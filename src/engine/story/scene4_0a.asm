UpdateCameraFromPlayer:
	wram_bank WRAM_ACTORS ; $6235
	ld hl, wActors + ACTORF_X ; $623b
	ld a, [hl+] ; $623e
	ld b, [hl] ; $623f
	ld c, a ; $6240
	inc hl ; $6241
	ld a, [hl+] ; $6242
	ld d, [hl] ; $6243
	ld e, a ; $6244
	push de ; $6245
	ld hl, $f610 ; $6246
	add hl, bc ; $6249
	ld a, [wMapScrollMinX] ; $624a
	ld d, a ; $624d
	ld a, h ; $624e
	sub d ; $624f
	bit 7, a ; $6250
	jr z, .clampXHigh ; $6252
	ld h, d ; $6254
	ld l, $00 ; $6255
	jr .storeX ; $6257
.clampXHigh:
	ld a, [wMapWidthTiles] ; $6259
	sub $14 ; $625c
	ld d, a ; $625e
	ld a, h ; $625f
	sub d ; $6260
	bit 7, a ; $6261
	jr nz, .storeX ; $6263
	ld h, d ; $6265
	ld l, $00 ; $6266
.storeX:
	ld b, h ; $6268
	ld c, l ; $6269
	pop de ; $626a
	ld hl, $f510 ; $626b
	add hl, de ; $626e
	ld a, [wMapScrollMinY] ; $626f
	ld d, a ; $6272
	ld a, h ; $6273
	sub d ; $6274
	bit 7, a ; $6275
	jr z, .clampYHigh ; $6277
	ld h, d ; $6279
	ld l, $00 ; $627a
	jr .storeY ; $627c
.clampYHigh:
	ld a, [wMapHeightTiles] ; $627e
	sub $12 ; $6281
	ld d, a ; $6283
	ld a, h ; $6284
	sub d ; $6285
	bit 7, a ; $6286
	jr nz, .storeY ; $6288
	ld h, d ; $628a
	ld l, $00 ; $628b
.storeY:
	ld d, h ; $628d
	ld e, l ; $628e
	ld hl, wCameraX ; $628f
	ld a, c ; $6292
	ld [hl+], a ; $6293
	ld a, b ; $6294
	ld [hl+], a ; $6295
	ld a, e ; $6296
	ld [hl+], a ; $6297
	ld a, d ; $6298
	ld [hl], a ; $6299
	ret ; $629a
UnusedStepCourtSceneGfxStream:
	ld a, [wCourtSceneGfxStepsLeft] ; $629b
	or a ; $629e
	jr nz, .done ; $629f
.checkScrollX:
	ld hl, CameraFromPlayerSpriteList ; $62a1
	ld a, [wCourtSceneGfxCursor] ; $62a4
	add l ; $62a7
	ld l, a ; $62a8
	ld a, h ; $62a9
	adc $00 ; $62aa
	ld h, a ; $62ac
	ld a, [hl] ; $62ad
	cp $ff ; $62ae
	jr nz, .checkScrollY ; $62b0
	xor a ; $62b2
	ld [wCourtSceneGfxCursor], a ; $62b3
	jr .checkScrollX ; $62b6
.checkScrollY:
	ld b, a ; $62b8
	inc hl ; $62b9
	ld c, [hl] ; $62ba
	inc hl ; $62bb
	ld e, [hl] ; $62bc
	inc hl ; $62bd
	ld a, [hl] ; $62be
	push af ; $62bf
	push bc ; $62c0
	ld l, e ; $62c1
	ld h, $00 ; $62c2
	add hl, hl ; $62c4
	add hl, hl ; $62c5
	add hl, hl ; $62c6
	add hl, hl ; $62c7
	ld de, vTiles2 + VRAM_BANK1 ; $62c8
	add hl, de ; $62cb
	push hl ; $62cc
	ld l, b ; $62cd
	ld h, $00 ; $62ce
	add hl, hl ; $62d0
	add hl, hl ; $62d1
	add hl, hl ; $62d2
	add hl, hl ; $62d3
	ld bc, LoadCourtSceneGraphics ; $62d4
	add hl, bc ; $62d7
	pop de ; $62d8
	pop bc ; $62d9
	call QueueVRAMCopy ; $62da
	ld a, [wCourtSceneGfxCursor] ; $62dd
	add $04 ; $62e0
	ld [wCourtSceneGfxCursor], a ; $62e2
	pop af ; $62e5
