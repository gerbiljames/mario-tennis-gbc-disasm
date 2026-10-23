LoadIntroAwesomeOpponentsCaption:
	push_wram_bank WRAM_STAGING ; $73f2
	ld_slot hl, DataPtr_IntroAwesomeTiles ; $73fb
	ld de, wDecompBuffer ; $73fe
	call DecompressDataFromBank ; $7401
	ld hl, wDecompBuffer ; $7404
	ld de, vTiles2 ; $7407
	ld c, 128 ; $740a
	call QueueVRAMCopy ; $740c
	ld hl, wDecompBufferHigh ; $740f
	ld de, vTiles1 ; $7412
	ld c, wDecompBufferHigh_SIZE / 16 ; $7415
	call QueueVRAMCopy ; $7417
	wram_bank WRAM_TEXT ; $741a
	ld hl, IntroAwesomeOpponentsCaptionTilemap ; $7420
	ld de, wWindowShadowTilemap ; $7423
	call DecompressData ; $7426
	ld hl, IntroAwesomeOpponentsCaptionAttrmap ; $7429
	ld de, wWindowShadowAttrmap ; $742c
	call DecompressData ; $742f
	pop_wram_bank ; $7432
	ret ; $7437
IntroAwesomeOpponentsCaptionTilemap:
	INCBIN "data/engine/cutscenes/lz_IntroAwesomeOpponentsCaptionTilemap.bin" ; $7438, 221 bytes
IntroAwesomeOpponentsCaptionAttrmap:
	INCBIN "data/engine/cutscenes/lz_IntroAwesomeOpponentsCaptionAttrmap.bin" ; $7515, 76 bytes
Unused_6b_IncrementCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $7561
	inc a ; $7564
	ld [wCutsceneStepTimer], a ; $7565
	ret ; $7568
ApplyScrollYFromWram:
	ld a, [wCutsceneSpriteAX] ; $7569
	ldh [hScrollY], a ; $756c
	ret ; $756e
IntroCutsceneMarioCloseupScrollInitPalettes_6b:
	INCLUDE "data/engine/cutscenes/IntroCutsceneMarioCloseupScrollInitPalettes_6b.asm" ; $756f, 64 bytes (palettes)
RunTitleScreen:
	call ClearFrameTasks ; $75af
	wram_bank WRAM_SCREEN ; $75b2
	xor a ; $75b8
	ldh [hScrollX], a ; $75b9
	ldh [hScrollY], a ; $75bb
	ld [wScreenScratch], a ; $75bd
	ld [wTitleSpriteFrame], a ; $75c0
	ld [wTitleSpriteHoldTimer], a ; $75c3
	ld a, $98 ; $75c6
	ld [wScreenScratch], a ; $75c8
	script_fade_out 127 ; $75cb
	call WaitFadeEnd ; $75d0
	call DisableLCDSafely ; $75d3
	script_fade_out 127 ; $75d6
	call WaitFadeEnd ; $75db
	ld c, SCREENASSET_TitleScreen ; $75de
	farcall LoadScreenAssetRecord ; $75e0
	farcall QueueWram3MapToVRAM ; $75e3
	ld c, TitleStartTextFrame0_SIZE / 16 ; $75e6
	ld b, TILEBLOCK_TitleStartTextFrame0 ; $75e8
	ld de, vTiles0 + VRAM_BANK1 ; $75ea
	farcall LoadCompressedTileBlock ; $75ed
	ld c, TitleStartTextFrame1_SIZE / 16 ; $75f0
	ld b, TILEBLOCK_TitleStartTextFrame1 ; $75f2
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $75f4
	farcall LoadCompressedTileBlock ; $75f7
	ld c, TitleStartTextFrame2_SIZE / 16 ; $75fa
	ld b, TILEBLOCK_TitleStartTextFrame2 ; $75fc
	ld de, vTiles0 tile $40 + VRAM_BANK1 ; $75fe
	farcall LoadCompressedTileBlock ; $7601
	ld c, TitleStartTextFrame3_SIZE / 16 ; $7604
	ld b, TILEBLOCK_TitleStartTextFrame3 ; $7606
	ld de, vTiles0 tile $60 + VRAM_BANK1 ; $7608
	farcall LoadCompressedTileBlock ; $760b
	ld c, TitleStartTextFrame4_SIZE / 16 ; $760e
	ld b, TILEBLOCK_TitleStartTextFrame4 ; $7610
	ld de, vTiles0 ; $7612
	farcall LoadCompressedTileBlock ; $7615
	ld c, TitleStartTextFrame5_SIZE / 16 ; $7618
	ld b, TILEBLOCK_TitleStartTextFrame5 ; $761a
	ld de, vTiles0 tile $20 ; $761c
	farcall LoadCompressedTileBlock ; $761f
	ld c, TitleStartTextFrame6_SIZE / 16 ; $7622
	ld b, TILEBLOCK_TitleStartTextFrame6 ; $7624
	ld de, vTiles0 tile $40 ; $7626
	farcall LoadCompressedTileBlock ; $7629
	ld c, TitleStartTextFrame7_SIZE / 16 ; $762c
	ld b, TILEBLOCK_TitleStartTextFrame7 ; $762e
	ld de, vTiles0 tile $60 ; $7630
	farcall LoadCompressedTileBlock ; $7633
	ld hl, TitleSpritePalette ; $7636
	ld_obj_pals de, 0, 1 ; $7639
	call LoadPaletteShadow ; $763c
	frame_task QueueTitleSprite ; $763f
	sound BGM_TITLE_SCREEN ; $7647
	call EnableLCD ; $7649
	script_fade_in 4 ; $764c
	call WaitFadeEnd ; $7651
	wram_bank WRAM_SCREEN ; $7654
	ld a, $9f ; $765a
	ld [wScreenScratch], a ; $765c
