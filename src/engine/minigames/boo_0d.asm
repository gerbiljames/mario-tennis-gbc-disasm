BananaBunchHook_MinigameStart:
	ret ; $552b
BananaBunchHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $552c
	call UpdateBananaBunchTargetHits ; $552f
	ret ; $5532
BananaBunchHook_PointStart:
	call StartMinigameSoloPoint ; $5533
	ld a, [wMinigameLevel] ; $5536
	add a ; $5539
	ld_hl_indexed BananaBunchGridLayoutsByLevel ; $553a
	ld a, [hl+] ; $5541
	ld h, [hl] ; $5542
	ld l, a ; $5543
	call CopyMinigameTilemapBlock ; $5544
	ret ; $5547
BananaBunchGridLayoutsByLevel:
	; $5548, 6 bytes (records:2)
	dw BananaBunchGridLayout0 ; record 0
	dw BananaBunchGridLayout1 ; record 1
	dw BananaBunchGridLayout2 ; record 2
BananaBunchGridLayout0:
	; $554e, 24 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
BananaBunchGridLayout1:
	; $5566, 24 bytes (bytes:8)
	db $00, $00, $07, $00, $07, $00, $00, $00 ; 0x00
	db $00, $00, $00, $07, $00, $00, $00, $00 ; 0x08
	db $00, $00, $07, $00, $07, $00, $00, $00 ; 0x10
BananaBunchGridLayout2:
	; $557e, 24 bytes (bytes:8)
	db $07, $07, $00, $00, $05, $00, $05, $00 ; 0x00
	db $07, $00, $07, $00, $05, $05, $00, $00 ; 0x08
	db $07, $07, $00, $00, $05, $00, $05, $00 ; 0x10
BananaBunchHook_PointEnd:
	call HandleMinigamePointEnd ; $5596
	ret ; $5599
BananaBunchHook_RallyTick:
	call BananaBunchReflectBallAndRecordCell ; $559a
	ret ; $559d
BananaBunchHook_Bounce:
	call StubNop_0d_0 ; $559e
	ret ; $55a1
BananaBunchHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $55a2
	ret ; $55a5
UpdateBananaBunchTargetHits:
	call ScoreMinigameTargetHitOrDeflectBall ; $55a6
	ret ; $55a9
BananaBunchReflectBallAndRecordCell:
	call ReflectBallVelocity ; $55aa
	call GetMinigameGridCellIndex ; $55ad
	ld [wMinigameLastHitCell], a ; $55b0
	ret ; $55b3
CopyMinigameTilemapBlock:
	wram_bank WRAM_COURT_PLANES ; $55b4
	ld de, wMinigameTargetGrid ; $55ba
	ld bc, $0018 ; $55bd
	call CopyMemoryBC ; $55c0
	call DrawMinigameGrid ; $55c3
	farcall FlushTilemapToVram ; $55c6
	ret ; $55c9
ScoreMinigameTargetHitOrDeflectBall:
	ld hl, wMinigameHitPending ; $55ca
	ld a, [hl] ; $55cd
	and a ; $55ce
	ret z ; $55cf
	ld [hl], $00 ; $55d0
	ld a, [wMinigameHitTargetType] ; $55d2
	cp $ff ; $55d5
	jr z, MinigameTargetTypeScores.eqff ; $55d7
	ld a, [wMinigameHitTargetType] ; $55d9
	ld_hl_indexed MinigameTargetTypeScores ; $55dc
	ld e, [hl] ; $55e3
	ld d, $00 ; $55e4
	call AddToMinigameScore ; $55e6
	ld a, $ff ; $55e9
	ld [wMinigameHitTargetType], a ; $55eb
	call IsMinigameTargetReached ; $55ee
	and a ; $55f1
	ret z ; $55f2
	ld a, POINTOUTCOME_MINIGAME_CLEARED ; $55f3
	ld [wPointOutcome], a ; $55f5
	ret ; $55f8
MinigameTargetTypeScores:
	; $55f9, 4 bytes (bytes:4)
	db $01, $03, $05, $03 ; 0x00
.eqff:
	ld a, [wMinigameLastHitCell] ; $55fd
	cp $ff ; $5600
	ret z ; $5602
	add $c0 ; $5603
	ld l, a ; $5605
	adc $c7 ; $5606
	sub l ; $5608
	ld h, a ; $5609
	ld a, [hl] ; $560a
	and a ; $560b
	ret z ; $560c
	sub $04 ; $560d
	farcall DeflectBallOffMinigameTarget ; $560f
	sound SFX_BALL_CONTACT ; $5612
	ret ; $5614
