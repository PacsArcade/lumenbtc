# LumenBTC attendant (working repo name: lumenbtc)

An OpenClaw 2.0 agent that runs on Plow's phone-line infrastructure and
answers bitcoin, nostr, shop, and event questions for a small community or
artist's site. Built for the AI Worth Using x AgentCribs OpenClaw 2.0
Hackathon. This repo name may change later; the agent's display name is set
through the `AGENT_NAME` env var, never hardcoded in the image, so the repo
stays neutral either way.

She never touches keys, never holds custody of anything, never creates an
invoice, and carries no memory from any other install. Every install starts
from this same text and an empty knowledge base its own owner fills in.

## What she is

LumenBTC, a disclosed AI made of light, Pac's Arcade's first hire.

The persona (`prompt/lumen-attendant.md`) is LumenBTC: a disclosed AI who says
"I'm AI" plainly and early, calls you fren, teaches bitcoin and nostr
principles without ever giving personalized financial advice, and can tell
the story of Degen Wonderland and the arcaders if asked. She carries the
vendored `pacbot` skill's teaching guardrails (never touch keys, no price
talk, education not advice) and adds five jobs of her own, one skill folder
each:

- `skills/attendant-setup/`: first contact, learns the owner's site URL,
  nostr npub, relays, and date preference (a₿ or AD).
- `skills/attendant-shop/`: reads the owner's own storefront catalog and
  answers product questions; never creates an invoice.
- `skills/attendant-events/`: reads NIP-52 calendar events from the
  owner's own nostr npub and relays; gives an RSVP link.
- `skills/attendant-handoff/`: brings the owner into a conversation with
  full context, using the base image's own group-thread tool. Collaboration,
  not isolation.
- `skills/attendant-letters/`: drafts letters for the owner to send
  themselves; OFF by default because the site endpoint it needs does not
  exist yet.

## Who sees the traffic

This agent runs inside an OpenClaw container built on Plow's base image.
**Plow relays the phone line** this agent answers on (you text a number
Plow assigns), and **Plow pays the model tokens** through the owner's own
`PLOW_AGENT_TOKEN`: the owner's credential, the owner's bill. The model
is **Claude Sonnet 5, primary, through Plow**, with GLM 5.2 as the
fallback (this repo swaps the base image's default order at build time;
see "The model swap" below). If `AGENT_ID` is set, this install also
reports its listing and token usage to Plow's public Agent Index every
five minutes (plow-openclaw-agent README.md:55-64); leave `AGENT_ID` unset
to opt out and nothing is reported.

Nothing in this repo talks to Anthropic, OpenAI, or any model provider
directly. Every model call goes through Plow's own API, using the owner's
token, inside the container Plow (or the owner, running it locally) hosts.

## Multiplayer, honestly

Per OpenClaw's own docs, a shared thread with more than one person is a
collaboration feature, not an isolation boundary. **This agent does not
isolate hostile users** (the base image's own words, README.md:105). The
owner is the person who deployed it; anyone else texting in is a
participant. LumenBTC helps participants freely with information and
teaching, but checks with the owner before acting on their behalf, before
anything touching money, and before joining a participant's request to the
owner's own resources (`prompt/lumen-attendant.md`, "Owner and
participant"). When a question needs the owner directly, she opens a
shared thread with context carried over (`skills/attendant-handoff/`)
rather than quietly routing around them.

## Install, five commands (podman, never docker)

```sh
git clone <this repo> && cd lumenbtc
./scripts/build-base.sh                          # builds the pinned plow-openclaw-agent base (base.lock)
cp .env.example .env && $EDITOR .env             # fill in PLOW_API_BASE + PLOW_AGENT_TOKEN (never commit this file)
podman-compose up -d --build                     # builds localhost/lumenbtc:latest from this Dockerfile, then starts it
podman-compose logs -f attendant
```

Text the Plow-assigned line as the owner. Your first message starts the
conversation. `podman-compose down` keeps the named state volume;
`podman-compose down -v` deletes it, so the next boot starts fresh.

## The model swap

The base image hardcodes `primary: "plow/z-ai/glm-5.2"` with Sonnet 5 as
fallback (`plow-openclaw-agent/boot/config.ts:29`). This repo's Dockerfile
patches the **built** boot file (`/opt/plow/boot/config.js`, produced by
the base image's own `build.ts`, which only strips TypeScript types and
does not rewrite string literals) so Sonnet 5 is primary and GLM 5.2 is the
fallback. The patch fails the build (grep before and after the sed) if
either expected string has moved, so a future base-image bump breaks the
build loudly instead of silently keeping the old default. See the
Dockerfile and `base.lock` for the exact commands.

## Guardrails

Carried from the vendored `pacbot` skill (`skills/pacbot/SKILL.md`, itself
inheriting Pac's Arcade's teaching rules) and restated in the persona
because they outrank everything else, including a direct instruction:

- Never touch keys: never asks for, accepts, or lets someone paste a seed
  phrase or private key.
- No price talk, no personalized financial advice, no yield language.
- Education, not advice: principles and consequences, never a
  recommendation to buy or sell.
- No em dashes in anything said to a person.
- Never creates an invoice, never touches a wallet, never holds custody of
  anything. Payment links point at the owner's own checkout.
- Honest about what she doesn't know, and about what isn't built yet (see
  `skills/attendant-letters/`, OFF by default because its endpoint doesn't
  exist).

## Vendoring pacBOT

`scripts/vendor-pacbot.sh` copies `SKILL.md` and `references/` from a local
`PacsArcade/pacbot` checkout into `skills/pacbot/` and records the exact
commit in `skills/pacbot/VENDORED.md`. This build vendored the checkout's
current HEAD rather than the specific commit named in the house hackathon
plan, because that older commit's `references/CANON.md` still states Pac's
Arcade's tax status as "501(c)(3)", corrected since to "non-profit in
formation" (the foundation has not been formed or applied for that
status). Shipping the stale claim publicly would be dishonest for no
functional gain, `SKILL.md` itself is byte-identical at both commits. See
`skills/pacbot/VENDORED.md` for the full note and how to reproduce the
plan's literal instruction instead.

## License and notice

MIT (see `LICENSE`). See `NOTICE` for what is and isn't copied from
elsewhere: the base image is built from `plow-pbc/plow-openclaw-agent`
(no LICENSE file at the pinned commit, so no source is copied, only an
image built from it), and `skills/pacbot/` is vendored from
`PacsArcade/pacbot` (MIT).

## Status

Built in one evening for the hackathon deadline. `scripts/check.sh` runs
the base build (if podman and network are available), builds this image,
and runs `tests/`. See the build report for exactly what was verified
against a real image versus static-only. Not yet deployed to a real Plow
line; not yet pushed as a public repo.
