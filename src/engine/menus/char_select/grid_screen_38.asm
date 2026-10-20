UpdateCharSelectCharSprite:
	ld c, l ; $4ce2
	ld b, h ; $4ce3
	ld hl, wCharObjectBank - wCharStruct ; $4ce4
	add hl, bc ; $4ce7
	ld a, [hl] ; $4ce8
	and a ; $4ce9
	ret z ; $4cea
	ld l, c ; $4ceb
	ld h, b ; $4cec
	push hl ; $4ced
	ld de, wCharStruct ; $4cee
	ld c, $08 ; $4cf1
	call CopyMemoryFast ; $4cf3
	farcall EaseCharFacing ; $4cf6
	farcall StepCharAnimation ; $4cf9
	ld d, $02 ; $4cfc
	ld a, d ; $4cfe
	ld [wCharFacingOctant], a ; $4cff
	push de ; $4d02
	farcall ReloadCharFacingTiles ; $4d03
	pop de ; $4d06
	farcall BuildCharSpriteSlots ; $4d07
	pop de ; $4d0a
	ld hl, wCharStruct ; $4d0b
	ld c, $06 ; $4d0e
	call CopyMemoryFast ; $4d10
	ret ; $4d13
SetCharSelectAnimations:
	wram_bank WRAM_ACTORS ; $4d14
	ld d, CHARANIM_STAND ; $4d1a
	farcall SetCharAnimation ; $4d1c
	wram_bank WRAM_TEXT ; $4d1f
	ld d, CHARANIM_STAND ; $4d25
	farcall SetCharAnimation ; $4d27
	wram_bank WRAM_SCENE ; $4d2a
	ld d, CHARANIM_STAND ; $4d30
	farcall SetCharAnimation ; $4d32
	wram_bank WRAM_SOUND ; $4d35
	ld d, CHARANIM_STAND ; $4d3b
	farcall SetCharAnimation ; $4d3d
	call GetSelectedCharWramBank ; $4d40
	wram_bank b ; $4d43
	ld d, CHARANIM_FOREHAND ; $4d48
	farcall SetCharAnimation ; $4d4a
	wram_bank WRAM_ACTORS ; $4d4d
	push_wram_bank WRAM_COURT_PLANES ; $4d53
	xor a ; $4d5c
	ld [wCharSelectIdleAnimState], a ; $4d5d
	pop_wram_bank ; $4d60
	ret ; $4d65
ReloadSelectedCharGfx:
	ld b, $0b ; $4d66
	ld c, $0b ; $4d68
	farcall LoadIndexedPalette ; $4d6a
	ld b, $0c ; $4d6d
	ld c, $0b ; $4d6f
	farcall LoadIndexedPalette ; $4d71
	ld b, $0d ; $4d74
	ld c, $0b ; $4d76
	farcall LoadIndexedPalette ; $4d78
	ld b, $0e ; $4d7b
	ld c, $0b ; $4d7d
	farcall LoadIndexedPalette ; $4d7f
	ld b, $0f ; $4d82
	ld c, $0b ; $4d84
	farcall LoadIndexedPalette ; $4d86
	call GetSelectedCharWramBank ; $4d89
	wram_bank b ; $4d8c
	farcall ReloadCharPalette ; $4d91
	wram_bank WRAM_CHAR0 ; $4d94
	ret ; $4d9a
TickCharSelectIdleAnim:
	call GetSelectedCharWramBank ; $4d9b
	wram_bank b ; $4d9e
	ld bc, wCharStruct ; $4da3
	ld hl, wCharAnimId - wCharStruct ; $4da6
	add hl, bc ; $4da9
	ld a, [hl] ; $4daa
	cp CHARANIM_IDLE ; $4dab
	jr nz, .done ; $4dad
	push_wram_bank WRAM_COURT_PLANES ; $4daf
	ld a, [wCharSelectIdleAnimState] ; $4db8
	inc a ; $4dbb
	ld [wCharSelectIdleAnimState], a ; $4dbc
	ld d, a ; $4dbf
	pop_wram_bank ; $4dc0
	ld a, d ; $4dc5
	and $1f ; $4dc6
	jr nz, .done ; $4dc8
	ld d, CHARANIM_FOREHAND ; $4dca
	farcall SetCharAnimation ; $4dcc
	push_wram_bank WRAM_COURT_PLANES ; $4dcf
	ld a, [wCharSelectIdleTimer] ; $4dd8
	inc a ; $4ddb
	ld [wCharSelectIdleTimer], a ; $4ddc
	cp $0f ; $4ddf
	jr nz, .restore ; $4de1
	xor a ; $4de3
	ld [wCharSelectIdleTimer], a ; $4de4
	call GetSelectedCharWramBank ; $4de7
	wram_bank b ; $4dea
	ld d, CHARANIM_OVERHEAD ; $4def
	farcall SetCharAnimation ; $4df1
