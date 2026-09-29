InitGrayscalePaletteFade:
	push_wram_bank WRAM_SCENE ; $75ab
	xor a ; $75b4
	ld hl, wPaletteFadeMask ; $75b5
	ld b, $10 ; $75b8
.loop:
	ld [hl+], a ; $75ba
	dec b ; $75bb
	jr nz, .loop ; $75bc
	call CopyMasterPalettesToFadeBuffers ; $75be
	call DesaturateFadeTargetPalettes ; $75c1
	pop_wram_bank ; $75c4
	ret ; $75c9
; InitGrayscalePaletteFade with Unused_03_ClearFadeTargetPalettes in place of DesaturateFadeTargetPalettes: the fade-to-black variant of the same setup. Nothing calls it; bank $03's callers only use the grayscale one.
Unused_03_InitBlackPaletteFade:
	push_wram_bank WRAM_SCENE ; $75ca
	xor a ; $75d3
	ld hl, wPaletteFadeMask ; $75d4
	ld b, $10 ; $75d7
.loopB:
	ld [hl+], a ; $75d9
	dec b ; $75da
	jr nz, .loopB ; $75db
	call CopyMasterPalettesToFadeBuffers ; $75dd
	call Unused_03_ClearFadeTargetPalettes ; $75e0
	pop_wram_bank ; $75e3
	ret ; $75e8
CopyMasterPalettesToFadeBuffers:
	ld hl, wMasterPalettes ; $75e9
	ld de, wPaletteFadeLive ; $75ec
	ld b, $80 ; $75ef
.loop:
	ld a, [hl+] ; $75f1
	ld [de], a ; $75f2
	inc de ; $75f3
	dec b ; $75f4
	jr nz, .loop ; $75f5
	ld hl, wMasterPalettes ; $75f7
	ld de, wPaletteFadeTarget ; $75fa
	ld b, $80 ; $75fd
.loopB:
	ld a, [hl+] ; $75ff
	ld [de], a ; $7600
	inc de ; $7601
	dec b ; $7602
	jr nz, .loopB ; $7603
	ret ; $7605
Unused_03_ClearFadeTargetPalettes:
	ld hl, wPaletteFadeTarget ; $7606
	ld b, $40 ; $7609
	ld de, $0000 ; $760b
.loop:
	ld a, e ; $760e
	ld [hl+], a ; $760f
	ld [hl], d ; $7610
	inc hl ; $7611
	dec b ; $7612
	jr nz, .loop ; $7613
	ret ; $7615
DesaturateFadeTargetPalettes:
	ld hl, wPaletteFadeTarget ; $7616
	ld de, wPaletteColorSplit ; $7619
	ld b, $40 ; $761c
.loop:
	push bc ; $761e
	push hl ; $761f
	ld a, [hl+] ; $7620
	ld b, [hl] ; $7621
	ld c, a ; $7622
	call SplitColorComponents ; $7623
	ld [de], a ; $7626
	inc de ; $7627
	ld a, b ; $7628
	ld [de], a ; $7629
	inc de ; $762a
	ld a, c ; $762b
	ld [de], a ; $762c
	dec de ; $762d
	dec de ; $762e
	call ComputeGrayscaleColor ; $762f
	inc de ; $7632
	inc de ; $7633
	ld a, [de] ; $7634
	ld c, a ; $7635
	dec de ; $7636
	ld a, [de] ; $7637
	ld b, a ; $7638
	dec de ; $7639
	ld a, [de] ; $763a
	call CombineColorComponents ; $763b
	pop hl ; $763e
	ld a, c ; $763f
	ld [hl+], a ; $7640
	ld [hl], b ; $7641
	inc hl ; $7642
	pop bc ; $7643
	dec b ; $7644
	jr nz, .loop ; $7645
	ret ; $7647
ComputeGrayscaleColor:
	ld a, [de] ; $7648
	inc de ; $7649
	ld c, a ; $764a
	ld a, [de] ; $764b
	inc de ; $764c
	add c ; $764d
	ld c, a ; $764e
	ld a, [de] ; $764f
	add c ; $7650
	ld c, a ; $7651
	ld b, $00 ; $7652
	srl a ; $7654
	srl a ; $7656
	srl a ; $7658
	ld [de], a ; $765a
	dec de ; $765b
	ld h, b ; $765c
	ld l, c ; $765d
	add hl, hl ; $765e
	srl h ; $765f
	rr l ; $7661
	srl h ; $7663
	rr l ; $7665
	srl h ; $7667
	rr l ; $7669
	ld a, l ; $766b
	ld [de], a ; $766c
	dec de ; $766d
	ld h, b ; $766e
	ld l, c ; $766f
	add hl, hl ; $7670
	add hl, hl ; $7671
	srl h ; $7672
	rr l ; $7674
	srl h ; $7676
	rr l ; $7678
	srl h ; $767a
	rr l ; $767c
	ld a, l ; $767e
	bit 5, a ; $767f
	jr z, .store ; $7681
	ld a, $1f ; $7683
.store:
	ld [de], a ; $7685
	ret ; $7686
