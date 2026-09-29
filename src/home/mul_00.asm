SignExtendLToHL:
	ld h, $00 ; $090d
	bit 7, l ; $090f
	ret z ; $0911
	dec h ; $0912
	ret ; $0913
Unused_00_SignExtendEToDE:
	ld d, $00 ; $0914
	bit 7, e ; $0916
	ret z ; $0918
	dec d ; $0919
	ret ; $091a
SignExtendCToBC:
	ld b, $00 ; $091b
	bit 7, c ; $091d
	ret z ; $091f
	dec b ; $0920
	ret ; $0921
.loop:
	ld hl, $0000 ; $0922
	ret ; $0925
MulHLByA:
	or a ; $0926
	jr z, SignExtendCToBC.loop ; $0927
	push af ; $0929
	push de ; $092a
	ld d, h ; $092b
	ld e, l ; $092c
	add a ; $092d
	jr c, .top7 ; $092e
	add a ; $0930
	jr c, .top6 ; $0931
	add a ; $0933
	jr c, .top5 ; $0934
	add a ; $0936
	jr c, .top4 ; $0937
	add a ; $0939
	jr c, .top3 ; $093a
	add a ; $093c
	jr c, .top2 ; $093d
	add a ; $093f
	jr c, .top1 ; $0940
	jr .done ; $0942
.top7:
	jr z, .mul128 ; $0944
	add hl, hl ; $0946
	add a ; $0947
	jr nc, .step6 ; $0948
	add hl, de ; $094a
.top6:
	jr z, .finish6 ; $094b
.step6:
	add hl, hl ; $094d
	add a ; $094e
	jr nc, .step5 ; $094f
	add hl, de ; $0951
.top5:
	jr z, .finish5 ; $0952
.step5:
	add hl, hl ; $0954
	add a ; $0955
	jr nc, .step4 ; $0956
	add hl, de ; $0958
.top4:
	jr z, .finish4 ; $0959
.step4:
	add hl, hl ; $095b
	add a ; $095c
	jr nc, .step3 ; $095d
	add hl, de ; $095f
.top3:
	jr z, .finish3 ; $0960
.step3:
	add hl, hl ; $0962
	add a ; $0963
	jr nc, .step2 ; $0964
	add hl, de ; $0966
.top2:
	jr z, .finish2 ; $0967
.step2:
	add hl, hl ; $0969
	add a ; $096a
	jr nc, .step1 ; $096b
	add hl, de ; $096d
.top1:
	jr z, .finish1 ; $096e
.step1:
	add hl, hl ; $0970
	add hl, de ; $0971
	pop de ; $0972
	pop af ; $0973
	ret ; $0974
.mul128:
	srl h ; $0975
	rr l ; $0977
	rra ; $0979
	ld h, l ; $097a
	ld l, a ; $097b
	jr .done ; $097c
.finish6:
	add hl, hl ; $097e
.finish5:
	add hl, hl ; $097f
.finish4:
	add hl, hl ; $0980
.finish3:
	add hl, hl ; $0981
.finish2:
	add hl, hl ; $0982
.finish1:
	add hl, hl ; $0983
.done:
	pop de ; $0984
	pop af ; $0985
	ret ; $0986
DivHLByDE:
	push af ; $0987
	push bc ; $0988
	xor a ; $0989
	sub e ; $098a
	ld c, a ; $098b
	sbc a ; $098c
	sub d ; $098d
	ld b, a ; $098e
	or c ; $098f
	jr nz, .divide ; $0990
	ld hl, rIE ; $0992
	pop bc ; $0995
	pop af ; $0996
	ret ; $0997
.divide:
	ld a, h ; $0998
	ld h, l ; $0999
	push hl ; $099a
	ld hl, $0000 ; $099b
	scf ; $099e
	adc a ; $099f
	rl l ; $09a0
	add hl, bc ; $09a2
	jr c, .hiBit6 ; $09a3
	dec a ; $09a5
	add hl, de ; $09a6
.hiBit6:
	adc a ; $09a7
	rl l ; $09a8
	add hl, bc ; $09aa
	jr c, .hiBit5 ; $09ab
	dec a ; $09ad
	add hl, de ; $09ae
.hiBit5:
	adc a ; $09af
	rl l ; $09b0
	add hl, bc ; $09b2
	jr c, .hiBit4 ; $09b3
	dec a ; $09b5
	add hl, de ; $09b6
.hiBit4:
	adc a ; $09b7
	rl l ; $09b8
	add hl, bc ; $09ba
	jr c, .hiBit3 ; $09bb
	dec a ; $09bd
	add hl, de ; $09be
.hiBit3:
	adc a ; $09bf
	rl l ; $09c0
	add hl, bc ; $09c2
	jr c, .hiBit2 ; $09c3
	dec a ; $09c5
	add hl, de ; $09c6
.hiBit2:
	adc a ; $09c7
	rl l ; $09c8
	add hl, bc ; $09ca
	jr c, .hiBit1 ; $09cb
	dec a ; $09cd
	add hl, de ; $09ce
