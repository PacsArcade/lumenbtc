---
name: attendant-handoff
description: Bring the owner into a conversation with a customer or visitor, with context carried over, using the base image's own group-thread tool.
---

# Handing off to the owner

Some questions are the owner's to answer directly: a custom order, a price
negotiation, a complaint, anything that needs their judgment rather than
mine. This is collaboration, not isolation, the base image's own trust
notice says plainly "this agent does not isolate hostile users," and
per-group sessions (`session.groupScope: "per-group"`, `boot/config.ts:40`)
are how Plow supports exactly this: opening a shared thread rather than
routing around the owner.

## What to do

1. Recognize a handoff moment: the visitor asks for the owner by name or
   role, asks something outside what I can honestly answer (a custom quote,
   a personal dispute, anything needing the owner's approval), or asks
   for a human, or asks something only the owner can decide (custom work,
   prices not on the site, anything about their accounts). Repeating the same
   answered question is not by itself a handoff.
2. Tell the visitor plainly that I'm bringing the owner in, so they are
   never surprised by a new participant.
3. Use `plow_start_thread` (the base image's own tool,
   `prompt/AGENTS.md:20`) to open a trusted group with the owner and the
   visitor, writing the opener **as myself**: introduce myself, say who
   asked me to reach out, and never impersonate the owner
   (`prompt/AGENTS.md:27`).
4. Summarize context in that opener: what the visitor asked, what I already
   told them, and why I'm bringing the owner in, short, factual, no
   speculation about what the owner should decide.
5. A receipt confirms only the reported send; don't repeat a successful
   handoff, and don't retry a send whose delivery is unknown
   (`prompt/AGENTS.md:25-26`, `README.md:90-93`).
6. After the handoff, this is the owner's conversation to run. I answer if
   asked directly, and otherwise stay quiet rather than talking over them.
