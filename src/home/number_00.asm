NumberFontGlyph_0:
	; $1ff7, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $da, $73, $fc ; #+oo+# .####.
NumberFontGlyph_1:
	; $2005, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $0f, $c3, $6c ; ..###. .#+o#.
	db $3a, $c3, $ec ; .#oo#. .##o#.
	db $0e, $c3, $ef ; ..#o#. .##o##
	db $3a, $b3, $ff ; .#ooo# .#####
NumberFontGlyph_2:
	; $2013, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $bf, $db ; #o##o# ###+o#
	db $da, $7e, $7f ; #+oo+# #o+###
	db $ea, $bf, $ff ; #oooo# ######
NumberFontGlyph_3:
	; $2021, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $ff, $ce, $a7 ; #####. #ooo+#
	db $ff, $b3, $a7 ; ####o# .#oo+#
	db $3f, $bf, $fb ; .###o# ####o#
	db $ea, $7f, $fc ; #ooo+# #####.
NumberFontGlyph_4:
	; $202f, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $0f, $c3, $6c ; ..###. .#+o#.
	db $da, $ce, $ec ; #+oo#. #o#o#.
	db $ee, $fe, $ab ; #o#o## #oooo#
	db $fe, $f0, $fc ; ###o## ..###.
NumberFontGlyph_5:
	; $203d, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $ff, $fe, $ab ; ###### #oooo#
	db $ef, $fe, $a7 ; #o#### #ooo+#
	db $ff, $be, $fb ; ####o# #o##o#
	db $da, $73, $fc ; #+oo+# .####.
NumberFontGlyph_6:
	; $204b, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $fe, $a7 ; #o#### #ooo+#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $da, $73, $fc ; #+oo+# .####.
NumberFontGlyph_7:
	; $2059, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $ff, $fe, $ab ; ###### #oooo#
	db $fd, $b3, $67 ; ###+o# .#+o+#
	db $39, $c3, $b0 ; .#o+#. .#o#..
	db $3b, $03, $f0 ; .#o#.. .###..
NumberFontGlyph_8:
	; $2067, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $bd, $a7 ; #o##o# #+oo+#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $da, $73, $fc ; #+oo+# .####.
NumberFontGlyph_9:
	; $2075, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $be, $fb ; #o##o# #o##o#
	db $da, $bf, $fb ; #+ooo# ####o#
	db $da, $73, $fc ; #+oo+# .####.
NumberFontGlyph_0a:
	; $2083, 14 bytes (font_glyph)
	db $06, $08 ; 6 x 8, 2bpp
	db $3f, $cd, $a7 ; .####. #+oo+#
	db $ef, $bf, $fb ; #o##o# ####o#
	db $0e, $70, $fc ; ..#o+# ..###.
	db $0e, $c0, $fc ; ..#o#. ..###.
NumberFontGlyphPtrs:
	; $2091, 32 bytes (records:2)
	dw NumberFontGlyph_0 ; record 0
	dw NumberFontGlyph_1 ; record 1
	dw NumberFontGlyph_2 ; record 2
	dw NumberFontGlyph_3 ; record 3
	dw NumberFontGlyph_4 ; record 4
	dw NumberFontGlyph_5 ; record 5
	dw NumberFontGlyph_6 ; record 6
	dw NumberFontGlyph_7 ; record 7
	dw NumberFontGlyph_8 ; record 8
	dw NumberFontGlyph_9 ; record 9
	dw NumberFontGlyph_0a ; record 10
	dw NumberFontGlyph_0a ; record 11
	dw NumberFontGlyph_0a ; record 12
	dw NumberFontGlyph_0a ; record 13
	dw NumberFontGlyph_0a ; record 14
	dw NumberFontGlyph_0a ; record 15
	push af ; $20b1
	push bc ; $20b2
	push de ; $20b3
	push hl ; $20b4
	add sp, -16 ; $20b5
	push de ; $20b7
	push hl ; $20b8
	ld hl, sp + 6 ; $20b9
	ld d, h ; $20bb
	ld e, l ; $20bc
	pop hl ; $20bd
	call FormatDecimalNumber ; $20be
	ld hl, sp + 4 ; $20c1
	pop de ; $20c3
	call RenderTextToTiles ; $20c4
	add sp, 16 ; $20c7
	pop hl ; $20c9
	pop de ; $20ca
	pop bc ; $20cb
	pop af ; $20cc
	ret ; $20cd
