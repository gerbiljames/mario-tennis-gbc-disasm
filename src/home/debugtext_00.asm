ClearDebugTextBuffer:
	ld hl, wDebugTextBuffer ; $188b
	ld c, wDebugTextBuffer_SIZE / 16 ; $188e
	jp ClearMemory16 ; $1890
UpdateDebugOverlay:
	xor a ; $1893
	ldh [rVBK], a ; $1894
	ld hl, wDebugPeakLYText ; $1896
	ld de, vBGMap1 + 8 * TILEMAP_WIDTH + 8 ; $1899
	ld a, [hl+] ; $189c
	ld [de], a ; $189d
	inc de ; $189e
	ld a, [hl+] ; $189f
	ld [de], a ; $18a0
	inc de ; $18a1
	ld a, [hl+] ; $18a2
	ld [de], a ; $18a3
	inc de ; $18a4
	ld a, [hl+] ; $18a5
	ld [de], a ; $18a6
	inc de ; $18a7
	ldh a, [hDebugStepMode] ; $18a8
	cp $03 ; $18aa
	jr z, .storeShowDebugConsole2 ; $18ac
	cp $01 ; $18ae
	jr z, .eq01 ; $18b0
	ldh a, [hVBlankCounter] ; $18b2
	and $01 ; $18b4
	jr z, .storeShowDebugConsole2 ; $18b6
	jr .storeShowDebugConsole ; $18b8
.eq01:
	ldh a, [hPlayerInputFlags] ; $18ba
	bit PADB_SELECT, a ; $18bc
.storeShowDebugConsole:
	xor a ; $18be
	jr .store ; $18bf
.storeShowDebugConsole2:
	ld a, $01 ; $18c1
.store:
	ldh [hShowDebugConsole], a ; $18c3
	ldh a, [hDebugTextDirty] ; $18c5
	or a ; $18c7
	ret z ; $18c8
	xor a ; $18c9
	ldh [hDebugTextDirty], a ; $18ca
	xor a ; $18cc
	ldh [rVBK], a ; $18cd
	ld bc, wDebugTextBuffer ; $18cf
	ld de, $1d00 ; $18d2
	ld a, $23 ; $18d5
StartVRAMDMATransfer:
	ld hl, rVDMA_SRC_HIGH ; $18d7
	ld [hl], b ; $18da
	inc l ; $18db
	ld [hl], c ; $18dc
	inc l ; $18dd
	ld [hl], d ; $18de
	inc l ; $18df
	ld [hl], e ; $18e0
	inc l ; $18e1
	ld [hl], a ; $18e2
	ret ; $18e3
Unused_00_WaitStartVRAMDMAFromHL:
	push af ; $18e4
.loop:
	ldh a, [hVBlankOccurred] ; $18e5
	or a ; $18e7
	jr nz, .loop ; $18e8
	pop af ; $18ea
StartVRAMDMAFromHL:
	ld a, c ; $18eb
	dec a ; $18ec
	ld b, h ; $18ed
	ld c, l ; $18ee
	jr StartVRAMDMATransfer ; $18ef
GetDebugTextBufferAddr:
	push af ; $18f1
	push hl ; $18f2
	ld l, d ; $18f3
	ld h, $cc ; $18f4
	ld a, e ; $18f6
	rrca ; $18f7
	rrca ; $18f8
	rrca ; $18f9
	ld e, a ; $18fa
	and $1f ; $18fb
	ld d, a ; $18fd
	xor e ; $18fe
	ld e, a ; $18ff
	add hl, de ; $1900
	ld e, l ; $1901
	ld d, h ; $1902
	pop hl ; $1903
	pop af ; $1904
	ret ; $1905
PrintString:
	push af ; $1906
	call GetDebugTextBufferAddr ; $1907
.charLoop:
	ld a, [hl+] ; $190a
	or a ; $190b
	jr z, .terminated ; $190c
	ld [de], a ; $190e
	inc de ; $190f
	ld a, e ; $1910
	and $1f ; $1911
	jr nz, .charLoop ; $1913
	ld a, e ; $1915
	sub $20 ; $1916
	ld e, a ; $1918
	jr nc, .nextRow ; $1919
	dec d ; $191b
.nextRow:
	jr .charLoop ; $191c
.terminated:
	dec hl ; $191e
	ld a, $01 ; $191f
.markDirty:
	ldh [hDebugTextDirty], a ; $1921
	pop af ; $1923
	ret ; $1924
HexDigits:
	; $1925, 16 bytes (bytes:16)
	db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $41, $42, $43, $44, $45, $46 ; 0x00
