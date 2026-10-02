IntroCutsceneState16Update_6b:
	ld a, [wCutsceneStepTimer] ; $4a42
	inc a ; $4a45
	ld [wCutsceneStepTimer], a ; $4a46
	cp $70 ; $4a49
	jp z, DispatchCutsceneStateInit.loopB ; $4a4b
	jp DispatchCutsceneStateInit.loop ; $4a4e
IntroCutsceneState16Exit_6b:
	xor a ; $4a51
	ld [wCutsceneStepTimer], a ; $4a52
	jp DispatchCutsceneStateInit.loop2 ; $4a55
IntroCutsceneState16InitPalettes_6b:
	INCLUDE "data/bank_06b/IntroCutsceneState16InitPalettes_6b.asm" ; $4a58, 64 bytes (palettes)
IntroCutsceneState17Init_6b:
	wram_bank WRAM_ACTORS ; $4a98
	ld hl, wIntroCharactersTilemap + 6 * TILEMAP_WIDTH ; $4a9e
	ld de, vBGMap1 + 6 * TILEMAP_WIDTH ; $4aa1
	ld c, $10 ; $4aa4
	call QueueVRAMCopy ; $4aa6
	ld hl, wIntroCharactersAttrmap + 6 * TILEMAP_WIDTH ; $4aa9
	ld de, vBGMap1 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $4aac
	ld c, $10 ; $4aaf
	call QueueVRAMCopy ; $4ab1
	call AdvanceFrame ; $4ab4
	ld hl, wIntroCharactersTilemap + 4 * TILEMAP_WIDTH ; $4ab7
	ld de, vBGMap1 + 4 * TILEMAP_WIDTH ; $4aba
	ld c, $04 ; $4abd
	call QueueVRAMCopy ; $4abf
	ld hl, wIntroCharactersAttrmap + 4 * TILEMAP_WIDTH ; $4ac2
	ld de, vBGMap1 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4ac5
	ld c, $04 ; $4ac8
	call QueueVRAMCopy ; $4aca
	call AdvanceFrame ; $4acd
	ld hl, Palettes_6b_03 ; $4ad0
	ld_bg_pals de, 1, 7 ; $4ad3
	call LoadPaletteShadow ; $4ad6
	xor a ; $4ad9
	ld [wCutsceneStepTimer], a ; $4ada
	jp DispatchCutsceneStateInit.loop ; $4add
IntroCutsceneState17Update_6b:
	ld a, [wCutsceneStepTimer] ; $4ae0
	inc a ; $4ae3
	ld [wCutsceneStepTimer], a ; $4ae4
	cp $70 ; $4ae7
	jp z, DispatchCutsceneStateInit.loopB ; $4ae9
	jp DispatchCutsceneStateInit.loop ; $4aec
IntroCutsceneState17Exit_6b:
	jp DispatchCutsceneStateInit.loop2 ; $4aef
