DecompressIntroTitleTiles:
	push_wram_bank WRAM_STAGING ; $73f2
	ld_slot hl, DataPtr_IntroAwesomeTiles ; $73fb
	ld de, wDecompBuffer ; $73fe
	call DecompressDataFromBank ; $7401
	ld hl, wDecompBuffer ; $7404
	ld de, vTiles2 ; $7407
	ld c, $80 ; $740a
	call QueueVRAMCopy ; $740c
	ld hl, wTextTileBuffer ; $740f
	ld de, vTiles1 ; $7412
	ld c, $80 ; $7415
	call QueueVRAMCopy ; $7417
	wram_bank WRAM_TEXT ; $741a
	ld hl, DecompressIntroTitleTiles1 ; $7420
	ld de, wWindowShadowTilemap ; $7423
	call DecompressData ; $7426
	ld hl, DecompressIntroTitleTiles2 ; $7429
	ld de, wWindowShadowAttrmap ; $742c
	call DecompressData ; $742f
	pop_wram_bank ; $7432
	ret ; $7437
DecompressIntroTitleTiles1:
	INCBIN "data/bank_06b/lz_DecompressIntroTitleTiles1.bin" ; $7438, 221 bytes
DecompressIntroTitleTiles2:
	INCBIN "data/bank_06b/lz_DecompressIntroTitleTiles2.bin" ; $7515, 76 bytes
Unused_6b_IncrementCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $7561
	inc a ; $7564
	ld [wCutsceneStepTimer], a ; $7565
	ret ; $7568
ApplyScrollYFromWram:
	ld a, [wCutsceneSpriteAX] ; $7569
	ldh [hScrollY], a ; $756c
	ret ; $756e
IntroCutsceneState18InitPalettes_6b:
	INCLUDE "data/bank_06b/IntroCutsceneState18InitPalettes_6b.asm" ; $756f, 64 bytes (palettes)
RunTitleScreen:
	call ClearFrameTasks ; $75af
	wram_bank WRAM_SCREEN ; $75b2
	xor a ; $75b8
	ldh [hScrollX], a ; $75b9
	ldh [hScrollY], a ; $75bb
	ld [wScreenScratch], a ; $75bd
	ld [wTitleSpriteFrame], a ; $75c0
	ld [wTitleSpriteTimer], a ; $75c3
	ld a, $98 ; $75c6
	ld [wScreenScratch], a ; $75c8
	ld c, $7f ; $75cb
	call BeginFadeOut ; $75cd
	call WaitFadeEnd ; $75d0
	call DisableLCDSafely ; $75d3
	ld c, $7f ; $75d6
	call BeginFadeOut ; $75d8
	call WaitFadeEnd ; $75db
	ld c, SCREENASSET_TitleScreen ; $75de
	farcall LoadScreenAssetRecord ; $75e0
	farcall QueueWram3MapToVRAM ; $75e3
	ld c, TitleGfx0_SIZE / 16 ; $75e6
	ld b, TILEBLOCK_TitleGfx0 ; $75e8
	ld de, vTiles0 + VRAM_BANK1 ; $75ea
	farcall LoadCompressedTileBlock ; $75ed
	ld c, TitleGfx1_SIZE / 16 ; $75f0
	ld b, TILEBLOCK_TitleGfx1 ; $75f2
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $75f4
	farcall LoadCompressedTileBlock ; $75f7
	ld c, TitleGfx2_SIZE / 16 ; $75fa
	ld b, TILEBLOCK_TitleGfx2 ; $75fc
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $75fe
	farcall LoadCompressedTileBlock ; $7601
	ld c, TitleGfx3_SIZE / 16 ; $7604
	ld b, TILEBLOCK_TitleGfx3 ; $7606
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $7608
	farcall LoadCompressedTileBlock ; $760b
	ld c, TitleGfx4_SIZE / 16 ; $760e
	ld b, TILEBLOCK_TitleGfx4 ; $7610
	ld de, vTiles0 ; $7612
	farcall LoadCompressedTileBlock ; $7615
	ld c, TitleGfx5_SIZE / 16 ; $7618
	ld b, TILEBLOCK_TitleGfx5 ; $761a
	ld de, vTiles0 + $20 * TILE_SIZE ; $761c
	farcall LoadCompressedTileBlock ; $761f
	ld c, TitleGfx6_SIZE / 16 ; $7622
	ld b, TILEBLOCK_TitleGfx6 ; $7624
	ld de, vTiles0 + $40 * TILE_SIZE ; $7626
	farcall LoadCompressedTileBlock ; $7629
	ld c, TitleGfx7_SIZE / 16 ; $762c
	ld b, TILEBLOCK_TitleGfx7 ; $762e
	ld de, vTiles0 + $60 * TILE_SIZE ; $7630
	farcall LoadCompressedTileBlock ; $7633
	ld hl, Palettes_6b_11 ; $7636
	lb de, $08, $01 ; $7639 palette index, count
	call LoadPaletteShadow ; $763c
	ld a, $01 ; $763f
	ld hl, QueueTitleSprite ; $7641
	call RegisterFrameTask ; $7644
	sound BGM_TITLE_SCREEN ; $7647
	call EnableLCD ; $7649
	script_fade_in $04 ; $764c
	call WaitFadeEnd ; $7651
	wram_bank WRAM_SCREEN ; $7654
	ld a, $9f ; $765a
	ld [wScreenScratch], a ; $765c
