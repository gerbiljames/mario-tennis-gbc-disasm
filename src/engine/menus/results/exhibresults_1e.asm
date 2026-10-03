DrawExhibitionResultsHeader:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $44b1
	jr nz, .doubles ; $44b4
	call LoadSinglesLabelTiles ; $44b6
	xor a ; $44b9
	call DrawResultsNameLabelRows ; $44ba
	call DrawSinglesPlayerNames ; $44bd
	call DrawSetsGamesScore ; $44c0
	ret ; $44c3
.doubles:
	call LoadDoublesLabelTiles ; $44c4
	ld a, $01 ; $44c7
	call DrawResultsNameLabelRows ; $44c9
	call DrawDoublesPlayerNames ; $44cc
	call DrawSetsGamesScore ; $44cf
	ret ; $44d2
DrawMarioExhibitionResultsHeader:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $44d3
	jr nz, .doubles ; $44d6
	call LoadSinglesLabelTiles ; $44d8
	xor a ; $44db
	call DrawResultsNameLabelRows ; $44dc
	call DrawMarioExhibitionLabel ; $44df
	call DrawSetsGamesScore ; $44e2
	ret ; $44e5
.doubles:
	call LoadDoublesLabelTiles ; $44e6
	xor a ; $44e9
	call DrawResultsNameLabelRows ; $44ea
	call DrawMarioExhibitionLabel ; $44ed
	call DrawSetsGamesScore ; $44f0
	ret ; $44f3
DrawRankMatchResultsHeader:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $44f4
	jr nz, .doubles ; $44f7
	call LoadSinglesLabelTiles ; $44f9
	xor a ; $44fc
	call DrawResultsNameLabelRows ; $44fd
	call DrawClassNameLabel ; $4500
	call DrawRankMatchLabel ; $4503
	call DrawSetsGamesScore ; $4506
	ret ; $4509
.doubles:
	call LoadDoublesLabelTiles ; $450a
	xor a ; $450d
	call DrawResultsNameLabelRows ; $450e
	call DrawClassNameLabel ; $4511
	call DrawRankMatchLabel ; $4514
	call DrawSetsGamesScore ; $4517
	ret ; $451a
DrawTournamentResultsHeader:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $451b
	jr nz, .doubles ; $451e
	call LoadSinglesLabelTiles ; $4520
	xor a ; $4523
	call DrawResultsNameLabelRows ; $4524
	call DrawTournamentRoundLabel ; $4527
	call DrawSetsGamesScore ; $452a
	ret ; $452d
.doubles:
	call LoadDoublesLabelTiles ; $452e
	xor a ; $4531
	call DrawResultsNameLabelRows ; $4532
	call DrawTournamentRoundLabel ; $4535
	call DrawSetsGamesScore ; $4538
	ret ; $453b
DrawPracticeResultsHeader:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $453c
	jr nz, .doubles ; $453f
	call LoadSinglesLabelTiles ; $4541
	xor a ; $4544
	call DrawResultsNameLabelRows ; $4545
	call DrawClassNameLabel ; $4548
	call DrawPracticeMatchLabel ; $454b
	call DrawSetsGamesScore ; $454e
	ret ; $4551
.doubles:
	call LoadDoublesLabelTiles ; $4552
	xor a ; $4555
	call DrawResultsNameLabelRows ; $4556
	call DrawClassNameLabel ; $4559
	call DrawPracticeMatchLabel ; $455c
	call DrawSetsGamesScore ; $455f
	ret ; $4562
DrawProportionalTextLine:
	ldh a, [hWramBank] ; $4563
	push af ; $4565
	ld bc, $0012 ; $4566
	farcall RenderProportionalTextAt ; $4569
	pop_wram_bank ; $456c
	ret ; $4571
DrawContinuePromptText:
	push_wram_bank WRAM_SCREEN ; $4572
	ld a, $80 ; $457b
.loop:
	cp $91 ; $457d
	jr z, .restore ; $457f
	ld [hl], a ; $4581
	inc hl ; $4582
	inc a ; $4583
	jr .loop ; $4584
.restore:
	pop_wram_bank ; $4586
	ret ; $458b