IntroCutsceneState18Init_6b:
	ld hl, IntroCutsceneState18InitPalettes_6b ; $4af2
	ld_bg_pals de, 0, 8 ; $4af5
	call LoadPaletteShadow ; $4af8
	wram_bank WRAM_TEXT ; $4afb
	ld hl, wWindowShadowTilemap + 19 * TILEMAP_WIDTH ; $4b01
	ld de, vBGMap1 + 19 * TILEMAP_WIDTH ; $4b04
	ld c, $10 ; $4b07
	call QueueVRAMCopy ; $4b09
	ld hl, wWindowShadowAttrmap + 19 * TILEMAP_WIDTH ; $4b0c
	ld de, vBGMap1 + 19 * TILEMAP_WIDTH + VRAM_BANK1 ; $4b0f
	ld c, $10 ; $4b12
	call QueueVRAMCopy ; $4b14
	call AdvanceFrame ; $4b17
	ld hl, wWindowShadowTilemap + 11 * TILEMAP_WIDTH ; $4b1a
	ld de, vBGMap1 + 11 * TILEMAP_WIDTH ; $4b1d
	ld c, $10 ; $4b20
	call QueueVRAMCopy ; $4b22
	ld hl, wWindowShadowAttrmap + 11 * TILEMAP_WIDTH ; $4b25
	ld de, vBGMap1 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $4b28
	ld c, $10 ; $4b2b
	call QueueVRAMCopy ; $4b2d
	call AdvanceFrame ; $4b30
	ld a, $48 ; $4b33
	ld [wCutsceneSpriteAX], a ; $4b35
	ldh [hScrollY], a ; $4b38
	ld a, $08 ; $4b3a
	ld hl, ApplyScrollYFromWram ; $4b3c
	call RegisterFrameTask ; $4b3f
	ld hl, wWindowShadowTilemap + 3 * TILEMAP_WIDTH ; $4b42
	ld de, vBGMap1 + 3 * TILEMAP_WIDTH ; $4b45
	ld c, $10 ; $4b48
	call QueueVRAMCopy ; $4b4a
	ld hl, wWindowShadowAttrmap + 3 * TILEMAP_WIDTH ; $4b4d
	ld de, vBGMap1 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $4b50
	ld c, $10 ; $4b53
	call QueueVRAMCopy ; $4b55
	call AdvanceFrame ; $4b58
	ld hl, wWindowShadowTilemap ; $4b5b
	ld de, vBGMap1 ; $4b5e
	ld c, $08 ; $4b61
	call QueueVRAMCopy ; $4b63
	ld hl, wWindowShadowAttrmap ; $4b66
	ld de, vBGMap1 + VRAM_BANK1 ; $4b69
	ld c, $08 ; $4b6c
	call QueueVRAMCopy ; $4b6e
	ld hl, Palettes_6b_03 ; $4b71
	ld_bg_pals de, 1, 7 ; $4b74
	call LoadPaletteShadow ; $4b77
	call AdvanceFrame ; $4b7a
	wram_bank WRAM_STAGING ; $4b7d
	ld hl, wDecompBuffer ; $4b83
	ld de, vTiles2 ; $4b86
	ld c, $20 ; $4b89
	call QueueVRAMCopy ; $4b8b
	call AdvanceFrame ; $4b8e
	ld hl, wDecompBuffer + 32 * TILE_SIZE ; $4b91
	ld de, vTiles2 + $20 * TILE_SIZE ; $4b94
	ld c, $20 ; $4b97
	call QueueVRAMCopy ; $4b99
	call AdvanceFrame ; $4b9c
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $4b9f
	ld de, vTiles2 + $40 * TILE_SIZE ; $4ba2
	ld c, $20 ; $4ba5
	call QueueVRAMCopy ; $4ba7
	call AdvanceFrame ; $4baa
	ld hl, wDecompBuffer + 96 * TILE_SIZE ; $4bad
	ld de, vTiles2 + $60 * TILE_SIZE ; $4bb0
	ld c, $20 ; $4bb3
	call QueueVRAMCopy ; $4bb5
	call AdvanceFrame ; $4bb8
	ld hl, wTextTileBuffer ; $4bbb
	ld de, vTiles1 ; $4bbe
	ld c, $20 ; $4bc1
	call QueueVRAMCopy ; $4bc3
	call AdvanceFrame ; $4bc6
	xor a ; $4bc9
	ld [wCutsceneStepTimer], a ; $4bca
	jp DispatchCutsceneStateInit.loop ; $4bcd
IntroCutsceneState18Update_6b:
	ld a, [wCutsceneSpriteAX] ; $4bd0
	sub $04 ; $4bd3
	ld [wCutsceneSpriteAX], a ; $4bd5
	ldh [hScrollY], a ; $4bd8
	jp z, DispatchCutsceneStateInit.loopB ; $4bda
	ld a, [wCutsceneStepTimer] ; $4bdd
	or a ; $4be0
	jr nz, .checkCutsceneStepTimer ; $4be1
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $4be3
	inc a ; $4be6
	ld [wCutsceneStepTimer], a ; $4be7
	jp DispatchCutsceneStateInit.loop ; $4bea
IntroCutsceneState18Exit_6b:
	ld hl, ApplyScrollYFromWram ; $4bed
	call UnregisterFrameTask ; $4bf0
	wram_bank WRAM_SCREEN ; $4bf3
	ld a, $00 ; $4bf9
	ldh [hShowDebugConsole], a ; $4bfb
	jp DispatchCutsceneStateInit.loop2 ; $4bfd
Palettes_6b_03:
	INCLUDE "data/bank_06b/Palettes_6b_03.asm" ; $4c00, 56 bytes (palettes)
