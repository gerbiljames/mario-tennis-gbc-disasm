ToggleSelectedUnlockFlag:
	push_wram_bank WRAM_SCENE ; $68a4
	ld hl, wUnlockFlagsBlock ; $68ad
	ld a, [wCharSelectChar] ; $68b0
	cp $1a ; $68b3
	jr c, .playSfx ; $68b5
	cp $20 ; $68b7
	jr nc, .playSfx ; $68b9
	sub $18 ; $68bb
	add l ; $68bd
	ld l, a ; $68be
	jr nc, .read ; $68bf
	inc h ; $68c1
.read:
	ld a, [hl] ; $68c2
	xor $01 ; $68c3
	ld [hl], a ; $68c5
	sound SFX_MENU_SELECT ; $68c6
	pop_wram_bank ; $68c8
	ret ; $68cd
.playSfx:
	sound SFX_MENU_CANCEL ; $68ce
	pop_wram_bank ; $68d0
	ret ; $68d5
LoadUnlockDebugCursorGfx:
	push_wram_bank WRAM_STAGING ; $68d6
	ld hl, UnlockDebugCursorGfx ; $68df
	ld de, wDecompBuffer ; $68e2
	call DecompressData ; $68e5
	ld hl, wDecompBuffer ; $68e8
	ld de, vTiles0 + $50 * TILE_SIZE ; $68eb
	ld c, UnlockDebugCursorGfx_SIZE / 16 ; $68ee
	call QueueVRAMCopy ; $68f0
	pop_wram_bank ; $68f3
	ld hl, UnlockDebugCursorPalette ; $68f8
	lb de, $08, $01 ; $68fb palette index, count
	call LoadPaletteShadow ; $68fe
	ld a, $01 ; $6901
	ld hl, DrawUnlockDebugFlagSprites ; $6903
	call RegisterFrameTask ; $6906
	ret ; $6909
UnlockDebugCursorGfx:
	INCBIN "data/bank_01b/lz_UnlockDebugCursorGfx.bin" ; $690a, 29 bytes
	INCLUDE "data/bank_01b/lz_UnlockDebugCursorGfx.inc" ; DEF UnlockDebugCursorGfx_SIZE EQU its decoded length, generated from the .bin by make
	; $6927, 9 bytes (fill)
	ds 9, $00
UnlockDebugCursorPalette:
	INCLUDE "data/bank_01b/UnlockDebugCursorPalette.asm" ; $6930, 8 bytes (palettes)
DrawUnlockDebugFlagSprites:
	push_wram_bank WRAM_SCENE ; $6938
	ld hl, wUnlockFlagsBlock + 2 ; $6941
	xor a ; $6944
.loop:
	push af ; $6945
	add a ; $6946
	bit 0, [hl] ; $6947
	inc hl ; $6949
	jr z, .restore ; $694a
	push hl ; $694c
	ld hl, UnlockDebugFlagSprites ; $694d
	add l ; $6950
	ld l, a ; $6951
	jr nc, .read ; $6952
	inc h ; $6954
.read:
	ld d, [hl] ; $6955
	inc hl ; $6956
	ld e, [hl] ; $6957
	pop hl ; $6958
	call QueueBobbingFlagSprite ; $6959
.restore:
	pop af ; $695c
	inc a ; $695d
	cp $06 ; $695e
	jr c, .loop ; $6960
	pop_wram_bank ; $6962
	ret ; $6967
UnlockDebugFlagSprites:
	; $6968, 12 bytes (bytes:12)
	db $24, $28, $3c, $28, $54, $28, $6c, $28, $84, $28, $24, $40 ; 0x00
QueueBobbingFlagSprite:
	push hl ; $6974
	farcall ApplySpriteBobOffset_18 ; $6975
	ld c, $50 ; $6978
	ld b, $00 ; $697a
	call QueueSprite ; $697c
	pop hl ; $697f
	ret ; $6980
	ret ; $6981
