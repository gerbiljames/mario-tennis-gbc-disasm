INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $32", ROMX[$4000], BANK[$32]

FarPtr_32_00:
	dw FetchDialogueText_32 ; $4000
FarPtr_32_02:
	dw FetchShortText_32 ; $4002
Text_32_4004:
	INCLUDE "data/bank_032/text_4004.asm" ; $4004, 15011 bytes
FetchDialogueText_32:
	push af ; $7aa7
	ld a, $00 ; $7aa8
	call FetchText_32 ; $7aaa
	pop af ; $7aad
	ret ; $7aae
FetchShortText_32:
	push af ; $7aaf
	ld a, $01 ; $7ab0
	call FetchText_32 ; $7ab2
	pop af ; $7ab5
	ret ; $7ab6
FetchText_32:
	push bc ; $7ab7
	push de ; $7ab8
	push hl ; $7ab9
	ld hl, $4004 ; $7aba
	sla e ; $7abd
	rl d ; $7abf
	add hl, de ; $7ac1
	ld e, [hl] ; $7ac2
	inc hl ; $7ac3
	ld d, [hl] ; $7ac4
	ld hl, $417a ; $7ac5
	add hl, de ; $7ac8
	or a, a ; $7ac9
	jr nz, Label_32_7ad3 ; $7aca
	ld de, $c600 ; $7acc
	ld c, $a0 ; $7acf
	jr Label_32_7ad8 ; $7ad1
Label_32_7ad3:
	ld de, $d880 ; $7ad3
	ld c, $10 ; $7ad6
Label_32_7ad8:
	dec c ; $7ad8
	jr z, Label_32_7ae5 ; $7ad9
	ld a, [hl+] ; $7adb
	ld [de], a ; $7adc
	inc de ; $7add
	or a, a ; $7ade
	jr nz, Label_32_7ad8 ; $7adf
	pop hl ; $7ae1
	pop de ; $7ae2
	pop bc ; $7ae3
	ret ; $7ae4
Label_32_7ae5:
	xor a, a ; $7ae5
	ld [de], a ; $7ae6
	ldh a, [$ff9e] ; $7ae7
	or a, a ; $7ae9
	jr z, Label_32_7aee ; $7aea
	sound $2c ; $7aec
Label_32_7aee:
	pop hl ; $7aee
	pop de ; $7aef
	pop bc ; $7af0
	ret ; $7af1
	ds 1294, $ff ; $7af2, fill