.loop:
	call StepTitleSpriteAnimation ; $765f
	call AdvanceFrame ; $7662
	ldh a, [hInputRisingEdge] ; $7665
	bit PADB_A, a ; $7667
	jr nz, .playSfx ; $7669
	bit 3, a ; $766b
	jr nz, .playSfx ; $766d
	ldh a, [hVBlankCounter] ; $766f
	and $07 ; $7671
	jr nz, .loop ; $7673
	ld a, [wScreenScratch] ; $7675
	inc a ; $7678
	ld [wScreenScratch], a ; $7679
	jr z, .playSfx2 ; $767c
	jr .loop ; $767e
.playSfx:
	sound BGM_NONE ; $7680
	sound SFX_MENU_DECIDE ; $7682
	call ClearFrameTasks ; $7684
	ld c, $10 ; $7687
	call BeginFadeOut ; $7689
	call WaitFadeEnd ; $768c
	xor a ; $768f
	ret ; $7690
	sound BGM_NONE ; $7691
	call ClearFrameTasks ; $7693
	ld c, $20 ; $7696
	call BeginFadeOut ; $7698
	call WaitFadeEnd ; $769b
	ld hl, rIE ; $769e
	res 1, [hl] ; $76a1
	ld a, $01 ; $76a3
	ret ; $76a5
.playSfx2:
	sound BGM_NONE ; $76a6
	call ClearFrameTasks ; $76a8
	ld c, $08 ; $76ab
	call BeginFadeOut ; $76ad
	call WaitFadeEnd ; $76b0
	ld a, $ff ; $76b3
	ret ; $76b5
QueueTitleSprite:
	push_wram_bank WRAM_SCREEN ; $76b6
	ld a, [wTitleSpriteFrame] ; $76bf
	ld hl, TitleSpriteTable0 ; $76c2
	add l ; $76c5
	ld l, a ; $76c6
	jr nc, .read ; $76c7
	inc h ; $76c9
.read:
	ld c, [hl] ; $76ca
	ld a, [wTitleSpriteFrame] ; $76cb
	ld hl, TitleSpriteTable1 ; $76ce
	add l ; $76d1
	ld l, a ; $76d2
	jr nc, .readB ; $76d3
	inc h ; $76d5
.readB:
	ld b, [hl] ; $76d6
	lb de, $28, $58 ; $76d7 x, y
	ld hl, QueueTitleSprite_SpriteTemplate ; $76da
	call QueueSpriteTemplate ; $76dd
	pop_wram_bank ; $76e0
	ret ; $76e5
TitleSpriteTable0:
	; $76e6, 8 bytes (bytes:8)
	db $00, $20, $40, $60, $00, $20, $40, $60 ; 0x00
TitleSpriteTable1:
	; $76ee, 8 bytes (bytes:8)
	db $08, $08, $08, $08, $00, $00, $00, $00 ; 0x00
QueueTitleSprite_SpriteTemplate:
	; $76f6, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
StepTitleSpriteAnimation:
	ld a, [wTitleSpriteTimer] ; $771f
	or a ; $7722
	jr z, .zero ; $7723
	inc a ; $7725
	ld [wTitleSpriteTimer], a ; $7726
	cp $10 ; $7729
	jr nz, .done ; $772b
	xor a ; $772d
	ld [wTitleSpriteTimer], a ; $772e
	ret ; $7731
.zero:
	ldh a, [hVBlankCounter] ; $7732
	and $07 ; $7734
	cp $07 ; $7736
	jr nz, .done ; $7738
	ld a, [wTitleSpriteFrame] ; $773a
	inc a ; $773d
	and $07 ; $773e
	ld [wTitleSpriteFrame], a ; $7740
	cp $07 ; $7743
	jr nz, .done ; $7745
	ld a, $01 ; $7747
	ld [wTitleSpriteTimer], a ; $7749
.done:
	ret ; $774c
	ret ; $774d
TitleScreenTilemap:
	INCBIN "data/bank_06b/lz_TitleScreenTilemap.bin" ; $774e, 292 bytes
TitleScreenAttrmap:
	INCBIN "data/bank_06b/lz_TitleScreenAttrmap.bin" ; $7872, 157 bytes
TitleScreenPalettes:
	INCLUDE "data/bank_06b/TitleScreenPalettes.asm" ; $790f, 64 bytes (palettes)
Palettes_6b_11:
	INCLUDE "data/bank_06b/Palettes_6b_11.asm" ; $794f, 8 bytes (palettes)
AwardCeremonyTilemap:
	INCBIN "data/bank_06b/lz_AwardCeremonyTilemap.bin" ; $7957, 293 bytes
AwardCeremonyAttrmap:
	INCBIN "data/bank_06b/lz_AwardCeremonyAttrmap.bin" ; $7a7c, 114 bytes
AwardCeremonyTilemap2:
	INCBIN "data/bank_06b/lz_AwardCeremonyTilemap2.bin" ; $7aee, 292 bytes
AwardCeremonyAttrmap2:
	INCBIN "data/bank_06b/lz_AwardCeremonyAttrmap2.bin" ; $7c12, 125 bytes
AwardCeremonyTilemap3:
	INCBIN "data/bank_06b/lz_AwardCeremonyTilemap3.bin" ; $7c8f, 296 bytes
AwardCeremonyAttrmap3:
	INCBIN "data/bank_06b/lz_AwardCeremonyAttrmap3.bin" ; $7db7, 120 bytes
AwardCeremonyTilemap4:
	INCBIN "data/bank_06b/lz_AwardCeremonyTilemap4.bin" ; $7e2f, 296 bytes
AwardCeremonyAttrmap4:
	INCBIN "data/bank_06b/lz_AwardCeremonyAttrmap4.bin" ; $7f57, 129 bytes
	; $7fd8, 40 bytes fill to bank end (linker-padded)
