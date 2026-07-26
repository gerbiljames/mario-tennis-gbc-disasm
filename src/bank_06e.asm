SECTION "ROM Bank $6e", ROMX[$4000], BANK[$6e]

	farptr FetchDialogueText_6e ; $4000
	farptr FetchShortText_6e ; $4002
FetchTextTable_6e:
	INCBIN "data/bank_06e/d_4004.bin" ; $4004, 484 bytes
Text_6e_41e8:
	INCLUDE "data/bank_06e/text_41e8.asm" ; $41e8, 14624 bytes
FetchDialogueText_6e:
	push af ; $7b08
	ld a, $00 ; $7b09
	call FetchText_6e ; $7b0b
	pop af ; $7b0e
	ret ; $7b0f
FetchShortText_6e:
	push af ; $7b10
	ld a, $01 ; $7b11
	call FetchText_6e ; $7b13
	pop af ; $7b16
	ret ; $7b17
FetchText_6e:
	push bc ; $7b18
	push de ; $7b19
	push hl ; $7b1a
	ld hl, FetchTextTable_6e ; $7b1b
	sla e ; $7b1e
	rl d ; $7b20
	add hl, de ; $7b22
	ld e, [hl] ; $7b23
	inc hl ; $7b24
	ld d, [hl] ; $7b25
	ld hl, Text_6e_41e8 ; $7b26
	add hl, de ; $7b29
	or a, a ; $7b2a
	jr nz, .nonZero ; $7b2b
	ld de, wTextBuffer ; $7b2d
	ld c, $a0 ; $7b30
	jr .loop ; $7b32
.nonZero:
	ld de, wShortTextBuffer ; $7b34
	ld c, $10 ; $7b37
.loop:
	dec c ; $7b39
	jr z, .countDone ; $7b3a
	ld a, [hl+] ; $7b3c
	ld [de], a ; $7b3d
	inc de ; $7b3e
	or a, a ; $7b3f
	jr nz, .loop ; $7b40
	pop hl ; $7b42
	pop de ; $7b43
	pop bc ; $7b44
	ret ; $7b45
.countDone:
	xor a, a ; $7b46
	ld [de], a ; $7b47
	ldh a, [hDebugStepMode] ; $7b48
	or a, a ; $7b4a
	jr z, .restore ; $7b4b
	sound $2c ; $7b4d
.restore:
	pop hl ; $7b4f
	pop de ; $7b50
	pop bc ; $7b51
	ret ; $7b52
	; $7b53, 1197 bytes fill to bank end (linker-padded)
