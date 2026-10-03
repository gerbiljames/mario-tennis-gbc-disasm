DrillBriefing_ServeAndSmash:
	ld a, $55 ; $6230
	ld [wBriefingPlayerX], a ; $6232
	ld a, $44 ; $6235
	ld [wBriefingPlayerY], a ; $6237
	ld a, $01 ; $623a
	ld hl, DrawBriefingPlayerSprite ; $623c
	call RegisterFrameTask ; $623f
	ld a, $34 ; $6242
	ld [wBriefingOpponentX], a ; $6244
	ld a, $06 ; $6247
	ld [wBriefingOpponentY], a ; $6249
	ld a, $01 ; $624c
	ld hl, DrawBriefingOpponentSprite ; $624e
	call RegisterFrameTask ; $6251
	ld a, $4e ; $6254
	ld [wBriefingBallX], a ; $6256
	ld a, $38 ; $6259
	ld [wBriefingBallY], a ; $625b
	ld a, $01 ; $625e
	ld hl, DrawBriefingBallSprite ; $6260
	call RegisterFrameTask ; $6263
	ld a, $00 ; $6266
	ld [wBriefingHMarkerUnflipped], a ; $6268
	ld a, $3a ; $626b
	ld [wBriefingHMarkerX], a ; $626d
	ld a, $20 ; $6270
	ld [wBriefingHMarkerY], a ; $6272
	ld a, $01 ; $6275
	ld hl, DrawBriefingMarkerHFlip ; $6277
	call RegisterFrameTask ; $627a
	ld a, $03 ; $627d
	ld [wBriefingRotMarkerDir], a ; $627f
	ld a, $52 ; $6282
	ld [wBriefingRotMarkerX], a ; $6284
	ld a, $40 ; $6287
	ld [wBriefingRotMarkerY], a ; $6289
	ld a, $01 ; $628c
	ld hl, DrawBriefingMarkerRotated ; $628e
	call RegisterFrameTask ; $6291
	ld a, $0d ; $6294
	ld [wBriefingBracketWidth], a ; $6296
	ld a, $00 ; $6299
	ld [wBriefingBracketHeight], a ; $629b
	ld a, $3e ; $629e
	ld [wBriefingBracketX], a ; $62a0
	ld a, $22 ; $62a3
	ld [wBriefingBracketY], a ; $62a5
	ld a, $01 ; $62a8
	ld hl, DrawBriefingTargetBrackets ; $62aa
	call RegisterFrameTask ; $62ad
	ld hl, Text_36_706 ; $62b0
	call DrawBriefingCaption ; $62b3
	call WaitForInputBlinking ; $62b6
	call ClearFrameTasks ; $62b9
	ld a, $01 ; $62bc
	ld hl, UpdateAnimatedTilesTask_17 ; $62be
	call RegisterFrameTask ; $62c1
	ld a, $55 ; $62c4
	ld [wBriefingPlayerX], a ; $62c6
	ld a, $44 ; $62c9
	ld [wBriefingPlayerY], a ; $62cb
	ld a, $01 ; $62ce
	ld hl, DrawBriefingPlayerSprite ; $62d0
	call RegisterFrameTask ; $62d3
	ld a, $34 ; $62d6
	ld [wBriefingOpponentX], a ; $62d8
	ld a, $06 ; $62db
	ld [wBriefingOpponentY], a ; $62dd
	ld a, $01 ; $62e0
	ld hl, DrawBriefingOpponentSprite ; $62e2
	call RegisterFrameTask ; $62e5
	ld a, $00 ; $62e8
	ld [wBriefingHMarkerUnflipped], a ; $62ea
	ld a, $3a ; $62ed
	ld [wBriefingHMarkerX], a ; $62ef
	ld a, $3c ; $62f2
	ld [wBriefingHMarkerY], a ; $62f4
	ld a, $01 ; $62f7
	ld hl, DrawBriefingMarkerHFlip ; $62f9
	call RegisterFrameTask ; $62fc
	ld b, $06 ; $62ff
	call DrawDiagramTargetOverlay ; $6301
	ld a, $01 ; $6304
	ld hl, CycleDiagramTargetPalette ; $6306
	call RegisterFrameTask ; $6309
	ld hl, Text_36_707 ; $630c
	call DrawBriefingCaption ; $630f
	call WaitForInputBlinking ; $6312
	call ClearFrameTasks ; $6315
	ld a, $01 ; $6318
	ld hl, UpdateAnimatedTilesTask_17 ; $631a
	call RegisterFrameTask ; $631d
	call DrawDiagramTargetOverlay ; $6320
	ld a, $52 ; $6323
	ld [wBriefingPlayerX], a ; $6325
	ld a, $30 ; $6328
	ld [wBriefingPlayerY], a ; $632a
	ld a, $01 ; $632d
	ld hl, DrawBriefingPlayerSprite ; $632f
	call RegisterFrameTask ; $6332
	ld a, $34 ; $6335
	ld [wBriefingOpponentX], a ; $6337
	ld a, $06 ; $633a
	ld [wBriefingOpponentY], a ; $633c
	ld a, $01 ; $633f
	ld hl, DrawBriefingOpponentSprite ; $6341
	call RegisterFrameTask ; $6344
	ld a, $5d ; $6347
	ld [wBriefingBallX], a ; $6349
	ld a, $1b ; $634c
	ld [wBriefingBallY], a ; $634e
	ld a, $01 ; $6351
	ld hl, DrawBriefingBallSprite ; $6353
	call RegisterFrameTask ; $6356
	ld a, $01 ; $6359
	ld [wBriefingRotMarkerDir], a ; $635b
	ld a, $46 ; $635e
	ld [wBriefingRotMarkerX], a ; $6360
	ld a, $16 ; $6363
	ld [wBriefingRotMarkerY], a ; $6365
	ld a, $01 ; $6368
	ld hl, DrawBriefingMarkerRotated ; $636a
	call RegisterFrameTask ; $636d
	ld a, $00 ; $6370
	ld [wBriefingVMarkerUpright], a ; $6372
	ld a, $5b ; $6375
	ld [wBriefingVMarkerX], a ; $6377
	ld a, $21 ; $637a
	ld [wBriefingVMarkerY], a ; $637c
	ld a, $01 ; $637f
	ld hl, DrawBriefingMarkerVFlip ; $6381
	call RegisterFrameTask ; $6384
	ld a, $04 ; $6387
	ld [wBriefingSwingFrame], a ; $6389
	ld a, $2d ; $638c
	ld [wBriefingSwingX], a ; $638e
	ld a, $30 ; $6391
	ld [wBriefingSwingY], a ; $6393
	ld a, $01 ; $6396
	ld hl, DrawBriefingSwingAnim ; $6398
	call RegisterFrameTask ; $639b
	ld hl, Text_36_708 ; $639e
	call DrawBriefingCaption ; $63a1
	call WaitForInputBlinking ; $63a4
	call ClearFrameTasks ; $63a7
	ld a, $01 ; $63aa
	ld hl, UpdateAnimatedTilesTask_17 ; $63ac
	call RegisterFrameTask ; $63af
	ld a, $55 ; $63b2
	ld [wBriefingPlayerX], a ; $63b4
	ld a, $44 ; $63b7
	ld [wBriefingPlayerY], a ; $63b9
	ld a, $01 ; $63bc
	ld hl, DrawBriefingPlayerSprite ; $63be
	call RegisterFrameTask ; $63c1
	ld a, $34 ; $63c4
	ld [wBriefingOpponentX], a ; $63c6
	ld a, $06 ; $63c9
	ld [wBriefingOpponentY], a ; $63cb
	ld a, $01 ; $63ce
	ld hl, DrawBriefingOpponentSprite ; $63d0
	call RegisterFrameTask ; $63d3
	ld a, $50 ; $63d6
	ld [wBriefingBallX], a ; $63d8
	ld a, $37 ; $63db
	ld [wBriefingBallY], a ; $63dd
	ld a, $01 ; $63e0
	ld hl, DrawBriefingBallSprite ; $63e2
	call RegisterFrameTask ; $63e5
	ld a, $03 ; $63e8
	ld [wBriefingRotMarkerDir], a ; $63ea
	ld a, $54 ; $63ed
	ld [wBriefingRotMarkerX], a ; $63ef
	ld a, $3d ; $63f2
	ld [wBriefingRotMarkerY], a ; $63f4
	ld a, $01 ; $63f7
	ld hl, DrawBriefingMarkerRotated ; $63f9
	call RegisterFrameTask ; $63fc
	ld a, $0d ; $63ff
	ld [wBriefingBracketWidth], a ; $6401
	ld a, $00 ; $6404
	ld [wBriefingBracketHeight], a ; $6406
	ld a, $3e ; $6409
	ld [wBriefingBracketX], a ; $640b
	ld a, $22 ; $640e
	ld [wBriefingBracketY], a ; $6410
	ld a, $01 ; $6413
	ld hl, DrawBriefingTargetBrackets ; $6415
	call RegisterFrameTask ; $6418
	ld hl, Text_36_709 ; $641b
	call DrawBriefingCaption ; $641e
