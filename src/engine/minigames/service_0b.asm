SignedTable_0b_00:
	; $46f1, 10 bytes (bytes:10)
	db $00, $00, $ff, $00, $ff, $ff, $01, $ff, $ff, $01 ; 0x00
SignedTable_0b_01:
	; $46fb, 10 bytes (bytes:10)
	db $00, $00, $01, $00, $01, $01, $ff, $01, $01, $ff ; 0x00
RunTrainingDrillByID:
	push af ; $4705
	farcall InitMinigameMatchSettings ; $4706
	pop af ; $4709
	cp MINIGAME_TWO_ON_ONE ; $470a
	jp z, .doublesDrill ; $470c
	cp MINIGAME_TENNIS_MACHINE_1 ; $470f
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
	ld hl, wDrillAbortCountdown ; $4726
	ld c, $02 ; $4729
	call ClearMemory16 ; $472b
	ld a, $ff ; $472e
	ld [wAiServeAimOverride], a ; $4730
	xor a ; $4733
	ld hl, wAiServeTargetX ; $4734
	ld [hl+], a ; $4737
	ld [hl], a ; $4738
	ld [wAiServeSkipToss], a ; $4739
	farcall RunMinigameMatch ; $473c
.afterMatch:
	xor a ; $473f
	ldh [hScrollX], a ; $4740
	ldh [hScrollY], a ; $4742
	ld a, $ff ; $4744
	ld [wAiServeAimOverride], a ; $4746
	xor a ; $4749
	ld hl, wAiServeTargetX ; $474a
	ld [hl+], a ; $474d
	ld [hl], a ; $474e
	ld [wAiServeSkipToss], a ; $474f
	ld a, [wMatchRetryRequest] ; $4752
	or a ; $4755
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4756
	jp nz, RunTrainingDrillByID ; $4759
	ld a, [wMatchExitRequest] ; $475c
	or a ; $475f
	jr z, .checkMenuFlag ; $4760
	ld a, WINLOSE_LOSE ; $4762
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
	ld a, [wDrillLessonResult] ; $4783
	ld l, a ; $4786
	ld h, $00 ; $4787
	farcall PushTextArgNumber ; $4789
	ld a, [wPointWinLoseFlag] ; $478c
	inc a ; $478f
	srl a ; $4790
	ld hl, $015f ; $4792
	add l ; $4795
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
	ld hl, wScreenAttrmap ; $47e3
	ld bc, $0500 ; $47e6
	call FillMemoryBC_0b ; $47e9
	wram_bank $03 ; $47ec
	ld a, $20 ; $47f2
	ld hl, wShadowTilemap ; $47f4
	ld bc, $0500 ; $47f7
	call FillMemoryBC_0b ; $47fa
	wram_bank $03 ; $47fd
	ld hl, wShadowTilemap ; $4803
	ld de, vBGMap0 ; $4806
	ld c, $24 ; $4809
	call QueueVRAMCopy ; $480b
	wram_bank $02 ; $480e
	ld hl, wScreenAttrmap ; $4814
	ld de, vBGMap0 + VRAM_BANK1 ; $4817
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
	or b ; $4828
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
	xor a ; $4851
	ld [wDrillAbortCountdownActive], a ; $4852
	ld a, $0a ; $4855
	ld [wDrillAbortCountdown], a ; $4857
	xor a ; $485a
	ld [wDrillMessageId], a ; $485b
	xor a ; $485e
	ld [wDrillPointJudgement], a ; $485f
	ret ; $4862
ServiceMatch1Hook_PointEnd:
	call ServiceMatch1JudgeOnPointEnd ; $4863
	call ServiceMatch1HandlePointEnd ; $4866
	ld a, [wTotalPointsScoredInCurrentGame] ; $4869
	bit 0, a ; $486c
	ret nz ; $486e
	cp $08 ; $486f
	jr z, .eq08 ; $4871
	ld hl, wDrillCounters + 1 ; $4873
	ld a, [hl+] ; $4876
	ld b, [hl] ; $4877
	cp b ; $4878
	ret z ; $4879
	ld a, MATCHABORT_MATCH ; $487a
	ld [wMatchAbortFlag], a ; $487c
	ret ; $487f
