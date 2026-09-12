NetGameMatch3JudgeOnPointEnd:
	ld a, $00 ; $5a78
	call NetGameMatch3JudgePoint ; $5a7a
	ld [wDrillPointJudgement], a ; $5a7d
	ret ; $5a80
NetGameMatch3JudgeOnBallHit:
	ld a, $01 ; $5a81
	call NetGameMatch3JudgePoint ; $5a83
	ld [wDrillPointJudgement], a ; $5a86
	ret ; $5a89
NetGameMatch3JudgeOnBounce:
	ret ; $5a8a
	ld a, $02 ; $5a8b
	call NetGameMatch3JudgePoint ; $5a8d
	ld [wDrillPointJudgement], a ; $5a90
	ret ; $5a93
NetGameMatch3JudgeOnRallyTick:
	ret ; $5a94
	ld a, $03 ; $5a95
	call NetGameMatch3JudgePoint ; $5a97
	ld [wDrillPointJudgement], a ; $5a9a
	ret ; $5a9d
NetGameMatch3JudgePoint:
	ld b, a ; $5a9e
	ld a, [wDrillPointJudgement] ; $5a9f
	or a ; $5aa2
	ret nz ; $5aa3
	ld a, [wRallyLength] ; $5aa4
	dec a ; $5aa7
	ld a, a ; $5aa8
	rst Rst00 ; $5aa9
	dw NetGameMatch3JudgePoint.rally1 ; $5aaa jumptable
	dw NetGameMatch3Cases1.dispatchResult ; $5aac jumptable
	dw NetGameMatch3Cases2.dispatchResult ; $5aae jumptable
	dw NetGameMatch3Cases3.dispatchResult ; $5ab0 jumptable
	dw NetGameMatch3Cases4.dispatchResult ; $5ab2 jumptable
.rally1:
	ld a, b ; $5ab4
	ld a, a ; $5ab5
	rst Rst00 ; $5ab6
	dw NetGameMatch3JudgePoint.result0 ; $5ab7 jumptable
	dw NetGameMatch3Cases1 ; $5ab9 jumptable
	dw NetGameMatch3Cases1.returnZero ; $5abb jumptable
	dw NetGameMatch3Cases1.returnZero2 ; $5abd jumptable
.result0:
	ld a, [wPointOutcome] ; $5abf
	ld hl, NetGameMatch3JudgePointDrillShotTable ; $5ac2
	add l ; $5ac5
	ld l, a ; $5ac6
	jr nc, .readEntry1 ; $5ac7
	inc h ; $5ac9
.readEntry1:
	ld a, [hl] ; $5aca
	ld a, a ; $5acb
	ld b, $0d ; $5acc
	call QueueDrillResultMessage ; $5ace
	ld a, [wPointOutcome] ; $5ad1
	ld hl, SignedTable_0b_00 ; $5ad4
	add l ; $5ad7
	ld l, a ; $5ad8
	jr nc, .readEntry2 ; $5ad9
	inc h ; $5adb
.readEntry2:
	ld a, [hl] ; $5adc
	ret ; $5add
NetGameMatch3JudgePointDrillShotTable:
	; $5ade, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $19, $ff, $ff, $1d, $17, $ff, $ff, $17
NetGameMatch3Cases1:
	xor a ; $5ae8
	ret ; $5ae9
.returnZero:
	xor a ; $5aea
	ret ; $5aeb
.returnZero2:
	xor a ; $5aec
	ret ; $5aed
.dispatchResult:
	ld a, b ; $5aee
	ld a, a ; $5aef
	rst Rst00 ; $5af0
	dw NetGameMatch3Cases1.checkPointOutcome ; $5af1 jumptable
	dw NetGameMatch3Cases2 ; $5af3 jumptable
	dw NetGameMatch3Cases2.returnZero ; $5af5 jumptable
	dw NetGameMatch3Cases2.returnZero2 ; $5af7 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5af9
	ld hl, NetGameMatch3Cases1DrillShotTable ; $5afc
	add l ; $5aff
	ld l, a ; $5b00
	jr nc, .read ; $5b01
	inc h ; $5b03
.read:
	ld a, [hl] ; $5b04
	ld a, a ; $5b05
	ld b, $0d ; $5b06
	call QueueDrillResultMessage ; $5b08
	ld a, [wPointOutcome] ; $5b0b
	ld hl, SignedTable_0b_01 ; $5b0e
	add l ; $5b11
	ld l, a ; $5b12
	jr nc, .readB ; $5b13
	inc h ; $5b15
.readB:
	ld a, [hl] ; $5b16
	ret ; $5b17
NetGameMatch3Cases1DrillShotTable:
	; $5b18, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $17, $17, $20, $1e, $1e, $20
