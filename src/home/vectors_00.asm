Rst00:
	jp JumpTableDispatch ; $0000
	ds 5, $ff ; $0003, fill
Rst08:
	jp PlaySoundCmd ; $0008
	INCBIN "data/bank_000/d_000b.bin" ; $000b, 13 bytes
Rst18:
	jp FarCall ; $0018
	ds 5, $ff ; $001b, fill
Rst20:
	jp SetGameFlagCmd ; $0020
	ds 5, $ff ; $0023, fill
Rst28:
	jp ClearGameFlagCmd ; $0028
	ds 5, $ff ; $002b, fill
Rst30:
	jp TestGameFlagCmd ; $0030
	ds 13, $ff ; $0033, fill
VBlankInterrupt:
	jp VBlankHandler ; $0040
	ds 5, $ff ; $0043, fill
LCDStatInterrupt:
	jp LCDStatHandler ; $0048
	ds 5, $ff ; $004b, fill
TimerInterrupt:
	jp TimerHandler ; $0050
	ds 5, $ff ; $0053, fill
SerialInterrupt:
	jp SerialHandler ; $0058
	ds 5, $ff ; $005b, fill
JoypadInterrupt:
	jp JumpTableDispatch ; $0060
	ds 157, $ff ; $0063, fill
EntryPoint:
	nop ; $0100
	jp NintendoLogo.start ; $0101
NintendoLogo:
	INCBIN "data/bank_000/NintendoLogo.bin" ; $0104, 48 bytes
	; $0134, 28 bytes (cart_header)
	db "CGBTENNIS ", $00 ; $0134 title
	db "BM8E"            ; $013f manufacturer code
	db $c0               ; $0143 CGB flag: CGB only
	db "01"              ; $0144 new licensee
	db $00               ; $0146 SGB flag
	db $1b               ; $0147 cart type: MBC5+RAM+BATTERY
	db $06               ; $0148 ROM size: 2048 KiB, 128 banks
	db $03               ; $0149 RAM size: 32 KiB, 4 banks
	db $01               ; $014a destination: non-Japanese
	db $33               ; $014b old licensee
	db $00               ; $014c mask ROM version
	db $a5               ; $014d header checksum
	db $64, $e3          ; $014e global checksum
.start:
	jp Start ; $0150
BuildStamp:
	; $0153, 11 bytes (ascii)
	db "10011171737"
CallHLInBankA:
	push hl ; $015e
	push hl ; $015f
	push hl ; $0160
	push af ; $0161
	ld hl, sp + 4 ; $0162
	ld [hl], $75 ; $0164
	inc hl ; $0166
	ld [hl], $01 ; $0167
	inc hl ; $0169
	ldh a, [hRomBank] ; $016a
	ld [hl], a ; $016c
	pop af ; $016d
	ldh [hRomBank], a ; $016e
	ld [rROMB0], a ; $0170
	pop hl ; $0173
	jp hl ; $0174
	push af ; $0175
	push hl ; $0176
	ld hl, sp + 4 ; $0177
	ld a, [hl] ; $0179
	ldh [hRomBank], a ; $017a
	ld [rROMB0], a ; $017c
	pop hl ; $017f
	pop af ; $0180
	inc sp ; $0181
	inc sp ; $0182
	ret ; $0183
Unused_00_CallTableEntryInBankA:
	push hl ; $0184
	push hl ; $0185
	push hl ; $0186
	push af ; $0187
	ld hl, sp + 4 ; $0188
	ld [hl], $a7 ; $018a
	inc hl ; $018c
	ld [hl], $01 ; $018d
	inc hl ; $018f
	ldh a, [hRomBank] ; $0190
	ld [hl], a ; $0192
	pop af ; $0193
	ldh [hRomBank], a ; $0194
	ld [rROMB0], a ; $0196
	pop hl ; $0199
	ld a, b ; $019a
	add a ; $019b
	add l ; $019c
	ld l, a ; $019d
	jr nc, .readSlot ; $019e
	inc h ; $01a0
