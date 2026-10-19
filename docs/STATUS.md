# Project status — 2026-10-19

Where the disassembly stands and what is still open. The subsystem docs under
`docs/` are the writeups; the git log has the history.

## Where things stand

The ROM rebuilds byte-perfect (`make compare` against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`; the European release with
`make EUROPE=1 compare`), `make check` passes every class,
and the repo holds no ROM bytes: `./setup.sh` extracts the data from the
user's `baserom.gbc` per `data.manifest`.

| | |
|---|---|
| source-spelled bytes (`tools/stats.py`) | 914,903, 43.6% of the 2 MiB ROM; 977,831 `INCBIN`, 200,809 free |
| instruction and code-macro lines | 124,724 |
| labels | 29,565: ROM 14,410 global + 13,418 local, RAM 1,737; none state only an address |
| extracted data regions | 4,267 (3,255 `INCBIN`, 1,012 generated `INCLUDE`s), 863 of them LZ streams |
| source of truth | `src/`, `ram/`, `include/`, edited directly; the generator is retired at tag `generator-final` |

Ids, records and layouts are checked at build time: id-indexed tables assert
their row count (`table_width` / `assert_table_length`), record layouts are
`rsreset` / `rb` declarations and RAM structure macros (`char_record`,
`match_stats`), enumerations are `const_def` / `const`, and code that relies
on RAM adjacency or on an id being 0 asserts it. Routines copied into
several banks are one file under `src/twins/` (90 families).

Everything once anonymous is classified, and the structure is rendered
rather than binary: farcall slots, `rst` pseudo-ops, story map trees, actor
bytecode, mode hooks, sprite templates, animation scripts, text and flag
ids, record tables. Content — tiles, tilemaps, palettes, strings, sound
scripts — is extracted into `data/` as editable PNGs, grids, text and rows,
with a fork's edits under `mods/`.

| doc | subject |
|---|---|
| `docs/match_engine.md` | match loops, physics, the shot solver, the CPU AI, doubles, link play |
| `docs/story_mode.md` | the story RPG: maps, scenes, entry points, flags, ladders, EXP |
| `docs/screens_and_ui.md` | menus, windows, the text engine, the sprite queue, fades |
| `docs/graphics_formats.md` | the LZ format, scene and court records, objects, palettes |
| `docs/actor_script.md` | the overworld actor bytecode |
| `docs/sound_engine.md` | the sound driver and its scripts |
| `docs/save_format.md` | the battery save and `tools/savetool.py` |
| `docs/ram_map.md` | WRAM/HRAM, union overlays, free RAM |
| `docs/bugs.md` | defects in the game, and the nine `make FIXES=1` fixes |
| `docs/unused_code.md` | the 788 routines and 112 blobs nothing live reaches |
| `docs/duplicated_code.md` | the live routines assembled into several banks |
| `docs/bank0_notes.md` | the ROM0 helpers |

## What is still open

* **Banked-WRAM operands:** 50 stay raw numbers, all inside `Unused_`
  routines no trace can reach.
* **Actor slots:** 13 operands on reached code stay numbers, each a slot that
  holds different actors in the lists possible there (`docs/story_mode.md`).
* **Entry and exit ids:** named per location (`ENTRY_*`, `EXIT_*`); two exit
  requests and one exit row's entry stay numbers, having no row to name.
* **Behaviour:** the event test finds no difference between a shifted build
  and the original. Its only crashes are the Test2 debug screens' glyph
  underrun and, set apart as `FORCED`, singles states sent to the awards
  ceremony's doubles-only entry.
* **Developer intent, not bytes:** `docs/graphics_formats.md` §8 (the unused
  `$63` palette sentinel, the two additive fades) and the "not established"
  sentences in `docs/match_engine.md`.

## How to resume

```
make clean && make -j compare && make check && make test
```

is the pipeline; `make -j FIXES=1` builds the fixed ROM. Runtime tools need
PyBoy (`make venv`): `make event-test` (and `tools/eventtest.py --targets
--handlers --free`), `tools/linktest.py`, `tools/steer.py`, `make slot-audit`,
`tools/ramaudit.py`. Static: `tools/reach.py` (what can run),
`tools/routes.py` (which entry points can be entered), `tools/twins.py`,
`tools/ram_free.py`, `tools/stats.py`. `make check` is what catches what a
byte-perfect build cannot.
