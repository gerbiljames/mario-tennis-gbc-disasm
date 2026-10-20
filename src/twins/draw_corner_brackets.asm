; Shared by Unused_16_DrawCornerBrackets, Unused_1b_DrawCornerBrackets,
; Unused_38_DrawCornerBrackets, Unused_3b_DrawCornerBrackets,
; Unused_3e_DrawCornerBrackets (banks $16, $1b, $38, $3b, $3e).

ASSERT STRCMP("{TWIN_LABEL}", "{DrawCornerBrackets_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push de
	push bc
	sprite_tile_attr $00, OAM_BANK1 | 1
	call QueueSprite
	pop bc
	pop de
	push de
	push bc
	ld a, b
	add d
	ld d, a
	push de
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | 1
	call QueueSprite
	pop de
	pop bc
	pop de
	push de
	push bc
	ld a, c
	add e
	ld e, a
	ld a, b
	add d
	ld d, a
	push de
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP | 1
	call QueueSprite
	pop de
	pop bc
	pop de
	ld a, e
	add c
	ld e, a
	push de
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP | 1
	call QueueSprite
	pop de
	ret
