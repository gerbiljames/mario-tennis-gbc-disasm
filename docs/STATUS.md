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
| labels | 21,979, of which 20,399 human-named and 1,580 generator-derived (`FarPtr_*` slot labels, `SoundTable_*`); 0 state only an address |
| data blobs (`INCBIN`) | 4,218 — 838 LZ streams, the rest raw graphics, tilemaps, sprite frames and sound |
| coverage inputs | 174 `coverage/*.json` dumps and 2 `hooks/*.json` captures |
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
| `docs/unused_code.md` | the 199 unreferenced routines and 100 blobs, and the eight patterns they fall into |
| `docs/bank0_notes.md` | the ROM0 helpers |

## What is still open

**Banked-WRAM operands: none left in live code.** A `$dxxx` literal whose
WRAM bank neither static dataflow nor any trace has pinned renders as a raw
number, because a name in the wrong bank is worse than none. The 97 that
remain all sit in `Unused*` routines (`tools/ram_gaps.py` counts them as
`dead`): nothing references them, so no trace can ever prove them, and they
are left raw on purpose. The last live ones went three ways — a callee that
selects the bank itself (the story scripts' actor-slot pointers handed to
`AttachActorStepMover`, the digit drawers' `wram_bank $03`), which the
unions express as instruction-range scopes; siblings behind a jump table
whose traced twins prove the bank (ranking rows 9-11, doubles markers 5/6,
which no `ShowRankingBoard` argument ever selects); and one arithmetic
constant. `ram_gaps.py --static` reports any site whose bank the dataflow
knows but no union names, and that bucket is empty too.

**Named in the docs as not established.** `docs/graphics_formats.md` §8 now
holds two items, and both are about the developers' intent rather than the
bytes: why the `$63` per-object-palette sentinel exists when no object uses
it, and why there are two additive fades. Everything else there was settled
on 2026-09-11 (the odd palette regions were over-declared, the header bytes
are a constant, the scene record is read only to `+5`); `docs/story_mode.md` "Oddities
and open questions" keeps only the shipped-defect entries (the Star Court
unlock and the dead record fields are resolved); the "not established" sentences in `docs/match_engine.md`.

**Not started, and only worth it for other people.** A ROM-free CI job
(`make test` skips the ROM-dependent pins when `baserom.gbc` is absent, so
it would run as it stands). It changes nothing in the disassembly.

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

* **2026-09-11** — sprite frames in the PNGs are drawn assembled. A blob
  that is a run of frames carries a layout in the manifest (`gfx:2x2` for
  the 570 walk-sprite blobs, four 16x16 facings side by side; `gfx:3x4+3`
  and `gfx:4x4+4` for the 1,710 character frames, the 24x32 or 32x32 body
  as 4-tile columns with the standing-shadow tiles beneath), taken from the
  object queues' tile order rather than from templates, so it is a fixed
  permutation and encodes back exactly (`docs/graphics_formats.md` §0).
* **2026-09-11** — the last `db` fallbacks in the rendered data are gone.
  The 34 animation scripts that end on a byte the macros cannot spell (a
  hold's unread `$00` operand; the five-byte walk script whose bare loop
  command takes its operand from the next script's first byte) render as
  macros plus one commented `db` (`docs/graphics_formats.md` §4.4). The
  "padding byte" after `CharViewerSceneActors_1a` is the one-opcode
  `as_halt` script its four records point at, now `ActorScript_1a_CharViewer`;
  the one after `FireworkMapActors_14` is padding before the aligned tile
  blob, and is labelled as such.
* **2026-09-11** — a test suite, `make test` (`tests/`, stdlib `unittest`,
  47 tests): the codecs (LZ and tile-image round trips, the SM83 decoder's
  self-test, every idiom macro assembled and compared to the bytes it
  stands for), the emitter's idiom collapse and packed-argument rendering
  on synthetic listings, the curated inputs' structure (unique names, union
  bounds, flag and constant shapes), the analysis on a synthetic ROM
  (descent, the WRAM-bank dataflow through push/pop, the text-id walkers),
  and, when `baserom.gbc` is present, pins on the generated source and the
  analysis (instruction, macro, text-id and manifest counts, every curated
  label on an instruction start) plus `check.py` and `ram_gaps.py` runs.
  The last pin caught one stale curated label (`.fromCallerPtr` at
  `$38:$69aa`, inside an instruction, nothing referencing it), removed.
