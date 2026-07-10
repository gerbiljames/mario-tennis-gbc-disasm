INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $03", ROMX[$4000], BANK[$03]

	INCBIN "data/bank_003/d_4000.bin" ; $4000, 74 bytes
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
	INCBIN "data/bank_003/d_4825.bin" ; $4825, 31 bytes
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
	INCBIN "data/bank_003/d_4a3c.bin" ; $4a3c, 26 bytes
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
	INCBIN "data/bank_003/d_4aff.bin" ; $4aff, 29 bytes
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
	INCBIN "data/bank_003/d_4b54.bin" ; $4b54, 71 bytes
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
	INCBIN "data/bank_003/d_4cd3.bin" ; $4cd3, 61 bytes
	ld a, [$c36c] ; $4d10
	cp a, $03 ; $4d13
	ret nc ; $4d15
	call Func_00_2452 ; $4d16
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
	rst Rst18 ; $4e57
	jr nz, Label_03_4e5d ; $4e58
	pop de ; $4e5a
	push de ; $4e5b
	INCBIN "data/bank_003/d_4e5c.bin" ; $4e5c, 1 bytes
Label_03_4e5d:
	ret nz ; $4e5d
	inc b ; $4e5e
	rst Rst18 ; $4e5f
	jr nz, Label_03_4e65 ; $4e60
	pop de ; $4e62
	jr Label_03_4e87 ; $4e63
Label_03_4e65:
	push de ; $4e65
	ld de, $0400 ; $4e66
	rst Rst18 ; $4e69
	jr nz, $4e6f ; $4e6a
	pop de ; $4e6c
	push de ; $4e6d
	ld de, $0480 ; $4e6e
	rst Rst18 ; $4e71
	jr nz, Label_03_4e77 ; $4e72
	pop de ; $4e74
	jr Label_03_4e87 ; $4e75
Label_03_4e77:
	push de ; $4e77
	ld de, $0420 ; $4e78
	rst Rst18 ; $4e7b
	jr nz, Label_03_4e81 ; $4e7c
	pop de ; $4e7e
	push de ; $4e7f
	INCBIN "data/bank_003/d_4e80.bin" ; $4e80, 1 bytes
Label_03_4e81:
	and a, b ; $4e81
	inc b ; $4e82
	rst Rst18 ; $4e83
	jr nz, $4e89 ; $4e84
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
	INCBIN "data/bank_003/d_4f7d.bin" ; $4f7d, 49 bytes
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
	INCBIN "data/bank_003/d_5072.bin" ; $5072, 207 bytes
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
	rst Rst18 ; $515b
	ld [bc], a ; $515c
	dec c ; $515d
	ld hl, $d480 ; $515e
	ld a, e ; $5161
	ld [hl+], a ; $5162
	ld [hl], d ; $5163
	ld a, $01 ; $5164
	rst Rst18 ; $5166
	ld [bc], a ; $5167
	dec c ; $5168
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
	rst Rst18 ; $51c2
	ld [bc], a ; $51c3
	dec c ; $51c4
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
	INCBIN "data/bank_003/d_524f.bin" ; $524f, 702 bytes
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
	rst Rst18 ; $56cd
	ld e, $03 ; $56ce
	pop de ; $56d0
	push de ; $56d1
	ld de, $0140 ; $56d2
	rst Rst18 ; $56d5
	ld e, $03 ; $56d6
	pop de ; $56d8
	push de ; $56d9
	ld de, $0160 ; $56da
	rst Rst18 ; $56dd
	ld e, $03 ; $56de
	pop de ; $56e0
	push de ; $56e1
	ld de, $0180 ; $56e2
	rst Rst18 ; $56e5
	ld e, $03 ; $56e6
	pop de ; $56e8
	push de ; $56e9
	ld de, $01a0 ; $56ea
	rst Rst18 ; $56ed
	ld e, $03 ; $56ee
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
	INCBIN "data/bank_003/d_5787.bin" ; $5787, 91 bytes
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
	rst Rst30 ; $57f6
	jr nz, Label_03_5814 ; $57f7
	jr z, Label_03_5838 ; $57f9
	jr Label_03_581e ; $57fb
Label_03_57fd:
	rst Rst30 ; $57fd
	and a, b ; $57fe
	ld a, [de] ; $57ff
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
Label_03_5814:
	call Func_00_0926 ; $5814
	push hl ; $5817
	pop de ; $5818
	call Func_03_4d86 ; $5819
	jr z, Label_03_5838 ; $581c
Label_03_581e:
	ld a, b ; $581e
	rst Rst18 ; $581f
	ld [bc], a ; $5820
	dec c ; $5821
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
	INCBIN "data/bank_003/d_5844.bin" ; $5844, 365 bytes
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
	INCBIN "data/bank_003/d_59c5.bin" ; $59c5, 9787 bytes