DrawSaveWarningTextLine1:
	push_wram_bank WRAM_SCREEN ; $458c
	ld a, $92 ; $4595
.loop:
	cp $9e ; $4597
	jr z, .restore ; $4599
	ld [hl], a ; $459b
	inc hl ; $459c
	inc a ; $459d
	jr .loop ; $459e
.restore:
	pop_wram_bank ; $45a0
	ret ; $45a5
DrawSaveWarningTextLine2:
	push_wram_bank WRAM_SCREEN ; $45a6
	ld a, $a4 ; $45af
.loop:
	cp $b5 ; $45b1
	jr z, .restore ; $45b3
	ld [hl], a ; $45b5
	inc hl ; $45b6
	inc a ; $45b7
	jr .loop ; $45b8
.restore:
	pop_wram_bank ; $45ba
	ret ; $45bf
FetchAndDrawDialogueText:
	push bc ; $45c0
	xor a ; $45c1
	farcall AddTextIdOffset ; $45c2
	farcall FetchDialogueText ; $45c5
	pop bc ; $45c8
WriteTextToTilemap:
	ld hl, wTextBuffer ; $45c9
.charLoop:
	wram_bank WRAM_SCREEN ; $45cc
	ld a, [hl+] ; $45d2
	or a ; $45d3
	ret z ; $45d4
	cp $de ; $45d5
	jr z, .markChar ; $45d7
	cp $df ; $45d9
	jr z, .markChar ; $45db
	ld [de], a ; $45dd
	wram_bank WRAM_COURT_PLANES ; $45de
	ld a, b ; $45e4
	ld [de], a ; $45e5
	inc de ; $45e6
	jr .charLoop ; $45e7
.markChar:
	push de ; $45e9
	push bc ; $45ea
.backLoop:
	dec de ; $45eb
	dec c ; $45ec
	jr nz, .backLoop ; $45ed
	dec de ; $45ef
	ld c, a ; $45f0
	ld a, [de] ; $45f1
	cp $03 ; $45f2
	ld a, c ; $45f4
	jr nz, .storeMark ; $45f5
	sub $d0 ; $45f7
.storeMark:
	ld [de], a ; $45f9
	wram_bank WRAM_COURT_PLANES ; $45fa
	ld a, b ; $4600
	ld [de], a ; $4601
	pop bc ; $4602
	pop de ; $4603
	jr .charLoop ; $4604
DrawSinglesPlayerNames:
	ld hl, wPlayer1MainName ; $4606
	call CopyStringToTextBuffer ; $4609
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 3 ; $460c
	call ShiftDestForLongName ; $460f
	ld bc, $0020 ; $4612
	call WriteTextToTilemap ; $4615
	ld hl, Text_31_215 ; $4618
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 9 ; $461b
	ld bc, $0020 ; $461e
	call FetchAndDrawDialogueText ; $4621
	ld hl, wPlayer2MainName ; $4624
	call CopyStringToTextBuffer ; $4627
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 12 ; $462a
	ld bc, $0020 ; $462d
	call WriteTextToTilemap ; $4630
	ret ; $4633
DrawDoublesPlayerNames:
	ld hl, wPlayer1MainName ; $4634
	call CopyStringToTextBuffer ; $4637
	ld de, wScreenAttrmap + 12 * TILEMAP_WIDTH + 3 ; $463a
	call ShiftDestForLongName ; $463d
	ld bc, $0020 ; $4640
	call WriteTextToTilemap ; $4643
	ld hl, wPlayer1PartnerName ; $4646
	call CopyStringToTextBuffer ; $4649
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 3 ; $464c
	call ShiftDestForLongName ; $464f
	ld bc, $0020 ; $4652
	call WriteTextToTilemap ; $4655
	ld hl, Text_31_215 ; $4658
	ld de, wScreenAttrmap + 13 * TILEMAP_WIDTH + 9 ; $465b
	ld bc, $0020 ; $465e
	call FetchAndDrawDialogueText ; $4661
	ld hl, wPlayer2MainName ; $4664
	call CopyStringToTextBuffer ; $4667
	ld de, wScreenAttrmap + 12 * TILEMAP_WIDTH + 12 ; $466a
	ld bc, $0020 ; $466d
	call WriteTextToTilemap ; $4670
	ld hl, wPlayer2PartnerName ; $4673
	call CopyStringToTextBuffer ; $4676
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 12 ; $4679
	ld bc, $0020 ; $467c
	call WriteTextToTilemap ; $467f
	ret ; $4682
