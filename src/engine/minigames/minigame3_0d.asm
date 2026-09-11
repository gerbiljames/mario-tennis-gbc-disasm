LoadMatchUiCourtTilemap:
	add a ; $50fa
	ld_hl_indexed TargetShotZoneOverlayOffsets ; $50fb
	ld a, [hl+] ; $5102
	ld b, [hl] ; $5103
	ld c, a ; $5104
	ld hl, TargetShotZoneOverlayAttrs ; $5105
	add hl, bc ; $5108
	push hl ; $5109
	push hl ; $510a
	ld hl, TargetShotZoneOverlayTiles ; $510b
	add hl, bc ; $510e
	push hl ; $510f
	push hl ; $5110
	pop hl ; $5111
	ld de, wCourtTilemapSaved + 9 * TILEMAP_WIDTH + 11 ; $5112
	lb bc, $0a, $05 ; $5115 width, rows
	call CopyTextRect ; $5118
	pop hl ; $511b
	ld de, wCourtTilemap + 9 * TILEMAP_WIDTH + 11 ; $511c
	lb bc, $0a, $05 ; $511f width, rows
	call CopyTextRect ; $5122
	pop hl ; $5125
	ld de, wCourtAttrmapSaved + 9 * TILEMAP_WIDTH + 11 ; $5126
	lb bc, $0a, $05 ; $5129 width, rows
	call CopyTextRect ; $512c
	pop hl ; $512f
	ld de, wCourtAttrmap + 9 * TILEMAP_WIDTH + 11 ; $5130
	lb bc, $0a, $05 ; $5133 width, rows
	call CopyTextRect ; $5136
	ret ; $5139
TargetShotZoneOverlayOffsets:
	; $513a, 14 bytes (records:2)
	dw $0000 ; record 0
	dw $0032 ; record 1
	dw $0064 ; record 2
	dw $0096 ; record 3
	dw $00c8 ; record 4
	dw $0064 ; record 5
	dw $0096 ; record 6
LoadTargetZoneConfig:
	add a ; $5148
	add a ; $5149
	add a ; $514a
	ld_hl_indexed MinigameTargetZoneBounds ; $514b
	ld de, wTargetZoneX1 ; $5152
	ld bc, $0008 ; $5155
	call CopyMemoryBC ; $5158
	ret ; $515b
MinigameTargetZoneBounds:
	; $515c, 56 bytes (bytes:8)
	db $50, $fe, $20, $fb, $00, $00, $00, $00 ; 0x00
	db $00, $00, $20, $fb, $b0, $01, $00, $00 ; 0x08
	db $50, $fe, $60, $fd, $b0, $01, $00, $00 ; 0x10
	db $50, $fe, $20, $fb, $b0, $01, $60, $fd ; 0x18
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x20
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x28
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x30
MinigameConfig_ShootingStar:
	; $5194, 16 bytes (bytes:16)
	db $15, $10, $02, $08, $1d, $19, $00, $17, $b6, $51, $bd, $40, $a4, $51, $00, $00 ; 0x00
InitMinigame_ShootingStar:
	ld a, $01 ; $51a4
	ld [wMinigameUsesTennisMachine], a ; $51a6
	ld a, [wMinigameLevel] ; $51a9
	cp $02 ; $51ac
	jr nz, .done ; $51ae
	ld a, $01 ; $51b0
	ld [wMinigameHighScoreMode], a ; $51b2
.done:
	ret ; $51b5
MinigameHooks_ShootingStar:
	; $51b6, 16 bytes (mode_hooks)
	dw ShootingStarHook_PerFrame ; record 0
	dw ShootingStarHook_PointStart ; record 1
	dw ShootingStarHook_PointEnd ; record 2
	dw ShootingStarHook_MinigameStart ; record 3
	dw ShootingStarHook_BallHit ; record 4
	dw ShootingStarHook_Bounce ; record 5
	dw ShootingStarHook_RallyTick ; record 6
	dw ShootingStarHook_Draw ; record 7
ShootingStarHook_MinigameStart:
	call InitBallTargetActor ; $51c6
	ld a, $01 ; $51c9
	ld [wMinigameServeSlot], a ; $51cb
	call StartMinigameMatch ; $51ce
	ret ; $51d1
ShootingStarHook_PerFrame:
	call DrawMinigameScoreHud ; $51d2
	call UpdateScorePopup ; $51d5
	ret ; $51d8
ShootingStarHook_Draw:
	call UpdateMinigameActors ; $51d9
	ret ; $51dc
