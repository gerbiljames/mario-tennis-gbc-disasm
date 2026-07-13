SECTION "ROM Bank $31", ROMX[$4000], BANK[$31]

FarPtr_FetchDialogueText_31:
	dw FetchDialogueText_31 ; $4000
FarPtr_FetchShortText_31:
	dw FetchShortText_31 ; $4002
Text_31_4004:
	INCLUDE "data/bank_031/text_4004.asm" ; $4004, 15295 bytes
FetchDialogueText_31:
	push af ; $7bc3
	ld a, $00 ; $7bc4
	call FetchText_31 ; $7bc6
	pop af ; $7bc9
	ret ; $7bca
FetchShortText_31:
	push af ; $7bcb
	ld a, $01 ; $7bcc
	call FetchText_31 ; $7bce
	pop af ; $7bd1
	ret ; $7bd2
FetchText_31:
	push bc ; $7bd3
	push de ; $7bd4
	push hl ; $7bd5
	ld hl, $4004 ; $7bd6
	sla e ; $7bd9
	rl d ; $7bdb
	add hl, de ; $7bdd
	ld e, [hl] ; $7bde
	inc hl ; $7bdf
	ld d, [hl] ; $7be0
	ld hl, $42ba ; $7be1
	add hl, de ; $7be4
	or a, a ; $7be5
	jr nz, Label_31_7bef ; $7be6
	ld de, wTextBuffer ; $7be8
	ld c, $a0 ; $7beb
	jr Label_31_7bf4 ; $7bed
Label_31_7bef:
	ld de, wShortTextBuffer ; $7bef
	ld c, $10 ; $7bf2
Label_31_7bf4:
	dec c ; $7bf4
	jr z, Label_31_7c01 ; $7bf5
	ld a, [hl+] ; $7bf7
	ld [de], a ; $7bf8
	inc de ; $7bf9
	or a, a ; $7bfa
	jr nz, Label_31_7bf4 ; $7bfb
	pop hl ; $7bfd
	pop de ; $7bfe
	pop bc ; $7bff
	ret ; $7c00
Label_31_7c01:
	xor a, a ; $7c01
	ld [de], a ; $7c02
	ldh a, [$ff9e] ; $7c03
	or a, a ; $7c05
	jr z, Label_31_7c0a ; $7c06
	sound $2c ; $7c08
Label_31_7c0a:
	pop hl ; $7c0a
	pop de ; $7c0b
	pop bc ; $7c0c
	ret ; $7c0d
	ds 1010, $ff ; $7c0e, fill
