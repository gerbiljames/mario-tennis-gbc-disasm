DrillBriefing_ServeAndSmash:
	ld a, $55 ; $6230
	ld [wBriefingPlayerX], a ; $6232
	ld a, $44 ; $6235
	ld [wBriefingPlayerY], a ; $6237
	frame_task DrawBriefingPlayerSprite ; $623a
	ld a, $34 ; $6242
	ld [wBriefingOpponentX], a ; $6244
	ld a, $06 ; $6247
	ld [wBriefingOpponentY], a ; $6249
	frame_task DrawBriefingOpponentSprite ; $624c
	ld a, $4e ; $6254
	ld [wBriefingBallX], a ; $6256
	ld a, $38 ; $6259
	ld [wBriefingBallY], a ; $625b
	frame_task DrawBriefingBallSprite ; $625e
	ld a, $00 ; $6266
	ld [wBriefingHMarkerUnflipped], a ; $6268
	ld a, $3a ; $626b
	ld [wBriefingHMarkerX], a ; $626d
	ld a, $20 ; $6270
	ld [wBriefingHMarkerY], a ; $6272
	frame_task DrawBriefingMarkerHFlip ; $6275
	ld a, $03 ; $627d
	ld [wBriefingRotMarkerDir], a ; $627f
	ld a, $52 ; $6282
	ld [wBriefingRotMarkerX], a ; $6284
	ld a, $40 ; $6287
	ld [wBriefingRotMarkerY], a ; $6289
	frame_task DrawBriefingMarkerRotated ; $628c
	ld a, $0d ; $6294
	ld [wBriefingBracketWidth], a ; $6296
	ld a, $00 ; $6299
	ld [wBriefingBracketHeight], a ; $629b
	ld a, $3e ; $629e
	ld [wBriefingBracketX], a ; $62a0
	ld a, $22 ; $62a3
	ld [wBriefingBracketY], a ; $62a5
	frame_task DrawBriefingTargetBrackets ; $62a8
	ld hl, Text_BriefServeSmashServeDeep ; $62b0
	call DrawBriefingCaption ; $62b3
	call WaitForInputBlinking ; $62b6
	call ClearFrameTasks ; $62b9
	frame_task UpdateAnimatedTilesTask_17 ; $62bc
	ld a, $55 ; $62c4
	ld [wBriefingPlayerX], a ; $62c6
	ld a, $44 ; $62c9
	ld [wBriefingPlayerY], a ; $62cb
	frame_task DrawBriefingPlayerSprite ; $62ce
	ld a, $34 ; $62d6
	ld [wBriefingOpponentX], a ; $62d8
	ld a, $06 ; $62db
	ld [wBriefingOpponentY], a ; $62dd
	frame_task DrawBriefingOpponentSprite ; $62e0
	ld a, $00 ; $62e8
	ld [wBriefingHMarkerUnflipped], a ; $62ea
	ld a, $3a ; $62ed
	ld [wBriefingHMarkerX], a ; $62ef
	ld a, $3c ; $62f2
	ld [wBriefingHMarkerY], a ; $62f4
	frame_task DrawBriefingMarkerHFlip ; $62f7
	ld b, $06 ; $62ff
	call DrawDiagramTargetOverlay ; $6301
	frame_task CycleDiagramTargetPalette ; $6304
	ld hl, Text_BriefServeSmashRunToLine ; $630c
	call DrawBriefingCaption ; $630f
	call WaitForInputBlinking ; $6312
	call ClearFrameTasks ; $6315
	frame_task UpdateAnimatedTilesTask_17 ; $6318
	call DrawDiagramTargetOverlay ; $6320
	ld a, $52 ; $6323
	ld [wBriefingPlayerX], a ; $6325
	ld a, $30 ; $6328
	ld [wBriefingPlayerY], a ; $632a
	frame_task DrawBriefingPlayerSprite ; $632d
	ld a, $34 ; $6335
	ld [wBriefingOpponentX], a ; $6337
	ld a, $06 ; $633a
	ld [wBriefingOpponentY], a ; $633c
	frame_task DrawBriefingOpponentSprite ; $633f
	ld a, $5d ; $6347
	ld [wBriefingBallX], a ; $6349
	ld a, $1b ; $634c
	ld [wBriefingBallY], a ; $634e
	frame_task DrawBriefingBallSprite ; $6351
	ld a, $01 ; $6359
	ld [wBriefingRotMarkerDir], a ; $635b
	ld a, $46 ; $635e
	ld [wBriefingRotMarkerX], a ; $6360
	ld a, $16 ; $6363
	ld [wBriefingRotMarkerY], a ; $6365
	frame_task DrawBriefingMarkerRotated ; $6368
	ld a, $00 ; $6370
	ld [wBriefingVMarkerUpright], a ; $6372
	ld a, $5b ; $6375
	ld [wBriefingVMarkerX], a ; $6377
	ld a, $21 ; $637a
	ld [wBriefingVMarkerY], a ; $637c
	frame_task DrawBriefingMarkerVFlip ; $637f
	ld a, $04 ; $6387
	ld [wBriefingCmdPrompt], a ; $6389
	ld a, $2d ; $638c
	ld [wBriefingCmdPromptX], a ; $638e
	ld a, $30 ; $6391
	ld [wBriefingCmdPromptY], a ; $6393
	frame_task DrawBriefingCmdPrompt ; $6396
	ld hl, Text_BriefServeSmashSmashLob ; $639e
	call DrawBriefingCaption ; $63a1
	call WaitForInputBlinking ; $63a4
	call ClearFrameTasks ; $63a7
	frame_task UpdateAnimatedTilesTask_17 ; $63aa
	ld a, $55 ; $63b2
	ld [wBriefingPlayerX], a ; $63b4
	ld a, $44 ; $63b7
	ld [wBriefingPlayerY], a ; $63b9
	frame_task DrawBriefingPlayerSprite ; $63bc
	ld a, $34 ; $63c4
	ld [wBriefingOpponentX], a ; $63c6
	ld a, $06 ; $63c9
	ld [wBriefingOpponentY], a ; $63cb
	frame_task DrawBriefingOpponentSprite ; $63ce
	ld a, $50 ; $63d6
	ld [wBriefingBallX], a ; $63d8
	ld a, $37 ; $63db
	ld [wBriefingBallY], a ; $63dd
	frame_task DrawBriefingBallSprite ; $63e0
	ld a, $03 ; $63e8
	ld [wBriefingRotMarkerDir], a ; $63ea
	ld a, $54 ; $63ed
	ld [wBriefingRotMarkerX], a ; $63ef
	ld a, $3d ; $63f2
	ld [wBriefingRotMarkerY], a ; $63f4
	frame_task DrawBriefingMarkerRotated ; $63f7
	ld a, $0d ; $63ff
	ld [wBriefingBracketWidth], a ; $6401
	ld a, $00 ; $6404
	ld [wBriefingBracketHeight], a ; $6406
	ld a, $3e ; $6409
	ld [wBriefingBracketX], a ; $640b
	ld a, $22 ; $640e
	ld [wBriefingBracketY], a ; $6410
	frame_task DrawBriefingTargetBrackets ; $6413
	ld hl, Text_BriefServeSmashAllPositions ; $641b
	call DrawBriefingCaption ; $641e