ShootingStarHook_PointStart:
	call ResetTargetHitState ; $51dd
	farcall AdvanceMatchRng ; $51e0
	and $01 ; $51e3
	inc a ; $51e5
	ld hl, wMinigameServeSlot ; $51e6
	add [hl] ; $51e9
	cp $03 ; $51ea
	jr c, .store ; $51ec
	sub $03 ; $51ee
.store:
	ld [hl], a ; $51f0
	call LaunchMinigameServe ; $51f1
	ret ; $51f4
ShootingStarHook_PointEnd:
	call EndMinigamePoint ; $51f5
	ret ; $51f8
ShootingStarHook_RallyTick:
	call KeepMinigameCameraFixed ; $51f9
	ret ; $51fc
ShootingStarHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $51fd
	ret ; $5200
ShootingStarHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5201
	ret ; $5204
InitBallTargetActor:
	call ClearMinigameActors ; $5205
	ld de, ShootingStarTargetActorHandler ; $5208
	ld bc, wMinigameActors ; $520b
	call SetMinigameActorHandler ; $520e
	ld hl, $0000 ; $5211
	ld de, $fdc0 ; $5214
	ld bc, wMinigameActors ; $5217
	call SetMinigameActorPosition ; $521a
	ret ; $521d
ResetTargetHitState:
	ld a, [wMinigameHitScored] ; $521e
	and a ; $5221
	jr nz, .nonZero ; $5222
	xor a ; $5224
	ld [wMinigameHitStreak], a ; $5225
.nonZero:
	xor a ; $5228
	ld [wMinigameHitScored], a ; $5229
	xor a ; $522c
	ld [wMinigameActors + 2], a ; $522d
	ret ; $5230
ShootingStarTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5231
	rst Rst00 ; $5234
	dw AdvanceTargetActorState.advanceMatchRng ; $5235 jumptable
	dw AdvanceTargetActorState.drawTargetReticleSprite ; $5237 jumptable
	dw AdvanceTargetActorState.drawTargetHitCountdown ; $5239 jumptable
	dw AdvanceTargetActorState.drawTargetReticleSprite2 ; $523b jumptable
	dw RetStub ; $523d jumptable
AdvanceTargetActorState:
	ld hl, wMinigameSceneActor + 2 ; $523f
	inc [hl] ; $5242
	ret ; $5243
.advanceMatchRng:
	ld a, [wMinigameSceneActor + 3] ; $5244
	and a ; $5247
	jr z, .zero ; $5248
	farcall AdvanceMatchRng ; $524a
	ld h, $00 ; $524d
	ld l, a ; $524f
	add hl, hl ; $5250
	ld de, $ff00 ; $5251
	add hl, de ; $5254
	ld de, $fdc0 ; $5255
	call SetMinigameActorWorldPos ; $5258
.zero:
	xor a ; $525b
	ld [wMinigameSceneActor + 3], a ; $525c
	call AdvanceTargetActorState ; $525f
.drawTargetReticleSprite:
	call DrawTargetReticleSprite ; $5262
	call IsBallInHitZone ; $5265
	and a ; $5268
	ret z ; $5269
	call AwardHitScore ; $526a
	jp AdvanceTargetActorState ; $526d
.drawTargetHitCountdown:
	call DrawTargetHitCountdown ; $5270
	ld hl, wMinigameSceneActor + 3 ; $5273
	dec [hl] ; $5276
	ld a, [hl] ; $5277
	and a ; $5278
	ret nz ; $5279
	farcall AdvanceMatchRng ; $527a
	ld h, $00 ; $527d
	ld l, a ; $527f
	add hl, hl ; $5280
	ld de, $ff00 ; $5281
	add hl, de ; $5284
	ld de, $fdc0 ; $5285
	call SetMinigameActorWorldPos ; $5288
	jp AdvanceTargetActorState ; $528b
.drawTargetReticleSprite2:
	call DrawTargetReticleSprite ; $528e
	ret ; $5291
IsBallInHitZone:
	ld a, [wLastShotCharIndex] ; $5292
	and $01 ; $5295
	jp nz, .returnZero ; $5297
	ld hl, wMinigameSceneActor + 6 ; $529a
	ld a, [hl+] ; $529d
	ld d, [hl] ; $529e
	ld e, a ; $529f
	ld hl, wBallX ; $52a0
	ld a, [hl+] ; $52a3
	ld h, [hl] ; $52a4
	ld l, a ; $52a5
	ld a, l ; $52a6
	sub e ; $52a7
	ld l, a ; $52a8
	ld a, h ; $52a9
	sbc d ; $52aa
	ld h, a ; $52ab
	bit 7, h ; $52ac
	jr z, .positive ; $52ae
	xor a ; $52b0
	sub l ; $52b1
	ld l, a ; $52b2
	sbc a ; $52b3
	sub h ; $52b4
	ld h, a ; $52b5
