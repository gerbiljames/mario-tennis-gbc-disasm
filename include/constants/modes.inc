; --- Drill result messages (wDrillMessageId, DrillMessageTextIds_0b) ---
; Named after the text each id shows. QueueDrillResultMessage adds an offset
; in b when the other side served, to reach the same outcome's other
; wording. Ids 72-86 point past text bank $25 (docs/bugs.md) and get no name.
def DRILLMSG_NONE equ $00 ; ShowQueuedDrillMessage substitutes DRILLMSG_THERE_IS_NO_MESSAGE_FOR_THIS_CASE
def DRILLMSG_HIDE equ $ff ; show nothing
def DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT equ $01
def DRILLMSG_DOUBLE_FAULT_YOU_FAILED equ $02
def DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAILED equ $03
def DRILLMSG_I_RETURNED_IT_SO_YOU_FAILED equ $04
def DRILLMSG_I_TOUCHED_IT_SO_YOU_FAILED equ $05
def DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET equ $06
def DRILLMSG_SERVICE_ACE_I_GET_A_POINT equ $07
def DRILLMSG_DOUBLE_FAULT_I_FAIL equ $08
def DRILLMSG_I_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_I_FAIL equ $09
def DRILLMSG_YOU_RETURNED_THE_BALL_SO_I_FAIL equ $0a
def DRILLMSG_YOU_TOUCHED_THE_BALL_SO_I_FAIL equ $0b
def DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_I_GET equ $0c
def DRILLMSG_NICE_SERVE_YOU_GET_A_POINT equ $0d
def DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 equ $0e
def DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAIL equ $0f
def DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL equ $10
def DRILLMSG_YOU_DIDNT_USE_TOPSPIN_TO_BOUNCE_IT_OUT_OF_BOUNDS equ $11
def DRILLMSG_YOU_DIDNT_APPLY_SLICE_TO_BOUNCE_IT_OUT_OF_BOUNDS equ $12
def DRILLMSG_YOU_DIDNT_SERVE_WITH_NICE_TIMING_SO_YOU_FAIL equ $13
def DRILLMSG_NICE_VOLLEY_YOU_GET_A_POINT equ $14
def DRILLMSG_NICE_SMASH_YOU_GET_A_POINT equ $15
def DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT equ $16
def DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT equ $17
def DRILLMSG_I_DIDNT_LOB_THE_BALL_SO_YOU_GET_A_POINT equ $18
def DRILLMSG_DOUBLE_FAULT_YOU_FAILED_3 equ $19
def DRILLMSG_YOU_DIDNT_RETURN_THE_BALL_BEFORE_IT_BOUNCED_SO_YOU equ $1a
def DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE equ $1b
def DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL equ $1c
def DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL equ $1d
def DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET_2 equ $1e
def DRILLMSG_YOU_DIDNT_VOLLEY_THE_BALL_SO_YOU_FAIL equ $1f
def DRILLMSG_YOU_DIDNT_PLAY_THE_NET_SO_YOU_FAIL equ $20
def DRILLMSG_NICE_VOLLEY_I_GET_A_POINT equ $21
def DRILLMSG_NICE_SMASH_I_GET_A_POINT equ $22
def DRILLMSG_WAY_TO_PLAY_THE_NET_I_GET_A_POINT equ $23
def DRILLMSG_YOU_DIDNT_RETURN_IT_SO_I_GET_A_POINT equ $24
def DRILLMSG_YOU_DIDNT_HIT_A_LOB_SO_I_GET_A_POINT equ $25
def DRILLMSG_DOUBLE_FAULT_I_FAIL_2 equ $26
def DRILLMSG_I_DIDNT_RETURN_IT_BEFORE_IT_BOUNCED_SO_I_FAIL equ $27
def DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE equ $28
def DRILLMSG_I_DIDNT_HIT_A_SMASH_SO_I_FAIL equ $29
def DRILLMSG_I_DIDNT_SCORE_SO_I_FAIL equ $2a
def DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_I_GET_2 equ $2b
def DRILLMSG_I_DIDNT_VOLLEY_THE_BALL_SO_I_FAIL equ $2c
def DRILLMSG_I_DIDNT_PLAY_THE_NET_SO_I_FAIL equ $2d
def DRILLMSG_NICE_VOLLEY_YOU_DID_IT equ $2e
def DRILLMSG_NICE_SMASH_YOU_DID_IT equ $2f
def DRILLMSG_NICE_DROP_SHOT_YOU_DID_IT equ $30
def DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED equ $31
def DRILLMSG_I_DIDNT_HIT_A_LOB_SO_YOU_SUCCEED equ $32
def DRILLMSG_DOUBLE_FAULT_YOU_FAIL equ $33
def DRILLMSG_YOU_DIDNT_RETURN_IT_BEFORE_IT_BOUNCED_SO_YOU_FAIL equ $34
def DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 equ $35
def DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL_2 equ $36
def DRILLMSG_YOU_DIDNT_HIT_A_SMASH_WINNER_SO_YOU_FAIL equ $37
def DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2 equ $38
def DRILLMSG_YOU_DIDNT_HIT_A_DROP_SHOT_SO_YOU_FAIL equ $39
def DRILLMSG_YOU_DIDNT_VOLLEY_SO_YOU_FAIL equ $3a
def DRILLMSG_YOU_DIDNT_HIT_A_LONG_DEEP_SERVE_SO_YOU_FAIL equ $3b
def DRILLMSG_YOU_DIDNT_SCORE_WITH_YOUR_DROP_SHOT_SO_YOU_FAIL equ $3c
def DRILLMSG_NICE_LOB_YOU_GET_A_POINT equ $3d
def DRILLMSG_NICE_RETURN_YOU_GET_A_POINT equ $3e
def DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL equ $3f
def DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_WITH_A_LOB_SO_YOU equ $40
def DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT_2 equ $41
def DRILLMSG_DOUBLE_FAULT_YOU_GET_A_POINT equ $42
def DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL equ $43
def DRILLMSG_I_VOLLEYED_SO_YOU_FAIL equ $44
def DRILLMSG_I_HIT_A_SMASH_SO_YOU_FAIL equ $45
def DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 equ $46
def DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL equ $47
def DRILLMSG_NICE_RETURN_YOU_DID_IT equ $57
def DRILLMSG_NICE_LOB_YOU_DID_IT equ $58
def DRILLMSG_YOU_DIDNT_RETURN_IT_SO_YOU_FAIL equ $59
def DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_3 equ $5a
def DRILLMSG_YOU_DIDNT_HIT_A_LOB_SO_YOU_FAIL equ $5b
def DRILLMSG_DOUBLE_FAULT_YOU_PASS equ $5c
def DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL equ $5d
def DRILLMSG_NICE_STROKE_YOUR_POINT equ $5e
def DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT equ $5f
def DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT equ $60
def DRILLMSG_YOUR_BALL_DIDNT_LAND_PAST_MY_SERVICE_LINE_MY_POINT equ $61
def DRILLMSG_YOU_MOVED_PAST_THE_SERVICE_LINE_MY_POINT equ $62
def DRILLMSG_DOUBLE_FAULT_MY_POINT equ $63
def DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_MY_POINT equ $64
def DRILLMSG_NICE_STROKE_MY_POINT equ $65
def DRILLMSG_I_DIDNT_RETURN_THE_TO_YOUR_COURT_YOUR_POINT equ $66
def DRILLMSG_YOU_DIDNT_RETURN_IT_MY_POINT equ $67
def DRILLMSG_MY_RETURN_DIDNT_LAND_PAST_YOUR_SERVICE_LINE_YOUR_POINT equ $68
def DRILLMSG_I_PLAYED_THE_NET_FROM_THE_SERVICE_LINE_YOUR_POINT equ $69
def DRILLMSG_DOUBLE_FAULT_YOUR_POINT equ $6a
def DRILLMSG_I_RETURNED_YOUR_SERVE_BEFORE_IT_BOUNCED_YOUR_POINT equ $6b
def DRILLMSG_THERE_IS_NO_MESSAGE_FOR_THIS_CASE equ $6c

