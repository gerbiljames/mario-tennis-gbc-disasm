RunPagedTextMenu:
	push bc ; $4944
	push de ; $4945
	push hl ; $4946
	ld b, a ; $4947
	push_wram_bank WRAM_TEXT ; $4948
	ld a, b ; $4951
	add sp, -3 ; $4952
	ld b, h ; $4954
	ld c, l ; $4955
	ld hl, sp + 0 ; $4956
	ld [hl], b ; $4958
	ld hl, sp + 1 ; $4959
	ld [hl], c ; $495b
	ld hl, sp + 2 ; $495c
	ld [hl], a ; $495e
	wram_bank WRAM_TEXT ; $495f
	xor a ; $4965
	ld [wMenuPage], a ; $4966
.pageLoop:
	ld hl, sp + 0 ; $4969
	ld b, [hl] ; $496b
	ld hl, sp + 1 ; $496c
	ld c, [hl] ; $496e
	ld a, [wMenuPage] ; $496f
	ld h, $00 ; $4972
	ld l, a ; $4974
	add hl, bc ; $4975
	ld d, $01 ; $4976
	ld e, $01 ; $4978
	call CreateMenuWindowPaged ; $497a
	farcall RestoreShadowTilemap ; $497d
	call RenderMenuWindowText ; $4980
	call RunMenuSelection ; $4983
	push af ; $4986
	ld a, [wMenuWindowId] ; $4987
	call CloseWindow ; $498a
	ld a, $ff ; $498d
	ld [wMenuWindowId], a ; $498f
	pop af ; $4992
	cp $7f ; $4993
	jr nc, .checkCancel ; $4995
	ld b, a ; $4997
	ld a, [wMenuPage] ; $4998
	sla a ; $499b
	sla a ; $499d
	add b ; $499f
	jr .done ; $49a0
.checkCancel:
	cp $ff ; $49a2
	jr z, .done ; $49a4
	cp $fe ; $49a6
	jr nz, .pageNext ; $49a8
	ld a, [wMenuPage] ; $49aa
	dec a ; $49ad
	cp $ff ; $49ae
	jr nz, .storePagePrev ; $49b0
	ld hl, sp + 2 ; $49b2
	ld a, [hl] ; $49b4
	dec a ; $49b5
.storePagePrev:
	ld [wMenuPage], a ; $49b6
	jr .pageLoop ; $49b9
.pageNext:
	ld a, [wMenuPage] ; $49bb
	inc a ; $49be
	ld hl, sp + 2 ; $49bf
	ld b, [hl] ; $49c1
	cp b ; $49c2
	jr c, .storePageNext ; $49c3
	xor a ; $49c5
.storePageNext:
	ld [wMenuPage], a ; $49c6
	jp .pageLoop ; $49c9
.done:
	ld [wMenuCursorRow], a ; $49cc
	add sp, 3 ; $49cf
	ld b, a ; $49d1
	pop_wram_bank ; $49d2
	ld a, b ; $49d7
	pop hl ; $49d8
	pop de ; $49d9
	pop bc ; $49da
	ret ; $49db
; Registered as a per-frame task by Unused_05_RunPagedTextMenuAutoSize and unregistered
; when the menu closes, so it does run every frame -- but its body reads
; wMenuCursorRow into a and then `pop af` discards it, leaving no effect. Not
; a bare `ret` stub: the register/unregister pair around it is real, only the
; work is missing.
Unused_05_PagedMenuFrameTask:
	push af ; $49dc
	push bc ; $49dd
	push de ; $49de
	push hl ; $49df
	push_wram_bank WRAM_TEXT ; $49e0
	ld a, [wMenuCursorRow] ; $49e9
	pop_wram_bank ; $49ec
	pop hl ; $49f1
	pop de ; $49f2
	pop bc ; $49f3
	pop af ; $49f4
	ret ; $49f5
Unused_05_RunPagedTextMenuAutoSize:
	push bc ; $49f6
	push de ; $49f7
	push hl ; $49f8
	ld b, a ; $49f9
	push_wram_bank WRAM_TEXT ; $49fa
	ld a, b ; $4a03
	add sp, -3 ; $4a04
	ld b, h ; $4a06
	ld c, l ; $4a07
	ld hl, sp + 0 ; $4a08
	ld [hl], b ; $4a0a
	ld hl, sp + 1 ; $4a0b
	ld [hl], c ; $4a0d
	ld hl, sp + 2 ; $4a0e
	ld [hl], a ; $4a10
	wram_bank WRAM_TEXT ; $4a11
	xor a ; $4a17
	ld [wMenuPage], a ; $4a18
	ld a, $01 ; $4a1b
	ld hl, Unused_05_PagedMenuFrameTask ; $4a1d
	call RegisterFrameTask ; $4a20
