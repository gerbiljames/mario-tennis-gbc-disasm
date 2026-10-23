; --- Character record fields ---
; The $40-byte record of the story characters (wStoryMain/wStoryPartner,
; mirrored at wSavedMain/wSavedPartner) and the four on-court match records
; (wPlayer1Main onwards), which bank $02 reaches as `ld hl, CHARREC_* / add hl, bc` with the record in bc.
	rsreset
def CHARREC_NAME             rb 7 ; $00 then padding
	rb_skip 3                        ; $07
def CHARREC_LINK_COURT_MASK  rb   ; $0a name padding; ExchangeLinkCharSelection borrows the main records' byte
def CHARREC_CHAR             rb   ; $0b CHAR_* id
def CHARREC_PALETTE          rb   ; $0c
def CHARREC_GENDER           rb   ; $0d 0 male, 1 female
def CHARREC_LEFT_HANDED      rb   ; $0e becomes the OAM X-flip on court
def CHARREC_AI_POSITION      rb   ; $0f home-position strategy, copied to wAiPositionStrategy
def CHARREC_REACH            rb 8 ; $10 the reach box
def CHARREC_LEVEL            rb   ; $18 1-99; each level-up also raises one of CHARREC_TRAIN_LEVELS
def CHARREC_SHOT_TRAITS      rw   ; $19 shot-trait bits: bit 7 of the low byte for StartCharSwing, high bits 0/1 pick the lob and drop placement rows; STATARCH_TRAIT_UNLOCKS can OR more in
def CHARREC_AI_PARAMS        rb 4 ; $1b reaction delays near and far, tracking, aim-away chance
def CHARREC_DIFFICULTY       rb   ; $1f AI difficulty: 0 easy - 3 intense from the CPU menus, 4-8 drill-feeder shot rows (wAiDifficulty)
def CHARREC_STAT_TOP         rb   ; $20 the eleven 0-9 stats, in this order
def CHARREC_STAT_SLICE       rb   ; $21
def CHARREC_STAT_SERVE       rb   ; $22
def CHARREC_STAT_STROKE      rb   ; $23
def CHARREC_STAT_VOLLEY      rb   ; $24
def CHARREC_STAT_ANGLE       rb   ; $25
def CHARREC_STAT_PLACEMENT   rb   ; $26
def CHARREC_STAT_SPEED       rb   ; $27
def CHARREC_STAT_DASH        rb   ; $28
def CHARREC_STAT_REACTION    rb   ; $29
def CHARREC_STAT_STOP        rb   ; $2a
def CHARREC_SPEED_BONUS      rb   ; $2b added to the Speed stat for the shot-placement row
def CHARREC_EXP              rb 3 ; $2c accumulator, capped at 99999
def CHARREC_BUILD_KIND       rb   ; $2f written by InitMatchRecordFromCharId ($03 main, $02 roster), read by nothing
def CHARREC_PHYSICS_TEMPLATE rw 4 ; $30
def CHARREC_TRAIN_LEVELS     rb 4 ; $38 in TRAINSTAT_* order
def CHARREC_EQUIPMENT        rb   ; $3c racket (low nibble) and shoes (high)
	rb_skip 3                        ; $3d
def CHAR_RECORD_SIZE equ _RS
	ASSERT CHAR_RECORD_SIZE == $40
def MAX_LEVEL equ 99 ; CHARREC_LEVEL stops here
def NUM_CHAR_STATS equ CHARREC_SPEED_BONUS - CHARREC_STAT_TOP ; the eleven 0-9 stat bars

; --- Stat index (CHARREC_STAT_* - CHARREC_STAT_TOP; wCharDataStats and its siblings + n) ---
	const_def
	const CHARSTAT_TOP       ; $00
	const CHARSTAT_SLICE     ; $01
	const CHARSTAT_SERVE     ; $02
	const CHARSTAT_STROKE    ; $03
	const CHARSTAT_VOLLEY    ; $04
	const CHARSTAT_ANGLE     ; $05
	const CHARSTAT_PLACEMENT ; $06
	const CHARSTAT_SPEED     ; $07
	const CHARSTAT_DASH      ; $08
	const CHARSTAT_REACTION  ; $09
	const CHARSTAT_STOP      ; $0a
	ASSERT const_value == NUM_CHAR_STATS
	ASSERT CHARREC_STAT_TOP - CHARREC_STAT_TOP == CHARSTAT_TOP
	ASSERT CHARREC_STAT_SLICE - CHARREC_STAT_TOP == CHARSTAT_SLICE
	ASSERT CHARREC_STAT_SERVE - CHARREC_STAT_TOP == CHARSTAT_SERVE
	ASSERT CHARREC_STAT_STROKE - CHARREC_STAT_TOP == CHARSTAT_STROKE
	ASSERT CHARREC_STAT_VOLLEY - CHARREC_STAT_TOP == CHARSTAT_VOLLEY
	ASSERT CHARREC_STAT_ANGLE - CHARREC_STAT_TOP == CHARSTAT_ANGLE
	ASSERT CHARREC_STAT_PLACEMENT - CHARREC_STAT_TOP == CHARSTAT_PLACEMENT
	ASSERT CHARREC_STAT_SPEED - CHARREC_STAT_TOP == CHARSTAT_SPEED
	ASSERT CHARREC_STAT_DASH - CHARREC_STAT_TOP == CHARSTAT_DASH
	ASSERT CHARREC_STAT_REACTION - CHARREC_STAT_TOP == CHARSTAT_REACTION
	ASSERT CHARREC_STAT_STOP - CHARREC_STAT_TOP == CHARSTAT_STOP

