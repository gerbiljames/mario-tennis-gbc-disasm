StubNop_05_0:
	ret ; $4626
AllocWindowSlotBit:
	push hl ; $4627
	push bc ; $4628
	push de ; $4629
	ld b, $07 ; $462a
	ld a, [wWindowSlotMask] ; $462c
	ld c, $01 ; $462f
.searchLoop:
	rrca ; $4631
	jr nc, .claim ; $4632
	sla c ; $4634
	dec b ; $4636
	jr nz, .searchLoop ; $4637
	ld a, $ff ; $4639
	jr .done ; $463b
.claim:
	ld a, [wWindowSlotMask] ; $463d
	or c ; $4640
	ld [wWindowSlotMask], a ; $4641
	ld a, $07 ; $4644
	sub b ; $4646
.done:
	pop de ; $4647
	pop bc ; $4648
	pop hl ; $4649
	ret ; $464a
GetScreenTopLeftCell:
	push af ; $464b
	push hl ; $464c
	ldh a, [hScrollX] ; $464d
	add $07 ; $464f
	rrca ; $4651
	rrca ; $4652
	rrca ; $4653
	and $1f ; $4654
	ld d, a ; $4656
	ldh a, [hScrollY] ; $4657
	add $07 ; $4659
	rrca ; $465b
	rrca ; $465c
	rrca ; $465d
	and $1f ; $465e
	ld e, a ; $4660
	pop hl ; $4661
	pop af ; $4662
	ret ; $4663
CreateWindowWithAttr:
	push hl ; $4664
	ld h, a ; $4665
	push_wram_bank $05 ; $4666
	ld a, h ; $466f
	ld [wWindowTileAttr], a ; $4670
	call CreateWindow ; $4673
	ld h, a ; $4676
	ld a, TILEATTR_PRIORITY ; $4677
	ld [wWindowTileAttr], a ; $4679
	pop_wram_bank ; $467c
	ld a, h ; $4681
	pop hl ; $4682
	ret ; $4683
CreateWindow:
	call CreateWindowFromScreenRect ; $4684
	ret ; $4687
CreateDialogueWindow:
	push hl ; $4688
	ld a, b ; $4689
	ld [wDialogueWindowHeight], a ; $468a
	ld a, c ; $468d
	ld [wDialogueWindowWidth], a ; $468e
	push de ; $4691
	call CreateWindowFromScreenRect ; $4692
	ld [wDialogueWindowId], a ; $4695
	pop de ; $4698
	push af ; $4699
	ld h, d ; $469a
	ld l, e ; $469b
	call GetScreenTopLeftCell ; $469c
	ld a, h ; $469f
	add d ; $46a0
	and $1f ; $46a1
	ld [wDialogueWindowCol], a ; $46a3
	ld a, l ; $46a6
	add e ; $46a7
	and $1f ; $46a8
	ld [wDialogueWindowRow], a ; $46aa
	pop af ; $46ad
	pop hl ; $46ae
	ret ; $46af
CreateMenuWindowFromText:
	push bc ; $46b0
	push de ; $46b1
	push hl ; $46b2
	wram_bank $05 ; $46b3
	call FetchDialogueText ; $46b9
	push hl ; $46bc
	ld h, d ; $46bd
	ld l, e ; $46be
	call GetScreenTopLeftCell ; $46bf
	ld a, h ; $46c2
	add d ; $46c3
	and $1f ; $46c4
	ld d, a ; $46c6
	ld a, l ; $46c7
	add e ; $46c8
	and $1f ; $46c9
	ld e, a ; $46cb
	pop hl ; $46cc
	call MeasureTextDimensions ; $46cd
	ld a, c ; $46d0
	dec a ; $46d1
	sra a ; $46d2
	ld [wMenuRowCount], a ; $46d4
	ld a, b ; $46d7
	srl b ; $46d8
	srl b ; $46da
	srl b ; $46dc
	and $07 ; $46de
	jr z, .gotRows ; $46e0
	inc b ; $46e2