.hiBit1:
	adc a ; $09cf
	rl l ; $09d0
	add hl, bc ; $09d2
	jr c, .hiBit0 ; $09d3
	dec a ; $09d5
	add hl, de ; $09d6
.hiBit0:
	adc a ; $09d7
	rl l ; $09d8
	add hl, bc ; $09da
	jr c, .hiDone ; $09db
	dec a ; $09dd
	add hl, de ; $09de
.hiDone:
	ld h, a ; $09df
	pop af ; $09e0
	push hl ; $09e1
	ld h, $00 ; $09e2
	scf ; $09e4
	adc a ; $09e5
	rl l ; $09e6
	rl h ; $09e8
	add hl, bc ; $09ea
	jr c, .loBit6 ; $09eb
	dec a ; $09ed
	add hl, de ; $09ee
.loBit6:
	adc a ; $09ef
	rl l ; $09f0
	rl h ; $09f2
	add hl, bc ; $09f4
	jr c, .loBit5 ; $09f5
	dec a ; $09f7
	add hl, de ; $09f8
.loBit5:
	adc a ; $09f9
	rl l ; $09fa
	rl h ; $09fc
	add hl, bc ; $09fe
	jr c, .loBit4 ; $09ff
	dec a ; $0a01
	add hl, de ; $0a02
.loBit4:
	adc a ; $0a03
	rl l ; $0a04
	rl h ; $0a06
	add hl, bc ; $0a08
	jr c, .loBit3 ; $0a09
	dec a ; $0a0b
	add hl, de ; $0a0c
.loBit3:
	adc a ; $0a0d
	rl l ; $0a0e
	rl h ; $0a10
	add hl, bc ; $0a12
	jr c, .loBit2 ; $0a13
	dec a ; $0a15
	add hl, de ; $0a16
.loBit2:
	adc a ; $0a17
	rl l ; $0a18
	rl h ; $0a1a
	add hl, bc ; $0a1c
	jr c, .loBit1 ; $0a1d
	dec a ; $0a1f
	add hl, de ; $0a20
.loBit1:
	adc a ; $0a21
	rl l ; $0a22
	rl h ; $0a24
	add hl, bc ; $0a26
	jr c, .loBit0 ; $0a27
	dec a ; $0a29
	add hl, de ; $0a2a
.loBit0:
	adc a ; $0a2b
	rl l ; $0a2c
	rl h ; $0a2e
	add hl, bc ; $0a30
	jr c, .done ; $0a31
	dec a ; $0a33
	add hl, de ; $0a34
.done:
	pop hl ; $0a35
	ld l, a ; $0a36
	pop bc ; $0a37
	pop af ; $0a38
	ret ; $0a39
AdvanceRandomSeed:
	push af ; $0a3a
	push de ; $0a3b
	ldh a, [hRandomSeed] ; $0a3c
	ld l, a ; $0a3e
	ldh a, [hRandomSeed + 1] ; $0a3f
	ld h, a ; $0a41
	ld d, h ; $0a42
	ld e, l ; $0a43
	add hl, hl ; $0a44
	add hl, hl ; $0a45
	add hl, de ; $0a46
	ld de, $3573 ; $0a47
	add hl, de ; $0a4a
	ld a, l ; $0a4b
	ldh [hRandomSeed], a ; $0a4c
	ld a, h ; $0a4e
	ldh [hRandomSeed + 1], a ; $0a4f
	pop de ; $0a51
	pop af ; $0a52
	ret ; $0a53
AngleFromVectorCoarse:
	push bc ; $0a54
	ld c, $00 ; $0a55
	ld a, h ; $0a57
	or l ; $0a58
	jr z, .toAngle ; $0a59
	ld c, $10 ; $0a5b
	ld a, d ; $0a5d
	or e ; $0a5e
	jr z, .toAngle ; $0a5f
	push hl ; $0a61
	push de ; $0a62
	bit 7, d ; $0a63
	jr z, .absY ; $0a65
	xor a ; $0a67
	sub e ; $0a68
	ld e, a ; $0a69
	sbc a ; $0a6a
	sub d ; $0a6b
	ld d, a ; $0a6c
.absY:
	bit 7, h ; $0a6d
	jr z, .absX ; $0a6f
	xor a ; $0a71
	sub l ; $0a72
	ld l, a ; $0a73
	sbc a ; $0a74
	sub h ; $0a75
	ld h, a ; $0a76
.absX:
	ld a, h ; $0a77
	cp $10 ; $0a78
	jr c, .scaleUp ; $0a7a
	sra d ; $0a7c
	rr e ; $0a7e
	sra d ; $0a80
	rr e ; $0a82
	add hl, hl ; $0a84
	add hl, hl ; $0a85
	jr .divide ; $0a86
.scaleUp:
	add hl, hl ; $0a88
	add hl, hl ; $0a89
	add hl, hl ; $0a8a
	add hl, hl ; $0a8b
