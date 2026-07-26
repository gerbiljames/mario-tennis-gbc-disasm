SECTION "ROM Bank $37", ROMX[$4000], BANK[$37]

	farptr FetchDialogueText_37 ; $4000
	farptr FetchShortText_37 ; $4002
FetchTextTable_37:
	INCBIN "data/bank_037/d_4004.bin" ; $4004, 512 bytes
Text_37_4204:
	INCLUDE "data/bank_037/text_4204.asm" ; $4204, 14618 bytes
FetchDialogueText_37:
	push af ; $7b1e
	ld a, $00 ; $7b1f
	call FetchText_37 ; $7b21
	pop af ; $7b24
	ret ; $7b25
FetchShortText_37:
	push af ; $7b26
	ld a, $01 ; $7b27
	call FetchText_37 ; $7b29
	pop af ; $7b2c
	ret ; $7b2d
FetchText_37:
	push bc ; $7b2e
	push de ; $7b2f
	push hl ; $7b30
	ld hl, FetchTextTable_37 ; $7b31
	sla e ; $7b34
	rl d ; $7b36
	add hl, de ; $7b38
	ld e, [hl] ; $7b39
	inc hl ; $7b3a
	ld d, [hl] ; $7b3b
	ld hl, Text_37_4204 ; $7b3c
	add hl, de ; $7b3f
	or a, a ; $7b40
	jr nz, .nonZero ; $7b41
	ld de, wTextBuffer ; $7b43
	ld c, $a0 ; $7b46
	jr .loop ; $7b48
.nonZero:
	ld de, wShortTextBuffer ; $7b4a
	ld c, $10 ; $7b4d
.loop:
	dec c ; $7b4f
	jr z, .countDone ; $7b50
	ld a, [hl+] ; $7b52
	ld [de], a ; $7b53
	inc de ; $7b54
	or a, a ; $7b55
	jr nz, .loop ; $7b56
	pop hl ; $7b58
	pop de ; $7b59
	pop bc ; $7b5a
	ret ; $7b5b
.countDone:
	xor a, a ; $7b5c
	ld [de], a ; $7b5d
	ldh a, [hDebugStepMode] ; $7b5e
	or a, a ; $7b60
	jr z, .restore ; $7b61
	sound $2c ; $7b63
.restore:
	pop hl ; $7b65
	pop de ; $7b66
	pop bc ; $7b67
	ret ; $7b68
	; $7b69, 1175 bytes fill to bank end (linker-padded)
