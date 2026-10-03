EnableTargetZoneAfterDelayTask:
	ld hl, wDrillCounters + 8 ; $6bd0
	dec [hl] ; $6bd3
	ret nz ; $6bd4
	ld a, $01 ; $6bd5
	ld [wTargetZoneEnabled], a ; $6bd7
	ld hl, EnableTargetZoneAfterDelayTask ; $6bda
	call UnregisterFrameTask ; $6bdd
	ret ; $6be0
StrokePractice1Hook_PointEnd:
	call StrokePractice1JudgeOnPointEnd ; $6be1
	ld a, [wPointOutcome] ; $6be4
	cp POINTOUTCOME_OUT ; $6be7
	jr z, .eq05 ; $6be9
	jr .strokePractice1HandlePointEnd ; $6beb
.eq05:
	ld hl, wDrillCounters + 1 ; $6bed
	inc [hl] ; $6bf0
.strokePractice1HandlePointEnd:
	call StrokePractice1HandlePointEnd ; $6bf1
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bf4
	cp $04 ; $6bf7
	ret c ; $6bf9
	call StrokePractice1EvaluateResult ; $6bfa
	ld [wPointWinLoseFlag], a ; $6bfd
	ret ; $6c00
; Instruction-identical to StrokePractice3EvaluateResult (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_evaluate_result, StrokePractice1EvaluateResult ; $6c01
StrokePractice1Hook_RallyTick:
	call StrokePractice1JudgeOnRallyTick ; $6c4a
	ret ; $6c4d
StrokePractice1Hook_Bounce:
	call StrokePractice1JudgeOnBounce ; $6c4e
	ret ; $6c51
StrokePractice1Hook_BallHit:
	call StrokePractice1JudgeOnBallHit ; $6c52
	ld a, [wRallyLength] ; $6c55
	cp $01 ; $6c58
	ret nz ; $6c5a
	call ResetActiveCharState ; $6c5b
	ret ; $6c5e
StrokePractice1Table:
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
; Instruction-identical to StrokePractice3HandlePointEnd (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_handle_point_end, StrokePractice1HandlePointEnd ; $6c81
StrokePractice1JudgeOnPointEnd:
	ld a, $00 ; $6cd0
	call StrokePractice1JudgePoint ; $6cd2
	ld [wDrillPointJudgement], a ; $6cd5
	ret ; $6cd8
StrokePractice1JudgeOnBallHit:
	ld a, $01 ; $6cd9
	call StrokePractice1JudgePoint ; $6cdb
	ld [wDrillPointJudgement], a ; $6cde
	ret ; $6ce1
StrokePractice1JudgeOnBounce:
	ld a, $02 ; $6ce2
	call StrokePractice1JudgePoint ; $6ce4
	ld [wDrillPointJudgement], a ; $6ce7
	ret ; $6cea
; Judges the point on the rally-tick event -- except that the leading `ret`
; means the body never runs. Called from StrokePractice1Hook_RallyTick, the
; fourth of this drill's four judges; see docs/bugs.md.
StrokePractice1JudgeOnRallyTick:
	ret ; $6ceb
	ld a, $03 ; $6cec
	call StrokePractice1JudgePoint ; $6cee
	ld [wDrillPointJudgement], a ; $6cf1
	ret ; $6cf4
StrokePractice1JudgePoint:
	ld b, a ; $6cf5
	ld a, [wDrillPointJudgement] ; $6cf6
	or a ; $6cf9
	ret nz ; $6cfa
	ld a, [wRallyLength] ; $6cfb
	dec a ; $6cfe
	ld a, a ; $6cff
	rst Rst00 ; $6d00
	dw StrokePractice1JudgePoint.rally1 ; $6d01 jumptable
	dw StrokePractice1Cases1.dispatchResult ; $6d03 jumptable
.rally1:
	ld a, b ; $6d05
	ld a, a ; $6d06
	rst Rst00 ; $6d07
	dw StrokePractice1JudgePoint.result0 ; $6d08 jumptable
	dw StrokePractice1Cases1 ; $6d0a jumptable
	dw StrokePractice1Cases1.returnZero ; $6d0c jumptable
	dw StrokePractice1Cases1.returnZero2 ; $6d0e jumptable
.result0:
	ld a, [wPointOutcome] ; $6d10
	ld hl, StrokePractice1JudgePointSignedTable ; $6d13
	add l ; $6d16
	ld l, a ; $6d17
	jr nc, .readEntry1 ; $6d18
	inc h ; $6d1a
.readEntry1:
	ld a, [hl] ; $6d1b
	ld a, a ; $6d1c
	ld b, $00 ; $6d1d
	call QueueDrillResultMessage ; $6d1f
	ld a, [wPointOutcome] ; $6d22
	ld hl, SignedTable_0b_01 ; $6d25
	add l ; $6d28
	ld l, a ; $6d29
	jr nc, .readEntry2 ; $6d2a
	inc h ; $6d2c
.readEntry2:
	ld a, [hl] ; $6d2d
	ret ; $6d2e
StrokePractice1JudgePointSignedTable:
	; $6d2f, 10 bytes (bytes:10)
	db $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59 ; 0x00
StrokePractice1Cases1:
	xor a ; $6d39
	ret ; $6d3a
.returnZero:
	xor a ; $6d3b
	ret ; $6d3c
.returnZero2:
	xor a ; $6d3d
	ret ; $6d3e
.dispatchResult:
	ld a, b ; $6d3f
	ld a, a ; $6d40
	rst Rst00 ; $6d41
	dw StrokePractice1Cases1.checkPointOutcome ; $6d42 jumptable
	dw StrokePractice1Cases2 ; $6d44 jumptable
	dw StrokePractice1Cases2.checkBallBounceCount ; $6d46 jumptable
	dw StrokePractice1Cases2.storeMatchAbortFlag2 ; $6d48 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6d4a
	ld hl, StrokePractice1Cases1SignedTable ; $6d4d
	add l ; $6d50
	ld l, a ; $6d51
	jr nc, .read ; $6d52
	inc h ; $6d54
.read:
	ld a, [hl] ; $6d55
	ld a, a ; $6d56
	ld b, $00 ; $6d57
	call QueueDrillResultMessage ; $6d59
	ld a, [wPointOutcome] ; $6d5c
	ld hl, SignedTable_0b_00 ; $6d5f
	add l ; $6d62
	ld l, a ; $6d63
	jr nc, .readB ; $6d64
	inc h ; $6d66
.readB:
	ld a, [hl] ; $6d67
	ret ; $6d68
StrokePractice1Cases1SignedTable:
	; $6d69, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57 ; 0x00
; Instruction-identical to StrokePractice3Cases2 (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_cases2, StrokePractice1Cases2 ; $6d73
StrokePractice2Drill:
	; $6dae, 16 bytes
	drill_def CHAR_DRILL_STROKE_PRACTICE_2, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_PRACTICE_2, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, StrokePractice2Hooks, StrokePracticePointTable, StrokePractice2DrillInit
StrokePractice2DrillInit:
	ld a, $01 ; $6dbe
	ld [wDrillIsPracticeLesson], a ; $6dc0
	ret ; $6dc3
StrokePractice2Hooks:
	; $6dc4, 16 bytes (mode_hooks)
	dw StrokePractice2Hook_PerFrame ; record 0
	dw StrokePractice2Hook_PointStart ; record 1
	dw StrokePractice2Hook_PointEnd ; record 2
	dw StrokePractice2Hook_MinigameStart ; record 3
	dw StrokePractice2Hook_BallHit ; record 4
	dw StrokePractice2Hook_Bounce ; record 5
	dw StrokePractice2Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokePractice2Hook_MinigameStart:
	xor a ; $6dd4
	ld [wDrillCounters + 2], a ; $6dd5
	ld [wDrillCounters + 7], a ; $6dd8
	ret ; $6ddb
StrokePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6ddc
	ret ; $6ddf
StrokePractice2Hook_PointStart:
	xor a ; $6de0
	ld [wDrillAbortCountdownActive], a ; $6de1
	ld a, $0a ; $6de4
	ld [wDrillAbortCountdown], a ; $6de6
	xor a ; $6de9
	ld [wTargetZoneEnabled], a ; $6dea
	ld hl, StrokePractice2PointStartDrillPositions ; $6ded
	call SetDrillTargetZoneForPoint ; $6df0
	xor a ; $6df3
	ld [wDrillMessageId], a ; $6df4
	xor a ; $6df7
	ld [wDrillPointJudgement], a ; $6df8
	ld a, $5a ; $6dfb
	ld [wDrillCounters + 8], a ; $6dfd
	ld a, $01 ; $6e00
	ld hl, StrokePractice2TargetZoneDelayTask ; $6e02
	call RegisterFrameTask ; $6e05
	ld a, [wTotalPointsScoredInCurrentGame] ; $6e08
	ld hl, StrokePractice2PointStartTable ; $6e0b
	add l ; $6e0e
	ld l, a ; $6e0f
	jr nc, .read ; $6e10
	inc h ; $6e12
.read:
	ld a, [hl] ; $6e13
	ld [wAiServeAimOverride], a ; $6e14
	ret ; $6e17
StrokePractice2PointStartTable:
	; $6e18, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
StrokePractice2TargetZoneDelayTask:
	ld hl, wDrillCounters + 8 ; $6e1c
	dec [hl] ; $6e1f
	ret nz ; $6e20
	ld a, $01 ; $6e21
	ld [wTargetZoneEnabled], a ; $6e23
	ld hl, StrokePractice2TargetZoneDelayTask ; $6e26
	call UnregisterFrameTask ; $6e29
	ret ; $6e2c
StrokePractice2Hook_PointEnd:
	call StrokePractice2JudgeOnPointEnd ; $6e2d
	call StrokePractice2HandlePointEnd ; $6e30
	ld a, [wTotalPointsScoredInCurrentGame] ; $6e33
	cp $04 ; $6e36
	ret c ; $6e38
	call StrokePractice2EvaluateResult ; $6e39
	ld [wPointWinLoseFlag], a ; $6e3c
	ret ; $6e3f
StrokePractice2EvaluateResult:
	ld a, [wDrillCounters + 7] ; $6e40
	cp $04 ; $6e43
	jr nz, .ne04 ; $6e45
	xor a ; $6e47
	ld [wDrillLessonResult], a ; $6e48
	ld a, $01 ; $6e4b
	ret ; $6e4d
.ne04:
	ld a, [wDrillCounters + 7] ; $6e4e
	cp $03 ; $6e51
	jr c, .lt03 ; $6e53
	ld a, $05 ; $6e55
	ld [wDrillLessonResult], a ; $6e57
	jr .notFound ; $6e5a
.lt03:
	ld a, [wDrillCounters + 2] ; $6e5c
	cp $04 ; $6e5f
	jr nc, .checkRallyLength ; $6e61
	ld a, $01 ; $6e63
	ld [wDrillLessonResult], a ; $6e65
	jr .notFound ; $6e68
.checkRallyLength:
	ld a, [wRallyLength] ; $6e6a
	cp $03 ; $6e6d
	jr nc, .step3 ; $6e6f
	ld a, [wShotRecoilVariant] ; $6e71
	cp $01 ; $6e74
	jr nz, .compare ; $6e76
	ld a, $02 ; $6e78
	ld [wDrillLessonResult], a ; $6e7a
	jr .notFound ; $6e7d
.compare:
	cp $02 ; $6e7f
	jr nz, .step3 ; $6e81
	ld a, $03 ; $6e83
	ld [wDrillLessonResult], a ; $6e85
	jr .notFound ; $6e88
.step3:
	ld a, $04 ; $6e8a
	ld [wDrillLessonResult], a ; $6e8c
.notFound:
	ld a, $ff ; $6e8f
	ret ; $6e91
StrokePractice2Hook_RallyTick:
	call StrokePractice2JudgeOnRallyTick ; $6e92
	ld a, [wRallyLength] ; $6e95
	cp $02 ; $6e98
	ret nz ; $6e9a
	call ResetActiveCharState ; $6e9b
	ret ; $6e9e
StrokePractice2Hook_Bounce:
	call StrokePractice2JudgeOnBounce ; $6e9f
	ret ; $6ea2
StrokePractice2Hook_BallHit:
	call StrokePractice2JudgeOnBallHit ; $6ea3
	ret ; $6ea6
StrokePractice2PointStartDrillPositions:
	; $6ea7, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $fe50, $fb20, $0000, $fd60 ; point 0
	drill_gates $0000, $fb20, $01b0, $fd60 ; point 1
	drill_gates $0000, $02a0, $01b0, $04e0 ; point 2
	drill_gates $fe50, $02a0, $0000, $04e0 ; point 3
	db $ff, $ff ; end
StrokePractice2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6ec9
	ld a, [wDrillPointJudgement] ; $6ecc
	ld [wPointWinLoseFlag], a ; $6ecf
	cp $01 ; $6ed2
	jr nz, .recordDrillPointResultBits ; $6ed4
	ld hl, wDrillCounters + 7 ; $6ed6
	inc [hl] ; $6ed9
.recordDrillPointResultBits:
	call RecordDrillPointResultBits ; $6eda
	call ShowQueuedDrillMessage ; $6edd
	farcall UpdatePointStats ; $6ee0
	farcall AwardPoint ; $6ee3
	ld a, [wDrillCounters + 7] ; $6ee6
	ld [wPlayer1PointsWon], a ; $6ee9
	xor a ; $6eec
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
StrokePractice2JudgeOnPointEnd:
	ld a, $00 ; $6f18
	call StrokePractice2JudgePoint ; $6f1a
	ld [wDrillPointJudgement], a ; $6f1d
	ret ; $6f20
StrokePractice2JudgeOnBallHit:
	ld a, $01 ; $6f21
	call StrokePractice2JudgePoint ; $6f23
	ld [wDrillPointJudgement], a ; $6f26
	ret ; $6f29
StrokePractice2JudgeOnBounce:
	ld a, $02 ; $6f2a
	call StrokePractice2JudgePoint ; $6f2c
	ld [wDrillPointJudgement], a ; $6f2f
	ret ; $6f32
StrokePractice2JudgeOnRallyTick:
	ret ; $6f33
	ld a, $03 ; $6f34
	call StrokePractice2JudgePoint ; $6f36
	ld [wDrillPointJudgement], a ; $6f39
	ret ; $6f3c
StrokePractice2JudgePoint:
	ld b, a ; $6f3d
	ld a, [wDrillPointJudgement] ; $6f3e
	or a ; $6f41
	ret nz ; $6f42
	ld a, [wRallyLength] ; $6f43
	dec a ; $6f46
	ld a, a ; $6f47
	rst Rst00 ; $6f48
	dw StrokePractice2JudgePoint.rally1 ; $6f49 jumptable
	dw StrokePractice2Cases1.dispatchResult ; $6f4b jumptable
.rally1:
	ld a, b ; $6f4d
	ld a, a ; $6f4e
	rst Rst00 ; $6f4f
	dw StrokePractice2JudgePoint.result0 ; $6f50 jumptable
	dw StrokePractice2Cases1 ; $6f52 jumptable
	dw StrokePractice2Cases1.returnZero ; $6f54 jumptable
	dw StrokePractice2Cases1.returnZero2 ; $6f56 jumptable
.result0:
	ld a, [wPointOutcome] ; $6f58
	ld hl, StrokePractice2JudgePointDrillShotTable ; $6f5b
	add l ; $6f5e
	ld l, a ; $6f5f
	jr nc, .readEntry1 ; $6f60
	inc h ; $6f62
.readEntry1:
	ld a, [hl] ; $6f63
	ld a, a ; $6f64
	ld b, $00 ; $6f65
	call QueueDrillResultMessage ; $6f67
	ld a, [wPointOutcome] ; $6f6a
	ld hl, SignedTable_0b_01 ; $6f6d
	add l ; $6f70
	ld l, a ; $6f71
	jr nc, .readEntry2 ; $6f72
	inc h ; $6f74
.readEntry2:
	ld a, [hl] ; $6f75
	ret ; $6f76
StrokePractice2JudgePointDrillShotTable:
	; $6f77, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59
StrokePractice2Cases1:
	xor a ; $6f81
	ret ; $6f82
.returnZero:
	xor a ; $6f83
	ret ; $6f84
.returnZero2:
	xor a ; $6f85
	ret ; $6f86
.dispatchResult:
	ld a, b ; $6f87
	ld a, a ; $6f88
	rst Rst00 ; $6f89
	dw StrokePractice2Cases1.checkPointOutcome ; $6f8a jumptable
	dw StrokePractice2Cases2 ; $6f8c jumptable
	dw StrokePractice2Cases2.checkBallBounceCount ; $6f8e jumptable
	dw StrokePractice2Cases2.storeMatchAbortFlag2 ; $6f90 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6f92
	ld hl, StrokePractice2Cases1DrillShotTable ; $6f95
	add l ; $6f98
	ld l, a ; $6f99
	jr nc, .read ; $6f9a
	inc h ; $6f9c
.read:
	ld a, [hl] ; $6f9d
	ld a, a ; $6f9e
	ld b, $00 ; $6f9f
	call QueueDrillResultMessage ; $6fa1
	ld a, [wPointOutcome] ; $6fa4
	ld hl, SignedTable_0b_00 ; $6fa7
	add l ; $6faa
	ld l, a ; $6fab
	jr nc, .readB ; $6fac
	inc h ; $6fae
.readB:
	ld a, [hl] ; $6faf
	ret ; $6fb0
StrokePractice2Cases1DrillShotTable:
	; $6fb1, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57
StrokePractice2Cases2:
	ld a, [wBallBounceCount] ; $6fbb
	or a ; $6fbe
	ret z ; $6fbf
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_LOB_SO_YOU_FAIL ; $6fc0
	ld b, $00 ; $6fc2
	call QueueDrillResultMessage ; $6fc4
	ld a, [wCurrentShotType] ; $6fc7
	cp SHOTTYPE_LOB ; $6fca
	jp nz, .storeMatchAbortFlag ; $6fcc
	ld hl, wDrillCounters + 2 ; $6fcf
	inc [hl] ; $6fd2
	xor a ; $6fd3
	ret ; $6fd4
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $6fd5
	cp $01 ; $6fd8
	ld a, $00 ; $6fda
	ret nz ; $6fdc
	ld a, DRILLMSG_NICE_LOB_YOU_DID_IT ; $6fdd
	ld b, $00 ; $6fdf
	call QueueDrillResultMessage ; $6fe1
	call RecordDrillTargetZoneHit ; $6fe4
	call CheckDrillTargetZoneMissed ; $6fe7
	or a ; $6fea
	jp nz, .nonZero ; $6feb
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_3 ; $6fee
	ld b, $00 ; $6ff0
	call QueueDrillResultMessage ; $6ff2
	ld hl, wDrillCounters + 3 ; $6ff5
	inc [hl] ; $6ff8
	jp .storeMatchAbortFlag ; $6ff9
.storeMatchAbortFlag2:
	xor a ; $6ffc
	ret ; $6ffd
.nonZero:
	ld a, MATCHABORT_POINT ; $6ffe
	ld [wMatchAbortFlag], a ; $7000
	ld a, $01 ; $7003
	ret ; $7005
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $7006
	ld [wMatchAbortFlag], a ; $7008
	ld a, $ff ; $700b
	ret ; $700d
StrokePractice3Drill:
	; $700e, 16 bytes
	drill_def CHAR_DRILL_STROKE_PRACTICE_3, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_PRACTICE_3, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, StrokePractice3Hooks, StrokePracticePointTable, StrokePractice3DrillInit
StrokePractice3DrillInit:
	ld a, $01 ; $701e
	ld [wDrillIsPracticeLesson], a ; $7020
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
	ld [wDrillIsPracticeLesson], a ; $7036
	xor a ; $7039
	ld [wDrillCounters + 2], a ; $703a
	ld [wDrillCounters + 1], a ; $703d
	ret ; $7040
StrokePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $7041
	ret ; $7044
StrokePractice3Hook_PointStart:
	xor a ; $7045
	ld [wDrillAbortCountdownActive], a ; $7046
	ld a, $0a ; $7049
	ld [wDrillAbortCountdown], a ; $704b
	xor a ; $704e
	ld [wTargetZoneEnabled], a ; $704f
	ld hl, StrokePractice3PointStartDrillPositions ; $7052
	call SetDrillTargetZoneForPoint ; $7055
	xor a ; $7058
	ld [wDrillMessageId], a ; $7059
	xor a ; $705c
	ld [wDrillPointJudgement], a ; $705d
	ld a, $5a ; $7060
	ld [wDrillCounters + 8], a ; $7062
	ld a, $01 ; $7065
	ld hl, StrokePractice3TargetZoneDelayTask ; $7067
	call RegisterFrameTask ; $706a
	ld a, [wTotalPointsScoredInCurrentGame] ; $706d
	ld hl, StrokePractice3PointStartTable ; $7070
	add l ; $7073
	ld l, a ; $7074
	jr nc, .read ; $7075
	inc h ; $7077
.read:
	ld a, [hl] ; $7078
	ld [wAiServeAimOverride], a ; $7079
	ret ; $707c
StrokePractice3PointStartTable:
	; $707d, 4 bytes (bytes:4)
	db $00, $00, $00, $00 ; 0x00
StrokePractice3TargetZoneDelayTask:
	ld hl, wDrillCounters + 8 ; $7081
	dec [hl] ; $7084
	ret nz ; $7085
	ld a, $01 ; $7086
	ld [wTargetZoneEnabled], a ; $7088
	ld hl, StrokePractice3TargetZoneDelayTask ; $708b
	call UnregisterFrameTask ; $708e
	ret ; $7091
StrokePractice3Hook_PointEnd:
	call StrokePractice3JudgeOnPointEnd ; $7092
	call StrokePractice3HandlePointEnd ; $7095
	ld a, [wTotalPointsScoredInCurrentGame] ; $7098
	cp $04 ; $709b
	ret c ; $709d
	call StrokePractice3EvaluateResult ; $709e
	ld [wPointWinLoseFlag], a ; $70a1
	ret ; $70a4
; Instruction-identical to StrokePractice1EvaluateResult (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_evaluate_result, StrokePractice3EvaluateResult ; $70a5
StrokePractice3Hook_RallyTick:
	call StrokePractice3JudgeOnRallyTick ; $70ee
	ld a, [wRallyLength] ; $70f1
	cp $02 ; $70f4
	ret nz ; $70f6
	call ResetActiveCharState ; $70f7
	ret ; $70fa
StrokePractice3Hook_Bounce:
	call StrokePractice3JudgeOnBounce ; $70fb
	ret ; $70fe
StrokePractice3Hook_BallHit:
	call StrokePractice3JudgeOnBallHit ; $70ff
	ld a, [wRallyLength] ; $7102
	cp $01 ; $7105
	ret nz ; $7107
	ret ; $7108
StrokePractice3PointStartDrillPositions:
	; $7109, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $0120, $fb20, $01b0, $fd60 ; point 0
	drill_gates $fe50, $fb20, $fee0, $fd60 ; point 1
	drill_gates $fe50, $02a0, $fee0, $04e0 ; point 2
	drill_gates $0120, $02a0, $01b0, $04e0 ; point 3
	db $ff, $ff ; end
; Instruction-identical to StrokePractice1HandlePointEnd (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_handle_point_end, StrokePractice3HandlePointEnd ; $712b
StrokePractice3JudgeOnPointEnd:
	ld a, $00 ; $717a
	call StrokePractice3JudgePoint ; $717c
	ld [wDrillPointJudgement], a ; $717f
	ret ; $7182
StrokePractice3JudgeOnBallHit:
	ld a, $01 ; $7183
	call StrokePractice3JudgePoint ; $7185
	ld [wDrillPointJudgement], a ; $7188
	ret ; $718b
StrokePractice3JudgeOnBounce:
	ld a, $02 ; $718c
	call StrokePractice3JudgePoint ; $718e
	ld [wDrillPointJudgement], a ; $7191
	ret ; $7194
StrokePractice3JudgeOnRallyTick:
	ret ; $7195
	ld a, $03 ; $7196
	call StrokePractice3JudgePoint ; $7198
	ld [wDrillPointJudgement], a ; $719b
	ret ; $719e
StrokePractice3JudgePoint:
	ld b, a ; $719f
	ld a, [wDrillPointJudgement] ; $71a0
	or a ; $71a3
	ret nz ; $71a4
	ld a, [wRallyLength] ; $71a5
	dec a ; $71a8
	ld a, a ; $71a9
	rst Rst00 ; $71aa
	dw StrokePractice3JudgePoint.rally1 ; $71ab jumptable
	dw StrokePractice3Cases1.dispatchResult ; $71ad jumptable
.rally1:
	ld a, b ; $71af
	ld a, a ; $71b0
	rst Rst00 ; $71b1
	dw StrokePractice3JudgePoint.result0 ; $71b2 jumptable
	dw StrokePractice3Cases1 ; $71b4 jumptable
	dw StrokePractice3Cases1.returnZero ; $71b6 jumptable
	dw StrokePractice3Cases1.returnZero2 ; $71b8 jumptable
.result0:
	ld a, [wPointOutcome] ; $71ba
	ld hl, StrokePractice3JudgePointDrillShotTable ; $71bd
	add l ; $71c0
	ld l, a ; $71c1
	jr nc, .readEntry1 ; $71c2
	inc h ; $71c4
.readEntry1:
	ld a, [hl] ; $71c5
	ld a, a ; $71c6
	ld b, $00 ; $71c7
	call QueueDrillResultMessage ; $71c9
	ld a, [wPointOutcome] ; $71cc
	ld hl, SignedTable_0b_01 ; $71cf
	add l ; $71d2
	ld l, a ; $71d3
	jr nc, .readEntry2 ; $71d4
	inc h ; $71d6
.readEntry2:
	ld a, [hl] ; $71d7
	ret ; $71d8
StrokePractice3JudgePointDrillShotTable:
	; $71d9, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $5c, $ff, $ff, $5a, $59, $ff, $ff, $59
StrokePractice3Cases1:
	xor a ; $71e3
	ret ; $71e4
.returnZero:
	xor a ; $71e5
	ret ; $71e6
.returnZero2:
	xor a ; $71e7
	ret ; $71e8
.dispatchResult:
	ld a, b ; $71e9
	ld a, a ; $71ea
	rst Rst00 ; $71eb
	dw StrokePractice3Cases1.checkPointOutcome ; $71ec jumptable
	dw StrokePractice3Cases2 ; $71ee jumptable
	dw StrokePractice3Cases2.checkBallBounceCount ; $71f0 jumptable
	dw StrokePractice3Cases2.storeMatchAbortFlag2 ; $71f2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $71f4
	ld hl, StrokePractice3Cases1DrillShotTable ; $71f7
	add l ; $71fa
	ld l, a ; $71fb
	jr nc, .read ; $71fc
	inc h ; $71fe
.read:
	ld a, [hl] ; $71ff
	ld a, a ; $7200
	ld b, $00 ; $7201
	call QueueDrillResultMessage ; $7203
	ld a, [wPointOutcome] ; $7206
	ld hl, SignedTable_0b_00 ; $7209
	add l ; $720c
	ld l, a ; $720d
	jr nc, .readB ; $720e
	inc h ; $7210
.readB:
	ld a, [hl] ; $7211
	ret ; $7212
StrokePractice3Cases1DrillShotTable:
	; $7213, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $59, $59, $57, $5d, $5d, $57
; Instruction-identical to StrokePractice1Cases2 (in this bank); a change here belongs in every copy.
	twin_named stroke_practice1_cases2, StrokePractice3Cases2 ; $721d
RunDoublesDrillMatch:
	xor a ; $7258
	ld [wMatchContext], a ; $7259
	ld a, GAMEMODE_MARIO_MINIGAME ; $725c
	ld [wGameMode], a ; $725e
	ld a, MATCHLIST_TRAINING ; $7261
	ld [wCurrentMinigameStoryMatch], a ; $7263
	ld a, MINIGAME_TWO_ON_ONE ; $7266
	ld [wCurrentMinigameStoryMatch + 1], a ; $7268
	ld a, BGM_TWO_ON_ONE ; $726b
	ld [wMatchBGM], a ; $726d
	ld a, $01 ; $7270
	ld [wMatchIsDoubles], a ; $7272
	ld a, $03 ; $7275
	ld [wOnCourtCharCount], a ; $7277
	ld a, COURT_TWO_ON_ONE ; $727a
	ld [wCurrentlyUsedCourt], a ; $727c
	ld b, CHAR_BOWSER ; $727f
	ld a, b ; $7281
	ld [wMatchPlayerChar], a ; $7282
	ld c, $00 ; $7285
	farcall InitCa00RecordFromCharId ; $7287
	ld b, CHAR_WALUIGI ; $728a
	ld a, b ; $728c
	ld [wMatchOpponentChar], a ; $728d
	ld c, $02 ; $7290
	farcall InitCa00RecordFromCharId ; $7292
	ld b, CHAR_WARIO ; $7295
	ld c, $03 ; $7297
	farcall InitCa00RecordFromCharId ; $7299
	ld a, [wMinigameLevel] ; $729c
	add a ; $729f
	ld_hl_indexed DoublesDrillMatchPtrs ; $72a0
	ld a, [hl+] ; $72a7
	ld h, [hl] ; $72a8
	ld l, a ; $72a9
	ld a, [hl+] ; $72aa
	ld [wMatchTypeNumberOfGames], a ; $72ab
	ld a, [hl+] ; $72ae
	ld [wMatchTypeNumberOfSets], a ; $72af
	push hl ; $72b2
	ld a, [hl+] ; $72b3
	ld [wPlayer2MainAiParams], a ; $72b4
	ld a, [hl+] ; $72b7
	ld [wPlayer2MainAiParams + 1], a ; $72b8
	ld a, [hl+] ; $72bb
	ld [wPlayer2MainAiParams + 2], a ; $72bc
	ld a, [hl+] ; $72bf
	ld [wPlayer2MainAiParams + 3], a ; $72c0
	ld a, [hl+] ; $72c3
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $72c4
	pop hl ; $72c7
	ld a, [hl+] ; $72c8
	ld [wPlayer2PartnerAiParams], a ; $72c9
	ld a, [hl+] ; $72cc
	ld [wPlayer2PartnerAiParams + 1], a ; $72cd
	ld a, [hl+] ; $72d0
	ld [wPlayer2PartnerAiParams + 2], a ; $72d1
	ld a, [hl+] ; $72d4
	ld [wPlayer2PartnerAiParams + 3], a ; $72d5
	ld a, [hl+] ; $72d8
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $72d9
	farcall RunMatch ; $72dc
	ret ; $72df
DoublesDrillMatchPtrs:
	; $72e0, 6 bytes (records:2)
	dw DrillResultBitsRow0 ; record 0
	dw DrillResultBitsRow1 ; record 1
	dw DrillResultBitsRow2 ; record 2
DrillResultBitsRow0:
	; $72e6, 7 bytes (bytes:7)
	db $06, $01, $24, $13, $12, $1e, $00 ; 0x00
DrillResultBitsRow1:
	; $72ed, 7 bytes (bytes:7)
	db $06, $03, $14, $0f, $0a, $64, $01 ; 0x00
DrillResultBitsRow2:
	; $72f4, 7 bytes (bytes:7)
	db $06, $05, $0e, $0a, $02, $b4, $03 ; 0x00
	; $72fb, 3333 bytes fill to bank end (linker-padded)
