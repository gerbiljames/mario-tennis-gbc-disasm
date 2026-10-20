; --- Scene ids (SceneGfxSlotTable; wCurrentScene, wStoryLocationScene) ---
; The index of a scene's eight-slot record. 0-15 are the match courts,
; selected by CourtSceneDataTable; 16-36 the overworld, selected by the
; story_location records. Each scene's blob family (SceneConfig, Palettes,
; Tiles, Tilemap, ...) carries the same name in CamelCase: SCENE_RESTAURANT's
; tilemap is RestaurantTilemap. The courts have ScoreboardColumnTiles/Attrs in
; place of SceneConfig.
	const_def
	const SCENE_MINIGAME_COURT       ; $00 Banana Bunch, Perfect Shot, Fruit Fantasy, and the unused court $0e
	const SCENE_TARGET_SHOT_COURT    ; $01
	const SCENE_GRASS_COURT          ; $02 COURT_GRASS and COURT_GRASS_ISLAND_OPEN
	const SCENE_TRAINING_COURT       ; $03 COURT_TRAINING_PRACTICE and the training match court
	const SCENE_CLAY_COURT           ; $04
	const SCENE_HARD_COURT           ; $05
	const SCENE_MACHINE_COURT        ; $06
	const SCENE_CENTER_COURT         ; $07
	const SCENE_COMPOSITION_COURT    ; $08
	const SCENE_TROPICS_COURT        ; $09 Yoshi's court
	const SCENE_STAR_COURT           ; $0a also Shooting Star and Boo Blast
	const SCENE_BOWSER_COURT         ; $0b no court row selects it
	const SCENE_WAREHOUSE_COURT      ; $0c Wario's court; also Treasure Box, Medallion Match, Two-On-One
	const SCENE_CASTLE_COURT         ; $0d Peach's court
	const SCENE_WALL_PRACTICE        ; $0e
	const SCENE_JUNGLE_COURT         ; $0f DK's court
	const SCENE_STAR_PATTERN_BG      ; $10 the main menu and the developer test locations
	const SCENE_ACADEMY_MAIN_BLDG    ; $11
	const SCENE_DORM_ROOM            ; $12
	const SCENE_RESTAURANT_PLAZA     ; $13
	const SCENE_COURTYARD            ; $14 the Academy courtyard and the Varsity Court
	const SCENE_ISLAND_SKY           ; $15
	const SCENE_SPECIAL_COURT        ; $16
	const SCENE_SENIOR_CLASS_COURT   ; $17
	const SCENE_JUNIOR_CLASS_COURT   ; $18
	const SCENE_RESTAURANT           ; $19 and the cafeteria
	const SCENE_ACADEMY_ENTRANCE     ; $1a
	const SCENE_DORM_ENTRANCE        ; $1b
	const SCENE_TOURNAMENT_COURTYARD ; $1c
	const SCENE_COURT_1              ; $1d
	const SCENE_TRAINING_COURT_MAP   ; $1e the overworld view of the Training Court
	const SCENE_COURT_2              ; $1f
	const SCENE_CENTER_COURT_MAP     ; $20 the overworld view of the Center Court
	const SCENE_PEACHS_CASTLE        ; $21
	const SCENE_TRAINING_CENTER      ; $22 also the machine and wall practice rooms
	const SCENE_TOURNAMENT           ; $23
	const SCENE_AWARDS_CEREMONY      ; $24
def NUM_SCENES equ const_value

; --- Scene tilemap copy origin (a for CopyScrolledSceneTilemapToVram) ---
def SCENECOPY_FROM_PLAYER equ $00 ; re-centre the camera on the player first
def SCENECOPY_FROM_CAMERA equ $01 ; any nonzero: copy around wCameraX/wCameraY as they stand

; --- Ending-sequence object fields (bank $18, wScreenScratch) ---
; NUM_SCENEOBJS 16-byte records, each spawned from an 11-byte
; ObjectArrayASpawnTable / ObjectArrayBSpawnTable row. TaskUpdateObjects_18
; adds the steps to the positions and jumps to the callback with the object
; in bc; TaskDrawObjectSprites_18 draws it as two 8x16 sprites side by side.
	rsreset
def SCENEOBJ_ATTR      rb ; $00 OAM attributes
def SCENEOBJ_X         rw ; $01 8.8 pixels
def SCENEOBJ_Y         rw ; $03 8.8 pixels; wraps to $10 at $c0
def SCENEOBJ_X_STEP    rb ; $05 1/256 pixels added to SCENEOBJ_X each frame
def SCENEOBJ_Y_STEP    rb ; $06 1/256 pixels added to SCENEOBJ_Y each frame
def SCENEOBJ_TILE      rb ; $07 the left sprite's tile (the right one is +2); the callback steps its low nibble by 4
def SCENEOBJ_PHASE     rb ; $08 the tile steps when (hVBlankCounter - this) & 7 is 0
def SCENEOBJ_CALLBACK  rw ; $09 jumped to; ends in jp ObjectUpdateLoopTail_18
def SCENEOBJ_SPAWN_SIZE equ _RS
	rb_skip 5             ; $0b
def SCENEOBJ_SIZE equ _RS
	ASSERT SCENEOBJ_SIZE == $10
def NUM_SCENEOBJS equ 16
