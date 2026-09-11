UnusedRunMessagesMusicMenu:
	ld a, STORYMENUITEM_MESSAGES ; $70ac
	ld [wStoryMenuFirstItem], a ; $70ae
	jp RunStoryTwoOptionMenu ; $70b1
RunMessageSpeedMenu:
	ld a, STORYMENUITEM_MSG_SLOW ; $70b4
	ld [wStoryMenuFirstItem], a ; $70b6
	jp RunStoryThreeOptionMenu ; $70b9
RunMusicOnOffMenu:
	ld a, STORYMENUITEM_MUSIC_ON ; $70bc
	ld [wStoryMenuFirstItem], a ; $70be
	jp RunStoryTwoOptionMenu ; $70c1
UnusedRunSaveQuitMenu:
	ld a, STORYMENUITEM_SAVE_GAME ; $70c4
	ld [wStoryMenuFirstItem], a ; $70c6
	jp RunStoryTwoOptionMenu ; $70c9
RunStoryTwoOptionMenu:
	ld a, [wStoryMenuFirstItem] ; $70cc
	ld de, $050a ; $70cf
	call DrawStoryMenuItem ; $70d2
	ld a, [wStoryMenuFirstItem] ; $70d5
	inc a ; $70d8
	ld de, $0b0a ; $70d9
	call DrawStoryMenuItem ; $70dc
	ld a, [wStoryMenuFirstItem] ; $70df
	cp STORYMENUITEM_SAVE_GAME ; $70e2
	jr z, .redrawStoryTilemapRows ; $70e4
	ld hl, wMatchMenuSelection ; $70e6
	add [hl] ; $70e9
	ld hl, $0162 ; $70ea
	add l ; $70ed
	ld l, a ; $70ee
	jr nc, .drawStoryMenuCaption ; $70ef
	inc h ; $70f1
.drawStoryMenuCaption:
	ld de, $000e ; $70f2
	call DrawStoryMenuCaption ; $70f5
.redrawStoryTilemapRows:
	call RedrawStoryTilemapRows ; $70f8
	ld a, [wMatchMenuSelection] ; $70fb
	ld hl, wStoryMenuFirstItem ; $70fe
	add [hl] ; $7101
	call LoadStoryMenuItemGfx ; $7102
.loop:
	farcall ReadMatchInputPressed ; $7105
	and $02 ; $7108
	jr z, .readMatchInputPressed ; $710a
	sound SFX_MENU_CANCEL ; $710c
	ld a, MATCHMENUSEL_CANCELLED ; $710e
	ld [wMatchMenuSelection], a ; $7110
	jr .advanceFrame ; $7113
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $7115
	and $01 ; $7118
	jr z, .readMatchInputRepeat ; $711a
	sound SFX_MENU_SELECT ; $711c
	jr .advanceFrame ; $711e
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $7120
	and $30 ; $7123
	jr z, .checkMatchMenuSelection2 ; $7125
	ld b, a ; $7127
	ld c, $02 ; $7128
	ld a, [wMatchMenuSelection] ; $712a
	call MoveCursorHorizontal ; $712d
	ld [wMatchMenuSelection], a ; $7130
	sound SFX_MENU_MOVE ; $7133
	ld a, [wStoryMenuFirstItem] ; $7135
	cp STORYMENUITEM_SAVE_GAME ; $7138
	jr z, .checkMatchMenuSelection ; $713a
	ld hl, wMatchMenuSelection ; $713c
	add [hl] ; $713f
	ld hl, $0162 ; $7140
	add l ; $7143
	ld l, a ; $7144
	jr nc, .drawStoryMenuCaption2 ; $7145
	inc h ; $7147
.drawStoryMenuCaption2:
	ld de, $000e ; $7148
	call DrawStoryMenuCaption ; $714b
	call RedrawStoryTilemapRows ; $714e
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $7151
	ld hl, wStoryMenuFirstItem ; $7154
	add [hl] ; $7157
	call LoadStoryMenuItemGfx ; $7158
.checkMatchMenuSelection2:
	ld a, [wMatchMenuSelection] ; $715b
	add a ; $715e
	ld_hl_indexed StoryTwoOptionCursorPositions ; $715f
	ld a, [hl+] ; $7166
	ld d, [hl] ; $7167
	ld e, a ; $7168
	call QueueStoryMenuCursorSprite ; $7169
	call AdvanceFrame ; $716c
	jp .loop ; $716f