IntroCutsceneState19Init_6b:
	ld hl, Palette_6b_1 ; $4c38
	ld_bg_pals de, 0, 8 ; $4c3b
	call LoadPaletteShadow ; $4c3e
	xor a ; $4c41
	ld [wCutsceneStepTimer], a ; $4c42
	ld [wCutsceneSpriteAY], a ; $4c45
	xor a ; $4c48
	ld [wCameraY], a ; $4c49
	ld a, $24 ; $4c4c
	ld [wCameraY + 1], a ; $4c4e
	ld a, $00 ; $4c51
	ld [wCutsceneSpriteAnimTick], a ; $4c53
	ld [wCutsceneSpriteAnimFrame], a ; $4c56
	ld de, $015c ; $4c59
	ld hl, wCutsceneScrollAccum ; $4c5c
	ld a, e ; $4c5f
	ld [hl+], a ; $4c60
	ld [hl], d ; $4c61
	ld de, $0120 ; $4c62
	ld hl, wIntroCutsceneScrollY ; $4c65
	ld a, e ; $4c68
	ld [hl+], a ; $4c69
	ld [hl], d ; $4c6a
	jp DispatchCutsceneStateInit.loop ; $4c6b
IntroCutsceneState19Exit_6b:
	ld c, $04 ; $4c6e
	call BeginFadeOut ; $4c70
	call WaitFadeEnd ; $4c73
	jp DispatchCutsceneStateInit.loop2 ; $4c76
; Instruction-identical to IntroCutsceneState00Update_6b (in this bank); a change here belongs in every copy.
	twin_named intro_cutscene_state00_update, IntroCutsceneState19Update_6b ; $4c79
UpdateCutsceneScrollX:
	ld a, [wCutsceneStepTimer] ; $4c9e
	ld hl, CutsceneScrollXTable ; $4ca1
	add l ; $4ca4
	ld l, a ; $4ca5
	jr nc, .read ; $4ca6
	inc h ; $4ca8
.read:
	ld e, [hl] ; $4ca9
	ld hl, wIntroCutsceneScrollY ; $4caa
	ld a, [hl+] ; $4cad
	ld h, [hl] ; $4cae
	ld l, a ; $4caf
	ld d, $00 ; $4cb0
	ld a, l ; $4cb2
	sub e ; $4cb3
	ld l, a ; $4cb4
	ld a, h ; $4cb5
	sbc d ; $4cb6
	ld h, a ; $4cb7
	ld a, h ; $4cb8
	ld [wIntroCutsceneScrollY + 1], a ; $4cb9
	ld a, l ; $4cbc
	ld [wIntroCutsceneScrollY], a ; $4cbd
	ret ; $4cc0
CutsceneScrollXTable:
	INCBIN "data/bank_06b/CutsceneScrollXTable.bin" ; $4cc1, 160 bytes
UpdateCutsceneScrollY:
	ld a, [wCutsceneStepTimer] ; $4d61
	ld hl, CutsceneScrollYTable ; $4d64
	add l ; $4d67
	ld l, a ; $4d68
	jr nc, .read ; $4d69
	inc h ; $4d6b
.read:
	ld e, [hl] ; $4d6c
	ld hl, wCutsceneScrollAccum ; $4d6d
	ld a, [hl+] ; $4d70
	ld h, [hl] ; $4d71
	ld l, a ; $4d72
	ld d, $00 ; $4d73
	ld a, l ; $4d75
	sub e ; $4d76
	ld l, a ; $4d77
	ld a, h ; $4d78
	sbc d ; $4d79
	ld h, a ; $4d7a
	ld a, h ; $4d7b
	ld [wCutsceneScrollAccum + 1], a ; $4d7c
	ld a, l ; $4d7f
	ld [wCutsceneScrollAccum], a ; $4d80
	ret ; $4d83
CutsceneScrollYTable:
	INCBIN "data/bank_06b/CutsceneScrollYTable.bin" ; $4d84, 169 bytes
QueueCutsceneAnimatedSprites:
	ld a, [wCutsceneStepTimer] ; $4e2d
	cp $20 ; $4e30
	ret c ; $4e32
	ld a, [wCutsceneStepTimer] ; $4e33
	sub $20 ; $4e36
	add a ; $4e38
	ld hl, CutsceneAnimatedSprites2 ; $4e39
	add l ; $4e3c
	ld l, a ; $4e3d
	jr nc, .read ; $4e3e
	inc h ; $4e40
