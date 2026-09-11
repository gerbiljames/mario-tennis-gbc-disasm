UnpackBytesToNibbles:
	ld hl, wLinkNibbleBuffer ; $4656
	ld a, c ; $4659
	add a ; $465a
	cp $5f ; $465b
	jr c, .unpack ; $465d
	xor a ; $465f
	scf ; $4660
	jp .done ; $4661
.unpack:
	ld c, a ; $4664
	ld b, $00 ; $4665
.nibbleLoop:
	ld a, [de] ; $4667
	bit 0, b ; $4668
	jr nz, .lowNibble ; $466a
	swap a ; $466c
	and $0f ; $466e
	jr .store ; $4670
.lowNibble:
	and $0f ; $4672
	inc de ; $4674
.store:
	ld [hl+], a ; $4675
	inc b ; $4676
	ld a, b ; $4677
	cp c ; $4678
	jr nz, .nibbleLoop ; $4679
	ld a, c ; $467b
	scf ; $467c
	ccf ; $467d
.done:
	ret ; $467e
ExchangeLinkFrameByteMaster:
	di ; $467f
	ldh a, [rLY] ; $4680
	ei ; $4682
	cp $8c ; $4683
	jr nz, ExchangeLinkFrameByteMaster ; $4685
	di ; $4687
	ldh a, [hLinkTxByte] ; $4688
	ldh [rSB], a ; $468a
	push af ; $468c
	ld a, SC_FAST | SC_INTERNAL ; $468d
	ldh [rSC], a ; $468f
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $4691
	ldh [rSC], a ; $4693
	pop af ; $4695
	ei ; $4696
	call AdvanceFrame ; $4697
	ldh a, [hLinkRxByte] ; $469a
	ld b, a ; $469c
	cp $00 ; $469d
	jr z, .badReply ; $469f
	cp $ff ; $46a1
	jr z, .resetLink ; $46a3
	and $c0 ; $46a5
	cp $80 ; $46a7
	jr z, .checkDuplicate ; $46a9
	cp $40 ; $46ab
	jr z, .checkDuplicate ; $46ad
.badReply:
	call LinkErrorReset ; $46af
	ld hl, hLinkCounter ; $46b2
	inc [hl] ; $46b5
	ld a, [hl] ; $46b6
	cp $0a ; $46b7
	jr nc, .giveUp ; $46b9
	call WaitVBlank ; $46bb
	jp ExchangeLinkFrameByteMaster ; $46be
.giveUp:
	call LinkErrorReset ; $46c1
.resetLink:
	call LinkErrorReset ; $46c4
.checkDuplicate:
	ldh a, [hLinkLastRxByte] ; $46c7
	cp b ; $46c9
	jr nz, .store ; $46ca
	and $3f ; $46cc
	ld hl, hLinkCounter ; $46ce
	inc [hl] ; $46d1
	ld a, [hl] ; $46d2
	cp $02 ; $46d3
	jr nc, .reinitLink ; $46d5
	call WaitVBlank ; $46d7
	call WaitVBlank ; $46da
	jp ExchangeLinkFrameByteMaster ; $46dd
.reinitLink:
	call InitSerialLink ; $46e0
	call LinkErrorReset ; $46e3
.store:
	ld a, b ; $46e6
	ldh [hLinkLastRxByte], a ; $46e7
	ldh [hLinkLastRxMirror], a ; $46e9
	xor a ; $46eb
	ldh [hLinkCounter], a ; $46ec
	ret ; $46ee
ExchangeLinkFrameByteSlave:
	call AwaitSerialByte ; $46ef
	jr c, .resetLink ; $46f2
	push bc ; $46f4
	call AdvanceFrame ; $46f5
	pop bc ; $46f8
	di ; $46f9
	cp $00 ; $46fa
	jr z, .resetLink ; $46fc
	cp $ff ; $46fe
	jr z, .resetLinkAgain ; $4700
	and $c0 ; $4702
	cp $40 ; $4704
	jr z, .checkDuplicate ; $4706
	cp $80 ; $4708
	jr z, .checkDuplicate ; $470a
.resetLink:
	call LinkErrorReset ; $470c
.resetLinkAgain:
	call LinkErrorReset ; $470f
.checkDuplicate:
	ldh a, [hLinkLastRxByte] ; $4712
	cp b ; $4714
	jr nz, .store ; $4715
	and $3f ; $4717
	jr .resetLink ; $4719
