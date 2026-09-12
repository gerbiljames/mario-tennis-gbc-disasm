	farptr InitAndRunGame ; $4000
	farptr ShowDmgLockoutScreen ; $4002
	farptr LoadMenuTilesA ; $4004
	farptr LoadMenuTilesB ; $4006
	farptr LoadMenuFontPalette ; $4008
	farptr LoadMenuFontGfx ; $400a
	farptr LoadMenuBgPalettes3To7 ; $400c
	farptr LoadMenuObjPalettes3To7 ; $400e
	farptr LoadDebugMenuPalette ; $4010
	farptr LoadMenuTilesBChunk2 ; $4012
	farptr LoadMenuFontGfxStaged ; $4014
	farptr RunSoundTest ; $4016
InitAndRunGame:
	call InitSerialLink ; $4018
	push de ; $401b
	ld de, SAVEFLAG_DEBUG_TEST_MENU ; $401c
	farcall ClearSaveFlag ; $401f
	pop de ; $4022
	call DisableLCDSafely ; $4023
	wram_bank WRAM_STAGING ; $4026
	ld hl, wDecompBuffer ; $402c
	ld c, $00 ; $402f
	call ClearMemory16 ; $4031
	wram_bank WRAM_COURT_PLANES ; $4034
	ld hl, wScreenAttrmap ; $403a
	ld c, $00 ; $403d
	call ClearMemory16 ; $403f
	wram_bank WRAM_SCREEN ; $4042
	ld hl, wShadowTilemap ; $4048
	ld c, $00 ; $404b
	call ClearMemory16 ; $404d
	wram_bank WRAM_ACTORS ; $4050
	ld hl, wActors ; $4056
	ld c, $00 ; $4059
	call ClearMemory16 ; $405b
	wram_bank WRAM_TEXT ; $405e
	ld hl, wWindowShadowTilemap ; $4064
	ld c, $00 ; $4067
	call ClearMemory16 ; $4069
	wram_bank WRAM_SCENE ; $406c
	ld hl, WRAMX_BASE ; $4072
	ld c, $00 ; $4075
	call ClearMemory16 ; $4077
	ld hl, wShadowOAM ; $407a
	ld c, $0a ; $407d
	call ClearMemory16 ; $407f
	call ClearDebugTextBuffer ; $4082
	call LoadMenuFontGfx ; $4085
	call LoadMenuObjPalettes3To7 ; $4088
	farcall ValidateSaveRam ; $408b
	farcall RepairAllSaveSlots ; $408e
	farcall ApplyN64RecordsUnlockFlags ; $4091
	farcall UpdateUnlockablesSaveBlock ; $4094
	farcall InitStoryModeState ; $4097
	farcall InitDefaultMatchSettings ; $409a
	call EnableLCD ; $409d
	script_fade_in $7f ; $40a0
.loop:
	ld hl, wStoryModeCurrentLocation ; $40a5
	ld [hl], STORYLOC_MAIN_MENU ; $40a8
	ld hl, wStoryModeEntryPoint ; $40aa
	ld [hl], $0a ; $40ad
	farcall RunStoryModeOverworld ; $40af
.loopB:
	ld hl, BuildStamp ; $40b2
	lb de, $05, $11 ; $40b5 column, row
	call PrintString ; $40b8
	ld a, $03 ; $40bb
	ldh [hDebugStepMode], a ; $40bd
.loop2:
	ldh a, [hInputPressed] ; $40bf
	bit PADB_A, a ; $40c1
	jr z, .advanceFrame ; $40c3
	push de ; $40c5
	ld de, SAVEFLAG_DEBUG_TEST_MENU ; $40c6
	farcall SetSaveFlag ; $40c9
	pop de ; $40cc
	jr .setDebugStepMode ; $40cd
.advanceFrame:
	bit 3, a ; $40cf
	jr nz, .setDebugStepMode ; $40d1
	call AdvanceFrame ; $40d3
	jr .loop2 ; $40d6
.setDebugStepMode:
	ld a, $00 ; $40d8
	ldh [hDebugStepMode], a ; $40da
	ld hl, wStoryModeCurrentLocation ; $40dc
	ld [hl], STORYLOC_MAIN_MENU ; $40df
	ld hl, wStoryModeEntryPoint ; $40e1
	ld [hl], $0a ; $40e4
	farcall RunStoryModeOverworld ; $40e6
	jp .loopB ; $40e9
