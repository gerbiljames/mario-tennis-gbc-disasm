TryEstablishLink:
	di ; $4048
	ldh a, [hLinkRxByte] ; $4049
	ei ; $404b
	cp LINKMSG_PROBE ; $404c
	jr z, .probe ; $404e
	ld a, LINKSTATE_MASTER ; $4050
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
	ld a, LINKSTATE_SLAVE ; $4069
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
	ld a, IE_SERIAL | IE_VBLANK ; $407b
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
	ld a, LINKMSG_SYNC_MASTER ; $40d2
	ldh [rSB], a ; $40d4
	push af ; $40d6
	ld a, SC_FAST | SC_INTERNAL ; $40d7
	ldh [rSC], a ; $40d9
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $40db
	ldh [rSC], a ; $40dd
	pop af ; $40df
	ei ; $40e0
	call WaitSerialTransfer ; $40e1
	call ShortDelay ; $40e4
	call ShortDelay ; $40e7
	di ; $40ea
	ldh a, [hLinkRxByte] ; $40eb
	ei ; $40ed
	cp LINKMSG_SYNC_SLAVE ; $40ee
	jr z, .synced ; $40f0
	dec e ; $40f2
	jr nz, .syncLoop ; $40f3
	call LinkErrorReset ; $40f5
.synced:
	xor a ; $40f8
	ldh [hLinkRxNibbleIndex], a ; $40f9
	ldh [hLinkTxNibbleIndex], a ; $40fb
	ld de, $0000 ; $40fd
	ld b, c ; $4100
.nibbleLoop:
	ld hl, wLinkTxNibbles ; $4101
	ldh a, [hLinkTxNibbleIndex] ; $4104
	add_hl_a ; $4106
	ld a, [hl] ; $410b
	ldh [hLinkTxByte], a ; $410c
.sendRetry:
	ldh a, [hLinkTxByte] ; $410e
	or LINKTAG_MASTER ; $4110
	ldh [rSB], a ; $4112
	push af ; $4114
	ld a, SC_FAST | SC_INTERNAL ; $4115
	ldh [rSC], a ; $4117
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $4119
	ldh [rSC], a ; $411b
	pop af ; $411d
	call WaitSerialTransfer ; $411e
	call ShortDelay ; $4121
	call ShortDelay ; $4124
	call PollSerialResponse ; $4127
	jr c, .sendRetry ; $412a
	ld h, a ; $412c
	and LINKTAG_MASK ; $412d
	cp LINKTAG_SLAVE ; $412f
	jr z, .storeRxNibble ; $4131
	call LinkErrorReset ; $4133
.storeRxNibble:
	ld a, h ; $4136
	push af ; $4137
	ld hl, wLinkRxNibbles ; $4138
	ldh a, [hLinkRxNibbleIndex] ; $413b
	add_hl_a ; $413d
	pop af ; $4142
	and LINKTAG_PAYLOAD ; $4143
	ld [hl], a ; $4145
	add_de_a ; $4146
	xor a ; $414b
	ldh [hLinkRetryCount], a ; $414c
	ld hl, hLinkTxNibbleIndex ; $414e
	inc [hl] ; $4151
	ld hl, hLinkRxNibbleIndex ; $4152
	inc [hl] ; $4155
	dec b ; $4156
	jr nz, .nibbleLoop ; $4157
	ld a, LINKMSG_BLOCK_END ; $4159
	ld b, LINKMSG_BLOCK_END_ACK ; $415b
	call SendByteAwaitEchoMaster ; $415d
	jr nc, .sendChecksumCue ; $4160
	call LinkErrorReset ; $4162
.sendChecksumCue:
	ld a, LINKMSG_CHECKSUM ; $4165
	call SendByteGetReplyMaster ; $4167
	cp LINKMSG_CHECKSUM ; $416a
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
	sub_hl_de ; $417c
	ld a, h ; $4182
	or l ; $4183
	pop de ; $4184
	pop hl ; $4185
	jp z, .checksumOk ; $4186
	ld a, LINKMSG_CHECKSUM_BAD ; $4189
	call SendByteGetReplyMaster ; $418b
	cp LINKMSG_BLOCK_OK ; $418e
	jp z, .startBlock ; $4190
	cp LINKMSG_CHECKSUM_BAD ; $4193
	jp z, .startBlock ; $4195
	call LinkErrorReset ; $4198
.checksumOk:
	ld a, LINKMSG_BLOCK_OK ; $419b
	call SendByteGetReplyMaster ; $419d
	cp LINKMSG_BLOCK_OK ; $41a0
	jr z, .done ; $41a2
	cp LINKMSG_CHECKSUM_BAD ; $41a4
	jp z, .startBlock ; $41a6
	call LinkErrorReset ; $41a9
.done:
	pop hl ; $41ac
	pop de ; $41ad
	pop bc ; $41ae
	pop af ; $41af
	ret ; $41b0
Unused_07_DelayByLinkPhase:
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
	ld a, SC_FAST | SC_INTERNAL ; $41d3
	ldh [rSC], a ; $41d5
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $41d7
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
	ld a, LINKMSG_SYNC_SLAVE ; $4200
	ldh [rSB], a ; $4202
	push af ; $4204
	ld a, SC_FAST | SC_EXTERNAL ; $4205
	ldh [rSC], a ; $4207
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $4209
	ldh [rSC], a ; $420b
	pop af ; $420d
	ei ; $420e
	nop ; $420f
	nop ; $4210
	di ; $4211
	ld a, [wLinkTxNibbles] ; $4212
	or LINKTAG_SLAVE ; $4215
	ldh [hLinkTxByte], a ; $4217
	ei ; $4219
	ld e, $64 ; $421a
