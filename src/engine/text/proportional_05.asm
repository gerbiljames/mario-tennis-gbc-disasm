RenderProportionalTextAt:
	push af ; $5db3
	push bc ; $5db4
	push de ; $5db5
	push hl ; $5db6
	set_flag FLAG_PROPORTIONAL_TEXT_MODE ; $5db7
	push bc ; $5dba
	push de ; $5dbb
	push hl ; $5dbc
	ld hl, wGlyphTileWritePtr ; $5dbd
	ld a, e ; $5dc0
	ld [hl+], a ; $5dc1
	ld [hl], d ; $5dc2
	pop hl ; $5dc3
	call InitGlyphStreamAt ; $5dc4
	push_wram_bank WRAM_TEXT ; $5dc7
	xor a ; $5dd0
	call AddTextIdOffset ; $5dd1
	xor a ; $5dd4
	ld [wTextArgStringWriteIndex], a ; $5dd5
	ld [wTextArgStringMeasureIndex], a ; $5dd8
	ld [wTextArgNumberWriteIndex], a ; $5ddb
	ld [wTextArgNumberMeasureIndex], a ; $5dde
	ld [wTextArgShortTextWriteIndex], a ; $5de1
	ld [wTextArgShortTextMeasureIndex], a ; $5de4
	ld a, [wShadowTilemapPtr + 1] ; $5de7
	add $03 ; $5dea
	cp d ; $5dec
	jr nc, .destOk ; $5ded
	ld a, d ; $5def
	sub $04 ; $5df0
	ld d, a ; $5df2
.destOk:
	ld a, e ; $5df3
	ld [wGlyphVramDest], a ; $5df4
	ld a, d ; $5df7
	ld [wGlyphVramDest + 1], a ; $5df8
	ld c, $20 ; $5dfb
	ld b, $ff ; $5dfd
	ld a, c ; $5dff
	cpl ; $5e00
	inc a ; $5e01
	ld c, a ; $5e02
	ld [wTextRowIndent], a ; $5e03
	call FetchDialogueText ; $5e06
	ld hl, wTextBuffer ; $5e09
	xor a ; $5e0c
	ld [wGlyphStampEnabled], a ; $5e0d
	ld a, [wWindowId] ; $5e10
	ld b, a ; $5e13
	ld a, [wMenuWindowId] ; $5e14
	cp b ; $5e17
	jr z, .markerChecked ; $5e18
	ld a, $01 ; $5e1a
	ld [wGlyphStampEnabled], a ; $5e1c
.markerChecked:
	pop_wram_bank ; $5e1f
.charLoop:
	ld a, [hl] ; $5e24
	cp $20 ; $5e25
	jr nc, ProportionalTextCodeHandler5_05.glyph ; $5e27
	push hl ; $5e29
	push af ; $5e2a
	add a ; $5e2b
	ld hl, ProportionalTextCodeHandlers_05 ; $5e2c
	add l ; $5e2f
	ld l, a ; $5e30
	jr nc, .readVector ; $5e31
	inc h ; $5e33
.readVector:
	ld a, [hl+] ; $5e34
	ld h, [hl] ; $5e35
	ld l, a ; $5e36
	pop af ; $5e37
	jp hl ; $5e38
ProportionalTextCodeHandlers_05:
	; $5e39, 32 bytes (records:2)
	dw ProportionalTextCodeHandler0_05 ; record 0
	dw ProportionalTextCodeHandler1_05 ; record 1
	dw ProportionalTextCodeHandler0_05 ; record 2
	dw ProportionalTextCodeHandler0_05 ; record 3
	dw ProportionalTextCodeHandler4_05 ; record 4
	dw ProportionalTextCodeHandler5_05 ; record 5
	dw ProportionalTextCodeHandler5_05 ; record 6
	dw ProportionalTextCodeHandler4_05 ; record 7
	dw ProportionalTextCodeHandler4_05 ; record 8
	dw ProportionalTextCodeHandler4_05 ; record 9
	dw ProportionalTextCodeHandler5_05 ; record 10
	dw ProportionalTextCodeHandler4_05 ; record 11
	dw ProportionalTextCodeHandler5_05 ; record 12
	dw ProportionalTextCodeHandler5_05 ; record 13
	dw ProportionalTextCodeHandler14_05 ; record 14
	dw ProportionalTextCodeHandler5_05 ; record 15
