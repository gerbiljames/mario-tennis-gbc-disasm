SECTION "ROM Bank $0b", ROMX[$4000], BANK[$0b]

	farptr RunTrainingDrillByID ; $4000
StartDrillFromDefinition:
	ld hl, $0000 ; $4002
	add hl, bc ; $4005
	ld a, [hl] ; $4006
	ld [wMatchOpponentChar], a ; $4007
	ld hl, $0001 ; $400a
	add hl, bc ; $400d
	ld a, [hl] ; $400e
	ld [wCurrentlyUsedCourt], a ; $400f
	ld hl, $0002 ; $4012
	add hl, bc ; $4015
	ld a, [hl] ; $4016
	ld [wOnCourtCharCount], a ; $4017
	ld hl, $0003 ; $401a
	add hl, bc ; $401d
	ld a, [hl] ; $401e
	ld [wGameMode], a ; $401f
	ld a, $02 ; $4022
	ld [wCurrentMinigameStoryMatch], a ; $4024
	ld hl, $0004 ; $4027
	add hl, bc ; $402a
	ld a, [hl] ; $402b
	ld [wCurrentMinigameStoryMatch + 1], a ; $402c
	ld hl, $0005 ; $402f
	add hl, bc ; $4032
	ld a, [hl] ; $4033
	ld [wMatchBGM], a ; $4034
	push bc ; $4037
	ld hl, $0007 ; $4038
	add hl, bc ; $403b
	ld b, [hl] ; $403c
	ld c, $00 ; $403d
	farcall InitCa00RecordFromCharId ; $403f
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4042
	ld [wMatchPlayerChar], a ; $4045
	ld a, [wMatchOpponentChar] ; $4048
	cp a, $ff ; $404b
	jr z, .restore ; $404d
	ld b, a ; $404f
	ld c, $02 ; $4050
	farcall InitCa00RecordFromCharId ; $4052
.restore:
	pop bc ; $4055
	ld hl, $0008 ; $4056
	add hl, bc ; $4059
	ld a, [hl+] ; $405a
	ld d, [hl] ; $405b
	ld e, a ; $405c
	ldh a, [hRomBank] ; $405d
	farcall SetModeHookTable ; $405f
	ld hl, $000a ; $4062
	add hl, bc ; $4065
	ld a, [hl+] ; $4066
	ld d, [hl] ; $4067
	ld e, a ; $4068
	farcall SetMinigamePointTable ; $4069
	ld hl, $000c ; $406c
	add hl, bc ; $406f
	ld a, [hl+] ; $4070
	ld h, [hl] ; $4071
	ld l, a ; $4072
	ld a, h ; $4073
	or a, l ; $4074
	jr z, .done ; $4075
	call JumpToHL ; $4077
.done:
	ret ; $407a
RecordDrillPointResultBits:
	ld a, [wPointWinLoseFlag] ; $407b
	or a, a ; $407e
	ret z ; $407f
	and a, $03 ; $4080
	ld b, a ; $4082
	rrc a ; $4083
	rrc a ; $4085
	ld c, a ; $4087
	ld a, [wTotalPointsScoredInCurrentGame] ; $4088
	ld b, a ; $408b
	ld hl, $40bc ; $408c
	ld a, [$c7bb] ; $408f
	or a, a ; $4092
	jr nz, .storeBits ; $4093
	ld a, b ; $4095
	and a, $01 ; $4096
	add a, a ; $4098
	add a, l ; $4099
	ld l, a ; $409a
	jr nc, .checkOddPoint ; $409b
	inc h ; $409d
.checkOddPoint:
	srl b ; $409e
	ld a, [wTotalPointsScoredInCurrentGame] ; $40a0
	and a, $01 ; $40a3
	jr z, .storeBits ; $40a5
	ld a, c ; $40a7
	xor a, $80 ; $40a8
	ld c, a ; $40aa
	jr .storeBits ; $40ab
.storeBits:
	ld a, [hl+] ; $40ad
	ld h, [hl] ; $40ae
	ld l, a ; $40af
	inc b ; $40b0
	sla b ; $40b1
	ld a, c ; $40b3
.rotateLoop:
	rlc a ; $40b4
	dec b ; $40b6
	jr nz, .rotateLoop ; $40b7
	or a, [hl] ; $40b9
	ld [hl], a ; $40ba
	ret ; $40bb
	; $40bc, 4 bytes (records:2)
	dw $c2fc ; record 0
	dw $c2fd ; record 1
CountDrillShotSuccesses:
	push bc ; $40c0
	push hl ; $40c1
	ld hl, $c2fc ; $40c2
	add a, l ; $40c5
	ld l, a ; $40c6
	jr nc, .gotSlot ; $40c7
	inc h ; $40c9
.gotSlot:
	ld c, $00 ; $40ca
	ld a, [hl] ; $40cc
	ld b, a ; $40cd
	and a, $03 ; $40ce
	cp a, $01 ; $40d0
	jr nz, .checkShot2 ; $40d2
	inc c ; $40d4
.checkShot2:
	ld a, b ; $40d5
	srl a ; $40d6
	srl a ; $40d8
	and a, $03 ; $40da
	cp a, $01 ; $40dc
	jr nz, .checkShot3 ; $40de
	inc c ; $40e0
.checkShot3:
	ld a, b ; $40e1
	swap a ; $40e2
	and a, $03 ; $40e4
	cp a, $01 ; $40e6
	jr nz, .checkShot4 ; $40e8
	inc c ; $40ea
.checkShot4:
	ld a, b ; $40eb
	swap a ; $40ec
	srl a ; $40ee
	srl a ; $40f0
	and a, $03 ; $40f2
	cp a, $01 ; $40f4
	jr nz, .done ; $40f6
	inc c ; $40f8
.done:
	ld a, c ; $40f9
	pop hl ; $40fa
	pop bc ; $40fb
	ret ; $40fc
CheckTwoPointLead:
	ld a, [wPlayer2PointsWon] ; $40fd
	ld b, a ; $4100
	ld a, [wPlayer1PointsWon] ; $4101
	sub a, b ; $4104
	bit 7, a ; $4105
	jr nz, .player2Ahead ; $4107
	cp a, $02 ; $4109
	jr c, .tied ; $410b
	ld a, $01 ; $410d
	ret ; $410f
.player2Ahead:
	cpl ; $4110
	inc a ; $4111
	cp a, $02 ; $4112
	jr c, .tied ; $4114
	ld a, $02 ; $4116
	ret ; $4118
.tied:
	xor a, a ; $4119
	ret ; $411a
Unused_0b_411b:
	; $411b, 7 bytes (bytes:7)
	db $df, $2a, $08, $fa, $b1, $c4, $c9 ; 0x00
	ld hl, wBallDepth ; $4122
	ld a, [hl+] ; $4125
	ld d, [hl] ; $4126
	ld e, a ; $4127
	ld hl, wBallX ; $4128
	ld a, [hl+] ; $412b
	ld h, [hl] ; $412c
	ld l, a ; $412d
	ret ; $412e
	ld h, a ; $412f
	ld l, $00 ; $4130
	srl h ; $4132
	rr l ; $4134
	ld bc, $d000 ; $4136
	add hl, bc ; $4139
	ld b, h ; $413a
	ld c, l ; $413b
	ld hl, $0004 ; $413c
	add hl, bc ; $413f
	ld a, [hl+] ; $4140
	ld d, [hl] ; $4141
	ld e, a ; $4142
	ld hl, $0001 ; $4143
	add hl, bc ; $4146
	ld a, [hl+] ; $4147
	ld h, [hl] ; $4148
	ld l, a ; $4149
	ret ; $414a
ResetActiveCharState:
	ldh a, [hWramBank] ; $414b
	push af ; $414d
	wram_bank $05 ; $414e
	ld a, $00 ; $4154
	farcall SetCharState ; $4156
	pop af ; $4159
	wram_bank ; $415a
	ret ; $415e
IndexDrillTableByPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $415f
	add a, a ; $4162
	add a, a ; $4163
	add a, a ; $4164
	add a, l ; $4165
	ld l, a ; $4166
	jr nc, .gotPtr ; $4167
	inc h ; $4169
.gotPtr:
	ld b, h ; $416a
	ld c, l ; $416b
	ld hl, $0002 ; $416c
	add hl, bc ; $416f
	ld a, [hl+] ; $4170
	ld d, [hl] ; $4171
	ld e, a ; $4172
	ld hl, $0000 ; $4173
	add hl, bc ; $4176
	ld a, [hl+] ; $4177
	ld h, [hl] ; $4178
	ld l, a ; $4179
	push bc ; $417a
	farcall SetBallGatePoint1 ; $417b
	pop bc ; $417e
	ld hl, $0006 ; $417f
	add hl, bc ; $4182
	ld a, [hl+] ; $4183
	ld d, [hl] ; $4184
	ld e, a ; $4185
	ld hl, $0004 ; $4186
	add hl, bc ; $4189
	ld a, [hl+] ; $418a
	ld h, [hl] ; $418b
	ld l, a ; $418c
	farcall SetBallGatePoint2 ; $418d
	ret ; $4190
SetDrillTargetZoneForPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4191
	add a, a ; $4194
	add a, a ; $4195
	add a, a ; $4196
	add a, l ; $4197
	ld l, a ; $4198
	jr nc, .gotEntry ; $4199
	inc h ; $419b
.gotEntry:
	ld b, h ; $419c
	ld c, l ; $419d
	ld hl, $0002 ; $419e
	add hl, bc ; $41a1
	ld a, [hl+] ; $41a2
	ld d, [hl] ; $41a3
	ld e, a ; $41a4
	ld hl, $0000 ; $41a5
	add hl, bc ; $41a8
	ld a, [hl+] ; $41a9
	ld h, [hl] ; $41aa
	ld l, a ; $41ab
	push bc ; $41ac
	farcall SetTargetZoneCorner1 ; $41ad
	pop bc ; $41b0
	ld hl, $0006 ; $41b1
	add hl, bc ; $41b4
	ld a, [hl+] ; $41b5
	ld d, [hl] ; $41b6
	ld e, a ; $41b7
	ld hl, $0004 ; $41b8
	add hl, bc ; $41bb
	ld a, [hl+] ; $41bc
	ld h, [hl] ; $41bd
	ld l, a ; $41be
	farcall SetTargetZoneCorner2 ; $41bf
	ret ; $41c2
UpdateDrillAbortCountdown:
	ld a, [$c2e1] ; $41c3
	or a, a ; $41c6
	ret z ; $41c7
	ld a, [wPointOutcome] ; $41c8
	or a, a ; $41cb
	ret nz ; $41cc
	ld hl, $c2e0 ; $41cd
	dec [hl] ; $41d0
	ld a, [hl] ; $41d1
	or a, a ; $41d2
	ret nz ; $41d3
	ld a, $01 ; $41d4
	ld [wMatchAbortFlag], a ; $41d6
	ret ; $41d9
RecordDrillTargetZoneHitIfInPlay:
	ld a, [wPointOutcome] ; $41da
	cp a, $04 ; $41dd
	ret z ; $41df
	cp a, $01 ; $41e0
	ret z ; $41e2
	cp a, $03 ; $41e3
	ret z ; $41e5
RecordDrillTargetZoneHit:
	ld a, [wBallBounceCount] ; $41e6
	cp a, $02 ; $41e9
	ret nc ; $41eb
	farcall IsBallInTargetZone ; $41ec
	jr z, .setBit ; $41ef
	xor a, a ; $41f1
	ld [wTargetZoneEnabled], a ; $41f2
	ret ; $41f5
.setBit:
	ld a, [wTotalPointsScoredInCurrentGame] ; $41f6
	ld b, a ; $41f9
	inc b ; $41fa
	xor a, a ; $41fb
	scf ; $41fc
.shiftLoop:
	rla ; $41fd
	dec b ; $41fe
	jr nz, .shiftLoop ; $41ff
	ld hl, $c2e4 ; $4201
	or a, [hl] ; $4204
	ld [hl], a ; $4205
	ret ; $4206
Table_0b_4207:
	; $4207, 4 bytes (bytes:4)
	db $03, $02, $00, $01 ; 0x00
CountDrillResultBitsSet:
	push bc ; $420b
	ld a, [$c2e4] ; $420c
	ld b, a ; $420f
	xor a, a ; $4210
	ld c, $08 ; $4211
.shiftLoop:
	rr b ; $4213
	adc a, $00 ; $4215
	dec c ; $4217
	jr nz, .shiftLoop ; $4218
	pop bc ; $421a
	ret ; $421b
CheckDrillTargetZoneMissed:
	push bc ; $421c
	ld a, [wTotalPointsScoredInCurrentGame] ; $421d
	ld c, a ; $4220
	inc c ; $4221
	ld a, [$c2e4] ; $4222
	ld b, a ; $4225
.shiftLoop:
	ld a, $00 ; $4226
	rr b ; $4228
	adc a, $00 ; $422a
	dec c ; $422c
	jr nz, .shiftLoop ; $422d
	xor a, $01 ; $422f
	pop bc ; $4231
	ret ; $4232
RecordGateCrossOnServe:
	ld a, [wRallyLength] ; $4233
	cp a, $01 ; $4236
	ret nz ; $4238
	ld a, [$c78b] ; $4239
	or a, a ; $423c
	ret z ; $423d
	farcall DidBallCrossGate ; $423e
	ret z ; $4241
	xor a, a ; $4242
	ld [$c78b], a ; $4243
	ld a, [wTotalPointsScoredInCurrentGame] ; $4246
	ld b, a ; $4249
	inc b ; $424a
	xor a, a ; $424b
	scf ; $424c
.loop:
	rla ; $424d
	dec b ; $424e
	jr nz, .loop ; $424f
	ld hl, $c2e5 ; $4251
	or a, [hl] ; $4254
	ld [hl], a ; $4255
	ret ; $4256
CountDrillResultBitsSetAlt:
	push bc ; $4257
	ld a, [$c2e5] ; $4258
	ld b, a ; $425b
	xor a, a ; $425c
	ld c, $08 ; $425d
.loop:
	rr b ; $425f
	adc a, $00 ; $4261
	dec c ; $4263
	jr nz, .loop ; $4264
	pop bc ; $4266
	ret ; $4267
CountDrillResultBitsThisGame:
	push bc ; $4268
	ld a, [wTotalPointsScoredInCurrentGame] ; $4269
	ld c, a ; $426c
	inc c ; $426d
	ld a, [$c2e5] ; $426e
	ld b, a ; $4271
.loop:
	ld a, $00 ; $4272
	rr b ; $4274
	adc a, $00 ; $4276
	dec c ; $4278
	jr nz, .loop ; $4279
	or a, a ; $427b
	pop bc ; $427c
	ret ; $427d
MatchDrillPointTable:
	; $427e, 64 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $00, $01, $09, $09 ; 0x04
	db $00, $03, $09, $09 ; 0x08
	db $01, $00, $09, $09 ; 0x0c
	db $01, $02, $09, $09 ; 0x10
	db $00, $01, $09, $09 ; 0x14
	db $01, $02, $09, $09 ; 0x18
	db $01, $00, $09, $09 ; 0x1c
	db $03, $00, $09, $09 ; 0x20
	db $00, $01, $09, $09 ; 0x24
	db $03, $00, $09, $09 ; 0x28
	db $01, $00, $09, $09 ; 0x2c
	db $02, $01, $09, $09 ; 0x30
	db $00, $01, $09, $09 ; 0x34
	db $02, $01, $09, $09 ; 0x38
	db $01, $00, $09, $09 ; 0x3c
	; $42be, 1 bytes (fill)
	ds 1, $ff
StrokeMatchPointTable:
	; $42bf, 64 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $01, $00, $09, $09 ; 0x04
	db $00, $03, $09, $09 ; 0x08
	db $00, $01, $09, $09 ; 0x0c
	db $01, $02, $09, $09 ; 0x10
	db $01, $00, $09, $09 ; 0x14
	db $01, $02, $09, $09 ; 0x18
	db $00, $01, $09, $09 ; 0x1c
	db $03, $00, $09, $09 ; 0x20
	db $01, $00, $09, $09 ; 0x24
	db $03, $00, $09, $09 ; 0x28
	db $00, $01, $09, $09 ; 0x2c
	db $02, $01, $09, $09 ; 0x30
	db $01, $00, $09, $09 ; 0x34
	db $02, $01, $09, $09 ; 0x38
	db $00, $01, $09, $09 ; 0x3c
	; $42ff, 1 bytes (fill)
	ds 1, $ff
PracticeDrillPointTable:
	; $4300, 32 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $00, $01, $09, $09 ; 0x04
	db $01, $02, $09, $09 ; 0x08
	db $00, $01, $09, $09 ; 0x0c
	db $03, $00, $09, $09 ; 0x10
	db $00, $01, $09, $09 ; 0x14
	db $02, $01, $09, $09 ; 0x18
	db $00, $01, $09, $09 ; 0x1c
	; $4320, 1 bytes (fill)
	ds 1, $ff
StrokePracticePointTable:
	; $4321, 32 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $01, $00, $09, $09 ; 0x04
	db $01, $02, $09, $09 ; 0x08
	db $01, $00, $09, $09 ; 0x0c
	db $03, $00, $09, $09 ; 0x10
	db $01, $00, $09, $09 ; 0x14
	db $02, $01, $09, $09 ; 0x18
	db $01, $00, $09, $09 ; 0x1c
	; $4341, 1 bytes (fill)
	ds 1, $ff
TargetPositions_0b_4342:
	; $4342, 64 bytes (records:4)
; 16 records x 4 bytes
	dw $fe40, $fd40 ; record 0
	dw $0000, $0000 ; record 1
	dw $0000, $0000 ; record 2
	dw $01c0, $02c0 ; record 3
	dw $0000, $fd40 ; record 4
	dw $01c0, $0000 ; record 5
	dw $fe40, $0000 ; record 6
	dw $0000, $02c0 ; record 7
	dw $0000, $0000 ; record 8
	dw $01c0, $02c0 ; record 9
	dw $fe40, $fd40 ; record 10
	dw $0000, $0000 ; record 11
	dw $fe40, $0000 ; record 12
	dw $0000, $02c0 ; record 13
	dw $0000, $fd40 ; record 14
	dw $01c0, $0000 ; record 15
	; $4382, 2 bytes (fill)
	ds 2, $ff
TargetPositions_0b_4384:
	; $4384, 32 bytes (records:4)
; 8 records x 4 bytes
	dw $fe40, $fd40 ; record 0
	dw $0000, $0000 ; record 1
	dw $0000, $fd40 ; record 2
	dw $01c0, $0000 ; record 3
	dw $0000, $0000 ; record 4
	dw $01c0, $02c0 ; record 5
	dw $fe40, $0000 ; record 6
	dw $0000, $02c0 ; record 7
	; $43a4, 2 bytes (fill)
	ds 2, $ff
PlayDrillPointEndSequence:
	ld hl, wMatchCameraY ; $43a6
	ld a, [hl+] ; $43a9
	ld d, [hl] ; $43aa
	ld e, a ; $43ab
	ld hl, wMatchCameraX ; $43ac
	ld a, [hl+] ; $43af
	ld h, [hl] ; $43b0
	ld l, a ; $43b1
	farcall SetCameraTarget ; $43b2
	ld a, [wPointOutcome] ; $43b5
	cp a, $06 ; $43b8
	jr z, .showScore ; $43ba
	cp a, $07 ; $43bc
	jr z, .showScore ; $43be
	cp a, $01 ; $43c0
	jr z, .showBanner ; $43c2
	cp a, $03 ; $43c4
	jr z, .showBanner ; $43c6
	jr .waitBanner ; $43c8
.showBanner:
	add a, $00 ; $43ca
	farcall ShowCourtBanner ; $43cc
.waitBanner:
	ld a, $1e ; $43cf
	farcall StepMatchFrames ; $43d1
	farcall HideCourtBanner ; $43d4
	ld a, $0f ; $43d7
	farcall StepMatchFrames ; $43d9
.showScore:
	farcall SpawnGameScoreDisplayObjs ; $43dc
	ld a, $0a ; $43df
	farcall StepMatchFrames ; $43e1
	ld a, $0a ; $43e4
	farcall StepMatchFramesSkippable ; $43e6
	farcall UpdateScorePanelDisplay ; $43e9
	ld a, $0a ; $43ec
	farcall StepMatchFrames ; $43ee
	ld a, $1e ; $43f1
	farcall StepMatchFramesSkippable ; $43f3
	farcall DismissGameScoreDisplayObjs ; $43f6
	ld a, $46 ; $43f9
	farcall StepMatchFramesSkippable ; $43fb
	ld a, $08 ; $43fe
	farcall StepMatchFrames ; $4400
	ret ; $4403
LoadDrillOpponentChar:
	ld b, a ; $4404
	ld c, $02 ; $4405
	farcall InitCa00RecordFromCharId ; $4407
	ldh a, [hWramBank] ; $440a
	push af ; $440c
	wram_bank $05 ; $440d
	farcall LoadCharacterAttributes ; $4413
	pop af ; $4416
	wram_bank ; $4417
	ret ; $441b
LoadDrillOpponentBySide:
	ld a, [wCurrentServingPlayer] ; $441c
	and a, $01 ; $441f
	add a, l ; $4421
	ld l, a ; $4422
	jr nc, .load ; $4423
	inc h ; $4425
.load:
	ld a, [hl] ; $4426
	call LoadDrillOpponentChar ; $4427
	ret ; $442a
WriteCharStructByte:
	ld b, a ; $442b
	ldh a, [hWramBank] ; $442c
	push af ; $442e
	wram_bank $05 ; $442f
	ld de, wCharPosX ; $4435
	add hl, de ; $4438
	ld [hl], b ; $4439
	pop af ; $443a
	wram_bank ; $443b
	ret ; $443f
	ld hl, $007a ; $4440
	call WriteCharStructByte ; $4443
	ret ; $4446
TestCharStateBit4:
	ld b, a ; $4447
	ldh a, [hWramBank] ; $4448
	push af ; $444a
	ld a, $04 ; $444b
	add a, b ; $444d
	ld a, a ; $444e
	wram_bank ; $444f
	ld de, $df00 ; $4453
	ld hl, $0050 ; $4456
	add hl, de ; $4459
	ld a, [hl] ; $445a
	bit 4, a ; $445b
	jr z, .clear ; $445d
	pop af ; $445f
	wram_bank ; $4460
	ld a, $01 ; $4464
	ret ; $4466
.clear:
	pop af ; $4467
	wram_bank ; $4468
	xor a, a ; $446c
	ret ; $446d
SyncPointWinLoseFlagTask:
	ldh a, [hWramBank] ; $446e
	push af ; $4470
	wram_bank $05 ; $4471
	ld hl, wCharPointResult ; $4477
	ld a, [wPointWinLoseFlag] ; $447a
	ld [hl], a ; $447d
	pop af ; $447e
	wram_bank ; $447f
	ret ; $4483
	ld a, [wPointOutcome] ; $4484
	cp a, $01 ; $4487
	jr z, .step4 ; $4489
	cp a, $03 ; $448b
	jr z, .step4 ; $448d
	cp a, $09 ; $448f
	ld a, $01 ; $4491
	jr z, .checkCurrentServingPlayer ; $4493
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4495
	cp a, $01 ; $4498
	jr nz, .checkRallyLength ; $449a
	ld hl, $c2f8 ; $449c
	ld a, [wCurrentServingPlayer] ; $449f
	add a, l ; $44a2
	ld l, a ; $44a3
	jr nc, .read ; $44a4
	inc h ; $44a6
.read:
	ld a, [hl] ; $44a7
	or a, a ; $44a8
	jr nz, .checkRallyLength ; $44a9
	ld a, $03 ; $44ab
	jr .checkCurrentServingPlayer ; $44ad
.checkRallyLength:
	ld a, [wRallyLength] ; $44af
	cp a, $01 ; $44b2
	jr nz, .checkPointOutcome ; $44b4
	ld a, [wServiceAceFlag] ; $44b6
	or a, a ; $44b9
	jr z, .zero ; $44ba
	ld a, $01 ; $44bc
	jr .checkCurrentServingPlayer ; $44be
.zero:
	ld a, $02 ; $44c0
	jr .checkCurrentServingPlayer ; $44c2
.checkPointOutcome:
	ld a, [wPointOutcome] ; $44c4
	or a, a ; $44c7
	jr nz, .compare ; $44c8
	ld a, $04 ; $44ca
	jr .checkCurrentServingPlayer ; $44cc
.compare:
	cp a, $07 ; $44ce
	ld a, $06 ; $44d0
	jr z, .checkCurrentServingPlayer ; $44d2
	cp a, $09 ; $44d4
	ld a, $01 ; $44d6
	jr z, .checkCurrentServingPlayer ; $44d8
	ld a, $05 ; $44da
	jr .checkCurrentServingPlayer ; $44dc
.checkCurrentServingPlayer:
	ld b, a ; $44de
	ld a, [wCurrentServingPlayer] ; $44df
	or a, a ; $44e2
	jr z, .zero2 ; $44e3
	ld a, $06 ; $44e5
.zero2:
	add a, b ; $44e7
	ld [$c2e6], a ; $44e8
	ret ; $44eb
.step4:
	ld a, $ff ; $44ec
	ld [$c2e6], a ; $44ee
	ret ; $44f1
QueueDrillOutcomeMessage:
	ld a, [wPointOutcome] ; $44f2
	cp a, $01 ; $44f5
	jr z, .step3 ; $44f7
	cp a, $03 ; $44f9
	jr z, .step3 ; $44fb
	call CheckDrillTargetZoneMissed ; $44fd
	or a, a ; $4500
	jr nz, .checkRallyLength ; $4501
	ld a, $10 ; $4503
	jr .store ; $4505
.checkRallyLength:
	ld a, [wRallyLength] ; $4507
	cp a, $01 ; $450a
	jr nz, .checkPointOutcome ; $450c
	ld a, [wServiceAceFlag] ; $450e
	or a, a ; $4511
	jr z, .zero ; $4512
	ld a, $0d ; $4514
	jr .store ; $4516
.zero:
	ld a, $0e ; $4518
	jr .store ; $451a
.checkPointOutcome:
	ld a, [wPointOutcome] ; $451c
	or a, a ; $451f
	jr nz, .nonZero ; $4520
	ld a, $10 ; $4522
	jr .store ; $4524
.nonZero:
	ld a, $10 ; $4526
	jr .store ; $4528
.store:
	ld [$c2e6], a ; $452a
	ret ; $452d
.step3:
	ld a, $ff ; $452e
	ld [$c2e6], a ; $4530
	ret ; $4533
QueueDrillResultMessage:
	cp a, $ff ; $4534
	jr z, .store ; $4536
	ld c, a ; $4538
	ld a, [wCurrentServingPlayer] ; $4539
	or a, a ; $453c
	jr z, .addOffset ; $453d
	ld a, b ; $453f
.addOffset:
	add a, c ; $4540
.store:
	ld [$c2e6], a ; $4541
	ret ; $4544
SetDrillMessageByServer:
	cp a, $ff ; $4545
	jr z, .store ; $4547
	ld c, a ; $4549
	ld a, [wCurrentServingPlayer] ; $454a
	xor a, $01 ; $454d
	or a, a ; $454f
	jr z, .addOffset ; $4550
	ld a, b ; $4552
.addOffset:
	add a, c ; $4553
.store:
	ld [$c2e6], a ; $4554
	ret ; $4557
SetDrillMessageByRallyParity:
	cp a, $ff ; $4558
	jr z, .store ; $455a
	ld c, a ; $455c
	ld a, [wTotalPointsScoredInCurrentGame] ; $455d
	xor a, $01 ; $4560
	ld d, a ; $4562
	ld a, [wRallyLength] ; $4563
	xor a, $01 ; $4566
	add a, d ; $4568
	and a, $01 ; $4569
	or a, a ; $456b
	jr z, .addOffset ; $456c
	ld a, b ; $456e
.addOffset:
	add a, c ; $456f
.store:
	ld [$c2e6], a ; $4570
	ret ; $4573
ShowQueuedDrillMessage:
	ld a, [$c2e6] ; $4574
	or a, a ; $4577
	jr nz, .show ; $4578
	ld a, $6c ; $457a
	ld [$c2e6], a ; $457c
.show:
	call ShowDrillMessageByIndex ; $457f
	ret ; $4582
ShowDrillMessageByIndex:
	cp a, $ff ; $4583
	ret z ; $4585
	ld h, $00 ; $4586
	ld l, a ; $4588
	add hl, hl ; $4589
	ld de, DrillMessageTextIds_0b ; $458a
	add hl, de ; $458d
	ld a, [hl+] ; $458e
	ld b, [hl] ; $458f
	ld c, a ; $4590
	ld h, b ; $4591
	ld l, c ; $4592
	xor a, a ; $4593
	farcall AddTextIdOffset ; $4594
	ld b, h ; $4597
	ld c, l ; $4598
	farcall MeasureDialogueWidthTiles ; $4599
	ld h, b ; $459c
	ld l, c ; $459d
	add a, $02 ; $459e
	ld b, a ; $45a0
	ldh a, [hWramBank] ; $45a1
	push af ; $45a3
	wram_bank $05 ; $45a4
	ld a, [$d86f] ; $45aa
	ld e, a ; $45ad
	pop af ; $45ae
	wram_bank ; $45af
	ld a, e ; $45b3
	add a, a ; $45b4
	inc a ; $45b5
	ld c, a ; $45b6
	ld d, b ; $45b7
	ld a, $14 ; $45b8
	sub a, d ; $45ba
	srl a ; $45bb
	ld d, a ; $45bd
	ld e, $06 ; $45be
	farcall ShowMessageWindow ; $45c0
	ret ; $45c3
DrillMessageTextIds_0b:
	; $45c4, 218 bytes (records:2)
	dw $28c4 ; record 0
	dw $28c4 ; record 1
	dw $28c5 ; record 2
	dw $28c6 ; record 3
	dw $28c7 ; record 4
	dw $28c8 ; record 5
	dw $28c9 ; record 6
	dw $28ca ; record 7
	dw $28cb ; record 8
	dw $28cc ; record 9
	dw $28cd ; record 10
	dw $28ce ; record 11
	dw $28cf ; record 12
	dw $28d0 ; record 13
	dw $28d1 ; record 14
	dw $28d2 ; record 15
	dw $28d3 ; record 16
	dw $28d4 ; record 17
	dw $28d5 ; record 18
	dw $28d6 ; record 19
	dw $28d7 ; record 20
	dw $28d8 ; record 21
	dw $28d9 ; record 22
	dw $28da ; record 23
	dw $28db ; record 24
	dw $28dc ; record 25
	dw $28dd ; record 26
	dw $28de ; record 27
	dw $28df ; record 28
	dw $28e0 ; record 29
	dw $28e1 ; record 30
	dw $28e2 ; record 31
	dw $28e3 ; record 32
	dw $28e4 ; record 33
	dw $28e5 ; record 34
	dw $28e6 ; record 35
	dw $28e7 ; record 36
	dw $28e8 ; record 37
	dw $28e9 ; record 38
	dw $28ea ; record 39
	dw $28eb ; record 40
	dw $28ec ; record 41
	dw $28ed ; record 42
	dw $28ee ; record 43
	dw $28ef ; record 44
	dw $28f0 ; record 45
	dw $28f1 ; record 46
	dw $28f2 ; record 47
	dw $28f3 ; record 48
	dw $28f4 ; record 49
	dw $28f5 ; record 50
	dw $28f6 ; record 51
	dw $28f7 ; record 52
	dw $28f8 ; record 53
	dw $28f9 ; record 54
	dw $28fa ; record 55
	dw $28fb ; record 56
	dw $28fc ; record 57
	dw $28fd ; record 58
	dw $28fe ; record 59
	dw $28ff ; record 60
	dw $2900 ; record 61
	dw $2901 ; record 62
	dw $2902 ; record 63
	dw $2903 ; record 64
	dw $2904 ; record 65
	dw $2905 ; record 66
	dw $2906 ; record 67
	dw $2907 ; record 68
	dw $2908 ; record 69
	dw $2909 ; record 70
	dw $290a ; record 71
	dw $290b ; record 72
	dw $290c ; record 73
	dw $290d ; record 74
	dw $290e ; record 75
	dw $290f ; record 76
	dw $2910 ; record 77
	dw $2911 ; record 78
	dw $2912 ; record 79
	dw $2913 ; record 80
	dw $2914 ; record 81
	dw $2915 ; record 82
	dw $2916 ; record 83
	dw $2917 ; record 84
	dw $2918 ; record 85
	dw $2919 ; record 86
	dw $2c0f ; record 87
	dw $2c10 ; record 88
	dw $2c11 ; record 89
	dw $2c12 ; record 90
	dw $2c13 ; record 91
	dw $2c14 ; record 92
	dw $2c15 ; record 93
	dw $2c16 ; record 94
	dw $2c17 ; record 95
	dw $2c18 ; record 96
	dw $2c19 ; record 97
	dw $2c1a ; record 98
	dw $2c1b ; record 99
	dw $2c1c ; record 100
	dw $2c1d ; record 101
	dw $2c1e ; record 102
	dw $2c1f ; record 103
	dw $2c20 ; record 104
	dw $2c21 ; record 105
	dw $2c22 ; record 106
	dw $2c23 ; record 107
	dw $2c24 ; record 108
Unused_0b_469e:
	; $469e, 2 bytes (bytes:2)
	db $00, $02 ; 0x00
QueueDrillMarker1_0b:
	ld a, [$c78b] ; $46a0
	and a, a ; $46a3
	ret z ; $46a4
	ld bc, $0000 ; $46a5
	ld hl, $c79a ; $46a8
	ld a, [hl+] ; $46ab
	ld d, [hl] ; $46ac
	ld e, a ; $46ad
	ld hl, $c798 ; $46ae
	ld a, [hl+] ; $46b1
	ld h, [hl] ; $46b2
	ld l, a ; $46b3
	farcall ProjectWorldToScreen_08 ; $46b4
	farcall ApplyCameraProjection ; $46b7
	ld hl, DrillSpriteTemplate_0b ; $46ba
	ld bc, $0930 ; $46bd
	call QueueSpriteTemplate ; $46c0
	ret ; $46c3
QueueDrillMarker2_0b:
	ld a, [$c78b] ; $46c4
	and a, a ; $46c7
	ret z ; $46c8
	ld bc, $0000 ; $46c9
	ld hl, $c79e ; $46cc
	ld a, [hl+] ; $46cf
	ld d, [hl] ; $46d0
	ld e, a ; $46d1
	ld hl, $c79c ; $46d2
	ld a, [hl+] ; $46d5
QueueDrillSprite_0b:
	ld h, [hl] ; $46d6
	ld l, a ; $46d7
	farcall ProjectWorldToScreen_08 ; $46d8
	farcall ApplyCameraProjection ; $46db
	ld hl, DrillSpriteTemplate_0b ; $46de
	ld bc, $0930 ; $46e1
	call QueueSpriteTemplate ; $46e4
	ret ; $46e7
