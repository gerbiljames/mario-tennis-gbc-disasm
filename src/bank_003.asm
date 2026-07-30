SECTION "ROM Bank $03", ROMX[$4000], BANK[$03]

	farptr WipeAllSaveRam ; $4000
	farptr ValidateSaveRam ; $4002
	farptr WriteSaveBlock ; $4004
	farptr ReadSaveBlock ; $4006
	farptr ReadSaveBlockTag ; $4008
	farptr VerifySaveBlock ; $400a
	farptr InvalidateStorySlot ; $400c
	farptr ResetAllSaveBlocks ; $400e
	farptr EraseAndInitSaveRam ; $4010
	farptr RepairAllSaveSlots ; $4012
	farptr ReinitSaveRamPreservingBlock6 ; $4014
	farptr EraseStorySlotSaveData ; $4016
	farptr SaveStorySlotWithTimer ; $4018
	farptr CheckStorySlot ; $401a
	farptr TestSaveFlag ; $401c
	farptr SetSaveFlag ; $401e
	farptr ClearSaveFlag ; $4020
	farptr SaveSlotDebugEditor ; $4022
	farptr ReadExhibitionSaveBlock ; $4024
	farptr WriteExhibitionSaveBlock ; $4026
	farptr ClearSaveBlock11 ; $4028
	farptr UpdateMinigameRecord ; $402a
	farptr ReadMinigameRecord ; $402c
	farptr ApplyN64RecordsUnlockFlags ; $402e
	farptr UpdateUnlockablesSaveBlock ; $4030
	farptr ReadMarioCastVictoryGrid ; $4032
	farptr WriteMarioCastVictoryGrid ; $4034
	farptr RunScrollingTextScreen ; $4036
	farptr SetupSceneAnimationPalettes ; $4038
	farptr UpdateSceneAnimation ; $403a
	farptr PlayScrollingStoryCutscene ; $403c
	farptr ShowStoryResultScreen ; $403e
	farptr InitGrayscalePaletteFade ; $4040
	farptr SetupPaletteFadeMask ; $4042
	farptr AnimatePaletteFadeToTarget ; $4044
	farptr SetAllUnlockablesInSaveBlock ; $4046
	farptr SaveStorySlot ; $4048
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
SaveSignature:
	INCLUDE "data/bank_003/text_47e9.asm" ; $47e9, 16 bytes
WipeAllSaveRam:
	ld e, $00 ; $47f9
.loop:
	ld a, e ; $47fb
	ldh [hSramBank], a ; $47fc
	ld [rRAMB], a ; $47fe
	ld bc, $0200 ; $4801
	ld hl, $a000 ; $4804
	xor a ; $4807
.loopB:
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
	jr nz, .loopB ; $4819
	dec b ; $481b
	jr nz, .loopB ; $481c
	inc e ; $481e
	ld a, e ; $481f
	cp $04 ; $4820
	jr c, .loop ; $4822
	ret ; $4824
ClearSaveFlagsArea:
	xor a ; $4825
	ldh [hSramBank], a ; $4826
	ld [rRAMB], a ; $4828
	ld c, $02 ; $482b
	ld hl, sSaveFlags ; $482d
.loop:
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
	jr nz, .loop ; $4841
	ret ; $4843
SumSaveHeaderRegion:
	push af ; $4844
	push de ; $4845
	push bc ; $4846
	xor a ; $4847
	ldh [hSramBank], a ; $4848
	ld [rRAMB], a ; $484a
	ld h, a ; $484d
	ld l, a ; $484e
	ld de, sSaveFormatVersion ; $484f
	ld bc, $0838 ; $4852
.loop:
	ld a, [de] ; $4855
	inc de ; $4856
	add l ; $4857
	ld l, a ; $4858
	jr nc, .gotPtr ; $4859
	inc h ; $485b
.gotPtr:
	dec c ; $485c
	jr nz, .loop ; $485d
	dec b ; $485f
	jr nz, .loop ; $4860
	pop bc ; $4862
	pop de ; $4863
	pop af ; $4864
	ret ; $4865
UpdateSaveHeaderChecksum:
	push af ; $4866
	push bc ; $4867
	push de ; $4868
	push hl ; $4869
	call SumSaveHeaderRegion ; $486a
	ld a, l ; $486d
	ld [sSaveMasterChecksum], a ; $486e
	ld a, h ; $4871
	ld [sSaveMasterChecksum + 1], a ; $4872
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
	ldh [hSramBank], a ; $4887
	ld [rRAMB], a ; $4889
	ld c, $04 ; $488c
	pop hl ; $488e
	pop de ; $488f
	call CopyMemoryFast ; $4890
	add sp, 64 ; $4893
	ld a, $00 ; $4895
	ldh [hSramBank], a ; $4897
	ld [rRAMB], a ; $4899
	pop hl ; $489c
	pop de ; $489d
	pop bc ; $489e
	pop af ; $489f
	ret ; $48a0
MirrorSaveHeaderToBank1:
	push af ; $48a1
	push bc ; $48a2
	push de ; $48a3
	push hl ; $48a4
	call SumSaveHeaderRegion ; $48a5
	ld a, l ; $48a8
	ld [sSaveMasterChecksum], a ; $48a9
	ld a, h ; $48ac
	ld [sSaveMasterChecksum + 1], a ; $48ad
	ld hl, $a000 ; $48b0
	ld de, wTextBuffer ; $48b3
	ld c, $20 ; $48b6
	call CopyMemoryFast ; $48b8
	ld a, $01 ; $48bb
	ldh [hSramBank], a ; $48bd
	ld [rRAMB], a ; $48bf
	ld hl, wTextBuffer ; $48c2
	ld de, $a000 ; $48c5
	ld c, $20 ; $48c8
	call CopyMemoryFast ; $48ca
	ld a, $00 ; $48cd
	ldh [hSramBank], a ; $48cf
	ld [rRAMB], a ; $48d1
	ld hl, sSaveBlockDirectory + 416 ; $48d4
	ld de, wTextBuffer ; $48d7
	ld c, $20 ; $48da
	call CopyMemoryFast ; $48dc
	ld a, $01 ; $48df
	ldh [hSramBank], a ; $48e1
	ld [rRAMB], a ; $48e3
	ld hl, wTextBuffer ; $48e6
	ld de, sSaveBlockDirectory + 416 ; $48e9
	ld c, $20 ; $48ec
	call CopyMemoryFast ; $48ee
	ld a, $00 ; $48f1
	ldh [hSramBank], a ; $48f3
	ld [rRAMB], a ; $48f5
	ld hl, sSaveBlockDirectory + 928 ; $48f8
	ld de, wTextBuffer ; $48fb
	ld c, $20 ; $48fe
	call CopyMemoryFast ; $4900
	ld a, $01 ; $4903
	ldh [hSramBank], a ; $4905
	ld [rRAMB], a ; $4907
	ld hl, wTextBuffer ; $490a
	ld de, sSaveBlockDirectory + 928 ; $490d
	ld c, $20 ; $4910
	call CopyMemoryFast ; $4912
	ld a, $00 ; $4915
	ldh [hSramBank], a ; $4917
	ld [rRAMB], a ; $4919
	ld hl, sSaveBlockDirectory + 1440 ; $491c
	ld de, wTextBuffer ; $491f
	ld c, $20 ; $4922
	call CopyMemoryFast ; $4924
	ld a, $01 ; $4927
	ldh [hSramBank], a ; $4929
	ld [rRAMB], a ; $492b
	ld hl, wTextBuffer ; $492e
	ld de, sSaveBlockDirectory + 1440 ; $4931
	ld c, $20 ; $4934
	call CopyMemoryFast ; $4936
	ld a, $00 ; $4939
	ldh [hSramBank], a ; $493b
	ld [rRAMB], a ; $493d
	pop hl ; $4940
	pop de ; $4941
	pop bc ; $4942
	pop af ; $4943
	ret ; $4944
VerifySaveHeaderChecksum:
	push hl ; $4945
	push de ; $4946
	call SumSaveHeaderRegion ; $4947
	push hl ; $494a
	ld hl, sSaveMasterChecksum ; $494b
	ld a, [hl+] ; $494e
	ld h, [hl] ; $494f
	ld l, a ; $4950
	pop de ; $4951
	ld a, l ; $4952
	sub e ; $4953
	ld l, a ; $4954
	ld a, h ; $4955
	sbc d ; $4956
	ld h, a ; $4957
	ld a, h ; $4958
	or l ; $4959
	pop de ; $495a
	pop hl ; $495b
	ret ; $495c
ValidateSaveRam:
	push hl ; $495d
	push de ; $495e
	push bc ; $495f
	ld a, $0a ; $4960
	ld [rRAMG], a ; $4962
	ld a, $00 ; $4965
	ldh [hSramBank], a ; $4967
	ld [rRAMB], a ; $4969
	ld hl, sSaveSignature ; $496c
	ld de, SaveSignature ; $496f
	call CompareSaveSignature ; $4972
	jr nz, .setSramBank ; $4975
	call VerifySaveHeaderChecksum ; $4977
	jr nz, .setSramBank ; $497a
	xor a ; $497c
	jp .step2 ; $497d
.setSramBank:
	ld a, $01 ; $4980
	ldh [hSramBank], a ; $4982
	ld [rRAMB], a ; $4984
	ld hl, $a000 ; $4987
	ld de, wTextBuffer ; $498a
	ld c, $20 ; $498d
	call CopyMemoryFast ; $498f
	ld a, $00 ; $4992
	ldh [hSramBank], a ; $4994
	ld [rRAMB], a ; $4996
	ld hl, wTextBuffer ; $4999
	ld de, $a000 ; $499c
	ld c, $20 ; $499f
	call CopyMemoryFast ; $49a1
	ld a, $01 ; $49a4
	ldh [hSramBank], a ; $49a6
	ld [rRAMB], a ; $49a8
	ld hl, sSaveBlockDirectory + 416 ; $49ab
	ld de, wTextBuffer ; $49ae
	ld c, $20 ; $49b1
	call CopyMemoryFast ; $49b3
	ld a, $00 ; $49b6
	ldh [hSramBank], a ; $49b8
	ld [rRAMB], a ; $49ba
	ld hl, wTextBuffer ; $49bd
	ld de, sSaveBlockDirectory + 416 ; $49c0
	ld c, $20 ; $49c3
	call CopyMemoryFast ; $49c5
	ld a, $01 ; $49c8
	ldh [hSramBank], a ; $49ca
	ld [rRAMB], a ; $49cc
	ld hl, sSaveBlockDirectory + 928 ; $49cf
	ld de, wTextBuffer ; $49d2
	ld c, $20 ; $49d5
	call CopyMemoryFast ; $49d7
	ld a, $00 ; $49da
	ldh [hSramBank], a ; $49dc
	ld [rRAMB], a ; $49de
	ld hl, wTextBuffer ; $49e1
	ld de, sSaveBlockDirectory + 928 ; $49e4
	ld c, $20 ; $49e7
	call CopyMemoryFast ; $49e9
	ld a, $01 ; $49ec
	ldh [hSramBank], a ; $49ee
	ld [rRAMB], a ; $49f0
	ld hl, sSaveBlockDirectory + 1440 ; $49f3
	ld de, wTextBuffer ; $49f6
	ld c, $20 ; $49f9
	call CopyMemoryFast ; $49fb
	ld a, $00 ; $49fe
	ldh [hSramBank], a ; $4a00
	ld [rRAMB], a ; $4a02
	ld hl, wTextBuffer ; $4a05
	ld de, sSaveBlockDirectory + 1440 ; $4a08
	ld c, $20 ; $4a0b
	call CopyMemoryFast ; $4a0d
	ld hl, $a000 ; $4a10
	ld de, SaveSignature ; $4a13
	call CompareSaveSignature ; $4a16
	jr nz, .wipeAllSaveRam ; $4a19
	call VerifySaveHeaderChecksum ; $4a1b
	jr nz, .wipeAllSaveRam ; $4a1e
	ld a, $01 ; $4a20
	jr .step2 ; $4a22
.wipeAllSaveRam:
	call WipeAllSaveRam ; $4a24
	call InitSaveHeader ; $4a27
	call MirrorSaveHeaderToBank1 ; $4a2a
	call InitAllMinigameRecordBlocks ; $4a2d
	ld a, $ff ; $4a30
.step2:
	push af ; $4a32
	xor a ; $4a33
	ld [rRAMG], a ; $4a34
	pop af ; $4a37
	pop bc ; $4a38
	pop de ; $4a39
	pop hl ; $4a3a
	ret ; $4a3b
EraseAndInitSaveRam:
	ld a, $0a ; $4a3c
	ld [rRAMG], a ; $4a3e
	ld a, $00 ; $4a41
	ldh [hSramBank], a ; $4a43
	ld [rRAMB], a ; $4a45
	call WipeAllSaveRam ; $4a48
	call InitSaveHeader ; $4a4b
	call MirrorSaveHeaderToBank1 ; $4a4e
	xor a ; $4a51
	ld [rRAMG], a ; $4a52
	ret ; $4a55
CompareSaveSignature:
	push de ; $4a56
	push hl ; $4a57
.loop:
	ld a, [de] ; $4a58
	cp [hl] ; $4a59
	jr nz, .step ; $4a5a
	or a ; $4a5c
	jr z, .restore ; $4a5d
	inc de ; $4a5f
	inc hl ; $4a60
	jr .loop ; $4a61
.step:
	ld a, $01 ; $4a63
.restore:
	pop hl ; $4a65
	pop de ; $4a66
	or a ; $4a67
	ret ; $4a68
CopySaveSignature:
	push af ; $4a69
	push de ; $4a6a
	push hl ; $4a6b
.loop:
	ld a, [hl] ; $4a6c
	ld [de], a ; $4a6d
	or a ; $4a6e
	jr z, .restore ; $4a6f
	inc hl ; $4a71
	inc de ; $4a72
	jr .loop ; $4a73
.restore:
	pop hl ; $4a75
	pop de ; $4a76
	pop af ; $4a77
	ret ; $4a78
GetSaveBlockDirEntry:
	push hl ; $4a79
	ld l, a ; $4a7a
	ld h, $00 ; $4a7b
	add hl, hl ; $4a7d
	add hl, hl ; $4a7e
	add hl, hl ; $4a7f
	add hl, hl ; $4a80
	ld bc, sSaveBlockDirectory ; $4a81
	add hl, bc ; $4a84
	ld b, h ; $4a85
	ld c, l ; $4a86
	pop hl ; $4a87
	ret ; $4a88
WriteSaveBlock:
	push hl ; $4a89
	push de ; $4a8a
	push bc ; $4a8b
	ld a, $0a ; $4a8c
	ld [rRAMG], a ; $4a8e
	ld a, $00 ; $4a91
	ldh [hSramBank], a ; $4a93
	ld [rRAMB], a ; $4a95
	call InitSaveHeader ; $4a98
	push de ; $4a9b
	ld a, b ; $4a9c
	call GetSaveBlockDirEntry ; $4a9d
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
	ldh [hSramBank], a ; $4ab8
	ld [rRAMB], a ; $4aba
	pop hl ; $4abd
	push hl ; $4abe
	push bc ; $4abf
.copyLoop:
	ld a, [hl+] ; $4ac0
	ld [de], a ; $4ac1
	inc de ; $4ac2
	dec bc ; $4ac3
	ld a, b ; $4ac4
	or c ; $4ac5
	jr nz, .copyLoop ; $4ac6
	pop bc ; $4ac8
	pop hl ; $4ac9
	ld de, $0000 ; $4aca
.checksumLoop:
	ld a, [hl+] ; $4acd
	add e ; $4ace
	ld e, a ; $4acf
	ld a, d ; $4ad0
	adc $00 ; $4ad1
	ld d, a ; $4ad3
	dec bc ; $4ad4
	ld a, b ; $4ad5
	or c ; $4ad6
	jr nz, .checksumLoop ; $4ad7
	ld a, $00 ; $4ad9
	ldh [hSramBank], a ; $4adb
	ld [rRAMB], a ; $4add
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
	call MirrorSaveHeaderToBank1 ; $4af1
	xor a ; $4af4
	push af ; $4af5
	xor a ; $4af6
	ld [rRAMG], a ; $4af7
	pop af ; $4afa
	pop bc ; $4afb
	pop de ; $4afc
	pop hl ; $4afd
	ret ; $4afe
InvalidateStorySlot:
	push hl ; $4aff
	push de ; $4b00
	push bc ; $4b01
	ld a, b ; $4b02
	cp $03 ; $4b03
	jr nc, .ge03 ; $4b05
	sla a ; $4b07
	ld b, a ; $4b09
	call InvalidateSaveBlock ; $4b0a
	or a ; $4b0d
	jr nz, .restore ; $4b0e
	inc b ; $4b10
	call InvalidateSaveBlock ; $4b11
	jr .restore ; $4b14
.ge03:
	ld a, $ff ; $4b16
.restore:
	pop bc ; $4b18
	pop de ; $4b19
	pop hl ; $4b1a
	ret ; $4b1b
InvalidateSaveBlock:
	push hl ; $4b1c
	push de ; $4b1d
	push bc ; $4b1e
	ld a, $0a ; $4b1f
	ld [rRAMG], a ; $4b21
	ld a, $00 ; $4b24
	ldh [hSramBank], a ; $4b26
	ld [rRAMB], a ; $4b28
	call InitSaveHeader ; $4b2b
	ld a, b ; $4b2e
	call GetSaveBlockDirEntry ; $4b2f
	xor a ; $4b32
	ld [bc], a ; $4b33
	ld de, $0000 ; $4b34
	ld hl, $0006 ; $4b37
	add hl, bc ; $4b3a
	ld [hl], e ; $4b3b
	inc hl ; $4b3c
	ld [hl], d ; $4b3d
	inc hl ; $4b3e
	ld c, $08 ; $4b3f
	xor a ; $4b41
.clearLoop:
	ld [hl+], a ; $4b42
	dec c ; $4b43
	jr nz, .clearLoop ; $4b44
	call MirrorSaveHeaderToBank1 ; $4b46
	xor a ; $4b49
	push af ; $4b4a
	xor a ; $4b4b
	ld [rRAMG], a ; $4b4c
	pop af ; $4b4f
	pop bc ; $4b50
	pop de ; $4b51
	pop hl ; $4b52
	ret ; $4b53
ResetAllSaveBlocks:
	ld a, $00 ; $4b54
	ld [wCurrentStorySlot], a ; $4b56
	ld a, $00 ; $4b59
	call EraseStorySlotSaveData ; $4b5b
	ld a, $01 ; $4b5e
	ld [wCurrentStorySlot], a ; $4b60
	ld a, $00 ; $4b63
	call EraseStorySlotSaveData ; $4b65
	ld a, $02 ; $4b68
	ld [wCurrentStorySlot], a ; $4b6a
	ld a, $00 ; $4b6d
	call EraseStorySlotSaveData ; $4b6f
	ld a, $00 ; $4b72
	ld [wCurrentStorySlot], a ; $4b74
	ld b, $36 ; $4b77
	call InvalidateSaveBlock ; $4b79
	ld b, $37 ; $4b7c
	call InvalidateSaveBlock ; $4b7e
	ld a, $0a ; $4b81
	ld [rRAMG], a ; $4b83
	ld a, $00 ; $4b86
	ldh [hSramBank], a ; $4b88
	ld [rRAMB], a ; $4b8a
	call ClearSaveFlagsArea ; $4b8d
	call InitSaveHeader ; $4b90
	call MirrorSaveHeaderToBank1 ; $4b93
	xor a ; $4b96
	ld [rRAMG], a ; $4b97
	ret ; $4b9a
ReadSaveBlock:
	push hl ; $4b9b
	push de ; $4b9c
	push bc ; $4b9d
	ld a, $0a ; $4b9e
	ld [rRAMG], a ; $4ba0
	ld a, $00 ; $4ba3
	ldh [hSramBank], a ; $4ba5
	ld [rRAMB], a ; $4ba7
	ld a, b ; $4baa
	call GetSaveBlockDirEntry ; $4bab
	ld a, [bc] ; $4bae
	or a ; $4baf
	jp nz, .present ; $4bb0
	ld a, $fe ; $4bb3
	jp .done ; $4bb5
.present:
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
	ldh [hSramBank], a ; $4bd0
	ld [rRAMB], a ; $4bd2
	pop hl ; $4bd5
	push hl ; $4bd6
	push bc ; $4bd7
.copyLoop:
	ld a, [de] ; $4bd8
	ld [hl+], a ; $4bd9
	inc de ; $4bda
	dec bc ; $4bdb
	ld a, b ; $4bdc
	or c ; $4bdd
	jr nz, .copyLoop ; $4bde
	pop bc ; $4be0
	pop hl ; $4be1
	ld de, $0000 ; $4be2
.checksumLoop:
	ld a, [hl+] ; $4be5
	add e ; $4be6
	ld e, a ; $4be7
	ld a, d ; $4be8
	adc $00 ; $4be9
	ld d, a ; $4beb
	dec bc ; $4bec
	ld a, b ; $4bed
	or c ; $4bee
	jr nz, .checksumLoop ; $4bef
	ld a, $00 ; $4bf1
	ldh [hSramBank], a ; $4bf3
	ld [rRAMB], a ; $4bf5
	pop bc ; $4bf8
	ld hl, $0006 ; $4bf9
	add hl, bc ; $4bfc
	ld a, [hl+] ; $4bfd
	ld h, [hl] ; $4bfe
	ld l, a ; $4bff
	ld a, h ; $4c00
	xor d ; $4c01
	ld h, a ; $4c02
	ld a, l ; $4c03
	xor e ; $4c04
	or h ; $4c05
	jr z, .done ; $4c06
	ld a, $ff ; $4c08