.restore:
	pop_wram_bank ; $4df4
.done:
	ret ; $4df9
GetSelectedCharWramBank:
	ld c, $02 ; $4dfa
	call GetMenuCursorIndex_38 ; $4dfc
	ld b, a ; $4dff
	push_wram_bank WRAM_COURT_PLANES ; $4e00
	ld a, [wCharSelectIsPartner] ; $4e09
	ld c, a ; $4e0c
	pop_wram_bank ; $4e0d
	ld a, c ; $4e12
	add a ; $4e13
	add b ; $4e14
	ld hl, SelectedCharWramBankTable ; $4e15
	add_hl_a ; $4e18
	ld b, [hl] ; $4e1d
	ret ; $4e1e
SelectedCharWramBankTable:
	; $4e1f, 4 bytes (bytes:4)
	db $04, $05, $06, $07 ; 0x00
DrawCharacterSelectCursor:
	ld c, $02 ; $4e23
	call GetMenuCursorIndex_38 ; $4e25
	add a ; $4e28
	ld hl, CharacterSelectCursorTable ; $4e29
	add_hl_a ; $4e2c
	ld a, [hl+] ; $4e31
	ld d, [hl] ; $4e32
	ld e, a ; $4e33
	wram_bank WRAM_COURT_PLANES ; $4e34
	ld c, $00 ; $4e3a
	ld a, [wCharSelectHandedness] ; $4e3c
	or a ; $4e3f
	jr nz, .gotColumn ; $4e40
	ld c, $02 ; $4e42
.gotColumn:
	ld b, 0 ; $4e44
	call QueueSprite ; $4e46
	ret ; $4e49
CharacterSelectCursorTable:
	; $4e4a, 8 bytes (bytes:8)
	db $54, $2c, $54, $6d, $6d, $2c, $6d, $6d ; 0x00
TickMenuBgScrollTask_38:
	farcall TickMenuBgScroll ; $4e52
	ret ; $4e55
Unused_38_WramBank3Nop:
	push_wram_bank WRAM_SCREEN ; $4e56
	pop_wram_bank ; $4e5f
	ret ; $4e64
RunExhibitionCharSelectScreen:
	sound BGM_MENU ; $4e65
	wram_bank WRAM_SCREEN ; $4e67
	ld a, b ; $4e6d
	ld [wCharSelectMode], a ; $4e6e
	ld a, HAND_UNCHOSEN ; $4e71
	ld [wCharGridHandedness], a ; $4e73
	call DisableLCDSafely ; $4e76
	farcall LoadMenuFontGfx ; $4e79
	xor a ; $4e7c
	ld [wCharSelectRemoteSlot], a ; $4e7d
	ld hl, wCharGridEntries ; $4e80
	ld bc, wCharGridEntries_SIZE ; $4e83
	call ClearBytes ; $4e86
	call BuildCharUnlockFlags ; $4e89
	call SetupCharGridScreen ; $4e8c
	call EnableLCD ; $4e8f
	script_fade_in 16 ; $4e92
	call WaitFadeEnd ; $4e97
	ld hl, rIE ; $4e9a
	res B_IE_TIMER, [hl] ; $4e9d
	frame_task TickMenuBgScrollTask_38 ; $4e9f
	call RefreshCharInfoPanel ; $4ea7
.frameLoop:
	call AdvanceFrame ; $4eaa
	ldh a, [hInputPressed] ; $4ead
	ld [wMenuInputPressed], a ; $4eaf
	wram_bank WRAM_SCREEN ; $4eb2
	ld a, [wCharGridRightPressCount] ; $4eb8
	push de ; $4ebb
	push af ; $4ebc
	ld a, a ; $4ebd
	ld_cell de, $03, $01 ; $4ebe
	call PrintDecimalByte ; $4ec1
	pop af ; $4ec4
	pop de ; $4ec5
	ld a, [wCpuDifficultyPrompt] ; $4ec6
	or a ; $4ec9
	jr z, .confirm ; $4eca
	call DrawCharGridCharSprites ; $4ecc
	call RunCpuDifficultySubmenu ; $4ecf
	ldh a, [hWramBank] ; $4ed2
	push af ; $4ed4
	jr .redraw ; $4ed5
.confirm:
	call HandleCharGridDpad ; $4ed7
	call HandleCharGridButtons ; $4eda
	xor a ; $4edd
	ld [wMenuInputPressed], a ; $4ede
	ldh [hInputPressed], a ; $4ee1
	push_wram_bank WRAM_SCREEN ; $4ee3
	ld a, [wCharSelectSlot] ; $4eec
	cp CHARSELECTSLOT_DONE ; $4eef
	jr z, .cancel ; $4ef1
	call DrawCharGridCursorBox ; $4ef3
	call DrawCharGridCharSprites ; $4ef6
	call DrawCharGridScrollArrows ; $4ef9
	jr .redraw ; $4efc