.advanceFrame:
	call AdvanceFrame ; $7172
	ret ; $7175
StoryTwoOptionCursorPositions:
	; $7176, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
RunStoryThreeOptionMenu:
	call RestoreStoryTilemapNoPriority ; $717a
	ld a, [wStoryMenuFirstItem] ; $717d
	ld de, $030a ; $7180
	call DrawStoryMenuItem ; $7183
	ld a, [wStoryMenuFirstItem] ; $7186
	inc a ; $7189
	ld de, $080a ; $718a
	call DrawStoryMenuItem ; $718d
	ld a, [wStoryMenuFirstItem] ; $7190
	inc a ; $7193
	inc a ; $7194
	ld de, $0d0a ; $7195
	call DrawStoryMenuItem ; $7198
	ld a, [wStoryMenuFirstItem] ; $719b
	cp $06 ; $719e
	ld hl, wMatchMenuSelection ; $71a0
	add [hl] ; $71a3
	ld hl, $0162 ; $71a4
	add l ; $71a7
	ld l, a ; $71a8
	jr nc, .drawStoryMenuCaption ; $71a9
	inc h ; $71ab
.drawStoryMenuCaption:
	ld de, $000e ; $71ac
	call DrawStoryMenuCaption ; $71af
	call RedrawStoryTilemapRows ; $71b2
	ld a, [wMatchMenuSelection] ; $71b5
	ld hl, wStoryMenuFirstItem ; $71b8
	add [hl] ; $71bb
	call LoadStoryMenuItemGfx ; $71bc
.loop:
	farcall ReadMatchInputPressed ; $71bf
	and $02 ; $71c2
	jr z, .readMatchInputPressed ; $71c4
	sound SFX_MENU_CANCEL ; $71c6
	ld a, MATCHMENUSEL_CANCELLED ; $71c8
	ld [wMatchMenuSelection], a ; $71ca
	jr .restoreStoryTilemapNoPriority ; $71cd
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $71cf
	and $01 ; $71d2
	jr z, .readMatchInputRepeat ; $71d4
	sound SFX_MENU_SELECT ; $71d6
	jr .restoreStoryTilemapNoPriority ; $71d8
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $71da
	and $30 ; $71dd
	jr z, .checkMatchMenuSelection ; $71df
	ld b, a ; $71e1
	ld c, $03 ; $71e2
	ld a, [wMatchMenuSelection] ; $71e4
	call MoveCursorHorizontal ; $71e7
	ld [wMatchMenuSelection], a ; $71ea
	sound SFX_MENU_MOVE ; $71ed
	ld a, [wStoryMenuFirstItem] ; $71ef
	cp $06 ; $71f2
	ld hl, wMatchMenuSelection ; $71f4
	add [hl] ; $71f7
	ld hl, $0162 ; $71f8
	add l ; $71fb
	ld l, a ; $71fc
	jr nc, .drawStoryMenuCaption2 ; $71fd
	inc h ; $71ff
.drawStoryMenuCaption2:
	ld de, $000e ; $7200
	call DrawStoryMenuCaption ; $7203
	call RedrawStoryTilemapRows ; $7206
	ld a, [wMatchMenuSelection] ; $7209
	ld hl, wStoryMenuFirstItem ; $720c
	add [hl] ; $720f
	call LoadStoryMenuItemGfx ; $7210
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $7213
	add a ; $7216
	ld_hl_indexed StoryThreeOptionCursorPositions ; $7217
	ld a, [hl+] ; $721e
	ld d, [hl] ; $721f
	ld e, a ; $7220
	call QueueStoryMenuCursorSprite ; $7221
	call AdvanceFrame ; $7224
	jp .loop ; $7227
.restoreStoryTilemapNoPriority:
	call RestoreStoryTilemapNoPriority ; $722a
	call AdvanceFrame ; $722d
	ret ; $7230
StoryThreeOptionCursorPositions:
	; $7231, 6 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $30 ; 0x02
	db $60, $58 ; 0x04
RedrawStoryTilemapRows:
	wram_bank $05 ; $7237
	farcall RedrawAllTilemapRows ; $723d
	ret ; $7240