FormatHexWord:
	push af ; $1935
	ld a, h ; $1936
	swap a ; $1937
	and $0f ; $1939
	cp $0a ; $193b
	jr c, .nibble0 ; $193d
	add $07 ; $193f
.nibble0:
	add $30 ; $1941
	ld [de], a ; $1943
	inc de ; $1944
	ld a, h ; $1945
	and $0f ; $1946
	cp $0a ; $1948
	jr c, .nibble1 ; $194a
	add $07 ; $194c
.nibble1:
	add $30 ; $194e
	ld [de], a ; $1950
	inc de ; $1951
	ld a, l ; $1952
	swap a ; $1953
	and $0f ; $1955
	cp $0a ; $1957
	jr c, .nibble2 ; $1959
	add $07 ; $195b
.nibble2:
	add $30 ; $195d
	ld [de], a ; $195f
	inc de ; $1960
	ld a, l ; $1961
	and $0f ; $1962
	cp $0a ; $1964
	jr c, .nibble3 ; $1966
	add $07 ; $1968
.nibble3:
	add $30 ; $196a
	ld [de], a ; $196c
	inc de ; $196d
	xor a ; $196e
	ld [de], a ; $196f
	pop af ; $1970
	ret ; $1971
FormatDecimalNumber:
	add sp, -6 ; $1972
	push bc ; $1974
	ld b, $00 ; $1975
	ld c, a ; $1977
	push bc ; $1978
	push de ; $1979
	ld e, l ; $197a
	ld d, h ; $197b
	ld hl, sp + 11 ; $197c
	ld a, $80 ; $197e
	ld [hl], a ; $1980
	ld l, e ; $1981
	ld h, d ; $1982
	bit 7, h ; $1983
	jr z, .positive ; $1985
	xor a ; $1987
	sub l ; $1988
	ld l, a ; $1989
	sbc a ; $198a
	sub h ; $198b
	ld h, a ; $198c
	ld e, l ; $198d
	ld d, h ; $198e
	ld hl, sp + 11 ; $198f
	set 0, [hl] ; $1991
	ld l, e ; $1993
	ld h, d ; $1994
.positive:
	ld c, l ; $1995
	ld b, h ; $1996
	ld hl, sp + 6 ; $1997
	ld e, l ; $1999
	ld d, h ; $199a
	ld l, c ; $199b
	ld h, b ; $199c
	ld bc, $d8f0 ; $199d
	call ExtractDecimalDigit ; $19a0
	ld bc, $2710 ; $19a3
	add hl, bc ; $19a6
	ld [de], a ; $19a7
	inc de ; $19a8
	ld bc, $fc18 ; $19a9
	call ExtractDecimalDigit ; $19ac
	ld bc, $03e8 ; $19af
	add hl, bc ; $19b2
	ld [de], a ; $19b3
	inc de ; $19b4
	ld bc, hSpriteQueueBase ; $19b5
	call ExtractDecimalDigit ; $19b8
	ld bc, $0064 ; $19bb
	add hl, bc ; $19be
	ld [de], a ; $19bf
	inc de ; $19c0
	ld bc, $fff6 ; $19c1
	call ExtractDecimalDigit ; $19c4
	ld bc, $000a ; $19c7
	add hl, bc ; $19ca
	ld [de], a ; $19cb
	inc de ; $19cc
	ld a, l ; $19cd
	ld [de], a ; $19ce
	pop de ; $19cf
	pop bc ; $19d0
	inc c ; $19d1
	dec c ; $19d2
	jr z, .emitSign ; $19d3
	ld b, $05 ; $19d5
	ld hl, sp + 2 ; $19d7
.countDigitsLoop:
	ld a, [hl] ; $19d9
	or a ; $19da
	jr nz, .checkPad ; $19db
	dec b ; $19dd
	inc hl ; $19de
	bit 7, [hl] ; $19df
	jr z, .countDigitsLoop ; $19e1
	inc b ; $19e3
.checkPad:
	ld a, c ; $19e4
	sub b ; $19e5
	jr c, .emitSign ; $19e6
	jr z, .emitSign ; $19e8
	ld b, a ; $19ea
	ld a, $20 ; $19eb
	ld hl, sp + 7 ; $19ed
	bit 0, [hl] ; $19ef
	jr z, .padLoop ; $19f1
	dec b ; $19f3
	jr z, .emitSign ; $19f4
.padLoop:
	ld [de], a ; $19f6
	inc de ; $19f7
	dec b ; $19f8
	jr nz, .padLoop ; $19f9