NetGameMatch3Cases2:
	xor a ; $5b22
	ret ; $5b23
.returnZero:
	xor a ; $5b24
	ret ; $5b25
.returnZero2:
	xor a ; $5b26
	ret ; $5b27
.dispatchResult:
	ld a, b ; $5b28
	ld a, a ; $5b29
	rst Rst00 ; $5b2a
	dw NetGameMatch3Cases2.checkPointOutcome ; $5b2b jumptable
	dw NetGameMatch3Cases3 ; $5b2d jumptable
	dw NetGameMatch3Cases3.returnZero ; $5b2f jumptable
	dw NetGameMatch3Cases3.returnZero2 ; $5b31 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5b33
	ld hl, NetGameMatch3Cases2DrillShotTable ; $5b36
	add l ; $5b39
	ld l, a ; $5b3a
	jr nc, .read ; $5b3b
	inc h ; $5b3d
.read:
	ld a, [hl] ; $5b3e
	ld a, a ; $5b3f
	ld b, $0d ; $5b40
	call QueueDrillResultMessage ; $5b42
	ld a, [wPointOutcome] ; $5b45
	ld hl, SignedTable_0b_00 ; $5b48
	add l ; $5b4b
	ld l, a ; $5b4c
	jr nc, .readB ; $5b4d
	inc h ; $5b4f
.readB:
	ld a, [hl] ; $5b50
	ret ; $5b51
NetGameMatch3Cases2DrillShotTable:
	; $5b52, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $1d, $1d, $16, $ff, $ff, $16
NetGameMatch3Cases3:
	ld a, $1b ; $5b5c
	ld b, $0d ; $5b5e
	call QueueDrillResultMessage ; $5b60
	ld a, [wTotalPointsScoredInCurrentGame] ; $5b63
	and $01 ; $5b66
	call TestCharStateBit4 ; $5b68
	or a ; $5b6b
	jp z, UnusedStoreMatchAbortFlag_5.storeMatchAbortFlag ; $5b6c
	xor a ; $5b6f
	ret ; $5b70
.returnZero:
	xor a ; $5b71
	ret ; $5b72
.returnZero2:
	xor a ; $5b73
	ret ; $5b74
.dispatchResult:
	ld a, b ; $5b75
	ld a, a ; $5b76
	rst Rst00 ; $5b77
	dw NetGameMatch3Cases3.checkPointOutcome ; $5b78 jumptable
	dw NetGameMatch3Cases4 ; $5b7a jumptable
	dw NetGameMatch3Cases4.noAction ; $5b7c jumptable
	dw NetGameMatch3Cases4.noAction2 ; $5b7e jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5b80
	ld hl, NetGameMatch3Cases3DrillShotTable ; $5b83
	add l ; $5b86
	ld l, a ; $5b87
	jr nc, .read ; $5b88
	inc h ; $5b8a
.read:
	ld a, [hl] ; $5b8b
	ld a, a ; $5b8c
	ld b, $0d ; $5b8d
	call QueueDrillResultMessage ; $5b8f
	ld a, [wPointOutcome] ; $5b92
	ld hl, SignedTable_0b_01 ; $5b95
	add l ; $5b98
	ld l, a ; $5b99
	jr nc, .readB ; $5b9a
	inc h ; $5b9c
.readB:
	ld a, [hl] ; $5b9d
	ret ; $5b9e
NetGameMatch3Cases3DrillShotTable:
	; $5b9f, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $16, $16, $1d, $ff, $ff, $1d
NetGameMatch3Cases4:
	xor a ; $5ba9
	ret ; $5baa
.noAction:
	xor a ; $5bab
	ret ; $5bac
.noAction2:
	xor a ; $5bad
	ret ; $5bae
.dispatchResult:
	ld a, b ; $5baf
	ld a, a ; $5bb0
	rst Rst00 ; $5bb1
	dw NetGameMatch3Cases4.queueDrillResultMessage2 ; $5bb2 jumptable
	dw NetGameMatch3Cases4.queueDrillResultMessage ; $5bb4 jumptable
	dw NetGameMatch3Cases4.noAction3 ; $5bb6 jumptable
	dw NetGameMatch3Cases4.storeMatchAbortFlag2 ; $5bb8 jumptable
.queueDrillResultMessage2:
	xor a ; $5bba
	ret ; $5bbb
.queueDrillResultMessage:
	ld a, $1d ; $5bbc
	ld b, $0d ; $5bbe
	call QueueDrillResultMessage ; $5bc0
	jp UnusedStoreMatchAbortFlag_5.storeMatchAbortFlag ; $5bc3
.noAction3:
	xor a ; $5bc6
	ret ; $5bc7
.storeMatchAbortFlag2:
	xor a ; $5bc8
	ret ; $5bc9