.done:
	dec a ; $62e6
	ld [wCourtSceneGfxStepsLeft], a ; $62e7
	ret ; $62ea
CameraFromPlayerSpriteList:
	; $62eb, 13 bytes (records:4)
; 3 records x 4 bytes
	dw $1000, $0a50 ; record 0
	dw $1010, $0a50 ; record 1
	dw $1020, $0a50 ; record 2
	db $ff
LoadCourtSceneGraphics:
	push af ; $62f8
	push bc ; $62f9
	push de ; $62fa
	push hl ; $62fb
	ld [wCurrentScene], a ; $62fc
	ld h, $00 ; $62ff
	ld l, a ; $6301
	add hl, hl ; $6302
	add hl, hl ; $6303
	add hl, hl ; $6304
	add hl, hl ; $6305
	ld de, SceneGfxSlotTable ; $6306
	add hl, de ; $6309
	inc hl ; $630a
	inc hl ; $630b
	ld a, [hl+] ; $630c
	ld c, a ; $630d
	ld a, [hl+] ; $630e
	ld b, a ; $630f
	push bc ; $6310
	ld a, [hl+] ; $6311
	ld c, a ; $6312
	ld a, [hl+] ; $6313
	ld b, a ; $6314
	push bc ; $6315
	ld a, [hl+] ; $6316
	ld c, a ; $6317
	ld a, [hl+] ; $6318
	ld b, a ; $6319
	push bc ; $631a
	ld a, [hl+] ; $631b
	ld c, a ; $631c
	ld a, [hl+] ; $631d
	ld b, a ; $631e
	push bc ; $631f
	ld a, [hl+] ; $6320
	ld c, a ; $6321
	ld a, [hl+] ; $6322
	ld b, a ; $6323
	push bc ; $6324
	inc hl ; $6325
	inc hl ; $6326
	wram_bank WRAM_STAGING ; $6327
	ld a, [hl+] ; $632d
	ld h, [hl] ; $632e
	ld l, a ; $632f
	ld de, wDecompBuffer ; $6330
	call DecompressDataFromBank ; $6333
	ld hl, wDecompBuffer ; $6336
	ld de, vTiles2 + VRAM_BANK1 ; $6339
	ld c, $80 ; $633c
	call QueueVRAMCopy ; $633e
	ld hl, wTextTileBuffer ; $6341
	ld de, vTiles1 + VRAM_BANK1 ; $6344
	ld c, wTextTileBuffer_SIZE / 16 ; $6347
	call QueueVRAMCopy ; $6349
	wram_bank WRAM_ACTORS ; $634c
	pop hl ; $6352
	ld de, wScoreboardColumnAttrs ; $6353
	ld bc, wScoreboardColumnAttrs_SIZE ; $6356
	call CopyDataFromBank ; $6359
	pop hl ; $635c
	ld de, wScoreboardColumnTiles ; $635d
	ld bc, wScoreboardColumnTiles_SIZE ; $6360
	call CopyDataFromBank ; $6363
	wram_bank WRAM_COURT_PLANES ; $6366
	pop hl ; $636c
	ld de, wCourtAttrmapSaved ; $636d
	call DecompressDataFromBank ; $6370
	pop hl ; $6373
	ld de, wCourtTilemapSaved ; $6374
	call DecompressDataFromBank ; $6377
	pop hl ; $637a
	ld de, wScreenAttrmap ; $637b
	ld bc, $0040 ; $637e
	call CopyDataFromBank ; $6381
	ld hl, wScreenAttrmap + 16 ; $6384
	ld_bg_pals de, 2, 6 ; $6387
	call LoadPaletteShadow ; $638a
	ld hl, wScreenAttrmap + 1 * TILEMAP_WIDTH + 8 ; $638d
	ld_obj_pals de, 3, 1 ; $6390
	call LoadPaletteShadow ; $6393
	pop hl ; $6396
	pop de ; $6397
	pop bc ; $6398
	pop af ; $6399
	ret ; $639a
