TextCmdNop2:
	ret ; $5297
GetNextArgShortTextLength:
	push bc ; $5298
	push hl ; $5299
	ld a, [wTextArgShortTextMeasureIndex] ; $529a
	ld b, $00 ; $529d
	ld c, a ; $529f
	inc a ; $52a0
	ld [wTextArgShortTextMeasureIndex], a ; $52a1
	ld hl, wTextArgShortTextQueue ; $52a4
	add hl, bc ; $52a7
	ld a, [hl] ; $52a8
	ld l, a ; $52a9
	ld h, $00 ; $52aa
	ld b, h ; $52ac
	ld c, l ; $52ad
	ld hl, $0000 ; $52ae
	add hl, bc ; $52b1
	call FetchShortText ; $52b2
	ld hl, wShortTextBuffer ; $52b5
	ld b, $00 ; $52b8
.loop:
	ld a, [hl+] ; $52ba
	cp $00 ; $52bb
	jr z, .eq00 ; $52bd
	cp $de ; $52bf
	jr z, .loop ; $52c1
	cp $df ; $52c3
	jr z, .loop ; $52c5
	inc b ; $52c7
	jr .loop ; $52c8
.eq00:
	ld a, b ; $52ca
	pop hl ; $52cb
	pop bc ; $52cc
	ret ; $52cd
TextCmdPrintArgNumber:
	push bc ; $52ce
	push_wram_bank $05 ; $52cf
	ld a, [wTextArgNumberCount] ; $52d8
	ld b, a ; $52db
	ld a, [wTextArgNumberWriteIndex] ; $52dc
	cp b ; $52df
	jr z, .restore ; $52e0
	ld b, $00 ; $52e2
	ld c, a ; $52e4
	sla c ; $52e5
	inc a ; $52e7
	ld [wTextArgNumberWriteIndex], a ; $52e8
	ld hl, wTextArgNumberQueue ; $52eb
	add hl, bc ; $52ee
	ld c, [hl] ; $52ef
	inc hl ; $52f0
	ld b, [hl] ; $52f1
	pop_wram_bank ; $52f2
	ld h, b ; $52f7
	ld l, c ; $52f8
	call RenderInlineNumber ; $52f9
	jr .restore2 ; $52fc
.restore:
	pop_wram_bank ; $52fe
.restore2:
	pop bc ; $5303
	ret ; $5304
MeasureNextArgNumberWidth:
	push hl ; $5305
	push bc ; $5306
	push de ; $5307
	ld a, [wTextArgNumberMeasureIndex] ; $5308
	ld b, $00 ; $530b
	ld c, a ; $530d
	sla c ; $530e
	inc a ; $5310
	ld [wTextArgNumberMeasureIndex], a ; $5311
	ld hl, wTextArgNumberQueue ; $5314
	add hl, bc ; $5317
	ld e, [hl] ; $5318
	inc hl ; $5319
	ld d, [hl] ; $531a
	ld h, d ; $531b
	ld l, e ; $531c
	ld bc, $d8f0 ; $531d
	ld de, $2710 ; $5320
	add hl, bc ; $5323
	ld a, $05 ; $5324
	bit 7, h ; $5326
	jr z, IsTileBlockedAt.step ; $5328
	add hl, de ; $532a
.loop:
	add hl, bc ; $532b
	bit 7, h ; $532c
	jr z, .loop ; $532e
	add hl, de ; $5330
	ld bc, $fc18 ; $5331
	ld de, $03e8 ; $5334
	add hl, bc ; $5337
	ld a, $04 ; $5338
	bit 7, h ; $533a
	jr z, IsTileBlockedAt.step ; $533c
	add hl, de ; $533e
.loopB:
	add hl, bc ; $533f
	bit 7, h ; $5340
	jr z, .loopB ; $5342
	add hl, de ; $5344
	ld bc, hSpriteQueueBase ; $5345
	ld de, $0064 ; $5348