.done:
	push af ; $4c0a
	xor a ; $4c0b
	ld [rRAMG], a ; $4c0c
	pop af ; $4c0f
	pop bc ; $4c10
	pop de ; $4c11
	pop hl ; $4c12
	ret ; $4c13
VerifySaveBlock:
	push hl ; $4c14
	push de ; $4c15
	push bc ; $4c16
	ld a, $0a ; $4c17
	ld [rRAMG], a ; $4c19
	ld a, $00 ; $4c1c
	ldh [hSramBank], a ; $4c1e
	ld [rRAMB], a ; $4c20
	ld a, b ; $4c23
	call GetSaveBlockDirEntry ; $4c24
	ld a, [bc] ; $4c27
	or a ; $4c28
	jp nz, .present ; $4c29
	ld a, $fe ; $4c2c
	jp .done ; $4c2e
.present:
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
	ldh [hSramBank], a ; $4c49
	ld [rRAMB], a ; $4c4b
	pop hl ; $4c4e
	push de ; $4c4f
	push bc ; $4c50
.compareLoop:
	ld a, [de] ; $4c51
	cp [hl] ; $4c52
	jr z, .next ; $4c53
	ld a, $00 ; $4c55
	ldh [hSramBank], a ; $4c57
	ld [rRAMB], a ; $4c59
	add sp, 6 ; $4c5c
	ld a, $fd ; $4c5e
	jp .done ; $4c60
.next:
	inc hl ; $4c63
	inc de ; $4c64
	dec bc ; $4c65
	ld a, b ; $4c66
	or c ; $4c67
	jr nz, .compareLoop ; $4c68
	pop bc ; $4c6a
	pop hl ; $4c6b
	ld de, $0000 ; $4c6c
.checksumLoop:
	ld a, [hl+] ; $4c6f
	add e ; $4c70
	ld e, a ; $4c71
	ld a, d ; $4c72
	adc $00 ; $4c73
	ld d, a ; $4c75
	dec bc ; $4c76
	ld a, b ; $4c77
	or c ; $4c78
	jr nz, .checksumLoop ; $4c79
	ld a, $00 ; $4c7b
	ldh [hSramBank], a ; $4c7d
	ld [rRAMB], a ; $4c7f
	pop bc ; $4c82
	ld hl, $0006 ; $4c83
	add hl, bc ; $4c86
	ld a, [hl+] ; $4c87
	ld h, [hl] ; $4c88
	ld l, a ; $4c89
	ld a, h ; $4c8a
	xor d ; $4c8b
	ld h, a ; $4c8c
	ld a, l ; $4c8d
	xor e ; $4c8e
	or h ; $4c8f
	jr z, .done ; $4c90
	ld a, $ff ; $4c92
.done:
	push af ; $4c94
	xor a ; $4c95
	ld [rRAMG], a ; $4c96
	pop af ; $4c99
	pop bc ; $4c9a
	pop de ; $4c9b
	pop hl ; $4c9c
	ret ; $4c9d
ReadSaveBlockTag:
	push hl ; $4c9e
	push de ; $4c9f
	push bc ; $4ca0
	ld a, $0a ; $4ca1
	ld [rRAMG], a ; $4ca3
	ld a, $00 ; $4ca6
	ldh [hSramBank], a ; $4ca8
	ld [rRAMB], a ; $4caa
	ld a, b ; $4cad
	call GetSaveBlockDirEntry ; $4cae
	ld a, [bc] ; $4cb1
	or a ; $4cb2
	jp nz, .nonZero ; $4cb3
	ld a, $fe ; $4cb6
	jp .loopB ; $4cb8
.nonZero:
	ld a, $08 ; $4cbb
	add c ; $4cbd
	ld e, a ; $4cbe
	ld d, b ; $4cbf
	ld c, $08 ; $4cc0
.loop:
	ld a, [de] ; $4cc2
	ld [hl+], a ; $4cc3
	inc de ; $4cc4
	dec c ; $4cc5
	jr nz, .loop ; $4cc6
	xor a ; $4cc8
.loopB:
	push af ; $4cc9
	xor a ; $4cca
	ld [rRAMG], a ; $4ccb
	pop af ; $4cce
	pop bc ; $4ccf
	pop de ; $4cd0
	pop hl ; $4cd1
	ret ; $4cd2
	push hl ; $4cd3
	push de ; $4cd4
	push bc ; $4cd5
	ld a, $0a ; $4cd6
	ld [rRAMG], a ; $4cd8
	ld a, $00 ; $4cdb
	ldh [hSramBank], a ; $4cdd
	ld [rRAMB], a ; $4cdf
	ld a, b ; $4ce2
	call GetSaveBlockDirEntry ; $4ce3
	ld a, [bc] ; $4ce6
	or a ; $4ce7
	jp nz, .nonZero2 ; $4ce8
	ld a, $fe ; $4ceb
	jp .loopB ; $4ced
.nonZero2:
	ld a, $08 ; $4cf0
	add c ; $4cf2
	ld e, a ; $4cf3
	ld d, b ; $4cf4
	ld c, $02 ; $4cf5
.loop2:
	ld a, [de] ; $4cf7
	ld [hl+], a ; $4cf8
	inc de ; $4cf9
	dec c ; $4cfa
	jr nz, .loop2 ; $4cfb
	xor a ; $4cfd
	push af ; $4cfe
	xor a ; $4cff
	ld [rRAMG], a ; $4d00
	pop af ; $4d03
	pop bc ; $4d04
	pop de ; $4d05
	pop hl ; $4d06
	ret ; $4d07
SaveStorySlot:
	ld a, [wCurrentStorySlot] ; $4d08
	cp $03 ; $4d0b
	ret nc ; $4d0d
	jr SaveStorySlotWithTimer.checkCurrentStorySlot ; $4d0e
SaveStorySlotWithTimer:
	ld a, [wCurrentStorySlot] ; $4d10
	cp $03 ; $4d13
	ret nc ; $4d15
	call SaveGameTimer ; $4d16
.checkCurrentStorySlot:
	ld a, [wCurrentStorySlot] ; $4d19
	add a ; $4d1c
	ld b, a ; $4d1d
	ld hl, wStorySlotData ; $4d1e
	ld de, $0000 ; $4d21
	call WriteSaveBlock ; $4d24
	or a ; $4d27
	ret nz ; $4d28
	ld a, [wCurrentStorySlot] ; $4d29
	add a ; $4d2c
	ld b, a ; $4d2d
	ld hl, wStorySlotData ; $4d2e
	call VerifySaveBlock ; $4d31
	or a ; $4d34
	ret nz ; $4d35
	ld a, [wCurrentStorySlot] ; $4d36
	add a ; $4d39
	add $1b ; $4d3a
	ld b, a ; $4d3c
	ld hl, wStorySlotData ; $4d3d
	ld de, wTextBuffer ; $4d40
	call WriteSaveBlock ; $4d43
	or a ; $4d46
	ret nz ; $4d47
	ld a, [wCurrentStorySlot] ; $4d48
	add a ; $4d4b
	add $1b ; $4d4c
	ld b, a ; $4d4e
	ld hl, wStorySlotData ; $4d4f
	call VerifySaveBlock ; $4d52
	or a ; $4d55
	ret nz ; $4d56
	call UpdateUnlockablesSaveBlock ; $4d57
	xor a ; $4d5a
	ret ; $4d5b
	pop af ; $4d5c
	wram_bank ; $4d5d
	ld a, $ff ; $4d61
	ret ; $4d63
CheckStorySlot:
	push bc ; $4d64
	push de ; $4d65
	push hl ; $4d66
	ld a, [wCurrentStorySlot] ; $4d67
	cp $03 ; $4d6a
	jr nc, .noSlot ; $4d6c
	add a ; $4d6e
	ld b, a ; $4d6f
	ld hl, wStorySlotData ; $4d70
	call ReadSaveBlock ; $4d73
	jr .done ; $4d76
.noSlot:
	ld a, $fe ; $4d78
.done:
	pop hl ; $4d7a
	pop de ; $4d7b
	pop bc ; $4d7c
	ret ; $4d7d
SaveFlagMaskTable_03:
	; $4d7e, 8 bytes (bytes:8)
	db $80, $40, $20, $10, $08, $04, $02, $01 ; 0x00
TestSaveFlag:
	push hl ; $4d86
	push de ; $4d87
	push bc ; $4d88
	ld b, a ; $4d89
	ld a, $0a ; $4d8a
	ld [rRAMG], a ; $4d8c
	ld a, $00 ; $4d8f
	ldh [hSramBank], a ; $4d91
	ld [rRAMB], a ; $4d93
	ld hl, SaveFlagMaskTable_03 ; $4d96
	ld a, e ; $4d99
	rlca ; $4d9a
	rlca ; $4d9b
	rlca ; $4d9c
	add l ; $4d9d
	ld l, a ; $4d9e
	jr nc, .gotMask ; $4d9f
	inc h ; $4da1
.gotMask:
	ld a, [hl] ; $4da2
	ld hl, sSaveFlags ; $4da3
	ld e, d ; $4da6
	ld d, $00 ; $4da7
	add hl, de ; $4da9
	and [hl] ; $4daa
	push af ; $4dab
	xor a ; $4dac
	ld [rRAMG], a ; $4dad
	pop af ; $4db0
	ld a, b ; $4db1
	pop bc ; $4db2
	pop de ; $4db3
	pop hl ; $4db4
	ret ; $4db5
SetSaveFlag:
	push hl ; $4db6
	push af ; $4db7
	ld a, $0a ; $4db8
	ld [rRAMG], a ; $4dba
	ld a, $00 ; $4dbd
	ldh [hSramBank], a ; $4dbf
	ld [rRAMB], a ; $4dc1
	ld hl, SaveFlagMaskTable_03 ; $4dc4
	ld a, e ; $4dc7
	rlca ; $4dc8
	rlca ; $4dc9
	rlca ; $4dca
	add l ; $4dcb
	ld l, a ; $4dcc
	jr nc, .gotMask ; $4dcd
	inc h ; $4dcf
.gotMask:
	ld a, [hl] ; $4dd0
	ld hl, sSaveFlags ; $4dd1
	ld e, d ; $4dd4
	ld d, $00 ; $4dd5
	add hl, de ; $4dd7
	or [hl] ; $4dd8
	ld [hl], a ; $4dd9
	call UpdateSaveHeaderChecksum ; $4dda
	xor a ; $4ddd
	ld [rRAMG], a ; $4dde
	pop af ; $4de1
	pop hl ; $4de2
	ret ; $4de3
ClearSaveFlag:
	push hl ; $4de4
	push af ; $4de5
	ld a, $0a ; $4de6
	ld [rRAMG], a ; $4de8
	ld a, $00 ; $4deb
	ldh [hSramBank], a ; $4ded
	ld [rRAMB], a ; $4def
	ld hl, SaveFlagMaskTable_03 ; $4df2
	ld a, e ; $4df5
	rlca ; $4df6
	rlca ; $4df7
	rlca ; $4df8
	add l ; $4df9
	ld l, a ; $4dfa
	jr nc, .gotMask ; $4dfb
	inc h ; $4dfd
.gotMask:
	ld a, [hl] ; $4dfe
	ld hl, sSaveFlags ; $4dff
	ld e, d ; $4e02
	ld d, $00 ; $4e03
	add hl, de ; $4e05
	cpl ; $4e06
	and [hl] ; $4e07
	ld [hl], a ; $4e08
	call UpdateSaveHeaderChecksum ; $4e09
	xor a ; $4e0c
	ld [rRAMG], a ; $4e0d
	pop af ; $4e10
	pop hl ; $4e11
	ret ; $4e12
EraseStorySlotSaveData:
	push bc ; $4e13
	push de ; $4e14
	push hl ; $4e15
	ld h, a ; $4e16
	ld a, $0a ; $4e17
	ld [rRAMG], a ; $4e19
	call InitSaveHeader ; $4e1c
	ld a, [wCurrentStorySlot] ; $4e1f
	cp $03 ; $4e22
	jp nc, .badSlot ; $4e24
	add a ; $4e27
	ld c, a ; $4e28
	ld a, $00 ; $4e29
	add c ; $4e2b
	ld b, a ; $4e2c
	call ClearSaveBlock ; $4e2d
	inc b ; $4e30
	call ClearSaveBlock ; $4e31
	ld a, $1b ; $4e34
	add c ; $4e36
	ld b, a ; $4e37
	call ClearSaveBlock ; $4e38
	inc b ; $4e3b
	call ClearSaveBlock ; $4e3c
	call MirrorSaveHeaderToBank1 ; $4e3f
	xor a ; $4e42
	ld [rRAMG], a ; $4e43
	call InitCurrentSlotMinigameRecords ; $4e46
	ld a, [wCurrentStorySlot] ; $4e49
	or a ; $4e4c
	jr z, .slot0 ; $4e4d
	cp $01 ; $4e4f
	jr z, .slot1 ; $4e51
	push de ; $4e53
	ld de, SAVEFLAG_STORY_SLOT2_A ; $4e54
	farcall ClearSaveFlag ; $4e57
	pop de ; $4e5a
	push de ; $4e5b
	ld de, SAVEFLAG_STORY_SLOT2_B ; $4e5c
	farcall ClearSaveFlag ; $4e5f
	pop de ; $4e62
	jr .ok ; $4e63
.slot0:
	push de ; $4e65
	ld de, SAVEFLAG_STORY_SLOT0_A ; $4e66
	farcall ClearSaveFlag ; $4e69
	pop de ; $4e6c
	push de ; $4e6d
	ld de, SAVEFLAG_STORY_SLOT0_B ; $4e6e
	farcall ClearSaveFlag ; $4e71
	pop de ; $4e74
	jr .ok ; $4e75
.slot1:
	push de ; $4e77
	ld de, SAVEFLAG_STORY_SLOT1_A ; $4e78
	farcall ClearSaveFlag ; $4e7b
	pop de ; $4e7e
	push de ; $4e7f
	ld de, SAVEFLAG_STORY_SLOT1_B ; $4e80
	farcall ClearSaveFlag ; $4e83
	pop de ; $4e86
.ok:
	xor a ; $4e87
	jr .done ; $4e88
.badSlot:
	ld a, $01 ; $4e8a
.done:
	pop hl ; $4e8c
	pop de ; $4e8d
	pop bc ; $4e8e
	ret ; $4e8f
ClearSaveBlock:
	ld a, h ; $4e90
	or a ; $4e91
	jr nz, .clearData ; $4e92
	call ClearSaveBlockEntry ; $4e94
	jr .done ; $4e97
.clearData:
	call ClearSaveBlockData ; $4e99
.done:
	ret ; $4e9c
ClearSaveBlockData:
	push hl ; $4e9d
	push de ; $4e9e
	push bc ; $4e9f
	ld a, $00 ; $4ea0
	ldh [hSramBank], a ; $4ea2
	ld [rRAMB], a ; $4ea4
	ld a, b ; $4ea7
	call GetSaveBlockDirEntry ; $4ea8
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
	ldh [hSramBank], a ; $4ec3
	ld [rRAMB], a ; $4ec5
	pop hl ; $4ec8
	push hl ; $4ec9
	push bc ; $4eca
.loop:
	xor a ; $4ecb
	ld [de], a ; $4ecc
	inc de ; $4ecd
	dec bc ; $4ece
	ld a, b ; $4ecf
	or c ; $4ed0
	jr nz, .loop ; $4ed1
	pop bc ; $4ed3
	pop hl ; $4ed4
	ld de, $0000 ; $4ed5
	ld a, $00 ; $4ed8
	ldh [hSramBank], a ; $4eda
	ld [rRAMB], a ; $4edc
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
.loopB:
	xor a ; $4eed
	ld [hl+], a ; $4eee
	dec c ; $4eef
	jr nz, .loopB ; $4ef0
	xor a ; $4ef2
	pop bc ; $4ef3
	pop de ; $4ef4
	pop hl ; $4ef5
	ret ; $4ef6
	push hl ; $4ef7
	push de ; $4ef8
	push bc ; $4ef9
	ld a, $00 ; $4efa
	ldh [hSramBank], a ; $4efc
	ld [rRAMB], a ; $4efe
	ld a, b ; $4f01
	call GetSaveBlockDirEntry ; $4f02
	push bc ; $4f05
	push hl ; $4f06
	ld hl, $0001 ; $4f07
	add hl, bc ; $4f0a
	ld c, [hl] ; $4f0b
	push bc ; $4f0c
	inc hl ; $4f0d
	ld a, [hl+] ; $4f0e
	ld e, a ; $4f0f
	ld a, [hl+] ; $4f10
	ld d, a ; $4f11
	ld a, [hl+] ; $4f12
	ld b, [hl] ; $4f13
	ld c, a ; $4f14
	ld hl, $a000 ; $4f15
	add hl, de ; $4f18
	ld d, h ; $4f19
	ld e, l ; $4f1a
	ld hl, $0008 ; $4f1b
	add hl, de ; $4f1e
	ld d, h ; $4f1f
	ld e, l ; $4f20
	pop hl ; $4f21
	ld a, l ; $4f22
	ldh [hSramBank], a ; $4f23
	ld [rRAMB], a ; $4f25
	pop hl ; $4f28
	push hl ; $4f29
	push bc ; $4f2a
.loop2:
	xor a ; $4f2b
	ld [de], a ; $4f2c
	inc de ; $4f2d
	dec bc ; $4f2e
	ld a, b ; $4f2f
	or c ; $4f30
	jr nz, .loop2 ; $4f31
	pop bc ; $4f33
	pop hl ; $4f34
	ld de, $0000 ; $4f35
	ld a, $00 ; $4f38
	ldh [hSramBank], a ; $4f3a
	ld [rRAMB], a ; $4f3c
	pop bc ; $4f3f
	ld a, $01 ; $4f40
	ld [bc], a ; $4f42
	ld hl, $0006 ; $4f43
	add hl, bc ; $4f46
	ld [hl], e ; $4f47
	inc hl ; $4f48
	ld [hl], d ; $4f49
	inc hl ; $4f4a
	ld c, $08 ; $4f4b
.loop3:
	xor a ; $4f4d
	ld [hl+], a ; $4f4e
	dec c ; $4f4f
	jr nz, .loop3 ; $4f50
	xor a ; $4f52
	pop bc ; $4f53
	pop de ; $4f54
	pop hl ; $4f55
	ret ; $4f56
ClearSaveBlockEntry:
	push hl ; $4f57
	push de ; $4f58
	push bc ; $4f59
	ld a, $00 ; $4f5a
	ldh [hSramBank], a ; $4f5c
	ld [rRAMB], a ; $4f5e
	ld a, b ; $4f61
	call GetSaveBlockDirEntry ; $4f62
	xor a ; $4f65
	ld [bc], a ; $4f66
	ld de, $0000 ; $4f67
	ld hl, $0006 ; $4f6a
	add hl, bc ; $4f6d
	ld [hl], e ; $4f6e
	inc hl ; $4f6f
	ld [hl], d ; $4f70
	inc hl ; $4f71
	ld c, $08 ; $4f72
	xor a ; $4f74
.loop:
	ld [hl+], a ; $4f75
	dec c ; $4f76
	jr nz, .loop ; $4f77
	pop bc ; $4f79
	pop de ; $4f7a
	pop hl ; $4f7b
	ret ; $4f7c
ReinitSaveRamPreservingBlock6:
	push af ; $4f7d
	push bc ; $4f7e
	push de ; $4f7f
	push hl ; $4f80
	ldh a, [hWramBank] ; $4f81
	push af ; $4f83
	wram_bank $01 ; $4f84
	ld hl, wDecompBuffer ; $4f8a
	call ReadBlock6 ; $4f8d
	ld b, a ; $4f90
	push bc ; $4f91
	call EraseAndInitSaveRam ; $4f92
	pop bc ; $4f95
	ld a, b ; $4f96
	cp $fe ; $4f97
	jr z, .initAllMinigameRecordBlocks ; $4f99
	ld hl, wDecompBuffer ; $4f9b
	call WriteBlock6WithBackup ; $4f9e
.initAllMinigameRecordBlocks:
	call InitAllMinigameRecordBlocks ; $4fa1
	pop af ; $4fa4
	wram_bank ; $4fa5
	pop hl ; $4fa9
	pop de ; $4faa
	pop bc ; $4fab
	pop af ; $4fac
	ret ; $4fad
WriteExhibitionSaveBlock:
	ld a, $36 ; $4fae
	ld b, a ; $4fb0
	ld hl, wStorySlotData ; $4fb1
	ld de, $0000 ; $4fb4
	call WriteSaveBlock ; $4fb7
	or a ; $4fba
	ret nz ; $4fbb
	ld a, $36 ; $4fbc
	ld b, a ; $4fbe
	ld hl, wStorySlotData ; $4fbf
	call VerifySaveBlock ; $4fc2
	or a ; $4fc5
	ret nz ; $4fc6
	ld a, $37 ; $4fc7
	ld b, a ; $4fc9
	ld hl, wStorySlotData ; $4fca
	ld de, wTextBuffer ; $4fcd
	call WriteSaveBlock ; $4fd0
	or a ; $4fd3
	ret nz ; $4fd4
	ld a, $37 ; $4fd5
	ld b, a ; $4fd7
	ld hl, wStorySlotData ; $4fd8
	call VerifySaveBlock ; $4fdb
	or a ; $4fde
	ret nz ; $4fdf
	xor a ; $4fe0
	ret ; $4fe1
	pop af ; $4fe2
	wram_bank ; $4fe3
	ld a, $ff ; $4fe7
	ret ; $4fe9