.eq08:
	ld hl, wDrillCounters + 2 ; $4880
	ld a, [hl-] ; $4883
	sub [hl] ; $4884
	jr z, .clearPointWinLoseFlag ; $4885
	jr nc, .storePointWinLoseFlag ; $4887
	ld a, WINLOSE_WIN ; $4889
	ld [wPointWinLoseFlag], a ; $488b
	ret ; $488e
.clearPointWinLoseFlag:
	xor a ; $488f
	ld [wPointWinLoseFlag], a ; $4890
	ret ; $4893
.storePointWinLoseFlag:
	ld a, WINLOSE_LOSE ; $4894
	ld [wPointWinLoseFlag], a ; $4896
	ret ; $4899
ServiceMatch1Hook_RallyTick:
	call ServiceMatch1JudgeOnRallyTick ; $489a
	ret ; $489d
ServiceMatch1Hook_Bounce:
	call ServiceMatch1JudgeOnBounce ; $489e
	ret ; $48a1
ServiceMatch1Hook_BallHit:
	call ServiceMatch1JudgeOnBallHit ; $48a2
	ret ; $48a5
ServiceMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $48a6
	ld a, [wDrillPointJudgement] ; $48a9
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
	ld [wDrillCounters + 1], a ; $48c2
	ld a, $01 ; $48c5
	call CountDrillShotSuccesses ; $48c7
	ld [wDrillCounters + 2], a ; $48ca
	call ShowQueuedDrillMessage ; $48cd
	farcall UpdatePointStats ; $48d0
	farcall AwardPoint ; $48d3
	ld a, [wDrillCounters + 1] ; $48d6
	ld [wPlayer1PointsWon], a ; $48d9
	ld a, [wDrillCounters + 2] ; $48dc
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
ServiceMatch1JudgeOnPointEnd:
	ld a, $00 ; $48fc
	call ServiceMatch1JudgePoint ; $48fe
	ld [wDrillPointJudgement], a ; $4901
	ret ; $4904
ServiceMatch1JudgeOnBallHit:
	ld a, $01 ; $4905
	call ServiceMatch1JudgePoint ; $4907
	ld [wDrillPointJudgement], a ; $490a
	ret ; $490d
; Judges the point on the ball-bounce event -- except that the leading `ret`
; means the body never runs, so this drill does not judge on a bounce.
;
; Each drill has four of these, one per hook: PointEnd, BallHit, Bounce and
; RallyTick, passing 0-3 to its JudgePoint as the event code. 18 of the 52 in
; this bank start with `ret`, and which ones varies by drill -- most disable
; only RallyTick, the serve and net drills also disable Bounce, and
; ServiceMatch2 disables Bounce while leaving RallyTick live. So the effect is
; a per-drill choice of which events can score a point. Whether each `ret` was
; written as that choice or left behind by an edit is not something the code
; can settle. See docs/bugs.md.
ServiceMatch1JudgeOnBounce:
	ret ; $490e
	ld a, $02 ; $490f
	call ServiceMatch1JudgePoint ; $4911
	ld [wDrillPointJudgement], a ; $4914
	ret ; $4917
ServiceMatch1JudgeOnRallyTick:
	ret ; $4918
	ld a, $03 ; $4919
	call ServiceMatch1JudgePoint ; $491b
	ld [wDrillPointJudgement], a ; $491e
	ret ; $4921
ServiceMatch1JudgePoint:
	ld b, a ; $4922
	ld a, [wDrillPointJudgement] ; $4923
	or a ; $4926
	ret nz ; $4927
	ld a, [wRallyLength] ; $4928
	dec a ; $492b
	ld a, a ; $492c
	rst Rst00 ; $492d
	dw ServiceMatch1JudgePoint.rally1 ; $492e jumptable
	dw ServiceMatch1Cases1.dispatchResult ; $4930 jumptable
.rally1:
	ld a, b ; $4932
	ld a, a ; $4933
	rst Rst00 ; $4934
	dw ServiceMatch1JudgePoint.result0 ; $4935 jumptable
	dw ServiceMatch1Cases1 ; $4937 jumptable
	dw ServiceMatch1Cases1.returnZero ; $4939 jumptable
	dw ServiceMatch1Cases1.returnZero2 ; $493b jumptable
.result0:
	ld a, [wPointOutcome] ; $493d
	ld hl, ServiceMatch1JudgePointSignedTable ; $4940
	add l ; $4943
	ld l, a ; $4944
	jr nc, .readEntry1 ; $4945
	inc h ; $4947
