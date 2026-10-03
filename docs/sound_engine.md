# Sound Engine (bank 0)

The music/SFX driver lives entirely in bank 0: code at `$3078`–`$3dd3`, then
its wave and envelope tables to `$3fc7`. It is a per-channel command
interpreter: every song and sound effect is a script of two-byte commands — opcode, operand — that is stepped once per engine tick to
drive the four Game Boy APU channels. The 315 channel scripts are extracted
as editable source (`data/bank_07x/<Track>.asm`, one `snd_*` macro row per
command; see "Script command set" and `tools/snd.py`).

## Channels and state blocks

Six logical channels share the four hardware channels. Each channel owns a
32-byte state block in WRAM bank $07:

- `wSndChannels` (`$d100`, 6 × `$20` bytes). First word = script pointer
  (`$ffff` ⇒ channel idle). **Channels 0–1 carry sound effects and 2–5 carry
  music** — `CheckMusicChannelsIdle`/`StopMusic` walk four blocks from
  `wSndChannels + 64` (`$d140`, i.e. channel 2), while the effect half of
  `PlaySound` clears blocks 0 and 1 before its table lookup.
- `wSndLoopSlots` (`$d1c0`) — per-channel loop bookkeeping resolved by
  `GetChannelLoopSlot`.

While a channel is being serviced its 32-byte block is copied into the HRAM
working set at **`$ffd0`** (`hSndScriptPtr` … `hSndRestFlag`) so the inner loop
can use fast `ldh`. `RunSoundEngine` (`$3373`) saves/restores the sprite-queue
bytes that overlap `$ffd0`; the block is written back after each channel.
The HRAM layout is the sound-driver variant of the shared `$ffd0` union in
`ram/hram.asm` (its names apply in `$3373`–`$3dd3`).

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
| `$ffd9` | `hSndNoteTimer` | portamento/glide countdown |
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
| `$d20a` | `wSndChannelType` | current channel type (copy of `hSndChannelType` low bits): `SNDCHANTYPE_SQUARE1`/`SQUARE2`/`WAVE`/`NOISE` = the hardware channel, since `wSndRegBase` is type × 5 |
| `$d20b` | `wSndChannelBits` | current channel's stereo bit-pair (`$11`/`$22`/`$44`/`$88`) |
| `$d20c` | `wSndChannelPanMask` | same pair, masked with `hSndPanMask` into `wSndPanShadow` |
| `$d20d` | `wSndRegBase` | APU register offset (type × 5); `WriteChannelReg` uses `$ff10`+this+reg |
| `$d20e` | `wSndFrameCounter` | free-running counter; low nibble is the vibrato phase |
| `$d20f` | `wSndChannelIndex` | index (0-5) of the channel being updated |
| `$d212`–`$d214` | `wSndUpdateReqMask`/`wSndUpdateReqData`/`wSndUpdateReqAck` | deferred channel-reconfigure request |
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
  envelope sequence (`SoundEnvelopeTable`, `$3ed6`, phased by `hSndEnvPos`/`hSndEnvLength`)
  and writes the shaped volume via `ApplyChannelEnvelope`.
- `TickVolumeSlide` (`$3968`) — periodic volume ramp driven by `hSndVolSlide`.

## Script command set

`RunSoundChannelScript` (`$3558`) keeps the channel's position as a **command
index** (`hSndScriptPtr`) and reads the command at `hSndDataPtr + index * 2`:
every command is two bytes, opcode then operand, and the index steps by one
per command. The one exception is `$ac`, four bytes, whose target word is the
byte offset of a command from the track's start (`srl` halves it into an
index). Loop points and the `$b0`-`$bf` loops work through four 3-byte
**slots** per channel (`GetChannelLoopSlot`: `wSndLoopSlots` + channel × 12 +
slot × 3; a counter and a saved index; the shipped scripts use slots 0-3), so
they carry no addresses. The macro on each row is what the extracted scripts
are written with (`include/macros.inc`):