IsTileBlockedAt:
	add hl, bc ; $534b
	ld a, $03 ; $534c
	bit 7, h ; $534e
	jr z, .step ; $5350
	add hl, de ; $5352
.loop:
	add hl, bc ; $5353
	bit 7, h ; $5354
	jr z, .loop ; $5356
	add hl, de ; $5358
	ld bc, $fff6 ; $5359
	ld de, $000a ; $535c
	add hl, bc ; $535f
	ld a, $02 ; $5360
	bit 7, h ; $5362
	jr z, .step ; $5364
	add hl, de ; $5366
.loopB:
	add hl, bc ; $5367
	bit 7, h ; $5368
	jr z, .loopB ; $536a
	add hl, de ; $536c
	ld a, $01 ; $536d
.step:
	ld b, $00 ; $536f
.loop2:
	push af ; $5371
	push hl ; $5372
	dec a ; $5373
	add a ; $5374
	ld hl, PowersOfTen_05 ; $5375
	add l ; $5378
	ld l, a ; $5379
	jr nc, .read ; $537a
	inc h ; $537c
.read:
	ld a, [hl+] ; $537d
	ld d, [hl] ; $537e
	ld e, a ; $537f
	pop hl ; $5380
	xor a ; $5381
.loop3:
	ld a, l ; $5382
	sub e ; $5383
	ld l, a ; $5384
	ld a, h ; $5385
	sbc d ; $5386
	ld h, a ; $5387
	bit 7, h ; $5388
	jr nz, .offset ; $538a
	inc a ; $538c
	jr .loop3 ; $538d
.offset:
	add hl, de ; $538f
	ld c, $30 ; $5390
	add c ; $5392
	call GetGlyphWidth ; $5393
	ld a, c ; $5396
	add b ; $5397
	ld b, a ; $5398
	pop af ; $5399
	dec a ; $539a
	jr nz, .loop2 ; $539b
	ld a, b ; $539d
	pop de ; $539e
	pop bc ; $539f
	pop hl ; $53a0
	ret ; $53a1
PowersOfTen_05:
	; $53a2, 10 bytes (records:2)
	dw $0001 ; record 0
	dw $000a ; record 1
	dw $0064 ; record 2
	dw $03e8 ; record 3
	dw $2710 ; record 4
StubNop_05_2:
	ret ; $53ac
	ret ; $53ad
Unused_05_SetTextVar:
	push af ; $53ae
	push bc ; $53af
	push de ; $53b0
	push hl ; $53b1
	ld b, a ; $53b2
	push_wram_bank $05 ; $53b3
	ld a, b ; $53bc
	ld [wUnusedTextByte], a ; $53bd
	pop_wram_bank ; $53c0
	pop hl ; $53c5
	pop de ; $53c6
	pop bc ; $53c7
	pop af ; $53c8
	ret ; $53c9
TextCmdPrintShortText:
	push af ; $53ca
	push bc ; $53cb
	ld a, [wTextCharNameArg] ; $53cc
	push de ; $53cf
	ld hl, $001b ; $53d0
	add l ; $53d3
	ld l, a ; $53d4
	jr nc, .fetchShortTextToBuffer ; $53d5
	inc h ; $53d7
.fetchShortTextToBuffer:
	ld de, wInlineTextBuffer ; $53d8
	call FetchShortTextToBuffer ; $53db
	pop de ; $53de
	ld hl, wInlineTextBuffer ; $53df
	call RenderInlineString ; $53e2
	pop bc ; $53e5
	pop af ; $53e6
	ret ; $53e7
MeasureIndexedShortTextWidth:
	push bc ; $53e8
	push de ; $53e9
	push hl ; $53ea
	ld a, [wTextCharNameArg] ; $53eb
	ld hl, $001b ; $53ee
	add l ; $53f1
	ld l, a ; $53f2
	jr nc, .fetchShortTextToBuffer ; $53f3
	inc h ; $53f5
