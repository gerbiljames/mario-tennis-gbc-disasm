DecodeN64CharTrophyCounts:
	push af ; $4e97
	push bc ; $4e98
	push de ; $4e99
	push hl ; $4e9a
	ld a, [hl] ; $4e9b
	and $03 ; $4e9c
	ld b, a ; $4e9e
	call FillTrophyCountCells ; $4e9f
	inc de ; $4ea2
	inc de ; $4ea3
	inc de ; $4ea4
	ld a, [hl] ; $4ea5
	and $30 ; $4ea6
	swap a ; $4ea8
	ld b, a ; $4eaa
	call FillTrophyCountCells ; $4eab
	inc de ; $4eae
	inc de ; $4eaf
	inc de ; $4eb0
	ld a, [hl] ; $4eb1
	and $0c ; $4eb2
	srl a ; $4eb4
	srl a ; $4eb6
	ld b, a ; $4eb8
	call FillTrophyCountCells ; $4eb9
	inc de ; $4ebc
	inc de ; $4ebd
	inc de ; $4ebe
	ld a, [hl] ; $4ebf
	and $c0 ; $4ec0
	swap a ; $4ec2
	srl a ; $4ec4
	srl a ; $4ec6
	ld b, a ; $4ec8
	call FillTrophyCountCells ; $4ec9
	pop hl ; $4ecc
	pop de ; $4ecd
	pop bc ; $4ece
	pop af ; $4ecf
	ret ; $4ed0
FillTrophyCountCells:
	push de ; $4ed1
	push bc ; $4ed2
.cellLoop:
	ld a, b ; $4ed3
	or a ; $4ed4
	jr z, .done ; $4ed5
	ld a, $01 ; $4ed7
	ld [de], a ; $4ed9
	inc de ; $4eda
	ld a, b ; $4edb
	dec a ; $4edc
	ld b, a ; $4edd
	jr .cellLoop ; $4ede
.done:
	pop bc ; $4ee0
	pop de ; $4ee1
	ret ; $4ee2
CheckN64TnmtSecondPage:
	ld hl, wN64TnmtTrophyCells + 2 ; $4ee3
	ld c, $00 ; $4ee6
	ld de, $000c ; $4ee8
.scanCol2Full:
	ld a, [hl] ; $4eeb
	or a ; $4eec
	jr z, .checkOtherColumn ; $4eed
	add hl, de ; $4eef
	ld a, c ; $4ef0
	inc a ; $4ef1
	ld c, a ; $4ef2
	cp $0e ; $4ef3
	jr nz, .scanCol2Full ; $4ef5
	ld hl, wN64TnmtTrophyCells + 5 ; $4ef7
	ld c, $00 ; $4efa
	ld de, $000c ; $4efc
.scanCol5Any:
	ld a, [hl] ; $4eff
	or a ; $4f00
	jr nz, .returnOne ; $4f01
	add hl, de ; $4f03
	ld a, c ; $4f04
	inc a ; $4f05
	ld c, a ; $4f06
	cp $10 ; $4f07
	jr nz, .scanCol5Any ; $4f09
.checkOtherColumn:
	ld hl, wN64TnmtTrophyCells + 5 ; $4f0b
	ld c, $00 ; $4f0e
	ld de, $000c ; $4f10
.scanCol5Full:
	ld a, [hl] ; $4f13
	or a ; $4f14
	jr z, .returnZero ; $4f15
	add hl, de ; $4f17
	ld a, c ; $4f18
	inc a ; $4f19
	ld c, a ; $4f1a
	cp $0e ; $4f1b
	jr nz, .scanCol5Full ; $4f1d
	ld hl, wN64TnmtTrophyCells + 2 ; $4f1f
	ld c, $00 ; $4f22
	ld de, $000c ; $4f24
.scanCol2Any:
	ld a, [hl] ; $4f27
	or a ; $4f28
	jr nz, .returnOne ; $4f29
	add hl, de ; $4f2b
	ld a, c ; $4f2c
	inc a ; $4f2d
	ld c, a ; $4f2e
	cp $10 ; $4f2f
	jr nz, .scanCol2Any ; $4f31
.returnOne:
	ld a, $01 ; $4f33
	ret ; $4f35
.returnZero:
	xor a ; $4f36
	ret ; $4f37
