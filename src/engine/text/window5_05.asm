FetchSRAMDialogueText:
	push af ; $6d2b
	ld a, $00 ; $6d2c
	call FetchSRAMText ; $6d2e
	pop af ; $6d31
	ret ; $6d32
; FetchSRAMDialogueText with a = 1 in place of a = 0 -- the short-text fetch mode over the same SRAM path. Nothing calls it.
Unused_05_FetchSRAMShortText:
	push af ; $6d33
	ld a, $01 ; $6d34
	call FetchSRAMText ; $6d36
	pop af ; $6d39
	ret ; $6d3a
FetchSRAMText:
	push bc ; $6d3b
	push de ; $6d3c
	push hl ; $6d3d
	ld hl, SramTextOffsetTable_05 ; $6d3e
	sla e ; $6d41
	rl d ; $6d43
	add hl, de ; $6d45
	ld e, [hl] ; $6d46
	inc hl ; $6d47
	ld d, [hl] ; $6d48
	ld hl, $a800 ; $6d49
	add hl, de ; $6d4c
	or a ; $6d4d
	jr nz, .nonZero ; $6d4e
	ld de, wTextBuffer ; $6d50
	ld bc, $0180 ; $6d53
	jr .copyMemoryBC ; $6d56
.nonZero:
	ld de, wShortTextBuffer ; $6d58
	ld bc, $0020 ; $6d5b
.copyMemoryBC:
	call CopyMemoryBC ; $6d5e
	pop hl ; $6d61
	pop de ; $6d62
	pop bc ; $6d63
	ret ; $6d64
SramTextOffsetTable_05:
	; $6d65, 32 bytes (records:2)
	dw $0009 ; record 0
	dw $0089 ; record 1
	dw $0109 ; record 2
	dw $0189 ; record 3
	dw $0209 ; record 4
	dw $0289 ; record 5
	dw $0309 ; record 6
	dw $0389 ; record 7
	dw $0409 ; record 8
	dw $0489 ; record 9
	dw $0509 ; record 10
	dw $0589 ; record 11
	dw $0609 ; record 12
	dw $0689 ; record 13
	dw $0709 ; record 14
	dw $0789 ; record 15
Unused_05_RunDebugWindowDemo:
	ldh a, [hWramBank] ; $6d85
	push af ; $6d87
	xor a ; $6d88
	ld a, $02 ; $6d89
	ldh [hScrollX], a ; $6d8b
	ldh [hScrollY], a ; $6d8d
	script_fade_in $7f ; $6d8f
	call WaitFadeEnd ; $6d94
	call RestoreShadowTilemap ; $6d97
	wait_frames $1e ; $6d9a
	call DisableLCDSafely ; $6d9e
	call ResetTextWindowState ; $6da1
	ld de, $d000 ; $6da4
	ld hl, wShadowTilemapPtr ; $6da7
	ld a, e ; $6daa
	ld [hl+], a ; $6dab
	ld [hl], d ; $6dac
	ld a, $05 ; $6dad
	ld [wShadowTilemapBank], a ; $6daf
	ld a, TILEATTR_PRIORITY ; $6db2
	ld [wWindowTileAttr], a ; $6db4
	ld d, $00 ; $6db7
	ld e, $02 ; $6db9
	ld b, $10 ; $6dbb
	ld c, $07 ; $6dbd
	call CreateWindowFromScreenRect ; $6dbf
	call DrawTextWindowFrame ; $6dc2
	call RedrawWindowRows ; $6dc5
	ld d, $02 ; $6dc8
	ld e, $04 ; $6dca
	ld b, $08 ; $6dcc
	ld c, $0c ; $6dce
	call CreateWindowFromScreenRect ; $6dd0
	call DrawTextWindowFrame ; $6dd3
	call RedrawWindowRows ; $6dd6
	call EnableLCD ; $6dd9
	pop_wram_bank ; $6ddc
	sound SFX_BEEP ; $6de1
