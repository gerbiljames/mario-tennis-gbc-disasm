ShowPointOutcomeBanner:
	ld a, [wPointOutcome] ; $43ba
	cp POINTOUTCOME_WINNER ; $43bd
	jr z, .done ; $43bf
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $43c1
	jr z, .done ; $43c3
	cp POINTOUTCOME_MINIGAME_CLEARED ; $43c5
	jr z, .done ; $43c7
	ld a, [wPointOutcome] ; $43c9
	add $00 ; $43cc
	farcall ShowCourtBanner ; $43ce
	ld a, 30 ; $43d1
	farcall StepMatchFrames ; $43d3
	farcall HideCourtBanner ; $43d6
	ld a, 10 ; $43d9
	farcall StepMatchFrames ; $43db
.done:
	ret ; $43de
DetermineMinigamePointResult:
	ld a, [wMinigameHighScoreMode] ; $43df
	and a ; $43e2
	jr nz, .isMinigameScoreLimitReached ; $43e3
	ld a, [wPointOutcome] ; $43e5
	cp POINTOUTCOME_MINIGAME_CLEARED ; $43e8
	jr z, .eq0b ; $43ea
	jr .storePointWinLoseFlag ; $43ec
.isMinigameScoreLimitReached:
	call IsMinigameScoreLimitReached ; $43ee
	and a ; $43f1
	jr nz, .nonZero ; $43f2
	jr .storePointWinLoseFlag ; $43f4
.eq0b:
	ld a, WINLOSE_WIN ; $43f6
	ld [wPointWinLoseFlag], a ; $43f8
	ld a, [wMinigameLevel] ; $43fb
	add $12 ; $43fe
	ld d, a ; $4400
	ret ; $4401
.nonZero:
	ld a, WINLOSE_WIN ; $4402
	ld [wPointWinLoseFlag], a ; $4404
	ld d, $16 ; $4407
	ret ; $4409
.storePointWinLoseFlag:
	ld a, WINLOSE_LOSE ; $440a
	ld [wPointWinLoseFlag], a ; $440c
	ld d, $17 ; $440f
	ret ; $4411
ShowMinigamePointResult:
	ld a, [wPointWinLoseFlag] ; $4412
	add a ; $4415
	jr c, .lostPoint ; $4416
	sound BGM_WIN ; $4418
	jr .showBanner ; $441a
.lostPoint:
	sound BGM_LOSE ; $441c
.showBanner:
	farcall StepMatchFrame ; $441e
	ld a, d ; $4421
	farcall ShowCourtBanner ; $4422
	ld a, 10 ; $4425
	farcall StepMatchFrames ; $4427
	ld a, $2d ; $442a
	farcall StepMatchFramesSkippable ; $442c
	farcall RunMatchFramesUntilInput ; $442f
	farcall HideCourtBanner ; $4432
	ld a, 15 ; $4435
	farcall StepMatchFrames ; $4437
	ld a, MATCHABORT_MATCH ; $443a
	ld [wMatchAbortFlag], a ; $443c
	ret ; $443f
ClearMinigameActors:
	wram_bank WRAM_ACTORS ; $4440
	ld hl, wMinigameActors ; $4446
	ld c, wMinigameActors_SIZE / 16 ; $4449
	call ClearMemory16 ; $444b
	ret ; $444e
SetMinigameActorHandler:
	wram_bank WRAM_ACTORS ; $444f
	ld hl, $000e ; $4455
	add hl, bc ; $4458
	ld a, e ; $4459
	ld [hl+], a ; $445a
	ld [hl], d ; $445b
	ld hl, $0000 ; $445c
	add hl, bc ; $445f
	set 0, [hl] ; $4460
	set 1, [hl] ; $4462
	ret ; $4464
SetMinigameActorPosition:
	wram_bank WRAM_ACTORS ; $4465
	push de ; $446b
	push hl ; $446c
	push hl ; $446d
	ld hl, $0008 ; $446e
	add hl, bc ; $4471
	ld a, e ; $4472
	ld [hl+], a ; $4473
	ld [hl], d ; $4474
	pop de ; $4475
	ld hl, $0006 ; $4476
	add hl, bc ; $4479
	ld a, e ; $447a
	ld [hl+], a ; $447b
	ld [hl], d ; $447c
	pop hl ; $447d
	pop de ; $447e
	push bc ; $447f
	ld bc, $0000 ; $4480
	farcall ProjectWorldToScreen_08 ; $4483
	ld e, c ; $4486
	ld d, b ; $4487
	pop bc ; $4488
	push hl ; $4489
	ld hl, $000c ; $448a
	add hl, bc ; $448d
	ld a, e ; $448e
	ld [hl+], a ; $448f
	ld [hl], d ; $4490
	pop de ; $4491
	ld hl, $000a ; $4492
	add hl, bc ; $4495
	ld a, e ; $4496
	ld [hl+], a ; $4497
	ld [hl], d ; $4498
	ret ; $4499