RedrawN64TnmtDataWindow:
	call DrawN64TnmtRowIcons ; $4f38
	call DrawN64TnmtPageLabels ; $4f3b
	call DrawN64TnmtTrophyRows ; $4f3e
	call FlushN64TnmtWindowToVram ; $4f41
	ret ; $4f44
DrawN64TnmtRowIcons:
	push af ; $4f45
	push bc ; $4f46
	push de ; $4f47
	push hl ; $4f48
	push_wram_bank WRAM_SCREEN ; $4f49
	ld hl, wN64TnmtRowChars ; $4f52
	ld a, [wDataScreenScrollRow] ; $4f55
	add_hl_a ; $4f58
	ld d, h ; $4f5d
	ld e, l ; $4f5e
	ld c, $00 ; $4f5f
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH + 2 ; $4f61
.loop:
	ld a, [de] ; $4f64
	inc de ; $4f65
	ld b, a ; $4f66
	call DrawChartCharIcon ; $4f67
	push de ; $4f6a
	ld de, $0040 ; $4f6b
	add hl, de ; $4f6e
	pop de ; $4f6f
	ld a, c ; $4f70
	inc a ; $4f71
	ld c, a ; $4f72
	cp $05 ; $4f73
	jr nz, .loop ; $4f75
	pop_wram_bank ; $4f77
	pop hl ; $4f7c
	pop de ; $4f7d
	pop bc ; $4f7e
	pop af ; $4f7f
	ret ; $4f80
DrawN64TnmtPageLabels:
	push_wram_bank WRAM_SCREEN ; $4f81
	ld a, [wDataScreenPage] ; $4f8a
	or a ; $4f8d
	jr nz, .page1 ; $4f8e
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4f90
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 5 ; $4f93
	rect_size $06, $02 ; $4f96
	farcall CopyTilemapRect ; $4f9a
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4f9d
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 12 ; $4fa0
	rect_size $06, $02 ; $4fa3
	farcall CopyTilemapRect ; $4fa7
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH ; $4faa
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 5 ; $4fad
	rect_size $06, $02 ; $4fb0
	farcall CopyTilemapRect ; $4fb4
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH ; $4fb7
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 12 ; $4fba
	rect_size $06, $02 ; $4fbd
	farcall CopyTilemapRect ; $4fc1
	jr .restore ; $4fc4
.page1:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 6 ; $4fc6
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 5 ; $4fc9
	rect_size $06, $02 ; $4fcc
	farcall CopyTilemapRect ; $4fd0
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 6 ; $4fd3
	ld de, wShadowTilemap + 5 * TILEMAP_WIDTH + 12 ; $4fd6
	rect_size $06, $02 ; $4fd9
	farcall CopyTilemapRect ; $4fdd
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH + 6 ; $4fe0
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 5 ; $4fe3
	rect_size $06, $02 ; $4fe6
	farcall CopyTilemapRect ; $4fea
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH + 6 ; $4fed
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 12 ; $4ff0
	rect_size $06, $02 ; $4ff3
	farcall CopyTilemapRect ; $4ff7
.restore:
	pop_wram_bank ; $4ffa
	ret ; $4fff
DrawN64TnmtTrophyRows:
	wram_bank WRAM_SCREEN ; $5000
	ld a, [wDataScreenScrollRow] ; $5006
	add a ; $5009
	ld b, a ; $500a
	add a ; $500b
	add b ; $500c
	add a ; $500d
	ld hl, wN64TnmtTrophyCells ; $500e
	add_hl_a ; $5011
	ld a, [wDataScreenPage] ; $5016
	or a ; $5019
	jr z, .drawN64TnmtTrophyRow ; $501a
	ld a, $06 ; $501c
	add l ; $501e
	ld l, a ; $501f
	jr nc, .drawN64TnmtTrophyRow ; $5020
	inc h ; $5022
.drawN64TnmtTrophyRow:
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 5 ; $5023
	ld c, $00 ; $5026
.loop:
	call DrawN64TnmtTrophyRow ; $5028
	push hl ; $502b
	ld hl, $0040 ; $502c
	add hl, de ; $502f
	ld d, h ; $5030
	ld e, l ; $5031
	pop hl ; $5032
	ld a, $0c ; $5033
	add_hl_a ; $5035
	ld a, c ; $503a
	inc a ; $503b
	ld c, a ; $503c
	cp $05 ; $503d
	jr nz, .loop ; $503f
	ret ; $5041
