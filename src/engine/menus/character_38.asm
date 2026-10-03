RunCharacterSelectScreen:
	sound BGM_MENU ; $47c7
	wram_bank WRAM_COURT_PLANES ; $47c9
	ld a, b ; $47cf
	ld [wCharSelectIsPartner], a ; $47d0
	wram_bank WRAM_CHAR3 ; $47d3
	ld hl, wCharPosX ; $47d9
	ld c, $10 ; $47dc
	call ClearMemory16 ; $47de
	wram_bank WRAM_CHAR2 ; $47e1
	ld hl, wCharPosX ; $47e7
	ld c, $10 ; $47ea
	call ClearMemory16 ; $47ec
	wram_bank WRAM_CHAR1 ; $47ef
	ld hl, wCharPosX ; $47f5
	ld c, $10 ; $47f8
	call ClearMemory16 ; $47fa
	wram_bank WRAM_CHAR0 ; $47fd
	ld hl, wCharPosX ; $4803
	ld c, $10 ; $4806
	call ClearMemory16 ; $4808
	farcall ResetMatchState ; $480b
	call ClearFrameTasks ; $480e
	xor a ; $4811
	ld [wCharSelectIdleAnimState], a ; $4812
	ld [wCharSelectHandedness], a ; $4815
	ld [wCharSelectIdleTimer], a ; $4818
	call DisableLCDSafely ; $481b
	call ClearFrameTasks ; $481e
	call SetupCharacterSelectScreen ; $4821
	call DrawCharacterSelectChars ; $4824
	ld a, $01 ; $4827
	ld hl, UpdateAnimatedTilesTask_38 ; $4829
	call RegisterFrameTask ; $482c
	ld a, $01 ; $482f
	ld hl, DrawCharacterSelectChars ; $4831
	call RegisterFrameTask ; $4834
	ld a, $01 ; $4837
	ld hl, DrawCharacterSelectCursor ; $4839
	call RegisterFrameTask ; $483c
	call EnableLCD ; $483f
	script_fade_in 8 ; $4842
	call WaitFadeEnd ; $4847
	ld hl, rIE ; $484a
	res 2, [hl] ; $484d
	ld a, $01 ; $484f
	ld hl, TickMenuBgScrollTask_38 ; $4851
	call RegisterFrameTask ; $4854
.redraw:
	ldh a, [hInputPressed] ; $4857
	ld [wMenuInputPressed], a ; $4859
	ld b, $02 ; $485c
	ld c, $01 ; $485e
	call MoveMenuCursorGrid_38 ; $4860
	or a ; $4863
	jr z, .inputLoop ; $4864
	call RefreshCharacterSelectHighlight ; $4866
.inputLoop:
	call AdvanceFrame ; $4869
	ldh a, [hInputPressed] ; $486c
	bit PADB_A, a ; $486e
	jr nz, .confirm ; $4870
	bit 1, a ; $4872
	jr nz, .cancel ; $4874
	bit 3, a ; $4876
	jr nz, .viewStats ; $4878
	jr .redraw ; $487a
.confirm:
	sound SFX_MENU_SELECT ; $487c
	ld c, 16 ; $487e
	call BeginFadeOut ; $4880
	call WaitFadeEnd ; $4883
	ld c, $02 ; $4886
	call GetMenuCursorIndex_38 ; $4888
	push af ; $488b
	wram_bank WRAM_COURT_PLANES ; $488c
	ld a, [wCharSelectHandedness] ; $4892
	ld b, a ; $4895
	ld a, [wCharSelectIsPartner] ; $4896
	add a ; $4899
	ld c, a ; $489a
	pop af ; $489b
	add c ; $489c
	push af ; $489d
	ld d, a ; $489e
	ld a, [wStoryCharacterSlot] ; $489f
	farcall InitPlayerRecordFromTemplate ; $48a2
	push af ; $48a5
	ld hl, wStoryModeNameOfMainCharacter ; $48a6
	ld a, [wStoryCharacterSlot] ; $48a9
	or a ; $48ac
	jr z, .finish ; $48ad
	ld l, $40 ; $48af
.finish:
	ld a, l ; $48b1
	add $0e ; $48b2
	ld l, a ; $48b4
	ld a, h ; $48b5
	adc $00 ; $48b6
	ld h, a ; $48b8
	pop af ; $48b9
	ld a, [wCharSelectHandedness] ; $48ba
	ld [hl], a ; $48bd
	pop af ; $48be
	push af ; $48bf
	call ClearFrameTasks ; $48c0
	ld hl, rIE ; $48c3
	set 2, [hl] ; $48c6
	call DisableLCDSafely ; $48c8
	farcall LoadMenuFontGfx ; $48cb
	call EnableLCD ; $48ce
	pop af ; $48d1
	ret ; $48d2