.positive:
	ld de, $ff80 ; $52b6
	add hl, de ; $52b9
	jr c, .returnZero ; $52ba
	ld hl, wMinigameSceneActor + 8 ; $52bc
	ld a, [hl+] ; $52bf
	ld d, [hl] ; $52c0
	ld e, a ; $52c1
	ld hl, wBallDepth ; $52c2
	ld a, [hl+] ; $52c5
	ld h, [hl] ; $52c6
	ld l, a ; $52c7
	ld a, l ; $52c8
	sub e ; $52c9
	ld l, a ; $52ca
	ld a, h ; $52cb
	sbc d ; $52cc
	ld h, a ; $52cd
	bit 7, h ; $52ce
	jr z, .positive2 ; $52d0
	xor a ; $52d2
	sub l ; $52d3
	ld l, a ; $52d4
	sbc a ; $52d5
	sub h ; $52d6
	ld h, a ; $52d7
.positive2:
	ld de, $ff00 ; $52d8
	add hl, de ; $52db
	jr c, .returnZero ; $52dc
	ld hl, wBallHeight ; $52de
	ld a, [hl+] ; $52e1
	ld h, [hl] ; $52e2
	ld l, a ; $52e3
	bit 7, h ; $52e4
	jr z, .positive3 ; $52e6
	xor a ; $52e8
	sub l ; $52e9
	ld l, a ; $52ea
	sbc a ; $52eb
	sub h ; $52ec
	ld h, a ; $52ed
.positive3:
	ld de, $ff40 ; $52ee
	add hl, de ; $52f1
	jr c, .returnZero ; $52f2
	ld a, $01 ; $52f4
	ret ; $52f6
.returnZero:
	xor a ; $52f7
	ret ; $52f8
AwardHitScore:
	ld a, $10 ; $52f9
	ld [wMinigameSceneActor + 3], a ; $52fb
	ld hl, $0001 ; $52fe
	ld a, [wCurrentShotType] ; $5301
	cp SHOTTYPE_SMASH ; $5304
	jr nz, .step ; $5306
	ld a, $20 ; $5308
	ld [wMinigameSceneActor + 3], a ; $530a
	ld hl, $0007 ; $530d
.step:
	ld a, $01 ; $5310
	ld [wMinigameHitScored], a ; $5312
	ld a, [wMinigameHitStreak] ; $5315
	add $4f ; $5318
	ld e, a ; $531a
	adc $53 ; $531b
	sub e ; $531d
	ld d, a ; $531e
	ld a, [de] ; $531f
	call PlaySoundManaged ; $5320
	ld a, [wMinigameHitStreak] ; $5323
	add $57 ; $5326
	ld e, a ; $5328
	adc $53 ; $5329
	sub e ; $532b
	ld d, a ; $532c
	ld a, [de] ; $532d
	call MulHLByA ; $532e
	ld e, l ; $5331
	ld d, h ; $5332
	ld hl, wScorePopupValue ; $5333
	ld a, e ; $5336
	ld [hl+], a ; $5337
	ld [hl], d ; $5338
	call AddToMinigameScore ; $5339
	call StartScorePopup ; $533c
	ld b, $07 ; $533f
	call IncrementCappedCounter ; $5341
	ld a, POINTOUTCOME_WINNER ; $5344
	ld [wPointOutcome], a ; $5346
	ld a, $01 ; $5349
	ld [wPointOutcomeSide], a ; $534b
	ret ; $534e
MinigameHitStreakSounds:
	; $534f, 8 bytes (bytes:8)
	db $c0, $bf, $be, $bd, $bc, $bb, $ba, $ba ; 0x00
MinigameHitStreakMultipliers:
	; $5357, 8 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20, $40, $80 ; 0x00
DrawTargetReticleSprite:
	call ProjectMinigameWorldPosition ; $535f
	ld c, $30 ; $5362
	ld h, $fc ; $5364
	ld l, $f1 ; $5366
	call QueueSprite24x32 ; $5368
	ldh a, [hVBlankCounter] ; $536b
	and $1f ; $536d
	ld_hl_indexed TargetReticleAnimFrames ; $536f
	ld a, [hl] ; $5376
	cp $ff ; $5377
	ret z ; $5379
	farcall QueueMatchSpriteFrameA ; $537a
	ret ; $537d
TargetReticleAnimFrames:
	; $537e, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x08
	db $02, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawTargetHitCountdown:
	call ProjectMinigameWorldPosition ; $539e
	ld c, $3c ; $53a1
	ld a, [wMinigameSceneActor + 3] ; $53a3
	call QueueMinigameHitBurst ; $53a6
	ret ; $53a9
