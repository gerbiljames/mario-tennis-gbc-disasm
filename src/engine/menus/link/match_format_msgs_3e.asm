DrawSinglesDoublesRow:
	ld b, MATCHFMTOPT_SINGLES ; $4817
	ld c, ATTRRECT_INACTIVE ; $4819
	call SetLinkMatchFormatOptionAttrRect ; $481b
	ld b, MATCHFMTOPT_DOUBLES ; $481e
	ld c, ATTRRECT_INACTIVE ; $4820
	call SetLinkMatchFormatOptionAttrRect ; $4822
	ld a, [wMatchFormatDoubles] ; $4825
	ld b, a ; $4828
	ld c, ATTRRECT_SELECTED ; $4829
	call SetLinkMatchFormatOptionAttrRect ; $482b
	ret ; $482e
DrawGameCountRow:
	ld b, MATCHFMTOPT_GAMES ; $482f
	ld c, ATTRRECT_INACTIVE ; $4831
	call SetLinkMatchFormatOptionAttrRect ; $4833
	ld b, MATCHFMTOPT_GAMES + 1 ; $4836
	ld c, ATTRRECT_INACTIVE ; $4838
	call SetLinkMatchFormatOptionAttrRect ; $483a
	ld a, [wMatchFormatGames] ; $483d
	add MATCHFMTOPT_GAMES ; $4840
	ld b, a ; $4842
	ld c, ATTRRECT_SELECTED ; $4843
	call SetLinkMatchFormatOptionAttrRect ; $4845
	ret ; $4848
DrawSetCountRow:
	ld b, MATCHFMTOPT_SETS ; $4849
	ld c, ATTRRECT_INACTIVE ; $484b
	call SetLinkMatchFormatOptionAttrRect ; $484d
	ld b, MATCHFMTOPT_SETS + 1 ; $4850
	ld c, ATTRRECT_INACTIVE ; $4852
	call SetLinkMatchFormatOptionAttrRect ; $4854
	ld b, MATCHFMTOPT_SETS + 2 ; $4857
	ld c, ATTRRECT_INACTIVE ; $4859
	call SetLinkMatchFormatOptionAttrRect ; $485b
	ld a, [wMatchFormatSets] ; $485e
	add MATCHFMTOPT_SETS ; $4861
	ld b, a ; $4863
	ld c, ATTRRECT_SELECTED ; $4864
	call SetLinkMatchFormatOptionAttrRect ; $4866
	ret ; $4869
SetLinkMatchFormatOptionAttrRect:
	push af ; $486a
	push bc ; $486b
	push de ; $486c
	push hl ; $486d
	push_wram_bank WRAM_SCREEN ; $486e
	ld hl, LinkMatchFormatOptionAttrAddrs_3e ; $4877
	ld a, b ; $487a
	add a ; $487b
	add_hl_a ; $487c
	ld a, [hl+] ; $4881
	ld d, [hl] ; $4882
	ld e, a ; $4883
	ld h, $0d ; $4884
	ld a, c ; $4886
	or a ; $4887
	jr z, .fill ; $4888
	ld a, b ; $488a
	ld hl, LinkMatchFormatOptionAttrWidths_3e ; $488b
	add_hl_a ; $488e
	ld a, [hl] ; $4893
	ld h, a ; $4894
.fill:
	rect_size $05, $03 ; $4895
	farcall FillTilemapRect ; $4899
	pop_wram_bank ; $489c
	pop hl ; $48a1
	pop de ; $48a2
	pop bc ; $48a3
	pop af ; $48a4
	ret ; $48a5
LinkMatchFormatOptionAttrAddrs_3e:
	; $48a6, 14 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 3 ; record 0
	dw wShadowAttrmap + 3 * TILEMAP_WIDTH + 12 ; record 1
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 3 ; record 2
	dw wShadowAttrmap + 7 * TILEMAP_WIDTH + 12 ; record 3
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 7 ; record 5
	dw wShadowAttrmap + 11 * TILEMAP_WIDTH + 13 ; record 6
LinkMatchFormatOptionAttrWidths_3e:
	; $48b4, 7 bytes (bytes:7)
	db $0c, $0c, $0e, $0e, $0f, $0f, $0f ; 0x00
	twin_named flush_match_format_row_to_vram, FlushLinkMatchFormatRowAttrs ; $48bb
LinkMatchFormatCursorSpriteTask:
	ld c, $01 ; $48f1
	call GetMenuCursorIndex_3e ; $48f3
	or a ; $48f6
	jr nz, .compare ; $48f7
	ld a, [wMatchFormatDoubles] ; $48f9
	jr .gotRuleValue ; $48fc