.read:
	ld a, [hl+] ; $4e41
	ld d, [hl] ; $4e42
	ld e, a ; $4e43
	call ApplyCutsceneScrollToSpriteX ; $4e44
	ld c, $40 ; $4e47
	ld b, $09 ; $4e49
	ld hl, QueueCutsceneAnimatedSprites_SpriteTemplate0 ; $4e4b
	call QueueSpriteTemplate ; $4e4e
	ld a, [wCutsceneStepTimer] ; $4e51
	sub $20 ; $4e54
	add a ; $4e56
	ld hl, CutsceneAnimatedSprites1 ; $4e57
	add l ; $4e5a
	ld l, a ; $4e5b
	jr nc, .readB ; $4e5c
	inc h ; $4e5e
.readB:
	ld a, [hl+] ; $4e5f
	ld d, [hl] ; $4e60
	ld e, a ; $4e61
	call ApplyCutsceneScrollToSpriteX ; $4e62
	ld c, $44 ; $4e65
	ld b, $09 ; $4e67
	ld hl, QueueCutsceneAnimatedSprites_SpriteTemplate1 ; $4e69
	call QueueSpriteTemplate ; $4e6c
	ld a, [wCutsceneStepTimer] ; $4e6f
	sub $20 ; $4e72
	add a ; $4e74
	ld hl, CutsceneAnimatedSprites0 ; $4e75
	add l ; $4e78
	ld l, a ; $4e79
	jr nc, .read2 ; $4e7a
	inc h ; $4e7c
.read2:
	ld a, [hl+] ; $4e7d
	ld d, [hl] ; $4e7e
	ld e, a ; $4e7f
	call ApplyCutsceneScrollToSpriteX ; $4e80
	ld c, $48 ; $4e83
	ld b, $09 ; $4e85
	ld hl, QueueCutsceneAnimatedSprites_SpriteTemplate2 ; $4e87
	call QueueSpriteTemplate ; $4e8a
	ret ; $4e8d
QueueCutsceneAnimatedSprites_SpriteTemplate0:
	; $4e8e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
QueueCutsceneAnimatedSprites_SpriteTemplate1:
	; $4e97, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
QueueCutsceneAnimatedSprites_SpriteTemplate2:
	; $4ea0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
CutsceneAnimatedSprites0:
	INCBIN "data/bank_06b/CutsceneAnimatedSprites0.bin" ; $4ea5, 240 bytes
CutsceneAnimatedSprites1:
	INCBIN "data/bank_06b/CutsceneAnimatedSprites1.bin" ; $4f95, 216 bytes
CutsceneAnimatedSprites2:
	INCBIN "data/bank_06b/CutsceneAnimatedSprites2.bin" ; $506d, 288 bytes
ApplyCutsceneScrollToSpriteX:
	push bc ; $518d
	push hl ; $518e
	ld c, d ; $518f
	ld b, e ; $5190
	ld hl, wIntroCutsceneScrollY ; $5191
	ld a, [hl+] ; $5194
	ld d, [hl] ; $5195
	ld e, a ; $5196
	ld h, $00 ; $5197
	ld l, b ; $5199
	ld a, l ; $519a
	sub e ; $519b
	ld l, a ; $519c
	ld a, h ; $519d
	sbc d ; $519e
	ld h, a ; $519f
	ld e, l ; $51a0
	ld d, c ; $51a1
	pop hl ; $51a2
	pop bc ; $51a3
	ret ; $51a4
.loop:
	ldh a, [hInputRisingEdge] ; $51a5
	bit PADB_A, a ; $51a7
	jr nz, .done ; $51a9
	jr .loop ; $51ab
.done:
	ret ; $51ad
ShowIntroLogoScreen:
	call DisableLCDSafely ; $51ae
	ld c, SCREENASSET_CompanyLogos ; $51b1
	farcall LoadScreenAssetRecord ; $51b3
	farcall QueueWram3MapToVRAM ; $51b6
	xor a ; $51b9
	ldh [hScrollX], a ; $51ba
	ldh [hScrollY], a ; $51bc
	ld [wCutsceneStepTimer], a ; $51be
	ld a, $d8 ; $51c1
	ldh [hScrollY], a ; $51c3
	sound SFX_LOGO_JINGLE ; $51c5
	call EnableLCD ; $51c7
	script_fade_in $20 ; $51ca
	call WaitFadeEnd ; $51cf
.loop:
	call AdvanceFrame ; $51d2
	ld a, [wCutsceneStepTimer] ; $51d5
	inc a ; $51d8
	ld [wCutsceneStepTimer], a ; $51d9
	cp $3c ; $51dc
	jr z, .clearCutsceneStepTimer ; $51de
	jr .loop ; $51e0
