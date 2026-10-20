PrepareScoreboardGfx:
	ld a, $00 ; $4915
	ld [wScoreboardOrigin + 1], a ; $4917
	ld a, $02 ; $491a
	ld [wScoreboardOrigin], a ; $491c
	ld a, [wScoreboardLayout] ; $491f
	cp SCOREBOARD_SCORE ; $4922
	jr nz, .checkScoreboardLayout ; $4924
	ld a, $02 ; $4926
	ld [wScoreboardOrigin + 1], a ; $4928
.checkScoreboardLayout:
	ld a, [wScoreboardLayout] ; $492b
	cp SCOREBOARD_HIGH_SCORE ; $492e
	jr nz, .checkOnCourtCharCountMinus1 ; $4930
	ld a, $02 ; $4932
	ld [wScoreboardOrigin + 1], a ; $4934
.checkOnCourtCharCountMinus1:
	jumptable [wOnCourtCharCountMinus1] ; $4937
	dw PrepareScoreboardGfx.reloadOneChar ; $493b jumptable
	dw PrepareScoreboardGfx.reloadTwoChars ; $493d jumptable
	dw PrepareScoreboardGfx.reloadThreeChars ; $493f jumptable
	dw PrepareScoreboardGfx.reloadFourChars ; $4941 jumptable
.reloadFourChars:
	wram_bank WRAM_SCENE ; $4943
	farcall ReloadCharPalette ; $4949
.reloadThreeChars:
	wram_bank WRAM_SOUND ; $494c
	farcall ReloadCharPalette ; $4952
.reloadTwoChars:
	wram_bank WRAM_TEXT ; $4955
	farcall ReloadCharPalette ; $495b
.reloadOneChar:
	wram_bank WRAM_ACTORS ; $495e
	farcall ReloadCharPalette ; $4964
	farcall StepMatchFrame ; $4967
	ld a, [wMatchContext] ; $496a
	cp MATCHCONTEXT_MINIGAME ; $496d
	jr z, .minigame ; $496f
	ld a, [wPlayer1GamesWon] ; $4971
	ld b, DIGITGFX_NUMERALS ; $4974
	ld de, vTiles0 tile $70 ; $4976
	farcall LoadScoreDigitGfx ; $4979
	ld a, [wPlayer1SetsWon] ; $497c
	ld b, DIGITGFX_NUMERALS ; $497f
	ld de, vTiles0 tile $68 ; $4981
	farcall LoadScoreDigitGfx ; $4984
	ld a, [wPlayer2GamesWon] ; $4987
	ld b, DIGITGFX_NUMERALS ; $498a
	ld de, vTiles0 tile $74 ; $498c
	farcall LoadScoreDigitGfx ; $498f
	ld a, [wPlayer2SetsWon] ; $4992
	ld b, DIGITGFX_NUMERALS ; $4995
	ld de, vTiles0 tile $6c ; $4997
	farcall LoadScoreDigitGfx ; $499a
	farcall StepMatchFrame ; $499d
.minigame:
	wram_bank WRAM_COURT_PLANES ; $49a0
	ret ; $49a6
DrawScoreboard:
	push bc ; $49a7
	ld hl, wScoreboardOrigin ; $49a8
	ld a, [hl+] ; $49ab
	ld d, [hl] ; $49ac
	ld e, a ; $49ad
	ld a, [wScoreboardLayout] ; $49ae
	add a ; $49b1
	ld_hl_indexed ScoreboardTilemapPointers ; $49b2
	ld a, [hl+] ; $49b9
	ld h, [hl] ; $49ba
	ld l, a ; $49bb
	call CopyTextRectPair ; $49bc
	pop bc ; $49bf
	jumptable [wScoreboardLayout] ; $49c0
	dw RetStub ; $49c4 jumptable
	dw RetStub ; $49c6 jumptable
	dw RetStub ; $49c8 jumptable
	dw DrawScoreboardDrillResultRow ; $49ca jumptable
	dw DrawScoreboardDrillResultRows ; $49cc jumptable
	dw DrawScoreboardPointPips ; $49ce jumptable
	dw RetStub ; $49d0 jumptable
	dw RetStub ; $49d2 jumptable
	ret ; $49d4
DrawScoreboardDrillResultRows:
	ld_cell de, $05, $04 ; $49d5
	ld c, $04 ; $49d8
	call DrawScoreboardEmptyPips ; $49da
	ld a, [wDrillShotResultBits + 1] ; $49dd
	ld c, a ; $49e0
	call DrawScoreboardPackedPips ; $49e1
