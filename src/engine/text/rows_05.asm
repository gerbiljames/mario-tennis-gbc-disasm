MarkTilemapRowsDirty:
	push af ; $7086
	push bc ; $7087
	push de ; $7088
	push hl ; $7089
	ld a, d ; $708a
	and $1f ; $708b
	ld d, a ; $708d
	call SetRowDirtyFlags ; $708e
	pop hl ; $7091
	pop de ; $7092
	pop bc ; $7093
	pop af ; $7094
	ret ; $7095
MarkWindowRowsDirty:
	push af ; $7096
	push bc ; $7097
	push de ; $7098
	push hl ; $7099
	call GetWindowStructPtr ; $709a
	inc hl ; $709d
	ld d, [hl] ; $709e
	inc hl ; $709f
	inc hl ; $70a0
	ld e, [hl] ; $70a1
	call SetRowDirtyFlags ; $70a2
	pop hl ; $70a5
	pop de ; $70a6
	pop bc ; $70a7
	pop af ; $70a8
	ret ; $70a9
SetRowDirtyFlags:
	ld hl, wTilemapRowDirty ; $70aa
	ld c, $20 ; $70ad
	xor a ; $70af
.loop:
	ld [hl+], a ; $70b0
	dec c ; $70b1
	jr nz, .loop ; $70b2
	ld hl, wTilemapRowDirty ; $70b4
	ld a, d ; $70b7
	and $1f ; $70b8
	ld d, a ; $70ba
	add l ; $70bb
	ld l, a ; $70bc
	jr nc, .gotPtr ; $70bd
	inc h ; $70bf
.gotPtr:
	ld a, $01 ; $70c0
.loopB:
	ld [hl+], a ; $70c2
	inc d ; $70c3
	bit 5, d ; $70c4
	jr z, .bit5Clear ; $70c6
	res 5, d ; $70c8
	ld hl, wTilemapRowDirty ; $70ca
.bit5Clear:
	dec e ; $70cd
	jr nz, .loopB ; $70ce
	ret ; $70d0
MarkWindowRowsDirtyMin7:
	push af ; $70d1
	push bc ; $70d2
	push de ; $70d3
	push hl ; $70d4
	call GetWindowStructPtr ; $70d5
	inc hl ; $70d8
	ld d, [hl] ; $70d9
	inc hl ; $70da
	inc hl ; $70db
	ld e, [hl] ; $70dc
	ld a, e ; $70dd
	cp $07 ; $70de
	jr nc, .ge07 ; $70e0
	ld a, $07 ; $70e2
	sub e ; $70e4
	srl a ; $70e5
	ld e, a ; $70e7
	ld a, d ; $70e8
	sub e ; $70e9
	and $1f ; $70ea
	ld d, a ; $70ec
	ld e, $07 ; $70ed
.ge07:
	ld hl, wTilemapRowDirty ; $70ef
	ld c, $20 ; $70f2
	xor a ; $70f4
.loop:
	ld [hl+], a ; $70f5
	dec c ; $70f6
	jr nz, .loop ; $70f7
	ld hl, wTilemapRowDirty ; $70f9
	ld a, d ; $70fc
	and $1f ; $70fd
	ld d, a ; $70ff
	add l ; $7100
	ld l, a ; $7101
	jr nc, .gotPtr ; $7102
	inc h ; $7104
.gotPtr:
	ld a, $01 ; $7105
.loopB:
	ld [hl+], a ; $7107
	inc d ; $7108
	bit 5, d ; $7109
	jr z, .bit5Clear ; $710b
	res 5, d ; $710d
	ld hl, wTilemapRowDirty ; $710f
.bit5Clear:
	dec e ; $7112
	jr nz, .loopB ; $7113
	pop hl ; $7115
	pop de ; $7116
	pop bc ; $7117
	pop af ; $7118
	ret ; $7119
FlushDirtyRowsPerFrame:
	push af ; $711a
	push bc ; $711b
	push de ; $711c
	push hl ; $711d
	call BuildDirtyRowRuns ; $711e
	set_flag FLAG_VRAM_UPDATE_BUSY ; $7121
	ld hl, wTilemapRowRuns ; $7124
.loop:
	ld a, [hl] ; $7127
	cp $ff ; $7128
	jr z, .eqff ; $712a
	ld c, [hl] ; $712c
	inc hl ; $712d
	ld b, [hl] ; $712e
	inc hl ; $712f
	call CopyDirtyRowSpanToVRAM ; $7130
	push af ; $7133
	ldh a, [rLCDC] ; $7134
	bit 7, a ; $7136
	jr z, .restore ; $7138
	call AdvanceFrame ; $713a