.gotRows:
	inc b ; $46e3
	inc b ; $46e4
	inc b ; $46e5
	call AllocWindowStruct ; $46e6
	ld a, [wWindowId] ; $46e9
	cp $ff ; $46ec
	jp z, .done ; $46ee
	ld a, [wWindowId] ; $46f1
	ld b, a ; $46f4
	call SetWindowTextId ; $46f5
	ld a, [wWindowId] ; $46f8
	ld b, $02 ; $46fb
	call SetWindowState ; $46fd
	ld a, [wMenuDepth] ; $4700
	cp $ff ; $4703
	jr z, .noCursorEntry ; $4705
	ld hl, wMenuStack ; $4707
	sla a ; $470a
	ld c, a ; $470c
	ld b, $00 ; $470d
	add hl, bc ; $470f
	ld a, [wMenuCursorRow] ; $4710
	ld b, a ; $4713
	ld a, [hl] ; $4714
	and $f0 ; $4715
	or b ; $4717
	ld [hl], a ; $4718
.noCursorEntry:
	ld a, [wMenuDepth] ; $4719
	inc a ; $471c
	ld [wMenuDepth], a ; $471d
	ld hl, wMenuStack ; $4720
	sla a ; $4723
	ld c, a ; $4725
	ld b, $00 ; $4726
	add hl, bc ; $4728
	ld a, [wMenuRowCount] ; $4729
	sla a ; $472c
	sla a ; $472e
	sla a ; $4730
	sla a ; $4732
	ld [hl+], a ; $4734
	ld a, [wWindowId] ; $4735
	ld [wMenuWindowId], a ; $4738
	ld [hl], a ; $473b
	xor a ; $473c
	ld [wMenuCursorRow], a ; $473d
	ld a, [wWindowId] ; $4740
.done:
	pop hl ; $4743
	pop de ; $4744
	pop bc ; $4745
	ret ; $4746
CreateMenuWindowPaged:
	call CreateMenuWindowFromText ; $4747
	push af ; $474a
	push bc ; $474b
	ld a, [wWindowId] ; $474c
	ld b, $03 ; $474f
	call SetWindowState ; $4751
	pop bc ; $4754
	pop af ; $4755
	ret ; $4756
ResetWindowState:
	push af ; $4757
	call GetWindowStructPtr ; $4758
	ld a, $04 ; $475b
	add l ; $475d
	ld l, a ; $475e
	jr nc, .store ; $475f
	inc h ; $4761
.store:
	ld [hl], $ff ; $4762
	pop af ; $4764
	ret ; $4765
StubNop_05_1:
	ret ; $4766
SetWindowState:
	call GetWindowStructPtr ; $4767
	ld a, $04 ; $476a
	add l ; $476c
	ld l, a ; $476d
	jr nc, .store ; $476e
	inc h ; $4770
.store:
	ld [hl], b ; $4771
	ret ; $4772
GetWindowState:
	call GetWindowStructPtr ; $4773
	ld a, $04 ; $4776
	add l ; $4778
	ld l, a ; $4779
	jr nc, .read ; $477a
	inc h ; $477c
.read:
	ld a, [hl] ; $477d
	ret ; $477e
RunMenuSelection:
	push bc ; $477f
	push de ; $4780
	push hl ; $4781
	push_wram_bank $05 ; $4782
	xor a ; $478b
	ld [wTextArrowEraseAddr], a ; $478c
	ld [wTextArrowEraseAddr + 1], a ; $478f
	ld a, $ff ; $4792
	ld hl, wTextArrowCell ; $4794
	ld [hl+], a ; $4797
	ld [hl], a ; $4798
	ld a, [wMenuWindowId] ; $4799
	call GetWindowStructPtr ; $479c
	ld d, [hl] ; $479f
	inc hl ; $47a0
	ld e, [hl] ; $47a1
	inc d ; $47a2
	inc e ; $47a3
	push af ; $47a4
	push bc ; $47a5
	push de ; $47a6
	push hl ; $47a7
	ld a, [wMenuCursorRow] ; $47a8
	sla a ; $47ab
	add e ; $47ad
	ld e, a ; $47ae
	call GetTilemapCellAddress ; $47af
	xor a ; $47b2
	ld hl, wTextArrowBlinkCounter ; $47b3
	ld [hl+], a ; $47b6
	ld [hl], e ; $47b7
	inc hl ; $47b8
	ld [hl], d ; $47b9
	ld a, $01 ; $47ba
	ld hl, AnimateTextArrowTask ; $47bc
	call RegisterFrameTask ; $47bf
	pop hl ; $47c2
	pop de ; $47c3
	pop bc ; $47c4
	pop af ; $47c5
	ld a, [wMenuCursorRow] ; $47c6
	ld b, a ; $47c9