.fetchShortTextToBuffer:
	ld de, wInlineTextBuffer ; $53f6
	farcall FetchShortTextToBuffer ; $53f9
	ld hl, wInlineTextBuffer ; $53fc
	ld b, $00 ; $53ff
.loop:
	ld a, [hl+] ; $5401
	cp $00 ; $5402
	jr z, .eq00 ; $5404
	call GetGlyphWidth ; $5406
	ld a, c ; $5409
	add b ; $540a
	ld b, a ; $540b
	jr .loop ; $540c
.eq00:
	ld a, b ; $540e
	pop hl ; $540f
	pop de ; $5410
	pop bc ; $5411
	ret ; $5412
WrapTextCellPointer:
	push af ; $5413
	push hl ; $5414
	ld h, d ; $5415
	ld l, e ; $5416
	srl h ; $5417
	rr l ; $5419
	srl h ; $541b
	rr l ; $541d
	srl l ; $541f
	sra l ; $5421
	sra l ; $5423
	ld a, [wTextCursorRow] ; $5425
	cp l ; $5428
	jr z, .step ; $5429
	ld a, e ; $542b
	sub $20 ; $542c
	ld e, a ; $542e
	jr nc, .step ; $542f
	ld e, a ; $5431
	dec d ; $5432
.step:
	ld a, d ; $5433
	and $03 ; $5434
	ld h, a ; $5436
	or $d0 ; $5437
	ld d, a ; $5439
	pop hl ; $543a
	pop af ; $543b
	ret ; $543c
WrapTextCellPointerPrevRow:
	push af ; $543d
	push hl ; $543e
	ld h, d ; $543f
	ld l, e ; $5440
	srl h ; $5441
	rr l ; $5443
	srl h ; $5445
	rr l ; $5447
	srl l ; $5449
	srl l ; $544b
	srl l ; $544d
	ld a, [wTextCursorRow] ; $544f
	dec a ; $5452
	and $1f ; $5453
	cp l ; $5455
	jr z, .step ; $5456
	ld a, e ; $5458
	sub $20 ; $5459
	ld e, a ; $545b
	jr nc, .step ; $545c
	and $3f ; $545e
	ld e, a ; $5460
	dec d ; $5461
.step:
	ld a, d ; $5462
	and $03 ; $5463
	ld h, a ; $5465
	or $d0 ; $5466
	ld d, a ; $5468
	pop hl ; $5469
	pop af ; $546a
	ret ; $546b
DispatchControlCode:
	push hl ; $546c
	ld hl, ControlCodeDispatchReturn ; $546d
	push hl ; $5470
	push af ; $5471
	push bc ; $5472
	push de ; $5473
	sla a ; $5474
	ld hl, ControlCodeHandlers_05 ; $5476
	ld c, a ; $5479
	ld b, $00 ; $547a
	add hl, bc ; $547c
	ld d, h ; $547d
	ld e, l ; $547e
	ld a, [de] ; $547f
	ld l, a ; $5480
	inc de ; $5481
	ld a, [de] ; $5482
	ld h, a ; $5483
	pop de ; $5484
	pop bc ; $5485
	pop af ; $5486
	jp hl ; $5487
ControlCodeDispatchReturn:
	pop hl ; $5488
	ret ; $5489
ControlCodeHandler16:
	ret ; $548a
ControlCodeHandler17:
	ret ; $548b
ControlCodeHandler18:
	ret ; $548c
ControlCodeHandler19:
	ret ; $548d
TextCmdNop0:
	ret ; $548e
