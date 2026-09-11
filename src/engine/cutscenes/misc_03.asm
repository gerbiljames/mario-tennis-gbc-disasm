InitSaveHeader:
	push af ; $404a
	push bc ; $404b
	push de ; $404c
	push hl ; $404d
	ld a, $00 ; $404e
	ldh [hSramBank], a ; $4050
	ld [rRAMB], a ; $4052
	ld hl, SaveSignature ; $4055
	ld de, sSaveSignature ; $4058
	call CopySaveSignature ; $405b
	ld hl, sSaveBlockDirectory + 1 ; $405e
	ld [hl], $00 ; $4061
	inc hl ; $4063
	ld [hl], $00 ; $4064
	inc hl ; $4066
	ld [hl], $08 ; $4067
	inc hl ; $4069
	ld [hl], $00 ; $406a
	inc hl ; $406c
	ld [hl], $03 ; $406d
	ld hl, sSaveBlockDirectory + 17 ; $406f
	ld [hl], $00 ; $4072
	inc hl ; $4074
	ld [hl], $00 ; $4075
	inc hl ; $4077
	ld [hl], $0b ; $4078
	inc hl ; $407a
	ld [hl], $00 ; $407b
	inc hl ; $407d
	ld [hl], $02 ; $407e
	ld hl, sSaveBlockDirectory + 33 ; $4080
	ld [hl], $00 ; $4083
	inc hl ; $4085
	ld [hl], $00 ; $4086
	inc hl ; $4088
	ld [hl], $0d ; $4089
	inc hl ; $408b
	ld [hl], $00 ; $408c
	inc hl ; $408e
	ld [hl], $03 ; $408f
	ld hl, sSaveBlockDirectory + 49 ; $4091
	ld [hl], $00 ; $4094
	inc hl ; $4096
	ld [hl], $00 ; $4097
	inc hl ; $4099
	ld [hl], $10 ; $409a
	inc hl ; $409c
	ld [hl], $00 ; $409d
	inc hl ; $409f
	ld [hl], $02 ; $40a0
	ld hl, sSaveBlockDirectory + 65 ; $40a2
	ld [hl], $00 ; $40a5
	inc hl ; $40a7
	ld [hl], $00 ; $40a8
	inc hl ; $40aa
	ld [hl], $12 ; $40ab
	inc hl ; $40ad
	ld [hl], $00 ; $40ae
	inc hl ; $40b0
	ld [hl], $03 ; $40b1
	ld hl, sSaveBlockDirectory + 81 ; $40b3
	ld [hl], $00 ; $40b6
	inc hl ; $40b8
	ld [hl], $00 ; $40b9
	inc hl ; $40bb
	ld [hl], $15 ; $40bc
	inc hl ; $40be
	ld [hl], $00 ; $40bf
	inc hl ; $40c1
	ld [hl], $02 ; $40c2
	ld hl, sSaveBlockDirectory + 97 ; $40c4
	ld [hl], $00 ; $40c7
	inc hl ; $40c9
	ld [hl], $00 ; $40ca
	inc hl ; $40cc
	ld [hl], $17 ; $40cd
	inc hl ; $40cf
	ld [hl], $30 ; $40d0
	inc hl ; $40d2
	ld [hl], $00 ; $40d3
	ld hl, sSaveBlockDirectory + 113 ; $40d5
	ld [hl], $00 ; $40d8
	inc hl ; $40da
	ld [hl], $30 ; $40db
	inc hl ; $40dd
	ld [hl], $17 ; $40de
	inc hl ; $40e0
	ld [hl], $20 ; $40e1
	inc hl ; $40e3
	ld [hl], $00 ; $40e4
	ld hl, sSaveBlockDirectory + 129 ; $40e6
	ld [hl], $00 ; $40e9
	inc hl ; $40eb
	ld [hl], $50 ; $40ec
	inc hl ; $40ee
	ld [hl], $17 ; $40ef
	inc hl ; $40f1
	ld [hl], $20 ; $40f2
	inc hl ; $40f4
	ld [hl], $00 ; $40f5
	ld hl, sSaveBlockDirectory + 145 ; $40f7
	ld [hl], $00 ; $40fa
	inc hl ; $40fc
	ld [hl], $70 ; $40fd
	inc hl ; $40ff
	ld [hl], $17 ; $4100
	inc hl ; $4102
	ld [hl], $20 ; $4103
	inc hl ; $4105
	ld [hl], $00 ; $4106
	ld hl, sSaveBlockDirectory + 161 ; $4108
	ld [hl], $00 ; $410b
	inc hl ; $410d
	ld [hl], $90 ; $410e
	inc hl ; $4110
	ld [hl], $17 ; $4111
	inc hl ; $4113
	ld [hl], $10 ; $4114
	inc hl ; $4116
	ld [hl], $00 ; $4117
	ld hl, sSaveBlockDirectory + 177 ; $4119
	ld [hl], $00 ; $411c
	inc hl ; $411e
	ld [hl], $00 ; $411f
	inc hl ; $4121
	ld [hl], $18 ; $4122
	inc hl ; $4124
	ld [hl], $00 ; $4125
	inc hl ; $4127
	ld [hl], $02 ; $4128
	ld hl, sSaveBlockDirectory + 193 ; $412a
	ld [hl], $00 ; $412d
	inc hl ; $412f
	ld [hl], $00 ; $4130
	inc hl ; $4132
	ld [hl], $1a ; $4133
	inc hl ; $4135
	ld [hl], $20 ; $4136
	inc hl ; $4138
	ld [hl], $00 ; $4139
	ld hl, sSaveBlockDirectory + 209 ; $413b
	ld [hl], $00 ; $413e
	inc hl ; $4140
	ld [hl], $20 ; $4141
	inc hl ; $4143
	ld [hl], $1a ; $4144
	inc hl ; $4146
	ld [hl], $20 ; $4147
	inc hl ; $4149
	ld [hl], $00 ; $414a
	ld hl, sSaveBlockDirectory + 225 ; $414c
	ld [hl], $00 ; $414f
	inc hl ; $4151
	ld [hl], $40 ; $4152
	inc hl ; $4154
	ld [hl], $1a ; $4155
	inc hl ; $4157
	ld [hl], $20 ; $4158
	inc hl ; $415a
	ld [hl], $00 ; $415b
	ld hl, sSaveBlockDirectory + 241 ; $415d
	ld [hl], $00 ; $4160
	inc hl ; $4162
	ld [hl], $60 ; $4163
	inc hl ; $4165
	ld [hl], $1a ; $4166
	inc hl ; $4168
	ld [hl], $20 ; $4169
	inc hl ; $416b
	ld [hl], $00 ; $416c
	ld hl, sSaveBlockDirectory + 257 ; $416e
	ld [hl], $00 ; $4171
	inc hl ; $4173
	ld [hl], $80 ; $4174
	inc hl ; $4176
	ld [hl], $1a ; $4177
	inc hl ; $4179
	ld [hl], $80 ; $417a
	inc hl ; $417c
	ld [hl], $00 ; $417d
	ld hl, sSaveBlockDirectory + 273 ; $417f
	ld [hl], $00 ; $4182
	inc hl ; $4184
	ld [hl], $00 ; $4185
	inc hl ; $4187
	ld [hl], $1b ; $4188
	inc hl ; $418a
	ld [hl], $80 ; $418b
	inc hl ; $418d
	ld [hl], $00 ; $418e
	ld hl, sSaveBlockDirectory + 289 ; $4190
	ld [hl], $00 ; $4193
	inc hl ; $4195
	ld [hl], $80 ; $4196
	inc hl ; $4198
	ld [hl], $1b ; $4199
	inc hl ; $419b
	ld [hl], $80 ; $419c
	inc hl ; $419e
	ld [hl], $00 ; $419f
	ld hl, sSaveBlockDirectory + 305 ; $41a1
	ld [hl], $00 ; $41a4
	inc hl ; $41a6
	ld [hl], $00 ; $41a7
	inc hl ; $41a9
	ld [hl], $1c ; $41aa
	inc hl ; $41ac
	ld [hl], $80 ; $41ad
	inc hl ; $41af
	ld [hl], $00 ; $41b0
	ld hl, sSaveBlockDirectory + 321 ; $41b2
	ld [hl], $00 ; $41b5
	inc hl ; $41b7
	ld [hl], $80 ; $41b8
	inc hl ; $41ba
	ld [hl], $1c ; $41bb
	inc hl ; $41bd
	ld [hl], $80 ; $41be
	inc hl ; $41c0
	ld [hl], $00 ; $41c1
	ld hl, sSaveBlockDirectory + 337 ; $41c3
	ld [hl], $00 ; $41c6
	inc hl ; $41c8
	ld [hl], $00 ; $41c9
	inc hl ; $41cb
	ld [hl], $1d ; $41cc
	inc hl ; $41ce
	ld [hl], $80 ; $41cf
	inc hl ; $41d1
	ld [hl], $00 ; $41d2
	ld hl, sSaveBlockDirectory + 353 ; $41d4
	ld [hl], $00 ; $41d7
	inc hl ; $41d9
	ld [hl], $80 ; $41da
	inc hl ; $41dc
	ld [hl], $1d ; $41dd
	inc hl ; $41df
	ld [hl], $80 ; $41e0
	inc hl ; $41e2
	ld [hl], $00 ; $41e3
	ld hl, sSaveBlockDirectory + 369 ; $41e5
	ld [hl], $00 ; $41e8
	inc hl ; $41ea
	ld [hl], $00 ; $41eb
	inc hl ; $41ed
	ld [hl], $1e ; $41ee
	inc hl ; $41f0
	ld [hl], $80 ; $41f1
	inc hl ; $41f3
	ld [hl], $00 ; $41f4
	ld hl, sSaveBlockDirectory + 385 ; $41f6
	ld [hl], $00 ; $41f9
	inc hl ; $41fb
	ld [hl], $80 ; $41fc
	inc hl ; $41fe
	ld [hl], $1e ; $41ff
	inc hl ; $4201
	ld [hl], $80 ; $4202
	inc hl ; $4204
	ld [hl], $00 ; $4205
	ld hl, sSaveBlockDirectory + 401 ; $4207
	ld [hl], $00 ; $420a
	inc hl ; $420c
	ld [hl], $00 ; $420d
	inc hl ; $420f
	ld [hl], $1f ; $4210
	inc hl ; $4212
	ld [hl], $80 ; $4213
	inc hl ; $4215
	ld [hl], $00 ; $4216
	ld hl, sSaveBlockDirectory + 417 ; $4218
	ld [hl], $00 ; $421b
	inc hl ; $421d
	ld [hl], $80 ; $421e
	inc hl ; $4220
	ld [hl], $1f ; $4221
	inc hl ; $4223
	ld [hl], $80 ; $4224
	inc hl ; $4226
	ld [hl], $00 ; $4227
	ld hl, sSaveBlockDirectory + 433 ; $4229
	ld [hl], $01 ; $422c
	inc hl ; $422e
	ld [hl], $00 ; $422f
	inc hl ; $4231
	ld [hl], $08 ; $4232
	inc hl ; $4234
	ld [hl], $00 ; $4235
	inc hl ; $4237
	ld [hl], $03 ; $4238
	ld hl, sSaveBlockDirectory + 449 ; $423a
	ld [hl], $01 ; $423d
	inc hl ; $423f
	ld [hl], $00 ; $4240
	inc hl ; $4242
	ld [hl], $0b ; $4243
	inc hl ; $4245
	ld [hl], $00 ; $4246
	inc hl ; $4248
	ld [hl], $02 ; $4249
	ld hl, sSaveBlockDirectory + 465 ; $424b
	ld [hl], $01 ; $424e
	inc hl ; $4250
	ld [hl], $00 ; $4251
	inc hl ; $4253
	ld [hl], $0d ; $4254
	inc hl ; $4256
	ld [hl], $00 ; $4257
	inc hl ; $4259
	ld [hl], $03 ; $425a
	ld hl, sSaveBlockDirectory + 481 ; $425c
	ld [hl], $01 ; $425f
	inc hl ; $4261
	ld [hl], $00 ; $4262
	inc hl ; $4264
	ld [hl], $10 ; $4265
	inc hl ; $4267
	ld [hl], $00 ; $4268
	inc hl ; $426a
	ld [hl], $02 ; $426b
	ld hl, sSaveBlockDirectory + 497 ; $426d
	ld [hl], $01 ; $4270
	inc hl ; $4272
	ld [hl], $00 ; $4273
	inc hl ; $4275
	ld [hl], $12 ; $4276
	inc hl ; $4278
	ld [hl], $00 ; $4279
	inc hl ; $427b
	ld [hl], $03 ; $427c
	ld hl, sSaveBlockDirectory + 513 ; $427e
	ld [hl], $01 ; $4281
	inc hl ; $4283
	ld [hl], $00 ; $4284
	inc hl ; $4286
	ld [hl], $15 ; $4287
	inc hl ; $4289
	ld [hl], $00 ; $428a
	inc hl ; $428c
	ld [hl], $02 ; $428d
	ld hl, sSaveBlockDirectory + 529 ; $428f
	ld [hl], $01 ; $4292
	inc hl ; $4294
	ld [hl], $00 ; $4295
	inc hl ; $4297
	ld [hl], $17 ; $4298
	inc hl ; $429a
	ld [hl], $30 ; $429b
	inc hl ; $429d
	ld [hl], $00 ; $429e
	ld hl, sSaveBlockDirectory + 545 ; $42a0
	ld [hl], $01 ; $42a3
	inc hl ; $42a5
	ld [hl], $30 ; $42a6
	inc hl ; $42a8
	ld [hl], $17 ; $42a9
	inc hl ; $42ab
	ld [hl], $20 ; $42ac
	inc hl ; $42ae
	ld [hl], $00 ; $42af
	ld hl, sSaveBlockDirectory + 561 ; $42b1
	ld [hl], $01 ; $42b4
	inc hl ; $42b6
	ld [hl], $50 ; $42b7
	inc hl ; $42b9
	ld [hl], $17 ; $42ba
	inc hl ; $42bc
	ld [hl], $20 ; $42bd
	inc hl ; $42bf
	ld [hl], $00 ; $42c0
	ld hl, sSaveBlockDirectory + 577 ; $42c2
	ld [hl], $01 ; $42c5
	inc hl ; $42c7
	ld [hl], $70 ; $42c8
	inc hl ; $42ca
	ld [hl], $17 ; $42cb
	inc hl ; $42cd
	ld [hl], $20 ; $42ce
	inc hl ; $42d0
	ld [hl], $00 ; $42d1
	ld hl, sSaveBlockDirectory + 593 ; $42d3
	ld [hl], $01 ; $42d6
	inc hl ; $42d8
	ld [hl], $90 ; $42d9
	inc hl ; $42db
	ld [hl], $17 ; $42dc
	inc hl ; $42de
	ld [hl], $10 ; $42df
	inc hl ; $42e1
	ld [hl], $00 ; $42e2
	ld hl, sSaveBlockDirectory + 609 ; $42e4
	ld [hl], $01 ; $42e7
	inc hl ; $42e9
	ld [hl], $00 ; $42ea
	inc hl ; $42ec
	ld [hl], $18 ; $42ed
	inc hl ; $42ef
	ld [hl], $80 ; $42f0
	inc hl ; $42f2
	ld [hl], $00 ; $42f3
	ld hl, sSaveBlockDirectory + 625 ; $42f5
	ld [hl], $01 ; $42f8
	inc hl ; $42fa
	ld [hl], $80 ; $42fb
	inc hl ; $42fd
	ld [hl], $18 ; $42fe
	inc hl ; $4300
	ld [hl], $80 ; $4301
	inc hl ; $4303
	ld [hl], $00 ; $4304
	ld hl, sSaveBlockDirectory + 641 ; $4306
	ld [hl], $01 ; $4309
	inc hl ; $430b
	ld [hl], $00 ; $430c
	inc hl ; $430e
	ld [hl], $19 ; $430f
	inc hl ; $4311
	ld [hl], $80 ; $4312
	inc hl ; $4314
	ld [hl], $00 ; $4315
	ld hl, sSaveBlockDirectory + 657 ; $4317
	ld [hl], $01 ; $431a
	inc hl ; $431c
	ld [hl], $80 ; $431d
	inc hl ; $431f
	ld [hl], $19 ; $4320
	inc hl ; $4322
	ld [hl], $80 ; $4323
	inc hl ; $4325
	ld [hl], $00 ; $4326
	ld hl, sSaveBlockDirectory + 673 ; $4328
	ld [hl], $01 ; $432b
	inc hl ; $432d
	ld [hl], $00 ; $432e
	inc hl ; $4330
	ld [hl], $1a ; $4331
	inc hl ; $4333
	ld [hl], $80 ; $4334
	inc hl ; $4336
	ld [hl], $00 ; $4337
	ld hl, sSaveBlockDirectory + 689 ; $4339
	ld [hl], $01 ; $433c
	inc hl ; $433e
	ld [hl], $80 ; $433f
	inc hl ; $4341
	ld [hl], $1a ; $4342
	inc hl ; $4344
	ld [hl], $80 ; $4345
	inc hl ; $4347
	ld [hl], $00 ; $4348
	ld hl, sSaveBlockDirectory + 705 ; $434a
	ld [hl], $01 ; $434d
	inc hl ; $434f
	ld [hl], $00 ; $4350
	inc hl ; $4352
	ld [hl], $1b ; $4353
	inc hl ; $4355
	ld [hl], $80 ; $4356
	inc hl ; $4358
	ld [hl], $00 ; $4359
	ld hl, sSaveBlockDirectory + 721 ; $435b
	ld [hl], $01 ; $435e
	inc hl ; $4360
	ld [hl], $80 ; $4361
	inc hl ; $4363
	ld [hl], $1b ; $4364
	inc hl ; $4366
	ld [hl], $80 ; $4367
	inc hl ; $4369
	ld [hl], $00 ; $436a
	ld hl, sSaveBlockDirectory + 737 ; $436c
	ld [hl], $01 ; $436f
	inc hl ; $4371
	ld [hl], $00 ; $4372
	inc hl ; $4374
	ld [hl], $1c ; $4375
	inc hl ; $4377
	ld [hl], $80 ; $4378
	inc hl ; $437a
	ld [hl], $00 ; $437b
	ld hl, sSaveBlockDirectory + 753 ; $437d
	ld [hl], $01 ; $4380
	inc hl ; $4382
	ld [hl], $80 ; $4383
	inc hl ; $4385
	ld [hl], $1c ; $4386
	inc hl ; $4388
	ld [hl], $80 ; $4389
	inc hl ; $438b
	ld [hl], $00 ; $438c
	ld hl, sSaveBlockDirectory + 769 ; $438e
	ld [hl], $01 ; $4391
	inc hl ; $4393
	ld [hl], $00 ; $4394
	inc hl ; $4396
	ld [hl], $1d ; $4397
	inc hl ; $4399
	ld [hl], $80 ; $439a
	inc hl ; $439c
	ld [hl], $00 ; $439d
	ld hl, sSaveBlockDirectory + 785 ; $439f
	ld [hl], $01 ; $43a2
	inc hl ; $43a4
	ld [hl], $80 ; $43a5
	inc hl ; $43a7
	ld [hl], $1d ; $43a8
	inc hl ; $43aa
	ld [hl], $80 ; $43ab
	inc hl ; $43ad
	ld [hl], $00 ; $43ae
	ld hl, sSaveBlockDirectory + 801 ; $43b0
	ld [hl], $01 ; $43b3
	inc hl ; $43b5
	ld [hl], $00 ; $43b6
	inc hl ; $43b8
	ld [hl], $1e ; $43b9
	inc hl ; $43bb
	ld [hl], $80 ; $43bc
	inc hl ; $43be
	ld [hl], $00 ; $43bf
	ld hl, sSaveBlockDirectory + 817 ; $43c1
	ld [hl], $01 ; $43c4
	inc hl ; $43c6
	ld [hl], $80 ; $43c7
	inc hl ; $43c9
	ld [hl], $1e ; $43ca
	inc hl ; $43cc
	ld [hl], $80 ; $43cd
	inc hl ; $43cf
	ld [hl], $00 ; $43d0
	ld hl, sSaveBlockDirectory + 833 ; $43d2
	ld [hl], $01 ; $43d5
	inc hl ; $43d7
	ld [hl], $00 ; $43d8
	inc hl ; $43da
	ld [hl], $1f ; $43db
	inc hl ; $43dd
	ld [hl], $80 ; $43de
	inc hl ; $43e0
	ld [hl], $00 ; $43e1
	ld hl, sSaveBlockDirectory + 849 ; $43e3
	ld [hl], $01 ; $43e6
	inc hl ; $43e8
	ld [hl], $80 ; $43e9
	inc hl ; $43eb
	ld [hl], $1f ; $43ec
	inc hl ; $43ee
	ld [hl], $80 ; $43ef
	inc hl ; $43f1
	ld [hl], $00 ; $43f2
	ld hl, sSaveBlockDirectory + 865 ; $43f4
	ld [hl], $02 ; $43f7
	inc hl ; $43f9
	ld [hl], $00 ; $43fa
	inc hl ; $43fc
	ld [hl], $00 ; $43fd
	inc hl ; $43ff
	ld [hl], $00 ; $4400
	inc hl ; $4402
	ld [hl], $03 ; $4403
	ld hl, sSaveBlockDirectory + 881 ; $4405
	ld [hl], $02 ; $4408
	inc hl ; $440a
	ld [hl], $00 ; $440b
	inc hl ; $440d
	ld [hl], $03 ; $440e
	inc hl ; $4410
	ld [hl], $00 ; $4411
	inc hl ; $4413
	ld [hl], $03 ; $4414
	ld hl, sSaveBlockDirectory + 897 ; $4416
	ld [hl], $02 ; $4419
	inc hl ; $441b
	ld [hl], $00 ; $441c
	inc hl ; $441e
	ld [hl], $06 ; $441f
	inc hl ; $4421
	ld [hl], $20 ; $4422
	inc hl ; $4424
	ld [hl], $00 ; $4425
	ld hl, sSaveBlockDirectory + 913 ; $4427
	ld [hl], $02 ; $442a
	inc hl ; $442c
	ld [hl], $20 ; $442d
	inc hl ; $442f
	ld [hl], $06 ; $4430
	inc hl ; $4432
	ld [hl], $20 ; $4433
	inc hl ; $4435
	ld [hl], $00 ; $4436
	ld hl, sSaveBlockDirectory + 929 ; $4438
	ld [hl], $02 ; $443b
	inc hl ; $443d
	ld [hl], $40 ; $443e
	inc hl ; $4440
	ld [hl], $06 ; $4441
	inc hl ; $4443
	ld [hl], $20 ; $4444
	inc hl ; $4446
	ld [hl], $00 ; $4447
	ld hl, sSaveBlockDirectory + 945 ; $4449
	ld [hl], $02 ; $444c
	inc hl ; $444e
	ld [hl], $60 ; $444f
	inc hl ; $4451
	ld [hl], $06 ; $4452
	inc hl ; $4454
	ld [hl], $20 ; $4455
	inc hl ; $4457
	ld [hl], $00 ; $4458
	ld hl, sSaveBlockDirectory + 961 ; $445a
	ld [hl], $02 ; $445d
	inc hl ; $445f
	ld [hl], $80 ; $4460
	inc hl ; $4462
	ld [hl], $06 ; $4463
	inc hl ; $4465
	ld [hl], $20 ; $4466
	inc hl ; $4468
	ld [hl], $00 ; $4469
	ld hl, sSaveBlockDirectory + 977 ; $446b
	ld [hl], $02 ; $446e
	inc hl ; $4470
	ld [hl], $a0 ; $4471
	inc hl ; $4473
	ld [hl], $06 ; $4474
	inc hl ; $4476
	ld [hl], $20 ; $4477
	inc hl ; $4479
	ld [hl], $00 ; $447a
	ld hl, sSaveBlockDirectory + 993 ; $447c
	ld [hl], $02 ; $447f
	inc hl ; $4481
	ld [hl], $c0 ; $4482
	inc hl ; $4484
	ld [hl], $06 ; $4485
	inc hl ; $4487
	ld [hl], $60 ; $4488
	inc hl ; $448a
	ld [hl], $00 ; $448b
	ld hl, sSaveBlockDirectory + 1009 ; $448d
	ld [hl], $02 ; $4490
	inc hl ; $4492
	ld [hl], $20 ; $4493
	inc hl ; $4495
	ld [hl], $07 ; $4496
	inc hl ; $4498
	ld [hl], $a0 ; $4499
	inc hl ; $449b
	ld [hl], $0d ; $449c
	ld hl, sSaveBlockDirectory + 1025 ; $449e
	ld [hl], $02 ; $44a1
	inc hl ; $44a3
	ld [hl], $c0 ; $44a4
	inc hl ; $44a6
	ld [hl], $14 ; $44a7
	inc hl ; $44a9
	ld [hl], $c0 ; $44aa
	inc hl ; $44ac
	ld [hl], $06 ; $44ad
	ld hl, sSaveBlockDirectory + 1041 ; $44af
	ld [hl], $02 ; $44b2
	inc hl ; $44b4
	ld [hl], $80 ; $44b5
	inc hl ; $44b7
	ld [hl], $1b ; $44b8
	inc hl ; $44ba
	ld [hl], $80 ; $44bb
	inc hl ; $44bd
	ld [hl], $00 ; $44be
	ld hl, sSaveBlockDirectory + 1057 ; $44c0
	ld [hl], $02 ; $44c3
	inc hl ; $44c5
	ld [hl], $00 ; $44c6
	inc hl ; $44c8
	ld [hl], $1c ; $44c9
	inc hl ; $44cb
	ld [hl], $80 ; $44cc
	inc hl ; $44ce
	ld [hl], $00 ; $44cf
	ld hl, sSaveBlockDirectory + 1073 ; $44d1
	ld [hl], $02 ; $44d4
	inc hl ; $44d6
	ld [hl], $80 ; $44d7
	inc hl ; $44d9
	ld [hl], $1c ; $44da
	inc hl ; $44dc
	ld [hl], $80 ; $44dd
	inc hl ; $44df
	ld [hl], $00 ; $44e0
	ld hl, sSaveBlockDirectory + 1089 ; $44e2
	ld [hl], $02 ; $44e5
	inc hl ; $44e7
	ld [hl], $00 ; $44e8
	inc hl ; $44ea
	ld [hl], $1d ; $44eb
	inc hl ; $44ed
	ld [hl], $80 ; $44ee
	inc hl ; $44f0
	ld [hl], $00 ; $44f1
	ld hl, sSaveBlockDirectory + 1105 ; $44f3
	ld [hl], $02 ; $44f6
	inc hl ; $44f8
	ld [hl], $80 ; $44f9
	inc hl ; $44fb
	ld [hl], $1d ; $44fc
	inc hl ; $44fe
	ld [hl], $80 ; $44ff
	inc hl ; $4501
	ld [hl], $00 ; $4502
	ld hl, sSaveBlockDirectory + 1121 ; $4504
	ld [hl], $02 ; $4507
	inc hl ; $4509
	ld [hl], $00 ; $450a
	inc hl ; $450c
	ld [hl], $1e ; $450d
	inc hl ; $450f
	ld [hl], $80 ; $4510
	inc hl ; $4512
	ld [hl], $00 ; $4513
	ld hl, sSaveBlockDirectory + 1137 ; $4515
	ld [hl], $02 ; $4518
	inc hl ; $451a
	ld [hl], $80 ; $451b
	inc hl ; $451d
	ld [hl], $1e ; $451e
	inc hl ; $4520
	ld [hl], $80 ; $4521
	inc hl ; $4523
	ld [hl], $00 ; $4524
	ld hl, sSaveBlockDirectory + 1153 ; $4526
	ld [hl], $02 ; $4529
	inc hl ; $452b
	ld [hl], $00 ; $452c
	inc hl ; $452e
	ld [hl], $1f ; $452f
	inc hl ; $4531
	ld [hl], $80 ; $4532
	inc hl ; $4534
	ld [hl], $00 ; $4535
	ld hl, sSaveBlockDirectory + 1169 ; $4537
	ld [hl], $02 ; $453a
	inc hl ; $453c
	ld [hl], $80 ; $453d
	inc hl ; $453f
	ld [hl], $1f ; $4540
	inc hl ; $4542
	ld [hl], $80 ; $4543
	inc hl ; $4545
	ld [hl], $00 ; $4546
	ld hl, sSaveBlockDirectory + 1185 ; $4548
	ld [hl], $03 ; $454b
	inc hl ; $454d
	ld [hl], $00 ; $454e
	inc hl ; $4550
	ld [hl], $00 ; $4551
	inc hl ; $4553
	ld [hl], $00 ; $4554
	inc hl ; $4556
	ld [hl], $01 ; $4557
	ld hl, sSaveBlockDirectory + 1201 ; $4559
	ld [hl], $03 ; $455c
	inc hl ; $455e
	ld [hl], $00 ; $455f
	inc hl ; $4561
	ld [hl], $01 ; $4562
	inc hl ; $4564
	ld [hl], $00 ; $4565
	inc hl ; $4567
	ld [hl], $01 ; $4568
	ld hl, sSaveBlockDirectory + 1217 ; $456a
	ld [hl], $03 ; $456d
	inc hl ; $456f
	ld [hl], $00 ; $4570
	inc hl ; $4572
	ld [hl], $02 ; $4573
	inc hl ; $4575
	ld [hl], $00 ; $4576
	inc hl ; $4578
	ld [hl], $01 ; $4579
	ld hl, sSaveBlockDirectory + 1233 ; $457b
	ld [hl], $03 ; $457e
	inc hl ; $4580
	ld [hl], $00 ; $4581
	inc hl ; $4583
	ld [hl], $03 ; $4584
	inc hl ; $4586
	ld [hl], $00 ; $4587
	inc hl ; $4589
	ld [hl], $01 ; $458a
	ld hl, sSaveBlockDirectory + 1249 ; $458c
	ld [hl], $03 ; $458f
	inc hl ; $4591
	ld [hl], $00 ; $4592
	inc hl ; $4594
	ld [hl], $04 ; $4595
	inc hl ; $4597
	ld [hl], $00 ; $4598
	inc hl ; $459a
	ld [hl], $01 ; $459b
	ld hl, sSaveBlockDirectory + 1265 ; $459d
	ld [hl], $03 ; $45a0
	inc hl ; $45a2
	ld [hl], $00 ; $45a3
	inc hl ; $45a5
	ld [hl], $05 ; $45a6
	inc hl ; $45a8
	ld [hl], $00 ; $45a9
	inc hl ; $45ab
	ld [hl], $02 ; $45ac
	ld hl, sSaveBlockDirectory + 1281 ; $45ae
	ld [hl], $03 ; $45b1
	inc hl ; $45b3
	ld [hl], $00 ; $45b4
	inc hl ; $45b6
	ld [hl], $07 ; $45b7
	inc hl ; $45b9
	ld [hl], $00 ; $45ba
	inc hl ; $45bc
	ld [hl], $01 ; $45bd
	ld hl, sSaveBlockDirectory + 1297 ; $45bf
	ld [hl], $03 ; $45c2
	inc hl ; $45c4
	ld [hl], $00 ; $45c5
	inc hl ; $45c7
	ld [hl], $08 ; $45c8
	inc hl ; $45ca
	ld [hl], $00 ; $45cb
	inc hl ; $45cd
	ld [hl], $01 ; $45ce
	ld hl, sSaveBlockDirectory + 1313 ; $45d0
	ld [hl], $03 ; $45d3
	inc hl ; $45d5
	ld [hl], $00 ; $45d6
	inc hl ; $45d8
	ld [hl], $09 ; $45d9
	inc hl ; $45db
	ld [hl], $00 ; $45dc
	inc hl ; $45de
	ld [hl], $01 ; $45df
	ld hl, sSaveBlockDirectory + 1329 ; $45e1
	ld [hl], $03 ; $45e4
	inc hl ; $45e6
	ld [hl], $00 ; $45e7
	inc hl ; $45e9
	ld [hl], $0a ; $45ea
	inc hl ; $45ec
	ld [hl], $00 ; $45ed
	inc hl ; $45ef
	ld [hl], $01 ; $45f0
	ld hl, sSaveBlockDirectory + 1345 ; $45f2
	ld [hl], $03 ; $45f5
	inc hl ; $45f7
	ld [hl], $00 ; $45f8
	inc hl ; $45fa
	ld [hl], $0b ; $45fb
	inc hl ; $45fd
	ld [hl], $00 ; $45fe
	inc hl ; $4600
	ld [hl], $01 ; $4601
	ld hl, sSaveBlockDirectory + 1361 ; $4603
	ld [hl], $03 ; $4606
	inc hl ; $4608
	ld [hl], $00 ; $4609
	inc hl ; $460b
	ld [hl], $0c ; $460c
	inc hl ; $460e
	ld [hl], $00 ; $460f
	inc hl ; $4611
	ld [hl], $02 ; $4612
	ld hl, sSaveBlockDirectory + 1377 ; $4614
	ld [hl], $03 ; $4617
	inc hl ; $4619
	ld [hl], $00 ; $461a
	inc hl ; $461c
	ld [hl], $0e ; $461d
	inc hl ; $461f
	ld [hl], $00 ; $4620
	inc hl ; $4622
	ld [hl], $02 ; $4623
	ld hl, sSaveBlockDirectory + 1393 ; $4625
	ld [hl], $03 ; $4628
	inc hl ; $462a
	ld [hl], $00 ; $462b
	inc hl ; $462d
	ld [hl], $10 ; $462e
	inc hl ; $4630
	ld [hl], $00 ; $4631
	inc hl ; $4633
	ld [hl], $05 ; $4634
	ld hl, sSaveBlockDirectory + 1409 ; $4636
	ld [hl], $04 ; $4639
	inc hl ; $463b
	ld [hl], $00 ; $463c
	inc hl ; $463e
	ld [hl], $00 ; $463f
	inc hl ; $4641
	ld [hl], $00 ; $4642
	inc hl ; $4644
	ld [hl], $01 ; $4645
	ld hl, sSaveBlockDirectory + 1425 ; $4647
	ld [hl], $04 ; $464a
	inc hl ; $464c
	ld [hl], $00 ; $464d
	inc hl ; $464f
	ld [hl], $01 ; $4650
	inc hl ; $4652
	ld [hl], $00 ; $4653
	inc hl ; $4655
	ld [hl], $01 ; $4656
	ld hl, sSaveBlockDirectory + 1441 ; $4658
	ld [hl], $04 ; $465b
	inc hl ; $465d
	ld [hl], $00 ; $465e
	inc hl ; $4660
	ld [hl], $02 ; $4661
	inc hl ; $4663
	ld [hl], $00 ; $4664
	inc hl ; $4666
	ld [hl], $01 ; $4667
	ld hl, sSaveBlockDirectory + 1457 ; $4669
	ld [hl], $04 ; $466c
	inc hl ; $466e
	ld [hl], $00 ; $466f
	inc hl ; $4671
	ld [hl], $03 ; $4672
	inc hl ; $4674
	ld [hl], $00 ; $4675
	inc hl ; $4677
	ld [hl], $01 ; $4678
	ld hl, sSaveBlockDirectory + 1473 ; $467a
	ld [hl], $04 ; $467d
	inc hl ; $467f
	ld [hl], $00 ; $4680
	inc hl ; $4682
	ld [hl], $04 ; $4683
	inc hl ; $4685
	ld [hl], $00 ; $4686
	inc hl ; $4688
	ld [hl], $01 ; $4689
	ld hl, sSaveBlockDirectory + 1489 ; $468b
	ld [hl], $04 ; $468e
	inc hl ; $4690
	ld [hl], $00 ; $4691
	inc hl ; $4693
	ld [hl], $05 ; $4694
	inc hl ; $4696
	ld [hl], $00 ; $4697
	inc hl ; $4699
	ld [hl], $02 ; $469a
	ld hl, sSaveBlockDirectory + 1505 ; $469c
	ld [hl], $04 ; $469f
	inc hl ; $46a1
	ld [hl], $00 ; $46a2
	inc hl ; $46a4
	ld [hl], $07 ; $46a5
	inc hl ; $46a7
	ld [hl], $00 ; $46a8
	inc hl ; $46aa
	ld [hl], $05 ; $46ab
	ld hl, sSaveBlockDirectory + 1521 ; $46ad
	ld [hl], $04 ; $46b0
	inc hl ; $46b2
	ld [hl], $00 ; $46b3
	inc hl ; $46b5
	ld [hl], $0c ; $46b6
	inc hl ; $46b8
	ld [hl], $00 ; $46b9
	inc hl ; $46bb
	ld [hl], $05 ; $46bc
	ld hl, sSaveBlockDirectory + 1537 ; $46be
	ld [hl], $04 ; $46c1
	inc hl ; $46c3
	ld [hl], $00 ; $46c4
	inc hl ; $46c6
	ld [hl], $11 ; $46c7
	inc hl ; $46c9
	ld [hl], $00 ; $46ca
	inc hl ; $46cc
	ld [hl], $05 ; $46cd
	ld hl, sSaveBlockDirectory + 1553 ; $46cf
	ld [hl], $04 ; $46d2
	inc hl ; $46d4
	ld [hl], $00 ; $46d5
	inc hl ; $46d7
	ld [hl], $16 ; $46d8
	inc hl ; $46da
	ld [hl], $00 ; $46db
	inc hl ; $46dd
	ld [hl], $05 ; $46de
	ld hl, sSaveBlockDirectory + 1569 ; $46e0
	ld [hl], $05 ; $46e3
	inc hl ; $46e5
	ld [hl], $00 ; $46e6
	inc hl ; $46e8
	ld [hl], $00 ; $46e9
	inc hl ; $46eb
	ld [hl], $00 ; $46ec
	inc hl ; $46ee
	ld [hl], $15 ; $46ef
	ld hl, sSaveBlockDirectory + 1585 ; $46f1
	ld [hl], $05 ; $46f4
	inc hl ; $46f6
	ld [hl], $00 ; $46f7
	inc hl ; $46f9
	ld [hl], $15 ; $46fa
	inc hl ; $46fc
	ld [hl], $00 ; $46fd
	inc hl ; $46ff
	ld [hl], $02 ; $4700
	ld hl, sSaveBlockDirectory + 1601 ; $4702
	ld [hl], $05 ; $4705
	inc hl ; $4707
	ld [hl], $00 ; $4708
	inc hl ; $470a
	ld [hl], $17 ; $470b
	inc hl ; $470d
	ld [hl], $00 ; $470e
	inc hl ; $4710
	ld [hl], $02 ; $4711
	ld hl, sSaveBlockDirectory + 1617 ; $4713
	ld [hl], $05 ; $4716
	inc hl ; $4718
	ld [hl], $00 ; $4719
	inc hl ; $471b
	ld [hl], $19 ; $471c
	inc hl ; $471e
	ld [hl], $00 ; $471f
	inc hl ; $4721
	ld [hl], $02 ; $4722
	ld hl, sSaveBlockDirectory + 1633 ; $4724
	ld [hl], $05 ; $4727
	inc hl ; $4729
	ld [hl], $00 ; $472a
	inc hl ; $472c
	ld [hl], $1b ; $472d
	inc hl ; $472f
	ld [hl], $00 ; $4730
	inc hl ; $4732
	ld [hl], $02 ; $4733
	ld hl, sSaveBlockDirectory + 1649 ; $4735
	ld [hl], $05 ; $4738
	inc hl ; $473a
	ld [hl], $00 ; $473b
	inc hl ; $473d
	ld [hl], $1d ; $473e
	inc hl ; $4740
	ld [hl], $00 ; $4741
	inc hl ; $4743
	ld [hl], $02 ; $4744
	ld hl, sSaveBlockDirectory + 1665 ; $4746
	ld [hl], $06 ; $4749
	inc hl ; $474b
	ld [hl], $00 ; $474c
	inc hl ; $474e
	ld [hl], $00 ; $474f
	inc hl ; $4751
	ld [hl], $00 ; $4752
	inc hl ; $4754
	ld [hl], $1e ; $4755
	ld hl, sSaveBlockDirectory + 1681 ; $4757
	ld [hl], $07 ; $475a
	inc hl ; $475c
	ld [hl], $00 ; $475d
	inc hl ; $475f
	ld [hl], $00 ; $4760
	inc hl ; $4762
	ld [hl], $00 ; $4763
	inc hl ; $4765
	ld [hl], $1e ; $4766
	ld hl, sSaveBlockDirectory + 1697 ; $4768
	ld [hl], $08 ; $476b
	inc hl ; $476d
	ld [hl], $00 ; $476e
	inc hl ; $4770
	ld [hl], $00 ; $4771
	inc hl ; $4773
	ld [hl], $00 ; $4774
	inc hl ; $4776
	ld [hl], $1e ; $4777
	ld hl, sSaveBlockDirectory + 1713 ; $4779
	ld [hl], $09 ; $477c
	inc hl ; $477e
	ld [hl], $00 ; $477f
	inc hl ; $4781
	ld [hl], $00 ; $4782
	inc hl ; $4784
	ld [hl], $00 ; $4785
	inc hl ; $4787
	ld [hl], $1e ; $4788
	ld hl, sSaveBlockDirectory + 1729 ; $478a
	ld [hl], $0a ; $478d
	inc hl ; $478f
	ld [hl], $00 ; $4790
	inc hl ; $4792
	ld [hl], $00 ; $4793
	inc hl ; $4795
	ld [hl], $00 ; $4796
	inc hl ; $4798
	ld [hl], $1e ; $4799
	ld hl, sSaveBlockDirectory + 1745 ; $479b
	ld [hl], $0b ; $479e
	inc hl ; $47a0
	ld [hl], $00 ; $47a1
	inc hl ; $47a3
	ld [hl], $00 ; $47a4
	inc hl ; $47a6
	ld [hl], $00 ; $47a7
	inc hl ; $47a9
	ld [hl], $1e ; $47aa
	ld hl, sSaveBlockDirectory + 1761 ; $47ac
	ld [hl], $0c ; $47af
	inc hl ; $47b1
	ld [hl], $00 ; $47b2
	inc hl ; $47b4
	ld [hl], $00 ; $47b5
	inc hl ; $47b7
	ld [hl], $00 ; $47b8
	inc hl ; $47ba
	ld [hl], $1e ; $47bb
	ld hl, sSaveBlockDirectory + 1777 ; $47bd
	ld [hl], $0d ; $47c0
	inc hl ; $47c2
	ld [hl], $00 ; $47c3
	inc hl ; $47c5
	ld [hl], $00 ; $47c6
	inc hl ; $47c8
	ld [hl], $00 ; $47c9
	inc hl ; $47cb
	ld [hl], $1e ; $47cc
	ld hl, sSaveBlockDirectory + 1793 ; $47ce
	ld [hl], $0e ; $47d1
	inc hl ; $47d3
	ld [hl], $00 ; $47d4
	inc hl ; $47d6
	ld [hl], $00 ; $47d7
	inc hl ; $47d9
	ld [hl], $00 ; $47da
	inc hl ; $47dc
	ld [hl], $1e ; $47dd
	ld hl, sSaveFormatVersion ; $47df
	ld [hl], $71 ; $47e2
	pop hl ; $47e4
	pop de ; $47e5
	pop bc ; $47e6
	pop af ; $47e7
	ret ; $47e8
