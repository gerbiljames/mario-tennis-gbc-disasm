# Project status — 2026-09-10

This is where the disassembly stands and what is still open. The dated
working log that used to live here — every session's findings in the order
they were found, 2026-07-09 to 2026-08-08 — is `docs/history.md`, kept
verbatim; the subsystem docs under `docs/` are the reader-facing writeups.

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
| bare banked-WRAM operands | 188 — 94 `unproven` (live code no trace has reached), 91 `dead` (inside `Unused*` routines, unreachable by any trace), 3 in the bank `$03` cutscene text-window blit whose buffer does not fit its union |

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

**The 94 live unproven banked-WRAM operands.** A `$dxxx` literal whose WRAM
bank neither static dataflow nor any trace has pinned renders as a raw
number, because a name in the wrong bank is worse than none. 91 more sit in
`Unused*` routines and are counted as `dead`: nothing references them, so
no trace can ever prove them. Of the live 94, the biggest groups are the
story cutscene scripts in banks `$12`-`$14` (Senior Court rank intros, the
Tennis Machine level-cleared scenes, the Wall Practice room — one site
each, ~20 in all, each behind its own progression flag), the character-data
screen's view-only re-entry (12, `SetupCharDataScreen`), the link screens
(bank `$38` grid, bank `$3e` link error), the Training Court challenger
walk-ons (6), the three ranking rows 9-11 and doubles markers 5/6 no
board argument seems to reach, and the DMG lockout screen (5, needs the
ROM run in DMG mode). The developer "Test" map (debug warp location 3)
is the cheapest lever for the story flows: its nine NPCs launch every
story match, the lesson menu with its ranking-board samples, the
epilogue and the ending credits directly.

**Named in the docs as not established.** `docs/graphics_formats.md` §8
(collision-map cell geometry, three odd-sized palette regions, object-header
bytes +2/+3, the `$63` sentinel, whether the bank `$00` fade is visually
white, the 136-byte scene-config layout); `docs/story_mode.md` "Oddities
and open questions" (story-completion unlocks, record fields `+$2b`/`+$2f`/
`+$3d`-`+$3f`); the "not established" sentences in `docs/match_engine.md`.

**Small rendering leads.** `SeanSpriteAnim04` and the 42 five-byte
walk-sprite scripts render as `db` for reasons `docs/graphics_formats.md`
§4.4 gives. Two `map_actors` tables carry one padding byte past their
terminator.

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

* **2026-09-10** — an emulator session: eleven coverage dumps under the v4
  connector (erase-confirm prompt, the N64 Tennis Data screens with a forged
  save block, the developer Test map's lesson menu, epilogue, ending credits
  and an Island Open singles match to its EXP screens). `ram_gaps` gained a
  `dead` bucket and sixteen unreferenced routines their `Unused_` names;
  seven new union variants name what the screens touch. Bare banked
  operands 230 → 188, of which 94 are live.
* **2026-09-10** — the text-id walker follows `push hl` / `pop hl` pairs, so
  `RenderProportionalTextAt` (which parks the id while it sets the glyph
  pointer) and the five caption helpers built on it count as consumers: 102
  more `ld hl, Text_*` sites, 503 → 605, every caption in the briefing,
  menu, link and clear-status screens named. A survey of the other forward
  walkers found one more gap — the load-site walk had no push/pop tracking,
  a five-instruction limit and only recognised `call` hand-offs — worth one
  site (606). `_scan_ptr_use` and the WRAM-bank dataflow already track the
  stack; the nine derived consumers that call something while the id sits
  in `hl` all call routines that park it (`push hl` first thing).
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