ControlCodeHandlers_05:
	; $548f, 64 bytes (records:2)
	dw TextCmdNop0 ; record 0
	dw TextCmdNewline ; record 1
	dw TextCmdWaitButtonPage ; record 2
	dw WaitTextAdvanceInput ; record 3
	dw TextCmdPrintArgString ; record 4
	dw TextCmdDelay30 ; record 5
	dw TextCmdDelay15Skippable ; record 6
	dw TextCmdPrintPlayerName ; record 7
	dw TextCmdNop2 ; record 8
	dw TextCmdPrintArgNumber ; record 9
	dw TextCmdNop ; record 10
	dw TextCmdPrintPartnerName ; record 11
	dw TextCmdDelay150Skippable ; record 12
	dw TextCmdNextGlyphStreamRow ; record 13
	dw TextCmdPrintShortText ; record 14
	dw TextCmdNewline ; record 15
	dw ControlCodeHandler16 ; record 16
	dw ControlCodeHandler17 ; record 17
	dw ControlCodeHandler18 ; record 18
	dw ControlCodeHandler19 ; record 19
	dw TextCmdNewline ; record 20
	dw TextCmdNewline ; record 21
	dw TextCmdNewline ; record 22
	dw TextCmdNewline ; record 23
	dw TextCmdNewline ; record 24
	dw TextCmdNewline ; record 25
	dw TextCmdNewline ; record 26
	dw TextCmdNewline ; record 27
	dw TextCmdNewline ; record 28
	dw TextCmdNewline ; record 29
	dw TextCmdApplyDakuten ; record 30
	dw TextCmdApplyHandakuten ; record 31
RenderInlineString:
	push af ; $54cf
	ld a, [wTextStreamPtr + 1] ; $54d0
	cp $c6 ; $54d3
	jr nz, .checkWrap ; $54d5
	ld a, [wTextStreamPtr] ; $54d7
	or a ; $54da
	jr z, .charLoop ; $54db
.checkWrap:
	dec de ; $54dd
	ld a, [de] ; $54de
	inc de ; $54df
	cp $05 ; $54e0
	jr z, .charLoop ; $54e2
	ld a, e ; $54e4
	and $1f ; $54e5
	jr nz, .charLoop ; $54e7
	push hl ; $54e9
	ld h, d ; $54ea
	ld l, e ; $54eb
	ld de, $ffe0 ; $54ec
	add hl, de ; $54ef
	ld d, h ; $54f0
	ld e, l ; $54f1
	pop hl ; $54f2
.charLoop:
	ld a, [hl] ; $54f3
	cp $00 ; $54f4
	jr z, .done ; $54f6
	test_flag FLAG_PROPORTIONAL_TEXT_MODE ; $54f8
	jr nz, .proportional ; $54fb
	call DrawInlineGlyph ; $54fd
	call UploadLastGlyphTiles ; $5500
	jr .checkMark ; $5503
.proportional:
	call StampGlyphTileAtPen ; $5505
	call DrawInlineGlyph ; $5508
	call StampGlyphTileAtPen ; $550b
	call UploadLastGlyphTiles ; $550e
.checkMark:
	inc hl ; $5511
	ld a, [hl] ; $5512
	cp $de ; $5513
	jr z, .markChar ; $5515
	cp $df ; $5517
	jr nz, .nextCell ; $5519
.markChar:
	push hl ; $551b
	push bc ; $551c
	ld h, d ; $551d
	ld l, e ; $551e
	ld bc, $ffe0 ; $551f
	add hl, bc ; $5522
	push af ; $5523
	ld a, [wShadowTilemapPtr + 1] ; $5524
	ld c, a ; $5527
	ld a, h ; $5528
	cp c ; $5529
	jr nc, .cellPtrOk ; $552a
	ld bc, $0400 ; $552c
	add hl, bc ; $552f
.cellPtrOk:
	pop af ; $5530
	ld b, a ; $5531
	ld a, [hl] ; $5532
	cp $03 ; $5533
	ld a, b ; $5535
	jr nz, .writeMark ; $5536
	sub $d0 ; $5538
.writeMark:
	ld [hl], a ; $553a
	pop bc ; $553b
	pop hl ; $553c
	inc hl ; $553d