DrawScoreboardDrillResultRow:
	ld_cell de, $05, $02 ; $49e4
	ld c, $04 ; $49e7
	call DrawScoreboardEmptyPips ; $49e9
	ld a, [wDrillShotResultBits] ; $49ec
	ld c, a ; $49ef
	call DrawScoreboardPackedPips ; $49f0
	ret ; $49f3
DrawScoreboardPointPips:
	ld_cell de, $03, $02 ; $49f4
	ld c, $05 ; $49f7
	call DrawScoreboardEmptyPips ; $49f9
	ld a, [wPlayer1PointsWon] ; $49fc
	ld c, a ; $49ff
	call DrawScoreboardFilledPips ; $4a00
	ld_cell de, $03, $04 ; $4a03
	ld c, $05 ; $4a06
	call DrawScoreboardEmptyPips ; $4a08
	ld a, [wPlayer2PointsWon] ; $4a0b
	ld c, a ; $4a0e
	call DrawScoreboardFilledPips ; $4a0f
	ret ; $4a12
DrawScoreboardPackedPips:
	ld hl, wScoreboardOrigin ; $4a13
	ld a, [hl+] ; $4a16
	ld h, [hl] ; $4a17
	ld l, a ; $4a18
	add hl, de ; $4a19
	ld e, l ; $4a1a
	ld d, h ; $4a1b
.loop:
	push bc ; $4a1c
	push de ; $4a1d
	ld hl, DrawScoreboardPackedPipsNext ; $4a1e
	push hl ; $4a21
	ld a, c ; $4a22
	and $03 ; $4a23
	jumptable a ; $4a25
	dw RetStub ; $4a27 jumptable
	dw DrawScoreboardPipFilled ; $4a29 jumptable
	dw DrawScoreboardPipAlt ; $4a2b jumptable
	dw DrawScoreboardPipAlt ; $4a2d jumptable
DrawScoreboardPackedPipsNext:
	pop de ; $4a2f
	pop bc ; $4a30
	inc d ; $4a31
	inc d ; $4a32
	srl c ; $4a33
	srl c ; $4a35
	jr nz, DrawScoreboardPackedPips.loop ; $4a37
	ret ; $4a39
DrawScoreboardFilledPips:
	inc c ; $4a3a
	dec c ; $4a3b
	ret z ; $4a3c
	ld hl, wScoreboardOrigin ; $4a3d
	ld a, [hl+] ; $4a40
	ld h, [hl] ; $4a41
	ld l, a ; $4a42
	add hl, de ; $4a43
	ld e, l ; $4a44
	ld d, h ; $4a45
.loop:
	push bc ; $4a46
	push de ; $4a47
	call DrawScoreboardPipFilled ; $4a48
	pop de ; $4a4b
	pop bc ; $4a4c
	inc d ; $4a4d
	inc d ; $4a4e
	dec c ; $4a4f
	jr nz, .loop ; $4a50
	ret ; $4a52
DrawScoreboardEmptyPips:
	inc b ; $4a53
	dec b ; $4a54
	ret z ; $4a55
	push de ; $4a56
	ld hl, wScoreboardOrigin ; $4a57
	ld a, [hl+] ; $4a5a
	ld h, [hl] ; $4a5b
	ld l, a ; $4a5c
	add hl, de ; $4a5d
	ld e, l ; $4a5e
	ld d, h ; $4a5f
.pipLoop:
	push bc ; $4a60
	push de ; $4a61
	call DrawScoreboardPipEmpty ; $4a62
	pop de ; $4a65
	pop bc ; $4a66
	inc d ; $4a67
	inc d ; $4a68
	dec c ; $4a69
	jr nz, .pipLoop ; $4a6a
	pop de ; $4a6c
	ret ; $4a6d
DrawScoreboardPipFilled:
	ld hl, ScoreboardPipFilledRect ; $4a6e
	call CopyTextRectPair ; $4a71
	ret ; $4a74
DrawScoreboardPipAlt:
	ld hl, ScoreboardPipAltRect ; $4a75
	call CopyTextRectPair ; $4a78
	ret ; $4a7b
DrawScoreboardPipEmpty:
	ld hl, ScoreboardPipEmptyRect ; $4a7c
	call CopyTextRectPair ; $4a7f
	ret ; $4a82
ScoreboardPipTilesFilled:
	; $4a83, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0a, $0b ; row 0
	tilemap_row $1a, $1b ; row 1
	tilemap_end
