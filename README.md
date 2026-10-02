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
   make test                    # codecs, macros and source pins (ROM optional)
   ```

   The tools need Python 3 with Pillow; the runtime checks (`make
   event-test`, `make slot-audit`) also need PyBoy. `make venv` puts both,
   at the versions in `requirements.txt`, into `.venv`, which those targets
   then use; they also start from a battery save (`SAVE=`, default
   `maxed-unlocked.sav`, which `tools/savetool.py unlock` can prepare).

## What is here

The ROM is 128 banks of 16 KiB. 59 of them contain code; the rest are
graphics, audio, tilemaps and text.

| | |
|---|---|
| instructions disassembled | 160,940, across every code bank |
| proven code and structured source | 428,509 bytes, 20.4% of the ROM |
| labels | 21,979 — 20,399 human-named, the rest derived from something already named (a bank's `$4000` slot table, a sound table) |
| compressed graphics | 839 LZ streams, each named, sized by decoding it |
| `Unused_` routines | 773 routines and 100 blobs nothing live reaches, catalogued in `docs/unused_code.md` |

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
  space (196 KiB across 124 banks) is free for new code -- and a blob that
  grows, an edited tilemap or PNG, has room, since even a labelled tail is
  left to the linker rather than restated as a fill.
- **Text.** Edit the strings in `data/<bank>/TextStrings_<bank>.asm`; the
  per-bank offset table is `dw Pool.sN - Pool` in the bank source, so the
  assembler recomputes every offset. Line and page breaks are the `line` /
  `page` / `done` macros and the other control codes are named
  (`TX_PLAYER_NAME`, `TX_ARG_NUMBER`, `TX_DELAY_15`, ...,
  `include/text_codes.inc`, with what each does); a roster name inserted
  into a string is `TX_SHORT_TEXT, CHAR_EMILY`. Find a string with
  `tools/strings.py baserom.gbc --index --bank <bank>`; a text id in the code
  is spelled `Text_<bank>_<index>` (`include/text_ids.inc`).
- **Data files carry their names.** Everything extracted into `data/` is
  named after its label in the source: `data/bank_040/AlexSpriteFrame00.png`,
  `data/bank_001/lz_DmgLockoutTilesLZ_01.bin` (the `lz_` prefix marks a
  compressed stream), `data/bank_016/MatchResultPalettes0.asm`. Only a blob
  nothing names keeps an address name (`d_4004.bin`).
- **Graphics are images.** Every blob that is tile graphics (2,728 of
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
  its blob. `tools/gfx.py`, `tools/tilemap.py` and `tools/lz.py` are the converters
  if you need them by hand.
- **Screen layouts are text.** Every tile plane and attribute plane (213
  blobs, most of them LZ streams) is extracted a second time as a
  `.tilemap` file beside its `.bin`: one `tilemap_row` of hex cells per
  row, at the width the loader uses. Edit it and `make` re-encodes the
  blob, compressing it again if it is an `lz_*` stream; `make check`
  round-trips every grid. The 37 scenes also get a view-only picture
  beside the grid (`<Tilemap>.preview.png`, composed from the scene's
  tiles and palettes; `make previews` redraws them after an edit).
- **Tables.** Stats, physics constants, mode hooks, map actors, animation
  scripts, flag lists and menu definitions render as structured source with
  named fields — `docs/graphics_formats.md` and `docs/story_mode.md` give the
  layouts. The tables a balance mod reaches for are one macro row per record
  with the field order in the macro's comment (`include/macros.inc`): every
  character's attributes and eleven stat bars (`char_record`, named per
  character, `src/engine/story/debug_02.asm`), the racket and shoe bonuses
  (`equip_stat_deltas`), the four stat-growth archetypes (`stat_thresholds`),
  the EXP curve (`exp_threshold`), the AI's shot habits per serve style
  (`AISHOT_*`), the CPU difficulty rows (`cpu_difficulty`, `src/engine/menus/cpu_38.asm`),
  the shot-type presets (`shot_preset`, `src/engine/match/shot2_07.asm`), the
  per-court surface physics (`court_scene`, `src/engine/match/court_08.asm`),
  every story and
  minigame match's mode, opponent, court, format and music
  (`match_settings`, `src/engine/story/match_0a.asm`), the training drills'
  per-outcome message and verdict rows (`drill_outcomes`), the court
  position records (`court_positions`) and the Target Shot scoring rules
  (`score_rule`).
- **Ids are constants.** Character, court, scene, game-mode, story-location,
  minigame, shot-type, sound and menu-item ids, the link roles and control
  tokens, and the per-location story stages each have a family in
  `include/constants.inc`, and the comparisons and stores that use them are
  written with the name. A family's header says which RAM symbol carries it.
- **Assets are referenced by name.** The two screen-asset dispatchers take
  an index into a table in bank `$39`, and each table row defines its own:
  `tileblock CharacterSelectGfx` is a row of `TileBlockPtrs_39` and defines
  `TILEBLOCK_CharacterSelectGfx`, `screen_asset TitleScreen, ...` a row of
  `ScreenAssetRecordTable` and `SCREENASSET_TitleScreen`. Call sites and the
  cutscene id lists use those names, so inserting a row renumbers what
  follows and every reference moves. A slot in a bank's `$4000` table is
  likewise a `DataPtr_`/`FarPtr_` label, referenced as `BANK(...)` /
  `LOW(...)` or through `dslot`.
- **The shot physics are source.** The fifteen trajectory tables the shot
  solver looks answers up in (`docs/match_engine.md` "The trajectory
  tables") are extracted to `data/bank_02x/<Table>.asm` as `traj_row speed,
  elevation, delta` rows, blocked by contact-height band and placement
  variant. Edit a row and `make`; `make check` proves the round trip.
- **Sound is source.** The 315 channel scripts behind every song and effect
  are extracted to `data/bank_07x/<Track>.asm`, one `snd_*` row per command
  (`snd_note C#, 3, 8`, `snd_loop_point 0`, `snd_call 2, .call0`, ...), with
  the command set in `docs/sound_engine.md`. Edit a track and `make`; add
  one with a file and a `SoundTable` row. `make check` proves every track
  round-trips through the codec (`tools/snd.py`).