Unused_00_RenderCharToTiles:
	push af ; $20ce
	push hl ; $20cf
	sub $30 ; $20d0
	and $1f ; $20d2
	add a ; $20d4
	ld_hl_indexed NumberFontGlyphPtrs ; $20d5
	ld a, [hl+] ; $20dc
	ld h, [hl] ; $20dd
	ld l, a ; $20de
	call RenderGlyphToTiles ; $20df
	pop hl ; $20e2
	pop af ; $20e3
	ret ; $20e4
RenderTextToTiles:
	push af ; $20e5
	push bc ; $20e6
	push de ; $20e7
	push hl ; $20e8
.loop:
	ld a, [hl+] ; $20e9
	and a ; $20ea
	jr z, .restore ; $20eb
	sub $30 ; $20ed
	jr nc, .noCarry ; $20ef
	ld a, b ; $20f1
	add $06 ; $20f2
	ld b, a ; $20f4
	jr .loop ; $20f5
.noCarry:
	push hl ; $20f7
	and $1f ; $20f8
	add a ; $20fa
	ld_hl_indexed NumberFontGlyphPtrs ; $20fb
	ld a, [hl+] ; $2102
	ld h, [hl] ; $2103
	ld l, a ; $2104
	call RenderGlyphToTiles ; $2105
	ld a, [hl] ; $2108
	add b ; $2109
	ld b, a ; $210a
	pop hl ; $210b
	jr .loop ; $210c
.restore:
	pop hl ; $210e
	pop de ; $210f
	pop bc ; $2110
	pop af ; $2111
	ret ; $2112
PixelMaskTable:
	; $2113, 8 bytes (bytes:8)
	db $80, $40, $20, $10, $08, $04, $02, $01 ; 0x00
RenderGlyphToTiles:
	push af ; $211b
	push bc ; $211c
	push de ; $211d
	push hl ; $211e
	ld a, [hl+] ; $211f
	ld [wGlyphBlitWidth], a ; $2120
	ld a, [hl+] ; $2123
	ld [wGlyphBlitRowsLeft], a ; $2124
	push hl ; $2127
	ld a, b ; $2128
	and $07 ; $2129
	ld_hl_indexed PixelMaskTable ; $212b
	ld a, [hl] ; $2132
	ld [wGlyphBlitDestMask], a ; $2133
	ld a, b ; $2136
	and $f8 ; $2137
	ld l, a ; $2139
	ld h, $00 ; $213a
	add hl, hl ; $213c
	add hl, hl ; $213d
	ld b, $00 ; $213e
	sla c ; $2140
	add hl, bc ; $2142
	add hl, de ; $2143
	pop de ; $2144
	ld c, $80 ; $2145
.loop:
	push hl ; $2147
	ld a, [wGlyphBlitDestMask] ; $2148
	ld b, a ; $214b
	ld a, [wGlyphBlitWidth] ; $214c
.loopB:
	push af ; $214f
	ld a, [de] ; $2150
	and c ; $2151
	jr z, .clearPixel ; $2152
	ld a, b ; $2154
	or [hl] ; $2155
	jr .store ; $2156
.clearPixel:
	ld a, b ; $2158
	cpl ; $2159
	and [hl] ; $215a
.store:
	ld [hl+], a ; $215b
	rrc c ; $215c
	ld a, [de] ; $215e
	and c ; $215f
	jr z, .clearPixel2 ; $2160
	ld a, b ; $2162
	or [hl] ; $2163
	jr .store2 ; $2164
.clearPixel2:
	ld a, b ; $2166
	cpl ; $2167
	and [hl] ; $2168
.store2:
	ld [hl-], a ; $2169
	rrc c ; $216a
	jr nc, .nextBit ; $216c
	inc de ; $216e
.nextBit:
	rrc b ; $216f
	jr nc, .restore ; $2171
	ld a, $20 ; $2173
	add l ; $2175
	ld l, a ; $2176
	jr nc, .restore ; $2177
	inc h ; $2179
.restore:
	pop af ; $217a
	dec a ; $217b
	jp nz, .loopB ; $217c
	ld hl, wGlyphBlitRowsLeft ; $217f
	dec [hl] ; $2182
	pop hl ; $2183
	inc hl ; $2184
	inc hl ; $2185
	jr nz, .loop ; $2186
	pop hl ; $2188
	pop de ; $2189
	pop bc ; $218a
	pop af ; $218b
	ret ; $218c
