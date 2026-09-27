# Project status — 2026-09-27

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
| labels (counted 2026-09-12) | 21,979, of which 20,399 human-named and 1,580 derived (`FarPtr_*` slot labels, `SoundTable_*`); 0 state only an address |
| data blobs (`INCBIN`) | 4,218 — 838 LZ streams, the rest raw graphics, tilemaps, sprite frames and sound |
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
| `docs/unused_code.md` | the 209 unreferenced routines and 100 blobs, and the eight patterns they fall into |
| `docs/bank0_notes.md` | the ROM0 helpers |

## What is still open

**Banked-WRAM operands: none left in live code.** A `$dxxx` literal whose
WRAM bank neither static dataflow nor any trace has pinned renders as a raw
number, because a name in the wrong bank is worse than none. The 97 that
remain all sit in `Unused*` routines: nothing references them, so no trace
can ever prove them, and they are left raw on purpose. The last live ones went three ways — a callee that
selects the bank itself (the story scripts' actor-slot pointers handed to
`AttachActorStepMover`, the digit drawers' `wram_bank $03`), which the
unions express as instruction-range scopes; siblings behind a jump table
whose traced twins prove the bank (ranking rows 9-11, doubles markers 5/6,
which no `ShowRankingBoard` argument ever selects); and one arithmetic
constant. The generator's last run reported no site whose bank the dataflow
knew but no union named.

**Named in the docs as not established.** `docs/graphics_formats.md` §8 now
holds two items, and both are about the developers' intent rather than the
bytes: why the `$63` per-object-palette sentinel exists when no object uses
it, and why there are two additive fades. Everything else there was settled
on 2026-09-11 (the odd palette regions were over-declared, the header bytes
are a constant, the scene record is read only to `+5`); `docs/story_mode.md` "Oddities
and open questions" keeps only the shipped-defect entries (the Star Court
unlock and the dead record fields are resolved); the "not established" sentences in `docs/match_engine.md`.

## How to resume

The source is edited directly: a name, a note, a union variant, a table
layout or an instruction is changed in `src/`, `ram/` or `include/`, and

```
make clean && make -j compare && make check && make test
```

is the whole pipeline (`compare` holds until the first deliberate change to
the bytes; `check` and `test` hold after it). `make shift-test` builds a
copy with every bank padded, and `tools/playtest.py` (needs PyBoy) plays it
against the original. `tools/strings.py --index
--bank <bank>` reads a text id; `tools/gfxdump.py` draws contact sheets of
the graphics streams and palette regions into gitignored `data/gfx/`;
`tools/twins.py` lists the routines a fix has to land in more than once;
`tools/ram_free.py` recomputes the free-RAM inventory after the RAM
declarations change.

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
unaligned DMA source, a PNG or grid that no longer encodes to its blob.

## Recent changes

