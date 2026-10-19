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
	jr c, .partialCell ; $5a06
	jr z, .lastFullCell ; $5a08
	ld b, a ; $5a0a
	ld a, $08 ; $5a0b
	rlca ; $5a0d
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a0e
	ld a, [hl+] ; $5a15
	ld [de], a ; $5a16
	push de ; $5a17
	ld a, $0a ; $5a18
	add_de_a ; $5a1a
	ld a, [hl] ; $5a1f
	ld [de], a ; $5a20
	pop de ; $5a21
	inc de ; $5a22
	jr .loop ; $5a23
.partialCell:
	add $08 ; $5a25
	rlca ; $5a27
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a28
	ld a, [hl+] ; $5a2f
	ld [de], a ; $5a30
	ld a, $0a ; $5a31
	add_de_a ; $5a33
	ld a, [hl] ; $5a38
	ld [de], a ; $5a39
	ret ; $5a3a
.lastFullCell:
	ld a, $08 ; $5a3b
	rlca ; $5a3d
	ld_hl_indexed DrawExpProgressBarTilesTable ; $5a3e
	ld a, [hl+] ; $5a45
	ld [de], a ; $5a46
	ld a, $0a ; $5a47
	add_de_a ; $5a49
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
	ld a, SCREEN_HEIGHT_PX ; $5a7b
	ldh [rWY], a ; $5a7d
	call ClearSpriteQueue ; $5a7f
	call InitDrillWorkRam ; $5a82
	pop af ; $5a85
	call BuildCharDataConfirmScreen ; $5a86
	call EnableLCD ; $5a89
	call AdvanceFrame ; $5a8c
	farcall StartCharDataScreenAnimTask ; $5a8f
	script_fade_in 16 ; $5a92
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
	bit PADB_B, a ; $5ab1
	jr nz, .cancel ; $5ab3
	and PADF_UP | PADF_DOWN ; $5ab5
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
	jr nz, .cancel ; $5acf
	sound SFX_MENU_SELECT ; $5ad1
	jr .beginFadeOut ; $5ad3
.cancel:
	wram_bank WRAM_SCENE ; $5ad5
	ld a, $01 ; $5adb
	ld [wCharDataConfirmState], a ; $5add
	sound SFX_MENU_CANCEL ; $5ae0
.beginFadeOut:
	script_fade_out 16 ; $5ae2
	call WaitFadeEnd ; $5ae7
	farcall StopCharDataScreenAnimTask ; $5aea
	call ClearFrameTasks ; $5aed
	wram_bank WRAM_SCENE ; $5af0
	ld a, [wCharDataConfirmState] ; $5af6
	ret ; $5af9
	twin draw_confirm_selection_cursor, 1d ; $5afa DrawConfirmSelectionCursor_1d
BuildCharDataConfirmScreen:
	push af ; $5b1a
	farcall CharDataScreen_LoadScreen ; $5b1b
	farcall LoadCharDataScreenTilemaps ; $5b1e
	pop af ; $5b21
	ld [wStoryCharacterSlot], a ; $5b22
	push af ; $5b25
	ld hl, wStoryMainName ; $5b26
	ld a, [wStoryCharacterSlot] ; $5b29
	or a ; $5b2c
	jr z, .paletteField ; $5b2d
	ld l, $40 ; $5b2f
.paletteField:
	ld a, l ; $5b31
	add $0c ; $5b32
	ld l, a ; $5b34
	ld a, h ; $5b35
	adc $00 ; $5b36
	ld h, a ; $5b38
	pop af ; $5b39
	ld a, [hl] ; $5b3a
	ld_bg_pals de, 4, 1 ; $5b3b
	farcall LoadIndexedPaletteThunk ; $5b3e
	wram_bank WRAM_STAGING ; $5b41
	push af ; $5b47
	ld hl, wStoryMainName ; $5b48
	ld a, [wStoryCharacterSlot] ; $5b4b
	or a ; $5b4e
	jr z, .charField ; $5b4f
	ld l, $40 ; $5b51
