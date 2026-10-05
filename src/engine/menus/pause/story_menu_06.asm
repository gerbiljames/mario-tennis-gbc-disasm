TextRectAttrs_06:
	; $6973, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_end
Unused_06_DrawMusicMenuRow:
	ld_cell de, $03, $0a ; $698b
	call GetShadowTilemapAddr ; $698e
	ld hl, Unused_06_DrawMusicMenuRowTextRect ; $6991
	ld_size bc, $0c, $02 ; $6994
	call CopyTextRect ; $6997
	ld_cell de, $03, $0a ; $699a
	call GetShadowAttrmapAddr ; $699d
	ld hl, TextRectAttrs_06 ; $69a0
	ld_size bc, $0c, $02 ; $69a3
	call CopyTextRect ; $69a6
	ld a, [wCourtViewLocked] ; $69a9
	and a ; $69ac
	ret z ; $69ad
	ld a, $05 ; $69ae
	ld_cell de, $09, $0a ; $69b0
	call DrawMatchMenuItem ; $69b3
	ret ; $69b6
QueueMatchMenuCursorSprite:
	ld a, d ; $69b7
	add $fc ; $69b8
	ld d, a ; $69ba
	call AdjustSpriteCoordsForScroll ; $69bb
	ld hl, QueueMatchMenuCursorSprite_SpriteTemplate ; $69be
	ld_oam bc, 0, $00 ; $69c1
	call QueueSpriteTemplate ; $69c4
	ret ; $69c7
DrawScoreboardModeTitle:
	ld h, $05 ; $69c8
	ld a, [wScoreboardOrigin] ; $69ca
	ld l, a ; $69cd
	add hl, hl ; $69ce
	add hl, hl ; $69cf
	add hl, hl ; $69d0
	ld de, $fcf0 ; $69d1
	add hl, de ; $69d4
	ld e, l ; $69d5
	ld d, h ; $69d6
	farcall AddBobbingOffsetYLarge ; $69d7
	call AdjustSpriteCoordsForScroll ; $69da
	ld hl, DrawScoreboardModeTitle_SpriteTemplate ; $69dd
	ld_oam bc, 0, $00 ; $69e0
	call QueueSpriteTemplate ; $69e3
	ret ; $69e6
QueueMatchMenuCursorSprite_SpriteTemplate:
	; $69e7, 41 bytes (sprite_template)
	oam_sprite $00, $20, $64, $02
	oam_sprite $00, $28, $66, $02
	oam_sprite $10, $08, $40, $02
	oam_sprite $10, $10, $42, $02
	oam_sprite $10, $18, $44, $02
	oam_sprite $10, $20, $46, $02
	oam_sprite $10, $28, $48, $02
	oam_sprite $10, $30, $4a, $02
	oam_sprite $10, $38, $4c, $02
	oam_sprite $10, $40, $4e, $02
	oam_sprite_end
DrawScoreboardModeTitle_SpriteTemplate:
	; $6a10, 41 bytes (sprite_template)
	oam_sprite $10, $08, $50, $02
	oam_sprite $10, $10, $52, $02
	oam_sprite $10, $18, $54, $02
	oam_sprite $10, $20, $56, $02
	oam_sprite $10, $28, $58, $02
	oam_sprite $10, $30, $5a, $02
	oam_sprite $10, $38, $5c, $02
	oam_sprite $10, $40, $5e, $02
	oam_sprite $10, $48, $60, $02
	oam_sprite $10, $50, $62, $02
	oam_sprite_end
DebugStatNamePointers:
	; $6a39, 30 bytes (records:2)
	dw DebugStatName_Speed ; record 0
	dw DebugStatName_Add ; record 1
	dw DebugStatName_Brake ; record 2
	dw DebugStatName_Turn ; record 3
	dw DebugStatName_Angle ; record 4
	dw DebugStatName_Place ; record 5
	dw DebugStatName_Stroke ; record 6
	dw DebugStatName_Serve ; record 7
	dw DebugStatName_Volley ; record 8
	dw DebugStatName_Top ; record 9
	dw DebugStatName_Slice ; record 10
	dw DebugStatName_High ; record 11
	dw DebugStatName_Reach ; record 12
	dw DebugStatName_Jump ; record 13
	dw DebugStatName_Dive ; record 14
DebugStatName_Speed:
	INCLUDE "data/bank_006/DebugStatName_Speed.asm" ; $6a57, 7 bytes
DebugStatName_Add:
	INCLUDE "data/bank_006/DebugStatName_Add.asm" ; $6a5e, 5 bytes
DebugStatName_Brake:
	INCLUDE "data/bank_006/DebugStatName_Brake.asm" ; $6a63, 7 bytes
DebugStatName_Turn:
	INCLUDE "data/bank_006/DebugStatName_Turn.asm" ; $6a6a, 6 bytes
DebugStatName_Angle:
	INCLUDE "data/bank_006/DebugStatName_Angle.asm" ; $6a70, 7 bytes
DebugStatName_Place:
	INCLUDE "data/bank_006/DebugStatName_Place.asm" ; $6a77, 7 bytes
DebugStatName_Stroke:
	INCLUDE "data/bank_006/DebugStatName_Stroke.asm" ; $6a7e, 8 bytes
