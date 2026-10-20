ServeToTargetsBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $570f
	inc a ; $5712
	ld [wBriefingAnimTimer], a ; $5713
	cp $78 ; $5716
	jr nc, ServeToTargetsBriefing_AdvanceAnim ; $5718
	ret ; $571a
ServeToTargetsBriefing_AdvanceAnim:
	xor a ; $571b
	ld [wBriefingAnimTimer], a ; $571c
	ld a, [wBriefingAnimStep] ; $571f
	inc a ; $5722
	and $03 ; $5723
	ld [wBriefingAnimStep], a ; $5725
	sla a ; $5728
	sla a ; $572a
	ld c, a ; $572c
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnimTable ; $572d
	ld a, [hl] ; $5734
	inc hl ; $5735
	inc hl ; $5736
	ld b, [hl] ; $5737
	ld a, a ; $5738
	ld [wBriefingPlayerX], a ; $5739
	ld a, b ; $573c
	ld [wBriefingPlayerY], a ; $573d
	ld a, c ; $5740
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_BracketPosTable ; $5741
	ld a, [hl] ; $5748
	inc hl ; $5749
	inc hl ; $574a
	ld b, [hl] ; $574b
	ld a, a ; $574c
	ld [wBriefingBracketX], a ; $574d
	ld a, b ; $5750
	ld [wBriefingBracketY], a ; $5751
	ld a, c ; $5754
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_BallPosTable ; $5755
	ld a, [hl] ; $575c
	inc hl ; $575d
	inc hl ; $575e
	ld b, [hl] ; $575f
	ld a, a ; $5760
	ld [wBriefingBallX], a ; $5761
	ld a, b ; $5764
	ld [wBriefingBallY], a ; $5765
	ld a, [wBriefingAnimStep] ; $5768
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_HandUnflippedTable ; $576b
	ld a, [hl] ; $5772
	ld [wBriefingHandUnflipped], a ; $5773
	ld a, c ; $5776
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_HandPosTable ; $5777
	ld a, [hl] ; $577e
	inc hl ; $577f
	inc hl ; $5780
	ld b, [hl] ; $5781
	ld a, a ; $5782
	ld [wBriefingHandX], a ; $5783
	ld a, b ; $5786
	ld [wBriefingHandY], a ; $5787
	ld a, [wBriefingAnimStep] ; $578a
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_DiagArrowDirTable ; $578d
	ld a, [hl] ; $5794
	ld [wBriefingDiagArrowDir], a ; $5795
	ld a, c ; $5798
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_DiagArrowPosTable ; $5799
	ld a, [hl] ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld b, [hl] ; $57a3
	ld a, a ; $57a4
	ld [wBriefingDiagArrowX], a ; $57a5
	ld a, b ; $57a8
	ld [wBriefingDiagArrowY], a ; $57a9
	ld a, [wBriefingAnimStep] ; $57ac
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable ; $57af
	ld b, [hl] ; $57b6
	call DrawDiagramTargetOverlay ; $57b7
	ret ; $57ba
ServeToTargetsBriefing_AdvanceAnimTable:
	; $57bb, 16 bytes (records:2)
	dw $0054 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0054 ; record 6
	dw $0003 ; record 7
ServeToTargetsBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_BallPosTable.asm" ; $57cb, 16 bytes (words:2)
ServeToTargetsBriefing_AdvanceAnim_HandUnflippedTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_HandUnflippedTable.asm" ; $57db, 4 bytes (bytes:4)
ServeToTargetsBriefing_AdvanceAnim_HandPosTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_HandPosTable.asm" ; $57df, 16 bytes (words:2)
ServeToTargetsBriefing_AdvanceAnim_DiagArrowDirTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_DiagArrowDirTable.asm" ; $57ef, 4 bytes (bytes:4)
ServeToTargetsBriefing_AdvanceAnim_DiagArrowPosTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_DiagArrowPosTable.asm" ; $57f3, 16 bytes (words:2)
ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable.asm" ; $5803, 4 bytes (bytes:4)
ServeToTargetsBriefing_AdvanceAnim_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/ServeToTargetsBriefing_AdvanceAnim_BracketPosTable.asm" ; $5807, 16 bytes (words:2)
DrillBriefing_SpinServe:
	ld a, $03 ; $5817
	ld [wBriefingAnimStep], a ; $5819
	call SpinServeBriefing_AdvanceAnim ; $581c
	frame_task DrawBriefingPlayerSprite ; $581f
	frame_task DrawBriefingBallSprite ; $5827
	frame_task DrawBriefingPointingHand ; $582f
	frame_task DrawBriefingDiagonalArrow ; $5837
	frame_task CycleDiagramTargetPalette ; $583f
	ld hl, Text_BriefSpinServeFourCourts ; $5847
	call DrawBriefingCaption ; $584a
	xor a ; $584d
	ld [wBriefingAnimTimer], a ; $584e
	ld [wBriefingAnimStep], a ; $5851