ReadExhibitionSaveBlock:
	push bc ; $4fea
	push de ; $4feb
	push hl ; $4fec
	ld a, $36 ; $4fed
	ld b, a ; $4fef
	ld hl, wStorySlotData ; $4ff0
	call ReadSaveBlock ; $4ff3
	jr .restore ; $4ff6
	db $3e ; $4ff8
	db $fe ; $4ff9
.restore:
	pop hl ; $4ffa
	pop de ; $4ffb
	pop bc ; $4ffc
	ret ; $4ffd
ClearSaveBlock11:
	push bc ; $4ffe
	push de ; $4fff
	push hl ; $5000
	ld a, $0a ; $5001
	ld [rRAMG], a ; $5003
	ld b, $0b ; $5006
	call ClearSaveBlockData ; $5008
	push af ; $500b
	xor a ; $500c
	ld [rRAMG], a ; $500d
	pop af ; $5010
	pop hl ; $5011
	pop de ; $5012
	pop bc ; $5013
	ret ; $5014
ReadMinigameRecord:
	push af ; $5015
	push bc ; $5016
	push de ; $5017
	push hl ; $5018
	ld b, a ; $5019
	ldh a, [hWramBank] ; $501a
	push af ; $501c
	wram_bank $07 ; $501d
	ld a, b ; $5023
	sub $02 ; $5024
	jr nc, .read ; $5026
	ld a, [wCurrentStorySlot] ; $5028
	cp $03 ; $502b
	jr nc, .done ; $502d
.read:
	push af ; $502f
	push bc ; $5030
	push de ; $5031
	push hl ; $5032
	ld hl, wMinigameRecordBlock ; $5033
	ld c, $02 ; $5036
	xor a ; $5038
	call FillMemory16 ; $5039
	pop hl ; $503c
	pop de ; $503d
	pop bc ; $503e
	pop af ; $503f
	ld a, b ; $5040
	sub $02 ; $5041
	jr nc, .notStory ; $5043
	ld a, [wCurrentStorySlot] ; $5045
	jr .gotBlockId ; $5048
.notStory:
	xor a ; $504a
.gotBlockId:
	add $38 ; $504b
	push bc ; $504d
	ld b, a ; $504e
	ld hl, wMinigameRecordBlock ; $504f
	call ReadSaveBlock ; $5052
	pop bc ; $5055
	ld a, b ; $5056
	add a ; $5057
	ld l, a ; $5058
	xor a ; $5059
	ld h, a ; $505a
	ld de, wMinigameRecordBlock ; $505b
	add hl, de ; $505e
	ld a, [hl+] ; $505f
	ld d, [hl] ; $5060
	ld e, a ; $5061
	ld hl, wMinigameRecordValue ; $5062
	ld a, e ; $5065
	ld [hl+], a ; $5066
	ld [hl], d ; $5067
.done:
	pop af ; $5068
	wram_bank ; $5069
	pop hl ; $506d
	pop de ; $506e
	pop bc ; $506f
	pop af ; $5070
	ret ; $5071
UpdateMinigameRecord:
	push bc ; $5072
	push de ; $5073
	push hl ; $5074
	ld b, a ; $5075
	ldh a, [hWramBank] ; $5076
	push af ; $5078
	wram_bank $07 ; $5079
	ld a, b ; $507f
	sub $02 ; $5080
	jr nc, .readSlot0 ; $5082
	ld a, [wCurrentStorySlot] ; $5084
	cp $03 ; $5087
	jp nc, .failed ; $5089
	jr .read ; $508c
.readSlot0:
	ld a, $00 ; $508e
.read:
	push af ; $5090
	push bc ; $5091
	push de ; $5092
	push hl ; $5093
	ld hl, wMinigameRecordBlock ; $5094
	ld c, $02 ; $5097
	xor a ; $5099
	call FillMemory16 ; $509a
	pop hl ; $509d
	pop de ; $509e
	pop bc ; $509f
	pop af ; $50a0
	add $38 ; $50a1
	push bc ; $50a3
	ld b, a ; $50a4
	ld hl, wMinigameRecordBlock ; $50a5
	call ReadSaveBlock ; $50a8
	pop bc ; $50ab
	ld hl, wMinigameRecordValue ; $50ac
	ld a, [hl+] ; $50af
	ld d, [hl] ; $50b0
	ld e, a ; $50b1
	push de ; $50b2
	ld a, b ; $50b3
	add a ; $50b4
	ld l, a ; $50b5
	xor a ; $50b6
	ld h, a ; $50b7
	ld de, wMinigameRecordBlock ; $50b8
	add hl, de ; $50bb
	pop de ; $50bc
	ld a, e ; $50bd
	ld [hl+], a ; $50be
	ld [hl], d ; $50bf
	ld a, b ; $50c0
	sub $02 ; $50c1
	jr nc, .writeSlot0 ; $50c3
	ld a, [wCurrentStorySlot] ; $50c5
	jr .write ; $50c8
.writeSlot0:
	xor a ; $50ca
.write:
	push bc ; $50cb
	add $38 ; $50cc
	ld b, a ; $50ce
	ld hl, wMinigameRecordBlock ; $50cf
	ld de, $0000 ; $50d2
	call WriteSaveBlock ; $50d5
	pop bc ; $50d8
	or a ; $50d9
	jr nz, .failed ; $50da
	ld a, b ; $50dc
	sub $02 ; $50dd
	jr nc, .verifySlot0 ; $50df
	ld a, [wCurrentStorySlot] ; $50e1
	jr .verify ; $50e4
.verifySlot0:
	xor a ; $50e6
.verify:
	push bc ; $50e7
	add $38 ; $50e8
	ld b, a ; $50ea
	ld hl, wMinigameRecordBlock ; $50eb
	call VerifySaveBlock ; $50ee
	pop bc ; $50f1
	or a ; $50f2
	jr nz, .failed ; $50f3
	ld a, b ; $50f5
	sub $02 ; $50f6
	jr nc, .backupSlot0 ; $50f8
	ld a, [wCurrentStorySlot] ; $50fa
	jr .writeBackup ; $50fd
.backupSlot0:
	xor a ; $50ff
.writeBackup:
	push bc ; $5100
	add $3b ; $5101
	ld b, a ; $5103
	ld hl, wMinigameRecordBlock ; $5104
	ld de, $0000 ; $5107
	call WriteSaveBlock ; $510a
	pop bc ; $510d
	or a ; $510e
	jr nz, .failed ; $510f
	ld a, b ; $5111
	sub $02 ; $5112
	jr nc, .backupVerifySlot0 ; $5114
	ld a, [wCurrentStorySlot] ; $5116
	jr .verifyBackup ; $5119
.backupVerifySlot0:
	xor a ; $511b
.verifyBackup:
	push bc ; $511c
	add $3b ; $511d
	ld b, a ; $511f
	ld hl, wMinigameRecordBlock ; $5120
	call VerifySaveBlock ; $5123
	pop bc ; $5126
	or a ; $5127
	jr nz, .failed ; $5128
	jr .done ; $512a
.failed:
	pop af ; $512c
	wram_bank ; $512d
	ld a, $01 ; $5131
	pop hl ; $5133
	pop de ; $5134
	pop bc ; $5135
	ret ; $5136
.done:
	pop af ; $5137
	wram_bank ; $5138
	xor a ; $513c
	pop hl ; $513d
	pop de ; $513e
	pop bc ; $513f
	ret ; $5140
InitCurrentSlotMinigameRecords:
	push af ; $5141
	push bc ; $5142
	push de ; $5143
	push hl ; $5144
	ldh a, [hWramBank] ; $5145
	push af ; $5147
	wram_bank $07 ; $5148
	ld a, [wCurrentStorySlot] ; $514e
	add $38 ; $5151
	ld b, a ; $5153
	ld hl, wMinigameRecordBlock ; $5154
	call ReadSaveBlock ; $5157
	xor a ; $515a
	farcall GetDefaultMinigameRecordValue ; $515b
	ld hl, wMinigameRecordBlock ; $515e
	ld a, e ; $5161
	ld [hl+], a ; $5162
	ld [hl], d ; $5163
	ld a, $01 ; $5164
	farcall GetDefaultMinigameRecordValue ; $5166
	ld hl, wMinigameRecordBlock + 2 ; $5169
	ld a, e ; $516c
	ld [hl+], a ; $516d
	ld [hl], d ; $516e
	ld a, [wCurrentStorySlot] ; $516f
	add $38 ; $5172
	ld b, a ; $5174
	ld hl, wMinigameRecordBlock ; $5175
	ld de, $0000 ; $5178
	call WriteSaveBlock ; $517b
	or a ; $517e
	jr nz, .restore ; $517f
	ld a, [wCurrentStorySlot] ; $5181
	add $3b ; $5184
	ld b, a ; $5186
	ld hl, wMinigameRecordBlock ; $5187
	ld de, $0000 ; $518a
	call WriteSaveBlock ; $518d
.restore:
	pop af ; $5190
	wram_bank ; $5191
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
InitAllMinigameRecordBlocks:
	push af ; $519a
	push bc ; $519b
	push de ; $519c
	push hl ; $519d
	ldh a, [hWramBank] ; $519e
	push af ; $51a0
	wram_bank $07 ; $51a1
	push af ; $51a7
	push bc ; $51a8
	push de ; $51a9
	push hl ; $51aa
	ld hl, wMinigameRecordBlock ; $51ab
	ld c, $02 ; $51ae
	xor a ; $51b0
	call FillMemory16 ; $51b1
	pop hl ; $51b4
	pop de ; $51b5
	pop bc ; $51b6
	pop af ; $51b7
	ld hl, wMinigameRecordBlock ; $51b8
	xor a ; $51bb
.loop:
	cp $0b ; $51bc
	jr z, .eq0b ; $51be
	push af ; $51c0
	push hl ; $51c1
	farcall GetDefaultMinigameRecordValue ; $51c2
	pop hl ; $51c5
	ld a, e ; $51c6
	ld [hl+], a ; $51c7
	ld [hl], d ; $51c8
	pop af ; $51c9
	inc a ; $51ca
	inc hl ; $51cb
	jr .loop ; $51cc
.eq0b:
	ld a, $38 ; $51ce
	ld b, a ; $51d0
	ld hl, wMinigameRecordBlock ; $51d1
	ld de, $0000 ; $51d4
	call WriteSaveBlock ; $51d7
	or a ; $51da
	jr nz, .restore ; $51db
	ld a, $3b ; $51dd
	ld b, a ; $51df
	ld hl, wMinigameRecordBlock ; $51e0
	ld de, $0000 ; $51e3
	call WriteSaveBlock ; $51e6
	ld a, $39 ; $51e9
	ld b, a ; $51eb
	ld hl, wMinigameRecordBlock ; $51ec
	ld de, $0000 ; $51ef
	call WriteSaveBlock ; $51f2
	or a ; $51f5
	jr nz, .restore ; $51f6
	ld a, $3c ; $51f8
	ld b, a ; $51fa
	ld hl, wMinigameRecordBlock ; $51fb
	ld de, $0000 ; $51fe
	call WriteSaveBlock ; $5201
	ld a, $3a ; $5204
	ld b, a ; $5206
	ld hl, wMinigameRecordBlock ; $5207
	ld de, $0000 ; $520a
	call WriteSaveBlock ; $520d
	or a ; $5210
	jr nz, .restore ; $5211
	ld a, $3d ; $5213
	ld b, a ; $5215
	ld hl, wMinigameRecordBlock ; $5216
	ld de, $0000 ; $5219
	call WriteSaveBlock ; $521c
.restore:
	pop af ; $521f
	wram_bank ; $5220
	pop hl ; $5224
	pop de ; $5225
	pop bc ; $5226
	pop af ; $5227
	ret ; $5228
ReadMarioCastVictoryGrid:
	push af ; $5229
	push bc ; $522a
	push de ; $522b
	push hl ; $522c
	ld b, $3e ; $522d
	call ReadSaveBlock ; $522f
	or a ; $5232
	jr z, .restore ; $5233
	xor a ; $5235
	ld c, $06 ; $5236
	call FillMemory16 ; $5238
.restore:
	pop hl ; $523b
	pop de ; $523c
	pop bc ; $523d
	pop af ; $523e
	ret ; $523f
WriteMarioCastVictoryGrid:
	push bc ; $5240
	push de ; $5241
	push hl ; $5242
	ld b, $3e ; $5243
	ld de, $0000 ; $5245
	call WriteSaveBlock ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	ret ; $524e
MoveSaveEditorCursor:
	ldh a, [hPlayerInputFlags] ; $524f
	bit PADB_A, a ; $5251
	jr nz, .move ; $5253
	ld hl, hSaveEditorCursor ; $5255
	ld a, [hl+] ; $5258
	ld h, [hl] ; $5259
	ld l, a ; $525a
	ld b, l ; $525b
	ld e, c ; $525c
	call SignExtendEToDE ; $525d
	add hl, de ; $5260
	ld a, h ; $5261
	and $03 ; $5262
	ldh [hSaveEditorCursor + 1], a ; $5264
	ld a, l ; $5266
	ldh [hSaveEditorCursor], a ; $5267
	xor b ; $5269
	bit 7, a ; $526a
	ret ; $526c
	xor a ; $526d
	dec a ; $526e
	ret ; $526f
.move:
	sound SFX_MENU_MOVE ; $5270
	ld hl, hSaveEditorCursor ; $5272
	ld a, [hl+] ; $5275
	ld h, [hl] ; $5276
	ld l, a ; $5277
	ld de, $d300 ; $5278
	add hl, de ; $527b
	push hl ; $527c
	ld a, [hl] ; $527d
	add b ; $527e
	ld [hl], a ; $527f
	pop hl ; $5280
	res 0, l ; $5281
	ld b, l ; $5283
	ld a, [hl+] ; $5284
	ld l, [hl] ; $5285
	ld h, a ; $5286
	push hl ; $5287
	ld a, b ; $5288
	and $06 ; $5289
	add a ; $528b
	add $04 ; $528c
	ld d, a ; $528e
	ld a, b ; $528f
	and $78 ; $5290
	add a ; $5292
	swap a ; $5293
	inc a ; $5295
	ld e, a ; $5296
	pop hl ; $5297
	call PrintHexWord ; $5298
	xor a ; $529b
	ret ; $529c
GetCurrentSlotBlockId:
	push af ; $529d
	push hl ; $529e
	ld a, [wCurrentStorySlot] ; $529f
	and $03 ; $52a2
	add LOW(StorySlotBlockIds_03) ; $52a4
	ld l, a ; $52a6
	adc HIGH(StorySlotBlockIds_03) ; $52a7
	sub l ; $52a9
	ld h, a ; $52aa
	ld b, [hl] ; $52ab
	pop hl ; $52ac
	pop af ; $52ad
	ret ; $52ae
StorySlotBlockIds_03:
	; $52af, 4 bytes (bytes:4)
	db $00, $02, $04, $0b ; 0x00
ReadCurrentSlotBlock:
	wram_bank $07 ; $52b3
	call GetCurrentSlotBlockId ; $52b9
	ld hl, wSaveBlockBuffer ; $52bc
	call ReadSaveBlock ; $52bf
	ret ; $52c2
WriteCurrentSlotBlock:
	wram_bank $07 ; $52c3
	call GetCurrentSlotBlockId ; $52c9
	ld hl, wSaveBlockBuffer ; $52cc
	call WriteSaveBlock ; $52cf
	ret ; $52d2
InvalidateCurrentSlotBlock:
	wram_bank $07 ; $52d3
	call GetCurrentSlotBlockId ; $52d9
	ld hl, wSaveBlockBuffer ; $52dc
	call InvalidateStorySlot ; $52df
	ret ; $52e2
	; $52e3, 13 bytes (fill)
	ds 13, $00
SaveEditorCursorTiles_03:
	INCBIN "data/bank_003/d_52f0.bin" ; $52f0, 32 bytes
SaveSlotDebugEditor:
	ld hl, SaveEditorCursorTiles_03 ; $5310
	ld de, $8000 ; $5313
	ld c, (SaveSlotDebugEditor - SaveEditorCursorTiles_03) / 16 ; $5316
	call QueueVRAMCopy ; $5318
	sound BGM_EXHIBITION_MATCH ; $531b
	ld a, $03 ; $531d
	ldh [hDebugStepMode], a ; $531f
	xor a ; $5321
	ld [wCurrentStorySlot], a ; $5322
	ld hl, $0000 ; $5325
	ld a, l ; $5328
	ldh [hSaveEditorCursor], a ; $5329
	ld a, h ; $532b
	ldh [hSaveEditorCursor + 1], a ; $532c
	farcall InitTextWindows ; $532e
	call EnableLCD ; $5331
	ld c, $7f ; $5334
	call BeginFadeOut ; $5336
	script_fade_in $7f ; $5339
	farcall InitStoryModeState ; $533e
	ld de, $0000 ; $5341
.loop:
	call ReadCurrentSlotBlock ; $5344
	or a ; $5347
	jr z, .zero ; $5348
	push de ; $534a
	ld hl, SaveResultFailedString_03 ; $534b
	ld de, $0511 ; $534e
	call PrintString ; $5351
	pop de ; $5354
	ld hl, $d300 ; $5355
	ld c, $30 ; $5358
	call ClearMemory16 ; $535a
	jp .loopB ; $535d
.zero:
	ld hl, SaveResultLoadedString_03 ; $5360
	ld de, $0511 ; $5363
	call PrintString ; $5366
.loopB:
	wram_bank $07 ; $5369
	push de ; $536f
	ld hl, hSaveEditorCursor ; $5370
	ld a, [hl+] ; $5373
	ld h, [hl] ; $5374
	ld l, a ; $5375
	ld de, $d300 ; $5376
	add hl, de ; $5379
	ld a, l ; $537a
	and $80 ; $537b
	ld l, a ; $537d
	ld b, $10 ; $537e
	ld e, $01 ; $5380
.loop2:
	ld d, $00 ; $5382
	push bc ; $5384
	push de ; $5385
	push hl ; $5386
	ld a, h ; $5387
	sub $d3 ; $5388
	ld h, a ; $538a
	call PrintHexWord ; $538b
	pop hl ; $538e
	pop de ; $538f
	inc d ; $5390
	inc d ; $5391
	inc d ; $5392
	inc d ; $5393
	ld c, $04 ; $5394
.loop3:
	push hl ; $5396
	ld a, [hl+] ; $5397
	ld l, [hl] ; $5398
	ld h, a ; $5399
	push de ; $539a
	push bc ; $539b
	call PrintHexWord ; $539c
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
	jr nz, .loop3 ; $53a9
	inc e ; $53ab
	pop bc ; $53ac
	dec b ; $53ad
	jr nz, .loop2 ; $53ae
	pop de ; $53b0
.loop4:
	push de ; $53b1
	ld hl, hSaveEditorCursor ; $53b2
	ld a, [hl+] ; $53b5
	ld h, [hl] ; $53b6
	ld l, a ; $53b7
	ld de, $1011 ; $53b8
	call PrintHexWord ; $53bb
	ld a, [wCurrentStorySlot] ; $53be
	ld de, $0011 ; $53c1
	call PrintDecimalByte ; $53c4
	pop de ; $53c7
.loop5:
	ldh a, [hPlayerInputFlags] ; $53c8
	bit PADB_A, a ; $53ca
	jr nz, .step2 ; $53cc
	ldh a, [hVBlankCounter] ; $53ce
	bit 3, a ; $53d0
	jr z, .advanceFrame ; $53d2
.step2:
	push de ; $53d4
	ldh a, [hSaveEditorCursor] ; $53d5
	ld e, a ; $53d7
	and $07 ; $53d8
	swap a ; $53da
	add $24 ; $53dc
	ld d, a ; $53de
	ld a, e ; $53df
	and $78 ; $53e0
	add $0c ; $53e2
	ld e, a ; $53e4
	ld bc, $0000 ; $53e5
	push de ; $53e8
	call QueueSprite ; $53e9
	pop de ; $53ec
	ld bc, $0000 ; $53ed
	ld a, d ; $53f0
	add $08 ; $53f1
	ld d, a ; $53f3
	call QueueSprite ; $53f4
	pop de ; $53f7
.advanceFrame:
	call AdvanceFrame ; $53f8
	ldh a, [hInputPressed] ; $53fb
	bit PADB_UP, a ; $53fd
	jr z, .moveSaveEditorCursor ; $53ff
	ld bc, $f0f8 ; $5401
	call MoveSaveEditorCursor ; $5404
	jr z, .loop4 ; $5407
	jp .loopB ; $5409
.moveSaveEditorCursor:
	bit 5, a ; $540c
	jr z, .bit5Clear ; $540e
	ld bc, $ffff ; $5410
	call MoveSaveEditorCursor ; $5413
	jr z, .loop4 ; $5416
	jp .loopB ; $5418
.bit5Clear:
	bit 4, a ; $541b
	jr z, .bit4Clear ; $541d
	ld bc, $0101 ; $541f
	call MoveSaveEditorCursor ; $5422
	jr z, .loop4 ; $5425
	jp .loopB ; $5427
.bit4Clear:
	bit 7, a ; $542a
	jr z, .positive ; $542c
	ld bc, $1008 ; $542e
	call MoveSaveEditorCursor ; $5431
	jp z, .loop4 ; $5434
	jp .loopB ; $5437
