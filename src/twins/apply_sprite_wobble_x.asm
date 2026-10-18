; Shared by Unused_16_ApplySpriteWobbleX, Unused_17_ApplySpriteWobbleX (banks
; $16, $17).

ASSERT STRCMP("{TWIN_LABEL}", "{ApplySpriteWobbleX_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	ldh a, [hVBlankCounter]
	and $0f
	ld hl, SpriteWobbleXTable_{TWIN}
	add l
	ld l, a
	jr nc, .readOffset
	inc h
.readOffset:
	ld a, [hl]
	ld b, a
	ld a, c
	or a
	jr z, .subtract
	ld a, b
	add d
	ld d, a
	ret
.subtract:
	ld a, d
	sub b
	ld d, a
	ret