Unused_01_MenuRedraw:
	ld hl, BuildStamp ; $40ec
	lb de, $05, $11 ; $40ef column, row
	call PrintString ; $40f2
	ld a, $03 ; $40f5
	ldh [hDebugStepMode], a ; $40f7
.loop:
	ldh a, [hInputPressed] ; $40f9
	bit PADB_START, a ; $40fb
	jr z, .runSoundTest ; $40fd
	ld a, $01 ; $40ff
	ldh [hDebugStepMode], a ; $4101
	ld hl, wStoryModeCurrentLocation ; $4103
	ld [hl], STORYLOC_MAIN_MENU ; $4106
	ld hl, wStoryModeEntryPoint ; $4108
	ld [hl], $0a ; $410b
	farcall RunStoryModeOverworld ; $410d
	jp InitAndRunGame.loop ; $4110
.runSoundTest:
	bit 2, a ; $4113
	jr z, .bit2Clear ; $4115
	farcall RunSoundTest ; $4117
.bit2Clear:
	bit 0, a ; $411a
	jr z, .bit0Clear ; $411c
	ld a, $01 ; $411e
	ldh [hDebugStepMode], a ; $4120
.loopB:
	farcall RunDebugTestMatch ; $4122
	jr .loopB ; $4125
.bit0Clear:
	bit 1, a ; $4127
	jr z, .bit1Clear ; $4129
	ld a, $01 ; $412b
	ldh [hDebugStepMode], a ; $412d
.loop2:
	farcall StubNop_3b ; $412f
	farcall RunMatch ; $4132
	jp .loop2 ; $4135
.bit1Clear:
	bit 6, a ; $4138
	jp z, Unused_01_MatchSetup.bit6Clear ; $413a
	ld a, $01 ; $413d
	ldh [hDebugStepMode], a ; $413f
	ld a, $00 ; $4141
	ld [wCurrentStorySlot], a ; $4143
	farcall CheckStorySlot ; $4146
	ld b, $00 ; $4149
	ld c, $04 ; $414b
	farcall ShowTournamentBracket ; $414d
	ld b, $01 ; $4150
	ld c, $02 ; $4152
	farcall ShowTournamentBracket ; $4154
	ld a, MINIGAME_SERVICE_MATCH_2 ; $4157
	ld [wCurrentMinigameStoryMatch], a ; $4159
	ld a, $11 ; $415c
	ld [wCurrentMinigameStoryMatch + 1], a ; $415e
	ld a, WINLOSE_WIN ; $4161
	ld [wMatchWinLoseFlag], a ; $4163
	ld a, $00 ; $4166
	ld [wCurrentStorySlot], a ; $4168
	farcall CheckStorySlot ; $416b
	ld a, CHAR_LUIGI ; $416e
	ld [wPlayer1CurrentMainCharacter], a ; $4170
	ld a, CHAR_DK ; $4173
	ld [wPlayer1CurrentPartnerCharacter], a ; $4175
	ld a, CHAR_BABY_MARIO ; $4178
	ld [wPlayer2CurrentMainCharacter], a ; $417a
	ld a, CHAR_MARIO ; $417d
	ld [wPlayer2CurrentPartnerCharacter], a ; $417f
	ld a, $03 ; $4182
	ld [wAnimatedTilePeriod], a ; $4184
	ld de, FLAG_DOUBLES ; $4187
	call SetGameFlagByNumber ; $418a
	ld a, $00 ; $418d
	ld [wCurrentMinigameStoryMatch + 1], a ; $418f
.loop3:
	farcall RunMatchWinLoseScreen ; $4192
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4195
	inc a ; $4198
	ld [wCurrentMinigameStoryMatch + 1], a ; $4199
	jr .loop3 ; $419c
Unused_01_MatchSetup:
	farcall ShowEquipmentStatusScreen ; $419e
	ld de, FLAG_DOUBLES ; $41a1
	call ClearGameFlagByNumber ; $41a4
	ld a, GAMEMODE_EXHIBITION ; $41a7
	ld [wGameMode], a ; $41a9
	farcall RunMatchStatsScreen ; $41ac
	farcall ShowLinkErrorScreen ; $41af
	farcall ShowLinkMessageScreen ; $41b2
	farcall RunShoesSelectScreen ; $41b5
	farcall RunRacketSelectScreen ; $41b8
	ld a, $01 ; $41bb
	ldh [hDebugStepMode], a ; $41bd
	farcall RunDebugCharViewer ; $41bf
