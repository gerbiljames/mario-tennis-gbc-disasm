CheckIntroSkipInput:
	ldh a, [hInputRisingEdge] ; $53f1
	and $09 ; $53f3
	ret z ; $53f5
	ld a, $01 ; $53f6
	ld [wIntroCutsceneCheck], a ; $53f8
	ret ; $53fb
InitCutsceneSceneA:
	call DisableLCDSafely ; $53fc
	farcall InitSceneScroll ; $53ff
	farcall InitTextWindows ; $5402
	wram_bank WRAM_STAGING ; $5405
	ld hl, CutsceneSceneAGfx0 ; $540b
	ld de, wDecompBuffer ; $540e
	call DecompressData ; $5411
	ld hl, wDecompBuffer ; $5414
	ld de, vTiles2 ; $5417
	ld c, 128 ; $541a -- 128 of CutsceneSceneAGfx0's 144 tiles
	call QueueVRAMCopy ; $541c
	ld hl, wTextTileBuffer ; $541f
	ld de, vTiles1 ; $5422
	ld c, wTextTileBuffer_SIZE / 16 ; $5425
	call QueueVRAMCopy ; $5427
	wram_bank WRAM_COURT_PLANES ; $542a
	ld hl, CutsceneSceneAGfx1 ; $5430
	ld de, wScreenAttrmap ; $5433
	call DecompressData ; $5436
	wram_bank WRAM_SCREEN ; $5439
	ld hl, CutsceneSceneAGfx2 ; $543f
	ld de, wShadowTilemap ; $5442
	call DecompressData ; $5445
	xor a ; $5448
	ld [wCameraY], a ; $5449
	ld [wCameraX], a ; $544c
	ld a, $24 ; $544f
	ld [wCameraY + 1], a ; $5451
	ld a, $01 ; $5454
	farcall CopyScrolledSceneTilemapToVram ; $5456
	xor a ; $5459
	ld [wCameraY + 1], a ; $545a
	ret ; $545d
Unused_6b_InitCutsceneSceneB:
	call DisableLCDSafely ; $545e
	farcall InitSceneScroll ; $5461
	farcall InitTextWindows ; $5464
	wram_bank WRAM_STAGING ; $5467
	ld hl, CutsceneSceneAGfx0 ; $546d
	ld de, wDecompBuffer ; $5470
	call DecompressData ; $5473
	ld hl, wDecompBuffer ; $5476
	ld de, vTiles2 ; $5479
	ld c, 128 ; $547c -- 128 of CutsceneSceneAGfx0's 144 tiles
	call QueueVRAMCopy ; $547e
	ld hl, wTextTileBuffer ; $5481
	ld de, vTiles1 ; $5484
	ld c, wTextTileBuffer_SIZE / 16 ; $5487
	call QueueVRAMCopy ; $5489
	wram_bank WRAM_COURT_PLANES ; $548c
	ld hl, CutsceneSceneBGfx1 ; $5492
	ld de, wScreenAttrmap ; $5495
	call DecompressData ; $5498
	wram_bank WRAM_SCREEN ; $549b
	ld hl, CutsceneSceneBGfx0 ; $54a1
	ld de, wShadowTilemap ; $54a4
	call DecompressData ; $54a7
	xor a ; $54aa
	ld [wCameraY], a ; $54ab
	ld a, $24 ; $54ae
	ld [wCameraY + 1], a ; $54b0
	ld a, $01 ; $54b3
	farcall CopyScrolledSceneTilemapToVram ; $54b5
	ret ; $54b8
InitCutsceneSceneC:
	call DisableLCDSafely ; $54b9
	farcall InitSceneScroll ; $54bc
	farcall InitTextWindows ; $54bf
	wram_bank WRAM_STAGING ; $54c2
	ld hl, CutsceneSceneAGfx0 ; $54c8
	ld de, wDecompBuffer ; $54cb
	call DecompressData ; $54ce
	ld hl, wDecompBuffer ; $54d1
	ld de, vTiles2 ; $54d4
	ld c, 128 ; $54d7 -- 128 of CutsceneSceneAGfx0's 144 tiles
	call QueueVRAMCopy ; $54d9
	ld hl, wTextTileBuffer ; $54dc
	ld de, vTiles1 ; $54df
	ld c, wTextTileBuffer_SIZE / 16 ; $54e2
	call QueueVRAMCopy ; $54e4
	wram_bank WRAM_COURT_PLANES ; $54e7
	ld hl, CutsceneSceneBGfx1 ; $54ed
	ld de, wScreenAttrmap ; $54f0
	call DecompressData ; $54f3
	wram_bank WRAM_SCREEN ; $54f6
	ld hl, CutsceneSceneBGfx0 ; $54fc
	ld de, wShadowTilemap ; $54ff
	call DecompressData ; $5502
	ld hl, Palette_6b_1 ; $5505
	ld_bg_pals de, 0, 8 ; $5508
	call LoadPaletteShadow ; $550b
	xor a ; $550e
	ld [wCameraY], a ; $550f
	ld a, $24 ; $5512
	ld [wCameraY + 1], a ; $5514
	ld a, $01 ; $5517
	farcall CopyScrolledSceneTilemapToVram ; $5519
	ret ; $551c
