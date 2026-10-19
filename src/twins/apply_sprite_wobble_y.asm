; Shared by Unused_16_ApplySpriteWobbleY, ApplySpriteWobbleY_17 (banks $16,
; $17).

ASSERT STRCMP("{TWIN_LABEL}", "{ApplySpriteWobbleY_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	ldh a, [hVBlankCounter]
	and $0f
	ld hl, SpriteWobbleYTable_{TWIN}
	add_hl_a
	ld a, [hl]
	ld b, a
	ld a, c
	or a
	jr z, .subtract
	ld a, b
	add e
	ld e, a
	ret
.subtract:
	ld a, e
	sub b
	ld e, a
	ret