DrillSpriteTemplate_0b:
	; $46e8, 9 bytes (sprite_template)
	oam_sprite $f1, $04, $00, $00
	oam_sprite $01, $04, $02, $00
	oam_sprite_end
SignedTable_0b_46f1:
	; $46f1, 10 bytes (bytes:10)
	db $00, $00, $ff, $00, $ff, $ff, $01, $ff, $ff, $01 ; 0x00
SignedTable_0b_46fb:
	; $46fb, 10 bytes (bytes:10)
	db $00, $00, $01, $00, $01, $01, $ff, $01, $01, $ff ; 0x00
RunTrainingDrillByID:
	push af ; $4705
	farcall InitMinigameMatchSettings ; $4706
	pop af ; $4709
	cp a, $24 ; $470a
	jp z, .doublesDrill ; $470c
	cp a, $12 ; $470f
	jr nc, .minigame ; $4711
	ld l, a ; $4713
	ld h, $00 ; $4714
	add hl, hl ; $4716
	ld de, DrillDefinitionPtrs ; $4717
	add hl, de ; $471a
	ld a, [hl+] ; $471b
	ld b, [hl] ; $471c
	ld c, a ; $471d
	call StartDrillFromDefinition ; $471e
	jr .runMatch ; $4721
.minigame:
	farcall StartMinigameByID ; $4723
.runMatch:
	ld hl, $c2e0 ; $4726
	ld c, $02 ; $4729
	call ClearMemory16 ; $472b
	ld a, $ff ; $472e
	ld [$c7b5], a ; $4730
	xor a, a ; $4733
	ld hl, $c7b6 ; $4734
	ld [hl+], a ; $4737
	ld [hl], a ; $4738
	ld [$c7a8], a ; $4739
	farcall RunMinigameMatch ; $473c
.afterMatch:
	xor a, a ; $473f
	ldh [hScrollX], a ; $4740
	ldh [hScrollY], a ; $4742
	ld a, $ff ; $4744
	ld [$c7b5], a ; $4746
	xor a, a ; $4749
	ld hl, $c7b6 ; $474a
	ld [hl+], a ; $474d
	ld [hl], a ; $474e
	ld [$c7a8], a ; $474f
	ld a, [wMatchRetryRequest] ; $4752
	or a, a ; $4755
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4756
	jp nz, RunTrainingDrillByID ; $4759
	ld a, [wMatchExitRequest] ; $475c
	or a, a ; $475f
	jr z, .checkMenuFlag ; $4760
	ld a, $ff ; $4762
	ld [wPointWinLoseFlag], a ; $4764
.checkMenuFlag:
	test_flag FLAG_DRILL_FROM_MENU ; $4767
	jr z, .finish ; $476a
	call DisableLCDSafely ; $476c
	farcall ResetTextWindowState ; $476f
	call ClearBGForDrillResult ; $4772
	farcall LoadMenuFontGfx ; $4775
	call EnableLCD ; $4778
	script_fade_in $08 ; $477b
	call WaitFadeEnd ; $4780
	ld a, [$c2e3] ; $4783
	ld l, a ; $4786
	ld h, $00 ; $4787
	farcall PushTextArgNumber ; $4789
	ld a, [wPointWinLoseFlag] ; $478c
	inc a ; $478f
	srl a ; $4790
	ld hl, $015f ; $4792
	add a, l ; $4795
	ld l, a ; $4796
	jr nc, .showSpeakerDialogue ; $4797
	inc h ; $4799
.showSpeakerDialogue:
	ld a, $80 ; $479a
	farcall ShowSpeakerDialogue ; $479c
	ld c, $10 ; $479f
	call BeginFadeOut ; $47a1
	call WaitFadeEnd ; $47a4
.finish:
	clear_flag FLAG_DRILL_FROM_MENU ; $47a7
	farcall ProcessMatchRewards ; $47aa
	ret ; $47ad
.doublesDrill:
	call RunDoublesDrillMatch ; $47ae
	jp .afterMatch ; $47b1
DrillDefinitionPtrs:
	; $47b4, 36 bytes (records:2)
	dw ServiceMatch1Drill ; record 0
	dw ServiceMatch2Drill ; record 1
	dw ServiceMatch3Drill ; record 2
	dw ServicePractice1Drill ; record 3
	dw ServicePractice2Drill ; record 4
	dw ServicePractice3Drill ; record 5
	dw NetGameMatch1Drill ; record 6
	dw NetGameMatch2Drill ; record 7
	dw NetGameMatch3Drill ; record 8
	dw NetGamePractice1Drill ; record 9
	dw NetGamePractice2Drill ; record 10
	dw NetGamePractice3Drill ; record 11
	dw StrokeMatch1Drill ; record 12
	dw StrokeMatch2Drill ; record 13
	dw StrokeMatch3Drill ; record 14
	dw StrokePractice1Drill ; record 15
	dw StrokePractice2Drill ; record 16
	dw StrokePractice3Drill ; record 17
ClearBGForDrillResult:
	call DisableLCDSafely ; $47d8
	wram_bank $02 ; $47db
	ld a, $00 ; $47e1
	ld hl, $d000 ; $47e3
	ld bc, $0500 ; $47e6
	call FillMemoryBC_0b ; $47e9
	wram_bank $03 ; $47ec
	ld a, $20 ; $47f2
	ld hl, $d000 ; $47f4
	ld bc, $0500 ; $47f7
	call FillMemoryBC_0b ; $47fa
	wram_bank $03 ; $47fd
	ld hl, $d000 ; $4803
	ld de, $9800 ; $4806
	ld c, $24 ; $4809
	call QueueVRAMCopy ; $480b
	wram_bank $02 ; $480e
	ld hl, $d000 ; $4814
	ld de, $b800 ; $4817
	ld c, $24 ; $481a
	call QueueVRAMCopy ; $481c
	call EnableLCD ; $481f
	ret ; $4822
FillMemoryBC_0b:
	ld e, a ; $4823
.loop:
	ld [hl], e ; $4824
	inc hl ; $4825
	dec bc ; $4826
	ld a, c ; $4827
	or a, b ; $4828
	jr nz, .loop ; $4829
	ret ; $482b
ServiceMatch1Drill:
	; $482c, 16 bytes (drill_definition)
	db $37, $18, $02, $05, $00, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServiceMatch1Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
ServiceMatch1Hooks:
	; $483c, 16 bytes (mode_hooks)
	dw ServiceMatch1Hook_PerFrame ; record 0
	dw ServiceMatch1Hook_PointStart ; record 1
	dw ServiceMatch1Hook_PointEnd ; record 2
	dw ServiceMatch1Hook_MinigameStart ; record 3
	dw ServiceMatch1Hook_BallHit ; record 4
	dw ServiceMatch1Hook_Bounce ; record 5
	dw ServiceMatch1Hook_RallyTick ; record 6
	dw RetStub ; record 7
ServiceMatch1Hook_MinigameStart:
	ret ; $484c
ServiceMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $484d
	ret ; $4850
ServiceMatch1Hook_PointStart:
	xor a, a ; $4851
	ld [$c2e1], a ; $4852
	ld a, $0a ; $4855
	ld [$c2e0], a ; $4857
	xor a, a ; $485a
	ld [$c2e6], a ; $485b
	xor a, a ; $485e
	ld [$c2ff], a ; $485f
	ret ; $4862
ServiceMatch1Hook_PointEnd:
	call ServiceMatch1JudgeShot0 ; $4863
	call ServiceMatch1HandlePointEnd ; $4866
	ld a, [wTotalPointsScoredInCurrentGame] ; $4869
	bit 0, a ; $486c
	ret nz ; $486e
	cp a, $08 ; $486f
	jr z, .eq08 ; $4871
	ld hl, $c2e8 ; $4873
	ld a, [hl+] ; $4876
	ld b, [hl] ; $4877
	cp a, b ; $4878
	ret z ; $4879
	ld a, $80 ; $487a
	ld [wMatchAbortFlag], a ; $487c
	ret ; $487f
.eq08:
	ld hl, $c2e9 ; $4880
	ld a, [hl-] ; $4883
	sub a, [hl] ; $4884
	jr z, .clearPointWinLoseFlag ; $4885
	jr nc, .storePointWinLoseFlag ; $4887
	ld a, $01 ; $4889
	ld [wPointWinLoseFlag], a ; $488b
	ret ; $488e
.clearPointWinLoseFlag:
	xor a, a ; $488f
	ld [wPointWinLoseFlag], a ; $4890
	ret ; $4893
.storePointWinLoseFlag:
	ld a, $ff ; $4894
	ld [wPointWinLoseFlag], a ; $4896
	ret ; $4899
ServiceMatch1Hook_RallyTick:
	call ServiceMatch1JudgeShot3 ; $489a
	ret ; $489d
ServiceMatch1Hook_Bounce:
	call ServiceMatch1JudgeShot2 ; $489e
	ret ; $48a1
ServiceMatch1Hook_BallHit:
	call ServiceMatch1JudgeShot1 ; $48a2
	ret ; $48a5
ServiceMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $48a6
	ld a, [$c2ff] ; $48a9
	ld b, a ; $48ac
	ld a, [wTotalPointsScoredInCurrentGame] ; $48ad
	bit 0, a ; $48b0
	ld a, b ; $48b2
	jr z, .store ; $48b3
	cpl ; $48b5
	inc a ; $48b6
.store:
	ld [wPointWinLoseFlag], a ; $48b7
	call RecordDrillPointResultBits ; $48ba
	ld a, $00 ; $48bd
	call CountDrillShotSuccesses ; $48bf
	ld [$c2e8], a ; $48c2
	ld a, $01 ; $48c5
	call CountDrillShotSuccesses ; $48c7
	ld [$c2e9], a ; $48ca
	call ShowQueuedDrillMessage ; $48cd
	farcall UpdatePointStats ; $48d0
	farcall AwardPoint ; $48d3
	ld a, [$c2e8] ; $48d6
	ld [wPlayer1PointsWon], a ; $48d9
	ld a, [$c2e9] ; $48dc
	ld [wPlayer2PointsWon], a ; $48df
	ld a, [wPlayer1PointsWon] ; $48e2
	ld b, $01 ; $48e5
	farcall LoadPlayer1PointsDigitGfx ; $48e7
	ld a, [wPlayer2PointsWon] ; $48ea
	ld b, $01 ; $48ed
	farcall LoadPlayer2PointsDigitGfx ; $48ef
	farcall StepMatchFrame ; $48f2
	farcall StartPointEndReactions ; $48f5
	call PlayDrillPointEndSequence ; $48f8
	ret ; $48fb
ServiceMatch1JudgeShot0:
	ld a, $00 ; $48fc
	call ServiceMatch1JudgePoint ; $48fe
	ld [$c2ff], a ; $4901
	ret ; $4904
ServiceMatch1JudgeShot1:
	ld a, $01 ; $4905
	call ServiceMatch1JudgePoint ; $4907
	ld [$c2ff], a ; $490a
	ret ; $490d
ServiceMatch1JudgeShot2:
	ret ; $490e
	ld a, $02 ; $490f
	call ServiceMatch1JudgePoint ; $4911
	ld [$c2ff], a ; $4914
	ret ; $4917
ServiceMatch1JudgeShot3:
	ret ; $4918
	ld a, $03 ; $4919
	call ServiceMatch1JudgePoint ; $491b
	ld [$c2ff], a ; $491e
	ret ; $4921
ServiceMatch1JudgePoint:
	ld b, a ; $4922
	ld a, [$c2ff] ; $4923
	or a, a ; $4926
	ret nz ; $4927
	ld a, [wRallyLength] ; $4928
	dec a ; $492b
	ld a, a ; $492c
	rst Rst00 ; $492d
	dw ServiceMatch1JudgePoint.rally1 ; $492e jumptable
	dw ServiceMatch1Cases1.step3 ; $4930 jumptable
.rally1:
	ld a, b ; $4932
	ld a, a ; $4933
	rst Rst00 ; $4934
	dw ServiceMatch1JudgePoint.result0 ; $4935 jumptable
	dw ServiceMatch1Cases1 ; $4937 jumptable
	dw ServiceMatch1Cases1.step ; $4939 jumptable
	dw ServiceMatch1Cases1.step2 ; $493b jumptable
.result0:
	ld a, [wPointOutcome] ; $493d
	ld hl, SignedTable_0b_495c ; $4940
	add a, l ; $4943
	ld l, a ; $4944
	jr nc, .readEntry1 ; $4945
	inc h ; $4947
.readEntry1:
	ld a, [hl] ; $4948
	ld a, a ; $4949
	ld b, $06 ; $494a
	call QueueDrillResultMessage ; $494c
	ld a, [wPointOutcome] ; $494f
	ld hl, SignedTable_0b_46f1 ; $4952
	add a, l ; $4955
	ld l, a ; $4956
	jr nc, .readEntry2 ; $4957
	inc h ; $4959
.readEntry2:
	ld a, [hl] ; $495a
	ret ; $495b
SignedTable_0b_495c:
	; $495c, 10 bytes (bytes:10)
	db $ff, $ff, $02, $ff, $ff, $02, $01, $ff, $ff, $01 ; 0x00
ServiceMatch1Cases1:
	xor a, a ; $4966
	ret ; $4967
.step:
	xor a, a ; $4968
	ret ; $4969
.step2:
	xor a, a ; $496a
	ret ; $496b
.step3:
	ld a, b ; $496c
	ld a, a ; $496d
	rst Rst00 ; $496e
	dw ServiceMatch1Cases1.checkPointOutcome ; $496f jumptable
	dw ServiceMatch1Cases2 ; $4971 jumptable
	dw ServiceMatch1Cases2.step ; $4973 jumptable
	dw ServiceMatch1Cases2.step2 ; $4975 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4977
	ld hl, SignedTable_0b_4996 ; $497a
	add a, l ; $497d
	ld l, a ; $497e
	jr nc, .read ; $497f
	inc h ; $4981
.read:
	ld a, [hl] ; $4982
	ld a, a ; $4983
	ld b, $06 ; $4984
	call QueueDrillResultMessage ; $4986
	ld a, [wPointOutcome] ; $4989
	ld hl, SignedTable_0b_46fb ; $498c
	add a, l ; $498f
	ld l, a ; $4990
	jr nc, .readB ; $4991
	inc h ; $4993
.readB:
	ld a, [hl] ; $4994
	ret ; $4995
SignedTable_0b_4996:
	; $4996, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $06, $06, $ff ; 0x00
ServiceMatch1Cases2:
	ld a, [wPointOutcome] ; $49a0
	cp a, $07 ; $49a3
	ld a, $00 ; $49a5
	ret z ; $49a7
	ld a, $04 ; $49a8
	ld b, $06 ; $49aa
	call QueueDrillResultMessage ; $49ac
	jr .storeMatchAbortFlag ; $49af
	db $af ; $49b1
	ret ; $49b2
.step:
	xor a, a ; $49b3
	ret ; $49b4
.step2:
	xor a, a ; $49b5
	ret ; $49b6
	ld a, $01 ; $49b7
	ld [wMatchAbortFlag], a ; $49b9
	ld a, $01 ; $49bc
	ret ; $49be
.storeMatchAbortFlag:
	ld a, $01 ; $49bf
	ld [wMatchAbortFlag], a ; $49c1
	ld a, $ff ; $49c4
	ret ; $49c6
ServiceMatch2Drill:
	; $49c7, 16 bytes (drill_definition)
	db $38, $18, $02, $05, $01, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServiceMatch2Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
ServiceMatch2Hooks:
	; $49d7, 16 bytes (mode_hooks)
	dw ServiceMatch2Hook_PerFrame ; record 0
	dw ServiceMatch2Hook_PointStart ; record 1
	dw ServiceMatch2Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw ServiceMatch2Hook_BallHit ; record 4
	dw ServiceMatch2Hook_Bounce ; record 5
	dw ServiceMatch2Hook_RallyTick ; record 6
	dw ServiceMatch2Hook_Draw ; record 7
ServiceMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $49e7
	ret ; $49ea
ServiceMatch2Hook_Draw:
	call QueueDrillMarker1_0b ; $49eb
	call QueueDrillMarker2_0b ; $49ee
	ret ; $49f1
ServiceMatch2Hook_PointStart:
	xor a, a ; $49f2
	ld [$c2e1], a ; $49f3
	ld [$c2e2], a ; $49f6
	ld a, $0a ; $49f9
	ld [$c2e0], a ; $49fb
	ld a, $01 ; $49fe
	ld [$c78b], a ; $4a00
	ld hl, DrillPositions_0b_4a6a ; $4a03
	call IndexDrillTableByPoint ; $4a06
	ld a, [wTotalPointsScoredInCurrentGame] ; $4a09
	srl a ; $4a0c
	ld hl, Table_0b_4a23 ; $4a0e
	add a, l ; $4a11
	ld l, a ; $4a12
	jr nc, .read ; $4a13
	inc h ; $4a15
.read:
	ld a, [hl] ; $4a16
	ld [$c7b5], a ; $4a17
	xor a, a ; $4a1a
	ld [$c2e6], a ; $4a1b
	xor a, a ; $4a1e
	ld [$c2ff], a ; $4a1f
	ret ; $4a22
Table_0b_4a23:
	; $4a23, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
ServiceMatch2Hook_PointEnd:
	call ServiceMatch2JudgeShot0 ; $4a27
	call ServiceMatch2HandlePointEnd ; $4a2a
	ld a, [wTotalPointsScoredInCurrentGame] ; $4a2d
	bit 0, a ; $4a30
	ret nz ; $4a32
	cp a, $08 ; $4a33
	jr z, .eq08 ; $4a35
	ld hl, $c2e8 ; $4a37
	ld a, [hl+] ; $4a3a
	ld b, [hl] ; $4a3b
	cp a, b ; $4a3c
	ret z ; $4a3d
	ld a, $80 ; $4a3e
	ld [wMatchAbortFlag], a ; $4a40
	ret ; $4a43
.eq08:
	ld hl, $c2e9 ; $4a44
	ld a, [hl-] ; $4a47
	sub a, [hl] ; $4a48
	jr z, .clearPointWinLoseFlag ; $4a49
	jr nc, .storePointWinLoseFlag ; $4a4b
	ld a, $01 ; $4a4d
	ld [wPointWinLoseFlag], a ; $4a4f
	ret ; $4a52
.clearPointWinLoseFlag:
	xor a, a ; $4a53
	ld [wPointWinLoseFlag], a ; $4a54
	ret ; $4a57
.storePointWinLoseFlag:
	ld a, $ff ; $4a58
	ld [wPointWinLoseFlag], a ; $4a5a
	ret ; $4a5d
ServiceMatch2Hook_RallyTick:
	call ServiceMatch2JudgeShot3 ; $4a5e
	ret ; $4a61
ServiceMatch2Hook_Bounce:
	call ServiceMatch2JudgeShot2 ; $4a62
	ret ; $4a65
ServiceMatch2Hook_BallHit:
	call ServiceMatch2JudgeShot1 ; $4a66
	ret ; $4a69
DrillPositions_0b_4a6a:
	; $4a6a, 66 bytes (records:4)
; 16 records x 4 bytes
	dw $0000, $0000 ; record 0
	dw $01b0, $0000 ; record 1
	dw $fe50, $0000 ; record 2
	dw $0000, $0000 ; record 3
	dw $fe50, $0000 ; record 4
	dw $0000, $0000 ; record 5
	dw $0000, $0000 ; record 6
	dw $01b0, $0000 ; record 7
	dw $fe50, $0000 ; record 8
	dw $0000, $0000 ; record 9
	dw $0000, $0000 ; record 10
	dw $01b0, $0000 ; record 11
	dw $0000, $0000 ; record 12
	dw $01b0, $0000 ; record 13
	dw $fe50, $0000 ; record 14
	dw $0000, $0000 ; record 15
	db $ff, $ff
ServiceMatch2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $4aac
	ld a, [$c2ff] ; $4aaf
	ld b, a ; $4ab2
	ld a, [wTotalPointsScoredInCurrentGame] ; $4ab3
	bit 0, a ; $4ab6
	ld a, b ; $4ab8
	jr z, .store ; $4ab9
	cpl ; $4abb
	inc a ; $4abc
.store:
	ld [wPointWinLoseFlag], a ; $4abd
	call RecordDrillPointResultBits ; $4ac0
	ld a, $00 ; $4ac3
	call CountDrillShotSuccesses ; $4ac5
	ld [$c2e8], a ; $4ac8
	ld a, $01 ; $4acb
	call CountDrillShotSuccesses ; $4acd
	ld [$c2e9], a ; $4ad0
	call ShowQueuedDrillMessage ; $4ad3
	ld hl, $c2f8 ; $4ad6
	ld a, [wCurrentServingPlayer] ; $4ad9
	add a, l ; $4adc
	ld l, a ; $4add
	jr nc, .read ; $4ade
	inc h ; $4ae0
.read:
	ld a, [hl] ; $4ae1
	or a, a ; $4ae2
	jr z, .serviceMatch2AwardPointToSide ; $4ae3
	farcall UpdatePointStats ; $4ae5
.serviceMatch2AwardPointToSide:
	call ServiceMatch2AwardPointToSide ; $4ae8
	ld a, [wPlayer1PointsWon] ; $4aeb
	ld b, $01 ; $4aee
	farcall LoadPlayer1PointsDigitGfx ; $4af0
	ld a, [wPlayer2PointsWon] ; $4af3
	ld b, $01 ; $4af6
	farcall LoadPlayer2PointsDigitGfx ; $4af8
	farcall StepMatchFrame ; $4afb
	farcall StartPointEndReactions ; $4afe
	call PlayDrillPointEndSequence ; $4b01
	ret ; $4b04
ServiceMatch2AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $4b05
	or a, a ; $4b08
	ret z ; $4b09
	inc a ; $4b0a
	srl a ; $4b0b
	ld b, a ; $4b0d
	ld a, [wTotalPointsScoredInCurrentGame] ; $4b0e
	and a, $01 ; $4b11
	xor a, $01 ; $4b13
	add a, b ; $4b15
	bit 0, a ; $4b16
	jr nz, .clearServeFaultFlag ; $4b18
	ld hl, wPlayer2PointsWon ; $4b1a
	bit 1, a ; $4b1d
	jr z, .bump ; $4b1f
	ld hl, wPlayer1PointsWon ; $4b21
.bump:
	inc [hl] ; $4b24
.clearServeFaultFlag:
	xor a, a ; $4b25
	ld [wServeFaultFlag], a ; $4b26
	ld hl, wTotalPointsScoredInCurrentGame ; $4b29
	inc [hl] ; $4b2c
	ret ; $4b2d
ServiceMatch2JudgeShot0:
	ld a, $00 ; $4b2e
	call ServiceMatch2JudgePoint ; $4b30
	ld [$c2ff], a ; $4b33
	ret ; $4b36
ServiceMatch2JudgeShot1:
	ld a, $01 ; $4b37
	call ServiceMatch2JudgePoint ; $4b39
	ld [$c2ff], a ; $4b3c
	ret ; $4b3f
ServiceMatch2JudgeShot2:
	ret ; $4b40
	ld a, $02 ; $4b41
	call ServiceMatch2JudgePoint ; $4b43
	ld [$c2ff], a ; $4b46
	ret ; $4b49
ServiceMatch2JudgeShot3:
	ld a, $03 ; $4b4a
	call ServiceMatch2JudgePoint ; $4b4c
	ld [$c2ff], a ; $4b4f
	ret ; $4b52
ServiceMatch2JudgePoint:
	ld b, a ; $4b53
	ld a, [$c2ff] ; $4b54
	or a, a ; $4b57
	ret nz ; $4b58
	ld a, [wRallyLength] ; $4b59
	dec a ; $4b5c
	ld a, a ; $4b5d
	rst Rst00 ; $4b5e
	dw ServiceMatch2JudgePoint.rally1 ; $4b5f jumptable
	dw ServiceMatch2Cases1.step2 ; $4b61 jumptable
.rally1:
	ld a, b ; $4b63
	ld a, a ; $4b64
	rst Rst00 ; $4b65
	dw ServiceMatch2JudgePoint.result0 ; $4b66 jumptable
	dw ServiceMatch2Cases1 ; $4b68 jumptable
	dw ServiceMatch2Cases1.step ; $4b6a jumptable
	dw ServiceMatch2Cases1.checkBallHasBouncedFlag ; $4b6c jumptable
.result0:
	ld a, [wPointOutcome] ; $4b6e
	ld hl, DrillShotTable_0b_4b8d ; $4b71
	add a, l ; $4b74
	ld l, a ; $4b75
	jr nc, .readEntry1 ; $4b76
	inc h ; $4b78
.readEntry1:
	ld a, [hl] ; $4b79
	ld a, a ; $4b7a
	ld b, $06 ; $4b7b
	call QueueDrillResultMessage ; $4b7d
	ld a, [wPointOutcome] ; $4b80
	ld hl, SignedTable_0b_46f1 ; $4b83
	add a, l ; $4b86
	ld l, a ; $4b87
	jr nc, .readEntry2 ; $4b88
	inc h ; $4b8a
.readEntry2:
	ld a, [hl] ; $4b8b
	ret ; $4b8c
DrillShotTable_0b_4b8d:
	; $4b8d, 10 bytes (bytes:10)
	db $ff, $ff, $02, $ff, $ff, $02, $01, $ff, $ff, $01 ; 0x00
ServiceMatch2Cases1:
	xor a, a ; $4b97
	ret ; $4b98
.step:
	xor a, a ; $4b99
	ret ; $4b9a
.checkBallHasBouncedFlag:
	ld a, [wBallHasBouncedFlag] ; $4b9b
	or a, a ; $4b9e
	ld a, $00 ; $4b9f
	ret nz ; $4ba1
	ld a, $03 ; $4ba2
	ld b, $06 ; $4ba4
	call QueueDrillResultMessage ; $4ba6
	farcall DidBallCrossGate ; $4ba9
	jr z, ServiceMatch2Cases2.storeMatchAbortFlag ; $4bac
	xor a, a ; $4bae
	ld [$c78b], a ; $4baf
	xor a, a ; $4bb2
	ld [$c78b], a ; $4bb3
	xor a, a ; $4bb6
	ret ; $4bb7
.step2:
	ld a, b ; $4bb8
	ld a, a ; $4bb9
	rst Rst00 ; $4bba
	dw ServiceMatch2Cases1.checkPointOutcome ; $4bbb jumptable
	dw ServiceMatch2Cases2 ; $4bbd jumptable
	dw ServiceMatch2Cases2.step ; $4bbf jumptable
	dw ServiceMatch2Cases2.step2 ; $4bc1 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4bc3
	ld hl, DrillShotTable_0b_4be2 ; $4bc6
	add a, l ; $4bc9
	ld l, a ; $4bca
	jr nc, .read ; $4bcb
	inc h ; $4bcd
.read:
	ld a, [hl] ; $4bce
	ld a, a ; $4bcf
	ld b, $06 ; $4bd0
	call QueueDrillResultMessage ; $4bd2
	ld a, [wPointOutcome] ; $4bd5
	ld hl, SignedTable_0b_46fb ; $4bd8
	add a, l ; $4bdb
	ld l, a ; $4bdc
	jr nc, .readB ; $4bdd
	inc h ; $4bdf
.readB:
	ld a, [hl] ; $4be0
	ret ; $4be1
DrillShotTable_0b_4be2:
	; $4be2, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $06, $06, $ff ; 0x00
ServiceMatch2Cases2:
	ld a, [wPointOutcome] ; $4bec
	cp a, $07 ; $4bef
	ld a, $00 ; $4bf1
	ret z ; $4bf3
	ld a, $04 ; $4bf4
	ld b, $06 ; $4bf6
	call QueueDrillResultMessage ; $4bf8
	jr .storeMatchAbortFlag ; $4bfb
	db $af ; $4bfd
	ret ; $4bfe
.step:
	xor a, a ; $4bff
	ret ; $4c00
.step2:
	xor a, a ; $4c01
	ret ; $4c02
	ld a, $01 ; $4c03
	ld [wMatchAbortFlag], a ; $4c05
	ld a, $01 ; $4c08
	ret ; $4c0a
.storeMatchAbortFlag:
	ld a, $01 ; $4c0b
	ld [wMatchAbortFlag], a ; $4c0d
	ld a, $ff ; $4c10
	ret ; $4c12
ServiceMatch3Drill:
	; $4c13, 16 bytes (drill_definition)
	db $39, $18, $02, $05, $02, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServiceMatch3Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
ServiceMatch3Hooks:
	; $4c23, 16 bytes (mode_hooks)
	dw ServiceMatch3Hook_PerFrame ; record 0
	dw ServiceMatch3Hook_PointStart ; record 1
	dw ServiceMatch3Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw ServiceMatch3Hook_BallHit ; record 4
	dw ServiceMatch3Hook_Bounce ; record 5
	dw ServiceMatch3Hook_RallyTick ; record 6
	dw RetStub ; record 7
ServiceMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4c33
	ret ; $4c36
ServiceMatch3Hook_PointStart:
	xor a, a ; $4c37
	ld [$c2e1], a ; $4c38
	ld a, $0a ; $4c3b
	ld [$c2e0], a ; $4c3d
	xor a, a ; $4c40
	ld [$c2e6], a ; $4c41
	xor a, a ; $4c44
	ld [$c2ff], a ; $4c45
	ret ; $4c48
ServiceMatch3Hook_PointEnd:
	call ServiceMatch3JudgeShot0 ; $4c49
	call ServiceMatch3HandlePointEnd ; $4c4c
	ld a, [wPointWinLoseFlag] ; $4c4f
	or a, a ; $4c52
	ret z ; $4c53
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c54
	bit 0, a ; $4c57
	ret nz ; $4c59
	ld a, [wPlayer1PointsWon] ; $4c5a
	ld b, a ; $4c5d
	ld a, [wPlayer2PointsWon] ; $4c5e
	sub a, b ; $4c61
	ld b, a ; $4c62
	bit 7, a ; $4c63
	jr z, .compare ; $4c65
	cpl ; $4c67
	inc a ; $4c68
.compare:
	cp a, $02 ; $4c69
	jr c, .checkTotalPointsScoredInCurrentGame ; $4c6b
	xor a, a ; $4c6d
	rl b ; $4c6e
	rl a ; $4c70
	or a, a ; $4c72
	jr nz, .store ; $4c73
	ld a, $ff ; $4c75
.store:
	ld [wPointWinLoseFlag], a ; $4c77
	ld a, $80 ; $4c7a
	ld [wMatchAbortFlag], a ; $4c7c
	ret ; $4c7f
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c80
	cp a, $08 ; $4c83
	ret c ; $4c85
	ld a, $00 ; $4c86
	ld [wPointWinLoseFlag], a ; $4c88
	ret ; $4c8b
ServiceMatch3Hook_RallyTick:
	call ServiceMatch3JudgeShot3 ; $4c8c
	ret ; $4c8f
ServiceMatch3Hook_Bounce:
	call ServiceMatch3JudgeShot2 ; $4c90
	ret ; $4c93
ServiceMatch3Hook_BallHit:
	call ServiceMatch3JudgeShot1 ; $4c94
	ret ; $4c97
ServiceMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $4c98
	ld a, [$c2ff] ; $4c9b
	ld b, a ; $4c9e
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c9f
	bit 0, a ; $4ca2
	ld a, b ; $4ca4
	jr z, .store ; $4ca5
	cpl ; $4ca7
	inc a ; $4ca8
.store:
	ld [wPointWinLoseFlag], a ; $4ca9
	call RecordDrillPointResultBits ; $4cac
	ld a, $00 ; $4caf
	call CountDrillShotSuccesses ; $4cb1
	ld [$c2e8], a ; $4cb4
	ld a, $01 ; $4cb7
	call CountDrillShotSuccesses ; $4cb9
	ld [$c2e9], a ; $4cbc
	call ShowQueuedDrillMessage ; $4cbf
	farcall UpdatePointStats ; $4cc2
	call ServiceMatch3AwardPointToSide ; $4cc5
	ld a, [$c2e8] ; $4cc8
	ld [wPlayer1PointsWon], a ; $4ccb
	ld a, [$c2e9] ; $4cce
	ld [wPlayer2PointsWon], a ; $4cd1
	ld a, [wPlayer1PointsWon] ; $4cd4
	ld b, $01 ; $4cd7
	farcall LoadPlayer1PointsDigitGfx ; $4cd9
	ld a, [wPlayer2PointsWon] ; $4cdc
	ld b, $01 ; $4cdf
	farcall LoadPlayer2PointsDigitGfx ; $4ce1
	farcall StepMatchFrame ; $4ce4
	farcall StartPointEndReactions ; $4ce7
	call PlayDrillPointEndSequence ; $4cea
	ret ; $4ced
ServiceMatch3AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $4cee
	or a, a ; $4cf1
	ret z ; $4cf2
	inc a ; $4cf3
	srl a ; $4cf4
	ld b, a ; $4cf6
	ld a, [wTotalPointsScoredInCurrentGame] ; $4cf7
	and a, $01 ; $4cfa
	xor a, $01 ; $4cfc
	add a, b ; $4cfe
	bit 0, a ; $4cff
	jr nz, .clearServeFaultFlag ; $4d01
	ld hl, wPlayer2PointsWon ; $4d03
	bit 1, a ; $4d06
	jr z, .bump ; $4d08
	ld hl, wPlayer1PointsWon ; $4d0a
.bump:
	inc [hl] ; $4d0d
.clearServeFaultFlag:
	xor a, a ; $4d0e
	ld [wServeFaultFlag], a ; $4d0f
	ld hl, wTotalPointsScoredInCurrentGame ; $4d12
	inc [hl] ; $4d15
	ret ; $4d16
ServiceMatch3JudgeShot0:
	ld a, $00 ; $4d17
	call ServiceMatch3JudgePoint ; $4d19
	ld [$c2ff], a ; $4d1c
	ret ; $4d1f
ServiceMatch3JudgeShot1:
	ld a, $01 ; $4d20
	call ServiceMatch3JudgePoint ; $4d22
	ld [$c2ff], a ; $4d25
	ret ; $4d28
ServiceMatch3JudgeShot2:
	ret ; $4d29
	ld a, $02 ; $4d2a
	call ServiceMatch3JudgePoint ; $4d2c
	ld [$c2ff], a ; $4d2f
	ret ; $4d32
ServiceMatch3JudgeShot3:
	ret ; $4d33
	ld a, $03 ; $4d34
	call ServiceMatch3JudgePoint ; $4d36
	ld [$c2ff], a ; $4d39
	ret ; $4d3c
ServiceMatch3JudgePoint:
	ld b, a ; $4d3d
	ld a, [$c2ff] ; $4d3e
	or a, a ; $4d41
	ret nz ; $4d42
	ld a, [wRallyLength] ; $4d43
	dec a ; $4d46
	ld a, a ; $4d47
	rst Rst00 ; $4d48
	dw ServiceMatch3JudgePoint.rally1 ; $4d49 jumptable
	dw ServiceMatch3Cases1.step3 ; $4d4b jumptable