.bit6Clear:
	bit 7, a ; $41c2
	jr z, Unused_01.positive ; $41c4
	ld a, $01 ; $41c6
	ldh [hDebugStepMode], a ; $41c8
	ld a, $00 ; $41ca
	ldh [hDebugStepMode], a ; $41cc
.loop:
	farcall RunIntroCutscene ; $41ce
	farcall RunTitleScreen ; $41d1
	jr .loop ; $41d4
Unused_01:
	jp InitAndRunGame.loop ; $41d6
	db $18 ; $41d9
	db $ef ; $41da
.positive:
	bit 4, a ; $41db
	jr z, .bit4Clear ; $41dd
	ld a, $01 ; $41df
	ldh [hDebugStepMode], a ; $41e1
	ld hl, wStoryModeCurrentLocation ; $41e3
	ld [hl], STORYLOC_TEST ; $41e6
	ld hl, wStoryModeEntryPoint ; $41e8
	ld [hl], $0a ; $41eb
	ld a, $00 ; $41ed
	ld [wStoryModeMainCharacterOverworldSprite], a ; $41ef
	farcall RunStoryModeOverworld ; $41f2
.bit4Clear:
	bit 5, a ; $41f5
	jr z, .advanceFrame ; $41f7
	ld a, $01 ; $41f9
	ldh [hDebugStepMode], a ; $41fb
	farcall RunDebugCharViewer ; $41fd
	ld a, $00 ; $4200
	ldh [hDebugStepMode], a ; $4202
.loop:
	call AdvanceFrame ; $4204
	jr .loop ; $4207
.advanceFrame:
	call AdvanceFrame ; $4209
	jp Unused_01_MenuRedraw.loop ; $420c
	db $00 ; $420f
MenuWindowTiles_01:
	INCBIN "data/bank_001/MenuWindowTiles_01.bin" ; $4210, 256 bytes
	ds 256, $00 ; $4310, fill
MenuFontTiles_01:
	INCBIN "data/bank_001/MenuFontTiles_01.bin" ; $4410, 512 bytes
MenuTilesBStagedTiles0:
	INCBIN "data/bank_001/MenuTilesBStagedTiles0.bin" ; $4610, 512 bytes
MenuTilesBStagedTiles1:
	INCBIN "data/bank_001/MenuTilesBStagedTiles1.bin" ; $4810, 512 bytes
MenuFontFillTiles_01:
	; $4a10, 1536 bytes (pattern)
	ds 1536, $ff, $00
MenuFontPalettes_01:
	INCLUDE "data/bank_001/MenuFontPalettes_01.asm" ; $5010, 64 bytes (palettes)
LoadMenuFontPalette:
	push af ; $5050
	push bc ; $5051
	push de ; $5052
	push hl ; $5053
	ld hl, MenuFontPalettes_01 ; $5054
	lb de, $00, $01 ; $5057 palette index, count
	call LoadPaletteShadow ; $505a
	pop hl ; $505d
	pop de ; $505e
	pop bc ; $505f
	pop af ; $5060
	ret ; $5061
LoadMenuTilesA:
	push af ; $5062
	push bc ; $5063
	push de ; $5064
	push hl ; $5065
	ld hl, MenuWindowTiles_01 ; $5066
	ld de, vTiles2 ; $5069
	ld c, $10 ; $506c
	call QueueVRAMCopy ; $506e
	pop hl ; $5071
	pop de ; $5072
	pop bc ; $5073
	pop af ; $5074
	ret ; $5075
LoadMenuTilesB:
	push af ; $5076
	push bc ; $5077
	push de ; $5078
	push hl ; $5079
	ld hl, MenuFontTiles_01 ; $507a
	ld de, vTiles2 + $20 * TILE_SIZE ; $507d
	ld c, $60 ; $5080
	call QueueVRAMCopy ; $5082
	ld hl, MenuFontFillTiles_01 ; $5085
	ld de, vTiles1 ; $5088
	ld c, $60 ; $508b
	call QueueVRAMCopy ; $508d
	pop hl ; $5090
	pop de ; $5091
	pop bc ; $5092
	pop af ; $5093
	ret ; $5094
