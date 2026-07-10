INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $34", ROMX[$4000], BANK[$34]

FarPtr_34_00:
	dw Func_34_7b43 ; $4000
Text_34_4002:
	INCLUDE "data/bank_034/text_4002.asm" ; $4002, 15169 bytes
Func_34_7b43:
	push af ; $7b43
	ld a, $00 ; $7b44
	call Func_34_7b53 ; $7b46
	pop af ; $7b49
	ret ; $7b4a
	INCBIN "data/bank_034/d_7b4b.bin" ; $7b4b, 8 bytes
Func_34_7b53:
	push bc ; $7b53
	push de ; $7b54
	push hl ; $7b55
	ld hl, $4004 ; $7b56
	sla e ; $7b59
	rl d ; $7b5b
	add hl, de ; $7b5d
	ld e, [hl] ; $7b5e
	inc hl ; $7b5f
	ld d, [hl] ; $7b60
	ld hl, $4242 ; $7b61
	add hl, de ; $7b64
	or a, a ; $7b65
	jr nz, Label_34_7b6f ; $7b66
	ld de, $c600 ; $7b68
	ld c, $a0 ; $7b6b
	jr Label_34_7b74 ; $7b6d
Label_34_7b6f:
	ld de, $d880 ; $7b6f
	ld c, $10 ; $7b72
Label_34_7b74:
	dec c ; $7b74
	jr z, Label_34_7b81 ; $7b75
	ld a, [hl+] ; $7b77
	ld [de], a ; $7b78
	inc de ; $7b79
	or a, a ; $7b7a
	jr nz, Label_34_7b74 ; $7b7b
	pop hl ; $7b7d
	pop de ; $7b7e
	pop bc ; $7b7f
	ret ; $7b80
Label_34_7b81:
	xor a, a ; $7b81
	ld [de], a ; $7b82
	ldh a, [$ff9e] ; $7b83
	or a, a ; $7b85
	jr z, Label_34_7b8a ; $7b86
	sound $2c ; $7b88
Label_34_7b8a:
	pop hl ; $7b8a
	pop de ; $7b8b
	pop bc ; $7b8c
	ret ; $7b8d
	ds 1138, $ff ; $7b8e, fill
