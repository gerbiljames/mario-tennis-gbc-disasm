SetWindowTextId:
	ld d, h ; $55d5
	ld e, l ; $55d6
	ld a, b ; $55d7
	call GetWindowStructPtr ; $55d8
	ld a, $06 ; $55db
	add l ; $55dd
	ld l, a ; $55de
	jr nc, .store ; $55df
	inc h ; $55e1
.store:
	ld a, e ; $55e2
	ld [hl+], a ; $55e3
	ld [hl], d ; $55e4
	ret ; $55e5
SetActiveWindowTextId:
	push af ; $55e6
	push bc ; $55e7
	xor a ; $55e8
	call AddTextIdOffset ; $55e9
	push hl ; $55ec
	ld a, [wDialogueWindowId] ; $55ed
	ld b, a ; $55f0
	call SetWindowTextId ; $55f1
	pop hl ; $55f4
	pop bc ; $55f5
	pop af ; $55f6
	ret ; $55f7
RenderWindowText:
	push af ; $55f8
	push bc ; $55f9
	push de ; $55fa
	push hl ; $55fb
	ld a, b ; $55fc
	call GetWindowStructPtr ; $55fd
	push hl ; $5600
	ld a, $06 ; $5601
	add l ; $5603
	ld l, a ; $5604
	jr nc, .read ; $5605
	inc h ; $5607
.read:
	ld a, [hl+] ; $5608
	ld b, [hl] ; $5609
	ld c, a ; $560a
	pop de ; $560b
	ld a, b ; $560c
	and $3f ; $560d
	ld b, a ; $560f
	ld a, [wTextPageBreakRequest] ; $5610
	or a ; $5613
	jr z, .zero ; $5614
	xor a ; $5616
	ld [wTextPageBreakRequest], a ; $5617
.zero:
	ld a, b ; $561a
	cp $03 ; $561b
	ld a, $01 ; $561d
	ld [wWindowTextEmpty], a ; $561f
	jr z, .restore ; $5622
	xor a ; $5624
	ld [wWindowTextEmpty], a ; $5625
	ld h, d ; $5628
	ld l, e ; $5629
	push hl ; $562a
	push hl ; $562b
	ld h, b ; $562c
	ld l, c ; $562d
	call FetchDialogueText ; $562e
	pop hl ; $5631
	ld a, [hl+] ; $5632
	inc a ; $5633
	and $1f ; $5634
	ld d, a ; $5636
	ld a, [hl+] ; $5637
	inc a ; $5638
	and $1f ; $5639
	ld e, a ; $563b
	pop hl ; $563c
	ld hl, wTextBuffer ; $563d
	call RenderTextString ; $5640
.restore:
	pop hl ; $5643
	pop de ; $5644
	pop bc ; $5645
	pop af ; $5646
	ret ; $5647
RenderActiveWindowText:
	push af ; $5648
	push bc ; $5649
	ld a, [wDialogueWindowId] ; $564a
	ld b, a ; $564d
	call RenderWindowText ; $564e
	pop bc ; $5651
	pop af ; $5652
	ret ; $5653
FitWindowToText:
	push af ; $5654
	push bc ; $5655
	push de ; $5656
	push hl ; $5657
	ld hl, wTextBuffer ; $5658
	ld a, [wTextResumePtr + 1] ; $565b
	or a ; $565e
	jr z, .measure ; $565f
	ld hl, wTextResumePtr ; $5661
	ld a, [hl+] ; $5664
	ld h, [hl] ; $5665
	ld l, a ; $5666
.measure:
	xor a ; $5667
	ld b, a ; $5668
	ld d, a ; $5669
	ld e, a ; $566a
.charLoop:
	ld a, [hl+] ; $566b
	cp $00 ; $566c
	jp z, .lastLine ; $566e
	cp $02 ; $5671
	jp z, .lastLine ; $5673
	cp $01 ; $5676
	jr z, .newline ; $5678
	jr .checkArgShortText ; $567a
