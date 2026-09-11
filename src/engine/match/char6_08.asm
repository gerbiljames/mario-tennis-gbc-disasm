UpdateChargeFlash:
	ld a, [wCharChargeFlashOn] ; $764b
	and a ; $764e
	ret z ; $764f
	ld a, [wCharSwingFrames] ; $7650
	cp $14 ; $7653
	ret c ; $7655
	and $04 ; $7656
	jr z, EndChargeFlash ; $7658
	ld hl, wCharChargeFlashGfxLoaded ; $765a
	ld a, [hl] ; $765d
	and a ; $765e
	ret nz ; $765f
	ld [hl], $01 ; $7660
	call LoadCharChargeFlashGfx ; $7662
	ret ; $7665
EndChargeFlash:
	ld hl, wCharChargeFlashGfxLoaded ; $7666
	ld a, [hl] ; $7669
	and a ; $766a
	ret z ; $766b
	ld [hl], $00 ; $766c
	call ReloadCharFrameGfx ; $766e
	ret ; $7671
BuildCharSpriteSlots:
	ld hl, wCharPosHeight + 1 ; $7672
	ld a, [hl+] ; $7675
	ld b, [hl] ; $7676
	ld c, a ; $7677
	ld hl, wCharPosDepth + 1 ; $7678
	ld a, [hl+] ; $767b
	ld d, [hl] ; $767c
	ld e, a ; $767d
	ld hl, wCharPosX + 1 ; $767e
	ld a, [hl+] ; $7681
	ld h, [hl] ; $7682
	ld l, a ; $7683
	call ProjectWorldToScreen_08 ; $7684
	call ApplyCameraProjection ; $7687
	ld a, d ; $768a
	ld [wCharScreenX], a ; $768b
	ld a, e ; $768e
	ld [wCharScreenY], a ; $768f
	ld a, d ; $7692
	add $08 ; $7693
	cp $b0 ; $7695
	jr nc, DrawOffscreenCharArrow ; $7697
	ld a, e ; $7699
	cp $a0 ; $769a
	jr nc, DrawOffscreenCharArrow ; $769c
	ld hl, wCharPosDepth + 1 ; $769e
	ld a, [hl+] ; $76a1
	ld h, [hl] ; $76a2
	ld l, a ; $76a3
	add hl, hl ; $76a4
	add hl, hl ; $76a5
	add hl, hl ; $76a6
	ld a, h ; $76a7
	add $80 ; $76a8
	ld [wCharDepthKey], a ; $76aa
	ld a, [wCharFacingOctant] ; $76ad
	ld_hl_indexed BuildCharSpriteSlotsTable ; $76b0
	ld a, [wCharSpriteAttr] ; $76b7
	or $08 ; $76ba
	xor [hl] ; $76bc
	ld b, a ; $76bd
	ld a, [wCharTileBase] ; $76be
	ld c, a ; $76c1
	ld a, [wCharFacingOctant] ; $76c2
	cp $02 ; $76c5
	jr z, .mirrorSprite ; $76c7
	cp $06 ; $76c9
	jr z, .mirrorSprite ; $76cb
	jr .store ; $76cd
.mirrorSprite:
	ld a, [wCharMirrorAttrMask] ; $76cf
	xor b ; $76d2
	ld b, a ; $76d3
.store:
	ld hl, wCharSpriteSlot ; $76d4
	ld a, c ; $76d7
	ld [hl+], a ; $76d8
	ld a, b ; $76d9
	ld [hl+], a ; $76da
	ld a, e ; $76db
	ld [hl+], a ; $76dc
	ld [hl], d ; $76dd
	ld a, [wStandingShadowsEnabled] ; $76de
	and a ; $76e1
	ret z ; $76e2
	ld hl, wCharFlags ; $76e3
	bit CHARB_AIRBORNE, [hl] ; $76e6
	ret nz ; $76e8
	ldh a, [hMatchFrameCounter] ; $76e9
	and $01 ; $76eb
	ret z ; $76ed
	ld hl, wCharGroundShadowSlot ; $76ee
	ld bc, $0858 ; $76f1
	ld a, c ; $76f4
	ld [hl+], a ; $76f5
	ld a, b ; $76f6
	ld [hl+], a ; $76f7
	ld a, e ; $76f8
	ld [hl+], a ; $76f9
	ld [hl], d ; $76fa
	ret ; $76fb
