OpenChoiceTabPanel:
	ld a, b ; $5092
	or a ; $5093
	jr z, .close ; $5094
	ld c, $00 ; $5096
.openLoop:
	call AdvanceFrame ; $5098
	ld b, $10 ; $509b
	farcall RestoreMenuBgAndDrawPanel ; $509d
	ld b, $03 ; $50a0
	farcall FlushWram3MapRows ; $50a2
	ld a, c ; $50a5
	inc a ; $50a6
	ld c, a ; $50a7
	cp $0c ; $50a8
	jr nz, .openLoop ; $50aa
	ret ; $50ac
.close:
	ld c, $08 ; $50ad
.closeLoop:
	call AdvanceFrame ; $50af
	ld b, $11 ; $50b2
	farcall RestoreMenuBgAndDrawPanel ; $50b4
	ld b, $03 ; $50b7
	farcall FlushWram3MapRows ; $50b9
	ld a, c ; $50bc
	dec a ; $50bd
	ld c, a ; $50be
	cp $ff ; $50bf
	jr nz, .closeLoop ; $50c1
	ret ; $50c3
CloseChoiceTabPanel:
	ld a, b ; $50c4
	or a ; $50c5
	jr z, .close ; $50c6
	ld c, $00 ; $50c8
.openLoop:
	call AdvanceFrame ; $50ca
	ld b, $11 ; $50cd
	farcall RestoreMenuBgAndDrawPanel ; $50cf
	ld b, $03 ; $50d2
	farcall FlushWram3MapRows ; $50d4
	ld a, c ; $50d7
	inc a ; $50d8
	ld c, a ; $50d9
	cp $0a ; $50da
	jr nz, .openLoop ; $50dc
	ret ; $50de
.close:
	ld c, $0c ; $50df
.closeLoop:
	call AdvanceFrame ; $50e1
	ld b, $10 ; $50e4
	farcall RestoreMenuBgAndDrawPanel ; $50e6
	ld b, $03 ; $50e9
	farcall FlushWram3MapRows ; $50eb
	ld a, c ; $50ee
	dec a ; $50ef
	ld c, a ; $50f0
	or a ; $50f1
	jr nz, .closeLoop ; $50f2
	ret ; $50f4
ChoiceTabCursorSpriteTask:
	farcall TickMenuBgScroll ; $50f5
	ld c, $02 ; $50f8
	call GetMenuCursorIndex_3e ; $50fa
	push af ; $50fd
	ld hl, ChoiceTabCursorTiles_3e ; $50fe
	add l ; $5101
	ld l, a ; $5102
	jr nc, .read ; $5103
	inc h ; $5105
.read:
	ld c, [hl] ; $5106
	pop af ; $5107
	ld hl, ChoiceTabCursorPositions_3e ; $5108
	add a ; $510b
	add l ; $510c
	ld l, a ; $510d
	jr nc, .readB ; $510e
	inc h ; $5110
.readB:
	ld a, [hl+] ; $5111
	ld d, [hl] ; $5112
	ld e, a ; $5113
	farcall ApplySpriteBobOffset ; $5114
	ld b, $08 ; $5117
	ld hl, ChoiceTabCursorSpriteTask_SpriteTemplate0 ; $5119
	push de ; $511c
	call QueueSpriteTemplate ; $511d
	pop de ; $5120
	ld hl, $17f8 ; $5121
	add hl, de ; $5124
	ld d, h ; $5125
	ld e, l ; $5126
	ld hl, ChoiceTabCursorSpriteTask_SpriteTemplate1 ; $5127
	ld b, $08 ; $512a
	ld c, $70 ; $512c
	call QueueSpriteTemplate ; $512e
	ret ; $5131
ChoiceTabCursorSpriteTask_SpriteTemplate0:
	; $5132, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
ChoiceTabCursorSpriteTask_SpriteTemplate1:
	; $5153, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
ChoiceTabCursorPositions_3e:
	; $515c, 6 bytes (bytes:6)
	db $50, $0c, $50, $54, $50, $5c ; 0x00
ChoiceTabCursorTiles_3e:
	; $5162, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
SetChoiceTabAttrRect:
	push af ; $5165
	push bc ; $5166
	push de ; $5167
	push hl ; $5168
	ld a, c ; $5169
	or a ; $516a
	jr z, .inactiveAttr ; $516b
	ld h, $0c ; $516d
	jr .lookup ; $516f
.inactiveAttr:
	ld h, $0d ; $5171
.lookup:
	push hl ; $5173
	ld hl, ChoiceTabAttrAddrs_3e ; $5174
	ld a, b ; $5177
	add a ; $5178
	add l ; $5179
	ld l, a ; $517a
	jr nc, .readAddr ; $517b
	inc h ; $517d