.compare:
	cp MATCHFMTROW_GAMES ; $48fe
	jr nz, .checkMatchFormatSets ; $4900
	ld a, [wMatchFormatGames] ; $4902
	add MATCHFMTOPT_GAMES ; $4905
	jr .gotRuleValue ; $4907
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $4909
	add MATCHFMTOPT_SETS ; $490c
.gotRuleValue:
	push af ; $490e
	ld hl, LinkMatchFormatCursorTiles_3e ; $490f
	add_hl_a ; $4912
	ld c, [hl] ; $4917
	pop af ; $4918
	ld hl, LinkMatchFormatCursorPositions_3e ; $4919
	add a ; $491c
	add_hl_a ; $491d
	ld a, [hl+] ; $4922
	ld d, [hl] ; $4923
	ld e, a ; $4924
	farcall ApplySpriteBobOffset ; $4925
	ld b, OAM_BANK1 ; $4928
	ld hl, LinkMatchFormatCursorSpriteTask_SpriteTemplate0 ; $492a
	push de ; $492d
	call QueueSpriteTemplate ; $492e
	pop de ; $4931
	ld hl, $17f8 ; $4932
	add hl, de ; $4935
	ld d, h ; $4936
	ld e, l ; $4937
	ld hl, LinkMatchFormatCursorSpriteTask_SpriteTemplate1 ; $4938
	sprite_attr_tile OAM_BANK1, $70 ; $493b
	call QueueSpriteTemplate ; $493f
	ret ; $4942
LinkMatchFormatCursorSpriteTask_SpriteTemplate0:
	; $4943, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
LinkMatchFormatCursorSpriteTask_SpriteTemplate1:
	; $4964, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LinkMatchFormatCursorPositions_3e:
	; $496d, 14 bytes (bytes:14)
	db $2d, $0a, $2d, $54, $4f, $0c, $4f, $54, $6a, $00, $6a, $2c, $6a, $5d ; 0x00
LinkMatchFormatCursorTiles_3e:
	; $497b, 7 bytes (bytes:7)
	db $00, $10, $20, $30, $40, $50, $60 ; 0x00
DrawLinkMatchFormatCaption:
	wram_bank WRAM_SCREEN ; $4982
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $4988
	rect_size $14, $01 ; $498b
	ld h, $03 ; $498f
	farcall FillTilemapRect ; $4991
	ld a, $02 ; $4994
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $4996
	ld a, $04 ; $4999
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $499b
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $499e
	rect_size $12, $01 ; $49a1
	ld h, $20 ; $49a5
	farcall FillTilemapRect ; $49a7
	farcall RenderMatchFormatOptionText ; $49aa
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $49ad
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $49b0
	ld c, 2 * TILEMAP_WIDTH / 16 ; $49b3
	call QueueVRAMCopy ; $49b5
	ret ; $49b8
Unused_3e_DrawLinkMatchFormatCaptionText:
	wram_bank WRAM_SCREEN ; $49b9
	ld c, $01 ; $49bf
	call GetMenuCursorIndex_3e ; $49c1
	ld b, a ; $49c4
	add a ; $49c5
	ld hl, LinkMatchFormatCaptionDests_3e ; $49c6
	add_hl_a ; $49c9
	ld a, [hl+] ; $49ce
	ld d, [hl] ; $49cf
	ld e, a ; $49d0
	ld a, b ; $49d1
	ld hl, Text_MatchTypeSinglesOrDoubles ; $49d2
	add_hl_a ; $49d5
	ld c, $20 ; $49da
	farcall RenderTextToBuffer64 ; $49dc
	ret ; $49df
LinkMatchFormatCaptionDests_3e:
	; $49e0, 6 bytes (ram_ptrs:3)
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 2
ShowLinkMessageScreen:
	push af ; $49e6
	push bc ; $49e7
	push de ; $49e8
	push hl ; $49e9
	ldh a, [hWramBank] ; $49ea
	push af ; $49ec
	call DisableLCDSafely ; $49ed
	call ClearFrameTasks ; $49f0
	call LoadLinkMessageScreen ; $49f3
	xor a ; $49f6
	ld [wAnimatedTileSet], a ; $49f7
	ld a, $03 ; $49fa
	ld [wAnimatedTilePeriod], a ; $49fc
	call EnableLCD ; $49ff
	script_fade_in 8 ; $4a02
	call WaitFadeEnd ; $4a07
	pop_wram_bank ; $4a0a
	pop hl ; $4a0f
	pop de ; $4a10
	pop bc ; $4a11
	pop af ; $4a12
	ret ; $4a13