.store:
	ld a, b ; $471b
	ldh [hLinkLastRxByte], a ; $471c
	ldh [hLinkLastRxMirror], a ; $471e
	xor a ; $4720
	ldh [hLinkCounter], a ; $4721
	ei ; $4723
	ret ; $4724
SyncLinkFrameMaster:
	push bc ; $4725
	push hl ; $4726
	call PrepareLinkStatePayload ; $4727
	call ExchangeLinkFrameByteMaster ; $472a
	call SerialDecodeInput ; $472d
	call SerialEncodeInput ; $4730
	pop hl ; $4733
	pop bc ; $4734
	ret ; $4735
SyncLinkFrameSlave:
	push bc ; $4736
	push hl ; $4737
	call PrepareLinkStatePayload ; $4738
	call ExchangeLinkFrameByteSlave ; $473b
	call SerialDecodeInput ; $473e
	call SerialEncodeInput ; $4741
	pop hl ; $4744
	pop bc ; $4745
	ret ; $4746
SyncLinkFrame:
	push af ; $4747
	push bc ; $4748
	push de ; $4749
	push hl ; $474a
	ld hl, hMatchFrameCounter ; $474b
	inc [hl] ; $474e
	ldh a, [hLinkState] ; $474f
	cp LINKSTATE_SLAVE ; $4751
	jr z, .slave ; $4753
	call SyncLinkFrameMaster ; $4755
	jr .done ; $4758
.slave:
	call SyncLinkFrameSlave ; $475a
.done:
	pop hl ; $475d
	pop de ; $475e
	pop bc ; $475f
	pop af ; $4760
	ret ; $4761
RunLinkMatchFrame:
	push af ; $4762
	push bc ; $4763
	push de ; $4764
	push hl ; $4765
	ld hl, hMatchFrameCounter ; $4766
	inc [hl] ; $4769
	ldh a, [hLinkState] ; $476a
	cp LINKSTATE_SLAVE ; $476c
	jr z, .asSlave ; $476e
	call RunLinkMatchFrameMaster ; $4770
	jr .done ; $4773
.asSlave:
	call RunLinkMatchFrameSlave ; $4775
.done:
	pop hl ; $4778
	pop de ; $4779
	pop bc ; $477a
	pop af ; $477b
	ret ; $477c
ExchangeLinkReadySignal:
	push af ; $477d
	push bc ; $477e
	ld c, $64 ; $477f
	ldh a, [hLinkState] ; $4781
	cp LINKSTATE_SLAVE ; $4783
	jr z, .asSlave ; $4785
	cp LINKSTATE_MASTER ; $4787
	jr z, .delayLoop ; $4789
	call LinkErrorReset ; $478b
.delayLoop:
	call ShortDelay ; $478e
	dec c ; $4791
	jr nz, .delayLoop ; $4792
	call ExchangeReadyTokenMaster ; $4794
	jr .done ; $4797
.asSlave:
	call ExchangeReadyTokenSlave ; $4799
.done:
	pop bc ; $479c
	pop af ; $479d
	ret ; $479e
ExchangeReadyTokenMaster:
	push af ; $479f
	push de ; $47a0
	ldh a, [rSC] ; $47a1
	and $7f ; $47a3
	ldh [rSC], a ; $47a5
	ld de, $2710 ; $47a7
.retry:
	ldh a, [rSC] ; $47aa
	bit 7, a ; $47ac
	jr nz, .retry ; $47ae
	di ; $47b0
	ld a, $0b ; $47b1
	or $40 ; $47b3
	ldh [rSB], a ; $47b5
	push af ; $47b7
	ld a, SC_FAST | SC_INTERNAL ; $47b8
	ldh [rSC], a ; $47ba
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $47bc
	ldh [rSC], a ; $47be
	pop af ; $47c0
	ei ; $47c1
	call ShortDelay ; $47c2
	ldh a, [hLinkRxByte] ; $47c5
	and $3f ; $47c7
	cp $0a ; $47c9
	jr z, .done ; $47cb
	dec de ; $47cd
	ld a, d ; $47ce
	or e ; $47cf
	jr nz, .retry ; $47d0
	call LinkErrorReset ; $47d2
.done:
	pop de ; $47d5
	pop af ; $47d6
	ret ; $47d7