.loop:
	ld a, [wBriefingAnimTimer] ; $6421
	inc a ; $6424
	ld [wBriefingAnimTimer], a ; $6425
	cp $78 ; $6428
	jp c, .waitInput ; $642a
	xor a ; $642d
	ld [wBriefingAnimTimer], a ; $642e
	ld a, [wBriefingAnimStep] ; $6431
	inc a ; $6434
	and $03 ; $6435
	ld [wBriefingAnimStep], a ; $6437
	sla a ; $643a
	sla a ; $643c
	ld c, a ; $643e
	ld_hl_indexed DrillBriefing_ServeAndSmash_PlayerPosTable ; $643f
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
.waitInput:
	ld c, BRIEFPROMPT_NONE ; $64b0
	call AdvanceFrameCheckInput ; $64b2
	and a ; $64b5
	jp z, .loop ; $64b6
	call ClearFrameTasks ; $64b9
	ret ; $64bc
DrillBriefing_ServeAndSmash_PlayerPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_PlayerPosTable.asm" ; $64bd, 16 bytes (words:2)
DrillBriefing_ServeAndSmash_OpponentPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_OpponentPosTable.asm" ; $64cd, 16 bytes (words:2)
DrillBriefing_ServeAndSmash_BallPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_BallPosTable.asm" ; $64dd, 16 bytes (words:2)
Unused_17_ServeAndSmash_RotMarkerDirTable0:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash_RotMarkerDirTable0.asm" ; $64ed, 4 bytes (bytes:4)
Unused_17_ServeAndSmash_RotMarkerPosTable0:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash_RotMarkerPosTable0.asm" ; $64f1, 16 bytes (words:2)
DrillBriefing_ServeAndSmash_RotMarkerDirTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_RotMarkerDirTable.asm" ; $6501, 4 bytes (bytes:4)
DrillBriefing_ServeAndSmash_RotMarkerPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_RotMarkerPosTable.asm" ; $6505, 16 bytes (words:2)
Unused_17_ServeAndSmash_RotMarkerDirTable1:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash_RotMarkerDirTable1.asm" ; $6515, 4 bytes (bytes:4)
Unused_17_ServeAndSmash_RotMarkerPosTable1:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash_RotMarkerPosTable1.asm" ; $6519, 16 bytes (words:2)
DrillBriefing_ServeAndSmash_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash_BracketPosTable.asm" ; $6529, 16 bytes (words:2)
DrillBriefing_ServeAndSmash2:
	ld a, $55 ; $6539
	ld [wBriefingPlayerX], a ; $653b
	ld a, $44 ; $653e
	ld [wBriefingPlayerY], a ; $6540
	frame_task DrawBriefingPlayerSprite ; $6543
	ld a, $34 ; $654b
	ld [wBriefingOpponentX], a ; $654d
	ld a, $06 ; $6550
	ld [wBriefingOpponentY], a ; $6552
	frame_task DrawBriefingOpponentSprite ; $6555
	ld a, $4e ; $655d
	ld [wBriefingBallX], a ; $655f
	ld a, $38 ; $6562
	ld [wBriefingBallY], a ; $6564
	frame_task DrawBriefingBallSprite ; $6567
	ld a, $00 ; $656f
	ld [wBriefingHMarkerUnflipped], a ; $6571
	ld a, $3a ; $6574
	ld [wBriefingHMarkerX], a ; $6576
	ld a, $20 ; $6579
	ld [wBriefingHMarkerY], a ; $657b
	frame_task DrawBriefingMarkerHFlip ; $657e
	ld a, $03 ; $6586
	ld [wBriefingRotMarkerDir], a ; $6588
	ld a, $52 ; $658b
	ld [wBriefingRotMarkerX], a ; $658d
	ld a, $40 ; $6590
	ld [wBriefingRotMarkerY], a ; $6592
	frame_task DrawBriefingMarkerRotated ; $6595
	ld a, $0d ; $659d
	ld [wBriefingBracketWidth], a ; $659f
	ld a, $00 ; $65a2
	ld [wBriefingBracketHeight], a ; $65a4
	ld a, $3e ; $65a7
	ld [wBriefingBracketX], a ; $65a9
	ld a, $22 ; $65ac
	ld [wBriefingBracketY], a ; $65ae
	frame_task DrawBriefingTargetBrackets ; $65b1
	ld hl, Text_BriefDropShotServeDeep ; $65b9
	call DrawBriefingCaption ; $65bc
	call WaitForInputBlinking ; $65bf
	call ClearFrameTasks ; $65c2
	frame_task UpdateAnimatedTilesTask_17 ; $65c5
	ld a, $55 ; $65cd
	ld [wBriefingPlayerX], a ; $65cf
	ld a, $44 ; $65d2
	ld [wBriefingPlayerY], a ; $65d4
	frame_task DrawBriefingPlayerSprite ; $65d7
	ld a, $34 ; $65df
	ld [wBriefingOpponentX], a ; $65e1
	ld a, $06 ; $65e4
	ld [wBriefingOpponentY], a ; $65e6
	frame_task DrawBriefingOpponentSprite ; $65e9
	ld a, $00 ; $65f1
	ld [wBriefingHMarkerUnflipped], a ; $65f3
	ld a, $3a ; $65f6
	ld [wBriefingHMarkerX], a ; $65f8
	ld a, $3c ; $65fb
	ld [wBriefingHMarkerY], a ; $65fd
	frame_task DrawBriefingMarkerHFlip ; $6600
	ld b, $06 ; $6608
	call DrawDiagramTargetOverlay ; $660a
	frame_task CycleDiagramTargetPalette ; $660d
	ld hl, Text_BriefDropShotRunUpBlank ; $6615
	call DrawBriefingCaption ; $6618
	call WaitForInputBlinking ; $661b
	call ClearFrameTasks ; $661e
	frame_task UpdateAnimatedTilesTask_17 ; $6621
	call DrawDiagramTargetOverlay ; $6629
	ld a, $52 ; $662c
	ld [wBriefingPlayerX], a ; $662e
	ld a, $30 ; $6631
	ld [wBriefingPlayerY], a ; $6633
	frame_task DrawBriefingPlayerSprite ; $6636
	ld a, $34 ; $663e
	ld [wBriefingOpponentX], a ; $6640
	ld a, $06 ; $6643
	ld [wBriefingOpponentY], a ; $6645
	frame_task DrawBriefingOpponentSprite ; $6648
	ld a, $5d ; $6650
	ld [wBriefingBallX], a ; $6652
	ld a, $1b ; $6655
	ld [wBriefingBallY], a ; $6657
	frame_task DrawBriefingBallSprite ; $665a
	ld a, $01 ; $6662
	ld [wBriefingRotMarkerDir], a ; $6664
	ld a, $46 ; $6667
	ld [wBriefingRotMarkerX], a ; $6669
	ld a, $16 ; $666c
	ld [wBriefingRotMarkerY], a ; $666e
	frame_task DrawBriefingMarkerRotated ; $6671
	ld a, $00 ; $6679
	ld [wBriefingVMarkerUpright], a ; $667b
	ld a, $5b ; $667e
	ld [wBriefingVMarkerX], a ; $6680
	ld a, $21 ; $6683
	ld [wBriefingVMarkerY], a ; $6685
	frame_task DrawBriefingMarkerVFlip ; $6688
	ld a, $05 ; $6690
	ld [wBriefingCmdPrompt], a ; $6692
	ld a, $2d ; $6695
	ld [wBriefingCmdPromptX], a ; $6697
	ld a, $30 ; $669a
	ld [wBriefingCmdPromptY], a ; $669c
	frame_task DrawBriefingCmdPrompt ; $669f
	ld hl, Text_BriefDropShotMiddleBlank ; $66a7
	call DrawBriefingCaption ; $66aa
	call WaitForInputBlinking ; $66ad
	call ClearFrameTasks ; $66b0
	frame_task UpdateAnimatedTilesTask_17 ; $66b3
	ld a, $55 ; $66bb
	ld [wBriefingPlayerX], a ; $66bd
	ld a, $44 ; $66c0
	ld [wBriefingPlayerY], a ; $66c2
	frame_task DrawBriefingPlayerSprite ; $66c5
	ld a, $34 ; $66cd
	ld [wBriefingOpponentX], a ; $66cf
	ld a, $06 ; $66d2
	ld [wBriefingOpponentY], a ; $66d4
	frame_task DrawBriefingOpponentSprite ; $66d7
	ld a, $50 ; $66df
	ld [wBriefingBallX], a ; $66e1
	ld a, $37 ; $66e4
	ld [wBriefingBallY], a ; $66e6
	frame_task DrawBriefingBallSprite ; $66e9
	ld a, $03 ; $66f1
	ld [wBriefingRotMarkerDir], a ; $66f3
	ld a, $54 ; $66f6
	ld [wBriefingRotMarkerX], a ; $66f8
	ld a, $3d ; $66fb
	ld [wBriefingRotMarkerY], a ; $66fd
	frame_task DrawBriefingMarkerRotated ; $6700
	ld a, $0d ; $6708
	ld [wBriefingBracketWidth], a ; $670a
	ld a, $00 ; $670d
	ld [wBriefingBracketHeight], a ; $670f
	ld a, $3e ; $6712
	ld [wBriefingBracketX], a ; $6714
	ld a, $22 ; $6717
	ld [wBriefingBracketY], a ; $6719
	frame_task DrawBriefingTargetBrackets ; $671c
	ld hl, Text_BriefDropShotPassBlank ; $6724
	call DrawBriefingCaption ; $6727
