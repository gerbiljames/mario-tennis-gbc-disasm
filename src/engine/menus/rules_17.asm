ReturnDownLineBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6e00
	inc a ; $6e03
	ld [wBriefingAnimTimer], a ; $6e04
	cp $78 ; $6e07
	jp nc, ReturnDownLineBriefing_AdvanceAnim ; $6e09
	ret ; $6e0c
ReturnDownLineBriefing_AdvanceAnim:
	xor a ; $6e0d
	ld [wBriefingAnimTimer], a ; $6e0e
	ld a, [wBriefingAnimStep] ; $6e11
	inc a ; $6e14
	and $03 ; $6e15
	ld [wBriefingAnimStep], a ; $6e17
	sla a ; $6e1a
	sla a ; $6e1c
	ld c, a ; $6e1e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnimTable ; $6e1f
	ld a, [hl] ; $6e26
	inc hl ; $6e27
	inc hl ; $6e28
	ld b, [hl] ; $6e29
	ld a, a ; $6e2a
	ld [wBriefingPlayerX], a ; $6e2b
	ld a, b ; $6e2e
	ld [wBriefingPlayerY], a ; $6e2f
	ld a, c ; $6e32
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable ; $6e33
	ld a, [hl] ; $6e3a
	inc hl ; $6e3b
	inc hl ; $6e3c
	ld b, [hl] ; $6e3d
	ld a, a ; $6e3e
	ld [wBriefingOpponentX], a ; $6e3f
	ld a, b ; $6e42
	ld [wBriefingOpponentY], a ; $6e43
	ld a, c ; $6e46
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_BracketPosTable ; $6e47
	ld a, [hl] ; $6e4e
	inc hl ; $6e4f
	inc hl ; $6e50
	ld b, [hl] ; $6e51
	ld a, a ; $6e52
	ld [wBriefingBracketX], a ; $6e53
	ld a, b ; $6e56
	ld [wBriefingBracketY], a ; $6e57
	ld a, c ; $6e5a
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_BallPosTable ; $6e5b
	ld a, [hl] ; $6e62
	inc hl ; $6e63
	inc hl ; $6e64
	ld b, [hl] ; $6e65
	ld a, a ; $6e66
	ld [wBriefingBallX], a ; $6e67
	ld a, b ; $6e6a
	ld [wBriefingBallY], a ; $6e6b
	ld a, [wBriefingAnimStep] ; $6e6e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6e71
	ld a, [hl] ; $6e78
	ld [wBriefingHMarkerUnflipped], a ; $6e79
	ld a, c ; $6e7c
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable ; $6e7d
	ld a, [hl] ; $6e84
	inc hl ; $6e85
	inc hl ; $6e86
	ld b, [hl] ; $6e87
	ld a, a ; $6e88
	ld [wBriefingHMarkerX], a ; $6e89
	ld a, b ; $6e8c
	ld [wBriefingHMarkerY], a ; $6e8d
	ld a, [wBriefingAnimStep] ; $6e90
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable ; $6e93
	ld a, [hl] ; $6e9a
	ld [wBriefingVMarkerUpright], a ; $6e9b
	ld a, c ; $6e9e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable ; $6e9f
	ld a, [hl] ; $6ea6
	inc hl ; $6ea7
	inc hl ; $6ea8
	ld b, [hl] ; $6ea9
	ld a, a ; $6eaa
	ld [wBriefingVMarkerX], a ; $6eab
	ld a, b ; $6eae
	ld [wBriefingVMarkerY], a ; $6eaf
	ret ; $6eb2