.animFirstCaption:
	call SpinServeBriefing_TickAnim ; $5854
	ld c, BRIEFPROMPT_SHOW ; $5857
	call AdvanceFrameCheckInput ; $5859
	and a ; $585c
	jp z, .animFirstCaption ; $585d
	call ClearFrameTasks ; $5860
	frame_task UpdateAnimatedTilesTask_17 ; $5863
	ld a, $03 ; $586b
	ld [wBriefingAnimStep], a ; $586d
	call SpinServeBriefing_AdvanceAnim ; $5870
	frame_task DrawBriefingPlayerSprite ; $5873
	frame_task DrawBriefingPointingHand ; $587b
	frame_task CycleDiagramTargetPalette ; $5883
	ld a, $00 ; $588b
	ld [wBriefingBracketWidth], a ; $588d
	ld a, $00 ; $5890
	ld [wBriefingBracketHeight], a ; $5892
	frame_task DrawBriefingTargetBrackets ; $5895
	ld hl, Text_BriefSpinServeSmallerTargets ; $589d
	call DrawBriefingCaption ; $58a0
	xor a ; $58a3
	ld [wBriefingAnimTimer], a ; $58a4
	ld [wBriefingAnimStep], a ; $58a7
.animSecondCaption:
	call SpinServeBriefing_TickAnim ; $58aa
	ld c, BRIEFPROMPT_SHOW ; $58ad
	call AdvanceFrameCheckInput ; $58af
	and a ; $58b2
	jp z, .animSecondCaption ; $58b3
	call ClearFrameTasks ; $58b6
	frame_task UpdateAnimatedTilesTask_17 ; $58b9
	ld a, $52 ; $58c1
	ld [wBriefingPlayerX], a ; $58c3
	ld a, $44 ; $58c6
	ld [wBriefingPlayerY], a ; $58c8
	frame_task DrawBriefingPlayerSprite ; $58cb
	ld a, $4e ; $58d3
	ld [wBriefingBallX], a ; $58d5
	ld a, $38 ; $58d8
	ld [wBriefingBallY], a ; $58da
	frame_task DrawBriefingBallSprite ; $58dd
	ld a, $00 ; $58e5
	ld [wBriefingHandUnflipped], a ; $58e7
	ld a, $3a ; $58ea
	ld [wBriefingHandX], a ; $58ec
	ld a, $24 ; $58ef
	ld [wBriefingHandY], a ; $58f1
	frame_task DrawBriefingPointingHand ; $58f4
	ld a, $03 ; $58fc
	ld [wBriefingDiagArrowDir], a ; $58fe
	ld a, $52 ; $5901
	ld [wBriefingDiagArrowX], a ; $5903
	ld a, $40 ; $5906
	ld [wBriefingDiagArrowY], a ; $5908
	frame_task DrawBriefingDiagonalArrow ; $590b
	ld b, $04 ; $5913
	call DrawDiagramTargetOverlay ; $5915
	frame_task CycleDiagramTargetPalette ; $5918
	ld a, $00 ; $5920
	ld [wBriefingBracketWidth], a ; $5922
	ld a, $00 ; $5925
	ld [wBriefingBracketHeight], a ; $5927
	ld a, $40 ; $592a
	ld [wBriefingBracketX], a ; $592c
	ld a, $24 ; $592f
	ld [wBriefingBracketY], a ; $5931
	frame_task DrawBriefingTargetBrackets ; $5934
	ld hl, Text_BriefSpinServeDiagonally ; $593c
	call DrawBriefingCaption ; $593f
	call WaitForInputBlinking ; $5942
	call ClearFrameTasks ; $5945
	frame_task UpdateAnimatedTilesTask_17 ; $5948
	ld a, $52 ; $5950
	ld [wBriefingPlayerX], a ; $5952
	ld a, $44 ; $5955
	ld [wBriefingPlayerY], a ; $5957
	frame_task DrawBriefingPlayerSprite ; $595a
	ld a, $46 ; $5962
	ld [wBriefingBallX], a ; $5964
	ld a, $28 ; $5967
	ld [wBriefingBallY], a ; $5969
	frame_task DrawBriefingBallSprite ; $596c
	ld a, $03 ; $5974
	ld [wBriefingDiagArrowDir], a ; $5976
	ld a, $49 ; $5979
	ld [wBriefingDiagArrowX], a ; $597b
	ld a, $2f ; $597e
	ld [wBriefingDiagArrowY], a ; $5980
	frame_task DrawBriefingDiagonalArrow ; $5983
	ld a, $01 ; $598b
	ld [wBriefingLeftArrowUnflipped], a ; $598d
	ld a, $30 ; $5990
	ld [wBriefingLeftArrowX], a ; $5992
	ld a, $22 ; $5995
	ld [wBriefingLeftArrowY], a ; $5997
	frame_task DrawBriefingLeftArrow ; $599a
	ld b, $04 ; $59a2
	call DrawDiagramTargetOverlay ; $59a4
	frame_task CycleDiagramTargetPalette ; $59a7
	ld hl, Text_BriefSpinServeBounceOutCorner ; $59af
	call DrawBriefingCaption ; $59b2
	call WaitForInputBlinking ; $59b5
	call ClearFrameTasks ; $59b8
	frame_task UpdateAnimatedTilesTask_17 ; $59bb
	ld a, $00 ; $59c3
	ld [wBriefingAnimStep], a ; $59c5
	call SpinServeBriefing_AdvanceAnim2 ; $59c8
	frame_task DrawBriefingPlayerSprite ; $59cb
	frame_task DrawBriefingBallSprite ; $59d3
	frame_task DrawBriefingDiagonalArrow ; $59db
	frame_task DrawBriefingLeftArrow ; $59e3
	frame_task DrawBriefingCmdPrompt ; $59eb
	frame_task CycleDiagramTargetPalette ; $59f3
	ld hl, Text_BriefSpinServeTopspinRight ; $59fb
	ld a, [wStoryMainLeftHanded] ; $59fe
	and a ; $5a01
	jr z, .drawBriefingCaption ; $5a02
	ld hl, Text_BriefSpinServeTopspinLeft ; $5a04