.positive:
	bit 1, a ; $543a
	jr z, .bit1Clear ; $543c
	ld a, [wCurrentStorySlot] ; $543e
	push af ; $5441
	ld a, $03 ; $5442
	ld [wCurrentStorySlot], a ; $5444
	call ReadCurrentSlotBlock ; $5447
	or a ; $544a
	jr nz, .restore ; $544b
	ld hl, $d300 ; $544d
	ld a, [hl+] ; $5450
	or [hl] ; $5451
	jr z, .restore ; $5452
	inc hl ; $5454
	ld a, $01 ; $5455
	ld [hl+], a ; $5457
	ld [hl+], a ; $5458
	ld [hl+], a ; $5459
	ld [hl+], a ; $545a
	ld [hl+], a ; $545b
	ld [hl+], a ; $545c
	call WriteCurrentSlotBlock ; $545d
	pop af ; $5460
	sound JINGLE_DONE_FOR_THE_DAY ; $5461
	jp .loop ; $5463
.restore:
	pop af ; $5466
	ld [wCurrentStorySlot], a ; $5467
	jp .loop ; $546a
.bit1Clear:
	bit 2, a ; $546d
	jr z, .bit2Clear ; $546f
	sound SFX_MENU_SELECT ; $5471
	ld a, [wCurrentStorySlot] ; $5473
	inc a ; $5476
	and $03 ; $5477
	ld [wCurrentStorySlot], a ; $5479
	jp .loop ; $547c
.bit2Clear:
	bit 3, a ; $547f
	jr z, .skipSave ; $5481
	sound SFX_MENU_SELECT ; $5483
	ldh a, [hPlayerInputFlags] ; $5485
	bit PADB_A, a ; $5487
	jr nz, .bit3Set ; $5489
	push de ; $548b
	ld hl, SaveResultSavedString_03 ; $548c
	ld de, $0511 ; $548f
	call PrintString ; $5492
	call WriteCurrentSlotBlock ; $5495
	pop de ; $5498
	jp .loop4 ; $5499
.bit3Set:
	push de ; $549c
	ld hl, SaveResultDeletedString_03 ; $549d
	ld de, $0511 ; $54a0
	call PrintString ; $54a3
	call InvalidateCurrentSlotBlock ; $54a6
	jp .loop4 ; $54a9
	db $d1 ; $54ac
.skipSave:
	jp .loop5 ; $54ad
SaveResultFailedString_03:
	; $54b0, 12 bytes (ascii)
	db "FAILED     ", $00
SaveResultLoadedString_03:
	; $54bc, 12 bytes (ascii)
	db "LOADED     ", $00
SaveResultSavedString_03:
	; $54c8, 12 bytes (ascii)
	db "SAVED      ", $00
SaveResultDeletedString_03:
	; $54d4, 12 bytes (ascii)
	db "DELETED    ", $00
SaveResultBlankString_03:
	; $54e0, 8 bytes (ascii)
	db "      ", $00, $00
UnusedByteRamp_03:
	; $54e8, 13 bytes (bytes:13)
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d ; 0x00
	; $54f5, 8 bytes (fill)
	ds 8, $00
MarioGolfSignature_03:
	; $54fd, 16 bytes (ascii)
	db "MARIO GOLF GB CH"
RestoreStoryBlockFromBackup:
	ld hl, wDecompBuffer ; $550d
	call ReadSaveBlock ; $5510
	cp $ff ; $5513
	ret nz ; $5515
	push bc ; $5516
	ld a, $1b ; $5517
	add b ; $5519
	ld b, a ; $551a
	call ReadSaveBlock ; $551b
	or a ; $551e
	jr nz, .restore ; $551f
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $5521
	call ReadSaveBlockTag ; $5524
	pop bc ; $5527
	ld hl, wDecompBuffer ; $5528
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $552b
	call WriteSaveBlock ; $552e
	ret ; $5531
.restore:
	pop bc ; $5532
	call InvalidateSaveBlock ; $5533
	inc b ; $5536
	call InvalidateSaveBlock ; $5537
	ret ; $553a
Unused_03_InvalidateBlockIfUnwritten:
	ld hl, $d000 ; $553b
	call ReadSaveBlock ; $553e
	cp $ff ; $5541
	ret nz ; $5543
	call InvalidateSaveBlock ; $5544
	ret ; $5547
Unused_03_RestoreBlockOrClear:
	ld hl, $d000 ; $5548
	call ReadSaveBlock ; $554b
	cp $ff ; $554e
	ret nz ; $5550
	push bc ; $5551
	ld a, $1b ; $5552
	add b ; $5554
	ld b, a ; $5555
	call ReadSaveBlock ; $5556
	or a ; $5559
	jr nz, .nonZero ; $555a
	pop bc ; $555c
	ld hl, $d000 ; $555d
	ld de, $0000 ; $5560
	call WriteSaveBlock ; $5563
	ret ; $5566
.nonZero:
	push bc ; $5567
	ld hl, $d000 ; $5568
	ld c, $20 ; $556b
	call ClearMemory16 ; $556d
	pop bc ; $5570
	ld hl, $d000 ; $5571
	ld de, $0000 ; $5574
	call WriteSaveBlock ; $5577
	ret ; $557a
Unused_03_RestoreBlock06FromBackup:
	ld b, $06 ; $557b
	ld hl, $d000 ; $557d
	call ReadSaveBlock ; $5580
	cp $ff ; $5583
	ret nz ; $5585
	ld b, $21 ; $5586
	call ReadSaveBlock ; $5588
	or a ; $558b
	jr nz, .nonZero2 ; $558c
	ld b, $06 ; $558e
	ld hl, $d000 ; $5590
	ld de, $0000 ; $5593
	call WriteSaveBlock ; $5596
	ret ; $5599
.nonZero2:
	ld b, $06 ; $559a
	call InvalidateSaveBlock ; $559c
	ld b, $21 ; $559f
	call InvalidateSaveBlock ; $55a1
	ret ; $55a4
Unused_03_RestoreBlock07FromBackup:
	ld b, $07 ; $55a5
	ld hl, $d000 ; $55a7
	call ReadSaveBlock ; $55aa
	cp $ff ; $55ad
	ret nz ; $55af
	ld b, $22 ; $55b0
	call ReadSaveBlock ; $55b2
	or a ; $55b5
	jr nz, .nonZero3 ; $55b6
	ld b, $07 ; $55b8
	ld hl, $d000 ; $55ba
	ld de, $0000 ; $55bd
	call WriteSaveBlock ; $55c0
	ret ; $55c3
.nonZero3:
	ld b, $07 ; $55c4
	call InvalidateSaveBlock ; $55c6
	ld b, $22 ; $55c9
	call InvalidateSaveBlock ; $55cb
	ret ; $55ce
Unused_03_RestoreBlock08FromBackup:
	ld b, $08 ; $55cf
	ld hl, $d000 ; $55d1
	call ReadSaveBlock ; $55d4
	cp $ff ; $55d7
	ret nz ; $55d9
	ld b, $23 ; $55da
	call ReadSaveBlock ; $55dc
	or a ; $55df
	jr nz, .nonZero4 ; $55e0
	ld b, $08 ; $55e2
	ld hl, $d000 ; $55e4
	ld de, $0000 ; $55e7
	call WriteSaveBlock ; $55ea
	ret ; $55ed
.nonZero4:
	ld b, $08 ; $55ee
	call InvalidateSaveBlock ; $55f0
	ld b, $23 ; $55f3
	call InvalidateSaveBlock ; $55f5
	ret ; $55f8
Unused_03_RestoreBlock09FromBackup:
	ld b, $09 ; $55f9
	ld hl, $d000 ; $55fb
	call ReadSaveBlock ; $55fe
	cp $ff ; $5601
	ret nz ; $5603
	ld b, $24 ; $5604
	call ReadSaveBlock ; $5606
	or a ; $5609
	jr nz, .nonZero5 ; $560a
	ld b, $09 ; $560c
	ld hl, $d000 ; $560e
	ld de, $0000 ; $5611
	call WriteSaveBlock ; $5614
	ret ; $5617
.nonZero5:
	ld b, $09 ; $5618
	call InvalidateSaveBlock ; $561a
	ld b, $24 ; $561d
	call InvalidateSaveBlock ; $561f
	ret ; $5622
Unused_03_RestoreBlock0aFromBackup:
	ld b, $0a ; $5623
	ld hl, $d000 ; $5625
	call ReadSaveBlock ; $5628
	cp $ff ; $562b
	ret nz ; $562d
	ld b, $25 ; $562e
	call ReadSaveBlock ; $5630
	or a ; $5633
	jr nz, .nonZero6 ; $5634
	ld b, $0a ; $5636
	ld hl, $d000 ; $5638
	ld de, $0000 ; $563b
	call WriteSaveBlock ; $563e
	ret ; $5641
.nonZero6:
	ld b, $0a ; $5642
	call InvalidateSaveBlock ; $5644
	ld b, $25 ; $5647
	call InvalidateSaveBlock ; $5649
	ret ; $564c
Unused_03_ClearBlockIfSet:
	ld hl, $d000 ; $564d
	call ReadSaveBlock ; $5650
	or a ; $5653
	ret z ; $5654
	push bc ; $5655
	ld hl, $d000 ; $5656
	ld c, $28 ; $5659
	call ClearMemory16 ; $565b
	pop bc ; $565e
	ld hl, $d000 ; $565f
	ld de, $0000 ; $5662
	call WriteSaveBlock ; $5665
	ret ; $5668
RepairAllSaveSlots:
	wram_bank $01 ; $5669
	ld b, $00 ; $566f
	call RestoreStoryBlockFromBackup ; $5671
	ld b, $02 ; $5674
	call RestoreStoryBlockFromBackup ; $5676
	ld b, $04 ; $5679
	call RestoreStoryBlockFromBackup ; $567b
	call RestoreBlock36FromBackup ; $567e
	ret ; $5681
RestoreBlock36FromBackup:
	ld a, $36 ; $5682
	ld b, a ; $5684
	ld hl, wDecompBuffer ; $5685
	call ReadSaveBlock ; $5688
	cp $ff ; $568b
	ret nz ; $568d
	push bc ; $568e
	ld a, $37 ; $568f
	ld b, a ; $5691
	call ReadSaveBlock ; $5692
	or a ; $5695
	jr nz, .restore ; $5696
	pop bc ; $5698
	ld hl, wDecompBuffer ; $5699
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $569c
	call WriteSaveBlock ; $569f
	ret ; $56a2
.restore:
	pop bc ; $56a3
	call InvalidateSaveBlock ; $56a4
	ret ; $56a7
ApplyN64RecordsUnlockFlags:
	push af ; $56a8
	push bc ; $56a9
	push de ; $56aa
	push hl ; $56ab
	ldh a, [hWramBank] ; $56ac
	push af ; $56ae
	wram_bank $07 ; $56af
	ld hl, wSaveBlockBuffer ; $56b5
	ld b, $0b ; $56b8
	call ReadSaveBlock ; $56ba
	or a ; $56bd
	jr nz, .restore ; $56be
	ld hl, wSaveBlockBuffer ; $56c0
	ld a, [hl] ; $56c3
	inc hl ; $56c4
	add [hl] ; $56c5
	or a ; $56c6
	jr z, .restore ; $56c7
	push de ; $56c9
	ld de, SAVEFLAG_N64_RECORDS_PRESENT ; $56ca
	farcall SetSaveFlag ; $56cd
	pop de ; $56d0
	push de ; $56d1
	ld de, SAVEFLAG_UNLOCKED_FAY ; $56d2
	farcall SetSaveFlag ; $56d5
	pop de ; $56d8
	push de ; $56d9
	ld de, SAVEFLAG_UNLOCKED_CURT ; $56da
	farcall SetSaveFlag ; $56dd
	pop de ; $56e0
	push de ; $56e1
	ld de, SAVEFLAG_UNLOCKED_MARK ; $56e2
	farcall SetSaveFlag ; $56e5
	pop de ; $56e8
	push de ; $56e9
	ld de, SAVEFLAG_UNLOCKED_SEAN ; $56ea
	farcall SetSaveFlag ; $56ed
	pop de ; $56f0
.restore:
	pop af ; $56f1
	wram_bank ; $56f2
	pop hl ; $56f6
	pop de ; $56f7
	pop bc ; $56f8
	pop af ; $56f9
	ret ; $56fa
UpdateUnlockablesSaveBlock:
	push af ; $56fb
	push bc ; $56fc
	push de ; $56fd
	push hl ; $56fe
	ldh a, [hWramBank] ; $56ff
	push af ; $5701
	wram_bank $07 ; $5702
	ld hl, wSaveBlockBuffer ; $5708
	ld b, $0b ; $570b
	call ReadSaveBlock ; $570d
	or a ; $5710
	jp nz, .restore ; $5711
	ld hl, wSaveBlockBuffer ; $5714
	ld a, [hl] ; $5717
	inc hl ; $5718
	add [hl] ; $5719
	or a ; $571a
	jp z, .restore ; $571b
	ld a, $02 ; $571e
	call CheckUnlockCondition ; $5720
	or a ; $5723
	jr z, .zero ; $5724
	ld hl, wSaveBlockBuffer + 2 ; $5726
	ld a, $01 ; $5729
	ld [hl], a ; $572b
.zero:
	ld a, $04 ; $572c
	call CheckUnlockCondition ; $572e
	or a ; $5731
	jr z, .zero2 ; $5732
	ld hl, wSaveBlockBuffer + 7 ; $5734
	ld a, $01 ; $5737
	ld [hl], a ; $5739
.zero2:
	ld a, $06 ; $573a
	call CheckUnlockCondition ; $573c
	or a ; $573f
	jr z, .zero3 ; $5740
	ld hl, wSaveBlockBuffer + 4 ; $5742
	ld a, $01 ; $5745
	ld [hl], a ; $5747
.zero3:
	ld a, $08 ; $5748
	call CheckUnlockCondition ; $574a
	or a ; $574d
	jr z, .zero4 ; $574e
	ld hl, wSaveBlockBuffer + 6 ; $5750
	ld a, $01 ; $5753
	ld [hl], a ; $5755
.zero4:
	ld a, $09 ; $5756
	call CheckUnlockCondition ; $5758
	or a ; $575b
	jr z, .zero5 ; $575c
	ld hl, wSaveBlockBuffer + 3 ; $575e
	ld a, $01 ; $5761
	ld [hl], a ; $5763
.zero5:
	ld a, $0a ; $5764
	call CheckUnlockCondition ; $5766
	or a ; $5769
	jr z, .zero6 ; $576a
	ld hl, wSaveBlockBuffer + 5 ; $576c
	ld a, $01 ; $576f
	ld [hl], a ; $5771
.zero6:
	ld hl, wSaveBlockBuffer ; $5772
	ld b, $0b ; $5775
	ld de, $0000 ; $5777
	call WriteSaveBlock ; $577a
.restore:
	pop af ; $577d
	wram_bank ; $577e
	pop hl ; $5782
	pop de ; $5783
	pop bc ; $5784
	pop af ; $5785
	ret ; $5786
SetAllUnlockablesInSaveBlock:
	push af ; $5787
	push bc ; $5788
	push de ; $5789
	push hl ; $578a
	ldh a, [hWramBank] ; $578b
	push af ; $578d
	wram_bank $07 ; $578e
	ld hl, wSaveBlockBuffer ; $5794
	ld b, $0b ; $5797
	call ReadSaveBlock ; $5799
	or a ; $579c
	jp nz, .restore ; $579d
	ld hl, wSaveBlockBuffer + 2 ; $57a0
	ld a, $01 ; $57a3
	ld [hl], a ; $57a5
	ld hl, wSaveBlockBuffer + 7 ; $57a6
	ld a, $01 ; $57a9
	ld [hl], a ; $57ab
	ld hl, wSaveBlockBuffer + 4 ; $57ac
	ld a, $01 ; $57af
	ld [hl], a ; $57b1
	ld hl, wSaveBlockBuffer + 6 ; $57b2
	ld a, $01 ; $57b5
	ld [hl], a ; $57b7
	ld hl, wSaveBlockBuffer + 3 ; $57b8
	ld a, $01 ; $57bb
	ld [hl], a ; $57bd
	ld hl, wSaveBlockBuffer + 5 ; $57be
	ld a, $01 ; $57c1
	ld [hl], a ; $57c3
	ld hl, wSaveBlockBuffer ; $57c4
	ld b, $0b ; $57c7
	ld de, $0000 ; $57c9
	call WriteSaveBlock ; $57cc
.restore:
	pop af ; $57cf
	wram_bank ; $57d0
	pop hl ; $57d4
	pop de ; $57d5
	pop bc ; $57d6
	pop af ; $57d7
	ret ; $57d8
UnlockConditionFlagRows_03:
	; $57d9, 9 bytes (bytes:1)
	db $16 ; 0x00
	db $19 ; 0x01
	db $1c ; 0x02
	db $1f ; 0x03
	db $2a ; 0x04
	db $2d ; 0x05
	db $30 ; 0x06
	db $33 ; 0x07
	db $36 ; 0x08
CheckUnlockCondition:
	push bc ; $57e2
	push de ; $57e3
	push hl ; $57e4
	ld b, a ; $57e5
	ldh a, [hWramBank] ; $57e6
	push af ; $57e8
	wram_bank $07 ; $57e9
	cp $02 ; $57ef
	jr nc, .saveFlagCondition ; $57f1
	or a ; $57f3
	jr nz, .machineWall ; $57f4
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $57f6
	jr z, .locked ; $57f9
	jr .checkRecord ; $57fb
.machineWall:
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $57fd
	jr z, .locked ; $5800
	jr .checkRecord ; $5802
.saveFlagCondition:
	ld a, b ; $5804
	sub $02 ; $5805
	ld hl, UnlockConditionFlagRows_03 ; $5807
	ld d, $00 ; $580a
	ld e, a ; $580c
	add hl, de ; $580d
	ld a, [hl] ; $580e
	ld l, a ; $580f
	ld h, $00 ; $5810
	ld a, $20 ; $5812
	call MulHLByA ; $5814
	push hl ; $5817
	pop de ; $5818
	call TestSaveFlag ; $5819
	jr z, .locked ; $581c
.checkRecord:
	ld a, b ; $581e
	farcall GetDefaultMinigameRecordValue ; $581f
	ld a, b ; $5822
	call ReadMinigameRecord ; $5823
	ld hl, wMinigameRecordValue ; $5826
	ld a, [hl+] ; $5829
	ld h, [hl] ; $582a
	ld l, a ; $582b
	ld a, l ; $582c
	sub e ; $582d
	ld l, a ; $582e
	ld a, h ; $582f
	sbc d ; $5830
	ld h, a ; $5831
	jr c, .locked ; $5832
	ld b, $01 ; $5834
	jr .done ; $5836
.locked:
	xor a ; $5838
	ld b, a ; $5839
.done:
	pop af ; $583a
	wram_bank ; $583b
	ld a, b ; $583f
	pop hl ; $5840
	pop de ; $5841
	pop bc ; $5842
	ret ; $5843
WriteBlock6WithBackup:
	push bc ; $5844
	push de ; $5845
	push hl ; $5846
	ld de, $0000 ; $5847
	ld b, $06 ; $584a
	call WriteSaveBlock ; $584c
	or a ; $584f
	jr nz, .step ; $5850
	call VerifySaveBlock ; $5852
	or a ; $5855
	jr nz, .step ; $5856
	ld b, $21 ; $5858
	call WriteSaveBlock ; $585a
	or a ; $585d
	jr nz, .step ; $585e
	call VerifySaveBlock ; $5860
	or a ; $5863
	jr nz, .step ; $5864
	xor a ; $5866
	jr .restore ; $5867
.step:
	ld a, $ff ; $5869
.restore:
	pop hl ; $586b
	pop de ; $586c
	pop bc ; $586d
	ret ; $586e
ReadBlock6:
	push bc ; $586f
	push de ; $5870
	push hl ; $5871
	ld b, $06 ; $5872
	call ReadSaveBlock ; $5874
	pop hl ; $5877
	pop de ; $5878
	pop bc ; $5879
	ret ; $587a
WriteBlock7WithBackup:
	push bc ; $587b
	push de ; $587c
	push hl ; $587d
	ld de, $0000 ; $587e
	ld b, $07 ; $5881
	call WriteSaveBlock ; $5883
	or a ; $5886
	jr nz, .step ; $5887
	call VerifySaveBlock ; $5889
	or a ; $588c
	jr nz, .step ; $588d
	ld b, $22 ; $588f
	call WriteSaveBlock ; $5891
	or a ; $5894
	jr nz, .step ; $5895
	call VerifySaveBlock ; $5897
	or a ; $589a
	jr nz, .step ; $589b
	xor a ; $589d
	jr .restore ; $589e
.step:
	ld a, $ff ; $58a0
.restore:
	pop hl ; $58a2
	pop de ; $58a3
	pop bc ; $58a4
	ret ; $58a5
ReadBlock7:
	push bc ; $58a6
	push de ; $58a7
	push hl ; $58a8
	ld b, $07 ; $58a9
	call ReadSaveBlock ; $58ab
	pop hl ; $58ae
	pop de ; $58af
	pop bc ; $58b0
	ret ; $58b1
WriteBlock8WithBackup:
	push bc ; $58b2
	push de ; $58b3
	push hl ; $58b4
	ld de, $0000 ; $58b5
	ld b, $08 ; $58b8
	call WriteSaveBlock ; $58ba
	or a ; $58bd
	jr nz, .step ; $58be
	call VerifySaveBlock ; $58c0
	or a ; $58c3
	jr nz, .step ; $58c4
	ld b, $23 ; $58c6
	call WriteSaveBlock ; $58c8
	or a ; $58cb
	jr nz, .step ; $58cc
	call VerifySaveBlock ; $58ce
	or a ; $58d1
	jr nz, .step ; $58d2
	xor a ; $58d4
	jr .restore ; $58d5
.step:
	ld a, $ff ; $58d7
.restore:
	pop hl ; $58d9
	pop de ; $58da
	pop bc ; $58db
	ret ; $58dc
