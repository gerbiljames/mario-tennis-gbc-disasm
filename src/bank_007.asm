SECTION "ROM Bank $07", ROMX[$4000], BANK[$07]

FarPtr_TryEstablishLink:
	dw TryEstablishLink ; $4000
FarPtr_EnableSerialAndVBlankInterrupts:
	dw EnableSerialAndVBlankInterrupts ; $4002
FarPtr_RunLinkMatchFrameMaster:
	dw RunLinkMatchFrameMaster ; $4004
FarPtr_RunLinkMatchFrameSlave:
	dw RunLinkMatchFrameSlave ; $4006
FarPtr_ExchangeNibbleBlockMaster:
	dw ExchangeNibbleBlockMaster ; $4008
FarPtr_ExchangeNibbleBlockSlave:
	dw ExchangeNibbleBlockSlave ; $400a
FarPtr_SendNibbleBlockSlave:
	dw SendNibbleBlockSlave ; $400c
FarPtr_ReceiveNibbleBlockMaster:
	dw ReceiveNibbleBlockMaster ; $400e
FarPtr_UnpackBytesToNibbles:
	dw UnpackBytesToNibbles ; $4010
FarPtr_ExchangeLinkFrameByteMaster:
	dw ExchangeLinkFrameByteMaster ; $4012
FarPtr_ExchangeLinkFrameByteSlave:
	dw ExchangeLinkFrameByteSlave ; $4014
FarPtr_SyncLinkFrameMaster:
	dw SyncLinkFrameMaster ; $4016
FarPtr_SyncLinkFrameSlave:
	dw SyncLinkFrameSlave ; $4018
FarPtr_SyncLinkFrame:
	dw SyncLinkFrame ; $401a
FarPtr_RunLinkMatchFrame:
	dw RunLinkMatchFrame ; $401c
FarPtr_ExchangeLinkReadySignal:
	dw ExchangeLinkReadySignal ; $401e
FarPtr_RunLinkInputFrame:
	dw RunLinkInputFrame ; $4020
FarPtr_UpdateLinkSession:
	dw UpdateLinkSession ; $4022
FarPtr_EndLinkSession:
	dw EndLinkSession ; $4024
FarPtr_ExchangeHandshakeBlockMaster:
	dw ExchangeHandshakeBlockMaster ; $4026
FarPtr_ExchangeHandshakeBlockSlave:
	dw ExchangeHandshakeBlockSlave ; $4028
FarPtr_ExchangeLinkBlockToWram5:
	dw ExchangeLinkBlockToWram5 ; $402a
FarPtr_PrimeSlaveSerialReply:
	dw PrimeSlaveSerialReply ; $402c
FarPtr_PrepareLinkStatePayload:
	dw PrepareLinkStatePayload ; $402e
FarPtr_PrepareLinkInputPayload:
	dw PrepareLinkInputPayload ; $4030
FarPtr_ResyncLinkSession:
	dw ResyncLinkSession ; $4032
FarPtr_ResyncLinkSessionWithTimer:
	dw ResyncLinkSessionWithTimer ; $4034
FarPtr_RunLinkCommandFrame:
	dw RunLinkCommandFrame ; $4036
FarPtr_ExchangeLinkDataBlock:
	dw ExchangeLinkDataBlock ; $4038
FarPtr_ComputeShotPlacement:
	dw ComputeShotPlacement ; $403a
FarPtr_ExecuteShot:
	dw ExecuteShot ; $403c
FarPtr_ComputeShotTrajectory:
	dw ComputeShotTrajectory ; $403e
FarPtr_LookupCharSpriteSet:
	dw LookupCharSpriteSet ; $4040
FarPtr_SetupCharacterSprite:
	dw SetupCharacterSprite ; $4042
FarPtr_LoadCharacterAttributes:
	dw LoadCharacterAttributes ; $4044
FarPtr_RunDebugTestMatch:
	dw RunDebugTestMatch ; $4046
TryEstablishLink:
	di ; $4048
	ldh a, [$ffc0] ; $4049
	ei ; $404b
	cp a, $c1 ; $404c
	jr z, Label_07_4061 ; $404e
	ld a, $01 ; $4050
	ldh [$ffc2], a ; $4052
	call TryLinkHandshakeMaster ; $4054
	jr nc, Label_07_4076 ; $4057
	push af ; $4059
	call ResetSerialState ; $405a
	pop af ; $405d
	scf ; $405e
	jr Label_07_4076 ; $405f
Label_07_4061:
	di ; $4061
	xor a, a ; $4062
	ldh [$ffc0], a ; $4063
	xor a, a ; $4065
	ldh [$ffd7], a ; $4066
	ei ; $4068
	ld a, $02 ; $4069
	ldh [$ffc2], a ; $406b
	call TryLinkHandshakeSlave ; $406d
	jr nc, Label_07_4076 ; $4070
	call ResetSerialState ; $4072
	scf ; $4075
Label_07_4076:
	ret ; $4076
EnableSerialAndVBlankInterrupts:
	di ; $4077
	xor a, a ; $4078
	ldh [rIF], a ; $4079
	ld a, $09 ; $407b
	ldh [rIE], a ; $407d
	ei ; $407f
	ret ; $4080
RunLinkMatchFrameMaster:
	push bc ; $4081
	push hl ; $4082
	call PrepareLinkStatePayload ; $4083
	call ExchangeLinkFrameByteMaster ; $4086
	call SerialDecodeInput ; $4089
	ldh a, [$ffd3] ; $408c
	call SoftResetIfABStartSelect ; $408e
	farcall FarPtr_UpdateMatchFrame ; $4091
	call SerialEncodeInput ; $4094
	pop hl ; $4097
	pop bc ; $4098
	ret ; $4099
RunLinkMatchFrameSlave:
	push bc ; $409a
	push hl ; $409b
	call PrepareLinkStatePayload ; $409c
	call ExchangeLinkFrameByteSlave ; $409f
	call SerialDecodeInput ; $40a2
	ldh a, [$ffd3] ; $40a5
	call SoftResetIfABStartSelect ; $40a7
	farcall FarPtr_UpdateMatchFrame ; $40aa
	call SerialEncodeInput ; $40ad
	pop hl ; $40b0
	pop bc ; $40b1
	ret ; $40b2
ExchangeNibbleBlockMaster:
	push af ; $40b3
	push bc ; $40b4
	push de ; $40b5
	push hl ; $40b6
	call UnpackBytesToNibbles ; $40b7
	jr nc, Label_07_40bf ; $40ba
	call LinkErrorReset ; $40bc
Label_07_40bf:
	ld c, a ; $40bf
	call ComputeNibbleBufferChecksum ; $40c0
Label_07_40c3:
	call ShortDelay ; $40c3
	call ShortDelay ; $40c6
	call ShortDelay ; $40c9
	call ShortDelay ; $40cc
	ld e, $64 ; $40cf
Label_07_40d1:
	di ; $40d1
	ld a, $c3 ; $40d2
	ldh [rSB], a ; $40d4
	push af ; $40d6
	ld a, $03 ; $40d7
	ldh [rSC], a ; $40d9
	ld a, $83 ; $40db
	ldh [rSC], a ; $40dd
	pop af ; $40df
	ei ; $40e0
	call WaitSerialTransfer ; $40e1
	call ShortDelay ; $40e4
	call ShortDelay ; $40e7
	di ; $40ea
	ldh a, [$ffc0] ; $40eb
	ei ; $40ed
	cp a, $c4 ; $40ee
	jr z, Label_07_40f8 ; $40f0
	dec e ; $40f2
	jr nz, Label_07_40d1 ; $40f3
	call LinkErrorReset ; $40f5
Label_07_40f8:
	xor a, a ; $40f8
	ldh [$ffc6], a ; $40f9
	ldh [$ffc7], a ; $40fb
	ld de, $0000 ; $40fd
	ld b, c ; $4100
Label_07_4101:
	ld hl, $ce40 ; $4101
	ldh a, [$ffc7] ; $4104
	add a, l ; $4106
	ld l, a ; $4107
	jr nc, Label_07_410b ; $4108
	inc h ; $410a
Label_07_410b:
	ld a, [hl] ; $410b
	ldh [$ffc1], a ; $410c
Label_07_410e:
	ldh a, [$ffc1] ; $410e
	or a, $40 ; $4110
	ldh [rSB], a ; $4112
	push af ; $4114
	ld a, $03 ; $4115
	ldh [rSC], a ; $4117
	ld a, $83 ; $4119
	ldh [rSC], a ; $411b
	pop af ; $411d
	call WaitSerialTransfer ; $411e
	call ShortDelay ; $4121
	call ShortDelay ; $4124
	call PollSerialResponse ; $4127
	jr c, Label_07_410e ; $412a
	ld h, a ; $412c
	and a, $c0 ; $412d
	cp a, $80 ; $412f
	jr z, Label_07_4136 ; $4131
	call LinkErrorReset ; $4133
Label_07_4136:
	ld a, h ; $4136
	push af ; $4137
	ld hl, $cea0 ; $4138
	ldh a, [$ffc6] ; $413b
	add a, l ; $413d
	ld l, a ; $413e
	jr nc, Label_07_4142 ; $413f
	inc h ; $4141
Label_07_4142:
	pop af ; $4142
	and a, $3f ; $4143
	ld [hl], a ; $4145
	add a, e ; $4146
	ld e, a ; $4147
	jr nc, Label_07_414b ; $4148
	inc d ; $414a
Label_07_414b:
	xor a, a ; $414b
	ldh [$ffc8], a ; $414c
	ld hl, $ffc7 ; $414e
	inc [hl] ; $4151
	ld hl, $ffc6 ; $4152
	inc [hl] ; $4155
	dec b ; $4156
	jr nz, Label_07_4101 ; $4157
	ld a, $c5 ; $4159
	ld b, $c6 ; $415b
	call SendByteAwaitEchoMaster ; $415d
	jr nc, Label_07_4165 ; $4160
	call LinkErrorReset ; $4162
Label_07_4165:
	ld a, $cc ; $4165
	call SendByteGetReplyMaster ; $4167
	cp a, $cc ; $416a
	jr z, Label_07_4171 ; $416c
	call LinkErrorReset ; $416e
Label_07_4171:
	call ExchangeChecksumMaster ; $4171
	ldh a, [$ffe5] ; $4174
	ld e, a ; $4176
	ldh a, [$ffe6] ; $4177
	ld d, a ; $4179
	push hl ; $417a
	push de ; $417b
	ld a, l ; $417c
	sub a, e ; $417d
	ld l, a ; $417e
	ld a, h ; $417f
	sbc a, d ; $4180
	ld h, a ; $4181
	ld a, h ; $4182
	or a, l ; $4183
	pop de ; $4184
	pop hl ; $4185
	jp z, Label_07_419b ; $4186
	ld a, $cb ; $4189
	call SendByteGetReplyMaster ; $418b
	cp a, $cd ; $418e
	jp z, Label_07_40c3 ; $4190
	cp a, $cb ; $4193
	jp z, Label_07_40c3 ; $4195
	call LinkErrorReset ; $4198
Label_07_419b:
	ld a, $cd ; $419b
	call SendByteGetReplyMaster ; $419d
	cp a, $cd ; $41a0
	jr z, Label_07_41ac ; $41a2
	cp a, $cb ; $41a4
	jp z, Label_07_40c3 ; $41a6
	call LinkErrorReset ; $41a9
Label_07_41ac:
	pop hl ; $41ac
	pop de ; $41ad
	pop bc ; $41ae
	pop af ; $41af
	ret ; $41b0
	push af ; $41b1
	push bc ; $41b2
	ld bc, $007d ; $41b3
Label_07_41b6:
	dec bc ; $41b6
	ld a, c ; $41b7
	or a, b ; $41b8
	jr nz, Label_07_41b6 ; $41b9
	ldh a, [$ffe8] ; $41bb
	dec a ; $41bd
	bit 7, a ; $41be
	jr z, Label_07_41ea ; $41c0
	push af ; $41c2
	push bc ; $41c3
	push de ; $41c4
	push hl ; $41c5
	di ; $41c6
	ldh a, [$ffc0] ; $41c7
	ei ; $41c9
	push af ; $41ca
	call UpdateSoundEngine ; $41cb
	ld a, $d3 ; $41ce
	ldh [rSB], a ; $41d0
	push af ; $41d2
	ld a, $03 ; $41d3
	ldh [rSC], a ; $41d5
	ld a, $83 ; $41d7
	ldh [rSC], a ; $41d9
	pop af ; $41db
	call WaitSerialTransfer ; $41dc
	pop af ; $41df
	di ; $41e0
	ldh [$ffc0], a ; $41e1
	ei ; $41e3
	pop hl ; $41e4
	pop de ; $41e5
	pop bc ; $41e6
	pop af ; $41e7
	ld a, $0f ; $41e8
Label_07_41ea:
	ldh [$ffe8], a ; $41ea
	pop bc ; $41ec
	pop af ; $41ed
	ret ; $41ee
ExchangeNibbleBlockSlave:
	push af ; $41ef
	push bc ; $41f0
	push de ; $41f1
	push hl ; $41f2
	call UnpackBytesToNibbles ; $41f3
	jr nc, Label_07_41fb ; $41f6
	call LinkErrorReset ; $41f8
Label_07_41fb:
	ld c, a ; $41fb
	call ComputeNibbleBufferChecksum ; $41fc
Label_07_41ff:
	di ; $41ff
	ld a, $c4 ; $4200
	ldh [rSB], a ; $4202
	push af ; $4204
	ld a, $02 ; $4205
	ldh [rSC], a ; $4207
	ld a, $82 ; $4209
	ldh [rSC], a ; $420b
	pop af ; $420d
	ei ; $420e
	nop ; $420f
	nop ; $4210
	di ; $4211
	ld a, [$ce40] ; $4212
	or a, $80 ; $4215
	ldh [$ffc1], a ; $4217
	ei ; $4219
	ld e, $64 ; $421a
Label_07_421c:
	call WaitSerialTransfer ; $421c
	jr c, Label_07_422c ; $421f
	di ; $4221
	ldh a, [$ffc0] ; $4222
	ei ; $4224
	cp a, $c3 ; $4225
	jr z, Label_07_422f ; $4227
	dec e ; $4229
	jr nz, Label_07_421c ; $422a
Label_07_422c:
	call LinkErrorReset ; $422c
Label_07_422f:
	ld a, $01 ; $422f
	ldh [$ffc7], a ; $4231
	xor a, a ; $4233
	ldh [$ffc6], a ; $4234
	ld de, $0000 ; $4236
	ld b, c ; $4239
	dec b ; $423a
Label_07_423b:
	di ; $423b
	ldh a, [rIF] ; $423c
	and a, $f7 ; $423e
	ldh [rIF], a ; $4240
	xor a, a ; $4242
	ldh [$ffd7], a ; $4243
	ld hl, $ce40 ; $4245
	ldh a, [$ffc7] ; $4248
	add a, l ; $424a
	ld l, a ; $424b
	jr nc, Label_07_424f ; $424c
	inc h ; $424e
Label_07_424f:
	ld a, [hl] ; $424f
	or a, $80 ; $4250
	ldh [$ffc1], a ; $4252
	ei ; $4254
	call WaitSerialTransfer ; $4255
	jr nc, Label_07_425d ; $4258
	call LinkErrorReset ; $425a
Label_07_425d:
	call PollSerialResponse ; $425d
	jr nc, Label_07_4265 ; $4260
	call LinkErrorReset ; $4262
Label_07_4265:
	ld c, a ; $4265
	and a, $c0 ; $4266
	cp a, $40 ; $4268
	jr z, Label_07_426f ; $426a
	call LinkErrorReset ; $426c
Label_07_426f:
	ld hl, $cea0 ; $426f
	ldh a, [$ffc6] ; $4272
	add a, l ; $4274
	ld l, a ; $4275
	jr nc, Label_07_4279 ; $4276
	inc h ; $4278
Label_07_4279:
	ld a, c ; $4279
	and a, $3f ; $427a
	ld [hl], a ; $427c
	add a, e ; $427d
	ld e, a ; $427e
	jr nc, Label_07_4282 ; $427f
	inc d ; $4281
Label_07_4282:
	xor a, a ; $4282
	ldh [$ffc8], a ; $4283
	ld hl, $ffc7 ; $4285
	inc [hl] ; $4288
	ld hl, $ffc6 ; $4289
	inc [hl] ; $428c
	dec b ; $428d
	jr nz, Label_07_423b ; $428e
	di ; $4290
	ldh a, [rIF] ; $4291
	and a, $f7 ; $4293
	ldh [rIF], a ; $4295
	xor a, a ; $4297
	ldh [$ffd7], a ; $4298
	ld a, $c6 ; $429a
	ldh [$ffc1], a ; $429c
	ei ; $429e
	call WaitSerialTransfer ; $429f
	di ; $42a2
	ldh a, [$ffc0] ; $42a3
	ei ; $42a5
	ld b, a ; $42a6
	and a, $c0 ; $42a7
	cp a, $40 ; $42a9
	jr z, Label_07_42b0 ; $42ab
	call LinkErrorReset ; $42ad
Label_07_42b0:
	ld hl, $cea0 ; $42b0
	ldh a, [$ffc6] ; $42b3
	add a, l ; $42b5
	ld l, a ; $42b6
	jr nc, Label_07_42ba ; $42b7
	inc h ; $42b9
Label_07_42ba:
	ld a, b ; $42ba
	and a, $3f ; $42bb
	ld [hl], a ; $42bd
	add a, e ; $42be
	ld e, a ; $42bf
	jr nc, Label_07_42c3 ; $42c0
	inc d ; $42c2
Label_07_42c3:
	ld a, $cc ; $42c3
	call SendByteGetReplySlave ; $42c5
	cp a, $c5 ; $42c8
	jr z, Label_07_42cf ; $42ca
	call LinkErrorReset ; $42cc
Label_07_42cf:
	call ExchangeChecksumSlave ; $42cf
	ldh a, [$ffe5] ; $42d2
	ld e, a ; $42d4
	ldh a, [$ffe6] ; $42d5
	ld d, a ; $42d7
	push hl ; $42d8
	push de ; $42d9
	ld a, l ; $42da
	sub a, e ; $42db
	ld l, a ; $42dc
	ld a, h ; $42dd
	sbc a, d ; $42de
	ld h, a ; $42df
	ld a, h ; $42e0
	or a, l ; $42e1
	pop de ; $42e2
	pop hl ; $42e3
	jp z, Label_07_4312 ; $42e4
	di ; $42e7
	ldh a, [rIF] ; $42e8
	and a, $f7 ; $42ea
	ldh [rIF], a ; $42ec
	xor a, a ; $42ee
	ldh [$ffd7], a ; $42ef
	ld a, $cb ; $42f1
	ldh [rSB], a ; $42f3
	push af ; $42f5
	ld a, $02 ; $42f6
	ldh [rSC], a ; $42f8
	ld a, $82 ; $42fa
	ldh [rSC], a ; $42fc
	pop af ; $42fe
	ei ; $42ff
	ld a, $cb ; $4300
	call SendByteGetReplySlave ; $4302
	cp a, $cb ; $4305
	jp z, Label_07_41ff ; $4307
	cp a, $cd ; $430a
	jp z, Label_07_41ff ; $430c
	call LinkErrorReset ; $430f
