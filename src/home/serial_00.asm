VBlankHandler:
	push af ; $2749
	ldh a, [hVBlankSuppressed] ; $274a
	or a ; $274c
	jp nz, .restore ; $274d
	push bc ; $2750
	push de ; $2751
	push hl ; $2752
	ldh a, [rVBK] ; $2753
	push af ; $2755
	call ApplyPendingPaletteUpdates ; $2756
	ldh a, [hVBlankOccurred] ; $2759
	or a ; $275b
	jr nz, .nonZero2 ; $275c
	ldh a, [hShowDebugConsole] ; $275e
	or a ; $2760
	jr nz, .compare ; $2761
	ldh a, [hScrollX] ; $2763
	ldh [rSCX], a ; $2765
	ldh a, [hScrollY] ; $2767
	ldh [rSCY], a ; $2769
	ldh a, [rLCDC] ; $276b
	and $f7 ; $276d
	ldh [rLCDC], a ; $276f
	jr .checkSpriteBufferPage ; $2771
.compare:
	cp $01 ; $2773
	jr nz, .ne01 ; $2775
	xor a ; $2777
	ldh [rSCX], a ; $2778
	ld a, $40 ; $277a
	ldh [rSCY], a ; $277c
	ldh a, [rLCDC] ; $277e
	or $08 ; $2780
	ldh [rLCDC], a ; $2782
	jr .checkSpriteBufferPage ; $2784
.ne01:
	ldh a, [hScrollX] ; $2786
	ldh [rSCX], a ; $2788
	ldh a, [hScrollY] ; $278a
	ldh [rSCY], a ; $278c
.checkSpriteBufferPage:
	ld a, [wSpriteBufferPage] ; $278e
	xor $05 ; $2791
	ldh [hOAMDMARoutine + 1], a ; $2793
	call hOAMDMARoutine ; $2795
	call ProcessBGBlitQueue ; $2798
	or a ; $279b
	jr nz, .nonZero ; $279c
	call ProcessVRAMCopyQueues ; $279e
.nonZero:
	ldh a, [hDebugStepMode] ; $27a1
	or a ; $27a3
	jr z, .zero ; $27a4
	call UpdateDebugOverlay ; $27a6
.zero:
	ld a, $01 ; $27a9
	ldh [hVBlankOccurred], a ; $27ab
	ld hl, hVBlankCounter ; $27ad
	inc [hl] ; $27b0
.nonZero2:
	ldh a, [hLinkExchangeActive] ; $27b1
	or a ; $27b3
	jr nz, .updateGameTimer ; $27b4
	call ReadJoypad ; $27b6
	ldh a, [hPlayerInputFlags] ; $27b9
	cp $0f ; $27bb
	jp z, SoftReset ; $27bd
	call AdvanceRandomSeed ; $27c0
.updateGameTimer:
	call UpdateGameTimer ; $27c3
	call UpdateFadeOut ; $27c6
	call UpdateFadeIn ; $27c9
	call UpdateSoundEngine ; $27cc
	pop af ; $27cf
	ldh [rVBK], a ; $27d0
	pop hl ; $27d2
	pop de ; $27d3
	pop bc ; $27d4
.restore:
	pop af ; $27d5
	reti ; $27d6
TimerHandler:
	push af ; $27d7
	ldh a, [hLinkState] ; $27d8
	cp LINKSTATE_SLAVE ; $27da
	jr nz, .ne02 ; $27dc
	ldh a, [rIF] ; $27de
	and $08 ; $27e0
	jr nz, .restore ; $27e2
.ne02:
	ldh a, [rLCDC] ; $27e4
	bit 7, a ; $27e6
	jr nz, .restore ; $27e8
	push bc ; $27ea
	push de ; $27eb
	push hl ; $27ec
	call UpdateSoundEngine ; $27ed
	pop hl ; $27f0
	pop de ; $27f1
	pop bc ; $27f2
.restore:
	pop af ; $27f3
	reti ; $27f4
LCDStatHandler:
	push af ; $27f5
	push bc ; $27f6
	ld a, [wRasterScrollStartLY] ; $27f7
	ld b, a ; $27fa
	ldh a, [rLY] ; $27fb
	cp b ; $27fd
	jr c, .restore ; $27fe
	ld a, [wRasterScrollX] ; $2800
	ldh [rSCX], a ; $2803
	ld a, [wRasterScrollEndLY] ; $2805
	ld b, a ; $2808
	ldh a, [rLY] ; $2809
	cp b ; $280b
	jr c, .restore ; $280c
	xor a ; $280e
	ldh [rSCX], a ; $280f