* **2026-09-27** — a runtime audit. `tools/runtime_audit.py` (needs PyBoy)
  plays the game headless from a save -- every story location entered at
  each of its entry points through the game's own `$ff` reload request, then
  walked about at random, and a long random session from the Test map,
  whose debug NPCs launch story matches -- with hooks that check the
  source's claims against what runs. On 3.5 million frames: none of the
  206 `Unused*` routines executed; every actor-slot name reached (1,553
  distinct script sites, about 19,700 executions, and 164 NPC talks) ran
  under a list holding the same actor in that slot as the list its name
  comes from, with no disagreement; and the character records loaded were
  the ones their constants say (the drill partners for their drills, Mark
  and Ellis for doubles Varsity #2, `$5b`/`$5c` for Dream Match Hard and
  Intense). `$5b`-`$60` are now `CHAR_DREAM_HARD` ... `CHAR_DREAM_DOUBLES_MAX`.
  A record the audit saw load during Net Game Match 1, `$54`, led to
  LoadDrillOpponentBySide: the net-game and stroke match drills swap the
  opponent's record by server at every point, which a hook on it confirmed
  (the player serving loads the drill's own partner, the opponent serving
  `$54`). `$54`-`$56` are `CHAR_DRILL_NET_GAME_MATCH_n_SERVING`, `$58`/`$59`
  `CHAR_DRILL_STROKE_MATCH_n_RECEIVING`; `$57` is Stroke Match 1's empty slot.
  Coverage is what random play reaches: scenes gated behind story states
  the save is past (most of the ranking-match intros and victory scenes,
  `AcademyWingInitScript_10`'s stage branches) never ran, so the ~600 actor
  slots still written as numbers were not resolved this way.
* **2026-09-27** — the padded ROM boots and plays. Running it (BizHawk,
  then headless PyBoy) found what the static checks could not. It hung
  before the Nintendo logo because nineteen tables were addressed as
  split-base `add $lo / ld l, a / adc $hi / sub l / ld h, a` with raw
  operands (fixed in the previous commit). Then the main menu's caption box
  came out garbled: VRAM DMA ignores the low four bits of its source, so
  graphics the game copies straight from ROM must stay 16-byte aligned, and
  a 3-byte shift misaligned them. Every aligned uncompressed graphics or
  tilemap blob and every direct DMA source (2,363) now has `ds ALIGN[4]`
  before it -- no bytes today, padding after an edit -- and the `dma` check
  fails on a DMA source without one. `tools/playtest.py` runs a ROM and the
  original side by side in PyBoy under one seeded input sequence from a
  save and reports persistent screen mismatches; the fully padded ROM
  agrees through the intro, title, menus and into an exhibition match
  (11,000 frames), apart from transient timing drift: a shifted build is not
  cycle-identical, since page-crossing lookups and lag frames move.
  `shifttest.py` takes `--banks` and `--out`, maps each byte through the
  symbol tables (the shift is 3 before a bank's first alignment and 16
  after), and needs 18 free bytes to pad a bank.
* **2026-09-27** — a correction to the 2026-09-12 music names. The match
  settings tables are indexed by story match (`STORYMATCH_*`, new: the
  class rankings counting down to #1, the Island Open rounds, the three
  Dream Matches), not by `MINIGAME_*` id as their row comments claimed, so
  the seven tunes named from those rows were wrong: they are
  `BGM_PRACTICE_MATCH`, `BGM_JUNIOR_RANKING`, `BGM_VARSITY_RANKING`,
  `BGM_ISLAND_OPEN` (and `_SEMIFINAL`, `_FINAL`) and `BGM_DREAM_MATCH`. The
  real drill, machine and wall tunes come from the drill definitions, now
  `drill_def` rows in both banks (`$0b`'s eighteen training drills and
  `$0d`'s eighteen minigame and room configs, seven of which had been
  decoded as instructions): `BGM_DRILL_MATCH`, `BGM_DRILL_PRACTICE`,
  `BGM_TENNIS_MACHINE`, `BGM_WALL_PRACTICE`, `BGM_TARGET_MINIGAMES`. The
  drills' opponents are records `$37`-`$48`, `CHAR_DRILL_*`; the 70
  `load_match_settings` calls name their match.
* **2026-09-27** — a pass over known values the source still spelled as
  numbers. Struct fields: `ACTORF_*` (the actor record, with its flag and
  status bits — heading at `+$14`, facing at `+$34` following it unless
  locked, the drawn `FACE_*` at `+$32`), `CHARREC_*` (the `$40`-byte
  character record, the eleven stats by name) and `OBJSLOT_*` (bank `$09`'s
  object slots), about 330 sites. Ids: the extended character ids
  `CHAR_RANKER_32`-`47` and the six named opponents (their own names in the
  roster's name pool, though RemapExtendedCharId shows them as roster
  characters), 97 more text ids (the challenger dialogue, base-plus-offset
  loads, the ranking boards' name tables), the bank `$04` actor lists as
  `map_actor` rows, `as_set_field`'s selectors (actor record offsets). Two
  corrections: `script_facing_lock`'s operand was a lock flag, not a facing
  (now `script_lock_facing` / `script_unlock_facing`), and the actor-field
  opcode handlers reached `ActorFieldTypeTable_04` through a split `add $fd`
  / `ld a, $47` / `adc $00` that `literals` now catches. `$c780` is
  `wModeScratch`. Left as numbers on purpose: animation ids (what id 3, the
  common one, depicts would need the frames identified), the unnamed
  character records `$36`-`$63`, and slots that more than one actor list
  could fill.
* **2026-09-27** — actor slots are named by row. `map_actor` takes a
  ninth argument, and the macro defines `ACTOR_<name>` as `3 + row` (a row
  whose condition fails still takes its slot, so row order is the slot map).
  All 79 lists name their rows after location and object, and 4,153 slot
  numbers in the story scripts and `NpcScripts` tables became names where
  the active list is certain (`docs/story_mode.md`, "map_actor"); about 600
  stay numbers because more than one list could be active.
* **2026-09-27** — the last hardcoded ROM addresses. A scan for ROM
  addresses written as numbers (4-digit literals in address operands,
  split `LOW`/`HIGH` halves, literal banks beside cross-bank labels, and
  label-valued words inside the untyped blobs) found three. The Training
  Gym joggers' actor scripts made 96 `as_call`s to `$4c8e` and `$4ce5`,
  two unlabelled wait routines inside `Unused…ClearWaypoint` bodies: they
  are `TrainingGymRunner0BWaitWaypointClear` and
  `TrainingGymRunner0CWaitWaypointClear`, and the tail all three waits jump
  to, filed as `.checkTimer` under an unused label, is the proximity test
  `TrainingGymRunnerCheckClearance`. `VramTileset_09`'s 29 source words
  are offsets into `TilesetTiles_09`, and six rows of
  `TilemapAssemblyDispatch_39` point one byte past the last rect list
  (`.pastEnd`). Everything else the scan raised was coordinates, sizes,
  colours or text ids.
  A `make check` class, `literals`, now fails on a numeric `jp`/`call`
  target, a number in a macro argument that elsewhere always takes a label,
  and an `ld rr`/`dw` literal equal to a same-bank label. Its first run
  found `StrokePractice2Hooks`, the one drill hook table still decoded as
  instructions (`call c, $e06d`), now eight `dw` rows like its siblings. The
  `$4000` slot encodings `farcall`, `dslot` and the new `ld_slot` (33
  `(BANK(x) << 8) | LOW(x)` loads) assert their label is in the slot table,
  since only its low byte is stored.
  `make shift-test` (`tools/shifttest.py`) rebuilds a copy with 3 bytes of
  padding at the top of every bank with room (123; the five full data
  banks `$2f`, `$64`, `$68`, `$69`, `$7f` stay put) and checks every byte
  that changed is a moved reference: 43,694 low bytes and 157 carried high
  bytes, nothing else. It cannot see a hardcoded address (those bytes do
  not change), which is what `literals` is for; booting the padded ROM it
  leaves behind is the remaining proof, not yet done. The twelve slot
  lookups in bank `$00` load `h` with `SLOT_TABLE_PAGE`, the constant the
  asserts check against, and no ROM table is indexed without carrying into
  the high byte, so none depends on staying inside a 256-byte page.
  Going through the slot consumers turned up 117 more hardcoded slots:
  `ObjectIdList_04` stored `db slot, bank` bytes into banks whose slot words
  had no label, so a shifted build would have loaded the wrong header for
  every object without a byte of the diff changing. The character banks'
  and walk-sprite banks' slots are labelled, the list is `object_id` rows
  defining `OBJ_*` (`docs/graphics_formats.md` §4.3), and every `map_actor`
  row, `script_set_objdef` and object load names its object. The table the
  generator had called `TileIdLookup` is `CharObjectIdTable`, the game's own
  map from `CHAR_*` to walk sprite, which names 31 of them. Seven menu
  label-tile tables and four `FarCallVector` calls held raw slot pairs too;
  they are `dslot` rows and `ld_slot` loads, and `literals` fails on a
  numeric `hl` handed to any slot consumer.
* **2026-09-12** — the last unnamed sound ids. The ids carried by tables
  rather than `sound` sites are named for what they accompany: the seven
  drill and lesson themes the match-settings tables select
  (`BGM_TRAINING_DRILL`, `BGM_SERVICE_DRILL`, `BGM_STROKE_MATCH`,
  `BGM_STROKE_PRACTICE`, `BGM_TENNIS_MACHINE_A/B`, `BGM_WALL_PRACTICE`),
  the three story-location themes (`BGM_ACADEMY_BUILDING`,
  `BGM_ACADEMY_OUTDOORS`, `BGM_ACADEMY_ROOMS`) and the `BGM_UNCHANGED`
  sentinel, the six on-court cues the object templates play
  (`SFX_SCORE_DISPLAY`, the five `SFX_BANNER_*` by banner row) and the two
  level jingles. `SFX_RANKING_MARKER` is `SFX_MARKER`: the same cue lands the
  score digits and a banner. The court-select music rows and the two raw
  `wMatchBGM` stores use the names too.
* **2026-09-12** — the minigame point tables and the drill gate tables have
  named fields. The eight `*PointTable`s are the court-position record shape
  (`court_positions`, one row per point; the old rendering had split each
  record in half), with their `$ff` terminators already carved as one-byte
  fills. The eight `*PointStartDrillPositions` tables are `drill_gates x1,
  depth1, x2, depth2` rows, the two ball-gate points `IndexDrillTableByPoint`
  sets per point, ending on `$ff, $ff`.
* **2026-09-12** — the match-screen object templates have named fields.
  Bank `$09`'s seven `*ObjTemplate*` tables (45 records: the score display,
  the serve indicators, the win/lose result, the 29 court banners) render as
  `obj_template x, y, sprite_template, update, curve, exit_update,
  exit_curve, sound, draw_mode`, the layout read from `LoadObjTemplate_09`
  and `StartObjExitAnim`. Their update-routine words were entry points
  inside an unlabelled tail of `FinishObjSlotUpdate`, now `ObjUpdateShow`,
  `ObjUpdateHide` and `ObjUpdateRunCurve`; and six of their sprite-template
  words pointed into the last 24 bytes of the `ServeGfxPtrTable_09` blob
  and part-way into the region after it, which turned out to be one
  8-row column template entered at different rows to draw fewer objects
  (`ObjColumn8SpriteTemplate_09` with `.rows7`-`.rows2` entries), followed
  by two more templates the generator had left as raw bytes. The blob is
  24 bytes shorter and the three templates are rows.
* **2026-09-12** — four more table families have named fields: every story
  and minigame match's settings (`match_settings mode, opponent, court,
  sets, games, bgm`, the two 25-row tables, each row commented with its
  `MINIGAME_*` id), the training drills' per-outcome rows (`drill_outcomes`,
  38 tables indexed by `POINTOUTCOME_*`), the six court-position record
  tables (`court_positions`, the four `wCharCourtPos` codes then the four
  `wCharServeRole` codes) and the Target Shot scoring rules (`score_rule`).
  The remaining raw tables are a long tail of screen geometry, sprite offset
  lists and per-screen scratch, worth a macro only when someone edits one.
* **2026-09-12** — polish across the tree. 77 fragments whose dominant-word
  names misled were renamed for what they hold (`vectors_00`, `vblank_00`,
  `decompress_00`, `trig_00`, `boot_01`, `courtselect_3e`, `dictionary_3f`,
  ...), the bank `$03` save routines moved under `src/engine/save/` and the
  sound note trigger under `src/audio/`. The docs' `file:line` citations
  are file names only; the routine each sentence names is the stable key,
  and the address comments give the original location. The two
  `ShotBallPath` pairs share a source through a third macro form,
  `twin_in file, Label, bank`, leaving four copies separate (the Island
  Open NPC scripts). `hSndPortamentoTimer` is `hSndNoteTimer`: the note
  command's length operand sets it. The debug test menu needs no build
  flag: `InitAndRunGame` sets `SAVEFLAG_DEBUG_TEST_MENU` when A is held
  at boot.
* **2026-09-12** — the trajectory tables are source. The fifteen
  ballistic-solution tables of the nine shot banks (15,360 bytes each in
  the four stroke banks, 7,200 in the three serve banks, the lob, drop,
  fallback, neutral, reach and three stretch tables) are extracted to
  `data/bank_02x/<Table>.asm` as `traj_row` / `traj_row4` rows with block
  separators where the offset tables index in 64-row blocks, and the five
  small offset blobs of bank `$24` as `dw` rows; the banks `INCLUDE` them.
  `make check` (`traj`) proves each renders back to its bytes.
* **2026-09-12** — WRAM bank switches say what they reach for. The 1,725
  `wram_bank` / `push_wram_bank` sites use `WRAM_*` constants: the bank's
  owner (`WRAM_STAGING`, `WRAM_COURT_PLANES`, `WRAM_SCREEN`, `WRAM_ACTORS`,
  `WRAM_TEXT`, `WRAM_SCENE`, `WRAM_SOUND`) or, where the code goes on to
  touch the on-court character struct at `$df00` (or is a bare switch in
  the match engine), `WRAM_CHAR0`-`WRAM_CHAR3` for banks 4-7. Same
  numbers, so the bytes are unchanged.
* **2026-09-12** — a fork can commit its edits. `mods/` mirrors `data/`:
  an edited PNG, grid, text file or track lives there at the same relative
  path (tracked), and `tools/mods.py apply` copies it over `data/` before
  every `make` (at Makefile parse time, so no target races it) and after
  every extraction; `tools/mods.py collect baserom.gbc` brings every file
  edited in `data/` into `mods/` by comparing against a fresh extraction.
  ROM content stays out of the repository; only the fork's own changes go
  in.
* **2026-09-12** — the sound scripts are source. Reading the driver
  settled the format: every command is two bytes and the interpreter
  steps by command index, the one four-byte command (`$ac`) carrying a
  byte offset from the track's start; loops go through per-channel slots.
  All 315 channel scripts decode over exactly their extents, and
  `extract.py` now renders each to `data/bank_07x/<Track>.asm` as `snd_*`
  macro rows (`snd_note C#, 3, 8`, `snd_call 2, .call0`; noise-channel
  tracks as `snd_noise`), which the sound banks `INCLUDE` in place of the
  `INCBIN`s. `tools/snd.py` is the codec, `make check` (`sound`) proves
  the round trip, and `docs/sound_engine.md` has the command reference.
  Eight tracks end on a note and run on into what follows; the rendering
  says so. The emulator gives no audio, so the command names come from
  what the driver does with each operand, not from listening.