SetMinigameActorWorldPos:
	ld c, l ; $449a
	ld b, h ; $449b
	ld hl, wMinigameSceneActor + 6 ; $449c
	ld a, c ; $449f
	ld [hl+], a ; $44a0
	ld a, b ; $44a1
	ld [hl+], a ; $44a2
	ld a, e ; $44a3
	ld [hl+], a ; $44a4
	ld a, d ; $44a5
	ld [hl+], a ; $44a6
	ld l, c ; $44a7
	ld h, b ; $44a8
	ld bc, $0000 ; $44a9
	farcall ProjectWorldToScreen_08 ; $44ac
	ld e, l ; $44af
	ld d, h ; $44b0
	ld hl, wMinigameSceneActor + 10 ; $44b1
	ld a, e ; $44b4
	ld [hl+], a ; $44b5
	ld a, d ; $44b6
	ld [hl+], a ; $44b7
	ld a, c ; $44b8
	ld [hl+], a ; $44b9
	ld a, b ; $44ba
	ld [hl+], a ; $44bb
	ret ; $44bc
UpdateMinigameActors:
	wram_bank WRAM_ACTORS ; $44bd
	ld hl, wMinigameActors ; $44c3
	ld c, $07 ; $44c6
.actorLoop:
	call UpdateMinigameActor ; $44c8
	ld de, $0010 ; $44cb
	add hl, de ; $44ce
	dec c ; $44cf
	jr nz, .actorLoop ; $44d0
	ret ; $44d2
UpdateMinigameActor:
	bit 0, [hl] ; $44d3
	ret z ; $44d5
	push af ; $44d6
	push bc ; $44d7
	push de ; $44d8
	push hl ; $44d9
	push hl ; $44da
	ld de, wMinigameSceneActor ; $44db
	ld c, wMinigameSceneActor_SIZE / 16 ; $44de
	call CopyMemoryFast ; $44e0
	ld hl, wMinigameSceneActor + 14 ; $44e3
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	call JumpToHL ; $44e9
	pop de ; $44ec
	ld hl, wMinigameSceneActor ; $44ed
	ld c, wMinigameSceneActor_SIZE / 16 ; $44f0
	call CopyMemoryFast ; $44f2
	pop hl ; $44f5
	pop de ; $44f6
	pop bc ; $44f7
	pop af ; $44f8
	ret ; $44f9
MinigameConfig_TennisMachine1:
	; $44fa, 16 bytes
	drill_def CHAR_UNUSED_15, COURT_TENNIS_MACHINE, 2, GAMEMODE_TENNIS_MACHINE, MINIGAME_TENNIS_MACHINE_1, BGM_TENNIS_MACHINE, CHAR_STORY_MAIN, MinigameHooks_TennisMachine1, MinigamePointLayoutDuo, InitMinigame_TennisMachine1
InitMinigame_TennisMachine1:
	ld a, $01 ; $450a
	ld [wMinigameUsesTennisMachine], a ; $450c
	ld a, $00 ; $450f
	ld [wMinigameLevel], a ; $4511
	ret ; $4514
MinigameHooks_TennisMachine1:
	; $4515, 16 bytes (mode_hooks)
	dw TennisMachine1Hook_PerFrame ; record 0
	dw TennisMachine1Hook_PointStart ; record 1
	dw TennisMachine1Hook_PointEnd ; record 2
	dw TennisMachine1Hook_MinigameStart ; record 3
	dw TennisMachine1Hook_BallHit ; record 4
	dw TennisMachine1Hook_Bounce ; record 5
	dw TennisMachine1Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine1Hook_MinigameStart:
	ld a, $01 ; $4525
	ld [wMinigameServeSlot], a ; $4527
	call StartMinigameMatch ; $452a
	ret ; $452d
