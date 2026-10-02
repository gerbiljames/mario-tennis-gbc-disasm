MoveLinkCursorUp:
	ld a, [wMenuCursor2Y] ; $6d0b
	or a ; $6d0e
	jr z, .prevPage ; $6d0f
	dec a ; $6d11
	ld [wMenuCursor2Y], a ; $6d12
	jr .done ; $6d15
.prevPage:
	ldh a, [hLinkCursorPage] ; $6d17
	or a ; $6d19
	ret z ; $6d1a
	dec a ; $6d1b
	cp $02 ; $6d1c
	jr nz, .storePage ; $6d1e
	ld a, $03 ; $6d20
.storePage:
	ldh [hLinkCursorPage], a ; $6d22
.done:
	ret ; $6d24
MoveLinkCursorDown:
	ld a, [wMenuCursor2Y] ; $6d25
	inc a ; $6d28
	cp $02 ; $6d29
	jr z, .wrapPage ; $6d2b
	ld [wMenuCursor2Y], a ; $6d2d
	jr .done ; $6d30
.wrapPage:
	ldh a, [hLinkCursorPage] ; $6d32
	cp $02 ; $6d34
	jr nc, .nextPage ; $6d36
	cp $01 ; $6d38
	ret z ; $6d3a
	ld a, [wCharGridCreatedCount] ; $6d3b
	cp $07 ; $6d3e
	jr c, .done ; $6d40
	ld a, $01 ; $6d42
	ldh [hLinkCursorPage], a ; $6d44
	jr .storeRow ; $6d46
.nextPage:
	inc a ; $6d48
	ld e, a ; $6d49
	ld a, [wCharGridPageCount] ; $6d4a
	dec a ; $6d4d
	ld b, a ; $6d4e
	ld a, e ; $6d4f
	cp b ; $6d50
	jr nz, .storeRow ; $6d51
	ld a, b ; $6d53
	dec a ; $6d54
.storeRow:
	ldh [hLinkCursorPage], a ; $6d55
.done:
	ret ; $6d57
MoveLinkCursorRight:
	ld a, [wMenuCursor2X] ; $6d58
	inc a ; $6d5b
	cp $03 ; $6d5c
	jr nz, .store ; $6d5e
	ldh a, [hLinkCursorPage] ; $6d60
	or a ; $6d62
	jr z, .wrapToFirst ; $6d63
	cp $01 ; $6d65
	jr z, .wrapToFirst ; $6d67
	xor a ; $6d69
	ldh [hLinkCursorPage], a ; $6d6a
	jr .firstColumn ; $6d6c
.wrapToFirst:
	ld a, $03 ; $6d6e
	ldh [hLinkCursorPage], a ; $6d70
.firstColumn:
	xor a ; $6d72
.store:
	ld [wMenuCursor2X], a ; $6d73
	ret ; $6d76
MoveLinkCursorLeft:
	ld a, [wMenuCursor2X] ; $6d77
	dec a ; $6d7a
	cp $ff ; $6d7b
	jr nz, .store ; $6d7d
	ldh a, [hLinkCursorPage] ; $6d7f
	or a ; $6d81
	jr z, .wrapToLast ; $6d82
	cp $01 ; $6d84
	jr z, .wrapToLast ; $6d86
	xor a ; $6d88
	ldh [hLinkCursorPage], a ; $6d89
	jr .lastColumn ; $6d8b
.wrapToLast:
	ld a, $03 ; $6d8d
	ldh [hLinkCursorPage], a ; $6d8f
.lastColumn:
	ld a, $02 ; $6d91
.store:
	ld [wMenuCursor2X], a ; $6d93
	ret ; $6d96
Unused_38_RetreatLinkGridSelection:
	call RetreatToPreviousPlayerSlot ; $6d97
	cp $ff ; $6d9a
	jr nz, .clearSlot ; $6d9c
	ret ; $6d9e
.clearSlot:
	sound SFX_MENU_CANCEL ; $6d9f
	ld hl, wCharSelectSlotChars ; $6da1
	ld a, [wCharSelectSlot] ; $6da4
	add l ; $6da7
	ld l, a ; $6da8
	jr nc, .clearTaken ; $6da9
	inc h ; $6dab
.clearTaken:
	ld a, [hl] ; $6dac
	ld b, $00 ; $6dad
	ld [hl], b ; $6daf
	ld hl, wCharGridEntries ; $6db0
	add a ; $6db3
	add a ; $6db4
	add l ; $6db5
	ld l, a ; $6db6
	jr nc, .clearRecord ; $6db7
	inc h ; $6db9
