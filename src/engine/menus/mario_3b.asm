RecordExhibitionVictory:
	push_wram_bank $03 ; $7d57
	ld a, [wMatchWinLoseFlag] ; $7d60
	cp WINLOSE_LOSE ; $7d63
	jr z, .restore ; $7d65
	ld de, FLAG_DOUBLES ; $7d67
	call TestGameFlagByNumber ; $7d6a
	jr nz, .restore ; $7d6d
	ld a, [wPlayer1CurrentMainCharacter] ; $7d6f
	ld c, a ; $7d72
	farcall IsMarioCastCharacter ; $7d73
	or a ; $7d76
	jr z, .restore ; $7d77
	ld a, [wPlayer2CurrentMainCharacter] ; $7d79
	ld c, a ; $7d7c
	farcall IsMarioCastCharacter ; $7d7d
	or a ; $7d80
	jr z, .restore ; $7d81
	ld a, [wPlayer1CurrentMainCharacter] ; $7d83
	call GetMarioCastIndex ; $7d86
	ld d, a ; $7d89
	ld a, [wPlayer2CurrentMainCharacter] ; $7d8a
	call GetMarioCastIndex ; $7d8d
	ld e, a ; $7d90
	ld hl, wN64RecordsBlock ; $7d91
	farcall ReadMarioCastVictoryGrid ; $7d94
	ld a, d ; $7d97
	add a ; $7d98
	add a ; $7d99
	add a ; $7d9a
	add d ; $7d9b
	add e ; $7d9c
	ld hl, wN64RecordsBlock ; $7d9d
	add l ; $7da0
	ld l, a ; $7da1
	jr nc, .checkExhibitionModeCPUMainCharacterDifficulty ; $7da2
	inc h ; $7da4
.checkExhibitionModeCPUMainCharacterDifficulty:
	push hl ; $7da5
	ld d, [hl] ; $7da6
	ld a, [wExhibitionModeCPUMainCharacterDifficulty] ; $7da7
	call GetVictoryScore ; $7daa
	pop hl ; $7dad
	cp d ; $7dae
	jr c, .restore ; $7daf
	ld [hl], a ; $7db1
	call UpdateMarioCastUnlocks ; $7db2
	ld hl, wN64RecordsBlock ; $7db5
	farcall WriteMarioCastVictoryGrid ; $7db8
.step2:
	jr nz, .step2 ; $7dbb
.restore:
	pop_wram_bank ; $7dbd
	ret ; $7dc2
StubNop_3b_5:
	ret ; $7dc3
GetVictoryScore:
	ld b, a ; $7dc4
	ld hl, VictoryScoreTable ; $7dc5
	ld a, [wVictoryScoreTableAlt] ; $7dc8
	or a ; $7dcb
	jr z, .zero ; $7dcc
	ld hl, VictoryScoreTable1 ; $7dce
.zero:
	ld a, b ; $7dd1
	add l ; $7dd2
	ld l, a ; $7dd3
	jr nc, .read ; $7dd4
	inc h ; $7dd6
.read:
	ld a, [hl] ; $7dd7
	ret ; $7dd8
VictoryScoreTable:
	; $7dd9, 4 bytes (bytes:4)
	db $03, $05, $07, $09 ; 0x00
VictoryScoreTable1:
	; $7ddd, 4 bytes (bytes:4)
	db $02, $04, $06, $08 ; 0x00
GetMarioCastIndex:
	sub $17 ; $7de1
	ld hl, MarioCastOrderTable ; $7de3
	add l ; $7de6
	ld l, a ; $7de7
	jr nc, .read ; $7de8
	inc h ; $7dea
.read:
	ld a, [hl] ; $7deb
	ret ; $7dec
MarioCastOrderTable:
	; $7ded, 9 bytes (bytes:3)
	db $01, $05, $03 ; 0x00
	db $00, $07, $04 ; 0x03
	db $08, $06, $02 ; 0x06
UpdateMarioCastUnlocks:
	ld c, $00 ; $7df6