CutsceneSceneAGfx0:
	INCBIN "data/bank_06b/lz_CutsceneSceneAGfx0.bin" ; $551d, 1210 bytes
CutsceneSceneBGfx0:
	INCBIN "data/bank_06b/lz_CutsceneSceneBGfx0.bin" ; $59d7, 512 bytes
CutsceneSceneBGfx1:
	INCBIN "data/bank_06b/lz_CutsceneSceneBGfx1.bin" ; $5bd7, 334 bytes
Palette_6b_1:
	INCLUDE "data/bank_06b/Palette_6b_1.asm" ; $5d25, 64 bytes (palettes)
CutsceneSceneAGfx1:
	INCBIN "data/bank_06b/lz_CutsceneSceneAGfx1.bin" ; $5d65, 323 bytes
CutsceneSceneAGfx2:
	INCBIN "data/bank_06b/lz_CutsceneSceneAGfx2.bin" ; $5ea8, 461 bytes
LoadIntroTilesAndPalette:
	ld b, TILEBLOCK_IntroGfx0 ; $6075
	ld c, IntroGfx0_SIZE / 16 ; $6077
	ld de, vTiles0 + VRAM_BANK1 ; $6079
	farcall LoadCompressedTileBlock ; $607c
	ld b, TILEBLOCK_IntroGfx1 ; $607f
	ld c, IntroGfx1_SIZE / 16 ; $6081
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $6083
	farcall LoadCompressedTileBlock ; $6086
	ld b, TILEBLOCK_IntroGfx2 ; $6089
	ld c, IntroGfx2_SIZE / 16 ; $608b
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $608d
	farcall LoadCompressedTileBlock ; $6090
	ld b, TILEBLOCK_IntroGfx3 ; $6093
	ld c, IntroGfx3_SIZE / 16 ; $6095
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $6097
	farcall LoadCompressedTileBlock ; $609a
	ld b, TILEBLOCK_IntroGfx4 ; $609d
	ld c, IntroGfx4_SIZE / 16 ; $609f
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $60a1
	farcall LoadCompressedTileBlock ; $60a4
	ld b, TILEBLOCK_IntroGfx5 ; $60a7
	ld c, IntroGfx5_SIZE / 16 ; $60a9
	ld de, vTiles0 + $44 * TILE_SIZE + VRAM_BANK1 ; $60ab
	farcall LoadCompressedTileBlock ; $60ae
	ld b, TILEBLOCK_IntroGfx6 ; $60b1
	ld c, 4 ; $60b3 -- 4 of IntroGfx6's 2 tiles
	ld de, vTiles0 + $48 * TILE_SIZE + VRAM_BANK1 ; $60b5
	farcall LoadCompressedTileBlock ; $60b8
	ld hl, IntroPalettes ; $60bb
	ld_obj_pals de, 0, 2 ; $60be
	call LoadPaletteShadow ; $60c1
	ret ; $60c4
IntroPalettes:
	INCLUDE "data/bank_06b/IntroPalettes.asm" ; $60c5, 16 bytes (palettes)
SetCameraYFromScrollPos:
	ld hl, wIntroCutsceneScrollY ; $60d5
	ld a, [hl+] ; $60d8
	ld d, [hl] ; $60d9
	ld e, a ; $60da
	sla e ; $60db
	rl d ; $60dd
	sla e ; $60df
	rl d ; $60e1
	sla e ; $60e3
	rl d ; $60e5
	sla e ; $60e7
	rl d ; $60e9
	sla e ; $60eb
	rl d ; $60ed
	ld a, e ; $60ef
	ld [wCameraY], a ; $60f0
	ld a, d ; $60f3
	ld [wCameraY + 1], a ; $60f4
	ret ; $60f7
