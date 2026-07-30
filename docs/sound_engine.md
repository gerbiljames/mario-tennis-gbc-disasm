# Sound Engine (bank 0)

The music/SFX driver lives entirely in bank 0, `$3078`–`$3ddf`. It is a
per-channel command interpreter: every song and sound effect is a script of
1-byte opcodes (plus operands) that is stepped once per engine tick to drive the
four Game Boy APU channels.

## Channels and state blocks

Six logical channels share the four hardware channels. Each channel owns a
32-byte state block in WRAM bank $07:

- `wSndChannels` (`$d100`, 6 × `$20` bytes). First word = script pointer
  (`$ffff` ⇒ channel idle). **Channels 0–1 carry sound effects and 2–5 carry
  music** — `CheckMusicChannelsIdle`/`StopMusic` walk four blocks from
  `wSndChannels + 64` (`$d140`, i.e. channel 2), while the effect half of
  `PlaySound` clears blocks 0 and 1 before its table lookup. (This document said
  the opposite until 2026-07-30, following two index-table labels that were
  themselves swapped; see docs/STATUS.md.)
- `wSndLoopSlots` (`$d1c0`) — per-channel loop bookkeeping resolved by
  `GetChannelLoopSlot`.

While a channel is being serviced its 32-byte block is copied into the HRAM
working set at **`$ffd0`** (`hSndScriptPtr` … `hSndRestFlag`) so the inner loop
can use fast `ldh`. `RunSoundEngine` (`$3373`) saves/restores the sprite-queue
bytes that overlap `$ffd0`; the block is written back after each channel.
The HRAM layout is the sound-driver variant of the shared `$ffd0` union in
`ram_unions.json` (scoped to `$3373`–`$3de0`).

### HRAM channel working set (`$ffd0`–`$ffef`)

| Addr | Symbol | Meaning |
|------|--------|---------|
| `$ffd0` | `hSndScriptPtr` | 16-bit script cursor (bit-addressed via `add hl,hl`) |
| `$ffd2` | `hSndChannelType` | low 2 bits = channel type (0 sq1/sweep, 1 sq2, 2 wave, 3 noise); high nibble = vibrato/length index |
| `$ffd3` | `hSndDataPtr` | 16-bit base pointer to the channel's note/command data |
| `$ffd5` | `hSndDataBank` | ROM bank of that data |
| `$ffd6` | `hSndToneCtrl` | duty (bits 6-7), flag (bit 4), note-length increment (low nibble) |
| `$ffd7` | `hSndLengthAccum` | fractional note-length accumulator |
| `$ffd8` | `hSndVolume` | volume/envelope (high nibble = level, steps by `$10`) |
| `$ffd9` | `hSndPortamentoTimer` | portamento/glide countdown |
| `$ffda` | `hSndWaveId` | wave-pattern id (wave ch) / note byte (others) |
| `$ffdb` | `hSndNoteOffset` | signed detune applied at note-on (bit 7 = active) |
| `$ffdc` | `hSndTranspose` | per-channel transpose |
| `$ffdd` | `hSndEnvRate` | instrument-envelope sweep speed |
| `$ffde` | `hSndEnvLength` | instrument-envelope length/target (note length on wave ch) |
| `$ffdf` | `hSndEnvPos` | current instrument-envelope position |
| `$ffe0` | `hSndVolSlide` | volume-slide state (bit 7 direction) |
| `$ffe1` | `hSndVolSlideReload` | volume-slide period reload |
| `$ffe2` | `hSndVolSlideTimer` | volume-slide countdown |
| `$ffe3` | `hSndPeriodLo` | base period low, vibrato centre |
| `$ffe4` | `hSndPeriodHi` | NRx4 shadow; bit 5 (`$20`) = software note-on marker |
| `$ffe5` | `hSndEcho` | echo depth (low nibble) + saved volume (high nibble) |
| `$ffe6` | `hSndPanMask` | this channel's rAUDTERM L/R bits |
| `$ffe7` | `hSndNoteLenReload` | note-length reload |
| `$ffe8` | `hSndNoteLenTimer` | note-length countdown (gates effects) |
| `$ffe9` | `hSndInstrument` | high nibble = wave/envelope-table select, low nibble = envelope sequence |
| `$ffea` | `hSndEchoTimer` | echo repeat counter |
| `$ffeb` | `hSndEchoCtrl` | echo enable/count (high nibble) + note offset (low nibble) |
| `$ffec` | `hSndLoopCount` | script loop counter |
| `$ffed` | `hSndLoopReturnPtr` | 16-bit saved script pointer for the active loop |
| `$ffef` | `hSndRestFlag` | non-zero ⇒ current step is a rest/tie (suppresses envelope) |

### Per-pass globals (`$d208`–`$d219`)

