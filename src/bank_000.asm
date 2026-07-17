SECTION "ROM Bank $00", ROM0[$0000]

Rst00:
	jp JumpTableDispatch ; $0000
	ds 5, $ff ; $0003, fill
Rst08:
	jp PlaySoundCmd ; $0008
	ds 5, $ff ; $000b, fill
Rst10:
	jp FarCall ; $0010
	ds 5, $ff ; $0013, fill
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
	ds 5, $ff ; $0033, fill
Rst38:
	rst Rst38 ; $0038
	rst Rst38 ; $0039
	rst Rst38 ; $003a
	rst Rst38 ; $003b
	rst Rst38 ; $003c
	rst Rst38 ; $003d
	rst Rst38 ; $003e
	rst Rst38 ; $003f
VBlankInterrupt:
	jp VBlankHandler ; $0040
	ds 5, $ff ; $0043, fill
LCDStatInterrupt:
	jp LCDStatHandler ; $0048
	ds 3, $ff ; $004b, fill
Func_00_004e:
	rst Rst38 ; $004e
	rst Rst38 ; $004f
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
	jp Label_00_0150 ; $0101
	INCBIN "data/bank_000/d_0104.bin" ; $0104, 76 bytes
Label_00_0150:
	jp Start ; $0150
	INCBIN "data/bank_000/d_0153.bin" ; $0153, 11 bytes
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
	ld [$2000], a ; $0170
	pop hl ; $0173
	jp hl ; $0174
	push af ; $0175
	push hl ; $0176
	ld hl, sp + 4 ; $0177
	ld a, [hl] ; $0179
	ldh [hRomBank], a ; $017a
	ld [$2000], a ; $017c
	pop hl ; $017f
	pop af ; $0180
	inc sp ; $0181
	inc sp ; $0182
	ret ; $0183
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
	ld [$2000], a ; $0196
	pop hl ; $0199
	ld a, b ; $019a
	add a, a ; $019b
	add a, l ; $019c
	ld l, a ; $019d
	jr nc, Label_00_01a1 ; $019e
	inc h ; $01a0
Label_00_01a1:
	ld a, [hl+] ; $01a1
	ld h, [hl] ; $01a2
	ld l, a ; $01a3
	or a, h ; $01a4
	ret z ; $01a5
	jp hl ; $01a6
	push af ; $01a7
	push hl ; $01a8
	ld hl, sp + 4 ; $01a9
	ld a, [hl] ; $01ab
	ldh [hRomBank], a ; $01ac
	ld [$2000], a ; $01ae
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
	ld [$2000], a ; $01c9
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
	ld [$2000], a ; $01dc
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
	ld [$2000], a ; $0203
	call CallVectorEntryE ; $0206
	pop af ; $0209
	ldh [hRomBank], a ; $020a
	ld [$2000], a ; $020c
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
	ld [$2000], a ; $0221
	ld h, $40 ; $0224
	ld a, [hl+] ; $0226
	ld h, [hl] ; $0227
	ld l, a ; $0228
	call CopyMemoryBC ; $0229
	pop af ; $022c
	ldh [hRomBank], a ; $022d
	ld [$2000], a ; $022f
	pop af ; $0232
	ret ; $0233
DecompressDataFromBank:
	push af ; $0234
	ldh a, [hRomBank] ; $0235
	push af ; $0237
	ld a, h ; $0238
	ldh [hRomBank], a ; $0239
	ld [$2000], a ; $023b
	ld h, $40 ; $023e
	ld a, [hl+] ; $0240
	ld h, [hl] ; $0241
	ld l, a ; $0242
	call DecompressData ; $0243
	pop af ; $0246
	ldh [hRomBank], a ; $0247
	ld [$2000], a ; $0249
	pop af ; $024c
	ret ; $024d
ClearBothVRAMBanks:
	ld a, $01 ; $024e
	ldh [rVBK], a ; $0250
	ld hl, $8000 ; $0252
	ld bc, $0200 ; $0255
	call ClearMemoryBC16 ; $0258
	xor a, a ; $025b
	ldh [rVBK], a ; $025c
	ld hl, $8000 ; $025e
	ld bc, $0200 ; $0261
	jp ClearMemoryBC16 ; $0264
Label_00_0267:
	ld a, $01 ; $0267
	ldh [rVBK], a ; $0269
	ld hl, $9800 ; $026b
	ld c, $80 ; $026e
	call ClearMemory16 ; $0270
	xor a, a ; $0273
	ldh [rVBK], a ; $0274
	ld hl, $9800 ; $0276
	ld c, $80 ; $0279
	call ClearMemory16 ; $027b
	ret ; $027e
LoadBGPaletteData:
	ld a, $80 ; $027f
	ldh [rBGPI], a ; $0281
	ld c, $69 ; $0283
	jr Label_00_028d ; $0285
LoadOBJPaletteData:
	ld a, $80 ; $0287
	ldh [rOBPI], a ; $0289
	ld c, $6b ; $028b
Label_00_028d:
	ld b, $08 ; $028d
Label_00_028f:
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
	jr nz, Label_00_028f ; $02a0
	ret ; $02a2
SwitchCPUSpeed:
	ldh a, [rSPD] ; $02a3
	bit 7, a ; $02a5
	ret nz ; $02a7
	ld a, $01 ; $02a8
	ldh [rSPD], a ; $02aa
	ldh a, [rIE] ; $02ac
	push af ; $02ae
	xor a, a ; $02af
	ldh [rIE], a ; $02b0
	ld a, $30 ; $02b2
	ldh [rJOYP], a ; $02b4
	stop ; $02b6
Label_00_02b8:
	ldh a, [rSPD] ; $02b8
	bit 7, a ; $02ba
	jr z, Label_00_02b8 ; $02bc
	xor a, a ; $02be
	ldh [rJOYP], a ; $02bf
	ldh [rIF], a ; $02c1
	pop af ; $02c3
	ldh [rIE], a ; $02c4
	ret ; $02c6
	ldh a, [rSPD] ; $02c7
	bit 7, a ; $02c9
	ret z ; $02cb
	ld a, $01 ; $02cc
	ldh [rSPD], a ; $02ce
	ldh a, [rIE] ; $02d0
	push af ; $02d2
	xor a, a ; $02d3
	ldh [rIE], a ; $02d4
	ld a, $30 ; $02d6
	ldh [rJOYP], a ; $02d8
	stop ; $02da
Label_00_02dc:
	ldh a, [rSPD] ; $02dc
	bit 7, a ; $02de
	jr nz, Label_00_02dc ; $02e0
	xor a, a ; $02e2
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
	and a, $0f ; $02f4
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
	and a, $0f ; $030a
	or a, b ; $030c
	ld c, a ; $030d
	ldh a, [hPlayerInputFlags] ; $030e
	xor a, c ; $0310
	and a, c ; $0311
	ldh [hInputRisingEdge], a ; $0312
	ld a, c ; $0314
	ldh [hPlayerInputFlags], a ; $0315
	ld a, $30 ; $0317
	ldh [rJOYP], a ; $0319
	ldh a, [hPlayerInputFlags] ; $031b
	ld b, a ; $031d
	or a, a ; $031e
	jr z, Label_00_033c ; $031f
	ldh a, [hInputRepeatButtons] ; $0321
	and a, b ; $0323
	jr nz, Label_00_032b ; $0324
	ldh a, [hInputRepeatButtons] ; $0326
	cp a, b ; $0328
	jr nz, Label_00_033c ; $0329
Label_00_032b:
	ldh a, [hInputRepeatTimer] ; $032b
	dec a ; $032d
	jr nz, Label_00_0337 ; $032e
	ldh a, [hInputRepeatDelay] ; $0330
	ldh [hInputRepeatTimer], a ; $0332
	ld a, b ; $0334
	jr Label_00_0343 ; $0335
Label_00_0337:
	ldh [hInputRepeatTimer], a ; $0337
	xor a, a ; $0339
	jr Label_00_0343 ; $033a
Label_00_033c:
	ld a, $12 ; $033c
	ldh [hInputRepeatTimer], a ; $033e
	ld a, b ; $0340
	ldh [hInputRepeatButtons], a ; $0341
Label_00_0343:
	ldh [hInputPressed], a ; $0343
	ret ; $0345
DisableLCDSafely:
	ldh a, [rLCDC] ; $0346
	bit 7, a ; $0348
	jr z, Label_00_0367 ; $034a
	ldh a, [rIE] ; $034c
	ldh [$ff9f], a ; $034e
	res 0, a ; $0350
	ldh [rIE], a ; $0352
Label_00_0354:
	ldh a, [rLY] ; $0354
	cp a, $91 ; $0356
	jr nz, Label_00_0354 ; $0358
	ldh a, [rLCDC] ; $035a
	and a, $7f ; $035c
	ldh [rLCDC], a ; $035e
	xor a, a ; $0360
	ldh [rIF], a ; $0361
	ldh a, [$ff9f] ; $0363
	ldh [rIE], a ; $0365
Label_00_0367:
	push hl ; $0367
	push bc ; $0368
	call ClearVRAMCopyQueue ; $0369
	xor a, a ; $036c
	ld hl, hBGRowBlitPending ; $036d
	ld [hl+], a ; $0370
	ld [hl+], a ; $0371
	ld [hl+], a ; $0372
	pop bc ; $0373
	pop hl ; $0374
	ret ; $0375
EnableLCD:
	ldh a, [rLCDC] ; $0376
	or a, $80 ; $0378
	ldh [rLCDC], a ; $037a
	call ClearUnusedSprites ; $037c
	xor a, a ; $037f
	ldh [hVBlankOccurred], a ; $0380
	ret ; $0382
ClearVRAMBank:
	ldh a, [hIsCGB] ; $0383
	and a, a ; $0385
	jp nz, ClearBothVRAMBanks ; $0386
	ld hl, $8000 ; $0389
	ld bc, $0200 ; $038c
	call ClearMemoryBC16 ; $038f
	ret ; $0392
	ldh a, [hIsCGB] ; $0393
	and a, a ; $0395
	jp nz, Label_00_0267 ; $0396
	ld hl, $9800 ; $0399
	ld bc, $0400 ; $039c
Label_00_039f:
	xor a, a ; $039f
	ld [hl+], a ; $03a0
	dec bc ; $03a1
	ld a, b ; $03a2
	or a, c ; $03a3
	jr nz, Label_00_039f ; $03a4
	ret ; $03a6
ClearBytes:
	xor a, a ; $03a7
	ld [hl+], a ; $03a8
	dec bc ; $03a9
	ld a, c ; $03aa
	or a, b ; $03ab
	jr nz, ClearBytes ; $03ac
Label_00_03ae:
	ret ; $03ae
ClearMemory16:
	xor a, a ; $03af
Label_00_03b0:
	ld [hl+], a ; $03b0
	ld [hl+], a ; $03b1
	ld [hl+], a ; $03b2
	ld [hl+], a ; $03b3
	ld [hl+], a ; $03b4
	ld [hl+], a ; $03b5
	ld [hl+], a ; $03b6
	ld [hl+], a ; $03b7
	ld [hl+], a ; $03b8
	ld [hl+], a ; $03b9
	ld [hl+], a ; $03ba
	ld [hl+], a ; $03bb
	ld [hl+], a ; $03bc
	ld [hl+], a ; $03bd
	ld [hl+], a ; $03be
	ld [hl+], a ; $03bf
	dec c ; $03c0
	jr nz, Label_00_03b0 ; $03c1
	ret ; $03c3
ClearMemoryBC16:
	xor a, a ; $03c4
	ld [hl+], a ; $03c5
	ld [hl+], a ; $03c6
	ld [hl+], a ; $03c7
	ld [hl+], a ; $03c8
	ld [hl+], a ; $03c9
	ld [hl+], a ; $03ca
	ld [hl+], a ; $03cb
	ld [hl+], a ; $03cc
	ld [hl+], a ; $03cd
	ld [hl+], a ; $03ce
	ld [hl+], a ; $03cf
	ld [hl+], a ; $03d0
	ld [hl+], a ; $03d1
	ld [hl+], a ; $03d2
	ld [hl+], a ; $03d3
	ld [hl+], a ; $03d4
	dec bc ; $03d5
	ld a, b ; $03d6
	or a, c ; $03d7
	jr nz, ClearMemoryBC16 ; $03d8
	ret ; $03da
CopyMemoryBC:
	inc c ; $03db
	dec c ; $03dc
	jr z, Label_00_03e0 ; $03dd
	inc b ; $03df
Label_00_03e0:
	ld a, [hl+] ; $03e0
	ld [de], a ; $03e1
	inc de ; $03e2
	dec c ; $03e3
	jr nz, Label_00_03e0 ; $03e4
	dec b ; $03e6
	jr nz, Label_00_03e0 ; $03e7
	ret ; $03e9
Label_00_03ea:
	ld a, [hl-] ; $03ea
	ld [de], a ; $03eb
	dec de ; $03ec
	dec bc ; $03ed
	ld a, b ; $03ee
	or a, c ; $03ef
	jr nz, Label_00_03ea ; $03f0
	ret ; $03f2
CopyMemoryFast:
	ld a, $0f ; $03f3
	and a, e ; $03f5
	jr z, Label_00_042c ; $03f6
Label_00_03f8:
	ld a, [hl+] ; $03f8
	ld [de], a ; $03f9
	inc de ; $03fa
	ld a, [hl+] ; $03fb
	ld [de], a ; $03fc
	inc de ; $03fd
	ld a, [hl+] ; $03fe
	ld [de], a ; $03ff
	inc de ; $0400
	ld a, [hl+] ; $0401
	ld [de], a ; $0402
	inc de ; $0403
	ld a, [hl+] ; $0404
	ld [de], a ; $0405
	inc de ; $0406
	ld a, [hl+] ; $0407
	ld [de], a ; $0408
	inc de ; $0409
	ld a, [hl+] ; $040a
	ld [de], a ; $040b
	inc de ; $040c
	ld a, [hl+] ; $040d
	ld [de], a ; $040e
	inc de ; $040f
	ld a, [hl+] ; $0410
	ld [de], a ; $0411
	inc de ; $0412
	ld a, [hl+] ; $0413
	ld [de], a ; $0414
	inc de ; $0415
	ld a, [hl+] ; $0416
	ld [de], a ; $0417
	inc de ; $0418
	ld a, [hl+] ; $0419
	ld [de], a ; $041a
	inc de ; $041b
	ld a, [hl+] ; $041c
	ld [de], a ; $041d
	inc de ; $041e
	ld a, [hl+] ; $041f
	ld [de], a ; $0420
	inc de ; $0421
	ld a, [hl+] ; $0422
	ld [de], a ; $0423
	inc de ; $0424
	ld a, [hl+] ; $0425
	ld [de], a ; $0426
	inc de ; $0427
	dec c ; $0428
	jr nz, Label_00_03f8 ; $0429
	ret ; $042b
Label_00_042c:
	ld a, [hl+] ; $042c
	ld [de], a ; $042d
	inc e ; $042e
	ld a, [hl+] ; $042f
	ld [de], a ; $0430
	inc e ; $0431
	ld a, [hl+] ; $0432
	ld [de], a ; $0433
	inc e ; $0434
	ld a, [hl+] ; $0435
	ld [de], a ; $0436
	inc e ; $0437
	ld a, [hl+] ; $0438
	ld [de], a ; $0439
	inc e ; $043a
	ld a, [hl+] ; $043b
	ld [de], a ; $043c
	inc e ; $043d
	ld a, [hl+] ; $043e
	ld [de], a ; $043f
	inc e ; $0440
	ld a, [hl+] ; $0441
	ld [de], a ; $0442
	inc e ; $0443
	ld a, [hl+] ; $0444
	ld [de], a ; $0445
	inc e ; $0446
	ld a, [hl+] ; $0447
	ld [de], a ; $0448
	inc e ; $0449
	ld a, [hl+] ; $044a
	ld [de], a ; $044b
	inc e ; $044c
	ld a, [hl+] ; $044d
	ld [de], a ; $044e
	inc e ; $044f
	ld a, [hl+] ; $0450
	ld [de], a ; $0451
	inc e ; $0452
	ld a, [hl+] ; $0453
	ld [de], a ; $0454
	inc e ; $0455
	ld a, [hl+] ; $0456
	ld [de], a ; $0457
	inc e ; $0458
	ld a, [hl+] ; $0459
	ld [de], a ; $045a
	inc de ; $045b
	dec c ; $045c
	jr nz, Label_00_042c ; $045d
	ret ; $045f
Label_00_0460:
	ld [hl+], a ; $0460
	dec c ; $0461
	jr nz, Label_00_0460 ; $0462
	ret ; $0464
ClearVRAMCopyQueue:
	ld hl, wVRAMCopyQueue ; $0465
	ld c, $05 ; $0468
	jp ClearMemory16 ; $046a
QueueVRAMCopyFromBank:
	ldh a, [hRomBank] ; $046d
	push af ; $046f
	ld a, b ; $0470
	ldh [hRomBank], a ; $0471
	ld [$2000], a ; $0473
	call QueueVRAMCopy ; $0476
	pop af ; $0479
	ldh [hRomBank], a ; $047a
	ld [$2000], a ; $047c
	ret ; $047f
QueueVRAMCopy:
	ldh a, [rLCDC] ; $0480
	add a, a ; $0482
	jr c, Label_00_0492 ; $0483
	xor a, a ; $0485
	bit 5, d ; $0486
	jr z, Label_00_048d ; $0488
	res 5, d ; $048a
	inc a ; $048c
Label_00_048d:
	ldh [rVBK], a ; $048d
	jp StartVRAMDMAFromHL ; $048f
Label_00_0492:
	xor a, a ; $0492
	ldh [hVRAMQueueDirty], a ; $0493
	ld a, c ; $0495
	dec a ; $0496
	push af ; $0497
	push hl ; $0498
	ld hl, wVRAMCopyQueue ; $0499
	ld l, $a0 ; $049c
	ld a, [hl] ; $049e
	or a, a ; $049f
	jr z, Label_00_04e7 ; $04a0
	ld l, $a8 ; $04a2
	ld a, [hl] ; $04a4
	or a, a ; $04a5
	jr z, Label_00_04e7 ; $04a6
	ld l, $b0 ; $04a8
	ld a, [hl] ; $04aa
	or a, a ; $04ab
	jr z, Label_00_04e7 ; $04ac
	ld l, $b8 ; $04ae
	ld a, [hl] ; $04b0
	or a, a ; $04b1
	jr z, Label_00_04e7 ; $04b2
	ld l, $c0 ; $04b4
	ld a, [hl] ; $04b6
	or a, a ; $04b7
	jr z, Label_00_04e7 ; $04b8
	ld l, $c8 ; $04ba
	ld a, [hl] ; $04bc
	or a, a ; $04bd
	jr z, Label_00_04e7 ; $04be
	ld l, $d0 ; $04c0
	ld a, [hl] ; $04c2
	or a, a ; $04c3
	jr z, Label_00_04e7 ; $04c4
	ld l, $d8 ; $04c6
	ld a, [hl] ; $04c8
	or a, a ; $04c9
	jr z, Label_00_04e7 ; $04ca
	ld l, $e0 ; $04cc
	ld a, [hl] ; $04ce
	or a, a ; $04cf
	jr z, Label_00_04e7 ; $04d0
	ld l, $e8 ; $04d2
	ld a, [hl] ; $04d4
	or a, a ; $04d5
	jr z, Label_00_04e7 ; $04d6
	ld a, $01 ; $04d8
	ldh [hVRAMQueueDirty], a ; $04da
	ldh a, [hDebugStepMode] ; $04dc
	or a, a ; $04de
	jr z, Label_00_04e3 ; $04df
	sound $6f ; $04e1
Label_00_04e3:
	pop hl ; $04e3
	pop af ; $04e4
	xor a, a ; $04e5
	ret ; $04e6
Label_00_04e7:
	ldh a, [hRomBank] ; $04e7
	ld [hl+], a ; $04e9
	ldh a, [hWramBank] ; $04ea
	ld [hl+], a ; $04ec
	pop bc ; $04ed
	ld [hl], b ; $04ee
	inc l ; $04ef
	ld [hl], c ; $04f0
	inc l ; $04f1
	ld a, $20 ; $04f2
	and a, d ; $04f4
	jr z, Label_00_04f9 ; $04f5
	ld a, $01 ; $04f7
Label_00_04f9:
	ld [hl+], a ; $04f9
	res 5, d ; $04fa
	ld [hl], d ; $04fc
	inc l ; $04fd
	ld [hl], e ; $04fe
	inc l ; $04ff
	pop af ; $0500
	ld [hl], a ; $0501
	ld a, $01 ; $0502
	ldh [hVRAMQueueDirty], a ; $0504
	ret ; $0506
QueueBGTileWrite:
	xor a, a ; $0507
	ldh [hVRAMQueueDirty], a ; $0508
	push hl ; $050a
	ld hl, wTileWriteQueue ; $050b
	ld c, $10 ; $050e
Label_00_0510:
	ld a, [hl] ; $0510
	or a, a ; $0511
	jr z, Label_00_0521 ; $0512
	inc hl ; $0514
	inc hl ; $0515
	inc hl ; $0516
	inc hl ; $0517
	dec c ; $0518
	jr nz, Label_00_0510 ; $0519
	pop hl ; $051b
	ld a, $01 ; $051c
	ldh [hVRAMQueueDirty], a ; $051e
	ret ; $0520
Label_00_0521:
	pop bc ; $0521
	ld [hl], d ; $0522
	inc hl ; $0523
	ld [hl], e ; $0524
	inc hl ; $0525
	ld [hl], c ; $0526
	inc hl ; $0527
	ld [hl], b ; $0528
	ld a, $01 ; $0529
	ldh [hVRAMQueueDirty], a ; $052b
	ret ; $052d
ProcessVRAMCopyQueues:
	ldh a, [hVRAMQueueDirty] ; $052e
	or a, a ; $0530
	ret z ; $0531
	ld hl, wVRAMCopyQueue ; $0532
	ld c, $0a ; $0535
	ldh a, [hWramBank] ; $0537
	ld e, a ; $0539
	ldh a, [hRomBank] ; $053a
	ld d, a ; $053c
	push de ; $053d
	ld d, $ff ; $053e
Label_00_0540:
	ld a, [hl] ; $0540
	or a, a ; $0541
	jr z, Label_00_0566 ; $0542
	ldh [hRomBank], a ; $0544
	ld [$2000], a ; $0546
	xor a, a ; $0549
	ld [hl+], a ; $054a
	ld a, [hl+] ; $054b
	wram_bank ; $054c
	ld e, $51 ; $0550
	ld a, [hl+] ; $0552
	ld [de], a ; $0553
	inc e ; $0554
	ld a, [hl+] ; $0555
	ld [de], a ; $0556
	inc e ; $0557
	ld a, [hl+] ; $0558
	ldh [rVBK], a ; $0559
	ld a, [hl+] ; $055b
	ld [de], a ; $055c
	inc e ; $055d
	ld a, [hl+] ; $055e
	ld [de], a ; $055f
	inc e ; $0560
	ld a, [hl+] ; $0561
	ld [de], a ; $0562
	dec c ; $0563
	jr nz, Label_00_0540 ; $0564
Label_00_0566:
	pop de ; $0566
	ld a, e ; $0567
	wram_bank ; $0568
	ld a, d ; $056c
	ldh [hRomBank], a ; $056d
	ld [$2000], a ; $056f
	ld hl, wTileWriteQueue ; $0572
	ld c, $10 ; $0575
Label_00_0577:
	ld a, [hl] ; $0577
	or a, a ; $0578
	jr z, Label_00_0594 ; $0579
	push bc ; $057b
	ld d, a ; $057c
	xor a, a ; $057d
	ld [hl+], a ; $057e
	ld e, [hl] ; $057f
	inc l ; $0580
	ld c, [hl] ; $0581
	inc l ; $0582
	ld b, [hl] ; $0583
	inc l ; $0584
	xor a, a ; $0585
	ldh [rVBK], a ; $0586
	ld a, c ; $0588
	ld [de], a ; $0589
	ld a, $01 ; $058a
	ldh [rVBK], a ; $058c
	ld a, b ; $058e
	ld [de], a ; $058f
	pop bc ; $0590
	dec c ; $0591
	jr nz, Label_00_0577 ; $0592
Label_00_0594:
	ret ; $0594
	dec c ; $0595
	jr z, Label_00_0566 ; $0596
	ld a, c ; $0598
	add a, a ; $0599
	add a, a ; $059a
	add a, a ; $059b
	ld c, a ; $059c
	ld a, l ; $059d
	add a, $08 ; $059e
	and a, $f8 ; $05a0
	ld l, a ; $05a2
	ld de, wVRAMCopyQueue ; $05a3
Label_00_05a6:
	ld a, [hl+] ; $05a6
	ld [de], a ; $05a7
	inc e ; $05a8
	dec c ; $05a9
	jr nz, Label_00_05a6 ; $05aa
	xor a, a ; $05ac
	ld [de], a ; $05ad
	jr Label_00_0566 ; $05ae
LoadPaletteShadow:
	ldh a, [hFadedOut] ; $05b0
	and a, a ; $05b2
	jr nz, LoadPalettesMasterOnly ; $05b3
LoadPalettesImmediate:
	push de ; $05b5
	ld a, e ; $05b6
	add a, a ; $05b7
	add a, a ; $05b8
	ld c, a ; $05b9
	ld a, d ; $05ba
	add a, a ; $05bb
	add a, a ; $05bc
	add a, a ; $05bd
	ld e, a ; $05be
	ld d, $c1 ; $05bf
Label_00_05c1:
	ld a, [hl+] ; $05c1
	ld [de], a ; $05c2
	inc d ; $05c3
	ld [de], a ; $05c4
	inc e ; $05c5
	ld a, [hl+] ; $05c6
	ld [de], a ; $05c7
	dec d ; $05c8
	ld [de], a ; $05c9
	inc e ; $05ca
	dec c ; $05cb
	jr nz, Label_00_05c1 ; $05cc
	ld hl, hPaletteDirtyFlags ; $05ce
	pop de ; $05d1
	bit 3, d ; $05d2
	jr nz, Label_00_05d8 ; $05d4
	set 0, [hl] ; $05d6
Label_00_05d8:
	ld a, e ; $05d8
	add a, d ; $05d9
	cp a, $09 ; $05da
	jr c, Label_00_05e0 ; $05dc
	set 1, [hl] ; $05de
Label_00_05e0:
	ret ; $05e0
LoadPalettesMasterOnly:
	ld a, e ; $05e1
	add a, a ; $05e2
	add a, a ; $05e3
	add a, a ; $05e4
	ld c, a ; $05e5
	ld a, d ; $05e6
	add a, a ; $05e7
	add a, a ; $05e8
	add a, a ; $05e9
	ld e, a ; $05ea
	ld d, $c2 ; $05eb
Label_00_05ed:
	ld a, [hl+] ; $05ed
	ld [de], a ; $05ee
	inc e ; $05ef
	dec c ; $05f0
	jr nz, Label_00_05ed ; $05f1
	ret ; $05f3
RestorePalettesFromMaster:
	push af ; $05f4
	push bc ; $05f5
	push de ; $05f6
	push hl ; $05f7
	ld hl, wMasterPalettes ; $05f8
	ld de, wBGPalettes ; $05fb
	ld c, $08 ; $05fe
	call CopyMemoryFast ; $0600
	ld hl, hPaletteDirtyFlags ; $0603
	ld [hl], $03 ; $0606
	pop hl ; $0608
	pop de ; $0609
	pop bc ; $060a
	pop af ; $060b
	ret ; $060c
ApplyPendingPaletteUpdates:
	ldh a, [hPaletteDirtyFlags] ; $060d
	rrca ; $060f
	jr nc, Label_00_0618 ; $0610
	ld hl, wBGPalettes ; $0612
	call LoadBGPaletteData ; $0615
Label_00_0618:
	ldh a, [hPaletteDirtyFlags] ; $0618
	rrca ; $061a
	rrca ; $061b
	jr nc, Label_00_0624 ; $061c
	ld hl, wOBJPalettes ; $061e
	call LoadOBJPaletteData ; $0621
Label_00_0624:
	xor a, a ; $0624
	ldh [hPaletteDirtyFlags], a ; $0625
	ret ; $0627
FarReadByte:
	push bc ; $0628
	ld b, a ; $0629
	ldh a, [hRomBank] ; $062a
	push af ; $062c
	ld a, b ; $062d
	ldh [hRomBank], a ; $062e
	ld [$2000], a ; $0630
	ld c, [hl] ; $0633
	pop af ; $0634
	ldh [hRomBank], a ; $0635
	ld [$2000], a ; $0637
	ld a, c ; $063a
	pop bc ; $063b
	ret ; $063c
FarReadWord:
	ld b, a ; $063d
	ldh a, [hRomBank] ; $063e
	push af ; $0640
	ld a, b ; $0641
	ldh [hRomBank], a ; $0642
	ld [$2000], a ; $0644
	ld c, [hl] ; $0647
	inc hl ; $0648
	ld b, [hl] ; $0649
	dec hl ; $064a
	pop af ; $064b
	ldh [hRomBank], a ; $064c
	ld [$2000], a ; $064e
	ret ; $0651
FarReadWordDI:
	di ; $0652
	ld [$2000], a ; $0653
	ld a, [hl+] ; $0656
	ld c, a ; $0657
	ld a, [hl-] ; $0658
	ld b, a ; $0659
	ldh a, [hRomBank] ; $065a
	ld [$2000], a ; $065c
	ei ; $065f
	ret ; $0660
	push bc ; $0661
	ldh a, [hRomBank] ; $0662
	ld b, a ; $0664
	ld a, h ; $0665
	ldh [hRomBank], a ; $0666
	ld [$2000], a ; $0668
	ld c, a ; $066b
	ld h, $40 ; $066c
	ld a, [hl+] ; $066e
	ld h, [hl] ; $066f
	ld l, a ; $0670
	ld a, b ; $0671
	ldh [hRomBank], a ; $0672
	ld [$2000], a ; $0674
	ld a, c ; $0677
	pop bc ; $0678
	ret ; $0679
FarCopyBytes:
	push bc ; $067a
	ld b, a ; $067b
	ldh a, [hRomBank] ; $067c
	ld c, a ; $067e
	ld a, b ; $067f
	ldh [hRomBank], a ; $0680
	ld [$2000], a ; $0682
	ld a, c ; $0685
	pop bc ; $0686
	push af ; $0687
	call CopyMemoryBC ; $0688
	pop af ; $068b
	ldh [hRomBank], a ; $068c
	ld [$2000], a ; $068e
	ret ; $0691
	push af ; $0692
	push bc ; $0693
	ld b, a ; $0694
	ldh a, [hRomBank] ; $0695
	ld c, a ; $0697
	ld a, b ; $0698
	ldh [hRomBank], a ; $0699
	ld [$2000], a ; $069b
	ld a, c ; $069e
	pop bc ; $069f
	push af ; $06a0
	call DecompressData ; $06a1
	pop af ; $06a4
	ldh [hRomBank], a ; $06a5
	ld [$2000], a ; $06a7
	pop af ; $06aa
	ret ; $06ab
CopyOAMDMARoutineToHRAM:
	ld c, $80 ; $06ac
	ld b, $0a ; $06ae
	ld hl, $06ba ; $06b0
Label_00_06b3:
	ld a, [hl+] ; $06b3
	ldh [c], a ; $06b4
	inc c ; $06b5
	dec b ; $06b6
	jr nz, Label_00_06b3 ; $06b7
	ret ; $06b9
	ld a, $c0 ; $06ba
	ldh [rDMA], a ; $06bc
	ld a, $28 ; $06be
Label_00_06c0:
	dec a ; $06c0
	jr nz, Label_00_06c0 ; $06c1
	ret ; $06c3
JumpTableDispatch:
	add a, a ; $06c4
	pop hl ; $06c5
	add a, l ; $06c6
	ld l, a ; $06c7
	jr nc, Label_00_06cb ; $06c8
	inc h ; $06ca
Label_00_06cb:
	ld a, [hl+] ; $06cb
	ld h, [hl] ; $06cc
	ld l, a ; $06cd
JumpToHL:
	jp hl ; $06ce
FarDispatchIndexed:
	push af ; $06cf
	push bc ; $06d0
	ld c, a ; $06d1
	ldh a, [hRomBank] ; $06d2
	push af ; $06d4
	ld a, h ; $06d5
	ldh [hRomBank], a ; $06d6
	ld [$2000], a ; $06d8
	ld h, $40 ; $06db
	ld a, [hl+] ; $06dd
	ld h, [hl] ; $06de
	ld l, a ; $06df
	ld a, c ; $06e0
	add a, a ; $06e1
	add a, l ; $06e2
	ld l, a ; $06e3
	ld a, h ; $06e4
	adc a, $00 ; $06e5
	ld h, a ; $06e7
	ld a, [hl+] ; $06e8
	ld h, [hl] ; $06e9
	ld l, a ; $06ea
	call DecompressData ; $06eb
	pop af ; $06ee
	ldh [hRomBank], a ; $06ef
	ld [$2000], a ; $06f1
	pop bc ; $06f4
	pop af ; $06f5
	ret ; $06f6
FarCopyIndexed:
	push af ; $06f7
	push bc ; $06f8
	push de ; $06f9
	push hl ; $06fa
	ld b, a ; $06fb
	ldh a, [hRomBank] ; $06fc
	push af ; $06fe
	ld a, h ; $06ff
	ldh [hRomBank], a ; $0700
	ld [$2000], a ; $0702
	ld h, $40 ; $0705
	ld a, [hl+] ; $0707
	ld h, [hl] ; $0708
	ld l, a ; $0709
	ld a, b ; $070a
	add a, a ; $070b
	add a, l ; $070c
	ld l, a ; $070d
	ld a, h ; $070e
	adc a, $00 ; $070f
	ld h, a ; $0711
	ld a, [hl+] ; $0712
	ld h, [hl] ; $0713
	ld l, a ; $0714
Label_00_0715:
	ld a, [hl+] ; $0715
	ld [de], a ; $0716
	inc de ; $0717
	dec c ; $0718
	jr nz, Label_00_0715 ; $0719
	pop af ; $071b
	ldh [hRomBank], a ; $071c
	ld [$2000], a ; $071e
	pop hl ; $0721
	pop de ; $0722
	pop bc ; $0723
	pop af ; $0724
	ret ; $0725
FarCallIndexed1:
	push af ; $0726
	push bc ; $0727
	push de ; $0728
	push hl ; $0729
	ld b, a ; $072a
	ldh a, [hRomBank] ; $072b
	push af ; $072d
	ld a, h ; $072e
	ldh [hRomBank], a ; $072f
	ld [$2000], a ; $0731
	ld h, $40 ; $0734
	ld a, [hl+] ; $0736
	ld h, [hl] ; $0737
	ld l, a ; $0738
	ld a, b ; $0739
	add a, a ; $073a
	add a, l ; $073b
	ld l, a ; $073c
	ld a, h ; $073d
	adc a, $00 ; $073e
	ld h, a ; $0740
	ld a, [hl+] ; $0741
	ld h, [hl] ; $0742
	ld l, a ; $0743
	call QueueVRAMCopy ; $0744
	pop af ; $0747
	ldh [hRomBank], a ; $0748
	ld [$2000], a ; $074a
	pop hl ; $074d
	pop de ; $074e
	pop bc ; $074f
	pop af ; $0750
	ret ; $0751
FarCallIndexed2:
	push af ; $0752
	push bc ; $0753
	push de ; $0754
	push hl ; $0755
	ld b, a ; $0756
	ldh a, [hRomBank] ; $0757
	push af ; $0759
	ld a, h ; $075a
	ldh [hRomBank], a ; $075b
	ld [$2000], a ; $075d
	ld h, $40 ; $0760
	ld a, [hl+] ; $0762
	ld h, [hl] ; $0763
	ld l, a ; $0764
	ld a, b ; $0765
	add a, a ; $0766
	add a, l ; $0767
	ld l, a ; $0768
	ld a, h ; $0769
	adc a, $00 ; $076a
	ld h, a ; $076c
	ld a, [hl+] ; $076d
	ld h, [hl] ; $076e
	ld l, a ; $076f
	call StartVRAMDMAFromHL ; $0770
	pop af ; $0773
	ldh [hRomBank], a ; $0774
	ld [$2000], a ; $0776
	pop hl ; $0779
	pop de ; $077a
	pop bc ; $077b
	pop af ; $077c
	ret ; $077d
FarCallIndexed3:
	push af ; $077e
	push bc ; $077f
	push de ; $0780
	push hl ; $0781
	ld b, a ; $0782
	ldh a, [hRomBank] ; $0783
	push af ; $0785
	ld a, h ; $0786
	ldh [hRomBank], a ; $0787
	ld [$2000], a ; $0789
	ld h, $40 ; $078c
	ld a, [hl+] ; $078e
	ld h, [hl] ; $078f
	ld l, a ; $0790
	ld a, b ; $0791
	add a, a ; $0792
	add a, l ; $0793
	ld l, a ; $0794
	ld a, h ; $0795
	adc a, $00 ; $0796
	ld h, a ; $0798
	ld a, [hl+] ; $0799
	ld h, [hl] ; $079a
	ld l, a ; $079b
	call CopyMemoryFast ; $079c
	pop af ; $079f
	ldh [hRomBank], a ; $07a0
	ld [$2000], a ; $07a2
	pop hl ; $07a5
	pop de ; $07a6
	pop bc ; $07a7
	pop af ; $07a8
	ret ; $07a9
FarReadPtrIndexed:
	push bc ; $07aa
	ldh a, [hRomBank] ; $07ab
	ld b, a ; $07ad
	ld a, h ; $07ae
	ldh [hRomBank], a ; $07af
	ld [$2000], a ; $07b1
	ld c, a ; $07b4
	ld h, $40 ; $07b5
	ld a, [hl+] ; $07b7
	ld h, [hl] ; $07b8
	ld l, a ; $07b9
	ld a, b ; $07ba
	ldh [hRomBank], a ; $07bb
	ld [$2000], a ; $07bd
	ld a, c ; $07c0
	pop bc ; $07c1
	jp CallHLInBankA ; $07c2
FarCallVector:
	ldh a, [hRomBank] ; $07c5
	push af ; $07c7
	ld a, h ; $07c8
	ldh [hRomBank], a ; $07c9
	ld [$2000], a ; $07cb
	ld h, $40 ; $07ce
	ld a, [hl+] ; $07d0
	ld h, [hl] ; $07d1
	ld l, a ; $07d2
	call JumpToHL ; $07d3
	pop af ; $07d6
	ldh [hRomBank], a ; $07d7
	ld [$2000], a ; $07d9
	ret ; $07dc
CopyMapRows32To64:
	ld c, $10 ; $07dd
Label_00_07df:
	ld a, [hl+] ; $07df
	ld [de], a ; $07e0
	inc de ; $07e1
	ld a, [hl+] ; $07e2
	ld [de], a ; $07e3
	inc de ; $07e4
	ld a, [hl+] ; $07e5
	ld [de], a ; $07e6
	inc de ; $07e7
	ld a, [hl+] ; $07e8
	ld [de], a ; $07e9
	inc de ; $07ea
	ld a, [hl+] ; $07eb
	ld [de], a ; $07ec
	inc de ; $07ed
	ld a, [hl+] ; $07ee
	ld [de], a ; $07ef
	inc de ; $07f0
	ld a, [hl+] ; $07f1
	ld [de], a ; $07f2
	inc de ; $07f3
	ld a, [hl+] ; $07f4
	ld [de], a ; $07f5
	inc de ; $07f6
	ld a, [hl+] ; $07f7
	ld [de], a ; $07f8
	inc de ; $07f9
	ld a, [hl+] ; $07fa
	ld [de], a ; $07fb
	inc de ; $07fc
	ld a, [hl+] ; $07fd
	ld [de], a ; $07fe
	inc de ; $07ff
	ld a, [hl+] ; $0800
	ld [de], a ; $0801
	inc de ; $0802
	ld a, [hl+] ; $0803
	ld [de], a ; $0804
	inc de ; $0805
	ld a, [hl+] ; $0806
	ld [de], a ; $0807
	inc de ; $0808
	ld a, [hl+] ; $0809
	ld [de], a ; $080a
	inc de ; $080b
	ld a, [hl+] ; $080c
	ld [de], a ; $080d
	inc de ; $080e
	ld a, [hl+] ; $080f
	ld [de], a ; $0810
	inc de ; $0811
	ld a, [hl+] ; $0812
	ld [de], a ; $0813
	inc de ; $0814
	ld a, [hl+] ; $0815
	ld [de], a ; $0816
	inc de ; $0817
	ld a, [hl+] ; $0818
	ld [de], a ; $0819
	inc de ; $081a
	ld a, [hl+] ; $081b
	ld [de], a ; $081c
	inc de ; $081d
	ld a, [hl+] ; $081e
	ld [de], a ; $081f
	inc de ; $0820
	ld a, [hl+] ; $0821
	ld [de], a ; $0822
	inc de ; $0823
	ld a, [hl+] ; $0824
	ld [de], a ; $0825
	inc de ; $0826
	ld a, [hl+] ; $0827
	ld [de], a ; $0828
	inc de ; $0829
	ld a, [hl+] ; $082a
	ld [de], a ; $082b
	inc de ; $082c
	ld a, [hl+] ; $082d
	ld [de], a ; $082e
	inc de ; $082f
	ld a, [hl+] ; $0830
	ld [de], a ; $0831
	inc de ; $0832
	ld a, [hl+] ; $0833
	ld [de], a ; $0834
	inc de ; $0835
	ld a, [hl+] ; $0836
	ld [de], a ; $0837
	inc de ; $0838
	ld a, [hl+] ; $0839
	ld [de], a ; $083a
	inc de ; $083b
	ld a, [hl+] ; $083c
	ld [de], a ; $083d
	inc de ; $083e
	push hl ; $083f
	ld h, d ; $0840
	ld l, e ; $0841
	xor a, a ; $0842
	ld [hl+], a ; $0843
	ld [hl+], a ; $0844
	ld [hl+], a ; $0845
	ld [hl+], a ; $0846
	ld [hl+], a ; $0847
	ld [hl+], a ; $0848
	ld [hl+], a ; $0849
	ld [hl+], a ; $084a
	ld [hl+], a ; $084b
	ld [hl+], a ; $084c
	ld [hl+], a ; $084d
	ld [hl+], a ; $084e
	ld [hl+], a ; $084f
	ld [hl+], a ; $0850
	ld [hl+], a ; $0851
	ld [hl+], a ; $0852
	xor a, a ; $0853
	ld [hl+], a ; $0854
	ld [hl+], a ; $0855
	ld [hl+], a ; $0856
	ld [hl+], a ; $0857
	ld [hl+], a ; $0858
	ld [hl+], a ; $0859
	ld [hl+], a ; $085a
	ld [hl+], a ; $085b
	ld [hl+], a ; $085c
	ld [hl+], a ; $085d
	ld [hl+], a ; $085e
	ld [hl+], a ; $085f
	ld [hl+], a ; $0860
	ld [hl+], a ; $0861
	ld [hl+], a ; $0862
	ld [hl+], a ; $0863
	ld d, h ; $0864
	ld e, l ; $0865
	pop hl ; $0866
	dec c ; $0867
	jp nz, Label_00_07df ; $0868
	ret ; $086b
CopyMapToScrollBuffers:
	push af ; $086c
	push bc ; $086d
	push de ; $086e
	push hl ; $086f
	ldh a, [hWramBank] ; $0870
	push af ; $0872
	wram_bank $01 ; $0873
	ld hl, $d000 ; $0879
	ld de, wTextBuffer ; $087c
	ld c, $20 ; $087f
	call CopyMemoryFast ; $0881
	wram_bank $02 ; $0884
	ld hl, wTextBuffer ; $088a
	ld de, $d000 ; $088d
	call CopyMapRows32To64 ; $0890
	wram_bank $01 ; $0893
	ld hl, $d200 ; $0899
	ld de, wTextBuffer ; $089c
	ld c, $20 ; $089f
	call CopyMemoryFast ; $08a1
	wram_bank $02 ; $08a4
	ld hl, wTextBuffer ; $08aa
	ld de, $d800 ; $08ad
	call CopyMapRows32To64 ; $08b0
	ld hl, $d800 ; $08b3
	ld c, $80 ; $08b6
	call ClearMemory16 ; $08b8
	wram_bank $01 ; $08bb
	ld hl, $d400 ; $08c1
	ld de, wTextBuffer ; $08c4
	ld c, $20 ; $08c7
	call CopyMemoryFast ; $08c9
	wram_bank $03 ; $08cc
	ld hl, wTextBuffer ; $08d2
	ld de, $d000 ; $08d5
	call CopyMapRows32To64 ; $08d8
	wram_bank $01 ; $08db
	ld hl, $d600 ; $08e1
	ld de, wTextBuffer ; $08e4
	ld c, $20 ; $08e7
	call CopyMemoryFast ; $08e9
	wram_bank $03 ; $08ec
	ld hl, wTextBuffer ; $08f2
	ld de, $d800 ; $08f5
	call CopyMapRows32To64 ; $08f8
	ld hl, $d800 ; $08fb
	ld c, $80 ; $08fe
	call ClearMemory16 ; $0900
	pop af ; $0903
	wram_bank ; $0904
	pop hl ; $0908
	pop de ; $0909
	pop bc ; $090a
	pop af ; $090b
	ret ; $090c
SignExtendLToHL:
	ld h, $00 ; $090d
	bit 7, l ; $090f
	ret z ; $0911
	dec h ; $0912
	ret ; $0913
SignExtendEToDE:
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
Label_00_0922:
	ld hl, $0000 ; $0922
	ret ; $0925
MulHLByA:
	or a, a ; $0926
	jr z, Label_00_0922 ; $0927
	push af ; $0929
	push de ; $092a
	ld d, h ; $092b
	ld e, l ; $092c
	add a, a ; $092d
	jr c, Label_00_0944 ; $092e
	add a, a ; $0930
	jr c, Label_00_094b ; $0931
	add a, a ; $0933
	jr c, Label_00_0952 ; $0934
	add a, a ; $0936
	jr c, Label_00_0959 ; $0937
	add a, a ; $0939
	jr c, Label_00_0960 ; $093a
	add a, a ; $093c
	jr c, Label_00_0967 ; $093d
	add a, a ; $093f
	jr c, Label_00_096e ; $0940
	jr Label_00_0984 ; $0942
Label_00_0944:
	jr z, Label_00_0975 ; $0944
	add hl, hl ; $0946
	add a, a ; $0947
	jr nc, Label_00_094d ; $0948
	add hl, de ; $094a
Label_00_094b:
	jr z, Label_00_097e ; $094b
Label_00_094d:
	add hl, hl ; $094d
	add a, a ; $094e
	jr nc, Label_00_0954 ; $094f
	add hl, de ; $0951
Label_00_0952:
	jr z, Label_00_097f ; $0952
Label_00_0954:
	add hl, hl ; $0954
	add a, a ; $0955
	jr nc, Label_00_095b ; $0956
	add hl, de ; $0958
Label_00_0959:
	jr z, Label_00_0980 ; $0959
Label_00_095b:
	add hl, hl ; $095b
	add a, a ; $095c
	jr nc, Label_00_0962 ; $095d
	add hl, de ; $095f
Label_00_0960:
	jr z, Label_00_0981 ; $0960
Label_00_0962:
	add hl, hl ; $0962
	add a, a ; $0963
	jr nc, Label_00_0969 ; $0964
	add hl, de ; $0966
Label_00_0967:
	jr z, Label_00_0982 ; $0967
Label_00_0969:
	add hl, hl ; $0969
	add a, a ; $096a
	jr nc, Label_00_0970 ; $096b
	add hl, de ; $096d
Label_00_096e:
	jr z, Label_00_0983 ; $096e
Label_00_0970:
	add hl, hl ; $0970
	add hl, de ; $0971
	pop de ; $0972
	pop af ; $0973
	ret ; $0974
Label_00_0975:
	srl h ; $0975
	rr l ; $0977
	rra ; $0979
	ld h, l ; $097a
	ld l, a ; $097b
	jr Label_00_0984 ; $097c
Label_00_097e:
	add hl, hl ; $097e
Label_00_097f:
	add hl, hl ; $097f
Label_00_0980:
	add hl, hl ; $0980
Label_00_0981:
	add hl, hl ; $0981
Label_00_0982:
	add hl, hl ; $0982
Label_00_0983:
	add hl, hl ; $0983
Label_00_0984:
	pop de ; $0984
	pop af ; $0985
	ret ; $0986
DivHLByDE:
	push af ; $0987
	push bc ; $0988
	xor a, a ; $0989
	sub a, e ; $098a
	ld c, a ; $098b
	sbc a, a ; $098c
	sub a, d ; $098d
	ld b, a ; $098e
	or a, c ; $098f
	jr nz, Label_00_0998 ; $0990
	ld hl, rIE ; $0992
	pop bc ; $0995
	pop af ; $0996
	ret ; $0997
Label_00_0998:
	ld a, h ; $0998
	ld h, l ; $0999
	push hl ; $099a
	ld hl, $0000 ; $099b
	scf ; $099e
	adc a, a ; $099f
	rl l ; $09a0
	add hl, bc ; $09a2
	jr c, Label_00_09a7 ; $09a3
	dec a ; $09a5
	add hl, de ; $09a6
Label_00_09a7:
	adc a, a ; $09a7
	rl l ; $09a8
	add hl, bc ; $09aa
	jr c, Label_00_09af ; $09ab
	dec a ; $09ad
	add hl, de ; $09ae
Label_00_09af:
	adc a, a ; $09af
	rl l ; $09b0
	add hl, bc ; $09b2
	jr c, Label_00_09b7 ; $09b3
	dec a ; $09b5
	add hl, de ; $09b6
Label_00_09b7:
	adc a, a ; $09b7
	rl l ; $09b8
	add hl, bc ; $09ba
	jr c, Label_00_09bf ; $09bb
	dec a ; $09bd
	add hl, de ; $09be
Label_00_09bf:
	adc a, a ; $09bf
	rl l ; $09c0
	add hl, bc ; $09c2
	jr c, Label_00_09c7 ; $09c3
	dec a ; $09c5
	add hl, de ; $09c6
Label_00_09c7:
	adc a, a ; $09c7
	rl l ; $09c8
	add hl, bc ; $09ca
	jr c, Label_00_09cf ; $09cb
	dec a ; $09cd
	add hl, de ; $09ce
Label_00_09cf:
	adc a, a ; $09cf
	rl l ; $09d0
	add hl, bc ; $09d2
	jr c, Label_00_09d7 ; $09d3
	dec a ; $09d5
	add hl, de ; $09d6
Label_00_09d7:
	adc a, a ; $09d7
	rl l ; $09d8
	add hl, bc ; $09da
	jr c, Label_00_09df ; $09db
	dec a ; $09dd
	add hl, de ; $09de
Label_00_09df:
	ld h, a ; $09df
	pop af ; $09e0
	push hl ; $09e1
	ld h, $00 ; $09e2
	scf ; $09e4
	adc a, a ; $09e5
	rl l ; $09e6
	rl h ; $09e8
	add hl, bc ; $09ea
	jr c, Label_00_09ef ; $09eb
	dec a ; $09ed
	add hl, de ; $09ee
Label_00_09ef:
	adc a, a ; $09ef
	rl l ; $09f0
	rl h ; $09f2
	add hl, bc ; $09f4
	jr c, Label_00_09f9 ; $09f5
	dec a ; $09f7
	add hl, de ; $09f8
Label_00_09f9:
	adc a, a ; $09f9
	rl l ; $09fa
	rl h ; $09fc
	add hl, bc ; $09fe
	jr c, Label_00_0a03 ; $09ff
	dec a ; $0a01
	add hl, de ; $0a02
Label_00_0a03:
	adc a, a ; $0a03
	rl l ; $0a04
	rl h ; $0a06
	add hl, bc ; $0a08
	jr c, Label_00_0a0d ; $0a09
	dec a ; $0a0b
	add hl, de ; $0a0c
Label_00_0a0d:
	adc a, a ; $0a0d
	rl l ; $0a0e
	rl h ; $0a10
	add hl, bc ; $0a12
	jr c, Label_00_0a17 ; $0a13
	dec a ; $0a15
	add hl, de ; $0a16
Label_00_0a17:
	adc a, a ; $0a17
	rl l ; $0a18
	rl h ; $0a1a
	add hl, bc ; $0a1c
	jr c, Label_00_0a21 ; $0a1d
	dec a ; $0a1f
	add hl, de ; $0a20
Label_00_0a21:
	adc a, a ; $0a21
	rl l ; $0a22
	rl h ; $0a24
	add hl, bc ; $0a26
	jr c, Label_00_0a2b ; $0a27
	dec a ; $0a29
	add hl, de ; $0a2a
Label_00_0a2b:
	adc a, a ; $0a2b
	rl l ; $0a2c
	rl h ; $0a2e
	add hl, bc ; $0a30
	jr c, Label_00_0a35 ; $0a31
	dec a ; $0a33
	add hl, de ; $0a34
Label_00_0a35:
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
	ldh a, [$fffd] ; $0a3f
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
	ldh [$fffd], a ; $0a4f
	pop de ; $0a51
	pop af ; $0a52
	ret ; $0a53
AngleFromVectorCoarse:
	push bc ; $0a54
	ld c, $00 ; $0a55
	ld a, h ; $0a57
	or a, l ; $0a58
	jr z, Label_00_0aa2 ; $0a59
	ld c, $10 ; $0a5b
	ld a, d ; $0a5d
	or a, e ; $0a5e
	jr z, Label_00_0aa2 ; $0a5f
	push hl ; $0a61
	push de ; $0a62
	bit 7, d ; $0a63
	jr z, Label_00_0a6d ; $0a65
	xor a, a ; $0a67
	sub a, e ; $0a68
	ld e, a ; $0a69
	sbc a, a ; $0a6a
	sub a, d ; $0a6b
	ld d, a ; $0a6c
Label_00_0a6d:
	bit 7, h ; $0a6d
	jr z, Label_00_0a77 ; $0a6f
	xor a, a ; $0a71
	sub a, l ; $0a72
	ld l, a ; $0a73
	sbc a, a ; $0a74
	sub a, h ; $0a75
	ld h, a ; $0a76
Label_00_0a77:
	ld a, h ; $0a77
	cp a, $10 ; $0a78
	jr c, Label_00_0a88 ; $0a7a
	sra d ; $0a7c
	rr e ; $0a7e
	sra d ; $0a80
	rr e ; $0a82
	add hl, hl ; $0a84
	add hl, hl ; $0a85
	jr Label_00_0a8c ; $0a86
Label_00_0a88:
	add hl, hl ; $0a88
	add hl, hl ; $0a89
	add hl, hl ; $0a8a
	add hl, hl ; $0a8b
Label_00_0a8c:
	call DivHLByDE ; $0a8c
	ld c, $0f ; $0a8f
	ld a, h ; $0a91
	or a, a ; $0a92
	jr nz, Label_00_0aa0 ; $0a93
	ld b, l ; $0a95
	ld hl, ArcTanTable ; $0a96
	ld c, $ff ; $0a99
Label_00_0a9b:
	inc c ; $0a9b
	ld a, [hl+] ; $0a9c
	cp a, b ; $0a9d
	jr c, Label_00_0a9b ; $0a9e
Label_00_0aa0:
	pop de ; $0aa0
	pop hl ; $0aa1
Label_00_0aa2:
	ld a, c ; $0aa2
	add a, a ; $0aa3
	add a, a ; $0aa4
	bit 7, d ; $0aa5
	jr z, Label_00_0aac ; $0aa7
	cpl ; $0aa9
	add a, $81 ; $0aaa
Label_00_0aac:
	bit 7, h ; $0aac
	jr z, Label_00_0ab2 ; $0aae
	cpl ; $0ab0
	inc a ; $0ab1
Label_00_0ab2:
	pop bc ; $0ab2
	ret ; $0ab3
ArcTanTable:
	INCBIN "data/bank_000/d_0ab4.bin" ; $0ab4, 17 bytes
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
	bit 7, h ; $0aea
	jr z, VectorFromLengthAndAngleRaw ; $0aec
	push af ; $0aee
	xor a, a ; $0aef
	sub a, l ; $0af0
	ld l, a ; $0af1
	sbc a, a ; $0af2
	sub a, h ; $0af3
	ld h, a ; $0af4
	pop af ; $0af5
	add a, $80 ; $0af6
VectorFromLengthAndAngleRaw:
	push hl ; $0af8
	push af ; $0af9
	call MulHLBySin ; $0afa
	pop af ; $0afd
	ld d, h ; $0afe
	ld e, l ; $0aff
	pop hl ; $0b00
MulHLByCos:
	add a, $40 ; $0b01
MulHLBySin:
	bit 7, a ; $0b03
	jr z, MulHLBySinHalf ; $0b05
	and a, $7f ; $0b07
	call MulHLBySinHalf ; $0b09
	xor a, a ; $0b0c
	sub a, l ; $0b0d
	ld l, a ; $0b0e
	sbc a, a ; $0b0f
	sub a, h ; $0b10
	ld h, a ; $0b11
	ret ; $0b12
MulHLBySinHalf:
	bit 6, a ; $0b13
	jr z, Label_00_0b1a ; $0b15
	cpl ; $0b17
	add a, $81 ; $0b18
Label_00_0b1a:
	push bc ; $0b1a
	add a, $5c ; $0b1b
	ld c, a ; $0b1d
	adc a, $0b ; $0b1e
	sub a, c ; $0b20
	ld b, a ; $0b21
	ld a, [bc] ; $0b22
	call MulHLByA ; $0b23
	ld bc, $0040 ; $0b26
	add hl, bc ; $0b29
	add hl, hl ; $0b2a
	sbc a, a ; $0b2b
	ld l, h ; $0b2c
	ld h, a ; $0b2d
	pop bc ; $0b2e
	ret ; $0b2f
MulHLByCosSigned:
	add a, $40 ; $0b30
MulHLBySinSigned:
	bit 7, a ; $0b32
	jr z, MulHLBySinSignedHalf ; $0b34
	and a, $7f ; $0b36
	call MulHLBySinSignedHalf ; $0b38
	xor a, a ; $0b3b
	sub a, l ; $0b3c
	ld l, a ; $0b3d
	sbc a, a ; $0b3e
	sub a, h ; $0b3f
	ld h, a ; $0b40
	ret ; $0b41
MulHLBySinSignedHalf:
	bit 6, a ; $0b42
	jr z, Label_00_0b49 ; $0b44
	cpl ; $0b46
	add a, $81 ; $0b47
Label_00_0b49:
	push bc ; $0b49
	add a, $5c ; $0b4a
	ld c, a ; $0b4c
	adc a, $0b ; $0b4d
	sub a, c ; $0b4f
	ld b, a ; $0b50
	ld a, [bc] ; $0b51
	call MulHLByASigned ; $0b52
	ld bc, $0040 ; $0b55
	add hl, bc ; $0b58
	add hl, hl ; $0b59
	pop bc ; $0b5a
	ret ; $0b5b
QuarterSineTable:
	; $0b5c, 65 bytes (bytes:16)
	db $00, $03, $06, $09, $0d, $10, $13, $16, $19, $1c, $1f, $22, $25, $28, $2b, $2e ; 0x00
	db $31, $34, $37, $3a, $3c, $3f, $42, $45, $47, $4a, $4c, $4f, $51, $54, $56, $58 ; 0x10
	db $5b, $5d, $5f, $61, $63, $65, $67, $69, $6b, $6c, $6e, $6f, $71, $72, $74, $75 ; 0x20
	db $76, $77, $79, $7a, $7b, $7b, $7c, $7d, $7e, $7e, $7f, $7f, $7f, $80, $80, $80 ; 0x30
	db $80 ; 0x40
MulHLByASignedFull:
	bit 7, h ; $0b9d
	jp z, MulHLByA ; $0b9f
	push af ; $0ba2
	xor a, a ; $0ba3
	sub a, l ; $0ba4
	ld l, a ; $0ba5
	sbc a, a ; $0ba6
	sub a, h ; $0ba7
	ld h, a ; $0ba8
	pop af ; $0ba9
	call MulHLByA ; $0baa
	push af ; $0bad
	xor a, a ; $0bae
	sub a, l ; $0baf
	ld l, a ; $0bb0
	sbc a, a ; $0bb1
	sub a, h ; $0bb2
	ld h, a ; $0bb3
	pop af ; $0bb4
	ret ; $0bb5
MulHLByAFracSigned:
	bit 7, h ; $0bb6
	jr z, MulHLByAFrac ; $0bb8
	push de ; $0bba
	ld d, a ; $0bbb
	xor a, a ; $0bbc
	sub a, l ; $0bbd
	ld l, a ; $0bbe
	sbc a, a ; $0bbf
	sub a, h ; $0bc0
	ld h, a ; $0bc1
	ld a, d ; $0bc2
	call MulHLByAFrac ; $0bc3
	ld d, a ; $0bc6
	xor a, a ; $0bc7
	sub a, l ; $0bc8
	ld l, a ; $0bc9
	sbc a, a ; $0bca
	sub a, h ; $0bcb
	ld h, a ; $0bcc
	ld a, d ; $0bcd
	pop de ; $0bce
	ret ; $0bcf
Label_00_0bd0:
	ld hl, $0000 ; $0bd0
	ret ; $0bd3
MulHLByAFrac:
	or a, a ; $0bd4
	jr z, Label_00_0bd0 ; $0bd5
	push de ; $0bd7
	ld e, l ; $0bd8
	ld d, h ; $0bd9
	rra ; $0bda
	jr c, Label_00_0c09 ; $0bdb
	rra ; $0bdd
	jr c, Label_00_0bf1 ; $0bde
	rra ; $0be0
	jr c, Label_00_0bf5 ; $0be1
	rra ; $0be3
	jr c, Label_00_0bf9 ; $0be4
	rra ; $0be6
	jr c, Label_00_0bfd ; $0be7
	rra ; $0be9
	jr c, Label_00_0c01 ; $0bea
	rra ; $0bec
	jr c, Label_00_0c05 ; $0bed
	jr Label_00_0c41 ; $0bef
Label_00_0bf1:
	srl h ; $0bf1
	jr Label_00_0c13 ; $0bf3
Label_00_0bf5:
	srl h ; $0bf5
	jr Label_00_0c1b ; $0bf7
Label_00_0bf9:
	srl h ; $0bf9
	jr Label_00_0c23 ; $0bfb
Label_00_0bfd:
	srl h ; $0bfd
	jr Label_00_0c2b ; $0bff
Label_00_0c01:
	srl h ; $0c01
	jr Label_00_0c33 ; $0c03
Label_00_0c05:
	srl h ; $0c05
	jr Label_00_0c3b ; $0c07
Label_00_0c09:
	srl h ; $0c09
	rr l ; $0c0b
	rra ; $0c0d
	jr nc, Label_00_0c11 ; $0c0e
	add hl, de ; $0c10
Label_00_0c11:
	rr h ; $0c11
Label_00_0c13:
	rr l ; $0c13
	rra ; $0c15
	jr nc, Label_00_0c19 ; $0c16
	add hl, de ; $0c18
Label_00_0c19:
	rr h ; $0c19
Label_00_0c1b:
	rr l ; $0c1b
	rra ; $0c1d
	jr nc, Label_00_0c21 ; $0c1e
	add hl, de ; $0c20
Label_00_0c21:
	rr h ; $0c21
Label_00_0c23:
	rr l ; $0c23
	rra ; $0c25
	jr nc, Label_00_0c29 ; $0c26
	add hl, de ; $0c28
Label_00_0c29:
	rr h ; $0c29
Label_00_0c2b:
	rr l ; $0c2b
	rra ; $0c2d
	jr nc, Label_00_0c31 ; $0c2e
	add hl, de ; $0c30
Label_00_0c31:
	rr h ; $0c31
Label_00_0c33:
	rr l ; $0c33
	rra ; $0c35
	jr nc, Label_00_0c39 ; $0c36
	add hl, de ; $0c38
Label_00_0c39:
	rr h ; $0c39
Label_00_0c3b:
	rr l ; $0c3b
	rra ; $0c3d
	jr nc, Label_00_0c41 ; $0c3e
	add hl, de ; $0c40
Label_00_0c41:
	rr h ; $0c41
	rr l ; $0c43
	rra ; $0c45
	pop de ; $0c46
	ret ; $0c47
MulHLByDESigned:
	bit 7, h ; $0c48
	jr z, MulHLByDE ; $0c4a
	push af ; $0c4c
	ld a, l ; $0c4d
	cpl ; $0c4e
	add a, $01 ; $0c4f
	ld l, a ; $0c51
	ld a, h ; $0c52
	sbc a, $00 ; $0c53
	cpl ; $0c55
	ld h, a ; $0c56
	pop af ; $0c57
	call MulHLByDE ; $0c58
	push af ; $0c5b
	ld a, l ; $0c5c
	cpl ; $0c5d
	add a, $01 ; $0c5e
	ld l, a ; $0c60
	ld a, h ; $0c61
	sbc a, $00 ; $0c62
	cpl ; $0c64
	ld h, a ; $0c65
	pop af ; $0c66
	ret ; $0c67
	ld a, h ; $0c68
	xor a, d ; $0c69
	ldh [hMathSign], a ; $0c6a
	bit 7, h ; $0c6c
	jr z, Label_00_0c76 ; $0c6e
	xor a, a ; $0c70
	sub a, l ; $0c71
	ld l, a ; $0c72
	sbc a, a ; $0c73
	sub a, h ; $0c74
	ld h, a ; $0c75
Label_00_0c76:
	bit 7, d ; $0c76
	jr z, Label_00_0c80 ; $0c78
	xor a, a ; $0c7a
	sub a, e ; $0c7b
	ld e, a ; $0c7c
	sbc a, a ; $0c7d
	sub a, d ; $0c7e
	ld d, a ; $0c7f
Label_00_0c80:
	call MulHLByDE ; $0c80
	ldh a, [hMathSign] ; $0c83
	bit 7, a ; $0c85
	ret z ; $0c87
	xor a, a ; $0c88
	sub a, l ; $0c89
	ld l, a ; $0c8a
	sbc a, a ; $0c8b
	sub a, h ; $0c8c
	ld h, a ; $0c8d
	ret ; $0c8e
MulHLByDE:
	push de ; $0c8f
	push bc ; $0c90
	ld c, d ; $0c91
	ld a, e ; $0c92
	ld b, $00 ; $0c93
	push hl ; $0c95
	add a, a ; $0c96
	jr c, Label_00_0cb7 ; $0c97
	jr z, Label_00_0cb2 ; $0c99
	ld e, l ; $0c9b
	ld d, h ; $0c9c
	add a, a ; $0c9d
	jr c, Label_00_0cbf ; $0c9e
	add a, a ; $0ca0
	jr c, Label_00_0cc5 ; $0ca1
	add a, a ; $0ca3
	jr c, Label_00_0ccb ; $0ca4
	add a, a ; $0ca6
	jr c, Label_00_0cd1 ; $0ca7
	add a, a ; $0ca9
	jr c, Label_00_0cd7 ; $0caa
	add a, a ; $0cac
	jr c, Label_00_0cdd ; $0cad
	xor a, a ; $0caf
	jr Label_00_0ce3 ; $0cb0
Label_00_0cb2:
	ld hl, $0000 ; $0cb2
	jr Label_00_0ce3 ; $0cb5
Label_00_0cb7:
	ld e, l ; $0cb7
	ld d, h ; $0cb8
	add hl, hl ; $0cb9
	adc a, a ; $0cba
	jr nc, Label_00_0cbf ; $0cbb
	add hl, de ; $0cbd
	adc a, b ; $0cbe
Label_00_0cbf:
	add hl, hl ; $0cbf
	adc a, a ; $0cc0
	jr nc, Label_00_0cc5 ; $0cc1
	add hl, de ; $0cc3
	adc a, b ; $0cc4
Label_00_0cc5:
	add hl, hl ; $0cc5
	adc a, a ; $0cc6
	jr nc, Label_00_0ccb ; $0cc7
	add hl, de ; $0cc9
	adc a, b ; $0cca
Label_00_0ccb:
	add hl, hl ; $0ccb
	adc a, a ; $0ccc
	jr nc, Label_00_0cd1 ; $0ccd
	add hl, de ; $0ccf
	adc a, b ; $0cd0
Label_00_0cd1:
	add hl, hl ; $0cd1
	adc a, a ; $0cd2
	jr nc, Label_00_0cd7 ; $0cd3
	add hl, de ; $0cd5
	adc a, b ; $0cd6
Label_00_0cd7:
	add hl, hl ; $0cd7
	adc a, a ; $0cd8
	jr nc, Label_00_0cdd ; $0cd9
	add hl, de ; $0cdb
	adc a, b ; $0cdc
Label_00_0cdd:
	add hl, hl ; $0cdd
	adc a, a ; $0cde
	jr nc, Label_00_0ce3 ; $0cdf
	add hl, de ; $0ce1
	adc a, b ; $0ce2
Label_00_0ce3:
	ld e, h ; $0ce3
	ld d, a ; $0ce4
	ld a, c ; $0ce5
	ld c, l ; $0ce6
	pop hl ; $0ce7
	push de ; $0ce8
	add a, a ; $0ce9
	jr c, Label_00_0d0a ; $0cea
	jr z, Label_00_0d05 ; $0cec
	ld e, l ; $0cee
	ld d, h ; $0cef
	add a, a ; $0cf0
	jr c, Label_00_0d12 ; $0cf1
	add a, a ; $0cf3
	jr c, Label_00_0d18 ; $0cf4
	add a, a ; $0cf6
	jr c, Label_00_0d1e ; $0cf7
	add a, a ; $0cf9
	jr c, Label_00_0d24 ; $0cfa
	add a, a ; $0cfc
	jr c, Label_00_0d2a ; $0cfd
	add a, a ; $0cff
	jr c, Label_00_0d30 ; $0d00
	xor a, a ; $0d02
	jr Label_00_0d36 ; $0d03
Label_00_0d05:
	ld hl, $0000 ; $0d05
	jr Label_00_0d36 ; $0d08
Label_00_0d0a:
	ld e, l ; $0d0a
	ld d, h ; $0d0b
	add hl, hl ; $0d0c
	adc a, a ; $0d0d
	jr nc, Label_00_0d12 ; $0d0e
	add hl, de ; $0d10
	adc a, b ; $0d11
Label_00_0d12:
	add hl, hl ; $0d12
	adc a, a ; $0d13
	jr nc, Label_00_0d18 ; $0d14
	add hl, de ; $0d16
	adc a, b ; $0d17
Label_00_0d18:
	add hl, hl ; $0d18
	adc a, a ; $0d19
	jr nc, Label_00_0d1e ; $0d1a
	add hl, de ; $0d1c
	adc a, b ; $0d1d
Label_00_0d1e:
	add hl, hl ; $0d1e
	adc a, a ; $0d1f
	jr nc, Label_00_0d24 ; $0d20
	add hl, de ; $0d22
	adc a, b ; $0d23
Label_00_0d24:
	add hl, hl ; $0d24
	adc a, a ; $0d25
	jr nc, Label_00_0d2a ; $0d26
	add hl, de ; $0d28
	adc a, b ; $0d29
Label_00_0d2a:
	add hl, hl ; $0d2a
	adc a, a ; $0d2b
	jr nc, Label_00_0d30 ; $0d2c
	add hl, de ; $0d2e
	adc a, b ; $0d2f
Label_00_0d30:
	add hl, hl ; $0d30
	adc a, a ; $0d31
	jr nc, Label_00_0d36 ; $0d32
	add hl, de ; $0d34
	adc a, b ; $0d35
Label_00_0d36:
	pop de ; $0d36
	add hl, de ; $0d37
	adc a, b ; $0d38
	ld b, a ; $0d39
	ld a, c ; $0d3a
	ldh [hMulResult], a ; $0d3b
	ld a, l ; $0d3d
	ldh [$ffa9], a ; $0d3e
	ld a, h ; $0d40
	ld l, h ; $0d41
	ldh [$ffaa], a ; $0d42
	ld a, b ; $0d44
	ld h, b ; $0d45
	ldh [$ffab], a ; $0d46
	pop bc ; $0d48
	pop de ; $0d49
	ret ; $0d4a
MulHLByDE32:
	push bc ; $0d4b
	ld c, d ; $0d4c
	ld a, e ; $0d4d
	ld b, $00 ; $0d4e
	push hl ; $0d50
	add a, a ; $0d51
	jr c, Label_00_0d72 ; $0d52
	jr z, Label_00_0d6d ; $0d54
	ld e, l ; $0d56
	ld d, h ; $0d57
	add a, a ; $0d58
	jr c, Label_00_0d7a ; $0d59
	add a, a ; $0d5b
	jr c, Label_00_0d80 ; $0d5c
	add a, a ; $0d5e
	jr c, Label_00_0d86 ; $0d5f
	add a, a ; $0d61
	jr c, Label_00_0d8c ; $0d62
	add a, a ; $0d64
	jr c, Label_00_0d92 ; $0d65
	add a, a ; $0d67
	jr c, Label_00_0d98 ; $0d68
	xor a, a ; $0d6a
	jr Label_00_0d9e ; $0d6b
Label_00_0d6d:
	ld hl, $0000 ; $0d6d
	jr Label_00_0d9e ; $0d70
Label_00_0d72:
	ld e, l ; $0d72
	ld d, h ; $0d73
	add hl, hl ; $0d74
	adc a, a ; $0d75
	jr nc, Label_00_0d7a ; $0d76
	add hl, de ; $0d78
	adc a, b ; $0d79
Label_00_0d7a:
	add hl, hl ; $0d7a
	adc a, a ; $0d7b
	jr nc, Label_00_0d80 ; $0d7c
	add hl, de ; $0d7e
	adc a, b ; $0d7f
Label_00_0d80:
	add hl, hl ; $0d80
	adc a, a ; $0d81
	jr nc, Label_00_0d86 ; $0d82
	add hl, de ; $0d84
	adc a, b ; $0d85
Label_00_0d86:
	add hl, hl ; $0d86
	adc a, a ; $0d87
	jr nc, Label_00_0d8c ; $0d88
	add hl, de ; $0d8a
	adc a, b ; $0d8b
Label_00_0d8c:
	add hl, hl ; $0d8c
	adc a, a ; $0d8d
	jr nc, Label_00_0d92 ; $0d8e
	add hl, de ; $0d90
	adc a, b ; $0d91
Label_00_0d92:
	add hl, hl ; $0d92
	adc a, a ; $0d93
	jr nc, Label_00_0d98 ; $0d94
	add hl, de ; $0d96
	adc a, b ; $0d97
Label_00_0d98:
	add hl, hl ; $0d98
	adc a, a ; $0d99
	jr nc, Label_00_0d9e ; $0d9a
	add hl, de ; $0d9c
	adc a, b ; $0d9d
Label_00_0d9e:
	ld e, h ; $0d9e
	ld d, a ; $0d9f
	ld a, c ; $0da0
	ld c, l ; $0da1
	pop hl ; $0da2
	push de ; $0da3
	add a, a ; $0da4
	jr c, Label_00_0dc5 ; $0da5
	jr z, Label_00_0dc0 ; $0da7
	ld e, l ; $0da9
	ld d, h ; $0daa
	add a, a ; $0dab
	jr c, Label_00_0dcd ; $0dac
	add a, a ; $0dae
	jr c, Label_00_0dd3 ; $0daf
	add a, a ; $0db1
	jr c, Label_00_0dd9 ; $0db2
	add a, a ; $0db4
	jr c, Label_00_0ddf ; $0db5
	add a, a ; $0db7
	jr c, Label_00_0de5 ; $0db8
	add a, a ; $0dba
	jr c, Label_00_0deb ; $0dbb
	xor a, a ; $0dbd
	jr Label_00_0df1 ; $0dbe
Label_00_0dc0:
	ld hl, $0000 ; $0dc0
	jr Label_00_0df1 ; $0dc3
Label_00_0dc5:
	ld e, l ; $0dc5
	ld d, h ; $0dc6
	add hl, hl ; $0dc7
	adc a, a ; $0dc8
	jr nc, Label_00_0dcd ; $0dc9
	add hl, de ; $0dcb
	adc a, b ; $0dcc
Label_00_0dcd:
	add hl, hl ; $0dcd
	adc a, a ; $0dce
	jr nc, Label_00_0dd3 ; $0dcf
	add hl, de ; $0dd1
	adc a, b ; $0dd2
Label_00_0dd3:
	add hl, hl ; $0dd3
	adc a, a ; $0dd4
	jr nc, Label_00_0dd9 ; $0dd5
	add hl, de ; $0dd7
	adc a, b ; $0dd8
Label_00_0dd9:
	add hl, hl ; $0dd9
	adc a, a ; $0dda
	jr nc, Label_00_0ddf ; $0ddb
	add hl, de ; $0ddd
	adc a, b ; $0dde
Label_00_0ddf:
	add hl, hl ; $0ddf
	adc a, a ; $0de0
	jr nc, Label_00_0de5 ; $0de1
	add hl, de ; $0de3
	adc a, b ; $0de4
Label_00_0de5:
	add hl, hl ; $0de5
	adc a, a ; $0de6
	jr nc, Label_00_0deb ; $0de7
	add hl, de ; $0de9
	adc a, b ; $0dea
Label_00_0deb:
	add hl, hl ; $0deb
	adc a, a ; $0dec
	jr nc, Label_00_0df1 ; $0ded
	add hl, de ; $0def
	adc a, b ; $0df0
Label_00_0df1:
	pop de ; $0df1
	add hl, de ; $0df2
	adc a, b ; $0df3
	ld e, c ; $0df4
	ld d, l ; $0df5
	ld l, h ; $0df6
	ld h, a ; $0df7
	pop bc ; $0df8
	ret ; $0df9
MulHLByASigned:
	bit 7, h ; $0dfa
	jr z, Label_00_0e13 ; $0dfc
	call Func_00_0e08 ; $0dfe
	xor a, a ; $0e01
	sub a, l ; $0e02
	ld l, a ; $0e03
	sbc a, a ; $0e04
	sub a, h ; $0e05
	ld h, a ; $0e06
	ret ; $0e07
Func_00_0e08:
	push de ; $0e08
	ld e, a ; $0e09
	xor a, a ; $0e0a
	sub a, l ; $0e0b
	ld l, a ; $0e0c
	sbc a, a ; $0e0d
	sub a, h ; $0e0e
	ld h, a ; $0e0f
	ld a, e ; $0e10
	jr Label_00_0e14 ; $0e11
Label_00_0e13:
	push de ; $0e13
Label_00_0e14:
	add a, a ; $0e14
	jr c, Label_00_0e35 ; $0e15
	jr z, Label_00_0e30 ; $0e17
	ld e, l ; $0e19
	ld d, h ; $0e1a
	add a, a ; $0e1b
	jr c, Label_00_0e3e ; $0e1c
	add a, a ; $0e1e
	jr c, Label_00_0e45 ; $0e1f
	add a, a ; $0e21
	jr c, Label_00_0e4c ; $0e22
	add a, a ; $0e24
	jr c, Label_00_0e53 ; $0e25
	add a, a ; $0e27
	jr c, Label_00_0e5a ; $0e28
	add a, a ; $0e2a
	jr c, Label_00_0e61 ; $0e2b
	xor a, a ; $0e2d
	jr Label_00_0e68 ; $0e2e
Label_00_0e30:
	ld hl, $0000 ; $0e30
	jr Label_00_0e68 ; $0e33
Label_00_0e35:
	ld e, l ; $0e35
	ld d, h ; $0e36
	add hl, hl ; $0e37
	adc a, a ; $0e38
	jr nc, Label_00_0e3e ; $0e39
	add hl, de ; $0e3b
	adc a, $00 ; $0e3c
Label_00_0e3e:
	add hl, hl ; $0e3e
	adc a, a ; $0e3f
	jr nc, Label_00_0e45 ; $0e40
	add hl, de ; $0e42
	adc a, $00 ; $0e43
Label_00_0e45:
	add hl, hl ; $0e45
	adc a, a ; $0e46
	jr nc, Label_00_0e4c ; $0e47
	add hl, de ; $0e49
	adc a, $00 ; $0e4a
Label_00_0e4c:
	add hl, hl ; $0e4c
	adc a, a ; $0e4d
	jr nc, Label_00_0e53 ; $0e4e
	add hl, de ; $0e50
	adc a, $00 ; $0e51
Label_00_0e53:
	add hl, hl ; $0e53
	adc a, a ; $0e54
	jr nc, Label_00_0e5a ; $0e55
	add hl, de ; $0e57
	adc a, $00 ; $0e58
Label_00_0e5a:
	add hl, hl ; $0e5a
	adc a, a ; $0e5b
	jr nc, Label_00_0e61 ; $0e5c
	add hl, de ; $0e5e
	adc a, $00 ; $0e5f
Label_00_0e61:
	add hl, hl ; $0e61
	adc a, a ; $0e62
	jr nc, Label_00_0e68 ; $0e63
	add hl, de ; $0e65
	adc a, $00 ; $0e66
Label_00_0e68:
	ld l, h ; $0e68
	ld h, a ; $0e69
	pop de ; $0e6a
	ret ; $0e6b
DivAHLByDESigned:
	ld b, a ; $0e6c
	xor a, d ; $0e6d
	ldh [hMathSign], a ; $0e6e
	bit 7, d ; $0e70
	jr z, Label_00_0e7a ; $0e72
	xor a, a ; $0e74
	sub a, e ; $0e75
	ld e, a ; $0e76
	sbc a, a ; $0e77
	sub a, d ; $0e78
	ld d, a ; $0e79
Label_00_0e7a:
	ld a, b ; $0e7a
	bit 7, b ; $0e7b
	jr z, Label_00_0e8d ; $0e7d
	ld a, l ; $0e7f
	cpl ; $0e80
	add a, $01 ; $0e81
	ld l, a ; $0e83
	ld a, h ; $0e84
	cpl ; $0e85
	adc a, $00 ; $0e86
	ld h, a ; $0e88
	ld a, b ; $0e89
	cpl ; $0e8a
	adc a, $00 ; $0e8b
Label_00_0e8d:
	call DivAHLByDE ; $0e8d
	ld b, a ; $0e90
	ldh a, [hMathSign] ; $0e91
	bit 7, a ; $0e93
	ld a, b ; $0e95
	ret z ; $0e96
	ld a, l ; $0e97
	cpl ; $0e98
	add a, $01 ; $0e99
	ld l, a ; $0e9b
	ld a, h ; $0e9c
	cpl ; $0e9d
	adc a, $00 ; $0e9e
	ld h, a ; $0ea0
	ld a, b ; $0ea1
	cpl ; $0ea2
	adc a, $00 ; $0ea3
	ret ; $0ea5
DivAHLByDE:
	inc d ; $0ea6
	dec d ; $0ea7
	jr nz, Label_00_0eaf ; $0ea8
	bit 7, e ; $0eaa
	jp z, DivAHLByE ; $0eac
Label_00_0eaf:
	push bc ; $0eaf
	ldh [$ffac], a ; $0eb0
	xor a, a ; $0eb2
	sub a, e ; $0eb3
	ld c, a ; $0eb4
	sbc a, a ; $0eb5
	sub a, d ; $0eb6
	ld b, a ; $0eb7
	or a, c ; $0eb8
	jr nz, Label_00_0ec1 ; $0eb9
	ld a, $ff ; $0ebb
	ld h, a ; $0ebd
	ld l, a ; $0ebe
	pop bc ; $0ebf
	ret ; $0ec0
Label_00_0ec1:
	ld a, l ; $0ec1
	push af ; $0ec2
	ldh a, [$ffac] ; $0ec3
	push hl ; $0ec5
	scf ; $0ec6
	ld hl, $0000 ; $0ec7
	adc a, a ; $0eca
	rl l ; $0ecb
	add hl, bc ; $0ecd
	jr c, Label_00_0ed2 ; $0ece
	dec a ; $0ed0
	add hl, de ; $0ed1
Label_00_0ed2:
	adc a, a ; $0ed2
	rl l ; $0ed3
	add hl, bc ; $0ed5
	jr c, Label_00_0eda ; $0ed6
	dec a ; $0ed8
	add hl, de ; $0ed9
Label_00_0eda:
	adc a, a ; $0eda
	rl l ; $0edb
	add hl, bc ; $0edd
	jr c, Label_00_0ee2 ; $0ede
	dec a ; $0ee0
	add hl, de ; $0ee1
Label_00_0ee2:
	adc a, a ; $0ee2
	rl l ; $0ee3
	add hl, bc ; $0ee5
	jr c, Label_00_0eea ; $0ee6
	dec a ; $0ee8
	add hl, de ; $0ee9
Label_00_0eea:
	adc a, a ; $0eea
	rl l ; $0eeb
	add hl, bc ; $0eed
	jr c, Label_00_0ef2 ; $0eee
	dec a ; $0ef0
	add hl, de ; $0ef1
Label_00_0ef2:
	adc a, a ; $0ef2
	rl l ; $0ef3
	add hl, bc ; $0ef5
	jr c, Label_00_0efa ; $0ef6
	dec a ; $0ef8
	add hl, de ; $0ef9
Label_00_0efa:
	adc a, a ; $0efa
	rl l ; $0efb
	add hl, bc ; $0efd
	jr c, Label_00_0f02 ; $0efe
	dec a ; $0f00
	add hl, de ; $0f01
Label_00_0f02:
	adc a, a ; $0f02
	rl l ; $0f03
	add hl, bc ; $0f05
	jr c, Label_00_0f0a ; $0f06
	dec a ; $0f08
	add hl, de ; $0f09
Label_00_0f0a:
	ldh [$ffae], a ; $0f0a
	pop af ; $0f0c
	ld h, $00 ; $0f0d
	scf ; $0f0f
	adc a, a ; $0f10
	rl l ; $0f11
	rl h ; $0f13
	add hl, bc ; $0f15
	jr c, Label_00_0f1a ; $0f16
	dec a ; $0f18
	add hl, de ; $0f19
Label_00_0f1a:
	adc a, a ; $0f1a
	rl l ; $0f1b
	rl h ; $0f1d
	add hl, bc ; $0f1f
	jr c, Label_00_0f24 ; $0f20
	dec a ; $0f22
	add hl, de ; $0f23
Label_00_0f24:
	adc a, a ; $0f24
	rl l ; $0f25
	rl h ; $0f27
	add hl, bc ; $0f29
	jr c, Label_00_0f2e ; $0f2a
	dec a ; $0f2c
	add hl, de ; $0f2d
Label_00_0f2e:
	adc a, a ; $0f2e
	rl l ; $0f2f
	rl h ; $0f31
	add hl, bc ; $0f33
	jr c, Label_00_0f38 ; $0f34
	dec a ; $0f36
	add hl, de ; $0f37
Label_00_0f38:
	adc a, a ; $0f38
	rl l ; $0f39
	rl h ; $0f3b
	add hl, bc ; $0f3d
	jr c, Label_00_0f42 ; $0f3e
	dec a ; $0f40
	add hl, de ; $0f41
Label_00_0f42:
	adc a, a ; $0f42
	rl l ; $0f43
	rl h ; $0f45
	add hl, bc ; $0f47
	jr c, Label_00_0f4c ; $0f48
	dec a ; $0f4a
	add hl, de ; $0f4b
Label_00_0f4c:
	adc a, a ; $0f4c
	rl l ; $0f4d
	rl h ; $0f4f
	add hl, bc ; $0f51
	jr c, Label_00_0f56 ; $0f52
	dec a ; $0f54
	add hl, de ; $0f55
Label_00_0f56:
	adc a, a ; $0f56
	rl l ; $0f57
	rl h ; $0f59
	add hl, bc ; $0f5b
	jr c, Label_00_0f60 ; $0f5c
	dec a ; $0f5e
	add hl, de ; $0f5f
Label_00_0f60:
	ldh [$ffad], a ; $0f60
	pop af ; $0f62
	scf ; $0f63
	adc a, a ; $0f64
	rl l ; $0f65
	rl h ; $0f67
	add hl, bc ; $0f69
	jr c, Label_00_0f6e ; $0f6a
	dec a ; $0f6c
	add hl, de ; $0f6d
Label_00_0f6e:
	adc a, a ; $0f6e
	rl l ; $0f6f
	rl h ; $0f71
	add hl, bc ; $0f73
	jr c, Label_00_0f78 ; $0f74
	dec a ; $0f76
	add hl, de ; $0f77
Label_00_0f78:
	adc a, a ; $0f78
	rl l ; $0f79
	rl h ; $0f7b
	add hl, bc ; $0f7d
	jr c, Label_00_0f82 ; $0f7e
	dec a ; $0f80
	add hl, de ; $0f81
Label_00_0f82:
	adc a, a ; $0f82
	rl l ; $0f83
	rl h ; $0f85
	add hl, bc ; $0f87
	jr c, Label_00_0f8c ; $0f88
	dec a ; $0f8a
	add hl, de ; $0f8b
Label_00_0f8c:
	adc a, a ; $0f8c
	rl l ; $0f8d
	rl h ; $0f8f
	add hl, bc ; $0f91
	jr c, Label_00_0f96 ; $0f92
	dec a ; $0f94
	add hl, de ; $0f95
Label_00_0f96:
	adc a, a ; $0f96
	rl l ; $0f97
	rl h ; $0f99
	add hl, bc ; $0f9b
	jr c, Label_00_0fa0 ; $0f9c
	dec a ; $0f9e
	add hl, de ; $0f9f
Label_00_0fa0:
	adc a, a ; $0fa0
	rl l ; $0fa1
	rl h ; $0fa3
	add hl, bc ; $0fa5
	jr c, Label_00_0faa ; $0fa6
	dec a ; $0fa8
	add hl, de ; $0fa9
Label_00_0faa:
	adc a, a ; $0faa
	rl l ; $0fab
	rl h ; $0fad
	add hl, bc ; $0faf
	jr c, Label_00_0fb4 ; $0fb0
	dec a ; $0fb2
	add hl, de ; $0fb3
Label_00_0fb4:
	ld l, a ; $0fb4
	ldh a, [$ffad] ; $0fb5
	ld h, a ; $0fb7
	ldh a, [$ffae] ; $0fb8
	pop bc ; $0fba
	ret ; $0fbb
DivAHLByE:
	push bc ; $0fbc
	ld c, l ; $0fbd
	ld l, h ; $0fbe
	ld h, a ; $0fbf
	xor a, a ; $0fc0
	add hl, hl ; $0fc1
	adc a, a ; $0fc2
	cp a, e ; $0fc3
	jr c, Label_00_0fc8 ; $0fc4
	inc l ; $0fc6
	sub a, e ; $0fc7
Label_00_0fc8:
	add hl, hl ; $0fc8
	adc a, a ; $0fc9
	cp a, e ; $0fca
	jr c, Label_00_0fcf ; $0fcb
	inc l ; $0fcd
	sub a, e ; $0fce
Label_00_0fcf:
	add hl, hl ; $0fcf
	adc a, a ; $0fd0
	cp a, e ; $0fd1
	jr c, Label_00_0fd6 ; $0fd2
	inc l ; $0fd4
	sub a, e ; $0fd5
Label_00_0fd6:
	add hl, hl ; $0fd6
	adc a, a ; $0fd7
	cp a, e ; $0fd8
	jr c, Label_00_0fdd ; $0fd9
	inc l ; $0fdb
	sub a, e ; $0fdc
Label_00_0fdd:
	add hl, hl ; $0fdd
	adc a, a ; $0fde
	cp a, e ; $0fdf
	jr c, Label_00_0fe4 ; $0fe0
	inc l ; $0fe2
	sub a, e ; $0fe3
Label_00_0fe4:
	add hl, hl ; $0fe4
	adc a, a ; $0fe5
	cp a, e ; $0fe6
	jr c, Label_00_0feb ; $0fe7
	inc l ; $0fe9
	sub a, e ; $0fea
Label_00_0feb:
	add hl, hl ; $0feb
	adc a, a ; $0fec
	cp a, e ; $0fed
	jr c, Label_00_0ff2 ; $0fee
	inc l ; $0ff0
	sub a, e ; $0ff1
Label_00_0ff2:
	add hl, hl ; $0ff2
	adc a, a ; $0ff3
	cp a, e ; $0ff4
	jr c, Label_00_0ff9 ; $0ff5
	inc l ; $0ff7
	sub a, e ; $0ff8
Label_00_0ff9:
	ld b, l ; $0ff9
	add hl, hl ; $0ffa
	adc a, a ; $0ffb
	cp a, e ; $0ffc
	jr c, Label_00_1001 ; $0ffd
	inc l ; $0fff
	sub a, e ; $1000
Label_00_1001:
	add hl, hl ; $1001
	adc a, a ; $1002
	cp a, e ; $1003
	jr c, Label_00_1008 ; $1004
	inc l ; $1006
	sub a, e ; $1007
Label_00_1008:
	add hl, hl ; $1008
	adc a, a ; $1009
	cp a, e ; $100a
	jr c, Label_00_100f ; $100b
	inc l ; $100d
	sub a, e ; $100e
Label_00_100f:
	add hl, hl ; $100f
	adc a, a ; $1010
	cp a, e ; $1011
	jr c, Label_00_1016 ; $1012
	inc l ; $1014
	sub a, e ; $1015
Label_00_1016:
	add hl, hl ; $1016
	adc a, a ; $1017
	cp a, e ; $1018
	jr c, Label_00_101d ; $1019
	inc l ; $101b
	sub a, e ; $101c
Label_00_101d:
	add hl, hl ; $101d
	adc a, a ; $101e
	cp a, e ; $101f
	jr c, Label_00_1024 ; $1020
	inc l ; $1022
	sub a, e ; $1023
Label_00_1024:
	add hl, hl ; $1024
	adc a, a ; $1025
	cp a, e ; $1026
	jr c, Label_00_102b ; $1027
	inc l ; $1029
	sub a, e ; $102a
Label_00_102b:
	add hl, hl ; $102b
	adc a, a ; $102c
	cp a, e ; $102d
	jr c, Label_00_1032 ; $102e
	inc l ; $1030
	sub a, e ; $1031
Label_00_1032:
	ld h, c ; $1032
	add hl, hl ; $1033
	adc a, a ; $1034
	cp a, e ; $1035
	jr c, Label_00_103a ; $1036
	inc l ; $1038
	sub a, e ; $1039
Label_00_103a:
	add hl, hl ; $103a
	adc a, a ; $103b
	cp a, e ; $103c
	jr c, Label_00_1041 ; $103d
	inc l ; $103f
	sub a, e ; $1040
Label_00_1041:
	add hl, hl ; $1041
	adc a, a ; $1042
	cp a, e ; $1043
	jr c, Label_00_1048 ; $1044
	inc l ; $1046
	sub a, e ; $1047
Label_00_1048:
	add hl, hl ; $1048
	adc a, a ; $1049
	cp a, e ; $104a
	jr c, Label_00_104f ; $104b
	inc l ; $104d
	sub a, e ; $104e
Label_00_104f:
	add hl, hl ; $104f
	adc a, a ; $1050
	cp a, e ; $1051
	jr c, Label_00_1056 ; $1052
	inc l ; $1054
	sub a, e ; $1055
Label_00_1056:
	add hl, hl ; $1056
	adc a, a ; $1057
	cp a, e ; $1058
	jr c, Label_00_105d ; $1059
	inc l ; $105b
	sub a, e ; $105c
Label_00_105d:
	add hl, hl ; $105d
	adc a, a ; $105e
	cp a, e ; $105f
	jr c, Label_00_1064 ; $1060
	inc l ; $1062
	sub a, e ; $1063
Label_00_1064:
	add hl, hl ; $1064
	adc a, a ; $1065
	cp a, e ; $1066
	jr c, Label_00_106b ; $1067
	inc l ; $1069
	sub a, e ; $106a
Label_00_106b:
	ld a, b ; $106b
	pop bc ; $106c
	ret ; $106d
GetSquareOfByte:
	push af ; $106e
	add a, a ; $106f
	jr c, Label_00_107e ; $1070
	add a, $30 ; $1072
	ld l, a ; $1074
	adc a, $11 ; $1075
	sub a, l ; $1077
	ld h, a ; $1078
	ld a, [hl+] ; $1079
	ld h, [hl] ; $107a
	ld l, a ; $107b
	pop af ; $107c
	ret ; $107d
Label_00_107e:
	add a, $30 ; $107e
	ld l, a ; $1080
	adc a, $12 ; $1081
	sub a, l ; $1083
	ld h, a ; $1084
	ld a, [hl+] ; $1085
	ld h, [hl] ; $1086
	ld l, a ; $1087
	pop af ; $1088
	ret ; $1089
AngleFromVector:
	push bc ; $108a
	push de ; $108b
	push hl ; $108c
	ld a, l ; $108d
	cpl ; $108e
	ld c, a ; $108f
	ld a, h ; $1090
	cpl ; $1091
	ld b, a ; $1092
	and a, c ; $1093
	inc a ; $1094
	jp z, Label_00_112b ; $1095
	ld de, $4000 ; $1098
	ld h, e ; $109b
	ld a, d ; $109c
	add a, b ; $109d
	jr c, Label_00_10a7 ; $109e
	ld b, a ; $10a0
	set 7, h ; $10a1
	ld a, $60 ; $10a3
	jr Label_00_10a9 ; $10a5
Label_00_10a7:
	ld a, $e0 ; $10a7
Label_00_10a9:
	add a, d ; $10a9
	srl a ; $10aa
	ld d, a ; $10ac
	add a, b ; $10ad
	jr c, Label_00_10b7 ; $10ae
	ld b, a ; $10b0
	set 6, h ; $10b1
	ld a, $18 ; $10b3
	jr Label_00_10b9 ; $10b5
Label_00_10b7:
	ld a, $f8 ; $10b7
Label_00_10b9:
	add a, d ; $10b9
	srl a ; $10ba
	ld d, a ; $10bc
	add a, b ; $10bd
	jr c, Label_00_10c7 ; $10be
	ld b, a ; $10c0
	set 5, h ; $10c1
	ld a, $06 ; $10c3
	jr Label_00_10c9 ; $10c5
Label_00_10c7:
	ld a, $fe ; $10c7
Label_00_10c9:
	add a, d ; $10c9
	srl a ; $10ca
	ld d, a ; $10cc
	ld a, h ; $10cd
	ld l, e ; $10ce
	ld h, d ; $10cf
	add hl, bc ; $10d0
	jr c, Label_00_10dc ; $10d1
	ld c, l ; $10d3
	ld b, h ; $10d4
	set 4, a ; $10d5
	ld hl, $0180 ; $10d7
	jr Label_00_10df ; $10da
Label_00_10dc:
	ld hl, $ff80 ; $10dc
Label_00_10df:
	add hl, de ; $10df
	srl h ; $10e0
	rr l ; $10e2
	ld e, l ; $10e4
	ld d, h ; $10e5
	add hl, bc ; $10e6
	jr c, Label_00_10f2 ; $10e7
	ld c, l ; $10e9
	ld b, h ; $10ea
	set 3, a ; $10eb
	ld hl, $0060 ; $10ed
	jr Label_00_10f5 ; $10f0
Label_00_10f2:
	ld hl, $ffe0 ; $10f2
Label_00_10f5:
	add hl, de ; $10f5
	srl h ; $10f6
	rr l ; $10f8
	ld e, l ; $10fa
	ld d, h ; $10fb
	add hl, bc ; $10fc
	jr c, Label_00_1108 ; $10fd
	ld c, l ; $10ff
	ld b, h ; $1100
	set 2, a ; $1101
	ld hl, $0018 ; $1103
	jr Label_00_110b ; $1106
Label_00_1108:
	ld hl, $fff8 ; $1108
Label_00_110b:
	add hl, de ; $110b
	srl h ; $110c
	rr l ; $110e
	ld e, l ; $1110
	ld d, h ; $1111
	add hl, bc ; $1112
	jr c, Label_00_111e ; $1113
	ld c, l ; $1115
	ld b, h ; $1116
	set 1, a ; $1117
	ld hl, $0006 ; $1119
	jr Label_00_1121 ; $111c
Label_00_111e:
	ld hl, hIsCGB ; $111e
Label_00_1121:
	add hl, de ; $1121
	srl h ; $1122
	rr l ; $1124
	ld e, l ; $1126
	ld d, h ; $1127
	add hl, bc ; $1128
	sbc a, $ff ; $1129
Label_00_112b:
	pop hl ; $112b
	pop de ; $112c
	pop bc ; $112d
	ret ; $112e
	db $00 ; $112f
SquaresTable:
	; $1130, 514 bytes (squares)
FOR i, 256
	dw (i * i) & $ffff
ENDR
	dw $ffff
MulSinCosSigned:
	bit 7, h ; $1332
	jr z, MulSinCos ; $1334
	xor a, a ; $1336
	sub a, l ; $1337
	ld l, a ; $1338
	sbc a, a ; $1339
	sub a, h ; $133a
	ld h, a ; $133b
	ld a, $80 ; $133c
	add a, b ; $133e
	ld b, a ; $133f
MulSinCos:
	ld a, c ; $1340
	and a, $f0 ; $1341
	ld c, a ; $1343
	push bc ; $1344
	push hl ; $1345
	call MulSin ; $1346
	ld e, l ; $1349
	ld d, h ; $134a
	pop hl ; $134b
	pop bc ; $134c
	ld a, b ; $134d
	add a, $40 ; $134e
	ld b, a ; $1350
MulSin:
	bit 7, b ; $1351
	jr z, MulSinUnsigned ; $1353
	res 7, b ; $1355
	call MulSinUnsigned ; $1357
	xor a, a ; $135a
	sub a, l ; $135b
	ld l, a ; $135c
	sbc a, a ; $135d
	sub a, h ; $135e
	ld h, a ; $135f
	ret ; $1360
MulSinUnsigned:
	push de ; $1361
	add hl, hl ; $1362
	ld e, l ; $1363
	ld d, h ; $1364
	ld h, b ; $1365
	ld a, c ; $1366
	srl h ; $1367
	rra ; $1369
	srl h ; $136a
	rra ; $136c
	srl h ; $136d
	rra ; $136f
	res 0, a ; $1370
	ld l, a ; $1372
	ld a, h ; $1373
	add a, $40 ; $1374
	ld h, a ; $1376
	ldh a, [hRomBank] ; $1377
	ld b, a ; $1379
	ld a, $2d ; $137a
	ldh [hRomBank], a ; $137c
	ld [$2000], a ; $137e
	ld a, [hl+] ; $1381
	ld h, [hl] ; $1382
	ld l, a ; $1383
	call MulHLByDE32 ; $1384
	ld a, b ; $1387
	ldh [hRomBank], a ; $1388
	ld [$2000], a ; $138a
	pop de ; $138d
	ret ; $138e
VectorLengthFromAngle:
	ld a, b ; $138f
	and a, $7f ; $1390
	sub a, $20 ; $1392
	cp a, $40 ; $1394
	jr c, Label_00_13b0 ; $1396
	bit 7, h ; $1398
	jr z, Label_00_13a2 ; $139a
	xor a, a ; $139c
	sub a, l ; $139d
	ld l, a ; $139e
	sbc a, a ; $139f
	sub a, h ; $13a0
	ld h, a ; $13a1
Label_00_13a2:
	call DivByCos ; $13a2
	bit 7, h ; $13a5
	jr z, Label_00_13af ; $13a7
	xor a, a ; $13a9
	sub a, l ; $13aa
	ld l, a ; $13ab
	sbc a, a ; $13ac
	sub a, h ; $13ad
	ld h, a ; $13ae
Label_00_13af:
	ret ; $13af
Label_00_13b0:
	ld l, e ; $13b0
	ld h, d ; $13b1
	bit 7, h ; $13b2
	jr z, Label_00_13bc ; $13b4
	xor a, a ; $13b6
	sub a, l ; $13b7
	ld l, a ; $13b8
	sbc a, a ; $13b9
	sub a, h ; $13ba
	ld h, a ; $13bb
Label_00_13bc:
	call DivBySin ; $13bc
	bit 7, h ; $13bf
	jr z, Label_00_13c9 ; $13c1
	xor a, a ; $13c3
	sub a, l ; $13c4
	ld l, a ; $13c5
	sbc a, a ; $13c6
	sub a, h ; $13c7
	ld h, a ; $13c8
Label_00_13c9:
	ret ; $13c9
DivByCos:
	ld a, b ; $13ca
	add a, $40 ; $13cb
	ld b, a ; $13cd
DivBySin:
	bit 7, b ; $13ce
	jr z, DivBySinUnsigned ; $13d0
	res 7, b ; $13d2
	call DivBySinUnsigned ; $13d4
	xor a, a ; $13d7
	sub a, l ; $13d8
	ld l, a ; $13d9
	sbc a, a ; $13da
	sub a, h ; $13db
	ld h, a ; $13dc
	ret ; $13dd
DivBySinUnsigned:
	push de ; $13de
	ld e, l ; $13df
	ld d, h ; $13e0
	ld h, b ; $13e1
	ld a, c ; $13e2
	srl h ; $13e3
	rra ; $13e5
	srl h ; $13e6
	rra ; $13e8
	srl h ; $13e9
	rra ; $13eb
	res 0, a ; $13ec
	ld l, a ; $13ee
	ld a, h ; $13ef
	add a, $50 ; $13f0
	ld h, a ; $13f2
	ldh a, [hRomBank] ; $13f3
	ld b, a ; $13f5
	ld a, $2d ; $13f6
	ldh [hRomBank], a ; $13f8
	ld [$2000], a ; $13fa
	ld a, [hl+] ; $13fd
	ld h, [hl] ; $13fe
	ld l, a ; $13ff
	call MulHLByDE32 ; $1400
	ld a, d ; $1403
	add a, a ; $1404
	rl l ; $1405
	rl h ; $1407
	add a, a ; $1409
	rl l ; $140a
	rl h ; $140c
	ld a, b ; $140e
	ldh [hRomBank], a ; $140f
	ld [$2000], a ; $1411
	pop de ; $1414
	ret ; $1415
AngleFromVector16:
	ld bc, $0000 ; $1416
	ld a, h ; $1419
	or a, l ; $141a
	jp z, Label_00_154f ; $141b
	ld b, $40 ; $141e
	ld a, d ; $1420
	or a, e ; $1421
	jp z, Label_00_154f ; $1422
	push hl ; $1425
	push de ; $1426
	bit 7, d ; $1427
	jr z, Label_00_1431 ; $1429
	xor a, a ; $142b
	sub a, e ; $142c
	ld e, a ; $142d
	sbc a, a ; $142e
	sub a, d ; $142f
	ld d, a ; $1430
Label_00_1431:
	bit 7, h ; $1431
	jr z, Label_00_143b ; $1433
	xor a, a ; $1435
	sub a, l ; $1436
	ld l, a ; $1437
	sbc a, a ; $1438
	sub a, h ; $1439
	ld h, a ; $143a
Label_00_143b:
	ld a, h ; $143b
	ld h, l ; $143c
	ld l, $00 ; $143d
	call DivAHLByDE ; $143f
	ld bc, $3fc0 ; $1442
	or a, a ; $1445
	jp nz, Label_00_154d ; $1446
	ld e, l ; $1449
	ld d, h ; $144a
	ld hl, $1663 ; $144b
	ld b, $00 ; $144e
	ld a, [hl+] ; $1450
	ld c, a ; $1451
	ld a, [hl-] ; $1452
	cp a, d ; $1453
	jr c, Label_00_1465 ; $1454
	jr nz, Label_00_145c ; $1456
	ld a, c ; $1458
	cp a, e ; $1459
	jr c, Label_00_1465 ; $145a
Label_00_145c:
	ld a, l ; $145c
	sub a, $80 ; $145d
	ld l, a ; $145f
	jr nc, Label_00_1463 ; $1460
	dec h ; $1462
Label_00_1463:
	jr Label_00_146e ; $1463
Label_00_1465:
	ld a, $80 ; $1465
	add a, l ; $1467
	ld l, a ; $1468
	jr nc, Label_00_146c ; $1469
	inc h ; $146b
Label_00_146c:
	set 7, b ; $146c
Label_00_146e:
	ld a, [hl+] ; $146e
	ld c, a ; $146f
	ld a, [hl-] ; $1470
	cp a, d ; $1471
	jr c, Label_00_1483 ; $1472
	jr nz, Label_00_147a ; $1474
	ld a, c ; $1476
	cp a, e ; $1477
	jr c, Label_00_1483 ; $1478
Label_00_147a:
	ld a, l ; $147a
	sub a, $40 ; $147b
	ld l, a ; $147d
	jr nc, Label_00_1481 ; $147e
	dec h ; $1480
Label_00_1481:
	jr Label_00_148c ; $1481
Label_00_1483:
	ld a, $40 ; $1483
	add a, l ; $1485
	ld l, a ; $1486
	jr nc, Label_00_148a ; $1487
	inc h ; $1489
Label_00_148a:
	set 6, b ; $148a
Label_00_148c:
	ld a, [hl+] ; $148c
	ld c, a ; $148d
	ld a, [hl-] ; $148e
	cp a, d ; $148f
	jr c, Label_00_14a1 ; $1490
	jr nz, Label_00_1498 ; $1492
	ld a, c ; $1494
	cp a, e ; $1495
	jr c, Label_00_14a1 ; $1496
Label_00_1498:
	ld a, l ; $1498
	sub a, $20 ; $1499
	ld l, a ; $149b
	jr nc, Label_00_149f ; $149c
	dec h ; $149e
Label_00_149f:
	jr Label_00_14aa ; $149f
Label_00_14a1:
	ld a, $20 ; $14a1
	add a, l ; $14a3
	ld l, a ; $14a4
	jr nc, Label_00_14a8 ; $14a5
	inc h ; $14a7
Label_00_14a8:
	set 5, b ; $14a8
Label_00_14aa:
	ld a, [hl+] ; $14aa
	ld c, a ; $14ab
	ld a, [hl-] ; $14ac
	cp a, d ; $14ad
	jr c, Label_00_14bf ; $14ae
	jr nz, Label_00_14b6 ; $14b0
	ld a, c ; $14b2
	cp a, e ; $14b3
	jr c, Label_00_14bf ; $14b4
Label_00_14b6:
	ld a, l ; $14b6
	sub a, $10 ; $14b7
	ld l, a ; $14b9
	jr nc, Label_00_14bd ; $14ba
	dec h ; $14bc
Label_00_14bd:
	jr Label_00_14c8 ; $14bd
Label_00_14bf:
	ld a, $10 ; $14bf
	add a, l ; $14c1
	ld l, a ; $14c2
	jr nc, Label_00_14c6 ; $14c3
	inc h ; $14c5
Label_00_14c6:
	set 4, b ; $14c6
Label_00_14c8:
	ld a, [hl+] ; $14c8
	ld c, a ; $14c9
	ld a, [hl-] ; $14ca
	cp a, d ; $14cb
	jr c, Label_00_14dd ; $14cc
	jr nz, Label_00_14d4 ; $14ce
	ld a, c ; $14d0
	cp a, e ; $14d1
	jr c, Label_00_14dd ; $14d2
Label_00_14d4:
	ld a, l ; $14d4
	sub a, $08 ; $14d5
	ld l, a ; $14d7
	jr nc, Label_00_14db ; $14d8
	dec h ; $14da
Label_00_14db:
	jr Label_00_14e6 ; $14db
Label_00_14dd:
	ld a, $08 ; $14dd
	add a, l ; $14df
	ld l, a ; $14e0
	jr nc, Label_00_14e4 ; $14e1
	inc h ; $14e3
Label_00_14e4:
	set 3, b ; $14e4
Label_00_14e6:
	ld a, [hl+] ; $14e6
	ld c, a ; $14e7
	ld a, [hl-] ; $14e8
	cp a, d ; $14e9
	jr c, Label_00_14fb ; $14ea
	jr nz, Label_00_14f2 ; $14ec
	ld a, c ; $14ee
	cp a, e ; $14ef
	jr c, Label_00_14fb ; $14f0
Label_00_14f2:
	ld a, l ; $14f2
	sub a, $04 ; $14f3
	ld l, a ; $14f5
	jr nc, Label_00_14f9 ; $14f6
	dec h ; $14f8
Label_00_14f9:
	jr Label_00_1504 ; $14f9
Label_00_14fb:
	ld a, $04 ; $14fb
	add a, l ; $14fd
	ld l, a ; $14fe
	jr nc, Label_00_1502 ; $14ff
	inc h ; $1501
Label_00_1502:
	set 2, b ; $1502
Label_00_1504:
	ld a, [hl+] ; $1504
	ld c, a ; $1505
	ld a, [hl-] ; $1506
	cp a, d ; $1507
	jr c, Label_00_1519 ; $1508
	jr nz, Label_00_1510 ; $150a
	ld a, c ; $150c
	cp a, e ; $150d
	jr c, Label_00_1519 ; $150e
Label_00_1510:
	ld a, l ; $1510
	sub a, $02 ; $1511
	ld l, a ; $1513
	jr nc, Label_00_1517 ; $1514
	dec h ; $1516
Label_00_1517:
	jr Label_00_1522 ; $1517
Label_00_1519:
	ld a, $02 ; $1519
	add a, l ; $151b
	ld l, a ; $151c
	jr nc, Label_00_1520 ; $151d
	inc h ; $151f
Label_00_1520:
	set 1, b ; $1520
Label_00_1522:
	ld a, [hl+] ; $1522
	ld c, a ; $1523
	ld a, [hl+] ; $1524
	cp a, d ; $1525
	jr c, Label_00_152e ; $1526
	jr nz, Label_00_152f ; $1528
	ld a, c ; $152a
	cp a, e ; $152b
	jr nc, Label_00_152f ; $152c
Label_00_152e:
	inc b ; $152e
Label_00_152f:
	ld a, b ; $152f
	inc a ; $1530
	jr nz, Label_00_1544 ; $1531
	ld a, [hl+] ; $1533
	ld c, a ; $1534
	ld a, [hl+] ; $1535
	cp a, d ; $1536
	jr c, Label_00_153f ; $1537
	jr nz, Label_00_1544 ; $1539
	ld a, c ; $153b
	cp a, e ; $153c
	jr nc, Label_00_1544 ; $153d
Label_00_153f:
	ld bc, $4000 ; $153f
	jr Label_00_154d ; $1542
Label_00_1544:
	ld a, b ; $1544
	rrca ; $1545
	rrca ; $1546
	ld b, a ; $1547
	and a, $c0 ; $1548
	ld c, a ; $154a
	xor a, b ; $154b
	ld b, a ; $154c
Label_00_154d:
	pop de ; $154d
	pop hl ; $154e
Label_00_154f:
	bit 7, d ; $154f
	jr z, Label_00_155a ; $1551
	xor a, a ; $1553
	sub a, c ; $1554
	ld c, a ; $1555
	ld a, $80 ; $1556
	sbc a, b ; $1558
	ld b, a ; $1559
Label_00_155a:
	bit 7, h ; $155a
	jr z, Label_00_1564 ; $155c
	xor a, a ; $155e
	sub a, c ; $155f
	ld c, a ; $1560
	sbc a, a ; $1561
	sub a, b ; $1562
	ld b, a ; $1563
Label_00_1564:
	ret ; $1564
TangentTable:
	; $1565, 514 bytes (records:2)
; 257 records x 2 bytes
	dw $0000 ; record 0
	dw $0001 ; record 1
	dw $0003 ; record 2
	dw $0004 ; record 3
	dw $0006 ; record 4
	dw $0007 ; record 5
	dw $0009 ; record 6
	dw $000b ; record 7
	dw $000c ; record 8
	dw $000e ; record 9
	dw $000f ; record 10
	dw $0011 ; record 11
	dw $0012 ; record 12
	dw $0014 ; record 13
	dw $0016 ; record 14
	dw $0017 ; record 15
	dw $0019 ; record 16
	dw $001a ; record 17
	dw $001c ; record 18
	dw $001e ; record 19
	dw $001f ; record 20
	dw $0021 ; record 21
	dw $0022 ; record 22
	dw $0024 ; record 23
	dw $0026 ; record 24
	dw $0027 ; record 25
	dw $0029 ; record 26
	dw $002a ; record 27
	dw $002c ; record 28
	dw $002e ; record 29
	dw $002f ; record 30
	dw $0031 ; record 31
	dw $0032 ; record 32
	dw $0034 ; record 33
	dw $0036 ; record 34
	dw $0037 ; record 35
	dw $0039 ; record 36
	dw $003b ; record 37
	dw $003c ; record 38
	dw $003e ; record 39
	dw $0040 ; record 40
	dw $0041 ; record 41
	dw $0043 ; record 42
	dw $0045 ; record 43
	dw $0046 ; record 44
	dw $0048 ; record 45
	dw $004a ; record 46
	dw $004c ; record 47
	dw $004d ; record 48
	dw $004f ; record 49
	dw $0051 ; record 50
	dw $0052 ; record 51
	dw $0054 ; record 52
	dw $0056 ; record 53
	dw $0058 ; record 54
	dw $0059 ; record 55
	dw $005b ; record 56
	dw $005d ; record 57
	dw $005f ; record 58
	dw $0061 ; record 59
	dw $0062 ; record 60
	dw $0064 ; record 61
	dw $0066 ; record 62
	dw $0068 ; record 63
	dw $006a ; record 64
	dw $006c ; record 65
	dw $006d ; record 66
	dw $006f ; record 67
	dw $0071 ; record 68
	dw $0073 ; record 69
	dw $0075 ; record 70
	dw $0077 ; record 71
	dw $0079 ; record 72
	dw $007b ; record 73
	dw $007d ; record 74
	dw $007f ; record 75
	dw $0081 ; record 76
	dw $0083 ; record 77
	dw $0085 ; record 78
	dw $0087 ; record 79
	dw $0089 ; record 80
	dw $008b ; record 81
	dw $008d ; record 82
	dw $008f ; record 83
	dw $0091 ; record 84
	dw $0093 ; record 85
	dw $0095 ; record 86
	dw $0097 ; record 87
	dw $0099 ; record 88
	dw $009b ; record 89
	dw $009e ; record 90
	dw $00a0 ; record 91
	dw $00a2 ; record 92
	dw $00a4 ; record 93
	dw $00a6 ; record 94
	dw $00a9 ; record 95
	dw $00ab ; record 96
	dw $00ad ; record 97
	dw $00af ; record 98
	dw $00b2 ; record 99
	dw $00b4 ; record 100
	dw $00b6 ; record 101
	dw $00b9 ; record 102
	dw $00bb ; record 103
	dw $00be ; record 104
	dw $00c0 ; record 105
	dw $00c3 ; record 106
	dw $00c5 ; record 107
	dw $00c8 ; record 108
	dw $00ca ; record 109
	dw $00cd ; record 110
	dw $00cf ; record 111
	dw $00d2 ; record 112
	dw $00d5 ; record 113
	dw $00d7 ; record 114
	dw $00da ; record 115
	dw $00dd ; record 116
	dw $00e0 ; record 117
	dw $00e2 ; record 118
	dw $00e5 ; record 119
	dw $00e8 ; record 120
	dw $00eb ; record 121
	dw $00ee ; record 122
	dw $00f1 ; record 123
	dw $00f4 ; record 124
	dw $00f7 ; record 125
	dw $00fa ; record 126
	dw $00fd ; record 127
	dw $0100 ; record 128
	dw $0103 ; record 129
	dw $0106 ; record 130
	dw $010a ; record 131
	dw $010d ; record 132
	dw $0110 ; record 133
	dw $0114 ; record 134
	dw $0117 ; record 135
	dw $011b ; record 136
	dw $011e ; record 137
	dw $0122 ; record 138
	dw $0125 ; record 139
	dw $0129 ; record 140
	dw $012d ; record 141
	dw $0130 ; record 142
	dw $0134 ; record 143
	dw $0138 ; record 144
	dw $013c ; record 145
	dw $0140 ; record 146
	dw $0144 ; record 147
	dw $0148 ; record 148
	dw $014d ; record 149
	dw $0151 ; record 150
	dw $0155 ; record 151
	dw $015a ; record 152
	dw $015e ; record 153
	dw $0163 ; record 154
	dw $0167 ; record 155
	dw $016c ; record 156
	dw $0171 ; record 157
	dw $0176 ; record 158
	dw $017b ; record 159
	dw $0180 ; record 160
	dw $0185 ; record 161
	dw $018a ; record 162
	dw $0190 ; record 163
	dw $0195 ; record 164
	dw $019b ; record 165
	dw $01a0 ; record 166
	dw $01a6 ; record 167
	dw $01ac ; record 168
	dw $01b2 ; record 169
	dw $01b8 ; record 170
	dw $01bf ; record 171
	dw $01c5 ; record 172
	dw $01cc ; record 173
	dw $01d2 ; record 174
	dw $01d9 ; record 175
	dw $01e0 ; record 176
	dw $01e7 ; record 177
	dw $01ef ; record 178
	dw $01f6 ; record 179
	dw $01fe ; record 180
	dw $0206 ; record 181
	dw $020e ; record 182
	dw $0216 ; record 183
	dw $021f ; record 184
	dw $0228 ; record 185
	dw $0231 ; record 186
	dw $023a ; record 187
	dw $0244 ; record 188
	dw $024d ; record 189
	dw $0257 ; record 190
	dw $0262 ; record 191
	dw $026c ; record 192
	dw $0277 ; record 193
	dw $0283 ; record 194
	dw $028e ; record 195
	dw $029a ; record 196
	dw $02a7 ; record 197
	dw $02b4 ; record 198
	dw $02c1 ; record 199
	dw $02cf ; record 200
	dw $02dd ; record 201
	dw $02ec ; record 202
	dw $02fb ; record 203
	dw $030b ; record 204
	dw $031b ; record 205
	dw $032d ; record 206
	dw $033e ; record 207
	dw $0351 ; record 208
	dw $0364 ; record 209
	dw $0378 ; record 210
	dw $038d ; record 211
	dw $03a3 ; record 212
	dw $03ba ; record 213
	dw $03d2 ; record 214
	dw $03eb ; record 215
	dw $0405 ; record 216
	dw $0421 ; record 217
	dw $043e ; record 218
	dw $045d ; record 219
	dw $047e ; record 220
	dw $04a0 ; record 221
	dw $04c4 ; record 222
	dw $04eb ; record 223
	dw $0513 ; record 224
	dw $053f ; record 225
	dw $056d ; record 226
	dw $059f ; record 227
	dw $05d4 ; record 228
	dw $060d ; record 229
	dw $064b ; record 230
	dw $068d ; record 231
	dw $06d5 ; record 232
	dw $0723 ; record 233
	dw $0779 ; record 234
	dw $07d7 ; record 235
	dw $083e ; record 236
	dw $08b0 ; record 237
	dw $092f ; record 238
	dw $09be ; record 239
	dw $0a5e ; record 240
	dw $0b14 ; record 241
	dw $0be5 ; record 242
	dw $0cd7 ; record 243
	dw $0df3 ; record 244
	dw $0f43 ; record 245
	dw $10d9 ; record 246
	dw $12cd ; record 247
	dw $1544 ; record 248
	dw $1878 ; record 249
	dw $1cce ; record 250
	dw $2302 ; record 251
	dw $2c9d ; record 252
	dw $3d78 ; record 253
	dw $62ca ; record 254
	dw $fb6a ; record 255
	dw $ffff ; record 256
GetTangent:
	add hl, hl ; $1767
	add hl, hl ; $1768
	jr c, Label_00_177e ; $1769
	ld a, h ; $176b
	cpl ; $176c
	ld l, a ; $176d
	ld h, $00 ; $176e
	add hl, hl ; $1770
	ld bc, $1568 ; $1771
	add hl, bc ; $1774
	ld a, [hl-] ; $1775
	ld l, [hl] ; $1776
	ld h, a ; $1777
	add a, a ; $1778
	ret nc ; $1779
	ld hl, $7fff ; $177a
	ret ; $177d
Label_00_177e:
	ld l, h ; $177e
	ld h, $00 ; $177f
	inc l ; $1781
	dec l ; $1782
	ret z ; $1783
	add hl, hl ; $1784
	ld bc, TangentTable ; $1785
	add hl, bc ; $1788
	xor a, a ; $1789
	sub a, [hl] ; $178a
	ld c, a ; $178b
	sbc a, a ; $178c
	inc hl ; $178d
	sub a, [hl] ; $178e
	ld l, c ; $178f
	ld h, a ; $1790
	add a, a ; $1791
	ret c ; $1792
	ld hl, $8001 ; $1793
	ret ; $1796
DecompressData:
	push af ; $1797
	push bc ; $1798
	push de ; $1799
	push de ; $179a
Label_00_179b:
	ld a, [hl+] ; $179b
	scf ; $179c
	rra ; $179d
	ld c, a ; $179e
	jr nc, Label_00_17f3 ; $179f
	ld a, [hl+] ; $17a1
	ld [de], a ; $17a2
	inc de ; $17a3
Label_00_17a4:
	srl c ; $17a4
	jr z, Label_00_179b ; $17a6
	jr nc, Label_00_17f3 ; $17a8
	ld a, [hl+] ; $17aa
	ld [de], a ; $17ab
	inc de ; $17ac
	srl c ; $17ad
	jr z, Label_00_179b ; $17af
	jr nc, Label_00_17f3 ; $17b1
	ld a, [hl+] ; $17b3
	ld [de], a ; $17b4
	inc de ; $17b5
	srl c ; $17b6
	jr z, Label_00_179b ; $17b8
	jr nc, Label_00_17f3 ; $17ba
	ld a, [hl+] ; $17bc
	ld [de], a ; $17bd
	inc de ; $17be
	srl c ; $17bf
	jr z, Label_00_179b ; $17c1
	jr nc, Label_00_17f3 ; $17c3
	ld a, [hl+] ; $17c5
	ld [de], a ; $17c6
	inc de ; $17c7
	srl c ; $17c8
	jr z, Label_00_179b ; $17ca
	jr nc, Label_00_17f3 ; $17cc
	ld a, [hl+] ; $17ce
	ld [de], a ; $17cf
	inc de ; $17d0
	srl c ; $17d1
	jr z, Label_00_179b ; $17d3
	jr nc, Label_00_17f3 ; $17d5
	ld a, [hl+] ; $17d7
	ld [de], a ; $17d8
	inc de ; $17d9
	srl c ; $17da
	jr z, Label_00_179b ; $17dc
	jr nc, Label_00_17f3 ; $17de
	ld a, [hl+] ; $17e0
	ld [de], a ; $17e1
	inc de ; $17e2
	jr Label_00_179b ; $17e3
Label_00_17e5:
	pop hl ; $17e5
	ld h, d ; $17e6
	ld l, e ; $17e7
	pop de ; $17e8
	ld a, l ; $17e9
	sub a, e ; $17ea
	ld l, a ; $17eb
	ld a, h ; $17ec
	sbc a, d ; $17ed
	ld h, a ; $17ee
	pop de ; $17ef
	pop bc ; $17f0
	pop af ; $17f1
	ret ; $17f2
Label_00_17f3:
	ld a, [hl+] ; $17f3
	ld b, [hl] ; $17f4
	inc hl ; $17f5
	push hl ; $17f6
	ld l, a ; $17f7
	or a, b ; $17f8
	jr z, Label_00_17e5 ; $17f9
	ld a, b ; $17fb
	rlca ; $17fc
	rlca ; $17fd
	rlca ; $17fe
	or a, $f8 ; $17ff
	ld h, a ; $1801
	add hl, de ; $1802
	ld a, b ; $1803
	and a, $1f ; $1804
	jr z, Label_00_187e ; $1806
	ld b, a ; $1808
	srl b ; $1809
	jr nc, Label_00_1812 ; $180b
	ld a, [hl+] ; $180d
	ld [de], a ; $180e
	inc de ; $180f
	jr z, Label_00_187e ; $1810
Label_00_1812:
	srl b ; $1812
	jr nc, Label_00_181e ; $1814
	ld a, [hl+] ; $1816
	ld [de], a ; $1817
	inc de ; $1818
	ld a, [hl+] ; $1819
	ld [de], a ; $181a
	inc de ; $181b
	jr z, Label_00_187e ; $181c
Label_00_181e:
	srl b ; $181e
	jr nc, Label_00_1830 ; $1820
	ld a, [hl+] ; $1822
	ld [de], a ; $1823
	inc de ; $1824
	ld a, [hl+] ; $1825
	ld [de], a ; $1826
	inc de ; $1827
	ld a, [hl+] ; $1828
	ld [de], a ; $1829
	inc de ; $182a
	ld a, [hl+] ; $182b
	ld [de], a ; $182c
	inc de ; $182d
	jr z, Label_00_187e ; $182e
Label_00_1830:
	srl b ; $1830
	jr nc, Label_00_184e ; $1832
	ld a, [hl+] ; $1834
	ld [de], a ; $1835
	inc de ; $1836
	ld a, [hl+] ; $1837
	ld [de], a ; $1838
	inc de ; $1839
	ld a, [hl+] ; $183a
	ld [de], a ; $183b
	inc de ; $183c
	ld a, [hl+] ; $183d
	ld [de], a ; $183e
	inc de ; $183f
	ld a, [hl+] ; $1840
	ld [de], a ; $1841
	inc de ; $1842
	ld a, [hl+] ; $1843
	ld [de], a ; $1844
	inc de ; $1845
	ld a, [hl+] ; $1846
	ld [de], a ; $1847
	inc de ; $1848
	ld a, [hl+] ; $1849
	ld [de], a ; $184a
	inc de ; $184b
	jr z, Label_00_187e ; $184c
Label_00_184e:
	ld a, [hl+] ; $184e
	ld [de], a ; $184f
	inc de ; $1850
	ld a, [hl+] ; $1851
	ld [de], a ; $1852
	inc de ; $1853
	ld a, [hl+] ; $1854
	ld [de], a ; $1855
	inc de ; $1856
	ld a, [hl+] ; $1857
	ld [de], a ; $1858
	inc de ; $1859
	ld a, [hl+] ; $185a
	ld [de], a ; $185b
	inc de ; $185c
	ld a, [hl+] ; $185d
	ld [de], a ; $185e
	inc de ; $185f
	ld a, [hl+] ; $1860
	ld [de], a ; $1861
	inc de ; $1862
	ld a, [hl+] ; $1863
	ld [de], a ; $1864
	inc de ; $1865
	ld a, [hl+] ; $1866
	ld [de], a ; $1867
	inc de ; $1868
	ld a, [hl+] ; $1869
	ld [de], a ; $186a
	inc de ; $186b
	ld a, [hl+] ; $186c
	ld [de], a ; $186d
	inc de ; $186e
	ld a, [hl+] ; $186f
	ld [de], a ; $1870
	inc de ; $1871
	ld a, [hl+] ; $1872
	ld [de], a ; $1873
	inc de ; $1874
	ld a, [hl+] ; $1875
	ld [de], a ; $1876
	inc de ; $1877
	ld a, [hl+] ; $1878
	ld [de], a ; $1879
	inc de ; $187a
	ld a, [hl+] ; $187b
	ld [de], a ; $187c
	inc de ; $187d
Label_00_187e:
	ld a, [hl+] ; $187e
	ld [de], a ; $187f
	inc de ; $1880
	ld a, [hl+] ; $1881
	ld [de], a ; $1882
	inc de ; $1883
	ld a, [hl+] ; $1884
	ld [de], a ; $1885
	inc de ; $1886
	pop hl ; $1887
	jp Label_00_17a4 ; $1888
ClearDebugTextBuffer:
	ld hl, wDebugTextBuffer ; $188b
	ld c, $24 ; $188e
	jp ClearMemory16 ; $1890
UpdateDebugOverlay:
	xor a, a ; $1893
	ldh [rVBK], a ; $1894
	ld hl, $c0fb ; $1896
	ld de, $9d08 ; $1899
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
	cp a, $03 ; $18aa
	jr z, Label_00_18c1 ; $18ac
	cp a, $01 ; $18ae
	jr z, Label_00_18ba ; $18b0
	ldh a, [hVBlankCounter] ; $18b2
	and a, $01 ; $18b4
	jr z, Label_00_18c1 ; $18b6
	jr Label_00_18be ; $18b8
Label_00_18ba:
	ldh a, [hPlayerInputFlags] ; $18ba
	bit 2, a ; $18bc
Label_00_18be:
	xor a, a ; $18be
	jr Label_00_18c3 ; $18bf
Label_00_18c1:
	ld a, $01 ; $18c1
Label_00_18c3:
	ldh [hShowDebugConsole], a ; $18c3
	ldh a, [hDebugTextDirty] ; $18c5
	or a, a ; $18c7
	ret z ; $18c8
	xor a, a ; $18c9
	ldh [hDebugTextDirty], a ; $18ca
	xor a, a ; $18cc
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
	push af ; $18e4
Label_00_18e5:
	ldh a, [hVBlankOccurred] ; $18e5
	or a, a ; $18e7
	jr nz, Label_00_18e5 ; $18e8
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
	and a, $1f ; $18fb
	ld d, a ; $18fd
	xor a, e ; $18fe
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
Label_00_190a:
	ld a, [hl+] ; $190a
	or a, a ; $190b
	jr z, Label_00_191e ; $190c
	ld [de], a ; $190e
	inc de ; $190f
	ld a, e ; $1910
	and a, $1f ; $1911
	jr nz, Label_00_190a ; $1913
	ld a, e ; $1915
	sub a, $20 ; $1916
	ld e, a ; $1918
	jr nc, Label_00_191c ; $1919
	dec d ; $191b
Label_00_191c:
	jr Label_00_190a ; $191c
Label_00_191e:
	dec hl ; $191e
	ld a, $01 ; $191f
Label_00_1921:
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
	and a, $0f ; $1939
	cp a, $0a ; $193b
	jr c, Label_00_1941 ; $193d
	add a, $07 ; $193f
Label_00_1941:
	add a, $30 ; $1941
	ld [de], a ; $1943
	inc de ; $1944
	ld a, h ; $1945
	and a, $0f ; $1946
	cp a, $0a ; $1948
	jr c, Label_00_194e ; $194a
	add a, $07 ; $194c
Label_00_194e:
	add a, $30 ; $194e
	ld [de], a ; $1950
	inc de ; $1951
	ld a, l ; $1952
	swap a ; $1953
	and a, $0f ; $1955
	cp a, $0a ; $1957
	jr c, Label_00_195d ; $1959
	add a, $07 ; $195b
Label_00_195d:
	add a, $30 ; $195d
	ld [de], a ; $195f
	inc de ; $1960
	ld a, l ; $1961
	and a, $0f ; $1962
	cp a, $0a ; $1964
	jr c, Label_00_196a ; $1966
	add a, $07 ; $1968
Label_00_196a:
	add a, $30 ; $196a
	ld [de], a ; $196c
	inc de ; $196d
	xor a, a ; $196e
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
	jr z, Label_00_1995 ; $1985
	xor a, a ; $1987
	sub a, l ; $1988
	ld l, a ; $1989
	sbc a, a ; $198a
	sub a, h ; $198b
	ld h, a ; $198c
	ld e, l ; $198d
	ld d, h ; $198e
	ld hl, sp + 11 ; $198f
	set 0, [hl] ; $1991
	ld l, e ; $1993
	ld h, d ; $1994
Label_00_1995:
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
	jr z, Label_00_19fb ; $19d3
	ld b, $05 ; $19d5
	ld hl, sp + 2 ; $19d7
Label_00_19d9:
	ld a, [hl] ; $19d9
	or a, a ; $19da
	jr nz, Label_00_19e4 ; $19db
	dec b ; $19dd
	inc hl ; $19de
	bit 7, [hl] ; $19df
	jr z, Label_00_19d9 ; $19e1
	inc b ; $19e3
Label_00_19e4:
	ld a, c ; $19e4
	sub a, b ; $19e5
	jr c, Label_00_19fb ; $19e6
	jr z, Label_00_19fb ; $19e8
	ld b, a ; $19ea
	ld a, $20 ; $19eb
	ld hl, sp + 7 ; $19ed
	bit 0, [hl] ; $19ef
	jr z, Label_00_19f6 ; $19f1
	dec b ; $19f3
	jr z, Label_00_19fb ; $19f4
Label_00_19f6:
	ld [de], a ; $19f6
	inc de ; $19f7
	dec b ; $19f8
	jr nz, Label_00_19f6 ; $19f9
Label_00_19fb:
	ld hl, sp + 7 ; $19fb
	bit 0, [hl] ; $19fd
	jr z, Label_00_1a05 ; $19ff
	ld a, $2d ; $1a01
	ld [de], a ; $1a03
	inc de ; $1a04
Label_00_1a05:
	ld b, $05 ; $1a05
	ld c, $30 ; $1a07
	ld hl, sp + 2 ; $1a09
Label_00_1a0b:
	ld a, [hl+] ; $1a0b
	or a, a ; $1a0c
	jr nz, Label_00_1a12 ; $1a0d
	dec b ; $1a0f
	jr nz, Label_00_1a0b ; $1a10
Label_00_1a12:
	add a, c ; $1a12
	ld [de], a ; $1a13
	inc de ; $1a14
	ld a, [hl+] ; $1a15
	bit 7, a ; $1a16
	jr z, Label_00_1a12 ; $1a18
	xor a, a ; $1a1a
	ld [de], a ; $1a1b
	pop bc ; $1a1c
	add sp, 6 ; $1a1d
	ret ; $1a1f
ExtractDecimalDigit:
	xor a, a ; $1a20
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
	jr z, Label_00_1a95 ; $1a76
	ld b, $05 ; $1a78
	ld hl, sp + 2 ; $1a7a
Label_00_1a7c:
	ld a, [hl] ; $1a7c
	or a, a ; $1a7d
	jr nz, Label_00_1a87 ; $1a7e
	dec b ; $1a80
	inc hl ; $1a81
	bit 7, [hl] ; $1a82
	jr z, Label_00_1a7c ; $1a84
	inc b ; $1a86
Label_00_1a87:
	ld a, c ; $1a87
	sub a, b ; $1a88
	jr c, Label_00_1a95 ; $1a89
	jr z, Label_00_1a95 ; $1a8b
	ld b, a ; $1a8d
	ld a, $20 ; $1a8e
Label_00_1a90:
	ld [de], a ; $1a90
	inc de ; $1a91
	dec b ; $1a92
	jr nz, Label_00_1a90 ; $1a93
Label_00_1a95:
	ld b, $05 ; $1a95
	ld c, $30 ; $1a97
	ld hl, sp + 2 ; $1a99
Label_00_1a9b:
	ld a, [hl+] ; $1a9b
	or a, a ; $1a9c
	jr nz, Label_00_1aa2 ; $1a9d
	dec b ; $1a9f
	jr nz, Label_00_1a9b ; $1aa0
Label_00_1aa2:
	add a, c ; $1aa2
	ld [de], a ; $1aa3
	inc de ; $1aa4
	ld a, [hl+] ; $1aa5
	bit 7, a ; $1aa6
	jr z, Label_00_1aa2 ; $1aa8
	xor a, a ; $1aaa
	ld [de], a ; $1aab
	pop bc ; $1aac
	add sp, 6 ; $1aad
	ret ; $1aaf
ExtractDecimalDigitUnsigned:
	xor a, a ; $1ab0
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
	jr Label_00_1b2b ; $1acc
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
	jr Label_00_1b2b ; $1ae2
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
	jr Label_00_1b2b ; $1af9
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
	jr Label_00_1b2b ; $1b13
PrintDecimalWord:
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
Label_00_1b2b:
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
	xor a, a ; $1b38
	ldh [hFrameTasksReady], a ; $1b39
	ld hl, wFrameTasks ; $1b3b
	ld c, $04 ; $1b3e
	call ClearMemory16 ; $1b40
	ld a, $01 ; $1b43
	ldh [hFrameTasksReady], a ; $1b45
	ret ; $1b47
Compare3Bytes:
	push hl ; $1b48
	push de ; $1b49
	ld a, [de] ; $1b4a
	cp a, [hl] ; $1b4b
	jr nz, Label_00_1b5d ; $1b4c
	inc hl ; $1b4e
	inc de ; $1b4f
	ld a, [de] ; $1b50
	cp a, [hl] ; $1b51
	jr nz, Label_00_1b5d ; $1b52
	inc hl ; $1b54
	inc de ; $1b55
	ld a, [de] ; $1b56
	cp a, [hl] ; $1b57
	jr nz, Label_00_1b5d ; $1b58
	xor a, a ; $1b5a
	jr Label_00_1b60 ; $1b5b
Label_00_1b5d:
	ld a, $01 ; $1b5d
	or a, a ; $1b5f
Label_00_1b60:
	pop de ; $1b60
	pop hl ; $1b61
	ret ; $1b62
Check3BytesZero:
	push hl ; $1b63
	ld a, [hl+] ; $1b64
	or a, [hl] ; $1b65
	inc hl ; $1b66
	or a, [hl] ; $1b67
	pop hl ; $1b68
	ret ; $1b69
RegisterFrameTask:
	add sp, -4 ; $1b6a
	push af ; $1b6c
	xor a, a ; $1b6d
	ldh [hFrameTasksReady], a ; $1b6e
	pop af ; $1b70
	ld d, h ; $1b71
	ld e, l ; $1b72
	ld hl, sp + 0 ; $1b73
	push hl ; $1b75
	ld [hl+], a ; $1b76
	ld [hl], e ; $1b77
	inc hl ; $1b78
	ld [hl], d ; $1b79
	inc hl ; $1b7a
	ldh a, [hRomBank] ; $1b7b
	ld [hl], a ; $1b7d
	pop de ; $1b7e
	inc de ; $1b7f
	ld bc, $0010 ; $1b80
	ld hl, wFrameTasks ; $1b83
Label_00_1b86:
	inc hl ; $1b86
	call Compare3Bytes ; $1b87
	jr nz, Label_00_1b90 ; $1b8a
	ld b, $01 ; $1b8c
	jr Label_00_1b96 ; $1b8e
Label_00_1b90:
	inc hl ; $1b90
	inc hl ; $1b91
	inc hl ; $1b92
	dec c ; $1b93
	jr nz, Label_00_1b86 ; $1b94
Label_00_1b96:
	ld a, b ; $1b96
	or a, a ; $1b97
	jr nz, Label_00_1bc1 ; $1b98
	ld c, $16 ; $1b9a
	ld hl, wFrameTasks ; $1b9c
Label_00_1b9f:
	inc hl ; $1b9f
	call Check3BytesZero ; $1ba0
	jr nz, Label_00_1bb7 ; $1ba3
	dec hl ; $1ba5
	dec de ; $1ba6
	ld a, [de] ; $1ba7
	ld [hl], a ; $1ba8
	inc hl ; $1ba9
	inc de ; $1baa
	ld a, [de] ; $1bab
	ld [hl], a ; $1bac
	inc de ; $1bad
	inc hl ; $1bae
	ld a, [de] ; $1baf
	ld [hl], a ; $1bb0
	inc de ; $1bb1
	inc hl ; $1bb2
	ld a, [de] ; $1bb3
	ld [hl], a ; $1bb4
	jr Label_00_1bc1 ; $1bb5
Label_00_1bb7:
	inc hl ; $1bb7
	inc hl ; $1bb8
	inc hl ; $1bb9
	dec c ; $1bba
	jr nz, Label_00_1b9f ; $1bbb
	ld a, b ; $1bbd
	or a, a ; $1bbe
	jr nz, Label_00_1bc1 ; $1bbf
Label_00_1bc1:
	call SortFrameTasks ; $1bc1
	ld a, $01 ; $1bc4
	ldh [hFrameTasksReady], a ; $1bc6
	add sp, 4 ; $1bc8
	ret ; $1bca
UnregisterFrameTask:
	add sp, -3 ; $1bcb
	push af ; $1bcd
	xor a, a ; $1bce
	ldh [hFrameTasksReady], a ; $1bcf
	pop af ; $1bd1
	ld d, h ; $1bd2
	ld e, l ; $1bd3
	ld hl, sp + 0 ; $1bd4
	push hl ; $1bd6
	ld [hl], e ; $1bd7
	inc hl ; $1bd8
	ld [hl], d ; $1bd9
	inc hl ; $1bda
	ldh a, [hRomBank] ; $1bdb
	ld [hl], a ; $1bdd
	pop de ; $1bde
	ld c, $10 ; $1bdf
	ld hl, wFrameTasks ; $1be1
Label_00_1be4:
	inc hl ; $1be4
	call Compare3Bytes ; $1be5
	jr nz, Label_00_1bf2 ; $1be8
	dec hl ; $1bea
	xor a, a ; $1beb
	ld [hl+], a ; $1bec
	ld [hl+], a ; $1bed
	ld [hl+], a ; $1bee
	ld [hl+], a ; $1bef
	jr Label_00_1bf8 ; $1bf0
Label_00_1bf2:
	inc hl ; $1bf2
	inc hl ; $1bf3
	inc hl ; $1bf4
	dec c ; $1bf5
	jr nz, Label_00_1be4 ; $1bf6
Label_00_1bf8:
	ld a, $01 ; $1bf8
	ldh [hFrameTasksReady], a ; $1bfa
	add sp, 3 ; $1bfc
	ret ; $1bfe
RunFrameTasks:
	and a, $80 ; $1bff
	ld b, a ; $1c01
	ldh a, [hFrameTasksReady] ; $1c02
	or a, a ; $1c04
	ret z ; $1c05
	ldh a, [hRomBank] ; $1c06
	ld d, a ; $1c08
	ldh a, [hWramBank] ; $1c09
	ld e, a ; $1c0b
	push de ; $1c0c
	ld c, $10 ; $1c0d
	ld hl, wFrameTasks ; $1c0f
Label_00_1c12:
	ld a, [hl+] ; $1c12
	xor a, b ; $1c13
	add a, a ; $1c14
	jr z, Label_00_1c2c ; $1c15
	jr c, Label_00_1c2c ; $1c17
	push bc ; $1c19
	push hl ; $1c1a
	ld a, [hl+] ; $1c1b
	ld e, a ; $1c1c
	ld a, [hl+] ; $1c1d
	ld d, a ; $1c1e
	ld a, [hl] ; $1c1f
	ldh [hRomBank], a ; $1c20
	ld [$2000], a ; $1c22
	ld l, e ; $1c25
	ld h, d ; $1c26
	call JumpToHL ; $1c27
	pop hl ; $1c2a
	pop bc ; $1c2b
Label_00_1c2c:
	inc hl ; $1c2c
	inc hl ; $1c2d
	inc hl ; $1c2e
	dec c ; $1c2f
	jr nz, Label_00_1c12 ; $1c30
	pop de ; $1c32
	ld a, d ; $1c33
	ldh [hRomBank], a ; $1c34
	ld [$2000], a ; $1c36
	ld a, e ; $1c39
	wram_bank ; $1c3a
	ret ; $1c3e
SortFrameTasks:
	ld c, $0f ; $1c3f
Label_00_1c41:
	ld hl, wFrameTasks ; $1c41
	ld de, $c1c4 ; $1c44
	ld b, c ; $1c47
Label_00_1c48:
	ld a, [de] ; $1c48
	cp a, [hl] ; $1c49
	jr c, Label_00_1c5b ; $1c4a
	push bc ; $1c4c
	ld c, $04 ; $1c4d
Label_00_1c4f:
	ld b, [hl] ; $1c4f
	ld a, [de] ; $1c50
	ld [hl+], a ; $1c51
	ld a, b ; $1c52
	ld [de], a ; $1c53
	inc de ; $1c54
	dec c ; $1c55
	jr nz, Label_00_1c4f ; $1c56
	pop bc ; $1c58
	jr Label_00_1c63 ; $1c59
Label_00_1c5b:
	inc hl ; $1c5b
	inc de ; $1c5c
	inc hl ; $1c5d
	inc de ; $1c5e
	inc hl ; $1c5f
	inc de ; $1c60
	inc hl ; $1c61
	inc de ; $1c62
Label_00_1c63:
	dec b ; $1c63
	jr nz, Label_00_1c48 ; $1c64
	dec c ; $1c66
	jr nz, Label_00_1c41 ; $1c67
	ret ; $1c69
SplitColorComponents:
	push de ; $1c6a
	ld a, b ; $1c6b
	and a, $7c ; $1c6c
	rrca ; $1c6e
	rrca ; $1c6f
	ld e, a ; $1c70
	ld a, b ; $1c71
	and a, $03 ; $1c72
	ld b, a ; $1c74
	ld a, c ; $1c75
	and a, $e0 ; $1c76
	or a, b ; $1c78
	rlca ; $1c79
	rlca ; $1c7a
	rlca ; $1c7b
	ld b, a ; $1c7c
	ld a, c ; $1c7d
	and a, $1f ; $1c7e
	ld c, e ; $1c80
	pop de ; $1c81
	ret ; $1c82
CombineColorComponents:
	push af ; $1c83
	push de ; $1c84
	and a, $1f ; $1c85
	ld e, a ; $1c87
	ld a, b ; $1c88
	rrca ; $1c89
	rrca ; $1c8a
	rrca ; $1c8b
	ld b, a ; $1c8c
	and a, $e0 ; $1c8d
	or a, e ; $1c8f
	ld e, a ; $1c90
	ld a, b ; $1c91
	and a, $03 ; $1c92
	ld b, a ; $1c94
	ld a, c ; $1c95
	rlca ; $1c96
	rlca ; $1c97
	and a, $7c ; $1c98
	or a, b ; $1c9a
	ld b, a ; $1c9b
	ld c, e ; $1c9c
	pop de ; $1c9d
	pop af ; $1c9e
	ret ; $1c9f
AddClampColorComponent:
	add a, d ; $1ca0
	bit 7, a ; $1ca1
	jr z, Label_00_1ca7 ; $1ca3
	xor a, a ; $1ca5
	ret ; $1ca6
Label_00_1ca7:
	cp a, $1f ; $1ca7
	ret c ; $1ca9
	ld a, $1f ; $1caa
	ret ; $1cac
AdjustColorRed:
	push af ; $1cad
	call SplitColorComponents ; $1cae
	call AddClampColorComponent ; $1cb1
	call CombineColorComponents ; $1cb4
	pop af ; $1cb7
	ret ; $1cb8
AdjustColorGreen:
	push af ; $1cb9
	call SplitColorComponents ; $1cba
	push af ; $1cbd
	ld a, b ; $1cbe
	call AddClampColorComponent ; $1cbf
	ld b, a ; $1cc2
	pop af ; $1cc3
	call CombineColorComponents ; $1cc4
	pop af ; $1cc7
	ret ; $1cc8
AdjustColorBlue:
	push af ; $1cc9
	call SplitColorComponents ; $1cca
	push af ; $1ccd
	ld a, c ; $1cce
	call AddClampColorComponent ; $1ccf
	ld c, a ; $1cd2
	pop af ; $1cd3
	call CombineColorComponents ; $1cd4
	pop af ; $1cd7
	ret ; $1cd8
AdjustColorsBrightness:
	push af ; $1cd9
	push bc ; $1cda
	push de ; $1cdb
	push hl ; $1cdc
Label_00_1cdd:
	push bc ; $1cdd
	push de ; $1cde
	ld d, c ; $1cdf
	ld a, [hl+] ; $1ce0
	ld c, a ; $1ce1
	ld a, [hl+] ; $1ce2
	ld b, a ; $1ce3
	call SplitColorComponents ; $1ce4
	call AddClampColorComponent ; $1ce7
	ld e, a ; $1cea
	ld a, b ; $1ceb
	call AddClampColorComponent ; $1cec
	ld b, a ; $1cef
	ld a, c ; $1cf0
	call AddClampColorComponent ; $1cf1
	ld c, a ; $1cf4
	ld a, e ; $1cf5
	call CombineColorComponents ; $1cf6
	pop de ; $1cf9
	ld a, c ; $1cfa
	ld [de], a ; $1cfb
	inc de ; $1cfc
	ld a, b ; $1cfd
	ld [de], a ; $1cfe
	inc de ; $1cff
	pop bc ; $1d00
	dec b ; $1d01
	jr nz, Label_00_1cdd ; $1d02
	pop hl ; $1d04
	pop de ; $1d05
	pop bc ; $1d06
	pop af ; $1d07
	ret ; $1d08
	push af ; $1d09
	jr Label_00_1d26 ; $1d0a
ForceFadeIn:
	push af ; $1d0c
	jr Label_00_1d34 ; $1d0d
	di ; $1d0f
	call BeginFadeOut ; $1d10
	push af ; $1d13
	ldh a, [hFadeState] ; $1d14
	or a, a ; $1d16
	jr z, Label_00_1d1d ; $1d17
	or a, $80 ; $1d19
	ldh [hFadeState], a ; $1d1b
Label_00_1d1d:
	pop af ; $1d1d
	ei ; $1d1e
	ret ; $1d1f
BeginFadeOut:
	push af ; $1d20
	ldh a, [hFadedOut] ; $1d21
	or a, a ; $1d23
	jr nz, Label_00_1d46 ; $1d24
Label_00_1d26:
	ld a, $01 ; $1d26
	ldh [hFadeState], a ; $1d28
	ldh [hFadedOut], a ; $1d2a
	jr Label_00_1d3b ; $1d2c
BeginFadeIn:
	push af ; $1d2e
	ldh a, [hFadedOut] ; $1d2f
	or a, a ; $1d31
	jr z, Label_00_1d46 ; $1d32
Label_00_1d34:
	ld a, $02 ; $1d34
	ldh [hFadeState], a ; $1d36
	xor a, a ; $1d38
	ldh [hFadedOut], a ; $1d39
Label_00_1d3b:
	ld a, c ; $1d3b
	and a, a ; $1d3c
	jr nz, Label_00_1d40 ; $1d3d
	inc a ; $1d3f
Label_00_1d40:
	ldh [hFadeSpeed], a ; $1d40
	ld a, $7c ; $1d42
	ldh [hFadeCounter], a ; $1d44
Label_00_1d46:
	pop af ; $1d46
	ret ; $1d47
UpdateFadeIn:
	push af ; $1d48
	ldh a, [hFadeState] ; $1d49
	and a, $02 ; $1d4b
	jr z, Label_00_1da2 ; $1d4d
	push bc ; $1d4f
	push de ; $1d50
	push hl ; $1d51
	ldh a, [hFadeSpeed] ; $1d52
	ld c, a ; $1d54
	ldh a, [hFadeCounter] ; $1d55
	sub a, c ; $1d57
	jr nc, Label_00_1d5b ; $1d58
	xor a, a ; $1d5a
Label_00_1d5b:
	ld c, a ; $1d5b
	jr Label_00_1d76 ; $1d5c
UpdateFadeOut:
	push af ; $1d5e
	ldh a, [hFadeState] ; $1d5f
	rrca ; $1d61
	jr nc, Label_00_1da2 ; $1d62
	push bc ; $1d64
	push de ; $1d65
	push hl ; $1d66
	ldh a, [hFadeSpeed] ; $1d67
	ld c, a ; $1d69
	ldh a, [hFadeCounter] ; $1d6a
	sub a, c ; $1d6c
	jr nc, Label_00_1d70 ; $1d6d
	xor a, a ; $1d6f
Label_00_1d70:
	ld b, a ; $1d70
	ld a, $7c ; $1d71
	sub a, b ; $1d73
	ld c, a ; $1d74
	ld a, b ; $1d75
Label_00_1d76:
	push af ; $1d76
	ldh a, [hFadeState] ; $1d77
	add a, a ; $1d79
	jr nc, Label_00_1d84 ; $1d7a
	ld a, c ; $1d7c
	and a, $04 ; $1d7d
	call z, ApplyWhiteFade ; $1d7f
	jr Label_00_1d93 ; $1d82
Label_00_1d84:
	ld hl, wMasterPalettes ; $1d84
	ld de, wBGPalettes ; $1d87
	ld b, $40 ; $1d8a
	srl c ; $1d8c
	srl c ; $1d8e
	call AdjustColorsBrightness ; $1d90
Label_00_1d93:
	pop af ; $1d93
	and a, a ; $1d94
	jr nz, Label_00_1d99 ; $1d95
	ldh [hFadeState], a ; $1d97
Label_00_1d99:
	ldh [hFadeCounter], a ; $1d99
	ld a, $03 ; $1d9b
	ldh [hPaletteDirtyFlags], a ; $1d9d
	pop hl ; $1d9f
	pop de ; $1da0
	pop bc ; $1da1
Label_00_1da2:
	pop af ; $1da2
	ret ; $1da3
WaitFadeEnd:
	push af ; $1da4
Label_00_1da5:
	ldh a, [hFadeState] ; $1da5
	and a, a ; $1da7
	jr z, Label_00_1dbb ; $1da8
	ldh a, [$ffd8] ; $1daa
	or a, a ; $1dac
	jr z, Label_00_1db6 ; $1dad
	push af ; $1daf
	farcall FarPtr_07_1a ; $1db0
	pop af ; $1db3
	jr Label_00_1db9 ; $1db4
Label_00_1db6:
	call AdvanceFrame ; $1db6
Label_00_1db9:
	jr Label_00_1da5 ; $1db9
Label_00_1dbb:
	pop af ; $1dbb
	ret ; $1dbc
	push af ; $1dbd
Label_00_1dbe:
	ldh a, [hFadeState] ; $1dbe
	and a, a ; $1dc0
	jr z, Label_00_1dca ; $1dc1
	push af ; $1dc3
	farcall FarPtr_07_1a ; $1dc4
	pop af ; $1dc7
	jr Label_00_1dbe ; $1dc8
Label_00_1dca:
	pop af ; $1dca
	ret ; $1dcb
ApplyWhiteFade:
	push af ; $1dcc
	ld a, c ; $1dcd
	and a, $78 ; $1dce
	ld d, a ; $1dd0
	rrca ; $1dd1
	rrca ; $1dd2
	ld e, a ; $1dd3
	swap a ; $1dd4
	rrca ; $1dd6
	ld l, a ; $1dd7
	ld h, $00 ; $1dd8
	add hl, hl ; $1dda
	add hl, hl ; $1ddb
	add hl, de ; $1ddc
	ld d, h ; $1ddd
	ld e, l ; $1dde
	ld hl, wMasterPalettes ; $1ddf
	ld bc, wBGPalettes ; $1de2
	ld a, $40 ; $1de5
Label_00_1de7:
	push af ; $1de7
	push de ; $1de8
	push bc ; $1de9
	ld a, [hl+] ; $1dea
	and a, $df ; $1deb
	add a, e ; $1ded
	ld c, a ; $1dee
	ld a, [hl+] ; $1def
	res 2, a ; $1df0
	adc a, d ; $1df2
	ld b, a ; $1df3
	bit 7, a ; $1df4
	jr z, Label_00_1dfa ; $1df6
	or a, $78 ; $1df8
Label_00_1dfa:
	bit 2, a ; $1dfa
	jr z, Label_00_1e05 ; $1dfc
	and a, $fc ; $1dfe
	dec a ; $1e00
	set 7, c ; $1e01
	set 6, c ; $1e03
Label_00_1e05:
	ld b, a ; $1e05
	ld a, c ; $1e06
	bit 5, a ; $1e07
	jr z, Label_00_1e0e ; $1e09
	and a, $e0 ; $1e0b
	dec a ; $1e0d
Label_00_1e0e:
	pop de ; $1e0e
	ld [de], a ; $1e0f
	inc de ; $1e10
	ld a, b ; $1e11
	ld [de], a ; $1e12
	inc de ; $1e13
	ld b, d ; $1e14
	ld c, e ; $1e15
	pop de ; $1e16
	pop af ; $1e17
	dec a ; $1e18
	jr nz, Label_00_1de7 ; $1e19
	pop af ; $1e1b
	ret ; $1e1c
ClearSpriteQueue:
	xor a, a ; $1e1d
	ldh [hSpriteQueueIndex], a ; $1e1e
	ldh [hSpriteQueueBase], a ; $1e20
ClearUnusedSprites:
	ldh a, [hSpriteQueueBase] ; $1e22
	ldh [hSpriteQueueIndex], a ; $1e24
	ld l, a ; $1e26
	ld a, [wSpriteBufferPage] ; $1e27
	ld h, a ; $1e2a
	ld a, $a0 ; $1e2b
	sub a, l ; $1e2d
	ret z ; $1e2e
	srl a ; $1e2f
	srl a ; $1e31
	ld c, a ; $1e33
	xor a, a ; $1e34
Label_00_1e35:
	ld [hl+], a ; $1e35
	ld [hl+], a ; $1e36
	ld [hl+], a ; $1e37
	ld [hl+], a ; $1e38
	dec c ; $1e39
	jr nz, Label_00_1e35 ; $1e3a
	ret ; $1e3c
ClearBothSpriteBuffers:
	call ClearSpriteQueue ; $1e3d
	ld a, [wSpriteBufferPage] ; $1e40
	push af ; $1e43
	and a, $cf ; $1e44
	xor a, $05 ; $1e46
	ld [wSpriteBufferPage], a ; $1e48
	call ClearSpriteQueue ; $1e4b
	pop af ; $1e4e
	ret ; $1e4f
	ldh a, [hSpriteQueueIndex] ; $1e50
	ldh [hSpriteQueueBase], a ; $1e52
	ret ; $1e54
QueueSprite16:
	ldh a, [hSpriteQueueIndex] ; $1e55
	cp a, $a0 ; $1e57
	ret z ; $1e59
	ld l, a ; $1e5a
	ld a, [wSpriteBufferPage] ; $1e5b
	ld h, a ; $1e5e
	bit 5, b ; $1e5f
	jr nz, Label_00_1e80 ; $1e61
	ld [hl], e ; $1e63
	inc l ; $1e64
	ld [hl], d ; $1e65
	inc l ; $1e66
	ld [hl], c ; $1e67
	inc l ; $1e68
	ld [hl], b ; $1e69
	inc l ; $1e6a
	inc c ; $1e6b
	inc c ; $1e6c
	ld a, l ; $1e6d
	cp a, $a0 ; $1e6e
	jr z, Label_00_1e7d ; $1e70
	ld [hl], e ; $1e72
	inc l ; $1e73
	ld a, d ; $1e74
	add a, $08 ; $1e75
	ld [hl+], a ; $1e77
	ld [hl], c ; $1e78
	inc l ; $1e79
	ld [hl], b ; $1e7a
	inc l ; $1e7b
	ld a, l ; $1e7c
Label_00_1e7d:
	ldh [hSpriteQueueIndex], a ; $1e7d
	ret ; $1e7f
Label_00_1e80:
	ld [hl], e ; $1e80
	inc l ; $1e81
	ld a, d ; $1e82
	add a, $08 ; $1e83
	ld [hl+], a ; $1e85
	ld [hl], c ; $1e86
	inc l ; $1e87
	ld [hl], b ; $1e88
	inc l ; $1e89
	inc c ; $1e8a
	inc c ; $1e8b
	ld a, l ; $1e8c
	cp a, $a0 ; $1e8d
	jr z, Label_00_1e7d ; $1e8f
	ld [hl], e ; $1e91
	inc l ; $1e92
	ld [hl], d ; $1e93
	inc l ; $1e94
	ld [hl], c ; $1e95
	inc l ; $1e96
	ld [hl], b ; $1e97
	inc l ; $1e98
	ld a, l ; $1e99
	ldh [hSpriteQueueIndex], a ; $1e9a
	ret ; $1e9c
QueueSpriteTemplate:
	add sp, -4 ; $1e9d
	push hl ; $1e9f
	ld hl, sp + 2 ; $1ea0
	ld a, e ; $1ea2
	ld [hl+], a ; $1ea3
	ld a, d ; $1ea4
	ld [hl+], a ; $1ea5
	ld a, c ; $1ea6
	ld [hl+], a ; $1ea7
	ld [hl], b ; $1ea8
	pop de ; $1ea9
	bit 5, b ; $1eaa
	jr nz, Label_00_1ed9 ; $1eac
	ld a, [wSpriteBufferPage] ; $1eae
	ld b, a ; $1eb1
	ldh a, [hSpriteQueueIndex] ; $1eb2
	ld c, a ; $1eb4
Label_00_1eb5:
	ld a, c ; $1eb5
	cp a, $a0 ; $1eb6
	jr z, Label_00_1f07 ; $1eb8
	ld a, [de] ; $1eba
	cp a, $80 ; $1ebb
	jr z, Label_00_1f07 ; $1ebd
	ld hl, sp + 0 ; $1ebf
	add a, [hl] ; $1ec1
	ld [bc], a ; $1ec2
	inc c ; $1ec3
	inc de ; $1ec4
	inc hl ; $1ec5
	ld a, [de] ; $1ec6
	add a, [hl] ; $1ec7
	ld [bc], a ; $1ec8
	inc c ; $1ec9
	inc de ; $1eca
	inc hl ; $1ecb
	ld a, [de] ; $1ecc
	add a, [hl] ; $1ecd
	ld [bc], a ; $1ece
	inc c ; $1ecf
	inc de ; $1ed0
	inc hl ; $1ed1
	ld a, [de] ; $1ed2
	add a, [hl] ; $1ed3
	ld [bc], a ; $1ed4
	inc c ; $1ed5
	inc de ; $1ed6
	jr Label_00_1eb5 ; $1ed7
Label_00_1ed9:
	ld a, [wSpriteBufferPage] ; $1ed9
	ld b, a ; $1edc
	ldh a, [hSpriteQueueIndex] ; $1edd
	ld c, a ; $1edf
Label_00_1ee0:
	ld a, c ; $1ee0
	cp a, $a0 ; $1ee1
	jr z, Label_00_1f07 ; $1ee3
	ld a, [de] ; $1ee5
	cp a, $80 ; $1ee6
	jr z, Label_00_1f07 ; $1ee8
	ld hl, sp + 0 ; $1eea
	add a, [hl] ; $1eec
	ld [bc], a ; $1eed
	inc c ; $1eee
	inc de ; $1eef
	inc hl ; $1ef0
	ld a, [de] ; $1ef1
	cpl ; $1ef2
	add a, $09 ; $1ef3
	add a, [hl] ; $1ef5
	ld [bc], a ; $1ef6
	inc c ; $1ef7
	inc de ; $1ef8
	inc hl ; $1ef9
	ld a, [de] ; $1efa
	add a, [hl] ; $1efb
	ld [bc], a ; $1efc
	inc c ; $1efd
	inc de ; $1efe
	inc hl ; $1eff
	ld a, [de] ; $1f00
	or a, [hl] ; $1f01
	ld [bc], a ; $1f02
	inc c ; $1f03
	inc de ; $1f04
	jr Label_00_1ee0 ; $1f05
Label_00_1f07:
	ld a, c ; $1f07
	ldh [hSpriteQueueIndex], a ; $1f08
	add sp, 4 ; $1f0a
	ret ; $1f0c
	push af ; $1f0d
	push bc ; $1f0e
	push de ; $1f0f
	push hl ; $1f10
	push hl ; $1f11
	ld hl, $0810 ; $1f12
	add hl, de ; $1f15
	ld d, h ; $1f16
	ld e, l ; $1f17
	pop hl ; $1f18
Label_00_1f19:
	push de ; $1f19
	push hl ; $1f1a
Label_00_1f1b:
	ldh a, [hSpriteQueueIndex] ; $1f1b
	cp a, $a0 ; $1f1d
	jr nz, Label_00_1f28 ; $1f1f
	add sp, 4 ; $1f21
	pop hl ; $1f23
	pop de ; $1f24
	pop bc ; $1f25
	pop af ; $1f26
	ret ; $1f27
Label_00_1f28:
	push hl ; $1f28
	ld l, a ; $1f29
	ld a, [wSpriteBufferPage] ; $1f2a
	ld h, a ; $1f2d
	ld [hl], e ; $1f2e
	inc l ; $1f2f
	ld [hl], d ; $1f30
	inc l ; $1f31
	ld [hl], c ; $1f32
	inc l ; $1f33
	ld [hl], b ; $1f34
	inc l ; $1f35
	ld a, l ; $1f36
	ldh [hSpriteQueueIndex], a ; $1f37
	pop hl ; $1f39
	inc c ; $1f3a
	inc c ; $1f3b
	ld a, d ; $1f3c
	add a, $08 ; $1f3d
	ld d, a ; $1f3f
	dec h ; $1f40
	jr nz, Label_00_1f1b ; $1f41
	pop hl ; $1f43
	pop de ; $1f44
	ld a, e ; $1f45
	add a, $10 ; $1f46
	ld e, a ; $1f48
	dec l ; $1f49
	jr nz, Label_00_1f19 ; $1f4a
	pop hl ; $1f4c
	pop de ; $1f4d
	pop bc ; $1f4e
	pop af ; $1f4f
	ret ; $1f50
QueueSprite:
	ldh a, [hSpriteQueueIndex] ; $1f51
	cp a, $a0 ; $1f53
	ret z ; $1f55
	ld l, a ; $1f56
	ld a, [wSpriteBufferPage] ; $1f57
	ld h, a ; $1f5a
	ld a, e ; $1f5b
	add a, $0c ; $1f5c
	ld [hl+], a ; $1f5e
	ld a, d ; $1f5f
	add a, $04 ; $1f60
	ld [hl+], a ; $1f62
	ld a, c ; $1f63
	ld [hl+], a ; $1f64
	ld a, b ; $1f65
	ld [hl+], a ; $1f66
	ld a, l ; $1f67
	ldh [hSpriteQueueIndex], a ; $1f68
	ret ; $1f6a
PositionSpriteWorld:
	push af ; $1f6b
	push bc ; $1f6c
	push de ; $1f6d
	push hl ; $1f6e
	push bc ; $1f6f
	ld a, [wCameraX] ; $1f70
	ld c, a ; $1f73
	ld a, [$c321] ; $1f74
	ld b, a ; $1f77
	ld a, l ; $1f78
	sub a, c ; $1f79
	ld l, a ; $1f7a
	ld a, h ; $1f7b
	sbc a, b ; $1f7c
	ld h, a ; $1f7d
	ld a, h ; $1f7e
	inc a ; $1f7f
	cp a, $16 ; $1f80
	jp nc, Label_00_1fab ; $1f82
	add hl, hl ; $1f85
	add hl, hl ; $1f86
	add hl, hl ; $1f87
	push hl ; $1f88
	ld hl, wCameraY ; $1f89
	ld a, [hl+] ; $1f8c
	ld b, [hl] ; $1f8d
	ld c, a ; $1f8e
	ld l, e ; $1f8f
	ld h, d ; $1f90
	ld a, l ; $1f91
	sub a, c ; $1f92
	ld l, a ; $1f93
	ld a, h ; $1f94
	sbc a, b ; $1f95
	ld h, a ; $1f96
	pop de ; $1f97
	ld a, h ; $1f98
	cp a, $14 ; $1f99
	jp nc, Label_00_1fab ; $1f9b
	add hl, hl ; $1f9e
	add hl, hl ; $1f9f
	add hl, hl ; $1fa0
	ld e, h ; $1fa1
	pop bc ; $1fa2
	call QueueSprite16 ; $1fa3
	pop hl ; $1fa6
	pop de ; $1fa7
	pop bc ; $1fa8
	pop af ; $1fa9
	ret ; $1faa
Label_00_1fab:
	pop bc ; $1fab
	pop hl ; $1fac
	pop de ; $1fad
	pop bc ; $1fae
	pop af ; $1faf
	ret ; $1fb0
PositionSpriteWorld2:
	push af ; $1fb1
	push bc ; $1fb2
	push de ; $1fb3
	push hl ; $1fb4
	push bc ; $1fb5
	ld a, [wCameraX] ; $1fb6
	ld c, a ; $1fb9
	ld a, [$c321] ; $1fba
	ld b, a ; $1fbd
	ld a, l ; $1fbe
	sub a, c ; $1fbf
	ld l, a ; $1fc0
	ld a, h ; $1fc1
	sbc a, b ; $1fc2
	ld h, a ; $1fc3
	ld a, h ; $1fc4
	inc a ; $1fc5
	cp a, $16 ; $1fc6
	jp nc, Label_00_1ff1 ; $1fc8
	add hl, hl ; $1fcb
	add hl, hl ; $1fcc
	add hl, hl ; $1fcd
	push hl ; $1fce
	ld hl, wCameraY ; $1fcf
	ld a, [hl+] ; $1fd2
	ld b, [hl] ; $1fd3
	ld c, a ; $1fd4
	ld l, e ; $1fd5
	ld h, d ; $1fd6
	ld a, l ; $1fd7
	sub a, c ; $1fd8
	ld l, a ; $1fd9
	ld a, h ; $1fda
	sbc a, b ; $1fdb
	ld h, a ; $1fdc
	pop de ; $1fdd
	ld a, h ; $1fde
	cp a, $13 ; $1fdf
	jp nc, Label_00_1ff1 ; $1fe1
	add hl, hl ; $1fe4
	add hl, hl ; $1fe5
	add hl, hl ; $1fe6
	ld e, h ; $1fe7
	pop bc ; $1fe8
	call QueueSprite ; $1fe9
	pop hl ; $1fec
	pop de ; $1fed
	pop bc ; $1fee
	pop af ; $1fef
	ret ; $1ff0
Label_00_1ff1:
	pop bc ; $1ff1
	pop hl ; $1ff2
	pop de ; $1ff3
	pop bc ; $1ff4
	pop af ; $1ff5
	ret ; $1ff6
	INCBIN "data/bank_000/d_1ff7.bin" ; $1ff7, 186 bytes
	push af ; $20b1
	push bc ; $20b2
	push de ; $20b3
	push hl ; $20b4
	add sp, -16 ; $20b5
	push de ; $20b7
	push hl ; $20b8
	ld hl, sp + 6 ; $20b9
	ld d, h ; $20bb
	ld e, l ; $20bc
	pop hl ; $20bd
	call FormatDecimalNumber ; $20be
	ld hl, sp + 4 ; $20c1
	pop de ; $20c3
	call RenderTextToTiles ; $20c4
	add sp, 16 ; $20c7
	pop hl ; $20c9
	pop de ; $20ca
	pop bc ; $20cb
	pop af ; $20cc
	ret ; $20cd
	push af ; $20ce
	push hl ; $20cf
	sub a, $30 ; $20d0
	and a, $1f ; $20d2
	add a, a ; $20d4
	add a, $91 ; $20d5
	ld l, a ; $20d7
	adc a, $20 ; $20d8
	sub a, l ; $20da
	ld h, a ; $20db
	ld a, [hl+] ; $20dc
	ld h, [hl] ; $20dd
	ld l, a ; $20de
	call RenderGlyphToTiles ; $20df
	pop hl ; $20e2
	pop af ; $20e3
	ret ; $20e4
RenderTextToTiles:
	push af ; $20e5
	push bc ; $20e6
	push de ; $20e7
	push hl ; $20e8
Label_00_20e9:
	ld a, [hl+] ; $20e9
	and a, a ; $20ea
	jr z, Label_00_210e ; $20eb
	sub a, $30 ; $20ed
	jr nc, Label_00_20f7 ; $20ef
	ld a, b ; $20f1
	add a, $06 ; $20f2
	ld b, a ; $20f4
	jr Label_00_20e9 ; $20f5
Label_00_20f7:
	push hl ; $20f7
	and a, $1f ; $20f8
	add a, a ; $20fa
	add a, $91 ; $20fb
	ld l, a ; $20fd
	adc a, $20 ; $20fe
	sub a, l ; $2100
	ld h, a ; $2101
	ld a, [hl+] ; $2102
	ld h, [hl] ; $2103
	ld l, a ; $2104
	call RenderGlyphToTiles ; $2105
	ld a, [hl] ; $2108
	add a, b ; $2109
	ld b, a ; $210a
	pop hl ; $210b
	jr Label_00_20e9 ; $210c
Label_00_210e:
	pop hl ; $210e
	pop de ; $210f
	pop bc ; $2110
	pop af ; $2111
	ret ; $2112
PixelMaskTable:
	INCBIN "data/bank_000/d_2113.bin" ; $2113, 8 bytes
RenderGlyphToTiles:
	push af ; $211b
	push bc ; $211c
	push de ; $211d
	push hl ; $211e
	ld a, [hl+] ; $211f
	ld [$c0f8], a ; $2120
	ld a, [hl+] ; $2123
	ld [$c0f9], a ; $2124
	push hl ; $2127
	ld a, b ; $2128
	and a, $07 ; $2129
	add a, $13 ; $212b
	ld l, a ; $212d
	adc a, $21 ; $212e
	sub a, l ; $2130
	ld h, a ; $2131
	ld a, [hl] ; $2132
	ld [$c0fa], a ; $2133
	ld a, b ; $2136
	and a, $f8 ; $2137
	ld l, a ; $2139
	ld h, $00 ; $213a
	add hl, hl ; $213c
	add hl, hl ; $213d
	ld b, $00 ; $213e
	sla c ; $2140
	add hl, bc ; $2142
	add hl, de ; $2143
	pop de ; $2144
	ld c, $80 ; $2145
Label_00_2147:
	push hl ; $2147
	ld a, [$c0fa] ; $2148
	ld b, a ; $214b
	ld a, [$c0f8] ; $214c
Label_00_214f:
	push af ; $214f
	ld a, [de] ; $2150
	and a, c ; $2151
	jr z, Label_00_2158 ; $2152
	ld a, b ; $2154
	or a, [hl] ; $2155
	jr Label_00_215b ; $2156
Label_00_2158:
	ld a, b ; $2158
	cpl ; $2159
	and a, [hl] ; $215a
Label_00_215b:
	ld [hl+], a ; $215b
	rrc c ; $215c
	ld a, [de] ; $215e
	and a, c ; $215f
	jr z, Label_00_2166 ; $2160
	ld a, b ; $2162
	or a, [hl] ; $2163
	jr Label_00_2169 ; $2164
Label_00_2166:
	ld a, b ; $2166
	cpl ; $2167
	and a, [hl] ; $2168
Label_00_2169:
	ld [hl-], a ; $2169
	rrc c ; $216a
	jr nc, Label_00_216f ; $216c
	inc de ; $216e
Label_00_216f:
	rrc b ; $216f
	jr nc, Label_00_217a ; $2171
	ld a, $20 ; $2173
	add a, l ; $2175
	ld l, a ; $2176
	jr nc, Label_00_217a ; $2177
	inc h ; $2179
Label_00_217a:
	pop af ; $217a
	dec a ; $217b
	jp nz, Label_00_214f ; $217c
	ld hl, $c0f9 ; $217f
	dec [hl] ; $2182
	pop hl ; $2183
	inc hl ; $2184
	inc hl ; $2185
	jr nz, Label_00_2147 ; $2186
	pop hl ; $2188
	pop de ; $2189
	pop bc ; $218a
	pop af ; $218b
	ret ; $218c
ProcessBGBlitQueue:
	xor a, a ; $218d
	ldh [hBGColumnBlitDone], a ; $218e
	ldh a, [hBGRowBlitPending] ; $2190
	or a, a ; $2192
	jr z, Label_00_21ca ; $2193
	ld a, $01 ; $2195
	ldh [rVBK], a ; $2197
	ld bc, $c300 ; $2199
	ld hl, wBGRowBlitDest ; $219c
	ld a, [hl+] ; $219f
	ld d, [hl] ; $21a0
	ld e, a ; $21a1
	ld a, $01 ; $21a2
	ld hl, rVDMA_SRC_HIGH ; $21a4
	ld [hl], b ; $21a7
	inc hl ; $21a8
	ld [hl], c ; $21a9
	inc hl ; $21aa
	ld [hl], d ; $21ab
	inc hl ; $21ac
	ld [hl], e ; $21ad
	inc hl ; $21ae
	ld [hl], a ; $21af
	xor a, a ; $21b0
	ldh [rVBK], a ; $21b1
	ld bc, $c340 ; $21b3
	ld hl, wBGRowBlitDest ; $21b6
	ld a, [hl+] ; $21b9
	ld d, [hl] ; $21ba
	ld e, a ; $21bb
	ld a, $01 ; $21bc
	ld hl, rVDMA_SRC_HIGH ; $21be
	ld [hl], b ; $21c1
	inc hl ; $21c2
	ld [hl], c ; $21c3
	inc hl ; $21c4
	ld [hl], d ; $21c5
	inc hl ; $21c6
	ld [hl], e ; $21c7
	inc hl ; $21c8
	ld [hl], a ; $21c9
Label_00_21ca:
	ldh a, [hBGColumnBlitPending] ; $21ca
	or a, a ; $21cc
	jr z, Label_00_2206 ; $21cd
	ld a, $01 ; $21cf
	ldh [hBGColumnBlitDone], a ; $21d1
	ldh [rVBK], a ; $21d3
	ld de, $c380 ; $21d5
	ld a, [wBGColumnBlitX] ; $21d8
	ld l, a ; $21db
	ld h, $98 ; $21dc
	ld b, $20 ; $21de
Label_00_21e0:
	ld a, [de] ; $21e0
	inc de ; $21e1
	ld [hl], a ; $21e2
	ld a, b ; $21e3
	ld bc, $0020 ; $21e4
	add hl, bc ; $21e7
	ld b, a ; $21e8
	dec b ; $21e9
	jr nz, Label_00_21e0 ; $21ea
	xor a, a ; $21ec
	ldh [rVBK], a ; $21ed
	ld de, $c3c0 ; $21ef
	ld a, [wBGColumnBlitX] ; $21f2
	ld l, a ; $21f5
	ld h, $98 ; $21f6
	ld b, $20 ; $21f8
Label_00_21fa:
	ld a, [de] ; $21fa
	inc de ; $21fb
	ld [hl], a ; $21fc
	ld a, b ; $21fd
	ld bc, $0020 ; $21fe
	add hl, bc ; $2201
	ld b, a ; $2202
	dec b ; $2203
	jr nz, Label_00_21fa ; $2204
Label_00_2206:
	xor a, a ; $2206
	ldh [hBGRowBlitPending], a ; $2207
	ldh [hBGColumnBlitPending], a ; $2209
	ldh a, [hBGColumnBlitDone] ; $220b
	ret ; $220d
GetMapBufferAddr64:
	ld a, [$c323] ; $220e
	add a, c ; $2211
	and a, $3f ; $2212
	ld h, $00 ; $2214
	ld l, a ; $2216
	add hl, hl ; $2217
	add hl, hl ; $2218
	add hl, hl ; $2219
	add hl, hl ; $221a
	add hl, hl ; $221b
	add hl, hl ; $221c
	ld a, [$c321] ; $221d
	add a, b ; $2220
	and a, $3f ; $2221
	ld d, $00 ; $2223
	ld e, a ; $2225
	add hl, de ; $2226
	ld de, $d000 ; $2227
	add hl, de ; $222a
	ret ; $222b
BlitBGRowFrom64:
	ld a, [$c323] ; $222c
	add a, c ; $222f
	and a, $1f ; $2230
	ld h, $00 ; $2232
	ld l, a ; $2234
	add hl, hl ; $2235
	add hl, hl ; $2236
	add hl, hl ; $2237
	add hl, hl ; $2238
	add hl, hl ; $2239
	ld de, $9800 ; $223a
	add hl, de ; $223d
	ld a, l ; $223e
	ld [wBGRowBlitDest], a ; $223f
	ld a, h ; $2242
	ld [$c327], a ; $2243
	ld a, [$c321] ; $2246
	add a, b ; $2249
	and a, $1f ; $224a
	ld h, $00 ; $224c
	ld l, a ; $224e
	ld de, $c300 ; $224f
	add hl, de ; $2252
	push hl ; $2253
	call GetMapBufferAddr64 ; $2254
	pop de ; $2257
	push hl ; $2258
	wram_bank $02 ; $2259
	ld c, $20 ; $225f
Label_00_2261:
	ld a, [hl+] ; $2261
	ld [de], a ; $2262
	ld a, l ; $2263
	and a, $3f ; $2264
	jr nz, Label_00_226e ; $2266
	ld a, c ; $2268
	ld bc, $ffc0 ; $2269
	add hl, bc ; $226c
	ld c, a ; $226d
Label_00_226e:
	inc e ; $226e
	res 5, e ; $226f
	dec c ; $2271
	jr nz, Label_00_2261 ; $2272
	pop hl ; $2274
	wram_bank $03 ; $2275
	ld bc, $4020 ; $227b
	ld a, e ; $227e
	add a, b ; $227f
	ld e, a ; $2280
Label_00_2281:
	ld a, [hl+] ; $2281
	ld [de], a ; $2282
	ld a, l ; $2283
	and a, $3f ; $2284
	jr nz, Label_00_228e ; $2286
	ld a, c ; $2288
	ld bc, $ffc0 ; $2289
	add hl, bc ; $228c
	ld c, a ; $228d
Label_00_228e:
	inc e ; $228e
	res 5, e ; $228f
	dec c ; $2291
	jr nz, Label_00_2281 ; $2292
	ld a, $01 ; $2294
	ldh [hBGRowBlitPending], a ; $2296
	ret ; $2298
BlitBGColumnFrom64:
	ld a, [$c321] ; $2299
	add a, b ; $229c
	and a, $1f ; $229d
	ld [wBGColumnBlitX], a ; $229f
	ld d, $00 ; $22a2
	ld e, a ; $22a4
	ld a, [$c323] ; $22a5
	add a, c ; $22a8
	and a, $1f ; $22a9
	ld h, $00 ; $22ab
	ld l, a ; $22ad
	ld de, $c380 ; $22ae
	add hl, de ; $22b1
	push hl ; $22b2
	call GetMapBufferAddr64 ; $22b3
	pop de ; $22b6
	push hl ; $22b7
	wram_bank $02 ; $22b8
	ld c, $20 ; $22be
Label_00_22c0:
	ld a, [hl] ; $22c0
	ld [de], a ; $22c1
	ld a, c ; $22c2
	ld bc, $0040 ; $22c3
	add hl, bc ; $22c6
	ld c, a ; $22c7
	res 5, h ; $22c8
	set 4, h ; $22ca
	inc e ; $22cc
	res 5, e ; $22cd
	dec c ; $22cf
	jr nz, Label_00_22c0 ; $22d0
	pop hl ; $22d2
	wram_bank $03 ; $22d3
	ld bc, $4020 ; $22d9
	ld a, e ; $22dc
	add a, b ; $22dd
	ld e, a ; $22de
Label_00_22df:
	ld a, [hl] ; $22df
	ld [de], a ; $22e0
	ld a, c ; $22e1
	ld bc, $0040 ; $22e2
	add hl, bc ; $22e5
	ld c, a ; $22e6
	res 5, h ; $22e7
	set 4, h ; $22e9
	inc e ; $22eb
	res 5, e ; $22ec
	dec c ; $22ee
	jr nz, Label_00_22df ; $22ef
	ld a, $01 ; $22f1
	ldh [hBGColumnBlitPending], a ; $22f3
	ret ; $22f5
GetScrollBufferAddr:
	ld a, [$c323] ; $22f6
	add a, c ; $22f9
	and a, $7f ; $22fa
	ld h, $00 ; $22fc
	ld l, a ; $22fe
	add hl, hl ; $22ff
	add hl, hl ; $2300
	add hl, hl ; $2301
	add hl, hl ; $2302
	add hl, hl ; $2303
	ld a, [$c321] ; $2304
	add a, b ; $2307
	and a, $1f ; $2308
	ld d, $00 ; $230a
	ld e, a ; $230c
	add hl, de ; $230d
	ld de, $d000 ; $230e
	add hl, de ; $2311
	ret ; $2312
BlitBGStrip:
	ld a, [$c323] ; $2313
	add a, c ; $2316
	and a, $1f ; $2317
	ld h, $00 ; $2319
	ld l, a ; $231b
	add hl, hl ; $231c
	add hl, hl ; $231d
	add hl, hl ; $231e
	add hl, hl ; $231f
	add hl, hl ; $2320
	ld de, $9800 ; $2321
	add hl, de ; $2324
	ld a, l ; $2325
	ld [wBGRowBlitDest], a ; $2326
	ld a, h ; $2329
	ld [$c327], a ; $232a
	ld a, [$c321] ; $232d
	add a, b ; $2330
	and a, $1f ; $2331
	ld h, $00 ; $2333
	ld l, a ; $2335
	ld de, $c300 ; $2336
	add hl, de ; $2339
	push hl ; $233a
	call GetScrollBufferAddr ; $233b
	pop de ; $233e
	push hl ; $233f
	wram_bank $02 ; $2340
	ld c, $20 ; $2346
Label_00_2348:
	ld a, [hl+] ; $2348
	ld [de], a ; $2349
	ld a, l ; $234a
	and a, $1f ; $234b
	jr nz, Label_00_2355 ; $234d
	ld a, c ; $234f
	ld bc, $ffe0 ; $2350
	add hl, bc ; $2353
	ld c, a ; $2354
Label_00_2355:
	inc e ; $2355
	res 5, e ; $2356
	dec c ; $2358
	jr nz, Label_00_2348 ; $2359
	pop hl ; $235b
	wram_bank $03 ; $235c
	ld bc, $4020 ; $2362
	ld a, e ; $2365
	add a, b ; $2366
	ld e, a ; $2367
Label_00_2368:
	ld a, [hl+] ; $2368
	ld [de], a ; $2369
	ld a, l ; $236a
	and a, $1f ; $236b
	jr nz, Label_00_2375 ; $236d
	ld a, c ; $236f
	ld bc, $ffe0 ; $2370
	add hl, bc ; $2373
	ld c, a ; $2374
Label_00_2375:
	inc e ; $2375
	res 5, e ; $2376
	dec c ; $2378
	jr nz, Label_00_2368 ; $2379
	ld a, $01 ; $237b
	ldh [hBGRowBlitPending], a ; $237d
	ret ; $237f
BlitBGStrip2:
	ld a, [$c321] ; $2380
	add a, b ; $2383
	and a, $1f ; $2384
	ld [wBGColumnBlitX], a ; $2386
	ld d, $00 ; $2389
	ld e, a ; $238b
	ld a, [$c323] ; $238c
	add a, c ; $238f
	and a, $1f ; $2390
	ld h, $00 ; $2392
	ld l, a ; $2394
	ld de, $c380 ; $2395
	add hl, de ; $2398
	push hl ; $2399
	call GetScrollBufferAddr ; $239a
	pop de ; $239d
	push hl ; $239e
	wram_bank $02 ; $239f
	ld c, $20 ; $23a5
Label_00_23a7:
	ld a, [hl] ; $23a7
	ld [de], a ; $23a8
	ld a, c ; $23a9
	ld bc, $0020 ; $23aa
	add hl, bc ; $23ad
	ld c, a ; $23ae
	res 5, h ; $23af
	set 4, h ; $23b1
	inc e ; $23b3
	res 5, e ; $23b4
	dec c ; $23b6
	jr nz, Label_00_23a7 ; $23b7
	pop hl ; $23b9
	wram_bank $03 ; $23ba
	ld bc, $4020 ; $23c0
	ld a, e ; $23c3
	add a, b ; $23c4
	ld e, a ; $23c5
Label_00_23c6:
	ld a, [hl] ; $23c6
	ld [de], a ; $23c7
	ld a, c ; $23c8
	ld bc, $0020 ; $23c9
	add hl, bc ; $23cc
	ld c, a ; $23cd
	res 5, h ; $23ce
	set 4, h ; $23d0
	inc e ; $23d2
	res 5, e ; $23d3
	dec c ; $23d5
	jr nz, Label_00_23c6 ; $23d6
	ld a, $01 ; $23d8
	ldh [hBGColumnBlitPending], a ; $23da
	ret ; $23dc
UpdateGameTimer:
	ld a, [$c0f4] ; $23dd
	cp a, $01 ; $23e0
	call z, TickSecondaryTimer ; $23e2
	ld hl, wGameTimer ; $23e5
	inc [hl] ; $23e8
	ld a, [hl] ; $23e9
	cp a, $3c ; $23ea
	ret c ; $23ec
	ld [hl], $00 ; $23ed
	inc hl ; $23ef
	inc [hl] ; $23f0
	ld a, [hl] ; $23f1
	cp a, $3c ; $23f2
	ret c ; $23f4
	ld [hl], $00 ; $23f5
	inc hl ; $23f7
	inc [hl] ; $23f8
	ld a, [hl] ; $23f9
	cp a, $3c ; $23fa
	ret c ; $23fc
	ld [hl], $00 ; $23fd
	inc hl ; $23ff
	inc [hl] ; $2400
	ld a, [hl] ; $2401
	cp a, $64 ; $2402
	ret c ; $2404
	dec [hl] ; $2405
	dec hl ; $2406
	ld [hl], $3b ; $2407
	ret ; $2409
	ld hl, $c0f5 ; $240a
	inc [hl] ; $240d
	ld a, [hl] ; $240e
	cp a, $3c ; $240f
	jr nz, Label_00_2422 ; $2411
	ld [hl], $00 ; $2413
	inc hl ; $2415
	sound $af ; $2416
	dec [hl] ; $2418
	ld a, [hl] ; $2419
	cp a, $ff ; $241a
	jr nz, Label_00_2422 ; $241c
	ld [hl], $3b ; $241e
	inc hl ; $2420
	dec [hl] ; $2421
Label_00_2422:
	ld hl, $c0f6 ; $2422
	ld a, [hl+] ; $2425
	or a, [hl] ; $2426
	ret nz ; $2427
	xor a, a ; $2428
	ld hl, $c0f4 ; $2429
	ld [hl], $ff ; $242c
	inc hl ; $242e
	ld [hl+], a ; $242f
	ld [hl+], a ; $2430
	ld [hl+], a ; $2431
	sound $b0 ; $2432
	ret ; $2434
TickSecondaryTimer:
	ld hl, $c0f5 ; $2435
	inc [hl] ; $2438
	ld a, [hl] ; $2439
	cp a, $3c ; $243a
	ret c ; $243c
	ld [hl], $00 ; $243d
	inc hl ; $243f
	inc [hl] ; $2440
	ld a, [hl] ; $2441
	cp a, $3c ; $2442
	ret c ; $2444
	ld [hl], $00 ; $2445
	inc hl ; $2447
	inc [hl] ; $2448
	ld a, [hl] ; $2449
	cp a, $0a ; $244a
	ret c ; $244c
	dec [hl] ; $244d
	dec hl ; $244e
	ld [hl], $3b ; $244f
	ret ; $2451
SaveGameTimer:
	push af ; $2452
	push de ; $2453
	push hl ; $2454
	ld hl, wGameTimer ; $2455
	ld de, $c88e ; $2458
	di ; $245b
	ld a, [hl+] ; $245c
	ld [de], a ; $245d
	inc de ; $245e
	ld a, [hl+] ; $245f
	ld [de], a ; $2460
	inc de ; $2461
	ld a, [hl+] ; $2462
	ld [de], a ; $2463
	inc de ; $2464
	ld a, [hl+] ; $2465
	ld [de], a ; $2466
	inc de ; $2467
	ei ; $2468
	pop hl ; $2469
	pop de ; $246a
	pop af ; $246b
	ret ; $246c
RestoreGameTimer:
	push af ; $246d
	push de ; $246e
	push hl ; $246f
	ld de, wGameTimer ; $2470
	ld hl, $c88e ; $2473
	di ; $2476
	ld a, [hl+] ; $2477
	ld [de], a ; $2478
	inc de ; $2479
	ld a, [hl+] ; $247a
	ld [de], a ; $247b
	inc de ; $247c
	ld a, [hl+] ; $247d
	ld [de], a ; $247e
	inc de ; $247f
	ld a, [hl+] ; $2480
	ld [de], a ; $2481
	inc de ; $2482
	ei ; $2483
	pop hl ; $2484
	pop de ; $2485
	pop af ; $2486
	ret ; $2487
ResetGameTimer:
	push af ; $2488
	push hl ; $2489
	ld hl, wGameTimer ; $248a
	xor a, a ; $248d
	di ; $248e
	ld [hl+], a ; $248f
	ld [hl+], a ; $2490
	ld [hl+], a ; $2491
	ld [hl], a ; $2492
	ei ; $2493
	pop hl ; $2494
	pop af ; $2495
	ret ; $2496
	INCBIN "data/bank_000/d_2497.bin" ; $2497, 8 bytes
TestGameFlag:
	push hl ; $249f
	push bc ; $24a0
	ld b, a ; $24a1
	ld a, e ; $24a2
	rlca ; $24a3
	rlca ; $24a4
	rlca ; $24a5
	add a, $97 ; $24a6
	ld l, a ; $24a8
	adc a, $24 ; $24a9
	sub a, l ; $24ab
	ld h, a ; $24ac
	ld a, [hl] ; $24ad
	ld hl, wGameFlags ; $24ae
	ld e, d ; $24b1
	ld d, $00 ; $24b2
	add hl, de ; $24b4
	and a, [hl] ; $24b5
	ld a, b ; $24b6
	pop bc ; $24b7
	pop hl ; $24b8
	ret ; $24b9
SetGameFlag:
	push hl ; $24ba
	push af ; $24bb
	ld a, e ; $24bc
	rlca ; $24bd
	rlca ; $24be
	rlca ; $24bf
	add a, $97 ; $24c0
	ld l, a ; $24c2
	adc a, $24 ; $24c3
	sub a, l ; $24c5
	ld h, a ; $24c6
	ld a, [hl] ; $24c7
	ld hl, wGameFlags ; $24c8
	ld e, d ; $24cb
	ld d, $00 ; $24cc
	add hl, de ; $24ce
	or a, [hl] ; $24cf
	ld [hl], a ; $24d0
	pop af ; $24d1
	pop hl ; $24d2
	ret ; $24d3
ClearGameFlag:
	push hl ; $24d4
	push af ; $24d5
	ld a, e ; $24d6
	rlca ; $24d7
	rlca ; $24d8
	rlca ; $24d9
	add a, $97 ; $24da
	ld l, a ; $24dc
	adc a, $24 ; $24dd
	sub a, l ; $24df
	ld h, a ; $24e0
	ld a, [hl] ; $24e1
	ld hl, wGameFlags ; $24e2
	ld e, d ; $24e5
	ld d, $00 ; $24e6
	add hl, de ; $24e8
	cpl ; $24e9
	and a, [hl] ; $24ea
	ld [hl], a ; $24eb
	pop af ; $24ec
	pop hl ; $24ed
	ret ; $24ee
TestGameFlagByNumber:
	push de ; $24ef
	sla e ; $24f0
	rl d ; $24f2
	sla e ; $24f4
	rl d ; $24f6
	sla e ; $24f8
	rl d ; $24fa
	sla e ; $24fc
	rl d ; $24fe
	sla e ; $2500
	rl d ; $2502
	call TestGameFlag ; $2504
	pop de ; $2507
	ret ; $2508
SetGameFlagByNumber:
	push de ; $2509
	sla e ; $250a
	rl d ; $250c
	sla e ; $250e
	rl d ; $2510
	sla e ; $2512
	rl d ; $2514
	sla e ; $2516
	rl d ; $2518
	sla e ; $251a
	rl d ; $251c
	call SetGameFlag ; $251e
	pop de ; $2521
	ret ; $2522
ClearGameFlagByNumber:
	push de ; $2523
	sla e ; $2524
	rl d ; $2526
	sla e ; $2528
	rl d ; $252a
	sla e ; $252c
	rl d ; $252e
	sla e ; $2530
	rl d ; $2532
	sla e ; $2534
	rl d ; $2536
	call ClearGameFlag ; $2538
	pop de ; $253b
	ret ; $253c
FetchInlineWordOperand:
	push bc ; $253d
	ld c, [hl] ; $253e
	inc hl ; $253f
	ld b, [hl] ; $2540
	dec hl ; $2541
	push hl ; $2542
	ld h, b ; $2543
	ld l, c ; $2544
	ld e, [hl] ; $2545
	inc hl ; $2546
	ld d, [hl] ; $2547
	inc hl ; $2548
	ld b, h ; $2549
	ld c, l ; $254a
	pop hl ; $254b
	ld [hl], c ; $254c
	inc hl ; $254d
	ld [hl], b ; $254e
	pop bc ; $254f
	ret ; $2550
TestGameFlagCmd:
	push de ; $2551
	push hl ; $2552
	ld hl, sp + 4 ; $2553
	call FetchInlineWordOperand ; $2555
	call TestGameFlag ; $2558
	pop hl ; $255b
	pop de ; $255c
	ret ; $255d
SetGameFlagCmd:
	push de ; $255e
	push hl ; $255f
	ld hl, sp + 4 ; $2560
	call FetchInlineWordOperand ; $2562
	call SetGameFlag ; $2565
	pop hl ; $2568
	pop de ; $2569
	ret ; $256a
ClearGameFlagCmd:
	push de ; $256b
	push hl ; $256c
	ld hl, sp + 4 ; $256d
	call FetchInlineWordOperand ; $256f
	call ClearGameFlag ; $2572
	pop hl ; $2575
	pop de ; $2576
	ret ; $2577
Start:
	and a, a ; $2578
	cp a, $11 ; $2579
	ld a, $00 ; $257b
	jr nz, Label_00_2580 ; $257d
	inc a ; $257f
Label_00_2580:
	ldh [hIsCGB], a ; $2580
SoftReset:
	ld sp, $d000 ; $2582
	call DisableLCDSafely ; $2585
	di ; $2588
	ld hl, $c000 ; $2589
	ld c, $ff ; $258c
	call ClearMemory16 ; $258e
	xor a, a ; $2591
	ld c, $80 ; $2592
	ld b, $70 ; $2594
Label_00_2596:
	ldh [c], a ; $2596
	inc c ; $2597
	dec b ; $2598
	jr nz, Label_00_2596 ; $2599
	ldh [rIF], a ; $259b
	ldh [rIE], a ; $259d
	ldh [rSCY], a ; $259f
	ldh [rSCX], a ; $25a1
	ldh [rSTAT], a ; $25a3
	ldh a, [hIsCGB] ; $25a5
	or a, a ; $25a7
	jr nz, Label_00_25ad ; $25a8
	farcall FarPtr_01_02 ; $25aa
Label_00_25ad:
	xor a, a ; $25ad
	ldh [rVBK], a ; $25ae
	ldh [rWBK], a ; $25b0
	ldh [rRP], a ; $25b2
	xor a, a ; $25b4
	ld [$0000], a ; $25b5
	call CopyOAMDMARoutineToHRAM ; $25b8
	call ClearVRAMBank ; $25bb
	xor a, a ; $25be
	ldh [hDebugStepMode], a ; $25bf
	call SwitchCPUSpeed ; $25c1
	ld a, $06 ; $25c4
	ldh [hInputRepeatDelay], a ; $25c6
	call ClearSpriteQueue ; $25c8
	call ClearFrameTasks ; $25cb
	call ClearVRAMCopyQueue ; $25ce
	ldh a, [hWramBank] ; $25d1
	push af ; $25d3
	wram_bank $07 ; $25d4
	ld hl, $d000 ; $25da
	ld c, $00 ; $25dd
	call ClearMemory16 ; $25df
	call InitAudioEngine ; $25e2
	pop af ; $25e5
	wram_bank ; $25e6
	ld a, $07 ; $25ea
	ldh [rWX], a ; $25ec
	ld a, $90 ; $25ee
	ldh [rWY], a ; $25f0
	ld hl, rTMA ; $25f2
	ld a, $77 ; $25f5
	ld [hl+], a ; $25f7
	xor a, a ; $25f8
	ld [hl], a ; $25f9
	set 2, [hl] ; $25fa
	ld a, $08 ; $25fc
	ldh [rSTAT], a ; $25fe
	ld a, $50 ; $2600
	ldh [rLYC], a ; $2602
	xor a, a ; $2604
	ldh [rSB], a ; $2605
	ld a, $02 ; $2607
	ldh [rSC], a ; $2609
	ld a, $82 ; $260b
	ldh [rSC], a ; $260d
	xor a, a ; $260f
	ldh [rIF], a ; $2610
	ld a, $0d ; $2612
	ldh [rIE], a ; $2614
	ld a, $e7 ; $2616
	ldh [rLCDC], a ; $2618
	ei ; $261a
	xor a, a ; $261b
	ldh [hPaletteDirtyFlags], a ; $261c
	ldh [hFadeState], a ; $261e
	ldh [hFadeSpeed], a ; $2620
	ldh [hFadeCounter], a ; $2622
	ld a, $c0 ; $2624
	ld [wSpriteBufferPage], a ; $2626
	call InitSerialLink ; $2629
	farcall FarPtr_01_00 ; $262c
	stop ; $262f
AdvanceFrame:
	push af ; $2631
	push bc ; $2632
	push de ; $2633
	push hl ; $2634
	ldh a, [$ffc8] ; $2635
	or a, a ; $2637
	jr z, Label_00_2641 ; $2638
	ldh a, [$ffc3] ; $263a
	and a, $e0 ; $263c
	jp nz, LinkErrorReset ; $263e
Label_00_2641:
	ldh a, [rVBK] ; $2641
	push af ; $2643
	xor a, a ; $2644
	ldh [hVBlankOccurred], a ; $2645
	xor a, a ; $2647
	call RunFrameTasks ; $2648
	ld a, [wSpriteBufferPage] ; $264b
	and a, $cf ; $264e
	xor a, $05 ; $2650
	ld [wSpriteBufferPage], a ; $2652
	ldh a, [hWramBank] ; $2655
	push af ; $2657
	wram_bank $07 ; $2658
	call ResumeBGMAfterJingle ; $265e
	pop af ; $2661
	wram_bank ; $2662
	ldh a, [rLY] ; $2666
	ld l, a ; $2668
	ldh a, [hPeakLY] ; $2669
	ld h, a ; $266b
	cp a, l ; $266c
	jr c, Label_00_2676 ; $266d
	ldh a, [hPeakLYFrames] ; $266f
	dec a ; $2671
	ldh [hPeakLYFrames], a ; $2672
	jr nz, Label_00_267e ; $2674
Label_00_2676:
	ld a, l ; $2676
	ld h, l ; $2677
	ldh [hPeakLY], a ; $2678
	ld a, $0f ; $267a
	ldh [hPeakLYFrames], a ; $267c
Label_00_267e:
	ld de, $c0fb ; $267e
	call FormatHexWord ; $2681
	ldh a, [hDebugStepMode] ; $2684
	or a, a ; $2686
	jp z, Label_00_26f3 ; $2687
	ldh a, [$ffd8] ; $268a
	or a, a ; $268c
	jr nz, Label_00_269d ; $268d
	ldh a, [hPlayerInputFlags] ; $268f
	and a, $0c ; $2691
	cp a, $0c ; $2693
	jr nz, Label_00_269d ; $2695
	ld a, $01 ; $2697
	ldh [$ff9a], a ; $2699
	jr Label_00_26a2 ; $269b
Label_00_269d:
	ldh a, [$ff9a] ; $269d
	or a, a ; $269f
	jr z, Label_00_26f3 ; $26a0
Label_00_26a2:
	ldh a, [hInputRisingEdge] ; $26a2
	bit 2, a ; $26a4
	jr z, Label_00_26b5 ; $26a6
	ldh a, [hDebugStepMode] ; $26a8
	inc a ; $26aa
	cp a, $04 ; $26ab
	jr c, Label_00_26b1 ; $26ad
	ld a, $01 ; $26af
Label_00_26b1:
	ldh [hDebugStepMode], a ; $26b1
	jr Label_00_26c4 ; $26b3
Label_00_26b5:
	ldh a, [hPlayerInputFlags] ; $26b5
	bit 3, a ; $26b7
	jr z, Label_00_26c4 ; $26b9
	bit 2, a ; $26bb
	jr nz, Label_00_26c4 ; $26bd
	xor a, a ; $26bf
	ldh [$ff9a], a ; $26c0
	jr Label_00_26f3 ; $26c2
Label_00_26c4:
	ldh a, [hInputPressed] ; $26c4
	and a, $f3 ; $26c6
	jr nz, Label_00_26f3 ; $26c8
	ldh a, [$ffd8] ; $26ca
	or a, a ; $26cc
	jr z, Label_00_26d7 ; $26cd
	ldh a, [$ffc2] ; $26cf
	cp a, $02 ; $26d1
	jr z, Label_00_26f0 ; $26d3
	jr Label_00_26e2 ; $26d5
Label_00_26d7:
	ei ; $26d7
	halt ; $26d8
	nop ; $26d9
	di ; $26da
	ldh a, [hVBlankOccurred] ; $26db
	and a, a ; $26dd
	jr z, Label_00_26d7 ; $26de
	jr Label_00_26f0 ; $26e0
Label_00_26e2:
	ei ; $26e2
	nop ; $26e3
	di ; $26e4
	ldh a, [hVBlankOccurred] ; $26e5
	ld b, a ; $26e7
	ldh a, [$ffd7] ; $26e8
	and a, b ; $26ea
	jr z, Label_00_26e2 ; $26eb
	xor a, a ; $26ed
	ldh [$ffd7], a ; $26ee
Label_00_26f0:
	ei ; $26f0
	jr Label_00_26a2 ; $26f1
Label_00_26f3:
	ldh a, [$ffd8] ; $26f3
	or a, a ; $26f5
	jr z, Label_00_2700 ; $26f6
	ldh a, [$ffc2] ; $26f8
	cp a, $02 ; $26fa
	jr z, Label_00_2719 ; $26fc
	jr Label_00_270b ; $26fe
Label_00_2700:
	halt ; $2700
	nop ; $2701
	di ; $2702
	ldh a, [hVBlankOccurred] ; $2703
	and a, a ; $2705
	jr nz, Label_00_2719 ; $2706
	ei ; $2708
	jr Label_00_2700 ; $2709
Label_00_270b:
	ei ; $270b
	nop ; $270c
	di ; $270d
	ldh a, [hVBlankOccurred] ; $270e
	ld b, a ; $2710
	ldh a, [$ffd7] ; $2711
	and a, b ; $2713
	jr z, Label_00_270b ; $2714
	xor a, a ; $2716
	ldh [$ffd7], a ; $2717
Label_00_2719:
	ei ; $2719
	pop af ; $271a
	ldh [rVBK], a ; $271b
	call ClearUnusedSprites ; $271d
	pop hl ; $2720
	pop de ; $2721
	pop bc ; $2722
	pop af ; $2723
	ret ; $2724
WaitFramesCmd:
	push bc ; $2725
	push de ; $2726
	push hl ; $2727
	ld hl, sp + 6 ; $2728
	ld e, [hl] ; $272a
	inc hl ; $272b
	ld d, [hl] ; $272c
	dec hl ; $272d
	push hl ; $272e
	ld h, d ; $272f
	ld l, e ; $2730
	ld c, [hl] ; $2731
	inc hl ; $2732
	ld d, h ; $2733
	ld e, l ; $2734
	pop hl ; $2735
	ld [hl], e ; $2736
	inc hl ; $2737
	ld [hl], d ; $2738
	pop hl ; $2739
	pop de ; $273a
	call WaitFrames ; $273b
	pop bc ; $273e
	ret ; $273f
WaitFrames:
	push af ; $2740
Label_00_2741:
	call AdvanceFrame ; $2741
	dec c ; $2744
	jr nz, Label_00_2741 ; $2745
	pop af ; $2747
	ret ; $2748
VBlankHandler:
	push af ; $2749
	ldh a, [$ffe7] ; $274a
	or a, a ; $274c
	jp nz, Label_00_27d5 ; $274d
	push bc ; $2750
	push de ; $2751
	push hl ; $2752
	ldh a, [rVBK] ; $2753
	push af ; $2755
	call ApplyPendingPaletteUpdates ; $2756
	ldh a, [hVBlankOccurred] ; $2759
	or a, a ; $275b
	jr nz, Label_00_27b1 ; $275c
	ldh a, [hShowDebugConsole] ; $275e
	or a, a ; $2760
	jr nz, Label_00_2773 ; $2761
	ldh a, [hScrollX] ; $2763
	ldh [rSCX], a ; $2765
	ldh a, [hScrollY] ; $2767
	ldh [rSCY], a ; $2769
	ldh a, [rLCDC] ; $276b
	and a, $f7 ; $276d
	ldh [rLCDC], a ; $276f
	jr Label_00_278e ; $2771
Label_00_2773:
	cp a, $01 ; $2773
	jr nz, Label_00_2786 ; $2775
	xor a, a ; $2777
	ldh [rSCX], a ; $2778
	ld a, $40 ; $277a
	ldh [rSCY], a ; $277c
	ldh a, [rLCDC] ; $277e
	or a, $08 ; $2780
	ldh [rLCDC], a ; $2782
	jr Label_00_278e ; $2784
Label_00_2786:
	ldh a, [hScrollX] ; $2786
	ldh [rSCX], a ; $2788
	ldh a, [hScrollY] ; $278a
	ldh [rSCY], a ; $278c
Label_00_278e:
	ld a, [wSpriteBufferPage] ; $278e
	xor a, $05 ; $2791
	ldh [$ff81], a ; $2793
	call $ff80 ; $2795
	call ProcessBGBlitQueue ; $2798
	or a, a ; $279b
	jr nz, Label_00_27a1 ; $279c
	call ProcessVRAMCopyQueues ; $279e
Label_00_27a1:
	ldh a, [hDebugStepMode] ; $27a1
	or a, a ; $27a3
	jr z, Label_00_27a9 ; $27a4
	call UpdateDebugOverlay ; $27a6
Label_00_27a9:
	ld a, $01 ; $27a9
	ldh [hVBlankOccurred], a ; $27ab
	ld hl, hVBlankCounter ; $27ad
	inc [hl] ; $27b0
Label_00_27b1:
	ldh a, [$ffd8] ; $27b1
	or a, a ; $27b3
	jr nz, Label_00_27c3 ; $27b4
	call ReadJoypad ; $27b6
	ldh a, [hPlayerInputFlags] ; $27b9
	cp a, $0f ; $27bb
	jp z, SoftReset ; $27bd
	call AdvanceRandomSeed ; $27c0
Label_00_27c3:
	call UpdateGameTimer ; $27c3
	call UpdateFadeOut ; $27c6
	call UpdateFadeIn ; $27c9
	call UpdateSoundEngine ; $27cc
	pop af ; $27cf
	ldh [rVBK], a ; $27d0
	pop hl ; $27d2
	pop de ; $27d3
	pop bc ; $27d4
Label_00_27d5:
	pop af ; $27d5
	reti ; $27d6
TimerHandler:
	push af ; $27d7
	ldh a, [$ffc2] ; $27d8
	cp a, $02 ; $27da
	jr nz, Label_00_27e4 ; $27dc
	ldh a, [rIF] ; $27de
	and a, $08 ; $27e0
	jr nz, Label_00_27f3 ; $27e2
Label_00_27e4:
	ldh a, [rLCDC] ; $27e4
	bit 7, a ; $27e6
	jr nz, Label_00_27f3 ; $27e8
	push bc ; $27ea
	push de ; $27eb
	push hl ; $27ec
	call UpdateSoundEngine ; $27ed
	pop hl ; $27f0
	pop de ; $27f1
	pop bc ; $27f2
Label_00_27f3:
	pop af ; $27f3
	reti ; $27f4
LCDStatHandler:
	push af ; $27f5
	push bc ; $27f6
	ld a, [$cb02] ; $27f7
	ld b, a ; $27fa
	ldh a, [rLY] ; $27fb
	cp a, b ; $27fd
	jr c, Label_00_2811 ; $27fe
	ld a, [$cb01] ; $2800
	ldh [rSCX], a ; $2803
	ld a, [$cb03] ; $2805
	ld b, a ; $2808
	ldh a, [rLY] ; $2809
	cp a, b ; $280b
	jr c, Label_00_2811 ; $280c
	xor a, a ; $280e
	ldh [rSCX], a ; $280f
Label_00_2811:
	pop bc ; $2811
	pop af ; $2812
	reti ; $2813
WaitVBlank:
	xor a, a ; $2814
	ldh [hVBlankOccurred], a ; $2815
Label_00_2817:
	ei ; $2817
	nop ; $2818
	di ; $2819
	ldh a, [hVBlankOccurred] ; $281a
	and a, a ; $281c
	jr z, Label_00_2817 ; $281d
	ei ; $281f
	ret ; $2820
ShortDelay:
	push af ; $2821
	push bc ; $2822
	ld bc, $007d ; $2823
Label_00_2826:
	dec bc ; $2826
	ld a, c ; $2827
	or a, b ; $2828
	jr nz, Label_00_2826 ; $2829
	pop bc ; $282b
	pop af ; $282c
	ret ; $282d
WaitSerialTransfer:
	push bc ; $282e
	ld bc, $c350 ; $282f
Label_00_2832:
	ei ; $2832
	nop ; $2833
	di ; $2834
	ldh a, [$ffd7] ; $2835
	and a, a ; $2837
	jr nz, Label_00_2843 ; $2838
	dec bc ; $283a
	ld a, b ; $283b
	or a, c ; $283c
	jr nz, Label_00_2832 ; $283d
	ei ; $283f
	scf ; $2840
	jr Label_00_2848 ; $2841
Label_00_2843:
	xor a, a ; $2843
	ldh [$ffd7], a ; $2844
	scf ; $2846
	ccf ; $2847
Label_00_2848:
	ei ; $2848
	pop bc ; $2849
	ret ; $284a
LinkErrorReset:
	farcall FarPtr_3e_12 ; $284b
	jp SoftReset ; $284e
Func_00_2851:
	call ReadJoypad ; $2851
	ret ; $2854
Func_00_2855:
	xor a, $0f ; $2855
	jr nz, Label_00_285c ; $2857
	jp SoftReset ; $2859
Label_00_285c:
	ret ; $285c
Func_00_285d:
	jp SoftReset ; $285d
	ret ; $2860
SerialHandler:
	push af ; $2861
	push bc ; $2862
	push de ; $2863
	push hl ; $2864
	ldh a, [$ffe1] ; $2865
	add a, a ; $2867
	jr c, Label_00_286f ; $2868
	ldh a, [rSB] ; $286a
	ld b, a ; $286c
	ldh [$ffc0], a ; $286d
Label_00_286f:
	ldh a, [$ffc2] ; $286f
	cp a, $01 ; $2871
	jr nz, Label_00_287c ; $2873
	ldh [$ffd7], a ; $2875
	pop hl ; $2877
	pop de ; $2878
	pop bc ; $2879
	pop af ; $287a
	reti ; $287b
Label_00_287c:
	ldh a, [$ffdf] ; $287c
	or a, a ; $287e
	jr z, Label_00_2891 ; $287f
	ldh a, [$ffe0] ; $2881
	or a, a ; $2883
	jr z, Label_00_288b ; $2884
	xor a, a ; $2886
	ldh [$ffe0], a ; $2887
	jr Label_00_2891 ; $2889
Label_00_288b:
	ldh a, [$ffe1] ; $288b
	ld a, $40 ; $288d
	ldh [$ffe1], a ; $288f
Label_00_2891:
	ldh a, [$ffe1] ; $2891
	add a, a ; $2893
	ldh [$ffe1], a ; $2894
	jr c, Label_00_289c ; $2896
	ld a, $01 ; $2898
	ldh [$ffd7], a ; $289a
Label_00_289c:
	pop hl ; $289c
	pop de ; $289d
	pop bc ; $289e
	ldh a, [$ffc1] ; $289f
	ldh [rSB], a ; $28a1
	push af ; $28a3
	ld a, $02 ; $28a4
	ldh [rSC], a ; $28a6
	ld a, $82 ; $28a8
	ldh [rSC], a ; $28aa
	pop af ; $28ac
	pop af ; $28ad
	reti ; $28ae
IncrementLinkFrameCounter:
	ldh a, [$ffc8] ; $28af
	inc a ; $28b1
	cp a, $08 ; $28b2
	jr z, Label_00_28b8 ; $28b4
	ldh [$ffc8], a ; $28b6
Label_00_28b8:
	ret ; $28b8
InitSerialLink:
	ld a, $c0 ; $28b9
	ldh [rSB], a ; $28bb
	xor a, a ; $28bd
	ldh [$ffc0], a ; $28be
	ld a, $c0 ; $28c0
	ldh [$ffc1], a ; $28c2
	ld a, $02 ; $28c4
	ldh [rSC], a ; $28c6
	ld a, $82 ; $28c8
	ldh [rSC], a ; $28ca
	xor a, a ; $28cc
	ldh [$ffc2], a ; $28cd
	ldh [$ffc3], a ; $28cf
	ldh [$ffc4], a ; $28d1
	ldh [$ffc8], a ; $28d3
	ldh [$ffd3], a ; $28d5
	ldh [$ffd4], a ; $28d7
	ldh [$ffd5], a ; $28d9
	ldh [$ffd6], a ; $28db
	ldh [$ffd7], a ; $28dd
	ldh [$ffd8], a ; $28df
	ldh [$ffdc], a ; $28e1
	ldh [$ffd9], a ; $28e3
	ldh [$ffda], a ; $28e5
	ldh [$ffdb], a ; $28e7
	ldh [$ffdd], a ; $28e9
	ldh [$ffde], a ; $28eb
	ldh [$ffdf], a ; $28ed
	ldh [$ffe1], a ; $28ef
	ldh [$ffe2], a ; $28f1
	ldh [$ffe7], a ; $28f3
	ldh [$ffe9], a ; $28f5
	ret ; $28f7
ResetSerialState:
	xor a, a ; $28f8
	ldh [$ffc0], a ; $28f9
	ldh [$ffc1], a ; $28fb
	ldh [$ffc3], a ; $28fd
	ldh [$ffc4], a ; $28ff
	ldh [$ffc8], a ; $2901
	ldh [$ffd3], a ; $2903
	ldh [$ffd4], a ; $2905
	ldh [$ffd5], a ; $2907
	ldh [$ffd6], a ; $2909
	ldh [$ffd7], a ; $290b
	ldh [$ffdc], a ; $290d
	ldh [$ffd9], a ; $290f
	ldh [$ffda], a ; $2911
	ldh [$ffdb], a ; $2913
	ldh [$ffdd], a ; $2915
	ldh [$ffde], a ; $2917
	ldh [$ffe1], a ; $2919
	ldh [$ffdf], a ; $291b
	ldh [$ffe2], a ; $291d
	ldh [$ffe7], a ; $291f
	ldh [$ffe9], a ; $2921
	ret ; $2923
SerialEncodeInput:
	push bc ; $2924
	push hl ; $2925
	ldh a, [$ffd6] ; $2926
	ld b, a ; $2928
	and a, $0f ; $2929
	cp a, $0f ; $292b
	jr nz, Label_00_2935 ; $292d
	ld a, $3f ; $292f
	ld b, $0f ; $2931
	jr Label_00_2958 ; $2933
Label_00_2935:
	bit 3, a ; $2935
	jr z, Label_00_293f ; $2937
	ld a, $30 ; $2939
	ld b, $08 ; $293b
	jr Label_00_2958 ; $293d
Label_00_293f:
	bit 2, a ; $293f
	jr z, Label_00_2949 ; $2941
	ld a, $0c ; $2943
	ld b, $04 ; $2945
	jr Label_00_2958 ; $2947
Label_00_2949:
	and a, $03 ; $2949
	ld c, a ; $294b
	ld a, b ; $294c
	rra ; $294d
	rra ; $294e
	and a, $3c ; $294f
	or a, c ; $2951
	push af ; $2952
	ld a, b ; $2953
	and a, $f3 ; $2954
	ld b, a ; $2956
	pop af ; $2957
Label_00_2958:
	ld c, a ; $2958
	ld a, b ; $2959
	ldh [$ffd6], a ; $295a
	ldh a, [$ffc2] ; $295c
	cp a, $01 ; $295e
	jr z, Label_00_2974 ; $2960
	cp a, $02 ; $2962
	jr z, Label_00_2974 ; $2964
	sound $72 ; $2966
	xor a, a ; $2968
	ldh [$ffd5], a ; $2969
	ldh [$ffd6], a ; $296b
	ld a, $c0 ; $296d
	ldh [$ffc1], a ; $296f
	call LinkErrorReset ; $2971
Label_00_2974:
	ldh a, [$ffdf] ; $2974
	or a, a ; $2976
	jr z, Label_00_2988 ; $2977
	ldh a, [$ffc2] ; $2979
	cp a, $02 ; $297b
	jr nz, Label_00_2988 ; $297d
Label_00_297f:
	ei ; $297f
	nop ; $2980
	nop ; $2981
	di ; $2982
	ldh a, [$ffe0] ; $2983
	or a, a ; $2985
	jr nz, Label_00_297f ; $2986
Label_00_2988:
	ldh a, [$ffdc] ; $2988
	or a, c ; $298a
	di ; $298b
	ldh [$ffc1], a ; $298c
	ldh [$ffe0], a ; $298e
	ei ; $2990
	pop hl ; $2991
	pop bc ; $2992
	ret ; $2993
SerialDecodeInput:
	push af ; $2994
	push bc ; $2995
	ldh a, [$ffc0] ; $2996
	ld b, a ; $2998
	and a, $c0 ; $2999
	cp a, $80 ; $299b
	jr z, Label_00_29aa ; $299d
	cp a, $40 ; $299f
	jr z, Label_00_29aa ; $29a1
	sound $72 ; $29a3
	xor a, a ; $29a5
	ldh [$ffd3], a ; $29a6
	jr Label_00_29f3 ; $29a8
Label_00_29aa:
	ld a, b ; $29aa
	and a, $3f ; $29ab
	cp a, $3f ; $29ad
	jr nz, Label_00_29b5 ; $29af
	ld a, $0f ; $29b1
	jr Label_00_29cf ; $29b3
Label_00_29b5:
	cp a, $30 ; $29b5
	jr nz, Label_00_29bd ; $29b7
	ld a, $08 ; $29b9
	jr Label_00_29cf ; $29bb
Label_00_29bd:
	cp a, $0c ; $29bd
	jr nz, Label_00_29c5 ; $29bf
	ld a, $04 ; $29c1
	jr Label_00_29cf ; $29c3
Label_00_29c5:
	ld c, a ; $29c5
	and a, $03 ; $29c6
	ld b, a ; $29c8
	ld a, c ; $29c9
	rla ; $29ca
	rla ; $29cb
	and a, $f0 ; $29cc
	or a, b ; $29ce
Label_00_29cf:
	ldh [$ffd4], a ; $29cf
	ldh a, [$ffc2] ; $29d1
	cp a, $01 ; $29d3
	jr nz, Label_00_29e0 ; $29d5
	ldh a, [$ffd5] ; $29d7
	or a, a ; $29d9
	jr nz, Label_00_29f1 ; $29da
	ldh a, [$ffd4] ; $29dc
	jr Label_00_29f1 ; $29de
Label_00_29e0:
	ldh a, [$ffd5] ; $29e0
	ld b, a ; $29e2
	ldh a, [$ffde] ; $29e3
	ldh [$ffd5], a ; $29e5
	ld a, b ; $29e7
	ldh [$ffde], a ; $29e8
	ldh a, [$ffd4] ; $29ea
	or a, a ; $29ec
	jr nz, Label_00_29f1 ; $29ed
	ldh a, [$ffd5] ; $29ef
Label_00_29f1:
	ldh [$ffd3], a ; $29f1
Label_00_29f3:
	pop bc ; $29f3
	pop af ; $29f4
	ret ; $29f5
	di ; $29f6
	xor a, a ; $29f7
	ldh [rIF], a ; $29f8
	ldh a, [rIE] ; $29fa
	or a, $08 ; $29fc
	ldh [rIE], a ; $29fe
	ei ; $2a00
	ret ; $2a01
	di ; $2a02
	xor a, a ; $2a03
	ldh [rIF], a ; $2a04
	ldh a, [rIE] ; $2a06
	or a, $01 ; $2a08
	ldh [rIE], a ; $2a0a
	ei ; $2a0c
	ret ; $2a0d
EnableTimerInterrupt:
	di ; $2a0e
	xor a, a ; $2a0f
	ldh [rIF], a ; $2a10
	ldh a, [rIE] ; $2a12
	or a, $04 ; $2a14
	ldh [rIE], a ; $2a16
	ei ; $2a18
	ret ; $2a19
	di ; $2a1a
	xor a, a ; $2a1b
	ldh [rIF], a ; $2a1c
	ld a, $0d ; $2a1e
	ldh [rIE], a ; $2a20
	ei ; $2a22
	ret ; $2a23
	di ; $2a24
	xor a, a ; $2a25
	ldh [rIF], a ; $2a26
	ld a, $09 ; $2a28
	ldh [rIE], a ; $2a2a
	ei ; $2a2c
	ret ; $2a2d
	push af ; $2a2e
	ld [$c3a4], a ; $2a2f
	ld a, c ; $2a32
	ld [$c3a5], a ; $2a33
	ld a, l ; $2a36
	ld [$c3a0], a ; $2a37
	ld a, h ; $2a3a
	ld [$c3a1], a ; $2a3b
	ld a, e ; $2a3e
	ld [$c3a2], a ; $2a3f
	ld a, d ; $2a42
	ld [$c3a3], a ; $2a43
	xor a, a ; $2a46
	ld [$c3a6], a ; $2a47
	ld a, $05 ; $2a4a
	ld hl, $2a54 ; $2a4c
	call RegisterFrameTask ; $2a4f
	pop af ; $2a52
	ret ; $2a53
	push af ; $2a54
	push bc ; $2a55
	push de ; $2a56
	push hl ; $2a57
	ldh a, [hWramBank] ; $2a58
	push af ; $2a5a
	ld a, [$c3a4] ; $2a5b
	wram_bank ; $2a5e
	ld a, [$c3a6] ; $2a62
	and a, $0f ; $2a65
	jr z, Label_00_2a79 ; $2a67
	ld hl, $c3a0 ; $2a69
	ld a, [hl+] ; $2a6c
	ld h, [hl] ; $2a6d
	ld l, a ; $2a6e
	ld de, $9800 ; $2a6f
	ld a, [$c3a5] ; $2a72
	ld c, a ; $2a75
	call QueueVRAMCopy ; $2a76
Label_00_2a79:
	ld a, [$c3a6] ; $2a79
	and a, $f0 ; $2a7c
	jr z, Label_00_2a90 ; $2a7e
	ld hl, $c3a2 ; $2a80
	ld a, [hl+] ; $2a83
	ld h, [hl] ; $2a84
	ld l, a ; $2a85
	ld de, $b800 ; $2a86
	ld a, [$c3a5] ; $2a89
	ld c, a ; $2a8c
	call QueueVRAMCopy ; $2a8d
Label_00_2a90:
	xor a, a ; $2a90
	ld [$c3a6], a ; $2a91
	pop af ; $2a94
	wram_bank ; $2a95
	pop hl ; $2a99
	pop de ; $2a9a
	pop bc ; $2a9b
	pop af ; $2a9c
	ret ; $2a9d
Func_00_2a9e:
	push bc ; $2a9e
	ld c, $11 ; $2a9f
	farcall FarPtr_05_1c ; $2aa1
	pop bc ; $2aa4
	ret ; $2aa5
CopyTextString:
	push af ; $2aa6
	push bc ; $2aa7
	push hl ; $2aa8
Label_00_2aa9:
	ld a, [hl+] ; $2aa9
	cp a, $00 ; $2aaa
	jr z, Label_00_2acc ; $2aac
	cp a, $de ; $2aae
	jr z, Label_00_2aba ; $2ab0
	cp a, $df ; $2ab2
	jr z, Label_00_2aba ; $2ab4
	ld [de], a ; $2ab6
	inc de ; $2ab7
	jr Label_00_2aa9 ; $2ab8
Label_00_2aba:
	push hl ; $2aba
	ld b, a ; $2abb
	ld hl, $ffdf ; $2abc
	add hl, de ; $2abf
	ld a, [hl] ; $2ac0
	cp a, $03 ; $2ac1
	ld a, b ; $2ac3
	jr nz, Label_00_2ac8 ; $2ac4
	sub a, $d0 ; $2ac6
Label_00_2ac8:
	ld [hl], a ; $2ac8
	pop hl ; $2ac9
	jr Label_00_2aa9 ; $2aca
Label_00_2acc:
	pop hl ; $2acc
	pop bc ; $2acd
	pop af ; $2ace
	ret ; $2acf
	ld [de], a ; $2ad0
	inc de ; $2ad1
	ret ; $2ad2
DrawHexWord:
	push af ; $2ad3
	push bc ; $2ad4
	push hl ; $2ad5
	add sp, -10 ; $2ad6
	push de ; $2ad8
	ld c, l ; $2ad9
	ld b, h ; $2ada
	ld hl, sp + 2 ; $2adb
	ld e, l ; $2add
	ld d, h ; $2ade
	ld l, c ; $2adf
	ld h, b ; $2ae0
	ld c, e ; $2ae1
	ld b, d ; $2ae2
	call FormatHexWord ; $2ae3
	ld l, c ; $2ae6
	ld h, b ; $2ae7
	pop de ; $2ae8
	call CopyTextString ; $2ae9
	add sp, 10 ; $2aec
	pop hl ; $2aee
	pop bc ; $2aef
	pop af ; $2af0
	ret ; $2af1
DrawDecimalWord:
	push af ; $2af2
	push bc ; $2af3
	push hl ; $2af4
	add sp, -10 ; $2af5
	push de ; $2af7
	ld c, l ; $2af8
	ld b, h ; $2af9
	ld hl, sp + 2 ; $2afa
	ld e, l ; $2afc
	ld d, h ; $2afd
	ld l, c ; $2afe
	ld h, b ; $2aff
	ld c, e ; $2b00
	ld b, d ; $2b01
	call FormatDecimalNumber ; $2b02
	ld l, c ; $2b05
	ld h, b ; $2b06
	pop de ; $2b07
	call CopyTextString ; $2b08
	add sp, 10 ; $2b0b
	pop hl ; $2b0d
	pop bc ; $2b0e
	pop af ; $2b0f
	ret ; $2b10
	ld l, a ; $2b11
	ld h, $00 ; $2b12
	ld a, $01 ; $2b14
	jr DrawDecimalWord ; $2b16
	ld l, a ; $2b18
	ld h, $00 ; $2b19
	ld a, $02 ; $2b1b
	jr DrawDecimalWord ; $2b1d
	ld l, a ; $2b1f
	ld h, $00 ; $2b20
	ld a, $03 ; $2b22
	jr DrawDecimalWord ; $2b24
	push af ; $2b26
	push hl ; $2b27
	call Func_00_2b34 ; $2b28
	call Func_00_2b34 ; $2b2b
	call Func_00_2b34 ; $2b2e
	pop hl ; $2b31
	pop af ; $2b32
	ret ; $2b33
Func_00_2b34:
	push hl ; $2b34
	ld a, [hl+] ; $2b35
	ld h, [hl] ; $2b36
	ld l, a ; $2b37
	sra h ; $2b38
	rr l ; $2b3a
	ld a, $04 ; $2b3c
	call DrawDecimalWord ; $2b3e
	inc de ; $2b41
	pop hl ; $2b42
	inc hl ; $2b43
	inc hl ; $2b44
	ret ; $2b45
CopyTextRect:
	push bc ; $2b46
	push de ; $2b47
Label_00_2b48:
	ld a, [hl+] ; $2b48
	and a, a ; $2b49
	ld [de], a ; $2b4a
	inc de ; $2b4b
	dec b ; $2b4c
	jr nz, Label_00_2b48 ; $2b4d
	pop de ; $2b4f
	pop bc ; $2b50
	ld a, $20 ; $2b51
	add a, e ; $2b53
	ld e, a ; $2b54
	jr nc, Label_00_2b58 ; $2b55
	inc d ; $2b57
Label_00_2b58:
	dec c ; $2b58
	jr nz, CopyTextRect ; $2b59
	ret ; $2b5b
DrawWindowFramePriority:
	ld a, $80 ; $2b5c
	ld [wWindowFrameAttr], a ; $2b5e
	jr DrawWindowFrame ; $2b61
DrawWindowFrameNoPriority:
	ld a, $00 ; $2b63
	ld [wWindowFrameAttr], a ; $2b65
DrawWindowFrame:
	push af ; $2b68
	push bc ; $2b69
	push de ; $2b6a
	push hl ; $2b6b
	push hl ; $2b6c
	ld l, e ; $2b6d
	ld h, d ; $2b6e
	ld e, c ; $2b6f
	ld d, b ; $2b70
	pop bc ; $2b71
	push bc ; $2b72
	push de ; $2b73
	push hl ; $2b74
Label_00_2b75:
	push bc ; $2b75
	push de ; $2b76
	push hl ; $2b77
Label_00_2b78:
	ld a, $20 ; $2b78
	ld [hl+], a ; $2b7a
	ld a, [wWindowFrameAttr] ; $2b7b
	ld [de], a ; $2b7e
	inc de ; $2b7f
	dec b ; $2b80
	jr nz, Label_00_2b78 ; $2b81
	pop hl ; $2b83
	pop de ; $2b84
	pop bc ; $2b85
	ld a, $20 ; $2b86
	add a, l ; $2b88
	ld l, a ; $2b89
	jr nc, Label_00_2b8d ; $2b8a
	inc h ; $2b8c
Label_00_2b8d:
	ld a, $20 ; $2b8d
	add a, e ; $2b8f
	ld e, a ; $2b90
	jr nc, Label_00_2b94 ; $2b91
	inc d ; $2b93
Label_00_2b94:
	dec c ; $2b94
	jr nz, Label_00_2b75 ; $2b95
	pop hl ; $2b97
	pop de ; $2b98
	pop bc ; $2b99
	call DrawWindowFrameTop ; $2b9a
	ld a, $20 ; $2b9d
	add a, l ; $2b9f
	ld l, a ; $2ba0
	jr nc, Label_00_2ba4 ; $2ba1
	inc h ; $2ba3
Label_00_2ba4:
	dec c ; $2ba4
	dec c ; $2ba5
Label_00_2ba6:
	call DrawWindowFrameSides ; $2ba6
	ld a, $20 ; $2ba9
	add a, l ; $2bab
	ld l, a ; $2bac
	jr nc, Label_00_2bb0 ; $2bad
	inc h ; $2baf
Label_00_2bb0:
	dec c ; $2bb0
	jr nz, Label_00_2ba6 ; $2bb1
	call DrawWindowFrameBottom ; $2bb3
	pop hl ; $2bb6
	pop de ; $2bb7
	pop bc ; $2bb8
	pop af ; $2bb9
	ret ; $2bba
DrawWindowFrameTop:
	push bc ; $2bbb
	push hl ; $2bbc
	ld a, $02 ; $2bbd
	ld [hl+], a ; $2bbf
	dec b ; $2bc0
	dec b ; $2bc1
Label_00_2bc2:
	ld a, $03 ; $2bc2
	ld [hl+], a ; $2bc4
	dec b ; $2bc5
	jr nz, Label_00_2bc2 ; $2bc6
	ld a, $04 ; $2bc8
	ld [hl+], a ; $2bca
	pop hl ; $2bcb
	pop bc ; $2bcc
	ret ; $2bcd
DrawWindowFrameSides:
	push hl ; $2bce
	ld [hl], $05 ; $2bcf
	ld a, b ; $2bd1
	dec a ; $2bd2
	add a, l ; $2bd3
	ld l, a ; $2bd4
	jr nc, Label_00_2bd8 ; $2bd5
	inc h ; $2bd7
Label_00_2bd8:
	ld [hl], $06 ; $2bd8
	pop hl ; $2bda
	ret ; $2bdb
DrawWindowFrameBottom:
	ld a, $07 ; $2bdc
	ld [hl+], a ; $2bde
	dec b ; $2bdf
	dec b ; $2be0
Label_00_2be1:
	ld a, $08 ; $2be1
	ld [hl+], a ; $2be3
	dec b ; $2be4
	jr nz, Label_00_2be1 ; $2be5
	ld a, $09 ; $2be7
	ld [hl+], a ; $2be9
	ret ; $2bea
	bit 5, a ; $2beb
	jr z, Label_00_2bf1 ; $2bed
	dec d ; $2bef
	ret ; $2bf0
Label_00_2bf1:
	bit 4, a ; $2bf1
	jr z, Label_00_2bf7 ; $2bf3
	inc d ; $2bf5
	ret ; $2bf6
Label_00_2bf7:
	bit 6, a ; $2bf7
	jr z, Label_00_2bfd ; $2bf9
	dec e ; $2bfb
	ret ; $2bfc
Label_00_2bfd:
	bit 7, a ; $2bfd
	jr z, Label_00_2c03 ; $2bff
	inc e ; $2c01
	ret ; $2c02
Label_00_2c03:
	ret ; $2c03
MoveCursorVertical:
	bit 6, b ; $2c04
	jr nz, Label_00_2c18 ; $2c06
	bit 7, b ; $2c08
	jr nz, Label_00_2c16 ; $2c0a
	ret ; $2c0c
MoveCursorHorizontal:
	bit 5, b ; $2c0d
	jr nz, Label_00_2c18 ; $2c0f
	bit 4, b ; $2c11
	jr nz, Label_00_2c16 ; $2c13
	ret ; $2c15
Label_00_2c16:
	inc a ; $2c16
	inc a ; $2c17
Label_00_2c18:
	dec a ; $2c18
	add a, a ; $2c19
	jr nc, Label_00_2c20 ; $2c1a
	ld a, c ; $2c1c
	dec a ; $2c1d
	jr Label_00_2c25 ; $2c1e
Label_00_2c20:
	rra ; $2c20
	cp a, c ; $2c21
	jr c, Label_00_2c25 ; $2c22
	xor a, a ; $2c24
Label_00_2c25:
	ret ; $2c25
TickTimer:
	ld a, [hl] ; $2c26
	and a, a ; $2c27
	ret z ; $2c28
	dec [hl] ; $2c29
	ret ; $2c2a
QueueSprite24x32:
	bit 5, b ; $2c2b
	jr nz, Label_00_2c8d ; $2c2d
	ld a, h ; $2c2f
	add a, d ; $2c30
	ld d, a ; $2c31
	ld a, l ; $2c32
	add a, e ; $2c33
	ld e, a ; $2c34
	ld a, [wSpriteBufferPage] ; $2c35
	ld h, a ; $2c38
	ldh a, [hSpriteQueueIndex] ; $2c39
	cp a, $89 ; $2c3b
	ret nc ; $2c3d
	ld l, a ; $2c3e
	ld a, e ; $2c3f
	ld [hl+], a ; $2c40
	ld a, d ; $2c41
	ld [hl+], a ; $2c42
	ld a, c ; $2c43
	ld [hl+], a ; $2c44
	ld a, b ; $2c45
	ld [hl+], a ; $2c46
	inc c ; $2c47
	inc c ; $2c48
	ld a, e ; $2c49
	add a, $10 ; $2c4a
	ld [hl+], a ; $2c4c
	ld a, d ; $2c4d
	ld [hl+], a ; $2c4e
	ld a, c ; $2c4f
	ld [hl+], a ; $2c50
	ld a, b ; $2c51
	ld [hl+], a ; $2c52
	inc c ; $2c53
	inc c ; $2c54
	ld a, e ; $2c55
	ld [hl+], a ; $2c56
	ld a, d ; $2c57
	add a, $08 ; $2c58
	ld [hl+], a ; $2c5a
	ld a, c ; $2c5b
	ld [hl+], a ; $2c5c
	ld a, b ; $2c5d
	ld [hl+], a ; $2c5e
	inc c ; $2c5f
	inc c ; $2c60
	ld a, e ; $2c61
	add a, $10 ; $2c62
	ld [hl+], a ; $2c64
	ld a, d ; $2c65
	add a, $08 ; $2c66
	ld [hl+], a ; $2c68
	ld a, c ; $2c69
	ld [hl+], a ; $2c6a
	ld a, b ; $2c6b
	ld [hl+], a ; $2c6c
	inc c ; $2c6d
	inc c ; $2c6e
	ld a, e ; $2c6f
	ld [hl+], a ; $2c70
	ld a, d ; $2c71
	add a, $10 ; $2c72
	ld [hl+], a ; $2c74
	ld a, c ; $2c75
	ld [hl+], a ; $2c76
	ld a, b ; $2c77
	ld [hl+], a ; $2c78
	inc c ; $2c79
	inc c ; $2c7a
	ld a, e ; $2c7b
	add a, $10 ; $2c7c
	ld [hl+], a ; $2c7e
	ld a, d ; $2c7f
	add a, $10 ; $2c80
	ld [hl+], a ; $2c82
	ld a, c ; $2c83
	ld [hl+], a ; $2c84
	ld a, b ; $2c85
	ld [hl+], a ; $2c86
	inc c ; $2c87
	inc c ; $2c88
	ld a, l ; $2c89
	ldh [hSpriteQueueIndex], a ; $2c8a
	ret ; $2c8c
Label_00_2c8d:
	ld a, d ; $2c8d
	sub a, h ; $2c8e
	add a, $08 ; $2c8f
	ld d, a ; $2c91
	ld a, l ; $2c92
	add a, e ; $2c93
	ld e, a ; $2c94
	ld a, [wSpriteBufferPage] ; $2c95
	ld h, a ; $2c98
	ldh a, [hSpriteQueueIndex] ; $2c99
	cp a, $89 ; $2c9b
	ret nc ; $2c9d
	ld l, a ; $2c9e
	ld a, e ; $2c9f
	ld [hl+], a ; $2ca0
	ld a, d ; $2ca1
	ld [hl+], a ; $2ca2
	ld a, c ; $2ca3
	ld [hl+], a ; $2ca4
	ld a, b ; $2ca5
	ld [hl+], a ; $2ca6
	inc c ; $2ca7
	inc c ; $2ca8
	ld a, e ; $2ca9
	add a, $10 ; $2caa
	ld [hl+], a ; $2cac
	ld a, d ; $2cad
	ld [hl+], a ; $2cae
	ld a, c ; $2caf
	ld [hl+], a ; $2cb0
	ld a, b ; $2cb1
	ld [hl+], a ; $2cb2
	inc c ; $2cb3
	inc c ; $2cb4
	ld a, e ; $2cb5
	ld [hl+], a ; $2cb6
	ld a, d ; $2cb7
	add a, $f8 ; $2cb8
	ld [hl+], a ; $2cba
	ld a, c ; $2cbb
	ld [hl+], a ; $2cbc
	ld a, b ; $2cbd
	ld [hl+], a ; $2cbe
	inc c ; $2cbf
	inc c ; $2cc0
	ld a, e ; $2cc1
	add a, $10 ; $2cc2
	ld [hl+], a ; $2cc4
	ld a, d ; $2cc5
	add a, $f8 ; $2cc6
	ld [hl+], a ; $2cc8
	ld a, c ; $2cc9
	ld [hl+], a ; $2cca
	ld a, b ; $2ccb
	ld [hl+], a ; $2ccc
	inc c ; $2ccd
	inc c ; $2cce
	ld a, e ; $2ccf
	ld [hl+], a ; $2cd0
	ld a, d ; $2cd1
	add a, $f0 ; $2cd2
	ld [hl+], a ; $2cd4
	ld a, c ; $2cd5
	ld [hl+], a ; $2cd6
	ld a, b ; $2cd7
	ld [hl+], a ; $2cd8
	inc c ; $2cd9
	inc c ; $2cda
	ld a, e ; $2cdb
	add a, $10 ; $2cdc
	ld [hl+], a ; $2cde
	ld a, d ; $2cdf
	add a, $f0 ; $2ce0
	ld [hl+], a ; $2ce2
	ld a, c ; $2ce3
	ld [hl+], a ; $2ce4
	ld a, b ; $2ce5
	ld [hl+], a ; $2ce6
	inc c ; $2ce7
	inc c ; $2ce8
	ld a, l ; $2ce9
	ldh [hSpriteQueueIndex], a ; $2cea
	ret ; $2cec
QueueSprite32x32:
	bit 5, b ; $2ced
	jr nz, Label_00_2d34 ; $2cef
	ld a, h ; $2cf1
	add a, d ; $2cf2
	ldh [$ffd0], a ; $2cf3
	ld a, l ; $2cf5
	add a, e ; $2cf6
	ldh [$ffd1], a ; $2cf7
	ld a, [wSpriteBufferPage] ; $2cf9
	ld h, a ; $2cfc
	ldh a, [hSpriteQueueIndex] ; $2cfd
	ld l, a ; $2cff
	ld de, $0000 ; $2d00
	call QueueSpriteBlockPart ; $2d03
	ld de, $0010 ; $2d06
	call QueueSpriteBlockPart ; $2d09
	ld de, $0800 ; $2d0c
	call QueueSpriteBlockPart ; $2d0f
	ld de, $0810 ; $2d12
	call QueueSpriteBlockPart ; $2d15
	ld de, $1000 ; $2d18
	call QueueSpriteBlockPart ; $2d1b
	ld de, $1010 ; $2d1e
	call QueueSpriteBlockPart ; $2d21
	ld de, $1800 ; $2d24
	call QueueSpriteBlockPart ; $2d27
	ld de, $1810 ; $2d2a
	call QueueSpriteBlockPart ; $2d2d
	ld a, l ; $2d30
	ldh [hSpriteQueueIndex], a ; $2d31
	ret ; $2d33
Label_00_2d34:
	ld a, d ; $2d34
	sub a, h ; $2d35
	add a, $08 ; $2d36
	ldh [$ffd0], a ; $2d38
	ld a, l ; $2d3a
	add a, e ; $2d3b
	ldh [$ffd1], a ; $2d3c
	ld a, [wSpriteBufferPage] ; $2d3e
	ld h, a ; $2d41
	ldh a, [hSpriteQueueIndex] ; $2d42
	ld l, a ; $2d44
	ld de, $0000 ; $2d45
	call QueueSpriteBlockPart ; $2d48
	ld de, $0010 ; $2d4b
	call QueueSpriteBlockPart ; $2d4e
	ld de, $f800 ; $2d51
	call QueueSpriteBlockPart ; $2d54
	ld de, $f810 ; $2d57
	call QueueSpriteBlockPart ; $2d5a
	ld de, $f000 ; $2d5d
	call QueueSpriteBlockPart ; $2d60
	ld de, $f010 ; $2d63
	call QueueSpriteBlockPart ; $2d66
	ld de, $e800 ; $2d69
	call QueueSpriteBlockPart ; $2d6c
	ld de, $e810 ; $2d6f
	call QueueSpriteBlockPart ; $2d72
	ld a, l ; $2d75
	ldh [hSpriteQueueIndex], a ; $2d76
	ret ; $2d78
QueueSpriteBlockPart:
	ld a, l ; $2d79
	cp a, $a0 ; $2d7a
	ret z ; $2d7c
	ldh a, [$ffd1] ; $2d7d
	add a, e ; $2d7f
	ld [hl+], a ; $2d80
	ldh a, [$ffd0] ; $2d81
	add a, d ; $2d83
	ld [hl+], a ; $2d84
	ld a, c ; $2d85
	ld [hl+], a ; $2d86
	ld a, b ; $2d87
	ld [hl+], a ; $2d88
	inc c ; $2d89
	inc c ; $2d8a
	ret ; $2d8b
ProjectWorldToScreen:
	ldh a, [hRomBank] ; $2d8c
	push af ; $2d8e
	ld a, $2f ; $2d8f
	ldh [hRomBank], a ; $2d91
	ld [$2000], a ; $2d93
	push hl ; $2d96
	push de ; $2d97
	ld l, e ; $2d98
	ld h, d ; $2d99
	call MulViewScaleA ; $2d9a
	ld e, l ; $2d9d
	ld d, h ; $2d9e
	ld l, c ; $2d9f
	ld h, b ; $2da0
	call MulViewScaleB ; $2da1
	add hl, de ; $2da4
	pop de ; $2da5
	push hl ; $2da6
	ld l, e ; $2da7
	ld h, d ; $2da8
	call MulViewScaleB ; $2da9
	ld e, l ; $2dac
	ld d, h ; $2dad
	ld l, c ; $2dae
	ld h, b ; $2daf
	call MulViewScaleANeg ; $2db0
	add hl, de ; $2db3
	ld e, l ; $2db4
	ld d, h ; $2db5
	pop bc ; $2db6
	pop hl ; $2db7
	ld a, $2e ; $2db8
	ldh [hRomBank], a ; $2dba
	ld [$2000], a ; $2dbc
	push de ; $2dbf
	push hl ; $2dc0
	ld l, e ; $2dc1
	ld h, d ; $2dc2
	call GetPerspectiveScale ; $2dc3
	ld l, c ; $2dc6
	ld h, b ; $2dc7
	ld a, d ; $2dc8
	call MulHLByASigned ; $2dc9
	add hl, hl ; $2dcc
	ld bc, $0004 ; $2dcd
	add hl, bc ; $2dd0
	add hl, hl ; $2dd1
	add hl, hl ; $2dd2
	ld c, l ; $2dd3
	ld b, h ; $2dd4
	pop hl ; $2dd5
	ld a, d ; $2dd6
	call MulHLByASigned ; $2dd7
	add hl, hl ; $2dda
	ld de, $0004 ; $2ddb
	add hl, de ; $2dde
	add hl, hl ; $2ddf
	add hl, hl ; $2de0
	pop de ; $2de1
	pop af ; $2de2
	ldh [hRomBank], a ; $2de3
	ld [$2000], a ; $2de5
	ret ; $2de8
MulViewScaleA:
	bit 7, h ; $2de9
	jr nz, Label_00_2df9 ; $2deb
	res 0, l ; $2ded
	ld a, h ; $2def
	and a, $1f ; $2df0
	add a, $40 ; $2df2
	ld h, a ; $2df4
	ld a, [hl+] ; $2df5
	ld h, [hl] ; $2df6
	ld l, a ; $2df7
	ret ; $2df8
Label_00_2df9:
	xor a, a ; $2df9
	sub a, l ; $2dfa
	ld l, a ; $2dfb
	sbc a, a ; $2dfc
	sub a, h ; $2dfd
	ld h, a ; $2dfe
	res 0, l ; $2dff
	ld a, h ; $2e01
	and a, $1f ; $2e02
	add a, $40 ; $2e04
	ld h, a ; $2e06
	ld a, [hl+] ; $2e07
	ld h, [hl] ; $2e08
	ld l, a ; $2e09
	xor a, a ; $2e0a
	sub a, l ; $2e0b
	ld l, a ; $2e0c
	sbc a, a ; $2e0d
	sub a, h ; $2e0e
	ld h, a ; $2e0f
	ret ; $2e10
MulViewScaleANeg:
	bit 7, h ; $2e11
	jr nz, Label_00_2e27 ; $2e13
	res 0, l ; $2e15
	ld a, h ; $2e17
	and a, $1f ; $2e18
	add a, $40 ; $2e1a
	ld h, a ; $2e1c
	ld a, [hl+] ; $2e1d
	ld h, [hl] ; $2e1e
	ld l, a ; $2e1f
	xor a, a ; $2e20
	sub a, l ; $2e21
	ld l, a ; $2e22
	sbc a, a ; $2e23
	sub a, h ; $2e24
	ld h, a ; $2e25
	ret ; $2e26
Label_00_2e27:
	xor a, a ; $2e27
	sub a, l ; $2e28
	ld l, a ; $2e29
	sbc a, a ; $2e2a
	sub a, h ; $2e2b
	ld h, a ; $2e2c
	res 0, l ; $2e2d
	ld a, h ; $2e2f
	and a, $1f ; $2e30
	add a, $40 ; $2e32
	ld h, a ; $2e34
	ld a, [hl+] ; $2e35
	ld h, [hl] ; $2e36
	ld l, a ; $2e37
	ret ; $2e38
MulViewScaleB:
	bit 7, h ; $2e39
	jr nz, Label_00_2e49 ; $2e3b
	res 0, l ; $2e3d
	ld a, h ; $2e3f
	and a, $1f ; $2e40
	add a, $60 ; $2e42
	ld h, a ; $2e44
	ld a, [hl+] ; $2e45
	ld h, [hl] ; $2e46
	ld l, a ; $2e47
	ret ; $2e48
Label_00_2e49:
	xor a, a ; $2e49
	sub a, l ; $2e4a
	ld l, a ; $2e4b
	sbc a, a ; $2e4c
	sub a, h ; $2e4d
	ld h, a ; $2e4e
	res 0, l ; $2e4f
	ld a, h ; $2e51
	and a, $1f ; $2e52
	add a, $60 ; $2e54
	ld h, a ; $2e56
	ld a, [hl+] ; $2e57
	ld h, [hl] ; $2e58
	ld l, a ; $2e59
	xor a, a ; $2e5a
	sub a, l ; $2e5b
	ld l, a ; $2e5c
	sbc a, a ; $2e5d
	sub a, h ; $2e5e
	ld h, a ; $2e5f
	ret ; $2e60
GetPerspectiveScale:
	ld a, h ; $2e61
	add a, $20 ; $2e62
	and a, $3f ; $2e64
	ld h, a ; $2e66
	set 6, h ; $2e67
	ld d, [hl] ; $2e69
	ret ; $2e6a
Label_00_2e6b:
	ldh a, [hRomBank] ; $2e6b
	push af ; $2e6d
	ld a, [$df22] ; $2e6e
	ldh [hRomBank], a ; $2e71
	ld [$2000], a ; $2e73
	ld hl, $df38 ; $2e76
	ld a, [hl+] ; $2e79
	ld h, [hl] ; $2e7a
	ld l, a ; $2e7b
	add hl, de ; $2e7c
	add hl, de ; $2e7d
	ld a, [hl+] ; $2e7e
	ld [$df1b], a ; $2e7f
	ld a, [hl+] ; $2e82
	ld [$df1c], a ; $2e83
	ld a, [hl+] ; $2e86
	ld [$df1d], a ; $2e87
	ld c, [hl] ; $2e8a
	ld hl, $df24 ; $2e8b
	ld a, [hl+] ; $2e8e
	ld h, [hl] ; $2e8f
	ld l, a ; $2e90
	add hl, de ; $2e91
	ld a, [hl+] ; $2e92
	ld h, [hl] ; $2e93
	ld l, a ; $2e94
	ld a, [$df26] ; $2e95
	ld e, a ; $2e98
	ld a, [$df27] ; $2e99
	ld d, a ; $2e9c
	ld a, [wStandingShadowsEnabled] ; $2e9d
	and a, a ; $2ea0
	jr nz, Label_00_2ead ; $2ea1
	call QueueVRAMCopy ; $2ea3
Label_00_2ea6:
	pop af ; $2ea6
	ldh [hRomBank], a ; $2ea7
	ld [$2000], a ; $2ea9
	ret ; $2eac
Label_00_2ead:
	push de ; $2ead
	push hl ; $2eae
	call QueueVRAMCopy ; $2eaf
	pop hl ; $2eb2
	pop de ; $2eb3
	ld a, [$df1d] ; $2eb4
	and a, a ; $2eb7
	jr z, Label_00_2ee8 ; $2eb8
	ld bc, $0100 ; $2eba
	add hl, bc ; $2ebd
	ld a, $30 ; $2ebe
	add a, e ; $2ec0
	ld e, a ; $2ec1
	jr nc, Label_00_2ec5 ; $2ec2
	inc d ; $2ec4
Label_00_2ec5:
	call Func_00_2f0c ; $2ec5
	ld a, $40 ; $2ec8
	add a, e ; $2eca
	ld e, a ; $2ecb
	jr nc, Label_00_2ecf ; $2ecc
	inc d ; $2ece
Label_00_2ecf:
	call Func_00_2f0c ; $2ecf
	ld a, $40 ; $2ed2
	add a, e ; $2ed4
	ld e, a ; $2ed5
	jr nc, Label_00_2ed9 ; $2ed6
	inc d ; $2ed8
Label_00_2ed9:
	call Func_00_2f0c ; $2ed9
	ld a, $40 ; $2edc
	add a, e ; $2ede
	ld e, a ; $2edf
	jr nc, Label_00_2ee3 ; $2ee0
	inc d ; $2ee2
Label_00_2ee3:
	call Func_00_2f0c ; $2ee3
	jr Label_00_2ea6 ; $2ee6
Label_00_2ee8:
	ld bc, $00c0 ; $2ee8
	add hl, bc ; $2eeb
	ld a, $30 ; $2eec
	add a, e ; $2eee
	ld e, a ; $2eef
	jr nc, Label_00_2ef3 ; $2ef0
	inc d ; $2ef2
Label_00_2ef3:
	call Func_00_2f0c ; $2ef3
	ld a, $40 ; $2ef6
	add a, e ; $2ef8
	ld e, a ; $2ef9
	jr nc, Label_00_2efd ; $2efa
	inc d ; $2efc
Label_00_2efd:
	call Func_00_2f0c ; $2efd
	ld a, $40 ; $2f00
	add a, e ; $2f02
	ld e, a ; $2f03
	jr nc, Label_00_2f07 ; $2f04
	inc d ; $2f06
Label_00_2f07:
	call Func_00_2f0c ; $2f07
	jr Label_00_2ea6 ; $2f0a
Func_00_2f0c:
	ld c, $01 ; $2f0c
	push de ; $2f0e
	push hl ; $2f0f
	call QueueVRAMCopy ; $2f10
	pop hl ; $2f13
	pop de ; $2f14
	ld bc, $0010 ; $2f15
	add hl, bc ; $2f18
	ret ; $2f19
UpdateSoundEngine:
	ld hl, $ffd2 ; $2f1a
	ld a, [hl] ; $2f1d
	or a, a ; $2f1e
	jr nz, Label_00_2f31 ; $2f1f
	ld [hl], $01 ; $2f21
	ldh a, [hWramBank] ; $2f23
	push af ; $2f25
	call RunSoundEngine ; $2f26
	pop af ; $2f29
	wram_bank ; $2f2a
	xor a, a ; $2f2e
	ldh [$ffd2], a ; $2f2f
Label_00_2f31:
	ret ; $2f31
ResumeBGM:
	push af ; $2f32
	push bc ; $2f33
	push de ; $2f34
	push hl ; $2f35
	ld hl, hMusic ; $2f36
	bit 0, [hl] ; $2f39
	jr z, Label_00_2f4d ; $2f3b
	res 0, [hl] ; $2f3d
	ldh a, [hWramBank] ; $2f3f
	push af ; $2f41
	ld a, [wCurrentBGM] ; $2f42
	call PlaySound ; $2f45
	pop af ; $2f48
	wram_bank ; $2f49
Label_00_2f4d:
	pop hl ; $2f4d
	pop de ; $2f4e
	pop bc ; $2f4f
	pop af ; $2f50
	ret ; $2f51
	push hl ; $2f52
	ld hl, hMusic ; $2f53
	bit 0, [hl] ; $2f56
	jr z, Label_00_2f5e ; $2f58
	res 0, [hl] ; $2f5a
	sound $00 ; $2f5c
Label_00_2f5e:
	pop hl ; $2f5e
	ret ; $2f5f
	push af ; $2f60
	push bc ; $2f61
	push de ; $2f62
	push hl ; $2f63
	ld a, [$c8a3] ; $2f64
	and a, $01 ; $2f67
	ld c, a ; $2f69
	ldh a, [hMusic] ; $2f6a
	and a, $fe ; $2f6c
	or a, c ; $2f6e
	ldh [hMusic], a ; $2f6f
	bit 0, a ; $2f71
	jr z, Label_00_2f81 ; $2f73
	ldh a, [hWramBank] ; $2f75
	push af ; $2f77
	xor a, a ; $2f78
	call PlaySound ; $2f79
	pop af ; $2f7c
	wram_bank ; $2f7d
Label_00_2f81:
	pop hl ; $2f81
	pop de ; $2f82
	pop bc ; $2f83
	pop af ; $2f84
	ret ; $2f85
SetMusicMuted:
	push af ; $2f86
	push bc ; $2f87
	push de ; $2f88
	push hl ; $2f89
	ld b, a ; $2f8a
	xor a, a ; $2f8b
	ldh [hActiveJingle], a ; $2f8c
	ldh a, [hWramBank] ; $2f8e
	push af ; $2f90
	ld a, b ; $2f91
	and a, $01 ; $2f92
	ld c, a ; $2f94
	ldh a, [hMusic] ; $2f95
	and a, $fe ; $2f97
	or a, c ; $2f99
	ldh [hMusic], a ; $2f9a
	bit 0, a ; $2f9c
	jr nz, Label_00_2fa5 ; $2f9e
	ld a, [wCurrentBGM] ; $2fa0
	jr Label_00_2fa6 ; $2fa3
Label_00_2fa5:
	xor a, a ; $2fa5
Label_00_2fa6:
	call PlaySound ; $2fa6
	pop af ; $2fa9
	wram_bank ; $2faa
	pop hl ; $2fae
	pop de ; $2faf
	pop bc ; $2fb0
	pop af ; $2fb1
	ret ; $2fb2
PlaySoundCmd:
	push af ; $2fb3
	push bc ; $2fb4
	push de ; $2fb5
	push hl ; $2fb6
	ld hl, sp + 8 ; $2fb7
	ld e, [hl] ; $2fb9
	inc hl ; $2fba
	ld d, [hl] ; $2fbb
	dec hl ; $2fbc
	ld a, [de] ; $2fbd
	inc de ; $2fbe
	ld [hl], e ; $2fbf
	inc hl ; $2fc0
	ld [hl], d ; $2fc1
Label_00_2fc2:
	cp a, $50 ; $2fc2
	jr nc, Label_00_3010 ; $2fc4
	cp a, $40 ; $2fc6
	jr c, Label_00_2fe6 ; $2fc8
	ld hl, hMusic ; $2fca
	bit 0, [hl] ; $2fcd
	jr nz, Label_00_301f ; $2fcf
	ldh [hActiveJingle], a ; $2fd1
	sub a, $40 ; $2fd3
	ld hl, JingleSoundIds ; $2fd5
	add a, l ; $2fd8
	ld l, a ; $2fd9
	jr nc, Label_00_2fdd ; $2fda
	inc h ; $2fdc
Label_00_2fdd:
	ld a, [hl] ; $2fdd
	jr Label_00_2ffa ; $2fde
JingleSoundIds:
	INCBIN "data/bank_000/d_2fe0.bin" ; $2fe0, 6 bytes
Label_00_2fe6:
	ld d, a ; $2fe6
	ldh a, [hActiveJingle] ; $2fe7
	or a, a ; $2fe9
	ld a, d ; $2fea
	jr z, Label_00_2ff3 ; $2feb
	ld hl, wCurrentBGM ; $2fed
	ld [hl], a ; $2ff0
	jr Label_00_301f ; $2ff1
Label_00_2ff3:
	ld hl, wCurrentBGM ; $2ff3
	cp a, [hl] ; $2ff6
	jr z, Label_00_301f ; $2ff7
	ld [hl], a ; $2ff9
Label_00_2ffa:
	ld hl, hMusic ; $2ffa
	bit 0, [hl] ; $2ffd
	jr nz, Label_00_301f ; $2fff
	ld h, a ; $3001
	ldh a, [hWramBank] ; $3002
	push af ; $3004
	ld a, h ; $3005
	call PlaySound ; $3006
	pop af ; $3009
	wram_bank ; $300a
	jr Label_00_301f ; $300e
Label_00_3010:
	ld h, a ; $3010
	ldh a, [hWramBank] ; $3011
	push af ; $3013
	ld a, h ; $3014
	call PlaySound ; $3015
	pop af ; $3018
	wram_bank ; $3019
	jr Label_00_301f ; $301d
Label_00_301f:
	pop hl ; $301f
	pop de ; $3020
	pop bc ; $3021
	pop af ; $3022
	ret ; $3023
PlaySoundManaged:
	push af ; $3024
	push bc ; $3025
	push de ; $3026
	push hl ; $3027
	jr Label_00_2fc2 ; $3028
WaitJingleEnd:
	push af ; $302a
	push bc ; $302b
	push de ; $302c
	push hl ; $302d
	ldh a, [hActiveJingle] ; $302e
	or a, a ; $3030
	jr z, Label_00_3058 ; $3031
Label_00_3033:
	call AdvanceFrame ; $3033
	ldh a, [hPlayerInputFlags] ; $3036
	or a, a ; $3038
	jr nz, Label_00_3040 ; $3039
	ldh a, [hActiveJingle] ; $303b
	or a, a ; $303d
	jr nz, Label_00_3033 ; $303e
Label_00_3040:
	xor a, a ; $3040
	ldh [hActiveJingle], a ; $3041
	ld hl, hMusic ; $3043
	bit 0, [hl] ; $3046
	jr nz, Label_00_3058 ; $3048
	ldh a, [hWramBank] ; $304a
	push af ; $304c
	ld a, [wCurrentBGM] ; $304d
	call PlaySound ; $3050
	pop af ; $3053
	wram_bank ; $3054
Label_00_3058:
	pop hl ; $3058
	pop de ; $3059
	pop bc ; $305a
	pop af ; $305b
	ret ; $305c
ResumeBGMAfterJingle:
	call CheckSfxChannelsIdle ; $305d
	ret nz ; $3060
	ldh a, [hActiveJingle] ; $3061
	or a, a ; $3063
	ret z ; $3064
	ld a, e ; $3065
	and a, $0f ; $3066
	ret nz ; $3068
	xor a, a ; $3069
	ldh [hActiveJingle], a ; $306a
	ld hl, hMusic ; $306c
	bit 0, [hl] ; $306f
	ret nz ; $3071
	ld a, [wCurrentBGM] ; $3072
	jp PlaySound ; $3075
InitAudioEngine:
	wram_bank $07 ; $3078
	ld bc, $0000 ; $307e
	call Func_00_30b4 ; $3081
	ld a, $80 ; $3084
	ldh [rAUDENA], a ; $3086
	xor a, a ; $3088
	ldh [rAUDTERM], a ; $3089
	ld [$d209], a ; $308b
	ld a, $77 ; $308e
	ldh [rAUDVOL], a ; $3090
	ld hl, $d100 ; $3092
	ld b, $06 ; $3095
	ld a, $ff ; $3097
Label_00_3099:
	ld [hl+], a ; $3099
	ld [hl-], a ; $309a
	ld de, $0020 ; $309b
	add hl, de ; $309e
	dec b ; $309f
	jr nz, Label_00_3099 ; $30a0
	ld hl, $d1c0 ; $30a2
	ld b, $48 ; $30a5
	xor a, a ; $30a7
Label_00_30a8:
	ld [hl+], a ; $30a8
	dec b ; $30a9
	jr nz, Label_00_30a8 ; $30aa
	xor a, a ; $30ac
	ld [$d215], a ; $30ad
	ld [$d219], a ; $30b0
	ret ; $30b3
Func_00_30b4:
	ld a, b ; $30b4
	ld [$d212], a ; $30b5
	ld a, c ; $30b8
	ld [$d213], a ; $30b9
	xor a, a ; $30bc
	ld [$d214], a ; $30bd
	ret ; $30c0
Func_00_30c1:
	ld a, [$d20f] ; $30c1
	inc a ; $30c4
	ld b, a ; $30c5
	ld a, $01 ; $30c6
Label_00_30c8:
	dec b ; $30c8
	jr z, Label_00_30ce ; $30c9
	add a, a ; $30cb
	jr Label_00_30c8 ; $30cc
Label_00_30ce:
	ld b, a ; $30ce
	ld a, [$d214] ; $30cf
	or a, b ; $30d2
	ld [$d214], a ; $30d3
	ret ; $30d6
Label_00_30d7:
	ld a, [$d214] ; $30d7
	ld hl, $d212 ; $30da
	and a, [hl] ; $30dd
	cp a, [hl] ; $30de
	jr nz, Label_00_310b ; $30df
	ld hl, $d106 ; $30e1
	ld a, [$d213] ; $30e4
	and a, $0f ; $30e7
	ld b, a ; $30e9
	ld a, [$d212] ; $30ea
Label_00_30ed:
	srl a ; $30ed
	ld [$d214], a ; $30ef
	jr nc, Label_00_30f9 ; $30f2
	ld a, [hl] ; $30f4
	and a, $f0 ; $30f5
	or a, b ; $30f7
	ld [hl], a ; $30f8
Label_00_30f9:
	ld a, l ; $30f9
	add a, $20 ; $30fa
	ld l, a ; $30fc
	ld a, h ; $30fd
	adc a, $00 ; $30fe
	ld h, a ; $3100
	ld a, [$d214] ; $3101
	and a, a ; $3104
	jr nz, Label_00_30ed ; $3105
	xor a, a ; $3107
	ld [$d212], a ; $3108
Label_00_310b:
	xor a, a ; $310b
	ld [$d214], a ; $310c
	ret ; $310f
CheckSfxChannelsIdle:
	wram_bank $07 ; $3110
	ld hl, $d140 ; $3116
	ld de, $0020 ; $3119
	ld b, $04 ; $311c
Label_00_311e:
	ld a, [hl+] ; $311e
	inc a ; $311f
	ret nz ; $3120
	ld a, [hl-] ; $3121
	inc a ; $3122
	ret nz ; $3123
	add hl, de ; $3124
	dec b ; $3125
	jr nz, Label_00_311e ; $3126
	ret ; $3128
StopAllSound:
	push af ; $3129
	push bc ; $312a
	push de ; $312b
	push hl ; $312c
	wram_bank $07 ; $312d
	ld a, $ff ; $3133
	ld hl, $d140 ; $3135
	ld de, $0020 ; $3138
	ld b, $04 ; $313b
Label_00_313d:
	ld [hl+], a ; $313d
	ld [hl-], a ; $313e
	add hl, de ; $313f
	dec b ; $3140
	jr nz, Label_00_313d ; $3141
	ld hl, $d1d8 ; $3143
	ld bc, $0030 ; $3146
	call ClearBytes ; $3149
	pop hl ; $314c
	pop de ; $314d
	pop bc ; $314e
	pop af ; $314f
	ret ; $3150
SfxIndexTable:
	; $3151, 100 bytes (sound_index)
	sound_entry $78, 4, 0 ; sound 0
	sound_entry $78, 4, 4 ; sound 1
	sound_entry $78, 4, 8 ; sound 2
	sound_entry $78, 4, 12 ; sound 3
	sound_entry $78, 4, 16 ; sound 4
	sound_entry $78, 4, 20 ; sound 5
	sound_entry $78, 4, 24 ; sound 6
	sound_entry $79, 4, 0 ; sound 7
	sound_entry $79, 4, 4 ; sound 8
	sound_entry $78, 3, 28 ; sound 9
	sound_entry $79, 4, 8 ; sound 10
	sound_entry $79, 4, 12 ; sound 11
	sound_entry $79, 4, 16 ; sound 12
	sound_entry $79, 4, 20 ; sound 13
	sound_entry $79, 4, 24 ; sound 14
	sound_entry $7a, 4, 0 ; sound 15
	sound_entry $7a, 4, 4 ; sound 16
	sound_entry $7a, 4, 8 ; sound 17
	sound_entry $7a, 4, 12 ; sound 18
	sound_entry $7a, 4, 16 ; sound 19
	sound_entry $7a, 4, 20 ; sound 20
	sound_entry $7b, 4, 0 ; sound 21
	sound_entry $7b, 4, 4 ; sound 22
	sound_entry $7b, 4, 8 ; sound 23
	sound_entry $7b, 4, 12 ; sound 24
	sound_entry $7b, 3, 16 ; sound 25
	sound_entry $7b, 4, 19 ; sound 26
	sound_entry $7b, 4, 23 ; sound 27
	sound_entry $7b, 4, 27 ; sound 28
	sound_entry $7b, 4, 31 ; sound 29
	sound_entry $7b, 4, 35 ; sound 30
	sound_entry $7c, 4, 0 ; sound 31
	sound_entry $7c, 4, 4 ; sound 32
	sound_entry $7c, 4, 8 ; sound 33
	sound_entry $7c, 4, 12 ; sound 34
	sound_entry $7c, 4, 16 ; sound 35
	sound_entry $7d, 4, 0 ; sound 36
	sound_entry $7d, 4, 4 ; sound 37
	sound_entry $7d, 4, 8 ; sound 38
	sound_entry $7e, 4, 0 ; sound 39
	sound_entry $7e, 4, 4 ; sound 40
	sound_entry $7d, 4, 12 ; sound 41
	sound_entry $7d, 4, 16 ; sound 42
	sound_entry $7e, 4, 8 ; sound 43
	sound_entry $79, 4, 28 ; sound 44
	sound_entry $7a, 3, 24 ; sound 45
	sound_entry $7b, 4, 39 ; sound 46
	sound_entry $7d, 4, 20 ; sound 47
	sound_entry $7b, 4, 43 ; sound 48
	sound_entry $7d, 4, 24 ; sound 49
MusicIndexTable:
	; $31b5, 226 bytes (sound_index)
	sound_entry $78, 1, 31 ; sound 0
	sound_entry $78, 1, 32 ; sound 1
	sound_entry $79, 1, 32 ; sound 2
	sound_entry $7c, 1, 20 ; sound 3
	sound_entry $7c, 1, 21 ; sound 4
	sound_entry $7c, 1, 22 ; sound 5
	sound_entry $7c, 1, 23 ; sound 6
	sound_entry $7c, 1, 24 ; sound 7
	sound_entry $7c, 1, 25 ; sound 8
	sound_entry $7d, 1, 28 ; sound 9
	sound_entry $7c, 1, 26 ; sound 10
	sound_entry $7d, 1, 29 ; sound 11
	sound_entry $7e, 1, 12 ; sound 12
	sound_entry $7e, 1, 13 ; sound 13
	sound_entry $7e, 1, 14 ; sound 14
	sound_entry $7e, 1, 15 ; sound 15
	sound_entry $7e, 1, 16 ; sound 16
	sound_entry $7e, 1, 17 ; sound 17
	sound_entry $7e, 1, 18 ; sound 18
	sound_entry $7e, 1, 19 ; sound 19
	sound_entry $7e, 1, 20 ; sound 20
	sound_entry $7e, 1, 21 ; sound 21
	sound_entry $7e, 1, 22 ; sound 22
	sound_entry $7e, 1, 23 ; sound 23
	sound_entry $7e, 1, 24 ; sound 24
	sound_entry $7e, 1, 25 ; sound 25
	sound_entry $7e, 1, 26 ; sound 26
	sound_entry $7e, 1, 27 ; sound 27
	sound_entry $7e, 1, 28 ; sound 28
	sound_entry $7e, 1, 29 ; sound 29
	sound_entry $7e, 2, 30 ; sound 30
	sound_entry $7e, 1, 32 ; sound 31
	sound_entry $7e, 1, 33 ; sound 32
	sound_entry $7e, 1, 34 ; sound 33
	sound_entry $7e, 1, 35 ; sound 34
	sound_entry $7e, 1, 36 ; sound 35
	sound_entry $7e, 1, 37 ; sound 36
	sound_entry $7e, 1, 38 ; sound 37
	sound_entry $7e, 1, 39 ; sound 38
	sound_entry $7e, 1, 40 ; sound 39
	sound_entry $7e, 1, 41 ; sound 40
	sound_entry $7e, 1, 42 ; sound 41
	sound_entry $7e, 1, 43 ; sound 42
	sound_entry $7e, 1, 44 ; sound 43
	sound_entry $7e, 1, 45 ; sound 44
	sound_entry $7e, 1, 46 ; sound 45
	sound_entry $7e, 1, 47 ; sound 46
	sound_entry $7e, 1, 48 ; sound 47
	sound_entry $7e, 1, 49 ; sound 48
	sound_entry $7e, 2, 50 ; sound 49
	sound_entry $7e, 1, 52 ; sound 50
	sound_entry $7e, 2, 53 ; sound 51
	sound_entry $7e, 1, 55 ; sound 52
	sound_entry $7e, 1, 56 ; sound 53
	sound_entry $7e, 2, 57 ; sound 54
	sound_entry $7e, 1, 59 ; sound 55
	sound_entry $7e, 1, 60 ; sound 56
	sound_entry $7e, 1, 61 ; sound 57
	sound_entry $7e, 1, 62 ; sound 58
	sound_entry $7e, 1, 63 ; sound 59
	sound_entry $7e, 1, 64 ; sound 60
	sound_entry $7e, 1, 65 ; sound 61
	sound_entry $7e, 1, 66 ; sound 62
	sound_entry $7e, 1, 67 ; sound 63
	sound_entry $7e, 1, 68 ; sound 64
	sound_entry $7e, 1, 69 ; sound 65
	sound_entry $7e, 1, 70 ; sound 66
	sound_entry $7e, 1, 71 ; sound 67
	sound_entry $7e, 1, 72 ; sound 68
	sound_entry $7f, 2, 0 ; sound 69
	sound_entry $7f, 1, 2 ; sound 70
	sound_entry $7f, 1, 3 ; sound 71
	sound_entry $7f, 1, 4 ; sound 72
	sound_entry $78, 1, 33 ; sound 73
	sound_entry $7b, 1, 47 ; sound 74
	sound_entry $7d, 1, 30 ; sound 75
	sound_entry $7f, 1, 5 ; sound 76
	sound_entry $7f, 1, 6 ; sound 77
	sound_entry $7f, 1, 7 ; sound 78
	sound_entry $7f, 1, 8 ; sound 79
	sound_entry $7f, 1, 9 ; sound 80
	sound_entry $7f, 1, 10 ; sound 81
	sound_entry $7f, 1, 11 ; sound 82
	sound_entry $7f, 1, 12 ; sound 83
	sound_entry $7f, 1, 13 ; sound 84
	sound_entry $7f, 1, 14 ; sound 85
	sound_entry $7f, 1, 15 ; sound 86
	sound_entry $7f, 1, 16 ; sound 87
	sound_entry $7f, 1, 17 ; sound 88
	sound_entry $7f, 1, 18 ; sound 89
	sound_entry $7f, 1, 19 ; sound 90
	sound_entry $7f, 1, 20 ; sound 91
	sound_entry $7f, 1, 21 ; sound 92
	sound_entry $7f, 1, 22 ; sound 93
	sound_entry $7f, 1, 23 ; sound 94
	sound_entry $7f, 1, 24 ; sound 95
	sound_entry $7f, 1, 25 ; sound 96
	sound_entry $7f, 1, 26 ; sound 97
	sound_entry $7f, 1, 27 ; sound 98
	sound_entry $7f, 1, 28 ; sound 99
	sound_entry $7f, 1, 29 ; sound 100
	sound_entry $7f, 1, 30 ; sound 101
	sound_entry $7f, 1, 31 ; sound 102
	sound_entry $7f, 1, 32 ; sound 103
	sound_entry $7f, 1, 33 ; sound 104
	sound_entry $7f, 1, 34 ; sound 105
	sound_entry $7f, 1, 35 ; sound 106
	sound_entry $7f, 1, 36 ; sound 107
	sound_entry $7f, 1, 37 ; sound 108
	sound_entry $7f, 1, 38 ; sound 109
	sound_entry $7f, 1, 39 ; sound 110
	sound_entry $7f, 1, 40 ; sound 111
	sound_entry $7f, 1, 41 ; sound 112
PlaySound:
	and a, a ; $3297
	jp z, StopAllSound ; $3298
	push bc ; $329b
	push de ; $329c
	push hl ; $329d
	ld hl, SfxIndexTable ; $329e
	cp a, $50 ; $32a1
	jr c, Label_00_32cf ; $32a3
	ld hl, MusicIndexTable ; $32a5
	push af ; $32a8
	push hl ; $32a9
	wram_bank $07 ; $32aa
	ld a, $ff ; $32b0
	ld hl, $d100 ; $32b2
	ld [hl+], a ; $32b5
	ld [hl], a ; $32b6
	ld hl, $d120 ; $32b7
	ld [hl+], a ; $32ba
	ld [hl], a ; $32bb
	ld hl, $d1c0 ; $32bc
	ld bc, $0018 ; $32bf
	call ClearBytes ; $32c2
	pop hl ; $32c5
	pop af ; $32c6
	sub a, $50 ; $32c7
	jr nz, Label_00_32d2 ; $32c9
	pop hl ; $32cb
	pop de ; $32cc
	pop bc ; $32cd
	ret ; $32ce
Label_00_32cf:
	call StopAllSound ; $32cf
Label_00_32d2:
	dec a ; $32d2
	add a, a ; $32d3
	jr nc, Label_00_32d7 ; $32d4
	inc h ; $32d6
Label_00_32d7:
	add a, l ; $32d7
	ld l, a ; $32d8
	jr nc, Label_00_32dc ; $32d9
	inc h ; $32db
Label_00_32dc:
	ldh a, [hRomBank] ; $32dc
	push af ; $32de
	ld a, [hl] ; $32df
	and a, $0f ; $32e0
	or a, $70 ; $32e2
	ldh [hRomBank], a ; $32e4
	ld [$2000], a ; $32e6
	ld a, [hl+] ; $32e9
	swap a ; $32ea
	and a, $0f ; $32ec
	ld b, a ; $32ee
	ld l, [hl] ; $32ef
	ld h, $00 ; $32f0
	add hl, hl ; $32f2
	add hl, hl ; $32f3
	set 6, h ; $32f4
	ld e, l ; $32f6
	ld d, h ; $32f7
	di ; $32f8
Label_00_32f9:
	push bc ; $32f9
	push de ; $32fa
	call StartSoundChannel ; $32fb
	pop de ; $32fe
	ld hl, $0004 ; $32ff
	add hl, de ; $3302
	ld e, l ; $3303
	ld d, h ; $3304
	pop bc ; $3305
	dec b ; $3306
	jr nz, Label_00_32f9 ; $3307
	ei ; $3309
	pop af ; $330a
	ldh [hRomBank], a ; $330b
	ld [$2000], a ; $330d
	pop hl ; $3310
	pop de ; $3311
	pop bc ; $3312
	ret ; $3313
StartSoundChannel:
	ld a, [de] ; $3314
	inc de ; $3315
	ld c, a ; $3316
	ld b, $00 ; $3317
	ld hl, $d100 ; $3319
	add hl, bc ; $331c
	ld a, [hl] ; $331d
	cp a, $ff ; $331e
	jr z, Label_00_333f ; $3320
	inc hl ; $3322
	ld a, [hl-] ; $3323
	ld b, $ee ; $3324
	and a, $03 ; $3326
	jr z, Label_00_3338 ; $3328
	ld b, $dd ; $332a
	cp a, $01 ; $332c
	jr z, Label_00_3338 ; $332e
	ld b, $bb ; $3330
	cp a, $02 ; $3332
	jr z, Label_00_3338 ; $3334
	ld b, $77 ; $3336
Label_00_3338:
	ld a, [$d209] ; $3338
	and a, b ; $333b
	ld [$d209], a ; $333c
Label_00_333f:
	xor a, a ; $333f
	ld [hl+], a ; $3340
	ld [hl+], a ; $3341
	ld a, [de] ; $3342
	inc de ; $3343
	ld [hl+], a ; $3344
	ld a, [de] ; $3345
	inc de ; $3346
	ld [hl+], a ; $3347
	ld a, [de] ; $3348
	inc de ; $3349
	ld [hl+], a ; $334a
	ldh a, [hRomBank] ; $334b
	ld [hl], a ; $334d
	inc hl ; $334e
	inc hl ; $334f
	inc hl ; $3350
	inc hl ; $3351
	inc hl ; $3352
	ld a, $ff ; $3353
	ld [hl+], a ; $3355
	xor a, a ; $3356
	push de ; $3357
	ld de, $000e ; $3358
	add hl, de ; $335b
	pop de ; $335c
	push hl ; $335d
	ld [hl+], a ; $335e
	ld [hl+], a ; $335f
	ld [hl-], a ; $3360
	dec hl ; $3361
	dec hl ; $3362
	dec hl ; $3363
	dec hl ; $3364
	dec hl ; $3365
	ld [hl-], a ; $3366
	ld [hl], $80 ; $3367
	pop hl ; $3369
	inc hl ; $336a
	inc hl ; $336b
	inc hl ; $336c
	xor a, a ; $336d
	ld [hl+], a ; $336e
	ld [hl+], a ; $336f
	ld [hl+], a ; $3370
	ld [hl+], a ; $3371
	ret ; $3372
RunSoundEngine:
	wram_bank $07 ; $3373
	ld hl, $ffd0 ; $3379
	ld de, $d000 ; $337c
	ld c, $02 ; $337f
	call CopyMemoryFast ; $3381
	call UpdateSoundChannels ; $3384
	ld hl, $d000 ; $3387
	ld de, $ffd0 ; $338a
	ld c, $02 ; $338d
	jp CopyMemoryFast ; $338f
UpdateSoundChannels:
	ldh a, [hRomBank] ; $3392
	push af ; $3394
	ld a, [$d215] ; $3395
	ld [$d20f], a ; $3398
	xor a, a ; $339b
	ld [$d208], a ; $339c
	ld hl, $d20e ; $339f
	inc [hl] ; $33a2
	ld hl, $d100 ; $33a3
Label_00_33a6:
	ld a, [hl+] ; $33a6
	ld b, a ; $33a7
	ld a, [hl-] ; $33a8
	and a, b ; $33a9
	inc a ; $33aa
	jp z, Label_00_34b7 ; $33ab
	push hl ; $33ae
	ld de, $ffd0 ; $33af
	ld c, $02 ; $33b2
	call CopyMemoryFast ; $33b4
	ldh a, [$ffd5] ; $33b7
	ldh [hRomBank], a ; $33b9
	ld [$2000], a ; $33bb
	ldh a, [$ffd2] ; $33be
	and a, $03 ; $33c0
	ld [$d20a], a ; $33c2
	ld b, a ; $33c5
	add a, a ; $33c6
	add a, a ; $33c7
	add a, b ; $33c8
	ld [$d20d], a ; $33c9
	inc b ; $33cc
	ld a, $88 ; $33cd
Label_00_33cf:
	rlca ; $33cf
	dec b ; $33d0
	jr nz, Label_00_33cf ; $33d1
	ld [$d20b], a ; $33d3
	ld [$d20c], a ; $33d6
	ldh a, [$ffd0] ; $33d9
	ld b, a ; $33db
	ldh a, [$ffd1] ; $33dc
	or a, b ; $33de
	and a, a ; $33df
	jp z, Label_00_34dd ; $33e0
	call TickVibrato ; $33e3
	call Func_00_3a40 ; $33e6
	ldh a, [$ffde] ; $33e9
	ld b, a ; $33eb
	ldh a, [$ffdf] ; $33ec
	inc a ; $33ee
	cp a, b ; $33ef
	jr c, Label_00_33f3 ; $33f0
	ld a, b ; $33f2
Label_00_33f3:
	ldh [$ffdf], a ; $33f3
	ld hl, $ffd7 ; $33f5
	ldh a, [$ffd6] ; $33f8
	and a, $0f ; $33fa
	add a, [hl] ; $33fc
	cp a, $10 ; $33fd
	jr c, Label_00_3406 ; $33ff
	sub a, $10 ; $3401
	ld [hl], a ; $3403
	jr Label_00_3464 ; $3404
Label_00_3406:
	ld [hl], a ; $3406
	call TickVolumeSlide ; $3407
	ldh a, [$ffe8] ; $340a
	and a, a ; $340c
	jr z, Label_00_3412 ; $340d
	dec a ; $340f
	ldh [$ffe8], a ; $3410
Label_00_3412:
	ldh a, [$ffd9] ; $3412
	and a, a ; $3414
	jr nz, Label_00_344d ; $3415
	ldh a, [$ffeb] ; $3417
	and a, $f0 ; $3419
	jr z, Label_00_342f ; $341b
	ld hl, $ffea ; $341d
	dec [hl] ; $3420
	jr nz, Label_00_343b ; $3421
	ldh a, [$ffe5] ; $3423
	and a, $f0 ; $3425
	ld c, a ; $3427
	ldh a, [$ffd8] ; $3428
	and a, $0f ; $342a
	or a, c ; $342c
	ldh [$ffd8], a ; $342d
Label_00_342f:
	call Func_00_30c1 ; $342f
Label_00_3432:
	ldh a, [$ffe7] ; $3432
	ldh [$ffe8], a ; $3434
	call RunSoundChannelScript ; $3436
	jr Label_00_3464 ; $3439
Label_00_343b:
	ldh a, [$ffeb] ; $343b
	and a, $0f ; $343d
	dec a ; $343f
	cp a, [hl] ; $3440
	jr nz, Label_00_3464 ; $3441
	call ScaleEchoVolume ; $3443
	ldh a, [$ffd8] ; $3446
	call ApplyChannelEnvelope ; $3448
	jr Label_00_3464 ; $344b
Label_00_344d:
	dec a ; $344d
	ldh [$ffd9], a ; $344e
	push af ; $3450
	ldh a, [$ffef] ; $3451
	or a, a ; $3453
	jr z, Label_00_3459 ; $3454
	dec a ; $3456
	ldh [$ffef], a ; $3457
Label_00_3459:
	pop af ; $3459
	jr nz, Label_00_3464 ; $345a
	ldh a, [$ffeb] ; $345c
	and a, $f0 ; $345e
	jr nz, Label_00_3464 ; $3460
	jr Label_00_342f ; $3462
Label_00_3464:
	ld a, [$d219] ; $3464
	and a, a ; $3467
	jr z, Label_00_349f ; $3468
	ld a, [$d20a] ; $346a
	cp a, $02 ; $346d
	jr nz, Label_00_349f ; $346f
	ld a, [$d20f] ; $3471
	cp a, $02 ; $3474
	jr c, Label_00_349f ; $3476
	ld a, [$d20b] ; $3478
	ld b, a ; $347b
	ld a, [$d208] ; $347c
	and a, b ; $347f
	jr nz, Label_00_349f ; $3480
	ld a, [$d217] ; $3482
	ld b, a ; $3485
	ldh a, [$ffda] ; $3486
	cp a, b ; $3488
	jr z, Label_00_349f ; $3489
	ld e, a ; $348b
	ld [$d217], a ; $348c
	swap e ; $348f
	xor a, a ; $3491
	ld [$d219], a ; $3492
	ldh [rAUD3ENA], a ; $3495
	ld d, a ; $3497
	call LoadWavePattern ; $3498
	ld a, $80 ; $349b
	ldh [rAUD3ENA], a ; $349d
Label_00_349f:
	ld a, [$d20b] ; $349f
	ld b, a ; $34a2
	ld a, [$d208] ; $34a3
	or a, b ; $34a6
	ld [$d208], a ; $34a7
	pop hl ; $34aa
	push hl ; $34ab
	ld e, l ; $34ac
	ld d, h ; $34ad
	ld c, $02 ; $34ae
	ld hl, $ffd0 ; $34b0
	call CopyMemoryFast ; $34b3
	pop hl ; $34b6
Label_00_34b7:
	ld de, $0020 ; $34b7
	add hl, de ; $34ba
	ld a, [$d20f] ; $34bb
	inc a ; $34be
	ld [$d20f], a ; $34bf
	cp a, $06 ; $34c2
	jp c, Label_00_33a6 ; $34c4
	ld a, [$d208] ; $34c7
	ld b, a ; $34ca
	ld a, [$d209] ; $34cb
	and a, b ; $34ce
	ld [$d209], a ; $34cf
	ldh [rAUDTERM], a ; $34d2
	pop af ; $34d4
	ldh [hRomBank], a ; $34d5
	ld [$2000], a ; $34d7
	jp Label_00_30d7 ; $34da
Label_00_34dd:
	ldh a, [$ffd3] ; $34dd
Label_00_34df:
	ld l, a ; $34df
	ldh a, [$ffd4] ; $34e0
	ld h, a ; $34e2
	ld a, [hl+] ; $34e3
	and a, $0f ; $34e4
	ld d, a ; $34e6
	ldh [$ffd7], a ; $34e7
	ld a, [$d20a] ; $34e9
	cp a, $02 ; $34ec
	jr z, Label_00_351e ; $34ee
	ld a, [hl+] ; $34f0
	rrca ; $34f1
	rrca ; $34f2
	and a, $c0 ; $34f3
	or a, d ; $34f5
Label_00_34f6:
	ldh [$ffd6], a ; $34f6
	ld a, [hl+] ; $34f8
	swap a ; $34f9
	ldh [$ffd8], a ; $34fb
	ld a, [$d20a] ; $34fd
	cp a, $02 ; $3500
	jr z, Label_00_3524 ; $3502
	ld a, [hl+] ; $3504
	ldh [$ffda], a ; $3505
Label_00_3507:
	ld a, $ff ; $3507
	ldh [$ffdb], a ; $3509
	xor a, a ; $350b
	ldh [$ffdc], a ; $350c
	ldh [$ffdd], a ; $350e
	ldh [$ffe0], a ; $3510
	ldh [$ffd1], a ; $3512
	dec a ; $3514
	ldh [$ffe6], a ; $3515
	ld a, $02 ; $3517
	ldh [$ffd0], a ; $3519
	jp Label_00_3432 ; $351b
Label_00_351e:
	ld a, [hl+] ; $351e
	ldh [$ffde], a ; $351f
	ld a, d ; $3521
	jr Label_00_34f6 ; $3522
Label_00_3524:
	xor a, a ; $3524
	ldh [rAUD3ENA], a ; $3525
	ld d, a ; $3527
	ldh a, [$ffda] ; $3528
	ld e, a ; $352a
	cp a, $ff ; $352b
	jr nz, Label_00_3533 ; $352d
	ld e, [hl] ; $352f
	ld a, e ; $3530
	ldh [$ffda], a ; $3531
Label_00_3533:
	ld [$d217], a ; $3533
	swap e ; $3536
	ld hl, WavePatternTable ; $3538
	push de ; $353b
	ldh a, [$ffe9] ; $353c
	swap a ; $353e
	and a, $0f ; $3540
	add a, a ; $3542
	ld e, a ; $3543
	ld d, $00 ; $3544
	add hl, de ; $3546
	ld a, [hl+] ; $3547
	ld h, [hl] ; $3548
	ld l, a ; $3549
	pop de ; $354a
	add hl, de ; $354b
	ld c, $30 ; $354c
	ld b, $10 ; $354e
Label_00_3550:
	ld a, [hl+] ; $3550
	ldh [c], a ; $3551
	inc c ; $3552
	dec b ; $3553
	jr nz, Label_00_3550 ; $3554
	jr Label_00_3507 ; $3556
RunSoundChannelScript:
	ldh a, [$ffd0] ; $3558
	ld l, a ; $355a
	ldh a, [$ffd1] ; $355b
	ld h, a ; $355d
	add hl, hl ; $355e
	ldh a, [$ffd3] ; $355f
	ld e, a ; $3561
	ldh a, [$ffd4] ; $3562
	ld d, a ; $3564
	add hl, de ; $3565
Label_00_3566:
	ldh a, [$ffd0] ; $3566
	add a, $01 ; $3568
	ldh [$ffd0], a ; $356a
	ldh a, [$ffd1] ; $356c
	adc a, $00 ; $356e
	ldh [$ffd1], a ; $3570
	ld a, [hl+] ; $3572
	cp a, $d0 ; $3573
	jr nc, Label_00_35b9 ; $3575
	cp a, $b0 ; $3577
	jp nc, Label_00_35f9 ; $3579
	cp a, $a0 ; $357c
	jp nc, Label_00_3635 ; $357e
	jp Label_00_3864 ; $3581
Label_00_3584:
	cp a, $fd ; $3584
	jr z, Label_00_358e ; $3586
	cp a, $ff ; $3588
	jr z, Label_00_359f ; $358a
	jr Label_00_359c ; $358c
Label_00_358e:
	push hl ; $358e
	ld b, [hl] ; $358f
	call GetChannelLoopSlot ; $3590
	xor a, a ; $3593
	ld [hl+], a ; $3594
	ldh a, [$ffd0] ; $3595
	ld [hl+], a ; $3597
	ldh a, [$ffd1] ; $3598
	ld [hl], a ; $359a
	pop hl ; $359b
Label_00_359c:
	inc hl ; $359c
	jr Label_00_3566 ; $359d
Label_00_359f:
	ldh [$ffd0], a ; $359f
	ldh [$ffd1], a ; $35a1
	ld a, [$d20a] ; $35a3
	cp a, $02 ; $35a6
	jr nz, Label_00_35b6 ; $35a8
	ld a, [$d20f] ; $35aa
	cp a, $02 ; $35ad
	jr nc, Label_00_35b6 ; $35af
	ld a, $ff ; $35b1
	ld [$d219], a ; $35b3
Label_00_35b6:
	jp Label_00_3b02 ; $35b6
Label_00_35b9:
	cp a, $f0 ; $35b9
	jr nc, Label_00_3584 ; $35bb
	cp a, $e0 ; $35bd
	jr nc, Label_00_35c5 ; $35bf
	and a, $0f ; $35c1
	jr Label_00_35c9 ; $35c3
Label_00_35c5:
	and a, $0f ; $35c5
	cpl ; $35c7
	inc a ; $35c8
Label_00_35c9:
	ld b, a ; $35c9
	ld a, [$d20a] ; $35ca
	cp a, $02 ; $35cd
	jr z, Label_00_35d9 ; $35cf
	ld a, b ; $35d1
	ldh [$ffe0], a ; $35d2
	ld a, [hl] ; $35d4
	ldh [$ffe1], a ; $35d5
	ldh [$ffe2], a ; $35d7
Label_00_35d9:
	inc hl ; $35d9
	jp Label_00_3566 ; $35da
Label_00_35dd:
	and a, $0f ; $35dd
	ld b, a ; $35df
	ld a, [$d20a] ; $35e0
	cp a, $02 ; $35e3
	jr z, Label_00_35f5 ; $35e5
	ldh a, [$ffd8] ; $35e7
	and a, $0f ; $35e9
	jr nz, Label_00_35f5 ; $35eb
	ld a, [hl] ; $35ed
	ldh [$ffde], a ; $35ee
	ld a, b ; $35f0
	swap a ; $35f1
	ldh [$ffdd], a ; $35f3
Label_00_35f5:
	inc hl ; $35f5
	jp Label_00_3566 ; $35f6
Label_00_35f9:
	cp a, $c0 ; $35f9
	jr nc, Label_00_35dd ; $35fb
	and a, $0f ; $35fd
	jp z, Label_00_3618 ; $35ff
	ld e, a ; $3602
	ld b, [hl] ; $3603
	push hl ; $3604
	call GetChannelLoopSlot ; $3605
	inc [hl] ; $3608
	ld a, [hl+] ; $3609
	inc e ; $360a
	cp a, e ; $360b
	jr nc, Label_00_3614 ; $360c
	ld a, [hl+] ; $360e
	ldh [$ffd0], a ; $360f
	ld a, [hl] ; $3611
	ldh [$ffd1], a ; $3612
Label_00_3614:
	pop hl ; $3614
	jp RunSoundChannelScript ; $3615
Label_00_3618:
	ld a, [hl] ; $3618
	ld b, a ; $3619
	and a, $f0 ; $361a
	cp a, $f0 ; $361c
	jp nz, Label_00_3631 ; $361e
	ld b, [hl] ; $3621
	push hl ; $3622
	call GetChannelLoopSlot ; $3623
	inc hl ; $3626
	ld a, [hl+] ; $3627
	ldh [$ffd0], a ; $3628
	ld a, [hl] ; $362a
	ldh [$ffd1], a ; $362b
	pop hl ; $362d
	jp RunSoundChannelScript ; $362e
Label_00_3631:
	inc hl ; $3631
	jp Label_00_3566 ; $3632
Label_00_3635:
	cp a, $a0 ; $3635
	jr nz, Label_00_364f ; $3637
	ld a, [hl+] ; $3639
	swap a ; $363a
	ldh [$ffd8], a ; $363c
	ld a, [$d20b] ; $363e
	ld b, a ; $3641
	ld a, [$d208] ; $3642
	and a, b ; $3645
	jp nz, Label_00_3566 ; $3646
	call ApplyChannelEnvelope ; $3649
	jp Label_00_3566 ; $364c
Label_00_364f:
	cp a, $a1 ; $364f
	jr nz, Label_00_369e ; $3651
	ld a, [$d20a] ; $3653
	cp a, $02 ; $3656
	jr z, Label_00_3660 ; $3658
	ld a, [hl+] ; $365a
	ldh [$ffda], a ; $365b
	jp Label_00_3566 ; $365d
Label_00_3660:
	ld a, [hl+] ; $3660
	ld e, a ; $3661
	ldh [$ffda], a ; $3662
	ld a, [$d20b] ; $3664
	ld b, a ; $3667
	ld a, [$d208] ; $3668
	and a, b ; $366b
	jr z, Label_00_3671 ; $366c
	jp Label_00_3566 ; $366e
Label_00_3671:
	xor a, a ; $3671
	ldh [rAUD3ENA], a ; $3672
	ld d, a ; $3674
	push hl ; $3675
	ld a, e ; $3676
	ld [$d217], a ; $3677
	swap e ; $367a
	ld hl, WavePatternTable ; $367c
	push de ; $367f
	ldh a, [$ffe9] ; $3680
	swap a ; $3682
	and a, $0f ; $3684
	add a, a ; $3686
	ld e, a ; $3687
	ld d, $00 ; $3688
	add hl, de ; $368a
	ld a, [hl+] ; $368b
	ld h, [hl] ; $368c
	ld l, a ; $368d
	pop de ; $368e
	add hl, de ; $368f
	ld c, $30 ; $3690
	ld b, $10 ; $3692
Label_00_3694:
	ld a, [hl+] ; $3694
	ldh [c], a ; $3695
	inc c ; $3696
	dec b ; $3697
	jr nz, Label_00_3694 ; $3698
	pop hl ; $369a
	jp Label_00_3566 ; $369b
Label_00_369e:
	cp a, $a2 ; $369e
	jr nz, Label_00_36bf ; $36a0
	ld a, [$d20a] ; $36a2
	cp a, $02 ; $36a5
	jr z, Label_00_36b9 ; $36a7
	ld a, [hl+] ; $36a9
	rrca ; $36aa
	rrca ; $36ab
	and a, $c0 ; $36ac
	ld d, a ; $36ae
	ldh a, [$ffd6] ; $36af
	and a, $3f ; $36b1
	or a, d ; $36b3
	ldh [$ffd6], a ; $36b4
	jp Label_00_3566 ; $36b6
Label_00_36b9:
	ld a, [hl+] ; $36b9
	ldh [$ffde], a ; $36ba
	jp Label_00_3566 ; $36bc
Label_00_36bf:
	cp a, $a3 ; $36bf
	cp a, $a3 ; $36c1
	jr nz, Label_00_36e8 ; $36c3
	ld a, [hl+] ; $36c5
	cp a, $fe ; $36c6
	jr z, Label_00_36e2 ; $36c8
	ld b, a ; $36ca
	and a, $0f ; $36cb
	add a, a ; $36cd
	ldh [$ffe7], a ; $36ce
	ldh [$ffe8], a ; $36d0
	ld a, b ; $36d2
	add a, $10 ; $36d3
	and a, $f0 ; $36d5
	ld e, a ; $36d7
	ldh a, [$ffd2] ; $36d8
	and a, $0f ; $36da
	or a, e ; $36dc
Label_00_36dd:
	ldh [$ffd2], a ; $36dd
	jp Label_00_3566 ; $36df
Label_00_36e2:
	ldh a, [$ffd2] ; $36e2
	and a, $0f ; $36e4
	jr Label_00_36dd ; $36e6
Label_00_36e8:
	cp a, $a4 ; $36e8
	jr nz, Label_00_36f2 ; $36ea
	ld a, [hl+] ; $36ec
	ldh [$ffdb], a ; $36ed
	jp Label_00_3566 ; $36ef
Label_00_36f2:
	cp a, $a5 ; $36f2
	jr nz, Label_00_3704 ; $36f4
	ld a, [hl+] ; $36f6
	cp a, $01 ; $36f7
	jr nz, Label_00_36ff ; $36f9
	ldh a, [$ffe6] ; $36fb
	swap a ; $36fd
Label_00_36ff:
	ldh [$ffe6], a ; $36ff
	jp Label_00_3566 ; $3701
Label_00_3704:
	cp a, $a6 ; $3704
	jr nz, Label_00_370e ; $3706
	ld a, [hl+] ; $3708
	ldh [rAUDVOL], a ; $3709
	jp Label_00_3566 ; $370b
Label_00_370e:
	cp a, $a7 ; $370e
	jr nz, Label_00_3718 ; $3710
	ld a, [hl] ; $3712
	ldh [$ffd9], a ; $3713
	jp Label_00_3947 ; $3715
Label_00_3718:
	cp a, $a8 ; $3718
	jr nz, Label_00_372a ; $371a
	ld a, [hl+] ; $371c
	ld c, a ; $371d
	and a, $0f ; $371e
	ld b, a ; $3720
	ld a, c ; $3721
	and a, $f0 ; $3722
	or a, b ; $3724
	ldh [$ffe9], a ; $3725
	jp Label_00_3566 ; $3727
Label_00_372a:
	cp a, $a9 ; $372a
	jp nz, Label_00_3795 ; $372c
	ld a, [hl+] ; $372f
	cp a, $f0 ; $3730
	jr z, Label_00_3771 ; $3732
	cp a, $f1 ; $3734
	jr z, Label_00_3779 ; $3736
	cp a, $f2 ; $3738
	jr z, Label_00_3781 ; $373a
	cp a, $f3 ; $373c
	jr z, Label_00_378b ; $373e
	cp a, $fe ; $3740
	jr z, Label_00_374c ; $3742
	cp a, $ff ; $3744
	jr nz, Label_00_3760 ; $3746
	ldh a, [$ffdc] ; $3748
	jr Label_00_374f ; $374a
Label_00_374c:
	ld a, [$d218] ; $374c
Label_00_374f:
	sla a ; $374f
	add a, l ; $3751
	ld l, a ; $3752
	ld a, h ; $3753
	adc a, $00 ; $3754
	ld h, a ; $3756
	ld a, [hl+] ; $3757
	ldh [$ffd0], a ; $3758
	ld a, [hl] ; $375a
	ldh [$ffd1], a ; $375b
	jp RunSoundChannelScript ; $375d
Label_00_3760:
	cp a, $80 ; $3760
	jr nc, Label_00_3769 ; $3762
	ldh [$ffdc], a ; $3764
	jp Label_00_3566 ; $3766
Label_00_3769:
	sub a, $80 ; $3769
	ld [$d218], a ; $376b
	jp Label_00_3566 ; $376e
Label_00_3771:
	ldh a, [$ffdc] ; $3771
	inc a ; $3773
	ldh [$ffdc], a ; $3774
	jp Label_00_3566 ; $3776
Label_00_3779:
	ldh a, [$ffdc] ; $3779
	dec a ; $377b
	ldh [$ffdc], a ; $377c
	jp Label_00_3566 ; $377e
Label_00_3781:
	ld a, [$d218] ; $3781
	inc a ; $3784
	ld [$d218], a ; $3785
	jp Label_00_3566 ; $3788
Label_00_378b:
	ld a, [$d218] ; $378b
	dec a ; $378e
	ld [$d218], a ; $378f
	jp Label_00_3566 ; $3792
Label_00_3795:
	cp a, $aa ; $3795
	jr nz, Label_00_37bf ; $3797
	ld a, [hl+] ; $3799
	ld c, a ; $379a
	and a, $f0 ; $379b
	jr z, Label_00_37b5 ; $379d
	swap a ; $379f
	ldh [$ffea], a ; $37a1
	or a, $f0 ; $37a3
	ldh [$ffeb], a ; $37a5
	ld a, c ; $37a7
	and a, $0f ; $37a8
	ld c, a ; $37aa
	ldh a, [$ffe5] ; $37ab
	and a, $f0 ; $37ad
	or a, c ; $37af
	ldh [$ffe5], a ; $37b0
	jp Label_00_3566 ; $37b2
Label_00_37b5:
	xor a, a ; $37b5
	ldh [$ffea], a ; $37b6
	ldh [$ffe5], a ; $37b8
	ldh [$ffeb], a ; $37ba
	jp Label_00_3566 ; $37bc
Label_00_37bf:
	cp a, $ac ; $37bf
	jr nz, Label_00_37fd ; $37c1
	ldh a, [$ffec] ; $37c3
	sub a, $01 ; $37c5
	jr z, Label_00_37eb ; $37c7
	jr nc, Label_00_37cc ; $37c9
	ld a, [hl] ; $37cb
Label_00_37cc:
	ldh [$ffec], a ; $37cc
	ldh a, [$ffd0] ; $37ce
	sub a, $01 ; $37d0
	ldh [$ffed], a ; $37d2
	ldh a, [$ffd1] ; $37d4
	sbc a, $00 ; $37d6
	ldh [$ffee], a ; $37d8
	inc hl ; $37da
	ld a, [hl+] ; $37db
	ld h, [hl] ; $37dc
	ld l, a ; $37dd
	srl h ; $37de
	rr l ; $37e0
	ld a, l ; $37e2
	ldh [$ffd0], a ; $37e3
	ld a, h ; $37e5
	ldh [$ffd1], a ; $37e6
	jp RunSoundChannelScript ; $37e8
Label_00_37eb:
	xor a, a ; $37eb
	ldh [$ffec], a ; $37ec
	ldh a, [$ffd0] ; $37ee
	add a, $01 ; $37f0
	ldh [$ffd0], a ; $37f2
	ldh a, [$ffd1] ; $37f4
	adc a, $00 ; $37f6
	ldh [$ffd1], a ; $37f8
	jp RunSoundChannelScript ; $37fa
Label_00_37fd:
	cp a, $ad ; $37fd
	jr nz, Label_00_380c ; $37ff
	ldh a, [$ffed] ; $3801
	ldh [$ffd0], a ; $3803
	ldh a, [$ffee] ; $3805
	ldh [$ffd1], a ; $3807
	jp RunSoundChannelScript ; $3809
Label_00_380c:
	cp a, $ae ; $380c
	jr nz, Label_00_381e ; $380e
	ld a, [hl+] ; $3810
	and a, $10 ; $3811
	ld b, a ; $3813
	ldh a, [$ffd6] ; $3814
	and a, $ef ; $3816
	or a, b ; $3818
	ldh [$ffd6], a ; $3819
	jp Label_00_3566 ; $381b
Label_00_381e:
	cp a, $af ; $381e
	jr nz, Label_00_3832 ; $3820
	ld a, [hl+] ; $3822
	and a, $0f ; $3823
	ldh [$ffd7], a ; $3825
	ld b, a ; $3827
	ldh a, [$ffd6] ; $3828
	and a, $f0 ; $382a
	or a, b ; $382c
	ldh [$ffd6], a ; $382d
	jp Label_00_3566 ; $382f
Label_00_3832:
	inc hl ; $3832
	jp Label_00_3566 ; $3833
NoiseNoteTable:
	INCBIN "data/bank_000/d_3836.bin" ; $3836, 16 bytes
Label_00_3846:
	xor a, a ; $3846
	ldh [$ffef], a ; $3847
	ld a, [$d20a] ; $3849
	cp a, $02 ; $384c
	jr z, Label_00_3858 ; $384e
	ldh a, [$ffe4] ; $3850
	and a, $7f ; $3852
	jp z, Label_00_3afa ; $3854
	ret ; $3857
Label_00_3858:
	ldh a, [$ffe4] ; $3858
	and a, $7f ; $385a
	ret nz ; $385c
	call AbortIfChannelTriggered ; $385d
	xor a, a ; $3860
	ldh [rAUD3ENA], a ; $3861
	ret ; $3863
Label_00_3864:
	ld b, a ; $3864
	ldh a, [$ffeb] ; $3865
	and a, $f0 ; $3867
	jr z, Label_00_387a ; $3869
	push de ; $386b
	ldh a, [$ffeb] ; $386c
	and a, $0f ; $386e
	ldh [$ffea], a ; $3870
	ld c, a ; $3872
	ld a, [hl] ; $3873
	sub a, c ; $3874
	ldh [$ffd9], a ; $3875
	pop de ; $3877
	jr Label_00_387d ; $3878
Label_00_387a:
	ld a, [hl] ; $387a
	ldh [$ffd9], a ; $387b
Label_00_387d:
	push bc ; $387d
	ld c, a ; $387e
	ldh a, [$ffdb] ; $387f
	bit 7, a ; $3881
	jr z, Label_00_388c ; $3883
	add a, c ; $3885
	jr z, Label_00_388a ; $3886
	jr c, Label_00_388c ; $3888
Label_00_388a:
	ld a, $01 ; $388a
Label_00_388c:
	pop bc ; $388c
	ldh [$ffef], a ; $388d
	ld a, [$d20a] ; $388f
	cp a, $03 ; $3892
	jr nz, Label_00_38b2 ; $3894
	ld a, b ; $3896
	cp a, $1f ; $3897
	jr z, Label_00_3846 ; $3899
	cp a, $10 ; $389b
	jr nc, Label_00_38ad ; $389d
	ld hl, NoiseNoteTable ; $389f
	add a, l ; $38a2
	ld l, a ; $38a3
	ld a, h ; $38a4
	adc a, $00 ; $38a5
	ld h, a ; $38a7
	ld l, [hl] ; $38a8
	ld h, $00 ; $38a9
	jr Label_00_38e5 ; $38ab
Label_00_38ad:
	ld l, a ; $38ad
	ld h, $00 ; $38ae
	jr Label_00_38e5 ; $38b0
Label_00_38b2:
	ld a, b ; $38b2
	and a, $0f ; $38b3
	cp a, $0c ; $38b5
	jr nc, Label_00_3846 ; $38b7
	add a, a ; $38b9
	ld e, a ; $38ba
	ldh a, [$ffd6] ; $38bb
	and a, $10 ; $38bd
	jr z, Label_00_38c5 ; $38bf
	ld a, e ; $38c1
	add a, $18 ; $38c2
	ld e, a ; $38c4
Label_00_38c5:
	ld d, $00 ; $38c5
	ld hl, NotePeriodTable ; $38c7
	add hl, de ; $38ca
	ld a, [hl+] ; $38cb
	ld h, [hl] ; $38cc
	ld l, a ; $38cd
	ld a, b ; $38ce
	swap a ; $38cf
	and a, $0f ; $38d1
	jr z, Label_00_38dd ; $38d3
	ld b, a ; $38d5
Label_00_38d6:
	srl h ; $38d6
	rr l ; $38d8
	dec b ; $38da
	jr nz, Label_00_38d6 ; $38db
Label_00_38dd:
	ld a, $00 ; $38dd
	sub a, l ; $38df
	ld l, a ; $38e0
	ld a, $08 ; $38e1
	sbc a, h ; $38e3
	ld h, a ; $38e4
Label_00_38e5:
	xor a, a ; $38e5
	ldh [$ffdf], a ; $38e6
	call AbortIfChannelTriggered ; $38e8
	ld a, [$d20a] ; $38eb
	cp a, $02 ; $38ee
	jr nz, Label_00_38f9 ; $38f0
	call LoadWavePatternIfChanged ; $38f2
	ld a, $80 ; $38f5
	ldh [rAUD3ENA], a ; $38f7
Label_00_38f9:
	push hl ; $38f9
	call Func_00_39d0 ; $38fa
	pop hl ; $38fd
	ld a, [$d20a] ; $38fe
	and a, a ; $3901
	ldh a, [$ffda] ; $3902
	ld c, $10 ; $3904
	call z, WriteChannelReg ; $3906
	ld a, l ; $3909
	ld c, $13 ; $390a
	call WriteChannelReg ; $390c
	ld a, l ; $390f
	cp a, $02 ; $3910
	jr c, Label_00_391c ; $3912
	cp a, $fe ; $3914
	jr c, Label_00_391e ; $3916
	ld a, $fd ; $3918
	jr Label_00_391e ; $391a
Label_00_391c:
	ld a, $02 ; $391c
Label_00_391e:
	ldh [$ffe3], a ; $391e
	ld a, [$d20a] ; $3920
	cp a, $02 ; $3923
	jr z, Label_00_395a ; $3925
	cp a, $02 ; $3927
	jr nc, Label_00_3936 ; $3929
	ldh a, [$ffd6] ; $392b
	and a, $c0 ; $392d
	or a, $3f ; $392f
	ld c, $11 ; $3931
	call WriteChannelReg ; $3933
Label_00_3936:
	ld a, h ; $3936
	and a, $07 ; $3937
	or a, $80 ; $3939
Label_00_393b:
	or a, $20 ; $393b
	ldh [$ffe4], a ; $393d
	ld c, $14 ; $393f
	call WriteChannelReg ; $3941
	call ResetChannelLength ; $3944
Label_00_3947:
	ld a, [$d20c] ; $3947
	ld b, a ; $394a
	cpl ; $394b
	ld c, a ; $394c
	ldh a, [$ffe6] ; $394d
	and a, b ; $394f
	ld b, a ; $3950
	ld a, [$d209] ; $3951
	and a, c ; $3954
	or a, b ; $3955
	ld [$d209], a ; $3956
	ret ; $3959
Label_00_395a:
	xor a, a ; $395a
	ldh [rAUD3LEN], a ; $395b
	ldh a, [rAUDENA] ; $395d
	and a, $04 ; $395f
	jr z, Label_00_3936 ; $3961
	ld a, h ; $3963
	and a, $07 ; $3964
	jr Label_00_393b ; $3966
TickVolumeSlide:
	ld a, [$d20a] ; $3968
	cp a, $02 ; $396b
	ret z ; $396d
	ldh a, [$ffe0] ; $396e
	and a, a ; $3970
	ret z ; $3971
	ld hl, $ffe2 ; $3972
	dec [hl] ; $3975
	ret nz ; $3976
	ldh a, [$ffd8] ; $3977
	swap a ; $3979
	cp a, $10 ; $397b
	ret nc ; $397d
	and a, $0f ; $397e
	ld b, a ; $3980
	ldh a, [$ffe1] ; $3981
	ldh [$ffe2], a ; $3983
	ld hl, $ffe0 ; $3985
	ld a, [hl] ; $3988
	bit 7, a ; $3989
	jr nz, Label_00_399b ; $398b
	dec [hl] ; $398d
	ld a, b ; $398e
	cp a, $0f ; $398f
	ret z ; $3991
	ldh a, [$ffd8] ; $3992
	add a, $10 ; $3994
	ldh [$ffd8], a ; $3996
	jp ApplyChannelEnvelope ; $3998
Label_00_399b:
	inc [hl] ; $399b
	ld a, b ; $399c
	and a, a ; $399d
	ret z ; $399e
	ldh a, [$ffd8] ; $399f
	sub a, $10 ; $39a1
	ldh [$ffd8], a ; $39a3
	jr ApplyChannelEnvelope ; $39a5
TickVibrato:
	call AbortIfChannelTriggered ; $39a7
	ld a, [$d20a] ; $39aa
	cp a, $03 ; $39ad
	ret z ; $39af
	ldh a, [$ffe8] ; $39b0
	and a, a ; $39b2
	ret nz ; $39b3
	ldh a, [$ffd2] ; $39b4
	and a, $f0 ; $39b6
	ret z ; $39b8
	sub a, $10 ; $39b9
	ld b, a ; $39bb
	ld a, [$d20e] ; $39bc
	and a, $0f ; $39bf
	or a, b ; $39c1
	ld e, a ; $39c2
	ld d, $00 ; $39c3
	ld hl, SoundPitchTable ; $39c5
	add hl, de ; $39c8
	ldh a, [$ffe3] ; $39c9
	add a, [hl] ; $39cb
	ld c, $13 ; $39cc
	jr WriteChannelReg ; $39ce
Func_00_39d0:
	ld a, [$d20a] ; $39d0
	cp a, $02 ; $39d3
	jr z, Label_00_3a1d ; $39d5
	ldh a, [$ffdd] ; $39d7
	and a, a ; $39d9
	jp nz, Label_00_3a55 ; $39da
	ldh a, [$ffd8] ; $39dd
ApplyChannelEnvelope:
	ld b, a ; $39df
	and a, $f0 ; $39e0
	jr z, Label_00_39f6 ; $39e2
	ldh a, [$ffef] ; $39e4
	or a, a ; $39e6
	jr nz, Label_00_39f6 ; $39e7
	ld a, b ; $39e9
	rrca ; $39ea
	rrca ; $39eb
	add a, $10 ; $39ec
	and a, $f0 ; $39ee
	ld c, a ; $39f0
	ld a, b ; $39f1
	and a, $0f ; $39f2
	or a, c ; $39f4
	ld b, a ; $39f5
Label_00_39f6:
	ld a, b ; $39f6
	and a, $07 ; $39f7
	jr nz, Label_00_39ff ; $39f9
	ld a, b ; $39fb
	or a, $08 ; $39fc
	ld b, a ; $39fe
Label_00_39ff:
	ld a, [$d20d] ; $39ff
	add a, $12 ; $3a02
	ld c, a ; $3a04
	ldh a, [c] ; $3a05
	cp a, b ; $3a06
	ret z ; $3a07
	ld a, b ; $3a08
	ldh [c], a ; $3a09
	ldh a, [$ffe4] ; $3a0a
	ld c, $14 ; $3a0c
	call WriteChannelReg ; $3a0e
	jp ResetChannelLength ; $3a11
WriteChannelReg:
	ld b, a ; $3a14
	ld a, [$d20d] ; $3a15
	add a, c ; $3a18
	ld c, a ; $3a19
	ld a, b ; $3a1a
	ldh [c], a ; $3a1b
	ret ; $3a1c
Label_00_3a1d:
	ldh a, [$ffd8] ; $3a1d
	ld c, $12 ; $3a1f
	jr WriteChannelReg ; $3a21
ResetChannelLength:
	ld c, $11 ; $3a23
	ld a, [$d20d] ; $3a25
	add a, c ; $3a28
	ld c, a ; $3a29
	ldh a, [c] ; $3a2a
	and a, $c0 ; $3a2b
	ldh [c], a ; $3a2d
	ret ; $3a2e
Label_00_3a2f:
	ld a, e ; $3a2f
	srl a ; $3a30
	add a, $02 ; $3a32
	swap a ; $3a34
	ld hl, $ffd8 ; $3a36
	cp a, [hl] ; $3a39
	ret c ; $3a3a
	and a, $60 ; $3a3b
	ldh [rAUD3LEVEL], a ; $3a3d
	ret ; $3a3f
Func_00_3a40:
	call AbortIfChannelTriggered ; $3a40
	ldh a, [$ffe4] ; $3a43
	and a, $7f ; $3a45
	jp z, Label_00_3afa ; $3a47
	ld a, [$d20a] ; $3a4a
	cp a, $02 ; $3a4d
	jr z, Label_00_3a55 ; $3a4f
	ldh a, [$ffdd] ; $3a51
	and a, a ; $3a53
	ret z ; $3a54
Label_00_3a55:
	ldh a, [$ffde] ; $3a55
	and a, a ; $3a57
	ret z ; $3a58
	ld e, $00 ; $3a59
	ld c, a ; $3a5b
	ldh a, [$ffdf] ; $3a5c
	ld b, $04 ; $3a5e
Label_00_3a60:
	add a, a ; $3a60
	cp a, c ; $3a61
	jr c, Label_00_3a65 ; $3a62
	sub a, c ; $3a64
Label_00_3a65:
	ccf ; $3a65
	rl e ; $3a66
	dec b ; $3a68
	jr nz, Label_00_3a60 ; $3a69
	ld a, [$d20a] ; $3a6b
	cp a, $02 ; $3a6e
	jr z, Label_00_3a2f ; $3a70
	ldh a, [$ffdd] ; $3a72
	or a, e ; $3a74
	ld e, a ; $3a75
	ld d, $00 ; $3a76
	push de ; $3a78
	ldh a, [$ffe9] ; $3a79
	and a, $0f ; $3a7b
	ld de, $3ed6 ; $3a7d
	sla a ; $3a80
	add a, e ; $3a82
	ld e, a ; $3a83
	ld a, $00 ; $3a84
	adc a, d ; $3a86
	ld d, a ; $3a87
	ld a, [de] ; $3a88
	ld l, a ; $3a89
	inc de ; $3a8a
	ld a, [de] ; $3a8b
	ld h, a ; $3a8c
	pop de ; $3a8d
	ld a, l ; $3a8e
	sub a, $10 ; $3a8f
	ld l, a ; $3a91
	ld a, h ; $3a92
	sbc a, $00 ; $3a93
	ld h, a ; $3a95
	add hl, de ; $3a96
	ldh a, [$ffd8] ; $3a97
	swap a ; $3a99
	ld e, a ; $3a9b
	ld a, [hl] ; $3a9c
	ld h, a ; $3a9d
	and a, $f0 ; $3a9e
	or a, e ; $3aa0
	ld e, a ; $3aa1
	bit 2, h ; $3aa2
	jr nz, Label_00_3ac6 ; $3aa4
	inc b ; $3aa6
	ld a, c ; $3aa7
	swap a ; $3aa8
	and a, $0f ; $3aaa
	jr z, Label_00_3ac6 ; $3aac
	ld b, a ; $3aae
	bit 3, e ; $3aaf
	jr nz, Label_00_3abf ; $3ab1
	sla b ; $3ab3
	bit 2, e ; $3ab5
	jr nz, Label_00_3abf ; $3ab7
	sla b ; $3ab9
	bit 1, e ; $3abb
	jr z, Label_00_3ac4 ; $3abd
Label_00_3abf:
	ld a, b ; $3abf
	cp a, $08 ; $3ac0
	jr c, Label_00_3ac6 ; $3ac2
Label_00_3ac4:
	ld b, $00 ; $3ac4
Label_00_3ac6:
	bit 1, h ; $3ac6
	jr z, Label_00_3acf ; $3ac8
	ld a, b ; $3aca
	jr z, Label_00_3acf ; $3acb
	srl b ; $3acd
Label_00_3acf:
	ld a, h ; $3acf
	and a, $08 ; $3ad0
	or a, b ; $3ad2
	ld b, a ; $3ad3
	bit 0, h ; $3ad4
	jr z, Label_00_3ae1 ; $3ad6
	ld hl, SoundChannelMaskTable ; $3ad8
	add hl, de ; $3adb
	ld a, [hl] ; $3adc
	or a, b ; $3add
	jp ApplyChannelEnvelope ; $3ade
Label_00_3ae1:
	ld c, $12 ; $3ae1
	ld a, [$d20d] ; $3ae3
	add a, c ; $3ae6
	ld c, a ; $3ae7
	ldh a, [c] ; $3ae8
	and a, $08 ; $3ae9
	ld l, a ; $3aeb
	ld a, h ; $3aec
	and a, $08 ; $3aed
	cp a, l ; $3aef
	ret z ; $3af0
	ld hl, SoundChannelMaskTable ; $3af1
	add hl, de ; $3af4
	ld a, [hl] ; $3af5
	or a, b ; $3af6
	jp ApplyChannelEnvelope ; $3af7
Label_00_3afa:
	call AbortIfChannelTriggered ; $3afa
	ld a, $00 ; $3afd
	jp ApplyChannelEnvelope ; $3aff
Label_00_3b02:
	call AbortIfChannelTriggered ; $3b02
	ld a, [$d20b] ; $3b05
	cpl ; $3b08
	ld b, a ; $3b09
	ld a, [$d209] ; $3b0a
	and a, b ; $3b0d
	ld [$d209], a ; $3b0e
	ret ; $3b11
AbortIfChannelTriggered:
	ld a, [$d20b] ; $3b12
	ld b, a ; $3b15
	ld a, [$d208] ; $3b16
	and a, b ; $3b19
	ret z ; $3b1a
	pop af ; $3b1b
	ret ; $3b1c
NotePeriodTable:
	; $3b1d, 48 bytes (records:2)
; 24 records x 2 bytes
	dw $07d4 ; record 0
	dw $0764 ; record 1
	dw $06f9 ; record 2
	dw $0695 ; record 3
	dw $0637 ; record 4
	dw $05dd ; record 5
	dw $0589 ; record 6
	dw $053a ; record 7
	dw $04f0 ; record 8
	dw $04a8 ; record 9
	dw $0465 ; record 10
	dw $0426 ; record 11
	dw $079c ; record 12
	dw $072e ; record 13
	dw $06c7 ; record 14
	dw $0666 ; record 15
	dw $060a ; record 16
	dw $05b3 ; record 17
	dw $0561 ; record 18
	dw $0515 ; record 19
	dw $04cc ; record 20
	dw $0486 ; record 21
	dw $0445 ; record 22
	dw $0408 ; record 23
SoundChannelMaskTable:
	; $3b4d, 256 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00, $10, $10, $10, $10, $10, $10, $10, $10 ; 0x10
	db $00, $00, $00, $00, $10, $10, $10, $10, $10, $10, $10, $10, $20, $20, $20, $20 ; 0x20
	db $00, $00, $00, $10, $10, $10, $10, $10, $20, $20, $20, $20, $20, $30, $30, $30 ; 0x30
	db $00, $00, $10, $10, $10, $10, $20, $20, $20, $20, $30, $30, $30, $30, $40, $40 ; 0x40
	db $00, $00, $10, $10, $10, $20, $20, $20, $30, $30, $30, $40, $40, $40, $50, $50 ; 0x50
	db $00, $00, $10, $10, $20, $20, $20, $30, $30, $40, $40, $40, $50, $50, $60, $60 ; 0x60
	db $00, $00, $10, $10, $20, $20, $30, $30, $40, $40, $50, $50, $60, $60, $70, $70 ; 0x70
	db $00, $10, $10, $20, $20, $30, $30, $40, $40, $50, $50, $60, $60, $70, $70, $80 ; 0x80
	db $00, $10, $10, $20, $20, $30, $40, $40, $50, $50, $60, $70, $70, $80, $80, $90 ; 0x90
	db $00, $10, $10, $20, $30, $30, $40, $50, $50, $60, $70, $70, $80, $90, $90, $a0 ; 0xa0
	db $00, $10, $10, $20, $30, $40, $40, $50, $60, $70, $70, $80, $90, $a0, $a0, $b0 ; 0xb0
	db $00, $10, $20, $20, $30, $40, $50, $60, $60, $70, $80, $90, $a0, $a0, $b0, $c0 ; 0xc0
	db $00, $10, $20, $30, $30, $40, $50, $60, $70, $80, $90, $a0, $a0, $b0, $c0, $d0 ; 0xd0
	db $00, $10, $20, $30, $40, $50, $60, $70, $70, $80, $90, $a0, $b0, $c0, $d0, $e0 ; 0xe0
	db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90, $a0, $b0, $c0, $d0, $e0, $f0 ; 0xf0
SoundPitchTable:
	; $3c4d, 240 bytes (bytes:16)
	db $00, $00, $01, $01, $00, $00, $ff, $ff, $00, $00, $01, $01, $00, $00, $ff, $ff ; 0x00
	db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $ff, $ff, $ff, $ff ; 0x10
	db $00, $01, $02, $01, $00, $ff, $fe, $ff, $00, $01, $02, $01, $00, $ff, $fe, $ff ; 0x20
	db $00, $00, $01, $01, $02, $02, $01, $01, $00, $00, $ff, $ff, $fe, $fe, $ff, $ff ; 0x30
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x40
	db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; 0x50
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x60
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02 ; 0x70
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x80
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x90
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0xa0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0xb0
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0xc0
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0xd0
	db $00, $01, $02, $02, $03, $02, $02, $01, $00, $ff, $fe, $fe, $fd, $fe, $fe, $ff ; 0xe0
LoadWavePatternIfChanged:
	ld a, [$d217] ; $3d3d
	ld b, a ; $3d40
	ldh a, [$ffda] ; $3d41
	cp a, b ; $3d43
	ret z ; $3d44
	ld [$d217], a ; $3d45
	ld e, a ; $3d48
	swap e ; $3d49
	xor a, a ; $3d4b
	ldh [rAUD3ENA], a ; $3d4c
LoadWavePattern:
	ld d, a ; $3d4e
	ld hl, WavePatternTable ; $3d4f
	push de ; $3d52
	ldh a, [$ffe9] ; $3d53
	swap a ; $3d55
	and a, $0f ; $3d57
	add a, a ; $3d59
	ld e, a ; $3d5a
	ld d, $00 ; $3d5b
	add hl, de ; $3d5d
	ld a, [hl+] ; $3d5e
	ld h, [hl] ; $3d5f
	ld l, a ; $3d60
	pop de ; $3d61
	add hl, de ; $3d62
	ld de, rAUD3WAVE_0 ; $3d63
	ld b, $10 ; $3d66
Label_00_3d68:
	ld a, [hl+] ; $3d68
	ld [de], a ; $3d69
	inc de ; $3d6a
	dec b ; $3d6b
	jr nz, Label_00_3d68 ; $3d6c
	ret ; $3d6e
GetChannelLoopSlot:
	ld a, [$d20f] ; $3d6f
	add a, a ; $3d72
	ld c, a ; $3d73
	add a, a ; $3d74
	add a, c ; $3d75
	add a, a ; $3d76
	ld c, a ; $3d77
	ld a, b ; $3d78
	and a, $0f ; $3d79
	ld b, a ; $3d7b
	add a, a ; $3d7c
	add a, b ; $3d7d
	add a, c ; $3d7e
	ld hl, $d1c0 ; $3d7f
	add a, l ; $3d82
	ld l, a ; $3d83
	ld a, $00 ; $3d84
	adc a, h ; $3d86
	ld h, a ; $3d87
	ret ; $3d88
ScaleEchoVolume:
	push de ; $3d89
	push bc ; $3d8a
	ldh a, [$ffe5] ; $3d8b
	and a, $0f ; $3d8d
	inc a ; $3d8f
	ld d, a ; $3d90
	ld bc, $0000 ; $3d91
	ldh a, [$ffd8] ; $3d94
	swap a ; $3d96
	and a, $0f ; $3d98
	inc a ; $3d9a
	ld e, a ; $3d9b
Label_00_3d9c:
	ld a, e ; $3d9c
	add a, c ; $3d9d
	ld c, a ; $3d9e
	ld a, $00 ; $3d9f
	adc a, b ; $3da1
	ld b, a ; $3da2
	dec d ; $3da3
	jr nz, Label_00_3d9c ; $3da4
	srl b ; $3da6
	rr c ; $3da8
	srl b ; $3daa
	rr c ; $3dac
	srl b ; $3dae
	rr c ; $3db0
	srl b ; $3db2
	rr c ; $3db4
	ld a, c ; $3db6
	and a, a ; $3db7
	jr nz, Label_00_3dbc ; $3db8
	ld c, $01 ; $3dba
Label_00_3dbc:
	swap c ; $3dbc
	ldh a, [$ffd8] ; $3dbe
	ld d, a ; $3dc0
	and a, $f0 ; $3dc1
	ld e, a ; $3dc3
	ldh a, [$ffe5] ; $3dc4
	and a, $0f ; $3dc6
	or a, e ; $3dc8
	ldh [$ffe5], a ; $3dc9
	ld a, d ; $3dcb
	and a, $0f ; $3dcc
	or a, c ; $3dce
	ldh [$ffd8], a ; $3dcf
	pop bc ; $3dd1
	pop de ; $3dd2
	ret ; $3dd3
WavePatternTable:
	INCBIN "data/bank_000/d_3dd4.bin" ; $3dd4, 500 bytes
	ds 56, $ff ; $3fc8, fill
