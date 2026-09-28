# Vendored from PacsArcade/pacbot

- Source checkout: `/home/pac/dev/pacsarcade/pacbot`
- Vendored ref: `HEAD` -> `1e5a89a8132868ee7aa7d1c47f6e33c597ccc1f7` (1e5a89a)
- Plan-named commit (openclaw-hackathon-plan.md:493): `7b4fab3` -> `7b4fab3a6687b194b8f2ed73fbfac9337b8dc3ba`
- License: MIT (PacsArcade/pacBOT, see /home/pac/dev/pacsarcade/pacbot/LICENSE)
- Files: SKILL.md, references/ (evals/ excluded, not part of the skill contract)

## Deviation from the plan's literal commit

The plan names `7b4fab3` for vendoring. This run vendored `1e5a89a8132868ee7aa7d1c47f6e33c597ccc1f7`
instead because `7b4fab3`'s `references/CANON.md` still states Pac's
Arcade's tax status as "501(c)(3)", which commit `e495cb3` (block 968,237,
on the Admiral's word "ship the 501 wording") corrected to "non-profit in
formation" — the foundation has not been formed and has not applied for
501(c)(3) status. `git diff 7b4fab3 1e5a89a8132868ee7aa7d1c47f6e33c597ccc1f7 -- SKILL.md README.md
ROADMAP.md` is empty (those three files are identical at both commits);
only `references/CANON.md` and `references/voicebox-plan.md` changed, and
the change is a factual correction, not new content. Run
`./scripts/vendor-pacbot.sh 7b4fab3` to reproduce the plan's literal
instruction and ship the outdated wording instead.