.loop:
	ld hl, wN64RecordsBlock ; $7df8
	ld a, c ; $7dfb
	add a ; $7dfc
	add a ; $7dfd
	add a ; $7dfe
	add c ; $7dff
	add l ; $7e00
	ld l, a ; $7e01
	jr nc, .gotPtr ; $7e02
	inc h ; $7e04
.gotPtr:
	ld b, $00 ; $7e05
.loopB:
	ld a, c ; $7e07
	cp b ; $7e08
	jr z, .countDone ; $7e09
	ld a, [hl] ; $7e0b
	or a ; $7e0c
	jr z, .zero ; $7e0d
.countDone:
	inc hl ; $7e0f
	inc b ; $7e10
	ld a, b ; $7e11
	cp $09 ; $7e12
	jr nz, .loopB ; $7e14
	ld de, SAVEFLAG_COURT_WAREHOUSE ; $7e16
	farcall SetSaveFlag ; $7e19
	jr .done ; $7e1c
.zero:
	inc c ; $7e1e
	ld a, c ; $7e1f
	cp $09 ; $7e20
	jr nz, .loop ; $7e22
.done:
	ret ; $7e24
CheckMarioCastChartExpanded:
	ldh a, [hWramBank] ; $7e25
	push af ; $7e27
	push bc ; $7e28
	ld b, $10 ; $7e29
	ld a, [wChartColumnList + 6] ; $7e2b
	cp $10 ; $7e2e
	jr z, .notExpanded ; $7e30
	pop bc ; $7e32
	pop_wram_bank ; $7e33
	ld a, $01 ; $7e38
	ret ; $7e3a
.notExpanded:
	pop bc ; $7e3b
	pop_wram_bank ; $7e3c
	xor a ; $7e41
	ret ; $7e42
ApplyMarioCastChartReducedLayout:
	push af ; $7e43
	push bc ; $7e44
	push de ; $7e45
	push hl ; $7e46
	push_wram_bank $03 ; $7e47
	call CheckMarioCastChartExpanded ; $7e50
	or a ; $7e53
	jr nz, .restore ; $7e54
	call CopyMarioCastChartReducedTilemap ; $7e56
	call FixupMarioCastChartHeaderRow ; $7e59
	call CompactMarioCastChartRows ; $7e5c
.restore:
	pop_wram_bank ; $7e5f
	pop hl ; $7e64
	pop de ; $7e65
	pop bc ; $7e66
	pop af ; $7e67
	ret ; $7e68
CopyMarioCastChartReducedTilemap:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 1 ; $7e69
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; $7e6c
	ld b, $12 ; $7e6f
	ld c, $0c ; $7e71
	farcall CopyTilemapRect ; $7e73
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH + 1 ; $7e76
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 1 ; $7e79
	ld b, $12 ; $7e7c
	ld c, $0c ; $7e7e
	farcall CopyTilemapRect ; $7e80
	ret ; $7e83
FixupMarioCastChartHeaderRow:
	ld a, [wChartColumnList + 5] ; $7e84
	ld [wChartColumnList + 4], a ; $7e87
	ret ; $7e8a
CompactMarioCastChartRows:
	ld hl, wChartRows + 80 ; $7e8b
	ld de, wChartRows + 64 ; $7e8e
	ld bc, $0010 ; $7e91
	call CopyMemoryBC ; $7e94
	ld hl, wChartRows + 5 ; $7e97
	ld de, wChartRows + 4 ; $7e9a
	ld c, $00 ; $7e9d
.loop:
	ld a, [hl] ; $7e9f
	ld [de], a ; $7ea0
	push bc ; $7ea1
	ld bc, $0010 ; $7ea2
	add hl, bc ; $7ea5
	push hl ; $7ea6
	ld hl, $0010 ; $7ea7
	add hl, de ; $7eaa
	ld d, h ; $7eab
	ld e, l ; $7eac
	pop hl ; $7ead
	pop bc ; $7eae
	inc c ; $7eaf
	ld a, c ; $7eb0
	cp $06 ; $7eb1
	jr nz, .loop ; $7eb3
	ret ; $7eb5
	; $7eb6, 330 bytes fill to bank end (linker-padded)
