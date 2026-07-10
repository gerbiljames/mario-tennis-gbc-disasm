INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $03", ROMX[$4000], BANK[$03]

FarPtr_03_00:
	dw Func_03_47f9 ; $4000
FarPtr_03_02:
	dw Func_03_495d ; $4002
FarPtr_03_04:
	dw Func_03_4a89 ; $4004
FarPtr_03_06:
	dw Func_03_4b9b ; $4006
FarPtr_03_08:
	dw Func_03_4c9e ; $4008
FarPtr_03_0a:
	dw Func_03_4c14 ; $400a
FarPtr_03_0c:
	dw Func_03_4aff ; $400c
FarPtr_03_0e:
	dw Func_03_4b54 ; $400e
FarPtr_03_10:
	dw Func_03_4a3c ; $4010
FarPtr_03_12:
	dw Func_03_5669 ; $4012
FarPtr_03_14:
	dw Func_03_4f7d ; $4014
FarPtr_03_16:
	dw Func_03_4e13 ; $4016
FarPtr_03_18:
	dw Func_03_4d10 ; $4018
FarPtr_03_1a:
	dw Func_03_4d64 ; $401a
FarPtr_03_1c:
	dw Func_03_4d86 ; $401c
FarPtr_03_1e:
	dw Func_03_4db6 ; $401e
FarPtr_03_20:
	dw Func_03_4de4 ; $4020
FarPtr_03_22:
	dw Func_03_5310 ; $4022
FarPtr_03_24:
	dw Func_03_4fea ; $4024
FarPtr_03_26:
	dw Func_03_4fae ; $4026
FarPtr_03_28:
	dw Func_03_4ffe ; $4028
FarPtr_03_2a:
	dw Func_03_5072 ; $402a
FarPtr_03_2c:
	dw Func_03_5015 ; $402c
FarPtr_03_2e:
	dw Func_03_56a8 ; $402e
FarPtr_03_30:
	dw Func_03_56fb ; $4030
FarPtr_03_32:
	dw Func_03_5229 ; $4032
FarPtr_03_34:
	dw Func_03_5240 ; $4034
FarPtr_03_36:
	dw Func_03_59c5 ; $4036
FarPtr_03_38:
	dw Func_03_5b28 ; $4038
FarPtr_03_3a:
	dw Func_03_5b4d ; $403a
FarPtr_03_3c:
	dw Func_03_6ff7 ; $403c
FarPtr_03_3e:
	dw Func_03_751e ; $403e
FarPtr_03_40:
	dw Func_03_75ab ; $4040
FarPtr_03_42:
	dw Func_03_7687 ; $4042
FarPtr_03_44:
	dw Func_03_7719 ; $4044
FarPtr_03_46:
	dw Func_03_5787 ; $4046
FarPtr_03_48:
	dw Func_03_4d08 ; $4048
Func_03_404a:
	push af ; $404a
	push bc ; $404b
	push de ; $404c
	push hl ; $404d
	ld a, $00 ; $404e
	ldh [$ff97], a ; $4050
	ld [$4000], a ; $4052
	ld hl, $47e9 ; $4055
	ld de, $a020 ; $4058
	call Func_03_4a69 ; $405b
	ld hl, $a061 ; $405e
	ld [hl], $00 ; $4061
	inc hl ; $4063
	ld [hl], $00 ; $4064
	inc hl ; $4066
	ld [hl], $08 ; $4067
	inc hl ; $4069
	ld [hl], $00 ; $406a
	inc hl ; $406c
	ld [hl], $03 ; $406d
	ld hl, $a071 ; $406f
	ld [hl], $00 ; $4072
	inc hl ; $4074
	ld [hl], $00 ; $4075
	inc hl ; $4077
	ld [hl], $0b ; $4078
	inc hl ; $407a
	ld [hl], $00 ; $407b
	inc hl ; $407d
	ld [hl], $02 ; $407e
	ld hl, $a081 ; $4080
	ld [hl], $00 ; $4083
	inc hl ; $4085
	ld [hl], $00 ; $4086
	inc hl ; $4088
	ld [hl], $0d ; $4089
	inc hl ; $408b
	ld [hl], $00 ; $408c
	inc hl ; $408e
	ld [hl], $03 ; $408f
	ld hl, $a091 ; $4091
	ld [hl], $00 ; $4094
	inc hl ; $4096
	ld [hl], $00 ; $4097
	inc hl ; $4099
	ld [hl], $10 ; $409a
	inc hl ; $409c
	ld [hl], $00 ; $409d
	inc hl ; $409f
	ld [hl], $02 ; $40a0
	ld hl, $a0a1 ; $40a2
	ld [hl], $00 ; $40a5
	inc hl ; $40a7
	ld [hl], $00 ; $40a8
	inc hl ; $40aa
	ld [hl], $12 ; $40ab
	inc hl ; $40ad
	ld [hl], $00 ; $40ae
	inc hl ; $40b0
	ld [hl], $03 ; $40b1
	ld hl, $a0b1 ; $40b3
	ld [hl], $00 ; $40b6
	inc hl ; $40b8
	ld [hl], $00 ; $40b9
	inc hl ; $40bb
	ld [hl], $15 ; $40bc
	inc hl ; $40be
	ld [hl], $00 ; $40bf
	inc hl ; $40c1
	ld [hl], $02 ; $40c2
	ld hl, $a0c1 ; $40c4
	ld [hl], $00 ; $40c7
	inc hl ; $40c9
	ld [hl], $00 ; $40ca
	inc hl ; $40cc
	ld [hl], $17 ; $40cd
	inc hl ; $40cf
	ld [hl], $30 ; $40d0
	inc hl ; $40d2
	ld [hl], $00 ; $40d3
	ld hl, $a0d1 ; $40d5
	ld [hl], $00 ; $40d8
	inc hl ; $40da
	ld [hl], $30 ; $40db
	inc hl ; $40dd
	ld [hl], $17 ; $40de
	inc hl ; $40e0
	ld [hl], $20 ; $40e1
	inc hl ; $40e3
	ld [hl], $00 ; $40e4
	ld hl, $a0e1 ; $40e6
	ld [hl], $00 ; $40e9
	inc hl ; $40eb
	ld [hl], $50 ; $40ec
	inc hl ; $40ee
	ld [hl], $17 ; $40ef
	inc hl ; $40f1
	ld [hl], $20 ; $40f2
	inc hl ; $40f4
	ld [hl], $00 ; $40f5
	ld hl, $a0f1 ; $40f7
	ld [hl], $00 ; $40fa
	inc hl ; $40fc
	ld [hl], $70 ; $40fd
	inc hl ; $40ff
	ld [hl], $17 ; $4100
	inc hl ; $4102
	ld [hl], $20 ; $4103
	inc hl ; $4105
	ld [hl], $00 ; $4106
	ld hl, $a101 ; $4108
	ld [hl], $00 ; $410b
	inc hl ; $410d
	ld [hl], $90 ; $410e
	inc hl ; $4110
	ld [hl], $17 ; $4111
	inc hl ; $4113
	ld [hl], $10 ; $4114
	inc hl ; $4116
	ld [hl], $00 ; $4117
	ld hl, $a111 ; $4119
	ld [hl], $00 ; $411c
	inc hl ; $411e
	ld [hl], $00 ; $411f
	inc hl ; $4121
	ld [hl], $18 ; $4122
	inc hl ; $4124
	ld [hl], $00 ; $4125
	inc hl ; $4127
	ld [hl], $02 ; $4128
	ld hl, $a121 ; $412a
	ld [hl], $00 ; $412d
	inc hl ; $412f
	ld [hl], $00 ; $4130
	inc hl ; $4132
	ld [hl], $1a ; $4133
	inc hl ; $4135
	ld [hl], $20 ; $4136
	inc hl ; $4138
	ld [hl], $00 ; $4139
	ld hl, $a131 ; $413b
	ld [hl], $00 ; $413e
	inc hl ; $4140
	ld [hl], $20 ; $4141
	inc hl ; $4143
	ld [hl], $1a ; $4144
	inc hl ; $4146
	ld [hl], $20 ; $4147
	inc hl ; $4149
	ld [hl], $00 ; $414a
	ld hl, $a141 ; $414c
	ld [hl], $00 ; $414f
	inc hl ; $4151
	ld [hl], $40 ; $4152
	inc hl ; $4154
	ld [hl], $1a ; $4155
	inc hl ; $4157
	ld [hl], $20 ; $4158
	inc hl ; $415a
	ld [hl], $00 ; $415b
	ld hl, $a151 ; $415d
	ld [hl], $00 ; $4160
	inc hl ; $4162
	ld [hl], $60 ; $4163
	inc hl ; $4165
	ld [hl], $1a ; $4166
	inc hl ; $4168
	ld [hl], $20 ; $4169
	inc hl ; $416b
	ld [hl], $00 ; $416c
	ld hl, $a161 ; $416e
	ld [hl], $00 ; $4171
	inc hl ; $4173
	ld [hl], $80 ; $4174
	inc hl ; $4176
	ld [hl], $1a ; $4177
	inc hl ; $4179
	ld [hl], $80 ; $417a
	inc hl ; $417c
	ld [hl], $00 ; $417d
	ld hl, $a171 ; $417f
	ld [hl], $00 ; $4182
	inc hl ; $4184
	ld [hl], $00 ; $4185
	inc hl ; $4187
	ld [hl], $1b ; $4188
	inc hl ; $418a
	ld [hl], $80 ; $418b
	inc hl ; $418d
	ld [hl], $00 ; $418e
	ld hl, $a181 ; $4190
	ld [hl], $00 ; $4193
	inc hl ; $4195
	ld [hl], $80 ; $4196
	inc hl ; $4198
	ld [hl], $1b ; $4199
	inc hl ; $419b
	ld [hl], $80 ; $419c
	inc hl ; $419e
	ld [hl], $00 ; $419f
	ld hl, $a191 ; $41a1
	ld [hl], $00 ; $41a4
	inc hl ; $41a6
	ld [hl], $00 ; $41a7
	inc hl ; $41a9
	ld [hl], $1c ; $41aa
	inc hl ; $41ac
	ld [hl], $80 ; $41ad
	inc hl ; $41af
	ld [hl], $00 ; $41b0
	ld hl, $a1a1 ; $41b2
	ld [hl], $00 ; $41b5
	inc hl ; $41b7
	ld [hl], $80 ; $41b8
	inc hl ; $41ba
	ld [hl], $1c ; $41bb
	inc hl ; $41bd
	ld [hl], $80 ; $41be
	inc hl ; $41c0
	ld [hl], $00 ; $41c1
	ld hl, $a1b1 ; $41c3
	ld [hl], $00 ; $41c6
	inc hl ; $41c8
	ld [hl], $00 ; $41c9
	inc hl ; $41cb
	ld [hl], $1d ; $41cc
	inc hl ; $41ce
	ld [hl], $80 ; $41cf
	inc hl ; $41d1
	ld [hl], $00 ; $41d2
	ld hl, $a1c1 ; $41d4
	ld [hl], $00 ; $41d7
	inc hl ; $41d9
	ld [hl], $80 ; $41da
	inc hl ; $41dc
	ld [hl], $1d ; $41dd
	inc hl ; $41df
	ld [hl], $80 ; $41e0
	inc hl ; $41e2
	ld [hl], $00 ; $41e3
	ld hl, $a1d1 ; $41e5
	ld [hl], $00 ; $41e8
	inc hl ; $41ea
	ld [hl], $00 ; $41eb
	inc hl ; $41ed
	ld [hl], $1e ; $41ee
	inc hl ; $41f0
	ld [hl], $80 ; $41f1
	inc hl ; $41f3
	ld [hl], $00 ; $41f4
	ld hl, $a1e1 ; $41f6
	ld [hl], $00 ; $41f9
	inc hl ; $41fb
	ld [hl], $80 ; $41fc
	inc hl ; $41fe
	ld [hl], $1e ; $41ff
	inc hl ; $4201
	ld [hl], $80 ; $4202
	inc hl ; $4204
	ld [hl], $00 ; $4205
	ld hl, $a1f1 ; $4207
	ld [hl], $00 ; $420a
	inc hl ; $420c
	ld [hl], $00 ; $420d
	inc hl ; $420f
	ld [hl], $1f ; $4210
	inc hl ; $4212
	ld [hl], $80 ; $4213
	inc hl ; $4215
	ld [hl], $00 ; $4216
	ld hl, $a201 ; $4218
	ld [hl], $00 ; $421b
	inc hl ; $421d
	ld [hl], $80 ; $421e
	inc hl ; $4220
	ld [hl], $1f ; $4221
	inc hl ; $4223
	ld [hl], $80 ; $4224
	inc hl ; $4226
	ld [hl], $00 ; $4227
	ld hl, $a211 ; $4229
	ld [hl], $01 ; $422c
	inc hl ; $422e
	ld [hl], $00 ; $422f
	inc hl ; $4231
	ld [hl], $08 ; $4232
	inc hl ; $4234
	ld [hl], $00 ; $4235
	inc hl ; $4237
	ld [hl], $03 ; $4238
	ld hl, $a221 ; $423a
	ld [hl], $01 ; $423d
	inc hl ; $423f
	ld [hl], $00 ; $4240
	inc hl ; $4242
	ld [hl], $0b ; $4243
	inc hl ; $4245
	ld [hl], $00 ; $4246
	inc hl ; $4248
	ld [hl], $02 ; $4249
	ld hl, $a231 ; $424b
	ld [hl], $01 ; $424e
	inc hl ; $4250
	ld [hl], $00 ; $4251
	inc hl ; $4253
	ld [hl], $0d ; $4254
	inc hl ; $4256
	ld [hl], $00 ; $4257
	inc hl ; $4259
	ld [hl], $03 ; $425a
	ld hl, $a241 ; $425c
	ld [hl], $01 ; $425f
	inc hl ; $4261
	ld [hl], $00 ; $4262
	inc hl ; $4264
	ld [hl], $10 ; $4265
	inc hl ; $4267
	ld [hl], $00 ; $4268
	inc hl ; $426a
	ld [hl], $02 ; $426b
	ld hl, $a251 ; $426d
	ld [hl], $01 ; $4270
	inc hl ; $4272
	ld [hl], $00 ; $4273
	inc hl ; $4275
	ld [hl], $12 ; $4276
	inc hl ; $4278
	ld [hl], $00 ; $4279
	inc hl ; $427b
	ld [hl], $03 ; $427c
	ld hl, $a261 ; $427e
	ld [hl], $01 ; $4281
	inc hl ; $4283
	ld [hl], $00 ; $4284
	inc hl ; $4286
	ld [hl], $15 ; $4287
	inc hl ; $4289
	ld [hl], $00 ; $428a
	inc hl ; $428c
	ld [hl], $02 ; $428d
	ld hl, $a271 ; $428f
	ld [hl], $01 ; $4292
	inc hl ; $4294
	ld [hl], $00 ; $4295
	inc hl ; $4297
	ld [hl], $17 ; $4298
	inc hl ; $429a
	ld [hl], $30 ; $429b
	inc hl ; $429d
	ld [hl], $00 ; $429e
	ld hl, $a281 ; $42a0
	ld [hl], $01 ; $42a3
	inc hl ; $42a5
	ld [hl], $30 ; $42a6
	inc hl ; $42a8
	ld [hl], $17 ; $42a9
	inc hl ; $42ab
	ld [hl], $20 ; $42ac
	inc hl ; $42ae
	ld [hl], $00 ; $42af
	ld hl, $a291 ; $42b1
	ld [hl], $01 ; $42b4
	inc hl ; $42b6
	ld [hl], $50 ; $42b7
	inc hl ; $42b9
	ld [hl], $17 ; $42ba
	inc hl ; $42bc
	ld [hl], $20 ; $42bd
	inc hl ; $42bf
	ld [hl], $00 ; $42c0
	ld hl, $a2a1 ; $42c2
	ld [hl], $01 ; $42c5
	inc hl ; $42c7
	ld [hl], $70 ; $42c8
	inc hl ; $42ca
	ld [hl], $17 ; $42cb
	inc hl ; $42cd
	ld [hl], $20 ; $42ce
	inc hl ; $42d0
	ld [hl], $00 ; $42d1
	ld hl, $a2b1 ; $42d3
	ld [hl], $01 ; $42d6
	inc hl ; $42d8
	ld [hl], $90 ; $42d9
	inc hl ; $42db
	ld [hl], $17 ; $42dc
	inc hl ; $42de
	ld [hl], $10 ; $42df
	inc hl ; $42e1
	ld [hl], $00 ; $42e2
	ld hl, $a2c1 ; $42e4
	ld [hl], $01 ; $42e7
	inc hl ; $42e9
	ld [hl], $00 ; $42ea
	inc hl ; $42ec
	ld [hl], $18 ; $42ed
	inc hl ; $42ef
	ld [hl], $80 ; $42f0
	inc hl ; $42f2
	ld [hl], $00 ; $42f3
	ld hl, $a2d1 ; $42f5
	ld [hl], $01 ; $42f8
	inc hl ; $42fa
	ld [hl], $80 ; $42fb
	inc hl ; $42fd
	ld [hl], $18 ; $42fe
	inc hl ; $4300
	ld [hl], $80 ; $4301
	inc hl ; $4303
	ld [hl], $00 ; $4304
	ld hl, $a2e1 ; $4306
	ld [hl], $01 ; $4309
	inc hl ; $430b
	ld [hl], $00 ; $430c
	inc hl ; $430e
	ld [hl], $19 ; $430f
	inc hl ; $4311
	ld [hl], $80 ; $4312
	inc hl ; $4314
	ld [hl], $00 ; $4315
	ld hl, $a2f1 ; $4317
	ld [hl], $01 ; $431a
	inc hl ; $431c
	ld [hl], $80 ; $431d
	inc hl ; $431f
	ld [hl], $19 ; $4320
	inc hl ; $4322
	ld [hl], $80 ; $4323
	inc hl ; $4325
	ld [hl], $00 ; $4326
	ld hl, $a301 ; $4328
	ld [hl], $01 ; $432b
	inc hl ; $432d
	ld [hl], $00 ; $432e
	inc hl ; $4330
	ld [hl], $1a ; $4331
	inc hl ; $4333
	ld [hl], $80 ; $4334
	inc hl ; $4336
	ld [hl], $00 ; $4337
	ld hl, $a311 ; $4339
	ld [hl], $01 ; $433c
	inc hl ; $433e
	ld [hl], $80 ; $433f
	inc hl ; $4341
	ld [hl], $1a ; $4342
	inc hl ; $4344
	ld [hl], $80 ; $4345
	inc hl ; $4347
	ld [hl], $00 ; $4348
	ld hl, $a321 ; $434a
	ld [hl], $01 ; $434d
	inc hl ; $434f
	ld [hl], $00 ; $4350
	inc hl ; $4352
	ld [hl], $1b ; $4353
	inc hl ; $4355
	ld [hl], $80 ; $4356
	inc hl ; $4358
	ld [hl], $00 ; $4359
	ld hl, $a331 ; $435b
	ld [hl], $01 ; $435e
	inc hl ; $4360
	ld [hl], $80 ; $4361
	inc hl ; $4363
	ld [hl], $1b ; $4364
	inc hl ; $4366
	ld [hl], $80 ; $4367
	inc hl ; $4369
	ld [hl], $00 ; $436a
	ld hl, $a341 ; $436c
	ld [hl], $01 ; $436f
	inc hl ; $4371
	ld [hl], $00 ; $4372
	inc hl ; $4374
	ld [hl], $1c ; $4375
	inc hl ; $4377
	ld [hl], $80 ; $4378
	inc hl ; $437a
	ld [hl], $00 ; $437b
	ld hl, $a351 ; $437d
	ld [hl], $01 ; $4380
	inc hl ; $4382
	ld [hl], $80 ; $4383
	inc hl ; $4385
	ld [hl], $1c ; $4386
	inc hl ; $4388
	ld [hl], $80 ; $4389
	inc hl ; $438b
	ld [hl], $00 ; $438c
	ld hl, $a361 ; $438e
	ld [hl], $01 ; $4391
	inc hl ; $4393
	ld [hl], $00 ; $4394
	inc hl ; $4396
	ld [hl], $1d ; $4397
	inc hl ; $4399
	ld [hl], $80 ; $439a
	inc hl ; $439c
	ld [hl], $00 ; $439d
	ld hl, $a371 ; $439f
	ld [hl], $01 ; $43a2
	inc hl ; $43a4
	ld [hl], $80 ; $43a5
	inc hl ; $43a7
	ld [hl], $1d ; $43a8
	inc hl ; $43aa
	ld [hl], $80 ; $43ab
	inc hl ; $43ad
	ld [hl], $00 ; $43ae
	ld hl, $a381 ; $43b0
	ld [hl], $01 ; $43b3
	inc hl ; $43b5
	ld [hl], $00 ; $43b6
	inc hl ; $43b8
	ld [hl], $1e ; $43b9
	inc hl ; $43bb
	ld [hl], $80 ; $43bc
	inc hl ; $43be
	ld [hl], $00 ; $43bf
	ld hl, $a391 ; $43c1
	ld [hl], $01 ; $43c4
	inc hl ; $43c6
	ld [hl], $80 ; $43c7
	inc hl ; $43c9
	ld [hl], $1e ; $43ca
	inc hl ; $43cc
	ld [hl], $80 ; $43cd
	inc hl ; $43cf
	ld [hl], $00 ; $43d0
	ld hl, $a3a1 ; $43d2
	ld [hl], $01 ; $43d5
	inc hl ; $43d7
	ld [hl], $00 ; $43d8
	inc hl ; $43da
	ld [hl], $1f ; $43db
	inc hl ; $43dd
	ld [hl], $80 ; $43de
	inc hl ; $43e0
	ld [hl], $00 ; $43e1
	ld hl, $a3b1 ; $43e3
	ld [hl], $01 ; $43e6
	inc hl ; $43e8
	ld [hl], $80 ; $43e9
	inc hl ; $43eb
	ld [hl], $1f ; $43ec
	inc hl ; $43ee
	ld [hl], $80 ; $43ef
	inc hl ; $43f1
	ld [hl], $00 ; $43f2
	ld hl, $a3c1 ; $43f4
	ld [hl], $02 ; $43f7
	inc hl ; $43f9
	ld [hl], $00 ; $43fa
	inc hl ; $43fc
	ld [hl], $00 ; $43fd
	inc hl ; $43ff
	ld [hl], $00 ; $4400
	inc hl ; $4402
	ld [hl], $03 ; $4403
	ld hl, $a3d1 ; $4405
	ld [hl], $02 ; $4408
	inc hl ; $440a
	ld [hl], $00 ; $440b
	inc hl ; $440d
	ld [hl], $03 ; $440e
	inc hl ; $4410
	ld [hl], $00 ; $4411
	inc hl ; $4413
	ld [hl], $03 ; $4414
	ld hl, $a3e1 ; $4416
	ld [hl], $02 ; $4419
	inc hl ; $441b
	ld [hl], $00 ; $441c
	inc hl ; $441e
	ld [hl], $06 ; $441f
	inc hl ; $4421
	ld [hl], $20 ; $4422
	inc hl ; $4424
	ld [hl], $00 ; $4425
	ld hl, $a3f1 ; $4427
	ld [hl], $02 ; $442a
	inc hl ; $442c
	ld [hl], $20 ; $442d
	inc hl ; $442f
	ld [hl], $06 ; $4430
	inc hl ; $4432
	ld [hl], $20 ; $4433
	inc hl ; $4435
	ld [hl], $00 ; $4436
	ld hl, $a401 ; $4438
	ld [hl], $02 ; $443b
	inc hl ; $443d
	ld [hl], $40 ; $443e
	inc hl ; $4440
	ld [hl], $06 ; $4441
	inc hl ; $4443
	ld [hl], $20 ; $4444
	inc hl ; $4446
	ld [hl], $00 ; $4447
	ld hl, $a411 ; $4449
	ld [hl], $02 ; $444c
	inc hl ; $444e
	ld [hl], $60 ; $444f
	inc hl ; $4451
	ld [hl], $06 ; $4452
	inc hl ; $4454
	ld [hl], $20 ; $4455
	inc hl ; $4457
	ld [hl], $00 ; $4458
	ld hl, $a421 ; $445a
	ld [hl], $02 ; $445d
	inc hl ; $445f
	ld [hl], $80 ; $4460
	inc hl ; $4462
	ld [hl], $06 ; $4463
	inc hl ; $4465
	ld [hl], $20 ; $4466
	inc hl ; $4468
	ld [hl], $00 ; $4469
	ld hl, $a431 ; $446b
	ld [hl], $02 ; $446e
	inc hl ; $4470
	ld [hl], $a0 ; $4471
	inc hl ; $4473
	ld [hl], $06 ; $4474
	inc hl ; $4476
	ld [hl], $20 ; $4477
	inc hl ; $4479
	ld [hl], $00 ; $447a
	ld hl, $a441 ; $447c
	ld [hl], $02 ; $447f
	inc hl ; $4481
	ld [hl], $c0 ; $4482
	inc hl ; $4484
	ld [hl], $06 ; $4485
	inc hl ; $4487
	ld [hl], $60 ; $4488
	inc hl ; $448a
	ld [hl], $00 ; $448b
	ld hl, $a451 ; $448d
	ld [hl], $02 ; $4490
	inc hl ; $4492
	ld [hl], $20 ; $4493
	inc hl ; $4495
	ld [hl], $07 ; $4496
	inc hl ; $4498
	ld [hl], $a0 ; $4499
	inc hl ; $449b
	ld [hl], $0d ; $449c
	ld hl, $a461 ; $449e
	ld [hl], $02 ; $44a1
	inc hl ; $44a3
	ld [hl], $c0 ; $44a4
	inc hl ; $44a6
	ld [hl], $14 ; $44a7
	inc hl ; $44a9
	ld [hl], $c0 ; $44aa
	inc hl ; $44ac
	ld [hl], $06 ; $44ad
	ld hl, $a471 ; $44af
	ld [hl], $02 ; $44b2
	inc hl ; $44b4
	ld [hl], $80 ; $44b5
	inc hl ; $44b7
	ld [hl], $1b ; $44b8
	inc hl ; $44ba
	ld [hl], $80 ; $44bb
	inc hl ; $44bd
	ld [hl], $00 ; $44be
	ld hl, $a481 ; $44c0
	ld [hl], $02 ; $44c3
	inc hl ; $44c5
	ld [hl], $00 ; $44c6
	inc hl ; $44c8
	ld [hl], $1c ; $44c9
	inc hl ; $44cb
	ld [hl], $80 ; $44cc
	inc hl ; $44ce
	ld [hl], $00 ; $44cf
	ld hl, $a491 ; $44d1
	ld [hl], $02 ; $44d4
	inc hl ; $44d6
	ld [hl], $80 ; $44d7
	inc hl ; $44d9
	ld [hl], $1c ; $44da
	inc hl ; $44dc
	ld [hl], $80 ; $44dd
	inc hl ; $44df
	ld [hl], $00 ; $44e0
	ld hl, $a4a1 ; $44e2
	ld [hl], $02 ; $44e5
	inc hl ; $44e7
	ld [hl], $00 ; $44e8
	inc hl ; $44ea
	ld [hl], $1d ; $44eb
	inc hl ; $44ed
	ld [hl], $80 ; $44ee
	inc hl ; $44f0
	ld [hl], $00 ; $44f1
	ld hl, $a4b1 ; $44f3
	ld [hl], $02 ; $44f6
	inc hl ; $44f8
	ld [hl], $80 ; $44f9
	inc hl ; $44fb
	ld [hl], $1d ; $44fc
	inc hl ; $44fe
	ld [hl], $80 ; $44ff
	inc hl ; $4501
	ld [hl], $00 ; $4502
	ld hl, $a4c1 ; $4504
	ld [hl], $02 ; $4507
	inc hl ; $4509
	ld [hl], $00 ; $450a
	inc hl ; $450c
	ld [hl], $1e ; $450d
	inc hl ; $450f
	ld [hl], $80 ; $4510
	inc hl ; $4512
	ld [hl], $00 ; $4513
	ld hl, $a4d1 ; $4515
	ld [hl], $02 ; $4518
	inc hl ; $451a
	ld [hl], $80 ; $451b
	inc hl ; $451d
	ld [hl], $1e ; $451e
	inc hl ; $4520
	ld [hl], $80 ; $4521
	inc hl ; $4523
	ld [hl], $00 ; $4524
	ld hl, $a4e1 ; $4526
	ld [hl], $02 ; $4529
	inc hl ; $452b
	ld [hl], $00 ; $452c
	inc hl ; $452e
	ld [hl], $1f ; $452f
	inc hl ; $4531
	ld [hl], $80 ; $4532
	inc hl ; $4534
	ld [hl], $00 ; $4535
	ld hl, $a4f1 ; $4537
	ld [hl], $02 ; $453a
	inc hl ; $453c
	ld [hl], $80 ; $453d
	inc hl ; $453f
	ld [hl], $1f ; $4540
	inc hl ; $4542
	ld [hl], $80 ; $4543
	inc hl ; $4545
	ld [hl], $00 ; $4546
	ld hl, $a501 ; $4548
	ld [hl], $03 ; $454b
	inc hl ; $454d
	ld [hl], $00 ; $454e
	inc hl ; $4550
	ld [hl], $00 ; $4551
	inc hl ; $4553
	ld [hl], $00 ; $4554
	inc hl ; $4556
	ld [hl], $01 ; $4557
	ld hl, $a511 ; $4559
	ld [hl], $03 ; $455c
	inc hl ; $455e
	ld [hl], $00 ; $455f
	inc hl ; $4561
	ld [hl], $01 ; $4562
	inc hl ; $4564
	ld [hl], $00 ; $4565
	inc hl ; $4567
	ld [hl], $01 ; $4568
	ld hl, $a521 ; $456a
	ld [hl], $03 ; $456d
	inc hl ; $456f
	ld [hl], $00 ; $4570
	inc hl ; $4572
	ld [hl], $02 ; $4573
	inc hl ; $4575
	ld [hl], $00 ; $4576
	inc hl ; $4578
	ld [hl], $01 ; $4579
	ld hl, $a531 ; $457b
	ld [hl], $03 ; $457e
	inc hl ; $4580
	ld [hl], $00 ; $4581
	inc hl ; $4583
	ld [hl], $03 ; $4584
	inc hl ; $4586
	ld [hl], $00 ; $4587
	inc hl ; $4589
	ld [hl], $01 ; $458a
	ld hl, $a541 ; $458c
	ld [hl], $03 ; $458f
	inc hl ; $4591
	ld [hl], $00 ; $4592
	inc hl ; $4594
	ld [hl], $04 ; $4595
	inc hl ; $4597
	ld [hl], $00 ; $4598
	inc hl ; $459a
	ld [hl], $01 ; $459b
	ld hl, $a551 ; $459d
	ld [hl], $03 ; $45a0
	inc hl ; $45a2
	ld [hl], $00 ; $45a3
	inc hl ; $45a5
	ld [hl], $05 ; $45a6
	inc hl ; $45a8
	ld [hl], $00 ; $45a9
	inc hl ; $45ab
	ld [hl], $02 ; $45ac
	ld hl, $a561 ; $45ae
	ld [hl], $03 ; $45b1
	inc hl ; $45b3
	ld [hl], $00 ; $45b4
	inc hl ; $45b6
	ld [hl], $07 ; $45b7
	inc hl ; $45b9
	ld [hl], $00 ; $45ba
	inc hl ; $45bc
	ld [hl], $01 ; $45bd
	ld hl, $a571 ; $45bf
	ld [hl], $03 ; $45c2
	inc hl ; $45c4
	ld [hl], $00 ; $45c5
	inc hl ; $45c7
	ld [hl], $08 ; $45c8
	inc hl ; $45ca
	ld [hl], $00 ; $45cb
	inc hl ; $45cd
	ld [hl], $01 ; $45ce
	ld hl, $a581 ; $45d0
	ld [hl], $03 ; $45d3
	inc hl ; $45d5
	ld [hl], $00 ; $45d6
	inc hl ; $45d8
	ld [hl], $09 ; $45d9
	inc hl ; $45db
	ld [hl], $00 ; $45dc
	inc hl ; $45de
	ld [hl], $01 ; $45df
	ld hl, $a591 ; $45e1
	ld [hl], $03 ; $45e4
	inc hl ; $45e6
	ld [hl], $00 ; $45e7
	inc hl ; $45e9
	ld [hl], $0a ; $45ea
	inc hl ; $45ec
	ld [hl], $00 ; $45ed
	inc hl ; $45ef
	ld [hl], $01 ; $45f0
	ld hl, $a5a1 ; $45f2
	ld [hl], $03 ; $45f5
	inc hl ; $45f7
	ld [hl], $00 ; $45f8
	inc hl ; $45fa
	ld [hl], $0b ; $45fb
	inc hl ; $45fd
	ld [hl], $00 ; $45fe
	inc hl ; $4600
	ld [hl], $01 ; $4601
	ld hl, $a5b1 ; $4603
	ld [hl], $03 ; $4606
	inc hl ; $4608
	ld [hl], $00 ; $4609
	inc hl ; $460b
	ld [hl], $0c ; $460c
	inc hl ; $460e
	ld [hl], $00 ; $460f
	inc hl ; $4611
	ld [hl], $02 ; $4612
	ld hl, $a5c1 ; $4614
	ld [hl], $03 ; $4617
	inc hl ; $4619
	ld [hl], $00 ; $461a
	inc hl ; $461c
	ld [hl], $0e ; $461d
	inc hl ; $461f
	ld [hl], $00 ; $4620
	inc hl ; $4622
	ld [hl], $02 ; $4623
	ld hl, $a5d1 ; $4625
	ld [hl], $03 ; $4628
	inc hl ; $462a
	ld [hl], $00 ; $462b
	inc hl ; $462d
	ld [hl], $10 ; $462e
	inc hl ; $4630
	ld [hl], $00 ; $4631
	inc hl ; $4633
	ld [hl], $05 ; $4634
	ld hl, $a5e1 ; $4636
	ld [hl], $04 ; $4639
	inc hl ; $463b
	ld [hl], $00 ; $463c
	inc hl ; $463e
	ld [hl], $00 ; $463f
	inc hl ; $4641
	ld [hl], $00 ; $4642
	inc hl ; $4644
	ld [hl], $01 ; $4645
	ld hl, $a5f1 ; $4647
	ld [hl], $04 ; $464a
	inc hl ; $464c
	ld [hl], $00 ; $464d
	inc hl ; $464f
	ld [hl], $01 ; $4650
	inc hl ; $4652
	ld [hl], $00 ; $4653
	inc hl ; $4655
	ld [hl], $01 ; $4656
	ld hl, $a601 ; $4658
	ld [hl], $04 ; $465b
	inc hl ; $465d
	ld [hl], $00 ; $465e
	inc hl ; $4660
	ld [hl], $02 ; $4661
	inc hl ; $4663
	ld [hl], $00 ; $4664
	inc hl ; $4666
	ld [hl], $01 ; $4667
	ld hl, $a611 ; $4669
	ld [hl], $04 ; $466c
	inc hl ; $466e
	ld [hl], $00 ; $466f
	inc hl ; $4671
	ld [hl], $03 ; $4672
	inc hl ; $4674
	ld [hl], $00 ; $4675
	inc hl ; $4677
	ld [hl], $01 ; $4678
	ld hl, $a621 ; $467a
	ld [hl], $04 ; $467d
	inc hl ; $467f
	ld [hl], $00 ; $4680
	inc hl ; $4682
	ld [hl], $04 ; $4683
	inc hl ; $4685
	ld [hl], $00 ; $4686
	inc hl ; $4688
	ld [hl], $01 ; $4689
	ld hl, $a631 ; $468b
	ld [hl], $04 ; $468e
	inc hl ; $4690
	ld [hl], $00 ; $4691
	inc hl ; $4693
	ld [hl], $05 ; $4694
	inc hl ; $4696
	ld [hl], $00 ; $4697
	inc hl ; $4699
	ld [hl], $02 ; $469a
	ld hl, $a641 ; $469c
	ld [hl], $04 ; $469f
	inc hl ; $46a1
	ld [hl], $00 ; $46a2
	inc hl ; $46a4
	ld [hl], $07 ; $46a5
	inc hl ; $46a7
	ld [hl], $00 ; $46a8
	inc hl ; $46aa
	ld [hl], $05 ; $46ab
	ld hl, $a651 ; $46ad
	ld [hl], $04 ; $46b0
	inc hl ; $46b2
	ld [hl], $00 ; $46b3
	inc hl ; $46b5
	ld [hl], $0c ; $46b6
	inc hl ; $46b8
	ld [hl], $00 ; $46b9
	inc hl ; $46bb
	ld [hl], $05 ; $46bc
	ld hl, $a661 ; $46be
	ld [hl], $04 ; $46c1
	inc hl ; $46c3
	ld [hl], $00 ; $46c4
	inc hl ; $46c6
	ld [hl], $11 ; $46c7
	inc hl ; $46c9
	ld [hl], $00 ; $46ca
	inc hl ; $46cc
	ld [hl], $05 ; $46cd
	ld hl, $a671 ; $46cf
	ld [hl], $04 ; $46d2
	inc hl ; $46d4
	ld [hl], $00 ; $46d5
	inc hl ; $46d7
	ld [hl], $16 ; $46d8
	inc hl ; $46da
	ld [hl], $00 ; $46db
	inc hl ; $46dd
	ld [hl], $05 ; $46de
	ld hl, $a681 ; $46e0
	ld [hl], $05 ; $46e3
	inc hl ; $46e5
	ld [hl], $00 ; $46e6
	inc hl ; $46e8
	ld [hl], $00 ; $46e9
	inc hl ; $46eb
	ld [hl], $00 ; $46ec
	inc hl ; $46ee
	ld [hl], $15 ; $46ef
	ld hl, $a691 ; $46f1
	ld [hl], $05 ; $46f4
	inc hl ; $46f6
	ld [hl], $00 ; $46f7
	inc hl ; $46f9
	ld [hl], $15 ; $46fa
	inc hl ; $46fc
	ld [hl], $00 ; $46fd
	inc hl ; $46ff
	ld [hl], $02 ; $4700
	ld hl, $a6a1 ; $4702
	ld [hl], $05 ; $4705
	inc hl ; $4707
	ld [hl], $00 ; $4708
	inc hl ; $470a
	ld [hl], $17 ; $470b
	inc hl ; $470d
	ld [hl], $00 ; $470e
	inc hl ; $4710
	ld [hl], $02 ; $4711
	ld hl, $a6b1 ; $4713
	ld [hl], $05 ; $4716
	inc hl ; $4718
	ld [hl], $00 ; $4719
	inc hl ; $471b
	ld [hl], $19 ; $471c
	inc hl ; $471e
	ld [hl], $00 ; $471f
	inc hl ; $4721
	ld [hl], $02 ; $4722
	ld hl, $a6c1 ; $4724
	ld [hl], $05 ; $4727
	inc hl ; $4729
	ld [hl], $00 ; $472a
	inc hl ; $472c
	ld [hl], $1b ; $472d
	inc hl ; $472f
	ld [hl], $00 ; $4730
	inc hl ; $4732
	ld [hl], $02 ; $4733
	ld hl, $a6d1 ; $4735
	ld [hl], $05 ; $4738
	inc hl ; $473a
	ld [hl], $00 ; $473b
	inc hl ; $473d
	ld [hl], $1d ; $473e
	inc hl ; $4740
	ld [hl], $00 ; $4741
	inc hl ; $4743
	ld [hl], $02 ; $4744
	ld hl, $a6e1 ; $4746
	ld [hl], $06 ; $4749
	inc hl ; $474b
	ld [hl], $00 ; $474c
	inc hl ; $474e
	ld [hl], $00 ; $474f
	inc hl ; $4751
	ld [hl], $00 ; $4752
	inc hl ; $4754
	ld [hl], $1e ; $4755
	ld hl, $a6f1 ; $4757
	ld [hl], $07 ; $475a
	inc hl ; $475c
	ld [hl], $00 ; $475d
	inc hl ; $475f
	ld [hl], $00 ; $4760
	inc hl ; $4762
	ld [hl], $00 ; $4763
	inc hl ; $4765
	ld [hl], $1e ; $4766
	ld hl, $a701 ; $4768
	ld [hl], $08 ; $476b
	inc hl ; $476d
	ld [hl], $00 ; $476e
	inc hl ; $4770
	ld [hl], $00 ; $4771
	inc hl ; $4773
	ld [hl], $00 ; $4774
	inc hl ; $4776
	ld [hl], $1e ; $4777
	ld hl, $a711 ; $4779
	ld [hl], $09 ; $477c
	inc hl ; $477e
	ld [hl], $00 ; $477f
	inc hl ; $4781
	ld [hl], $00 ; $4782
	inc hl ; $4784
	ld [hl], $00 ; $4785
	inc hl ; $4787
	ld [hl], $1e ; $4788
	ld hl, $a721 ; $478a
	ld [hl], $0a ; $478d
	inc hl ; $478f
	ld [hl], $00 ; $4790
	inc hl ; $4792
	ld [hl], $00 ; $4793
	inc hl ; $4795
	ld [hl], $00 ; $4796
	inc hl ; $4798
	ld [hl], $1e ; $4799
	ld hl, $a731 ; $479b
	ld [hl], $0b ; $479e
	inc hl ; $47a0
	ld [hl], $00 ; $47a1
	inc hl ; $47a3
	ld [hl], $00 ; $47a4
	inc hl ; $47a6
	ld [hl], $00 ; $47a7
	inc hl ; $47a9
	ld [hl], $1e ; $47aa
	ld hl, $a741 ; $47ac
	ld [hl], $0c ; $47af
	inc hl ; $47b1
	ld [hl], $00 ; $47b2
	inc hl ; $47b4
	ld [hl], $00 ; $47b5
	inc hl ; $47b7
	ld [hl], $00 ; $47b8
	inc hl ; $47ba
	ld [hl], $1e ; $47bb
	ld hl, $a751 ; $47bd
	ld [hl], $0d ; $47c0
	inc hl ; $47c2
	ld [hl], $00 ; $47c3
	inc hl ; $47c5
	ld [hl], $00 ; $47c6
	inc hl ; $47c8
	ld [hl], $00 ; $47c9
	inc hl ; $47cb
	ld [hl], $1e ; $47cc
	ld hl, $a761 ; $47ce
	ld [hl], $0e ; $47d1
	inc hl ; $47d3
	ld [hl], $00 ; $47d4
	inc hl ; $47d6
	ld [hl], $00 ; $47d7
	inc hl ; $47d9
	ld [hl], $00 ; $47da
	inc hl ; $47dc
	ld [hl], $1e ; $47dd
	ld hl, $a038 ; $47df
	ld [hl], $71 ; $47e2
	pop hl ; $47e4
	pop de ; $47e5
	pop bc ; $47e6
	pop af ; $47e7
	ret ; $47e8
	INCBIN "data/bank_003/d_47e9.bin" ; $47e9, 16 bytes
