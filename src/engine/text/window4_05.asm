GetSpeakerVoice:
	push bc ; $608a
	push de ; $608b
	push hl ; $608c
	call GetObjectSlotPointer ; $608d
	ld a, h ; $6090
	ld b, $08 ; $6091
	or l ; $6093
	jr z, .done ; $6094
	push_wram_bank WRAM_ACTORS ; $6096
	ld a, l ; $609f
	ldh [hActorPtr], a ; $60a0
	ld a, h ; $60a2
	ldh [hActorPtr + 1], a ; $60a3
	ld hl, hActorPtr ; $60a5
	ld a, [hl+] ; $60a8
	ld h, [hl] ; $60a9
	add $21 ; $60aa
	ld l, a ; $60ac
	ld a, [hl] ; $60ad
	ld c, a ; $60ae
	sub $1e ; $60af
	bit 7, a ; $60b1
	ld b, $08 ; $60b3
	jr nz, .done ; $60b5
	ld l, a ; $60b7
	ld h, $00 ; $60b8
	add hl, hl ; $60ba
	ld de, SpeakerVoiceActorTypePropertyTable ; $60bb
	add hl, de ; $60be
	inc hl ; $60bf
	ld b, [hl] ; $60c0
	pop_wram_bank ; $60c1
.done:
	ld a, b ; $60c6
	pop hl ; $60c7
	pop de ; $60c8
	pop bc ; $60c9
	ret ; $60ca
SpeakerVoiceActorTypePropertyTable:
	; $60cb, 175 bytes (bytes:2)
	db $1e, $04 ; 0x00
	db $1f, $03 ; 0x02
	db $20, $04 ; 0x04
	db $21, $06 ; 0x06
	db $22, $05 ; 0x08
	db $23, $07 ; 0x0a
	db $24, $07 ; 0x0c
	db $25, $04 ; 0x0e
	db $26, $08 ; 0x10
	db $27, $08 ; 0x12
	db $28, $04 ; 0x14
	db $29, $03 ; 0x16
	db $2a, $05 ; 0x18
	db $2b, $07 ; 0x1a
	db $2c, $08 ; 0x1c
	db $2d, $06 ; 0x1e
	db $2e, $01 ; 0x20
	db $2f, $03 ; 0x22
	db $30, $04 ; 0x24
	db $31, $04 ; 0x26
	db $32, $04 ; 0x28
	db $33, $02 ; 0x2a
	db $34, $04 ; 0x2c
	db $35, $08 ; 0x2e
	db $36, $08 ; 0x30
	db $37, $04 ; 0x32
	db $38, $03 ; 0x34
	db $39, $02 ; 0x36
	db $3a, $01 ; 0x38
	db $3b, $03 ; 0x3a
	db $3c, $04 ; 0x3c
	db $3d, $04 ; 0x3e
	db $3e, $03 ; 0x40
	db $3f, $03 ; 0x42
	db $40, $04 ; 0x44
	db $41, $07 ; 0x46
	db $42, $04 ; 0x48
	db $43, $04 ; 0x4a
	db $44, $03 ; 0x4c
	db $45, $03 ; 0x4e
	db $46, $03 ; 0x50
	db $47, $04 ; 0x52
	db $48, $06 ; 0x54
	db $49, $03 ; 0x56
	db $4a, $02 ; 0x58
	db $4b, $04 ; 0x5a
	db $4c, $08 ; 0x5c
	db $4d, $08 ; 0x5e
	db $4e, $08 ; 0x60
	db $4f, $08 ; 0x62
	db $50, $08 ; 0x64
	db $51, $08 ; 0x66
	db $52, $08 ; 0x68
	db $53, $08 ; 0x6a
	db $54, $04 ; 0x6c
	db $55, $00 ; 0x6e
	db $56, $02 ; 0x70
	db $57, $01 ; 0x72
	db $58, $04 ; 0x74
	db $59, $03 ; 0x76
	db $5a, $03 ; 0x78
	db $5b, $02 ; 0x7a
	db $5c, $04 ; 0x7c
	db $5d, $01 ; 0x7e
	db $5e, $02 ; 0x80
	db $5f, $05 ; 0x82
	db $60, $06 ; 0x84
	db $61, $04 ; 0x86
	db $62, $06 ; 0x88
	db $63, $05 ; 0x8a
	db $64, $02 ; 0x8c
	db $65, $03 ; 0x8e
	db $66, $04 ; 0x90
	db $67, $06 ; 0x92
	db $68, $04 ; 0x94
	db $69, $01 ; 0x96
	db $6a, $03 ; 0x98
	db $6b, $05 ; 0x9a
	db $6c, $03 ; 0x9c
	db $6d, $02 ; 0x9e
	db $6e, $08 ; 0xa0
	db $6f, $08 ; 0xa2
	db $70, $00 ; 0xa4
	db $71, $02 ; 0xa6
	db $72, $03 ; 0xa8
	db $73, $08 ; 0xaa
	db $74, $08 ; 0xac
	db $ff ; 0xae
