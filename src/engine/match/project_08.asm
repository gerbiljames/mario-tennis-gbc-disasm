ProjectWorldToScreen_08:
	jp ProjectWorldToScreen ; $59b8
ApplyCameraProjection:
	ld e, l ; $59bb
	ld d, h ; $59bc
	ld hl, wCameraOffsetX ; $59bd
	ld a, [hl+] ; $59c0
	ld h, [hl] ; $59c1
	ld l, a ; $59c2
	add hl, de ; $59c3
	add hl, hl ; $59c4
	add hl, hl ; $59c5
	add hl, hl ; $59c6
	ld d, h ; $59c7
	ld hl, wCameraOffsetY ; $59c8
	ld a, [hl+] ; $59cb
	ld h, [hl] ; $59cc
	ld l, a ; $59cd
	add hl, bc ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	add hl, hl ; $59d1
	ld e, h ; $59d2
	ret ; $59d3
UnusedMulHLSignedByDE:
	bit 7, h ; $59d4
	jp z, MulHLByDE ; $59d6
	xor a ; $59d9
	sub l ; $59da
	ld l, a ; $59db
	sbc a ; $59dc
	sub h ; $59dd
	ld h, a ; $59de
	call MulHLByDE ; $59df
NegateMulResultLow:
	ldh a, [hMulResult] ; $59e2
	cpl ; $59e4
	add $01 ; $59e5
	ldh [hMulResult], a ; $59e7
	ldh a, [hMulResult + 1] ; $59e9
	cpl ; $59eb
	adc $00 ; $59ec
	ldh [hMulResult + 1], a ; $59ee
	ld a, l ; $59f0
	cpl ; $59f1
	adc $00 ; $59f2
	ld l, a ; $59f4
	ld a, h ; $59f5
	cpl ; $59f6
	adc $00 ; $59f7
	ld h, a ; $59f9
	ret ; $59fa
MulHLByDESigned32:
	ld a, h ; $59fb
	xor d ; $59fc
	ldh [hMathSign], a ; $59fd
	bit 7, h ; $59ff
	jr z, .absDE ; $5a01
	xor a ; $5a03
	sub l ; $5a04
	ld l, a ; $5a05
	sbc a ; $5a06
	sub h ; $5a07
	ld h, a ; $5a08
.absDE:
	bit 7, d ; $5a09
	jr z, .multiply ; $5a0b
	xor a ; $5a0d
	sub e ; $5a0e
	ld e, a ; $5a0f
	sbc a ; $5a10
	sub d ; $5a11
	ld d, a ; $5a12
.multiply:
	call MulHLByDE ; $5a13
	ldh a, [hMathSign] ; $5a16
	bit 7, a ; $5a18
	jr nz, NegateMulResultLow ; $5a1a
	ret ; $5a1c
MulHLByDEAbs:
	ld a, h ; $5a1d
	xor d ; $5a1e
	ldh [hMathSign], a ; $5a1f
	bit 7, h ; $5a21
	jr z, .absDE ; $5a23
	xor a ; $5a25
	sub l ; $5a26
	ld l, a ; $5a27
	sbc a ; $5a28
	sub h ; $5a29
	ld h, a ; $5a2a
.absDE:
	bit 7, d ; $5a2b
	jr z, .multiply ; $5a2d
	xor a ; $5a2f
	sub e ; $5a30
	ld e, a ; $5a31
	sbc a ; $5a32
	sub d ; $5a33
	ld d, a ; $5a34
.multiply:
	call MulHLByDE ; $5a35
	ret ; $5a38
MulSignedHLByAFrac:
	bit 7, h ; $5a39
	jp z, MulHLByAFrac ; $5a3b
	ld d, a ; $5a3e
	xor a ; $5a3f
	sub l ; $5a40
	ld l, a ; $5a41
	sbc a ; $5a42
	sub h ; $5a43
	ld h, a ; $5a44
	ld a, d ; $5a45
	call MulHLByAFrac ; $5a46
	ld e, l ; $5a49
	ld d, h ; $5a4a
	call NegateADE ; $5a4b
	ld l, e ; $5a4e
	ld h, d ; $5a4f
	ret ; $5a50
MulHLByTangent:
	push hl ; $5a51
	ld l, c ; $5a52
	ld h, b ; $5a53
	call GetTangent ; $5a54
	pop de ; $5a57
	call MulHLByDESigned32 ; $5a58
	ldh a, [hMulResult + 1] ; $5a5b
	ld d, l ; $5a5d
	ld e, a ; $5a5e
	ret ; $5a5f