DebugStatName_Serve:
	INCLUDE "data/bank_006/DebugStatName_Serve.asm" ; $6a86, 7 bytes
DebugStatName_Volley:
	INCLUDE "data/bank_006/DebugStatName_Volley.asm" ; $6a8d, 8 bytes
DebugStatName_Top:
	INCLUDE "data/bank_006/DebugStatName_Top.asm" ; $6a95, 5 bytes
DebugStatName_Slice:
	INCLUDE "data/bank_006/DebugStatName_Slice.asm" ; $6a9a, 7 bytes
DebugStatName_High:
	INCLUDE "data/bank_006/DebugStatName_High.asm" ; $6aa1, 6 bytes
DebugStatName_Reach:
	INCLUDE "data/bank_006/DebugStatName_Reach.asm" ; $6aa7, 7 bytes
DebugStatName_Jump:
	INCLUDE "data/bank_006/DebugStatName_Jump.asm" ; $6aae, 6 bytes
DebugStatName_Dive:
	INCLUDE "data/bank_006/DebugStatName_Dive.asm" ; $6ab4, 6 bytes
Unused_06_DrawDebugStatsLabels:
	ld_cell de, $00, $00 ; $6aba
	call GetShadowAttrmapAddr ; $6abd
	ld c, e ; $6ac0
	ld b, d ; $6ac1
	ld_cell de, $00, $00 ; $6ac2
	call GetShadowTilemapAddr ; $6ac5
	ld hl, $0f11 ; $6ac8
	call DrawWindowFrameNoPriority ; $6acb
	ld c, $00 ; $6ace
	ld_cell de, $01, $01 ; $6ad0
.loop:
	push bc ; $6ad3
	push de ; $6ad4
	push bc ; $6ad5
	call GetShadowTilemapAddr ; $6ad6
	pop bc ; $6ad9
	ld a, c ; $6ada
	add a ; $6adb
	ld_hl_indexed DebugStatNamePointers ; $6adc
	ld a, [hl+] ; $6ae3
	ld h, [hl] ; $6ae4
	ld l, a ; $6ae5
	call Unused_00_CopyTextString ; $6ae6
	pop de ; $6ae9
	pop bc ; $6aea
	inc e ; $6aeb
	inc c ; $6aec
	ld a, c ; $6aed
	cp $0f ; $6aee
	jr nz, .loop ; $6af0
	ret ; $6af2
Unused_06_DrawDebugStatsValues:
	ld_cell de, $0a, $01 ; $6af3
	call GetShadowTilemapAddr ; $6af6
	ld hl, wDebugStatWords ; $6af9
	ld a, [hl+] ; $6afc
	ld h, [hl] ; $6afd
	ld l, a ; $6afe
	call Unused_06_DrawDebugStatWord ; $6aff
	ld hl, wDebugStatWords + 4 ; $6b02
	ld a, [hl+] ; $6b05
	ld h, [hl] ; $6b06
	ld l, a ; $6b07
	call Unused_06_DrawDebugStatWord ; $6b08
	ld hl, wDebugStatWords + 6 ; $6b0b
	ld a, [hl+] ; $6b0e
	ld h, [hl] ; $6b0f
	ld l, a ; $6b10
	call Unused_06_DrawDebugStatWord ; $6b11
	ld a, [wDebugStatBytes] ; $6b14
	call Unused_06_DrawDebugStatByte ; $6b17
	ld a, [wDebugStatBytes + 1] ; $6b1a
	call Unused_06_DrawDebugStatByte ; $6b1d
	ld a, [wDebugStatBytes + 2] ; $6b20
	call Unused_06_DrawDebugStatByte ; $6b23
	ld a, [wDebugStatBytes + 3] ; $6b26
	call Unused_06_DrawDebugStatByte ; $6b29
	ld a, [wDebugStatBytes + 4] ; $6b2c
	call Unused_06_DrawDebugStatByte ; $6b2f
	ld a, [wDebugStatBytes + 5] ; $6b32
	call Unused_06_DrawDebugStatByte ; $6b35
	ld a, [wDebugStatBytes + 6] ; $6b38
	call Unused_06_DrawDebugStatByte ; $6b3b
	ld a, [wDebugStatBytes + 7] ; $6b3e
	call Unused_06_DrawDebugStatByte ; $6b41
	ld hl, wDebugStatWords2 ; $6b44
	ld a, [hl+] ; $6b47
	ld h, [hl] ; $6b48
	ld l, a ; $6b49
	call Unused_06_DrawDebugStatWord ; $6b4a
	ld hl, wDebugStatWords2 + 2 ; $6b4d
	ld a, [hl+] ; $6b50
	ld h, [hl] ; $6b51
	ld l, a ; $6b52
	call Unused_06_DrawDebugStatWord ; $6b53
	ld hl, wDebugStatWords2 + 4 ; $6b56
	ld a, [hl+] ; $6b59
	ld h, [hl] ; $6b5a
	ld l, a ; $6b5b
	call Unused_06_DrawDebugStatWord ; $6b5c
	ld hl, wDebugStatWords2 + 6 ; $6b5f
	ld a, [hl+] ; $6b62
	ld h, [hl] ; $6b63
	ld l, a ; $6b64
	call Unused_06_DrawDebugStatWord ; $6b65
	ret ; $6b68
