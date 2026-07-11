INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1f", ROMX[$4000], BANK[$1f]

FarPtr_1f_00:
	dw FetchDialogueText_1f ; $4000
FarPtr_1f_02:
	dw FetchShortText_1f ; $4002
Text_1f_4004:
	INCLUDE "data/bank_01f/text_4004.asm" ; $4004, 14983 bytes
FetchDialogueText_1f:
	push af ; $7a8b
	ld a, $00 ; $7a8c
	call FetchText_1f ; $7a8e
	pop af ; $7a91
	ret ; $7a92
FetchShortText_1f:
	push af ; $7a93
	ld a, $01 ; $7a94
	call FetchText_1f ; $7a96
	pop af ; $7a99
	ret ; $7a9a
FetchText_1f:
	push bc ; $7a9b
	push de ; $7a9c
	push hl ; $7a9d
	ld hl, $4004 ; $7a9e
	sla e ; $7aa1
	rl d ; $7aa3
	add hl, de ; $7aa5
	ld e, [hl] ; $7aa6
	inc hl ; $7aa7
	ld d, [hl] ; $7aa8
	ld hl, $417e ; $7aa9
	add hl, de ; $7aac
	or a, a ; $7aad
	jr nz, Label_1f_7ab7 ; $7aae
	ld de, wTextBuffer ; $7ab0
	ld c, $a0 ; $7ab3
	jr Label_1f_7abc ; $7ab5
Label_1f_7ab7:
	ld de, wShortTextBuffer ; $7ab7
	ld c, $10 ; $7aba
Label_1f_7abc:
	dec c ; $7abc
	jr z, Label_1f_7ac9 ; $7abd
	ld a, [hl+] ; $7abf
	ld [de], a ; $7ac0
	inc de ; $7ac1
	or a, a ; $7ac2
	jr nz, Label_1f_7abc ; $7ac3
	pop hl ; $7ac5
	pop de ; $7ac6
	pop bc ; $7ac7
	ret ; $7ac8
Label_1f_7ac9:
	xor a, a ; $7ac9
	ld [de], a ; $7aca
	ldh a, [$ff9e] ; $7acb
	or a, a ; $7acd
	jr z, Label_1f_7ad2 ; $7ace
	sound $2c ; $7ad0
Label_1f_7ad2:
	pop hl ; $7ad2
	pop de ; $7ad3
	pop bc ; $7ad4
	ret ; $7ad5
	ds 1322, $ff ; $7ad6, fill
