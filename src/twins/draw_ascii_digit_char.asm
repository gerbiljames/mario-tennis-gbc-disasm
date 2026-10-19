; Shared by Unused_3b_DrawAsciiDigitChar, Unused_1b_DrawAsciiDigitChar,
; Unused_17_DrawAsciiDigitChar, Unused_16_DrawAsciiDigitChar,
; Unused_3e_DrawAsciiDigitChar (banks $16, $17, $1b, $3b, $3e).

ASSERT STRCMP("{TWIN_LABEL}", "{DrawAsciiDigitChar_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push hl
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH
	sub $30
	jr c, .carry
	add $30
	ld b, a
	wram_bank WRAM_SCREEN
	ld a, b
	ld [de], a
	inc de
	pop hl
	ret
.carry:
	inc de
	pop hl
	ret