Unused_06_DrawDebugStatByte:
	push de ; $6b69
	ld l, a ; $6b6a
	ld h, $00 ; $6b6b
	call Unused_00_DrawHexWord ; $6b6d
	pop de ; $6b70
	ld hl, $0020 ; $6b71
	add hl, de ; $6b74
	ld e, l ; $6b75
	ld d, h ; $6b76
	ret ; $6b77
Unused_06_DrawDebugStatWord:
	push de ; $6b78
	call Unused_00_DrawHexWord ; $6b79
	pop de ; $6b7c
	ld hl, $0020 ; $6b7d
	add hl, de ; $6b80
	ld e, l ; $6b81
	ld d, h ; $6b82
	ret ; $6b83
Unused_06_RunDebugStatsEditor:
	ldh a, [hWramBank] ; $6b84
	push af ; $6b86
	farcall StepMatchFrame ; $6b87
	farcall Unused_01_LoadMenuTilesBChunk2 ; $6b8a
	wram_bank WRAM_CHAR0 ; $6b8d
	ld hl, wCharPosX ; $6b93
	ld de, wDebugMenuWindowId ; $6b96
	ld c, $08 ; $6b99
	call CopyMemoryFast ; $6b9b
	wram_bank WRAM_COURT_PLANES ; $6b9e
	farcall StepMatchFrame ; $6ba4
	xor a ; $6ba7
	ld [wMatchMenuSelection], a ; $6ba8
	call Unused_06_DrawDebugStatsLabels ; $6bab
	call Unused_06_DrawDebugStatsValues ; $6bae
	call FlushTilemapToVram ; $6bb1
	farcall StepMatchFrame ; $6bb4
.loop:
	farcall ReadMatchInputPressed ; $6bb7
	and $0d ; $6bba
	jr nz, .maskSet ; $6bbc
	call Unused_06_HandleDebugStatsInput ; $6bbe
	call Unused_06_FlushTilemapToVramIfDirty ; $6bc1
	farcall StepMatchFrame ; $6bc4
	jr .loop ; $6bc7
.maskSet:
	and $08 ; $6bc9
	jr z, .restoreBgTilemap ; $6bcb
	ld de, $270b ; $6bcd
	ld hl, wMinigamesCurrentScore ; $6bd0
	ld a, e ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl], d ; $6bd5
.restoreBgTilemap:
	call RestoreBgTilemap ; $6bd6
	call FlushTilemapToVram ; $6bd9
	farcall StepMatchFrame ; $6bdc
	wram_bank WRAM_CHAR0 ; $6bdf
	ld hl, wDebugMenuWindowId ; $6be5
	ld de, wCharPosX ; $6be8
	ld c, $08 ; $6beb
	call CopyMemoryFast ; $6bed
	pop_wram_bank ; $6bf0
	ret ; $6bf5
Unused_06_HandleDebugStatsInput:
	ldh a, [hInputPressed] ; $6bf6
	ld b, a ; $6bf8
	ld c, $0b ; $6bf9
	ld a, [wMatchMenuSelection] ; $6bfb
	call Unused_00_MoveCursorVertical ; $6bfe
	ld [wMatchMenuSelection], a ; $6c01
	call Unused_06_AdjustSelectedDebugStat ; $6c04
	call Unused_06_QueueDebugStatsCursorSprites ; $6c07
	call Unused_06_DrawDebugStatsValues ; $6c0a
	ld a, $01 ; $6c0d
	ld [wTilemapDirtyFlag], a ; $6c0f
	ret ; $6c12
Unused_06_QueueDebugStatsCursorSprites:
	ld de, $0c0c ; $6c13
	call AdjustSpriteCoordsForScroll ; $6c16
	ld a, [wMatchMenuSelection] ; $6c19
	add a ; $6c1c
	add a ; $6c1d
	add a ; $6c1e
	add e ; $6c1f
	ld e, a ; $6c20
	ld_oam bc, OAM_BANK1 | 1, $42 ; $6c21
	call QueueSprite ; $6c24
	ld a, d ; $6c27
	add $40 ; $6c28
	ld d, a ; $6c2a
	ld_oam bc, OAM_BANK1 | 1, $42 ; $6c2b
	call QueueSprite ; $6c2e
	ret ; $6c31
Unused_06_AdjustSelectedDebugStat:
	ld a, [wMatchMenuSelection] ; $6c32
	rst Rst00 ; $6c35
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatWord ; $6c36 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatWord2 ; $6c38 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatWord3 ; $6c3a jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatByte ; $6c3c jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatByte2 ; $6c3e jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatByte3 ; $6c40 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatDigit ; $6c42 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatDigit2 ; $6c44 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatDigit3 ; $6c46 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatDigit4 ; $6c48 jumptable
	dw Unused_06_AdjustSelectedDebugStat.adjustDebugStatDigit5 ; $6c4a jumptable
.adjustDebugStatWord:
	ld hl, wDebugStatWords ; $6c4c
	ld bc, $0010 ; $6c4f
	jp Unused_06_AdjustDebugStatWord ; $6c52
.adjustDebugStatWord2:
	ld hl, wDebugStatWords + 4 ; $6c55
	ld bc, $0010 ; $6c58
	jp Unused_06_AdjustDebugStatWord ; $6c5b