.cancel:
	call DrawCharGridWaitBanner ; $4efe
.redraw:
	ld a, [wCharSelectExitCode] ; $4f01
	ld b, a ; $4f04
	pop_wram_bank ; $4f05
	ld a, b ; $4f0a
	cp CHARSELECT_DONE ; $4f0b
	jr z, .finish ; $4f0d
	cp CHARSELECT_CANCELLED ; $4f0f
	jr z, .done ; $4f11
	jr .frameLoop ; $4f13
.finish:
	script_fade_out 8 ; $4f15
	call WaitFadeEnd ; $4f1a
	call ResolveSelectedCharIds ; $4f1d
	call InitMatchCharsFromSelection ; $4f20
	call ApplyHandednessToCharRecords ; $4f23
	call ApplyCpuDifficultyToCharRecords ; $4f26
	farcall InitDefaultMatchSettings ; $4f29
	call ClearFrameTasks ; $4f2c
	ld hl, rIE ; $4f2f
	set B_IE_TIMER, [hl] ; $4f32
	xor a ; $4f34
	ret ; $4f35
.done:
	sound SFX_MENU_CANCEL ; $4f36
	script_fade_out 16 ; $4f38
	call WaitFadeEnd ; $4f3d
	call ClearFrameTasks ; $4f40
	ld hl, rIE ; $4f43
	set B_IE_TIMER, [hl] ; $4f46
	ld a, $ff ; $4f48
	ret ; $4f4a
DrawCharGridCursorBox:
	ld c, $03 ; $4f4b
	call GetMenuCursorIndex_38 ; $4f4d
	add a ; $4f50
	ld hl, CharGridCursorBoxTable ; $4f51
	add_hl_a ; $4f54
	ld a, [hl+] ; $4f59
	ld d, [hl] ; $4f5a
	ld e, a ; $4f5b
	ld bc, $1008 ; $4f5c
	call DrawSelectedOptionBox ; $4f5f
	ret ; $4f62
CharGridCursorBoxTable:
	; $4f63, 12 bytes (bytes:12)
	db $30, $09, $30, $21, $30, $39, $4a, $09, $4a, $21, $4a, $39 ; 0x00
