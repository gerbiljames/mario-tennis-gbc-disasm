	ds ALIGN[4]
PaletteEditorCursorTiles_05:
	INCBIN "data/bank_005/PaletteEditorCursorTiles_05.bin" ; $6890, 192 bytes
GetSelectedBGPaletteColorPtr:
	ld hl, wDebugPaletteIndex ; $6950
	ld a, [hl] ; $6953
	add a ; $6954
	add a ; $6955
	ld hl, wDebugPaletteColorIndex ; $6956
	add [hl] ; $6959
	add a ; $695a
	ld hl, wBGPalettes ; $695b
	add l ; $695e
	ld l, a ; $695f
	jr nc, .done ; $6960
	inc h ; $6962
.done:
	ret ; $6963
DebugDrawColorComponents:
	push af ; $6964
	push bc ; $6965
	push de ; $6966
	push hl ; $6967
	call GetSelectedBGPaletteColorPtr ; $6968
	ld a, [hl+] ; $696b
	ld b, [hl] ; $696c
	ld c, a ; $696d
	call SplitColorComponents ; $696e
	push de ; $6971
	ld h, $00 ; $6972
	ld l, a ; $6974
	ld de, wDebugMenuWindowId ; $6975
	ld a, $03 ; $6978
	call FormatDecimalNumber ; $697a
	ld h, $00 ; $697d
	ld l, b ; $697f
	ld de, wDebugWarpCursorRow ; $6980
	ld a, $03 ; $6983
	call FormatDecimalNumber ; $6985
	ld h, $00 ; $6988
	ld l, c ; $698a
	ld de, wDebugColorBlueDigits ; $698b
	ld a, $03 ; $698e
	call FormatDecimalNumber ; $6990
	pop de ; $6993
	ld a, e ; $6994
	add a ; $6995
	add e ; $6996
	add $00 ; $6997
	ld l, a ; $6999
	adc $c7 ; $699a
	sub l ; $699c
	ld h, a ; $699d
	ld [hl], $0d ; $699e
	xor a ; $69a0
	ld [wDebugColorDigitsEnd], a ; $69a1
	ld hl, wDebugMenuWindowId ; $69a4
	ld_cell de, $01, $02 ; $69a7
	ld a, [wDebugColorEditorWindowId] ; $69aa
	call WriteStringToWindow ; $69ad
	ld a, [wDebugColorEditorWindowId] ; $69b0
	call RedrawWindowRows ; $69b3
	pop hl ; $69b6
	pop de ; $69b7
	pop bc ; $69b8
	pop af ; $69b9
	ret ; $69ba
ColorEditorHeader_05:
	; $69bb, 10 bytes (ascii)
	db "--R--G--B", $00
RunDebugColorEditor:
	ld_cell de, $07, $00 ; $69c5
	ld_size bc, $0b, $04 ; $69c8
	farcall CreateWindow ; $69cb
	ld [wDebugColorEditorWindowId], a ; $69ce
	call DrawTextWindowFrame ; $69d1
	call RedrawWindowRows ; $69d4
	ld hl, ColorEditorHeader_05 ; $69d7
	ld_cell de, $01, $01 ; $69da
	ld a, [wDebugColorEditorWindowId] ; $69dd
	call WriteStringToWindow ; $69e0
	ld e, $00 ; $69e3
	call DebugDrawColorComponents ; $69e5
.loop:
	ldh a, [hInputRisingEdge] ; $69e8
	and PADF_A | PADF_B ; $69ea
	jr nz, .closeWindow ; $69ec
	ldh a, [hPlayerInputFlags] ; $69ee
	bit PADB_LEFT, a ; $69f0
	jr z, .step ; $69f2
	dec e ; $69f4
	jr .step4 ; $69f5
.step:
	bit 4, a ; $69f7
	jr z, .bit4Clear ; $69f9
	inc e ; $69fb
	jr .step4 ; $69fc