UnusedStoreMatchAbortFlag_5:
	ld a, MATCHABORT_POINT ; $5bca
	ld [wMatchAbortFlag], a ; $5bcc
	ld a, $01 ; $5bcf
	ret ; $5bd1
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $5bd2
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
	ld [wDrillIsPracticeLesson], a ; $5bec
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
	xor a ; $5c00
	ld [wDrillCounters + 2], a ; $5c01
	ld [wDrillCounters + 3], a ; $5c04
	ld [wDrillCounters + 4], a ; $5c07
	ld a, $04 ; $5c0a
	ld [wDrillCounters + 5], a ; $5c0c
	ld a, $01 ; $5c0f
	ld [wDrillIsPracticeLesson], a ; $5c11
	ret ; $5c14
NetGamePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5c15
	ret ; $5c18
NetGamePractice1Hook_PointStart:
	xor a ; $5c19
	ld [wDrillAbortCountdownActive], a ; $5c1a
	ld a, $0a ; $5c1d
	ld [wDrillAbortCountdown], a ; $5c1f
	xor a ; $5c22
	ld [wDrillCounters + 6], a ; $5c23
	ld a, $01 ; $5c26
	ld [wTargetZoneEnabled], a ; $5c28
	ld hl, NetGamePractice1Table ; $5c2b
	call SetDrillTargetZoneForPoint ; $5c2e
	ld a, $40 ; $5c31
	call LoadDrillOpponentChar ; $5c33
	xor a ; $5c36
	ld [wDrillMessageId], a ; $5c37
	xor a ; $5c3a
	ld [wDrillPointJudgement], a ; $5c3b
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c3e
	ld hl, NetGamePractice1PointStartTable ; $5c41
	add l ; $5c44
	ld l, a ; $5c45
	jr nc, .read ; $5c46
	inc h ; $5c48
.read:
	ld a, [hl] ; $5c49
	ld [wAiServeAimOverride], a ; $5c4a
	ret ; $5c4d
NetGamePractice1PointStartTable:
	; $5c4e, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
NetGamePractice1Hook_PointEnd:
	call NetGamePractice1JudgeOnPointEnd ; $5c52
	ld a, [wPointOutcome] ; $5c55
	cp POINTOUTCOME_NET ; $5c58
	jr z, .netGamePractice1HandlePointEnd2 ; $5c5a
	cp POINTOUTCOME_OUT ; $5c5c
	jr z, .netGamePractice1HandlePointEnd2 ; $5c5e
	jr .netGamePractice1HandlePointEnd ; $5c60
.netGamePractice1HandlePointEnd2:
	ld hl, wDrillCounters + 2 ; $5c62
	inc [hl] ; $5c65
.netGamePractice1HandlePointEnd:
	call NetGamePractice1HandlePointEnd ; $5c66
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c69
	cp $04 ; $5c6c
	ret c ; $5c6e
	call NetGamePractice1EvaluateResult ; $5c6f
	ld [wPointWinLoseFlag], a ; $5c72
	ret ; $5c75
NetGamePractice1EvaluateResult:
	ld a, [wDrillCounters + 4] ; $5c76
	cp $04 ; $5c79
	jr nz, .checkCharacter1DoubleFaults ; $5c7b
	xor a ; $5c7d
	ld [wDrillLessonResult], a ; $5c7e
	ld a, $01 ; $5c81
	ret ; $5c83
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5c84
	cp $04 ; $5c87
	jr nz, .compare ; $5c89
	ld a, $01 ; $5c8b
	ld [wDrillLessonResult], a ; $5c8d
	jr .notFound ; $5c90
.compare:
	or a ; $5c92
	jr z, .zero ; $5c93
	ld a, $02 ; $5c95
	ld [wDrillLessonResult], a ; $5c97
	jr .notFound ; $5c9a
.zero:
	ld a, [wDrillCounters + 4] ; $5c9c
	cp $03 ; $5c9f
	jr nz, .ne03 ; $5ca1
	ld a, $05 ; $5ca3
	ld [wDrillLessonResult], a ; $5ca5
	jr .notFound ; $5ca8
.ne03:
	ld a, [wDrillCounters + 5] ; $5caa
	or a ; $5cad
	jr nz, .nonZero ; $5cae
	ld a, $04 ; $5cb0
	ld [wDrillLessonResult], a ; $5cb2
	jr .notFound ; $5cb5
.nonZero:
	ld a, $03 ; $5cb7
	ld [wDrillLessonResult], a ; $5cb9
	jr .notFound ; $5cbc
.notFound:
	ld a, $ff ; $5cbe
	ret ; $5cc0