RunStoryDataConfirmMenu:
	wram_bank WRAM_STAGING ; $6982
	ld c, $20 ; $6988
	call BeginFadeOut ; $698a
	call WaitFadeEnd ; $698d
	call DisableLCDSafely ; $6990
	xor a ; $6993
	ld [wMinigameHighScoreMode], a ; $6994
	ld [wStoryDataPromptFlag], a ; $6997
	farcall ForceFlushBgMapToVram ; $699a
	call EnableLCD ; $699d
	script_fade_in $20 ; $69a0
	call WaitFadeEnd ; $69a5
	wram_bank WRAM_SOUND ; $69a8
	xor a ; $69ae
	ld [wStubbedPromptTaskState], a ; $69af
	ld a, $0c ; $69b2
	ld [wStubbedPromptTaskState + 1], a ; $69b4
	ld a, $01 ; $69b7
	ld hl, StubNop_1b_09 ; $69b9
	call RegisterFrameTask ; $69bc
	ld b, $01 ; $69bf
	farcall RunTwoOptionSelectB ; $69c1
	push af ; $69c4
	ld hl, StubNop_1b_09 ; $69c5
	call UnregisterFrameTask ; $69c8
	pop af ; $69cb
	ret ; $69cc
; A lone $c9 (ret) followed by the byte pair $ff $36 four times, wedged
; between the end of a two-option-select wrapper and the run of ret
; bytes named StubNop_1b_09. Reads as a stub return plus filler.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_1b_StubRetAndFill:
	; $69cd, 9 bytes (bytes:9)
	db $c9, $ff, $36, $ff, $36, $ff, $36, $ff, $36 ; 0x00
StubNop_1b_09:
	ret ; $69d6
Unused_1b_StubRet1:
	ret ; $69d7
Unused_1b_StubRet2:
	ret ; $69d8
Unused_1b_ShowHighScoreConfirmScreen:
	ld hl, wMinigameHighScoreMode ; $69d9
	ld [hl], $01 ; $69dc
	wram_bank WRAM_STAGING ; $69de
	ld c, $20 ; $69e4
	call BeginFadeOut ; $69e6
	call WaitFadeEnd ; $69e9
	call DisableLCDSafely ; $69ec
	farcall InitConfirmScreen ; $69ef
	call StubNop_1b_10 ; $69f2
	farcall ForceFlushBgMapToVram ; $69f5
	call EnableLCD ; $69f8
	script_fade_in $20 ; $69fb
	call WaitFadeEnd ; $6a00
.loop:
	and a ; $6a03
	jr nz, .loop ; $6a04
	ld b, $00 ; $6a06
	farcall StubNop_18_1 ; $6a08
	call AdvanceFrame ; $6a0b
	ret ; $6a0e
Unused_1b_DrawErasePrompt:
	ld hl, wPlayer1MainName ; $6a0f
	farcall PushTextArgString ; $6a12
	ld de, $d9c1 ; $6a15
	call CopyMainCharNameWithDiacritics ; $6a18
	ld hl, Text_31_106 ; $6a1b
	farcall RenderProportionalTextAt32 ; $6a1e
	farcall Unused_18_DrawYesNoLabels ; $6a21
	ret ; $6a24
Unused_1b_DrawContinuePrompt:
	ld hl, Text_31_109 ; $6a25
	ld de, $d9c1 ; $6a28
	farcall RenderProportionalTextAt32 ; $6a2b
	farcall Unused_18_DrawYesNoLabels ; $6a2e
	ret ; $6a31
Unused_1b_DrawEraseConfirmPrompt:
	ld hl, Text_31_107 ; $6a32
	ld de, $d9c1 ; $6a35
	farcall RenderProportionalTextAt32 ; $6a38
	farcall Unused_18_DrawYesNoLabels ; $6a3b
	ret ; $6a3e
Unused_1b_DrawIsThisCorrectPrompt:
	ld hl, Text_31_113 ; $6a3f
	ld de, $d9c1 ; $6a42
	farcall RenderProportionalTextAt32 ; $6a45
	farcall Unused_18_DrawYesNoLabels ; $6a48
	ret ; $6a4b
Unused_1b_DrawCharAndItemDataPrompt:
	ld hl, Text_30_354 ; $6a4c
	ld de, $d9c1 ; $6a4f
	farcall RenderProportionalTextAt32 ; $6a52
	ld hl, Text_30_354 ; $6a55
	ld de, $da01 ; $6a58
	farcall RenderProportionalTextAt32 ; $6a5b
	ret ; $6a5e