DrawN64TnmtTrophyRow:
	push af ; $5042
	push bc ; $5043
	push de ; $5044
	push hl ; $5045
	ld c, $00 ; $5046
.leftCellLoop:
	ld a, [hl+] ; $5048
	or a ; $5049
	jr z, .drawEmptyLeftCell ; $504a
	call DrawWonTrophyIcon ; $504c
	jr .nextLeftCell ; $504f
.drawEmptyLeftCell:
	call DrawEmptyTrophyCell ; $5051
.nextLeftCell:
	inc de ; $5054
	inc de ; $5055
	ld a, c ; $5056
	inc a ; $5057
	ld c, a ; $5058
	cp $03 ; $5059
	jr nz, .leftCellLoop ; $505b
	inc de ; $505d
	ld c, $00 ; $505e
.rightCellLoop:
	ld a, [hl+] ; $5060
	or a ; $5061
	jr z, .drawEmptyRightCell ; $5062
	call DrawWonTrophyIcon ; $5064
	jr .nextRightCell ; $5067
.drawEmptyRightCell:
	call DrawEmptyTrophyCell ; $5069
.nextRightCell:
	inc de ; $506c
	inc de ; $506d
	ld a, c ; $506e
	inc a ; $506f
	ld c, a ; $5070
	cp $03 ; $5071
	jr nz, .rightCellLoop ; $5073
	pop hl ; $5075
	pop de ; $5076
	pop bc ; $5077
	pop af ; $5078
	ret ; $5079
DrawEmptyTrophyCell:
	push af ; $507a
	push bc ; $507b
	push de ; $507c
	push hl ; $507d
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 12 ; $507e
	rect_size $02, $02 ; $5081
	farcall CopyTilemapRect ; $5085
	pop hl ; $5088
	pop de ; $5089
	pop bc ; $508a
	pop af ; $508b
	ret ; $508c
FlushN64TnmtWindowToVram:
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $508d
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $5090
	ld c, 4 * TILEMAP_WIDTH / 16 ; $5093
	call QueueVRAMCopy ; $5095
	ld hl, wShadowAttrmap + 5 * TILEMAP_WIDTH ; $5098
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH + VRAM_BANK1 ; $509b
	ld c, 4 * TILEMAP_WIDTH / 16 ; $509e
	call QueueVRAMCopy ; $50a0
	call AdvanceFrame ; $50a3
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $50a6
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $50a9
	ld c, 4 * TILEMAP_WIDTH / 16 ; $50ac
	call QueueVRAMCopy ; $50ae
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $50b1
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $50b4
	ld c, 4 * TILEMAP_WIDTH / 16 ; $50b7
	call QueueVRAMCopy ; $50b9
	call AdvanceFrame ; $50bc
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $50bf
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $50c2
	ld c, 4 * TILEMAP_WIDTH / 16 ; $50c5
	call QueueVRAMCopy ; $50c7
	ld hl, wShadowAttrmap + 13 * TILEMAP_WIDTH ; $50ca
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH + VRAM_BANK1 ; $50cd
	ld c, 4 * TILEMAP_WIDTH / 16 ; $50d0
	call QueueVRAMCopy ; $50d2
	ret ; $50d5
N64TnmtScrollArrowsTask:
	push_wram_bank WRAM_SCREEN ; $50d6
	ld a, [wN64TnmtHasSecondPage] ; $50df
	or a ; $50e2
	jr z, .applyCursorBounceX ; $50e3
	ld a, [wDataScreenPage] ; $50e5
	or a ; $50e8
	jr nz, .applyCursorBounceX ; $50e9
	ld_xy de, $93, $2f ; $50eb
	ld c, BOBDIR_POS ; $50ee
	call ApplyCursorBounceX ; $50f0
	ld b, $08 ; $50f3
	ld c, $00 ; $50f5
	ld h, $00 ; $50f7
	farcall QueueStackedSpritePair ; $50f9
.applyCursorBounceX:
	ld a, [wDataScreenPage] ; $50fc
	or a ; $50ff
	jr z, .checkUpArrow ; $5100
	ld_xy de, $20, $2f ; $5102
	ld c, BOBDIR_NEG ; $5105
	call ApplyCursorBounceX ; $5107
	ld b, $08 ; $510a
	ld c, $00 ; $510c
	ld h, $01 ; $510e
	farcall QueueStackedSpritePair ; $5110