UnusedAbsADE:
	bit 7, d ; $5a60
	ret z ; $5a62
NegateADE:
	cpl ; $5a63
	inc a ; $5a64
	jr nz, .notZero ; $5a65
	sub e ; $5a67
	ld e, a ; $5a68
	sbc a ; $5a69
	sub d ; $5a6a
	ld d, a ; $5a6b
	xor a ; $5a6c
	ret ; $5a6d
.notZero:
	push af ; $5a6e
	ld a, e ; $5a6f
	cpl ; $5a70
	ld e, a ; $5a71
	ld a, d ; $5a72
	cpl ; $5a73
	ld d, a ; $5a74
	pop af ; $5a75
	ret ; $5a76
Unused_08_AddSignedDEToMem24:
	ld a, e ; $5a77
	add [hl] ; $5a78
	ld [hl+], a ; $5a79
	ld a, d ; $5a7a
	adc [hl] ; $5a7b
	ld [hl+], a ; $5a7c
	bit 7, d ; $5a7d
	jr nz, .negative ; $5a7f
	ret nc ; $5a81
	inc [hl] ; $5a82
	ret ; $5a83
.negative:
	ret c ; $5a84
	dec [hl] ; $5a85
	ret ; $5a86
AddVel24ToPos32:
	ld a, [de] ; $5a87
	add [hl] ; $5a88
	ld [hl+], a ; $5a89
	inc de ; $5a8a
	ld a, [de] ; $5a8b
	adc [hl] ; $5a8c
	ld [hl+], a ; $5a8d
	inc de ; $5a8e
	ld a, [de] ; $5a8f
	bit 7, a ; $5a90
	jr nz, .carryHigh ; $5a92
	adc [hl] ; $5a94
	ld [hl+], a ; $5a95
	ret nc ; $5a96
	inc [hl] ; $5a97
	ret ; $5a98
.carryHigh:
	adc [hl] ; $5a99
	ld [hl+], a ; $5a9a
	ret c ; $5a9b
	dec [hl] ; $5a9c
	ret ; $5a9d
Add24ToMem24:
	add [hl] ; $5a9e
	ld [hl+], a ; $5a9f
	ld a, [hl] ; $5aa0
	adc e ; $5aa1
	ld [hl+], a ; $5aa2
	ld a, [hl] ; $5aa3
	adc d ; $5aa4
	ld [hl+], a ; $5aa5
	ret ; $5aa6
AddDEToMem24:
	ld a, [hl] ; $5aa7
	add e ; $5aa8
	ld [hl+], a ; $5aa9
	ld a, [hl] ; $5aaa
	adc d ; $5aab
	ld [hl+], a ; $5aac
	bit 7, d ; $5aad
	jr nz, .negative ; $5aaf
	ret nc ; $5ab1
	inc [hl] ; $5ab2
	ret ; $5ab3
.negative:
	ret c ; $5ab4
	dec [hl] ; $5ab5
	ret ; $5ab6
AddBCToMem24:
	ld a, [hl] ; $5ab7
	add c ; $5ab8
	ld [hl+], a ; $5ab9
	ld a, [hl] ; $5aba
	adc b ; $5abb
	ld [hl+], a ; $5abc
	bit 7, b ; $5abd
	jr nz, .negative ; $5abf
	ret nc ; $5ac1
	inc [hl] ; $5ac2
	ret ; $5ac3
.negative:
	ret c ; $5ac4
	dec [hl] ; $5ac5
	ret ; $5ac6
AddDEToMem24IntoBC:
	ld a, [hl+] ; $5ac7
	add e ; $5ac8
	ld a, [hl+] ; $5ac9
	adc d ; $5aca
	ld c, a ; $5acb
	bit 7, d ; $5acc
	ld b, [hl] ; $5ace
	jr nz, .negative ; $5acf
	ret nc ; $5ad1
	inc b ; $5ad2
	ret ; $5ad3
.negative:
	ret c ; $5ad4
	dec b ; $5ad5
	ret ; $5ad6
ScorePoint:
	call HandleServeFault ; $5ad7
	call FlagServiceReturnAce ; $5ada
	call ResolvePointWinner ; $5add
	ld [wPointWinLoseFlag], a ; $5ae0
	call UpdatePointStats ; $5ae3
