# Mario Tennis (GBC) disassembly

A disassembly of **Mario Tennis (USA)** for the Game Boy Color, built with
[RGBDS](https://rgbds.gbdev.io/). It rebuilds the retail ROM byte for byte,
every routine and variable carries a human-assigned name, and the game's
systems are written up under `docs/`.

The repository contains **no copyrighted ROM content**. Graphics, audio,
text and the other binary data are extracted from a user-supplied ROM at
setup time into the gitignored `data/` tree; what is committed is the code,
the layout, the names and the structure.

## Building

1. Obtain a legal copy of Mario Tennis (USA): SHA-1
   `414ba58340a27fc27b127bc01455b32764151ff0`, 2,097,152 bytes, `CGBTENNIS`,
   MBC5+RAM+BATTERY.
2. Install [RGBDS](https://rgbds.gbdev.io/install) v1.0.0 or newer, or put
   its binaries in `tools/rgbds/` (the Makefile's default; override with
   `make RGBDS=`). `.rgbds-version` records the version the byte-perfect
   build is verified against, and `rgbdscheck.asm` fails early on older
   assemblers.
3. Extract the data and build:

   ```sh
   ./setup.sh path/to/rom.gbc   # verifies the ROM, populates data/
   make                         # builds mariotennis.gbc
   make compare                 # confirms SHA-1 matches the original
   make check                   # structural checks the byte compare cannot make
   make test                    # codecs, macros and source pins (ROM optional)
   make FIXES=1                 # mariotennis-fixes.gbc: the shipped bugs fixed
   ```

   `make FIXES=1` assembles the `IF DEF(FIXES)` blocks -- the bugs in
   `docs/bugs.md` that carry a **Fix** paragraph -- into `build-fixes/`,
   leaving the byte-perfect build untouched.

The tools need Python 3 with Pillow; the runtime checks (`make event-test`,
`make slot-audit`) also need PyBoy. `make venv` installs both, at the
versions in `requirements.txt`, into `.venv`, which those targets use. They
start from a battery save (`SAVE=`, default `maxed-unlocked.sav`, which
`tools/savetool.py unlock` can prepare).

## What is here

The ROM is 128 banks of 16 KiB; 59 contain code, the rest graphics, audio,
tilemaps and text.

| | |
|---|---|
| instructions | 133,293 source lines of instructions and code macros (`tools/stats.py`) |
| source-spelled bytes | 848,059 bytes, 40.4% of the ROM, written as instructions, records and decoded tables rather than `INCBIN` |
| labels | 30,436: 14,408 routines and tables and 14,416 locals in ROM, 1,612 RAM names |
| compressed graphics | 839 LZ streams, each named, sized by decoding it |
| `Unused_` routines | 779 routines and 103 blobs nothing live reaches (`docs/unused_code.md`) |

Every `INCBIN` is classified (graphics, audio, text, a resource descriptor,
a record array or fill). Structure is rendered as source -- farcall slot
tables, `rst` pseudo-ops, story map trees and actor bytecode, mode-hook
tables, sprite templates and animation scripts, flag-id lists, text ids,
packed call arguments -- while the content it points at (tiles, palettes,
strings, the 315 sound-channel scripts) stays in `data/`.

`docs/STATUS.md` is the current state and what is still open.

## Layout

- `src/bank_XXX.asm` -- one holder per ROM bank: its `SECTION`, any
  decoded-length includes, and the ordered `INCLUDE` list of its fragments.
  Fragments live by subsystem, named `<topic>_<bank>.asm`: `src/home/`
  (bank `$00`), `src/engine/{match,story,minigames,text,menus,cutscenes,save}/`,
  `src/story/` (location scripts), `src/audio/` (sound engine and banks),
  `src/data/{shots,text,sprites,scenes,gfx}/` (table-and-blob banks), and
  `src/twins/` (shared bodies of duplicated routines). A bank's order is its
  include order, so fragments can be edited, split or moved without touching
  the bytes. Data is structured source, a generated `INCLUDE` from `data/`
  (text, palettes, sound tables), or an `INCBIN` of a named blob.
- `ram/` -- RAM declarations (`wram.asm`, `hram.asm`, `sram.asm`), with a
  note on every symbol.
- `include/` -- hardware (`hardware.inc`, CC0), macros, constants, flags,
  text ids and codes, actor roles, mirrored RAM.
- `data.manifest` -- the offset/length/spec list `tools/extract.py` slices
  the ROM by; `data.previews` -- which planes, tiles and palettes make each
  scene preview.
- `mods/` -- a fork's edited data files (below).
- `docs/` -- one subsystem each: `match_engine.md`, `story_mode.md`,
  `screens_and_ui.md`, `graphics_formats.md`, `actor_script.md`,
  `sound_engine.md`, `save_format.md`, `ram_map.md`, `bank0_notes.md`; plus
  `bugs.md` (defects, with dead stores and stubs kept apart),
  `unused_code.md` (unreferenced code and its patterns) and
  `duplicated_code.md` (live routines with identical copies).

## Reading the source

- **Every instruction line ends with its original address** (`; $5db3`), so
  a reference in the docs (`$05:$5db3`) is greppable and is the address to
  break on in an emulator running the original cartridge. The comments are
  not build addresses: after an edit changes a bank's size they are the
  original ROM's, and a moved or inserted line can go without one. The
  runtime tools place lines relative to the nearest label in the build's
  symbol file and skip edited stretches (`tools/banksrc.py`,
  `build_addresses`).
- **Local labels** (`.loop`) are jump targets inside a routine, spelled
  `Parent.done` from outside. A routine with a table in its middle resumes
  after it with `Routine.local:`.
- **Every entry point is a global label**, named for what selects it
  (`<Drill>Result<k>`, `<Location>Entry<id>Scene`); `make check` (`labels`)
  enforces it.
- **Notes** above a routine say what the name cannot: what it does, its
  arguments, what is wrong with it.
- **Macros** (`include/macros.inc`) stand for the idioms the code is built
  from and expand to the original bytes: `farcall` (`rst $18`), `sound`
  (`rst $08`), `wram_bank` / `push_wram_bank` / `pop_wram_bank`,
  `ld_hl_indexed` (`hl = Table + a`), `wait_frames`, the register-pair
  macros (`ld_xy`, `ld_cell`, `ld_size`, `ld_oam`, `ld_tile_run`,
  `ld_bg_pals` / `ld_obj_pals`), map positions in tiles with a point
  (`map_entry $03, FACE_DOWN, 18.0, 13.0`: the game's 1/256-tile words,
  checked by `map_pos`), `set_flag` / `test_flag` / `clear_flag` /
  `ld_flag_id` (`include/flag_constants.inc`), `palette`, and the
  `script_*`, `as_*`, `anim_*`, `map_*` and `tilemap_*` families for story
  scripts, actor bytecode, animation scripts, map records and tilemap patch
  lists.
- **VRAM addresses are places**: `vTiles0 + $10 * TILE_SIZE`,
  `vBGMap0 + 15 * TILEMAP_WIDTH + 4`, `+ VRAM_BANK1` for the second bank.
- **RAM**: WRAM banks 1-7 and the overlaid buffers are unions with a variant
  per owner; a banked address is named only where its bank was proven, and a
  raw `$dxxx` that remains is inside an `Unused_` routine.
  `include/ram_mirrored.inc` holds structures that exist identically in
  several banks (`docs/ram_map.md`).
- **`Unused_` routines** are proven unreferenced; where one is a copy or
  sibling of a live routine, its note says which and how it differs.
- **Twins**: 139 live routines are instruction-identical copies (one per
  bank, mostly: `FetchText_25` / `FetchText_26`, the shot solver's helpers in
  every court bank, the menu-cursor library). All but three are assembled
  from one of 62 shared files under `src/twins/` (275 copies, dead ones
  included) by a line such as `twin fetch_text, 25`, so a fix has one home
  (`docs/duplicated_code.md`).

## Editing and modding

`src/`, `ram/` and `include/` are the source, edited directly, and `make` is
the whole pipeline. They were produced by a generator (coverage traces, a
recursive descent and JSON inputs), since retired; it, its inputs and the
coverage captures are at the git tag `generator-final`.

After an edit only `make compare` is expected to fail. Edits are safe
because the layout is recomputed rather than restated:

- **Size can change.** Pointers are symbols, so inserted bytes move
  everything after them. Each bank's section stops at its last real byte and
  `rgblink -p 0xff` pads the rest, leaving 196 KiB free across 124 banks and
  room for a blob, tilemap or PNG to grow (even a labelled tail is left to
  the linker).
- **Text** is `data/<bank>/TextStrings_<bank>.asm`; offsets are
  `dw Pool.sN - Pool`, so the assembler recomputes them. Breaks are `line` /
  `page` / `done`, the other control codes are named
  (`include/text_codes.inc`), and a roster name in a string is
  `TX_SHORT_TEXT, CHAR_EMILY`. `tools/strings.py baserom.gbc --index --bank
  <bank>` finds a string; a text id in code is `Text_<bank>_<index>`
  (`include/text_ids.inc`).
- **Data files are named after their labels**
  (`data/bank_040/AlexSpriteFrame00.png`,
  `data/bank_001/lz_DmgLockoutTilesLZ_01.bin`, `lz_` marking a compressed
  stream); only a blob nothing names keeps an address name (`d_4004.bin`).
- **Graphics are PNGs.** Each of the 2,728 tile-graphics blobs is also
  extracted as a four-colour indexed PNG: character frames as the 24x32 body
  with its standing shadow, walk sprites as four facings side by side
  (`docs/graphics_formats.md` §0), everything else as tiles in blob order,
  sixteen per row. Edit the PNG and `make` re-encodes (and recompresses an
  `lz_*`) blob; an untouched PNG rebuilds nothing, and enlarging a plain
  image's canvas grows its blob.
- **Screen layouts are text.** The 231 tile and attribute planes (all LZ
  streams) are also `.tilemap` grids, one `tilemap_row` of hex cells per
  row at the width the loader uses; `make` re-encodes an edited grid. The 37 scenes get a view-only
  `<Tilemap>.preview.png` (`make previews` redraws them).
- **Tables are structured source** with named fields
  (`docs/graphics_formats.md`, `docs/story_mode.md`). The ones a balance mod
  wants are one macro row per record, field order in the macro's comment:
  `char_record` (attributes and eleven stat bars per character,
  `src/engine/story/debug_02.asm`), `equip_stat_deltas`, `stat_thresholds`,
  `exp_threshold`, `AISHOT_*`, `cpu_difficulty`
  (`src/engine/menus/cpu_38.asm`), `shot_preset`
  (`src/engine/match/shot2_07.asm`), `court_scene`
  (`src/engine/match/court_08.asm`), `match_settings` (every story and
  minigame match, `src/engine/story/match_0a.asm`), `drill_outcomes`,
  `court_positions` and `score_rule`.
- **Ids are constants** (characters, courts, scenes, game modes, story
  locations and stages, minigames, shot types, sounds, menu items, link
  roles and tokens), in families in `include/constants.inc` whose headers
  name the RAM symbol that carries them.
- **Assets are referenced by name.** A `tileblock` or `screen_asset` row in
  bank `$39` defines its `TILEBLOCK_*` / `SCREENASSET_*` index, so inserting
  a row renumbers its references. A `$4000` slot is a `DataPtr_`/`FarPtr_`
  label used as `BANK(...)` / `LOW(...)` or through `dslot`.
- **Shot physics are source**: the fifteen trajectory tables
  (`docs/match_engine.md` "The trajectory tables") are
  `data/bank_02x/<Table>.asm`, `traj_row speed, elevation, delta` rows
  blocked by contact-height band and placement variant.
- **Sound is source**: the 315 channel scripts are
  `data/bank_07x/<Track>.asm`, one `snd_*` row per command
  (`docs/sound_engine.md`); a new track is a file plus a `SoundTable_<bank>`
  row.
- **Copy counts follow their source.** A whole-blob VRAM copy is
  `ld c, (Next - Blob) / 16`, or `Blob_SIZE / 16` for a decompressed stream
  (a decoded length `make` derives), so a grown blob is copied whole; a
  partial copy keeps its literal count and says which tiles of which blob.
  A whole RAM object uses the `_SIZE` that `export_size` exports
  (`ld bc, wInlineTextBuffer_SIZE`), part of a buffer says which part
  (`SCREEN_HEIGHT * TILEMAP_WIDTH`, `2 * CHAR_RECORD_SIZE`,
  `WRAMX_END - wScreenScratch`), and whole map rows are counted
  (`3 * TILEMAP_WIDTH / 16`).
- **The header is fixed up**: `make` runs `rgbfix -v`, so an edited title
  or cart type cannot leave a header checksum the CGB boot ROM rejects; it
  changes nothing in the unmodified build.
- **Free RAM** is listed in `docs/ram_map.md`; `tools/ram_free.py`
  recomputes the static list after RAM changes.
- **Saves**: `tools/savetool.py` (`docs/save_format.md`).

`make check` round-trips every PNG, grid, sound track and trajectory table.

**A fork commits its data edits in `mods/`.** `data/` is ROM content and is
never committed; an edited file lives at the same path under `mods/`
(`mods/bank_040/AlexSpriteFrame00.png`) and is copied over `data/` before
every `make` and after every extraction (`mods/README.md`). End to end, on a
branch: change `src/` and `data/`, run `python3 tools/mods.py collect
baserom.gbc` to copy changed data files into `mods/`, `make`. `make check`
and `make test` read the build's own layout, `make shift-test` proves the
code still relocates, and `make event-test` plays the edited ROM against a
padded copy of itself. Commit `src/` and `mods/`; checking out a tree
without a mod restores the extracted file on the next `make`.

`./setup.sh` and `tools/extract.py` overwrite `data/` and delete files the
manifest no longer lists, then reapply `mods/`. `--keep` leaves any file
that differs from what the ROM would give (a `.bin`, a generated `.asm`, a
PNG that no longer encodes to its blob) as it is, reports it, and deletes
nothing.

## Tools

- `tools/check.py` (`make check`) -- what a byte-perfect build cannot check: LZ streams decode in their extents and re-encode, no symbol inside a stream, no overlapping regions, no routine under an actor script's, a table's or another routine's label, no new branch to the next instruction, no ROM address as a number, DMA sources aligned, every PNG, grid, track and trajectory table round-trips, actor-slot names hold, `Unused` names match `reach.py`, `; debug warp only` entries match `routes.py`.
- `tests/` (`make test`) -- codecs, every idiom macro against its bytes, the extractor's `--keep`, and source pins (idiom, sound-id, VRAM-name, copy-length counts).
- `tools/extract.py` -- `data.manifest` + base ROM -> `data/`.
- `tools/mods.py` -- copies `mods/` over `data/`; collects edited data files into `mods/`.
- `tools/lz.py`, `tools/gfx.py`, `tools/tilemap.py`, `tools/snd.py` -- the LZ, PNG, tilemap-grid and sound-script codecs.
- `tools/strings.py` -- game text by bank and index, or a string scan of a ROM.
- `tools/savetool.py` -- battery save inspector and editor.
- `tools/gfxdump.py` -- PNG contact sheets of graphics streams and palettes, in gitignored `data/gfx/`.
- `tools/stats.py` -- the headline counts above, from the built `.sym` and `.map`.
- `tools/banksrc.py`, `tools/deps.py` -- a bank's source read whole; the build's dependency list.
- `tools/reach.py` -- which routines can run at all, from the reset, interrupt and `rst` vectors; `--coverage` splits never-entered routines into unreachable and not yet reached.
- `tools/routes.py` -- which `map_entry` rows anything in retail can send the player to.
- `tools/twins.py` -- the groups of instruction-identical live routines.
- `tools/ram_free.py` -- RAM bytes no symbol covers.
- `tools/shifttest.py` (`make shift-test`) -- builds with every bank padded and checks each changed byte is a moved label reference; `--out` keeps the ROM and `.sym`.
- `tools/eventtest.py` (`make event-test`) -- plays the padded and original builds through every story state and location under the same inputs, reporting apart entry points entered in a mode the game never uses; `--free`, `--targets`, `--handlers` add sessions, `--coverage`/`--units` record routines entered.
- `tools/coverage.py` -- which routines an eventtest coverage file shows run and never run.
- `tools/steer.py` -- runs a routine no session entered by replaying a session and forcing each branch and table jump on the way down to it.
- `tools/linktest.py` -- two PyBoy games joined by a link cable made of hooks on the games' serial code, through to a link match; `--keys` (random presses), `--unplug-after` (pull the cable), `--steer`, `--coverage`.
- `tools/actorslots.py` -- names the `map_actor` slot a story script addresses by following control flow (`--apply`); `--runtime` (`make slot-audit`) checks the names in PyBoy.
- `tools/runtime_audit.py` -- checks `Unused` names, actor-slot names and NpcScripts ids in headless play.
- `tools/ramaudit.py` -- `free` poison-tests the free-RAM list over played flows; `writer` names the routine that first writes a byte.
- `tools/playtest.py` -- plays two ROMs side by side and reports where their screens diverge.

Each tool's docstring has its full usage.