ScoreboardPipTilesAlt:
	; $4a87, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0c, $0d ; row 0
	tilemap_row $1c, $1d ; row 1
	tilemap_end
ScoreboardPipTilesEmpty:
	; $4a8b, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0e, $0f ; row 0
	tilemap_row $1e, $1f ; row 1
	tilemap_end
ScoreboardPipAttrsFilled:
	; $4a8f, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipAttrsAlt:
	; $4a93, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipAttrsEmpty:
	; $4a97, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipFilledRect:
	; $4a9b, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesFilled, ScoreboardPipAttrsFilled
ScoreboardPipAltRect:
	; $4aa1, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesAlt, ScoreboardPipAttrsAlt
ScoreboardPipEmptyRect:
	; $4aa7, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesEmpty, ScoreboardPipAttrsEmpty
ScoreboardMatchTilemap:
	; $4aad, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardLessonTilemap:
	; $4b32, 95 bytes (tilemap:19)
	tilemap_begin 19, 5
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $31, $20, $32, $20, $33, $20, $34, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 4
	tilemap_end
ScoreboardDrillTilemap:
	; $4b91, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $31, $20, $32, $20, $33, $20, $34, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardPointPipsTilemap:
	; $4c16, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardScoreTilemap:
	; $4c9b, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardHighScoreTilemap:
	; $4cfd, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardMatchAttrmap:
	; $4d5f, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardLessonAttrmap:
	; $4de4, 95 bytes (tilemap:19)
	tilemap_begin 19, 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 4
	tilemap_end
ScoreboardDrillAttrmap:
	; $4e43, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardPointPipsAttrmap:
	; $4ec8, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardScoreAttrmap:
	; $4f4d, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardHighScoreAttrmap:
	; $4faf, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardMatchTilemapDesc:
	; $5011, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardMatchTilemap, ScoreboardMatchAttrmap
ScoreboardLessonTilemapDesc:
	; $5017, 6 bytes (rect_pair)
	rect_pair 5, 19, ScoreboardLessonTilemap, ScoreboardLessonAttrmap
ScoreboardDrillTilemapDesc:
	; $501d, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardDrillTilemap, ScoreboardDrillAttrmap
ScoreboardPointPipsTilemapDesc:
	; $5023, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardPointPipsTilemap, ScoreboardPointPipsAttrmap
ScoreboardScoreTilemapDesc:
	; $5029, 6 bytes (rect_pair)
	rect_pair 7, 14, ScoreboardScoreTilemap, ScoreboardScoreAttrmap
ScoreboardHighScoreTilemapDesc:
	; $502f, 6 bytes (rect_pair)
	rect_pair 7, 14, ScoreboardHighScoreTilemap, ScoreboardHighScoreAttrmap
ScoreboardTilemapPointers:
	; $5035, 16 bytes (records:2)
	dw ScoreboardMatchTilemapDesc ; record 0
	dw ScoreboardMatchTilemapDesc ; record 1
	dw ScoreboardMatchTilemapDesc ; record 2
	dw ScoreboardLessonTilemapDesc ; record 3
	dw ScoreboardDrillTilemapDesc ; record 4
	dw ScoreboardPointPipsTilemapDesc ; record 5
	dw ScoreboardScoreTilemapDesc ; record 6
	dw ScoreboardHighScoreTilemapDesc ; record 7
CopyTextRectPair:
	push de ; $5045
	push hl ; $5046
	push hl ; $5047
	call GetShadowTilemapAddr ; $5048
	pop hl ; $504b
	ld a, [hl+] ; $504c
	ld c, a ; $504d
	ld a, [hl+] ; $504e
	ld b, a ; $504f
	ld a, [hl+] ; $5050
	ld h, [hl] ; $5051
	ld l, a ; $5052
	call CopyTextRect ; $5053
	pop hl ; $5056
	pop de ; $5057
	push hl ; $5058
	call GetShadowAttrmapAddr ; $5059
	pop hl ; $505c
	ld a, [hl+] ; $505d
	ld c, a ; $505e
	ld a, [hl+] ; $505f
	ld b, a ; $5060
	inc hl ; $5061
	inc hl ; $5062
	ld a, [hl+] ; $5063
	ld h, [hl] ; $5064
	ld l, a ; $5065
	call CopyTextRect ; $5066
	ret ; $5069