ReturnDownLineBriefing_AdvanceAnimTable:
	; $6eb3, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6ec3, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_BallPosTable.asm" ; $6ed3, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6ee3, 4 bytes
ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6ee7, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable.bin" ; $6ef7, 4 bytes
ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable.bin" ; $6efb, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_BracketPosTable.bin" ; $6f0b, 16 bytes
ShowRulesScreen:
	push af ; $6f1b
	wram_bank WRAM_SCREEN ; $6f1c
	pop af ; $6f22
	ld [wRulesPageListId], a ; $6f23
	ld a, [wMinigameLevel] ; $6f26
	ld [wRulesMinigameLevel], a ; $6f29
	xor a ; $6f2c
	ld [wRulesExitCode], a ; $6f2d
	ld [wRulesAnimEnabled], a ; $6f30
	ld [wRulesAnimCounter], a ; $6f33
	ld [wRulesIsMinigame], a ; $6f36
	ld [wRulesScreenAnimFrame], a ; $6f39
	ld c, $20 ; $6f3c
	call BeginFadeOut ; $6f3e
	call WaitFadeEnd ; $6f41
	call DisableLCDSafely ; $6f44
	call LoadRulesScreen ; $6f47
	ld a, $01 ; $6f4a
	ld [wAnimatedTileSet], a ; $6f4c
	ld a, $03 ; $6f4f
	ld [wAnimatedTilePeriod], a ; $6f51
	ld a, $01 ; $6f54
	ld hl, UpdateAnimatedTilesTask_17 ; $6f56
	call RegisterFrameTask ; $6f59
	call EnableLCD ; $6f5c
	script_fade_in $20 ; $6f5f
	call WaitFadeEnd ; $6f64
	wram_bank WRAM_SCREEN ; $6f67
	ld a, $01 ; $6f6d
	ld hl, AdvanceRulesScreenAnimFrame ; $6f6f
	call RegisterFrameTask ; $6f72
	ld a, $01 ; $6f75
	ld [wRulesAnimEnabled], a ; $6f77
	xor a ; $6f7a
	ld [wRulesAnimCounter], a ; $6f7b
	call RunMinigameRulesPages ; $6f7e
	ld c, $20 ; $6f81
	call BeginFadeOut ; $6f83
	call WaitFadeEnd ; $6f86
	call ClearFrameTasks ; $6f89
	ld a, [wRulesExitCode] ; $6f8c
	ret ; $6f8f
	ret ; $6f90
RunMinigameRulesPages:
	push_wram_bank WRAM_SCREEN ; $6f91
	ld a, [wSelectedMinigame] ; $6f9a
	inc a ; $6f9d
	inc a ; $6f9e
	farcall ReadMinigameRecord ; $6f9f
	wram_bank WRAM_SOUND ; $6fa2
	ld hl, wMinigameRecordValue ; $6fa8
	ld a, [hl+] ; $6fab
	ld h, [hl] ; $6fac
	ld l, a ; $6fad
	wram_bank WRAM_SCREEN ; $6fae
	farcall PushTextArgNumber ; $6fb4
	ld a, [wSelectedMinigame] ; $6fb7
	ld hl, MinigameRulesTextIdBases_17 ; $6fba
	add a ; $6fbd
	add l ; $6fbe
	ld l, a ; $6fbf
	jr nc, .read ; $6fc0
	inc h ; $6fc2
.read:
	ld a, [hl+] ; $6fc3
	ld d, [hl] ; $6fc4
	ld e, a ; $6fc5
	ld hl, wRulesPageTextIdBase ; $6fc6
	ld a, e ; $6fc9
	ld [hl+], a ; $6fca
	ld [hl], d ; $6fcb
	ld hl, MinigameRulesPageLists_17 ; $6fcc
	ld a, [wRulesPageListId] ; $6fcf
	call MinigameRulesPageLoop ; $6fd2
	pop_wram_bank ; $6fd5
	ret ; $6fda
MinigameRulesTextIdBases_17:
	; $6fdb, 18 bytes (records:2)
	dw $2cc6 ; record 0
	dw $2cd0 ; record 1
	dw $2cda ; record 2
	dw $2ce2 ; record 3
	dw $2cef ; record 4
	dw $2cf6 ; record 5
	dw $3007 ; record 6
	dw $3017 ; record 7
	dw $3026 ; record 8
