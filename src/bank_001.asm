SECTION "ROM Bank $01", ROMX[$4000], BANK[$01]

	farptr RunDebugTestMenu ; $4000
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
RunDebugTestMenu:
	call InitSerialLink ; $4018
	push de ; $401b
	ld de, SAVEFLAG_DEBUG_TEST_MENU ; $401c
	farcall ClearSaveFlag ; $401f
	pop de ; $4022
	call DisableLCDSafely ; $4023
	wram_bank $01 ; $4026
	ld hl, $d000 ; $402c
	ld c, $00 ; $402f
	call ClearMemory16 ; $4031
	wram_bank $02 ; $4034
	ld hl, $d000 ; $403a
	ld c, $00 ; $403d
	call ClearMemory16 ; $403f
	wram_bank $03 ; $4042
	ld hl, $d000 ; $4048
	ld c, $00 ; $404b
	call ClearMemory16 ; $404d
	wram_bank $04 ; $4050
	ld hl, $d000 ; $4056
	ld c, $00 ; $4059
	call ClearMemory16 ; $405b
	wram_bank $05 ; $405e
	ld hl, $d000 ; $4064
	ld c, $00 ; $4067
	call ClearMemory16 ; $4069
	wram_bank $06 ; $406c
	ld hl, $d000 ; $4072
	ld c, $00 ; $4075
	call ClearMemory16 ; $4077
	ld hl, $c000 ; $407a
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
	ld [hl], $00 ; $40a8
	ld hl, wStoryModeEntryPoint ; $40aa
	ld [hl], $0a ; $40ad
	farcall RunStoryModeOverworld ; $40af
.loopB:
	ld hl, BuildStamp ; $40b2
	ld de, $0511 ; $40b5
	call PrintString ; $40b8
	ld a, $03 ; $40bb
	ldh [hDebugStepMode], a ; $40bd
.loopBB:
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
	jr .loopBB ; $40d6
.setDebugStepMode:
	ld a, $00 ; $40d8
	ldh [hDebugStepMode], a ; $40da
	ld hl, wStoryModeCurrentLocation ; $40dc
	ld [hl], $00 ; $40df
	ld hl, wStoryModeEntryPoint ; $40e1
	ld [hl], $0a ; $40e4
	farcall RunStoryModeOverworld ; $40e6
	jp .loopB ; $40e9
Unused_01_MenuRedraw:
	ld hl, BuildStamp ; $40ec
	ld de, $0511 ; $40ef
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
	ld [hl], $00 ; $4106
	ld hl, wStoryModeEntryPoint ; $4108
	ld [hl], $0a ; $410b
	farcall RunStoryModeOverworld ; $410d
	jp RunDebugTestMenu.loop ; $4110
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
.loopBB:
	farcall StubNop_3b_44a9 ; $412f
	farcall RunMatch ; $4132
	jp .loopBB ; $4135
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
	ld a, $01 ; $4157
	ld [wCurrentMinigameStoryMatch], a ; $4159
	ld a, $11 ; $415c
	ld [wCurrentMinigameStoryMatch + 1], a ; $415e
	ld a, $01 ; $4161
	ld [wMatchWinLoseFlag], a ; $4163
	ld a, $00 ; $4166
	ld [wCurrentStorySlot], a ; $4168
	farcall CheckStorySlot ; $416b
	ld a, $17 ; $416e
	ld [wPlayer1CurrentMainCharacter], a ; $4170
	ld a, $18 ; $4173
	ld [wPlayer1CurrentPartnerCharacter], a ; $4175
	ld a, $19 ; $4178
	ld [wPlayer2CurrentMainCharacter], a ; $417a
	ld a, $1a ; $417d
	ld [wPlayer2CurrentPartnerCharacter], a ; $417f
	ld a, $03 ; $4182
	ld [wAnimatedTilePeriod], a ; $4184
	ld de, $002f ; $4187
	call SetGameFlagByNumber ; $418a
	ld a, $00 ; $418d
	ld [wCurrentMinigameStoryMatch + 1], a ; $418f
.loopBBB:
	farcall RunMatchWinLoseScreen ; $4192
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4195
	inc a ; $4198
	ld [wCurrentMinigameStoryMatch + 1], a ; $4199
	jr .loopBBB ; $419c
Unused_01_MatchSetup:
	farcall ShowEquipmentStatusScreen ; $419e
	ld de, $002f ; $41a1
	call ClearGameFlagByNumber ; $41a4
	ld a, $04 ; $41a7
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
	jr z, Unused_01_41d6.positive ; $41c4
	ld a, $01 ; $41c6
	ldh [hDebugStepMode], a ; $41c8
	ld a, $00 ; $41ca
	ldh [hDebugStepMode], a ; $41cc
