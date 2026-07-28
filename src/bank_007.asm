SECTION "ROM Bank $07", ROMX[$4000], BANK[$07]

	farptr TryEstablishLink ; $4000
	farptr EnableSerialAndVBlankInterrupts ; $4002
	farptr RunLinkMatchFrameMaster ; $4004
	farptr RunLinkMatchFrameSlave ; $4006
	farptr ExchangeNibbleBlockMaster ; $4008
	farptr ExchangeNibbleBlockSlave ; $400a
	farptr SendNibbleBlockSlave ; $400c
	farptr ReceiveNibbleBlockMaster ; $400e
	farptr UnpackBytesToNibbles ; $4010
	farptr ExchangeLinkFrameByteMaster ; $4012
	farptr ExchangeLinkFrameByteSlave ; $4014
	farptr SyncLinkFrameMaster ; $4016
	farptr SyncLinkFrameSlave ; $4018
	farptr SyncLinkFrame ; $401a
	farptr RunLinkMatchFrame ; $401c
	farptr ExchangeLinkReadySignal ; $401e
	farptr RunLinkInputFrame ; $4020
	farptr UpdateLinkSession ; $4022
	farptr EndLinkSession ; $4024
	farptr ExchangeHandshakeBlockMaster ; $4026
	farptr ExchangeHandshakeBlockSlave ; $4028
	farptr ExchangeLinkBlockToWram5 ; $402a
	farptr PrimeSlaveSerialReply ; $402c
	farptr PrepareLinkStatePayload ; $402e
	farptr PrepareLinkInputPayload ; $4030
	farptr ResyncLinkSession ; $4032
	farptr ResyncLinkSessionWithTimer ; $4034
	farptr RunLinkCommandFrame ; $4036
	farptr ExchangeLinkDataBlock ; $4038
	farptr ComputeShotPlacement ; $403a
	farptr ExecuteShot ; $403c
	farptr ComputeShotTrajectory ; $403e
	farptr LookupCharSpriteSet ; $4040
	farptr SetupCharacterSprite ; $4042
	farptr LoadCharacterAttributes ; $4044
	farptr RunDebugTestMatch ; $4046
TryEstablishLink:
	di ; $4048
	ldh a, [hLinkRxByte] ; $4049
	ei ; $404b
	cp $c1 ; $404c
	jr z, .probe ; $404e
	ld a, $01 ; $4050
	ldh [hLinkState], a ; $4052
	call TryLinkHandshakeMaster ; $4054
	jr nc, .done ; $4057
	push af ; $4059
	call ResetSerialState ; $405a
	pop af ; $405d
	scf ; $405e
	jr .done ; $405f
.probe:
	di ; $4061
	xor a ; $4062
	ldh [hLinkRxByte], a ; $4063
	xor a ; $4065
	ldh [hLinkTransferDone], a ; $4066
	ei ; $4068
	ld a, $02 ; $4069
	ldh [hLinkState], a ; $406b
	call TryLinkHandshakeSlave ; $406d
	jr nc, .done ; $4070
	call ResetSerialState ; $4072
	scf ; $4075
.done:
	ret ; $4076
EnableSerialAndVBlankInterrupts:
	di ; $4077
	xor a ; $4078
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
	ldh a, [hLinkInput] ; $408c
	call SoftResetIfABStartSelect ; $408e
	farcall UpdateMatchFrame ; $4091
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
	ldh a, [hLinkInput] ; $40a5
	call SoftResetIfABStartSelect ; $40a7
	farcall UpdateMatchFrame ; $40aa
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
	jr nc, .haveLength ; $40ba
	call LinkErrorReset ; $40bc
.haveLength:
	ld c, a ; $40bf
	call ComputeNibbleBufferChecksum ; $40c0
.startBlock:
	call ShortDelay ; $40c3
	call ShortDelay ; $40c6
	call ShortDelay ; $40c9
	call ShortDelay ; $40cc
	ld e, $64 ; $40cf
.syncLoop:
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
	ldh a, [hLinkRxByte] ; $40eb
	ei ; $40ed
	cp $c4 ; $40ee
	jr z, .synced ; $40f0
	dec e ; $40f2
	jr nz, .syncLoop ; $40f3
	call LinkErrorReset ; $40f5
.synced:
	xor a ; $40f8
	ldh [hLinkNibbleAccum], a ; $40f9
	ldh [hLinkBlockOffset], a ; $40fb
	ld de, $0000 ; $40fd
	ld b, c ; $4100
.nibbleLoop:
	ld hl, $ce40 ; $4101
	ldh a, [hLinkBlockOffset] ; $4104
	add l ; $4106
	ld l, a ; $4107
	jr nc, .loadTxNibble ; $4108
	inc h ; $410a
.loadTxNibble:
	ld a, [hl] ; $410b
	ldh [hLinkTxByte], a ; $410c
.sendRetry:
	ldh a, [hLinkTxByte] ; $410e
	or $40 ; $4110
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
	jr c, .sendRetry ; $412a
	ld h, a ; $412c
	and $c0 ; $412d
	cp $80 ; $412f
	jr z, .storeRxNibble ; $4131
	call LinkErrorReset ; $4133
.storeRxNibble:
	ld a, h ; $4136
	push af ; $4137
	ld hl, $cea0 ; $4138
	ldh a, [hLinkNibbleAccum] ; $413b
	add l ; $413d
	ld l, a ; $413e
	jr nc, .accumulate ; $413f
	inc h ; $4141
.accumulate:
	pop af ; $4142
	and $3f ; $4143
	ld [hl], a ; $4145
	add e ; $4146
	ld e, a ; $4147
	jr nc, .nextNibble ; $4148
	inc d ; $414a
.nextNibble:
	xor a ; $414b
	ldh [hLinkCounter], a ; $414c
	ld hl, hLinkBlockOffset ; $414e
	inc [hl] ; $4151
	ld hl, hLinkNibbleAccum ; $4152
	inc [hl] ; $4155
	dec b ; $4156
	jr nz, .nibbleLoop ; $4157
	ld a, $c5 ; $4159
	ld b, $c6 ; $415b
	call SendByteAwaitEchoMaster ; $415d
	jr nc, .sendBlockEnd ; $4160
	call LinkErrorReset ; $4162
.sendBlockEnd:
	ld a, $cc ; $4165
	call SendByteGetReplyMaster ; $4167
	cp $cc ; $416a
	jr z, .compareChecksum ; $416c
	call LinkErrorReset ; $416e
.compareChecksum:
	call ExchangeChecksumMaster ; $4171
	ldh a, [hLinkBlockChecksum] ; $4174
	ld e, a ; $4176
	ldh a, [hLinkBlockChecksum + 1] ; $4177
	ld d, a ; $4179
	push hl ; $417a
	push de ; $417b
	ld a, l ; $417c
	sub e ; $417d
	ld l, a ; $417e
	ld a, h ; $417f
	sbc d ; $4180
	ld h, a ; $4181
	ld a, h ; $4182
	or l ; $4183
	pop de ; $4184
	pop hl ; $4185
	jp z, .checksumOk ; $4186
	ld a, $cb ; $4189
	call SendByteGetReplyMaster ; $418b
	cp $cd ; $418e
	jp z, .startBlock ; $4190
	cp $cb ; $4193
	jp z, .startBlock ; $4195
	call LinkErrorReset ; $4198
.checksumOk:
	ld a, $cd ; $419b
	call SendByteGetReplyMaster ; $419d
	cp $cd ; $41a0
	jr z, .done ; $41a2
	cp $cb ; $41a4
	jp z, .startBlock ; $41a6
	call LinkErrorReset ; $41a9
.done:
	pop hl ; $41ac
	pop de ; $41ad
	pop bc ; $41ae
	pop af ; $41af
	ret ; $41b0
DelayByLinkPhase:
	push af ; $41b1
	push bc ; $41b2
	ld bc, $007d ; $41b3
.spinLoop:
	dec bc ; $41b6
	ld a, c ; $41b7
	or b ; $41b8
	jr nz, .spinLoop ; $41b9
	ldh a, [hLinkPhaseDelay] ; $41bb
	dec a ; $41bd
	bit 7, a ; $41be
	jr z, .done ; $41c0
	push af ; $41c2
	push bc ; $41c3
	push de ; $41c4
	push hl ; $41c5
	di ; $41c6
	ldh a, [hLinkRxByte] ; $41c7
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
	ldh [hLinkRxByte], a ; $41e1
	ei ; $41e3
	pop hl ; $41e4
	pop de ; $41e5
	pop bc ; $41e6
	pop af ; $41e7
	ld a, $0f ; $41e8
.done:
	ldh [hLinkPhaseDelay], a ; $41ea
	pop bc ; $41ec
	pop af ; $41ed
	ret ; $41ee
ExchangeNibbleBlockSlave:
	push af ; $41ef
	push bc ; $41f0
	push de ; $41f1
	push hl ; $41f2
	call UnpackBytesToNibbles ; $41f3
	jr nc, .haveLength ; $41f6
	call LinkErrorReset ; $41f8
.haveLength:
	ld c, a ; $41fb
	call ComputeNibbleBufferChecksum ; $41fc
.startBlock:
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
	or $80 ; $4215
	ldh [hLinkTxByte], a ; $4217
	ei ; $4219
	ld e, $64 ; $421a
.syncLoop:
	call WaitSerialTransfer ; $421c
	jr c, .syncFailed ; $421f
	di ; $4221
	ldh a, [hLinkRxByte] ; $4222
	ei ; $4224
	cp $c3 ; $4225
	jr z, .synced ; $4227
	dec e ; $4229
	jr nz, .syncLoop ; $422a
.syncFailed:
	call LinkErrorReset ; $422c
.synced:
	ld a, $01 ; $422f
	ldh [hLinkBlockOffset], a ; $4231
	xor a ; $4233
	ldh [hLinkNibbleAccum], a ; $4234
	ld de, $0000 ; $4236
	ld b, c ; $4239
	dec b ; $423a
.nibbleLoop:
	di ; $423b
	ldh a, [rIF] ; $423c
	and $f7 ; $423e
	ldh [rIF], a ; $4240
	xor a ; $4242
	ldh [hLinkTransferDone], a ; $4243
	ld hl, $ce40 ; $4245
	ldh a, [hLinkBlockOffset] ; $4248
	add l ; $424a
	ld l, a ; $424b
	jr nc, .loadTxNibble ; $424c
	inc h ; $424e
.loadTxNibble:
	ld a, [hl] ; $424f
	or $80 ; $4250
	ldh [hLinkTxByte], a ; $4252
	ei ; $4254
	call WaitSerialTransfer ; $4255
	jr nc, .pollReply ; $4258
	call LinkErrorReset ; $425a
.pollReply:
	call PollSerialResponse ; $425d
	jr nc, .checkTag ; $4260
	call LinkErrorReset ; $4262
.checkTag:
	ld c, a ; $4265
	and $c0 ; $4266
	cp $40 ; $4268
	jr z, .storeRxNibble ; $426a
	call LinkErrorReset ; $426c
.storeRxNibble:
	ld hl, $cea0 ; $426f
	ldh a, [hLinkNibbleAccum] ; $4272
	add l ; $4274
	ld l, a ; $4275
	jr nc, .accumulate ; $4276
	inc h ; $4278
.accumulate:
	ld a, c ; $4279
	and $3f ; $427a
	ld [hl], a ; $427c
	add e ; $427d
	ld e, a ; $427e
	jr nc, .nextNibble ; $427f
	inc d ; $4281
.nextNibble:
	xor a ; $4282
	ldh [hLinkCounter], a ; $4283
	ld hl, hLinkBlockOffset ; $4285
	inc [hl] ; $4288
	ld hl, hLinkNibbleAccum ; $4289
	inc [hl] ; $428c
	dec b ; $428d
	jr nz, .nibbleLoop ; $428e
	di ; $4290
	ldh a, [rIF] ; $4291
	and $f7 ; $4293
	ldh [rIF], a ; $4295
	xor a ; $4297
	ldh [hLinkTransferDone], a ; $4298
	ld a, $c6 ; $429a
	ldh [hLinkTxByte], a ; $429c
	ei ; $429e
	call WaitSerialTransfer ; $429f
	di ; $42a2
	ldh a, [hLinkRxByte] ; $42a3
	ei ; $42a5
	ld b, a ; $42a6
	and $c0 ; $42a7
	cp $40 ; $42a9
	jr z, .storeLastNibble ; $42ab
	call LinkErrorReset ; $42ad
.storeLastNibble:
	ld hl, $cea0 ; $42b0
	ldh a, [hLinkNibbleAccum] ; $42b3
	add l ; $42b5
	ld l, a ; $42b6
	jr nc, .accumulateLast ; $42b7
	inc h ; $42b9
.accumulateLast:
	ld a, b ; $42ba
	and $3f ; $42bb
	ld [hl], a ; $42bd
	add e ; $42be
	ld e, a ; $42bf
	jr nc, .sendBlockEnd ; $42c0
	inc d ; $42c2
.sendBlockEnd:
	ld a, $cc ; $42c3
	call SendByteGetReplySlave ; $42c5
	cp $c5 ; $42c8
	jr z, .compareChecksum ; $42ca
	call LinkErrorReset ; $42cc
.compareChecksum:
	call ExchangeChecksumSlave ; $42cf
	ldh a, [hLinkBlockChecksum] ; $42d2
	ld e, a ; $42d4
	ldh a, [hLinkBlockChecksum + 1] ; $42d5
	ld d, a ; $42d7
	push hl ; $42d8
	push de ; $42d9
	ld a, l ; $42da
	sub e ; $42db
	ld l, a ; $42dc
	ld a, h ; $42dd
	sbc d ; $42de
	ld h, a ; $42df
	ld a, h ; $42e0
	or l ; $42e1
	pop de ; $42e2
	pop hl ; $42e3
	jp z, .checksumOk ; $42e4
	di ; $42e7
	ldh a, [rIF] ; $42e8
	and $f7 ; $42ea
	ldh [rIF], a ; $42ec
	xor a ; $42ee
	ldh [hLinkTransferDone], a ; $42ef
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
	cp $cb ; $4305
	jp z, .startBlock ; $4307
	cp $cd ; $430a
	jp z, .startBlock ; $430c
	call LinkErrorReset ; $430f
.checksumOk:
	ld a, $cd ; $4312
	call SendByteGetReplySlave ; $4314
	cp $cb ; $4317
	jp z, .startBlock ; $4319
	cp $cd ; $431c
	jr z, .done ; $431e
	call LinkErrorReset ; $4320
.done:
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
	and $0f ; $432f
	or $40 ; $4331
	call SendByteGetReplyMaster ; $4333
	ld b, a ; $4336
	and $c0 ; $4337
	cp $80 ; $4339
	jr z, .nibble1 ; $433b
	call LinkErrorReset ; $433d
.nibble1:
	call ShiftNibbleIntoChecksum ; $4340
	ld a, d ; $4343
	and $0f ; $4344
	or $40 ; $4346
	call SendByteGetReplyMaster ; $4348
	ld b, a ; $434b
	and $c0 ; $434c
	cp $80 ; $434e
	jr z, .nibble2 ; $4350
	call LinkErrorReset ; $4352
.nibble2:
	call ShiftNibbleIntoChecksum ; $4355
	ld a, e ; $4358
	swap a ; $4359
	and $0f ; $435b
	or $40 ; $435d
	call SendByteGetReplyMaster ; $435f
	ld b, a ; $4362
	and $c0 ; $4363
	cp $80 ; $4365
	jr z, .nibble3 ; $4367
	call LinkErrorReset ; $4369
.nibble3:
	call ShiftNibbleIntoChecksum ; $436c
	ld a, e ; $436f
	and $0f ; $4370
	or $40 ; $4372
	call SendByteGetReplyMaster ; $4374
	ld b, a ; $4377
	and $c0 ; $4378
	cp $80 ; $437a
	jr z, .done ; $437c
	call LinkErrorReset ; $437e
.done:
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
	and $0f ; $4393
	or $80 ; $4395
	call SendByteGetReplySlave ; $4397
	cp $cc ; $439a
	jr z, .nibble1 ; $439c
	call LinkErrorReset ; $439e
.nibble1:
	ld a, d ; $43a1
	and $0f ; $43a2
	or $80 ; $43a4
	call SendByteGetReplySlave ; $43a6
	ld b, a ; $43a9
	and $c0 ; $43aa
	cp $40 ; $43ac
	jr z, .nibble2 ; $43ae
	call LinkErrorReset ; $43b0
.nibble2:
	call ShiftNibbleIntoChecksum ; $43b3
	ld a, e ; $43b6
	swap a ; $43b7
	and $0f ; $43b9
	or $80 ; $43bb
	call SendByteGetReplySlave ; $43bd
	ld b, a ; $43c0
	and $c0 ; $43c1
	cp $40 ; $43c3
	jr z, .nibble3 ; $43c5
	call LinkErrorReset ; $43c7
