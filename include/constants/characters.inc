; --- Character record fields ---
; The $40-byte record of the story characters ($c900/$c940, mirrored at
; $c800/$c840) and the four on-court match records ($ca00-$cac0), which bank
; $02 reaches as `ld hl, CHARREC_* / add hl, bc` with the record in bc.
def CHARREC_NAME             equ $00 ; 7 bytes, then padding
def CHARREC_CHAR             equ $0b ; CHAR_* id
def CHARREC_PALETTE          equ $0c
def CHARREC_GENDER           equ $0d ; 0 male, 1 female
def CHARREC_LEFT_HANDED      equ $0e ; becomes the OAM X-flip on court
def CHARREC_PHYSICS          equ $0f
def CHARREC_REACH            equ $10 ; 8 bytes: the reach box
def CHARREC_LEVEL            equ $18 ; 1-99; each level-up also raises one of CHARREC_TRAIN_LEVELS
def CHARREC_SWING            equ $19 ; word
def CHARREC_AI_PARAMS        equ $1b ; 5 bytes
def CHARREC_STAT_TOP         equ $20 ; the eleven 0-9 stats, in this order
def CHARREC_STAT_SLICE       equ $21
def CHARREC_STAT_SERVE       equ $22
def CHARREC_STAT_STROKE      equ $23
def CHARREC_STAT_VOLLEY      equ $24
def CHARREC_STAT_ANGLE       equ $25
def CHARREC_STAT_PLACEMENT   equ $26
def CHARREC_STAT_SPEED       equ $27
def CHARREC_STAT_DASH        equ $28
def CHARREC_STAT_REACTION    equ $29
def CHARREC_STAT_STOP        equ $2a
def CHARREC_SPEED_BONUS      equ $2b ; added to the Speed stat for the shot-placement row
def CHARREC_EXP              equ $2c ; 3-byte accumulator, capped at 99999
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
def CHAR_ALEX       equ $00
def CHAR_NINA       equ $01
def CHAR_HARRY      equ $02
def CHAR_KATE       equ $03
def CHAR_ALLIE      equ $04
def CHAR_JOY        equ $05
def CHAR_BRIAN      equ $06
def CHAR_PAM        equ $07
def CHAR_BOB        equ $08
def CHAR_BETH       equ $09
def CHAR_FAY        equ $0a
def CHAR_CURT       equ $0b
def CHAR_MARK       equ $0c
def CHAR_SEAN       equ $0d
def CHAR_SAMMI      equ $0e
def CHAR_ELDEN      equ $0f
def CHAR_SPIKE      equ $10
def CHAR_EMILY      equ $11
def CHAR_B_COZ      equ $12 ; "B. Coz"
def CHAR_A_COZ      equ $13 ; "A. Coz"
def CHAR_KEVIN      equ $14
def CHAR_UNUSED_15  equ $15 ; roster slot reading "Not used"; see below
def CHAR_UNUSED_16  equ $16 ; roster slot reading "Not used"
def CHAR_LUIGI      equ $17
def CHAR_DK         equ $18
def CHAR_BABY_MARIO equ $19 ; "Baby M."
def CHAR_MARIO      equ $1a
def CHAR_WALUIGI    equ $1b
def CHAR_YOSHI      equ $1c
def CHAR_BOWSER     equ $1d
def CHAR_WARIO      equ $1e
def CHAR_PEACH      equ $1f