ReadBlock8:
	push bc ; $58dd
	push de ; $58de
	push hl ; $58df
	ld b, $08 ; $58e0
	call ReadSaveBlock ; $58e2
	pop hl ; $58e5
	pop de ; $58e6
	pop bc ; $58e7
	ret ; $58e8
WriteBlock9WithBackup:
	push bc ; $58e9
	push de ; $58ea
	push hl ; $58eb
	ld de, $0000 ; $58ec
	ld b, $09 ; $58ef
	call WriteSaveBlock ; $58f1
	or a ; $58f4
	jr nz, .step ; $58f5
	call VerifySaveBlock ; $58f7
	or a ; $58fa
	jr nz, .step ; $58fb
	ld b, $24 ; $58fd
	call WriteSaveBlock ; $58ff
	or a ; $5902
	jr nz, .step ; $5903
	call VerifySaveBlock ; $5905
	or a ; $5908
	jr nz, .step ; $5909
	xor a ; $590b
	jr .restore ; $590c
.step:
	ld a, $ff ; $590e
.restore:
	pop hl ; $5910
	pop de ; $5911
	pop bc ; $5912
	ret ; $5913
ReadBlock9:
	push bc ; $5914
	push de ; $5915
	push hl ; $5916
	ld b, $09 ; $5917
	call ReadSaveBlock ; $5919
	pop hl ; $591c
	pop de ; $591d
	pop bc ; $591e
	ret ; $591f
WriteBlock10WithBackup:
	push bc ; $5920
	push de ; $5921
	push hl ; $5922
	ld de, $0000 ; $5923
	ld b, $0a ; $5926
	call WriteSaveBlock ; $5928
	or a ; $592b
	jr nz, .step ; $592c
	call VerifySaveBlock ; $592e
	or a ; $5931
	jr nz, .step ; $5932
	ld b, $25 ; $5934
	call WriteSaveBlock ; $5936
	or a ; $5939
	jr nz, .step ; $593a
	call VerifySaveBlock ; $593c
	or a ; $593f
	jr nz, .step ; $5940
	xor a ; $5942
	jr .restore ; $5943
.step:
	ld a, $ff ; $5945
.restore:
	pop hl ; $5947
	pop de ; $5948
	pop bc ; $5949
	ret ; $594a
ReadBlock10:
	push bc ; $594b
	push de ; $594c
	push hl ; $594d
	ld b, $0a ; $594e
	call ReadSaveBlock ; $5950
	pop hl ; $5953
	pop de ; $5954
	pop bc ; $5955
	ret ; $5956
TestCartIdString_03:
	; $5957, 30 bytes (ascii)
	db "TESTCARTIDTESTCARTIDTESTCARTID"
DebugTestMinigameRecords:
	push af ; $5975
	push bc ; $5976
	push de ; $5977
	push hl ; $5978
	wram_bank $07 ; $5979
	ld hl, wMinigameRecordValue ; $597f
	ld de, $270f ; $5982
	ld a, e ; $5985
	ld [hl+], a ; $5986
	ld [hl], d ; $5987
	xor a ; $5988
	call UpdateMinigameRecord ; $5989
	ld hl, wMinigameRecordValue ; $598c
	ld de, $03e7 ; $598f
	ld a, e ; $5992
	ld [hl+], a ; $5993
	ld [hl], d ; $5994
	ld a, $01 ; $5995
	call UpdateMinigameRecord ; $5997
	ld hl, wMinigameRecordValue ; $599a
	ld de, $0000 ; $599d
	ld a, e ; $59a0
	ld [hl+], a ; $59a1
	ld [hl], d ; $59a2
	xor a ; $59a3
	call ReadMinigameRecord ; $59a4
	ld a, $01 ; $59a7
	call ReadMinigameRecord ; $59a9
	pop hl ; $59ac
	pop de ; $59ad
	pop bc ; $59ae
	pop af ; $59af
	ret ; $59b0
FillMemory16:
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
	jr nz, FillMemory16 ; $59c2
	ret ; $59c4
RunScrollingTextScreen:
	call ClearFrameTasks ; $59c5
	farcall LoadMenuFontGfx ; $59c8
	call DisableLCDSafely ; $59cb
	xor a ; $59ce
	ldh [hScrollX], a ; $59cf
	ldh [hScrollY], a ; $59d1
	ld [wCameraX], a ; $59d3
	ld [wCameraX + 1], a ; $59d6
	ld [wCameraY], a ; $59d9
	ld [wCameraY + 1], a ; $59dc
	ld a, $90 ; $59df
	ldh [rWY], a ; $59e1
	call ClearSpriteQueue ; $59e3
	ld hl, ScrollTextPalette_03 ; $59e6
	ld de, $0001 ; $59e9
	call LoadPaletteShadow ; $59ec
	call InitScrollingTextScreen ; $59ef
	call EnableLCD ; $59f2
	sound BGM_CREDITS ; $59f5
	ld c, $08 ; $59f7
	call ForceFadeIn ; $59f9
	call WaitFadeEnd ; $59fc
.loop:
	wram_bank $06 ; $59ff
	ld a, [wScrollTextDelay] ; $5a05
	dec a ; $5a08
	ld [wScrollTextDelay], a ; $5a09
	jr nz, .checkDebugStepMode ; $5a0c
	ld a, $02 ; $5a0e
	ld [wScrollTextDelay], a ; $5a10
	ld a, [wScrollTextDone] ; $5a13
	and a ; $5a16
	jr nz, .checkDebugStepMode ; $5a17
	ldh a, [hScrollY] ; $5a19
	inc a ; $5a1b
	ldh [hScrollY], a ; $5a1c
	and $07 ; $5a1e
	jr nz, .checkDebugStepMode ; $5a20
	ld hl, wScrollTextId ; $5a22
	ld a, [hl+] ; $5a25
	ld h, [hl] ; $5a26
	ld l, a ; $5a27
	wram_bank $03 ; $5a28
	ld de, wShadowTilemap ; $5a2e
	ld c, $10 ; $5a31
	farcall FetchAndDrawDialogueText ; $5a33
	call TestTextEndMarker ; $5a36
	and a ; $5a39
	jr nz, .nonZero ; $5a3a
	wram_bank $06 ; $5a3c
	ld a, $01 ; $5a42
	ld [wScrollTextDone], a ; $5a44
	jr .checkDebugStepMode ; $5a47
.nonZero:
	ld de, $0090 ; $5a49
	call GetScrollTextRowVramAddr ; $5a4c
	push de ; $5a4f
	wram_bank $03 ; $5a50
	ld hl, wShadowTilemap ; $5a56
	ld c, $02 ; $5a59
	call QueueVRAMCopy ; $5a5b
	pop de ; $5a5e
	wram_bank $06 ; $5a5f
	ld hl, wScrollTextId ; $5a65
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
.checkDebugStepMode:
	ldh a, [hDebugStepMode] ; $5a73
	or a ; $5a75
	jr nz, .nonZero2 ; $5a76
	ld a, [wScrollTextDone] ; $5a78
	and a ; $5a7b
	jr z, .advanceFrame ; $5a7c
.nonZero2:
	ldh a, [hPlayerInputFlags] ; $5a7e
	and $0b ; $5a80
	jr nz, .maskSet ; $5a82
.advanceFrame:
	call AdvanceFrame ; $5a84
	wram_bank $03 ; $5a87
	xor a ; $5a8d
	ld b, $40 ; $5a8e
	ld hl, wShadowTilemap ; $5a90
.loopB:
	ld [hl+], a ; $5a93
	inc b ; $5a94
	jr nz, .loopB ; $5a95
	jp .loop ; $5a97
.maskSet:
	ld c, $01 ; $5a9a
	call BeginFadeOut ; $5a9c
	call WaitFadeEnd ; $5a9f
	call ClearFrameTasks ; $5aa2
	farcall LoadMenuFontGfx ; $5aa5
	ret ; $5aa8
InitScrollingTextScreen:
	wram_bank $06 ; $5aa9
	ld hl, wScrollTextDelay ; $5aaf
	ld a, $02 ; $5ab2
	ld [hl+], a ; $5ab4
	ld [hl+], a ; $5ab5
	ld de, $1863 ; $5ab6
	ld a, e ; $5ab9
	ld [hl+], a ; $5aba
	ld [hl], d ; $5abb
	xor a ; $5abc
	ld [wScrollTextDone], a ; $5abd
	wram_bank $02 ; $5ac0
	ld bc, $0400 ; $5ac6
	ld d, $00 ; $5ac9
	ld hl, wScreenAttrmap ; $5acb
	call FillMemoryBC ; $5ace
	ld hl, wScreenAttrmap ; $5ad1
	ld de, $b800 ; $5ad4
	ld c, $40 ; $5ad7
	call QueueVRAMCopy ; $5ad9
	wram_bank $03 ; $5adc
	ld bc, $0400 ; $5ae2
	ld d, $20 ; $5ae5
	ld hl, wShadowTilemap ; $5ae7
	call FillMemoryBC ; $5aea
	ld hl, wShadowTilemap ; $5aed
	ld de, $9800 ; $5af0
	ld c, $40 ; $5af3
	call QueueVRAMCopy ; $5af5
	ret ; $5af8
FillMemoryBC:
	ld [hl], d ; $5af9
	inc hl ; $5afa
	dec bc ; $5afb
	ld a, b ; $5afc
	or c ; $5afd
	jr nz, FillMemoryBC ; $5afe
	ret ; $5b00
GetScrollTextRowVramAddr:
	ldh a, [hScrollY] ; $5b01
	ld h, $00 ; $5b03
	ld l, a ; $5b05
	add hl, de ; $5b06
	sla l ; $5b07
	rl h ; $5b09
	sla l ; $5b0b
	rl h ; $5b0d
	ld a, h ; $5b0f
	and $03 ; $5b10
	ld h, a ; $5b12
	ld de, $9800 ; $5b13
	add hl, de ; $5b16
	ld d, h ; $5b17
	ld e, l ; $5b18
	ret ; $5b19
TestTextEndMarker:
	ld a, [wShadowTilemap] ; $5b1a
	sub $23 ; $5b1d
	ret ; $5b1f
ScrollTextPalette_03:
	INCLUDE "data/bank_003/palettes_5b20.asm" ; $5b20, 8 bytes (palettes)
SetupSceneAnimationPalettes:
	ldh a, [hWramBank] ; $5b28
	push af ; $5b2a
	wram_bank $06 ; $5b2b
	xor a ; $5b31
	ld [$d000], a ; $5b32
	ld hl, SceneAnimObjPalette0_03 ; $5b35
	ld de, $0a01 ; $5b38
	call LoadPaletteShadow ; $5b3b
	ld hl, SceneAnimObjPalette1_03 ; $5b3e
	ld de, $0b01 ; $5b41
	call LoadPaletteShadow ; $5b44
	pop af ; $5b47
	wram_bank ; $5b48
	ret ; $5b4c
UpdateSceneAnimation:
	ldh a, [hWramBank] ; $5b4d
	push af ; $5b4f
	wram_bank $06 ; $5b50
	call LoadCutsceneAnimFrameGfx_00_08 ; $5b56
	call LoadCutsceneAnimFrameGfx_09_11 ; $5b59
	call LoadCutsceneAnimFrameGfx_12_1A ; $5b5c
	call LoadCutsceneAnimFrameGfx_1B_23 ; $5b5f
	call LoadCutsceneAnimFrameGfx_24_2C ; $5b62
	call LoadCutsceneAnimFrameGfx_2D_35 ; $5b65
	wram_bank $06 ; $5b68
	ld a, [wCutsceneSlideTimer] ; $5b6e
	and $03 ; $5b71
	jr nz, .restore ; $5b73
	ld a, [$d000] ; $5b75
	ld b, a ; $5b78
	sub $36 ; $5b79
	jp nc, .restore ; $5b7b
	ld a, b ; $5b7e
	inc a ; $5b7f
	ld [$d000], a ; $5b80
.restore:
	pop af ; $5b83
	wram_bank ; $5b84
	ret ; $5b88
LoadCutsceneAnimFrameGfx_00_08:
	wram_bank $06 ; $5b89
	ld a, [$d000] ; $5b8f
	cp $00 ; $5b92
	jp z, .eq00 ; $5b94
	cp $01 ; $5b97
	jp z, .eq01 ; $5b99
	cp $02 ; $5b9c
	jp z, .eq02 ; $5b9e
	cp $03 ; $5ba1
	jp z, .eq03 ; $5ba3
	cp $04 ; $5ba6
	jp z, .eq04 ; $5ba8
	cp $05 ; $5bab
	jp z, .eq05 ; $5bad
	cp $06 ; $5bb0
	jp z, .eq06 ; $5bb2
	cp $07 ; $5bb5
	jp z, .eq07 ; $5bb7
	cp $08 ; $5bba
	jp z, .eq08 ; $5bbc
	jp .queueSpriteTemplate ; $5bbf
.eq00:
	wram_bank $01 ; $5bc2
	ld hl, CutsceneAnimFrameLZ_00 ; $5bc8
	ld de, wDecompBuffer ; $5bcb
	call DecompressData ; $5bce
	ld hl, wDecompBuffer ; $5bd1
	ld de, $8000 ; $5bd4
	ld c, $04 ; $5bd7
	call QueueVRAMCopy ; $5bd9
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate0 ; $5bdc
	ld d, $fe ; $5bdf
	ld e, $80 ; $5be1
	ld bc, $0300 ; $5be3
	call QueueSpriteTemplate ; $5be6
	ret ; $5be9
.eq01:
	wram_bank $01 ; $5bea
	ld hl, CutsceneAnimFrameLZ_01 ; $5bf0
	ld de, wDecompBuffer ; $5bf3
	call DecompressData ; $5bf6
	ld hl, wDecompBuffer ; $5bf9
	ld de, $8000 ; $5bfc
	ld c, $04 ; $5bff
	call QueueVRAMCopy ; $5c01
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate1 ; $5c04
	ld d, $fe ; $5c07
	ld e, $80 ; $5c09
	ld bc, $0300 ; $5c0b
	call QueueSpriteTemplate ; $5c0e
	ret ; $5c11
.eq02:
	wram_bank $01 ; $5c12
	ld hl, CutsceneAnimFrameLZ_02 ; $5c18
	ld de, wDecompBuffer ; $5c1b
	call DecompressData ; $5c1e
	ld hl, wDecompBuffer ; $5c21
	ld de, $8000 ; $5c24
	ld c, $04 ; $5c27
	call QueueVRAMCopy ; $5c29
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate2 ; $5c2c
	ld d, $fe ; $5c2f
	ld e, $80 ; $5c31
	ld bc, $0300 ; $5c33
	call QueueSpriteTemplate ; $5c36
	ret ; $5c39
.eq03:
	wram_bank $01 ; $5c3a
	ld hl, CutsceneAnimFrameLZ_03 ; $5c40
	ld de, wDecompBuffer ; $5c43
	call DecompressData ; $5c46
	ld hl, wDecompBuffer ; $5c49
	ld de, $8000 ; $5c4c
	ld c, $04 ; $5c4f
	call QueueVRAMCopy ; $5c51
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate3 ; $5c54
	ld d, $fe ; $5c57
	ld e, $80 ; $5c59
	ld bc, $0300 ; $5c5b
	call QueueSpriteTemplate ; $5c5e
	ret ; $5c61
.eq04:
	wram_bank $01 ; $5c62
	ld hl, CutsceneAnimFrameLZ_04 ; $5c68
	ld de, wDecompBuffer ; $5c6b
	call DecompressData ; $5c6e
	ld hl, wDecompBuffer ; $5c71
	ld de, $8000 ; $5c74
	ld c, $04 ; $5c77
	call QueueVRAMCopy ; $5c79
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate4 ; $5c7c
	ld d, $fe ; $5c7f
	ld e, $80 ; $5c81
	ld bc, $0300 ; $5c83
	call QueueSpriteTemplate ; $5c86
	ret ; $5c89
.eq05:
	wram_bank $01 ; $5c8a
	ld hl, CutsceneAnimFrameLZ_05 ; $5c90
	ld de, wDecompBuffer ; $5c93
	call DecompressData ; $5c96
	ld hl, wDecompBuffer ; $5c99
	ld de, $8000 ; $5c9c
	ld c, $04 ; $5c9f
	call QueueVRAMCopy ; $5ca1
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate5 ; $5ca4
	ld d, $fe ; $5ca7
	ld e, $80 ; $5ca9
	ld bc, $0300 ; $5cab
	call QueueSpriteTemplate ; $5cae
	ret ; $5cb1
.eq06:
	wram_bank $01 ; $5cb2
	ld hl, CutsceneAnimFrameLZ_06 ; $5cb8
	ld de, wDecompBuffer ; $5cbb
	call DecompressData ; $5cbe
	ld hl, wDecompBuffer ; $5cc1
	ld de, $8000 ; $5cc4
	ld c, $04 ; $5cc7
	call QueueVRAMCopy ; $5cc9
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate6 ; $5ccc
	ld d, $fe ; $5ccf
	ld e, $80 ; $5cd1
	ld bc, $0300 ; $5cd3
	call QueueSpriteTemplate ; $5cd6
	ret ; $5cd9
.eq07:
	wram_bank $01 ; $5cda
	ld hl, CutsceneAnimFrameLZ_07 ; $5ce0
	ld de, wDecompBuffer ; $5ce3
	call DecompressData ; $5ce6
	ld hl, wDecompBuffer ; $5ce9
	ld de, $8000 ; $5cec
	ld c, $04 ; $5cef
	call QueueVRAMCopy ; $5cf1
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate7 ; $5cf4
	ld d, $fe ; $5cf7
	ld e, $80 ; $5cf9
	ld bc, $0300 ; $5cfb
	call QueueSpriteTemplate ; $5cfe
	ret ; $5d01
.eq08:
	wram_bank $01 ; $5d02
	ld hl, CutsceneAnimFrameLZ_08 ; $5d08
	ld de, wDecompBuffer ; $5d0b
	call DecompressData ; $5d0e
	ld hl, wDecompBuffer ; $5d11
	ld de, $8000 ; $5d14
	ld c, $04 ; $5d17
	call QueueVRAMCopy ; $5d19
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8 ; $5d1c
	ld d, $fe ; $5d1f
	ld e, $80 ; $5d21
	ld bc, $0300 ; $5d23
	call QueueSpriteTemplate ; $5d26
	ret ; $5d29
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8 ; $5d2a
	ld d, $fe ; $5d2d
	ld e, $80 ; $5d2f
	ld bc, $0300 ; $5d31
	call QueueSpriteTemplate ; $5d34
	ret ; $5d37
LoadCutsceneAnimFrameGfx_09_11:
	wram_bank $06 ; $5d38
	ld a, [$d000] ; $5d3e
	ld b, a ; $5d41
	sub $09 ; $5d42
	ret c ; $5d44
	ld a, b ; $5d45
	cp $09 ; $5d46
	jp z, .eq09 ; $5d48
	cp $0a ; $5d4b
	jp z, .eq0a ; $5d4d
	cp $0b ; $5d50
	jp z, .eq0b ; $5d52
	cp $0c ; $5d55
	jp z, .eq0c ; $5d57
	cp $0d ; $5d5a
	jp z, .eq0d ; $5d5c
	cp $0e ; $5d5f
	jp z, .eq0e ; $5d61
	cp $0f ; $5d64
	jp z, .eq0f ; $5d66
	cp $10 ; $5d69
	jp z, .eq10 ; $5d6b
	cp $11 ; $5d6e
	jp z, .eq11 ; $5d70
	jp .queueSpriteTemplate ; $5d73
.eq09:
	wram_bank $01 ; $5d76
	ld hl, CutsceneAnimFrameLZ_09 ; $5d7c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5d7f
	call DecompressData ; $5d82
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5d85
	ld de, $8040 ; $5d88
	ld c, $04 ; $5d8b
	call QueueVRAMCopy ; $5d8d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate0 ; $5d90
	ld d, $0e ; $5d93
	ld e, $80 ; $5d95
	ld bc, $0204 ; $5d97
	call QueueSpriteTemplate ; $5d9a
	ret ; $5d9d
.eq0a:
	wram_bank $01 ; $5d9e
	ld hl, CutsceneAnimFrameLZ_0a ; $5da4
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5da7
	call DecompressData ; $5daa
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dad
	ld de, $8040 ; $5db0
	ld c, $04 ; $5db3
	call QueueVRAMCopy ; $5db5
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate1 ; $5db8
	ld d, $0e ; $5dbb
	ld e, $80 ; $5dbd
	ld bc, $0204 ; $5dbf
	call QueueSpriteTemplate ; $5dc2
	ret ; $5dc5
.eq0b:
	wram_bank $01 ; $5dc6
	ld hl, CutsceneAnimFrameLZ_0b ; $5dcc
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5dcf
	call DecompressData ; $5dd2
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dd5
	ld de, $8040 ; $5dd8
	ld c, $04 ; $5ddb
	call QueueVRAMCopy ; $5ddd
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate2 ; $5de0
	ld d, $0e ; $5de3
	ld e, $80 ; $5de5
	ld bc, $0204 ; $5de7
	call QueueSpriteTemplate ; $5dea
	ret ; $5ded
.eq0c:
	wram_bank $01 ; $5dee
	ld hl, CutsceneAnimFrameLZ_0c ; $5df4
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5df7
	call DecompressData ; $5dfa
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5dfd
	ld de, $8040 ; $5e00
	ld c, $04 ; $5e03
	call QueueVRAMCopy ; $5e05
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate3 ; $5e08
	ld d, $0e ; $5e0b
	ld e, $80 ; $5e0d
	ld bc, $0204 ; $5e0f
	call QueueSpriteTemplate ; $5e12
	ret ; $5e15