.adjustDebugStatWord3:
	ld hl, wDebugStatWords + 6 ; $6c5e
	ld bc, $0010 ; $6c61
	jp Unused_06_AdjustDebugStatWord ; $6c64
.adjustDebugStatByte:
	ld hl, wDebugStatBytes ; $6c67
	ld b, $02 ; $6c6a
	jp Unused_06_AdjustDebugStatByte ; $6c6c
.adjustDebugStatByte2:
	ld hl, wDebugStatBytes + 1 ; $6c6f
	ld b, $08 ; $6c72
	jp Unused_06_AdjustDebugStatByte ; $6c74
.adjustDebugStatByte3:
	ld hl, wDebugStatBytes + 2 ; $6c77
	ld b, $02 ; $6c7a
	jp Unused_06_AdjustDebugStatByte ; $6c7c
.adjustDebugStatDigit:
	ld hl, wDebugStatBytes + 3 ; $6c7f
	jp Unused_06_AdjustDebugStatDigit ; $6c82
.adjustDebugStatDigit2:
	ld hl, wDebugStatBytes + 4 ; $6c85
	jp Unused_06_AdjustDebugStatDigit ; $6c88
.adjustDebugStatDigit3:
	ld hl, wDebugStatBytes + 5 ; $6c8b
	jp Unused_06_AdjustDebugStatDigit ; $6c8e
.adjustDebugStatDigit4:
	ld hl, wDebugStatBytes + 6 ; $6c91
	jp Unused_06_AdjustDebugStatDigit ; $6c94
.adjustDebugStatDigit5:
	ld hl, wDebugStatBytes + 7 ; $6c97
	jp Unused_06_AdjustDebugStatDigit ; $6c9a
Unused_06_AdjustDebugStatDigit:
	ldh a, [hInputPressed] ; $6c9d
	ld b, a ; $6c9f
	ld c, $0a ; $6ca0
	ld a, [hl] ; $6ca2
	call MoveCursorHorizontal ; $6ca3
	ld [hl], a ; $6ca6
	ret ; $6ca7
Unused_06_AdjustDebugStatByte:
	ldh a, [hInputPressed] ; $6ca8
	bit PADB_LEFT, a ; $6caa
	jr nz, .read ; $6cac
	bit 4, a ; $6cae
	jr nz, .readB ; $6cb0
	ret ; $6cb2
.read:
	ld a, [hl] ; $6cb3
	sub b ; $6cb4
	ld [hl], a ; $6cb5
	ret ; $6cb6
.readB:
	ld a, [hl] ; $6cb7
	add b ; $6cb8
	ld [hl], a ; $6cb9
	ret ; $6cba
Unused_06_AdjustDebugStatWord:
	ldh a, [hInputPressed] ; $6cbb
	bit PADB_LEFT, a ; $6cbd
	jr nz, .read ; $6cbf
	bit 4, a ; $6cc1
	jr nz, .readB ; $6cc3
	ret ; $6cc5
.read:
	ld a, [hl+] ; $6cc6
	ld e, a ; $6cc7
	ld d, [hl] ; $6cc8
	ld a, e ; $6cc9
	sub c ; $6cca
	ld e, a ; $6ccb
	ld a, d ; $6ccc
	sbc b ; $6ccd
	ld d, a ; $6cce
	ld a, d ; $6ccf
	ld [hl-], a ; $6cd0
	ld [hl], e ; $6cd1
	ret ; $6cd2
.readB:
	ld a, [hl+] ; $6cd3
	ld e, a ; $6cd4
	ld d, [hl] ; $6cd5
	ld a, e ; $6cd6
	add c ; $6cd7
	ld e, a ; $6cd8
	ld a, d ; $6cd9
	adc b ; $6cda
	ld d, a ; $6cdb
	ld a, d ; $6cdc
	ld [hl-], a ; $6cdd
	ld [hl], e ; $6cde
	ret ; $6cdf
StoryMenuDefs:
	; $6ce0, 48 bytes (menu_def:STORYMENUITEM)
	menu_def STORYMENUITEM_STATUS, STORYMENUITEM_CLEAR_STATUS, STORYMENUITEM_OPTIONS, STORYMENUITEM_SAVE ; menu 0
	menu_def STORYMENUITEM_CHAR_DATA, STORYMENUITEM_ITEMS ; menu 1
	menu_def STORYMENUITEM_MESSAGES, STORYMENUITEM_MUSIC ; menu 2
	menu_def STORYMENUITEM_MSG_SLOW, STORYMENUITEM_MSG_NORMAL, STORYMENUITEM_MSG_FAST ; menu 3
	menu_def STORYMENUITEM_MUSIC_ON, STORYMENUITEM_MUSIC_OFF ; menu 4
	menu_def STORYMENUITEM_SAVE_GAME, STORYMENUITEM_TO_MAIN_MENU, STORYMENUITEM_CANCEL ; menu 5
RunStoryMenu:
	call GetStoryMenuItemCount ; $6d10
	ld [wPauseMenuItemCount], a ; $6d13
	call DrawStoryMenuItems ; $6d16
	jr .redraw ; $6d19
