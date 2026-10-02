Unused_05_IsCursorOnAdjustRow:
	push bc ; $4c76
	ld a, [wMenuAdjustRowMask] ; $4c77
	bit 7, a ; $4c7a
	jr z, .restore ; $4c7c
	and $7f ; $4c7e
	ld b, a ; $4c80
	ld a, [wMenuCursorRow] ; $4c81
	inc a ; $4c84
.loop:
	rrc b ; $4c85
	dec a ; $4c87
	jr nz, .loop ; $4c88
	rlc b ; $4c8a
	bit 0, b ; $4c8c
	jr z, .restore ; $4c8e
	ldh a, [hInputPressed] ; $4c90
	and PADF_UP | PADF_DOWN ; $4c92
	jr nz, .restore ; $4c94
	pop bc ; $4c96
	ld a, $01 ; $4c97
	ret ; $4c99
.restore:
	pop bc ; $4c9a
	xor a ; $4c9b
	ret ; $4c9c
Unused_05_AnimateMenuScrollArrowsTask:
	wram_bank WRAM_TEXT ; $4c9d
	ld a, [wMenuAdjustRowMask] ; $4ca3
	bit 7, a ; $4ca6
	jr z, .checkFlag ; $4ca8
	and $7f ; $4caa
	ld b, a ; $4cac
	ld a, [wMenuCursorRow] ; $4cad
	inc a ; $4cb0
.loop:
	rrc b ; $4cb1
	dec a ; $4cb3
	jr nz, .loop ; $4cb4
	rlc b ; $4cb6
	bit 0, b ; $4cb8
	jr z, .checkFlag ; $4cba
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4cbc
	jp nz, .step5 ; $4cbf
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4cc2
	jp nz, .step5 ; $4cc5
.checkFlag:
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4cc8
	jr nz, .isPauseOptionsMenuOpen ; $4ccb
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4ccd
	jp nz, .isMinigamePauseMenuOpen ; $4cd0
	jp .step3 ; $4cd3
.isPauseOptionsMenuOpen:
	ld l, $20 ; $4cd6
	ld_cell de, $0b, $01 ; $4cd8
	farcall Unused_1a_QueueWindowTileWrite ; $4cdb
	ld l, $20 ; $4cde
	ld_cell de, $0b, $03 ; $4ce0
	farcall Unused_1a_QueueWindowTileWrite ; $4ce3
	jr .step3 ; $4ce6
.isMinigamePauseMenuOpen:
	ld l, $20 ; $4ce8
	ld_cell de, $0d, $05 ; $4cea
	farcall Unused_1a_QueueWindowTileWrite ; $4ced
	ld l, $20 ; $4cf0
	ld_cell de, $0d, $07 ; $4cf2
	farcall Unused_1a_QueueWindowTileWrite ; $4cf5
	jr .step3 ; $4cf8
.step3:
	ld hl, wTextArrowBlinkCounter ; $4cfa
	ld a, [hl+] ; $4cfd
	and $10 ; $4cfe
	or a ; $4d00
	jr z, .zero ; $4d01
	ld a, $20 ; $4d03
	jr .read ; $4d05
.zero:
	ld a, $0d ; $4d07
.read:
	ld e, [hl] ; $4d09
	inc hl ; $4d0a
	ld d, [hl] ; $4d0b
	ld h, d ; $4d0c
	ld l, e ; $4d0d
	ld de, $3000 ; $4d0e
	add hl, de ; $4d11
	ld de, vBGMap0 ; $4d12
	add hl, de ; $4d15
	ld d, h ; $4d16
	ld e, l ; $4d17
	ld l, a ; $4d18
	ld h, $80 ; $4d19
	push de ; $4d1b
	call QueueBGTileWrite ; $4d1c
	pop de ; $4d1f
	ld a, [wTextArrowBlinkCounter] ; $4d20
	inc a ; $4d23
	ld [wTextArrowBlinkCounter], a ; $4d24
	ld a, [wTextArrowEraseAddr + 1] ; $4d27
	or a ; $4d2a
	jr z, .done ; $4d2b
	ld d, a ; $4d2d
	ld a, [wTextArrowEraseAddr] ; $4d2e
	ld e, a ; $4d31
	ld a, $20 ; $4d32
	ld l, a ; $4d34
	ld h, $80 ; $4d35
	call QueueBGTileWrite ; $4d37
	xor a ; $4d3a
	ld [wTextArrowEraseAddr + 1], a ; $4d3b
.done:
	ret ; $4d3e
