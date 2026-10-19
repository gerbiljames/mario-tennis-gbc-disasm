; --- Drill result messages (wDrillMessageId, DrillMessageTextIds_0b) ---
; Named after the text each id shows. QueueDrillResultMessage adds an offset
; in b when the other side served, to reach the same outcome's other
; wording. Ids 72-86 point past text bank $25 (docs/bugs.md) and get no name.
def DRILLMSG_NONE equ $00 ; ShowQueuedDrillMessage substitutes DRILLMSG_THERE_IS_NO_MESSAGE_FOR_THIS_CASE
def DRILLMSG_HIDE equ $ff ; show nothing
	const_def $01
	const DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT                         ; $01
	const DRILLMSG_DOUBLE_FAULT_YOU_FAILED                             ; $02
	const DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAILED    ; $03
	const DRILLMSG_I_RETURNED_IT_SO_YOU_FAILED                         ; $04
	const DRILLMSG_I_TOUCHED_IT_SO_YOU_FAILED                          ; $05
	const DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET   ; $06
	const DRILLMSG_SERVICE_ACE_I_GET_A_POINT                           ; $07
	const DRILLMSG_DOUBLE_FAULT_I_FAIL                                 ; $08
	const DRILLMSG_I_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_I_FAIL          ; $09
	const DRILLMSG_YOU_RETURNED_THE_BALL_SO_I_FAIL                     ; $0a
	const DRILLMSG_YOU_TOUCHED_THE_BALL_SO_I_FAIL                      ; $0b
	const DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_I_GET   ; $0c
	const DRILLMSG_NICE_SERVE_YOU_GET_A_POINT                          ; $0d
	const DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2                           ; $0e
	const DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAIL      ; $0f
	const DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL           ; $10
	const DRILLMSG_YOU_DIDNT_USE_TOPSPIN_TO_BOUNCE_IT_OUT_OF_BOUNDS    ; $11
	const DRILLMSG_YOU_DIDNT_APPLY_SLICE_TO_BOUNCE_IT_OUT_OF_BOUNDS    ; $12
	const DRILLMSG_YOU_DIDNT_SERVE_WITH_NICE_TIMING_SO_YOU_FAIL        ; $13
	const DRILLMSG_NICE_VOLLEY_YOU_GET_A_POINT                         ; $14
	const DRILLMSG_NICE_SMASH_YOU_GET_A_POINT                          ; $15
	const DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT                 ; $16
	const DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT          ; $17
	const DRILLMSG_I_DIDNT_LOB_THE_BALL_SO_YOU_GET_A_POINT             ; $18
	const DRILLMSG_DOUBLE_FAULT_YOU_FAILED_3                           ; $19
	const DRILLMSG_YOU_DIDNT_RETURN_THE_BALL_BEFORE_IT_BOUNCED_SO_YOU  ; $1a
	const DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE     ; $1b
	const DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL                   ; $1c
	const DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL                         ; $1d
	const DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET_2 ; $1e
	const DRILLMSG_YOU_DIDNT_VOLLEY_THE_BALL_SO_YOU_FAIL               ; $1f
	const DRILLMSG_YOU_DIDNT_PLAY_THE_NET_SO_YOU_FAIL                  ; $20
	const DRILLMSG_NICE_VOLLEY_I_GET_A_POINT                           ; $21
	const DRILLMSG_NICE_SMASH_I_GET_A_POINT                            ; $22
	const DRILLMSG_WAY_TO_PLAY_THE_NET_I_GET_A_POINT                   ; $23
	const DRILLMSG_YOU_DIDNT_RETURN_IT_SO_I_GET_A_POINT                ; $24
	const DRILLMSG_YOU_DIDNT_HIT_A_LOB_SO_I_GET_A_POINT                ; $25
	const DRILLMSG_DOUBLE_FAULT_I_FAIL_2                               ; $26
	const DRILLMSG_I_DIDNT_RETURN_IT_BEFORE_IT_BOUNCED_SO_I_FAIL       ; $27
	const DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE       ; $28
	const DRILLMSG_I_DIDNT_HIT_A_SMASH_SO_I_FAIL                       ; $29
	const DRILLMSG_I_DIDNT_SCORE_SO_I_FAIL                             ; $2a
	const DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_I_GET_2 ; $2b
	const DRILLMSG_I_DIDNT_VOLLEY_THE_BALL_SO_I_FAIL                   ; $2c
	const DRILLMSG_I_DIDNT_PLAY_THE_NET_SO_I_FAIL                      ; $2d
	const DRILLMSG_NICE_VOLLEY_YOU_DID_IT                              ; $2e
	const DRILLMSG_NICE_SMASH_YOU_DID_IT                               ; $2f
	const DRILLMSG_NICE_DROP_SHOT_YOU_DID_IT                           ; $30
	const DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED                    ; $31
	const DRILLMSG_I_DIDNT_HIT_A_LOB_SO_YOU_SUCCEED                    ; $32
	const DRILLMSG_DOUBLE_FAULT_YOU_FAIL                               ; $33
	const DRILLMSG_YOU_DIDNT_RETURN_IT_BEFORE_IT_BOUNCED_SO_YOU_FAIL   ; $34
	const DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2   ; $35
	const DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL_2                 ; $36
	const DRILLMSG_YOU_DIDNT_HIT_A_SMASH_WINNER_SO_YOU_FAIL            ; $37
	const DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2         ; $38
	const DRILLMSG_YOU_DIDNT_HIT_A_DROP_SHOT_SO_YOU_FAIL               ; $39
	const DRILLMSG_YOU_DIDNT_VOLLEY_SO_YOU_FAIL                        ; $3a
	const DRILLMSG_YOU_DIDNT_HIT_A_LONG_DEEP_SERVE_SO_YOU_FAIL         ; $3b
	const DRILLMSG_YOU_DIDNT_SCORE_WITH_YOUR_DROP_SHOT_SO_YOU_FAIL     ; $3c
	const DRILLMSG_NICE_LOB_YOU_GET_A_POINT                            ; $3d
	const DRILLMSG_NICE_RETURN_YOU_GET_A_POINT                         ; $3e
	const DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL               ; $3f
	const DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_WITH_A_LOB_SO_YOU         ; $40
	const DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT_2        ; $41
	const DRILLMSG_DOUBLE_FAULT_YOU_GET_A_POINT                        ; $42
	const DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL                        ; $43
	const DRILLMSG_I_VOLLEYED_SO_YOU_FAIL                              ; $44
	const DRILLMSG_I_HIT_A_SMASH_SO_YOU_FAIL                           ; $45
	const DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2     ; $46
	const DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL ; $47
	const_def $57
	const DRILLMSG_NICE_RETURN_YOU_DID_IT                                 ; $57
	const DRILLMSG_NICE_LOB_YOU_DID_IT                                    ; $58
	const DRILLMSG_YOU_DIDNT_RETURN_IT_SO_YOU_FAIL                        ; $59
	const DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_3            ; $5a
	const DRILLMSG_YOU_DIDNT_HIT_A_LOB_SO_YOU_FAIL                        ; $5b
	const DRILLMSG_DOUBLE_FAULT_YOU_PASS                                  ; $5c
	const DRILLMSG_YOU_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL   ; $5d
	const DRILLMSG_NICE_STROKE_YOUR_POINT                                 ; $5e
	const DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT            ; $5f
	const DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT                           ; $60
	const DRILLMSG_YOUR_BALL_DIDNT_LAND_PAST_MY_SERVICE_LINE_MY_POINT     ; $61
	const DRILLMSG_YOU_MOVED_PAST_THE_SERVICE_LINE_MY_POINT               ; $62
	const DRILLMSG_DOUBLE_FAULT_MY_POINT                                  ; $63
	const DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_MY_POINT       ; $64
	const DRILLMSG_NICE_STROKE_MY_POINT                                   ; $65
	const DRILLMSG_I_DIDNT_RETURN_THE_TO_YOUR_COURT_YOUR_POINT            ; $66
	const DRILLMSG_YOU_DIDNT_RETURN_IT_MY_POINT                           ; $67
	const DRILLMSG_MY_RETURN_DIDNT_LAND_PAST_YOUR_SERVICE_LINE_YOUR_POINT ; $68
	const DRILLMSG_I_PLAYED_THE_NET_FROM_THE_SERVICE_LINE_YOUR_POINT      ; $69
	const DRILLMSG_DOUBLE_FAULT_YOUR_POINT                                ; $6a
	const DRILLMSG_I_RETURNED_YOUR_SERVE_BEFORE_IT_BOUNCED_YOUR_POINT     ; $6b
	const DRILLMSG_THERE_IS_NO_MESSAGE_FOR_THIS_CASE                      ; $6c