SetupCharGridScreen:
	xor a ; $4f6f
	ldh [hScrollX], a ; $4f70
	ldh [hScrollY], a ; $4f72
	ld [wCameraX], a ; $4f74
	ld [wCameraX + 1], a ; $4f77
	ld [wCameraY], a ; $4f7a
	ld [wCameraY + 1], a ; $4f7d
	call BuildCreatedCharRecords ; $4f80
	ld b, $03 ; $4f83
	ld c, $00 ; $4f85
	call SetMenuCursorFromIndex_38 ; $4f87
	wram_bank WRAM_STAGING ; $4f8a
	ld hl, CharGridArrowSpriteGfx ; $4f90
	ld de, wDecompBuffer ; $4f93
	call DecompressData ; $4f96
	ld hl, wDecompBuffer ; $4f99
	ld de, vTiles0 tile $10 + VRAM_BANK1 ; $4f9c
	ld c, CharGridArrowSpriteGfx_SIZE / 16 ; $4f9f
	call QueueVRAMCopy ; $4fa1
	ld hl, CharGridScreenObjPalette ; $4fa4
	ld_obj_pals de, 1, 1 ; $4fa7
	call LoadPalettesMasterOnly ; $4faa
	wram_bank WRAM_STAGING ; $4fad
	ld hl, PleaseWaitSpriteGfx ; $4fb3
	ld de, wDecompBuffer ; $4fb6
	call DecompressData ; $4fb9
	ld hl, wDecompBuffer ; $4fbc
	ld de, vTiles0 tile $20 + VRAM_BANK1 ; $4fbf
	ld c, PleaseWaitSpriteGfx_SIZE / 16 ; $4fc2
	call QueueVRAMCopy ; $4fc4
	ld c, SCREENASSET_ExhibitionSetup ; $4fc7
	farcall LoadScreenAssetRecord ; $4fc9
	farcall ResetTextWindowState ; $4fcc
	wram_bank WRAM_TEXT ; $4fcf
	ld a, WRAM_SCREEN ; $4fd5
	ld [wShadowTilemapBank], a ; $4fd7
	ld a, $00 ; $4fda
	ld [wWindowTileAttr], a ; $4fdc
	rect_cell $00, $02 ; $4fdf
	rect_size $14, $03 ; $4fe3
	farcall CreateWindowFromScreenRect ; $4fe7
	farcall DrawTextWindowFrame ; $4fea
	farcall RedrawWindowRows ; $4fed
	rect_cell $00, $0c ; $4ff0
	rect_size $14, $06 ; $4ff4
	farcall CreateWindowFromScreenRect ; $4ff8
	farcall DrawTextWindowFrame ; $4ffb
	farcall RedrawWindowRows ; $4ffe
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $5001
	ld c, SharedMenuGfx17_SIZE / 16 ; $5003
	ld de, vTiles2 ; $5005
	farcall LoadCompressedTileBlock ; $5008
	ld b, TILEBLOCK_StatLabelTiles ; $500b
	ld c, StatLabelTiles_SIZE / 16 ; $500d
	ld de, vTiles2 tile $10 ; $500f
	farcall LoadCompressedTileBlock ; $5012
	ld b, TILEBLOCK_CharGridStatLabelSpriteGfx ; $5015
	ld c, CharGridStatLabelSpriteGfx_SIZE / 16 ; $5017
	ld de, vTiles0 tile $50 + VRAM_BANK1 ; $5019
	farcall LoadCompressedTileBlock ; $501c
	ld b, TILEBLOCK_DigitFontTiles ; $501f
	ld c, DigitFontTiles_SIZE / 16 ; $5021
	ld de, vTiles0 tile $64 + VRAM_BANK1 ; $5023
	farcall LoadCompressedTileBlock ; $5026
	ld de, vTiles0 ; $5029
	call LoadAllCharPortraitTiles ; $502c
	ld de, vTiles1 + VRAM_BANK1 ; $502f
	call LoadAllCharPortraitTiles ; $5032
	call InitCharGridState ; $5035
	call DrawCharGridSlotPrompt ; $5038
	call DrawCharGridSlotIcons ; $503b
	farcall QueueWram3MapToVRAM ; $503e
	ld de, vTiles0 + VRAM_BANK1 ; $5041
	farcall LoadCornerBracketCursorGfx ; $5044
	ld hl, CharGridScreenPalettes ; $5047
	ld_obj_pals de, 3, 5 ; $504a
	call LoadPalettesMasterOnly ; $504d
	ld c, $0b ; $5050
	ld b, $0a ; $5052
	farcall LoadIndexedPalette ; $5054
	farcall InitMenuBgScroll ; $5057
	ld b, $01 ; $505a
	ld c, $01 ; $505c
	farcall LoadMenuSpritePalettePair ; $505e
	ld a, $30 ; $5061
	ld [wMenuBgScrollTile], a ; $5063
	ld [wMenuBgScrollTile + 1], a ; $5066
	ld a, $09 ; $5069
	ld [wMenuBgScrollAttr], a ; $506b
	ld [wMenuBgScrollAttr + 1], a ; $506e
	ld b, TILEBLOCK_SelectACharacterTitleGfx ; $5071
	ld c, SelectACharacterTitleGfx_SIZE / 16 ; $5073
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $5075
	farcall LoadCompressedTileBlock ; $5078
	farcall InitDefaultMatchSettings ; $507b
	ret ; $507e
CharGridScreenPalettes:
	INCLUDE "data/engine/menus/char_select/CharGridScreenPalettes.asm" ; $507f, 40 bytes (palettes)
CharGridArrowSpriteGfx:
	INCBIN "data/engine/menus/char_select/lz_CharGridArrowSpriteGfx.bin" ; $50a7, 74 bytes
	INCLUDE "data/engine/menus/char_select/lz_CharGridArrowSpriteGfx.inc" ; DEF CharGridArrowSpriteGfx_SIZE EQU its decoded length, generated from the .bin by make
CharGridScreenObjPalette:
	INCLUDE "data/engine/menus/char_select/CharGridScreenObjPalette.asm" ; $50f1, 8 bytes (palettes)
PleaseWaitSpriteGfx:
	INCBIN "data/engine/menus/char_select/lz_PleaseWaitSpriteGfx.bin" ; $50f9, 156 bytes
	INCLUDE "data/engine/menus/char_select/lz_PleaseWaitSpriteGfx.inc" ; DEF PleaseWaitSpriteGfx_SIZE EQU its decoded length, generated from the .bin by make
HandleCharGridDpad:
	push_wram_bank WRAM_SCREEN ; $5195
	ld a, [wCharSelectSlot] ; $519e
	cp CHARSELECTSLOT_DONE ; $51a1
	jr z, .done ; $51a3
	ld a, [wMenuInputPressed] ; $51a5
	ldh a, [hInputPressed] ; $51a8
	bit PADB_RIGHT, a ; $51aa
	jr nz, .moveRight ; $51ac
	bit PADB_LEFT, a ; $51ae
	jr nz, .moveLeft ; $51b0
	bit PADB_UP, a ; $51b2
	jr nz, .moveUp ; $51b4
	bit PADB_DOWN, a ; $51b6
	jr nz, .moveDown ; $51b8
	jr .done ; $51ba