InitSceneTileAnimations:
	push af ; $639b
	push bc ; $639c
	push de ; $639d
	push hl ; $639e
	push_wram_bank WRAM_TEXT ; $639f
	ld a, $ff ; $63a8
	ld b, $01 ; $63aa
	ld hl, wSceneTileAnimState ; $63ac
	ld [hl+], a ; $63af
	ld [hl], b ; $63b0
	inc hl ; $63b1
	ld [hl+], a ; $63b2
	ld [hl], b ; $63b3
	inc hl ; $63b4
	ld [hl+], a ; $63b5
	ld [hl], b ; $63b6
	inc hl ; $63b7
	ld [hl+], a ; $63b8
	ld [hl], b ; $63b9
	inc hl ; $63ba
	ld [hl+], a ; $63bb
	ld [hl+], a ; $63bc
	ld [hl+], a ; $63bd
	ld [hl+], a ; $63be
	ld a, $00 ; $63bf
	call GetSceneSlotPtr ; $63c1
	ld de, wSceneTileAnimHeader ; $63c4
	ld bc, $0088 ; $63c7
	call CopyDataFromBank ; $63ca
	ld hl, wSceneTileAnimEntries ; $63cd
	ld a, [hl] ; $63d0
	cp $fe ; $63d1
	jr nz, .buildSlots ; $63d3
	jp .done ; $63d5
.buildSlots:
	add sp, -2 ; $63d8
	ld de, wSceneTileAnimState + 2 ; $63da
	push hl ; $63dd
	ld hl, sp + 2 ; $63de
	ld [hl], e ; $63e0
	inc hl ; $63e1
	ld [hl], d ; $63e2
	pop hl ; $63e3
	ld d, h ; $63e4
	ld e, l ; $63e5
	ld b, $ff ; $63e6
	ld c, $03 ; $63e8
	xor a ; $63ea
	ld hl, wSceneTileAnimState ; $63eb
	ld [hl], a ; $63ee
	ld hl, wSceneTileAnimStart ; $63ef
	ld [hl], a ; $63f2
	inc hl ; $63f3
.scanLoop:
	inc b ; $63f4
	ld a, [de] ; $63f5
	inc de ; $63f6
	cp $fe ; $63f7
	jr z, .listEnd ; $63f9
	cp $ff ; $63fb
	jr nz, .scanLoop ; $63fd
	inc b ; $63ff
	ld a, b ; $6400
	inc a ; $6401
	ld [hl], a ; $6402
	push de ; $6403
	push hl ; $6404
	ld hl, sp + 4 ; $6405
	ld e, [hl] ; $6407
	inc hl ; $6408
	ld d, [hl] ; $6409
	pop hl ; $640a
	ld [de], a ; $640b
	inc de ; $640c
	inc de ; $640d
	push hl ; $640e
	ld hl, sp + 4 ; $640f
	ld [hl], e ; $6411
	inc hl ; $6412
	ld [hl], d ; $6413
	pop hl ; $6414
	pop de ; $6415
	ld a, [de] ; $6416
	inc a ; $6417
	inc de ; $6418
	push hl ; $6419
	push de ; $641a
	ld d, a ; $641b
	ld a, $04 ; $641c
	sub c ; $641e
	ld hl, wSceneTileAnimState ; $641f
	ld e, a ; $6422
	ld a, d ; $6423
	ld d, $00 ; $6424
	add hl, de ; $6426
	add hl, de ; $6427
	inc hl ; $6428
	ld [hl], a ; $6429
	pop de ; $642a
	pop hl ; $642b
	inc hl ; $642c
	dec c ; $642d
	jr nz, .scanLoop ; $642e