Unused_1b_DrawGameTimerRow:
	ld a, [wGameTimer + 3] ; $6a5f
	ld h, $00 ; $6a62
	ld l, a ; $6a64
	ld a, $02 ; $6a65
	ld de, $da05 ; $6a67
	farcall DrawDecimalNumberToTilemap ; $6a6a
	ld a, [wGameTimer + 2] ; $6a6d
	add $64 ; $6a70
	ld h, $00 ; $6a72
	ld l, a ; $6a74
	ld a, $03 ; $6a75
	ld de, $da07 ; $6a77
	farcall DrawDecimalNumberToTilemap ; $6a7a
	ld a, [wGameTimer + 1] ; $6a7d
	add $64 ; $6a80
	ld h, $00 ; $6a82
	ld l, a ; $6a84
	ld a, $03 ; $6a85
	ld de, $da0a ; $6a87
	farcall DrawDecimalNumberToTilemap ; $6a8a
	ld a, $3a ; $6a8d
	ld de, $da07 ; $6a8f
	farcall WriteTilemapByteAdvance ; $6a92
	ld a, $3a ; $6a95
	ld de, $da0a ; $6a97
	farcall WriteTilemapByteAdvance ; $6a9a
	call Unused_1b_QueueStoryInfoRowToVram ; $6a9d
	ret ; $6aa0
Unused_1b_QueueStoryInfoRowToVram:
	ld hl, $da00 ; $6aa1
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH ; $6aa4
	ld c, $01 ; $6aa7
	call QueueVRAMCopy ; $6aa9
	ret ; $6aac
StubNop_1b_10:
	ret ; $6aad
CopyMainCharNameWithDiacritics:
	push de ; $6aae
	ld hl, wStoryModeNameOfMainCharacter ; $6aaf
	pop de ; $6ab2
.loop:
	ld a, [hl+] ; $6ab3
	and a ; $6ab4
	jr z, .done ; $6ab5
	cp $de ; $6ab7
	jr z, .eqde ; $6ab9
	cp $df ; $6abb
	jr z, .eqdf ; $6abd
	ld b, a ; $6abf
	ld a, b ; $6ac0
	ld [de], a ; $6ac1
	inc de ; $6ac2
	jr .loop ; $6ac3
.eqde:
	push de ; $6ac5
	push hl ; $6ac6
	ld hl, $ffdf ; $6ac7
	add hl, de ; $6aca
	ld [hl], $0e ; $6acb
	pop hl ; $6acd
	pop de ; $6ace
	jr .loop ; $6acf
.eqdf:
	push de ; $6ad1
	push hl ; $6ad2
	ld hl, $ffdf ; $6ad3
	add hl, de ; $6ad6
	ld [hl], $0f ; $6ad7
	pop hl ; $6ad9
	pop de ; $6ada
	jr .loop ; $6adb
.done:
	ret ; $6add
ShowNoN64DataFoundScreen:
	wram_bank WRAM_STAGING ; $6ade
	ld c, $20 ; $6ae4
	call BeginFadeOut ; $6ae6
	call WaitFadeEnd ; $6ae9
	call DisableLCDSafely ; $6aec
	ld a, $20 ; $6aef
	ld hl, wTextTileBuffer + 6 * TILE_SIZE + 2 ; $6af1
	call FillTilemapRow17 ; $6af4
	ld hl, wTextTileBuffer + 8 * TILE_SIZE + 2 ; $6af7
	call FillTilemapRow17 ; $6afa
	ld hl, wTextTileBuffer + 10 * TILE_SIZE + 2 ; $6afd
	call FillTilemapRow17 ; $6b00
	ld hl, wTextTileBuffer + 12 * TILE_SIZE + 2 ; $6b03
	call FillTilemapRow17 ; $6b06
	ld hl, wTextTileBuffer + 14 * TILE_SIZE + 2 ; $6b09
	call FillTilemapRow17 ; $6b0c
	ld a, $00 ; $6b0f
	ld hl, wTextTileBuffer + 70 * TILE_SIZE + 2 ; $6b11
	call FillTilemapRow17 ; $6b14
	ld hl, wTextTileBuffer + 72 * TILE_SIZE + 2 ; $6b17
	call FillTilemapRow17 ; $6b1a
	ld hl, wTextTileBuffer + 74 * TILE_SIZE + 2 ; $6b1d
	call FillTilemapRow17 ; $6b20
	ld hl, wTextTileBuffer + 76 * TILE_SIZE + 2 ; $6b23
	call FillTilemapRow17 ; $6b26
	ld hl, wTextTileBuffer + 78 * TILE_SIZE + 2 ; $6b29
	call FillTilemapRow17 ; $6b2c
	ld hl, Text_31_123 ; $6b2f
	ld de, wTextTileBuffer + 8 * TILE_SIZE + 3 ; $6b32
	farcall RenderProportionalTextAt32 ; $6b35
	ld hl, Text_31_124 ; $6b38
	ld de, wTextTileBuffer + 12 * TILE_SIZE + 3 ; $6b3b
	farcall RenderProportionalTextAt32 ; $6b3e
	farcall ForceFlushBgMapToVram ; $6b41
	call EnableLCD ; $6b44
	script_fade_in $20 ; $6b47
	call WaitFadeEnd ; $6b4c
