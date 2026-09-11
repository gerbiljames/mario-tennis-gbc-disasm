PackNibblesToBytes:
	ld a, c ; $49b0
	add a ; $49b1
	cp $5f ; $49b2
	jr c, .pack ; $49b4
	call LinkErrorReset ; $49b6
.pack:
	ld c, a ; $49b9
	ld b, $00 ; $49ba
	ld de, wLinkByteBuffer ; $49bc
.nibbleLoop:
	ld a, b ; $49bf
	and $01 ; $49c0
	jr nz, .lowNibble ; $49c2
	ld a, [de] ; $49c4
	swap a ; $49c5
	and $f0 ; $49c7
	jr .store ; $49c9
.lowNibble:
	ld a, [de] ; $49cb
	and $0f ; $49cc
	push bc ; $49ce
	ld b, a ; $49cf
	ld a, [hl] ; $49d0
	and $f0 ; $49d1
	or b ; $49d3
	pop bc ; $49d4
.store:
	ld [hl], a ; $49d5
	inc b ; $49d6
	inc de ; $49d7
	bit 0, b ; $49d8
	jr nz, .next ; $49da
	inc hl ; $49dc
.next:
	ld a, b ; $49dd
	cp c ; $49de
	jr c, .nibbleLoop ; $49df
	ret ; $49e1
PrimeSlaveSerialReply:
	ldh a, [hLinkState] ; $49e2
	cp LINKSTATE_SLAVE ; $49e4
	jr nz, .done ; $49e6
	ld a, $40 ; $49e8
	ldh [rSB], a ; $49ea
	push af ; $49ec
	ld a, SC_FAST | SC_EXTERNAL ; $49ed
	ldh [rSC], a ; $49ef
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $49f1
	ldh [rSC], a ; $49f3
	pop af ; $49f5
.done:
	ret ; $49f6
PrepareLinkStatePayload:
	push af ; $49f7
	ldh a, [hLinkTxByte] ; $49f8
	and $c0 ; $49fa
	xor $c0 ; $49fc
	ldh [hLinkTxSeqBits], a ; $49fe
	ldh a, [hLinkTxInput] ; $4a00
	ldh [hLinkRemoteInputBuf], a ; $4a02
	call ReadJoypadThunk ; $4a04
	ldh a, [hPlayerInputFlags] ; $4a07
	and $f0 ; $4a09
	ld c, a ; $4a0b
	call ComposeLinkStateByte ; $4a0c
	ldh [hLinkTxInput], a ; $4a0f
	pop af ; $4a11
	ret ; $4a12
PrepareLinkInputPayload:
	push af ; $4a13
	ldh a, [hLinkTxByte] ; $4a14
	and $c0 ; $4a16
	xor $c0 ; $4a18
	ldh [hLinkTxSeqBits], a ; $4a1a
	ldh a, [hLinkTxInput] ; $4a1c
	ldh [hLinkRemoteInputBuf], a ; $4a1e
	call ReadJoypadThunk ; $4a20
	ldh a, [hInputPressed] ; $4a23
	ldh [hLinkTxInput], a ; $4a25
	pop af ; $4a27
	ret ; $4a28
AwaitSerialByte:
	push de ; $4a29
	ld de, $4e20 ; $4a2a
.waitLoop:
	ei ; $4a2d
	nop ; $4a2e
	nop ; $4a2f
	di ; $4a30
	ldh a, [hVBlankOccurred] ; $4a31
	or a ; $4a33
	jr z, .waitLoop ; $4a34
	ldh a, [hLinkTransferDone] ; $4a36
	or a ; $4a38
	jr nz, .received ; $4a39
	dec de ; $4a3b
	ld a, d ; $4a3c
	or e ; $4a3d
	jr nz, .waitLoop ; $4a3e
	scf ; $4a40
	jr .done ; $4a41
.received:
	dec a ; $4a43
	ldh [hLinkTransferDone], a ; $4a44
	xor a ; $4a46
	ldh [hVBlankOccurred], a ; $4a47
	scf ; $4a49
	ccf ; $4a4a
.done:
	ldh a, [hLinkRxByte] ; $4a4b
	ld b, a ; $4a4d
	ei ; $4a4e
	pop de ; $4a4f
	ret ; $4a50
