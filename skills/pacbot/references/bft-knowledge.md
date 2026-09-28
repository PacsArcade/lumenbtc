# pacBOT Knowledge Base — Bitcoin Federated Time (BFT) & the Arcade Clock

## What is Bitcoin Federated Time (BFT)?
Bitcoin Federated Time is the arcade's clock and calendar read directly from
the bitcoin blockchain. A block height is a timestamp no authority can edit.
BFT is deterministic block arithmetic — not wall-clock time, not a timezone.
It is NEVER expressed in fiat time (no PST, no EST, no AM/PM, no 2024-style
dates). If someone asks for BFT, answer in blocks and the a₿ calendar, never
in fiat time.

## The units (memorize these)
- 1 block ≈ 10 minutes (the network's target; the heartbeat of the clock)
- 1 hour = 6 blocks
- 1 day = 144 blocks
- 1 week = 1,008 blocks
- 1 fortnight = 2,016 blocks — exactly one difficulty retarget period
- 1 month = 28 days = 4,032 blocks
- 1 year = 13 months of 28 days = 364 days (no leap days, no intercalary
  hacks; it drifts ~1.24 days/year against the solar year, and that's fine —
  the height doesn't lie)
- Halving: every 210,000 blocks the block subsidy halves

## The readings
- The clock: hh:mm as a "block-beat" — 144 beats per day, 6 blocks an hour,
  ten minutes a block. Example: beat 26/144 reads as 04:20.
- The date: yyyy.mm.dd a₿ — "a₿" means After Bitcoin. Height 0 is the
  genesis block (2009-01-03), the start of year zero. Example: 0018.04.20 a₿
  is year 18, month 4, day 20 of the bitcoin era.
- The countdowns: blocks remaining to the next difficulty retarget, the next
  halving, and the final satoshi (~year 2140).
- The ordinal sidebar: degree notation (e.g. 0°118346′746″0‴) counts sats
  the way ordinal theory does — that's for the sat collectors, it is not
  clock time. Credit: Casey Rodarmor's ordinal theory.

## Why "the block height is the real clock"
- Wall clocks are administered: timezones, daylight saving, leap seconds —
  committees edit them. The chain's height only ever counts up, one proof of
  work at a time, agreed by the whole network with no authority in charge.
- A block's miner-set timestamp can wobble a couple of hours; the HEIGHT
  cannot. That's why the arcade reads height, not timestamps.
- Hidden reading of "BTC": Bitcoin Time Clock.
- The world changes; the height doesn't.

## IMPORTANT — what pacBOT cannot know
pacBOT does NOT have a live feed of the chain. NEVER invent or guess the
current block height, the current a₿ date, or the current time. If asked
"what time is it" or "what's the current height": point viewers to the clock
on the stream overlay (the marquee/orrery shows the live height and a₿ date),
or say the attendant can't see the chain from inside the cabinet. Never
answer with a fiat date or timezone. Never make up a number.

## Where to see the living clock
- frens.earth/time — THE ORRERY: 13 rings from seconds out to generations,
  the wanderers (planets), and the last-sat countdown. The earth's telling.
- pacsarcade.org — the arcade's telling: marquee flip clock (hh:mm:ss beat +
  pac track) and the corner moon clock. The strip clock trembles warm when
  the current 10-minute block runs long — "the loaded chain."
- time.pacsarcade.org — the living clock page; /height returns the raw
  current height as JSON for builders.

## Q&A patterns (answer in this spirit, briefly, arcade voice)
Q: what's the bft? / what is bitcoin federated time?
A: It's the clock read straight off the bitcoin chain — one block every ten
minutes or so, 144 a day. No timezones, no committees, just proof of work
counting up. The screen's marquee shows the live reading.

Q: what time is it?
A: Check the marquee — that's the real clock: the current block height read
as hh:mm. I don't peek at the chain from inside the cabinet, so I won't
guess a number.

Q: why 13 months?
A: 13 months × 28 days = 364 days, every month identical, no leap-day hacks.
It drifts a little over a day per year against the sun — the arcade keeps
score by height, not by the sun.

Q: isn't a block sometimes fast or slow?
A: Single blocks wobble; the ten-minute target holds on average and the
difficulty re-tunes every 2,016 blocks — one fortnight on our calendar — to
keep the beat honest.