.loop:
	ldh a, [hInputRisingEdge] ; $6b4f
	and PADF_A | PADF_B ; $6b51
	jr nz, .playSfx ; $6b53
	call AdvanceFrame ; $6b55
	jr .loop ; $6b58
.playSfx:
	sound SFX_MENU_SELECT ; $6b5a
	ret ; $6b5c
FillTilemapRow17:
	ld [hl+], a ; $6b5d
	ld [hl+], a ; $6b5e
	ld [hl+], a ; $6b5f
	ld [hl+], a ; $6b60
	ld [hl+], a ; $6b61
	ld [hl+], a ; $6b62
	ld [hl+], a ; $6b63
	ld [hl+], a ; $6b64
	ld [hl+], a ; $6b65
	ld [hl+], a ; $6b66
	ld [hl+], a ; $6b67
	ld [hl+], a ; $6b68
	ld [hl+], a ; $6b69
	ld [hl+], a ; $6b6a
	ld [hl+], a ; $6b6b
	ld [hl+], a ; $6b6c
	ld [hl+], a ; $6b6d
	ret ; $6b6e
ShowTrophiesPlaceholderScreen:
	wram_bank WRAM_STAGING ; $6b6f
	ld c, $20 ; $6b75
	call BeginFadeOut ; $6b77
	call WaitFadeEnd ; $6b7a
	call DisableLCDSafely ; $6b7d
	farcall ForceFlushBgMapToVram ; $6b80
	call EnableLCD ; $6b83
	script_fade_in $20 ; $6b86
	call WaitFadeEnd ; $6b8b
.loop:
	ldh a, [hInputRisingEdge] ; $6b8e
	and PADF_A | PADF_B ; $6b90
	jr nz, .playSfx ; $6b92
	call AdvanceFrame ; $6b94
	jr .loop ; $6b97
.playSfx:
	sound SFX_MENU_SELECT ; $6b99
	ret ; $6b9b
RunMinigameLevelSelect:
	push_wram_bank WRAM_COURT_PLANES ; $6b9c
	ld a, c ; $6ba5
	ld [wScreenAttrmap], a ; $6ba6
	xor a ; $6ba9
	ld [wScreenAttrmap + 1], a ; $6baa
	call CountClearedMinigameLevels ; $6bad
	call LoadMinigameLevelSelectGfx ; $6bb0
	ld a, [wScreenAttrmap + 1] ; $6bb3
	cp $02 ; $6bb6
	jr z, .runMinigameLevelSelect3 ; $6bb8
	call RunMinigameLevelSelect2 ; $6bba
	jr .step ; $6bbd
.runMinigameLevelSelect3:
	call RunMinigameLevelSelect3 ; $6bbf
.step:
	wram_bank WRAM_COURT_PLANES ; $6bc2
	ld a, [wScreenAttrmap + 3] ; $6bc8
	ld c, a ; $6bcb
	pop_wram_bank ; $6bcc
	ld a, c ; $6bd1
	ret ; $6bd2
