# Content-only image. Nothing here is Plow's code: this Dockerfile builds
# FROM an image already built from plow-openclaw-agent at a pinned commit
# (see base.lock), and only COPYs our own prompt append and skill folders
# into the paths that base image's own boot process reads.
#
# plow-openclaw-agent has no LICENSE (checked: `find ... -iname "licen*"`
# on the HEAD 7c476de checkout returns nothing; every sibling Plow repo is
# Apache-2.0). A fork of it cannot be relicensed MIT, so this repo copies
# no Plow source, it only builds against a locally-built base image tag.
ARG BASE=localhost/plow-openclaw-agent:7c476de
FROM ${BASE}
# ghcr links the package to this repo through the source label; the base image's own label pointed at openclaw.
LABEL org.opencontainers.image.source="https://github.com/PacsArcade/lumenbtc" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.description="LumenBTC, a disclosed AI made of light: your bitcoin startup's first hire on OpenClaw 2.0"

# The base image's final stage runs as `node` (plow-openclaw-agent/Dockerfile
# line 44: `USER node`); /opt/plow/* was written as root during the base
# build (no --chown on its own COPYs), so root is needed here to append the
# prompt, add skills, and patch the built boot file.
USER root

# Persona append. The base image reads /opt/plow/prompt/AGENTS.md at every
# boot (plow-openclaw-agent boot/main.ts:21-22) and writes it, rendered,
# into the workspace, so appending here is the documented extension point,
# not a patch of base behavior.
COPY prompt/lumen-attendant.md /tmp/lumen-attendant.md
RUN printf '\n' >> /opt/plow/prompt/AGENTS.md \
 && cat /tmp/lumen-attendant.md >> /opt/plow/prompt/AGENTS.md \
 && rm /tmp/lumen-attendant.md

# Skills. The base image's rendered config sets
# skills.load.extraDirs = ["/opt/plow/skills"] (boot/config.ts:45), so
# anything placed there is loaded by OpenClaw at boot. Whether the base's own
# bundled skills also load is governed by the base's allowBundled setting on
# the same line, which this image does not touch.
COPY skills/ /opt/plow/skills/

# Model swap: Sonnet 5 primary, GLM 5.2 fallback.
#
# The source (plow-openclaw-agent boot/config.ts:29) hardcodes
#   model: { primary: "plow/z-ai/glm-5.2", fallbacks: ["plow/anthropic/claude-sonnet-5"] }
# but the base image's own build step (build.ts:4-9) only strips TypeScript
# types into boot/config.js, it does not rewrite string literals, so the
# same two strings are what actually ships and run at
# /opt/plow/boot/config.js inside the already-built base image. That is the
# file this patches, not the .ts source (patching the source would do
# nothing; build.ts already ran when the base image was built).
#
# Fail-closed: grep for both expected strings before touching the file, and
# grep for both expected results after, so a base-image bump that changes
# this shape breaks the build instead of silently keeping the old default.
RUN set -eu; \
    f=/opt/plow/boot/config.js; \
    grep -qF '"plow/z-ai/glm-5.2"' "$f" || { echo "model-swap: expected primary-model string not found in $f (base image shape changed)"; exit 1; }; \
    grep -qF '"plow/anthropic/claude-sonnet-5"' "$f" || { echo "model-swap: expected fallback-model string not found in $f (base image shape changed)"; exit 1; }; \
    grep -qF 'primary: "plow/z-ai/glm-5.2", fallbacks: ["plow/anthropic/claude-sonnet-5"]' "$f" \
      || { echo "model-swap: expected primary/fallbacks literal not found verbatim in $f (base image shape changed)"; exit 1; }; \
    sed -i 's#primary: "plow/z-ai/glm-5.2", fallbacks: \["plow/anthropic/claude-sonnet-5"\]#primary: "plow/anthropic/claude-sonnet-5", fallbacks: ["plow/z-ai/glm-5.2"]#' "$f"; \
    grep -qF 'primary: "plow/anthropic/claude-sonnet-5", fallbacks: ["plow/z-ai/glm-5.2"]' "$f" \
      || { echo "model-swap: swap did not apply to $f"; exit 1; }

USER node
