ApplySlideOffsetToSpriteX:
	push bc ; $5997
	ld b, $00 ; $5998
	ld c, d ; $599a
	wram_bank WRAM_SCENE ; $599b
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	add hl, bc ; $59a4
	ld a, h ; $59a5
	or a ; $59a6
	jr nz, .offscreen ; $59a7
	ld a, l ; $59a9
	cp $a0 ; $59aa
	jr nc, .offscreen ; $59ac
	ld d, l ; $59ae
	pop bc ; $59af
	ret ; $59b0
.offscreen:
	ld d, $a8 ; $59b1
	pop bc ; $59b3
	ret ; $59b4
GetCharDataDigitSprite:
	sub $30 ; $59b5
	rlca ; $59b7
	add $38 ; $59b8
	ld c, a ; $59ba
	ld b, $08 ; $59bb
	ret ; $59bd
ComputeExpProgressBar:
	ld a, [wStoryCharacterSlot] ; $59be
	farcall GetExpRemainingToNextLevel ; $59c1
	ld a, h ; $59c4
	or l ; $59c5
	jp z, .returnZero ; $59c6
	push hl ; $59c9
	ld a, [wStoryCharacterSlot] ; $59ca
	farcall GetExpProgressInCurrentLevel ; $59cd
	pop de ; $59d0
	push hl ; $59d1
	add hl, de ; $59d2
	pop de ; $59d3
	ld b, $40 ; $59d4
	call ScaleValueToBar ; $59d6
	ret ; $59d9
.returnZero:
	xor a ; $59da
	ret ; $59db
ScaleValueToBar:
	push bc ; $59dc
	push hl ; $59dd
	ld h, $00 ; $59de
	ld l, b ; $59e0
	call MulHLByDESigned ; $59e1
	ldh a, [hMulResult] ; $59e4
	ld l, a ; $59e6
	ldh a, [hMulResult + 1] ; $59e7
	ld h, a ; $59e9
	ldh a, [hMulResult + 2] ; $59ea
	pop de ; $59ec
	call DivAHLByDE ; $59ed
	ld a, h ; $59f0
	or a ; $59f1
	jr nz, .done ; $59f2
	pop bc ; $59f4
	inc b ; $59f5
	ld a, l ; $59f6
	cp b ; $59f7
	ret c ; $59f8
.done:
	pop bc ; $59f9
	ld a, b ; $59fa
	ret ; $59fb
DrawExpProgressBarTiles:
	ld b, a ; $59fc
	wram_bank WRAM_SCREEN ; $59fd
.loop:
	ld a, b ; $5a03
	sub $08 ; $5a04
	jr c, .carry ; $5a06
	jr z, .zero ; $5a08
	ld b, a ; $5a0a
	ld a, $08 ; $5a0b
	rlca ; $5a0d
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a0e
	ld a, [hl+] ; $5a15
	ld [de], a ; $5a16
	push de ; $5a17
	ld a, $0a ; $5a18
	add e ; $5a1a
	ld e, a ; $5a1b
	jr nc, .read ; $5a1c
	inc d ; $5a1e
.read:
	ld a, [hl] ; $5a1f
	ld [de], a ; $5a20
	pop de ; $5a21
	inc de ; $5a22
	jr .loop ; $5a23
.carry:
	add $08 ; $5a25
	rlca ; $5a27
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a28
	ld a, [hl+] ; $5a2f
	ld [de], a ; $5a30
	ld a, $0a ; $5a31
	add e ; $5a33
	ld e, a ; $5a34
	jr nc, .readB ; $5a35
	inc d ; $5a37
.readB:
	ld a, [hl] ; $5a38
	ld [de], a ; $5a39
	ret ; $5a3a
.zero:
	ld a, $08 ; $5a3b
	rlca ; $5a3d
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a3e
	ld a, [hl+] ; $5a45
	ld [de], a ; $5a46
	ld a, $0a ; $5a47
	add e ; $5a49
	ld e, a ; $5a4a
	jr nc, .read2 ; $5a4b
	inc d ; $5a4d
.read2:
	ld a, [hl] ; $5a4e
	ld [de], a ; $5a4f
	ret ; $5a50