.inputLoop:
	farcall ReadMatchInputPressed ; $6d1b
	and $0a ; $6d1e
	jr z, .checkA ; $6d20
	sound SFX_MENU_CANCEL ; $6d22
	ld a, MATCHMENUSEL_CANCELLED ; $6d24
	ld [wMatchMenuSelection], a ; $6d26
	jr .done ; $6d29
.checkA:
	farcall ReadMatchInputPressed ; $6d2b
	and $01 ; $6d2e
	jr z, .checkLeftRight ; $6d30
	sound SFX_MENU_SELECT ; $6d32
	jr .done ; $6d34
.checkLeftRight:
	farcall ReadMatchInputRepeat ; $6d36
	and $30 ; $6d39
	jr z, .drawCursor ; $6d3b
	ld b, a ; $6d3d
	ld a, [wPauseMenuItemCount] ; $6d3e
	ld c, a ; $6d41
	ld a, [wMatchMenuSelection] ; $6d42
	call MoveCursorHorizontal ; $6d45
	ld [wMatchMenuSelection], a ; $6d48
	sound SFX_MENU_MOVE ; $6d4b
.redraw:
	ld a, [wMatchMenuSelection] ; $6d4d
	call GetStoryMenuItemId ; $6d50
	push af ; $6d53
	call LoadStoryMenuItemGfx ; $6d54
	pop af ; $6d57
	ld_hl_indexed Text_30_354 ; $6d58
	ld_cell de, $00, $0e ; $6d5f
	call DrawStoryMenuCaption ; $6d62
	call RedrawStoryTilemapRows ; $6d65
.drawCursor:
	call DrawStoryMenuCursor ; $6d68
	call AdvanceFrame ; $6d6b
	jr .inputLoop ; $6d6e
.done:
	call AdvanceFrame ; $6d70
	ret ; $6d73
GetStoryMenuItemId:
	ld b, a ; $6d74
	ld a, [wPauseMenuId] ; $6d75
	add a ; $6d78
	add a ; $6d79
	add a ; $6d7a
	ld_hl_indexed StoryMenuDefs ; $6d7b
	ld a, b ; $6d82
	add l ; $6d83
	ld l, a ; $6d84
	jr nc, .read ; $6d85
	inc h ; $6d87
.read:
	ld a, [hl] ; $6d88
	ret ; $6d89
GetStoryMenuItemCount:
	ld a, [wPauseMenuId] ; $6d8a
	add a ; $6d8d
	add a ; $6d8e
	add a ; $6d8f
	ld_hl_indexed StoryMenuDefs + 4 ; $6d90
	ld a, [hl] ; $6d97
	ret ; $6d98
DrawStoryMenuItems:
	ld a, [wPauseMenuItemCount] ; $6d99
	add a ; $6d9c
	ld_hl_indexed StoryMenuItemPosPointers ; $6d9d
	ld a, [hl+] ; $6da4
	ld h, [hl] ; $6da5
	ld l, a ; $6da6
	ld a, [wPauseMenuItemCount] ; $6da7
	ld c, a ; $6daa
	ld b, $00 ; $6dab
.loop:
	ld a, [hl+] ; $6dad
	ld e, a ; $6dae
	ld a, [hl+] ; $6daf
	ld d, a ; $6db0
	push bc ; $6db1
	push hl ; $6db2
	ld a, b ; $6db3
	call GetStoryMenuItemId ; $6db4
	call DrawStoryMenuItem ; $6db7
	pop hl ; $6dba
	pop bc ; $6dbb
	inc b ; $6dbc
	dec c ; $6dbd
	jr nz, .loop ; $6dbe
	ret ; $6dc0
StoryMenuItemPosPointers:
	; $6dc1, 10 bytes (records:2)
	dw StoryMenuItemPos2Items ; record 0
	dw StoryMenuItemPos2Items ; record 1
	dw StoryMenuItemPos2Items ; record 2
	dw StoryMenuItemPos3Items ; record 3
	dw StoryMenuItemPos4Items ; record 4
StoryMenuItemPos2Items:
	; $6dcb, 4 bytes (bytes:2)
	db $0a, $05 ; 0x00
	db $0a, $0b ; 0x02
StoryMenuItemPos3Items:
	; $6dcf, 6 bytes (bytes:2)
	db $0a, $04 ; 0x00
	db $0a, $08 ; 0x02
	db $0a, $0c ; 0x04
StoryMenuItemPos4Items:
	; $6dd5, 8 bytes (bytes:2)
	db $0a, $03 ; 0x00
	db $0a, $06 ; 0x02
	db $0a, $09 ; 0x04
	db $0a, $0c ; 0x06
DrawStoryMenuCursor:
	ld a, [wPauseMenuItemCount] ; $6ddd
	add a ; $6de0
	ld_hl_indexed StoryMenuCursorPosPointers ; $6de1
	ld a, [hl+] ; $6de8
	ld h, [hl] ; $6de9
	ld l, a ; $6dea
	ld a, [wMatchMenuSelection] ; $6deb
	add a ; $6dee
	add l ; $6def
	ld l, a ; $6df0
	jr nc, .read ; $6df1
	inc h ; $6df3
.read:
	ld a, [hl+] ; $6df4
	ld d, [hl] ; $6df5
	ld e, a ; $6df6
	call QueueStoryMenuCursorSprite ; $6df7
	ret ; $6dfa