.readEntry1:
	ld a, [hl] ; $4948
	ld a, a ; $4949
	ld b, $06 ; $494a
	call QueueDrillResultMessage ; $494c
	ld a, [wPointOutcome] ; $494f
	ld hl, SignedTable_0b_00 ; $4952
	add l ; $4955
	ld l, a ; $4956
	jr nc, .readEntry2 ; $4957
	inc h ; $4959
.readEntry2:
	ld a, [hl] ; $495a
	ret ; $495b
ServiceMatch1JudgePointSignedTable:
	; $495c, 10 bytes (bytes:10)
	db $ff, $ff, $02, $ff, $ff, $02, $01, $ff, $ff, $01 ; 0x00
ServiceMatch1Cases1:
	xor a ; $4966
	ret ; $4967
.returnZero:
	xor a ; $4968
	ret ; $4969
.returnZero2:
	xor a ; $496a
	ret ; $496b
.dispatchResult:
	ld a, b ; $496c
	ld a, a ; $496d
	rst Rst00 ; $496e
	dw ServiceMatch1Cases1.checkPointOutcome ; $496f jumptable
	dw ServiceMatch1Cases2 ; $4971 jumptable
	dw ServiceMatch1Cases2.returnZero ; $4973 jumptable
	dw ServiceMatch1Cases2.storeMatchAbortFlag2 ; $4975 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4977
	ld hl, ServiceMatch1Cases1SignedTable ; $497a
	add l ; $497d
	ld l, a ; $497e
	jr nc, .read ; $497f
	inc h ; $4981
.read:
	ld a, [hl] ; $4982
	ld a, a ; $4983
	ld b, $06 ; $4984
	call QueueDrillResultMessage ; $4986
	ld a, [wPointOutcome] ; $4989
	ld hl, SignedTable_0b_01 ; $498c
	add l ; $498f
	ld l, a ; $4990
	jr nc, .readB ; $4991
	inc h ; $4993
.readB:
	ld a, [hl] ; $4994
	ret ; $4995
ServiceMatch1Cases1SignedTable:
	; $4996, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $06, $06, $ff ; 0x00
ServiceMatch1Cases2:
	ld a, [wPointOutcome] ; $49a0
	cp POINTOUTCOME_SERVE_VOLLEYED ; $49a3
	ld a, $00 ; $49a5
	ret z ; $49a7
	ld a, $04 ; $49a8
	ld b, $06 ; $49aa
	call QueueDrillResultMessage ; $49ac
	jr UnusedStoreMatchAbortFlag_1.storeMatchAbortFlag ; $49af
	db $af ; $49b1
	ret ; $49b2
.returnZero:
	xor a ; $49b3
	ret ; $49b4
.storeMatchAbortFlag2:
	xor a ; $49b5
	ret ; $49b6
UnusedStoreMatchAbortFlag_1:
	ld a, MATCHABORT_POINT ; $49b7
	ld [wMatchAbortFlag], a ; $49b9
	ld a, $01 ; $49bc
	ret ; $49be
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $49bf
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
	xor a ; $49f2
	ld [wDrillAbortCountdownActive], a ; $49f3
	ld [wUnusedDrillPointStartByte], a ; $49f6
	ld a, $0a ; $49f9
	ld [wDrillAbortCountdown], a ; $49fb
	ld a, $01 ; $49fe
	ld [wDrillGateActive], a ; $4a00
	ld hl, ServiceMatch2PointStartDrillPositions ; $4a03
	call IndexDrillTableByPoint ; $4a06
	ld a, [wTotalPointsScoredInCurrentGame] ; $4a09
	srl a ; $4a0c
	ld hl, ServiceMatch2PointStartTable ; $4a0e
	add l ; $4a11
	ld l, a ; $4a12
	jr nc, .read ; $4a13
	inc h ; $4a15
.read:
	ld a, [hl] ; $4a16
	ld [wAiServeAimOverride], a ; $4a17
	xor a ; $4a1a
	ld [wDrillMessageId], a ; $4a1b
	xor a ; $4a1e
	ld [wDrillPointJudgement], a ; $4a1f
	ret ; $4a22
ServiceMatch2PointStartTable:
	; $4a23, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
