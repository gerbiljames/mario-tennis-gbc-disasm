LoadPalettesMasterOnly:
	ld a, e ; $05e1
	add a ; $05e2
	add a ; $05e3
	add a ; $05e4
	ld c, a ; $05e5
	ld a, d ; $05e6
	add a ; $05e7
	add a ; $05e8
	add a ; $05e9
	ld e, a ; $05ea
	ld d, $c2 ; $05eb
.copyLoop:
	ld a, [hl+] ; $05ed
	ld [de], a ; $05ee
	inc e ; $05ef
	dec c ; $05f0
	jr nz, .copyLoop ; $05f1
	ret ; $05f3
RestorePalettesFromMaster:
	push af ; $05f4
	push bc ; $05f5
	push de ; $05f6
	push hl ; $05f7
	ld hl, wMasterPalettes ; $05f8
	ld de, wBGPalettes ; $05fb
	ld c, $08 ; $05fe
	call CopyMemoryFast ; $0600
	ld hl, hPaletteDirtyFlags ; $0603
	ld [hl], $03 ; $0606
	pop hl ; $0608
	pop de ; $0609
	pop bc ; $060a
	pop af ; $060b
	ret ; $060c
ApplyPendingPaletteUpdates:
	ldh a, [hPaletteDirtyFlags] ; $060d
	rrca ; $060f
	jr nc, .checkPaletteDirtyFlags ; $0610
	ld hl, wBGPalettes ; $0612
	call LoadBGPaletteData ; $0615
.checkPaletteDirtyFlags:
	ldh a, [hPaletteDirtyFlags] ; $0618
	rrca ; $061a
	rrca ; $061b
	jr nc, .clearPaletteDirtyFlags ; $061c
	ld hl, wOBJPalettes ; $061e
	call LoadOBJPaletteData ; $0621
.clearPaletteDirtyFlags:
	xor a ; $0624
	ldh [hPaletteDirtyFlags], a ; $0625
	ret ; $0627
FarReadByte:
	push bc ; $0628
	ld b, a ; $0629
	ldh a, [hRomBank] ; $062a
	push af ; $062c
	ld a, b ; $062d
	ldh [hRomBank], a ; $062e
	ld [rROMB0], a ; $0630
	ld c, [hl] ; $0633
	pop af ; $0634
	ldh [hRomBank], a ; $0635
	ld [rROMB0], a ; $0637
	ld a, c ; $063a
	pop bc ; $063b
	ret ; $063c
FarReadWord:
	ld b, a ; $063d
	ldh a, [hRomBank] ; $063e
	push af ; $0640
	ld a, b ; $0641
	ldh [hRomBank], a ; $0642
	ld [rROMB0], a ; $0644
	ld c, [hl] ; $0647
	inc hl ; $0648
	ld b, [hl] ; $0649
	dec hl ; $064a
	pop af ; $064b
	ldh [hRomBank], a ; $064c
	ld [rROMB0], a ; $064e
	ret ; $0651
FarReadWordDI:
	di ; $0652
	ld [rROMB0], a ; $0653
	ld a, [hl+] ; $0656
	ld c, a ; $0657
	ld a, [hl-] ; $0658
	ld b, a ; $0659
	ldh a, [hRomBank] ; $065a
	ld [rROMB0], a ; $065c
	ei ; $065f
	ret ; $0660
; FarReadPtrIndexed that returns instead of tail-jumping through the entry it read. Nothing calls it.
Unused_00_ReadFarVectorEntry:
	push bc ; $0661
	ldh a, [hRomBank] ; $0662
	ld b, a ; $0664
	ld a, h ; $0665
	ldh [hRomBank], a ; $0666
	ld [rROMB0], a ; $0668
	ld c, a ; $066b
	ld h, SLOT_TABLE_PAGE ; $066c
	ld a, [hl+] ; $066e
	ld h, [hl] ; $066f
	ld l, a ; $0670
	ld a, b ; $0671
	ldh [hRomBank], a ; $0672
	ld [rROMB0], a ; $0674
	ld a, c ; $0677
	pop bc ; $0678
	ret ; $0679