ShiftDestForLongName:
	ld c, $00 ; $4683
	ld hl, wTextBuffer ; $4685
.loop:
	ld a, [hl+] ; $4688
	or a ; $4689
	jr z, .zero ; $468a
	cp $de ; $468c
	jr z, .loop ; $468e
	cp $df ; $4690
	jr z, .loop ; $4692
	inc c ; $4694
	jr .loop ; $4695
.zero:
	ld a, $05 ; $4697
	cp c ; $4699
	ret nc ; $469a
	ld a, c ; $469b
	sub $05 ; $469c
	ld c, a ; $469e
.loopB:
	dec de ; $469f
	dec c ; $46a0
	jr nz, .loopB ; $46a1
	ret ; $46a3
DrawSetsGamesScore:
	ld hl, Text_31_225 ; $46a4
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 2 ; $46a7
	ld bc, $0020 ; $46aa
	call FetchAndDrawDialogueText ; $46ad
	ld a, [wPlayer1SetsWon] ; $46b0
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 6 ; $46b3
	call FormatAndDrawNumber ; $46b6
	ld hl, Text_31_227 ; $46b9
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 7 ; $46bc
	ld bc, $0020 ; $46bf
	call FetchAndDrawDialogueText ; $46c2
	ld a, [wPlayer2SetsWon] ; $46c5
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 8 ; $46c8
	call FormatAndDrawNumber ; $46cb
	ld hl, Text_31_226 ; $46ce
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 11 ; $46d1
	ld bc, $0020 ; $46d4
	call FetchAndDrawDialogueText ; $46d7
	ld a, [wPlayer1GamesWon] ; $46da
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 15 ; $46dd
	call FormatAndDrawNumber ; $46e0
	ld hl, Text_31_227 ; $46e3
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 16 ; $46e6
	call FetchAndDrawDialogueText ; $46e9
	ld a, [wPlayer2GamesWon] ; $46ec
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 17 ; $46ef
	call FormatAndDrawNumber ; $46f2
	ret ; $46f5
FormatAndDrawNumber:
	ld h, $00 ; $46f6
	ld l, a ; $46f8
	push de ; $46f9
	ld de, wTextBuffer ; $46fa
	ld a, $01 ; $46fd
	call FormatDecimalNumberUnsigned ; $46ff
	pop de ; $4702
	ld hl, wTextBuffer ; $4703
	ld bc, $0020 ; $4706
	call WriteTextToTilemap ; $4709
	ret ; $470c
CopyStringToTextBuffer:
	ld de, wTextBuffer ; $470d
.copyLoop:
	ld a, [hl+] ; $4710
	ld [de], a ; $4711
	or a ; $4712
	ret z ; $4713
	inc de ; $4714
	jr .copyLoop ; $4715
DrawClassNameLabel:
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4717
	jr nz, .doubles ; $471a
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $471c
	jr nz, .varsity ; $471f
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $4721
	jr nz, .senior ; $4724
	jr .junior ; $4726
.doubles:
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $4728
	jr nz, .varsity ; $472b
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $472d
	jr nz, .senior ; $4730
.junior:
	ld hl, Text_31_218 ; $4732
	jr .draw ; $4735
.senior:
	ld hl, Text_31_219 ; $4737
	jr .draw ; $473a
.varsity:
	ld hl, Text_31_220 ; $473c
.draw:
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 1 ; $473f
	ld bc, $0020 ; $4742
	call DrawProportionalTextLine ; $4745
	ret ; $4748
DrawRankMatchLabel:
	ld hl, wTextBuffer ; $4749
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $474c
	jr nz, .isTempResultsScreenOpen ; $474f
	ld a, $34 ; $4751
	ld [hl], a ; $4753
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $4754
	jr nz, .checkWramBank ; $4757
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $4759
	jr nz, .checkFlag ; $475c
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $475e
	jp z, .read ; $4761
	dec [hl] ; $4764
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $4765
	jp z, .read ; $4768
	dec [hl] ; $476b
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $476c
	jr z, .read ; $476f
	dec [hl] ; $4771
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $4772
	jr z, .read ; $4775
	ret ; $4777