.clearCutsceneStepTimer:
	xor a ; $51e2
	ld [wCutsceneStepTimer], a ; $51e3
	ret ; $51e6
ScrollOutIntroLogo:
	ld a, $40 ; $51e7
	ldh [hScrollY], a ; $51e9
.loop:
	call AdvanceFrame ; $51eb
	ld a, [wCutsceneStepTimer] ; $51ee
	inc a ; $51f1
	ld [wCutsceneStepTimer], a ; $51f2
	cp $3e ; $51f5
	jr z, .eq3e ; $51f7
	jr .loop ; $51f9
.eq3e:
	ld c, $10 ; $51fb
	call BeginFadeOut ; $51fd
	call WaitFadeEnd ; $5200
	call DisableLCDSafely ; $5203
	xor a ; $5206
	ldh [hScrollY], a ; $5207
	ret ; $5209
LoadCutsceneTileset:
	ld b, TILEBLOCK_CutsceneGfx0 ; $520a
	ld c, CutsceneGfx0_SIZE / 16 ; $520c
	ld de, vTiles0 + VRAM_BANK1 ; $520e
	farcall LoadCompressedTileBlock ; $5211
	ld b, TILEBLOCK_CutsceneGfx1 ; $5214
	ld c, CutsceneGfx1_SIZE / 16 ; $5216
	ld de, vTiles0 + $06 * TILE_SIZE + VRAM_BANK1 ; $5218
	farcall LoadCompressedTileBlock ; $521b
	ld b, TILEBLOCK_CutsceneGfx2 ; $521e
	ld c, CutsceneGfx2_SIZE / 16 ; $5220
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $5222
	farcall LoadCompressedTileBlock ; $5225
	ld b, TILEBLOCK_CutsceneGfx3 ; $5228
	ld c, CutsceneGfx3_SIZE / 16 ; $522a
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $522c
	farcall LoadCompressedTileBlock ; $522f
	ld b, TILEBLOCK_CutsceneGfx4 ; $5232
	ld c, CutsceneGfx4_SIZE / 16 ; $5234
	ld de, vTiles0 + $26 * TILE_SIZE + VRAM_BANK1 ; $5236
	farcall LoadCompressedTileBlock ; $5239
	ld b, TILEBLOCK_CutsceneGfx5 ; $523c
	ld c, CutsceneGfx5_SIZE / 16 ; $523e
	ld de, vTiles0 + $38 * TILE_SIZE + VRAM_BANK1 ; $5240
	farcall LoadCompressedTileBlock ; $5243
	ld b, TILEBLOCK_CutsceneGfx6 ; $5246
	ld c, CutsceneGfx6_SIZE / 16 ; $5248
	ld de, vTiles0 + $48 * TILE_SIZE + VRAM_BANK1 ; $524a
	farcall LoadCompressedTileBlock ; $524d
	ld hl, CutsceneTilesetPalettes ; $5250
	ld_obj_pals de, 0, 2 ; $5253
	call LoadPaletteShadow ; $5256
	ret ; $5259
CutsceneTilesetPalettes:
	INCLUDE "data/bank_06b/CutsceneTilesetPalettes.asm" ; $525a, 16 bytes (palettes)
QueueCutsceneSpriteGroupA:
	ld hl, QueueCutsceneSpriteGroupA_SpriteTemplate0 ; $526a
	ld a, [wCutsceneSpriteAX] ; $526d
	ld d, $10 ; $5270
	add d ; $5272
	ld d, a ; $5273
	ld a, [wCutsceneSpriteAY] ; $5274
	ld e, a ; $5277
	call ApplyCutsceneBobOffset ; $5278
	ld c, $00 ; $527b
	ld b, $08 ; $527d
	call QueueSpriteTemplate ; $527f
	ld hl, QueueCutsceneSpriteGroupA_SpriteTemplate1 ; $5282
	ld a, [wCutsceneSpriteAX] ; $5285
	ld d, $08 ; $5288
	add d ; $528a
	ld d, a ; $528b
	ld a, [wCutsceneSpriteAY] ; $528c
	ld e, $10 ; $528f
	add e ; $5291
	ld e, a ; $5292
	call ApplyCutsceneBobOffset ; $5293
	ld c, $06 ; $5296
	ld b, $08 ; $5298
	call QueueSpriteTemplate ; $529a
	ld hl, QueueCutsceneSpriteGroupA_SpriteTemplate2 ; $529d
	ld a, [wCutsceneSpriteAX] ; $52a0
	ld d, a ; $52a3
	ld a, [wCutsceneSpriteAY] ; $52a4
	ld e, $20 ; $52a7
	add e ; $52a9
	ld e, a ; $52aa
	call ApplyCutsceneBobOffset ; $52ab
	ld c, $10 ; $52ae
	ld b, $08 ; $52b0
	call QueueSpriteTemplate ; $52b2
	ret ; $52b5