Func_03_47f9:
	ld e, $00 ; $47f9
Label_03_47fb:
	ld a, e ; $47fb
	ldh [$ff97], a ; $47fc
	ld [$4000], a ; $47fe
	ld bc, $0200 ; $4801
	ld hl, $a000 ; $4804
	xor a, a ; $4807
Label_03_4808:
	ld [hl+], a ; $4808
	ld [hl+], a ; $4809
	ld [hl+], a ; $480a
	ld [hl+], a ; $480b
	ld [hl+], a ; $480c
	ld [hl+], a ; $480d
	ld [hl+], a ; $480e
	ld [hl+], a ; $480f
	ld [hl+], a ; $4810
	ld [hl+], a ; $4811
	ld [hl+], a ; $4812
	ld [hl+], a ; $4813
	ld [hl+], a ; $4814
	ld [hl+], a ; $4815
	ld [hl+], a ; $4816
	ld [hl+], a ; $4817
	dec c ; $4818
	jr nz, Label_03_4808 ; $4819
	dec b ; $481b
	jr nz, Label_03_4808 ; $481c
	inc e ; $481e
	ld a, e ; $481f
	cp a, $04 ; $4820
	jr c, Label_03_47fb ; $4822
	ret ; $4824
Func_03_4825:
	xor a, a ; $4825
	ldh [$ff97], a ; $4826
	ld [$4000], a ; $4828
	ld c, $02 ; $482b
	ld hl, $a040 ; $482d
Label_03_4830:
	ld [hl+], a ; $4830
	ld [hl+], a ; $4831
	ld [hl+], a ; $4832
	ld [hl+], a ; $4833
	ld [hl+], a ; $4834
	ld [hl+], a ; $4835
	ld [hl+], a ; $4836
	ld [hl+], a ; $4837
	ld [hl+], a ; $4838
	ld [hl+], a ; $4839
	ld [hl+], a ; $483a
	ld [hl+], a ; $483b
	ld [hl+], a ; $483c
	ld [hl+], a ; $483d
	ld [hl+], a ; $483e
	ld [hl+], a ; $483f
	dec c ; $4840
	jr nz, Label_03_4830 ; $4841
	ret ; $4843
Func_03_4844:
	push af ; $4844
	push de ; $4845
	push bc ; $4846
	xor a, a ; $4847
	ldh [$ff97], a ; $4848
	ld [$4000], a ; $484a
	ld h, a ; $484d
	ld l, a ; $484e
	ld de, $a038 ; $484f
	ld bc, $0838 ; $4852
Label_03_4855:
	ld a, [de] ; $4855
	inc de ; $4856
	add a, l ; $4857
	ld l, a ; $4858
	jr nc, Label_03_485c ; $4859
	inc h ; $485b
Label_03_485c:
	dec c ; $485c
	jr nz, Label_03_4855 ; $485d
	dec b ; $485f
	jr nz, Label_03_4855 ; $4860
	pop bc ; $4862
	pop de ; $4863
	pop af ; $4864
	ret ; $4865
Func_03_4866:
	push af ; $4866
	push bc ; $4867
	push de ; $4868
	push hl ; $4869
	call Func_03_4844 ; $486a
	ld a, l ; $486d
	ld [$a030], a ; $486e
	ld a, h ; $4871
	ld [$a031], a ; $4872
	add sp, -64 ; $4875
	ld hl, sp + 0 ; $4877
	ld d, h ; $4879
	ld e, l ; $487a
	ld hl, $a000 ; $487b
	ld c, $04 ; $487e
	push hl ; $4880
	push de ; $4881
	call CopyMemoryFast ; $4882
	ld a, $01 ; $4885
	ldh [$ff97], a ; $4887
	ld [$4000], a ; $4889
	ld c, $04 ; $488c
	pop hl ; $488e
	pop de ; $488f
	call CopyMemoryFast ; $4890
	add sp, 64 ; $4893
	ld a, $00 ; $4895
	ldh [$ff97], a ; $4897
	ld [$4000], a ; $4899
	pop hl ; $489c
	pop de ; $489d
	pop bc ; $489e
	pop af ; $489f
	ret ; $48a0
Func_03_48a1:
	push af ; $48a1
	push bc ; $48a2
	push de ; $48a3
	push hl ; $48a4
	call Func_03_4844 ; $48a5
	ld a, l ; $48a8
	ld [$a030], a ; $48a9
	ld a, h ; $48ac
	ld [$a031], a ; $48ad
	ld hl, $a000 ; $48b0
	ld de, $c600 ; $48b3
	ld c, $20 ; $48b6
	call CopyMemoryFast ; $48b8
	ld a, $01 ; $48bb
	ldh [$ff97], a ; $48bd
	ld [$4000], a ; $48bf
	ld hl, $c600 ; $48c2
	ld de, $a000 ; $48c5
	ld c, $20 ; $48c8
	call CopyMemoryFast ; $48ca
	ld a, $00 ; $48cd
	ldh [$ff97], a ; $48cf
	ld [$4000], a ; $48d1
	ld hl, $a200 ; $48d4
	ld de, $c600 ; $48d7
	ld c, $20 ; $48da
	call CopyMemoryFast ; $48dc
	ld a, $01 ; $48df
	ldh [$ff97], a ; $48e1
	ld [$4000], a ; $48e3
	ld hl, $c600 ; $48e6
	ld de, $a200 ; $48e9
	ld c, $20 ; $48ec
	call CopyMemoryFast ; $48ee
	ld a, $00 ; $48f1
	ldh [$ff97], a ; $48f3
	ld [$4000], a ; $48f5
	ld hl, $a400 ; $48f8
	ld de, $c600 ; $48fb
	ld c, $20 ; $48fe
	call CopyMemoryFast ; $4900
	ld a, $01 ; $4903
	ldh [$ff97], a ; $4905
	ld [$4000], a ; $4907
	ld hl, $c600 ; $490a
	ld de, $a400 ; $490d
	ld c, $20 ; $4910
	call CopyMemoryFast ; $4912
	ld a, $00 ; $4915
	ldh [$ff97], a ; $4917
	ld [$4000], a ; $4919
	ld hl, $a600 ; $491c
	ld de, $c600 ; $491f
	ld c, $20 ; $4922
	call CopyMemoryFast ; $4924
	ld a, $01 ; $4927
	ldh [$ff97], a ; $4929
	ld [$4000], a ; $492b
	ld hl, $c600 ; $492e
	ld de, $a600 ; $4931
	ld c, $20 ; $4934
	call CopyMemoryFast ; $4936
	ld a, $00 ; $4939
	ldh [$ff97], a ; $493b
	ld [$4000], a ; $493d
	pop hl ; $4940
	pop de ; $4941
	pop bc ; $4942
	pop af ; $4943
	ret ; $4944
Func_03_4945:
	push hl ; $4945
	push de ; $4946
	call Func_03_4844 ; $4947
	push hl ; $494a
	ld hl, $a030 ; $494b
	ld a, [hl+] ; $494e
	ld h, [hl] ; $494f
	ld l, a ; $4950
	pop de ; $4951
	ld a, l ; $4952
	sub a, e ; $4953
	ld l, a ; $4954
	ld a, h ; $4955
	sbc a, d ; $4956
	ld h, a ; $4957
	ld a, h ; $4958
	or a, l ; $4959
	pop de ; $495a
	pop hl ; $495b
	ret ; $495c
