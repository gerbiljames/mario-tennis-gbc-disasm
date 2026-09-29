ReadMarioCastVictoryGrid:
	push af ; $5229
	push bc ; $522a
	push de ; $522b
	push hl ; $522c
	ld b, $3e ; $522d
	call ReadSaveBlock ; $522f
	or a ; $5232
	jr z, .restore ; $5233
	xor a ; $5235
	ld c, $06 ; $5236
	call FillMemory16 ; $5238
.restore:
	pop hl ; $523b
	pop de ; $523c
	pop bc ; $523d
	pop af ; $523e
	ret ; $523f
WriteMarioCastVictoryGrid:
	push bc ; $5240
	push de ; $5241
	push hl ; $5242
	ld b, $3e ; $5243
	ld de, $0000 ; $5245
	call WriteSaveBlock ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	ret ; $524e
Unused_03_MoveSaveEditorCursor:
	ldh a, [hPlayerInputFlags] ; $524f
	bit PADB_A, a ; $5251
	jr nz, .move ; $5253
	ld hl, hSaveEditorCursor ; $5255
	ld a, [hl+] ; $5258
	ld h, [hl] ; $5259
	ld l, a ; $525a
	ld b, l ; $525b
	ld e, c ; $525c
	call Unused_00_SignExtendEToDE ; $525d
	add hl, de ; $5260
	ld a, h ; $5261
	and $03 ; $5262
	ldh [hSaveEditorCursor + 1], a ; $5264
	ld a, l ; $5266
	ldh [hSaveEditorCursor], a ; $5267
	xor b ; $5269
	bit 7, a ; $526a
	ret ; $526c
	xor a ; $526d
	dec a ; $526e
	ret ; $526f
.move:
	sound SFX_MENU_MOVE ; $5270
	ld hl, hSaveEditorCursor ; $5272
	ld a, [hl+] ; $5275
	ld h, [hl] ; $5276
	ld l, a ; $5277
	ld de, $d300 ; $5278
	add hl, de ; $527b
	push hl ; $527c
	ld a, [hl] ; $527d
	add b ; $527e
	ld [hl], a ; $527f
	pop hl ; $5280
	res 0, l ; $5281
	ld b, l ; $5283
	ld a, [hl+] ; $5284
	ld l, [hl] ; $5285
	ld h, a ; $5286
	push hl ; $5287
	ld a, b ; $5288
	and $06 ; $5289
	add a ; $528b
	add $04 ; $528c
	ld d, a ; $528e
	ld a, b ; $528f
	and $78 ; $5290
	add a ; $5292
	swap a ; $5293
	inc a ; $5295
	ld e, a ; $5296
	pop hl ; $5297
	call PrintHexWord ; $5298
	xor a ; $529b
	ret ; $529c
Unused_03_GetCurrentSlotBlockId:
	push af ; $529d
	push hl ; $529e
	ld a, [wCurrentStorySlot] ; $529f
	and $03 ; $52a2
	ld_hl_indexed StorySlotBlockIds_03 ; $52a4
	ld b, [hl] ; $52ab
	pop hl ; $52ac
	pop af ; $52ad
	ret ; $52ae
StorySlotBlockIds_03:
	; $52af, 4 bytes (bytes:4)
	db $00, $02, $04, $0b ; 0x00
Unused_03_ReadCurrentSlotBlock:
	wram_bank WRAM_SOUND ; $52b3
	call Unused_03_GetCurrentSlotBlockId ; $52b9
	ld hl, wSaveBlockBuffer ; $52bc
	call ReadSaveBlock ; $52bf
	ret ; $52c2
Unused_03_WriteCurrentSlotBlock:
	wram_bank WRAM_SOUND ; $52c3
	call Unused_03_GetCurrentSlotBlockId ; $52c9
	ld hl, wSaveBlockBuffer ; $52cc
	call WriteSaveBlock ; $52cf
	ret ; $52d2
