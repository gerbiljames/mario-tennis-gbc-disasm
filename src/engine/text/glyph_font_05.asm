DrawInlineGlyph:
	push af ; $7681
	push bc ; $7682
	push de ; $7683
	push hl ; $7684
	ldh a, [hWramBank] ; $7685
	push af ; $7687
	push hl ; $7688
	ld hl, wTextRowWidth ; $7689
	ld b, [hl] ; $768c
	inc hl ; $768d
	ld c, [hl] ; $768e
	ld hl, wGlyphPenX ; $768f
	ld a, [hl+] ; $7692
	ld d, [hl] ; $7693
	ld e, a ; $7694
	pop hl ; $7695
	ld a, [hl+] ; $7696
	cp $02 ; $7697
	jr z, .step3 ; $7699
	cp $03 ; $769b
	jr z, .step3 ; $769d
	cp $01 ; $769f
	jr z, .eq01 ; $76a1
	jr .drawGlyph ; $76a3
.eq01:
	ld e, $00 ; $76a5
	ld d, c ; $76a7
	sra d ; $76a8
	rr e ; $76aa
	ld a, c ; $76ac
	add b ; $76ad
	ld [wTextRowColumn], a ; $76ae
	ld [wGlyphRowStartCol], a ; $76b1
	jr .step3 ; $76b4
.drawGlyph:
	push af ; $76b6
	wram_bank WRAM_SOUND ; $76b7
	pop af ; $76bd
	call DrawGlyph ; $76be
.step3:
	ld hl, wGlyphPenX ; $76c1
	ld a, e ; $76c4
	ld [hl+], a ; $76c5
	ld [hl], d ; $76c6
	pop_wram_bank ; $76c7
	pop hl ; $76cc
	pop de ; $76cd
	pop bc ; $76ce
	pop af ; $76cf
	ret ; $76d0
Unused_05_ResetGlyphPen_1:
	push af ; $76d1
	push bc ; $76d2
	push de ; $76d3
	push hl ; $76d4
	ldh a, [hWramBank] ; $76d5
	push af ; $76d7
	xor a ; $76d8
	ld hl, wGlyphPenX ; $76d9
	ld [hl+], a ; $76dc
	ld [hl+], a ; $76dd
	ld [hl+], a ; $76de
	ld [hl+], a ; $76df
	ld [hl+], a ; $76e0
	ld [hl], a ; $76e1
	wram_bank WRAM_SOUND ; $76e2
	call ClearGlyphBuffer ; $76e8
	pop_wram_bank ; $76eb
	pop hl ; $76f0
	pop de ; $76f1
	pop bc ; $76f2
	pop af ; $76f3
	ret ; $76f4
Unused_05_ResetGlyphPen_2:
	push af ; $76f5
	push bc ; $76f6
	push de ; $76f7
	push hl ; $76f8
	ldh a, [hWramBank] ; $76f9
	push af ; $76fb
	xor a ; $76fc
	ld hl, wGlyphPenX ; $76fd
	ld [hl+], a ; $7700
	ld [hl+], a ; $7701
	ld [hl+], a ; $7702
	ld [hl+], a ; $7703
	ld a, $00 ; $7704
	ld [hl+], a ; $7706
	ld [hl+], a ; $7707
	wram_bank WRAM_SOUND ; $7708
	call ClearGlyphBuffer ; $770e
	pop_wram_bank ; $7711
	pop hl ; $7716
	pop de ; $7717
	pop bc ; $7718
	pop af ; $7719
	ret ; $771a