FarCopyBytes:
	push bc ; $067a
	ld b, a ; $067b
	ldh a, [hRomBank] ; $067c
	ld c, a ; $067e
	ld a, b ; $067f
	ldh [hRomBank], a ; $0680
	ld [rROMB0], a ; $0682
	ld a, c ; $0685
	pop bc ; $0686
	push af ; $0687
	call CopyMemoryBC ; $0688
	pop af ; $068b
	ldh [hRomBank], a ; $068c
	ld [rROMB0], a ; $068e
	ret ; $0691
; FarCopyBytes with a push af / pop af around the banked call -- the same far-call shell aimed at DecompressData. Nothing calls it; every decompress goes through DecompressDataFromBank.
Unused_00_FarDecompressData:
	push af ; $0692
	push bc ; $0693
	ld b, a ; $0694
	ldh a, [hRomBank] ; $0695
	ld c, a ; $0697
	ld a, b ; $0698
	ldh [hRomBank], a ; $0699
	ld [rROMB0], a ; $069b
	ld a, c ; $069e
	pop bc ; $069f
	push af ; $06a0
	call DecompressData ; $06a1
	pop af ; $06a4
	ldh [hRomBank], a ; $06a5
	ld [rROMB0], a ; $06a7
	pop af ; $06aa
	ret ; $06ab
CopyOAMDMARoutineToHRAM:
	ld c, LOW(hOAMDMARoutine) ; $06ac
	ld b, $0a ; $06ae
	ld hl, OAMDMARoutine ; $06b0
.loop:
	ld a, [hl+] ; $06b3
	ldh [c], a ; $06b4
	inc c ; $06b5
	dec b ; $06b6
	jr nz, .loop ; $06b7
	ret ; $06b9
OAMDMARoutine:
	ld a, LINKMSG_NONE ; $06ba
	ldh [rDMA], a ; $06bc
	ld a, $28 ; $06be
.loopB:
	dec a ; $06c0
	jr nz, .loopB ; $06c1
	ret ; $06c3
JumpTableDispatch:
	add a ; $06c4
	pop hl ; $06c5
	add l ; $06c6
	ld l, a ; $06c7
	jr nc, .read ; $06c8
	inc h ; $06ca
.read:
	ld a, [hl+] ; $06cb
	ld h, [hl] ; $06cc
	ld l, a ; $06cd
JumpToHL:
	jp hl ; $06ce
FarDispatchIndexed:
	push af ; $06cf
	push bc ; $06d0
	ld c, a ; $06d1
	ldh a, [hRomBank] ; $06d2
	push af ; $06d4
	ld a, h ; $06d5
	ldh [hRomBank], a ; $06d6
	ld [rROMB0], a ; $06d8
	ld h, SLOT_TABLE_PAGE ; $06db
	ld a, [hl+] ; $06dd
	ld h, [hl] ; $06de
	ld l, a ; $06df
	ld a, c ; $06e0
	add a ; $06e1
	add l ; $06e2
	ld l, a ; $06e3
	ld a, h ; $06e4
	adc $00 ; $06e5
	ld h, a ; $06e7
	ld a, [hl+] ; $06e8
	ld h, [hl] ; $06e9
	ld l, a ; $06ea
	call DecompressData ; $06eb
	pop af ; $06ee
	ldh [hRomBank], a ; $06ef
	ld [rROMB0], a ; $06f1
	pop bc ; $06f4
	pop af ; $06f5
	ret ; $06f6
FarCopyIndexed:
	push af ; $06f7
	push bc ; $06f8
	push de ; $06f9
	push hl ; $06fa
	ld b, a ; $06fb
	ldh a, [hRomBank] ; $06fc
	push af ; $06fe
	ld a, h ; $06ff
	ldh [hRomBank], a ; $0700
	ld [rROMB0], a ; $0702
	ld h, SLOT_TABLE_PAGE ; $0705
	ld a, [hl+] ; $0707
	ld h, [hl] ; $0708
	ld l, a ; $0709
	ld a, b ; $070a
	add a ; $070b
	add l ; $070c
	ld l, a ; $070d
	ld a, h ; $070e
	adc $00 ; $070f
	ld h, a ; $0711
	ld a, [hl+] ; $0712
	ld h, [hl] ; $0713
	ld l, a ; $0714