Unused_03_InvalidateCurrentSlotBlock:
	wram_bank WRAM_SOUND ; $52d3
	call Unused_03_GetCurrentSlotBlockId ; $52d9
	ld hl, wSaveBlockBuffer ; $52dc
	call Unused_03_InvalidateStorySlot ; $52df
	ret ; $52e2
	; $52e3, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
SaveEditorCursorTiles_03:
	INCBIN "data/bank_003/SaveEditorCursorTiles_03.bin" ; $52f0, 32 bytes
Unused_03_SaveSlotDebugEditor:
	ld hl, SaveEditorCursorTiles_03 ; $5310
	ld de, vTiles0 ; $5313
	ld c, (Unused_03_SaveSlotDebugEditor - SaveEditorCursorTiles_03) / 16 ; $5316
	call QueueVRAMCopy ; $5318
	sound BGM_EXHIBITION_MATCH ; $531b
	ld a, $03 ; $531d
	ldh [hDebugStepMode], a ; $531f
	xor a ; $5321
	ld [wCurrentStorySlot], a ; $5322
	ld hl, $0000 ; $5325
	ld a, l ; $5328
	ldh [hSaveEditorCursor], a ; $5329
	ld a, h ; $532b
	ldh [hSaveEditorCursor + 1], a ; $532c
	farcall InitTextWindows ; $532e
	call EnableLCD ; $5331
	ld c, $7f ; $5334
	call BeginFadeOut ; $5336
	script_fade_in $7f ; $5339
	farcall InitStoryModeState ; $533e
	ld de, $0000 ; $5341
.loop:
	call Unused_03_ReadCurrentSlotBlock ; $5344
	or a ; $5347
	jr z, .zero ; $5348
	push de ; $534a
	ld hl, SaveResultFailedString_03 ; $534b
	lb de, $05, $11 ; $534e column, row
	call PrintString ; $5351
	pop de ; $5354
	ld hl, $d300 ; $5355
	ld c, $30 ; $5358
	call ClearMemory16 ; $535a
	jp .loopB ; $535d
.zero:
	ld hl, SaveResultLoadedString_03 ; $5360
	lb de, $05, $11 ; $5363 column, row
	call PrintString ; $5366
.loopB:
	wram_bank WRAM_SOUND ; $5369
	push de ; $536f
	ld hl, hSaveEditorCursor ; $5370
	ld a, [hl+] ; $5373
	ld h, [hl] ; $5374
	ld l, a ; $5375
	ld de, $d300 ; $5376
	add hl, de ; $5379
	ld a, l ; $537a
	and $80 ; $537b
	ld l, a ; $537d
	ld b, $10 ; $537e
	ld e, $01 ; $5380
.loop2:
	ld d, $00 ; $5382
	push bc ; $5384
	push de ; $5385
	push hl ; $5386
	ld a, h ; $5387
	sub $d3 ; $5388
	ld h, a ; $538a
	call PrintHexWord ; $538b
	pop hl ; $538e
	pop de ; $538f
	inc d ; $5390
	inc d ; $5391
	inc d ; $5392
	inc d ; $5393
	ld c, $04 ; $5394
.loop3:
	push hl ; $5396
	ld a, [hl+] ; $5397
	ld l, [hl] ; $5398
	ld h, a ; $5399
	push de ; $539a
	push bc ; $539b
	call PrintHexWord ; $539c
	pop bc ; $539f
	pop de ; $53a0
	pop hl ; $53a1
	inc hl ; $53a2
	inc hl ; $53a3
	inc d ; $53a4
	inc d ; $53a5
	inc d ; $53a6
	inc d ; $53a7
	dec c ; $53a8
	jr nz, .loop3 ; $53a9
	inc e ; $53ab
	pop bc ; $53ac
	dec b ; $53ad
	jr nz, .loop2 ; $53ae
	pop de ; $53b0
.loop4:
	push de ; $53b1
	ld hl, hSaveEditorCursor ; $53b2
	ld a, [hl+] ; $53b5
	ld h, [hl] ; $53b6
	ld l, a ; $53b7
	ld de, $1011 ; $53b8
	call PrintHexWord ; $53bb
	ld a, [wCurrentStorySlot] ; $53be
	ld de, $0011 ; $53c1
	call PrintDecimalByte ; $53c4
	pop de ; $53c7