ResyncLinkSession:
	di ; $4a51
	xor a ; $4a52
	ldh [rIF], a ; $4a53
	ldh a, [rIE] ; $4a55
	and $09 ; $4a57
	ldh [rIE], a ; $4a59
	ei ; $4a5b
	call DisableLCDSafely ; $4a5c
	ld a, $01 ; $4a5f
	ldh [hVBlankSuppressed], a ; $4a61
	ld a, $01 ; $4a63
	ldh [hLinkExchangeActive], a ; $4a65
	farcall ExchangeLinkReadySignal ; $4a67
	ldh a, [hLinkState] ; $4a6a
	cp LINKSTATE_SLAVE ; $4a6c
	jr z, .asSlave ; $4a6e
	cp LINKSTATE_MASTER ; $4a70
	jr z, .asMaster ; $4a72
	call LinkErrorReset ; $4a74
.asMaster:
	ld a, $40 ; $4a77
	ldh [hLinkTxSeqBits], a ; $4a79
	call ShortDelay ; $4a7b
	call ShortDelay ; $4a7e
	call ShortDelay ; $4a81
	call ShortDelay ; $4a84
	call ShortDelay ; $4a87
	jr .encode ; $4a8a
.asSlave:
	xor a ; $4a8c
	ldh [hLinkTransferDone], a ; $4a8d
	ld a, $80 ; $4a8f
	ldh [hLinkTxSeqBits], a ; $4a91
.encode:
	call SerialEncodeInput ; $4a93
	farcall PrimeSlaveSerialReply ; $4a96
	xor a ; $4a99
	ldh [hLinkRemoteInputPrev], a ; $4a9a
	ld a, $01 ; $4a9c
	ldh [hLinkAckRequired], a ; $4a9e
	call EnableLCD ; $4aa0
	xor a ; $4aa3
	ldh [hVBlankSuppressed], a ; $4aa4
	ldh [hMatchFrameCounter], a ; $4aa6
	ret ; $4aa8
ResyncLinkSessionWithTimer:
	di ; $4aa9
	xor a ; $4aaa
	ldh [rIF], a ; $4aab
	ldh a, [rIE] ; $4aad
	and $09 ; $4aaf
	ldh [rIE], a ; $4ab1
	ei ; $4ab3
	ld a, $01 ; $4ab4
	ldh [hVBlankSuppressed], a ; $4ab6
	ld a, $01 ; $4ab8
	ldh [hLinkExchangeActive], a ; $4aba
	farcall ExchangeLinkReadySignal ; $4abc
	ldh a, [hLinkState] ; $4abf
	cp LINKSTATE_SLAVE ; $4ac1
	jr z, .asSlave ; $4ac3
	cp LINKSTATE_MASTER ; $4ac5
	jr z, .asMaster ; $4ac7
	call LinkErrorReset ; $4ac9
.asMaster:
	ld a, $40 ; $4acc
	ldh [hLinkTxSeqBits], a ; $4ace
	call ShortDelay ; $4ad0
	call ShortDelay ; $4ad3
	call ShortDelay ; $4ad6
	call ShortDelay ; $4ad9
	call ShortDelay ; $4adc
	jr .encode ; $4adf
.asSlave:
	xor a ; $4ae1
	ldh [hLinkTransferDone], a ; $4ae2
	ld a, $80 ; $4ae4
	ldh [hLinkTxSeqBits], a ; $4ae6
.encode:
	call SerialEncodeInput ; $4ae8
	farcall PrimeSlaveSerialReply ; $4aeb
	xor a ; $4aee
	ldh [hLinkRemoteInputPrev], a ; $4aef
	ld a, $01 ; $4af1
	ldh [hLinkAckRequired], a ; $4af3
	call EnableTimerInterrupt ; $4af5
	xor a ; $4af8
	ldh [hVBlankSuppressed], a ; $4af9
	ldh [hMatchFrameCounter], a ; $4afb
	ret ; $4afd
TryLinkHandshakeSlave:
	push hl ; $4afe
	push de ; $4aff
	push bc ; $4b00
	call EnableSerialAndVBlankInterrupts ; $4b01
	di ; $4b04
	ldh a, [rIF] ; $4b05
	and $f7 ; $4b07
	ldh [rIF], a ; $4b09
	xor a ; $4b0b
	ldh [hLinkTransferDone], a ; $4b0c
	ld a, LINKMSG_PROBE_REPLY ; $4b0e
	ldh [hLinkTxByte], a ; $4b10
	ldh [hLinkTxPending], a ; $4b12
	ei ; $4b14
	call AwaitSerialByte ; $4b15
	jr c, .failed ; $4b18
	di ; $4b1a
	ldh a, [hLinkRxByte] ; $4b1b
	cp $c2 ; $4b1d
	jr z, .failed ; $4b1f
	cp $00 ; $4b21
	jr z, .failed ; $4b23
	cp $ff ; $4b25
	jr z, .failed ; $4b27
	cp $c1 ; $4b29
	jr z, .success ; $4b2b
	ei ; $4b2d