ProportionalTextCodeHandler14_05:
	pop hl ; $5e59
	inc hl ; $5e5a
	push af ; $5e5b
	wram_bank WRAM_TEXT ; $5e5c
	ld a, [hl] ; $5e62
	ld [wTextCharNameArg], a ; $5e63
	pop_wram_bank ; $5e66
	pop af ; $5e6b
	call DispatchControlCode ; $5e6c
	inc hl ; $5e6f
	jr RenderProportionalTextAt.charLoop ; $5e70
ProportionalTextCodeHandler1_05:
	pop hl ; $5e72
	ld a, $0d ; $5e73
	call DispatchControlCode ; $5e75
	inc hl ; $5e78
	jr RenderProportionalTextAt.charLoop ; $5e79
ProportionalTextCodeHandler4_05:
	pop hl ; $5e7b
	call DispatchControlCode ; $5e7c
	inc hl ; $5e7f
	jr RenderProportionalTextAt.charLoop ; $5e80
ProportionalTextCodeHandler5_05:
	pop hl ; $5e82
.glyph:
	push af ; $5e83
	ld a, [wShadowTilemapBank] ; $5e84
	wram_bank ; $5e87
	pop af ; $5e8b
	call StampGlyphTileAtPen ; $5e8c
	call DrawInlineGlyph ; $5e8f
	call StampGlyphTileAtPen ; $5e92
	inc hl ; $5e95
	ld a, [hl] ; $5e96
	cp $de ; $5e97
	jr z, .markFollows ; $5e99
	cp $df ; $5e9b
	jr nz, .nextCell ; $5e9d
.markFollows:
	push hl ; $5e9f
	ld h, d ; $5ea0
	ld l, e ; $5ea1
	add hl, bc ; $5ea2
	ld b, a ; $5ea3
	ld a, [wShadowTilemapPtr + 1] ; $5ea4
	dec a ; $5ea7
	cp h ; $5ea8
	jr c, .readCell ; $5ea9
	ld a, h ; $5eab
	add $04 ; $5eac
	ld h, a ; $5eae
.readCell:
	ld a, [hl] ; $5eaf
	cp $03 ; $5eb0
	ld a, b ; $5eb2
	ld b, $ff ; $5eb3
	jr nz, .writeCell ; $5eb5
	sub $d0 ; $5eb7
.writeCell:
	ld [hl], a ; $5eb9
	pop hl ; $5eba
	inc hl ; $5ebb
.nextCell:
	inc de ; $5ebc
	ld a, e ; $5ebd
	and $1f ; $5ebe
	jp nz, RenderProportionalTextAt.charLoop ; $5ec0
	push hl ; $5ec3
	ld h, d ; $5ec4
	ld l, e ; $5ec5
	add hl, bc ; $5ec6
	ld d, h ; $5ec7
	ld e, l ; $5ec8
	pop hl ; $5ec9
	jp RenderProportionalTextAt.charLoop ; $5eca
ProportionalTextCodeHandler0_05:
	pop hl ; $5ecd
	push_wram_bank WRAM_TEXT ; $5ece
	xor a ; $5ed7
	ld [wTextRowIndent], a ; $5ed8
	ld [wTextArgStringWriteIndex], a ; $5edb
	ld [wTextArgStringMeasureIndex], a ; $5ede
	ld [wTextArgNumberWriteIndex], a ; $5ee1
	ld [wTextArgNumberMeasureIndex], a ; $5ee4
	ld [wTextArgShortTextWriteIndex], a ; $5ee7
	ld [wTextArgShortTextMeasureIndex], a ; $5eea
	pop_wram_bank ; $5eed
	ld hl, wGlyphPenX ; $5ef2
	ld a, [hl+] ; $5ef5
	ld h, [hl] ; $5ef6
	ld l, a ; $5ef7
	sla l ; $5ef8
	rl h ; $5efa
	ld a, h ; $5efc
	ld [wGlyphRowStartCol], a ; $5efd
	pop de ; $5f00
	pop bc ; $5f01
	call SaveGlyphPenColumns ; $5f02
	clear_flag FLAG_PROPORTIONAL_TEXT_MODE ; $5f05
	pop hl ; $5f08
	pop de ; $5f09
	pop bc ; $5f0a
	pop af ; $5f0b
	ret ; $5f0c