.loop:
	call FetchDialogueText ; $4a23
	call MeasureTextDimensions ; $4a26
	ld a, $01 ; $4a29
	sra b ; $4a2b
	add b ; $4a2d
	ld d, a ; $4a2e
	ld hl, sp + 0 ; $4a2f
	ld b, [hl] ; $4a31
	ld hl, sp + 1 ; $4a32
	ld c, [hl] ; $4a34
	ld a, [wMenuPage] ; $4a35
	ld h, $00 ; $4a38
	ld l, a ; $4a3a
	add hl, bc ; $4a3b
	ld e, $05 ; $4a3c
	call CreateMenuWindowPaged ; $4a3e
	call RestoreShadowTilemap ; $4a41
	call Unused_05_StubNop_05_0 ; $4a44
	call RunMenuSelection ; $4a47
	push af ; $4a4a
	ld a, [wMenuWindowId] ; $4a4b
	call CloseWindow ; $4a4e
	ld a, $ff ; $4a51
	ld [wMenuWindowId], a ; $4a53
	pop af ; $4a56
	cp $7f ; $4a57
	jr nc, .compare ; $4a59
	ld b, a ; $4a5b
	ld a, [wMenuPage] ; $4a5c
	sla a ; $4a5f
	sla a ; $4a61
	add b ; $4a63
	jr .store3 ; $4a64
.compare:
	cp $ff ; $4a66
	jr z, .store3 ; $4a68
	cp $fe ; $4a6a
	jr nz, .nefe ; $4a6c
	ld a, [wMenuPage] ; $4a6e
	dec a ; $4a71
	cp $ff ; $4a72
	jr nz, .store ; $4a74
	ld hl, sp + 2 ; $4a76
	ld a, [hl] ; $4a78
	dec a ; $4a79
.store:
	ld [wMenuPage], a ; $4a7a
	jr .loop ; $4a7d
.nefe:
	ld a, [wMenuPage] ; $4a7f
	inc a ; $4a82
	ld hl, sp + 2 ; $4a83
	ld b, [hl] ; $4a85
	cp b ; $4a86
	jr c, .store2 ; $4a87
	xor a ; $4a89
.store2:
	ld [wMenuPage], a ; $4a8a
	jp .loop ; $4a8d
.store3:
	ld [wMenuCursorRow], a ; $4a90
	add sp, 3 ; $4a93
	push af ; $4a95
	ld hl, Unused_05_PagedMenuFrameTask ; $4a96
	call UnregisterFrameTask ; $4a99
	pop af ; $4a9c
	ld b, a ; $4a9d
	pop_wram_bank ; $4a9e
	ld a, b ; $4aa3
	pop hl ; $4aa4
	pop de ; $4aa5
	pop bc ; $4aa6
	ret ; $4aa7
Unused_05_RunMenuSelectionShared:
	push bc ; $4aa8
	push de ; $4aa9
	push hl ; $4aaa
	push_wram_bank WRAM_TEXT ; $4aab
	xor a ; $4ab4
	ld [wTextArrowEraseAddr], a ; $4ab5
	ld [wTextArrowEraseAddr + 1], a ; $4ab8
	ld a, $ff ; $4abb
	ld hl, wTextArrowCell ; $4abd
	ld [hl+], a ; $4ac0
	ld [hl], a ; $4ac1
	ld a, [wMenuWindowId] ; $4ac2
	call GetWindowStructPtr ; $4ac5
	ld d, [hl] ; $4ac8
	inc hl ; $4ac9
	ld e, [hl] ; $4aca
	inc d ; $4acb
	inc e ; $4acc
	push af ; $4acd
	push bc ; $4ace
	push de ; $4acf
	push hl ; $4ad0
	ld a, [wMenuInitialRow] ; $4ad1
	ld [wMenuCursorRow], a ; $4ad4
	xor a ; $4ad7
	ld [wMenuInitialRow], a ; $4ad8
	ld a, [wMenuCursorRow] ; $4adb
	sla a ; $4ade
	add e ; $4ae0
	ld e, a ; $4ae1
	call GetTilemapCellAddress ; $4ae2
	xor a ; $4ae5
	ld hl, wTextArrowBlinkCounter ; $4ae6
	ld [hl+], a ; $4ae9
	ld [hl], e ; $4aea
	inc hl ; $4aeb
	ld [hl], d ; $4aec
	ld a, $01 ; $4aed
	ld hl, Unused_05_AnimateMenuScrollArrowsTask ; $4aef
	call RegisterFrameTask ; $4af2
	pop hl ; $4af5
	pop de ; $4af6
	pop bc ; $4af7
	pop af ; $4af8
	ld a, [wMenuCursorRow] ; $4af9
	ld b, a ; $4afc