ProcessBGBlitQueue:
	xor a ; $218d
	ldh [hBGColumnBlitDone], a ; $218e
	ldh a, [hBGRowBlitPending] ; $2190
	or a ; $2192
	jr z, .zero ; $2193
	ld a, $01 ; $2195
	ldh [rVBK], a ; $2197
	ld bc, wBGRowBlitAttrs ; $2199
	ld hl, wBGRowBlitDest ; $219c
	ld a, [hl+] ; $219f
	ld d, [hl] ; $21a0
	ld e, a ; $21a1
	ld a, $01 ; $21a2
	ld hl, rVDMA_SRC_HIGH ; $21a4
	ld [hl], b ; $21a7
	inc hl ; $21a8
	ld [hl], c ; $21a9
	inc hl ; $21aa
	ld [hl], d ; $21ab
	inc hl ; $21ac
	ld [hl], e ; $21ad
	inc hl ; $21ae
	ld [hl], a ; $21af
	xor a ; $21b0
	ldh [rVBK], a ; $21b1
	ld bc, wBGRowBlitTiles ; $21b3
	ld hl, wBGRowBlitDest ; $21b6
	ld a, [hl+] ; $21b9
	ld d, [hl] ; $21ba
	ld e, a ; $21bb
	ld a, $01 ; $21bc
	ld hl, rVDMA_SRC_HIGH ; $21be
	ld [hl], b ; $21c1
	inc hl ; $21c2
	ld [hl], c ; $21c3
	inc hl ; $21c4
	ld [hl], d ; $21c5
	inc hl ; $21c6
	ld [hl], e ; $21c7
	inc hl ; $21c8
	ld [hl], a ; $21c9
.zero:
	ldh a, [hBGColumnBlitPending] ; $21ca
	or a ; $21cc
	jr z, .zero2 ; $21cd
	ld a, $01 ; $21cf
	ldh [hBGColumnBlitDone], a ; $21d1
	ldh [rVBK], a ; $21d3
	ld de, wBGColumnBlitAttrs ; $21d5
	ld a, [wBGColumnBlitX] ; $21d8
	ld l, a ; $21db
	ld h, $98 ; $21dc
	ld b, $20 ; $21de
.loop:
	ld a, [de] ; $21e0
	inc de ; $21e1
	ld [hl], a ; $21e2
	ld a, b ; $21e3
	ld bc, $0020 ; $21e4
	add hl, bc ; $21e7
	ld b, a ; $21e8
	dec b ; $21e9
	jr nz, .loop ; $21ea
	xor a ; $21ec
	ldh [rVBK], a ; $21ed
	ld de, wBGColumnBlitTiles ; $21ef
	ld a, [wBGColumnBlitX] ; $21f2
	ld l, a ; $21f5
	ld h, $98 ; $21f6
	ld b, $20 ; $21f8
.loopB:
	ld a, [de] ; $21fa
	inc de ; $21fb
	ld [hl], a ; $21fc
	ld a, b ; $21fd
	ld bc, $0020 ; $21fe
	add hl, bc ; $2201
	ld b, a ; $2202
	dec b ; $2203
	jr nz, .loopB ; $2204
.zero2:
	xor a ; $2206
	ldh [hBGRowBlitPending], a ; $2207
	ldh [hBGColumnBlitPending], a ; $2209
	ldh a, [hBGColumnBlitDone] ; $220b
	ret ; $220d
GetMapBufferAddr64:
	ld a, [wCameraY + 1] ; $220e
	add c ; $2211
	and $3f ; $2212
	ld h, $00 ; $2214
	ld l, a ; $2216
	add hl, hl ; $2217
	add hl, hl ; $2218
	add hl, hl ; $2219
	add hl, hl ; $221a
	add hl, hl ; $221b
	add hl, hl ; $221c
	ld a, [wCameraX + 1] ; $221d
	add b ; $2220
	and $3f ; $2221
	ld d, $00 ; $2223
	ld e, a ; $2225
	add hl, de ; $2226
	ld de, wMapBuffer64 ; $2227
	add hl, de ; $222a
	ret ; $222b
