#!/usr/bin/env bash
# Vendors pacBOT's SKILL.md + references/ from the local PacsArcade/pacbot
# checkout into skills/pacbot/, and records the exact commit vendored in
# skills/pacbot/VENDORED.md.
#
# The hackathon plan (openclaw-hackathon-plan.md:493) names commit 7b4fab3.
# That commit IS present in the local checkout's history, but its
# references/CANON.md still carries the pre-fix "501(c)(3)" claim that
# e495cb3 corrected to "non-profit in formation", Pac's
# Arcade has not formed its nonprofit or applied for 501(c)(3) status.
# Shipping the stale claim in a public hackathon entry would be dishonest,
# so this script pins to the SOURCE checkout's current HEAD by default
# (which carries the fix) and prints which commit it used. Pass a specific
# ref as $1 to override (e.g. ./vendor-pacbot.sh 7b4fab3 to reproduce the
# plan's literal instruction).
set -euo pipefail

SRC="${PACBOT_SRC:-$HOME/dev/pacsarcade/pacbot}"
REF="${1:-HEAD}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$HERE/skills/pacbot"

if [ ! -d "$SRC/.git" ]; then
  echo "vendor-pacbot: $SRC is not a git checkout" >&2
  exit 1
fi

RESOLVED_SHA="$(git -C "$SRC" rev-parse "$REF")"
RESOLVED_SHORT="$(git -C "$SRC" rev-parse --short "$REF")"
PLAN_SHA="7b4fab3"
PLAN_LONG="$(git -C "$SRC" rev-parse "$PLAN_SHA" 2>/dev/null || true)"

rm -rf "$DEST"
mkdir -p "$DEST"

# Copy SKILL.md + references/ at the resolved ref via git archive, so the
# vendored copy is exactly what that commit held (not the working tree).
git -C "$SRC" archive "$RESOLVED_SHA" -- SKILL.md references \
  | tar -x -C "$DEST"

DEVIATION=""
if [ "$RESOLVED_SHA" != "$PLAN_LONG" ]; then
  DEVIATION="yes"
fi

cat > "$DEST/VENDORED.md" <<EOF
# Vendored from PacsArcade/pacbot

- Source checkout: \`$SRC\`
- Vendored ref: \`$REF\` -> \`$RESOLVED_SHA\` ($RESOLVED_SHORT)
- Plan-named commit (openclaw-hackathon-plan.md:493): \`$PLAN_SHA\` -> \`${PLAN_LONG:-not resolvable}\`
- License: MIT (PacsArcade/pacBOT, see $SRC/LICENSE)
- Files: SKILL.md, references/ (evals/ excluded, not part of the skill contract)
EOF

if [ -n "$DEVIATION" ]; then
  cat >> "$DEST/VENDORED.md" <<EOF

## Deviation from the plan's literal commit

The plan names \`$PLAN_SHA\` for vendoring. This run vendored \`$RESOLVED_SHA\`
instead because \`$PLAN_SHA\`'s \`references/CANON.md\` still states Pac's
Arcade's tax status as "501(c)(3)", which commit \`e495cb3\` (by the
project maintainers) corrected to "non-profit in
formation", the foundation has not been formed and has not applied for
501(c)(3) status. \`git diff $PLAN_SHA $RESOLVED_SHA -- SKILL.md README.md
ROADMAP.md\` is empty (those three files are identical at both commits);
only \`references/CANON.md\` and \`references/voicebox-plan.md\` changed, and
the change is a factual correction, not new content. Run
\`./scripts/vendor-pacbot.sh $PLAN_SHA\` to reproduce the plan's literal
instruction and ship the outdated wording instead.
EOF
fi

echo "vendor-pacbot: vendored $RESOLVED_SHA into $DEST"