* **2026-09-11** — the scene blob families are named after their scene.
  Each of the 37 scenes' blobs (config, palettes, tiles, tilemap, attribute
  map, collision and behaviour maps, and the `DataPtr_` slots and aliases)
  now carry the `SCENE_*` name in CamelCase, in the source, `data.manifest`,
  `data.previews`, the extracted `data/` files and the docs: 440 labels.
  Nine families had been named by a wrong visual guess (`SpaResort*` was
  the restaurant, `CeremonyHall*` Peach's Castle, `Countryside*` the
  restaurant plaza, `Clubhouse*` and `Courtyard*` the two minigame courts,
  and the `HardCourt`/`CompositionCourt`/`PracticeCourt`/`IslandOpenCourt`
  families were the training, hard, composition and wall-practice courts);
  the rest were renamed for consistency (`YoshiCourt*` → `TropicsCourt*`,
  `CafeCourt*` → `Court1*`, `StadiumGrounds*` → `CenterCourtMap*`, ...).
* **2026-09-11** — the twin families share one source. 60 families, 271
  of the 279 instruction-identical live routines, are now one file each
  under `src/twins/`, assembled into every member bank through
  `twin file, <bank>` (labels and bank-local references take the bank
  suffix through `{TWIN}`) or `twin_named file, Label` for identical bodies
  under different names. The bytes are unchanged; the shared bodies drop
  the per-instruction address comments and the `twin` line carries the
  copy's start. Three labels gained the suffix their family used
  (`FetchTextTable_1f`, `DrawAsciiDigitString_1b`,
  `SpriteWobbleXTable_17`). Eight copies stay separate: the two
  `ShotBallPath*` pairs reference different tables under different names,
  and four Island Open NPC scripts differ only in a text id, which the
  twins tool had mistaken for a bank suffix (fixed). Also fixed: the split
  commit had left `src/data/` untracked because `.gitignore`'s `data/`
  matched it; the pattern is now anchored and the 76 files are in.