BuildCharSpriteSlotsTable:
	; $76fc, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
DrawOffscreenCharArrow:
	ld a, [wOffscreenArrowsEnabled] ; $7704
	and a ; $7707
	ret z ; $7708
	ldh a, [hMatchFrameCounter] ; $7709
	and $01 ; $770b
	ret z ; $770d
	ld a, d ; $770e
	add $f8 ; $770f
	cp $90 ; $7711
	jr c, .clampDepth ; $7713
	ld a, [wCharPosX + 2] ; $7715
	bit 7, a ; $7718
	ld d, $08 ; $771a
	jr nz, .clampDepth ; $771c
	ld d, $98 ; $771e
.clampDepth:
	ld a, e ; $7720
	add $f0 ; $7721
	cp $80 ; $7723
	jr c, .queue ; $7725
	ld a, [wCharPosDepth + 2] ; $7727
	bit 7, a ; $772a
	ld e, $10 ; $772c
	jr nz, .queue ; $772e
	ld e, $90 ; $7730
.queue:
	ld a, [wCharSpriteAttr] ; $7732
	ld b, a ; $7735
	res 5, b ; $7736
	ld a, [wCharIndex] ; $7738
	add a ; $773b
	add a ; $773c
	add a ; $773d
	add $00 ; $773e
	ld c, a ; $7740
	call QueueSprite16 ; $7741
	ret ; $7744
BuildAirborneShadowSlot:
	ld hl, wCharFlags ; $7745
	bit CHARB_AIRBORNE, [hl] ; $7748
	ret z ; $774a
	ld bc, $0000 ; $774b
	ld hl, wCharPosDepth + 1 ; $774e
	ld a, [hl+] ; $7751
	ld d, [hl] ; $7752
	ld e, a ; $7753
	ld hl, wCharPosX + 1 ; $7754
	ld a, [hl+] ; $7757
	ld h, [hl] ; $7758
	ld l, a ; $7759
	call ProjectWorldToScreen_08 ; $775a
	call ApplyCameraProjection ; $775d
	ld hl, wCharPosHeight + 1 ; $7760
	ld a, [hl+] ; $7763
	ld h, [hl] ; $7764
	ld l, a ; $7765
	bit 7, h ; $7766
	jr z, .fillSlot ; $7768
	xor a ; $776a
	sub l ; $776b
	ld l, a ; $776c
	sbc a ; $776d
	sub h ; $776e
	ld h, a ; $776f
.fillSlot:
	ld bc, $ffe0 ; $7770
	xor a ; $7773
	add hl, bc ; $7774
	jr nc, .done ; $7775
	inc a ; $7777
	add hl, bc ; $7778
	jr nc, .done ; $7779
	inc a ; $777b
	add hl, bc ; $777c
	jr nc, .done ; $777d
	inc a ; $777f
.done:
	ld bc, $0850 ; $7780
	add a ; $7783
	add c ; $7784
	ld c, a ; $7785
	ld hl, wCharAirShadowSlot ; $7786
	ld a, c ; $7789
	ld [hl+], a ; $778a
	ld a, b ; $778b
	ld [hl+], a ; $778c
	ld a, e ; $778d
	ld [hl+], a ; $778e
	ld [hl], d ; $778f
	ret ; $7790
; Interprets the animation script at wCharAnimScriptPtr, one command per frame
; once wCharAnimDelay expires. Commands are words: below $f0 is [delay, frame],
; $ff rewinds to wCharAnimScriptBase + d, $fe switches animation, $fb toggles
; the flip bits of wCharSpriteAttr. A frame change sets bit 6 of
; wCharSpriteDirty so ReloadCharFacingTiles uploads new tiles.
StepCharAnimation:
	ld a, [wCharAnimDelay] ; $7791
	and a ; $7794
	jr nz, .keepFrame ; $7795