ApplyPointToScore:
	ld a, [wTiebreakerIndicator] ; $5ae6
	and a ; $5ae9
	jr nz, .tiebreakPoint ; $5aea
	call AwardPoint ; $5aec
	ld b, $04 ; $5aef
	call ResetAdvantageToDeuce ; $5af1
	call CheckGameWon ; $5af4
	ld [wGameWinLoseFlag], a ; $5af7
	call AwardGame ; $5afa
	call CheckSetWon ; $5afd
	ld [wSetWinLoseFlag], a ; $5b00
	call AwardSet ; $5b03
	call CheckMatchWon ; $5b06
	ld [wMatchWinLoseFlag], a ; $5b09
	ret ; $5b0c
.tiebreakPoint:
	call AwardPoint ; $5b0d
	ld b, $07 ; $5b10
	call ResetAdvantageToDeuce ; $5b12
	call CheckTiebreakGameWon ; $5b15
	ld [wGameWinLoseFlag], a ; $5b18
	call AwardGame ; $5b1b
	call CheckSetWon ; $5b1e
	ld [wSetWinLoseFlag], a ; $5b21
	call AwardSet ; $5b24
	call CheckMatchWon ; $5b27
	ld [wMatchWinLoseFlag], a ; $5b2a
	ret ; $5b2d
EvaluatePointSituation:
	ld a, [wPlayer1PointsWon] ; $5b2e
	ld hl, wPlayer2PointsWon ; $5b31
	sub [hl] ; $5b34
	jr z, .done ; $5b35
	bit 7, a ; $5b37
	ld a, $01 ; $5b39
	jr z, .checkGamePoint ; $5b3b
	ld a, $ff ; $5b3d
.checkGamePoint:
	add sp, -16 ; $5b3f
	ld hl, sp + 0 ; $5b41
	ld e, l ; $5b43
	ld d, h ; $5b44
	push de ; $5b45
	push af ; $5b46
	ld hl, wPlayer1SetsWon ; $5b47
	ld c, $01 ; $5b4a
	call CopyMemoryFast ; $5b4c
	pop af ; $5b4f
	ld [wPointWinLoseFlag], a ; $5b50
	call ApplyPointToScore ; $5b53
	ld a, [wGameWinLoseFlag] ; $5b56
	ld [wGamePointFlag], a ; $5b59
	ld a, [wSetWinLoseFlag] ; $5b5c
	ld [wSetPointFlag], a ; $5b5f
	ld a, [wMatchWinLoseFlag] ; $5b62
	ld [wMatchPointFlag], a ; $5b65
	pop hl ; $5b68
	ld de, wPlayer1SetsWon ; $5b69
	ld c, $01 ; $5b6c
	call CopyMemoryFast ; $5b6e
	add sp, 16 ; $5b71
	ret ; $5b73
.done:
	xor a ; $5b74
	ld [wGamePointFlag], a ; $5b75
	ld [wSetPointFlag], a ; $5b78
	ld [wMatchPointFlag], a ; $5b7b
	ret ; $5b7e
HandleServeFault:
	ld a, [wRallyLength] ; $5b7f
	cp $01 ; $5b82
	ret nz ; $5b84
	ld a, [wPointOutcomeSide] ; $5b85
	cp $ff ; $5b88
	ret nz ; $5b8a
	ld a, [wServeFaultFlag] ; $5b8b
	and a ; $5b8e
	jr nz, .doubleFault ; $5b8f
	ld a, $01 ; $5b91
	ld [wServeFaultFlag], a ; $5b93
	ld a, POINTOUTCOME_FAULT ; $5b96
	ld [wPointOutcome], a ; $5b98
	ret ; $5b9b
.doubleFault:
	ld a, $00 ; $5b9c
	ld [wServeFaultFlag], a ; $5b9e
	ld a, POINTOUTCOME_DOUBLE_FAULT ; $5ba1
	ld [wPointOutcome], a ; $5ba3
	ret ; $5ba6
FlagServiceReturnAce:
	ld a, [wPointOutcome] ; $5ba7
	cp POINTOUTCOME_WINNER ; $5baa
	ret nz ; $5bac
	ld a, [wRallyLength] ; $5bad
	cp $01 ; $5bb0
	jr nz, .checkReturnAce ; $5bb2
	ld a, $01 ; $5bb4
	ld [wServiceAceFlag], a ; $5bb6