.rally1:
	ld a, b ; $4d4d
	ld a, a ; $4d4e
	rst Rst00 ; $4d4f
	dw ServiceMatch3JudgePoint.result0 ; $4d50 jumptable
	dw ServiceMatch3Cases1 ; $4d52 jumptable
	dw ServiceMatch3Cases1.step ; $4d54 jumptable
	dw ServiceMatch3Cases1.step2 ; $4d56 jumptable
.result0:
	ld a, [wPointOutcome] ; $4d58
	ld hl, DrillShotTable_0b_4d77 ; $4d5b
	add a, l ; $4d5e
	ld l, a ; $4d5f
	jr nc, .readEntry1 ; $4d60
	inc h ; $4d62
.readEntry1:
	ld a, [hl] ; $4d63
	ld a, a ; $4d64
	ld b, $06 ; $4d65
	call QueueDrillResultMessage ; $4d67
	ld a, [wPointOutcome] ; $4d6a
	ld hl, SignedTable_0b_46f1 ; $4d6d
	add a, l ; $4d70
	ld l, a ; $4d71
	jr nc, .readEntry2 ; $4d72
	inc h ; $4d74
.readEntry2:
	ld a, [hl] ; $4d75
	ret ; $4d76
DrillShotTable_0b_4d77:
	; $4d77, 10 bytes (bytes:10)
	db $ff, $ff, $02, $ff, $ff, $02, $01, $ff, $ff, $01 ; 0x00
ServiceMatch3Cases1:
	xor a, a ; $4d81
	ret ; $4d82
.step:
	xor a, a ; $4d83
	ret ; $4d84
.step2:
	xor a, a ; $4d85
	ret ; $4d86
.step3:
	ld a, b ; $4d87
	ld a, a ; $4d88
	rst Rst00 ; $4d89
	dw ServiceMatch3Cases1.checkPointOutcome ; $4d8a jumptable
	dw ServiceMatch3Cases2 ; $4d8c jumptable
	dw ServiceMatch3Cases2.step ; $4d8e jumptable
	dw ServiceMatch3Cases2.step2 ; $4d90 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4d92
	ld hl, DrillShotTable_0b_4db1 ; $4d95
	add a, l ; $4d98
	ld l, a ; $4d99
	jr nc, .read ; $4d9a
	inc h ; $4d9c
.read:
	ld a, [hl] ; $4d9d
	ld a, a ; $4d9e
	ld b, $06 ; $4d9f
	call QueueDrillResultMessage ; $4da1
	ld a, [wPointOutcome] ; $4da4
	ld hl, SignedTable_0b_46fb ; $4da7
	add a, l ; $4daa
	ld l, a ; $4dab
	jr nc, .readB ; $4dac
	inc h ; $4dae
.readB:
	ld a, [hl] ; $4daf
	ret ; $4db0
DrillShotTable_0b_4db1:
	; $4db1, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $06, $06, $ff ; 0x00
ServiceMatch3Cases2:
	ld a, [wPointOutcome] ; $4dbb
	cp a, $07 ; $4dbe
	ld a, $00 ; $4dc0
	ret z ; $4dc2
	ld a, $04 ; $4dc3
	ld b, $06 ; $4dc5
	call QueueDrillResultMessage ; $4dc7
	jr .storeMatchAbortFlag ; $4dca
	db $af ; $4dcc
	ret ; $4dcd
.step:
	xor a, a ; $4dce
	ret ; $4dcf
.step2:
	xor a, a ; $4dd0
	ret ; $4dd1
	ld a, $01 ; $4dd2
	ld [wMatchAbortFlag], a ; $4dd4
	ld a, $01 ; $4dd7
	ret ; $4dd9
.storeMatchAbortFlag:
	ld a, $01 ; $4dda
	ld [wMatchAbortFlag], a ; $4ddc
	ld a, $ff ; $4ddf
	ret ; $4de1
ServicePractice1Drill:
	; $4de2, 16 bytes (drill_definition)
	db $3a, $09, $02, $05, $03, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServicePractice1Hooks, PracticeDrillPointTable, ServicePractice1DrillInit ; mode hooks, point table, init
	db $00, $00
ServicePractice1DrillInit:
	ld a, $01 ; $4df2
	ld [$c7bb], a ; $4df4
	ret ; $4df7
ServicePractice1Hooks:
	; $4df8, 16 bytes (mode_hooks)
	dw ServicePractice1Hook_PerFrame ; record 0
	dw ServicePractice1Hook_PointStart ; record 1
	dw ServicePractice1Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw ServicePractice1Hook_BallHit ; record 4
	dw ServicePractice1Hook_Bounce ; record 5
	dw ServicePractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
ServicePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4e08
	ret ; $4e0b
ServicePractice1Hook_PointStart:
	xor a, a ; $4e0c
	ld [$c2e1], a ; $4e0d
	ld a, $0a ; $4e10
	ld [$c2e0], a ; $4e12
	xor a, a ; $4e15
	ld [$c2e6], a ; $4e16
	ld a, $01 ; $4e19
	ld [wTargetZoneEnabled], a ; $4e1b
	ld hl, DrillPositions_0b_4ea0 ; $4e1e
	call SetDrillTargetZoneForPoint ; $4e21
	ret ; $4e24
ServicePractice1Hook_PointEnd:
	call ServicePractice1HandlePointEnd ; $4e25
	ld a, [wTotalPointsScoredInCurrentGame] ; $4e28
	cp a, $04 ; $4e2b
	ret c ; $4e2d
	ld a, [wPointWinLoseFlag] ; $4e2e
	or a, a ; $4e31
	ret z ; $4e32
	call ServicePractice1EvaluateResult ; $4e33
	ld [wPointWinLoseFlag], a ; $4e36
	ld a, $80 ; $4e39
	ld [wMatchAbortFlag], a ; $4e3b
	ret ; $4e3e
ServicePractice1EvaluateResult:
	ld a, [$c2e7] ; $4e3f
	ld b, a ; $4e42
	ld a, $04 ; $4e43
	sub a, b ; $4e45
	ld b, a ; $4e46
	cp a, $04 ; $4e47
	jr nz, .checkCharacter1DoubleFaults ; $4e49
	ld a, $01 ; $4e4b
	ld [$c2e3], a ; $4e4d
	jr .notFound ; $4e50
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $4e52
	or a, a ; $4e55
	jr z, .zero ; $4e56
	ld a, $02 ; $4e58
	ld [$c2e3], a ; $4e5a
	jr .notFound ; $4e5d
.zero:
	ld a, b ; $4e5f
	or a, a ; $4e60
	jr z, .zero2 ; $4e61
	ld a, $03 ; $4e63
	ld [$c2e3], a ; $4e65
	jr .notFound ; $4e68
.notFound:
	ld a, $ff ; $4e6a
	ret ; $4e6c
.zero2:
	xor a, a ; $4e6d
	ld [$c2e3], a ; $4e6e
	ld a, $01 ; $4e71
	ret ; $4e73
ServicePractice1Hook_RallyTick:
	ret ; $4e74
ServicePractice1Hook_Bounce:
	ld a, [wRallyLength] ; $4e75
	cp a, $01 ; $4e78
	ret nz ; $4e7a
	call RecordDrillTargetZoneHitIfInPlay ; $4e7b
	ret ; $4e7e
	ld a, [wBallBounceCount] ; $4e7f
	cp a, $02 ; $4e82
	ret nz ; $4e84
	ld a, [wRallyLength] ; $4e85
	cp a, $01 ; $4e88
	ret nz ; $4e8a
	sound $72 ; $4e8b
	ret ; $4e8d
ServicePractice1Hook_BallHit:
	ld a, [wRallyLength] ; $4e8e
	cp a, $02 ; $4e91
	jr c, .done ; $4e93
	ld a, $01 ; $4e95
	ld [$c2e1], a ; $4e97
	call ResetActiveCharState ; $4e9a
	sound $5f ; $4e9d
.done:
	ret ; $4e9f
DrillPositions_0b_4ea0:
	; $4ea0, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $fe50, $fd60 ; record 0
	dw $ff28, $feb0 ; record 1
	dw $00d8, $fd60 ; record 2
	dw $01b0, $feb0 ; record 3
	dw $00d8, $0150 ; record 4
	dw $01b0, $02a0 ; record 5
	dw $fe50, $0150 ; record 6
	dw $ff28, $02a0 ; record 7
	db $ff, $ff
ServicePractice1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $4ec2
	call ServicePractice1QueueOutcomeMessage ; $4ec5
	ld [wPointWinLoseFlag], a ; $4ec8
	call RecordDrillPointResultBits ; $4ecb
	ld a, $00 ; $4ece
	call CountDrillShotSuccesses ; $4ed0
	ld [$c2e8], a ; $4ed3
	ld a, $01 ; $4ed6
	call CountDrillShotSuccesses ; $4ed8
	ld [$c2e9], a ; $4edb
	call ShowQueuedDrillMessage ; $4ede
	farcall UpdatePointStats ; $4ee1
	farcall AwardPoint ; $4ee4
	ld a, [$c2e8] ; $4ee7
	ld [wPlayer1PointsWon], a ; $4eea
	xor a, a ; $4eed
	ld [wPlayer2PointsWon], a ; $4eee
	ld a, [wPlayer1PointsWon] ; $4ef1
	ld b, $01 ; $4ef4
	farcall LoadPlayer1PointsDigitGfx ; $4ef6
	ld a, [wPlayer2PointsWon] ; $4ef9
	ld b, $01 ; $4efc
	farcall LoadPlayer2PointsDigitGfx ; $4efe
	farcall StepMatchFrame ; $4f01
	ld a, $01 ; $4f04
	ld hl, SyncPointWinLoseFlagTask ; $4f06
	call RegisterFrameTask ; $4f09
	farcall StartPointEndReactions ; $4f0c
	ld hl, SyncPointWinLoseFlagTask ; $4f0f
	call UnregisterFrameTask ; $4f12
	call PlayDrillPointEndSequence ; $4f15
	ret ; $4f18
	call CheckDrillTargetZoneMissed ; $4f19
	add a, a ; $4f1c
	dec a ; $4f1d
	ld [$c2f8], a ; $4f1e
	ret ; $4f21
ServicePractice1QueueOutcomeMessage:
	ld a, [wPointOutcome] ; $4f22
	cp a, $01 ; $4f25
	jp z, .step4 ; $4f27
	cp a, $03 ; $4f2a
	jp z, .step4 ; $4f2c
	ld a, [wPointOutcome] ; $4f2f
	cp a, $02 ; $4f32
	jr z, .eq02 ; $4f34
	ld a, $10 ; $4f36
	ld b, $00 ; $4f38
	call QueueDrillResultMessage ; $4f3a
	call CheckDrillTargetZoneMissed ; $4f3d
	or a, a ; $4f40
	jr z, .zero ; $4f41
	ld a, $0d ; $4f43
	ld b, $00 ; $4f45
	call QueueDrillResultMessage ; $4f47
	jr .step2 ; $4f4a
.eq02:
	ld a, $0e ; $4f4c
	ld b, $00 ; $4f4e
	call QueueDrillResultMessage ; $4f50
	ld a, $ff ; $4f53
	ret ; $4f55
	db $18 ; $4f56
	db $07 ; $4f57
.step2:
	ld hl, $c2e7 ; $4f58
	inc [hl] ; $4f5b
	ld a, $01 ; $4f5c
	ret ; $4f5e
.zero:
	ld a, $ff ; $4f5f
	ret ; $4f61
.step4:
	ld a, $ff ; $4f62
	ld [$c2e6], a ; $4f64
	xor a, a ; $4f67
	ret ; $4f68
ServicePractice2Drill:
	; $4f69, 16 bytes (drill_definition)
	db $3b, $09, $02, $05, $04, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServicePractice2Hooks, PracticeDrillPointTable, ServicePractice2DrillInit ; mode hooks, point table, init
	db $00, $00
ServicePractice2DrillInit:
	ld a, $01 ; $4f79
	ld [$c7bb], a ; $4f7b
	ret ; $4f7e
ServicePractice2Hooks:
	; $4f7f, 16 bytes (mode_hooks)
	dw ServicePractice2Hook_PerFrame ; record 0
	dw ServicePractice2Hook_PointStart ; record 1
	dw ServicePractice2Hook_PointEnd ; record 2
	dw ServicePractice2Hook_MinigameStart ; record 3
	dw ServicePractice2Hook_BallHit ; record 4
	dw ServicePractice2Hook_Bounce ; record 5
	dw ServicePractice2Hook_RallyTick ; record 6
	dw RetStub ; record 7
ServicePractice2Hook_MinigameStart:
	ld a, $02 ; $4f8f
	ld [$c2e8], a ; $4f91
	ld [$c2e9], a ; $4f94
	ret ; $4f97
ServicePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4f98
	ret ; $4f9b
ServicePractice2Hook_PointStart:
	xor a, a ; $4f9c
	ld [$c2e1], a ; $4f9d
	ld a, $0a ; $4fa0
	ld [$c2e0], a ; $4fa2
	ld a, $01 ; $4fa5
	ld [wTargetZoneEnabled], a ; $4fa7
	ld hl, DrillPositions_0b_5060 ; $4faa
	call SetDrillTargetZoneForPoint ; $4fad
	xor a, a ; $4fb0
	ld [$c2e6], a ; $4fb1
	ret ; $4fb4
ServicePractice2Hook_PointEnd:
	call ServicePractice2HandlePointEnd ; $4fb5
	ld a, [wTotalPointsScoredInCurrentGame] ; $4fb8
	cp a, $04 ; $4fbb
	ret c ; $4fbd
	ld a, [wPointWinLoseFlag] ; $4fbe
	or a, a ; $4fc1
	ret z ; $4fc2
	call ServicePractice2EvaluateResult ; $4fc3
	ld [wPointWinLoseFlag], a ; $4fc6
	ld a, $80 ; $4fc9
	ld [wMatchAbortFlag], a ; $4fcb
	ret ; $4fce
ServicePractice2EvaluateResult:
	ld a, [wPlayer1PointsWon] ; $4fcf
	or a, a ; $4fd2
	jr nz, .checkCharacter1DoubleFaults ; $4fd3
	ld a, $01 ; $4fd5
	ld [$c2e3], a ; $4fd7
	jr .notFound ; $4fda
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $4fdc
	or a, a ; $4fdf
	jr z, .countDrillResultBitsSet ; $4fe0
	ld a, $02 ; $4fe2
	ld [$c2e3], a ; $4fe4
	jr .notFound ; $4fe7
.countDrillResultBitsSet:
	call CountDrillResultBitsSet ; $4fe9
	or a, a ; $4fec
	jr z, .zero ; $4fed
	ld a, $03 ; $4fef
	ld [$c2e3], a ; $4ff1
	jr .notFound ; $4ff4
.zero:
	ld a, [$c2e9] ; $4ff6
	or a, a ; $4ff9
	jr z, .zero3 ; $4ffa
	ld a, [$c2e8] ; $4ffc
	or a, a ; $4fff
	jr z, .zero2 ; $5000
	ld a, $04 ; $5002
	ld [$c2e3], a ; $5004
	jr .notFound ; $5007
.zero2:
	ld b, $06 ; $5009
	ld a, [wStoryModeMainCharacterLeftHanded] ; $500b
	cpl ; $500e
	inc a ; $500f
	add a, b ; $5010
	ld [$c2e3], a ; $5011
	jr .notFound ; $5014
.zero3:
	ld a, [$c2e8] ; $5016
	or a, a ; $5019
	jr z, .zero4 ; $501a
	ld b, $05 ; $501c
	ld a, [wStoryModeMainCharacterLeftHanded] ; $501e
	add a, b ; $5021
	ld [$c2e3], a ; $5022
	jr .notFound ; $5025
.notFound:
	ld a, $ff ; $5027
	ret ; $5029
.zero4:
	xor a, a ; $502a
	ld [$c2e3], a ; $502b
	ld a, $01 ; $502e
	ret ; $5030
ServicePractice2Hook_RallyTick:
	ret ; $5031
ServicePractice2Hook_Bounce:
	ld a, [wBallHasBouncedFlag] ; $5032
	or a, a ; $5035
	ret nz ; $5036
	ld a, [wRallyLength] ; $5037
	cp a, $01 ; $503a
	ret nz ; $503c
	call RecordDrillTargetZoneHitIfInPlay ; $503d
	ret ; $5040
	ld a, [wBallBounceCount] ; $5041
	cp a, $02 ; $5044
	ret nz ; $5046
	ld a, [wRallyLength] ; $5047
	cp a, $01 ; $504a
	ret nz ; $504c
	sound $72 ; $504d
	ret ; $504f
ServicePractice2Hook_BallHit:
	ld a, [wRallyLength] ; $5050
	cp a, $02 ; $5053
	jr c, .done ; $5055
	ld a, $01 ; $5057
	ld [$c2e1], a ; $5059
	call ResetActiveCharState ; $505c
.done:
	ret ; $505f
DrillPositions_0b_5060:
	; $5060, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $fe50, $fd60 ; record 0
	dw $fee0, $fe40 ; record 1
	dw $0120, $fd60 ; record 2
	dw $01b0, $fe40 ; record 3
	dw $0120, $01c0 ; record 4
	dw $01b0, $02a0 ; record 5
	dw $fe50, $01c0 ; record 6
	dw $fee0, $02a0 ; record 7
	db $ff, $ff
ServicePractice2HandlePointEnd:
	call ServicePractice2SetupShotTarget ; $5082
	farcall UpdateScorePanelDisplay ; $5085
	call ServicePractice2QueueOutcomeMessage ; $5088
	ld [wPointWinLoseFlag], a ; $508b
	call RecordDrillPointResultBits ; $508e
	ld a, $00 ; $5091
	call CountDrillShotSuccesses ; $5093
	ld [$c2ec], a ; $5096
	ld a, $01 ; $5099
	call CountDrillShotSuccesses ; $509b
	ld [$c2ed], a ; $509e
	ld a, [$c2e6] ; $50a1
	or a, a ; $50a4
	jr nz, .showDrillMessageByIndex ; $50a5
	call QueueDrillOutcomeMessage ; $50a7
.showDrillMessageByIndex:
	call ShowDrillMessageByIndex ; $50aa
	farcall UpdatePointStats ; $50ad
	farcall AwardPoint ; $50b0
	ld a, [$c2ec] ; $50b3
	ld [wPlayer1PointsWon], a ; $50b6
	xor a, a ; $50b9
	ld [wPlayer2PointsWon], a ; $50ba
	ld a, [wPlayer1PointsWon] ; $50bd
	ld b, $01 ; $50c0
	farcall LoadPlayer1PointsDigitGfx ; $50c2
	ld a, [wPlayer2PointsWon] ; $50c5
	ld b, $01 ; $50c8
	farcall LoadPlayer2PointsDigitGfx ; $50ca
	farcall StepMatchFrame ; $50cd
	ld a, $01 ; $50d0
	ld hl, SyncPointWinLoseFlagTask ; $50d2
	call RegisterFrameTask ; $50d5
	farcall StartPointEndReactions ; $50d8
	ld hl, SyncPointWinLoseFlagTask ; $50db
	call UnregisterFrameTask ; $50de
	call PlayDrillPointEndSequence ; $50e1
	ret ; $50e4
ServicePractice2SetupShotTarget:
	ld a, [wRallyLength] ; $50e5
	cp a, $01 ; $50e8
	ret nz ; $50ea
	ld a, [wTotalPointsScoredInCurrentGame] ; $50eb
	cp a, $04 ; $50ee
	ret nc ; $50f0
	ld hl, Table_0b_5130 ; $50f1
	add a, l ; $50f4
	ld l, a ; $50f5
	jr nc, .checkStoryModeMainCharacterLeftHanded ; $50f6
	inc h ; $50f8
.checkStoryModeMainCharacterLeftHanded:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $50f9
	add a, l ; $50fc
	ld l, a ; $50fd
	jr nc, .read ; $50fe
	inc h ; $5100
.read:
	ld b, [hl] ; $5101
	ld a, [wCurrentShotType] ; $5102
	ld [$c2ea], a ; $5105
	cp a, b ; $5108
	jr nz, .checkTotalPointsScoredInCurrentGame ; $5109
	ld a, [wTotalPointsScoredInCurrentGame] ; $510b
	add a, a ; $510e
	ld hl, $5135 ; $510f
	add a, l ; $5112
	ld l, a ; $5113
	jr nc, .checkStoryModeMainCharacterLeftHanded2 ; $5114
	inc h ; $5116
.checkStoryModeMainCharacterLeftHanded2:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5117
	add a, a ; $511a
	add a, l ; $511b
	ld l, a ; $511c
	jr nc, .readB ; $511d
	inc h ; $511f
.readB:
	ld a, [hl+] ; $5120
	ld h, [hl] ; $5121
	ld l, a ; $5122
	dec [hl] ; $5123
	ret ; $5124
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5125
	and a, $01 ; $5128
	add a, $11 ; $512a
	ld [$c2e6], a ; $512c
	ret ; $512f
Table_0b_5130:
	; $5130, 15 bytes (bytes:15)
	db $0d, $0c, $0d, $0c, $0d, $e9, $c2, $e8, $c2, $e9, $c2, $e8, $c2, $e9, $c2 ; 0x00
ServicePractice2QueueOutcomeMessage:
	ld a, [wPointOutcome] ; $513f
	cp a, $01 ; $5142
	jp z, .step4 ; $5144
	cp a, $03 ; $5147
	jp z, .step4 ; $5149
	ld a, [wPointOutcome] ; $514c
	cp a, $02 ; $514f
	jr nz, .ne02 ; $5151
	ld a, $0e ; $5153
	ld b, $00 ; $5155
	call QueueDrillResultMessage ; $5157
	jr .notFound ; $515a
.ne02:
	ld a, $11 ; $515c
	ld b, $00 ; $515e
	call QueueDrillResultMessage ; $5160
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5163
	and a, $01 ; $5166
	ld b, a ; $5168
	ld a, [wTotalPointsScoredInCurrentGame] ; $5169
	add a, b ; $516c
	and a, $01 ; $516d
	xor a, $01 ; $516f
	ld b, a ; $5171
	ld a, [$c2e6] ; $5172
	add a, b ; $5175
	ld [$c2e6], a ; $5176
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5179
	ld hl, DrillShotTable_0b_51c8 ; $517c
	add a, l ; $517f
	ld l, a ; $5180
	jr nc, .checkTotalPointsScoredInCurrentGame ; $5181
	inc h ; $5183
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5184
	add a, l ; $5187
	ld l, a ; $5188
	jr nc, .read ; $5189
	inc h ; $518b
.read:
	ld b, [hl] ; $518c
	ld a, [$c2ea] ; $518d
	cp a, b ; $5190
	jr nz, .notFound ; $5191
	ld a, $10 ; $5193
	ld b, $00 ; $5195
	call QueueDrillResultMessage ; $5197
	call CheckDrillTargetZoneMissed ; $519a
	or a, a ; $519d
	jr z, .notFound ; $519e
	ld a, $0d ; $51a0
	ld b, $00 ; $51a2
	call QueueDrillResultMessage ; $51a4
	ld a, [wPointOutcome] ; $51a7
	cp a, $06 ; $51aa
	jr z, .eq06 ; $51ac
	ld a, $0e ; $51ae
	ld b, $00 ; $51b0
	call QueueDrillResultMessage ; $51b2
	jr .notFound ; $51b5
.eq06:
	ld hl, $c2e7 ; $51b7
	inc [hl] ; $51ba
	ld a, $01 ; $51bb
	ret ; $51bd
.notFound:
	ld a, $ff ; $51be
	ret ; $51c0
.step4:
	ld a, $ff ; $51c1
	ld [$c2e6], a ; $51c3
	xor a, a ; $51c6
	ret ; $51c7
DrillShotTable_0b_51c8:
	; $51c8, 5 bytes (bytes:5)
	db $0d, $0c, $0d, $0c, $0d ; 0x00
ServicePractice3Drill:
	; $51cd, 16 bytes (drill_definition)
	db $3c, $09, $02, $05, $05, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw ServicePractice3Hooks, PracticeDrillPointTable, ServicePractice3DrillInit ; mode hooks, point table, init
	db $00, $00
ServicePractice3DrillInit:
	ld a, $01 ; $51dd
	ld [$c7bb], a ; $51df
	ret ; $51e2
ServicePractice3Hooks:
	; $51e3, 16 bytes (mode_hooks)
	dw ServicePractice3Hook_PerFrame ; record 0
	dw ServicePractice3Hook_PointStart ; record 1
	dw ServicePractice3Hook_PointEnd ; record 2
	dw ServicePractice3Hook_MinigameStart ; record 3
	dw ServicePractice3Hook_BallHit ; record 4
	dw ServicePractice3Hook_Bounce ; record 5
	dw ServicePractice3Hook_RallyTick ; record 6
	dw ServicePractice3Hook_Draw ; record 7
ServicePractice3Hook_MinigameStart:
	ld a, $04 ; $51f3
	ld [$c2e8], a ; $51f5
	ld a, $01 ; $51f8
	ld [$c7bb], a ; $51fa
	ret ; $51fd
ServicePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $51fe
	ld a, [wRallyLength] ; $5201
	cp a, $01 ; $5204
	jr nz, .done ; $5206
	call RecordGateCrossOnServe ; $5208
.done:
	ret ; $520b
ServicePractice3Hook_Draw:
	call QueueDrillMarker1_0b ; $520c
	call QueueDrillMarker2_0b ; $520f
	ret ; $5212
ServicePractice3Hook_PointStart:
	xor a, a ; $5213
	ld [$c2e1], a ; $5214
	ld a, $0a ; $5217
	ld [$c2e0], a ; $5219
	ld a, $01 ; $521c
	ld [wTargetZoneEnabled], a ; $521e
	ld hl, $5302 ; $5221
	call SetDrillTargetZoneForPoint ; $5224
	ld a, $01 ; $5227
	ld [$c78b], a ; $5229
	ld hl, DrillPositions_0b_52e0 ; $522c
	call IndexDrillTableByPoint ; $522f
	xor a, a ; $5232
	ld [$c2e6], a ; $5233
	ret ; $5236
ServicePractice3Hook_PointEnd:
	call ServicePractice3HandlePointEnd ; $5237
	ld a, [wTotalPointsScoredInCurrentGame] ; $523a
	cp a, $04 ; $523d
	ret c ; $523f
	ld a, [wPointWinLoseFlag] ; $5240
	or a, a ; $5243
	ret z ; $5244
	call ServicePractice3EvaluateResult ; $5245
	ld [wPointWinLoseFlag], a ; $5248
	ld a, $80 ; $524b
	ld [wMatchAbortFlag], a ; $524d
	ret ; $5250
ServicePractice3EvaluateResult:
	call CountDrillResultBitsSet ; $5251
	ld b, a ; $5254
	call CountDrillResultBitsSetAlt ; $5255
	ld c, a ; $5258
	ld a, [$c2e7] ; $5259
	or a, a ; $525c
	jr nz, .checkCharacter1DoubleFaults ; $525d
	ld a, $01 ; $525f
	ld [$c2e3], a ; $5261
	jr .notFound ; $5264
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5266
	or a, a ; $5269
	jr z, .countDrillResultBitsSet ; $526a
	ld a, $02 ; $526c
	ld [$c2e3], a ; $526e
	jr .notFound ; $5271
.countDrillResultBitsSet:
	call CountDrillResultBitsSet ; $5273
	or a, a ; $5276
	jr z, .zero ; $5277
	ld a, $03 ; $5279
	ld [$c2e3], a ; $527b
	jr .notFound ; $527e
.zero:
	ld a, [$c2e8] ; $5280
	or a, a ; $5283
	jr z, .countDrillResultBitsSetAlt ; $5284
	ld a, $04 ; $5286
	ld [$c2e3], a ; $5288
	jr .notFound ; $528b
.countDrillResultBitsSetAlt:
	call CountDrillResultBitsSetAlt ; $528d
	cp a, $04 ; $5290
	jr z, .eq04 ; $5292
	ld a, $05 ; $5294
	ld [$c2e3], a ; $5296
	jr .notFound ; $5299
.notFound:
	ld a, $ff ; $529b
	ret ; $529d
.eq04:
	xor a, a ; $529e
	ld [$c2e3], a ; $529f
	ld a, $01 ; $52a2
	ret ; $52a4
ServicePractice3Hook_RallyTick:
	ret ; $52a5
ServicePractice3Hook_Bounce:
	ld a, [wRallyLength] ; $52a6
	cp a, $01 ; $52a9
	ret nz ; $52ab
	call RecordDrillTargetZoneHitIfInPlay ; $52ac
	ret ; $52af
ServicePractice3Hook_BallHit:
	call ServicePractice3SetupShotTarget ; $52b0
	ld a, [wRallyLength] ; $52b3
	cp a, $02 ; $52b6
	jr c, .done ; $52b8
	ld a, $01 ; $52ba
	ld [$c2e1], a ; $52bc
	call ResetActiveCharState ; $52bf
.done:
	ret ; $52c2
ServicePractice3SetupShotTarget:
	ld a, [wRallyLength] ; $52c3
	cp a, $01 ; $52c6
	ret nz ; $52c8
	ld a, [wTotalPointsScoredInCurrentGame] ; $52c9
	cp a, $04 ; $52cc
	ret nc ; $52ce
	ld a, [wSpecialShotFlag] ; $52cf
	or a, a ; $52d2
	jr nz, .nonZero ; $52d3
	ld a, $13 ; $52d5
	ld [$c2e6], a ; $52d7
	ret ; $52da
.nonZero:
	ld hl, $c2e8 ; $52db
	dec [hl] ; $52de
	ret ; $52df
DrillPositions_0b_52e0:
	; $52e0, 68 bytes (records:4)
; 17 records x 4 bytes
	dw $0000, $02a0 ; record 0
	dw $006c, $02a0 ; record 1
	dw $ff94, $02a0 ; record 2
	dw $0000, $02a0 ; record 3
	dw $ff94, $fd60 ; record 4
	dw $0000, $fd60 ; record 5
	dw $0000, $fd60 ; record 6
	dw $006c, $fd60 ; record 7
	dw $ffff, $ff94 ; record 8
	dw $fd60, $0000 ; record 9
	dw $feb0, $0000 ; record 10
	dw $fd60, $006c ; record 11
	dw $feb0, $0000 ; record 12
	dw $0150, $006c ; record 13
	dw $02a0, $ff94 ; record 14
	dw $0150, $0000 ; record 15
	dw $02a0, $ffff ; record 16
ServicePractice3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5324
	call ServicePractice3QueueOutcomeMessage ; $5327
	ld [wPointWinLoseFlag], a ; $532a
	call RecordDrillPointResultBits ; $532d
	ld a, $00 ; $5330
	call CountDrillShotSuccesses ; $5332
	ld [$c2ec], a ; $5335
	ld a, $01 ; $5338
	call CountDrillShotSuccesses ; $533a
	ld [$c2ed], a ; $533d
	call ShowQueuedDrillMessage ; $5340
	farcall UpdatePointStats ; $5343
	farcall AwardPoint ; $5346
	ld a, [$c2ec] ; $5349
	ld [wPlayer1PointsWon], a ; $534c
	xor a, a ; $534f
	ld [wPlayer2PointsWon], a ; $5350
	ld a, [wPlayer1PointsWon] ; $5353
	ld b, $01 ; $5356
	farcall LoadPlayer1PointsDigitGfx ; $5358
	ld a, [wPlayer2PointsWon] ; $535b
	ld b, $01 ; $535e
	farcall LoadPlayer2PointsDigitGfx ; $5360
	farcall StepMatchFrame ; $5363
	ld a, $01 ; $5366
	ld hl, SyncPointWinLoseFlagTask ; $5368
	call RegisterFrameTask ; $536b
	farcall StartPointEndReactions ; $536e
	ld hl, SyncPointWinLoseFlagTask ; $5371
	call UnregisterFrameTask ; $5374
	call PlayDrillPointEndSequence ; $5377
	ret ; $537a
ServicePractice3QueueOutcomeMessage:
	ld a, [wPointOutcome] ; $537b
	cp a, $01 ; $537e
	jp z, .step4 ; $5380
	cp a, $03 ; $5383
	jp z, .step4 ; $5385
	ld a, [wPointOutcome] ; $5388
	cp a, $02 ; $538b
	jr z, .eq02 ; $538d
	ld a, $13 ; $538f
	ld b, $00 ; $5391
	call QueueDrillResultMessage ; $5393
	ld a, [wSpecialShotFlag] ; $5396
	or a, a ; $5399
	jr z, .notFound ; $539a
	ld a, $0f ; $539c
	ld b, $00 ; $539e
	call QueueDrillResultMessage ; $53a0
	call CountDrillResultBitsThisGame ; $53a3
	jr z, .notFound ; $53a6
	ld a, $10 ; $53a8
	ld b, $00 ; $53aa
	call QueueDrillResultMessage ; $53ac
	call CheckDrillTargetZoneMissed ; $53af
	or a, a ; $53b2
	jr z, .notFound ; $53b3
	ld a, $0d ; $53b5
	ld b, $00 ; $53b7
	call QueueDrillResultMessage ; $53b9
	ld a, [wPointOutcome] ; $53bc
	cp a, $06 ; $53bf
	jr z, .eq06 ; $53c1
.eq02:
	ld a, $0e ; $53c3
	ld b, $00 ; $53c5
	call QueueDrillResultMessage ; $53c7
	jr .notFound ; $53ca
.eq06:
	ld hl, $c2e7 ; $53cc
	inc [hl] ; $53cf
	ld a, $01 ; $53d0
	ret ; $53d2
.notFound:
	ld a, $ff ; $53d3
	ret ; $53d5
.step4:
	ld a, $ff ; $53d6
	ld [$c2e6], a ; $53d8
	xor a, a ; $53db
	ret ; $53dc
NetGameMatch1Drill:
	; $53dd, 16 bytes (drill_definition)
	db $3d, $18, $02, $05, $06, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGameMatch1Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
NetGameMatch1Hooks:
	; $53ed, 16 bytes (mode_hooks)
	dw NetGameMatch1Hook_PerFrame ; record 0
	dw NetGameMatch1Hook_PointStart ; record 1
	dw NetGameMatch1Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch1Hook_BallHit ; record 4
	dw NetGameMatch1Hook_Bounce ; record 5
	dw NetGameMatch1Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $53fd
	ret ; $5400