.restore:
	pop bc ; $2811
	pop af ; $2812
	reti ; $2813
WaitVBlank:
	xor a ; $2814
	ldh [hVBlankOccurred], a ; $2815
.waitLoop:
	ei ; $2817
	nop ; $2818
	di ; $2819
	ldh a, [hVBlankOccurred] ; $281a
	and a ; $281c
	jr z, .waitLoop ; $281d
	ei ; $281f
	ret ; $2820
ShortDelay:
	push af ; $2821
	push bc ; $2822
	ld bc, $007d ; $2823
.loop:
	dec bc ; $2826
	ld a, c ; $2827
	or b ; $2828
	jr nz, .loop ; $2829
	pop bc ; $282b
	pop af ; $282c
	ret ; $282d
WaitSerialTransfer:
	push bc ; $282e
	ld bc, $c350 ; $282f
.waitLoop:
	ei ; $2832
	nop ; $2833
	di ; $2834
	ldh a, [hLinkTransferDone] ; $2835
	and a ; $2837
	jr nz, .received ; $2838
	dec bc ; $283a
	ld a, b ; $283b
	or c ; $283c
	jr nz, .waitLoop ; $283d
	ei ; $283f
	scf ; $2840
	jr .done ; $2841
.received:
	xor a ; $2843
	ldh [hLinkTransferDone], a ; $2844
	scf ; $2846
	ccf ; $2847
.done:
	ei ; $2848
	pop bc ; $2849
	ret ; $284a
LinkErrorReset:
	farcall ShowLinkErrorScreen ; $284b
	jp SoftReset ; $284e
ReadJoypadThunk:
	call ReadJoypad ; $2851
	ret ; $2854
SoftResetIfABStartSelect:
	xor $0f ; $2855
	jr nz, .done ; $2857
	jp SoftReset ; $2859
.done:
	ret ; $285c
JumpSoftReset:
	jp SoftReset ; $285d
	ret ; $2860
SerialHandler:
	push af ; $2861
	push bc ; $2862
	push de ; $2863
	push hl ; $2864
	ldh a, [hLinkShiftQueue] ; $2865
	add a ; $2867
	jr c, .carry ; $2868
	ldh a, [rSB] ; $286a
	ld b, a ; $286c
	ldh [hLinkRxByte], a ; $286d
.carry:
	ldh a, [hLinkState] ; $286f
	cp LINKSTATE_MASTER ; $2871
	jr nz, .ne01 ; $2873
	ldh [hLinkTransferDone], a ; $2875
	pop hl ; $2877
	pop de ; $2878
	pop bc ; $2879
	pop af ; $287a
	reti ; $287b
.ne01:
	ldh a, [hLinkAckRequired] ; $287c
	or a ; $287e
	jr z, .step4 ; $287f
	ldh a, [hLinkTxPending] ; $2881
	or a ; $2883
	jr z, .zero ; $2884
	xor a ; $2886
	ldh [hLinkTxPending], a ; $2887
	jr .step4 ; $2889
.zero:
	ldh a, [hLinkShiftQueue] ; $288b
	ld a, $40 ; $288d
	ldh [hLinkShiftQueue], a ; $288f
.step4:
	ldh a, [hLinkShiftQueue] ; $2891
	add a ; $2893
	ldh [hLinkShiftQueue], a ; $2894
	jr c, .restore ; $2896
	ld a, $01 ; $2898
	ldh [hLinkTransferDone], a ; $289a
.restore:
	pop hl ; $289c
	pop de ; $289d
	pop bc ; $289e
	ldh a, [hLinkTxByte] ; $289f
	ldh [rSB], a ; $28a1
	push af ; $28a3
	ld a, SC_FAST | SC_EXTERNAL ; $28a4
	ldh [rSC], a ; $28a6
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $28a8
	ldh [rSC], a ; $28aa
	pop af ; $28ac
	pop af ; $28ad
	reti ; $28ae
IncrementLinkFrameCounter:
	ldh a, [hLinkCounter] ; $28af
	inc a ; $28b1
	cp $08 ; $28b2
	jr z, .done ; $28b4
	ldh [hLinkCounter], a ; $28b6
.done:
	ret ; $28b8