ResetTextWindowsAndRestoreMap:
	call InitTextWindows ; $617a
	call RestoreShadowTilemap ; $617d
	ret ; $6180
CreateWindowWithTextId:
	push bc ; $6181
	push_wram_bank WRAM_TEXT ; $6182
	call CreateWindow ; $618b
	bit 7, h ; $618e
	jr nz, .negative ; $6190
	ld b, a ; $6192
	call SetWindowTextId ; $6193
.negative:
	ld a, [wWindowId] ; $6196
	ld b, a ; $6199
	pop_wram_bank ; $619a
	ld a, b ; $619f
	pop bc ; $61a0
	ret ; $61a1
RedrawWindowText:
	push af ; $61a2
	push bc ; $61a3
	push de ; $61a4
	push hl ; $61a5
	ld b, a ; $61a6
	push_wram_bank WRAM_TEXT ; $61a7
	ld a, [wDialogueWindowId] ; $61b0
	cp b ; $61b3
	jr nz, .getWindowStructPtr ; $61b4
	ld [wGlyphWindowId], a ; $61b6
.loop:
	xor a ; $61b9
	ld [wGlyphRowStartCol], a ; $61ba
	ld [wGlyphFlushedCol], a ; $61bd
	push_wram_bank WRAM_SOUND ; $61c0
	call ClearGlyphBuffer ; $61c9
	call UploadGlyphTilesPartial ; $61cc
	pop_wram_bank ; $61cf
	ld a, [wDialogueWindowId] ; $61d4
	push af ; $61d7
	call GetWindowStructPtr ; $61d8
	ld bc, $0006 ; $61db
	add hl, bc ; $61de
	ld a, [hl+] ; $61df
	ld h, [hl] ; $61e0
	ld l, a ; $61e1
	call MeasureDialogueWidthTiles ; $61e2
	pop af ; $61e5
	call DrawTextWindowFrame ; $61e6
	call RenderActiveWindowText ; $61e9
	ld a, [wDialogueWindowId] ; $61ec
	call RestoreTilemapUnderWindow ; $61ef
	ld a, [wTextPageBreakRequest] ; $61f2
	or a ; $61f5
	jr nz, .loop ; $61f6
	jr .restore ; $61f8
.getWindowStructPtr:
	ld a, b ; $61fa
	call GetWindowStructPtr ; $61fb
	ld b, h ; $61fe
	ld c, l ; $61ff
	ld d, [hl] ; $6200
	inc d ; $6201
	inc hl ; $6202
	ld e, [hl] ; $6203
	inc e ; $6204
	ld hl, $0004 ; $6205
	add hl, bc ; $6208
	ld a, [hl] ; $6209
	and $02 ; $620a
	jr z, .maskClear ; $620c
	inc d ; $620e
.maskClear:
	ld hl, $0006 ; $620f
	add hl, bc ; $6212
	ld a, [hl+] ; $6213
	ld h, [hl] ; $6214
	ld l, a ; $6215
	ld a, h ; $6216
	cp $ff ; $6217
	jr z, .restore ; $6219
	call FetchDialogueText ; $621b
	ld hl, wTextBuffer ; $621e
	call RenderTextString ; $6221