NetGamePractice1Hook_RallyTick:
	call NetGamePractice1JudgeOnRallyTick ; $5cc1
	ret ; $5cc4
NetGamePractice1Hook_Bounce:
	call NetGamePractice1JudgeOnBounce ; $5cc5
	ret ; $5cc8
NetGamePractice1Hook_BallHit:
	call NetGamePractice1JudgeOnBallHit ; $5cc9
	ld a, [wLastShotCharIndex] ; $5ccc
	cp $01 ; $5ccf
	jr nz, .done ; $5cd1
	call ResetActiveCharState ; $5cd3
.done:
	ret ; $5cd6
NetGamePractice1Table:
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
; Instruction-identical to NetGamePractice2HandlePointEnd and NetGamePractice3HandlePointEnd (in this bank); a change here belongs in every copy.
	twin_named net_game_practice1_handle_point_end, NetGamePractice1HandlePointEnd ; $5cf9
NetGamePractice1JudgeOnPointEnd:
	ld a, $00 ; $5d48
	call NetGamePractice1JudgePoint ; $5d4a
	ld [wDrillPointJudgement], a ; $5d4d
	ret ; $5d50
NetGamePractice1JudgeOnBallHit:
	ld a, $01 ; $5d51
	call NetGamePractice1JudgePoint ; $5d53
	ld [wDrillPointJudgement], a ; $5d56
	ret ; $5d59
NetGamePractice1JudgeOnBounce:
	ld a, $02 ; $5d5a
	call NetGamePractice1JudgePoint ; $5d5c
	ld [wDrillPointJudgement], a ; $5d5f
	ret ; $5d62
; Judges the point on the rally-tick event -- except that the leading `ret`
; means the body never runs. Called from NetGamePractice1Hook_RallyTick, the
; fourth of this drill's four judges; see docs/bugs.md.
NetGamePractice1JudgeOnRallyTick:
	ret ; $5d63
	ld a, $03 ; $5d64
	call NetGamePractice1JudgePoint ; $5d66
	ld [wDrillPointJudgement], a ; $5d69
	ret ; $5d6c
NetGamePractice1JudgePoint:
	ld b, a ; $5d6d
	ld a, [wDrillPointJudgement] ; $5d6e
	or a ; $5d71
	ret nz ; $5d72
	ld a, [wRallyLength] ; $5d73
	dec a ; $5d76
	ld a, a ; $5d77
	rst Rst00 ; $5d78
	dw NetGamePractice1JudgePoint.rally1 ; $5d79 jumptable
	dw NetGamePractice1Cases1.dispatchResult ; $5d7b jumptable
	dw NetGamePractice1Cases2.dispatchResult ; $5d7d jumptable
.rally1:
	ld a, b ; $5d7f
	ld a, a ; $5d80
	rst Rst00 ; $5d81
	dw NetGamePractice1JudgePoint.result0 ; $5d82 jumptable
	dw NetGamePractice1Cases1 ; $5d84 jumptable
	dw NetGamePractice1Cases1.returnZero ; $5d86 jumptable
	dw NetGamePractice1Cases1.returnZero2 ; $5d88 jumptable
.result0:
	ld a, [wPointOutcome] ; $5d8a
	ld hl, NetGamePractice1JudgePointSignedTable ; $5d8d
	add l ; $5d90
	ld l, a ; $5d91
	jr nc, .readEntry1 ; $5d92
	inc h ; $5d94
.readEntry1:
	ld a, [hl] ; $5d95
	ld a, a ; $5d96
	ld b, $00 ; $5d97
	call QueueDrillResultMessage ; $5d99
	ld a, [wPointOutcome] ; $5d9c
	ld hl, SignedTable_0b_00 ; $5d9f
	add l ; $5da2
	ld l, a ; $5da3
	jr nc, .readEntry2 ; $5da4
	inc h ; $5da6
.readEntry2:
	ld a, [hl] ; $5da7
	ret ; $5da8
NetGamePractice1JudgePointSignedTable:
	; $5da9, 10 bytes (bytes:10)
	db $ff, $ff, $33, $ff, $ff, $38, $31, $ff, $ff, $31 ; 0x00
NetGamePractice1Cases1:
	xor a ; $5db3
	ret ; $5db4
.returnZero:
	xor a ; $5db5
	ret ; $5db6
.returnZero2:
	xor a ; $5db7
	ret ; $5db8
.dispatchResult:
	ld a, b ; $5db9
	ld a, a ; $5dba
	rst Rst00 ; $5dbb
	dw NetGamePractice1Cases1.checkPointOutcome ; $5dbc jumptable
	dw NetGamePractice1Cases2 ; $5dbe jumptable
	dw NetGamePractice1Cases2.returnZero ; $5dc0 jumptable
	dw NetGamePractice1Cases2.returnZero2 ; $5dc2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5dc4
	ld hl, NetGamePractice1Cases1SignedTable ; $5dc7
	add l ; $5dca
	ld l, a ; $5dcb
	jr nc, .read ; $5dcc
	inc h ; $5dce