* **2026-09-11** — the source is split by subsystem. Each
  `src/bank_XXX.asm` is now a holder — the `SECTION` line, the
  decoded-length includes, and an ordered `INCLUDE` list — and the
  contents live in 400 fragment files under `src/home/`,
  `src/engine/<subsystem>/`, `src/story/`, `src/audio/` and
  `src/data/<kind>/`, each named `<topic>_<bank>.asm` after the routines
  that dominate it (cut at label boundaries where the topic changes,
  400-1000 lines each; the pure data banks are one file apiece, named for
  what they hold). The bytes are unchanged, the holder's include order is
  the bank's layout, and `tools/banksrc.py` gives the tools a bank whole.
  Make dependencies come from `tools/deps.py` (`build/deps.mk`). The docs'
  `src/bank_XXX.asm:line` references were mapped to the fragment files.
* **2026-09-11** — the id pass. The big families (character, court,
  game-mode, location, minigame, shot-type, sound) were already applied
  where the generator's constants keyed them; a data-flow scan from each
  family's carrier symbol found 290 more sites, and four new families:
  `SCENE_*` (the 37 scene-table records, named for what loads them, used by
  the `story_location` and `court_scene` rows), `LINKSTATE_*` and
  `LINKMSG_*` (the link roles and the ten `$c0`-`$cd` control tokens),
  `MATCHCONTEXT_*` and `MENUSLIDE_*`; the 40 serial-control writes use
  `hardware.inc`'s `SC_*` bits, and the 42 story entry-point sentinels
  `STORYENTRY_NONE`. What stays literal is mostly per-location stage
  scratch, whose meaning changes by bank, and the numbered entry points.
  The scene blob families named by visual guess were renamed the same day
  (below).