.loop:
	call AdvanceFrame ; $4afd
	ldh a, [hInputPressed] ; $4b00
	bit PADB_A, a ; $4b02
	jp nz, Unused_05_LoadOverworldSpriteDef.isCursorOnAdjustRow ; $4b04
	bit 6, a ; $4b07
	jr z, .bit6Clear ; $4b09
	dec b ; $4b0b
	bit 7, b ; $4b0c
	jr z, .playSfx ; $4b0e
	ld a, [wMenuRowCount] ; $4b10
	dec a ; $4b13
	ld b, a ; $4b14
	jr .playSfx ; $4b15
.bit6Clear:
	ldh a, [hInputPressed] ; $4b17
	and PADF_DOWN ; $4b19
	jp z, Unused_05_LoadOverworldSpriteDef.checkInputRisingEdge ; $4b1b
	ld a, [wMenuRowCount] ; $4b1e
	ld c, a ; $4b21
	inc b ; $4b22
	ld a, b ; $4b23
	cp c ; $4b24
	jr c, .playSfx ; $4b25
	ld b, $00 ; $4b27
.playSfx:
	sound SFX_MENU_MOVE ; $4b29
	push de ; $4b2b
	xor a ; $4b2c
	ld [wTextArrowBlinkCounter], a ; $4b2d
	ld a, b ; $4b30
	sla a ; $4b31
	add e ; $4b33
	ld e, a ; $4b34
	ld a, $20 ; $4b35
	call WriteTileToShadowMapCell ; $4b37
	push af ; $4b3a
	push bc ; $4b3b
	push de ; $4b3c
	push hl ; $4b3d
	ld hl, wTextArrowCell ; $4b3e
	ld a, [hl+] ; $4b41
	ld h, [hl] ; $4b42
	ld l, a ; $4b43
	ld de, $3000 ; $4b44
	add hl, de ; $4b47
	ld de, vBGMap0 ; $4b48
	add hl, de ; $4b4b
	ld d, h ; $4b4c
	ld e, l ; $4b4d
	ld hl, wTextArrowEraseAddr ; $4b4e
	ld a, e ; $4b51
	ld [hl+], a ; $4b52
	ld a, d ; $4b53
	ld [hl], a ; $4b54
	pop hl ; $4b55
	pop de ; $4b56
	pop bc ; $4b57
	pop af ; $4b58
	pop de ; $4b59
	push de ; $4b5a
	ld a, b ; $4b5b
	sla a ; $4b5c
	add e ; $4b5e
	ld e, a ; $4b5f
	push hl ; $4b60
	call GetTilemapCellAddress ; $4b61
	ld hl, wTextArrowCell ; $4b64
	ld [hl], e ; $4b67
Unused_05_LoadOverworldSpriteDef:
	inc hl ; $4b68
	ld [hl], d ; $4b69
	pop hl ; $4b6a
	pop de ; $4b6b
	ld a, b ; $4b6c
	ld [wMenuCursorRow], a ; $4b6d
	jr .checkInputRisingEdge ; $4b70
.isCursorOnAdjustRow:
	call Unused_05_IsCursorOnAdjustRow ; $4b72
	or a ; $4b75
	jr nz, Unused_05_RunMenuSelectionShared.loop ; $4b76
	sound SFX_MENU_SELECT ; $4b78
	ld a, b ; $4b7a
	ld [wMenuCursorRow], a ; $4b7b
	push af ; $4b7e
	push bc ; $4b7f
	push de ; $4b80
	push hl ; $4b81
	ld hl, Unused_05_AnimateMenuScrollArrowsTask ; $4b82
	call UnregisterFrameTask ; $4b85
	call AdvanceFrame ; $4b88
	ld a, [wMenuCursorRow] ; $4b8b
	sla a ; $4b8e
	inc a ; $4b90
	ld e, a ; $4b91
	ld d, $01 ; $4b92
	ld a, [wMenuWindowId] ; $4b94
	ld c, $0d ; $4b97
	ld b, $80 ; $4b99
	call WriteWindowCellTileAttr ; $4b9b
	pop hl ; $4b9e
	pop de ; $4b9f
	pop bc ; $4ba0
	pop af ; $4ba1
	jp .step7 ; $4ba2
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $4ba5
	and PADF_START ; $4ba7
	jp z, .checkInputPressed ; $4ba9
	sound SFX_MENU_CANCEL ; $4bac
	ld a, [wPauseMenuOptionBits] ; $4bae
	and $f0 ; $4bb1
	ld [wPauseMenuOptionBits], a ; $4bb3
	ld a, $ff ; $4bb6
	jp .store ; $4bb8
