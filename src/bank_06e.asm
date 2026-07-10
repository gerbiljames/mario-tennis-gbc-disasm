INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6e", ROMX[$4000], BANK[$6e]

FarPtr_6e_00:
	dw Func_6e_7b08 ; $4000
	INCBIN "data/bank_06e/d_4002.bin" ; $4002, 15110 bytes
Func_6e_7b08:
	push af ; $7b08
	ld a, $00 ; $7b09
	call Func_6e_7b18 ; $7b0b
	pop af ; $7b0e
	ret ; $7b0f
	INCBIN "data/bank_06e/d_7b10.bin" ; $7b10, 8 bytes
Func_6e_7b18:
	push bc ; $7b18
	push de ; $7b19
	push hl ; $7b1a
	ld hl, $4004 ; $7b1b
	sla e ; $7b1e
	rl d ; $7b20
	add hl, de ; $7b22
	ld e, [hl] ; $7b23
	inc hl ; $7b24
	ld d, [hl] ; $7b25
	ld hl, $41e8 ; $7b26
	add hl, de ; $7b29
	or a, a ; $7b2a
	jr nz, Label_6e_7b34 ; $7b2b
	ld de, $c600 ; $7b2d
	ld c, $a0 ; $7b30
	jr Label_6e_7b39 ; $7b32
Label_6e_7b34:
	ld de, $d880 ; $7b34
	ld c, $10 ; $7b37
Label_6e_7b39:
	dec c ; $7b39
	jr z, Label_6e_7b46 ; $7b3a
	ld a, [hl+] ; $7b3c
	ld [de], a ; $7b3d
	inc de ; $7b3e
	or a, a ; $7b3f
	jr nz, Label_6e_7b39 ; $7b40
	pop hl ; $7b42
	pop de ; $7b43
	pop bc ; $7b44
	ret ; $7b45
Label_6e_7b46:
	xor a, a ; $7b46
	ld [de], a ; $7b47
	ldh a, [$ff9e] ; $7b48
	or a, a ; $7b4a
	jr z, Label_6e_7b4f ; $7b4b
	rst Rst08 ; $7b4d
	inc l ; $7b4e
Label_6e_7b4f:
	pop hl ; $7b4f
	pop de ; $7b50
	pop bc ; $7b51
	ret ; $7b52
	INCBIN "data/bank_06e/d_7b53.bin" ; $7b53, 1197 bytes