.moveRight:
	ld a, [wCharGridRightPressCount] ; $51bc
	inc a ; $51bf
	ld [wCharGridRightPressCount], a ; $51c0
	ld a, HAND_UNCHOSEN ; $51c3
	ld [wCharGridHandedness], a ; $51c5
	call MoveCharGridCursorRight ; $51c8
	xor a ; $51cb
	ld [wMenuInputPressed], a ; $51cc
	jp .done ; $51cf
.moveLeft:
	ld a, HAND_UNCHOSEN ; $51d2
	ld [wCharGridHandedness], a ; $51d4
	call MoveCharGridCursorLeft ; $51d7
	jr .done ; $51da
.moveUp:
	ld a, HAND_UNCHOSEN ; $51dc
	ld [wCharGridHandedness], a ; $51de
	call MoveCharGridCursorUp ; $51e1
	jr .done ; $51e4
.moveDown:
	ld a, HAND_UNCHOSEN ; $51e6
	ld [wCharGridHandedness], a ; $51e8
	call MoveCharGridCursorDown ; $51eb
.done:
	pop_wram_bank ; $51ee
	ret ; $51f3
MoveCharGridCursorUp:
	ld a, [wMenuCursorY] ; $51f4
	or a ; $51f7
	jr z, .prevPage ; $51f8
	dec a ; $51fa
	ld [wMenuCursorY], a ; $51fb
	sound SFX_MENU_MOVE ; $51fe
	jr .refresh ; $5200
.prevPage:
	ld a, [wCharGridPage] ; $5202
	or a ; $5205
	ret z ; $5206
	dec a ; $5207
	cp $02 ; $5208
	jr nz, .beep ; $520a
	ld a, $03 ; $520c
	jr .storePage ; $520e
.beep:
	sound SFX_MENU_MOVE ; $5210
.storePage:
	ld [wCharGridPage], a ; $5212
	call BuildVisiblePageSpriteList ; $5215
.refresh:
	call RefreshCharInfoPanel ; $5218
	ret ; $521b
MoveCharGridCursorDown:
	ld a, [wMenuCursorY] ; $521c
	inc a ; $521f
	cp $02 ; $5220
	jr z, .nextPage ; $5222
	ld [wMenuCursorY], a ; $5224
	sound SFX_MENU_MOVE ; $5227
	jr .refresh ; $5229
.nextPage:
	ld a, [wCharGridPage] ; $522b
	cp $02 ; $522e
	jr nc, .checkLastPage ; $5230
	cp $01 ; $5232
	ret z ; $5234
	ld a, [wCharGridCreatedCount] ; $5235
	cp $07 ; $5238
	jr c, .refresh ; $523a
	ld a, $01 ; $523c
	ld [wCharGridPage], a ; $523e
	jr .playMoveSound ; $5241
.checkLastPage:
	inc a ; $5243
	ld e, a ; $5244
	ld a, [wCharGridPageCount] ; $5245
	dec a ; $5248
	ld b, a ; $5249
	ld a, e ; $524a
	cp b ; $524b
	jr nz, .playMoveSound ; $524c
	ld a, b ; $524e
	dec a ; $524f
	jr .storePage ; $5250
.playMoveSound:
	sound SFX_MENU_MOVE ; $5252
.storePage:
	ld [wCharGridPage], a ; $5254
	call BuildVisiblePageSpriteList ; $5257
.refresh:
	call RefreshCharInfoPanel ; $525a
	ret ; $525d
MoveCharGridCursorRight:
	ld a, [wMenuCursorX] ; $525e
	inc a ; $5261
	cp $03 ; $5262
	jr nz, .store ; $5264
	ld a, [wCharGridPage] ; $5266
	cp $02 ; $5269
	jr c, .toRosterRows ; $526b
	ld a, [wCharGridPage] ; $526d
	ld [wCharGridPrevPage], a ; $5270
	xor a ; $5273
	ld [wCharGridPage], a ; $5274
	jr .firstColumn ; $5277
.toRosterRows:
	ld a, $03 ; $5279
	ld [wCharGridPage], a ; $527b
.firstColumn:
	xor a ; $527e
.store:
	ld [wMenuCursorX], a ; $527f
	call BuildVisiblePageSpriteList ; $5282
	call RefreshCharInfoPanel ; $5285
	sound SFX_MENU_MOVE ; $5288
	ret ; $528a