SetupPaletteFadeMask:
	push_wram_bank WRAM_SCENE ; $7687
	ld hl, wPaletteFadeAmount ; $7690
	ld [hl], d ; $7693
	ld l, d ; $7694
	ld h, $00 ; $7695
	ld de, $001f ; $7697
	call DivHLByDE ; $769a
	ld a, l ; $769d
	ld [wPaletteFadeFrameDelay], a ; $769e
	ld hl, wPaletteFadeMask ; $76a1
	bit 7, b ; $76a4
	jr z, .positive ; $76a6
	ld [hl], $01 ; $76a8
.positive:
	inc hl ; $76aa
	bit 6, b ; $76ab
	jr z, .bit6Clear ; $76ad
	ld [hl], $01 ; $76af
.bit6Clear:
	inc hl ; $76b1
	bit 5, b ; $76b2
	jr z, .bit5Clear ; $76b4
	ld [hl], $01 ; $76b6
.bit5Clear:
	inc hl ; $76b8
	bit 4, b ; $76b9
	jr z, .bit4Clear ; $76bb
	ld [hl], $01 ; $76bd
.bit4Clear:
	inc hl ; $76bf
	bit 3, b ; $76c0
	jr z, .bit3Clear ; $76c2
	ld [hl], $01 ; $76c4
.bit3Clear:
	inc hl ; $76c6
	bit 2, b ; $76c7
	jr z, .bit2Clear ; $76c9
	ld [hl], $01 ; $76cb
.bit2Clear:
	inc hl ; $76cd
	bit 1, b ; $76ce
	jr z, .bit1Clear ; $76d0
	ld [hl], $01 ; $76d2
.bit1Clear:
	inc hl ; $76d4
	bit 0, b ; $76d5
	jr z, .bit0Clear ; $76d7
	ld [hl], $01 ; $76d9
.bit0Clear:
	inc hl ; $76db
	bit 7, c ; $76dc
	jr z, .positive2 ; $76de
	ld [hl], $01 ; $76e0
.positive2:
	inc hl ; $76e2
	bit 6, c ; $76e3
	jr z, .bit6Clear2 ; $76e5
	ld [hl], $01 ; $76e7
.bit6Clear2:
	inc hl ; $76e9
	bit 5, c ; $76ea
	jr z, .bit5Clear2 ; $76ec
	ld [hl], $01 ; $76ee
.bit5Clear2:
	inc hl ; $76f0
	bit 4, c ; $76f1
	jr z, .bit4Clear2 ; $76f3
	ld [hl], $01 ; $76f5
.bit4Clear2:
	inc hl ; $76f7
	bit 3, c ; $76f8
	jr z, .bit3Clear2 ; $76fa
	ld [hl], $01 ; $76fc
.bit3Clear2:
	inc hl ; $76fe
	bit 2, c ; $76ff
	jr z, .bit2Clear2 ; $7701
	ld [hl], $01 ; $7703
.bit2Clear2:
	inc hl ; $7705
	bit 1, c ; $7706
	jr z, .bit1Clear2 ; $7708
	ld [hl], $01 ; $770a
.bit1Clear2:
	inc hl ; $770c
	bit 0, c ; $770d
	jr z, .restore ; $770f
	ld [hl], $01 ; $7711
.restore:
	pop_wram_bank ; $7713
	ret ; $7718
AnimatePaletteFadeToTarget:
	push_wram_bank WRAM_SCENE ; $7719
.loop:
	ld a, [wPaletteFadeFrameDelay] ; $7722
.loopB:
	and a ; $7725
	jr z, .zero ; $7726
	call AdvanceFrame ; $7728
	dec a ; $772b
	jr .loopB ; $772c
.zero:
	ld de, wPaletteFadeMask ; $772e
	ld b, $00 ; $7731
.loop2:
	push de ; $7733
	push bc ; $7734
	ld a, [de] ; $7735
	and a ; $7736
	jr z, .restore ; $7737
	call StepPaletteColorsTowardTarget ; $7739
.restore:
	pop bc ; $773c
	pop de ; $773d
	inc de ; $773e
	inc b ; $773f
	ld a, b ; $7740
	cp $10 ; $7741
	jr nz, .loop2 ; $7743
	ld hl, wPaletteFadeLive ; $7745
	ld d, $00 ; $7748
	ld e, $10 ; $774a
	call LoadPalettesImmediate ; $774c
	call AdvanceFrame ; $774f
	ld hl, wPaletteFadeAmount ; $7752
	ld a, [hl] ; $7755
	dec a ; $7756
	ld [hl], a ; $7757
	and a ; $7758
	jr nz, .loop ; $7759
	call SnapPalettesToTarget ; $775b
	pop_wram_bank ; $775e
	ret ; $7763
StepPaletteColorsTowardTarget:
	ld a, b ; $7764
	ld [wPaletteFadeIndex], a ; $7765
	ld hl, wPaletteFadeTarget ; $7768
	call AdvanceToPaletteEntry ; $776b
	ld d, h ; $776e
	ld e, l ; $776f
	ld hl, wPaletteFadeLive ; $7770
	ld a, [wPaletteFadeIndex] ; $7773
	ld b, a ; $7776
	call AdvanceToPaletteEntry ; $7777
	ld b, $04 ; $777a
