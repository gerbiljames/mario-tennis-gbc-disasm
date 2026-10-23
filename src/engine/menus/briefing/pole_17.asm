DrillBriefing_ServeThroughPoles:
	ld a, $03 ; $5c67
	ld [wBriefingAnimStep], a ; $5c69
	call PoleServeBriefing_AdvanceAnim ; $5c6c
	frame_task DrawBriefingPlayerSprite ; $5c6f
	frame_task DrawBriefingBallSprite ; $5c77
	frame_task DrawBriefingPointingHand ; $5c7f
	frame_task DrawBriefingDiagonalArrow ; $5c87
	frame_task CycleDiagramTargetPalette ; $5c8f
	ld hl, Text_BriefPoleServeFourCourts ; $5c97
	call DrawBriefingCaption ; $5c9a
	xor a ; $5c9d
	ld [wBriefingAnimTimer], a ; $5c9e
	ld [wBriefingAnimStep], a ; $5ca1
.animFirstCaption:
	call PoleServeBriefing_TickAnim ; $5ca4
	ld c, BRIEFPROMPT_SHOW ; $5ca7
	call AdvanceFrameCheckInput ; $5ca9
	and a ; $5cac
	jp z, .animFirstCaption ; $5cad
	call ClearFrameTasks ; $5cb0
	frame_task UpdateAnimatedTilesTask_17 ; $5cb3
	ld a, $03 ; $5cbb
	ld [wBriefingAnimStep], a ; $5cbd
	call PoleServeBriefing_AdvancePoleAnim ; $5cc0
	frame_task DrawBriefingPlayerSprite ; $5cc3
	frame_task DrawBriefingPointingHand ; $5ccb
	frame_task CycleDiagramTargetPalette ; $5cd3
	ld a, $00 ; $5cdb
	ld [wBriefingBracketWidth], a ; $5cdd
	ld a, $00 ; $5ce0
	ld [wBriefingBracketHeight], a ; $5ce2
	frame_task DrawBriefingTargetBrackets ; $5ce5
	ld hl, Text_BriefPoleServeSmallerTargets ; $5ced
	call DrawBriefingCaption ; $5cf0
	xor a ; $5cf3
	ld [wBriefingAnimTimer], a ; $5cf4
	ld [wBriefingAnimStep], a ; $5cf7
.animSecondCaption:
	call PoleServeBriefing_TickPoleAnim ; $5cfa
	ld a, [wBriefingAnimStep] ; $5cfd
	sla a ; $5d00
	sla a ; $5d02
	ld_hl_indexed PoleServeBriefing_PlayerPosTable ; $5d04
	ld a, [hl] ; $5d0b
	inc hl ; $5d0c
	inc hl ; $5d0d
	ld b, [hl] ; $5d0e
	ld a, a ; $5d0f
	ld [wBriefingPlayerX], a ; $5d10
	ld a, b ; $5d13
	ld [wBriefingPlayerY], a ; $5d14
	ld c, BRIEFPROMPT_SHOW ; $5d17
	call AdvanceFrameCheckInput ; $5d19
	and a ; $5d1c
	jp z, .animSecondCaption ; $5d1d
	call ClearFrameTasks ; $5d20
	frame_task UpdateAnimatedTilesTask_17 ; $5d23
	ld a, $03 ; $5d2b
	ld [wBriefingAnimStep], a ; $5d2d
	call PoleServeBriefing_AdvancePoleAnim ; $5d30
	frame_task DrawBriefingPlayerSprite ; $5d33
	ld a, $00 ; $5d3b
	ld [wBriefingHandUnflipped], a ; $5d3d
	ld a, $4b ; $5d40
	ld [wBriefingHandX], a ; $5d42
	ld a, $36 ; $5d45
	ld [wBriefingHandY], a ; $5d47
	frame_task DrawBriefingPointingHand ; $5d4a
	frame_task DrawBriefingPoleSprites ; $5d52
	frame_task CycleDiagramTargetPalette ; $5d5a
	ld a, $00 ; $5d62
	ld [wBriefingBracketWidth], a ; $5d64
	ld a, $00 ; $5d67
	ld [wBriefingBracketHeight], a ; $5d69
	frame_task DrawBriefingTargetBrackets ; $5d6c
	ld hl, Text_BriefPoleServeThroughPoles ; $5d74
	call DrawBriefingCaption ; $5d77
	call WaitForInputBlinking ; $5d7a
	call ClearFrameTasks ; $5d7d
	frame_task UpdateAnimatedTilesTask_17 ; $5d80
	ld a, $03 ; $5d88
	ld [wBriefingAnimStep], a ; $5d8a
	call PoleServeBriefing_AdvancePoleAnim ; $5d8d
	frame_task DrawBriefingPlayerSprite ; $5d90
	frame_task DrawBriefingPoleSprites ; $5d98
	frame_task CycleDiagramTargetPalette ; $5da0
	ld a, $00 ; $5da8
	ld [wBriefingBracketWidth], a ; $5daa
	ld a, $00 ; $5dad
	ld [wBriefingBracketHeight], a ; $5daf
	frame_task DrawBriefingTargetBrackets ; $5db2
	ld hl, Text_BriefPoleServeDownLineTiming ; $5dba
	call DrawBriefingCaption ; $5dbd