.listEnd:
	ld a, c ; $6430
	or a ; $6431
	jr z, .install ; $6432
	ld a, $ff ; $6434
	dec hl ; $6436
	ld [hl], a ; $6437
	push hl ; $6438
	ld hl, sp + 2 ; $6439
	ld e, [hl] ; $643b
	inc hl ; $643c
	ld d, [hl] ; $643d
	pop hl ; $643e
	dec de ; $643f
	dec de ; $6440
	ld [de], a ; $6441
.install:
	ld a, $01 ; $6442
	ld hl, UpdateSceneTileAnimations ; $6444
	call RegisterFrameTask ; $6447
	add sp, 2 ; $644a
.done:
	pop_wram_bank ; $644c
	pop hl ; $6451
	pop de ; $6452
	pop bc ; $6453
	pop af ; $6454
	ret ; $6455
StopSceneTileAnimations:
	push af ; $6456
	push bc ; $6457
	push de ; $6458
	push hl ; $6459
	ld hl, UpdateSceneTileAnimations ; $645a
	call UnregisterFrameTask ; $645d
	pop hl ; $6460
	pop de ; $6461
	pop bc ; $6462
	pop af ; $6463
	ret ; $6464
UpdateSceneTileAnimations:
	test_flag FLAG_VRAM_UPDATE_BUSY ; $6465
	ret nz ; $6468
	test_flag FLAG_DEBUG_FREEZE_TILE_ANIM ; $6469
	ret nz ; $646c
	push af ; $646d
	push bc ; $646e
	push de ; $646f
	push hl ; $6470
	push_wram_bank WRAM_TEXT ; $6471
	ld de, wSceneTileAnimBuffer ; $647a
	ld hl, wSceneTileAnimBufferPtr ; $647d
	ld a, e ; $6480
	ld [hl+], a ; $6481
	ld [hl], d ; $6482
	ld c, $00 ; $6483
	ld hl, wSceneTileAnimStart ; $6485
.read:
	ld a, [hl] ; $6488
	cp $ff ; $6489
	jr z, .done ; $648b
	push hl ; $648d
	ld l, c ; $648e
	ld h, $00 ; $648f
	add hl, hl ; $6491
	ld de, wSceneTileAnimState ; $6492
	add hl, de ; $6495
	inc hl ; $6496
	ld a, [hl] ; $6497
	dec a ; $6498
	ld [hl], a ; $6499
	pop hl ; $649a
	inc hl ; $649b
	ld b, c ; $649c
	inc c ; $649d
	ld d, a ; $649e
	ld a, c ; $649f
	cp $04 ; $64a0
	jr z, .done ; $64a2
	ld a, d ; $64a4
	or a ; $64a5
	jr nz, .read ; $64a6
	ld a, b ; $64a8
	call AdvanceSceneTileAnimation ; $64a9
	ld a, c ; $64ac
	cp $04 ; $64ad
	jr nz, .read ; $64af
.done:
	pop_wram_bank ; $64b1
	pop hl ; $64b6
	pop de ; $64b7
	pop bc ; $64b8
	pop af ; $64b9
	ret ; $64ba
AdvanceSceneTileAnimation:
	push af ; $64bb
	push bc ; $64bc
	push de ; $64bd
	push hl ; $64be
	push af ; $64bf
	add sp, -1 ; $64c0
	ld hl, sp + 0 ; $64c2
	ld [hl], a ; $64c4
	ld h, $00 ; $64c5
	ld l, a ; $64c7
	add hl, hl ; $64c8
	ld bc, wSceneTileAnimState ; $64c9
	add hl, bc ; $64cc
	ld a, [hl] ; $64cd
	ld [wSceneTileAnimCursor], a ; $64ce
.applyFrame:
	ld hl, wSceneTileAnimEntries ; $64d1
	ld a, [wSceneTileAnimCursor] ; $64d4
	ld c, a ; $64d7
	ld b, $00 ; $64d8
	add hl, bc ; $64da
	ld a, [hl] ; $64db
	cp $ff ; $64dc
	jr nz, .nextEntry ; $64de
	ld hl, sp + 0 ; $64e0
	ld c, [hl] ; $64e2
	ld b, $00 ; $64e3
	ld hl, wSceneTileAnimStart ; $64e5
	add hl, bc ; $64e8
	ld a, [hl] ; $64e9
	ld [wSceneTileAnimCursor], a ; $64ea
	jr .applyFrame ; $64ed