; --- Training drill definitions (drill_def rows, read by StartDrillFromDefinition) ---
def DRILLDEF_OPPONENT     equ $00 ; -> wMatchOpponentChar
def DRILLDEF_COURT        equ $01 ; -> wCurrentlyUsedCourt
def DRILLDEF_CHARS        equ $02 ; -> wOnCourtCharCount
def DRILLDEF_MODE         equ $03 ; -> wGameMode
def DRILLDEF_MATCH        equ $04 ; -> wCurrentMinigameStoryMatch + 1, under MATCHLIST_TRAINING
def DRILLDEF_BGM          equ $05 ; -> wMatchBGM
def DRILLDEF_PLAYER       equ $07 ; the player's character, for InitCa00RecordFromCharId
def DRILLDEF_HOOKS        equ $08 ; word: SetModeHookTable
def DRILLDEF_POINT_TABLE  equ $0a ; word: SetMinigamePointTable
def DRILLDEF_INIT         equ $0c ; word: called if nonzero

; --- Game mode (wGameMode) ---
; What kind of tennis is being played, $00-$0a. Indexes
; SaveQuitMenuIdByGameMode and ScoreboardModeGfxPointers (whose word art spells
; each mode out) unguarded; it is field 0 of Singles/DoublesMatchSettingsTable
; and field 3 of the drill and minigame configs. wGameMode lives inside
; wStorySlotData, so it is saved with the story slot and a results screen
; reopened from the main menu renders the saved mode.
def GAMEMODE_NONE           equ $00 ; no match; the story overworld (RunStoryLocation clears it)
def GAMEMODE_RANKING_MATCH  equ $01 ; story class-ranking match (Junior/Senior/Varsity)
def GAMEMODE_ISLAND_OPEN    equ $02 ; story Island Open tournament match
def GAMEMODE_PRACTICE_MATCH equ $03 ; story practice match
def GAMEMODE_EXHIBITION     equ $04 ; exhibition mode (outside story mode)
def GAMEMODE_TRAINING_DRILL equ $05 ; Training Court lesson/drill (bank $0b definitions)
def GAMEMODE_TENNIS_MACHINE equ $06 ; Tennis Machine Room (FLAG_CLEARED_MACHINE_MASTER)
def GAMEMODE_WALL_PRACTICE  equ $07 ; Wall Practice Room (FLAG_CLEARED_WALL_MASTER)
def GAMEMODE_MARIO_MINIGAME equ $08 ; a Mario mini-game (bank $0d configs)
def GAMEMODE_LINK_MATCH     equ $09 ; link-cable versus match (set beside wLinkMatchRole)
def GAMEMODE_DREAM_MATCH    equ $0a ; story Dream Match against the Mario cast