.step5:
	ld a, [wTextArrowEraseAddr + 1] ; $4d3f
	or a ; $4d42
	jr z, .zero2 ; $4d43
	ld d, a ; $4d45
	ld a, [wTextArrowEraseAddr] ; $4d46
	ld e, a ; $4d49
	ld a, $20 ; $4d4a
	ld l, a ; $4d4c
	ld h, $80 ; $4d4d
	call QueueBGTileWrite ; $4d4f
	xor a ; $4d52
	ld [wTextArrowEraseAddr + 1], a ; $4d53
.zero2:
	wram_bank WRAM_TEXT ; $4d56
	ld hl, wTextArrowBlinkCounter ; $4d5c
	inc [hl] ; $4d5f
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4d60
	jr nz, .isPauseOptionsMenuOpen2 ; $4d63
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4d65
	jr nz, .isMinigamePauseMenuOpen2 ; $4d68
	jp .doneB ; $4d6a
.isPauseOptionsMenuOpen2:
	ld l, $20 ; $4d6d
	ld_cell de, $0b, $01 ; $4d6f
	farcall Unused_1a_QueueWindowTileWrite ; $4d72
	ld l, $20 ; $4d75
	ld_cell de, $0b, $03 ; $4d77
	farcall Unused_1a_QueueWindowTileWrite ; $4d7a
	ld a, [wMenuCursorRow] ; $4d7d
	and a ; $4d80
	jr nz, .getMenuCursorBlinkPhase ; $4d81
	call Unused_05_GetMenuCursorBlinkPhase ; $4d83
	and a ; $4d86
	ld de, $0101 ; $4d87
	jp z, .queueWindowTileWrite ; $4d8a
	ld l, $0c ; $4d8d
	ld_cell de, $01, $01 ; $4d8f
	farcall Unused_1a_QueueWindowTileWrite ; $4d92
	ld l, $0d ; $4d95
	ld_cell de, $0b, $01 ; $4d97
	farcall Unused_1a_QueueWindowTileWrite ; $4d9a
	jp .doneB ; $4d9d
.getMenuCursorBlinkPhase:
	call Unused_05_GetMenuCursorBlinkPhase ; $4da0
	and a ; $4da3
	ld de, $0103 ; $4da4
	jp z, .queueWindowTileWrite ; $4da7
	ld l, $0c ; $4daa
	ld_cell de, $01, $03 ; $4dac
	farcall Unused_1a_QueueWindowTileWrite ; $4daf
	ld l, $0d ; $4db2
	ld_cell de, $0b, $03 ; $4db4
	farcall Unused_1a_QueueWindowTileWrite ; $4db7
	jp .doneB ; $4dba
.isMinigamePauseMenuOpen2:
	ld l, $20 ; $4dbd
	ld_cell de, $0d, $05 ; $4dbf
	farcall Unused_1a_QueueWindowTileWrite ; $4dc2
	ld l, $20 ; $4dc5
	ld_cell de, $0d, $07 ; $4dc7
	farcall Unused_1a_QueueWindowTileWrite ; $4dca
	ld a, [wMenuCursorRow] ; $4dcd
	cp $03 ; $4dd0
	jr z, .getMenuCursorBlinkPhase2 ; $4dd2
	call Unused_05_GetMenuCursorBlinkPhase ; $4dd4
	or a ; $4dd7
	ld de, $0105 ; $4dd8
	jr z, .queueWindowTileWrite ; $4ddb
	ld l, $0c ; $4ddd
	ld_cell de, $01, $05 ; $4ddf
	farcall Unused_1a_QueueWindowTileWrite ; $4de2
	ld l, $0d ; $4de5
	ld_cell de, $0d, $05 ; $4de7
	farcall Unused_1a_QueueWindowTileWrite ; $4dea
	jr .doneB ; $4ded
.getMenuCursorBlinkPhase2:
	call Unused_05_GetMenuCursorBlinkPhase ; $4def
	or a ; $4df2
	ld de, $0107 ; $4df3
	jr z, .queueWindowTileWrite ; $4df6
	ld l, $0c ; $4df8
	ld_cell de, $01, $07 ; $4dfa
	farcall Unused_1a_QueueWindowTileWrite ; $4dfd
	ld l, $0d ; $4e00
	ld_cell de, $0d, $07 ; $4e02
	farcall Unused_1a_QueueWindowTileWrite ; $4e05
	jr .doneB ; $4e08
.queueWindowTileWrite:
	ld l, $20 ; $4e0a
	farcall Unused_1a_QueueWindowTileWrite ; $4e0c
.doneB:
	ret ; $4e0f
Unused_05_GetMenuCursorBlinkPhase:
	wram_bank WRAM_TEXT ; $4e10
	ld a, [wTextArrowBlinkCounter] ; $4e16
	and $10 ; $4e19
	or a ; $4e1b
	jr z, .visible ; $4e1c
	xor a ; $4e1e
	ret ; $4e1f
.visible:
	ld a, $01 ; $4e20
	ret ; $4e22