* **2026-09-11** — the tunable tables have named fields. One macro row per
  record, field order in the macro's comment: the 100 character records
  (`char_record`, each with the character's name), the racket and shoe
  bonuses (`equip_stat_deltas`), the four stat archetypes
  (`stat_thresholds`), the EXP curve (`exp_threshold`, in decimal), the
  shot-type presets (`shot_preset`, with five new `SFX_HIT_*` ids), the CPU
  difficulty rows (`cpu_difficulty`), the court surface table
  (`court_scene`, named per court) and the AI shot habits (`AISHOT_*`
  codes). Labels renamed for what they hold: `RacketStatDeltas_02`,
  `ShoeStatDeltas_02`, `StatArchetype0-3_02`, `ExpLevelThresholds_02`,
  `CourtSceneDataTable`. Also fixed `strings.py --index`, which had listed
  strings in pool order rather than text-id order since the retirement.
* **2026-09-11** — screen assets are referenced by name. The two bank
  `$39` dispatch tables define their own indices: `tileblock Name` rows
  (122) export `TILEBLOCK_Name`, `screen_asset Name, ...` rows (70) export
  `SCREENASSET_Name`, and all 153 `LoadCompressedTileBlock` sites and 38
  `LoadScreenAssetRecord` sites, plus the five cutscene id lists in bank
  `$18`, use them. The 139 tile-block copies that take the whole decoded
  block now say `Blob_SIZE / 16` (the `.inc` included at the top of the
  using bank); the 13 partial ones say which tiles of which blob.
* **2026-09-11** — the generator is retired and `src/` is the source of
  truth. A final run reproduced the committed tree byte for byte, the tag
  `generator-final` was placed on it, and `tools/disasm.py`, `disasmlib/`,
  the six JSON inputs, `coverage/`, `hooks/`, the coverage-pipeline clients,
  `sm83.py`, `progress.py`, `ram_gaps.py` and the generator's tests left
  the tree. What stayed was made independent of them: `check.py` reads
  symbols from the build's `.sym` (and dropped the text-table and curated-
  constant checks, which the assembler now makes), `strings.py --index`
  reads the extracted text source, `ram_free.py` reads
  `include/ram_mirrored.inc`, and the "do not edit by hand" headers are
  gone. From here a change to a name, note, union or table is an edit to
  the assembly.