.syncLoop:
	call WaitSerialTransfer ; $421c
	jr c, .syncFailed ; $421f
	di ; $4221
	ldh a, [hLinkRxByte] ; $4222
	ei ; $4224
	cp LINKMSG_SYNC_MASTER ; $4225
	jr z, .synced ; $4227
	dec e ; $4229
	jr nz, .syncLoop ; $422a
.syncFailed:
	call LinkErrorReset ; $422c
.synced:
	ld a, $01 ; $422f
	ldh [hLinkTxNibbleIndex], a ; $4231
	xor a ; $4233
	ldh [hLinkRxNibbleIndex], a ; $4234
	ld de, $0000 ; $4236
	ld b, c ; $4239
	dec b ; $423a
.nibbleLoop:
	di ; $423b
	ldh a, [rIF] ; $423c
	and ~IF_SERIAL ; $423e
	ldh [rIF], a ; $4240
	xor a ; $4242
	ldh [hLinkTransferDone], a ; $4243
	ld hl, wLinkTxNibbles ; $4245
	ldh a, [hLinkTxNibbleIndex] ; $4248
	add_hl_a ; $424a
	ld a, [hl] ; $424f
	or LINKTAG_SLAVE ; $4250
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
	and LINKTAG_MASK ; $4266
	cp LINKTAG_MASTER ; $4268
	jr z, .storeRxNibble ; $426a
	call LinkErrorReset ; $426c
.storeRxNibble:
	ld hl, wLinkRxNibbles ; $426f
	ldh a, [hLinkRxNibbleIndex] ; $4272
	add_hl_a ; $4274
	ld a, c ; $4279
	and LINKTAG_PAYLOAD ; $427a
	ld [hl], a ; $427c
	add_de_a ; $427d
	xor a ; $4282
	ldh [hLinkRetryCount], a ; $4283
	ld hl, hLinkTxNibbleIndex ; $4285
	inc [hl] ; $4288
	ld hl, hLinkRxNibbleIndex ; $4289
	inc [hl] ; $428c
	dec b ; $428d
	jr nz, .nibbleLoop ; $428e
	di ; $4290
	ldh a, [rIF] ; $4291
	and ~IF_SERIAL ; $4293
	ldh [rIF], a ; $4295
	xor a ; $4297
	ldh [hLinkTransferDone], a ; $4298
	ld a, LINKMSG_BLOCK_END_ACK ; $429a
	ldh [hLinkTxByte], a ; $429c
	ei ; $429e
	call WaitSerialTransfer ; $429f
	di ; $42a2
	ldh a, [hLinkRxByte] ; $42a3
	ei ; $42a5
	ld b, a ; $42a6
	and LINKTAG_MASK ; $42a7
	cp LINKTAG_MASTER ; $42a9
	jr z, .storeLastNibble ; $42ab
	call LinkErrorReset ; $42ad
.storeLastNibble:
	ld hl, wLinkRxNibbles ; $42b0
	ldh a, [hLinkRxNibbleIndex] ; $42b3
	add_hl_a ; $42b5
	ld a, b ; $42ba
	and LINKTAG_PAYLOAD ; $42bb
	ld [hl], a ; $42bd
	add_de_a ; $42be
	ld a, LINKMSG_CHECKSUM ; $42c3
	call SendByteGetReplySlave ; $42c5
	cp LINKMSG_BLOCK_END ; $42c8
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
	sub_hl_de ; $42da
	ld a, h ; $42e0
	or l ; $42e1
	pop de ; $42e2
	pop hl ; $42e3
	jp z, .checksumOk ; $42e4
	di ; $42e7
	ldh a, [rIF] ; $42e8
	and ~IF_SERIAL ; $42ea
	ldh [rIF], a ; $42ec
	xor a ; $42ee
	ldh [hLinkTransferDone], a ; $42ef
	ld a, LINKMSG_CHECKSUM_BAD ; $42f1
	ldh [rSB], a ; $42f3
	push af ; $42f5
	ld a, SC_FAST | SC_EXTERNAL ; $42f6
	ldh [rSC], a ; $42f8
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $42fa
	ldh [rSC], a ; $42fc
	pop af ; $42fe
	ei ; $42ff
	ld a, LINKMSG_CHECKSUM_BAD ; $4300
	call SendByteGetReplySlave ; $4302
	cp LINKMSG_CHECKSUM_BAD ; $4305
	jp z, .startBlock ; $4307
	cp LINKMSG_BLOCK_OK ; $430a
	jp z, .startBlock ; $430c
	call LinkErrorReset ; $430f
.checksumOk:
	ld a, LINKMSG_BLOCK_OK ; $4312
	call SendByteGetReplySlave ; $4314
	cp LINKMSG_CHECKSUM_BAD ; $4317
	jp z, .startBlock ; $4319
	cp LINKMSG_BLOCK_OK ; $431c
	jr z, .done ; $431e
	call LinkErrorReset ; $4320
.done:
	pop hl ; $4323
	pop de ; $4324
	pop bc ; $4325
	pop af ; $4326
	ret ; $4327
