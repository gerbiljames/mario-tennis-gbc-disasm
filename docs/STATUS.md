# Project status — 2026-07-19

## Where things stand

**~155.2K instructions / 399,700 bytes of proven code+structured source
(19.1% of the 2 MiB ROM) disassembled; everything rebuilds byte-perfect**
(`make compare` → OK against SHA-1
`414ba58340a27fc27b127bc01455b32764151ff0`). 59 of 128 banks contain
code; the other 69 are data (graphics/audio/tilemaps/text) — but most of that
data is now *carved into named streams and records* rather than left as
anonymous blobs. The repo contains no ROM bytes: all data is extracted from a
user-supplied `baserom.gbc` by `./setup.sh` per `data.manifest`.

**Every remaining anonymous blob has been classified as code, table, or data**
(see "Blob classification pass" below): a ROM-wide code-shape screen of all
5,000-odd INCBINs finds no uncarved code; what stays binary is graphics,
resource descriptors, record arrays, or fill.

Everything below is **committed** (HEAD `55bb5bf`); the whole history rebuilds
byte-perfect. Per-bank progress at any time: `python3 tools/progress.py`
(proven-code bytes, fill runs, label counts, human-named counts) and
`tools/progress.py --unnamed <bank>` to list still-auto-named symbols.

### Name the shot-type dispatch handlers (2026-07-19)

Two `$07` jump tables dispatch directly on `wCurrentShotType` (`ld a,
[wCurrentShotType]` / `rst Rst00`), so each entry is uniquely identified by its
shot-type index. Named all their targets: the 12-entry executor table at `$5445`
(applies per-type ball-height/preset/trajectory then farcalls the shot's physics
bank) -> `ExecuteShot{Topspin,PowerTopspin,Slice,PowerSlice,Neutral,Reach,
ReachPowerTopspin,ReachPowerSlice,ReachBasic,Smash,Lob,Drop}`; and the 15-entry
`ComputeShotPlacement` table at `$5165` (each loads a distinct per-type placement
sub-table from the `$4d21` blob via `LoadShotPlacementEntry`, then computes shot
speed) -> `ShotPlacement<Type>`, including the three serves
(`ServeTopspin`/`ServeSlice`/`ServeFlat`). Byte-perfect.

### Apply shot-type / joypad constants ROM-wide (2026-07-19)

Swept every bank for sites that operate on a known input value or
`wCurrentShotType` and tagged them in `constants.json` so the source reads
symbolically. Input sites were found with a straight-line taint scan: an
`ld a,[<input>]` from a standard-layout byte (`hPlayerInputFlags`,
`hInputPressed`, `hInputRepeatButtons`, `hInputRisingEdge`, `wMenuInputPressed`)
taints `a`, and the first `and`/`or`/`xor`/`cp a, n8` or `bit`/`res`/`set N, a`
before any branch, label, or `a`-write is tagged — 172 sites across banks
`$00`-`$7f` now read e.g. `bit PADB_A, a`, `and a, PADF_START`,
`and a, PADF_A | PADF_B`. Whole-nibble masks (`$f0`/`$0f`/`$f3`) are left raw —
they select a nibble, not a button. Also tagged four more `wCurrentShotType`
compares (`StartLandingMarker` lob check `$08:$52dd`, the drop/lob AI checks
`$08:$79dc/$79e3`, the smash check `$0d:$5304`).

Renamed the two AI shot-class predicates whose old names disagreed with the
confirmed codes ($0a=lob, $0b=drop): `AiIsIncomingDropShot` (which tests $0a)
-> `AiIsIncomingLobShot`, and its drop-then-lob entry point
`AiIsIncomingDropOrShortShot` -> `AiIsIncomingDropOrLobShot`. Byte-perfect.

### Joypad button constants (2026-07-19)

`$df1f` (the per-character input byte from `ReadCharPadInput`) uses the standard
GB joypad layout — buttons in the low nibble, d-pad in the high. Added `PADF_*`
(masks) and `PADB_*` (bit indices) to `constants.inc` and extended the
immediate-constant mechanism to also rewrite `bit`/`set`/`res` index operands
(the index is baked into the opcode, so it's a pure text change). Constant values
may now be expressions — tagged the shot-input aim/button sites in `$08`
(`BufferShotButtonPress`, `CaptureServeAim`, `CaptureShotAim`) so e.g.
`and a, $03` reads `and a, PADF_A | PADF_B` and `bit 4, a` reads
`bit PADB_RIGHT, a`. Byte-perfect.

### Shot-type constants + disassembler constant mechanism (2026-07-19)

Identified the `wCurrentShotType` codes by decoding the button-sequence
selection tables in `SelectRallyShotType`/`SelectServeShotType` (`$08`): the
`df16` (first button) x `df17` (second button) tables give A=topspin ($00),
B=slice ($02), A->B=lob ($0a), B->A=drop ($0b), A+B=smash ($09), a "power"
variant per doubled button ($01/$03), the ball-smashable "reach" variants
($05-$08 -> bank `$2c` ProjectShotPlacement), and three serve codes ($0c-$0e);
$09/$0a/$0b independently confirmed by the `Record{Smash,Lob,DropShot}Stat` `cp`
checks.

Added a general **immediate-operand constant mechanism** to the disassembler:
`constants.json` maps an instruction's flat offset to a named constant, and
`render_operand` substitutes it into the `ld r, n8` / `cp a, n8` operand (keyed
by exact offset, so a wrong tag fails the byte-perfect compare). Constants live
in the new hand-maintained `include/constants.inc`, preincluded for every bank
via the Makefile `PRELUDE`. Defined `SHOTTYPE_*` for all 15 codes and tagged the
7 highest-confidence sites (the four handler writes in `$07`, the three
`Record*Stat` checks in `$08`). Byte-perfect.

Also added an `enum:<PREFIX>:<cols>` **data-table spec**: it renders each byte of
a table as a constant of that group (parsed from `constants.inc`), `cols` per
row, falling back to `$xx` for unnamed values. Retyped the three shot-select
tables (`$08:$707a/$709b/$70b4`) from `bytes:4` to `enum:SHOTTYPE:4`, so the
`SelectServeShotType`/`SelectRallyShotType` button x direction maps now read as
their `SHOTTYPE_*` results directly in the source. Byte-perfect.

Identified the three serve types: `BufferShotButtonPress` masks `$df1f & $03`
into the first-button field `$df16` (A=1, B=2, A+B=3), which `SelectServeShotType`
indexes — so serves mirror the ground strokes by first button. Renamed
`SHOTTYPE_SERVE_0/1/2` -> `SHOTTYPE_SERVE_TOPSPIN/SLICE/FLAT` ($0c/$0d/$0e; A+B is
smash in a rally but flat/power on serve). Byte-perfect.

### Label bank $2c shot-placement offset tables (2026-07-19)

The three parallel `$2c` handlers at `$7281`/`$72d3`/`$7325` each do `ld bc,
<table>; call Func_2c_4250` (which indexes the table by ball height). The three
64-byte `records:2` tables (`$7293`/`$72e5`/`$7337`) were already typed but
unlabeled, so the `ld bc` sites rendered as bare `$xxxx`. Named them
`ShotPlacementOffsets0-2_2c` so the references resolve. The paired `ld hl,
$4281`/`$4e81`/`$6081` bases were the only three references into the 12 KB
`$4281` blob, so split it there into `ShotPlacementData0-2_2c`
(3072/4608/4608 bytes) — every handler is now fully symbolic. Byte-perfect.

Then named the three handlers themselves: they are slots 0-2 of bank `$2c`'s
farcall table, dispatched from bank `$7`'s `wCurrentShotType` jumptable (types
6/7/8, all gated on `CheckBallInSmashRange`) and each projecting a shot's
on-screen placement via its paired data/offset tables. Named them
`ProjectShotPlacement0-2` with matching `FarPtr_ProjectShotPlacement0-2` slots,
so the bank-`$7` `farcall` sites and the dispatch table read meaningfully.
Byte-perfect.

### Carve VarsityCourtTourCutsceneBody_13 (2026-07-19)

The 918-byte `$13:$667a` blob (reached only by dynamic dispatch, never in
coverage) was uncarved code + data. Decoded it into:

- **`DecompressVarsityCourtTourRecords_13`** (`$667a`) — loops 4x, `DecompressData`
  each LZ block into `$d000` then `QueueVRAMCopy`s `$10` bytes to `$a000+i*$100`,
  then `LoadPaletteShadow` from the trailing palette.
- **`QueueVarsityCourtTourSprites_13`** (`$66c3`) — indexes a 4-entry table and
  `QueueSpriteTemplate`s the selected sprite block.
- Two `records:2` pointer tables (`VarsityCourtTourSpritePtrs_13` `$66ff`,
  `VarsityCourtTourLzPtrs_13` `$678b`), each resolving to its four labeled blocks:
  4x 33-byte sprite blocks, 4 LZ blocks, and an 8-byte palette (`$6a08`).

Seeded the two routine entries (`bank013_static_code.json`), declared the two
tables (`data_tables.json`), and labeled every sub-block (`labels.json`). All the
data blocks stay raw INCBIN, so no LZ round-trip is needed. Byte-perfect.

### script_get_actor_state macro (2026-07-19)

Added a `script_get_actor_state actor` command: `ld a, actor; farcall
FarPtr_GetActorStateAddr` (`GetActorStateAddr`, `$0a:$4311` — returns the
actor's state-struct address, `$d000 + actor*$40`, in hl; callers copy it into
bc/de to read/write state fields). Same two-step shape as `script_wait_move`.
Collapses 132 of 136 sites across banks $0e-$15/$27; the 4 holdouts load the
actor id from `$c2b1` (3) or are a shared function entry (1). `script_set_objdef`
(which embeds the same farcall after a leading `ld d`) is unaffected — it anchors
earlier, so its 38 sites still collapse whole. Byte-perfect.

