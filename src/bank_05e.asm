SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

FarPtr_FetchDialogueText_5e:
	dw FetchDialogueText_5e ; $4000
FarPtr_FetchShortText_5e:
	dw FetchShortText_5e ; $4002
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
	jr nz, Label_5e_6ebb ; $6eb2
	ld de, wTextBuffer ; $6eb4
	ld c, $a0 ; $6eb7
	jr Label_5e_6ec0 ; $6eb9
Label_5e_6ebb:
	ld de, wShortTextBuffer ; $6ebb
	ld c, $10 ; $6ebe
Label_5e_6ec0:
	dec c ; $6ec0
	jr z, Label_5e_6ecd ; $6ec1
	ld a, [hl+] ; $6ec3
	ld [de], a ; $6ec4
	inc de ; $6ec5
	or a, a ; $6ec6
	jr nz, Label_5e_6ec0 ; $6ec7
	pop hl ; $6ec9
	pop de ; $6eca
	pop bc ; $6ecb
	ret ; $6ecc
Label_5e_6ecd:
	xor a, a ; $6ecd
	ld [de], a ; $6ece
	ldh a, [hDebugStepMode] ; $6ecf
	or a, a ; $6ed1
	jr z, Label_5e_6ed6 ; $6ed2
	sound $2c ; $6ed4
Label_5e_6ed6:
	pop hl ; $6ed6
	pop de ; $6ed7
	pop bc ; $6ed8
	ret ; $6ed9
	ds 4390, $ff ; $6eda, fill