.loop:
	call StepTitleSpriteAnimation ; $765f
	call AdvanceFrame ; $7662
	ldh a, [hInputRisingEdge] ; $7665
	bit PADB_A, a ; $7667
	jr nz, .startGame ; $7669
	bit PADB_START, a ; $766b
	jr nz, .startGame ; $766d
	ldh a, [hVBlankCounter] ; $766f
	and $07 ; $7671
	jr nz, .loop ; $7673
	ld a, [wScreenScratch] ; $7675
	inc a ; $7678
	ld [wScreenScratch], a ; $7679
	jr z, .attractTimeout ; $767c
	jr .loop ; $767e
.startGame:
	sound BGM_NONE ; $7680
	sound SFX_MENU_DECIDE ; $7682
	call ClearFrameTasks ; $7684
	script_fade_out 16 ; $7687
	call WaitFadeEnd ; $768c
	xor a ; $768f
	ret ; $7690
	sound BGM_NONE ; $7691
	call ClearFrameTasks ; $7693
	script_fade_out 32 ; $7696
	call WaitFadeEnd ; $769b
	ld hl, rIE ; $769e
	res B_IE_STAT, [hl] ; $76a1
	ld a, $01 ; $76a3
	ret ; $76a5
.attractTimeout:
	sound BGM_NONE ; $76a6
	call ClearFrameTasks ; $76a8
	script_fade_out 8 ; $76ab
	call WaitFadeEnd ; $76b0
	ld a, $ff ; $76b3
	ret ; $76b5
QueueTitleSprite:
	push_wram_bank WRAM_SCREEN ; $76b6
	ld a, [wTitleSpriteFrame] ; $76bf
	ld hl, TitleSpriteFrameTileBases ; $76c2
	add_hl_a ; $76c5
	ld c, [hl] ; $76ca
	ld a, [wTitleSpriteFrame] ; $76cb
	ld hl, TitleSpriteFrameAttrs ; $76ce
	add_hl_a ; $76d1
	ld b, [hl] ; $76d6
	ld_xy de, $28, $58 ; $76d7
	ld hl, QueueTitleSprite_SpriteTemplate ; $76da
	call QueueSpriteTemplate ; $76dd
	pop_wram_bank ; $76e0
	ret ; $76e5
TitleSpriteFrameTileBases:
	; $76e6, 8 bytes (bytes:8)
	db $00, $20, $40, $60, $00, $20, $40, $60 ; 0x00
TitleSpriteFrameAttrs:
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
	ld a, [wTitleSpriteHoldTimer] ; $771f
	or a ; $7722
	jr z, .advanceFrame ; $7723
	inc a ; $7725
	ld [wTitleSpriteHoldTimer], a ; $7726
	cp $10 ; $7729
	jr nz, .done ; $772b
	xor a ; $772d
	ld [wTitleSpriteHoldTimer], a ; $772e
	ret ; $7731
.advanceFrame:
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
	ld [wTitleSpriteHoldTimer], a ; $7749
.done:
	ret ; $774c
	ret ; $774d
TitleScreenTilemap:
	INCBIN "data/engine/cutscenes/lz_TitleScreenTilemap.bin" ; $774e, 292 bytes
TitleScreenAttrmap:
	INCBIN "data/engine/cutscenes/lz_TitleScreenAttrmap.bin" ; $7872, 157 bytes
TitleScreenPalettes:
	INCLUDE "data/engine/cutscenes/TitleScreenPalettes.asm" ; $790f, 64 bytes (palettes)
TitleSpritePalette:
	INCLUDE "data/engine/cutscenes/TitleSpritePalette.asm" ; $794f, 8 bytes (palettes)
DreamMatchEpilogueDoublesBoysTilemap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesBoysTilemap.bin" ; $7957, 293 bytes
DreamMatchEpilogueDoublesBoysAttrmap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesBoysAttrmap.bin" ; $7a7c, 114 bytes
DreamMatchEpilogueDoublesBoyGirlTilemap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesBoyGirlTilemap.bin" ; $7aee, 292 bytes
DreamMatchEpilogueDoublesBoyGirlAttrmap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesBoyGirlAttrmap.bin" ; $7c12, 125 bytes
DreamMatchEpilogueDoublesGirlBoyTilemap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesGirlBoyTilemap.bin" ; $7c8f, 296 bytes
DreamMatchEpilogueDoublesGirlBoyAttrmap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesGirlBoyAttrmap.bin" ; $7db7, 120 bytes
DreamMatchEpilogueDoublesGirlsTilemap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesGirlsTilemap.bin" ; $7e2f, 296 bytes
DreamMatchEpilogueDoublesGirlsAttrmap:
	INCBIN "data/engine/cutscenes/lz_DreamMatchEpilogueDoublesGirlsAttrmap.bin" ; $7f57, 129 bytes
	; $7fd8, 40 bytes fill to bank end (linker-padded)
