UnusedServeSecondBounceSound_2:
	ld a, [wBallBounceCount] ; $5041
	cp $02 ; $5044
	ret nz ; $5046
	ld a, [wRallyLength] ; $5047
	cp $01 ; $504a
	ret nz ; $504c
	sound SFX_BEEP ; $504d
	ret ; $504f
ServicePractice2Hook_BallHit:
	ld a, [wRallyLength] ; $5050
	cp $02 ; $5053
	jr c, .done ; $5055
	ld a, $01 ; $5057
	ld [wDrillAbortCountdownActive], a ; $5059
	call ResetActiveCharState ; $505c
.done:
	ret ; $505f
ServicePractice2PointStartDrillPositions:
	; $5060, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $fe50, $fd60, $fee0, $fe40 ; point 0
	drill_gates $0120, $fd60, $01b0, $fe40 ; point 1
	drill_gates $0120, $01c0, $01b0, $02a0 ; point 2
	drill_gates $fe50, $01c0, $fee0, $02a0 ; point 3
	db $ff, $ff ; end
ServicePractice2HandlePointEnd:
	call ServicePractice2SetupShotTarget ; $5082
	farcall UpdateScorePanelDisplay ; $5085
	call ServicePractice2QueueOutcomeMessage ; $5088
	ld [wPointWinLoseFlag], a ; $508b
	call RecordDrillPointResultBits ; $508e
	ld a, $00 ; $5091
	call CountDrillShotSuccesses ; $5093
	ld [wDrillCounters + 5], a ; $5096
	ld a, $01 ; $5099
	call CountDrillShotSuccesses ; $509b
	ld [wDrillCounters + 6], a ; $509e
	ld a, [wDrillMessageId] ; $50a1
	or a ; $50a4
	jr nz, .showDrillMessageByIndex ; $50a5
	call QueueDrillOutcomeMessage ; $50a7
.showDrillMessageByIndex:
	call ShowDrillMessageByIndex ; $50aa
	farcall UpdatePointStats ; $50ad
	farcall AwardPoint ; $50b0
	ld a, [wDrillCounters + 5] ; $50b3
	ld [wPlayer1PointsWon], a ; $50b6
	xor a ; $50b9
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
	cp $01 ; $50e8
	ret nz ; $50ea
	ld a, [wTotalPointsScoredInCurrentGame] ; $50eb
	cp $04 ; $50ee
	ret nc ; $50f0
	ld hl, Table_0b_2 ; $50f1
	add l ; $50f4
	ld l, a ; $50f5
	jr nc, .checkStoryModeMainCharacterLeftHanded ; $50f6
	inc h ; $50f8
.checkStoryModeMainCharacterLeftHanded:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $50f9
	add l ; $50fc
	ld l, a ; $50fd
	jr nc, .read ; $50fe
	inc h ; $5100
.read:
	ld b, [hl] ; $5101
	ld a, [wCurrentShotType] ; $5102
	ld [wDrillCounters + 3], a ; $5105
	cp b ; $5108
	jr nz, .checkTotalPointsScoredInCurrentGame ; $5109
	ld a, [wTotalPointsScoredInCurrentGame] ; $510b
	add a ; $510e
	ld hl, ServicePractice2SetupShotTargetTable ; $510f
	add l ; $5112
	ld l, a ; $5113
	jr nc, .checkStoryModeMainCharacterLeftHanded2 ; $5114
	inc h ; $5116
.checkStoryModeMainCharacterLeftHanded2:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5117
	add a ; $511a
	add l ; $511b
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
	and $01 ; $5128
	add $11 ; $512a
	ld [wDrillMessageId], a ; $512c
	ret ; $512f
Table_0b_2:
	; $5130, 5 bytes (bytes:15)
	db $0d, $0c, $0d, $0c, $0d ; 0x00
ServicePractice2SetupShotTargetTable:
	; $5135, 10 bytes (bytes:15)
	db $e9, $c2, $e8, $c2, $e9, $c2, $e8, $c2, $e9, $c2 ; 0x00
