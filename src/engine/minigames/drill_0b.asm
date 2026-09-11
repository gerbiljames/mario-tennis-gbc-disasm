	farptr RunTrainingDrillByID ; $4000
; Instruction-identical to InitMinigameFromConfig (one copy per bank); a change here belongs in every copy.
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
	ld a, MATCHLIST_TRAINING ; $4022
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
	cp CHAR_NONE ; $404b
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
	or l ; $4074
	jr z, .done ; $4075
	call JumpToHL ; $4077
.done:
	ret ; $407a
RecordDrillPointResultBits:
	ld a, [wPointWinLoseFlag] ; $407b
	or a ; $407e
	ret z ; $407f
	and $03 ; $4080
	ld b, a ; $4082
	rrc a ; $4083
	rrc a ; $4085
	ld c, a ; $4087
	ld a, [wTotalPointsScoredInCurrentGame] ; $4088
	ld b, a ; $408b
	ld hl, DrillPointResultBitsTable ; $408c
	ld a, [wDrillIsPracticeLesson] ; $408f
	or a ; $4092
	jr nz, .storeBits ; $4093
	ld a, b ; $4095
	and $01 ; $4096
	add a ; $4098
	add l ; $4099
	ld l, a ; $409a
	jr nc, .checkOddPoint ; $409b
	inc h ; $409d
.checkOddPoint:
	srl b ; $409e
	ld a, [wTotalPointsScoredInCurrentGame] ; $40a0
	and $01 ; $40a3
	jr z, .storeBits ; $40a5
	ld a, c ; $40a7
	xor $80 ; $40a8
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
	or [hl] ; $40b9
	ld [hl], a ; $40ba
	ret ; $40bb
DrillPointResultBitsTable:
	; $40bc, 4 bytes (ram_ptrs:0)
	dw wDrillShotResultBits ; record 0
	dw wDrillShotResultBits + 1 ; record 1
CountDrillShotSuccesses:
	push bc ; $40c0
	push hl ; $40c1
	ld hl, wDrillShotResultBits ; $40c2
	add l ; $40c5
	ld l, a ; $40c6
	jr nc, .gotSlot ; $40c7
	inc h ; $40c9
.gotSlot:
	ld c, $00 ; $40ca
	ld a, [hl] ; $40cc
	ld b, a ; $40cd
	and $03 ; $40ce
	cp $01 ; $40d0
	jr nz, .checkShot2 ; $40d2
	inc c ; $40d4
.checkShot2:
	ld a, b ; $40d5
	srl a ; $40d6
	srl a ; $40d8
	and $03 ; $40da
	cp $01 ; $40dc
	jr nz, .checkShot3 ; $40de
	inc c ; $40e0
.checkShot3:
	ld a, b ; $40e1
	swap a ; $40e2
	and $03 ; $40e4
	cp $01 ; $40e6
	jr nz, .checkShot4 ; $40e8
	inc c ; $40ea
.checkShot4:
	ld a, b ; $40eb
	swap a ; $40ec
	srl a ; $40ee
	srl a ; $40f0
	and $03 ; $40f2
	cp $01 ; $40f4
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
	sub b ; $4104
	bit 7, a ; $4105
	jr nz, .player2Ahead ; $4107
	cp $02 ; $4109
	jr c, .tied ; $410b
	ld a, $01 ; $410d
	ret ; $410f
.player2Ahead:
	cpl ; $4110
	inc a ; $4111
	cp $02 ; $4112
	jr c, .tied ; $4114
	ld a, $02 ; $4116
	ret ; $4118
.tied:
	xor a ; $4119
	ret ; $411a
Unused_0b_0:
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
UnusedGetObjectXAndDepth:
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
	push_wram_bank $05 ; $414b
	ld a, CHARSTATE_INERT ; $4154
	farcall SetCharState ; $4156
	pop_wram_bank ; $4159
	ret ; $415e
IndexDrillTableByPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $415f
	add a ; $4162
	add a ; $4163
	add a ; $4164
	add l ; $4165
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
	add a ; $4194
	add a ; $4195
	add a ; $4196
	add l ; $4197
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
	ld a, [wDrillAbortCountdownActive] ; $41c3
	or a ; $41c6
	ret z ; $41c7
	ld a, [wPointOutcome] ; $41c8
	or a ; $41cb
	ret nz ; $41cc
	ld hl, wDrillAbortCountdown ; $41cd
	dec [hl] ; $41d0
	ld a, [hl] ; $41d1
	or a ; $41d2
	ret nz ; $41d3
	ld a, MATCHABORT_POINT ; $41d4
	ld [wMatchAbortFlag], a ; $41d6
	ret ; $41d9