MinigameRulesPageLists_17:
	; $6fed, 174 bytes (rules_pages:6)
	rules_pages_stride 6
	rules_pages $00, $01, $02 ; list 0
	rules_pages $03, $04, $05 ; list 1
	rules_pages $06, $07, $88 ; list 2
	rules_pages $00, $01, $02 ; list 3
	rules_pages $03, $04, $05 ; list 4
	rules_pages $06, $07, $88 ; list 5
	rules_pages $00, $01 ; list 6
	rules_pages $02, $03 ; list 7
	rules_pages $04, $05, $86 ; list 8
	rules_pages $00, $01, $02, $03 ; list 9
	rules_pages $04, $05, $06, $07 ; list 10
	rules_pages $08, $09, $0a, $8b ; list 11
	rules_pages $00, $01 ; list 12
	rules_pages $02, $03 ; list 13
	rules_pages $04, $85 ; list 14
	rules_pages $00, $01, $02 ; list 15
	rules_pages $03, $04, $05 ; list 16
	rules_pages $06, $07, $88 ; list 17
	rules_pages $00, $01, $02, $03, $04 ; list 18
	rules_pages $05, $06, $07, $08, $09 ; list 19
	rules_pages $0a, $0b, $0c, $0d, $8e ; list 20
	rules_pages $00, $01, $02, $03, $04 ; list 21
	rules_pages $05, $06, $07, $08, $09 ; list 22
	rules_pages $0a, $0b, $0c, $8d ; list 23
	rules_pages $00, $01, $02, $03 ; list 24
	rules_pages $04, $05, $06, $07 ; list 25
	rules_pages $08, $09, $0a, $0b ; list 26
	rules_pages $1b ; list 27
	rules_pages $1c ; list 28
MinigameRulesPageLoop:
	add a ; $709b
	ld b, a ; $709c
	add a ; $709d
	add b ; $709e
	add l ; $709f
	ld l, a ; $70a0
	jr nc, .loop ; $70a1
	inc h ; $70a3
.loop:
	ld a, [hl+] ; $70a4
	cp $ff ; $70a5
	jp z, .playSfx3 ; $70a7
	push hl ; $70aa
	bit 7, a ; $70ab
	jr z, .step ; $70ad
	push af ; $70af
	ld d, a ; $70b0
	wram_bank WRAM_SOUND ; $70b1
	ld hl, wMinigameRecordValue ; $70b7
	ld a, [hl+] ; $70ba
	ld h, [hl] ; $70bb
	ld l, a ; $70bc
	wram_bank WRAM_SCREEN ; $70bd
	ld a, h ; $70c3
	cp $27 ; $70c4
	jr nz, .restore ; $70c6
	ld a, l ; $70c8
	cp $0f ; $70c9
	jr nz, .restore ; $70cb
	pop bc ; $70cd
	ld a, d ; $70ce
	inc a ; $70cf
	jr .step ; $70d0
.restore:
	pop af ; $70d2
.step:
	and $7f ; $70d3
	pop hl ; $70d5
	push hl ; $70d6
	push af ; $70d7
	ld a, [hl] ; $70d8
	cp $ff ; $70d9
	jr z, .prepareRulesPageTilemap ; $70db
	ld a, $01 ; $70dd
	ld hl, DrawRulesNextPageArrow ; $70df
	call RegisterFrameTask ; $70e2
.prepareRulesPageTilemap:
	call PrepareRulesPageTilemap ; $70e5
	ld hl, wRulesPageTextIdBase ; $70e8
	ld a, [hl+] ; $70eb
	ld h, [hl] ; $70ec
	ld l, a ; $70ed
	pop af ; $70ee
	add l ; $70ef
	ld l, a ; $70f0
	jr nc, .prepareGlyphBuffer ; $70f1
	inc h ; $70f3
.prepareGlyphBuffer:
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $70f4
	ld c, $20 ; $70f7
	farcall PrepareGlyphBuffer ; $70f9
	ld c, $10 ; $70fc
	farcall RenderProportionalTextAt ; $70fe
	farcall UploadGlyphBuffer ; $7101
	call QueueRulesPageToVRAM ; $7104
.loopB:
	call AdvanceFrame ; $7107
	ldh a, [hInputRisingEdge] ; $710a
	bit PADB_A, a ; $710c
	jr nz, .playSfx ; $710e
	bit 7, a ; $7110
	jr nz, .playSfx ; $7112
	bit 1, a ; $7114
	jr nz, .playSfx2 ; $7116
	bit 3, a ; $7118
	jr nz, .restore2 ; $711a
	jr .loopB ; $711c