.nextEntry:
	ld b, a ; $64ef
	inc hl ; $64f0
	ld c, [hl] ; $64f1
	inc hl ; $64f2
	ld e, [hl] ; $64f3
	inc hl ; $64f4
	ld a, [hl] ; $64f5
	push af ; $64f6
	ld d, b ; $64f7
	ld b, $00 ; $64f8
	sla c ; $64fa
	rl b ; $64fc
	sla c ; $64fe
	rl b ; $6500
	sla c ; $6502
	rl b ; $6504
	sla c ; $6506
	rl b ; $6508
	push bc ; $650a
	ld a, d ; $650b
	ld l, e ; $650c
	ld h, $00 ; $650d
	add hl, hl ; $650f
	add hl, hl ; $6510
	add hl, hl ; $6511
	add hl, hl ; $6512
	ld de, vTiles2 + VRAM_BANK1 ; $6513
	add hl, de ; $6516
	push hl ; $6517
	ld l, a ; $6518
	ld h, $00 ; $6519
	add hl, hl ; $651b
	add hl, hl ; $651c
	add hl, hl ; $651d
	add hl, hl ; $651e
	push bc ; $651f
	ld b, h ; $6520
	ld c, l ; $6521
	ld a, $06 ; $6522
	call GetSceneSlotPtr ; $6524
	push hl ; $6527
	push bc ; $6528
	ld a, h ; $6529
	ld h, $40 ; $652a
	ld de, wSceneTileAnimSrcPtr ; $652c
	ld bc, wSceneTileAnimSrcPtr_SIZE ; $652f
	call FarCopyBytes ; $6532
	pop bc ; $6535
	ld hl, wSceneTileAnimBufferPtr ; $6536
	ld a, [hl+] ; $6539
	ld d, [hl] ; $653a
	ld e, a ; $653b
	ld hl, wSceneTileAnimSrcPtr ; $653c
	ld a, [hl+] ; $653f
	ld h, [hl] ; $6540
	ld l, a ; $6541
	add hl, bc ; $6542
	pop bc ; $6543
	ld a, b ; $6544
	pop bc ; $6545
	call FarCopyBytes ; $6546
	ld hl, wSceneTileAnimBufferPtr ; $6549
	ld a, [hl+] ; $654c
	ld h, [hl] ; $654d
	ld l, a ; $654e
	pop de ; $654f
	pop bc ; $6550
	push bc ; $6551
	srl b ; $6552
	rr c ; $6554
	srl b ; $6556
	rr c ; $6558
	srl b ; $655a
	rr c ; $655c
	srl b ; $655e
	rr c ; $6560
	ld hl, wSceneTileAnimBufferPtr ; $6562
	ld a, [hl+] ; $6565
	ld h, [hl] ; $6566
	ld l, a ; $6567
	push hl ; $6568
	call QueueVRAMCopy ; $6569
	pop hl ; $656c
	pop bc ; $656d
	add hl, bc ; $656e
	ld b, h ; $656f
	ld c, l ; $6570
	ld hl, wSceneTileAnimBufferPtr ; $6571
	ld a, c ; $6574
	ld [hl+], a ; $6575
	ld [hl], b ; $6576
	ld a, [wSceneTileAnimCursor] ; $6577
	add $04 ; $657a
	ld [wSceneTileAnimCursor], a ; $657c
	pop af ; $657f
	ld d, a ; $6580
	add sp, 1 ; $6581
	pop af ; $6583
	ld h, $00 ; $6584
	ld l, a ; $6586
	add hl, hl ; $6587
	ld bc, wSceneTileAnimState ; $6588
	add hl, bc ; $658b
	ld a, [wSceneTileAnimCursor] ; $658c
	ld [hl+], a ; $658f
	ld [hl], d ; $6590
	pop hl ; $6591
	pop de ; $6592
	pop bc ; $6593
	pop af ; $6594
	ret ; $6595