.loop:
	ld a, [wBriefingAnimTimer] ; $6421
	inc a ; $6424
	ld [wBriefingAnimTimer], a ; $6425
	cp $78 ; $6428
	jp c, .lt78 ; $642a
	xor a ; $642d
	ld [wBriefingAnimTimer], a ; $642e
	ld a, [wBriefingAnimStep] ; $6431
	inc a ; $6434
	and $03 ; $6435
	ld [wBriefingAnimStep], a ; $6437
	sla a ; $643a
	sla a ; $643c
	ld c, a ; $643e
	ld_hl_indexed DrillBriefing_ServeAndSmashTable ; $643f
	ld a, [hl] ; $6446
	inc hl ; $6447
	inc hl ; $6448
	ld b, [hl] ; $6449
	ld a, a ; $644a
	ld [wBriefingPlayerX], a ; $644b
	ld a, b ; $644e
	ld [wBriefingPlayerY], a ; $644f
	ld a, c ; $6452
	ld_hl_indexed DrillBriefing_ServeAndSmash_OpponentPosTable ; $6453
	ld a, [hl] ; $645a
	inc hl ; $645b
	inc hl ; $645c
	ld b, [hl] ; $645d
	ld a, a ; $645e
	ld [wBriefingOpponentX], a ; $645f
	ld a, b ; $6462
	ld [wBriefingOpponentY], a ; $6463
	ld a, c ; $6466
	ld_hl_indexed DrillBriefing_ServeAndSmash_BracketPosTable ; $6467
	ld a, [hl] ; $646e
	inc hl ; $646f
	inc hl ; $6470
	ld b, [hl] ; $6471
	ld a, a ; $6472
	ld [wBriefingBracketX], a ; $6473
	ld a, b ; $6476
	ld [wBriefingBracketY], a ; $6477
	ld a, c ; $647a
	ld_hl_indexed DrillBriefing_ServeAndSmash_BallPosTable ; $647b
	ld a, [hl] ; $6482
	inc hl ; $6483
	inc hl ; $6484
	ld b, [hl] ; $6485
	ld a, a ; $6486
	ld [wBriefingBallX], a ; $6487
	ld a, b ; $648a
	ld [wBriefingBallY], a ; $648b
	ld a, [wBriefingAnimStep] ; $648e
	ld_hl_indexed DrillBriefing_ServeAndSmash_RotMarkerDirTable ; $6491
	ld a, [hl] ; $6498
	ld [wBriefingRotMarkerDir], a ; $6499
	ld a, c ; $649c
	ld_hl_indexed DrillBriefing_ServeAndSmash_RotMarkerPosTable ; $649d
	ld a, [hl] ; $64a4
	inc hl ; $64a5
	inc hl ; $64a6
	ld b, [hl] ; $64a7
	ld a, a ; $64a8
	ld [wBriefingRotMarkerX], a ; $64a9
	ld a, b ; $64ac
	ld [wBriefingRotMarkerY], a ; $64ad