DrawScoreboardSprites:
	ld a, [wScoreboardOrigin + 1] ; $506a
	ld h, a ; $506d
	ld a, [wScoreboardOrigin] ; $506e
	ld l, a ; $5071
	add hl, hl ; $5072
	add hl, hl ; $5073
	add hl, hl ; $5074
	ld e, l ; $5075
	ld d, h ; $5076
	push de ; $5077
	call AdjustSpriteCoordsForScroll ; $5078
	ld a, [wScoreboardLayout] ; $507b
	add a ; $507e
	ld_hl_indexed ScoreboardSpriteTemplatePointers ; $507f
	ld a, [hl+] ; $5086
	ld h, [hl] ; $5087
	ld l, a ; $5088
	ld_oam bc, 0, $00 ; $5089
	call QueueSpriteTemplate ; $508c
	pop de ; $508f
	ld a, [wScoreboardLayout] ; $5090
	cp SCOREBOARD_SCORE ; $5093
	jr z, DrawScoreboardSprites.adjustSpriteCoordsForScroll ; $5095
	cp SCOREBOARD_HIGH_SCORE ; $5097
	jr z, DrawScoreboardSprites.adjustSpriteCoordsForScroll ; $5099
	ret ; $509b
ScoreboardSpriteTemplatePointers:
	; $509c, 16 bytes (records:2)
	dw ScoreboardSinglesTemplate ; record 0
	dw ScoreboardThreeCharsTemplate ; record 1
	dw ScoreboardDoublesTemplate ; record 2
	dw ScoreboardLessonTemplate ; record 3
	dw ScoreboardDrillTemplate ; record 4
	dw ScoreboardPointPipsTemplate ; record 5
	dw ScoreboardScoreTemplate ; record 6
	dw ScoreboardScoreTemplate ; record 7
DrawScoreboardSprites.adjustSpriteCoordsForScroll:
	ld hl, $4c0c ; $50ac
	add hl, de ; $50af
	ld e, l ; $50b0
	ld d, h ; $50b1
	push de ; $50b2
	call AdjustSpriteCoordsForScroll ; $50b3
	ld hl, wMinigamesCurrentScore ; $50b6
	ld a, [hl+] ; $50b9
	ld h, [hl] ; $50ba
	ld l, a ; $50bb
	ld b, $01 ; $50bc
	ld a, $04 ; $50be
	farcall DrawNumberWithSprites ; $50c0
	pop de ; $50c3
	ld a, e ; $50c4
	add $18 ; $50c5
	ld e, a ; $50c7
	call AdjustSpriteCoordsForScroll ; $50c8
	ld a, [wMinigameHighScoreMode] ; $50cb
	and a ; $50ce
	ld hl, wMinigameHighScore ; $50cf
	jr nz, DrawScoreboardSprites.read ; $50d2
	ld hl, wMinigamesTargetScore ; $50d4
DrawScoreboardSprites.read:
	ld a, [hl+] ; $50d7
	ld h, [hl] ; $50d8
	ld l, a ; $50d9
	ld b, $02 ; $50da
	ld a, $04 ; $50dc
	farcall DrawNumberWithSprites ; $50de
	ret ; $50e1
ScoreboardSinglesTemplate:
	; $50e2, 65 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $18, $08, $05
	oam_sprite $30, $20, $0a, $05
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
ScoreboardThreeCharsTemplate:
	; $5123, 73 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $10, $08, $05
	oam_sprite $30, $18, $0a, $05
	oam_sprite $30, $20, $18, $07
	oam_sprite $30, $28, $1a, $07
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
ScoreboardDoublesTemplate:
	; $516c, 81 bytes (sprite_template)
	oam_sprite $20, $10, $00, $04
	oam_sprite $20, $18, $02, $04
	oam_sprite $20, $20, $10, $06
	oam_sprite $20, $28, $12, $06
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $10, $08, $05
	oam_sprite $30, $18, $0a, $05
	oam_sprite $30, $20, $18, $07
	oam_sprite $30, $28, $1a, $07
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
ScoreboardDrillTemplate:
	; $51bd, 33 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $18, $08, $05
	oam_sprite $30, $20, $0a, $05
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
ScoreboardPointPipsTemplate:
	; $51de, 33 bytes (sprite_template)
	oam_sprite $20, $0e, $00, $04
	oam_sprite $20, $16, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $0e, $08, $05
	oam_sprite $30, $16, $0a, $05
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
ScoreboardLessonTemplate:
	; $51ff, 17 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite_end
ScoreboardScoreTemplate:
	; $5210, 9 bytes (sprite_template)
	oam_sprite $18, $14, $00, $04
	oam_sprite $18, $1c, $02, $04
	oam_sprite_end