.playSfx:
	sound SFX_MENU_SELECT ; $711e
	ld hl, DrawRulesNextPageArrow ; $7120
	call UnregisterFrameTask ; $7123
	ld hl, RulesScreenTiles ; $7126
	call UnregisterFrameTask ; $7129
	ld a, $01 ; $712c
	ld [wRulesAnimEnabled], a ; $712e
	ld [wRulesIsMinigame], a ; $7131
	xor a ; $7134
	ld [wRulesAnimCounter], a ; $7135
	pop hl ; $7138
	jp .loop ; $7139
.playSfx2:
	sound SFX_MENU_CANCEL ; $713c
	ld hl, DrawRulesNextPageArrow ; $713e
	call UnregisterFrameTask ; $7141
	ld hl, RulesScreenTiles ; $7144
	call UnregisterFrameTask ; $7147
	ld a, $ff ; $714a
	ld [wRulesExitCode], a ; $714c
	pop hl ; $714f
.playSfx3:
	sound SFX_MENU_DECIDE ; $7150
	ret ; $7152
.restore2:
	pop hl ; $7153
	sound SFX_MENU_DECIDE ; $7154
	ret ; $7156
LoadRulesScreen:
	call LoadRulesBorderAnimTiles ; $7157
	farcall LoadMenuFontGfx ; $715a
	ld c, SCREENASSET_RulesScreen ; $715d
	farcall LoadScreenAssetRecord ; $715f
	ldh a, [hWramBank] ; $7162
	push af ; $7164
	farcall InitTextWindows ; $7165
	wram_bank WRAM_TEXT ; $7168
	ld a, $03 ; $716e
	ld [wShadowTilemapBank], a ; $7170
	ld a, $00 ; $7173
	ld [wWindowTileAttr], a ; $7175
	pop_wram_bank ; $7178
	farcall PrepareGlyphBuffer ; $717d
	call ClearRulesScreenTextArea ; $7180
	ld hl, RulesScreenPalette ; $7183
	ld_obj_pals de, 1, 2 ; $7186
	call LoadPalettesImmediate ; $7189
	ld de, vTiles0 + VRAM_BANK1 ; $718c
	farcall LoadMenuArrowSpriteTiles ; $718f
	ld b, $08 ; $7192
	ld c, $0f ; $7194
	farcall LoadIndexedPalette ; $7196
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $7199
	ld c, SharedMenuGfx17_SIZE / 16 ; $719b
	ld de, vTiles2 ; $719d
	farcall LoadCompressedTileBlock ; $71a0
	ld a, $03 ; $71a3
	ld [wShadowTilemapBank], a ; $71a5
	ld hl, wShadowTilemapPtr ; $71a8
	ld de, wDecompBuffer ; $71ab
	ld a, e ; $71ae
	ld [hl+], a ; $71af
	ld [hl], d ; $71b0
	ld a, $01 ; $71b1
	ld hl, DrawRulesScreenCharacters ; $71b3
	call RegisterFrameTask ; $71b6
	farcall QueueWram3MapToVRAM ; $71b9
	ret ; $71bc
ClearRulesScreenTextArea:
	push_wram_bank WRAM_SCREEN ; $71bd
	ld de, wShadowAttrmap + 3 * TILEMAP_WIDTH + 2 ; $71c6
	ld b, $10 ; $71c9
	ld c, $0e ; $71cb
	ld h, $00 ; $71cd
	farcall FillTilemapRect ; $71cf
	call ClearRulesPageRows ; $71d2
	pop_wram_bank ; $71d5
	ret ; $71da
ClearRulesPageRows:
	push_wram_bank WRAM_SCREEN ; $71db
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 2 ; $71e4
	ld b, $10 ; $71e7
	ld c, $01 ; $71e9
	ld h, $03 ; $71eb
	farcall FillTilemapRect ; $71ed
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $71f0
	ld b, $10 ; $71f3
	ld c, $0d ; $71f5
	ld h, $20 ; $71f7
	farcall FillTilemapRect ; $71f9
	pop_wram_bank ; $71fc
	ret ; $7201