Label_07_4312:
	ld a, $cd ; $4312
	call SendByteGetReplySlave ; $4314
	cp a, $cb ; $4317
	jp z, Label_07_41ff ; $4319
	cp a, $cd ; $431c
	jr z, Label_07_4323 ; $431e
	call LinkErrorReset ; $4320
Label_07_4323:
	pop hl ; $4323
	pop de ; $4324
	pop bc ; $4325
	pop af ; $4326
	ret ; $4327
ExchangeChecksumMaster:
	push bc ; $4328
	ld hl, $0000 ; $4329
	ld a, d ; $432c
	swap a ; $432d
	and a, $0f ; $432f
	or a, $40 ; $4331
	call SendByteGetReplyMaster ; $4333
	ld b, a ; $4336
	and a, $c0 ; $4337
	cp a, $80 ; $4339
	jr z, Label_07_4340 ; $433b
	call LinkErrorReset ; $433d
Label_07_4340:
	call ShiftNibbleIntoChecksum ; $4340
	ld a, d ; $4343
	and a, $0f ; $4344
	or a, $40 ; $4346
	call SendByteGetReplyMaster ; $4348
	ld b, a ; $434b
	and a, $c0 ; $434c
	cp a, $80 ; $434e
	jr z, Label_07_4355 ; $4350
	call LinkErrorReset ; $4352
Label_07_4355:
	call ShiftNibbleIntoChecksum ; $4355
	ld a, e ; $4358
	swap a ; $4359
	and a, $0f ; $435b
	or a, $40 ; $435d
	call SendByteGetReplyMaster ; $435f
	ld b, a ; $4362
	and a, $c0 ; $4363
	cp a, $80 ; $4365
	jr z, Label_07_436c ; $4367
	call LinkErrorReset ; $4369
Label_07_436c:
	call ShiftNibbleIntoChecksum ; $436c
	ld a, e ; $436f
	and a, $0f ; $4370
	or a, $40 ; $4372
	call SendByteGetReplyMaster ; $4374
	ld b, a ; $4377
	and a, $c0 ; $4378
	cp a, $80 ; $437a
	jr z, Label_07_4381 ; $437c
	call LinkErrorReset ; $437e
Label_07_4381:
	call ShiftNibbleIntoChecksum ; $4381
	call ShortDelay ; $4384
	call ShortDelay ; $4387
	pop bc ; $438a
	ret ; $438b
ExchangeChecksumSlave:
	push bc ; $438c
	ld hl, $0000 ; $438d
	ld a, d ; $4390
	swap a ; $4391
	and a, $0f ; $4393
	or a, $80 ; $4395
	call SendByteGetReplySlave ; $4397
	cp a, $cc ; $439a
	jr z, Label_07_43a1 ; $439c
	call LinkErrorReset ; $439e
Label_07_43a1:
	ld a, d ; $43a1
	and a, $0f ; $43a2
	or a, $80 ; $43a4
	call SendByteGetReplySlave ; $43a6
	ld b, a ; $43a9
	and a, $c0 ; $43aa
	cp a, $40 ; $43ac
	jr z, Label_07_43b3 ; $43ae
	call LinkErrorReset ; $43b0
Label_07_43b3:
	call ShiftNibbleIntoChecksum ; $43b3
	ld a, e ; $43b6
	swap a ; $43b7
	and a, $0f ; $43b9
	or a, $80 ; $43bb
	call SendByteGetReplySlave ; $43bd
	ld b, a ; $43c0
	and a, $c0 ; $43c1
	cp a, $40 ; $43c3
	jr z, Label_07_43ca ; $43c5
	call LinkErrorReset ; $43c7
Label_07_43ca:
	call ShiftNibbleIntoChecksum ; $43ca
	ld a, e ; $43cd
	and a, $0f ; $43ce
	or a, $80 ; $43d0
	call SendByteGetReplySlave ; $43d2
	ld b, a ; $43d5
	and a, $c0 ; $43d6
	cp a, $40 ; $43d8
	jr z, Label_07_43df ; $43da
	call LinkErrorReset ; $43dc
Label_07_43df:
	call ShiftNibbleIntoChecksum ; $43df
	ld a, $cd ; $43e2
	call SendByteGetReplySlave ; $43e4
	ld b, a ; $43e7
	and a, $c0 ; $43e8
	cp a, $40 ; $43ea
	jr z, Label_07_43f1 ; $43ec
	call LinkErrorReset ; $43ee
Label_07_43f1:
	call ShiftNibbleIntoChecksum ; $43f1
	pop bc ; $43f4
	ret ; $43f5
ShiftNibbleIntoChecksum:
	sla l ; $43f6
	rl h ; $43f8
	sla l ; $43fa
	rl h ; $43fc
	sla l ; $43fe
	rl h ; $4400
	sla l ; $4402
	rl h ; $4404
	ld a, b ; $4406
	and a, $0f ; $4407
	or a, l ; $4409
	ld l, a ; $440a
	ret ; $440b
ComputeNibbleBufferChecksum:
	push af ; $440c
	push bc ; $440d
	push de ; $440e
	push hl ; $440f
	ld hl, $ce40 ; $4410
	ld de, $0000 ; $4413
Label_07_4416:
	ld a, [hl+] ; $4416
	add a, e ; $4417
	ld e, a ; $4418
	jr nc, Label_07_441c ; $4419
	inc d ; $441b
Label_07_441c:
	dec c ; $441c
	jr nz, Label_07_4416 ; $441d
	ld a, e ; $441f
	ldh [$ffe5], a ; $4420
	ld a, d ; $4422
	ldh [$ffe6], a ; $4423
	pop hl ; $4425
	pop de ; $4426
	pop bc ; $4427
	pop af ; $4428
	ret ; $4429
SendNibbleBlockSlave:
	push af ; $442a
	push bc ; $442b
	push de ; $442c
	push hl ; $442d
	call UnpackBytesToNibbles ; $442e
	jr nc, Label_07_4437 ; $4431
	scf ; $4433
	jp Label_07_44bc ; $4434
Label_07_4437:
	ld c, a ; $4437
Label_07_4438:
	ld a, $c3 ; $4438
	ld b, $c4 ; $443a
	call SendByteAwaitEchoSlave ; $443c
	jr c, Label_07_4438 ; $443f
	ld hl, $ce40 ; $4441
	ld de, $0000 ; $4444
	ld b, c ; $4447
Label_07_4448:
	ld a, [hl+] ; $4448
	ldh [$ffc1], a ; $4449
	add a, e ; $444b
	ld e, a ; $444c
	jr nc, Label_07_4450 ; $444d
	inc d ; $444f
Label_07_4450:
	di ; $4450
	ldh a, [$ffc1] ; $4451
	or a, $80 ; $4453
	ldh [rSB], a ; $4455
	push af ; $4457
	ld a, $02 ; $4458
	ldh [rSC], a ; $445a
	ld a, $82 ; $445c
	ldh [rSC], a ; $445e
	pop af ; $4460
	ei ; $4461
	call WaitSerialTransfer ; $4462
	call PollSerialResponse ; $4465
	jr c, Label_07_4450 ; $4468
	xor a, a ; $446a
	ldh [$ffc8], a ; $446b
	dec b ; $446d
	jr nz, Label_07_4448 ; $446e
Label_07_4470:
	ld a, $c5 ; $4470
	ld b, $c6 ; $4472
	call SendByteAwaitEchoSlave ; $4474
	jr c, Label_07_4470 ; $4477
	ld hl, $0000 ; $4479
Label_07_447c:
	ld a, $cc ; $447c
	call SendByteGetReplySlave ; $447e
	cp a, $cd ; $4481
	jr z, Label_07_44a3 ; $4483
	ld b, a ; $4485
	and a, $c0 ; $4486
	cp a, $40 ; $4488
	jr nz, Label_07_447c ; $448a
	sla l ; $448c
	rl h ; $448e
	sla l ; $4490
	rl h ; $4492
	sla l ; $4494
	rl h ; $4496
	sla l ; $4498
	rl h ; $449a
	ld a, b ; $449c
	and a, $0f ; $449d
	or a, l ; $449f
	ld l, a ; $44a0
	jr Label_07_447c ; $44a1
Label_07_44a3:
	push hl ; $44a3
	push de ; $44a4
	ld a, l ; $44a5
	sub a, e ; $44a6
	ld l, a ; $44a7
	ld a, h ; $44a8
	sbc a, d ; $44a9
	ld h, a ; $44aa
	ld a, h ; $44ab
	or a, l ; $44ac
	pop de ; $44ad
	pop hl ; $44ae
	jr nz, Label_07_4438 ; $44af
Label_07_44b1:
	ld a, $80 ; $44b1
	call SendByteGetReplySlave ; $44b3
	cp a, $40 ; $44b6
	jr nz, Label_07_44b1 ; $44b8
	scf ; $44ba
	ccf ; $44bb
Label_07_44bc:
	pop hl ; $44bc
	pop de ; $44bd
	pop bc ; $44be
	pop af ; $44bf
	ret ; $44c0
ReceiveNibbleBlockMaster:
	push af ; $44c1
	push bc ; $44c2
	push de ; $44c3
	push hl ; $44c4
	call EnableSerialAndVBlankInterrupts ; $44c5
Label_07_44c8:
	ld a, $c4 ; $44c8
	ld b, $c3 ; $44ca
	call SendByteAwaitEchoMaster ; $44cc
	jr c, Label_07_44c8 ; $44cf
	ld hl, $cea0 ; $44d1
	ld de, $0000 ; $44d4
	ld b, $00 ; $44d7
Label_07_44d9:
	ld a, $40 ; $44d9
	ldh [rSB], a ; $44db
	push af ; $44dd
	ld a, $03 ; $44de
	ldh [rSC], a ; $44e0
	ld a, $83 ; $44e2
	ldh [rSC], a ; $44e4
	pop af ; $44e6
	call ShortDelay ; $44e7
	call PollSerialResponse ; $44ea
	jr c, Label_07_44d9 ; $44ed
	cp a, $c5 ; $44ef
	jr z, Label_07_4507 ; $44f1
	and a, $3f ; $44f3
	ld [hl+], a ; $44f5
	add a, e ; $44f6
	ld e, a ; $44f7
	jr nc, Label_07_44fb ; $44f8
	inc d ; $44fa
Label_07_44fb:
	xor a, a ; $44fb
	ldh [$ffc8], a ; $44fc
	inc b ; $44fe
	ld a, b ; $44ff
	cp a, $40 ; $4500
	jr c, Label_07_44d9 ; $4502
	call LinkErrorReset ; $4504
Label_07_4507:
	ld a, $c6 ; $4507
	call SendByteGetReplyMaster ; $4509
	ld a, d ; $450c
	or a, $40 ; $450d
	call SendByteGetReplyMaster ; $450f
	ld a, e ; $4512
	or a, $40 ; $4513
	call SendByteGetReplyMaster ; $4515
	ld a, $cd ; $4518
	call SendByteGetReplyMaster ; $451a
Label_07_451d:
	ld a, $40 ; $451d
	call SendByteGetReplyMaster ; $451f
	cp a, $c3 ; $4522
	jr z, Label_07_44c8 ; $4524
	cp a, $80 ; $4526
	jr nz, Label_07_451d ; $4528
	pop hl ; $452a
	pop de ; $452b
	pop bc ; $452c
	pop af ; $452d
	ret ; $452e
PollSerialResponse:
	push bc ; $452f
	di ; $4530
	ldh a, [$ffc0] ; $4531
	ld b, a ; $4533
	cp a, $00 ; $4534
	jr z, Label_07_4543 ; $4536
	cp a, $ff ; $4538
	jr z, Label_07_4543 ; $453a
	xor a, a ; $453c
	ldh [$ffc8], a ; $453d
	scf ; $453f
	ccf ; $4540
	jr Label_07_4547 ; $4541
Label_07_4543:
	call IncrementLinkFrameCounter ; $4543
	scf ; $4546
Label_07_4547:
	ei ; $4547
	ld a, b ; $4548
	pop bc ; $4549
	ret ; $454a
SendByteAwaitEchoMaster:
	push bc ; $454b
	ldh [$ffc1], a ; $454c
	ld c, $14 ; $454e
Label_07_4550:
	di ; $4550
	ldh a, [$ffc1] ; $4551
	ldh [rSB], a ; $4553
	push af ; $4555
	ld a, $03 ; $4556
	ldh [rSC], a ; $4558
	ld a, $83 ; $455a
	ldh [rSC], a ; $455c
	pop af ; $455e
	ei ; $455f
	call WaitSerialTransfer ; $4560
	call ShortDelay ; $4563
	call ShortDelay ; $4566
	di ; $4569
	ldh a, [$ffc0] ; $456a
	ei ; $456c
	cp a, $00 ; $456d
	jr z, Label_07_4581 ; $456f
	cp a, $ff ; $4571
	jr z, Label_07_4581 ; $4573
	cp a, b ; $4575
	jr z, Label_07_4586 ; $4576
	xor a, a ; $4578
	ldh [$ffc8], a ; $4579
	dec c ; $457b
	jr nz, Label_07_4550 ; $457c
	scf ; $457e
	jr Label_07_4588 ; $457f
Label_07_4581:
	call IncrementLinkFrameCounter ; $4581
	jr Label_07_4550 ; $4584
Label_07_4586:
	scf ; $4586
	ccf ; $4587
Label_07_4588:
	pop bc ; $4588
	ret ; $4589
SendByteAwaitEchoSlave:
	push bc ; $458a
	ldh [$ffc1], a ; $458b
	ld c, $1e ; $458d
Label_07_458f:
	di ; $458f
	ldh a, [$ffc1] ; $4590
	ldh [rSB], a ; $4592
	push af ; $4594
	ld a, $02 ; $4595
	ldh [rSC], a ; $4597
	ld a, $82 ; $4599
	ldh [rSC], a ; $459b
	pop af ; $459d
	ei ; $459e
	call WaitSerialTransfer ; $459f
	ldh a, [$ffc0] ; $45a2
	cp a, $00 ; $45a4
	jr z, Label_07_45b8 ; $45a6
	cp a, $ff ; $45a8
	jr z, Label_07_45b8 ; $45aa
	cp a, b ; $45ac
	jr z, Label_07_45bd ; $45ad
	xor a, a ; $45af
	ldh [$ffc8], a ; $45b0
	dec c ; $45b2
	jr nz, Label_07_458f ; $45b3
	scf ; $45b5
	jr Label_07_45bf ; $45b6
Label_07_45b8:
	call IncrementLinkFrameCounter ; $45b8
	jr Label_07_458f ; $45bb
Label_07_45bd:
	scf ; $45bd
	ccf ; $45be
Label_07_45bf:
	pop bc ; $45bf
	ret ; $45c0
SendByteGetReplyMaster:
	push bc ; $45c1
	ldh [$ffc1], a ; $45c2
	ld c, $64 ; $45c4
Label_07_45c6:
	ei ; $45c6
	nop ; $45c7
	di ; $45c8
	ldh a, [$ffc1] ; $45c9
	ldh [rSB], a ; $45cb
	push af ; $45cd
	ld a, $03 ; $45ce
	ldh [rSC], a ; $45d0
	ld a, $83 ; $45d2
	ldh [rSC], a ; $45d4
	pop af ; $45d6
	ei ; $45d7
	call WaitSerialTransfer ; $45d8
	call ShortDelay ; $45db
	call ShortDelay ; $45de
	di ; $45e1
	ldh a, [$ffc0] ; $45e2
	cp a, $00 ; $45e4
	jr z, Label_07_45ee ; $45e6
	cp a, $ff ; $45e8
	jr z, Label_07_45ee ; $45ea
	jr Label_07_45f5 ; $45ec
Label_07_45ee:
	dec c ; $45ee
	jr nz, Label_07_45c6 ; $45ef
	ei ; $45f1
	call LinkErrorReset ; $45f2
Label_07_45f5:
	ei ; $45f5
	pop bc ; $45f6
	ret ; $45f7
	push bc ; $45f8
	ldh [$ffc1], a ; $45f9
Label_07_45fb:
	ldh a, [$ffc1] ; $45fb
	ldh [rSB], a ; $45fd
	push af ; $45ff
	ld a, $03 ; $4600
	ldh [rSC], a ; $4602
	ld a, $83 ; $4604
	ldh [rSC], a ; $4606
	pop af ; $4608
	call AdvanceFrame ; $4609
	ldh a, [$ffc0] ; $460c
	cp a, $00 ; $460e
	jr z, Label_07_461d ; $4610
	cp a, $ff ; $4612
	jr z, Label_07_461d ; $4614
	ld b, a ; $4616
	xor a, a ; $4617
	ldh [$ffc8], a ; $4618
	ld a, b ; $461a
	jr Label_07_4622 ; $461b
Label_07_461d:
	call IncrementLinkFrameCounter ; $461d
	jr Label_07_45fb ; $4620
Label_07_4622:
	pop bc ; $4622
	ret ; $4623
SendByteGetReplySlave:
	push bc ; $4624
	di ; $4625
	ldh [$ffe0], a ; $4626
	ldh [$ffc1], a ; $4628
	ldh a, [rIF] ; $462a
	and a, $f7 ; $462c
	ldh [rIF], a ; $462e
	xor a, a ; $4630
	ldh [$ffd7], a ; $4631
	ei ; $4633
	ld c, $64 ; $4634
Label_07_4636:
	call WaitSerialTransfer ; $4636
	jr c, Label_07_464e ; $4639
	di ; $463b
	ldh a, [$ffc0] ; $463c
	ei ; $463e
	cp a, $00 ; $463f
	jr z, Label_07_464e ; $4641
	cp a, $ff ; $4643
	jr z, Label_07_464e ; $4645
	ld b, a ; $4647
	xor a, a ; $4648
	ldh [$ffc8], a ; $4649
	ld a, b ; $464b
	jr Label_07_4654 ; $464c
Label_07_464e:
	dec c ; $464e
	jr nz, Label_07_4636 ; $464f
	call LinkErrorReset ; $4651
Label_07_4654:
	pop bc ; $4654
	ret ; $4655