.drawBriefingCaption:
	call DrawBriefingCaption ; $5a07
	xor a ; $5a0a
	ld [wBriefingAnimTimer], a ; $5a0b
	ld [wBriefingAnimStep], a ; $5a0e
.animSwingCaption:
	call SpinServeBriefing_TickAnim2 ; $5a11
	ld c, BRIEFPROMPT_SHOW ; $5a14
	call AdvanceFrameCheckInput ; $5a16
	and a ; $5a19
	jp z, .animSwingCaption ; $5a1a
	call ClearFrameTasks ; $5a1d
	frame_task UpdateAnimatedTilesTask_17 ; $5a20
	ld a, $03 ; $5a28
	ld [wBriefingAnimStep], a ; $5a2a
	call SpinServeBriefing_AdvanceAnim ; $5a2d
	frame_task DrawBriefingPlayerSprite ; $5a30
	frame_task DrawBriefingBallSprite ; $5a38
	frame_task DrawBriefingDiagonalArrow ; $5a40
	frame_task CycleDiagramTargetPalette ; $5a48
	frame_task DrawBriefingTargetBrackets ; $5a50
	ld hl, Text_BriefSpinServeHitAllTargets ; $5a58
	call DrawBriefingCaption ; $5a5b
	xor a ; $5a5e
	ld [wBriefingAnimTimer], a ; $5a5f
	ld [wBriefingAnimStep], a ; $5a62
.animLastCaption:
	call SpinServeBriefing_TickAnim ; $5a65
	ld c, BRIEFPROMPT_NONE ; $5a68
	call AdvanceFrameCheckInput ; $5a6a
	and a ; $5a6d
	jp z, .animLastCaption ; $5a6e
	call ClearFrameTasks ; $5a71
	ret ; $5a74
SpinServeBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $5a75
	inc a ; $5a78
	ld [wBriefingAnimTimer], a ; $5a79
	cp $78 ; $5a7c
	jr nc, SpinServeBriefing_AdvanceAnim ; $5a7e
	ret ; $5a80