.nibble3:
	call ShiftNibbleIntoChecksum ; $43ca
	ld a, e ; $43cd
	and $0f ; $43ce
	or $80 ; $43d0
	call SendByteGetReplySlave ; $43d2
	ld b, a ; $43d5
	and $c0 ; $43d6
	cp $40 ; $43d8
	jr z, .nibble4 ; $43da
	call LinkErrorReset ; $43dc
.nibble4:
	call ShiftNibbleIntoChecksum ; $43df
	ld a, $cd ; $43e2
	call SendByteGetReplySlave ; $43e4
	ld b, a ; $43e7
	and $c0 ; $43e8
	cp $40 ; $43ea
	jr z, .done ; $43ec
	call LinkErrorReset ; $43ee
.done:
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
	and $0f ; $4407
	or l ; $4409
	ld l, a ; $440a
	ret ; $440b
ComputeNibbleBufferChecksum:
	push af ; $440c
	push bc ; $440d
	push de ; $440e
	push hl ; $440f
	ld hl, $ce40 ; $4410
	ld de, $0000 ; $4413
.sumLoop:
	ld a, [hl+] ; $4416
	add e ; $4417
	ld e, a ; $4418
	jr nc, .next ; $4419
	inc d ; $441b
.next:
	dec c ; $441c
	jr nz, .sumLoop ; $441d
	ld a, e ; $441f
	ldh [hLinkBlockChecksum], a ; $4420
	ld a, d ; $4422
	ldh [hLinkBlockChecksum + 1], a ; $4423
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
	jr nc, .haveLength ; $4431
	scf ; $4433
	jp .done ; $4434
.haveLength:
	ld c, a ; $4437
.startBlock:
	ld a, $c3 ; $4438
	ld b, $c4 ; $443a
	call SendByteAwaitEchoSlave ; $443c
	jr c, .startBlock ; $443f
	ld hl, $ce40 ; $4441
	ld de, $0000 ; $4444
	ld b, c ; $4447
.sendLoop:
	ld a, [hl+] ; $4448
	ldh [hLinkTxByte], a ; $4449
	add e ; $444b
	ld e, a ; $444c
	jr nc, .sendByte ; $444d
	inc d ; $444f
.sendByte:
	di ; $4450
	ldh a, [hLinkTxByte] ; $4451
	or $80 ; $4453
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
	jr c, .sendByte ; $4468
	xor a ; $446a
	ldh [hLinkCounter], a ; $446b
	dec b ; $446d
	jr nz, .sendLoop ; $446e
.sendBlockEnd:
	ld a, $c5 ; $4470
	ld b, $c6 ; $4472
	call SendByteAwaitEchoSlave ; $4474
	jr c, .sendBlockEnd ; $4477
	ld hl, $0000 ; $4479
.compareChecksum:
	ld a, $cc ; $447c
	call SendByteGetReplySlave ; $447e
	cp $cd ; $4481
	jr z, .checksumOk ; $4483
	ld b, a ; $4485
	and $c0 ; $4486
	cp $40 ; $4488
	jr nz, .compareChecksum ; $448a
	sla l ; $448c
	rl h ; $448e
	sla l ; $4490
	rl h ; $4492
	sla l ; $4494
	rl h ; $4496
	sla l ; $4498
	rl h ; $449a
	ld a, b ; $449c
	and $0f ; $449d
	or l ; $449f
	ld l, a ; $44a0
	jr .compareChecksum ; $44a1
.checksumOk:
	push hl ; $44a3
	push de ; $44a4
	ld a, l ; $44a5
	sub e ; $44a6
	ld l, a ; $44a7
	ld a, h ; $44a8
	sbc d ; $44a9
	ld h, a ; $44aa
	ld a, h ; $44ab
	or l ; $44ac
	pop de ; $44ad
	pop hl ; $44ae
	jr nz, .startBlock ; $44af
.retry:
	ld a, $80 ; $44b1
	call SendByteGetReplySlave ; $44b3
	cp $40 ; $44b6
	jr nz, .retry ; $44b8
	scf ; $44ba
	ccf ; $44bb
.done:
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
.startBlock:
	ld a, $c4 ; $44c8
	ld b, $c3 ; $44ca
	call SendByteAwaitEchoMaster ; $44cc
	jr c, .startBlock ; $44cf
	ld hl, $cea0 ; $44d1
	ld de, $0000 ; $44d4
	ld b, $00 ; $44d7
.nibbleLoop:
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
	jr c, .nibbleLoop ; $44ed
	cp $c5 ; $44ef
	jr z, .compareChecksum ; $44f1
	and $3f ; $44f3
	ld [hl+], a ; $44f5
	add e ; $44f6
	ld e, a ; $44f7
	jr nc, .nextNibble ; $44f8
	inc d ; $44fa
.nextNibble:
	xor a ; $44fb
	ldh [hLinkCounter], a ; $44fc
	inc b ; $44fe
	ld a, b ; $44ff
	cp $40 ; $4500
	jr c, .nibbleLoop ; $4502
	call LinkErrorReset ; $4504
.compareChecksum:
	ld a, $c6 ; $4507
	call SendByteGetReplyMaster ; $4509
	ld a, d ; $450c
	or $40 ; $450d
	call SendByteGetReplyMaster ; $450f
	ld a, e ; $4512
	or $40 ; $4513
	call SendByteGetReplyMaster ; $4515
	ld a, $cd ; $4518
	call SendByteGetReplyMaster ; $451a
.retry:
	ld a, $40 ; $451d
	call SendByteGetReplyMaster ; $451f
	cp $c3 ; $4522
	jr z, .startBlock ; $4524
	cp $80 ; $4526
	jr nz, .retry ; $4528
	pop hl ; $452a
	pop de ; $452b
	pop bc ; $452c
	pop af ; $452d
	ret ; $452e
PollSerialResponse:
	push bc ; $452f
	di ; $4530
	ldh a, [hLinkRxByte] ; $4531
	ld b, a ; $4533
	cp $00 ; $4534
	jr z, .noReply ; $4536
	cp $ff ; $4538
	jr z, .noReply ; $453a
	xor a ; $453c
	ldh [hLinkCounter], a ; $453d
	scf ; $453f
	ccf ; $4540
	jr .done ; $4541
.noReply:
	call IncrementLinkFrameCounter ; $4543
	scf ; $4546
.done:
	ei ; $4547
	ld a, b ; $4548
	pop bc ; $4549
	ret ; $454a
SendByteAwaitEchoMaster:
	push bc ; $454b
	ldh [hLinkTxByte], a ; $454c
	ld c, $14 ; $454e
.sendLoop:
	di ; $4550
	ldh a, [hLinkTxByte] ; $4551
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
	ldh a, [hLinkRxByte] ; $456a
	ei ; $456c
	cp $00 ; $456d
	jr z, .retry ; $456f
	cp $ff ; $4571
	jr z, .retry ; $4573
	cp b ; $4575
	jr z, .success ; $4576
	xor a ; $4578
	ldh [hLinkCounter], a ; $4579
	dec c ; $457b
	jr nz, .sendLoop ; $457c
	scf ; $457e
	jr .done ; $457f
.retry:
	call IncrementLinkFrameCounter ; $4581
	jr .sendLoop ; $4584
.success:
	scf ; $4586
	ccf ; $4587
.done:
	pop bc ; $4588
	ret ; $4589
SendByteAwaitEchoSlave:
	push bc ; $458a
	ldh [hLinkTxByte], a ; $458b
	ld c, $1e ; $458d
.sendLoop:
	di ; $458f
	ldh a, [hLinkTxByte] ; $4590
	ldh [rSB], a ; $4592
	push af ; $4594
	ld a, $02 ; $4595
	ldh [rSC], a ; $4597
	ld a, $82 ; $4599
	ldh [rSC], a ; $459b
	pop af ; $459d
	ei ; $459e
	call WaitSerialTransfer ; $459f
	ldh a, [hLinkRxByte] ; $45a2
	cp $00 ; $45a4
	jr z, .retry ; $45a6
	cp $ff ; $45a8
	jr z, .retry ; $45aa
	cp b ; $45ac
	jr z, .success ; $45ad
	xor a ; $45af
	ldh [hLinkCounter], a ; $45b0
	dec c ; $45b2
	jr nz, .sendLoop ; $45b3
	scf ; $45b5
	jr .done ; $45b6
.retry:
	call IncrementLinkFrameCounter ; $45b8
	jr .sendLoop ; $45bb
.success:
	scf ; $45bd
	ccf ; $45be
.done:
	pop bc ; $45bf
	ret ; $45c0
SendByteGetReplyMaster:
	push bc ; $45c1
	ldh [hLinkTxByte], a ; $45c2
	ld c, $64 ; $45c4
.sendLoop:
	ei ; $45c6
	nop ; $45c7
	di ; $45c8
	ldh a, [hLinkTxByte] ; $45c9
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
	ldh a, [hLinkRxByte] ; $45e2
	cp $00 ; $45e4
	jr z, .retry ; $45e6
	cp $ff ; $45e8
	jr z, .retry ; $45ea
	jr .done ; $45ec
.retry:
	dec c ; $45ee
	jr nz, .sendLoop ; $45ef
	ei ; $45f1
	call LinkErrorReset ; $45f2
.done:
	ei ; $45f5
	pop bc ; $45f6
	ret ; $45f7
SendByteAwaitReplyMaster:
	push bc ; $45f8
	ldh [hLinkTxByte], a ; $45f9
.sendLoop:
	ldh a, [hLinkTxByte] ; $45fb
	ldh [rSB], a ; $45fd
	push af ; $45ff
	ld a, $03 ; $4600
	ldh [rSC], a ; $4602
	ld a, $83 ; $4604
	ldh [rSC], a ; $4606
	pop af ; $4608
	call AdvanceFrame ; $4609
	ldh a, [hLinkRxByte] ; $460c
	cp $00 ; $460e
	jr z, .retry ; $4610
	cp $ff ; $4612
	jr z, .retry ; $4614
	ld b, a ; $4616
	xor a ; $4617
	ldh [hLinkCounter], a ; $4618
	ld a, b ; $461a
	jr .done ; $461b
.retry:
	call IncrementLinkFrameCounter ; $461d
	jr .sendLoop ; $4620
.done:
	pop bc ; $4622
	ret ; $4623
SendByteGetReplySlave:
	push bc ; $4624
	di ; $4625
	ldh [hLinkTxPending], a ; $4626
	ldh [hLinkTxByte], a ; $4628
	ldh a, [rIF] ; $462a
	and $f7 ; $462c
	ldh [rIF], a ; $462e
	xor a ; $4630
	ldh [hLinkTransferDone], a ; $4631
	ei ; $4633
	ld c, $64 ; $4634
.waitLoop:
	call WaitSerialTransfer ; $4636
	jr c, .retry ; $4639
	di ; $463b
	ldh a, [hLinkRxByte] ; $463c
	ei ; $463e
	cp $00 ; $463f
	jr z, .retry ; $4641
	cp $ff ; $4643
	jr z, .retry ; $4645
	ld b, a ; $4647
	xor a ; $4648
	ldh [hLinkCounter], a ; $4649
	ld a, b ; $464b
	jr .done ; $464c
.retry:
	dec c ; $464e
	jr nz, .waitLoop ; $464f
	call LinkErrorReset ; $4651
.done:
	pop bc ; $4654
	ret ; $4655
UnpackBytesToNibbles:
	ld hl, $ce40 ; $4656
	ld a, c ; $4659
	add a ; $465a
	cp $5f ; $465b
	jr c, .unpack ; $465d
	xor a ; $465f
	scf ; $4660
	jp .done ; $4661
.unpack:
	ld c, a ; $4664
	ld b, $00 ; $4665
.nibbleLoop:
	ld a, [de] ; $4667
	bit 0, b ; $4668
	jr nz, .lowNibble ; $466a
	swap a ; $466c
	and $0f ; $466e
	jr .store ; $4670
.lowNibble:
	and $0f ; $4672
	inc de ; $4674
.store:
	ld [hl+], a ; $4675
	inc b ; $4676
	ld a, b ; $4677
	cp c ; $4678
	jr nz, .nibbleLoop ; $4679
	ld a, c ; $467b
	scf ; $467c
	ccf ; $467d
.done:
	ret ; $467e
ExchangeLinkFrameByteMaster:
	di ; $467f
	ldh a, [rLY] ; $4680
	ei ; $4682
	cp $8c ; $4683
	jr nz, ExchangeLinkFrameByteMaster ; $4685
	di ; $4687
	ldh a, [hLinkTxByte] ; $4688
	ldh [rSB], a ; $468a
	push af ; $468c
	ld a, $03 ; $468d
	ldh [rSC], a ; $468f
	ld a, $83 ; $4691
	ldh [rSC], a ; $4693
	pop af ; $4695
	ei ; $4696
	call AdvanceFrame ; $4697
	ldh a, [hLinkRxByte] ; $469a
	ld b, a ; $469c
	cp $00 ; $469d
	jr z, .badReply ; $469f
	cp $ff ; $46a1
	jr z, .resetLink ; $46a3
	and $c0 ; $46a5
	cp $80 ; $46a7
	jr z, .checkDuplicate ; $46a9
	cp $40 ; $46ab
	jr z, .checkDuplicate ; $46ad
.badReply:
	call LinkErrorReset ; $46af
	ld hl, hLinkCounter ; $46b2
	inc [hl] ; $46b5
	ld a, [hl] ; $46b6
	cp $0a ; $46b7
	jr nc, .giveUp ; $46b9
	call WaitVBlank ; $46bb
	jp ExchangeLinkFrameByteMaster ; $46be
.giveUp:
	call LinkErrorReset ; $46c1
.resetLink:
	call LinkErrorReset ; $46c4
.checkDuplicate:
	ldh a, [hLinkLastRxByte] ; $46c7
	cp b ; $46c9
	jr nz, .store ; $46ca
	and $3f ; $46cc
	ld hl, hLinkCounter ; $46ce
	inc [hl] ; $46d1
	ld a, [hl] ; $46d2
	cp $02 ; $46d3
	jr nc, .reinitLink ; $46d5
	call WaitVBlank ; $46d7
	call WaitVBlank ; $46da
	jp ExchangeLinkFrameByteMaster ; $46dd
.reinitLink:
	call InitSerialLink ; $46e0
	call LinkErrorReset ; $46e3
.store:
	ld a, b ; $46e6
	ldh [hLinkLastRxByte], a ; $46e7
	ldh [hLinkLastRxMirror], a ; $46e9
	xor a ; $46eb
	ldh [hLinkCounter], a ; $46ec
	ret ; $46ee
ExchangeLinkFrameByteSlave:
	call AwaitSerialByte ; $46ef
	jr c, .resetLink ; $46f2
	push bc ; $46f4
	call AdvanceFrame ; $46f5
	pop bc ; $46f8
	di ; $46f9
	cp $00 ; $46fa
	jr z, .resetLink ; $46fc
	cp $ff ; $46fe
	jr z, .resetLinkAgain ; $4700
	and $c0 ; $4702
	cp $40 ; $4704
	jr z, .checkDuplicate ; $4706
	cp $80 ; $4708
	jr z, .checkDuplicate ; $470a
.resetLink:
	call LinkErrorReset ; $470c
.resetLinkAgain:
	call LinkErrorReset ; $470f
.checkDuplicate:
	ldh a, [hLinkLastRxByte] ; $4712
	cp b ; $4714
	jr nz, .store ; $4715
	and $3f ; $4717
	jr .resetLink ; $4719
.store:
	ld a, b ; $471b
	ldh [hLinkLastRxByte], a ; $471c
	ldh [hLinkLastRxMirror], a ; $471e
	xor a ; $4720
	ldh [hLinkCounter], a ; $4721
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
	ld hl, hMatchFrameCounter ; $474b
	inc [hl] ; $474e
	ldh a, [hLinkState] ; $474f
	cp $02 ; $4751
	jr z, .slave ; $4753
	call SyncLinkFrameMaster ; $4755
	jr .done ; $4758
.slave:
	call SyncLinkFrameSlave ; $475a
.done:
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
	ld hl, hMatchFrameCounter ; $4766
	inc [hl] ; $4769
	ldh a, [hLinkState] ; $476a
	cp $02 ; $476c
	jr z, .asSlave ; $476e
	call RunLinkMatchFrameMaster ; $4770
	jr .done ; $4773
.asSlave:
	call RunLinkMatchFrameSlave ; $4775
.done:
	pop hl ; $4778
	pop de ; $4779
	pop bc ; $477a
	pop af ; $477b
	ret ; $477c
ExchangeLinkReadySignal:
	push af ; $477d
	push bc ; $477e
	ld c, $64 ; $477f
	ldh a, [hLinkState] ; $4781
	cp $02 ; $4783
	jr z, .asSlave ; $4785
	cp $01 ; $4787
	jr z, .delayLoop ; $4789
	call LinkErrorReset ; $478b
.delayLoop:
	call ShortDelay ; $478e
	dec c ; $4791
	jr nz, .delayLoop ; $4792
	call ExchangeReadyTokenMaster ; $4794
	jr .done ; $4797
.asSlave:
	call ExchangeReadyTokenSlave ; $4799
