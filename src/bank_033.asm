INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $33", ROMX[$4000], BANK[$33]

FarPtr_33_00:
	dw Func_33_7aca ; $4000
Text_33_4002:
	INCLUDE "data/bank_033/text_4002.asm" ; $4002, 15048 bytes
Func_33_7aca:
	push af ; $7aca
	ld a, $00 ; $7acb
	call Func_33_7ada ; $7acd
	pop af ; $7ad0
	ret ; $7ad1
	INCBIN "data/bank_033/d_7ad2.bin" ; $7ad2, 8 bytes
Func_33_7ada:
	push bc ; $7ada
	push de ; $7adb
	push hl ; $7adc
	ld hl, $4004 ; $7add
	sla e ; $7ae0
	rl d ; $7ae2
	add hl, de ; $7ae4
	ld e, [hl] ; $7ae5
	inc hl ; $7ae6
	ld d, [hl] ; $7ae7
	ld hl, $41be ; $7ae8
	add hl, de ; $7aeb
	or a, a ; $7aec
	jr nz, Label_33_7af6 ; $7aed
	ld de, $c600 ; $7aef
	ld c, $a0 ; $7af2
	jr Label_33_7afb ; $7af4
Label_33_7af6:
	ld de, $d880 ; $7af6
	ld c, $10 ; $7af9
Label_33_7afb:
	dec c ; $7afb
	jr z, Label_33_7b08 ; $7afc
	ld a, [hl+] ; $7afe
	ld [de], a ; $7aff
	inc de ; $7b00
	or a, a ; $7b01
	jr nz, Label_33_7afb ; $7b02
	pop hl ; $7b04
	pop de ; $7b05
	pop bc ; $7b06
	ret ; $7b07
Label_33_7b08:
	xor a, a ; $7b08
	ld [de], a ; $7b09
	ldh a, [$ff9e] ; $7b0a
	or a, a ; $7b0c
	jr z, Label_33_7b11 ; $7b0d
	sound $2c ; $7b0f
Label_33_7b11:
	pop hl ; $7b11
	pop de ; $7b12
	pop bc ; $7b13
	ret ; $7b14
	ds 1259, $ff ; $7b15, fill