MoveCharGridCursorLeft:
	ld a, [wMenuCursorX] ; $528b
	dec a ; $528e
	cp $ff ; $528f
	jr nz, .store ; $5291
	ld a, [wCharGridPage] ; $5293
	cp $02 ; $5296
	jr c, .toRosterRows ; $5298
	ld a, [wCharGridPage] ; $529a
	ld [wCharGridPrevPage], a ; $529d
	xor a ; $52a0
	ld [wCharGridPage], a ; $52a1
	jr .lastColumn ; $52a4
.toRosterRows:
	ld a, $03 ; $52a6
	ld [wCharGridPage], a ; $52a8
.lastColumn:
	call BuildVisiblePageSpriteList ; $52ab
	ld a, $02 ; $52ae
.store:
	ld [wMenuCursorX], a ; $52b0
	call RefreshCharInfoPanel ; $52b3
	sound SFX_MENU_MOVE ; $52b6
	ret ; $52b8
HandleCharGridButtons:
	ld a, [wMenuInputPressed] ; $52b9
	bit PADB_A, a ; $52bc
	jr nz, .confirm ; $52be
	bit PADB_B, a ; $52c0
	jr nz, .cancel ; $52c2
	bit PADB_START, a ; $52c4
	jr nz, .toggleHandedness ; $52c6
	ret ; $52c8
.confirm:
	call ConfirmCharGridSelection ; $52c9
	ret ; $52cc
.cancel:
	call CancelCharGridSelection ; $52cd
	ret ; $52d0
.toggleHandedness:
	call GetGridSlotFromCursor ; $52d1
	ld b, a ; $52d4
	ld hl, wCharGridEntries ; $52d5
	add a ; $52d8
	add a ; $52d9
	add_hl_a ; $52da
	ld a, [hl] ; $52df
	ld c, a ; $52e0
	call IsMarioCastCharacter ; $52e1
	or a ; $52e4
	jr z, .done ; $52e5
	sound SFX_MENU_MOVE ; $52e7
	ld a, [wCharGridHandedness] ; $52e9
	cp HAND_UNCHOSEN ; $52ec
	jr z, .starChar ; $52ee
	xor $01 ; $52f0
	ld [wCharGridHandedness], a ; $52f2
	call RefreshCharInfoPanel ; $52f5
	ret ; $52f8
.starChar:
	ld a, HAND_LEFT ; $52f9
	ld [wCharGridHandedness], a ; $52fb
	call RefreshCharInfoPanel ; $52fe
.done:
	ret ; $5301
ConfirmCharGridSelection:
	push_wram_bank WRAM_SCREEN ; $5302
	ld a, [wCharSelectSlot] ; $530b
	ld a, [wCharGridPage] ; $530e
	ld c, a ; $5311
	ld a, [wMenuCursorX] ; $5312
	ld d, a ; $5315
	ld a, [wMenuCursorY] ; $5316
	ld e, a ; $5319
	call TestAndSetGridEntryTaken ; $531a
	or a ; $531d
	jr nz, .rejectCell ; $531e
	call GetGridSlotFromCursor ; $5320
	ld b, a ; $5323
	ld hl, wCharGridEntries ; $5324
	add a ; $5327
	add a ; $5328
	add_hl_a ; $5329
	ld a, [hl] ; $532e
	cp $ff ; $532f
	jr z, .rejectCell ; $5331
	ld c, a ; $5333
	ld a, [wCharSelectSlot] ; $5334
	ld hl, wCharSelectSlotChars ; $5337
	add_hl_a ; $533a
	ld [hl], b ; $533f
	ld a, c ; $5340
	ld c, a ; $5341
	call IsMarioCastCharacter ; $5342
	or a ; $5345
	jr z, .drawPortrait ; $5346
	ld a, [wCharGridHandedness] ; $5348
	cp HAND_LEFT ; $534b
	jr nz, .drawPortrait ; $534d
	ld a, [wCharSelectSlot] ; $534f
	ld hl, wCharSelectSlotLeftHanded ; $5352
	add_hl_a ; $5355
	ld a, $01 ; $535a
	ld [hl], a ; $535c
.drawPortrait:
	call GetGridSlotFromCursor ; $535d
	ld b, a ; $5360
	call DrawPlayerSlotPortrait ; $5361
	sound SFX_MENU_SELECT ; $5364
	jr .advanceSlot ; $5366
.rejectCell:
	sound SFX_MENU_CANCEL ; $5368
	pop_wram_bank ; $536a
	ret ; $536f
