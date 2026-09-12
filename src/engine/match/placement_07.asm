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
	INCBIN "data/bank_007/LinkStateBytePtrs_07.bin" ; $4d21, 16 bytes
ShotPlacementDataTopspin_07:
	INCBIN "data/bank_007/ShotPlacementDataTopspin_07.bin" ; $4d31, 80 bytes
ShotPlacementDataPowerTopspin_07:
	INCBIN "data/bank_007/ShotPlacementDataPowerTopspin_07.bin" ; $4d81, 80 bytes
ShotPlacementDataSlice_07:
	INCBIN "data/bank_007/ShotPlacementDataSlice_07.bin" ; $4dd1, 80 bytes
ShotPlacementDataPowerSlice_07:
	INCBIN "data/bank_007/ShotPlacementDataPowerSlice_07.bin" ; $4e21, 80 bytes
ShotPlacementDataNeutral_07:
	INCBIN "data/bank_007/ShotPlacementDataNeutral_07.bin" ; $4e71, 80 bytes
ShotPlacementDataSmash_07:
	INCBIN "data/bank_007/ShotPlacementDataSmash_07.bin" ; $4ec1, 80 bytes
ShotPlacementDataReachBasic_07:
	INCBIN "data/bank_007/ShotPlacementDataReachBasic_07.bin" ; $4f11, 80 bytes
ShotPlacementDataReachPowerTopspin_07:
	INCBIN "data/bank_007/ShotPlacementDataReachPowerTopspin_07.bin" ; $4f61, 80 bytes
ShotPlacementDataReachPowerSlice_07:
	INCBIN "data/bank_007/ShotPlacementDataReachPowerSlice_07.bin" ; $4fb1, 80 bytes
ShotPlacementDataReach_07:
	INCBIN "data/bank_007/ShotPlacementDataReach_07.bin" ; $5001, 80 bytes
ShotPlacementDataLob_07:
	INCBIN "data/bank_007/ShotPlacementDataLob_07.bin" ; $5051, 16 bytes
ShotPlacementDataDrop_07:
	INCBIN "data/bank_007/ShotPlacementDataDrop_07.bin" ; $5061, 16 bytes
ShotPlacementDataServeTopspin_07:
	INCBIN "data/bank_007/ShotPlacementDataServeTopspin_07.bin" ; $5071, 80 bytes
ShotPlacementDataServeSlice_07:
	INCBIN "data/bank_007/ShotPlacementDataServeSlice_07.bin" ; $50c1, 80 bytes
ShotPlacementDataServeFlat_07:
	INCBIN "data/bank_007/ShotPlacementDataServeFlat_07.bin" ; $5111, 80 bytes
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