.read:
	ld a, [hl] ; $5dcf
	ld a, a ; $5dd0
	ld b, $00 ; $5dd1
	call QueueDrillResultMessage ; $5dd3
	ld a, [wPointOutcome] ; $5dd6
	ld hl, SignedTable_0b_01 ; $5dd9
	add l ; $5ddc
	ld l, a ; $5ddd
	jr nc, .readB ; $5dde
	inc h ; $5de0
.readB:
	ld a, [hl] ; $5de1
	ret ; $5de2
NetGamePractice1Cases1SignedTable:
	; $5de3, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $31, $31, $3a, $31, $31, $3a ; 0x00
NetGamePractice1Cases2:
	xor a ; $5ded
	ret ; $5dee
.returnZero:
	xor a ; $5def
	ret ; $5df0
.returnZero2:
	xor a ; $5df1
	ret ; $5df2
.dispatchResult:
	ld a, b ; $5df3
	ld a, a ; $5df4
	rst Rst00 ; $5df5
	dw NetGamePractice1Cases2.checkPointOutcome ; $5df6 jumptable
	dw NetGamePractice1Cases3 ; $5df8 jumptable
	dw NetGamePractice1Cases3.checkBallBounceCount ; $5dfa jumptable
	dw NetGamePractice1Cases3.storeMatchAbortFlag2 ; $5dfc jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5dfe
	ld hl, NetGamePractice1Cases2SignedTable1 ; $5e01
	add l ; $5e04
	ld l, a ; $5e05
	jr nc, .read ; $5e06
	inc h ; $5e08
.read:
	ld a, [hl] ; $5e09
	ld a, a ; $5e0a
	ld b, $00 ; $5e0b
	call QueueDrillResultMessage ; $5e0d
	ld a, [wPointOutcome] ; $5e10
	ld hl, NetGamePractice1Cases2SignedTable0 ; $5e13
	add l ; $5e16
	ld l, a ; $5e17
	jr nc, .readB ; $5e18
	inc h ; $5e1a
.readB:
	ld a, [hl] ; $5e1b
	ret ; $5e1c
NetGamePractice1Cases2SignedTable0:
	; $5e1d, 10 bytes (bytes:10)
	db $00, $00, $ff, $00, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
NetGamePractice1Cases2SignedTable1:
	; $5e27, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $38, $38, $38, $ff, $ff, $38 ; 0x00
NetGamePractice1Cases3:
	ld a, $35 ; $5e31
	ld b, $00 ; $5e33
	call QueueDrillResultMessage ; $5e35
	xor a ; $5e38
	call TestCharStateBit4 ; $5e39
	or a ; $5e3c
	jp z, .storeMatchAbortFlag ; $5e3d
	ld a, $3a ; $5e40
	ld b, $00 ; $5e42
	call QueueDrillResultMessage ; $5e44
	ld a, [wShotRecoilVariant] ; $5e47
	cp $01 ; $5e4a
	jp nz, .storeMatchAbortFlag ; $5e4c
	ld hl, wDrillCounters + 5 ; $5e4f
	dec [hl] ; $5e52
	xor a ; $5e53
	ret ; $5e54
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $5e55
	cp $01 ; $5e58
	ld a, $00 ; $5e5a
	ret nz ; $5e5c
	ld a, [wPointOutcome] ; $5e5d
	cp POINTOUTCOME_NET ; $5e60
	jr z, .eq04 ; $5e62
	ld a, $2e ; $5e64
	ld b, $00 ; $5e66
	call QueueDrillResultMessage ; $5e68
	call RecordDrillTargetZoneHit ; $5e6b
	call CheckDrillTargetZoneMissed ; $5e6e
	or a ; $5e71
	jp nz, .nonZero ; $5e72
.eq04:
	ld a, $38 ; $5e75
	ld b, $00 ; $5e77
	call QueueDrillResultMessage ; $5e79
	ld hl, wDrillCounters + 3 ; $5e7c
	inc [hl] ; $5e7f
	jp .storeMatchAbortFlag ; $5e80
.storeMatchAbortFlag2:
	xor a ; $5e83
	ret ; $5e84
.nonZero:
	ld a, MATCHABORT_POINT ; $5e85
	ld [wMatchAbortFlag], a ; $5e87
	ld a, $01 ; $5e8a
	ret ; $5e8c
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $5e8d
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
	ld [wDrillIsPracticeLesson], a ; $5ea7
	ret ; $5eaa
