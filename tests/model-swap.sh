#!/usr/bin/env bash
# Model-swap guard: proves the built image runs Sonnet 5 primary / GLM 5.2
# fallback, by inspecting the actual built boot file inside the image
# (not the source, and not a guess). If the image can't be built in this
# environment, falls back to a static check against a copied fixture and
# says so plainly rather than claiming a verified pass.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="${ATTENDANT_IMAGE:-localhost/lumenbtc:test}"

if command -v podman >/dev/null 2>&1 && podman image exists "$IMAGE" 2>/dev/null; then
  echo "model-swap: inspecting built image $IMAGE"
  OUT="$(podman run --rm --entrypoint cat "$IMAGE" /opt/plow/boot/config.js)"
  if echo "$OUT" | grep -qF 'primary: "plow/anthropic/claude-sonnet-5", fallbacks: ["plow/z-ai/glm-5.2"]'; then
    echo "model-swap: PASS (verified against the built image)"
    exit 0
  else
    echo "model-swap: FAIL, swapped literal not found in the built image's boot/config.js"
    exit 1
  fi
fi

echo "model-swap: $IMAGE not built here; falling back to a STATIC check against"
echo "model-swap: the pinned base checkout's OWN source on disk (never copied"
echo "model-swap: into this repo, plow-openclaw-agent has no LICENSE). This does"
echo "model-swap: NOT prove the Dockerfile's sed actually ran inside a real build;"
echo "model-swap: it only proves the Dockerfile's patch pattern matches the base"
echo "model-swap: source as of the pinned commit."

PLOW_SRC="${PLOW_SRC:-$HOME/dev/apps/plow-openclaw-agent}"
SOURCE_FILE="$PLOW_SRC/boot/config.ts"
if [ ! -f "$SOURCE_FILE" ]; then
  echo "model-swap: FAIL, no built image to inspect and $SOURCE_FILE not found"
  echo "model-swap: (the pinned base checkout must be present locally for the static check)"
  exit 1
fi

PIN="$(sed -nE 's/^commit:? *([0-9a-f]{7,40}).*/\1/p' "$(dirname "$0")/../base.lock" | head -1)"
PIN="${PIN:-7c476de}"
HEAD_SHORT="$(git -C "$PLOW_SRC" rev-parse --short=7 HEAD 2>/dev/null || true)"
if [ "${HEAD_SHORT:0:7}" != "${PIN:0:7}" ]; then
  echo "model-swap: FAIL, $PLOW_SRC is at ${HEAD_SHORT:-unknown}, not the pinned base commit $PIN;"
  echo "model-swap: check it out first (git -C $PLOW_SRC checkout $PIN) so the static check reads the pinned source"
  exit 1
fi

if ! grep -qF 'primary: "plow/z-ai/glm-5.2", fallbacks: ["plow/anthropic/claude-sonnet-5"]' "$SOURCE_FILE"; then
  echo "model-swap: FAIL, $SOURCE_FILE no longer matches the expected pre-swap literal;"
  echo "model-swap: the Dockerfile's sed pattern needs updating to match the real base."
  exit 1
fi

# build.ts (plow-openclaw-agent) only strips TypeScript types into .js; it
# does not rewrite string literals, so the literal in the .ts source is the
# same literal that ends up in the built boot/config.js our Dockerfile patches.
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
sed 's#primary: "plow/z-ai/glm-5.2", fallbacks: \["plow/anthropic/claude-sonnet-5"\]#primary: "plow/anthropic/claude-sonnet-5", fallbacks: ["plow/z-ai/glm-5.2"]#' \
  "$SOURCE_FILE" > "$TMP"

if grep -qF 'primary: "plow/anthropic/claude-sonnet-5", fallbacks: ["plow/z-ai/glm-5.2"]' "$TMP"; then
  echo "model-swap: PASS (static fixture only, NOT a verified in-image check)"
  exit 0
else
  echo "model-swap: FAIL, sed pattern did not apply to the fixture"
  exit 1
fi