.lt78:
	ld c, $01 ; $64b0
	call AdvanceFrameCheckInput ; $64b2
	and a ; $64b5
	jp z, .loop ; $64b6
	call ClearFrameTasks ; $64b9
	ret ; $64bc
DrillBriefing_ServeAndSmashTable:
	; $64bd, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
DrillBriefing_ServeAndSmash_OpponentPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_OpponentPosTable.bin" ; $64cd, 16 bytes
DrillBriefing_ServeAndSmash_BallPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_BallPosTable.bin" ; $64dd, 36 bytes
DrillBriefing_ServeAndSmash_RotMarkerDirTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_RotMarkerDirTable.bin" ; $6501, 4 bytes
DrillBriefing_ServeAndSmash_RotMarkerPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_RotMarkerPosTable.bin" ; $6505, 36 bytes
DrillBriefing_ServeAndSmash_BracketPosTable:
	INCLUDE "data/bank_017/DrillBriefing_ServeAndSmash_BracketPosTable.asm" ; $6529, 16 bytes
DrillBriefing_ServeAndSmash2:
	ld a, $55 ; $6539
	ld [wBriefingPlayerX], a ; $653b
	ld a, $44 ; $653e
	ld [wBriefingPlayerY], a ; $6540
	ld a, $01 ; $6543
	ld hl, DrawBriefingPlayerSprite ; $6545
	call RegisterFrameTask ; $6548
	ld a, $34 ; $654b
	ld [wBriefingOpponentX], a ; $654d
	ld a, $06 ; $6550
	ld [wBriefingOpponentY], a ; $6552
	ld a, $01 ; $6555
	ld hl, DrawBriefingOpponentSprite ; $6557
	call RegisterFrameTask ; $655a
	ld a, $4e ; $655d
	ld [wBriefingBallX], a ; $655f
	ld a, $38 ; $6562
	ld [wBriefingBallY], a ; $6564
	ld a, $01 ; $6567
	ld hl, DrawBriefingBallSprite ; $6569
	call RegisterFrameTask ; $656c
	ld a, $00 ; $656f
	ld [wBriefingHMarkerUnflipped], a ; $6571
	ld a, $3a ; $6574
	ld [wBriefingHMarkerX], a ; $6576
	ld a, $20 ; $6579
	ld [wBriefingHMarkerY], a ; $657b
	ld a, $01 ; $657e
	ld hl, DrawBriefingMarkerHFlip ; $6580
	call RegisterFrameTask ; $6583
	ld a, $03 ; $6586
	ld [wBriefingRotMarkerDir], a ; $6588
	ld a, $52 ; $658b
	ld [wBriefingRotMarkerX], a ; $658d
	ld a, $40 ; $6590
	ld [wBriefingRotMarkerY], a ; $6592
	ld a, $01 ; $6595
	ld hl, DrawBriefingMarkerRotated ; $6597
	call RegisterFrameTask ; $659a
	ld a, $0d ; $659d
	ld [wBriefingBracketWidth], a ; $659f
	ld a, $00 ; $65a2
	ld [wBriefingBracketHeight], a ; $65a4
	ld a, $3e ; $65a7
	ld [wBriefingBracketX], a ; $65a9
	ld a, $22 ; $65ac
	ld [wBriefingBracketY], a ; $65ae
	ld a, $01 ; $65b1
	ld hl, DrawBriefingTargetBrackets ; $65b3
	call RegisterFrameTask ; $65b6
	ld hl, Text_36_710 ; $65b9
	call DrawBriefingCaption ; $65bc
	call WaitForInputBlinking ; $65bf
	call ClearFrameTasks ; $65c2
	ld a, $01 ; $65c5
	ld hl, UpdateAnimatedTilesTask_17 ; $65c7
	call RegisterFrameTask ; $65ca
	ld a, $55 ; $65cd
	ld [wBriefingPlayerX], a ; $65cf
	ld a, $44 ; $65d2
	ld [wBriefingPlayerY], a ; $65d4
	ld a, $01 ; $65d7
	ld hl, DrawBriefingPlayerSprite ; $65d9
	call RegisterFrameTask ; $65dc
	ld a, $34 ; $65df
	ld [wBriefingOpponentX], a ; $65e1
	ld a, $06 ; $65e4
	ld [wBriefingOpponentY], a ; $65e6
	ld a, $01 ; $65e9
	ld hl, DrawBriefingOpponentSprite ; $65eb
	call RegisterFrameTask ; $65ee
	ld a, $00 ; $65f1
	ld [wBriefingHMarkerUnflipped], a ; $65f3
	ld a, $3a ; $65f6
	ld [wBriefingHMarkerX], a ; $65f8
	ld a, $3c ; $65fb
	ld [wBriefingHMarkerY], a ; $65fd
	ld a, $01 ; $6600
	ld hl, DrawBriefingMarkerHFlip ; $6602
	call RegisterFrameTask ; $6605
	ld b, $06 ; $6608
	call DrawDiagramTargetOverlay ; $660a
	ld a, $01 ; $660d
	ld hl, CycleDiagramTargetPalette ; $660f
	call RegisterFrameTask ; $6612
	ld hl, Text_36_711 ; $6615
	call DrawBriefingCaption ; $6618
	call WaitForInputBlinking ; $661b
	call ClearFrameTasks ; $661e
	ld a, $01 ; $6621
	ld hl, UpdateAnimatedTilesTask_17 ; $6623
	call RegisterFrameTask ; $6626
	call DrawDiagramTargetOverlay ; $6629
	ld a, $52 ; $662c
	ld [wBriefingPlayerX], a ; $662e
	ld a, $30 ; $6631
	ld [wBriefingPlayerY], a ; $6633
	ld a, $01 ; $6636
	ld hl, DrawBriefingPlayerSprite ; $6638
	call RegisterFrameTask ; $663b
	ld a, $34 ; $663e
	ld [wBriefingOpponentX], a ; $6640
	ld a, $06 ; $6643
	ld [wBriefingOpponentY], a ; $6645
	ld a, $01 ; $6648
	ld hl, DrawBriefingOpponentSprite ; $664a
	call RegisterFrameTask ; $664d
	ld a, $5d ; $6650
	ld [wBriefingBallX], a ; $6652
	ld a, $1b ; $6655
	ld [wBriefingBallY], a ; $6657
	ld a, $01 ; $665a
	ld hl, DrawBriefingBallSprite ; $665c
	call RegisterFrameTask ; $665f
	ld a, $01 ; $6662
	ld [wBriefingRotMarkerDir], a ; $6664
	ld a, $46 ; $6667
	ld [wBriefingRotMarkerX], a ; $6669
	ld a, $16 ; $666c
	ld [wBriefingRotMarkerY], a ; $666e
	ld a, $01 ; $6671
	ld hl, DrawBriefingMarkerRotated ; $6673
	call RegisterFrameTask ; $6676
	ld a, $00 ; $6679
	ld [wBriefingVMarkerUpright], a ; $667b
	ld a, $5b ; $667e
	ld [wBriefingVMarkerX], a ; $6680
	ld a, $21 ; $6683
	ld [wBriefingVMarkerY], a ; $6685
	ld a, $01 ; $6688
	ld hl, DrawBriefingMarkerVFlip ; $668a
	call RegisterFrameTask ; $668d
	ld a, $05 ; $6690
	ld [wBriefingSwingFrame], a ; $6692
	ld a, $2d ; $6695
	ld [wBriefingSwingX], a ; $6697
	ld a, $30 ; $669a
	ld [wBriefingSwingY], a ; $669c
	ld a, $01 ; $669f
	ld hl, DrawBriefingSwingAnim ; $66a1
	call RegisterFrameTask ; $66a4
	ld hl, Text_36_712 ; $66a7
	call DrawBriefingCaption ; $66aa
	call WaitForInputBlinking ; $66ad
	call ClearFrameTasks ; $66b0
	ld a, $01 ; $66b3
	ld hl, UpdateAnimatedTilesTask_17 ; $66b5
	call RegisterFrameTask ; $66b8
	ld a, $55 ; $66bb
	ld [wBriefingPlayerX], a ; $66bd
	ld a, $44 ; $66c0
	ld [wBriefingPlayerY], a ; $66c2
	ld a, $01 ; $66c5
	ld hl, DrawBriefingPlayerSprite ; $66c7
	call RegisterFrameTask ; $66ca
	ld a, $34 ; $66cd
	ld [wBriefingOpponentX], a ; $66cf
	ld a, $06 ; $66d2
	ld [wBriefingOpponentY], a ; $66d4
	ld a, $01 ; $66d7
	ld hl, DrawBriefingOpponentSprite ; $66d9
	call RegisterFrameTask ; $66dc
	ld a, $50 ; $66df
	ld [wBriefingBallX], a ; $66e1
	ld a, $37 ; $66e4
	ld [wBriefingBallY], a ; $66e6
	ld a, $01 ; $66e9
	ld hl, DrawBriefingBallSprite ; $66eb
	call RegisterFrameTask ; $66ee
	ld a, $03 ; $66f1
	ld [wBriefingRotMarkerDir], a ; $66f3
	ld a, $54 ; $66f6
	ld [wBriefingRotMarkerX], a ; $66f8
	ld a, $3d ; $66fb
	ld [wBriefingRotMarkerY], a ; $66fd
	ld a, $01 ; $6700
	ld hl, DrawBriefingMarkerRotated ; $6702
	call RegisterFrameTask ; $6705
	ld a, $0d ; $6708
	ld [wBriefingBracketWidth], a ; $670a
	ld a, $00 ; $670d
	ld [wBriefingBracketHeight], a ; $670f
	ld a, $3e ; $6712
	ld [wBriefingBracketX], a ; $6714
	ld a, $22 ; $6717
	ld [wBriefingBracketY], a ; $6719
	ld a, $01 ; $671c
	ld hl, DrawBriefingTargetBrackets ; $671e
	call RegisterFrameTask ; $6721
	ld hl, Text_36_713 ; $6724
	call DrawBriefingCaption ; $6727
