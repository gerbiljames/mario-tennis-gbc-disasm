# Project status — 2026-07-12

## Where things stand

**~125.4K instructions / 273,343 bytes of proven code (13.0% of the 2 MiB ROM)
disassembled; everything rebuilds byte-perfect** (`make compare` → OK against
SHA-1 `414ba58340a27fc27b127bc01455b32764151ff0`). 59 of 128 banks contain
code; the other 69 are data (graphics/audio/tilemaps/text) — but most of that
data is now *carved into named streams and records* rather than left as
anonymous blobs. The repo contains no ROM bytes: all data is extracted from a
user-supplied `baserom.gbc` by `./setup.sh` per `data.manifest`.

Everything below is **committed** (HEAD `7f5293b`); the whole history rebuilds
byte-perfect. Per-bank progress at any time: `python3 tools/progress.py`
(proven-code bytes, fill runs, label counts, human-named counts) and
`tools/progress.py --unnamed <bank>` to list still-auto-named symbols.

### Code structure — solved conventions

**Farcall convention:** `rst $18` + two inline operand bytes (`db slot, bank`)
dispatch through a per-bank pointer table at $4000 via the FarCall trampoline
($01b6). `tools/disasm.py` emits these as `farcall FarPtr_bb_ss` (macro in
`include/macros.inc`), renders the tables as labeled `dw` entries, and seeds
descent from every table target. This gave the cross-bank call graph.
6,441 farcall sites. **Slot names derive from curated targets
automatically**: a table slot whose function or data target is named in
`labels.json` is emitted as `FarPtr_<Name>`/`DataPtr_<Name>` (extra
slots for the same target get `<Name>Alias1`, `Alias2`, ...), so call sites read
`farcall FarPtr_ClearSpriteSlots` and data-loader notes read
`-> DataPtr_CourtDiagramTiles` — naming a target names its slot everywhere,
with no extra annotation. `infer_tables()` exploits the self-delimiting layout of
dense banks to recover unused entries (+24 KB of statically proven code).

**All rst vectors decoded** as inline-operand pseudo-ops (macros in
include/macros.inc):
- `rst $00` → JumpTableDispatch ($06c4): inline `dw` jump table, indexed by `a`.
- `rst $08` → sound/music command ($2fb3), one id byte: `sound $xx` (451 sites).
- `rst $20/$28/$30` → three commands sharing an operand fetcher ($253d) that
  reads an inline `dw` pointer into de: `rst20/rst28/rst30 $xxxx`.
- `Func_00_07c5` is a register-based far dispatcher — runtime-computed, not
  statically exploitable.

**Match-launcher stubs** (`seed_launcher_stubs`): banks $10/$0e hold runs of
uniform 14-byte functions that store a match id into
`wCurrentMinigameStoryMatch` and `farcall FarPtr_0a_5a` (the match starter),
reached via dw tables read through RAM. The rigid shape is scanned and
seeded statically (runs of 3+), and the launcher dw tables render as
labeled `ptr_words` entries — 41 stubs + a 35-entry table in bank $10's
story match-select data.

**WRAM bank switches** render as the `wram_bank` macro (macros.inc): the
`ldh [hWramBank], a` + `ldh [rWBK], a` shadow-write pair, with an optional
immediate (`wram_bank $04`) when preceded by `ld a, imm`. All 2,020 pairs in
the ROM collapse (1,596 immediate + 424 bare, e.g. after `pop af`); a
peephole in `disasm.py`'s emitter (`wram_bank_seq`) skips sites where a jump
target lands mid-sequence — none exist today.

**Twin data banks:** groups of data banks carry relocated copies of the same
bank-local helper, dispatched via farcall slot 0. Confirmed: an OAM-frame
loader in $1f/$25/$26/$30-$37/$5e/$6e (one bank per character's animation
frames); `infer_twin_tables()` fingerprints slot-0 targets by opcode shape.

Largest code banks: $08 (match engine, 99.6% code), $05, $00, $13 (story
engine), $6b, $03 (save engine), $0a, $07.

### Data banks — carved and named

- **30 character-sprite banks ($40-$5d)** named after their owners (Mario,
  Peach, etc.); $5a is the **training ball machine**, not a character.
- **Sound banks** ($0c, $78-$7f) carved.
- **Sprite/object banks ($6a, $6f, $70-$77)** fully decoded from bank $04's
  $4f75 dispatch table: each record is a 16-byte header (count/flags + `dw`
  body pointers), an inline `.frames` pointer array to its 16x16 frame
  graphics, and an `OamPtrs` array to per-frame OAM sublists. All 92 records'
  header/array structure renders in-source; only the leaf frame-graphics and
  OAM bytes stay as gitignored blobs. `disasm.py`: `add_object_header_slots` /
  `split_object_bodies` / `follow_oam_arrays` / `follow_frame_arrays`.
- **Bank $2d is the trig ROM**: `SineTable` ($4000, 2048 words,
  sin(i*pi/2048) in 1.15 fixed point over a half turn) and `CosecantTable`
  ($5000, 2048 words, 0.5/sin clamped to 1.0). Consumed only by the bank-0
  trig suite at $1332-$13c9 (`MulSinCos`, `MulSin`, `DivBySin`/`DivByCos`,
  and `VectorLengthFromAngle`, which picks the better-conditioned reciprocal
  by quadrant) — used by the match engine's trajectory math. Angle unit:
  256 = full turn in b, fraction in c.
