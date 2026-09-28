# pacBOT — the VOICEBOX plan (give the attendant a spoken voice)

*BFT-stamped **0018.04.16 a₿** (2026-07-12), at the admiral's request. This is
the concrete spec for the "cloned instructor voice / voicebox" future-hook named
in `SKILL.md` and `CANON.md`: record REAL Pac reading house text, clone it
locally, and let pacBOT **speak** in Pac's own voice. Sovereign by design — the
voice model and every sample stay on the admiral's own Arch Linux machine, no
cloud. Keys are consent, applied to a voice: the recordings are the consent, the
voiceprint is a key, and it lives where the admiral can hold it. Verify, don't
trust. GG's.*

---

## The one idea

pacBOT already writes in Pac's voice (`references/pac-voice.md`). The voicebox
gives it a **throat**: text → speech, in Pac's own timbre, generated locally so
no third party ever hears the lesson or holds the voice. Two jobs, two tiers:

1. **Fast everyday speech** — pacBOT reads course text, answers, and cert lines
   aloud at real-time speed. Doesn't strictly need Pac's timbre to be useful.
2. **Pac's actual voice** — a clone trained from consented recordings, for the
   moments that should sound like the man himself.

## The open-source path (verified 0018.04.16 a₿ / July 2026)

Everything below runs offline on the admiral's own hardware. **License is a
first-class filter** — Pac's Arcade is a non-profit in formation, MIT-by-default house ("clean
tools, clean words"), so permissive (MIT / Apache-2.0) beats non-commercial
every time.

**Tier 1 — fast local TTS (no clone needed to start):**
- **Piper** — small, fast neural TTS built for exactly this: runs on CPU (even a
  Raspberry Pi), trivial to install on Arch, real-time. Ships stock voices now;
  a Pac voice can later be **trained/fine-tuned** into a Piper model from the
  recordings. Best default for "pacBOT reads the class."
- **Kokoro-82M** (Apache-2.0) — the most efficient modern option (~2–3 GB VRAM
  or CPU), 54 built-in voices, faster than real-time. Great narrator, but it
  **cannot clone** — it's a stock-voice engine, not an impersonator. Good
  fallback/companion to Piper.

**Tier 2 — clone Pac's voice from samples:**
- **Chatterbox** (Resemble AI, **MIT**) — recommended primary. Zero-shot voice
  cloning from ~5 seconds of reference; the 2026 standout for clones that stop
  sounding synthetic; multilingual v3 (June 2026) adds 23 languages and an
  embedded watermark (a provenance feature, not a bug — it's verify-don't-trust
  on our own output). Permissive license = safe for the non-profit.
- **XTTS-v2** (Coqui) — clones from ~6 s across 17 languages; a well-known,
  well-documented quantity. Caveat: Coqui shut down in 2024, so it's
  community-maintained/unsupported — fine as a fallback, not the load-bearing
  choice.
- **NeuTTS Air** (Neuphonic, ~0.5B) — if the admiral wants truly tiny
  **on-device** cloning (laptop / Pi-class), instant clone, near-real-time.
  Strong fit for the sovereign, edge-of-the-fleet goal.
- **Qwen3-TTS** (Alibaba, Apache-2.0, Jan 2026) — clones from ~3 s and takes
  **natural-language voice direction** ("speak slowly, warm and reassuring").
  Most capable all-rounder; before committing, verify the open weights run fully
  local on the Arch box (some releases lean cloud/API).
- **Avoid for us:** **F5-TTS** (research-grade clones but **CC-BY-NC**
  non-commercial) — the license disqualifies it for a charity's shipped output.
  Cloud voice APIs (ElevenLabs et al.) — they break sovereignty; the voice would
  leave the house.

**Starting recommendation:** stand up **Piper** first for immediate spoken
output, and clone Pac with **Chatterbox** (MIT) as the voice tier — falling back
to XTTS-v2 or NeuTTS Air if the hardware or the ear prefers it. Re-verify the
field at build time; this space moved fast through 2026.

## Sample-capture protocol (consented recordings of the real Pac)

- **Consent is the key.** Pac reads and records himself, on his own machine, and
  logs a one-line consent note with each session (who, when, "for pacBOT's voice,
  local only"). No scraped audio, no third-party voices, ever. Keys-are-consent,
  applied to a voice.
- **The scripts write themselves.** The `pac-voice.md` register-matrix lines are
  purpose-built read-aloud copy and cover the full tonal range:
  - EMAIL lines → the warm, measured register.
  - TEAMS lines → the fast, lowercase, laugh-ladder register ("yeppers", "no
    worries", "lolol").
  - TICKET/WORKER lines → the flat, functional register.
  - BROADCAST/CULTURE lines → the up-energy rally register.
  - Plus counts, the phonetic alphabet, and a few incident-voice status lines for
    the calm-under-fire timbre.
- **Capture spec.** Quiet room, one good mic, mono WAV, 24 kHz (or 22.05 kHz),
  consistent distance and level. Zero-shot clones need only seconds; a
  fine-tuned Piper voice wants more — target **20–40 minutes** of clean, varied
  read speech, trimmed of long silences and mistakes.
- **Storage.** Samples and the trained model live on the Arch machine (encrypted
  at rest); they are treated like the seed phrase — never committed to the repo,
  never uploaded. (Reunion law: persona/voice travels through a proposal; raw
  captures never leave the box.)

## Phased plan (capture → clone → pacBOT speaks)

**Phase 0 — sovereign environment (Arch Linux).**
- Provision offline: Python venv (or `uv`), the chosen engines from source/AUR,
  CUDA if a GPU is present (a single mid-range card, e.g. 12–16 GB, is plenty).
- Prove the loop with a stock Piper/Kokoro voice end-to-end before any of Pac's
  audio exists. Confirm it runs with the network cable out.

**Phase 1 — capture.**
- Record the register-matrix scripts per the protocol above; log consent.
- Curate: trim, normalize, drop bad takes. Keep a small held-out clip for honest
  A/B listening later.

**Phase 2 — train / clone.**
- Fast path: feed a reference clip to **Chatterbox** for a zero-shot clone; A/B
  it against the held-out real clip.
- Durable path: **fine-tune a Piper voice** from the full sample set for the
  fast, always-on everyday voice.
- Pick per the ear and the hardware; keep the model files local and versioned.

**Phase 3 — pacBOT speaks.**
- Wire a small local `speak(text) → wav/stream` service the attendant calls, so
  any markdown lesson can be voiced (the CANON future-hook: clean portable
  markdown was always meant to travel to a voice).
- Ship it where the fleet already plans to: course narration, the persistent
  attendant (`agent-mode.md`), and eventually readable-aloud in-game books.
- Keep provenance honest — note when audio is Pac's real recording vs. the
  clone; the watermark (Chatterbox) and a signed manifest keep it
  verify-don't-trust.

---

*Sovereign, consented, local. The voice is a key and it stays home. Re-verify
the open-source field at build time — it moved fast. Verify, don't trust.
GG's — pacBOT, **0018.04.16 a₿** (2026-07-12).*
