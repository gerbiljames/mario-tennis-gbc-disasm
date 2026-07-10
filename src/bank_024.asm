INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $24", ROMX[$4000], BANK[$24]

FarPtr_24_00:
	dw Func_24_4589 ; $4000
FarPtr_24_02:
	dw Func_24_51a0 ; $4002
FarPtr_24_04:
	dw Func_24_57fd ; $4004
FarPtr_24_06:
	dw Func_24_6644 ; $4006
FarPtr_24_08:
	dw Func_24_6696 ; $4008
FarPtr_24_0a:
	dw Func_24_6706 ; $400a
FarPtr_24_0c:
	dw Func_24_7707 ; $400c
Func_24_400e:
	push hl ; $400e
	ld l, e ; $400f
	ld h, d ; $4010
	add hl, hl ; $4011
	add hl, hl ; $4012
	ld l, h ; $4013
	ld h, $00 ; $4014
	ld e, l ; $4016
	ld d, h ; $4017
	add hl, hl ; $4018
	add hl, de ; $4019
	add hl, hl ; $401a
	pop de ; $401b
	add hl, de ; $401c
	ret ; $401d
Func_24_401e:
	push hl ; $401e
	ld l, e ; $401f
	ld h, d ; $4020
	add hl, hl ; $4021
	add hl, hl ; $4022
	ld l, h ; $4023
	ld h, $00 ; $4024
	add hl, hl ; $4026
	add hl, hl ; $4027
	pop de ; $4028
	add hl, de ; $4029
	ret ; $402a
	INCBIN "data/bank_024/d_402b.bin" ; $402b, 31 bytes
Func_24_404a:
	ld a, [$c48e] ; $404a
	ld d, a ; $404d
	ld a, [$c48f] ; $404e
	ld e, a ; $4051
Label_24_4052:
	push hl ; $4052
	ld a, [hl+] ; $4053
	ld h, [hl] ; $4054
	ld l, a ; $4055
	add hl, bc ; $4056
	pop hl ; $4057
	jr c, Label_24_4068 ; $4058
	ld a, d ; $405a
	cp a, e ; $405b
	jr nc, Label_24_4068 ; $405c
	inc d ; $405e
	ld a, $04 ; $405f
	add a, l ; $4061
	ld l, a ; $4062
	jr nc, Label_24_4066 ; $4063
	inc h ; $4065
Label_24_4066:
	jr Label_24_4052 ; $4066
Label_24_4068:
	ret ; $4068
Func_24_4069:
	ld a, [hl+] ; $4069
	ld c, a ; $406a
	ld a, [hl+] ; $406b
	ld b, a ; $406c
	push bc ; $406d
	ld a, [hl+] ; $406e
	ld c, a ; $406f
	ld a, [hl+] ; $4070
	ld b, a ; $4071
	ld a, [hl+] ; $4072
	ld e, a ; $4073
	ld a, [hl+] ; $4074
	ld d, a ; $4075
	ld a, [$c4a7] ; $4076
	and a, a ; $4079
	jr z, Label_24_4082 ; $407a
	xor a, a ; $407c
	sub a, e ; $407d
	ld e, a ; $407e
	sbc a, a ; $407f
	sub a, d ; $4080
	ld d, a ; $4081
Label_24_4082:
	ld hl, $c43a ; $4082
	ld a, [hl+] ; $4085
	ld h, [hl] ; $4086
	ld l, a ; $4087
	add hl, de ; $4088
	ld e, l ; $4089
	ld d, h ; $408a
	pop hl ; $408b
	farcall FarPtr_08_26 ; $408c
	ret ; $408f
Func_24_4090:
	ld a, [hl+] ; $4090
	ld c, a ; $4091
	ld a, [hl+] ; $4092
	ld b, a ; $4093
	push bc ; $4094
	ld a, [hl+] ; $4095
	ld c, a ; $4096
	ld a, [hl+] ; $4097
	ld b, a ; $4098
	ld hl, $c43a ; $4099
	ld a, [hl+] ; $409c
	ld d, [hl] ; $409d
	ld e, a ; $409e
	pop hl ; $409f
	farcall FarPtr_08_26 ; $40a0
	ret ; $40a3
	INCBIN "data/bank_024/d_40a4.bin" ; $40a4, 197 bytes