.eq0d:
	wram_bank $01 ; $5e16
	ld hl, CutsceneAnimFrameLZ_0d ; $5e1c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e1f
	call DecompressData ; $5e22
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e25
	ld de, $8040 ; $5e28
	ld c, $04 ; $5e2b
	call QueueVRAMCopy ; $5e2d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate4 ; $5e30
	ld d, $0e ; $5e33
	ld e, $80 ; $5e35
	ld bc, $0204 ; $5e37
	call QueueSpriteTemplate ; $5e3a
	ret ; $5e3d
.eq0e:
	wram_bank $01 ; $5e3e
	ld hl, CutsceneAnimFrameLZ_0e ; $5e44
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e47
	call DecompressData ; $5e4a
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e4d
	ld de, $8040 ; $5e50
	ld c, $04 ; $5e53
	call QueueVRAMCopy ; $5e55
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate5 ; $5e58
	ld d, $0e ; $5e5b
	ld e, $80 ; $5e5d
	ld bc, $0204 ; $5e5f
	call QueueSpriteTemplate ; $5e62
	ret ; $5e65
.eq0f:
	wram_bank $01 ; $5e66
	ld hl, CutsceneAnimFrameLZ_0f ; $5e6c
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e6f
	call DecompressData ; $5e72
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e75
	ld de, $8040 ; $5e78
	ld c, $04 ; $5e7b
	call QueueVRAMCopy ; $5e7d
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate6 ; $5e80
	ld d, $0e ; $5e83
	ld e, $80 ; $5e85
	ld bc, $0204 ; $5e87
	call QueueSpriteTemplate ; $5e8a
	ret ; $5e8d
.eq10:
	wram_bank $01 ; $5e8e
	ld hl, CutsceneAnimFrameLZ_10 ; $5e94
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5e97
	call DecompressData ; $5e9a
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5e9d
	ld de, $8040 ; $5ea0
	ld c, $04 ; $5ea3
	call QueueVRAMCopy ; $5ea5
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate7 ; $5ea8
	ld d, $0e ; $5eab
	ld e, $80 ; $5ead
	ld bc, $0204 ; $5eaf
	call QueueSpriteTemplate ; $5eb2
	ret ; $5eb5
.eq11:
	wram_bank $01 ; $5eb6
	ld hl, CutsceneAnimFrameLZ_11 ; $5ebc
	ld de, wDecompBuffer + 4 * TILE_SIZE ; $5ebf
	call DecompressData ; $5ec2
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $5ec5
	ld de, $8040 ; $5ec8
	ld c, $04 ; $5ecb
	call QueueVRAMCopy ; $5ecd
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8 ; $5ed0
	ld d, $0e ; $5ed3
	ld e, $80 ; $5ed5
	ld bc, $0204 ; $5ed7
	call QueueSpriteTemplate ; $5eda
	ret ; $5edd
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8 ; $5ede
	ld d, $0e ; $5ee1
	ld e, $80 ; $5ee3
	ld bc, $0204 ; $5ee5
	call QueueSpriteTemplate ; $5ee8
	ret ; $5eeb
LoadCutsceneAnimFrameGfx_12_1A:
	wram_bank $06 ; $5eec
	ld a, [$d000] ; $5ef2
	ld b, a ; $5ef5
	sub $12 ; $5ef6
	ret c ; $5ef8
	ld a, b ; $5ef9
	cp $12 ; $5efa
	jp z, .eq12 ; $5efc
	cp $13 ; $5eff
	jp z, .eq13 ; $5f01
	cp $14 ; $5f04
	jp z, .eq14 ; $5f06
	cp $15 ; $5f09
	jp z, .eq15 ; $5f0b
	cp $16 ; $5f0e
	jp z, .eq16 ; $5f10
	cp $17 ; $5f13
	jp z, .eq17 ; $5f15
	cp $18 ; $5f18
	jp z, .eq18 ; $5f1a
	cp $19 ; $5f1d
	jp z, .eq19 ; $5f1f
	cp $1a ; $5f22
	jp z, .eq1a ; $5f24
	jp .queueSpriteTemplate ; $5f27
.eq12:
	wram_bank $01 ; $5f2a
	ld hl, CutsceneAnimFrameLZ_12 ; $5f30
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f33
	call DecompressData ; $5f36
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f39
	ld de, $8080 ; $5f3c
	ld c, $04 ; $5f3f
	call QueueVRAMCopy ; $5f41
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate0 ; $5f44
	ld d, $1e ; $5f47
	ld e, $80 ; $5f49
	ld bc, $0308 ; $5f4b
	call QueueSpriteTemplate ; $5f4e
	ret ; $5f51
.eq13:
	wram_bank $01 ; $5f52
	ld hl, CutsceneAnimFrameLZ_13 ; $5f58
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f5b
	call DecompressData ; $5f5e
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f61
	ld de, $8080 ; $5f64
	ld c, $04 ; $5f67
	call QueueVRAMCopy ; $5f69
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate1 ; $5f6c
	ld d, $1e ; $5f6f
	ld e, $80 ; $5f71
	ld bc, $0308 ; $5f73
	call QueueSpriteTemplate ; $5f76
	ret ; $5f79
.eq14:
	wram_bank $01 ; $5f7a
	ld hl, CutsceneAnimFrameLZ_14 ; $5f80
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5f83
	call DecompressData ; $5f86
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5f89
	ld de, $8080 ; $5f8c
	ld c, $04 ; $5f8f
	call QueueVRAMCopy ; $5f91
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate2 ; $5f94
	ld d, $1e ; $5f97
	ld e, $80 ; $5f99
	ld bc, $0308 ; $5f9b
	call QueueSpriteTemplate ; $5f9e
	ret ; $5fa1
.eq15:
	wram_bank $01 ; $5fa2
	ld hl, CutsceneAnimFrameLZ_15 ; $5fa8
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5fab
	call DecompressData ; $5fae
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5fb1
	ld de, $8080 ; $5fb4
	ld c, $04 ; $5fb7
	call QueueVRAMCopy ; $5fb9
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate3 ; $5fbc
	ld d, $1e ; $5fbf
	ld e, $80 ; $5fc1
	ld bc, $0308 ; $5fc3
	call QueueSpriteTemplate ; $5fc6
	ret ; $5fc9
.eq16:
	wram_bank $01 ; $5fca
	ld hl, CutsceneAnimFrameLZ_16 ; $5fd0
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5fd3
	call DecompressData ; $5fd6
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $5fd9
	ld de, $8080 ; $5fdc
	ld c, $04 ; $5fdf
	call QueueVRAMCopy ; $5fe1
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate4 ; $5fe4
	ld d, $1e ; $5fe7
	ld e, $80 ; $5fe9
	ld bc, $0308 ; $5feb
	call QueueSpriteTemplate ; $5fee
	ret ; $5ff1
.eq17:
	wram_bank $01 ; $5ff2
	ld hl, CutsceneAnimFrameLZ_17 ; $5ff8
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $5ffb
	call DecompressData ; $5ffe
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6001
	ld de, $8080 ; $6004
	ld c, $04 ; $6007
	call QueueVRAMCopy ; $6009
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate5 ; $600c
	ld d, $1e ; $600f
	ld e, $80 ; $6011
	ld bc, $0308 ; $6013
	call QueueSpriteTemplate ; $6016
	ret ; $6019
.eq18:
	wram_bank $01 ; $601a
	ld hl, CutsceneAnimFrameLZ_18 ; $6020
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $6023
	call DecompressData ; $6026
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6029
	ld de, $8080 ; $602c
	ld c, $04 ; $602f
	call QueueVRAMCopy ; $6031
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate6 ; $6034
	ld d, $1e ; $6037
	ld e, $80 ; $6039
	ld bc, $0308 ; $603b
	call QueueSpriteTemplate ; $603e
	ret ; $6041
.eq19:
	wram_bank $01 ; $6042
	ld hl, CutsceneAnimFrameLZ_19 ; $6048
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $604b
	call DecompressData ; $604e
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6051
	ld de, $8080 ; $6054
	ld c, $04 ; $6057
	call QueueVRAMCopy ; $6059
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate7 ; $605c
	ld d, $1e ; $605f
	ld e, $80 ; $6061
	ld bc, $0308 ; $6063
	call QueueSpriteTemplate ; $6066
	ret ; $6069
.eq1a:
	wram_bank $01 ; $606a
	ld hl, CutsceneAnimFrameLZ_1a ; $6070
	ld de, wDecompBuffer + 8 * TILE_SIZE ; $6073
	call DecompressData ; $6076
	ld hl, wDecompBuffer + 8 * TILE_SIZE ; $6079
	ld de, $8080 ; $607c
	ld c, $04 ; $607f
	call QueueVRAMCopy ; $6081
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8 ; $6084
	ld d, $1e ; $6087
	ld e, $80 ; $6089
	ld bc, $0308 ; $608b
	call QueueSpriteTemplate ; $608e
	ret ; $6091
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8 ; $6092
	ld d, $1e ; $6095
	ld e, $80 ; $6097
	ld bc, $0308 ; $6099
	call QueueSpriteTemplate ; $609c
	ret ; $609f
LoadCutsceneAnimFrameGfx_1B_23:
	wram_bank $06 ; $60a0
	ld a, [$d000] ; $60a6
	ld b, a ; $60a9
	sub $1b ; $60aa
	ret c ; $60ac
	ld a, b ; $60ad
	cp $1b ; $60ae
	jp z, .eq1b ; $60b0
	cp $1c ; $60b3
	jp z, .eq1c ; $60b5
	cp $1d ; $60b8
	jp z, .eq1d ; $60ba
	cp $1e ; $60bd
	jp z, .eq1e ; $60bf
	cp $1f ; $60c2
	jp z, .eq1f ; $60c4
	cp $20 ; $60c7
	jp z, .eq20 ; $60c9
	cp $21 ; $60cc
	jp z, .eq21 ; $60ce
	cp $22 ; $60d1
	jp z, .eq22 ; $60d3
	cp $23 ; $60d6
	jp z, .eq23 ; $60d8
	jp .queueSpriteTemplate ; $60db
.eq1b:
	wram_bank $01 ; $60de
	ld hl, CutsceneAnimFrameLZ_1b ; $60e4
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $60e7
	call DecompressData ; $60ea
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $60ed
	ld de, $80c0 ; $60f0
	ld c, $02 ; $60f3
	call QueueVRAMCopy ; $60f5
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate0 ; $60f8
	ld d, $2e ; $60fb
	ld e, $80 ; $60fd
	ld bc, $030c ; $60ff
	call QueueSpriteTemplate ; $6102
	ret ; $6105
.eq1c:
	wram_bank $01 ; $6106
	ld hl, CutsceneAnimFrameLZ_1c ; $610c
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $610f
	call DecompressData ; $6112
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6115
	ld de, $80c0 ; $6118
	ld c, $02 ; $611b
	call QueueVRAMCopy ; $611d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate1 ; $6120
	ld d, $2e ; $6123
	ld e, $80 ; $6125
	ld bc, $030c ; $6127
	call QueueSpriteTemplate ; $612a
	ret ; $612d
.eq1d:
	wram_bank $01 ; $612e
	ld hl, CutsceneAnimFrameLZ_1d ; $6134
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6137
	call DecompressData ; $613a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $613d
	ld de, $80c0 ; $6140
	ld c, $02 ; $6143
	call QueueVRAMCopy ; $6145
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate2 ; $6148
	ld d, $2e ; $614b
	ld e, $80 ; $614d
	ld bc, $030c ; $614f
	call QueueSpriteTemplate ; $6152
	ret ; $6155
.eq1e:
	wram_bank $01 ; $6156
	ld hl, CutsceneAnimFrameLZ_1e ; $615c
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $615f
	call DecompressData ; $6162
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6165
	ld de, $80c0 ; $6168
	ld c, $02 ; $616b
	call QueueVRAMCopy ; $616d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate3 ; $6170
	ld d, $2e ; $6173
	ld e, $80 ; $6175
	ld bc, $030c ; $6177
	call QueueSpriteTemplate ; $617a
	ret ; $617d
.eq1f:
	wram_bank $01 ; $617e
	ld hl, CutsceneAnimFrameLZ_1f ; $6184
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6187
	call DecompressData ; $618a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $618d
	ld de, $80c0 ; $6190
	ld c, $02 ; $6193
	call QueueVRAMCopy ; $6195
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate4 ; $6198
	ld d, $2e ; $619b
	ld e, $80 ; $619d
	ld bc, $030c ; $619f
	call QueueSpriteTemplate ; $61a2
	ret ; $61a5
.eq20:
	wram_bank $01 ; $61a6
	ld hl, CutsceneAnimFrameLZ_20 ; $61ac
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61af
	call DecompressData ; $61b2
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $61b5
	ld de, $80c0 ; $61b8
	ld c, $02 ; $61bb
	call QueueVRAMCopy ; $61bd
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate5 ; $61c0
	ld d, $2e ; $61c3
	ld e, $80 ; $61c5
	ld bc, $030c ; $61c7
	call QueueSpriteTemplate ; $61ca
	ret ; $61cd
.eq21:
	wram_bank $01 ; $61ce
	ld hl, CutsceneAnimFrameLZ_21 ; $61d4
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61d7
	call DecompressData ; $61da
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $61dd
	ld de, $80c0 ; $61e0
	ld c, $02 ; $61e3
	call QueueVRAMCopy ; $61e5
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate6 ; $61e8
	ld d, $2e ; $61eb
	ld e, $80 ; $61ed
	ld bc, $030c ; $61ef
	call QueueSpriteTemplate ; $61f2
	ret ; $61f5
.eq22:
	wram_bank $01 ; $61f6
	ld hl, CutsceneAnimFrameLZ_22 ; $61fc
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $61ff
	call DecompressData ; $6202
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $6205
	ld de, $80c0 ; $6208
	ld c, $02 ; $620b
	call QueueVRAMCopy ; $620d
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate7 ; $6210
	ld d, $2e ; $6213
	ld e, $80 ; $6215
	ld bc, $030c ; $6217
	call QueueSpriteTemplate ; $621a
	ret ; $621d
.eq23:
	wram_bank $01 ; $621e
	ld hl, CutsceneAnimFrameLZ_23 ; $6224
	ld de, wDecompBuffer + 12 * TILE_SIZE ; $6227
	call DecompressData ; $622a
	ld hl, wDecompBuffer + 12 * TILE_SIZE ; $622d
	ld de, $80c0 ; $6230
	ld c, $02 ; $6233
	call QueueVRAMCopy ; $6235
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8 ; $6238
	ld d, $2e ; $623b
	ld e, $80 ; $623d
	ld bc, $030c ; $623f
	call QueueSpriteTemplate ; $6242
	ret ; $6245
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8 ; $6246
	ld d, $2e ; $6249
	ld e, $80 ; $624b
	ld bc, $030c ; $624d
	call QueueSpriteTemplate ; $6250
	ret ; $6253
LoadCutsceneAnimFrameGfx_24_2C:
	wram_bank $06 ; $6254
	ld a, [$d000] ; $625a
	ld b, a ; $625d
	sub $24 ; $625e
	ret c ; $6260
	ld a, b ; $6261
	cp $24 ; $6262
	jp z, .eq24 ; $6264
	cp $25 ; $6267
	jp z, .eq25 ; $6269
	cp $26 ; $626c
	jp z, .eq26 ; $626e
	cp $27 ; $6271
	jp z, .eq27 ; $6273
	cp $28 ; $6276
	jp z, .eq28 ; $6278
	cp $29 ; $627b
	jp z, .eq29 ; $627d
	cp $2a ; $6280
	jp z, .eq2a ; $6282
	cp $2b ; $6285
	jp z, .eq2b ; $6287
	cp $2c ; $628a
	jp z, .eq2c ; $628c
	jp .queueSpriteTemplate ; $628f
.eq24:
	wram_bank $01 ; $6292
	ld hl, CutsceneAnimFrameLZ_24 ; $6298
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $629b
	call DecompressData ; $629e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62a1
	ld de, $80e0 ; $62a4
	ld c, $02 ; $62a7
	call QueueVRAMCopy ; $62a9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate0 ; $62ac
	ld d, $36 ; $62af
	ld e, $80 ; $62b1
	ld bc, $020e ; $62b3
	call QueueSpriteTemplate ; $62b6
	ret ; $62b9
.eq25:
	wram_bank $01 ; $62ba
	ld hl, CutsceneAnimFrameLZ_25 ; $62c0
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $62c3
	call DecompressData ; $62c6
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62c9
	ld de, $80e0 ; $62cc
	ld c, $02 ; $62cf
	call QueueVRAMCopy ; $62d1
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate1 ; $62d4
	ld d, $36 ; $62d7
	ld e, $80 ; $62d9
	ld bc, $020e ; $62db
	call QueueSpriteTemplate ; $62de
	ret ; $62e1
.eq26:
	wram_bank $01 ; $62e2
	ld hl, CutsceneAnimFrameLZ_26 ; $62e8
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $62eb
	call DecompressData ; $62ee
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $62f1
	ld de, $80e0 ; $62f4
	ld c, $02 ; $62f7
	call QueueVRAMCopy ; $62f9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate2 ; $62fc
	ld d, $36 ; $62ff
	ld e, $80 ; $6301
	ld bc, $020e ; $6303
	call QueueSpriteTemplate ; $6306
	ret ; $6309
.eq27:
	wram_bank $01 ; $630a
	ld hl, CutsceneAnimFrameLZ_27 ; $6310
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $6313
	call DecompressData ; $6316
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6319
	ld de, $80e0 ; $631c
	ld c, $02 ; $631f
	call QueueVRAMCopy ; $6321
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate3 ; $6324
	ld d, $36 ; $6327
	ld e, $80 ; $6329
	ld bc, $020e ; $632b
	call QueueSpriteTemplate ; $632e
	ret ; $6331
.eq28:
	wram_bank $01 ; $6332
	ld hl, CutsceneAnimFrameLZ_28 ; $6338
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $633b
	call DecompressData ; $633e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6341
	ld de, $80e0 ; $6344
	ld c, $02 ; $6347
	call QueueVRAMCopy ; $6349
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate4 ; $634c
	ld d, $36 ; $634f
	ld e, $80 ; $6351
	ld bc, $020e ; $6353
	call QueueSpriteTemplate ; $6356
	ret ; $6359
.eq29:
	wram_bank $01 ; $635a
	ld hl, CutsceneAnimFrameLZ_29 ; $6360
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $6363
	call DecompressData ; $6366
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6369
	ld de, $80e0 ; $636c
	ld c, $02 ; $636f
	call QueueVRAMCopy ; $6371
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate5 ; $6374
	ld d, $36 ; $6377
	ld e, $80 ; $6379
	ld bc, $020e ; $637b
	call QueueSpriteTemplate ; $637e
	ret ; $6381
.eq2a:
	wram_bank $01 ; $6382
	ld hl, CutsceneAnimFrameLZ_2a ; $6388
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $638b
	call DecompressData ; $638e
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $6391
	ld de, $80e0 ; $6394
	ld c, $02 ; $6397
	call QueueVRAMCopy ; $6399
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate6 ; $639c
	ld d, $36 ; $639f
	ld e, $80 ; $63a1
	ld bc, $020e ; $63a3
	call QueueSpriteTemplate ; $63a6
	ret ; $63a9
.eq2b:
	wram_bank $01 ; $63aa
	ld hl, CutsceneAnimFrameLZ_2b ; $63b0
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $63b3
	call DecompressData ; $63b6
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $63b9
	ld de, $80e0 ; $63bc
	ld c, $02 ; $63bf
	call QueueVRAMCopy ; $63c1
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate7 ; $63c4
	ld d, $36 ; $63c7
	ld e, $80 ; $63c9
	ld bc, $020e ; $63cb
	call QueueSpriteTemplate ; $63ce
	ret ; $63d1
.eq2c:
	wram_bank $01 ; $63d2
	ld hl, CutsceneAnimFrameLZ_2c ; $63d8
	ld de, wDecompBuffer + 14 * TILE_SIZE ; $63db
	call DecompressData ; $63de
	ld hl, wDecompBuffer + 14 * TILE_SIZE ; $63e1
	ld de, $80e0 ; $63e4
	ld c, $02 ; $63e7
	call QueueVRAMCopy ; $63e9
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8 ; $63ec
	ld d, $36 ; $63ef
	ld e, $80 ; $63f1
	ld bc, $020e ; $63f3
	call QueueSpriteTemplate ; $63f6
	ret ; $63f9
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8 ; $63fa
	ld d, $36 ; $63fd
	ld e, $80 ; $63ff
	ld bc, $020e ; $6401
	call QueueSpriteTemplate ; $6404
	ret ; $6407
LoadCutsceneAnimFrameGfx_2D_35:
	wram_bank $06 ; $6408
	ld a, [$d000] ; $640e
	ld b, a ; $6411
	sub $2d ; $6412
	ret c ; $6414
	ld a, b ; $6415
	cp $2d ; $6416
	jp z, .eq2d ; $6418
	cp $2e ; $641b
	jp z, .eq2e ; $641d
	cp $2f ; $6420
	jp z, .eq2f ; $6422
	cp $30 ; $6425
	jp z, .eq30 ; $6427
	cp $31 ; $642a
	jp z, .eq31 ; $642c
	cp $32 ; $642f
	jp z, .eq32 ; $6431
	cp $33 ; $6434
	jp z, .eq33 ; $6436
	cp $34 ; $6439
	jp z, .eq34 ; $643b
	cp $35 ; $643e
	jp z, .eq35 ; $6440
	jp .queueSpriteTemplate ; $6443