MinigameConfig_BooBlast:
	; $5615, 16 bytes (bytes:16)
	db $17, $12, $02, $08, $1c, $11, $00, $1a, $58, $56, $c6, $40, $25, $56, $00, $00 ; 0x00
InitMinigame_BooBlast:
	ld a, $01 ; $5625
	ld [wMinigameIsBooBlast], a ; $5627
	ld a, [wMinigameLevel] ; $562a
	cp $02 ; $562d
	jr nz, .ne02 ; $562f
	ld a, $01 ; $5631
	ld [wMinigameHighScoreMode], a ; $5633
.ne02:
	ld hl, BooBlastInitParams ; $5636
	ld a, [hl+] ; $5639
	ld [wPlayer2MainAiParams], a ; $563a
	ld a, [hl+] ; $563d
	ld [wPlayer2MainAiParams + 1], a ; $563e
	ld a, [hl+] ; $5641
	ld [wPlayer2MainAiParams + 2], a ; $5642
	ld a, [hl+] ; $5645
	ld [wPlayer2MainAiParams + 3], a ; $5646
	ld a, [hl+] ; $5649
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $564a
	ld a, [hl+] ; $564d
	ld [wPlayer2MainInitByte], a ; $564e
	ret ; $5651
BooBlastInitParams:
	; $5652, 6 bytes (bytes:6)
	db $00, $00, $00, $dc, $03, $01 ; 0x00
MinigameHooks_BooBlast:
	; $5658, 16 bytes (mode_hooks)
	dw BooBlastHook_PerFrame ; record 0
	dw BooBlastHook_PointStart ; record 1
	dw BooBlastHook_PointEnd ; record 2
	dw BooBlastHook_MinigameStart ; record 3
	dw BooBlastHook_BallHit ; record 4
	dw BooBlastHook_Bounce ; record 5
	dw BooBlastHook_RallyTick ; record 6
	dw BooBlastHook_Draw ; record 7
BooBlastHook_MinigameStart:
	call InitMinigameControllerActor ; $5668
	call InitBooBlastScore ; $566b
	ret ; $566e
BooBlastHook_PerFrame:
	call DrawMinigameScoreAtDefaultPos ; $566f
	call UpdateScorePopup ; $5672
	ret ; $5675
BooBlastHook_Draw:
	call UpdateMinigameActors ; $5676
	ret ; $5679
BooBlastHook_PointStart:
	call DisableOffscreenArrows ; $567a
	ret ; $567d
BooBlastHook_PointEnd:
	call DisableMinigameControllerActor ; $567e
	call ResolveAndShowMinigamePoint ; $5681
	ret ; $5684
BooBlastHook_RallyTick:
	call StubNop_0d_1 ; $5685
	ret ; $5688
BooBlastHook_Bounce:
	call StubNop_0d_2 ; $5689
	ret ; $568c
BooBlastHook_BallHit:
	call UpdateBooBlastHitStreak ; $568d
	ret ; $5690
InitMinigameControllerActor:
	call ClearMinigameActors ; $5691
	ld de, BooBlastControllerActorHandler ; $5694
	ld bc, wMinigameActors ; $5697
	call SetMinigameActorHandler ; $569a
	ld hl, $0000 ; $569d
	ld de, $0000 ; $56a0
	ld bc, wMinigameActors ; $56a3
	call SetMinigameActorPosition ; $56a6
	ret ; $56a9
DisableMinigameControllerActor:
	ld hl, wMinigameActors ; $56aa
	res 0, [hl] ; $56ad
	ret ; $56af
InitBooBlastScore:
	call InitMinigameScore ; $56b0
	ret ; $56b3
DrawMinigameScoreAtDefaultPos:
	ld de, $8403 ; $56b4
	call DrawMinigameScore ; $56b7
	ret ; $56ba
DisableOffscreenArrows:
	xor a ; $56bb
	ld [wOffscreenArrowsEnabled], a ; $56bc
	ret ; $56bf
ResolveAndShowMinigamePoint:
	call ShowPointOutcomeBanner ; $56c0
	call DetermineMinigamePointResult ; $56c3
	push de ; $56c6
	push_wram_bank WRAM_CHAR0 ; $56c7
	farcall CharPointEndReaction ; $56d0
	ld a, [wCharPointResult] ; $56d3
	push af ; $56d6
	wram_bank WRAM_CHAR1 ; $56d7
	farcall CharPointEndReaction ; $56dd
	pop af ; $56e0
	ld [wCharPointResult], a ; $56e1
	pop_wram_bank ; $56e4
	pop de ; $56e9
	call ShowMinigamePointResult ; $56ea
	ret ; $56ed
StubNop_0d_1:
	ret ; $56ee