StoryMenuCursorPosPointers:
	; $6dfb, 10 bytes (records:2)
	dw StoryMenuCursorPos2Items ; record 0
	dw StoryMenuCursorPos2Items ; record 1
	dw StoryMenuCursorPos2Items ; record 2
	dw StoryMenuCursorPos3Items ; record 3
	dw StoryMenuCursorPos4Items ; record 4
StoryMenuCursorPos2Items:
	; $6e05, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
StoryMenuCursorPos3Items:
	; $6e09, 6 bytes (bytes:2)
	db $60, $10 ; 0x00
	db $60, $30 ; 0x02
	db $60, $50 ; 0x04
StoryMenuCursorPos4Items:
	; $6e0f, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
RunStoryModeMenu:
	ldh a, [hWramBank] ; $6e17
	push af ; $6e19
	farcall StopSceneTileAnimations ; $6e1a
	ldh a, [hLinkPayloadKind] ; $6e1d
	push af ; $6e1f
	call AdvanceFrame ; $6e20
	sound SFX_PAUSE_MENU ; $6e23
	xor a ; $6e25
	ld [wMatchMenuSelection], a ; $6e26
	ld a, $02 ; $6e29
	ldh [hLinkPayloadKind], a ; $6e2b
	farcall InitTextWindows ; $6e2d
	ld a, TILEATTR_PRIORITY | TILEATTR_PAL1 ; $6e30
	ld [wWindowTileAttr], a ; $6e32
	set_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6e35
	farcall LoadMatchStoryGfx ; $6e38
	call RestoreStoryTilemapNoPriority ; $6e3b
	rect_cell $00, $0e ; $6e3e
	rect_size $13, $03 ; $6e42
	farcall CreateWindowFromScreenRect ; $6e46
	call AdvanceFrame ; $6e49
	wram_bank WRAM_TEXT ; $6e4c
.loop:
	ld hl, ScoreboardModeGfxTail ; $6e52
	ld de, vTiles0 + $64 * TILE_SIZE ; $6e55
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $6e58
	call QueueVRAMCopy ; $6e5a
	ld a, $00 ; $6e5d
	ld [wPauseMenuId], a ; $6e5f
	call RunStoryMenu ; $6e62
	ld a, [wMatchMenuSelection] ; $6e65
	cp MATCHMENUSEL_CANCELLED ; $6e68
	jr z, StoryPauseMenu_AfterItem.restoreStoryShadowTilemap ; $6e6a
	push af ; $6e6c
	ld hl, StoryPauseMenu_AfterItem ; $6e6d
	push hl ; $6e70
	ld a, [wMatchMenuSelection] ; $6e71
	rst Rst00 ; $6e74
	dw StoryPauseMenu_PlayerData ; $6e75 jumptable
	dw StoryPauseMenu_GameProgress ; $6e77 jumptable
	dw StoryPauseMenu_Options ; $6e79 jumptable
	dw StoryPauseMenu_SaveQuit ; $6e7b jumptable
StoryPauseMenu_AfterItem:
	ld b, a ; $6e7d
	pop af ; $6e7e
	ld [wMatchMenuSelection], a ; $6e7f
	cp $02 ; $6e82
	jr c, .runStoryModeMenu ; $6e84
	cp $03 ; $6e86
	jr nz, .checkMatchAbortFlag ; $6e88
	ld a, b ; $6e8a
	or a ; $6e8b
	jr nz, .runStoryModeMenu ; $6e8c
.checkMatchAbortFlag:
	ld a, [wMatchAbortFlag] ; $6e8e
	and a ; $6e91
	jr z, RunStoryModeMenu.loop ; $6e92
.restoreStoryShadowTilemap:
	call RestoreStoryShadowTilemap ; $6e94
	call RedrawStoryTilemapRows ; $6e97
	call AdvanceFrame ; $6e9a
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6e9d
	farcall LoadMenuFontGfxStaged ; $6ea0
	pop af ; $6ea3
	ldh [hLinkPayloadKind], a ; $6ea4
	farcall InitTextWindows ; $6ea6
	farcall InitSceneTileAnimations ; $6ea9
	pop_wram_bank ; $6eac
	ret ; $6eb1
.runStoryModeMenu:
	ld a, b ; $6eb2
	cp $ff ; $6eb3
	jp z, RunStoryModeMenu.loop ; $6eb5
	pop af ; $6eb8
	ldh [hLinkPayloadKind], a ; $6eb9
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6ebb
	farcall InitSceneTileAnimations ; $6ebe
	pop_wram_bank ; $6ec1
	ret ; $6ec6
UnusedStoryMenuRedrawReentry:
	call Unused_06_DrawStoryMenuItemRow ; $6ec7
	ld hl, ScoreboardModeGfxTail ; $6eca
	ld de, vTiles0 + $64 * TILE_SIZE ; $6ecd
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $6ed0
	call QueueVRAMCopy ; $6ed2
	jr .checkMatchMenuSelection ; $6ed5