.done:
	pop bc ; $479c
	pop af ; $479d
	ret ; $479e
ExchangeReadyTokenMaster:
	push af ; $479f
	push de ; $47a0
	ldh a, [rSC] ; $47a1
	and $7f ; $47a3
	ldh [rSC], a ; $47a5
	ld de, $2710 ; $47a7
.retry:
	ldh a, [rSC] ; $47aa
	bit 7, a ; $47ac
	jr nz, .retry ; $47ae
	di ; $47b0
	ld a, $0b ; $47b1
	or $40 ; $47b3
	ldh [rSB], a ; $47b5
	push af ; $47b7
	ld a, $03 ; $47b8
	ldh [rSC], a ; $47ba
	ld a, $83 ; $47bc
	ldh [rSC], a ; $47be
	pop af ; $47c0
	ei ; $47c1
	call ShortDelay ; $47c2
	ldh a, [hLinkRxByte] ; $47c5
	and $3f ; $47c7
	cp $0a ; $47c9
	jr z, .done ; $47cb
	dec de ; $47cd
	ld a, d ; $47ce
	or e ; $47cf
	jr nz, .retry ; $47d0
	call LinkErrorReset ; $47d2
.done:
	pop de ; $47d5
	pop af ; $47d6
	ret ; $47d7
ExchangeReadyTokenSlave:
	push af ; $47d8
	push de ; $47d9
	ld de, $0003 ; $47da
	di ; $47dd
	ld a, $0a ; $47de
	or $80 ; $47e0
	ldh [hLinkTxByte], a ; $47e2
	ldh [rSB], a ; $47e4
	push af ; $47e6
	ld a, $02 ; $47e7
	ldh [rSC], a ; $47e9
	ld a, $82 ; $47eb
	ldh [rSC], a ; $47ed
	pop af ; $47ef
	ei ; $47f0
.retry:
	call WaitSerialTransfer ; $47f1
	ldh a, [hLinkRxByte] ; $47f4
	and $3f ; $47f6
	cp $0b ; $47f8
	jr z, .done ; $47fa
	dec de ; $47fc
	ld a, d ; $47fd
	or e ; $47fe
	jr nz, .retry ; $47ff
	call LinkErrorReset ; $4801
.done:
	pop de ; $4804
	pop af ; $4805
	ret ; $4806
RunLinkInputFrameMaster:
	push bc ; $4807
	push hl ; $4808
	call PrepareLinkInputPayload ; $4809
	call ExchangeLinkFrameByteMaster ; $480c
	call SerialDecodeInput ; $480f
	ldh a, [hLinkInput] ; $4812
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
	ldh a, [hLinkInput] ; $4828
	call SoftResetIfABStartSelect ; $482a
	call SerialEncodeInput ; $482d
	pop hl ; $4830
	pop bc ; $4831
	ret ; $4832
RunLinkInputFrame:
	ld hl, hMatchFrameCounter ; $4833
	inc [hl] ; $4836
	ldh a, [hLinkState] ; $4837
	cp $02 ; $4839
	jr z, .slave ; $483b
	call RunLinkInputFrameMaster ; $483d
	jr .done ; $4840
.slave:
	call RunLinkInputFrameSlave ; $4842
.done:
	ret ; $4845
UpdateLinkSession:
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld a, [wLinkSessionActive] ; $484a
	or a ; $484d
	jp z, .done ; $484e
	ldh a, [hLinkExchangeActive] ; $4851
	or a ; $4853
	jp nz, .frameLoop ; $4854
	sound $00 ; $4857
	call DisableLCDSafely ; $4859
	ld a, $01 ; $485c
	ldh [hLinkExchangeActive], a ; $485e
	farcall ExchangeLinkReadySignal ; $4860
	ldh a, [hLinkState] ; $4863
	cp $02 ; $4865
	jp z, .asSlave ; $4867
	cp $01 ; $486a
	jr z, .asMaster ; $486c
	call LinkErrorReset ; $486e
.asMaster:
	ld a, $40 ; $4871
	ldh [hLinkTxSeqBits], a ; $4873
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
	jr .encode ; $48a5
.asSlave:
	xor a ; $48a7
	ldh [hLinkTransferDone], a ; $48a8
	ld a, $80 ; $48aa
	ldh [hLinkTxSeqBits], a ; $48ac
.encode:
	xor a ; $48ae
	ldh [hLinkPlayerCount], a ; $48af
	call SerialEncodeInput ; $48b1
	farcall PrimeSlaveSerialReply ; $48b4
	xor a ; $48b7
	ldh [hLinkRemoteInputPrev], a ; $48b8
	ld hl, wCharInputSource ; $48ba
	wram_bank $04 ; $48bd
	ld [hl], $05 ; $48c3
	wram_bank $05 ; $48c5
	ld [hl], $06 ; $48cb
	wram_bank $04 ; $48cd
	xor a ; $48d3
	ldh [hLinkRxByte], a ; $48d4
	ldh [hLinkTransferDone], a ; $48d6
	ld a, $01 ; $48d8
	ldh [hLinkAckRequired], a ; $48da
	call EnableLCD ; $48dc
.frameLoop:
	xor a ; $48df
	ldh [hMatchFrameCounter], a ; $48e0
	push af ; $48e2
	farcall SyncLinkFrame ; $48e3
	pop af ; $48e6
	push af ; $48e7
	farcall SyncLinkFrame ; $48e8
	pop af ; $48eb
	push af ; $48ec
	farcall SyncLinkFrame ; $48ed
	pop af ; $48f0
.done:
	pop hl ; $48f1
	pop de ; $48f2
	pop bc ; $48f3
	pop af ; $48f4
	ret ; $48f5
EndLinkSession:
	xor a ; $48f6
	ld [wLinkSessionActive], a ; $48f7
	call InitSerialLink ; $48fa
	ret ; $48fd
ExchangeHandshakeBlockMaster:
	ld hl, wTextBuffer ; $48fe
	ld c, $28 ; $4901
	ld a, $02 ; $4903
.fillLoop:
	ld [hl+], a ; $4905
	dec c ; $4906
	jr nz, .fillLoop ; $4907
	ld de, wTextBuffer ; $4909
	ld c, $28 ; $490c
	call ExchangeNibbleBlockMaster ; $490e
	ret ; $4911
ExchangeHandshakeBlockSlave:
	ld hl, wTextBuffer ; $4912
	ld c, $28 ; $4915
	ld a, $08 ; $4917
.fillLoop:
	ld [hl+], a ; $4919
	dec c ; $491a
	jr nz, .fillLoop ; $491b
	ld de, wTextBuffer ; $491d
	ld c, $28 ; $4920
	call ExchangeNibbleBlockSlave ; $4922
	ret ; $4925
ExchangeLinkBlockToWram5:
	call DisableLCDSafely ; $4926
	di ; $4929
	ldh a, [rIF] ; $492a
	and $08 ; $492c
	ldh [rIF], a ; $492e
	ei ; $4930
	xor a ; $4931
	ldh [hLinkExchangeActive], a ; $4932
	call LongDelay ; $4934
	call LongDelay ; $4937
	call LongDelay ; $493a
	ldh a, [hLinkState] ; $493d
	cp $02 ; $493f
	jr z, .asSlave ; $4941
	cp $01 ; $4943
	jr z, .asMaster ; $4945
	call LinkErrorReset ; $4947
.asMaster:
	call ExchangeHandshakeBlockMaster ; $494a
	jr .copyToWram ; $494d
.asSlave:
	call ExchangeHandshakeBlockSlave ; $494f
.copyToWram:
	wram_bank $05 ; $4952
	ld hl, $c650 ; $4958
	ld c, $28 ; $495b
	call PackNibblesToBytes ; $495d
	ld a, $01 ; $4960
	ldh [hLinkExchangeActive], a ; $4962
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
	and $08 ; $497a
	ldh [rIF], a ; $497c
	ei ; $497e
	xor a ; $497f
	ldh [hLinkExchangeActive], a ; $4980
	call LongDelay ; $4982
	call LongDelay ; $4985
	call LongDelay ; $4988
	pop bc ; $498b
	pop de ; $498c
	pop hl ; $498d
	ldh a, [hLinkState] ; $498e
	cp $02 ; $4990
	jr z, .asSlave ; $4992
	cp $01 ; $4994
	jr z, .asMaster ; $4996
	call LinkErrorReset ; $4998
.asMaster:
	call ExchangeNibbleBlockMaster ; $499b
	jr .unpack ; $499e
.asSlave:
	call ExchangeNibbleBlockSlave ; $49a0
.unpack:
	call PackNibblesToBytes ; $49a3
	di ; $49a6
	ld a, $09 ; $49a7
	ldh [rIF], a ; $49a9
	ei ; $49ab
	call EnableLCD ; $49ac
	ret ; $49af
PackNibblesToBytes:
	ld a, c ; $49b0
	add a ; $49b1
	cp $5f ; $49b2
	jr c, .pack ; $49b4
	call LinkErrorReset ; $49b6
.pack:
	ld c, a ; $49b9
	ld b, $00 ; $49ba
	ld de, $cea0 ; $49bc
.nibbleLoop:
	ld a, b ; $49bf
	and $01 ; $49c0
	jr nz, .lowNibble ; $49c2
	ld a, [de] ; $49c4
	swap a ; $49c5
	and $f0 ; $49c7
	jr .store ; $49c9
.lowNibble:
	ld a, [de] ; $49cb
	and $0f ; $49cc
	push bc ; $49ce
	ld b, a ; $49cf
	ld a, [hl] ; $49d0
	and $f0 ; $49d1
	or b ; $49d3
	pop bc ; $49d4
.store:
	ld [hl], a ; $49d5
	inc b ; $49d6
	inc de ; $49d7
	bit 0, b ; $49d8
	jr nz, .next ; $49da
	inc hl ; $49dc
.next:
	ld a, b ; $49dd
	cp c ; $49de
	jr c, .nibbleLoop ; $49df
	ret ; $49e1
PrimeSlaveSerialReply:
	ldh a, [hLinkState] ; $49e2
	cp $02 ; $49e4
	jr nz, .done ; $49e6
	ld a, $40 ; $49e8
	ldh [rSB], a ; $49ea
	push af ; $49ec
	ld a, $02 ; $49ed
	ldh [rSC], a ; $49ef
	ld a, $82 ; $49f1
	ldh [rSC], a ; $49f3
	pop af ; $49f5
.done:
	ret ; $49f6
PrepareLinkStatePayload:
	push af ; $49f7
	ldh a, [hLinkTxByte] ; $49f8
	and $c0 ; $49fa
	xor $c0 ; $49fc
	ldh [hLinkTxSeqBits], a ; $49fe
	ldh a, [hLinkTxInput] ; $4a00
	ldh [hLinkRemoteInputBuf], a ; $4a02
	call ReadJoypadThunk ; $4a04
	ldh a, [hPlayerInputFlags] ; $4a07
	and $f0 ; $4a09
	ld c, a ; $4a0b
	call ComposeLinkStateByte ; $4a0c
	ldh [hLinkTxInput], a ; $4a0f
	pop af ; $4a11
	ret ; $4a12
PrepareLinkInputPayload:
	push af ; $4a13
	ldh a, [hLinkTxByte] ; $4a14
	and $c0 ; $4a16
	xor $c0 ; $4a18
	ldh [hLinkTxSeqBits], a ; $4a1a
	ldh a, [hLinkTxInput] ; $4a1c
	ldh [hLinkRemoteInputBuf], a ; $4a1e
	call ReadJoypadThunk ; $4a20
	ldh a, [hInputPressed] ; $4a23
	ldh [hLinkTxInput], a ; $4a25
	pop af ; $4a27
	ret ; $4a28
AwaitSerialByte:
	push de ; $4a29
	ld de, $4e20 ; $4a2a
.waitLoop:
	ei ; $4a2d
	nop ; $4a2e
	nop ; $4a2f
	di ; $4a30
	ldh a, [hVBlankOccurred] ; $4a31
	or a ; $4a33
	jr z, .waitLoop ; $4a34
	ldh a, [hLinkTransferDone] ; $4a36
	or a ; $4a38
	jr nz, .received ; $4a39
	dec de ; $4a3b
	ld a, d ; $4a3c
	or e ; $4a3d
	jr nz, .waitLoop ; $4a3e
	scf ; $4a40
	jr .done ; $4a41
.received:
	dec a ; $4a43
	ldh [hLinkTransferDone], a ; $4a44
	xor a ; $4a46
	ldh [hVBlankOccurred], a ; $4a47
	scf ; $4a49
	ccf ; $4a4a
.done:
	ldh a, [hLinkRxByte] ; $4a4b
	ld b, a ; $4a4d
	ei ; $4a4e
	pop de ; $4a4f
	ret ; $4a50
ResyncLinkSession:
	di ; $4a51
	xor a ; $4a52
	ldh [rIF], a ; $4a53
	ldh a, [rIE] ; $4a55
	and $09 ; $4a57
	ldh [rIE], a ; $4a59
	ei ; $4a5b
	call DisableLCDSafely ; $4a5c
	ld a, $01 ; $4a5f
	ldh [hVBlankSuppressed], a ; $4a61
	ld a, $01 ; $4a63
	ldh [hLinkExchangeActive], a ; $4a65
	farcall ExchangeLinkReadySignal ; $4a67
	ldh a, [hLinkState] ; $4a6a
	cp $02 ; $4a6c
	jr z, .asSlave ; $4a6e
	cp $01 ; $4a70
	jr z, .asMaster ; $4a72
	call LinkErrorReset ; $4a74
.asMaster:
	ld a, $40 ; $4a77
	ldh [hLinkTxSeqBits], a ; $4a79
	call ShortDelay ; $4a7b
	call ShortDelay ; $4a7e
	call ShortDelay ; $4a81
	call ShortDelay ; $4a84
	call ShortDelay ; $4a87
	jr .encode ; $4a8a
.asSlave:
	xor a ; $4a8c
	ldh [hLinkTransferDone], a ; $4a8d
	ld a, $80 ; $4a8f
	ldh [hLinkTxSeqBits], a ; $4a91
.encode:
	call SerialEncodeInput ; $4a93
	farcall PrimeSlaveSerialReply ; $4a96
	xor a ; $4a99
	ldh [hLinkRemoteInputPrev], a ; $4a9a
	ld a, $01 ; $4a9c
	ldh [hLinkAckRequired], a ; $4a9e
	call EnableLCD ; $4aa0
	xor a ; $4aa3
	ldh [hVBlankSuppressed], a ; $4aa4
	ldh [hMatchFrameCounter], a ; $4aa6
	ret ; $4aa8
ResyncLinkSessionWithTimer:
	di ; $4aa9
	xor a ; $4aaa
	ldh [rIF], a ; $4aab
	ldh a, [rIE] ; $4aad
	and $09 ; $4aaf
	ldh [rIE], a ; $4ab1
	ei ; $4ab3
	ld a, $01 ; $4ab4
	ldh [hVBlankSuppressed], a ; $4ab6
	ld a, $01 ; $4ab8
	ldh [hLinkExchangeActive], a ; $4aba
	farcall ExchangeLinkReadySignal ; $4abc
	ldh a, [hLinkState] ; $4abf
	cp $02 ; $4ac1
	jr z, .asSlave ; $4ac3
	cp $01 ; $4ac5
	jr z, .asMaster ; $4ac7
	call LinkErrorReset ; $4ac9
.asMaster:
	ld a, $40 ; $4acc
	ldh [hLinkTxSeqBits], a ; $4ace
	call ShortDelay ; $4ad0
	call ShortDelay ; $4ad3
	call ShortDelay ; $4ad6
	call ShortDelay ; $4ad9
	call ShortDelay ; $4adc
	jr .encode ; $4adf
.asSlave:
	xor a ; $4ae1
	ldh [hLinkTransferDone], a ; $4ae2
	ld a, $80 ; $4ae4
	ldh [hLinkTxSeqBits], a ; $4ae6
.encode:
	call SerialEncodeInput ; $4ae8
	farcall PrimeSlaveSerialReply ; $4aeb
	xor a ; $4aee
	ldh [hLinkRemoteInputPrev], a ; $4aef
	ld a, $01 ; $4af1
	ldh [hLinkAckRequired], a ; $4af3
	call EnableTimerInterrupt ; $4af5
	xor a ; $4af8
	ldh [hVBlankSuppressed], a ; $4af9
	ldh [hMatchFrameCounter], a ; $4afb
	ret ; $4afd
TryLinkHandshakeSlave:
	push hl ; $4afe
	push de ; $4aff
	push bc ; $4b00
	call EnableSerialAndVBlankInterrupts ; $4b01
	di ; $4b04
	ldh a, [rIF] ; $4b05
	and $f7 ; $4b07
	ldh [rIF], a ; $4b09
	xor a ; $4b0b
	ldh [hLinkTransferDone], a ; $4b0c
	ld a, $c2 ; $4b0e
	ldh [hLinkTxByte], a ; $4b10
	ldh [hLinkTxPending], a ; $4b12
	ei ; $4b14
	call AwaitSerialByte ; $4b15
	jr c, .failed ; $4b18
	di ; $4b1a
	ldh a, [hLinkRxByte] ; $4b1b
	cp $c2 ; $4b1d
	jr z, .failed ; $4b1f
	cp $00 ; $4b21
	jr z, .failed ; $4b23
	cp $ff ; $4b25
	jr z, .failed ; $4b27
	cp $c1 ; $4b29
	jr z, .success ; $4b2b
	ei ; $4b2d