.inputLoop:
	call AdvanceFrame ; $47ca
	ldh a, [hInputRisingEdge] ; $47cd
	bit PADB_A, a ; $47cf
	jr nz, .confirm ; $47d1
	ldh a, [hInputPressed] ; $47d3
	bit PADB_UP, a ; $47d5
	jr z, .checkDown ; $47d7
	dec b ; $47d9
	bit 7, b ; $47da
	jr z, .moveCursor ; $47dc
	ld a, [wMenuRowCount] ; $47de
	dec a ; $47e1
	ld b, a ; $47e2
	jr .moveCursor ; $47e3
.checkDown:
	ldh a, [hInputPressed] ; $47e5
	and PADF_DOWN ; $47e7
	jp z, .checkStart ; $47e9
	ld a, [wMenuRowCount] ; $47ec
	ld c, a ; $47ef
	inc b ; $47f0
	ld a, b ; $47f1
	cp c ; $47f2
	jr c, .moveCursor ; $47f3
	ld b, $00 ; $47f5
.moveCursor:
	sound SFX_MENU_MOVE ; $47f7
	push de ; $47f9
	xor a ; $47fa
	ld [wTextArrowBlinkCounter], a ; $47fb
	ld a, b ; $47fe
	sla a ; $47ff
	add e ; $4801
	ld e, a ; $4802
	ld a, $20 ; $4803
	call WriteTileToShadowMapCell ; $4805
	push af ; $4808
	push bc ; $4809
	push de ; $480a
	push hl ; $480b
	ld hl, wTextArrowCell ; $480c
	ld a, [hl+] ; $480f
	ld h, [hl] ; $4810
	ld l, a ; $4811
	ld de, $3000 ; $4812
	add hl, de ; $4815
	ld de, $9800 ; $4816
	add hl, de ; $4819
	ld d, h ; $481a
	ld e, l ; $481b
	ld hl, wTextArrowEraseAddr ; $481c
	ld a, e ; $481f
	ld [hl+], a ; $4820
	ld a, d ; $4821
	ld [hl], a ; $4822
	pop hl ; $4823
	pop de ; $4824
	pop bc ; $4825
	pop af ; $4826
	pop de ; $4827
	push de ; $4828
	ld a, b ; $4829
	sla a ; $482a
	add e ; $482c
	ld e, a ; $482d
	push hl ; $482e
	call GetTilemapCellAddress ; $482f
	ld hl, wTextArrowCell ; $4832
	ld [hl], e ; $4835
	inc hl ; $4836
	ld [hl], d ; $4837
	pop hl ; $4838
	pop de ; $4839
	ld a, b ; $483a
	ld [wMenuCursorRow], a ; $483b
	jr .checkStart ; $483e
.confirm:
	ld a, b ; $4840
	ld [wMenuCursorRow], a ; $4841
	sound SFX_MENU_SELECT ; $4844
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld hl, AnimateTextArrowTask ; $484a
	call UnregisterFrameTask ; $484d
	call AdvanceFrame ; $4850
	ld a, [wMenuCursorRow] ; $4853
	sla a ; $4856
	inc a ; $4858
	ld e, a ; $4859
	ld d, $01 ; $485a
	ld a, [wMenuWindowId] ; $485c
	ld c, $0d ; $485f
	ld b, $80 ; $4861
	call WriteWindowCellTileAttr ; $4863
	pop hl ; $4866
	pop de ; $4867
	pop bc ; $4868
	pop af ; $4869
	jp .done ; $486a
.checkStart:
	ldh a, [hInputRisingEdge] ; $486d
	and PADF_START ; $486f
	jp z, .checkB ; $4871
	sound SFX_MENU_CANCEL ; $4874
	ld a, $ff ; $4876
	jp .cancel ; $4878