.restore:
	pop_wram_bank ; $6224
	pop hl ; $6229
	pop de ; $622a
	pop bc ; $622b
	pop af ; $622c
	ret ; $622d
UploadGlyphTilesPartial:
	push_wram_bank WRAM_SOUND ; $622e
	ld hl, wGlyphTileBuffer ; $6237
	ld de, vTiles1 ; $623a
	ld c, $1b ; $623d
	call QueueVRAMCopy ; $623f
	push af ; $6242
	ldh a, [rLCDC] ; $6243
	bit 7, a ; $6245
	jr z, .restore ; $6247
	call AdvanceFrame ; $6249
.restore:
	pop af ; $624c
	ld hl, wGlyphTileBuffer + 27 * TILE_SIZE ; $624d
	ld de, vTiles1 + $1b * TILE_SIZE ; $6250
	ld c, $1b ; $6253
	call QueueVRAMCopy ; $6255
	push af ; $6258
	ldh a, [rLCDC] ; $6259
	bit 7, a ; $625b
	jr z, .restore2 ; $625d
	call AdvanceFrame ; $625f
.restore2:
	pop af ; $6262
	pop_wram_bank ; $6263
	ret ; $6268
RenderWindowTextToCompletion:
	push af ; $6269
	push bc ; $626a
	push de ; $626b
	push hl ; $626c
	ld b, a ; $626d
	push_wram_bank WRAM_TEXT ; $626e
	ld a, [wDialogueWindowId] ; $6277
	cp b ; $627a
	jr nz, .getWindowStructPtr ; $627b
	ld [wGlyphWindowId], a ; $627d
.loop:
	ld a, [wDialogueWindowId] ; $6280
	call DrawTextWindowFrame ; $6283
	call RenderActiveWindowText ; $6286
	ld a, [wTextPageBreakRequest] ; $6289
	or a ; $628c
	jr nz, .loop ; $628d
	jr .restore ; $628f
.getWindowStructPtr:
	ld a, b ; $6291
	call GetWindowStructPtr ; $6292
	ld b, h ; $6295
	ld c, l ; $6296
	ld d, [hl] ; $6297
	inc d ; $6298
	inc hl ; $6299
	ld e, [hl] ; $629a
	inc e ; $629b
	ld hl, $0004 ; $629c
	add hl, bc ; $629f
	ld a, [hl] ; $62a0
	and $02 ; $62a1
	jr z, .maskClear ; $62a3
	inc d ; $62a5
.maskClear:
	ld hl, $0006 ; $62a6
	add hl, bc ; $62a9
	ld a, [hl+] ; $62aa
	ld h, [hl] ; $62ab
	ld l, a ; $62ac
	ld a, h ; $62ad
	cp $ff ; $62ae
	jr z, .restore ; $62b0
.restore:
	pop_wram_bank ; $62b2
	pop hl ; $62b7
	pop de ; $62b8
	pop bc ; $62b9
	pop af ; $62ba
	ret ; $62bb
RedrawWindowRowsSafe:
	push af ; $62bc
	push bc ; $62bd
	push de ; $62be
	push hl ; $62bf
	ld b, a ; $62c0
	push_wram_bank WRAM_TEXT ; $62c1
	ld a, b ; $62ca
	call RedrawWindowRowsThunk ; $62cb
	pop_wram_bank ; $62ce
	pop hl ; $62d3
	pop de ; $62d4
	pop bc ; $62d5
	pop af ; $62d6
	ret ; $62d7
CloseWindowAlt:
	push af ; $62d8
	call RestoreTilemapUnderWindow ; $62d9
	call RedrawWindowRowsThunk ; $62dc
	call ResetWindowState ; $62df
	call FreeWindow ; $62e2
	pop af ; $62e5
	ret ; $62e6
