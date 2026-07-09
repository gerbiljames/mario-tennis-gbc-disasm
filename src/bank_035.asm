INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $35", ROMX[$4000], BANK[$35]

	INCBIN "data/bank_035/d_4000.bin" ; $4000, 15145 bytes
	push af ; $7b29
	ld a, $00 ; $7b2a
	call Func_35_7b39 ; $7b2c
	pop af ; $7b2f
	ret ; $7b30
	INCBIN "data/bank_035/d_7b31.bin" ; $7b31, 8 bytes
Func_35_7b39:
	push bc ; $7b39
	push de ; $7b3a
	push hl ; $7b3b
	ld hl, $4004 ; $7b3c
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
	ld de, $c600 ; $7b4e
	ld c, $a0 ; $7b51
	jr Label_35_7b5a ; $7b53
Label_35_7b55:
	ld de, $d880 ; $7b55
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
	ldh a, [$ff9e] ; $7b69
	or a, a ; $7b6b
	jr z, Label_35_7b70 ; $7b6c
	rst Rst08 ; $7b6e
	inc l ; $7b6f
Label_35_7b70:
	pop hl ; $7b70
	pop de ; $7b71
	pop bc ; $7b72
	ret ; $7b73
	INCBIN "data/bank_035/d_7b74.bin" ; $7b74, 1164 bytes