NetGameMatch1Hook_PointStart:
	xor a, a ; $5401
	ld [$c2e1], a ; $5402
	ld a, $0a ; $5405
	ld [$c2e0], a ; $5407
	ld hl, $542c ; $540a
	call LoadDrillOpponentBySide ; $540d
	xor a, a ; $5410
	ld [$c2e6], a ; $5411
	xor a, a ; $5414
	ld [$c2ff], a ; $5415
	ld a, [wTotalPointsScoredInCurrentGame] ; $5418
	bit 0, a ; $541b
	ret nz ; $541d
	xor a, a ; $541e
	ld [$c2e8], a ; $541f
	ld [$c2e9], a ; $5422
	ld [$c2ea], a ; $5425
	ld [$c2eb], a ; $5428
	ret ; $542b
	db $3d ; $542c
	db $54 ; $542d
NetGameMatch1Hook_PointEnd:
	call NetGameMatch1JudgeShot0 ; $542e
	call NetGameMatch1HandlePointEnd ; $5431
	ld a, [wTotalPointsScoredInCurrentGame] ; $5434
	bit 0, a ; $5437
	ret nz ; $5439
	call NetGameMatch1DecideWinner ; $543a
	ld a, [wPlayer2PointsWon] ; $543d
	ld hl, wPlayer1PointsWon ; $5440
	sub a, [hl] ; $5443
	ret z ; $5444
	ld a, $80 ; $5445
	ld [wMatchAbortFlag], a ; $5447
	ret ; $544a
NetGameMatch1Hook_RallyTick:
	call NetGameMatch1JudgeShot3 ; $544b
	ret ; $544e
NetGameMatch1Hook_Bounce:
	call NetGameMatch1JudgeShot2 ; $544f
	ret ; $5452
NetGameMatch1Hook_BallHit:
	call NetGameMatch1JudgeShot1 ; $5453
	ret ; $5456
NetGameMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5457
	ld a, [$c2ff] ; $545a
	ld b, a ; $545d
	ld a, [wTotalPointsScoredInCurrentGame] ; $545e
	bit 0, a ; $5461
	ld a, b ; $5463
	jr z, .store ; $5464
	cpl ; $5466
	inc a ; $5467
.store:
	ld [wPointWinLoseFlag], a ; $5468
	call RecordDrillPointResultBits ; $546b
	call ShowQueuedDrillMessage ; $546e
	farcall UpdatePointStats ; $5471
	call NetGameMatch1AwardPointToSide ; $5474
	ld a, [wPlayer1PointsWon] ; $5477
	ld b, $01 ; $547a
	farcall LoadPlayer1PointsDigitGfx ; $547c
	ld a, [wPlayer2PointsWon] ; $547f
	ld b, $01 ; $5482
	farcall LoadPlayer2PointsDigitGfx ; $5484
	farcall StepMatchFrame ; $5487
	farcall StartPointEndReactions ; $548a
	call PlayDrillPointEndSequence ; $548d
	ret ; $5490
NetGameMatch1AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $5491
	or a, a ; $5494
	ret z ; $5495
	inc a ; $5496
	srl a ; $5497
	ld b, a ; $5499
	ld a, [wTotalPointsScoredInCurrentGame] ; $549a
	and a, $01 ; $549d
	xor a, $01 ; $549f
	add a, b ; $54a1
	bit 0, a ; $54a2
	jr nz, .clearServeFaultFlag ; $54a4
	ld hl, wPlayer2PointsWon ; $54a6
	bit 1, a ; $54a9
	jr z, .bump ; $54ab
	ld hl, wPlayer1PointsWon ; $54ad
.bump:
	inc [hl] ; $54b0
.clearServeFaultFlag:
	xor a, a ; $54b1
	ld [wServeFaultFlag], a ; $54b2
	ld hl, wTotalPointsScoredInCurrentGame ; $54b5
	inc [hl] ; $54b8
	ret ; $54b9
NetGameMatch1DecideWinner:
	ld a, [wPlayer1PointsWon] ; $54ba
	ld b, a ; $54bd
	ld a, [wPlayer2PointsWon] ; $54be
	sub a, b ; $54c1
	jr nc, .compare ; $54c2
	ld a, $01 ; $54c4
	ld [wPointWinLoseFlag], a ; $54c6
	ret ; $54c9
.compare:
	or a, a ; $54ca
	jr z, .store ; $54cb
	ld a, $ff ; $54cd
.store:
	ld [wPointWinLoseFlag], a ; $54cf
	ret ; $54d2
NetGameMatch1JudgeShot0:
	ld a, $00 ; $54d3
	call NetGameMatch1JudgePoint ; $54d5
	ld [$c2ff], a ; $54d8
	ret ; $54db
NetGameMatch1JudgeShot1:
	ld a, $01 ; $54dc
	call NetGameMatch1JudgePoint ; $54de
	ld [$c2ff], a ; $54e1
	ret ; $54e4
NetGameMatch1JudgeShot2:
	ret ; $54e5
	ld a, $02 ; $54e6
	call NetGameMatch1JudgePoint ; $54e8
	ld [$c2ff], a ; $54eb
	ret ; $54ee
NetGameMatch1JudgeShot3:
	ret ; $54ef
	ld a, $03 ; $54f0
	call NetGameMatch1JudgePoint ; $54f2
	ld [$c2ff], a ; $54f5
	ret ; $54f8
NetGameMatch1JudgePoint:
	ld b, a ; $54f9
	ld a, [$c2ff] ; $54fa
	or a, a ; $54fd
	ret nz ; $54fe
	ld a, [wRallyLength] ; $54ff
	dec a ; $5502
	ld a, a ; $5503
	rst Rst00 ; $5504
	dw NetGameMatch1JudgePoint.rally1 ; $5505 jumptable
	dw NetGameMatch1Cases1.step3 ; $5507 jumptable
	dw NetGameMatch1Cases2.step3 ; $5509 jumptable
	dw NetGameMatch1Cases3.step3 ; $550b jumptable
	dw NetGameMatch1Cases4.step3 ; $550d jumptable
.rally1:
	ld a, b ; $550f
	ld a, a ; $5510
	rst Rst00 ; $5511
	dw NetGameMatch1JudgePoint.result0 ; $5512 jumptable
	dw NetGameMatch1Cases1 ; $5514 jumptable
	dw NetGameMatch1Cases1.step ; $5516 jumptable
	dw NetGameMatch1Cases1.step2 ; $5518 jumptable
.result0:
	ld a, [wPointOutcome] ; $551a
	ld hl, DrillShotTable_0b_5539 ; $551d
	add a, l ; $5520
	ld l, a ; $5521
	jr nc, .readEntry1 ; $5522
	inc h ; $5524
.readEntry1:
	ld a, [hl] ; $5525
	ld a, a ; $5526
	ld b, $0d ; $5527
	call QueueDrillResultMessage ; $5529
	ld a, [wPointOutcome] ; $552c
	ld hl, SignedTable_0b_46f1 ; $552f
	add a, l ; $5532
	ld l, a ; $5533
	jr nc, .readEntry2 ; $5534
	inc h ; $5536
.readEntry2:
	ld a, [hl] ; $5537
	ret ; $5538
DrillShotTable_0b_5539:
	; $5539, 10 bytes (bytes:10)
	db $ff, $ff, $19, $ff, $ff, $1d, $17, $ff, $ff, $17 ; 0x00
NetGameMatch1Cases1:
	xor a, a ; $5543
	ret ; $5544
.step:
	xor a, a ; $5545
	ret ; $5546
.step2:
	xor a, a ; $5547
	ret ; $5548
.step3:
	ld a, b ; $5549
	ld a, a ; $554a
	rst Rst00 ; $554b
	dw NetGameMatch1Cases1.checkPointOutcome ; $554c jumptable
	dw NetGameMatch1Cases2 ; $554e jumptable
	dw NetGameMatch1Cases2.step ; $5550 jumptable
	dw NetGameMatch1Cases2.step2 ; $5552 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5554
	ld hl, DrillShotTable_0b_5573 ; $5557
	add a, l ; $555a
	ld l, a ; $555b
	jr nc, .read ; $555c
	inc h ; $555e
.read:
	ld a, [hl] ; $555f
	ld a, a ; $5560
	ld b, $0d ; $5561
	call QueueDrillResultMessage ; $5563
	ld a, [wPointOutcome] ; $5566
	ld hl, SignedTable_0b_46fb ; $5569
	add a, l ; $556c
	ld l, a ; $556d
	jr nc, .readB ; $556e
	inc h ; $5570
.readB:
	ld a, [hl] ; $5571
	ret ; $5572
DrillShotTable_0b_5573:
	; $5573, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $17, $17, $1f, $1e, $1e, $1f ; 0x00
NetGameMatch1Cases2:
	xor a, a ; $557d
	ret ; $557e
.step:
	xor a, a ; $557f
	ret ; $5580
.step2:
	xor a, a ; $5581
	ret ; $5582
.step3:
	ld a, b ; $5583
	ld a, a ; $5584
	rst Rst00 ; $5585
	dw NetGameMatch1Cases2.checkPointOutcome ; $5586 jumptable
	dw NetGameMatch1Cases3 ; $5588 jumptable
	dw NetGameMatch1Cases3.step ; $558a jumptable
	dw NetGameMatch1Cases3.step2 ; $558c jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $558e
	ld hl, DrillShotTable_0b_55ad ; $5591
	add a, l ; $5594
	ld l, a ; $5595
	jr nc, .read ; $5596
	inc h ; $5598
.read:
	ld a, [hl] ; $5599
	ld a, a ; $559a
	ld b, $0d ; $559b
	call QueueDrillResultMessage ; $559d
	ld a, [wPointOutcome] ; $55a0
	ld hl, SignedTable_0b_46f1 ; $55a3
	add a, l ; $55a6
	ld l, a ; $55a7
	jr nc, .readB ; $55a8
	inc h ; $55aa
.readB:
	ld a, [hl] ; $55ab
	ret ; $55ac
DrillShotTable_0b_55ad:
	; $55ad, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $1d, $1d, $14, $ff, $ff, $14 ; 0x00
NetGameMatch1Cases3:
	ld a, $1b ; $55b7
	ld b, $0d ; $55b9
	call QueueDrillResultMessage ; $55bb
	ld a, [wTotalPointsScoredInCurrentGame] ; $55be
	and a, $01 ; $55c1
	call TestCharStateBit4 ; $55c3
	or a, a ; $55c6
	jp z, NetGameMatch1Cases4.storeMatchAbortFlag ; $55c7
	ld a, $1f ; $55ca
	ld b, $0d ; $55cc
	call QueueDrillResultMessage ; $55ce
	ld a, [$c4a1] ; $55d1
	cp a, $01 ; $55d4
	jp nz, NetGameMatch1Cases4.storeMatchAbortFlag ; $55d6
	xor a, a ; $55d9
	ret ; $55da
.step:
	xor a, a ; $55db
	ret ; $55dc
.step2:
	xor a, a ; $55dd
	ret ; $55de
.step3:
	ld a, b ; $55df
	ld a, a ; $55e0
	rst Rst00 ; $55e1
	dw NetGameMatch1Cases3.checkPointOutcome ; $55e2 jumptable
	dw NetGameMatch1Cases4 ; $55e4 jumptable
	dw NetGameMatch1Cases4.step ; $55e6 jumptable
	dw NetGameMatch1Cases4.step2 ; $55e8 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $55ea
	ld hl, DrillShotTable_0b_5609 ; $55ed
	add a, l ; $55f0
	ld l, a ; $55f1
	jr nc, .read ; $55f2
	inc h ; $55f4
.read:
	ld a, [hl] ; $55f5
	ld a, a ; $55f6
	ld b, $0d ; $55f7
	call QueueDrillResultMessage ; $55f9
	ld a, [wPointOutcome] ; $55fc
	ld hl, SignedTable_0b_46fb ; $55ff
	add a, l ; $5602
	ld l, a ; $5603
	jr nc, .readB ; $5604
	inc h ; $5606
.readB:
	ld a, [hl] ; $5607
	ret ; $5608
DrillShotTable_0b_5609:
	; $5609, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $14, $14, $1d, $ff, $ff, $1d ; 0x00
NetGameMatch1Cases4:
	xor a, a ; $5613
	ret ; $5614
.step:
	xor a, a ; $5615
	ret ; $5616
.step2:
	xor a, a ; $5617
	ret ; $5618
.step3:
	ld a, b ; $5619
	ld a, a ; $561a
	rst Rst00 ; $561b
	dw NetGameMatch1Cases4.step4 ; $561c jumptable
	dw NetGameMatch1Cases4.queueDrillResultMessage ; $561e jumptable
	dw NetGameMatch1Cases4.step6 ; $5620 jumptable
	dw NetGameMatch1Cases4.step7 ; $5622 jumptable
.step4:
	xor a, a ; $5624
	ret ; $5625
.queueDrillResultMessage:
	ld a, $1d ; $5626
	ld b, $0d ; $5628
	call QueueDrillResultMessage ; $562a
	jp .storeMatchAbortFlag ; $562d
.step6:
	xor a, a ; $5630
	ret ; $5631
.step7:
	xor a, a ; $5632
	ret ; $5633
	ld a, $01 ; $5634
	ld [wMatchAbortFlag], a ; $5636
	ld a, $01 ; $5639
	ret ; $563b
.storeMatchAbortFlag:
	ld a, $01 ; $563c
	ld [wMatchAbortFlag], a ; $563e
	ld a, $ff ; $5641
	ret ; $5643
NetGameMatch2Drill:
	; $5644, 16 bytes (drill_definition)
	db $3e, $18, $02, $05, $07, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGameMatch2Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
NetGameMatch2Hooks:
	; $5654, 16 bytes (mode_hooks)
	dw NetGameMatch2Hook_PerFrame ; record 0
	dw NetGameMatch2Hook_PointStart ; record 1
	dw NetGameMatch2Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch2Hook_BallHit ; record 4
	dw NetGameMatch2Hook_Bounce ; record 5
	dw NetGameMatch2Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5664
	ret ; $5667
NetGameMatch2Hook_PointStart:
	xor a, a ; $5668
	ld [$c2e1], a ; $5669
	ld a, $0a ; $566c
	ld [$c2e0], a ; $566e
	ld hl, $5699 ; $5671
	call LoadDrillOpponentBySide ; $5674
	xor a, a ; $5677
	ld [$c2e6], a ; $5678
	xor a, a ; $567b
	ld [$c2ff], a ; $567c
	ld a, [wTotalPointsScoredInCurrentGame] ; $567f
	bit 0, a ; $5682
	ret nz ; $5684
	xor a, a ; $5685
	ld [$c2e8], a ; $5686
	ld [$c2e9], a ; $5689
	ld [$c2ea], a ; $568c
	ld [$c2eb], a ; $568f
	ld [$c2ec], a ; $5692
	ld [$c2ed], a ; $5695
	ret ; $5698
	db $3e ; $5699
	db $55 ; $569a
NetGameMatch2Hook_PointEnd:
	call NetGameMatch2JudgeShot0 ; $569b
	call NetGameMatch2HandlePointEnd ; $569e
	ld a, [wTotalPointsScoredInCurrentGame] ; $56a1
	bit 0, a ; $56a4
	ret nz ; $56a6
	ld a, [wPlayer1PointsWon] ; $56a7
	ld b, a ; $56aa
	ld a, [wPlayer2PointsWon] ; $56ab
	sub a, b ; $56ae
	ld b, a ; $56af
	bit 7, a ; $56b0
	jr z, .compare ; $56b2
	cpl ; $56b4
	inc a ; $56b5
.compare:
	cp a, $02 ; $56b6
	jr c, .checkTotalPointsScoredInCurrentGame ; $56b8
	xor a, a ; $56ba
	rl b ; $56bb
	rl a ; $56bd
	or a, a ; $56bf
	jr nz, .store ; $56c0
	ld a, $ff ; $56c2
.store:
	ld [wPointWinLoseFlag], a ; $56c4
	ld a, $80 ; $56c7
	ld [wMatchAbortFlag], a ; $56c9
	ret ; $56cc
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $56cd
	cp a, $08 ; $56d0
	ret nz ; $56d2
	ld a, $00 ; $56d3
	ld [wPointWinLoseFlag], a ; $56d5
	ld a, $80 ; $56d8
	ld [wMatchAbortFlag], a ; $56da
	ret ; $56dd
NetGameMatch2Hook_RallyTick:
	call NetGameMatch2JudgeShot3 ; $56de
	ret ; $56e1
NetGameMatch2Hook_Bounce:
	call NetGameMatch2JudgeShot2 ; $56e2
	ret ; $56e5
NetGameMatch2Hook_BallHit:
	call NetGameMatch2JudgeShot1 ; $56e6
	ret ; $56e9
NetGameMatch2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $56ea
	ld a, [$c2ff] ; $56ed
	ld b, a ; $56f0
	ld a, [wTotalPointsScoredInCurrentGame] ; $56f1
	bit 0, a ; $56f4
	ld a, b ; $56f6
	jr z, .store ; $56f7
	cpl ; $56f9
	inc a ; $56fa
.store:
	ld [wPointWinLoseFlag], a ; $56fb
	call RecordDrillPointResultBits ; $56fe
	call ShowQueuedDrillMessage ; $5701
	farcall UpdatePointStats ; $5704
	call NetGameMatch2AwardPointToSide ; $5707
	ld a, [wPlayer1PointsWon] ; $570a
	ld b, $01 ; $570d
	farcall LoadPlayer1PointsDigitGfx ; $570f
	ld a, [wPlayer2PointsWon] ; $5712
	ld b, $01 ; $5715
	farcall LoadPlayer2PointsDigitGfx ; $5717
	farcall StepMatchFrame ; $571a
	farcall StartPointEndReactions ; $571d
	call PlayDrillPointEndSequence ; $5720
	ret ; $5723
NetGameMatch2AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $5724
	or a, a ; $5727
	ret z ; $5728
	inc a ; $5729
	srl a ; $572a
	ld b, a ; $572c
	ld a, [wTotalPointsScoredInCurrentGame] ; $572d
	and a, $01 ; $5730
	xor a, $01 ; $5732
	add a, b ; $5734
	bit 0, a ; $5735
	jr nz, .clearServeFaultFlag ; $5737
	ld hl, wPlayer2PointsWon ; $5739
	bit 1, a ; $573c
	jr z, .bump ; $573e
	ld hl, wPlayer1PointsWon ; $5740
.bump:
	inc [hl] ; $5743
.clearServeFaultFlag:
	xor a, a ; $5744
	ld [wServeFaultFlag], a ; $5745
	ld hl, wTotalPointsScoredInCurrentGame ; $5748
	inc [hl] ; $574b
	ret ; $574c
NetGameMatch2JudgeShot0:
	ld a, $00 ; $574d
	call NetGameMatch2JudgePoint ; $574f
	ld [$c2ff], a ; $5752
	ret ; $5755
NetGameMatch2JudgeShot1:
	ld a, $01 ; $5756
	call NetGameMatch2JudgePoint ; $5758
	ld [$c2ff], a ; $575b
	ret ; $575e
NetGameMatch2JudgeShot2:
	ret ; $575f
	ld a, $02 ; $5760
	call NetGameMatch2JudgePoint ; $5762
	ld [$c2ff], a ; $5765
	ret ; $5768
NetGameMatch2JudgeShot3:
	ret ; $5769
	ld a, $03 ; $576a
	call NetGameMatch2JudgePoint ; $576c
	ld [$c2ff], a ; $576f
	ret ; $5772
NetGameMatch2JudgePoint:
	ld b, a ; $5773
	ld a, [$c2ff] ; $5774
	or a, a ; $5777
	ret nz ; $5778
	ld a, [wRallyLength] ; $5779
	dec a ; $577c
	ld a, a ; $577d
	rst Rst00 ; $577e
	dw NetGameMatch2JudgePoint.rally1 ; $577f jumptable
	dw NetGameMatch2Cases1.step3 ; $5781 jumptable
	dw NetGameMatch2Cases2.step3 ; $5783 jumptable
	dw NetGameMatch2Cases3.step3 ; $5785 jumptable
	dw NetGameMatch2Cases4.step3 ; $5787 jumptable
.rally1:
	ld a, b ; $5789
	ld a, a ; $578a
	rst Rst00 ; $578b
	dw NetGameMatch2JudgePoint.result0 ; $578c jumptable
	dw NetGameMatch2Cases1 ; $578e jumptable
	dw NetGameMatch2Cases1.step ; $5790 jumptable
	dw NetGameMatch2Cases1.step2 ; $5792 jumptable
.result0:
	ld a, [wPointOutcome] ; $5794
	ld hl, DrillShotTable_0b_57b3 ; $5797
	add a, l ; $579a
	ld l, a ; $579b
	jr nc, .readEntry1 ; $579c
	inc h ; $579e
.readEntry1:
	ld a, [hl] ; $579f
	ld a, a ; $57a0
	ld b, $0d ; $57a1
	call QueueDrillResultMessage ; $57a3
	ld a, [wPointOutcome] ; $57a6
	ld hl, SignedTable_0b_46f1 ; $57a9
	add a, l ; $57ac
	ld l, a ; $57ad
	jr nc, .readEntry2 ; $57ae
	inc h ; $57b0
.readEntry2:
	ld a, [hl] ; $57b1
	ret ; $57b2
DrillShotTable_0b_57b3:
	; $57b3, 10 bytes (bytes:10)
	db $ff, $ff, $19, $ff, $ff, $1d, $18, $ff, $ff, $18 ; 0x00
NetGameMatch2Cases1:
	xor a, a ; $57bd
	ret ; $57be
.step:
	xor a, a ; $57bf
	ret ; $57c0
.step2:
	xor a, a ; $57c1
	ret ; $57c2
.step3:
	ld a, b ; $57c3
	ld a, a ; $57c4
	rst Rst00 ; $57c5
	dw NetGameMatch2Cases1.checkPointOutcome ; $57c6 jumptable
	dw NetGameMatch2Cases2 ; $57c8 jumptable
	dw NetGameMatch2Cases2.step ; $57ca jumptable
	dw NetGameMatch2Cases2.step2 ; $57cc jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $57ce
	ld hl, DrillShotTable_0b_57ed ; $57d1
	add a, l ; $57d4
	ld l, a ; $57d5
	jr nc, .read ; $57d6
	inc h ; $57d8
.read:
	ld a, [hl] ; $57d9
	ld a, a ; $57da
	ld b, $0d ; $57db
	call QueueDrillResultMessage ; $57dd
	ld a, [wPointOutcome] ; $57e0
	ld hl, SignedTable_0b_46fb ; $57e3
	add a, l ; $57e6
	ld l, a ; $57e7
	jr nc, .readB ; $57e8
	inc h ; $57ea
.readB:
	ld a, [hl] ; $57eb
	ret ; $57ec
DrillShotTable_0b_57ed:
	; $57ed, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $17, $17, $1c, $1e, $1e, $1c ; 0x00
NetGameMatch2Cases2:
	ld a, [wBallBounceCount] ; $57f7
	or a, a ; $57fa
	ret z ; $57fb
	ld a, $18 ; $57fc
	ld b, $0d ; $57fe
	call QueueDrillResultMessage ; $5800
	ld a, [wCurrentShotType] ; $5803
	cp a, $0a ; $5806
	jp nz, NetGameMatch2Cases4.storeMatchAbortFlag ; $5808
	xor a, a ; $580b
	ret ; $580c
.step:
	xor a, a ; $580d
	ret ; $580e
.step2:
	xor a, a ; $580f
	ret ; $5810
.step3:
	ld a, b ; $5811
	ld a, a ; $5812
	rst Rst00 ; $5813
	dw NetGameMatch2Cases2.checkPointOutcome ; $5814 jumptable
	dw NetGameMatch2Cases3 ; $5816 jumptable
	dw NetGameMatch2Cases3.step ; $5818 jumptable
	dw NetGameMatch2Cases3.step2 ; $581a jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $581c
	ld hl, DrillShotTable_0b_583b ; $581f
	add a, l ; $5822
	ld l, a ; $5823
	jr nc, .read ; $5824
	inc h ; $5826
.read:
	ld a, [hl] ; $5827
	ld a, a ; $5828
	ld b, $0d ; $5829
	call QueueDrillResultMessage ; $582b
	ld a, [wPointOutcome] ; $582e
	ld hl, SignedTable_0b_46f1 ; $5831
	add a, l ; $5834
	ld l, a ; $5835
	jr nc, .readB ; $5836
	inc h ; $5838
.readB:
	ld a, [hl] ; $5839
	ret ; $583a
DrillShotTable_0b_583b:
	; $583b, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $1d, $1d, $15, $ff, $ff, $15 ; 0x00
NetGameMatch2Cases3:
	ld a, $1c ; $5845
	ld b, $0d ; $5847
	call QueueDrillResultMessage ; $5849
	ld a, [$c4a1] ; $584c
	cp a, $02 ; $584f
	jp nz, NetGameMatch2Cases4.storeMatchAbortFlag2 ; $5851
	xor a, a ; $5854
	ret ; $5855
.step:
	xor a, a ; $5856
	ret ; $5857
.step2:
	xor a, a ; $5858
	ret ; $5859
.step3:
	ld a, b ; $585a
	ld a, a ; $585b
	rst Rst00 ; $585c
	dw NetGameMatch2Cases3.checkPointOutcome ; $585d jumptable
	dw NetGameMatch2Cases4 ; $585f jumptable
	dw NetGameMatch2Cases4.step ; $5861 jumptable
	dw NetGameMatch2Cases4.step2 ; $5863 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5865
	ld hl, DrillShotTable_0b_5884 ; $5868
	add a, l ; $586b
	ld l, a ; $586c
	jr nc, .read ; $586d
	inc h ; $586f
.read:
	ld a, [hl] ; $5870
	ld a, a ; $5871
	ld b, $0d ; $5872
	call QueueDrillResultMessage ; $5874
	ld a, [wPointOutcome] ; $5877
	ld hl, SignedTable_0b_46fb ; $587a
	add a, l ; $587d
	ld l, a ; $587e
	jr nc, .readB ; $587f
	inc h ; $5881
.readB:
	ld a, [hl] ; $5882
	ret ; $5883
DrillShotTable_0b_5884:
	; $5884, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $15, $15, $1d, $ff, $ff, $1d ; 0x00
NetGameMatch2Cases4:
	xor a, a ; $588e
	ret ; $588f
.step:
	xor a, a ; $5890
	ret ; $5891
.step2:
	xor a, a ; $5892
	ret ; $5893
.step3:
	ld a, b ; $5894
	ld a, a ; $5895
	rst Rst00 ; $5896
	dw NetGameMatch2Cases4.step4 ; $5897 jumptable
	dw NetGameMatch2Cases4.queueDrillResultMessage ; $5899 jumptable
	dw NetGameMatch2Cases4.step6 ; $589b jumptable
	dw NetGameMatch2Cases4.step7 ; $589d jumptable
.step4:
	xor a, a ; $589f
	ret ; $58a0
.queueDrillResultMessage:
	ld a, $1d ; $58a1
	ld b, $0d ; $58a3
	call QueueDrillResultMessage ; $58a5
	jp .storeMatchAbortFlag2 ; $58a8
.step6:
	xor a, a ; $58ab
	ret ; $58ac
.step7:
	xor a, a ; $58ad
	ret ; $58ae
.storeMatchAbortFlag:
	ld a, $01 ; $58af
	ld [wMatchAbortFlag], a ; $58b1
	ld a, $01 ; $58b4
	ret ; $58b6
.storeMatchAbortFlag2:
	ld a, $01 ; $58b7
	ld [wMatchAbortFlag], a ; $58b9
	ld a, $ff ; $58bc
	ret ; $58be
NetGameMatch3Drill:
	; $58bf, 16 bytes (drill_definition)
	db $3f, $18, $02, $05, $08, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGameMatch3Hooks, MatchDrillPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
NetGameMatch3Hooks:
	; $58cf, 16 bytes (mode_hooks)
	dw NetGameMatch3Hook_PerFrame ; record 0
	dw NetGameMatch3Hook_PointStart ; record 1
	dw NetGameMatch3Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch3Hook_BallHit ; record 4
	dw NetGameMatch3Hook_Bounce ; record 5
	dw NetGameMatch3Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $58df
	ret ; $58e2
NetGameMatch3Hook_PointStart:
	xor a, a ; $58e3
	ld [$c2e1], a ; $58e4
	ld a, $0a ; $58e7
	ld [$c2e0], a ; $58e9
	xor a, a ; $58ec
	ld [$c2e6], a ; $58ed
	xor a, a ; $58f0
	ld [$c2ff], a ; $58f1
	ld a, [wTotalPointsScoredInCurrentGame] ; $58f4
	bit 1, a ; $58f7
	ret nz ; $58f9
	xor a, a ; $58fa
	ld [$c2e8], a ; $58fb
	ld [$c2e9], a ; $58fe
	ld [$c2ec], a ; $5901
	ld [$c2ed], a ; $5904
	ret ; $5907
NetGameMatch3Hook_PointEnd:
	call NetGameMatch3JudgeShot0 ; $5908
	call NetGameMatch3HandlePointEnd ; $590b
	ld hl, $594c ; $590e
	call LoadDrillOpponentBySide ; $5911
	ld a, [wTotalPointsScoredInCurrentGame] ; $5914
	bit 0, a ; $5917
	ret nz ; $5919
	ld a, [wPlayer1PointsWon] ; $591a
	ld b, a ; $591d
	ld a, [wPlayer2PointsWon] ; $591e
	sub a, b ; $5921
	ld b, a ; $5922
	bit 7, a ; $5923
	jr z, .compare ; $5925
	cpl ; $5927
	inc a ; $5928
.compare:
	cp a, $02 ; $5929
	jr c, .checkTotalPointsScoredInCurrentGame ; $592b
	xor a, a ; $592d
	rl b ; $592e
	rl a ; $5930
	or a, a ; $5932
	jr nz, .store ; $5933
	ld a, $ff ; $5935
.store:
	ld [wPointWinLoseFlag], a ; $5937
	ld a, $80 ; $593a
	ld [wMatchAbortFlag], a ; $593c
	ret ; $593f
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5940
	cp a, $08 ; $5943
	ret c ; $5945
	ld a, $00 ; $5946
	ld [wPointWinLoseFlag], a ; $5948
	ret ; $594b
	db $3f ; $594c
	db $56 ; $594d
NetGameMatch3Hook_RallyTick:
	call NetGameMatch3JudgeShot3 ; $594e
	ret ; $5951
NetGameMatch3Hook_Bounce:
	call NetGameMatch3JudgeShot2 ; $5952
	ret ; $5955
NetGameMatch3Hook_BallHit:
	call NetGameMatch3JudgeShot1 ; $5956
	ret ; $5959
NetGameMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $595a
	ld a, [$c2ff] ; $595d
	ld b, a ; $5960
	ld a, [wTotalPointsScoredInCurrentGame] ; $5961
	bit 0, a ; $5964
	ld a, b ; $5966
	jr z, .store ; $5967
	cpl ; $5969
	inc a ; $596a
.store:
	ld [wPointWinLoseFlag], a ; $596b
	call RecordDrillPointResultBits ; $596e
	call ShowQueuedDrillMessage ; $5971
	farcall UpdatePointStats ; $5974
	call NetGameMatch3AwardPointToSide ; $5977
	ld a, [wPlayer1PointsWon] ; $597a
	ld b, $01 ; $597d
	farcall LoadPlayer1PointsDigitGfx ; $597f
	ld a, [wPlayer2PointsWon] ; $5982
	ld b, $01 ; $5985
	farcall LoadPlayer2PointsDigitGfx ; $5987
	farcall StepMatchFrame ; $598a
	farcall StartPointEndReactions ; $598d
	call PlayDrillPointEndSequence ; $5990
	ret ; $5993
	ld a, [wPointOutcome] ; $5994
	cp a, $01 ; $5997
	jp z, .step5 ; $5999
	cp a, $03 ; $599c
	jp z, .step5 ; $599e
	ld a, [wRallyLength] ; $59a1
	dec a ; $59a4
	and a, $03 ; $59a5
	add a, a ; $59a7
	ld hl, $59b4 ; $59a8
	add a, l ; $59ab
	ld l, a ; $59ac
	jr nc, .read ; $59ad
	inc h ; $59af
.read:
	ld a, [hl+] ; $59b0
	ld h, [hl] ; $59b1
	ld l, a ; $59b2
	jp hl ; $59b3
	dw NetGameMatch3HandlePointEnd.queueDrillResultMessage ; $59b4 jumptable
	dw NetGameMatch3HandlePointEnd.queueDrillResultMessage3 ; $59b6 jumptable
	dw NetGameMatch3HandlePointEnd.queueDrillResultMessage2 ; $59b8 jumptable
	dw NetGameMatch3HandlePointEnd.queueDrillResultMessage4 ; $59ba jumptable
.queueDrillResultMessage:
	ld a, $17 ; $59bc
	ld b, $0d ; $59be
	call QueueDrillResultMessage ; $59c0
	ld a, [wPointOutcome] ; $59c3
	cp a, $06 ; $59c6
	jr z, .checkTotalPointsScoredInCurrentGame ; $59c8
	ld a, $19 ; $59ca
	ld b, $0d ; $59cc
	call QueueDrillResultMessage ; $59ce
	jp .checkTotalPointsScoredInCurrentGame2 ; $59d1
.queueDrillResultMessage2:
	ld a, $1b ; $59d4
	ld b, $0d ; $59d6
	call QueueDrillResultMessage ; $59d8
	ld a, [wTotalPointsScoredInCurrentGame] ; $59db
	and a, $01 ; $59de
	ld hl, $c2ec ; $59e0
	add a, l ; $59e3
	ld l, a ; $59e4
	jr nc, .readB ; $59e5
	inc h ; $59e7
.readB:
	ld a, [hl] ; $59e8
	or a, a ; $59e9
	jr z, .checkTotalPointsScoredInCurrentGame2 ; $59ea
	ld a, $16 ; $59ec
	ld b, $0d ; $59ee
	call QueueDrillResultMessage ; $59f0
	ld a, [wPointOutcome] ; $59f3
	cp a, $06 ; $59f6
	jr z, .checkTotalPointsScoredInCurrentGame ; $59f8
	jr .checkTotalPointsScoredInCurrentGame2 ; $59fa
.queueDrillResultMessage3:
	ld a, $1d ; $59fc
	ld b, $0d ; $59fe
	call QueueDrillResultMessage ; $5a00
	ld a, [wPointOutcome] ; $5a03
	cp a, $06 ; $5a06
	jr z, .checkTotalPointsScoredInCurrentGame2 ; $5a08
	push af ; $5a0a
	ld a, $1e ; $5a0b
	ld b, $0d ; $5a0d
	call QueueDrillResultMessage ; $5a0f
	pop af ; $5a12
	cp a, $07 ; $5a13
	jr z, .checkTotalPointsScoredInCurrentGame ; $5a15
	ld a, $17 ; $5a17
	ld b, $0d ; $5a19
	call QueueDrillResultMessage ; $5a1b
	jr .checkTotalPointsScoredInCurrentGame ; $5a1e