.loop5:
	ldh a, [hPlayerInputFlags] ; $53c8
	bit PADB_A, a ; $53ca
	jr nz, .step2 ; $53cc
	ldh a, [hVBlankCounter] ; $53ce
	bit 3, a ; $53d0
	jr z, .advanceFrame ; $53d2
.step2:
	push de ; $53d4
	ldh a, [hSaveEditorCursor] ; $53d5
	ld e, a ; $53d7
	and $07 ; $53d8
	swap a ; $53da
	add $24 ; $53dc
	ld d, a ; $53de
	ld a, e ; $53df
	and $78 ; $53e0
	add $0c ; $53e2
	ld e, a ; $53e4
	lb bc, $00, $00 ; $53e5 attr, tile
	push de ; $53e8
	call QueueSprite ; $53e9
	pop de ; $53ec
	lb bc, $00, $00 ; $53ed attr, tile
	ld a, d ; $53f0
	add $08 ; $53f1
	ld d, a ; $53f3
	call QueueSprite ; $53f4
	pop de ; $53f7
.advanceFrame:
	call AdvanceFrame ; $53f8
	ldh a, [hInputPressed] ; $53fb
	bit PADB_UP, a ; $53fd
	jr z, .moveSaveEditorCursor ; $53ff
	ld bc, $f0f8 ; $5401
	call Unused_03_MoveSaveEditorCursor ; $5404
	jr z, .loop4 ; $5407
	jp .loopB ; $5409
.moveSaveEditorCursor:
	bit 5, a ; $540c
	jr z, .bit5Clear ; $540e
	ld bc, $ffff ; $5410
	call Unused_03_MoveSaveEditorCursor ; $5413
	jr z, .loop4 ; $5416
	jp .loopB ; $5418
.bit5Clear:
	bit 4, a ; $541b
	jr z, .bit4Clear ; $541d
	ld bc, $0101 ; $541f
	call Unused_03_MoveSaveEditorCursor ; $5422
	jr z, .loop4 ; $5425
	jp .loopB ; $5427
.bit4Clear:
	bit 7, a ; $542a
	jr z, .positive ; $542c
	ld bc, $1008 ; $542e
	call Unused_03_MoveSaveEditorCursor ; $5431
	jp z, .loop4 ; $5434
	jp .loopB ; $5437
.positive:
	bit 1, a ; $543a
	jr z, .bit1Clear ; $543c
	ld a, [wCurrentStorySlot] ; $543e
	push af ; $5441
	ld a, STORYSLOT_NONE ; $5442
	ld [wCurrentStorySlot], a ; $5444
	call Unused_03_ReadCurrentSlotBlock ; $5447
	or a ; $544a
	jr nz, .restore ; $544b
	ld hl, $d300 ; $544d
	ld a, [hl+] ; $5450
	or [hl] ; $5451
	jr z, .restore ; $5452
	inc hl ; $5454
	ld a, $01 ; $5455
	ld [hl+], a ; $5457
	ld [hl+], a ; $5458
	ld [hl+], a ; $5459
	ld [hl+], a ; $545a
	ld [hl+], a ; $545b
	ld [hl+], a ; $545c
	call Unused_03_WriteCurrentSlotBlock ; $545d
	pop af ; $5460
	sound JINGLE_DONE_FOR_THE_DAY ; $5461
	jp .loop ; $5463
.restore:
	pop af ; $5466
	ld [wCurrentStorySlot], a ; $5467
	jp .loop ; $546a
.bit1Clear:
	bit 2, a ; $546d
	jr z, .bit2Clear ; $546f
	sound SFX_MENU_SELECT ; $5471
	ld a, [wCurrentStorySlot] ; $5473
	inc a ; $5476
	and $03 ; $5477
	ld [wCurrentStorySlot], a ; $5479
	jp .loop ; $547c