.readAddr:
	ld a, [hl+] ; $517e
	ld d, [hl] ; $517f
	ld e, a ; $5180
	pop hl ; $5181
	ld b, $05 ; $5182
	ld c, $03 ; $5184
	farcall FillTilemapRect ; $5186
	pop hl ; $5189
	pop de ; $518a
	pop bc ; $518b
	pop af ; $518c
	ret ; $518d
ChoiceTabAttrAddrs_3e:
	; $518e, 4 bytes (bytes:4)
	db $e3, $d4, $ec, $d4 ; 0x00
RunPlayAlonePartnerMenu:
	sound BGM_MENU ; $5192
	ld hl, rIE ; $5194
	res 2, [hl] ; $5197
	call LoadPlayAlonePartnerGraphics ; $5199
	wram_bank $03 ; $519c
	ld a, [wMenuSlideDirection] ; $51a2
	ld b, a ; $51a5
	call OpenChoiceTabPanel ; $51a6
	farcall InitMenuBgScroll ; $51a9
	ld b, $01 ; $51ac
	ld c, $01 ; $51ae
	farcall LoadMenuSpritePalettePair ; $51b0
	xor a ; $51b3
	ld c, a ; $51b4
	ld b, $02 ; $51b5
	call SetMenuCursorFromIndex_3e ; $51b7
	ld a, $01 ; $51ba
	ld hl, ChoiceTabCursorSpriteTask ; $51bc
	call RegisterFrameTask ; $51bf
	call RedrawPlayAlonePartnerMenu ; $51c2
	wram_bank $03 ; $51c5
.loop:
	call AdvanceFrame ; $51cb
	ldh a, [hInputPressed] ; $51ce
	ld [wMenuInputPressed], a ; $51d0
	ld b, $02 ; $51d3
	ld c, $01 ; $51d5
	call MoveMenuCursorGrid_3e ; $51d7
	or a ; $51da
	jr z, .checkMenuInputPressed ; $51db
	sound SFX_MENU_MOVE ; $51dd
	call RedrawPlayAlonePartnerMenu ; $51df
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $51e2
	bit PADB_A, a ; $51e5
	jr nz, .playSfx ; $51e7
	bit 1, a ; $51e9
	jr nz, .playSfx2 ; $51eb
	jr .loop ; $51ed
.playSfx:
	sound SFX_MENU_SELECT ; $51ef
	call ClearFrameTasks ; $51f1
	ld hl, rIE ; $51f4
	set 2, [hl] ; $51f7
	ld b, $01 ; $51f9
	call CloseChoiceTabPanel ; $51fb
	ld a, MENUSLIDE_FORWARD ; $51fe
	ld [wMenuSlideDirection], a ; $5200
	ld c, $02 ; $5203
	call GetMenuCursorIndex_3e ; $5205
	clear_flag FLAG_DOUBLES ; $5208
	or a ; $520b
	jr z, .done ; $520c
	set_flag FLAG_DOUBLES ; $520e
.done:
	ret ; $5211
.playSfx2:
	sound SFX_MENU_CANCEL ; $5212
	call ClearFrameTasks ; $5214
	ld hl, rIE ; $5217
	set 2, [hl] ; $521a
	ld b, $00 ; $521c
	call CloseChoiceTabPanel ; $521e
	ld a, MENUSLIDE_BACK ; $5221
	ld [wMenuSlideDirection], a ; $5223
	ld a, $ff ; $5226
	ret ; $5228
LoadPlayAlonePartnerGraphics:
	push_wram_bank $01 ; $5229
	ld c, $00 ; $5232
.loop:
	ld a, c ; $5234
	add a ; $5235
	ld hl, PlayAlonePartnerGfxParams_3e ; $5236
	add l ; $5239
	ld l, a ; $523a
	jr nc, .read ; $523b
	inc h ; $523d
.read:
	ld a, [hl+] ; $523e
	ld h, [hl] ; $523f
	ld l, a ; $5240
	push af ; $5241
	push bc ; $5242
	push de ; $5243
	push hl ; $5244
	ld de, wDecompBuffer ; $5245
	call DecompressDataFromBank ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	pop af ; $524e
	ld hl, PlayAlonePartnerGfxDests_3e ; $524f
	ld a, c ; $5252
	add a ; $5253
	add l ; $5254
	ld l, a ; $5255
	jr nc, .readB ; $5256
	inc h ; $5258