.failed:
	scf ; $4b2e
	jr .done ; $4b2f
.success:
	scf ; $4b31
	ccf ; $4b32
.done:
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
	and $7f ; $4b41
	ldh [rSC], a ; $4b43
	ei ; $4b45
	ld a, $c1 ; $4b46
	ldh [hLinkTxByte], a ; $4b48
	ld hl, $03e8 ; $4b4a
	ld de, $03e8 ; $4b4d
.pollLoop:
	ldh a, [rLY] ; $4b50
	cp $8c ; $4b52
	jr nz, .pollLoop ; $4b54
	ldh a, [rSC] ; $4b56
	bit 7, a ; $4b58
	jr nz, .pollLoop ; $4b5a
	di ; $4b5c
	ldh a, [hLinkTxByte] ; $4b5d
	ldh [rSB], a ; $4b5f
	push af ; $4b61
	ld a, $03 ; $4b62
	ldh [rSC], a ; $4b64
	ld a, $83 ; $4b66
	ldh [rSC], a ; $4b68
	pop af ; $4b6a
	xor a ; $4b6b
	ldh [hLinkTransferDone], a ; $4b6c
	ei ; $4b6e
	call AwaitSerialByte ; $4b6f
	farcall AnimateLinkStatusPalette ; $4b72
	farcall UpdateAnimatedTiles ; $4b75
	jr c, .sendReady ; $4b78
	cp $c1 ; $4b7a
	jr z, .sendReady ; $4b7c
	cp $ff ; $4b7e
	jr z, .sendReady ; $4b80
	cp $c2 ; $4b82
	jr z, .failed ; $4b84
	ld a, d ; $4b86
	cp $03 ; $4b87
	jr nz, .retry ; $4b89
	ld a, e ; $4b8b
	cp $e8 ; $4b8c
	jr nz, .retry ; $4b8e
	push bc ; $4b90
	push de ; $4b91
	push hl ; $4b92
	ld c, $02 ; $4b93
	farcall ShowLinkStatusMessage ; $4b95
	pop hl ; $4b98
	pop de ; $4b99
	pop bc ; $4b9a
.retry:
	dec de ; $4b9b
	ld a, d ; $4b9c
	or e ; $4b9d
	jr nz, .pollLoop ; $4b9e
	jr .sendReady ; $4ba0
.sendReady:
	di ; $4ba2
	ld a, $c0 ; $4ba3
	ldh [rSB], a ; $4ba5
	push af ; $4ba7
	ld a, $03 ; $4ba8
	ldh [rSC], a ; $4baa
	ld a, $83 ; $4bac
	ldh [rSC], a ; $4bae
	pop af ; $4bb0
	xor a ; $4bb1
	ldh [hLinkTransferDone], a ; $4bb2
	ei ; $4bb4
	call AwaitSerialByte ; $4bb5
	ld a, e ; $4bb8
	scf ; $4bb9
	jr .done ; $4bba
.failed:
	scf ; $4bbc
	ccf ; $4bbd
.done:
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
	ldh a, [hLinkState] ; $4bf3
	cp $02 ; $4bf5
	jr z, .asSlave ; $4bf7
	call RunLinkCommandFrameMaster ; $4bf9
	jr .done ; $4bfc
.asSlave:
	call RunLinkCommandFrameSlave ; $4bfe
.done:
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
	ldh a, [hLinkTxInput] ; $4c26
	ld b, a ; $4c28
	push hl ; $4c29
	push de ; $4c2a
	farcall UpdateMenuCursorFromLinkInput ; $4c2b
	pop de ; $4c2e
	pop hl ; $4c2f
	ld c, b ; $4c30
	ldh a, [hLinkState] ; $4c31
	cp $01 ; $4c33
	jr z, .checkSlaveWait ; $4c35
	cp $02 ; $4c37
	jr z, .checkSlaveWait ; $4c39
	sound $72 ; $4c3b
	xor a ; $4c3d
	ldh [hLinkRemoteInputBuf], a ; $4c3e
	ldh [hLinkTxInput], a ; $4c40
	ld a, $c0 ; $4c42
	ldh [hLinkTxByte], a ; $4c44
	call LinkErrorReset ; $4c46
.checkSlaveWait:
	ldh a, [hLinkAckRequired] ; $4c49
	or a ; $4c4b
	jr z, .send ; $4c4c
	ldh a, [hLinkState] ; $4c4e
	cp $02 ; $4c50
	jr nz, .send ; $4c52
.waitAck:
	ei ; $4c54
	nop ; $4c55
	nop ; $4c56
	di ; $4c57
	ldh a, [hLinkTxPending] ; $4c58
	or a ; $4c5a
	jr nz, .waitAck ; $4c5b
.send:
	ldh a, [hLinkTxSeqBits] ; $4c5d
	or c ; $4c5f
	di ; $4c60
	ldh [hLinkTxByte], a ; $4c61
	ldh [hLinkTxPending], a ; $4c63
	ei ; $4c65
	pop hl ; $4c66
	pop bc ; $4c67
	ret ; $4c68
SerialDecodeCommand:
	push af ; $4c69
	push bc ; $4c6a
	ldh a, [hLinkRxByte] ; $4c6b
	ld b, a ; $4c6d
	and $c0 ; $4c6e
	cp $80 ; $4c70
	jr z, .decode ; $4c72
	cp $40 ; $4c74
	jr z, .decode ; $4c76
	sound $72 ; $4c78
	xor a ; $4c7a
	ldh [hLinkInput], a ; $4c7b
	jr .done ; $4c7d
.decode:
	ld a, b ; $4c7f
	and $3f ; $4c80
	ldh [hLinkRemoteInput], a ; $4c82
	ldh a, [hLinkState] ; $4c84
	cp $01 ; $4c86
	jr nz, .asSlave ; $4c88
	ldh a, [hLinkRemoteInputBuf] ; $4c8a
	or a ; $4c8c
	jr nz, .storeInput ; $4c8d
	ldh a, [hLinkRemoteInput] ; $4c8f
	call DecodeLinkCommandCode ; $4c91
	jr .storeInput ; $4c94
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4c96
	ld b, a ; $4c98
	ldh a, [hLinkRemoteInputPrev] ; $4c99
	ldh [hLinkRemoteInputBuf], a ; $4c9b
	ld a, b ; $4c9d
	ldh [hLinkRemoteInputPrev], a ; $4c9e
	ldh a, [hLinkRemoteInput] ; $4ca0
	or a ; $4ca2
	jr z, .useBuffered ; $4ca3
	call DecodeLinkCommandCode ; $4ca5
	jr .storeInput ; $4ca8
.useBuffered:
	ldh a, [hLinkRemoteInputBuf] ; $4caa
.storeInput:
	ldh [hLinkInput], a ; $4cac
.done:
	pop bc ; $4cae
	pop af ; $4caf
	ret ; $4cb0
AdvanceLinkPlayerCount:
	ld a, [wMatchIsDoubles] ; $4cb1
	inc a ; $4cb4
	ld b, a ; $4cb5
	ldh a, [hLinkPlayerCount] ; $4cb6
	cp b ; $4cb8
	ldh a, [hLinkTxInput] ; $4cb9
	jr c, .maskHigh ; $4cbb
	and $0f ; $4cbd
	ldh [hLinkTxInput], a ; $4cbf
	jr .checkJoin ; $4cc1
.maskHigh:
	ld c, a ; $4cc3
	and $f0 ; $4cc4
	jr nz, .done ; $4cc6
	ld a, c ; $4cc8
.checkJoin:
	bit 0, a ; $4cc9
	jr z, .checkLeave ; $4ccb
	ldh a, [hLinkPlayerCount] ; $4ccd
	cp b ; $4ccf
	jr nc, .done ; $4cd0
	inc a ; $4cd2
	ldh [hLinkPlayerCount], a ; $4cd3
	jr .done ; $4cd5
.checkLeave:
	bit 1, a ; $4cd7
	jr z, .done ; $4cd9
	ldh a, [hLinkPlayerCount] ; $4cdb
	or a ; $4cdd
	jr z, .done ; $4cde
	dec a ; $4ce0
	ldh [hLinkPlayerCount], a ; $4ce1
.done:
	ret ; $4ce3
DecodeLinkCommandCode:
	cp $14 ; $4ce4
	jr nz, .code15 ; $4ce6
	ld a, $0f ; $4ce8
	jr .store ; $4cea
.code15:
	cp $15 ; $4cec
	jr nz, .code19 ; $4cee
	ld a, $01 ; $4cf0
	jr .store ; $4cf2
.code19:
	cp $19 ; $4cf4
	jr nz, .passthrough ; $4cf6
	ld a, $02 ; $4cf8
	jr .store ; $4cfa
.passthrough:
	xor a ; $4cfc
.store:
	ret ; $4cfd
ComposeLinkStateByte:
	push bc ; $4cfe
	push hl ; $4cff
	ldh a, [hLinkPayloadKind] ; $4d00
	add a ; $4d02
	add a ; $4d03
	ld hl, LinkStateBytePtrs_07 ; $4d04
	add l ; $4d07
	ld l, a ; $4d08
	jr nc, .readEntry ; $4d09
	inc h ; $4d0b
.readEntry:
	push hl ; $4d0c
	ld a, [hl+] ; $4d0d
	ld h, [hl] ; $4d0e
	ld l, a ; $4d0f
	ld a, [hl] ; $4d10
	and $f0 ; $4d11
	ld b, a ; $4d13
	pop hl ; $4d14
	inc hl ; $4d15
	inc hl ; $4d16
	ld a, [hl+] ; $4d17
	ld h, [hl] ; $4d18
	ld l, a ; $4d19
	ld a, [hl] ; $4d1a
	and $0f ; $4d1b
	or b ; $4d1d
	pop hl ; $4d1e
	pop bc ; $4d1f
	ret ; $4d20
LinkStateBytePtrs_07:
	INCBIN "data/bank_007/d_4d21.bin" ; $4d21, 16 bytes
ShotPlacementDataTopspin_07:
	INCBIN "data/bank_007/d_4d31.bin" ; $4d31, 80 bytes
ShotPlacementDataPowerTopspin_07:
	INCBIN "data/bank_007/d_4d81.bin" ; $4d81, 80 bytes
ShotPlacementDataSlice_07:
	INCBIN "data/bank_007/d_4dd1.bin" ; $4dd1, 80 bytes
ShotPlacementDataPowerSlice_07:
	INCBIN "data/bank_007/d_4e21.bin" ; $4e21, 80 bytes
ShotPlacementDataNeutral_07:
	INCBIN "data/bank_007/d_4e71.bin" ; $4e71, 80 bytes
ShotPlacementDataSmash_07:
	INCBIN "data/bank_007/d_4ec1.bin" ; $4ec1, 80 bytes
ShotPlacementDataReachBasic_07:
	INCBIN "data/bank_007/d_4f11.bin" ; $4f11, 80 bytes
ShotPlacementDataReachPowerTopspin_07:
	INCBIN "data/bank_007/d_4f61.bin" ; $4f61, 80 bytes
ShotPlacementDataReachPowerSlice_07:
	INCBIN "data/bank_007/d_4fb1.bin" ; $4fb1, 80 bytes
ShotPlacementDataReach_07:
	INCBIN "data/bank_007/d_5001.bin" ; $5001, 80 bytes
ShotPlacementDataLob_07:
	INCBIN "data/bank_007/d_5051.bin" ; $5051, 16 bytes
ShotPlacementDataDrop_07:
	INCBIN "data/bank_007/d_5061.bin" ; $5061, 16 bytes
ShotPlacementDataServeTopspin_07:
	INCBIN "data/bank_007/d_5071.bin" ; $5071, 80 bytes
ShotPlacementDataServeSlice_07:
	INCBIN "data/bank_007/d_50c1.bin" ; $50c1, 80 bytes
ShotPlacementDataServeFlat_07:
	INCBIN "data/bank_007/d_5111.bin" ; $5111, 80 bytes
ComputeShotPlacement:
	ld a, [wCurrentShotType] ; $5161
	rst Rst00 ; $5164
	dw ShotPlacementTopspin ; $5165 jumptable
	dw ShotPlacementPowerTopspin ; $5167 jumptable
	dw ShotPlacementSlice ; $5169 jumptable
	dw ShotPlacementPowerSlice ; $516b jumptable
	dw ShotPlacementNeutral ; $516d jumptable
	dw ShotPlacementReach ; $516f jumptable
	dw ShotPlacementReachPowerTopspin ; $5171 jumptable
	dw ShotPlacementReachPowerSlice ; $5173 jumptable
	dw ShotPlacementReachBasic ; $5175 jumptable
	dw ShotPlacementSmash ; $5177 jumptable
	dw ShotPlacementLob ; $5179 jumptable
	dw ShotPlacementDrop ; $517b jumptable
	dw ShotPlacementServeTopspin ; $517d jumptable
	dw ShotPlacementServeSlice ; $517f jumptable
	dw ShotPlacementServeFlat ; $5181 jumptable
ShotPlacementTopspin:
	ld hl, ShotPlacementDataTopspin_07 ; $5183
	ld a, [wTopspinPlacementIndex] ; $5186
	ld d, a ; $5189
	ld a, [wGroundStrokeSpeedIndex] ; $518a
	ld e, a ; $518d
	call LoadShotPlacementEntry ; $518e
	call AddBallSpeedQuarter ; $5191
	call AddChargeSpeedBonus ; $5194
	call FinalizeShotSpeed ; $5197
	ret ; $519a
ShotPlacementPowerTopspin:
	ld hl, ShotPlacementDataPowerTopspin_07 ; $519b
	ld a, [wTopspinPlacementIndex] ; $519e
	ld d, a ; $51a1
	ld a, [wGroundStrokeSpeedIndex] ; $51a2
	ld e, a ; $51a5
	call LoadShotPlacementEntry ; $51a6
	call AddBallSpeedQuarter ; $51a9
	call AddChargeSpeedBonus ; $51ac
	call FinalizeShotSpeed ; $51af
	ret ; $51b2
ShotPlacementSlice:
	ld hl, ShotPlacementDataSlice_07 ; $51b3
	ld a, [wSlicePlacementIndex] ; $51b6
	ld d, a ; $51b9
	ld a, [wGroundStrokeSpeedIndex] ; $51ba
	ld e, a ; $51bd
	call LoadShotPlacementEntry ; $51be
	call AddBallSpeedEighth ; $51c1
	call AddChargeSpeedBonusHalf ; $51c4
	call FinalizeShotSpeed ; $51c7
	ret ; $51ca
ShotPlacementPowerSlice:
	ld hl, ShotPlacementDataPowerSlice_07 ; $51cb
	ld a, [wSlicePlacementIndex] ; $51ce
	ld d, a ; $51d1
	ld a, [wGroundStrokeSpeedIndex] ; $51d2
	ld e, a ; $51d5
	call LoadShotPlacementEntry ; $51d6
	call AddBallSpeedEighth ; $51d9
	call AddChargeSpeedBonusHalf ; $51dc
	call FinalizeShotSpeed ; $51df
	ret ; $51e2
ShotPlacementNeutral:
	ld hl, ShotPlacementDataNeutral_07 ; $51e3
	ld d, $00 ; $51e6
	ld a, [wGroundStrokeSpeedIndex] ; $51e8
	ld e, a ; $51eb
	call LoadShotPlacementEntry ; $51ec
	call AddBallSpeedQuarter ; $51ef
	call AddChargeSpeedBonus ; $51f2
	call FinalizeShotSpeed ; $51f5
	ret ; $51f8
ShotPlacementSmash:
	ld hl, ShotPlacementDataSmash_07 ; $51f9
	ld d, $00 ; $51fc
	ld a, [wSmashServeSpeedIndex] ; $51fe
	ld e, a ; $5201
	call LoadShotPlacementEntry ; $5202
	call AddBallSpeed3Sixteenths ; $5205
	call AddChargeSpeedBonus ; $5208
	call FinalizeShotSpeed ; $520b
	ret ; $520e
ShotPlacementReachBasic:
	ld hl, ShotPlacementDataReachBasic_07 ; $520f
	ld d, $00 ; $5212
	ld a, [wReachSpeedIndex] ; $5214
	ld e, a ; $5217
	call LoadShotPlacementEntry ; $5218
	call AddBallSpeed3Sixteenths ; $521b
	call FinalizeShotSpeed ; $521e
	ret ; $5221
ShotPlacementReachPowerTopspin:
	ld hl, ShotPlacementDataReachPowerTopspin_07 ; $5222
	ld d, $00 ; $5225
	ld a, [wReachSpeedIndex] ; $5227
	ld e, a ; $522a
	call LoadShotPlacementEntry ; $522b
	call AddBallSpeedQuarter ; $522e
	call FinalizeShotSpeed ; $5231
	ret ; $5234