| Addr | Symbol | Meaning |
|------|--------|---------|
| `$d208` | `wSndActiveMask` | channels serviced/keyed this pass |
| `$d209` | `wSndPanShadow` | rAUDTERM shadow (L/R enables) |
| `$d20a` | `wSndChannelType` | current channel type (copy of `hSndChannelType` low bits) |
| `$d20b` | `wSndChannelBits` | current channel's stereo bit-pair (`$11`/`$22`/`$44`/`$88`) |
| `$d20c` | `wSndChannelPanMask` | same pair, masked with `hSndPanMask` into `wSndPanShadow` |
| `$d20d` | `wSndRegBase` | APU register offset (type × 5); `WriteChannelReg` uses `$ff10`+this+reg |
| `$d20e` | `wSndFrameCounter` | free-running counter; low nibble is the vibrato phase |
| `$d20f` | `wSndChannelIndex` | index (0-5) of the channel being updated |
| `$d212`–`$d214` | `wSndUpdateReqMask`/`Data`/`Ack` | deferred channel-reconfigure request |
| `$d215` | `wSndFirstChannel` | channel the pass starts from |
| `$d217` | `wSndLoadedWaveId` | wave pattern currently in wave RAM (change detection) |
| `$d218` | `wSndTranspose` | global transpose |
| `$d219` | `wSndWaveReloadPending` | force wave reload on next note |

## Per-tick update

`UpdateSoundChannels` (`$3392`) walks the six blocks. For each active channel it
mirrors state to HRAM, selects the hardware channel (`wSndChannelType` etc.),
then runs the per-tick effect chain before decrementing the note timer and, when
it expires, stepping the script via `RunSoundChannelScript`:

- `TickVibrato` (`$39a7`) — pitch LFO; offsets `hSndPeriodLo` by `SoundPitchTable`.
- `TickInstrumentEnvelope` (`$3a40`) — advances the `hSndInstrument`-selected
  envelope sequence (pointer table at `$3ed6`, phased by `hSndEnvPos`/`hSndEnvLength`)
  and writes the shaped volume via `ApplyChannelEnvelope`.
- `TickVolumeSlide` (`$3968`) — periodic volume ramp driven by `hSndVolSlide`.

## Script command set

`RunSoundChannelScript` (`$3558`) reads one opcode byte and dispatches by range:

| Range | Handler | Meaning |
|-------|---------|---------|
| `$00`–`$9f` | `SndTriggerNote` (`$3864`) | note-on: compute period, key the channel |
| `$a0` | | set volume, apply envelope |
| `$a1` | | set `hSndWaveId` (loads wave RAM on the wave channel) |
| `$a2` | | set duty (`hSndToneCtrl`) / wave note length |
| `$a3` | | note length → `hSndNoteLenReload`/`hSndNoteLenTimer` |
| `$a4` | | `hSndNoteOffset` (detune) |
| `$a5` | | `hSndPanMask` (stereo output) |
| `$a6` | | write `rAUDVOL` (master volume) |
| `$a7` | | `hSndPortamentoTimer` (glide) |
| `$a8` | | `hSndInstrument` |
| `$a9` | | transpose control (`hSndTranspose`/`wSndTranspose`) |
| `$aa` | | echo setup (`hSndEcho`/`hSndEchoCtrl`/`hSndEchoTimer`) |
| `$ac` | | loop with count (`hSndLoopCount` + `hSndLoopReturnPtr`) |
| `$ad` | | loop return |
| `$ae` | | `hSndToneCtrl` bit 4 flag |
| `$af` | | note-length nibble → `hSndToneCtrl`/`hSndLengthAccum` |
| `$b0`–`$bf` | | loop / repeat (count in low nibble, uses `GetChannelLoopSlot`) |
| `$c0`–`$cf` | | instrument-envelope sweep (`hSndEnvRate`/`hSndEnvLength`) |
| `$d0`–`$df` | | volume slide up |
| `$e0`–`$ef` | | volume slide down |
| `$fd` | | set loop point |
| `$ff` | `SndReleaseChannel` (`$3b02`) | end script, clear this channel's output |

(`$ab`, unclaimed `$f0`–`$fc`/`$fe` opcodes fall through and skip one byte.)

## Key data tables

| Label | Addr | Contents |
|-------|------|----------|
| `NotePeriodTable` | `$3b1d` | 24 × 2-byte APU periods (two octaves) |
| `NoiseNoteTable` | `$3836` | 16 noise-channel `rAUD4POLY` values |
| `SoundChannelMaskTable` | `$3b4d` | 16×16 volume-scaling matrix used to shape envelopes |
| `SoundPitchTable` | `$3c4d` | vibrato pitch offsets |
| `WavePatternTable` | `$3dd4` | wave-channel patterns **and** the instrument-envelope pointer table at `$3ed6` |

## Entry points

- `PlaySound` (`$3297`) / `PlaySoundManaged` (`$3024`) — start a sound/song by id.
- `StopMusic` (`$3129`) — stops the four *music* channels only; effects keep
  playing, and sound id `$50` is what silences those. `SetMusicMuted` (`$2f86`).
- `RunSoundEngine` (`$3373`) — per-tick driver (called from `UpdateSoundEngine`
  `$2f1a` and the timer handler when the LCD is off).