; --- Match-list category (wCurrentMinigameStoryMatch high byte, $c8f6) ---
; The 16-bit selector at $c8f6 is (category, index). 0/1: the index is a row of
; SinglesMatchSettingsTable_0a / DoublesMatchSettingsTable_0a; 2: the index is
; a MINIGAME_* id (written by every drill and minigame setup path).
def MATCHLIST_SINGLES  equ $00
def MATCHLIST_DOUBLES  equ $01
def MATCHLIST_TRAINING equ $02

; --- Story match ids (wCurrentMinigameStoryMatch low byte under
; MATCHLIST_SINGLES / MATCHLIST_DOUBLES): the row of the match settings table.
; The ranked matches count down to #1. $0f, $14 and $15 are table rows no
; documented match uses (two grass practice matches and an empty row).
def STORYMATCH_JUNIOR_PRACTICE       equ $00
def STORYMATCH_JUNIOR_4              equ $01
def STORYMATCH_JUNIOR_3              equ $02
def STORYMATCH_JUNIOR_2              equ $03
def STORYMATCH_JUNIOR_1              equ $04
def STORYMATCH_SENIOR_PRACTICE       equ $05
def STORYMATCH_SENIOR_4              equ $06
def STORYMATCH_SENIOR_3              equ $07
def STORYMATCH_SENIOR_2              equ $08
def STORYMATCH_SENIOR_1              equ $09
def STORYMATCH_VARSITY_PRACTICE      equ $0a
def STORYMATCH_VARSITY_4             equ $0b
def STORYMATCH_VARSITY_3             equ $0c
def STORYMATCH_VARSITY_2             equ $0d
def STORYMATCH_VARSITY_1             equ $0e
def STORYMATCH_ISLAND_OPEN_ROUND_1   equ $10
def STORYMATCH_ISLAND_OPEN_ROUND_2   equ $11
def STORYMATCH_ISLAND_OPEN_SEMIFINAL equ $12
def STORYMATCH_ISLAND_OPEN_FINAL     equ $13
def STORYMATCH_DREAM_MAX             equ $16
def STORYMATCH_DREAM_INTENSE         equ $17
def STORYMATCH_DREAM_HARD            equ $18