ShotPlacementReachPowerSlice:
	ld hl, ShotPlacementDataReachPowerSlice_07 ; $5235
	ld d, $00 ; $5238
	ld a, [wReachSpeedIndex] ; $523a
	ld e, a ; $523d
	call LoadShotPlacementEntry ; $523e
	call AddBallSpeedEighth ; $5241
	call FinalizeShotSpeed ; $5244
	ret ; $5247
ShotPlacementReach:
	ld hl, ShotPlacementDataReach_07 ; $5248
	ld d, $00 ; $524b
	ld a, [wReachSpeedIndex] ; $524d
	ld e, a ; $5250
	call LoadShotPlacementEntry ; $5251
	call AddBallSpeed3Sixteenths ; $5254
	call FinalizeShotSpeed ; $5257
	ret ; $525a
ShotPlacementLob:
	ld hl, ShotPlacementDataLob_07 ; $525b
	ld a, [wLobPlacementIndex] ; $525e
	ld d, a ; $5261
	ld e, $00 ; $5262
	call LoadShotPlacementEntry ; $5264
	ret ; $5267
ShotPlacementDrop:
	ld hl, ShotPlacementDataDrop_07 ; $5268
	ld a, [wDropPlacementIndex] ; $526b
	ld d, a ; $526e
	ld e, $00 ; $526f
	call LoadShotPlacementEntry ; $5271
	ret ; $5274
ShotPlacementServeTopspin:
	ld hl, ShotPlacementDataServeTopspin_07 ; $5275
	ld a, [wTopspinPlacementIndex] ; $5278
	ld d, a ; $527b
	ld a, [wSmashServeSpeedIndex] ; $527c
	ld e, a ; $527f
	call LoadShotPlacementEntry ; $5280
	ret ; $5283
ShotPlacementServeSlice:
	ld hl, ShotPlacementDataServeSlice_07 ; $5284
	ld a, [wSlicePlacementIndex] ; $5287
	ld d, a ; $528a
	ld a, [wSmashServeSpeedIndex] ; $528b
	ld e, a ; $528e
	call LoadShotPlacementEntry ; $528f
	ret ; $5292
ShotPlacementServeFlat:
	ld hl, ShotPlacementDataServeFlat_07 ; $5293
	ld d, $00 ; $5296
	ld a, [wSmashServeSpeedIndex] ; $5298
	ld e, a ; $529b
	call LoadShotPlacementEntry ; $529c
	ret ; $529f
LoadShotPlacementEntry:
	push hl ; $52a0
	ld a, d ; $52a1
	add a ; $52a2
	add a ; $52a3
	add a ; $52a4
	add l ; $52a5
	ld l, a ; $52a6
	jr nc, .gotEntry ; $52a7
	inc h ; $52a9
.gotEntry:
	ld a, [hl+] ; $52aa
	ld [wBallTopspin], a ; $52ab
	ld a, [hl+] ; $52ae
	ld [wBallTopspin + 1], a ; $52af
	ld a, [hl+] ; $52b2
	ld b, [hl] ; $52b3
	ld c, a ; $52b4
	ld a, [wShotAimMirror] ; $52b5
	and a ; $52b8
	jr z, .storeSideSpin ; $52b9
	xor a ; $52bb
	sub c ; $52bc
	ld c, a ; $52bd
	sbc a ; $52be
	sub b ; $52bf
	ld b, a ; $52c0
.storeSideSpin:
	ld hl, wBallSideSpin ; $52c1
	ld a, c ; $52c4
	ld [hl+], a ; $52c5
	ld [hl], b ; $52c6
	pop hl ; $52c7
	ld a, e ; $52c8
	add a ; $52c9
	add a ; $52ca
	add a ; $52cb
	add $04 ; $52cc
	add l ; $52ce
	ld l, a ; $52cf
	jr nc, .readTarget ; $52d0
	inc h ; $52d2
.readTarget:
	ld a, [hl+] ; $52d3
	ld b, [hl] ; $52d4
	ld c, a ; $52d5
	ret ; $52d6
FinalizeShotSpeed:
	call AddPlayerMomentumToShot ; $52d7
	call ApplyCharFlagShotSpeedPenalty ; $52da
	ld hl, $ff00 ; $52dd
	add hl, bc ; $52e0
	bit 7, h ; $52e1
	jr z, .store ; $52e3
	ld bc, $0100 ; $52e5
.store:
	ld a, c ; $52e8
	ld [wShotSpeedFinal], a ; $52e9
	ld a, b ; $52ec
	ld [wShotSpeedFinal + 1], a ; $52ed
	ret ; $52f0
AddBallSpeedQuarter:
	ld hl, wBallVelocityDepth ; $52f1
	ld a, [hl+] ; $52f4
	ld h, [hl] ; $52f5
	ld l, a ; $52f6
	sra h ; $52f7
	rr l ; $52f9
	sra h ; $52fb
	rr l ; $52fd
	jr AddBallSpeedEighth.absSpeed ; $52ff
AddBallSpeed3Sixteenths:
	ld hl, wBallVelocityDepth ; $5301
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
	jr AddBallSpeedEighth.absSpeed ; $531b
AddBallSpeedEighth:
	ld hl, wBallVelocityDepth ; $531d
	ld a, [hl+] ; $5320
	ld h, [hl] ; $5321
	ld l, a ; $5322
	sra h ; $5323
	rr l ; $5325
	sra h ; $5327
	rr l ; $5329
	sra h ; $532b
	rr l ; $532d
.absSpeed:
	bit 7, h ; $532f
	jr nz, .store ; $5331
	xor a ; $5333
	sub l ; $5334
	ld l, a ; $5335
	sbc a ; $5336
	sub h ; $5337
	ld h, a ; $5338
.store:
	ld a, l ; $5339
	ld [wShotSpeedBallTerm], a ; $533a
	ld a, h ; $533d
	ld [wShotSpeedBallTerm + 1], a ; $533e
	add hl, bc ; $5341
	ld c, l ; $5342
	ld b, h ; $5343
	ret ; $5344
AddChargeSpeedBonus:
	ld a, [wShotChargeLevel] ; $5345
	ld l, a ; $5348
	ld h, $00 ; $5349
	ld de, $ffe0 ; $534b
	add hl, de ; $534e
	ld a, $80 ; $534f
	bit 7, h ; $5351
	jr z, .done ; $5353
	srl a ; $5355
.done:
	call MulHLByASignedFull ; $5357
	jr AddChargeSpeedBonusHalf.store ; $535a
AddChargeSpeedBonusHalf:
	ld a, [wShotChargeLevel] ; $535c
	ld l, a ; $535f
	ld h, $00 ; $5360
	ld de, $ffe0 ; $5362
	add hl, de ; $5365
	ld a, $40 ; $5366
	bit 7, h ; $5368
	jr z, .scale ; $536a
	srl a ; $536c
.scale:
	call MulHLByASignedFull ; $536e
	jr .store ; $5371
.store:
	ld a, l ; $5373
	ld [wShotSpeedChargeTerm], a ; $5374
	ld a, h ; $5377
	ld [wShotSpeedChargeTerm + 1], a ; $5378
	add hl, bc ; $537b
	ld c, l ; $537c
	ld b, h ; $537d
	ret ; $537e
AddPlayerMomentumToShot:
	ld hl, wCharVelDepth ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	sra h ; $5385
	rr l ; $5387
	ld a, [wCharCourtPos] ; $5389
	and $02 ; $538c
	jr nz, .store ; $538e
	xor a ; $5390
	sub l ; $5391
	ld l, a ; $5392
	sbc a ; $5393
	sub h ; $5394
	ld h, a ; $5395
.store:
	ld a, l ; $5396
	ld [wShotSpeedMomentumTerm], a ; $5397
	ld a, h ; $539a
	ld [wShotSpeedMomentumTerm + 1], a ; $539b
	add hl, bc ; $539e
	ld c, l ; $539f
	ld b, h ; $53a0
	ret ; $53a1
ApplyCharFlagShotSpeedPenalty:
	ld hl, wCharFlags ; $53a2
	bit 1, [hl] ; $53a5
	jr z, .done ; $53a7
	ld hl, $f400 ; $53a9
	add hl, bc ; $53ac
	ld c, l ; $53ad
	ld b, h ; $53ae
.done:
	ret ; $53af
ExecuteShot:
	ld hl, wBallHitEvent ; $53b0
	ld a, [hl] ; $53b3
	and a ; $53b4
	ret nz ; $53b5
	ld a, $01 ; $53b6
	ld [wBallHitEvent], a ; $53b8
	ld a, [wCharIndex] ; $53bb
	ld [wLastShotCharIndex], a ; $53be
	ld a, [wCharServeRole] ; $53c1
	ld [wLastShotServeRole], a ; $53c4
	ld a, [wCharAimOffset] ; $53c7
	ld [wLastShotAimOffset], a ; $53ca
	ld a, [wCharShotType] ; $53cd
	ld [wCurrentShotType], a ; $53d0
	ld a, [wCharShotButton1] ; $53d3
	swap a ; $53d6
	ld hl, wCharShotButton2 ; $53d8
	or [hl] ; $53db
	ld [wLastShotButtons], a ; $53dc
	ld a, [wBallCourtQuadrant] ; $53df
	ld [wBallQuadrantAtHit], a ; $53e2
	xor a ; $53e5
	ld [wSpecialShotFlag], a ; $53e6
	ld [wLastShotWasPowerShot], a ; $53e9
	ld [wFallbackTrajectoryFlag], a ; $53ec
	ld b, $00 ; $53ef
	ld a, [wCharSwingAnim] ; $53f1
	cp $06 ; $53f4
	jr nz, .checkShot0a ; $53f6
	inc b ; $53f8
.checkShot0a:
	cp $0a ; $53f9
	jr nz, .checkLeftHanded ; $53fb
	inc b ; $53fd
.checkLeftHanded:
	ld a, [wCharMirrorAttrMask] ; $53fe
	and a ; $5401
	jr z, .checkServe ; $5402
	inc b ; $5404
.checkServe:
	ld a, [wRallyLength] ; $5405
	cp $00 ; $5408
	jr nz, .storeMirror ; $540a
	inc b ; $540c
.storeMirror:
	ld a, b ; $540d
	and $01 ; $540e
	ld [wShotAimMirror], a ; $5410
	ld a, [wCharSwingFrames] ; $5413
	cp $3f ; $5416
	jr c, .storeCharge ; $5418
	ld a, $3f ; $541a
.storeCharge:
	ld [wShotChargeLevel], a ; $541c
	ld a, [$df4c] ; $541f
	ld [$c4a3], a ; $5422
	ld hl, wBallVelocityX ; $5425
	ld a, [hl+] ; $5428
	ld d, [hl] ; $5429
	ld e, a ; $542a
	ld hl, $c454 ; $542b
	ld a, e ; $542e
	ld [hl+], a ; $542f
	ld [hl], d ; $5430
	ld hl, wBallVelocityDepth ; $5431
	ld a, [hl+] ; $5434
	ld d, [hl] ; $5435
	ld e, a ; $5436
	ld hl, $c456 ; $5437
	ld a, e ; $543a
	ld [hl+], a ; $543b
	ld [hl], d ; $543c
	ld hl, ShotRecoilFrameTask ; $543d
	push hl ; $5440
	ld a, [wCurrentShotType] ; $5441
	rst Rst00 ; $5444
	dw ExecuteShotTopspin ; $5445 jumptable
	dw ExecuteShotPowerTopspin ; $5447 jumptable
	dw ExecuteShotSlice ; $5449 jumptable
	dw ExecuteShotPowerSlice ; $544b jumptable
	dw ExecuteShotNeutral ; $544d jumptable
	dw ExecuteShotReach ; $544f jumptable
	dw ExecuteShotReachPowerTopspin ; $5451 jumptable
	dw ExecuteShotReachPowerSlice ; $5453 jumptable
	dw ExecuteShotReachBasic ; $5455 jumptable
	dw ExecuteShotSmash ; $5457 jumptable
	dw ExecuteShotLob ; $5459 jumptable
	dw ExecuteShotDrop ; $545b jumptable
	dw ExecuteShotServeTopspin ; $545d jumptable
	dw ExecuteShotServeSlice ; $545f jumptable
	dw ExecuteShotServeFlat ; $5461 jumptable
ShotRecoilFrameTask:
	call ApplyShotRecoil ; $5463
	xor a ; $5466
	ld [wCharSwingFrames], a ; $5467
	ret ; $546a
ApplyShotRecoil:
	ld hl, wCharFlags ; $546b
	set 0, [hl] ; $546e
	res 5, [hl] ; $5470
	ld a, [wShotRecoilVariant] ; $5472
	add a ; $5475
	add LOW(ShotRecoilVarPtrs_07) ; $5476
	ld l, a ; $5478
	adc HIGH(ShotRecoilVarPtrs_07) ; $5479
	sub l ; $547b
	ld h, a ; $547c
	ld a, [hl+] ; $547d
	ld h, [hl] ; $547e
	ld l, a ; $547f
	ld a, [hl] ; $5480
	add LOW(ShotRecoilTable_07) ; $5481
	ld l, a ; $5483
	adc HIGH(ShotRecoilTable_07) ; $5484
	sub l ; $5486
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
	ld hl, wCharVelDepth ; $5495
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
	ld hl, wCharVelDepth ; $54a6
	ld a, e ; $54a9
	ld [hl+], a ; $54aa
	ld [hl], d ; $54ab
	ld hl, wCharFlags ; $54ac
	bit 1, [hl] ; $54af
	jr nz, .done ; $54b1
	ld hl, wCharVelX ; $54b3
	ld a, [hl+] ; $54b6
	ld h, [hl] ; $54b7
	ld l, a ; $54b8
	sra h ; $54b9
	rr l ; $54bb
	sra h ; $54bd
	rr l ; $54bf
	ld e, l ; $54c1
	ld d, h ; $54c2
	ld hl, wCharVelX ; $54c3
	ld a, e ; $54c6
	ld [hl+], a ; $54c7
	ld [hl], d ; $54c8
.done:
	ret ; $54c9
ShotRecoilVarPtrs_07:
	; $54ca, 10 bytes (records:2)
	dw $df6b ; record 0
	dw $df6d ; record 1
	dw $df6c ; record 2
	dw $df6b ; record 3
	dw $df6c ; record 4
ShotRecoilTable_07:
	; $54d4, 10 bytes (bytes:10)
	db $58, $50, $48, $40, $38, $30, $28, $20, $18, $10 ; 0x00
WeakenShotByCharge:
	ld a, [wShotChargeLevel] ; $54de
	ld l, a ; $54e1
	ld h, $00 ; $54e2
	add hl, hl ; $54e4
	add hl, hl ; $54e5
	ld a, c ; $54e6
	sub l ; $54e7
	ld c, a ; $54e8
	ld a, b ; $54e9
	sbc h ; $54ea
	ld b, a ; $54eb
	ret ; $54ec
BoostShotByCharge:
	ld a, [wShotChargeLevel] ; $54ed
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
	ld hl, wCharVelDepth ; $54fe
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
	ld a, [wCharCourtPos] ; $5514
	and $02 ; $5517
	jr nz, .addMomentum ; $5519
	xor a ; $551b
	sub l ; $551c
	ld l, a ; $551d
	sbc a ; $551e
	sub h ; $551f
	ld h, a ; $5520
.addMomentum:
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
	jr z, .absX ; $552d
	xor a ; $552f
	sub l ; $5530
	ld l, a ; $5531
	sbc a ; $5532
	sub h ; $5533
	ld h, a ; $5534
.absX:
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
	jr z, .done ; $554e
	call AngleFromVector16 ; $5550
	push bc ; $5553
	ld hl, wBallDepth ; $5554
	ld a, [hl+] ; $5557
	ld h, [hl] ; $5558
	ld l, a ; $5559
	bit 7, h ; $555a
	jr z, .absDepth ; $555c
	xor a ; $555e
	sub l ; $555f
	ld l, a ; $5560
	sbc a ; $5561
	sub h ; $5562
	ld h, a ; $5563
.absDepth:
	ld de, $04e0 ; $5564
	add hl, de ; $5567
	ld e, l ; $5568
	ld d, h ; $5569
	ld hl, wBallHeight ; $556a
	ld a, [hl+] ; $556d
	ld h, [hl] ; $556e
	ld l, a ; $556f
	xor a ; $5570
	sub l ; $5571
	ld l, a ; $5572
	sbc a ; $5573
	sub h ; $5574
	ld h, a ; $5575
	call AngleFromVector16 ; $5576
	pop hl ; $5579
	add hl, bc ; $557a
	bit 7, h ; $557b
.done:
	ret ; $557d