LoadLinkMessageScreen:
	ld c, SCREENASSET_LinkingScreen ; $4a14
	farcall LoadScreenAssetRecord ; $4a16
	farcall ResetTextWindowState ; $4a19
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4a1c
	ld c, SharedMenuGfx17_SIZE / 16 ; $4a1e
	ld de, vTiles2 ; $4a20
	farcall LoadCompressedTileBlock ; $4a23
	wram_bank WRAM_TEXT ; $4a26
	ld a, WRAM_SCREEN ; $4a2c
	ld [wShadowTilemapBank], a ; $4a2e
	ld a, $00 ; $4a31
	ld [wWindowTileAttr], a ; $4a33
	rect_cell $00, $0b ; $4a36
	rect_size $14, $07 ; $4a3a
	farcall CreateWindowFromScreenRect ; $4a3e
	farcall DrawTextWindowFrame ; $4a41
	farcall RedrawWindowRows ; $4a44
	wram_bank WRAM_SCREEN ; $4a47
	farcall PrepareGlyphBuffer ; $4a4d
	farcall QueueWram3MapToVRAM ; $4a50
	ret ; $4a53
AnimateLinkStatusPalette:
	push af ; $4a54
	push bc ; $4a55
	push de ; $4a56
	push hl ; $4a57
	ldh a, [hVBlankCounter] ; $4a58
	and $1c ; $4a5a
	srl a ; $4a5c
	srl a ; $4a5e
	ld hl, AnimateLinkStatusPalettePtrs ; $4a60
	add a ; $4a63
	add_hl_a ; $4a64
	ld a, [hl+] ; $4a69
	ld h, [hl] ; $4a6a
	ld l, a ; $4a6b
	ld_bg_pals de, 5, 1 ; $4a6c
	call LoadPaletteShadow ; $4a6f
	pop hl ; $4a72
	pop de ; $4a73
	pop bc ; $4a74
	pop af ; $4a75
	ret ; $4a76
AnimateLinkStatusPalettePtrs:
	; $4a77, 16 bytes (records:2)
	dw LinkStatusPalette0 ; record 0
	dw LinkStatusPalette0 ; record 1
	dw LinkStatusPalette1 ; record 2
	dw LinkStatusPalette1 ; record 3
	dw LinkStatusPalette2 ; record 4
	dw LinkStatusPalette2 ; record 5
	dw LinkStatusPalette3 ; record 6
	dw LinkStatusPalette3 ; record 7
LinkStatusPalette0:
	INCLUDE "data/engine/menus/link/LinkStatusPalette0.asm" ; $4a87, 8 bytes (palettes)
LinkStatusPalette1:
	INCLUDE "data/engine/menus/link/LinkStatusPalette1.asm" ; $4a8f, 8 bytes (palettes)
LinkStatusPalette2:
	INCLUDE "data/engine/menus/link/LinkStatusPalette2.asm" ; $4a97, 8 bytes (palettes)
LinkStatusPalette3:
	INCLUDE "data/engine/menus/link/LinkStatusPalette3.asm" ; $4a9f, 8 bytes (palettes)
ShowLinkErrorScreen:
	call InitSerialLink ; $4aa7
	call DisableLCDSafely ; $4aaa
	call ClearFrameTasks ; $4aad
	call ClearBothSpriteBuffers ; $4ab0
	xor a ; $4ab3
	ldh [hScrollX], a ; $4ab4
	ldh [hScrollY], a ; $4ab6
	call LoadLinkErrorScreen ; $4ab8
	xor a ; $4abb
	ld [wAnimatedTileSet], a ; $4abc
	ld a, $05 ; $4abf
	ld [wAnimatedTilePeriod], a ; $4ac1
	call EnableLCD ; $4ac4
	script_fade_in 8 ; $4ac7
	call WaitFadeEnd ; $4acc
.loop:
	call AdvanceFrame ; $4acf
	call AnimateLinkErrorPalette ; $4ad2
	ldh a, [hInputRisingEdge] ; $4ad5
	or a ; $4ad7
	jr z, .loop ; $4ad8
	call ClearFrameTasks ; $4ada
	ret ; $4add