.loop:
	ld a, [wBriefingAnimTimer] ; $672a
	inc a ; $672d
	ld [wBriefingAnimTimer], a ; $672e
	cp $78 ; $6731
	jp c, .lt78 ; $6733
	xor a ; $6736
	ld [wBriefingAnimTimer], a ; $6737
	ld a, [wBriefingAnimStep] ; $673a
	inc a ; $673d
	and $03 ; $673e
	ld [wBriefingAnimStep], a ; $6740
	sla a ; $6743
	sla a ; $6745
	ld c, a ; $6747
	ld_hl_indexed DrillBriefing_ServeAndSmash2Table ; $6748
	ld a, [hl] ; $674f
	inc hl ; $6750
	inc hl ; $6751
	ld b, [hl] ; $6752
	ld a, a ; $6753
	ld [wBriefingPlayerX], a ; $6754
	ld a, b ; $6757
	ld [wBriefingPlayerY], a ; $6758
	ld a, c ; $675b
	ld_hl_indexed DrillBriefing_ServeAndSmash2_OpponentPosTable ; $675c
	ld a, [hl] ; $6763
	inc hl ; $6764
	inc hl ; $6765
	ld b, [hl] ; $6766
	ld a, a ; $6767
	ld [wBriefingOpponentX], a ; $6768
	ld a, b ; $676b
	ld [wBriefingOpponentY], a ; $676c
	ld a, c ; $676f
	ld_hl_indexed DrillBriefing_ServeAndSmash2_BracketPosTable ; $6770
	ld a, [hl] ; $6777
	inc hl ; $6778
	inc hl ; $6779
	ld b, [hl] ; $677a
	ld a, a ; $677b
	ld [wBriefingBracketX], a ; $677c
	ld a, b ; $677f
	ld [wBriefingBracketY], a ; $6780
	ld a, c ; $6783
	ld_hl_indexed DrillBriefing_ServeAndSmash2_BallPosTable ; $6784
	ld a, [hl] ; $678b
	inc hl ; $678c
	inc hl ; $678d
	ld b, [hl] ; $678e
	ld a, a ; $678f
	ld [wBriefingBallX], a ; $6790
	ld a, b ; $6793
	ld [wBriefingBallY], a ; $6794
	ld a, [wBriefingAnimStep] ; $6797
	ld_hl_indexed DrillBriefing_ServeAndSmash2_RotMarkerDirTable ; $679a
	ld a, [hl] ; $67a1
	ld [wBriefingRotMarkerDir], a ; $67a2
	ld a, c ; $67a5
	ld_hl_indexed DrillBriefing_ServeAndSmash2_RotMarkerPosTable ; $67a6
	ld a, [hl] ; $67ad
	inc hl ; $67ae
	inc hl ; $67af
	ld b, [hl] ; $67b0
	ld a, a ; $67b1
	ld [wBriefingRotMarkerX], a ; $67b2
	ld a, b ; $67b5
	ld [wBriefingRotMarkerY], a ; $67b6
