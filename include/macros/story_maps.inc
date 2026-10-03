; Story-mode map tables: map_tree slots, map_entry, map_script, map_actor, locations.

; Each story location owns a 7-word directory (a map_tree) copied to $c286,
; one sub-table per slot, consumed by the bank $0a overworld engine:
;   0 EntryPoints (map_entry)    - spawn record per entry point / warp id
;   1 ExitTriggers (map_script)  - RunLocationExit
;   2 Actors (map_actor)         - the location's NPC/prop actor list
;   3 NpcScripts (map_script)    - RunNpcInteraction (talk)
;   4 FacingScripts (map_script) - RunFacingTileScript (action button vs tile)
;   5 TileTriggers (map_script)  - RunTileTriggerScript (step-on)
;   6 InitScript                 - RunLocationInitScript (code)
; Slots with no table point at a shared $ff (an empty list) or at slot 6's
; init code.

; Actor spawn template (14 bytes, list ended by map_actor_end).
; SpawnActorFromTemplate spawns `objdef` unless `cond` is met,
; then seeds the actor's position, facing, object id, animation, and (if
; nonzero) a palette override. `facing` is a FACE_* constant (include/constants/).
; Usage: map_actor cond, objdef, x, y, facing, obj_id, anim, palette[, NAME]
; InitLocationActors fills slots 0-2 with the player, its shadow and the
; companion, then the list in order (a row whose cond fails still takes its
; slot), so row n is actor slot 3 + n. NAME defines ACTOR_NAME as that slot;
; inserting or reordering rows renumbers them.
MACRO map_actor
IF !DEF(_MAP_ACTOR_ROW)
DEF _MAP_ACTOR_ROW = 0
ENDC
IF _NARG == 9
DEF ACTOR_\9 EQU _MAP_ACTOR_ROW + 3
EXPORT ACTOR_\9
ENDC
DEF _MAP_ACTOR_ROW += 1
	map_pos \3, \4
	dw \1, \2, (\3) >> 8, (\4) >> 8
	db \5, $00, \6, \7, \8, $00
ENDM

; Names an actor slot by its role in a scene whose possible lists put
; different actors in it: `actor_role ISLAND_OPEN_OPPONENT, $0a, List, List...`
; defines ACTOR_ROLE_ISLAND_OPEN_OPPONENT = $0a. The lists are not assembled;
; tools/actorslots.py checks every use against them (include/actor_roles.inc).
MACRO actor_role
DEF ACTOR_ROLE_\1 EQU \2
ENDM

; Terminates a map_actor list: nine $00 bytes then the $ff sentinel that
; SpawnActorsFromList stops on (template byte 9).
MACRO map_actor_end
DEF _MAP_ACTOR_ROW = 0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff
ENDM

; Entry-point spawn record (8 bytes, table terminated by $ff). Selected by
; wStoryModeEntryPoint; places the main character (facing a FACE_* direction,
; include/constants/) and runs `arrival_script`.
; Usage: map_entry id, facing, x, y, arrival_script
MACRO map_entry
	map_pos \3, \4
	db \1, \2
	dw (\3) >> 8, (\4) >> 8, \5
ENDM

; Story-script record (8 bytes, table terminated by $ff). FindStoryScriptEntry
; matches `id` (and `facing_mask`, a FACEMASK_* constant in
; include/constants/, against the actor's facing), checks `flag_cond`, then runs
; `handler` with the two arg bytes. What the args mean belongs to the map_tree
; slot the table sits in, not to the record: in an ExitTriggers table (slot 1)
; RunLocationExit copies `arg0` into wStoryModeCurrentLocation --
; a STORYLOC_* id -- and `arg1` into wStoryModeEntryPoint, which indexes the
; destination's own map_entry list. In the other three slots they are whatever
; the handler reads them as.
; Usage: map_script id, facing_mask, flag_cond, handler, arg0, arg1
MACRO map_script
	db \1, \2
	dw \3, \4
	db \5, \6
ENDM

; Story location record (6 bytes) in bank $0a's StoryLocationTable, indexed by
; wStoryModeCurrentLocation (GetStoryLocationRecordPtr). `map_scripts` is a
; slot in the target bank's $4000 directory (a DataPtr_*MapScripts label); the
; engine copies its 7-word map_tree to $c286 (LoadStoryLocationHeader), loads
; `scene` graphics (LoadStorySceneGraphics), and plays `bgm` (a BGM_* id;
; BGM_UNCHANGED, $ff, keeps what is playing).
; Usage: story_location id, scene, map_scripts, bgm
MACRO story_location
	db \1, \2
	dslot \3
	db \4, $00
ENDM

; map_pos x, y -- assert that a map position is written in tiles with a
; point (18.0, 17.5): positions are in 1/256 tile and the macros store `x >> 8`
; of the Q16.16 literal, so a plain integer would land 256 times too close.
MACRO map_pos
	ASSERT (\1) % 256 == 0 && (\1) < 256.0, "map position \1: write tiles with a point, e.g. 18.0"
	ASSERT (\2) % 256 == 0 && (\2) < 256.0, "map position \2: write tiles with a point, e.g. 18.0"
ENDM

; map_offset dx, dy -- the same for a signed move in tiles (-4.0, 2.0).
MACRO map_offset
	ASSERT (\1) % 256 == 0 && (\1) >= -128.0 && (\1) < 128.0, "map offset \1: write tiles with a point, e.g. -4.0"
	ASSERT (\2) % 256 == 0 && (\2) >= -128.0 && (\2) < 128.0, "map offset \2: write tiles with a point, e.g. -4.0"
ENDM