SpinServeBriefing_AdvanceAnim:
	xor a ; $5a81
	ld [wBriefingAnimTimer], a ; $5a82
	ld a, [wBriefingAnimStep] ; $5a85
	inc a ; $5a88
	and $03 ; $5a89
	ld [wBriefingAnimStep], a ; $5a8b
	sla a ; $5a8e
	sla a ; $5a90
	ld c, a ; $5a92
	ld_hl_indexed SpinServeBriefing_AdvanceAnimTable ; $5a93
	ld a, [hl] ; $5a9a
	inc hl ; $5a9b
	inc hl ; $5a9c
	ld b, [hl] ; $5a9d
	ld a, a ; $5a9e
	ld [wBriefingPlayerX], a ; $5a9f
	ld a, b ; $5aa2
	ld [wBriefingPlayerY], a ; $5aa3
	ld a, c ; $5aa6
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_BracketPosTable ; $5aa7
	ld a, [hl] ; $5aae
	inc hl ; $5aaf
	inc hl ; $5ab0
	ld b, [hl] ; $5ab1
	ld a, a ; $5ab2
	ld [wBriefingBracketX], a ; $5ab3
	ld a, b ; $5ab6
	ld [wBriefingBracketY], a ; $5ab7
	ld a, c ; $5aba
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_BallPosTable ; $5abb
	ld a, [hl] ; $5ac2
	inc hl ; $5ac3
	inc hl ; $5ac4
	ld b, [hl] ; $5ac5
	ld a, a ; $5ac6
	ld [wBriefingBallX], a ; $5ac7
	ld a, b ; $5aca
	ld [wBriefingBallY], a ; $5acb
	ld a, [wBriefingAnimStep] ; $5ace
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_HandUnflippedTable ; $5ad1
	ld a, [hl] ; $5ad8
	ld [wBriefingHandUnflipped], a ; $5ad9
	ld a, c ; $5adc
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_HandPosTable ; $5add
	ld a, [hl] ; $5ae4
	inc hl ; $5ae5
	inc hl ; $5ae6
	ld b, [hl] ; $5ae7
	ld a, a ; $5ae8
	ld [wBriefingHandX], a ; $5ae9
	ld a, b ; $5aec
	ld [wBriefingHandY], a ; $5aed
	ld a, [wBriefingAnimStep] ; $5af0
	ld_hl_indexed SpinServeBriefing_DiagArrowDirTable ; $5af3
	ld a, [hl] ; $5afa
	ld [wBriefingDiagArrowDir], a ; $5afb
	ld a, c ; $5afe
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_DiagArrowPosTable ; $5aff
	ld a, [hl] ; $5b06
	inc hl ; $5b07
	inc hl ; $5b08
	ld b, [hl] ; $5b09
	ld a, a ; $5b0a
	ld [wBriefingDiagArrowX], a ; $5b0b
	ld a, b ; $5b0e
	ld [wBriefingDiagArrowY], a ; $5b0f
	ld a, [wBriefingAnimStep] ; $5b12
	ld_hl_indexed SpinServeBriefing_TargetOverlayTable ; $5b15
	ld b, [hl] ; $5b1c
	call DrawDiagramTargetOverlay ; $5b1d
	ret ; $5b20
SpinServeBriefing_TickAnim2:
	ld a, [wBriefingAnimTimer] ; $5b21
	inc a ; $5b24
	ld [wBriefingAnimTimer], a ; $5b25
	cp $78 ; $5b28
	jr nc, SpinServeBriefing_AdvanceAnim2 ; $5b2a
	ret ; $5b2c
SpinServeBriefing_AdvanceAnim2:
	xor a ; $5b2d
	ld [wBriefingAnimTimer], a ; $5b2e
	ld a, [wBriefingAnimStep] ; $5b31
	xor $01 ; $5b34
	ld [wBriefingAnimStep], a ; $5b36
	sla a ; $5b39
	sla a ; $5b3b
	ld c, a ; $5b3d
	ld_hl_indexed SpinServeBriefing_AdvanceAnimTable ; $5b3e
	ld a, [hl] ; $5b45
	inc hl ; $5b46
	inc hl ; $5b47
	ld b, [hl] ; $5b48
	ld a, a ; $5b49
	ld [wBriefingPlayerX], a ; $5b4a
	ld a, b ; $5b4d
	ld [wBriefingPlayerY], a ; $5b4e
	ld a, c ; $5b51
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_BallPosTable ; $5b52
	ld a, [hl] ; $5b59
	inc hl ; $5b5a
	inc hl ; $5b5b
	ld b, [hl] ; $5b5c
	ld a, a ; $5b5d
	ld [wBriefingBallX], a ; $5b5e
	ld a, b ; $5b61
	ld [wBriefingBallY], a ; $5b62
	ld a, [wBriefingAnimStep] ; $5b65
	ld_hl_indexed SpinServeBriefing_DiagArrowDirTable ; $5b68
	ld a, [hl] ; $5b6f
	ld [wBriefingDiagArrowDir], a ; $5b70
	ld a, c ; $5b73
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_DiagArrowPosTable ; $5b74
	ld a, [hl] ; $5b7b
	inc hl ; $5b7c
	inc hl ; $5b7d
	ld b, [hl] ; $5b7e
	ld a, a ; $5b7f
	ld [wBriefingDiagArrowX], a ; $5b80
	ld a, b ; $5b83
	ld [wBriefingDiagArrowY], a ; $5b84
	ld a, [wBriefingAnimStep] ; $5b87
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_LeftArrowUnflippedTable ; $5b8a
	ld a, [hl] ; $5b91
	ld [wBriefingLeftArrowUnflipped], a ; $5b92
	ld a, c ; $5b95
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_LeftArrowPosTable ; $5b96
	ld a, [hl] ; $5b9d
	inc hl ; $5b9e
	inc hl ; $5b9f
	ld b, [hl] ; $5ba0
	ld a, a ; $5ba1
	ld [wBriefingLeftArrowX], a ; $5ba2
	ld a, b ; $5ba5
	ld [wBriefingLeftArrowY], a ; $5ba6
	ld b, $00 ; $5ba9
	ld a, [wStoryMainLeftHanded] ; $5bab
	and a ; $5bae
	jr z, .rightHanded ; $5baf
	ld b, $02 ; $5bb1
