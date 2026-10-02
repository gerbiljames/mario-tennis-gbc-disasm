# Project status — 2026-10-02

This is where the disassembly stands and what is still open. The dated
working log that used to live here -- every session's findings in the order
they were found, 2026-07-09 to 2026-08-08, then the "Recent changes"
entries to 2026-09-30 -- is `docs/history.md`, kept verbatim. The subsystem
docs under `docs/` are the reader-facing writeups.

## Where things stand

The ROM rebuilds byte-perfect (`make compare` → `mariotennis.gbc: OK` against
SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0`) and `make check` passes every
structural class. The repo holds no ROM bytes: `./setup.sh` extracts every
data blob, string pool, palette and sound table from the user's `baserom.gbc`
per `data.manifest`.

| | |
|---|---|
| proven code + structured source | 428,509 bytes, 20.4% of the 2 MiB ROM |
| instructions disassembled | 160,940 |
| banks containing code | 59 of 128 |
| labels (counted 2026-09-12) | 21,979, of which 20,399 human-named and 1,580 derived (`FarPtr_*` slot labels, `SoundTable_*`); 0 state only an address |
| extracted data regions | 4,243 (3,685 `INCBIN`, 558 generated `INCLUDE`s) — 839 LZ streams, the rest raw graphics, tilemaps, sprite frames, text, palettes and sound |
| source of truth | `src/`, `ram/`, `include/`, edited directly; the generator and its 174 coverage dumps and 2 hook captures are retired at tag `generator-final` |
| bare banked-WRAM operands | 97, all `dead`: inside `Unused*` routines nothing references, so no trace can ever reach them. Zero in live code |

Everything that was ever anonymous has been classified. Every `INCBIN` is
known to be graphics, audio, text, a resource descriptor, a record array or
fill; a ROM-wide code-shape screen plus a twin-bank diff of the near-identical
shot banks found the last stranded routines, and the 247 seed offsets that
had no label were each traced to a verdict. The interesting structure is
rendered rather than binary: farcall slot tables, `rst` pseudo-ops, the
three idioms the code is built from (`push_wram_bank`/`pop_wram_bank`,
`ld_hl_indexed`, `wait_frames`), story map trees and actor bytecode, mode-hook tables, sprite templates and
animation scripts, flag-id lists, text ids, packed bank/slot selectors,
record tables with embedded pointers, and 3,949 local labels inside
functions. What stays out of the repository is content — tiles, tilemaps,
palettes, strings and the 315 sound-channel scripts — extracted into
`data/` at setup as PNGs, grids, text, palette rows and `snd_*` script
rows, all editable, with a fork's edits committed under `mods/`.

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
| `docs/ram_map.md` | the WRAM/HRAM symbol map, the union overlays, free RAM |
| `docs/bugs.md` | defects in the *game* — bugs, dead stores, stubbed routines |
| `docs/unused_code.md` | the 773 routines and 100 blobs nothing live reaches, the patterns they fall into, and how every reachable routine was made to run |
| `docs/bank0_notes.md` | the ROM0 helpers |

## What is still open

**Code.** Every routine is proven code or data, and every routine
`tools/reach.py` can reach from the vectors has run: in play and in targeted
sessions, and under `tools/steer.py` for the ones behind conditions no
session meets. The two it cannot run, `Unused_00_ApplyWhiteFade` and
`Unused_00_TickSecondaryTimer`, sit behind flags nothing in the ROM ever
sets. `reach.py` now proves that too: it finds calls decided by a variable
no store can make pass, and `make check` holds each such variable to a
reviewed verdict (`docs/unused_code.md`). Nothing the analysis can reach is
`Unused`, and nothing it cannot reach is anything else.

**Names.**
* Banked-WRAM operands: none left in live code. A `$dxxx` literal whose
  WRAM bank no static dataflow or trace has pinned renders as a raw number,
  because a name in the wrong bank is worse than none. The 97 that remain
  all sit in `Unused*` routines, left raw on purpose.
* Actor slots: 105 script operands and 17 `NpcScripts` ids are still
  numbers. Each is a slot with no single part across the lists that can
  be active there, a slot past the end of every list, a line in a shared
  twin file, or a table of a location the player never controls. Slots
  that mean one thing in every candidate list have role names
  (`include/actor_roles.inc`, `docs/story_mode.md`).
* Free RAM: 4,360 bytes, poison-checked at runtime over every flow the
  tools can drive, link play and the N64 screens included
  (`docs/ram_map.md`).

**Behaviour.** The event test compares a shifted build with the original
over every story state and location, the menu sessions and every target
without a difference. Its one known game crash, the Test2 debug screens'
glyph underrun, happens in both builds, and it counts crashes separately
from differences. `docs/bugs.md` lists the shipped defects found along the
way.

**Named in the docs as not established.**
* `docs/graphics_formats.md` §8 holds two items, both about the developers'
  intent rather than the bytes: why the `$63` per-object-palette sentinel
  exists when no object uses it, and why there are two additive fades.
* `docs/story_mode.md` "Oddities" keeps only shipped-defect entries.
* The "not established" sentences in `docs/match_engine.md`.

## How to resume

The source is edited directly: a name, a note, a union variant, a table
layout or an instruction is changed in `src/`, `ram/` or `include/`, and

```
make clean && make -j compare && make check && make test
```

is the whole pipeline (`compare` holds until the first deliberate change to
the bytes; `check` and `test` hold after it). `make shift-test` builds a
copy with every bank padded, and `make event-test` (needs PyBoy) plays that
copy and the original through every story state and compares what the game
does. `tools/strings.py --index
--bank <bank>` reads a text id; `tools/gfxdump.py` draws contact sheets of
the graphics streams and palette regions into gitignored `data/gfx/`;
`tools/twins.py` lists the routines a fix has to land in more than once;
`tools/ram_free.py` recomputes the free-RAM inventory after the RAM
declarations change.

The runtime tools (PyBoy, `make venv`):
* `make event-test` plays two builds; run `tools/eventtest.py` directly
  for `--targets`, `--handlers` and `--free` (sessions beyond the story
  states) and `--coverage`/`--units` (the routines entered, for
  `tools/coverage.py` and `tools/steer.py`).
* `tools/linktest.py` plays two games over an emulated link cable.
* `tools/steer.py` runs routines no session reaches.
* `tools/actorslots.py --runtime` (`make slot-audit`) checks the actor-slot
  names in play.
* `tools/ramaudit.py` poisons the free RAM, or finds a byte's first writer.

`tools/reach.py` is the static half: which routines the vectors can reach
at all.

The generator that produced the tree — `tools/disasm.py`, its `disasmlib`
package, the JSON inputs (`labels.json`, `data_tables.json`, `ram_map.json`,
`ram_unions.json`, `constants.json`, `flags.json`), the `coverage/` traces
and `hooks/` captures, and the tests that exercised them — was retired on
2026-09-11, when a final run reproduced the committed source exactly. It is
kept whole at the git tag `generator-final` (`git show generator-final:tools/disasm.py`)
for anyone who wants to see how a name or a union scope was established;
nothing in the tree depends on it any more.

`make check` is what catches the mistakes a byte-perfect build cannot: an LZ
stream that no longer decodes, an assembled symbol inside one, overlapping
extracted regions, a routine stranded in an actor script's label scope, a
new branch that decides nothing, a ROM address written as a number, an
unaligned DMA source, a PNG, grid, sound track or trajectory table that no longer encodes to its blob, an
actor-slot name that does not hold where it is used, or a routine whose
`Unused` name disagrees with reachability.

## Recent changes

The full entries from 2026-08-07 to 2026-09-30, newest first, are at the
end of `docs/history.md`. In short:

* **2026-10-03 — sizes and positions.** Copy and clear lengths follow what
  they copy: a RAM object's exported size (`export_size`), a decompressed
  stream's `_SIZE`, or a named slice (`SCREEN_HEIGHT * TILEMAP_WIDTH`,
  `WRAMX_SIZE`, `2 * CHAR_RECORD_SIZE`). Map positions in `map_entry`,
  `map_actor`, the `script_*` moves and `as_set_*` are tiles with a point
  (`18.0`, `17.5`), 3,054 lines. Lone sprite attributes in `b` name their
  `OAM_*` flags. Found on the way: `FetchSRAMText` copies past both text
  buffers (harmless, `docs/bugs.md`).
* **2026-10-02 — pair macros.** Every register pair a callee reads as two
  bytes says which is which: `ld_xy` (sprite x, y), `ld_cell` (column, row),
  `ld_size`, `ld_oam` (attribute with `OAM_*` flags, tile), `ld_tile_run`
  and `ld_bg_pals`/`ld_obj_pals`, about 640 sites in all. Checking each
  helper's register order found three pairs of swapped X/Y names
  (`hSpriteBlit*`, `StarWarpPath*`, `OffsetStatSpriteY`). The 69 VRAM
  addresses outside the copy consumers are named too.
* **2026-10-02 — docs pass.** Every subsystem doc, the README and this
  page re-checked against the tree: names, addresses and counts current,
  generator-era wording gone. Two corrections came out of it: the game's
  fades go through white, not black (`docs/bugs.md`), and the dialogue
  window's width and height names were swapped. The three
  `GameProgressScreenTiles` regions are graphics, not palettes.
* **2026-10-01 — unreachable by data.** `tools/reach.py` finds calls and
  jumps decided by a variable that no visible store can make pass. Each is
  reviewed in `DATA_FLAGS`, and `make check` fails on any it has not seen.
  The four dead ones drop their edges, so `ApplyWhiteFade` and
  `TickSecondaryTimer` are now `Unused_00_*` (773 in all).
* **2026-09-30 — coverage finished.** Every routine `tools/reach.py` says
  the vectors can reach has now run, except two that wait on flags nothing
  sets (`Unused_00_ApplyWhiteFade`, `Unused_00_TickSecondaryTimer`). Several routes were added:
  * link play over an emulated cable (`tools/linktest.py`, which can also
    pull the cable or play from a locked save);
  * story handlers called on demand, including the tables scripts install;
  * the N64 record screens, with forged records;
  * the minigames and drills from the menu;
  * `tools/steer.py` for the rest. It replays a session and forces only the
    branches on the way down to a routine; that proves the routine can run,
    kept apart from what play reaches.

  Two undocumented unlock-everything button codes turned up on the way
  (`docs/save_format.md`). `docs/unused_code.md` has the account.
* **2026-09-30 — the event test is clean.**
  * A PyBoy bug had hung runs whenever a breakpoint landed on the cycle a
    frame ended; `eventtest` now steps past it.
  * Match-return entries now start from a lost match, instead of a stale
    win that sent Wall Practice's result script through a jump table past
    its end.
  * Game crashes are counted apart from hangs. The only one left is the
    Test2 debug screens'.

  A full sweep compares the shifted build clean.
* **2026-09-30 — bugs.** The glyph underrun in `docs/bugs.md` is worse than
  recorded. The line-break code seeds the pen from the row's tile column
  with a signed shift, so rows past column `$80` draw below the buffer, and
  on the Test2 debug screens the writes reach the stack.
* **2026-09-29/30 — names.**
  * Actor slots come from following control flow, then from stage and tile
    modelling at the Senior Court and the Island Open, then role names
    (`include/actor_roles.inc`). 4,781 row names and 48 role names; 105
    operands stay numbers, each with no single part.
  * The 21 raw text ids left are named.
  * 404 more routines nothing live reaches are named `Unused` (771 in
    all), among them the dead copies inside shared twin templates and the
    in-match stats editor behind a hotkey check that returns at once.
  * `make check` gains `slots` and `reach`.
* **2026-09-30 — RAM.** The free-RAM poison check covers every flow the
  tools can drive. No free byte is a live variable. `tools/ramaudit.py`
  reruns it and finds a byte's first writer.
* **2026-09-29 — edited builds.** A first real mod, on a throwaway branch,
  found the tools' dependence on original addresses; all fixed on main
  (see "How to resume" above).
* **2026-09-27/28 — the runtime tools.** `tools/runtime_audit.py`, the
  padded ROM playing through every story state (`make event-test`), and
  actor slots named by row.