PrepareRulesPageTilemap:
	push_wram_bank WRAM_SCREEN ; $7202
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 2 ; $720b
	ld b, $10 ; $720e
	ld c, $01 ; $7210
	ld h, $03 ; $7212
	farcall FillTilemapRect ; $7214
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $7217
	ld b, $10 ; $721a
	ld c, $0d ; $721c
	ld h, $20 ; $721e
	farcall FillTilemapRect ; $7220
	ld a, [wRulesIsMinigame] ; $7223
	or a ; $7226
	jr nz, .nonZero ; $7227
	ld a, [wRulesMinigameLevel] ; $7229
	add $03 ; $722c
	ld h, a ; $722e
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $722f
	ld b, $10 ; $7232
	ld c, $01 ; $7234
	farcall FillTilemapRect ; $7236
	jr .restore ; $7239
.nonZero:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $723b
	ld b, $10 ; $723e
	ld c, $01 ; $7240
	ld h, $00 ; $7242
	farcall FillTilemapRect ; $7244
.restore:
	pop_wram_bank ; $7247
	ret ; $724c
QueueRulesPageToVRAM:
	ld a, [wRulesIsMinigame] ; $724d
	or a ; $7250
	jr nz, .nonZero ; $7251
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $7253
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $7256
	ld c, $0a ; $7259
	call QueueVRAMCopy ; $725b
	jr .queueVRAMCopy ; $725e
.nonZero:
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $7260
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $7263
	ld c, $0a ; $7266
	call QueueVRAMCopy ; $7268
.queueVRAMCopy:
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $726b
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $726e
	ld c, $02 ; $7271
	call QueueVRAMCopy ; $7273
	call AdvanceFrame ; $7276
	ld hl, wShadowTilemap + 8 * TILEMAP_WIDTH ; $7279
	ld de, vBGMap0 + 8 * TILEMAP_WIDTH ; $727c
	ld c, $0a ; $727f
	call QueueVRAMCopy ; $7281
	call AdvanceFrame ; $7284
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $7287
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $728a
	ld c, $08 ; $728d
	call QueueVRAMCopy ; $728f
	ret ; $7292