.newline:
	inc e ; $567c
	ld a, d ; $567d
	cp b ; $567e
	ld a, b ; $567f
	ld b, $00 ; $5680
	jr nc, .charLoop ; $5682
	ld d, a ; $5684
	jr .charLoop ; $5685
.checkArgShortText:
	cp $08 ; $5687
	jr nz, .checkArgNumber ; $5689
	call GetNextArgShortTextLength ; $568b
	add b ; $568e
	ld b, a ; $568f
	jr .charLoop ; $5690
.checkArgNumber:
	cp $09 ; $5692
	jr nz, .checkMainCharName ; $5694
	call MeasureNextArgNumberWidth ; $5696
	add b ; $5699
	ld b, a ; $569a
	jr .charLoop ; $569b
.checkMainCharName:
	cp $07 ; $569d
	jr nz, .checkArgString ; $569f
	call MeasureMainCharacterNameWidth ; $56a1
	add b ; $56a4
	ld b, a ; $56a5
	jr .charLoop ; $56a6
.checkArgString:
	cp $04 ; $56a8
	jr nz, .checkPartnerName ; $56aa
	call MeasureNextArgStringWidth ; $56ac
	add b ; $56af
	ld b, a ; $56b0
	jr .charLoop ; $56b1
.checkPartnerName:
	cp $0b ; $56b3
	jr nz, .checkIndexedShortText ; $56b5
	call MeasurePartnerCharacterNameWidth ; $56b7
	add b ; $56ba
	ld b, a ; $56bb
	jr .charLoop ; $56bc
.checkIndexedShortText:
	cp $0e ; $56be
	jr nz, .glyph ; $56c0
	ld a, [hl+] ; $56c2
	ld [wTextCharNameArg], a ; $56c3
	call MeasureIndexedShortTextWidth ; $56c6
	add b ; $56c9
	ld b, a ; $56ca
	jr .charLoop ; $56cb
.glyph:
	cp $20 ; $56cd
	jp c, .charLoop ; $56cf
	cp $7b ; $56d2
	jp nc, .charLoop ; $56d4
	call GetGlyphWidth ; $56d7
	ld a, c ; $56da
	add b ; $56db
	ld b, a ; $56dc
	jp .charLoop ; $56dd
.lastLine:
	inc e ; $56e0
	ld a, d ; $56e1
	cp b ; $56e2
	jr nc, .toCells ; $56e3
	ld d, b ; $56e5
.toCells:
	ld a, d ; $56e6
	and $07 ; $56e7
	jr z, .roundedWidth ; $56e9
	ld a, $01 ; $56eb
.roundedWidth:
	srl d ; $56ed
	srl d ; $56ef
	srl d ; $56f1
	add d ; $56f3
	ld d, a ; $56f4
	ld a, d ; $56f5
	ld [wFitTextWidthCells], a ; $56f6
	ld a, e ; $56f9
	ld [wFitTextLineCount], a ; $56fa
	inc d ; $56fd
	inc d ; $56fe
	sla e ; $56ff
	inc e ; $5701
	push de ; $5702
	ld a, [wDialogueWindowId] ; $5703
	cp DIALOGUEWIN_NONE ; $5706
	jr nz, .placeWindow ; $5708
	xor a ; $570a
.placeWindow:
	sla a ; $570b
	sla a ; $570d
	ld b, $00 ; $570f
	ld c, a ; $5711
	ld hl, wWindowFitTable ; $5712
	add hl, bc ; $5715
	ld c, [hl] ; $5716
	inc hl ; $5717
	ld b, [hl] ; $5718
	ld h, b ; $5719
	ld l, c ; $571a
	pop bc ; $571b
	ld a, [wDialogueWindowHeight] ; $571c
	sub b ; $571f
	srl a ; $5720
	ld d, a ; $5722
	ld a, [wDialogueWindowCol] ; $5723