.charField:
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
	ld de, vTiles2 tile $20 + VRAM_BANK1 ; $5b66
	ld c, 3 ; $5b69
	call QueueVRAMCopy ; $5b6b
	ld hl, wDecompBuffer tile 3 ; $5b6e
	ld de, vTiles2 tile $30 + VRAM_BANK1 ; $5b71
	ld c, 3 ; $5b74
	call QueueVRAMCopy ; $5b76
	ld hl, wDecompBuffer tile 6 ; $5b79
	ld de, vTiles2 tile $40 + VRAM_BANK1 ; $5b7c
	ld c, 3 ; $5b7f
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
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $5bcc
	call QueueVRAMCopy ; $5bce
	wram_bank WRAM_COURT_PLANES ; $5bd1
	ld hl, wScreenAttrmap ; $5bd7
	ld de, vBGMap0 + VRAM_BANK1 ; $5bda
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $5bdd
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
	ld a, SCREEN_HEIGHT_PX ; $5bfa
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
	INCLUDE "data/engine/menus/char_data/DrillDisplayData_1d.asm" ; $5c25, 9 bytes (blit_runs)
StatPageTilemapPatch0:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch0.asm" ; $5c2e, 5 bytes (blit_runs)
CharDataSummaryPageTilemapPatch0:
	INCLUDE "data/engine/menus/char_data/CharDataSummaryPageTilemapPatch0.asm" ; $5c33, 53 bytes (blit_runs)
CharDataSummaryPageTilemapPatch1:
	INCLUDE "data/engine/menus/char_data/CharDataSummaryPageTilemapPatch1.asm" ; $5c68, 53 bytes (blit_runs)
CharDataSummaryPageTilemapPatch2:
	INCLUDE "data/engine/menus/char_data/CharDataSummaryPageTilemapPatch2.asm" ; $5c9d, 9 bytes (blit_runs)
StatPageTilemapPatch1:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch1.asm" ; $5ca6, 21 bytes (blit_runs)
CharDataConfirmScreenTilemapPatch0:
	INCLUDE "data/engine/menus/char_data/CharDataConfirmScreenTilemapPatch0.asm" ; $5cbb, 21 bytes (blit_runs)
StatPageTilemapPatch2:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch2.asm" ; $5cd0, 29 bytes (blit_runs)
CharDataConfirmScreenTilemapPatch1:
	INCLUDE "data/engine/menus/char_data/CharDataConfirmScreenTilemapPatch1.asm" ; $5ced, 29 bytes (blit_runs)
StatPageTilemapPatch3:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch3.asm" ; $5d0a, 21 bytes (blit_runs)
CharDataConfirmScreenTilemapPatch2:
	INCLUDE "data/engine/menus/char_data/CharDataConfirmScreenTilemapPatch2.asm" ; $5d1f, 21 bytes (blit_runs)
StatPageTilemapPatch4:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch4.asm" ; $5d34, 37 bytes (blit_runs)
CharDataConfirmScreenTilemapPatch3:
	INCLUDE "data/engine/menus/char_data/CharDataConfirmScreenTilemapPatch3.asm" ; $5d59, 37 bytes (blit_runs)
CharDataSummaryFieldsTilePlot0:
	INCBIN "data/engine/menus/char_data/CharDataSummaryFieldsTilePlot0.bin" ; $5d7e, 19 bytes
CharDataSummaryFieldsTilePlot1:
	INCBIN "data/engine/menus/char_data/CharDataSummaryFieldsTilePlot1.bin" ; $5d91, 19 bytes
MainCharStatPageTilemapPatch00:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch00.asm" ; $5da4, 13 bytes (blit_runs)
PartnerStatPageTilemapPatch00:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch00.asm" ; $5db1, 13 bytes (blit_runs)
CharDataConfirmScreenTilemapPatch4:
	INCLUDE "data/engine/menus/char_data/CharDataConfirmScreenTilemapPatch4.asm" ; $5dbe, 13 bytes (blit_runs)