.bit4Clear:
	bit 6, a ; $69fe
	jr z, .bit6Clear ; $6a00
	ld d, $01 ; $6a02
	jr .getSelectedBGPaletteColorPtr ; $6a04
.bit6Clear:
	bit 7, a ; $6a06
	jr z, .advanceFrame ; $6a08
	ld d, $ff ; $6a0a
	jr .getSelectedBGPaletteColorPtr ; $6a0c
.advanceFrame:
	call AdvanceFrame ; $6a0e
	jr .loop ; $6a11
.step4:
	ld a, e ; $6a13
	cp $ff ; $6a14
	jr nz, .compare ; $6a16
	ld e, $02 ; $6a18
.compare:
	cp $03 ; $6a1a
	jr nz, .debugDrawColorComponents ; $6a1c
	ld e, $00 ; $6a1e
.debugDrawColorComponents:
	call DebugDrawColorComponents ; $6a20
	jr .loop ; $6a23
.getSelectedBGPaletteColorPtr:
	call GetSelectedBGPaletteColorPtr ; $6a25
	ld a, [hl+] ; $6a28
	ld c, a ; $6a29
	ld a, [hl-] ; $6a2a
	ld b, a ; $6a2b
	ld a, e ; $6a2c
	and $03 ; $6a2d
	jr nz, .maskSet ; $6a2f
	call AdjustColorRed ; $6a31
.maskSet:
	dec a ; $6a34
	jr nz, .countLeft ; $6a35
	call AdjustColorGreen ; $6a37
.countLeft:
	dec a ; $6a3a
	jr nz, .countLeft2 ; $6a3b
	call AdjustColorBlue ; $6a3d
.countLeft2:
	ld a, c ; $6a40
	ld [hl+], a ; $6a41
	ld a, b ; $6a42
	ld [hl-], a ; $6a43
	ld a, $03 ; $6a44
	ldh [hPaletteDirtyFlags], a ; $6a46
	call DebugDrawColorComponents ; $6a48
	jr .loop ; $6a4b
.closeWindow:
	ld a, [wDebugColorEditorWindowId] ; $6a4d
	call CloseWindow ; $6a50
	ret ; $6a53
RunDebugPaletteViewer:
	wram_bank WRAM_TEXT ; $6a54
	ld_cell de, $00, $00 ; $6a5a
	ld_size bc, $07, $12 ; $6a5d
	ld a, $00 ; $6a60
	farcall CreateWindowWithAttr ; $6a62
	ld [wDebugPaletteViewerWindowId], a ; $6a65
	ld a, [wDebugPaletteViewerWindowId] ; $6a68
	call DrawTextWindowFrame ; $6a6b
	ld h, $10 ; $6a6e
	ld_cell de, $01, $01 ; $6a70
	ld bc, $0030 ; $6a73
.loop:
	call WriteWindowCellTileAttr ; $6a76
	inc e ; $6a79
	inc c ; $6a7a
	res 3, c ; $6a7b
	dec h ; $6a7d
	jr nz, .loop ; $6a7e
	ld h, $08 ; $6a80
	ld e, $01 ; $6a82
	ld b, $00 ; $6a84
.loopB:
	ld d, $02 ; $6a86
	ld c, $a0 ; $6a88
	call WriteWindowCellTileAttr ; $6a8a
	inc d ; $6a8d
	ld c, $a1 ; $6a8e
	call WriteWindowCellTileAttr ; $6a90
	inc d ; $6a93
	ld c, $a2 ; $6a94
	call WriteWindowCellTileAttr ; $6a96
	inc d ; $6a99
	ld c, $a3 ; $6a9a
	call WriteWindowCellTileAttr ; $6a9c
	inc e ; $6a9f
	inc b ; $6aa0
	dec h ; $6aa1
	jr nz, .loopB ; $6aa2
	ld a, [wDebugPaletteViewerWindowId] ; $6aa4
	call RedrawWindowRows ; $6aa7
	ld a, $0f ; $6aaa
	ld hl, DrawPaletteCursorSprites ; $6aac
	call RegisterFrameTask ; $6aaf