ShowDialogueCentered:
	push af ; $62e7
	push bc ; $62e8
	push de ; $62e9
	push_wram_bank WRAM_TEXT ; $62ea
	xor a ; $62f3
	ld [wTextArgStringWriteIndex], a ; $62f4
	ld [wTextArgStringMeasureIndex], a ; $62f7
	ld [wTextArgNumberWriteIndex], a ; $62fa
	ld [wTextArgNumberMeasureIndex], a ; $62fd
	ld [wTextArgShortTextWriteIndex], a ; $6300
	ld [wTextArgShortTextMeasureIndex], a ; $6303
	call AddTextIdOffset ; $6306
	call ApplyMessageSpeed ; $6309
	ld a, [wDialogueWindowId] ; $630c
	cp DIALOGUEWIN_NONE ; $630f
	jr nz, .loop ; $6311
	call OpenCenteredDialogueWindow ; $6313
.loop:
	call SetActiveWindowTextId ; $6316
	ld a, [wDialogueWindowId] ; $6319
	call RedrawWindowText ; $631c
	call RedrawWindowRowsThunk ; $631f
	ld a, [wTextPageBreakRequest] ; $6322
	or a ; $6325
	jr nz, .loop ; $6326
	ld a, [wDialogueWindowId] ; $6328
	call CloseWindowAlt ; $632b
	ld a, DIALOGUEWIN_NONE ; $632e
	ld [wDialogueWindowId], a ; $6330
	xor a ; $6333
	ld [wTextArgStringWriteIndex], a ; $6334
	ld [wTextArgStringMeasureIndex], a ; $6337
	ld [wTextArgNumberWriteIndex], a ; $633a
	ld [wTextArgNumberMeasureIndex], a ; $633d
	ld [wTextArgShortTextWriteIndex], a ; $6340
	ld [wTextArgShortTextMeasureIndex], a ; $6343
	pop_wram_bank ; $6346
	pop de ; $634b
	pop bc ; $634c
	pop af ; $634d
	ret ; $634e
OpenCenteredDialogueWindow:
	push af ; $634f
	push bc ; $6350
	push de ; $6351
	push hl ; $6352
	push de ; $6353
	push hl ; $6354
	ld de, $0000 ; $6355
	ld b, $14 ; $6358
	ld c, $07 ; $635a
	call CreateDialogueWindow ; $635c
	pop hl ; $635f
	call FetchDialogueText ; $6360
	pop de ; $6363
	ld a, [wDialogueWindowId] ; $6364
	call GetWindowStructPtr ; $6367
	inc hl ; $636a
	inc hl ; $636b
	ld a, d ; $636c
	ld d, [hl] ; $636d
	sra d ; $636e
	sub d ; $6370
	ld d, a ; $6371
	inc hl ; $6372
	ld a, e ; $6373
	ld e, [hl] ; $6374
	sra e ; $6375
	sub e ; $6377
	ld e, a ; $6378
	dec hl ; $6379
	dec hl ; $637a
	ld [hl-], a ; $637b
	ld [hl], d ; $637c
	ld a, [wDialogueWindowId] ; $637d
	call DrawTextWindowFrame ; $6380
	pop hl ; $6383
	pop de ; $6384
	pop bc ; $6385
	pop af ; $6386
	ret ; $6387
Unused_05_ChooseSpeechBubbleHalf:
	push af ; $6388
	push bc ; $6389
	push hl ; $638a
	ld b, a ; $638b
	ldh a, [hWramBank] ; $638c
	push af ; $638e
	ld a, b ; $638f
	and $3f ; $6390
	ld e, a ; $6392
	rl b ; $6393
	jr c, .step2 ; $6395
	call GetObjectSlotPointer ; $6397
	ld a, [wCameraY + 1] ; $639a
	ld b, a ; $639d
	ld a, l ; $639e
	ldh [hActorPtr], a ; $639f
	ld a, h ; $63a1
	ldh [hActorPtr + 1], a ; $63a2
	wram_bank WRAM_ACTORS ; $63a4
	ld hl, hActorPtr ; $63aa
	ld a, [hl+] ; $63ad
	ld h, [hl] ; $63ae
	add $0e ; $63af
	ld l, a ; $63b1
	inc hl ; $63b2
	ld a, [hl] ; $63b3
	sub b ; $63b4
	cp $0a ; $63b5
	jr c, .lt0a ; $63b7
	ld e, $00 ; $63b9
	ld b, $00 ; $63bb
	jr .step2 ; $63bd