NetGamePractice2Hooks:
	; $5eab, 16 bytes (mode_hooks)
	dw NetGamePractice2Hook_PerFrame ; record 0
	dw NetGamePractice2Hook_PointStart ; record 1
	dw NetGamePractice2Hook_PointEnd ; record 2
	dw NetGamePractice2Hook_MinigameStart ; record 3
	dw NetGamePractice2Hook_BallHit ; record 4
	dw NetGamePractice2Hook_Bounce ; record 5
	dw NetGamePractice2Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGamePractice2Hook_MinigameStart:
	xor a ; $5ebb
	ld [wDrillCounters + 3], a ; $5ebc
	ld [wDrillCounters + 4], a ; $5ebf
	ld a, $04 ; $5ec2
	ld [wDrillCounters + 5], a ; $5ec4
	ld a, $01 ; $5ec7
	ld [wDrillIsPracticeLesson], a ; $5ec9
	ret ; $5ecc
NetGamePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5ecd
	ret ; $5ed0
NetGamePractice2Hook_PointStart:
	xor a ; $5ed1
	ld [wDrillAbortCountdownActive], a ; $5ed2
	ld a, $0a ; $5ed5
	ld [wDrillAbortCountdown], a ; $5ed7
	xor a ; $5eda
	ld [wDrillCounters + 1], a ; $5edb
	ld [wDrillCounters + 6], a ; $5ede
	ld a, $01 ; $5ee1
	ld [wTargetZoneEnabled], a ; $5ee3
	ld hl, NetGamePractice2PointStartDrillPositions ; $5ee6
	call SetDrillTargetZoneForPoint ; $5ee9
	ld a, $41 ; $5eec
	call LoadDrillOpponentChar ; $5eee
	xor a ; $5ef1
	ld [wDrillMessageId], a ; $5ef2
	xor a ; $5ef5
	ld [wDrillPointJudgement], a ; $5ef6
	ret ; $5ef9
NetGamePractice2Hook_PointEnd:
	call NetGamePractice2JudgeOnPointEnd ; $5efa
	ld a, [wPointOutcome] ; $5efd
	cp POINTOUTCOME_NET ; $5f00
	jr z, .netGamePractice2HandlePointEnd2 ; $5f02
	cp POINTOUTCOME_OUT ; $5f04
	jr z, .netGamePractice2HandlePointEnd2 ; $5f06
	jr .netGamePractice2HandlePointEnd ; $5f08
.netGamePractice2HandlePointEnd2:
	ld hl, wDrillCounters + 3 ; $5f0a
	inc [hl] ; $5f0d
.netGamePractice2HandlePointEnd:
	call NetGamePractice2HandlePointEnd ; $5f0e
	ld a, [wTotalPointsScoredInCurrentGame] ; $5f11
	cp $04 ; $5f14
	ret c ; $5f16
	call NetGamePractice2EvaluateResult ; $5f17
	ld [wPointWinLoseFlag], a ; $5f1a
	ret ; $5f1d
NetGamePractice2EvaluateResult:
	ld a, [wDrillCounters + 4] ; $5f1e
	cp $04 ; $5f21
	jr nz, .checkCharacter1DoubleFaults ; $5f23
	xor a ; $5f25
	ld [wDrillLessonResult], a ; $5f26
	ld a, $01 ; $5f29
	ret ; $5f2b
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5f2c
	cp $04 ; $5f2f
	jr nz, .compare ; $5f31
	ld a, $01 ; $5f33
	ld [wDrillLessonResult], a ; $5f35
	jr .notFound ; $5f38
.compare:
	or a ; $5f3a
	jr z, .zero ; $5f3b
	ld a, $02 ; $5f3d
	ld [wDrillLessonResult], a ; $5f3f
	jr .notFound ; $5f42
.zero:
	ld a, [wDrillCounters + 4] ; $5f44
	cp $03 ; $5f47
	jr nz, .ne03 ; $5f49
	ld a, $06 ; $5f4b
	ld [wDrillLessonResult], a ; $5f4d
	jr .notFound ; $5f50
.ne03:
	ld a, [wDrillCounters + 5] ; $5f52
	or a ; $5f55
	jr nz, .nonZero ; $5f56
	ld a, $05 ; $5f58
	ld [wDrillLessonResult], a ; $5f5a
	jr .notFound ; $5f5d
.nonZero:
	ld a, [wDrillCounters + 4] ; $5f5f
	cp $01 ; $5f62
	jr c, .step4 ; $5f64
	cp $03 ; $5f66
	jr nc, .step4 ; $5f68
	ld a, $04 ; $5f6a
	ld [wDrillLessonResult], a ; $5f6c
	jr .notFound ; $5f6f
