; Game constants. Hand-maintained (not generated). Preincluded for every bank
; via the Makefile PRELUDE, alongside hardware.inc / macros.inc.

; --- Joypad buttons (standard GB layout) ---
; The per-character input byte ($df1f, built by ReadCharPadInput) and the raw
; joypad shadow use the standard layout: buttons in the low nibble, d-pad in the
; high nibble. PADF_* are the bit masks; PADB_* the matching bit indices (for
; bit/set/res).
def PADF_A       equ $01
def PADF_B       equ $02
def PADF_SELECT  equ $04
def PADF_START   equ $08
def PADF_RIGHT   equ $10
def PADF_LEFT    equ $20
def PADF_UP      equ $40
def PADF_DOWN    equ $80
def PADB_A       equ 0
def PADB_B       equ 1
def PADB_SELECT  equ 2
def PADB_START   equ 3
def PADB_RIGHT   equ 4
def PADB_LEFT    equ 5
def PADB_UP      equ 6
def PADB_DOWN    equ 7

; --- Overworld actor facing (map_actor `facing`, map_entry `sprite`) ---
; The facing byte stored in an actor's state ($daXX). Its top 2 bits are a
; direction index (0-3); CheckTriggerFacingMask ($0a:$53bd) shifts them out and
; looks them up in a table -> PADF bit to test against a FACEMASK_* below. The
; byte doubles as the movement angle fed to as_move (0/64/128/192 on a 256-unit
; circle). These are the NPC/overworld facings, deliberately distinct from the
; PADF_* joypad masks even where the value coincides.
def FACE_RIGHT   equ $00
def FACE_DOWN    equ $40
def FACE_LEFT    equ $80
def FACE_UP      equ $c0

; --- Cutscene actor slots ---
; The actor an overworld/cutscene `script_*` command targets (index into the
; actor state array at $d000, stride $40). Slots are filled in a fixed order
; when a story location loads (InitLocationActors, $0a:$5485): the player and
; two paired system actors first, then the location's `map_actor` list in order
; (SpawnActor always takes the first free slot, so list entry i -> slot 3+i).
; Only the three reserved system slots have a stable name; the rest are
; scene-local (see the per-scene actor ids). ACTOR_PLAYER_SHADOW and
; ACTOR_PARTNER both run the $04:$41d1 follower script.
def ACTOR_PLAYER        equ $00 ; the main character sprite
def ACTOR_PLAYER_SHADOW equ $01 ; player's paired follower actor ($41d1)
def ACTOR_PARTNER       equ $02 ; companion/doubles partner (Func_04_4f10)

; --- Story-script facing mask (map_script `facing_mask`) ---
; The direction an actor must face for FindStoryScriptEntry ($0a:$53e4) to run
; the record. PADF-layout bits (matched against the facing->PADF table lookup);
; FACEMASK_ANY ($ff) matches every facing.
def FACEMASK_ANY   equ $ff
def FACEMASK_RIGHT equ $10
def FACEMASK_LEFT  equ $20
def FACEMASK_UP    equ $40
def FACEMASK_DOWN  equ $80

; --- Shot types (wCurrentShotType, $c4a0) ---
; Selected from the A/B button sequence by SelectRallyShotType /
; SelectServeShotType ($08:$707e/$706b), which index the button (df16) x
; second-button (df17) tables. Base strokes: A = topspin, B = slice,
; A->B = lob, B->A = drop, A+B = smash; doubling a button gives its "power"
; variant. When the ball is in smash range (df50 bit 4) the ground strokes are
; swapped for their "reach" variants ($06/$07/$08, dispatched to bank $2c's
; ProjectShotPlacement0-2). Serves mirror the ground strokes by first button:
; A -> topspin serve, B -> slice serve, A+B -> flat serve (SelectServeShotType).
def SHOTTYPE_TOPSPIN            equ $00 ; A
def SHOTTYPE_POWER_TOPSPIN      equ $01 ; A -> A
def SHOTTYPE_SLICE              equ $02 ; B
def SHOTTYPE_POWER_SLICE        equ $03 ; B -> B
def SHOTTYPE_NEUTRAL            equ $04 ; no valid button combo (table fallback)
def SHOTTYPE_REACH              equ $05 ; reach attempted, ball not in smash range
def SHOTTYPE_REACH_POWER_TOPSPIN equ $06 ; A -> A, ball smashable
def SHOTTYPE_REACH_POWER_SLICE equ $07 ; B -> B, ball smashable
def SHOTTYPE_REACH_BASIC       equ $08 ; A / B, ball smashable
def SHOTTYPE_SMASH             equ $09 ; A + B
def SHOTTYPE_LOB               equ $0a ; A -> B
def SHOTTYPE_DROP              equ $0b ; B -> A
def SHOTTYPE_SERVE_TOPSPIN     equ $0c ; serve, A
def SHOTTYPE_SERVE_SLICE       equ $0d ; serve, B
def SHOTTYPE_SERVE_FLAT        equ $0e ; serve, A+B