.checkB:
	ldh a, [hInputPressed] ; $487b
	and PADF_B ; $487d
	jp z, .checkSideScroll ; $487f
	sound SFX_MENU_CANCEL ; $4882
	ld a, $ff ; $4884
	jr .cancel ; $4886
.checkSideScroll:
	call GetWindowState ; $4888
	cp $03 ; $488b
	jp nz, .inputLoop ; $488d
	ld a, [wScrollListLength] ; $4890
	dec a ; $4893
	srl a ; $4894
	srl a ; $4896
	jp z, .inputLoop ; $4898
	ldh a, [hInputPressed] ; $489b
	and PADF_LEFT ; $489d
	jp z, .checkRight ; $489f
	ld a, $fe ; $48a2
	jr .cancel ; $48a4
.checkRight:
	ldh a, [hInputPressed] ; $48a6
	and PADF_RIGHT ; $48a8
	jp z, .inputLoop ; $48aa
	ld a, $fd ; $48ad
.cancel:
	ld [wMenuCursorRow], a ; $48af
	push af ; $48b2
	push bc ; $48b3
	push de ; $48b4
	push hl ; $48b5
	ld hl, AnimateTextArrowTask ; $48b6
	call UnregisterFrameTask ; $48b9
	call AdvanceFrame ; $48bc
	ld a, [wMenuDepth] ; $48bf
	or a ; $48c2
	jr z, .restored ; $48c3
	dec a ; $48c5
	ld hl, wMenuStack ; $48c6
	sla a ; $48c9
	ld c, a ; $48cb
	ld b, $00 ; $48cc
	add hl, bc ; $48ce
	ld a, [hl+] ; $48cf
	and $0f ; $48d0
	sla a ; $48d2
	inc a ; $48d4
	ld e, a ; $48d5
	ld d, $01 ; $48d6
	ld a, [hl] ; $48d8
	and $0f ; $48d9
	ld c, $20 ; $48db
	ld b, $80 ; $48dd
	call WriteWindowCellTileAttr ; $48df
.restored:
	pop hl ; $48e2
	pop de ; $48e3
	pop bc ; $48e4
	pop af ; $48e5
.done:
	ld b, a ; $48e6
	pop_wram_bank ; $48e7
	ld a, b ; $48ec
	pop hl ; $48ed
	pop de ; $48ee
	pop bc ; $48ef
	ret ; $48f0
AnimateTextArrowTask:
	push af ; $48f1
	push bc ; $48f2
	push de ; $48f3
	push hl ; $48f4
	wram_bank $05 ; $48f5
	ld hl, wTextArrowBlinkCounter ; $48fb
	ld a, [hl+] ; $48fe
	and $10 ; $48ff
	or a ; $4901
	jr z, .zero ; $4902
	ld a, $20 ; $4904
	jr .read ; $4906
.zero:
	ld a, $0d ; $4908
.read:
	ld e, [hl] ; $490a
	inc hl ; $490b
	ld d, [hl] ; $490c
	ld h, d ; $490d
	ld l, e ; $490e
	ld de, $3000 ; $490f
	add hl, de ; $4912
	ld de, $9800 ; $4913
	add hl, de ; $4916
	ld d, h ; $4917
	ld e, l ; $4918
	ld l, a ; $4919
	ld h, $80 ; $491a
	push de ; $491c
	call QueueBGTileWrite ; $491d
	pop de ; $4920
	ld a, [wTextArrowBlinkCounter] ; $4921
	inc a ; $4924
	ld [wTextArrowBlinkCounter], a ; $4925
	ld a, [wTextArrowEraseAddr] ; $4928
	or a ; $492b
	jr z, .restore ; $492c
	ld e, a ; $492e
	ld a, [wTextArrowEraseAddr + 1] ; $492f
	ld d, a ; $4932
	ld a, $20 ; $4933
	ld l, a ; $4935
	ld h, $80 ; $4936
	call QueueBGTileWrite ; $4938
	xor a ; $493b
	ld [wTextArrowEraseAddr], a ; $493c
.restore:
	pop hl ; $493f
	pop de ; $4940
	pop bc ; $4941
	pop af ; $4942
	ret ; $4943