.readB:
	ld a, [hl+] ; $5259
	ld d, [hl] ; $525a
	ld e, a ; $525b
	ld hl, wDecompBuffer ; $525c
	push af ; $525f
	push bc ; $5260
	push de ; $5261
	push hl ; $5262
	ld bc, $0010 ; $5263
	call QueueVRAMCopy ; $5266
	pop hl ; $5269
	pop de ; $526a
	pop bc ; $526b
	pop af ; $526c
	ld a, c ; $526d
	inc a ; $526e
	ld c, a ; $526f
	call AdvanceFrame ; $5270
	ld a, c ; $5273
	cp $02 ; $5274
	jr nz, .loop ; $5276
	ld b, TILEBLOCK_SharedMenuGfx35 ; $5278
	ld c, SharedMenuGfx35_SIZE / 16 ; $527a
	ld de, vTiles0 + VRAM_BANK1 ; $527c
	farcall LoadCompressedTileBlock ; $527f
	call AdvanceFrame ; $5282
	ld b, TILEBLOCK_SharedMenuGfx36 ; $5285
	ld c, SharedMenuGfx36_SIZE / 16 ; $5287
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $5289
	farcall LoadCompressedTileBlock ; $528c
	call AdvanceFrame ; $528f
	ld b, TILEBLOCK_SharedMenuGfx27 ; $5292
	ld c, SharedMenuGfx27_SIZE / 16 ; $5294
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $5296
	farcall LoadCompressedTileBlock ; $5299
	call AdvanceFrame ; $529c
	call AdvanceFrame ; $529f
	ld b, $08 ; $52a2
	ld c, $10 ; $52a4
	farcall LoadIndexedPalette ; $52a6
	pop_wram_bank ; $52a9
	ret ; $52ae
PlayAlonePartnerGfxParams_3e:
	; $52af, 4 bytes (bytes:4)
	db $62, $3c, $64, $3c ; 0x00
PlayAlonePartnerGfxDests_3e:
	; $52b3, 4 bytes (bytes:4)
	db $00, $a8, $00, $a9 ; 0x00
RedrawPlayAlonePartnerMenu:
	wram_bank $03 ; $52b7
	ld b, $00 ; $52bd
	ld c, $00 ; $52bf
.loop:
	call SetChoiceTabAttrRect ; $52c1
	ld a, b ; $52c4
	inc a ; $52c5
	ld b, a ; $52c6
	cp $03 ; $52c7
	jr nz, .loop ; $52c9
	ld c, $02 ; $52cb
	call GetMenuCursorIndex_3e ; $52cd
	ld b, a ; $52d0
	ld c, $01 ; $52d1
	call SetChoiceTabAttrRect ; $52d3
	ld c, $02 ; $52d6
	call GetMenuCursorIndex_3e ; $52d8
	call SetPlayAlonePartnerPalette ; $52db
	wram_bank $03 ; $52de
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $52e4
	ld b, $14 ; $52e7
	ld c, $01 ; $52e9
	ld h, $03 ; $52eb
	farcall FillTilemapRect ; $52ed
	ld a, $02 ; $52f0
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $52f2
	ld a, $04 ; $52f5
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $52f7
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $52fa
	ld b, $12 ; $52fd
	ld c, $01 ; $52ff
	ld h, $20 ; $5301
	farcall FillTilemapRect ; $5303
	call DrawPlayAlonePartnerCaption ; $5306
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $5309
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $530c
	ld c, $06 ; $530f
	call QueueVRAMCopy ; $5311
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $5314
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $5317
	ld c, $04 ; $531a
	call QueueVRAMCopy ; $531c
	ret ; $531f
SetPlayAlonePartnerPalette:
	ld hl, PlayAlonePartnerPalettePtrs ; $5320
	add a ; $5323
	add l ; $5324
	ld l, a ; $5325
	jr nc, .read ; $5326
	inc h ; $5328
.read:
	ld a, [hl+] ; $5329
	ld h, [hl] ; $532a
	ld l, a ; $532b
	lb de, $04, $01 ; $532c palette index, count
	call LoadPaletteShadow ; $532f
	ret ; $5332
PlayAlonePartnerPalettePtrs:
	; $5333, 18 bytes (records:2)
	dw PlayAlonePartnerPalette ; record 0
	dw PlayAlonePartnerPalette ; record 1
	dw PlayAlonePartnerPalette ; record 2
	dw PlayAlonePartnerPalette ; record 3
	dw PlayAlonePartnerPalette ; record 4
	dw PlayAlonePartnerPalette ; record 5
	dw PlayAlonePartnerPalette ; record 6
	dw PlayAlonePartnerPalette ; record 7
	dw PlayAlonePartnerPalette ; record 8
PlayAlonePartnerPalette:
	; $5345, 16 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
	db $0a, $03, $ff, $7f, $40, $51, $00, $00 ; 0x08