.restore:
	pop af ; $713d
	jr .loop ; $713e
.eqff:
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7140
	pop hl ; $7143
	pop de ; $7144
	pop bc ; $7145
	pop af ; $7146
	ret ; $7147
FlushDirtyRowsNow:
	push af ; $7148
	push bc ; $7149
	push de ; $714a
	push hl ; $714b
	call BuildDirtyRowRuns ; $714c
	set_flag FLAG_VRAM_UPDATE_BUSY ; $714f
	ld hl, wTilemapRowRuns ; $7152
.loop:
	ld a, [hl] ; $7155
	cp $ff ; $7156
	jr z, .eqff ; $7158
	ld c, [hl] ; $715a
	inc hl ; $715b
	ld b, [hl] ; $715c
	inc hl ; $715d
	call CopyDirtyRowSpanToVRAM ; $715e
	jr .loop ; $7161
.eqff:
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7163
	push af ; $7166
	ldh a, [rLCDC] ; $7167
	bit 7, a ; $7169
	jr z, .restore ; $716b
	call AdvanceFrame ; $716d
.restore:
	pop af ; $7170
	pop hl ; $7171
	pop de ; $7172
	pop bc ; $7173
	pop af ; $7174
	ret ; $7175
CopyDirtyRowSpanToVRAM:
	push af ; $7176
	push bc ; $7177
	push de ; $7178
	push hl ; $7179
	ld l, c ; $717a
	ld h, $00 ; $717b
	add hl, hl ; $717d
	add hl, hl ; $717e
	add hl, hl ; $717f
	add hl, hl ; $7180
	add hl, hl ; $7181
	ld d, h ; $7182
	ld e, l ; $7183
	ld hl, wShadowTilemapPtr ; $7184
	ld a, [hl+] ; $7187
	ld h, [hl] ; $7188
	ld l, a ; $7189
	add hl, de ; $718a
	push hl ; $718b
	ld hl, $9800 ; $718c
	add hl, de ; $718f
	ld d, h ; $7190
	ld e, l ; $7191
	pop hl ; $7192
	ld c, b ; $7193
	sla c ; $7194
	ld a, [wShadowTilemapBank] ; $7196
	ld b, a ; $7199
	ldh a, [hWramBank] ; $719a
	push af ; $719c
	ld a, b ; $719d
	wram_bank ; $719e
	push hl ; $71a2
	push de ; $71a3
	push bc ; $71a4
	call QueueVRAMCopy ; $71a5
	pop bc ; $71a8
	pop de ; $71a9
	ld hl, $2000 ; $71aa
	add hl, de ; $71ad
	ld d, h ; $71ae
	ld e, l ; $71af
	pop hl ; $71b0
	push de ; $71b1
	ld de, $0400 ; $71b2
	add hl, de ; $71b5
	pop de ; $71b6
	call QueueVRAMCopy ; $71b7
	pop_wram_bank ; $71ba
	pop hl ; $71bf
	pop de ; $71c0
	pop bc ; $71c1
	pop af ; $71c2
	ret ; $71c3
BuildDirtyRowRuns:
	ld c, $00 ; $71c4
	ld hl, wTilemapRowDirty ; $71c6
	ld de, wTilemapRowRuns ; $71c9
.loop:
	ld a, c ; $71cc
	cp $20 ; $71cd
	jr nc, .ge20 ; $71cf
	ld a, [hl] ; $71d1
	or a ; $71d2
	jr nz, .nonZero ; $71d3
	inc hl ; $71d5
	inc c ; $71d6
	jr .loop ; $71d7
.nonZero:
	push hl ; $71d9
	ld h, d ; $71da
	ld l, e ; $71db
	ld [hl], c ; $71dc
	inc hl ; $71dd
	ld d, h ; $71de
	ld e, l ; $71df
	pop hl ; $71e0
	ld b, $00 ; $71e1
.loopB:
	ld a, c ; $71e3
	cp $20 ; $71e4
	jr nc, .step2 ; $71e6
	ld a, [hl] ; $71e8
	or a ; $71e9
	jr z, .step2 ; $71ea
	inc hl ; $71ec
	inc c ; $71ed
	inc b ; $71ee
	ld a, b ; $71ef
	cp $07 ; $71f0
	jr nc, .step2 ; $71f2
	jr .loopB ; $71f4