QueueCutsceneSpriteGroupA_SpriteTemplate0:
	; $52b6, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
QueueCutsceneSpriteGroupA_SpriteTemplate1:
	; $52c3, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
QueueCutsceneSpriteGroupA_SpriteTemplate2:
	; $52d8, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
QueueCutsceneSpriteGroupB:
	ld hl, QueueCutsceneSpriteGroupB_SpriteTemplate0 ; $52f9
	ld a, [wCutsceneSpriteBX] ; $52fc
	ld d, $18 ; $52ff
	add d ; $5301
	ld d, a ; $5302
	ld a, [wCutsceneSpriteBY] ; $5303
	ld e, a ; $5306
	call ApplyCutsceneBobOffset ; $5307
	ld c, $20 ; $530a
	ld b, $09 ; $530c
	call QueueSpriteTemplate ; $530e
	ld hl, QueueCutsceneSpriteGroupB_SpriteTemplate1 ; $5311
	ld a, [wCutsceneSpriteBX] ; $5314
	ld d, $08 ; $5317
	add d ; $5319
	ld d, a ; $531a
	ld a, [wCutsceneSpriteBY] ; $531b
	ld e, $10 ; $531e
	add e ; $5320
	ld e, a ; $5321
	call ApplyCutsceneBobOffset ; $5322
	ld c, $26 ; $5325
	ld b, $09 ; $5327
	call QueueSpriteTemplate ; $5329
	ld hl, QueueCutsceneSpriteGroupB_SpriteTemplate2 ; $532c
	ld a, [wCutsceneSpriteBX] ; $532f
	ld d, a ; $5332
	ld a, [wCutsceneSpriteBY] ; $5333
	ld e, $20 ; $5336
	add e ; $5338
	ld e, a ; $5339
	call ApplyCutsceneBobOffset ; $533a
	ld c, $38 ; $533d
	ld b, $09 ; $533f
	call QueueSpriteTemplate ; $5341
	ld hl, QueueCutsceneSpriteGroupB_SpriteTemplate3 ; $5344
	ld a, [wCutsceneSpriteBX] ; $5347
	ld d, $48 ; $534a
	add d ; $534c
	ld d, a ; $534d
	ld a, [wCutsceneSpriteBY] ; $534e
	ld e, $20 ; $5351
	add e ; $5353
	ld e, a ; $5354
	call ApplyCutsceneBobOffset ; $5355
	ld c, $48 ; $5358
	ld b, $09 ; $535a
	call QueueSpriteTemplate ; $535c
	ret ; $535f
QueueCutsceneSpriteGroupB_SpriteTemplate0:
	; $5360, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
QueueCutsceneSpriteGroupB_SpriteTemplate1:
	; $536d, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite_end
QueueCutsceneSpriteGroupB_SpriteTemplate2:
	; $5392, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
QueueCutsceneSpriteGroupB_SpriteTemplate3:
	; $53b3, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
ApplyCutsceneBobOffset:
	push hl ; $53b8
	ld a, [wCutsceneStepTimer] ; $53b9
	and $0f ; $53bc
	ld hl, CutsceneBobOffsetTable ; $53be
	add l ; $53c1
	ld l, a ; $53c2
	jr nc, .readOffset ; $53c3
	inc h ; $53c5
.readOffset:
	ld a, [hl] ; $53c6
	add e ; $53c7
	ld e, a ; $53c8
	pop hl ; $53c9
	ret ; $53ca
CutsceneBobOffsetTable:
	; $53cb, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $02, $03, $03, $04, $04, $04, $03, $03, $02, $01, $00, $00 ; 0x00
UpdateCutsceneScroll:
	ld a, [wCutsceneScrollX] ; $53db
	add $03 ; $53de
	ld [wCutsceneScrollX], a ; $53e0
	ldh [hScrollX], a ; $53e3
	ld a, [wIntroCutsceneSubState] ; $53e5
	sub $03 ; $53e8
	ld [wIntroCutsceneSubState], a ; $53ea
	ld [wRasterScrollX], a ; $53ed
	ret ; $53f0