RenderTextString:
	push bc ; $4e23
	ld a, [wTextResumePtr + 1] ; $4e24
	or a ; $4e27
	jr z, .zero ; $4e28
	ld bc, $3a00 ; $4e2a
	add hl, bc ; $4e2d
	ld b, h ; $4e2e
	ld c, l ; $4e2f
	ld hl, wTextResumePtr ; $4e30
	ld a, [hl+] ; $4e33
	ld h, [hl] ; $4e34
	ld l, a ; $4e35
	add hl, bc ; $4e36
	xor a ; $4e37
	ld [wTextResumePtr + 1], a ; $4e38
.zero:
	ld a, [wGlyphWindowId] ; $4e3b
	or a ; $4e3e
	jr nz, .initGlyphStreamForWindow ; $4e3f
	xor a ; $4e41
	ld [wGlyphRowStartCol], a ; $4e42
	ld [wGlyphFlushedCol], a ; $4e45
.initGlyphStreamForWindow:
	call InitGlyphStreamForWindow ; $4e48
	call RedrawActiveTextWindow ; $4e4b
	ld a, d ; $4e4e
	and $1f ; $4e4f
	ld [wTextCursorColumn], a ; $4e51
	ld a, e ; $4e54
	and $1f ; $4e55
	ld [wTextCursorRow], a ; $4e57
	call GetTilemapCellAddress ; $4e5a
TextInterpreterLoop:
	ld a, [wTextPageBreakRequest] ; $4e5d
	or a ; $4e60
	jr z, .zero ; $4e61
	ld a, l ; $4e63
	ld [wTextResumePtr], a ; $4e64
	ld a, h ; $4e67
	ld [wTextResumePtr + 1], a ; $4e68
	pop bc ; $4e6b
	ret ; $4e6c
.zero:
	ld a, l ; $4e6d
	ld [wTextStreamPtr], a ; $4e6e
	ld a, h ; $4e71
	ld [wTextStreamPtr + 1], a ; $4e72
	ld a, [hl] ; $4e75
	inc hl ; $4e76
	ld b, a ; $4e77
	or a ; $4e78
	jr nz, .compare ; $4e79
	test_flag FLAG_TEXT_RENDER_ACTIVE ; $4e7b
	jr nz, .restore ; $4e7e
	call FlushGlyphRow ; $4e80
.restore:
	pop bc ; $4e83
	ret ; $4e84
.compare:
	cp $de ; $4e85
	jr z, .eqde ; $4e87
	cp $df ; $4e89
	jr z, .eqdf ; $4e8b
	cp $0e ; $4e8d
	jr z, .eq0e ; $4e8f
	cp $20 ; $4e91
	jr nc, .ge20 ; $4e93
	jr .dispatchControlCode ; $4e95
.eqde:
	ld a, $1e ; $4e97
	jr .dispatchControlCode ; $4e99
.eqdf:
	ld a, $1f ; $4e9b
	jr .dispatchControlCode ; $4e9d
.eq0e:
	push af ; $4e9f
	ld a, [hl+] ; $4ea0
	ld [wTextCharNameArg], a ; $4ea1
	pop af ; $4ea4
.dispatchControlCode:
	call DispatchControlCode ; $4ea5
	call RedrawActiveTextWindow ; $4ea8
	jr TextInterpreterLoop ; $4eab
.ge20:
	ld a, b ; $4ead
	call WrapTextCellPointer ; $4eae
	call DrawStreamGlyph ; $4eb1
	call UploadLastGlyphTiles ; $4eb4
	call DelayTextCharacter ; $4eb7
	inc de ; $4eba
	ld a, e ; $4ebb
	and $1f ; $4ebc
	jp nz, TextInterpreterLoop ; $4ebe
	push hl ; $4ec1
	push de ; $4ec2
	ld h, d ; $4ec3
	ld l, e ; $4ec4
	ld de, $ffe0 ; $4ec5
	add hl, de ; $4ec8
	ld d, h ; $4ec9
	ld e, l ; $4eca
	pop de ; $4ecb
	pop hl ; $4ecc
	jp TextInterpreterLoop ; $4ecd
TextCmdNewline:
	call DrawStreamGlyph ; $4ed0
	push af ; $4ed3
	ld a, [wTextCursorRow] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	and $1f ; $4ed9
	ld [wTextCursorRow], a ; $4edb
	ld e, a ; $4ede
	ld a, [wTextCursorColumn] ; $4edf
	ld d, a ; $4ee2
	call GetTilemapCellAddress ; $4ee3
	pop af ; $4ee6
	ret ; $4ee7
TextCmdNop:
	ret ; $4ee8