.eq2d:
	wram_bank $01 ; $6446
	ld hl, CutsceneAnimFrameLZ_2d ; $644c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $644f
	call DecompressData ; $6452
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6455
	ld de, $8100 ; $6458
	ld c, $02 ; $645b
	call QueueVRAMCopy ; $645d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate0 ; $6460
	ld d, $3e ; $6463
	ld e, $80 ; $6465
	ld bc, $0310 ; $6467
	call QueueSpriteTemplate ; $646a
	ret ; $646d
.eq2e:
	wram_bank $01 ; $646e
	ld hl, CutsceneAnimFrameLZ_2e ; $6474
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6477
	call DecompressData ; $647a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $647d
	ld de, $8100 ; $6480
	ld c, $02 ; $6483
	call QueueVRAMCopy ; $6485
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate1 ; $6488
	ld d, $3e ; $648b
	ld e, $80 ; $648d
	ld bc, $0310 ; $648f
	call QueueSpriteTemplate ; $6492
	ret ; $6495
.eq2f:
	wram_bank $01 ; $6496
	ld hl, CutsceneAnimFrameLZ_2f ; $649c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $649f
	call DecompressData ; $64a2
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64a5
	ld de, $8100 ; $64a8
	ld c, $02 ; $64ab
	call QueueVRAMCopy ; $64ad
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate2 ; $64b0
	ld d, $3e ; $64b3
	ld e, $80 ; $64b5
	ld bc, $0310 ; $64b7
	call QueueSpriteTemplate ; $64ba
	ret ; $64bd
.eq30:
	wram_bank $01 ; $64be
	ld hl, CutsceneAnimFrameLZ_30 ; $64c4
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $64c7
	call DecompressData ; $64ca
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64cd
	ld de, $8100 ; $64d0
	ld c, $02 ; $64d3
	call QueueVRAMCopy ; $64d5
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate3 ; $64d8
	ld d, $3e ; $64db
	ld e, $80 ; $64dd
	ld bc, $0310 ; $64df
	call QueueSpriteTemplate ; $64e2
	ret ; $64e5
.eq31:
	wram_bank $01 ; $64e6
	ld hl, CutsceneAnimFrameLZ_31 ; $64ec
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $64ef
	call DecompressData ; $64f2
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $64f5
	ld de, $8100 ; $64f8
	ld c, $02 ; $64fb
	call QueueVRAMCopy ; $64fd
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate4 ; $6500
	ld d, $3e ; $6503
	ld e, $80 ; $6505
	ld bc, $0310 ; $6507
	call QueueSpriteTemplate ; $650a
	ret ; $650d
.eq32:
	wram_bank $01 ; $650e
	ld hl, CutsceneAnimFrameLZ_32 ; $6514
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6517
	call DecompressData ; $651a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $651d
	ld de, $8100 ; $6520
	ld c, $02 ; $6523
	call QueueVRAMCopy ; $6525
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate5 ; $6528
	ld d, $3e ; $652b
	ld e, $80 ; $652d
	ld bc, $0310 ; $652f
	call QueueSpriteTemplate ; $6532
	ret ; $6535
.eq33:
	wram_bank $01 ; $6536
	ld hl, CutsceneAnimFrameLZ_33 ; $653c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $653f
	call DecompressData ; $6542
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6545
	ld de, $8100 ; $6548
	ld c, $02 ; $654b
	call QueueVRAMCopy ; $654d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate6 ; $6550
	ld d, $3e ; $6553
	ld e, $80 ; $6555
	ld bc, $0310 ; $6557
	call QueueSpriteTemplate ; $655a
	ret ; $655d
.eq34:
	wram_bank $01 ; $655e
	ld hl, CutsceneAnimFrameLZ_34 ; $6564
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6567
	call DecompressData ; $656a
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $656d
	ld de, $8100 ; $6570
	ld c, $02 ; $6573
	call QueueVRAMCopy ; $6575
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate7 ; $6578
	ld d, $3e ; $657b
	ld e, $80 ; $657d
	ld bc, $0310 ; $657f
	call QueueSpriteTemplate ; $6582
	ret ; $6585
.eq35:
	wram_bank $01 ; $6586
	ld hl, CutsceneAnimFrameLZ_35 ; $658c
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $658f
	call DecompressData ; $6592
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $6595
	ld de, $8100 ; $6598
	ld c, $02 ; $659b
	call QueueVRAMCopy ; $659d
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8 ; $65a0
	ld d, $3e ; $65a3
	ld e, $80 ; $65a5
	ld bc, $0310 ; $65a7
	call QueueSpriteTemplate ; $65aa
	ret ; $65ad
.queueSpriteTemplate:
	ld hl, LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8 ; $65ae
	ld d, $3e ; $65b1
	ld e, $80 ; $65b3
	ld bc, $0310 ; $65b5
	call QueueSpriteTemplate ; $65b8
	ret ; $65bb
SceneAnimObjPalette0_03:
	INCLUDE "data/bank_003/palettes_65bc.asm" ; $65bc, 8 bytes (palettes)
SceneAnimObjPalette1_03:
	INCLUDE "data/bank_003/palettes_65c4.asm" ; $65c4, 8 bytes (palettes)
	; $65cc, 4 bytes (fill)
	ds 4, $00
CutsceneAnimFrameLZ_00:
	INCBIN "data/bank_003/d_65d0.bin" ; $65d0, 42 bytes
CutsceneAnimFrameLZ_01:
	INCBIN "data/bank_003/d_65fa.bin" ; $65fa, 46 bytes
CutsceneAnimFrameLZ_02:
	INCBIN "data/bank_003/d_6628.bin" ; $6628, 48 bytes
CutsceneAnimFrameLZ_03:
	INCBIN "data/bank_003/d_6658.bin" ; $6658, 65 bytes
CutsceneAnimFrameLZ_04:
	INCBIN "data/bank_003/d_6699.bin" ; $6699, 66 bytes
CutsceneAnimFrameLZ_05:
	INCBIN "data/bank_003/d_66db.bin" ; $66db, 72 bytes
CutsceneAnimFrameLZ_06:
	INCBIN "data/bank_003/d_6723.bin" ; $6723, 73 bytes
CutsceneAnimFrameLZ_07:
	INCBIN "data/bank_003/d_676c.bin" ; $676c, 73 bytes
CutsceneAnimFrameLZ_08:
	INCBIN "data/bank_003/d_67b5.bin" ; $67b5, 71 bytes
CutsceneAnimFrameLZ_09:
	INCBIN "data/bank_003/d_67fc.bin" ; $67fc, 38 bytes
CutsceneAnimFrameLZ_0a:
	INCBIN "data/bank_003/d_6822.bin" ; $6822, 46 bytes
CutsceneAnimFrameLZ_0b:
	INCBIN "data/bank_003/d_6850.bin" ; $6850, 46 bytes
CutsceneAnimFrameLZ_0c:
	INCBIN "data/bank_003/d_687e.bin" ; $687e, 67 bytes
CutsceneAnimFrameLZ_0d:
	INCBIN "data/bank_003/d_68c1.bin" ; $68c1, 75 bytes
CutsceneAnimFrameLZ_0e:
	INCBIN "data/bank_003/d_690c.bin" ; $690c, 75 bytes
CutsceneAnimFrameLZ_0f:
	INCBIN "data/bank_003/d_6957.bin" ; $6957, 75 bytes
CutsceneAnimFrameLZ_10:
	INCBIN "data/bank_003/d_69a2.bin" ; $69a2, 74 bytes
CutsceneAnimFrameLZ_11:
	INCBIN "data/bank_003/d_69ec.bin" ; $69ec, 73 bytes
CutsceneAnimFrameLZ_12:
	INCBIN "data/bank_003/d_6a35.bin" ; $6a35, 39 bytes
CutsceneAnimFrameLZ_13:
	INCBIN "data/bank_003/d_6a5c.bin" ; $6a5c, 49 bytes
CutsceneAnimFrameLZ_14:
	INCBIN "data/bank_003/d_6a8d.bin" ; $6a8d, 53 bytes
CutsceneAnimFrameLZ_15:
	INCBIN "data/bank_003/d_6ac2.bin" ; $6ac2, 66 bytes
CutsceneAnimFrameLZ_16:
	INCBIN "data/bank_003/d_6b04.bin" ; $6b04, 69 bytes
CutsceneAnimFrameLZ_17:
	INCBIN "data/bank_003/d_6b49.bin" ; $6b49, 73 bytes
CutsceneAnimFrameLZ_18:
	INCBIN "data/bank_003/d_6b92.bin" ; $6b92, 74 bytes
CutsceneAnimFrameLZ_19:
	INCBIN "data/bank_003/d_6bdc.bin" ; $6bdc, 74 bytes
CutsceneAnimFrameLZ_1a:
	INCBIN "data/bank_003/d_6c26.bin" ; $6c26, 69 bytes
CutsceneAnimFrameLZ_1b:
	INCBIN "data/bank_003/d_6c6b.bin" ; $6c6b, 15 bytes
CutsceneAnimFrameLZ_1c:
	INCBIN "data/bank_003/d_6c7a.bin" ; $6c7a, 15 bytes
CutsceneAnimFrameLZ_1d:
	INCBIN "data/bank_003/d_6c89.bin" ; $6c89, 15 bytes
CutsceneAnimFrameLZ_1e:
	INCBIN "data/bank_003/d_6c98.bin" ; $6c98, 19 bytes
CutsceneAnimFrameLZ_1f:
	INCBIN "data/bank_003/d_6cab.bin" ; $6cab, 22 bytes
CutsceneAnimFrameLZ_20:
	INCBIN "data/bank_003/d_6cc1.bin" ; $6cc1, 22 bytes
CutsceneAnimFrameLZ_21:
	INCBIN "data/bank_003/d_6cd7.bin" ; $6cd7, 22 bytes
CutsceneAnimFrameLZ_22:
	INCBIN "data/bank_003/d_6ced.bin" ; $6ced, 22 bytes
CutsceneAnimFrameLZ_23:
	INCBIN "data/bank_003/d_6d03.bin" ; $6d03, 22 bytes
CutsceneAnimFrameLZ_24:
	INCBIN "data/bank_003/d_6d19.bin" ; $6d19, 15 bytes
CutsceneAnimFrameLZ_25:
	INCBIN "data/bank_003/d_6d28.bin" ; $6d28, 15 bytes
CutsceneAnimFrameLZ_26:
	INCBIN "data/bank_003/d_6d37.bin" ; $6d37, 15 bytes
CutsceneAnimFrameLZ_27:
	INCBIN "data/bank_003/d_6d46.bin" ; $6d46, 20 bytes
CutsceneAnimFrameLZ_28:
	INCBIN "data/bank_003/d_6d5a.bin" ; $6d5a, 21 bytes
CutsceneAnimFrameLZ_29:
	INCBIN "data/bank_003/d_6d6f.bin" ; $6d6f, 22 bytes
CutsceneAnimFrameLZ_2a:
	INCBIN "data/bank_003/d_6d85.bin" ; $6d85, 22 bytes
CutsceneAnimFrameLZ_2b:
	INCBIN "data/bank_003/d_6d9b.bin" ; $6d9b, 22 bytes
CutsceneAnimFrameLZ_2c:
	INCBIN "data/bank_003/d_6db1.bin" ; $6db1, 22 bytes
CutsceneAnimFrameLZ_2d:
	INCBIN "data/bank_003/d_6dc7.bin" ; $6dc7, 15 bytes
CutsceneAnimFrameLZ_2e:
	INCBIN "data/bank_003/d_6dd6.bin" ; $6dd6, 15 bytes
CutsceneAnimFrameLZ_2f:
	INCBIN "data/bank_003/d_6de5.bin" ; $6de5, 15 bytes
CutsceneAnimFrameLZ_30:
	INCBIN "data/bank_003/d_6df4.bin" ; $6df4, 19 bytes
CutsceneAnimFrameLZ_31:
	INCBIN "data/bank_003/d_6e07.bin" ; $6e07, 22 bytes
CutsceneAnimFrameLZ_32:
	INCBIN "data/bank_003/d_6e1d.bin" ; $6e1d, 22 bytes
CutsceneAnimFrameLZ_33:
	INCBIN "data/bank_003/d_6e33.bin" ; $6e33, 22 bytes
CutsceneAnimFrameLZ_34:
	INCBIN "data/bank_003/d_6e49.bin" ; $6e49, 22 bytes
CutsceneAnimFrameLZ_35:
	INCBIN "data/bank_003/d_6e5f.bin" ; $6e5f, 22 bytes
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate0:
	; $6e75, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate1:
	; $6e7e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate2:
	; $6e87, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate3:
	; $6e90, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate4:
	; $6e99, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate5:
	; $6ea2, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate6:
	; $6eab, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate7:
	; $6eb4, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_00_08_SpriteTemplate8:
	; $6ebd, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate0:
	; $6ec6, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate1:
	; $6ecf, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate2:
	; $6ed8, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate3:
	; $6ee1, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate4:
	; $6eea, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate5:
	; $6ef3, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate6:
	; $6efc, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate7:
	; $6f05, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_09_11_SpriteTemplate8:
	; $6f0e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate0:
	; $6f17, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate1:
	; $6f20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate2:
	; $6f29, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate3:
	; $6f32, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate4:
	; $6f3b, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate5:
	; $6f44, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate6:
	; $6f4d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate7:
	; $6f56, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_12_1A_SpriteTemplate8:
	; $6f5f, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate0:
	; $6f68, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate1:
	; $6f6d, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate2:
	; $6f72, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate3:
	; $6f77, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate4:
	; $6f7c, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate5:
	; $6f81, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate6:
	; $6f86, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate7:
	; $6f8b, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_1B_23_SpriteTemplate8:
	; $6f90, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate0:
	; $6f95, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate1:
	; $6f9a, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate2:
	; $6f9f, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate3:
	; $6fa4, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate4:
	; $6fa9, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate5:
	; $6fae, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate6:
	; $6fb3, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate7:
	; $6fb8, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_24_2C_SpriteTemplate8:
	; $6fbd, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate0:
	; $6fc2, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate1:
	; $6fc7, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate2:
	; $6fcc, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate3:
	; $6fd1, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate4:
	; $6fd6, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate5:
	; $6fdb, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate6:
	; $6fe0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate7:
	; $6fe5, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
LoadCutsceneAnimFrameGfx_2D_35_SpriteTemplate8:
	; $6fea, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
FillMemoryDE:
	ld a, b ; $6fef
	ld [hl+], a ; $6ff0
	dec de ; $6ff1
	ld a, d ; $6ff2
	or e ; $6ff3
	jr nz, FillMemoryDE ; $6ff4
	ret ; $6ff6
PlayScrollingStoryCutscene:
	push af ; $6ff7
	push bc ; $6ff8
	push de ; $6ff9
	push hl ; $6ffa
	ld b, a ; $6ffb
	ldh a, [hWramBank] ; $6ffc
	push af ; $6ffe
	ld a, b ; $6fff
	push af ; $7000
	ld hl, WindowSolidTile_03 ; $7001
	ld de, $8ff0 ; $7004
	ld c, $01 ; $7007
	call QueueVRAMCopy ; $7009
	ld hl, WindowAttrMap_03 ; $700c
	ld de, $bc00 ; $700f
	ld c, $10 ; $7012
	call QueueVRAMCopy ; $7014
	ld hl, WindowTileMap_03 ; $7017
	ld de, $9c00 ; $701a
	ld c, $10 ; $701d
	call QueueVRAMCopy ; $701f
	call AdvanceFrame ; $7022
	farcall StopSceneScrollTask ; $7025
	ld a, $90 ; $7028
	ldh [rWY], a ; $702a
	wram_bank $06 ; $702c
	xor a ; $7032
	ld [$d000], a ; $7033
	ld [wCutsceneSlideTimer], a ; $7036
	pop af ; $7039
	push af ; $703a
	ld [wCutsceneWindowSliding], a ; $703b
	ld a, $01 ; $703e
	ld hl, AnimateWindowSlideUpTask ; $7040
	call RegisterFrameTask ; $7043
.loop:
	call AdvanceFrame ; $7046
	ld a, [$d000] ; $7049
	or a ; $704c
	jr z, .loop ; $704d
	ld a, $20 ; $704f
.loopB:
	call AdvanceFrame ; $7051
	dec a ; $7054
	or a ; $7055
	jr nz, .loopB ; $7056
	wram_bank $01 ; $7058
	ld hl, wDecompBuffer ; $705e
	ld b, $20 ; $7061
	ld de, $0300 ; $7063
	call FillMemoryDE ; $7066
	wram_bank $05 ; $7069
	ld hl, wWindowShadowTilemap ; $706f
	ld b, $20 ; $7072
	ld de, $0100 ; $7074
	call FillMemoryDE ; $7077
	call AdvanceFrame ; $707a
	pop af ; $707d
	call DrawCutsceneTextPage ; $707e
	call ScrollCutsceneTextWindow ; $7081
	pop af ; $7084
	wram_bank ; $7085
	pop hl ; $7089
	pop de ; $708a
	pop bc ; $708b
	pop af ; $708c
	ret ; $708d
	; $708e, 2 bytes (fill)
	ds 2, $00
WindowSolidTile_03:
	ds 16, $ff ; $7090, fill
WindowAttrMap_03:
	; $70a0, 256 bytes (pattern)
	ds 256, $80
WindowTileMap_03:
	; $71a0, 256 bytes (pattern)
	ds 256, $20
AnimateWindowSlideUpTask:
	ldh a, [hWramBank] ; $72a0
	push af ; $72a2
	wram_bank $06 ; $72a3
	ld a, [wCutsceneWindowSliding] ; $72a9
	ld b, a ; $72ac
	ld hl, WindowSlideStepTable_03 ; $72ad
	ld a, b ; $72b0
	add a ; $72b1
	add l ; $72b2
	ld l, a ; $72b3
	jr nc, .read ; $72b4
	inc h ; $72b6
.read:
	ld a, [hl+] ; $72b7
	ld c, a ; $72b8
	ld e, [hl] ; $72b9
	ld d, $00 ; $72ba
	pop af ; $72bc
	wram_bank ; $72bd
	ldh a, [hVBlankCounter] ; $72c1
	and $01 ; $72c3
	jr nz, .maskSet ; $72c5
	ldh a, [hScrollY] ; $72c7
	add c ; $72c9
	ldh [hScrollY], a ; $72ca
	ld hl, wRasterScrollStartLY ; $72cc
	ld a, [hl+] ; $72cf
	ld h, [hl] ; $72d0
	ld l, a ; $72d1
	add hl, de ; $72d2
	ld d, h ; $72d3
	ld e, l ; $72d4
	ld hl, wRasterScrollStartLY ; $72d5
	ld a, e ; $72d8
	ld [hl+], a ; $72d9
	ld [hl], d ; $72da
.maskSet:
	ld a, [wCutsceneSlideTimer] ; $72db
	inc a ; $72de
	ld [wCutsceneSlideTimer], a ; $72df
	and $3f ; $72e2
	ld b, a ; $72e4
	ld a, $90 ; $72e5
	sub b ; $72e7
	ldh [rWY], a ; $72e8
	ld a, b ; $72ea
	cp $3f ; $72eb
	jr nz, .done ; $72ed
	ld hl, AnimateWindowSlideUpTask ; $72ef
	call UnregisterFrameTask ; $72f2
	wram_bank $06 ; $72f5
	ld a, $01 ; $72fb
	ld [$d000], a ; $72fd
.done:
	ret ; $7300
WindowSlideStepTable_03:
	; $7301, 50 bytes (bytes:2)
	db $01, $20 ; 0x00
	db $01, $20 ; 0x02
	db $01, $20 ; 0x04
	db $02, $40 ; 0x06
	db $01, $20 ; 0x08
	db $01, $20 ; 0x0a
	db $01, $20 ; 0x0c
	db $01, $20 ; 0x0e
	db $01, $20 ; 0x10
	db $01, $20 ; 0x12
	db $01, $20 ; 0x14
	db $00, $00 ; 0x16
	db $00, $00 ; 0x18
	db $01, $20 ; 0x1a
	db $01, $20 ; 0x1c
	db $00, $00 ; 0x1e
	db $01, $20 ; 0x20
	db $01, $20 ; 0x22
	db $01, $20 ; 0x24
	db $01, $20 ; 0x26
	db $01, $20 ; 0x28
	db $01, $20 ; 0x2a
	db $01, $20 ; 0x2c
	db $01, $20 ; 0x2e
	db $02, $20 ; 0x30
DrawCutsceneTextPage:
	push af ; $7333
	push bc ; $7334
	push de ; $7335
	push hl ; $7336
	ld b, a ; $7337
	ldh a, [hWramBank] ; $7338
	push af ; $733a
	and $0f ; $733b
	ld a, b ; $733d
	ld c, a ; $733e
	add a ; $733f
	add c ; $7340
	add a ; $7341
	add c ; $7342
	ld hl, TextPageDescriptors_03 ; $7343
	add l ; $7346
	ld l, a ; $7347
	jr nc, .gotPtr ; $7348
	inc h ; $734a
.gotPtr:
	wram_bank $06 ; $734b
	ld a, [hl] ; $7351
	ld [wCutsceneTextScrollRows], a ; $7352
	ld b, a ; $7355
	inc hl ; $7356
	ld c, $00 ; $7357
.loop:
	call DrawCutsceneTextLines ; $7359
	call AdvanceFrame ; $735c
	inc hl ; $735f
	inc hl ; $7360
	inc c ; $7361
	ld a, c ; $7362
	cp b ; $7363
	jr nz, .loop ; $7364
	pop af ; $7366
	wram_bank ; $7367
	pop hl ; $736b
	pop de ; $736c
	pop bc ; $736d
	pop af ; $736e
	ret ; $736f