Func_24_4169:
	push hl ; $4169
	ld hl, $c43a ; $416a
	ld a, [hl+] ; $416d
	ld b, [hl] ; $416e
	ld c, a ; $416f
	ld hl, $c436 ; $4170
	ld a, [hl+] ; $4173
	ld d, [hl] ; $4174
	ld e, a ; $4175
	ld hl, $c434 ; $4176
	ld a, [hl+] ; $4179
	ld h, [hl] ; $417a
	ld l, a ; $417b
	call Func_00_138f ; $417c
	ld e, l ; $417f
	ld d, h ; $4180
	ld hl, $c48c ; $4181
	ld a, [hl+] ; $4184
	ld h, [hl] ; $4185
	ld l, a ; $4186
	ld a, l ; $4187
	sub a, e ; $4188
	ld l, a ; $4189
	ld a, h ; $418a
	sbc a, d ; $418b
	ld h, a ; $418c
	jr nc, Label_24_4195 ; $418d
	ld hl, $c48c ; $418f
	ld a, [hl+] ; $4192
	ld d, [hl] ; $4193
	ld e, a ; $4194
Label_24_4195:
	pop hl ; $4195
	push de ; $4196
	call Func_24_400e ; $4197
	call Func_24_4069 ; $419a
	pop hl ; $419d
	call Func_24_4201 ; $419e
	ret ; $41a1
Func_24_41a2:
	xor a, a ; $41a2
	sub a, c ; $41a3
	ld c, a ; $41a4
	sbc a, a ; $41a5
	sub a, b ; $41a6
	ld b, a ; $41a7
	ld a, [$c48a] ; $41a8
	ld e, a ; $41ab
	ld a, [$c48b] ; $41ac
	ld d, a ; $41af
	call Func_24_401e ; $41b0
	push hl ; $41b3
	ld a, [hl+] ; $41b4
	ld h, [hl] ; $41b5
	ld l, a ; $41b6
	add hl, bc ; $41b7
	ld e, l ; $41b8
	ld d, h ; $41b9
	pop hl ; $41ba
	jp c, Label_24_41fd ; $41bb
	call Func_24_404a ; $41be
	push de ; $41c1
	call Func_24_4090 ; $41c2
	pop de ; $41c5
	ld h, d ; $41c6
	ld l, $00 ; $41c7
	sra h ; $41c9
	rr l ; $41cb
	sra h ; $41cd
	rr l ; $41cf
	call Func_24_4201 ; $41d1
	ret ; $41d4
	INCBIN "data/bank_024/d_41d5.bin" ; $41d5, 40 bytes
Label_24_41fd:
	farcall FarPtr_24_04 ; $41fd
	ret ; $4200
Func_24_4201:
	ld a, [$c43a] ; $4201
	ld c, a ; $4204
	ld a, [$c43b] ; $4205
	ld b, a ; $4208
	call Func_00_1340 ; $4209
	ld c, l ; $420c
	ld b, h ; $420d
	ld hl, $c402 ; $420e
	ld a, [hl+] ; $4211
	ld h, [hl] ; $4212
	ld l, a ; $4213
	add hl, bc ; $4214
	ld c, l ; $4215
	ld b, h ; $4216
	ld hl, $c450 ; $4217
	ld a, c ; $421a
	ld [hl+], a ; $421b
	ld [hl], b ; $421c
	ld hl, $c406 ; $421d
	ld a, [hl+] ; $4220
	ld h, [hl] ; $4221
	ld l, a ; $4222
	add hl, de ; $4223
	ld e, l ; $4224
	ld d, h ; $4225
	ld hl, $c452 ; $4226
	ld a, e ; $4229
	ld [hl+], a ; $422a
	ld [hl], d ; $422b
	ret ; $422c