.loop:
	ld a, [wBriefingAnimTimer] ; $672a
	inc a ; $672d
	ld [wBriefingAnimTimer], a ; $672e
	cp $78 ; $6731
	jp c, .waitInput ; $6733
	xor a ; $6736
	ld [wBriefingAnimTimer], a ; $6737
	ld a, [wBriefingAnimStep] ; $673a
	inc a ; $673d
	and $03 ; $673e
	ld [wBriefingAnimStep], a ; $6740
	sla a ; $6743
	sla a ; $6745
	ld c, a ; $6747
	ld_hl_indexed DrillBriefing_ServeAndSmash2_PlayerPosTable ; $6748
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
.waitInput:
	ld c, BRIEFPROMPT_NONE ; $67b9
	call AdvanceFrameCheckInput ; $67bb
	and a ; $67be
	jp z, .loop ; $67bf
	call ClearFrameTasks ; $67c2
	ret ; $67c5
DrillBriefing_ServeAndSmash2_PlayerPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_PlayerPosTable.asm" ; $67c6, 16 bytes (words:2)
DrillBriefing_ServeAndSmash2_OpponentPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_OpponentPosTable.asm" ; $67d6, 16 bytes (words:2)
DrillBriefing_ServeAndSmash2_BallPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_BallPosTable.asm" ; $67e6, 16 bytes (words:2)
Unused_17_ServeAndSmash2_RotMarkerDirTable0:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash2_RotMarkerDirTable0.asm" ; $67f6, 4 bytes (bytes:4)
Unused_17_ServeAndSmash2_RotMarkerPosTable0:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash2_RotMarkerPosTable0.asm" ; $67fa, 16 bytes (words:2)
DrillBriefing_ServeAndSmash2_RotMarkerDirTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_RotMarkerDirTable.asm" ; $680a, 4 bytes (bytes:4)
DrillBriefing_ServeAndSmash2_RotMarkerPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_RotMarkerPosTable.asm" ; $680e, 16 bytes (words:2)
Unused_17_ServeAndSmash2_RotMarkerDirTable1:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash2_RotMarkerDirTable1.asm" ; $681e, 4 bytes (bytes:4)
Unused_17_ServeAndSmash2_RotMarkerPosTable1:
	INCLUDE "data/engine/menus/briefing/Unused_17_ServeAndSmash2_RotMarkerPosTable1.asm" ; $6822, 16 bytes (words:2)