.cancel:
	sound SFX_MENU_CANCEL ; $48d3
	ld c, 16 ; $48d5
	call BeginFadeOut ; $48d7
	call WaitFadeEnd ; $48da
	call ClearFrameTasks ; $48dd
	ld hl, rIE ; $48e0
	set 2, [hl] ; $48e3
	call DisableLCDSafely ; $48e5
	farcall LoadMenuFontGfx ; $48e8
	call EnableLCD ; $48eb
	ld a, $ff ; $48ee
	ret ; $48f0
.viewStats:
	sound SFX_MENU_MOVE ; $48f1
	push_wram_bank WRAM_COURT_PLANES ; $48f3
	ld a, [wCharSelectHandedness] ; $48fc
	xor $01 ; $48ff
	ld [wCharSelectHandedness], a ; $4901
	pop_wram_bank ; $4904
	jp .redraw ; $4909
; DrawCharGridCursorBox with a different palette (c = 2), template and 48 x 24 extent: the same cursor-box drawer sized for another grid. Nothing calls it.
Unused_38_DrawCharSelectCursorBox:
	ld c, $02 ; $490c
	call GetMenuCursorIndex_38 ; $490e
	add a ; $4911
	ld hl, CharacterSelectScreenTable ; $4912
	add l ; $4915
	ld l, a ; $4916
	jr nc, .done ; $4917
	inc h ; $4919
.done:
	ld a, [hl+] ; $491a
	ld d, [hl] ; $491b
	ld e, a ; $491c
	ld bc, $3018 ; $491d
	call DrawSelectedOptionBox ; $4920
	ret ; $4923
CharacterSelectScreenTable:
	; $4924, 8 bytes (bytes:8)
	db $20, $08, $20, $68, $40, $08, $40, $68 ; 0x00
LoadCharSelectCharPalettes:
	ld b, $04 ; $492c
	ld c, $0b ; $492e
	farcall LoadIndexedPalette ; $4930
	ld b, $05 ; $4933
	ld c, $0b ; $4935
	farcall LoadIndexedPalette ; $4937
	ld b, $06 ; $493a
	ld c, $0b ; $493c
	farcall LoadIndexedPalette ; $493e
	ld b, $07 ; $4941
	ld c, $0b ; $4943
	farcall LoadIndexedPalette ; $4945
	ret ; $4948
LoadHighlightedCharPalette:
	ld c, $02 ; $4949
	call GetMenuCursorIndex_38 ; $494b
	ld b, a ; $494e
	push_wram_bank WRAM_COURT_PLANES ; $494f
	ld a, [wCharSelectIsPartner] ; $4958
	ld c, a ; $495b
	pop_wram_bank ; $495c
	ld a, c ; $4961
	add a ; $4962
	add b ; $4963
	ld b, a ; $4964
	ld d, $04 ; $4965
	add d ; $4967
	ld d, a ; $4968
	ld a, b ; $4969
	farcall GetCharPaletteIndex ; $496a
	farcall LoadIndexedPalette_18 ; $496d
	ret ; $4970
; Four bytes, $03 $01 $02 $00 -- a permutation of the four character-
; select slots. Sits between LoadHighlightedCharPalette and
; SetupCharacterSelectScreen; the palette routine computes its own
; index arithmetically (cursor index + partner flag, then + 4) and
; never consults a table.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_38_SlotIndexOrder:
	; $4971, 4 bytes (bytes:4)
	db $03, $01, $02, $00 ; 0x00