| Opcode | Operand | Macro | Meaning |
|---|---|---|---|
| `$00`–`$9f` | length in ticks | `snd_note NOTE, octave, len` | note-on (`SndTriggerNote` `$3864`): low nibble = semitone into `NotePeriodTable` (`C_`..`B_`, the table's upper octave when `snd_tone_flag` bit 4 is set), high nibble = how many times the period is halved. Low nibble `$f` is `snd_hold octave, len`: no new pitch, the sounding note continues (or silence if none). On the noise channel the byte is `snd_noise value, len`: `< $10` indexes `NoiseNoteTable`, else the raw polynomial value |
| `$a0` | volume | `snd_volume` | set `hSndVolume`, apply the envelope |
| `$a1` | id | `snd_wave` | `hSndWaveId`: loads wave RAM on the wave channel, the sweep register on pulse 1 |
| `$a2` | value | `snd_duty` | duty into `hSndToneCtrl` (pulse) / envelope length (wave) |
| `$a3` | length | `snd_note_length` | `hSndNoteLenReload`/`hSndNoteLenTimer`; `$fe` clears |
| `$a4` | offset | `snd_detune` | `hSndNoteOffset` |
| `$a5` | mask | `snd_pan` | `hSndPanMask`; `$01` swaps the current mask's nibbles |
| `$a6` | value | `snd_master_volume` | written to `rAUDVOL` |
| `$a7` | ticks | `snd_glide` | the note timer (`hSndNoteTimer`) without a key-on |
| `$a8` | index | `snd_instrument` | `hSndInstrument` |
| `$a9` | value | `snd_transpose` | `hSndTranspose`/`wSndTranspose`; `$f0`-`$f3` step them, `$fe`/`$ff` read a jump table of indices that follows. Unused by the shipped scripts |
| `$aa` | value | `snd_echo` | echo count and note offset; 0 clears |
| `$ac` | count, target | `snd_call count, .label` | run the block at `.label` `count` times; each `snd_return` comes back to this command |
| `$ad` | — | `snd_return` | jump to the pending `snd_call` |
| `$ae` | flag | `snd_tone_flag` | `hSndToneCtrl` bit 4, the note table's octave |
| `$af` | nibble | `snd_length_nibble` | note-length increment |
| `$b0` | `$f0` \| slot | `snd_jump slot` | go back to the slot's loop point; without the `$f` marker the command is skipped |
| `$b1`–`$bf` | `$f0` \| slot | `snd_loop count, slot` | count = low nibble: go back until the block has run count + 1 times |
| `$c0`–`$cf` | length | `snd_envelope rate, len` | instrument-envelope sweep (`hSndEnvRate`/`hSndEnvLength`) |
| `$d0`–`$df` | period | `snd_volume_up step, period` | volume slide up |
| `$e0`–`$ef` | period | `snd_volume_down step, period` | volume slide down |
| `$fd` | `$f0` \| slot | `snd_loop_point slot` | remember the next command's index in the slot (the handlers mask the slot to the low nibble; every shipped operand carries the `$f` marker, so the macros write it) |
| `$ff` | — | `snd_end` | `SndReleaseChannel` (`$3b02`): end, clear this channel's output |

`$ab` and the unclaimed `$f0`–`$fc`/`$fe` opcodes are skipped with their
operand; the renderer writes them as raw `db` rows. Eight tracks end on a note
rather than a terminator and run on into the bytes that follow them; the
rendering says so on its last line.

**Editing a track.** `data/bank_07x/<Track>.asm` is generated at setup and
`INCLUDE`d by `src/audio/sound_<bank>.asm`; edit it and `make`.
Commands may be added or removed freely: `snd_call` targets are local labels
and everything else is slot-relative, so nothing has to be renumbered. A new
track is a new file plus a `SoundTable_<bank>` row (banks `$78`-`$7f`, at
`$4000`; `snd_channel` + `dw`) and, for a new id, a `sound_entry` in
`MusicIndexTable` or `SfxIndexTable` (generated into `data/bank_000/`). `make check` (`sound`)
proves the codec: every track decodes over exactly its extent and renders to
rows that encode back to the same bytes. `tools/snd.py decode <file.bin>`
renders any blob by hand.

## Key data tables

| Label | Addr | Contents |
|-------|------|----------|
| `NotePeriodTable` | `$3b1d` | 24 × 2-byte APU periods (two octaves) |
| `NoiseNoteTable` | `$3836` | 16 noise-channel `rAUD4POLY` values |
| `SoundChannelMaskTable` | `$3b4d` | 16×16 volume-scaling matrix used to shape envelopes |
| `SoundPitchTable` | `$3c4d` | vibrato pitch offsets |
| `WavePatternTable` | `$3dd4` | pointer to `WavePatterns` (`$3dd6`, 256 bytes of wave-channel patterns) |
| `SoundEnvelopeTable` | `$3ed6` | pointer to `SoundEnvelopes` (`$3ed8`, 240 bytes of instrument-envelope sequences) |

## Entry points

- `PlaySound` (`$3297`) / `PlaySoundManaged` (`$3024`) — start a sound/song by id.
- `StopMusic` (`$3129`) — stops the four *music* channels only; effects keep
  playing, and sound id `$50` (`SFX_STOP`) is what silences those. `SetMusicMuted` (`$2f86`).
- `RunSoundEngine` (`$3373`) — per-tick driver, reached through `UpdateSoundEngine`
  (`$2f1a`), which the VBlank handler calls and, when the LCD is off, the timer
  handler.

## Sound ids in the source

Every `sound` site names its id with a `BGM_*` / `SFX_*` constant from
`include/constants.inc`. The ids below `$80` that the sound test lists and
the match engine use were named by what they accompany on screen; the rest
(33 ids, 182 sites, 2026-09-11) are named from their call sites -- the
comment on each constant says where it plays -- because the emulator the
project drives gives no audio, so what a cue sounds like is not established.
A name has to hold at every site of its id, which is why the two cutscene
pop sounds are `SFX_APPEAR1`/`SFX_APPEAR2` and `$a2` is `SFX_STORY_CUE`:
its only sites are the `Unused_<bank>_MapScriptPlaySoundA2` handler each
story bank carries, and nothing reachable calls any of them. The ids that only tables carry were named on
2026-09-12 from the rows that select them: the drill and lesson themes of
the match-settings tables, the three story-location themes, the cues the
on-court object templates play as a banner or the score digits appear
(`SFX_BANNER_*`, `SFX_SCORE_DISPLAY`) and the two level jingles. The same
rule makes `$78` `SFX_MARKER` rather than a ranking-board name: the templates
also play it as the score digits land.