ServicePractice2QueueOutcomeMessage:
	ld a, [wPointOutcome] ; $513f
	cp POINTOUTCOME_FAULT ; $5142
	jp z, .step4 ; $5144
	cp POINTOUTCOME_LET ; $5147
	jp z, .step4 ; $5149
	ld a, [wPointOutcome] ; $514c
	cp POINTOUTCOME_DOUBLE_FAULT ; $514f
	jr nz, .ne02 ; $5151
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 ; $5153
	ld b, $00 ; $5155
	call QueueDrillResultMessage ; $5157
	jr .notFound ; $515a
.ne02:
	ld a, DRILLMSG_YOU_DIDNT_USE_TOPSPIN_TO_BOUNCE_IT_OUT_OF_BOUNDS ; $515c
	ld b, $00 ; $515e
	call QueueDrillResultMessage ; $5160
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5163
	and $01 ; $5166
	ld b, a ; $5168
	ld a, [wTotalPointsScoredInCurrentGame] ; $5169
	add b ; $516c
	and $01 ; $516d
	xor $01 ; $516f
	ld b, a ; $5171
	ld a, [wDrillMessageId] ; $5172
	add b ; $5175
	ld [wDrillMessageId], a ; $5176
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5179
	ld hl, ServicePractice2QueueOutcomeMessageDrillShotTable ; $517c
	add l ; $517f
	ld l, a ; $5180
	jr nc, .checkTotalPointsScoredInCurrentGame ; $5181
	inc h ; $5183
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5184
	add l ; $5187
	ld l, a ; $5188
	jr nc, .read ; $5189
	inc h ; $518b
.read:
	ld b, [hl] ; $518c
	ld a, [wDrillCounters + 3] ; $518d
	cp b ; $5190
	jr nz, .notFound ; $5191
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $5193
	ld b, $00 ; $5195
	call QueueDrillResultMessage ; $5197
	call CheckDrillTargetZoneMissed ; $519a
	or a ; $519d
	jr z, .notFound ; $519e
	ld a, DRILLMSG_NICE_SERVE_YOU_GET_A_POINT ; $51a0
	ld b, $00 ; $51a2
	call QueueDrillResultMessage ; $51a4
	ld a, [wPointOutcome] ; $51a7
	cp POINTOUTCOME_WINNER ; $51aa
	jr z, .eq06 ; $51ac
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 ; $51ae
	ld b, $00 ; $51b0
	call QueueDrillResultMessage ; $51b2
	jr .notFound ; $51b5
.eq06:
	ld hl, wDrillCounters ; $51b7
	inc [hl] ; $51ba
	ld a, $01 ; $51bb
	ret ; $51bd
.notFound:
	ld a, $ff ; $51be
	ret ; $51c0
.step4:
	ld a, DRILLMSG_HIDE ; $51c1
	ld [wDrillMessageId], a ; $51c3
	xor a ; $51c6
	ret ; $51c7
ServicePractice2QueueOutcomeMessageDrillShotTable:
	; $51c8, 5 bytes (bytes:5)
	db $0d, $0c, $0d, $0c, $0d ; 0x00
ServicePractice3Drill:
	; $51cd, 16 bytes
	drill_def CHAR_DRILL_SERVICE_PRACTICE_3, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_SERVICE_PRACTICE_3, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, ServicePractice3Hooks, PracticeDrillPointTable, ServicePractice3DrillInit
ServicePractice3DrillInit:
	ld a, $01 ; $51dd
	ld [wDrillIsPracticeLesson], a ; $51df
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
	ld [wDrillCounters + 1], a ; $51f5
	ld a, $01 ; $51f8
	ld [wDrillIsPracticeLesson], a ; $51fa
	ret ; $51fd
ServicePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $51fe
	ld a, [wRallyLength] ; $5201
	cp $01 ; $5204
	jr nz, .done ; $5206
	call RecordGateCrossOnServe ; $5208
.done:
	ret ; $520b
ServicePractice3Hook_Draw:
	call QueueDrillMarker1_0b ; $520c
	call QueueDrillMarker2_0b ; $520f
	ret ; $5212