Func_03_495d:
	push hl ; $495d
	push de ; $495e
	push bc ; $495f
	ld a, $0a ; $4960
	ld [$0000], a ; $4962
	ld a, $00 ; $4965
	ldh [$ff97], a ; $4967
	ld [$4000], a ; $4969
	ld hl, $a020 ; $496c
	ld de, $47e9 ; $496f
	call Func_03_4a56 ; $4972
	jr nz, Label_03_4980 ; $4975
	call Func_03_4945 ; $4977
	jr nz, Label_03_4980 ; $497a
	xor a, a ; $497c
	jp Label_03_4a32 ; $497d
Label_03_4980:
	ld a, $01 ; $4980
	ldh [$ff97], a ; $4982
	ld [$4000], a ; $4984
	ld hl, $a000 ; $4987
	ld de, $c600 ; $498a
	ld c, $20 ; $498d
	call CopyMemoryFast ; $498f
	ld a, $00 ; $4992
	ldh [$ff97], a ; $4994
	ld [$4000], a ; $4996
	ld hl, $c600 ; $4999
	ld de, $a000 ; $499c
	ld c, $20 ; $499f
	call CopyMemoryFast ; $49a1
	ld a, $01 ; $49a4
	ldh [$ff97], a ; $49a6
	ld [$4000], a ; $49a8
	ld hl, $a200 ; $49ab
	ld de, $c600 ; $49ae
	ld c, $20 ; $49b1
	call CopyMemoryFast ; $49b3
	ld a, $00 ; $49b6
	ldh [$ff97], a ; $49b8
	ld [$4000], a ; $49ba
	ld hl, $c600 ; $49bd
	ld de, $a200 ; $49c0
	ld c, $20 ; $49c3
	call CopyMemoryFast ; $49c5
	ld a, $01 ; $49c8
	ldh [$ff97], a ; $49ca
	ld [$4000], a ; $49cc
	ld hl, $a400 ; $49cf
	ld de, $c600 ; $49d2
	ld c, $20 ; $49d5
	call CopyMemoryFast ; $49d7
	ld a, $00 ; $49da
	ldh [$ff97], a ; $49dc
	ld [$4000], a ; $49de
	ld hl, $c600 ; $49e1
	ld de, $a400 ; $49e4
	ld c, $20 ; $49e7
	call CopyMemoryFast ; $49e9
	ld a, $01 ; $49ec
	ldh [$ff97], a ; $49ee
	ld [$4000], a ; $49f0
	ld hl, $a600 ; $49f3
	ld de, $c600 ; $49f6
	ld c, $20 ; $49f9
	call CopyMemoryFast ; $49fb
	ld a, $00 ; $49fe
	ldh [$ff97], a ; $4a00
	ld [$4000], a ; $4a02
	ld hl, $c600 ; $4a05
	ld de, $a600 ; $4a08
	ld c, $20 ; $4a0b
	call CopyMemoryFast ; $4a0d
	ld hl, $a000 ; $4a10
	ld de, $47e9 ; $4a13
	call Func_03_4a56 ; $4a16
	jr nz, Label_03_4a24 ; $4a19
	call Func_03_4945 ; $4a1b
	jr nz, Label_03_4a24 ; $4a1e
	ld a, $01 ; $4a20
	jr Label_03_4a32 ; $4a22
Label_03_4a24:
	call Func_03_47f9 ; $4a24
	call Func_03_404a ; $4a27
	call Func_03_48a1 ; $4a2a
	call Func_03_519a ; $4a2d
	ld a, $ff ; $4a30
Label_03_4a32:
	push af ; $4a32
	xor a, a ; $4a33
	ld [$0000], a ; $4a34
	pop af ; $4a37
	pop bc ; $4a38
	pop de ; $4a39
	pop hl ; $4a3a
	ret ; $4a3b
Func_03_4a3c:
	ld a, $0a ; $4a3c
	ld [$0000], a ; $4a3e
	ld a, $00 ; $4a41
	ldh [$ff97], a ; $4a43
	ld [$4000], a ; $4a45
	call Func_03_47f9 ; $4a48
	call Func_03_404a ; $4a4b
	call Func_03_48a1 ; $4a4e
	xor a, a ; $4a51
	ld [$0000], a ; $4a52
	ret ; $4a55
Func_03_4a56:
	push de ; $4a56
	push hl ; $4a57
Label_03_4a58:
	ld a, [de] ; $4a58
	cp a, [hl] ; $4a59
	jr nz, Label_03_4a63 ; $4a5a
	or a, a ; $4a5c
	jr z, Label_03_4a65 ; $4a5d
	inc de ; $4a5f
	inc hl ; $4a60
	jr Label_03_4a58 ; $4a61
Label_03_4a63:
	ld a, $01 ; $4a63
Label_03_4a65:
	pop hl ; $4a65
	pop de ; $4a66
	or a, a ; $4a67
	ret ; $4a68
Func_03_4a69:
	push af ; $4a69
	push de ; $4a6a
	push hl ; $4a6b
Label_03_4a6c:
	ld a, [hl] ; $4a6c
	ld [de], a ; $4a6d
	or a, a ; $4a6e
	jr z, Label_03_4a75 ; $4a6f
	inc hl ; $4a71
	inc de ; $4a72
	jr Label_03_4a6c ; $4a73
Label_03_4a75:
	pop hl ; $4a75
	pop de ; $4a76
	pop af ; $4a77
	ret ; $4a78
Func_03_4a79:
	push hl ; $4a79
	ld l, a ; $4a7a
	ld h, $00 ; $4a7b
	add hl, hl ; $4a7d
	add hl, hl ; $4a7e
	add hl, hl ; $4a7f
	add hl, hl ; $4a80
	ld bc, $a060 ; $4a81
	add hl, bc ; $4a84
	ld b, h ; $4a85
	ld c, l ; $4a86
	pop hl ; $4a87
	ret ; $4a88
Func_03_4a89:
	push hl ; $4a89
	push de ; $4a8a
	push bc ; $4a8b
	ld a, $0a ; $4a8c
	ld [$0000], a ; $4a8e
	ld a, $00 ; $4a91
	ldh [$ff97], a ; $4a93
	ld [$4000], a ; $4a95
	call Func_03_404a ; $4a98
	push de ; $4a9b
	ld a, b ; $4a9c
	call Func_03_4a79 ; $4a9d
	push bc ; $4aa0
	push hl ; $4aa1
	ld hl, $0001 ; $4aa2
	add hl, bc ; $4aa5
	ld c, [hl] ; $4aa6
	push bc ; $4aa7
	inc hl ; $4aa8
	ld a, [hl+] ; $4aa9
	ld e, a ; $4aaa
	ld a, [hl+] ; $4aab
	ld d, a ; $4aac
	ld a, [hl+] ; $4aad
	ld b, [hl] ; $4aae
	ld c, a ; $4aaf
	ld hl, $a000 ; $4ab0
	add hl, de ; $4ab3
	ld d, h ; $4ab4
	ld e, l ; $4ab5
	pop hl ; $4ab6
	ld a, l ; $4ab7
	ldh [$ff97], a ; $4ab8
	ld [$4000], a ; $4aba
	pop hl ; $4abd
	push hl ; $4abe
	push bc ; $4abf
Label_03_4ac0:
	ld a, [hl+] ; $4ac0
	ld [de], a ; $4ac1
	inc de ; $4ac2
	dec bc ; $4ac3
	ld a, b ; $4ac4
	or a, c ; $4ac5
	jr nz, Label_03_4ac0 ; $4ac6
	pop bc ; $4ac8
	pop hl ; $4ac9
	ld de, $0000 ; $4aca
Label_03_4acd:
	ld a, [hl+] ; $4acd
	add a, e ; $4ace
	ld e, a ; $4acf
	ld a, d ; $4ad0
	adc a, $00 ; $4ad1
	ld d, a ; $4ad3
	dec bc ; $4ad4
	ld a, b ; $4ad5
	or a, c ; $4ad6
	jr nz, Label_03_4acd ; $4ad7
	ld a, $00 ; $4ad9
	ldh [$ff97], a ; $4adb
	ld [$4000], a ; $4add
	pop bc ; $4ae0
	ld a, $01 ; $4ae1
	ld [bc], a ; $4ae3
	ld hl, $0006 ; $4ae4
	add hl, bc ; $4ae7
	ld [hl], e ; $4ae8
	inc hl ; $4ae9
	ld [hl], d ; $4aea
	inc hl ; $4aeb
	pop de ; $4aec
	ld a, d ; $4aed
	ld [hl+], a ; $4aee
	ld a, e ; $4aef
	ld [hl+], a ; $4af0
	call Func_03_48a1 ; $4af1
	xor a, a ; $4af4
	push af ; $4af5
	xor a, a ; $4af6
	ld [$0000], a ; $4af7
	pop af ; $4afa
	pop bc ; $4afb
	pop de ; $4afc
	pop hl ; $4afd
	ret ; $4afe
Func_03_4aff:
	push hl ; $4aff
	push de ; $4b00
	push bc ; $4b01
	ld a, b ; $4b02
	cp a, $03 ; $4b03
	jr nc, Label_03_4b16 ; $4b05
	sla a ; $4b07
	ld b, a ; $4b09
	call Func_03_4b1c ; $4b0a
	or a, a ; $4b0d
	jr nz, Label_03_4b18 ; $4b0e
	inc b ; $4b10
	call Func_03_4b1c ; $4b11
	jr Label_03_4b18 ; $4b14
Label_03_4b16:
	ld a, $ff ; $4b16
Label_03_4b18:
	pop bc ; $4b18
	pop de ; $4b19
	pop hl ; $4b1a
	ret ; $4b1b
Func_03_4b1c:
	push hl ; $4b1c
	push de ; $4b1d
	push bc ; $4b1e
	ld a, $0a ; $4b1f
	ld [$0000], a ; $4b21
	ld a, $00 ; $4b24
	ldh [$ff97], a ; $4b26
	ld [$4000], a ; $4b28
	call Func_03_404a ; $4b2b
	ld a, b ; $4b2e
	call Func_03_4a79 ; $4b2f
	xor a, a ; $4b32
	ld [bc], a ; $4b33
	ld de, $0000 ; $4b34
	ld hl, $0006 ; $4b37
	add hl, bc ; $4b3a
	ld [hl], e ; $4b3b
	inc hl ; $4b3c
	ld [hl], d ; $4b3d
	inc hl ; $4b3e
	ld c, $08 ; $4b3f
	xor a, a ; $4b41
Label_03_4b42:
	ld [hl+], a ; $4b42
	dec c ; $4b43
	jr nz, Label_03_4b42 ; $4b44
	call Func_03_48a1 ; $4b46
	xor a, a ; $4b49
	push af ; $4b4a
	xor a, a ; $4b4b
	ld [$0000], a ; $4b4c
	pop af ; $4b4f
	pop bc ; $4b50
	pop de ; $4b51
	pop hl ; $4b52
	ret ; $4b53
Func_03_4b54:
	ld a, $00 ; $4b54
	ld [$c36c], a ; $4b56
	ld a, $00 ; $4b59
	call Func_03_4e13 ; $4b5b
	ld a, $01 ; $4b5e
	ld [$c36c], a ; $4b60
	ld a, $00 ; $4b63
	call Func_03_4e13 ; $4b65
	ld a, $02 ; $4b68
	ld [$c36c], a ; $4b6a
	ld a, $00 ; $4b6d
	call Func_03_4e13 ; $4b6f
	ld a, $00 ; $4b72
	ld [$c36c], a ; $4b74
	ld b, $36 ; $4b77
	call Func_03_4b1c ; $4b79
	ld b, $37 ; $4b7c
	call Func_03_4b1c ; $4b7e
	ld a, $0a ; $4b81
	ld [$0000], a ; $4b83
	ld a, $00 ; $4b86
	ldh [$ff97], a ; $4b88
	ld [$4000], a ; $4b8a
	call Func_03_4825 ; $4b8d
	call Func_03_404a ; $4b90
	call Func_03_48a1 ; $4b93
	xor a, a ; $4b96
	ld [$0000], a ; $4b97
	ret ; $4b9a
Func_03_4b9b:
	push hl ; $4b9b
	push de ; $4b9c
	push bc ; $4b9d
	ld a, $0a ; $4b9e
	ld [$0000], a ; $4ba0
	ld a, $00 ; $4ba3
	ldh [$ff97], a ; $4ba5
	ld [$4000], a ; $4ba7
	ld a, b ; $4baa
	call Func_03_4a79 ; $4bab
	ld a, [bc] ; $4bae
	or a, a ; $4baf
	jp nz, Label_03_4bb8 ; $4bb0
	ld a, $fe ; $4bb3
	jp Label_03_4c0a ; $4bb5
Label_03_4bb8:
	push bc ; $4bb8
	push hl ; $4bb9
	ld hl, $0001 ; $4bba
	add hl, bc ; $4bbd
	ld c, [hl] ; $4bbe
	push bc ; $4bbf
	inc hl ; $4bc0
	ld a, [hl+] ; $4bc1
	ld e, a ; $4bc2
	ld a, [hl+] ; $4bc3
	ld d, a ; $4bc4
	ld a, [hl+] ; $4bc5
	ld b, [hl] ; $4bc6
	ld c, a ; $4bc7
	ld hl, $a000 ; $4bc8
	add hl, de ; $4bcb
	ld d, h ; $4bcc
	ld e, l ; $4bcd
	pop hl ; $4bce
	ld a, l ; $4bcf
	ldh [$ff97], a ; $4bd0
	ld [$4000], a ; $4bd2
	pop hl ; $4bd5
	push hl ; $4bd6
	push bc ; $4bd7
Label_03_4bd8:
	ld a, [de] ; $4bd8
	ld [hl+], a ; $4bd9
	inc de ; $4bda
	dec bc ; $4bdb
	ld a, b ; $4bdc
	or a, c ; $4bdd
	jr nz, Label_03_4bd8 ; $4bde
	pop bc ; $4be0
	pop hl ; $4be1
	ld de, $0000 ; $4be2
Label_03_4be5:
	ld a, [hl+] ; $4be5
	add a, e ; $4be6
	ld e, a ; $4be7
	ld a, d ; $4be8
	adc a, $00 ; $4be9
	ld d, a ; $4beb
	dec bc ; $4bec
	ld a, b ; $4bed
	or a, c ; $4bee
	jr nz, Label_03_4be5 ; $4bef
	ld a, $00 ; $4bf1
	ldh [$ff97], a ; $4bf3
	ld [$4000], a ; $4bf5
	pop bc ; $4bf8
	ld hl, $0006 ; $4bf9
	add hl, bc ; $4bfc
	ld a, [hl+] ; $4bfd
	ld h, [hl] ; $4bfe
	ld l, a ; $4bff
	ld a, h ; $4c00
	xor a, d ; $4c01
	ld h, a ; $4c02
	ld a, l ; $4c03
	xor a, e ; $4c04
	or a, h ; $4c05
	jr z, Label_03_4c0a ; $4c06
	ld a, $ff ; $4c08
Label_03_4c0a:
	push af ; $4c0a
	xor a, a ; $4c0b
	ld [$0000], a ; $4c0c
	pop af ; $4c0f
	pop bc ; $4c10
	pop de ; $4c11
	pop hl ; $4c12
	ret ; $4c13
Func_03_4c14:
	push hl ; $4c14
	push de ; $4c15
	push bc ; $4c16
	ld a, $0a ; $4c17
	ld [$0000], a ; $4c19
	ld a, $00 ; $4c1c
	ldh [$ff97], a ; $4c1e
	ld [$4000], a ; $4c20
	ld a, b ; $4c23
	call Func_03_4a79 ; $4c24
	ld a, [bc] ; $4c27
	or a, a ; $4c28
	jp nz, Label_03_4c31 ; $4c29
	ld a, $fe ; $4c2c
	jp Label_03_4c94 ; $4c2e
Label_03_4c31:
	push bc ; $4c31
	push hl ; $4c32
	ld hl, $0001 ; $4c33
	add hl, bc ; $4c36
	ld c, [hl] ; $4c37
	push bc ; $4c38
	inc hl ; $4c39
	ld a, [hl+] ; $4c3a
	ld e, a ; $4c3b
	ld a, [hl+] ; $4c3c
	ld d, a ; $4c3d
	ld a, [hl+] ; $4c3e
	ld b, [hl] ; $4c3f
	ld c, a ; $4c40
	ld hl, $a000 ; $4c41
	add hl, de ; $4c44
	ld d, h ; $4c45
	ld e, l ; $4c46
	pop hl ; $4c47
	ld a, l ; $4c48
	ldh [$ff97], a ; $4c49
	ld [$4000], a ; $4c4b
	pop hl ; $4c4e
	push de ; $4c4f
	push bc ; $4c50
Label_03_4c51:
	ld a, [de] ; $4c51
	cp a, [hl] ; $4c52
	jr z, Label_03_4c63 ; $4c53
	ld a, $00 ; $4c55
	ldh [$ff97], a ; $4c57
	ld [$4000], a ; $4c59
	add sp, 6 ; $4c5c
	ld a, $fd ; $4c5e
	jp Label_03_4c94 ; $4c60
Label_03_4c63:
	inc hl ; $4c63
	inc de ; $4c64
	dec bc ; $4c65
	ld a, b ; $4c66
	or a, c ; $4c67
	jr nz, Label_03_4c51 ; $4c68
	pop bc ; $4c6a
	pop hl ; $4c6b
	ld de, $0000 ; $4c6c
Label_03_4c6f:
	ld a, [hl+] ; $4c6f
	add a, e ; $4c70
	ld e, a ; $4c71
	ld a, d ; $4c72
	adc a, $00 ; $4c73
	ld d, a ; $4c75
	dec bc ; $4c76
	ld a, b ; $4c77
	or a, c ; $4c78
	jr nz, Label_03_4c6f ; $4c79
	ld a, $00 ; $4c7b
	ldh [$ff97], a ; $4c7d
	ld [$4000], a ; $4c7f
	pop bc ; $4c82
	ld hl, $0006 ; $4c83
	add hl, bc ; $4c86
	ld a, [hl+] ; $4c87
	ld h, [hl] ; $4c88
	ld l, a ; $4c89
	ld a, h ; $4c8a
	xor a, d ; $4c8b
	ld h, a ; $4c8c
	ld a, l ; $4c8d
	xor a, e ; $4c8e
	or a, h ; $4c8f
	jr z, Label_03_4c94 ; $4c90
	ld a, $ff ; $4c92
Label_03_4c94:
	push af ; $4c94
	xor a, a ; $4c95
	ld [$0000], a ; $4c96
	pop af ; $4c99
	pop bc ; $4c9a
	pop de ; $4c9b
	pop hl ; $4c9c
	ret ; $4c9d
Func_03_4c9e:
	push hl ; $4c9e
	push de ; $4c9f
	push bc ; $4ca0
	ld a, $0a ; $4ca1
	ld [$0000], a ; $4ca3
	ld a, $00 ; $4ca6
	ldh [$ff97], a ; $4ca8
	ld [$4000], a ; $4caa
	ld a, b ; $4cad
	call Func_03_4a79 ; $4cae
	ld a, [bc] ; $4cb1
	or a, a ; $4cb2
	jp nz, Label_03_4cbb ; $4cb3
	ld a, $fe ; $4cb6
	jp Label_03_4cc9 ; $4cb8
Label_03_4cbb:
	ld a, $08 ; $4cbb
	add a, c ; $4cbd
	ld e, a ; $4cbe
	ld d, b ; $4cbf
	ld c, $08 ; $4cc0
Label_03_4cc2:
	ld a, [de] ; $4cc2
	ld [hl+], a ; $4cc3
	inc de ; $4cc4
	dec c ; $4cc5
	jr nz, Label_03_4cc2 ; $4cc6
	xor a, a ; $4cc8
Label_03_4cc9:
	push af ; $4cc9
	xor a, a ; $4cca
	ld [$0000], a ; $4ccb
	pop af ; $4cce
	pop bc ; $4ccf
	pop de ; $4cd0
	pop hl ; $4cd1
	ret ; $4cd2
	INCBIN "data/bank_003/d_4cd3.bin" ; $4cd3, 53 bytes
Func_03_4d08:
	ld a, [$c36c] ; $4d08
	cp a, $03 ; $4d0b
	ret nc ; $4d0d
	jr Label_03_4d19 ; $4d0e
Func_03_4d10:
	ld a, [$c36c] ; $4d10
	cp a, $03 ; $4d13
	ret nc ; $4d15
	call Func_00_2452 ; $4d16
Label_03_4d19:
	ld a, [$c36c] ; $4d19
	add a, a ; $4d1c
	ld b, a ; $4d1d
	ld hl, $c800 ; $4d1e
	ld de, $0000 ; $4d21
	call Func_03_4a89 ; $4d24
	or a, a ; $4d27
	ret nz ; $4d28
	ld a, [$c36c] ; $4d29
	add a, a ; $4d2c
	ld b, a ; $4d2d
	ld hl, $c800 ; $4d2e
	call Func_03_4c14 ; $4d31
	or a, a ; $4d34
	ret nz ; $4d35
	ld a, [$c36c] ; $4d36
	add a, a ; $4d39
	add a, $1b ; $4d3a
	ld b, a ; $4d3c
	ld hl, $c800 ; $4d3d
	ld de, $c600 ; $4d40
	call Func_03_4a89 ; $4d43
	or a, a ; $4d46
	ret nz ; $4d47
	ld a, [$c36c] ; $4d48
	add a, a ; $4d4b
	add a, $1b ; $4d4c
	ld b, a ; $4d4e
	ld hl, $c800 ; $4d4f
	call Func_03_4c14 ; $4d52
	or a, a ; $4d55
	ret nz ; $4d56
	call Func_03_56fb ; $4d57
	xor a, a ; $4d5a
	ret ; $4d5b
	INCBIN "data/bank_003/d_4d5c.bin" ; $4d5c, 8 bytes
Func_03_4d64:
	push bc ; $4d64
	push de ; $4d65
	push hl ; $4d66
	ld a, [$c36c] ; $4d67
	cp a, $03 ; $4d6a
	jr nc, Label_03_4d78 ; $4d6c
	add a, a ; $4d6e
	ld b, a ; $4d6f
	ld hl, $c800 ; $4d70
	call Func_03_4b9b ; $4d73
	jr Label_03_4d7a ; $4d76
Label_03_4d78:
	ld a, $fe ; $4d78
Label_03_4d7a:
	pop hl ; $4d7a
	pop de ; $4d7b
	pop bc ; $4d7c
	ret ; $4d7d
	INCBIN "data/bank_003/d_4d7e.bin" ; $4d7e, 8 bytes
Func_03_4d86:
	push hl ; $4d86
	push de ; $4d87
	push bc ; $4d88
	ld b, a ; $4d89
	ld a, $0a ; $4d8a
	ld [$0000], a ; $4d8c
	ld a, $00 ; $4d8f
	ldh [$ff97], a ; $4d91
	ld [$4000], a ; $4d93
	ld hl, $4d7e ; $4d96
	ld a, e ; $4d99
	rlca ; $4d9a
	rlca ; $4d9b
	rlca ; $4d9c
	add a, l ; $4d9d
	ld l, a ; $4d9e
	jr nc, Label_03_4da2 ; $4d9f
	inc h ; $4da1
Label_03_4da2:
	ld a, [hl] ; $4da2
	ld hl, $a040 ; $4da3
	ld e, d ; $4da6
	ld d, $00 ; $4da7
	add hl, de ; $4da9
	and a, [hl] ; $4daa
	push af ; $4dab
	xor a, a ; $4dac
	ld [$0000], a ; $4dad
	pop af ; $4db0
	ld a, b ; $4db1
	pop bc ; $4db2
	pop de ; $4db3
	pop hl ; $4db4
	ret ; $4db5
Func_03_4db6:
	push hl ; $4db6
	push af ; $4db7
	ld a, $0a ; $4db8
	ld [$0000], a ; $4dba
	ld a, $00 ; $4dbd
	ldh [$ff97], a ; $4dbf
	ld [$4000], a ; $4dc1
	ld hl, $4d7e ; $4dc4
	ld a, e ; $4dc7
	rlca ; $4dc8
	rlca ; $4dc9
	rlca ; $4dca
	add a, l ; $4dcb
	ld l, a ; $4dcc
	jr nc, Label_03_4dd0 ; $4dcd
	inc h ; $4dcf
Label_03_4dd0:
	ld a, [hl] ; $4dd0
	ld hl, $a040 ; $4dd1
	ld e, d ; $4dd4
	ld d, $00 ; $4dd5
	add hl, de ; $4dd7
	or a, [hl] ; $4dd8
	ld [hl], a ; $4dd9
	call Func_03_4866 ; $4dda
	xor a, a ; $4ddd
	ld [$0000], a ; $4dde
	pop af ; $4de1
	pop hl ; $4de2
	ret ; $4de3
Func_03_4de4:
	push hl ; $4de4
	push af ; $4de5
	ld a, $0a ; $4de6
	ld [$0000], a ; $4de8
	ld a, $00 ; $4deb
	ldh [$ff97], a ; $4ded
	ld [$4000], a ; $4def
	ld hl, $4d7e ; $4df2
	ld a, e ; $4df5
	rlca ; $4df6
	rlca ; $4df7
	rlca ; $4df8
	add a, l ; $4df9
	ld l, a ; $4dfa
	jr nc, Label_03_4dfe ; $4dfb
	inc h ; $4dfd