InitGlyphStreamAt:
	push af ; $771b
	push bc ; $771c
	push de ; $771d
	push hl ; $771e
	push_wram_bank WRAM_TEXT ; $771f
	xor a ; $7728
	ld hl, wGlyphPenX ; $7729
	ld [hl+], a ; $772c
	ld [hl+], a ; $772d
	ld [hl+], a ; $772e
	inc hl ; $772f
	inc hl ; $7730
	inc hl ; $7731
	ld [hl+], a ; $7732
	ld [hl+], a ; $7733
	ld [hl], a ; $7734
	ld [wTextRowNextTile], a ; $7735
	ld a, [wTextRowColumn] ; $7738
	ld d, a ; $773b
	ld e, c ; $773c
	ld a, [wMenuWindowId] ; $773d
	ld b, a ; $7740
	ld a, [wWindowId] ; $7741
	cp b ; $7744
	jr nz, .step ; $7745
	test_flag FLAG_TEMP_WIDE_GLYPH_STREAM ; $7747
	jr nz, .step ; $774a
	inc d ; $774c
	ld e, c ; $774d
	inc c ; $774e
.step:
	ld b, e ; $774f
	ld e, $00 ; $7750
	ld hl, wGlyphRowStartCol ; $7752
	ld [hl], d ; $7755
	inc hl ; $7756
	ld [hl], d ; $7757
	sra d ; $7758
	rr e ; $775a
	ld hl, wGlyphPenX ; $775c
	ld [hl], e ; $775f
	inc hl ; $7760
	ld [hl], d ; $7761
	ld hl, wTextRowWidth ; $7762
	ld [hl], b ; $7765
	inc hl ; $7766
	ld a, [hl] ; $7767
	add c ; $7768
	ld [hl], a ; $7769
	pop_wram_bank ; $776a
	pop hl ; $776f
	pop de ; $7770
	pop bc ; $7771
	pop af ; $7772
	ret ; $7773
SaveGlyphPenColumns:
	push af ; $7774
	push bc ; $7775
	push hl ; $7776
	ld a, [wWindowId] ; $7777
	ld b, a ; $777a
	ld a, [wMenuWindowId] ; $777b
	cp b ; $777e
	jr z, .restore ; $777f
	ld hl, wGlyphRowStartCol ; $7781
	ld a, [hl+] ; $7784
	ld b, [hl] ; $7785
	ld c, a ; $7786
	sub b ; $7787
	inc hl ; $7788
	ld [hl+], a ; $7789
	ld [hl], b ; $778a
	dec hl ; $778b
	dec hl ; $778c
	ld [hl], c ; $778d
.restore:
	pop hl ; $778e
	pop bc ; $778f
	pop af ; $7790
	ret ; $7791
UploadGlyphBuffer:
	push af ; $7792
	ldh a, [rLCDC] ; $7793
	bit 7, a ; $7795
	jr z, .lcdOff ; $7797
	call UploadGlyphBufferQueued ; $7799
	jr .done ; $779c
.lcdOff:
	call UploadGlyphBufferDMA ; $779e
.done:
	pop af ; $77a1
	ret ; $77a2
FlushGlyphRow:
	push af ; $77a3
	push bc ; $77a4
	ld a, [wGlyphWindowId] ; $77a5
	ld b, a ; $77a8
	ld a, [wDialogueWindowId] ; $77a9
	cp b ; $77ac
	jr nz, .uploadGlyphBufferQueued ; $77ad
	ld a, [wMessageSpeed] ; $77af
	bit 7, a ; $77b2
	jr nz, .uploadGlyphBufferQueued ; $77b4
	and $7f ; $77b6
	jr nz, .step2 ; $77b8
.uploadGlyphBufferQueued:
	ldh a, [rLCDC] ; $77ba
	bit 7, a ; $77bc
	jr z, .uploadGlyphBufferDMA ; $77be
	call UploadGlyphBufferQueued ; $77c0
	jr .step2 ; $77c3
.uploadGlyphBufferDMA:
	call UploadGlyphBufferDMA ; $77c5
.step2:
	ld hl, wTextRowWidth ; $77c8
	ld b, [hl] ; $77cb
	inc hl ; $77cc
	ld c, [hl] ; $77cd
	ld a, [wGlyphRowStartCol] ; $77ce
	ld [wGlyphFlushedCol], a ; $77d1
	ld a, c ; $77d4
	add b ; $77d5
	ld [hl], a ; $77d6
	ld [wGlyphRowStartCol], a ; $77d7
	pop bc ; $77da
	pop af ; $77db
	ret ; $77dc