.step2:
	push hl ; $71f6
	ld h, d ; $71f7
	ld l, e ; $71f8
	ld [hl], b ; $71f9
	inc hl ; $71fa
	ld d, h ; $71fb
	ld e, l ; $71fc
	pop hl ; $71fd
	jr .loop ; $71fe
.ge20:
	ld h, d ; $7200
	ld l, e ; $7201
	ld [hl], $ff ; $7202
	ret ; $7204
RedrawWindowRows:
	push af ; $7205
	push bc ; $7206
	push de ; $7207
	push hl ; $7208
	call MarkWindowRowsDirty ; $7209
	call FlushDirtyRowsPerFrame ; $720c
	pop hl ; $720f
	pop de ; $7210
	pop bc ; $7211
	pop af ; $7212
	ret ; $7213
RedrawWindowRowsPadded:
	push af ; $7214
	push bc ; $7215
	push de ; $7216
	push hl ; $7217
	call MarkWindowRowsDirtyMin7 ; $7218
	call FlushDirtyRowsNow ; $721b
	pop hl ; $721e
	pop de ; $721f
	pop bc ; $7220
	pop af ; $7221
	ret ; $7222
RedrawTilemapRowRange:
	push af ; $7223
	push bc ; $7224
	push de ; $7225
	push hl ; $7226
	call MarkTilemapRowsDirty ; $7227
	call FlushDirtyRowsPerFrame ; $722a
	pop hl ; $722d
	pop de ; $722e
	pop bc ; $722f
	pop af ; $7230
	ret ; $7231
RenderMenuWindowText:
	push af ; $7232
	push bc ; $7233
	push de ; $7234
	push hl ; $7235
	ld a, [wMenuWindowId] ; $7236
	or a ; $7239
	jr nz, .draw ; $723a
	call PrepareGlyphBuffer ; $723c
.draw:
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $723f
	ld a, [wMenuWindowId] ; $7242
	call DrawTextWindowFrame ; $7245
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $7248
	farcall GetWindowStructPtr ; $724b
	ld b, h ; $724e
	ld c, l ; $724f
	ld d, [hl] ; $7250
	inc hl ; $7251
	ld e, [hl] ; $7252
	ld hl, $0006 ; $7253
	add hl, bc ; $7256
	ld a, [hl+] ; $7257
	ld h, [hl] ; $7258
	ld l, a ; $7259
	push hl ; $725a
	inc d ; $725b
	inc d ; $725c
	ld a, d ; $725d
RenderTextAtWindowCell:
	and $1f ; $725e
	ld d, a ; $7260
	inc e ; $7261
	ld a, e ; $7262
	and $1f ; $7263
	ld e, a ; $7265
	ld h, $00 ; $7266
	ld l, e ; $7268
	add hl, hl ; $7269
	add hl, hl ; $726a
	add hl, hl ; $726b
	add hl, hl ; $726c
	add hl, hl ; $726d
	ld a, d ; $726e
	add l ; $726f
	ld l, a ; $7270
	jr nc, .gotPtr ; $7271
	inc h ; $7273
.gotPtr:
	ld d, h ; $7274
	ld e, l ; $7275
	ld hl, wShadowTilemapPtr ; $7276
	ld a, [hl+] ; $7279
	ld h, [hl] ; $727a
	ld l, a ; $727b
	add hl, de ; $727c
	ld d, h ; $727d
	ld e, l ; $727e
	pop hl ; $727f
	push_wram_bank WRAM_TEXT ; $7280
	ld a, [wMenuWindowId] ; $7289
	ld c, a ; $728c
	ld a, [wShadowTilemapBank] ; $728d
	ld a, a ; $7290
	wram_bank ; $7291
	push de ; $7295
	push hl ; $7296
	ld a, c ; $7297
	call GetWindowStructPtr ; $7298
	ld a, $02 ; $729b
	add l ; $729d
	ld l, a ; $729e
	jr nc, .read ; $729f
	inc h ; $72a1
.read:
	ld c, [hl] ; $72a2
	dec c ; $72a3
	dec c ; $72a4
	pop hl ; $72a5
	pop de ; $72a6
	call RenderProportionalTextAt ; $72a7
	call UploadGlyphBuffer ; $72aa
	pop_wram_bank ; $72ad
	ld a, [wMenuWindowId] ; $72b2
	call RedrawWindowRows ; $72b5
	pop hl ; $72b8
	pop de ; $72b9
	pop bc ; $72ba
	pop af ; $72bb
	ret ; $72bc