TennisMachine1Hook_PerFrame:
	call DrawMinigameScoreHud ; $452e
	ret ; $4531
TennisMachine1Hook_PointStart:
	call LaunchMinigameServe ; $4532
	ret ; $4535
TennisMachine1Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4536
	ret ; $4539
TennisMachine1Hook_RallyTick:
	call KeepMinigameCameraFixed ; $453a
	ret ; $453d
TennisMachine1Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $453e
	ret ; $4541
TennisMachine1Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4542
	ret ; $4545
MinigameShotDifficultyRamp:
	; $4546, 1 bytes (bytes:4)
	db $01 ; 0x00
EndMinigamePoint_PointOutcomeTable:
	db $01 ; $4547
LaunchBallTable:
	INCBIN "data/bank_00d/LaunchBallTable.bin" ; $4548, 102 bytes
MinigameShotIntervalByTempo:
	; $45ae, 5 bytes (bytes:5)
	db $28, $28, $1e, $14, $0a ; 0x00
MinigameShotAimPools:
	; $45b3, 144 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $10, $10, $10, $10, $10, $10, $10, $10, $20, $20, $20, $20, $20, $20, $20, $20 ; 0x10
	db $11, $11, $11, $11, $11, $11, $11, $11, $22, $22, $22, $22, $22, $22, $22, $22 ; 0x20
	db $10, $10, $10, $10, $10, $10, $12, $12, $20, $20, $20, $20, $20, $20, $21, $21 ; 0x30
	db $10, $10, $10, $10, $30, $30, $12, $12, $20, $20, $20, $20, $30, $30, $21, $21 ; 0x40
	db $11, $11, $11, $11, $30, $30, $12, $12, $22, $22, $22, $22, $30, $30, $21, $21 ; 0x50
	db $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12 ; 0x60
	db $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21 ; 0x70
	db $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30 ; 0x80
MinigameShotSpinPool:
	; $4643, 8 bytes (bytes:8)
	db $00, $00, $ff, $ff, $ff, $01, $01, $01 ; 0x00
MinigameCharCoordsTable:
	; $464b, 36 bytes (bytes:4)
	db $a0, $fe, $00, $fc ; 0x00
	db $00, $00, $00, $fc ; 0x04
	db $60, $01, $00, $fc ; 0x08
	db $a0, $fe, $40, $fd ; 0x0c
	db $00, $00, $40, $fd ; 0x10
	db $60, $01, $40, $fd ; 0x14
	db $a0, $fe, $c0, $fe ; 0x18
	db $00, $00, $c0, $fe ; 0x1c
	db $60, $01, $c0, $fe ; 0x20
MinigameBallLaunchHeights:
	; $466f, 6 bytes (records:2)
	dw $ffa0 ; record 0
	dw $ff80 ; record 1
	dw $ff60 ; record 2
MinigameBallLaunchSpeeds:
	; $4675, 3 bytes (bytes:3)
	db $ef, $c1, $93 ; 0x00
StartMinigameMatch:
	call InitMinigameScore ; $4678
	ld hl, $0000 ; $467b
	ld de, $fe00 ; $467e
	call SnapCameraTo_0d ; $4681
	ld de, $fb20 ; $4684
	ld hl, wCourtLimitDepth ; $4687
	ld a, e ; $468a
	ld [hl+], a ; $468b
	ld [hl], d ; $468c
	ld de, $fe50 ; $468d
	ld hl, wCourtLimitX ; $4690
	ld a, e ; $4693
	ld [hl+], a ; $4694
	ld [hl], d ; $4695
	wram_bank WRAM_ACTORS ; $4696
	ld hl, $0000 ; $469c
	ld de, $0480 ; $469f
	farcall SetCharPosAndTarget ; $46a2
	ld a, CHARSTATE_STANDBY ; $46a5
	farcall SetCharState ; $46a7
	wram_bank WRAM_CHAR1 ; $46aa
	ld a, [wMinigameServeSlot] ; $46b0
	call GetMinigameCharCoordsEntry ; $46b3
	farcall SetCharPosAndTarget ; $46b6
	ld a, CHARSTATE_WALK ; $46b9
	farcall SetCharState ; $46bb
	ld a, $04 ; $46be
	ld [wCharAimJitterScale], a ; $46c0
	xor a ; $46c3
	ld [wMinigameServeState], a ; $46c4
	ld a, [wCharId] ; $46c7
	cp CHAR_UNUSED_15 ; $46ca
	jr nz, .countdown ; $46cc
	ld a, $01 ; $46ce
	ld [wMinigameServeState], a ; $46d0