QueueScrollingSprite:
	ld hl, wIntroCutsceneScrollY ; $60f8
	ld a, [hl+] ; $60fb
	ld d, [hl] ; $60fc
	ld e, a ; $60fd
	ld hl, wCutsceneScrollAccum ; $60fe
	ld a, [hl+] ; $6101
	ld h, [hl] ; $6102
	ld l, a ; $6103
	ld a, l ; $6104
	sub e ; $6105
	ld l, a ; $6106
	ld a, h ; $6107
	sbc d ; $6108
	ld h, a ; $6109
	ld e, l ; $610a
	ld a, [wCutsceneSpriteAnimFrame] ; $610b
	ld c, a ; $610e
	ld d, $40 ; $610f
	call QueueIntroSpriteBlock ; $6111
	ret ; $6114
AdvanceSpriteAnimTimer:
	ld a, [wCutsceneSpriteAnimTick] ; $6115
	inc a ; $6118
	ld [wCutsceneSpriteAnimTick], a ; $6119
	and $30 ; $611c
	rrca ; $611e
	rrca ; $611f
	rrca ; $6120
	rrca ; $6121
	ld [wCutsceneSpriteAnimFrame], a ; $6122
	ret ; $6125
QueueIntroSpriteBlock:
	ld hl, IntroSpriteBlockTable ; $6126
	ld a, c ; $6129
	add l ; $612a
	ld l, a ; $612b
	jr nc, .read ; $612c
	inc h ; $612e
.read:
	ld c, [hl] ; $612f
	ld hl, QueueIntroSpriteBlock_SpriteTemplate ; $6130
	ld b, OAM_BANK1 ; $6133
	call QueueSpriteTemplate ; $6135
	ret ; $6138
IntroSpriteBlockTable:
	; $6139, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
QueueIntroSpriteBlock_SpriteTemplate:
	; $613d, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
; Returns unless wCutsceneStepTimer >= $14 and [$c323] is nonzero, then
; reads the 16-bit camera Y at $c322 (wCameraY) and writes it back
; unchanged, so the routine has no effect. Nothing calls it.
Unused_6b_RewriteCutsceneCameraY:
	ld a, [wCutsceneStepTimer] ; $615e
	cp $14 ; $6161
	jr c, .done ; $6163
	ld a, [wCameraY + 1] ; $6165
	or a ; $6168
	jr z, .done ; $6169
	ld a, [wCameraY + 1] ; $616b
	ld h, a ; $616e
	ld a, [wCameraY] ; $616f
	ld l, a ; $6172
	ld a, h ; $6173
	ld [wCameraY + 1], a ; $6174
	ld a, l ; $6177
	ld [wCameraY], a ; $6178
.done:
	ret ; $617b
InitTitleSceneGraphics:
	call DisableLCDSafely ; $617c
	farcall InitSceneScroll ; $617f
	farcall InitTextWindows ; $6182
	wram_bank WRAM_STAGING ; $6185
	ld hl, TitleSceneGraphicsGfx0 ; $618b
	ld de, wDecompBuffer ; $618e
	call DecompressData ; $6191
	ld hl, wDecompBuffer ; $6194
	ld de, vTiles2 + VRAM_BANK1 ; $6197
	ld c, 128 ; $619a -- 128 of TitleSceneGraphicsGfx0's 241 tiles
	call QueueVRAMCopy ; $619c
	ld hl, wTextTileBuffer ; $619f
	ld de, vTiles1 + VRAM_BANK1 ; $61a2
	ld c, wTextTileBuffer_SIZE / 16 ; $61a5
	call QueueVRAMCopy ; $61a7
	wram_bank WRAM_COURT_PLANES ; $61aa
	ld hl, TitleSceneGraphicsGfx2 ; $61b0
	ld de, wScreenAttrmap ; $61b3
	call DecompressData ; $61b6
	wram_bank WRAM_SCREEN ; $61b9
	ld hl, TitleSceneGraphicsGfx1 ; $61bf
	ld de, wShadowTilemap ; $61c2
	call DecompressData ; $61c5
	ld hl, TitleScenePalette ; $61c8
	ld_bg_pals de, 0, 8 ; $61cb
	call LoadPaletteShadow ; $61ce
	ld a, $20 ; $61d1
	ld [wCameraX + 1], a ; $61d3
	xor a ; $61d6
	ld [wCameraX], a ; $61d7
	ld [wCameraY], a ; $61da
	ld [wCameraY + 1], a ; $61dd
	ld a, $01 ; $61e0
	farcall CopyScrolledSceneTilemapToVram ; $61e2
	ret ; $61e5