LoadMenuTilesBStaged:
	push af ; $5095
	push bc ; $5096
	push de ; $5097
	push hl ; $5098
	ld hl, MenuFontTiles_01 ; $5099
	ld de, vTiles2 + $20 * TILE_SIZE ; $509c
	ld c, (MenuTilesBStagedTiles0 - MenuFontTiles_01) / 16 ; $509f
	call QueueVRAMCopy ; $50a1
	call AdvanceFrame ; $50a4
	ld hl, MenuTilesBStagedTiles0 ; $50a7
	ld de, vTiles2 + $40 * TILE_SIZE ; $50aa
	ld c, (MenuTilesBStagedTiles1 - MenuTilesBStagedTiles0) / 16 ; $50ad
	call QueueVRAMCopy ; $50af
	call AdvanceFrame ; $50b2
	ld hl, MenuTilesBStagedTiles1 ; $50b5
	ld de, vTiles2 + $60 * TILE_SIZE ; $50b8
	ld c, (MenuFontFillTiles_01 - MenuTilesBStagedTiles1) / 16 ; $50bb
	call QueueVRAMCopy ; $50bd
	call AdvanceFrame ; $50c0
	ld hl, MenuFontPalettes_01 ; $50c3
	ld de, vTiles1 + $60 * TILE_SIZE ; $50c6
	ld c, $20 ; $50c9
	call QueueVRAMCopy ; $50cb
	call AdvanceFrame ; $50ce
	pop hl ; $50d1
	pop de ; $50d2
	pop bc ; $50d3
	pop af ; $50d4
	ret ; $50d5
LoadMenuTilesBChunk2:
	ld hl, MenuTilesBStagedTiles0 ; $50d6
	ld de, vTiles2 + $40 * TILE_SIZE ; $50d9
	ld c, (MenuTilesBStagedTiles1 - MenuTilesBStagedTiles0) / 16 ; $50dc
	call QueueVRAMCopy ; $50de
	ret ; $50e1
LoadMenuFontGfx:
	call LoadMenuFontPalette ; $50e2
	call LoadMenuTilesA ; $50e5
	call LoadMenuTilesB ; $50e8
	ret ; $50eb
LoadMenuFontGfxStaged:
	call LoadMenuFontPalette ; $50ec
	call LoadMenuTilesA ; $50ef
	call LoadMenuTilesBStaged ; $50f2
	ret ; $50f5
DebugMenuPalettes_01:
	INCLUDE "data/bank_001/DebugMenuPalettes_01.asm" ; $50f6, 128 bytes (palettes)
LoadMenuBgPalettes3To7:
	push af ; $5176
	push bc ; $5177
	push de ; $5178
	push hl ; $5179
	ld hl, $87c8 ; $517a
	lb de, $03, $05 ; $517d palette index, count
	call LoadPaletteShadow ; $5180
	pop hl ; $5183
	pop de ; $5184
	pop bc ; $5185
	pop af ; $5186
	ret ; $5187
LoadMenuObjPalettes3To7:
	push af ; $5188
	push bc ; $5189
	push de ; $518a
	push hl ; $518b
	ld hl, $87c8 ; $518c
	lb de, $0b, $05 ; $518f palette index, count
	call LoadPaletteShadow ; $5192
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
LoadDebugMenuPalette:
	ld a, b ; $519a
	add a ; $519b
	add a ; $519c
	add a ; $519d
	ld_hl_indexed DebugMenuPalettes_01 ; $519e
	ld e, $01 ; $51a5
	call LoadPaletteShadow ; $51a7
	ret ; $51aa
	; $51ab, 5 bytes (fill)
	ds 5, $00
UnusedJpWindowTiles_01:
	INCBIN "data/bank_001/UnusedJpWindowTiles_01.bin" ; $51b0, 256 bytes
	ds 256, $00 ; $52b0, fill
UnusedJpFontTiles_01:
	INCBIN "data/bank_001/UnusedJpFontTiles_01.bin" ; $53b0, 3136 bytes
UnusedJpFontPalettes_01:
	INCLUDE "data/bank_001/UnusedJpFontPalettes_01.asm" ; $5ff0, 64 bytes (palettes)