UnpackBytesToNibbles:
	ld hl, $ce40 ; $4656
	ld a, c ; $4659
	add a, a ; $465a
	cp a, $5f ; $465b
	jr c, Label_07_4664 ; $465d
	xor a, a ; $465f
	scf ; $4660
	jp Label_07_467e ; $4661
Label_07_4664:
	ld c, a ; $4664
	ld b, $00 ; $4665
Label_07_4667:
	ld a, [de] ; $4667
	bit 0, b ; $4668
	jr nz, Label_07_4672 ; $466a
	swap a ; $466c
	and a, $0f ; $466e
	jr Label_07_4675 ; $4670
Label_07_4672:
	and a, $0f ; $4672
	inc de ; $4674
Label_07_4675:
	ld [hl+], a ; $4675
	inc b ; $4676
	ld a, b ; $4677
	cp a, c ; $4678
	jr nz, Label_07_4667 ; $4679
	ld a, c ; $467b
	scf ; $467c
	ccf ; $467d
Label_07_467e:
	ret ; $467e
ExchangeLinkFrameByteMaster:
	di ; $467f
	ldh a, [rLY] ; $4680
	ei ; $4682
	cp a, $8c ; $4683
	jr nz, ExchangeLinkFrameByteMaster ; $4685
	di ; $4687
	ldh a, [$ffc1] ; $4688
	ldh [rSB], a ; $468a
	push af ; $468c
	ld a, $03 ; $468d
	ldh [rSC], a ; $468f
	ld a, $83 ; $4691
	ldh [rSC], a ; $4693
	pop af ; $4695
	ei ; $4696
	call AdvanceFrame ; $4697
	ldh a, [$ffc0] ; $469a
	ld b, a ; $469c
	cp a, $00 ; $469d
	jr z, Label_07_46af ; $469f
	cp a, $ff ; $46a1
	jr z, Label_07_46c4 ; $46a3
	and a, $c0 ; $46a5
	cp a, $80 ; $46a7
	jr z, Label_07_46c7 ; $46a9
	cp a, $40 ; $46ab
	jr z, Label_07_46c7 ; $46ad
Label_07_46af:
	call LinkErrorReset ; $46af
	ld hl, $ffc8 ; $46b2
	inc [hl] ; $46b5
	ld a, [hl] ; $46b6
	cp a, $0a ; $46b7
	jr nc, Label_07_46c1 ; $46b9
	call WaitVBlank ; $46bb
	jp ExchangeLinkFrameByteMaster ; $46be
Label_07_46c1:
	call LinkErrorReset ; $46c1
Label_07_46c4:
	call LinkErrorReset ; $46c4
Label_07_46c7:
	ldh a, [$ffdb] ; $46c7
	cp a, b ; $46c9
	jr nz, Label_07_46e6 ; $46ca
	and a, $3f ; $46cc
	ld hl, $ffc8 ; $46ce
	inc [hl] ; $46d1
	ld a, [hl] ; $46d2
	cp a, $02 ; $46d3
	jr nc, Label_07_46e0 ; $46d5
	call WaitVBlank ; $46d7
	call WaitVBlank ; $46da
	jp ExchangeLinkFrameByteMaster ; $46dd
Label_07_46e0:
	call InitSerialLink ; $46e0
	call LinkErrorReset ; $46e3
Label_07_46e6:
	ld a, b ; $46e6
	ldh [$ffdb], a ; $46e7
	ldh [$ffda], a ; $46e9
	xor a, a ; $46eb
	ldh [$ffc8], a ; $46ec
	ret ; $46ee
ExchangeLinkFrameByteSlave:
	call AwaitSerialByte ; $46ef
	jr c, Label_07_470c ; $46f2
	push bc ; $46f4
	call AdvanceFrame ; $46f5
	pop bc ; $46f8
	di ; $46f9
	cp a, $00 ; $46fa
	jr z, Label_07_470c ; $46fc
	cp a, $ff ; $46fe
	jr z, Label_07_470f ; $4700
	and a, $c0 ; $4702
	cp a, $40 ; $4704
	jr z, Label_07_4712 ; $4706
	cp a, $80 ; $4708
	jr z, Label_07_4712 ; $470a
Label_07_470c:
	call LinkErrorReset ; $470c
Label_07_470f:
	call LinkErrorReset ; $470f
Label_07_4712:
	ldh a, [$ffdb] ; $4712
	cp a, b ; $4714
	jr nz, Label_07_471b ; $4715
	and a, $3f ; $4717
	jr Label_07_470c ; $4719
Label_07_471b:
	ld a, b ; $471b
	ldh [$ffdb], a ; $471c
	ldh [$ffda], a ; $471e
	xor a, a ; $4720
	ldh [$ffc8], a ; $4721
	ei ; $4723
	ret ; $4724
SyncLinkFrameMaster:
	push bc ; $4725
	push hl ; $4726
	call PrepareLinkStatePayload ; $4727
	call ExchangeLinkFrameByteMaster ; $472a
	call SerialDecodeInput ; $472d
	call SerialEncodeInput ; $4730
	pop hl ; $4733
	pop bc ; $4734
	ret ; $4735
SyncLinkFrameSlave:
	push bc ; $4736
	push hl ; $4737
	call PrepareLinkStatePayload ; $4738
	call ExchangeLinkFrameByteSlave ; $473b
	call SerialDecodeInput ; $473e
	call SerialEncodeInput ; $4741
	pop hl ; $4744
	pop bc ; $4745
	ret ; $4746
SyncLinkFrame:
	push af ; $4747
	push bc ; $4748
	push de ; $4749
	push hl ; $474a
	ld hl, $ffe9 ; $474b
	inc [hl] ; $474e
	ldh a, [$ffc2] ; $474f
	cp a, $02 ; $4751
	jr z, Label_07_475a ; $4753
	call SyncLinkFrameMaster ; $4755
	jr Label_07_475d ; $4758
Label_07_475a:
	call SyncLinkFrameSlave ; $475a
Label_07_475d:
	pop hl ; $475d
	pop de ; $475e
	pop bc ; $475f
	pop af ; $4760
	ret ; $4761
RunLinkMatchFrame:
	push af ; $4762
	push bc ; $4763
	push de ; $4764
	push hl ; $4765
	ld hl, $ffe9 ; $4766
	inc [hl] ; $4769
	ldh a, [$ffc2] ; $476a
	cp a, $02 ; $476c
	jr z, Label_07_4775 ; $476e
	call RunLinkMatchFrameMaster ; $4770
	jr Label_07_4778 ; $4773
Label_07_4775:
	call RunLinkMatchFrameSlave ; $4775
Label_07_4778:
	pop hl ; $4778
	pop de ; $4779
	pop bc ; $477a
	pop af ; $477b
	ret ; $477c
ExchangeLinkReadySignal:
	push af ; $477d
	push bc ; $477e
	ld c, $64 ; $477f
	ldh a, [$ffc2] ; $4781
	cp a, $02 ; $4783
	jr z, Label_07_4799 ; $4785
	cp a, $01 ; $4787
	jr z, Label_07_478e ; $4789
	call LinkErrorReset ; $478b
Label_07_478e:
	call ShortDelay ; $478e
	dec c ; $4791
	jr nz, Label_07_478e ; $4792
	call ExchangeReadyTokenMaster ; $4794
	jr Label_07_479c ; $4797
Label_07_4799:
	call ExchangeReadyTokenSlave ; $4799
Label_07_479c:
	pop bc ; $479c
	pop af ; $479d
	ret ; $479e
ExchangeReadyTokenMaster:
	push af ; $479f
	push de ; $47a0
	ldh a, [rSC] ; $47a1
	and a, $7f ; $47a3
	ldh [rSC], a ; $47a5
	ld de, $2710 ; $47a7
Label_07_47aa:
	ldh a, [rSC] ; $47aa
	bit 7, a ; $47ac
	jr nz, Label_07_47aa ; $47ae
	di ; $47b0
	ld a, $0b ; $47b1
	or a, $40 ; $47b3
	ldh [rSB], a ; $47b5
	push af ; $47b7
	ld a, $03 ; $47b8
	ldh [rSC], a ; $47ba
	ld a, $83 ; $47bc
	ldh [rSC], a ; $47be
	pop af ; $47c0
	ei ; $47c1
	call ShortDelay ; $47c2
	ldh a, [$ffc0] ; $47c5
	and a, $3f ; $47c7
	cp a, $0a ; $47c9
	jr z, Label_07_47d5 ; $47cb
	dec de ; $47cd
	ld a, d ; $47ce
	or a, e ; $47cf
	jr nz, Label_07_47aa ; $47d0
	call LinkErrorReset ; $47d2
Label_07_47d5:
	pop de ; $47d5
	pop af ; $47d6
	ret ; $47d7
ExchangeReadyTokenSlave:
	push af ; $47d8
	push de ; $47d9
	ld de, $0003 ; $47da
	di ; $47dd
	ld a, $0a ; $47de
	or a, $80 ; $47e0
	ldh [$ffc1], a ; $47e2
	ldh [rSB], a ; $47e4
	push af ; $47e6
	ld a, $02 ; $47e7
	ldh [rSC], a ; $47e9
	ld a, $82 ; $47eb
	ldh [rSC], a ; $47ed
	pop af ; $47ef
	ei ; $47f0
Label_07_47f1:
	call WaitSerialTransfer ; $47f1
	ldh a, [$ffc0] ; $47f4
	and a, $3f ; $47f6
	cp a, $0b ; $47f8
	jr z, Label_07_4804 ; $47fa
	dec de ; $47fc
	ld a, d ; $47fd
	or a, e ; $47fe
	jr nz, Label_07_47f1 ; $47ff
	call LinkErrorReset ; $4801
Label_07_4804:
	pop de ; $4804
	pop af ; $4805
	ret ; $4806
RunLinkInputFrameMaster:
	push bc ; $4807
	push hl ; $4808
	call PrepareLinkInputPayload ; $4809
	call ExchangeLinkFrameByteMaster ; $480c
	call SerialDecodeInput ; $480f
	ldh a, [$ffd3] ; $4812
	call SoftResetIfABStartSelect ; $4814
	call SerialEncodeInput ; $4817
	pop bc ; $481a
	pop hl ; $481b
	ret ; $481c
RunLinkInputFrameSlave:
	push bc ; $481d
	push hl ; $481e
	call PrepareLinkInputPayload ; $481f
	call ExchangeLinkFrameByteSlave ; $4822
	call SerialDecodeInput ; $4825
	ldh a, [$ffd3] ; $4828
	call SoftResetIfABStartSelect ; $482a
	call SerialEncodeInput ; $482d
	pop hl ; $4830
	pop bc ; $4831
	ret ; $4832
RunLinkInputFrame:
	ld hl, $ffe9 ; $4833
	inc [hl] ; $4836
	ldh a, [$ffc2] ; $4837
	cp a, $02 ; $4839
	jr z, Label_07_4842 ; $483b
	call RunLinkInputFrameMaster ; $483d
	jr Label_07_4845 ; $4840
Label_07_4842:
	call RunLinkInputFrameSlave ; $4842
Label_07_4845:
	ret ; $4845
UpdateLinkSession:
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld a, [$c33f] ; $484a
	or a, a ; $484d
	jp z, Label_07_48f1 ; $484e
	ldh a, [$ffd8] ; $4851
	or a, a ; $4853
	jp nz, Label_07_48df ; $4854
	sound $00 ; $4857
	call DisableLCDSafely ; $4859
	ld a, $01 ; $485c
	ldh [$ffd8], a ; $485e
	farcall FarPtr_ExchangeLinkReadySignal ; $4860
	ldh a, [$ffc2] ; $4863
	cp a, $02 ; $4865
	jp z, Label_07_48a7 ; $4867
	cp a, $01 ; $486a
	jr z, Label_07_4871 ; $486c
	call LinkErrorReset ; $486e
Label_07_4871:
	ld a, $40 ; $4871
	ldh [$ffdc], a ; $4873
	call ShortDelay ; $4875
	call ShortDelay ; $4878
	call ShortDelay ; $487b
	call ShortDelay ; $487e
	call ShortDelay ; $4881
	call ShortDelay ; $4884
	call ShortDelay ; $4887
	call ShortDelay ; $488a
	call ShortDelay ; $488d
	call ShortDelay ; $4890
	call ShortDelay ; $4893
	call ShortDelay ; $4896
	call ShortDelay ; $4899
	call ShortDelay ; $489c
	call ShortDelay ; $489f
	call ShortDelay ; $48a2
	jr Label_07_48ae ; $48a5
Label_07_48a7:
	xor a, a ; $48a7
	ldh [$ffd7], a ; $48a8
	ld a, $80 ; $48aa
	ldh [$ffdc], a ; $48ac
Label_07_48ae:
	xor a, a ; $48ae
	ldh [$ffe2], a ; $48af
	call SerialEncodeInput ; $48b1
	farcall FarPtr_PrimeSlaveSerialReply ; $48b4
	xor a, a ; $48b7
	ldh [$ffde], a ; $48b8
	ld hl, $df1e ; $48ba
	wram_bank $04 ; $48bd
	ld [hl], $05 ; $48c3
	wram_bank $05 ; $48c5
	ld [hl], $06 ; $48cb
	wram_bank $04 ; $48cd
	xor a, a ; $48d3
	ldh [$ffc0], a ; $48d4
	ldh [$ffd7], a ; $48d6
	ld a, $01 ; $48d8
	ldh [$ffdf], a ; $48da
	call EnableLCD ; $48dc
Label_07_48df:
	xor a, a ; $48df
	ldh [$ffe9], a ; $48e0
	push af ; $48e2
	farcall FarPtr_SyncLinkFrame ; $48e3
	pop af ; $48e6
	push af ; $48e7
	farcall FarPtr_SyncLinkFrame ; $48e8
	pop af ; $48eb
	push af ; $48ec
	farcall FarPtr_SyncLinkFrame ; $48ed
	pop af ; $48f0
Label_07_48f1:
	pop hl ; $48f1
	pop de ; $48f2
	pop bc ; $48f3
	pop af ; $48f4
	ret ; $48f5
EndLinkSession:
	xor a, a ; $48f6
	ld [$c33f], a ; $48f7
	call InitSerialLink ; $48fa
	ret ; $48fd
ExchangeHandshakeBlockMaster:
	ld hl, wTextBuffer ; $48fe
	ld c, $28 ; $4901
	ld a, $02 ; $4903
Label_07_4905:
	ld [hl+], a ; $4905
	dec c ; $4906
	jr nz, Label_07_4905 ; $4907
	ld de, wTextBuffer ; $4909
	ld c, $28 ; $490c
	call ExchangeNibbleBlockMaster ; $490e
	ret ; $4911
ExchangeHandshakeBlockSlave:
	ld hl, wTextBuffer ; $4912
	ld c, $28 ; $4915
	ld a, $08 ; $4917
Label_07_4919:
	ld [hl+], a ; $4919
	dec c ; $491a
	jr nz, Label_07_4919 ; $491b
	ld de, wTextBuffer ; $491d
	ld c, $28 ; $4920
	call ExchangeNibbleBlockSlave ; $4922
	ret ; $4925
ExchangeLinkBlockToWram5:
	call DisableLCDSafely ; $4926
	di ; $4929
	ldh a, [rIF] ; $492a
	and a, $08 ; $492c
	ldh [rIF], a ; $492e
	ei ; $4930
	xor a, a ; $4931
	ldh [$ffd8], a ; $4932
	call LongDelay ; $4934
	call LongDelay ; $4937
	call LongDelay ; $493a
	ldh a, [$ffc2] ; $493d
	cp a, $02 ; $493f
	jr z, Label_07_494f ; $4941
	cp a, $01 ; $4943
	jr z, Label_07_494a ; $4945
	call LinkErrorReset ; $4947
Label_07_494a:
	call ExchangeHandshakeBlockMaster ; $494a
	jr Label_07_4952 ; $494d
Label_07_494f:
	call ExchangeHandshakeBlockSlave ; $494f
Label_07_4952:
	wram_bank $05 ; $4952
	ld hl, $c650 ; $4958
	ld c, $28 ; $495b
	call PackNibblesToBytes ; $495d
	ld a, $01 ; $4960
	ldh [$ffd8], a ; $4962
	di ; $4964
	ld a, $09 ; $4965
	ldh [rIF], a ; $4967
	ei ; $4969
	call EnableLCD ; $496a
	ret ; $496d
ExchangeLinkDataBlock:
	push hl ; $496e
	push de ; $496f
	push bc ; $4970
	call WaitVBlank ; $4971
	call DisableLCDSafely ; $4974
	di ; $4977
	ldh a, [rIF] ; $4978
	and a, $08 ; $497a
	ldh [rIF], a ; $497c
	ei ; $497e
	xor a, a ; $497f
	ldh [$ffd8], a ; $4980
	call LongDelay ; $4982
	call LongDelay ; $4985
	call LongDelay ; $4988
	pop bc ; $498b
	pop de ; $498c
	pop hl ; $498d
	ldh a, [$ffc2] ; $498e
	cp a, $02 ; $4990
	jr z, Label_07_49a0 ; $4992
	cp a, $01 ; $4994
	jr z, Label_07_499b ; $4996
	call LinkErrorReset ; $4998
Label_07_499b:
	call ExchangeNibbleBlockMaster ; $499b
	jr Label_07_49a3 ; $499e
Label_07_49a0:
	call ExchangeNibbleBlockSlave ; $49a0
Label_07_49a3:
	call PackNibblesToBytes ; $49a3
	di ; $49a6
	ld a, $09 ; $49a7
	ldh [rIF], a ; $49a9
	ei ; $49ab
	call EnableLCD ; $49ac
	ret ; $49af
PackNibblesToBytes:
	ld a, c ; $49b0
	add a, a ; $49b1
	cp a, $5f ; $49b2
	jr c, Label_07_49b9 ; $49b4
	call LinkErrorReset ; $49b6
Label_07_49b9:
	ld c, a ; $49b9
	ld b, $00 ; $49ba
	ld de, $cea0 ; $49bc
Label_07_49bf:
	ld a, b ; $49bf
	and a, $01 ; $49c0
	jr nz, Label_07_49cb ; $49c2
	ld a, [de] ; $49c4
	swap a ; $49c5
	and a, $f0 ; $49c7
	jr Label_07_49d5 ; $49c9
Label_07_49cb:
	ld a, [de] ; $49cb
	and a, $0f ; $49cc
	push bc ; $49ce
	ld b, a ; $49cf
	ld a, [hl] ; $49d0
	and a, $f0 ; $49d1
	or a, b ; $49d3
	pop bc ; $49d4
Label_07_49d5:
	ld [hl], a ; $49d5
	inc b ; $49d6
	inc de ; $49d7
	bit 0, b ; $49d8
	jr nz, Label_07_49dd ; $49da
	inc hl ; $49dc