.step4:
	ld a, $03 ; $5f71
	ld [wDrillLessonResult], a ; $5f73
	jr .notFound ; $5f76
.notFound:
	ld a, $ff ; $5f78
	ret ; $5f7a
NetGamePractice2Hook_RallyTick:
	call NetGamePractice2JudgeOnRallyTick ; $5f7b
	ret ; $5f7e
NetGamePractice2Hook_Bounce:
	call NetGamePractice2JudgeOnBounce ; $5f7f
	ret ; $5f82
NetGamePractice2Hook_BallHit:
	call NetGamePractice2JudgeOnBallHit ; $5f83
	ld a, [wLastShotCharIndex] ; $5f86
	cp $01 ; $5f89
	jr nz, .done ; $5f8b
	call ResetActiveCharState ; $5f8d
.done:
	ret ; $5f90
NetGamePractice2PointStartDrillPositions:
	; $5f91, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $fe50, $fd60, $0000, $fe40 ; point 0
	drill_gates $0000, $fd60, $01b0, $fe40 ; point 1
	drill_gates $0000, $01c0, $01b0, $02a0 ; point 2
	drill_gates $fe50, $01c0, $0000, $02a0 ; point 3
	db $ff, $ff ; end
; Instruction-identical to NetGamePractice1HandlePointEnd and NetGamePractice3HandlePointEnd (in this bank); a change here belongs in every copy.
	twin_named net_game_practice1_handle_point_end, NetGamePractice2HandlePointEnd ; $5fb3
NetGamePractice2JudgeOnPointEnd:
	ld a, $00 ; $6002
	call NetGamePractice2JudgePoint ; $6004
	ld [wDrillPointJudgement], a ; $6007
	ret ; $600a
NetGamePractice2JudgeOnBallHit:
	ld a, $01 ; $600b
	call NetGamePractice2JudgePoint ; $600d
	ld [wDrillPointJudgement], a ; $6010
	ret ; $6013
NetGamePractice2JudgeOnBounce:
	ld a, $02 ; $6014
	call NetGamePractice2JudgePoint ; $6016
	ld [wDrillPointJudgement], a ; $6019
	ret ; $601c
NetGamePractice2JudgeOnRallyTick:
	ret ; $601d
	ld a, $03 ; $601e
	call NetGamePractice2JudgePoint ; $6020
	ld [wDrillPointJudgement], a ; $6023
	ret ; $6026
NetGamePractice2JudgePoint:
	ld b, a ; $6027
	ld a, [wDrillPointJudgement] ; $6028
	or a ; $602b
	ret nz ; $602c
	ld a, [wRallyLength] ; $602d
	dec a ; $6030
	ld a, a ; $6031
	rst Rst00 ; $6032
	dw NetGamePractice2JudgePoint.rally1 ; $6033 jumptable
	dw NetGamePractice2Cases1.dispatchResult ; $6035 jumptable
	dw NetGamePractice2Cases2.dispatchResult ; $6037 jumptable
.rally1:
	ld a, b ; $6039
	ld a, a ; $603a
	rst Rst00 ; $603b
	dw NetGamePractice2JudgePoint.result0 ; $603c jumptable
	dw NetGamePractice2Cases1 ; $603e jumptable
	dw NetGamePractice2Cases1.checkBallBounceCount ; $6040 jumptable
	dw NetGamePractice2Cases1.returnZero ; $6042 jumptable
.result0:
	ld a, [wPointOutcome] ; $6044
	ld hl, NetGamePractice2JudgePointDrillShotTable ; $6047
	add l ; $604a
	ld l, a ; $604b
	jr nc, .readEntry1 ; $604c
	inc h ; $604e
.readEntry1:
	ld a, [hl] ; $604f
	ld a, a ; $6050
	ld b, $00 ; $6051
	call QueueDrillResultMessage ; $6053
	ld a, [wPointOutcome] ; $6056
	ld hl, SignedTable_0b_00 ; $6059
	add l ; $605c
	ld l, a ; $605d
	jr nc, .readEntry2 ; $605e
	inc h ; $6060
.readEntry2:
	ld a, [hl] ; $6061
	ret ; $6062
NetGamePractice2JudgePointDrillShotTable:
	; $6063, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $33, $ff, $ff, $3b, $31, $ff, $ff, $31