LoadLinkErrorScreen:
	ld c, SCREENASSET_LinkError ; $4ade
	farcall LoadScreenAssetRecord ; $4ae0
	farcall ResetTextWindowState ; $4ae3
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $4ae6
	ld c, SharedMenuGfx17_SIZE / 16 ; $4ae8
	ld de, vTiles2 ; $4aea
	farcall LoadCompressedTileBlock ; $4aed
	wram_bank WRAM_TEXT ; $4af0
	ld a, WRAM_SCREEN ; $4af6
	ld [wShadowTilemapBank], a ; $4af8
	ld a, $00 ; $4afb
	ld [wWindowTileAttr], a ; $4afd
	rect_cell $00, $0d ; $4b00
	rect_size $14, $05 ; $4b04
	farcall CreateWindowFromScreenRect ; $4b08
	farcall DrawTextWindowFrame ; $4b0b
	farcall RedrawWindowRows ; $4b0e
	farcall PrepareGlyphBuffer ; $4b11
	wram_bank WRAM_SCREEN ; $4b14
	ld hl, Text_LinkCheckGameLink ; $4b1a
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; $4b1d
	ld c, $12 ; $4b20
	farcall RenderProportionalTextAt ; $4b22
	ld hl, Text_LinkCableConnection ; $4b25
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $4b28
	ld c, $12 ; $4b2b
	farcall RenderProportionalTextAt ; $4b2d
	farcall UploadGlyphBuffer ; $4b30
	farcall QueueWram3MapToVRAM ; $4b33
	ret ; $4b36
AnimateLinkErrorPalette:
	push_wram_bank WRAM_SCREEN ; $4b37
	ld hl, LinkErrorPalette_3e ; $4b40
	ld de, wLinkErrorPalette ; $4b43
	ld bc, wLinkErrorPalette_SIZE ; $4b46
	call CopyMemoryBC ; $4b49
	ldh a, [hVBlankCounter] ; $4b4c
	and $3c ; $4b4e
	srl a ; $4b50
	srl a ; $4b52
	add a ; $4b54
	jr nc, .notNegative ; $4b55
	ld a, $0c ; $4b57
	dec a ; $4b59
	jr .gotFlashIndex ; $4b5a
.notNegative:
	rra ; $4b5c
	cp $0c ; $4b5d
	jr c, .gotFlashIndex ; $4b5f
	xor a ; $4b61
.gotFlashIndex:
	add a ; $4b62
	ld hl, LinkErrorFlashColors_3e ; $4b63
	add_hl_a ; $4b66
	ld a, [hl+] ; $4b6b
	ld d, [hl] ; $4b6c
	ld e, a ; $4b6d
	ld hl, wLinkErrorPalette + 2 ; $4b6e
	ld [hl], e ; $4b71
	inc hl ; $4b72
	ld [hl], d ; $4b73
	ld hl, wLinkErrorPalette ; $4b74
	ld_bg_pals de, 3, 1 ; $4b77
	call LoadPaletteShadow ; $4b7a
	pop_wram_bank ; $4b7d
	ret ; $4b82
LinkErrorPalette_3e:
	INCLUDE "data/engine/menus/link/LinkErrorPalette_3e.asm" ; $4b83, 8 bytes (palettes)
LinkErrorFlashColors_3e:
	INCLUDE "data/engine/menus/link/LinkErrorFlashColors_3e.asm" ; $4b8b, 24 bytes (palettes)
ShowLinkStatusMessage:
	push bc ; $4ba3
	wram_bank WRAM_SCREEN ; $4ba4
	call ClearLinkMessageWindow ; $4baa
	farcall PrepareGlyphBuffer ; $4bad
	wram_bank WRAM_SCREEN ; $4bb0
	pop bc ; $4bb6
	ld a, c ; $4bb7
	or a ; $4bb8
	jr z, .message0 ; $4bb9
	cp $01 ; $4bbb
	jr z, .message1 ; $4bbd
	jr .renderProportionalTextAt ; $4bbf
.message0:
	ld hl, Text_LinkOtherPlayerNotReady ; $4bc1
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bc4
	ld c, $12 ; $4bc7
	farcall RenderProportionalTextAt ; $4bc9
	jr .uploadGlyphBuffer ; $4bcc
.message1:
	ld hl, Text_LinkImproperlyLinked ; $4bce
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bd1
	ld c, $12 ; $4bd4
	farcall RenderProportionalTextAt ; $4bd6
	jr .uploadGlyphBuffer ; $4bd9
.renderProportionalTextAt:
	ld hl, Text_LinkWaitingForOtherPlayer ; $4bdb
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bde
	ld c, $12 ; $4be1
	farcall RenderProportionalTextAt ; $4be3
.uploadGlyphBuffer:
	farcall UploadGlyphBuffer ; $4be6
	call FlushLinkMessageRows ; $4be9
	ret ; $4bec
ClearLinkMessageWindow:
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $4bed
	rect_size $12, $01 ; $4bf0
	ld h, $03 ; $4bf4
	farcall FillTilemapRect ; $4bf6
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bf9
	rect_size $12, $05 ; $4bfc
	ld h, $20 ; $4c00
	farcall FillTilemapRect ; $4c02
	ret ; $4c05
	twin_named queue_caption_row_to_vram, FlushLinkMessageRows ; $4c06
