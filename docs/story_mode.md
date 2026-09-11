# Story Mode

Story mode is the game's RPG shell: a tile-scrolled overworld with an actor
engine, per-location script tables, dialogue, a pause menu with status screens,
and a progression system built entirely out of flag bits. It is also the *host*
for everything else — the title screen and main menu run as location `$00` of the
same engine (see [Entry](#entry-and-top-level-flow)), so almost every frame the
cartridge executes is inside the story-mode loop.

Where the pieces live:

| bank | role |
| --- | --- |
| `$0a` | the overworld engine: location loop, script dispatch, scene loader, collision/behaviour maps, camera, cutscene helpers |
| `$04` | actor engine: spawning, per-frame stepping, player control, the actor-script VM |
| `$0e`-`$15` | location script data + hand-written location code for the 30 playable locations |
| `$27` | the same, for the 12 epilogue ("End1".."End17") locations |
| `$5f`-`$66` and neighbours | scene assets (tiles, tilemaps, attribute maps, collision/behaviour maps) reached through `$4000` slot directories |
| `$02` | character records, the stat pipeline, EXP/level, save signatures |
| `$03` | save engine, `SAVEFLAG_*` accessors, the scrolling-text/credits cutscene renderer |
| `$05` | text engine and dialogue windows (control-code interpreter at `$05:$4e5d`) |
| `$06` | the story pause menu |
| `$18` | full-screen "screen sequence" beats (`RunStorySceneByMode`) |

Related references: [`actor_script.md`](actor_script.md) (the actor bytecode),
[`save_format.md`](save_format.md) (SRAM layout), [`ram_map.md`](ram_map.md)
(every WRAM address named here).

## Entry and top-level flow

Boot reaches `InitAndRunGame` (`$01:$4018`, from `$00:$262c`), which
initialises SRAM and story state and then does this:

```
ld hl, wStoryModeCurrentLocation / ld [hl], STORYLOC_MAIN_MENU
ld hl, wStoryModeEntryPoint      / ld [hl], $0a
farcall RunStoryModeOverworld
```

`RunStoryModeOverworld` (`$0a:$4f2c`) is an infinite loop: clear the frame-task
list, register the player-position debug overlay, `call RunStoryLocation`,
repeat. Every location change is therefore a *return* from `RunStoryLocation`
followed by a fresh load — there is no location-to-location transition path.

Location `$00` is "Main Menu". Its `InitScript` (`MainMenuInitScript_10`,
`$10:$4eb9`) parks the player actor off-map at `($3f00,$3f00)` and calls
`RunTitleAndMainMenuLoop` (`$10:$4f0d`), which runs the logo, intro cutscene,
title screen and main menu, and does not return until the player has committed
to something. To *leave* the menu it writes `wStoryModeExitTriggerRequest`; the
location loop then looks that id up in `MainMenuExitTriggers_10` and reads the
destination out of the record:

| exit id | destination | when |
| --- | --- | --- |
| `$01` | loc `$14` Academy Entrance, entry `$0f` | new game (`$10:$5081`) |
| `$02` | loc `$0a` Dorm Room, entry `$01` | ordinary continue |
| `$03` | loc `$04` "Test 2", entry `$01` | `FLAG_DEBUG_SKIP_LOCATION_EXIT` shortcut |
| `$04` | loc `$06` Academy Wing, entry `$0f` | Island Open final won, story not yet flagged complete |
| `$05` | loc `$1d` Peach's Castle, entry `$0f` | story complete, Mario World not yet visited |

`GetStoryContinueDestination` (`$10:$5752`) picks between `$02`/`$04`/`$05` by
testing, in order, `FLAG_WON_ISLAND_OPEN_*_FINAL`, `FLAG_STORY_COMPLETE_*` and
`FLAG_REACHED_MARIO_WORLD_*`, with `FLAG_DOUBLES` selecting the singles or
doubles arc. So "where you resume" is derived from flags, not stored.

`SaveStoryReturnPoint` / `RestoreStoryReturnPoint` (`$0a:$527f`/`$52ae`) hold a
location + entry point + 5-byte position (`wStoryReturnLocation`,
`wStoryReturnEntryPoint`, `wStoryReturnPosition`). Called with `b = $ff` it
snapshots the live position and stores entry point `$ff` (meaning "no door —
restore the exact position"); the save/quit path calls it with an explicit
`b`/`c` pair (`$06:$706a` uses `b=$0a, c=$01`, the dorm room).

## The location loop

`RunStoryLocation` (`$0a:$4f40`) is the whole overworld in one function. Load
phase, in order:

1. `BeginFadeOut`, `ClearTemporaryStoryFlags` (zeroes `wGameFlags` bytes
   `$1c-$1f`), `ClearStoryEventRequests` (zeroes the six bytes `$c2a0-$c2a5`).
2. `LoadStoryLocationHeader` (`$0a:$5114`) — see [Location data](#location-data).
3. `LoadStoryEntryPointRecord` (`$0a:$516f`) — searches the location's
   `EntryPoints` table for `wStoryModeEntryPoint` and fills
   `wStoryModeSpawnPosition` (X, Y, facing) and `wStoryArrivalScript`. If the id
   is `$ff` the whole step is skipped and the existing spawn buffer is used
   (that is how the game returns you to the exact spot after a full-screen
   sub-screen). If the id is not found, record 0 is used as the fallback.
4. `wGameMode = 0`, start `wStoryLocationBGM` unless it is `$ff` or the ending
   credits are running.
5. `InitLocationActors` (`$0a:$5466`): reset the actor engine, spawn the main
   character at the spawn position, spawn the companion, then
   `SpawnActorsFromList` over the location's `map_actor` list.
6. Load object palettes, the scene graphics (`LoadStorySceneGraphics`), and the
   scrolled tilemap; enable the LCD.
7. Run the entry point's `arrival_script` (if nonzero) through
   `CallHLInBankA` in `wStoryLocationBank`, then `RunLocationInitScript`.
8. If an exit was already requested (an init script can request one), run
   `RunLocationExit` and return immediately — otherwise fade in and, when
   `wStoryModeShowLocationName` is set, show the location-name popup.

### The frame loop

`.frameLoop` (`$0a:$4ff5`) switches to WRAM bank `$04` and then checks
`CheckStoryEventRequests` — the OR of the six request bytes `$c2a0-$c2a5`. If
*none* is set it drops into `.waitForEvent`, which attaches the player's
controller script and idles frame-by-frame until a request appears. If a request
*is* pending it re-installs `ActorScript_0a` on the player (a 6-byte script that
just halts, i.e. hands control back to the player), then tests the requests in a
fixed order:

| order | request | handler |
| --- | --- | --- |
| 1 | `wStoryModeTriggerScript` (`$c2a0`) | `RunQueuedTriggerScript` — a step-on trigger queued by the movement code |
| 2 | `wStoryModeExitTriggerRequest` (`$c2a1`) | `RunLocationExit`, then return (reload) |
| 3 | `wStoryModeMenuRequest` (`$c2a5`) | wait for the player to stop, then `RunStoryModeMenu` unless `FLAG_STORY_MENU_LOCKED` |
| 4 | auto-interact arming (`$c2a2`) | if the player has been walking into the same direction for `>= $1e` frames, raise an interact request itself |
| 5 | `wStoryModeInteractRequest` (`$c2a4`) | `FindActorFacingPlayer` → `RunNpcInteraction`; if no script ran, `GetFacingTileInteractionId` → `RunFacingTileScript`; if still nothing, `GetTileTriggerAtPlayer` → `RunTileTriggerScript` |
| 6 | debug menu | if `hDebugStepMode` is nonzero and the interact was not auto-fired, `RunDebugMenu` |

`wStoryScriptRan` (`$c2da`) is the "did anything handle this" flag:
`RunStoryScriptOrDialogue` sets it, and the loop clears it before step 5 so the
NPC → facing-tile → step-on cascade stops at the first handler that fires.

The auto-interact rule (step 4) is what makes walking into a door work without
pressing A: `UpdatePlayerControl` (`$04:$52a6`) sets `wStoryAutoInteractArmed`
whenever the point ahead of the player is blocked, and the loop converts a
sustained push against that obstacle into an interact request, recording
`wStoryAutoInteractFired = $ff` so the debug-menu check is suppressed.

Player input is read in `UpdatePlayerControl` (`$04:$516b`): A raises
`wStoryModeInteractRequest` **and** probes the tile under the player
(`CheckTileTriggerAtPoint`), Start raises `wStoryModeMenuRequest`, holding B sets
`FLAG_PLAYER_RUNNING` (which selects walk speed `$0040` instead of `$0020`), and
the D-pad direction becomes `wPlayerMoveAngle` via `DpadMaskToAngleTable_04`.

## Location data

### The location record

`StoryLocationTable_0a` (`$0a:$564f`) is 42 six-byte `story_location` records
indexed by `wStoryModeCurrentLocation`; `GetStoryLocationCount` (`$0a:$574b`)
returns `$2a` and `GetStoryLocationRecordPtr` (`$0a:$574e`) does the `*6`.
Fields: `id`, `scene`, a two-byte `dslot` reference to the map-script tree, and
`bgm` (`$ff` = leave the music alone).

`LoadStoryLocationHeader` copies all six bytes to `wStoryModeCurrentLocation`
($c280), so the loaded header is simply the record in place:

| addr | field |
| --- | --- |
| `$c280` | location id |
| `$c281` | `wStoryLocationScene` — index into `SceneGfxSlotTable` |
| `$c282` | `wStoryLocationMapScriptsSlot` — low byte of a `$40xx` directory entry |
| `$c283` | ROM bank of that directory (copied out to `wStoryLocationBank`, `$c29b`) |
| `$c284` | `wStoryLocationBGM` |
| `$c285` | pad |

The `dslot` indirection is worth spelling out because it appears everywhere in
this game. `dslot Label` emits `db LOW(Label), BANK(Label)`. `CopyDataFromBank`
(`$00:$021a`) takes that pair in `hl`, banks in `h`, **forces `h = $40`**, reads
the word at `$40LL`, and copies `bc` bytes from there. So each data bank opens
with a pointer directory in `$4000-$40ff` and a slot is addressed by one byte.
The location header uses it to fetch 14 bytes — the `map_tree`.

The location name popup is not stored in the record: `LoadStoryLocationHeader`
computes text id `$0179 + location` (`$0a:$5142`) into
`wStoryModeLocationNameTextId`, and sets `wStoryModeShowLocationName` from
`wStoryModeEntryPoint != $ff` — arriving through a door names the room, coming
back from a menu screen does not. The ids `$00`-`$04` are developer/test locations.

### The `map_tree`

The 14 bytes are seven words, copied to `$c286`, one per sub-table. The
disassembler renders them with the `map_tree` spec and names the slots from
`MAP_TREE_SLOTS`:

| slot | WRAM ptr | content | consumer |
| --- | --- | --- | --- |
| 0 | `wMapEntryPointsPtr` `$c286` | `map_entry` records | `LoadStoryEntryPointRecord` |
| 1 | `wMapExitTriggersPtr` `$c288` | `map_script` records | `RunLocationExit` (`$0a:$560b`) |
| 2 | `wMapActorsPtr` `$c28a` | `map_actor` list | `InitLocationActors` → `SpawnActorsFromList` |
| 3 | `wMapNpcScriptsPtr` `$c28c` | `map_script` records | `RunNpcInteraction` (`$0a:$54b5`) |
| 4 | `wMapFacingScriptsPtr` `$c28e` | `map_script` records | `RunFacingTileScript` (`$0a:$5574`) |
| 5 | `wMapTileTriggersPtr` `$c290` | `map_script` records | `RunTileTriggerScript` (`$0a:$55dd`), `RunQueuedTriggerScript` (`$0a:$55a5`) |
| 6 | `wMapInitScriptPtr` `$c292` | native code | `RunLocationInitScript` (`$0a:$5495`) |

Each of the eight location banks `$0e`-`$15` opens with a directory sized to the
number of locations it hosts (bank `$10` has eight slots, bank `$15` two), and
the first `map_tree` follows immediately. Bank `$27` holds twelve more trees for
the epilogue locations. Distribution, cross-referenced from
`StoryLocationTable_0a`:

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
| +$00 | entry-point id (matched against `wStoryModeEntryPoint`) |
| +$01 | facing (`FACE_*`) |
| +$02 | X (16-bit) |
| +$04 | Y (16-bit) |
| +$06 | `arrival_script` — same-bank code address, `$0000` = none |

`LoadStoryEntryPointRecord` copies the matched record to `wStoryMapRecord`, then
splits it into `wStoryModeSpawnPosition` (X, Y at +0..+3, facing at +4) and
`wStoryArrivalScript`.

### `map_actor` — spawn templates (14 bytes, list ends on a `$ff` sentinel)

| off | field |
| --- | --- |
| +$00 | `cond` — flag condition; the actor is *skipped* if it is met |
| +$02 | `objdef` — pointer to an actor script (see [`actor_script.md`](actor_script.md)) |
| +$04 | X (16-bit) |
| +$06 | Y (16-bit) |
| +$08 | facing (`FACE_*`) |
| +$0a | object-def id (sprite/animation record) |
| +$0b | animation id |
| +$0c | palette override (0 = none) |

`SpawnActorsFromList` (`$04:$4cf7`) walks 14 bytes at a time and stops when a
record's byte +9 is `$ff`; `map_actor_end` emits the nine zero bytes plus that
sentinel. A slot may hold several back-to-back lists — the extra ones are scene
variants swapped in at runtime by `ScriptRespawnLocationActors` (`$0a:$4152`,
which just re-runs `InitLocationActors` with a different list pointer).

Actor slots are assigned in a fixed order (`include/constants.inc`): `$00`
`ACTOR_PLAYER`, `$01` `ACTOR_PLAYER_SHADOW`, `$02` `ACTOR_PARTNER`, then list
entry *i* lands in slot `3+i`. There are 24 slots of `$40` bytes from `$d000` in
WRAM bank `$04`.

### `map_script` — the script records (8 bytes, `$ff`-terminated)

Four of the seven slots share this record shape, and one lookup function,
`FindStoryScriptEntry` (`$0a:$53e4`), serves all of them:

| off | field |
| --- | --- |
| +$00 | `id` — matched against the lookup key (`$ff` terminates the table) |
| +$01 | `facing_mask` — `FACEMASK_*`; `$ff` matches any |
| +$02 | `flag_cond` — flag-id word, `$0000` = unconditional |
| +$04 | `handler` — text id if `< $4000`, otherwise a code address in `wStoryLocationBank` |
| +$06 | `arg0` |
| +$07 | `arg1` |

`facing_mask` is checked by `CheckTriggerFacingMask` (`$0a:$53bd`), which maps
`wPlayerMoveAngle`'s top two bits through `FacingMaskTable_0a` to a PADF-layout
bit and ANDs it with the mask — so a record can be restricted to "only when
approached from below", which is how one door tile can serve two rooms.

`flag_cond` goes through `EvalFlagCondition` (`$04:$4c49`), and the polarity is
easy to get wrong: the record is used when the evaluation returns **Z**.

* `$0000` — always used.
* plain flag id (`byte<<8 | bit<<5`) — used while the flag is **clear**.
* the same with bit 7 of the high byte set — used only while the flag is
  **set** (the handler clears bit 7 before testing).

Because bit 7 of the byte index is the negation flag, only flag bytes `$00`-`$7f`
can appear in a condition. This is the mechanism behind almost all "the NPC says
something different now" behaviour: several records share an `id`, each with a
different flag guard, and the first match wins.

`arg0`/`arg1` are interpreted per slot:

* **ExitTriggers** — `arg0` = destination location, `arg1` = destination entry
  point, written straight into `wStoryModeCurrentLocation` /
  `wStoryModeEntryPoint` after the handler runs (`$0a:$5637`). This is the door
  and warp mechanism, and also how the main menu hands off to the story
  (see [Entry](#entry-and-top-level-flow)).
* **NpcScripts** — `arg0` is a behaviour bitmask applied around the handler by
  `RunNpcInteraction`: bit 0 turns the actor to face the player (player angle
  `+ $80`), bit 1 restores its original facing afterwards, bit 3 forces
  animation 1 for the duration (saving the old one in
  `wStoryScriptSavedActorAnim`), bit 4 sets state bits 0/1 at `+$05` (freeze).
  The actor's `+$19` busy byte is forced to 1 throughout and restored after
  (`wStoryScriptSavedActorBusy`).
* **TileTriggers reached via `RunQueuedTriggerScript`** — `arg0 == $01` makes the
  queued trigger a no-op (`$0a:$55c6`), so a tile can be live for a deliberate
  A-press but inert when merely walked over.
* FacingScripts and `RunTileTriggerScript` do not read the args.

An exit request of `$ff` matches nothing (the search sees `$ff` as the
terminator), so `$ff` means "reload the current location without running an exit
script" — which is exactly what the full-screen pause-menu screens use.

### Running a handler

`RunStoryScriptOrDialogue` (`$0a:$541d`) takes the handler in `hl` and a
speaker/actor id in `a`:

* `hl == 0` — nothing to do.
* `hl & $c000 == 0` (i.e. `< $4000`) — it is a **text id**: wait for the player
  to stop moving, then `ShowSpeakerDialogue` with `a` as the speaker. Bank
  `$05`'s dialogue engine opens the bubble over that actor.
* otherwise — it is **code**. Wrap in `BeginCutsceneScriptMode` /
  `EndCutsceneScriptMode` and call it via `CallHLInBankA` in
  `wStoryLocationBank`.

`BeginCutsceneScriptMode` (`$0a:$40d0`) detaches the player's follower actor
(slot 1), resets the screen shake, and — only when `hDebugStepMode` is nonzero —
registers `ToggleCutsceneFastForward`, so Start-to-fast-forward a cutscene is a
debug-build feature. `EndCutsceneScriptMode` re-attaches the follower
(`AttachActorWaypointFollower` with slot 1 following slot 0) and copies the
player actor's facing back into `wPlayerMoveAngle`.

The speaker id for an NPC handler is the *actor slot index* that
`FindActorFacingPlayer` returned, which is also the record's `id` field — the
same value `GetActorStateAddr` (`$0a:$4312`) turns into `$d000 + slot*$40`.

## Scenes: graphics, collision and the camera

A location's `scene` byte indexes `SceneGfxSlotTable` (`$0a:$59d9`), 37 records
of eight `dslot` words. Records 0-15 are the match courts (loaded by
`LoadCourtSceneGraphics` from the `court_scene` rows); the overworld uses
`$10`-`$24`, which is exactly the range the `story_location` records reference.
The `SCENE_*` constants name each record for what loads it, and both tables
and the scene table's row comments use them. Each scene's blob family (its
`SceneConfig`, `Palettes`, `Tiles`, `Tilemap`, `Attrmap`, `CollisionMap` and
`BehaviorMap` labels, and the `data/` files named after them) carries the
same name in CamelCase, so `SCENE_RESTAURANT`'s tilemap is
`lz_RestaurantTilemap.png`; the families were first named by looking at the
pictures, and several of those guesses (a "spa resort" for the restaurant,
a "ceremony hall" for Peach's Castle) were wrong.

`LoadStorySceneGraphics` (`$0a:$585d`) reads the eight slots and consumes them in
this order:

| slot | destination | size / meaning |
| --- | --- | --- |
| 7 | decompressed to `wDecompBuffer` (WRAM `$01`), then `$80` tiles to VRAM bank 1 `$9000` | BG tile graphics |
| 6 | **discarded** — see the bug note below | intended for `wStorySceneUnusedBuffer` |
| 5 | decompressed to `$d400`, WRAM bank `$06` | the **behaviour map** (1 KiB) |
| 4 | decompressed to `$d000`, WRAM bank `$06` | the **collision map** (1 KiB) |
| 3 | decompressed to `wScreenAttrmap` (WRAM `$02`) | BG attribute map |
| 2 | decompressed to `wShadowTilemap` (WRAM `$03`) | BG tilemap |
| 1 | 64 raw bytes to `wDecompBuffer`, palettes taken from +16 | palettes |
| 0 | 136 raw bytes to `wStorySceneRecord` (WRAM `$06`) | scene config |

Only four bytes of the scene config are ever read: `+2..+5` become
`wMapScrollMinX`, `wMapScrollMinY`, `wMapWidthTiles`, `wMapHeightTiles`
(`$0a:$5912`). The fixed `$88`-byte copy over-reads the config blob (the carved
blobs are 27-42 bytes), which is harmless.

### The two 32x32 maps

`GetCollisionMapCellAddr` (`$0a:$5edd`) and `GetBehaviorMapCellAddr` (`$0a:$5f31`)
take `d` = X high byte, `e` = Y high byte and compute
`base + (Y & ~1) * 16 + (X >> 1)` — i.e. a 32x32 byte grid whose cells are two
map units on a side, with a 32-byte row stride. Collision base is `$d000`,
behaviour base `$d400`, both in WRAM bank `$06`.

**Collision** is read by `IsTerrainBlockedAtPoint` (`$04:$534b`), and only the
low nibble matters: `$0f` blocks, everything else (including other nonzero
values) does not. `IsPointBlocked` (`$04:$533d`) returns `$80 | terrain` for a
wall or, failing that, the result of `FindActorAtPoint` — so live actors block
movement too.

**Behaviour** encodes triggers as `high nibble = id, low nibble = kind`:

| low nibble | meaning | read by |
| --- | --- | --- |
| `$1` | step-on trigger; the high nibble is queued in `wStoryModeTriggerScript` | `GetTileTriggerAtPlayer` (`$0a:$5369`), `CheckTileTriggerAtPoint` (`$04:$5141`) |
| `$3` | exit trigger; the high nibble goes to `wStoryModeExitTriggerRequest` | `CheckTileTriggerAtPoint` (`$04:$5160`) |
| `$8` | action tile; the high nibble is the `FacingScripts` id | `GetFacingTileInteractionId` (`$0a:$5200`) |
| `$c` | extended talk reach: `FindActorFacingPlayer` re-probes at `$03c0` ahead instead of `$01c0` | `$0a:$5247` |

`GetTileTriggerAtPlayer` additionally validates the id against the
`TileTriggers` table before reporting it, so a behaviour cell with no matching
record is silently inert.

The maps are not purely static: location init scripts patch them. `bank $13`'s
dorm-room variant setup, for example, block-copies a rect of both maps with
`CopyCollisionMapRect` / `CopyBehaviorMapRect` (`$0a:$5f90`/`$5fd6`, which copy
*within* the map, not from ROM) and then rewrites individual cells with
`WriteBehaviorMapCell` (`$13:$5092` onwards) to open or close a door.

### Camera and scroll

`UpdateCameraFromPlayer` (`$0a:$6235`) sets `wCameraX = playerX - $09f0` and
`wCameraY = playerY - $0af0` (positions are 16-bit with `$100` per tile, so this
roughly centres a 20x18-tile viewport), then clamps each axis to
`[wMapScrollMin*, wMapWidthTiles - $14]` / `[..., wMapHeightTiles - $12]` in
whole tiles. `InitSceneScroll` / `UpdateSceneScroll` / `CopySceneTilemapRect`
(`$0a:$5930`, `$5a67`, `$60a8`) stream new tilemap columns/rows out of
`wShadowTilemap` as the camera moves.

## NPCs and dialogue

Overworld NPCs are actors: a `map_actor` record gives them a position, sprite and
actor script, and an `NpcScripts` record keyed on their actor slot gives them
something to say. The handler is usually a tiny same-bank routine that indexes a
per-NPC `records:2` text-id table with `wMapSceneStage` (`$c2b0`) and then calls
`script_speak`. `wMapSceneStage` is *not* a global chapter counter: each
location's init script derives it from the save flags
(`SetupCenterCourtSceneVariant`, `InitTournamentSiteSceneVariant`,
`ComputeIslandOpenRound`, …), so the same NPC line table produces different
dialogue as the flags advance. `wMapSceneStage2` (`$c2b1`) is a second such
selector used by a few locations.

Most academy NPCs are anonymous students and staff giving tennis tips; nothing in
their dialogue names them, which is why they are labelled `<Location>Npc<id>`.
The named cast lives in a separate roster/name table at `$30:$466d`, used by the
match and ranking screens rather than the overworld. Peach's Castle (location
29, `MarioWorldMapScripts_0e`) is the exception: its NPCs are the Mario cast, each
with one signature line in bank `$5e` (`$308e`-`$30a8`).

Dialogue itself belongs to bank `$05`. `ShowSpeakerDialogue` (`$05:$581f`) takes
the text id in `hl` and the speaker actor in `a`, resets the three text-argument
queues, applies `wMessageSpeed`, picks a voice, and opens a bubble over that
actor. The only interpreter involved is the text control-code engine at
`$05:$4e5d`. The location-name popup reuses the same path
(`ShowLocationNamePopup`, `$0a:$52f5`, speaker `$83`, auto-closing after `$50`
frames or on any input).

**There is no story bytecode VM.** Story flow is native code: hand-written
routines in the location banks, with the `script_*` macros collapsing the fixed
register-setup + `farcall` sequences into readable one-liners. The one real
interpreter in the overworld is the *actor* VM (`StepActorScript`, `$04:$4229`,
op table `$04:$447d`), documented in [`actor_script.md`](actor_script.md).

## The pause menu

Start raises `wStoryModeMenuRequest`; the loop calls `RunStoryModeMenu`
(`$06:$6e17`), which stops the scene tile animations, sets
`FLAG_HIDE_OVERWORLD_ACTORS`, opens a 3-row window at the bottom of the screen
and runs the menu tree. `StoryMenuDefs` (`$06:$6ce0`) is six `menu_def` rows of
`STORYMENUITEM_*` ids (`include/constants.inc`), selected by `wPauseMenuId`:

| menu | items |
| --- | --- |
| 0 (root) | STATUS, CLEAR STATUS, OPTIONS, SAVE |
| 1 | CHAR. DATA, ITEMS |
| 2 | MESSAGES, MUSIC |
| 3 | SLOW / NORMAL / FAST |
| 4 | MUSIC ON / OFF |
| 5 | SAVE, TO MAIN MENU, CANCEL |

The three full-screen items share one trick (`$06:$6f66`, `$6f84`, `$6fa0`): back
up the live player position into `wStoryModeSpawnPosition`, set
`wStoryModeEntryPoint = $ff` and `wStoryModeExitTriggerRequest = $ff`, then
farcall the screen. When it returns, the location loop's exit check fires, the
`$ff` matches no exit record, and the location reloads with the player exactly
where they were.

* **STATUS → CHAR. DATA** — `ShowCharDataScreen` (`$1d:$4000`).
* **STATUS → ITEMS** — `ShowEquipmentStatusScreen` (`$3e:$…`), the racket/shoe
  equip screen.
* **CLEAR STATUS** — `ShowGameProgressScreen` (`$1e:$…`).
* **OPTIONS** — message speed (`wMessageSpeed`) and music on/off; the music
  choice is persisted with `SetStorySlotFlagA`.
* **SAVE** — `SaveStoryReturnPoint` + `SaveStorySlotWithTimer`, then request loc
  `$00` entry `$01` (back to the main menu). "TO MAIN MENU" does the same without
  saving.

Note that the pause menu's "CLEAR STATUS" *item* opens the read-only progress
screen. The similarly named `RunClearStatusSetupMenu` in bank `$0a` is a
different, developer-facing thing — see below.

## Progression

### Two flag spaces

| | `wGameFlags` | save flags |
| --- | --- | --- |
| where | WRAM `$c9c0`-`$c9df` (32 bytes), inside the saved story-slot image | SRAM `$a040`-`$a05f` |
| scope | per story slot | global, all slots |
| accessors | `rst $20/$28/$30` → `SetGameFlag`/`ClearGameFlag`/`TestGameFlag` (`$00:$24ba`/`$24d4`/`$249f`); `*GameFlagByNumber` (`$00:$24ef`) for a computed id | `SetSaveFlag`/`ClearSaveFlag`/`TestSaveFlag` (`$03:$4db6`/`$4de4`/`$4d86`), which also bank in SRAM and rewrite the header checksum |
| names | 120 `FLAG_*` in `include/flag_constants.inc` | 47 `SAVEFLAG_*` in `include/constants.inc` |

Both use the same id encoding. A flag number is `byte * 8 + bit`; the inline
operand form used by the macros is two bytes, `bit << 5` then the byte index,
and the mask applied is `$80 >> bit`. `test_flag` leaves **Z set when the flag is
clear**.

`wGameFlags` bytes `$1c`-`$1f` (flags 224-255) are `wGameFlagsTemp`, zeroed by
`ClearTemporaryStoryFlags` on every location load — scene-variant bits
(`FLAG_TEMP_SCENE_VARIANT_A/B`) and screen-mode bits live there and cannot
outlive a map transition.

The interesting `wGameFlags` regions:

| bytes | contents |
| --- | --- |
| `$02`-`$05` | engine and debug bits (`FLAG_PLAYER_RUNNING`, `FLAG_HIDE_OVERWORLD_ACTORS`, `FLAG_CUTSCENE_FAST_FORWARD`, `FLAG_DEBUG_*`, `FLAG_STORY_MENU_LOCKED`, `FLAG_DOUBLES`) |
| `$06`-`$07` | Island Open bracket + Dream Match wins (doubles in `$06`, singles in `$07`) |
| `$08`-`$0b` | class ranking-match wins (doubles `$08`/`$09`, singles `$0a`/`$0b`) |
| `$0c`-`$0d` | equipment owned; ending-credits control bits |
| `$14`-`$17` | `FLAG_REACHED_ISLAND_OPEN_*`, `FLAG_STORY_COMPLETE_*`, `FLAG_REACHED_MARIO_WORLD_*`, `FLAG_ISLAND_OPEN_IN_PROGRESS` |
| `$18`-`$1b` | training-drill clears (Service / Net Game / Stroke match+practice, Tennis Machine, Wall) |

`SAVEFLAG_*` covers what must survive a slot erase: character unlocks
(`SAVEFLAG_UNLOCKED_FAY` … `_ELDEN`, plus flags 20-31 whose *flag number equals
the character id* they unlock), arcade-minigame clears, court unlocks, the
per-slot "a save exists" A/B bits, `SAVEFLAG_OPENING_SEEN`, and
`SAVEFLAG_DEBUG_TEST_MENU`.

### The ranking ladder and the tournament arc

`FLAG_DOUBLES` (flag 47) selects the whole singles-or-doubles arc; every
progression flag exists in both flavours. The ladder is:

1. Class ranking matches at the Junior (loc 11/12), Senior (loc 16) and Varsity
   courts — `FLAG_WON_{JUNIOR,SENIOR,VARSITY}_{SINGLES,DOUBLES}_RANK_n`.
2. Training drills and machine/wall practice at the Training Center (17),
   Tennis Machine Room (18), Wall Practice Room (19) and Training Court (15) —
   `FLAG_CLEARED_*`.
3. The Island Open, staged from Tournament Courtyard (21) through Court #1/#2
   (22/23), Center Court (24) and Tournament (25) —
   `FLAG_WON_ISLAND_OPEN_*_{ROUND_1,ROUND_2,SEMIFINAL,FINAL}`, with
   `FLAG_ISLAND_OPEN_IN_PROGRESS` marking the bracket as live.
4. Awards Ceremony (26) and the Island Sky departure scene (27), where
   `FLAG_STORY_COMPLETE_*` is set (`$0e:$710c`).
5. Peach's Castle (29) and Special Court (28), gated on
   `FLAG_REACHED_MARIO_WORLD_*`, hosting the Dream Match
   (`FLAG_WON_DREAM_MATCH_*`, which grants `SAVEFLAG_UNLOCKED_SAMMI`/`_ELDEN`).

Each stage reads back as scene variation rather than as a state machine:
`InitTournamentSiteSceneVariant` (`$15:$4271`) and
`SetupCenterCourtSceneVariant` (`$11:$41b6`) test the bracket flags in descending
order to derive `wMapSceneStage`, and `TournamentInitScript_0f` (`$0f:$620f`)
spawns the appropriate round's rival roster.

Win flags are **not** written by any shared match-end routine. Each court's own
post-match cutscene script checks `wMatchExitRequest` and `wMatchWinLoseFlag` and
then sets the specific flag — e.g. `ActorScript_11_21.checkMatchExitRequest`
(`$11:$5d38`) dispatches on `wCurrentMinigameStoryMatch + 1` to
`set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_{3,2,1}` (`src/story/doubles_11.asm:56`,
`1854`, `1896`). The arcade-minigame clears go the other way, through the SRAM
space: `SetMinigameClearFlag` (`$1e:$6edc`) indexes `MinigameClearFlagTable_1e`
and calls `SetSaveFlag`.

### Story matches

A story match is launched by writing a big-endian id into
`wCurrentMinigameStoryMatch` (`$c8f6`) and calling
`LoadMatchSettingsFromTable` — the `load_match_settings` macro is exactly that
pair. The id's high byte is the category (0 singles, 1 doubles, 2
minigame/training) and the low byte the match; `docs/ram_map.md` lists all of
them by name.

`LoadMatchSettingsFromTable` (`$0a:$4a5c`) indexes
`SinglesMatchSettingsTable_0a` (`$0a:$4ab2`) or `DoublesMatchSettingsTable_0a`
(`$0a:$4b2f`) by `low byte * 5` and unpacks a 5-byte record: `wGameMode`,
`wMatchOpponentChar`, `wCurrentlyUsedCourt`, a packed sets/games byte, and
`wMatchBGM`. `FLAG_DEBUG_KEEP_MATCH_SETTINGS` diverts the sets/games and BGM
reads. Both tables are 125 bytes / 25 records.

`RunStoryMatch` (`$0a:$4962`) then fades out, calls
`AssignStoryMatchCharacters` (`$0a:$49aa`) and `RunMatch`; on return, a
save-and-quit request saves and bounces to the main menu, otherwise the caller
continues its cutscene. `AssignStoryMatchCharacters` fills the four on-court
records via `InitCa00RecordFromCharId`: selector `$80`/`$81` mean "copy the story
main/partner record", the opponent uses its character id, and the opponent's
doubles partner comes from `PairSwapIndexTable_0a` (`$0a:$49d9`).
`RestoreOverworldAfterMatch` (`$0a:$4991`) restores the overworld palettes and
menu font afterwards.

`wGameMode` (`$c8a6`) records which kind of match is running (1 ranking, 2 Island
Open, 3 practice, 5 training-court minigames, 6 tennis machine, 7 wall practice,
`$0a` Dream Match); `RunStoryLocation` sets it to 0 on every location load.

### The ending

`RunEndingCreditsSequence` (`$0a:$6e74`) is a driver *over* `RunStoryLocation`.
It sets `FLAG_ENDING_CREDITS_RUNNING` (which suppresses BGM and the menu font
load in the location loader) and walks `EndingCutsceneLocationList`
(`$0a:$6e40`), a 21-record list of (location, entry point) pairs: the twelve
bank-`$27` "End*" rooms plus Island Sky, Center Court, Peach's Castle and Special
Court. For each it calls `RunStoryLocation`, then — unless
`FLAG_ENDING_CREDITS_PENDING` was raised — freezes the actors, fades to
grayscale and plays `PlayScrollingStoryCutscene` (bank `$03`) for that step.
`ShowStoryResultScreen` closes the sequence.

Bank `$18`'s `RunStorySceneByMode` (`$18:$7617`) is the other narrative device:
`b` picks one of `PlayScreenSequence0/1/2` and `c` picks the artwork. Sequence 1
is the Awards-Ceremony congratulations screen (called from `$0f:$4e91`/`$556b`
with a gender-derived key), sequence 2 is the ending/Dream-Match epilogue screen
(and sets `SAVEFLAG_OPENING_SEEN`). Bank `$03` owns both the generic scrolling
caption screen (`RunScrollingTextScreen`, `$03:$59c5`) and the animated credits
montage (`PlayScrollingStoryCutscene`).

## The character record

The record is `$40` bytes and the same layout is used in four places:

| base | what |
| --- | --- |
| `$c900` / `$c940` | the live story main character / partner — `GetPlayerRecordPtr` (`$02:$4206`) returns `$c900` for selector 0 and `$c940` otherwise |
| `$c800` / `$c840` | a mirror of the above pair, kept in step by a 128-byte copy and its own `RecomputeCharacterStats` call (`$02:$4795`-`$47c2`); this is the front of the saved slot image |
| `$ca00` + slot*`$40` | the four on-court match characters — `GetCa00RecordPtr` (`$02:$420e`) |
| `StoryCharacterRecords_02` | the ROM attribute database, 29 bytes per character id, copied into a record at `+$0f`-`+$2b` |

Fields (evidence in `src/bank_002.asm` unless noted):

| off | field |
| --- | --- |
| +$00 | display name (ASCII, NUL-padded) |
| +$0b | character id (post-`RemapExtendedCharId`) |
| +$0c | palette index (`GetCharPaletteIndex`) |
| +$0d | gender (0 male, 1 female) |
| +$0e | left-handed flag |
| +$0f-$1f | AI / physics attributes from the ROM record (reach windows, smash and dive speeds, reaction delays, swing word) |
| +$18 | level for player characters (1-99, capped `$63`), class tier for roster NPCs |
| +$20-$2a | the eleven displayed stat bars, 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop |
| +$2c | EXP (a 3-byte accumulator, capped at 99999 by `AddExpCapped`) |
| +$30-$37 | physics template, copied into `+$10`-`+$17` on every recompute |
| +$38-$3b | the four trainable levels: Spin, Power, Control, Speed |
| +$3c | equipment: low nibble racket, high nibble shoes |

`InitCa00RecordFromCharId` (`$02:$4066`) is the constructor: it zeroes the 64-byte
destination, then branches on the selector — `$ff` marks the slot empty
(`+$0b = $ff`), `$90` builds the "main character" placeholder, bit 7 set means
"copy the story record at `$c900 + (b & 1) * $40`", and bit 7 clear means "load
character id *b* from `StoryCharacterRecords_02`", which also fetches the name
text and stamps the palette index.

### Stats

`RecomputeCharacterStats` (`$02:$44e9`) derives all eleven bars from the four
trainable levels. For each stat it does:

```
raw  = level_byte * 5 - (record[+$18] - 1)      ; ScaleStatForBarLevel, clamped to a signed byte
bar  = count of thresholds raw clears (0-9)     ; LookupStatBarLevel, 9-entry signed table
```

The threshold tables are grouped per character archetype: `record[+$0b] & 3`
picks one of four 113-byte tables through `StatArchetypePtrs_02`
(`StatArchetype0_02`-`StatArchetype3_02`): a tier byte, the 12-byte template
copied to `+$30`-`+$3b` when the record is built, then eleven
`stat_thresholds` rows, one per stat. Level-to-stat
mapping:

| trainable level | feeds |
| --- | --- |
| +$38 Spin | Top, Slice |
| +$39 Power | Serve, Stroke, Volley |
| +$3a Control | Angle, Placement |
| +$3b Speed | Speed, Dash, Reaction, Stop |

Because the character's overall level at `+$18` is *subtracted*, a stat bar only
grows when its category level has been trained ahead of the character's overall
level — growth is a budget across the four categories, not a rising tide.

The function finishes by copying `+$30`-`+$37` into `+$10`-`+$17` (refreshing the
physics fields the match engine reads) and, **only when the record base's low
byte is zero**, calling `ApplyStatModifiers` (`$02:$468e`). That condition is
true for `$c800`, `$c900` and `$ca00` but not for `$c840`/`$c940`/`$ca40`/`$ca80`/
`$cac0`, so equipment bonuses apply to the main character's records only.
`ApplyStatModifiers` reads the two nibbles of `+$3c` and adds a signed per-stat
row from the racket table (`RacketStatDeltas_02`, 7 rows) and the shoe table
(`ShoeStatDeltas_02`, `$02:$475f`, 3 rows), both `equip_stat_deltas` rows with
the equipment named beside each.

Equipment ownership is gated on the `FLAG_HAVE_*_RACKET` / `FLAG_HAVE_*_SHOES`
bits (`wGameFlags` bytes `$0c`/`$0d`); the equip screen in bank `$3e`
(`HandleEquipSelectInput`) read-modify-writes the nibble at `+$3c` directly.

### EXP and levelling

`LevelUpPlayerRecord` (`$02:$4?`, `src/engine/story/stat2_02.asm:141`) increments `+$18`
(capped at 99), bumps one of the four trainable levels chosen by `d` = 0-3, and
recomputes the stats. `LevelUpPlayer` is the far entry point that resolves the
record through `GetPlayerRecordPtr` first, and `ComputeLevelUpStatDeltas`
snapshots the eleven bars before and after so the level-up screen can show
arrows.

EXP is added by `AddPlayerExp` → `AddExpCapped` (`src/engine/story/exp_02.asm:122`). The
threshold curve is `ExpLevelThresholds_02`, a cumulative 3-bytes-per-level
table (`exp_threshold` rows, 99 levels) terminated by `$ff,$ff,$ff` and
indexed by `(level-1)*3`; `GetExpRequiredForLevel`, `GetExpRemainingToNextLevel`,
`GetExpProgressInCurrentLevel` and `HasReachedNextLevelExp` all read it. Awards
are staged per source (`wPendingExpStory`, `wPendingExpTrophy`,
`wPendingExpExhibition`, `wPendingExpLinked`) and applied by
`ApplyPendingExpAwards` (`$1e:$…`) on the next slot load;
`ScaleExpByPlayerLevel` averages the two story records' `+$18` and scales the
award as the average crosses 10/20/30/40/50.

### Save signature

`wStorySaveSignature` (`$c880`, 4 bytes) distinguishes two slots that otherwise
look identical. `GenerateUniqueStorySaveSignature` (`src/engine/story/story_02.asm:411`)
seeds it from `wStoryRandomBytes` and re-rolls until
`CheckStorySignatureCollision` (`src/engine/story/story_02.asm:331`) passes against the cached
per-slot signatures (`CacheStorySlotSummaries` copies each slot's into `$d400 +
slot*4`). An all-zero candidate is treated as an automatic collision. It is
called once, on the new-game path (`$10:$5076`).

The saved image itself is `$c800`-`$caff` written wholesale as save block `2N`
for slot *N*, plus a backup copy at block `$1b + 2N` (`SaveStorySlotWithTimer`,
`$03:$4d10`). See [`save_format.md`](save_format.md).

## WRAM state

The story engine's working set is the block `$c280`-`$c2ff` (WRAM bank 0, so
always visible), plus the actor array in bank `$04` and the two maps in bank
`$06`. Fuller notes for each address are in [`ram_map.md`](ram_map.md).

| addr | symbol | role |
| --- | --- | --- |
| `$c280` | `wStoryModeCurrentLocation` | current location id; also the first byte of the copied header |
| `$c281` | `wStoryLocationScene` | scene index for `SceneGfxSlotTable` |
| `$c282` | `wStoryLocationMapScriptsSlot` | `dslot` (low byte, bank) of the `map_tree` |
| `$c284` | `wStoryLocationBGM` | `$ff` = keep current music |
| `$c286`-`$c293` | `wMapEntryPointsPtr` … `wMapInitScriptPtr` | the seven `map_tree` slot pointers |
| `$c294` | `wUnusedExitTriggerIdMirror` | write-only mirror of `$c2a1` (dead store) |
| `$c295` | `wStoryModeEntryPoint` | entry-point id; `$ff` = keep the saved position |
| `$c296` | `wStoryModeSpawnPosition` | 5 bytes: X, Y, facing |
| `$c29b` | `wStoryLocationBank` | ROM bank of all this location's tables and code |
| `$c29c` | `wStoryArrivalScript` | the selected entry point's arrival script |
| `$c2a0` | `wStoryModeTriggerScript` | queued step-on trigger id |
| `$c2a1` | `wStoryModeExitTriggerRequest` | nonzero = leave the location, by the id of a row in its `ExitTriggers` table (the destination is that row's `arg0`); `$ff` = plain reload, matching no row |
| `$c2a2`/`$c2a3` | `wStoryAutoInteractArmed` / `wStoryAutoInteractFired` | walk-into-thing auto-interact |
| `$c2a4` | `wStoryModeInteractRequest` | set by A |
| `$c2a5` | `wStoryModeMenuRequest` | set by Start |
| `$c2b0`/`$c2b1` | `wMapSceneStage` / `wMapSceneStage2` | per-location scene stage, derived from flags |
| `$c2b2`-`$c2bf` | (location scratch) | whatever this location needs |
| `$c2c0` | `wStoryMapRecord` | 8-byte staging copy of the matched `map_entry`/`map_script` record |
| `$c2d0`-`$c2d4` | `wStoryModePlayersXPosition`, `…YPosition`, `wStoryModePlayerFacing` | snapshot of the player actor, refreshed by `UpdateActors` |
| `$c2d5`-`$c2d7` | `wStoryModeShowLocationName`, `wStoryModeLocationNameTextId` | the name popup |
| `$c2d8`-`$c2da` | `wStoryScriptSavedActorBusy`, `…Anim`, `wStoryScriptRan` | NPC-interaction bookkeeping |
| `$c2db` | `wUnusedStoryScriptId` | write-only (dead store) |
| `$c32e` | `wCurrentScene` | scene index the graphics loader last used |
| `$c36c` | `wCurrentStorySlot` | active save slot 0-2 (`$0f` = none, `$03`+ = not a story slot) |
| `$c800`-`$caff` | `wStorySlotData` | the saved story-slot image (records, flags, match settings) |
| `$c9c0`-`$c9df` | `wGameFlags` | progression flags; `$1c`-`$1f` are `wGameFlagsTemp` |
| `$d000`+ (bank `$04`) | `wActors` | 24 actor slots of `$40` bytes |
| `$d000`/`$d400` (bank `$06`) | — | collision map / behaviour map, 32x32 each |
| `$d?` (bank `$06`) | `wStorySceneRecord` | 136-byte scene config copy |

## Oddities and open questions

Recorded here because a future reader will otherwise re-derive them. Items
marked *resolved* were fixed in the source on 2026-09-10; the rest stand.

* **Scene slot 6 is never loaded.** `LoadStorySceneGraphics` (`$0a:$58bd`) pops
  slot 6 into `hl` and loads `de` with `wStorySceneUnusedBuffer`, then
  immediately pops slot 5 over `hl` and `$d400` over `de`. The intended
  destination has a WRAM label and no data ever arrives there; correspondingly,
  most scene records' slot 6 holds either an `*SceneUnusedSlot` filler pointer or
  a stray pointer to the *next* scene's config.
* **`SceneGfxSlotTable` slots 4/5 — resolved.** The story loader decompresses
  slot 4 to `wCollisionMap` (`$d000`) and slot 5 to `wBehaviorMap` (`$d400`) in
  WRAM bank `$06`, and the story-scene records are named `*CollisionMap` /
  `*BehaviorMap` accordingly. The 16 court-shaped records are read by the
  court loader instead (`docs/graphics_formats.md` §3.4): there slot 4 aliases
  slot 0 (40 raw bytes of scoreboard column tiles — still `*SceneConfig`,
  because under the story loader the same slot is the config/palette block)
  and slot 5 is `*ScoreboardColumnAttrs` (renamed from `*SceneConfigB`).
* **`ReadBehaviorMapCell` still prints its result.** `$0a:$5f65`-`$5f6f`
  unconditionally calls `PrintHexByte` with `de = $0e0e` on every read.
  `PrintString` writes into the debug text buffer and only sets
  `hDebugTextDirty`, so nothing is corrupted, but every behaviour-map lookup
  pays for a hex format + string print.
* **A terrain check in `UpdatePlayerControl` can never fire.** At `$04:$5215`
  the code farcalls `ReadCollisionMapCell` and then executes `ld a, $00` before
  `and $0f` / `cp $0b`, so the returned nibble is discarded and the
  `$0b` branch (which would set walk speed `$0010` and probe range 2) is
  unreachable. The other two speeds (`$0040` running, `$0020` normal) work.
* **A duplicate of `EvalFlagCondition`** sits at `$0a:$53a2`, between
  `GetTileTriggerAtPlayer`'s `ret` and `FacingMaskTable_0a`, labelled
  `EvalFlagCondition_0a`. The live copy that `FindStoryScriptEntry` farcalls
  is `$04:$4c49`; no caller of the bank-`$0a` copy was found.
* **The clear-status flag writers were named for each other — resolved.**
  `SetTrainingCourtClearFlags` (`$0a:$4da9`, was `SetRankingMatchClearFlags`)
  clears the 28 `FLAG_CLEARED_*` drill flags from byte `$18` and re-sets the
  level-1 or level-1+2 subset from `TrainingCourtLevel1/2ClearFlags_0a`.
  `SetSinglesRankingClearFlags` (`$0a:$4e0e`, was `SetMinigameClearFlags`)
  clears the nine singles `FLAG_WON_*_SINGLES_RANK_*` flags and sets as many
  of `SinglesRankingClearFlagList_0a` as the chosen class and rank imply;
  `SetDoublesRankingClearFlags` (`$0a:$4e75`, was the `Alt`) does the same
  from `DoublesRankingClearFlagList_0a` — but its clear loop starts at byte
  `$0a` too, so it clears the *singles* wins and leaves stale doubles wins in
  place (`docs/bugs.md`). The lists render as `flag_id` rows. None of this
  touches the arcade minigames, whose real writer is `SetMinigameClearFlag`,
  singular, at `$1e:$6edc`, into the SRAM flag space.
* **`RunClearStatusSetupMenu` is a developer tool.** `$0a:$4bac` walks a
  Set/Continue → Mini-Game/Ranking-Match → level menu chain and then
  `ApplyClearStatusFlags` (`$0a:$4d80`) rewrites the progression flags wholesale;
  choosing "Continue" makes the whole thing a no-op. Its menu state lives in
  WRAM bank `$05` on top of the idle far-P1 character struct
  (`wClearStatusMode` / `Doubles` / `Format` / `Class` / `Rank` /
  `WindowId` / `ResultCode`, `$df00`-`$df06`, range-scoped so the match-engine
  names stay out). `TrainingCourtClearFlagListPtrs_0a` (`$0a:$4dec`) parallels
  the branch structure but has no reader — dead data.
* **The character-vs-level naming at record `+$18`.** `ram/wram.asm` names
  `$c818` "Level (1-99)" and `$c918` "ExpTier" — the same offset in two records
  with the same layout. For player characters the raw byte is a level;
  `LookupExpTierForChar` (`$1e:$…`, `src/engine/menus/exp3_1e.asm:224`) is what derives a
  coarse 0-6 tier from it.
* **EXP field width.** `ram/wram.asm` documents `$c92c`/`$c82c` as 16-bit, but
  `AddExpCapped` maintains three bytes and caps at 99999, while
  `GetExpRemainingToNextLevel` / `GetExpProgressInCurrentLevel` read only the low
  two back out. In practice the level-99 requirement is well under 65536, so the
  truncation never bites.
* **`ld a, [wStoryCharacterSlot]` doubles as the ending-scene index** in
  `RunEndingCreditsSequence`, and the list it indexes,
  `EndingCutsceneLocationList`, holds (location, entry point) pairs -- it was
  called `EndingCreditsSequenceTileList` until 2026-07-30 and holds no tiles.
  The `byte0 == 0` branch at `$0a:$6ea4`-`$6eab` computes
  `sprite * 2` and then discards it by reloading `a`; no record in the table has
  a zero first byte, so the branch is unreachable.
* **Story completion and the Star Court — resolved.** `FLAG_STORY_COMPLETE_*`
  itself grants nothing permanent, but `CheckAllProgressComplete`
  (`$1e:$6f8d`, run from `ProcessMatchRewards` after every rewarded match)
  walks 36 game flags — `AllProgressFlagList_1e` (both Dream Matches, the
  rank-1 win of every class in both arcs, both Island Open finals) and,
  because the walk is 36 entries long, the 26 drill, machine and wall clears
  of `RewardFlagListMode2_1e` that follow it — and when every one is set it
  calls `SetSaveFlag` with `SAVEFLAG_COURT_STAR`. So the Star Court is the
  exhibition unlock for finishing *everything* in story mode, singles and
  doubles, and it is granted on the match that completes the set.
* **Record fields `+$2b`, `+$2f` and `+$3d`-`+$3f` are dead stores.** `+$2f`
  is written `$00`/`$02`/`$03` by the three record-init paths and nothing
  reads it; the others are neither written by the game nor read. Listed under
  dead stores in `docs/bugs.md`.
* **The `$ff, $c9` list endings — resolved.** The `$c9` after the `$ff`
  terminator of `JuniorClassCourtSinglesEntryPoints_11`,
  `JuniorClassCourtDoublesFacingScripts_11` and `…TileTriggers_11` is a `ret`
  opcode: a one-byte empty script left after each list, which nothing in the
  bank points at (a search of every word in bank `$11` finds no reference).
  They are carved as `Unused_11_NullScriptA`-`C`, and the lists are the
  terminator alone. `FireworkMapActors_14` (`$14:$6675`) and the bank `$1a`
  table that shares the shape each carry one `$00` past `map_actor_end`; the
  byte before a 2 KiB tile blob is padding, and is rendered as the `db $00`
  it is.