* **2026-09-11** — every sound call names its id. The 33 ids that were
  still literal at 182 sites are named from their call sites in
  `include/constants.inc` (`SFX_NET_CORD`, `SFX_RANKING_MARKER`,
  `SFX_VOICE_YOSHI`, the two cutscene pop sounds, ...); the comments say
  where each plays, since the emulator gives no audio to say what it
  sounds like.
* **2026-09-11** — two readability changes for modders. VRAM addresses are
  named at the 760 sites a VRAM consumer takes them (`vTiles0 + $10 *
  TILE_SIZE`, `vBGMap0 + 15 * TILEMAP_WIDTH`, `+ VRAM_BANK1`), the 51 words
  in that range that are sign bits or coordinates left literal. And the
  generated palette files use a `palette` macro of four `r,g,b` 5-bit
  triples instead of `dw` words, except the five palettes whose words use
  bit 15.
* **2026-09-11** — screen layouts are editable. The 213 tile and attribute
  planes (200 of them LZ streams) carry a `tilemap:W` manifest tag and are
  extracted a second time as `.tilemap` text grids, one `tilemap_row` per
  row at the loader's width (64 for the story scroll buffers, 32 for the
  screen planes); `make` re-encodes an edited grid and recompresses it,
  `make check` round-trips all 213, and each of the 37 scenes gets a
  view-only picture composed from its planes, tiles and palettes
  (`data.previews`, `make previews`). Proving it exposed that two banks ended
  in a *labelled* `ds` fill, which left them no room to grow; a labelled
  tail is now left to the linker's padding like any other.