SetupCharacterSelectScreen:
	xor a ; $4975
	ldh [hScrollX], a ; $4976
	ldh [hScrollY], a ; $4978
	wram_bank WRAM_COURT_PLANES ; $497a
	xor a ; $4980
	ld [wCharSelectIdleAnimState], a ; $4981
	ld [wCharSelectHandedness], a ; $4984
	ld [wCharSelectIdleTimer], a ; $4987
	ld [wCameraX], a ; $498a
	ld [wCameraX + 1], a ; $498d
	ld [wCameraY], a ; $4990
	ld [wCameraY + 1], a ; $4993
	ld a, $90 ; $4996
	ldh [rWY], a ; $4998
	call ClearSpriteQueue ; $499a
	ld a, $02 ; $499d
	ld [wOnCourtCharCount], a ; $499f
	farcall InitActorEngine ; $49a2
	ld b, $02 ; $49a5
	ld c, $00 ; $49a7
	call SetMenuCursorFromIndex_38 ; $49a9
	farcall LoadMenuFontGfx ; $49ac
	ld c, SCREENASSET_CharacterSelect ; $49af
	farcall LoadScreenAssetRecord ; $49b1
	call LoadCharSelectCharPalettes ; $49b4
	farcall ResetTextWindowState ; $49b7
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $49ba
	ld c, SharedMenuGfx17_SIZE / 16 ; $49bc
	ld de, vTiles2 ; $49be
	farcall LoadCompressedTileBlock ; $49c1
	wram_bank WRAM_TEXT ; $49c4
	ld a, $03 ; $49ca
	ld [wShadowTilemapBank], a ; $49cc
	ld a, $00 ; $49cf
	ld [wWindowTileAttr], a ; $49d1
	rect_cell $00, $0f ; $49d4
	rect_size $14, $03 ; $49d8
	farcall CreateWindowFromScreenRect ; $49dc
	farcall DrawTextWindowFrame ; $49df
	farcall RedrawWindowRows ; $49e2
	rect_cell $00, $02 ; $49e5
	rect_size $14, $03 ; $49e9
	farcall CreateWindowFromScreenRect ; $49ed
	farcall DrawTextWindowFrame ; $49f0
	farcall RedrawWindowRows ; $49f3
	farcall PrepareGlyphBuffer ; $49f6
	call InitCharacterSelectChars ; $49f9
	call ReloadSelectedCharGfx ; $49fc
	call LoadHighlightedCharPalette ; $49ff
	call SetCharSelectAnimations ; $4a02
	call DrawCharacterSelectPrompt ; $4a05
	farcall UploadGlyphBuffer ; $4a08
	ld a, CHAR_ALEX ; $4a0b
	farcall LoadCharMugshotToBuffer ; $4a0d
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $4a10
	farcall CopyMugshotBufferToVram ; $4a13
	ld a, CHAR_NINA ; $4a16
	farcall LoadCharMugshotToBuffer ; $4a18
	ld de, vTiles2 + $30 * TILE_SIZE + VRAM_BANK1 ; $4a1b
	farcall CopyMugshotBufferToVram ; $4a1e
	wram_bank WRAM_COURT_PLANES ; $4a21
	ld a, [wCharSelectIsPartner] ; $4a27
	or a ; $4a2a
	jr z, .secondRow ; $4a2b
	ld a, CHAR_HARRY ; $4a2d
	farcall LoadCharMugshotToBuffer ; $4a2f
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $4a32
	farcall CopyMugshotBufferToVram ; $4a35
	ld a, CHAR_KATE ; $4a38
	farcall LoadCharMugshotToBuffer ; $4a3a
	ld de, vTiles2 + $30 * TILE_SIZE + VRAM_BANK1 ; $4a3d
	farcall CopyMugshotBufferToVram ; $4a40
	wram_bank WRAM_SCREEN ; $4a43
	ld b, $03 ; $4a49
	ld c, $03 ; $4a4b
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH + 6 ; $4a4d
	ld h, $0e ; $4a50
	farcall FillTilemapRect ; $4a52
	ld b, $03 ; $4a55
	ld c, $03 ; $4a57
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH + 14 ; $4a59
	ld h, $0f ; $4a5c
	farcall FillTilemapRect ; $4a5e
.secondRow:
	ld b, TILEBLOCK_CharacterSelectGfx ; $4a61
	ld c, CharacterSelectGfx_SIZE / 16 ; $4a63
	ld de, vTiles0 ; $4a65
	farcall LoadCompressedTileBlock ; $4a68
	ld b, $08 ; $4a6b
	ld c, $0c ; $4a6d
	farcall LoadIndexedPalette ; $4a6f
	farcall QueueWram3MapToVRAM ; $4a72
	wram_bank WRAM_COURT_PLANES ; $4a75
	xor a ; $4a7b
	ld [wCharSelectIdleAnimState], a ; $4a7c
	ld [wCharSelectIdleTimer], a ; $4a7f
	ld [wCharSelectHandedness], a ; $4a82
	farcall InitMenuBgScroll ; $4a85
	ld b, $01 ; $4a88
	ld c, $01 ; $4a8a
	farcall LoadMenuSpritePalettePair ; $4a8c
	ld a, $10 ; $4a8f
	ld [wMenuBgScrollTile], a ; $4a91
	ld [wMenuBgScrollTile + 1], a ; $4a94
	ld b, TILEBLOCK_SharedMenuGfx72 ; $4a97
	ld c, SharedMenuGfx72_SIZE / 16 ; $4a99
	ld de, vTiles0 + $10 * TILE_SIZE ; $4a9b
	farcall LoadCompressedTileBlock ; $4a9e
	call LoadCharSelectCharPalettes ; $4aa1
	call LoadHighlightedCharPalette ; $4aa4
	call SetCharSelectAnimations ; $4aa7
	call ReloadSelectedCharGfx ; $4aaa
	ret ; $4aad
