; Archipelago ids. This file is the master copy: tools/ap_export.py reads the
; ap_location and ap_item lines below (one per line, in this form) and writes
; them into the apworld. A location's id is its done bit in the ledger; the
; Archipelago id is that plus 1. An item's id is its counter in the ledger
; and its Archipelago id; 0 is no item (a location holding another world's).

IF !DEF(AP_CONSTANTS_INC)
DEF AP_CONSTANTS_INC EQU 1

DEF AP_NUM_LOCATIONS = 0
DEF AP_NUM_ITEMS = 1

; ap_location LOC_NAME, "Name"
MACRO ap_location
	DEF \1 EQU AP_NUM_LOCATIONS
	REDEF AP_NUM_LOCATIONS = AP_NUM_LOCATIONS + 1
ENDM

; ap_item ITEM_NAME, "Name"[, "name in game messages"]
MACRO ap_item
	DEF \1 EQU AP_NUM_ITEMS
IF _NARG > 2
	DEF AP_ITEM_TEXT_{d:AP_NUM_ITEMS} EQUS \3
ELSE
	DEF AP_ITEM_TEXT_{d:AP_NUM_ITEMS} EQUS \2
ENDC
	REDEF AP_NUM_ITEMS = AP_NUM_ITEMS + 1
ENDM

DEF AP_ITEM_NONE EQU 0
; in ApPlacements: a location this seed's options leave out
DEF AP_ITEM_ABSENT EQU $ff

; ApOptGoal
DEF AP_GOAL_ISLAND_OPEN EQU 0
DEF AP_GOAL_DREAM_MATCH EQU 1
DEF AP_GOAL_COMPLETIONIST EQU 2
; ApOptMinigames (0: the vanilla grid)
DEF AP_MINIGAMES_PROGRESSIVE EQU 1
DEF AP_MINIGAMES_CELLS EQU 2
DEF AP_MINIGAMES_EXCLUDED EQU 3
; ApOptStoryArcs
DEF AP_ARCS_BOTH EQU 0
DEF AP_ARCS_SINGLES EQU 1
DEF AP_ARCS_DOUBLES EQU 2

; ap_pass ARC, N -- nz if the arc's class pass count is at least N (ARC:
; AP_ARC_SINGLES, AP_ARC_DOUBLES or AP_ARC_ACTIVE, the one FLAG_DOUBLES
; picks); like test_flag, keeps every register but af
DEF AP_ARC_SINGLES EQU 0
DEF AP_ARC_DOUBLES EQU 1
DEF AP_ARC_ACTIVE EQU 2
DEF AP_TEST_PASS EQU $80
MACRO ap_pass
	call ApTestInline
	db AP_TEST_PASS | (\1), \2
ENDM

; ap_has ITEM, N -- nz if the effective inventory holds at least N of ITEM;
; like test_flag, keeps every register but af
MACRO ap_has
	call ApTestInline
	db \1, \2
ENDM

; apcall Routine -- calls an AP-bank routine from any bank through ApFarCall;
; clobbers hl, passes bc and de
MACRO apcall
	ld hl, \1
	call ApFarCall
ENDM

	ap_location LOC_JUNIOR_SINGLES_RANK_4, "Junior Singles Rank 4"
	ap_location LOC_JUNIOR_SINGLES_RANK_3, "Junior Singles Rank 3"
	ap_location LOC_JUNIOR_SINGLES_RANK_2, "Junior Singles Rank 2"
	ap_location LOC_JUNIOR_SINGLES_RANK_1, "Junior Singles Rank 1"
	ap_location LOC_SENIOR_SINGLES_RANK_4, "Senior Singles Rank 4"
	ap_location LOC_SENIOR_SINGLES_RANK_3, "Senior Singles Rank 3"
	ap_location LOC_SENIOR_SINGLES_RANK_2, "Senior Singles Rank 2"
	ap_location LOC_SENIOR_SINGLES_RANK_1, "Senior Singles Rank 1"
	ap_location LOC_VARSITY_SINGLES_RANK_4, "Varsity Singles Rank 4"
	ap_location LOC_ISLAND_OPEN_SINGLES_ROUND_1, "Island Open Singles Round 1"
	ap_location LOC_ISLAND_OPEN_SINGLES_ROUND_2, "Island Open Singles Round 2"
	ap_location LOC_ISLAND_OPEN_SINGLES_SEMIFINAL, "Island Open Singles Semifinal"
	ap_location LOC_ISLAND_OPEN_SINGLES_FINAL, "Island Open Singles Final"
	ap_location LOC_DREAM_MATCH_SINGLES, "Singles Dream Match"

	ap_location LOC_JUNIOR_DOUBLES_RANK_3, "Junior Doubles Rank 3"
	ap_location LOC_JUNIOR_DOUBLES_RANK_2, "Junior Doubles Rank 2"
	ap_location LOC_JUNIOR_DOUBLES_RANK_1, "Junior Doubles Rank 1"
	ap_location LOC_SENIOR_DOUBLES_RANK_3, "Senior Doubles Rank 3"
	ap_location LOC_SENIOR_DOUBLES_RANK_2, "Senior Doubles Rank 2"
	ap_location LOC_SENIOR_DOUBLES_RANK_1, "Senior Doubles Rank 1"
	ap_location LOC_VARSITY_DOUBLES_RANK_2, "Varsity Doubles Rank 2"
	ap_location LOC_ISLAND_OPEN_DOUBLES_ROUND_1, "Island Open Doubles Round 1"
	ap_location LOC_ISLAND_OPEN_DOUBLES_SEMIFINAL, "Island Open Doubles Semifinal"
	ap_location LOC_ISLAND_OPEN_DOUBLES_FINAL, "Island Open Doubles Final"
	ap_location LOC_DREAM_MATCH_DOUBLES, "Doubles Dream Match"