.clearRecord:
	inc hl ; $6dba
	inc hl ; $6dbb
	xor a ; $6dbc
	ld [hl], a ; $6dbd
	ld a, $02 ; $6dbe
	ld [wLinkSelectSlotState], a ; $6dc0
	ret ; $6dc3
Unused_38_ConfirmRemoteGridSelection:
	ld a, [wCharSelectSlot] ; $6dc4
	ld a, [wCharGridPage] ; $6dc7
	ld c, a ; $6dca
	ld a, [wMenuCursor2X] ; $6dcb
	ld d, a ; $6dce
	ld a, [wMenuCursor2Y] ; $6dcf
	ld e, a ; $6dd2
	call TestAndSetGridEntryTaken ; $6dd3
	or a ; $6dd6
	jr nz, .done ; $6dd7
	call GetGridSlotFromCursor ; $6dd9
	ld b, a ; $6ddc
	ld hl, wCharGridEntries ; $6ddd
	add a ; $6de0
	add a ; $6de1
	add l ; $6de2
	ld l, a ; $6de3
	jr nc, .refresh ; $6de4
	inc h ; $6de6
.refresh:
	ld a, [hl] ; $6de7
	cp $ff ; $6de8
	jr z, .done ; $6dea
	ld a, [wCharSelectSlot] ; $6dec
	ld hl, wCharSelectSlotChars ; $6def
	add l ; $6df2
	ld l, a ; $6df3
	jr nc, .redraw ; $6df4
	inc h ; $6df6
.redraw:
	ld [hl], b ; $6df7
	ld a, $01 ; $6df8
	ld [wLinkSelectSlotState], a ; $6dfa
	jr .noSelection ; $6dfd
.done:
	xor a ; $6dff
	ret ; $6e00
.noSelection:
	ld a, $01 ; $6e01
	ret ; $6e03
WaitLinkSelectStartupFrames:
	ld a, [wLinkSelectStartupFrames] ; $6e04
	cp $03 ; $6e07
	jr z, .yes ; $6e09
	inc a ; $6e0b
	ld [wLinkSelectStartupFrames], a ; $6e0c
	xor a ; $6e0f
	ret ; $6e10
.yes:
	ld a, $01 ; $6e11
	ret ; $6e13
RunNameEntryScreen:
	ld a, b ; $6e14
	ld [wStoryCharacterSlot], a ; $6e15
	wram_bank WRAM_COURT_PLANES ; $6e18
	ld a, c ; $6e1e
	ld [wScreenAttrmap + 1], a ; $6e1f
	call DisableLCDSafely ; $6e22
	call ClearFrameTasks ; $6e25
	call SetupNameEntryScreen ; $6e28
	ld a, $01 ; $6e2b
	ld hl, UpdateAnimatedTilesTask_38 ; $6e2d
	call RegisterFrameTask ; $6e30
	ld a, $01 ; $6e33
	ld hl, DrawNameEntryCursor ; $6e35
	call RegisterFrameTask ; $6e38
	ld a, $01 ; $6e3b
	ld hl, DrawNameEntryUnderlineSprites ; $6e3d
	call RegisterFrameTask ; $6e40
	call EnableLCD ; $6e43
	script_fade_in $10 ; $6e46
	call WaitFadeEnd ; $6e4b
	ld hl, rIE ; $6e4e
	res 2, [hl] ; $6e51
	ld a, $01 ; $6e53
	ld hl, TickMenuBgScrollTask_38 ; $6e55
	call RegisterFrameTask ; $6e58
.redraw:
	ld a, [wMenuCursorX] ; $6e5b
	push de ; $6e5e
	push af ; $6e5f
	ld a, a ; $6e60
	ld_cell de, $03, $03 ; $6e61
	call PrintDecimalByte ; $6e64
	pop af ; $6e67
	pop de ; $6e68
	ldh a, [hInputPressed] ; $6e69
	ld [wMenuInputPressed], a ; $6e6b
	ld b, $0f ; $6e6e
	ld c, $06 ; $6e70
	call MoveMenuCursorGrid_38 ; $6e72
	or a ; $6e75
	jr z, .inputLoop ; $6e76
	call HandleNameEntryCursorMove ; $6e78
.inputLoop:
	call AdvanceFrame ; $6e7b
	ld a, [wMenuInputPressed] ; $6e7e
	bit PADB_A, a ; $6e81
	jr nz, .pressA ; $6e83
	bit 1, a ; $6e85
	jr nz, .pressB ; $6e87
	bit 2, a ; $6e89
	jr nz, .beep ; $6e8b
	jr .redraw ; $6e8d