Label_03_4dfe:
	ld a, [hl] ; $4dfe
	ld hl, $a040 ; $4dff
	ld e, d ; $4e02
	ld d, $00 ; $4e03
	add hl, de ; $4e05
	cpl ; $4e06
	and a, [hl] ; $4e07
	ld [hl], a ; $4e08
	call Func_03_4866 ; $4e09
	xor a, a ; $4e0c
	ld [$0000], a ; $4e0d
	pop af ; $4e10
	pop hl ; $4e11
	ret ; $4e12
Func_03_4e13:
	push bc ; $4e13
	push de ; $4e14
	push hl ; $4e15
	ld h, a ; $4e16
	ld a, $0a ; $4e17
	ld [$0000], a ; $4e19
	call Func_03_404a ; $4e1c
	ld a, [$c36c] ; $4e1f
	cp a, $03 ; $4e22
	jp nc, Label_03_4e8a ; $4e24
	add a, a ; $4e27
	ld c, a ; $4e28
	ld a, $00 ; $4e29
	add a, c ; $4e2b
	ld b, a ; $4e2c
	call Func_03_4e90 ; $4e2d
	inc b ; $4e30
	call Func_03_4e90 ; $4e31
	ld a, $1b ; $4e34
	add a, c ; $4e36
	ld b, a ; $4e37
	call Func_03_4e90 ; $4e38
	inc b ; $4e3b
	call Func_03_4e90 ; $4e3c
	call Func_03_48a1 ; $4e3f
	xor a, a ; $4e42
	ld [$0000], a ; $4e43
	call Func_03_5141 ; $4e46
	ld a, [$c36c] ; $4e49
	or a, a ; $4e4c
	jr z, Label_03_4e65 ; $4e4d
	cp a, $01 ; $4e4f
	jr z, Label_03_4e77 ; $4e51
	push de ; $4e53
	ld de, $0440 ; $4e54
	farcall FarPtr_03_20 ; $4e57
	pop de ; $4e5a
	push de ; $4e5b
	ld de, $04c0 ; $4e5c
	farcall FarPtr_03_20 ; $4e5f
	pop de ; $4e62
	jr Label_03_4e87 ; $4e63
Label_03_4e65:
	push de ; $4e65
	ld de, $0400 ; $4e66
	farcall FarPtr_03_20 ; $4e69
	pop de ; $4e6c
	push de ; $4e6d
	ld de, $0480 ; $4e6e
	farcall FarPtr_03_20 ; $4e71
	pop de ; $4e74
	jr Label_03_4e87 ; $4e75
Label_03_4e77:
	push de ; $4e77
	ld de, $0420 ; $4e78
	farcall FarPtr_03_20 ; $4e7b
	pop de ; $4e7e
	push de ; $4e7f
	ld de, $04a0 ; $4e80
	farcall FarPtr_03_20 ; $4e83
	pop de ; $4e86
Label_03_4e87:
	xor a, a ; $4e87
	jr Label_03_4e8c ; $4e88
Label_03_4e8a:
	ld a, $01 ; $4e8a
Label_03_4e8c:
	pop hl ; $4e8c
	pop de ; $4e8d
	pop bc ; $4e8e
	ret ; $4e8f
Func_03_4e90:
	ld a, h ; $4e90
	or a, a ; $4e91
	jr nz, Label_03_4e99 ; $4e92
	call Func_03_4f57 ; $4e94
	jr Label_03_4e9c ; $4e97
Label_03_4e99:
	call Func_03_4e9d ; $4e99
Label_03_4e9c:
	ret ; $4e9c
Func_03_4e9d:
	push hl ; $4e9d
	push de ; $4e9e
	push bc ; $4e9f
	ld a, $00 ; $4ea0
	ldh [$ff97], a ; $4ea2
	ld [$4000], a ; $4ea4
	ld a, b ; $4ea7
	call Func_03_4a79 ; $4ea8
	push bc ; $4eab
	push hl ; $4eac
	ld hl, $0001 ; $4ead
	add hl, bc ; $4eb0
	ld c, [hl] ; $4eb1
	push bc ; $4eb2
	inc hl ; $4eb3
	ld a, [hl+] ; $4eb4
	ld e, a ; $4eb5
	ld a, [hl+] ; $4eb6
	ld d, a ; $4eb7
	ld a, [hl+] ; $4eb8
	ld b, [hl] ; $4eb9
	ld c, a ; $4eba
	ld hl, $a000 ; $4ebb
	add hl, de ; $4ebe
	ld d, h ; $4ebf
	ld e, l ; $4ec0
	pop hl ; $4ec1
	ld a, l ; $4ec2
	ldh [$ff97], a ; $4ec3
	ld [$4000], a ; $4ec5
	pop hl ; $4ec8
	push hl ; $4ec9
	push bc ; $4eca
Label_03_4ecb:
	xor a, a ; $4ecb
	ld [de], a ; $4ecc
	inc de ; $4ecd
	dec bc ; $4ece
	ld a, b ; $4ecf
	or a, c ; $4ed0
	jr nz, Label_03_4ecb ; $4ed1
	pop bc ; $4ed3
	pop hl ; $4ed4
	ld de, $0000 ; $4ed5
	ld a, $00 ; $4ed8
	ldh [$ff97], a ; $4eda
	ld [$4000], a ; $4edc
	pop bc ; $4edf
	ld a, $01 ; $4ee0
	ld [bc], a ; $4ee2
	ld hl, $0006 ; $4ee3
	add hl, bc ; $4ee6
	ld [hl], e ; $4ee7
	inc hl ; $4ee8
	ld [hl], d ; $4ee9
	inc hl ; $4eea
	ld c, $08 ; $4eeb
Label_03_4eed:
	xor a, a ; $4eed
	ld [hl+], a ; $4eee
	dec c ; $4eef
	jr nz, Label_03_4eed ; $4ef0
	xor a, a ; $4ef2
	pop bc ; $4ef3
	pop de ; $4ef4
	pop hl ; $4ef5
	ret ; $4ef6
	INCBIN "data/bank_003/d_4ef7.bin" ; $4ef7, 96 bytes
Func_03_4f57:
	push hl ; $4f57
	push de ; $4f58
	push bc ; $4f59
	ld a, $00 ; $4f5a
	ldh [$ff97], a ; $4f5c
	ld [$4000], a ; $4f5e
	ld a, b ; $4f61
	call Func_03_4a79 ; $4f62
	xor a, a ; $4f65
	ld [bc], a ; $4f66
	ld de, $0000 ; $4f67
	ld hl, $0006 ; $4f6a
	add hl, bc ; $4f6d
	ld [hl], e ; $4f6e
	inc hl ; $4f6f
	ld [hl], d ; $4f70
	inc hl ; $4f71
	ld c, $08 ; $4f72
	xor a, a ; $4f74
Label_03_4f75:
	ld [hl+], a ; $4f75
	dec c ; $4f76
	jr nz, Label_03_4f75 ; $4f77
	pop bc ; $4f79
	pop de ; $4f7a
	pop hl ; $4f7b
	ret ; $4f7c
Func_03_4f7d:
	push af ; $4f7d
	push bc ; $4f7e
	push de ; $4f7f
	push hl ; $4f80
	ldh a, [$ff96] ; $4f81
	push af ; $4f83
	ld a, $01 ; $4f84
	ldh [$ff96], a ; $4f86
	ldh [rWBK], a ; $4f88
	ld hl, $d000 ; $4f8a
	call Func_03_586f ; $4f8d
	ld b, a ; $4f90
	push bc ; $4f91
	call Func_03_4a3c ; $4f92
	pop bc ; $4f95
	ld a, b ; $4f96
	cp a, $fe ; $4f97
	jr z, Label_03_4fa1 ; $4f99
	ld hl, $d000 ; $4f9b
	call Func_03_5844 ; $4f9e
Label_03_4fa1:
	call Func_03_519a ; $4fa1
	pop af ; $4fa4
	ldh [$ff96], a ; $4fa5
	ldh [rWBK], a ; $4fa7
	pop hl ; $4fa9
	pop de ; $4faa
	pop bc ; $4fab
	pop af ; $4fac
	ret ; $4fad
Func_03_4fae:
	ld a, $36 ; $4fae
	ld b, a ; $4fb0
	ld hl, $c800 ; $4fb1
	ld de, $0000 ; $4fb4
	call Func_03_4a89 ; $4fb7
	or a, a ; $4fba
	ret nz ; $4fbb
	ld a, $36 ; $4fbc
	ld b, a ; $4fbe
	ld hl, $c800 ; $4fbf
	call Func_03_4c14 ; $4fc2
	or a, a ; $4fc5
	ret nz ; $4fc6
	ld a, $37 ; $4fc7
	ld b, a ; $4fc9
	ld hl, $c800 ; $4fca
	ld de, $c600 ; $4fcd
	call Func_03_4a89 ; $4fd0
	or a, a ; $4fd3
	ret nz ; $4fd4
	ld a, $37 ; $4fd5
	ld b, a ; $4fd7
	ld hl, $c800 ; $4fd8
	call Func_03_4c14 ; $4fdb
	or a, a ; $4fde
	ret nz ; $4fdf
	xor a, a ; $4fe0
	ret ; $4fe1
	INCBIN "data/bank_003/d_4fe2.bin" ; $4fe2, 8 bytes
Func_03_4fea:
	push bc ; $4fea
	push de ; $4feb
	push hl ; $4fec
	ld a, $36 ; $4fed
	ld b, a ; $4fef
	ld hl, $c800 ; $4ff0
	call Func_03_4b9b ; $4ff3
	jr Label_03_4ffa ; $4ff6
	INCBIN "data/bank_003/d_4ff8.bin" ; $4ff8, 2 bytes
Label_03_4ffa:
	pop hl ; $4ffa
	pop de ; $4ffb
	pop bc ; $4ffc
	ret ; $4ffd
Func_03_4ffe:
	push bc ; $4ffe
	push de ; $4fff
	push hl ; $5000
	ld a, $0a ; $5001
	ld [$0000], a ; $5003
	ld b, $0b ; $5006
	call Func_03_4e9d ; $5008
	push af ; $500b
	xor a, a ; $500c
	ld [$0000], a ; $500d
	pop af ; $5010
	pop hl ; $5011
	pop de ; $5012
	pop bc ; $5013
	ret ; $5014
Func_03_5015:
	push af ; $5015
	push bc ; $5016
	push de ; $5017
	push hl ; $5018
	ld b, a ; $5019
	ldh a, [$ff96] ; $501a
	push af ; $501c
	ld a, $07 ; $501d
	ldh [$ff96], a ; $501f
	ldh [rWBK], a ; $5021
	ld a, b ; $5023
	sub a, $02 ; $5024
	jr nc, Label_03_502f ; $5026
	ld a, [$c36c] ; $5028
	cp a, $03 ; $502b
	jr nc, Label_03_5068 ; $502d
Label_03_502f:
	push af ; $502f
	push bc ; $5030
	push de ; $5031
	push hl ; $5032
	ld hl, $d480 ; $5033
	ld c, $02 ; $5036
	xor a, a ; $5038
	call Func_03_59b1 ; $5039
	pop hl ; $503c
	pop de ; $503d
	pop bc ; $503e
	pop af ; $503f
	ld a, b ; $5040
	sub a, $02 ; $5041
	jr nc, Label_03_504a ; $5043
	ld a, [$c36c] ; $5045
	jr Label_03_504b ; $5048
Label_03_504a:
	xor a, a ; $504a
Label_03_504b:
	add a, $38 ; $504b
	push bc ; $504d
	ld b, a ; $504e
	ld hl, $d480 ; $504f
	call Func_03_4b9b ; $5052
	pop bc ; $5055
	ld a, b ; $5056
	add a, a ; $5057
	ld l, a ; $5058
	xor a, a ; $5059
	ld h, a ; $505a
	ld de, $d480 ; $505b
	add hl, de ; $505e
	ld a, [hl+] ; $505f
	ld d, [hl] ; $5060
	ld e, a ; $5061
	ld hl, $de00 ; $5062
	ld a, e ; $5065
	ld [hl+], a ; $5066
	ld [hl], d ; $5067
Label_03_5068:
	pop af ; $5068
	ldh [$ff96], a ; $5069
	ldh [rWBK], a ; $506b
	pop hl ; $506d
	pop de ; $506e
	pop bc ; $506f
	pop af ; $5070
	ret ; $5071
Func_03_5072:
	push bc ; $5072
	push de ; $5073
	push hl ; $5074
	ld b, a ; $5075
	ldh a, [$ff96] ; $5076
	push af ; $5078
	ld a, $07 ; $5079
	ldh [$ff96], a ; $507b
	ldh [rWBK], a ; $507d
	ld a, b ; $507f
	sub a, $02 ; $5080
	jr nc, Label_03_508e ; $5082
	ld a, [$c36c] ; $5084
	cp a, $03 ; $5087
	jp nc, Label_03_512c ; $5089
	jr Label_03_5090 ; $508c
Label_03_508e:
	ld a, $00 ; $508e
Label_03_5090:
	push af ; $5090
	push bc ; $5091
	push de ; $5092
	push hl ; $5093
	ld hl, $d480 ; $5094
	ld c, $02 ; $5097
	xor a, a ; $5099
	call Func_03_59b1 ; $509a
	pop hl ; $509d
	pop de ; $509e
	pop bc ; $509f
	pop af ; $50a0
	add a, $38 ; $50a1
	push bc ; $50a3
	ld b, a ; $50a4
	ld hl, $d480 ; $50a5
	call Func_03_4b9b ; $50a8
	pop bc ; $50ab
	ld hl, $de00 ; $50ac
	ld a, [hl+] ; $50af
	ld d, [hl] ; $50b0
	ld e, a ; $50b1
	push de ; $50b2
	ld a, b ; $50b3
	add a, a ; $50b4
	ld l, a ; $50b5
	xor a, a ; $50b6
	ld h, a ; $50b7
	ld de, $d480 ; $50b8
	add hl, de ; $50bb
	pop de ; $50bc
	ld a, e ; $50bd
	ld [hl+], a ; $50be
	ld [hl], d ; $50bf
	ld a, b ; $50c0
	sub a, $02 ; $50c1
	jr nc, Label_03_50ca ; $50c3
	ld a, [$c36c] ; $50c5
	jr Label_03_50cb ; $50c8
Label_03_50ca:
	xor a, a ; $50ca
Label_03_50cb:
	push bc ; $50cb
	add a, $38 ; $50cc
	ld b, a ; $50ce
	ld hl, $d480 ; $50cf
	ld de, $0000 ; $50d2
	call Func_03_4a89 ; $50d5
	pop bc ; $50d8
	or a, a ; $50d9
	jr nz, Label_03_512c ; $50da
	ld a, b ; $50dc
	sub a, $02 ; $50dd
	jr nc, Label_03_50e6 ; $50df
	ld a, [$c36c] ; $50e1
	jr Label_03_50e7 ; $50e4
Label_03_50e6:
	xor a, a ; $50e6
Label_03_50e7:
	push bc ; $50e7
	add a, $38 ; $50e8
	ld b, a ; $50ea
	ld hl, $d480 ; $50eb
	call Func_03_4c14 ; $50ee
	pop bc ; $50f1
	or a, a ; $50f2
	jr nz, Label_03_512c ; $50f3
	ld a, b ; $50f5
	sub a, $02 ; $50f6
	jr nc, Label_03_50ff ; $50f8
	ld a, [$c36c] ; $50fa
	jr Label_03_5100 ; $50fd
Label_03_50ff:
	xor a, a ; $50ff
Label_03_5100:
	push bc ; $5100
	add a, $3b ; $5101
	ld b, a ; $5103
	ld hl, $d480 ; $5104
	ld de, $0000 ; $5107
	call Func_03_4a89 ; $510a
	pop bc ; $510d
	or a, a ; $510e
	jr nz, Label_03_512c ; $510f
	ld a, b ; $5111
	sub a, $02 ; $5112
	jr nc, Label_03_511b ; $5114
	ld a, [$c36c] ; $5116
	jr Label_03_511c ; $5119
Label_03_511b:
	xor a, a ; $511b
Label_03_511c:
	push bc ; $511c
	add a, $3b ; $511d
	ld b, a ; $511f
	ld hl, $d480 ; $5120
	call Func_03_4c14 ; $5123
	pop bc ; $5126
	or a, a ; $5127
	jr nz, Label_03_512c ; $5128
	jr Label_03_5137 ; $512a
Label_03_512c:
	pop af ; $512c
	ldh [$ff96], a ; $512d
	ldh [rWBK], a ; $512f
	ld a, $01 ; $5131
	pop hl ; $5133
	pop de ; $5134
	pop bc ; $5135
	ret ; $5136
Label_03_5137:
	pop af ; $5137
	ldh [$ff96], a ; $5138
	ldh [rWBK], a ; $513a
	xor a, a ; $513c
	pop hl ; $513d
	pop de ; $513e
	pop bc ; $513f
	ret ; $5140
Func_03_5141:
	push af ; $5141
	push bc ; $5142
	push de ; $5143
	push hl ; $5144
	ldh a, [$ff96] ; $5145
	push af ; $5147
	ld a, $07 ; $5148
	ldh [$ff96], a ; $514a
	ldh [rWBK], a ; $514c
	ld a, [$c36c] ; $514e
	add a, $38 ; $5151
	ld b, a ; $5153
	ld hl, $d480 ; $5154
	call Func_03_4b9b ; $5157
	xor a, a ; $515a
	farcall FarPtr_0d_02 ; $515b
	ld hl, $d480 ; $515e
	ld a, e ; $5161
	ld [hl+], a ; $5162
	ld [hl], d ; $5163
	ld a, $01 ; $5164
	farcall FarPtr_0d_02 ; $5166
	ld hl, $d482 ; $5169
	ld a, e ; $516c
	ld [hl+], a ; $516d
	ld [hl], d ; $516e
	ld a, [$c36c] ; $516f
	add a, $38 ; $5172
	ld b, a ; $5174
	ld hl, $d480 ; $5175
	ld de, $0000 ; $5178
	call Func_03_4a89 ; $517b
	or a, a ; $517e
	jr nz, Label_03_5190 ; $517f
	ld a, [$c36c] ; $5181
	add a, $3b ; $5184
	ld b, a ; $5186
	ld hl, $d480 ; $5187
	ld de, $0000 ; $518a
	call Func_03_4a89 ; $518d
Label_03_5190:
	pop af ; $5190
	ldh [$ff96], a ; $5191
	ldh [rWBK], a ; $5193
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
Func_03_519a:
	push af ; $519a
	push bc ; $519b
	push de ; $519c
	push hl ; $519d
	ldh a, [$ff96] ; $519e
	push af ; $51a0
	ld a, $07 ; $51a1
	ldh [$ff96], a ; $51a3
	ldh [rWBK], a ; $51a5
	push af ; $51a7
	push bc ; $51a8
	push de ; $51a9
	push hl ; $51aa
	ld hl, $d480 ; $51ab
	ld c, $02 ; $51ae
	xor a, a ; $51b0
	call Func_03_59b1 ; $51b1
	pop hl ; $51b4
	pop de ; $51b5
	pop bc ; $51b6
	pop af ; $51b7
	ld hl, $d480 ; $51b8
	xor a, a ; $51bb
Label_03_51bc:
	cp a, $0b ; $51bc
	jr z, Label_03_51ce ; $51be
	push af ; $51c0
	push hl ; $51c1
	farcall FarPtr_0d_02 ; $51c2
	pop hl ; $51c5
	ld a, e ; $51c6
	ld [hl+], a ; $51c7
	ld [hl], d ; $51c8
	pop af ; $51c9
	inc a ; $51ca
	inc hl ; $51cb
	jr Label_03_51bc ; $51cc
Label_03_51ce:
	ld a, $38 ; $51ce
	ld b, a ; $51d0
	ld hl, $d480 ; $51d1
	ld de, $0000 ; $51d4
	call Func_03_4a89 ; $51d7
	or a, a ; $51da
	jr nz, Label_03_521f ; $51db
	ld a, $3b ; $51dd
	ld b, a ; $51df
	ld hl, $d480 ; $51e0
	ld de, $0000 ; $51e3
	call Func_03_4a89 ; $51e6
	ld a, $39 ; $51e9
	ld b, a ; $51eb
	ld hl, $d480 ; $51ec
	ld de, $0000 ; $51ef
	call Func_03_4a89 ; $51f2
	or a, a ; $51f5
	jr nz, Label_03_521f ; $51f6
	ld a, $3c ; $51f8
	ld b, a ; $51fa
	ld hl, $d480 ; $51fb
	ld de, $0000 ; $51fe
	call Func_03_4a89 ; $5201
	ld a, $3a ; $5204
	ld b, a ; $5206
	ld hl, $d480 ; $5207
	ld de, $0000 ; $520a
	call Func_03_4a89 ; $520d
	or a, a ; $5210
	jr nz, Label_03_521f ; $5211
	ld a, $3d ; $5213
	ld b, a ; $5215
	ld hl, $d480 ; $5216
	ld de, $0000 ; $5219
	call Func_03_4a89 ; $521c
Label_03_521f:
	pop af ; $521f
	ldh [$ff96], a ; $5220
	ldh [rWBK], a ; $5222
	pop hl ; $5224
	pop de ; $5225
	pop bc ; $5226
	pop af ; $5227
	ret ; $5228
Func_03_5229:
	push af ; $5229
	push bc ; $522a
	push de ; $522b
	push hl ; $522c
	ld b, $3e ; $522d
	call Func_03_4b9b ; $522f
	or a, a ; $5232
	jr z, Label_03_523b ; $5233
	xor a, a ; $5235
	ld c, $06 ; $5236
	call Func_03_59b1 ; $5238
Label_03_523b:
	pop hl ; $523b
	pop de ; $523c
	pop bc ; $523d
	pop af ; $523e
	ret ; $523f
Func_03_5240:
	push bc ; $5240
	push de ; $5241
	push hl ; $5242
	ld b, $3e ; $5243
	ld de, $0000 ; $5245
	call Func_03_4a89 ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	ret ; $524e
Func_03_524f:
	ldh a, [hPlayerInputFlags] ; $524f
	bit 0, a ; $5251
	jr nz, Label_03_5270 ; $5253
	ld hl, $ffb0 ; $5255
	ld a, [hl+] ; $5258
	ld h, [hl] ; $5259
	ld l, a ; $525a
	ld b, l ; $525b
	ld e, c ; $525c
	call Func_00_0914 ; $525d
	add hl, de ; $5260
	ld a, h ; $5261
	and a, $03 ; $5262
	ldh [$ffb1], a ; $5264
	ld a, l ; $5266
	ldh [$ffb0], a ; $5267
	xor a, b ; $5269
	bit 7, a ; $526a
	ret ; $526c
	INCBIN "data/bank_003/d_526d.bin" ; $526d, 3 bytes
Label_03_5270:
	sound $5e ; $5270
	ld hl, $ffb0 ; $5272
	ld a, [hl+] ; $5275
	ld h, [hl] ; $5276
	ld l, a ; $5277
	ld de, $d300 ; $5278
	add hl, de ; $527b
	push hl ; $527c
	ld a, [hl] ; $527d
	add a, b ; $527e
	ld [hl], a ; $527f
	pop hl ; $5280
	res 0, l ; $5281
	ld b, l ; $5283
	ld a, [hl+] ; $5284
	ld l, [hl] ; $5285
	ld h, a ; $5286
	push hl ; $5287
	ld a, b ; $5288
	and a, $06 ; $5289
	add a, a ; $528b
	add a, $04 ; $528c
	ld d, a ; $528e
	ld a, b ; $528f
	and a, $78 ; $5290
	add a, a ; $5292
	swap a ; $5293
	inc a ; $5295
	ld e, a ; $5296
	pop hl ; $5297
	call Func_00_1ace ; $5298
	xor a, a ; $529b
	ret ; $529c
Func_03_529d:
	push af ; $529d
	push hl ; $529e
	ld a, [$c36c] ; $529f
	and a, $03 ; $52a2
	add a, $af ; $52a4
	ld l, a ; $52a6
	adc a, $52 ; $52a7
	sub a, l ; $52a9
	ld h, a ; $52aa
	ld b, [hl] ; $52ab
	pop hl ; $52ac
	pop af ; $52ad
	ret ; $52ae
	INCBIN "data/bank_003/d_52af.bin" ; $52af, 4 bytes
Func_03_52b3:
	ld a, $07 ; $52b3
	ldh [$ff96], a ; $52b5
	ldh [rWBK], a ; $52b7
	call Func_03_529d ; $52b9
	ld hl, $d500 ; $52bc
	call Func_03_4b9b ; $52bf
	ret ; $52c2
Func_03_52c3:
	ld a, $07 ; $52c3
	ldh [$ff96], a ; $52c5
	ldh [rWBK], a ; $52c7
	call Func_03_529d ; $52c9
	ld hl, $d500 ; $52cc
	call Func_03_4a89 ; $52cf
	ret ; $52d2
Func_03_52d3:
	ld a, $07 ; $52d3
	ldh [$ff96], a ; $52d5
	ldh [rWBK], a ; $52d7
	call Func_03_529d ; $52d9
	ld hl, $d500 ; $52dc
	call Func_03_4aff ; $52df
	ret ; $52e2
	INCBIN "data/bank_003/d_52e3.bin" ; $52e3, 45 bytes