.queueDrillResultMessage4:
	ld a, $17 ; $5a20
	ld b, $0d ; $5a22
	call QueueDrillResultMessage ; $5a24
	ld a, [wPointOutcome] ; $5a27
	or a, a ; $5a2a
	jr nz, .checkTotalPointsScoredInCurrentGame ; $5a2b
	ld a, $1d ; $5a2d
	ld b, $0d ; $5a2f
	call QueueDrillResultMessage ; $5a31
	jr .checkTotalPointsScoredInCurrentGame2 ; $5a34
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5a36
	and a, $01 ; $5a39
	xor a, $01 ; $5a3b
	add a, a ; $5a3d
	dec a ; $5a3e
	ret ; $5a3f
.checkTotalPointsScoredInCurrentGame2:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5a40
	and a, $01 ; $5a43
	add a, a ; $5a45
	dec a ; $5a46
	ret ; $5a47
.step5:
	ld a, $ff ; $5a48
	ld [$c2e6], a ; $5a4a
	xor a, a ; $5a4d
	ret ; $5a4e
NetGameMatch3AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $5a4f
	or a, a ; $5a52
	ret z ; $5a53
	inc a ; $5a54
	srl a ; $5a55
	ld b, a ; $5a57
	ld a, [wTotalPointsScoredInCurrentGame] ; $5a58
	and a, $01 ; $5a5b
	xor a, $01 ; $5a5d
	add a, b ; $5a5f
	bit 0, a ; $5a60
	jr nz, .clearServeFaultFlag ; $5a62
	ld hl, wPlayer2PointsWon ; $5a64
	bit 1, a ; $5a67
	jr z, .bump ; $5a69
	ld hl, wPlayer1PointsWon ; $5a6b
.bump:
	inc [hl] ; $5a6e
.clearServeFaultFlag:
	xor a, a ; $5a6f
	ld [wServeFaultFlag], a ; $5a70
	ld hl, wTotalPointsScoredInCurrentGame ; $5a73
	inc [hl] ; $5a76
	ret ; $5a77
NetGameMatch3JudgeShot0:
	ld a, $00 ; $5a78
	call NetGameMatch3JudgePoint ; $5a7a
	ld [$c2ff], a ; $5a7d
	ret ; $5a80
NetGameMatch3JudgeShot1:
	ld a, $01 ; $5a81
	call NetGameMatch3JudgePoint ; $5a83
	ld [$c2ff], a ; $5a86
	ret ; $5a89
NetGameMatch3JudgeShot2:
	ret ; $5a8a
	ld a, $02 ; $5a8b
	call NetGameMatch3JudgePoint ; $5a8d
	ld [$c2ff], a ; $5a90
	ret ; $5a93
NetGameMatch3JudgeShot3:
	ret ; $5a94
	ld a, $03 ; $5a95
	call NetGameMatch3JudgePoint ; $5a97
	ld [$c2ff], a ; $5a9a
	ret ; $5a9d
NetGameMatch3JudgePoint:
	ld b, a ; $5a9e
	ld a, [$c2ff] ; $5a9f
	or a, a ; $5aa2
	ret nz ; $5aa3
	ld a, [wRallyLength] ; $5aa4
	dec a ; $5aa7
	ld a, a ; $5aa8
	rst Rst00 ; $5aa9
	dw NetGameMatch3JudgePoint.rally1 ; $5aaa jumptable
	dw NetGameMatch3Cases1.step3 ; $5aac jumptable
	dw NetGameMatch3Cases2.step3 ; $5aae jumptable
	dw NetGameMatch3Cases3.step3 ; $5ab0 jumptable
	dw NetGameMatch3Cases4.step3 ; $5ab2 jumptable
.rally1:
	ld a, b ; $5ab4
	ld a, a ; $5ab5
	rst Rst00 ; $5ab6
	dw NetGameMatch3JudgePoint.result0 ; $5ab7 jumptable
	dw NetGameMatch3Cases1 ; $5ab9 jumptable
	dw NetGameMatch3Cases1.step ; $5abb jumptable
	dw NetGameMatch3Cases1.step2 ; $5abd jumptable
.result0:
	ld a, [wPointOutcome] ; $5abf
	ld hl, DrillShotTable_0b_5ade ; $5ac2
	add a, l ; $5ac5
	ld l, a ; $5ac6
	jr nc, .readEntry1 ; $5ac7
	inc h ; $5ac9
.readEntry1:
	ld a, [hl] ; $5aca
	ld a, a ; $5acb
	ld b, $0d ; $5acc
	call QueueDrillResultMessage ; $5ace
	ld a, [wPointOutcome] ; $5ad1
	ld hl, SignedTable_0b_46f1 ; $5ad4
	add a, l ; $5ad7
	ld l, a ; $5ad8
	jr nc, .readEntry2 ; $5ad9
	inc h ; $5adb
.readEntry2:
	ld a, [hl] ; $5adc
	ret ; $5add
DrillShotTable_0b_5ade:
	; $5ade, 10 bytes (bytes:10)
	db $ff, $ff, $19, $ff, $ff, $1d, $17, $ff, $ff, $17 ; 0x00
NetGameMatch3Cases1:
	xor a, a ; $5ae8
	ret ; $5ae9
.step:
	xor a, a ; $5aea
	ret ; $5aeb
.step2:
	xor a, a ; $5aec
	ret ; $5aed
.step3:
	ld a, b ; $5aee
	ld a, a ; $5aef
	rst Rst00 ; $5af0
	dw NetGameMatch3Cases1.checkPointOutcome ; $5af1 jumptable
	dw NetGameMatch3Cases2 ; $5af3 jumptable
	dw NetGameMatch3Cases2.step ; $5af5 jumptable
	dw NetGameMatch3Cases2.step2 ; $5af7 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5af9
	ld hl, DrillShotTable_0b_5b18 ; $5afc
	add a, l ; $5aff
	ld l, a ; $5b00
	jr nc, .read ; $5b01
	inc h ; $5b03
.read:
	ld a, [hl] ; $5b04
	ld a, a ; $5b05
	ld b, $0d ; $5b06
	call QueueDrillResultMessage ; $5b08
	ld a, [wPointOutcome] ; $5b0b
	ld hl, SignedTable_0b_46fb ; $5b0e
	add a, l ; $5b11
	ld l, a ; $5b12
	jr nc, .readB ; $5b13
	inc h ; $5b15
.readB:
	ld a, [hl] ; $5b16
	ret ; $5b17
DrillShotTable_0b_5b18:
	; $5b18, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $17, $17, $20, $1e, $1e, $20 ; 0x00
NetGameMatch3Cases2:
	xor a, a ; $5b22
	ret ; $5b23
.step:
	xor a, a ; $5b24
	ret ; $5b25
.step2:
	xor a, a ; $5b26
	ret ; $5b27
.step3:
	ld a, b ; $5b28
	ld a, a ; $5b29
	rst Rst00 ; $5b2a
	dw NetGameMatch3Cases2.checkPointOutcome ; $5b2b jumptable
	dw NetGameMatch3Cases3 ; $5b2d jumptable
	dw NetGameMatch3Cases3.step ; $5b2f jumptable
	dw NetGameMatch3Cases3.step2 ; $5b31 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5b33
	ld hl, DrillShotTable_0b_5b52 ; $5b36
	add a, l ; $5b39
	ld l, a ; $5b3a
	jr nc, .read ; $5b3b
	inc h ; $5b3d
.read:
	ld a, [hl] ; $5b3e
	ld a, a ; $5b3f
	ld b, $0d ; $5b40
	call QueueDrillResultMessage ; $5b42
	ld a, [wPointOutcome] ; $5b45
	ld hl, SignedTable_0b_46f1 ; $5b48
	add a, l ; $5b4b
	ld l, a ; $5b4c
	jr nc, .readB ; $5b4d
	inc h ; $5b4f
.readB:
	ld a, [hl] ; $5b50
	ret ; $5b51
DrillShotTable_0b_5b52:
	; $5b52, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $1d, $1d, $16, $ff, $ff, $16 ; 0x00
NetGameMatch3Cases3:
	ld a, $1b ; $5b5c
	ld b, $0d ; $5b5e
	call QueueDrillResultMessage ; $5b60
	ld a, [wTotalPointsScoredInCurrentGame] ; $5b63
	and a, $01 ; $5b66
	call TestCharStateBit4 ; $5b68
	or a, a ; $5b6b
	jp z, NetGameMatch3Cases4.storeMatchAbortFlag ; $5b6c
	xor a, a ; $5b6f
	ret ; $5b70
.step:
	xor a, a ; $5b71
	ret ; $5b72
.step2:
	xor a, a ; $5b73
	ret ; $5b74
.step3:
	ld a, b ; $5b75
	ld a, a ; $5b76
	rst Rst00 ; $5b77
	dw NetGameMatch3Cases3.checkPointOutcome ; $5b78 jumptable
	dw NetGameMatch3Cases4 ; $5b7a jumptable
	dw NetGameMatch3Cases4.step ; $5b7c jumptable
	dw NetGameMatch3Cases4.step2 ; $5b7e jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5b80
	ld hl, DrillShotTable_0b_5b9f ; $5b83
	add a, l ; $5b86
	ld l, a ; $5b87
	jr nc, .read ; $5b88
	inc h ; $5b8a
.read:
	ld a, [hl] ; $5b8b
	ld a, a ; $5b8c
	ld b, $0d ; $5b8d
	call QueueDrillResultMessage ; $5b8f
	ld a, [wPointOutcome] ; $5b92
	ld hl, SignedTable_0b_46fb ; $5b95
	add a, l ; $5b98
	ld l, a ; $5b99
	jr nc, .readB ; $5b9a
	inc h ; $5b9c
.readB:
	ld a, [hl] ; $5b9d
	ret ; $5b9e
DrillShotTable_0b_5b9f:
	; $5b9f, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $16, $16, $1d, $ff, $ff, $1d ; 0x00
NetGameMatch3Cases4:
	xor a, a ; $5ba9
	ret ; $5baa
.step:
	xor a, a ; $5bab
	ret ; $5bac
.step2:
	xor a, a ; $5bad
	ret ; $5bae
.step3:
	ld a, b ; $5baf
	ld a, a ; $5bb0
	rst Rst00 ; $5bb1
	dw NetGameMatch3Cases4.step4 ; $5bb2 jumptable
	dw NetGameMatch3Cases4.queueDrillResultMessage ; $5bb4 jumptable
	dw NetGameMatch3Cases4.step6 ; $5bb6 jumptable
	dw NetGameMatch3Cases4.step7 ; $5bb8 jumptable
.step4:
	xor a, a ; $5bba
	ret ; $5bbb
.queueDrillResultMessage:
	ld a, $1d ; $5bbc
	ld b, $0d ; $5bbe
	call QueueDrillResultMessage ; $5bc0
	jp .storeMatchAbortFlag ; $5bc3
.step6:
	xor a, a ; $5bc6
	ret ; $5bc7
.step7:
	xor a, a ; $5bc8
	ret ; $5bc9
	ld a, $01 ; $5bca
	ld [wMatchAbortFlag], a ; $5bcc
	ld a, $01 ; $5bcf
	ret ; $5bd1
.storeMatchAbortFlag:
	ld a, $01 ; $5bd2
	ld [wMatchAbortFlag], a ; $5bd4
	ld a, $ff ; $5bd7
	ret ; $5bd9
NetGamePractice1Drill:
	; $5bda, 16 bytes (drill_definition)
	db $40, $09, $02, $05, $09, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGamePractice1Hooks, PracticeDrillPointTable, NetGamePractice1DrillInit ; mode hooks, point table, init
	db $00, $00
NetGamePractice1DrillInit:
	ld a, $01 ; $5bea
	ld [$c7bb], a ; $5bec
	ret ; $5bef
NetGamePractice1Hooks:
	; $5bf0, 16 bytes (mode_hooks)
	dw NetGamePractice1Hook_PerFrame ; record 0
	dw NetGamePractice1Hook_PointStart ; record 1
	dw NetGamePractice1Hook_PointEnd ; record 2
	dw NetGamePractice1Hook_MinigameStart ; record 3
	dw NetGamePractice1Hook_BallHit ; record 4
	dw NetGamePractice1Hook_Bounce ; record 5
	dw NetGamePractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGamePractice1Hook_MinigameStart:
	xor a, a ; $5c00
	ld [$c2e9], a ; $5c01
	ld [$c2ea], a ; $5c04
	ld [$c2eb], a ; $5c07
	ld a, $04 ; $5c0a
	ld [$c2ec], a ; $5c0c
	ld a, $01 ; $5c0f
	ld [$c7bb], a ; $5c11
	ret ; $5c14
NetGamePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5c15
	ret ; $5c18
NetGamePractice1Hook_PointStart:
	xor a, a ; $5c19
	ld [$c2e1], a ; $5c1a
	ld a, $0a ; $5c1d
	ld [$c2e0], a ; $5c1f
	xor a, a ; $5c22
	ld [$c2ed], a ; $5c23
	ld a, $01 ; $5c26
	ld [wTargetZoneEnabled], a ; $5c28
	ld hl, $5cd7 ; $5c2b
	call SetDrillTargetZoneForPoint ; $5c2e
	ld a, $40 ; $5c31
	call LoadDrillOpponentChar ; $5c33
	xor a, a ; $5c36
	ld [$c2e6], a ; $5c37
	xor a, a ; $5c3a
	ld [$c2ff], a ; $5c3b
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c3e
	ld hl, Table_0b_5c4e ; $5c41
	add a, l ; $5c44
	ld l, a ; $5c45
	jr nc, .read ; $5c46
	inc h ; $5c48
.read:
	ld a, [hl] ; $5c49
	ld [$c7b5], a ; $5c4a
	ret ; $5c4d
Table_0b_5c4e:
	; $5c4e, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
NetGamePractice1Hook_PointEnd:
	call Drill09JudgePointMode0 ; $5c52
	ld a, [wPointOutcome] ; $5c55
	cp a, $04 ; $5c58
	jr z, .step ; $5c5a
	cp a, $05 ; $5c5c
	jr z, .step ; $5c5e
	jr .netGamePractice1HandlePointEnd ; $5c60
.step:
	ld hl, $c2e9 ; $5c62
	inc [hl] ; $5c65
.netGamePractice1HandlePointEnd:
	call NetGamePractice1HandlePointEnd ; $5c66
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c69
	cp a, $04 ; $5c6c
	ret c ; $5c6e
	call NetGamePractice1EvaluateResult ; $5c6f
	ld [wPointWinLoseFlag], a ; $5c72
	ret ; $5c75
NetGamePractice1EvaluateResult:
	ld a, [$c2eb] ; $5c76
	cp a, $04 ; $5c79
	jr nz, .checkCharacter1DoubleFaults ; $5c7b
	xor a, a ; $5c7d
	ld [$c2e3], a ; $5c7e
	ld a, $01 ; $5c81
	ret ; $5c83
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5c84
	cp a, $04 ; $5c87
	jr nz, .compare ; $5c89
	ld a, $01 ; $5c8b
	ld [$c2e3], a ; $5c8d
	jr .notFound ; $5c90
.compare:
	or a, a ; $5c92
	jr z, .zero ; $5c93
	ld a, $02 ; $5c95
	ld [$c2e3], a ; $5c97
	jr .notFound ; $5c9a
.zero:
	ld a, [$c2eb] ; $5c9c
	cp a, $03 ; $5c9f
	jr nz, .ne03 ; $5ca1
	ld a, $05 ; $5ca3
	ld [$c2e3], a ; $5ca5
	jr .notFound ; $5ca8
.ne03:
	ld a, [$c2ec] ; $5caa
	or a, a ; $5cad
	jr nz, .nonZero ; $5cae
	ld a, $04 ; $5cb0
	ld [$c2e3], a ; $5cb2
	jr .notFound ; $5cb5
.nonZero:
	ld a, $03 ; $5cb7
	ld [$c2e3], a ; $5cb9
	jr .notFound ; $5cbc
.notFound:
	ld a, $ff ; $5cbe
	ret ; $5cc0
NetGamePractice1Hook_RallyTick:
	call StubNop_0b_5d63 ; $5cc1
	ret ; $5cc4
NetGamePractice1Hook_Bounce:
	call Drill09JudgePointMode2 ; $5cc5
	ret ; $5cc8
NetGamePractice1Hook_BallHit:
	call Drill09JudgePointMode1 ; $5cc9
	ld a, [wLastShotCharIndex] ; $5ccc
	cp a, $01 ; $5ccf
	jr nz, .done ; $5cd1
	call ResetActiveCharState ; $5cd3
.done:
	ret ; $5cd6
	; $5cd7, 34 bytes (records:2)
	dw $0000 ; record 0
	dw $fb20 ; record 1
	dw $01b0 ; record 2
	dw $feb0 ; record 3
	dw $fe50 ; record 4
	dw $fb20 ; record 5
	dw $0000 ; record 6
	dw $feb0 ; record 7
	dw $fe50 ; record 8
	dw $0150 ; record 9
	dw $0000 ; record 10
	dw $04e0 ; record 11
	dw $0000 ; record 12
	dw $0150 ; record 13
	dw $01b0 ; record 14
	dw $04e0 ; record 15
	dw $ffff ; record 16
NetGamePractice1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5cf9
	ld a, [$c2ff] ; $5cfc
	ld [wPointWinLoseFlag], a ; $5cff
	cp a, $01 ; $5d02
	jr nz, .recordDrillPointResultBits ; $5d04
	ld hl, $c2eb ; $5d06
	inc [hl] ; $5d09
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $5d0a
	call ShowQueuedDrillMessage ; $5d0d
	farcall UpdatePointStats ; $5d10
	farcall AwardPoint ; $5d13
	ld a, [$c2eb] ; $5d16
	ld [wPlayer1PointsWon], a ; $5d19
	xor a, a ; $5d1c
	ld [wPlayer2PointsWon], a ; $5d1d
	ld a, [wPlayer1PointsWon] ; $5d20
	ld b, $01 ; $5d23
	farcall LoadPlayer1PointsDigitGfx ; $5d25
	ld a, [wPlayer2PointsWon] ; $5d28
	ld b, $01 ; $5d2b
	farcall LoadPlayer2PointsDigitGfx ; $5d2d
	farcall StepMatchFrame ; $5d30
	ld a, $01 ; $5d33
	ld hl, SyncPointWinLoseFlagTask ; $5d35
	call RegisterFrameTask ; $5d38
	farcall StartPointEndReactions ; $5d3b
	ld hl, SyncPointWinLoseFlagTask ; $5d3e
	call UnregisterFrameTask ; $5d41
	call PlayDrillPointEndSequence ; $5d44
	ret ; $5d47
Drill09JudgePointMode0:
	ld a, $00 ; $5d48
	call NetGamePractice1JudgePoint ; $5d4a
	ld [$c2ff], a ; $5d4d
	ret ; $5d50
Drill09JudgePointMode1:
	ld a, $01 ; $5d51
	call NetGamePractice1JudgePoint ; $5d53
	ld [$c2ff], a ; $5d56
	ret ; $5d59
Drill09JudgePointMode2:
	ld a, $02 ; $5d5a
	call NetGamePractice1JudgePoint ; $5d5c
	ld [$c2ff], a ; $5d5f
	ret ; $5d62
StubNop_0b_5d63:
	ret ; $5d63
	ld a, $03 ; $5d64
	call NetGamePractice1JudgePoint ; $5d66
	ld [$c2ff], a ; $5d69
	ret ; $5d6c
NetGamePractice1JudgePoint:
	ld b, a ; $5d6d
	ld a, [$c2ff] ; $5d6e
	or a, a ; $5d71
	ret nz ; $5d72
	ld a, [wRallyLength] ; $5d73
	dec a ; $5d76
	ld a, a ; $5d77
	rst Rst00 ; $5d78
	dw NetGamePractice1JudgePoint.rally1 ; $5d79 jumptable
	dw NetGamePractice1Cases1.step3 ; $5d7b jumptable
	dw NetGamePractice1Cases2.step3 ; $5d7d jumptable
.rally1:
	ld a, b ; $5d7f
	ld a, a ; $5d80
	rst Rst00 ; $5d81
	dw NetGamePractice1JudgePoint.result0 ; $5d82 jumptable
	dw NetGamePractice1Cases1 ; $5d84 jumptable
	dw NetGamePractice1Cases1.step ; $5d86 jumptable
	dw NetGamePractice1Cases1.step2 ; $5d88 jumptable
.result0:
	ld a, [wPointOutcome] ; $5d8a
	ld hl, SignedTable_0b_5da9 ; $5d8d
	add a, l ; $5d90
	ld l, a ; $5d91
	jr nc, .readEntry1 ; $5d92
	inc h ; $5d94
.readEntry1:
	ld a, [hl] ; $5d95
	ld a, a ; $5d96
	ld b, $00 ; $5d97
	call QueueDrillResultMessage ; $5d99
	ld a, [wPointOutcome] ; $5d9c
	ld hl, SignedTable_0b_46f1 ; $5d9f
	add a, l ; $5da2
	ld l, a ; $5da3
	jr nc, .readEntry2 ; $5da4
	inc h ; $5da6
.readEntry2:
	ld a, [hl] ; $5da7
	ret ; $5da8
SignedTable_0b_5da9:
	; $5da9, 10 bytes (bytes:10)
	db $ff, $ff, $33, $ff, $ff, $38, $31, $ff, $ff, $31 ; 0x00
NetGamePractice1Cases1:
	xor a, a ; $5db3
	ret ; $5db4
.step:
	xor a, a ; $5db5
	ret ; $5db6
.step2:
	xor a, a ; $5db7
	ret ; $5db8
.step3:
	ld a, b ; $5db9
	ld a, a ; $5dba
	rst Rst00 ; $5dbb
	dw NetGamePractice1Cases1.checkPointOutcome ; $5dbc jumptable
	dw NetGamePractice1Cases2 ; $5dbe jumptable
	dw NetGamePractice1Cases2.step ; $5dc0 jumptable
	dw NetGamePractice1Cases2.step2 ; $5dc2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5dc4
	ld hl, SignedTable_0b_5de3 ; $5dc7
	add a, l ; $5dca
	ld l, a ; $5dcb
	jr nc, .read ; $5dcc
	inc h ; $5dce
.read:
	ld a, [hl] ; $5dcf
	ld a, a ; $5dd0
	ld b, $00 ; $5dd1
	call QueueDrillResultMessage ; $5dd3
	ld a, [wPointOutcome] ; $5dd6
	ld hl, SignedTable_0b_46fb ; $5dd9
	add a, l ; $5ddc
	ld l, a ; $5ddd
	jr nc, .readB ; $5dde
	inc h ; $5de0
.readB:
	ld a, [hl] ; $5de1
	ret ; $5de2
SignedTable_0b_5de3:
	; $5de3, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $31, $31, $3a, $31, $31, $3a ; 0x00
NetGamePractice1Cases2:
	xor a, a ; $5ded
	ret ; $5dee
.step:
	xor a, a ; $5def
	ret ; $5df0
.step2:
	xor a, a ; $5df1
	ret ; $5df2
.step3:
	ld a, b ; $5df3
	ld a, a ; $5df4
	rst Rst00 ; $5df5
	dw NetGamePractice1Cases2.checkPointOutcome ; $5df6 jumptable
	dw NetGamePractice1Cases3 ; $5df8 jumptable
	dw NetGamePractice1Cases3.checkBallBounceCount ; $5dfa jumptable
	dw NetGamePractice1Cases3.step2 ; $5dfc jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5dfe
	ld hl, SignedTable_0b_5e27 ; $5e01
	add a, l ; $5e04
	ld l, a ; $5e05
	jr nc, .read ; $5e06
	inc h ; $5e08
.read:
	ld a, [hl] ; $5e09
	ld a, a ; $5e0a
	ld b, $00 ; $5e0b
	call QueueDrillResultMessage ; $5e0d
	ld a, [wPointOutcome] ; $5e10
	ld hl, SignedTable_0b_5e1d ; $5e13
	add a, l ; $5e16
	ld l, a ; $5e17
	jr nc, .readB ; $5e18
	inc h ; $5e1a
.readB:
	ld a, [hl] ; $5e1b
	ret ; $5e1c
SignedTable_0b_5e1d:
	; $5e1d, 10 bytes (bytes:10)
	db $00, $00, $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
SignedTable_0b_5e27:
	; $5e27, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $38, $38, $38, $ff, $ff, $38 ; 0x00
NetGamePractice1Cases3:
	ld a, $35 ; $5e31
	ld b, $00 ; $5e33
	call QueueDrillResultMessage ; $5e35
	xor a, a ; $5e38
	call TestCharStateBit4 ; $5e39
	or a, a ; $5e3c
	jp z, .storeMatchAbortFlag ; $5e3d
	ld a, $3a ; $5e40
	ld b, $00 ; $5e42
	call QueueDrillResultMessage ; $5e44
	ld a, [$c4a1] ; $5e47
	cp a, $01 ; $5e4a
	jp nz, .storeMatchAbortFlag ; $5e4c
	ld hl, $c2ec ; $5e4f
	dec [hl] ; $5e52
	xor a, a ; $5e53
	ret ; $5e54
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $5e55
	cp a, $01 ; $5e58
	ld a, $00 ; $5e5a
	ret nz ; $5e5c
	ld a, [wPointOutcome] ; $5e5d
	cp a, $04 ; $5e60
	jr z, .eq04 ; $5e62
	ld a, $2e ; $5e64
	ld b, $00 ; $5e66
	call QueueDrillResultMessage ; $5e68
	call RecordDrillTargetZoneHit ; $5e6b
	call CheckDrillTargetZoneMissed ; $5e6e
	or a, a ; $5e71
	jp nz, .nonZero ; $5e72
.eq04:
	ld a, $38 ; $5e75
	ld b, $00 ; $5e77
	call QueueDrillResultMessage ; $5e79
	ld hl, $c2ea ; $5e7c
	inc [hl] ; $5e7f
	jp .storeMatchAbortFlag ; $5e80
.step2:
	xor a, a ; $5e83
	ret ; $5e84
.nonZero:
	ld a, $01 ; $5e85
	ld [wMatchAbortFlag], a ; $5e87
	ld a, $01 ; $5e8a
	ret ; $5e8c
.storeMatchAbortFlag:
	ld a, $01 ; $5e8d
	ld [wMatchAbortFlag], a ; $5e8f
	ld a, $ff ; $5e92
	ret ; $5e94
NetGamePractice2Drill:
	; $5e95, 16 bytes (drill_definition)
	db $41, $09, $02, $05, $0a, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGamePractice2Hooks, PracticeDrillPointTable, NetGamePractice2DrillInit ; mode hooks, point table, init
	db $00, $00
NetGamePractice2DrillInit:
	ld a, $01 ; $5ea5
	ld [$c7bb], a ; $5ea7
	ret ; $5eaa
NetGamePractice2Hooks:
	call $d15e ; $5eab
	ld e, [hl] ; $5eae
	ld a, [$bb5e] ; $5eaf
	ld e, [hl] ; $5eb2
	add a, e ; $5eb3
	ld e, a ; $5eb4
	ld a, a ; $5eb5
	ld e, a ; $5eb6
	ld a, e ; $5eb7
	ld e, a ; $5eb8
	xor a, [hl] ; $5eb9
	inc bc ; $5eba
NetGamePractice2Hook_MinigameStart:
	xor a, a ; $5ebb
	ld [$c2ea], a ; $5ebc
	ld [$c2eb], a ; $5ebf
	ld a, $04 ; $5ec2
	ld [$c2ec], a ; $5ec4
	ld a, $01 ; $5ec7
	ld [$c7bb], a ; $5ec9
	ret ; $5ecc
NetGamePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5ecd
	ret ; $5ed0
NetGamePractice2Hook_PointStart:
	xor a, a ; $5ed1
	ld [$c2e1], a ; $5ed2
	ld a, $0a ; $5ed5
	ld [$c2e0], a ; $5ed7
	xor a, a ; $5eda
	ld [$c2e8], a ; $5edb
	ld [$c2ed], a ; $5ede
	ld a, $01 ; $5ee1
	ld [wTargetZoneEnabled], a ; $5ee3
	ld hl, DrillPositions_0b_5f91 ; $5ee6
	call SetDrillTargetZoneForPoint ; $5ee9
	ld a, $41 ; $5eec
	call LoadDrillOpponentChar ; $5eee
	xor a, a ; $5ef1
	ld [$c2e6], a ; $5ef2
	xor a, a ; $5ef5
	ld [$c2ff], a ; $5ef6
	ret ; $5ef9
NetGamePractice2Hook_PointEnd:
	call NetGamePractice2JudgeShot0 ; $5efa
	ld a, [wPointOutcome] ; $5efd
	cp a, $04 ; $5f00
	jr z, .step ; $5f02
	cp a, $05 ; $5f04
	jr z, .step ; $5f06
	jr .netGamePractice2HandlePointEnd ; $5f08
.step:
	ld hl, $c2ea ; $5f0a
	inc [hl] ; $5f0d
.netGamePractice2HandlePointEnd:
	call NetGamePractice2HandlePointEnd ; $5f0e
	ld a, [wTotalPointsScoredInCurrentGame] ; $5f11
	cp a, $04 ; $5f14
	ret c ; $5f16
	call NetGamePractice2EvaluateResult ; $5f17
	ld [wPointWinLoseFlag], a ; $5f1a
	ret ; $5f1d
NetGamePractice2EvaluateResult:
	ld a, [$c2eb] ; $5f1e
	cp a, $04 ; $5f21
	jr nz, .checkCharacter1DoubleFaults ; $5f23
	xor a, a ; $5f25
	ld [$c2e3], a ; $5f26
	ld a, $01 ; $5f29
	ret ; $5f2b
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5f2c
	cp a, $04 ; $5f2f
	jr nz, .compare ; $5f31
	ld a, $01 ; $5f33
	ld [$c2e3], a ; $5f35
	jr .notFound ; $5f38
.compare:
	or a, a ; $5f3a
	jr z, .zero ; $5f3b
	ld a, $02 ; $5f3d
	ld [$c2e3], a ; $5f3f
	jr .notFound ; $5f42
.zero:
	ld a, [$c2eb] ; $5f44
	cp a, $03 ; $5f47
	jr nz, .ne03 ; $5f49
	ld a, $06 ; $5f4b
	ld [$c2e3], a ; $5f4d
	jr .notFound ; $5f50
.ne03:
	ld a, [$c2ec] ; $5f52
	or a, a ; $5f55
	jr nz, .nonZero ; $5f56
	ld a, $05 ; $5f58
	ld [$c2e3], a ; $5f5a
	jr .notFound ; $5f5d
.nonZero:
	ld a, [$c2eb] ; $5f5f
	cp a, $01 ; $5f62
	jr c, .step4 ; $5f64
	cp a, $03 ; $5f66
	jr nc, .step4 ; $5f68
	ld a, $04 ; $5f6a
	ld [$c2e3], a ; $5f6c
	jr .notFound ; $5f6f
.step4:
	ld a, $03 ; $5f71
	ld [$c2e3], a ; $5f73
	jr .notFound ; $5f76
.notFound:
	ld a, $ff ; $5f78
	ret ; $5f7a
NetGamePractice2Hook_RallyTick:
	call NetGamePractice2JudgeShot3 ; $5f7b
	ret ; $5f7e
NetGamePractice2Hook_Bounce:
	call NetGamePractice2JudgeShot2 ; $5f7f
	ret ; $5f82
NetGamePractice2Hook_BallHit:
	call NetGamePractice2JudgeShot1 ; $5f83
	ld a, [wLastShotCharIndex] ; $5f86
	cp a, $01 ; $5f89
	jr nz, .done ; $5f8b
	call ResetActiveCharState ; $5f8d
.done:
	ret ; $5f90
DrillPositions_0b_5f91:
	; $5f91, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $fe50, $fd60 ; record 0
	dw $0000, $fe40 ; record 1
	dw $0000, $fd60 ; record 2
	dw $01b0, $fe40 ; record 3
	dw $0000, $01c0 ; record 4
	dw $01b0, $02a0 ; record 5
	dw $fe50, $01c0 ; record 6
	dw $0000, $02a0 ; record 7
	db $ff, $ff
NetGamePractice2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5fb3
	ld a, [$c2ff] ; $5fb6
	ld [wPointWinLoseFlag], a ; $5fb9
	cp a, $01 ; $5fbc
	jr nz, .recordDrillPointResultBits ; $5fbe
	ld hl, $c2eb ; $5fc0
	inc [hl] ; $5fc3
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $5fc4
	call ShowQueuedDrillMessage ; $5fc7
	farcall UpdatePointStats ; $5fca
	farcall AwardPoint ; $5fcd
	ld a, [$c2eb] ; $5fd0
	ld [wPlayer1PointsWon], a ; $5fd3
	xor a, a ; $5fd6
	ld [wPlayer2PointsWon], a ; $5fd7
	ld a, [wPlayer1PointsWon] ; $5fda
	ld b, $01 ; $5fdd
	farcall LoadPlayer1PointsDigitGfx ; $5fdf
	ld a, [wPlayer2PointsWon] ; $5fe2
	ld b, $01 ; $5fe5
	farcall LoadPlayer2PointsDigitGfx ; $5fe7
	farcall StepMatchFrame ; $5fea
	ld a, $01 ; $5fed
	ld hl, SyncPointWinLoseFlagTask ; $5fef
	call RegisterFrameTask ; $5ff2
	farcall StartPointEndReactions ; $5ff5
	ld hl, SyncPointWinLoseFlagTask ; $5ff8
	call UnregisterFrameTask ; $5ffb
	call PlayDrillPointEndSequence ; $5ffe
	ret ; $6001
NetGamePractice2JudgeShot0:
	ld a, $00 ; $6002
	call NetGamePractice2JudgePoint ; $6004
	ld [$c2ff], a ; $6007
	ret ; $600a
NetGamePractice2JudgeShot1:
	ld a, $01 ; $600b
	call NetGamePractice2JudgePoint ; $600d
	ld [$c2ff], a ; $6010
	ret ; $6013
NetGamePractice2JudgeShot2:
	ld a, $02 ; $6014
	call NetGamePractice2JudgePoint ; $6016
	ld [$c2ff], a ; $6019
	ret ; $601c
NetGamePractice2JudgeShot3:
	ret ; $601d
	ld a, $03 ; $601e
	call NetGamePractice2JudgePoint ; $6020
	ld [$c2ff], a ; $6023
	ret ; $6026
NetGamePractice2JudgePoint:
	ld b, a ; $6027
	ld a, [$c2ff] ; $6028
	or a, a ; $602b
	ret nz ; $602c
	ld a, [wRallyLength] ; $602d
	dec a ; $6030
	ld a, a ; $6031
	rst Rst00 ; $6032
	dw NetGamePractice2JudgePoint.rally1 ; $6033 jumptable
	dw NetGamePractice2Cases1.step2 ; $6035 jumptable
	dw NetGamePractice2Cases2.step3 ; $6037 jumptable