- **Copy counts follow their source.** A VRAM copy of a whole blob is
  written `ld c, (Next - Blob) / 16`, and a whole copy of a decompressed
  stream `ld c, Blob_SIZE / 16`, where `Blob_SIZE` is the decoded length in
  a `.inc` `make` derives from the blob beside it. Either way, growing the
  blob copies the extra tiles instead of silently truncating. A partial copy
  keeps its literal count and says which tiles of which blob it takes.
- **The header is fixed up.** `make` runs `rgbfix -v`, so editing the title or
  cart type cannot leave a header checksum the CGB boot ROM rejects. It changes
  nothing in the unmodified build, which is why `make compare` still holds.
- **Free RAM.** `docs/ram_map.md` ends with the bytes nothing names and a
  poison run never touched, per bank; `tools/ram_free.py` recomputes the
  static half after the RAM declarations change.
- **Save files.** `tools/savetool.py` verifies, dumps and edits battery saves
  (levels, stats, unlock flags), recomputing the checksums (`docs/save_format.md`).

- **What an edit looks like end to end.** On a branch: fix code in `src/`
  and edit data in `data/` (the PNG, grid, text or track); `python3
  tools/mods.py collect baserom.gbc` copies each changed data file into
  `mods/`; `make`. `make compare` now fails -- that is the point -- and
  everything else still applies: `make check` and `make test` read the
  build's own layout, `make shift-test` proves the edited code still
  relocates, and `make event-test` plays the edited ROM against a padded
  copy of itself (`make venv` first for PyBoy). Commit `src/` and `mods/`.
  Checking out a tree without a mod puts the extracted file back on the next
  `make`, so switching between a fork and upstream needs no re-extraction.
  To show a fix works, run the routine in PyBoy on both builds: the
  grayscale and menu-stack fixes in `docs/bugs.md` were confirmed by calling
  `ConvertColorToGrayscale` on test colours and by forcing a full menu
  stack under the debug menu.
- **A fork commits its edits in `mods/`.** `data/` is ROM content and is
  not committed; an edited file lives at the same relative path under
  `mods/` (`mods/bank_040/AlexSpriteFrame00.png`) and is copied over
  `data/` before every `make` and after every extraction. Edit in `data/`
  and run `python3 tools/mods.py collect baserom.gbc` to bring every changed
  file into `mods/`, or put files there directly (`mods/README.md`).