WaitActorsIdleTimeout:
	add d ; $5726
	ld d, a ; $5727
	ld a, [wDialogueWindowWidth] ; $5728
	sub c ; $572b
	srl a ; $572c
	ld e, a ; $572e
	ld a, [wDialogueWindowRow] ; $572f
	add e ; $5732
	ld e, a ; $5733
	ld a, [wDialogueWindowId] ; $5734
	call GetWindowStructPtr ; $5737
	call SetWindowRect ; $573a
	ld [wTextArgNumberMeasureIndex], a ; $573d
	pop hl ; $5740
	pop de ; $5741
	pop bc ; $5742
	pop af ; $5743
	ret ; $5744
MeasureTextDimensions:
	push af ; $5745
	push de ; $5746
	push hl ; $5747
	ld hl, wTextBuffer ; $5748
	xor a ; $574b
	ld b, a ; $574c
	ld d, a ; $574d
	ld e, a ; $574e
.loop:
	ld a, [hl+] ; $574f
	cp $00 ; $5750
	jr z, .eq00 ; $5752
	cp $01 ; $5754
	jr nz, .compare ; $5756
	inc e ; $5758
	ld a, d ; $5759
	cp b ; $575a
	ld a, b ; $575b
	ld b, $00 ; $575c
	jr nc, .loop ; $575e
	ld d, a ; $5760
	jr .loop ; $5761
.compare:
	cp $08 ; $5763
	jr nz, .compare2 ; $5765
	call GetNextArgShortTextLength ; $5767
	add b ; $576a
	ld b, a ; $576b
	jr .loop ; $576c
.compare2:
	cp $09 ; $576e
	jr nz, .compare3 ; $5770
	call MeasureNextArgNumberWidth ; $5772
	add b ; $5775
	ld b, a ; $5776
	jr .loop ; $5777
.compare3:
	cp $20 ; $5779
	jr c, .loop ; $577b
	cp $7b ; $577d
	jr nc, .loop ; $577f
	call GetGlyphWidth ; $5781
	ld a, c ; $5784
	add b ; $5785
	ld b, a ; $5786
	jr .loop ; $5787
.eq00:
	inc e ; $5789
	ld a, d ; $578a
	cp b ; $578b
	jr nc, .countLeft ; $578c
	ld d, b ; $578e
.countLeft:
	inc d ; $578f
	inc d ; $5790
	inc d ; $5791
	sla e ; $5792
	inc e ; $5794
	push de ; $5795
	pop bc ; $5796
	pop hl ; $5797
	pop de ; $5798
	pop af ; $5799
	ret ; $579a
DelayTextCharacter:
	push af ; $579b
	push bc ; $579c
	push de ; $579d
	push hl ; $579e
	ld c, a ; $579f
	push_wram_bank WRAM_TEXT ; $57a0
	ld a, [wTextRedrawGuard] ; $57a9
	or a ; $57ac
	ld b, a ; $57ad
	jr z, .restore ; $57ae
	ld a, c ; $57b0
	cp $20 ; $57b1
	jr nz, .checkSpeed ; $57b3
	ld b, $04 ; $57b5
	jr .waitFrame ; $57b7
.checkSpeed:
	ld a, [wDialogueVoice] ; $57b9
	cp $08 ; $57bc
	jr z, .waitFrame ; $57be
	push bc ; $57c0
	ld e, a ; $57c1
	sla e ; $57c2
	sla e ; $57c4
	ld d, $9a ; $57c6
	ld a, c ; $57c8
	and $03 ; $57c9
	add e ; $57cb
	add d ; $57cc
	call PlaySoundManaged ; $57cd
	pop bc ; $57d0
.waitFrame:
	call AdvanceFrame ; $57d1
	ldh a, [hPlayerInputFlags] ; $57d4
	and $f3 ; $57d6
	jr nz, .restore ; $57d8
	dec b ; $57da
	jr nz, .waitFrame ; $57db
.restore:
	pop_wram_bank ; $57dd
	pop hl ; $57e2
	pop de ; $57e3
	pop bc ; $57e4
	pop af ; $57e5
	ret ; $57e6