.pressA:
	ld a, [wMenuCursorY] ; $6e8f
	cp $05 ; $6e92
	jr z, .bottomRow ; $6e94
	call AppendCharToName ; $6e96
	jr .redraw ; $6e99
.bottomRow:
	call GetNameEntryBottomRowAction ; $6e9b
	or a ; $6e9e
	jr z, .beep ; $6e9f
	cp $01 ; $6ea1
	jr z, .backspace ; $6ea3
	jr .accept ; $6ea5
.beep:
	sound SFX_MENU_MOVE ; $6ea7
.backspace:
	sound SFX_MENU_CANCEL ; $6ea9
	call DeleteLastNameChar ; $6eab
	jr .redraw ; $6eae
.pressB:
	sound SFX_MENU_CANCEL ; $6eb0
	push_wram_bank WRAM_SCREEN ; $6eb2
	ld a, [wNameEntryBuffer] ; $6ebb
	ld b, a ; $6ebe
	pop_wram_bank ; $6ebf
	ld a, b ; $6ec4
	cp $00 ; $6ec5
	jr z, .cancel ; $6ec7
	call DeleteLastNameChar ; $6ec9
	jr .redraw ; $6ecc
.cancel:
	sound SFX_MENU_CANCEL ; $6ece
	ld c, $10 ; $6ed0
	call BeginFadeOut ; $6ed2
	call WaitFadeEnd ; $6ed5
	call ClearFrameTasks ; $6ed8
	ld hl, rIE ; $6edb
	set 2, [hl] ; $6ede
	ld a, $ff ; $6ee0
	ret ; $6ee2
.accept:
	push_wram_bank WRAM_SCREEN ; $6ee3
	ld a, [wNameEntryBuffer] ; $6eec
	ld b, a ; $6eef
	pop_wram_bank ; $6ef0
	ld a, b ; $6ef5
	cp $00 ; $6ef6
	jr z, .storeName ; $6ef8
	wram_bank WRAM_SCREEN ; $6efa
	call TrimTrailingSpacesFromName ; $6f00
	call GetActiveStoryNameBuffer ; $6f03
	ld d, b ; $6f06
	ld e, c ; $6f07
	ld hl, wNameEntryBuffer ; $6f08
	ld bc, $000b ; $6f0b
	call CopyMemoryBC ; $6f0e
	sound SFX_MENU_SELECT ; $6f11
	ld c, $10 ; $6f13
	call BeginFadeOut ; $6f15
	call WaitFadeEnd ; $6f18
	call ClearFrameTasks ; $6f1b
	ld hl, rIE ; $6f1e
	set 2, [hl] ; $6f21
	ld a, $00 ; $6f23
	ret ; $6f25
.storeName:
	wram_bank WRAM_SCREEN ; $6f26
	call GetActiveStoryNameBuffer ; $6f2c
	ld h, b ; $6f2f
	ld l, c ; $6f30
	ld de, wNameEntryBuffer ; $6f31
	ld bc, $000b ; $6f34
	call CopyMemoryBC ; $6f37
	call GetActiveStoryNameBuffer ; $6f3a
	ld d, b ; $6f3d
	ld e, c ; $6f3e
	ld hl, wNameEntryBuffer ; $6f3f
	ld bc, $000b ; $6f42
	call CopyMemoryBC ; $6f45
	call DrawEnteredName ; $6f48
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $6f4b
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $6f4e
	ld c, $04 ; $6f51
	call QueueVRAMCopy ; $6f53
	call AdvanceFrame ; $6f56
	sound SFX_MENU_SELECT ; $6f59
	ld c, $10 ; $6f5b
	call BeginFadeOut ; $6f5d
	call WaitFadeEnd ; $6f60
	call ClearFrameTasks ; $6f63
	ld hl, rIE ; $6f66
	set 2, [hl] ; $6f69
	ld a, $00 ; $6f6b
	ret ; $6f6d