; drills, in MINIGAME_* order (ApDrillLocations indexes by minigame id)
	ap_location LOC_SERVICE_MATCH_1, "Service Match 1"
	ap_location LOC_SERVICE_MATCH_2, "Service Match 2"
	ap_location LOC_SERVICE_MATCH_3, "Service Match 3"
	ap_location LOC_SERVICE_LESSON_1, "Service Lesson 1"
	ap_location LOC_SERVICE_LESSON_2, "Service Lesson 2"
	ap_location LOC_SERVICE_LESSON_3, "Service Lesson 3"
	ap_location LOC_NET_GAME_MATCH_1, "Net Game Match 1"
	ap_location LOC_NET_GAME_MATCH_2, "Net Game Match 2"
	ap_location LOC_NET_GAME_MATCH_3, "Net Game Match 3"
	ap_location LOC_NET_GAME_LESSON_1, "Net Game Lesson 1"
	ap_location LOC_NET_GAME_LESSON_2, "Net Game Lesson 2"
	ap_location LOC_NET_GAME_LESSON_3, "Net Game Lesson 3"
	ap_location LOC_STROKE_MATCH_1, "Stroke Match 1"
	ap_location LOC_STROKE_MATCH_2, "Stroke Match 2"
	ap_location LOC_STROKE_MATCH_3, "Stroke Match 3"
	ap_location LOC_STROKE_LESSON_1, "Stroke Lesson 1"
	ap_location LOC_STROKE_LESSON_2, "Stroke Lesson 2"
	ap_location LOC_STROKE_LESSON_3, "Stroke Lesson 3"
	ap_location LOC_TENNIS_MACHINE_1, "Tennis Machine Level 1"
	ap_location LOC_TENNIS_MACHINE_2, "Tennis Machine Level 2"
	ap_location LOC_TENNIS_MACHINE_3, "Tennis Machine Level 3"
	ap_location LOC_TENNIS_MACHINE_4, "Tennis Machine Level 4"
	ap_location LOC_WALL_PRACTICE_1, "Wall Practice Level 1"
	ap_location LOC_WALL_PRACTICE_2, "Wall Practice Level 2"
	ap_location LOC_WALL_PRACTICE_3, "Wall Practice Level 3"
	ap_location LOC_WALL_PRACTICE_4, "Wall Practice Level 4"
	ap_location LOC_TENNIS_MACHINE_MASTER, "Tennis Machine Master"
	ap_location LOC_WALL_PRACTICE_MASTER, "Wall Practice Master"

	ap_location LOC_SWING_CONTEST_LOW, "Swing Contest Low Score"
	ap_location LOC_SWING_CONTEST_HIGH, "Swing Contest High Score"

