SECTION "ROM Bank $34", ROMX[$4000], BANK[$34]

	farptr FetchDialogueText_34 ; $4000
	farptr FetchShortText_34 ; $4002
Text_34_4004:
	INCLUDE "data/bank_034/text_4004.asm" ; $4004, 15167 bytes
FetchDialogueText_34:
	push af ; $7b43
	ld a, $00 ; $7b44
	call FetchText_34 ; $7b46
	pop af ; $7b49
	ret ; $7b4a
FetchShortText_34:
	push af ; $7b4b
	ld a, $01 ; $7b4c
	call FetchText_34 ; $7b4e
	pop af ; $7b51
	ret ; $7b52
FetchText_34:
	push bc ; $7b53
	push de ; $7b54
	push hl ; $7b55
	ld hl, Text_34_4004 ; $7b56
	sla e ; $7b59
	rl d ; $7b5b
	add hl, de ; $7b5d
	ld e, [hl] ; $7b5e
	inc hl ; $7b5f
	ld d, [hl] ; $7b60
	ld hl, $4242 ; $7b61
	add hl, de ; $7b64
	or a, a ; $7b65
	jr nz, .nonZero ; $7b66
	ld de, wTextBuffer ; $7b68
	ld c, $a0 ; $7b6b
	jr .loop ; $7b6d
.nonZero:
	ld de, wShortTextBuffer ; $7b6f
	ld c, $10 ; $7b72
.loop:
	dec c ; $7b74
	jr z, .countDone ; $7b75
	ld a, [hl+] ; $7b77
	ld [de], a ; $7b78
	inc de ; $7b79
	or a, a ; $7b7a
	jr nz, .loop ; $7b7b
	pop hl ; $7b7d
	pop de ; $7b7e
	pop bc ; $7b7f
	ret ; $7b80
.countDone:
	xor a, a ; $7b81
	ld [de], a ; $7b82
	ldh a, [hDebugStepMode] ; $7b83
	or a, a ; $7b85
	jr z, .restore ; $7b86
	sound $2c ; $7b88
.restore:
	pop hl ; $7b8a
	pop de ; $7b8b
	pop bc ; $7b8c
	ret ; $7b8d
	; $7b8e, 1138 bytes fill to bank end (linker-padded)