SetupNameEntryScreen:
	ld b, TILEBLOCK_NameEntryGfx ; $6f6e
	ld c, NameEntryGfx_SIZE / 16 ; $6f70
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $6f72
	farcall LoadCompressedTileBlock ; $6f75
	ld hl, vTiles0 + VRAM_BANK1 ; $6f78
	ld de, $0801 ; $6f7b
	farcall LoadMenuHandCursorGfx ; $6f7e
	ld b, $0f ; $6f81
	ld c, $00 ; $6f83
	call SetMenuCursorFromIndex_38 ; $6f85
	ld c, SCREENASSET_NameEntry ; $6f88
	farcall LoadScreenAssetRecord ; $6f8a
	farcall ResetTextWindowState ; $6f8d
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $6f90
	ld c, SharedMenuGfx17_SIZE / 16 ; $6f92
	ld de, vTiles2 ; $6f94
	farcall LoadCompressedTileBlock ; $6f97
	wram_bank WRAM_TEXT ; $6f9a
	ld a, $03 ; $6fa0
	ld [wShadowTilemapBank], a ; $6fa2
	ld a, $00 ; $6fa5
	ld [wWindowTileAttr], a ; $6fa7
	ld d, $00 ; $6faa
	ld e, $02 ; $6fac
	ld b, $14 ; $6fae
	ld c, $03 ; $6fb0
	farcall CreateWindowFromScreenRect ; $6fb2
	farcall DrawTextWindowFrame ; $6fb5
	farcall RedrawWindowRows ; $6fb8
	ld d, $00 ; $6fbb
	ld e, $08 ; $6fbd
	ld b, $14 ; $6fbf
	ld c, $09 ; $6fc1
	farcall CreateWindowFromScreenRect ; $6fc3
	farcall DrawTextWindowFrame ; $6fc6
	farcall RedrawWindowRows ; $6fc9
	ld d, $06 ; $6fcc
	ld e, $05 ; $6fce
	ld b, $09 ; $6fd0
	ld c, $03 ; $6fd2
	farcall CreateWindowFromScreenRect ; $6fd4
	farcall DrawTextWindowFrame ; $6fd7
	farcall RedrawWindowRows ; $6fda
	ld hl, NameEntryCharset_38 ; $6fdd
	call DrawNameEntryCharGrid ; $6fe0
	call DrawEnterNameLabel ; $6fe3
	ld b, $0a ; $6fe6
	ld c, $0c ; $6fe8
	farcall LoadIndexedPalette ; $6fea
	push_wram_bank WRAM_COURT_PLANES ; $6fed
	ld a, [wScreenAttrmap + 1] ; $6ff6
	farcall LoadCharMugshotToBuffer ; $6ff9
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $6ffc
	farcall CopyMugshotBufferToVram ; $6fff
	wram_bank WRAM_COURT_PLANES ; $7002
	call GetActiveStoryNameBuffer ; $7008
	ld hl, $000c ; $700b
	add hl, bc ; $700e
	ld a, [hl] ; $700f
	ld d, $04 ; $7010
	farcall LoadIndexedPalette_18 ; $7012
	pop_wram_bank ; $7015
	farcall InitMenuBgScroll ; $701a
	ld b, $01 ; $701d
	ld c, $01 ; $701f
	farcall LoadMenuSpritePalettePair ; $7021
	ld a, $10 ; $7024
	ld [wMenuBgScrollTile], a ; $7026
	ld [wMenuBgScrollTile + 1], a ; $7029
	ld b, TILEBLOCK_SharedMenuGfx72 ; $702c
	ld c, SharedMenuGfx72_SIZE / 16 ; $702e
	ld de, vTiles0 + $10 * TILE_SIZE ; $7030
	farcall LoadCompressedTileBlock ; $7033
	push_wram_bank WRAM_COURT_PLANES ; $7036
	xor a ; $703f
	ld [wScreenAttrmap], a ; $7040
	wram_bank WRAM_SCREEN ; $7043
	call GetActiveStoryNameBuffer ; $7049
	ld h, b ; $704c
	ld l, c ; $704d
	ld de, wNameEntryBuffer ; $704e
	ld bc, $000b ; $7051
	call CopyMemoryBC ; $7054
	pop_wram_bank ; $7057
	call DrawEnteredName ; $705c
	farcall QueueWram3MapToVRAM ; $705f
	ret ; $7062
; Four bytes ($01 $03 $02 $00, a permutation of four slots) followed by
; ten $3f bytes and a $00 -- eleven bytes, exactly the size of
; wNameEntryBuffer and the length SetupNameEntryScreen copies with
; `ld bc, $000b`. It reads as a blank-name template, but that routine
; takes its eleven bytes from GetActiveStoryNameBuffer, not from here.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_38_NameEntryBlank:
	; $7063, 15 bytes (bytes:15)
	db $01, $03, $02, $00, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $00 ; 0x00
HandleNameEntryCursorMove:
	sound SFX_MENU_MOVE ; $7072
	ld a, [wMenuCursorY] ; $7074
	cp $05 ; $7077
	jr nz, .done ; $7079
	ldh a, [hInputPressed] ; $707b
	bit PADB_RIGHT, a ; $707d
	jr nz, .snapRight ; $707f
	bit 5, a ; $7081
	jr nz, .snapLeft ; $7083
	jr .done ; $7085