.animLastCaption:
	call PoleServeBriefing_TickPoleAnim ; $5dc0
	ld c, BRIEFPROMPT_NONE ; $5dc3
	call AdvanceFrameCheckInput ; $5dc5
	and a ; $5dc8
	jp z, .animLastCaption ; $5dc9
	call ClearFrameTasks ; $5dcc
	ret ; $5dcf
PoleServeBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $5dd0
	inc a ; $5dd3
	ld [wBriefingAnimTimer], a ; $5dd4
	cp $78 ; $5dd7
	jr nc, PoleServeBriefing_AdvanceAnim ; $5dd9
	ret ; $5ddb
PoleServeBriefing_AdvanceAnim:
	xor a ; $5ddc
	ld [wBriefingAnimTimer], a ; $5ddd
	ld a, [wBriefingAnimStep] ; $5de0
	inc a ; $5de3
	and $03 ; $5de4
	ld [wBriefingAnimStep], a ; $5de6
	sla a ; $5de9
	sla a ; $5deb
	ld c, a ; $5ded
	ld_hl_indexed PoleServeBriefing_PlayerPosTable ; $5dee
	ld a, [hl] ; $5df5
	inc hl ; $5df6
	inc hl ; $5df7
	ld b, [hl] ; $5df8
	ld a, a ; $5df9
	ld [wBriefingPlayerX], a ; $5dfa
	ld a, b ; $5dfd
	ld [wBriefingPlayerY], a ; $5dfe
	ld a, c ; $5e01
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_BallPosTable ; $5e02
	ld a, [hl] ; $5e09
	inc hl ; $5e0a
	inc hl ; $5e0b
	ld b, [hl] ; $5e0c
	ld a, a ; $5e0d
	ld [wBriefingBallX], a ; $5e0e
	ld a, b ; $5e11
	ld [wBriefingBallY], a ; $5e12
	ld a, [wBriefingAnimStep] ; $5e15
	ld_hl_indexed PoleServeBriefing_HandUnflippedTable ; $5e18
	ld a, [hl] ; $5e1f
	ld [wBriefingHandUnflipped], a ; $5e20
	ld a, c ; $5e23
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_HandPosTable ; $5e24
	ld a, [hl] ; $5e2b
	inc hl ; $5e2c
	inc hl ; $5e2d
	ld b, [hl] ; $5e2e
	ld a, a ; $5e2f
	ld [wBriefingHandX], a ; $5e30
	ld a, b ; $5e33
	ld [wBriefingHandY], a ; $5e34
	ld a, [wBriefingAnimStep] ; $5e37
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_DiagArrowDirTable ; $5e3a
	ld a, [hl] ; $5e41
	ld [wBriefingDiagArrowDir], a ; $5e42
	ld a, c ; $5e45
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_DiagArrowPosTable ; $5e46
	ld a, [hl] ; $5e4d
	inc hl ; $5e4e
	inc hl ; $5e4f
	ld b, [hl] ; $5e50
	ld a, a ; $5e51
	ld [wBriefingDiagArrowX], a ; $5e52
	ld a, b ; $5e55
	ld [wBriefingDiagArrowY], a ; $5e56
	ld a, [wBriefingAnimStep] ; $5e59
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5e5c
	ld b, [hl] ; $5e63
	call DrawDiagramTargetOverlay ; $5e64
	ret ; $5e67