.lt0a:
	ld e, $0b ; $63bf
	ld b, $01 ; $63c1
.step2:
	wram_bank WRAM_TEXT ; $63c3
	ld a, b ; $63c9
	ld [wSpeechBubbleLowerHalf], a ; $63ca
	pop_wram_bank ; $63cd
	ld d, $00 ; $63d2
	pop hl ; $63d4
	pop bc ; $63d5
	pop af ; $63d6
	ret ; $63d7
DebugToggleSelectedFlag:
	push af ; $63d8
	push bc ; $63d9
	push de ; $63da
	push hl ; $63db
	ld a, [wDebugFlagPage] ; $63dc
	add a ; $63df
	add a ; $63e0
	add a ; $63e1
	add a ; $63e2
	add a ; $63e3
	add a ; $63e4
	ld l, a ; $63e5
	ld a, [wDebugFlagByte] ; $63e6
	add a ; $63e9
	add a ; $63ea
	add a ; $63eb
	add l ; $63ec
	ld l, a ; $63ed
	ld a, [wDebugFlagBit] ; $63ee
	add l ; $63f1
	ld e, a ; $63f2
	ld d, $00 ; $63f3
	call TestGameFlagByNumber ; $63f5
	jr z, .setGameFlagByNumber ; $63f8
	call ClearGameFlagByNumber ; $63fa
	jr .restore ; $63fd
.setGameFlagByNumber:
	call SetGameFlagByNumber ; $63ff
.restore:
	pop hl ; $6402
	pop de ; $6403
	pop bc ; $6404
	pop af ; $6405
	ret ; $6406
DebugDrawFlagsWindow1:
	push af ; $6407
	push bc ; $6408
	push de ; $6409
	push hl ; $640a
	ld hl, wDebugFlagWindow1Id ; $640b
	ld b, [hl] ; $640e
	ld a, [wDebugFlagPage] ; $640f
	add a ; $6412
	add a ; $6413
	add a ; $6414
	add a ; $6415
	add a ; $6416
	add a ; $6417
	ld de, $0101 ; $6418
	call DebugDrawHexRowLabel ; $641b
	ld de, $0401 ; $641e
	call DebugDrawFlagBitRow ; $6421
	add $08 ; $6424
	ld de, $0402 ; $6426
	call DebugDrawFlagBitRow ; $6429
	add $08 ; $642c
	ld de, $0104 ; $642e
	call DebugDrawHexRowLabel ; $6431
	ld de, $0404 ; $6434
	call DebugDrawFlagBitRow ; $6437
	add $08 ; $643a
	ld de, $0405 ; $643c
	call DebugDrawFlagBitRow ; $643f
	pop hl ; $6442
	pop de ; $6443
	pop bc ; $6444
	pop af ; $6445
	ret ; $6446
DebugDrawFlagsWindow2:
	push af ; $6447
	push bc ; $6448
	push de ; $6449
	push hl ; $644a
	ld hl, wDebugFlagWindow2Id ; $644b
	ld b, [hl] ; $644e
	ld a, [wDebugFlagPage] ; $644f
	add a ; $6452
	inc a ; $6453
	add a ; $6454
	add a ; $6455
	add a ; $6456
	add a ; $6457
	add a ; $6458
	ld de, $0101 ; $6459
	call DebugDrawHexRowLabel ; $645c
	ld de, $0401 ; $645f
	call DebugDrawFlagBitRow ; $6462
	add $08 ; $6465
	ld de, $0402 ; $6467
	call DebugDrawFlagBitRow ; $646a
	add $08 ; $646d
	ld de, $0104 ; $646f
	call DebugDrawHexRowLabel ; $6472
	ld de, $0404 ; $6475
	call DebugDrawFlagBitRow ; $6478
	add $08 ; $647b
	ld de, $0405 ; $647d
	call DebugDrawFlagBitRow ; $6480
	pop hl ; $6483
	pop de ; $6484
	pop bc ; $6485
	pop af ; $6486
	ret ; $6487