.snapRight:
	call SnapNameEntryCursorRight ; $7087
	jr .done ; $708a
.snapLeft:
	call SnapNameEntryCursorLeft ; $708c
.done:
	ret ; $708f
DrawNameEntryCursor:
	ld c, $0f ; $7090
	call GetMenuCursorIndex_38 ; $7092
	add a ; $7095
	ld hl, NameEntryCursorTable ; $7096
	add l ; $7099
	ld l, a ; $709a
	jr nc, .read ; $709b
	inc h ; $709d
.read:
	ld a, [hl+] ; $709e
	ld d, [hl] ; $709f
	ld e, a ; $70a0
	call QueueNameEntryCursorSprites ; $70a1
	ret ; $70a4
NameEntryCursorTable:
	INCBIN "data/bank_038/NameEntryCursorTable.bin" ; $70a5, 180 bytes
DrawEnterNameLabel:
	push_wram_bank WRAM_SCREEN ; $7159
	ld hl, EnterNameText_38 ; $7162
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $7165
	call DrawNameWithDiacritics_38 ; $7168
	pop_wram_bank ; $716b
	ret ; $7170
EnterNameText_38:
	INCLUDE "data/bank_038/EnterNameText_38.asm" ; $7171, 11 bytes
DrawNameEntryCharGrid:
	push_wram_bank WRAM_SCREEN ; $717c
	ld c, $05 ; $7185
	ld b, $03 ; $7187
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH + 1 ; $7189
.lowerCase:
	ld a, $20 ; $718c
	ld [de], a ; $718e
	inc de ; $718f
.drawRows:
	ld a, [hl+] ; $7190
	push hl ; $7191
	ld h, d ; $7192
	ld l, e ; $7193
	ld [hl+], a ; $7194
	ld d, h ; $7195
	ld e, l ; $7196
	pop hl ; $7197
	dec c ; $7198
	jr nz, .drawRows ; $7199
	ld c, $05 ; $719b
	dec b ; $719d
	jr nz, .lowerCase ; $719e
	ld a, [hl] ; $71a0
	or a ; $71a1
	jr z, .done ; $71a2
	ld b, $03 ; $71a4
	push hl ; $71a6
	ld hl, $000e ; $71a7
	add hl, de ; $71aa
	ld d, h ; $71ab
	ld e, l ; $71ac
	pop hl ; $71ad
	jr .lowerCase ; $71ae
.done:
	pop_wram_bank ; $71b0
	ret ; $71b5
NameEntryCharset_38:
	INCLUDE "data/bank_038/NameEntryCharset_38.asm" ; $71b6, 106 bytes
GetNameEntryBottomRowAction:
	ld hl, NameEntryBottomRowActionTable ; $7220
	ld a, [wMenuCursorX] ; $7223
	add l ; $7226
	ld l, a ; $7227
	jr nc, .read ; $7228
	inc h ; $722a
.read:
	ld a, [hl] ; $722b
	ret ; $722c
NameEntryBottomRowActionTable:
	; $722d, 15 bytes (bytes:15)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02 ; 0x00
SnapNameEntryCursorRight:
	ld hl, SnapNameEntryCursorRightTable ; $723c
	ld a, [wMenuCursorX] ; $723f
	add l ; $7242
	ld l, a ; $7243
	jr nc, .read ; $7244
	inc h ; $7246
.read:
	ld a, [hl] ; $7247
	ld [wMenuCursorX], a ; $7248
	ret ; $724b
SnapNameEntryCursorRightTable:
	; $724c, 15 bytes (bytes:15)
	db $07, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $07, $07, $07, $07 ; 0x00
SnapNameEntryCursorLeft:
	ld hl, SnapNameEntryCursorLeftTable ; $725b
	ld a, [wMenuCursorX] ; $725e
	add l ; $7261
	ld l, a ; $7262
	jr nc, .read ; $7263
	inc h ; $7265
.read:
	ld a, [hl] ; $7266
	ld [wMenuCursorX], a ; $7267
	ret ; $726a
SnapNameEntryCursorLeftTable:
	; $726b, 15 bytes (bytes:15)
	db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $07, $07, $07, $07, $07, $0a ; 0x00
QueueNameEntryCursorSprites:
	ld c, $00 ; $727a
	ld b, $08 ; $727c
	push de ; $727e
	call QueueSprite ; $727f
	pop de ; $7282
	ld a, $08 ; $7283
	add d ; $7285
	ld d, a ; $7286
	ld c, $02 ; $7287
	ld b, $08 ; $7289
	call QueueSprite ; $728b
	ret ; $728e