.loop2:
	ldh a, [hInputRisingEdge] ; $6ab2
	bit PADB_B, a ; $6ab4
	jr nz, .closeWindow ; $6ab6
	bit 0, a ; $6ab8
	jr z, .bit0Clear ; $6aba
	call RunDebugColorEditor ; $6abc
.bit0Clear:
	ld a, [wDebugPaletteColorIndex] ; $6abf
	ld d, a ; $6ac2
	ld a, [wDebugPaletteIndex] ; $6ac3
	ld e, a ; $6ac6
	ldh a, [hInputPressed] ; $6ac7
	bit PADB_LEFT, a ; $6ac9
	jr z, .step2 ; $6acb
	dec d ; $6acd
	jr .step5 ; $6ace
.step2:
	bit 4, a ; $6ad0
	jr z, .bit4Clear ; $6ad2
	inc d ; $6ad4
	jr .step5 ; $6ad5
.bit4Clear:
	bit 6, a ; $6ad7
	jr z, .bit6Clear ; $6ad9
	dec e ; $6adb
	jr .step5 ; $6adc
.bit6Clear:
	bit 7, a ; $6ade
	jr z, .step5 ; $6ae0
	inc e ; $6ae2
	jr .step5 ; $6ae3
.step5:
	ld a, d ; $6ae5
	and $03 ; $6ae6
	ld [wDebugPaletteColorIndex], a ; $6ae8
	ld a, e ; $6aeb
	and $0f ; $6aec
	ld [wDebugPaletteIndex], a ; $6aee
	call AdvanceFrame ; $6af1
	jr .loop2 ; $6af4
.closeWindow:
	ld a, [wDebugPaletteViewerWindowId] ; $6af6
	call CloseWindow ; $6af9
	ld hl, DrawPaletteCursorSprites ; $6afc
	call UnregisterFrameTask ; $6aff
	ret ; $6b02
DrawPaletteCursorSprites:
	ld a, [wCameraX] ; $6b03
	rlca ; $6b06
	rlca ; $6b07
	rlca ; $6b08
	add $04 ; $6b09
	and $07 ; $6b0b
	ld h, a ; $6b0d
	ld a, [wCameraY] ; $6b0e
	rlca ; $6b11
	rlca ; $6b12
	rlca ; $6b13
	add $04 ; $6b14
	and $07 ; $6b16
	ld l, a ; $6b18
	ld a, [wDebugPaletteColorIndex] ; $6b19
	add a ; $6b1c
	add a ; $6b1d
	add a ; $6b1e
	add $18 ; $6b1f
	sub h ; $6b21
	ld d, a ; $6b22
	ld a, [wDebugPaletteIndex] ; $6b23
	add a ; $6b26
	add a ; $6b27
	add a ; $6b28
	add $18 ; $6b29
	sub l ; $6b2b
	ld e, a ; $6b2c
	sprite_attr_tile 1, $60 ; $6b2d
	push hl ; $6b31
	call QueueSprite16 ; $6b32
	pop hl ; $6b35
	ld a, $50 ; $6b36
	sub l ; $6b38
	ld e, a ; $6b39
	ld b, 0 ; $6b3a
	ld a, $08 ; $6b3c
