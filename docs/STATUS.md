# Project status — 2026-09-10

This is where the disassembly stands and what is still open. The dated
working log that used to live here — every session's findings in the order
they were found, 2026-07-09 to 2026-08-08 — is `docs/history.md`, kept
verbatim; the subsystem docs under `docs/` are the reader-facing writeups.
The state below describes HEAD `1d371d6`.

## Where things stand

The ROM rebuilds byte-perfect (`make compare` → `mariotennis.gbc: OK` against
SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0`) and `make check` passes every
structural class. The repo holds no ROM bytes: `./setup.sh` extracts every
data blob, string pool, palette and sound table from the user's `baserom.gbc`
per `data.manifest`.

| | |
|---|---|
| proven code + structured source | 428,461 bytes, 20.4% of the 2 MiB ROM |
| instructions disassembled | 160,919 |
| banks containing code | 59 of 128 |
| labels | 21,974, of which 20,394 human-named and 1,580 generator-derived (`FarPtr_*` slot labels, `SoundTable_*`); 0 state only an address |
| data blobs (`INCBIN`) | 4,218 — 838 LZ streams, the rest raw graphics, tilemaps, sprite frames and sound |
| coverage inputs | 174 `coverage/*.json` dumps and 2 `hooks/*.json` captures |
| bare banked-WRAM operands | 230, all in the `unproven` bucket of `tools/ram_gaps.py` |

Everything that was ever anonymous has been classified. Every `INCBIN` is
known to be graphics, audio, text, a resource descriptor, a record array or
fill; a ROM-wide code-shape screen plus a twin-bank diff of the near-identical
shot banks found the last stranded routines, and the 247 seed offsets that
had no label were each traced to a verdict. The interesting structure is
rendered rather than binary: farcall slot tables, `rst` pseudo-ops, story
map trees and actor bytecode, mode-hook tables, sprite templates and
animation scripts, flag-id lists, text ids, packed bank/slot selectors,
record tables with embedded pointers, and 3,949 local labels inside
functions. What stays binary is content: tiles, tilemaps, palettes, strings
and the 315 sound-channel scripts (identified and named, deliberately not
decoded — see `docs/history.md` for the line).

### What each document covers

| doc | subject |
|---|---|
| `docs/match_engine.md` | bank `$08`'s match/set/point loops, physics, the shot solver, the CPU AI, doubles, link play |
| `docs/story_mode.md` | the story RPG: maps, scenes, flags, ranking ladders, the EXP screens, the developer clear-status tool |
| `docs/screens_and_ui.md` | the menu shell, window system, text engine, sprite queue, fades |
| `docs/graphics_formats.md` | the LZ format, scene/court records, object headers and animation scripts, palettes; §8 is its open list |
| `docs/actor_script.md` | the overworld actor bytecode VM and its opcodes |
| `docs/sound_engine.md` | the driver, sound-id indexing, channel scripts |
| `docs/save_format.md` | the battery save layout and `tools/savetool.py` |
| `docs/ram_map.md` | the WRAM/HRAM symbol map, generated from `ram_map.json` |
| `docs/bugs.md` | defects in the *game* — bugs, dead stores, stubbed routines |
| `docs/bank0_notes.md` | the ROM0 helpers |

## What is still open

**The 230 unproven banked-WRAM operands.** A `$dxxx` literal whose WRAM bank
neither static dataflow nor any trace has pinned renders as a raw number,
because a name in the wrong bank is worse than none. Ordinary driving has
saturated — a traced exhibition match adds no instructions and one or two
operands — but a *native BizHawk Trace Logger capture of a real story
flow* still reaches code the menus never touch: the last such capture (a
doubles semi-final) resolved four and settled two dead-code questions.
The flows not yet captured: a singles ranking match through the ranking
board, the other Island Open rounds, a minigame to its score screen, and
link play. `tools/tracelog2cov.py` converts a multi-segment log in one
command. It is fair to stop here and call the residue unreachable-by-trace.

**Named in the docs as not established.** `docs/graphics_formats.md` §8
(collision-map cell geometry, three odd-sized palette regions, object-header
bytes +2/+3, the `$63` sentinel, whether the bank `$00` fade is visually
white, the 136-byte scene-config layout); `docs/story_mode.md` "Oddities
and open questions" (story-completion unlocks, record fields `+$2b`/`+$2f`/
`+$3d`-`+$3f`); the "not established" sentences in `docs/match_engine.md`.

**Small rendering leads.** 38 of the 62 `RenderProportionalTextAt` call
sites load their caption id as a raw `ld hl, $10xx` rather than a `Text_*`
constant, because the text-id pass names ids by consumer and that consumer is
not on its list. `SeanSpriteAnim04` and the 42 five-byte walk-sprite scripts
render as `db` for reasons `docs/graphics_formats.md` §4.4 gives. Two
`map_actors` tables carry one padding byte past their terminator.

**Not started, and only worth it for other people.** A generated PNG pipeline
for the graphics blobs, unit tests for `tools/disasmlib`, and a ROM-free CI
job. None of it changes the disassembly.

## How to resume

Regenerate the source from the curated inputs — always with the hook
captures, or the data banks regress:

```
python3 tools/disasm.py baserom.gbc coverage/*.json --hooks hooks/*.json
python3 tools/extract.py baserom.gbc data.manifest data/
make clean && make -j compare && make check
```

Measure with `python3 tools/progress.py` (per-bank proven bytes and the
`named` / `derived` / `auto` label buckets; `--unnamed <bank>` lists what is
left) and `python3 tools/ram_gaps.py` (the bare banked-operand buckets).
`tools/strings.py baserom.gbc --index --bank <bank>` reads a text id;
`tools/gfxdump.py` draws contact sheets of the graphics streams and palette
regions into gitignored `data/gfx/`.

The curated inputs, all JSON, all regenerated into `src/` and `ram/`:

| file | what it holds |
|---|---|
| `labels.json` | ROM symbol names by flat offset; a dot-prefixed value is a local label inside the enclosing function |
| `data_tables.json` | render spec per data region (`records:N`, `flag_ids`, `sprite_anim`, `map_actors`, …) |
| `ram_map.json` | global WRAM/HRAM names |
| `ram_unions.json` | banked and overlaid RAM: variants scoped by ROM bank, WRAM bank and instruction range; a symbol's size comes from its note's leading `[N bytes]` tag |
| `constants.json` | named immediates by instruction offset (values in `include/constants.inc`) |
| `flags.json` | game-flag and save-flag names |
| `coverage/*_static_code.json` | hand-authored code seeds; a wrong one asserts garbage as code forever |
| `hooks/*.json` | `CopyDataFromBank` / `DecompressDataFromBank` captures that classify the `$4000` slot tables |

`make check` is what catches the mistakes a byte-perfect build cannot: an LZ
stream that no longer decodes, a symbol inside one, a text table pointing at
nothing, a constant keyed to the wrong offset, overlapping regions, a local
label bound to the wrong parent.

## Recent changes

* **2026-09-10** — the desk pass over everything the docs had flagged as
  wrong: object-header word 1 renamed `AnimPtrs` and its 635 scripts rendered
  as `anim_*` macros; bank `$03`'s fade buffers renamed the right way round
  (`wPaletteFadeTarget` / `wPaletteFadeLive`, 16-byte mask, frame delay);
  the clear-status tool's flag writers renamed for what they clear and its
  menu state given its own union; the two "Maybe" routines renamed
  (`ApplyLinkRoleToWinLoseFlag`, `AiRollAimAwayFromChar`); three stray
  `ret`s carved in bank `$11`; `WRAMX_BASE` / `STACK_TOP` for the page
  clears; `gfxdump` palette sheet fixed; `docs/STATUS.md` split into this
  page and `docs/history.md`.
* **2026-08-08** — a native trace of the Island Open doubles semi-final: the
  ranking board reached, `BuildMatchResultTilemap` proven dead, 234 → 230
  unproven operands.
* **2026-08-07/08** — every raw address operand followed to its consumer;
  packed selectors rendered; `records:N:ptrK`; the last unbanked WRAM named.
* Earlier — see `docs/history.md`.