Func_24_422d:
	push hl ; $422d
	push bc ; $422e
	ld hl, $c43a ; $422f
	ld a, [hl+] ; $4232
	ld b, [hl] ; $4233
	ld c, a ; $4234
	ld hl, $c406 ; $4235
	ld a, [hl+] ; $4238
	ld d, [hl] ; $4239
	ld e, a ; $423a
	ld hl, $c402 ; $423b
	ld a, [hl+] ; $423e
	ld h, [hl] ; $423f
	ld l, a ; $4240
	call Func_00_138f ; $4241
	add hl, hl ; $4244
	ld a, h ; $4245
	and a, $1f ; $4246
	ld [$c472], a ; $4248
	add a, a ; $424b
	pop hl ; $424c
	pop de ; $424d
	add a, l ; $424e
	ld l, a ; $424f
	jr nc, Label_24_4253 ; $4250
	inc h ; $4252
Label_24_4253:
	ld a, [hl+] ; $4253
	ld h, [hl] ; $4254
	ld l, a ; $4255
	add hl, de ; $4256
	ret ; $4257
Func_24_4258:
	ld e, l ; $4258
	ld d, h ; $4259
	ld hl, $c40a ; $425a
	ld a, [hl+] ; $425d
	ld h, [hl] ; $425e
	ld l, a ; $425f
	xor a, a ; $4260
	sub a, l ; $4261
	ld l, a ; $4262
	sbc a, a ; $4263
	sub a, h ; $4264
	ld h, a ; $4265
	add hl, hl ; $4266
	add hl, hl ; $4267
	add hl, hl ; $4268
	add hl, hl ; $4269
	ld a, h ; $426a
	and a, $1f ; $426b
	add a, a ; $426d
	ld l, c ; $426e
	ld h, b ; $426f
	add a, l ; $4270
	ld l, a ; $4271
	jr nc, Label_24_4275 ; $4272
	inc h ; $4274
Label_24_4275:
	ld a, [hl+] ; $4275
	ld h, [hl] ; $4276
	ld l, a ; $4277
	add hl, de ; $4278
	ret ; $4279
Func_24_427a:
	ld e, l ; $427a
	ld d, h ; $427b
	add a, a ; $427c
	ld l, c ; $427d
	ld h, b ; $427e
	add a, l ; $427f
	ld l, a ; $4280
	jr nc, Label_24_4284 ; $4281
	inc h ; $4283
Label_24_4284:
	ld a, [hl+] ; $4284
	ld h, [hl] ; $4285
	ld l, a ; $4286
	add hl, de ; $4287
	ret ; $4288
	INCBIN "data/bank_024/d_4289.bin" ; $4289, 768 bytes