.bit2Clear:
	bit 3, a ; $547f
	jr z, .skipSave ; $5481
	sound SFX_MENU_SELECT ; $5483
	ldh a, [hPlayerInputFlags] ; $5485
	bit PADB_A, a ; $5487
	jr nz, .bit3Set ; $5489
	push de ; $548b
	ld hl, SaveResultSavedString_03 ; $548c
	lb de, $05, $11 ; $548f column, row
	call PrintString ; $5492
	call Unused_03_WriteCurrentSlotBlock ; $5495
	pop de ; $5498
	jp .loop4 ; $5499
.bit3Set:
	push de ; $549c
	ld hl, SaveResultDeletedString_03 ; $549d
	lb de, $05, $11 ; $54a0 column, row
	call PrintString ; $54a3
	call Unused_03_InvalidateCurrentSlotBlock ; $54a6
	jp .loop4 ; $54a9
	db $d1 ; $54ac
.skipSave:
	jp .loop5 ; $54ad
SaveResultFailedString_03:
	; $54b0, 12 bytes (ascii)
	db "FAILED     ", $00
SaveResultLoadedString_03:
	; $54bc, 12 bytes (ascii)
	db "LOADED     ", $00
SaveResultSavedString_03:
	; $54c8, 12 bytes (ascii)
	db "SAVED      ", $00
SaveResultDeletedString_03:
	; $54d4, 12 bytes (ascii)
	db "DELETED    ", $00
SaveResultBlankString_03:
	; $54e0, 8 bytes (ascii)
	db "      ", $00, $00
UnusedByteRamp_03:
	; $54e8, 13 bytes (bytes:13)
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d ; 0x00
	; $54f5, 8 bytes (fill)
	ds 8, $00
MarioGolfSignature_03:
	; $54fd, 16 bytes (ascii)
	db "MARIO GOLF GB CH"
RestoreStoryBlockFromBackup:
	ld hl, wDecompBuffer ; $550d
	call ReadSaveBlock ; $5510
	cp $ff ; $5513
	ret nz ; $5515
	push bc ; $5516
	ld a, $1b ; $5517
	add b ; $5519
	ld b, a ; $551a
	call ReadSaveBlock ; $551b
	or a ; $551e
	jr nz, .restore ; $551f
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $5521
	call ReadSaveBlockTag ; $5524
	pop bc ; $5527
	ld hl, wDecompBuffer ; $5528
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $552b
	call WriteSaveBlock ; $552e
	ret ; $5531
.restore:
	pop bc ; $5532
	call InvalidateSaveBlock ; $5533
	inc b ; $5536
	call InvalidateSaveBlock ; $5537
	ret ; $553a
Unused_03_InvalidateBlockIfUnwritten:
	ld hl, $d000 ; $553b
	call ReadSaveBlock ; $553e
	cp $ff ; $5541
	ret nz ; $5543
	call InvalidateSaveBlock ; $5544
	ret ; $5547
Unused_03_RestoreBlockOrClear:
	ld hl, $d000 ; $5548
	call ReadSaveBlock ; $554b
	cp $ff ; $554e
	ret nz ; $5550
	push bc ; $5551
	ld a, $1b ; $5552
	add b ; $5554
	ld b, a ; $5555
	call ReadSaveBlock ; $5556
	or a ; $5559
	jr nz, .nonZero ; $555a
	pop bc ; $555c
	ld hl, $d000 ; $555d
	ld de, $0000 ; $5560
	call WriteSaveBlock ; $5563
	ret ; $5566
.nonZero:
	push bc ; $5567
	ld hl, $d000 ; $5568
	ld c, $20 ; $556b
	call ClearMemory16 ; $556d
	pop bc ; $5570
	ld hl, $d000 ; $5571
	ld de, $0000 ; $5574
	call WriteSaveBlock ; $5577
	ret ; $557a
Unused_03_RestoreBlock06FromBackup:
	ld b, $06 ; $557b
	ld hl, $d000 ; $557d
	call ReadSaveBlock ; $5580
	cp $ff ; $5583
	ret nz ; $5585
	ld b, $21 ; $5586
	call ReadSaveBlock ; $5588
	or a ; $558b
	jr nz, .nonZero2 ; $558c
	ld b, $06 ; $558e
	ld hl, $d000 ; $5590
	ld de, $0000 ; $5593
	call WriteSaveBlock ; $5596
	ret ; $5599