.loop:
	ldh a, [hPlayerInputFlags] ; $6de3
	ld hl, hScrollX ; $6de5
	bit PADB_RIGHT, a ; $6de8
	jr z, .step ; $6dea
	inc [hl] ; $6dec
	jr .step2 ; $6ded
.step:
	bit 5, a ; $6def
	jr z, .step2 ; $6df1
	dec [hl] ; $6df3
.step2:
	ld hl, hScrollY ; $6df4
	bit 6, a ; $6df7
	jr z, .bit6Clear ; $6df9
	dec [hl] ; $6dfb
	jr .advanceFrame ; $6dfc
.bit6Clear:
	bit 7, a ; $6dfe
	jr z, .advanceFrame ; $6e00
	inc [hl] ; $6e02
.advanceFrame:
	call AdvanceFrame ; $6e03
	jr .loop ; $6e06
	ret ; $6e08
ResetTextWindowState:
	push af ; $6e09
	push bc ; $6e0a
	push de ; $6e0b
	push hl ; $6e0c
	wram_bank WRAM_TEXT ; $6e0d
	ld hl, wWindowShadowTilemap ; $6e13
	ld c, $80 ; $6e16
	call ClearMemory16 ; $6e18
	ld hl, wWindowFitTable ; $6e1b
	ld c, $80 ; $6e1e
	call ClearMemory16 ; $6e20
	ld de, wWindowShadowTilemap ; $6e23
	ld hl, wShadowTilemapPtr ; $6e26
	ld a, e ; $6e29
	ld [hl+], a ; $6e2a
	ld [hl], d ; $6e2b
	ld a, $05 ; $6e2c
	ld [wShadowTilemapBank], a ; $6e2e
	ld a, TILEATTR_PRIORITY ; $6e31
	ld [wWindowTileAttr], a ; $6e33
	ld a, DIALOGUEWIN_NONE ; $6e36
	ld [wDialogueWindowId], a ; $6e38
	ld a, $fe ; $6e3b
	ld [wMenuWindowId], a ; $6e3d
	pop hl ; $6e40
	pop de ; $6e41
	pop bc ; $6e42
	pop af ; $6e43
	ret ; $6e44
CreateWindowFromScreenRect:
	push bc ; $6e45
	push de ; $6e46
	push hl ; $6e47
	call PrepareGlyphBuffer ; $6e48
	wram_bank WRAM_TEXT ; $6e4b
	ld h, d ; $6e51
	ld l, e ; $6e52
	call GetScreenTopLeftCell ; $6e53
	ld a, h ; $6e56
	add d ; $6e57
	ld d, a ; $6e58
	ld a, l ; $6e59
	add e ; $6e5a
	ld e, a ; $6e5b
	call AllocWindowStruct ; $6e5c
	ld a, [wWindowId] ; $6e5f
	cp $ff ; $6e62
	jr z, .done ; $6e64
	ld a, [wWindowId] ; $6e66
.done:
	pop hl ; $6e69
	pop de ; $6e6a
	pop bc ; $6e6b
	ret ; $6e6c
AllocWindowStruct:
	push de ; $6e6d
	push bc ; $6e6e
	push hl ; $6e6f
	wram_bank WRAM_TEXT ; $6e70
	call AllocWindowId ; $6e76
	cp $ff ; $6e79
	jr z, .restore ; $6e7b
	ld [wWindowId], a ; $6e7d
	add a ; $6e80
	add a ; $6e81
	add a ; $6e82
	ld hl, wWindowStructs ; $6e83
	add l ; $6e86
	ld l, a ; $6e87
	jr nc, .store ; $6e88
	inc h ; $6e8a
.store:
	ld [hl], d ; $6e8b
	inc hl ; $6e8c
	ld [hl], e ; $6e8d
	inc hl ; $6e8e
	ld [hl], b ; $6e8f
	inc hl ; $6e90
	ld [hl], c ; $6e91
.restore:
	pop hl ; $6e92
	pop bc ; $6e93
	pop de ; $6e94
	ret ; $6e95