- **Banks $2e/$2f complete the 3D pipeline's tables**: `ViewScaleTableA`/
  `ViewScaleTableB` ($2f: linear multiply LUTs, slopes 103/128 and 234/128)
  and `PerspectiveScaleTable` ($2e: byte reciprocal, indexed view-depth +
  $2000). `ProjectWorldToScreen` ($2d8c) combines them: screen-Y from
  A*depth + B*height, screen-X from X, both scaled by
  PerspectiveScaleTable[B*depth - A*height] — a fixed-pitch camera
  (pitch = atan(A/B) ~ 24 deg) with table-driven multiplies throughout.
- **Menu / court / cutscene graphics streams** named; `tools/gfxdump.py`
  renders PNG contact sheets of the carved LZ streams for identification.
- **Menu/status screen assets decoded**: `ScreenAssetRecordTable`
  ($39:$40f5, 70 records x 4 slot words, rendered in-source as `dslot` lines of FarPtr_/DataPtr_ slot labels — the farcall operand encoding — so records read as their targets' curated names) — each
  record is (LZ tiles, LZ tilemap, LZ attrmap, 64-byte BG palette set) for
  one full screen; `LoadScreenAssetRecord` ($39:$407e, `farcall
  FarPtr_LoadScreenAssetRecord`, 20+ sites) walks a record per screen id
  and feeds the palettes to `LoadPaletteShadow`. The records read their
  slot words through RAM, invisible to static backtracking, so
  `disasm.py`'s `add_slot_record_tables` walks the table, anchored on the curated label and delimited by proven code: +252
  proven slots across banks $17-$19/$3a/$3c-$3f/$6d etc. (7 placeholder
  records skipped). All 70 records rendered offline and identified: the
  full menu/UI screen set (title, company logos, intro attract slides,
  play-mode / exhibition / equipment selects, link screens, tournament +
  N64-tournament charts, brackets, Ring Shot HUD, rules, Varsity Team
  Chart) plus the story cutscene sets (victory poses, shop scenes, award
  ceremony, champion medal + photos) — every record's
  tilemap/attrmap/palette blob is named after its curated tile stem, and
  all palette sets render in-source via the `palettes` blob spec. The
  proven slots are also fed to `infer_tables` as ground truth: a data
  target whose bytes decode as instructions is no longer claimed as an
  unused code entry (this retracted ~230 false instructions in bank $6b
  that had eaten the title-screen tilemap/attrmap/palettes and the
  ceremony maps).
- **Match-scene graphics system mapped**: `SceneGfxSlotTable` ($0a:$59d9,
  37 records x 8 slot words, rendered as `dslot` slot-label lines) covers banks $5f-$69.
  Slot layout: +$0 scene config (camera scroll bounds -> $c329-$c32c at
  struct offset 2, plus court-line lists; second half is the mirrored
  swapped-ends copy), +$2 = 8 BG palettes (courts use 2-7), +$4/+$6 = LZ
  tilemap/attrmap (32x32 for courts, 64x64 for story maps; attrs all VRAM
  bank 1), +$e = LZ tiles, +$c dead (never read — formulaically points at
  the next scene's data or bank filler). Slots +$8/+$a are dual-purpose:
  `LoadCourtSceneGraphics` ($0a:$62f8, the match loader, verified live via
  the hook log) copies them raw as the 80-byte court parameter pair to
  wram4:$de80/$dea8 (courts point +$8 back at the +$0 config), while
  `LoadStorySceneGraphics` ($0a:$585d, the story loader, matches the
  session2 story-drive hook trail) LZ-decompresses them to wram6:$d000/$d400
  as an auxiliary 32x32 map/attr layer (collision-like for interiors).
  `GetSceneSlotPtr` ($0a:$5d0b) fetches one slot word.
- **All 18 court/scene images in banks $5f-$63 identified and named**
  (scene id: name): 0-1 ClubhouseScene/CourtyardScene ($5f); 2-5 the four
  exhibition surfaces GrassCourt/HardCourt/ClayCourt/CompositionCourt
  ($60; hard verified live); 6 MachineCourt (ball-machine training court,
  matches bank $5a's machine sprites), 7 CenterCourt, 8 PracticeCourt
  (plain fenced court w/ scoreboard; name inferred), 9 YoshiCourt (Fruit
  Fantasy fruit borders) ($61); 10 StarCourt (Shooting Star), 11
  BowserCourt (lava castle, Two-on-One), 12 WarioCourt (Treasure Box
  crates + biplane), 13 PeachCourt (Perfect Shot winged-heart panels)
  ($62); 14 IslandOpenCourt (videoboard stadium), 15 DKCourt (Banana
  Bunch), 16 StarPatternBg (star-wallpaper backdrop, loaded via the match
  loader in session1 — likely a minigame/ceremony backdrop), 17
  DormInterior (64x64 RPG interior map; slots $30-$3e of bank $63's
  32-slot table, proven by the iterative slot scan — acceptance recomputes
  table extents until a pass adds nothing, since a newly proven slot's
  target can delimit the table; the old `DormInteriorScenePtrs` numeric
  rendering is superseded) ($63). Minigame court themes match the minigame host text (Yoshi=Fruit
  Fantasy, Peach=Perfect Shot, Bowser=Two-on-One, DK=Banana Bunch,
  Wario=Treasure Box).
  Generator: curated labels now split anonymous data runs (disasm.py), so
  streams reached only through non-slot pointers carve out of blobs.
- **All 19 story-mode scene maps in banks $64-$69 (records 18-36) identified
  and named**, rendered offline full-color (tilemap + attrmap palette-select
  + tiles decompressed from the ROM). These are 64x64 overworld/interior maps
  (vs the 32x32 courts), each with a 32x32 aux tilemap/attr layer at slots
  +$8/+$a. (record: name): 18 DormBedroom (player room interiors, pink/blue),
  19 Countryside (field + cottage + road), 20 AcademyGrounds (campus court +
  buildings) ($64); 21 Seaside (ocean/island/boat), 22 HedgeCourt, 23
  ClayCourtGrounds ($65); 24 HardCourtGrounds, 25 SpaResort (pink resort), 26
  MainBuilding (grand hall + courts), 27 GardenPavilion ($66); 28
  FountainCourt, 29 CafeCourt, 30 CourtComplex (mixed courts + lake) ($67);
  31 ClubCourt, 32 StadiumGrounds (grandstand stadium), 33 CeremonyHall
  (trophy/award hall) ($68); 34 TrainingHall (Lv1-4 court-select interior),
  35 CenterCourtHall (CENTER A/B courts + pool interior), 36 ClubroomInterior
  ($69). Names are descriptive (tile-derived), not confirmed canonical.
- **Duplicate $4000-table pointer entries are alias-named.** When several
  slots point at one target (dual-purpose/dead scene slots that alias a real
  asset; defaulted fan-in ranges like bank $39's 18 slots -> `Lz_39_47ab`),
  the first entry is `DataPtr_<Target>`/`FarPtr_<Target>` and the rest are
  `<Target>Alias1`, `Alias2`, ... (`disasm.py assign_slot_names`), so every
  duplicate reads back to its target instead of an opaque `DataPtr_bb_ss`.
  158 duplicate entries across 16 banks ($39/$3a/$3d-$3f/$5f-$69/$6d) now
  carry a target-derived name; singletons whose target isn't curated keep
  their numeric slot name.
- Raw blobs are split at interior slot-table targets, overlapping copy blobs
  clipped, and LZ stream extents carved exactly (incl. the 3-byte terminator).

### Text / string system — fully symbolic

Game text renders through `text` / `line` / `page` / `done` macros with
label-based index tables. Text-bank string index tables are decoded and the
fetch stubs proven. `tools/strings.py` dumps text by bank; `--index` lists it
by bank and string-table index. Text regions are emitted as generated `db`
source under gitignored `data/`.

### Battery save format — fully reversed (`docs/save_format.md`)

32 KiB SRAM, 4 banks. Engine named (bank 3: `InitSaveHeader`,
`WriteSaveBlock`, `SaveStorySlot`, `ValidateSaveRam`, ...). Header signature
`"CAMELOTGBTENNIS\0"`, master + per-block checksums, a bank-1 mirror, block
directory, and story-slot layout (character records: name/level/11 stats/EXP)
all documented. **Global 256-bit flag array at `$a040`** holds character-roster
and mini-game unlocks. `tools/savetool.py` verifies / dumps / edits saves
(recomputing all checksums + the mirror); `savetool.py unlock` sets the flag
array to unlock every character and mini-game (verified in-emulator). Noted a
real game bug: `ValidateSaveRam`'s mirror re-check compares the wrong signature
offset, so a corrupt header always falls through to a full wipe.

## Pipeline (all working, all documented in README.md)

1. Coverage collection — two paths:
   - **BizHawk native Trace Logger** (fast gameplay) → `tools/tracelog2cov.py`
     (handles auto-split `_N.log` segments, resolves banks by opcode-byte
     matching, rejects DMA/halt-bug corrupted lines).
   - **gbc-disasm MCP connector** (autonomous driving, slower) →
     `dump_coverage` writes `coverage/<name>.json` directly from the Lua.
   Data-loader arguments are also captured at runtime (hook captures) and
   ingested as data slots.
2. `tools/disasm.py baserom.gbc coverage/*.json` — regenerates `src/` from
   coverage seeds + conservative recursive descent. Symbol sources: fixed
   vector names, `labels.json`, hardware.inc registers, and `ram_map.json`
   (RetroAchievements-documented RAM → `include/ram_constants.asm`). Fails
   early on unsupported RGBDS versions; enforces a naming-convention lint.
3. `tools/extract.py` + `make clean && make -j compare` — verify byte-perfect.

Supporting tools: `sm83.py` (opcode tables), `lz.py` (LZ codec), `strings.py`,
`gfxdump.py`, `savetool.py`, `progress.py`, `hook_client.py`, `trace_client.py`.
RGBDS 1.0.1 binaries in `tools/rgbds/` (gitignored); Makefile defaults there.

## Autonomous driving

The `/drive-coverage` skill captures the full playbook: pause_emulation for
deterministic input timing, screenshot navigation, savestate checkpoints, SRAM
safety rules, cursor-jiggle before A, serve timing, and match telemetry via
`read_memory` at $c8e0. The gbc-disasm MCP server lives at
`~/code/gbc-disasm-mcp` (uncommitted, not a git repo). If BizHawk or the MCP
server restarts, reload `lua/disasm_connector.lua` + `/mcp` reconnect.

## Coverage inventory (`coverage/`)

- `clean_session1.json` — human menu/match play (post-pairing-fix, clean).
- `native_seg*.json`, `native2_seg*.json` — two human Trace Logger sessions.
- `autodrive1.json`, `autodrive2_*.json` — autonomous drives (dictionary,
  status, Shooting Star minigame, doubles, exhibition options/camera, serve,
  match results, clay court, difficulty select).
- `story_intro.json` — human story-mode intro (145 segments, 217M traced
  instructions, 22 GB of logs unioned; +11,973 seeds). Story engine lit up
  banks $04/$05/$0a/$10-$15/$1c/$1d/$38.
- `story2_overworld.json` — autonomous story drive: save-continue, story pause
  menu, Restaurant + NPC dialogue, dorm/plaza/training maps, Harry dorm event,
  and the full **Stroke Practice drill engine** in $1d.
- `story3_drillwin.json` — human: winning the stroke-practice drill (success
  handlers in $1d) + reward flow ($1c/$1d/$1e/$02).
- `story4_servevolley.json` — human: serve-and-volley drill ($17/$15/$0b, $25).
- `story5_netplay.json` — autonomous: Net Play Practice drill (only 3 new seeds).
- `story6_restaurant_traingame.json` — human: restaurant + a training game
  ($0e/$0a/$10/$12 tennis-machine/$0d, first code in $6e).
- `story7_rankingmatch.json` — human: full junior ranking match, won ($11
  ranking flow, $16 EXP earn/distribute first code, $1e/$08/$2c/$24/$32).
- `contaminated/` — pre-fix dumps with phantom seeds; never union these.

Phantom-code cleanups since then: banks 42/43 were zero-filled farcall targets
(rejected), a misattributed seed in bank 65 was denylisted, and rst38-padding /
zero-filled farcall targets are now filtered. Build stays byte-perfect.

## Not yet covered (biggest wins first)

1. **Rest of story mode** — ranking matches beyond the first (senior/varsity),
   level-up/stat-distribution details, Wall Practice room engine, Academy Main
   Building/Wing maps, later areas (tournament, Peach's castle). (Covered:
   stroke + net-play drills, tennis machine, restaurant/cafeteria, first junior
   ranking match with EXP screens.)
2. Match-point → ceremony transition, tiebreaks, deuce.
3. Remaining minigames (locked behind story), Game Boy Tower, tournament.
4. Grass court init; 6-games/3-sets match configs; more characters.

## Annotation state

**Human-named symbols: 697 of 15,036 labels** (`tools/progress.py`; the rest
are auto-generated `Func_/Label_/FarPtr_` names). Bank 0: 56 named routines
(docs/bank0_notes.md) — FarCall trampoline, OAM DMA stub, joypad, LZ
decompressor, sound engine entries, OAM sprite queuers, SoftReset, interrupt
handlers. Bank 3: save engine (23 named, docs/save_format.md). RAM:
docs/ram_map.md (129 RetroAchievements-sourced entries plus 32
project-identified: the match ball position, renderer effect/marker state,
mode-hook table, `hWramBank`, `wMatchIsDoubles`, `wOnCourtCharCount`).
`disasm.py` now also inlines curated RAM symbols into `ld hl/de/bc, imm`
pointer setups (same curated-only rule as data labels), so 16-bit fields
read via pointer render symbolically. Data banks:
character/sound/walk-sprite/graphics streams named as above.

The match engine's **per-character WRAM-bank structs are mapped**
(docs/ram_map.md "Match engine per-character structs"): banks 4-7 each hold
one on-court character at the same `$dfxx` addresses (4/6 = near-side pair,
5/7 = far-side pair; `ForEachCharBank` $6a3a iterates them). Known fields:
24-bit fixed-point X/depth/height at `$df00/03/06`, state machine at `$df18`,
walk targets at `$df46/48`, velocity at `$df40`. 15 routines named around
this: the walk-to-target loop (`MoveCharTowardTarget`/`CheckCharNearTarget`),
char state/facing/placement setters, and the point-end doubles-spacing chain
(`StartPointEndReactions` → `SpreadTeammateTargets` → `ComputePairSpread`,
which spreads a team pair's target depths $200 apart, min $100 from the net).

The **match sprite renderer is mapped** (docs/ram_map.md "Match renderer
sprite slots"): everything on court funnels through 4-byte slot records
`[tile, attr, Y, X]` ($ff = empty) cleared per frame by `ClearSpriteSlots` —
ball / ball shadow / trail slots at `$de00+` (bank 4), per-character sprite +
airborne-shadow + standing-shadow slots at `$df80+` — flushed back-to-front
by `DrawActorsByDepth` using the `$df96` depth keys. The ball keeps a
6-record position history ring at `$dd00` for the trail afterimages
(`BallTrailPalettes` at $50dc colors them by shot type). Direct-draw effects
(hit spark, special-shot flash, bounce dust, lob landing marker, training
target zone, off-screen arrows) and the per-mode draw hook
(`SetModeHookTable`/`CallModeHook`) are named too — 38 routines in this
pass, plus the bank-0 OAM queuers (`QueueSprite`/`QueueSprite16`/
`QueueSpriteTemplate`) and `TickTimer`.

Bank $08's 39 embedded blobs were classified (data table / stranded code /
padding). The ~281 bytes of code stranded behind computed jumps were recovered
as static seeds (`coverage/bank08_static_code.json`), taking the bank from
94.7% to 96.4% code. The 24 genuine data tables were then structured via
`data_tables.json` render specs (a `records:2` jump table, `records:4/5/8` and
`bytes:4/8` lookup/record tables) — `disasm.py` now renders these inline as
committed `db`/`dw` in the bank `.asm` (not gitignored INCBIN blobs). Strides were verified against the reading code where a direct
`ld hl,$xxxx` exists (e.g. `$709b`/`$70b4` are indexed `hl + i*4`; `$55a0`
strides by 5); tables reached only through computed pointers (`$5dc4`,
rendered `bytes:4` as a 25×4 grid) got their stride from the byte layout.
`$7a9d` was split into its two structures — a 16-entry `dw` pointer table and
its 32-byte payload (4×8-byte rows; the pointers land on rows +0/+8/+16/+24) —
by teaching `disasm.py` to end a data segment at any mid-run `data_tables.json`
key, so one region can hold back-to-back tables.

**Bank $08 now has zero data blobs — every byte is committed source.** The
last four INCBINs fell to three fixes: (1) a 672-byte region at `$4979` that
had been *misdecoded as code* was reclassified — the rst $00 jumptable at
`$4836` has only 4 live entries (index = char count - 1), but the parser had
extended it over the 8 dead pointer bytes at `$483f`, seeding descent into
data. `parse_jumptables` now stops at any declared `data_tables.json` offset,
and the region renders as the **court-position tables**: `GamePositionPtrs`/
`TiebreakPositionPtrs` (per-char-count `dw`, read via split add/adc at
`$480c`/`$48cd`) into `GamePositionTables` (3 blocks x 4 games x 8-byte
records) and `TiebreakPositionTables` (3 blocks x 24 points x 8 bytes); each
record is 4 per-char `$df0a` position codes + 4 per-char `$df09` serve/side
codes, applied by `AssignCourtPositions`/`LoadPositionRecord`. (2) Two
stranded `ret` bytes (`$6957`, `$6d26`) joined the static code seeds. (3) A
$ff run that reaches the bank end is now emitted as `ds` fill regardless of
length (previously needed 64+; this also converted short trailing fills in
13 other banks).

**Bank $3b got the same treatment — zero blobs, 98.0% code** (was 77.8% with
67 blobs). Blob classification found ~1.6 KB of genuinely stranded code (70
static seeds in `coverage/bank3b_static_code.json`): sprite-row renderers
calling `QueueSprite`, a 529-byte cursor/menu handler at `$41a8` reading
`$cb04/$cb05`, `wram_bank $03` helpers, and functions reached only via
`ld hl, addr` + `jp hl` dispatch (e.g. `$6cac` loads `$6f5b`). The other 65
regions were structured via `data_tables.json`: WRAM `dw` pointer lists,
self-referencing pointer-table + payload pairs, OAM sprite-template rows
(`bytes:4` with `$80` terminators), 16-byte permutation tables, and small
byte lookups; mixed blobs (data + code + data, e.g. `$5278`, `$734f`,
`$79b6`) were split at exact boundaries. First semantics are in: the shared
**menu cursor system** (`MoveMenuCursor`/`MoveMenuCursorRepeat` on
`wMenuCursorX/Y`, fed by `hInputPressed`), the stat-number printer
`PrintNumberRightAligned` (36 call sites in bank $16's match-stats code),
and the **star-unlock records**: `RecordExhibitionVictory` keeps a 9x9
best-victory matrix (Mario cast vs Mario cast, scored by difficulty via
`VictoryScoreTable`) in a save block, and `UpdateStarUnlocks` awards a
star when a character has beaten all eight others. Bank 0 gained the
banked **frame-task registry** (`RegisterFrameTask`/`ClearFrameTasks`,
`wFrameTasks` at $c1c0, gated by `hFrameTasksReady`) — the computed
dispatch that stranded several of the recovered callbacks — plus
`FormatDecimalNumber`, `hRomBank` ($ff95), and `hInputPressed` ($ff91).
Bank $3b's interactive screen builders (the story pause-menu 3x3 grid and
its sub-screens) still need a live BizHawk session to identify visually.

**Bank $00's remaining blobs were classified** (math tables / stranded code /
sound tables). ~679 instructions of code reached only through computed
dispatch (pointer tables, farcall trampolines) were recovered as static seeds
(`coverage/bank00_static_code.json`): `AngleFromVector` (an atan2-style CORDIC,
the inverse of the `MulSinCos` suite), six banked-dispatch trampolines
(`FarDispatchIndexed`/`FarCopyIndexed`/`FarCallIndexed1..3`/`FarReadPtrIndexed`,
each mapping a bank into `H` and calling/copying via its `$4000` table), the
world-to-screen sprite transform (`PositionSpriteWorld`/`2` — camera-subtract,
cull against 22x20 tiles, x8 to pixels, then `QueueSprite`), and the tilemap
scroll blitters (`GetScrollBufferAddr`/`BlitBGStrip`/`2`). Two of these blobs
were code with embedded data tables interleaved; descent split them at the
exact `ret` boundaries. The genuine data tables were named and, where the
stride was clear, structured inline via `data_tables.json`: `SquaresTable`
(i² for i=0..255 + an `$ffff` sentinel, used for squared-distance checks via
the `$106e` lookup — emitted as a compile-time `FOR i, 256 / dw (i * i) &
$ffff` loop, `squares` spec, since the exact integer formula rebuilds
byte-perfect), `TangentTable` (signed 8.8 fixed-point, clamped ±$7fff near
90°, read by `Func_00_1767` — kept as literal `dw` because it's a
game-generated table whose custom rounding and overflow tail no compile-time
`tan` reproduces exactly), and the sound driver's `SfxIndexTable`/
`MusicIndexTable` (split at ID $50 by `PlaySound`). The sound engine's internal
`NotePeriodTable` (12-semitone GB period values, octave-shifted then subtracted
from 2048 to form the frequency register), `SoundChannelMaskTable`, and
`SoundPitchTable` were named and structured inline (`records:2`/`bytes:16`).
The `SfxIndexTable`/`MusicIndexTable` entries index `SoundTable_$78..$7f` — the
same `(length, pointer)` format as `SoundTable_0c` — in per-sound groups of
`voices` channel records. They render through a new `sound_entry bank, voices,
record` macro (`data_tables.json` spec `sound_index`, macro in
`include/macros.inc`) instead of opaque bytes, e.g. `sound_entry $78, 4, 0`.

A second pass took bank $00 from 51 data blobs to 9. ~600 more instructions
of stranded utility code were seeded (`coverage/bank00_static_code.json`, now
68 entries) — bank-switch/dispatch trampolines, VRAM/tilemap clears, the
number/hex formatters, the interrupt-config family at `$2a1a`, and
`JoypadInterrupt` (`$0060`, a `jp JumpTableDispatch` stranded in the vector
table). Each blob was verified to decode as clean code that tiles to its
boundary and whose descent never leaks into a protected data region; blobs
holding back-to-back functions got one seed per post-`ret` entry. The
rst/interrupt vector padding now renders as `ds` (an all-`$ff` unclassified
run is fill at any length, not just >=64). `HexDigits` (the `FormatHexWord`
nibble table) and `QuarterSineTable` (a `128*sin` easing curve) were named
and structured. The 9 remaining blobs are genuine data: the cartridge
header/logo, the sprite-transform's embedded tables, small sound lookups, and
the `$3dd4` sound block.

**Banks $2a/$2b (each 4 blobs -> 1)** are twin ball-height positioning banks
called from the match engine (bank $07's `FarPtr_2{a,b}_00` -> `Func_2*_5e9d`,
dispatched the same way; their `$4002`-`$424b` helpers are byte-identical).
Each opening `$4000` "table" is a single live farcall slot followed by
stranded multiply/scale helpers, now seeded as code
(`coverage/bank02{a,b}_static_code.json`). The real pointer tables are
`BallPos{Block,Sub,Height}Offsets_2{a,b}` (`$5ebf`/`$5ebd`) — three `dw`
offset arrays into `BallPosData_2{a,b}` (`$427d`), a 7200-byte block addressed
as `[10 outer][10 sub][12 ball-height] x 6-byte position records`
(`10*720 = 7200` exactly). `Func_2*_426e`/`424c` do `BallPosData + word[table
+ index*2]`; ball height (`wBallHeight`, scaled `& $1f`) selects the innermost
record. The one twin difference: $2a indexes the outer block by `$df6f`, while
$2b hardcodes it to 0 (`xor a`), so $2b's tables sit two bytes earlier.

**Bank $10 (story match-select) — code recovered** (31.9% → 39.5% code;
37 → 27 blobs). Seeded 16 stranded code blobs + two jump tables
(`MatchSelectHandlers{A,B}_10` at `$4e6c`/`$4fc6`) and several farcall
"scripts" (`$448d` 435 B, `$4450`, `$7443`, `$7472`, `$7bfa`)
(`coverage/bank010_static_code.json`). The remaining blobs are genuine
match-select **data**: big self-referential pointer-table + record structures
(`$61b1` 3649 B, `$468d`, `$74a9`, `$5a80` — each entry a `dw` into a
`01 40 00 …`-header record, verified *not* code before declining to seed) and
`$0cXX`-valued lookup tables (`$5ddc`/`$5f30`/`$5c34`/`$5899`/`$5982`).

**Bank $13 (story engine, biggest story bank) de-blobbed** (56.0% → 70.8%
code; 29 → 16 blobs). The bulk of its "data" was **story-command handler code**
reached through four small dispatch tables (`StoryCmdHandlers{A,B,C,D}_13` at
`$4006/$4e20/$526a/$5c78`, 7-8 `dw` entries each) whose targets point into the
data blobs — seeding those targets recovered the handlers
(`coverage/bank013_static_code.json`). A second pass recovered a run of
~22-byte story-command handler stubs (`$5968-$5a1a`), farcall "script"
sequences (`$6a89`, `$43a1`, `$4357`), small routines (`$7b4e`/`$7b53`,
`$5c27`), and code behind a 5-byte pointer header (`$4ef4`). The 16 remaining
blobs are genuine story data: scene/actor records (`$472c`/`$4c7e`/`$6638`
share a `00 00 25 7b …` record header), coordinate tables, and small lookups.
See [[stranded-code-carving]].

**Bank $1b (dispatch bank) — code recovered, dispatch tables remain**
(38.2% → 45.1% code). Seeded 11 stranded handler blobs
(`coverage/bank01b_static_code.json`, function starts + internal flow targets);
the two code+data-interleaved ones (`$5f5f`, `$664b`) split correctly, leaving
their embedded tables (`$5f69`, `$6035`, `$6671`) as data. The bank's bulk is
large irregular **jump-table + inline-handler** regions (`$504e` 1219 B,
`$5856` 987 B stride-16 stubs, `$5c8d` 708 B stride-48, `$402e` resource-pointer
table) and a 2.4 KB `$446d` blob — each is a few leading `dw` pointers then
runs of handler stubs, reached via `jp hl`. These need per-table extent
analysis (or runtime coverage) to seed safely and were left for a later pass.

**Bank $1e (reward/results screen-resource bank) fully identified**
(52.7% → 61.5% code). Turned out to be a screen-resource bank: sequences of
LZ-compressed graphics streams (loaded via `ld hl,src; call DecompressData`)
and small palette sets (`call LoadPaletteShadow`, `de` low byte = palette
count) bundled per reward/results screen. Three giant opaque blobs ($4c40 2 KB,
$5be1 2.4 KB, $75a6 1 KB) were carved into **21 exactly-bounded named streams**
(`Lz_1e_*` × 15, `Palettes_1e_*` × 6) by enumerating every DecompressData/
LoadPaletteShadow source and labeling each — the streams chain contiguously,
so label-splitting yields the exact compressed length (verified against
`tools/lz.py`, e.g. `Lz_1e_4c70` = 1455 B comp / 2816 decomp). Loaders now read
`ld hl, Lz_1e_4c70` / `ld hl, Palettes_1e_4c40`, and palette sets render inline
as BGR555 colors. Also recovered the stranded handler code (bank-swap/VRAM
copiers, a farcall stub) and structured three jump tables
(`RewardSubHandlers{A,B,C}_1e`). Remaining blobs are small coordinate/OAM/
lookup tables. See [[stranded-code-carving]].

**Bank $1d (stroke-practice drill engine) — partial, careful carve.**
Recovered the clean stranded code (bank-swap routine `$4e5e` — its `$4e76`
data table correctly left as data — and the `$7cd9` `jp hl` jump table's 5
handler targets incl. `$7d0f`, structured as `DrillSubHandlers_1d`) and named
the drill's display-data tables: `DrillDisplayData_1d` (`$5c25`, 3079 B,
loaded from 7 sites, WRAM-offset records copied to `$d000`+ via
`Func_1d_4bb6`) and `DrillDisplayData2_1d` (`$77c8`). **`$57d2` (453 B) was
deliberately left as a blob**: it interleaves sprite-drawing code with inline
OAM/sprite-template data (`ld de,$591c/$5944`) with no `ret` before the data,
so static seeding decodes straight through the templates and misframes them
(a data pointer lands mid-instruction) — this needs runtime coverage to
separate, not a static seed. The remaining blobs are genuine drill data
(display records, tile-id/curve lookup tables). Net code % barely moved
because the big code region was correctly declined; see
[[stranded-code-carving]].

**Bank $38 (interactive story-screen bank) de-blobbed** (46 blobs → 37;
70.7% → 79.0% code). Its stranded "data" was menu/cursor handler code
(reading `$cb04/$cb05/$cb0e` + input `$ffd4/$ffd5`, kin to bank $3b's
pause-menu builders) reached only through computed dispatch, now seeded
(`coverage/bank038_static_code.json`, function starts + internal call/jump
targets — *not* blind per-byte entries, so trailing data tables like the
`$45ff` parameter table are left as data). Five **6-entry `dw` jump tables +
their inline handler runs** were structured and named
(`SubHandlers_38_{56c9,59ba,5c8f,5feb,69c1}`, loaded via `ld hl,SubHandlers…`
from multiple sites) and their handler targets seeded. `EnterNameText_38`
(`$7171`, "Enter Name") named. The 37 remaining blobs are genuine data: menu
cursor coordinate grids (x,y pairs), OAM/position record tables, tile-id
lists, and self-referential pointer-table+record structures (e.g. `$4695`).
Caution learned here: seeding *every* per-byte "entry" a linear decoder emits
can decode a code-adjacent data table as instructions (it briefly mislabeled
`$45ff` as `jr` code); seed function starts + internal flow targets instead.

**Bank $05 (text control-code engine) largely de-blobbed** (42 blobs → 12;
69.9% → 85.4% code). Most "data" blobs were stranded handler code reached
only through the engine's control-code jump tables (read via `jp hl` through
pointers, invisible to static descent), now seeded
(`coverage/bank005_static_code.json`, ~105 entries): bank-swap copiers,
input-wait loops, array initializers, and the per-source **text-fetch handler
stubs** (5-byte `farcall $bb:02` + `jr`, one per text bank
`$31-$37/$6e/$1f/$25/$26/$5e`). Four dispatch tables were structured inline as
`dw` and named: `ControlCodeHandlers_05` (`$548f`, 32 entries, the main
control-code table loaded by `ld hl,$548f`; its 5 leading `$c9` bytes are
no-op `ret` handlers), `DialogueTextFetchers_05`/`ShortTextFetchers_05`
(`$5c3b`/`$5cc7`, 16 each), and `TextSubcmdHandlers_05` (`$66de`). Two data
tables named: `PowersOfTen_05` (`$53a2`, 1/10/100/1000/10000 for decimal
formatting) and `HexDigitChars_05` (`$6488`, "0123456789ABCDEF"). The 12
remaining blobs are genuine data: font/glyph tiles (`$7942` 1694 B, `$6886`),
a glyph-width table (`$60cb`, id/width pairs), small parameter/word tables,
and text strings (e.g. `$67b7` "- ENTER NO -").

**Bank $07's stranded code was recovered** (14 blobs → 8 genuine data tables;
36.5% → 40.3% code). Its "data" blobs held ~600 bytes of code reached only
through computed dispatch, now seeded (`coverage/bank007_static_code.json`):
a link-cable serial-exchange stub (`$45f8`, drives `[$ff01]`/`[$ff02]`), a
match-id clamp (`$4cb1`), a sprite-field table blitter (`$5d1e`), a
delay/serial stub (`$41b1`), a ball-height guard (`$59ec`), and a
**self-contained target-zone mode implementation at `$5ea1`**: the setup
routine puts 2 chars on court, sets `wTargetZoneEnabled`, and installs a
mode-hook table (`ModeHookTable_07` at `$5efc`, via `SetModeHookTable`) plus
its FarPtr_08_4a data at `$5ff6`; the seven hook callbacks/stubs
(`$5ed2/$5ed3/$5f0d/$5f24/$5f25/$5f49/$5f4d/$5f75/$5f8e`) interleave with those
tables and were seeded around them. The 8 remaining blobs are genuine data:
`$4d21` (1088 B, indexed `$4d21 + [$ffdd]*4` by `Func_07_4cfe`),
`CharSpriteSetTable` (`$5a50`, already named), the `$5f94` mode data, and
five small lookup tables.

**Banks $20/$21/$22/$23 are four more ball-position banks** in the same
family as $2a/$2b — each dispatched from the same bank-7 shot-placement
selector (`FarPtr_20/21/22/23_00` at $58fd/$5916/…, alongside `_2a`/`_2b`),
so the selector picks one of six placement tables per shot/mode. Each is a
15360-byte position table (`BallPosData_2{0-3}` at `$427d`) addressed as
`base + heightOffset[ballHeightBand] + blockOffset[$df6f]` then a 6-byte
record. The two offset tables (byte-identical across all four banks, and to
each other's structure) are carved inline: `BallPosHeightOffsets` ($7e98, 32
words; ball height `& $1f` quantizes to 4 bands `{0, $0f00, $1e00, $2d00}`,
each = 3840 bytes) and `BallPosBlockOffsets` ($7ed8, 10 words, step $180 =
384 bytes/block). So 15360 = 4 bands × 10 blocks × 384 = 4×10×64 six-byte
records. Everything else ($4012-$424b) is stranded per-axis
coordinate-projection helper code (variants of `Func_2*_4102`: `MulSinCos`
placement, stride-4/stride-6 table search, record scale), reached only
through computed dispatch — seeded as static code
(`coverage/bank02{0,1,2,3}_static_code.json`, byte-identical helpers). Each
bank went from 5 helper-code blobs + 2 anonymous offset tables down to just
the named `BallPosData` INCBIN (94% of the bank). $2a/$2b differ only in
using a third (sub) offset dimension and a 7200-byte table.

**Bank $27** is a self-contained story presentation/cutscene: a script that
stages VRAM graphics/tilemap loads through bank $0a's DMA queue
(`FarPtr_0a_22`/`_24`, dest tile-pages `$3180`/`$3500`/`$3b00`/`$3f00`), plays
`sound $96`/`$79`, frame-delays via `Func_27_7856`, and branches on story flag
`$05.7` between two variants (the second, `$4ff0`-`$516a`, was stranded code
now seeded in `coverage/bank027_static_code.json`). Its opening `$4000` is a
12-entry `dw` pointer table (`SceneFramePtrs_27`) into 12 frame records, each
with a 6-pointer header, split across `SceneFrameData_27` (`$4018`) and
`SceneFrameDataHi_27` (`$51d0`) with the script code between; `SceneSharedData_27`
(`$785d`) is referenced by every record's tail. The exact record field layout
and which cutscene it is (flag `$05.7`-gated) are not yet pinned down.

**Bank $28** is a story-match/minigame graphics loader: a proper 9-slot
farcall table (`FarPtr_28_00`..`_10`, called from the match engine $08 and
story $06/$0d) of functions that load tiles + palettes into VRAM for the
current match (dispatched off `wCurrentMinigameStoryMatch`, `$c8f5`/`$c8f7`).
Each function decompresses an LZ tile stream (`MatchGfxTilesA_28`/`B` at
`$45e0`/`$6180`) and applies palette sets via `LoadPaletteShadow`. Three
palette blocks are carved to inline `palettes` source
(`MatchGfxPalettes{A,B,C}_28` = 10/16/9 palettes); the LZ tiles and raw
tilemap copies stay gitignored graphics blobs. The two unproven farcall slots
(`$0e`/`$10` -> `$60a0`/`$6086`, small SRAM-record copiers interleaved with
their index tables) were seeded as code.

Next annotation targets: bank $08 (match engine, biggest & densest code bank —
693 still-unnamed routines; name the now-structured tables, and confirm
`$5dc4`'s semantics via a runtime trace), bank $3b (753 unnamed routines, now
fully carved), bank $13 (biggest story bank), bank $1e, sound-command enum
for the 451 `sound $xx` sites, WRAM map expansion from ram_map gaps.

## Repo state

All work is committed (HEAD `a83f337`); every commit rebuilds byte-perfect.
Gitignored: baserom.gbc, data/, build/, tools/rgbds/, *.o, *.gbc, *.sav.