.loop:
	push af ; $6b3e
	push hl ; $6b3f
	ld a, $20 ; $6b40
	sub h ; $6b42
	ld d, a ; $6b43
	ld c, $66 ; $6b44
	push de ; $6b46
	call QueueSprite ; $6b47
	pop de ; $6b4a
	ld a, d ; $6b4b
	add $08 ; $6b4c
	ld d, a ; $6b4e
	inc c ; $6b4f
	inc c ; $6b50
	push de ; $6b51
	call QueueSprite ; $6b52
	pop de ; $6b55
	ld a, d ; $6b56
	add $08 ; $6b57
	ld d, a ; $6b59
	inc c ; $6b5a
	inc c ; $6b5b
	push de ; $6b5c
	call QueueSprite ; $6b5d
	pop de ; $6b60
	ld a, e ; $6b61
	add $08 ; $6b62
	ld e, a ; $6b64
	inc b ; $6b65
	pop hl ; $6b66
	pop af ; $6b67
	dec a ; $6b68
	jr nz, .loop ; $6b69
	ret ; $6b6b
StartDebugPaletteEditor:
	ld hl, PaletteEditorCursorTiles_05 ; $6b6c
	ld de, vTiles0 + $60 * TILE_SIZE ; $6b6f
	ld c, (GetSelectedBGPaletteColorPtr - PaletteEditorCursorTiles_05) / 16 ; $6b72
	call QueueVRAMCopy ; $6b74
	xor a ; $6b77
	ld [wDebugPaletteColorIndex], a ; $6b78
	ld [wDebugPaletteIndex], a ; $6b7b
	call RunDebugPaletteViewer ; $6b7e
	ret ; $6b81
Unused_05_WriteStringToTilemap:
	push af ; $6b82
.loop:
	ld a, [hl] ; $6b83
	cp $00 ; $6b84
	jr z, .restore ; $6b86
	ld [de], a ; $6b88
	inc hl ; $6b89
	ld a, [hl] ; $6b8a
	cp $de ; $6b8b
	jr z, .eqde ; $6b8d
	cp $df ; $6b8f
	jr nz, .nedf ; $6b91
.eqde:
	push hl ; $6b93
	push bc ; $6b94
	ld h, d ; $6b95
	ld l, e ; $6b96
	ld bc, $ffe0 ; $6b97
	add hl, bc ; $6b9a
	ld b, a ; $6b9b
	ld a, [hl] ; $6b9c
	cp $03 ; $6b9d
	ld a, b ; $6b9f
	jr nz, .store ; $6ba0
	sub $d0 ; $6ba2
.store:
	ld [hl], a ; $6ba4
	pop bc ; $6ba5
	pop hl ; $6ba6
	inc hl ; $6ba7
.nedf:
	inc de ; $6ba8
	ld a, e ; $6ba9
	and $1f ; $6baa
	jr nz, .loop ; $6bac
	push hl ; $6bae
	ld h, d ; $6baf
	ld l, e ; $6bb0
	add hl, de ; $6bb1
	ld d, h ; $6bb2
	ld e, l ; $6bb3
	pop hl ; $6bb4
	jr .loop ; $6bb5
.restore:
	pop af ; $6bb7
	ret ; $6bb8
Unused_05_WriteStringToTilemapAlt:
	push af ; $6bb9
.loop:
	ld a, [hl] ; $6bba
	cp $00 ; $6bbb
	jr z, .restore ; $6bbd
	ld [de], a ; $6bbf
	inc hl ; $6bc0
	ld a, [hl] ; $6bc1
	cp $de ; $6bc2
	jr z, .eqde ; $6bc4
	cp $df ; $6bc6
	jr nz, .nedf ; $6bc8
.eqde:
	push hl ; $6bca
	push bc ; $6bcb
	ld h, d ; $6bcc
	ld l, e ; $6bcd
	ld bc, $ffe0 ; $6bce
	add hl, bc ; $6bd1
	ld b, a ; $6bd2
	ld a, [hl] ; $6bd3
	cp $0e ; $6bd4
	ld a, b ; $6bd6
	jr nz, .store ; $6bd7
	sub $82 ; $6bd9
.store:
	ld [hl], a ; $6bdb
	pop bc ; $6bdc
	pop hl ; $6bdd
	inc hl ; $6bde