DrawExpProgressBarTilesTable:
	; $5a51, 18 bytes (bytes:16)
	db $f9, $fa, $e1, $f1, $e2, $f2, $e3, $f3, $e4, $f4, $e5, $f5, $e6, $f6, $e7, $f7 ; 0x00
	db $e8, $f8 ; 0x10
PromptCharDataConfirm:
	push af ; $5a63
	call ClearFrameTasks ; $5a64
	call DisableLCDSafely ; $5a67
	xor a ; $5a6a
	ldh [hScrollX], a ; $5a6b
	ldh [hScrollY], a ; $5a6d
	ld [wCameraX], a ; $5a6f
	ld [wCameraX + 1], a ; $5a72
	ld [wCameraY], a ; $5a75
	ld [wCameraY + 1], a ; $5a78
	ld a, $90 ; $5a7b
	ldh [rWY], a ; $5a7d
	call ClearSpriteQueue ; $5a7f
	call InitDrillWorkRam ; $5a82
	pop af ; $5a85
	call BuildCharDataConfirmScreen ; $5a86
	call EnableLCD ; $5a89
	call AdvanceFrame ; $5a8c
	farcall StartCharDataScreenAnimTask ; $5a8f
	script_fade_in $10 ; $5a92
	call WaitFadeEnd ; $5a97
	wram_bank WRAM_SCENE ; $5a9a
	ld a, $01 ; $5aa0
	ld [wCharDataConfirmState], a ; $5aa2
.loop:
	call DrawConfirmSelectionCursor_1d ; $5aa5
	call AdvanceFrame ; $5aa8
	ldh a, [hInputRisingEdge] ; $5aab
	bit PADB_A, a ; $5aad
	jr nz, .step ; $5aaf
	bit 1, a ; $5ab1
	jr nz, .beginFadeOut2 ; $5ab3
	and $c0 ; $5ab5
	jr z, .loop ; $5ab7
	sound SFX_MENU_MOVE ; $5ab9
	ld a, [wCharDataConfirmState] ; $5abb
	xor $01 ; $5abe
	ld [wCharDataConfirmState], a ; $5ac0
	jr .loop ; $5ac3
.step:
	wram_bank WRAM_SCENE ; $5ac5
	ld a, [wCharDataConfirmState] ; $5acb
	or a ; $5ace
	jr nz, .beginFadeOut2 ; $5acf
	sound SFX_MENU_SELECT ; $5ad1
	jr .beginFadeOut ; $5ad3
.beginFadeOut2:
	wram_bank WRAM_SCENE ; $5ad5
	ld a, $01 ; $5adb
	ld [wCharDataConfirmState], a ; $5add
	sound SFX_MENU_CANCEL ; $5ae0
.beginFadeOut:
	ld c, $10 ; $5ae2
	call BeginFadeOut ; $5ae4
	call WaitFadeEnd ; $5ae7
	farcall StopCharDataScreenAnimTask ; $5aea
	call ClearFrameTasks ; $5aed
	wram_bank WRAM_SCENE ; $5af0
	ld a, [wCharDataConfirmState] ; $5af6
	ret ; $5af9
; Instruction-identical to DrawConfirmSelectionCursor_1a and DrawConfirmSelectionCursor_1c (one copy per bank); a change here belongs in every copy.
	twin draw_confirm_selection_cursor, 1d ; $5afa DrawConfirmSelectionCursor_1d
BuildCharDataConfirmScreen:
	push af ; $5b1a
	farcall CharDataScreen_LoadScreen ; $5b1b
	farcall LoadCharDataScreenTilemaps ; $5b1e
	pop af ; $5b21
	ld [wStoryCharacterSlot], a ; $5b22
	push af ; $5b25
	ld hl, wStoryModeNameOfMainCharacter ; $5b26
	ld a, [wStoryCharacterSlot] ; $5b29
	or a ; $5b2c
	jr z, .zero ; $5b2d
	ld l, $40 ; $5b2f