Label_07_49dd:
	ld a, b ; $49dd
	cp a, c ; $49de
	jr c, Label_07_49bf ; $49df
	ret ; $49e1
PrimeSlaveSerialReply:
	ldh a, [$ffc2] ; $49e2
	cp a, $02 ; $49e4
	jr nz, Label_07_49f6 ; $49e6
	ld a, $40 ; $49e8
	ldh [rSB], a ; $49ea
	push af ; $49ec
	ld a, $02 ; $49ed
	ldh [rSC], a ; $49ef
	ld a, $82 ; $49f1
	ldh [rSC], a ; $49f3
	pop af ; $49f5
Label_07_49f6:
	ret ; $49f6
PrepareLinkStatePayload:
	push af ; $49f7
	ldh a, [$ffc1] ; $49f8
	and a, $c0 ; $49fa
	xor a, $c0 ; $49fc
	ldh [$ffdc], a ; $49fe
	ldh a, [$ffd6] ; $4a00
	ldh [$ffd5], a ; $4a02
	call ReadJoypadThunk ; $4a04
	ldh a, [hPlayerInputFlags] ; $4a07
	and a, $f0 ; $4a09
	ld c, a ; $4a0b
	call ComposeLinkStateByte ; $4a0c
	ldh [$ffd6], a ; $4a0f
	pop af ; $4a11
	ret ; $4a12
PrepareLinkInputPayload:
	push af ; $4a13
	ldh a, [$ffc1] ; $4a14
	and a, $c0 ; $4a16
	xor a, $c0 ; $4a18
	ldh [$ffdc], a ; $4a1a
	ldh a, [$ffd6] ; $4a1c
	ldh [$ffd5], a ; $4a1e
	call ReadJoypadThunk ; $4a20
	ldh a, [hInputPressed] ; $4a23
	ldh [$ffd6], a ; $4a25
	pop af ; $4a27
	ret ; $4a28
AwaitSerialByte:
	push de ; $4a29
	ld de, $4e20 ; $4a2a
Label_07_4a2d:
	ei ; $4a2d
	nop ; $4a2e
	nop ; $4a2f
	di ; $4a30
	ldh a, [hVBlankOccurred] ; $4a31
	or a, a ; $4a33
	jr z, Label_07_4a2d ; $4a34
	ldh a, [$ffd7] ; $4a36
	or a, a ; $4a38
	jr nz, Label_07_4a43 ; $4a39
	dec de ; $4a3b
	ld a, d ; $4a3c
	or a, e ; $4a3d
	jr nz, Label_07_4a2d ; $4a3e
	scf ; $4a40
	jr Label_07_4a4b ; $4a41
Label_07_4a43:
	dec a ; $4a43
	ldh [$ffd7], a ; $4a44
	xor a, a ; $4a46
	ldh [hVBlankOccurred], a ; $4a47
	scf ; $4a49
	ccf ; $4a4a
Label_07_4a4b:
	ldh a, [$ffc0] ; $4a4b
	ld b, a ; $4a4d
	ei ; $4a4e
	pop de ; $4a4f
	ret ; $4a50
ResyncLinkSession:
	di ; $4a51
	xor a, a ; $4a52
	ldh [rIF], a ; $4a53
	ldh a, [rIE] ; $4a55
	and a, $09 ; $4a57
	ldh [rIE], a ; $4a59
	ei ; $4a5b
	call DisableLCDSafely ; $4a5c
	ld a, $01 ; $4a5f
	ldh [$ffe7], a ; $4a61
	ld a, $01 ; $4a63
	ldh [$ffd8], a ; $4a65
	farcall FarPtr_ExchangeLinkReadySignal ; $4a67
	ldh a, [$ffc2] ; $4a6a
	cp a, $02 ; $4a6c
	jr z, Label_07_4a8c ; $4a6e
	cp a, $01 ; $4a70
	jr z, Label_07_4a77 ; $4a72
	call LinkErrorReset ; $4a74
Label_07_4a77:
	ld a, $40 ; $4a77
	ldh [$ffdc], a ; $4a79
	call ShortDelay ; $4a7b
	call ShortDelay ; $4a7e
	call ShortDelay ; $4a81
	call ShortDelay ; $4a84
	call ShortDelay ; $4a87
	jr Label_07_4a93 ; $4a8a
Label_07_4a8c:
	xor a, a ; $4a8c
	ldh [$ffd7], a ; $4a8d
	ld a, $80 ; $4a8f
	ldh [$ffdc], a ; $4a91
Label_07_4a93:
	call SerialEncodeInput ; $4a93
	farcall FarPtr_PrimeSlaveSerialReply ; $4a96
	xor a, a ; $4a99
	ldh [$ffde], a ; $4a9a
	ld a, $01 ; $4a9c
	ldh [$ffdf], a ; $4a9e
	call EnableLCD ; $4aa0
	xor a, a ; $4aa3
	ldh [$ffe7], a ; $4aa4
	ldh [$ffe9], a ; $4aa6
	ret ; $4aa8
ResyncLinkSessionWithTimer:
	di ; $4aa9
	xor a, a ; $4aaa
	ldh [rIF], a ; $4aab
	ldh a, [rIE] ; $4aad
	and a, $09 ; $4aaf
	ldh [rIE], a ; $4ab1
	ei ; $4ab3
	ld a, $01 ; $4ab4
	ldh [$ffe7], a ; $4ab6
	ld a, $01 ; $4ab8
	ldh [$ffd8], a ; $4aba
	farcall FarPtr_ExchangeLinkReadySignal ; $4abc
	ldh a, [$ffc2] ; $4abf
	cp a, $02 ; $4ac1
	jr z, Label_07_4ae1 ; $4ac3
	cp a, $01 ; $4ac5
	jr z, Label_07_4acc ; $4ac7
	call LinkErrorReset ; $4ac9
Label_07_4acc:
	ld a, $40 ; $4acc
	ldh [$ffdc], a ; $4ace
	call ShortDelay ; $4ad0
	call ShortDelay ; $4ad3
	call ShortDelay ; $4ad6
	call ShortDelay ; $4ad9
	call ShortDelay ; $4adc
	jr Label_07_4ae8 ; $4adf
Label_07_4ae1:
	xor a, a ; $4ae1
	ldh [$ffd7], a ; $4ae2
	ld a, $80 ; $4ae4
	ldh [$ffdc], a ; $4ae6
Label_07_4ae8:
	call SerialEncodeInput ; $4ae8
	farcall FarPtr_PrimeSlaveSerialReply ; $4aeb
	xor a, a ; $4aee
	ldh [$ffde], a ; $4aef
	ld a, $01 ; $4af1
	ldh [$ffdf], a ; $4af3
	call EnableTimerInterrupt ; $4af5
	xor a, a ; $4af8
	ldh [$ffe7], a ; $4af9
	ldh [$ffe9], a ; $4afb
	ret ; $4afd
TryLinkHandshakeSlave:
	push hl ; $4afe
	push de ; $4aff
	push bc ; $4b00
	call EnableSerialAndVBlankInterrupts ; $4b01
	di ; $4b04
	ldh a, [rIF] ; $4b05
	and a, $f7 ; $4b07
	ldh [rIF], a ; $4b09
	xor a, a ; $4b0b
	ldh [$ffd7], a ; $4b0c
	ld a, $c2 ; $4b0e
	ldh [$ffc1], a ; $4b10
	ldh [$ffe0], a ; $4b12
	ei ; $4b14
	call AwaitSerialByte ; $4b15
	jr c, Label_07_4b2e ; $4b18
	di ; $4b1a
	ldh a, [$ffc0] ; $4b1b
	cp a, $c2 ; $4b1d
	jr z, Label_07_4b2e ; $4b1f
	cp a, $00 ; $4b21
	jr z, Label_07_4b2e ; $4b23
	cp a, $ff ; $4b25
	jr z, Label_07_4b2e ; $4b27
	cp a, $c1 ; $4b29
	jr z, Label_07_4b31 ; $4b2b
	ei ; $4b2d
Label_07_4b2e:
	scf ; $4b2e
	jr Label_07_4b33 ; $4b2f
Label_07_4b31:
	scf ; $4b31
	ccf ; $4b32
Label_07_4b33:
	ei ; $4b33
	pop bc ; $4b34
	pop de ; $4b35
	pop hl ; $4b36
	ret ; $4b37
TryLinkHandshakeMaster:
	push hl ; $4b38
	push de ; $4b39
	push bc ; $4b3a
	call EnableSerialAndVBlankInterrupts ; $4b3b
	di ; $4b3e
	ldh a, [rSC] ; $4b3f
	and a, $7f ; $4b41
	ldh [rSC], a ; $4b43
	ei ; $4b45
	ld a, $c1 ; $4b46
	ldh [$ffc1], a ; $4b48
	ld hl, $03e8 ; $4b4a
	ld de, $03e8 ; $4b4d
Label_07_4b50:
	ldh a, [rLY] ; $4b50
	cp a, $8c ; $4b52
	jr nz, Label_07_4b50 ; $4b54
	ldh a, [rSC] ; $4b56
	bit 7, a ; $4b58
	jr nz, Label_07_4b50 ; $4b5a
	di ; $4b5c
	ldh a, [$ffc1] ; $4b5d
	ldh [rSB], a ; $4b5f
	push af ; $4b61
	ld a, $03 ; $4b62
	ldh [rSC], a ; $4b64
	ld a, $83 ; $4b66
	ldh [rSC], a ; $4b68
	pop af ; $4b6a
	xor a, a ; $4b6b
	ldh [$ffd7], a ; $4b6c
	ei ; $4b6e
	call AwaitSerialByte ; $4b6f
	farcall FarPtr_3e_16 ; $4b72
	farcall FarPtr_39_04 ; $4b75
	jr c, Label_07_4ba2 ; $4b78
	cp a, $c1 ; $4b7a
	jr z, Label_07_4ba2 ; $4b7c
	cp a, $ff ; $4b7e
	jr z, Label_07_4ba2 ; $4b80
	cp a, $c2 ; $4b82
	jr z, Label_07_4bbc ; $4b84
	ld a, d ; $4b86
	cp a, $03 ; $4b87
	jr nz, Label_07_4b9b ; $4b89
	ld a, e ; $4b8b
	cp a, $e8 ; $4b8c
	jr nz, Label_07_4b9b ; $4b8e
	push bc ; $4b90
	push de ; $4b91
	push hl ; $4b92
	ld c, $02 ; $4b93
	farcall FarPtr_3e_30 ; $4b95
	pop hl ; $4b98
	pop de ; $4b99
	pop bc ; $4b9a
Label_07_4b9b:
	dec de ; $4b9b
	ld a, d ; $4b9c
	or a, e ; $4b9d
	jr nz, Label_07_4b50 ; $4b9e
	jr Label_07_4ba2 ; $4ba0
Label_07_4ba2:
	di ; $4ba2
	ld a, $c0 ; $4ba3
	ldh [rSB], a ; $4ba5
	push af ; $4ba7
	ld a, $03 ; $4ba8
	ldh [rSC], a ; $4baa
	ld a, $83 ; $4bac
	ldh [rSC], a ; $4bae
	pop af ; $4bb0
	xor a, a ; $4bb1
	ldh [$ffd7], a ; $4bb2
	ei ; $4bb4
	call AwaitSerialByte ; $4bb5
	ld a, e ; $4bb8
	scf ; $4bb9
	jr Label_07_4bbe ; $4bba
Label_07_4bbc:
	scf ; $4bbc
	ccf ; $4bbd
Label_07_4bbe:
	pop bc ; $4bbe
	pop de ; $4bbf
	pop hl ; $4bc0
	ret ; $4bc1
LongDelay:
	call ShortDelay ; $4bc2
	call ShortDelay ; $4bc5
	call ShortDelay ; $4bc8
	call ShortDelay ; $4bcb
	call ShortDelay ; $4bce
	call ShortDelay ; $4bd1
	call ShortDelay ; $4bd4
	call ShortDelay ; $4bd7
	call ShortDelay ; $4bda
	call ShortDelay ; $4bdd
	call ShortDelay ; $4be0
	call ShortDelay ; $4be3
	call ShortDelay ; $4be6
	call ShortDelay ; $4be9
	call ShortDelay ; $4bec
	call ShortDelay ; $4bef
	ret ; $4bf2
RunLinkCommandFrame:
	ldh a, [$ffc2] ; $4bf3
	cp a, $02 ; $4bf5
	jr z, Label_07_4bfe ; $4bf7
	call RunLinkCommandFrameMaster ; $4bf9
	jr Label_07_4c01 ; $4bfc
Label_07_4bfe:
	call RunLinkCommandFrameSlave ; $4bfe
Label_07_4c01:
	ret ; $4c01
RunLinkCommandFrameMaster:
	push bc ; $4c02
	push hl ; $4c03
	call PrepareLinkInputPayload ; $4c04
	call ExchangeLinkFrameByteMaster ; $4c07
	call SerialDecodeCommand ; $4c0a
	call SerialEncodeCommand ; $4c0d
	pop bc ; $4c10
	pop hl ; $4c11
	ret ; $4c12
RunLinkCommandFrameSlave:
	push bc ; $4c13
	push hl ; $4c14
	call PrepareLinkInputPayload ; $4c15
	call ExchangeLinkFrameByteSlave ; $4c18
	call SerialDecodeCommand ; $4c1b
	call SerialEncodeCommand ; $4c1e
	pop hl ; $4c21
	pop bc ; $4c22
	ret ; $4c23
SerialEncodeCommand:
	push bc ; $4c24
	push hl ; $4c25
	ldh a, [$ffd6] ; $4c26
	ld b, a ; $4c28
	push hl ; $4c29
	push de ; $4c2a
	farcall FarPtr_38_0a ; $4c2b
	pop de ; $4c2e
	pop hl ; $4c2f
	ld c, b ; $4c30
	ldh a, [$ffc2] ; $4c31
	cp a, $01 ; $4c33
	jr z, Label_07_4c49 ; $4c35
	cp a, $02 ; $4c37
	jr z, Label_07_4c49 ; $4c39
	sound $72 ; $4c3b
	xor a, a ; $4c3d
	ldh [$ffd5], a ; $4c3e
	ldh [$ffd6], a ; $4c40
	ld a, $c0 ; $4c42
	ldh [$ffc1], a ; $4c44
	call LinkErrorReset ; $4c46
Label_07_4c49:
	ldh a, [$ffdf] ; $4c49
	or a, a ; $4c4b
	jr z, Label_07_4c5d ; $4c4c
	ldh a, [$ffc2] ; $4c4e
	cp a, $02 ; $4c50
	jr nz, Label_07_4c5d ; $4c52
Label_07_4c54:
	ei ; $4c54
	nop ; $4c55
	nop ; $4c56
	di ; $4c57
	ldh a, [$ffe0] ; $4c58
	or a, a ; $4c5a
	jr nz, Label_07_4c54 ; $4c5b
Label_07_4c5d:
	ldh a, [$ffdc] ; $4c5d
	or a, c ; $4c5f
	di ; $4c60
	ldh [$ffc1], a ; $4c61
	ldh [$ffe0], a ; $4c63
	ei ; $4c65
	pop hl ; $4c66
	pop bc ; $4c67
	ret ; $4c68
SerialDecodeCommand:
	push af ; $4c69
	push bc ; $4c6a
	ldh a, [$ffc0] ; $4c6b
	ld b, a ; $4c6d
	and a, $c0 ; $4c6e
	cp a, $80 ; $4c70
	jr z, Label_07_4c7f ; $4c72
	cp a, $40 ; $4c74
	jr z, Label_07_4c7f ; $4c76
	sound $72 ; $4c78
	xor a, a ; $4c7a
	ldh [$ffd3], a ; $4c7b
	jr Label_07_4cae ; $4c7d
Label_07_4c7f:
	ld a, b ; $4c7f
	and a, $3f ; $4c80
	ldh [$ffd4], a ; $4c82
	ldh a, [$ffc2] ; $4c84
	cp a, $01 ; $4c86
	jr nz, Label_07_4c96 ; $4c88
	ldh a, [$ffd5] ; $4c8a
	or a, a ; $4c8c
	jr nz, Label_07_4cac ; $4c8d
	ldh a, [$ffd4] ; $4c8f
	call DecodeLinkCommandCode ; $4c91
	jr Label_07_4cac ; $4c94
Label_07_4c96:
	ldh a, [$ffd5] ; $4c96
	ld b, a ; $4c98
	ldh a, [$ffde] ; $4c99
	ldh [$ffd5], a ; $4c9b
	ld a, b ; $4c9d
	ldh [$ffde], a ; $4c9e
	ldh a, [$ffd4] ; $4ca0
	or a, a ; $4ca2
	jr z, Label_07_4caa ; $4ca3
	call DecodeLinkCommandCode ; $4ca5
	jr Label_07_4cac ; $4ca8
Label_07_4caa:
	ldh a, [$ffd5] ; $4caa
Label_07_4cac:
	ldh [$ffd3], a ; $4cac
Label_07_4cae:
	pop bc ; $4cae
	pop af ; $4caf
	ret ; $4cb0
	ld a, [wMatchIsDoubles] ; $4cb1
	inc a ; $4cb4
	ld b, a ; $4cb5
	ldh a, [$ffe2] ; $4cb6
	cp a, b ; $4cb8
	ldh a, [$ffd6] ; $4cb9
	jr c, Label_07_4cc3 ; $4cbb
	and a, $0f ; $4cbd
	ldh [$ffd6], a ; $4cbf
	jr Label_07_4cc9 ; $4cc1
Label_07_4cc3:
	ld c, a ; $4cc3
	and a, $f0 ; $4cc4
	jr nz, Label_07_4ce3 ; $4cc6
	ld a, c ; $4cc8
Label_07_4cc9:
	bit 0, a ; $4cc9
	jr z, Label_07_4cd7 ; $4ccb
	ldh a, [$ffe2] ; $4ccd
	cp a, b ; $4ccf
	jr nc, Label_07_4ce3 ; $4cd0
	inc a ; $4cd2
	ldh [$ffe2], a ; $4cd3
	jr Label_07_4ce3 ; $4cd5
Label_07_4cd7:
	bit 1, a ; $4cd7
	jr z, Label_07_4ce3 ; $4cd9
	ldh a, [$ffe2] ; $4cdb
	or a, a ; $4cdd
	jr z, Label_07_4ce3 ; $4cde
	dec a ; $4ce0
	ldh [$ffe2], a ; $4ce1
Label_07_4ce3:
	ret ; $4ce3
DecodeLinkCommandCode:
	cp a, $14 ; $4ce4
	jr nz, Label_07_4cec ; $4ce6
	ld a, $0f ; $4ce8
	jr Label_07_4cfd ; $4cea