.loop:
	farcall RunIntroCutscene ; $41ce
	farcall RunTitleScreen ; $41d1
	jr .loop ; $41d4
Unused_01_41d6:
	jp RunDebugTestMenu.loop ; $41d6
	db $18 ; $41d9
	db $ef ; $41da
.positive:
	bit 4, a ; $41db
	jr z, .bit4Clear ; $41dd
	ld a, $01 ; $41df
	ldh [hDebugStepMode], a ; $41e1
	ld hl, wStoryModeCurrentLocation ; $41e3
	ld [hl], $03 ; $41e6
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
	INCBIN "data/bank_001/d_4210.bin" ; $4210, 256 bytes
	ds 256, $00 ; $4310, fill
MenuFontTiles_01:
	INCBIN "data/bank_001/d_4410.bin" ; $4410, 1536 bytes
MenuFontFillTiles_01:
	; $4a10, 1536 bytes (pattern)
	ds 1536, $ff, $00
MenuFontPalettes_01:
	; $5010, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7fff, $6bff, $1e58, $0000 ; pal 0: #ffffff #ffffd5 #c59439 #000000
	dw $0160, $7fff, $3def, $0000 ; pal 1: #005a00 #ffffff #7b7b7b #000000
	dw $6587, $7fff, $5294, $0000 ; pal 2: #3962cd #ffffff #a4a4a4 #000000
	dw $4a5f, $5fbf, $28df, $0000 ; pal 3: #ff9494 #ffeebd #ff3152 #000000
	dw $03f2, $034b, $12c8, $19e0 ; pal 4: #94ff00 #5ad500 #41b420 #007b31
	dw $0120, $0210, $2318, $53ff ; pal 5: #004a00 #838300 #c5c541 #ffffa4
	dw $0120, $000f, $2118, $529f ; pal 6: #004a00 #7b0000 #c54141 #ffa4a4
	dw $0120, $4000, $5184, $7ff4 ; pal 7: #004a00 #000083 #2062a4 #a4ffff
LoadMenuFontPalette:
	push af ; $5050
	push bc ; $5051
	push de ; $5052
	push hl ; $5053
	ld hl, MenuFontPalettes_01 ; $5054
	ld de, $0001 ; $5057
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
	ld de, $9000 ; $5069
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
	ld de, $9200 ; $507d
	ld c, $60 ; $5080
	call QueueVRAMCopy ; $5082
	ld hl, MenuFontFillTiles_01 ; $5085
	ld de, $8800 ; $5088
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
	ld de, $9200 ; $509c
	ld c, $20 ; $509f
	call QueueVRAMCopy ; $50a1
	call AdvanceFrame ; $50a4
	ld hl, $4610 ; $50a7
	ld de, $9400 ; $50aa
	ld c, $20 ; $50ad
	call QueueVRAMCopy ; $50af
	call AdvanceFrame ; $50b2
	ld hl, $4810 ; $50b5
	ld de, $9600 ; $50b8
	ld c, $20 ; $50bb
	call QueueVRAMCopy ; $50bd
	call AdvanceFrame ; $50c0
	ld hl, MenuFontPalettes_01 ; $50c3
	ld de, $8e00 ; $50c6
	ld c, $20 ; $50c9
	call QueueVRAMCopy ; $50cb
	call AdvanceFrame ; $50ce
	pop hl ; $50d1
	pop de ; $50d2
	pop bc ; $50d3
	pop af ; $50d4
	ret ; $50d5
LoadMenuTilesBChunk2:
	ld hl, $4610 ; $50d6
	ld de, $9400 ; $50d9
	ld c, $20 ; $50dc
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
	; $50f6, 128 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $39ce, $0000 ; pal 0: #414a52 #ffffff #737373 #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $1adc, $6bff, $1e40, $0000 ; pal 3: #e6b431 #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $331f, $6bff, $01df, $0000 ; pal 5: #ffc562 #ffffd5 #ff7300 #000000
	dw $5a9f, $6bff, $001f, $0000 ; pal 6: #ffa4b4 #ffffd5 #ff0000 #000000
	dw $3acc, $6bff, $7d4a, $0000 ; pal 7: #62b473 #ffffd5 #5252ff #000000
	dw $6e43, $679f, $258f, $0000 ; pal 8: #1894de #ffe6cd #7b624a #000000
	dw $294a, $294a, $294a, $294a ; pal 9: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 10: #525252 #525252 #525252 #525252
	dw $01ff, $011f, $7fff, $0000 ; pal 11: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 12: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 13: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 14: #ff7b00 #ff4100 #ffffff #000000
	dw $01ff, $011f, $7fff, $0000 ; pal 15: #ff7b00 #ff4100 #ffffff #000000