InitSerialLink:
	ld a, LINKMSG_NONE ; $28b9
	ldh [rSB], a ; $28bb
	xor a ; $28bd
	ldh [hLinkRxByte], a ; $28be
	ld a, LINKMSG_NONE ; $28c0
	ldh [hLinkTxByte], a ; $28c2
	ld a, SC_FAST | SC_EXTERNAL ; $28c4
	ldh [rSC], a ; $28c6
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $28c8
	ldh [rSC], a ; $28ca
	xor a ; $28cc
	ldh [hLinkState], a ; $28cd
	ldh [hLinkErrorFlags], a ; $28cf
	ldh [hUnusedLinkByte], a ; $28d1
	ldh [hLinkCounter], a ; $28d3
	ldh [hLinkInput], a ; $28d5
	ldh [hLinkRemoteInput], a ; $28d7
	ldh [hLinkRemoteInputBuf], a ; $28d9
	ldh [hLinkTxInput], a ; $28db
	ldh [hLinkTransferDone], a ; $28dd
	ldh [hLinkExchangeActive], a ; $28df
	ldh [hLinkTxSeqBits], a ; $28e1
	ldh [hUnusedLinkSlot], a ; $28e3
	ldh [hLinkLastRxMirror], a ; $28e5
	ldh [hLinkLastRxByte], a ; $28e7
	ldh [hLinkPayloadKind], a ; $28e9
	ldh [hLinkRemoteInputPrev], a ; $28eb
	ldh [hLinkAckRequired], a ; $28ed
	ldh [hLinkShiftQueue], a ; $28ef
	ldh [hLinkPlayerCount], a ; $28f1
	ldh [hVBlankSuppressed], a ; $28f3
	ldh [hMatchFrameCounter], a ; $28f5
	ret ; $28f7
ResetSerialState:
	xor a ; $28f8
	ldh [hLinkRxByte], a ; $28f9
	ldh [hLinkTxByte], a ; $28fb
	ldh [hLinkErrorFlags], a ; $28fd
	ldh [hUnusedLinkByte], a ; $28ff
	ldh [hLinkCounter], a ; $2901
	ldh [hLinkInput], a ; $2903
	ldh [hLinkRemoteInput], a ; $2905
	ldh [hLinkRemoteInputBuf], a ; $2907
	ldh [hLinkTxInput], a ; $2909
	ldh [hLinkTransferDone], a ; $290b
	ldh [hLinkTxSeqBits], a ; $290d
	ldh [hUnusedLinkSlot], a ; $290f
	ldh [hLinkLastRxMirror], a ; $2911
	ldh [hLinkLastRxByte], a ; $2913
	ldh [hLinkPayloadKind], a ; $2915
	ldh [hLinkRemoteInputPrev], a ; $2917
	ldh [hLinkShiftQueue], a ; $2919
	ldh [hLinkAckRequired], a ; $291b
	ldh [hLinkPlayerCount], a ; $291d
	ldh [hVBlankSuppressed], a ; $291f
	ldh [hMatchFrameCounter], a ; $2921
	ret ; $2923
; Sends the local player's input over the link, a few bits per frame.
; hLinkTxInput holds what is still owed: the whole low nibble goes as $3f, else
; bit 3 as $30, else bit 2 as $0c, else the low pair -- and the remainder is
; stored back, so a burst of presses is spread over several frames rather than
; dropped. hLinkTxSeqBits is OR'd into every byte sent and inverted each frame,
; which is how the peer tells a fresh frame from a repeat.
SerialEncodeInput:
	push bc ; $2924
	push hl ; $2925
	ldh a, [hLinkTxInput] ; $2926
	ld b, a ; $2928
	and $0f ; $2929
	cp $0f ; $292b
	jr nz, .checkBit3 ; $292d
	ld a, $3f ; $292f
	ld b, $0f ; $2931
	jr .storeQueue ; $2933
.checkBit3:
	bit 3, a ; $2935
	jr z, .checkBit2 ; $2937
	ld a, $30 ; $2939
	ld b, $08 ; $293b
	jr .storeQueue ; $293d
.checkBit2:
	bit 2, a ; $293f
	jr z, .pairBits ; $2941
	ld a, $0c ; $2943
	ld b, $04 ; $2945
	jr .storeQueue ; $2947
.pairBits:
	and $03 ; $2949
	ld c, a ; $294b
	ld a, b ; $294c
	rra ; $294d
	rra ; $294e
	and $3c ; $294f
	or c ; $2951
	push af ; $2952
	ld a, b ; $2953
	and $f3 ; $2954
	ld b, a ; $2956
	pop af ; $2957