CountClearedMinigameLevels:
	ld c, $00 ; $6bd3
	ld a, [wScreenAttrmap] ; $6bd5
	add a ; $6bd8
	ld hl, ClearedMinigameLevelsTable ; $6bd9
	add l ; $6bdc
	ld l, a ; $6bdd
	jr nc, .read ; $6bde
	inc h ; $6be0
.read:
	ld a, [hl+] ; $6be1
	ld h, [hl] ; $6be2
	ld l, a ; $6be3
	push hl ; $6be4
	ld a, [hl+] ; $6be5
	ld d, [hl] ; $6be6
	ld e, a ; $6be7
	farcall TestSaveFlag ; $6be8
	pop hl ; $6beb
	jr z, .next ; $6bec
	inc c ; $6bee
.next:
	inc hl ; $6bef
	inc hl ; $6bf0
	ld a, [hl+] ; $6bf1
	ld d, [hl] ; $6bf2
	ld e, a ; $6bf3
	farcall TestSaveFlag ; $6bf4
	jr z, .countDone ; $6bf7
	inc c ; $6bf9
.countDone:
	ld a, c ; $6bfa
	ld [wScreenAttrmap + 1], a ; $6bfb
	ld a, [wScreenAttrmap + 1] ; $6bfe
	ld hl, CountClearedMinigameLevelsTable ; $6c01
	add l ; $6c04
	ld l, a ; $6c05
	jr nc, .readB ; $6c06
	inc h ; $6c08
.readB:
	ld a, [hl] ; $6c09
	ld [wScreenAttrmap + 2], a ; $6c0a
	ret ; $6c0d
CountClearedMinigameLevelsTable:
	; $6c0e, 3 bytes (bytes:3)
	db $02, $02, $03 ; 0x00
ClearedMinigameLevelsTable:
	; $6c11, 18 bytes (records:2)
	dw MinigameLevelRow0 ; record 0
	dw MinigameLevelRow1 ; record 1
	dw MinigameLevelRow2 ; record 2
	dw MinigameLevelRow3 ; record 3
	dw MinigameLevelRow4 ; record 4
	dw MinigameLevelRow5 ; record 5
	dw MinigameLevelRow6 ; record 6
	dw MinigameLevelRow7 ; record 7
	dw MinigameLevelRow8 ; record 8
MinigameLevelRow0:
	; $6c23, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_BOO_BLAST_1 ; 0
	dw SAVEFLAG_CLEARED_BOO_BLAST_2 ; 1
	dw SAVEFLAG_CLEARED_BOO_BLAST_3 ; 2
MinigameLevelRow1:
	; $6c29, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_1 ; 0
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_2 ; 1
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_3 ; 2
MinigameLevelRow2:
	; $6c2f, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_1 ; 0
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_2 ; 1
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_3 ; 2
MinigameLevelRow3:
	; $6c35, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_TARGET_SHOT_1 ; 0
	dw SAVEFLAG_CLEARED_TARGET_SHOT_2 ; 1
	dw SAVEFLAG_CLEARED_TARGET_SHOT_3 ; 2
MinigameLevelRow4:
	; $6c3b, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_1 ; 0
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_2 ; 1
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_3 ; 2
MinigameLevelRow5:
	; $6c41, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_1 ; 0
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_2 ; 1
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_3 ; 2
MinigameLevelRow6:
	; $6c47, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_TREASURE_BOX_1 ; 0
	dw SAVEFLAG_CLEARED_TREASURE_BOX_2 ; 1
	dw SAVEFLAG_CLEARED_TREASURE_BOX_3 ; 2
MinigameLevelRow7:
	; $6c4d, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_1 ; 0
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_2 ; 1
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_3 ; 2
MinigameLevelRow8:
	; $6c53, 6 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_1 ; 0
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_2 ; 1
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_3 ; 2
LoadMinigameLevelSelectGfx:
	push_wram_bank WRAM_STAGING ; $6c59
	ld c, $00 ; $6c62
.loop:
	ld a, c ; $6c64
	add a ; $6c65
	ld hl, MinigameLevelSelectGfxTable ; $6c66
	add l ; $6c69
	ld l, a ; $6c6a
	jr nc, .read ; $6c6b
	inc h ; $6c6d