.loop:
	push bc ; $777c
	push de ; $777d
	push hl ; $777e
	ld a, [hl+] ; $777f
	ld b, [hl] ; $7780
	ld c, a ; $7781
	call SplitColorComponents ; $7782
	ld hl, wPaletteColorSplit ; $7785
	ld [hl+], a ; $7788
	ld a, b ; $7789
	ld [hl+], a ; $778a
	ld a, c ; $778b
	ld [hl], a ; $778c
	ld h, d ; $778d
	ld l, e ; $778e
	ld a, [hl+] ; $778f
	ld b, [hl] ; $7790
	ld c, a ; $7791
	call SplitColorComponents ; $7792
	ld hl, wPaletteColorSplit + 3 ; $7795
	ld [hl+], a ; $7798
	ld a, b ; $7799
	ld [hl+], a ; $779a
	ld a, c ; $779b
	ld [hl], a ; $779c
	ld hl, wPaletteColorSplit ; $779d
	ld de, wPaletteColorSplit + 3 ; $77a0
	call StepColorComponentTowardTarget ; $77a3
	ld hl, wPaletteColorSplit + 1 ; $77a6
	ld de, wPaletteColorSplit + 4 ; $77a9
	call StepColorComponentTowardTarget ; $77ac
	ld hl, wPaletteColorSplit + 2 ; $77af
	ld de, wPaletteColorSplit + 5 ; $77b2
	call StepColorComponentTowardTarget ; $77b5
	ld hl, wPaletteColorSplit + 2 ; $77b8
	ld a, [hl-] ; $77bb
	ld c, a ; $77bc
	ld a, [hl-] ; $77bd
	ld b, a ; $77be
	ld a, [hl] ; $77bf
	call CombineColorComponents ; $77c0
	pop hl ; $77c3
	ld a, c ; $77c4
	ld [hl+], a ; $77c5
	ld [hl], b ; $77c6
	inc hl ; $77c7
	pop de ; $77c8
	pop bc ; $77c9
	inc de ; $77ca
	inc de ; $77cb
	dec b ; $77cc
	jr nz, .loop ; $77cd
	ret ; $77cf
StepColorComponentTowardTarget:
	ld a, [de] ; $77d0
	ld b, [hl] ; $77d1
	sub b ; $77d2
	ret z ; $77d3
	jr c, .read ; $77d4
	ld a, [hl] ; $77d6
	inc a ; $77d7
	and $1f ; $77d8
	ld [hl], a ; $77da
	ret ; $77db
.read:
	ld a, [hl] ; $77dc
	dec a ; $77dd
	and $1f ; $77de
	ld [hl], a ; $77e0
	ret ; $77e1
SnapPalettesToTarget:
	ld hl, wPaletteFadeMask ; $77e2
	ld b, $00 ; $77e5
.loop:
	push hl ; $77e7
	push bc ; $77e8
	ld a, [hl] ; $77e9
	and a ; $77ea
	jr z, .restore ; $77eb
	ld c, b ; $77ed
	ld hl, wPaletteFadeTarget ; $77ee
	call AdvanceToPaletteEntry ; $77f1
	ld d, h ; $77f4
	ld e, l ; $77f5
	ld b, c ; $77f6
	ld hl, wPaletteFadeLive ; $77f7
	call AdvanceToPaletteEntry ; $77fa
	ld a, [de] ; $77fd
	ld [hl+], a ; $77fe
	inc de ; $77ff
	ld a, [de] ; $7800
	ld [hl+], a ; $7801
	inc de ; $7802
	ld a, [de] ; $7803
	ld [hl+], a ; $7804
	inc de ; $7805
	ld a, [de] ; $7806
	ld [hl+], a ; $7807
	inc de ; $7808
	ld a, [de] ; $7809
	ld [hl+], a ; $780a
	inc de ; $780b
	ld a, [de] ; $780c
	ld [hl+], a ; $780d
	inc de ; $780e
	ld a, [de] ; $780f
	ld [hl+], a ; $7810
	inc de ; $7811
	ld a, [de] ; $7812
	ld [hl+], a ; $7813
	inc de ; $7814
.restore:
	pop bc ; $7815
	pop hl ; $7816
	inc hl ; $7817
	inc b ; $7818
	ld a, b ; $7819
	cp $10 ; $781a
	jr nz, .loop ; $781c
	ld hl, wPaletteFadeLive ; $781e
	ld d, $00 ; $7821
	ld e, $10 ; $7823
	call LoadPalettesImmediate ; $7825
	ret ; $7828
AdvanceToPaletteEntry:
	ld a, b ; $7829
	and a ; $782a
	ret z ; $782b
	ld a, $08 ; $782c
	add l ; $782e
	ld l, a ; $782f
	jr nc, .seekLoop ; $7830
	inc h ; $7832
.seekLoop:
	dec b ; $7833
	jr AdvanceToPaletteEntry ; $7834
	; $7836, 1994 bytes fill to bank end (linker-padded)