.countdown:
	call PlayMinigameCountdown ; $46d3
	ret ; $46d6
DrawMinigameScoreHud:
	ld_xy de, $84, $03 ; $46d7
	call DrawMinigameScore ; $46da
	ld a, [wMinigameServeState] ; $46dd
	and a ; $46e0
	jr z, .done ; $46e1
	push_wram_bank WRAM_CHAR1 ; $46e3
	ld hl, wCharSpriteSlot + 1 ; $46ec
	res 5, [hl] ; $46ef
	pop_wram_bank ; $46f1
.done:
	ret ; $46f6
LaunchMinigameServe:
	ld b, $19 ; $46f7
	ld hl, wMinigameServeCount ; $46f9
	ld a, [hl+] ; $46fc
	ld h, [hl] ; $46fd
	ld l, a ; $46fe
	ld a, h ; $46ff
	and a ; $4700
	jr nz, .gotSpeed ; $4701
	xor a ; $4703
	ld h, a ; $4704
	ld e, $0a ; $4705
	call DivAHLByE ; $4707
	ld b, l ; $470a
.gotSpeed:
	ld a, b ; $470b
	ld [wMinigameServeSpeed], a ; $470c
	push_wram_bank WRAM_TEXT ; $470f
	ld d, CHARANIM_FOREHAND ; $4718
	farcall SetCharAnimation ; $471a
	pop_wram_bank ; $471d
	ld a, [wMinigameServeState] ; $4722
	and a ; $4725
	jr z, .launch ; $4726
	ld a, 15 ; $4728
	farcall StepMatchFrames ; $472a
.launch:
	ld hl, wMinigameServeCount ; $472d
	ld a, [hl+] ; $4730
	ld d, [hl] ; $4731
	ld e, a ; $4732
	inc de ; $4733
	ld hl, wMinigameServeCount ; $4734
	ld a, e ; $4737
	ld [hl+], a ; $4738
	ld [hl], d ; $4739
	call LaunchBall ; $473a
	ld a, [wMinigameServeSlot] ; $473d
	ld l, a ; $4740
	ld h, $00 ; $4741
	ld de, $0003 ; $4743
	call DivHLByDE ; $4746
	ld a, l ; $4749
	ld [wMinigameServeGroup], a ; $474a
	call ApplyMinigameCharTargetFromTable ; $474d
	ret ; $4750
AwardMinigamePointAndEnd:
	farcall ResolvePointWinner ; $4751
	add a ; $4754
	jr c, EndMinigamePoint ; $4755
	ld de, $0001 ; $4757
	call AddToMinigameScore ; $475a
EndMinigamePoint:
	push_wram_bank WRAM_ACTORS ; $475d
	ld a, CHARSTATE_STANDBY ; $4766
	farcall SetCharState ; $4768
	pop_wram_bank ; $476b
	call ShowPointOutcomeBanner ; $4770
	farcall ResolvePointWinner ; $4773
	add a ; $4776
	jr c, .resolve ; $4777
	ld a, [wMinigameServeSpeed] ; $4779
	add a ; $477c
	add a ; $477d
	ld_hl_indexed EndMinigamePoint_PointOutcomeTable ; $477e
	ld a, [hl] ; $4785
	ld_hl_indexed MinigameShotIntervalByTempo ; $4786
	ld a, [hl] ; $478d
	farcall StepMatchFrames ; $478e
	call IsMinigameTargetReached ; $4791
	and a ; $4794
	ret z ; $4795
	ld a, POINTOUTCOME_MINIGAME_CLEARED ; $4796
	ld [wPointOutcome], a ; $4798
.resolve:
	call DetermineMinigamePointResult ; $479b
	push de ; $479e
	push_wram_bank WRAM_ACTORS ; $479f
	farcall CharPointEndReaction ; $47a8
	wram_bank WRAM_TEXT ; $47ab
	farcall CharPointEndReaction ; $47b1
	pop_wram_bank ; $47b4
	pop de ; $47b9
	call ShowMinigamePointResult ; $47ba
	ret ; $47bd
KeepMinigameCameraFixed:
	xor a ; $47be
	ld [wCameraFollowBall], a ; $47bf
	ret ; $47c2
