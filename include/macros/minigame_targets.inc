; Minigame target scripts (MinigameTargetFormation*Script*), stepped by
; RunMinigameTargetScript through MinigameTargetOpHandlers_0a until a command
; yields. Positions (wMinigameTargetWork +6/+8, ApplyCameraProjection's world
; coordinates) and distances are written with a point (-7.0): the words store
; `x >> 8` of the Q16.16 literal.

MACRO tgt_end          ; $00 stop: the script stays on this command
	db $00
ENDM

MACRO tgt_wait         ; $01 yield for \1 frames
	db $01, \1
ENDM

MACRO tgt_jump         ; $02 continue at \1 (stored relative to the operand)
	db $02
	dw (\1) - @
ENDM

MACRO tgt_call         ; $03 call native routine \1, then continue
	db $03
	dw \1
ENDM

MACRO tgt_wait_arrival ; $04 yield until the move started by tgt_move ends
	db $04
ENDM

MACRO tgt_set_pos      ; $05 place the target at (\1, \2)
	db $05
	dw (\1) >> 8, (\2) >> 8
ENDM

MACRO tgt_move         ; $06 head \2 units from the current position at angle \1 ($40 a quarter turn)
	db $06, \1
	dw (\2) >> 8
ENDM

MACRO tgt_set_type     ; $07 set the target type (sprite, deflection, score) to \1
	db $07, \1
ENDM

MACRO tgt_add_type     ; $08 add \1 to the target type, modulo 4
	db $08, \1
ENDM