* **2026-09-11** — the PNG pipeline: the manifest tags the 2,724 blobs that
  are whole 8x8-tile graphics `gfx`, `extract.py` decodes each to a
  four-colour indexed PNG beside its `.bin` (LZ streams decompressed
  first, the tile count stored in the file), the Makefile re-encodes a blob
  whose PNG is newer, and `make check` round-trips every image. Editing a
  tile is now editing an image.
  Setting it up caught one mis-carve and one mis-name: the Academy Main
  Building interior's tile set (scene record 17, loaded by location 5 and
  the ending's Principal's Office) was a raw blob because its stream
  expands too little for the exact-extent promotion; a data-copy hook
  capture of that load classifies it, and the record family it belongs
  to, named `DormInterior*` until now, is `AcademyMainBldg*`.
* **2026-09-11** — packed call arguments: a raw `ld rr, $hhll` whose callee
  reads the pair as two bytes renders as `lb rr, $hh, $ll` with the halves
  named at the site (440 sites: palette index/count, sprite x/y and
  attr/tile, tilemap tile/count, text column/row, rect width/rows); a
  game-flag id handed to Set/Clear/TestGameFlag renders as
  `ld_flag_id de, FLAG_*` and one handed to a `*ByNumber` helper as the
  constant; `RunPagedTextMenu` joins the text-id sinks (13 menu ids named,
  605 → 619). The seventeen game flags that had no name are named for
  their only writers: the ending-seen pair `PlayScreenSequence2` tests and
  sets, the new-game pair `InitStoryModeState` writes, and the thirteen
  per-slot flags the unlock-everything cheat sets that nothing reads. Every
  game-flag operand in the source is symbolic now except three loop bases.
* **2026-09-11** — three idiom macros: `push_wram_bank N` / `pop_wram_bank`
  for the bank prologue and epilogue (351 / 452 sites), `ld_hl_indexed T`
  for the five-instruction split-base table index (414), and `wait_frames N`
  for WaitFramesCmd's inline argument (79). Each expands to the original
  bytes; a label or note landing inside a sequence keeps it raw.
* **2026-09-11** — the questions of intent, worked through: the three
  odd-sized palette regions were over-declared and hid a stray `ret`, a
  47-byte unreferenced firework reset and three padding bytes (carved);
  header bytes +2/+3 are a per-family constant; the scene record is read
  only to `+5`; the Star Court is granted by `CheckAllProgressComplete`
  once all 36 progress flags are set; the record fields are dead stores.
  Two genuine intent questions remain in the graphics doc.
* **2026-09-11** — two emulator experiments close the graphics doc's
  testable questions: the collision map is a 32 × 32 grid of 2 × 2-tile
  cells (the rounded `e * 16` is `(e >> 1) * 32`), drawn live it is the
  Tournament Courtyard; and the bank `$00` fade is a fade to white, seen
  mid-fade with the palettes at master + 20 per component.
* **2026-09-10** — the last 67 live sites, all on the desk: 39 story-script
  loads of actor slot 0/1 handed to helpers that select WRAM bank 4, the
  five digit-drawer copies, the link grid's handedness toggle, the screen
  sequence object list, the ring-shot chart, a scroll-buffer base and the
  char-data patch list, each a range scope on the union that already named
  the address; the ten ranking rows/markers no board argument selects,
  scoped on their traced siblings; and five more routines reachable only
  from the dead debug save flow or a farptr nothing calls, named Unused_.
  160 → 97, every one of them dead.
* **2026-09-10** — the DMG lockout screen, from a native trace of the ROM
  booted in DMG mode: the game hangs there, so the connector could not
  capture it, and on a DMG there is no WRAM bank register for the converter
  to read — the screen's five staging-buffer sites are scoped to the WRAM
  bank 1 union by range, the single upper WRAM half a DMG has. 165 → 160.
* **2026-09-10** — the desk pass after the emulator session: the cutscene
  text-scroll buffer, the continue prompt's tilemap rows, the link-error
  palette, the exhibition grid bits and the character-data blit sources
  named through range-scoped union variants; the bank `$18` sequence union
  no longer reaches into the dead confirm-label drawers; `ram_gaps --static`
  reports dataflow-known-but-unnamed sites (22 found, all resolved). 188 → 165
  bare banked operands, 72 of them live.
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