ExchangeReadyTokenSlave:
	push af ; $47d8
	push de ; $47d9
	ld de, $0003 ; $47da
	di ; $47dd
	ld a, $0a ; $47de
	or $80 ; $47e0
	ldh [hLinkTxByte], a ; $47e2
	ldh [rSB], a ; $47e4
	push af ; $47e6
	ld a, SC_FAST | SC_EXTERNAL ; $47e7
	ldh [rSC], a ; $47e9
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $47eb
	ldh [rSC], a ; $47ed
	pop af ; $47ef
	ei ; $47f0
.retry:
	call WaitSerialTransfer ; $47f1
	ldh a, [hLinkRxByte] ; $47f4
	and $3f ; $47f6
	cp $0b ; $47f8
	jr z, .done ; $47fa
	dec de ; $47fc
	ld a, d ; $47fd
	or e ; $47fe
	jr nz, .retry ; $47ff
	call LinkErrorReset ; $4801
.done:
	pop de ; $4804
	pop af ; $4805
	ret ; $4806
RunLinkInputFrameMaster:
	push bc ; $4807
	push hl ; $4808
	call PrepareLinkInputPayload ; $4809
	call ExchangeLinkFrameByteMaster ; $480c
	call SerialDecodeInput ; $480f
	ldh a, [hLinkInput] ; $4812
	call SoftResetIfABStartSelect ; $4814
	call SerialEncodeInput ; $4817
	pop bc ; $481a
	pop hl ; $481b
	ret ; $481c
RunLinkInputFrameSlave:
	push bc ; $481d
	push hl ; $481e
	call PrepareLinkInputPayload ; $481f
	call ExchangeLinkFrameByteSlave ; $4822
	call SerialDecodeInput ; $4825
	ldh a, [hLinkInput] ; $4828
	call SoftResetIfABStartSelect ; $482a
	call SerialEncodeInput ; $482d
	pop hl ; $4830
	pop bc ; $4831
	ret ; $4832
RunLinkInputFrame:
	ld hl, hMatchFrameCounter ; $4833
	inc [hl] ; $4836
	ldh a, [hLinkState] ; $4837
	cp LINKSTATE_SLAVE ; $4839
	jr z, .slave ; $483b
	call RunLinkInputFrameMaster ; $483d
	jr .done ; $4840
.slave:
	call RunLinkInputFrameSlave ; $4842
.done:
	ret ; $4845
UpdateLinkSession:
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld a, [wLinkSessionActive] ; $484a
	or a ; $484d
	jp z, .done ; $484e
	ldh a, [hLinkExchangeActive] ; $4851
	or a ; $4853
	jp nz, .frameLoop ; $4854
	sound BGM_NONE ; $4857
	call DisableLCDSafely ; $4859
	ld a, $01 ; $485c
	ldh [hLinkExchangeActive], a ; $485e
	farcall ExchangeLinkReadySignal ; $4860
	ldh a, [hLinkState] ; $4863
	cp LINKSTATE_SLAVE ; $4865
	jp z, .asSlave ; $4867
	cp LINKSTATE_MASTER ; $486a
	jr z, .asMaster ; $486c
	call LinkErrorReset ; $486e
.asMaster:
	ld a, $40 ; $4871
	ldh [hLinkTxSeqBits], a ; $4873
	call ShortDelay ; $4875
	call ShortDelay ; $4878
	call ShortDelay ; $487b
	call ShortDelay ; $487e
	call ShortDelay ; $4881
	call ShortDelay ; $4884
	call ShortDelay ; $4887
	call ShortDelay ; $488a
	call ShortDelay ; $488d
	call ShortDelay ; $4890
	call ShortDelay ; $4893
	call ShortDelay ; $4896
	call ShortDelay ; $4899
	call ShortDelay ; $489c
	call ShortDelay ; $489f
	call ShortDelay ; $48a2
	jr .encode ; $48a5
.asSlave:
	xor a ; $48a7
	ldh [hLinkTransferDone], a ; $48a8
	ld a, $80 ; $48aa
	ldh [hLinkTxSeqBits], a ; $48ac
.encode:
	xor a ; $48ae
	ldh [hLinkPlayerCount], a ; $48af
	call SerialEncodeInput ; $48b1
	farcall PrimeSlaveSerialReply ; $48b4
	xor a ; $48b7
	ldh [hLinkRemoteInputPrev], a ; $48b8
	ld hl, wCharInputSource ; $48ba
	wram_bank $04 ; $48bd
	ld [hl], $05 ; $48c3
	wram_bank $05 ; $48c5
	ld [hl], $06 ; $48cb
	wram_bank $04 ; $48cd
	xor a ; $48d3
	ldh [hLinkRxByte], a ; $48d4
	ldh [hLinkTransferDone], a ; $48d6
	ld a, $01 ; $48d8
	ldh [hLinkAckRequired], a ; $48da
	call EnableLCD ; $48dc