NetGamePractice2Cases1:
	xor a ; $606d
	ret ; $606e
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $606f
	cp $01 ; $6072
	ld a, $00 ; $6074
	ret nz ; $6076
	ld a, [wBallHasBouncedFlag] ; $6077
	or a ; $607a
	ld a, $00 ; $607b
	ret nz ; $607d
	ld a, [wPointOutcome] ; $607e
	cp POINTOUTCOME_OUT ; $6081
	ld a, $00 ; $6083
	ret z ; $6085
	ld a, [wPointOutcome] ; $6086
	cp POINTOUTCOME_DOUBLE_FAULT ; $6089
	ld a, $00 ; $608b
	ret z ; $608d
	ld a, $3b ; $608e
	ld b, $00 ; $6090
	call QueueDrillResultMessage ; $6092
	call RecordDrillTargetZoneHit ; $6095
	call CheckDrillTargetZoneMissed ; $6098
	or a ; $609b
	jp z, NetGamePractice2Cases3.ne09 ; $609c
	xor a ; $609f
	ret ; $60a0
.returnZero:
	xor a ; $60a1
	ret ; $60a2
.dispatchResult:
	ld a, b ; $60a3
	ld a, a ; $60a4
	rst Rst00 ; $60a5
	dw NetGamePractice2Cases1.checkPointOutcome ; $60a6 jumptable
	dw NetGamePractice2Cases2 ; $60a8 jumptable
	dw NetGamePractice2Cases2.returnZero ; $60aa jumptable
	dw NetGamePractice2Cases2.returnZero2 ; $60ac jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $60ae
	ld hl, NetGamePractice2Cases1DrillShotTable ; $60b1
	add l ; $60b4
	ld l, a ; $60b5
	jr nc, .read ; $60b6
	inc h ; $60b8
.read:
	ld a, [hl] ; $60b9
	ld a, a ; $60ba
	ld b, $00 ; $60bb
	call QueueDrillResultMessage ; $60bd
	ld a, [wPointOutcome] ; $60c0
	ld hl, SignedTable_0b_01 ; $60c3
	add l ; $60c6
	ld l, a ; $60c7
	jr nc, .readB ; $60c8
	inc h ; $60ca
.readB:
	ld a, [hl] ; $60cb
	ret ; $60cc
NetGamePractice2Cases1DrillShotTable:
	; $60cd, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $31, $31, $36, $31, $31, $36
NetGamePractice2Cases2:
	ld a, [wBallBounceCount] ; $60d7
	or a ; $60da
	ret z ; $60db
	ld a, $32 ; $60dc
	ld b, $00 ; $60de
	call QueueDrillResultMessage ; $60e0
	ld a, [wCurrentShotType] ; $60e3
	cp SHOTTYPE_LOB ; $60e6
	jp nz, NetGamePractice2Cases3.storeMatchAbortFlag ; $60e8
	xor a ; $60eb
	ret ; $60ec
.returnZero:
	xor a ; $60ed
	ret ; $60ee
.returnZero2:
	xor a ; $60ef
	ret ; $60f0
.dispatchResult:
	ld a, b ; $60f1
	ld a, a ; $60f2
	rst Rst00 ; $60f3
	dw NetGamePractice2Cases2.checkPointOutcome ; $60f4 jumptable
	dw NetGamePractice2Cases3 ; $60f6 jumptable
	dw NetGamePractice2Cases3.returnZero ; $60f8 jumptable
	dw NetGamePractice2Cases3.storeMatchAbortFlag2 ; $60fa jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $60fc
	ld hl, NetGamePractice2Cases2DrillShotTable ; $60ff
	add l ; $6102
	ld l, a ; $6103
	jr nc, .read ; $6104
	inc h ; $6106
.read:
	ld a, [hl] ; $6107
	ld a, a ; $6108
	ld b, $00 ; $6109
	call QueueDrillResultMessage ; $610b
	ld a, [wPointOutcome] ; $610e
	ld hl, SignedTable_0b_00 ; $6111
	add l ; $6114
	ld l, a ; $6115
	jr nc, .readB ; $6116
	inc h ; $6118
.readB:
	ld a, [hl] ; $6119
	ret ; $611a
NetGamePractice2Cases2DrillShotTable:
	; $611b, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $37, $37, $2f, $ff, $ff, $2f
NetGamePractice2Cases3:
	ld a, $36 ; $6125
	ld b, $00 ; $6127
	call QueueDrillResultMessage ; $6129
	ld a, [wCurrentShotType] ; $612c
	cp SHOTTYPE_SMASH ; $612f
	jp nz, .ne09 ; $6131
	ld hl, wDrillCounters + 5 ; $6134
	dec [hl] ; $6137
	xor a ; $6138
	ret ; $6139
.returnZero:
	xor a ; $613a
	ret ; $613b
.storeMatchAbortFlag2:
	xor a ; $613c
	ret ; $613d
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $613e
	ld [wMatchAbortFlag], a ; $6140
	ld a, $01 ; $6143
	ret ; $6145
.ne09:
	ld a, MATCHABORT_POINT ; $6146
	ld [wMatchAbortFlag], a ; $6148
	ld a, $ff ; $614b
	ret ; $614d