.readSlot:
	ld a, [hl+] ; $01a1
	ld h, [hl] ; $01a2
	ld l, a ; $01a3
	or h ; $01a4
	ret z ; $01a5
	jp hl ; $01a6
	push af ; $01a7
	push hl ; $01a8
	ld hl, sp + 4 ; $01a9
	ld a, [hl] ; $01ab
	ldh [hRomBank], a ; $01ac
	ld [rROMB0], a ; $01ae
	pop hl ; $01b1
	pop af ; $01b2
	inc sp ; $01b3
	inc sp ; $01b4
	ret ; $01b5
FarCall:
	push hl ; $01b6
	push af ; $01b7
	ld hl, sp + 0 ; $01b8
	ldh a, [hRomBank] ; $01ba
	ld [hl], a ; $01bc
	ld hl, sp + 4 ; $01bd
	push de ; $01bf
	ld a, [hl+] ; $01c0
	ld e, a ; $01c1
	ld d, [hl] ; $01c2
	ld a, [de] ; $01c3
	inc de ; $01c4
	ld [hl], a ; $01c5
	ld a, [de] ; $01c6
	ldh [hRomBank], a ; $01c7
	ld [rROMB0], a ; $01c9
	inc de ; $01cc
	ld a, [hl] ; $01cd
	ld [hl], d ; $01ce
	dec hl ; $01cf
	ld [hl], e ; $01d0
	pop de ; $01d1
	call CallVectorEntryA ; $01d2
	push af ; $01d5
	push hl ; $01d6
	ld hl, sp + 4 ; $01d7
	ld a, [hl] ; $01d9
	ldh [hRomBank], a ; $01da
	ld [rROMB0], a ; $01dc
	pop hl ; $01df
	pop af ; $01e0
	inc sp ; $01e1
	inc sp ; $01e2
	inc sp ; $01e3
	inc sp ; $01e4
	ret ; $01e5
CallVectorEntryA:
	ld h, $40 ; $01e6
	ld l, a ; $01e8
	ld a, [hl+] ; $01e9
	ld h, [hl] ; $01ea
	ld l, a ; $01eb
	push hl ; $01ec
	ld hl, sp + 5 ; $01ed
	ld a, [hl+] ; $01ef
	push af ; $01f0
	ld a, [hl+] ; $01f1
	ld h, [hl] ; $01f2
	ld l, a ; $01f3
	pop af ; $01f4
	ret ; $01f5
Unused_00_FarCallVectorInline:
	ld hl, sp + 0 ; $01f6
	ldh a, [hRomBank] ; $01f8
	push af ; $01fa
	ld a, [hl+] ; $01fb
	ld h, [hl] ; $01fc
	ld l, a ; $01fd
	ld a, [hl+] ; $01fe
	ld e, a ; $01ff
	ld a, [hl] ; $0200
	ldh [hRomBank], a ; $0201
	ld [rROMB0], a ; $0203
	call CallVectorEntryE ; $0206
	pop af ; $0209
	ldh [hRomBank], a ; $020a
	ld [rROMB0], a ; $020c
	pop hl ; $020f
	inc hl ; $0210
	inc hl ; $0211
	jp hl ; $0212
CallVectorEntryE:
	ld h, $40 ; $0213
	ld l, e ; $0215
	ld a, [hl+] ; $0216
	ld h, [hl] ; $0217
	ld l, a ; $0218
	jp hl ; $0219
CopyDataFromBank:
	push af ; $021a
	ldh a, [hRomBank] ; $021b
	push af ; $021d
	ld a, h ; $021e
	ldh [hRomBank], a ; $021f
	ld [rROMB0], a ; $0221
	ld h, $40 ; $0224
	ld a, [hl+] ; $0226
	ld h, [hl] ; $0227
	ld l, a ; $0228
	call CopyMemoryBC ; $0229
	pop af ; $022c
	ldh [hRomBank], a ; $022d
	ld [rROMB0], a ; $022f
	pop af ; $0232
	ret ; $0233
DecompressDataFromBank:
	push af ; $0234
	ldh a, [hRomBank] ; $0235
	push af ; $0237
	ld a, h ; $0238
	ldh [hRomBank], a ; $0239
	ld [rROMB0], a ; $023b
	ld h, $40 ; $023e
	ld a, [hl+] ; $0240
	ld h, [hl] ; $0241
	ld l, a ; $0242
	call DecompressData ; $0243
	pop af ; $0246
	ldh [hRomBank], a ; $0247
	ld [rROMB0], a ; $0249
	pop af ; $024c
	ret ; $024d