LoadMenuBgPalettes3To7:
	push af ; $5176
	push bc ; $5177
	push de ; $5178
	push hl ; $5179
	ld hl, $87c8 ; $517a
	ld de, $0305 ; $517d
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
	ld de, $0b05 ; $518f
	call LoadPaletteShadow ; $5192
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
LoadDebugMenuPalette:
	ld a, b ; $519a
	add a, a ; $519b
	add a, a ; $519c
	add a, a ; $519d
	add a, $f6 ; $519e
	ld l, a ; $51a0
	adc a, $50 ; $51a1
	sub a, l ; $51a3
	ld h, a ; $51a4
	ld e, $01 ; $51a5
	call LoadPaletteShadow ; $51a7
	ret ; $51aa
	; $51ab, 5 bytes (fill)
	ds 5, $00
UnusedJpWindowTiles_01:
	INCBIN "data/bank_001/d_51b0.bin" ; $51b0, 256 bytes
	ds 256, $00 ; $52b0, fill
UnusedJpFontTiles_01:
	INCBIN "data/bank_001/d_53b0.bin" ; $53b0, 3136 bytes
UnusedJpFontPalettes_01:
	; $5ff0, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0180, $7fff, $3def, $0000 ; pal 0: #006200 #ffffff #7b7b7b #000000
	dw $1d2f, $7c00, $001f, $0000 ; pal 1: #7b4a39 #0000ff #ff0000 #000000
	dw $1d2f, $7fff, $001f, $0000 ; pal 2: #7b4a39 #ffffff #ff0000 #000000
	dw $01e0, $2508, $2508, $2508 ; pal 3: #007b00 #41414a #41414a #41414a
	dw $01e0, $2508, $2508, $2508 ; pal 4: #007b00 #41414a #41414a #41414a
	dw $0180, $0210, $235a, $63ff ; pal 5: #006200 #838300 #d5d541 #ffffc5
	dw $0180, $085f, $39df, $631f ; pal 6: #006200 #ff1010 #ff7373 #ffc5c5
	dw $0180, $0a82, $43f0, $63f8 ; pal 7: #006200 #10a410 #83ff83 #c5ffc5
ShowDmgLockoutScreen:
	ld a, $00 ; $6030
	ldh [rLCDC], a ; $6032
	ld hl, DmgLockoutTilesLZ_01 ; $6034
	ld de, $d000 ; $6037
	call DecompressData ; $603a
	ld hl, $d000 ; $603d
	ld de, $9000 ; $6040
	ld c, $80 ; $6043
	call CopyMemoryFast ; $6045
	ld hl, $d800 ; $6048
	ld de, $8800 ; $604b
	ld c, $80 ; $604e
	call CopyMemoryFast ; $6050
	ld hl, DmgLockoutTilemapLZ_01 ; $6053
	ld de, $d000 ; $6056
	call DecompressData ; $6059
	ld hl, $d000 ; $605c
	ld de, $9800 ; $605f
	ld c, $40 ; $6062
	call CopyMemoryFast ; $6064
	ld a, $e4 ; $6067
	ldh [rBGP], a ; $6069
	xor a, a ; $606b
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
	INCBIN "data/bank_001/d_607c.bin" ; $607c, 2183 bytes
DmgLockoutTilemapLZ_01:
	INCBIN "data/bank_001/d_6903.bin" ; $6903, 344 bytes
RunSoundTest:
	push af ; $6a5b
	push bc ; $6a5c
	push de ; $6a5d
	push hl ; $6a5e
	ld a, [$ca00] ; $6a5f
	ld d, a ; $6a62
	ld a, [$ca01] ; $6a63
	ld e, a ; $6a66
	ld b, $00 ; $6a67
	ldh a, [hDebugStepMode] ; $6a69
	push af ; $6a6b
	ld a, $03 ; $6a6c
	ldh [hDebugStepMode], a ; $6a6e
	push hl ; $6a70
	push de ; $6a71
	ld hl, SoundTestStrings_01 ; $6a72
	ld de, $0d09 ; $6a75
	call PrintString ; $6a78
	pop de ; $6a7b
	pop hl ; $6a7c
	push hl ; $6a7d
	push de ; $6a7e
	ld hl, $6b6a ; $6a7f
	ld de, $0d0b ; $6a82
	call PrintString ; $6a85
	pop de ; $6a88
	pop hl ; $6a89
.loop:
	call AdvanceFrame ; $6a8a
	ldh a, [hInputPressed] ; $6a8d
	and a, PADF_UP | PADF_DOWN ; $6a8f
	jr z, .step ; $6a91
	ld a, b ; $6a93
	xor a, $01 ; $6a94
	ld b, a ; $6a96
.step:
	ld a, b ; $6a97
	or a, a ; $6a98
	jr nz, .nonZero ; $6a99
	ldh a, [hInputPressed] ; $6a9b
	bit PADB_RIGHT, a ; $6a9d
	jr z, .zero ; $6a9f
	inc d ; $6aa1
	jr .step3 ; $6aa2
