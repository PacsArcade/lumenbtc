#!/usr/bin/env bash
# Builds the pinned plow-openclaw-agent base image locally with podman.
# See base.lock for the pin and the reasoning.
set -euo pipefail

PIN="7c476de"
SRC="${PLOW_SRC:-$HOME/dev/apps/plow-openclaw-agent}"
TAG="${BASE_TAG:-localhost/plow-openclaw-agent:$PIN}"

if [ ! -d "$SRC/.git" ]; then
  echo "build-base: $SRC is not a git checkout" >&2
  exit 1
fi

if ! command -v podman >/dev/null 2>&1; then
  echo "build-base: podman not found on PATH (never docker on this ship)" >&2
  exit 1
fi

CURRENT="$(git -C "$SRC" rev-parse --short HEAD)"
if [ "$CURRENT" != "$PIN" ]; then
  echo "build-base: $SRC is at $CURRENT, checking out pinned $PIN"
  git -C "$SRC" checkout "$PIN"
fi

echo "build-base: podman build -t $TAG $SRC"
podman build -t "$TAG" "$SRC"
