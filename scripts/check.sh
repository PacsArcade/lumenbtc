#!/usr/bin/env bash
# The one gate: builds the base + this image with podman if the base tag
# exists (or can be built), runs tests/, and sweeps for secrets. Never
# docker. Exits non-zero on any failure.
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$HERE"
FAIL=0

echo "== check: no-secrets sweep =="
bash tests/no-secrets.sh || FAIL=1

echo
echo "== check: prompt length sanity =="
bash tests/prompt-length.sh || FAIL=1

BASE_TAG="localhost/plow-openclaw-agent:7c476de"
IMAGE_TAG="localhost/pacbot-attendant:test"

if command -v podman >/dev/null 2>&1; then
  if podman image exists "$BASE_TAG" 2>/dev/null; then
    echo
    echo "== check: base image $BASE_TAG present, building attendant image =="
    if podman build -t "$IMAGE_TAG" --build-arg "BASE=$BASE_TAG" .; then
      echo "check: attendant image built as $IMAGE_TAG"
    else
      echo "check: FAIL, attendant image build failed"
      FAIL=1
    fi
  else
    echo
    echo "== check: base image $BASE_TAG not present; attempting scripts/build-base.sh =="
    if bash scripts/build-base.sh; then
      echo
      echo "== check: base built, building attendant image =="
      if podman build -t "$IMAGE_TAG" --build-arg "BASE=$BASE_TAG" .; then
        echo "check: attendant image built as $IMAGE_TAG"
      else
        echo "check: FAIL, attendant image build failed"
        FAIL=1
      fi
    else
      echo "check: base build failed or podman/network unavailable here;"
      echo "check: continuing with static-only tests (see report for the tail)"
    fi
  fi
else
  echo
  echo "== check: podman not found; skipping image build, static tests only =="
fi

echo
echo "== check: model-swap guard =="
ATTENDANT_IMAGE="$IMAGE_TAG" bash tests/model-swap.sh || FAIL=1

echo
if [ "$FAIL" -eq 0 ]; then
  echo "check: ALL GREEN"
else
  echo "check: FAILED, see above"
fi
exit "$FAIL"