.divide:
	call DivHLByDE ; $0a8c
	ld c, $0f ; $0a8f
	ld a, h ; $0a91
	or a ; $0a92
	jr nz, .restore ; $0a93
	ld b, l ; $0a95
	ld hl, ArcTanTable ; $0a96
	ld c, $ff ; $0a99
.searchLoop:
	inc c ; $0a9b
	ld a, [hl+] ; $0a9c
	cp b ; $0a9d
	jr c, .searchLoop ; $0a9e
.restore:
	pop de ; $0aa0
	pop hl ; $0aa1
.toAngle:
	ld a, c ; $0aa2
	add a ; $0aa3
	add a ; $0aa4
	bit 7, d ; $0aa5
	jr z, .mirrorY ; $0aa7
	cpl ; $0aa9
	add $81 ; $0aaa
.mirrorY:
	bit 7, h ; $0aac
	jr z, .done ; $0aae
	cpl ; $0ab0
	inc a ; $0ab1
.done:
	pop bc ; $0ab2
	ret ; $0ab3
ArcTanTable:
	; $0ab4, 17 bytes (bytes:17)
	db $00, $01, $03, $04, $06, $08, $0a, $0d, $10, $13, $18, $1e, $26, $35, $51, $a5, $ff ; 0x00
VectorFromLengthAndAngle:
	sra h ; $0ac5
	rr l ; $0ac7
	sra h ; $0ac9
	rr l ; $0acb
	sra h ; $0acd
	rr l ; $0acf
	sra h ; $0ad1
	rr l ; $0ad3
	push hl ; $0ad5
	push af ; $0ad6
	call MulHLBySin ; $0ad7
	pop af ; $0ada
	add hl, hl ; $0adb
	add hl, hl ; $0adc
	add hl, hl ; $0add
	add hl, hl ; $0ade
	ld e, l ; $0adf
	ld d, h ; $0ae0
	pop hl ; $0ae1
	call MulHLByCos ; $0ae2
	add hl, hl ; $0ae5
	add hl, hl ; $0ae6
	add hl, hl ; $0ae7
	add hl, hl ; $0ae8
	ret ; $0ae9
Unused_00_VectorFromSignedLengthAndAngle:
	bit 7, h ; $0aea
	jr z, VectorFromLengthAndAngleRaw ; $0aec
	push af ; $0aee
	xor a ; $0aef
	sub l ; $0af0
	ld l, a ; $0af1
	sbc a ; $0af2
	sub h ; $0af3
	ld h, a ; $0af4
	pop af ; $0af5
	add $80 ; $0af6
VectorFromLengthAndAngleRaw:
	push hl ; $0af8
	push af ; $0af9
	call MulHLBySin ; $0afa
	pop af ; $0afd
	ld d, h ; $0afe
	ld e, l ; $0aff
	pop hl ; $0b00
MulHLByCos:
	add $40 ; $0b01
MulHLBySin:
	bit 7, a ; $0b03
	jr z, MulHLBySinHalf ; $0b05
	and $7f ; $0b07
	call MulHLBySinHalf ; $0b09
	xor a ; $0b0c
	sub l ; $0b0d
	ld l, a ; $0b0e
	sbc a ; $0b0f
	sub h ; $0b10
	ld h, a ; $0b11
	ret ; $0b12
MulHLBySinHalf:
	bit 6, a ; $0b13
	jr z, .bit6Clear ; $0b15
	cpl ; $0b17
	add $81 ; $0b18
.bit6Clear:
	push bc ; $0b1a
	ld_bc_indexed QuarterSineTable ; $0b1b
	ld a, [bc] ; $0b22
	call MulHLByA ; $0b23
	ld bc, $0040 ; $0b26
	add hl, bc ; $0b29
	add hl, hl ; $0b2a
	sbc a ; $0b2b
	ld l, h ; $0b2c
	ld h, a ; $0b2d
	pop bc ; $0b2e
	ret ; $0b2f
MulHLByCosSigned:
	add $40 ; $0b30
MulHLBySinSigned:
	bit 7, a ; $0b32
	jr z, MulHLBySinSignedHalf ; $0b34
	and $7f ; $0b36
	call MulHLBySinSignedHalf ; $0b38
	xor a ; $0b3b
	sub l ; $0b3c
	ld l, a ; $0b3d
	sbc a ; $0b3e
	sub h ; $0b3f
	ld h, a ; $0b40
	ret ; $0b41
MulHLBySinSignedHalf:
	bit 6, a ; $0b42
	jr z, .bit6Clear ; $0b44
	cpl ; $0b46
	add $81 ; $0b47
.bit6Clear:
	push bc ; $0b49
	ld_bc_indexed QuarterSineTable ; $0b4a
	ld a, [bc] ; $0b51
	call MulHLByASigned ; $0b52
	ld bc, $0040 ; $0b55
	add hl, bc ; $0b58
	add hl, hl ; $0b59
	pop bc ; $0b5a
	ret ; $0b5b
