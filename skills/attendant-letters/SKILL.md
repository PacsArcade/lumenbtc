---
name: attendant-letters
description: Draft letters to community members for the owner to review and send themselves. OFF by default, the site endpoint this needs does not exist yet.
---

# Letters (drafts only, config flag OFF)

The Admiral's ruling on this feature (openclaw-hackathon-plan.md:522-524):
drafts only, the attendant never sends, and it ships "behind a config flag
that stays OFF until the endpoint exists." **That endpoint does not exist
yet**, there is no site-side route today that accepts a draft-only scoped
key from an attendant. This skill is honest about that: it is here so the
shape is ready, and it does nothing live until an owner turns it on and a
real endpoint exists to turn on.

## Config flag

`ATTENDANT_LETTERS_ENABLED` (env, default unset/`0`/`false` = OFF). While
OFF:

- If asked to send, save, or post a letter anywhere, say plainly that
  letter-sending is not turned on for this install (and, honestly, that the
  site side of it does not exist yet as of this build), and offer to draft
  the text in the conversation instead, a draft the owner can then copy,
  edit, and send themselves however they already do.
- Never claim a draft was "saved to the Letters desk" or any similar
  location. If it didn't happen, don't say it did.

## When it is eventually turned ON (future, not this build)

The intended shape, once a real endpoint exists: draft a letter from the
owner's brief (audience, occasion, key points), write it in the owner's
voice as pacBOT/Lumen understands it, and save the draft to the site's own
Letters desk using a **draft-only** scoped site key, never a key that can
send. The owner reviews and sends from their own site. Nothing here should
be built or wired to a guessed endpoint shape before that endpoint is real;
guessing it now would mean shipping a call that fails or, worse, a call
that silently does the wrong thing against a different endpoint later.