.advanceSlot:
	call BuildVisiblePageSpriteList ; $5370
	call GetGridSlotFromCursor ; $5373
	ld b, a ; $5376
	ld hl, wCharGridEntries ; $5377
	add a ; $537a
	add a ; $537b
	add_hl_a ; $537c
	ld a, [hl] ; $5381
	ld c, a ; $5382
	call NeedsCpuDifficultyPrompt ; $5383
	or a ; $5386
	jr z, .nextSlot ; $5387
	ld a, $01 ; $5389
	ld [wCpuDifficultyPrompt], a ; $538b
	jr .done ; $538e
.nextSlot:
	call AdvanceToNextPlayerSlot ; $5390
	cp $ff ; $5393
	jr nz, .done ; $5395
	ld a, CHARSELECT_DONE ; $5397
	ld [wCharSelectExitCode], a ; $5399
.done:
	call DrawCharGridSlotPrompt ; $539c
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $539f
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $53a2
	ld c, 2 * TILEMAP_WIDTH / 16 ; $53a5
	call QueueVRAMCopy ; $53a7
	pop_wram_bank ; $53aa
	ret ; $53af
CancelCharGridSelection:
	push_wram_bank WRAM_SCREEN ; $53b0
	call RetreatToPreviousPlayerSlot ; $53b9
	cp $ff ; $53bc
	jr nz, .clearSlot ; $53be
	ld a, CHARSELECT_CANCELLED ; $53c0
	ld [wCharSelectExitCode], a ; $53c2
	pop_wram_bank ; $53c5
	ret ; $53ca
.clearSlot:
	sound SFX_MENU_CANCEL ; $53cb
	ld hl, wCharSelectSlotChars ; $53cd
	ld a, [wCharSelectSlot] ; $53d0
	add_hl_a ; $53d3
	ld a, [hl] ; $53d8
	ld b, $00 ; $53d9
	ld [hl], b ; $53db
	ld hl, wCharGridEntries ; $53dc
	add a ; $53df
	add a ; $53e0
	add_hl_a ; $53e1
	inc hl ; $53e6
	inc hl ; $53e7
	xor a ; $53e8
	ld [hl], a ; $53e9
	wram_bank WRAM_SCREEN ; $53ea
	ld hl, wCharSelectSlotDifficulty ; $53f0
	ld a, [wCharSelectSlot] ; $53f3
	add_hl_a ; $53f6
	xor a ; $53fb
	ld [hl], a ; $53fc
	ld hl, wCharSelectSlotLeftHanded ; $53fd
	ld a, [wCharSelectSlot] ; $5400
	add_hl_a ; $5403
	xor a ; $5408
	ld [hl], a ; $5409
	call ClearPlayerSlotPortrait ; $540a
	call BuildVisiblePageSpriteList ; $540d
	call DrawCharGridSlotPrompt ; $5410
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $5413
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $5416
	ld c, 2 * TILEMAP_WIDTH / 16 ; $5419
	call QueueVRAMCopy ; $541b
	pop_wram_bank ; $541e
	ret ; $5423
DrawCharGridSlotPrompt:
	wram_bank WRAM_SCREEN ; $5424
	ld a, [wCharSelectSlot] ; $542a
	cp CHARSELECTSLOT_BACKED_OUT ; $542d
	ret z ; $542f
	wram_bank WRAM_SCREEN ; $5430
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; $5436
	rect_size $12, $01 ; $5439
	ld h, $03 ; $543d
	farcall FillTilemapRect ; $543f
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $5442
	rect_size $12, $01 ; $5445
	ld h, $20 ; $5449
	farcall FillTilemapRect ; $544b
	ld a, [wCpuDifficultyPrompt] ; $544e
	or a ; $5451
	jr z, .promptFromTable ; $5452
	ld hl, Text_CharGridCpuDifficulty ; $5454
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $5457
	ld c, $20 ; $545a
	farcall RenderTextToBuffer64 ; $545c
	ret ; $545f
.promptFromTable:
	ld hl, CharGridSlotPromptsLinkP2 ; $5460
	ld a, [wCharSelectMode] ; $5463
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $5466
	jr z, .readEntry ; $5468
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $546a
	jr z, .readEntry ; $546c
	ld hl, CharGridSlotPromptsDefault ; $546e
.readEntry:
	ld a, [wCharSelectSlot] ; $5471
	add a ; $5474
	add_hl_a ; $5475
	ld a, [hl+] ; $547a
	ld h, [hl] ; $547b
	ld l, a ; $547c
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $547d
	ld c, $20 ; $5480
	farcall RenderTextToBuffer64 ; $5482
	ret ; $5485
CharGridSlotPromptsDefault:
	; $5486, 10 bytes (bytes:10)
	db $8e, $00, $8f, $00, $90, $00, $91, $00, $92, $00 ; 0x00
CharGridSlotPromptsLinkP2:
	; $5490, 10 bytes (bytes:10)
	db $8e, $00, $8e, $00, $8e, $00, $8f, $00, $92, $00 ; 0x00
