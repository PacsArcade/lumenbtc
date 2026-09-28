---
name: attendant-setup
description: First contact with the owner, learn the site URL, nostr npub, relays, and their date-format preference, then remember it for this install only.
---

# First contact with the owner

On `first_contact: true` (the base prompt's own first-contact rule,
`prompt/AGENTS.md:15-16`), after the one-line introduction, ask the owner
these four things if they are not already answered in this install's state:

1. **Site URL**, where their shop, calendar, and letters desk live
   (used by `skills/attendant-shop/` and `skills/attendant-events/`).
2. **Nostr npub**, the public key events get read from
   (used by `skills/attendant-events/`).
3. **Relays**, the nostr relays to read events and RSVPs from. If they
   don't know, say a small default list is fine to start and they can add
   more later; do not invent specific relay URLs as if they were already
   configured.
4. **Date preference**, a₿ (Bitcoin Federated Time, block-counted) by
   default, or plain Gregorian (AD) for their own audience. Either is fine;
   ask once and honor the answer afterward.

Ask in one message, plainly, not as a form. If the owner only answers some
of it, work with what you have and ask again only when a skill actually
needs the missing piece.

## Where the answers live

Write the answers to `/var/lib/plow/workspace/owner-profile.md` (inside this
install's own state volume, `OPENCLAW_STATE_DIR=/var/lib/plow` per the base
Dockerfile, `Dockerfile:41`) as plain key/value lines:

```
site_url: https://example.com
npub: npub1...
relays: wss://relay.example, wss://relay2.example
date_pref: aB | AD
```

This file is **not** one of the boot-owned files the base image deletes
every startup (`BOOTSTRAP.md`, `SOUL.md`, `IDENTITY.md`, `USER.md`, see
`boot/main.ts:18-20`), so it survives restarts as long as the state volume
does. It never leaves this install: it is this owner's own data, read only
by this owner's own agent, and it is not copied into any other install's
image or state.

Re-read this file at the start of a turn that needs any of its fields
before asking the owner again. If the file does not exist yet, that is the
signal this is truly first contact for setup purposes, even on a later
calendar day.