.nextCommand:
	ld hl, wCharAnimScriptPtr ; $7797
	ld a, [hl+] ; $779a
	ld h, [hl] ; $779b
	ld l, a ; $779c
	ld a, [wCharObjectBank] ; $779d
	call FarReadWordDI ; $77a0
	ld e, c ; $77a3
	ld d, b ; $77a4
	ld a, e ; $77a5
	cp $f0 ; $77a6
	jr c, .setDelay ; $77a8
	cp $ff ; $77aa
	jr z, .jumpToFrames ; $77ac
	cp $fe ; $77ae
	jr z, .setAnimation ; $77b0
	cp $fb ; $77b2
	jr z, .toggleFlip ; $77b4
	ld a, $ff ; $77b6
	ld [wCharAnimDelay], a ; $77b8
	jr .keepFrame ; $77bb
.jumpToFrames:
	ld hl, wCharAnimScriptBase ; $77bd
	ld a, [hl+] ; $77c0
	add d ; $77c1
	ld [wCharAnimScriptPtr], a ; $77c2
	ld a, [hl+] ; $77c5
	adc $00 ; $77c6
	ld [wCharAnimScriptPtr + 1], a ; $77c8
	jr .nextCommand ; $77cb
.setAnimation:
	call SetCharAnimation ; $77cd
	jr .nextCommand ; $77d0
.toggleFlip:
	ld hl, wCharSpriteAttr ; $77d2
	ld a, [hl] ; $77d5
	and $0f ; $77d6
	xor d ; $77d8
	ld [hl], a ; $77d9
	ld hl, wCharAnimScriptPtr ; $77da
	ld a, [hl] ; $77dd
	add $02 ; $77de
	ld [hl+], a ; $77e0
	jr nc, .nextCommand ; $77e1
	inc [hl] ; $77e3
	jr .nextCommand ; $77e4
.setDelay:
	ld a, d ; $77e6
	ld [wCharAnimDelay], a ; $77e7
	ld hl, wCharAnimScriptPtr ; $77ea
	ld a, [hl] ; $77ed
	add $02 ; $77ee
	ld [hl+], a ; $77f0
	jr nc, .storeFrame ; $77f1
	inc [hl] ; $77f3
	jr .storeFrame ; $77f4
.keepFrame:
	ld a, [wCharAnimFrame] ; $77f6
	ld e, a ; $77f9
.storeFrame:
	ld hl, wCharAnimDelay ; $77fa
	dec [hl] ; $77fd
	ld hl, wCharAnimFrame ; $77fe
	ld a, [hl] ; $7801
	cp e ; $7802
	jr z, .done ; $7803
	ld [hl], e ; $7805
	ld hl, wCharSpriteDirty ; $7806
	set 6, [hl] ; $7809
.done:
	ret ; $780b
ReadCharInput:
	xor a ; $780c
	ld [wCharInputBits], a ; $780d
	ld a, [wCharInputSource] ; $7810
	add a ; $7813
	ld_hl_indexed CharInputPtrs ; $7814
	ld a, [hl+] ; $781b
	ld h, [hl] ; $781c
	ld l, a ; $781d
	jp hl ; $781e
CharInputPtrs:
	; $781f, 14 bytes (records:2)
	dw ReadCharPadInput ; record 0
	dw CharInputHandler1_08 ; record 1
	dw ReadCharPadInput ; record 2
	dw ReadCharPadInput ; record 3
	dw CharInputHandler4_08 ; record 4
	dw CharInputHandler5_08 ; record 5
	dw CharInputHandler6_08 ; record 6
CharInputHandler4_08:
	ldh a, [hLinkInput] ; $782d
	ld [wCharInputBits], a ; $782f
	ret ; $7832