.nonZero2:
	ld b, $06 ; $559a
	call InvalidateSaveBlock ; $559c
	ld b, $21 ; $559f
	call InvalidateSaveBlock ; $55a1
	ret ; $55a4
Unused_03_RestoreBlock07FromBackup:
	ld b, $07 ; $55a5
	ld hl, $d000 ; $55a7
	call ReadSaveBlock ; $55aa
	cp $ff ; $55ad
	ret nz ; $55af
	ld b, $22 ; $55b0
	call ReadSaveBlock ; $55b2
	or a ; $55b5
	jr nz, .nonZero3 ; $55b6
	ld b, $07 ; $55b8
	ld hl, $d000 ; $55ba
	ld de, $0000 ; $55bd
	call WriteSaveBlock ; $55c0
	ret ; $55c3
.nonZero3:
	ld b, $07 ; $55c4
	call InvalidateSaveBlock ; $55c6
	ld b, $22 ; $55c9
	call InvalidateSaveBlock ; $55cb
	ret ; $55ce
Unused_03_RestoreBlock08FromBackup:
	ld b, $08 ; $55cf
	ld hl, $d000 ; $55d1
	call ReadSaveBlock ; $55d4
	cp $ff ; $55d7
	ret nz ; $55d9
	ld b, $23 ; $55da
	call ReadSaveBlock ; $55dc
	or a ; $55df
	jr nz, .nonZero4 ; $55e0
	ld b, $08 ; $55e2
	ld hl, $d000 ; $55e4
	ld de, $0000 ; $55e7
	call WriteSaveBlock ; $55ea
	ret ; $55ed
.nonZero4:
	ld b, $08 ; $55ee
	call InvalidateSaveBlock ; $55f0
	ld b, $23 ; $55f3
	call InvalidateSaveBlock ; $55f5
	ret ; $55f8
Unused_03_RestoreBlock09FromBackup:
	ld b, $09 ; $55f9
	ld hl, $d000 ; $55fb
	call ReadSaveBlock ; $55fe
	cp $ff ; $5601
	ret nz ; $5603
	ld b, $24 ; $5604
	call ReadSaveBlock ; $5606
	or a ; $5609
	jr nz, .nonZero5 ; $560a
	ld b, $09 ; $560c
	ld hl, $d000 ; $560e
	ld de, $0000 ; $5611
	call WriteSaveBlock ; $5614
	ret ; $5617
.nonZero5:
	ld b, $09 ; $5618
	call InvalidateSaveBlock ; $561a
	ld b, $24 ; $561d
	call InvalidateSaveBlock ; $561f
	ret ; $5622
Unused_03_RestoreBlock0aFromBackup:
	ld b, $0a ; $5623
	ld hl, $d000 ; $5625
	call ReadSaveBlock ; $5628
	cp $ff ; $562b
	ret nz ; $562d
	ld b, $25 ; $562e
	call ReadSaveBlock ; $5630
	or a ; $5633
	jr nz, .nonZero6 ; $5634
	ld b, $0a ; $5636
	ld hl, $d000 ; $5638
	ld de, $0000 ; $563b
	call WriteSaveBlock ; $563e
	ret ; $5641
.nonZero6:
	ld b, $0a ; $5642
	call InvalidateSaveBlock ; $5644
	ld b, $25 ; $5647
	call InvalidateSaveBlock ; $5649
	ret ; $564c
Unused_03_ClearBlockIfSet:
	ld hl, $d000 ; $564d
	call ReadSaveBlock ; $5650
	or a ; $5653
	ret z ; $5654
	push bc ; $5655
	ld hl, $d000 ; $5656
	ld c, $28 ; $5659
	call ClearMemory16 ; $565b
	pop bc ; $565e
	ld hl, $d000 ; $565f
	ld de, $0000 ; $5662
	call WriteSaveBlock ; $5665
	ret ; $5668