### script_wait_actor_script macro (2026-07-19)

Added a `script_wait_actor_script actor` command: `ld a, actor; farcall
FarPtr_WaitActorScriptDone` (`WaitActorScriptDone`, `$0a:$4372` — blocks the
cutscene, advancing a frame per poll until the actor's script ends, ~600-frame
timeout). Same two-step shape as `script_wait_move`. Collapses all 81 sites
across banks $0e/$0f/$11/$12/$13/$15/$27. Byte-perfect.

### Audit StoryLocationTable trees end-to-end (2026-07-19)

Walked all 42 `story_location` map_scripts pointers and, recursively, every
`map_tree` slot (294) and its sub-references. Findings and fixes:

- **Root naming:** five trees reached via `story_location` were named
  `…Scene_11`/`…StoryCmds_12` though structurally identical `map_tree`s; renamed
  to the `…MapScripts_NN` convention (the `DataPtr_` wrappers auto-derive).
- **Slot naming:** all 294 slots follow `<Base><Role>_<bank>` except the
  match-select "Test" screen, which repurposes the tree — slot 3 keeps the
  descriptive `MatchSelectHandlerTable_10` (a menu dispatch, not NPC scripts),
  and slot 6's generic `Func_10_4190` was renamed `MatchSelectInitScript_10`.
- **`map_script` handler `$12:$4ce9`:** the static-code seed sat one byte late
  (`$4cea`), so the handler decoded as data (`db $ff, $3e`) with no label. Moved
  the seed to `$4ce9`; it now carves as `Func_12_4ce9` and the leading `ld a,$00`
  folds into a `script_move_target` macro. The other 226 raw `<$4000` handlers
  are dialogue/text ids (`ShowSpeakerDialogue`), correctly left literal.
- **`map_actor` script `$11:$6e16`:** a runtime-selected variant entry point
  absorbed into `ActorScript_11_6e07`'s run; declared `actor_script` +
  `ActorScript_11_6e16` so the `map_actor` resolves symbolically.

Config-only (labels.json + data_tables.json + one seed offset); byte-perfect.
(Out of scope: 4 `map_actor` raw script refs in bank `$1a`, not reached from any
story-location tree.)

### Decode actor-script bytecode (2026-07-19)