; --- Training drill definitions (drill_def rows, read by StartDrillFromDefinition) ---
	const_def
	const DRILLDEF_OPPONENT ; $00 -> wMatchOpponentChar
	const DRILLDEF_COURT    ; $01 -> wCurrentlyUsedCourt
	const DRILLDEF_CHARS    ; $02 -> wOnCourtCharCount
	const DRILLDEF_MODE     ; $03 -> wGameMode
	const DRILLDEF_MATCH    ; $04 -> wCurrentMinigameStoryMatch + 1, under MATCHLIST_TRAINING
	const DRILLDEF_BGM      ; $05 -> wMatchBGM
def DRILLDEF_PLAYER       equ $07 ; the player's character, for InitCa00RecordFromCharId
def DRILLDEF_HOOKS        equ $08 ; word: SetModeHookTable
def DRILLDEF_POINT_TABLE  equ $0a ; word: SetMinigamePointTable
def DRILLDEF_INIT         equ $0c ; word: called if nonzero

; --- Drill counters (wDrillCounters) ---
; Nine bytes each drill uses its own way, so the views below overlap. The
; bytes NetGameMatch1-3 and StrokeMatch2-3 only clear at PointStart stay raw.
; Service matches and lessons:
	rsreset
def DRILLCTR_SERVES_SCORED       rb ; $00 lessons: points won off the serve
def DRILLCTR_P1_SUCCESSES        rb ; $01 CountDrillShotSuccesses for each side
def DRILLCTR_P2_SUCCESSES        rb ; $02
def DRILLCTR_SERVE_SHOT_TYPE     rb ; $03 ServicePractice2: wCurrentShotType of the serve
	rb_skip                         ; $04