UploadGlyphBufferQueued:
	push af ; $77dd
	push bc ; $77de
	push de ; $77df
	push hl ; $77e0
	ldh a, [hWramBank] ; $77e1
	push af ; $77e3
	set_flag FLAG_VRAM_UPDATE_BUSY ; $77e4
	wram_bank WRAM_SOUND ; $77e7
	ld a, [wKeepMatchStatsFlag] ; $77ed
	or a ; $77f0
	jr z, .zero ; $77f1
	ld b, $60 ; $77f3
	jr .step2 ; $77f5
.zero:
	ld b, $80 ; $77f7
.step2:
	ld a, [wGlyphRowStartCol] ; $77f9
	inc a ; $77fc
	cp b ; $77fd
	jr c, .countLeft ; $77fe
	ld a, b ; $7800
.countLeft:
	ld b, $00 ; $7801
.loop:
	inc b ; $7803
	sub $12 ; $7804
	jr c, .carry ; $7806
	jr .loop ; $7808
.carry:
	push bc ; $780a
	ld hl, $0000 ; $780b
	ld b, h ; $780e
	ld c, l ; $780f
	ld de, vTiles1 ; $7810
	add hl, de ; $7813
	push_wram_bank WRAM_TEXT ; $7814
	ld a, [wWindowTileAttr] ; $781d
	bit 3, a ; $7820
	jr z, .restore ; $7822
	ld de, $2000 ; $7824
	add hl, de ; $7827
.restore:
	pop_wram_bank ; $7828
	push hl ; $782d
	ld h, b ; $782e
	ld l, c ; $782f
	ld de, wGlyphTileBuffer ; $7830
	add hl, de ; $7833
	pop de ; $7834
	pop bc ; $7835
	ld c, $12 ; $7836
.loopB:
	push bc ; $7838
	push hl ; $7839
	push de ; $783a
	call QueueVRAMCopy ; $783b
	ld bc, $0120 ; $783e
	pop hl ; $7841
	add hl, bc ; $7842
	ld d, h ; $7843
	ld e, l ; $7844
	pop hl ; $7845
	add hl, bc ; $7846
	pop bc ; $7847
	ld a, [wLinkSessionActive] ; $7848
	or a ; $784b
	jr nz, .stepMatchFrame ; $784c
	call AdvanceFrame ; $784e
	jr .next ; $7851
.stepMatchFrame:
	farcall StepMatchFrame ; $7853
.next:
	dec b ; $7856
	jr nz, .loopB ; $7857
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7859
	pop_wram_bank ; $785c
	pop hl ; $7861
	pop de ; $7862
	pop bc ; $7863
	pop af ; $7864
	ret ; $7865
UploadGlyphBufferDMA:
	push af ; $7866
	push bc ; $7867
	push de ; $7868
	push hl ; $7869
	ldh a, [hWramBank] ; $786a
	push af ; $786c
	ld a, [wGlyphRowStartCol] ; $786d
	inc a ; $7870
	ld b, a ; $7871
	wram_bank WRAM_SOUND ; $7872
	ld a, b ; $7878
	ld b, $00 ; $7879
.loop:
	inc b ; $787b
	sub $20 ; $787c
	jr z, .step ; $787e
	jr c, .step ; $7880
	jr .loop ; $7882
.step:
	ld hl, wGlyphTileBuffer ; $7884
	ld de, vTiles1 ; $7887
	ld c, $20 ; $788a