LoadRulesBorderAnimTiles:
	wram_bank WRAM_STAGING ; $7293
	ld hl, RulesBorderAnimTiles0 ; $7299
	ld de, wDecompBuffer ; $729c
	call DecompressData ; $729f
	ld hl, wDecompBuffer ; $72a2
	ld de, vTiles0 ; $72a5
	ld bc, $0012 ; $72a8
	call QueueVRAMCopy ; $72ab
	ld hl, wDecompBuffer ; $72ae
	ld de, vTiles0 + $24 * TILE_SIZE ; $72b1
	ld bc, $0012 ; $72b4
	call QueueVRAMCopy ; $72b7
	ld hl, wDecompBuffer ; $72ba
	ld de, vTiles0 + $48 * TILE_SIZE ; $72bd
	ld bc, $0012 ; $72c0
	call QueueVRAMCopy ; $72c3
	ld hl, wDecompBuffer ; $72c6
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $72c9
	ld bc, $0012 ; $72cc
	call QueueVRAMCopy ; $72cf
	ld hl, wDecompBuffer ; $72d2
	ld de, vTiles0 + $34 * TILE_SIZE + VRAM_BANK1 ; $72d5
	ld bc, $0012 ; $72d8
	call QueueVRAMCopy ; $72db
	ld hl, wDecompBuffer ; $72de
	ld de, vTiles0 + $58 * TILE_SIZE + VRAM_BANK1 ; $72e1
	ld bc, $0012 ; $72e4
	call QueueVRAMCopy ; $72e7
	ld hl, RulesBorderAnimTiles1 ; $72ea
	ld de, wDecompBuffer ; $72ed
	call DecompressData ; $72f0
	ld hl, wDecompBuffer ; $72f3
	ld de, vTiles0 + $4a * TILE_SIZE ; $72f6
	ld bc, $0002 ; $72f9
	call QueueVRAMCopy ; $72fc
	ld hl, wDecompBuffer ; $72ff
	ld de, vTiles0 + $12 * TILE_SIZE + VRAM_BANK1 ; $7302
	ld bc, $0002 ; $7305
	call QueueVRAMCopy ; $7308
	ld hl, wDecompBuffer ; $730b
	ld de, vTiles0 + $36 * TILE_SIZE + VRAM_BANK1 ; $730e
	ld bc, $0002 ; $7311
	call QueueVRAMCopy ; $7314
	ld hl, wDecompBuffer ; $7317
	ld de, vTiles0 + $5a * TILE_SIZE + VRAM_BANK1 ; $731a
	ld bc, $0002 ; $731d
	call QueueVRAMCopy ; $7320
	ld hl, RulesBorderAnimTiles2 ; $7323
	ld de, wDecompBuffer ; $7326
	call DecompressData ; $7329
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $732c
	ld de, vTiles0 + $2c * TILE_SIZE ; $732f
	ld bc, $0001 ; $7332
	call QueueVRAMCopy ; $7335
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $7338
	ld de, vTiles0 + $18 * TILE_SIZE + VRAM_BANK1 ; $733b
	ld bc, $0001 ; $733e
	call QueueVRAMCopy ; $7341
	ld hl, wDecompBuffer ; $7344
	ld de, vTiles0 + $3c * TILE_SIZE + VRAM_BANK1 ; $7347
	ld bc, $0001 ; $734a
	call QueueVRAMCopy ; $734d
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $7350
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $7353
	ld bc, $0001 ; $7356
	call QueueVRAMCopy ; $7359
	ld hl, RulesBorderAnimTiles3 ; $735c
	ld de, wDecompBuffer ; $735f
	call DecompressData ; $7362
	ld hl, wDecompBuffer ; $7365
	ld de, vTiles0 + $12 * TILE_SIZE ; $7368
	ld bc, $0012 ; $736b
	call QueueVRAMCopy ; $736e
	ld hl, wDecompBuffer ; $7371
	ld de, vTiles0 + $36 * TILE_SIZE ; $7374
	ld bc, $0012 ; $7377
	call QueueVRAMCopy ; $737a
	ld hl, wDecompBuffer ; $737d
	ld de, vTiles0 + $5a * TILE_SIZE ; $7380
	ld bc, $0012 ; $7383
	call QueueVRAMCopy ; $7386
	ld hl, wDecompBuffer ; $7389
	ld de, vTiles0 + $22 * TILE_SIZE + VRAM_BANK1 ; $738c
	ld bc, $0012 ; $738f
	call QueueVRAMCopy ; $7392
	ld hl, wDecompBuffer ; $7395
	ld de, vTiles0 + $46 * TILE_SIZE + VRAM_BANK1 ; $7398
	ld bc, $0012 ; $739b
	call QueueVRAMCopy ; $739e
	ld hl, wDecompBuffer ; $73a1
	ld de, vTiles0 + $6a * TILE_SIZE + VRAM_BANK1 ; $73a4
	ld bc, $0012 ; $73a7
	call QueueVRAMCopy ; $73aa
	ld hl, RulesBorderAnimTiles4 ; $73ad
	ld de, wDecompBuffer ; $73b0
	call DecompressData ; $73b3
	ld hl, wDecompBuffer ; $73b6
	ld de, vTiles0 + $5c * TILE_SIZE ; $73b9
	ld bc, $0002 ; $73bc
	call QueueVRAMCopy ; $73bf
	ld hl, wDecompBuffer ; $73c2
	ld de, vTiles0 + $24 * TILE_SIZE + VRAM_BANK1 ; $73c5
	ld bc, $0002 ; $73c8
	call QueueVRAMCopy ; $73cb
	ld hl, wDecompBuffer ; $73ce
	ld de, vTiles0 + $48 * TILE_SIZE + VRAM_BANK1 ; $73d1
	ld bc, $0002 ; $73d4
	call QueueVRAMCopy ; $73d7
	ld hl, wDecompBuffer ; $73da
	ld de, vTiles0 + $6c * TILE_SIZE + VRAM_BANK1 ; $73dd
	ld bc, $0002 ; $73e0
	call QueueVRAMCopy ; $73e3
	ld hl, RulesBorderAnimTiles5 ; $73e6
	ld de, wDecompBuffer ; $73e9
	call DecompressData ; $73ec
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $73ef
	ld de, vTiles0 + $3e * TILE_SIZE ; $73f2
	ld bc, $0001 ; $73f5
	call QueueVRAMCopy ; $73f8
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $73fb
	ld de, vTiles0 + $2a * TILE_SIZE + VRAM_BANK1 ; $73fe
	ld bc, $0001 ; $7401
	call QueueVRAMCopy ; $7404
	ld hl, wDecompBuffer ; $7407
	ld de, vTiles0 + $4e * TILE_SIZE + VRAM_BANK1 ; $740a
	ld bc, $0001 ; $740d
	call QueueVRAMCopy ; $7410
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $7413
	ld de, vTiles0 + $72 * TILE_SIZE + VRAM_BANK1 ; $7416
	ld bc, $0001 ; $7419
	call QueueVRAMCopy ; $741c
	ret ; $741f
