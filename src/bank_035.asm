SECTION "ROM Bank $35", ROMX[$4000], BANK[$35]

FarPtr_FetchDialogueText_35:
	dw FetchDialogueText_35 ; $4000
FarPtr_FetchShortText_35:
	dw FetchShortText_35 ; $4002
Text_35_4004:
	INCLUDE "data/bank_035/text_4004.asm" ; $4004, 15141 bytes
FetchDialogueText_35:
	push af ; $7b29
	ld a, $00 ; $7b2a
	call FetchText_35 ; $7b2c
	pop af ; $7b2f
	ret ; $7b30
FetchShortText_35:
	push af ; $7b31
	ld a, $01 ; $7b32
	call FetchText_35 ; $7b34
	pop af ; $7b37
	ret ; $7b38
FetchText_35:
	push bc ; $7b39
	push de ; $7b3a
	push hl ; $7b3b
	ld hl, Text_35_4004 ; $7b3c
	sla e ; $7b3f
	rl d ; $7b41
	add hl, de ; $7b43
	ld e, [hl] ; $7b44
	inc hl ; $7b45
	ld d, [hl] ; $7b46
	ld hl, $4220 ; $7b47
	add hl, de ; $7b4a
	or a, a ; $7b4b
	jr nz, Label_35_7b55 ; $7b4c
	ld de, wTextBuffer ; $7b4e
	ld c, $a0 ; $7b51
	jr Label_35_7b5a ; $7b53
Label_35_7b55:
	ld de, wShortTextBuffer ; $7b55
	ld c, $10 ; $7b58
Label_35_7b5a:
	dec c ; $7b5a
	jr z, Label_35_7b67 ; $7b5b
	ld a, [hl+] ; $7b5d
	ld [de], a ; $7b5e
	inc de ; $7b5f
	or a, a ; $7b60
	jr nz, Label_35_7b5a ; $7b61
	pop hl ; $7b63
	pop de ; $7b64
	pop bc ; $7b65
	ret ; $7b66
Label_35_7b67:
	xor a, a ; $7b67
	ld [de], a ; $7b68
	ldh a, [hDebugStepMode] ; $7b69
	or a, a ; $7b6b
	jr z, Label_35_7b70 ; $7b6c
	sound $2c ; $7b6e
Label_35_7b70:
	pop hl ; $7b70
	pop de ; $7b71
	pop bc ; $7b72
	ret ; $7b73
	ds 1164, $ff ; $7b74, fill