; mini-game clears, in MinigameClearFlagTable_1e order (game * 3 + level - 1)
	ap_location LOC_BOO_BLAST_1, "Boo Blast Level 1"
	ap_location LOC_BOO_BLAST_2, "Boo Blast Level 2"
	ap_location LOC_BOO_BLAST_3, "Boo Blast Level 3"
	ap_location LOC_SHOOTING_STAR_1, "Shooting Star Level 1"
	ap_location LOC_SHOOTING_STAR_2, "Shooting Star Level 2"
	ap_location LOC_SHOOTING_STAR_3, "Shooting Star Level 3"
	ap_location LOC_PERFECT_SHOT_1, "Perfect Shot Level 1"
	ap_location LOC_PERFECT_SHOT_2, "Perfect Shot Level 2"
	ap_location LOC_PERFECT_SHOT_3, "Perfect Shot Level 3"
	ap_location LOC_TARGET_SHOT_1, "Target Shot Level 1"
	ap_location LOC_TARGET_SHOT_2, "Target Shot Level 2"
	ap_location LOC_TARGET_SHOT_3, "Target Shot Level 3"
	ap_location LOC_FRUIT_FANTASY_1, "Fruit Fantasy Level 1"
	ap_location LOC_FRUIT_FANTASY_2, "Fruit Fantasy Level 2"
	ap_location LOC_FRUIT_FANTASY_3, "Fruit Fantasy Level 3"
	ap_location LOC_BANANA_BUNCH_1, "Banana Bunch Level 1"
	ap_location LOC_BANANA_BUNCH_2, "Banana Bunch Level 2"
	ap_location LOC_BANANA_BUNCH_3, "Banana Bunch Level 3"
	ap_location LOC_TREASURE_BOX_1, "Treasure Box Level 1"
	ap_location LOC_TREASURE_BOX_2, "Treasure Box Level 2"
	ap_location LOC_TREASURE_BOX_3, "Treasure Box Level 3"
	ap_location LOC_MEDALLION_MATCH_1, "Medallion Match Level 1"
	ap_location LOC_MEDALLION_MATCH_2, "Medallion Match Level 2"
	ap_location LOC_MEDALLION_MATCH_3, "Medallion Match Level 3"
	ap_location LOC_TWO_ON_ONE_1, "Two-on-One Level 1"
	ap_location LOC_TWO_ON_ONE_2, "Two-on-One Level 2"
	ap_location LOC_TWO_ON_ONE_3, "Two-on-One Level 3"

	ap_location LOC_SHOOTING_STAR_RECORD, "Shooting Star Record"
	ap_location LOC_TARGET_SHOT_RECORD, "Target Shot Record"
	ap_location LOC_BANANA_BUNCH_RECORD, "Banana Bunch Record"

	ap_item ITEM_SINGLES_PASS, "Progressive Singles Pass", "Singles Pass"
	ap_item ITEM_DOUBLES_PASS, "Progressive Doubles Pass", "Doubles Pass"

	ap_item ITEM_SERVICE_MATCH, "Progressive Service Match", "Service Match"
	ap_item ITEM_SERVICE_LESSON, "Progressive Service Lesson", "Service Lesson"
	ap_item ITEM_NET_GAME_MATCH, "Progressive Net Game Match", "Net Game Match"
	ap_item ITEM_NET_GAME_LESSON, "Progressive Net Game Lesson", "Net Game Lesson"
	ap_item ITEM_STROKE_MATCH, "Progressive Stroke Match", "Stroke Match"
	ap_item ITEM_STROKE_LESSON, "Progressive Stroke Lesson", "Stroke Lesson"
	ap_item ITEM_TENNIS_MACHINE, "Progressive Tennis Machine", "Tennis Machine"
	ap_item ITEM_WALL_PRACTICE, "Progressive Wall Practice", "Wall Practice"

; mini-games, in MinigameClearFlagTable_1e game order
	ap_item ITEM_BOO_BLAST, "Boo Blast"
	ap_item ITEM_SHOOTING_STAR, "Shooting Star"
	ap_item ITEM_PERFECT_SHOT, "Perfect Shot"
	ap_item ITEM_TARGET_SHOT, "Target Shot"
	ap_item ITEM_FRUIT_FANTASY, "Fruit Fantasy"
	ap_item ITEM_BANANA_BUNCH, "Banana Bunch"
	ap_item ITEM_TREASURE_BOX, "Treasure Box"
	ap_item ITEM_MEDALLION_MATCH, "Medallion Match"
	ap_item ITEM_TWO_ON_ONE, "Two-on-One"

; equipment, in FLAG_HAVE_* order
	ap_item ITEM_LARGE_RACKET, "Large Racket"
	ap_item ITEM_SMALL_RACKET, "Small Racket"
	ap_item ITEM_IRON_RACKET, "Iron Racket"
	ap_item ITEM_SILVER_RACKET, "Silver Racket"
	ap_item ITEM_GOLD_RACKET, "Gold Racket"
	ap_item ITEM_DRIVE_RACKET, "Drive Racket"
	ap_item ITEM_IRON_SHOES, "Iron Shoes"
	ap_item ITEM_LIGHT_SHOES, "Light Shoes"

	ap_item ITEM_EXP_BUNDLE, "EXP Bundle"

DEF AP_NO_LOCATION EQU $ff
DEF AP_REWARD_LIST_SIZE EQU 32
DEF NUM_MARIO_MINIGAMES EQU 9
DEF SWING_CONTEST_LOW EQU 100
DEF SWING_CONTEST_HIGH EQU 150

; the ledger (ram/sram.asm)
DEF AP_LOCATION_BYTES EQU 16
DEF AP_ITEM_SLOTS EQU 32
DEF AP_RECENT_ITEMS EQU 8
DEF AP_NAME_LENGTH EQU 24
DEF AP_RECENT_ITEM_SIZE EQU 1 + AP_NAME_LENGTH + 1
DEF AP_CHECKSUM_SEED EQU $a55a
DEF AP_ITEM_NAME_SIZE EQU 24
DEF AP_MESSAGE_TEXT EQU $3400
DEF AP_EXP_BUNDLE EQU 100
DEF AP_TEXT_LINE EQU $01
DEF AP_TEXT_DONE EQU $03
ASSERT AP_ITEM_NAME_SIZE == AP_NAME_LENGTH
DEF AP_LOCATION_NAMES_SIZE EQU 2 * (AP_NAME_LENGTH + 1)
ASSERT AP_NUM_LOCATIONS <= AP_LOCATION_BYTES * 8
ASSERT AP_NUM_ITEMS <= AP_ITEM_SLOTS

ENDC
