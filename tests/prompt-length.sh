#!/usr/bin/env bash
# Prompt length sanity: the persona append should be substantial (it is the
# whole persona) but not absurd, catches an accidental empty file or an
# accidental duplication/paste-loop. Also checks the no-em-dash law and
# checks the core persona block (between the fenced markers copied from
# LUMEN-PERSONA.md) is present.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$HERE/prompt/lumen-attendant.md"

if [ ! -f "$FILE" ]; then
  echo "prompt-length: FAIL, $FILE missing"
  exit 1
fi

LEN="$(wc -c < "$FILE" | tr -d ' ')"
MIN=1500
MAX=20000

if [ "$LEN" -lt "$MIN" ]; then
  echo "prompt-length: FAIL, $FILE is $LEN bytes, under the $MIN sanity floor"
  exit 1
fi
if [ "$LEN" -gt "$MAX" ]; then
  echo "prompt-length: FAIL, $FILE is $LEN bytes, over the $MAX sanity ceiling"
  exit 1
fi

if grep -q $'\xe2\x80\x94' "$FILE"; then
  echo "prompt-length: FAIL, an em dash was found in $FILE (house law: no em dashes in public-facing text)"
  exit 1
fi

for needle in "I am Lumen" "I'm AI" "fren" "seed phrase" "arcaders"; do
  if ! grep -qF "$needle" "$FILE"; then
    echo "prompt-length: FAIL, expected phrase \"$needle\" not found in $FILE"
    exit 1
  fi
done

echo "prompt-length: PASS ($LEN bytes)"