; --- Extended character ids: the story and minigame opponents ---
; Records $20-$35 of StoryCharacterRecords_02 continue the roster's name pool
; (bank $30 string id + 27): "Ranker 32" to "Ranker 47", then six named
; opponents. On screen RemapExtendedCharId shows each as a roster character
; (NameTextRemap_02). Records $36 and up have no name in the pool. $36,
; $49-$53, $57 and $5a are unnamed because nothing loads them; their stats are
; all zero.
def CHAR_RANKER_32     equ $20
def CHAR_RANKER_33     equ $21
def CHAR_RANKER_34     equ $22
def CHAR_RANKER_35     equ $23
def CHAR_RANKER_36     equ $24
def CHAR_RANKER_37     equ $25
def CHAR_RANKER_38     equ $26
def CHAR_RANKER_39     equ $27
def CHAR_RANKER_40     equ $28
def CHAR_RANKER_41     equ $29
def CHAR_RANKER_42     equ $2a
def CHAR_RANKER_43     equ $2b
def CHAR_RANKER_44     equ $2c
def CHAR_RANKER_45     equ $2d
def CHAR_RANKER_46     equ $2e
def CHAR_RANKER_47     equ $2f
def CHAR_KEVIN_2     equ $30 ; shown as Kevin
def CHAR_EMILY_2     equ $31 ; shown as Emily
def CHAR_MARK_2      equ $32 ; shown as Mark
def CHAR_ELLIS       equ $33
def CHAR_FRANK       equ $34
def CHAR_EDGAR       equ $35
; Two match drills swap their opponent's record by server at each point
; (LoadDrillOpponentBySide): the net-game matches use these on the points the
; opponent serves, the stroke matches on the points the player serves.
def CHAR_DRILL_NET_GAME_MATCH_1_SERVING   equ $54
def CHAR_DRILL_NET_GAME_MATCH_2_SERVING   equ $55
def CHAR_DRILL_NET_GAME_MATCH_3_SERVING   equ $56
; $57 would be Stroke Match 1's: its stats are all zero and that drill loads
; no second record.
def CHAR_DRILL_STROKE_MATCH_2_RECEIVING   equ $58
def CHAR_DRILL_STROKE_MATCH_3_RECEIVING   equ $59
; Records $5b-$60 are the Dream Match opponents' records, in the match
; settings rows of STORYMATCH_DREAM_HARD/_INTENSE/_MAX (singles, then doubles).
def CHAR_DREAM_HARD            equ $5b
def CHAR_DREAM_INTENSE         equ $5c
def CHAR_DREAM_MAX             equ $5d
def CHAR_DREAM_DOUBLES_HARD    equ $5e
def CHAR_DREAM_DOUBLES_INTENSE equ $5f
def CHAR_DREAM_DOUBLES_MAX     equ $60
; ... and their doubles partners, which DoublesPartnerTable_0a pairs with
; them (AssignStoryMatchCharacters loads the partner from the opponent's id).
def CHAR_DREAM_DOUBLES_HARD_PARTNER    equ $61
def CHAR_DREAM_DOUBLES_INTENSE_PARTNER equ $62
def CHAR_DREAM_DOUBLES_MAX_PARTNER     equ $63
; Records $37-$48 are the drill partners, one per training drill in
; MINIGAME_* order: each drill_def names its own as the opponent.
def CHAR_DRILL_SERVICE_MATCH_1    equ $37
def CHAR_DRILL_SERVICE_MATCH_2    equ $38
def CHAR_DRILL_SERVICE_MATCH_3    equ $39
def CHAR_DRILL_SERVICE_PRACTICE_1 equ $3a
def CHAR_DRILL_SERVICE_PRACTICE_2 equ $3b
def CHAR_DRILL_SERVICE_PRACTICE_3 equ $3c
def CHAR_DRILL_NET_GAME_MATCH_1   equ $3d
def CHAR_DRILL_NET_GAME_MATCH_2   equ $3e
def CHAR_DRILL_NET_GAME_MATCH_3   equ $3f
def CHAR_DRILL_NET_GAME_PRACTICE_1 equ $40
def CHAR_DRILL_NET_GAME_PRACTICE_2 equ $41
def CHAR_DRILL_NET_GAME_PRACTICE_3 equ $42
def CHAR_DRILL_STROKE_MATCH_1     equ $43
def CHAR_DRILL_STROKE_MATCH_2     equ $44
def CHAR_DRILL_STROKE_MATCH_3     equ $45
def CHAR_DRILL_STROKE_PRACTICE_1  equ $46
def CHAR_DRILL_STROKE_PRACTICE_2  equ $47
def CHAR_DRILL_STROKE_PRACTICE_3  equ $48

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