Label_07_4cec:
	cp a, $15 ; $4cec
	jr nz, Label_07_4cf4 ; $4cee
	ld a, $01 ; $4cf0
	jr Label_07_4cfd ; $4cf2
Label_07_4cf4:
	cp a, $19 ; $4cf4
	jr nz, Label_07_4cfc ; $4cf6
	ld a, $02 ; $4cf8
	jr Label_07_4cfd ; $4cfa
Label_07_4cfc:
	xor a, a ; $4cfc
Label_07_4cfd:
	ret ; $4cfd
ComposeLinkStateByte:
	push bc ; $4cfe
	push hl ; $4cff
	ldh a, [$ffdd] ; $4d00
	add a, a ; $4d02
	add a, a ; $4d03
	ld hl, $4d21 ; $4d04
	add a, l ; $4d07
	ld l, a ; $4d08
	jr nc, Label_07_4d0c ; $4d09
	inc h ; $4d0b
Label_07_4d0c:
	push hl ; $4d0c
	ld a, [hl+] ; $4d0d
	ld h, [hl] ; $4d0e
	ld l, a ; $4d0f
	ld a, [hl] ; $4d10
	and a, $f0 ; $4d11
	ld b, a ; $4d13
	pop hl ; $4d14
	inc hl ; $4d15
	inc hl ; $4d16
	ld a, [hl+] ; $4d17
	ld h, [hl] ; $4d18
	ld l, a ; $4d19
	ld a, [hl] ; $4d1a
	and a, $0f ; $4d1b
	or a, b ; $4d1d
	pop hl ; $4d1e
	pop bc ; $4d1f
	ret ; $4d20
	INCBIN "data/bank_007/d_4d21.bin" ; $4d21, 1088 bytes
ComputeShotPlacement:
	ld a, [$c4a0] ; $5161
	rst Rst00 ; $5164
	dw Label_07_5183 ; $5165 jumptable
	dw Label_07_519b ; $5167 jumptable
	dw Label_07_51b3 ; $5169 jumptable
	dw Label_07_51cb ; $516b jumptable
	dw Label_07_51e3 ; $516d jumptable
	dw Label_07_5248 ; $516f jumptable
	dw Label_07_5222 ; $5171 jumptable
	dw Label_07_5235 ; $5173 jumptable
	dw Label_07_520f ; $5175 jumptable
	dw Label_07_51f9 ; $5177 jumptable
	dw Label_07_525b ; $5179 jumptable
	dw Label_07_5268 ; $517b jumptable
	dw Label_07_5275 ; $517d jumptable
	dw Label_07_5284 ; $517f jumptable
	dw Label_07_5293 ; $5181 jumptable
Label_07_5183:
	ld hl, $4d31 ; $5183
	ld a, [$df6e] ; $5186
	ld d, a ; $5189
	ld a, [$df6b] ; $518a
	ld e, a ; $518d
	call LoadShotPlacementEntry ; $518e
	call AddBallSpeedQuarter ; $5191
	call AddChargeSpeedBonus ; $5194
	call FinalizeShotSpeed ; $5197
	ret ; $519a
Label_07_519b:
	ld hl, $4d81 ; $519b
	ld a, [$df6e] ; $519e
	ld d, a ; $51a1
	ld a, [$df6b] ; $51a2
	ld e, a ; $51a5
	call LoadShotPlacementEntry ; $51a6
	call AddBallSpeedQuarter ; $51a9
	call AddChargeSpeedBonus ; $51ac
	call FinalizeShotSpeed ; $51af
	ret ; $51b2
Label_07_51b3:
	ld hl, $4dd1 ; $51b3
	ld a, [$df6f] ; $51b6
	ld d, a ; $51b9
	ld a, [$df6b] ; $51ba
	ld e, a ; $51bd
	call LoadShotPlacementEntry ; $51be
	call AddBallSpeedEighth ; $51c1
	call AddChargeSpeedBonusHalf ; $51c4
	call FinalizeShotSpeed ; $51c7
	ret ; $51ca
Label_07_51cb:
	ld hl, $4e21 ; $51cb
	ld a, [$df6f] ; $51ce
	ld d, a ; $51d1
	ld a, [$df6b] ; $51d2
	ld e, a ; $51d5
	call LoadShotPlacementEntry ; $51d6
	call AddBallSpeedEighth ; $51d9
	call AddChargeSpeedBonusHalf ; $51dc
	call FinalizeShotSpeed ; $51df
	ret ; $51e2
Label_07_51e3:
	ld hl, $4e71 ; $51e3
	ld d, $00 ; $51e6
	ld a, [$df6b] ; $51e8
	ld e, a ; $51eb
	call LoadShotPlacementEntry ; $51ec
	call AddBallSpeedQuarter ; $51ef
	call AddChargeSpeedBonus ; $51f2
	call FinalizeShotSpeed ; $51f5
	ret ; $51f8
Label_07_51f9:
	ld hl, $4ec1 ; $51f9
	ld d, $00 ; $51fc
	ld a, [$df6c] ; $51fe
	ld e, a ; $5201
	call LoadShotPlacementEntry ; $5202
	call AddBallSpeed3Sixteenths ; $5205
	call AddChargeSpeedBonus ; $5208
	call FinalizeShotSpeed ; $520b
	ret ; $520e
Label_07_520f:
	ld hl, $4f11 ; $520f
	ld d, $00 ; $5212
	ld a, [$df6d] ; $5214
	ld e, a ; $5217
	call LoadShotPlacementEntry ; $5218
	call AddBallSpeed3Sixteenths ; $521b
	call FinalizeShotSpeed ; $521e
	ret ; $5221
Label_07_5222:
	ld hl, $4f61 ; $5222
	ld d, $00 ; $5225
	ld a, [$df6d] ; $5227
	ld e, a ; $522a
	call LoadShotPlacementEntry ; $522b
	call AddBallSpeedQuarter ; $522e
	call FinalizeShotSpeed ; $5231
	ret ; $5234
Label_07_5235:
	ld hl, $4fb1 ; $5235
	ld d, $00 ; $5238
	ld a, [$df6d] ; $523a
	ld e, a ; $523d
	call LoadShotPlacementEntry ; $523e
	call AddBallSpeedEighth ; $5241
	call FinalizeShotSpeed ; $5244
	ret ; $5247
Label_07_5248:
	ld hl, $5001 ; $5248
	ld d, $00 ; $524b
	ld a, [$df6d] ; $524d
	ld e, a ; $5250
	call LoadShotPlacementEntry ; $5251
	call AddBallSpeed3Sixteenths ; $5254
	call FinalizeShotSpeed ; $5257
	ret ; $525a
Label_07_525b:
	ld hl, $5051 ; $525b
	ld a, [$df92] ; $525e
	ld d, a ; $5261
	ld e, $00 ; $5262
	call LoadShotPlacementEntry ; $5264
	ret ; $5267
Label_07_5268:
	ld hl, $5061 ; $5268
	ld a, [$df93] ; $526b
	ld d, a ; $526e
	ld e, $00 ; $526f
	call LoadShotPlacementEntry ; $5271
	ret ; $5274
Label_07_5275:
	ld hl, $5071 ; $5275
	ld a, [$df6e] ; $5278
	ld d, a ; $527b
	ld a, [$df6c] ; $527c
	ld e, a ; $527f
	call LoadShotPlacementEntry ; $5280
	ret ; $5283
Label_07_5284:
	ld hl, $50c1 ; $5284
	ld a, [$df6f] ; $5287
	ld d, a ; $528a
	ld a, [$df6c] ; $528b
	ld e, a ; $528e
	call LoadShotPlacementEntry ; $528f
	ret ; $5292
Label_07_5293:
	ld hl, $5111 ; $5293
	ld d, $00 ; $5296
	ld a, [$df6c] ; $5298
	ld e, a ; $529b
	call LoadShotPlacementEntry ; $529c
	ret ; $529f
LoadShotPlacementEntry:
	push hl ; $52a0
	ld a, d ; $52a1
	add a, a ; $52a2
	add a, a ; $52a3
	add a, a ; $52a4
	add a, l ; $52a5
	ld l, a ; $52a6
	jr nc, Label_07_52aa ; $52a7
	inc h ; $52a9
Label_07_52aa:
	ld a, [hl+] ; $52aa
	ld [$c41c], a ; $52ab
	ld a, [hl+] ; $52ae
	ld [$c41d], a ; $52af
	ld a, [hl+] ; $52b2
	ld b, [hl] ; $52b3
	ld c, a ; $52b4
	ld a, [$c4a7] ; $52b5
	and a, a ; $52b8
	jr z, Label_07_52c1 ; $52b9
	xor a, a ; $52bb
	sub a, c ; $52bc
	ld c, a ; $52bd
	sbc a, a ; $52be
	sub a, b ; $52bf
	ld b, a ; $52c0
Label_07_52c1:
	ld hl, $c41e ; $52c1
	ld a, c ; $52c4
	ld [hl+], a ; $52c5
	ld [hl], b ; $52c6
	pop hl ; $52c7
	ld a, e ; $52c8
	add a, a ; $52c9
	add a, a ; $52ca
	add a, a ; $52cb
	add a, $04 ; $52cc
	add a, l ; $52ce
	ld l, a ; $52cf
	jr nc, Label_07_52d3 ; $52d0
	inc h ; $52d2
Label_07_52d3:
	ld a, [hl+] ; $52d3
	ld b, [hl] ; $52d4
	ld c, a ; $52d5
	ret ; $52d6
FinalizeShotSpeed:
	call AddPlayerMomentumToShot ; $52d7
	call Func_07_53a2 ; $52da
	ld hl, rJOYP ; $52dd
	add hl, bc ; $52e0
	bit 7, h ; $52e1
	jr z, Label_07_52e8 ; $52e3
	ld bc, $0100 ; $52e5
Label_07_52e8:
	ld a, c ; $52e8
	ld [$c458], a ; $52e9
	ld a, b ; $52ec
	ld [$c459], a ; $52ed
	ret ; $52f0
AddBallSpeedQuarter:
	ld hl, $c424 ; $52f1
	ld a, [hl+] ; $52f4
	ld h, [hl] ; $52f5
	ld l, a ; $52f6
	sra h ; $52f7
	rr l ; $52f9
	sra h ; $52fb
	rr l ; $52fd
	jr Label_07_532f ; $52ff
AddBallSpeed3Sixteenths:
	ld hl, $c424 ; $5301
	ld a, [hl+] ; $5304
	ld h, [hl] ; $5305
	ld l, a ; $5306
	sra h ; $5307
	rr l ; $5309
	sra h ; $530b
	rr l ; $530d
	sra h ; $530f
	rr l ; $5311
	sra h ; $5313
	rr l ; $5315
	ld e, l ; $5317
	ld d, h ; $5318
	add hl, de ; $5319
	add hl, de ; $531a
	jr Label_07_532f ; $531b
AddBallSpeedEighth:
	ld hl, $c424 ; $531d
	ld a, [hl+] ; $5320
	ld h, [hl] ; $5321
	ld l, a ; $5322
	sra h ; $5323
	rr l ; $5325
	sra h ; $5327
	rr l ; $5329
	sra h ; $532b
	rr l ; $532d
Label_07_532f:
	bit 7, h ; $532f
	jr nz, Label_07_5339 ; $5331
	xor a, a ; $5333
	sub a, l ; $5334
	ld l, a ; $5335
	sbc a, a ; $5336
	sub a, h ; $5337
	ld h, a ; $5338
Label_07_5339:
	ld a, l ; $5339
	ld [$c45a], a ; $533a
	ld a, h ; $533d
	ld [$c45b], a ; $533e
	add hl, bc ; $5341
	ld c, l ; $5342
	ld b, h ; $5343
	ret ; $5344
AddChargeSpeedBonus:
	ld a, [$c4a2] ; $5345
	ld l, a ; $5348
	ld h, $00 ; $5349
	ld de, $ffe0 ; $534b
	add hl, de ; $534e
	ld a, $80 ; $534f
	bit 7, h ; $5351
	jr z, Label_07_5357 ; $5353
	srl a ; $5355
Label_07_5357:
	call MulHLByASignedFull ; $5357
	jr Label_07_5373 ; $535a
AddChargeSpeedBonusHalf:
	ld a, [$c4a2] ; $535c
	ld l, a ; $535f
	ld h, $00 ; $5360
	ld de, $ffe0 ; $5362
	add hl, de ; $5365
	ld a, $40 ; $5366
	bit 7, h ; $5368
	jr z, Label_07_536e ; $536a
	srl a ; $536c
Label_07_536e:
	call MulHLByASignedFull ; $536e
	jr Label_07_5373 ; $5371
Label_07_5373:
	ld a, l ; $5373
	ld [$c45e], a ; $5374
	ld a, h ; $5377
	ld [$c45f], a ; $5378
	add hl, bc ; $537b
	ld c, l ; $537c
	ld b, h ; $537d
	ret ; $537e
AddPlayerMomentumToShot:
	ld hl, $df42 ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	sra h ; $5385
	rr l ; $5387
	ld a, [$df0a] ; $5389
	and a, $02 ; $538c
	jr nz, Label_07_5396 ; $538e
	xor a, a ; $5390
	sub a, l ; $5391
	ld l, a ; $5392
	sbc a, a ; $5393
	sub a, h ; $5394
	ld h, a ; $5395
Label_07_5396:
	ld a, l ; $5396
	ld [$c45c], a ; $5397
	ld a, h ; $539a
	ld [$c45d], a ; $539b
	add hl, bc ; $539e
	ld c, l ; $539f
	ld b, h ; $53a0
	ret ; $53a1
Func_07_53a2:
	ld hl, $df0f ; $53a2
	bit 1, [hl] ; $53a5
	jr z, Label_07_53af ; $53a7
	ld hl, $f400 ; $53a9
	add hl, bc ; $53ac
	ld c, l ; $53ad
	ld b, h ; $53ae
Label_07_53af:
	ret ; $53af
ExecuteShot:
	ld hl, $c4b7 ; $53b0
	ld a, [hl] ; $53b3
	and a, a ; $53b4
	ret nz ; $53b5
	ld a, $01 ; $53b6
	ld [$c4b7], a ; $53b8
	ld a, [$df0b] ; $53bb
	ld [$c4b8], a ; $53be
	ld a, [$df09] ; $53c1
	ld [$c4b9], a ; $53c4
	ld a, [$df4a] ; $53c7
	ld [$c4a4], a ; $53ca
	ld a, [$df14] ; $53cd
	ld [$c4a0], a ; $53d0
	ld a, [$df16] ; $53d3
	swap a ; $53d6
	ld hl, $df17 ; $53d8
	or a, [hl] ; $53db
	ld [$c490], a ; $53dc
	ld a, [$c4b0] ; $53df
	ld [$c4be], a ; $53e2
	xor a, a ; $53e5
	ld [$c4a5], a ; $53e6
	ld [$c4a6], a ; $53e9
	ld [$c4c6], a ; $53ec
	ld b, $00 ; $53ef
	ld a, [$df15] ; $53f1
	cp a, $06 ; $53f4
	jr nz, Label_07_53f9 ; $53f6
	inc b ; $53f8
Label_07_53f9:
	cp a, $0a ; $53f9
	jr nz, Label_07_53fe ; $53fb
	inc b ; $53fd
Label_07_53fe:
	ld a, [$df94] ; $53fe
	and a, a ; $5401
	jr z, Label_07_5405 ; $5402
	inc b ; $5404
Label_07_5405:
	ld a, [wRallyLength] ; $5405
	cp a, $00 ; $5408
	jr nz, Label_07_540d ; $540a
	inc b ; $540c
Label_07_540d:
	ld a, b ; $540d
	and a, $01 ; $540e
	ld [$c4a7], a ; $5410
	ld a, [$df4b] ; $5413
	cp a, $3f ; $5416
	jr c, Label_07_541c ; $5418
	ld a, $3f ; $541a
Label_07_541c:
	ld [$c4a2], a ; $541c
	ld a, [$df4c] ; $541f
	ld [$c4a3], a ; $5422
	ld hl, $c421 ; $5425
	ld a, [hl+] ; $5428
	ld d, [hl] ; $5429
	ld e, a ; $542a
	ld hl, $c454 ; $542b
	ld a, e ; $542e
	ld [hl+], a ; $542f
	ld [hl], d ; $5430
	ld hl, $c424 ; $5431
	ld a, [hl+] ; $5434
	ld d, [hl] ; $5435
	ld e, a ; $5436
	ld hl, $c456 ; $5437
	ld a, e ; $543a
	ld [hl+], a ; $543b
	ld [hl], d ; $543c
	ld hl, $5463 ; $543d
	push hl ; $5440
	ld a, [$c4a0] ; $5441
	rst Rst00 ; $5444
	dw Label_07_58be ; $5445 jumptable
	dw Label_07_58d3 ; $5447 jumptable
	dw Label_07_58ec ; $5449 jumptable
	dw Label_07_5901 ; $544b jumptable
	dw Label_07_59a8 ; $544d jumptable
	dw Label_07_597c ; $544f jumptable
	dw Label_07_5952 ; $5451 jumptable
	dw Label_07_5967 ; $5453 jumptable
	dw Label_07_593d ; $5455 jumptable
	dw Label_07_5991 ; $5457 jumptable
	dw Label_07_591a ; $5459 jumptable
	dw Label_07_592d ; $545b jumptable
	dw Label_07_59c5 ; $545d jumptable
	dw Label_07_59d2 ; $545f jumptable
	dw Label_07_59df ; $5461 jumptable
	call ApplyShotRecoil ; $5463
	xor a, a ; $5466
	ld [$df4b], a ; $5467
	ret ; $546a
ApplyShotRecoil:
	ld hl, $df0f ; $546b
	set 0, [hl] ; $546e
	res 5, [hl] ; $5470
	ld a, [$c4a1] ; $5472
	add a, a ; $5475
	add a, $ca ; $5476
	ld l, a ; $5478
	adc a, $54 ; $5479
	sub a, l ; $547b
	ld h, a ; $547c
	ld a, [hl+] ; $547d
	ld h, [hl] ; $547e
	ld l, a ; $547f
	ld a, [hl] ; $5480
	add a, $d4 ; $5481
	ld l, a ; $5483
	adc a, $54 ; $5484
	sub a, l ; $5486
	ld h, a ; $5487
	ld b, [hl] ; $5488
	ld hl, $c456 ; $5489
	ld a, [hl+] ; $548c
	ld h, [hl] ; $548d
	ld l, a ; $548e
	ld a, b ; $548f
	call MulHLByAFracSigned ; $5490
	ld e, l ; $5493
	ld d, h ; $5494
	ld hl, $df42 ; $5495
	ld a, [hl+] ; $5498
	ld h, [hl] ; $5499
	ld l, a ; $549a
	sra h ; $549b
	rr l ; $549d
	sra h ; $549f
	rr l ; $54a1
	add hl, de ; $54a3
	ld e, l ; $54a4
	ld d, h ; $54a5
	ld hl, $df42 ; $54a6
	ld a, e ; $54a9
	ld [hl+], a ; $54aa
	ld [hl], d ; $54ab
	ld hl, $df0f ; $54ac
	bit 1, [hl] ; $54af
	jr nz, Label_07_54c9 ; $54b1
	ld hl, $df40 ; $54b3
	ld a, [hl+] ; $54b6
	ld h, [hl] ; $54b7
	ld l, a ; $54b8
	sra h ; $54b9
	rr l ; $54bb
	sra h ; $54bd
	rr l ; $54bf
	ld e, l ; $54c1
	ld d, h ; $54c2
	ld hl, $df40 ; $54c3
	ld a, e ; $54c6
	ld [hl+], a ; $54c7
	ld [hl], d ; $54c8