CharInputHandler5_08:
	ldh a, [hLinkState] ; $7833
	cp LINKSTATE_SLAVE ; $7835
	jr z, CharInputHandler6_08.remoteLive ; $7837
	cp LINKSTATE_MASTER ; $7839
	jr z, CharInputHandler6_08.remoteBuffered ; $783b
	jr ReadCharPadInput ; $783d
CharInputHandler6_08:
	ldh a, [hLinkState] ; $783f
	cp LINKSTATE_SLAVE ; $7841
	jr z, .remoteBuffered ; $7843
	cp LINKSTATE_MASTER ; $7845
	jr z, .remoteLive ; $7847
	jr ReadCharPadInput ; $7849
.remoteBuffered:
	ldh a, [hLinkRemoteInputBuf] ; $784b
	jr .store ; $784d
.remoteLive:
	ldh a, [hLinkRemoteInput] ; $784f
.store:
	ld [wCharInputBits], a ; $7851
	ret ; $7854
ReadCharPadInput:
	ldh a, [hPlayerInputFlags] ; $7855
	and $f0 ; $7857
	ld c, a ; $7859
	ldh a, [hInputRisingEdge] ; $785a
	and $0f ; $785c
	or c ; $785e
	ld [wCharInputBits], a ; $785f
	ret ; $7862
CharInputHandler1_08:
	ld hl, wAiActionTimer ; $7863
	ld a, [hl] ; $7866
	and a ; $7867
	jr z, .player2 ; $7868
	dec [hl] ; $786a
	ret ; $786b
.player2:
	ld hl, wAiSecondButtonDelay ; $786c
	ld a, [hl] ; $786f
	and a ; $7870
	jr z, .maskInput ; $7871
	dec [hl] ; $7873
.maskInput:
	ld a, [wMatchIsDoubles] ; $7874
	and a ; $7877
	jr z, .store ; $7878
	ld a, [wCharServeRole] ; $787a
	and $02 ; $787d
	jp z, .checkCpu ; $787f
	ld a, [wCharState] ; $7882
	rst Rst00 ; $7885
	dw AiPhaseNoop ; $7886 jumptable
	dw AiRallyStateNetPlayer ; $7888 jumptable
	dw AiRecoverStateNetPlayer ; $788a jumptable
	dw AiServeState ; $788c jumptable
	dw AiPhaseNoop ; $788e jumptable
	dw AiPhaseNoop ; $7890 jumptable
	dw AiPhaseNoop ; $7892 jumptable
	dw AiPhaseNoop ; $7894 jumptable
.checkCpu:
	ld a, [wCharState] ; $7896
	rst Rst00 ; $7899
	dw AiPhaseNoop ; $789a jumptable
	dw AiRallyStateBaseliner ; $789c jumptable
	dw AiRecoverStateBaseliner ; $789e jumptable
	dw AiServeState ; $78a0 jumptable
	dw AiPhaseNoop ; $78a2 jumptable
	dw AiPhaseNoop ; $78a4 jumptable
	dw AiPhaseNoop ; $78a6 jumptable
	dw AiPhaseNoop ; $78a8 jumptable
.store:
	ld a, [wCharState] ; $78aa
	rst Rst00 ; $78ad
	dw AiPhaseNoop ; $78ae jumptable
	dw AiRallyStateSingles ; $78b0 jumptable
	dw AiRecoverStateSingles ; $78b2 jumptable
	dw AiServeState ; $78b4 jumptable
	dw AiPhaseNoop ; $78b6 jumptable
	dw AiPhaseNoop ; $78b8 jumptable
	dw AiPhaseNoop ; $78ba jumptable
	dw AiPhaseNoop ; $78bc jumptable