ApplyShotTypePresets:
	ld a, [wCurrentShotType] ; $557e
	ld b, a ; $5581
	add a ; $5582
	add a ; $5583
	add b ; $5584
	add LOW(ShotTypePresets_07) ; $5585
	ld l, a ; $5587
	adc HIGH(ShotTypePresets_07) ; $5588
	sub l ; $558a
	ld h, a ; $558b
	ld a, [hl+] ; $558c
	call PlaySoundManaged ; $558d
	ld a, [hl+] ; $5590
	ld [wShotRecoilVariant], a ; $5591
	ld a, [hl+] ; $5594
	push hl ; $5595
	farcall SetBallTrailColor ; $5596
	pop hl ; $5599
	ld a, [hl+] ; $559a
	ld b, [hl] ; $559b
	ld c, a ; $559c
	ret ; $559d
ShotTypePresets_07:
	; $559e, 75 bytes (records:5)
; 15 records x 5 bytes
	db $51, $00, $00, $80, $02 ; record 0
	db $51, $00, $01, $c0, $03 ; record 1
	db $57, $00, $00, $80, $02 ; record 2
	db $57, $00, $02, $c0, $03 ; record 3
	db $51, $00, $00, $c0, $03 ; record 4
	db $51, $01, $00, $c0, $03 ; record 5
	db $51, $01, $00, $80, $04 ; record 6
	db $51, $01, $00, $80, $03 ; record 7
	db $51, $01, $00, $c0, $03 ; record 8
	db $57, $02, $03, $40, $04 ; record 9
	db $53, $03, $00, $00, $02 ; record 10
	db $52, $03, $00, $00, $02 ; record 11
	db $54, $04, $01, $a0, $02 ; record 12
	db $54, $04, $02, $a0, $02 ; record 13
	db $54, $04, $03, $a0, $02 ; record 14
GetShotAimOffsetForSide:
	ld hl, CourtSideOffsets_07_563e ; $55e9
	ld a, [wMinigameUsesWall] ; $55ec
	and a ; $55ef
	jr nz, .readAim ; $55f0
	ld a, [wCharCourtPos] ; $55f2
	and $01 ; $55f5
	add a ; $55f7
	add a ; $55f8
	add a ; $55f9
	add $2e ; $55fa
	ld l, a ; $55fc
	adc $56 ; $55fd
	sub l ; $55ff
	ld h, a ; $5600
.readAim:
	ld a, [wCharAimOffset] ; $5601
	inc a ; $5604
	add a ; $5605
	add l ; $5606
	ld l, a ; $5607
	jr nc, .done ; $5608
	inc h ; $560a
.done:
	ld a, [hl+] ; $560b
	ld d, [hl] ; $560c
	ld e, a ; $560d
	ld hl, wCharPosX + 1 ; $560e
	ld a, [hl+] ; $5611
	ld h, [hl] ; $5612
	ld l, a ; $5613
	xor a ; $5614
	sub l ; $5615
	ld l, a ; $5616
	sbc a ; $5617
	sub h ; $5618
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
CourtSideOffsets_07_562e:
	; $562e, 8 bytes (records:2)
	dw $fe60 ; record 0
	dw $ff20 ; record 1
	dw $ffdc ; record 2
	dw $0000 ; record 3
CourtSideOffsets_07_5636:
	; $5636, 8 bytes (records:2)
	dw $0024 ; record 0
	dw $00e0 ; record 1
	dw $01a0 ; record 2
	dw $0000 ; record 3
CourtSideOffsets_07_563e:
	; $563e, 8 bytes (records:2)
	dw $ff20 ; record 0
	dw $0000 ; record 1
	dw $00e0 ; record 2
	dw $0000 ; record 3
ComputeShotTargetX:
	ld a, [wRallyLength] ; $5646
	and a ; $5649
	jr z, GetShotAimOffsetForSide ; $564a
	call ComputeAimBaseOffset ; $564c
	ld a, [wCharAimOffset] ; $564f
	add $02 ; $5652
	and $07 ; $5654
	ld a, a ; $5656
	rst Rst00 ; $5657
	dw ComputeShotTargetX.fromBallX ; $5658 jumptable
	dw ComputeShotTargetX.halveShort ; $565a jumptable
	dw ComputeShotTargetX.straight ; $565c jumptable
	dw ComputeShotTargetX.halveLong ; $565e jumptable
	dw ComputeShotTargetX.fromBallXLong ; $5660 jumptable
	dw ComputeShotTargetX.straight ; $5662 jumptable
	dw ComputeShotTargetX.straight ; $5664 jumptable
	dw ComputeShotTargetX.straight ; $5666 jumptable
.halveShort:
	sra d ; $5668
	rr e ; $566a
.fromBallX:
	ld hl, wBallX ; $566c
	ld a, [hl+] ; $566f
	ld h, [hl] ; $5670
	ld l, a ; $5671
	xor a ; $5672
	sub l ; $5673
	ld l, a ; $5674
	sbc a ; $5675
	sub h ; $5676
	ld h, a ; $5677
	add hl, de ; $5678
	ld e, l ; $5679
	ld d, h ; $567a
	call ClampShotTargetX ; $567b
	xor a ; $567e
	sub e ; $567f
	ld e, a ; $5680
	sbc a ; $5681
	sub d ; $5682
	ld d, a ; $5683
	ret ; $5684
.halveLong:
	sra d ; $5685
	rr e ; $5687
.fromBallXLong:
	ld hl, wBallX ; $5689
	ld a, [hl+] ; $568c
	ld h, [hl] ; $568d
	ld l, a ; $568e
	add hl, de ; $568f
	ld e, l ; $5690
	ld d, h ; $5691
	call ClampShotTargetX ; $5692
	ret ; $5695
.straight:
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
	sub h ; $56a8
	ld e, a ; $56a9
	jr nc, .absTarget ; $56aa
	dec d ; $56ac
.absTarget:
	call GetRandomAimJitter ; $56ad
	ld a, h ; $56b0
	add e ; $56b1
	ld e, a ; $56b2
	jr nc, .store ; $56b3
	inc d ; $56b5
.store:
	ret ; $56b6
ComputeAimBaseOffset:
	ld hl, wAimSpreadBase ; $56b7
	ld a, [hl+] ; $56ba
	ld d, [hl] ; $56bb
	ld e, a ; $56bc
	ld hl, wCharPosDepth + 1 ; $56bd
	ld a, [hl+] ; $56c0
	ld h, [hl] ; $56c1
	ld l, a ; $56c2
	bit 7, h ; $56c3
	jr z, .quarter ; $56c5
	xor a ; $56c7
	sub l ; $56c8
	ld l, a ; $56c9
	sbc a ; $56ca
	sub h ; $56cb
	ld h, a ; $56cc
.quarter:
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
	ld hl, wCourtLimitX ; $56e3
	ld a, [hl+] ; $56e6
	ld h, [hl] ; $56e7
	ld l, a ; $56e8
	ld bc, $0020 ; $56e9
	add hl, bc ; $56ec
	xor a ; $56ed
	sub l ; $56ee
	ld l, a ; $56ef
	sbc a ; $56f0
	sub h ; $56f1
	ld h, a ; $56f2
	ld c, l ; $56f3
	ld b, h ; $56f4
	ld l, e ; $56f5
	ld h, d ; $56f6
	ld a, l ; $56f7
	sub c ; $56f8
	ld l, a ; $56f9
	ld a, h ; $56fa
	sbc b ; $56fb
	ld h, a ; $56fc
	bit 7, h ; $56fd
	jr nz, .applyJitter ; $56ff
	ld e, c ; $5701
	ld d, b ; $5702
.applyJitter:
	call GetRandomAimJitter ; $5703
	ld a, e ; $5706
	sub h ; $5707
	ld e, a ; $5708
	jr nc, .done ; $5709
	dec d ; $570b
.done:
	ret ; $570c
GetRandomAimJitter:
	farcall AdvanceMatchRng ; $570d
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
	ld a, [wCharCourtPos] ; $571e
	and $02 ; $5721
	jr nz, .aimReady ; $5723
	xor a ; $5725
	sub c ; $5726
	ld c, a ; $5727
	sbc a ; $5728
	sub b ; $5729
	ld b, a ; $572a
.aimReady:
	ld hl, wShotAimTargetDepth ; $572b
	ld a, c ; $572e
	ld [hl+], a ; $572f
	ld [hl], b ; $5730
	ld hl, wBallDepth ; $5731
	ld a, [hl+] ; $5734
	ld h, [hl] ; $5735
	ld l, a ; $5736
	ld a, c ; $5737
	sub l ; $5738
	ld c, a ; $5739
	ld a, b ; $573a
	sbc h ; $573b
	ld b, a ; $573c
	ld hl, wShotAimDeltaDepth ; $573d
	ld a, c ; $5740
	ld [hl+], a ; $5741
	ld [hl], b ; $5742
	call ComputeShotTargetX ; $5743
	ld hl, wShotAimTargetX ; $5746
	ld a, e ; $5749
	ld [hl+], a ; $574a
	ld [hl], d ; $574b
	ld hl, wBallX ; $574c
	ld a, [hl+] ; $574f
	ld h, [hl] ; $5750
	ld l, a ; $5751
	ld a, e ; $5752
	sub l ; $5753
	ld e, a ; $5754
	ld a, d ; $5755
	sbc h ; $5756
	ld d, a ; $5757
	ld hl, wShotAimDeltaX ; $5758
	ld a, e ; $575b
	ld [hl+], a ; $575c
	ld [hl], d ; $575d
	ld hl, wShotAimDeltaDepth ; $575e
	ld a, [hl+] ; $5761
	ld h, [hl] ; $5762
	ld l, a ; $5763
	call AngleFromVector16 ; $5764
	ld hl, wShotAimAngle ; $5767
	ld a, c ; $576a
	ld [hl+], a ; $576b
	ld [hl], b ; $576c
	ld hl, wShotAimAngle ; $576d
	ld a, [hl+] ; $5770
	ld b, [hl] ; $5771
	ld c, a ; $5772
	ld hl, wBallDepth ; $5773
	ld a, [hl+] ; $5776
	ld h, [hl] ; $5777
	ld l, a ; $5778
	bit 7, h ; $5779
	jr z, .absMinDepth ; $577b
	xor a ; $577d
	sub l ; $577e
	ld l, a ; $577f
	sbc a ; $5780
	sub h ; $5781
	ld h, a ; $5782
.absMinDepth:
	ld de, $0140 ; $5783
	add hl, de ; $5786
	call DivBySin ; $5787
	bit 7, h ; $578a
	jr z, .absMinDist ; $578c
	xor a ; $578e
	sub l ; $578f
	ld l, a ; $5790
	sbc a ; $5791
	sub h ; $5792
	ld h, a ; $5793
.absMinDist:
	ld e, l ; $5794
	ld d, h ; $5795
	add hl, hl ; $5796
	add hl, hl ; $5797
	ld a, h ; $5798
	ld [wShotTrajRowMin], a ; $5799
	ld hl, wShotDistMin ; $579c
	ld a, e ; $579f
	ld [hl+], a ; $57a0
	ld [hl], d ; $57a1
	ld hl, wShotAimAngle ; $57a2
	ld a, [hl+] ; $57a5
	ld b, [hl] ; $57a6
	ld c, a ; $57a7
	ld hl, wBallDepth ; $57a8
	ld a, [hl+] ; $57ab
	ld h, [hl] ; $57ac
	ld l, a ; $57ad
	bit 7, h ; $57ae
	jr z, .absMaxDepth ; $57b0
	xor a ; $57b2
	sub l ; $57b3
	ld l, a ; $57b4
	sbc a ; $57b5
	sub h ; $57b6
	ld h, a ; $57b7
.absMaxDepth:
	ld de, $0480 ; $57b8
	add hl, de ; $57bb
	call DivBySin ; $57bc
	bit 7, h ; $57bf
	jr z, .absMaxDist ; $57c1
	xor a ; $57c3
	sub l ; $57c4
	ld l, a ; $57c5
	sbc a ; $57c6
	sub h ; $57c7
	ld h, a ; $57c8
.absMaxDist:
	ld e, l ; $57c9
	ld d, h ; $57ca
	add hl, hl ; $57cb
	add hl, hl ; $57cc
	ld a, h ; $57cd
	ld [wShotTrajRowMax], a ; $57ce
	ld hl, wShotDistMax ; $57d1
	ld a, e ; $57d4
	ld [hl+], a ; $57d5
	ld [hl], d ; $57d6
	ld hl, wShotAimAngle ; $57d7
	ld a, [hl+] ; $57da
	ld b, [hl] ; $57db
	ld c, a ; $57dc
	ld l, e ; $57dd
	ld h, d ; $57de
	call MulSinCos ; $57df
	bit 7, h ; $57e2
	jr z, .absSideways ; $57e4
	xor a ; $57e6
	sub l ; $57e7
	ld l, a ; $57e8
	sbc a ; $57e9
	sub h ; $57ea
	ld h, a ; $57eb
.absSideways:
	ld c, l ; $57ec
	ld b, h ; $57ed
	ld hl, $ffe0 ; $57ee
	add hl, bc ; $57f1
	jr nc, .solveHeight ; $57f2
	ld hl, wCourtLimitX ; $57f4
	ld a, [hl+] ; $57f7
	ld h, [hl] ; $57f8
	ld l, a ; $57f9
	ld de, $0020 ; $57fa
	add hl, de ; $57fd
	ld e, l ; $57fe
	ld d, h ; $57ff
	ld a, [wShotAimAngle + 1] ; $5800
	add $40 ; $5803
	bit 7, a ; $5805
	jr z, .absLimitX ; $5807
	xor a ; $5809
	sub e ; $580a
	ld e, a ; $580b
	sbc a ; $580c
	sub d ; $580d
	ld d, a ; $580e
.absLimitX:
	ld hl, wBallX ; $580f
	ld a, [hl+] ; $5812
	ld h, [hl] ; $5813
	ld l, a ; $5814
	add hl, de ; $5815
	bit 7, h ; $5816
	jr z, .absBallX ; $5818
	xor a ; $581a
	sub l ; $581b
	ld l, a ; $581c
	sbc a ; $581d
	sub h ; $581e
	ld h, a ; $581f
.absBallX:
	ld e, l ; $5820
	ld d, h ; $5821
	ld a, l ; $5822
	sub c ; $5823
	ld l, a ; $5824
	ld a, h ; $5825
	sbc b ; $5826
	ld h, a ; $5827
	bit 7, h ; $5828
	jr z, .solveHeight ; $582a
	push de ; $582c
	ld l, $00 ; $582d
	ld a, [wShotDistMax] ; $582f
	ld h, a ; $5832
	ld a, [wShotDistMax + 1] ; $5833
	ld e, c ; $5836
	ld d, b ; $5837
	call DivAHLByDESigned ; $5838
	pop de ; $583b
	call MulHLByDE ; $583c
	ld h, l ; $583f
	ldh a, [hMulResult + 1] ; $5840
	ld l, a ; $5842
	ld e, l ; $5843
	ld d, h ; $5844
	add hl, hl ; $5845
	add hl, hl ; $5846
	ld a, h ; $5847
	ld [wShotTrajRowMax], a ; $5848
	ld hl, wShotDistMax ; $584b
	ld a, e ; $584e
	ld [hl+], a ; $584f
	ld [hl], d ; $5850
.solveHeight:
	ld hl, wBallHeight ; $5851
	ld a, [hl+] ; $5854
	ld d, [hl] ; $5855
	ld e, a ; $5856
	xor a ; $5857
	sub e ; $5858
	ld e, a ; $5859
	sbc a ; $585a
	sub d ; $585b
	ld d, a ; $585c
	ld hl, $c470 ; $585d
	ld a, e ; $5860
	ld [hl+], a ; $5861
	ld [hl], d ; $5862
	ld hl, wShotAimTargetX ; $5863
	ld de, wBallTargetX ; $5866
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
	jr nz, .done ; $5882
	ld hl, $0060 ; $5884
	add hl, de ; $5887
	sra h ; $5888
	rr l ; $588a
	ld a, e ; $588c
	sub l ; $588d
	ld e, a ; $588e
	ld a, d ; $588f
	sbc h ; $5890
	ld d, a ; $5891
	ld hl, wBallHeight ; $5892
	ld a, e ; $5895
	ld [hl+], a ; $5896
	ld [hl], d ; $5897
.done:
	ret ; $5898
RaiseBallHeightForLob:
	ld hl, wBallHeight ; $5899
	ld a, [hl+] ; $589c
	ld d, [hl] ; $589d
	ld e, a ; $589e
	ld hl, $0080 ; $589f
	add hl, de ; $58a2
	bit 7, h ; $58a3
	jr nz, .raise ; $58a5
	ld de, $ffa0 ; $58a7
	ld hl, wBallHeight ; $58aa
	ld a, e ; $58ad
	ld [hl+], a ; $58ae
	ld [hl], d ; $58af
	ret ; $58b0
.raise:
	ld hl, $0020 ; $58b1
	add hl, de ; $58b4
	ld e, l ; $58b5
	ld d, h ; $58b6
	ld hl, wBallHeight ; $58b7
	ld a, e ; $58ba
	ld [hl+], a ; $58bb
	ld [hl], d ; $58bc
	ret ; $58bd