StampGlyphTileAtPen:
	push af ; $5f0d
	push bc ; $5f0e
	push de ; $5f0f
	push hl ; $5f10
	ld a, [wGlyphStampEnabled] ; $5f11
	or a ; $5f14
	jr z, .restore ; $5f15
	ld hl, wGlyphTileWritePtr ; $5f17
	ld a, [hl+] ; $5f1a
	ld d, [hl] ; $5f1b
	ld e, a ; $5f1c
	ld a, [wGlyphFlushedCol] ; $5f1d
	ld b, a ; $5f20
	ld hl, wGlyphPenX ; $5f21
	ld a, [hl+] ; $5f24
	ld h, [hl] ; $5f25
	ld l, a ; $5f26
	sla l ; $5f27
	rl h ; $5f29
	ld a, h ; $5f2b
	ld c, a ; $5f2c
	sub b ; $5f2d
	ld h, e ; $5f2e
	add e ; $5f2f
	ld e, a ; $5f30
	jr nc, .cellPtrOk ; $5f31
	inc d ; $5f33
.cellPtrOk:
	ld a, e ; $5f34
	and $20 ; $5f35
	ld l, a ; $5f37
	ld a, h ; $5f38
	and $20 ; $5f39
	xor l ; $5f3b
	jr z, .checkCell ; $5f3c
	ld hl, $ffe0 ; $5f3e
	add hl, de ; $5f41
	ld d, h ; $5f42
	ld e, l ; $5f43
.checkCell:
	ld a, [de] ; $5f44
	cp $06 ; $5f45
	jr z, .restore ; $5f47
	ld a, c ; $5f49
	add $80 ; $5f4a
	ld [de], a ; $5f4c
.restore:
	pop hl ; $5f4d
	pop de ; $5f4e
	pop bc ; $5f4f
	pop af ; $5f50
	ret ; $5f51
RenderTextToBuffer64:
	push af ; $5f52
	push bc ; $5f53
	push de ; $5f54
	push hl ; $5f55
	push_wram_bank WRAM_TEXT ; $5f56
	xor a ; $5f5f
	call AddTextIdOffset ; $5f60
	ld a, e ; $5f63
	ld [wGlyphVramDest], a ; $5f64
	ld a, d ; $5f67
	ld [wGlyphVramDest + 1], a ; $5f68
	ld b, $ff ; $5f6b
	ld a, c ; $5f6d
	cpl ; $5f6e
	inc a ; $5f6f
	ld c, a ; $5f70
	ld [wTextRowIndent], a ; $5f71
	call FetchDialogueText ; $5f74
	ld hl, wTextBuffer ; $5f77
	pop_wram_bank ; $5f7a
.charLoop:
	ld a, [hl] ; $5f7f
	cp $20 ; $5f80
	jr nc, TextCodeLiteral_05.store ; $5f82
	push hl ; $5f84
	push af ; $5f85
	add a ; $5f86
	ld hl, TextControlCodeHandlers_05 ; $5f87
	add l ; $5f8a
	ld l, a ; $5f8b
	jr nc, .readVector ; $5f8c
	inc h ; $5f8e
.readVector:
	ld a, [hl+] ; $5f8f
	ld h, [hl] ; $5f90
	ld l, a ; $5f91
	pop af ; $5f92
	jp hl ; $5f93
TextControlCodeHandlers_05:
	; $5f94, 32 bytes (records:2)
	dw TextCodeEnd_05 ; record 0
	dw TextCodeLineBreak_05 ; record 1
	dw TextCodeLiteral_05 ; record 2
	dw TextCodeEnd_05 ; record 3
	dw TextCodeLiteral_05 ; record 4
	dw TextCodeLiteral_05 ; record 5
	dw TextCodeLiteral_05 ; record 6
	dw TextCodeLiteral_05 ; record 7
	dw TextCodeLiteral_05 ; record 8
	dw TextCodeLiteral_05 ; record 9
	dw TextCodeLiteral_05 ; record 10
	dw TextCodeLiteral_05 ; record 11
	dw TextCodeLiteral_05 ; record 12
	dw TextCodeLiteral_05 ; record 13
	dw TextCodeLiteral_05 ; record 14
	dw TextCodeLiteral_05 ; record 15
TextCodeLineBreak_05:
	pop hl ; $5fb4
	ld a, $0d ; $5fb5
	call DispatchControlCode ; $5fb7
	inc hl ; $5fba
	jr RenderTextToBuffer64.charLoop ; $5fbb
TextCodeLiteral_05:
	pop hl ; $5fbd
.store:
	ld [de], a ; $5fbe
	inc hl ; $5fbf
	ld a, [hl] ; $5fc0
	cp $de ; $5fc1
	jr z, .eqde ; $5fc3
	cp $df ; $5fc5
	jr nz, .nedf ; $5fc7