Label_07_54c9:
	ret ; $54c9
	INCBIN "data/bank_007/d_54ca.bin" ; $54ca, 20 bytes
WeakenShotByCharge:
	ld a, [$c4a2] ; $54de
	ld l, a ; $54e1
	ld h, $00 ; $54e2
	add hl, hl ; $54e4
	add hl, hl ; $54e5
	ld a, c ; $54e6
	sub a, l ; $54e7
	ld c, a ; $54e8
	ld a, b ; $54e9
	sbc a, h ; $54ea
	ld b, a ; $54eb
	ret ; $54ec
BoostShotByCharge:
	ld a, [$c4a2] ; $54ed
	ld l, a ; $54f0
	ld h, $00 ; $54f1
	add hl, hl ; $54f3
	ld e, l ; $54f4
	ld d, h ; $54f5
	add hl, hl ; $54f6
	add hl, hl ; $54f7
	add hl, de ; $54f8
	add hl, de ; $54f9
	add hl, bc ; $54fa
	ld c, l ; $54fb
	ld b, h ; $54fc
	ret ; $54fd
NudgeShotByPlayerMomentum:
	ld hl, $df42 ; $54fe
	ld a, [hl+] ; $5501
	ld h, [hl] ; $5502
	ld l, a ; $5503
	sra h ; $5504
	rr l ; $5506
	sra h ; $5508
	rr l ; $550a
	sra h ; $550c
	rr l ; $550e
	sra h ; $5510
	rr l ; $5512
	ld a, [$df0a] ; $5514
	and a, $02 ; $5517
	jr nz, Label_07_5521 ; $5519
	xor a, a ; $551b
	sub a, l ; $551c
	ld l, a ; $551d
	sbc a, a ; $551e
	sub a, h ; $551f
	ld h, a ; $5520
Label_07_5521:
	add hl, bc ; $5521
	ld c, l ; $5522
	ld b, h ; $5523
	ret ; $5524
CheckBallInSmashRange:
	ld hl, wBallDepth ; $5525
	ld a, [hl+] ; $5528
	ld h, [hl] ; $5529
	ld l, a ; $552a
	bit 7, h ; $552b
	jr z, Label_07_5535 ; $552d
	xor a, a ; $552f
	sub a, l ; $5530
	ld l, a ; $5531
	sbc a, a ; $5532
	sub a, h ; $5533
	ld h, a ; $5534
Label_07_5535:
	ld e, l ; $5535
	ld d, h ; $5536
	sra d ; $5537
	rr e ; $5539
	add hl, de ; $553b
	sra h ; $553c
	rr l ; $553e
	ld e, l ; $5540
	ld d, h ; $5541
	ld hl, wBallHeight ; $5542
	ld a, [hl+] ; $5545
	ld h, [hl] ; $5546
	ld l, a ; $5547
	ld bc, $0070 ; $5548
	add hl, bc ; $554b
	bit 7, h ; $554c
	jr z, Label_07_557d ; $554e
	call AngleFromVector16 ; $5550
	push bc ; $5553
	ld hl, wBallDepth ; $5554
	ld a, [hl+] ; $5557
	ld h, [hl] ; $5558
	ld l, a ; $5559
	bit 7, h ; $555a
	jr z, Label_07_5564 ; $555c
	xor a, a ; $555e
	sub a, l ; $555f
	ld l, a ; $5560
	sbc a, a ; $5561
	sub a, h ; $5562
	ld h, a ; $5563
Label_07_5564:
	ld de, $04e0 ; $5564
	add hl, de ; $5567
	ld e, l ; $5568
	ld d, h ; $5569
	ld hl, wBallHeight ; $556a
	ld a, [hl+] ; $556d
	ld h, [hl] ; $556e
	ld l, a ; $556f
	xor a, a ; $5570
	sub a, l ; $5571
	ld l, a ; $5572
	sbc a, a ; $5573
	sub a, h ; $5574
	ld h, a ; $5575
	call AngleFromVector16 ; $5576
	pop hl ; $5579
	add hl, bc ; $557a
	bit 7, h ; $557b
Label_07_557d:
	ret ; $557d
ApplyShotTypePresets:
	ld a, [$c4a0] ; $557e
	ld b, a ; $5581
	add a, a ; $5582
	add a, a ; $5583
	add a, b ; $5584
	add a, $9e ; $5585
	ld l, a ; $5587
	adc a, $55 ; $5588
	sub a, l ; $558a
	ld h, a ; $558b
	ld a, [hl+] ; $558c
	call PlaySoundManaged ; $558d
	ld a, [hl+] ; $5590
	ld [$c4a1], a ; $5591
	ld a, [hl+] ; $5594
	push hl ; $5595
	farcall FarPtr_SetBallTrailColor ; $5596
	pop hl ; $5599
	ld a, [hl+] ; $559a
	ld b, [hl] ; $559b
	ld c, a ; $559c
	ret ; $559d
	INCBIN "data/bank_007/d_559e.bin" ; $559e, 75 bytes
Label_07_55e9:
	ld hl, $563e ; $55e9
	ld a, [$c7b9] ; $55ec
	and a, a ; $55ef
	jr nz, Label_07_5601 ; $55f0
	ld a, [$df0a] ; $55f2
	and a, $01 ; $55f5
	add a, a ; $55f7
	add a, a ; $55f8
	add a, a ; $55f9
	add a, $2e ; $55fa
	ld l, a ; $55fc
	adc a, $56 ; $55fd
	sub a, l ; $55ff
	ld h, a ; $5600
Label_07_5601:
	ld a, [$df4a] ; $5601
	inc a ; $5604
	add a, a ; $5605
	add a, l ; $5606
	ld l, a ; $5607
	jr nc, Label_07_560b ; $5608
	inc h ; $560a
Label_07_560b:
	ld a, [hl+] ; $560b
	ld d, [hl] ; $560c
	ld e, a ; $560d
	ld hl, $df01 ; $560e
	ld a, [hl+] ; $5611
	ld h, [hl] ; $5612
	ld l, a ; $5613
	xor a, a ; $5614
	sub a, l ; $5615
	ld l, a ; $5616
	sbc a, a ; $5617
	sub a, h ; $5618
	ld h, a ; $5619
	sra h ; $561a
	rr l ; $561c
	sra h ; $561e
	rr l ; $5620
	sra h ; $5622
	rr l ; $5624
	sra h ; $5626
	rr l ; $5628
	add hl, de ; $562a
	ld e, l ; $562b
	ld d, h ; $562c
	ret ; $562d
	INCBIN "data/bank_007/d_562e.bin" ; $562e, 24 bytes
ComputeShotTargetX:
	ld a, [wRallyLength] ; $5646
	and a, a ; $5649
	jr z, Label_07_55e9 ; $564a
	call ComputeAimBaseOffset ; $564c
	ld a, [$df4a] ; $564f
	add a, $02 ; $5652
	and a, $07 ; $5654
	ld a, a ; $5656
	rst Rst00 ; $5657
	dw Label_07_566c ; $5658 jumptable
	dw Label_07_5668 ; $565a jumptable
	dw Label_07_5696 ; $565c jumptable
	dw Label_07_5685 ; $565e jumptable
	dw Label_07_5689 ; $5660 jumptable
	dw Label_07_5696 ; $5662 jumptable
	dw Label_07_5696 ; $5664 jumptable
	dw Label_07_5696 ; $5666 jumptable
Label_07_5668:
	sra d ; $5668
	rr e ; $566a
Label_07_566c:
	ld hl, wBallX ; $566c
	ld a, [hl+] ; $566f
	ld h, [hl] ; $5670
	ld l, a ; $5671
	xor a, a ; $5672
	sub a, l ; $5673
	ld l, a ; $5674
	sbc a, a ; $5675
	sub a, h ; $5676
	ld h, a ; $5677
	add hl, de ; $5678
	ld e, l ; $5679
	ld d, h ; $567a
	call ClampShotTargetX ; $567b
	xor a, a ; $567e
	sub a, e ; $567f
	ld e, a ; $5680
	sbc a, a ; $5681
	sub a, d ; $5682
	ld d, a ; $5683
	ret ; $5684
Label_07_5685:
	sra d ; $5685
	rr e ; $5687
Label_07_5689:
	ld hl, wBallX ; $5689
	ld a, [hl+] ; $568c
	ld h, [hl] ; $568d
	ld l, a ; $568e
	add hl, de ; $568f
	ld e, l ; $5690
	ld d, h ; $5691
	call ClampShotTargetX ; $5692
	ret ; $5695
Label_07_5696:
	ld hl, wBallX ; $5696
	ld a, [hl+] ; $5699
	ld d, [hl] ; $569a
	ld e, a ; $569b
	sra d ; $569c
	rr e ; $569e
	sra d ; $56a0
	rr e ; $56a2
	call GetRandomAimJitter ; $56a4
	ld a, e ; $56a7
	sub a, h ; $56a8
	ld e, a ; $56a9
	jr nc, Label_07_56ad ; $56aa
	dec d ; $56ac
Label_07_56ad:
	call GetRandomAimJitter ; $56ad
	ld a, h ; $56b0
	add a, e ; $56b1
	ld e, a ; $56b2
	jr nc, Label_07_56b6 ; $56b3
	inc d ; $56b5
Label_07_56b6:
	ret ; $56b6
ComputeAimBaseOffset:
	ld hl, $c43e ; $56b7
	ld a, [hl+] ; $56ba
	ld d, [hl] ; $56bb
	ld e, a ; $56bc
	ld hl, $df04 ; $56bd
	ld a, [hl+] ; $56c0
	ld h, [hl] ; $56c1
	ld l, a ; $56c2
	bit 7, h ; $56c3
	jr z, Label_07_56cd ; $56c5
	xor a, a ; $56c7
	sub a, l ; $56c8
	ld l, a ; $56c9
	sbc a, a ; $56ca
	sub a, h ; $56cb
	ld h, a ; $56cc
Label_07_56cd:
	sra h ; $56cd
	rr l ; $56cf
	sra h ; $56d1
	rr l ; $56d3
	sra h ; $56d5
	rr l ; $56d7
	add hl, de ; $56d9
	ld a, [$df69] ; $56da
	call MulHLByAFrac ; $56dd
	ld e, l ; $56e0
	ld d, h ; $56e1
	ret ; $56e2
ClampShotTargetX:
	ld hl, $c484 ; $56e3
	ld a, [hl+] ; $56e6
	ld h, [hl] ; $56e7
	ld l, a ; $56e8
	ld bc, $0020 ; $56e9
	add hl, bc ; $56ec
	xor a, a ; $56ed
	sub a, l ; $56ee
	ld l, a ; $56ef
	sbc a, a ; $56f0
	sub a, h ; $56f1
	ld h, a ; $56f2
	ld c, l ; $56f3
	ld b, h ; $56f4
	ld l, e ; $56f5
	ld h, d ; $56f6
	ld a, l ; $56f7
	sub a, c ; $56f8
	ld l, a ; $56f9
	ld a, h ; $56fa
	sbc a, b ; $56fb
	ld h, a ; $56fc
	bit 7, h ; $56fd
	jr nz, Label_07_5703 ; $56ff
	ld e, c ; $5701
	ld d, b ; $5702
Label_07_5703:
	call GetRandomAimJitter ; $5703
	ld a, e ; $5706
	sub a, h ; $5707
	ld e, a ; $5708
	jr nc, Label_07_570c ; $5709
	dec d ; $570b
Label_07_570c:
	ret ; $570c
GetRandomAimJitter:
	farcall FarPtr_AdvanceMatchRng ; $570d
	ld l, a ; $5710
	ld h, $00 ; $5711
	ld a, [$df6a] ; $5713
	call MulHLByA ; $5716
	add hl, hl ; $5719
	add hl, hl ; $571a
	add hl, hl ; $571b
	add hl, hl ; $571c
	ret ; $571d
ComputeShotTrajectory:
	ld a, [$df0a] ; $571e
	and a, $02 ; $5721
	jr nz, Label_07_572b ; $5723
	xor a, a ; $5725
	sub a, c ; $5726
	ld c, a ; $5727
	sbc a, a ; $5728
	sub a, b ; $5729
	ld b, a ; $572a
Label_07_572b:
	ld hl, $c432 ; $572b
	ld a, c ; $572e
	ld [hl+], a ; $572f
	ld [hl], b ; $5730
	ld hl, wBallDepth ; $5731
	ld a, [hl+] ; $5734
	ld h, [hl] ; $5735
	ld l, a ; $5736
	ld a, c ; $5737
	sub a, l ; $5738
	ld c, a ; $5739
	ld a, b ; $573a
	sbc a, h ; $573b
	ld b, a ; $573c
	ld hl, $c436 ; $573d
	ld a, c ; $5740
	ld [hl+], a ; $5741
	ld [hl], b ; $5742
	call ComputeShotTargetX ; $5743
	ld hl, $c430 ; $5746
	ld a, e ; $5749
	ld [hl+], a ; $574a
	ld [hl], d ; $574b
	ld hl, wBallX ; $574c
	ld a, [hl+] ; $574f
	ld h, [hl] ; $5750
	ld l, a ; $5751
	ld a, e ; $5752
	sub a, l ; $5753
	ld e, a ; $5754
	ld a, d ; $5755
	sbc a, h ; $5756
	ld d, a ; $5757
	ld hl, $c434 ; $5758
	ld a, e ; $575b
	ld [hl+], a ; $575c
	ld [hl], d ; $575d
	ld hl, $c436 ; $575e
	ld a, [hl+] ; $5761
	ld h, [hl] ; $5762
	ld l, a ; $5763
	call AngleFromVector16 ; $5764
	ld hl, $c43a ; $5767
	ld a, c ; $576a
	ld [hl+], a ; $576b
	ld [hl], b ; $576c
	ld hl, $c43a ; $576d
	ld a, [hl+] ; $5770
	ld b, [hl] ; $5771
	ld c, a ; $5772
	ld hl, wBallDepth ; $5773
	ld a, [hl+] ; $5776
	ld h, [hl] ; $5777
	ld l, a ; $5778
	bit 7, h ; $5779
	jr z, Label_07_5783 ; $577b
	xor a, a ; $577d
	sub a, l ; $577e
	ld l, a ; $577f
	sbc a, a ; $5780
	sub a, h ; $5781
	ld h, a ; $5782
Label_07_5783:
	ld de, $0140 ; $5783
	add hl, de ; $5786
	call DivBySin ; $5787
	bit 7, h ; $578a
	jr z, Label_07_5794 ; $578c
	xor a, a ; $578e
	sub a, l ; $578f
	ld l, a ; $5790
	sbc a, a ; $5791
	sub a, h ; $5792
	ld h, a ; $5793
Label_07_5794:
	ld e, l ; $5794
	ld d, h ; $5795
	add hl, hl ; $5796
	add hl, hl ; $5797
	ld a, h ; $5798
	ld [$c48e], a ; $5799
	ld hl, $c48a ; $579c
	ld a, e ; $579f
	ld [hl+], a ; $57a0
	ld [hl], d ; $57a1
	ld hl, $c43a ; $57a2
	ld a, [hl+] ; $57a5
	ld b, [hl] ; $57a6
	ld c, a ; $57a7
	ld hl, wBallDepth ; $57a8
	ld a, [hl+] ; $57ab
	ld h, [hl] ; $57ac
	ld l, a ; $57ad
	bit 7, h ; $57ae
	jr z, Label_07_57b8 ; $57b0
	xor a, a ; $57b2
	sub a, l ; $57b3
	ld l, a ; $57b4
	sbc a, a ; $57b5
	sub a, h ; $57b6
	ld h, a ; $57b7
Label_07_57b8:
	ld de, $0480 ; $57b8
	add hl, de ; $57bb
	call DivBySin ; $57bc
	bit 7, h ; $57bf
	jr z, Label_07_57c9 ; $57c1
	xor a, a ; $57c3
	sub a, l ; $57c4
	ld l, a ; $57c5
	sbc a, a ; $57c6
	sub a, h ; $57c7
	ld h, a ; $57c8
Label_07_57c9:
	ld e, l ; $57c9
	ld d, h ; $57ca
	add hl, hl ; $57cb
	add hl, hl ; $57cc
	ld a, h ; $57cd
	ld [$c48f], a ; $57ce
	ld hl, $c48c ; $57d1
	ld a, e ; $57d4
	ld [hl+], a ; $57d5
	ld [hl], d ; $57d6
	ld hl, $c43a ; $57d7
	ld a, [hl+] ; $57da
	ld b, [hl] ; $57db
	ld c, a ; $57dc
	ld l, e ; $57dd
	ld h, d ; $57de
	call MulSinCos ; $57df
	bit 7, h ; $57e2
	jr z, Label_07_57ec ; $57e4
	xor a, a ; $57e6
	sub a, l ; $57e7
	ld l, a ; $57e8
	sbc a, a ; $57e9
	sub a, h ; $57ea
	ld h, a ; $57eb
Label_07_57ec:
	ld c, l ; $57ec
	ld b, h ; $57ed
	ld hl, $ffe0 ; $57ee
	add hl, bc ; $57f1
	jr nc, Label_07_5851 ; $57f2
	ld hl, $c484 ; $57f4
	ld a, [hl+] ; $57f7
	ld h, [hl] ; $57f8
	ld l, a ; $57f9
	ld de, $0020 ; $57fa
	add hl, de ; $57fd
	ld e, l ; $57fe
	ld d, h ; $57ff
	ld a, [$c43b] ; $5800
	add a, $40 ; $5803
	bit 7, a ; $5805
	jr z, Label_07_580f ; $5807
	xor a, a ; $5809
	sub a, e ; $580a
	ld e, a ; $580b
	sbc a, a ; $580c
	sub a, d ; $580d
	ld d, a ; $580e