.zero:
	ld a, l ; $5b31
	add $0c ; $5b32
	ld l, a ; $5b34
	ld a, h ; $5b35
	adc $00 ; $5b36
	ld h, a ; $5b38
	pop af ; $5b39
	ld a, [hl] ; $5b3a
	lb de, $04, $01 ; $5b3b palette index, count
	farcall LoadIndexedPaletteThunk ; $5b3e
	wram_bank WRAM_STAGING ; $5b41
	push af ; $5b47
	ld hl, wStoryModeNameOfMainCharacter ; $5b48
	ld a, [wStoryCharacterSlot] ; $5b4b
	or a ; $5b4e
	jr z, .zero2 ; $5b4f
	ld l, $40 ; $5b51
.zero2:
	ld a, l ; $5b53
	add $0b ; $5b54
	ld l, a ; $5b56
	ld a, h ; $5b57
	adc $00 ; $5b58
	ld h, a ; $5b5a
	pop af ; $5b5b
	ld a, [hl] ; $5b5c
	ld de, wDecompBuffer ; $5b5d
	farcall DecompressCharMugshot ; $5b60
	ld hl, wDecompBuffer ; $5b63
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $5b66
	ld c, $03 ; $5b69
	call QueueVRAMCopy ; $5b6b
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $5b6e
	ld de, vTiles2 + $30 * TILE_SIZE + VRAM_BANK1 ; $5b71
	ld c, $03 ; $5b74
	call QueueVRAMCopy ; $5b76
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $5b79
	ld de, vTiles2 + $40 * TILE_SIZE + VRAM_BANK1 ; $5b7c
	ld c, $03 ; $5b7f
	call QueueVRAMCopy ; $5b81
	call BuildCharStatDisplay ; $5b84
	ld hl, CharDataConfirmScreenTilemapPatch0 ; $5b87
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $5b8a
	call ApplyTilemapPatchList ; $5b8d
	ld hl, CharDataConfirmScreenTilemapPatch1 ; $5b90
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $5b93
	call ApplyTilemapPatchList ; $5b96
	ld hl, CharDataConfirmScreenTilemapPatch2 ; $5b99
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $5b9c
	call ApplyTilemapPatchList ; $5b9f
	ld hl, CharDataConfirmScreenTilemapPatch3 ; $5ba2
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $5ba5
	call ApplyTilemapPatchList ; $5ba8
	ld hl, CharDataConfirmScreenTilemapPatch4 ; $5bab
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $5bae
	call ApplyTilemapPatchList ; $5bb1
	ld hl, CharDataConfirmScreenTilemapPatch5 ; $5bb4
	ld bc, wCharDataPagePlane + 10 * TILEMAP_WIDTH + 16 ; $5bb7
	call ApplyTilemapPatchList ; $5bba
	call DrawCharDataConfirmPrompt ; $5bbd
	wram_bank WRAM_SCREEN ; $5bc0
	ld hl, wShadowTilemap ; $5bc6
	ld de, vBGMap0 ; $5bc9
	ld c, $24 ; $5bcc
	call QueueVRAMCopy ; $5bce
	wram_bank WRAM_COURT_PLANES ; $5bd1
	ld hl, wScreenAttrmap ; $5bd7
	ld de, vBGMap0 + VRAM_BANK1 ; $5bda
	ld c, $24 ; $5bdd
	call QueueVRAMCopy ; $5bdf
	ret ; $5be2
InitCharDataScreenVideo:
	call ClearFrameTasks ; $5be3
	call DisableLCDSafely ; $5be6
	xor a ; $5be9
	ldh [hScrollX], a ; $5bea
	ldh [hScrollY], a ; $5bec
	ld [wCameraX], a ; $5bee
	ld [wCameraX + 1], a ; $5bf1
	ld [wCameraY], a ; $5bf4
	ld [wCameraY + 1], a ; $5bf7
	ld a, $90 ; $5bfa
	ldh [rWY], a ; $5bfc
	call ClearSpriteQueue ; $5bfe
	farcall LoadMenuFontGfx ; $5c01
	call InitDrillWorkRam ; $5c04
	call BuildCharDataScreenPages ; $5c07
	ret ; $5c0a