.storeQueue:
	ld c, a ; $2958
	ld a, b ; $2959
	ldh [hLinkTxInput], a ; $295a
	ldh a, [hLinkState] ; $295c
	cp LINKSTATE_MASTER ; $295e
	jr z, .checkSlaveWait ; $2960
	cp LINKSTATE_SLAVE ; $2962
	jr z, .checkSlaveWait ; $2964
	sound SFX_BEEP ; $2966
	xor a ; $2968
	ldh [hLinkRemoteInputBuf], a ; $2969
	ldh [hLinkTxInput], a ; $296b
	ld a, LINKMSG_NONE ; $296d
	ldh [hLinkTxByte], a ; $296f
	call LinkErrorReset ; $2971
.checkSlaveWait:
	ldh a, [hLinkAckRequired] ; $2974
	or a ; $2976
	jr z, .send ; $2977
	ldh a, [hLinkState] ; $2979
	cp LINKSTATE_SLAVE ; $297b
	jr nz, .send ; $297d
.waitAck:
	ei ; $297f
	nop ; $2980
	nop ; $2981
	di ; $2982
	ldh a, [hLinkTxPending] ; $2983
	or a ; $2985
	jr nz, .waitAck ; $2986
.send:
	ldh a, [hLinkTxSeqBits] ; $2988
	or c ; $298a
	di ; $298b
	ldh [hLinkTxByte], a ; $298c
	ldh [hLinkTxPending], a ; $298e
	ei ; $2990
	pop hl ; $2991
	pop bc ; $2992
	ret ; $2993
SerialDecodeInput:
	push af ; $2994
	push bc ; $2995
	ldh a, [hLinkRxByte] ; $2996
	ld b, a ; $2998
	and $c0 ; $2999
	cp $80 ; $299b
	jr z, .decode ; $299d
	cp $40 ; $299f
	jr z, .decode ; $29a1
	sound SFX_BEEP ; $29a3
	xor a ; $29a5
	ldh [hLinkInput], a ; $29a6
	jr .done ; $29a8
.decode:
	ld a, b ; $29aa
	and $3f ; $29ab
	cp $3f ; $29ad
	jr nz, .checkLeftRight ; $29af
	ld a, $0f ; $29b1
	jr .storeRemote ; $29b3
.checkLeftRight:
	cp $30 ; $29b5
	jr nz, .checkUpDown ; $29b7
	ld a, $08 ; $29b9
	jr .storeRemote ; $29bb
.checkUpDown:
	cp $0c ; $29bd
	jr nz, .unpackPair ; $29bf
	ld a, $04 ; $29c1
	jr .storeRemote ; $29c3
.unpackPair:
	ld c, a ; $29c5
	and $03 ; $29c6
	ld b, a ; $29c8
	ld a, c ; $29c9
	rla ; $29ca
	rla ; $29cb
	and $f0 ; $29cc
	or b ; $29ce
.storeRemote:
	ldh [hLinkRemoteInput], a ; $29cf
	ldh a, [hLinkState] ; $29d1
	cp LINKSTATE_MASTER ; $29d3
	jr nz, .asSlave ; $29d5
	ldh a, [hLinkRemoteInputBuf] ; $29d7
	or a ; $29d9
	jr nz, .storeInput ; $29da
	ldh a, [hLinkRemoteInput] ; $29dc
	jr .storeInput ; $29de
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $29e0
	ld b, a ; $29e2
	ldh a, [hLinkRemoteInputPrev] ; $29e3
	ldh [hLinkRemoteInputBuf], a ; $29e5
	ld a, b ; $29e7
	ldh [hLinkRemoteInputPrev], a ; $29e8
	ldh a, [hLinkRemoteInput] ; $29ea
	or a ; $29ec
	jr nz, .storeInput ; $29ed
	ldh a, [hLinkRemoteInputBuf] ; $29ef
.storeInput:
	ldh [hLinkInput], a ; $29f1
.done:
	pop bc ; $29f3
	pop af ; $29f4
	ret ; $29f5
; EnableTimerInterrupt with `or $08` (IE bit 3, serial) in place of `or $04`. Nothing calls it; the link code sets IE directly.
Unused_00_EnableSerialInterrupt:
	di ; $29f6
	xor a ; $29f7
	ldh [rIF], a ; $29f8
	ldh a, [rIE] ; $29fa
	or $08 ; $29fc
	ldh [rIE], a ; $29fe
	ei ; $2a00
	ret ; $2a01
; EnableTimerInterrupt with `or $01` (IE bit 0, VBlank) in place of `or $04`. Nothing calls it.
Unused_00_EnableVBlankInterrupt:
	di ; $2a02
	xor a ; $2a03
	ldh [rIF], a ; $2a04
	ldh a, [rIE] ; $2a06
	or $01 ; $2a08
	ldh [rIE], a ; $2a0a
	ei ; $2a0c
	ret ; $2a0d