Label_07_580f:
	ld hl, wBallX ; $580f
	ld a, [hl+] ; $5812
	ld h, [hl] ; $5813
	ld l, a ; $5814
	add hl, de ; $5815
	bit 7, h ; $5816
	jr z, Label_07_5820 ; $5818
	xor a, a ; $581a
	sub a, l ; $581b
	ld l, a ; $581c
	sbc a, a ; $581d
	sub a, h ; $581e
	ld h, a ; $581f
Label_07_5820:
	ld e, l ; $5820
	ld d, h ; $5821
	ld a, l ; $5822
	sub a, c ; $5823
	ld l, a ; $5824
	ld a, h ; $5825
	sbc a, b ; $5826
	ld h, a ; $5827
	bit 7, h ; $5828
	jr z, Label_07_5851 ; $582a
	push de ; $582c
	ld l, $00 ; $582d
	ld a, [$c48c] ; $582f
	ld h, a ; $5832
	ld a, [$c48d] ; $5833
	ld e, c ; $5836
	ld d, b ; $5837
	call DivAHLByDESigned ; $5838
	pop de ; $583b
	call MulHLByDE ; $583c
	ld h, l ; $583f
	ldh a, [$ffa9] ; $5840
	ld l, a ; $5842
	ld e, l ; $5843
	ld d, h ; $5844
	add hl, hl ; $5845
	add hl, hl ; $5846
	ld a, h ; $5847
	ld [$c48f], a ; $5848
	ld hl, $c48c ; $584b
	ld a, e ; $584e
	ld [hl+], a ; $584f
	ld [hl], d ; $5850
Label_07_5851:
	ld hl, wBallHeight ; $5851
	ld a, [hl+] ; $5854
	ld d, [hl] ; $5855
	ld e, a ; $5856
	xor a, a ; $5857
	sub a, e ; $5858
	ld e, a ; $5859
	sbc a, a ; $585a
	sub a, d ; $585b
	ld d, a ; $585c
	ld hl, $c470 ; $585d
	ld a, e ; $5860
	ld [hl+], a ; $5861
	ld [hl], d ; $5862
	ld hl, $c430 ; $5863
	ld de, $c450 ; $5866
	ld a, [hl+] ; $5869
	ld [de], a ; $586a
	inc de ; $586b
	ld a, [hl+] ; $586c
	ld [de], a ; $586d
	inc de ; $586e
	ld a, [hl+] ; $586f
	ld [de], a ; $5870
	inc de ; $5871
	ld a, [hl+] ; $5872
	ld [de], a ; $5873
	inc de ; $5874
	ret ; $5875
NormalizeBallHeightForShot:
	ld hl, wBallHeight ; $5876
	ld a, [hl+] ; $5879
	ld d, [hl] ; $587a
	ld e, a ; $587b
	ld hl, $0060 ; $587c
	add hl, de ; $587f
	bit 7, h ; $5880
	jr nz, Label_07_5898 ; $5882
	ld hl, $0060 ; $5884
	add hl, de ; $5887
	sra h ; $5888
	rr l ; $588a
	ld a, e ; $588c
	sub a, l ; $588d
	ld e, a ; $588e
	ld a, d ; $588f
	sbc a, h ; $5890
	ld d, a ; $5891
	ld hl, wBallHeight ; $5892
	ld a, e ; $5895
	ld [hl+], a ; $5896
	ld [hl], d ; $5897
Label_07_5898:
	ret ; $5898
RaiseBallHeightForLob:
	ld hl, wBallHeight ; $5899
	ld a, [hl+] ; $589c
	ld d, [hl] ; $589d
	ld e, a ; $589e
	ld hl, $0080 ; $589f
	add hl, de ; $58a2
	bit 7, h ; $58a3
	jr nz, Label_07_58b1 ; $58a5
	ld de, hPeakLY ; $58a7
	ld hl, wBallHeight ; $58aa
	ld a, e ; $58ad
	ld [hl+], a ; $58ae
	ld [hl], d ; $58af
	ret ; $58b0
Label_07_58b1:
	ld hl, $0020 ; $58b1
	add hl, de ; $58b4
	ld e, l ; $58b5
	ld d, h ; $58b6
	ld hl, wBallHeight ; $58b7
	ld a, e ; $58ba
	ld [hl+], a ; $58bb
	ld [hl], d ; $58bc
	ret ; $58bd
Label_07_58be:
	ld a, $00 ; $58be
	ld [$c4a0], a ; $58c0
	call NormalizeBallHeightForShot ; $58c3
	call ApplyShotTypePresets ; $58c6
	call WeakenShotByCharge ; $58c9
	call ComputeShotTrajectory ; $58cc
	farcall FarPtr_22_00 ; $58cf
	ret ; $58d2
Label_07_58d3:
	ld hl, $df0f ; $58d3
	bit 1, [hl] ; $58d6
	jr nz, Label_07_58be ; $58d8
	ld a, $01 ; $58da
	ld [$c4a6], a ; $58dc
	call NormalizeBallHeightForShot ; $58df
	call ApplyShotTypePresets ; $58e2
	call ComputeShotTrajectory ; $58e5
	farcall FarPtr_23_00 ; $58e8
	ret ; $58eb
Label_07_58ec:
	ld a, $02 ; $58ec
	ld [$c4a0], a ; $58ee
	call NormalizeBallHeightForShot ; $58f1
	call ApplyShotTypePresets ; $58f4
	call WeakenShotByCharge ; $58f7
	call ComputeShotTrajectory ; $58fa
	farcall FarPtr_20_00 ; $58fd
	ret ; $5900
Label_07_5901:
	ld hl, $df0f ; $5901
	bit 1, [hl] ; $5904
	jr nz, Label_07_58ec ; $5906
	ld a, $01 ; $5908
	ld [$c4a6], a ; $590a
	call NormalizeBallHeightForShot ; $590d
	call ApplyShotTypePresets ; $5910
	call ComputeShotTrajectory ; $5913
	farcall FarPtr_21_00 ; $5916
	ret ; $5919
Label_07_591a:
	call RaiseBallHeightForLob ; $591a
	call ApplyShotTypePresets ; $591d
	call BoostShotByCharge ; $5920
	call NudgeShotByPlayerMomentum ; $5923
	farcall FarPtr_ComputeShotTrajectory ; $5926
	farcall FarPtr_24_00 ; $5929
	ret ; $592c
Label_07_592d:
	call RaiseBallHeightForLob ; $592d
	call ApplyShotTypePresets ; $5930
	call WeakenShotByCharge ; $5933
	call ComputeShotTrajectory ; $5936
	farcall FarPtr_24_02 ; $5939
	ret ; $593c
Label_07_593d:
	call CheckBallInSmashRange ; $593d
	jr z, Label_07_597c ; $5940
	call NormalizeBallHeightForShot ; $5942
	call ApplyShotTypePresets ; $5945
	call WeakenShotByCharge ; $5948
	call ComputeShotTrajectory ; $594b
	farcall FarPtr_2c_00 ; $594e
	ret ; $5951
Label_07_5952:
	call CheckBallInSmashRange ; $5952
	jr z, Label_07_597c ; $5955
	call NormalizeBallHeightForShot ; $5957
	call ApplyShotTypePresets ; $595a
	call WeakenShotByCharge ; $595d
	call ComputeShotTrajectory ; $5960
	farcall FarPtr_2c_02 ; $5963
	ret ; $5966
Label_07_5967:
	call CheckBallInSmashRange ; $5967
	jr z, Label_07_597c ; $596a
	call NormalizeBallHeightForShot ; $596c
	call ApplyShotTypePresets ; $596f
	call WeakenShotByCharge ; $5972
	call ComputeShotTrajectory ; $5975
	farcall FarPtr_2c_04 ; $5978
	ret ; $597b
Label_07_597c:
	ld a, $05 ; $597c
	ld [$c4a0], a ; $597e
	call NormalizeBallHeightForShot ; $5981
	call ApplyShotTypePresets ; $5984
	call WeakenShotByCharge ; $5987
	call ComputeShotTrajectory ; $598a
	farcall FarPtr_24_0c ; $598d
	ret ; $5990
Label_07_5991:
	ld a, $09 ; $5991
	ld [$c4a0], a ; $5993
	ld a, $01 ; $5996
	ld [$c4a6], a ; $5998
	call NormalizeBallHeightForShot ; $599b
	call ApplyShotTypePresets ; $599e
	call ComputeShotTrajectory ; $59a1
	farcall FarPtr_24_08 ; $59a4
	ret ; $59a7
Label_07_59a8:
	call CheckBallInSmashRange ; $59a8
	jr z, Label_07_59b8 ; $59ab
	ld a, [$df15] ; $59ad
	cp a, $07 ; $59b0
	jr z, Label_07_5991 ; $59b2
	cp a, $08 ; $59b4
	jr z, Label_07_5991 ; $59b6
Label_07_59b8:
	call NormalizeBallHeightForShot ; $59b8
	call ApplyShotTypePresets ; $59bb
	call ComputeShotTrajectory ; $59be
	farcall FarPtr_24_06 ; $59c1
	ret ; $59c4
Label_07_59c5:
	call ApplyShotTypePresets ; $59c5
	call ComputeShotTrajectory ; $59c8
	farcall FarPtr_29_00 ; $59cb
	call Func_07_5a01 ; $59ce
	ret ; $59d1
Label_07_59d2:
	call ApplyShotTypePresets ; $59d2
	call ComputeShotTrajectory ; $59d5
	farcall FarPtr_2a_00 ; $59d8
	call Func_07_5a01 ; $59db
	ret ; $59de
Label_07_59df:
	call ApplyShotTypePresets ; $59df
	call ComputeShotTrajectory ; $59e2
	farcall FarPtr_2b_00 ; $59e5
	call Func_07_5a01 ; $59e8
	ret ; $59eb
	ld hl, wBallHeight ; $59ec
	ld a, [hl+] ; $59ef
	ld h, [hl] ; $59f0
	ld l, a ; $59f1
	ld de, $0140 ; $59f2
	add hl, de ; $59f5
	jr c, Label_07_5a00 ; $59f6
	ld a, $01 ; $59f8
	ld [$c4a5], a ; $59fa
	ld [$c4a6], a ; $59fd
Label_07_5a00:
	ret ; $5a00
Func_07_5a01:
	ld hl, wBallHeight ; $5a01
	ld a, [hl+] ; $5a04
	ld h, [hl] ; $5a05
	ld l, a ; $5a06
	xor a, a ; $5a07
	sub a, l ; $5a08
	ld l, a ; $5a09
	sbc a, a ; $5a0a
	sub a, h ; $5a0b
	ld h, a ; $5a0c
	add hl, hl ; $5a0d
	add hl, hl ; $5a0e
	add hl, hl ; $5a0f
	add hl, hl ; $5a10
	ld a, h ; $5a11
	and a, $1f ; $5a12
	add a, $23 ; $5a14
	ld l, a ; $5a16
	adc a, $5a ; $5a17
	sub a, l ; $5a19
	ld h, a ; $5a1a
	ld a, [hl] ; $5a1b
	ld [$c4a5], a ; $5a1c
	ld [$c4a6], a ; $5a1f
	ret ; $5a22
	INCBIN "data/bank_007/d_5a23.bin" ; $5a23, 32 bytes
LookupCharSpriteSet:
	push hl ; $5a43
	and a, $3f ; $5a44
	add a, $50 ; $5a46
	ld l, a ; $5a48
	adc a, $5a ; $5a49
	sub a, l ; $5a4b
	ld h, a ; $5a4c
	ld a, [hl] ; $5a4d
	pop hl ; $5a4e
	ret ; $5a4f
CharSpriteSetTable:
	INCBIN "data/bank_007/d_5a50.bin" ; $5a50, 32 bytes
SetupCharacterSprite:
	push de ; $5a70
	farcall FarPtr_04_12 ; $5a71
	pop de ; $5a74
	ld a, e ; $5a75
	ld [$df3a], a ; $5a76
	ld a, [$df0b] ; $5a79
	add a, $04 ; $5a7c
	ld [$df37], a ; $5a7e
	ld a, [$df0b] ; $5a81
	add a, $af ; $5a84
	ld l, a ; $5a86
	adc a, $5a ; $5a87
	sub a, l ; $5a89
	ld h, a ; $5a8a
	ld a, [hl] ; $5a8b
	ld [$df36], a ; $5a8c
	ld a, [$df0b] ; $5a8f
	add a, a ; $5a92
	add a, $a7 ; $5a93
	ld l, a ; $5a95
	adc a, $5a ; $5a96
	sub a, l ; $5a98
	ld h, a ; $5a99
	ld a, [hl+] ; $5a9a
	ld d, [hl] ; $5a9b
	ld e, a ; $5a9c
	ld hl, $df26 ; $5a9d
	ld a, e ; $5aa0
	ld [hl+], a ; $5aa1
	ld [hl], d ; $5aa2
	farcall FarPtr_08_1e ; $5aa3
	ret ; $5aa6
	INCBIN "data/bank_007/d_5aa7.bin" ; $5aa7, 12 bytes
LoadCharacterAttributes:
	ld a, [$df0b] ; $5ab3
	add a, a ; $5ab6
	add a, $42 ; $5ab7
	ld l, a ; $5ab9
	adc a, $5c ; $5aba
	sub a, l ; $5abc
	ld h, a ; $5abd
	ld a, [hl+] ; $5abe
	ld d, [hl] ; $5abf
	ld e, a ; $5ac0
	ld hl, $0010 ; $5ac1
	add hl, de ; $5ac4
	ld a, [hl+] ; $5ac5
	ld b, [hl] ; $5ac6
	ld c, a ; $5ac7
	ld hl, $fff0 ; $5ac8
	add hl, bc ; $5acb
	ld c, l ; $5acc
	ld b, h ; $5acd
	ld hl, $df70 ; $5ace
	ld a, c ; $5ad1
	ld [hl+], a ; $5ad2
	ld [hl], b ; $5ad3
	ld hl, $0012 ; $5ad4
	add hl, de ; $5ad7
	ld a, [hl+] ; $5ad8
	ld b, [hl] ; $5ad9
	ld c, a ; $5ada
	ld hl, $df72 ; $5adb
	ld a, c ; $5ade
	ld [hl+], a ; $5adf
	ld [hl], b ; $5ae0
	ld hl, $0014 ; $5ae1
	add hl, de ; $5ae4
	ld a, [hl+] ; $5ae5
	ld b, [hl] ; $5ae6
	ld c, a ; $5ae7
	ld hl, $0200 ; $5ae8
	add hl, bc ; $5aeb
	ld c, l ; $5aec
	ld b, h ; $5aed
	ld hl, $df74 ; $5aee
	ld a, c ; $5af1
	ld [hl+], a ; $5af2
	ld [hl], b ; $5af3
	ld hl, $0016 ; $5af4
	add hl, de ; $5af7
	ld a, [hl+] ; $5af8
	ld b, [hl] ; $5af9
	ld c, a ; $5afa
	ld hl, $df76 ; $5afb
	ld a, c ; $5afe
	ld [hl+], a ; $5aff
	ld [hl], b ; $5b00
	ld hl, $0019 ; $5b01
	add hl, de ; $5b04
	ld a, [hl+] ; $5b05
	ld b, [hl] ; $5b06
	ld c, a ; $5b07
	ld hl, $df90 ; $5b08
	ld a, c ; $5b0b
	ld [hl+], a ; $5b0c
	ld [hl], b ; $5b0d
	ld hl, $0018 ; $5b0e
	add hl, de ; $5b11
	ld a, [hl] ; $5b12
	ld [$df95], a ; $5b13
	ld b, $00 ; $5b16
	ld hl, $000e ; $5b18
	add hl, de ; $5b1b
	ld a, [hl] ; $5b1c
	and a, a ; $5b1d
	jr z, Label_07_5b22 ; $5b1e
	ld b, $20 ; $5b20
Label_07_5b22:
	ld a, b ; $5b22
	ld [$df94], a ; $5b23
	ld hl, $0027 ; $5b26
	add hl, de ; $5b29
	ld a, [hl] ; $5b2a
	add a, a ; $5b2b
	add a, $4a ; $5b2c
	ld l, a ; $5b2e
	adc a, $5c ; $5b2f
	sub a, l ; $5b31
	ld h, a ; $5b32
	ld a, [hl+] ; $5b33
	ld b, [hl] ; $5b34
	ld c, a ; $5b35
	ld hl, $df60 ; $5b36
	ld a, c ; $5b39
	ld [hl+], a ; $5b3a
	ld [hl], b ; $5b3b
	ld hl, $0027 ; $5b3c
	add hl, de ; $5b3f
	ld a, [hl] ; $5b40
	ld hl, $002b ; $5b41
	add hl, de ; $5b44
	add a, [hl] ; $5b45
	add a, a ; $5b46
	jr nc, Label_07_5b4c ; $5b47
	xor a, a ; $5b49
	jr Label_07_5b54 ; $5b4a
Label_07_5b4c:
	rra ; $5b4c
	cp a, $0a ; $5b4d
	jr c, Label_07_5b54 ; $5b4f
	ld a, $0a ; $5b51
	dec a ; $5b53