.checkReturnAce:
	ld a, [wRallyLength] ; $5bb9
	cp $02 ; $5bbc
	jr nz, .done ; $5bbe
	ld a, $01 ; $5bc0
	ld [wReturnAceFlag], a ; $5bc2
.done:
	ret ; $5bc5
ResetAdvantageToDeuce:
	ld a, [wPlayer1PointsWon] ; $5bc6
	cp b ; $5bc9
	jr nz, .done ; $5bca
	ld a, [wPlayer2PointsWon] ; $5bcc
	cp b ; $5bcf
	jr nz, .done ; $5bd0
	ld a, b ; $5bd2
	dec a ; $5bd3
	ld [wPlayer1PointsWon], a ; $5bd4
	ld [wPlayer2PointsWon], a ; $5bd7
.done:
	ret ; $5bda
AwardSet:
	ld a, [wSetWinLoseFlag] ; $5bdb
	add a ; $5bde
	ret z ; $5bdf
	ld hl, wPlayer1SetsWon ; $5be0
	jr nc, .increment ; $5be3
	ld hl, wPlayer2SetsWon ; $5be5
.increment:
	inc [hl] ; $5be8
	xor a ; $5be9
	ld [wPlayer1GamesWon], a ; $5bea
	ld [wPlayer2GamesWon], a ; $5bed
	ld [wTiebreakerIndicator], a ; $5bf0
	ret ; $5bf3
AwardGame:
	ld a, [wGameWinLoseFlag] ; $5bf4
	add a ; $5bf7
	ret z ; $5bf8
	ld hl, wPlayer1GamesWon ; $5bf9
	jr nc, .increment ; $5bfc
	ld hl, wPlayer2GamesWon ; $5bfe
.increment:
	inc [hl] ; $5c01
	xor a ; $5c02
	ld [wPlayer1PointsWon], a ; $5c03
	ld [wPlayer2PointsWon], a ; $5c06
	ld [wTotalPointsScoredInCurrentGame], a ; $5c09
	ld [wDeuceIndicator], a ; $5c0c
	ld hl, wTotalGamesWonInMatch ; $5c0f
	inc [hl] ; $5c12
	ret ; $5c13
AwardPoint:
	ld a, [wPointWinLoseFlag] ; $5c14
	add a ; $5c17
	ret z ; $5c18
	ld hl, wPlayer1PointsWon ; $5c19
	jr nc, .increment ; $5c1c
	ld hl, wPlayer2PointsWon ; $5c1e
.increment:
	inc [hl] ; $5c21
	xor a ; $5c22
	ld [wServeFaultFlag], a ; $5c23
	ld hl, wTotalPointsScoredInCurrentGame ; $5c26
	inc [hl] ; $5c29
	ret ; $5c2a
UpdatePointStats:
	call RecordFaultStat ; $5c2b
	call RecordDoubleFaultStat ; $5c2e
	ld a, [wPointOutcome] ; $5c31
	cp POINTOUTCOME_WINNER ; $5c34
	ret nz ; $5c36
	call RecordDropShotWinnerStat ; $5c37
	call RecordLobWinnerStat ; $5c3a
	call RecordSmashAceStat ; $5c3d
	call RecordReturnAceStat ; $5c40
	call RecordServiceAceStat ; $5c43
	ret ; $5c46
RecordFaultStat:
	ld a, [wPointOutcome] ; $5c47
	cp POINTOUTCOME_FAULT ; $5c4a
	ret nz ; $5c4c
	ld hl, wCharacter1Faults ; $5c4d
	jp RecordDropShotWinnerStat.bumpStat ; $5c50
RecordDoubleFaultStat:
	ld a, [wPointOutcome] ; $5c53
	cp POINTOUTCOME_DOUBLE_FAULT ; $5c56
	ret nz ; $5c58
	ld hl, wCharacter1DoubleFaults ; $5c59
	jp RecordDropShotWinnerStat.bumpStat ; $5c5c
RecordServiceAceStat:
	ld a, [wServiceAceFlag] ; $5c5f
	and a ; $5c62
	ret z ; $5c63
	ld a, POINTWINNER_SERVICE_ACE ; $5c64
	ld [wPointWinnerShotType], a ; $5c66
	ld hl, wCharacter1ServiceAces ; $5c69
	jp RecordDropShotWinnerStat.bumpStat ; $5c6c