CloseWindow:
	push af ; $72bd
	push bc ; $72be
	push de ; $72bf
	push hl ; $72c0
	call RestoreTilemapUnderWindow ; $72c1
	call RedrawWindowRows ; $72c4
	call ResetWindowState ; $72c7
	call FreeWindow ; $72ca
	pop hl ; $72cd
	pop de ; $72ce
	pop bc ; $72cf
	pop af ; $72d0
	ret ; $72d1
RedrawAllTilemapRows:
	push de ; $72d2
	ld d, $00 ; $72d3
	ld e, $20 ; $72d5
	call RedrawTilemapRowRange ; $72d7
	pop de ; $72da
	ret ; $72db
PrepareGlyphBuffer:
	push af ; $72dc
	push bc ; $72dd
	push de ; $72de
	push hl ; $72df
	push_wram_bank WRAM_TEXT ; $72e0
	ld a, [wGlyphBufferHoldCount] ; $72e9
	or a ; $72ec
	jr nz, .keepBuffer ; $72ed
	wram_bank WRAM_SOUND ; $72ef
	call ClearGlyphBuffer ; $72f5
	call ResetGlyphStream ; $72f8
	jr .done ; $72fb
.keepBuffer:
	ld a, [wGlyphRowStartCol] ; $72fd
	ld [wGlyphFlushedCol], a ; $7300
.done:
	pop_wram_bank ; $7303
	pop hl ; $7308
	pop de ; $7309
	pop bc ; $730a
	pop af ; $730b
	ret ; $730c
ResetGlyphStream:
	push af ; $730d
	push hl ; $730e
	xor a ; $730f
	ld hl, wGlyphPenX ; $7310
	ld [hl+], a ; $7313
	ld [hl+], a ; $7314
	ld [hl+], a ; $7315
	ld [hl+], a ; $7316
	ld [hl+], a ; $7317
	ld [hl+], a ; $7318
	ld [hl+], a ; $7319
	ld [hl+], a ; $731a
	ld [hl], a ; $731b
	ld [wTextRowNextTile], a ; $731c
	pop hl ; $731f
	pop af ; $7320
	ret ; $7321
DrawGlyph:
	push af ; $7322
	push bc ; $7323
	push hl ; $7324
	sub $20 ; $7325
	push af ; $7327
	ld h, $00 ; $7328
	ld l, a ; $732a
	add hl, hl ; $732b
	add hl, hl ; $732c
	add hl, hl ; $732d
	add hl, hl ; $732e
	ld bc, FontGlyphs ; $732f
	add hl, bc ; $7332
	push de ; $7333
	ld c, $10 ; $7334
.rowLoop:
	ld a, [hl+] ; $7336
	call PlotGlyphRow ; $7337
	ld a, $08 ; $733a
	add e ; $733c
	ld e, a ; $733d
	jr nc, .nextRow ; $733e
	inc d ; $7340
.nextRow:
	dec c ; $7341
	jr nz, .rowLoop ; $7342
	pop de ; $7344
	pop af ; $7345
	call GetGlyphWidthByIndex ; $7346
	ld a, e ; $7349
	and $07 ; $734a
	add c ; $734c
	ld b, a ; $734d
	bit 3, a ; $734e
	jr z, .alignPen ; $7350
	ld a, $80 ; $7352
	add e ; $7354
	ld e, a ; $7355
	jr nc, .alignPen ; $7356
	inc d ; $7358
.alignPen:
	ld a, b ; $7359
	and $07 ; $735a
	ld b, a ; $735c
	ld a, e ; $735d
	and $f8 ; $735e
	or b ; $7360
	ld e, a ; $7361
	pop hl ; $7362
	pop bc ; $7363
	pop af ; $7364
	ret ; $7365
GetGlyphWidth:
	push af ; $7366
	push hl ; $7367
	sub $20 ; $7368
	call GetGlyphWidthByIndex ; $736a
	pop hl ; $736d
	pop af ; $736e
	ret ; $736f
GetGlyphWidthByIndex:
	ld hl, GlyphWidths_05 ; $7370
	add l ; $7373
	ld l, a ; $7374
	jr nc, .read ; $7375
	inc h ; $7377
.read:
	ld c, [hl] ; $7378
	ret ; $7379