ClearBothVRAMBanks:
	ld a, $01 ; $024e
	ldh [rVBK], a ; $0250
	ld hl, vTiles0 ; $0252
	ld bc, $0200 ; $0255
	call ClearMemoryBC16 ; $0258
	xor a ; $025b
	ldh [rVBK], a ; $025c
	ld hl, $8000 ; $025e
	ld bc, $0200 ; $0261
	jp ClearMemoryBC16 ; $0264
.loop:
	ld a, $01 ; $0267
	ldh [rVBK], a ; $0269
	ld hl, vBGMap0 ; $026b
	ld c, $80 ; $026e
	call ClearMemory16 ; $0270
	xor a ; $0273
	ldh [rVBK], a ; $0274
	ld hl, vBGMap0 ; $0276
	ld c, $80 ; $0279
	call ClearMemory16 ; $027b
	ret ; $027e
LoadBGPaletteData:
	ld a, $80 ; $027f
	ldh [rBGPI], a ; $0281
	ld c, $69 ; $0283
	jr LoadOBJPaletteData.step ; $0285
LoadOBJPaletteData:
	ld a, $80 ; $0287
	ldh [rOBPI], a ; $0289
	ld c, LOW(rOBPD) ; $028b
.step:
	ld b, $08 ; $028d
.loop:
	ld a, [hl+] ; $028f
	ldh [c], a ; $0290
	ld a, [hl+] ; $0291
	ldh [c], a ; $0292
	ld a, [hl+] ; $0293
	ldh [c], a ; $0294
	ld a, [hl+] ; $0295
	ldh [c], a ; $0296
	ld a, [hl+] ; $0297
	ldh [c], a ; $0298
	ld a, [hl+] ; $0299
	ldh [c], a ; $029a
	ld a, [hl+] ; $029b
	ldh [c], a ; $029c
	ld a, [hl+] ; $029d
	ldh [c], a ; $029e
	dec b ; $029f
	jr nz, .loop ; $02a0
	ret ; $02a2
SwitchCPUSpeed:
	ldh a, [rSPD] ; $02a3
	bit 7, a ; $02a5
	ret nz ; $02a7
	ld a, $01 ; $02a8
	ldh [rSPD], a ; $02aa
	ldh a, [rIE] ; $02ac
	push af ; $02ae
	xor a ; $02af
	ldh [rIE], a ; $02b0
	ld a, $30 ; $02b2
	ldh [rJOYP], a ; $02b4
	stop ; $02b6
.loop:
	ldh a, [rSPD] ; $02b8
	bit 7, a ; $02ba
	jr z, .loop ; $02bc
	xor a ; $02be
	ldh [rJOYP], a ; $02bf
	ldh [rIF], a ; $02c1
	pop af ; $02c3
	ldh [rIE], a ; $02c4
	ret ; $02c6
; SwitchCPUSpeed with its two branch conditions inverted (ret z / jr nz where the live one has ret nz / jr z): the single-speed direction the game never asks for. Nothing calls it.
Unused_00_SwitchCPUSpeedSingle:
	ldh a, [rSPD] ; $02c7
	bit 7, a ; $02c9
	ret z ; $02cb
	ld a, $01 ; $02cc
	ldh [rSPD], a ; $02ce
	ldh a, [rIE] ; $02d0
	push af ; $02d2
	xor a ; $02d3
	ldh [rIE], a ; $02d4
	ld a, $30 ; $02d6
	ldh [rJOYP], a ; $02d8
	stop ; $02da
.loopB:
	ldh a, [rSPD] ; $02dc
	bit 7, a ; $02de
	jr nz, .loopB ; $02e0
	xor a ; $02e2
	ldh [rJOYP], a ; $02e3
	ldh [rIF], a ; $02e5
	pop af ; $02e7
	ldh [rIE], a ; $02e8
	ret ; $02ea