ServiceMatch2Hook_PointEnd:
	call ServiceMatch2JudgeOnPointEnd ; $4a27
	call ServiceMatch2HandlePointEnd ; $4a2a
	ld a, [wTotalPointsScoredInCurrentGame] ; $4a2d
	bit 0, a ; $4a30
	ret nz ; $4a32
	cp $08 ; $4a33
	jr z, .eq08 ; $4a35
	ld hl, wDrillCounters + 1 ; $4a37
	ld a, [hl+] ; $4a3a
	ld b, [hl] ; $4a3b
	cp b ; $4a3c
	ret z ; $4a3d
	ld a, MATCHABORT_MATCH ; $4a3e
	ld [wMatchAbortFlag], a ; $4a40
	ret ; $4a43
.eq08:
	ld hl, wDrillCounters + 2 ; $4a44
	ld a, [hl-] ; $4a47
	sub [hl] ; $4a48
	jr z, .clearPointWinLoseFlag ; $4a49
	jr nc, .storePointWinLoseFlag ; $4a4b
	ld a, WINLOSE_WIN ; $4a4d
	ld [wPointWinLoseFlag], a ; $4a4f
	ret ; $4a52
.clearPointWinLoseFlag:
	xor a ; $4a53
	ld [wPointWinLoseFlag], a ; $4a54
	ret ; $4a57
.storePointWinLoseFlag:
	ld a, WINLOSE_LOSE ; $4a58
	ld [wPointWinLoseFlag], a ; $4a5a
	ret ; $4a5d
ServiceMatch2Hook_RallyTick:
	call ServiceMatch2JudgeOnRallyTick ; $4a5e
	ret ; $4a61
ServiceMatch2Hook_Bounce:
	call ServiceMatch2JudgeOnBounce ; $4a62
	ret ; $4a65
ServiceMatch2Hook_BallHit:
	call ServiceMatch2JudgeOnBallHit ; $4a66
	ret ; $4a69
ServiceMatch2PointStartDrillPositions:
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
	ld a, [wDrillPointJudgement] ; $4aaf
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
	ld [wDrillCounters + 1], a ; $4ac8
	ld a, $01 ; $4acb
	call CountDrillShotSuccesses ; $4acd
	ld [wDrillCounters + 2], a ; $4ad0
	call ShowQueuedDrillMessage ; $4ad3
	ld hl, wDrillServeTargetResult ; $4ad6
	ld a, [wCurrentServingPlayer] ; $4ad9
	add l ; $4adc
	ld l, a ; $4add
	jr nc, .read ; $4ade
	inc h ; $4ae0
.read:
	ld a, [hl] ; $4ae1
	or a ; $4ae2
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
; Instruction-identical to NetGameMatch1AwardPointToSide, NetGameMatch2AwardPointToSide, NetGameMatch3AwardPointToSide, ServiceMatch3AwardPointToSide, StrokeMatch2AwardPointToSide and StrokeMatch3AwardPointToSide (in this bank); a change here belongs in every copy.
	twin_named net_game_match1_award_point_to_side, ServiceMatch2AwardPointToSide ; $4b05
ServiceMatch2JudgeOnPointEnd:
	ld a, $00 ; $4b2e
	call ServiceMatch2JudgePoint ; $4b30
	ld [wDrillPointJudgement], a ; $4b33
	ret ; $4b36
ServiceMatch2JudgeOnBallHit:
	ld a, $01 ; $4b37
	call ServiceMatch2JudgePoint ; $4b39
	ld [wDrillPointJudgement], a ; $4b3c
	ret ; $4b3f
ServiceMatch2JudgeOnBounce:
	ret ; $4b40
	ld a, $02 ; $4b41
	call ServiceMatch2JudgePoint ; $4b43
	ld [wDrillPointJudgement], a ; $4b46
	ret ; $4b49
ServiceMatch2JudgeOnRallyTick:
	ld a, $03 ; $4b4a
	call ServiceMatch2JudgePoint ; $4b4c
	ld [wDrillPointJudgement], a ; $4b4f
	ret ; $4b52
ServiceMatch2JudgePoint:
	ld b, a ; $4b53
	ld a, [wDrillPointJudgement] ; $4b54
	or a ; $4b57
	ret nz ; $4b58
	ld a, [wRallyLength] ; $4b59
	dec a ; $4b5c
	ld a, a ; $4b5d
	rst Rst00 ; $4b5e
	dw ServiceMatch2JudgePoint.rally1 ; $4b5f jumptable
	dw ServiceMatch2Cases1.dispatchResult ; $4b61 jumptable