ExecuteShotTopspin:
	ld a, SHOTTYPE_TOPSPIN ; $58be
	ld [wCurrentShotType], a ; $58c0
	call NormalizeBallHeightForShot ; $58c3
	call ApplyShotTypePresets ; $58c6
	call WeakenShotByCharge ; $58c9
	call ComputeShotTrajectory ; $58cc
	farcall ShotBallPathTopspin ; $58cf
	ret ; $58d2
ExecuteShotPowerTopspin:
	ld hl, wCharFlags ; $58d3
	bit 1, [hl] ; $58d6
	jr nz, ExecuteShotTopspin ; $58d8
	ld a, $01 ; $58da
	ld [wLastShotWasPowerShot], a ; $58dc
	call NormalizeBallHeightForShot ; $58df
	call ApplyShotTypePresets ; $58e2
	call ComputeShotTrajectory ; $58e5
	farcall ShotBallPathPowerTopspin ; $58e8
	ret ; $58eb
ExecuteShotSlice:
	ld a, SHOTTYPE_SLICE ; $58ec
	ld [wCurrentShotType], a ; $58ee
	call NormalizeBallHeightForShot ; $58f1
	call ApplyShotTypePresets ; $58f4
	call WeakenShotByCharge ; $58f7
	call ComputeShotTrajectory ; $58fa
	farcall ShotBallPathSlice ; $58fd
	ret ; $5900
ExecuteShotPowerSlice:
	ld hl, wCharFlags ; $5901
	bit 1, [hl] ; $5904
	jr nz, ExecuteShotSlice ; $5906
	ld a, $01 ; $5908
	ld [wLastShotWasPowerShot], a ; $590a
	call NormalizeBallHeightForShot ; $590d
	call ApplyShotTypePresets ; $5910
	call ComputeShotTrajectory ; $5913
	farcall ShotBallPathPowerSlice ; $5916
	ret ; $5919
ExecuteShotLob:
	call RaiseBallHeightForLob ; $591a
	call ApplyShotTypePresets ; $591d
	call BoostShotByCharge ; $5920
	call NudgeShotByPlayerMomentum ; $5923
	farcall ComputeShotTrajectory ; $5926
	farcall ShotBallPathLob ; $5929
	ret ; $592c
ExecuteShotDrop:
	call RaiseBallHeightForLob ; $592d
	call ApplyShotTypePresets ; $5930
	call WeakenShotByCharge ; $5933
	call ComputeShotTrajectory ; $5936
	farcall ShotBallPathDrop ; $5939
	ret ; $593c
ExecuteShotReachBasic:
	call CheckBallInSmashRange ; $593d
	jr z, ExecuteShotReach ; $5940
	call NormalizeBallHeightForShot ; $5942
	call ApplyShotTypePresets ; $5945
	call WeakenShotByCharge ; $5948
	call ComputeShotTrajectory ; $594b
	farcall ProjectShotPlacement0 ; $594e
	ret ; $5951
ExecuteShotReachPowerTopspin:
	call CheckBallInSmashRange ; $5952
	jr z, ExecuteShotReach ; $5955
	call NormalizeBallHeightForShot ; $5957
	call ApplyShotTypePresets ; $595a
	call WeakenShotByCharge ; $595d
	call ComputeShotTrajectory ; $5960
	farcall ProjectShotPlacement1 ; $5963
	ret ; $5966
ExecuteShotReachPowerSlice:
	call CheckBallInSmashRange ; $5967
	jr z, ExecuteShotReach ; $596a
	call NormalizeBallHeightForShot ; $596c
	call ApplyShotTypePresets ; $596f
	call WeakenShotByCharge ; $5972
	call ComputeShotTrajectory ; $5975
	farcall ProjectShotPlacement2 ; $5978
	ret ; $597b
ExecuteShotReach:
	ld a, SHOTTYPE_REACH ; $597c
	ld [wCurrentShotType], a ; $597e
	call NormalizeBallHeightForShot ; $5981
	call ApplyShotTypePresets ; $5984
	call WeakenShotByCharge ; $5987
	call ComputeShotTrajectory ; $598a
	farcall ShotBallPathReach ; $598d
	ret ; $5990
ExecuteShotSmash:
	ld a, SHOTTYPE_SMASH ; $5991
	ld [wCurrentShotType], a ; $5993
	ld a, $01 ; $5996
	ld [wLastShotWasPowerShot], a ; $5998
	call NormalizeBallHeightForShot ; $599b
	call ApplyShotTypePresets ; $599e
	call ComputeShotTrajectory ; $59a1
	farcall ShotBallPathSmash ; $59a4
	ret ; $59a7
ExecuteShotNeutral:
	call CheckBallInSmashRange ; $59a8
	jr z, .neutralShot ; $59ab
	ld a, [wCharSwingAnim] ; $59ad
	cp $07 ; $59b0
	jr z, ExecuteShotSmash ; $59b2
	cp $08 ; $59b4
	jr z, ExecuteShotSmash ; $59b6
.neutralShot:
	call NormalizeBallHeightForShot ; $59b8
	call ApplyShotTypePresets ; $59bb
	call ComputeShotTrajectory ; $59be
	farcall ShotBallPathNeutral ; $59c1
	ret ; $59c4
ExecuteShotServeTopspin:
	call ApplyShotTypePresets ; $59c5
	call ComputeShotTrajectory ; $59c8
	farcall ShotBallPathServeTopspin ; $59cb
	call SetSpecialShotFlagFromBallHeight ; $59ce
	ret ; $59d1
ExecuteShotServeSlice:
	call ApplyShotTypePresets ; $59d2
	call ComputeShotTrajectory ; $59d5
	farcall ShotBallPathServeSlice ; $59d8
	call SetSpecialShotFlagFromBallHeight ; $59db
	ret ; $59de
ExecuteShotServeFlat:
	call ApplyShotTypePresets ; $59df
	call ComputeShotTrajectory ; $59e2
	farcall ShotBallPathServeFlat ; $59e5
	call SetSpecialShotFlagFromBallHeight ; $59e8
	ret ; $59eb
	ld hl, wBallHeight ; $59ec
	ld a, [hl+] ; $59ef
	ld h, [hl] ; $59f0
	ld l, a ; $59f1
	ld de, $0140 ; $59f2
	add hl, de ; $59f5
	jr c, .done ; $59f6
	ld a, $01 ; $59f8
	ld [wSpecialShotFlag], a ; $59fa
	ld [wLastShotWasPowerShot], a ; $59fd
.done:
	ret ; $5a00
SetSpecialShotFlagFromBallHeight:
	ld hl, wBallHeight ; $5a01
	ld a, [hl+] ; $5a04
	ld h, [hl] ; $5a05
	ld l, a ; $5a06
	xor a ; $5a07
	sub l ; $5a08
	ld l, a ; $5a09
	sbc a ; $5a0a
	sub h ; $5a0b
	ld h, a ; $5a0c
	add hl, hl ; $5a0d
	add hl, hl ; $5a0e
	add hl, hl ; $5a0f
	add hl, hl ; $5a10
	ld a, h ; $5a11
	and $1f ; $5a12
	add LOW(SpecialShotFlagTable_07) ; $5a14
	ld l, a ; $5a16
	adc HIGH(SpecialShotFlagTable_07) ; $5a17
	sub l ; $5a19
	ld h, a ; $5a1a
	ld a, [hl] ; $5a1b
	ld [wSpecialShotFlag], a ; $5a1c
	ld [wLastShotWasPowerShot], a ; $5a1f
	ret ; $5a22
SpecialShotFlagTable_07:
	; $5a23, 32 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x10
LookupCharSpriteSet:
	push hl ; $5a43
	and $3f ; $5a44
	add LOW(CharSpriteSetTable) ; $5a46
	ld l, a ; $5a48
	adc HIGH(CharSpriteSetTable) ; $5a49
	sub l ; $5a4b
	ld h, a ; $5a4c
	ld a, [hl] ; $5a4d
	pop hl ; $5a4e
	ret ; $5a4f
CharSpriteSetTable:
	; $5a50, 32 bytes (bytes:16)
	db $00, $01, $03, $02, $0c, $16, $0d, $17, $0f, $18, $19, $0e, $05, $07, $06, $09 ; 0x00
	db $08, $04, $0b, $0a, $0a, $1a, $0c, $1b, $1c, $1d, $10, $11, $12, $13, $15, $14 ; 0x10
SetupCharacterSprite:
	push de ; $5a70
	farcall SetupCharSpriteFromObjectDef ; $5a71
	pop de ; $5a74
	ld a, e ; $5a75
	ld [wCharGfxBank], a ; $5a76
	ld a, [wCharIndex] ; $5a79
	add $04 ; $5a7c
	ld [wCharSpriteAttr], a ; $5a7e
	ld a, [wCharIndex] ; $5a81
	add LOW(Data_07_5aaf) ; $5a84
	ld l, a ; $5a86
	adc HIGH(Data_07_5aaf) ; $5a87
	sub l ; $5a89
	ld h, a ; $5a8a
	ld a, [hl] ; $5a8b
	ld [wCharTileBase], a ; $5a8c
	ld a, [wCharIndex] ; $5a8f
	add a ; $5a92
	add LOW(CharFrameGfxDest_07) ; $5a93
	ld l, a ; $5a95
	adc HIGH(CharFrameGfxDest_07) ; $5a96
	sub l ; $5a98
	ld h, a ; $5a99
	ld a, [hl+] ; $5a9a
	ld d, [hl] ; $5a9b
	ld e, a ; $5a9c
	ld hl, wCharFrameVramDest ; $5a9d
	ld a, e ; $5aa0
	ld [hl+], a ; $5aa1
	ld [hl], d ; $5aa2
	farcall ReloadCharFrameGfx ; $5aa3
	ret ; $5aa6
CharFrameGfxDest_07:
	; $5aa7, 8 bytes (records:2)
	dw $a000 ; record 0
	dw $a100 ; record 1
	dw $a200 ; record 2
	dw $a300 ; record 3
Data_07_5aaf:
	INCBIN "data/bank_007/d_5aaf.bin" ; $5aaf, 4 bytes
; Copies one character's attribute record into the per-character struct: the
; reach box CheckCharBallContact tests against, the jump-smash and dive speeds,
; and the six AI parameters at record +$0f and +$1b-$1f -- home-position
; strategy, the two reaction delays, ball tracking, aim-away chance and serve
; style. Those six are exactly the block OverrideCharStatsForDebug rewrites,
; which is the corroboration that they are the AI's personality and not
; physics.
LoadCharacterAttributes:
	ld a, [wCharIndex] ; $5ab3
	add a ; $5ab6
	add LOW(CharAttrStructPtrs_07) ; $5ab7
	ld l, a ; $5ab9
	adc HIGH(CharAttrStructPtrs_07) ; $5aba
	sub l ; $5abc
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
	ld hl, wCharReachHeight ; $5ace
	ld a, c ; $5ad1
	ld [hl+], a ; $5ad2
	ld [hl], b ; $5ad3
	ld hl, $0012 ; $5ad4
	add hl, de ; $5ad7
	ld a, [hl+] ; $5ad8
	ld b, [hl] ; $5ad9
	ld c, a ; $5ada
	ld hl, wCharReachX ; $5adb
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
	ld hl, wCharSmashJumpSpeed ; $5aee
	ld a, c ; $5af1
	ld [hl+], a ; $5af2
	ld [hl], b ; $5af3
	ld hl, $0016 ; $5af4
	add hl, de ; $5af7
	ld a, [hl+] ; $5af8
	ld b, [hl] ; $5af9
	ld c, a ; $5afa
	ld hl, wCharDiveSpeed ; $5afb
	ld a, c ; $5afe
	ld [hl+], a ; $5aff
	ld [hl], b ; $5b00
	ld hl, $0019 ; $5b01
	add hl, de ; $5b04
	ld a, [hl+] ; $5b05
	ld b, [hl] ; $5b06
	ld c, a ; $5b07
	ld hl, wCharSwingAttrWord ; $5b08
	ld a, c ; $5b0b
	ld [hl+], a ; $5b0c
	ld [hl], b ; $5b0d
	ld hl, $0018 ; $5b0e
	add hl, de ; $5b11
	ld a, [hl] ; $5b12
	ld [wCharExpTier], a ; $5b13
	ld b, $00 ; $5b16
	ld hl, $000e ; $5b18
	add hl, de ; $5b1b
	ld a, [hl] ; $5b1c
	and a ; $5b1d
	jr z, .storeHandedness ; $5b1e
	ld b, $20 ; $5b20
.storeHandedness:
	ld a, b ; $5b22
	ld [wCharMirrorAttrMask], a ; $5b23
	ld hl, $0027 ; $5b26
	add hl, de ; $5b29
	ld a, [hl] ; $5b2a
	add a ; $5b2b
	add LOW(CharStatTable_07_5c4a) ; $5b2c
	ld l, a ; $5b2e
	adc HIGH(CharStatTable_07_5c4a) ; $5b2f
	sub l ; $5b31
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
	add [hl] ; $5b45
	add a ; $5b46
	jr nc, .clampSpin ; $5b47
	xor a ; $5b49
	jr .readPlacementTable ; $5b4a
.clampSpin:
	rra ; $5b4c
	cp $0a ; $5b4d
	jr c, .readPlacementTable ; $5b4f
	ld a, $0a ; $5b51
	dec a ; $5b53
.readPlacementTable:
	add a ; $5b54
	add LOW(CharStatTable_07_5c4a) ; $5b55
	ld l, a ; $5b57
	adc HIGH(CharStatTable_07_5c4a) ; $5b58
	sub l ; $5b5a
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
	add a ; $5b6a
	add LOW(CharStatTable_07_5c5e) ; $5b6b
	ld l, a ; $5b6d
	adc HIGH(CharStatTable_07_5c5e) ; $5b6e
	sub l ; $5b70
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
	add a ; $5b80
	add LOW(CharStatTable_07_5c72) ; $5b81
	ld l, a ; $5b83
	adc HIGH(CharStatTable_07_5c72) ; $5b84
	sub l ; $5b86
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
	add LOW(CharStatTable_07_5c86) ; $5b96
	ld l, a ; $5b98
	adc HIGH(CharStatTable_07_5c86) ; $5b99
	sub l ; $5b9b
	ld h, a ; $5b9c
	ld a, [hl] ; $5b9d
	ld [wCharFacingEaseRate], a ; $5b9e
	ld hl, $0025 ; $5ba1
	add hl, de ; $5ba4
	ld a, [hl] ; $5ba5
	add LOW(CharStatTable_07_5c90) ; $5ba6
	ld l, a ; $5ba8
	adc HIGH(CharStatTable_07_5c90) ; $5ba9
	sub l ; $5bab
	ld h, a ; $5bac
	ld a, [hl] ; $5bad
	ld [$df69], a ; $5bae
	ld hl, $0026 ; $5bb1
	add hl, de ; $5bb4
	ld a, [hl] ; $5bb5
	add LOW(CharStatTable_07_5c9a) ; $5bb6
	ld l, a ; $5bb8
	adc HIGH(CharStatTable_07_5c9a) ; $5bb9
	sub l ; $5bbb
	ld h, a ; $5bbc
	ld a, [hl] ; $5bbd
	ld [$df6a], a ; $5bbe
	ld hl, $0023 ; $5bc1
	add hl, de ; $5bc4
	ld a, [hl] ; $5bc5
	ld [wGroundStrokeSpeedIndex], a ; $5bc6
	ld hl, $0022 ; $5bc9
	add hl, de ; $5bcc
	ld a, [hl] ; $5bcd
	ld [wSmashServeSpeedIndex], a ; $5bce
	ld hl, $0024 ; $5bd1
	add hl, de ; $5bd4
	ld a, [hl] ; $5bd5
	ld [wReachSpeedIndex], a ; $5bd6
	ld hl, $0021 ; $5bd9
	add hl, de ; $5bdc
	ld a, [hl] ; $5bdd
	ld [wSlicePlacementIndex], a ; $5bde
	ld hl, $0020 ; $5be1
	add hl, de ; $5be4
	ld a, [hl] ; $5be5
	ld [wTopspinPlacementIndex], a ; $5be6
	ld hl, $000f ; $5be9
	add hl, de ; $5bec
	ld a, [hl] ; $5bed
	ld [wAiPositionStrategy], a ; $5bee
	ld hl, $001b ; $5bf1
	add hl, de ; $5bf4
	ld a, [hl] ; $5bf5
	ld [wAiReactionDelayNear], a ; $5bf6
	ld hl, $001c ; $5bf9
	add hl, de ; $5bfc
	ld a, [hl] ; $5bfd
	ld [wAiReactionDelayFar], a ; $5bfe
	ld hl, $001d ; $5c01
	add hl, de ; $5c04
	ld a, [hl] ; $5c05
	ld [wAiTrackingParam], a ; $5c06
	ld hl, $001e ; $5c09
	add hl, de ; $5c0c
	ld a, [hl] ; $5c0d
	ld [wAiAimAwayChance], a ; $5c0e
	ld hl, $001f ; $5c11
	add hl, de ; $5c14
	ld a, [hl] ; $5c15
	ld [wAiServeStyle], a ; $5c16
	ld a, $00 ; $5c19
	ld hl, wCharSwingAttrWord + 1 ; $5c1b
	bit 0, [hl] ; $5c1e
	jr z, .storeLobIndex ; $5c20
	ld a, $01 ; $5c22