.checkFlag:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $4778
	jr z, .read ; $477b
	dec [hl] ; $477d
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $477e
	jr z, .read ; $4781
	dec [hl] ; $4783
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $4784
	jr z, .read ; $4787
	dec [hl] ; $4789
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $478a
	jr z, .read ; $478d
	ret ; $478f
.isTempResultsScreenOpen:
	ld a, $33 ; $4790
	ld [hl], a ; $4792
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $4793
	jr nz, .checkWramBank ; $4796
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $4798
	jr nz, .checkFlag2 ; $479b
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $479d
	jr z, .read ; $47a0
	dec [hl] ; $47a2
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $47a3
	jr z, .read ; $47a6
	dec [hl] ; $47a8
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $47a9
	jr z, .read ; $47ac
	ret ; $47ae
.checkFlag2:
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $47af
	jr z, .read ; $47b2
	dec [hl] ; $47b4
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $47b5
	jr z, .read ; $47b8
	dec [hl] ; $47ba
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $47bb
	jr z, .read ; $47be
	ret ; $47c0
.read:
	ld a, [hl] ; $47c1
	sub $30 ; $47c2
	ld l, a ; $47c4
	xor a ; $47c5
	ld h, a ; $47c6
	farcall PushTextArgNumber ; $47c7
	ld hl, Text_31_221 ; $47ca
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 10 ; $47cd
	ld bc, $0020 ; $47d0
	call DrawProportionalTextLine ; $47d3
	ret ; $47d6
.checkWramBank:
	push_wram_bank WRAM_SCREEN ; $47d7
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH + 10 ; $47e0
	ld a, $20 ; $47e3
	ld [hl+], a ; $47e5
	ld [hl+], a ; $47e6
	ld [hl+], a ; $47e7
	ld [hl+], a ; $47e8
	ld [hl+], a ; $47e9
	ld [hl+], a ; $47ea
	ld [hl+], a ; $47eb
	ld [hl+], a ; $47ec
	ld [hl], a ; $47ed
	pop_wram_bank ; $47ee
	ret ; $47f3
DrawTournamentRoundLabel:
	ld hl, Text_31_222 ; $47f4
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 1 ; $47f7
	ld bc, $0020 ; $47fa
	call DrawProportionalTextLine ; $47fd
	ld hl, wTextBuffer ; $4800
	ld a, $31 ; $4803
	ld [hl], a ; $4805
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4806
	jr nz, .checkFlag ; $4809
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $480b
	jr z, .read ; $480e
	inc [hl] ; $4810
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4811
	jr z, .read ; $4814
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4816
	jr z, .clearRoundLabelRow ; $4819
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $481b
	jr z, .clearRoundLabelRow2 ; $481e
	ret ; $4820
.checkFlag:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4821
	jr z, .read ; $4824
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $4826
	jr z, .clearRoundLabelRow ; $4829
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $482b
	jr z, .clearRoundLabelRow2 ; $482e
	ret ; $4830
.read:
	ld a, [hl] ; $4831
	sub $30 ; $4832
	ld l, a ; $4834
	xor a ; $4835
	ld h, a ; $4836
	farcall PushTextArgNumber ; $4837
	ld hl, Text_31_223 ; $483a
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 10 ; $483d
	ld bc, $0020 ; $4840
	call DrawProportionalTextLine ; $4843
	ret ; $4846
.clearRoundLabelRow:
	call ClearRoundLabelRow ; $4847
	ld hl, Text_31_230 ; $484a
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 9 ; $484d
	ld bc, $0020 ; $4850
	call DrawProportionalTextLine ; $4853
	ret ; $4856
.clearRoundLabelRow2:
	call ClearRoundLabelRow ; $4857
	ld hl, Text_31_229 ; $485a
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 10 ; $485d
	ld bc, $0020 ; $4860
	call DrawProportionalTextLine ; $4863
	ret ; $4866