Func_24_4589:
	farcall FarPtr_07_3a ; $4589
	ld hl, $4289 ; $458c
	ld bc, $459c ; $458f
	ld a, [$df92] ; $4592
	call Func_24_427a ; $4595
	call Func_24_4169 ; $4598
	ret ; $459b
	INCBIN "data/bank_024/d_459c.bin" ; $459c, 1807 bytes
	push af ; $4cab
	sbc a, b ; $4cac
	cp a, $e0 ; $4cad
	dec h ; $4caf
	ld d, [hl] ; $4cb0
	push af ; $4cb1
	sbc a, b ; $4cb2
	cp a, $80 ; $4cb3
	ld h, $56 ; $4cb5
	push af ; $4cb7
	sbc a, b ; $4cb8
	cp a, $00 ; $4cb9
	daa ; $4cbb
	ld d, [hl] ; $4cbc
	push af ; $4cbd
	sbc a, b ; $4cbe
	cp a, $80 ; $4cbf
	daa ; $4cc1
	ld d, [hl] ; $4cc2
	push af ; $4cc3
	sbc a, b ; $4cc4
	cp a, $20 ; $4cc5
	jr z, Label_24_4d1f ; $4cc7
	push af ; $4cc9
	sbc a, b ; $4cca
	cp a, $c0 ; $4ccb
	jr z, $4d25 ; $4ccd
	push af ; $4ccf
	sbc a, b ; $4cd0
	cp a, $40 ; $4cd1
	add hl, hl ; $4cd3
	ld d, [hl] ; $4cd4
	push af ; $4cd5
	sbc a, b ; $4cd6
	cp a, $c0 ; $4cd7
	add hl, hl ; $4cd9
	ld d, [hl] ; $4cda
	push af ; $4cdb
	ld [hl], h ; $4cdc
	cp a, $60 ; $4cdd
	ld a, [hl+] ; $4cdf
	ld d, [hl] ; $4ce0
	push af ; $4ce1
	ld [hl], h ; $4ce2
	cp a, $e0 ; $4ce3
	ld a, [hl+] ; $4ce5
	ld d, [hl] ; $4ce6
	push af ; $4ce7
	ld [hl], h ; $4ce8
	cp a, $60 ; $4ce9
	dec hl ; $4ceb
	ld d, [hl] ; $4cec
	push af ; $4ced
	ld [hl], h ; $4cee
	cp a, $c0 ; $4cef
	dec hl ; $4cf1
	ld d, [hl] ; $4cf2
	push af ; $4cf3
	ld [hl], h ; $4cf4
	cp a, $60 ; $4cf5
	inc l ; $4cf7
	ld d, [hl] ; $4cf8
	push af ; $4cf9
	ld [hl], h ; $4cfa
	cp a, $e0 ; $4cfb
	inc l ; $4cfd
	ld d, [hl] ; $4cfe
	push af ; $4cff
	ld [hl], h ; $4d00
	cp a, $80 ; $4d01
	dec l ; $4d03
	ld d, [hl] ; $4d04
	push af ; $4d05
	ld [hl], h ; $4d06
	cp a, $e0 ; $4d07
	dec l ; $4d09
	ld d, [hl] ; $4d0a
	push af ; $4d0b
	ld [hl], h ; $4d0c
	cp a, $40 ; $4d0d
	ld l, $56 ; $4d0f
	push af ; $4d11
	ld [hl], h ; $4d12
	cp a, $e0 ; $4d13
	ld l, $56 ; $4d15
	push af ; $4d17
	ld [hl], h ; $4d18
	cp a, $80 ; $4d19
	cpl ; $4d1b
	ld d, [hl] ; $4d1c
	push af ; $4d1d
	ld [hl], h ; $4d1e
Label_24_4d1f:
	cp a, $a0 ; $4d1f
	ld [$e002], sp ; $4d21
	call z, $a0f1 ; $4d24
	ld [$e002], sp ; $4d27
	call z, $a0f1 ; $4d2a
	ld [$e002], sp ; $4d2d
	call z, $a0f1 ; $4d30
	ld [$e002], sp ; $4d33
	call z, $a0f1 ; $4d36
	ld [$e002], sp ; $4d39
	call z, $a0f1 ; $4d3c
	ld [$e002], sp ; $4d3f
	call z, $80f1 ; $4d42
	add hl, bc ; $4d45
	sub a, b ; $4d46
	INCBIN "data/bank_024/d_4d47.bin" ; $4d47, 1113 bytes
Func_24_51a0:
	farcall FarPtr_07_3a ; $51a0
	ld hl, $45a0 ; $51a3
	ld bc, $51b9 ; $51a6
	call Func_24_422d ; $51a9
	ld bc, $51f9 ; $51ac
	ld a, [$df93] ; $51af
	call Func_24_427a ; $51b2
	call Func_24_4169 ; $51b5
	ret ; $51b8
	INCBIN "data/bank_024/d_51b9.bin" ; $51b9, 1604 bytes
Func_24_57fd:
	ld a, $01 ; $57fd
	ld [$c4c6], a ; $57ff
	xor a, a ; $5802
	ld [$c4bd], a ; $5803
	xor a, a ; $5806
	ld hl, $c41c ; $5807
	ld [hl+], a ; $580a
	ld [hl+], a ; $580b
	ld [hl+], a ; $580c
	ld [hl+], a ; $580d
	ld a, d ; $580e
	srl a ; $580f
	ld bc, $0280 ; $5811
	cp a, $04 ; $5814
	jr c, Label_24_5824 ; $5816
	ld a, $03 ; $5818
	ld bc, $0140 ; $581a
	jr z, Label_24_5824 ; $581d
	ld a, $00 ; $581f
	ld bc, $00e0 ; $5821