Label_07_5b54:
	add a, a ; $5b54
	add a, $4a ; $5b55
	ld l, a ; $5b57
	adc a, $5c ; $5b58
	sub a, l ; $5b5a
	ld h, a ; $5b5b
	ld a, [hl+] ; $5b5c
	ld b, [hl] ; $5b5d
	ld c, a ; $5b5e
	ld hl, $df62 ; $5b5f
	ld a, c ; $5b62
	ld [hl+], a ; $5b63
	ld [hl], b ; $5b64
	ld hl, $0028 ; $5b65
	add hl, de ; $5b68
	ld a, [hl] ; $5b69
	add a, a ; $5b6a
	add a, $5e ; $5b6b
	ld l, a ; $5b6d
	adc a, $5c ; $5b6e
	sub a, l ; $5b70
	ld h, a ; $5b71
	ld a, [hl+] ; $5b72
	ld b, [hl] ; $5b73
	ld c, a ; $5b74
	ld hl, $df64 ; $5b75
	ld a, c ; $5b78
	ld [hl+], a ; $5b79
	ld [hl], b ; $5b7a
	ld hl, $002a ; $5b7b
	add hl, de ; $5b7e
	ld a, [hl] ; $5b7f
	add a, a ; $5b80
	add a, $72 ; $5b81
	ld l, a ; $5b83
	adc a, $5c ; $5b84
	sub a, l ; $5b86
	ld h, a ; $5b87
	ld a, [hl+] ; $5b88
	ld b, [hl] ; $5b89
	ld c, a ; $5b8a
	ld hl, $df66 ; $5b8b
	ld a, c ; $5b8e
	ld [hl+], a ; $5b8f
	ld [hl], b ; $5b90
	ld hl, $0029 ; $5b91
	add hl, de ; $5b94
	ld a, [hl] ; $5b95
	add a, $86 ; $5b96
	ld l, a ; $5b98
	adc a, $5c ; $5b99
	sub a, l ; $5b9b
	ld h, a ; $5b9c
	ld a, [hl] ; $5b9d
	ld [$df68], a ; $5b9e
	ld hl, $0025 ; $5ba1
	add hl, de ; $5ba4
	ld a, [hl] ; $5ba5
	add a, $90 ; $5ba6
	ld l, a ; $5ba8
	adc a, $5c ; $5ba9
	sub a, l ; $5bab
	ld h, a ; $5bac
	ld a, [hl] ; $5bad
	ld [$df69], a ; $5bae
	ld hl, $0026 ; $5bb1
	add hl, de ; $5bb4
	ld a, [hl] ; $5bb5
	add a, $9a ; $5bb6
	ld l, a ; $5bb8
	adc a, $5c ; $5bb9
	sub a, l ; $5bbb
	ld h, a ; $5bbc
	ld a, [hl] ; $5bbd
	ld [$df6a], a ; $5bbe
	ld hl, $0023 ; $5bc1
	add hl, de ; $5bc4
	ld a, [hl] ; $5bc5
	ld [$df6b], a ; $5bc6
	ld hl, $0022 ; $5bc9
	add hl, de ; $5bcc
	ld a, [hl] ; $5bcd
	ld [$df6c], a ; $5bce
	ld hl, $0024 ; $5bd1
	add hl, de ; $5bd4
	ld a, [hl] ; $5bd5
	ld [$df6d], a ; $5bd6
	ld hl, $0021 ; $5bd9
	add hl, de ; $5bdc
	ld a, [hl] ; $5bdd
	ld [$df6f], a ; $5bde
	ld hl, $0020 ; $5be1
	add hl, de ; $5be4
	ld a, [hl] ; $5be5
	ld [$df6e], a ; $5be6
	ld hl, $000f ; $5be9
	add hl, de ; $5bec
	ld a, [hl] ; $5bed
	ld [$df7f], a ; $5bee
	ld hl, $001b ; $5bf1
	add hl, de ; $5bf4
	ld a, [hl] ; $5bf5
	ld [$df79], a ; $5bf6
	ld hl, $001c ; $5bf9
	add hl, de ; $5bfc
	ld a, [hl] ; $5bfd
	ld [$df7a], a ; $5bfe
	ld hl, $001d ; $5c01
	add hl, de ; $5c04
	ld a, [hl] ; $5c05
	ld [$df7b], a ; $5c06
	ld hl, $001e ; $5c09
	add hl, de ; $5c0c
	ld a, [hl] ; $5c0d
	ld [$df7c], a ; $5c0e
	ld hl, $001f ; $5c11
	add hl, de ; $5c14
	ld a, [hl] ; $5c15
	ld [$df7d], a ; $5c16
	ld a, $00 ; $5c19
	ld hl, $df91 ; $5c1b
	bit 0, [hl] ; $5c1e
	jr z, Label_07_5c24 ; $5c20
	ld a, $01 ; $5c22
Label_07_5c24:
	ld [$df92], a ; $5c24
	ld a, $00 ; $5c27
	ld hl, $df91 ; $5c29
	bit 1, [hl] ; $5c2c
	jr z, Label_07_5c32 ; $5c2e
	ld a, $01 ; $5c30
Label_07_5c32:
	ld [$df93], a ; $5c32
	ld a, [$c4ee] ; $5c35
	bit 1, a ; $5c38
	ret z ; $5c3a
	ld a, [$df0b] ; $5c3b
	call OverrideCharStatsForDebug ; $5c3e
	ret ; $5c41
	INCBIN "data/bank_007/d_5c42.bin" ; $5c42, 178 bytes
OverrideCharStatsForDebug:
	push af ; $5cf4
	ld a, $04 ; $5cf5
	ld [$df79], a ; $5cf7
	ld a, $04 ; $5cfa
	ld [$df7a], a ; $5cfc
	ld a, $00 ; $5cff
	ld [$df7b], a ; $5d01
	ld a, $ff ; $5d04
	ld [$df7c], a ; $5d06
	ld a, $02 ; $5d09
	ld [$df7d], a ; $5d0b
	ld a, $00 ; $5d0e
	ld [$df6a], a ; $5d10
	ld a, $01 ; $5d13
	ld [$df7f], a ; $5d15
	ld a, $01 ; $5d18
	ld a, $01 ; $5d1a
	pop af ; $5d1c
	ret ; $5d1d
	add a, a ; $5d1e
	add a, a ; $5d1f
	add a, a ; $5d20
	add a, a ; $5d21
	add a, $a4 ; $5d22
	ld l, a ; $5d24
	adc a, $5c ; $5d25
	sub a, l ; $5d27
	ld h, a ; $5d28
	ld a, [hl+] ; $5d29
	push hl ; $5d2a
	add a, a ; $5d2b
	add a, $4a ; $5d2c
	ld l, a ; $5d2e
	adc a, $5c ; $5d2f
	sub a, l ; $5d31
	ld h, a ; $5d32
	ld a, [hl+] ; $5d33
	ld d, [hl] ; $5d34
	ld e, a ; $5d35
	ld hl, $0060 ; $5d36
	add hl, bc ; $5d39
	ld a, e ; $5d3a
	ld [hl+], a ; $5d3b
	ld [hl], d ; $5d3c
	pop hl ; $5d3d
	ld a, [hl+] ; $5d3e
	push hl ; $5d3f
	add a, a ; $5d40
	add a, $4a ; $5d41
	ld l, a ; $5d43
	adc a, $5c ; $5d44
	sub a, l ; $5d46
	ld h, a ; $5d47
	ld a, [hl+] ; $5d48
	ld d, [hl] ; $5d49
	ld e, a ; $5d4a
	ld hl, $0062 ; $5d4b
	add hl, bc ; $5d4e
	ld a, e ; $5d4f
	ld [hl+], a ; $5d50
	ld [hl], d ; $5d51
	pop hl ; $5d52
	ld a, [hl+] ; $5d53
	push hl ; $5d54
	add a, a ; $5d55
	add a, $5e ; $5d56
	ld l, a ; $5d58
	adc a, $5c ; $5d59
	sub a, l ; $5d5b
	ld h, a ; $5d5c
	ld a, [hl+] ; $5d5d
	ld d, [hl] ; $5d5e
	ld e, a ; $5d5f
	ld hl, $0064 ; $5d60
	add hl, bc ; $5d63
	ld a, e ; $5d64
	ld [hl+], a ; $5d65
	ld [hl], d ; $5d66
	pop hl ; $5d67
	ld a, [hl+] ; $5d68
	push hl ; $5d69
	add a, a ; $5d6a
	add a, $72 ; $5d6b
	ld l, a ; $5d6d
	adc a, $5c ; $5d6e
	sub a, l ; $5d70
	ld h, a ; $5d71
	ld a, [hl+] ; $5d72
	ld d, [hl] ; $5d73
	ld e, a ; $5d74
	ld hl, $0066 ; $5d75
	add hl, bc ; $5d78
	ld a, e ; $5d79
	ld [hl+], a ; $5d7a
	ld [hl], d ; $5d7b
	pop hl ; $5d7c
	ld a, [hl+] ; $5d7d
	push hl ; $5d7e
	add a, $86 ; $5d7f
	ld l, a ; $5d81
	adc a, $5c ; $5d82
	sub a, l ; $5d84
	ld h, a ; $5d85
	ld a, [hl] ; $5d86
	ld hl, $0068 ; $5d87
	add hl, bc ; $5d8a
	ld [hl], a ; $5d8b
	pop hl ; $5d8c
	ld a, [hl+] ; $5d8d
	push hl ; $5d8e
	add a, $90 ; $5d8f
	ld l, a ; $5d91
	adc a, $5c ; $5d92
	sub a, l ; $5d94
	ld h, a ; $5d95
	ld a, [hl] ; $5d96
	ld hl, $0069 ; $5d97
	add hl, bc ; $5d9a
	ld [hl], a ; $5d9b
	pop hl ; $5d9c
	ld a, [hl+] ; $5d9d
	push hl ; $5d9e
	add a, $9a ; $5d9f
	ld l, a ; $5da1
	adc a, $5c ; $5da2
	sub a, l ; $5da4
	ld h, a ; $5da5
	ld a, [hl] ; $5da6
	ld hl, $006a ; $5da7
	add hl, bc ; $5daa
	ld [hl], a ; $5dab
	pop hl ; $5dac
	ld a, $6b ; $5dad
	add a, c ; $5daf
	ld e, a ; $5db0
	ld d, b ; $5db1
	ld a, [hl+] ; $5db2
	ld [de], a ; $5db3
	ld a, $6c ; $5db4
	add a, c ; $5db6
	ld e, a ; $5db7
	ld d, b ; $5db8
	ld a, [hl+] ; $5db9
	ld [de], a ; $5dba
	ld a, $6d ; $5dbb
	add a, c ; $5dbd
	ld e, a ; $5dbe
	ld d, b ; $5dbf
	ld a, [hl+] ; $5dc0
	ld [de], a ; $5dc1
	ld a, $6e ; $5dc2
	add a, c ; $5dc4
	ld e, a ; $5dc5
	ld d, b ; $5dc6
	ld a, [hl+] ; $5dc7
	ld [de], a ; $5dc8
	ld a, $6f ; $5dc9
	add a, c ; $5dcb
	ld e, a ; $5dcc
	ld d, b ; $5dcd
	ld a, [hl+] ; $5dce
	ld [de], a ; $5dcf
	ld hl, $0070 ; $5dd0
	add hl, bc ; $5dd3
	ld de, $0080 ; $5dd4
	ld a, e ; $5dd7
	ld [hl+], a ; $5dd8
	ld [hl], d ; $5dd9
	ld hl, $0072 ; $5dda
	add hl, bc ; $5ddd
	ld de, $00a0 ; $5dde
	ld a, e ; $5de1
	ld [hl+], a ; $5de2
	ld [hl], d ; $5de3
	ld hl, $0074 ; $5de4
	add hl, bc ; $5de7
	ld de, $0800 ; $5de8
	ld a, e ; $5deb
	ld [hl+], a ; $5dec
	ld [hl], d ; $5ded
	ld hl, $0076 ; $5dee
	add hl, bc ; $5df1
	ld de, $000c ; $5df2
	ld a, e ; $5df5
	ld [hl+], a ; $5df6
	ld [hl], d ; $5df7
	ret ; $5df8
RunDebugTestMatch:
	ld a, $04 ; $5df9
	ld [wGameMode], a ; $5dfb
	ld a, $03 ; $5dfe
	ld [$c36c], a ; $5e00
	ld a, $01 ; $5e03
	ld [$c8a7], a ; $5e05
	ld a, $01 ; $5e08
	ld [wPlayer1SetsWon], a ; $5e0a
	ld [wPlayer1GamesWon], a ; $5e0d
	ld [wPlayer1PointsWon], a ; $5e10
	ld [wPlayer2SetsWon], a ; $5e13
	ld [wPlayer2GamesWon], a ; $5e16
	ld [wPlayer2PointsWon], a ; $5e19
	ld a, $02 ; $5e1c
	ld [wPlayer1GamesWon], a ; $5e1e
	ld a, $01 ; $5e21
	ld [wTotalGamesWonInMatch], a ; $5e23
	ld [wCharacter1ServiceAces], a ; $5e26
	ld [wCharacter1ReturnAces], a ; $5e29
	ld [wCharacter1SmashAces], a ; $5e2c
	ld [wCharacter1LobShotWinners], a ; $5e2f
	ld [wCharacter1DropShotWinners], a ; $5e32
	ld [wCharacter1Faults], a ; $5e35
	ld [wCharacter1DoubleFaults], a ; $5e38
	ld [wCharacter3ServiceAces], a ; $5e3b
	ld [wCharacter3ReturnAces], a ; $5e3e
	ld [wCharacter3SmashAces], a ; $5e41
	ld [wCharacter3LobShotWinners], a ; $5e44
	ld [wCharacter3DropShotWinners], a ; $5e47
	ld a, $62 ; $5e4a
	ld [wCharacter2ReturnAces], a ; $5e4c
	ld a, $01 ; $5e4f
	ld [wMatchIsDoubles], a ; $5e51
	ld a, $04 ; $5e54
	ld [wOnCourtCharCount], a ; $5e56
	ld a, $05 ; $5e59
	ld [wCurrentlyUsedCourt], a ; $5e5b
	ld a, $03 ; $5e5e
	ld [wMatchTypeNumberOfSets], a ; $5e60
	ld a, $02 ; $5e63
	ld [wMatchTypeNumberOfGames], a ; $5e65
	ld a, $1a ; $5e68
	ld [$c3b0], a ; $5e6a
	ld b, a ; $5e6d
	ld c, $00 ; $5e6e
	farcall FarPtr_02_18 ; $5e70
	ld a, $1d ; $5e73
	ld [$c3b1], a ; $5e75
	ld b, a ; $5e78
	ld c, $02 ; $5e79
	farcall FarPtr_02_18 ; $5e7b
	ld a, $1f ; $5e7e
	ld b, a ; $5e80
	ld c, $01 ; $5e81
	farcall FarPtr_02_18 ; $5e83
	ld a, $1c ; $5e86
	ld b, a ; $5e88
	ld c, $03 ; $5e89
	farcall FarPtr_02_18 ; $5e8b
	ld a, $00 ; $5e8e
	farcall FarPtr_SetStorySlotFlagB ; $5e90
	ld a, $01 ; $5e93
	farcall FarPtr_SetStorySlotFlagA ; $5e95
	ld a, $fe ; $5e98
	ld [$c4ee], a ; $5e9a
	farcall FarPtr_RunMatch ; $5e9d
	ret ; $5ea0
	farcall FarPtr_08_06 ; $5ea1
	ld a, $02 ; $5ea4
	ld [wCurrentlyUsedCourt], a ; $5ea6
	ld a, $02 ; $5ea9
	ld [wOnCourtCharCount], a ; $5eab
	ldh a, [hRomBank] ; $5eae
	ld de, ModeHookTable_07 ; $5eb0
	farcall FarPtr_SetModeHookTable ; $5eb3
	ld de, $5ff6 ; $5eb6
	farcall FarPtr_08_4a ; $5eb9
	ld a, $01 ; $5ebc
	ld [wTargetZoneEnabled], a ; $5ebe
	ld a, $1a ; $5ec1
	ld [$c3b0], a ; $5ec3
	ld a, $1c ; $5ec6
	ld [$c3b1], a ; $5ec8
	farcall FarPtr_Func_3b_44aa ; $5ecb
	farcall FarPtr_08_08 ; $5ece
	ret ; $5ed1
Func_07_5ed2:
	ret ; $5ed2
ResolveTargetModePoint:
	farcall FarPtr_09_26 ; $5ed3
	farcall FarPtr_ResolvePointWinner ; $5ed6
	ld [wPointWinLoseFlag], a ; $5ed9
	farcall FarPtr_UpdatePointStats ; $5edc
	farcall FarPtr_AwardPoint ; $5edf
	ld a, [wPlayer1PointsWon] ; $5ee2
	ld b, $01 ; $5ee5
	farcall FarPtr_09_2a ; $5ee7
	ld a, [wPlayer2PointsWon] ; $5eea
	ld b, $01 ; $5eed
	farcall FarPtr_09_2c ; $5eef
	farcall FarPtr_StepMatchFrame ; $5ef2
	farcall FarPtr_StartPointEndReactions ; $5ef5
	farcall FarPtr_ResolvePointOutcome ; $5ef8
	ret ; $5efb
ModeHookTable_07:
	INCBIN "data/bank_007/d_5efc.bin" ; $5efc, 17 bytes
	test_flag $0c, 4 ; $5f0d
	ret z ; $5f10
	ld a, $01 ; $5f11
	ld [$c4c0], a ; $5f13
	ld a, $14 ; $5f16
	farcall FarPtr_StepMatchFrames ; $5f18
	ld a, $00 ; $5f1b
	ld [$c4c0], a ; $5f1d
	clear_flag $0c, 4 ; $5f20
	ret ; $5f23
	ret ; $5f24
	farcall FarPtr_IsBallInTargetZone ; $5f25
	jr z, Label_07_5f48 ; $5f28
	farcall FarPtr_AdvanceMatchRng ; $5f2a
	ld h, $00 ; $5f2d
	ld l, a ; $5f2f
	add hl, hl ; $5f30
	xor a, a ; $5f31
	sub a, l ; $5f32
	ld l, a ; $5f33
	sbc a, a ; $5f34
	sub a, h ; $5f35
	ld h, a ; $5f36
	ld e, l ; $5f37
	ld d, h ; $5f38
	farcall FarPtr_08_52 ; $5f39
	farcall FarPtr_AdvanceMatchRng ; $5f3c
	ld h, $00 ; $5f3f
	ld l, a ; $5f41
	add hl, hl ; $5f42
	ld e, l ; $5f43
	ld d, h ; $5f44
	farcall FarPtr_08_54 ; $5f45
Label_07_5f48:
	ret ; $5f48
	set_flag $0c, 4 ; $5f49
	ret ; $5f4c
	ld hl, $fdc0 ; $5f4d
	ld de, $fd80 ; $5f50
	farcall FarPtr_08_4c ; $5f53
	ld hl, $0240 ; $5f56
	ld de, $fd80 ; $5f59
	farcall FarPtr_08_4e ; $5f5c
	ld hl, $ff60 ; $5f5f
	ld de, $fd60 ; $5f62
	farcall FarPtr_08_52 ; $5f65
	ld hl, $0000 ; $5f68
	ld de, rJOYP ; $5f6b
	farcall FarPtr_08_54 ; $5f6e
	call Func_07_5ed2 ; $5f71
	ret ; $5f74
	ld hl, $013f ; $5f75
	ld de, $000b ; $5f78
	ld bc, $1305 ; $5f7b
	farcall FarPtr_ShowMessageWindow ; $5f7e
	call ResolveTargetModePoint ; $5f81
	ld a, [wCharacter1ServiceAces] ; $5f84
	ld hl, wCharacter2ServiceAces ; $5f87
	cp a, [hl] ; $5f8a
	jr nz, Label_07_5f8e ; $5f8b
	ret ; $5f8d
Label_07_5f8e:
	ld a, $ff ; $5f8e
	ld [$c4c3], a ; $5f90
	ret ; $5f93
	INCBIN "data/bank_007/d_5f94.bin" ; $5f94, 162 bytes
	ds 8138, $ff ; $6036, fill