Func_03_5310:
	ld hl, $52f0 ; $5310
	ld de, $8000 ; $5313
	ld c, $02 ; $5316
	call Func_00_0480 ; $5318
	sound $06 ; $531b
	ld a, $03 ; $531d
	ldh [$ff9e], a ; $531f
	xor a, a ; $5321
	ld [$c36c], a ; $5322
	ld hl, $0000 ; $5325
	ld a, l ; $5328
	ldh [$ffb0], a ; $5329
	ld a, h ; $532b
	ldh [$ffb1], a ; $532c
	farcall FarPtr_05_00 ; $532e
	call EnableLCD ; $5331
	ld c, $7f ; $5334
	call Func_00_1d20 ; $5336
	ld c, $7f ; $5339
	call Func_00_1d2e ; $533b
	farcall FarPtr_02_02 ; $533e
	ld de, $0000 ; $5341
Label_03_5344:
	call Func_03_52b3 ; $5344
	or a, a ; $5347
	jr z, Label_03_5360 ; $5348
	push de ; $534a
	ld hl, $54b0 ; $534b
	ld de, $0511 ; $534e
	call Func_00_1906 ; $5351
	pop de ; $5354
	ld hl, $d300 ; $5355
	ld c, $30 ; $5358
	call ClearMemory16 ; $535a
	jp Label_03_5369 ; $535d
Label_03_5360:
	ld hl, $54bc ; $5360
	ld de, $0511 ; $5363
	call Func_00_1906 ; $5366
Label_03_5369:
	ld a, $07 ; $5369
	ldh [$ff96], a ; $536b
	ldh [rWBK], a ; $536d
	push de ; $536f
	ld hl, $ffb0 ; $5370
	ld a, [hl+] ; $5373
	ld h, [hl] ; $5374
	ld l, a ; $5375
	ld de, $d300 ; $5376
	add hl, de ; $5379
	ld a, l ; $537a
	and a, $80 ; $537b
	ld l, a ; $537d
	ld b, $10 ; $537e
	ld e, $01 ; $5380
Label_03_5382:
	ld d, $00 ; $5382
	push bc ; $5384
	push de ; $5385
	push hl ; $5386
	ld a, h ; $5387
	sub a, $d3 ; $5388
	ld h, a ; $538a
	call Func_00_1ace ; $538b
	pop hl ; $538e
	pop de ; $538f
	inc d ; $5390
	inc d ; $5391
	inc d ; $5392
	inc d ; $5393
	ld c, $04 ; $5394
Label_03_5396:
	push hl ; $5396
	ld a, [hl+] ; $5397
	ld l, [hl] ; $5398
	ld h, a ; $5399
	push de ; $539a
	push bc ; $539b
	call Func_00_1ace ; $539c
	pop bc ; $539f
	pop de ; $53a0
	pop hl ; $53a1
	inc hl ; $53a2
	inc hl ; $53a3
	inc d ; $53a4
	inc d ; $53a5
	inc d ; $53a6
	inc d ; $53a7
	dec c ; $53a8
	jr nz, Label_03_5396 ; $53a9
	inc e ; $53ab
	pop bc ; $53ac
	dec b ; $53ad
	jr nz, Label_03_5382 ; $53ae
	pop de ; $53b0
Label_03_53b1:
	push de ; $53b1
	ld hl, $ffb0 ; $53b2
	ld a, [hl+] ; $53b5
	ld h, [hl] ; $53b6
	ld l, a ; $53b7
	ld de, $1011 ; $53b8
	call Func_00_1ace ; $53bb
	ld a, [$c36c] ; $53be
	ld de, $0011 ; $53c1
	call Func_00_1ae4 ; $53c4
	pop de ; $53c7
Label_03_53c8:
	ldh a, [hPlayerInputFlags] ; $53c8
	bit 0, a ; $53ca
	jr nz, Label_03_53d4 ; $53cc
	ldh a, [$ff8c] ; $53ce
	bit 3, a ; $53d0
	jr z, Label_03_53f8 ; $53d2
Label_03_53d4:
	push de ; $53d4
	ldh a, [$ffb0] ; $53d5
	ld e, a ; $53d7
	and a, $07 ; $53d8
	swap a ; $53da
	add a, $24 ; $53dc
	ld d, a ; $53de
	ld a, e ; $53df
	and a, $78 ; $53e0
	add a, $0c ; $53e2
	ld e, a ; $53e4
	ld bc, $0000 ; $53e5
	push de ; $53e8
	call Func_00_1f51 ; $53e9
	pop de ; $53ec
	ld bc, $0000 ; $53ed
	ld a, d ; $53f0
	add a, $08 ; $53f1
	ld d, a ; $53f3
	call Func_00_1f51 ; $53f4
	pop de ; $53f7
Label_03_53f8:
	call Func_00_2631 ; $53f8
	ldh a, [$ff91] ; $53fb
	bit 6, a ; $53fd
	jr z, Label_03_540c ; $53ff
	ld bc, $f0f8 ; $5401
	call Func_03_524f ; $5404
	jr z, Label_03_53b1 ; $5407
	jp Label_03_5369 ; $5409
Label_03_540c:
	bit 5, a ; $540c
	jr z, Label_03_541b ; $540e
	ld bc, rIE ; $5410
	call Func_03_524f ; $5413
	jr z, Label_03_53b1 ; $5416
	jp Label_03_5369 ; $5418
Label_03_541b:
	bit 4, a ; $541b
	jr z, Label_03_542a ; $541d
	ld bc, $0101 ; $541f
	call Func_03_524f ; $5422
	jr z, Label_03_53b1 ; $5425
	jp Label_03_5369 ; $5427
Label_03_542a:
	bit 7, a ; $542a
	jr z, Label_03_543a ; $542c
	ld bc, $1008 ; $542e
	call Func_03_524f ; $5431
	jp z, Label_03_53b1 ; $5434
	jp Label_03_5369 ; $5437
Label_03_543a:
	bit 1, a ; $543a
	jr z, Label_03_546d ; $543c
	ld a, [$c36c] ; $543e
	push af ; $5441
	ld a, $03 ; $5442
	ld [$c36c], a ; $5444
	call Func_03_52b3 ; $5447
	or a, a ; $544a
	jr nz, Label_03_5466 ; $544b
	ld hl, $d300 ; $544d
	ld a, [hl+] ; $5450
	or a, [hl] ; $5451
	jr z, Label_03_5466 ; $5452
	inc hl ; $5454
	ld a, $01 ; $5455
	ld [hl+], a ; $5457
	ld [hl+], a ; $5458
	ld [hl+], a ; $5459
	ld [hl+], a ; $545a
	ld [hl+], a ; $545b
	ld [hl+], a ; $545c
	call Func_03_52c3 ; $545d
	pop af ; $5460
	sound $41 ; $5461
	jp Label_03_5344 ; $5463
Label_03_5466:
	pop af ; $5466
	ld [$c36c], a ; $5467
	jp Label_03_5344 ; $546a
Label_03_546d:
	bit 2, a ; $546d
	jr z, Label_03_547f ; $546f
	sound $5f ; $5471
	ld a, [$c36c] ; $5473
	inc a ; $5476
	and a, $03 ; $5477
	ld [$c36c], a ; $5479
	jp Label_03_5344 ; $547c
Label_03_547f:
	bit 3, a ; $547f
	jr z, Label_03_54ad ; $5481
	sound $5f ; $5483
	ldh a, [hPlayerInputFlags] ; $5485
	bit 0, a ; $5487
	jr nz, Label_03_549c ; $5489
	push de ; $548b
	ld hl, $54c8 ; $548c
	ld de, $0511 ; $548f
	call Func_00_1906 ; $5492
	call Func_03_52c3 ; $5495
	pop de ; $5498
	jp Label_03_53b1 ; $5499
Label_03_549c:
	push de ; $549c
	ld hl, $54d4 ; $549d
	ld de, $0511 ; $54a0
	call Func_00_1906 ; $54a3
	call Func_03_52d3 ; $54a6
	jp Label_03_53b1 ; $54a9
	INCBIN "data/bank_003/d_54ac.bin" ; $54ac, 1 bytes
Label_03_54ad:
	jp Label_03_53c8 ; $54ad
	INCBIN "data/bank_003/d_54b0.bin" ; $54b0, 93 bytes
Func_03_550d:
	ld hl, $d000 ; $550d
	call Func_03_4b9b ; $5510
	cp a, $ff ; $5513
	ret nz ; $5515
	push bc ; $5516
	ld a, $1b ; $5517
	add a, b ; $5519
	ld b, a ; $551a
	call Func_03_4b9b ; $551b
	or a, a ; $551e
	jr nz, Label_03_5532 ; $551f
	ld hl, $d400 ; $5521
	call Func_03_4c9e ; $5524
	pop bc ; $5527
	ld hl, $d000 ; $5528
	ld de, $d400 ; $552b
	call Func_03_4a89 ; $552e
	ret ; $5531
Label_03_5532:
	pop bc ; $5532
	call Func_03_4b1c ; $5533
	inc b ; $5536
	call Func_03_4b1c ; $5537
	ret ; $553a
	INCBIN "data/bank_003/d_553b.bin" ; $553b, 302 bytes
Func_03_5669:
	ld a, $01 ; $5669
	ldh [$ff96], a ; $566b
	ldh [rWBK], a ; $566d
	ld b, $00 ; $566f
	call Func_03_550d ; $5671
	ld b, $02 ; $5674
	call Func_03_550d ; $5676
	ld b, $04 ; $5679
	call Func_03_550d ; $567b
	call Func_03_5682 ; $567e
	ret ; $5681
Func_03_5682:
	ld a, $36 ; $5682
	ld b, a ; $5684
	ld hl, $d000 ; $5685
	call Func_03_4b9b ; $5688
	cp a, $ff ; $568b
	ret nz ; $568d
	push bc ; $568e
	ld a, $37 ; $568f
	ld b, a ; $5691
	call Func_03_4b9b ; $5692
	or a, a ; $5695
	jr nz, Label_03_56a3 ; $5696
	pop bc ; $5698
	ld hl, $d000 ; $5699
	ld de, $d400 ; $569c
	call Func_03_4a89 ; $569f
	ret ; $56a2
Label_03_56a3:
	pop bc ; $56a3
	call Func_03_4b1c ; $56a4
	ret ; $56a7
Func_03_56a8:
	push af ; $56a8
	push bc ; $56a9
	push de ; $56aa
	push hl ; $56ab
	ldh a, [$ff96] ; $56ac
	push af ; $56ae
	ld a, $07 ; $56af
	ldh [$ff96], a ; $56b1
	ldh [rWBK], a ; $56b3
	ld hl, $d500 ; $56b5
	ld b, $0b ; $56b8
	call Func_03_4b9b ; $56ba
	or a, a ; $56bd
	jr nz, Label_03_56f1 ; $56be
	ld hl, $d500 ; $56c0
	ld a, [hl] ; $56c3
	inc hl ; $56c4
	add a, [hl] ; $56c5
	or a, a ; $56c6
	jr z, Label_03_56f1 ; $56c7
	push de ; $56c9
	ld de, $07c0 ; $56ca
	farcall FarPtr_03_1e ; $56cd
	pop de ; $56d0
	push de ; $56d1
	ld de, $0140 ; $56d2
	farcall FarPtr_03_1e ; $56d5
	pop de ; $56d8
	push de ; $56d9
	ld de, $0160 ; $56da
	farcall FarPtr_03_1e ; $56dd
	pop de ; $56e0
	push de ; $56e1
	ld de, $0180 ; $56e2
	farcall FarPtr_03_1e ; $56e5
	pop de ; $56e8
	push de ; $56e9
	ld de, $01a0 ; $56ea
	farcall FarPtr_03_1e ; $56ed
	pop de ; $56f0
Label_03_56f1:
	pop af ; $56f1
	ldh [$ff96], a ; $56f2
	ldh [rWBK], a ; $56f4
	pop hl ; $56f6
	pop de ; $56f7
	pop bc ; $56f8
	pop af ; $56f9
	ret ; $56fa
Func_03_56fb:
	push af ; $56fb
	push bc ; $56fc
	push de ; $56fd
	push hl ; $56fe
	ldh a, [$ff96] ; $56ff
	push af ; $5701
	ld a, $07 ; $5702
	ldh [$ff96], a ; $5704
	ldh [rWBK], a ; $5706
	ld hl, $d500 ; $5708
	ld b, $0b ; $570b
	call Func_03_4b9b ; $570d
	or a, a ; $5710
	jp nz, Label_03_577d ; $5711
	ld hl, $d500 ; $5714
	ld a, [hl] ; $5717
	inc hl ; $5718
	add a, [hl] ; $5719
	or a, a ; $571a
	jp z, Label_03_577d ; $571b
	ld a, $02 ; $571e
	call Func_03_57e2 ; $5720
	or a, a ; $5723
	jr z, Label_03_572c ; $5724
	ld hl, $d502 ; $5726
	ld a, $01 ; $5729
	ld [hl], a ; $572b
Label_03_572c:
	ld a, $04 ; $572c
	call Func_03_57e2 ; $572e
	or a, a ; $5731
	jr z, Label_03_573a ; $5732
	ld hl, $d507 ; $5734
	ld a, $01 ; $5737
	ld [hl], a ; $5739
Label_03_573a:
	ld a, $06 ; $573a
	call Func_03_57e2 ; $573c
	or a, a ; $573f
	jr z, Label_03_5748 ; $5740
	ld hl, $d504 ; $5742
	ld a, $01 ; $5745
	ld [hl], a ; $5747
Label_03_5748:
	ld a, $08 ; $5748
	call Func_03_57e2 ; $574a
	or a, a ; $574d
	jr z, Label_03_5756 ; $574e
	ld hl, $d506 ; $5750
	ld a, $01 ; $5753
	ld [hl], a ; $5755
Label_03_5756:
	ld a, $09 ; $5756
	call Func_03_57e2 ; $5758
	or a, a ; $575b
	jr z, Label_03_5764 ; $575c
	ld hl, $d503 ; $575e
	ld a, $01 ; $5761
	ld [hl], a ; $5763
Label_03_5764:
	ld a, $0a ; $5764
	call Func_03_57e2 ; $5766
	or a, a ; $5769
	jr z, Label_03_5772 ; $576a
	ld hl, $d505 ; $576c
	ld a, $01 ; $576f
	ld [hl], a ; $5771
Label_03_5772:
	ld hl, $d500 ; $5772
	ld b, $0b ; $5775
	ld de, $0000 ; $5777
	call Func_03_4a89 ; $577a
Label_03_577d:
	pop af ; $577d
	ldh [$ff96], a ; $577e
	ldh [rWBK], a ; $5780
	pop hl ; $5782
	pop de ; $5783
	pop bc ; $5784
	pop af ; $5785
	ret ; $5786
Func_03_5787:
	push af ; $5787
	push bc ; $5788
	push de ; $5789
	push hl ; $578a
	ldh a, [$ff96] ; $578b
	push af ; $578d
	ld a, $07 ; $578e
	ldh [$ff96], a ; $5790
	ldh [rWBK], a ; $5792
	ld hl, $d500 ; $5794
	ld b, $0b ; $5797
	call Func_03_4b9b ; $5799
	or a, a ; $579c
	jp nz, Label_03_57cf ; $579d
	ld hl, $d502 ; $57a0
	ld a, $01 ; $57a3
	ld [hl], a ; $57a5
	ld hl, $d507 ; $57a6
	ld a, $01 ; $57a9
	ld [hl], a ; $57ab
	ld hl, $d504 ; $57ac
	ld a, $01 ; $57af
	ld [hl], a ; $57b1
	ld hl, $d506 ; $57b2
	ld a, $01 ; $57b5
	ld [hl], a ; $57b7
	ld hl, $d503 ; $57b8
	ld a, $01 ; $57bb
	ld [hl], a ; $57bd
	ld hl, $d505 ; $57be
	ld a, $01 ; $57c1
	ld [hl], a ; $57c3
	ld hl, $d500 ; $57c4
	ld b, $0b ; $57c7
	ld de, $0000 ; $57c9
	call Func_03_4a89 ; $57cc
Label_03_57cf:
	pop af ; $57cf
	ldh [$ff96], a ; $57d0
	ldh [rWBK], a ; $57d2
	pop hl ; $57d4
	pop de ; $57d5
	pop bc ; $57d6
	pop af ; $57d7
	ret ; $57d8
	INCBIN "data/bank_003/d_57d9.bin" ; $57d9, 9 bytes
Func_03_57e2:
	push bc ; $57e2
	push de ; $57e3
	push hl ; $57e4
	ld b, a ; $57e5
	ldh a, [$ff96] ; $57e6
	push af ; $57e8
	ld a, $07 ; $57e9
	ldh [$ff96], a ; $57eb
	ldh [rWBK], a ; $57ed
	cp a, $02 ; $57ef
	jr nc, Label_03_5804 ; $57f1
	or a, a ; $57f3
	jr nz, Label_03_57fd ; $57f4
	rst30 $1b20 ; $57f6
	jr z, Label_03_5838 ; $57f9
	jr Label_03_581e ; $57fb
Label_03_57fd:
	rst30 $1aa0 ; $57fd
	jr z, Label_03_5838 ; $5800
	jr Label_03_581e ; $5802
Label_03_5804:
	ld a, b ; $5804
	sub a, $02 ; $5805
	ld hl, $57d9 ; $5807
	ld d, $00 ; $580a
	ld e, a ; $580c
	add hl, de ; $580d
	ld a, [hl] ; $580e
	ld l, a ; $580f
	ld h, $00 ; $5810
	ld a, $20 ; $5812
	call Func_00_0926 ; $5814
	push hl ; $5817
	pop de ; $5818
	call Func_03_4d86 ; $5819
	jr z, Label_03_5838 ; $581c
Label_03_581e:
	ld a, b ; $581e
	farcall FarPtr_0d_02 ; $581f
	ld a, b ; $5822
	call Func_03_5015 ; $5823
	ld hl, $de00 ; $5826
	ld a, [hl+] ; $5829
	ld h, [hl] ; $582a
	ld l, a ; $582b
	ld a, l ; $582c
	sub a, e ; $582d
	ld l, a ; $582e
	ld a, h ; $582f
	sbc a, d ; $5830
	ld h, a ; $5831
	jr c, Label_03_5838 ; $5832
	ld b, $01 ; $5834
	jr Label_03_583a ; $5836
Label_03_5838:
	xor a, a ; $5838
	ld b, a ; $5839
Label_03_583a:
	pop af ; $583a
	ldh [$ff96], a ; $583b
	ldh [rWBK], a ; $583d
	ld a, b ; $583f
	pop hl ; $5840
	pop de ; $5841
	pop bc ; $5842
	ret ; $5843
Func_03_5844:
	push bc ; $5844
	push de ; $5845
	push hl ; $5846
	ld de, $0000 ; $5847
	ld b, $06 ; $584a
	call Func_03_4a89 ; $584c
	or a, a ; $584f
	jr nz, Label_03_5869 ; $5850
	call Func_03_4c14 ; $5852
	or a, a ; $5855
	jr nz, Label_03_5869 ; $5856
	ld b, $21 ; $5858
	call Func_03_4a89 ; $585a
	or a, a ; $585d
	jr nz, Label_03_5869 ; $585e
	call Func_03_4c14 ; $5860
	or a, a ; $5863
	jr nz, Label_03_5869 ; $5864
	xor a, a ; $5866
	jr Label_03_586b ; $5867
Label_03_5869:
	ld a, $ff ; $5869
Label_03_586b:
	pop hl ; $586b
	pop de ; $586c
	pop bc ; $586d
	ret ; $586e
Func_03_586f:
	push bc ; $586f
	push de ; $5870
	push hl ; $5871
	ld b, $06 ; $5872
	call Func_03_4b9b ; $5874
	pop hl ; $5877
	pop de ; $5878
	pop bc ; $5879
	ret ; $587a
	INCBIN "data/bank_003/d_587b.bin" ; $587b, 310 bytes
Func_03_59b1:
	ld [hl+], a ; $59b1
	ld [hl+], a ; $59b2
	ld [hl+], a ; $59b3
	ld [hl+], a ; $59b4
	ld [hl+], a ; $59b5
	ld [hl+], a ; $59b6
	ld [hl+], a ; $59b7
	ld [hl+], a ; $59b8
	ld [hl+], a ; $59b9
	ld [hl+], a ; $59ba
	ld [hl+], a ; $59bb
	ld [hl+], a ; $59bc
	ld [hl+], a ; $59bd
	ld [hl+], a ; $59be
	ld [hl+], a ; $59bf
	ld [hl+], a ; $59c0
	dec c ; $59c1
	jr nz, Func_03_59b1 ; $59c2
	ret ; $59c4
Func_03_59c5:
	call Func_00_1b38 ; $59c5
	farcall FarPtr_01_0a ; $59c8
	call DisableLCDSafely ; $59cb
	xor a, a ; $59ce
	ldh [$ff8b], a ; $59cf
	ldh [$ff8a], a ; $59d1
	ld [$c320], a ; $59d3
	ld [$c321], a ; $59d6
	ld [$c322], a ; $59d9
	ld [$c323], a ; $59dc
	ld a, $90 ; $59df
	ldh [rWY], a ; $59e1
	call Func_00_1e1d ; $59e3
	ld hl, $5b20 ; $59e6
	ld de, $0001 ; $59e9
	call Func_00_05b0 ; $59ec
	call Func_03_5aa9 ; $59ef
	call EnableLCD ; $59f2
	sound $2c ; $59f5
	ld c, $08 ; $59f7
	call Func_00_1d0c ; $59f9
	call Func_00_1da4 ; $59fc
Label_03_59ff:
	ld a, $06 ; $59ff
	ldh [$ff96], a ; $5a01
	ldh [rWBK], a ; $5a03
	ld a, [$d230] ; $5a05
	dec a ; $5a08
	ld [$d230], a ; $5a09
	jr nz, Label_03_5a73 ; $5a0c
	ld a, $02 ; $5a0e
	ld [$d230], a ; $5a10
	ld a, [$d234] ; $5a13
	and a, a ; $5a16
	jr nz, Label_03_5a73 ; $5a17
	ldh a, [$ff8a] ; $5a19
	inc a ; $5a1b
	ldh [$ff8a], a ; $5a1c
	and a, $07 ; $5a1e
	jr nz, Label_03_5a73 ; $5a20
	ld hl, $d232 ; $5a22
	ld a, [hl+] ; $5a25
	ld h, [hl] ; $5a26
	ld l, a ; $5a27
	ld a, $03 ; $5a28
	ldh [$ff96], a ; $5a2a
	ldh [rWBK], a ; $5a2c
	ld de, $d000 ; $5a2e
	ld c, $10 ; $5a31
	farcall FarPtr_1e_0a ; $5a33
	call Func_03_5b1a ; $5a36
	and a, a ; $5a39
	jr nz, Label_03_5a49 ; $5a3a
	ld a, $06 ; $5a3c
	ldh [$ff96], a ; $5a3e
	ldh [rWBK], a ; $5a40
	ld a, $01 ; $5a42
	ld [$d234], a ; $5a44
	jr Label_03_5a73 ; $5a47
Label_03_5a49:
	ld de, $0090 ; $5a49
	call Func_03_5b01 ; $5a4c
	push de ; $5a4f
	ld a, $03 ; $5a50
	ldh [$ff96], a ; $5a52
	ldh [rWBK], a ; $5a54
	ld hl, $d000 ; $5a56
	ld c, $02 ; $5a59
	call Func_00_0480 ; $5a5b
	pop de ; $5a5e
	ld a, $06 ; $5a5f
	ldh [$ff96], a ; $5a61
	ldh [rWBK], a ; $5a63
	ld hl, $d232 ; $5a65
	ld b, h ; $5a68
	ld c, l ; $5a69
	ld a, [hl+] ; $5a6a
	ld d, [hl] ; $5a6b
	ld e, a ; $5a6c
	inc de ; $5a6d
	ld h, b ; $5a6e
	ld l, c ; $5a6f
	ld a, e ; $5a70
	ld [hl+], a ; $5a71
	ld [hl], d ; $5a72
Label_03_5a73:
	ldh a, [$ff9e] ; $5a73
	or a, a ; $5a75
	jr nz, Label_03_5a7e ; $5a76
	ld a, [$d234] ; $5a78
	and a, a ; $5a7b
	jr z, Label_03_5a84 ; $5a7c
Label_03_5a7e:
	ldh a, [hPlayerInputFlags] ; $5a7e
	and a, $0b ; $5a80
	jr nz, Label_03_5a9a ; $5a82
Label_03_5a84:
	call Func_00_2631 ; $5a84
	ld a, $03 ; $5a87
	ldh [$ff96], a ; $5a89
	ldh [rWBK], a ; $5a8b
	xor a, a ; $5a8d
	ld b, $40 ; $5a8e
	ld hl, $d000 ; $5a90
Label_03_5a93:
	ld [hl+], a ; $5a93
	inc b ; $5a94
	jr nz, Label_03_5a93 ; $5a95
	jp Label_03_59ff ; $5a97
Label_03_5a9a:
	ld c, $01 ; $5a9a
	call Func_00_1d20 ; $5a9c
	call Func_00_1da4 ; $5a9f
	call Func_00_1b38 ; $5aa2
	farcall FarPtr_01_0a ; $5aa5
	ret ; $5aa8