.emitSign:
	ld hl, sp + 7 ; $19fb
	bit 0, [hl] ; $19fd
	jr z, .emitDigits ; $19ff
	ld a, $2d ; $1a01
	ld [de], a ; $1a03
	inc de ; $1a04
.emitDigits:
	ld b, $05 ; $1a05
	ld c, $30 ; $1a07
	ld hl, sp + 2 ; $1a09
.skipZerosLoop:
	ld a, [hl+] ; $1a0b
	or a ; $1a0c
	jr nz, .digitLoop ; $1a0d
	dec b ; $1a0f
	jr nz, .skipZerosLoop ; $1a10
.digitLoop:
	add c ; $1a12
	ld [de], a ; $1a13
	inc de ; $1a14
	ld a, [hl+] ; $1a15
	bit 7, a ; $1a16
	jr z, .digitLoop ; $1a18
	xor a ; $1a1a
	ld [de], a ; $1a1b
	pop bc ; $1a1c
	add sp, 6 ; $1a1d
	ret ; $1a1f
ExtractDecimalDigit:
	xor a ; $1a20
.loop:
	inc a ; $1a21
	add hl, bc ; $1a22
	jr c, .loop ; $1a23
	dec a ; $1a25
	ret ; $1a26
FormatDecimalNumberUnsigned:
	add sp, -6 ; $1a27
	push bc ; $1a29
	ld b, $00 ; $1a2a
	ld c, a ; $1a2c
	push bc ; $1a2d
	push de ; $1a2e
	ld e, l ; $1a2f
	ld d, h ; $1a30
	ld hl, sp + 11 ; $1a31
	ld a, $80 ; $1a33
	ld [hl], a ; $1a35
	ld l, e ; $1a36
	ld h, d ; $1a37
	ld c, l ; $1a38
	ld b, h ; $1a39
	ld hl, sp + 6 ; $1a3a
	ld e, l ; $1a3c
	ld d, h ; $1a3d
	ld l, c ; $1a3e
	ld h, b ; $1a3f
	ld bc, $d8f0 ; $1a40
	call ExtractDecimalDigitUnsigned ; $1a43
	ld bc, $2710 ; $1a46
	add hl, bc ; $1a49
	ld [de], a ; $1a4a
	inc de ; $1a4b
	ld bc, $fc18 ; $1a4c
	call ExtractDecimalDigitUnsigned ; $1a4f
	ld bc, $03e8 ; $1a52
	add hl, bc ; $1a55
	ld [de], a ; $1a56
	inc de ; $1a57
	ld bc, hSpriteQueueBase ; $1a58
	call ExtractDecimalDigitUnsigned ; $1a5b
	ld bc, $0064 ; $1a5e
	add hl, bc ; $1a61
	ld [de], a ; $1a62
	inc de ; $1a63
	ld bc, $fff6 ; $1a64
	call ExtractDecimalDigitUnsigned ; $1a67
	ld bc, $000a ; $1a6a
	add hl, bc ; $1a6d
	ld [de], a ; $1a6e
	inc de ; $1a6f
	ld a, l ; $1a70
	ld [de], a ; $1a71
	pop de ; $1a72
	pop bc ; $1a73
	inc c ; $1a74
	dec c ; $1a75
	jr z, .emitDigits ; $1a76
	ld b, $05 ; $1a78
	ld hl, sp + 2 ; $1a7a
.countDigitsLoop:
	ld a, [hl] ; $1a7c
	or a ; $1a7d
	jr nz, .checkPad ; $1a7e
	dec b ; $1a80
	inc hl ; $1a81
	bit 7, [hl] ; $1a82
	jr z, .countDigitsLoop ; $1a84
	inc b ; $1a86
.checkPad:
	ld a, c ; $1a87
	sub b ; $1a88
	jr c, .emitDigits ; $1a89
	jr z, .emitDigits ; $1a8b
	ld b, a ; $1a8d
	ld a, $20 ; $1a8e
.padLoop:
	ld [de], a ; $1a90
	inc de ; $1a91
	dec b ; $1a92
	jr nz, .padLoop ; $1a93
.emitDigits:
	ld b, $05 ; $1a95
	ld c, $30 ; $1a97
	ld hl, sp + 2 ; $1a99
.skipZerosLoop:
	ld a, [hl+] ; $1a9b
	or a ; $1a9c
	jr nz, .digitLoop ; $1a9d
	dec b ; $1a9f
	jr nz, .skipZerosLoop ; $1aa0
