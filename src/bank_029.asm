SECTION "ROM Bank $29", ROMX[$4000], BANK[$29]

FarPtr_29_00:
	dw Func_29_5e9d ; $4000
Func_29_4002:
	push hl ; $4002
	ld l, e ; $4003
	ld h, d ; $4004
	add hl, hl ; $4005
	add hl, hl ; $4006
	ld l, h ; $4007
	ld h, $00 ; $4008
	ld e, l ; $400a
	ld d, h ; $400b
	add hl, hl ; $400c
	add hl, de ; $400d
	add hl, hl ; $400e
	pop de ; $400f
	add hl, de ; $4010
	ret ; $4011
	INCBIN "data/bank_029/d_4012.bin" ; $4012, 13 bytes
Func_29_401f:
	ld a, [$c48e] ; $401f
	ld d, a ; $4022
	ld a, [$c48f] ; $4023
	ld e, a ; $4026
Label_29_4027:
	push hl ; $4027
	ld a, [hl+] ; $4028
	ld h, [hl] ; $4029
	ld l, a ; $402a
	add hl, bc ; $402b
	pop hl ; $402c
	jr c, Label_29_403d ; $402d
	ld a, d ; $402f
	cp a, e ; $4030
	jr nc, Label_29_403d ; $4031
	inc d ; $4033
	ld a, $06 ; $4034
	add a, l ; $4036
	ld l, a ; $4037
	jr nc, Label_29_403b ; $4038
	inc h ; $403a
Label_29_403b:
	jr Label_29_4027 ; $403b
Label_29_403d:
	ret ; $403d
	INCBIN "data/bank_029/d_403e.bin" ; $403e, 31 bytes
Func_29_405d:
	ld a, [hl+] ; $405d
	ld c, a ; $405e
	ld a, [hl+] ; $405f
	ld b, a ; $4060
	push bc ; $4061
	ld a, [hl+] ; $4062
	ld c, a ; $4063
	ld a, [hl+] ; $4064
	ld b, a ; $4065
	ld a, [hl+] ; $4066
	ld e, a ; $4067
	ld a, [hl+] ; $4068
	ld d, a ; $4069
	ld a, [$c4a7] ; $406a
	and a, a ; $406d
	jr z, Label_29_4076 ; $406e
	xor a, a ; $4070
	sub a, e ; $4071
	ld e, a ; $4072
	sbc a, a ; $4073
	sub a, d ; $4074
	ld d, a ; $4075
Label_29_4076:
	ld hl, $c43a ; $4076
	ld a, [hl+] ; $4079
	ld h, [hl] ; $407a
	ld l, a ; $407b
	add hl, de ; $407c
	ld e, l ; $407d
	ld d, h ; $407e
	pop hl ; $407f
	farcall FarPtr_08_26 ; $4080
	ret ; $4083
	INCBIN "data/bank_029/d_4084.bin" ; $4084, 20 bytes
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
	farcall FarPtr_08_26 ; $40dd
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
	farcall FarPtr_08_30 ; $40f6
	ld e, l ; $40f9
	ld d, h ; $40fa
	ld hl, $c450 ; $40fb
	ld a, e ; $40fe
	ld [hl+], a ; $40ff
	ld [hl], d ; $4100
	ret ; $4101
	xor a, a ; $4102
	sub a, c ; $4103
	ld c, a ; $4104
	sbc a, a ; $4105
	sub a, b ; $4106
	ld b, a ; $4107
	ld a, [$c48a] ; $4108
	ld e, a ; $410b
	ld a, [$c48b] ; $410c
	ld d, a ; $410f
	call Func_29_4002 ; $4110
	push hl ; $4113
	ld a, [hl+] ; $4114
	ld h, [hl] ; $4115
	ld l, a ; $4116
	add hl, bc ; $4117
	ld e, l ; $4118
	ld d, h ; $4119
	pop hl ; $411a
	jp c, Label_29_41f1 ; $411b
	call Func_29_401f ; $411e
	push de ; $4121
	call Func_29_405d ; $4122
	pop de ; $4125
	ld h, d ; $4126
	ld l, $00 ; $4127
	sra h ; $4129
	rr l ; $412b
	sra h ; $412d
	rr l ; $412f
	call Func_29_41f5 ; $4131
	ret ; $4134
	INCBIN "data/bank_029/d_4135.bin" ; $4135, 188 bytes