AdvanceRulesScreenAnimFrame:
	push_wram_bank WRAM_SCREEN ; $7420
	ld a, [wRulesAnimCounter] ; $7429
	inc a ; $742c
	ld [wRulesAnimCounter], a ; $742d
	ld a, [wRulesAnimEnabled] ; $7430
	or a ; $7433
	jr z, .zero ; $7434
	ldh a, [hVBlankCounter] ; $7436
	srl a ; $7438
	srl a ; $743a
	srl a ; $743c
	and $3f ; $743e
	ld hl, RulesScreenAnimFrameTable1 ; $7440
	add l ; $7443
	ld l, a ; $7444
	jr nc, .read ; $7445
	inc h ; $7447
.read:
	ld a, [hl] ; $7448
	ld [wRulesScreenAnimFrame], a ; $7449
	jr .step2 ; $744c
.zero:
	ldh a, [hVBlankCounter] ; $744e
	srl a ; $7450
	srl a ; $7452
	srl a ; $7454
	srl a ; $7456
	and $1f ; $7458
	ld hl, RulesScreenAnimFrameTable ; $745a
	add l ; $745d
	ld l, a ; $745e
	jr nc, .readB ; $745f
	inc h ; $7461
.readB:
	ld a, [hl] ; $7462
	ld [wRulesScreenAnimFrame], a ; $7463
	jr .step2 ; $7466
.step2:
	ld a, [wRulesAnimEnabled] ; $7468
	or a ; $746b
	jr z, .restore ; $746c
	ld a, [wRulesAnimCounter] ; $746e
	cp $ff ; $7471
	jr nz, .restore ; $7473
	xor a ; $7475
	ld [wRulesAnimEnabled], a ; $7476
.restore:
	pop_wram_bank ; $7479
	ret ; $747e
RulesScreenAnimFrameTable:
	; $747f, 32 bytes (records:2)
	dw $0100 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0001 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0100 ; record 7
	dw $0000 ; record 8
	dw $0000 ; record 9
	dw $0000 ; record 10
	dw $0001 ; record 11
	dw $0100 ; record 12
	dw $0000 ; record 13
	dw $0001 ; record 14
	dw $0000 ; record 15
RulesScreenAnimFrameTable1:
	; $749f, 60 bytes (records:2)
	dw $0402 ; record 0
	dw $0404 ; record 1
	dw $0502 ; record 2
	dw $0402 ; record 3
	dw $0202 ; record 4
	dw $0302 ; record 5
	dw $0402 ; record 6
	dw $0402 ; record 7
	dw $0304 ; record 8
	dw $0204 ; record 9
	dw $0204 ; record 10
	dw $0404 ; record 11
	dw $0402 ; record 12
	dw $0402 ; record 13
	dw $0402 ; record 14
	dw $0402 ; record 15
	dw $0402 ; record 16
	dw $0402 ; record 17
	dw $0402 ; record 18
	dw $0202 ; record 19
	dw $0304 ; record 20
	dw $0204 ; record 21
	dw $0204 ; record 22
	dw $0204 ; record 23
	dw $0402 ; record 24
	dw $0402 ; record 25
	dw $0402 ; record 26
	dw $0202 ; record 27
	dw $0302 ; record 28
	dw $0402 ; record 29