.digitLoop:
	add c ; $1aa2
	ld [de], a ; $1aa3
	inc de ; $1aa4
	ld a, [hl+] ; $1aa5
	bit 7, a ; $1aa6
	jr z, .digitLoop ; $1aa8
	xor a ; $1aaa
	ld [de], a ; $1aab
	pop bc ; $1aac
	add sp, 6 ; $1aad
	ret ; $1aaf
ExtractDecimalDigitUnsigned:
	xor a ; $1ab0
.loop:
	inc a ; $1ab1
	add hl, bc ; $1ab2
	jr c, .loop ; $1ab3
	dec a ; $1ab5
	ret ; $1ab6
PrintHexByte:
	push af ; $1ab7
	push bc ; $1ab8
	push de ; $1ab9
	push hl ; $1aba
	add sp, -10 ; $1abb
	ld hl, sp + 0 ; $1abd
	push de ; $1abf
	ld d, h ; $1ac0
	ld e, l ; $1ac1
	ld b, h ; $1ac2
	ld c, l ; $1ac3
	ld h, $00 ; $1ac4
	ld l, a ; $1ac6
	call FormatHexWord ; $1ac7
	inc hl ; $1aca
	inc hl ; $1acb
	jr Unused_00_PrintDecimalWord.printString ; $1acc
PrintHexWord:
	push af ; $1ace
	push bc ; $1acf
	push de ; $1ad0
	push hl ; $1ad1
	ld b, h ; $1ad2
	ld c, l ; $1ad3
	add sp, -10 ; $1ad4
	ld hl, sp + 0 ; $1ad6
	push de ; $1ad8
	ld d, h ; $1ad9
	ld e, l ; $1ada
	ld h, b ; $1adb
	ld l, c ; $1adc
	ld b, d ; $1add
	ld c, e ; $1ade
	call FormatHexWord ; $1adf
	jr Unused_00_PrintDecimalWord.printString ; $1ae2
PrintDecimalByte:
	push af ; $1ae4
	push bc ; $1ae5
	push de ; $1ae6
	push hl ; $1ae7
	add sp, -10 ; $1ae8
	ld hl, sp + 0 ; $1aea
	push de ; $1aec
	ld d, h ; $1aed
	ld e, l ; $1aee
	ld b, h ; $1aef
	ld c, l ; $1af0
	ld h, $00 ; $1af1
	ld l, a ; $1af3
	ld a, $04 ; $1af4
	call FormatDecimalNumber ; $1af6
	jr Unused_00_PrintDecimalWord.printString ; $1af9
; PrintDecimalByte with one extra call before the digit loop (the sign handling). Nothing calls it.
Unused_00_PrintDecimalByteSigned:
	push af ; $1afb
	push bc ; $1afc
	push de ; $1afd
	push hl ; $1afe
	add sp, -10 ; $1aff
	ld hl, sp + 0 ; $1b01
	push de ; $1b03
	ld d, h ; $1b04
	ld e, l ; $1b05
	ld b, h ; $1b06
	ld c, l ; $1b07
	ld h, $00 ; $1b08
	ld l, a ; $1b0a
	call SignExtendLToHL ; $1b0b
	ld a, $04 ; $1b0e
	call FormatDecimalNumber ; $1b10
	jr Unused_00_PrintDecimalWord.printString ; $1b13
Unused_00_PrintDecimalWord:
	push af ; $1b15
	push bc ; $1b16
	push de ; $1b17
	push hl ; $1b18
	ld b, h ; $1b19
	ld c, l ; $1b1a
	add sp, -10 ; $1b1b
	ld hl, sp + 0 ; $1b1d
	push de ; $1b1f
	ld d, h ; $1b20
	ld e, l ; $1b21
	ld h, b ; $1b22
	ld l, c ; $1b23
	ld b, d ; $1b24
	ld c, e ; $1b25
	ld a, $06 ; $1b26
	call FormatDecimalNumber ; $1b28
.printString:
	ld h, b ; $1b2b
	ld l, c ; $1b2c
	pop de ; $1b2d
	call PrintString ; $1b2e
	add sp, 10 ; $1b31
	pop hl ; $1b33
	pop de ; $1b34
	pop bc ; $1b35
	pop af ; $1b36
	ret ; $1b37
ClearFrameTasks:
	xor a ; $1b38
	ldh [hFrameTasksReady], a ; $1b39
	ld hl, wFrameTasks ; $1b3b
	ld c, wFrameTasks_SIZE / 16 ; $1b3e
	call ClearMemory16 ; $1b40
	ld a, $01 ; $1b43
	ldh [hFrameTasksReady], a ; $1b45
	ret ; $1b47