MainCharStatPageTilemapPatch01:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch01.asm" ; $5dcb, 13 bytes (blit_runs)
PartnerStatPageTilemapPatch01:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch01.asm" ; $5dd8, 13 bytes (blit_runs)
StatPageTilemapPatch5:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch5.asm" ; $5de5, 13 bytes (blit_runs)
StatPageTilemapPatch6:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch6.asm" ; $5df2, 33 bytes (blit_runs)
StatPageTilemapPatch7:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch7.asm" ; $5e13, 33 bytes (blit_runs)
StatPageTilemapPatch8:
	INCLUDE "data/engine/menus/char_data/StatPageTilemapPatch8.asm" ; $5e34, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch02:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch02.asm" ; $5e3d, 21 bytes (blit_runs)
MainCharStatPageTilemapPatch03:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch03.asm" ; $5e52, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch04:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch04.asm" ; $5e73, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch05:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch05.asm" ; $5e7c, 21 bytes (blit_runs)
MainCharStatPageTilemapPatch06:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch06.asm" ; $5e91, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch07:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch07.asm" ; $5eb2, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch08:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch08.asm" ; $5ebb, 21 bytes (blit_runs)
MainCharStatPageTilemapPatch09:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch09.asm" ; $5ed0, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch10:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch10.asm" ; $5ef1, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch11:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch11.asm" ; $5efa, 21 bytes (blit_runs)
MainCharStatPageTilemapPatch12:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch12.asm" ; $5f0f, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch13:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch13.asm" ; $5f30, 9 bytes (blit_runs)
PartnerStatPageTilemapPatch02:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch02.asm" ; $5f39, 21 bytes (blit_runs)
PartnerStatPageTilemapPatch03:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch03.asm" ; $5f4e, 33 bytes (blit_runs)
PartnerStatPageTilemapPatch04:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch04.asm" ; $5f6f, 9 bytes (blit_runs)
PartnerStatPageTilemapPatch05:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch05.asm" ; $5f78, 21 bytes (blit_runs)
PartnerStatPageTilemapPatch06:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch06.asm" ; $5f8d, 33 bytes (blit_runs)
PartnerStatPageTilemapPatch07:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch07.asm" ; $5fae, 9 bytes (blit_runs)
PartnerStatPageTilemapPatch08:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch08.asm" ; $5fb7, 21 bytes (blit_runs)
PartnerStatPageTilemapPatch09:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch09.asm" ; $5fcc, 33 bytes (blit_runs)
PartnerStatPageTilemapPatch10:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch10.asm" ; $5fed, 9 bytes (blit_runs)
PartnerStatPageTilemapPatch11:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch11.asm" ; $5ff6, 21 bytes (blit_runs)
PartnerStatPageTilemapPatch12:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch12.asm" ; $600b, 33 bytes (blit_runs)
PartnerStatPageTilemapPatch13:
	INCLUDE "data/engine/menus/char_data/PartnerStatPageTilemapPatch13.asm" ; $602c, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch14:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch14.asm" ; $6035, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch15:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch15.asm" ; $6056, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch16:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch16.asm" ; $6077, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch17:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch17.asm" ; $6080, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch18:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch18.asm" ; $60a1, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch19:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch19.asm" ; $60c2, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch20:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch20.asm" ; $60cb, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch21:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch21.asm" ; $60ec, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch22:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch22.asm" ; $610d, 9 bytes (blit_runs)
MainCharStatPageTilemapPatch23:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch23.asm" ; $6116, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch24:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch24.asm" ; $6137, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch25:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch25.asm" ; $6158, 5 bytes (blit_runs)
MainCharStatPageTilemapPatch26:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch26.asm" ; $615d, 21 bytes (blit_runs)
MainCharStatPageTilemapPatch27:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch27.asm" ; $6172, 33 bytes (blit_runs)
MainCharStatPageTilemapPatch28:
	INCLUDE "data/engine/menus/char_data/MainCharStatPageTilemapPatch28.asm" ; $6193, 5 bytes (blit_runs)
