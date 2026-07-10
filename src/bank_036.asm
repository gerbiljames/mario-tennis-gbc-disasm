INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $36", ROMX[$4000], BANK[$36]

FarPtr_36_00:
	dw Func_36_7ebe ; $4000
	INCBIN "data/bank_036/d_4002.bin" ; $4002, 16060 bytes
Func_36_7ebe:
	push af ; $7ebe
	ld a, $00 ; $7ebf
	call Func_36_7ece ; $7ec1
	pop af ; $7ec4
	ret ; $7ec5
	INCBIN "data/bank_036/d_7ec6.bin" ; $7ec6, 8 bytes
Func_36_7ece:
	push bc ; $7ece
	push de ; $7ecf
	push hl ; $7ed0
	ld hl, $4004 ; $7ed1
	sla e ; $7ed4
	rl d ; $7ed6
	add hl, de ; $7ed8
	ld e, [hl] ; $7ed9
	inc hl ; $7eda
	ld d, [hl] ; $7edb
	ld hl, $4592 ; $7edc
	add hl, de ; $7edf
	or a, a ; $7ee0
	jr nz, Label_36_7eea ; $7ee1
	ld de, $c600 ; $7ee3
	ld c, $a0 ; $7ee6
	jr Label_36_7eef ; $7ee8
Label_36_7eea:
	ld de, $d880 ; $7eea
	ld c, $10 ; $7eed
Label_36_7eef:
	dec c ; $7eef
	jr z, Label_36_7efc ; $7ef0
	ld a, [hl+] ; $7ef2
	ld [de], a ; $7ef3
	inc de ; $7ef4
	or a, a ; $7ef5
	jr nz, Label_36_7eef ; $7ef6
	pop hl ; $7ef8
	pop de ; $7ef9
	pop bc ; $7efa
	ret ; $7efb
Label_36_7efc:
	xor a, a ; $7efc
	ld [de], a ; $7efd
	ldh a, [$ff9e] ; $7efe
	or a, a ; $7f00
	jr z, Label_36_7f05 ; $7f01
	sound $2c ; $7f03
Label_36_7f05:
	pop hl ; $7f05
	pop de ; $7f06
	pop bc ; $7f07
	ret ; $7f08
	INCBIN "data/bank_036/d_7f09.bin" ; $7f09, 247 bytes