.frameLoop:
	xor a ; $48df
	ldh [hMatchFrameCounter], a ; $48e0
	push af ; $48e2
	farcall SyncLinkFrame ; $48e3
	pop af ; $48e6
	push af ; $48e7
	farcall SyncLinkFrame ; $48e8
	pop af ; $48eb
	push af ; $48ec
	farcall SyncLinkFrame ; $48ed
	pop af ; $48f0
.done:
	pop hl ; $48f1
	pop de ; $48f2
	pop bc ; $48f3
	pop af ; $48f4
	ret ; $48f5
EndLinkSession:
	xor a ; $48f6
	ld [wLinkSessionActive], a ; $48f7
	call InitSerialLink ; $48fa
	ret ; $48fd
ExchangeHandshakeBlockMaster:
	ld hl, wTextBuffer ; $48fe
	ld c, $28 ; $4901
	ld a, $02 ; $4903
.fillLoop:
	ld [hl+], a ; $4905
	dec c ; $4906
	jr nz, .fillLoop ; $4907
	ld de, wTextBuffer ; $4909
	ld c, $28 ; $490c
	call ExchangeNibbleBlockMaster ; $490e
	ret ; $4911
ExchangeHandshakeBlockSlave:
	ld hl, wTextBuffer ; $4912
	ld c, $28 ; $4915
	ld a, $08 ; $4917
.fillLoop:
	ld [hl+], a ; $4919
	dec c ; $491a
	jr nz, .fillLoop ; $491b
	ld de, wTextBuffer ; $491d
	ld c, $28 ; $4920
	call ExchangeNibbleBlockSlave ; $4922
	ret ; $4925
ExchangeLinkBlockToWram5:
	call DisableLCDSafely ; $4926
	di ; $4929
	ldh a, [rIF] ; $492a
	and $08 ; $492c
	ldh [rIF], a ; $492e
	ei ; $4930
	xor a ; $4931
	ldh [hLinkExchangeActive], a ; $4932
	call LongDelay ; $4934
	call LongDelay ; $4937
	call LongDelay ; $493a
	ldh a, [hLinkState] ; $493d
	cp LINKSTATE_SLAVE ; $493f
	jr z, .asSlave ; $4941
	cp LINKSTATE_MASTER ; $4943
	jr z, .asMaster ; $4945
	call LinkErrorReset ; $4947
.asMaster:
	call ExchangeHandshakeBlockMaster ; $494a
	jr .copyToWram ; $494d
.asSlave:
	call ExchangeHandshakeBlockSlave ; $494f
.copyToWram:
	wram_bank $05 ; $4952
	ld hl, wTextBuffer + 80 ; $4958
	ld c, $28 ; $495b
	call PackNibblesToBytes ; $495d
	ld a, $01 ; $4960
	ldh [hLinkExchangeActive], a ; $4962
	di ; $4964
	ld a, $09 ; $4965
	ldh [rIF], a ; $4967
	ei ; $4969
	call EnableLCD ; $496a
	ret ; $496d
ExchangeLinkDataBlock:
	push hl ; $496e
	push de ; $496f
	push bc ; $4970
	call WaitVBlank ; $4971
	call DisableLCDSafely ; $4974
	di ; $4977
	ldh a, [rIF] ; $4978
	and $08 ; $497a
	ldh [rIF], a ; $497c
	ei ; $497e
	xor a ; $497f
	ldh [hLinkExchangeActive], a ; $4980
	call LongDelay ; $4982
	call LongDelay ; $4985
	call LongDelay ; $4988
	pop bc ; $498b
	pop de ; $498c
	pop hl ; $498d
	ldh a, [hLinkState] ; $498e
	cp LINKSTATE_SLAVE ; $4990
	jr z, .asSlave ; $4992
	cp LINKSTATE_MASTER ; $4994
	jr z, .asMaster ; $4996
	call LinkErrorReset ; $4998
.asMaster:
	call ExchangeNibbleBlockMaster ; $499b
	jr .unpack ; $499e
.asSlave:
	call ExchangeNibbleBlockSlave ; $49a0
.unpack:
	call PackNibblesToBytes ; $49a3
	di ; $49a6
	ld a, $09 ; $49a7
	ldh [rIF], a ; $49a9
	ei ; $49ab
	call EnableLCD ; $49ac
	ret ; $49af