.loopB:
	push bc ; $788c
	push hl ; $788d
	push de ; $788e
	ld a, $00 ; $788f
	ldh [rVBK], a ; $7891
	call StartVRAMDMAFromHL ; $7893
	ld bc, $0200 ; $7896
	pop hl ; $7899
	add hl, bc ; $789a
	ld d, h ; $789b
	ld e, l ; $789c
	pop hl ; $789d
	add hl, bc ; $789e
	pop bc ; $789f
	dec b ; $78a0
	jr nz, .loopB ; $78a1
	pop_wram_bank ; $78a3
	pop hl ; $78a8
	pop de ; $78a9
	pop bc ; $78aa
	pop af ; $78ab
	ret ; $78ac
Unused_05_UploadGlyphTileRange:
	push bc ; $78ad
	push de ; $78ae
	push hl ; $78af
	push_wram_bank WRAM_SOUND ; $78b0
	ld a, [wGlyphUploadFirstTile] ; $78b9
	ld l, a ; $78bc
	ld h, $00 ; $78bd
	add hl, hl ; $78bf
	add hl, hl ; $78c0
	add hl, hl ; $78c1
	add hl, hl ; $78c2
	ld b, h ; $78c3
	ld c, l ; $78c4
	ld de, vTiles1 ; $78c5
	add hl, de ; $78c8
	ld a, [wGlyphUploadVramBank] ; $78c9
	or a ; $78cc
	jr z, .zero ; $78cd
	ld de, $2000 ; $78cf
	add hl, de ; $78d2
.zero:
	push hl ; $78d3
	ld h, b ; $78d4
	ld l, c ; $78d5
	ld de, wGlyphTileBuffer ; $78d6
	add hl, de ; $78d9
	pop de ; $78da
	ld a, [wGlyphUploadCount] ; $78db
	cp $20 ; $78de
	jr c, .lt20 ; $78e0
	ld a, $20 ; $78e2
.lt20:
	ld c, a ; $78e4
	call QueueVRAMCopy ; $78e5
	ld b, a ; $78e8
	pop_wram_bank ; $78e9
	ld a, b ; $78ee
	pop hl ; $78ef
	pop de ; $78f0
	pop bc ; $78f1
	ret ; $78f2
Unused_05_DrawGlyphString:
	push af ; $78f3
	push bc ; $78f4
	push de ; $78f5
	push hl ; $78f6
	ld a, d ; $78f7
	and $0f ; $78f8
	ld d, a ; $78fa
	sla e ; $78fb
	rl d ; $78fd
	sla e ; $78ff
	rl d ; $7901
	sla e ; $7903
	rl d ; $7905
.loop:
	ld a, [hl+] ; $7907
	cp $00 ; $7908
	jr z, .restore ; $790a
	call DrawGlyph ; $790c
	jr .loop ; $790f
.restore:
	pop hl ; $7911
	pop de ; $7912
	pop bc ; $7913
	pop af ; $7914
	ret ; $7915
	; $7916, 10 bytes (fill)
	ds 10, $00
	ds ALIGN[4]
FontGlyphs:
	INCBIN "data/bank_005/FontGlyphs.bin" ; $7920, 1632 bytes
GlyphWidths_05:
	; $7f80, 96 bytes (bytes:16)
	db $05, $04, $06, $06, $06, $06, $07, $04, $04, $04, $06, $06, $04, $06, $04, $06 ; 0x00
	db $06, $04, $06, $06, $06, $06, $06, $06, $06, $06, $04, $04, $05, $06, $05, $06 ; 0x10
	db $08, $06, $06, $06, $06, $06, $06, $06, $06, $04, $05, $06, $06, $08, $06, $07 ; 0x20
	db $06, $07, $06, $06, $06, $06, $06, $08, $06, $06, $06, $04, $06, $04, $06, $06 ; 0x30
	db $05, $07, $06, $06, $06, $06, $04, $06, $06, $03, $04, $06, $04, $08, $06, $06 ; 0x40
	db $06, $06, $05, $06, $04, $06, $06, $08, $06, $06, $06, $05, $05, $05, $05, $05 ; 0x50
	; $7fe0, 32 bytes fill to bank end (linker-padded)