PoleServeBriefing_TickPoleAnim:
	ld a, [wBriefingAnimTimer] ; $5e68
	inc a ; $5e6b
	ld [wBriefingAnimTimer], a ; $5e6c
	cp $78 ; $5e6f
	jr nc, PoleServeBriefing_AdvancePoleAnim ; $5e71
	ret ; $5e73
PoleServeBriefing_AdvancePoleAnim:
	xor a ; $5e74
	ld [wBriefingAnimTimer], a ; $5e75
	ld a, [wBriefingAnimStep] ; $5e78
	inc a ; $5e7b
	and $03 ; $5e7c
	ld [wBriefingAnimStep], a ; $5e7e
	sla a ; $5e81
	sla a ; $5e83
	ld c, a ; $5e85
	ld_hl_indexed PoleServeBriefing_AdvancePoleAnim_PlayerPosTable ; $5e86
	ld a, [hl] ; $5e8d
	inc hl ; $5e8e
	inc hl ; $5e8f
	ld b, [hl] ; $5e90
	ld a, a ; $5e91
	ld [wBriefingPlayerX], a ; $5e92
	ld a, b ; $5e95
	ld [wBriefingPlayerY], a ; $5e96
	ld a, c ; $5e99
	ld_hl_indexed PoleServeBriefing_AdvancePoleAnim_BracketPosTable ; $5e9a
	ld a, [hl] ; $5ea1
	inc hl ; $5ea2
	inc hl ; $5ea3
	ld b, [hl] ; $5ea4
	ld a, a ; $5ea5
	ld [wBriefingBracketX], a ; $5ea6
	ld a, b ; $5ea9
	ld [wBriefingBracketY], a ; $5eaa
	ld a, c ; $5ead
	ld_hl_indexed PoleServeBriefing_AdvancePoleAnim_PolePosTable ; $5eae
	ld a, [hl] ; $5eb5
	inc hl ; $5eb6
	inc hl ; $5eb7
	ld b, [hl] ; $5eb8
	ld a, a ; $5eb9
	ld [wBriefingPole1X], a ; $5eba
	ld a, b ; $5ebd
	ld [wBriefingPole1Y], a ; $5ebe
	ld a, c ; $5ec1
	ld_hl_indexed PoleServeBriefing_AdvancePoleAnim_PolePosTable ; $5ec2
	ld a, [hl] ; $5ec9
	add $08 ; $5eca
	ld [wBriefingPole2X], a ; $5ecc
	ld a, [wBriefingPole1Y] ; $5ecf
	ld [wBriefingPole2Y], a ; $5ed2
	ld a, [wBriefingAnimStep] ; $5ed5
	ld_hl_indexed PoleServeBriefing_HandUnflippedTable ; $5ed8
	ld a, [hl] ; $5edf
	ld [wBriefingHandUnflipped], a ; $5ee0
	ld a, c ; $5ee3
	ld_hl_indexed PoleServeBriefing_AdvancePoleAnim_HandPosTable ; $5ee4
	ld a, [hl] ; $5eeb
	inc hl ; $5eec
	inc hl ; $5eed
	ld b, [hl] ; $5eee
	ld a, a ; $5eef
	ld [wBriefingHandX], a ; $5ef0
	ld a, b ; $5ef3
	ld [wBriefingHandY], a ; $5ef4
	ld a, [wBriefingAnimStep] ; $5ef7
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5efa
	ld b, [hl] ; $5f01
	call DrawDiagramTargetOverlay ; $5f02
	ret ; $5f05
