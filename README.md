# Mario Tennis (GBC) disassembly

A disassembly of **Mario Tennis (USA)** for the Game Boy Color, built with
[RGBDS](https://rgbds.gbdev.io/). It rebuilds the retail ROM byte for byte,
every routine and variable carries a human-assigned name, and the game's
systems — the match engine, the story RPG, the menus, the text engine, the
sound driver, the save format — are written up under `docs/`.

The repository contains **no copyrighted ROM content**. Graphics, audio,
text and the other binary data are extracted from a user-supplied ROM at
setup time into the gitignored `data/` tree; what is committed is the code,
the layout, the names and the structure.

## Building

1. Obtain a legal copy of Mario Tennis (USA). Expected file:
   - SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0` (2,097,152 bytes,
     `CGBTENNIS`, MBC5+RAM+BATTERY)
2. Install [RGBDS](https://rgbds.gbdev.io/install) (or place its binaries in
   `tools/rgbds/`; the Makefile looks there by default — override with
   `make RGBDS=`). Requires v1.0.0 or newer; `.rgbds-version` records the
   version the byte-perfect build is verified against, and `rgbdscheck.asm`
   fails the build early on older assemblers.
3. Extract the data and build:

   ```sh
   ./setup.sh path/to/rom.gbc   # verifies the ROM, populates data/
   make                         # builds mariotennis.gbc
   make compare                 # confirms SHA-1 matches the original
   make check                   # structural checks the byte compare cannot make
   make test                    # the generator's own tests (ROM optional)
   ```

## What is here

The ROM is 128 banks of 16 KiB. 59 of them contain code; the rest are
graphics, audio, tilemaps and text.

| | |
|---|---|
| instructions disassembled | 160,940, across every code bank |
| proven code and structured source | 428,509 bytes, 20.4% of the ROM |
| labels | 21,979 — 20,399 human-named, the rest derived by the generator from something already named (a bank's `$4000` slot table, a sound table) |
| compressed graphics | 838 LZ streams, each named, sized by decoding it |
| `Unused_` routines | 199 routines and 100 blobs nothing references, catalogued in `docs/unused_code.md` |

Everything that is not code was classified: every `INCBIN` is known to be
graphics, audio, text, a resource descriptor, a record array or fill. The
structure is rendered rather than left binary — farcall slot tables, `rst`
pseudo-ops, story map trees and actor bytecode, mode-hook tables, sprite
templates and animation scripts, flag-id lists, text ids, packed call
arguments — while the content those structures point at (tiles, palettes,
strings, the 315 sound-channel scripts) stays in `data/`.

`docs/STATUS.md` is the current state of the project and what is still open;
`docs/history.md` is the dated log of how it was done.

## Modding

The build is a normal RGBDS project, so a change is an edit plus `make`; only
`make compare` (which asserts the original SHA-1) is expected to fail after
one. What makes edits *safe* is that the layout is recomputed rather than
restated:

- **Code and data may change size.** Pointers are symbols, so inserting bytes
  moves what follows and every reference follows it. Each bank's section stops
  at its last real byte and `rgblink -p 0xff` pads the rest, so the trailing
  space (186 KiB across 122 banks) is free for new code.
- **Text.** Edit the strings in `data/<bank>/TextStrings_<bank>.asm`; the
  per-bank offset table is `dw Pool.sN - Pool` in the bank source, so the
  assembler recomputes every offset. Find a string with
  `tools/strings.py baserom.gbc --index --bank <bank>`; a text id in the code
  is spelled `Text_<bank>_<index>` (`include/text_ids.inc`).
- **Data files carry their names.** Everything extracted into `data/` is
  named after its label in the source: `data/bank_040/AlexSpriteFrame00.png`,
  `data/bank_001/lz_MenuFontTiles_01.bin` (the `lz_` prefix marks a
  compressed stream), `data/bank_017/MatchResultPalettes.asm`. Only a blob
  nothing names keeps an address name (`d_4004.bin`).
- **Graphics are images.** Every blob that is tile graphics (2,725 of
  them: character and object frames, tile sets, icons, portraits, fonts) is
  extracted twice, as the `.bin` the source includes and as a PNG beside it
  in `data/` — a four-colour indexed image. Sprite frames are drawn
  assembled: a character frame as its 24x32 body with the standing-shadow
  tiles beneath, a walk sprite as its four facings side by side
  (`docs/graphics_formats.md` §0); everything else is the tiles in blob
  order, sixteen per row. Edit the PNG and `make` re-encodes the blob, compressing
  it again if it is an LZ stream (`lz_*`); a PNG you have not touched never
  rebuilds anything. A plain image grows its blob if you enlarge the canvas
  and draw past the last tile. `make check` confirms every PNG still encodes back to
  its blob. `tools/gfx.py` and `tools/lz.py` are the converters if you need
  them by hand.
- **Tables.** Stats, physics constants, mode hooks, map actors, animation
  scripts, flag lists and menu definitions render as structured source with
  named fields — `docs/graphics_formats.md` and `docs/story_mode.md` give the
  layouts.
- **Copy counts follow their source.** A VRAM copy of a whole blob is
  written `ld c, (Next - Blob) / 16`, and a whole copy of a decompressed
  stream `ld c, Blob_SIZE / 16`, where `Blob_SIZE` is the decoded length in
  a `.inc` `make` derives from the blob beside it. Either way, growing the
  blob copies the extra tiles instead of silently truncating. A partial copy
  keeps its literal count and says which tiles of which blob it takes.
- **The header is fixed up.** `make` runs `rgbfix -v`, so editing the title or
  cart type cannot leave a header checksum the CGB boot ROM rejects. It changes
  nothing in the unmodified build, which is why `make compare` still holds.
- **Save files.** `tools/savetool.py` verifies, dumps and edits battery saves
  (levels, stats, unlock flags), recomputing the checksums (`docs/save_format.md`).

`data/` is generated, so `./setup.sh` and `tools/extract.py` overwrite it
and delete files the manifest no longer lists. To re-extract after the
source has been regenerated without losing edits, run extraction with
`--keep`: a file that differs from what the ROM would give (a `.bin`, a
generated `.asm`, or a PNG that no longer encodes to its blob) is left as
it is and reported, and nothing is deleted.

## Reading the source

- **Every instruction line ends with its address**, `; $5db3`, so a reference
  in the docs (`$05:$5db3`) is greppable.
- **Local labels** (`.loop`, `.done`) are jump targets inside a routine;
  from another routine they are spelled `Parent.done`.
- **Notes** above a routine (a comment block) say what the address and the
  name cannot: what it does, what its arguments mean, what is wrong with it.
- **Macros** (`include/macros.inc`) stand for the idioms the code is built
  from, and each expands to the original bytes: `farcall` for the
  `rst $18` cross-bank call, `wram_bank N` and `push_wram_bank N` /
  `pop_wram_bank` for the WRAM bank switch and the save-and-restore around
  it, `ld_hl_indexed Table` for the split-base table index (`hl = Table + a`),
  `wait_frames N` for the frame-wait's inline argument, `lb rr, hi, lo` where
  a callee reads a register pair as two bytes (the site comment names them),
  `set_flag` / `test_flag` / `clear_flag` and `ld_flag_id` for the
  per-story-slot game flags (`include/flag_constants.inc`), `sound` for the
  `rst $08` sound command, and the `script_*`, `as_*`, `anim_*`, `map_*`
  and `tilemap_*` families for the story scripts, actor bytecode, animation
  scripts, map records and tilemap patch lists.
- **RAM symbols** live in `ram/` (`wram.asm`, `hram.asm`, `sram.asm`). WRAM
  banks 1-7 and the overlaid buffers are declared as unions with a variant per
  owner, and a banked address is only named at a site whose bank is proven,
  by the generator's dataflow or by a traced run; a raw `$dxxx` that remains
  is inside an `Unused_` routine no trace can reach. `include/ram_mirrored.inc`
  holds the structures that exist identically in several banks.
- **`Unused_` routines** are proven unreferenced. Where one is a copy or a
  sibling of a live routine, its note says which and how it differs.
- **Twins.** 279 live routines are instruction-identical copies of one
  another, mostly one per bank (`FetchText_25` / `FetchText_26`, the shot
  solver's helpers in every court bank, the menu-cursor library). Each
  one's note names its copies, because a fix has to land in all of them;
  `docs/duplicated_code.md` is the full list.

## Layout

- `src/bank_XXX.asm` — one file per ROM bank. Code is disassembled;
  data is either structured source, a generated `INCLUDE` from `data/`
  (text, palettes, sound tables — decoded structure whose values are ROM
  content), or an `INCBIN` of a named blob.
- `ram/`, `include/` — RAM declarations; hardware, macro, constant, flag,
  text-id and mirrored-RAM includes (`hardware.inc` is CC0; the rest are
  generated or hand-maintained as their headers say).
- `data.manifest` — offset/length/spec list `tools/extract.py` slices the
  base ROM by.
- `docs/` — `STATUS.md` (current state), `history.md` (the dated log),
  `match_engine.md`, `story_mode.md`, `screens_and_ui.md`,
  `graphics_formats.md`, `actor_script.md`, `sound_engine.md`,
  `save_format.md`, `ram_map.md`, `bank0_notes.md` (one subsystem each),
  `bugs.md` (defects in the game, with dead stores and stubbed routines kept
  apart), `unused_code.md` (the unreferenced code and its patterns),
  `duplicated_code.md` (the live routines that exist as identical copies).
- The **curated inputs** the source is generated from — all JSON, all keyed
  by flat ROM offset (`bank * 0x4000 + cpu - 0x4000`) where they name a site:
  `labels.json` (symbol names; a value may be `{"name", "note"}`, and a
  dot-prefixed name is a local label), `data_tables.json` (the render spec
  of each data region), `ram_map.json` and `ram_unions.json` (RAM names and
  the scoped unions), `constants.json` (named immediates), `flags.json`
  (game-flag names), `coverage/*.json` (execution traces and hand-authored
  code seeds) and `hooks/*.json` (captured data-copy arguments that classify
  the `$4000` slot tables).
- `tools/` — the generator and its helpers (below).

## Regenerating

`src/`, `ram/` and most of `include/` are generated. They are committed so
the repository builds as it stands, but a change to a name, a note, a union
or a data spec is made in the curated inputs and regenerated — never by
hand-editing `src/`, which the next regeneration overwrites:

```sh
python3 tools/disasm.py baserom.gbc coverage/*.json --hooks hooks/*.json
python3 tools/extract.py baserom.gbc data.manifest data/
make clean && make compare && make check
```

The `--hooks` argument is not optional: without the captures, the data-slot
tables the static analysis cannot classify regress to raw blobs.

## Tools

- `tools/disasm.py` — the command line of the generator; `tools/disasmlib/`
  is the generator itself, in three stages: analysis (`core.py` decoding and
  descent, `slots.py` data-slot proving, `carve.py` structure carving,
  composed in `disassembly.py`), naming (`labels.py`, `ram.py`,
  `textids.py`, `config.py`) and emission (`emit.py`, with the renderers in
  `operands.py`, `idioms.py`, `datatables.py`, `macros.py`). The package
  docstring has the module map.
- `tools/check.py` (`make check`) — the structural checks a byte-perfect
  build cannot make: every LZ stream decodes inside its extent and survives a
  re-encode, no symbol sits inside a stream, every text table addresses real
  strings, every curated constant lands on an instruction holding that value,
  the extracted regions do not overlap, local labels bind to the right parent.
- `tests/` (`make test`) — the generator's unit tests: the codecs, the
  macros against the bytes they stand for, the idiom and packed-argument
  renderers, the curated inputs' structure and the analysis on a synthetic
  ROM; with `baserom.gbc` present, pins on the generated source as well.
- `tools/twins.py` — the groups of instruction-identical live routines
  (`docs/duplicated_code.md`).
- `tools/progress.py` — per-bank proven-code bytes and the label-naming
  buckets. `tools/ram_gaps.py` — the bare banked-WRAM operands and why each
  is bare (`--static` adds the ones the dataflow could name).
- `tools/lz.py` — codec for the game's LZ format, both directions; the
  encoder round-trips every stream in the ROM.
- `tools/strings.py` — dumps the game text from the ROM by bank and index.
- `tools/savetool.py` — battery save inspector and editor.
- `tools/gfxdump.py` — PNG contact sheets of the graphics streams and palette
  regions, under gitignored `data/gfx/`, for identifying assets.
- `tools/sm83.py` — the SM83 decoder, emitting RGBDS syntax that round-trips
  byte-exactly through rgbasm.
- `tools/extract.py` — `data.manifest` + base ROM → `data/`.
- `tools/tracelog2cov.py`, `tools/hook_client.py`, `tools/trace_client.py` —
  the coverage pipeline: a BizHawk native Trace Logger file, or the
  `gbc-disasm` Lua connector's traces and data-copy hook captures, into the
  `coverage/` and `hooks/` inputs. Code was identified by execution coverage
  from real runs of the game, extended by a conservative recursive descent;
  `docs/history.md` records how each part of the ROM was reached.