.rally1:
	ld a, b ; $6039
	ld a, a ; $603a
	rst Rst00 ; $603b
	dw NetGamePractice2JudgePoint.result0 ; $603c jumptable
	dw NetGamePractice2Cases1 ; $603e jumptable
	dw NetGamePractice2Cases1.checkBallBounceCount ; $6040 jumptable
	dw NetGamePractice2Cases1.step ; $6042 jumptable
.result0:
	ld a, [wPointOutcome] ; $6044
	ld hl, DrillShotTable_0b_6063 ; $6047
	add a, l ; $604a
	ld l, a ; $604b
	jr nc, .readEntry1 ; $604c
	inc h ; $604e
.readEntry1:
	ld a, [hl] ; $604f
	ld a, a ; $6050
	ld b, $00 ; $6051
	call QueueDrillResultMessage ; $6053
	ld a, [wPointOutcome] ; $6056
	ld hl, SignedTable_0b_46f1 ; $6059
	add a, l ; $605c
	ld l, a ; $605d
	jr nc, .readEntry2 ; $605e
	inc h ; $6060
.readEntry2:
	ld a, [hl] ; $6061
	ret ; $6062
DrillShotTable_0b_6063:
	; $6063, 10 bytes (bytes:10)
	db $ff, $ff, $33, $ff, $ff, $3b, $31, $ff, $ff, $31 ; 0x00
NetGamePractice2Cases1:
	xor a, a ; $606d
	ret ; $606e
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $606f
	cp a, $01 ; $6072
	ld a, $00 ; $6074
	ret nz ; $6076
	ld a, [wBallHasBouncedFlag] ; $6077
	or a, a ; $607a
	ld a, $00 ; $607b
	ret nz ; $607d
	ld a, [wPointOutcome] ; $607e
	cp a, $05 ; $6081
	ld a, $00 ; $6083
	ret z ; $6085
	ld a, [wPointOutcome] ; $6086
	cp a, $02 ; $6089
	ld a, $00 ; $608b
	ret z ; $608d
	ld a, $3b ; $608e
	ld b, $00 ; $6090
	call QueueDrillResultMessage ; $6092
	call RecordDrillTargetZoneHit ; $6095
	call CheckDrillTargetZoneMissed ; $6098
	or a, a ; $609b
	jp z, NetGamePractice2Cases3.ne09 ; $609c
	xor a, a ; $609f
	ret ; $60a0
.step:
	xor a, a ; $60a1
	ret ; $60a2
.step2:
	ld a, b ; $60a3
	ld a, a ; $60a4
	rst Rst00 ; $60a5
	dw NetGamePractice2Cases1.checkPointOutcome ; $60a6 jumptable
	dw NetGamePractice2Cases2 ; $60a8 jumptable
	dw NetGamePractice2Cases2.step ; $60aa jumptable
	dw NetGamePractice2Cases2.step2 ; $60ac jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $60ae
	ld hl, DrillShotTable_0b_60cd ; $60b1
	add a, l ; $60b4
	ld l, a ; $60b5
	jr nc, .read ; $60b6
	inc h ; $60b8
.read:
	ld a, [hl] ; $60b9
	ld a, a ; $60ba
	ld b, $00 ; $60bb
	call QueueDrillResultMessage ; $60bd
	ld a, [wPointOutcome] ; $60c0
	ld hl, SignedTable_0b_46fb ; $60c3
	add a, l ; $60c6
	ld l, a ; $60c7
	jr nc, .readB ; $60c8
	inc h ; $60ca
.readB:
	ld a, [hl] ; $60cb
	ret ; $60cc
DrillShotTable_0b_60cd:
	; $60cd, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $31, $31, $36, $31, $31, $36 ; 0x00
NetGamePractice2Cases2:
	ld a, [wBallBounceCount] ; $60d7
	or a, a ; $60da
	ret z ; $60db
	ld a, $32 ; $60dc
	ld b, $00 ; $60de
	call QueueDrillResultMessage ; $60e0
	ld a, [wCurrentShotType] ; $60e3
	cp a, $0a ; $60e6
	jp nz, NetGamePractice2Cases3.storeMatchAbortFlag ; $60e8
	xor a, a ; $60eb
	ret ; $60ec
.step:
	xor a, a ; $60ed
	ret ; $60ee
.step2:
	xor a, a ; $60ef
	ret ; $60f0
.step3:
	ld a, b ; $60f1
	ld a, a ; $60f2
	rst Rst00 ; $60f3
	dw NetGamePractice2Cases2.checkPointOutcome ; $60f4 jumptable
	dw NetGamePractice2Cases3 ; $60f6 jumptable
	dw NetGamePractice2Cases3.step ; $60f8 jumptable
	dw NetGamePractice2Cases3.step2 ; $60fa jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $60fc
	ld hl, DrillShotTable_0b_611b ; $60ff
	add a, l ; $6102
	ld l, a ; $6103
	jr nc, .read ; $6104
	inc h ; $6106
.read:
	ld a, [hl] ; $6107
	ld a, a ; $6108
	ld b, $00 ; $6109
	call QueueDrillResultMessage ; $610b
	ld a, [wPointOutcome] ; $610e
	ld hl, SignedTable_0b_46f1 ; $6111
	add a, l ; $6114
	ld l, a ; $6115
	jr nc, .readB ; $6116
	inc h ; $6118
.readB:
	ld a, [hl] ; $6119
	ret ; $611a
DrillShotTable_0b_611b:
	; $611b, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $37, $37, $2f, $ff, $ff, $2f ; 0x00
NetGamePractice2Cases3:
	ld a, $36 ; $6125
	ld b, $00 ; $6127
	call QueueDrillResultMessage ; $6129
	ld a, [wCurrentShotType] ; $612c
	cp a, $09 ; $612f
	jp nz, .ne09 ; $6131
	ld hl, $c2ec ; $6134
	dec [hl] ; $6137
	xor a, a ; $6138
	ret ; $6139
.step:
	xor a, a ; $613a
	ret ; $613b
.step2:
	xor a, a ; $613c
	ret ; $613d
.storeMatchAbortFlag:
	ld a, $01 ; $613e
	ld [wMatchAbortFlag], a ; $6140
	ld a, $01 ; $6143
	ret ; $6145
.ne09:
	ld a, $01 ; $6146
	ld [wMatchAbortFlag], a ; $6148
	ld a, $ff ; $614b
	ret ; $614d
NetGamePractice3Drill:
	; $614e, 16 bytes (drill_definition)
	db $42, $09, $02, $05, $0b, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw NetGamePractice3Hooks, PracticeDrillPointTable, NetGamePractice3DrillInit ; mode hooks, point table, init
	db $00, $00
NetGamePractice3DrillInit:
	ld a, $01 ; $615e
	ld [$c7bb], a ; $6160
	ret ; $6163
NetGamePractice3Hooks:
	; $6164, 16 bytes (mode_hooks)
	dw NetGamePractice3Hook_PerFrame ; record 0
	dw NetGamePractice3Hook_PointStart ; record 1
	dw NetGamePractice3Hook_PointEnd ; record 2
	dw NetGamePractice3Hook_MinigameStart ; record 3
	dw NetGamePractice3Hook_BallHit ; record 4
	dw NetGamePractice3Hook_Bounce ; record 5
	dw NetGamePractice3Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGamePractice3Hook_MinigameStart:
	xor a, a ; $6174
	ld [$c2ea], a ; $6175
	ld [$c2eb], a ; $6178
	ld a, $04 ; $617b
	ld [$c2ec], a ; $617d
	ld a, $01 ; $6180
	ld [$c7bb], a ; $6182
	ret ; $6185
NetGamePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6186
	ret ; $6189
NetGamePractice3Hook_PointStart:
	xor a, a ; $618a
	ld [$c2e1], a ; $618b
	ld a, $0a ; $618e
	ld [$c2e0], a ; $6190
	ld a, $01 ; $6193
	ld [wTargetZoneEnabled], a ; $6195
	ld hl, DrillPositions_0b_6250 ; $6198
	call SetDrillTargetZoneForPoint ; $619b
	ld a, $42 ; $619e
	call LoadDrillOpponentChar ; $61a0
	xor a, a ; $61a3
	ld [$c2e6], a ; $61a4
	xor a, a ; $61a7
	ld [$c2ff], a ; $61a8
	ret ; $61ab
NetGamePractice3Hook_PointEnd:
	call NetGamePractice3JudgeShot0 ; $61ac
	ld a, [wPointOutcome] ; $61af
	cp a, $04 ; $61b2
	jr z, .step ; $61b4
	cp a, $05 ; $61b6
	jr z, .step ; $61b8
	jr .netGamePractice3HandlePointEnd ; $61ba
.step:
	ld hl, $c2ea ; $61bc
	inc [hl] ; $61bf
.netGamePractice3HandlePointEnd:
	call NetGamePractice3HandlePointEnd ; $61c0
	ld a, [wTotalPointsScoredInCurrentGame] ; $61c3
	cp a, $04 ; $61c6
	ret c ; $61c8
	call NetGamePractice3EvaluateResult ; $61c9
	ld [wPointWinLoseFlag], a ; $61cc
	ret ; $61cf
NetGamePractice3EvaluateResult:
	ld a, [$c2eb] ; $61d0
	cp a, $04 ; $61d3
	jr nz, .checkCharacter1DoubleFaults ; $61d5
	xor a, a ; $61d7
	ld [$c2e3], a ; $61d8
	ld a, $01 ; $61db
	ret ; $61dd
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $61de
	cp a, $04 ; $61e1
	jr nz, .compare ; $61e3
	ld a, $01 ; $61e5
	ld [$c2e3], a ; $61e7
	jr .notFound ; $61ea
.compare:
	or a, a ; $61ec
	jr z, .zero ; $61ed
	ld a, $02 ; $61ef
	ld [$c2e3], a ; $61f1
	jr .notFound ; $61f4
.zero:
	ld a, [$c2eb] ; $61f6
	cp a, $03 ; $61f9
	jr nz, .countDrillResultBitsSet ; $61fb
	ld a, $07 ; $61fd
	ld [$c2e3], a ; $61ff
	jr .notFound ; $6202
.countDrillResultBitsSet:
	call CountDrillResultBitsSet ; $6204
	or a, a ; $6207
	jr z, .zero2 ; $6208
	ld a, $03 ; $620a
	ld [$c2e3], a ; $620c
	jr .notFound ; $620f
.zero2:
	ld a, [$c2ec] ; $6211
	or a, a ; $6214
	jr nz, .nonZero ; $6215
	ld a, $06 ; $6217
	ld [$c2e3], a ; $6219
	jr .notFound ; $621c
.nonZero:
	ld a, [$c2eb] ; $621e
	cp a, $01 ; $6221
	jr c, .step4 ; $6223
	cp a, $03 ; $6225
	jr nc, .step4 ; $6227
	ld a, $05 ; $6229
	ld [$c2e3], a ; $622b
	jr .notFound ; $622e
.step4:
	ld a, $04 ; $6230
	ld [$c2e3], a ; $6232
	jr .notFound ; $6235
.notFound:
	ld a, $ff ; $6237
	ret ; $6239
NetGamePractice3Hook_RallyTick:
	call NetGamePractice3JudgeShot3 ; $623a
	ret ; $623d
NetGamePractice3Hook_Bounce:
	call NetGamePractice3JudgeShot2 ; $623e
	ret ; $6241
NetGamePractice3Hook_BallHit:
	call NetGamePractice3JudgeShot1 ; $6242
	ld a, [wLastShotCharIndex] ; $6245
	cp a, $01 ; $6248
	jr nz, .done ; $624a
	call ResetActiveCharState ; $624c
.done:
	ret ; $624f
DrillPositions_0b_6250:
	; $6250, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $fe50, $fd60 ; record 0
	dw $0000, $fe40 ; record 1
	dw $0000, $fd60 ; record 2
	dw $01b0, $fe40 ; record 3
	dw $0000, $01c0 ; record 4
	dw $01b0, $02a0 ; record 5
	dw $fe50, $01c0 ; record 6
	dw $0000, $02a0 ; record 7
	db $ff, $ff
NetGamePractice3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6272
	ld a, [$c2ff] ; $6275
	ld [wPointWinLoseFlag], a ; $6278
	cp a, $01 ; $627b
	jr nz, .recordDrillPointResultBits ; $627d
	ld hl, $c2eb ; $627f
	inc [hl] ; $6282
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $6283
	call ShowQueuedDrillMessage ; $6286
	farcall UpdatePointStats ; $6289
	farcall AwardPoint ; $628c
	ld a, [$c2eb] ; $628f
	ld [wPlayer1PointsWon], a ; $6292
	xor a, a ; $6295
	ld [wPlayer2PointsWon], a ; $6296
	ld a, [wPlayer1PointsWon] ; $6299
	ld b, $01 ; $629c
	farcall LoadPlayer1PointsDigitGfx ; $629e
	ld a, [wPlayer2PointsWon] ; $62a1
	ld b, $01 ; $62a4
	farcall LoadPlayer2PointsDigitGfx ; $62a6
	farcall StepMatchFrame ; $62a9
	ld a, $01 ; $62ac
	ld hl, SyncPointWinLoseFlagTask ; $62ae
	call RegisterFrameTask ; $62b1
	farcall StartPointEndReactions ; $62b4
	ld hl, SyncPointWinLoseFlagTask ; $62b7
	call UnregisterFrameTask ; $62ba
	call PlayDrillPointEndSequence ; $62bd
	ret ; $62c0
NetGamePractice3JudgeShot0:
	ld a, $00 ; $62c1
	call NetGamePractice3JudgePoint ; $62c3
	ld [$c2ff], a ; $62c6
	ret ; $62c9
NetGamePractice3JudgeShot1:
	ld a, $01 ; $62ca
	call NetGamePractice3JudgePoint ; $62cc
	ld [$c2ff], a ; $62cf
	ret ; $62d2
NetGamePractice3JudgeShot2:
	ld a, $02 ; $62d3
	call NetGamePractice3JudgePoint ; $62d5
	ld [$c2ff], a ; $62d8
	ret ; $62db
NetGamePractice3JudgeShot3:
	ret ; $62dc
	ld a, $03 ; $62dd
	call NetGamePractice3JudgePoint ; $62df
	ld [$c2ff], a ; $62e2
	ret ; $62e5
NetGamePractice3JudgePoint:
	ld b, a ; $62e6
	ld a, [$c2ff] ; $62e7
	or a, a ; $62ea
	ret nz ; $62eb
	ld a, [wRallyLength] ; $62ec
	dec a ; $62ef
	ld a, a ; $62f0
	rst Rst00 ; $62f1
	dw NetGamePractice3JudgePoint.rally1 ; $62f2 jumptable
	dw NetGamePractice3Cases1.step2 ; $62f4 jumptable
	dw NetGamePractice3Cases2.step3 ; $62f6 jumptable
.rally1:
	ld a, b ; $62f8
	ld a, a ; $62f9
	rst Rst00 ; $62fa
	dw NetGamePractice3JudgePoint.result0 ; $62fb jumptable
	dw NetGamePractice3Cases1 ; $62fd jumptable
	dw NetGamePractice3Cases1.checkBallBounceCount ; $62ff jumptable
	dw NetGamePractice3Cases1.step ; $6301 jumptable
.result0:
	ld a, [wPointOutcome] ; $6303
	ld hl, DrillShotTable_0b_6322 ; $6306
	add a, l ; $6309
	ld l, a ; $630a
	jr nc, .readEntry1 ; $630b
	inc h ; $630d
.readEntry1:
	ld a, [hl] ; $630e
	ld a, a ; $630f
	ld b, $00 ; $6310
	call QueueDrillResultMessage ; $6312
	ld a, [wPointOutcome] ; $6315
	ld hl, SignedTable_0b_46f1 ; $6318
	add a, l ; $631b
	ld l, a ; $631c
	jr nc, .readEntry2 ; $631d
	inc h ; $631f
.readEntry2:
	ld a, [hl] ; $6320
	ret ; $6321
DrillShotTable_0b_6322:
	; $6322, 10 bytes (bytes:10)
	db $ff, $ff, $33, $ff, $ff, $38, $31, $ff, $ff, $31 ; 0x00
NetGamePractice3Cases1:
	xor a, a ; $632c
	ret ; $632d
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $632e
	cp a, $01 ; $6331
	ld a, $00 ; $6333
	ret nz ; $6335
	ld a, [wBallHasBouncedFlag] ; $6336
	or a, a ; $6339
	ld a, $00 ; $633a
	ret nz ; $633c
	ld a, [wPointOutcome] ; $633d
	cp a, $05 ; $6340
	ld a, $00 ; $6342
	ret z ; $6344
	ld a, $3b ; $6345
	ld b, $00 ; $6347
	call QueueDrillResultMessage ; $6349
	call RecordDrillTargetZoneHit ; $634c
	call CheckDrillTargetZoneMissed ; $634f
	or a, a ; $6352
	jp z, NetGamePractice3Cases3.storeMatchAbortFlag ; $6353
	xor a, a ; $6356
	ret ; $6357
.step:
	xor a, a ; $6358
	ret ; $6359
.step2:
	ld a, b ; $635a
	ld a, a ; $635b
	rst Rst00 ; $635c
	dw NetGamePractice3Cases1.checkPointOutcome ; $635d jumptable
	dw NetGamePractice3Cases2 ; $635f jumptable
	dw NetGamePractice3Cases2.step ; $6361 jumptable
	dw NetGamePractice3Cases2.step2 ; $6363 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6365
	ld hl, DrillShotTable_0b_6384 ; $6368
	add a, l ; $636b
	ld l, a ; $636c
	jr nc, .read ; $636d
	inc h ; $636f
.read:
	ld a, [hl] ; $6370
	ld a, a ; $6371
	ld b, $00 ; $6372
	call QueueDrillResultMessage ; $6374
	ld a, [wPointOutcome] ; $6377
	ld hl, SignedTable_0b_46fb ; $637a
	add a, l ; $637d
	ld l, a ; $637e
	jr nc, .readB ; $637f
	inc h ; $6381
.readB:
	ld a, [hl] ; $6382
	ret ; $6383
DrillShotTable_0b_6384:
	; $6384, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $31, $31, $39, $31, $31, $39 ; 0x00
NetGamePractice3Cases2:
	xor a, a ; $638e
	ret ; $638f
.step:
	xor a, a ; $6390
	ret ; $6391
.step2:
	xor a, a ; $6392
	ret ; $6393
.step3:
	ld a, b ; $6394
	ld a, a ; $6395
	rst Rst00 ; $6396
	dw NetGamePractice3Cases2.checkPointOutcome ; $6397 jumptable
	dw NetGamePractice3Cases3 ; $6399 jumptable
	dw NetGamePractice3Cases3.step ; $639b jumptable
	dw NetGamePractice3Cases3.step2 ; $639d jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $639f
	ld hl, DrillShotTable_0b_63be ; $63a2
	add a, l ; $63a5
	ld l, a ; $63a6
	jr nc, .read ; $63a7
	inc h ; $63a9
.read:
	ld a, [hl] ; $63aa
	ld a, a ; $63ab
	ld b, $00 ; $63ac
	call QueueDrillResultMessage ; $63ae
	ld a, [wPointOutcome] ; $63b1
	ld hl, SignedTable_0b_46f1 ; $63b4
	add a, l ; $63b7
	ld l, a ; $63b8
	jr nc, .readB ; $63b9
	inc h ; $63bb
.readB:
	ld a, [hl] ; $63bc
	ret ; $63bd
DrillShotTable_0b_63be:
	; $63be, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3c, $3c, $30, $ff, $ff, $30 ; 0x00
NetGamePractice3Cases3:
	ld a, $35 ; $63c8
	ld b, $00 ; $63ca
	call QueueDrillResultMessage ; $63cc
	xor a, a ; $63cf
	call TestCharStateBit4 ; $63d0
	or a, a ; $63d3
	jp z, .storeMatchAbortFlag ; $63d4
	ld a, $39 ; $63d7
	ld b, $00 ; $63d9
	call QueueDrillResultMessage ; $63db
	ld a, [wCurrentShotType] ; $63de
	cp a, $0b ; $63e1
	jp nz, .storeMatchAbortFlag ; $63e3
	ld hl, $c2ec ; $63e6
	dec [hl] ; $63e9
	xor a, a ; $63ea
	ret ; $63eb
.step:
	xor a, a ; $63ec
	ret ; $63ed
.step2:
	xor a, a ; $63ee
	ret ; $63ef
	ld a, $01 ; $63f0
	ld [wMatchAbortFlag], a ; $63f2
	ld a, $01 ; $63f5
	ret ; $63f7
.storeMatchAbortFlag:
	ld a, $01 ; $63f8
	ld [wMatchAbortFlag], a ; $63fa
	ld a, $ff ; $63fd
	ret ; $63ff
StrokeMatch1Drill:
	; $6400, 16 bytes (drill_definition)
	db $43, $18, $02, $05, $0c, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokeMatch1Hooks, StrokeMatchPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
StrokeMatch1Hooks:
	; $6410, 16 bytes (mode_hooks)
	dw StrokeMatch1Hook_PerFrame ; record 0
	dw StrokeMatch1Hook_PointStart ; record 1
	dw StrokeMatch1Hook_PointEnd ; record 2
	dw StrokeMatch1Hook_MinigameStart ; record 3
	dw StrokeMatch1Hook_BallHit ; record 4
	dw StrokeMatch1Hook_Bounce ; record 5
	dw StrokeMatch1Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch1Hook_MinigameStart:
	ld a, $05 ; $6420
	ld [wScoreboardLayout], a ; $6422
	ret ; $6425
StrokeMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6426
	ret ; $6429
StrokeMatch1Hook_PointStart:
	xor a, a ; $642a
	ld [$c2e1], a ; $642b
	ld a, $0a ; $642e
	ld [$c2e0], a ; $6430
	xor a, a ; $6433
	ld [$c2e6], a ; $6434
	xor a, a ; $6437
	ld [$c2ff], a ; $6438
	ld a, $01 ; $643b
	ld [$c7a8], a ; $643d
	ret ; $6440
StrokeMatch1Hook_PointEnd:
	call StrokeMatch1JudgeShot0 ; $6441
	call StrokeMatch1HandlePointEnd ; $6444
	ld a, [wPlayer1PointsWon] ; $6447
	ld b, a ; $644a
	ld a, [wPlayer2PointsWon] ; $644b
	sub a, b ; $644e
	ld b, a ; $644f
	bit 7, a ; $6450
	jr z, .compare ; $6452
	cpl ; $6454
	inc a ; $6455
.compare:
	cp a, $02 ; $6456
	jr c, .checkTotalPointsScoredInCurrentGame ; $6458
	xor a, a ; $645a
	rl b ; $645b
	rl a ; $645d
	or a, a ; $645f
	jr nz, .store ; $6460
	ld a, $ff ; $6462
.store:
	ld [wPointWinLoseFlag], a ; $6464
	ld a, $80 ; $6467
	ld [wMatchAbortFlag], a ; $6469
	ret ; $646c
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $646d
	cp a, $08 ; $6470
	ret nz ; $6472
	xor a, a ; $6473
	ld [wPointWinLoseFlag], a ; $6474
	ld a, $80 ; $6477
	ld [wMatchAbortFlag], a ; $6479
	ret ; $647c
StrokeMatch1Hook_RallyTick:
	call StrokeMatch1JudgeShot3 ; $647d
	ret ; $6480
StrokeMatch1Hook_Bounce:
	call StrokeMatch1JudgeShot2 ; $6481
	ret ; $6484
StrokeMatch1Hook_BallHit:
	call StrokeMatch1JudgeShot1 ; $6485
	ret ; $6488
StrokeMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6489
	ld a, [$c2ff] ; $648c
	ld b, a ; $648f
	ld a, [wTotalPointsScoredInCurrentGame] ; $6490
	bit 0, a ; $6493
	ld a, b ; $6495
	jr z, .store ; $6496
	cpl ; $6498
	inc a ; $6499
.store:
	ld [wPointWinLoseFlag], a ; $649a
	call RecordDrillPointResultBits ; $649d
	call ShowQueuedDrillMessage ; $64a0
	farcall UpdatePointStats ; $64a3
	call StrokeMatch1AwardPointToSide ; $64a6
	ld a, [wPlayer1PointsWon] ; $64a9
	ld b, $01 ; $64ac
	farcall LoadPlayer1PointsDigitGfx ; $64ae
	ld a, [wPlayer2PointsWon] ; $64b1
	ld b, $01 ; $64b4
	farcall LoadPlayer2PointsDigitGfx ; $64b6
	farcall StepMatchFrame ; $64b9
	farcall StartPointEndReactions ; $64bc
	call PlayDrillPointEndSequence ; $64bf
	ret ; $64c2
StrokeMatch1AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $64c3
	or a, a ; $64c6
	ret z ; $64c7
	inc a ; $64c8
	srl a ; $64c9
	or a, a ; $64cb
	jr nz, .nonZero ; $64cc
	ld hl, wPlayer2PointsWon ; $64ce
	jr .bump ; $64d1
.nonZero:
	ld hl, wPlayer1PointsWon ; $64d3
.bump:
	inc [hl] ; $64d6
	xor a, a ; $64d7
	ld [wServeFaultFlag], a ; $64d8
	ld hl, wTotalPointsScoredInCurrentGame ; $64db
	inc [hl] ; $64de
	ret ; $64df
StrokeMatch1JudgeShot0:
	ld a, $00 ; $64e0
	call StrokeMatch1JudgePoint ; $64e2
	ld [$c2ff], a ; $64e5
	ret ; $64e8
StrokeMatch1JudgeShot1:
	ld a, $01 ; $64e9
	call StrokeMatch1JudgePoint ; $64eb
	ld [$c2ff], a ; $64ee
	ret ; $64f1
StrokeMatch1JudgeShot2:
	ld a, $02 ; $64f2
	call StrokeMatch1JudgePoint ; $64f4
	ld [$c2ff], a ; $64f7
	ret ; $64fa
StrokeMatch1JudgeShot3:
	ret ; $64fb
	ld a, $03 ; $64fc
	call StrokeMatch1JudgePoint ; $64fe
	ld [$c2ff], a ; $6501
	ret ; $6504
StrokeMatch1JudgePoint:
	ld b, a ; $6505
	ld a, [$c2ff] ; $6506
	or a, a ; $6509
	ret nz ; $650a
	ld a, [wRallyLength] ; $650b
	dec a ; $650e
	jp z, .branch13 ; $650f
	cp a, $01 ; $6512
	jp z, StrokeMatch1Cases1.eq01 ; $6514
	and a, $01 ; $6517
	jp z, StrokeMatch1Cases2.maskClear ; $6519
	jp StrokeMatch1Cases3.step2 ; $651c
.branch13:
	ld a, b ; $651f
	ld a, a ; $6520
	rst Rst00 ; $6521
	dw StrokeMatch1JudgePoint.rally1 ; $6522 jumptable
	dw StrokeMatch1Cases1 ; $6524 jumptable
	dw StrokeMatch1Cases1.step ; $6526 jumptable
	dw StrokeMatch1Cases1.step2 ; $6528 jumptable
.rally1:
	ld a, [wPointOutcome] ; $652a
	ld hl, DrillShotTable_0b_6549 ; $652d
	add a, l ; $6530
	ld l, a ; $6531
	jr nc, .readEntry1 ; $6532
	inc h ; $6534
.readEntry1:
	ld a, [hl] ; $6535
	ld a, a ; $6536
	ld b, $07 ; $6537
	call SetDrillMessageByRallyParity ; $6539
	call SelectStrokeTargetTableByPoint ; $653c
	ld a, [wPointOutcome] ; $653f
	add a, l ; $6542
	ld l, a ; $6543
	jr nc, .readEntry2 ; $6544
	inc h ; $6546
.readEntry2:
	ld a, [hl] ; $6547
	ret ; $6548
DrillShotTable_0b_6549:
	; $6549, 10 bytes (bytes:10)
	db $ff, $ff, $63, $ff, $ff, $ff, $60, $ff, $ff, $60 ; 0x00
StrokeMatch1Cases1:
	xor a, a ; $6553
	ret ; $6554
.step:
	xor a, a ; $6555
	ret ; $6556
.step2:
	xor a, a ; $6557
	ret ; $6558
.eq01:
	ld a, b ; $6559
	ld a, a ; $655a
	rst Rst00 ; $655b
	dw StrokeMatch1Cases1.checkPointOutcome ; $655c jumptable
	dw StrokeMatch1Cases2 ; $655e jumptable
	dw StrokeMatch1Cases2.checkPointOutcome ; $6560 jumptable
	dw StrokeMatch1Cases2.step ; $6562 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6564
	ld hl, DrillShotTable_0b_6583 ; $6567
	add a, l ; $656a
	ld l, a ; $656b
	jr nc, .read ; $656c
	inc h ; $656e
.read:
	ld a, [hl] ; $656f
	ld a, a ; $6570
	ld b, $07 ; $6571
	call SetDrillMessageByRallyParity ; $6573
	call SelectStrokeTargetTableByPointAlt ; $6576
	ld a, [wPointOutcome] ; $6579
	add a, l ; $657c
	ld l, a ; $657d
	jr nc, .readB ; $657e
	inc h ; $6580
.readB:
	ld a, [hl] ; $6581
	ret ; $6582
DrillShotTable_0b_6583:
	; $6583, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $60, $60, $5e, $64, $64, $60 ; 0x00
StrokeMatch1Cases2:
	ld a, [wBallBounceCount] ; $658d
	cp a, $01 ; $6590
	ret nz ; $6592
	ld a, $62 ; $6593
	ld b, $07 ; $6595
	call SetDrillMessageByRallyParity ; $6597
	ld a, [wLastShotCharIndex] ; $659a
	call TestCharStateBit4 ; $659d
	jp nz, StrokeMatch1Cases4.storeMatchAbortFlag2 ; $65a0
	xor a, a ; $65a3
	ret ; $65a4
.checkPointOutcome:
	ld a, [wPointOutcome] ; $65a5
	cp a, $09 ; $65a8
	ld a, $00 ; $65aa
	ret z ; $65ac
	ld a, $61 ; $65ad
	ld b, $07 ; $65af
	call SetDrillMessageByRallyParity ; $65b1
	call TestBallBounceDepth ; $65b4
	or a, a ; $65b7
	jp z, StrokeMatch1Cases4.storeMatchAbortFlag2 ; $65b8
	xor a, a ; $65bb
	ret ; $65bc
.step:
	xor a, a ; $65bd
	ret ; $65be
.maskClear:
	ld a, b ; $65bf
	ld a, a ; $65c0
	rst Rst00 ; $65c1
	dw StrokeMatch1Cases2.checkPointOutcome2 ; $65c2 jumptable
	dw StrokeMatch1Cases3 ; $65c4 jumptable
	dw StrokeMatch1Cases3.checkPointOutcome ; $65c6 jumptable
	dw StrokeMatch1Cases3.step ; $65c8 jumptable
.checkPointOutcome2:
	ld a, [wPointOutcome] ; $65ca
	ld hl, DrillShotTable_0b_65e9 ; $65cd
	add a, l ; $65d0
	ld l, a ; $65d1
	jr nc, .read ; $65d2
	inc h ; $65d4
.read:
	ld a, [hl] ; $65d5
	ld a, a ; $65d6
	ld b, $07 ; $65d7
	call SetDrillMessageByRallyParity ; $65d9
	call SelectStrokeTargetTableByPoint ; $65dc
	ld a, [wPointOutcome] ; $65df
	add a, l ; $65e2
	ld l, a ; $65e3
	jr nc, .readB ; $65e4
	inc h ; $65e6
.readB:
	ld a, [hl] ; $65e7
	ret ; $65e8
DrillShotTable_0b_65e9:
	; $65e9, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $5f, $5f, $5e, $ff, $ff, $60 ; 0x00
StrokeMatch1Cases3:
	ld a, $62 ; $65f3
	ld b, $07 ; $65f5
	call SetDrillMessageByRallyParity ; $65f7
	ld a, [wLastShotCharIndex] ; $65fa
	call TestCharStateBit4 ; $65fd
	jp nz, StrokeMatch1Cases4.storeMatchAbortFlag ; $6600
	xor a, a ; $6603
	ret ; $6604
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6605
	cp a, $09 ; $6608
	ld a, $00 ; $660a
	ret z ; $660c
	ld a, $61 ; $660d
	ld b, $07 ; $660f
	call SetDrillMessageByRallyParity ; $6611
	call TestBallBounceDepth ; $6614
	or a, a ; $6617
	jp z, StrokeMatch1Cases4.storeMatchAbortFlag ; $6618
	xor a, a ; $661b
	ret ; $661c
.step:
	xor a, a ; $661d
	ret ; $661e
.step2:
	ld a, b ; $661f
	ld a, a ; $6620
	rst Rst00 ; $6621
	dw StrokeMatch1Cases3.checkPointOutcome2 ; $6622 jumptable
	dw StrokeMatch1Cases4 ; $6624 jumptable
	dw StrokeMatch1Cases4.checkPointOutcome ; $6626 jumptable
	dw StrokeMatch1Cases4.step ; $6628 jumptable
.checkPointOutcome2:
	ld a, [wPointOutcome] ; $662a
	ld hl, DrillShotTable_0b_6649 ; $662d
	add a, l ; $6630
	ld l, a ; $6631
	jr nc, .read ; $6632
	inc h ; $6634
.read:
	ld a, [hl] ; $6635
	ld a, a ; $6636
	ld b, $07 ; $6637
	call SetDrillMessageByRallyParity ; $6639
	call SelectStrokeTargetTableByPointAlt ; $663c
	ld a, [wPointOutcome] ; $663f
	add a, l ; $6642
	ld l, a ; $6643
	jr nc, .readB ; $6644
	inc h ; $6646
.readB:
	ld a, [hl] ; $6647
	ret ; $6648
DrillShotTable_0b_6649:
	; $6649, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $5f, $5f, $5e, $ff, $ff, $60 ; 0x00
StrokeMatch1Cases4:
	ld a, $62 ; $6653
	ld b, $07 ; $6655
	call SetDrillMessageByRallyParity ; $6657
	ld a, [wLastShotCharIndex] ; $665a
	call TestCharStateBit4 ; $665d
	jp nz, .storeMatchAbortFlag2 ; $6660
	xor a, a ; $6663
	ret ; $6664
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6665
	cp a, $09 ; $6668
	ld a, $00 ; $666a
	ret z ; $666c
	ld a, $61 ; $666d
	ld b, $07 ; $666f
	call SetDrillMessageByRallyParity ; $6671
	call TestBallBounceDepth ; $6674
	or a, a ; $6677
	jp z, .storeMatchAbortFlag2 ; $6678
	xor a, a ; $667b
	ret ; $667c
.step:
	xor a, a ; $667d
	ret ; $667e