`data/` is extracted, so `./setup.sh` and `tools/extract.py` overwrite it
and delete files the manifest no longer lists; the `mods/` overlay is put
back afterwards. To re-extract without losing edits made in `data/` that are
not yet in `mods/`, run extraction with `--keep`: a file that differs from
what the ROM would give (a `.bin`, a generated `.asm`, or a PNG that no
longer encodes to its blob) is left as it is and reported, and nothing is
deleted.

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
  `ld_xy de, x, y` for a sprite's screen position and `ld_cell de, column,
  row` for a background-map cell,
  `set_flag` / `test_flag` / `clear_flag` and `ld_flag_id` for the
  per-story-slot game flags (`include/flag_constants.inc`), `palette` for
  a CGB palette as four `r,g,b` triples, `sound` for the
  `rst $08` sound command, and the `script_*`, `as_*`, `anim_*`, `map_*`
  and `tilemap_*` families for the story scripts, actor bytecode, animation
  scripts, map records and tilemap patch lists.
- **VRAM addresses are places.** A copy destination is `vTiles0 + $10 *
  TILE_SIZE` or `vBGMap0 + 15 * TILEMAP_WIDTH + 4`, never a bare `$8100`;
  `+ VRAM_BANK1` marks the second VRAM bank (`include/constants.inc`).
- **RAM symbols** live in `ram/` (`wram.asm`, `hram.asm`, `sram.asm`). WRAM
  banks 1-7 and the overlaid buffers are declared as unions with a variant per
  owner, and a banked address was named only at a site whose bank was
  proven, by static dataflow or by a traced run; a raw `$dxxx` that remains
  is inside an `Unused_` routine no trace can reach. `include/ram_mirrored.inc`
  holds the structures that exist identically in several banks.
- **`Unused_` routines** are proven unreferenced. Where one is a copy or a
  sibling of a live routine, its note says which and how it differs.
- **Twins.** 279 live routines are instruction-identical copies of one
  another, mostly one per bank (`FetchText_25` / `FetchText_26`, the shot
  solver's helpers in every court bank, the menu-cursor library). 275 of
  them are assembled from one shared file under `src/twins/`: a bank says
  `twin fetch_text, 25` where its copy sits, and the file's
  `FetchText_{TWIN}:` and bank-local references become that bank's, so a
  fix has one home. The shared bodies carry no per-instruction addresses;
  the `twin` line has the copy's start. `docs/duplicated_code.md` lists the
  families and the four copies that stay separate.

## Layout

- `src/bank_XXX.asm` — one holder per ROM bank: its `SECTION` line, any
  decoded-length includes, and the ordered `INCLUDE` list of the fragment
  files that hold its contents. The fragments live by subsystem, named
  `<topic>_<bank>.asm` after the routines that dominate them:
  `src/home/` (bank `$00`), `src/engine/{match,story,minigames,text,menus,
  cutscenes,save}/`, `src/story/` (the location scripts), `src/audio/`
  (the sound engine and the sound banks) and `src/data/{shots,text,sprites,
  scenes,gfx}/` (the banks that are only tables and blobs). A bank's order
  is the holder's include order, so a fragment can be edited, split or
  moved without touching the bytes. Code is disassembled; data is either
  structured source, a generated `INCLUDE` from `data/` (text, palettes,
  sound tables — decoded structure whose values are ROM content), or an
  `INCBIN` of a named blob. `tools/banksrc.py` reads a bank whole for the
  tools.
- `ram/`, `include/` — RAM declarations; hardware, macro, constant, flag,
  text-id, text-code, actor-role and mirrored-RAM includes (`hardware.inc` is CC0).
- `data.manifest` — offset/length/spec list `tools/extract.py` slices the
  base ROM by; `data.previews` — which planes, tiles and palettes make up
  each scene, for the preview pictures.
- `docs/` — `STATUS.md` (current state), `history.md` (the dated log),
  `match_engine.md`, `story_mode.md`, `screens_and_ui.md`,
  `graphics_formats.md`, `actor_script.md`, `sound_engine.md`,
  `save_format.md`, `ram_map.md`, `bank0_notes.md` (one subsystem each),
  `bugs.md` (defects in the game, with dead stores and stubbed routines kept
  apart), `unused_code.md` (the unreferenced code and its patterns),
  `duplicated_code.md` (the live routines that exist as identical copies).
- `tools/` — the codecs, the extractor and the checks (below).

## Editing

`src/`, `ram/` and `include/` are the source: a name, a note, a union
variant or a table layout is changed there, and `make` is the whole
pipeline. Every instruction still carries its original address in a
trailing comment (`; $4719`), which is the key the docs use and the address
to break on in an emulator running the original cartridge. It is a record of
where the instruction came from, not something the assembler reads: once an
edit changes a bank's size the comments after it are the original ROM's
addresses, not the build's, and a moved or inserted instruction can simply
do without one. No tool takes them as build addresses -- the runtime tools
place a line relative to its nearest label in the build's symbol file and
skip a stretch that has been edited (`tools/banksrc.py`, `build_addresses`).

The tree was produced by a generator — coverage traces from real runs of
the game, a conservative recursive descent, and JSON inputs holding every
name, note, union scope and data-region spec — that was retired on
2026-09-11 once nothing anonymous remained. Its last output is this
source. The generator, its inputs and the coverage captures are kept at
the git tag `generator-final`, and `docs/history.md` records how each part
of the ROM was reached.

## Tools

- `tools/check.py` (`make check`) — the structural checks a byte-perfect
  build cannot make: every LZ stream in the manifest decodes inside its
  extent and survives a re-encode, no assembled symbol sits inside a
  stream, the extracted regions do not overlap, no routine sits inside an
  actor script's label scope, no new conditional branch targets the
  instruction after it, no ROM address is written as a number, every DMA
  source is aligned, every PNG, tilemap grid, sound track and trajectory
  table encodes back to its blob, every actor-slot name holds in each list
  that can be active where it is used, and every `Unused` name agrees with
  `tools/reach.py`.
- `tools/linktest.py` — two copies of the game in PyBoy joined by a link
  cable made of hooks on each game's own serial code (PyBoy's port is
  unplugged), playing through the link handshake, rules and character
  select into a link match; `--keys` picks the random presses,
  `--unplug-after` pulls the cable, `--steer` forces the way to one
  routine, and `--coverage` merges the routines entered into an eventtest
  coverage file.
- `tools/reach.py` — which routines can run at all, following every
  reference from the reset, interrupt and `rst` vectors; `make check`
  holds the `Unused` names to it, and `--coverage` sorts the routines a
  sweep never entered into unreachable and not-yet-reached
  (`docs/unused_code.md`).
- `tools/steer.py` — runs the reachable routines no session entered, by
  replaying a session (`eventtest.py --units`) that entered a routine above
  one and forcing each branch, jump-table index and table jump on the way
  down to it; everything else is the game's own state.
- `tools/actorslots.py` — which `map_actor` list a story script addresses
  at each slot operand, by following control flow through the story code
  (`docs/story_mode.md`, "map_actor"): reports the slot numbers it can
  settle and renames them with `--apply`; `--runtime` (`make slot-audit`)
  checks every name against the list active in a PyBoy sweep.
- `tools/shifttest.py` (`make shift-test`) — builds a copy with every bank
  padded and checks each changed byte is a label reference that moved;
  `--out` keeps the padded ROM and its .sym.
- `tools/eventtest.py` (`make event-test`) — plays the padded and original
  builds through every story state and location under the same inputs;
  `--free`, `--targets` and `--handlers` add main-menu, targeted-start and
  per-handler sessions, and `--coverage` and `--units` record the routines
  entered (read by `tools/coverage.py` and `tools/steer.py`).
- `tools/coverage.py` — which routines an eventtest coverage file shows run
  and never run.
- `tools/playtest.py` — plays two ROMs side by side and reports where their
  screens diverge.
- `tools/runtime_audit.py` — checks the source's claims (`Unused` names,
  actor-slot names, NpcScripts ids) in headless play.
- `tools/mods.py` — copies `mods/` over `data/` and collects edited data
  files into `mods/`.
- `tools/snd.py` — the sound-script codec.
- `tools/banksrc.py`, `tools/deps.py` — a bank's source read whole for the
  tools; the build's dependency list.
- `tests/` (`make test`) — the codecs, every idiom macro assembled and
  compared to the bytes it stands for, the extractor's `--keep`, and pins on
  the source (idiom, sound-id, VRAM-name and copy-length counts) that a
  hand-written raw form would move.
- `tools/ram_free.py` — the RAM bytes no symbol covers, the static half of
  the free-RAM inventory in `docs/ram_map.md`.
- `tools/ramaudit.py` — the runtime half: `free` poisons every byte
  `ram_free.py` lists and plays a flow (an eventtest target, a story chunk,
  a link session) twice, poisoned and clean, reporting the bytes that hold
  data and any read of poison; `writer` names the routine that first writes
  a given byte.
- `tools/twins.py` — the groups of instruction-identical live routines
  (`docs/duplicated_code.md`).
- `tools/lz.py` — codec for the game's LZ format, both directions; the
  encoder round-trips every stream in the ROM.
- `tools/gfx.py`, `tools/tilemap.py` — the PNG and tilemap-grid codecs
  `make` runs when an image or grid is edited.
- `tools/strings.py` — lists the game text by bank and string index from
  the extracted text source (`--index`), or scans a ROM for strings.
- `tools/savetool.py` — battery save inspector and editor.
- `tools/gfxdump.py` — PNG contact sheets of the graphics streams and palette
  regions, under gitignored `data/gfx/`, for identifying assets.
- `tools/extract.py` — `data.manifest` + base ROM → `data/`.