.loop:
	farcall ReadMatchInputPressed ; $6ed7
	and $0e ; $6eda
	jr z, .readMatchInputPressed ; $6edc
	sound SFX_MENU_CANCEL ; $6ede
	ld a, MATCHMENUSEL_CANCELLED ; $6ee0
	ld [wMatchMenuSelection], a ; $6ee2
	jr .advanceFrame ; $6ee5
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $6ee7
	and $01 ; $6eea
	jr z, .readMatchInputRepeat ; $6eec
	sound SFX_MENU_SELECT ; $6eee
	jr .advanceFrame ; $6ef0
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $6ef2
	and $30 ; $6ef5
	jr z, .checkMatchMenuSelection2 ; $6ef7
	ld b, a ; $6ef9
	ld c, $04 ; $6efa
	ld a, [wMatchMenuSelection] ; $6efc
	call MoveCursorHorizontal ; $6eff
	ld [wMatchMenuSelection], a ; $6f02
	sound SFX_MENU_MOVE ; $6f05
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $6f07
	call LoadStoryMenuItemGfx ; $6f0a
	ld a, [wMatchMenuSelection] ; $6f0d
	ld_hl_indexed Text_30_354 ; $6f10
	ld_cell de, $00, $0e ; $6f17
	call DrawStoryMenuCaption ; $6f1a
	call RedrawStoryTilemapRows ; $6f1d
.checkMatchMenuSelection2:
	ld a, [wMatchMenuSelection] ; $6f20
	add a ; $6f23
	ld_hl_indexed StoryPauseMenuCursorPositions ; $6f24
	ld a, [hl+] ; $6f2b
	ld d, [hl] ; $6f2c
	ld e, a ; $6f2d
	call QueueStoryMenuCursorSprite ; $6f2e
	call AdvanceFrame ; $6f31
	jr .loop ; $6f34
.advanceFrame:
	call AdvanceFrame ; $6f36
	ret ; $6f39
StoryPauseMenuCursorPositions:
	; $6f3a, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
StoryPauseMenu_PlayerData:
	call RestoreStoryTilemapNoPriority ; $6f42
	xor a ; $6f45
	ld [wMatchMenuSelection], a ; $6f46
	ld a, $01 ; $6f49
	ld [wPauseMenuId], a ; $6f4b
	call RunStoryMenu ; $6f4e
	ld a, [wMatchMenuSelection] ; $6f51
	cp MATCHMENUSEL_CANCELLED ; $6f54
	jr z, .restoreStoryTilemapNoPriority ; $6f56
	ld a, [wMatchMenuSelection] ; $6f58
	rst Rst00 ; $6f5b
	dw StoryPauseMenu_CharPartnerData ; $6f5c jumptable
	dw StoryPauseMenu_Equipment ; $6f5e jumptable
.restoreStoryTilemapNoPriority:
	call RestoreStoryTilemapNoPriority ; $6f60
	ld a, $ff ; $6f63
	ret ; $6f65
StoryPauseMenu_CharPartnerData:
	ld hl, wStoryModePlayersXPosition ; $6f66
	ld de, wStoryModeSpawnPosition ; $6f69
	ld bc, wStoryModeSpawnPosition_SIZE ; $6f6c
	call CopyMemoryBC ; $6f6f
	ld a, STORYENTRY_NONE ; $6f72
	ld [wStoryModeEntryPoint], a ; $6f74
	ld [wUnusedExitTriggerIdMirror], a ; $6f77
	ld [wStoryModeExitTriggerRequest], a ; $6f7a
	apcall ApLoadAwardFont
	farcall ApplyPendingExpAwards
	ld a, $01 ; $6f7d
	farcall ShowCharDataScreen ; $6f7f
	xor a ; $6f82
	ret ; $6f83
StoryPauseMenu_Equipment:
	ld hl, wStoryModePlayersXPosition ; $6f84
	ld de, wStoryModeSpawnPosition ; $6f87
	ld bc, wStoryModeSpawnPosition_SIZE ; $6f8a
	call CopyMemoryBC ; $6f8d
	ld a, STORYENTRY_NONE ; $6f90
	ld [wStoryModeEntryPoint], a ; $6f92
	ld [wUnusedExitTriggerIdMirror], a ; $6f95
	ld [wStoryModeExitTriggerRequest], a ; $6f98
	farcall ShowEquipmentStatusScreen ; $6f9b
	xor a ; $6f9e
	ret ; $6f9f
StoryPauseMenu_GameProgress:
	ld hl, wStoryModePlayersXPosition ; $6fa0
	ld de, wStoryModeSpawnPosition ; $6fa3
	ld bc, wStoryModeSpawnPosition_SIZE ; $6fa6
	call CopyMemoryBC ; $6fa9
	ld a, STORYENTRY_NONE ; $6fac
	ld [wStoryModeEntryPoint], a ; $6fae
	ld [wUnusedExitTriggerIdMirror], a ; $6fb1
	ld [wStoryModeExitTriggerRequest], a ; $6fb4
	farcall ShowGameProgressScreen ; $6fb7
	xor a ; $6fba
	ret ; $6fbb
StoryPauseMenu_Options:
	call RestoreStoryTilemapNoPriority ; $6fbc
	ld a, [wCourtViewLocked] ; $6fbf
	and a ; $6fc2
	xor a ; $6fc3
	ld [wMatchMenuSelection], a ; $6fc4