AllocWindowId:
	push hl ; $6e96
	push bc ; $6e97
	push de ; $6e98
	ld b, $07 ; $6e99
	ld a, [wWindowSlotMask] ; $6e9b
	ld c, $01 ; $6e9e
.loop:
	rrca ; $6ea0
	jr nc, .step ; $6ea1
	sla c ; $6ea3
	dec b ; $6ea5
	jr nz, .loop ; $6ea6
	ld a, $ff ; $6ea8
	jr .restore ; $6eaa
.step:
	ld a, [wWindowSlotMask] ; $6eac
	or c ; $6eaf
	ld [wWindowSlotMask], a ; $6eb0
	ld a, $07 ; $6eb3
	sub b ; $6eb5
.restore:
	pop de ; $6eb6
	pop bc ; $6eb7
	pop hl ; $6eb8
	ret ; $6eb9
FreeWindow:
	push bc ; $6eba
	push de ; $6ebb
	ld d, a ; $6ebc
	call GetWindowStructPtr ; $6ebd
	xor a ; $6ec0
	ld c, $08 ; $6ec1
.clearLoop:
	ld [hl+], a ; $6ec3
	dec c ; $6ec4
	jr nz, .clearLoop ; $6ec5
	ld c, d ; $6ec7
	inc c ; $6ec8
	ld a, $01 ; $6ec9
.maskLoop:
	dec c ; $6ecb
	jr z, .clearBit ; $6ecc
	sla a ; $6ece
	jr .maskLoop ; $6ed0
.clearBit:
	ld b, a ; $6ed2
	ld a, [wWindowSlotMask] ; $6ed3
	and b ; $6ed6
	ld a, $ff ; $6ed7
	jr z, .restore ; $6ed9
	ld a, b ; $6edb
	xor $ff ; $6edc
	ld b, a ; $6ede
	ld a, [wWindowSlotMask] ; $6edf
	and b ; $6ee2
	ld [wWindowSlotMask], a ; $6ee3
	ld a, d ; $6ee6
.restore:
	pop de ; $6ee7
	pop bc ; $6ee8
	ret ; $6ee9
GetWindowStructPtr:
	push af ; $6eea
	and $07 ; $6eeb
	add a ; $6eed
	add a ; $6eee
	add a ; $6eef
	ld hl, wWindowStructs ; $6ef0
	add l ; $6ef3
	ld l, a ; $6ef4
	jr nc, .done ; $6ef5
	inc h ; $6ef7
.done:
	pop af ; $6ef8
	ret ; $6ef9
SaveWindowStruct:
	push af ; $6efa
	push bc ; $6efb
	push de ; $6efc
	push hl ; $6efd
	call GetWindowStructPtr ; $6efe
	ld de, wSavedWindowStruct ; $6f01
	ld c, $08 ; $6f04
.loop:
	ld a, [hl+] ; $6f06
	ld [de], a ; $6f07
	inc de ; $6f08
	dec c ; $6f09
	jr nz, .loop ; $6f0a
	pop hl ; $6f0c
	pop de ; $6f0d
	pop bc ; $6f0e
	pop af ; $6f0f
	ret ; $6f10
RestoreWindowStruct:
	push af ; $6f11
	push bc ; $6f12
	push de ; $6f13
	push hl ; $6f14
	call GetWindowStructPtr ; $6f15
	ld d, h ; $6f18
	ld e, l ; $6f19
	ld hl, wSavedWindowStruct ; $6f1a
	ld c, $08 ; $6f1d
.loop:
	ld a, [hl+] ; $6f1f
	ld [de], a ; $6f20
	inc de ; $6f21
	dec c ; $6f22
	jr nz, .loop ; $6f23
	pop hl ; $6f25
	pop de ; $6f26
	pop bc ; $6f27
	pop af ; $6f28
	ret ; $6f29
WrapCellPtrToRowStart:
	push af ; $6f2a
	ld a, l ; $6f2b
	and $1f ; $6f2c
	jr nz, .done ; $6f2e
	push bc ; $6f30
	ld bc, $ffe0 ; $6f31
	add hl, bc ; $6f34
	pop bc ; $6f35