CheckCharNearTarget:
	ld hl, wCharPosX + 1 ; $78be
	ld a, [hl+] ; $78c1
	ld b, [hl] ; $78c2
	ld c, a ; $78c3
	ld hl, wCharWalkTargetX ; $78c4
	ld a, [hl+] ; $78c7
	ld h, [hl] ; $78c8
	ld l, a ; $78c9
	ld a, l ; $78ca
	sub c ; $78cb
	ld l, a ; $78cc
	ld a, h ; $78cd
	sbc b ; $78ce
	ld h, a ; $78cf
	bit 7, h ; $78d0
	jr z, .absX ; $78d2
	xor a ; $78d4
	sub l ; $78d5
	ld l, a ; $78d6
	sbc a ; $78d7
	sub h ; $78d8
	ld h, a ; $78d9
.absX:
	ld de, $ffe8 ; $78da
	add hl, de ; $78dd
	jr c, .tooFar ; $78de
	ld hl, wCharPosDepth + 1 ; $78e0
	ld a, [hl+] ; $78e3
	ld b, [hl] ; $78e4
	ld c, a ; $78e5
	ld hl, wCharWalkTargetDepth ; $78e6
	ld a, [hl+] ; $78e9
	ld h, [hl] ; $78ea
	ld l, a ; $78eb
	ld a, l ; $78ec
	sub c ; $78ed
	ld l, a ; $78ee
	ld a, h ; $78ef
	sbc b ; $78f0
	ld h, a ; $78f1
	bit 7, h ; $78f2
	jr z, .absDepth ; $78f4
	xor a ; $78f6
	sub l ; $78f7
	ld l, a ; $78f8
	sbc a ; $78f9
	sub h ; $78fa
	ld h, a ; $78fb
.absDepth:
	ld de, $ffe8 ; $78fc
	add hl, de ; $78ff
	jr c, .tooFar ; $7900
	ld a, $01 ; $7902
	and a ; $7904
	ret ; $7905
.tooFar:
	xor a ; $7906
	ret ; $7907
AiSteerTowardTarget:
	ld hl, wCharPosX + 1 ; $7908
	ld a, [hl+] ; $790b
	ld b, [hl] ; $790c
	ld c, a ; $790d
	ld hl, wCharWalkTargetX ; $790e
	ld a, [hl+] ; $7911
	ld d, [hl] ; $7912
	ld e, a ; $7913
	ld a, e ; $7914
	sub c ; $7915
	ld e, a ; $7916
	ld a, d ; $7917
	sbc b ; $7918
	ld d, a ; $7919
	ld hl, wCharPosDepth + 1 ; $791a
	ld a, [hl+] ; $791d
	ld b, [hl] ; $791e
	ld c, a ; $791f
	ld hl, wCharWalkTargetDepth ; $7920
	ld a, [hl+] ; $7923
	ld h, [hl] ; $7924
	ld l, a ; $7925
	ld a, l ; $7926
	sub c ; $7927
	ld l, a ; $7928
	ld a, h ; $7929
	sbc b ; $792a
	ld h, a ; $792b
	call AngleFromVectorCoarse ; $792c
	swap a ; $792f
	and $0f ; $7931
	ld_hl_indexed AngleToDpadTable_08 ; $7933
	ld a, [wCharInputBits] ; $793a
	and $0f ; $793d
	or [hl] ; $793f
	ld [wCharInputBits], a ; $7940
	ret ; $7943
AiSteerTowardBall:
	ld hl, wBallRelCharX ; $7944
	ld a, [hl+] ; $7947
	ld d, [hl] ; $7948
	ld e, a ; $7949
	ld hl, wBallRelCharDepth ; $794a
	ld a, [hl+] ; $794d
	ld h, [hl] ; $794e
	ld l, a ; $794f
	call AngleFromVectorCoarse ; $7950
	swap a ; $7953
	and $0f ; $7955
	ld_hl_indexed AngleToDpadTable_08 ; $7957
	ld a, [wCharInputBits] ; $795e
	and $0f ; $7961
	or [hl] ; $7963
	ld [wCharInputBits], a ; $7964
	ret ; $7967
AiAdvancePhase:
	ld hl, wAiPhase ; $7968
	inc [hl] ; $796b