StubNop_0d_2:
	ret ; $56ef
UpdateBooBlastHitStreak:
	ld a, [wLastShotCharIndex] ; $56f0
	and $01 ; $56f3
	jr nz, .maskSet ; $56f5
	ld a, [wMinigameHitScored] ; $56f7
	and a ; $56fa
	jr z, .step3 ; $56fb
	jr .incrementCappedCounter ; $56fd
.maskSet:
	ld a, [wMinigameHitScored] ; $56ff
	and a ; $5702
	jr nz, .incrementCappedCounter ; $5703
	xor a ; $5705
	ld [wMinigameHitStreak], a ; $5706
	jr .step3 ; $5709
.incrementCappedCounter:
	ld b, $07 ; $570b
	call IncrementCappedCounter ; $570d
.step3:
	xor a ; $5710
	ld [wMinigameHitScored], a ; $5711
	xor a ; $5714
	ld [wMinigameActors + 2], a ; $5715
	ret ; $5718
BooBlastControllerActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5719
	rst Rst00 ; $571c
	dw AdvanceMinigameScriptState.advanceMinigameScriptState ; $571d jumptable
	dw AdvanceMinigameScriptState.drawBooBlastTargetSprite ; $571f jumptable
	dw AdvanceMinigameScriptState.drawBooBlastHitBurst ; $5721 jumptable
	dw AdvanceMinigameScriptState.drawBooBlastTargetSprite2 ; $5723 jumptable
	dw RetStub ; $5725 jumptable
AdvanceMinigameScriptState:
	ld hl, wMinigameSceneActor + 2 ; $5727
	inc [hl] ; $572a
	ret ; $572b
.advanceMinigameScriptState:
	call AdvanceMinigameScriptState ; $572c
.drawBooBlastTargetSprite:
	call DrawBooBlastTargetSprite ; $572f
	call IsBallWithinTargetZone ; $5732
	and a ; $5735
	ret z ; $5736
	call ScoreBallHit ; $5737
	jp AdvanceMinigameScriptState ; $573a
.drawBooBlastHitBurst:
	call DrawBooBlastHitBurst ; $573d
	ld hl, wMinigameSceneActor + 3 ; $5740
	dec [hl] ; $5743
	ld a, [hl] ; $5744
	and a ; $5745
	ret nz ; $5746
	farcall AdvanceMatchRng ; $5747
	ld h, $00 ; $574a
	ld l, a ; $574c
	add hl, hl ; $574d
	ld de, $ff00 ; $574e
	add hl, de ; $5751
	ld de, $0000 ; $5752
	call SetMinigameActorWorldPos ; $5755
	jp AdvanceMinigameScriptState ; $5758
.drawBooBlastTargetSprite2:
	call DrawBooBlastTargetSprite ; $575b
	ret ; $575e
IsBallWithinTargetZone:
	ld hl, wMinigameSceneActor + 6 ; $575f
	ld a, [hl+] ; $5762
	ld d, [hl] ; $5763
	ld e, a ; $5764
	ld hl, wBallX ; $5765
	ld a, [hl+] ; $5768
	ld h, [hl] ; $5769
	ld l, a ; $576a
	ld a, l ; $576b
	sub e ; $576c
	ld l, a ; $576d
	ld a, h ; $576e
	sbc d ; $576f
	ld h, a ; $5770
	bit 7, h ; $5771
	jr z, .positive ; $5773
	xor a ; $5775
	sub l ; $5776
	ld l, a ; $5777
	sbc a ; $5778
	sub h ; $5779
	ld h, a ; $577a
.positive:
	ld de, $ff80 ; $577b
	add hl, de ; $577e
	jr c, .returnZero ; $577f
	ld hl, wMinigameSceneActor + 8 ; $5781
	ld a, [hl+] ; $5784
	ld d, [hl] ; $5785
	ld e, a ; $5786
	ld hl, wBallDepth ; $5787
	ld a, [hl+] ; $578a
	ld h, [hl] ; $578b
	ld l, a ; $578c
	ld a, l ; $578d
	sub e ; $578e
	ld l, a ; $578f
	ld a, h ; $5790
	sbc d ; $5791
	ld h, a ; $5792
	bit 7, h ; $5793
	jr z, .positive2 ; $5795
	xor a ; $5797
	sub l ; $5798
	ld l, a ; $5799
	sbc a ; $579a
	sub h ; $579b
	ld h, a ; $579c