PoleServeBriefing_PlayerPosTable:
	; $5f06, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
PoleServeBriefing_AdvancePoleAnim_PlayerPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvancePoleAnim_PlayerPosTable.asm" ; $5f16, 16 bytes (words:2)
PoleServeBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvanceAnim_BallPosTable.asm" ; $5f26, 16 bytes (words:2)
PoleServeBriefing_HandUnflippedTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_HandUnflippedTable.asm" ; $5f36, 4 bytes (bytes:4)
PoleServeBriefing_AdvanceAnim_HandPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvanceAnim_HandPosTable.asm" ; $5f3a, 16 bytes (words:2)
PoleServeBriefing_AdvancePoleAnim_HandPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvancePoleAnim_HandPosTable.asm" ; $5f4a, 16 bytes (words:2)
PoleServeBriefing_AdvanceAnim_DiagArrowDirTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvanceAnim_DiagArrowDirTable.asm" ; $5f5a, 4 bytes (bytes:4)
PoleServeBriefing_AdvanceAnim_DiagArrowPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvanceAnim_DiagArrowPosTable.asm" ; $5f5e, 16 bytes (words:2)
PoleServeBriefing_TargetOverlayTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_TargetOverlayTable.asm" ; $5f6e, 4 bytes (bytes:4)
PoleServeBriefing_AdvancePoleAnim_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvancePoleAnim_BracketPosTable.asm" ; $5f72, 16 bytes (words:2)
PoleServeBriefing_AdvancePoleAnim_PolePosTable:
	INCLUDE "data/engine/menus/briefing/PoleServeBriefing_AdvancePoleAnim_PolePosTable.asm" ; $5f82, 16 bytes (words:2)