.loop:
	ld a, [hl+] ; $0715
	ld [de], a ; $0716
	inc de ; $0717
	dec c ; $0718
	jr nz, .loop ; $0719
	pop af ; $071b
	ldh [hRomBank], a ; $071c
	ld [rROMB0], a ; $071e
	pop hl ; $0721
	pop de ; $0722
	pop bc ; $0723
	pop af ; $0724
	ret ; $0725
FarCallIndexed1:
	push af ; $0726
	push bc ; $0727
	push de ; $0728
	push hl ; $0729
	ld b, a ; $072a
	ldh a, [hRomBank] ; $072b
	push af ; $072d
	ld a, h ; $072e
	ldh [hRomBank], a ; $072f
	ld [rROMB0], a ; $0731
	ld h, SLOT_TABLE_PAGE ; $0734
	ld a, [hl+] ; $0736
	ld h, [hl] ; $0737
	ld l, a ; $0738
	ld a, b ; $0739
	add a ; $073a
	add l ; $073b
	ld l, a ; $073c
	ld a, h ; $073d
	adc $00 ; $073e
	ld h, a ; $0740
	ld a, [hl+] ; $0741
	ld h, [hl] ; $0742
	ld l, a ; $0743
	call QueueVRAMCopy ; $0744
	pop af ; $0747
	ldh [hRomBank], a ; $0748
	ld [rROMB0], a ; $074a
	pop hl ; $074d
	pop de ; $074e
	pop bc ; $074f
	pop af ; $0750
	ret ; $0751
FarCallIndexed2:
	push af ; $0752
	push bc ; $0753
	push de ; $0754
	push hl ; $0755
	ld b, a ; $0756
	ldh a, [hRomBank] ; $0757
	push af ; $0759
	ld a, h ; $075a
	ldh [hRomBank], a ; $075b
	ld [rROMB0], a ; $075d
	ld h, SLOT_TABLE_PAGE ; $0760
	ld a, [hl+] ; $0762
	ld h, [hl] ; $0763
	ld l, a ; $0764
	ld a, b ; $0765
	add a ; $0766
	add l ; $0767
	ld l, a ; $0768
	ld a, h ; $0769
	adc $00 ; $076a
	ld h, a ; $076c
	ld a, [hl+] ; $076d
	ld h, [hl] ; $076e
	ld l, a ; $076f
	call StartVRAMDMAFromHL ; $0770
	pop af ; $0773
	ldh [hRomBank], a ; $0774
	ld [rROMB0], a ; $0776
	pop hl ; $0779
	pop de ; $077a
	pop bc ; $077b
	pop af ; $077c
	ret ; $077d
FarCallIndexed3:
	push af ; $077e
	push bc ; $077f
	push de ; $0780
	push hl ; $0781
	ld b, a ; $0782
	ldh a, [hRomBank] ; $0783
	push af ; $0785
	ld a, h ; $0786
	ldh [hRomBank], a ; $0787
	ld [rROMB0], a ; $0789
	ld h, SLOT_TABLE_PAGE ; $078c
	ld a, [hl+] ; $078e
	ld h, [hl] ; $078f
	ld l, a ; $0790
	ld a, b ; $0791
	add a ; $0792
	add l ; $0793
	ld l, a ; $0794
	ld a, h ; $0795
	adc $00 ; $0796
	ld h, a ; $0798
	ld a, [hl+] ; $0799
	ld h, [hl] ; $079a
	ld l, a ; $079b
	call CopyMemoryFast ; $079c
	pop af ; $079f
	ldh [hRomBank], a ; $07a0
	ld [rROMB0], a ; $07a2
	pop hl ; $07a5
	pop de ; $07a6
	pop bc ; $07a7
	pop af ; $07a8
	ret ; $07a9