* **2026-09-11** — text control codes are named. `include/text_codes.inc`
  gives every byte below `$20` its `TX_*` name (player and partner name,
  the string and number argument pops, the three delays, the short-text
  code and its operand, the newline aliases and the no-ops) and the pool
  renderer writes them, so a string reads `text TX_PLAYER_NAME, " won"`
  instead of `text $07, " won"`, and a roster name inserted into a string
  is `TX_SHORT_TEXT, CHAR_EMILY`. The include is in the build prelude; a
  test round-trips a string through the renderer and rgbasm.
* **2026-09-11** — the RAM the poison run found in use is named. The
  character records' documented field groups are declared in all eight
  records (physics attributes, swing word, AI parameters, stat bars, the
  3-byte EXP accumulators, physics template, trainable levels, name
  padding), the saved-slot mirror records get their name, id, palette,
  gender and handedness fields, the flag bytes 14-23 of `wGameFlags` are
  named by content, and `wPlayer1MainExpTier` fills its gap. The rest was
  not variables: the "records" at `$c6e0`/`$c730` are the save engine's
  staging copy passing through `$c600-$c7ff`, and bank `$07` `$d2b0-$d2ff`
  is the text engine writing five glyph tiles below `wGlyphTileBuffer`
  when the pen goes negative (`docs/bugs.md`); and the four bytes after
  each character's sprite slot are `wCharSpriteSlotFrame`, the frame
  descriptor the status, results and EXP screens park there. Static
  unnamed RAM is down to 4,404 bytes: 2,591 untouched, 1,616 cleared only,
  the rest explained; nothing the poison run found in use is left unnamed.