.rally1:
	ld a, b ; $4b63
	ld a, a ; $4b64
	rst Rst00 ; $4b65
	dw ServiceMatch2JudgePoint.result0 ; $4b66 jumptable
	dw ServiceMatch2Cases1 ; $4b68 jumptable
	dw ServiceMatch2Cases1.checkBallHasBouncedFlag2 ; $4b6a jumptable
	dw ServiceMatch2Cases1.checkBallHasBouncedFlag ; $4b6c jumptable
.result0:
	ld a, [wPointOutcome] ; $4b6e
	ld hl, ServiceMatch2JudgePointDrillShotTable ; $4b71
	add l ; $4b74
	ld l, a ; $4b75
	jr nc, .readEntry1 ; $4b76
	inc h ; $4b78
.readEntry1:
	ld a, [hl] ; $4b79
	ld a, a ; $4b7a
	ld b, $06 ; $4b7b
	call QueueDrillResultMessage ; $4b7d
	ld a, [wPointOutcome] ; $4b80
	ld hl, SignedTable_0b_00 ; $4b83
	add l ; $4b86
	ld l, a ; $4b87
	jr nc, .readEntry2 ; $4b88
	inc h ; $4b8a
.readEntry2:
	ld a, [hl] ; $4b8b
	ret ; $4b8c
ServiceMatch2JudgePointDrillShotTable:
	; $4b8d, 10 bytes (bytes:10)
	db $ff, $ff, $02, $ff, $ff, $02, $01, $ff, $ff, $01 ; 0x00
ServiceMatch2Cases1:
	xor a ; $4b97
	ret ; $4b98
.checkBallHasBouncedFlag2:
	xor a ; $4b99
	ret ; $4b9a
.checkBallHasBouncedFlag:
	ld a, [wBallHasBouncedFlag] ; $4b9b
	or a ; $4b9e
	ld a, $00 ; $4b9f
	ret nz ; $4ba1
	ld a, $03 ; $4ba2
	ld b, $06 ; $4ba4
	call QueueDrillResultMessage ; $4ba6
	farcall DidBallCrossGate ; $4ba9
	jr z, UnusedStoreMatchAbortFlag_2.storeMatchAbortFlag ; $4bac
	xor a ; $4bae
	ld [wDrillGateActive], a ; $4baf
	xor a ; $4bb2
	ld [wDrillGateActive], a ; $4bb3
	xor a ; $4bb6
	ret ; $4bb7
.dispatchResult:
	ld a, b ; $4bb8
	ld a, a ; $4bb9
	rst Rst00 ; $4bba
	dw ServiceMatch2Cases1.checkPointOutcome ; $4bbb jumptable
	dw ServiceMatch2Cases2 ; $4bbd jumptable
	dw ServiceMatch2Cases2.returnZero ; $4bbf jumptable
	dw ServiceMatch2Cases2.storeMatchAbortFlag2 ; $4bc1 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4bc3
	ld hl, ServiceMatch2Cases1DrillShotTable ; $4bc6
	add l ; $4bc9
	ld l, a ; $4bca
	jr nc, .read ; $4bcb
	inc h ; $4bcd
.read:
	ld a, [hl] ; $4bce
	ld a, a ; $4bcf
	ld b, $06 ; $4bd0
	call QueueDrillResultMessage ; $4bd2
	ld a, [wPointOutcome] ; $4bd5
	ld hl, SignedTable_0b_01 ; $4bd8
	add l ; $4bdb
	ld l, a ; $4bdc
	jr nc, .readB ; $4bdd
	inc h ; $4bdf
.readB:
	ld a, [hl] ; $4be0
	ret ; $4be1
ServiceMatch2Cases1DrillShotTable:
	; $4be2, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $06, $06, $ff ; 0x00
ServiceMatch2Cases2:
	ld a, [wPointOutcome] ; $4bec
	cp POINTOUTCOME_SERVE_VOLLEYED ; $4bef
	ld a, $00 ; $4bf1
	ret z ; $4bf3
	ld a, $04 ; $4bf4
	ld b, $06 ; $4bf6
	call QueueDrillResultMessage ; $4bf8
	jr UnusedStoreMatchAbortFlag_2.storeMatchAbortFlag ; $4bfb
	db $af ; $4bfd
	ret ; $4bfe
.returnZero:
	xor a ; $4bff
	ret ; $4c00
.storeMatchAbortFlag2:
	xor a ; $4c01
	ret ; $4c02