ShowDmgLockoutScreen:
	ld a, $00 ; $6030
	ldh [rLCDC], a ; $6032
	ld hl, DmgLockoutTilesLZ_01 ; $6034
	ld de, wDecompBuffer ; $6037
	call DecompressData ; $603a
	ld hl, wDecompBuffer ; $603d
	ld de, vTiles2 ; $6040
	ld c, $80 ; $6043 -- 128 of DmgLockoutTilesLZ_01's 256 tiles
	call CopyMemoryFast ; $6045
	ld hl, wTextTileBuffer ; $6048
	ld de, vTiles1 ; $604b
	ld c, $80 ; $604e
	call CopyMemoryFast ; $6050
	ld hl, DmgLockoutTilemapLZ_01 ; $6053
	ld de, wDecompBuffer ; $6056
	call DecompressData ; $6059
	ld hl, wDecompBuffer ; $605c
	ld de, vBGMap0 ; $605f
	ld c, $40 ; $6062
	call CopyMemoryFast ; $6064
	ld a, $e4 ; $6067
	ldh [rBGP], a ; $6069
	xor a ; $606b
	ldh [rIF], a ; $606c
	ld a, $00 ; $606e
	ldh [rIE], a ; $6070
	ld a, $c1 ; $6072
	ldh [rLCDC], a ; $6074
	ei ; $6076
.loop:
	call AdvanceFrame ; $6077
	jr .loop ; $607a
DmgLockoutTilesLZ_01:
	INCBIN "data/bank_001/lz_DmgLockoutTilesLZ_01.bin" ; $607c, 2183 bytes
DmgLockoutTilemapLZ_01:
	INCBIN "data/bank_001/lz_DmgLockoutTilemapLZ_01.bin" ; $6903, 344 bytes
RunSoundTest:
	push af ; $6a5b
	push bc ; $6a5c
	push de ; $6a5d
	push hl ; $6a5e
	ld a, [wPlayer1MainName] ; $6a5f
	ld d, a ; $6a62
	ld a, [wPlayer1MainName + 1] ; $6a63
	ld e, a ; $6a66
	ld b, $00 ; $6a67
	ldh a, [hDebugStepMode] ; $6a69
	push af ; $6a6b
	ld a, $03 ; $6a6c
	ldh [hDebugStepMode], a ; $6a6e
	push hl ; $6a70
	push de ; $6a71
	ld hl, SoundTestStrings_01 ; $6a72
	lb de, $0d, $09 ; $6a75 column, row
	call PrintString ; $6a78
	pop de ; $6a7b
	pop hl ; $6a7c
	push hl ; $6a7d
	push de ; $6a7e
	ld hl, SoundTestString0 ; $6a7f
	lb de, $0d, $0b ; $6a82 column, row
	call PrintString ; $6a85
	pop de ; $6a88
	pop hl ; $6a89
.loop:
	call AdvanceFrame ; $6a8a
	ldh a, [hInputPressed] ; $6a8d
	and PADF_UP | PADF_DOWN ; $6a8f
	jr z, .clampTrack ; $6a91
	ld a, b ; $6a93
	xor $01 ; $6a94
	ld b, a ; $6a96
.clampTrack:
	ld a, b ; $6a97
	or a ; $6a98
	jr nz, .nonZero ; $6a99
	ldh a, [hInputPressed] ; $6a9b
	bit PADB_RIGHT, a ; $6a9d
	jr z, .zero ; $6a9f
	inc d ; $6aa1
	jr .clampBank ; $6aa2
.zero:
	bit 5, a ; $6aa4
	jr z, .clampTrackDown ; $6aa6
	dec d ; $6aa8
.clampBank:
	ld a, d ; $6aa9
	cp $ff ; $6aaa
	jr nz, .neff ; $6aac
	ld d, $3e ; $6aae
	jr .clampTrackDown ; $6ab0
.neff:
	ld a, d ; $6ab2
	cp $3e ; $6ab3
	jr c, .clampTrackDown ; $6ab5
	jr z, .clampTrackDown ; $6ab7
	ld d, $00 ; $6ab9
	jr .clampTrackDown ; $6abb
.nonZero:
	ldh a, [hInputPressed] ; $6abd
	bit PADB_RIGHT, a ; $6abf
	jr z, .checkLeft ; $6ac1
	inc e ; $6ac3
	jr .clampSfx ; $6ac4