FarReadPtrIndexed:
	push bc ; $07aa
	ldh a, [hRomBank] ; $07ab
	ld b, a ; $07ad
	ld a, h ; $07ae
	ldh [hRomBank], a ; $07af
	ld [rROMB0], a ; $07b1
	ld c, a ; $07b4
	ld h, SLOT_TABLE_PAGE ; $07b5
	ld a, [hl+] ; $07b7
	ld h, [hl] ; $07b8
	ld l, a ; $07b9
	ld a, b ; $07ba
	ldh [hRomBank], a ; $07bb
	ld [rROMB0], a ; $07bd
	ld a, c ; $07c0
	pop bc ; $07c1
	jp CallHLInBankA ; $07c2
FarCallVector:
	ldh a, [hRomBank] ; $07c5
	push af ; $07c7
	ld a, h ; $07c8
	ldh [hRomBank], a ; $07c9
	ld [rROMB0], a ; $07cb
	ld h, SLOT_TABLE_PAGE ; $07ce
	ld a, [hl+] ; $07d0
	ld h, [hl] ; $07d1
	ld l, a ; $07d2
	call JumpToHL ; $07d3
	pop af ; $07d6
	ldh [hRomBank], a ; $07d7
	ld [rROMB0], a ; $07d9
	ret ; $07dc
CopyMapRows32To64:
	ld c, $10 ; $07dd
.copyLoop:
	ld a, [hl+] ; $07df
	ld [de], a ; $07e0
	inc de ; $07e1
	ld a, [hl+] ; $07e2
	ld [de], a ; $07e3
	inc de ; $07e4
	ld a, [hl+] ; $07e5
	ld [de], a ; $07e6
	inc de ; $07e7
	ld a, [hl+] ; $07e8
	ld [de], a ; $07e9
	inc de ; $07ea
	ld a, [hl+] ; $07eb
	ld [de], a ; $07ec
	inc de ; $07ed
	ld a, [hl+] ; $07ee
	ld [de], a ; $07ef
	inc de ; $07f0
	ld a, [hl+] ; $07f1
	ld [de], a ; $07f2
	inc de ; $07f3
	ld a, [hl+] ; $07f4
	ld [de], a ; $07f5
	inc de ; $07f6
	ld a, [hl+] ; $07f7
	ld [de], a ; $07f8
	inc de ; $07f9
	ld a, [hl+] ; $07fa
	ld [de], a ; $07fb
	inc de ; $07fc
	ld a, [hl+] ; $07fd
	ld [de], a ; $07fe
	inc de ; $07ff
	ld a, [hl+] ; $0800
	ld [de], a ; $0801
	inc de ; $0802
	ld a, [hl+] ; $0803
	ld [de], a ; $0804
	inc de ; $0805
	ld a, [hl+] ; $0806
	ld [de], a ; $0807
	inc de ; $0808
	ld a, [hl+] ; $0809
	ld [de], a ; $080a
	inc de ; $080b
	ld a, [hl+] ; $080c
	ld [de], a ; $080d
	inc de ; $080e
	ld a, [hl+] ; $080f
	ld [de], a ; $0810
	inc de ; $0811
	ld a, [hl+] ; $0812
	ld [de], a ; $0813
	inc de ; $0814
	ld a, [hl+] ; $0815
	ld [de], a ; $0816
	inc de ; $0817
	ld a, [hl+] ; $0818
	ld [de], a ; $0819
	inc de ; $081a
	ld a, [hl+] ; $081b
	ld [de], a ; $081c
	inc de ; $081d
	ld a, [hl+] ; $081e
	ld [de], a ; $081f
	inc de ; $0820
	ld a, [hl+] ; $0821
	ld [de], a ; $0822
	inc de ; $0823
	ld a, [hl+] ; $0824
	ld [de], a ; $0825
	inc de ; $0826
	ld a, [hl+] ; $0827
	ld [de], a ; $0828
	inc de ; $0829
	ld a, [hl+] ; $082a
	ld [de], a ; $082b
	inc de ; $082c
	ld a, [hl+] ; $082d
	ld [de], a ; $082e
	inc de ; $082f
	ld a, [hl+] ; $0830
	ld [de], a ; $0831
	inc de ; $0832
	ld a, [hl+] ; $0833
	ld [de], a ; $0834
	inc de ; $0835
	ld a, [hl+] ; $0836
	ld [de], a ; $0837
	inc de ; $0838
	ld a, [hl+] ; $0839
	ld [de], a ; $083a
	inc de ; $083b
	ld a, [hl+] ; $083c
	ld [de], a ; $083d
	inc de ; $083e
	push hl ; $083f
	ld h, d ; $0840
	ld l, e ; $0841
	xor a ; $0842
	ld [hl+], a ; $0843
	ld [hl+], a ; $0844
	ld [hl+], a ; $0845
	ld [hl+], a ; $0846
	ld [hl+], a ; $0847
	ld [hl+], a ; $0848
	ld [hl+], a ; $0849
	ld [hl+], a ; $084a
	ld [hl+], a ; $084b
	ld [hl+], a ; $084c
	ld [hl+], a ; $084d
	ld [hl+], a ; $084e
	ld [hl+], a ; $084f
	ld [hl+], a ; $0850
	ld [hl+], a ; $0851
	ld [hl+], a ; $0852
	xor a ; $0853
	ld [hl+], a ; $0854
	ld [hl+], a ; $0855
	ld [hl+], a ; $0856
	ld [hl+], a ; $0857
	ld [hl+], a ; $0858
	ld [hl+], a ; $0859
	ld [hl+], a ; $085a
	ld [hl+], a ; $085b
	ld [hl+], a ; $085c
	ld [hl+], a ; $085d
	ld [hl+], a ; $085e
	ld [hl+], a ; $085f
	ld [hl+], a ; $0860
	ld [hl+], a ; $0861
	ld [hl+], a ; $0862
	ld [hl+], a ; $0863
	ld d, h ; $0864
	ld e, l ; $0865
	pop hl ; $0866
	dec c ; $0867
	jp nz, .copyLoop ; $0868
	ret ; $086b