DrillBriefing_ServeAndVolley:
	ld a, $52 ; $5f92
	ld [wBriefingPlayerX], a ; $5f94
	ld a, $44 ; $5f97
	ld [wBriefingPlayerY], a ; $5f99
	frame_task DrawBriefingPlayerSprite ; $5f9c
	ld a, $34 ; $5fa4
	ld [wBriefingOpponentX], a ; $5fa6
	ld a, $06 ; $5fa9
	ld [wBriefingOpponentY], a ; $5fab
	frame_task DrawBriefingOpponentSprite ; $5fae
	ld a, $4e ; $5fb6
	ld [wBriefingBallX], a ; $5fb8
	ld a, $38 ; $5fbb
	ld [wBriefingBallY], a ; $5fbd
	frame_task DrawBriefingBallSprite ; $5fc0
	ld a, $00 ; $5fc8
	ld [wBriefingHandUnflipped], a ; $5fca
	ld a, $3a ; $5fcd
	ld [wBriefingHandX], a ; $5fcf
	ld a, $3c ; $5fd2
	ld [wBriefingHandY], a ; $5fd4
	frame_task DrawBriefingPointingHand ; $5fd7
	ld a, $03 ; $5fdf
	ld [wBriefingDiagArrowDir], a ; $5fe1
	ld a, $52 ; $5fe4
	ld [wBriefingDiagArrowX], a ; $5fe6
	ld a, $40 ; $5fe9
	ld [wBriefingDiagArrowY], a ; $5feb
	frame_task DrawBriefingDiagonalArrow ; $5fee
	ld b, $06 ; $5ff6
	call DrawDiagramTargetOverlay ; $5ff8
	frame_task CycleDiagramTargetPalette ; $5ffb
	ld hl, Text_BriefServeVolleyRunToLine ; $6003
	call DrawBriefingCaption ; $6006
	call WaitForInputBlinking ; $6009
	call ClearFrameTasks ; $600c
	frame_task UpdateAnimatedTilesTask_17 ; $600f
	call DrawDiagramTargetOverlay ; $6017
	ld a, $03 ; $601a
	ld [wBriefingAnimStep], a ; $601c
	call ServeAndVolleyBriefing_AdvanceAnim ; $601f
	frame_task DrawBriefingPlayerSprite ; $6022
	frame_task DrawBriefingOpponentSprite ; $602a
	frame_task DrawBriefingBallSprite ; $6032
	frame_task DrawBriefingPointingHand ; $603a
	frame_task DrawBriefingDiagonalArrow ; $6042
	frame_task DrawBriefingDownArrow ; $604a
	ld a, $0d ; $6052
	ld [wBriefingBracketWidth], a ; $6054
	ld a, $0f ; $6057
	ld [wBriefingBracketHeight], a ; $6059
	frame_task DrawBriefingTargetBrackets ; $605c
	ld hl, Text_BriefServeVolleyAimOpposite ; $6064
	call DrawBriefingCaption ; $6067
	call WaitForInputBlinking ; $606a
	call ClearFrameTasks ; $606d
	frame_task UpdateAnimatedTilesTask_17 ; $6070
	ld a, $03 ; $6078
	ld [wBriefingAnimStep], a ; $607a
	call ServeAndVolleyBriefing_AdvanceAnim ; $607d
	frame_task DrawBriefingPlayerSprite ; $6080
	frame_task DrawBriefingOpponentSprite ; $6088
	frame_task DrawBriefingBallSprite ; $6090
	frame_task DrawBriefingPointingHand ; $6098
	frame_task DrawBriefingDiagonalArrow ; $60a0
	frame_task DrawBriefingDownArrow ; $60a8
	ld a, $0d ; $60b0
	ld [wBriefingBracketWidth], a ; $60b2
	ld a, $0f ; $60b5
	ld [wBriefingBracketHeight], a ; $60b7
	frame_task DrawBriefingTargetBrackets ; $60ba
	ld hl, Text_BriefServeVolleyAllPositions ; $60c2
	call DrawBriefingCaption ; $60c5
	xor a ; $60c8
	ld [wBriefingAnimTimer], a ; $60c9
	ld [wBriefingAnimStep], a ; $60cc
.loop:
	call ServeAndVolleyBriefing_TickAnim ; $60cf
	ld c, BRIEFPROMPT_NONE ; $60d2
	call AdvanceFrameCheckInput ; $60d4
	and a ; $60d7
	jp z, .loop ; $60d8
	call ClearFrameTasks ; $60db
	ret ; $60de
ServeAndVolleyBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $60df
	inc a ; $60e2
	ld [wBriefingAnimTimer], a ; $60e3
	cp $78 ; $60e6
	jp nc, ServeAndVolleyBriefing_AdvanceAnim ; $60e8
	ret ; $60eb