DrawRulesScreenCharacters:
	push_wram_bank WRAM_SCREEN ; $74db
	ld a, [wRulesScreenAnimFrame] ; $74e4
	ld hl, RulesScreenCharactersTable0 ; $74e7
	add l ; $74ea
	ld l, a ; $74eb
	jr nc, .read ; $74ec
	inc h ; $74ee
.read:
	ld a, [hl] ; $74ef
	ld c, a ; $74f0
	push bc ; $74f1
	ld a, [wRulesScreenAnimFrame] ; $74f2
	ld hl, RulesScreenCharactersTable1 ; $74f5
	add l ; $74f8
	ld l, a ; $74f9
	jr nc, .readB ; $74fa
	inc h ; $74fc
.readB:
	ld b, [hl] ; $74fd
	ld_xy de, $7e, $68 ; $74fe
	ld hl, DrawRulesScreenCharacters_SpriteTemplate ; $7501
	call QueueSpriteTemplate ; $7504
	pop bc ; $7507
	ld a, $12 ; $7508
	add c ; $750a
	ld c, a ; $750b
	ld a, [wRulesScreenAnimFrame] ; $750c
	ld hl, RulesScreenCharactersTable2 ; $750f
	add l ; $7512
	ld l, a ; $7513
	jr nc, .read2 ; $7514
	inc h ; $7516
.read2:
	ld b, [hl] ; $7517
	ld_xy de, $7e, $68 ; $7518
	ld hl, DrawRulesScreenCharacters_SpriteTemplate ; $751b
	call QueueSpriteTemplate ; $751e
	pop_wram_bank ; $7521
	ret ; $7526
DrawRulesScreenCharacters_SpriteTemplate:
	; $7527, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $30, $08, $04, $00
	oam_sprite $10, $10, $06, $00
	oam_sprite $20, $10, $08, $00
	oam_sprite $30, $10, $0a, $00
	oam_sprite $10, $18, $0c, $00
	oam_sprite $20, $18, $0e, $00
	oam_sprite $30, $18, $10, $00
	oam_sprite_end
RulesScreenCharactersTable0:
	; $754c, 6 bytes (bytes:6)
	db $00, $24, $48, $10, $34, $58 ; 0x00
RulesScreenCharactersTable1:
	; $7552, 6 bytes (bytes:6)
	db $01, $01, $01, $09, $09, $09 ; 0x00
RulesScreenCharactersTable2:
	; $7558, 6 bytes (bytes:6)
	db $02, $02, $02, $0a, $0a, $0a ; 0x00
DrawRulesNextPageArrow:
	ld de, $7888 ; $755e
	ld c, $00 ; $7561
	call ApplySpriteWobbleY_17 ; $7563
	ld b, $08 ; $7566
	ld c, $00 ; $7568
	ld h, $03 ; $756a
	farcall QueueStackedSpritePair ; $756c
	ret ; $756f
RulesScreenTiles:
	INCBIN "data/bank_017/lz_RulesScreenTiles.bin" ; $7570, 512 bytes
RulesScreenTilemap:
	INCBIN "data/bank_017/lz_RulesScreenTilemap.bin" ; $7770, 309 bytes
RulesScreenAttrmap:
	INCBIN "data/bank_017/lz_RulesScreenAttrmap.bin" ; $78a5, 87 bytes
RulesScreenPalettes:
	INCLUDE "data/bank_017/RulesScreenPalettes.asm" ; $78fc, 64 bytes (palettes)
RulesBorderAnimTiles0:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles0.bin" ; $793c, 204 bytes
RulesBorderAnimTiles1:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles1.bin" ; $7a08, 39 bytes
RulesBorderAnimTiles2:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles2.bin" ; $7a2f, 39 bytes
RulesBorderAnimTiles3:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles3.bin" ; $7a56, 162 bytes
RulesBorderAnimTiles4:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles4.bin" ; $7af8, 32 bytes
RulesBorderAnimTiles5:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles5.bin" ; $7b18, 33 bytes
RulesScreenPalette:
	INCLUDE "data/bank_017/RulesScreenPalette.asm" ; $7b39, 64 bytes (palettes)
	; $7b79, 1159 bytes fill to bank end (linker-padded)