ProjectMinigameWorldPosition:
	ld hl, wMinigameSceneActor + 10 ; $53aa
	ld a, [hl+] ; $53ad
	ld e, a ; $53ae
	ld a, [hl+] ; $53af
	ld d, a ; $53b0
	ld a, [hl+] ; $53b1
	ld c, a ; $53b2
	ld a, [hl+] ; $53b3
	ld b, a ; $53b4
	ld l, e ; $53b5
	ld h, d ; $53b6
	farcall ApplyCameraProjection ; $53b7
	ld a, [wMinigameHitStreak] ; $53ba
	ld_hl_indexed MinigameTargetSpriteOamAttrByHitStreak ; $53bd
	ld b, [hl] ; $53c4
	ret ; $53c5
MinigameTargetSpriteOamAttrByHitStreak:
	; $53c6, 8 bytes (bytes:8)
	db $0f, $0e, $0e, $0e, $0e, $0e, $0e, $0d ; 0x00
QueueMinigameHitBurst:
	call QueueMinigameHitBurstFirstFour ; $53ce
	call QueueMinigameHitBurstParticle ; $53d1
	call QueueMinigameHitBurstParticle ; $53d4
	ret ; $53d7
QueueMinigameHitBurstFirstFour:
	and $0f ; $53d8
	cpl ; $53da
	inc a ; $53db
	add $0f ; $53dc
	ld_hl_indexed MinigameHitBurstParticleOffsets ; $53de
	ld a, e ; $53e5
	add $f8 ; $53e6
	ld e, a ; $53e8
	call QueueMinigameHitBurstParticle ; $53e9
	call QueueMinigameHitBurstParticle ; $53ec
	call QueueMinigameHitBurstParticle ; $53ef
	call QueueMinigameHitBurstParticle ; $53f2
	ret ; $53f5
QueueMinigameHitBurstFirstTwo:
	and $0f ; $53f6
	cpl ; $53f8
	inc a ; $53f9
	add $0f ; $53fa
	ld_hl_indexed MinigameHitBurstParticleOffsets ; $53fc
	call QueueMinigameHitBurstParticle ; $5403
	call QueueMinigameHitBurstParticle ; $5406
	ret ; $5409
QueueMinigameHitBurstParticle:
	push de ; $540a
	ld a, [hl] ; $540b
	add a ; $540c
	add d ; $540d
	ld d, a ; $540e
	ld a, $10 ; $540f
	add l ; $5411
	ld l, a ; $5412
	jr nc, .readY ; $5413
	inc h ; $5415
.readY:
	ld a, [hl] ; $5416
	add a ; $5417
	add e ; $5418
	ld e, a ; $5419
	ld a, $10 ; $541a
	add l ; $541c
	ld l, a ; $541d
	jr nc, .queue ; $541e
	inc h ; $5420
.queue:
	push hl ; $5421
	call QueueSprite ; $5422
	pop hl ; $5425
	pop de ; $5426
	dec e ; $5427
	dec e ; $5428
	dec e ; $5429
	dec e ; $542a
	ret ; $542b
MinigameHitBurstParticleOffsets:
	; $542c, 192 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x10
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0x20
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x30
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x40
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x50
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0x60
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x70
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x80
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x90
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0xa0
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0xb0
MinigameConfig_BananaBunch:
	; $54ec, 16 bytes (bytes:16)
	db $00, $11, $01, $08, $21, $16, $00, $18, $1b, $55, $b4, $40, $fc, $54, $00, $00 ; 0x00
InitMinigame_BananaBunch:
	farcall InitMinigameTargets ; $54fc
	ld a, $05 ; $54ff
	farcall SpawnMinigameTargetFormation ; $5501
	ld a, $01 ; $5504
	ld [wMinigameTargetsAltMode], a ; $5506
	ld a, $01 ; $5509
	ld [wMinigameUsesWall], a ; $550b
	ld a, [wMinigameLevel] ; $550e
	cp $02 ; $5511
	jr nz, .done ; $5513
	ld a, $01 ; $5515
	ld [wMinigameHighScoreMode], a ; $5517
.done:
	ret ; $551a
MinigameHooks_BananaBunch:
	; $551b, 16 bytes (mode_hooks)
	dw BananaBunchHook_PerFrame ; record 0
	dw BananaBunchHook_PointStart ; record 1
	dw BananaBunchHook_PointEnd ; record 2
	dw BananaBunchHook_MinigameStart ; record 3
	dw BananaBunchHook_BallHit ; record 4
	dw BananaBunchHook_Bounce ; record 5
	dw BananaBunchHook_RallyTick ; record 6
	dw RetStub ; record 7