.eqde:
	push hl ; $5fc9
	ld h, d ; $5fca
	ld l, e ; $5fcb
	add hl, bc ; $5fcc
	ld b, a ; $5fcd
	ld a, [hl] ; $5fce
	cp $03 ; $5fcf
	ld a, b ; $5fd1
	ld b, $ff ; $5fd2
	jr nz, .store2 ; $5fd4
	sub $d0 ; $5fd6
.store2:
	ld [hl], a ; $5fd8
	pop hl ; $5fd9
	inc hl ; $5fda
.nedf:
	inc de ; $5fdb
	ld a, e ; $5fdc
	and $3f ; $5fdd
	jp nz, RenderTextToBuffer64.charLoop ; $5fdf
	push hl ; $5fe2
	ld h, d ; $5fe3
	ld l, e ; $5fe4
	add hl, bc ; $5fe5
	ld d, h ; $5fe6
	ld e, l ; $5fe7
	pop hl ; $5fe8
	jp RenderTextToBuffer64.charLoop ; $5fe9
TextCodeEnd_05:
	pop hl ; $5fec
	pop hl ; $5fed
	pop de ; $5fee
	pop bc ; $5fef
	pop af ; $5ff0
	ret ; $5ff1
GetObjectSlotPointer:
	ld hl, $0000 ; $5ff2
	cp $ff ; $5ff5
	ret z ; $5ff7
	ld hl, wWindowShadowTilemap ; $5ff8
	cp $18 ; $5ffb
	jr nc, .done ; $5ffd
	push bc ; $5fff
	ld c, $00 ; $6000
	ld b, a ; $6002
	sra b ; $6003
	rr c ; $6005
	sra b ; $6007
	rr c ; $6009
	add hl, bc ; $600b
	pop bc ; $600c
.done:
	ret ; $600d
WriteStringToWindow:
	push af ; $600e
	push bc ; $600f
	push de ; $6010
	push hl ; $6011
.charLoop:
	ld b, a ; $6012
	ld a, [hl] ; $6013
	or a ; $6014
	jr z, .done ; $6015
	cp $de ; $6017
	jr z, .markChar ; $6019
	cp $df ; $601b
	jr z, .markChar ; $601d
	jr .writeChar ; $601f
.markChar:
	push bc ; $6021
	ld a, b ; $6022
	dec d ; $6023
	dec e ; $6024
	call ReadWindowCellTileAttr ; $6025
	inc d ; $6028
	inc e ; $6029
	ld b, a ; $602a
	ld a, c ; $602b
	cp $03 ; $602c
	ld a, [hl] ; $602e
	jr nz, .writeMark ; $602f
	sub $d0 ; $6031
.writeMark:
	pop bc ; $6033
	push bc ; $6034
	ld c, a ; $6035
	ld a, b ; $6036
	ld b, $80 ; $6037
	dec d ; $6039
	dec e ; $603a
	call WriteWindowCellTileAttr ; $603b
	inc d ; $603e
	inc e ; $603f
	inc hl ; $6040
	pop bc ; $6041
	ld a, b ; $6042
	jr .charLoop ; $6043
.writeChar:
	inc hl ; $6045
	ld c, a ; $6046
	ld a, b ; $6047
	ld b, $80 ; $6048
	call WriteWindowCellTileAttr ; $604a
	inc d ; $604d
	jr .charLoop ; $604e
.done:
	pop hl ; $6050
	pop de ; $6051
	pop bc ; $6052
	pop af ; $6053
	ret ; $6054
WriteDialogueToWindow:
	push af ; $6055
	push bc ; $6056
	push de ; $6057
	push hl ; $6058
	call FetchDialogueText ; $6059
	ld hl, wTextBuffer ; $605c
	call WriteStringToWindow ; $605f
	pop hl ; $6062
	pop de ; $6063
	pop bc ; $6064
	pop af ; $6065
	ret ; $6066
Unused_05_WriteNumberToWindow:
	push af ; $6067
	push bc ; $6068
	push de ; $6069
	push hl ; $606a
	call PushTextArgNumber ; $606b
	ld b, a ; $606e
	ld a, $01 ; $606f
	ld [wTextNumberRightAlign], a ; $6071
	ld a, b ; $6074
	ld hl, Text_30_310 ; $6075
	call FetchDialogueText ; $6078
	ld hl, wTextBuffer ; $607b
	call WriteStringToWindow ; $607e
	xor a ; $6081
	ld [wTextNumberRightAlign], a ; $6082
	pop hl ; $6085
	pop de ; $6086
	pop bc ; $6087
	pop af ; $6088
	ret ; $6089