.checkInputPressed:
	ldh a, [hInputPressed] ; $4bbb
	and PADF_B ; $4bbd
	jp z, .isCursorOnAdjustRow2 ; $4bbf
	sound SFX_MENU_CANCEL ; $4bc2
	ld a, [wPauseMenuOptionBits] ; $4bc4
	and $f0 ; $4bc7
	ld [wPauseMenuOptionBits], a ; $4bc9
	ld a, $ff ; $4bcc
	jp .store ; $4bce
.isCursorOnAdjustRow2:
	push af ; $4bd1
	push bc ; $4bd2
	push de ; $4bd3
	push hl ; $4bd4
	call Unused_05_IsCursorOnAdjustRow ; $4bd5
	or a ; $4bd8
	jr z, .restore ; $4bd9
	ldh a, [hInputPressed] ; $4bdb
	and PADF_LEFT ; $4bdd
	jp z, .zero ; $4bdf
	ld a, [wPauseMenuOptionBits] ; $4be2
	and $f0 ; $4be5
	or $01 ; $4be7
	ld [wPauseMenuOptionBits], a ; $4be9
	jr .restore2 ; $4bec
.zero:
	ldh a, [hInputPressed] ; $4bee
	and PADF_RIGHT ; $4bf0
	jr z, .restore ; $4bf2
	ld a, [wPauseMenuOptionBits] ; $4bf4
	and $f0 ; $4bf7
	or $02 ; $4bf9
	ld [wPauseMenuOptionBits], a ; $4bfb
	jr .restore2 ; $4bfe
.restore:
	pop hl ; $4c00
	pop de ; $4c01
	pop bc ; $4c02
	pop af ; $4c03
	call GetWindowState ; $4c04
	cp $03 ; $4c07
	jp nz, Unused_05_RunMenuSelectionShared.loop ; $4c09
	ld a, [wScrollListLength] ; $4c0c
	dec a ; $4c0f
	sra a ; $4c10
	sra a ; $4c12
	jp z, Unused_05_RunMenuSelectionShared.loop ; $4c14
	ldh a, [hInputPressed] ; $4c17
	and PADF_LEFT ; $4c19
	jp z, .runMenuSelectionShared ; $4c1b
	ld a, $fe ; $4c1e
	jr .store ; $4c20
.runMenuSelectionShared:
	ldh a, [hInputPressed] ; $4c22
	and PADF_RIGHT ; $4c24
	jp z, Unused_05_RunMenuSelectionShared.loop ; $4c26
	ld a, $fd ; $4c29
.store:
	ld [wMenuCursorRow], a ; $4c2b
	jr .unregisterFrameTask ; $4c2e
.restore2:
	pop hl ; $4c30
	pop de ; $4c31
	pop bc ; $4c32
	pop af ; $4c33
	ld a, [wMenuCursorRow] ; $4c34
.unregisterFrameTask:
	push af ; $4c37
	push bc ; $4c38
	push de ; $4c39
	push hl ; $4c3a
	ld hl, Unused_05_AnimateMenuScrollArrowsTask ; $4c3b
	call UnregisterFrameTask ; $4c3e
	call AdvanceFrame ; $4c41
	ld a, [wMenuDepth] ; $4c44
	or a ; $4c47
	jr z, .restore3 ; $4c48
	dec a ; $4c4a
	ld hl, wMenuStack ; $4c4b
	sla a ; $4c4e
	ld c, a ; $4c50
	ld b, $00 ; $4c51
	add hl, bc ; $4c53
	ld a, [hl+] ; $4c54
	and $0f ; $4c55
	sla a ; $4c57
	inc a ; $4c59
	ld e, a ; $4c5a
	ld d, $01 ; $4c5b
	ld a, [hl] ; $4c5d
	and $0f ; $4c5e
	ld c, $20 ; $4c60
	ld b, $80 ; $4c62
	call WriteWindowCellTileAttr ; $4c64
.restore3:
	pop hl ; $4c67
	pop de ; $4c68
	pop bc ; $4c69
	pop af ; $4c6a
.step7:
	ld b, a ; $4c6b
	pop_wram_bank ; $4c6c
	ld a, b ; $4c71
	pop hl ; $4c72
	pop de ; $4c73
	pop bc ; $4c74
	ret ; $4c75