.storeLobIndex:
	ld [wLobPlacementIndex], a ; $5c24
	ld a, $00 ; $5c27
	ld hl, wCharSwingAttrWord + 1 ; $5c29
	bit 1, [hl] ; $5c2c
	jr z, .storeDropIndex ; $5c2e
	ld a, $01 ; $5c30
.storeDropIndex:
	ld [wDropPlacementIndex], a ; $5c32
	ld a, [wDebugMatchFlags] ; $5c35
	bit 1, a ; $5c38
	ret z ; $5c3a
	ld a, [wCharIndex] ; $5c3b
	call OverrideCharStatsForDebug ; $5c3e
	ret ; $5c41
CharAttrStructPtrs_07:
	; $5c42, 8 bytes (records:2)
	dw $ca00 ; record 0
	dw $ca80 ; record 1
	dw $ca40 ; record 2
	dw $cac0 ; record 3
CharStatTable_07_5c4a:
	; $5c4a, 20 bytes (records:2)
	dw $0a00 ; record 0
	dw $0a80 ; record 1
	dw $0b00 ; record 2
	dw $0b80 ; record 3
	dw $0c00 ; record 4
	dw $0c80 ; record 5
	dw $0d00 ; record 6
	dw $0d80 ; record 7
	dw $0e00 ; record 8
	dw $0e80 ; record 9
CharStatTable_07_5c5e:
	; $5c5e, 20 bytes (records:2)
	dw $0030 ; record 0
	dw $003c ; record 1
	dw $0048 ; record 2
	dw $0054 ; record 3
	dw $0060 ; record 4
	dw $006c ; record 5
	dw $0078 ; record 6
	dw $0084 ; record 7
	dw $0090 ; record 8
	dw $009c ; record 9
CharStatTable_07_5c72:
	; $5c72, 20 bytes (records:2)
	dw $0040 ; record 0
	dw $0060 ; record 1
	dw $0080 ; record 2
	dw $00a0 ; record 3
	dw $00c0 ; record 4
	dw $00e0 ; record 5
	dw $0100 ; record 6
	dw $0120 ; record 7
	dw $0140 ; record 8
	dw $0160 ; record 9
CharStatTable_07_5c86:
	; $5c86, 10 bytes (bytes:10)
	db $06, $07, $08, $09, $0a, $0b, $0c, $0e, $10, $18 ; 0x00
CharStatTable_07_5c90:
	; $5c90, 10 bytes (bytes:10)
	db $75, $84, $93, $a3, $b2, $c1, $d1, $e0, $ef, $ff ; 0x00
CharStatTable_07_5c9a:
	; $5c9a, 10 bytes (bytes:10)
	db $0c, $0b, $0a, $09, $08, $07, $06, $05, $04, $03 ; 0x00
CharStatPresets_07:
	; $5ca4, 80 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $05, $09, $09, $09, $09, $09, $09, $00, $00, $00, $00 ; 0x00
	db $09, $09, $00, $00, $09, $05, $00, $09, $09, $00, $04, $09, $00, $00, $00, $00 ; 0x10
	db $07, $07, $07, $04, $04, $04, $00, $00, $01, $00, $04, $04, $00, $00, $00, $00 ; 0x20
	db $05, $05, $09, $04, $09, $05, $05, $00, $02, $00, $04, $09, $00, $00, $00, $00 ; 0x30
	db $05, $00, $07, $04, $04, $04, $00, $00, $03, $00, $04, $04, $00, $00, $00, $00 ; 0x40
OverrideCharStatsForDebug:
	push af ; $5cf4
	ld a, $04 ; $5cf5
	ld [wAiReactionDelayNear], a ; $5cf7
	ld a, $04 ; $5cfa
	ld [wAiReactionDelayFar], a ; $5cfc
	ld a, $00 ; $5cff
	ld [wAiTrackingParam], a ; $5d01
	ld a, $ff ; $5d04
	ld [wAiAimAwayChance], a ; $5d06
	ld a, $02 ; $5d09
	ld [wAiServeStyle], a ; $5d0b
	ld a, $00 ; $5d0e
	ld [$df6a], a ; $5d10
	ld a, $01 ; $5d13
	ld [wAiPositionStrategy], a ; $5d15
	ld a, $01 ; $5d18
	ld a, $01 ; $5d1a
	pop af ; $5d1c
	ret ; $5d1d
	add a ; $5d1e
	add a ; $5d1f
	add a ; $5d20
	add a ; $5d21
	add LOW(CharStatPresets_07) ; $5d22
	ld l, a ; $5d24
	adc HIGH(CharStatPresets_07) ; $5d25
	sub l ; $5d27
	ld h, a ; $5d28
	ld a, [hl+] ; $5d29
	push hl ; $5d2a
	add a ; $5d2b
	add LOW(CharStatTable_07_5c4a) ; $5d2c
	ld l, a ; $5d2e
	adc HIGH(CharStatTable_07_5c4a) ; $5d2f
	sub l ; $5d31
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
	add a ; $5d40
	add LOW(CharStatTable_07_5c4a) ; $5d41
	ld l, a ; $5d43
	adc HIGH(CharStatTable_07_5c4a) ; $5d44
	sub l ; $5d46
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
	add a ; $5d55
	add LOW(CharStatTable_07_5c5e) ; $5d56
	ld l, a ; $5d58
	adc HIGH(CharStatTable_07_5c5e) ; $5d59
	sub l ; $5d5b
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
	add a ; $5d6a
	add LOW(CharStatTable_07_5c72) ; $5d6b
	ld l, a ; $5d6d
	adc HIGH(CharStatTable_07_5c72) ; $5d6e
	sub l ; $5d70
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
	add LOW(CharStatTable_07_5c86) ; $5d7f
	ld l, a ; $5d81
	adc HIGH(CharStatTable_07_5c86) ; $5d82
	sub l ; $5d84
	ld h, a ; $5d85
	ld a, [hl] ; $5d86
	ld hl, $0068 ; $5d87
	add hl, bc ; $5d8a
	ld [hl], a ; $5d8b
	pop hl ; $5d8c
	ld a, [hl+] ; $5d8d
	push hl ; $5d8e
	add LOW(CharStatTable_07_5c90) ; $5d8f
	ld l, a ; $5d91
	adc HIGH(CharStatTable_07_5c90) ; $5d92
	sub l ; $5d94
	ld h, a ; $5d95
	ld a, [hl] ; $5d96
	ld hl, $0069 ; $5d97
	add hl, bc ; $5d9a
	ld [hl], a ; $5d9b
	pop hl ; $5d9c
	ld a, [hl+] ; $5d9d
	push hl ; $5d9e
	add LOW(CharStatTable_07_5c9a) ; $5d9f
	ld l, a ; $5da1
	adc HIGH(CharStatTable_07_5c9a) ; $5da2
	sub l ; $5da4
	ld h, a ; $5da5
	ld a, [hl] ; $5da6
	ld hl, $006a ; $5da7
	add hl, bc ; $5daa
	ld [hl], a ; $5dab
	pop hl ; $5dac
	ld a, $6b ; $5dad
	add c ; $5daf
	ld e, a ; $5db0
	ld d, b ; $5db1
	ld a, [hl+] ; $5db2
	ld [de], a ; $5db3
	ld a, $6c ; $5db4
	add c ; $5db6
	ld e, a ; $5db7
	ld d, b ; $5db8
	ld a, [hl+] ; $5db9
	ld [de], a ; $5dba
	ld a, $6d ; $5dbb
	add c ; $5dbd
	ld e, a ; $5dbe
	ld d, b ; $5dbf
	ld a, [hl+] ; $5dc0
	ld [de], a ; $5dc1
	ld a, $6e ; $5dc2
	add c ; $5dc4
	ld e, a ; $5dc5
	ld d, b ; $5dc6
	ld a, [hl+] ; $5dc7
	ld [de], a ; $5dc8
	ld a, $6f ; $5dc9
	add c ; $5dcb
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
	ld [wCurrentStorySlot], a ; $5e00
	ld a, $01 ; $5e03
	ld [wKeepMatchStatsFlag], a ; $5e05
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
	ld [wMatchPlayerChar], a ; $5e6a
	ld b, a ; $5e6d
	ld c, $00 ; $5e6e
	farcall InitCa00RecordFromCharId ; $5e70
	ld a, $1d ; $5e73
	ld [wMatchOpponentChar], a ; $5e75
	ld b, a ; $5e78
	ld c, $02 ; $5e79
	farcall InitCa00RecordFromCharId ; $5e7b
	ld a, $1f ; $5e7e
	ld b, a ; $5e80
	ld c, $01 ; $5e81
	farcall InitCa00RecordFromCharId ; $5e83
	ld a, $1c ; $5e86
	ld b, a ; $5e88
	ld c, $03 ; $5e89
	farcall InitCa00RecordFromCharId ; $5e8b
	ld a, $00 ; $5e8e
	farcall SetStorySlotFlagB ; $5e90
	ld a, $01 ; $5e93
	farcall SetStorySlotFlagA ; $5e95
	ld a, $fe ; $5e98
	ld [wDebugMatchFlags], a ; $5e9a
	farcall RunMatch ; $5e9d
	ret ; $5ea0
RunTargetZoneTestMode_07:
	farcall InitMinigameMatchSettings ; $5ea1
	ld a, $02 ; $5ea4
	ld [wCurrentlyUsedCourt], a ; $5ea6
	ld a, $02 ; $5ea9
	ld [wOnCourtCharCount], a ; $5eab
	ldh a, [hRomBank] ; $5eae
	ld de, ModeHookTable_07 ; $5eb0
	farcall SetModeHookTable ; $5eb3
	ld de, MinigamePointTable_07_5ff6 ; $5eb6
	farcall SetMinigamePointTable ; $5eb9
	ld a, $01 ; $5ebc
	ld [wTargetZoneEnabled], a ; $5ebe
	ld a, $1a ; $5ec1
	ld [wMatchPlayerChar], a ; $5ec3
	ld a, $1c ; $5ec6
	ld [wMatchOpponentChar], a ; $5ec8
	farcall RunN64ExhibData ; $5ecb
	farcall RunMinigameMatch ; $5ece
	ret ; $5ed1
StubNop_07_5ed2:
	ret ; $5ed2
ResolveTargetModePoint:
	farcall UpdateScorePanelDisplay ; $5ed3
	farcall ResolvePointWinner ; $5ed6
	ld [wPointWinLoseFlag], a ; $5ed9
	farcall UpdatePointStats ; $5edc
	farcall AwardPoint ; $5edf
	ld a, [wPlayer1PointsWon] ; $5ee2
	ld b, $01 ; $5ee5
	farcall LoadPlayer1PointsDigitGfx ; $5ee7
	ld a, [wPlayer2PointsWon] ; $5eea
	ld b, $01 ; $5eed
	farcall LoadPlayer2PointsDigitGfx ; $5eef
	farcall StepMatchFrame ; $5ef2
	farcall StartPointEndReactions ; $5ef5
	farcall ResolvePointOutcome ; $5ef8
	ret ; $5efb
ModeHookTable_07:
	; $5efc, 16 bytes (mode_hooks)
	dw ModeHookNop_07 ; record 0
	dw TargetZonePointStartHook_07 ; record 1
	dw TargetZonePointEndHook_07 ; record 2
	dw RetStub ; record 3
	dw TargetZoneBallHitHook_07 ; record 4
	dw TargetZoneBounceHook_07 ; record 5
	dw StubNop_07_5f24 ; record 6
	dw RetStub ; record 7
ModeHookNop_07:
	ret ; $5f0c
TargetZoneHitStopHook_07:
	test_flag $0c, 4 ; $5f0d
	ret z ; $5f10
	ld a, $01 ; $5f11
	ld [wMatchSimFrozen], a ; $5f13
	ld a, $14 ; $5f16
	farcall StepMatchFrames ; $5f18
	ld a, $00 ; $5f1b
	ld [wMatchSimFrozen], a ; $5f1d
	clear_flag $0c, 4 ; $5f20
	ret ; $5f23
StubNop_07_5f24:
	ret ; $5f24
TargetZoneBounceHook_07:
	farcall IsBallInTargetZone ; $5f25
	jr z, .done ; $5f28
	farcall AdvanceMatchRng ; $5f2a
	ld h, $00 ; $5f2d
	ld l, a ; $5f2f
	add hl, hl ; $5f30
	xor a ; $5f31
	sub l ; $5f32
	ld l, a ; $5f33
	sbc a ; $5f34
	sub h ; $5f35
	ld h, a ; $5f36
	ld e, l ; $5f37
	ld d, h ; $5f38
	farcall SetTargetZoneCorner1 ; $5f39
	farcall AdvanceMatchRng ; $5f3c
	ld h, $00 ; $5f3f
	ld l, a ; $5f41
	add hl, hl ; $5f42
	ld e, l ; $5f43
	ld d, h ; $5f44
	farcall SetTargetZoneCorner2 ; $5f45
.done:
	ret ; $5f48
TargetZoneBallHitHook_07:
	set_flag $0c, 4 ; $5f49
	ret ; $5f4c
TargetZonePointStartHook_07:
	ld hl, $fdc0 ; $5f4d
	ld de, $fd80 ; $5f50
	farcall SetBallGatePoint1 ; $5f53
	ld hl, $0240 ; $5f56
	ld de, $fd80 ; $5f59
	farcall SetBallGatePoint2 ; $5f5c
	ld hl, $ff60 ; $5f5f
	ld de, $fd60 ; $5f62
	farcall SetTargetZoneCorner1 ; $5f65
	ld hl, $0000 ; $5f68
	ld de, rJOYP ; $5f6b
	farcall SetTargetZoneCorner2 ; $5f6e
	call StubNop_07_5ed2 ; $5f71
	ret ; $5f74
TargetZonePointEndHook_07:
	ld hl, $013f ; $5f75
	ld de, $000b ; $5f78
	ld bc, $1305 ; $5f7b
	farcall ShowMessageWindow ; $5f7e
	call ResolveTargetModePoint ; $5f81
	ld a, [wCharacter1ServiceAces] ; $5f84
	ld hl, wCharacter2ServiceAces ; $5f87
	cp [hl] ; $5f8a
	jr nz, .abortMatch ; $5f8b
	ret ; $5f8d
.abortMatch:
	ld a, $ff ; $5f8e
	ld [wMatchAbortFlag], a ; $5f90
	ret ; $5f93
MinigamePointTable_07_5f94:
	; $5f94, 32 bytes (bytes:4)
	db $00, $09, $09, $09 ; 0x00
	db $00, $09, $09, $09 ; 0x04
	db $01, $09, $09, $09 ; 0x08
	db $00, $09, $09, $09 ; 0x0c
	db $03, $09, $09, $09 ; 0x10
	db $00, $09, $09, $09 ; 0x14
	db $02, $09, $09, $09 ; 0x18
	db $00, $09, $09, $09 ; 0x1c
	; $5fb4, 1 bytes (fill)
	ds 1, $ff
MinigamePointTable_07_5fb5:
	; $5fb5, 64 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $00, $01, $09, $09 ; 0x04
	db $03, $00, $09, $09 ; 0x08
	db $01, $00, $09, $09 ; 0x0c
	db $01, $02, $09, $09 ; 0x10
	db $00, $01, $09, $09 ; 0x14
	db $02, $01, $09, $09 ; 0x18
	db $01, $00, $09, $09 ; 0x1c
	db $03, $00, $09, $09 ; 0x20
	db $00, $01, $09, $09 ; 0x24
	db $00, $03, $09, $09 ; 0x28
	db $01, $00, $09, $09 ; 0x2c
	db $02, $01, $09, $09 ; 0x30
	db $00, $01, $09, $09 ; 0x34
	db $01, $02, $09, $09 ; 0x38
	db $01, $00, $09, $09 ; 0x3c
	; $5ff5, 1 bytes (fill)
	ds 1, $ff
MinigamePointTable_07_5ff6:
	; $5ff6, 64 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $00, $01, $09, $09 ; 0x04
	db $01, $02, $09, $09 ; 0x08
	db $01, $00, $09, $09 ; 0x0c
	db $00, $03, $09, $09 ; 0x10
	db $01, $00, $09, $09 ; 0x14
	db $01, $02, $09, $09 ; 0x18
	db $00, $01, $09, $09 ; 0x1c
	db $03, $00, $09, $09 ; 0x20
	db $00, $01, $09, $09 ; 0x24
	db $02, $01, $09, $09 ; 0x28
	db $01, $00, $09, $09 ; 0x2c
	db $03, $00, $09, $09 ; 0x30
	db $01, $00, $09, $09 ; 0x34
	db $02, $01, $09, $09 ; 0x38
	db $00, $01, $09, $09 ; 0x3c
	; $6036, 8138 bytes fill to bank end (linker-padded)