; --- Point outcome (wPointOutcome, $c4d8) — MATCH context ---
; ResolvePointOutcome ($08:$4df4) dispatches `rst Rst00` on wPointOutcome:
; 1-5 -> ShowCourtBanner(wPointOutcome) (banner id == the value), 6 -> the
; winner banner ShowCourtBanner(wPointWinnerShotType+$17), 7/8 -> text popups.
; So the low banner tileset ids equal these codes.
def POINTOUTCOME_FAULT          equ 1
def POINTOUTCOME_DOUBLE_FAULT   equ 2
def POINTOUTCOME_LET            equ 3
def POINTOUTCOME_NET            equ 4
def POINTOUTCOME_OUT            equ 5
def POINTOUTCOME_WINNER         equ 6

; --- Winning-shot type (wPointWinnerShotType, $c491) ---
; Set by the Record*Stat functions ($08:$5c5f+); the winner court banner is
; ShowCourtBanner(value + $17) -> banner ids 24-28. Confirmed in-game.
def POINTWINNER_SERVICE_ACE     equ 1
def POINTWINNER_RETURN_ACE      equ 2
def POINTWINNER_SMASH_ACE       equ 3
def POINTWINNER_LOB             equ 4
def POINTWINNER_DROP_SHOT       equ 5

; --- Match pause-menu item ids (MatchMenuDefs $06:$466f) ---
; GetMatchMenuItemId returns one of these; they index MatchMenuItemGfxPointers
; (the selected item's word art), MatchMenuItemRectPointers (its 3x2 label in
; the list) and the item caption at text id $013f + id (bank $30, 319+id).
; The names follow those captions; the comment gives the word art when it
; differs, and several ids deliberately share one graphic.
def MATCHMENUITEM_RULES              equ $00 ; "RULES"
def MATCHMENUITEM_CONTROLS           equ $01 ; "CONTROLS"
def MATCHMENUITEM_OPTIONS            equ $02 ; "OPTIONS"
def MATCHMENUITEM_SAVE               equ $03 ; "SAVE" (opens the save/quit menu)
def MATCHMENUITEM_CAMERA_MODE        equ $04 ; "CAMERA MODE"
def MATCHMENUITEM_MUSIC              equ $05 ; "MUSIC"
def MATCHMENUITEM_CAMERA_NORMAL      equ $06 ; "NORMAL"
def MATCHMENUITEM_CAMERA_PLAYER      equ $07 ; "PLAYER"
def MATCHMENUITEM_MUSIC_ON           equ $08 ; "ON"
def MATCHMENUITEM_MUSIC_OFF          equ $09 ; "OFF"
def MATCHMENUITEM_CANCEL             equ $0a ; "CANCEL"
def MATCHMENUITEM_SAVE_GAME          equ $0b ; "SAVE" (narrow; performs the save)
def MATCHMENUITEM_TO_MAIN_MENU       equ $0c ; "TO MAIN MENU"
def MATCHMENUITEM_TO_LEVEL_SELECT    equ $0d ; "TO LEVEL SELECT"
def MATCHMENUITEM_RETRY_MINIGAME     equ $0e ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_PRACTICE     equ $0f ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_MACHINE      equ $10 ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_PRACTICE_ALT equ $11 ; "TRY AGAIN"
def MATCHMENUITEM_RETRY_GAME         equ $12 ; "TRY AGAIN"
def MATCHMENUITEM_QUIT_GAME          equ $13 ; "QUIT MATCH"
def MATCHMENUITEM_QUIT_MATCH         equ $14 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_PRACTICE      equ $15 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_MACHINE       equ $16 ; "QUIT MINI-GAME"
def MATCHMENUITEM_QUIT_PRACTICE_ALT  equ $17 ; "QUIT MINI-GAME"

; --- Story pause-menu item ids (StoryMenuDefs $06:$6ce0) ---
; Same shape for the story-mode pause menu: StoryMenuItemGfxPointers,
; StoryMenuItemRectPointers, caption at text id $0162 + id (bank $30, 354+id).
def STORYMENUITEM_STATUS        equ $00 ; "STATUS"
def STORYMENUITEM_CLEAR_STATUS  equ $01 ; "CLEAR STATUS" (game progress)
def STORYMENUITEM_OPTIONS       equ $02 ; "OPTIONS"
def STORYMENUITEM_SAVE          equ $03 ; "SAVE" (opens the save/quit menu)
def STORYMENUITEM_MESSAGES      equ $04 ; "MESSAGES"
def STORYMENUITEM_MUSIC         equ $05 ; "MUSIC"
def STORYMENUITEM_MSG_SLOW      equ $06 ; "SLOW"
def STORYMENUITEM_MSG_NORMAL    equ $07 ; "NORMAL"
def STORYMENUITEM_MSG_FAST      equ $08 ; "FAST"
def STORYMENUITEM_MUSIC_ON      equ $09 ; "ON"
def STORYMENUITEM_MUSIC_OFF     equ $0a ; "OFF"
def STORYMENUITEM_SAVE_GAME     equ $0b ; "SAVE" (narrow; performs the save)
def STORYMENUITEM_TO_MAIN_MENU  equ $0c ; "TO MAIN MENU"
def STORYMENUITEM_CANCEL        equ $0d ; "CANCEL" (continue game)
def STORYMENUITEM_CHAR_DATA     equ $0e ; "CHAR. DATA"
def STORYMENUITEM_ITEMS         equ $0f ; "ITEMS"