DrillBriefing_ServeAndSmash2_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/DrillBriefing_ServeAndSmash2_BracketPosTable.asm" ; $6832, 16 bytes (words:2)
DrillBriefing_ReturnToTarget:
	ld a, $55 ; $6842
	ld [wBriefingPlayerX], a ; $6844
	ld a, $44 ; $6847
	ld [wBriefingPlayerY], a ; $6849
	frame_task DrawBriefingPlayerSprite ; $684c
	ld a, $3a ; $6854
	ld [wBriefingOpponentX], a ; $6856
	ld a, $03 ; $6859
	ld [wBriefingOpponentY], a ; $685b
	frame_task DrawBriefingOpponentSprite ; $685e
	ld a, $54 ; $6866
	ld [wBriefingBallX], a ; $6868
	ld a, $28 ; $686b
	ld [wBriefingBallY], a ; $686d
	frame_task DrawBriefingBallSprite ; $6870
	ld a, $01 ; $6878
	ld [wBriefingRotMarkerDir], a ; $687a
	ld a, $4c ; $687d
	ld [wBriefingRotMarkerX], a ; $687f
	ld a, $16 ; $6882
	ld [wBriefingRotMarkerY], a ; $6884
	frame_task DrawBriefingMarkerRotated ; $6887
	ld hl, Text_BriefReturnTargetReturnServe ; $688f
	call DrawBriefingCaption ; $6892
	call WaitForInputBlinking ; $6895
	call ClearFrameTasks ; $6898
	frame_task UpdateAnimatedTilesTask_17 ; $689b
	ld a, $03 ; $68a3
	ld [wBriefingAnimStep], a ; $68a5
	call ReturnToTargetBriefing_AdvanceAnim ; $68a8
	frame_task DrawBriefingPlayerSprite ; $68ab
	frame_task DrawBriefingOpponentSprite ; $68b3
	frame_task DrawBriefingBallSprite ; $68bb
	frame_task DrawBriefingMarkerHFlip ; $68c3
	frame_task DrawBriefingMarkerRotated ; $68cb
	ld a, $0d ; $68d3
	ld [wBriefingBracketWidth], a ; $68d5
	ld a, $09 ; $68d8
	ld [wBriefingBracketHeight], a ; $68da
	frame_task DrawBriefingTargetBrackets ; $68dd
	ld hl, Text_BriefReturnTargetHitTarget ; $68e5
	call DrawBriefingCaption ; $68e8
	call WaitForInputBlinking ; $68eb
	call ClearFrameTasks ; $68ee
	frame_task UpdateAnimatedTilesTask_17 ; $68f1
	ld a, $03 ; $68f9
	ld [wBriefingAnimStep], a ; $68fb
	call ReturnToTargetBriefing_AdvanceAnim ; $68fe
	frame_task DrawBriefingPlayerSprite ; $6901
	frame_task DrawBriefingOpponentSprite ; $6909
	frame_task DrawBriefingBallSprite ; $6911
	frame_task DrawBriefingMarkerHFlip ; $6919
	frame_task DrawBriefingMarkerRotated ; $6921
	ld a, $0d ; $6929
	ld [wBriefingBracketWidth], a ; $692b
	ld a, $09 ; $692e
	ld [wBriefingBracketHeight], a ; $6930
	frame_task DrawBriefingTargetBrackets ; $6933
	ld hl, Text_BriefReturnTargetAllPositions ; $693b
	call DrawBriefingCaption ; $693e
	xor a ; $6941
	ld [wBriefingAnimTimer], a ; $6942
	ld [wBriefingAnimStep], a ; $6945
.loop:
	call ReturnToTargetBriefing_TickAnim ; $6948
	ld c, BRIEFPROMPT_NONE ; $694b
	call AdvanceFrameCheckInput ; $694d
	and a ; $6950
	jp z, .loop ; $6951
	call ClearFrameTasks ; $6954
	ret ; $6957