.read:
	ld a, [hl+] ; $6c6e
	ld h, [hl] ; $6c6f
	ld l, a ; $6c70
	push af ; $6c71
	push bc ; $6c72
	push de ; $6c73
	push hl ; $6c74
	ld de, wDecompBuffer ; $6c75
	call DecompressDataFromBank ; $6c78
	pop hl ; $6c7b
	pop de ; $6c7c
	pop bc ; $6c7d
	pop af ; $6c7e
	ld hl, MinigameLevelSelectTable ; $6c7f
	ld a, c ; $6c82
	add a ; $6c83
	add l ; $6c84
	ld l, a ; $6c85
	jr nc, .readB ; $6c86
	inc h ; $6c88
.readB:
	ld a, [hl+] ; $6c89
	ld d, [hl] ; $6c8a
	ld e, a ; $6c8b
	ld hl, wDecompBuffer ; $6c8c
	push af ; $6c8f
	push bc ; $6c90
	push de ; $6c91
	push hl ; $6c92
	ld bc, $0010 ; $6c93
	call QueueVRAMCopy ; $6c96
	pop hl ; $6c99
	pop de ; $6c9a
	pop bc ; $6c9b
	pop af ; $6c9c
	ld a, c ; $6c9d
	inc a ; $6c9e
	ld c, a ; $6c9f
	call AdvanceFrame ; $6ca0
	push_wram_bank WRAM_COURT_PLANES ; $6ca3
	ld a, [wScreenAttrmap + 1] ; $6cac
	ld b, a ; $6caf
	pop_wram_bank ; $6cb0
	ld a, b ; $6cb5
	or a ; $6cb6
	jr z, .zero ; $6cb7
	ld a, c ; $6cb9
	cp $03 ; $6cba
	jr nz, .loop ; $6cbc
	jr .loadCompressedTileBlock2 ; $6cbe
.zero:
	ld a, c ; $6cc0
	cp $04 ; $6cc1
	jr nz, .loop ; $6cc3
.loadCompressedTileBlock2:
	ld b, TILEBLOCK_MinigameLevelSelectGfx0 ; $6cc5
	ld c, MinigameLevelSelectGfx0_SIZE / 16 ; $6cc7
	ld de, vTiles0 + VRAM_BANK1 ; $6cc9
	farcall LoadCompressedTileBlock ; $6ccc
	call AdvanceFrame ; $6ccf
	push_wram_bank WRAM_COURT_PLANES ; $6cd2
	ld a, [wScreenAttrmap + 1] ; $6cdb
	ld b, a ; $6cde
	pop_wram_bank ; $6cdf
	ld a, b ; $6ce4
	or a ; $6ce5
	jr z, .zero2 ; $6ce6
	ld b, TILEBLOCK_MinigameLevelSelectIconGfx ; $6ce8
	jr .loadCompressedTileBlock ; $6cea
.zero2:
	ld b, TILEBLOCK_SharedMenuGfx111 ; $6cec
.loadCompressedTileBlock:
	ld c, SharedMenuGfx111_SIZE / 16 ; $6cee
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $6cf0
	farcall LoadCompressedTileBlock ; $6cf3
	call AdvanceFrame ; $6cf6
	ld b, TILEBLOCK_MinigameLevelSelectGfx1 ; $6cf9
	ld c, MinigameLevelSelectGfx1_SIZE / 16 ; $6cfb
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $6cfd
	farcall LoadCompressedTileBlock ; $6d00
	call AdvanceFrame ; $6d03
	ld b, TILEBLOCK_SharedMenuGfx27 ; $6d06
	ld c, SharedMenuGfx27_SIZE / 16 ; $6d08
	ld de, vTiles0 + $70 * TILE_SIZE + VRAM_BANK1 ; $6d0a
	farcall LoadCompressedTileBlock ; $6d0d
	call AdvanceFrame ; $6d10
	ld b, TILEBLOCK_MinigameLevelSelectGfx2Alias16 ; $6d13
	ld c, MinigameLevelSelectGfx2_SIZE / 16 ; $6d15
	ld de, vTiles0 ; $6d17
	farcall LoadCompressedTileBlock ; $6d1a
	call AdvanceFrame ; $6d1d
	ld b, $08 ; $6d20
	ld c, $10 ; $6d22
	farcall LoadIndexedPalette ; $6d24
	pop_wram_bank ; $6d27
	ret ; $6d2c