.done:
	pop af ; $6f36
	ret ; $6f37
ClampCellPtrToShadowMap:
	push af ; $6f38
	push_wram_bank WRAM_TEXT ; $6f39
	ld a, [wShadowTilemapPtr + 1] ; $6f42
	add $03 ; $6f45
	cp h ; $6f47
	jr nc, .restore ; $6f48
	sub $03 ; $6f4a
	ld h, a ; $6f4c
.restore:
	pop_wram_bank ; $6f4d
	pop af ; $6f52
	ret ; $6f53
ClampCellPtrToAttrMap:
	push af ; $6f54
	push_wram_bank WRAM_TEXT ; $6f55
	ld a, [wShadowTilemapPtr + 1] ; $6f5e
	add $07 ; $6f61
	cp h ; $6f63
	jr nc, .restore ; $6f64
	sub $03 ; $6f66
	ld h, a ; $6f68
.restore:
	pop_wram_bank ; $6f69
	pop af ; $6f6e
	ret ; $6f6f
DrawTextWindowFrame:
	push af ; $6f70
	push bc ; $6f71
	push de ; $6f72
	push hl ; $6f73
	ld b, a ; $6f74
	ldh a, [hWramBank] ; $6f75
	push af ; $6f77
	ld a, b ; $6f78
	call GetWindowStructPtr ; $6f79
	ld d, [hl] ; $6f7c
	inc hl ; $6f7d
	ld e, [hl] ; $6f7e
	inc hl ; $6f7f
	ld b, [hl] ; $6f80
	inc hl ; $6f81
	ld c, [hl] ; $6f82
	inc hl ; $6f83
	ld a, [hl] ; $6f84
	cp $ff ; $6f85
	jp z, .done ; $6f87
	ld l, e ; $6f8a
	ld h, $00 ; $6f8b
	add hl, hl ; $6f8d
	add hl, hl ; $6f8e
	add hl, hl ; $6f8f
	add hl, hl ; $6f90
	add hl, hl ; $6f91
	ld a, d ; $6f92
	add l ; $6f93
	ld l, a ; $6f94
	jr nc, .gotOffset ; $6f95
	inc h ; $6f97
.gotOffset:
	ld d, h ; $6f98
	ld e, l ; $6f99
	ld hl, wShadowTilemapPtr ; $6f9a
	ld a, [hl+] ; $6f9d
	ld h, [hl] ; $6f9e
	ld l, a ; $6f9f
	add hl, de ; $6fa0
	ld a, [wShadowTilemapPtr + 1] ; $6fa1
	add $03 ; $6fa4
	cp h ; $6fa6
	jr nc, .mapPtrOk ; $6fa7
	ld a, h ; $6fa9
	sub $04 ; $6faa
	ld h, a ; $6fac
.mapPtrOk:
	ld e, b ; $6fad
	ld d, c ; $6fae
	ld a, [wWindowTileAttr] ; $6faf
	push af ; $6fb2
	push de ; $6fb3
	push hl ; $6fb4
	dec d ; $6fb5
	dec d ; $6fb6
	dec e ; $6fb7
	dec e ; $6fb8
	ld a, [wShadowTilemapBank] ; $6fb9
	ld a, a ; $6fbc
	wram_bank ; $6fbd
	ld a, [wGlyphRowStartCol] ; $6fc1
	add $80 ; $6fc4
	ld [wTextRowNextTile], a ; $6fc6
	push hl ; $6fc9
	ld [hl], $02 ; $6fca
	inc hl ; $6fcc
	call WrapCellPtrToRowStart ; $6fcd
	ld b, e ; $6fd0
	ld a, $03 ; $6fd1
.topLoop:
	ld [hl+], a ; $6fd3
	call WrapCellPtrToRowStart ; $6fd4
	dec b ; $6fd7
	jr nz, .topLoop ; $6fd8
	ld [hl], $04 ; $6fda
	inc hl ; $6fdc
	call WrapCellPtrToRowStart ; $6fdd
	pop hl ; $6fe0
	ld a, $20 ; $6fe1
	add l ; $6fe3
	ld l, a ; $6fe4
	jr nc, .topRowDone ; $6fe5
	inc h ; $6fe7