ReadJoypad:
	ld a, $20 ; $02eb
	ldh [rJOYP], a ; $02ed
	ldh a, [rJOYP] ; $02ef
	ldh a, [rJOYP] ; $02f1
	cpl ; $02f3
	and $0f ; $02f4
	swap a ; $02f6
	ld b, a ; $02f8
	ld a, $10 ; $02f9
	ldh [rJOYP], a ; $02fb
	ldh a, [rJOYP] ; $02fd
	ldh a, [rJOYP] ; $02ff
	ldh a, [rJOYP] ; $0301
	ldh a, [rJOYP] ; $0303
	ldh a, [rJOYP] ; $0305
	ldh a, [rJOYP] ; $0307
	cpl ; $0309
	and $0f ; $030a
	or b ; $030c
	ld c, a ; $030d
	ldh a, [hPlayerInputFlags] ; $030e
	xor c ; $0310
	and c ; $0311
	ldh [hInputRisingEdge], a ; $0312
	ld a, c ; $0314
	ldh [hPlayerInputFlags], a ; $0315
	ld a, $30 ; $0317
	ldh [rJOYP], a ; $0319
	ldh a, [hPlayerInputFlags] ; $031b
	ld b, a ; $031d
	or a ; $031e
	jr z, .setInputRepeatTimer ; $031f
	ldh a, [hInputRepeatButtons] ; $0321
	and b ; $0323
	jr nz, .nonZero ; $0324
	ldh a, [hInputRepeatButtons] ; $0326
	cp b ; $0328
	jr nz, .setInputRepeatTimer ; $0329
.nonZero:
	ldh a, [hInputRepeatTimer] ; $032b
	dec a ; $032d
	jr nz, .store ; $032e
	ldh a, [hInputRepeatDelay] ; $0330
	ldh [hInputRepeatTimer], a ; $0332
	ld a, b ; $0334
	jr .store2 ; $0335
.store:
	ldh [hInputRepeatTimer], a ; $0337
	xor a ; $0339
	jr .store2 ; $033a
.setInputRepeatTimer:
	ld a, $12 ; $033c
	ldh [hInputRepeatTimer], a ; $033e
	ld a, b ; $0340
	ldh [hInputRepeatButtons], a ; $0341
.store2:
	ldh [hInputPressed], a ; $0343
	ret ; $0345
DisableLCDSafely:
	ldh a, [rLCDC] ; $0346
	bit 7, a ; $0348
	jr z, .clearQueues ; $034a
	ldh a, [rIE] ; $034c
	ldh [hSavedIE], a ; $034e
	res 0, a ; $0350
	ldh [rIE], a ; $0352
.waitVBlank:
	ldh a, [rLY] ; $0354
	cp $91 ; $0356
	jr nz, .waitVBlank ; $0358
	ldh a, [rLCDC] ; $035a
	and $7f ; $035c
	ldh [rLCDC], a ; $035e
	xor a ; $0360
	ldh [rIF], a ; $0361
	ldh a, [hSavedIE] ; $0363
	ldh [rIE], a ; $0365
.clearQueues:
	push hl ; $0367
	push bc ; $0368
	call ClearVRAMCopyQueue ; $0369
	xor a ; $036c
	ld hl, hBGRowBlitPending ; $036d
	ld [hl+], a ; $0370
	ld [hl+], a ; $0371
	ld [hl+], a ; $0372
	pop bc ; $0373
	pop hl ; $0374
	ret ; $0375
EnableLCD:
	ldh a, [rLCDC] ; $0376
	or $80 ; $0378
	ldh [rLCDC], a ; $037a
	call ClearUnusedSprites ; $037c
	xor a ; $037f
	ldh [hVBlankOccurred], a ; $0380
	ret ; $0382
ClearVRAMBank:
	ldh a, [hIsCGB] ; $0383
	and a ; $0385
	jp nz, ClearBothVRAMBanks ; $0386
	ld hl, vTiles0 ; $0389
	ld bc, $0200 ; $038c
	call ClearMemoryBC16 ; $038f
	ret ; $0392
Unused_00_ClearBGMap:
	ldh a, [hIsCGB] ; $0393
	and a ; $0395
	jp nz, ClearBothVRAMBanks.loop ; $0396
	ld hl, $9800 ; $0399
	ld bc, $0400 ; $039c
.loop:
	xor a ; $039f
	ld [hl+], a ; $03a0
	dec bc ; $03a1
	ld a, b ; $03a2
	or c ; $03a3
	jr nz, .loop ; $03a4
	ret ; $03a6
ClearBytes:
	xor a ; $03a7
	ld [hl+], a ; $03a8
	dec bc ; $03a9
	ld a, c ; $03aa
	or b ; $03ab
	jr nz, ClearBytes ; $03ac