def DRILLCTR_LESSON_P1_SUCCESSES rb ; $05 ServicePractice2/3 count the sides here
def DRILLCTR_LESSON_P2_SUCCESSES rb ; $06
; ServicePractice2: serves of each kind still owed, 2 each
	rsset DRILLCTR_P1_SUCCESSES
def DRILLCTR_TOPSPIN_SERVES_LEFT rb ; $01
def DRILLCTR_SLICE_SERVES_LEFT   rb ; $02
; ServicePractice3: 4, less one per nicely timed serve
	rsset DRILLCTR_P1_SUCCESSES
def DRILLCTR_TIMED_SERVES_LEFT   rb ; $01
; Net lessons (NetGamePractice1-3):
	rsset 2
def DRILLCTR_NETP1_NET_OR_OUT    rb ; $02 NetGamePractice1's DRILLCTR_NET_OR_OUT
def DRILLCTR_NET_OR_OUT          rb ; $03 balls into the net or out
def DRILLCTR_PASSES              rb ; $04 points judged passed, shown as points won
def DRILLCTR_SHOTS_LEFT          rb ; $05 4, less one per use of the lesson's shot
; Net matches: per side, nonzero = played the net (read by Unused_0b_NetGameMatch3JudgePoint)
	rsset 5
def DRILLCTR_NET_PLAYED          rb 2 ; $05
; Stroke lessons (StrokePractice1-3):
	rsset 1
def DRILLCTR_OUTS                rb ; $01 StrokePractice1: balls hit out
def DRILLCTR_STROKE_PASSES       rb ; $02 StrokePractice1/3
def DRILLCTR_LOBS equ DRILLCTR_STROKE_PASSES ; StrokePractice2: lobs played
def DRILLCTR_OFF_TARGET          rb ; $03 shots that missed the target area (also NetGamePractice1)
	rsset 7
def DRILLCTR_LOB_PASSES          rb ; $07 StrokePractice2's DRILLCTR_STROKE_PASSES
def DRILLCTR_TARGET_ZONE_DELAY   rb ; $08 frames until wTargetZoneEnabled is set

; --- Drill length (wTotalPointsScoredInCurrentGame) ---
def DRILL_LESSON_POINTS equ 4 ; a practice lesson's points; all of them passed clears it
def DRILL_MATCH_POINTS  equ 8 ; a drill match's points, the serve alternating on bit 0

; --- Drill abort countdown (wDrillAbortCountdown) ---
def DRILL_ABORT_FRAMES equ 10 ; frames, once armed, before a drill point is given up

; --- Drill judge events (a to each *JudgePoint) ---
; Each drill's four *JudgeOn* hooks pass one; JudgePoint jumptables on it.
	const_def
	const JUDGEEVENT_POINT_END  ; $00
	const JUDGEEVENT_BALL_HIT   ; $01
	const JUDGEEVENT_BOUNCE     ; $02
	const JUDGEEVENT_RALLY_TICK ; $03