RestoreStoryShadowTilemap:
	farcall RestoreShadowTilemap ; $7241
	ret ; $7244
RestoreStoryTilemapNoPriority:
	farcall RestoreShadowTilemap ; $7245
	call ClearStoryAttrPriorityBits ; $7248
	farcall RedrawAllTilemapRows ; $724b
	ret ; $724e
DrawStoryMenuCaption:
	push hl ; $724f
	farcall PrepareGlyphBuffer ; $7250
	xor a ; $7253
	farcall DrawTextWindowFrame ; $7254
	ld hl, $0101 ; $7257
	add hl, de ; $725a
	ld e, l ; $725b
	ld d, h ; $725c
	call GetShadowTilemapAddr ; $725d
	pop hl ; $7260
	ld c, $11 ; $7261
	farcall RenderProportionalTextAt ; $7263
	farcall UploadGlyphBuffer ; $7266
	ret ; $7269
ClearStoryAttrPriorityBits:
	wram_bank $05 ; $726a
	ld hl, wShadowTilemapPtr ; $7270
	ld a, [hl+] ; $7273
	ld h, [hl] ; $7274
	ld l, a ; $7275
	ld bc, $0400 ; $7276
	add hl, bc ; $7279
.loop:
	res 7, [hl] ; $727a
	inc hl ; $727c
	dec bc ; $727d
	ld a, b ; $727e
	or c ; $727f
	jr nz, .loop ; $7280
	ret ; $7282
LoadStoryMenuItemGfx:
	add a ; $7283
	ld_hl_indexed StoryMenuItemGfxPointers ; $7284
	ld a, [hl+] ; $728b
	ld h, [hl] ; $728c
	ld l, a ; $728d
	ld de, wDecompBuffer ; $728e
	push_wram_bank $01 ; $7291
	call DecompressData ; $729a
	ld hl, wDecompBuffer ; $729d
	ld de, vTiles0 + $70 * TILE_SIZE ; $72a0
	ld c, $10 ; $72a3
	call QueueVRAMCopy ; $72a5
	pop_wram_bank ; $72a8
	ret ; $72ad
StoryMenuItemGfxPointers:
	; $72ae, 32 bytes (records:2)
	dw StoryMenuItemGfx_Status ; record 0
	dw StoryMenuItemGfx_ClearStatus ; record 1
	dw MatchMenuItemGfx_Options ; record 2
	dw MatchMenuItemGfx_Save ; record 3
	dw StoryMenuItemGfx_Messages ; record 4
	dw MatchMenuItemGfx_Music ; record 5
	dw StoryMenuItemGfx_Slow ; record 6
	dw StoryMenuItemGfx_Normal ; record 7
	dw StoryMenuItemGfx_Fast ; record 8
	dw MatchMenuItemGfx_On ; record 9
	dw MatchMenuItemGfx_Off ; record 10
	dw MatchMenuItemGfx_SaveNarrow ; record 11
	dw MatchMenuItemGfx_ToMainMenu ; record 12
	dw MatchMenuItemGfx_Cancel ; record 13
	dw StoryMenuItemGfx_CharData ; record 14
	dw StoryMenuItemGfx_Items ; record 15
QueueStoryMenuCursorSprite:
	ld a, d ; $72ce
	add $fc ; $72cf
	ld d, a ; $72d1
	call AdjustSpriteCoordsForScroll ; $72d2
	ld hl, QueueStoryMenuCursorSprite_SpriteTemplate ; $72d5
	lb bc, $00, $00 ; $72d8 attr, tile
	call QueueSpriteTemplate ; $72db
	ret ; $72de
QueueStoryMenuCursorSprite_SpriteTemplate:
	; $72df, 41 bytes (sprite_template)
	oam_sprite $00, $20, $64, $02
	oam_sprite $00, $28, $66, $02
	oam_sprite $10, $08, $70, $02
	oam_sprite $10, $10, $72, $02
	oam_sprite $10, $18, $74, $02
	oam_sprite $10, $20, $76, $02
	oam_sprite $10, $28, $78, $02
	oam_sprite $10, $30, $7a, $02
	oam_sprite $10, $38, $7c, $02
	oam_sprite $10, $40, $7e, $02
	oam_sprite_end
	; $7308, 8 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
