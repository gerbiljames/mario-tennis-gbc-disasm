INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $30", ROMX[$4000], BANK[$30]

FarPtr_30_00:
	dw Func_30_7d82 ; $4000
FarPtr_30_02:
	dw Func_30_7d8a ; $4002
	INCBIN "data/bank_030/d_4004.bin" ; $4004, 15742 bytes
Func_30_7d82:
	push af ; $7d82
	ld a, $00 ; $7d83
	call Func_30_7d92 ; $7d85
	pop af ; $7d88
	ret ; $7d89
Func_30_7d8a:
	push af ; $7d8a
	ld a, $01 ; $7d8b
	call Func_30_7d92 ; $7d8d
	pop af ; $7d90
	ret ; $7d91
Func_30_7d92:
	push bc ; $7d92
	push de ; $7d93
	push hl ; $7d94
	ld hl, $4004 ; $7d95
	sla e ; $7d98
	rl d ; $7d9a
	add hl, de ; $7d9c
	ld e, [hl] ; $7d9d
	inc hl ; $7d9e
	ld d, [hl] ; $7d9f
	ld hl, $4464 ; $7da0
	add hl, de ; $7da3
	or a, a ; $7da4
	jr nz, Label_30_7dae ; $7da5
	ld de, $c600 ; $7da7
	ld c, $a0 ; $7daa
	jr Label_30_7db3 ; $7dac
Label_30_7dae:
	ld de, $d880 ; $7dae
	ld c, $10 ; $7db1
Label_30_7db3:
	dec c ; $7db3
	jr z, Label_30_7dc0 ; $7db4
	ld a, [hl+] ; $7db6
	ld [de], a ; $7db7
	inc de ; $7db8
	or a, a ; $7db9
	jr nz, Label_30_7db3 ; $7dba
	pop hl ; $7dbc
	pop de ; $7dbd
	pop bc ; $7dbe
	ret ; $7dbf
Label_30_7dc0:
	xor a, a ; $7dc0
	ld [de], a ; $7dc1
	ldh a, [$ff9e] ; $7dc2
	or a, a ; $7dc4
	jr z, Label_30_7dc9 ; $7dc5
	sound $2c ; $7dc7
Label_30_7dc9:
	pop hl ; $7dc9
	pop de ; $7dca
	pop bc ; $7dcb
	ret ; $7dcc
	ds 563, $ff ; $7dcd, fill
