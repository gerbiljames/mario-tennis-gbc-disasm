INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

FarPtr_5e_00:
	dw Func_5e_6e8f ; $4000
Text_5e_4002:
	INCBIN "data/bank_05e/text_4002.bin" ; $4002, 11917 bytes
Func_5e_6e8f:
	push af ; $6e8f
	ld a, $00 ; $6e90
	call Func_5e_6e9f ; $6e92
	pop af ; $6e95
	ret ; $6e96
	INCBIN "data/bank_05e/d_6e97.bin" ; $6e97, 8 bytes
Func_5e_6e9f:
	push bc ; $6e9f
	push de ; $6ea0
	push hl ; $6ea1
	ld hl, $4004 ; $6ea2
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
	ld de, $c600 ; $6eb4
	ld c, $a0 ; $6eb7
	jr Label_5e_6ec0 ; $6eb9
Label_5e_6ebb:
	ld de, $d880 ; $6ebb
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
	ldh a, [$ff9e] ; $6ecf
	or a, a ; $6ed1
	jr z, Label_5e_6ed6 ; $6ed2
	sound $2c ; $6ed4
Label_5e_6ed6:
	pop hl ; $6ed6
	pop de ; $6ed7
	pop bc ; $6ed8
	ret ; $6ed9
	ds 4390, $ff ; $6eda, fill