; --- Training/minigame ids (wCurrentMinigameStoryMatch low byte, $c8f7) ---
; The argument of RunTrainingDrillByID, the single entry point for
; MATCHLIST_TRAINING: below $12 it indexes DrillDefinitionPtrs, otherwise
; StartMinigameByID indexes MinigameConfigTable with id - $12 ($24 is
; special-cased into RunDoublesDrillMatch).
; The 18 drill names come from the debug drill list (text 31:141-31:147, item
; order == id). Match drills run on COURT_TRAINING_MATCH, Practice drills on
; COURT_TRAINING_PRACTICE; the story lesson menus add $03/$09/$0f to a 0-2
; pick. (The ROM's menu string for id 3 reads "Service Match 1", a typo for
; "Service Practice 1".)
; $12-$1b are the Tennis Machine and Wall Practice levels plus their two
; high-score ("Master Lvl") variants.
; $1c-$24 are the nine Mario minigames; SetMinigameClearFlag indexes
; MinigameClearFlagTable_1e by (id - $1c) * 3 + level.
def MINIGAME_SERVICE_MATCH_1           equ $00
def MINIGAME_SERVICE_MATCH_2           equ $01
def MINIGAME_SERVICE_MATCH_3           equ $02
def MINIGAME_SERVICE_PRACTICE_1        equ $03
def MINIGAME_SERVICE_PRACTICE_2        equ $04
def MINIGAME_SERVICE_PRACTICE_3        equ $05
def MINIGAME_NET_GAME_MATCH_1          equ $06
def MINIGAME_NET_GAME_MATCH_2          equ $07
def MINIGAME_NET_GAME_MATCH_3          equ $08
def MINIGAME_NET_GAME_PRACTICE_1       equ $09
def MINIGAME_NET_GAME_PRACTICE_2       equ $0a
def MINIGAME_NET_GAME_PRACTICE_3       equ $0b
def MINIGAME_STROKE_MATCH_1            equ $0c
def MINIGAME_STROKE_MATCH_2            equ $0d
def MINIGAME_STROKE_MATCH_3            equ $0e
def MINIGAME_STROKE_PRACTICE_1         equ $0f
def MINIGAME_STROKE_PRACTICE_2         equ $10
def MINIGAME_STROKE_PRACTICE_3         equ $11
def MINIGAME_TENNIS_MACHINE_1          equ $12 ; "Machine Lvl 1"
def MINIGAME_TENNIS_MACHINE_2          equ $13
def MINIGAME_TENNIS_MACHINE_3          equ $14
def MINIGAME_TENNIS_MACHINE_4          equ $15
def MINIGAME_WALL_PRACTICE_1           equ $16 ; "Wall Lvl 1"
def MINIGAME_WALL_PRACTICE_2           equ $17
def MINIGAME_WALL_PRACTICE_3           equ $18
def MINIGAME_WALL_PRACTICE_4           equ $19
def MINIGAME_TENNIS_MACHINE_HIGH_SCORE equ $1a ; "Machine Master Lvl"
def MINIGAME_WALL_PRACTICE_HIGH_SCORE  equ $1b ; "Wall Master Lvl"
def MINIGAME_BOO_BLAST                 equ $1c ; first Mario minigame
def MINIGAME_SHOOTING_STAR             equ $1d
def MINIGAME_PERFECT_SHOT              equ $1e
def MINIGAME_TARGET_SHOT               equ $1f
def MINIGAME_FRUIT_FANTASY             equ $20
def MINIGAME_BANANA_BUNCH              equ $21
def MINIGAME_TREASURE_BOX              equ $22
def MINIGAME_MEDALLION_MATCH           equ $23
def MINIGAME_TWO_ON_ONE                equ $24

; --- Mario-minigame select slot (wSelectedMinigame) ---
; The cell index of the 3x3 Mario-minigame grid, turned into a MINIGAME_* id
; through MinigameDrillIdTable. The same index picks the character shown in
; the cell (MarioCastCharAtGridSlotTable) and the rules page (slot * 3 +
; wMinigameLevel); CheckMinigameGridExpanded asks whether slot 6 is unlocked
; to choose between the 6-cell and 9-cell grids.
def MARIOGAME_BOO_BLAST       equ $00 ; Mario
def MARIOGAME_SHOOTING_STAR   equ $01 ; Luigi
def MARIOGAME_PERFECT_SHOT    equ $02 ; Peach
def MARIOGAME_TARGET_SHOT     equ $03 ; Baby Mario
def MARIOGAME_FRUIT_FANTASY   equ $04 ; Yoshi
def MARIOGAME_BANANA_BUNCH    equ $05 ; DK
def MARIOGAME_TREASURE_BOX    equ $06 ; Wario; first cell of the expanded grid
def MARIOGAME_MEDALLION_MATCH equ $07 ; Waluigi
def MARIOGAME_TWO_ON_ONE      equ $08 ; Bowser