.nedf:
	inc de ; $6bdf
	ld a, e ; $6be0
	and $1f ; $6be1
	jr nz, .loop ; $6be3
	push hl ; $6be5
	ld h, d ; $6be6
	ld l, e ; $6be7
	add hl, de ; $6be8
	ld d, h ; $6be9
	ld e, l ; $6bea
	pop hl ; $6beb
	jr .loop ; $6bec
.restore:
	pop af ; $6bee
	ret ; $6bef
Unused_05_WriteStringToTilemapStreamed:
	push af ; $6bf0
	ld a, d ; $6bf1
	ld [$dc05], a ; $6bf2
	ld a, e ; $6bf5
	ld [$dc06], a ; $6bf6
	xor a ; $6bf9
	ld [$dc09], a ; $6bfa
.loop:
	ld a, [hl] ; $6bfd
	cp $00 ; $6bfe
	jr z, .restore ; $6c00
	cp $01 ; $6c02
	jr nz, .ne01 ; $6c04
	ld c, a ; $6c06
	ld a, [$dc05] ; $6c07
	ld d, a ; $6c0a
	ld a, [$dc06] ; $6c0b
	ld e, a ; $6c0e
	push hl ; $6c0f
	ld h, d ; $6c10
	ld l, e ; $6c11
	ld d, $00 ; $6c12
	ld e, $40 ; $6c14
	add hl, de ; $6c16
	ld d, h ; $6c17
	ld e, l ; $6c18
	ld a, d ; $6c19
	ld [$dc05], a ; $6c1a
	ld a, e ; $6c1d
	ld [$dc06], a ; $6c1e
	pop hl ; $6c21
	ld a, c ; $6c22
	inc hl ; $6c23
	ld a, [hl] ; $6c24
.ne01:
	ld c, $00 ; $6c25
	cp $02 ; $6c27
	jr nz, .ne02 ; $6c29
	ld a, $01 ; $6c2b
	ld [$dc09], a ; $6c2d
	inc hl ; $6c30
	ld a, h ; $6c31
	ld [$dc07], a ; $6c32
	ld a, l ; $6c35
	ld [$dc08], a ; $6c36
	jr .restore ; $6c39
.ne02:
	ld c, $01 ; $6c3b
	cp $03 ; $6c3d
	jr nz, .store ; $6c3f
	ld a, $01 ; $6c41
	ld [$dc0a], a ; $6c43
	jr .restore ; $6c46
.store:
	ld [de], a ; $6c48
	inc hl ; $6c49
	ld a, [hl] ; $6c4a
	cp $de ; $6c4b
	jr z, .eqde ; $6c4d
	cp $df ; $6c4f
	jr nz, .nedf ; $6c51
.eqde:
	push hl ; $6c53
	push bc ; $6c54
	ld h, d ; $6c55
	ld l, e ; $6c56
	ld bc, $ffe0 ; $6c57
	add hl, bc ; $6c5a
	ld b, a ; $6c5b
	ld a, [hl] ; $6c5c
	cp $0e ; $6c5d
	ld a, b ; $6c5f
	jr nz, .store2 ; $6c60
	sub $82 ; $6c62
.store2:
	ld [hl], a ; $6c64
	pop bc ; $6c65
	pop hl ; $6c66
	inc hl ; $6c67
.nedf:
	inc de ; $6c68
	ld a, e ; $6c69
	and $1f ; $6c6a
	jr nz, .loop ; $6c6c
	push hl ; $6c6e
	ld h, d ; $6c6f
	ld l, e ; $6c70
	add hl, de ; $6c71
	ld d, h ; $6c72
	ld e, l ; $6c73
	pop hl ; $6c74
	jr .loop ; $6c75
.restore:
	pop af ; $6c77
	ret ; $6c78
