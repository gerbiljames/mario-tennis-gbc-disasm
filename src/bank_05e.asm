SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

	farptr FetchDialogueText_5e ; $4000
	farptr FetchShortText_5e ; $4002
Text_5e_4004:
	INCLUDE "data/bank_05e/text_4004.asm" ; $4004, 11915 bytes
FetchDialogueText_5e:
	push af ; $6e8f
	ld a, $00 ; $6e90
	call FetchText_5e ; $6e92
	pop af ; $6e95
	ret ; $6e96
FetchShortText_5e:
	push af ; $6e97
	ld a, $01 ; $6e98
	call FetchText_5e ; $6e9a
	pop af ; $6e9d
	ret ; $6e9e
FetchText_5e:
	push bc ; $6e9f
	push de ; $6ea0
	push hl ; $6ea1
	ld hl, Text_5e_4004 ; $6ea2
	sla e ; $6ea5
	rl d ; $6ea7
	add hl, de ; $6ea9
	ld e, [hl] ; $6eaa
	inc hl ; $6eab
	ld d, [hl] ; $6eac
	ld hl, $428a ; $6ead
	add hl, de ; $6eb0
	or a, a ; $6eb1
	jr nz, .nonZero ; $6eb2
	ld de, wTextBuffer ; $6eb4
	ld c, $a0 ; $6eb7
	jr .loop ; $6eb9
.nonZero:
	ld de, wShortTextBuffer ; $6ebb
	ld c, $10 ; $6ebe
.loop:
	dec c ; $6ec0
	jr z, .countDone ; $6ec1
	ld a, [hl+] ; $6ec3
	ld [de], a ; $6ec4
	inc de ; $6ec5
	or a, a ; $6ec6
	jr nz, .loop ; $6ec7
	pop hl ; $6ec9
	pop de ; $6eca
	pop bc ; $6ecb
	ret ; $6ecc
.countDone:
	xor a, a ; $6ecd
	ld [de], a ; $6ece
	ldh a, [hDebugStepMode] ; $6ecf
	or a, a ; $6ed1
	jr z, .restore ; $6ed2
	sound $2c ; $6ed4
.restore:
	pop hl ; $6ed6
	pop de ; $6ed7
	pop bc ; $6ed8
	ret ; $6ed9
	; $6eda, 4390 bytes fill to bank end (linker-padded)