CopyMapToScrollBuffers:
	push af ; $086c
	push bc ; $086d
	push de ; $086e
	push hl ; $086f
	push_wram_bank WRAM_STAGING ; $0870
	ld hl, wDecompBuffer ; $0879
	ld de, wTextBuffer ; $087c
	ld c, $20 ; $087f
	call CopyMemoryFast ; $0881
	wram_bank WRAM_COURT_PLANES ; $0884
	ld hl, wTextBuffer ; $088a
	ld de, wMapScrollPlane0 ; $088d
	call CopyMapRows32To64 ; $0890
	wram_bank WRAM_STAGING ; $0893
	ld hl, wDecompBuffer + 32 * TILE_SIZE ; $0899
	ld de, wTextBuffer ; $089c
	ld c, $20 ; $089f
	call CopyMemoryFast ; $08a1
	wram_bank WRAM_COURT_PLANES ; $08a4
	ld hl, wTextBuffer ; $08aa
	ld de, wMapScrollPlane1 ; $08ad
	call CopyMapRows32To64 ; $08b0
	ld hl, wMapScrollPlane1 ; $08b3
	ld c, $80 ; $08b6
	call ClearMemory16 ; $08b8
	wram_bank WRAM_STAGING ; $08bb
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $08c1
	ld de, wTextBuffer ; $08c4
	ld c, $20 ; $08c7
	call CopyMemoryFast ; $08c9
	wram_bank WRAM_SCREEN ; $08cc
	ld hl, wTextBuffer ; $08d2
	ld de, wShadowTilemap ; $08d5
	call CopyMapRows32To64 ; $08d8
	wram_bank WRAM_STAGING ; $08db
	ld hl, wDecompBuffer + 96 * TILE_SIZE ; $08e1
	ld de, wTextBuffer ; $08e4
	ld c, $20 ; $08e7
	call CopyMemoryFast ; $08e9
	wram_bank WRAM_SCREEN ; $08ec
	ld hl, wTextBuffer ; $08f2
	ld de, wScreenScratch ; $08f5
	call CopyMapRows32To64 ; $08f8
	ld hl, wScreenScratch ; $08fb
	ld c, $80 ; $08fe
	call ClearMemory16 ; $0900
	pop_wram_bank ; $0903
	pop hl ; $0908
	pop de ; $0909
	pop bc ; $090a
	pop af ; $090b
	ret ; $090c
