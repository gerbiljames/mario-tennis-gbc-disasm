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

; --- On-court announcement banners (wPointOutcome, $c491) ---
; ShowCourtBanner ($09:$4367) shows an announcement by index: the id selects
; both the message tileset (VramTileset_09 -> TilesetTiles_09 / d_4900.bin) and
; the banner object template. wPointOutcome holds the same id and is passed
; straight to ShowCourtBanner, so these double as point-outcome codes. Ids read
; off the rendered tileset; 0 is the score-digit font, not a message.
def COURTBANNER_FAULT           equ 1
def COURTBANNER_DOUBLE_FAULT    equ 2
def COURTBANNER_LET             equ 3
def COURTBANNER_NET             equ 4
def COURTBANNER_OUT             equ 5
def COURTBANNER_START           equ 6
def COURTBANNER_BREAK_POINT     equ 7
def COURTBANNER_GAME_POINT      equ 8
def COURTBANNER_SET_POINT       equ 9
def COURTBANNER_MATCH_POINT     equ 10
def COURTBANNER_GAME_SET        equ 11
def COURTBANNER_SET_MATCH       equ 12
def COURTBANNER_NICE            equ 14
def COURTBANNER_MINIGAME_START  equ 16