.nextCell:
	call DelayTextCharacter ; $553e
	inc de ; $5541
	ld a, e ; $5542
	and $1f ; $5543
	jr nz, .charLoop ; $5545
	push hl ; $5547
	ld h, d ; $5548
	ld l, e ; $5549
	ld de, $ffe0 ; $554a
	add hl, de ; $554d
	ld d, h ; $554e
	ld e, l ; $554f
	pop hl ; $5550
	jr .charLoop ; $5551
.done:
	pop af ; $5553
	ret ; $5554
Unused_05_RenderInlineHexByte:
	push af ; $5555
	push bc ; $5556
	push hl ; $5557
	add sp, -10 ; $5558
	ld hl, sp + 0 ; $555a
	push de ; $555c
	ld d, h ; $555d
	ld e, l ; $555e
	ld b, h ; $555f
	ld c, l ; $5560
	ld h, $00 ; $5561
	ld l, a ; $5563
	call FormatHexWord ; $5564
	jp RenderInlineNumber.zero ; $5567
; PrintHexWord without its push de and with a jp tail: the inline-argument variant of the same renderer. Nothing calls it.
Unused_05_RenderInlineHexWord:
	push af ; $556a
	push bc ; $556b
	push hl ; $556c
	ld b, h ; $556d
	ld c, l ; $556e
	add sp, -10 ; $556f
	ld hl, sp + 0 ; $5571
	push de ; $5573
	ld d, h ; $5574
	ld e, l ; $5575
	ld h, b ; $5576
	ld l, c ; $5577
	ld b, d ; $5578
	ld c, e ; $5579
	call FormatHexWord ; $557a
	jp RenderInlineNumber.zero ; $557d
; PrintDecimalByte without its push de and with a jp tail: the inline-argument variant of the same renderer. Nothing calls it.
Unused_05_RenderInlineDecimalByte:
	push af ; $5580
	push bc ; $5581
	push hl ; $5582
	add sp, -10 ; $5583
	ld hl, sp + 0 ; $5585
	push de ; $5587
	ld d, h ; $5588
	ld e, l ; $5589
	ld b, h ; $558a
	ld c, l ; $558b
	ld h, $00 ; $558c
	ld l, a ; $558e
	ld a, $04 ; $558f
	call FormatDecimalNumber ; $5591
	jp RenderInlineNumber.zero ; $5594
RenderInlineNumber:
	push af ; $5597
	push bc ; $5598
	push hl ; $5599
	ld b, h ; $559a
	ld c, l ; $559b
	add sp, -10 ; $559c
	ld hl, sp + 0 ; $559e
	push de ; $55a0
	ld d, h ; $55a1
	ld e, l ; $55a2
	ld h, b ; $55a3
	ld l, c ; $55a4
	ld b, d ; $55a5
	ld c, e ; $55a6
	ld a, $00 ; $55a7
	call FormatDecimalNumber ; $55a9
	ld a, [wTextNumberRightAlign] ; $55ac
	or a ; $55af
	jr z, .zero ; $55b0
	push bc ; $55b2
	ld h, b ; $55b3
	ld l, c ; $55b4
	ld d, $00 ; $55b5
	ld e, $05 ; $55b7
.loop:
	ld a, [hl+] ; $55b9
	or a ; $55ba
	jr z, .restore ; $55bb
	dec e ; $55bd
	jr nz, .loop ; $55be
.restore:
	pop bc ; $55c0
	pop hl ; $55c1
	add hl, de ; $55c2
	ld d, h ; $55c3
	ld e, l ; $55c4
	ld h, b ; $55c5
	ld l, c ; $55c6
	jr .renderInlineString ; $55c7
.zero:
	ld h, b ; $55c9
	ld l, c ; $55ca
	pop de ; $55cb
.renderInlineString:
	call RenderInlineString ; $55cc
	add sp, 10 ; $55cf
	pop hl ; $55d1
	pop bc ; $55d2
	pop af ; $55d3
	ret ; $55d4