ServicePractice3Hook_PointStart:
	xor a ; $5213
	ld [wDrillAbortCountdownActive], a ; $5214
	ld a, $0a ; $5217
	ld [wDrillAbortCountdown], a ; $5219
	ld a, $01 ; $521c
	ld [wTargetZoneEnabled], a ; $521e
	ld hl, ServicePractice3TargetZones ; $5221
	call SetDrillTargetZoneForPoint ; $5224
	ld a, $01 ; $5227
	ld [wDrillGateActive], a ; $5229
	ld hl, ServicePractice3PointStartDrillPositions ; $522c
	call IndexDrillTableByPoint ; $522f
	xor a ; $5232
	ld [wDrillMessageId], a ; $5233
	ret ; $5236
ServicePractice3Hook_PointEnd:
	call ServicePractice3HandlePointEnd ; $5237
	ld a, [wTotalPointsScoredInCurrentGame] ; $523a
	cp $04 ; $523d
	ret c ; $523f
	ld a, [wPointWinLoseFlag] ; $5240
	or a ; $5243
	ret z ; $5244
	call ServicePractice3EvaluateResult ; $5245
	ld [wPointWinLoseFlag], a ; $5248
	ld a, MATCHABORT_MATCH ; $524b
	ld [wMatchAbortFlag], a ; $524d
	ret ; $5250
ServicePractice3EvaluateResult:
	call CountDrillResultBitsSet ; $5251
	ld b, a ; $5254
	call CountDrillResultBitsSetAlt ; $5255
	ld c, a ; $5258
	ld a, [wDrillCounters] ; $5259
	or a ; $525c
	jr nz, .checkCharacter1DoubleFaults ; $525d
	ld a, $01 ; $525f
	ld [wDrillLessonResult], a ; $5261
	jr .notFound ; $5264
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5266
	or a ; $5269
	jr z, .countDrillResultBitsSet ; $526a
	ld a, $02 ; $526c
	ld [wDrillLessonResult], a ; $526e
	jr .notFound ; $5271
.countDrillResultBitsSet:
	call CountDrillResultBitsSet ; $5273
	or a ; $5276
	jr z, .zero ; $5277
	ld a, $03 ; $5279
	ld [wDrillLessonResult], a ; $527b
	jr .notFound ; $527e
.zero:
	ld a, [wDrillCounters + 1] ; $5280
	or a ; $5283
	jr z, .countDrillResultBitsSetAlt ; $5284
	ld a, $04 ; $5286
	ld [wDrillLessonResult], a ; $5288
	jr .notFound ; $528b
.countDrillResultBitsSetAlt:
	call CountDrillResultBitsSetAlt ; $528d
	cp $04 ; $5290
	jr z, .eq04 ; $5292
	ld a, $05 ; $5294
	ld [wDrillLessonResult], a ; $5296
	jr .notFound ; $5299
.notFound:
	ld a, $ff ; $529b
	ret ; $529d
.eq04:
	xor a ; $529e
	ld [wDrillLessonResult], a ; $529f
	ld a, $01 ; $52a2
	ret ; $52a4
ServicePractice3Hook_RallyTick:
	ret ; $52a5
ServicePractice3Hook_Bounce:
	ld a, [wRallyLength] ; $52a6
	cp $01 ; $52a9
	ret nz ; $52ab
	call RecordDrillTargetZoneHitIfInPlay ; $52ac
	ret ; $52af
ServicePractice3Hook_BallHit:
	call ServicePractice3SetupShotTarget ; $52b0
	ld a, [wRallyLength] ; $52b3
	cp $02 ; $52b6
	jr c, .done ; $52b8
	ld a, $01 ; $52ba
	ld [wDrillAbortCountdownActive], a ; $52bc
	call ResetActiveCharState ; $52bf
.done:
	ret ; $52c2
ServicePractice3SetupShotTarget:
	ld a, [wRallyLength] ; $52c3
	cp $01 ; $52c6
	ret nz ; $52c8
	ld a, [wTotalPointsScoredInCurrentGame] ; $52c9
	cp $04 ; $52cc
	ret nc ; $52ce
	ld a, [wSpecialShotFlag] ; $52cf
	or a ; $52d2
	jr nz, .nonZero ; $52d3
	ld a, DRILLMSG_YOU_DIDNT_SERVE_WITH_NICE_TIMING_SO_YOU_FAIL ; $52d5
	ld [wDrillMessageId], a ; $52d7
	ret ; $52da
