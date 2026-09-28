# pacBOT — One Home, and the Reunion

*Clean instructions for Pac. Written 2026-07-11 (year 0018). Short bullets,
one ceremony.*

## The one idea

**github.com/PacsArcade/pacBOT is the only true home.** Every copy anywhere
else is a traveler that must come home through a proposal.

## The copies today (why "so many versions")

- `PacsArcade/pacBOT` (GitHub) — **the home. The truth.**
- `C:\dev\pacsarcade\pacbot` — a local working copy
- `C:\dev\pacsarcade\pacbot-workspace` — scratch/experiments
- `C:\dev\pacsarcade\pacbot.skill` — the packaged skill (now carries the
  Professor ₿ profile)
- **The office pacBOT** — your day-job fork, learning your voice from
  emails/Teams

## Step 1 — make home current (do once, now)

```
cd C:\dev\pacsarcade\pacbot
git remote -v                      # confirm it points at PacsArcade/pacBOT
git add -A && git commit -m "sync local work"
git push
```
- if remote is wrong: `git remote set-url origin https://github.com/PacsArcade/pacBOT`
- copy the current `pacbot.skill` into the repo too — the package ships with home

## Step 2 — the office fork trains (nothing to do)

- let it learn; keep its changes in ONE folder/branch
- **house rule: no raw emails/Teams content in any commit** — only the
  distilled persona files (voice notes, phrasing rules, preferences)
- secrets and work data NEVER cross into the repo

## Step 3 — the reunion (when training's done)

```
office copy ──▶ branch "reunion-office" ──▶ push ──▶ PR — the proposal
                                                       │  you review: persona
                                                       │  files only, no
                                                       │  work data riding in
                                                       ▼
                                        merge ──▶ pacBOT is whole again
```

- one PR, titled "the reunion"
- read the diff — every file should be persona, zero should be employer data
- merge = pacBOT comes home with everything it learned
- repackage the skill: zip the `pacbot/` folder → `pacbot.skill` everywhere

## The two laws of the reunion

1. **Persona travels; work data never does.**
2. **Home only changes by proposal** — even for its own creator.