TextPageDescriptors_03:
	; $7370, 147 bytes (records:7)
; 21 records x 7 bytes
	db $02, $00, $04, $04, $06, $00, $00 ; record 0
	db $01, $0a, $04, $00, $00, $00, $00 ; record 1
	db $01, $0e, $04, $00, $00, $00, $00 ; record 2
	db $01, $12, $04, $00, $00, $00, $00 ; record 3
	db $01, $16, $04, $00, $00, $00, $00 ; record 4
	db $01, $1a, $04, $00, $00, $00, $00 ; record 5
	db $01, $1e, $06, $00, $00, $00, $00 ; record 6
	db $02, $24, $06, $2a, $06, $00, $00 ; record 7
	db $01, $30, $06, $00, $00, $00, $00 ; record 8
	db $02, $36, $06, $3c, $06, $00, $00 ; record 9
	db $01, $42, $06, $00, $00, $00, $00 ; record 10
	db $01, $48, $05, $00, $00, $00, $00 ; record 11
	db $01, $4d, $05, $00, $00, $00, $00 ; record 12
	db $01, $52, $07, $00, $00, $00, $00 ; record 13
	db $02, $59, $05, $5e, $07, $00, $00 ; record 14
	db $01, $65, $05, $00, $00, $00, $00 ; record 15
	db $03, $6a, $06, $70, $06, $76, $05 ; record 16
	db $02, $7b, $07, $82, $07, $00, $00 ; record 17
	db $02, $7b, $07, $82, $07, $00, $00 ; record 18
	db $01, $89, $06, $00, $00, $00, $00 ; record 19
	db $01, $8f, $04, $00, $00, $00, $00 ; record 20
DrawCutsceneTextLines:
	push af ; $7403
	push bc ; $7404
	push de ; $7405
	push hl ; $7406
	ldh a, [hWramBank] ; $7407
	push af ; $7409
	push hl ; $740a
	ld hl, $0014 ; $740b
	ld a, c ; $740e
	or a ; $740f
	jr nz, .mulHLByA ; $7410
	ld h, $00 ; $7412
	ld l, $00 ; $7414
	jr .step ; $7416
.mulHLByA:
	call MulHLByA ; $7418
.step:
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
	add l ; $742a
	ld l, a ; $742b
	jr nc, .gotPtr ; $742c
	inc h ; $742e
.gotPtr:
	wram_bank $01 ; $742f
.loop:
	ld c, $50 ; $7435
	call DrawDialogueLineToBuffer ; $7437
	call AdvanceFrame ; $743a
	ld a, $50 ; $743d
	add e ; $743f
	ld e, a ; $7440
	jr nc, .gotPtr2 ; $7441
	inc d ; $7443
.gotPtr2:
	inc hl ; $7444
	dec b ; $7445
	jr nz, .loop ; $7446
	pop af ; $7448
	wram_bank ; $7449
	pop hl ; $744d
	pop de ; $744e
	pop bc ; $744f
	pop af ; $7450
	ret ; $7451
ScrollCutsceneTextWindow:
	push af ; $7452
	push bc ; $7453
	push de ; $7454
	push hl ; $7455
	ldh a, [hWramBank] ; $7456
	push af ; $7458
	wram_bank $06 ; $7459
	ld a, [wCutsceneTextScrollRows] ; $745f
	and $03 ; $7462
	jr nz, .maskSet ; $7464
	ld a, $01 ; $7466
.maskSet:
	ld b, a ; $7468
	ld d, $00 ; $7469
	ld c, $00 ; $746b
.loop:
	call AdvanceFrame ; $746d
	ld e, $14 ; $7470
.loopB:
	call BlitCutsceneTextWindow ; $7472
	inc c ; $7475
	dec e ; $7476
	jr nz, .loopB ; $7477
	ld e, $ff ; $7479
.loop2:
	call AdvanceFrame ; $747b
	dec e ; $747e
	jr nz, .loop2 ; $747f
	inc d ; $7481
	ld a, d ; $7482
	cp b ; $7483
	jr nz, .loop ; $7484
	pop af ; $7486
	wram_bank ; $7487
	pop hl ; $748b
	pop de ; $748c
	pop bc ; $748d
	pop af ; $748e
	ret ; $748f
BlitCutsceneTextWindow:
	push af ; $7490
	push bc ; $7491
	push de ; $7492
	push hl ; $7493
	ldh a, [hWramBank] ; $7494
	push af ; $7496
	ld hl, $d000 ; $7497
	ld a, c ; $749a
	add l ; $749b
	ld l, a ; $749c
	jr nc, .gotPtr ; $749d
	inc h ; $749f
.gotPtr:
	ld b, $08 ; $74a0
	ld de, $d000 ; $74a2
.loop:
	ld c, $14 ; $74a5
	push hl ; $74a7
	push de ; $74a8
.loopB:
	wram_bank $01 ; $74a9
	ld a, [hl+] ; $74af
	push hl ; $74b0
	ld h, d ; $74b1
	ld l, e ; $74b2
	push af ; $74b3
	wram_bank $05 ; $74b4
	pop af ; $74ba
	ld [hl], a ; $74bb
	inc de ; $74bc
	pop hl ; $74bd
	dec c ; $74be
	jr nz, .loopB ; $74bf
	pop de ; $74c1
	pop hl ; $74c2
	ld a, $50 ; $74c3
	add l ; $74c5
	ld l, a ; $74c6
	jr nc, .gotPtr2 ; $74c7
	inc h ; $74c9
.gotPtr2:
	ld a, $20 ; $74ca
	add e ; $74cc
	ld e, a ; $74cd
	jr nc, .gotPtr3 ; $74ce
	inc d ; $74d0
.gotPtr3:
	dec b ; $74d1
	jr nz, .loop ; $74d2
	wram_bank $05 ; $74d4
	ld hl, wWindowShadowTilemap ; $74da
	ld de, $9c00 ; $74dd
	ld c, $10 ; $74e0
	call QueueVRAMCopy ; $74e2
	call AdvanceFrame ; $74e5
	pop af ; $74e8
	wram_bank ; $74e9
	pop hl ; $74ed
	pop de ; $74ee
	pop bc ; $74ef
	pop af ; $74f0
	ret ; $74f1
DrawDialogueLineToBuffer:
	push af ; $74f2
	push bc ; $74f3
	push de ; $74f4
	push hl ; $74f5
	ldh a, [hWramBank] ; $74f6
	push af ; $74f8
	farcall FetchDialogueText ; $74f9
	ld hl, wTextBuffer ; $74fc
	wram_bank $01 ; $74ff
	ld c, $14 ; $7505
.loop:
	ld a, [hl+] ; $7507
	or a ; $7508
	jr z, .restore ; $7509
	push hl ; $750b
	ld h, d ; $750c
	ld l, e ; $750d
	ld [hl], a ; $750e
	pop hl ; $750f
	inc de ; $7510
	dec c ; $7511
	jr nz, .loop ; $7512
.restore:
	pop af ; $7514
	wram_bank ; $7515
	pop hl ; $7519
	pop de ; $751a
	pop bc ; $751b
	pop af ; $751c
	ret ; $751d
ShowStoryResultScreen:
	push af ; $751e
	push bc ; $751f
	push de ; $7520
	push hl ; $7521
	ldh a, [hWramBank] ; $7522
	push af ; $7524
	wram_bank $02 ; $7525
	ld hl, wScreenAttrmap ; $752b
	ld de, $0240 ; $752e
	ld b, $00 ; $7531
	call FillMemoryDE ; $7533
	wram_bank $03 ; $7536
	ld hl, wShadowTilemap ; $753c
	ld de, $0240 ; $753f
	ld b, $20 ; $7542
	call FillMemoryDE ; $7544
	ld hl, Text_5e_320 ; $7547
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH ; $754a
	ld bc, $0020 ; $754d
	farcall FetchAndDrawDialogueText ; $7550
	ld hl, Text_5e_322 ; $7553
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH ; $7556
	ld bc, $0020 ; $7559
	farcall FetchAndDrawDialogueText ; $755c
	wram_bank $02 ; $755f
	ld hl, wScreenAttrmap ; $7565
	ld de, $b800 ; $7568
	ld c, $24 ; $756b
	call QueueVRAMCopy ; $756d
	wram_bank $03 ; $7570
	ld hl, wShadowTilemap ; $7576
	ld de, $9800 ; $7579
	ld c, $24 ; $757c
	call QueueVRAMCopy ; $757e
	xor a ; $7581
	ldh [hScrollX], a ; $7582
	ldh [hScrollY], a ; $7584
	ld [wCameraX], a ; $7586
	ld [wCameraX + 1], a ; $7589
	ld [wCameraY], a ; $758c
	ld [wCameraY + 1], a ; $758f
	call AdvanceFrame ; $7592
	script_fade_in $04 ; $7595
	call WaitFadeEnd ; $759a
	call WaitFramesCmd ; $759d
	db $78 ; $75a0 inline arg
	pop af ; $75a1
	wram_bank ; $75a2
	pop hl ; $75a6
	pop de ; $75a7
	pop bc ; $75a8
	pop af ; $75a9
	ret ; $75aa
InitGrayscalePaletteFade:
	ldh a, [hWramBank] ; $75ab
	push af ; $75ad
	wram_bank $06 ; $75ae
	xor a ; $75b4
	ld hl, wPaletteFadeMask ; $75b5
	ld b, $10 ; $75b8
.loop:
	ld [hl+], a ; $75ba
	dec b ; $75bb
	jr nz, .loop ; $75bc
	call BackupMasterPalettes ; $75be
	call DesaturateWorkingPalettes ; $75c1
	pop af ; $75c4
	wram_bank ; $75c5
	ret ; $75c9
	ldh a, [hWramBank] ; $75ca
	push af ; $75cc
	wram_bank $06 ; $75cd
	xor a ; $75d3
	ld hl, wPaletteFadeMask ; $75d4
	ld b, $10 ; $75d7
.loopB:
	ld [hl+], a ; $75d9
	dec b ; $75da
	jr nz, .loopB ; $75db
	call BackupMasterPalettes ; $75dd
	call ClearWorkingPaletteBuffer ; $75e0
	pop af ; $75e3
	wram_bank ; $75e4
	ret ; $75e8
BackupMasterPalettes:
	ld hl, wMasterPalettes ; $75e9
	ld de, wMasterPalettesBackup ; $75ec
	ld b, $80 ; $75ef
.loop:
	ld a, [hl+] ; $75f1
	ld [de], a ; $75f2
	inc de ; $75f3
	dec b ; $75f4
	jr nz, .loop ; $75f5
	ld hl, wMasterPalettes ; $75f7
	ld de, wWorkingPalettes ; $75fa
	ld b, $80 ; $75fd
.loopB:
	ld a, [hl+] ; $75ff
	ld [de], a ; $7600
	inc de ; $7601
	dec b ; $7602
	jr nz, .loopB ; $7603
	ret ; $7605
ClearWorkingPaletteBuffer:
	ld hl, wWorkingPalettes ; $7606
	ld b, $40 ; $7609
	ld de, $0000 ; $760b
.loop:
	ld a, e ; $760e
	ld [hl+], a ; $760f
	ld [hl], d ; $7610
	inc hl ; $7611
	dec b ; $7612
	jr nz, .loop ; $7613
	ret ; $7615
DesaturateWorkingPalettes:
	ld hl, wWorkingPalettes ; $7616
	ld de, wPaletteColorSplit ; $7619
	ld b, $40 ; $761c
.loop:
	push bc ; $761e
	push hl ; $761f
	ld a, [hl+] ; $7620
	ld b, [hl] ; $7621
	ld c, a ; $7622
	call SplitColorComponents ; $7623
	ld [de], a ; $7626
	inc de ; $7627
	ld a, b ; $7628
	ld [de], a ; $7629
	inc de ; $762a
	ld a, c ; $762b
	ld [de], a ; $762c
	dec de ; $762d
	dec de ; $762e
	call ComputeGrayscaleColor ; $762f
	inc de ; $7632
	inc de ; $7633
	ld a, [de] ; $7634
	ld c, a ; $7635
	dec de ; $7636
	ld a, [de] ; $7637
	ld b, a ; $7638
	dec de ; $7639
	ld a, [de] ; $763a
	call CombineColorComponents ; $763b
	pop hl ; $763e
	ld a, c ; $763f
	ld [hl+], a ; $7640
	ld [hl], b ; $7641
	inc hl ; $7642
	pop bc ; $7643
	dec b ; $7644
	jr nz, .loop ; $7645
	ret ; $7647
ComputeGrayscaleColor:
	ld a, [de] ; $7648
	inc de ; $7649
	ld c, a ; $764a
	ld a, [de] ; $764b
	inc de ; $764c
	add c ; $764d
	ld c, a ; $764e
	ld a, [de] ; $764f
	add c ; $7650
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
	jr z, .store ; $7681
	ld a, $1f ; $7683
.store:
	ld [de], a ; $7685
	ret ; $7686
SetupPaletteFadeMask:
	ldh a, [hWramBank] ; $7687
	push af ; $7689
	wram_bank $06 ; $768a
	ld hl, wPaletteFadeAmount ; $7690
	ld [hl], d ; $7693
	ld l, d ; $7694
	ld h, $00 ; $7695
	ld de, $001f ; $7697
	call DivHLByDE ; $769a
	ld a, l ; $769d
	ld [wPaletteFadeStep], a ; $769e
	ld hl, wPaletteFadeMask ; $76a1
	bit 7, b ; $76a4
	jr z, .positive ; $76a6
	ld [hl], $01 ; $76a8
.positive:
	inc hl ; $76aa
	bit 6, b ; $76ab
	jr z, .bit6Clear ; $76ad
	ld [hl], $01 ; $76af
.bit6Clear:
	inc hl ; $76b1
	bit 5, b ; $76b2
	jr z, .bit5Clear ; $76b4
	ld [hl], $01 ; $76b6
.bit5Clear:
	inc hl ; $76b8
	bit 4, b ; $76b9
	jr z, .bit4Clear ; $76bb
	ld [hl], $01 ; $76bd
.bit4Clear:
	inc hl ; $76bf
	bit 3, b ; $76c0
	jr z, .bit3Clear ; $76c2
	ld [hl], $01 ; $76c4
.bit3Clear:
	inc hl ; $76c6
	bit 2, b ; $76c7
	jr z, .bit2Clear ; $76c9
	ld [hl], $01 ; $76cb
.bit2Clear:
	inc hl ; $76cd
	bit 1, b ; $76ce
	jr z, .bit1Clear ; $76d0
	ld [hl], $01 ; $76d2
.bit1Clear:
	inc hl ; $76d4
	bit 0, b ; $76d5
	jr z, .bit0Clear ; $76d7
	ld [hl], $01 ; $76d9
.bit0Clear:
	inc hl ; $76db
	bit 7, c ; $76dc
	jr z, .positive2 ; $76de
	ld [hl], $01 ; $76e0
.positive2:
	inc hl ; $76e2
	bit 6, c ; $76e3
	jr z, .bit6Clear2 ; $76e5
	ld [hl], $01 ; $76e7
.bit6Clear2:
	inc hl ; $76e9
	bit 5, c ; $76ea
	jr z, .bit5Clear2 ; $76ec
	ld [hl], $01 ; $76ee
.bit5Clear2:
	inc hl ; $76f0
	bit 4, c ; $76f1
	jr z, .bit4Clear2 ; $76f3
	ld [hl], $01 ; $76f5
.bit4Clear2:
	inc hl ; $76f7
	bit 3, c ; $76f8
	jr z, .bit3Clear2 ; $76fa
	ld [hl], $01 ; $76fc
.bit3Clear2:
	inc hl ; $76fe
	bit 2, c ; $76ff
	jr z, .bit2Clear2 ; $7701
	ld [hl], $01 ; $7703
.bit2Clear2:
	inc hl ; $7705
	bit 1, c ; $7706
	jr z, .bit1Clear2 ; $7708
	ld [hl], $01 ; $770a
.bit1Clear2:
	inc hl ; $770c
	bit 0, c ; $770d
	jr z, .restore ; $770f
	ld [hl], $01 ; $7711
.restore:
	pop af ; $7713
	wram_bank ; $7714
	ret ; $7718
AnimatePaletteFadeToTarget:
	ldh a, [hWramBank] ; $7719
	push af ; $771b
	wram_bank $06 ; $771c
.loop:
	ld a, [wPaletteFadeStep] ; $7722
.loopB:
	and a ; $7725
	jr z, .zero ; $7726
	call AdvanceFrame ; $7728
	dec a ; $772b
	jr .loopB ; $772c
.zero:
	ld de, wPaletteFadeMask ; $772e
	ld b, $00 ; $7731
.loop2:
	push de ; $7733
	push bc ; $7734
	ld a, [de] ; $7735
	and a ; $7736
	jr z, .restore ; $7737
	call StepPaletteColorsTowardTarget ; $7739
.restore:
	pop bc ; $773c
	pop de ; $773d
	inc de ; $773e
	inc b ; $773f
	ld a, b ; $7740
	cp $10 ; $7741
	jr nz, .loop2 ; $7743
	ld hl, wMasterPalettesBackup ; $7745
	ld d, $00 ; $7748
	ld e, $10 ; $774a
	call LoadPalettesImmediate ; $774c
	call AdvanceFrame ; $774f
	ld hl, wPaletteFadeAmount ; $7752
	ld a, [hl] ; $7755
	dec a ; $7756
	ld [hl], a ; $7757
	and a ; $7758
	jr nz, .loop ; $7759
	call SnapPalettesToTarget ; $775b
	pop af ; $775e
	wram_bank ; $775f
	ret ; $7763
StepPaletteColorsTowardTarget:
	ld a, b ; $7764
	ld [wPaletteFadeIndex], a ; $7765
	ld hl, wWorkingPalettes ; $7768
	call AdvanceToPaletteEntry ; $776b
	ld d, h ; $776e
	ld e, l ; $776f
	ld hl, wMasterPalettesBackup ; $7770
	ld a, [wPaletteFadeIndex] ; $7773
	ld b, a ; $7776
	call AdvanceToPaletteEntry ; $7777
	ld b, $04 ; $777a
.loop:
	push bc ; $777c
	push de ; $777d
	push hl ; $777e
	ld a, [hl+] ; $777f
	ld b, [hl] ; $7780
	ld c, a ; $7781
	call SplitColorComponents ; $7782
	ld hl, wPaletteColorSplit ; $7785
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
	call SplitColorComponents ; $7792
	ld hl, wPaletteColorSplit + 3 ; $7795
	ld [hl+], a ; $7798
	ld a, b ; $7799
	ld [hl+], a ; $779a
	ld a, c ; $779b
	ld [hl], a ; $779c
	ld hl, wPaletteColorSplit ; $779d
	ld de, wPaletteColorSplit + 3 ; $77a0
	call StepColorComponentTowardTarget ; $77a3
	ld hl, wPaletteColorSplit + 1 ; $77a6
	ld de, wPaletteColorSplit + 4 ; $77a9
	call StepColorComponentTowardTarget ; $77ac
	ld hl, wPaletteColorSplit + 2 ; $77af
	ld de, wPaletteColorSplit + 5 ; $77b2
	call StepColorComponentTowardTarget ; $77b5
	ld hl, wPaletteColorSplit + 2 ; $77b8
	ld a, [hl-] ; $77bb
	ld c, a ; $77bc
	ld a, [hl-] ; $77bd
	ld b, a ; $77be
	ld a, [hl] ; $77bf
	call CombineColorComponents ; $77c0
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
	jr nz, .loop ; $77cd
	ret ; $77cf
StepColorComponentTowardTarget:
	ld a, [de] ; $77d0
	ld b, [hl] ; $77d1
	sub b ; $77d2
	ret z ; $77d3
	jr c, .read ; $77d4
	ld a, [hl] ; $77d6
	inc a ; $77d7
	and $1f ; $77d8
	ld [hl], a ; $77da
	ret ; $77db
.read:
	ld a, [hl] ; $77dc
	dec a ; $77dd
	and $1f ; $77de
	ld [hl], a ; $77e0
	ret ; $77e1
SnapPalettesToTarget:
	ld hl, wPaletteFadeMask ; $77e2
	ld b, $00 ; $77e5
.loop:
	push hl ; $77e7
	push bc ; $77e8
	ld a, [hl] ; $77e9
	and a ; $77ea
	jr z, .restore ; $77eb
	ld c, b ; $77ed
	ld hl, wWorkingPalettes ; $77ee
	call AdvanceToPaletteEntry ; $77f1
	ld d, h ; $77f4
	ld e, l ; $77f5
	ld b, c ; $77f6
	ld hl, wMasterPalettesBackup ; $77f7
	call AdvanceToPaletteEntry ; $77fa
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
.restore:
	pop bc ; $7815
	pop hl ; $7816
	inc hl ; $7817
	inc b ; $7818
	ld a, b ; $7819
	cp $10 ; $781a
	jr nz, .loop ; $781c
	ld hl, wMasterPalettesBackup ; $781e
	ld d, $00 ; $7821
	ld e, $10 ; $7823
	call LoadPalettesImmediate ; $7825
	ret ; $7828
AdvanceToPaletteEntry:
	ld a, b ; $7829
	and a ; $782a
	ret z ; $782b
	ld a, $08 ; $782c
	add l ; $782e
	ld l, a ; $782f
	jr nc, .seekLoop ; $7830
	inc h ; $7832
.seekLoop:
	dec b ; $7833
	jr AdvanceToPaletteEntry ; $7834
	; $7836, 1994 bytes fill to bank end (linker-padded)