.positive2:
	ld de, $fec0 ; $579d
	add hl, de ; $57a0
	jr c, .returnZero ; $57a1
	ld hl, wBallHeight ; $57a3
	ld a, [hl+] ; $57a6
	ld h, [hl] ; $57a7
	ld l, a ; $57a8
	bit 7, h ; $57a9
	jr z, .positive3 ; $57ab
	xor a ; $57ad
	sub l ; $57ae
	ld l, a ; $57af
	sbc a ; $57b0
	sub h ; $57b1
	ld h, a ; $57b2
.positive3:
	ld de, $ff00 ; $57b3
	add hl, de ; $57b6
	jr c, .returnZero ; $57b7
	ld a, $01 ; $57b9
	ret ; $57bb
.returnZero:
	xor a ; $57bc
	ret ; $57bd
ScoreBallHit:
	ld a, $10 ; $57be
	ld [wMinigameSceneActor + 3], a ; $57c0
	ld a, $01 ; $57c3
	ld [wMinigameHitScored], a ; $57c5
	sound SFX_THUD ; $57c8
	ld a, [wMinigameHitStreak] ; $57ca
	add $f5 ; $57cd
	ld e, a ; $57cf
	adc $57 ; $57d0
	sub e ; $57d2
	ld d, a ; $57d3
	ld a, [de] ; $57d4
	ld hl, $0001 ; $57d5
	call MulHLByA ; $57d8
	ld e, l ; $57db
	ld d, h ; $57dc
	ld hl, wScorePopupValue ; $57dd
	ld a, e ; $57e0
	ld [hl+], a ; $57e1
	ld [hl], d ; $57e2
	call AddToMinigameScore ; $57e3
	call StartScorePopup ; $57e6
	call IsMinigameTargetReached ; $57e9
	and a ; $57ec
	jr z, .done ; $57ed
	ld a, POINTOUTCOME_MINIGAME_CLEARED ; $57ef
	ld [wPointOutcome], a ; $57f1
.done:
	ret ; $57f4
UnusedBitMaskTable_0d:
	; $57f5, 8 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20, $40, $80 ; 0x00
DrawBooBlastTargetSprite:
	call ProjectBallSprite ; $57fd
	ld c, $30 ; $5800
	ld h, $fc ; $5802
	ld l, $f1 ; $5804
	call QueueSprite24x32 ; $5806
	ldh a, [hVBlankCounter] ; $5809
	and $1f ; $580b
	ld_hl_indexed BooBlastTargetAnimFrames ; $580d
	ld a, [hl] ; $5814
	cp $ff ; $5815
	ret z ; $5817
	farcall QueueMatchSpriteFrameB ; $5818
	ret ; $581b
BooBlastTargetAnimFrames:
	; $581c, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x08
	db $02, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawBooBlastHitBurst:
	call ProjectBallSprite ; $583c
	ld c, $3c ; $583f
	ld a, [wMinigameSceneActor + 3] ; $5841
	call QueueMinigameHitBurst ; $5844
	ret ; $5847
ProjectBallSprite:
	ld hl, wMinigameSceneActor + 10 ; $5848
	ld a, [hl+] ; $584b
	ld e, a ; $584c
	ld a, [hl+] ; $584d
	ld d, a ; $584e
	ld a, [hl+] ; $584f
	ld c, a ; $5850
	ld a, [hl+] ; $5851
	ld b, a ; $5852
	ld l, e ; $5853
	ld h, d ; $5854
	farcall ApplyCameraProjection ; $5855
	ld a, [wMinigameHitStreak] ; $5858
	ld_hl_indexed MinigameHitStreakValueTable_0d ; $585b
	ld b, [hl] ; $5862
	ld b, $0e ; $5863
	ret ; $5865
MinigameHitStreakValueTable_0d:
	; $5866, 8 bytes (bytes:8)
	db $0f, $0e, $0e, $0e, $0e, $0e, $0e, $0d ; 0x00
MinigameConfig_PerfectShot:
	; $586e, 16 bytes (bytes:16)
	db $00, $13, $01, $08, $1e, $12, $00, $1f, $a6, $58, $b4, $40, $7e, $58, $00, $00 ; 0x00
InitMinigame_PerfectShot:
	ld a, $01 ; $587e
	ld [wMinigameUsesWall], a ; $5880
	ld a, [wMinigameLevel] ; $5883
	cp $02 ; $5886
	jr nz, .initMinigameTargets ; $5888
	ld a, $01 ; $588a
	ld [wMinigameHighScoreMode], a ; $588c
.initMinigameTargets:
	farcall InitMinigameTargets ; $588f
	ld a, [wMinigameLevel] ; $5892
	ld_hl_indexed PerfectShotLevelHasTargets ; $5895
	ld a, [hl] ; $589c
	and a ; $589d
	ret z ; $589e
	farcall SpawnMinigameTargetFormation ; $589f
	ret ; $58a2