BlitBGRowFrom64:
	ld a, [wCameraY + 1] ; $222c
	add c ; $222f
	and $1f ; $2230
	ld h, $00 ; $2232
	ld l, a ; $2234
	add hl, hl ; $2235
	add hl, hl ; $2236
	add hl, hl ; $2237
	add hl, hl ; $2238
	add hl, hl ; $2239
	ld de, $9800 ; $223a
	add hl, de ; $223d
	ld a, l ; $223e
	ld [wBGRowBlitDest], a ; $223f
	ld a, h ; $2242
	ld [wBGRowBlitDest + 1], a ; $2243
	ld a, [wCameraX + 1] ; $2246
	add b ; $2249
	and $1f ; $224a
	ld h, $00 ; $224c
	ld l, a ; $224e
	ld de, wBGRowBlitAttrs ; $224f
	add hl, de ; $2252
	push hl ; $2253
	call GetMapBufferAddr64 ; $2254
	pop de ; $2257
	push hl ; $2258
	wram_bank WRAM_COURT_PLANES ; $2259
	ld c, $20 ; $225f
.copyLoop:
	ld a, [hl+] ; $2261
	ld [de], a ; $2262
	ld a, l ; $2263
	and $3f ; $2264
	jr nz, .nextCell ; $2266
	ld a, c ; $2268
	ld bc, $ffc0 ; $2269
	add hl, bc ; $226c
	ld c, a ; $226d
.nextCell:
	inc e ; $226e
	res 5, e ; $226f
	dec c ; $2271
	jr nz, .copyLoop ; $2272
	pop hl ; $2274
	wram_bank WRAM_SCREEN ; $2275
	ld bc, $4020 ; $227b
	ld a, e ; $227e
	add b ; $227f
	ld e, a ; $2280
.secondHalf:
	ld a, [hl+] ; $2281
	ld [de], a ; $2282
	ld a, l ; $2283
	and $3f ; $2284
	jr nz, .nextCell2 ; $2286
	ld a, c ; $2288
	ld bc, $ffc0 ; $2289
	add hl, bc ; $228c
	ld c, a ; $228d
.nextCell2:
	inc e ; $228e
	res 5, e ; $228f
	dec c ; $2291
	jr nz, .secondHalf ; $2292
	ld a, $01 ; $2294
	ldh [hBGRowBlitPending], a ; $2296
	ret ; $2298
BlitBGColumnFrom64:
	ld a, [wCameraX + 1] ; $2299
	add b ; $229c
	and $1f ; $229d
	ld [wBGColumnBlitX], a ; $229f
	ld d, $00 ; $22a2
	ld e, a ; $22a4
	ld a, [wCameraY + 1] ; $22a5
	add c ; $22a8
	and $1f ; $22a9
	ld h, $00 ; $22ab
	ld l, a ; $22ad
	ld de, wBGColumnBlitAttrs ; $22ae
	add hl, de ; $22b1
	push hl ; $22b2
	call GetMapBufferAddr64 ; $22b3
	pop de ; $22b6
	push hl ; $22b7
	wram_bank WRAM_COURT_PLANES ; $22b8
	ld c, $20 ; $22be
.copyLoop:
	ld a, [hl] ; $22c0
	ld [de], a ; $22c1
	ld a, c ; $22c2
	ld bc, $0040 ; $22c3
	add hl, bc ; $22c6
	ld c, a ; $22c7
	res 5, h ; $22c8
	set 4, h ; $22ca
	inc e ; $22cc
	res 5, e ; $22cd
	dec c ; $22cf
	jr nz, .copyLoop ; $22d0
	pop hl ; $22d2
	wram_bank WRAM_SCREEN ; $22d3
	ld bc, $4020 ; $22d9
	ld a, e ; $22dc
	add b ; $22dd
	ld e, a ; $22de
.secondHalf:
	ld a, [hl] ; $22df
	ld [de], a ; $22e0
	ld a, c ; $22e1
	ld bc, $0040 ; $22e2
	add hl, bc ; $22e5
	ld c, a ; $22e6
	res 5, h ; $22e7
	set 4, h ; $22e9
	inc e ; $22eb
	res 5, e ; $22ec
	dec c ; $22ee
	jr nz, .secondHalf ; $22ef
	ld a, $01 ; $22f1
	ldh [hBGColumnBlitPending], a ; $22f3
	ret ; $22f5