TextCmdNextGlyphStreamRow:
	push af ; $4ee9
	push bc ; $4eea
	push hl ; $4eeb
	ld hl, wGlyphTileWritePtr ; $4eec
	ld a, [hl+] ; $4eef
	ld h, [hl] ; $4ef0
	ld l, a ; $4ef1
	ld a, $40 ; $4ef2
	add l ; $4ef4
	ld l, a ; $4ef5
	jr nc, .gotPtr ; $4ef6
	inc h ; $4ef8
.gotPtr:
	ld b, h ; $4ef9
	ld c, l ; $4efa
	ld hl, wGlyphTileWritePtr ; $4efb
	ld a, c ; $4efe
	ld [hl+], a ; $4eff
	ld [hl], b ; $4f00
	call StartGlyphStreamRow ; $4f01
	push_wram_bank WRAM_TEXT ; $4f04
	ld hl, wGlyphVramDest ; $4f0d
	ld a, [hl+] ; $4f10
	ld h, [hl] ; $4f11
	ld l, a ; $4f12
	ld a, [wTextRowIndent] ; $4f13
	cpl ; $4f16
	inc a ; $4f17
	sla a ; $4f18
	add l ; $4f1a
	ld l, a ; $4f1b
	jr nc, .storeGlyphVramDest ; $4f1c
	inc h ; $4f1e
.storeGlyphVramDest:
	ld a, l ; $4f1f
	ld [wGlyphVramDest], a ; $4f20
	ld a, h ; $4f23
	ld [wGlyphVramDest + 1], a ; $4f24
	ld d, h ; $4f27
	ld e, l ; $4f28
	pop_wram_bank ; $4f29
	pop hl ; $4f2e
	pop bc ; $4f2f
	pop af ; $4f30
	ret ; $4f31
TextCmdDelay30:
	push af ; $4f32
	ld a, [wTextRedrawGuard] ; $4f33
	or a ; $4f36
	jr nz, .nonZero ; $4f37
	ld a, $01 ; $4f39
	ld [wTextRedrawGuard], a ; $4f3b
	call RedrawActiveTextWindow ; $4f3e
	xor a ; $4f41
	ld [wTextRedrawGuard], a ; $4f42
.nonZero:
	ld a, $1e ; $4f45
.loop:
	call AdvanceFrame ; $4f47
	dec a ; $4f4a
	jr nz, .loop ; $4f4b
	pop af ; $4f4d
	ret ; $4f4e
TextCmdDelay15Skippable:
	push af ; $4f4f
	push bc ; $4f50
	ld a, [wTextRedrawGuard] ; $4f51
	or a ; $4f54
	jr nz, .nonZero ; $4f55
	ld a, $01 ; $4f57
	ld [wTextRedrawGuard], a ; $4f59
	call RedrawActiveTextWindow ; $4f5c
	xor a ; $4f5f
	ld [wTextRedrawGuard], a ; $4f60
.nonZero:
	ld b, $0f ; $4f63
.loop:
	call AdvanceFrame ; $4f65
	ldh a, [hInputPressed] ; $4f68
	and $f3 ; $4f6a
	jr nz, .restore ; $4f6c
	dec b ; $4f6e
	jr nz, .loop ; $4f6f
.restore:
	pop bc ; $4f71
	pop af ; $4f72
	ret ; $4f73
TextCmdWaitButtonPage:
	push af ; $4f74
	push de ; $4f75
	ld a, $01 ; $4f76
	call WrapTextCellPointer ; $4f78
	call GetTextContinueArrowCell ; $4f7b
	call GetTilemapCellAddress ; $4f7e
	ld [de], a ; $4f81
	call RedrawActiveTextWindow ; $4f82
	xor a ; $4f85
	ld hl, wTextArrowBlinkCounter ; $4f86
	ld [hl+], a ; $4f89
	ld [hl], e ; $4f8a
	inc hl ; $4f8b
	ld [hl], d ; $4f8c
	push af ; $4f8d
	push bc ; $4f8e
	push de ; $4f8f
	push hl ; $4f90
	ld a, $01 ; $4f91
	ld hl, TextContinueArrowBlinkTask ; $4f93
	call RegisterFrameTask ; $4f96
	call WaitTextAdvanceInput ; $4f99
	ld a, $10 ; $4f9c
	ld [wTextArrowBlinkCounter], a ; $4f9e
	call AdvanceFrame ; $4fa1
	ld hl, TextContinueArrowBlinkTask ; $4fa4
	call UnregisterFrameTask ; $4fa7
	set_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4faa
	call AdvanceFrame ; $4fad
	clear_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4fb0
	pop hl ; $4fb3
	pop de ; $4fb4
	pop bc ; $4fb5
	pop af ; $4fb6
	ld a, $01 ; $4fb7
	ld [wTextPageBreakRequest], a ; $4fb9
	pop de ; $4fbc
	pop af ; $4fbd
	ret ; $4fbe