The `map_actor` `objdef` blobs are not object-definition structs but **actor
scripts**: a 1-byte-opcode bytecode run each frame by `StepActorScript`
(`$04:$4229`), dispatched through the 22-entry handler table at `$04:$447d`.
Derived the full opcode set (operand widths confirmed by round-tripping every
blob through `rgbasm`) and documented it in `docs/actor_script.md`. New `as_*`
opcode macros + a `render_actor_script`/`actor_script` spec in `disasm.py` turn
the blobs into readable listings (e.g. a patrol loop of `as_set_pos`/
`as_wait_move`/`as_wait`/`as_jump`) with local labels at jump targets; the
relative `as_jump` back-edge assembles as `dw target - @`. Renamed
`ActorObjDef_*` → `ActorScript_*` (supersedes the "Label map_actor objdef
sub-tables" naming below). The decoder is a partial decode: it renders the clean
script prefix and emits any trailing non-opcode bytes as an `unclassified tail`
blob (five blobs; the tail bytes are *not* assumed to be code — nothing in the
traces or references classifies them yet). Corrected an over-seed: the four
`StoryCmdHandlersC_13` ($13:$526a) "handler" targets were actor-script fragment
entry points inside one blob, not code — reclassified `$585f`/`$5877`/`$5881`/
`$588b` as `actor_script`. Byte-perfect. Full reference in
`docs/actor_script.md`.

### Decode all installed actor scripts (2026-07-19)

Swept every `script_set_actor_script actor, addr` site (the macro for
`ScriptSetActorScript`): its `addr` operand is an actor script in that bank.
Labelled all 190 previously-unlabelled targets `ActorScript_*` and registered
them `actor_script`. Most are overlapping entry points into shared blobs (one
region holds ~20, like `$11:$5b14…$5d27`), so the renderer now emits a global
label reference for an `as_jump` that crosses into another entry point (fragments
fall through or jump between each other). Fixed one more code over-seed
(`$10:$741c`, a `script_set_actor_script` target mis-seeded as a jump-table
handler). ActorScript labels: 48 → 238; all 238 decode. Byte-perfect. Five
story-bank blobs decode cleanly as scripts but have **no** traceable
install/jump/call/table/`map_actor` reference (`$0e:$7ca4`, `$13:$62db`,
`$14:$78e7`, `$15:$7a23`, `$27:$4b41`) — left unclassified pending evidence, not
labelled on decode-shape alone. Also caught one pre-existing mislabel:
`SceneFrameDataHi_27` ($27:$51d0) was an install target already (wrongly) named
as frame data — renamed `ActorScript_27_51d0`. A sweep over all 238 script
targets (map_actor objdefs + install sites, literal and label operands) confirms
no other non-`ActorScript_` targets remain.

### Sprite-template spec + game-wide sweep (2026-07-19)

`QueueSpriteTemplate` ($00:$1e9d) reads 4-byte {dy, dx, tile, attr} OAM records
ended by a $80 dy byte. New `sprite_template` render spec + `oam_sprite`/
`oam_sprite_end` macros give them a readable form. `carve_sprite_templates` in
`disasm.py` auto-finds every `call QueueSpriteTemplate`, backtracks to the
nearest same-bank `ld hl, imm` that sets the pointer (rejecting cases where hl
is indexed/dereferenced first — those are pointer tables, not templates), sizes
the list by its $80 terminator, and carves it as a labeled `SpriteTemplate_bb_cccc`
blob — splitting the packed runs (e.g. bank $03's 54 back-to-back templates)
that otherwise sat in one anonymous blob. **135 templates carved across ~20
banks**; the `ld hl` load sites resolve to the labels. One dynamic-length list
with no $80 terminator ($1b:$6572, bounded by the sprite-queue cap) is left as a
blob. Match-result pair keeps curated names (`ResultSpriteTemplateLeft/Right_16`).

### Label map_actor objdef sub-tables (2026-07-19)

Every `map_actor` record's 2nd field is a pointer to an actor object-definition
(`SpawnActorFromTemplate` → `SpawnActor`), but these rendered as bare numbers. 44
distinct objdefs are referenced across the story banks ($0e-$15/$27), all shared
and unlabeled. Added generic labels for each (since renamed `ActorScript_bb_cccc`,
see "Decode actor-script bytecode" above) so the records read `map_actor $0000,
ActorScript_0f_7b57, …`; overlapping defs (e.g. `$7b2f` inside `$7b25`'s blob)
split into separate labeled blobs. Byte-perfect.

### Fix mis-seeded bank $13 map_actor lists (2026-07-19)

Two TravelingTeam `map_actor` spawn lists (loaded via `ld hl,addr; farcall
ScriptRespawnLocationActors`) each had a static code seed sitting on the *list
start* — decoding the 11 actor records as garbage code. In both cases the seed
was meant for the code that *follows* the list but was placed a list-length too
early: `$78d7` (→ init script `$797b`) and `$739c` (→ dispatcher `$7440`). Moved
each seed past its list, declared the lists as `map_actors`
(`DoublesTravelingTeamActors_13`/`SinglesTravelingTeamActors_13`), and labeled
the trailing code. Byte-perfect.

### Story-scene directories + respawn variant tables as macros (2026-07-19)

The story "scene" tables reached via `story_location`'s DataPtr
(`AcademyArrivalMapScripts_11`, `JuniorClassCourtSingles/DoublesMapScripts_11`,
`WallPracticeRoomMapScripts_12`) are each a full 7-word `map_tree` — same layout
as a location directory — but were seeded as generic `records:2` headers with
`records:8`/`bytes:14`/`bytes:16` slots. Retyped the four headers `map_tree` and
their slots `map_entries`/`map_scripts`/`map_actors`, with `<Scene><Role>` slot
labels; the arrival/handler pointers now carve as `script_*` cutscene code.

Then swept every flag-selected variant table installed at runtime — NpcScript
tables via `WriteStoryStateWord de=$000c` (map-tree slot 3) and actor lists via
`ScriptRespawnLocationActors`:

- **map_scripts (NpcScript variants):** 8 in bank `$11`
  (`JuniorClassCourt{Singles,Doubles}NpcScripts{A-D}_11`), 5 in bank `$13`
  (`VarsityCourtNpcScripts{A-E}_13`). Each `ld hl,table` dispatch now resolves
  symbolically.
- **map_actors (respawn variants):** 11 scene actor lists retagged from
  `bytes:14` (`$10`/`$11`/`$12`/`$1a`), plus ~19 more that were raw blobs across
  banks `$12`/`$13`/`$27`. The embedded ones sit inside larger uncarved code
  blobs, so a curated label at each list start (which splits the enclosing data
  run) plus a bounding label at the two chain tails not already on a
  label/code boundary keeps each list rendering as exactly its `map_actor`
  records + `map_actor_end`.
- **split fixes:** two `map_scripts` tables (`$12:$4cc0`, `$15:$505b`) had an
  interior `records:8` key that truncated the run mid-table; dropped the keys so
  every record renders as `map_script`.

All config-only (data_tables.json + labels.json); byte-perfect throughout.

### SeniorCourt story location (2026-07-19)

The `$12:$52f7` story-location map_tree (`SeniorCourtMapScripts_12`) and its seven
sub-tables were left as `records:2`/`bytes:14` raw data — the bank's other
location (`$4006`) was already tagged but this one was missed. Retyped the
data_tables specs (`map_tree` + `map_actors`/`map_entries`/`map_scripts` per
slot) and named the sub-tables `SeniorCourt<Role>_12`, so the tree renders as 7
labeled slots and the sub-tables as `map_*` macros (Actors is several
`map_actor` lists; the InitScript is code). Config-only; byte-perfect.

### Seed map-script/entry code targets (2026-07-19)

`map_script_code_targets` yields the handler/arrival-script pointers embedded in
`map_scripts`/`map_entries` tables, but it was only wired into labeling
(naming targets descent already reached). Now `main` also *seeds* them before a
re-descend, so a handler reached only through its table's indirect dispatch gets
decoded instead of falling into the table's data blob. Surgical in effect —
only `AcademyMainBldgEntryPoints_10` ($10:$74f9) had such a handler: its two
arrival scripts (`Func_10_7532`/`Func_10_7578`) were buried after the `$ff`
terminator, so the table over-ran to 197 bytes; now 57 bytes (7 records) with
the arrival scripts decoded as `script_*` cutscene code. Byte-perfect.

### script_set_actor_script macro (2026-07-19)

Added a `script_set_actor_script actor, script` command:
`ldh a,[hRomBank]; ld b,a; ld a,actor; ld de,script; farcall
FarPtr_ScriptSetActorScript` (`ScriptSetActorScript`, `$0a:$434f` — sets an
actor's script to a pointer in the current bank). Needed a new `'p'` step kind
(16-bit pointer operand resolved to a label when known). Collapses 327 of 328
sites across banks $0e-$15/$27; the lone holdout loads `de` from a table, not an
immediate. Byte-perfect.

### script_fade_in macro (2026-07-19)

Added a `script_fade_in speed` command: `ld c, speed; call BeginFadeIn`
(`$00:$1d2e`). Extended the `'C'` step kind to resolve ROM0 call targets
(cpu < $4000) as well as same-bank ones. Collapses all 218 `BeginFadeIn` call
sites game-wide. Byte-perfect.

### script_delay macro (2026-07-19)

Added a `script_delay frames` command: `ld a, frames; call WaitScriptFramesSaveA`
(`$27:$7856`, the af-preserving wrapper around `FarPtr_WaitScriptFrames`). This
needed a new `'C'` step kind in `script_cmd_seq` — a `call` to a curated
same-bank label (the existing steps only matched farcalls). Collapses all 83
cutscene sites in bank $27. Byte-perfect.

### script_copy_scene_rect macro (2026-07-19)

Added a `script_copy_scene_rect src_col, src_row, dst_col, dst_row, width, height`
command to `SCRIPT_COMMANDS`: the six `ld b/c/d/e/h/l` immediates feeding
`farcall FarPtr_CopySceneTilemapRect` (`CopySceneTilemapRect`, `$0a:$619e`, which
copies a tile rectangle between two scene-tilemap cells via `GetSceneTilemapAddr`).
Collapses all 61 call sites across banks $0e/$0f/$10/$12/$13/$14/$27. Byte-perfect.

### Bank $39 tilemap-assembly dispatch (2026-07-19)

`$39:$4e60` was a `records:2` blob (L1/L2 pointer tables) plus a separate
`bytes:6` pool of record lists. The indexer at `$39:$4e11` does a two-level
lookup: L1 table (by `b`) → L2 tables (by `c`) → lists of 6-byte
{src, dest, height, width} `CopyTilemapRect` records (height-0 terminated).
`carve_tilemap_dispatch` merges both into one `tilemap_dispatch` blob
(`TilemapAssemblyDispatch_39`); `render_tilemap_dispatch` emits the two pointer
levels as `.l2_N`/`.rl_N` locals and the records as `tilemap_rect`/
`tilemap_rect_end` macros — 24 L1 entries, 20 L2 tables, 214 record lists (6
unused slots point past the pool at the following code). Still byte-perfect.

### Bank $39 tile-block slot table (2026-07-19)

`TileBlockPtrs_39` ($39:$46b7, 244 bytes) was a `records:2` blob of bare words.
`LoadCompressedTileBlock` ($39:$468b) indexes it by `b*2` and feeds each word to
`DecompressDataFromBank` as `h:l` — i.e. each entry is a `(bank, slot)` pair into
that bank's $4000 pointer table. Retyped it as a `SLOT_RECORD_RENDERS` table (1
slot word/record) so all 122 entries render as `dslot DataPtr_bb_ss` referencing
their target slots (banks $18/$1b/$39/$3c/$3d/$3e/$3f/$6c/$6d). Registered the
three slots only reached through this table ($18:$92/$94, $3f:$78) as LZ data
slots so they resolve too.

### Bank $15 tour-scene actor list (2026-07-19)

`$15:$5c4f` was a 164-byte `bytes:14` blob — actually the `map_actor` spawn
list `TrainingCourtIntroTourScene` passes to `ScriptRespawnLocationActors`
(`ld hl,$5c4f`): 11 `{cond, objdef, x, y, facing, obj_id, anim, palette}`
records + a `map_actor_end` sentinel. Retyped to `map_actors`
(`TrainingCourtTourActors_15`); renders as `map_actor` macros.

### Bank $18 frame-task callbacks (2026-07-19)

`$18:$7a57` was a 375-byte `bytes:4` blob that had swallowed three
`RegisterFrameTask` callbacks — code descent never reaches (they're registered
via `ld hl,addr; call RegisterFrameTask`, not called): `TaskFadeInPalette_18`
(`$7a81`, steps a 16-entry palette fade from `PaletteFadeTable_18` at `$7ab5`),
`TaskDrawObjectSprites_18` (`$7b36`) and `TaskUpdateObjects_18` (`$7b6e`, object
update loops over the `$d800` table). Seeded the three entry points in
`coverage/bank018_static_code.json`; the template blob shrinks to the 42-byte
sprite template it actually is, and the palette table carves as `palettes`.

### Match-result graphics selector (2026-07-19)

`$16:$4e9d` (was a 3444-byte `records:2` blob) is the two-level table the
match-result gfx loader (`$16:$4e54`, `LoadMatchResultGfxSet`) indexes by the
remapped match gfx index: a self-delimiting `dw` pointer table
(`GfxSetPointerTable_16`) → 6-byte descriptor records → a contiguous pool of 21
LZ tile streams (each decompresses to 20 tiles at VRAM $8900/$8a40/$9140).
`carve_gfx_pointer_sets` in `disasm.py` walks the table, registers the pool as
labeled `Lz_16_*` blobs (extracted, gitignored), and shrinks the table region
to a `gfx_ptr_table` data table: `render_gfx_ptr_table` emits the pointers as
`.recN` locals and each record as a `gfx_set` of three stream labels. The same
method also carves two one-level `dw` tables straight into stream pools,
rendered by `render_lz_ptr_table` as `dw Lz_16_*` entries:
`$16:$60f1` (`WinLosePortraitVariantTable_16`, loader
`DecompressWinLosePortraitVariant` at `$60d5`, 8 streams) and
`$16:$6968` (`CharacterPortraitTable_16`, loader `DecompressCharacterPortrait`
at `$6955`, 32 entries / 30 streams). Still byte-perfect.

### Match-result tilemap scripts (2026-07-19)

`$16:$4abd` (480 bytes) was a `records:2` blob — really a 20-entry `dw` pointer
table (`MatchResultTilemapScripts_16`) plus the copy lists it indexes. The
routine at `$16:$4a71` (`BuildMatchResultTilemap`) selects a list by
`wCurrentMinigameStoryMatch`'s low byte (`$c8f7`) and walks it, farcalling
`CopyTilemapRect` (width fixed at 2 tiles) per record. A `tilemap_scripts`
render spec (`render_tilemap_scripts` in `disasm.py`) now emits the pointers as
`.scriptN` locals and each list as `tilemap_copy dest, src, rows` macro records
ended by a `tilemap_copy_end` sentinel (an all-zero 5-byte record — the routine
stops on a `$0000` dest word). Still byte-perfect.

### Cutscene script macros (2026-07-18)

Story cutscenes are hand-written native code — long runs of a fixed register
setup then a `farcall` into the script engine (`FarPtr_Script*`, bank $0a).
`script_cmd_seq` in `disasm.py` recognizes twenty of these idioms and emits
readable `script_*` macros (defined in the generated `include/macros.inc`):
`script_move_target/set_position/move_angle/move_player/move_player_to_actor`, `script_set_speed/player_speed`, `script_jump_velocity`,
`script_set_anim`, `script_set_objdef`, `script_face`, `script_face_pair`, `script_face_toward`, `script_facing_lock`, `script_set_active`, `script_speak`, `script_set_text`,
`script_wait_idle/wait_move/wait_frames`. Commands are step lists (register setups and farcalls); one
(`script_set_objdef`) spans two farcalls. The command is keyed by the farcall's
resolved slot name, and a sequence only collapses when no label or data note
lands inside it (past the first instruction), so nothing is hidden.
`script_wait_frames` also folds in the `push af`/`pop af` that brackets all
1216 of its sites (it clobbers `a` while callers hold an actor id there). **7,139
instances** across the story banks ($0e-$15, $27), turning ~18.6k lines of
`ld`/`farcall` boilerplate into ~7.3k lines of script. Each macro re-emits the
identical instructions; still byte-perfect. Example (`TournamentSiteArrivalScene`,
$15): `script_move_target $03, $1200, $2900` / `script_speak $03` /
`script_set_anim $04, $03` / `script_wait_idle $00`.

### Story-location map_trees carved in banks $12/$13/$15 (2026-07-18)

Six "StoryCmdHandlers*" tables were misidentified: they are the 7-slot
**`map_tree` location directories** that the bank $0a `story_location` records
point at (`DormEntrance` $12:$4006, `RestaurantPlaza` $13:$4006, `DormRoom`
$13:$4e20, `Courtyard` $13:$5c78, `TournamentCourtyard` $15:$4004,
`TrainingCourt` $15:$4796) — the same structure the bank $0e/$0f/$27 pass
already handled, just never extended to these banks. Each was typed `records:2`
and its sublists (EntryPoints/ExitTriggers/Actors/NpcScripts/FacingScripts/
TileTriggers) rendered as garbage disassembly. Retyped the directories `map_tree`
and each sublist `map_entries`/`map_scripts`/`map_actors`, renamed to
`<Loc><Role>_<bank>`. The story-script handlers referenced by the records — and
the InitScript slot-6 code — were only ever reached by linear decode from the old
blanket data-start seeds; those were replaced with precise per-handler code seeds
(the record pointer fields + the code following each list's `$ff` terminator), so
handlers now carve cleanly and the record lists get exact extents. Net +135
instructions, still byte-perfect. `StoryCmdHandlersC_13` ($13:$526a) was **left
alone**: it has no `$4000` DataPtr slot and no `story_location` reference, its
slots overlap, and its "InitScript" isn't code — it is not a real directory.
The `map_actors` renderer was also taught that one Actors slot can hold several
back-to-back sentinel-terminated lists (runtime-selected variants — Courtyard
holds five, 28 actors total); it now emits every list instead of the first plus
a raw `db` tail.

### Bank $1b $402e "table" split into farcall data slots + stranded cursor code (2026-07-18)

The 159-byte `records:2` blob at **`$1b:$402e`** was two things run together. The
first 18 bytes are the **data-pointer tail of the bank's `$4000` farcall table**:
the table is 32 slots (`$4000`–`$403f`), slots 0–22 code far-pointers, slots
23–31 (`$402e`–`$403e`) data pointers into the `$78bd` region — reached only by
slot index through `FarCall` (`$01b6`), which is why no literal `ld hl,$402e`
reader exists. Registered in `add_static_data_slots` (bank `$1b`, slots
`$2e`–`$3e`, `lz` kind), they now render as `DataPtr_1b_2e`…`DataPtr_1b_3e` over
nine **LZ-compressed 2bpp graphics streams** (`Lz_1b_78bd`…`Lz_1b_7e6f`, the
`$78bd` blob split 1→9). Each decompresses to a whole tile count — six ×16
tiles, two ×40, one ×20 — confirming they're tile assets; the three near-identical
16-tile streams (`$7a78`/`$7ab5`/`$7af6`) are colour/shape variants of one small
icon. The runtime consumer computes the slot address dynamically (no static
`ld hl,$402e` site), so which screen loads them isn't pinned down yet.

Everything after `$4040` was stranded code the far-call dispatcher reached but
recursive descent never seeded: `DrawMenuCursorCorners` (`$4040`) queues the four
bobbing corner sprites of the menu selection cursor via `QueueSprite` (`$1f51`),
applying a per-axis 1px bob from `ApplyCursorBobOffsetX` (`$40a3`, X/`d`) and the
existing `ApplyArrowBobOffset` (`$40cd`, Y/`e`), each indexing a 16-byte
`(hVBlankCounter & $0f)` ramp (`CursorBobOffsetTableX` at `$40bd`). A code seed
for `$4040` (`coverage/bank01b_static_code.json`) plus a `bytes:16` override for
the bob table carve it cleanly; the `$40f7` sibling that draws the alternate
cursor style is now `DrawMenuCursorCornersAlt`. Still byte-perfect.

### Map-script tables made readable (2026-07-18)

The story-location tables in banks **$0e/$0f** now render through dedicated
macros instead of raw `db`/`dw` hex. Each location owns a 7-word **`map_tree`**
directory (copied to `$c286` by the bank $0a overworld engine) whose slots are
named by role: `EntryPoints`, `ExitTriggers`, `Actors`, `NpcScripts`,
`FacingScripts`, `TileTriggers`, `InitScript`. Every slot is a labeled pointer,
including slots that point at an empty (immediately `$ff`-terminated) list — the
`ds`-fill emitter path is now label-aware so a curated label on a fill byte is
emitted instead of dropped. The three record formats got macros in
`include/macros.inc`:
- **`map_actor`** cond, objdef, x, y, facing, obj_id, anim, palette — the
  14-byte actor spawn template `SpawnActorFromTemplate` ($04:$4c60) expands;
  each list ends with **`map_actor_end`** (the shared 9×`$00` + `$ff` sentinel
  `SpawnActorsFromList` stops on).
- **`map_entry`** id, sprite, x, y, arrival_script — 8-byte entry-point spawn
  record selected by `wStoryModeEntryPoint`.
- **`map_script`** id, facing_mask, flag_cond, handler, arg0, arg1 — 8-byte
  story-script record matched by `FindStoryScriptEntry` ($0a:$53e4).

Three bank $0f regions had been carved as a single actor table in an earlier
pass but actually hold two back-to-back structures; they were split into
separate labeled tables (with the second, code-referenced table now symbolic):
`$41e9` = `AwardsCeremonyActors_0f` + `AwardsCeremonyActorsDoubles_0f` (`$430b`,
the doubles arrangement); `$65c2`/`$7842` = `IslandOpenRoundActors_0f`/
`…Doubles` + their paired `…Scripts` tables (`$65f6`/`$78a0`). `$7842`'s script
handlers were stranded cutscene code — `$78cc` was already seeded, `$78b1` was
added to `coverage/bank00f_static_code.json` (+one 11-instruction routine).
`MarioWorldNpcScripts_0e` referenced four handlers (`$633d`/`$63f4`/`$64a4`/
`$654f`, the NPC-$08 approach-from-4-directions scripts, each ending
`jp PromptExhibitionMatch`) that were stranded as code inside blobs interleaved
with `04 00` actor-script data; seeded into `coverage/bank00e_static_code.json`
(+402 bytes code), carved cleanly between the surviving data records.
The per-round Island Open rosters reached by `ld hl` in `LoadIslandOpenRoundNpcs`
(keyed on `$c2b0` = round 1/2/3, singles vs doubles by flag `$05.7`) are named
`IslandOpenRound{1,2,3}[Doubles]{Actors,Scripts}_0f`, plus the singles round-call
pair `IslandOpenRound{Actors,Scripts}Singles_0f` (`$75b7`/`$7615`) and
`AwardsCeremonyScriptsDoubles_0f` (`$5b04`) — every `map_actors`/`map_scripts`
table in $0e/$0f is now labeled.

The trees are reached from **`StoryLocationTable_0a`** (`$0a:$564f`, 42×6-byte
records indexed by `GetStoryLocationRecordPtr`): each record is
`story_location id, scene, map_scripts, bgm`, where `map_scripts` is a
`dslot` into the target bank's `$4000` directory — rendered as the
`DataPtr_*MapScripts` label when that slot is a known data-pointer (all the
$0e-$13/$15 trees resolve, e.g. loc 17 → `TrainingGymMapScripts_0e`, loc 26 →
`AwardsCeremonyMapScripts_0f`). Bank $14's four map-script trees (`$4008`/`$4a39`/`$4fac`/`$5221`, = the
Tennis Machine Room / Court #1/#2 / fountain locations 18/22/23/27) are
registered as `$4000` data slots in `add_static_data_slots` and **fully carved
like $0e/$0f**: all 7 slots per tree retagged to `map_tree`/`map_entries`/
`map_actors`/`map_scripts`, sub-tables + init scripts labeled `Loc{18,22,23,27}
<Role>_14` (handlers/init were already code in `bank014_static_code.json`), plus
the two per-scene respawn actor lists `Loc23ActorsAlt_14`/`Loc22ActorsAlt_14`
(a false internal data-table boundary at `$4efa` inside the `$4eb4` list was
removed). The location table now reads `DataPtr_Loc18MapScripts_14` etc.
The four bank-$14 trees are named from the in-game location-name popup
(`ShowLocationNamePopup` text id `$0179+loc` = string bank $30 index `377+loc`):
`TennisMachineRoom`/`Court1`/`Court2`/`IslandSky` (locs 18/22/23/27). Decoding
that name block identified all 42 story locations, now emitted as a comment on
each `StoryLocationTable_0a` record (`STORY_LOCATION_NAMES` in disasm.py) —
locs 30-41 are the End1-End17 ending tour. The Restaurant/Cafeteria trees
(bank $10, locs 13/14) and Center Court tree (bank $11, loc 24) are also carved
like $0e/$0f/$14 (three handlers seeded: `Func_10_5cb0` + the `Func_11_4199`/
`_41a3` no-op rets). The Academy Main Bldg. / Academy Wing trees (bank $10,
locs 5/6) are carved too — three more handlers seeded (`Func_10_623b`/`_6372`/
`_63e0`) and the Wing's Tile table `$6361` fixed from a `bytes:16`
mis-classification to `map_scripts`. The Test 2 / Development dev maps (bank
$10, locs 4/1) are carved as well (four `farcall`-headed handlers seeded); the
Main Menu (loc 0) and Test (loc 3) entries reuse the match-select structures
(`$4e6c` = `MatchSelectHandlersA_10`, `$4010` = the match-select main tree) and
are left resolving to those. The Test 2 exit table `$478e` had been over-sized
to 457 bytes; it is really 8 records, and the ~392 trailing bytes were 16
back-to-back exit/warp script routines (`$47cf`-`$4ade`, tiling exactly to the
Npc table) seeded as code. Its exit handler `$7bf9` is another `MapScriptNop`
(now `MapScriptNop_10` + `MapScriptClearActiveFlag_10`). Bank $27's `$4000`
(what had been curated as `SceneFramePtrs_27`) is really a 12-tree map-script
directory for the End1-End17 ending tour (locs 30-41): all 12 trees are carved
(`End<n><name>MapScripts_27`), the 12 staging scripts and shared exit no-op
`MapScriptNop_27` (`$7885`) were seeded from the old `SceneFrameData_27` blob
(+3780 instructions of real cutscene code; every data blob still ends on a
`ret`, so no misframing), and three lumped respawn actor lists split out. The
story location table is now fully resolved to named trees for all 42 locations.
The last two (loc 0 Main Menu `$4e6c`, loc 3 Test/character-select `$4010`) were
mislabeled `MatchSelect*` by an earlier pass — `$4e6c` had even been seeded as a
jump table, mis-decoding its data slots as code. They are now carved as
`MainMenuMapScripts_10` / `MatchSelectMapScripts_10` (false jump-table seeds
dropped, the off-by-2 `MatchSelectEntries_10` framing replaced by the real
`MatchSelectActors_10` = the 9 selectable characters). `render_map_table` also
learned `map_tree` so directories reached as data-slot marks render symbolically.

All six trees (Training Gym / Mario World / Special Court in $0e; Small Char.
Test / Awards Ceremony / Tournament in $0f) have their sub-tables labeled
(`<Tree><Role>_0X` in `labels.json`, +34), so the directory reads symbolically.
The record handlers/arrival scripts are indirect-dispatch code heads (reached
via `CallHLInBankA`), so recursive descent never labeled them; `disasm.py` now
seeds a `Func_` label for each (`map_script_code_targets`) and the macros
reference them by name. Implementation: `data_tables.json` retags $0e/$0f
tables to `map_tree`/`map_actors`/`map_entries`/`map_scripts`; `disasm.py`
renders them via `render_map_table` (pointer fields resolve to same-bank
labels). Rebuild stays byte-perfect (`make compare` → OK); only $0e/$0f change.

### Blob classification pass (2026-07-16)

A systematic sweep classified every remaining anonymous blob (code vs table vs
data), raising proven source from 282 KB to 388 KB and cutting the manifest
from 5,288 to ~5,000 entries. Highlights:

- **Shared menu-screen architecture** discovered and carved across banks
  $0e/$0f/$10/$11/$12/$14/$15 (each now 75-92% code): 7-slot dw trees whose
  slots are 14-byte entry records, `{id,$ff,0,dw handler,...}` handler tables,
  and a slot-6 code entry; every in-bank handler target was decode-verified
  and seeded (`coverage/bank0XX_static_code.json`), tables render inline via
  `data_tables.json`. Each bank ends with a ~600-byte resource-descriptor
  blob (`$10`-headed, $f9ff/$fbff/$fcff terminators) that the entry records
  point into — some with embedded 1-5 byte micro-handlers (seeded).
- **Bank $0c is an unreferenced leftover music bank**: same 4-channel
  `(channel word, stream ptr)` song format as $78-$7f, but `PlaySound` can
  only bank-switch to `$70|nibble` and no code anywhere switches to $0c.
- **Banks $2d/$2e/$2f** were already-named math tables (SineTable,
  CosecantTable, PerspectiveScaleTable, ViewScaleTableA/B).
- **Scene banks $5f-$69**: per-scene (metatile map, 8-palette set) groups —
  36 palette blobs render via `palettes`; pointer-targeted all-$ff tails
  (unused $4000-slot targets) now collapse to `ds N, $ff` in the emitter.
- **Ball-position twins $24/$29/$2c** carry local helper code ahead of their
  6-byte record payloads (seeded), like $20-$23/$2a/$2b.
- **Stub farms and continuation heads** in the engine/screen banks
  ($03/$04/$05/$06/$0a/$0b/$0d/$13/$16/$17/$18/$1a/$1b/$1c/$1d/$38/$39/$3e/$3f)
  were bulk-seeded after perfect-tiling verification
  (`coverage/bank_misc_static.json` et al). Bank $16 went 15%→83%, $06
  27%→89%, $12 26%→86%, $39 16%→70%.
- **What remains binary is data**: 2bpp graphics, the menu resource
  descriptors, `04 00`-family param records, OAM coordinate lists, level
  definitions (bank $0b's $47b4 directory), zeroed buffer templates and
  fill. Known deliberate hold-out: bank $0e `$71e9` (code head that flows
  into embedded data with no terminator — needs runtime coverage).
- Verification loop per bank: pattern carver (handler-table / record-run /
  dw-table detectors) → decode-verify every candidate before seeding →
  regen with `--hooks` → `make compare` → re-screen; a final ROM-wide
  code-shape screen over all blobs returns only known data.

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

**Inline-argument calls** (`INLINE_ARG_CALLS`): `Func_00_2725` is a ROM0 helper
that reads the byte at its return address (a repeat count) and steps the return
past it, so every `call $2725` is followed by one inline data byte. `decode_at`
emits it as a 4-byte pseudo-op rendering `call Func_00_2725` + `db $xx ; inline
arg` (mirrors the rst08/farcall inline handling). Fixed 33 mis-decoded sites
across 12 banks (the arg byte had been swallowing the next real instruction).

**Match-launcher stubs** (`seed_launcher_stubs`): banks $10/$0e hold runs of
uniform 14-byte functions that store a match id into
`wCurrentMinigameStoryMatch` and `farcall FarPtr_0a_5a` (the match starter),
reached via dw tables read through RAM. The rigid shape is scanned and
seeded statically (runs of 3+), and the launcher dw tables render as
labeled `ptr_words` entries — 41 stubs + a 35-entry table in bank $10's
story match-select data. The 5-instruction body (set match + court `$c8f7`,
`farcall FarPtr_LoadMatchSettingsFromTable`) now collapses to the
`load_match_settings match, court` macro via `match_launcher_seq` (70 sites
across banks $0e-$13: the 41 ret-stubs plus 29 inline callers).

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

2026-07-18 pass: the full 113-entry block directory extracted from
`InitSaveHeader` (most of it never written — including blocks addressing
SRAM banks 4-14 that don't exist on the 32 KiB cart); minigame-record
blocks `$38-$3d`, the 9×9 star-exhibition victory grid (block `$3e`,
`Read/WriteStarVictoryGrid`), and the N64 Transfer Pak records block
(`$0b`: presence word + per-char unlock flags) reversed; header fields
named as bank-3-scoped SRAM symbols (`sSaveSignature`,
`sSaveMasterChecksum`, `sSaveFormatVersion`, `sSaveBlockDirectory` via
`ram_unions.json`); all WRAM staging buffers mapped (WRAM7
`$d480/$d500/$de00`, WRAM6 `$d400`, WRAM3 `$d900`, WRAM1/2 `$d000`) —
see the expanded `docs/save_format.md`.

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
   (RetroAchievements-documented RAM → `ram.asm` +
   `ram/{sram,wram,hram}.asm`, one fixed-address SECTION per region with
   `::`-exported labels the linker resolves into every bank). Fails
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
- `session3_status_menus.json`, `session3_story.json` — autonomous drives:
  status-screen menus and story overworld.
- `session4_native.json` — human Trace Logger session (42 segments, 6.4 GB of
  logs unioned; 32.0K distinct offsets). All 577 offsets not in prior traces
  were already carved by recursive descent (mostly bank $12 tennis-machine and
  $1d/$1e drill code), so `src/` is unchanged — pure confirmation coverage.
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

**Human-named symbols: 2,898 of 16,870 labels** (`tools/progress.py`; the rest
are auto-generated `Func_/Label_/FarPtr_` names). Bank 0: 56 named routines
(docs/bank0_notes.md) — FarCall trampoline, OAM DMA stub, joypad, LZ
decompressor, sound engine entries, OAM sprite queuers, SoftReset, interrupt
handlers. Bank 3: save engine (23 named, docs/save_format.md). RAM:
docs/ram_map.md (280 entries in `ram_map.json`: 129 RetroAchievements-sourced
plus project-identified ones — match ball position/velocity/target, shot
type/aim, renderer effect/marker state, mode-hook table, story-mode location
entry/spawn/exit state, save-slot index + `wSaveBlockBuffer` staging buffer,
shadow-tilemap far pointer + glyph-pen text state, match-format menu
selections, serial-link HRAM vars, `hSramBank`/`hWramBank`, point-situation
flags (`wMatchPointFlag`/`wSetPointFlag`/`wGamePointFlag` via
`EvaluatePointSituation`'s simulate-next-point trick), ace/fault flags,
`wMatchRngState`, bank $6b cutscene driver step/timer/scroll).
A 2026-07-18 pass swept the hottest unnamed addresses per subsystem;
deliberately left unnamed: the story-script scratch pool `$c2b0-$c2ff`
(meaning changes per location script) and unproven mode-local bytes.
**Union overlays**: ranges reused by non-concurrent subsystems are modeled
via `ram_unions.json` → RGBDS `UNION`/`NEXTU` blocks in `ram/*.asm`, with
*scope-aware* operand substitution in `disasm.py` (a variant's names render
only at code sites inside its declared bank/address scopes; a `default`
variant covers everything outside scoped ranges; unproven consumers keep
numeric addresses). Current overlays: `$ffd0-$ffeb` (serial-link input slots
default; bank-0 sound driver, sprite queue, story actor engine scoped) and
`$c780-$c784` (char-select cursor, bank `$1b`). See docs/ram_map.md
"Union overlays".
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

**Bank $17 (serve-volley drill / menu bank) — code recovered** (50.1% →
58.6% code; 32 → 31 blobs). Seeded a big dispatcher (`$40bd` 841 B) + `$440a`
and, in a second pass, 10 more **cursor/menu handler** blobs (`$4016`-`$4443`,
reading `$cb04/$cb05` + bank-switch stubs) that the first classification had
mislabeled as data because they follow data tables. The remaining 31 blobs are
genuine data: uniform position/animation record arrays (`55 00 44 00 3a 00 …`,
several byte-identical — per-character/frame tables), LZ graphics, and OAM
templates. Lesson reinforced: after the first seed pass, re-scan the *new*
blobs — splitting a dispatcher exposes handler code that pattern-matches
(`fa 04 cb …` cursor reads, `f0 96 f5` bank swaps) but wasn't reached.

**Bank $0e (story match/launcher bank) — code recovered** (51.6% → 60.5%
code; 29 → 22 blobs). Seeded 8 stranded code blobs + farcall scripts (`$5bba`
774 B / 95 farcalls, `$43a6`, `$5422`). The big pointer-tables (`$75f6`,
`$5248`) and `$4006`'s targets were verified to point at `01 c0 00 …` data
records (not code) and left as data. Two bank-switch **code heads** (`$71e9`,
`$7c0c`) were tried but *reverted*: they run code straight into embedded data
with no `ret`, so seeding them misframed the adjacent `$75f6` data table into
`jp`/code — the recurring interleave trap (byte-perfect doesn't catch it). Left
as blobs pending runtime coverage.

**Bank $10 (story match-select) — code recovered** (31.9% → 39.5% code;
37 → 27 blobs). Seeded 16 stranded code blobs + two jump tables
(`MatchSelectHandlers{A,B}_10` at `$4e6c`/`$4fc6`) and several farcall
"scripts" (`$448d` 435 B, `$4450`, `$7443`, `$7472`, `$7bfa`)
(`coverage/bank010_static_code.json`). The remaining blobs are genuine
match-select **data**: big self-referential pointer-table + record structures
(`$61b1` 3649 B, `$468d`, `$74a9`, `$5a80` — each entry a `dw` into a
`01 40 00 …`-header record, verified *not* code before declining to seed) and
`$0cXX`-valued lookup tables (`$5ddc`/`$5f30`/`$5c34`/`$5899`/`$5982`).

**Bank $10 `$4000` header + `$4010` handler tree fully carved.** The bank's
`$4000` table is an 8-slot directory of match-select sub-tables; hooks proved
slots `$02-$06`, and `add_static_data_slots` resolves slots `$00`/`$08-$0e` (RAM-
dispatched, so no capture) as `DataPtr_10_*` over labeled sub-tables. Slot 0's
`$4010` was mis-decoded as code by a coarse `$4010` static seed that swept in the
whole pointer table and flowed into the setup routine that follows; the seed was
moved to its real entry (`$40b0`). `$4010` is now a 7-`dw` pointer table +
`MatchSelectEntries_10` (nine 14-byte records) + tail, all rendered inline.
Entry [3] `$4145` = `MatchSelectHandlerTable_10` (9 records `{id,$ff,$0000,dw
handler,$0000}`) whose handlers (`$40b0/$4195/$41da/$4450/$448d/$44cc/$4640/
`$40ef/$4137`, now `Func_10_*`) were carved out of the `d_40ef` blob.

**Bank $09 tileset de-blobbed.** The VRAM tileset at `$488a` (29-record
`{dw src, db tiles, db 0}` descriptor + `$4900-$60ff` tiles → VRAM `$8200`, loaded
by `Func_09_4873`) was split into three blobs by two lone coverage seeds
(`$24f99`/`$252b5`) that are data reads during the copy, not execution; added to
`BAD_SEEDS`, it is now one `VramTileset_09` + descriptor table. Also named
`MoveCurveTable_09`, `VramGfxPtrTable_09_616d`, `ServeGfxPtrTable_09`.

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

**Bank $6b (intro cutscene / title / award-ceremony driver)** carved: 40 -> 28
blobs, 28.6% -> 30.7% code. The bank is a state machine — `$cb3f` indexes an
18-word state->record pointer table at `$40bd` into 20 x 6-byte
`{init,update,exit}` handler records, and the records' handlers sat inside data
blobs (the two-level indirection is invisible to descent). 13 static seeds
(`coverage/bank06b_static_code.json`, function starts + internal flow targets)
recovered them: state 17's live exit/init/update tail (`$415c`/`$4166`/`$416e`,
which folded the `$40bd` blob down to a clean 156-byte table) and three
farcall/computed-reached helpers (`$51a5` button-wait loop, `$545e`
decompress-setup sibling of `Func_6b_53fc`, `$7691` teardown). Decoding the
full table exposed dead content: **records 11 and 12 are targeted by no state**
(their `$4885`/`$48f2` handler trio is a complete but unwired intro segment that
decompresses + scrolls character/logo tiles), and two orphaned handler snippets
(`$4159`/`$415f`) flank the live `$415c`. These decode as clean, function-calling
handlers (not data), so they are disassembled and marked `Unused_6b_*` rather
than hidden in blobs. Seven palette blobs
(`$42b2/475a/4c00/525a/60c5/756f/794f`) render inline via the `palettes` spec
and are named `Palettes_6b_*`, so their `LoadPaletteShadow` call sites read
symbolically. The remaining blobs are genuine data — LZ tile/tilemap streams,
metasprite templates, and frame-indexed animation curves.

**Bank $02 (story-mode character/roster/equipment manager) has zero data
blobs — 19.8% -> 48.4% committed source.** It owns the player character record
(`wStoryModeNameOfMainCharacter`, `$c800`), a 100-entry roster DB, equipment,
and save flags, exporting ~34 functions via `FarPtr_02`. All 18 blobs were
classified and structured (`data_tables.json`): `StoryCharacterRecords_02`
(`$52cf`, 100 x 29-byte records; stride proven by `Func_02_41ee` + the
`ld c,$1d` copy) followed by `CharGroupTable_02` (`$5e23`, 9 x 16-byte group
rows, searched by `Func_02_5eb3`/`5ee2`); `EquipRecordPtrs_02`/`EquipRecords_02`
(`$47f2` 4-ptr table -> 4 x 113-byte records); two `SaveFlagPtrs_02` word
tables (feeding Clear/Set/TestSaveFlag); `CharIconMasks_02`, `NameTextRemap_02`,
`MenuTilemaps_02` (null-terminated tile strings via `Func_00_1906`), and the
`Value100000_02` 24-bit cap constant. Four stranded-but-valid helpers unreferenced
anywhere (`coverage/bank002_static_code.json`) were carved as code and, like
bank $6b's dead handlers, labeled `Unused_02_*`: `SignExtendL`, `ListForEach`
(indexes a 64-byte table, left as data), `StorySlotVariant` (near-dup of
`Func_02_5247`), and `CharGroupFind`.

**Bank $01 (hidden debug/developer test menu)** partially carved, 6.3% ->
8.6% code, 10 -> 6 blobs. `Func_01_4018` is a button dispatcher into test modes
(match test -> `FarPtr_16_00`, intro/title test -> `FarPtr_6b`, story-location
tests) plus a sound test (`Func_01_6a5b`: adjust two hex indices on the d-pad
and play sounds). Converted to committed source: `DebugMenuPalettes_01`
(`$50f6`, 16 palettes, selected by `Func_01_519a`) and the sound-test tables
(`SoundTestStrings_01` tilemap labels + `SoundTestSoundsA_01`/`B` sound-id
tables read at `$6b3c`/`$6b52`). Three unreferenced handler fragments carved as
code, labeled `Unused_01_*` (`coverage/bank001_static_code.json`): `MenuRedraw`,
`MatchSetup`, `$41d6`. The remaining 6 blobs are tile/LZ graphics that stay
gitignored (no ROM bytes) but are now named: `MenuTilesA_01`/`MenuTilesB_01`,
the two LZ streams `MenuGfxLZ_01`/`MenuGfxLZ2_01` (split out of one blob, refs
now symbolic), and `UnusedTiles_01_51ab`/`_53b0` (~3.4 KB of graphics
referenced by nothing).

**Status/records viewer (banks $1a/$1b/$1c) identified via live driving.**
Driving the game to Status → file → Character Data (the two-panel per-character
stat screen, Alex/Harry) under an MCP execution trace pinned the subsystem:
bank $1b is the menu shell/state machine, bank $1a holds the per-screen
renderers (reached through the `FarPtr_1a` dispatch table), bank $1c the draw
helpers. The Character-Data screen's handlers are named from observed coverage:
`CharDataScreen_LoadGfx`/`_LoadScreen` (decompress tiles+sprites into VRAM),
`CharDataScreen_BuildStats`/`_DrawStats` (compute base+modifier per stat, format
digits, write gauge bars into the parallel bank-3 tile / bank-2 attribute
buffers), and the shared `CopyWram1ToWram2`/`CopyWram1ToWram3` block copiers.

The bank-0 **number-formatting subsystem** was named as signed/unsigned pairs:
`FormatDecimalNumber` (signed, pre-existing) + `FormatDecimalNumberUnsigned`
(`$1a27`) are near-duplicate value→padded-ASCII formatters differing only in
sign handling, each with its own inlined digit extractor
(`ExtractDecimalDigit`/`ExtractDecimalDigitUnsigned`, whose loop bodies now use
`.loop` locals). Five draw-to-tilemap wrappers sit on top (`PrintHexByte`,
`PrintHexWord`, `PrintDecimalByte`, `PrintDecimalWord`, and dead-code
`Unused_00_PrintDecimalByteSigned`), all sharing a tail that renders the
formatted string via `Func_00_1906`. `tools/disasm.py`'s labels.json validator
now accepts `.local` labels alongside PascalCase (the internal-label convention).

Bank $08's core match-loop API is now named: `StepMatchFrame` (`$4465`,
vblank-sync + one update step, 40 call sites) and its multi-frame wrapper
`StepMatchFrames` (`$4428`, early-exits on the `$c492` point-over flag), plus
the input readers `ReadMatchInputPressed` (`$4415`, `$ff94` edge-pressed) and
`ReadMatchInputRepeat` (`$441d`, `hInputPressed` autorepeat) — both fall back to
`$ffd3` in link mode. Names propagate through the `FarPtr_08` slots to all
call sites automatically.

**Broad function-naming pass (subagent-driven, +343 names).** A sweep across
the code banks named ~343 functions whose purpose is unambiguous from the code,
leaving deep physics/AI/scene-scripting and screen-specific builders (which need
runtime/visual identification) unnamed. Highlights:
- **Match engine ($08):** the full scoring/flow state machine — RunMatch ->
  RunMatchPlayLoop -> PlaySet -> PlayPoint; tennis win-by-2 scoring (Award/Check
  Point/Game/Set/Match, EvalWinByTwo, deuce/advantage); the 9 match-statistic
  recorders; ball physics head (StepBallPhysics, HandleBallNetCrossing); court
  camera; and the per-character state machine (UpdateCharStateMachine,
  Step/SetCharAnimation, CheckCharBallContact, ReadCharInput).
- **Story/roster ($02, $04, $06, $0d):** the overworld actor engine (spawn/
  script-VM/animation/camera in $04), the parallel match/story menu system ($06),
  the roster/EXP/stat manager ($02 — record getters, RecomputeCharacterStats, the
  EXP arithmetic family, per-slot save flags), and the minigame engine ($0d —
  scoring, actors, ball, countdown, score popups).
- **Screens:** match win/lose + statistics ($16), EXP-gain/Status char-data
  ($1a — ShowExpGainScreen, confirming Func_00_086c builds its two-panel
  row-doubled tilemap), reward/results ($1e), rules ($17), name-entry + match-type
  menus ($38), and the drill result/level-up screens ($1d).
- **Core/engine ($00, $03, $05, $09, $0a):** bank-0 utilities (sign-extend,
  mul/div, AdvanceRandomSeed, the frame-task registry, game timer, frame sync,
  window-frame drawing, the Format/Print number family), the save engine's
  block read/clear/restore helpers ($03), the text control-code interpreter
  ($05 — RenderTextString, DispatchControlCode, glyph-width measurement), VRAM
  gfx/object loaders ($09), and the scene tilemap scroll/blit system ($0a).
All applied via `labels.json` and verified byte-perfect each wave. Names were
gated on concrete in-code evidence and spot-checked against the source.

**Bank $00 deep-naming pass (2026-07-17, +116 names + 42 RAM labels).** A full
read-through of the home bank named every remaining identifiable Func_00_*:
the far-call/vector plumbing (CallHLInBankA, CallVectorEntryA/E, FarCallVector,
FarReadByte/Word, FarCopyBytes), the VBlank transfer system (QueueVRAMCopy,
QueueBGTileWrite, ProcessVRAMCopyQueues, the BG row/column blit queues and
their 64x64 map-buffer variants), the palette system (live $c100 / master
$c200 buffers, LoadPalettes*, fade state machine BeginFadeOut/In,
UpdateFadeIn/Out, ApplyWhiteFade, per-component color adjust), the math
library (MulHLByDE/32, MulHLByAFrac*, DivAHL*, sin/cos multiply family,
AngleFromVector16/Coarse, GetTangent), the leftover debug console
(wDebugTextBuffer at $cc00 -> $9d00, PrintString/PrintHex*, frame-time meter,
frame-step via hDebugStepMode), sprite queueing (QueueSprite24x32/32x32,
double-buffered OAM via wSpriteBufferPage), the serial-link input exchange
(SerialHandler, SerialEncode/DecodeInput, WaitSerialTransfer), music control
(PlaySoundCmd/PlaySoundManaged, jingle override via hActiveJingle), and the
sound-engine internals (RunSoundChannelScript command interpreter, vibrato/
volume-slide/echo ticks, wave-pattern loading). 42 matching HRAM/WRAM names
landed in ram_map.json (hFadeState, hVRAMQueueDirty, wCameraX/Y, wGameTimer,
hRandomSeed, hIsCGB, ...). Bank $00 is now 245/901 human-named; what remains
is mostly interior branch labels.

**Cross-bank naming pass round 2 (2026-07-17, +256 names).** Continued with a
mix of direct reading and per-bank subagent proposals (each verified against
the source before applying):
- **Bank $05 is now fully mapped as the text/window engine** (+141): the
  window-struct allocator ($dc00, 7 x 8-byte slots, mask $dc70), shadow
  tilemap under-window save/restore, the dirty-row flush pipeline
  (MarkWindowRowsDirty -> BuildDirtyRowRuns -> CopyDirtyRowSpanToVRAM), menu
  selection loops (RunMenuSelection, paged variants), the text-argument
  substitution lists (PushTextArgString/Number/ShortTextId + measurement),
  speaker dialogue/speech-bubble display, the dynamic glyph-tile streaming
  system (WRAM7 $d300 buffer -> $8800), SRAM text fetch, and a large leftover
  debug suite (flag editor, palette editor, warp menu, window demo).
- **Bank $07 identified and named** (+76): the link-play protocol engine
  (master/slave handshakes, per-frame input exchange with duplicate
  detection, nibble-block bulk transfer with checksums, command encode/
  decode) and the shot-execution engine (ExecuteShot, per-shot-type speed
  composition, ComputeShotTrajectory, recoil, smash-range check, aim
  jitter), plus RunDebugTestMatch.
- **Bank $0a story-script layer** (+27): script commands over the WRAM4
  actor records (position/move-target/polar movement, facing, screen shake,
  player teleport with fade, dialogue-sequence wrappers).
- **Bank $18 helpers** (+7): grid-cursor movement, unlock-flag test,
  bobbing cursor offsets, two-option prompt.
Named symbol count grew from 1,338 to 1,725. A follow-up mini-pass used the
text-id decode trick (see auto-memory text-id-decoding: text id hl -> bank
(h>>2)&$f + $30, index (h&3)*256+l, read with tools/strings.py --index) to
identify menus by their strings: bank $1b's character-select/mugshot cluster,
RunNewGameSetup, the Level Up/Status/Trophies menu, a leftover debug
"Saved Data/Mini-Game Flags" menu, and bank $10's singles/doubles/drill
match-list and minigame-select menus. Two offset-arithmetic mishaps
(labels landing in the wrong bank) were caught by blob-count changes and a
name clash; the fix and the safe recipe are recorded in the auto-memory
(naming-pass-workflow).

**Cross-bank naming pass round 3 (2026-07-17, +216 names).** Subagent proposals
(one per bank, evidence-gated, spot-checked) over the story-scene banks, driven
by text-id decoding. Named symbols: 1,735 -> 1,951. What each bank turned out
to be:
- **Bank $0e = training gym + Mario World.** The Repair Counter equipment-change
  flow (service menu, racket/shoe select via FarPtr_3e_0c/0e, handout/confirm
  dialogue, the $c295 return-path handlers) and the post-game Mario World
  exhibition-match story (arrival cutscenes singles/doubles, Peach's exhibition
  prompt with Hard/Intense/MAX select, decline tantrum, the 6
  LoadExhibitionMatchSettings stubs and HandleExhibitionMatchResult).
- **Bank $0f = Island Open tournament site.** Three map-script trees:
  Tournament (loc $19), Awards Ceremony (loc $1a), and the leftover dev map
  "Small Char. Test" (loc $02). Round computation from story
  flags, per-round NPC loads, round-call/break/arrival cutscenes, podium
  announcement, and the victory transition to the plane cutscene (location $1b).
- **Bank $11 = Academy arrival + junior-class ranking courts.** The game-opening
  greeting/tour scenes and late-student crash cutscene, plus the singles and
  doubles ranking-match offer/opponent flows (the doubles twins of the
  already-named StartNextRankingMatch/LoadRankingOpponentGraphics fork on story
  flag $05.7).
- **Bank $12 = Wall Practice Room + senior-class court.** Wall practice level
  signs/launch/result/record scripts (9999-hit counter cap, Master Level), and
  the senior ranking ladder: stage computation ($c2b1 from the story-flag
  cascade), offer/confirm scenes, practicing NPC pairs, victory dispatch.
- **Bank $14 = Tennis Machine Room + Island Open courts + water sprite.** All
  four machine-level result/practice/retry scripts, the Expert System record
  flow, Court #1/#2 gallery scenes, and the fountain water-sprite loaders.
- **Bank $15 = training courts + tournament site trees.** The three coaches
  (serve $07, net $12: volley/smash/drop shot, return $0d: return/lob/passing
  shot) with their lesson scenes/retry prompts/walk-to-court starters, the
  three challenger NPCs (serve/net/stroke match chains), and the pond
  side-story (swing-practice kid, water-sprite 10-second swing contest,
  Gold/Silver Racket reward).
- **Bank $0b = training-drill engine** (direct + agent): RunTrainingDrillByID
  ($47b4 14-byte drill-definition directory, ids >= $12 route to minigames),
  the drill result-message system ($45c4 text-id table, queue/show helpers),
  target-zone record/check helpers, and the per-drill judge/evaluate/point-end
  trios for drills 9 (serve-and-volley), 15 and 17.
- **Bank $39/$18 screen helpers** (direct): CopyTilemapRect/FillTilemapRect
  (the rect blitters behind 38 bank-$16 stats-screen farcall sites),
  LoadIndexedPalette (+ bank $18 twin), QueueWram3MapToVRAM, and RAM
  wBgMapShadowDirty ($cb61).
- Fixes: text-id fetcher mapping corrected (fetchers 8-12 = banks
  $6e/$1f/$25/$26/$5e, not $38+); disasm.py now dedupes consecutive identical
  label lines (a curated name on an offset with both a data-mark and a segment
  label emitted twice and broke assembly).
- **Bank $16 = win/lose + match-stats screens** (+17): the result-portrait
  pipeline (DecompressCharacterPortrait 32-entry table, win/lose face
  variants, palette-to-BG-slot-4-7 attr fills), per-match graphics loads
  indexed by wCurrentMinigameStoryMatch, banner sprite wobble helpers, and
  MaybeInvertMatchWinLoseFlag (link-mode side swap). The story EXP screens
  turned out to live elsewhere; $16's remainder is compressed graphics.
- **Bank $13 cutscene layer** (+15): academy courts tour (with the bobbing
  pointer-sprite frame task), Service Ace restaurant coach intro, door
  open/close animation pair, the daily "play doubles today?" prompt (sets
  wMatchIsDoubles + story flag $05,7), the academy questions menu, narrator
  scenes, the singles/doubles traveling-team victory cutscenes, and
  ComputeStoryRankTier_13. Noted: wWaterSpriteMinigameFlag is reused as
  generic scratch by $13's actor position save/restore — the RA-sourced name
  is mis-scoped.

Named symbols after the $13/$16 follow-up: 1,983.

### Naming pass round 4 (2026-07-17, later)

- **Bank $05 text engine fully decoded**: TextInterpreterLoop + all 20
  control-code handlers named (TextCmd*: newline, wait-button page break,
  arg-string/arg-number/short-text printers via the PushTextArg* queues,
  player/partner name inserts, dakuten/handakuten combining marks, three
  delay variants, nops) plus the continue-arrow blink task. Eleven WRAM5
  text-engine variables named in ram_map.json (wTextArgStringQueue,
  wTextStreamPtr, wGlyphVramDest, wTextPageBreakRequest, ...). Caution
  learned: $d82a/$d82b are the text cursor only under WRAM bank 5 — bank
  $17 uses the same addresses in WRAM bank 3 as target-box dims, so they
  stay unnamed.
- **Generator**: `records:2` data tables now emit `dw <label>` when a word
  resolves to a labeled same-bank offset — dispatch tables (e.g.
  ControlCodeHandlers_05) self-document as handlers get named.
- **Bank $06** (agent): match pause menu tree (rules pages per game mode,
  controls review, camera/music options, per-mode quit menus), scoreboard
  system (pips, captions, per-mode gfx), story pause tree (message speed,
  save/quit), shadow-tilemap addressing helpers, and RunDebugStatsEditor
  (FarPtr_06_02): a leftover hex editor for the $df00 player struct with
  ASCII field labels SPEED/ADD/BRAKE/TURN/ANGLE/PLACE/STROKE/SERVE/VOLLEY.
- **Bank $1b** (agent): academy ranking-board screens (singles/doubles
  12-name ladders, highlight + marker-coord tables, rank-change jingles),
  char-select roster/nav-grid/mugshot machinery, minigame level picker
  (2/3-panel variants gated on save flags), saved-data viewer (Exhibition
  vs Mini-Game Data, scrolling clear/star/high-score list), and another
  debug tree: char-unlock-flag toggle grid (writes save block $0b),
  'No N64 data was found.' screen, Trophies placeholder.
- **Bank $17** (agent): the nine training-drill briefing screens
  (DrillBriefing_*: serve-to-targets, spin serve, poles, serve+volley,
  two serve+smash, three return drills) — each an animated court-diagram
  with per-phase sprite-position record tables and 36:688+/37:3+ captions;
  the diagram sprite task suite (figures, ball, swing anim, poles, spot
  marker, target brackets, palette cycler); minigame rules pages; rules
  border animation. Twin cursor-grid helpers suffixed _17 (twins of the
  bank $1b set).
- **ROM0**: MulNegHLByA/MulPosHLByA (signed-multiply core), soft-reset
  combo checks, DrawHalvedWordDecimal, QueueTileCopyAdvance, sound-engine
  channel-update request trio + ApplyChannelVolumeEnvelope.
- **Bank $02**: GetCharPaletteIndex (+CharPaletteIndexTable feeding
  LoadIndexedPalette), RemapExtendedCharId, ValidateN64TransferRecord
  (checksummed $c9b0 transfer-pak record), stubbed EXP-gate helpers.
- **Banks $1c/$1d/$1e** (direct): ShowCharDataScreen + values-sync task +
  Backup/RestoreCharData pairs; ShowMatchResultsScreen, ProcessMatchRewards
  (per-mode reward/unlock recording), ShowGameProgressScreen tree;
  GrayscalePaletteColorInPlace/ConvertColorToGrayscale — note the original
  game bug: the blue component is stored to ROM $0002 (no-op), so the
  grayscale ignores fresh blue.

Named symbols after round 4: 2,294 (labels.json 2,209 + ram_map 225).

### Naming pass round 5 (2026-07-17, agent fleet restart)

- **Bank $0a fully mapped (agent): the story-overworld engine.**
  RunStoryModeOverworld/RunStoryLocation (6-byte location records at $564f,
  $0e-byte pointer headers at $c286, event-request polling $c2a0-$c2a5),
  FindStoryScriptEntry (8-byte trigger/exit/NPC records with facing masks +
  flag conditions), Begin/EndCutsceneScriptMode, the WRAM6 collision ($d000)
  and behavior ($d400) map accessors, scene tile animations + debug scene
  viewer, the 15-slot minigame moving-target pool with its own movement
  bytecode interpreter (RunMinigameTargetScript), story-match glue
  (AssignStoryMatchCharacters), and RunEndingCreditsSequence (End1-End17
  location tour with FreezeAllActors).
- **Bank $3b (agent): main menu + records front-end.** RunMainMenu (3x3 grid
  with save-slot mugshot cells), RunMatchFormatSelect, RunMinigameSelect
  (6/9-slot portrait grids), the saved-data source/erase pickers, the N64
  Transfer Pak record screens (Tnmt/Exhib/Ring Shot charts decoded from save
  block $0b), ShowTournamentBracket, RunStarCharExhibResults, and
  **a hidden cheat**: on the Trophies screen the game counts Right presses
  ($d900) and Left presses ($d901); exactly 12 Rights + 34 Lefts then
  A+Select runs ApplyUnlockEverythingCheat (sets all star-char/court/misc
  save flags for all three slots) and saves.
- **Bank $3e (agent): secondary menus.** Link match-rules/status/error
  screens, erase-data confirmations, the story equipment suite (racket/shoes
  choice + select + status screens with stat-mod readouts, owned lists from
  game flags, wEquippedRacket nibble equip), and the 4-court/9-court select
  grids (local + link variants, unlock gating via save flags into $cb54,
  per-court BGM through $c8f8).
- **Direct**: bank $04 actor helpers (IsTileBlockedAt, WaitActorsIdleTimeout,
  LoadOverworldSpriteDef), bank $0d GetDefaultMinigameRecordValue (+ save
  blocks $38+slot), bank $39 shared screen hub (LoadCompressedTileBlock —
  the 152-site tile-block loader — menu bg scroll, staged map flush, digit
  sprites), bank $18 char-select cursor/roster helpers.

Named symbols after round 5: 2,736 (labels.json 2,652 + ram_map 225 - overlap).

- **Bank $08 (agent): the match engine decoded.** Ball physics
  (SetBallVelocityPolar, ApplyBallAirDrag — drag proportional to speed,
  ApplyBallSpin — Magnus curve with 3/256-per-frame spin decay,
  ApplyCourtBounceDamping from per-court factors, BounceBallOffCourtFences,
  the 24/32-bit fixed-point integrator suite AddVel24ToPos32 etc.), the
  character state machine (serve toss/swing-window/strike phases, rally
  ready/windup/contact, changeover walks, point-end reactions), input
  handling (the two-press topspin/slice buffer $df16/$df17 with 5-frame
  window, charge flash after 20 held frames), movement (per-stat
  accelerate/brake/clamp per axis from the $df60+ stat block), and the
  complete CPU AI: singles and doubles state machines with strategy-driven
  positioning (baseliner vs net-rusher home spots), ball-intercept
  prediction (PredictBallXAtDepth = X + tan(heading) x depth-delta), skill-
  gated serve timing, shot-button personality tables via char groups, aim-
  away-from-opponent logic, and doubles poaching (AiNetPlayerPoachCheck).

Named symbols after round 5 complete: 2,898.

Next annotation targets: bank $08's remaining ~120 physics/AI routines (velocity
integrators, the CPU-AI behaviour state machine — need runtime traces), bank
$3b's screen-specific pause-menu builders, bank $0a story-overworld engine,
bank $03's remaining save farcall slots (FarPtr_03_18/24/26/2a/2c/...), bank
$1a EXP-screen internals, bank $13/$15's scene-scripting beats, sound-command
enum for the 451 `sound $xx` sites, WRAM map expansion from ram_map gaps.

## Repo state

All work is committed (HEAD `af938fc`); every commit rebuilds byte-perfect.
Gitignored: baserom.gbc, data/, build/, tools/rgbds/, *.o, *.gbc, *.sav.