StoryMenuItemGfx_Status:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Status.bin" ; $7310, 160 bytes
StoryMenuItemGfx_ClearStatus:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_ClearStatus.bin" ; $73b0, 183 bytes
StoryMenuItemGfx_Messages:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Messages.bin" ; $7467, 171 bytes
StoryMenuItemGfx_Slow:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Slow.bin" ; $7512, 118 bytes
StoryMenuItemGfx_Fast:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Fast.bin" ; $7588, 121 bytes
StoryMenuItemGfx_CharData:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_CharData.bin" ; $7601, 175 bytes
StoryMenuItemGfx_Items:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Items.bin" ; $76b0, 125 bytes
StoryMenuItemGfx_Normal:
	INCBIN "data/bank_006/lz_StoryMenuItemGfx_Normal.bin" ; $772d, 121 bytes
DrawStoryMenuItem:
	push de ; $77a6
	add a ; $77a7
	ld_hl_indexed StoryMenuItemRectPointers ; $77a8
	ld a, [hl+] ; $77af
	ld h, [hl] ; $77b0
	ld l, a ; $77b1
	push hl ; $77b2
	call GetShadowTilemapAddr ; $77b3
	pop hl ; $77b6
	ld bc, $0302 ; $77b7
	call CopyTileRectToShadowTilemap ; $77ba
	pop de ; $77bd
	call GetShadowAttrmapAddr ; $77be
	ld hl, MenuItemAttrRect3x2 ; $77c1
	ld bc, $0302 ; $77c4
	call CopyTileRectToShadowAttrmap ; $77c7
	ret ; $77ca
StoryMenuItemRectPointers:
	; $77cb, 32 bytes (records:2)
	dw StoryMenuItemRect_Status ; record 0
	dw StoryMenuItemRect_ClearStatus ; record 1
	dw StoryMenuItemRect_Options ; record 2
	dw StoryMenuItemRect_Save ; record 3
	dw StoryMenuItemRect_Messages ; record 4
	dw StoryMenuItemRect_Music ; record 5
	dw StoryMenuItemRect_Slow ; record 6
	dw StoryMenuItemRect_Normal ; record 7
	dw StoryMenuItemRect_Fast ; record 8
	dw StoryMenuItemRect_On ; record 9
	dw StoryMenuItemRect_Off ; record 10
	dw StoryMenuItemRect_SaveNarrow ; record 11
	dw StoryMenuItemRect_ToMainMenu ; record 12
	dw StoryMenuItemRect_Cancel ; record 13
	dw StoryMenuItemRect_CharData ; record 14
	dw StoryMenuItemRect_Items ; record 15
StoryMenuItemRect_Status:
	; $77eb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $49, $4a, $4b ; row 0
	tilemap_row $59, $5a, $5b ; row 1
	tilemap_end
StoryMenuItemRect_ClearStatus:
	; $77f1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $14, $15, $16 ; row 0
	tilemap_row $24, $25, $26 ; row 1
	tilemap_end
StoryMenuItemRect_Options:
	; $77f7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $17, $18, $19 ; row 0
	tilemap_row $27, $28, $29 ; row 1
	tilemap_end
StoryMenuItemRect_Save:
	; $77fd, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $1a, $1b, $1c ; row 0
	tilemap_row $2a, $2b, $2c ; row 1
	tilemap_end
StoryMenuItemRect_Messages:
	; $7803, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $1d, $1e, $1f ; row 0
	tilemap_row $2d, $2e, $2f ; row 1
	tilemap_end
StoryMenuItemRect_Music:
	; $7809, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e0, $e1, $e2 ; row 0
	tilemap_row $f0, $f1, $f2 ; row 1
	tilemap_end
StoryMenuItemRect_Slow:
	; $780f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4c, $4d, $4e ; row 0
	tilemap_row $5c, $5d, $5e ; row 1
	tilemap_end
StoryMenuItemRect_Normal:
	; $7815, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e9, $ea, $eb ; row 0
	tilemap_row $f9, $fa, $fb ; row 1
	tilemap_end
StoryMenuItemRect_Fast:
	; $781b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $ec, $ed, $ee ; row 0
	tilemap_row $fc, $fd, $fe ; row 1
	tilemap_end
