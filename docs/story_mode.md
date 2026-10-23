# Story Mode

Story mode is the game's RPG shell: a tile-scrolled overworld with an actor
engine, per-location script tables, dialogue, a pause menu, and progression
built entirely from flag bits. It also hosts the title screen and main menu,
which run as location `$00` (see [Entry](#entry-and-top-level-flow)), so
almost every frame runs inside the story-mode loop.

| bank | role |
| --- | --- |
| `$0a` | overworld engine: location loop, script dispatch, scene loader, collision/behaviour maps, camera, cutscene helpers |
| `$04` | actor engine: spawning, stepping, player control, the actor-script VM |
| `$0e`-`$15` | location script data + location code for the 30 playable locations |
| `$27` | the same for the 12 epilogue ("End1".."End17") locations |
| `$63`-`$69` | scene assets (tiles, tilemaps, attribute, collision and behaviour maps) via `$4000` slot directories |
| `$02` | character records, stat pipeline, EXP/level, save signatures |
| `$03` | save engine, `SAVEFLAG_*` accessors, scrolling-text/credits cutscene renderer |
| `$05` | text engine and dialogue windows (control-code interpreter at `$05:$4e5d`) |
| `$06` | the pause menu |
| `$18` | full-screen "screen sequence" beats (`RunStorySceneByMode`) |

See also [`actor_script.md`](actor_script.md), [`save_format.md`](save_format.md),
[`ram_map.md`](ram_map.md).

## Entry and top-level flow

Boot reaches `InitAndRunGame` (`$01:$4018`, from `$00:$262c`), which
initialises SRAM and story state, sets `wStoryModeCurrentLocation =
STORYLOC_MAIN_MENU`, `wStoryModeEntryPoint = ENTRY_MAIN_MENU_TITLE` (`$0a`:
logo, intro and title first; any other id opens the menu directly), and farcalls
`RunStoryModeOverworld` (`$0a:$4f2c`). That is an infinite loop: clear the
frame-task list, register the player-position debug overlay, `call
RunStoryLocation`. Every location change is a *return* from
`RunStoryLocation` followed by a fresh load.

Location `$00`'s init script (`MainMenuInitScript_10`, `$10:$4eb9`) parks the
player off-map at `(63.0, 63.0)` and calls `RunTitleAndMainMenuLoop`
(`$10:$4f0d`): logo, intro, title, main menu, returning only once the player
commits. It leaves by writing `wStoryModeExitTriggerRequest`, looked up in
`MainMenuExitTriggers_10`:

| exit (`EXIT_MAIN_MENU_*`) | destination | when |
| --- | --- | --- |
| `$01` `NEW_GAME` | `ENTRY_ACADEMY_ENTRANCE_NEW_GAME` | new game (`$10:$5081`) |
| `$02` `CONTINUE` | `ENTRY_DORM_ROOM_CONTINUE` | ordinary continue |
| `$03` `TEST_2` | `ENTRY_TEST_2_SETUP_MENU` | `FLAG_DEBUG_EXIT_TO_TEST_2` shortcut (Test 2 runs the clear-status setup menu) |
| `$04` `CONTINUE_ISLAND_OPEN_WON` | `ENTRY_ACADEMY_WING_ISLAND_OPEN_WON` | Island Open final won, story not yet flagged complete |
| `$05` `CONTINUE_TO_PEACHS_CASTLE` | `ENTRY_PEACHS_CASTLE_FIRST_VISIT` | story complete, Mario World not yet visited |

`GetStoryContinueDestination` (`$10:$5752`) picks `$02`/`$04`/`$05` by
testing, in order, `FLAG_WON_ISLAND_OPEN_*_FINAL`, `FLAG_STORY_COMPLETE_*`
and `FLAG_REACHED_MARIO_WORLD_*`, `FLAG_DOUBLES` choosing the arc. The resume
point is derived from flags, not stored.

`SaveStoryReturnPoint` / `RestoreStoryReturnPoint` (`$0a:$527f`/`$52ae`) hold
location + entry point + 5-byte position (`wStoryReturnLocation`,
`wStoryReturnEntryPoint`, `wStoryReturnPosition`). With `b = $ff` it
snapshots the live position and stores entry `$ff` ("restore the exact
position"), as the pause-menu save does (`$06:$706a`); the main menu's
continue passes an explicit pair (`$10:$50df`: `b=$0a, c=$01`, the dorm room).

## The location loop

`RunStoryLocation` (`$0a:$4f40`) is the whole overworld. Load phase:

1. `BeginFadeOut`, `ClearTemporaryStoryFlags` (zeroes `wGameFlags` bytes
   `$1c-$1f`), `ClearStoryEventRequests` (zeroes `$c2a0-$c2a5`).
2. `LoadStoryLocationHeader` (`$0a:$5114`) — see [Location data](#location-data).
3. `LoadStoryEntryPointRecord` (`$0a:$516f`) finds `wStoryModeEntryPoint` in
   the `EntryPoints` table and fills `wStoryModeSpawnPosition` (X, Y, facing)
   and `wStoryArrivalScript`. Id `$ff` skips the step and keeps the existing
   spawn buffer (return from a full-screen sub-screen); an id not found falls
   back to record 0.
4. `wGameMode = 0`; start `wStoryLocationBGM` unless it is `$ff` or the ending
   credits are running.
5. `InitLocationActors` (`$0a:$5466`): reset the actor engine, spawn the main
   character at the spawn position, the companion, then `SpawnActorsFromList`
   over the `map_actor` list.
6. Object palettes, `LoadStorySceneGraphics`, the scrolled tilemap; LCD on.
7. The entry's `arrival_script` (if nonzero) via `CallHLInBankA` in
   `wStoryLocationBank`, then `RunLocationInitScript`.
8. If an init script already requested an exit, `RunLocationExit` and return;
   otherwise fade in and, if `wStoryModeShowLocationName`, show the name popup.

### The frame loop

`.frameLoop` (`$0a:$4ff5`) switches to WRAM bank `$04` and checks
`CheckStoryEventRequests` (OR of `$c2a0-$c2a5`). With none set it drops into
`.waitForEvent`, attaching the player's controller script and idling until a
request appears. With one pending it re-installs `ActorScript_Null` on the
player (a 6-byte halting script) and tests in order:

| order | request | handler |
| --- | --- | --- |
| 1 | `wStoryModeTriggerScript` (`$c2a0`) | `RunQueuedTriggerScript` — step-on trigger queued by movement |
| 2 | `wStoryModeExitTriggerRequest` (`$c2a1`) | `RunLocationExit`, then return (reload) |
| 3 | `wStoryModeMenuRequest` (`$c2a5`) | wait for the player to stop, then `RunStoryModeMenu` unless `FLAG_STORY_MENU_LOCKED` |
| 4 | auto-interact arming (`$c2a2`) | after 30+ frames walking into the same direction, raise an interact request |
| 5 | `wStoryModeInteractRequest` (`$c2a4`) | `FindActorFacingPlayer` → `RunNpcInteraction`; else `GetFacingTileInteractionId` → `RunFacingTileScript`; else `GetTileTriggerAtPlayer` → `RunTileTriggerScript` |
| 6 | debug menu | if `hDebugStepMode` is nonzero and the interact was not auto-fired, `RunDebugMenu` |

`wStoryScriptRan` (`$c2da`), set by `RunStoryScriptOrDialogue` and cleared
before step 5, stops the NPC → facing-tile → step-on cascade at the first
handler that fires.

Step 4 makes walking into a door work without A: `UpdatePlayerControl`
(`$04:$52a6`) sets `wStoryAutoInteractArmed` whenever the point ahead is
blocked; the loop turns a sustained push into an interact request and sets
`wStoryAutoInteractFired` (`$c2a3`) `= $ff`, suppressing the debug-menu check.

Input is read in `UpdatePlayerControl` (`$04:$516b`): A raises
`wStoryModeInteractRequest` **and** probes the tile underfoot
(`CheckTileTriggerAtPoint`); Start raises `wStoryModeMenuRequest`; held B sets
`FLAG_PLAYER_RUNNING` (2.0 pixels per frame instead of 1.0; the 0.5 slow
terrain branch is unreachable, `docs/bugs.md`); the D-pad becomes
`wPlayerMoveAngle` via `DpadMaskToAngleTable_04`.

## Location data

### The location record

`StoryLocationTable_0a` (`$0a:$564f`) is 42 six-byte `story_location` records
indexed by `wStoryModeCurrentLocation` (`GetStoryLocationCount`, `$0a:$574b`,
returns `$2a`; `GetStoryLocationRecordPtr`, `$0a:$574e`, does the `*6`).
`LoadStoryLocationHeader` copies the record to `$c280`:

| addr | field |
| --- | --- |
| `$c280` | location id (`wStoryModeCurrentLocation`) |
| `$c281` | `wStoryLocationScene` — index into `SceneGfxSlotTable` |
| `$c282` | `wStoryLocationMapScriptsSlot` — low byte of a `$40xx` directory entry |
| `$c283` | ROM bank of that directory (copied to `wStoryLocationBank`, `$c29b`) |
| `$c284` | `wStoryLocationBGM` (`$ff` = leave the music alone) |
| `$c285` | pad |

`dslot Label` emits `db LOW(Label), BANK(Label)`. `CopyDataFromBank`
(`$00:$021a`) takes the pair in `hl`, banks in `h`, **forces `h = $40`**,
reads the word at `$40LL`, and copies `bc` bytes from there; each data bank
opens with a pointer directory at `$4000-$40ff`. The header uses it to fetch
the 14-byte `map_tree`.

The name popup's text id is computed, not stored: `$0179 + location`
(`$0a:$5142`) into `wStoryModeLocationNameTextId`, with
`wStoryModeShowLocationName = (wStoryModeEntryPoint != $ff)` — a door names
the room, returning from a menu screen does not. Ids `$01`-`$04` are
developer/test locations.

### The `map_tree`

Seven words copied to `$c286`, one per sub-table; in the source, seven `dw`
rows commented with their slot names (`include/macros/`):

| slot | WRAM ptr | content | consumer |
| --- | --- | --- | --- |
| 0 | `wMapEntryPointsPtr` `$c286` | `map_entry` records | `LoadStoryEntryPointRecord` |
| 1 | `wMapExitTriggersPtr` `$c288` | `map_script` records | `RunLocationExit` (`$0a:$560b`) |
| 2 | `wMapActorsPtr` `$c28a` | `map_actor` list | `InitLocationActors` → `SpawnActorsFromList` |
| 3 | `wMapNpcScriptsPtr` `$c28c` | `map_script` records | `RunNpcInteraction` (`$0a:$54b5`) |
| 4 | `wMapFacingScriptsPtr` `$c28e` | `map_script` records | `RunFacingTileScript` (`$0a:$5574`) |
| 5 | `wMapTileTriggersPtr` `$c290` | `map_script` records | `RunTileTriggerScript` (`$0a:$55dd`), `RunQueuedTriggerScript` (`$0a:$55a5`) |
| 6 | `wMapInitScriptPtr` `$c292` | native code | `RunLocationInitScript` (`$0a:$5495`) |

Each location bank `$0e`-`$15` opens with a directory sized to its locations
(bank `$10` eight slots, bank `$15` two), followed by the first `map_tree`:

| bank | locations |
| --- | --- |
| `$0e` | 17 Training Center, 28 Special Court, 29 Peach's Castle |
| `$0f` | 2 Small Char. Test, 25 Tournament, 26 Awards Ceremony |
| `$10` | 0 Main Menu, 1 Development, 3 Test (match select), 4 Test 2, 5 Academy Main Bldg., 6 Academy Wing, 13 Restaurant, 14 Cafeteria |
| `$11` | 11/12 Junior Class Court (singles/doubles), 20 Academy Entrance, 24 Center Court |
| `$12` | 9 Dorm Entrance, 16 Senior Class Court, 19 Wall Practice Room |
| `$13` | 7 Courtyard, 8 Restaurant Plaza, 10 Dorm Room |
| `$14` | 18 Tennis Machine Room, 22 Court #1, 23 Court #2, 27 Island Sky |
| `$15` | 15 Training Court, 21 Tournament Courtyard |
| `$27` | 30-41, the twelve "End*" epilogue rooms |

### `map_entry` — spawn records (8 bytes, `$ff`-terminated)

| off | field |
| --- | --- |
| +$00 | `MAPENTRY_ID`: entry-point id (matched against `wStoryModeEntryPoint`) |
| +$01 | `MAPENTRY_FACING`: facing (`FACE_*`) |
| +$02 | `MAPENTRY_X`: X (16-bit) |
| +$04 | `MAPENTRY_Y`: Y (16-bit) |
| +$06 | `MAPENTRY_SCRIPT`: `arrival_script` — same-bank code address, `$0000` = none |

The matched record goes to `wStoryMapRecord`, then is split into
`wStoryModeSpawnPosition` (X, Y, facing) and `wStoryArrivalScript`. X and Y
are written in tiles with a point (`map_pos` checks the form).

An entry id is local to its location (`$0f` returns from a match at the
Junior courts and flies to Peach's Castle from Island Sky). A scene an init
script runs for an entry is named `<Location><what it shows>Scene`
(`IslandSkyToPeachsCastleScene` serves two ids,
`TennisMachineRoomNoEntryScene` none); one whose role is still unknown keeps
`<Location>Entry<id>Scene`.

A row's optional last argument names it: `ENTRY_<location>_<name>` (the
`STORYLOC_*` suffix, then what reaches it or the scene it runs:
`ENTRY_DORM_ROOM_CONTINUE`, `ENTRY_ACADEMY_MAIN_BLDG_NEW_STUDENT`). An id
with no row (an init script's scene selector, the main menu's `TITLE`) is
named by an `entry_id` line in the same table. Stores, compares, return
points, the ending list and exit rows' `arg1` use the destination's names;
`make check` `entries` fails a name used for another location's id. The
fifteen debug-only rows stay unnamed, and so does `$00` in the End11 exit
(no Restaurant Plaza row; the first one is used).

The entry point is set by an exit's `arg1`, a code warp, the ending's
(location, entry) table, the return point, or a RAM value (the Training
Center's `wMapSceneStage2`). `STORYENTRY_NONE` (`$ff`) keeps the saved
position; an id with no `map_entry` row is a scene selector for the init
script. Only the awards ceremony splits by mode: doubles enters at `$0b`,
singles at `$0a`. Fifteen rows are reachable only from the debug warp menu
and are marked `; debug warp only` (`tools/routes.py` finds them; `make check`
`entries` keeps the marks true).

### `map_actor` — spawn templates (14 bytes, `$ff` sentinel)

| off | field |
| --- | --- |
| +$00 | `cond` — flag condition; when `EvalFlagCondition` rejects it the slot still spawns, as `ActorScript_Idle` with none of the fields below |
| +$02 | `objdef` — pointer to an actor script ([`actor_script.md`](actor_script.md)) |
| +$04 | X (16-bit) |
| +$06 | Y (16-bit) |
| +$08 | facing (`FACE_*`) |
| +$0a | object-def id (sprite/animation record) |
| +$0b | animation id |
| +$0c | palette override (0 = none) |

`SpawnActorsFromList` (`$04:$4cf7`) walks 14 bytes at a time and stops when
byte +9 is `$ff`; `map_actor_end` emits nine zero bytes plus that sentinel. A
slot may hold several back-to-back lists: scene variants swapped in by
`script_respawn_actors` (`ScriptRespawnLocationActors`, `$0a:$4152`, which re-runs
`InitLocationActors` with another list pointer).

Slots are fixed (`include/constants/`): `$00` `ACTOR_PLAYER`, `$01`
`ACTOR_PLAYER_SHADOW`, `$02` `ACTOR_PARTNER`, list entry *i* in slot `3+i`;
24 slots of `$40` bytes from `$d000`, WRAM bank `$04`.

#### Slot names

A row keeps its slot whatever its condition, so row order is the slot map.
Each `map_actor` row ends in a name, and the macro defines `ACTOR_<name>` as
`3 + row` (`ACTOR_MARIO_WORLD_PEACH`, `ACTOR_TRAINING_GYM_STUDENT_BLACK_HAIR_BOY_1`):
location plus object (`OBJ_*` without the prefix), numbered when a list holds
the same object twice. Scripts use these names, so inserting or reordering
rows renumbers every reference.

A slot is named only where the active list is certain at that line.
`tools/actorslots.py` follows control flow with the set of possible (list,
`NpcScripts` table) pairs:

* a location starts with its default list and table; the arrival script runs
  next, then the init script, each from what the previous step can leave;
* `script_respawn_actors` replaces the list, and `WriteStoryStateWord`
  into `wMapNpcScriptsPtr` the table, on that path only; a callee's installs
  reach its caller;
* the pairs active under player control are everything the init script and
  handlers can leave, iterated to a fixed point; a path that has written
  `wStoryModeExitTriggerRequest` leaves nothing (the Training Court, Academy
  Courts and Varsity Court tours, the Tournament Courtyard's
  `TournamentSiteArrivalScene` (entry `$0f`) and several ending scenes
  install lists on such paths);
* facing, tile and exit handlers and `as_call` routines run under any active
  pair, an `NpcScripts` handler only under pairs holding its table, and a
  routine dispatched through a `JumpToHL` table or inline `rst Rst00` jump
  table under its dispatcher's pairs;
* two locations pick their list from a flag-derived stage, and a branch on it
  narrows the list: the Senior Court's lists each belong to a set of
  `wMapSceneStage2` stages, the Tournament's round lists to the
  `wMapSceneStage` round `LoadIslandOpenRoundNpcs` sets (`STAGE_LISTS`); a
  stage-indexed table dispatches each entry under its own stage's lists;
* lists a script installs on a flag (the singles and doubles ending lists,
  the traveling teams, the doubles award ceremony, the Senior Court's
  singles list A and doubles list B, the Island Open round lists, which also
  hang on the semifinal flags) are bound to its value (`FLAG_LISTS`), and a
  `test_flag` branch keeps, on each side, the lists that agree; a
  location's default list is never bound, since it is active before any
  test;
* the Tournament's round-call tile triggers exist only once
  `LoadIslandOpenRoundNpcs` has written their cells, so they run only under
  its round lists — singles for trigger `$0f`, doubles for `$0e`
  (`TILE_LISTS`).

With several candidate lists, a row name fits only if its own list is one of
them and every candidate holds the same actor there. Among agreeing
candidates the name spells, in order of preference: one a second pass still
allows with the junior court's default lists bound to `FLAG_DOUBLES` (the
game picks that location by the flag; a debug warp need not, so the bound
only steers spelling, `HINT_LISTS`); one whose mode the nearest local label,
else the routine's name, says (`Singles`/`Doubles`); one the routine
installs; the location's default list; the one already named; the one most
of the routine's sites can be under; the shortest. A slot that means one thing across candidates anyway —
the same character under different scripts (the five seniors in all three
Senior Court lists) or whoever plays a part (Island Open slot `$0a` is this
round's opponent, Spike in one round and A. Coz in another) — gets a *role*
name, `ACTOR_ROLE_<location>_<role>`, declared with its lists in
`include/actor_roles.inc` (`actor_role SENIOR_COURT_FAY, $04, ...`), covering operands and
`NpcScripts` ids.

The sites the tool reaches carry slot names (row and role names,
script operands, `NpcScripts` ids); a few keep a number, and unreached code
keeps more. A PyBoy sweep that hooks each numbered site and records the
installed list and the slot's object agrees with the analysis wherever it
reached one. The numbered ones are:

* slots with no single part: a trophy in one list and a balloon in another;
  B. Coz in the doubles award ceremony but a walk-sprite student in the
  singles one, where the flow cannot tie the list to the branch;
* slots past the end of every candidate list: at run time the slot is
  empty (`DormRoomTravelingTeamMeetingTrigger_13` and
  `CenterCourtCreditsScene` position slots `$06` and `$0a`, which their
  lists never fill, so those lines move nothing), and the `NpcScripts` ids of locations whose lists are empty
  (the development map's sixteen, `RestaurantPlazaNpcScripts_13`'s `$03`);
* lines inside shared twin files;
* tables of locations the player never controls.

A routine also entered from somewhere the flow does not follow keeps a
number unless it installs its own list first. `actorslots.py` lists what is
left and renames what it can (`--apply`, which also respells names to the
preferred candidate). `make check` fails on a row name whose list cannot be
active there or whose slot holds a different actor in a possible list, and on a role name
used where an undeclared list is possible. `make slot-audit` checks every
name at run time over 36 story states and every location, comparing the
list `InitLocationActors` last installed.

### `map_script` — script records (8 bytes, `$ff`-terminated)

Slots 1, 3, 4, 5 share this shape and one lookup, `FindStoryScriptEntry`
(`$0a:$53e4`):

| off | field |
| --- | --- |
| +$00 | `MAPSCRIPT_ID`: `id` — matched against the lookup key (`$ff` terminates) |
| +$01 | `MAPSCRIPT_FACING_MASK`: `facing_mask` — `FACEMASK_*`; `$ff` matches any |
| +$02 | `MAPSCRIPT_FLAG_COND`: `flag_cond` — flag-id word, `$0000` = unconditional |
| +$04 | `MAPSCRIPT_HANDLER`: `handler` — text id if `< $4000`, else a code address in `wStoryLocationBank` |
| +$06 | `MAPSCRIPT_ARG0`: `arg0` |
| +$07 | `MAPSCRIPT_ARG1`: `arg1` |

`CheckTriggerFacingMask` (`$0a:$53bd`) maps `wPlayerMoveAngle`'s top two
bits through `FacingMaskTable_0a` to a PADF-layout bit and ANDs the mask, so
a record can apply only when approached from one side (one door tile serving
two rooms).

`flag_cond` goes through `EvalFlagCondition` (`$04:$4c49`); the record is
used when it returns **Z**:

* `$0000` — always.
* plain flag id (`byte<<8 | bit<<5`) — while the flag is **clear**.
* the same with bit 7 of the high byte set — only while the flag is **set**
  (bit 7 is cleared before testing).

So only flag bytes `$00`-`$7f` can appear in a condition. Several records
sharing an `id` with different guards, first match wins, is how NPCs change
their lines.

`arg0`/`arg1` per slot:

* **ExitTriggers** — destination location and entry point, written to
  `wStoryModeCurrentLocation` / `wStoryModeEntryPoint` after the handler
  (`$0a:$5637`): doors, warps, and the main-menu hand-off. A seventh argument
  names the id `EXIT_<location>_<name>` for the scripts that request it
  (`EXIT_DORM_ROOM_END_OF_DAY`); an ending scene's request is `_DONE`. Two
  requests stay raw for want of a row: `$0f` in `End3DormEntCutscene_27`
  and `$0e` in `Unused_10_RequestExitTrigger0e`.
* **NpcScripts** — `arg0` is a bitmask applied by `RunNpcInteraction`: bit 0
  turns the actor to face the player (player angle `+ $80`), bit 1 restores
  its facing afterwards, bit 3 forces animation 1 for the duration (old one
  in `wStoryScriptSavedActorAnim`), bit 4 sets `ACTORF_FLAGS` bits 0/1
  (freeze). The actor's `ACTORF_ANIM_RATE_MOVING` is forced to 1 and restored
  after (`wStoryScriptSavedActorAnimRate`).
* **TileTriggers via `RunQueuedTriggerScript`** — `arg0 == $01` makes the
  queued trigger a no-op (`$0a:$55c6`): live for an A-press, inert when
  walked over.
* FacingScripts and `RunTileTriggerScript` ignore the args.

An exit request of `$ff` matches nothing (it reads as the terminator), so it
means "reload without an exit script" — used by the full-screen pause-menu
screens.

### Running a handler

`RunStoryScriptOrDialogue` (`$0a:$541d`) takes the handler in `hl`, a
speaker/actor id in `a`:

* `hl == 0` — nothing.
* `hl & $c000 == 0` — **text id**: wait for the player to stop, then
  `ShowSpeakerDialogue` over speaker `a`.
* otherwise **code**: `CallHLInBankA` in `wStoryLocationBank`, wrapped in
  `BeginCutsceneScriptMode` / `EndCutsceneScriptMode`.

`BeginCutsceneScriptMode` (`$0a:$40d0`) detaches the follower (slot 1),
resets screen shake, and only when `hDebugStepMode` is nonzero registers
`ToggleCutsceneFastForward` (Start fast-forwards cutscenes in debug only).
`EndCutsceneScriptMode` re-attaches the follower
(`AttachActorWaypointFollower`, slot 1 following slot 0) and copies the
player's heading (`+$14`) into `wPlayerMoveAngle`.

An NPC handler's speaker id is the actor slot `FindActorFacingPlayer`
returned, which is also the record's `id`; `GetActorStateAddr` (`$0a:$4312`)
turns it into `$d000 + slot*$40`.

## Scenes: graphics, collision and the camera

`scene` indexes `SceneGfxSlotTable` (`$0a:$59d9`), 37 records of eight
`dslot` words. Records 0-15 are match courts (`LoadCourtSceneGraphics`,
`court_scene` rows); the overworld uses `$10`-`$24`. `SCENE_*` constants name
each record; its blob family (`SceneConfig`, `Palettes`, `Tiles`, `Tilemap`,
`Attrmap`, `CollisionMap`, `BehaviorMap`, and the `data/` files) uses the same
name in CamelCase (`SCENE_RESTAURANT` → `lz_RestaurantTilemap.tilemap`). The
courts have `ScoreboardColumnTiles`/`ScoreboardColumnAttrs` in place of
`SceneConfig`, `CollisionMap` and `BehaviorMap`.

`LoadStorySceneGraphics` (`$0a:$585d`) consumes the slots in this order:

| slot | destination | meaning |
| --- | --- | --- |
| 7 | `wDecompBuffer` (WRAM `$01`), then `$80` tiles to VRAM bank 1 `$9000` | BG tiles |
| 6 | skipped here; read per frame by the tile animator (below) | animation tiles |
| 5 | `$d400`, WRAM `$06` | behaviour map (1 KiB) |
| 4 | `$d000`, WRAM `$06` | collision map (1 KiB) |
| 3 | `wScreenAttrmap` (WRAM `$02`) | BG attribute map |
| 2 | `wShadowTilemap` (WRAM `$03`) | BG tilemap |
| 1 | 64 raw bytes to `wDecompBuffer`, palettes from +16 | palettes |
| 0 | 136 raw bytes to `wStorySceneRecord` (WRAM `$06`) | scene config |

Slots 2-5 and 7 are decompressed. For the 16 court records, read by the
court loader, slots 0 and 4 are `*ScoreboardColumnTiles` and slot 5 is
`*ScoreboardColumnAttrs` (`graphics_formats.md` §3.4).

`LoadStorySceneGraphics` reads scene-config bytes `+2..+5` (`scene_bounds`):
`wMapScrollMinX`, `wMapScrollMinY`, `wMapWidthTiles`, `wMapHeightTiles`
(`$0a:$5912`). `InitSceneTileAnimations` (`$0a:$639b`) copies the config
again and reads from `+8` (`wSceneTileAnimEntries`) a list of 4-byte
`scene_tile_anim src, count, dest, delay` steps, `$ff` (`scene_tile_anim_loop`)
closing each animation and `$fe` ending the list. `AdvanceSceneTileAnimation`
copies `count` tiles from tile `src` of the slot-6 sheet to tile `dest` of VRAM
bank 1 `$9000`. Six scenes animate (Courtyard, IslandSky, SpecialCourt,
TournamentCourtyard, PeachsCastle, AwardsCeremony): their slot 6 is a raw
96-tile `*SceneAnimTiles` sheet, one frame per 16-tile row. The rest have an
empty list; their slot 6 points at the next scene's config or at bank-end
padding (`*SceneNoAnimTiles`). Only animation slots 0-2 ever advance
(`UpdateSceneTileAnimations` stops at slot 3). The fixed `$88`-byte copies
over-read the 9-42-byte configs, harmlessly.

### The two 32x32 maps

`GetCollisionMapCellAddr` (`$0a:$5edd`) and `GetBehaviorMapCellAddr`
(`$0a:$5f31`) take `d` = X high byte, `e` = Y high byte and compute
`base + (Y & ~1) * 16 + (X >> 1)`: 32x32 cells of 2x2 tiles. Bases `$d000`
(collision) and `$d400` (behaviour), WRAM bank `$06`.

**Collision** is read by `IsTerrainBlockedAtPoint` (`$04:$534b`); only the
low nibble matters and only `$0f` blocks. `IsPointBlocked` (`$04:$533d`)
returns `$80 | terrain` for a wall, else `FindActorAtPoint`'s result, so
actors block too.

**Behaviour** cells are `high nibble = id, low nibble = kind`:

| low nibble | meaning | read by |
| --- | --- | --- |
| `$1` | step-on trigger; id queued in `wStoryModeTriggerScript` | `GetTileTriggerAtPlayer` (`$0a:$5369`), `CheckTileTriggerAtPoint` (`$04:$5141`) |
| `$3` | exit trigger; id to `wStoryModeExitTriggerRequest` | `CheckTileTriggerAtPoint` (`$04:$5160`) |
| `$8` | action tile; id is the `FacingScripts` id | `GetFacingTileInteractionId` (`$0a:$5200`) |
| `$c` | extended talk reach: `FindActorFacingPlayer` re-probes at `$03c0` ahead instead of `$01c0` | `$0a:$5247` |

`GetTileTriggerAtPlayer` checks the id against `TileTriggers` first, so a
cell with no record is inert. `ReadBehaviorMapCell` prints every result as
hex (`docs/bugs.md`).

Init scripts patch the maps. `SetupDormRoomSceneVariant` (bank `$13`)
block-copies rects of both maps with `CopyCollisionMapRect` /
`CopyBehaviorMapRect` (`$0a:$5f90`/`$5fd6`, copying *within* the map), and
`SetDormRoomEventTriggerCells_13` writes or clears nine step-on cells (id
`$0f`) with `WriteBehaviorMapCell` (from `$13:$5092`) by story progress.

### Camera and scroll

`UpdateCameraFromPlayer` (`$0a:$6235`): `wCameraX = playerX - $09f0`,
`wCameraY = playerY - $0af0` (`$100` per tile; roughly centres a 20x18
viewport), clamped per axis to `[wMapScrollMin*, wMapWidthTiles - $14]` /
`[..., wMapHeightTiles - $12]` in whole tiles. `InitSceneScroll` /
`UpdateSceneScroll` / `CopySceneTilemapRect` (`$0a:$5930`, `$5976`, `$619e`)
stream tilemap columns/rows from `wShadowTilemap`.

## NPCs and dialogue

An NPC is a `map_actor` (position, sprite, script) plus an `NpcScripts`
record keyed on its slot. The handler is usually a small routine that
indexes a per-NPC table of text ids by `wMapSceneStage` (`$c2b0`) and calls
`script_speak`. `wMapSceneStage` is per-location, derived from save flags by
the init script (`SetupCenterCourtStage`,
`InitTournamentSiteSceneVariant`, `ComputeIslandOpenRound`, …);
`wMapSceneStage2` (`$c2b1`) is a second selector some locations use.

Most academy NPCs are unnamed students and staff giving tips, labelled
`<Location>Npc<id>`. The named cast roster at `$30:$466d` serves the match
and ranking screens, not the overworld. Peach's Castle (29,
`MarioWorldMapScripts_0e`) is the exception: the Mario cast, one line each in
bank `$5e` (`Text_MarioWorldMarioMamaMia`-`Text_BobOmbWorldBelowExit`, ids `$308e`-`$30a8`).

`ShowSpeakerDialogue` (`$05:$581f`) takes the text id in `hl` and speaker in
`a`, resets the three text-argument queues, applies `wMessageSpeed`, picks a
voice, and opens a bubble over the actor. The location-name popup uses the
same engine (`ShowLocationNamePopup`, `$0a:$52f5`, via
`ShowSpeakerDialogueKeepOpen` with speaker `$83`, closing after 80 frames or
any input).

**There is no story bytecode VM.** Story flow is native code in the location
banks; the `script_*` macros wrap the register-setup + `farcall` sequences.
The overworld's interpreters are the text engine (`$05:$4e5d`) and the actor
VM (`StepActorScript`, `$04:$4229`; [`actor_script.md`](actor_script.md)).

## The pause menu

`RunStoryModeMenu` (`$06:$6e17`) stops scene tile animations, sets
`FLAG_HIDE_OVERWORLD_ACTORS`, opens a 3-row window at the bottom, and runs
the menu tree. `StoryMenuDefs` (`$06:$6ce0`) is six `menu_def` rows of
`STORYMENUITEM_*` ids, selected by `wPauseMenuId`:

| menu | items |
| --- | --- |
| 0 (root) | STATUS, CLEAR STATUS, OPTIONS, SAVE |
| 1 | CHAR. DATA, ITEMS |
| 2 | MESSAGES, MUSIC |
| 3 | SLOW / NORMAL / FAST |
| 4 | MUSIC ON / OFF |
| 5 | SAVE, TO MAIN MENU, CANCEL |

The three full-screen items (`$06:$6f66`, `$6f84`, `$6fa0`) back up the
player position into `wStoryModeSpawnPosition`, set `wStoryModeEntryPoint =
$ff` and `wStoryModeExitTriggerRequest = $ff`, and farcall the screen; on
return the `$ff` exit matches nothing and the location reloads with the
player in place.

* **STATUS → CHAR. DATA** — `ShowCharDataScreen` (`$1d:$4016`).
* **STATUS → ITEMS** — `ShowEquipmentStatusScreen` (`$3e:$5388`), the
  racket/shoe equip screen.
* **CLEAR STATUS** — `ShowGameProgressScreen` (`$1e:$7263`), read-only;
  unrelated to the developer `RunClearStatusSetupMenu` (see
  [Oddities](#oddities)).
* **OPTIONS** — `wMessageSpeed` and music on/off (persisted with
  `SetStorySlotMusicMuted`).
* **SAVE** — `SaveStoryReturnPoint` + `SaveStorySlotWithTimer`, then loc
  `$00` entry `$01`. "TO MAIN MENU" does the same without saving.

## Progression

### Two flag spaces

| | `wGameFlags` | save flags |
| --- | --- | --- |
| where | WRAM `$c9c0`-`$c9df` (32 bytes), in the saved story-slot image | SRAM `$a040`-`$a05f` |
| scope | per story slot | global |
| accessors | `rst $20/$28/$30` → `SetGameFlagCmd`/`ClearGameFlagCmd`/`TestGameFlagCmd` (`$00:$255e`/`$256b`/`$2551`, inline operand) over `SetGameFlag`/`ClearGameFlag`/`TestGameFlag` (`$00:$24ba`/`$24d4`/`$249f`); `*GameFlagByNumber` (`$00:$2509`/`$2523`/`$24ef`) for a computed id | `SetSaveFlag`/`ClearSaveFlag`/`TestSaveFlag` (`$03:$4db6`/`$4de4`/`$4d86`), which also bank in SRAM and rewrite the header checksum |
| names | `FLAG_*` in `include/flag_constants.inc` | `SAVEFLAG_*` in `include/constants/` |

Both use one encoding: flag number = `byte * 8 + bit`; the inline operand is
`bit << 5` then the byte index; the mask is `$80 >> bit`. `test_flag` leaves
**Z set when the flag is clear**.

`wGameFlags` bytes `$1c`-`$1f` (flags 224-255) are `wGameFlagsTemp`, zeroed
on every location load: scene-variant (`FLAG_TEMP_SCENE_VARIANT_A/B`) and
screen-mode bits that cannot outlive a map transition.

| bytes | contents |
| --- | --- |
| `$02`-`$05` | engine and debug bits (`FLAG_PLAYER_RUNNING`, `FLAG_HIDE_OVERWORLD_ACTORS`, `FLAG_CUTSCENE_FAST_FORWARD`, `FLAG_DEBUG_*`, `FLAG_STORY_MENU_LOCKED`, `FLAG_DOUBLES`) |
| `$06`-`$07` | Island Open bracket + Dream Match wins (doubles `$06`, singles `$07`) |
| `$08`-`$0b` | class ranking-match wins (doubles `$08`/`$09`, singles `$0a`/`$0b`) |
| `$0c`-`$0d` | equipment owned; ending-credits control bits |
| `$0e`-`$10` | NPC talked/moved/turned and scene-seen bits (`FLAG_RESTAURANT_NPC12_MOVED_STAGE_*`, `FLAG_REPAIR_COUNTER_*`, …) |
| `$11`-`$13` | `FLAG_TROPHY_EXP_GROUP_*_TIER_*`: one-time N64 trophy-EXP tiers (`TrophyExpTierFlags`) |
| `$14`-`$17` | `FLAG_UNLOCKED_<char>` (`$14`-`$15`: the 13 story-cast grid unlocks, set by story wins through `RewardUnlockCharFlags` and in every slot by the unlock codes), `FLAG_REACHED_ISLAND_OPEN_*`, `FLAG_STORY_COMPLETE_*`, `FLAG_REACHED_MARIO_WORLD_*`, `FLAG_ISLAND_OPEN_IN_PROGRESS` |
| `$18`-`$1b` | training-drill clears (Service / Net Game / Stroke match+practice, Tennis Machine, Wall) |

`SAVEFLAG_*` covers what survives a slot erase: character unlocks
(the six Mario-cast `SAVEFLAG_UNLOCKED_*`), arcade-minigame clears, court unlocks, the
per-slot option bits (A = music on/off, `SetStorySlotMusicMuted` from
`StoryPauseMenu_MusicToggle`; B = camera view, `SetStorySlotCourtView` from
`MatchPauseMenu_CameraSelect`), `SAVEFLAG_OPENING_SEEN`, and
`SAVEFLAG_DEBUG_TEST_MENU`.

### The ranking ladder and the tournament arc

`FLAG_DOUBLES` (flag 47) selects the singles or doubles arc; every
progression flag exists in both.

1. Class ranking matches at the Junior (loc 11/12), Senior (16) and Varsity
   courts — `FLAG_WON_{JUNIOR,SENIOR,VARSITY}_{SINGLES,DOUBLES}_RANK_n`.
2. Drills and machine/wall practice at the Training Center (17), Tennis
   Machine Room (18), Wall Practice Room (19), Training Court (15) —
   `FLAG_CLEARED_*`.
3. The Island Open, Tournament Courtyard (21) through Court #1/#2 (22/23),
   Center Court (24) and Tournament (25) —
   `FLAG_WON_ISLAND_OPEN_*_{ROUND_1,ROUND_2,SEMIFINAL,FINAL}` (`ROUND_2`
   singles only), with `FLAG_ISLAND_OPEN_IN_PROGRESS` while live.
4. Awards Ceremony (26) and Island Sky (27), where `FLAG_STORY_COMPLETE_*` is
   set (`$14:$7117`/`$7121`).
5. Peach's Castle (29) and Special Court (28), gated on
   `FLAG_REACHED_MARIO_WORLD_*`, hosting the Dream Match
   (`FLAG_WON_DREAM_MATCH_*`, granting `SAVEFLAG_UNLOCKED_MARIO`/`_PEACH`).

Stages read back as scene variation: `InitTournamentSiteSceneVariant`
(`$15:$4271`) and `SetupCenterCourtStage` (`$11:$41b6`) test the
bracket flags in descending order to derive `wMapSceneStage`;
`TournamentInitScript_0f` (`$0f:$620f`) derives the round with
`ComputeIslandOpenRound` and installs its actor list and `NpcScripts` table
with `LoadIslandOpenRoundNpcs` (`$0f:$6651`).

Win flags are set by each court's own post-match cutscene, not a shared
match-end routine: it checks `wMatchExitRequest` and `wMatchWinLoseFlag` and
sets the flag. E.g. on a win `JuniorClassCourtDoublesMatchReturn`
(`$11:$5d38`) reloads the court at entry `$0d`, and
`JuniorClassCourtDoublesVictoryScene` dispatches on
`wCurrentMatchIndex` (`$11:$5daa`) to `set_flag
FLAG_WON_JUNIOR_DOUBLES_RANK_{3,2,1}` (`.wonRank3`/`2`/`1`, `$11:$5db7`/
`$5ec0`/`$5fbd`). Arcade-minigame clears go to SRAM instead: `SetMinigameClearFlag`
(`$1e:$6edc`) indexes `MinigameClearFlagTable_1e` and calls `SetSaveFlag`.

`CheckAllProgressComplete` (`$1e:$6f8d`, from `ProcessMatchRewards` after
every rewarded match) walks 36 game flags — `AllProgressFlagList_1e` (both
Dream Matches, every class's rank-1 win in both arcs, both Island Open
finals) and, running past its end, the 26 drill/machine/wall clears of
`RewardFlagListTraining_1e` — and when all are set grants
`SAVEFLAG_COURT_STAR`. The Star Court is the exhibition unlock for finishing
everything in both arcs, granted on the completing match;
`FLAG_STORY_COMPLETE_*` itself grants nothing permanent.

### Story matches

A story match writes a big-endian id to `wCurrentMinigameStoryMatch`
(`$c8f6`) and calls `LoadMatchSettingsFromTable` (the `load_match_settings`
macro). High byte `wCurrentMatchList` = category (0 singles, 1 doubles,
2 minigame/training), low byte `wCurrentMatchIndex` = match; the `wCurrentMinigameStoryMatch` note in `ram/wram/` lists them all.

`LoadMatchSettingsFromTable` (`$0a:$4a5c`) indexes
`SinglesMatchSettingsTable_0a` (`$0a:$4ab2`) or `DoublesMatchSettingsTable_0a`
(`$0a:$4b2f`), 25 five-byte records each, by `low byte * 5`: `wGameMode`,
`wMatchOpponentChar`, `wCurrentlyUsedCourt`, a packed sets/games byte,
`wMatchBGM`. `FLAG_DEBUG_SHORT_MATCH` replaces the sets/games byte
with one set of two games.

`RunStoryMatch` (`$0a:$4962`) fades out, calls `AssignStoryMatchCharacters`
(`$0a:$49aa`) and `RunMatch`; on return a save-and-quit saves and goes to the
main menu, otherwise the caller's cutscene continues.
`AssignStoryMatchCharacters` fills the four on-court records via
`InitMatchRecordFromCharId`: selectors `$80`/`$81` copy the story main/partner
record, the opponent uses its character id, and its doubles partner comes
from `DoublesPartnerTable_0a` (`$0a:$49d9`) by opponent id.
`RestoreOverworldAfterMatch` (`$0a:$4991`) restores palettes and menu font.

`wGameMode` (`$c8a6`): 1 ranking, 2 Island Open, 3 practice, 5 training-court
minigames, 6 tennis machine, 7 wall practice, `$0a` Dream Match; 0 on every
location load. Match internals: [`match_engine.md`](match_engine.md).

### The ending

`RunEndingCreditsSequence` (`$0a:$6e74`) drives `RunStoryLocation`. It sets
`FLAG_ENDING_CREDITS_RUNNING` (suppressing BGM and the menu font load) and
walks `EndingCutsceneLocationList` (`$0a:$6e40`), 21 (location, entry point)
pairs: the twelve `$27` "End*" rooms plus Island Sky, Center Court, Peach's
Castle and Special Court. After each `RunStoryLocation`, unless
`FLAG_ENDING_CREDITS_PENDING` was raised, it freezes the actors, fades to
sepia and shows the next staff page, `ShowEndingCreditsStaffPage` (bank `$03`).
`ShowFinalCreditsCard` closes the sequence. The index is read with `ld a,
[wStoryCharacterSlot]`; the `byte0 == 0` branch at `$0a:$6ea4`-`$6eab`
computes `sprite * 2` and discards it, and no record has a zero first byte.

`RunStorySceneByMode` (`$18:$7617`): `b` picks the scene, `c` the artwork.
`PlayTravelingTeamVictoryScene` (from bank `$13`) ends on TO BE CONTINUED;
`PlayAwardsCeremonyScene` (from `$0f:$4e91`/`$556b`, gender-derived key) runs
the credits caption scroll and its own TO BE CONTINUED; `PlayDreamMatchEpilogueScene`
(from bank `$0e`) runs the ending credits on the first clear, then the
champion-medal screen with "The End", and sets `SAVEFLAG_OPENING_SEEN`. Bank
`$03` owns the scrolling staff roll (`RunStaffCreditsRoll`,
`$03:$59c5`) and the credits montage's staff pages (`ShowEndingCreditsStaffPage`).

## The character record

`$40` bytes, one layout in four places, each copy declared by `char_record`
(`include/macros/ram.inc`) as `<prefix><Field>`: `wSavedMain`, `wSavedPartner`,
`wStoryMain`, `wStoryPartner`, `wPlayer1Main`, `wPlayer1Partner`, `wPlayer2Main`,
`wPlayer2Partner`.

| base | what |
| --- | --- |
| `$c900` / `$c940` | live story main character / partner — `GetPlayerRecordPtr` (`$02:$4206`): `$c900` for selector 0, else `$c940` |
| `$c800` / `$c840` | a mirror of that pair, kept in step by a 128-byte copy and its own `RecomputeCharacterStats` (`$02:$4795`-`$47c2`) after an Iron racket or Iron shoes are dropped from the mirror's `+$3c`; front of the saved slot image |
| `$ca00` + slot*`$40` | the four on-court match characters — `GetMatchRecordPtr` (`$02:$420e`) |
| `StoryCharacterRecords_02` | ROM attribute database, 29 bytes per character id, copied to `+$0f`-`+$2b` |

Fields (code in `src/engine/story/*_02.asm`):

| off | field |
| --- | --- |
| +$00 | display name (ASCII, NUL-padded) |
| +$0b | character id (post-`RemapExtendedCharId`) |
| +$0c | palette index (`GetCharPaletteIndex`) |
| +$0d | gender (0 male, 1 female) |
| +$0e | left-handed flag |
| +$0f-$1e | AI / physics attributes (home-position strategy, reach windows, smash and dive speeds, skill-icon bits, reaction delays) |
| +$1f | AI difficulty (0 easy - 3 intense; 4-8 drill-feeder rows) |
| +$18 | level for player characters (1-99, capped `$63`), class tier for roster NPCs |
| +$20-$2a | eleven stat bars, 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop |
| +$2b | speed bonus, added to Speed by `LoadCharacterAttributes` |
| +$2c | EXP, 3-byte little-endian, capped at 99999 by `AddExpCapped` |
| +$2f | dead store (`docs/bugs.md`) |
| +$30-$37 | physics template, copied to `+$10`-`+$17` on every recompute |
| +$38-$3b | trainable levels: Spin, Power, Control, Speed |
| +$3c | equipment: low nibble racket, high nibble shoes |
| +$3d-$3f | never written or read |

`+$18` is `wStoryMainLevel` (`$c918`; the save copy is
`wSavedMainLevel`, `$c818`); for player characters the byte is a
level, and `LookupExpTierForChar` (`$1e:$693e`,
`src/engine/menus/exp/award_calc_1e.asm`) derives the coarse 0-6 tier from it.

`InitMatchRecordFromCharId` (`$02:$4066`) zeroes the 64 bytes, then by
selector: `$ff` empty (`+$0b = $ff`); `$90` the "main character" placeholder;
bit 7 set copies the story record at `$c900 + (b & 1) * $40`; bit 7 clear
loads character id *b* from `StoryCharacterRecords_02`, fetching the name
text and stamping the palette index.

### Stats

`RecomputeCharacterStats` (`$02:$44e9`) derives the eleven bars from the four
trainable levels:

```
raw  = level_byte * 5 - (record[+$18] - 1)      ; ScaleStatForBarLevel, clamped to a signed byte
bar  = count of thresholds raw clears (0-9)     ; LookupStatBarLevel, 9-entry signed table
```

`record[+$0b] & 3` picks one of four 113-byte archetype tables via
`StatArchetypePtrs_02` (`AlexStatArchetype_02`-`KateStatArchetype_02` by hero
id, laid out as `STATARCH_*`):
a tier byte, the 12-byte template copied to `+$30`-`+$3b` at build time,
eleven `stat_thresholds` rows, then (level, icon) modifier pairs to a `$ff`
(every archetype has none).

| trainable level | feeds |
| --- | --- |
| +$38 Spin | Top, Slice |
| +$39 Power | Serve, Stroke, Volley |
| +$3a Control | Angle, Placement |
| +$3b Speed | Speed, Dash, Reaction, Stop |

Since `+$18` is subtracted, a bar grows only when its category is trained
ahead of the overall level: growth is a budget across categories.

It then copies `+$30`-`+$37` to `+$10`-`+$17` and, **only when the record
base's low byte is zero** (`$c800`, `$c900`, `$ca00`; not
`$c840`/`$c940`/`$ca40`/`$ca80`/`$cac0`), calls `ApplyStatModifiers`
(`$02:$468e`), so equipment bonuses apply to the main character only. That
adds a signed per-stat row for each nibble of `+$3c` from
`RacketStatDeltas_02` (7 rows) and `ShoeStatDeltas_02` (`$02:$475f`, 3 rows),
`equip_stat_deltas` rows.

Ownership is `FLAG_HAVE_*_RACKET` / `FLAG_HAVE_*_SHOES` (`wGameFlags`
`$0c`/`$0d`); the equip screen (`HandleEquipSelectInput`, bank `$3e`)
read-modify-writes `+$3c`.

### EXP and levelling

`LevelUpPlayerRecord` (`$02:$49c1`, `src/engine/story/equip_02.asm`)
increments `+$18` (cap 99), bumps the trainable level chosen by `d` = 0-3,
and recomputes. `LevelUpPlayer` is the far entry via `GetPlayerRecordPtr`;
`ComputeLevelUpStatDeltas` snapshots the bars before and after for the
level-up arrows.

`AddPlayerExp` → `AddExpCapped` (`src/engine/story/records_02.asm`) adds EXP.
`ExpLevelThresholds_02` is cumulative, 3 bytes per level (`exp_threshold`
rows, 99 levels), `$ff,$ff,$ff`-terminated, indexed by `(level-1)*3`, read by
`GetExpRequiredForLevel`, `GetExpRemainingToNextLevel`,
`GetExpProgressInCurrentLevel` and `HasReachedNextLevelExp`. The two
`GetExp*` readers use only the low two bytes, which suffices since the
level-99 requirement is under 65536. Awards are staged per source
(`wPendingExpExhibition`, `wPendingExpLinked`, and the N64 transfer words
`wN64TransferMainExp`/`wN64TransferPartnerExp`, which no ROM code fills) and applied by `ApplyPendingExpAwards` (`$1e:$6afd`) on
the next slot load; `ScaleExpByPlayerLevel` averages the two story records'
`+$18` and scales by x1, x1.5, x2 … x3.5 in steps of 10 levels, x4 from 60.

### Save signature

`wStorySaveSignature` (`$c880`, 4 bytes) tells apart otherwise identical
slots. `GenerateUniqueStorySaveSignature` (`src/engine/story/story_02.asm`)
seeds it from `wStoryRandomBytes` and re-rolls until
`CheckStorySignatureCollision` passes against the cached per-slot signatures
(`CacheStorySlotSummaries` puts each at `$d400 + slot*4`); all-zero counts as
a collision. Called once, on new game (`$10:$5076`).

The image `$c800`-`$caff` is saved as block `2N` for slot *N* plus a backup at
`$1b + 2N` (`SaveStorySlotWithTimer`, `$03:$4d10`); see
[`save_format.md`](save_format.md).

## WRAM state

The working set is `$c280`-`$c2ff` (WRAM bank 0), plus the actor array (bank
`$04`) and the two maps (bank `$06`). `$c280`-`$c285` is the copied location
header and `$c286`-`$c293` the `map_tree` pointers (above). Per-address
notes are in `ram/wram/`.

Other addresses: `$c295` `wStoryModeEntryPoint`, `$c296`
`wStoryModeSpawnPosition` (5 bytes), `$c29c` `wStoryArrivalScript`, `$c2c0`
`wStoryMapRecord` (8 bytes, the matched `map_entry`/`map_script`),
`$c2d5`-`$c2d7` the name popup, `$c2d8`-`$c2da` `wStoryScriptSavedActorAnimRate`
/ `…Anim` / `wStoryScriptRan`; `$c294` `wUnusedExitTriggerIdMirror` and `$c2db`
`wUnusedStoryScriptId` (write-only); `$c2b2`-`$c2bf` per-location scratch;
`$c2d0`-`$c2d4` `wStoryModePlayersXPosition`/`…YPosition`/`wStoryModePlayerFacing`
(player snapshot, refreshed by `UpdateActors`); `$c32e` `wCurrentScene`
(scene last loaded); `$c36c` `wCurrentStorySlot` (0-2; `$0f` none, `$03`+ not
a story slot); `$c800`-`$caff` `wStorySlotData` (records, flags, match
settings); `$dc08` `wStorySceneRecord` (bank `$06`).

## Oddities

* **`Unused_0a_EvalFlagCondition`** (`$0a:$53a2`, between
  `GetTileTriggerAtPlayer`'s `ret` and `FacingMaskTable_0a`) duplicates the
  live `$04:$4c49`; nothing calls it.
* **The clear-status flag writers.** `SetTrainingCourtClearFlags`
  (`$0a:$4da9`) clears 28 flags from byte `$18` (every `FLAG_CLEARED_*` but
  the two `_EXPERT`) and re-sets the level-1 or level-1+2 subset from
  `TrainingCourtLevel1/2ClearFlags_0a`. `SetSinglesRankingClearFlags`
  (`$0a:$4e0e`) clears the nine singles `FLAG_WON_*_SINGLES_RANK_*` and sets
  as many of `SinglesRankingClearFlagList_0a` as the chosen class and rank
  imply; `SetDoublesRankingClearFlags` (`$0a:$4e75`) does the same from
  `DoublesRankingClearFlagList_0a` but clears the singles block too
  (`docs/bugs.md`). The lists are `flag_id` rows. Arcade minigames are not
  touched (their writer is `SetMinigameClearFlag`).
* **`RunClearStatusSetupMenu` is a developer tool**, reached via location 4
  "Test 2": `Test2InitScript_10` (`$10:$4b9b`), for any entry but `$0f`,
  farcalls `ClearStatusSetupMenuEntry` and leaves by the exit id the menu
  returns (`Test2ExitTriggers_10`: Training Court, Junior or Senior court,
  Courtyard, main menu). `$0a:$4bac` walks Set/Continue →
  Mini-Game/Ranking-Match → level, then `ApplyClearStatusFlags`
  (`$0a:$4d80`) rewrites the progression flags; "Continue" makes it a no-op.
  Menu state is in WRAM bank `$05` over the idle far-P1 character struct
  (`wClearStatusMode` / `Doubles` / `Format` / `Class` / `Rank` / `WindowId`
  / `ResultCode`, `$df00`-`$df06`, range-scoped).
  `Unused_0a_TrainingCourtClearFlagListPtrs` (`$0a:$4dec`) parallels the branches
  but has no reader.
* **`$ff, $c9` list endings.** The `$c9` after the `$ff` of
  `JuniorClassCourtSinglesEntryPoints_11`,
  `JuniorClassCourtDoublesFacingScripts_11` and `…TileTriggers_11` is an
  unreferenced one-byte `ret` script, carved as `Unused_11_NullScriptA`-`C`.
  `FireworkMapActors_14` (`$14:$6675`) carries one `$00` past
  `map_actor_end` (padding before a 2 KiB tile blob), rendered as `db $00`.