DrawCharDataConfirmPrompt:
	ld hl, CharDataConfirmPromptTilemapPatch ; $5c0b
	ld bc, wCharDataPagePlane + 12 * TILEMAP_WIDTH ; $5c0e
	call ApplyTilemapPatchList ; $5c11
	ret ; $5c14
StartCharDataValuesSyncTask:
	ld a, $01 ; $5c15
	ld hl, CharDataValuesSyncTask ; $5c17
	call RegisterFrameTask ; $5c1a
	ret ; $5c1d
StopCharDataValuesSyncTask:
	ld hl, CharDataValuesSyncTask ; $5c1e
	call UnregisterFrameTask ; $5c21
	ret ; $5c24
DrillDisplayData_1d:
	INCBIN "data/bank_01d/DrillDisplayData_1d.bin" ; $5c25, 9 bytes
StatPageTilemapPatch0:
	INCBIN "data/bank_01d/StatPageTilemapPatch0.bin" ; $5c2e, 5 bytes
CharDataSummaryPageTilemapPatch0:
	INCBIN "data/bank_01d/CharDataSummaryPageTilemapPatch0.bin" ; $5c33, 53 bytes
CharDataSummaryPageTilemapPatch1:
	INCBIN "data/bank_01d/CharDataSummaryPageTilemapPatch1.bin" ; $5c68, 53 bytes
CharDataSummaryPageTilemapPatch2:
	INCBIN "data/bank_01d/CharDataSummaryPageTilemapPatch2.bin" ; $5c9d, 9 bytes
StatPageTilemapPatch1:
	INCBIN "data/bank_01d/StatPageTilemapPatch1.bin" ; $5ca6, 21 bytes
CharDataConfirmScreenTilemapPatch0:
	INCBIN "data/bank_01d/CharDataConfirmScreenTilemapPatch0.bin" ; $5cbb, 21 bytes
StatPageTilemapPatch2:
	INCBIN "data/bank_01d/StatPageTilemapPatch2.bin" ; $5cd0, 29 bytes
CharDataConfirmScreenTilemapPatch1:
	INCBIN "data/bank_01d/CharDataConfirmScreenTilemapPatch1.bin" ; $5ced, 29 bytes
StatPageTilemapPatch3:
	INCBIN "data/bank_01d/StatPageTilemapPatch3.bin" ; $5d0a, 21 bytes
CharDataConfirmScreenTilemapPatch2:
	INCBIN "data/bank_01d/CharDataConfirmScreenTilemapPatch2.bin" ; $5d1f, 21 bytes
StatPageTilemapPatch4:
	INCBIN "data/bank_01d/StatPageTilemapPatch4.bin" ; $5d34, 37 bytes
CharDataConfirmScreenTilemapPatch3:
	INCBIN "data/bank_01d/CharDataConfirmScreenTilemapPatch3.bin" ; $5d59, 37 bytes
CharDataSummaryFieldsTilePlot0:
	INCBIN "data/bank_01d/CharDataSummaryFieldsTilePlot0.bin" ; $5d7e, 19 bytes
CharDataSummaryFieldsTilePlot1:
	INCBIN "data/bank_01d/CharDataSummaryFieldsTilePlot1.bin" ; $5d91, 19 bytes
MainCharStatPageTilemapPatch00:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch00.bin" ; $5da4, 13 bytes
PartnerStatPageTilemapPatch00:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch00.bin" ; $5db1, 13 bytes
CharDataConfirmScreenTilemapPatch4:
	INCBIN "data/bank_01d/CharDataConfirmScreenTilemapPatch4.bin" ; $5dbe, 13 bytes
MainCharStatPageTilemapPatch01:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch01.bin" ; $5dcb, 13 bytes
PartnerStatPageTilemapPatch01:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch01.bin" ; $5dd8, 13 bytes
StatPageTilemapPatch5:
	INCBIN "data/bank_01d/StatPageTilemapPatch5.bin" ; $5de5, 13 bytes
StatPageTilemapPatch6:
	INCBIN "data/bank_01d/StatPageTilemapPatch6.bin" ; $5df2, 33 bytes
StatPageTilemapPatch7:
	INCBIN "data/bank_01d/StatPageTilemapPatch7.bin" ; $5e13, 33 bytes