Func_03_5aa9:
	ld a, $06 ; $5aa9
	ldh [$ff96], a ; $5aab
	ldh [rWBK], a ; $5aad
	ld hl, $d230 ; $5aaf
	ld a, $02 ; $5ab2
	ld [hl+], a ; $5ab4
	ld [hl+], a ; $5ab5
	ld de, $1863 ; $5ab6
	ld a, e ; $5ab9
	ld [hl+], a ; $5aba
	ld [hl], d ; $5abb
	xor a, a ; $5abc
	ld [$d234], a ; $5abd
	ld a, $02 ; $5ac0
	ldh [$ff96], a ; $5ac2
	ldh [rWBK], a ; $5ac4
	ld bc, $0400 ; $5ac6
	ld d, $00 ; $5ac9
	ld hl, $d000 ; $5acb
	call Func_03_5af9 ; $5ace
	ld hl, $d000 ; $5ad1
	ld de, $b800 ; $5ad4
	ld c, $40 ; $5ad7
	call Func_00_0480 ; $5ad9
	ld a, $03 ; $5adc
	ldh [$ff96], a ; $5ade
	ldh [rWBK], a ; $5ae0
	ld bc, $0400 ; $5ae2
	ld d, $20 ; $5ae5
	ld hl, $d000 ; $5ae7
	call Func_03_5af9 ; $5aea
	ld hl, $d000 ; $5aed
	ld de, $9800 ; $5af0
	ld c, $40 ; $5af3
	call Func_00_0480 ; $5af5
	ret ; $5af8
Func_03_5af9:
	ld [hl], d ; $5af9
	inc hl ; $5afa
	dec bc ; $5afb
	ld a, b ; $5afc
	or a, c ; $5afd
	jr nz, Func_03_5af9 ; $5afe
	ret ; $5b00
Func_03_5b01:
	ldh a, [$ff8a] ; $5b01
	ld h, $00 ; $5b03
	ld l, a ; $5b05
	add hl, de ; $5b06
	sla l ; $5b07
	rl h ; $5b09
	sla l ; $5b0b
	rl h ; $5b0d
	ld a, h ; $5b0f
	and a, $03 ; $5b10
	ld h, a ; $5b12
	ld de, $9800 ; $5b13
	add hl, de ; $5b16
	ld d, h ; $5b17
	ld e, l ; $5b18
	ret ; $5b19
Func_03_5b1a:
	ld a, [$d000] ; $5b1a
	sub a, $23 ; $5b1d
	ret ; $5b1f
	INCBIN "data/bank_003/d_5b20.bin" ; $5b20, 8 bytes
Func_03_5b28:
	ldh a, [$ff96] ; $5b28
	push af ; $5b2a
	ld a, $06 ; $5b2b
	ldh [$ff96], a ; $5b2d
	ldh [rWBK], a ; $5b2f
	xor a, a ; $5b31
	ld [$d000], a ; $5b32
	ld hl, $65bc ; $5b35
	ld de, $0a01 ; $5b38
	call Func_00_05b0 ; $5b3b
	ld hl, $65c4 ; $5b3e
	ld de, $0b01 ; $5b41
	call Func_00_05b0 ; $5b44
	pop af ; $5b47
	ldh [$ff96], a ; $5b48
	ldh [rWBK], a ; $5b4a
	ret ; $5b4c
Func_03_5b4d:
	ldh a, [$ff96] ; $5b4d
	push af ; $5b4f
	ld a, $06 ; $5b50
	ldh [$ff96], a ; $5b52
	ldh [rWBK], a ; $5b54
	call Func_03_5b89 ; $5b56
	call Func_03_5d38 ; $5b59
	call Func_03_5eec ; $5b5c
	call Func_03_60a0 ; $5b5f
	call Func_03_6254 ; $5b62
	call Func_03_6408 ; $5b65
	ld a, $06 ; $5b68
	ldh [$ff96], a ; $5b6a
	ldh [rWBK], a ; $5b6c
	ld a, [$cb60] ; $5b6e
	and a, $03 ; $5b71
	jr nz, Label_03_5b83 ; $5b73
	ld a, [$d000] ; $5b75
	ld b, a ; $5b78
	sub a, $36 ; $5b79
	jp nc, Label_03_5b83 ; $5b7b
	ld a, b ; $5b7e
	inc a ; $5b7f
	ld [$d000], a ; $5b80
Label_03_5b83:
	pop af ; $5b83
	ldh [$ff96], a ; $5b84
	ldh [rWBK], a ; $5b86
	ret ; $5b88
Func_03_5b89:
	ld a, $06 ; $5b89
	ldh [$ff96], a ; $5b8b
	ldh [rWBK], a ; $5b8d
	ld a, [$d000] ; $5b8f
	cp a, $00 ; $5b92
	jp z, Label_03_5bc2 ; $5b94
	cp a, $01 ; $5b97
	jp z, Label_03_5bea ; $5b99
	cp a, $02 ; $5b9c
	jp z, Label_03_5c12 ; $5b9e
	cp a, $03 ; $5ba1
	jp z, Label_03_5c3a ; $5ba3
	cp a, $04 ; $5ba6
	jp z, Label_03_5c62 ; $5ba8
	cp a, $05 ; $5bab
	jp z, Label_03_5c8a ; $5bad
	cp a, $06 ; $5bb0
	jp z, Label_03_5cb2 ; $5bb2
	cp a, $07 ; $5bb5
	jp z, Label_03_5cda ; $5bb7
	cp a, $08 ; $5bba
	jp z, Label_03_5d02 ; $5bbc
	jp Label_03_5d2a ; $5bbf
Label_03_5bc2:
	ld a, $01 ; $5bc2
	ldh [$ff96], a ; $5bc4
	ldh [rWBK], a ; $5bc6
	ld hl, $65d0 ; $5bc8
	ld de, $d000 ; $5bcb
	call DecompressData ; $5bce
	ld hl, $d000 ; $5bd1
	ld de, $8000 ; $5bd4
	ld c, $04 ; $5bd7
	call Func_00_0480 ; $5bd9
	ld hl, $6e75 ; $5bdc
	ld d, $fe ; $5bdf
	ld e, $80 ; $5be1
	ld bc, $0300 ; $5be3
	call Func_00_1e9d ; $5be6
	ret ; $5be9
Label_03_5bea:
	ld a, $01 ; $5bea
	ldh [$ff96], a ; $5bec
	ldh [rWBK], a ; $5bee
	ld hl, $65fa ; $5bf0
	ld de, $d000 ; $5bf3
	call DecompressData ; $5bf6
	ld hl, $d000 ; $5bf9
	ld de, $8000 ; $5bfc
	ld c, $04 ; $5bff
	call Func_00_0480 ; $5c01
	ld hl, $6e7e ; $5c04
	ld d, $fe ; $5c07
	ld e, $80 ; $5c09
	ld bc, $0300 ; $5c0b
	call Func_00_1e9d ; $5c0e
	ret ; $5c11
Label_03_5c12:
	ld a, $01 ; $5c12
	ldh [$ff96], a ; $5c14
	ldh [rWBK], a ; $5c16
	ld hl, $6628 ; $5c18
	ld de, $d000 ; $5c1b
	call DecompressData ; $5c1e
	ld hl, $d000 ; $5c21
	ld de, $8000 ; $5c24
	ld c, $04 ; $5c27
	call Func_00_0480 ; $5c29
	ld hl, $6e87 ; $5c2c
	ld d, $fe ; $5c2f
	ld e, $80 ; $5c31
	ld bc, $0300 ; $5c33
	call Func_00_1e9d ; $5c36
	ret ; $5c39
Label_03_5c3a:
	ld a, $01 ; $5c3a
	ldh [$ff96], a ; $5c3c
	ldh [rWBK], a ; $5c3e
	ld hl, $6658 ; $5c40
	ld de, $d000 ; $5c43
	call DecompressData ; $5c46
	ld hl, $d000 ; $5c49
	ld de, $8000 ; $5c4c
	ld c, $04 ; $5c4f
	call Func_00_0480 ; $5c51
	ld hl, $6e90 ; $5c54
	ld d, $fe ; $5c57
	ld e, $80 ; $5c59
	ld bc, $0300 ; $5c5b
	call Func_00_1e9d ; $5c5e
	ret ; $5c61
Label_03_5c62:
	ld a, $01 ; $5c62
	ldh [$ff96], a ; $5c64
	ldh [rWBK], a ; $5c66
	ld hl, $6699 ; $5c68
	ld de, $d000 ; $5c6b
	call DecompressData ; $5c6e
	ld hl, $d000 ; $5c71
	ld de, $8000 ; $5c74
	ld c, $04 ; $5c77
	call Func_00_0480 ; $5c79
	ld hl, $6e99 ; $5c7c
	ld d, $fe ; $5c7f
	ld e, $80 ; $5c81
	ld bc, $0300 ; $5c83
	call Func_00_1e9d ; $5c86
	ret ; $5c89
Label_03_5c8a:
	ld a, $01 ; $5c8a
	ldh [$ff96], a ; $5c8c
	ldh [rWBK], a ; $5c8e
	ld hl, $66db ; $5c90
	ld de, $d000 ; $5c93
	call DecompressData ; $5c96
	ld hl, $d000 ; $5c99
	ld de, $8000 ; $5c9c
	ld c, $04 ; $5c9f
	call Func_00_0480 ; $5ca1
	ld hl, $6ea2 ; $5ca4
	ld d, $fe ; $5ca7
	ld e, $80 ; $5ca9
	ld bc, $0300 ; $5cab
	call Func_00_1e9d ; $5cae
	ret ; $5cb1
Label_03_5cb2:
	ld a, $01 ; $5cb2
	ldh [$ff96], a ; $5cb4
	ldh [rWBK], a ; $5cb6
	ld hl, $6723 ; $5cb8
	ld de, $d000 ; $5cbb
	call DecompressData ; $5cbe
	ld hl, $d000 ; $5cc1
	ld de, $8000 ; $5cc4
	ld c, $04 ; $5cc7
	call Func_00_0480 ; $5cc9
	ld hl, $6eab ; $5ccc
	ld d, $fe ; $5ccf
	ld e, $80 ; $5cd1
	ld bc, $0300 ; $5cd3
	call Func_00_1e9d ; $5cd6
	ret ; $5cd9
Label_03_5cda:
	ld a, $01 ; $5cda
	ldh [$ff96], a ; $5cdc
	ldh [rWBK], a ; $5cde
	ld hl, $676c ; $5ce0
	ld de, $d000 ; $5ce3
	call DecompressData ; $5ce6
	ld hl, $d000 ; $5ce9
	ld de, $8000 ; $5cec
	ld c, $04 ; $5cef
	call Func_00_0480 ; $5cf1
	ld hl, $6eb4 ; $5cf4
	ld d, $fe ; $5cf7
	ld e, $80 ; $5cf9
	ld bc, $0300 ; $5cfb
	call Func_00_1e9d ; $5cfe
	ret ; $5d01
Label_03_5d02:
	ld a, $01 ; $5d02
	ldh [$ff96], a ; $5d04
	ldh [rWBK], a ; $5d06
	ld hl, $67b5 ; $5d08
	ld de, $d000 ; $5d0b
	call DecompressData ; $5d0e
	ld hl, $d000 ; $5d11
	ld de, $8000 ; $5d14
	ld c, $04 ; $5d17
	call Func_00_0480 ; $5d19
	ld hl, $6ebd ; $5d1c
	ld d, $fe ; $5d1f
	ld e, $80 ; $5d21
	ld bc, $0300 ; $5d23
	call Func_00_1e9d ; $5d26
	ret ; $5d29
Label_03_5d2a:
	ld hl, $6ebd ; $5d2a
	ld d, $fe ; $5d2d
	ld e, $80 ; $5d2f
	ld bc, $0300 ; $5d31
	call Func_00_1e9d ; $5d34
	ret ; $5d37
Func_03_5d38:
	ld a, $06 ; $5d38
	ldh [$ff96], a ; $5d3a
	ldh [rWBK], a ; $5d3c
	ld a, [$d000] ; $5d3e
	ld b, a ; $5d41
	sub a, $09 ; $5d42
	ret c ; $5d44
	ld a, b ; $5d45
	cp a, $09 ; $5d46
	jp z, Label_03_5d76 ; $5d48
	cp a, $0a ; $5d4b
	jp z, Label_03_5d9e ; $5d4d
	cp a, $0b ; $5d50
	jp z, Label_03_5dc6 ; $5d52
	cp a, $0c ; $5d55
	jp z, Label_03_5dee ; $5d57
	cp a, $0d ; $5d5a
	jp z, Label_03_5e16 ; $5d5c
	cp a, $0e ; $5d5f
	jp z, Label_03_5e3e ; $5d61
	cp a, $0f ; $5d64
	jp z, Label_03_5e66 ; $5d66
	cp a, $10 ; $5d69
	jp z, Label_03_5e8e ; $5d6b
	cp a, $11 ; $5d6e
	jp z, Label_03_5eb6 ; $5d70
	jp Label_03_5ede ; $5d73
Label_03_5d76:
	ld a, $01 ; $5d76
	ldh [$ff96], a ; $5d78
	ldh [rWBK], a ; $5d7a
	ld hl, $67fc ; $5d7c
	ld de, $d040 ; $5d7f
	call DecompressData ; $5d82
	ld hl, $d040 ; $5d85
	ld de, $8040 ; $5d88
	ld c, $04 ; $5d8b
	call Func_00_0480 ; $5d8d
	ld hl, $6ec6 ; $5d90
	ld d, $0e ; $5d93
	ld e, $80 ; $5d95
	ld bc, $0204 ; $5d97
	call Func_00_1e9d ; $5d9a
	ret ; $5d9d
Label_03_5d9e:
	ld a, $01 ; $5d9e
	ldh [$ff96], a ; $5da0
	ldh [rWBK], a ; $5da2
	ld hl, $6822 ; $5da4
	ld de, $d040 ; $5da7
	call DecompressData ; $5daa
	ld hl, $d040 ; $5dad
	ld de, $8040 ; $5db0
	ld c, $04 ; $5db3
	call Func_00_0480 ; $5db5
	ld hl, $6ecf ; $5db8
	ld d, $0e ; $5dbb
	ld e, $80 ; $5dbd
	ld bc, $0204 ; $5dbf
	call Func_00_1e9d ; $5dc2
	ret ; $5dc5
Label_03_5dc6:
	ld a, $01 ; $5dc6
	ldh [$ff96], a ; $5dc8
	ldh [rWBK], a ; $5dca
	ld hl, $6850 ; $5dcc
	ld de, $d040 ; $5dcf
	call DecompressData ; $5dd2
	ld hl, $d040 ; $5dd5
	ld de, $8040 ; $5dd8
	ld c, $04 ; $5ddb
	call Func_00_0480 ; $5ddd
	ld hl, $6ed8 ; $5de0
	ld d, $0e ; $5de3
	ld e, $80 ; $5de5
	ld bc, $0204 ; $5de7
	call Func_00_1e9d ; $5dea
	ret ; $5ded
Label_03_5dee:
	ld a, $01 ; $5dee
	ldh [$ff96], a ; $5df0
	ldh [rWBK], a ; $5df2
	ld hl, $687e ; $5df4
	ld de, $d040 ; $5df7
	call DecompressData ; $5dfa
	ld hl, $d040 ; $5dfd
	ld de, $8040 ; $5e00
	ld c, $04 ; $5e03
	call Func_00_0480 ; $5e05
	ld hl, $6ee1 ; $5e08
	ld d, $0e ; $5e0b
	ld e, $80 ; $5e0d
	ld bc, $0204 ; $5e0f
	call Func_00_1e9d ; $5e12
	ret ; $5e15
Label_03_5e16:
	ld a, $01 ; $5e16
	ldh [$ff96], a ; $5e18
	ldh [rWBK], a ; $5e1a
	ld hl, $68c1 ; $5e1c
	ld de, $d040 ; $5e1f
	call DecompressData ; $5e22
	ld hl, $d040 ; $5e25
	ld de, $8040 ; $5e28
	ld c, $04 ; $5e2b
	call Func_00_0480 ; $5e2d
	ld hl, $6eea ; $5e30
	ld d, $0e ; $5e33
	ld e, $80 ; $5e35
	ld bc, $0204 ; $5e37
	call Func_00_1e9d ; $5e3a
	ret ; $5e3d
Label_03_5e3e:
	ld a, $01 ; $5e3e
	ldh [$ff96], a ; $5e40
	ldh [rWBK], a ; $5e42
	ld hl, $690c ; $5e44
	ld de, $d040 ; $5e47
	call DecompressData ; $5e4a
	ld hl, $d040 ; $5e4d
	ld de, $8040 ; $5e50
	ld c, $04 ; $5e53
	call Func_00_0480 ; $5e55
	ld hl, $6ef3 ; $5e58
	ld d, $0e ; $5e5b
	ld e, $80 ; $5e5d
	ld bc, $0204 ; $5e5f
	call Func_00_1e9d ; $5e62
	ret ; $5e65
Label_03_5e66:
	ld a, $01 ; $5e66
	ldh [$ff96], a ; $5e68
	ldh [rWBK], a ; $5e6a
	ld hl, $6957 ; $5e6c
	ld de, $d040 ; $5e6f
	call DecompressData ; $5e72
	ld hl, $d040 ; $5e75
	ld de, $8040 ; $5e78
	ld c, $04 ; $5e7b
	call Func_00_0480 ; $5e7d
	ld hl, $6efc ; $5e80
	ld d, $0e ; $5e83
	ld e, $80 ; $5e85
	ld bc, $0204 ; $5e87
	call Func_00_1e9d ; $5e8a
	ret ; $5e8d
Label_03_5e8e:
	ld a, $01 ; $5e8e
	ldh [$ff96], a ; $5e90
	ldh [rWBK], a ; $5e92
	ld hl, $69a2 ; $5e94
	ld de, $d040 ; $5e97
	call DecompressData ; $5e9a
	ld hl, $d040 ; $5e9d
	ld de, $8040 ; $5ea0
	ld c, $04 ; $5ea3
	call Func_00_0480 ; $5ea5
	ld hl, $6f05 ; $5ea8
	ld d, $0e ; $5eab
	ld e, $80 ; $5ead
	ld bc, $0204 ; $5eaf
	call Func_00_1e9d ; $5eb2
	ret ; $5eb5
Label_03_5eb6:
	ld a, $01 ; $5eb6
	ldh [$ff96], a ; $5eb8
	ldh [rWBK], a ; $5eba
	ld hl, $69ec ; $5ebc
	ld de, $d040 ; $5ebf
	call DecompressData ; $5ec2
	ld hl, $d040 ; $5ec5
	ld de, $8040 ; $5ec8
	ld c, $04 ; $5ecb
	call Func_00_0480 ; $5ecd
	ld hl, $6f0e ; $5ed0
	ld d, $0e ; $5ed3
	ld e, $80 ; $5ed5
	ld bc, $0204 ; $5ed7
	call Func_00_1e9d ; $5eda
	ret ; $5edd
Label_03_5ede:
	ld hl, $6f0e ; $5ede
	ld d, $0e ; $5ee1
	ld e, $80 ; $5ee3
	ld bc, $0204 ; $5ee5
	call Func_00_1e9d ; $5ee8
	ret ; $5eeb
Func_03_5eec:
	ld a, $06 ; $5eec
	ldh [$ff96], a ; $5eee
	ldh [rWBK], a ; $5ef0
	ld a, [$d000] ; $5ef2
	ld b, a ; $5ef5
	sub a, $12 ; $5ef6
	ret c ; $5ef8
	ld a, b ; $5ef9
	cp a, $12 ; $5efa
	jp z, Label_03_5f2a ; $5efc
	cp a, $13 ; $5eff
	jp z, Label_03_5f52 ; $5f01
	cp a, $14 ; $5f04
	jp z, Label_03_5f7a ; $5f06
	cp a, $15 ; $5f09
	jp z, Label_03_5fa2 ; $5f0b
	cp a, $16 ; $5f0e
	jp z, Label_03_5fca ; $5f10
	cp a, $17 ; $5f13
	jp z, Label_03_5ff2 ; $5f15
	cp a, $18 ; $5f18
	jp z, Label_03_601a ; $5f1a
	cp a, $19 ; $5f1d
	jp z, Label_03_6042 ; $5f1f
	cp a, $1a ; $5f22
	jp z, Label_03_606a ; $5f24
	jp Label_03_6092 ; $5f27
Label_03_5f2a:
	ld a, $01 ; $5f2a
	ldh [$ff96], a ; $5f2c
	ldh [rWBK], a ; $5f2e
	ld hl, $6a35 ; $5f30
	ld de, $d080 ; $5f33
	call DecompressData ; $5f36
	ld hl, $d080 ; $5f39
	ld de, $8080 ; $5f3c
	ld c, $04 ; $5f3f
	call Func_00_0480 ; $5f41
	ld hl, $6f17 ; $5f44
	ld d, $1e ; $5f47
	ld e, $80 ; $5f49
	ld bc, $0308 ; $5f4b
	call Func_00_1e9d ; $5f4e
	ret ; $5f51
Label_03_5f52:
	ld a, $01 ; $5f52
	ldh [$ff96], a ; $5f54
	ldh [rWBK], a ; $5f56
	ld hl, $6a5c ; $5f58
	ld de, $d080 ; $5f5b
	call DecompressData ; $5f5e
	ld hl, $d080 ; $5f61
	ld de, $8080 ; $5f64
	ld c, $04 ; $5f67
	call Func_00_0480 ; $5f69
	ld hl, $6f20 ; $5f6c
	ld d, $1e ; $5f6f
	ld e, $80 ; $5f71
	ld bc, $0308 ; $5f73
	call Func_00_1e9d ; $5f76
	ret ; $5f79
Label_03_5f7a:
	ld a, $01 ; $5f7a
	ldh [$ff96], a ; $5f7c
	ldh [rWBK], a ; $5f7e
	ld hl, $6a8d ; $5f80
	ld de, $d080 ; $5f83
	call DecompressData ; $5f86
	ld hl, $d080 ; $5f89
	ld de, $8080 ; $5f8c
	ld c, $04 ; $5f8f
	call Func_00_0480 ; $5f91
	ld hl, $6f29 ; $5f94
	ld d, $1e ; $5f97
	ld e, $80 ; $5f99
	ld bc, $0308 ; $5f9b
	call Func_00_1e9d ; $5f9e
	ret ; $5fa1
Label_03_5fa2:
	ld a, $01 ; $5fa2
	ldh [$ff96], a ; $5fa4
	ldh [rWBK], a ; $5fa6
	ld hl, $6ac2 ; $5fa8
	ld de, $d080 ; $5fab
	call DecompressData ; $5fae
	ld hl, $d080 ; $5fb1
	ld de, $8080 ; $5fb4
	ld c, $04 ; $5fb7
	call Func_00_0480 ; $5fb9
	ld hl, $6f32 ; $5fbc
	ld d, $1e ; $5fbf
	ld e, $80 ; $5fc1
	ld bc, $0308 ; $5fc3
	call Func_00_1e9d ; $5fc6
	ret ; $5fc9
Label_03_5fca:
	ld a, $01 ; $5fca
	ldh [$ff96], a ; $5fcc
	ldh [rWBK], a ; $5fce
	ld hl, $6b04 ; $5fd0
	ld de, $d080 ; $5fd3
	call DecompressData ; $5fd6
	ld hl, $d080 ; $5fd9
	ld de, $8080 ; $5fdc
	ld c, $04 ; $5fdf
	call Func_00_0480 ; $5fe1
	ld hl, $6f3b ; $5fe4
	ld d, $1e ; $5fe7
	ld e, $80 ; $5fe9
	ld bc, $0308 ; $5feb
	call Func_00_1e9d ; $5fee
	ret ; $5ff1
Label_03_5ff2:
	ld a, $01 ; $5ff2
	ldh [$ff96], a ; $5ff4
	ldh [rWBK], a ; $5ff6
	ld hl, $6b49 ; $5ff8
	ld de, $d080 ; $5ffb
	call DecompressData ; $5ffe
	ld hl, $d080 ; $6001
	ld de, $8080 ; $6004
	ld c, $04 ; $6007
	call Func_00_0480 ; $6009
	ld hl, $6f44 ; $600c
	ld d, $1e ; $600f
	ld e, $80 ; $6011
	ld bc, $0308 ; $6013
	call Func_00_1e9d ; $6016
	ret ; $6019
Label_03_601a:
	ld a, $01 ; $601a
	ldh [$ff96], a ; $601c
	ldh [rWBK], a ; $601e
	ld hl, $6b92 ; $6020
	ld de, $d080 ; $6023
	call DecompressData ; $6026
	ld hl, $d080 ; $6029
	ld de, $8080 ; $602c
	ld c, $04 ; $602f
	call Func_00_0480 ; $6031
	ld hl, $6f4d ; $6034
	ld d, $1e ; $6037
	ld e, $80 ; $6039
	ld bc, $0308 ; $603b
	call Func_00_1e9d ; $603e
	ret ; $6041