ApplyMessageSpeed:
	push af ; $57e7
	push_wram_bank WRAM_TEXT ; $57e8
	ld a, [wMessageSpeed] ; $57f1
	bit 7, a ; $57f4
	jr z, .speed1 ; $57f6
	xor a ; $57f8
	ld [wTextRedrawGuard], a ; $57f9
	jr .store ; $57fc
.speed1:
	or a ; $57fe
	jr nz, .speed2 ; $57ff
	ld a, $00 ; $5801
	ld [wTextRedrawGuard], a ; $5803
	jr .store ; $5806
.speed2:
	cp $01 ; $5808
	jr nz, .speed3 ; $580a
	ld a, $02 ; $580c
	ld [wTextRedrawGuard], a ; $580e
	jr .store ; $5811
.speed3:
	ld a, $04 ; $5813
	ld [wTextRedrawGuard], a ; $5815
.store:
	pop_wram_bank ; $5818
	pop af ; $581d
	ret ; $581e
ShowSpeakerDialogue:
	push af ; $581f
	push bc ; $5820
	push de ; $5821
	ld b, a ; $5822
	push_wram_bank WRAM_TEXT ; $5823
	xor a ; $582c
	ld [wTextArgStringWriteIndex], a ; $582d
	ld [wTextArgStringMeasureIndex], a ; $5830
	ld [wTextArgNumberWriteIndex], a ; $5833
	ld [wTextArgNumberMeasureIndex], a ; $5836
	ld [wTextArgShortTextWriteIndex], a ; $5839
	ld [wTextArgShortTextMeasureIndex], a ; $583c
	call AddTextIdOffset ; $583f
	ld a, b ; $5842
	cp $ff ; $5843
	jr nz, .store ; $5845
	ld a, $00 ; $5847
.store:
	ld [wDialogueSpeaker], a ; $5849
	call ApplyMessageSpeed ; $584c
	bit 7, a ; $584f
	ld b, $08 ; $5851
	jr nz, .negative ; $5853
	call GetSpeakerVoice ; $5855
	ld b, a ; $5858
.negative:
	ld a, b ; $5859
	ld [wDialogueVoice], a ; $585a
	ld a, [wDialogueWindowId] ; $585d
	cp DIALOGUEWIN_NONE ; $5860
	jr nz, .loop ; $5862
	xor a ; $5864
	ld [wGlyphRowStartCol], a ; $5865
	ld [wGlyphFlushedCol], a ; $5868
	push_wram_bank WRAM_SOUND ; $586b
	call ClearGlyphBuffer ; $5874
	call UploadGlyphBufferFull ; $5877
	pop_wram_bank ; $587a
	ld a, [wDialogueSpeaker] ; $587f
	call OpenSpeechBubble ; $5882
	call RestoreShadowTilemap ; $5885
.loop:
	xor a ; $5888
	ld [wGlyphRowStartCol], a ; $5889
	ld [wGlyphFlushedCol], a ; $588c
	push_wram_bank WRAM_SOUND ; $588f
	call ClearGlyphBuffer ; $5898
	call UploadGlyphBufferFull ; $589b
	pop_wram_bank ; $589e
	call SetActiveWindowTextId ; $58a3
	ld a, [wDialogueWindowId] ; $58a6
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $58a9
	call DrawTextWindowFrame ; $58ac
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $58af
	call RedrawWindowRowsPadded ; $58b2
	call RenderActiveWindowText ; $58b5
	ld a, [wTextPageBreakRequest] ; $58b8
	or a ; $58bb
	jr z, .zero ; $58bc
	ld a, [wDialogueWindowId] ; $58be
	call RestoreTilemapUnderWindow ; $58c1
	call FitWindowToText ; $58c4
	jr .loop ; $58c7