StatPageTilemapPatch8:
	INCBIN "data/bank_01d/StatPageTilemapPatch8.bin" ; $5e34, 9 bytes
MainCharStatPageTilemapPatch02:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch02.bin" ; $5e3d, 21 bytes
MainCharStatPageTilemapPatch03:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch03.bin" ; $5e52, 33 bytes
MainCharStatPageTilemapPatch04:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch04.bin" ; $5e73, 9 bytes
MainCharStatPageTilemapPatch05:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch05.bin" ; $5e7c, 21 bytes
MainCharStatPageTilemapPatch06:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch06.bin" ; $5e91, 33 bytes
MainCharStatPageTilemapPatch07:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch07.bin" ; $5eb2, 9 bytes
MainCharStatPageTilemapPatch08:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch08.bin" ; $5ebb, 21 bytes
MainCharStatPageTilemapPatch09:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch09.bin" ; $5ed0, 33 bytes
MainCharStatPageTilemapPatch10:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch10.bin" ; $5ef1, 9 bytes
MainCharStatPageTilemapPatch11:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch11.bin" ; $5efa, 21 bytes
MainCharStatPageTilemapPatch12:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch12.bin" ; $5f0f, 33 bytes
MainCharStatPageTilemapPatch13:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch13.bin" ; $5f30, 9 bytes
PartnerStatPageTilemapPatch02:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch02.bin" ; $5f39, 21 bytes
PartnerStatPageTilemapPatch03:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch03.bin" ; $5f4e, 33 bytes
PartnerStatPageTilemapPatch04:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch04.bin" ; $5f6f, 9 bytes
PartnerStatPageTilemapPatch05:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch05.bin" ; $5f78, 21 bytes
PartnerStatPageTilemapPatch06:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch06.bin" ; $5f8d, 33 bytes
PartnerStatPageTilemapPatch07:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch07.bin" ; $5fae, 9 bytes
PartnerStatPageTilemapPatch08:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch08.bin" ; $5fb7, 21 bytes
PartnerStatPageTilemapPatch09:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch09.bin" ; $5fcc, 33 bytes
PartnerStatPageTilemapPatch10:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch10.bin" ; $5fed, 9 bytes
PartnerStatPageTilemapPatch11:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch11.bin" ; $5ff6, 21 bytes
PartnerStatPageTilemapPatch12:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch12.bin" ; $600b, 33 bytes
PartnerStatPageTilemapPatch13:
	INCBIN "data/bank_01d/PartnerStatPageTilemapPatch13.bin" ; $602c, 9 bytes
MainCharStatPageTilemapPatch14:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch14.bin" ; $6035, 33 bytes
MainCharStatPageTilemapPatch15:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch15.bin" ; $6056, 33 bytes
MainCharStatPageTilemapPatch16:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch16.bin" ; $6077, 9 bytes
MainCharStatPageTilemapPatch17:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch17.bin" ; $6080, 33 bytes
MainCharStatPageTilemapPatch18:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch18.bin" ; $60a1, 33 bytes
MainCharStatPageTilemapPatch19:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch19.bin" ; $60c2, 9 bytes
MainCharStatPageTilemapPatch20:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch20.bin" ; $60cb, 33 bytes
MainCharStatPageTilemapPatch21:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch21.bin" ; $60ec, 33 bytes
MainCharStatPageTilemapPatch22:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch22.bin" ; $610d, 9 bytes
MainCharStatPageTilemapPatch23:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch23.bin" ; $6116, 33 bytes
MainCharStatPageTilemapPatch24:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch24.bin" ; $6137, 33 bytes
MainCharStatPageTilemapPatch25:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch25.bin" ; $6158, 5 bytes
MainCharStatPageTilemapPatch26:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch26.bin" ; $615d, 21 bytes
MainCharStatPageTilemapPatch27:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch27.bin" ; $6172, 33 bytes
MainCharStatPageTilemapPatch28:
	INCBIN "data/bank_01d/MainCharStatPageTilemapPatch28.bin" ; $6193, 5 bytes