Label_03_6042:
	ld a, $01 ; $6042
	ldh [$ff96], a ; $6044
	ldh [rWBK], a ; $6046
	ld hl, $6bdc ; $6048
	ld de, $d080 ; $604b
	call DecompressData ; $604e
	ld hl, $d080 ; $6051
	ld de, $8080 ; $6054
	ld c, $04 ; $6057
	call Func_00_0480 ; $6059
	ld hl, $6f56 ; $605c
	ld d, $1e ; $605f
	ld e, $80 ; $6061
	ld bc, $0308 ; $6063
	call Func_00_1e9d ; $6066
	ret ; $6069
Label_03_606a:
	ld a, $01 ; $606a
	ldh [$ff96], a ; $606c
	ldh [rWBK], a ; $606e
	ld hl, $6c26 ; $6070
	ld de, $d080 ; $6073
	call DecompressData ; $6076
	ld hl, $d080 ; $6079
	ld de, $8080 ; $607c
	ld c, $04 ; $607f
	call Func_00_0480 ; $6081
	ld hl, $6f5f ; $6084
	ld d, $1e ; $6087
	ld e, $80 ; $6089
	ld bc, $0308 ; $608b
	call Func_00_1e9d ; $608e
	ret ; $6091
Label_03_6092:
	ld hl, $6f5f ; $6092
	ld d, $1e ; $6095
	ld e, $80 ; $6097
	ld bc, $0308 ; $6099
	call Func_00_1e9d ; $609c
	ret ; $609f
Func_03_60a0:
	ld a, $06 ; $60a0
	ldh [$ff96], a ; $60a2
	ldh [rWBK], a ; $60a4
	ld a, [$d000] ; $60a6
	ld b, a ; $60a9
	sub a, $1b ; $60aa
	ret c ; $60ac
	ld a, b ; $60ad
	cp a, $1b ; $60ae
	jp z, Label_03_60de ; $60b0
	cp a, $1c ; $60b3
	jp z, Label_03_6106 ; $60b5
	cp a, $1d ; $60b8
	jp z, Label_03_612e ; $60ba
	cp a, $1e ; $60bd
	jp z, Label_03_6156 ; $60bf
	cp a, $1f ; $60c2
	jp z, Label_03_617e ; $60c4
	cp a, $20 ; $60c7
	jp z, Label_03_61a6 ; $60c9
	cp a, $21 ; $60cc
	jp z, Label_03_61ce ; $60ce
	cp a, $22 ; $60d1
	jp z, Label_03_61f6 ; $60d3
	cp a, $23 ; $60d6
	jp z, Label_03_621e ; $60d8
	jp Label_03_6246 ; $60db
Label_03_60de:
	ld a, $01 ; $60de
	ldh [$ff96], a ; $60e0
	ldh [rWBK], a ; $60e2
	ld hl, $6c6b ; $60e4
	ld de, $d0c0 ; $60e7
	call DecompressData ; $60ea
	ld hl, $d0c0 ; $60ed
	ld de, $80c0 ; $60f0
	ld c, $02 ; $60f3
	call Func_00_0480 ; $60f5
	ld hl, $6f68 ; $60f8
	ld d, $2e ; $60fb
	ld e, $80 ; $60fd
	ld bc, $030c ; $60ff
	call Func_00_1e9d ; $6102
	ret ; $6105
Label_03_6106:
	ld a, $01 ; $6106
	ldh [$ff96], a ; $6108
	ldh [rWBK], a ; $610a
	ld hl, $6c7a ; $610c
	ld de, $d0c0 ; $610f
	call DecompressData ; $6112
	ld hl, $d0c0 ; $6115
	ld de, $80c0 ; $6118
	ld c, $02 ; $611b
	call Func_00_0480 ; $611d
	ld hl, $6f6d ; $6120
	ld d, $2e ; $6123
	ld e, $80 ; $6125
	ld bc, $030c ; $6127
	call Func_00_1e9d ; $612a
	ret ; $612d
Label_03_612e:
	ld a, $01 ; $612e
	ldh [$ff96], a ; $6130
	ldh [rWBK], a ; $6132
	ld hl, $6c89 ; $6134
	ld de, $d0c0 ; $6137
	call DecompressData ; $613a
	ld hl, $d0c0 ; $613d
	ld de, $80c0 ; $6140
	ld c, $02 ; $6143
	call Func_00_0480 ; $6145
	ld hl, $6f72 ; $6148
	ld d, $2e ; $614b
	ld e, $80 ; $614d
	ld bc, $030c ; $614f
	call Func_00_1e9d ; $6152
	ret ; $6155
Label_03_6156:
	ld a, $01 ; $6156
	ldh [$ff96], a ; $6158
	ldh [rWBK], a ; $615a
	ld hl, $6c98 ; $615c
	ld de, $d0c0 ; $615f
	call DecompressData ; $6162
	ld hl, $d0c0 ; $6165
	ld de, $80c0 ; $6168
	ld c, $02 ; $616b
	call Func_00_0480 ; $616d
	ld hl, $6f77 ; $6170
	ld d, $2e ; $6173
	ld e, $80 ; $6175
	ld bc, $030c ; $6177
	call Func_00_1e9d ; $617a
	ret ; $617d
Label_03_617e:
	ld a, $01 ; $617e
	ldh [$ff96], a ; $6180
	ldh [rWBK], a ; $6182
	ld hl, $6cab ; $6184
	ld de, $d0c0 ; $6187
	call DecompressData ; $618a
	ld hl, $d0c0 ; $618d
	ld de, $80c0 ; $6190
	ld c, $02 ; $6193
	call Func_00_0480 ; $6195
	ld hl, $6f7c ; $6198
	ld d, $2e ; $619b
	ld e, $80 ; $619d
	ld bc, $030c ; $619f
	call Func_00_1e9d ; $61a2
	ret ; $61a5
Label_03_61a6:
	ld a, $01 ; $61a6
	ldh [$ff96], a ; $61a8
	ldh [rWBK], a ; $61aa
	ld hl, $6cc1 ; $61ac
	ld de, $d0c0 ; $61af
	call DecompressData ; $61b2
	ld hl, $d0c0 ; $61b5
	ld de, $80c0 ; $61b8
	ld c, $02 ; $61bb
	call Func_00_0480 ; $61bd
	ld hl, $6f81 ; $61c0
	ld d, $2e ; $61c3
	ld e, $80 ; $61c5
	ld bc, $030c ; $61c7
	call Func_00_1e9d ; $61ca
	ret ; $61cd
Label_03_61ce:
	ld a, $01 ; $61ce
	ldh [$ff96], a ; $61d0
	ldh [rWBK], a ; $61d2
	ld hl, $6cd7 ; $61d4
	ld de, $d0c0 ; $61d7
	call DecompressData ; $61da
	ld hl, $d0c0 ; $61dd
	ld de, $80c0 ; $61e0
	ld c, $02 ; $61e3
	call Func_00_0480 ; $61e5
	ld hl, $6f86 ; $61e8
	ld d, $2e ; $61eb
	ld e, $80 ; $61ed
	ld bc, $030c ; $61ef
	call Func_00_1e9d ; $61f2
	ret ; $61f5
Label_03_61f6:
	ld a, $01 ; $61f6
	ldh [$ff96], a ; $61f8
	ldh [rWBK], a ; $61fa
	ld hl, $6ced ; $61fc
	ld de, $d0c0 ; $61ff
	call DecompressData ; $6202
	ld hl, $d0c0 ; $6205
	ld de, $80c0 ; $6208
	ld c, $02 ; $620b
	call Func_00_0480 ; $620d
	ld hl, $6f8b ; $6210
	ld d, $2e ; $6213
	ld e, $80 ; $6215
	ld bc, $030c ; $6217
	call Func_00_1e9d ; $621a
	ret ; $621d
Label_03_621e:
	ld a, $01 ; $621e
	ldh [$ff96], a ; $6220
	ldh [rWBK], a ; $6222
	ld hl, $6d03 ; $6224
	ld de, $d0c0 ; $6227
	call DecompressData ; $622a
	ld hl, $d0c0 ; $622d
	ld de, $80c0 ; $6230
	ld c, $02 ; $6233
	call Func_00_0480 ; $6235
	ld hl, $6f90 ; $6238
	ld d, $2e ; $623b
	ld e, $80 ; $623d
	ld bc, $030c ; $623f
	call Func_00_1e9d ; $6242
	ret ; $6245
Label_03_6246:
	ld hl, $6f90 ; $6246
	ld d, $2e ; $6249
	ld e, $80 ; $624b
	ld bc, $030c ; $624d
	call Func_00_1e9d ; $6250
	ret ; $6253
Func_03_6254:
	ld a, $06 ; $6254
	ldh [$ff96], a ; $6256
	ldh [rWBK], a ; $6258
	ld a, [$d000] ; $625a
	ld b, a ; $625d
	sub a, $24 ; $625e
	ret c ; $6260
	ld a, b ; $6261
	cp a, $24 ; $6262
	jp z, Label_03_6292 ; $6264
	cp a, $25 ; $6267
	jp z, Label_03_62ba ; $6269
	cp a, $26 ; $626c
	jp z, Label_03_62e2 ; $626e
	cp a, $27 ; $6271
	jp z, Label_03_630a ; $6273
	cp a, $28 ; $6276
	jp z, Label_03_6332 ; $6278
	cp a, $29 ; $627b
	jp z, Label_03_635a ; $627d
	cp a, $2a ; $6280
	jp z, Label_03_6382 ; $6282
	cp a, $2b ; $6285
	jp z, Label_03_63aa ; $6287
	cp a, $2c ; $628a
	jp z, Label_03_63d2 ; $628c
	jp Label_03_63fa ; $628f
Label_03_6292:
	ld a, $01 ; $6292
	ldh [$ff96], a ; $6294
	ldh [rWBK], a ; $6296
	ld hl, $6d19 ; $6298
	ld de, $d0e0 ; $629b
	call DecompressData ; $629e
	ld hl, $d0e0 ; $62a1
	ld de, $80e0 ; $62a4
	ld c, $02 ; $62a7
	call Func_00_0480 ; $62a9
	ld hl, $6f95 ; $62ac
	ld d, $36 ; $62af
	ld e, $80 ; $62b1
	ld bc, $020e ; $62b3
	call Func_00_1e9d ; $62b6
	ret ; $62b9
Label_03_62ba:
	ld a, $01 ; $62ba
	ldh [$ff96], a ; $62bc
	ldh [rWBK], a ; $62be
	ld hl, $6d28 ; $62c0
	ld de, $d0e0 ; $62c3
	call DecompressData ; $62c6
	ld hl, $d0e0 ; $62c9
	ld de, $80e0 ; $62cc
	ld c, $02 ; $62cf
	call Func_00_0480 ; $62d1
	ld hl, $6f9a ; $62d4
	ld d, $36 ; $62d7
	ld e, $80 ; $62d9
	ld bc, $020e ; $62db
	call Func_00_1e9d ; $62de
	ret ; $62e1
Label_03_62e2:
	ld a, $01 ; $62e2
	ldh [$ff96], a ; $62e4
	ldh [rWBK], a ; $62e6
	ld hl, $6d37 ; $62e8
	ld de, $d0e0 ; $62eb
	call DecompressData ; $62ee
	ld hl, $d0e0 ; $62f1
	ld de, $80e0 ; $62f4
	ld c, $02 ; $62f7
	call Func_00_0480 ; $62f9
	ld hl, $6f9f ; $62fc
	ld d, $36 ; $62ff
	ld e, $80 ; $6301
	ld bc, $020e ; $6303
	call Func_00_1e9d ; $6306
	ret ; $6309
Label_03_630a:
	ld a, $01 ; $630a
	ldh [$ff96], a ; $630c
	ldh [rWBK], a ; $630e
	ld hl, $6d46 ; $6310
	ld de, $d0e0 ; $6313
	call DecompressData ; $6316
	ld hl, $d0e0 ; $6319
	ld de, $80e0 ; $631c
	ld c, $02 ; $631f
	call Func_00_0480 ; $6321
	ld hl, $6fa4 ; $6324
	ld d, $36 ; $6327
	ld e, $80 ; $6329
	ld bc, $020e ; $632b
	call Func_00_1e9d ; $632e
	ret ; $6331
Label_03_6332:
	ld a, $01 ; $6332
	ldh [$ff96], a ; $6334
	ldh [rWBK], a ; $6336
	ld hl, $6d5a ; $6338
	ld de, $d0e0 ; $633b
	call DecompressData ; $633e
	ld hl, $d0e0 ; $6341
	ld de, $80e0 ; $6344
	ld c, $02 ; $6347
	call Func_00_0480 ; $6349
	ld hl, $6fa9 ; $634c
	ld d, $36 ; $634f
	ld e, $80 ; $6351
	ld bc, $020e ; $6353
	call Func_00_1e9d ; $6356
	ret ; $6359
Label_03_635a:
	ld a, $01 ; $635a
	ldh [$ff96], a ; $635c
	ldh [rWBK], a ; $635e
	ld hl, $6d6f ; $6360
	ld de, $d0e0 ; $6363
	call DecompressData ; $6366
	ld hl, $d0e0 ; $6369
	ld de, $80e0 ; $636c
	ld c, $02 ; $636f
	call Func_00_0480 ; $6371
	ld hl, $6fae ; $6374
	ld d, $36 ; $6377
	ld e, $80 ; $6379
	ld bc, $020e ; $637b
	call Func_00_1e9d ; $637e
	ret ; $6381
Label_03_6382:
	ld a, $01 ; $6382
	ldh [$ff96], a ; $6384
	ldh [rWBK], a ; $6386
	ld hl, $6d85 ; $6388
	ld de, $d0e0 ; $638b
	call DecompressData ; $638e
	ld hl, $d0e0 ; $6391
	ld de, $80e0 ; $6394
	ld c, $02 ; $6397
	call Func_00_0480 ; $6399
	ld hl, $6fb3 ; $639c
	ld d, $36 ; $639f
	ld e, $80 ; $63a1
	ld bc, $020e ; $63a3
	call Func_00_1e9d ; $63a6
	ret ; $63a9
Label_03_63aa:
	ld a, $01 ; $63aa
	ldh [$ff96], a ; $63ac
	ldh [rWBK], a ; $63ae
	ld hl, $6d9b ; $63b0
	ld de, $d0e0 ; $63b3
	call DecompressData ; $63b6
	ld hl, $d0e0 ; $63b9
	ld de, $80e0 ; $63bc
	ld c, $02 ; $63bf
	call Func_00_0480 ; $63c1
	ld hl, $6fb8 ; $63c4
	ld d, $36 ; $63c7
	ld e, $80 ; $63c9
	ld bc, $020e ; $63cb
	call Func_00_1e9d ; $63ce
	ret ; $63d1
Label_03_63d2:
	ld a, $01 ; $63d2
	ldh [$ff96], a ; $63d4
	ldh [rWBK], a ; $63d6
	ld hl, $6db1 ; $63d8
	ld de, $d0e0 ; $63db
	call DecompressData ; $63de
	ld hl, $d0e0 ; $63e1
	ld de, $80e0 ; $63e4
	ld c, $02 ; $63e7
	call Func_00_0480 ; $63e9
	ld hl, $6fbd ; $63ec
	ld d, $36 ; $63ef
	ld e, $80 ; $63f1
	ld bc, $020e ; $63f3
	call Func_00_1e9d ; $63f6
	ret ; $63f9
Label_03_63fa:
	ld hl, $6fbd ; $63fa
	ld d, $36 ; $63fd
	ld e, $80 ; $63ff
	ld bc, $020e ; $6401
	call Func_00_1e9d ; $6404
	ret ; $6407
Func_03_6408:
	ld a, $06 ; $6408
	ldh [$ff96], a ; $640a
	ldh [rWBK], a ; $640c
	ld a, [$d000] ; $640e
	ld b, a ; $6411
	sub a, $2d ; $6412
	ret c ; $6414
	ld a, b ; $6415
	cp a, $2d ; $6416
	jp z, Label_03_6446 ; $6418
	cp a, $2e ; $641b
	jp z, Label_03_646e ; $641d
	cp a, $2f ; $6420
	jp z, Label_03_6496 ; $6422
	cp a, $30 ; $6425
	jp z, Label_03_64be ; $6427
	cp a, $31 ; $642a
	jp z, Label_03_64e6 ; $642c
	cp a, $32 ; $642f
	jp z, Label_03_650e ; $6431
	cp a, $33 ; $6434
	jp z, Label_03_6536 ; $6436
	cp a, $34 ; $6439
	jp z, Label_03_655e ; $643b
	cp a, $35 ; $643e
	jp z, Label_03_6586 ; $6440
	jp Label_03_65ae ; $6443
Label_03_6446:
	ld a, $01 ; $6446
	ldh [$ff96], a ; $6448
	ldh [rWBK], a ; $644a
	ld hl, $6dc7 ; $644c
	ld de, $d100 ; $644f
	call DecompressData ; $6452
	ld hl, $d100 ; $6455
	ld de, $8100 ; $6458
	ld c, $02 ; $645b
	call Func_00_0480 ; $645d
	ld hl, $6fc2 ; $6460
	ld d, $3e ; $6463
	ld e, $80 ; $6465
	ld bc, $0310 ; $6467
	call Func_00_1e9d ; $646a
	ret ; $646d
Label_03_646e:
	ld a, $01 ; $646e
	ldh [$ff96], a ; $6470
	ldh [rWBK], a ; $6472
	ld hl, $6dd6 ; $6474
	ld de, $d100 ; $6477
	call DecompressData ; $647a
	ld hl, $d100 ; $647d
	ld de, $8100 ; $6480
	ld c, $02 ; $6483
	call Func_00_0480 ; $6485
	ld hl, $6fc7 ; $6488
	ld d, $3e ; $648b
	ld e, $80 ; $648d
	ld bc, $0310 ; $648f
	call Func_00_1e9d ; $6492
	ret ; $6495
Label_03_6496:
	ld a, $01 ; $6496
	ldh [$ff96], a ; $6498
	ldh [rWBK], a ; $649a
	ld hl, $6de5 ; $649c
	ld de, $d100 ; $649f
	call DecompressData ; $64a2
	ld hl, $d100 ; $64a5
	ld de, $8100 ; $64a8
	ld c, $02 ; $64ab
	call Func_00_0480 ; $64ad
	ld hl, $6fcc ; $64b0
	ld d, $3e ; $64b3
	ld e, $80 ; $64b5
	ld bc, $0310 ; $64b7
	call Func_00_1e9d ; $64ba
	ret ; $64bd
Label_03_64be:
	ld a, $01 ; $64be
	ldh [$ff96], a ; $64c0
	ldh [rWBK], a ; $64c2
	ld hl, $6df4 ; $64c4
	ld de, $d100 ; $64c7
	call DecompressData ; $64ca
	ld hl, $d100 ; $64cd
	ld de, $8100 ; $64d0
	ld c, $02 ; $64d3
	call Func_00_0480 ; $64d5
	ld hl, $6fd1 ; $64d8
	ld d, $3e ; $64db
	ld e, $80 ; $64dd
	ld bc, $0310 ; $64df
	call Func_00_1e9d ; $64e2
	ret ; $64e5
Label_03_64e6:
	ld a, $01 ; $64e6
	ldh [$ff96], a ; $64e8
	ldh [rWBK], a ; $64ea
	ld hl, $6e07 ; $64ec
	ld de, $d100 ; $64ef
	call DecompressData ; $64f2
	ld hl, $d100 ; $64f5
	ld de, $8100 ; $64f8
	ld c, $02 ; $64fb
	call Func_00_0480 ; $64fd
	ld hl, $6fd6 ; $6500
	ld d, $3e ; $6503
	ld e, $80 ; $6505
	ld bc, $0310 ; $6507
	call Func_00_1e9d ; $650a
	ret ; $650d
Label_03_650e:
	ld a, $01 ; $650e
	ldh [$ff96], a ; $6510
	ldh [rWBK], a ; $6512
	ld hl, $6e1d ; $6514
	ld de, $d100 ; $6517
	call DecompressData ; $651a
	ld hl, $d100 ; $651d
	ld de, $8100 ; $6520
	ld c, $02 ; $6523
	call Func_00_0480 ; $6525
	ld hl, $6fdb ; $6528
	ld d, $3e ; $652b
	ld e, $80 ; $652d
	ld bc, $0310 ; $652f
	call Func_00_1e9d ; $6532
	ret ; $6535
Label_03_6536:
	ld a, $01 ; $6536
	ldh [$ff96], a ; $6538
	ldh [rWBK], a ; $653a
	ld hl, $6e33 ; $653c
	ld de, $d100 ; $653f
	call DecompressData ; $6542
	ld hl, $d100 ; $6545
	ld de, $8100 ; $6548
	ld c, $02 ; $654b
	call Func_00_0480 ; $654d
	ld hl, $6fe0 ; $6550
	ld d, $3e ; $6553
	ld e, $80 ; $6555
	ld bc, $0310 ; $6557
	call Func_00_1e9d ; $655a
	ret ; $655d
Label_03_655e:
	ld a, $01 ; $655e
	ldh [$ff96], a ; $6560
	ldh [rWBK], a ; $6562
	ld hl, $6e49 ; $6564
	ld de, $d100 ; $6567
	call DecompressData ; $656a
	ld hl, $d100 ; $656d
	ld de, $8100 ; $6570
	ld c, $02 ; $6573
	call Func_00_0480 ; $6575
	ld hl, $6fe5 ; $6578
	ld d, $3e ; $657b
	ld e, $80 ; $657d
	ld bc, $0310 ; $657f
	call Func_00_1e9d ; $6582
	ret ; $6585
Label_03_6586:
	ld a, $01 ; $6586
	ldh [$ff96], a ; $6588
	ldh [rWBK], a ; $658a
	ld hl, $6e5f ; $658c
	ld de, $d100 ; $658f
	call DecompressData ; $6592
	ld hl, $d100 ; $6595
	ld de, $8100 ; $6598
	ld c, $02 ; $659b
	call Func_00_0480 ; $659d
	ld hl, $6fea ; $65a0
	ld d, $3e ; $65a3
	ld e, $80 ; $65a5
	ld bc, $0310 ; $65a7
	call Func_00_1e9d ; $65aa
	ret ; $65ad
Label_03_65ae:
	ld hl, $6fea ; $65ae
	ld d, $3e ; $65b1
	ld e, $80 ; $65b3
	ld bc, $0310 ; $65b5
	call Func_00_1e9d ; $65b8
	ret ; $65bb
	INCBIN "data/bank_003/d_65bc.bin" ; $65bc, 93 bytes
	pop hl ; $6619
	or a, h ; $661a
	or a, h ; $661b
	ld [hl], $ce ; $661c
	pop hl ; $661e
	ld b, $b2 ; $661f
	ret z ; $6621
	pop hl ; $6622
	or a, b ; $6623
	or a, b ; $6624
	nop ; $6625
	nop ; $6626
	nop ; $6627
	or a, a ; $6628
	rlca ; $6629
	rlca ; $662a
	nop ; $662b
	rst Rst38 ; $662c
	ldh [rAUD1SWEEP], a ; $662d
	rra ; $662f
	ld a, [$31e7] ; $6630
	INCBIN "data/bank_003/d_6633.bin" ; $6633, 2492 bytes
Func_03_6fef:
	ld a, b ; $6fef
	ld [hl+], a ; $6ff0
	dec de ; $6ff1
	ld a, d ; $6ff2
	or a, e ; $6ff3
	jr nz, Func_03_6fef ; $6ff4
	ret ; $6ff6
Func_03_6ff7:
	push af ; $6ff7
	push bc ; $6ff8
	push de ; $6ff9
	push hl ; $6ffa
	ld b, a ; $6ffb
	ldh a, [$ff96] ; $6ffc
	push af ; $6ffe
	ld a, b ; $6fff
	push af ; $7000
	ld hl, $7090 ; $7001
	ld de, $8ff0 ; $7004
	ld c, $01 ; $7007
	call Func_00_0480 ; $7009
	ld hl, $70a0 ; $700c
	ld de, $bc00 ; $700f
	ld c, $10 ; $7012
	call Func_00_0480 ; $7014
	ld hl, $71a0 ; $7017
	ld de, $9c00 ; $701a
	ld c, $10 ; $701d
	call Func_00_0480 ; $701f
	call Func_00_2631 ; $7022
	farcall FarPtr_0a_a0 ; $7025
	ld a, $90 ; $7028
	ldh [rWY], a ; $702a
	ld a, $06 ; $702c
	ldh [$ff96], a ; $702e
	ldh [rWBK], a ; $7030
	xor a, a ; $7032
	ld [$d000], a ; $7033
	ld [$cb60], a ; $7036
	pop af ; $7039
	push af ; $703a
	ld [$d1fe], a ; $703b
	ld a, $01 ; $703e
	ld hl, $72a0 ; $7040
	call Func_00_1b6a ; $7043
Label_03_7046:
	call Func_00_2631 ; $7046
	ld a, [$d000] ; $7049
	or a, a ; $704c
	jr z, Label_03_7046 ; $704d
	ld a, $20 ; $704f