.lt78:
	ld c, $01 ; $67b9
	call AdvanceFrameCheckInput ; $67bb
	and a ; $67be
	jp z, .loop ; $67bf
	call ClearFrameTasks ; $67c2
	ret ; $67c5
DrillBriefing_ServeAndSmash2Table:
	; $67c6, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
DrillBriefing_ServeAndSmash2_OpponentPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_OpponentPosTable.bin" ; $67d6, 16 bytes
DrillBriefing_ServeAndSmash2_BallPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_BallPosTable.bin" ; $67e6, 36 bytes
DrillBriefing_ServeAndSmash2_RotMarkerDirTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_RotMarkerDirTable.bin" ; $680a, 4 bytes
DrillBriefing_ServeAndSmash2_RotMarkerPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_RotMarkerPosTable.bin" ; $680e, 36 bytes
DrillBriefing_ServeAndSmash2_BracketPosTable:
	INCLUDE "data/bank_017/DrillBriefing_ServeAndSmash2_BracketPosTable.asm" ; $6832, 16 bytes
DrillBriefing_ReturnToTarget:
	ld a, $55 ; $6842
	ld [wBriefingPlayerX], a ; $6844
	ld a, $44 ; $6847
	ld [wBriefingPlayerY], a ; $6849
	ld a, $01 ; $684c
	ld hl, DrawBriefingPlayerSprite ; $684e
	call RegisterFrameTask ; $6851
	ld a, $3a ; $6854
	ld [wBriefingOpponentX], a ; $6856
	ld a, $03 ; $6859
	ld [wBriefingOpponentY], a ; $685b
	ld a, $01 ; $685e
	ld hl, DrawBriefingOpponentSprite ; $6860
	call RegisterFrameTask ; $6863
	ld a, $54 ; $6866
	ld [wBriefingBallX], a ; $6868
	ld a, $28 ; $686b
	ld [wBriefingBallY], a ; $686d
	ld a, $01 ; $6870
	ld hl, DrawBriefingBallSprite ; $6872
	call RegisterFrameTask ; $6875
	ld a, $01 ; $6878
	ld [wBriefingRotMarkerDir], a ; $687a
	ld a, $4c ; $687d
	ld [wBriefingRotMarkerX], a ; $687f
	ld a, $16 ; $6882
	ld [wBriefingRotMarkerY], a ; $6884
	ld a, $01 ; $6887
	ld hl, DrawBriefingMarkerRotated ; $6889
	call RegisterFrameTask ; $688c
	ld hl, Text_37_3 ; $688f
	call DrawBriefingCaption ; $6892
	call WaitForInputBlinking ; $6895
	call ClearFrameTasks ; $6898
	ld a, $01 ; $689b
	ld hl, UpdateAnimatedTilesTask_17 ; $689d
	call RegisterFrameTask ; $68a0
	ld a, $03 ; $68a3
	ld [wBriefingAnimStep], a ; $68a5
	call ReturnToTargetBriefing_AdvanceAnim ; $68a8
	ld a, $01 ; $68ab
	ld hl, DrawBriefingPlayerSprite ; $68ad
	call RegisterFrameTask ; $68b0
	ld a, $01 ; $68b3
	ld hl, DrawBriefingOpponentSprite ; $68b5
	call RegisterFrameTask ; $68b8
	ld a, $01 ; $68bb
	ld hl, DrawBriefingBallSprite ; $68bd
	call RegisterFrameTask ; $68c0
	ld a, $01 ; $68c3
	ld hl, DrawBriefingMarkerHFlip ; $68c5
	call RegisterFrameTask ; $68c8
	ld a, $01 ; $68cb
	ld hl, DrawBriefingMarkerRotated ; $68cd
	call RegisterFrameTask ; $68d0
	ld a, $0d ; $68d3
	ld [wBriefingBracketWidth], a ; $68d5
	ld a, $09 ; $68d8
	ld [wBriefingBracketHeight], a ; $68da
	ld a, $01 ; $68dd
	ld hl, DrawBriefingTargetBrackets ; $68df
	call RegisterFrameTask ; $68e2
	ld hl, Text_37_4 ; $68e5
	call DrawBriefingCaption ; $68e8
	call WaitForInputBlinking ; $68eb
	call ClearFrameTasks ; $68ee
	ld a, $01 ; $68f1
	ld hl, UpdateAnimatedTilesTask_17 ; $68f3
	call RegisterFrameTask ; $68f6
	ld a, $03 ; $68f9
	ld [wBriefingAnimStep], a ; $68fb
	call ReturnToTargetBriefing_AdvanceAnim ; $68fe
	ld a, $01 ; $6901
	ld hl, DrawBriefingPlayerSprite ; $6903
	call RegisterFrameTask ; $6906
	ld a, $01 ; $6909
	ld hl, DrawBriefingOpponentSprite ; $690b
	call RegisterFrameTask ; $690e
	ld a, $01 ; $6911
	ld hl, DrawBriefingBallSprite ; $6913
	call RegisterFrameTask ; $6916
	ld a, $01 ; $6919
	ld hl, DrawBriefingMarkerHFlip ; $691b
	call RegisterFrameTask ; $691e
	ld a, $01 ; $6921
	ld hl, DrawBriefingMarkerRotated ; $6923
	call RegisterFrameTask ; $6926
	ld a, $0d ; $6929
	ld [wBriefingBracketWidth], a ; $692b
	ld a, $09 ; $692e
	ld [wBriefingBracketHeight], a ; $6930
	ld a, $01 ; $6933
	ld hl, DrawBriefingTargetBrackets ; $6935
	call RegisterFrameTask ; $6938
	ld hl, Text_37_5 ; $693b
	call DrawBriefingCaption ; $693e
	xor a ; $6941
	ld [wBriefingAnimTimer], a ; $6942
	ld [wBriefingAnimStep], a ; $6945
.loop:
	call ReturnToTargetBriefing_TickAnim ; $6948
	ld c, $01 ; $694b
	call AdvanceFrameCheckInput ; $694d
	and a ; $6950
	jp z, .loop ; $6951
	call ClearFrameTasks ; $6954
	ret ; $6957