.storeMatchAbortFlag:
	ld a, $01 ; $667f
	ld [wMatchAbortFlag], a ; $6681
	ld a, $01 ; $6684
	ret ; $6686
.storeMatchAbortFlag2:
	ld a, $01 ; $6687
	ld [wMatchAbortFlag], a ; $6689
	ld a, $ff ; $668c
	ret ; $668e
SelectStrokeTargetTableByPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $668f
	and a, $01 ; $6692
	ld a, $00 ; $6694
	or a, a ; $6696
	jr nz, .nonZero ; $6697
	ld hl, SignedTable_0b_46fb ; $6699
	jr .done ; $669c
.nonZero:
	ld hl, SignedTable_0b_46f1 ; $669e
.done:
	ret ; $66a1
SelectStrokeTargetTableByPointAlt:
	ld a, [wTotalPointsScoredInCurrentGame] ; $66a2
	and a, $01 ; $66a5
	ld a, $00 ; $66a7
	or a, a ; $66a9
	jr nz, .nonZero ; $66aa
	ld hl, SignedTable_0b_46f1 ; $66ac
	jr .done ; $66af
.nonZero:
	ld hl, SignedTable_0b_46fb ; $66b1
.done:
	ret ; $66b4
TestBallBounceDepth:
	ld a, [wBallBounceCount] ; $66b5
	cp a, $01 ; $66b8
	ret nz ; $66ba
	ld hl, wBallDepth ; $66bb
	ld a, [hl+] ; $66be
	ld h, [hl] ; $66bf
	ld l, a ; $66c0
	bit 7, h ; $66c1
	jr z, .positive ; $66c3
	xor a, a ; $66c5
	sub a, l ; $66c6
	ld l, a ; $66c7
	sbc a, a ; $66c8
	sub a, h ; $66c9
	ld h, a ; $66ca
.positive:
	ld de, $02a0 ; $66cb
	ld a, l ; $66ce
	sub a, e ; $66cf
	ld l, a ; $66d0
	ld a, h ; $66d1
	sbc a, d ; $66d2
	ld h, a ; $66d3
	ld a, $01 ; $66d4
	bit 7, h ; $66d6
	ret z ; $66d8
	xor a, a ; $66d9
	ret ; $66da
StrokeMatch2Drill:
	; $66db, 16 bytes (drill_definition)
	db $44, $18, $02, $05, $0d, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokeMatch2Hooks, StrokeMatchPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
StrokeMatch2Hooks:
	; $66eb, 16 bytes (mode_hooks)
	dw StrokeMatch2Hook_PerFrame ; record 0
	dw StrokeMatch2Hook_PointStart ; record 1
	dw StrokeMatch2Hook_PointEnd ; record 2
	dw StrokeMatch2Hook_MinigameStart ; record 3
	dw StrokeMatch2Hook_BallHit ; record 4
	dw StrokeMatch2Hook_Bounce ; record 5
	dw StrokeMatch2Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch2Hook_MinigameStart:
	ret ; $66fb
StrokeMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $66fc
	ret ; $66ff
StrokeMatch2Hook_PointStart:
	xor a, a ; $6700
	ld [$c2e1], a ; $6701
	ld a, $0a ; $6704
	ld [$c2e0], a ; $6706
	ld hl, $6737 ; $6709
	call LoadDrillOpponentBySide ; $670c
	xor a, a ; $670f
	ld [$c2e6], a ; $6710
	xor a, a ; $6713
	ld [$c2ff], a ; $6714
	ld a, [wTotalPointsScoredInCurrentGame] ; $6717
	bit 0, a ; $671a
	ret nz ; $671c
	xor a, a ; $671d
	ld [$c2e8], a ; $671e
	ld [$c2e9], a ; $6721
	ld [$c2ea], a ; $6724
	ld [$c2eb], a ; $6727
	ld [$c2ec], a ; $672a
	ld [$c2ed], a ; $672d
	ld [$c2ee], a ; $6730
	ld [$c2ef], a ; $6733
	ret ; $6736
	db $58 ; $6737
	db $44 ; $6738
StrokeMatch2Hook_PointEnd:
	call StrokeMatch2JudgeShot0 ; $6739
	call StrokeMatch2HandlePointEnd ; $673c
	ld a, [wTotalPointsScoredInCurrentGame] ; $673f
	bit 0, a ; $6742
	ret nz ; $6744
	ld a, [wPlayer1PointsWon] ; $6745
	ld b, a ; $6748
	ld a, [wPlayer2PointsWon] ; $6749
	sub a, b ; $674c
	ld b, a ; $674d
	bit 7, a ; $674e
	jr z, .compare ; $6750
	cpl ; $6752
	inc a ; $6753
.compare:
	cp a, $02 ; $6754
	jr c, .checkTotalPointsScoredInCurrentGame ; $6756
	xor a, a ; $6758
	rl b ; $6759
	rl a ; $675b
	or a, a ; $675d
	jr nz, .store ; $675e
	ld a, $ff ; $6760
.store:
	ld [wPointWinLoseFlag], a ; $6762
	ld a, $80 ; $6765
	ld [wMatchAbortFlag], a ; $6767
	ret ; $676a
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $676b
	cp a, $08 ; $676e
	ret nz ; $6770
	ld a, $00 ; $6771
	ld [wPointWinLoseFlag], a ; $6773
	ld a, $80 ; $6776
	ld [wMatchAbortFlag], a ; $6778
	ret ; $677b
StrokeMatch2Hook_RallyTick:
	call StrokeMatch2JudgeShot3 ; $677c
	ret ; $677f
StrokeMatch2Hook_Bounce:
	call StrokeMatch2JudgeShot2 ; $6780
	ret ; $6783
StrokeMatch2Hook_BallHit:
	call StrokeMatch2JudgeShot1 ; $6784
	ret ; $6787
StrokeMatch2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6788
	ld a, [$c2ff] ; $678b
	ld b, a ; $678e
	ld a, [wTotalPointsScoredInCurrentGame] ; $678f
	bit 0, a ; $6792
	ld a, b ; $6794
	jr z, .store ; $6795
	cpl ; $6797
	inc a ; $6798
.store:
	ld [wPointWinLoseFlag], a ; $6799
	call RecordDrillPointResultBits ; $679c
	call ShowQueuedDrillMessage ; $679f
	farcall UpdatePointStats ; $67a2
	call StrokeMatch2AwardPointToSide ; $67a5
	ld a, [wPlayer1PointsWon] ; $67a8
	ld b, $01 ; $67ab
	farcall LoadPlayer1PointsDigitGfx ; $67ad
	ld a, [wPlayer2PointsWon] ; $67b0
	ld b, $01 ; $67b3
	farcall LoadPlayer2PointsDigitGfx ; $67b5
	farcall StepMatchFrame ; $67b8
	farcall StartPointEndReactions ; $67bb
	call PlayDrillPointEndSequence ; $67be
	ret ; $67c1
StrokeMatch2AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $67c2
	or a, a ; $67c5
	ret z ; $67c6
	inc a ; $67c7
	srl a ; $67c8
	ld b, a ; $67ca
	ld a, [wTotalPointsScoredInCurrentGame] ; $67cb
	and a, $01 ; $67ce
	xor a, $01 ; $67d0
	add a, b ; $67d2
	bit 0, a ; $67d3
	jr nz, .clearServeFaultFlag ; $67d5
	ld hl, wPlayer2PointsWon ; $67d7
	bit 1, a ; $67da
	jr z, .bump ; $67dc
	ld hl, wPlayer1PointsWon ; $67de
.bump:
	inc [hl] ; $67e1
.clearServeFaultFlag:
	xor a, a ; $67e2
	ld [wServeFaultFlag], a ; $67e3
	ld hl, wTotalPointsScoredInCurrentGame ; $67e6
	inc [hl] ; $67e9
	ret ; $67ea
StrokeMatch2JudgeShot0:
	ld a, $00 ; $67eb
	call StrokeMatch2JudgePoint ; $67ed
	ld [$c2ff], a ; $67f0
	ret ; $67f3
StrokeMatch2JudgeShot1:
	ld a, $01 ; $67f4
	call StrokeMatch2JudgePoint ; $67f6
	ld [$c2ff], a ; $67f9
	ret ; $67fc
StrokeMatch2JudgeShot2:
	ld a, $02 ; $67fd
	call StrokeMatch2JudgePoint ; $67ff
	ld [$c2ff], a ; $6802
	ret ; $6805
StrokeMatch2JudgeShot3:
	ret ; $6806
	ld a, $03 ; $6807
	call StrokeMatch2JudgePoint ; $6809
	ld [$c2ff], a ; $680c
	ret ; $680f
StrokeMatch2JudgePoint:
	ld b, a ; $6810
	ld a, [$c2ff] ; $6811
	or a, a ; $6814
	ret nz ; $6815
	ld a, [wRallyLength] ; $6816
	dec a ; $6819
	ld a, a ; $681a
	rst Rst00 ; $681b
	dw StrokeMatch2JudgePoint.rally1 ; $681c jumptable
	dw StrokeMatch2Cases1.step3 ; $681e jumptable
	dw StrokeMatch2Cases2.step3 ; $6820 jumptable
	dw StrokeMatch2Cases3.step3 ; $6822 jumptable
.rally1:
	ld a, b ; $6824
	ld a, a ; $6825
	rst Rst00 ; $6826
	dw StrokeMatch2JudgePoint.result0 ; $6827 jumptable
	dw StrokeMatch2Cases1 ; $6829 jumptable
	dw StrokeMatch2Cases1.step ; $682b jumptable
	dw StrokeMatch2Cases1.step2 ; $682d jumptable
.result0:
	ld a, [wPointOutcome] ; $682f
	ld hl, DrillShotTable_0b_684e ; $6832
	add a, l ; $6835
	ld l, a ; $6836
	jr nc, .readEntry1 ; $6837
	inc h ; $6839
.readEntry1:
	ld a, [hl] ; $683a
	ld a, a ; $683b
	ld b, $0d ; $683c
	call SetDrillMessageByServer ; $683e
	ld a, [wPointOutcome] ; $6841
	ld hl, SignedTable_0b_46fb ; $6844
	add a, l ; $6847
	ld l, a ; $6848
	jr nc, .readEntry2 ; $6849
	inc h ; $684b
.readEntry2:
	ld a, [hl] ; $684c
	ret ; $684d
DrillShotTable_0b_684e:
	; $684e, 10 bytes (bytes:10)
	db $ff, $ff, $42, $ff, $ff, $ff, $3f, $ff, $ff, $3f ; 0x00
StrokeMatch2Cases1:
	xor a, a ; $6858
	ret ; $6859
.step:
	xor a, a ; $685a
	ret ; $685b
.step2:
	xor a, a ; $685c
	ret ; $685d
.step3:
	ld a, b ; $685e
	ld a, a ; $685f
	rst Rst00 ; $6860
	dw StrokeMatch2Cases1.checkPointOutcome ; $6861 jumptable
	dw StrokeMatch2Cases2 ; $6863 jumptable
	dw StrokeMatch2Cases2.step ; $6865 jumptable
	dw StrokeMatch2Cases2.step2 ; $6867 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6869
	ld hl, DrillShotTable_0b_6888 ; $686c
	add a, l ; $686f
	ld l, a ; $6870
	jr nc, .read ; $6871
	inc h ; $6873
.read:
	ld a, [hl] ; $6874
	ld a, a ; $6875
	ld b, $0d ; $6876
	call SetDrillMessageByServer ; $6878
	ld a, [wPointOutcome] ; $687b
	ld hl, SignedTable_0b_46f1 ; $687e
	add a, l ; $6881
	ld l, a ; $6882
	jr nc, .readB ; $6883
	inc h ; $6885
.readB:
	ld a, [hl] ; $6886
	ret ; $6887
DrillShotTable_0b_6888:
	; $6888, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $48, $48, $3d, $47, $47, $3d ; 0x00
StrokeMatch2Cases2:
	ld a, [wBallBounceCount] ; $6892
	or a, a ; $6895
	ret z ; $6896
	ld a, $40 ; $6897
	ld b, $0d ; $6899
	call SetDrillMessageByServer ; $689b
	ld a, [wCurrentShotType] ; $689e
	cp a, $0a ; $68a1
	jp nz, StrokeMatch2Cases3.storeMatchAbortFlag ; $68a3
	xor a, a ; $68a6
	ret ; $68a7
.step:
	xor a, a ; $68a8
	ret ; $68a9
.step2:
	xor a, a ; $68aa
	ret ; $68ab
.step3:
	ld a, b ; $68ac
	ld a, a ; $68ad
	rst Rst00 ; $68ae
	dw StrokeMatch2Cases2.checkPointOutcome ; $68af jumptable
	dw StrokeMatch2Cases3 ; $68b1 jumptable
	dw StrokeMatch2Cases3.step ; $68b3 jumptable
	dw StrokeMatch2Cases3.step2 ; $68b5 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $68b7
	ld hl, DrillShotTable_0b_68d6 ; $68ba
	add a, l ; $68bd
	ld l, a ; $68be
	jr nc, .read ; $68bf
	inc h ; $68c1
.read:
	ld a, [hl] ; $68c2
	ld a, a ; $68c3
	ld b, $0d ; $68c4
	call SetDrillMessageByServer ; $68c6
	ld a, [wPointOutcome] ; $68c9
	ld hl, SignedTable_0b_46fb ; $68cc
	add a, l ; $68cf
	ld l, a ; $68d0
	jr nc, .readB ; $68d1
	inc h ; $68d3
.readB:
	ld a, [hl] ; $68d4
	ret ; $68d5
DrillShotTable_0b_68d6:
	; $68d6, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3d, $3d, $43, $ff, $ff, $43 ; 0x00
StrokeMatch2Cases3:
	ld a, $46 ; $68e0
	ld b, $0d ; $68e2
	call SetDrillMessageByServer ; $68e4
	ld a, [wTotalPointsScoredInCurrentGame] ; $68e7
	and a, $01 ; $68ea
	xor a, $01 ; $68ec
	call TestCharStateBit4 ; $68ee
	or a, a ; $68f1
	jp z, .zero ; $68f2
	xor a, a ; $68f5
	ret ; $68f6
.step:
	xor a, a ; $68f7
	ret ; $68f8
.step2:
	xor a, a ; $68f9
	ret ; $68fa
.step3:
	ld a, b ; $68fb
	ld a, a ; $68fc
	rst Rst00 ; $68fd
	dw StrokeMatch2Cases3.step4 ; $68fe jumptable
	dw StrokeMatch2Cases3.setDrillMessageByServer ; $6900 jumptable
	dw StrokeMatch2Cases3.step6 ; $6902 jumptable
	dw StrokeMatch2Cases3.step7 ; $6904 jumptable
.step4:
	xor a, a ; $6906
	ret ; $6907
.setDrillMessageByServer:
	ld a, $43 ; $6908
	ld b, $0d ; $690a
	call SetDrillMessageByServer ; $690c
	jp .storeMatchAbortFlag ; $690f
.step6:
	xor a, a ; $6912
	ret ; $6913
.step7:
	xor a, a ; $6914
	ret ; $6915
.zero:
	ld a, $01 ; $6916
	ld [wMatchAbortFlag], a ; $6918
	ld a, $01 ; $691b
	ret ; $691d
.storeMatchAbortFlag:
	ld a, $01 ; $691e
	ld [wMatchAbortFlag], a ; $6920
	ld a, $ff ; $6923
	ret ; $6925
StrokeMatch3Drill:
	; $6926, 16 bytes (drill_definition)
	db $45, $18, $02, $05, $0e, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokeMatch3Hooks, StrokeMatchPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
StrokeMatch3Hooks:
	; $6936, 16 bytes (mode_hooks)
	dw StrokeMatch3Hook_PerFrame ; record 0
	dw StrokeMatch3Hook_PointStart ; record 1
	dw StrokeMatch3Hook_PointEnd ; record 2
	dw StrokeMatch3Hook_MinigameStart ; record 3
	dw StrokeMatch3Hook_BallHit ; record 4
	dw StrokeMatch3Hook_Bounce ; record 5
	dw StrokeMatch3Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch3Hook_MinigameStart:
	ret ; $6946
StrokeMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6947
	ret ; $694a
StrokeMatch3Hook_PointStart:
	xor a, a ; $694b
	ld [$c2e1], a ; $694c
	ld a, $0a ; $694f
	ld [$c2e0], a ; $6951
	ld hl, $6982 ; $6954
	call LoadDrillOpponentBySide ; $6957
	xor a, a ; $695a
	ld [$c2e6], a ; $695b
	xor a, a ; $695e
	ld [$c2ff], a ; $695f
	ld a, [wTotalPointsScoredInCurrentGame] ; $6962
	bit 0, a ; $6965
	ret nz ; $6967
	xor a, a ; $6968
	ld [$c2e8], a ; $6969
	ld [$c2e9], a ; $696c
	ld [$c2ea], a ; $696f
	ld [$c2eb], a ; $6972
	ld [$c2ec], a ; $6975
	ld [$c2ed], a ; $6978
	ld [$c2ee], a ; $697b
	ld [$c2ef], a ; $697e
	ret ; $6981
	db $59 ; $6982
	db $45 ; $6983
StrokeMatch3Hook_PointEnd:
	call StrokeMatch3JudgeShot0 ; $6984
	call StrokeMatch3HandlePointEnd ; $6987
	ld a, [wTotalPointsScoredInCurrentGame] ; $698a
	bit 0, a ; $698d
	ret nz ; $698f
	ld a, [wPlayer1PointsWon] ; $6990
	ld b, a ; $6993
	ld a, [wPlayer2PointsWon] ; $6994
	sub a, b ; $6997
	ld b, a ; $6998
	bit 7, a ; $6999
	jr z, .compare ; $699b
	cpl ; $699d
	inc a ; $699e
.compare:
	cp a, $02 ; $699f
	jr c, .checkTotalPointsScoredInCurrentGame ; $69a1
	xor a, a ; $69a3
	rl b ; $69a4
	rl a ; $69a6
	or a, a ; $69a8
	jr nz, .store ; $69a9
	ld a, $ff ; $69ab
.store:
	ld [wPointWinLoseFlag], a ; $69ad
	ld a, $80 ; $69b0
	ld [wMatchAbortFlag], a ; $69b2
	ret ; $69b5
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $69b6
	cp a, $08 ; $69b9
	ret nz ; $69bb
	ld a, $00 ; $69bc
	ld [wPointWinLoseFlag], a ; $69be
	ld a, $80 ; $69c1
	ld [wMatchAbortFlag], a ; $69c3
	ret ; $69c6
StrokeMatch3Hook_RallyTick:
	call StrokeMatch3JudgeShot3 ; $69c7
	ret ; $69ca
StrokeMatch3Hook_Bounce:
	call StrokeMatch3JudgeShot2 ; $69cb
	ret ; $69ce
StrokeMatch3Hook_BallHit:
	call StrokeMatch3JudgeShot1 ; $69cf
	ret ; $69d2
StrokeMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $69d3
	ld a, [$c2ff] ; $69d6
	ld b, a ; $69d9
	ld a, [wTotalPointsScoredInCurrentGame] ; $69da
	bit 0, a ; $69dd
	ld a, b ; $69df
	jr z, .store ; $69e0
	cpl ; $69e2
	inc a ; $69e3
.store:
	ld [wPointWinLoseFlag], a ; $69e4
	call RecordDrillPointResultBits ; $69e7
	call ShowQueuedDrillMessage ; $69ea
	farcall UpdatePointStats ; $69ed
	call StrokeMatch3AwardPointToSide ; $69f0
	ld a, [wPlayer1PointsWon] ; $69f3
	ld b, $01 ; $69f6
	farcall LoadPlayer1PointsDigitGfx ; $69f8
	ld a, [wPlayer2PointsWon] ; $69fb
	ld b, $01 ; $69fe
	farcall LoadPlayer2PointsDigitGfx ; $6a00
	farcall StepMatchFrame ; $6a03
	farcall StartPointEndReactions ; $6a06
	call PlayDrillPointEndSequence ; $6a09
	ret ; $6a0c
StrokeMatch3AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $6a0d
	or a, a ; $6a10
	ret z ; $6a11
	inc a ; $6a12
	srl a ; $6a13
	ld b, a ; $6a15
	ld a, [wTotalPointsScoredInCurrentGame] ; $6a16
	and a, $01 ; $6a19
	xor a, $01 ; $6a1b
	add a, b ; $6a1d
	bit 0, a ; $6a1e
	jr nz, .clearServeFaultFlag ; $6a20
	ld hl, wPlayer2PointsWon ; $6a22
	bit 1, a ; $6a25
	jr z, .bump ; $6a27
	ld hl, wPlayer1PointsWon ; $6a29
.bump:
	inc [hl] ; $6a2c
.clearServeFaultFlag:
	xor a, a ; $6a2d
	ld [wServeFaultFlag], a ; $6a2e
	ld hl, wTotalPointsScoredInCurrentGame ; $6a31
	inc [hl] ; $6a34
	ret ; $6a35
StrokeMatch3JudgeShot0:
	ld a, $00 ; $6a36
	call StrokeMatch3JudgePoint ; $6a38
	ld [$c2ff], a ; $6a3b
	ret ; $6a3e
StrokeMatch3JudgeShot1:
	ld a, $01 ; $6a3f
	call StrokeMatch3JudgePoint ; $6a41
	ld [$c2ff], a ; $6a44
	ret ; $6a47
StrokeMatch3JudgeShot2:
	ld a, $02 ; $6a48
	call StrokeMatch3JudgePoint ; $6a4a
	ld [$c2ff], a ; $6a4d
	ret ; $6a50
StrokeMatch3JudgeShot3:
	ret ; $6a51
	ld a, $03 ; $6a52
	call StrokeMatch3JudgePoint ; $6a54
	ld [$c2ff], a ; $6a57
	ret ; $6a5a
StrokeMatch3JudgePoint:
	ld b, a ; $6a5b
	ld a, [$c2ff] ; $6a5c
	or a, a ; $6a5f
	ret nz ; $6a60
	ld a, [wRallyLength] ; $6a61
	dec a ; $6a64
	ld a, a ; $6a65
	rst Rst00 ; $6a66
	dw StrokeMatch3JudgePoint.rally1 ; $6a67 jumptable
	dw StrokeMatch3Cases1.step3 ; $6a69 jumptable
	dw StrokeMatch3Cases2.step3 ; $6a6b jumptable
	dw StrokeMatch3Cases3.step3 ; $6a6d jumptable
.rally1:
	ld a, b ; $6a6f
	ld a, a ; $6a70
	rst Rst00 ; $6a71
	dw StrokeMatch3JudgePoint.result0 ; $6a72 jumptable
	dw StrokeMatch3Cases1 ; $6a74 jumptable
	dw StrokeMatch3Cases1.step ; $6a76 jumptable
	dw StrokeMatch3Cases1.step2 ; $6a78 jumptable
.result0:
	ld a, [wPointOutcome] ; $6a7a
	ld hl, DrillShotTable_0b_6a99 ; $6a7d
	add a, l ; $6a80
	ld l, a ; $6a81
	jr nc, .readEntry1 ; $6a82
	inc h ; $6a84
.readEntry1:
	ld a, [hl] ; $6a85
	ld a, a ; $6a86
	ld b, $0d ; $6a87
	call SetDrillMessageByServer ; $6a89
	ld a, [wPointOutcome] ; $6a8c
	ld hl, SignedTable_0b_46fb ; $6a8f
	add a, l ; $6a92
	ld l, a ; $6a93
	jr nc, .readEntry2 ; $6a94
	inc h ; $6a96
.readEntry2:
	ld a, [hl] ; $6a97
	ret ; $6a98
DrillShotTable_0b_6a99:
	; $6a99, 10 bytes (bytes:10)
	db $ff, $ff, $42, $ff, $ff, $ff, $3f, $ff, $ff, $3f ; 0x00
StrokeMatch3Cases1:
	xor a, a ; $6aa3
	ret ; $6aa4
.step:
	xor a, a ; $6aa5
	ret ; $6aa6
.step2:
	xor a, a ; $6aa7
	ret ; $6aa8
.step3:
	ld a, b ; $6aa9
	ld a, a ; $6aaa
	rst Rst00 ; $6aab
	dw StrokeMatch3Cases1.checkPointOutcome ; $6aac jumptable
	dw StrokeMatch3Cases2 ; $6aae jumptable
	dw StrokeMatch3Cases2.step ; $6ab0 jumptable
	dw StrokeMatch3Cases2.step2 ; $6ab2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6ab4
	ld hl, DrillShotTable_0b_6ad3 ; $6ab7
	add a, l ; $6aba
	ld l, a ; $6abb
	jr nc, .read ; $6abc
	inc h ; $6abe
.read:
	ld a, [hl] ; $6abf
	ld a, a ; $6ac0
	ld b, $0d ; $6ac1
	call SetDrillMessageByServer ; $6ac3
	ld a, [wPointOutcome] ; $6ac6
	ld hl, SignedTable_0b_46f1 ; $6ac9
	add a, l ; $6acc
	ld l, a ; $6acd
	jr nc, .readB ; $6ace
	inc h ; $6ad0
.readB:
	ld a, [hl] ; $6ad1
	ret ; $6ad2
DrillShotTable_0b_6ad3:
	; $6ad3, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3f, $49, $3e, $47, $47, $3e ; 0x00
StrokeMatch3Cases2:
	xor a, a ; $6add
	ret ; $6ade
.step:
	xor a, a ; $6adf
	ret ; $6ae0
.step2:
	xor a, a ; $6ae1
	ret ; $6ae2
.step3:
	ld a, b ; $6ae3
	ld a, a ; $6ae4
	rst Rst00 ; $6ae5
	dw StrokeMatch3Cases2.checkPointOutcome ; $6ae6 jumptable
	dw StrokeMatch3Cases3 ; $6ae8 jumptable
	dw StrokeMatch3Cases3.step ; $6aea jumptable
	dw StrokeMatch3Cases3.step2 ; $6aec jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6aee
	ld hl, DrillShotTable_0b_6b0d ; $6af1
	add a, l ; $6af4
	ld l, a ; $6af5
	jr nc, .read ; $6af6
	inc h ; $6af8
.read:
	ld a, [hl] ; $6af9
	ld a, a ; $6afa
	ld b, $0d ; $6afb
	call SetDrillMessageByServer ; $6afd
	ld a, [wPointOutcome] ; $6b00
	ld hl, SignedTable_0b_46fb ; $6b03
	add a, l ; $6b06
	ld l, a ; $6b07
	jr nc, .readB ; $6b08
	inc h ; $6b0a
.readB:
	ld a, [hl] ; $6b0b
	ret ; $6b0c
DrillShotTable_0b_6b0d:
	; $6b0d, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3e, $3e, $43, $ff, $ff, $43 ; 0x00
StrokeMatch3Cases3:
	ld a, $46 ; $6b17
	ld b, $0d ; $6b19
	call SetDrillMessageByServer ; $6b1b
	ld a, [wTotalPointsScoredInCurrentGame] ; $6b1e
	and a, $01 ; $6b21
	xor a, $01 ; $6b23
	call TestCharStateBit4 ; $6b25
	or a, a ; $6b28
	jp z, .zero ; $6b29
	xor a, a ; $6b2c
	ret ; $6b2d
.step:
	xor a, a ; $6b2e
	ret ; $6b2f
.step2:
	xor a, a ; $6b30
	ret ; $6b31
.step3:
	ld a, b ; $6b32
	ld a, a ; $6b33
	rst Rst00 ; $6b34
	dw StrokeMatch3Cases3.step4 ; $6b35 jumptable
	dw StrokeMatch3Cases3.setDrillMessageByServer ; $6b37 jumptable
	dw StrokeMatch3Cases3.step6 ; $6b39 jumptable
	dw StrokeMatch3Cases3.step7 ; $6b3b jumptable
.step4:
	xor a, a ; $6b3d
	ret ; $6b3e
.setDrillMessageByServer:
	ld a, $43 ; $6b3f
	ld b, $0d ; $6b41
	call SetDrillMessageByServer ; $6b43
	jp .storeMatchAbortFlag ; $6b46
.step6:
	xor a, a ; $6b49
	ret ; $6b4a
.step7:
	xor a, a ; $6b4b
	ret ; $6b4c
.zero:
	ld a, $01 ; $6b4d
	ld [wMatchAbortFlag], a ; $6b4f
	ld a, $01 ; $6b52
	ret ; $6b54
.storeMatchAbortFlag:
	ld a, $01 ; $6b55
	ld [wMatchAbortFlag], a ; $6b57
	ld a, $ff ; $6b5a
	ret ; $6b5c
StrokePractice1Drill:
	; $6b5d, 16 bytes (drill_definition)
	db $46, $09, $02, $05, $0f, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokePractice1Hooks, StrokePracticePointTable, StrokePractice1DrillInit ; mode hooks, point table, init
	db $00, $00
StrokePractice1DrillInit:
	ld a, $01 ; $6b6d
	ld [$c7bb], a ; $6b6f
	ret ; $6b72
StrokePractice1Hooks:
	; $6b73, 16 bytes (mode_hooks)
	dw StrokePractice1Hook_PerFrame ; record 0
	dw StrokePractice1Hook_PointStart ; record 1
	dw StrokePractice1Hook_PointEnd ; record 2
	dw StrokePractice1Hook_MinigameStart ; record 3
	dw StrokePractice1Hook_BallHit ; record 4
	dw StrokePractice1Hook_Bounce ; record 5
	dw StrokePractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokePractice1Hook_MinigameStart:
	ld a, $01 ; $6b83
	ld [$c7bb], a ; $6b85
	xor a, a ; $6b88
	ld [$c2e9], a ; $6b89
	ld [$c2e8], a ; $6b8c
	ret ; $6b8f
StrokePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6b90
	ret ; $6b93
StrokePractice1Hook_PointStart:
	xor a, a ; $6b94
	ld [$c2e1], a ; $6b95
	ld a, $0a ; $6b98
	ld [$c2e0], a ; $6b9a
	xor a, a ; $6b9d
	ld [wTargetZoneEnabled], a ; $6b9e
	ld hl, $6c5f ; $6ba1
	call SetDrillTargetZoneForPoint ; $6ba4
	xor a, a ; $6ba7
	ld [$c2e6], a ; $6ba8
	xor a, a ; $6bab
	ld [$c2ff], a ; $6bac
	ld a, $5a ; $6baf
	ld [$c2ef], a ; $6bb1
	ld a, $01 ; $6bb4
	ld hl, EnableTargetZoneAfterDelayTask ; $6bb6
	call RegisterFrameTask ; $6bb9
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bbc
	ld hl, Table_0b_6bcc ; $6bbf
	add a, l ; $6bc2
	ld l, a ; $6bc3
	jr nc, .read ; $6bc4
	inc h ; $6bc6
.read:
	ld a, [hl] ; $6bc7
	ld [$c7b5], a ; $6bc8
	ret ; $6bcb
Table_0b_6bcc:
	; $6bcc, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
EnableTargetZoneAfterDelayTask:
	ld hl, $c2ef ; $6bd0
	dec [hl] ; $6bd3
	ret nz ; $6bd4
	ld a, $01 ; $6bd5
	ld [wTargetZoneEnabled], a ; $6bd7
	ld hl, EnableTargetZoneAfterDelayTask ; $6bda
	call UnregisterFrameTask ; $6bdd
	ret ; $6be0
StrokePractice1Hook_PointEnd:
	call Drill15JudgePointMode0 ; $6be1
	ld a, [wPointOutcome] ; $6be4
	cp a, $05 ; $6be7
	jr z, .eq05 ; $6be9
	jr .strokePractice1HandlePointEnd ; $6beb
.eq05:
	ld hl, $c2e8 ; $6bed
	inc [hl] ; $6bf0
.strokePractice1HandlePointEnd:
	call StrokePractice1HandlePointEnd ; $6bf1
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bf4
	cp a, $04 ; $6bf7
	ret c ; $6bf9
	call StrokePractice1EvaluateResult ; $6bfa
	ld [wPointWinLoseFlag], a ; $6bfd
	ret ; $6c00
StrokePractice1EvaluateResult:
	ld a, [$c2e9] ; $6c01
	cp a, $04 ; $6c04
	jr nz, .ne04 ; $6c06
	xor a, a ; $6c08
	ld [$c2e3], a ; $6c09
	ld a, $01 ; $6c0c
	ret ; $6c0e
.ne04:
	ld a, [$c2e8] ; $6c0f
	cp a, $04 ; $6c12
	jr c, .compare ; $6c14
	ld a, $01 ; $6c16
	ld [$c2e3], a ; $6c18
	jr .notFound ; $6c1b
.compare:
	cp a, $02 ; $6c1d
	jr c, .lt02 ; $6c1f
	ld a, $02 ; $6c21
	ld [$c2e3], a ; $6c23
	jr .notFound ; $6c26
.lt02:
	ld a, [$c2e9] ; $6c28
	or a, a ; $6c2b
	jr nz, .compare2 ; $6c2c
	ld a, $03 ; $6c2e
	ld [$c2e3], a ; $6c30
	jr .notFound ; $6c33
.compare2:
	cp a, $03 ; $6c35
	jr nz, .ne03 ; $6c37
	ld a, $05 ; $6c39
	ld [$c2e3], a ; $6c3b
	jr .notFound ; $6c3e
.ne03:
	ld a, $04 ; $6c40
	ld [$c2e3], a ; $6c42
	jr .notFound ; $6c45
.notFound:
	ld a, $ff ; $6c47
	ret ; $6c49
StrokePractice1Hook_RallyTick:
	call StubNop_0b_6ceb ; $6c4a
	ret ; $6c4d
StrokePractice1Hook_Bounce:
	call Drill15JudgePointMode2 ; $6c4e
	ret ; $6c51
StrokePractice1Hook_BallHit:
	call Drill15JudgePointMode1 ; $6c52
	ld a, [wRallyLength] ; $6c55
	cp a, $01 ; $6c58
	ret nz ; $6c5a
	call ResetActiveCharState ; $6c5b
	ret ; $6c5e
	; $6c5f, 34 bytes (records:2)
	dw $fe50 ; record 0
	dw $fb20 ; record 1
	dw $0000 ; record 2
	dw $fd60 ; record 3
	dw $0000 ; record 4
	dw $fb20 ; record 5
	dw $01b0 ; record 6
	dw $fd60 ; record 7
	dw $0000 ; record 8
	dw $02a0 ; record 9
	dw $01b0 ; record 10
	dw $04e0 ; record 11
	dw $fe50 ; record 12
	dw $02a0 ; record 13
	dw $0000 ; record 14
	dw $04e0 ; record 15
	dw $ffff ; record 16