.rightHanded:
	ld a, [wBriefingAnimStep] ; $5bb3
	add b ; $5bb6
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_CmdPromptTable ; $5bb7
	ld a, [hl] ; $5bbe
	ld [wBriefingCmdPrompt], a ; $5bbf
	ld a, c ; $5bc2
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_CmdPromptPosTable ; $5bc3
	ld a, [hl] ; $5bca
	inc hl ; $5bcb
	inc hl ; $5bcc
	ld b, [hl] ; $5bcd
	ld a, a ; $5bce
	ld [wBriefingCmdPromptX], a ; $5bcf
	ld a, b ; $5bd2
	ld [wBriefingCmdPromptY], a ; $5bd3
	ld a, [wBriefingAnimStep] ; $5bd6
	ld_hl_indexed SpinServeBriefing_TargetOverlayTable ; $5bd9
	ld b, [hl] ; $5be0
	call DrawDiagramTargetOverlay ; $5be1
	ret ; $5be4
SpinServeBriefing_AdvanceAnimTable:
	; $5be5, 16 bytes (records:2)
	dw $0052 ; record 0
	dw $0044 ; record 1
	dw $003d ; record 2
	dw $0044 ; record 3
	dw $003d ; record 4
	dw $0000 ; record 5
	dw $0052 ; record 6
	dw $0000 ; record 7
SpinServeBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim_BallPosTable.asm" ; $5bf5, 16 bytes (words:2)
SpinServeBriefing_AdvanceAnim_HandUnflippedTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim_HandUnflippedTable.asm" ; $5c05, 4 bytes (bytes:4)
SpinServeBriefing_AdvanceAnim_HandPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim_HandPosTable.asm" ; $5c09, 16 bytes (words:2)
SpinServeBriefing_DiagArrowDirTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_DiagArrowDirTable.asm" ; $5c19, 4 bytes (bytes:4)
SpinServeBriefing_AdvanceAnim_DiagArrowPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim_DiagArrowPosTable.asm" ; $5c1d, 16 bytes (words:2)
SpinServeBriefing_TargetOverlayTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_TargetOverlayTable.asm" ; $5c2d, 4 bytes (bytes:4)
SpinServeBriefing_AdvanceAnim_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim_BracketPosTable.asm" ; $5c31, 16 bytes (words:2)
SpinServeBriefing_AdvanceAnim2_BallPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim2_BallPosTable.asm" ; $5c41, 8 bytes (words:2)
SpinServeBriefing_AdvanceAnim2_DiagArrowPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim2_DiagArrowPosTable.asm" ; $5c49, 8 bytes (words:2)
SpinServeBriefing_AdvanceAnim2_LeftArrowUnflippedTable:
	db $01 ; $5c51
	db $00 ; $5c52
SpinServeBriefing_AdvanceAnim2_LeftArrowPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim2_LeftArrowPosTable.asm" ; $5c53, 8 bytes (words:2)
SpinServeBriefing_AdvanceAnim2_CmdPromptTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim2_CmdPromptTable.asm" ; $5c5b, 4 bytes (bytes:4)
SpinServeBriefing_AdvanceAnim2_CmdPromptPosTable:
	INCLUDE "data/engine/menus/briefing/SpinServeBriefing_AdvanceAnim2_CmdPromptPosTable.asm" ; $5c5f, 8 bytes (words:2)