.checkLeft:
	bit 5, a ; $6ac6
	jr z, .clampTrackDown ; $6ac8
	dec e ; $6aca
.clampSfx:
	ld a, e ; $6acb
	cp $ff ; $6acc
	jr nz, .neff2 ; $6ace
	ld e, $71 ; $6ad0
	jr .clampTrackDown ; $6ad2
.neff2:
	ld a, e ; $6ad4
	cp $71 ; $6ad5
	jr c, .clampTrackDown ; $6ad7
	jr z, .clampTrackDown ; $6ad9
	ld e, $00 ; $6adb
.clampTrackDown:
	ld a, b ; $6add
	or a ; $6ade
	jr nz, .nonZero2 ; $6adf
	push hl ; $6ae1
	push de ; $6ae2
	ld hl, SoundTestString1 ; $6ae3
	lb de, $0c, $09 ; $6ae6 column, row
	call PrintString ; $6ae9
	pop de ; $6aec
	pop hl ; $6aed
	push hl ; $6aee
	push de ; $6aef
	ld hl, SoundTestString2 ; $6af0
	lb de, $0c, $0b ; $6af3 column, row
	call PrintString ; $6af6
	pop de ; $6af9
	pop hl ; $6afa
	jr .printDecimalByte ; $6afb
.nonZero2:
	push hl ; $6afd
	push de ; $6afe
	ld hl, SoundTestString1 ; $6aff
	lb de, $0c, $0b ; $6b02 column, row
	call PrintString ; $6b05
	pop de ; $6b08
	pop hl ; $6b09
	push hl ; $6b0a
	push de ; $6b0b
	ld hl, SoundTestString2 ; $6b0c
	lb de, $0c, $09 ; $6b0f column, row
	call PrintString ; $6b12
	pop de ; $6b15
	pop hl ; $6b16
.printDecimalByte:
	push de ; $6b17
	push af ; $6b18
	ld a, d ; $6b19
	ld de, $0e0a ; $6b1a
	call PrintDecimalByte ; $6b1d
	pop af ; $6b20
	pop de ; $6b21
	push de ; $6b22
	push af ; $6b23
	ld a, e ; $6b24
	ld de, $0e0c ; $6b25
	call PrintDecimalByte ; $6b28
	pop af ; $6b2b
	pop de ; $6b2c
	ldh a, [hInputPressed] ; $6b2d
	bit PADB_A, a ; $6b2f
	jr z, .continueLoop ; $6b31
	bit 0, b ; $6b33
	jr nz, .bit0Set ; $6b35
	push af ; $6b37
	push bc ; $6b38
	push de ; $6b39
	push hl ; $6b3a
	ld a, d ; $6b3b
	ld_hl_indexed SoundTestSoundsA_01 ; $6b3c
	ld a, [hl] ; $6b43
	call PlaySoundManaged ; $6b44
	pop hl ; $6b47
	pop de ; $6b48
	pop bc ; $6b49
	pop af ; $6b4a
	jr .continueLoop ; $6b4b
.bit0Set:
	push af ; $6b4d
	push bc ; $6b4e
	push de ; $6b4f
	push hl ; $6b50
	ld a, e ; $6b51
	ld_hl_indexed SoundTestSoundsB_01 ; $6b52
	ld a, [hl] ; $6b59
	call PlaySoundManaged ; $6b5a
	pop hl ; $6b5d
	pop de ; $6b5e
	pop bc ; $6b5f
	pop af ; $6b60
.continueLoop:
	jp .loop ; $6b61
SoundTestStrings_01:
	INCLUDE "data/bank_001/SoundTestStrings_01.asm" ; $6b64, 6 bytes (sound_data)
SoundTestString0:
	INCLUDE "data/bank_001/SoundTestString0.asm" ; $6b6a, 7 bytes
SoundTestString1:
	db $3e ; $6b71
	db $00 ; $6b72
SoundTestString2:
	db $20 ; $6b73
	db $00 ; $6b74
SoundTestSoundsA_01:
	INCLUDE "data/bank_001/SoundTestSoundsA_01.asm" ; $6b75, 63 bytes (sound_data)
SoundTestSoundsB_01:
	INCLUDE "data/bank_001/SoundTestSoundsB_01.asm" ; $6bb4, 114 bytes (sound_data)
	; $6c26, 5082 bytes fill to bank end (linker-padded)