.failed:
	scf ; $4b2e
	jr .done ; $4b2f
.success:
	scf ; $4b31
	ccf ; $4b32
.done:
	ei ; $4b33
	pop bc ; $4b34
	pop de ; $4b35
	pop hl ; $4b36
	ret ; $4b37
TryLinkHandshakeMaster:
	push hl ; $4b38
	push de ; $4b39
	push bc ; $4b3a
	call EnableSerialAndVBlankInterrupts ; $4b3b
	di ; $4b3e
	ldh a, [rSC] ; $4b3f
	and $7f ; $4b41
	ldh [rSC], a ; $4b43
	ei ; $4b45
	ld a, LINKMSG_PROBE ; $4b46
	ldh [hLinkTxByte], a ; $4b48
	ld hl, $03e8 ; $4b4a
	ld de, $03e8 ; $4b4d
.pollLoop:
	ldh a, [rLY] ; $4b50
	cp $8c ; $4b52
	jr nz, .pollLoop ; $4b54
	ldh a, [rSC] ; $4b56
	bit 7, a ; $4b58
	jr nz, .pollLoop ; $4b5a
	di ; $4b5c
	ldh a, [hLinkTxByte] ; $4b5d
	ldh [rSB], a ; $4b5f
	push af ; $4b61
	ld a, SC_FAST | SC_INTERNAL ; $4b62
	ldh [rSC], a ; $4b64
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $4b66
	ldh [rSC], a ; $4b68
	pop af ; $4b6a
	xor a ; $4b6b
	ldh [hLinkTransferDone], a ; $4b6c
	ei ; $4b6e
	call AwaitSerialByte ; $4b6f
	farcall AnimateLinkStatusPalette ; $4b72
	farcall UpdateAnimatedTiles ; $4b75
	jr c, .sendReady ; $4b78
	cp $c1 ; $4b7a
	jr z, .sendReady ; $4b7c
	cp $ff ; $4b7e
	jr z, .sendReady ; $4b80
	cp $c2 ; $4b82
	jr z, .failed ; $4b84
	ld a, d ; $4b86
	cp $03 ; $4b87
	jr nz, .retry ; $4b89
	ld a, e ; $4b8b
	cp $e8 ; $4b8c
	jr nz, .retry ; $4b8e
	push bc ; $4b90
	push de ; $4b91
	push hl ; $4b92
	ld c, $02 ; $4b93
	farcall ShowLinkStatusMessage ; $4b95
	pop hl ; $4b98
	pop de ; $4b99
	pop bc ; $4b9a
.retry:
	dec de ; $4b9b
	ld a, d ; $4b9c
	or e ; $4b9d
	jr nz, .pollLoop ; $4b9e
	jr .sendReady ; $4ba0
.sendReady:
	di ; $4ba2
	ld a, LINKMSG_NONE ; $4ba3
	ldh [rSB], a ; $4ba5
	push af ; $4ba7
	ld a, SC_FAST | SC_INTERNAL ; $4ba8
	ldh [rSC], a ; $4baa
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $4bac
	ldh [rSC], a ; $4bae
	pop af ; $4bb0
	xor a ; $4bb1
	ldh [hLinkTransferDone], a ; $4bb2
	ei ; $4bb4
	call AwaitSerialByte ; $4bb5
	ld a, e ; $4bb8
	scf ; $4bb9
	jr .done ; $4bba
.failed:
	scf ; $4bbc
	ccf ; $4bbd
.done:
	pop bc ; $4bbe
	pop de ; $4bbf
	pop hl ; $4bc0
	ret ; $4bc1
LongDelay:
	call ShortDelay ; $4bc2
	call ShortDelay ; $4bc5
	call ShortDelay ; $4bc8
	call ShortDelay ; $4bcb
	call ShortDelay ; $4bce
	call ShortDelay ; $4bd1
	call ShortDelay ; $4bd4
	call ShortDelay ; $4bd7
	call ShortDelay ; $4bda
	call ShortDelay ; $4bdd
	call ShortDelay ; $4be0
	call ShortDelay ; $4be3
	call ShortDelay ; $4be6
	call ShortDelay ; $4be9
	call ShortDelay ; $4bec
	call ShortDelay ; $4bef
	ret ; $4bf2
RunLinkCommandFrame:
	ldh a, [hLinkState] ; $4bf3
	cp LINKSTATE_SLAVE ; $4bf5
	jr z, .asSlave ; $4bf7
	call RunLinkCommandFrameMaster ; $4bf9
	jr .done ; $4bfc
.asSlave:
	call RunLinkCommandFrameSlave ; $4bfe