RefreshCharacterSelectHighlight:
	sound SFX_MENU_MOVE ; $4aae
	call LoadCharSelectCharPalettes ; $4ab0
	call LoadHighlightedCharPalette ; $4ab3
	call SetCharSelectAnimations ; $4ab6
	call ReloadSelectedCharGfx ; $4ab9
	push_wram_bank WRAM_COURT_PLANES ; $4abc
	xor a ; $4ac5
	ld [wCharSelectIdleTimer], a ; $4ac6
	pop_wram_bank ; $4ac9
	ret ; $4ace
DrawCharacterSelectPrompt:
	push af ; $4acf
	push bc ; $4ad0
	push de ; $4ad1
	push hl ; $4ad2
	push_wram_bank WRAM_COURT_PLANES ; $4ad3
	ld a, [wCharSelectIsPartner] ; $4adc
	or a ; $4adf
	jr nz, .altRow ; $4ae0
	wram_bank WRAM_SCREEN ; $4ae2
	ld hl, Text_30_117 ; $4ae8
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $4aeb
	ld c, $12 ; $4aee
	farcall RenderProportionalTextAt ; $4af0
	jr .nextRow ; $4af3
.altRow:
	wram_bank WRAM_SCREEN ; $4af5
	ld hl, Text_30_119 ; $4afb
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 2 ; $4afe
	ld c, $12 ; $4b01
	farcall RenderProportionalTextAt ; $4b03
.nextRow:
	wram_bank WRAM_SCREEN ; $4b06
	ld hl, Text_30_118 ; $4b0c
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $4b0f
	ld c, $12 ; $4b12
	farcall RenderProportionalTextAt ; $4b14
	pop_wram_bank ; $4b17
	pop hl ; $4b1c
	pop de ; $4b1d
	pop bc ; $4b1e
	pop af ; $4b1f
	ret ; $4b20
InitCharacterSelectChars:
	wram_bank WRAM_CHAR3 ; $4b21
	ld hl, wCharPosX ; $4b27
	ld c, $10 ; $4b2a
	call ClearMemory16 ; $4b2c
	wram_bank WRAM_CHAR2 ; $4b2f
	ld hl, wCharPosX ; $4b35
	ld c, $10 ; $4b38
	call ClearMemory16 ; $4b3a
	wram_bank WRAM_CHAR1 ; $4b3d
	ld hl, wCharPosX ; $4b43
	ld c, $10 ; $4b46
	call ClearMemory16 ; $4b48
	wram_bank WRAM_CHAR0 ; $4b4b
	ld hl, wCharPosX ; $4b51
	ld c, $10 ; $4b54
	call ClearMemory16 ; $4b56
	ld a, CHAR_ALEX ; $4b59
	farcall GetCharPaletteIndex ; $4b5b
	ld e, a ; $4b5e
	ld d, $00 ; $4b5f
	wram_bank WRAM_ACTORS ; $4b61
	ld a, $00 ; $4b67
	farcall InitChar ; $4b69
	ld a, CHAR_NINA ; $4b6c
	farcall GetCharPaletteIndex ; $4b6e
	ld e, a ; $4b71
	ld d, $01 ; $4b72
	wram_bank WRAM_TEXT ; $4b74
	ld a, $01 ; $4b7a
	farcall InitChar ; $4b7c
	ld a, CHAR_HARRY ; $4b7f
	farcall GetCharPaletteIndex ; $4b81
	ld e, a ; $4b84
	ld d, $02 ; $4b85
	wram_bank WRAM_SCENE ; $4b87
	ld a, $02 ; $4b8d
	farcall InitChar ; $4b8f
	ld a, CHAR_KATE ; $4b92
	farcall GetCharPaletteIndex ; $4b94
	ld e, a ; $4b97
	ld d, $03 ; $4b98
	wram_bank WRAM_CHAR3 ; $4b9a
	ld a, $03 ; $4ba0
	farcall InitChar ; $4ba2
	wram_bank WRAM_CHAR0 ; $4ba5
	ret ; $4bab