ServeAndVolleyBriefing_AdvanceAnim:
	xor a ; $60ec
	ld [wBriefingAnimTimer], a ; $60ed
	ld a, [wBriefingAnimStep] ; $60f0
	inc a ; $60f3
	and $03 ; $60f4
	ld [wBriefingAnimStep], a ; $60f6
	sla a ; $60f9
	sla a ; $60fb
	ld c, a ; $60fd
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_PlayerPosTable ; $60fe
	ld a, [hl] ; $6105
	inc hl ; $6106
	inc hl ; $6107
	ld b, [hl] ; $6108
	ld a, a ; $6109
	ld [wBriefingPlayerX], a ; $610a
	ld a, b ; $610d
	ld [wBriefingPlayerY], a ; $610e
	ld a, c ; $6111
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable ; $6112
	ld a, [hl] ; $6119
	inc hl ; $611a
	inc hl ; $611b
	ld b, [hl] ; $611c
	ld a, a ; $611d
	ld [wBriefingOpponentX], a ; $611e
	ld a, b ; $6121
	ld [wBriefingOpponentY], a ; $6122
	ld a, c ; $6125
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable ; $6126
	ld a, [hl] ; $612d
	inc hl ; $612e
	inc hl ; $612f
	ld b, [hl] ; $6130
	ld a, a ; $6131
	ld [wBriefingBracketX], a ; $6132
	ld a, b ; $6135
	ld [wBriefingBracketY], a ; $6136
	ld a, c ; $6139
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_BallPosTable ; $613a
	ld a, [hl] ; $6141
	inc hl ; $6142
	inc hl ; $6143
	ld b, [hl] ; $6144
	ld a, a ; $6145
	ld [wBriefingBallX], a ; $6146
	ld a, b ; $6149
	ld [wBriefingBallY], a ; $614a
	ld a, [wBriefingAnimStep] ; $614d
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HandUnflippedTable ; $6150
	ld a, [hl] ; $6157
	ld [wBriefingHandUnflipped], a ; $6158
	ld a, c ; $615b
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HandPosTable ; $615c
	ld a, [hl] ; $6163
	inc hl ; $6164
	inc hl ; $6165
	ld b, [hl] ; $6166
	ld a, a ; $6167
	ld [wBriefingHandX], a ; $6168
	ld a, b ; $616b
	ld [wBriefingHandY], a ; $616c
	ld a, [wBriefingAnimStep] ; $616f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_DiagArrowDirTable ; $6172
	ld a, [hl] ; $6179
	ld [wBriefingDiagArrowDir], a ; $617a
	ld a, c ; $617d
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_DiagArrowPosTable ; $617e
	ld a, [hl] ; $6185
	inc hl ; $6186
	inc hl ; $6187
	ld b, [hl] ; $6188
	ld a, a ; $6189
	ld [wBriefingDiagArrowX], a ; $618a
	ld a, b ; $618d
	ld [wBriefingDiagArrowY], a ; $618e
	ld a, [wBriefingAnimStep] ; $6191
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_DownArrowUnflippedTable ; $6194
	ld a, [hl] ; $619b
	ld [wBriefingDownArrowUnflipped], a ; $619c
	ld a, c ; $619f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_DownArrowPosTable ; $61a0
	ld a, [hl] ; $61a7
	inc hl ; $61a8
	inc hl ; $61a9
	ld b, [hl] ; $61aa
	ld a, a ; $61ab
	ld [wBriefingDownArrowX], a ; $61ac
	ld a, b ; $61af
	ld [wBriefingDownArrowY], a ; $61b0
	ret ; $61b3
ServeAndVolleyBriefing_AdvanceAnim_PlayerPosTable:
	; $61b4, 16 bytes (records:2)
	dw $0052 ; record 0
	dw $0030 ; record 1
	dw $003c ; record 2
	dw $0030 ; record 3
	dw $003c ; record 4
	dw $0018 ; record 5
	dw $0052 ; record 6
	dw $0018 ; record 7
ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable.asm" ; $61c4, 16 bytes (words:2)
ServeAndVolleyBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_BallPosTable.asm" ; $61d4, 16 bytes (words:2)
ServeAndVolleyBriefing_AdvanceAnim_HandUnflippedTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_HandUnflippedTable.asm" ; $61e4, 4 bytes (bytes:4)
ServeAndVolleyBriefing_AdvanceAnim_HandPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_HandPosTable.asm" ; $61e8, 16 bytes (words:2)
ServeAndVolleyBriefing_AdvanceAnim_DiagArrowDirTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_DiagArrowDirTable.asm" ; $61f8, 4 bytes (bytes:4)
ServeAndVolleyBriefing_AdvanceAnim_DiagArrowPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_DiagArrowPosTable.asm" ; $61fc, 16 bytes (words:2)
ServeAndVolleyBriefing_AdvanceAnim_DownArrowUnflippedTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_DownArrowUnflippedTable.asm" ; $620c, 4 bytes (bytes:4)
ServeAndVolleyBriefing_AdvanceAnim_DownArrowPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_DownArrowPosTable.asm" ; $6210, 16 bytes (words:2)
ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable:
	INCLUDE "data/engine/menus/briefing/ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable.asm" ; $6220, 16 bytes (words:2)