; --- Lesson result (wDrillLessonResult) ---
; Set by each lesson's *EvaluateResult; the coach's *ResultScene in bank $15
; jumptables on it for the follow-up line, which the names paraphrase. Only
; LESSON_PASSED is common; past the codes a coach shares, each lesson numbers
; its own.
def LESSON_PASSED equ $00
; Curt's serve lessons (ServicePractice1-3)
	const_def $01
	const LESSON_SERVE_NO_POINTS       ; $01 "You missed everyone!"
	const LESSON_SERVE_DOUBLE_FAULT    ; $02
	const LESSON_SERVE_MISSED_TARGET   ; $03
	const LESSON_SPIN_NO_SPIN          ; $04 ServicePractice2: neither spin served
	const LESSON_SPIN_LEFT_ONLY        ; $05 only the left corner cleared (+ wStoryMainLeftHanded)
	const LESSON_SPIN_RIGHT_ONLY       ; $06 only the right (- wStoryMainLeftHanded)
	const_def $04
	const LESSON_SERVE_LINE_TIMING     ; $04 ServicePractice3: serves not timed
	const LESSON_SERVE_LINE_NOT_CENTER ; $05 not served from the center
; Beth's net lessons (NetGamePractice1-3)
	const_def $01
	const LESSON_NET_ALL_FAULTS        ; $01 a double fault every point
	const LESSON_NET_DOUBLE_FAULT      ; $02
	const LESSON_VOLLEY_MISSED         ; $03 NetGamePractice1: slow off the serve
	const LESSON_VOLLEY_WRONG_SIDE     ; $04 volleyed, but not to the opposite side
	const LESSON_VOLLEY_ALMOST         ; $05 one point short
	const_def $03
	const LESSON_SMASH_NOT_ALL_SIDES   ; $03 NetGamePractice2
	const LESSON_SMASH_JUDGE_POSITION  ; $04
	const LESSON_SMASH_MISSED          ; $05 slow off the serve
	const LESSON_SMASH_ALMOST          ; $06
	const_def $03
	const LESSON_DROP_SERVE_SHALLOW    ; $03 NetGamePractice3: serve deeper
	const LESSON_DROP_NOT_ALL_SIDES    ; $04
	const LESSON_DROP_TIMING           ; $05
	const LESSON_DROP_MISSED           ; $06 slow off the serve, serving shallow
	const LESSON_DROP_ALMOST           ; $07
; The return coach's stroke lessons (StrokePractice1-3)
	const_def $01
	const LESSON_RETURN_ALL_OUT        ; $01 StrokePractice1/3: four or more out
	const LESSON_RETURN_INACCURATE     ; $02 two or three out
	const LESSON_RETURN_NO_PASSES      ; $03
	const LESSON_RETURN_INCONSISTENT   ; $04
	const LESSON_RETURN_ALMOST         ; $05
	const_def $01
	const LESSON_LOB_TOO_FEW           ; $01 StrokePractice2: "You're not even hitting lobs!"
	const LESSON_LOB_VOLLEYED          ; $02
	const LESSON_LOB_SMASHED           ; $03 too short
	const LESSON_LOB_NO_CONTROL        ; $04
	const LESSON_LOB_ALMOST            ; $05

; --- Game mode (wGameMode) ---
; What kind of tennis is being played, $00-$0a. Indexes
; SaveQuitMenuIdByGameMode and ScoreboardModeGfxPointers (whose word art spells
; each mode out) unguarded; it is field 0 of Singles/DoublesMatchSettingsTable
; and field 3 of the drill and minigame configs. wGameMode lives inside
; wStorySlotData, so it is saved with the story slot and a results screen
; reopened from the main menu renders the saved mode.
	const_def
	const GAMEMODE_NONE           ; $00 no match; the story overworld (RunStoryLocation clears it)
	const GAMEMODE_RANKING_MATCH  ; $01 story class-ranking match (Junior/Senior/Varsity)
	const GAMEMODE_ISLAND_OPEN    ; $02 story Island Open tournament match
	const GAMEMODE_PRACTICE_MATCH ; $03 story practice match
	const GAMEMODE_EXHIBITION     ; $04 exhibition mode (outside story mode)
	const GAMEMODE_TRAINING_DRILL ; $05 Training Court lesson/drill (bank $0b definitions)
	const GAMEMODE_TENNIS_MACHINE ; $06 Tennis Machine Room (FLAG_CLEARED_MACHINE_MASTER)
	const GAMEMODE_WALL_PRACTICE  ; $07 Wall Practice Room (FLAG_CLEARED_WALL_MASTER)
	const GAMEMODE_MARIO_MINIGAME ; $08 a Mario mini-game (bank $0d configs)
	const GAMEMODE_LINK_MATCH     ; $09 link-cable versus match (set beside wLinkMatchRole)
	const GAMEMODE_DREAM_MATCH    ; $0a story Dream Match against the Mario cast
