; --- Character record fields ---
; The $40-byte record of the story characters ($c900/$c940, mirrored at
; $c800/$c840) and the four on-court match records ($ca00-$cac0), which bank
; $02 reaches as `ld hl, CHARREC_* / add hl, bc` with the record in bc.
def CHARREC_NAME             equ $00 ; 7 bytes, then padding
	const_def 10
	const CHARREC_LINK_COURT_MASK ; $0a name padding; ExchangeLinkUnlockFlags borrows the main records' byte
	const CHARREC_CHAR            ; $0b CHAR_* id
	const CHARREC_PALETTE         ; $0c
	const CHARREC_GENDER          ; $0d 0 male, 1 female
	const CHARREC_LEFT_HANDED     ; $0e becomes the OAM X-flip on court
	const CHARREC_PHYSICS         ; $0f
	const CHARREC_REACH           ; $10 8 bytes: the reach box
def CHARREC_LEVEL            equ $18 ; 1-99; each level-up also raises one of CHARREC_TRAIN_LEVELS
def CHARREC_SWING            equ $19 ; word
def CHARREC_AI_PARAMS        equ $1b ; 4 bytes: reaction delays near and far, tracking, aim-away chance
	const_def 31
	const CHARREC_DIFFICULTY     ; $1f CPU difficulty 0 easy - 3 intense, the AI's serve style on court
	const CHARREC_STAT_TOP       ; $20 the eleven 0-9 stats, in this order
	const CHARREC_STAT_SLICE     ; $21
	const CHARREC_STAT_SERVE     ; $22
	const CHARREC_STAT_STROKE    ; $23
	const CHARREC_STAT_VOLLEY    ; $24
	const CHARREC_STAT_ANGLE     ; $25
	const CHARREC_STAT_PLACEMENT ; $26
	const CHARREC_STAT_SPEED     ; $27
	const CHARREC_STAT_DASH      ; $28
	const CHARREC_STAT_REACTION  ; $29
	const CHARREC_STAT_STOP      ; $2a
	const CHARREC_SPEED_BONUS    ; $2b added to the Speed stat for the shot-placement row
	const CHARREC_EXP            ; $2c 3-byte accumulator, capped at 99999
def CHARREC_BUILD_KIND        equ $2f ; written by InitCa00RecordFromCharId ($03 main, $02 roster), read by nothing
def CHARREC_PHYSICS_TEMPLATE equ $30 ; four words
def CHARREC_TRAIN_LEVELS     equ $38 ; four levels, spin first
def CHARREC_EQUIPMENT        equ $3c ; racket (low nibble) and shoes (high)

; --- Character ids (character record byte +$0b, wMatchPlayerChar/OpponentChar) ---
; The 32-entry roster, in the order every character-indexed table takes:
; CharSpriteSetTable, CharPaletteIndexTable, CharacterPortraitTable_16 and the
; bank $1b menu mugshots. The name is text id $001b + id (bank $30 strings
; from index $1b). Ids 0-3 are always unlocked; for 4-31
; CheckCharacterUnlocked tests save flag number = character id, so the
; SAVEFLAG_UNLOCKED_*/_CLEARED_* block above names the same characters.
	const_def
	const CHAR_ALEX       ; $00
	const CHAR_NINA       ; $01
	const CHAR_HARRY      ; $02
	const CHAR_KATE       ; $03
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
; (NameTextRemap_02). Records $36 and up have no name in the pool. $36,
; $49-$53, $57 and $5a are unnamed because nothing loads them; their stats are
; all zero.
	const_def 32
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
	const_def 84
	const CHAR_DRILL_NET_GAME_MATCH_1_SERVING ; $54
	const CHAR_DRILL_NET_GAME_MATCH_2_SERVING ; $55
	const CHAR_DRILL_NET_GAME_MATCH_3_SERVING ; $56
; $57 would be Stroke Match 1's: its stats are all zero and that drill loads
; no second record.
def CHAR_DRILL_STROKE_MATCH_2_RECEIVING   equ $58
def CHAR_DRILL_STROKE_MATCH_3_RECEIVING   equ $59
; Records $5b-$60 are the Dream Match opponents' records, in the match
; settings rows of STORYMATCH_DREAM_HARD/_INTENSE/_MAX (singles, then doubles).
	const_def 91
	const CHAR_DREAM_HARD            ; $5b
	const CHAR_DREAM_INTENSE         ; $5c
	const CHAR_DREAM_MAX             ; $5d
	const CHAR_DREAM_DOUBLES_HARD    ; $5e
	const CHAR_DREAM_DOUBLES_INTENSE ; $5f
	const CHAR_DREAM_DOUBLES_MAX     ; $60
; ... and their doubles partners, which DoublesPartnerTable_0a pairs with
; them (AssignStoryMatchCharacters loads the partner from the opponent's id).
	const_def 97
	const CHAR_DREAM_DOUBLES_HARD_PARTNER    ; $61
	const CHAR_DREAM_DOUBLES_INTENSE_PARTNER ; $62
	const CHAR_DREAM_DOUBLES_MAX_PARTNER     ; $63
; Records $37-$48 are the drill partners, one per training drill in
; MINIGAME_* order: each drill_def names its own as the opponent.
	const_def 55
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
; InitCa00RecordFromCharId branches on the id before using it as a roster
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