Label_03_7051:
	call Func_00_2631 ; $7051
	dec a ; $7054
	or a, a ; $7055
	jr nz, Label_03_7051 ; $7056
	ld a, $01 ; $7058
	ldh [$ff96], a ; $705a
	ldh [rWBK], a ; $705c
	ld hl, $d000 ; $705e
	ld b, $20 ; $7061
	ld de, $0300 ; $7063
	call Func_03_6fef ; $7066
	ld a, $05 ; $7069
	ldh [$ff96], a ; $706b
	ldh [rWBK], a ; $706d
	ld hl, $d000 ; $706f
	ld b, $20 ; $7072
	ld de, $0100 ; $7074
	call Func_03_6fef ; $7077
	call Func_00_2631 ; $707a
	pop af ; $707d
	call Func_03_7333 ; $707e
	call Func_03_7452 ; $7081
	pop af ; $7084
	ldh [$ff96], a ; $7085
	ldh [rWBK], a ; $7087
	pop hl ; $7089
	pop de ; $708a
	pop bc ; $708b
	pop af ; $708c
	ret ; $708d
	INCBIN "data/bank_003/d_708e.bin" ; $708e, 677 bytes
Func_03_7333:
	push af ; $7333
	push bc ; $7334
	push de ; $7335
	push hl ; $7336
	ld b, a ; $7337
	ldh a, [$ff96] ; $7338
	push af ; $733a
	and a, $0f ; $733b
	ld a, b ; $733d
	ld c, a ; $733e
	add a, a ; $733f
	add a, c ; $7340
	add a, a ; $7341
	add a, c ; $7342
	ld hl, $7370 ; $7343
	add a, l ; $7346
	ld l, a ; $7347
	jr nc, Label_03_734b ; $7348
	inc h ; $734a
Label_03_734b:
	ld a, $06 ; $734b
	ldh [$ff96], a ; $734d
	ldh [rWBK], a ; $734f
	ld a, [hl] ; $7351
	ld [$d001], a ; $7352
	ld b, a ; $7355
	inc hl ; $7356
	ld c, $00 ; $7357
Label_03_7359:
	call Func_03_7403 ; $7359
	call Func_00_2631 ; $735c
	inc hl ; $735f
	inc hl ; $7360
	inc c ; $7361
	ld a, c ; $7362
	cp a, b ; $7363
	jr nz, Label_03_7359 ; $7364
	pop af ; $7366
	ldh [$ff96], a ; $7367
	ldh [rWBK], a ; $7369
	pop hl ; $736b
	pop de ; $736c
	pop bc ; $736d
	pop af ; $736e
	ret ; $736f
	INCBIN "data/bank_003/d_7370.bin" ; $7370, 147 bytes
Func_03_7403:
	push af ; $7403
	push bc ; $7404
	push de ; $7405
	push hl ; $7406
	ldh a, [$ff96] ; $7407
	push af ; $7409
	push hl ; $740a
	ld hl, $0014 ; $740b
	ld a, c ; $740e
	or a, a ; $740f
	jr nz, Label_03_7418 ; $7410
	ld h, $00 ; $7412
	ld l, $00 ; $7414
	jr Label_03_741b ; $7416
Label_03_7418:
	call Func_00_0926 ; $7418
Label_03_741b:
	ld de, $d063 ; $741b
	add hl, de ; $741e
	ld d, h ; $741f
	ld e, l ; $7420
	pop hl ; $7421
	ld a, [hl+] ; $7422
	push af ; $7423
	ld a, [hl] ; $7424
	ld b, a ; $7425
	ld hl, $30ab ; $7426
	pop af ; $7429
	add a, l ; $742a
	ld l, a ; $742b
	jr nc, Label_03_742f ; $742c
	inc h ; $742e
Label_03_742f:
	ld a, $01 ; $742f
	ldh [$ff96], a ; $7431
	ldh [rWBK], a ; $7433
Label_03_7435:
	ld c, $50 ; $7435
	call Func_03_74f2 ; $7437
	call Func_00_2631 ; $743a
	ld a, $50 ; $743d
	add a, e ; $743f
	ld e, a ; $7440
	jr nc, Label_03_7444 ; $7441
	inc d ; $7443
Label_03_7444:
	inc hl ; $7444
	dec b ; $7445
	jr nz, Label_03_7435 ; $7446
	pop af ; $7448
	ldh [$ff96], a ; $7449
	ldh [rWBK], a ; $744b
	pop hl ; $744d
	pop de ; $744e
	pop bc ; $744f
	pop af ; $7450
	ret ; $7451
Func_03_7452:
	push af ; $7452
	push bc ; $7453
	push de ; $7454
	push hl ; $7455
	ldh a, [$ff96] ; $7456
	push af ; $7458
	ld a, $06 ; $7459
	ldh [$ff96], a ; $745b
	ldh [rWBK], a ; $745d
	ld a, [$d001] ; $745f
	and a, $03 ; $7462
	jr nz, Label_03_7468 ; $7464
	ld a, $01 ; $7466
Label_03_7468:
	ld b, a ; $7468
	ld d, $00 ; $7469
	ld c, $00 ; $746b
Label_03_746d:
	call Func_00_2631 ; $746d
	ld e, $14 ; $7470
Label_03_7472:
	call Func_03_7490 ; $7472
	inc c ; $7475
	dec e ; $7476
	jr nz, Label_03_7472 ; $7477
	ld e, $ff ; $7479
Label_03_747b:
	call Func_00_2631 ; $747b
	dec e ; $747e
	jr nz, Label_03_747b ; $747f
	inc d ; $7481
	ld a, d ; $7482
	cp a, b ; $7483
	jr nz, Label_03_746d ; $7484
	pop af ; $7486
	ldh [$ff96], a ; $7487
	ldh [rWBK], a ; $7489
	pop hl ; $748b
	pop de ; $748c
	pop bc ; $748d
	pop af ; $748e
	ret ; $748f
Func_03_7490:
	push af ; $7490
	push bc ; $7491
	push de ; $7492
	push hl ; $7493
	ldh a, [$ff96] ; $7494
	push af ; $7496
	ld hl, $d000 ; $7497
	ld a, c ; $749a
	add a, l ; $749b
	ld l, a ; $749c
	jr nc, Label_03_74a0 ; $749d
	inc h ; $749f
Label_03_74a0:
	ld b, $08 ; $74a0
	ld de, $d000 ; $74a2
Label_03_74a5:
	ld c, $14 ; $74a5
	push hl ; $74a7
	push de ; $74a8
Label_03_74a9:
	ld a, $01 ; $74a9
	ldh [$ff96], a ; $74ab
	ldh [rWBK], a ; $74ad
	ld a, [hl+] ; $74af
	push hl ; $74b0
	ld h, d ; $74b1
	ld l, e ; $74b2
	push af ; $74b3
	ld a, $05 ; $74b4
	ldh [$ff96], a ; $74b6
	ldh [rWBK], a ; $74b8
	pop af ; $74ba
	ld [hl], a ; $74bb
	inc de ; $74bc
	pop hl ; $74bd
	dec c ; $74be
	jr nz, Label_03_74a9 ; $74bf
	pop de ; $74c1
	pop hl ; $74c2
	ld a, $50 ; $74c3
	add a, l ; $74c5
	ld l, a ; $74c6
	jr nc, Label_03_74ca ; $74c7
	inc h ; $74c9
Label_03_74ca:
	ld a, $20 ; $74ca
	add a, e ; $74cc
	ld e, a ; $74cd
	jr nc, Label_03_74d1 ; $74ce
	inc d ; $74d0
Label_03_74d1:
	dec b ; $74d1
	jr nz, Label_03_74a5 ; $74d2
	ld a, $05 ; $74d4
	ldh [$ff96], a ; $74d6
	ldh [rWBK], a ; $74d8
	ld hl, $d000 ; $74da
	ld de, $9c00 ; $74dd
	ld c, $10 ; $74e0
	call Func_00_0480 ; $74e2
	call Func_00_2631 ; $74e5
	pop af ; $74e8
	ldh [$ff96], a ; $74e9
	ldh [rWBK], a ; $74eb
	pop hl ; $74ed
	pop de ; $74ee
	pop bc ; $74ef
	pop af ; $74f0
	ret ; $74f1
Func_03_74f2:
	push af ; $74f2
	push bc ; $74f3
	push de ; $74f4
	push hl ; $74f5
	ldh a, [$ff96] ; $74f6
	push af ; $74f8
	farcall FarPtr_05_1e ; $74f9
	ld hl, $c600 ; $74fc
	ld a, $01 ; $74ff
	ldh [$ff96], a ; $7501
	ldh [rWBK], a ; $7503
	ld c, $14 ; $7505
Label_03_7507:
	ld a, [hl+] ; $7507
	or a, a ; $7508
	jr z, Label_03_7514 ; $7509
	push hl ; $750b
	ld h, d ; $750c
	ld l, e ; $750d
	ld [hl], a ; $750e
	pop hl ; $750f
	inc de ; $7510
	dec c ; $7511
	jr nz, Label_03_7507 ; $7512
Label_03_7514:
	pop af ; $7514
	ldh [$ff96], a ; $7515
	ldh [rWBK], a ; $7517
	pop hl ; $7519
	pop de ; $751a
	pop bc ; $751b
	pop af ; $751c
	ret ; $751d
Func_03_751e:
	push af ; $751e
	push bc ; $751f
	push de ; $7520
	push hl ; $7521
	ldh a, [$ff96] ; $7522
	push af ; $7524
	ld a, $02 ; $7525
	ldh [$ff96], a ; $7527
	ldh [rWBK], a ; $7529
	ld hl, $d000 ; $752b
	ld de, $0240 ; $752e
	ld b, $00 ; $7531
	call Func_03_6fef ; $7533
	ld a, $03 ; $7536
	ldh [$ff96], a ; $7538
	ldh [rWBK], a ; $753a
	ld hl, $d000 ; $753c
	ld de, $0240 ; $753f
	ld b, $20 ; $7542
	call Func_03_6fef ; $7544
	ld hl, $3140 ; $7547
	ld de, $d0c0 ; $754a
	ld bc, $0020 ; $754d
	farcall FarPtr_1e_0a ; $7550
	ld hl, $3142 ; $7553
	ld de, $d180 ; $7556
	ld bc, $0020 ; $7559
	farcall FarPtr_1e_0a ; $755c
	ld a, $02 ; $755f
	ldh [$ff96], a ; $7561
	ldh [rWBK], a ; $7563
	ld hl, $d000 ; $7565
	ld de, $b800 ; $7568
	ld c, $24 ; $756b
	call Func_00_0480 ; $756d
	ld a, $03 ; $7570
	ldh [$ff96], a ; $7572
	ldh [rWBK], a ; $7574
	ld hl, $d000 ; $7576
	ld de, $9800 ; $7579
	ld c, $24 ; $757c
	call Func_00_0480 ; $757e
	xor a, a ; $7581
	ldh [$ff8b], a ; $7582
	ldh [$ff8a], a ; $7584
	ld [$c320], a ; $7586
	ld [$c321], a ; $7589
	ld [$c322], a ; $758c
	ld [$c323], a ; $758f
	call Func_00_2631 ; $7592
	ld c, $04 ; $7595
	call Func_00_1d2e ; $7597
	call Func_00_1da4 ; $759a
	call Func_00_2725 ; $759d
	ld a, b ; $75a0
	pop af ; $75a1
	ldh [$ff96], a ; $75a2
	ldh [rWBK], a ; $75a4
	pop hl ; $75a6
	pop de ; $75a7
	pop bc ; $75a8
	pop af ; $75a9
	ret ; $75aa
Func_03_75ab:
	ldh a, [$ff96] ; $75ab
	push af ; $75ad
	ld a, $06 ; $75ae
	ldh [$ff96], a ; $75b0
	ldh [rWBK], a ; $75b2
	xor a, a ; $75b4
	ld hl, $d1e0 ; $75b5
	ld b, $10 ; $75b8
Label_03_75ba:
	ld [hl+], a ; $75ba
	dec b ; $75bb
	jr nz, Label_03_75ba ; $75bc
	call Func_03_75e9 ; $75be
	call Func_03_7616 ; $75c1
	pop af ; $75c4
	ldh [$ff96], a ; $75c5
	ldh [rWBK], a ; $75c7
	ret ; $75c9
	INCBIN "data/bank_003/d_75ca.bin" ; $75ca, 31 bytes
Func_03_75e9:
	ld hl, $c200 ; $75e9
	ld de, $d140 ; $75ec
	ld b, $80 ; $75ef
Label_03_75f1:
	ld a, [hl+] ; $75f1
	ld [de], a ; $75f2
	inc de ; $75f3
	dec b ; $75f4
	jr nz, Label_03_75f1 ; $75f5
	ld hl, $c200 ; $75f7
	ld de, $d0a0 ; $75fa
	ld b, $80 ; $75fd
Label_03_75ff:
	ld a, [hl+] ; $75ff
	ld [de], a ; $7600
	inc de ; $7601
	dec b ; $7602
	jr nz, Label_03_75ff ; $7603
	ret ; $7605
	INCBIN "data/bank_003/d_7606.bin" ; $7606, 16 bytes
Func_03_7616:
	ld hl, $d0a0 ; $7616
	ld de, $d1f2 ; $7619
	ld b, $40 ; $761c
Label_03_761e:
	push bc ; $761e
	push hl ; $761f
	ld a, [hl+] ; $7620
	ld b, [hl] ; $7621
	ld c, a ; $7622
	call Func_00_1c6a ; $7623
	ld [de], a ; $7626
	inc de ; $7627
	ld a, b ; $7628
	ld [de], a ; $7629
	inc de ; $762a
	ld a, c ; $762b
	ld [de], a ; $762c
	dec de ; $762d
	dec de ; $762e
	call Func_03_7648 ; $762f
	inc de ; $7632
	inc de ; $7633
	ld a, [de] ; $7634
	ld c, a ; $7635
	dec de ; $7636
	ld a, [de] ; $7637
	ld b, a ; $7638
	dec de ; $7639
	ld a, [de] ; $763a
	call Func_00_1c83 ; $763b
	pop hl ; $763e
	ld a, c ; $763f
	ld [hl+], a ; $7640
	ld [hl], b ; $7641
	inc hl ; $7642
	pop bc ; $7643
	dec b ; $7644
	jr nz, Label_03_761e ; $7645
	ret ; $7647
Func_03_7648:
	ld a, [de] ; $7648
	inc de ; $7649
	ld c, a ; $764a
	ld a, [de] ; $764b
	inc de ; $764c
	add a, c ; $764d
	ld c, a ; $764e
	ld a, [de] ; $764f
	add a, c ; $7650
	ld c, a ; $7651
	ld b, $00 ; $7652
	srl a ; $7654
	srl a ; $7656
	srl a ; $7658
	ld [de], a ; $765a
	dec de ; $765b
	ld h, b ; $765c
	ld l, c ; $765d
	add hl, hl ; $765e
	srl h ; $765f
	rr l ; $7661
	srl h ; $7663
	rr l ; $7665
	srl h ; $7667
	rr l ; $7669
	ld a, l ; $766b
	ld [de], a ; $766c
	dec de ; $766d
	ld h, b ; $766e
	ld l, c ; $766f
	add hl, hl ; $7670
	add hl, hl ; $7671
	srl h ; $7672
	rr l ; $7674
	srl h ; $7676
	rr l ; $7678
	srl h ; $767a
	rr l ; $767c
	ld a, l ; $767e
	bit 5, a ; $767f
	jr z, Label_03_7685 ; $7681
	ld a, $1f ; $7683
Label_03_7685:
	ld [de], a ; $7685
	ret ; $7686
Func_03_7687:
	ldh a, [$ff96] ; $7687
	push af ; $7689
	ld a, $06 ; $768a
	ldh [$ff96], a ; $768c
	ldh [rWBK], a ; $768e
	ld hl, $d1f0 ; $7690
	ld [hl], d ; $7693
	ld l, d ; $7694
	ld h, $00 ; $7695
	ld de, $001f ; $7697
	call Func_00_0987 ; $769a
	ld a, l ; $769d
	ld [$d1f9], a ; $769e
	ld hl, $d1e0 ; $76a1
	bit 7, b ; $76a4
	jr z, Label_03_76aa ; $76a6
	ld [hl], $01 ; $76a8
Label_03_76aa:
	inc hl ; $76aa
	bit 6, b ; $76ab
	jr z, Label_03_76b1 ; $76ad
	ld [hl], $01 ; $76af
Label_03_76b1:
	inc hl ; $76b1
	bit 5, b ; $76b2
	jr z, Label_03_76b8 ; $76b4
	ld [hl], $01 ; $76b6
Label_03_76b8:
	inc hl ; $76b8
	bit 4, b ; $76b9
	jr z, Label_03_76bf ; $76bb
	ld [hl], $01 ; $76bd
Label_03_76bf:
	inc hl ; $76bf
	bit 3, b ; $76c0
	jr z, Label_03_76c6 ; $76c2
	ld [hl], $01 ; $76c4
Label_03_76c6:
	inc hl ; $76c6
	bit 2, b ; $76c7
	jr z, Label_03_76cd ; $76c9
	ld [hl], $01 ; $76cb
Label_03_76cd:
	inc hl ; $76cd
	bit 1, b ; $76ce
	jr z, Label_03_76d4 ; $76d0
	ld [hl], $01 ; $76d2
Label_03_76d4:
	inc hl ; $76d4
	bit 0, b ; $76d5
	jr z, Label_03_76db ; $76d7
	ld [hl], $01 ; $76d9
Label_03_76db:
	inc hl ; $76db
	bit 7, c ; $76dc
	jr z, Label_03_76e2 ; $76de
	ld [hl], $01 ; $76e0
Label_03_76e2:
	inc hl ; $76e2
	bit 6, c ; $76e3
	jr z, Label_03_76e9 ; $76e5
	ld [hl], $01 ; $76e7
Label_03_76e9:
	inc hl ; $76e9
	bit 5, c ; $76ea
	jr z, Label_03_76f0 ; $76ec
	ld [hl], $01 ; $76ee
Label_03_76f0:
	inc hl ; $76f0
	bit 4, c ; $76f1
	jr z, Label_03_76f7 ; $76f3
	ld [hl], $01 ; $76f5
Label_03_76f7:
	inc hl ; $76f7
	bit 3, c ; $76f8
	jr z, Label_03_76fe ; $76fa
	ld [hl], $01 ; $76fc
Label_03_76fe:
	inc hl ; $76fe
	bit 2, c ; $76ff
	jr z, Label_03_7705 ; $7701
	ld [hl], $01 ; $7703
Label_03_7705:
	inc hl ; $7705
	bit 1, c ; $7706
	jr z, Label_03_770c ; $7708
	ld [hl], $01 ; $770a
Label_03_770c:
	inc hl ; $770c
	bit 0, c ; $770d
	jr z, Label_03_7713 ; $770f
	ld [hl], $01 ; $7711
Label_03_7713:
	pop af ; $7713
	ldh [$ff96], a ; $7714
	ldh [rWBK], a ; $7716
	ret ; $7718
Func_03_7719:
	ldh a, [$ff96] ; $7719
	push af ; $771b
	ld a, $06 ; $771c
	ldh [$ff96], a ; $771e
	ldh [rWBK], a ; $7720
Label_03_7722:
	ld a, [$d1f9] ; $7722
Label_03_7725:
	and a, a ; $7725
	jr z, Label_03_772e ; $7726
	call Func_00_2631 ; $7728
	dec a ; $772b
	jr Label_03_7725 ; $772c
Label_03_772e:
	ld de, $d1e0 ; $772e
	ld b, $00 ; $7731
Label_03_7733:
	push de ; $7733
	push bc ; $7734
	ld a, [de] ; $7735
	and a, a ; $7736
	jr z, Label_03_773c ; $7737
	call Func_03_7764 ; $7739
Label_03_773c:
	pop bc ; $773c
	pop de ; $773d
	inc de ; $773e
	inc b ; $773f
	ld a, b ; $7740
	cp a, $10 ; $7741
	jr nz, Label_03_7733 ; $7743
	ld hl, $d140 ; $7745
	ld d, $00 ; $7748
	ld e, $10 ; $774a
	call Func_00_05b5 ; $774c
	call Func_00_2631 ; $774f
	ld hl, $d1f0 ; $7752
	ld a, [hl] ; $7755
	dec a ; $7756
	ld [hl], a ; $7757
	and a, a ; $7758
	jr nz, Label_03_7722 ; $7759
	call Func_03_77e2 ; $775b
	pop af ; $775e
	ldh [$ff96], a ; $775f
	ldh [rWBK], a ; $7761
	ret ; $7763
Func_03_7764:
	ld a, b ; $7764
	ld [$d1f1], a ; $7765
	ld hl, $d0a0 ; $7768
	call Func_03_7829 ; $776b
	ld d, h ; $776e
	ld e, l ; $776f
	ld hl, $d140 ; $7770
	ld a, [$d1f1] ; $7773
	ld b, a ; $7776
	call Func_03_7829 ; $7777
	ld b, $04 ; $777a
Label_03_777c:
	push bc ; $777c
	push de ; $777d
	push hl ; $777e
	ld a, [hl+] ; $777f
	ld b, [hl] ; $7780
	ld c, a ; $7781
	call Func_00_1c6a ; $7782
	ld hl, $d1f2 ; $7785
	ld [hl+], a ; $7788
	ld a, b ; $7789
	ld [hl+], a ; $778a
	ld a, c ; $778b
	ld [hl], a ; $778c
	ld h, d ; $778d
	ld l, e ; $778e
	ld a, [hl+] ; $778f
	ld b, [hl] ; $7790
	ld c, a ; $7791
	call Func_00_1c6a ; $7792
	ld hl, $d1f5 ; $7795
	ld [hl+], a ; $7798
	ld a, b ; $7799
	ld [hl+], a ; $779a
	ld a, c ; $779b
	ld [hl], a ; $779c
	ld hl, $d1f2 ; $779d
	ld de, $d1f5 ; $77a0
	call Func_03_77d0 ; $77a3
	ld hl, $d1f3 ; $77a6
	ld de, $d1f6 ; $77a9
	call Func_03_77d0 ; $77ac
	ld hl, $d1f4 ; $77af
	ld de, $d1f7 ; $77b2
	call Func_03_77d0 ; $77b5
	ld hl, $d1f4 ; $77b8
	ld a, [hl-] ; $77bb
	ld c, a ; $77bc
	ld a, [hl-] ; $77bd
	ld b, a ; $77be
	ld a, [hl] ; $77bf
	call Func_00_1c83 ; $77c0
	pop hl ; $77c3
	ld a, c ; $77c4
	ld [hl+], a ; $77c5
	ld [hl], b ; $77c6
	inc hl ; $77c7
	pop de ; $77c8
	pop bc ; $77c9
	inc de ; $77ca
	inc de ; $77cb
	dec b ; $77cc
	jr nz, Label_03_777c ; $77cd
	ret ; $77cf
Func_03_77d0:
	ld a, [de] ; $77d0
	ld b, [hl] ; $77d1
	sub a, b ; $77d2
	ret z ; $77d3
	jr c, Label_03_77dc ; $77d4
	ld a, [hl] ; $77d6
	inc a ; $77d7
	and a, $1f ; $77d8
	ld [hl], a ; $77da
	ret ; $77db
Label_03_77dc:
	ld a, [hl] ; $77dc
	dec a ; $77dd
	and a, $1f ; $77de
	ld [hl], a ; $77e0
	ret ; $77e1
Func_03_77e2:
	ld hl, $d1e0 ; $77e2
	ld b, $00 ; $77e5
Label_03_77e7:
	push hl ; $77e7
	push bc ; $77e8
	ld a, [hl] ; $77e9
	and a, a ; $77ea
	jr z, Label_03_7815 ; $77eb
	ld c, b ; $77ed
	ld hl, $d0a0 ; $77ee
	call Func_03_7829 ; $77f1
	ld d, h ; $77f4
	ld e, l ; $77f5
	ld b, c ; $77f6
	ld hl, $d140 ; $77f7
	call Func_03_7829 ; $77fa
	ld a, [de] ; $77fd
	ld [hl+], a ; $77fe
	inc de ; $77ff
	ld a, [de] ; $7800
	ld [hl+], a ; $7801
	inc de ; $7802
	ld a, [de] ; $7803
	ld [hl+], a ; $7804
	inc de ; $7805
	ld a, [de] ; $7806
	ld [hl+], a ; $7807
	inc de ; $7808
	ld a, [de] ; $7809
	ld [hl+], a ; $780a
	inc de ; $780b
	ld a, [de] ; $780c
	ld [hl+], a ; $780d
	inc de ; $780e
	ld a, [de] ; $780f
	ld [hl+], a ; $7810
	inc de ; $7811
	ld a, [de] ; $7812
	ld [hl+], a ; $7813
	inc de ; $7814
Label_03_7815:
	pop bc ; $7815
	pop hl ; $7816
	inc hl ; $7817
	inc b ; $7818
	ld a, b ; $7819
	cp a, $10 ; $781a
	jr nz, Label_03_77e7 ; $781c
	ld hl, $d140 ; $781e
	ld d, $00 ; $7821
	ld e, $10 ; $7823
	call Func_00_05b5 ; $7825
	ret ; $7828
Func_03_7829:
	ld a, b ; $7829
	and a, a ; $782a
	ret z ; $782b
	ld a, $08 ; $782c
	add a, l ; $782e
	ld l, a ; $782f
	jr nc, Label_03_7833 ; $7830
	inc h ; $7832
Label_03_7833:
	dec b ; $7833
	jr Func_03_7829 ; $7834
	INCBIN "data/bank_003/d_7836.bin" ; $7836, 1994 bytes