StoryMenuItemRect_On:
	; $7821, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e3, $e4, $e5 ; row 0
	tilemap_row $f3, $f4, $f5 ; row 1
	tilemap_end
StoryMenuItemRect_Off:
	; $7827, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e6, $e7, $e8 ; row 0
	tilemap_row $f6, $f7, $f8 ; row 1
	tilemap_end
StoryMenuItemRect_SaveNarrow:
	; $782d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $43, $44, $45 ; row 0
	tilemap_row $53, $54, $55 ; row 1
	tilemap_end
StoryMenuItemRect_ToMainMenu:
	; $7833, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $46, $47, $48 ; row 0
	tilemap_row $56, $57, $58 ; row 1
	tilemap_end
StoryMenuItemRect_Cancel:
	; $7839, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $60, $61, $62 ; row 0
	tilemap_row $63, $64, $65 ; row 1
	tilemap_end
StoryMenuItemRect_CharData:
	; $783f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $40, $41, $42 ; row 0
	tilemap_row $50, $51, $52 ; row 1
	tilemap_end
StoryMenuItemRect_Items:
	; $7845, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $12, $13, $4f ; row 0
	tilemap_row $22, $23, $5f ; row 1
	tilemap_end
StoryMenuItemRowTextRect:
	; $784b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
DrawStoryMenuItemRow:
	ld de, $030a ; $7863
	call GetShadowTilemapAddr ; $7866
	ld hl, StoryMenuItemRowTextRect ; $7869
	ld bc, $0c02 ; $786c
	call CopyTileRectToShadowTilemap ; $786f
	ld de, $030a ; $7872
	call GetShadowAttrmapAddr ; $7875
	ld hl, TextRectAttrs_06 ; $7878
	ld bc, $0c02 ; $787b
	call CopyTileRectToShadowAttrmap ; $787e
	ret ; $7881
CopyTileRectToShadowTilemap:
	push bc ; $7882
	push de ; $7883
.loop:
	ld a, [hl+] ; $7884
	and a ; $7885
	ld [de], a ; $7886
	inc de ; $7887
	push hl ; $7888
	ld a, e ; $7889
	and $1f ; $788a
	jr nz, .restore ; $788c
	ld h, d ; $788e
	ld l, e ; $788f
	ld de, $ffe0 ; $7890
	add hl, de ; $7893
	ld d, h ; $7894
	ld e, l ; $7895
.restore:
	pop hl ; $7896
	dec b ; $7897
	jr nz, .loop ; $7898
	pop de ; $789a
	pop bc ; $789b
	ld a, $20 ; $789c
	add e ; $789e
	ld e, a ; $789f
	jr nc, .gotPtr ; $78a0
	inc d ; $78a2
.gotPtr:
	ld a, d ; $78a3
	and $f3 ; $78a4
	ld d, a ; $78a6
	dec c ; $78a7
	jr nz, CopyTileRectToShadowTilemap ; $78a8
	ret ; $78aa
CopyTileRectToShadowAttrmap:
	push bc ; $78ab
	push de ; $78ac
.loop:
	ld a, [hl+] ; $78ad
	and a ; $78ae
	ld [de], a ; $78af
	inc de ; $78b0
	push hl ; $78b1
	ld a, e ; $78b2
	and $1f ; $78b3
	jr nz, .restore ; $78b5
	ld h, d ; $78b7
	ld l, e ; $78b8
	ld de, $ffe0 ; $78b9
	add hl, de ; $78bc
	ld d, h ; $78bd
	ld e, l ; $78be
.restore:
	pop hl ; $78bf
	dec b ; $78c0
	jr nz, .loop ; $78c1
	pop de ; $78c3
	pop bc ; $78c4
	ld a, $20 ; $78c5
	add e ; $78c7
	ld e, a ; $78c8
	jr nc, .gotPtr ; $78c9
	inc d ; $78cb
.gotPtr:
	ld a, d ; $78cc
	cp $d8 ; $78cd
	jr c, .ltd8 ; $78cf
	ld d, $d4 ; $78d1
.ltd8:
	dec c ; $78d3
	jr nz, CopyTileRectToShadowAttrmap ; $78d4
	ret ; $78d6
	; $78d7, 1833 bytes fill to bank end (linker-padded)