* **2026-09-11** — the "text-engine buffers" were block clears. Checking
  every written-but-unnamed byte against all seventeen saved states showed
  the 1,455 bytes of WRAM bank `$05` (and `$df97-$dfff` of banks `$05`-`$07`,
  and 286 WRAM0 bytes) never hold anything but zero: `ResetTextWindowState`
  clears the whole bank on every text-screen init, boot clears every WRAMX
  bank, and match setup clears each character bank's `$df00` page. The
  inventory now has three classes -- untouched (2,495 bytes), cleared only
  (1,620, usable as per-screen scratch), holds data (786, the naming
  targets) -- and `wSceneTileAnimBuffer` is declared at its real 384 bytes.
* **2026-09-11** — a verified free-RAM inventory (`docs/ram_map.md`, "Free
  RAM"). `tools/ram_free.py` lists the 5,106 bytes no symbol covers; every
  one was poisoned in a savestate and seven scripted flows (menus, a
  singles and a doubles match, the Test map, the status screens, the
  lesson menu, the credits) replayed against the clean state. 2,495 bytes
  were never touched and are the list to allocate from; 2,771 were
  written, among them the second shadow-OAM page, now `wShadowOAM2`, and
  1,455 bytes of still-unnamed WRAM bank `$05` text-engine buffers; the
  story character record's undeclared fields turned out to be read. The
  top 512 bytes of WRAM0 are the stack (`STACK_TOP` `$d000`, deepest reach
  `$cf34`) and are excluded.
* **2026-09-11** — `tools/extract.py --keep`: a re-extraction that leaves an
  edited file alone (a `.bin` or generated `.asm` that differs from the ROM,
  or a PNG that no longer encodes to its blob) and deletes nothing, so the
  tree can be regenerated around a modder's changes.
* **2026-09-11** — live twins are marked. `tools/twins.py` fingerprints the
  generated source and finds 64 groups of instruction-identical live
  routines, 279 in all (the shot solver's fifteen helpers in nine banks,
  `FetchText` in thirteen, the menu-cursor library in six, story-bank
  helpers, per-minigame handlers). Every member's note names its copies,
  39 whose names had drifted apart were renamed to one base plus bank
  suffix (`MoveMenuCursorBox` is `MoveMenuCursorGrid_38`,
  `PrintNumberString_3b` is `DrawDecimalNumber_3b`), and
  `docs/duplicated_code.md` lists the groups.
* **2026-09-11** — two modding fixes. Data files are named after their
  labels (`data/bank_040/AlexSpriteFrame00.png`, `lz_MenuFontTiles_01.bin`,
  `MatchResultPalettes.asm`; only unnamed blobs keep `d_XXXX`). And VRAM
  copy counts follow their blobs: the 92 whole copies of a decompressed
  stream are `ld c, Blob_SIZE / 16`, with the decoded length in a `.inc`
  that `make` derives from the blob (`lz.py --size-inc`), on top of the 34
  raw whole copies written `(Next - Blob) / 16`; 26 partial copies say
  which tiles of which blob they take. A plain PNG now grows its blob when
  drawn past its end, and an end-to-end edit (a tile added to
  `ConfirmScreenGfx3`) rebuilt with the copy at 33 tiles.
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