TitleSceneGraphicsGfx0:
	INCBIN "data/bank_06b/lz_TitleSceneGraphicsGfx0.bin" ; $61e6, 2774 bytes
TitleSceneGraphicsGfx1:
	INCBIN "data/bank_06b/lz_TitleSceneGraphicsGfx1.bin" ; $6cbc, 595 bytes
TitleSceneGraphicsGfx2:
	INCBIN "data/bank_06b/lz_TitleSceneGraphicsGfx2.bin" ; $6f0f, 308 bytes
TitleScenePalette:
	INCLUDE "data/bank_06b/TitleScenePalette.asm" ; $7043, 64 bytes (palettes)
IntroSequenceTimerTask:
	ld a, [wCutsceneSpriteAX] ; $7083
	inc a ; $7086
	ld [wCutsceneSpriteAX], a ; $7087
	cp $5a ; $708a
	jr nz, .compare ; $708c
	ld a, $01 ; $708e
	ld hl, CycleBgPalettes4To7Task ; $7090
	call RegisterFrameTask ; $7093
.compare:
	cp $aa ; $7096
	jr nz, .compare2 ; $7098
	ld a, $01 ; $709a
	ld hl, AnimateBgPalette1Task ; $709c
	call RegisterFrameTask ; $709f
.compare2:
	cp $01 ; $70a2
	jr nz, .done ; $70a4
	ld a, $01 ; $70a6
	ld hl, AnimateBgPalettes2And3Task ; $70a8
	call RegisterFrameTask ; $70ab
.done:
	ret ; $70ae
BgPalette1TaskPalettes:
	INCLUDE "data/bank_06b/BgPalette1TaskPalettes.asm" ; $70af, 128 bytes (palettes)
BgPalettes2And3TaskPalettes0:
	INCLUDE "data/bank_06b/BgPalettes2And3TaskPalettes0.asm" ; $712f, 128 bytes (palettes)
BgPalettes2And3TaskPalettes1:
	INCLUDE "data/bank_06b/BgPalettes2And3TaskPalettes1.asm" ; $71af, 128 bytes (palettes)
BgPalettes4To7TaskPalettes:
	INCLUDE "data/bank_06b/BgPalettes4To7TaskPalettes.asm" ; $722f, 128 bytes (palettes)
AnimateBgPalette1Task:
	ldh a, [hVBlankCounter] ; $72af
	and $03 ; $72b1
	cp $03 ; $72b3
	ret nz ; $72b5
	ld a, [wCutsceneSpriteAY] ; $72b6
	inc a ; $72b9
	ld [wCutsceneSpriteAY], a ; $72ba
	cp $10 ; $72bd
	jr nc, .ge10 ; $72bf
	sla a ; $72c1
	sla a ; $72c3
	sla a ; $72c5
	ld hl, BgPalette1TaskPalettes ; $72c7
	add l ; $72ca
	ld l, a ; $72cb
	jr nc, .loadPalettesImmediate ; $72cc
	inc h ; $72ce
.loadPalettesImmediate:
	ld_bg_pals de, 1, 1 ; $72cf
	call LoadPalettesImmediate ; $72d2
	ret ; $72d5
.ge10:
	ld hl, AnimateBgPalette1Task ; $72d6
	call UnregisterFrameTask ; $72d9
	ret ; $72dc
AnimateBgPalettes2And3Task:
	ldh a, [hVBlankCounter] ; $72dd
	and $03 ; $72df
	cp $03 ; $72e1
	ret nz ; $72e3
	ld a, [wCutsceneSpriteBX] ; $72e4
	inc a ; $72e7
	ld [wCutsceneSpriteBX], a ; $72e8
	cp $10 ; $72eb
	jr nc, .ge10 ; $72ed
	sla a ; $72ef
	sla a ; $72f1
	sla a ; $72f3
	push af ; $72f5
	ld hl, BgPalettes2And3TaskPalettes0 ; $72f6
	add l ; $72f9
	ld l, a ; $72fa
	jr nc, .loadPalettesImmediate ; $72fb
	inc h ; $72fd