Unused_05_WriteDialogueToTilemapStreamed:
	push af ; $6c79
	push bc ; $6c7a
	push de ; $6c7b
	push hl ; $6c7c
	push_wram_bank WRAM_TEXT ; $6c7d
	xor a ; $6c86
	call AddTextIdOffset ; $6c87
	xor a ; $6c8a
	ld [wTextArgStringWriteIndex], a ; $6c8b
	ld [wTextArgStringMeasureIndex], a ; $6c8e
	ld [wTextArgNumberWriteIndex], a ; $6c91
	ld [wTextArgNumberMeasureIndex], a ; $6c94
	ld [wTextArgShortTextWriteIndex], a ; $6c97
	ld [wTextArgShortTextMeasureIndex], a ; $6c9a
	ld a, e ; $6c9d
	ld [wGlyphVramDest], a ; $6c9e
	ld a, d ; $6ca1
	ld [wGlyphVramDest + 1], a ; $6ca2
	ld b, $ff ; $6ca5
	ld a, c ; $6ca7
	cpl ; $6ca8
	inc a ; $6ca9
	ld c, a ; $6caa
	ld [wTextRowIndent], a ; $6cab
	call FetchDialogueText ; $6cae
	ld hl, wTextBuffer ; $6cb1
	pop_wram_bank ; $6cb4
.loopB:
	ld a, [hl] ; $6cb9
	or a ; $6cba
	jr z, .checkWramBank ; $6cbb
	cp $03 ; $6cbd
	jr z, .checkWramBank ; $6cbf
	inc hl ; $6cc1
	push af ; $6cc2
	ld a, [hl] ; $6cc3
	ld [wTextCharNameArg], a ; $6cc4
	pop af ; $6cc7
	jr .dispatchControlCode ; $6cc8
	cp $01 ; $6cca
	jr nz, .store3 ; $6ccc
	ld a, $0d ; $6cce
.dispatchControlCode:
	call DispatchControlCode ; $6cd0
	inc hl ; $6cd3
	jr .loopB ; $6cd4
.store3:
	ld [de], a ; $6cd6
	inc hl ; $6cd7
	ld a, [hl] ; $6cd8
	cp $de ; $6cd9
	jr z, .eqde2 ; $6cdb
	cp $df ; $6cdd
	jr nz, .nedf2 ; $6cdf
.eqde2:
	push hl ; $6ce1
	ld h, d ; $6ce2
	ld l, e ; $6ce3
	add hl, bc ; $6ce4
	ld b, a ; $6ce5
	ld a, [hl] ; $6ce6
	cp $0e ; $6ce7
	ld a, b ; $6ce9
	ld b, $ff ; $6cea
	jr nz, .store4 ; $6cec
	sub $82 ; $6cee
.store4:
	ld [hl], a ; $6cf0
	pop hl ; $6cf1
	inc hl ; $6cf2
.nedf2:
	inc de ; $6cf3
	ld a, e ; $6cf4
	and $3f ; $6cf5
	jr nz, .loopB ; $6cf7
	push hl ; $6cf9
	ld h, d ; $6cfa
	ld l, e ; $6cfb
	add hl, bc ; $6cfc
	ld d, h ; $6cfd
	ld e, l ; $6cfe
	pop hl ; $6cff
	jr .loopB ; $6d00
.checkWramBank:
	push_wram_bank WRAM_TEXT ; $6d02
	xor a ; $6d0b
	ld [wTextRowIndent], a ; $6d0c
	ld [wTextArgStringWriteIndex], a ; $6d0f
	ld [wTextArgStringMeasureIndex], a ; $6d12
	ld [wTextArgNumberWriteIndex], a ; $6d15
	ld [wTextArgNumberMeasureIndex], a ; $6d18
	ld [wTextArgShortTextWriteIndex], a ; $6d1b
	ld [wTextArgShortTextMeasureIndex], a ; $6d1e
	pop_wram_bank ; $6d21
	pop hl ; $6d26
	pop de ; $6d27
	pop bc ; $6d28
	pop af ; $6d29
	ret ; $6d2a