DrawPlayAlonePartnerCaption:
	push_wram_bank $03 ; $5355
	ld c, $02 ; $535e
	call GetMenuCursorIndex_3e ; $5360
	ld b, a ; $5363
	ld hl, PlayAlonePartnerCaptionDests_3e ; $5364
	add a ; $5367
	add l ; $5368
	ld l, a ; $5369
	jr nc, .read ; $536a
	inc h ; $536c
.read:
	ld a, [hl+] ; $536d
	ld d, [hl] ; $536e
	ld e, a ; $536f
	ld a, b ; $5370
	ld hl, $00e2 ; $5371
	add l ; $5374
	ld l, a ; $5375
	jr nc, .renderTextToBuffer64 ; $5376
	inc h ; $5378
.renderTextToBuffer64:
	ld c, $20 ; $5379
	farcall RenderTextToBuffer64 ; $537b
	pop_wram_bank ; $537e
	ret ; $5383
PlayAlonePartnerCaptionDests_3e:
	; $5384, 4 bytes (bytes:4)
	db $01, $d2, $01, $d2 ; 0x00
ShowEquipmentStatusScreen:
	call ClearFrameTasks ; $5388
	ld c, $10 ; $538b
	call BeginFadeOut ; $538d
	call WaitFadeEnd ; $5390
	call AdvanceFrame ; $5393
	call AdvanceFrame ; $5396
	call DisableLCDSafely ; $5399
	farcall LoadMenuFontGfx ; $539c
	xor a ; $539f
	ldh [hScrollX], a ; $53a0
	ldh [hScrollY], a ; $53a2
	call DrawEquipmentStatusScreen ; $53a4
	call EnableLCD ; $53a7
	script_fade_in $10 ; $53aa
	call WaitFadeEnd ; $53af
.inputLoop:
	ldh a, [hInputPressed] ; $53b2
	bit PADB_A, a ; $53b4
	jr nz, .exit ; $53b6
	bit 1, a ; $53b8
	jr nz, .exit ; $53ba
	call AdvanceFrame ; $53bc
	jr .inputLoop ; $53bf
.exit:
	sound SFX_MENU_SELECT ; $53c1
	call ClearFrameTasks ; $53c3
	ld c, $10 ; $53c6
	call BeginFadeOut ; $53c8
	call WaitFadeEnd ; $53cb
	ret ; $53ce
DrawEquipmentStatusScreen:
	call LoadEquipmentStatusWindows ; $53cf
	farcall PrepareGlyphBuffer ; $53d2
	wram_bank $03 ; $53d5
	ld hl, wScreenScratch ; $53db
	ld bc, $0003 ; $53de
	call ClearMemory16 ; $53e1
	call DrawEquippedRacketPanel ; $53e4
	call DrawEquippedShoesPanel ; $53e7
	farcall UploadGlyphBuffer ; $53ea
	farcall QueueWram3MapToVRAM ; $53ed
	ret ; $53f0
LoadEquipmentStatusWindows:
	ld c, SCREENASSET_EquipmentSelect ; $53f1
	farcall LoadScreenAssetRecord ; $53f3
	farcall ResetTextWindowState ; $53f6
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $53f9
	ld c, SharedMenuGfx17_SIZE / 16 ; $53fb
	ld de, vTiles2 ; $53fd
	farcall LoadCompressedTileBlock ; $5400
	wram_bank $05 ; $5403
	ld a, $03 ; $5409
	ld [wShadowTilemapBank], a ; $540b
	ld a, $00 ; $540e
	ld [wWindowTileAttr], a ; $5410
	ld d, $00 ; $5413
	ld e, $00 ; $5415
	ld b, $14 ; $5417
	ld c, $09 ; $5419
	farcall CreateWindowFromScreenRect ; $541b
	farcall DrawTextWindowFrame ; $541e
	farcall RedrawWindowRows ; $5421
	ld d, $00 ; $5424
	ld e, $09 ; $5426
	ld b, $14 ; $5428
	ld c, $09 ; $542a
	farcall CreateWindowFromScreenRect ; $542c
	farcall DrawTextWindowFrame ; $542f
	farcall RedrawWindowRows ; $5432
	call SetEquipmentStatusAttrRects ; $5435
	ret ; $5438
SetEquipmentStatusAttrRects:
	wram_bank $03 ; $5439
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 1 ; $543f
	ld b, $12 ; $5442
	ld c, $05 ; $5444
	ld h, $08 ; $5446
	farcall FillTilemapRect ; $5448
	ld de, wShadowAttrmap + 3 * TILEMAP_WIDTH + 1 ; $544b
	ld b, $12 ; $544e
	ld c, $05 ; $5450
	ld h, $08 ; $5452
	farcall FillTilemapRect ; $5454
	ret ; $5457