CheckMinigameStartBannerTrigger:
	ld a, [wPointOutcome] ; $47c3
	and a ; $47c6
	jr nz, .done ; $47c7
	ld a, [wRallyLength] ; $47c9
	cp $04 ; $47cc
	jr nz, .done ; $47ce
	ld a, [wBallBounceCount] ; $47d0
	cp $01 ; $47d3
	jr nz, .done ; $47d5
	ld a, POINTOUTCOME_WINNER ; $47d7
	ld [wPointOutcome], a ; $47d9
	ld a, $01 ; $47dc
	ld [wPointOutcomeSide], a ; $47de
.done:
	ret ; $47e1
FreezeMinigameOpponentOnReturn:
	ld a, [wRallyLength] ; $47e2
	cp $03 ; $47e5
	jr nz, .done ; $47e7
	push_wram_bank WRAM_CHAR1 ; $47e9
	ld a, $28 ; $47f2
	ld [wCharFreezeTimer], a ; $47f4
	pop_wram_bank ; $47f7
.done:
	ret ; $47fc
LaunchBall:
	ld a, $01 ; $47fd
	ld [wBallSpriteEnabled], a ; $47ff
	ld [wBallShadowEnabled], a ; $4802
	ld [wBallTrailEnabled], a ; $4805
	ld a, $02 ; $4808
	ld [wRallyLength], a ; $480a
	ld a, $02 ; $480d
	ld [wBallCourtQuadrant], a ; $480f
	push_wram_bank WRAM_CHAR1 ; $4812
	ld a, $20 ; $481b
	ld [wCharSwingFrames], a ; $481d
	ld a, [wMinigameServeSpeed] ; $4820
	add a ; $4823
	add a ; $4824
	ld_hl_indexed LaunchBallTable ; $4825
	ld a, [hl] ; $482c
	dec a ; $482d
	ld [wGroundStrokeSpeedIndex], a ; $482e
	ld [wReachSpeedIndex], a ; $4831
	ld [wSlicePlacementIndex], a ; $4834
	ld [wTopspinPlacementIndex], a ; $4837
	ld a, [wMinigameServeSpeed] ; $483a
	add a ; $483d
	add a ; $483e
	ld_hl_indexed MinigameShotDifficultyRamp ; $483f
	ld a, [hl] ; $4846
	add a ; $4847
	add a ; $4848
	add a ; $4849
	add a ; $484a
	ld_hl_indexed MinigameShotAimPools ; $484b
	farcall AdvanceMatchRng ; $4852
	and $0f ; $4855
	add l ; $4857
	ld l, a ; $4858
	jr nc, .read ; $4859
	inc h ; $485b
.read:
	ld a, [hl] ; $485c
	swap a ; $485d
	and $0f ; $485f
	ld [wCharShotButton1], a ; $4861
	ld a, [hl] ; $4864
	and $0f ; $4865
	ld [wCharShotButton2], a ; $4867
	farcall SelectRallyShotType ; $486a
	ld a, [wMinigameServeGroup] ; $486d
	ld_hl_indexed MinigameBallLaunchSpeeds ; $4870
	ld a, [hl] ; $4877
	ld [wCharAimOffsetScale], a ; $4878
	ld a, [wMinigameServeGroup] ; $487b
	add a ; $487e
	ld_hl_indexed MinigameBallLaunchHeights ; $487f
	ld a, [hl+] ; $4886
	ld b, [hl] ; $4887
	ld c, a ; $4888
	ld hl, wCharPosDepth + 1 ; $4889
	ld a, [hl+] ; $488c
	ld d, [hl] ; $488d
	ld e, a ; $488e
	ld hl, wCharPosX + 1 ; $488f
	ld a, [hl+] ; $4892
	ld h, [hl] ; $4893
	ld l, a ; $4894
	farcall SetBallPosition ; $4895
	farcall AdvanceMatchRng ; $4898
	and $07 ; $489b
	ld_hl_indexed MinigameShotSpinPool ; $489d
	ld a, [hl] ; $48a4
	ld [wCharAimOffset], a ; $48a5
	ld_slot hl, FarPtr_ExecuteShot ; $48a8
	call FarCallVector ; $48ab
	sound SFX_BALL_LAUNCH ; $48ae
	pop_wram_bank ; $48b0
	ret ; $48b5