.loadPalettesImmediate:
	ld_bg_pals de, 2, 1 ; $72fe
	call LoadPalettesImmediate ; $7301
	pop af ; $7304
	ld hl, BgPalettes2And3TaskPalettes1 ; $7305
	add l ; $7308
	ld l, a ; $7309
	jr nc, .loadPalettesImmediate2 ; $730a
	inc h ; $730c
.loadPalettesImmediate2:
	ld_bg_pals de, 3, 1 ; $730d
	call LoadPalettesImmediate ; $7310
	ret ; $7313
.ge10:
	ld hl, AnimateBgPalettes2And3Task ; $7314
	call UnregisterFrameTask ; $7317
	ret ; $731a
CycleBgPalettes4To7Task:
	ldh a, [hVBlankCounter] ; $731b
	and $03 ; $731d
	cp $03 ; $731f
	ret nz ; $7321
	ld a, [wCutsceneSpriteBY] ; $7322
	inc a ; $7325
	ld [wCutsceneSpriteBY], a ; $7326
	cp $10 ; $7329
	jr nc, .compare ; $732b
	sla a ; $732d
	sla a ; $732f
	sla a ; $7331
	ld hl, BgPalettes4To7TaskPalettes ; $7333
	add l ; $7336
	ld l, a ; $7337
	jr nc, .loadPalettesImmediate ; $7338
	inc h ; $733a
.loadPalettesImmediate:
	ld_bg_pals de, 4, 4 ; $733b
	call LoadPalettesImmediate ; $733e
	ret ; $7341
.compare:
	cp $20 ; $7342
	jr c, .lt20 ; $7344
	ld b, a ; $7346
	ld a, $20 ; $7347
	sub b ; $7349
	sla a ; $734a
	sla a ; $734c
	sla a ; $734e
	ld hl, BgPalettes4To7TaskPalettes ; $7350
	add l ; $7353
	ld l, a ; $7354
	jr nc, .loadPalettesImmediate2 ; $7355
	inc h ; $7357
.loadPalettesImmediate2:
	ld_bg_pals de, 4, 4 ; $7358
	call LoadPalettesImmediate ; $735b
	ret ; $735e
.lt20:
	ld hl, CycleBgPalettes4To7Task ; $735f
	call UnregisterFrameTask ; $7362
	ret ; $7365
ScrollCutsceneXRightTask:
	ld a, [wCutsceneStepTimer] ; $7366
	cp $10 ; $7369
	jr nc, .done ; $736b
	ld hl, ScrollCutsceneXRightTaskTable ; $736d
	add l ; $7370
	ld l, a ; $7371
	jr nc, .read ; $7372
	inc h ; $7374
.read:
	ld a, [hl] ; $7375
	ld b, a ; $7376
	ld a, [wCutsceneScrollX] ; $7377
	add b ; $737a
	ld [wCutsceneScrollX], a ; $737b
	ldh [hScrollX], a ; $737e
.done:
	ret ; $7380
ScrollCutsceneXRightTaskTable:
	; $7381, 20 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00 ; 0x10
ScrollCutsceneXLeftTask:
	ld a, [wCutsceneStepTimer] ; $7395
	cp $10 ; $7398
	jr nc, .done ; $739a
	ld hl, ScrollCutsceneXLeftTaskTable ; $739c
	add l ; $739f
	ld l, a ; $73a0
	jr nc, .read ; $73a1
	inc h ; $73a3
.read:
	ld a, [hl] ; $73a4
	ld b, a ; $73a5
	ld a, [wCutsceneScrollX] ; $73a6
	sub b ; $73a9
	ld [wCutsceneScrollX], a ; $73aa
	ldh [hScrollX], a ; $73ad
.done:
	ret ; $73af
ScrollCutsceneXLeftTaskTable:
	; $73b0, 20 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00 ; 0x10
ScrollCutsceneLeftTask:
	ld a, [wCutsceneStepTimer] ; $73c4
	cp $10 ; $73c7
	jr nc, .done ; $73c9
	ld hl, ScrollCutsceneLeftTaskTable ; $73cb
	add l ; $73ce
	ld l, a ; $73cf
	jr nc, .read ; $73d0
	inc h ; $73d2
.read:
	ld a, [hl] ; $73d3
	ld b, a ; $73d4
	ld a, [wCutsceneScrollX] ; $73d5
	sub b ; $73d8
	ld [wCutsceneScrollX], a ; $73d9
	ldh [hScrollX], a ; $73dc
.done:
	ret ; $73de
ScrollCutsceneLeftTaskTable:
	; $73df, 19 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $02, $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00 ; 0x10
