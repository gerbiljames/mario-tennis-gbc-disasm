INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $29", ROMX[$4000], BANK[$29]

	INCBIN "data/bank_029/d_4000.bin" ; $4000, 152 bytes
Func_29_4098:
	ld a, [hl+] ; $4098
	ld c, a ; $4099
	ld a, [hl+] ; $409a
	ld b, a ; $409b
	push hl ; $409c
	ld hl, $c476 ; $409d
	ld a, c ; $40a0
	ld [hl+], a ; $40a1
	ld [hl], b ; $40a2
	ld hl, $c434 ; $40a3
	ld a, [hl+] ; $40a6
	ld h, [hl] ; $40a7
	ld l, a ; $40a8
	bit 7, h ; $40a9
	jr z, Label_29_40b3 ; $40ab
	xor a, a ; $40ad
	sub a, l ; $40ae
	ld l, a ; $40af
	sbc a, a ; $40b0
	sub a, h ; $40b1
	ld h, a ; $40b2
Label_29_40b3:
	add hl, hl ; $40b3
	ld a, b ; $40b4
	call Func_00_0bd4 ; $40b5
	add hl, hl ; $40b8
	add hl, hl ; $40b9
	add hl, bc ; $40ba
	ld c, l ; $40bb
	ld b, h ; $40bc
	pop hl ; $40bd
	push bc ; $40be
	ld a, [hl+] ; $40bf
	ld c, a ; $40c0
	ld a, [hl+] ; $40c1
	ld b, a ; $40c2
	ld a, [hl+] ; $40c3
	ld e, a ; $40c4
	ld a, [hl+] ; $40c5
	ld d, a ; $40c6
	ld a, [$c4a7] ; $40c7
	and a, a ; $40ca
	jr z, Label_29_40d3 ; $40cb
	xor a, a ; $40cd
	sub a, e ; $40ce
	ld e, a ; $40cf
	sbc a, a ; $40d0
	sub a, d ; $40d1
	ld d, a ; $40d2
Label_29_40d3:
	ld hl, $c43a ; $40d3
	ld a, [hl+] ; $40d6
	ld h, [hl] ; $40d7
	ld l, a ; $40d8
	add hl, de ; $40d9
	ld e, l ; $40da
	ld d, h ; $40db
	pop hl ; $40dc
	rst Rst18 ; $40dd
	ld h, $08 ; $40de
	ld de, $fd40 ; $40e0
	ld a, [$df0a] ; $40e3
	and a, $02 ; $40e6
	jr z, Label_29_40f0 ; $40e8
	xor a, a ; $40ea
	sub a, e ; $40eb
	ld e, a ; $40ec
	sbc a, a ; $40ed
	sub a, d ; $40ee
	ld d, a ; $40ef
Label_29_40f0:
	ld hl, $c452 ; $40f0
	ld a, e ; $40f3
	ld [hl+], a ; $40f4
	ld [hl], d ; $40f5
	rst Rst18 ; $40f6
	jr nc, Label_29_4101 ; $40f7
	ld e, l ; $40f9
	ld d, h ; $40fa
	ld hl, $c450 ; $40fb
	ld a, e ; $40fe
	ld [hl+], a ; $40ff
	ld [hl], d ; $4100
Label_29_4101:
	ret ; $4101
	INCBIN "data/bank_029/d_4102.bin" ; $4102, 330 bytes
Func_29_424c:
	ld e, l ; $424c
	ld d, h ; $424d
	ld hl, $c40a ; $424e
	ld a, [hl+] ; $4251
	ld h, [hl] ; $4252
	ld l, a ; $4253
	xor a, a ; $4254
	sub a, l ; $4255
	ld l, a ; $4256
	sbc a, a ; $4257
	sub a, h ; $4258
	ld h, a ; $4259
	add hl, hl ; $425a
	add hl, hl ; $425b
	add hl, hl ; $425c
	add hl, hl ; $425d
	ld a, h ; $425e
	and a, $1f ; $425f
	add a, a ; $4261
	ld l, c ; $4262
	ld h, b ; $4263
	add a, l ; $4264
	ld l, a ; $4265
	jr nc, Label_29_4269 ; $4266
	inc h ; $4268
Label_29_4269:
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ret ; $426d
Func_29_426e:
	ld e, l ; $426e
	ld d, h ; $426f
	add a, a ; $4270
	ld l, c ; $4271
	ld h, b ; $4272
	add a, l ; $4273
	ld l, a ; $4274
	jr nc, Label_29_4278 ; $4275
	inc h ; $4277
Label_29_4278:
	ld a, [hl+] ; $4278
	ld h, [hl] ; $4279
	ld l, a ; $427a
	add hl, de ; $427b
	ret ; $427c
	INCBIN "data/bank_029/d_427d.bin" ; $427d, 7200 bytes
	rst Rst18 ; $5e9d
	ld a, [hl-] ; $5e9e
	rlca ; $5e9f
	ld hl, $427d ; $5ea0
	ld bc, $5ebf ; $5ea3
	ld a, [$df6e] ; $5ea6
	call Func_29_426e ; $5ea9
	ld bc, $5ed3 ; $5eac
	ld a, [$df6c] ; $5eaf
	call Func_29_426e ; $5eb2
	ld bc, $5ee7 ; $5eb5
	call Func_29_424c ; $5eb8
	call Func_29_4098 ; $5ebb
	ret ; $5ebe
	INCBIN "data/bank_029/d_5ebf.bin" ; $5ebf, 8513 bytes
