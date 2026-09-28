#!/usr/bin/env bash
# Sweeps the tracked tree for things that look like secrets: bearer tokens,
# nostr private keys (nsec), generic API-key-shaped strings, and a committed
# .env. Fails on any hit.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$HERE"

FAIL=0

# Files git actually tracks or is about to track, minus this test itself
# (which necessarily mentions the patterns it looks for).
FILES="$(git ls-files 2>/dev/null || find . -type f -not -path './.git/*')"
FILES="$(echo "$FILES" | grep -v '^tests/no-secrets.sh$' || true)"

if echo "$FILES" | grep -E '(^|/)\.env(\..+)?$' | grep -qv '\.env\.example$'; then
  echo "no-secrets: FAIL, a .env file is tracked (only .env.example may be); it must never be committed"
  FAIL=1
fi

# Generic net: any credential-looking assignment with a real-looking value (placeholders excluded)
CRED='(token|secret|password|passwd|api[_-]?key|private[_-]?key)[A-Za-z0-9_]*[[:space:]]*[=:][[:space:]]*["'"'"']?[A-Za-z0-9_\-]{16,}'
HITS="$(echo "$FILES" | xargs -r grep -inE "$CRED" 2>/dev/null | grep -viE 'example|replace|your[_ -]|xxx|changeme|<[^>]+>|placeholder|\$\{|\$[A-Z_]+' || true)"
if [ -n "$HITS" ]; then
  echo "no-secrets: FAIL, credential-shaped assignment with a real-looking value:"; echo "$HITS"
  FAIL=1
fi

# nostr private keys
if echo "$FILES" | xargs -r grep -lE 'nsec1[0-9a-z]{20,}' 2>/dev/null; then
  echo "no-secrets: FAIL, nsec-shaped string found above"
  FAIL=1
fi

# Common bearer / API key shapes
PATTERNS='sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}'
if echo "$FILES" | xargs -r grep -lE "$PATTERNS" 2>/dev/null; then
  echo "no-secrets: FAIL, API-key-shaped string found above"
  FAIL=1
fi

# A live-looking token assignment (not an empty .env.example placeholder or
# a doc line that just names the variable).
if echo "$FILES" | xargs -r grep -nE '^(PLOW_AGENT_TOKEN|OPENCLAW_GATEWAY_TOKEN|PLOW_MCP_BRIDGE_TOKEN)=.+' 2>/dev/null \
   | grep -v '\.env\.example:'; then
  echo "no-secrets: FAIL, a token assignment with a value found outside .env.example"
  FAIL=1
fi

if [ "$FAIL" -eq 0 ]; then
  echo "no-secrets: PASS"
fi
exit "$FAIL"