StrokePractice1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6c81
	ld a, [$c2ff] ; $6c84
	ld [wPointWinLoseFlag], a ; $6c87
	cp a, $01 ; $6c8a
	jr nz, .recordDrillPointResultBits ; $6c8c
	ld hl, $c2e9 ; $6c8e
	inc [hl] ; $6c91
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $6c92
	call ShowQueuedDrillMessage ; $6c95
	farcall UpdatePointStats ; $6c98
	farcall AwardPoint ; $6c9b
	ld a, [$c2e9] ; $6c9e
	ld [wPlayer1PointsWon], a ; $6ca1
	xor a, a ; $6ca4
	ld [wPlayer2PointsWon], a ; $6ca5
	ld a, [wPlayer1PointsWon] ; $6ca8
	ld b, $01 ; $6cab
	farcall LoadPlayer1PointsDigitGfx ; $6cad
	ld a, [wPlayer2PointsWon] ; $6cb0
	ld b, $01 ; $6cb3
	farcall LoadPlayer2PointsDigitGfx ; $6cb5
	farcall StepMatchFrame ; $6cb8
	ld a, $01 ; $6cbb
	ld hl, SyncPointWinLoseFlagTask ; $6cbd
	call RegisterFrameTask ; $6cc0
	farcall StartPointEndReactions ; $6cc3
	ld hl, SyncPointWinLoseFlagTask ; $6cc6
	call UnregisterFrameTask ; $6cc9
	call PlayDrillPointEndSequence ; $6ccc
	ret ; $6ccf
Drill15JudgePointMode0:
	ld a, $00 ; $6cd0
	call StrokePractice1JudgePoint ; $6cd2
	ld [$c2ff], a ; $6cd5
	ret ; $6cd8
Drill15JudgePointMode1:
	ld a, $01 ; $6cd9
	call StrokePractice1JudgePoint ; $6cdb
	ld [$c2ff], a ; $6cde
	ret ; $6ce1
Drill15JudgePointMode2:
	ld a, $02 ; $6ce2
	call StrokePractice1JudgePoint ; $6ce4
	ld [$c2ff], a ; $6ce7
	ret ; $6cea
StubNop_0b_6ceb:
	ret ; $6ceb
	ld a, $03 ; $6cec
	call StrokePractice1JudgePoint ; $6cee
	ld [$c2ff], a ; $6cf1
	ret ; $6cf4
StrokePractice1JudgePoint:
	ld b, a ; $6cf5
	ld a, [$c2ff] ; $6cf6
	or a, a ; $6cf9
	ret nz ; $6cfa
	ld a, [wRallyLength] ; $6cfb
	dec a ; $6cfe
	ld a, a ; $6cff
	rst Rst00 ; $6d00
	dw StrokePractice1JudgePoint.rally1 ; $6d01 jumptable
	dw StrokePractice1Cases1.step3 ; $6d03 jumptable
.rally1:
	ld a, b ; $6d05
	ld a, a ; $6d06
	rst Rst00 ; $6d07
	dw StrokePractice1JudgePoint.result0 ; $6d08 jumptable
	dw StrokePractice1Cases1 ; $6d0a jumptable
	dw StrokePractice1Cases1.step ; $6d0c jumptable
	dw StrokePractice1Cases1.step2 ; $6d0e jumptable
.result0:
	ld a, [wPointOutcome] ; $6d10
	ld hl, SignedTable_0b_6d2f ; $6d13
	add a, l ; $6d16
	ld l, a ; $6d17
	jr nc, .readEntry1 ; $6d18
	inc h ; $6d1a
.readEntry1:
	ld a, [hl] ; $6d1b
	ld a, a ; $6d1c
	ld b, $00 ; $6d1d
	call QueueDrillResultMessage ; $6d1f
	ld a, [wPointOutcome] ; $6d22
	ld hl, SignedTable_0b_46fb ; $6d25
	add a, l ; $6d28
	ld l, a ; $6d29
	jr nc, .readEntry2 ; $6d2a
	inc h ; $6d2c
.readEntry2:
	ld a, [hl] ; $6d2d
	ret ; $6d2e
SignedTable_0b_6d2f:
	; $6d2f, 10 bytes (bytes:10)
	db $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59 ; 0x00
StrokePractice1Cases1:
	xor a, a ; $6d39
	ret ; $6d3a
.step:
	xor a, a ; $6d3b
	ret ; $6d3c
.step2:
	xor a, a ; $6d3d
	ret ; $6d3e
.step3:
	ld a, b ; $6d3f
	ld a, a ; $6d40
	rst Rst00 ; $6d41
	dw StrokePractice1Cases1.checkPointOutcome ; $6d42 jumptable
	dw StrokePractice1Cases2 ; $6d44 jumptable
	dw StrokePractice1Cases2.checkBallBounceCount ; $6d46 jumptable
	dw StrokePractice1Cases2.step ; $6d48 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6d4a
	ld hl, SignedTable_0b_6d69 ; $6d4d
	add a, l ; $6d50
	ld l, a ; $6d51
	jr nc, .read ; $6d52
	inc h ; $6d54
.read:
	ld a, [hl] ; $6d55
	ld a, a ; $6d56
	ld b, $00 ; $6d57
	call QueueDrillResultMessage ; $6d59
	ld a, [wPointOutcome] ; $6d5c
	ld hl, SignedTable_0b_46f1 ; $6d5f
	add a, l ; $6d62
	ld l, a ; $6d63
	jr nc, .readB ; $6d64
	inc h ; $6d66
.readB:
	ld a, [hl] ; $6d67
	ret ; $6d68
SignedTable_0b_6d69:
	; $6d69, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57 ; 0x00
StrokePractice1Cases2:
	xor a, a ; $6d73
	ret ; $6d74
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $6d75
	cp a, $01 ; $6d78
	ld a, $00 ; $6d7a
	ret nz ; $6d7c
	ld a, $57 ; $6d7d
	ld b, $00 ; $6d7f
	call QueueDrillResultMessage ; $6d81
	call RecordDrillTargetZoneHit ; $6d84
	call CheckDrillTargetZoneMissed ; $6d87
	or a, a ; $6d8a
	jp nz, .nonZero ; $6d8b
	ld a, $5a ; $6d8e
	ld b, $00 ; $6d90
	call QueueDrillResultMessage ; $6d92
	ld hl, $c2ea ; $6d95
	inc [hl] ; $6d98
	jp .storeMatchAbortFlag ; $6d99
.step:
	xor a, a ; $6d9c
	ret ; $6d9d
.nonZero:
	ld a, $01 ; $6d9e
	ld [wMatchAbortFlag], a ; $6da0
	ld a, $01 ; $6da3
	ret ; $6da5
.storeMatchAbortFlag:
	ld a, $01 ; $6da6
	ld [wMatchAbortFlag], a ; $6da8
	ld a, $ff ; $6dab
	ret ; $6dad
StrokePractice2Drill:
	; $6dae, 16 bytes (drill_definition)
	db $47, $09, $02, $05, $10, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokePractice2Hooks, StrokePracticePointTable, StrokePractice2DrillInit ; mode hooks, point table, init
	db $00, $00
StrokePractice2DrillInit:
	ld a, $01 ; $6dbe
	ld [$c7bb], a ; $6dc0
	ret ; $6dc3
StrokePractice2Hooks:
	call c, $e06d ; $6dc4
	ld l, l ; $6dc7
	dec l ; $6dc8
	ld l, [hl] ; $6dc9
	call nc, $a36d ; $6dca
	ld l, [hl] ; $6dcd
	sbc a, a ; $6dce
	ld l, [hl] ; $6dcf
	sub a, d ; $6dd0
	ld l, [hl] ; $6dd1
	xor a, [hl] ; $6dd2
	inc bc ; $6dd3
StrokePractice2Hook_MinigameStart:
	xor a, a ; $6dd4
	ld [$c2e9], a ; $6dd5
	ld [$c2ee], a ; $6dd8
	ret ; $6ddb
StrokePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6ddc
	ret ; $6ddf
StrokePractice2Hook_PointStart:
	xor a, a ; $6de0
	ld [$c2e1], a ; $6de1
	ld a, $0a ; $6de4
	ld [$c2e0], a ; $6de6
	xor a, a ; $6de9
	ld [wTargetZoneEnabled], a ; $6dea
	ld hl, DrillPositions_0b_6ea7 ; $6ded
	call SetDrillTargetZoneForPoint ; $6df0
	xor a, a ; $6df3
	ld [$c2e6], a ; $6df4
	xor a, a ; $6df7
	ld [$c2ff], a ; $6df8
	ld a, $5a ; $6dfb
	ld [$c2ef], a ; $6dfd
	ld a, $01 ; $6e00
	ld hl, StrokePractice2TargetZoneDelayTask ; $6e02
	call RegisterFrameTask ; $6e05
	ld a, [wTotalPointsScoredInCurrentGame] ; $6e08
	ld hl, Table_0b_6e18 ; $6e0b
	add a, l ; $6e0e
	ld l, a ; $6e0f
	jr nc, .read ; $6e10
	inc h ; $6e12
.read:
	ld a, [hl] ; $6e13
	ld [$c7b5], a ; $6e14
	ret ; $6e17
Table_0b_6e18:
	; $6e18, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
StrokePractice2TargetZoneDelayTask:
	ld hl, $c2ef ; $6e1c
	dec [hl] ; $6e1f
	ret nz ; $6e20
	ld a, $01 ; $6e21
	ld [wTargetZoneEnabled], a ; $6e23
	ld hl, StrokePractice2TargetZoneDelayTask ; $6e26
	call UnregisterFrameTask ; $6e29
	ret ; $6e2c
StrokePractice2Hook_PointEnd:
	call StrokePractice2JudgeShot0 ; $6e2d
	call StrokePractice2HandlePointEnd ; $6e30
	ld a, [wTotalPointsScoredInCurrentGame] ; $6e33
	cp a, $04 ; $6e36
	ret c ; $6e38
	call StrokePractice2EvaluateResult ; $6e39
	ld [wPointWinLoseFlag], a ; $6e3c
	ret ; $6e3f
StrokePractice2EvaluateResult:
	ld a, [$c2ee] ; $6e40
	cp a, $04 ; $6e43
	jr nz, .ne04 ; $6e45
	xor a, a ; $6e47
	ld [$c2e3], a ; $6e48
	ld a, $01 ; $6e4b
	ret ; $6e4d
.ne04:
	ld a, [$c2ee] ; $6e4e
	cp a, $03 ; $6e51
	jr c, .lt03 ; $6e53
	ld a, $05 ; $6e55
	ld [$c2e3], a ; $6e57
	jr .notFound ; $6e5a
.lt03:
	ld a, [$c2e9] ; $6e5c
	cp a, $04 ; $6e5f
	jr nc, .checkRallyLength ; $6e61
	ld a, $01 ; $6e63
	ld [$c2e3], a ; $6e65
	jr .notFound ; $6e68
.checkRallyLength:
	ld a, [wRallyLength] ; $6e6a
	cp a, $03 ; $6e6d
	jr nc, .step3 ; $6e6f
	ld a, [$c4a1] ; $6e71
	cp a, $01 ; $6e74
	jr nz, .compare ; $6e76
	ld a, $02 ; $6e78
	ld [$c2e3], a ; $6e7a
	jr .notFound ; $6e7d
.compare:
	cp a, $02 ; $6e7f
	jr nz, .step3 ; $6e81
	ld a, $03 ; $6e83
	ld [$c2e3], a ; $6e85
	jr .notFound ; $6e88
.step3:
	ld a, $04 ; $6e8a
	ld [$c2e3], a ; $6e8c
.notFound:
	ld a, $ff ; $6e8f
	ret ; $6e91
StrokePractice2Hook_RallyTick:
	call StrokePractice2JudgeShot3 ; $6e92
	ld a, [wRallyLength] ; $6e95
	cp a, $02 ; $6e98
	ret nz ; $6e9a
	call ResetActiveCharState ; $6e9b
	ret ; $6e9e
StrokePractice2Hook_Bounce:
	call StrokePractice2JudgeShot2 ; $6e9f
	ret ; $6ea2
StrokePractice2Hook_BallHit:
	call StrokePractice2JudgeShot1 ; $6ea3
	ret ; $6ea6
DrillPositions_0b_6ea7:
	; $6ea7, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $fe50, $fb20 ; record 0
	dw $0000, $fd60 ; record 1
	dw $0000, $fb20 ; record 2
	dw $01b0, $fd60 ; record 3
	dw $0000, $02a0 ; record 4
	dw $01b0, $04e0 ; record 5
	dw $fe50, $02a0 ; record 6
	dw $0000, $04e0 ; record 7
	db $ff, $ff
StrokePractice2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6ec9
	ld a, [$c2ff] ; $6ecc
	ld [wPointWinLoseFlag], a ; $6ecf
	cp a, $01 ; $6ed2
	jr nz, .recordDrillPointResultBits ; $6ed4
	ld hl, $c2ee ; $6ed6
	inc [hl] ; $6ed9
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $6eda
	call ShowQueuedDrillMessage ; $6edd
	farcall UpdatePointStats ; $6ee0
	farcall AwardPoint ; $6ee3
	ld a, [$c2ee] ; $6ee6
	ld [wPlayer1PointsWon], a ; $6ee9
	xor a, a ; $6eec
	ld [wPlayer2PointsWon], a ; $6eed
	ld a, [wPlayer1PointsWon] ; $6ef0
	ld b, $01 ; $6ef3
	farcall LoadPlayer1PointsDigitGfx ; $6ef5
	ld a, [wPlayer2PointsWon] ; $6ef8
	ld b, $01 ; $6efb
	farcall LoadPlayer2PointsDigitGfx ; $6efd
	farcall StepMatchFrame ; $6f00
	ld a, $01 ; $6f03
	ld hl, SyncPointWinLoseFlagTask ; $6f05
	call RegisterFrameTask ; $6f08
	farcall StartPointEndReactions ; $6f0b
	ld hl, SyncPointWinLoseFlagTask ; $6f0e
	call UnregisterFrameTask ; $6f11
	call PlayDrillPointEndSequence ; $6f14
	ret ; $6f17
StrokePractice2JudgeShot0:
	ld a, $00 ; $6f18
	call StrokePractice2JudgePoint ; $6f1a
	ld [$c2ff], a ; $6f1d
	ret ; $6f20
StrokePractice2JudgeShot1:
	ld a, $01 ; $6f21
	call StrokePractice2JudgePoint ; $6f23
	ld [$c2ff], a ; $6f26
	ret ; $6f29
StrokePractice2JudgeShot2:
	ld a, $02 ; $6f2a
	call StrokePractice2JudgePoint ; $6f2c
	ld [$c2ff], a ; $6f2f
	ret ; $6f32
StrokePractice2JudgeShot3:
	ret ; $6f33
	ld a, $03 ; $6f34
	call StrokePractice2JudgePoint ; $6f36
	ld [$c2ff], a ; $6f39
	ret ; $6f3c
StrokePractice2JudgePoint:
	ld b, a ; $6f3d
	ld a, [$c2ff] ; $6f3e
	or a, a ; $6f41
	ret nz ; $6f42
	ld a, [wRallyLength] ; $6f43
	dec a ; $6f46
	ld a, a ; $6f47
	rst Rst00 ; $6f48
	dw StrokePractice2JudgePoint.rally1 ; $6f49 jumptable
	dw StrokePractice2Cases1.step3 ; $6f4b jumptable
.rally1:
	ld a, b ; $6f4d
	ld a, a ; $6f4e
	rst Rst00 ; $6f4f
	dw StrokePractice2JudgePoint.result0 ; $6f50 jumptable
	dw StrokePractice2Cases1 ; $6f52 jumptable
	dw StrokePractice2Cases1.step ; $6f54 jumptable
	dw StrokePractice2Cases1.step2 ; $6f56 jumptable
.result0:
	ld a, [wPointOutcome] ; $6f58
	ld hl, DrillShotTable_0b_6f77 ; $6f5b
	add a, l ; $6f5e
	ld l, a ; $6f5f
	jr nc, .readEntry1 ; $6f60
	inc h ; $6f62
.readEntry1:
	ld a, [hl] ; $6f63
	ld a, a ; $6f64
	ld b, $00 ; $6f65
	call QueueDrillResultMessage ; $6f67
	ld a, [wPointOutcome] ; $6f6a
	ld hl, SignedTable_0b_46fb ; $6f6d
	add a, l ; $6f70
	ld l, a ; $6f71
	jr nc, .readEntry2 ; $6f72
	inc h ; $6f74
.readEntry2:
	ld a, [hl] ; $6f75
	ret ; $6f76
DrillShotTable_0b_6f77:
	; $6f77, 10 bytes (bytes:10)
	db $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59 ; 0x00
StrokePractice2Cases1:
	xor a, a ; $6f81
	ret ; $6f82
.step:
	xor a, a ; $6f83
	ret ; $6f84
.step2:
	xor a, a ; $6f85
	ret ; $6f86
.step3:
	ld a, b ; $6f87
	ld a, a ; $6f88
	rst Rst00 ; $6f89
	dw StrokePractice2Cases1.checkPointOutcome ; $6f8a jumptable
	dw StrokePractice2Cases2 ; $6f8c jumptable
	dw StrokePractice2Cases2.checkBallBounceCount ; $6f8e jumptable
	dw StrokePractice2Cases2.step ; $6f90 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6f92
	ld hl, DrillShotTable_0b_6fb1 ; $6f95
	add a, l ; $6f98
	ld l, a ; $6f99
	jr nc, .read ; $6f9a
	inc h ; $6f9c
.read:
	ld a, [hl] ; $6f9d
	ld a, a ; $6f9e
	ld b, $00 ; $6f9f
	call QueueDrillResultMessage ; $6fa1
	ld a, [wPointOutcome] ; $6fa4
	ld hl, SignedTable_0b_46f1 ; $6fa7
	add a, l ; $6faa
	ld l, a ; $6fab
	jr nc, .readB ; $6fac
	inc h ; $6fae
.readB:
	ld a, [hl] ; $6faf
	ret ; $6fb0
DrillShotTable_0b_6fb1:
	; $6fb1, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57 ; 0x00
StrokePractice2Cases2:
	ld a, [wBallBounceCount] ; $6fbb
	or a, a ; $6fbe
	ret z ; $6fbf
	ld a, $5b ; $6fc0
	ld b, $00 ; $6fc2
	call QueueDrillResultMessage ; $6fc4
	ld a, [wCurrentShotType] ; $6fc7
	cp a, $0a ; $6fca
	jp nz, .storeMatchAbortFlag ; $6fcc
	ld hl, $c2e9 ; $6fcf
	inc [hl] ; $6fd2
	xor a, a ; $6fd3
	ret ; $6fd4
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $6fd5
	cp a, $01 ; $6fd8
	ld a, $00 ; $6fda
	ret nz ; $6fdc
	ld a, $58 ; $6fdd
	ld b, $00 ; $6fdf
	call QueueDrillResultMessage ; $6fe1
	call RecordDrillTargetZoneHit ; $6fe4
	call CheckDrillTargetZoneMissed ; $6fe7
	or a, a ; $6fea
	jp nz, .nonZero ; $6feb
	ld a, $5a ; $6fee
	ld b, $00 ; $6ff0
	call QueueDrillResultMessage ; $6ff2
	ld hl, $c2ea ; $6ff5
	inc [hl] ; $6ff8
	jp .storeMatchAbortFlag ; $6ff9
.step:
	xor a, a ; $6ffc
	ret ; $6ffd
.nonZero:
	ld a, $01 ; $6ffe
	ld [wMatchAbortFlag], a ; $7000
	ld a, $01 ; $7003
	ret ; $7005
.storeMatchAbortFlag:
	ld a, $01 ; $7006
	ld [wMatchAbortFlag], a ; $7008
	ld a, $ff ; $700b
	ret ; $700d
StrokePractice3Drill:
	; $700e, 16 bytes (drill_definition)
	db $48, $09, $02, $05, $11, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokePractice3Hooks, StrokePracticePointTable, StrokePractice3DrillInit ; mode hooks, point table, init
	db $00, $00
StrokePractice3DrillInit:
	ld a, $01 ; $701e
	ld [$c7bb], a ; $7020
	ret ; $7023
StrokePractice3Hooks:
	; $7024, 16 bytes (mode_hooks)
	dw StrokePractice3Hook_PerFrame ; record 0
	dw StrokePractice3Hook_PointStart ; record 1
	dw StrokePractice3Hook_PointEnd ; record 2
	dw StrokePractice3Hook_MinigameStart ; record 3
	dw StrokePractice3Hook_BallHit ; record 4
	dw StrokePractice3Hook_Bounce ; record 5
	dw StrokePractice3Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokePractice3Hook_MinigameStart:
	ld a, $01 ; $7034
	ld [$c7bb], a ; $7036
	xor a, a ; $7039
	ld [$c2e9], a ; $703a
	ld [$c2e8], a ; $703d
	ret ; $7040
StrokePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $7041
	ret ; $7044
StrokePractice3Hook_PointStart:
	xor a, a ; $7045
	ld [$c2e1], a ; $7046
	ld a, $0a ; $7049
	ld [$c2e0], a ; $704b
	xor a, a ; $704e
	ld [wTargetZoneEnabled], a ; $704f
	ld hl, DrillPositions_0b_7109 ; $7052
	call SetDrillTargetZoneForPoint ; $7055
	xor a, a ; $7058
	ld [$c2e6], a ; $7059
	xor a, a ; $705c
	ld [$c2ff], a ; $705d
	ld a, $5a ; $7060
	ld [$c2ef], a ; $7062
	ld a, $01 ; $7065
	ld hl, StrokePractice3TargetZoneDelayTask ; $7067
	call RegisterFrameTask ; $706a
	ld a, [wTotalPointsScoredInCurrentGame] ; $706d
	ld hl, Table_0b_707d ; $7070
	add a, l ; $7073
	ld l, a ; $7074
	jr nc, .read ; $7075
	inc h ; $7077
.read:
	ld a, [hl] ; $7078
	ld [$c7b5], a ; $7079
	ret ; $707c
Table_0b_707d:
	; $707d, 4 bytes (bytes:4)
	db $00, $00, $00, $00 ; 0x00
StrokePractice3TargetZoneDelayTask:
	ld hl, $c2ef ; $7081
	dec [hl] ; $7084
	ret nz ; $7085
	ld a, $01 ; $7086
	ld [wTargetZoneEnabled], a ; $7088
	ld hl, StrokePractice3TargetZoneDelayTask ; $708b
	call UnregisterFrameTask ; $708e
	ret ; $7091
StrokePractice3Hook_PointEnd:
	call StrokePractice3JudgeShot0 ; $7092
	call StrokePractice3HandlePointEnd ; $7095
	ld a, [wTotalPointsScoredInCurrentGame] ; $7098
	cp a, $04 ; $709b
	ret c ; $709d
	call StrokePractice3EvaluateResult ; $709e
	ld [wPointWinLoseFlag], a ; $70a1
	ret ; $70a4
StrokePractice3EvaluateResult:
	ld a, [$c2e9] ; $70a5
	cp a, $04 ; $70a8
	jr nz, .ne04 ; $70aa
	xor a, a ; $70ac
	ld [$c2e3], a ; $70ad
	ld a, $01 ; $70b0
	ret ; $70b2
.ne04:
	ld a, [$c2e8] ; $70b3
	cp a, $04 ; $70b6
	jr c, .compare ; $70b8
	ld a, $01 ; $70ba
	ld [$c2e3], a ; $70bc
	jr .notFound ; $70bf
.compare:
	cp a, $02 ; $70c1
	jr c, .lt02 ; $70c3
	ld a, $02 ; $70c5
	ld [$c2e3], a ; $70c7
	jr .notFound ; $70ca
.lt02:
	ld a, [$c2e9] ; $70cc
	or a, a ; $70cf
	jr nz, .compare2 ; $70d0
	ld a, $03 ; $70d2
	ld [$c2e3], a ; $70d4
	jr .notFound ; $70d7
.compare2:
	cp a, $03 ; $70d9
	jr nz, .ne03 ; $70db
	ld a, $05 ; $70dd
	ld [$c2e3], a ; $70df
	jr .notFound ; $70e2
.ne03:
	ld a, $04 ; $70e4
	ld [$c2e3], a ; $70e6
	jr .notFound ; $70e9
.notFound:
	ld a, $ff ; $70eb
	ret ; $70ed
StrokePractice3Hook_RallyTick:
	call StrokePractice3JudgeShot3 ; $70ee
	ld a, [wRallyLength] ; $70f1
	cp a, $02 ; $70f4
	ret nz ; $70f6
	call ResetActiveCharState ; $70f7
	ret ; $70fa
StrokePractice3Hook_Bounce:
	call StrokePractice3JudgeShot2 ; $70fb
	ret ; $70fe
StrokePractice3Hook_BallHit:
	call StrokePractice3JudgeShot1 ; $70ff
	ld a, [wRallyLength] ; $7102
	cp a, $01 ; $7105
	ret nz ; $7107
	ret ; $7108
DrillPositions_0b_7109:
	; $7109, 34 bytes (records:4)
; 8 records x 4 bytes
	dw $0120, $fb20 ; record 0
	dw $01b0, $fd60 ; record 1
	dw $fe50, $fb20 ; record 2
	dw $fee0, $fd60 ; record 3
	dw $fe50, $02a0 ; record 4
	dw $fee0, $04e0 ; record 5
	dw $0120, $02a0 ; record 6
	dw $01b0, $04e0 ; record 7
	db $ff, $ff
StrokePractice3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $712b
	ld a, [$c2ff] ; $712e
	ld [wPointWinLoseFlag], a ; $7131
	cp a, $01 ; $7134
	jr nz, .recordDrillPointResultBits ; $7136
	ld hl, $c2e9 ; $7138
	inc [hl] ; $713b
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $713c
	call ShowQueuedDrillMessage ; $713f
	farcall UpdatePointStats ; $7142
	farcall AwardPoint ; $7145
	ld a, [$c2e9] ; $7148
	ld [wPlayer1PointsWon], a ; $714b
	xor a, a ; $714e
	ld [wPlayer2PointsWon], a ; $714f
	ld a, [wPlayer1PointsWon] ; $7152
	ld b, $01 ; $7155
	farcall LoadPlayer1PointsDigitGfx ; $7157
	ld a, [wPlayer2PointsWon] ; $715a
	ld b, $01 ; $715d
	farcall LoadPlayer2PointsDigitGfx ; $715f
	farcall StepMatchFrame ; $7162
	ld a, $01 ; $7165
	ld hl, SyncPointWinLoseFlagTask ; $7167
	call RegisterFrameTask ; $716a
	farcall StartPointEndReactions ; $716d
	ld hl, SyncPointWinLoseFlagTask ; $7170
	call UnregisterFrameTask ; $7173
	call PlayDrillPointEndSequence ; $7176
	ret ; $7179
StrokePractice3JudgeShot0:
	ld a, $00 ; $717a
	call StrokePractice3JudgePoint ; $717c
	ld [$c2ff], a ; $717f
	ret ; $7182
StrokePractice3JudgeShot1:
	ld a, $01 ; $7183
	call StrokePractice3JudgePoint ; $7185
	ld [$c2ff], a ; $7188
	ret ; $718b
StrokePractice3JudgeShot2:
	ld a, $02 ; $718c
	call StrokePractice3JudgePoint ; $718e
	ld [$c2ff], a ; $7191
	ret ; $7194
StrokePractice3JudgeShot3:
	ret ; $7195
	ld a, $03 ; $7196
	call StrokePractice3JudgePoint ; $7198
	ld [$c2ff], a ; $719b
	ret ; $719e
StrokePractice3JudgePoint:
	ld b, a ; $719f
	ld a, [$c2ff] ; $71a0
	or a, a ; $71a3
	ret nz ; $71a4
	ld a, [wRallyLength] ; $71a5
	dec a ; $71a8
	ld a, a ; $71a9
	rst Rst00 ; $71aa
	dw StrokePractice3JudgePoint.rally1 ; $71ab jumptable
	dw StrokePractice3Cases1.step3 ; $71ad jumptable
.rally1:
	ld a, b ; $71af
	ld a, a ; $71b0
	rst Rst00 ; $71b1
	dw StrokePractice3JudgePoint.result0 ; $71b2 jumptable
	dw StrokePractice3Cases1 ; $71b4 jumptable
	dw StrokePractice3Cases1.step ; $71b6 jumptable
	dw StrokePractice3Cases1.step2 ; $71b8 jumptable
.result0:
	ld a, [wPointOutcome] ; $71ba
	ld hl, DrillShotTable_0b_71d9 ; $71bd
	add a, l ; $71c0
	ld l, a ; $71c1
	jr nc, .readEntry1 ; $71c2
	inc h ; $71c4
.readEntry1:
	ld a, [hl] ; $71c5
	ld a, a ; $71c6
	ld b, $00 ; $71c7
	call QueueDrillResultMessage ; $71c9
	ld a, [wPointOutcome] ; $71cc
	ld hl, SignedTable_0b_46fb ; $71cf
	add a, l ; $71d2
	ld l, a ; $71d3
	jr nc, .readEntry2 ; $71d4
	inc h ; $71d6
.readEntry2:
	ld a, [hl] ; $71d7
	ret ; $71d8
DrillShotTable_0b_71d9:
	; $71d9, 10 bytes (bytes:10)
	db $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59 ; 0x00
StrokePractice3Cases1:
	xor a, a ; $71e3
	ret ; $71e4
.step:
	xor a, a ; $71e5
	ret ; $71e6
.step2:
	xor a, a ; $71e7
	ret ; $71e8
.step3:
	ld a, b ; $71e9
	ld a, a ; $71ea
	rst Rst00 ; $71eb
	dw StrokePractice3Cases1.checkPointOutcome ; $71ec jumptable
	dw StrokePractice3Cases2 ; $71ee jumptable
	dw StrokePractice3Cases2.checkBallBounceCount ; $71f0 jumptable
	dw StrokePractice3Cases2.step ; $71f2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $71f4
	ld hl, DrillShotTable_0b_7213 ; $71f7
	add a, l ; $71fa
	ld l, a ; $71fb
	jr nc, .read ; $71fc
	inc h ; $71fe
.read:
	ld a, [hl] ; $71ff
	ld a, a ; $7200
	ld b, $00 ; $7201
	call QueueDrillResultMessage ; $7203
	ld a, [wPointOutcome] ; $7206
	ld hl, SignedTable_0b_46f1 ; $7209
	add a, l ; $720c
	ld l, a ; $720d
	jr nc, .readB ; $720e
	inc h ; $7210
.readB:
	ld a, [hl] ; $7211
	ret ; $7212
DrillShotTable_0b_7213:
	; $7213, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57 ; 0x00
StrokePractice3Cases2:
	xor a, a ; $721d
	ret ; $721e
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $721f
	cp a, $01 ; $7222
	ld a, $00 ; $7224
	ret nz ; $7226
	ld a, $57 ; $7227
	ld b, $00 ; $7229
	call QueueDrillResultMessage ; $722b
	call RecordDrillTargetZoneHit ; $722e
	call CheckDrillTargetZoneMissed ; $7231
	or a, a ; $7234
	jp nz, .nonZero ; $7235
	ld a, $5a ; $7238
	ld b, $00 ; $723a
	call QueueDrillResultMessage ; $723c
	ld hl, $c2ea ; $723f
	inc [hl] ; $7242
	jp .storeMatchAbortFlag ; $7243
.step:
	xor a, a ; $7246
	ret ; $7247
.nonZero:
	ld a, $01 ; $7248
	ld [wMatchAbortFlag], a ; $724a
	ld a, $01 ; $724d
	ret ; $724f
.storeMatchAbortFlag:
	ld a, $01 ; $7250
	ld [wMatchAbortFlag], a ; $7252
	ld a, $ff ; $7255
	ret ; $7257
RunDoublesDrillMatch:
	xor a, a ; $7258
	ld [$c8f5], a ; $7259
	ld a, $08 ; $725c
	ld [wGameMode], a ; $725e
	ld a, $02 ; $7261
	ld [wCurrentMinigameStoryMatch], a ; $7263
	ld a, $24 ; $7266
	ld [wCurrentMinigameStoryMatch + 1], a ; $7268
	ld a, $15 ; $726b
	ld [wMatchBGM], a ; $726d
	ld a, $01 ; $7270
	ld [wMatchIsDoubles], a ; $7272
	ld a, $03 ; $7275
	ld [wOnCourtCharCount], a ; $7277
	ld a, $17 ; $727a
	ld [wCurrentlyUsedCourt], a ; $727c
	ld b, $1d ; $727f
	ld a, b ; $7281
	ld [wMatchPlayerChar], a ; $7282
	ld c, $00 ; $7285
	farcall InitCa00RecordFromCharId ; $7287
	ld b, $1b ; $728a
	ld a, b ; $728c
	ld [wMatchOpponentChar], a ; $728d
	ld c, $02 ; $7290
	farcall InitCa00RecordFromCharId ; $7292
	ld b, $1e ; $7295
	ld c, $03 ; $7297
	farcall InitCa00RecordFromCharId ; $7299
	ld a, [wMinigameLevel] ; $729c
	add a, a ; $729f
	add a, $e0 ; $72a0
	ld l, a ; $72a2
	adc a, $72 ; $72a3
	sub a, l ; $72a5
	ld h, a ; $72a6
	ld a, [hl+] ; $72a7
	ld h, [hl] ; $72a8
	ld l, a ; $72a9
	ld a, [hl+] ; $72aa
	ld [wMatchTypeNumberOfGames], a ; $72ab
	ld a, [hl+] ; $72ae
	ld [wMatchTypeNumberOfSets], a ; $72af
	push hl ; $72b2
	ld a, [hl+] ; $72b3
	ld [$ca9b], a ; $72b4
	ld a, [hl+] ; $72b7
	ld [$ca9c], a ; $72b8
	ld a, [hl+] ; $72bb
	ld [$ca9d], a ; $72bc
	ld a, [hl+] ; $72bf
	ld [$ca9e], a ; $72c0
	ld a, [hl+] ; $72c3
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $72c4
	pop hl ; $72c7
	ld a, [hl+] ; $72c8
	ld [$cadb], a ; $72c9
	ld a, [hl+] ; $72cc
	ld [$cadc], a ; $72cd
	ld a, [hl+] ; $72d0
	ld [$cadd], a ; $72d1
	ld a, [hl+] ; $72d4
	ld [$cade], a ; $72d5
	ld a, [hl+] ; $72d8
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $72d9
	farcall RunMatch ; $72dc
	ret ; $72df
	; $72e0, 27 bytes (records:2)
	dw $72e6 ; record 0
	dw $72ed ; record 1
	dw $72f4 ; record 2
	dw $0106 ; record 3
	dw $1324 ; record 4
	dw $1e12 ; record 5
	dw $0600 ; record 6
	dw $1403 ; record 7
	dw $0a0f ; record 8
	dw $0164 ; record 9
	dw $0506 ; record 10
	dw $0a0e ; record 11
	dw $b402 ; record 12
	db $03
	; $72fb, 3333 bytes fill to bank end (linker-padded)