.loop:
	ld a, $02 ; $6fc7
	ld [wPauseMenuId], a ; $6fc9
	call RunStoryMenu ; $6fcc
	ld a, [wMatchMenuSelection] ; $6fcf
	cp MATCHMENUSEL_CANCELLED ; $6fd2
	jr z, StoryOptionsMenu_AfterItem.done ; $6fd4
	push af ; $6fd6
	ld hl, StoryOptionsMenu_AfterItem ; $6fd7
	push hl ; $6fda
	ld a, [wMatchMenuSelection] ; $6fdb
	rst Rst00 ; $6fde
	dw StoryPauseMenu_MessageSpeed ; $6fdf jumptable
	dw StoryPauseMenu_MusicToggle ; $6fe1 jumptable
StoryOptionsMenu_AfterItem:
	pop af ; $6fe3
	ld [wMatchMenuSelection], a ; $6fe4
	jr StoryPauseMenu_Options.loop ; $6fe7
.done:
	ret ; $6fe9
UnusedRunStoryPlayerDataMenu:
	ld a, STORYMENUITEM_CHAR_DATA ; $6fea
	ld [wStoryMenuFirstItem], a ; $6fec
	ld a, $01 ; $6fef
	ld [wPauseMenuId], a ; $6ff1
	jp RunStoryMenu ; $6ff4
StoryPauseMenu_MessageSpeed:
	ld a, [wMessageSpeed] ; $6ff7
	ld b, a ; $6ffa
	ld a, $02 ; $6ffb
	sub b ; $6ffd
	ld [wMatchMenuSelection], a ; $6ffe
	call RunMessageSpeedMenu ; $7001
	ld a, [wMatchMenuSelection] ; $7004
	cp MATCHMENUSEL_CANCELLED ; $7007
	jr z, .done ; $7009
	ld b, a ; $700b
	ld a, $02 ; $700c
	sub b ; $700e
	ld [wMessageSpeed], a ; $700f
.done:
	ret ; $7012
StoryPauseMenu_MusicToggle:
	ldh a, [hMusic] ; $7013
	and $01 ; $7015
	ld [wMatchMenuSelection], a ; $7017
	call RunMusicOnOffMenu ; $701a
	ld a, [wMatchMenuSelection] ; $701d
	cp MATCHMENUSEL_CANCELLED ; $7020
	jr z, .done ; $7022
	call SetMusicMuted ; $7024
	ldh a, [hMusic] ; $7027
	and $01 ; $7029
	farcall SetStorySlotFlagA ; $702b
.done:
	ret ; $702e
StoryPauseMenu_SaveQuit:
	call RestoreStoryTilemapNoPriority ; $702f
	ld hl, Text_30_370 ; $7032
	ld_cell de, $00, $0e ; $7035
	call DrawStoryMenuCaption ; $7038
	ld a, $02 ; $703b
	ld [wMatchMenuSelection], a ; $703d
	ld a, $05 ; $7040
	ld [wPauseMenuId], a ; $7042
	call RunStoryMenu ; $7045
	ld a, [wMatchMenuSelection] ; $7048
	cp MATCHMENUSEL_CANCELLED ; $704b
	jr z, StoryPauseMenu_ReturnToMainMenu.storeStoryMenuFirstItem ; $704d
	cp $02 ; $704f
	jr z, StoryPauseMenu_ReturnToMainMenu.storeStoryMenuFirstItem ; $7051
	ld a, [wMatchMenuSelection] ; $7053
	cp $01 ; $7056
	jr z, StoryPauseMenu_ReturnToMainMenu ; $7058
	ld a, $01 ; $705a
	ld [wSaveAndQuitRequest], a ; $705c
	ld a, [wMessageSpeed] ; $705f
	res 7, a ; $7062
	ld [wMessageSpeed], a ; $7064
	ld bc, $ffff ; $7067
	farcall SaveStoryReturnPoint ; $706a
	farcall SaveStorySlotWithTimer ; $706d
	ld a, STORYLOC_MAIN_MENU ; $7070
	ld [wStoryModeCurrentLocation], a ; $7072
	ld a, $01 ; $7075
	ld [wStoryModeEntryPoint], a ; $7077
	ld a, $ff ; $707a
	ld [wUnusedExitTriggerIdMirror], a ; $707c
	ld [wStoryModeExitTriggerRequest], a ; $707f
	ld a, $01 ; $7082
	jr StoryPauseMenu_ReturnToMainMenu.done ; $7084
StoryPauseMenu_ReturnToMainMenu:
	wait_frames 8 ; $7086
	ld a, $01 ; $708a
	ld [wMatchExitRequest], a ; $708c
	ld a, MATCHABORT_ALL ; $708f
	ld [wMatchAbortFlag], a ; $7091
	ld a, STORYLOC_MAIN_MENU ; $7094
	ld [wStoryModeCurrentLocation], a ; $7096
	ld a, $01 ; $7099
	ld [wStoryModeEntryPoint], a ; $709b
	ld a, $ff ; $709e
	ld [wUnusedExitTriggerIdMirror], a ; $70a0
	ld [wStoryModeExitTriggerRequest], a ; $70a3
	ld a, $01 ; $70a6
.done:
	ret ; $70a8
.storeStoryMenuFirstItem:
	ld a, $00 ; $70a9
	ret ; $70ab