.checkUpArrow:
	ld a, [wDataScreenScrollRow] ; $5113
	or a ; $5116
	jr z, .checkDownArrow ; $5117
	ld_xy de, $0c, $32 ; $5119
	ld c, BOBDIR_POS ; $511c
	call ApplyCursorBounceY ; $511e
	ld b, $08 ; $5121
	ld c, $00 ; $5123
	ld h, $02 ; $5125
	farcall QueueStackedSpritePair ; $5127
.checkDownArrow:
	ld a, [wDataScreenScrollRow] ; $512a
	cp $0b ; $512d
	jr z, .restore ; $512f
	ld_xy de, $0c, $88 ; $5131
	ld c, BOBDIR_NEG ; $5134
	call ApplyCursorBounceY ; $5136
	ld b, $08 ; $5139
	ld c, $00 ; $513b
	ld h, $03 ; $513d
	farcall QueueStackedSpritePair ; $513f
.restore:
	pop_wram_bank ; $5142
	ret ; $5147
RunN64RingShotData:
	call DisableLCDSafely ; $5148
	sound BGM_STATUS_SCREEN ; $514b
	call BuildN64RingShotScreen ; $514d
	xor a ; $5150
	ld [wAnimatedTileSet], a ; $5151
	frame_task UpdateAnimatedTilesTask_3b ; $5154
	frame_task RingShotScrollArrowsTask ; $515c
	frame_task RingShotScoreDrawTask ; $5164
	call EnableLCD ; $516c
	script_fade_in 16 ; $516f
	call WaitFadeEnd ; $5174
	wram_bank WRAM_SCREEN ; $5177
.loop:
	ldh a, [hInputRepeat] ; $517d
	ld [wMenuInputPressed], a ; $517f
	call ScrollRingShotCursor ; $5182
	call AdvanceFrame ; $5185
	ld a, [wMenuInputPressed] ; $5188
	bit PADB_A, a ; $518b
	jr nz, .playSelectSfx ; $518d
	bit PADB_B, a ; $518f
	jr nz, .playCancelSfx ; $5191
	jr .loop ; $5193
.playSelectSfx:
	sound SFX_MENU_SELECT ; $5195
	script_fade_out 16 ; $5197
	call WaitFadeEnd ; $519c
	call ClearFrameTasks ; $519f
	ret ; $51a2
.playCancelSfx:
	sound SFX_MENU_CANCEL ; $51a3
	script_fade_out 16 ; $51a5
	call WaitFadeEnd ; $51aa
	call ClearFrameTasks ; $51ad
	ld a, $ff ; $51b0
	ret ; $51b2
BuildN64RingShotScreen:
	xor a ; $51b3
	ld [wMenuCursorX], a ; $51b4
	ld [wMenuCursorY], a ; $51b7
	ld c, SCREENASSET_N64RingShotPoints ; $51ba
	farcall LoadScreenAssetRecord ; $51bc
	wram_bank WRAM_SCREEN ; $51bf
	call LoadN64RingShotRecords ; $51c5
	wram_bank WRAM_SCREEN ; $51c8
	ld de, vTiles1 tile $2c + VRAM_BANK1 ; $51ce
	call LoadChartCharIconTiles ; $51d1
	ld de, vTiles0 + VRAM_BANK1 ; $51d4
	farcall LoadMenuArrowSpriteTiles ; $51d7
	ld b, $08 ; $51da
	ld c, $0f ; $51dc
	farcall LoadIndexedPalette ; $51de
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $51e1
	ld b, $09 ; $51e4
	ld c, $00 ; $51e6
	farcall InitNumberSpriteGfx ; $51e8
	ld a, $09 ; $51eb
	ld [wDigitSpriteAttr], a ; $51ed
	ld a, $10 ; $51f0
	ld [wDigitSpriteTileBase], a ; $51f2
	call DrawRingShotRowIcons ; $51f5
	call DrawRingShotModeTab ; $51f8
	call DrawRingShotClearMarks ; $51fb
	farcall QueueWram3MapToVRAM ; $51fe
	ret ; $5201