def NUM_GAMEMODES equ const_value

; --- Match-list category (wCurrentMinigameStoryMatch high byte) ---
; The 16-bit selector is (category, index). 0/1: the index is a row of
; SinglesMatchSettingsTable_0a / DoublesMatchSettingsTable_0a; 2: the index is
; a MINIGAME_* id (written by every drill and minigame setup path).
	const_def
	const MATCHLIST_SINGLES  ; $00
	const MATCHLIST_DOUBLES  ; $01
	const MATCHLIST_TRAINING ; $02

; --- Story match ids (wCurrentMinigameStoryMatch low byte under
; MATCHLIST_SINGLES / MATCHLIST_DOUBLES): the row of the match settings table.
; The ranked matches count down to #1. $0f, $14 and $15 are table rows no
; documented match uses (two grass practice matches and an empty row).
	const_def
	const STORYMATCH_JUNIOR_PRACTICE  ; $00
	const STORYMATCH_JUNIOR_4         ; $01
	const STORYMATCH_JUNIOR_3         ; $02
	const STORYMATCH_JUNIOR_2         ; $03
	const STORYMATCH_JUNIOR_1         ; $04
	const STORYMATCH_SENIOR_PRACTICE  ; $05
	const STORYMATCH_SENIOR_4         ; $06
	const STORYMATCH_SENIOR_3         ; $07
	const STORYMATCH_SENIOR_2         ; $08
	const STORYMATCH_SENIOR_1         ; $09
	const STORYMATCH_VARSITY_PRACTICE ; $0a
	const STORYMATCH_VARSITY_4        ; $0b
	const STORYMATCH_VARSITY_3        ; $0c
	const STORYMATCH_VARSITY_2        ; $0d
	const STORYMATCH_VARSITY_1        ; $0e
	const_def $10
	const STORYMATCH_ISLAND_OPEN_ROUND_1   ; $10
	const STORYMATCH_ISLAND_OPEN_ROUND_2   ; $11
	const STORYMATCH_ISLAND_OPEN_SEMIFINAL ; $12
	const STORYMATCH_ISLAND_OPEN_FINAL     ; $13
	const_def $16
	const STORYMATCH_DREAM_MAX     ; $16
	const STORYMATCH_DREAM_INTENSE ; $17
	const STORYMATCH_DREAM_HARD    ; $18

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
	const_def
	const MINIGAME_SERVICE_MATCH_1           ; $00
	const MINIGAME_SERVICE_MATCH_2           ; $01
	const MINIGAME_SERVICE_MATCH_3           ; $02
	const MINIGAME_SERVICE_PRACTICE_1        ; $03
	const MINIGAME_SERVICE_PRACTICE_2        ; $04
	const MINIGAME_SERVICE_PRACTICE_3        ; $05
	const MINIGAME_NET_GAME_MATCH_1          ; $06
	const MINIGAME_NET_GAME_MATCH_2          ; $07
	const MINIGAME_NET_GAME_MATCH_3          ; $08
	const MINIGAME_NET_GAME_PRACTICE_1       ; $09
	const MINIGAME_NET_GAME_PRACTICE_2       ; $0a
	const MINIGAME_NET_GAME_PRACTICE_3       ; $0b
	const MINIGAME_STROKE_MATCH_1            ; $0c
	const MINIGAME_STROKE_MATCH_2            ; $0d
	const MINIGAME_STROKE_MATCH_3            ; $0e
	const MINIGAME_STROKE_PRACTICE_1         ; $0f
	const MINIGAME_STROKE_PRACTICE_2         ; $10
	const MINIGAME_STROKE_PRACTICE_3         ; $11
	const MINIGAME_TENNIS_MACHINE_1          ; $12 "Machine Lvl 1"
	const MINIGAME_TENNIS_MACHINE_2          ; $13
	const MINIGAME_TENNIS_MACHINE_3          ; $14
	const MINIGAME_TENNIS_MACHINE_4          ; $15
	const MINIGAME_WALL_PRACTICE_1           ; $16 "Wall Lvl 1"
	const MINIGAME_WALL_PRACTICE_2           ; $17
	const MINIGAME_WALL_PRACTICE_3           ; $18
	const MINIGAME_WALL_PRACTICE_4           ; $19
	const MINIGAME_TENNIS_MACHINE_HIGH_SCORE ; $1a "Machine Master Lvl"
	const MINIGAME_WALL_PRACTICE_HIGH_SCORE  ; $1b "Wall Master Lvl"
	const MINIGAME_BOO_BLAST                 ; $1c first Mario minigame
	const MINIGAME_SHOOTING_STAR             ; $1d
	const MINIGAME_PERFECT_SHOT              ; $1e
	const MINIGAME_TARGET_SHOT               ; $1f
	const MINIGAME_FRUIT_FANTASY             ; $20
	const MINIGAME_BANANA_BUNCH              ; $21
	const MINIGAME_TREASURE_BOX              ; $22
	const MINIGAME_MEDALLION_MATCH           ; $23
	const MINIGAME_TWO_ON_ONE                ; $24