.nonZero:
	ld hl, wDrillCounters + 1 ; $52db
	dec [hl] ; $52de
	ret ; $52df
ServicePractice3PointStartDrillPositions:
	; $52e0, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $0000, $02a0, $006c, $02a0 ; point 0
	drill_gates $ff94, $02a0, $0000, $02a0 ; point 1
	drill_gates $ff94, $fd60, $0000, $fd60 ; point 2
	drill_gates $0000, $fd60, $006c, $fd60 ; point 3
	db $ff, $ff ; end
ServicePractice3TargetZones:
	; $5302, 34 bytes (records:8)
; 4 records x 8 bytes
	dw $ff94, $fd60, $0000, $feb0 ; record 0
	dw $0000, $fd60, $006c, $feb0 ; record 1
	dw $0000, $0150, $006c, $02a0 ; record 2
	dw $ff94, $0150, $0000, $02a0 ; record 3
	db $ff, $ff
ServicePractice3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5324
	call ServicePractice3QueueOutcomeMessage ; $5327
	ld [wPointWinLoseFlag], a ; $532a
	call RecordDrillPointResultBits ; $532d
	ld a, $00 ; $5330
	call CountDrillShotSuccesses ; $5332
	ld [wDrillCounters + 5], a ; $5335
	ld a, $01 ; $5338
	call CountDrillShotSuccesses ; $533a
	ld [wDrillCounters + 6], a ; $533d
	call ShowQueuedDrillMessage ; $5340
	farcall UpdatePointStats ; $5343
	farcall AwardPoint ; $5346
	ld a, [wDrillCounters + 5] ; $5349
	ld [wPlayer1PointsWon], a ; $534c
	xor a ; $534f
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
	cp POINTOUTCOME_FAULT ; $537e
	jp z, .step4 ; $5380
	cp POINTOUTCOME_LET ; $5383
	jp z, .step4 ; $5385
	ld a, [wPointOutcome] ; $5388
	cp POINTOUTCOME_DOUBLE_FAULT ; $538b
	jr z, .eq02 ; $538d
	ld a, DRILLMSG_YOU_DIDNT_SERVE_WITH_NICE_TIMING_SO_YOU_FAIL ; $538f
	ld b, $00 ; $5391
	call QueueDrillResultMessage ; $5393
	ld a, [wSpecialShotFlag] ; $5396
	or a ; $5399
	jr z, .notFound ; $539a
	ld a, DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAIL ; $539c
	ld b, $00 ; $539e
	call QueueDrillResultMessage ; $53a0
	call CountDrillResultBitsThisGame ; $53a3
	jr z, .notFound ; $53a6
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $53a8
	ld b, $00 ; $53aa
	call QueueDrillResultMessage ; $53ac
	call CheckDrillTargetZoneMissed ; $53af
	or a ; $53b2
	jr z, .notFound ; $53b3
	ld a, DRILLMSG_NICE_SERVE_YOU_GET_A_POINT ; $53b5
	ld b, $00 ; $53b7
	call QueueDrillResultMessage ; $53b9
	ld a, [wPointOutcome] ; $53bc
	cp POINTOUTCOME_WINNER ; $53bf
	jr z, .eq06 ; $53c1
.eq02:
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 ; $53c3
	ld b, $00 ; $53c5
	call QueueDrillResultMessage ; $53c7
	jr .notFound ; $53ca
.eq06:
	ld hl, wDrillCounters ; $53cc
	inc [hl] ; $53cf
	ld a, $01 ; $53d0
	ret ; $53d2
.notFound:
	ld a, $ff ; $53d3
	ret ; $53d5
.step4:
	ld a, DRILLMSG_HIDE ; $53d6
	ld [wDrillMessageId], a ; $53d8
	xor a ; $53db
	ret ; $53dc