Label_29_41f1:
	farcall FarPtr_24_04 ; $41f1
	ret ; $41f4
Func_29_41f5:
	ld a, [$c43a] ; $41f5
	ld c, a ; $41f8
	ld a, [$c43b] ; $41f9
	ld b, a ; $41fc
	call MulSinCos ; $41fd
	ld c, l ; $4200
	ld b, h ; $4201
	ld hl, wBallX ; $4202
	ld a, [hl+] ; $4205
	ld h, [hl] ; $4206
	ld l, a ; $4207
	add hl, bc ; $4208
	ld c, l ; $4209
	ld b, h ; $420a
	ld hl, $c450 ; $420b
	ld a, c ; $420e
	ld [hl+], a ; $420f
	ld [hl], b ; $4210
	ld hl, wBallDepth ; $4211
	ld a, [hl+] ; $4214
	ld h, [hl] ; $4215
	ld l, a ; $4216
	add hl, de ; $4217
	ld e, l ; $4218
	ld d, h ; $4219
	ld hl, $c452 ; $421a
	ld a, e ; $421d
	ld [hl+], a ; $421e
	ld [hl], d ; $421f
	ret ; $4220
	INCBIN "data/bank_029/d_4221.bin" ; $4221, 43 bytes
Func_29_424c:
	ld e, l ; $424c
	ld d, h ; $424d
	ld hl, wBallHeight ; $424e
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
BallPosData_29:
	INCBIN "data/bank_029/d_427d.bin" ; $427d, 7200 bytes
Func_29_5e9d:
	farcall FarPtr_ComputeShotPlacement ; $5e9d
	ld hl, BallPosData_29 ; $5ea0
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
	; $5ebf, 104 bytes (records:2)
; 52 records x 2 bytes
	dw $0000 ; record 0
	dw $02d0 ; record 1
	dw $05a0 ; record 2
	dw $0870 ; record 3
	dw $0b40 ; record 4
	dw $0e10 ; record 5
	dw $10e0 ; record 6
	dw $13b0 ; record 7
	dw $1680 ; record 8
	dw $1950 ; record 9
	dw $0000 ; record 10
	dw $0048 ; record 11
	dw $0090 ; record 12
	dw $00d8 ; record 13
	dw $0120 ; record 14
	dw $0168 ; record 15
	dw $01b0 ; record 16
	dw $01f8 ; record 17
	dw $0240 ; record 18
	dw $0288 ; record 19
	dw $0000 ; record 20
	dw $0000 ; record 21
	dw $0000 ; record 22
	dw $0000 ; record 23
	dw $0000 ; record 24
	dw $0000 ; record 25
	dw $0000 ; record 26
	dw $0000 ; record 27
	dw $0000 ; record 28
	dw $0000 ; record 29
	dw $0000 ; record 30
	dw $0000 ; record 31
	dw $0006 ; record 32
	dw $000c ; record 33
	dw $0012 ; record 34
	dw $0018 ; record 35
	dw $001e ; record 36
	dw $0024 ; record 37
	dw $002a ; record 38
	dw $0030 ; record 39
	dw $0036 ; record 40
	dw $003c ; record 41
	dw $0042 ; record 42
	dw $0042 ; record 43
	dw $0042 ; record 44
	dw $0042 ; record 45
	dw $0042 ; record 46
	dw $0042 ; record 47
	dw $0042 ; record 48
	dw $0042 ; record 49
	dw $0042 ; record 50
	dw $0042 ; record 51
	ds 8409, $ff ; $5f27, fill