; --- Mario-minigame select slot (wSelectedMinigame) ---
; The cell index of the 3x3 Mario-minigame grid, turned into a MINIGAME_* id
; through MinigameDrillIdTable. The same index picks the character shown in
; the cell (MarioCastCharAtGridSlotTable) and the rules page (slot * 3 +
; wMinigameLevel); CheckMinigameGridExpanded asks whether slot 6 is unlocked
; to choose between the 6-cell and 9-cell grids.
	const_def
	const MARIOGAME_BOO_BLAST       ; $00 Mario
	const MARIOGAME_SHOOTING_STAR   ; $01 Luigi
	const MARIOGAME_PERFECT_SHOT    ; $02 Peach
	const MARIOGAME_TARGET_SHOT     ; $03 Baby Mario
	const MARIOGAME_FRUIT_FANTASY   ; $04 Yoshi
	const MARIOGAME_BANANA_BUNCH    ; $05 DK
	const MARIOGAME_TREASURE_BOX    ; $06 Wario; first cell of the expanded grid
	const MARIOGAME_MEDALLION_MATCH ; $07 Waluigi
	const MARIOGAME_TWO_ON_ONE      ; $08 Bowser
def NUM_MARIOGAMES equ const_value

; --- Minigame level (wMinigameLevel, level - 1) ---
def MINIGAMELEVEL_HIGH_SCORE equ $02 ; a Mario minigame's third level sets wMinigameHighScoreMode

; --- Minigame actor fields (wMinigameActors, wMinigameSceneActor) ---
; UpdateMinigameActor copies each live record into wMinigameSceneActor, runs
; its handler on that copy, and copies it back.
	rsreset
def MGACTOR_FLAGS    rb ; $00 bit 0 enabled, bit 1 has a handler
def MGACTOR_SUBTYPE  rb ; $01 per minigame: the treasure box type, the medallion index
def MGACTOR_STATE    rb ; $02 the handler's RST00 sub-state
def MGACTOR_TIMER    rb ; $03
	rb_skip 2          ; $04
def MGACTOR_X        rw ; $06 world X
def MGACTOR_DEPTH    rw ; $08 world depth
def MGACTOR_SCREEN_X rw ; $0a projected
def MGACTOR_SCREEN_Y rw ; $0c
def MGACTOR_HANDLER  rw ; $0e
def MGACTOR_SIZE equ _RS
	ASSERT MGACTOR_SIZE == $10

; --- Minigame target fields (wMinigameTargets, wMinigameTargetWork) ---
; UpdateMinigameTarget copies each live record into wMinigameTargetWork, runs
; its script, movement, draw and hit checks there, and copies it back.
	rsreset
def MGTARGET_FLAGS        rb ; $00 bit 0 live, bit 1 moving toward the goal, bit 2 hit by the ball
def MGTARGET_KIND         rb ; $01 0-3: sprite, deflection, wMinigameHitTargetType
def MGTARGET_HIT_TIMER    rb ; $02 $20 on a hit, counts down; the low nibble shakes the sprite
def MGTARGET_SCRIPT_DELAY rb ; $03 frames before the script runs again
def MGTARGET_SCRIPT       rw ; $04
def MGTARGET_X            rw ; $06
def MGTARGET_DEPTH        rw ; $08
def MGTARGET_GOAL_X       rw ; $0a MoveMinigameTargetTowardGoal steps $10 a frame
def MGTARGET_GOAL_DEPTH   rw ; $0c
def MGTARGET_SIZE equ _RS
	ASSERT MGTARGET_SIZE == 14