.done:
	ret ; $4c01
RunLinkCommandFrameMaster:
	push bc ; $4c02
	push hl ; $4c03
	call PrepareLinkInputPayload ; $4c04
	call ExchangeLinkFrameByteMaster ; $4c07
	call SerialDecodeCommand ; $4c0a
	call SerialEncodeCommand ; $4c0d
	pop bc ; $4c10
	pop hl ; $4c11
	ret ; $4c12
RunLinkCommandFrameSlave:
	push bc ; $4c13
	push hl ; $4c14
	call PrepareLinkInputPayload ; $4c15
	call ExchangeLinkFrameByteSlave ; $4c18
	call SerialDecodeCommand ; $4c1b
	call SerialEncodeCommand ; $4c1e
	pop hl ; $4c21
	pop bc ; $4c22
	ret ; $4c23
SerialEncodeCommand:
	push bc ; $4c24
	push hl ; $4c25
	ldh a, [hLinkTxInput] ; $4c26
	ld b, a ; $4c28
	push hl ; $4c29
	push de ; $4c2a
	farcall UpdateMenuCursorFromLinkInput ; $4c2b
	pop de ; $4c2e
	pop hl ; $4c2f
	ld c, b ; $4c30
	ldh a, [hLinkState] ; $4c31
	cp LINKSTATE_MASTER ; $4c33
	jr z, .checkSlaveWait ; $4c35
	cp LINKSTATE_SLAVE ; $4c37
	jr z, .checkSlaveWait ; $4c39
	sound SFX_BEEP ; $4c3b
	xor a ; $4c3d
	ldh [hLinkRemoteInputBuf], a ; $4c3e
	ldh [hLinkTxInput], a ; $4c40
	ld a, LINKMSG_NONE ; $4c42
	ldh [hLinkTxByte], a ; $4c44
	call LinkErrorReset ; $4c46
.checkSlaveWait:
	ldh a, [hLinkAckRequired] ; $4c49
	or a ; $4c4b
	jr z, .send ; $4c4c
	ldh a, [hLinkState] ; $4c4e
	cp LINKSTATE_SLAVE ; $4c50
	jr nz, .send ; $4c52
.waitAck:
	ei ; $4c54
	nop ; $4c55
	nop ; $4c56
	di ; $4c57
	ldh a, [hLinkTxPending] ; $4c58
	or a ; $4c5a
	jr nz, .waitAck ; $4c5b
.send:
	ldh a, [hLinkTxSeqBits] ; $4c5d
	or c ; $4c5f
	di ; $4c60
	ldh [hLinkTxByte], a ; $4c61
	ldh [hLinkTxPending], a ; $4c63
	ei ; $4c65
	pop hl ; $4c66
	pop bc ; $4c67
	ret ; $4c68
SerialDecodeCommand:
	push af ; $4c69
	push bc ; $4c6a
	ldh a, [hLinkRxByte] ; $4c6b
	ld b, a ; $4c6d
	and $c0 ; $4c6e
	cp $80 ; $4c70
	jr z, .decode ; $4c72
	cp $40 ; $4c74
	jr z, .decode ; $4c76
	sound SFX_BEEP ; $4c78
	xor a ; $4c7a
	ldh [hLinkInput], a ; $4c7b
	jr .done ; $4c7d
.decode:
	ld a, b ; $4c7f
	and $3f ; $4c80
	ldh [hLinkRemoteInput], a ; $4c82
	ldh a, [hLinkState] ; $4c84
	cp LINKSTATE_MASTER ; $4c86
	jr nz, .asSlave ; $4c88
	ldh a, [hLinkRemoteInputBuf] ; $4c8a
	or a ; $4c8c
	jr nz, .storeInput ; $4c8d
	ldh a, [hLinkRemoteInput] ; $4c8f
	call DecodeLinkCommandCode ; $4c91
	jr .storeInput ; $4c94
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4c96
	ld b, a ; $4c98
	ldh a, [hLinkRemoteInputPrev] ; $4c99
	ldh [hLinkRemoteInputBuf], a ; $4c9b
	ld a, b ; $4c9d
	ldh [hLinkRemoteInputPrev], a ; $4c9e
	ldh a, [hLinkRemoteInput] ; $4ca0
	or a ; $4ca2
	jr z, .useBuffered ; $4ca3
	call DecodeLinkCommandCode ; $4ca5
	jr .storeInput ; $4ca8
.useBuffered:
	ldh a, [hLinkRemoteInputBuf] ; $4caa
.storeInput:
	ldh [hLinkInput], a ; $4cac
.done:
	pop bc ; $4cae
	pop af ; $4caf
	ret ; $4cb0