.topRowDone:
	call ClampCellPtrToShadowMap ; $6fe8
.midRowLoop:
	push hl ; $6feb
	ld [hl], $05 ; $6fec
	inc hl ; $6fee
	call WrapCellPtrToRowStart ; $6fef
	ld b, e ; $6ff2
	bit 0, d ; $6ff3
	jr z, .fillBlank ; $6ff5
	ld a, [wTextRowNextTile] ; $6ff7
.textCellLoop:
	test_flag FLAG_TEXT_RENDER_ACTIVE ; $6ffa
	jr z, .blankCell ; $6ffd
	ld [hl+], a ; $6fff
	jr .nextTextCell ; $7000
.blankCell:
	ld [hl], $20 ; $7002
	inc hl ; $7004
.nextTextCell:
	call WrapCellPtrToRowStart ; $7005
	inc a ; $7008
	dec b ; $7009
	jr nz, .textCellLoop ; $700a
	ld [wTextRowNextTile], a ; $700c
	jr .midRowEnd ; $700f
.fillBlank:
	ld a, $20 ; $7011
.blankLoop:
	ld [hl+], a ; $7013
	call WrapCellPtrToRowStart ; $7014
	dec b ; $7017
	jr nz, .blankLoop ; $7018
.midRowEnd:
	ld [hl], $06 ; $701a
	inc hl ; $701c
	call WrapCellPtrToRowStart ; $701d
	pop hl ; $7020
	ld a, $20 ; $7021
	add l ; $7023
	ld l, a ; $7024
	jr nc, .midRowDone ; $7025
	inc h ; $7027
.midRowDone:
	call ClampCellPtrToShadowMap ; $7028
	dec d ; $702b
	jr nz, .midRowLoop ; $702c
	push hl ; $702e
	ld [hl], $07 ; $702f
	inc hl ; $7031
	call WrapCellPtrToRowStart ; $7032
	ld b, e ; $7035
	ld a, $08 ; $7036
.bottomLoop:
	ld [hl+], a ; $7038
	call WrapCellPtrToRowStart ; $7039
	dec b ; $703c
	jr nz, .bottomLoop ; $703d
	ld [hl], $09 ; $703f
	inc hl ; $7041
	call WrapCellPtrToRowStart ; $7042
	pop hl ; $7045
	ld a, $20 ; $7046
	add l ; $7048
	ld l, a ; $7049
	jr nc, .bottomRowDone ; $704a
	inc h ; $704c
.bottomRowDone:
	call ClampCellPtrToShadowMap ; $704d
	pop hl ; $7050
	ld bc, $0400 ; $7051
	add hl, bc ; $7054
	pop de ; $7055
	pop af ; $7056
	dec e ; $7057
	dec e ; $7058
	ld c, a ; $7059
.attrRowLoop:
	push hl ; $705a
	ld [hl], c ; $705b
	inc hl ; $705c
	call WrapCellPtrToRowStart ; $705d
	ld b, e ; $7060
.attrCellLoop:
	ld [hl], c ; $7061
	inc hl ; $7062
	call WrapCellPtrToRowStart ; $7063
	dec b ; $7066
	jr nz, .attrCellLoop ; $7067
	ld [hl], c ; $7069
	inc hl ; $706a
	call WrapCellPtrToRowStart ; $706b
	pop hl ; $706e
	ld a, $20 ; $706f
	add l ; $7071
	ld l, a ; $7072
	jr nc, .attrRowDone ; $7073
	inc h ; $7075
.attrRowDone:
	call ClampCellPtrToAttrMap ; $7076
	dec d ; $7079
	jr nz, .attrRowLoop ; $707a
.done:
	pop_wram_bank ; $707c
	pop hl ; $7081
	pop de ; $7082
	pop bc ; $7083
	pop af ; $7084
	ret ; $7085