Label_24_5824:
	push af ; $5824
	farcall FarPtr_07_3e ; $5825
	pop af ; $5828
	add a, a ; $5829
	add a, $3c ; $582a
	ld l, a ; $582c
	adc a, $58 ; $582d
	sub a, l ; $582f
	ld h, a ; $5830
	ld a, [hl+] ; $5831
	ld d, [hl] ; $5832
	ld e, a ; $5833
	ld hl, $51fd ; $5834
	add hl, de ; $5837
	call Func_24_4169 ; $5838
	ret ; $583b
	INCBIN "data/bank_024/d_583c.bin" ; $583c, 3592 bytes
Func_24_6644:
	farcall FarPtr_07_3a ; $6644
	push bc ; $6647
	ld hl, $5844 ; $6648
	ld bc, $6656 ; $664b
	call Func_24_4258 ; $664e
	pop bc ; $6651
	call Func_24_41a2 ; $6652
	ret ; $6655
	INCBIN "data/bank_024/d_6656.bin" ; $6656, 64 bytes
Func_24_6696:
	farcall FarPtr_07_3a ; $6696
	push bc ; $6699
	ld hl, $c48c ; $669a
	ld a, [hl+] ; $669d
	ld d, [hl] ; $669e
	ld e, a ; $669f
	ld hl, $c406 ; $66a0
	ld a, [hl+] ; $66a3
	ld h, [hl] ; $66a4
	ld l, a ; $66a5
	bit 7, h ; $66a6
	jr z, Label_24_66b0 ; $66a8
	xor a, a ; $66aa
	sub a, l ; $66ab
	ld l, a ; $66ac
	sbc a, a ; $66ad
	sub a, h ; $66ae
	ld h, a ; $66af
Label_24_66b0:
	add hl, de ; $66b0
	ld e, l ; $66b1
	ld d, h ; $66b2
	ld hl, $c40a ; $66b3
	ld a, [hl+] ; $66b6
	ld h, [hl] ; $66b7
	ld l, a ; $66b8
	xor a, a ; $66b9
	sub a, l ; $66ba
	ld l, a ; $66bb
	sbc a, a ; $66bc
	sub a, h ; $66bd
	ld h, a ; $66be
	ld c, l ; $66bf
	ld b, h ; $66c0
	sra b ; $66c1
	rr c ; $66c3
	add hl, bc ; $66c5
	call Func_00_1416 ; $66c6
	ld a, [$df6c] ; $66c9
	add a, a ; $66cc
	add a, $f2 ; $66cd
	ld l, a ; $66cf
	adc a, $66 ; $66d0
	sub a, l ; $66d2
	ld h, a ; $66d3
	ld a, [hl+] ; $66d4
	ld h, [hl] ; $66d5
	ld l, a ; $66d6
	add hl, bc ; $66d7
	ld c, l ; $66d8
	ld b, h ; $66d9
	ld hl, $c43a ; $66da
	ld a, [hl+] ; $66dd
	ld d, [hl] ; $66de
	ld e, a ; $66df
	pop hl ; $66e0
	farcall FarPtr_08_26 ; $66e1
	ld hl, $c48c ; $66e4
	ld a, [hl+] ; $66e7
	ld d, [hl] ; $66e8
	ld e, a ; $66e9
	ld hl, rJOYP ; $66ea
	add hl, de ; $66ed
	call Func_24_4201 ; $66ee
	ret ; $66f1
	INCBIN "data/bank_024/d_66f2.bin" ; $66f2, 20 bytes
Func_24_6706:
	ret ; $6706
	INCBIN "data/bank_024/d_6707.bin" ; $6707, 4096 bytes
Func_24_7707:
	farcall FarPtr_07_3a ; $7707
	push bc ; $770a
	ld hl, $6707 ; $770b
	ld bc, $7719 ; $770e
	call Func_24_4258 ; $7711
	pop bc ; $7714
	call Func_24_41a2 ; $7715
	ret ; $7718
	INCBIN "data/bank_024/d_7719.bin" ; $7719, 2279 bytes