; --- Stat archetype layout (StatArchetype*_02, picked by CHARREC_CHAR & 3) ---
	rsreset
def STATARCH_LEVEL          rb      ; $00 -> CHARREC_LEVEL
def STATARCH_TEMPLATE       rb CHARREC_EQUIPMENT - CHARREC_PHYSICS_TEMPLATE ; $01 -> CHARREC_PHYSICS_TEMPLATE onwards
def STATARCH_THRESHOLDS     equ _RS ; $0d one stat_thresholds row per stat, CHARREC_STAT_* order
def STATARCH_TOP            rb 9
def STATARCH_SLICE          rb 9
def STATARCH_SERVE          rb 9
def STATARCH_STROKE         rb 9
def STATARCH_VOLLEY         rb 9
def STATARCH_ANGLE          rb 9
def STATARCH_PLACEMENT      rb 9
def STATARCH_SPEED          rb 9
def STATARCH_DASH           rb 9
def STATARCH_REACTION       rb 9
def STATARCH_STOP           rb 9
def STATARCH_TRAIT_UNLOCKS  equ _RS ; $70 (level, ShotTraitMasks_02 index) pairs OR'd into CHARREC_SHOT_TRAITS, to $ff
	ASSERT STATARCH_TRAIT_UNLOCKS - STATARCH_THRESHOLDS == NUM_CHAR_STATS * 9

; --- Match record slots (GetMatchRecordPtr's a, InitMatchRecordFromCharId's c) ---
	const_def
	const MATCHREC_P1_MAIN    ; $00 wPlayer1Main
	const MATCHREC_P1_PARTNER ; $01 wPlayer1Partner
	const MATCHREC_P2_MAIN    ; $02 wPlayer2Main
	const MATCHREC_P2_PARTNER ; $03 wPlayer2Partner
def NUM_MATCHRECS equ const_value

