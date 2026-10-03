; --- Scene ids (SceneGfxSlotTable; wCurrentScene, wStoryLocationScene) ---
; The index of a scene's eight-slot record. 0-15 are the match courts,
; selected by CourtSceneDataTable; 16-36 the overworld, selected by the
; story_location records. Each scene's blob family (SceneConfig, Palettes,
; Tiles, Tilemap, ...) carries the same name in CamelCase: SCENE_RESTAURANT's
; tilemap is RestaurantTilemap.
def SCENE_MINIGAME_COURT     equ $00 ; Banana Bunch, Perfect Shot, Fruit Fantasy, and the unused court $0e
def SCENE_TARGET_SHOT_COURT  equ $01
def SCENE_GRASS_COURT        equ $02 ; COURT_GRASS and COURT_GRASS_ISLAND_OPEN
def SCENE_TRAINING_COURT     equ $03 ; COURT_TRAINING_PRACTICE and the training match court
def SCENE_CLAY_COURT         equ $04
def SCENE_HARD_COURT         equ $05
def SCENE_MACHINE_COURT      equ $06
def SCENE_CENTER_COURT       equ $07
def SCENE_COMPOSITION_COURT  equ $08
def SCENE_TROPICS_COURT      equ $09 ; Yoshi's court
def SCENE_STAR_COURT         equ $0a ; also Shooting Star and Boo Blast
def SCENE_BOWSER_COURT       equ $0b ; no court row selects it
def SCENE_WAREHOUSE_COURT    equ $0c ; Wario's court; also Treasure Box, Medallion Match, Two-On-One
def SCENE_CASTLE_COURT       equ $0d ; Peach's court
def SCENE_WALL_PRACTICE      equ $0e
def SCENE_JUNGLE_COURT       equ $0f ; DK's court
def SCENE_STAR_PATTERN_BG    equ $10 ; the main menu and the developer test locations
def SCENE_ACADEMY_MAIN_BLDG  equ $11
def SCENE_DORM_ROOM          equ $12
def SCENE_RESTAURANT_PLAZA   equ $13
def SCENE_COURTYARD          equ $14 ; the Academy courtyard and the Varsity Court
def SCENE_ISLAND_SKY         equ $15
def SCENE_SPECIAL_COURT      equ $16
def SCENE_SENIOR_CLASS_COURT equ $17
def SCENE_JUNIOR_CLASS_COURT equ $18
def SCENE_RESTAURANT         equ $19 ; and the cafeteria
def SCENE_ACADEMY_ENTRANCE   equ $1a
def SCENE_DORM_ENTRANCE      equ $1b
def SCENE_TOURNAMENT_COURTYARD equ $1c
def SCENE_COURT_1            equ $1d
def SCENE_TRAINING_COURT_MAP equ $1e ; the overworld view of the Training Court
def SCENE_COURT_2            equ $1f
def SCENE_CENTER_COURT_MAP   equ $20 ; the overworld view of the Center Court
def SCENE_PEACHS_CASTLE      equ $21
def SCENE_TRAINING_CENTER    equ $22 ; also the machine and wall practice rooms
def SCENE_TOURNAMENT         equ $23
def SCENE_AWARDS_CEREMONY    equ $24
