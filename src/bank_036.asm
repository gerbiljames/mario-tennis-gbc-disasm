SECTION "ROM Bank $36", ROMX[$4000], BANK[$36]

	farptr FetchDialogueText_36 ; $4000
	farptr FetchShortText_36 ; $4002
Text_36_4004:
	INCLUDE "data/bank_036/text_4004.asm" ; $4004, 16058 bytes
FetchDialogueText_36:
	push af ; $7ebe
	ld a, $00 ; $7ebf
	call FetchText_36 ; $7ec1
	pop af ; $7ec4
	ret ; $7ec5
FetchShortText_36:
	push af ; $7ec6
	ld a, $01 ; $7ec7
	call FetchText_36 ; $7ec9
	pop af ; $7ecc
	ret ; $7ecd
FetchText_36:
	push bc ; $7ece
	push de ; $7ecf
	push hl ; $7ed0
	ld hl, Text_36_4004 ; $7ed1
	sla e ; $7ed4
	rl d ; $7ed6
	add hl, de ; $7ed8
	ld e, [hl] ; $7ed9
	inc hl ; $7eda
	ld d, [hl] ; $7edb
	ld hl, $4592 ; $7edc
	add hl, de ; $7edf
	or a, a ; $7ee0
	jr nz, .nonZero ; $7ee1
	ld de, wTextBuffer ; $7ee3
	ld c, $a0 ; $7ee6
	jr .loop ; $7ee8
.nonZero:
	ld de, wShortTextBuffer ; $7eea
	ld c, $10 ; $7eed
.loop:
	dec c ; $7eef
	jr z, .countDone ; $7ef0
	ld a, [hl+] ; $7ef2
	ld [de], a ; $7ef3
	inc de ; $7ef4
	or a, a ; $7ef5
	jr nz, .loop ; $7ef6
	pop hl ; $7ef8
	pop de ; $7ef9
	pop bc ; $7efa
	ret ; $7efb
.countDone:
	xor a, a ; $7efc
	ld [de], a ; $7efd
	ldh a, [hDebugStepMode] ; $7efe
	or a, a ; $7f00
	jr z, .restore ; $7f01
	sound $2c ; $7f03
.restore:
	pop hl ; $7f05
	pop de ; $7f06
	pop bc ; $7f07
	ret ; $7f08
	; $7f09, 247 bytes fill to bank end (linker-padded)