RecordDrillTargetZoneHitIfInPlay:
	ld a, [wPointOutcome] ; $41da
	cp POINTOUTCOME_NET ; $41dd
	ret z ; $41df
	cp POINTOUTCOME_FAULT ; $41e0
	ret z ; $41e2
	cp POINTOUTCOME_LET ; $41e3
	ret z ; $41e5
RecordDrillTargetZoneHit:
	ld a, [wBallBounceCount] ; $41e6
	cp $02 ; $41e9
	ret nc ; $41eb
	farcall IsBallInTargetZone ; $41ec
	jr z, .setBit ; $41ef
	xor a ; $41f1
	ld [wTargetZoneEnabled], a ; $41f2
	ret ; $41f5
.setBit:
	ld a, [wTotalPointsScoredInCurrentGame] ; $41f6
	ld b, a ; $41f9
	inc b ; $41fa
	xor a ; $41fb
	scf ; $41fc
.shiftLoop:
	rla ; $41fd
	dec b ; $41fe
	jr nz, .shiftLoop ; $41ff
	ld hl, wDrillTargetZoneHitBits ; $4201
	or [hl] ; $4204
	ld [hl], a ; $4205
	ret ; $4206
Table_0b_0:
	; $4207, 4 bytes (bytes:4)
	db $03, $02, $00, $01 ; 0x00
CountDrillResultBitsSet:
	push bc ; $420b
	ld a, [wDrillTargetZoneHitBits] ; $420c
	ld b, a ; $420f
	xor a ; $4210
	ld c, $08 ; $4211
.shiftLoop:
	rr b ; $4213
	adc $00 ; $4215
	dec c ; $4217
	jr nz, .shiftLoop ; $4218
	pop bc ; $421a
	ret ; $421b
CheckDrillTargetZoneMissed:
	push bc ; $421c
	ld a, [wTotalPointsScoredInCurrentGame] ; $421d
	ld c, a ; $4220
	inc c ; $4221
	ld a, [wDrillTargetZoneHitBits] ; $4222
	ld b, a ; $4225
.shiftLoop:
	ld a, $00 ; $4226
	rr b ; $4228
	adc $00 ; $422a
	dec c ; $422c
	jr nz, .shiftLoop ; $422d
	xor $01 ; $422f
	pop bc ; $4231
	ret ; $4232
RecordGateCrossOnServe:
	ld a, [wRallyLength] ; $4233
	cp $01 ; $4236
	ret nz ; $4238
	ld a, [wDrillGateActive] ; $4239
	or a ; $423c
	ret z ; $423d
	farcall DidBallCrossGate ; $423e
	ret z ; $4241
	xor a ; $4242
	ld [wDrillGateActive], a ; $4243
	ld a, [wTotalPointsScoredInCurrentGame] ; $4246
	ld b, a ; $4249
	inc b ; $424a
	xor a ; $424b
	scf ; $424c
.loop:
	rla ; $424d
	dec b ; $424e
	jr nz, .loop ; $424f
	ld hl, wDrillGateCrossBits ; $4251
	or [hl] ; $4254
	ld [hl], a ; $4255
	ret ; $4256
CountDrillResultBitsSetAlt:
	push bc ; $4257
	ld a, [wDrillGateCrossBits] ; $4258
	ld b, a ; $425b
	xor a ; $425c
	ld c, $08 ; $425d
.loop:
	rr b ; $425f
	adc $00 ; $4261
	dec c ; $4263
	jr nz, .loop ; $4264
	pop bc ; $4266
	ret ; $4267
CountDrillResultBitsThisGame:
	push bc ; $4268
	ld a, [wTotalPointsScoredInCurrentGame] ; $4269
	ld c, a ; $426c
	inc c ; $426d
	ld a, [wDrillGateCrossBits] ; $426e
	ld b, a ; $4271
.loop:
	ld a, $00 ; $4272
	rr b ; $4274
	adc $00 ; $4276
	dec c ; $4278
	jr nz, .loop ; $4279
	or a ; $427b
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