; --- Training stat (LevelUpPlayer's d; CHARREC_TRAIN_LEVELS + n) ---
	const_def
	const TRAINSTAT_SPIN    ; $00
	const TRAINSTAT_POWER   ; $01
	const TRAINSTAT_CONTROL ; $02
	const TRAINSTAT_SPEED   ; $03
def NUM_TRAINSTATS equ const_value
def TRAINSTAT_NONE equ $ff ; the level alone goes up

; --- Created-character record (wCreatedCharRecords: main then partner of each
; save slot, filled by BuildCreatedCharRecords from the story records) ---
	rsreset
def CREATEDCHAR_CHAR    rb   ; $00 CHAR_* id, $ff for an empty slot
def CREATEDCHAR_PALETTE rb   ; $01
def CREATEDCHAR_LEVEL   rb   ; $02
def CREATEDCHAR_SPIN    rb   ; $03 the training levels, TRAINSTAT_* order
def CREATEDCHAR_POWER   rb   ; $04
def CREATEDCHAR_CONTROL rb   ; $05
def CREATEDCHAR_SPEED   rb   ; $06
def CREATEDCHAR_NAME    rb CHARREC_CHAR - CHARREC_NAME ; $07
	rb_skip $20 - _RS                ; $12
def CREATED_CHAR_RECORD_SIZE equ _RS
	ASSERT CREATED_CHAR_RECORD_SIZE == $20

; --- Save-slot summary (wSaveSlotSummaries: one per story file, filled by
; BuildSaveSlotSummaries for the main-menu, saved-data and erase captions) ---
	rsreset
def SLOTSUM_CHAR    rb   ; $00 CHAR_* id, CHAR_EMPTY_SLOT for an empty file
def SLOTSUM_PALETTE rb   ; $01
def SLOTSUM_LEVEL   rb   ; $02
def SLOTSUM_NAME    rb CHARREC_CHAR - CHARREC_NAME ; $03
def SLOTSUM_MINUTES rb   ; $0e the saved play time
def SLOTSUM_HOURS   rb   ; $0f
def SLOTSUM_SIZE equ _RS
	ASSERT SLOTSUM_SIZE == $10

; --- Character ids (character record byte +$0b, wMatchPlayerChar/OpponentChar) ---
; The 32-entry roster, in the order every character-indexed table takes:
; CharSpriteSetTable, CharPaletteIndexTable, CharacterPortraitTable_16 and the
; bank $1b menu mugshots. The name is text id $001b + id (bank $30 strings
; from index $1b).
	const_def
	const CHAR_ALEX       ; $00
	const CHAR_NINA       ; $01
	const CHAR_HARRY      ; $02
	const CHAR_KATE       ; $03
def NUM_STORY_HEROES equ const_value ; the four story heroes, always unlocked
	const CHAR_ALLIE      ; $04
	const CHAR_JOY        ; $05
	const CHAR_BRIAN      ; $06
	const CHAR_PAM        ; $07
	const CHAR_BOB        ; $08
	const CHAR_BETH       ; $09
	const CHAR_FAY        ; $0a
	const CHAR_CURT       ; $0b
	const CHAR_MARK       ; $0c
	const CHAR_SEAN       ; $0d
	const CHAR_SAMMI      ; $0e
	const CHAR_ELDEN      ; $0f
	const CHAR_SPIKE      ; $10
	const CHAR_EMILY      ; $11
	const CHAR_B_COZ      ; $12 "B. Coz"
	const CHAR_A_COZ      ; $13 "A. Coz"
	const CHAR_KEVIN      ; $14
	const CHAR_UNUSED_15  ; $15 roster slot reading "Not used"; see below
	const CHAR_UNUSED_16  ; $16 roster slot reading "Not used"
	const CHAR_LUIGI      ; $17
	const CHAR_DK         ; $18
	const CHAR_BABY_MARIO ; $19 "Baby M."
	const CHAR_MARIO      ; $1a
	const CHAR_WALUIGI    ; $1b
	const CHAR_YOSHI      ; $1c
	const CHAR_BOWSER     ; $1d
	const CHAR_WARIO      ; $1e
	const CHAR_PEACH      ; $1f

; --- Extended character ids: the story and minigame opponents ---
; Records $20-$35 of StoryCharacterRecords_02 continue the roster's name pool
; (bank $30 string id + 27): "Ranker 32" to "Ranker 47", then six named
; opponents. On screen RemapExtendedCharId shows each as a roster character
; (ExtendedCharIdRemap_02). Records $36 and up have no name in the pool. $36,
; $49-$53, $57 and $5a are unnamed because nothing loads them; their stats are
; all zero.
	const_def $20
	const CHAR_RANKER_32 ; $20
	const CHAR_RANKER_33 ; $21
	const CHAR_RANKER_34 ; $22
	const CHAR_RANKER_35 ; $23
	const CHAR_RANKER_36 ; $24
	const CHAR_RANKER_37 ; $25
	const CHAR_RANKER_38 ; $26
	const CHAR_RANKER_39 ; $27
	const CHAR_RANKER_40 ; $28
	const CHAR_RANKER_41 ; $29
	const CHAR_RANKER_42 ; $2a
	const CHAR_RANKER_43 ; $2b
	const CHAR_RANKER_44 ; $2c
	const CHAR_RANKER_45 ; $2d
	const CHAR_RANKER_46 ; $2e
	const CHAR_RANKER_47 ; $2f
	const CHAR_KEVIN_2   ; $30 shown as Kevin
	const CHAR_EMILY_2   ; $31 shown as Emily
	const CHAR_MARK_2    ; $32 shown as Mark
	const CHAR_BOB_2     ; $33 shown as Bob (bank $30 name pool: "Ellis")
	const CHAR_FAY_2     ; $34 shown as Fay (name pool: "Frank")
	const CHAR_CURT_2    ; $35 shown as Curt (name pool: "Edgar")
; Two match drills swap their opponent's record by server at each point
; (LoadDrillOpponentBySide): the net-game matches use these on the points the
; opponent serves, the stroke matches on the points the player serves.
	const_def $54
	const CHAR_DRILL_NET_GAME_MATCH_1_SERVING ; $54
	const CHAR_DRILL_NET_GAME_MATCH_2_SERVING ; $55
	const CHAR_DRILL_NET_GAME_MATCH_3_SERVING ; $56
; $57 would be Stroke Match 1's: its stats are all zero and that drill loads
; no second record.
def CHAR_DRILL_STROKE_MATCH_2_RECEIVING   equ $58
def CHAR_DRILL_STROKE_MATCH_3_RECEIVING   equ $59
; Records $5b-$60 are the Dream Match opponents' records, in the match
; settings rows of STORYMATCH_DREAM_HARD/_INTENSE/_MAX (singles, then doubles).
	const_def $5b
	const CHAR_DREAM_HARD            ; $5b
	const CHAR_DREAM_INTENSE         ; $5c
	const CHAR_DREAM_MAX             ; $5d
	const CHAR_DREAM_DOUBLES_HARD    ; $5e
	const CHAR_DREAM_DOUBLES_INTENSE ; $5f
	const CHAR_DREAM_DOUBLES_MAX     ; $60
; ... and their doubles partners, which DoublesPartnerTable_0a pairs with
; them (AssignStoryMatchCharacters loads the partner from the opponent's id).
	const_def $61
	const CHAR_DREAM_DOUBLES_HARD_PARTNER    ; $61
	const CHAR_DREAM_DOUBLES_INTENSE_PARTNER ; $62
	const CHAR_DREAM_DOUBLES_MAX_PARTNER     ; $63
; Records $37-$48 are the drill partners, one per training drill in
; MINIGAME_* order: each drill_def names its own as the opponent.
	const_def $37
	const CHAR_DRILL_SERVICE_MATCH_1     ; $37
	const CHAR_DRILL_SERVICE_MATCH_2     ; $38
	const CHAR_DRILL_SERVICE_MATCH_3     ; $39
	const CHAR_DRILL_SERVICE_PRACTICE_1  ; $3a
	const CHAR_DRILL_SERVICE_PRACTICE_2  ; $3b
	const CHAR_DRILL_SERVICE_PRACTICE_3  ; $3c
	const CHAR_DRILL_NET_GAME_MATCH_1    ; $3d
	const CHAR_DRILL_NET_GAME_MATCH_2    ; $3e
	const CHAR_DRILL_NET_GAME_MATCH_3    ; $3f
	const CHAR_DRILL_NET_GAME_PRACTICE_1 ; $40
	const CHAR_DRILL_NET_GAME_PRACTICE_2 ; $41
	const CHAR_DRILL_NET_GAME_PRACTICE_3 ; $42
	const CHAR_DRILL_STROKE_MATCH_1      ; $43
	const CHAR_DRILL_STROKE_MATCH_2      ; $44
	const CHAR_DRILL_STROKE_MATCH_3      ; $45
	const CHAR_DRILL_STROKE_PRACTICE_1   ; $46
	const CHAR_DRILL_STROKE_PRACTICE_2   ; $47
	const CHAR_DRILL_STROKE_PRACTICE_3   ; $48

; --- Character-id sentinels (values outside the roster) ---
; InitMatchRecordFromCharId branches on the id before using it as a roster
; index: $ff clears the slot and stamps $ff at record +$0b, and any id with
; bit 7 set names a story character record instead -- bit 0 selects $c900
; (main) or $c940 (partner). Ids $20 and up are remapped into 4-31 by
; RemapExtendedCharId for their name and portrait.
; CHAR_UNUSED_15 doubles as a "no visible opponent / locked" marker: it is the
; opponent of every Tennis Machine config and of Shooting Star, and
; GetUnlockedMarioCastCharAtGridSlot returns it for a locked Mario-cast slot.
def CHAR_NONE          equ $ff ; empty court slot
def CHAR_STORY_MAIN    equ $80 ; the story slot's own character ($c900 record)
def CHAR_STORY_PARTNER equ $81 ; its doubles partner ($c940 record)
def CHAR_EMPTY_SLOT    equ $3f ; an empty story file's character, shown with palette $03; DecompressCharMugshot adds wCurrentStorySlot to it

; --- Story character record (wStoryCharacterSlot; GetPlayerRecordPtr's a) ---
; GetPlayerRecordPtr tests a for zero, so any nonzero value selects the
; partner; InitMatchRecordFromCharId picks the record by bit 0 of a
; CHAR_STORY_* id.
def STORYREC_MAIN    equ $00 ; wStoryMain ($c900)
def STORYREC_PARTNER equ $01 ; wStoryPartner ($c940)
ASSERT (CHAR_STORY_MAIN & 1) == STORYREC_MAIN
ASSERT (CHAR_STORY_PARTNER & 1) == STORYREC_PARTNER