MinigameLevelSelectGfxTable:
	; $6d2d, 8 bytes (records:2)
	dw MinigameLevelSelectGfxHandler0 ; record 0
	dw MinigameLevelSelectGfxHandler1 ; record 1
	dw MinigameLevelSelectGfxHandler2 ; record 2
	dw MinigameLevelSelectGfxTable0 ; record 3
MinigameLevelSelectTable:
	; $6d35, 8 bytes (records:2)
	dw $a800 ; record 0
	dw $a900 ; record 1
	dw $aa00 ; record 2
	dw $a900 ; record 3
DrawMinigameLevelDescription:
	push_wram_bank WRAM_COURT_PLANES ; $6d3d
	ld a, [wScreenAttrmap + 1] ; $6d46
	or a ; $6d49
	jr nz, .getMenuCursorIndex ; $6d4a
	ld c, $03 ; $6d4c
	call GetMenuCursorIndex_1b ; $6d4e
	cp $01 ; $6d51
	jr nz, .getMenuCursorIndex ; $6d53
	wram_bank WRAM_SCREEN ; $6d55
	ld hl, $00c5 ; $6d5b
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6d5e
	jr .renderTextToBuffer64 ; $6d61
.getMenuCursorIndex:
	wram_bank WRAM_SCREEN ; $6d63
	ld c, $03 ; $6d69
	call GetMenuCursorIndex_1b ; $6d6b
	ld b, a ; $6d6e
	ld hl, MinigameLevelDescriptionTable ; $6d6f
	add a ; $6d72
	add l ; $6d73
	ld l, a ; $6d74
	jr nc, .read ; $6d75
	inc h ; $6d77
.read:
	ld a, [hl+] ; $6d78
	ld d, [hl] ; $6d79
	ld e, a ; $6d7a
	ld a, b ; $6d7b
	ld hl, Text_30_194 ; $6d7c
	add l ; $6d7f
	ld l, a ; $6d80
	jr nc, .renderTextToBuffer64 ; $6d81
	inc h ; $6d83
.renderTextToBuffer64:
	ld c, $20 ; $6d84
	farcall RenderTextToBuffer64 ; $6d86
	pop af ; $6d89
MinigameLevelSelectGfxHandler0:
	ldh [hWramBank], a ; $6d8a
MinigameLevelSelectGfxHandler1:
	ldh [rWBK], a ; $6d8c
MinigameLevelSelectGfxHandler2:
	ret ; $6d8e
MinigameLevelDescriptionTable:
	; $6d8f, 1 bytes (bytes:6)
	db $01 ; 0x00
MinigameLevelSelectGfxTable0:
	; $6d90, 5 bytes (bytes:6)
	db $d2, $01, $d2, $01, $d2 ; 0x00
LoadMinigameLevelSelectPalette:
	ld hl, MinigameLevelSelectPalettePtrs ; $6d95
	add a ; $6d98
	add l ; $6d99
	ld l, a ; $6d9a
	jr nc, .read ; $6d9b
	inc h ; $6d9d
.read:
	ld a, [hl+] ; $6d9e
	ld h, [hl] ; $6d9f
	ld l, a ; $6da0
	lb de, $04, $01 ; $6da1 palette index, count
	call LoadPaletteShadow ; $6da4
	ret ; $6da7
MinigameLevelSelectPalettePtrs:
	; $6da8, 6 bytes (records:2)
	dw MinigameLevelSelectPalette0 ; record 0
	dw MinigameLevelSelectPalette2 ; record 1
	dw MinigameLevelSelectPalette1 ; record 2
MinigameLevelSelectPalette0:
	; $6dae, 8 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
MinigameLevelSelectPalette1:
	; $6db6, 8 bytes (bytes:8)
	db $b7, $5e, $ff, $6b, $93, $7c, $00, $00 ; 0x00
MinigameLevelSelectPalette2:
	; $6dbe, 8 bytes (bytes:8)
	db $99, $52, $ff, $6b, $1f, $14, $00, $00 ; 0x00