.zero:
	bit 5, a ; $6aa4
	jr z, .step9 ; $6aa6
	dec d ; $6aa8
.step3:
	ld a, d ; $6aa9
	cp a, $ff ; $6aaa
	jr nz, .neff ; $6aac
	ld d, $3e ; $6aae
	jr .step9 ; $6ab0
.neff:
	ld a, d ; $6ab2
	cp a, $3e ; $6ab3
	jr c, .step9 ; $6ab5
	jr z, .step9 ; $6ab7
	ld d, $00 ; $6ab9
	jr .step9 ; $6abb
.nonZero:
	ldh a, [hInputPressed] ; $6abd
	bit PADB_RIGHT, a ; $6abf
	jr z, .step6 ; $6ac1
	inc e ; $6ac3
	jr .step7 ; $6ac4
.step6:
	bit 5, a ; $6ac6
	jr z, .step9 ; $6ac8
	dec e ; $6aca
.step7:
	ld a, e ; $6acb
	cp a, $ff ; $6acc
	jr nz, .neff2 ; $6ace
	ld e, $71 ; $6ad0
	jr .step9 ; $6ad2
.neff2:
	ld a, e ; $6ad4
	cp a, $71 ; $6ad5
	jr c, .step9 ; $6ad7
	jr z, .step9 ; $6ad9
	ld e, $00 ; $6adb
.step9:
	ld a, b ; $6add
	or a, a ; $6ade
	jr nz, .nonZero2 ; $6adf
	push hl ; $6ae1
	push de ; $6ae2
	ld hl, $6b71 ; $6ae3
	ld de, $0c09 ; $6ae6
	call PrintString ; $6ae9
	pop de ; $6aec
	pop hl ; $6aed
	push hl ; $6aee
	push de ; $6aef
	ld hl, $6b73 ; $6af0
	ld de, $0c0b ; $6af3
	call PrintString ; $6af6
	pop de ; $6af9
	pop hl ; $6afa
	jr .printDecimalByte ; $6afb
.nonZero2:
	push hl ; $6afd
	push de ; $6afe
	ld hl, $6b71 ; $6aff
	ld de, $0c0b ; $6b02
	call PrintString ; $6b05
	pop de ; $6b08
	pop hl ; $6b09
	push hl ; $6b0a
	push de ; $6b0b
	ld hl, $6b73 ; $6b0c
	ld de, $0c09 ; $6b0f
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
	jr z, .label_01_6a8a ; $6b31
	bit 0, b ; $6b33
	jr nz, .bit0Set ; $6b35
	push af ; $6b37
	push bc ; $6b38
	push de ; $6b39
	push hl ; $6b3a
	ld a, d ; $6b3b
	add a, $75 ; $6b3c
	ld l, a ; $6b3e
	adc a, $6b ; $6b3f
	sub a, l ; $6b41
	ld h, a ; $6b42
	ld a, [hl] ; $6b43
	call PlaySoundManaged ; $6b44
	pop hl ; $6b47
	pop de ; $6b48
	pop bc ; $6b49
	pop af ; $6b4a
	jr .label_01_6a8a ; $6b4b
.bit0Set:
	push af ; $6b4d
	push bc ; $6b4e
	push de ; $6b4f
	push hl ; $6b50
	ld a, e ; $6b51
	add a, $b4 ; $6b52
	ld l, a ; $6b54
	adc a, $6b ; $6b55
	sub a, l ; $6b57
	ld h, a ; $6b58
	ld a, [hl] ; $6b59
	call PlaySoundManaged ; $6b5a
	pop hl ; $6b5d
	pop de ; $6b5e
	pop bc ; $6b5f
	pop af ; $6b60
.label_01_6a8a:
	jp .loop ; $6b61
SoundTestStrings_01:
	; $6b64, 17 bytes (bytes:16)
	db $4d, $55, $53, $49, $43, $00, $45, $46, $46, $45, $43, $54, $00, $3e, $00, $20 ; 0x00
	db $00 ; 0x10
SoundTestSoundsA_01:
	; $6b75, 63 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $16, $11, $12, $14, $19, $13, $15 ; 0x10
	db $14, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28 ; 0x20
	db $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $41, $42, $43, $44, $45 ; 0x30
SoundTestSoundsB_01:
	; $6bb4, 114 bytes (bytes:16)
	db $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f ; 0x00
	db $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e, $6f ; 0x10
	db $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f ; 0x20
	db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f ; 0x30
	db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f ; 0x40
	db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af ; 0x50
	db $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf ; 0x60
	db $c0, $c1 ; 0x70
	; $6c26, 5082 bytes fill to bank end (linker-padded)