.zero:
	ld a, [wDialogueWindowId] ; $58c9
	call CloseWindow ; $58cc
	ld a, DIALOGUEWIN_NONE ; $58cf
	ld [wDialogueWindowId], a ; $58d1
	xor a ; $58d4
	ld [wTextArgStringWriteIndex], a ; $58d5
	ld [wTextArgStringMeasureIndex], a ; $58d8
	ld [wTextArgNumberWriteIndex], a ; $58db
	ld [wTextArgNumberMeasureIndex], a ; $58de
	ld [wTextArgShortTextWriteIndex], a ; $58e1
	ld [wTextArgShortTextMeasureIndex], a ; $58e4
	pop_wram_bank ; $58e7
	pop de ; $58ec
	pop bc ; $58ed
	pop af ; $58ee
	ret ; $58ef
ShowSpeakerDialogueRestoreBG:
	push af ; $58f0
	push bc ; $58f1
	push de ; $58f2
	ld b, a ; $58f3
	push_wram_bank WRAM_TEXT ; $58f4
	xor a ; $58fd
	ld [wTextArgStringWriteIndex], a ; $58fe
	ld [wTextArgStringMeasureIndex], a ; $5901
	ld [wTextArgNumberWriteIndex], a ; $5904
	ld [wTextArgNumberMeasureIndex], a ; $5907
	ld [wTextArgShortTextWriteIndex], a ; $590a
	ld [wTextArgShortTextMeasureIndex], a ; $590d
	call AddTextIdOffset ; $5910
	ld a, b ; $5913
	cp $ff ; $5914
	jr nz, .store ; $5916
	ld a, $00 ; $5918
.store:
	ld [wDialogueSpeaker], a ; $591a
	call ApplyMessageSpeed ; $591d
	bit 7, a ; $5920
	ld b, $08 ; $5922
	jr nz, .negative ; $5924
	call GetSpeakerVoice ; $5926
	ld b, a ; $5929
.negative:
	ld a, b ; $592a
	ld [wDialogueVoice], a ; $592b
	ld a, [wDialogueWindowId] ; $592e
	cp DIALOGUEWIN_NONE ; $5931
	jr nz, .loop ; $5933
	xor a ; $5935
	ld [wGlyphRowStartCol], a ; $5936
	ld [wGlyphFlushedCol], a ; $5939
	push_wram_bank WRAM_SOUND ; $593c
	call ClearGlyphBuffer ; $5945
	call UploadGlyphBufferFull ; $5948
	pop_wram_bank ; $594b
	ld a, [wDialogueSpeaker] ; $5950
	call OpenSpeechBubble ; $5953
.loop:
	xor a ; $5956
	ld [wGlyphRowStartCol], a ; $5957
	ld [wGlyphFlushedCol], a ; $595a
	push_wram_bank WRAM_SOUND ; $595d
	call ClearGlyphBuffer ; $5966
	call UploadGlyphBufferFull ; $5969
	pop_wram_bank ; $596c
	call SetActiveWindowTextId ; $5971
	call RestoreShadowTilemap ; $5974
	ld a, [wDialogueWindowId] ; $5977
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $597a
	call DrawTextWindowFrame ; $597d
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $5980
	call RedrawWindowRowsPadded ; $5983
	call RenderActiveWindowText ; $5986
	ld a, [wTextPageBreakRequest] ; $5989
	or a ; $598c
	jr z, .clearTextArgStringWriteIndex ; $598d
	call FitWindowToText ; $598f
	jr .loop ; $5992
.clearTextArgStringWriteIndex:
	xor a ; $5994
	ld [wTextArgStringWriteIndex], a ; $5995
	ld [wTextArgStringMeasureIndex], a ; $5998
	ld [wTextArgNumberWriteIndex], a ; $599b
	ld [wTextArgNumberMeasureIndex], a ; $599e
	ld [wTextArgShortTextWriteIndex], a ; $59a1
	ld [wTextArgShortTextMeasureIndex], a ; $59a4
	pop_wram_bank ; $59a7
	pop de ; $59ac
	pop bc ; $59ad
	pop af ; $59ae
	ret ; $59af