DrawCharGridWaitBanner:
	ld c, $20 ; $549a
	ld b, $0f ; $549c
	ld de, $0840 ; $549e
	farcall ApplySpriteWaveOffset ; $54a1
	ld hl, DrawCharGridWaitBanner_SpriteTemplate ; $54a4
	call QueueSpriteTemplate ; $54a7
	ret ; $54aa
DrawCharGridWaitBanner_SpriteTemplate:
	; $54ab, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawCharGridScrollArrows:
	push_wram_bank WRAM_SCREEN ; $54cc
	ld a, [wCharSelectSlot] ; $54d5
	cp CHARSELECTSLOT_DONE ; $54d8
	jr z, .done ; $54da
	ld de, $0245 ; $54dc
	ld c, BOBDIR_POS ; $54df
	call ApplySpriteBobOffsetX ; $54e1
	sprite_tile_attr $10, OAM_BANK1 | 7 ; $54e4
	call QueueSprite ; $54e8
	ld de, $5045 ; $54eb
	ld c, BOBDIR_NEG ; $54ee
	call ApplySpriteBobOffsetX ; $54f0
	sprite_tile_attr $12, OAM_BANK1 | 7 ; $54f3
	call QueueSprite ; $54f7
	ld a, [wCharGridPage] ; $54fa
	or a ; $54fd
	jr z, .checkUpArrow ; $54fe
	cp $03 ; $5500
	jr z, .checkUpArrow ; $5502
	ld de, $2a25 ; $5504
	ld c, BOBDIR_POS ; $5507
	call ApplySpriteBobOffsetY ; $5509
	sprite_tile_attr $14, OAM_BANK1 | 7 ; $550c
	call QueueSprite ; $5510
.checkUpArrow:
	ld a, [wCharGridPage] ; $5513
	cp $01 ; $5516
	jr z, .done ; $5518
	or a ; $551a
	jr nz, .drawDownArrow ; $551b
	ld a, [wCharGridCreatedCount] ; $551d
	cp $07 ; $5520
	jr c, .done ; $5522
.drawDownArrow:
	ld a, [wCharGridPage] ; $5524
	ld b, a ; $5527
	ld a, [wCharGridPageCount] ; $5528
	dec a ; $552b
	dec a ; $552c
	cp b ; $552d
	jr z, .done ; $552e
	ld de, $2a63 ; $5530
	ld c, BOBDIR_NEG ; $5533
	call ApplySpriteBobOffsetY ; $5535
	sprite_tile_attr $16, OAM_BANK1 | 7 ; $5538
	call QueueSprite ; $553c
.done:
	pop_wram_bank ; $553f
	ret ; $5544
DrawCharGridCharSprites:
	push_wram_bank WRAM_SCREEN ; $5545
	ld hl, wScreenScratch ; $554e
	ld c, $00 ; $5551
.slotLoop:
	push hl ; $5553
	ld a, c ; $5554
	add a ; $5555
	ld hl, CharGridCharSprites ; $5556
	add_hl_a ; $5559
	ld a, [hl+] ; $555e
	ld d, [hl] ; $555f
	ld e, a ; $5560
	pop hl ; $5561
	push bc ; $5562
	ld b, [hl] ; $5563
	inc hl ; $5564
	ld c, [hl] ; $5565
	inc hl ; $5566
	ld a, b ; $5567
	cp $ff ; $5568
	jr z, .nextSlot ; $556a
	call QueueCharGridCharSprite ; $556c
.nextSlot:
	pop bc ; $556f
	ld a, c ; $5570
	inc a ; $5571
	ld c, a ; $5572
	cp $06 ; $5573
	jr nz, .slotLoop ; $5575
	pop_wram_bank ; $5577
	ret ; $557c
CharGridCharSprites:
	; $557d, 12 bytes (bytes:12)
	db $33, $0e, $33, $26, $33, $3e, $4e, $0e, $4e, $26, $4e, $3e ; 0x00
QueueCharGridCharSprite:
	push af ; $5589
	push bc ; $558a
	push de ; $558b
	push hl ; $558c
	ld h, b ; $558d
	ld a, $02 ; $558e
	add c ; $5590
	ld b, a ; $5591
	ld a, h ; $5592
	add a ; $5593
	add a ; $5594
	ld c, a ; $5595
	push de ; $5596
	call QueueSprite ; $5597
	pop de ; $559a
	ld a, $08 ; $559b
	add d ; $559d
	ld d, a ; $559e
	ld a, $02 ; $559f
	add c ; $55a1
	ld c, a ; $55a2
	call QueueSprite ; $55a3
	pop hl ; $55a6
	pop de ; $55a7
	pop bc ; $55a8
	pop af ; $55a9
	ret ; $55aa