DrawCharacterSelectChars:
	wram_bank WRAM_CHAR0 ; $4bac
	ld hl, wCharPosX ; $4bb2
	call UpdateCharSelectCharSprite ; $4bb5
	ld a, $58 ; $4bb8
	ld [wCharSpriteSlot + 2], a ; $4bba
	ld a, $20 ; $4bbd
	ld [wCharSpriteSlot + 3], a ; $4bbf
	wram_bank WRAM_CHAR1 ; $4bc2
	ld hl, wCharPosX ; $4bc8
	call UpdateCharSelectCharSprite ; $4bcb
	ld a, $58 ; $4bce
	ld [wCharSpriteSlot + 2], a ; $4bd0
	ld a, $61 ; $4bd3
	ld [wCharSpriteSlot + 3], a ; $4bd5
	wram_bank WRAM_CHAR2 ; $4bd8
	ld hl, wCharPosX ; $4bde
	call UpdateCharSelectCharSprite ; $4be1
	ld a, $c8 ; $4be4
	ld [wCharSpriteSlot + 2], a ; $4be6
	ld a, $c8 ; $4be9
	ld [wCharSpriteSlot + 3], a ; $4beb
	wram_bank WRAM_CHAR3 ; $4bee
	ld hl, wCharPosX ; $4bf4
	call UpdateCharSelectCharSprite ; $4bf7
	ld a, $c8 ; $4bfa
	ld [wCharSpriteSlot + 2], a ; $4bfc
	ld a, $c8 ; $4bff
	ld [wCharSpriteSlot + 3], a ; $4c01
	wram_bank WRAM_ACTORS ; $4c04
	push_wram_bank WRAM_COURT_PLANES ; $4c0a
	ld a, [wCharSelectIsPartner] ; $4c13
	ld b, a ; $4c16
	pop_wram_bank ; $4c17
	ld a, b ; $4c1c
	or a ; $4c1d
	jr z, .applySlot ; $4c1e
	wram_bank WRAM_CHAR0 ; $4c20
	ld a, $c8 ; $4c26
	ld [wCharSpriteSlot + 2], a ; $4c28
	ld a, $c8 ; $4c2b
	ld [wCharSpriteSlot + 3], a ; $4c2d
	wram_bank WRAM_CHAR1 ; $4c30
	ld a, $c8 ; $4c36
	ld [wCharSpriteSlot + 2], a ; $4c38
	ld a, $c8 ; $4c3b
	ld [wCharSpriteSlot + 3], a ; $4c3d
	wram_bank WRAM_CHAR2 ; $4c40
	ld a, $58 ; $4c46
	ld [wCharSpriteSlot + 2], a ; $4c48
	ld a, $20 ; $4c4b
	ld [wCharSpriteSlot + 3], a ; $4c4d
	wram_bank WRAM_CHAR3 ; $4c50
	ld a, $58 ; $4c56
	ld [wCharSpriteSlot + 2], a ; $4c58
	ld a, $61 ; $4c5b
	ld [wCharSpriteSlot + 3], a ; $4c5d
	wram_bank WRAM_ACTORS ; $4c60
.applySlot:
	push_wram_bank WRAM_COURT_PLANES ; $4c66
	ld a, [wCharSelectHandedness] ; $4c6f
	ld c, a ; $4c72
	pop_wram_bank ; $4c73
	ld a, c ; $4c78
	or a ; $4c79
	jr z, .applySlot2 ; $4c7a
	wram_bank WRAM_CHAR0 ; $4c7c
	ld hl, wCharSpriteSlot + 1 ; $4c82
	set 5, [hl] ; $4c85
	wram_bank WRAM_CHAR1 ; $4c87
	ld hl, wCharSpriteSlot + 1 ; $4c8d
	set 5, [hl] ; $4c90
	wram_bank WRAM_CHAR2 ; $4c92
	ld hl, wCharSpriteSlot + 1 ; $4c98
	set 5, [hl] ; $4c9b
	wram_bank WRAM_CHAR3 ; $4c9d
	ld hl, wCharSpriteSlot + 1 ; $4ca3
	set 5, [hl] ; $4ca6
.applySlot2:
	wram_bank WRAM_CHAR0 ; $4ca8
	ld hl, wCharSpriteSlot ; $4cae
	farcall DrawCharSprite ; $4cb1
	wram_bank WRAM_CHAR1 ; $4cb4
	ld hl, wCharSpriteSlot ; $4cba
	farcall DrawCharSprite ; $4cbd
	wram_bank WRAM_CHAR2 ; $4cc0
	ld hl, wCharSpriteSlot ; $4cc6
	farcall DrawCharSprite ; $4cc9
	wram_bank WRAM_CHAR3 ; $4ccc
	ld hl, wCharSpriteSlot ; $4cd2
	farcall DrawCharSprite ; $4cd5
	wram_bank WRAM_ACTORS ; $4cd8
	call TickCharSelectIdleAnim ; $4cde
	ret ; $4ce1
