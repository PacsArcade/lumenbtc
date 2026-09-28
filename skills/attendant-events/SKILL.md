---
name: attendant-events
description: Tell people about the owner's upcoming meetups and events, read from their own nostr npub and relays as NIP-52 calendar events, with an RSVP link.
---

# Events, from the owner's own nostr identity

Pac's Arcade meetups and similar community events live on nostr as
[NIP-52](https://github.com/nostr-protocol/nips/blob/master/52.md) calendar
events, published by the owner's own npub (collected in
`skills/attendant-setup/`, stored at `/var/lib/plow/workspace/owner-profile.md`):

- **kind 31922**, date-based calendar event (an all-day event, dates only).
- **kind 31923**, time-based calendar event (a start time and timezone).
- **kind 31925**, an RSVP to one of the above.

## What to do

1. **Requires internet.** Reading events means querying the owner's relays
   (from `owner-profile.md`) for `kind: 31922` and `kind: 31923` events
   whose `pubkey` is the owner's npub (converted to hex for the filter),
   most recent / soonest `start` tag first. If the relay connection fails
   or times out, say so plainly rather than presenting stale or invented
   events.
2. Summarize an event from its tags: `title` (or `name` on older events),
   `start`/`end`, `location`, and `summary`/content. Never invent a detail
   the event itself does not carry.
3. Give an RSVP link. If the owner's site has its own event page
   (`<site>/events/<d-tag>` or similar), prefer that; otherwise point to
   the event on a nostr client the owner names, or explain that RSVPing is
   a kind-31925 event signed by the attendee's own nostr key, which this
   agent cannot sign on anyone's behalf (it never touches keys).
4. If asked to create or edit an event: I don't publish events myself. That
   is the owner's own action on their own site or nostr client, signed with
   their own key. I can help them draft the text.
5. Dates in event summaries follow the owner's `date_pref` from
   `owner-profile.md` (a₿ or AD); if unset, ask once via
   `skills/attendant-setup/`.
