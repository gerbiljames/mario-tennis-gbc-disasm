DrillBriefing_ServeThroughPoles:
	ld a, $03 ; $5c67
	ld [wBriefingAnimStep], a ; $5c69
	call PoleServeBriefing_AdvanceAnim ; $5c6c
	ld a, $01 ; $5c6f
	ld hl, DrawBriefingPlayerSprite ; $5c71
	call RegisterFrameTask ; $5c74
	ld a, $01 ; $5c77
	ld hl, DrawBriefingBallSprite ; $5c79
	call RegisterFrameTask ; $5c7c
	ld a, $01 ; $5c7f
	ld hl, DrawBriefingMarkerHFlip ; $5c81
	call RegisterFrameTask ; $5c84
	ld a, $01 ; $5c87
	ld hl, DrawBriefingMarkerRotated ; $5c89
	call RegisterFrameTask ; $5c8c
	ld a, $01 ; $5c8f
	ld hl, CycleDiagramTargetPalette ; $5c91
	call RegisterFrameTask ; $5c94
	ld hl, Text_36_699 ; $5c97
	call DrawBriefingCaption ; $5c9a
	xor a ; $5c9d
	ld [wBriefingAnimTimer], a ; $5c9e
	ld [wBriefingAnimStep], a ; $5ca1
.loop:
	call PoleServeBriefing_TickAnim ; $5ca4
	ld c, $00 ; $5ca7
	call AdvanceFrameCheckInput ; $5ca9
	and a ; $5cac
	jp z, .loop ; $5cad
	call ClearFrameTasks ; $5cb0
	ld a, $01 ; $5cb3
	ld hl, UpdateAnimatedTilesTask_17 ; $5cb5
	call RegisterFrameTask ; $5cb8
	ld a, $03 ; $5cbb
	ld [wBriefingAnimStep], a ; $5cbd
	call PoleServeBriefing_AdvanceAnim2 ; $5cc0
	ld a, $01 ; $5cc3
	ld hl, DrawBriefingPlayerSprite ; $5cc5
	call RegisterFrameTask ; $5cc8
	ld a, $01 ; $5ccb
	ld hl, DrawBriefingMarkerHFlip ; $5ccd
	call RegisterFrameTask ; $5cd0
	ld a, $01 ; $5cd3
	ld hl, CycleDiagramTargetPalette ; $5cd5
	call RegisterFrameTask ; $5cd8
	ld a, $00 ; $5cdb
	ld [wBriefingBracketWidth], a ; $5cdd
	ld a, $00 ; $5ce0
	ld [wBriefingBracketHeight], a ; $5ce2
	ld a, $01 ; $5ce5
	ld hl, DrawBriefingTargetBrackets ; $5ce7
	call RegisterFrameTask ; $5cea
	ld hl, Text_36_700 ; $5ced
	call DrawBriefingCaption ; $5cf0
	xor a ; $5cf3
	ld [wBriefingAnimTimer], a ; $5cf4
	ld [wBriefingAnimStep], a ; $5cf7
.loopB:
	call PoleServeBriefing_TickAnim2 ; $5cfa
	ld a, [wBriefingAnimStep] ; $5cfd
	sla a ; $5d00
	sla a ; $5d02
	ld_hl_indexed DrillBriefing_ServeThroughPolesTable ; $5d04
	ld a, [hl] ; $5d0b
	inc hl ; $5d0c
	inc hl ; $5d0d
	ld b, [hl] ; $5d0e
	ld a, a ; $5d0f
	ld [wBriefingPlayerX], a ; $5d10
	ld a, b ; $5d13
	ld [wBriefingPlayerY], a ; $5d14
	ld c, $00 ; $5d17
	call AdvanceFrameCheckInput ; $5d19
	and a ; $5d1c
	jp z, .loopB ; $5d1d
	call ClearFrameTasks ; $5d20
	ld a, $01 ; $5d23
	ld hl, UpdateAnimatedTilesTask_17 ; $5d25
	call RegisterFrameTask ; $5d28
	ld a, $03 ; $5d2b
	ld [wBriefingAnimStep], a ; $5d2d
	call PoleServeBriefing_AdvanceAnim2 ; $5d30
	ld a, $01 ; $5d33
	ld hl, DrawBriefingPlayerSprite ; $5d35
	call RegisterFrameTask ; $5d38
	ld a, $00 ; $5d3b
	ld [wBriefingHMarkerUnflipped], a ; $5d3d
	ld a, $4b ; $5d40
	ld [wBriefingHMarkerX], a ; $5d42
	ld a, $36 ; $5d45
	ld [wBriefingHMarkerY], a ; $5d47
	ld a, $01 ; $5d4a
	ld hl, DrawBriefingMarkerHFlip ; $5d4c
	call RegisterFrameTask ; $5d4f
	ld a, $01 ; $5d52
	ld hl, DrawBriefingPoleSprites ; $5d54
	call RegisterFrameTask ; $5d57
	ld a, $01 ; $5d5a
	ld hl, CycleDiagramTargetPalette ; $5d5c
	call RegisterFrameTask ; $5d5f
	ld a, $00 ; $5d62
	ld [wBriefingBracketWidth], a ; $5d64
	ld a, $00 ; $5d67
	ld [wBriefingBracketHeight], a ; $5d69
	ld a, $01 ; $5d6c
	ld hl, DrawBriefingTargetBrackets ; $5d6e
	call RegisterFrameTask ; $5d71
	ld hl, Text_36_701 ; $5d74
	call DrawBriefingCaption ; $5d77
	call WaitForInputBlinking ; $5d7a
	call ClearFrameTasks ; $5d7d
	ld a, $01 ; $5d80
	ld hl, UpdateAnimatedTilesTask_17 ; $5d82
	call RegisterFrameTask ; $5d85
	ld a, $03 ; $5d88
	ld [wBriefingAnimStep], a ; $5d8a
	call PoleServeBriefing_AdvanceAnim2 ; $5d8d
	ld a, $01 ; $5d90
	ld hl, DrawBriefingPlayerSprite ; $5d92
	call RegisterFrameTask ; $5d95
	ld a, $01 ; $5d98
	ld hl, DrawBriefingPoleSprites ; $5d9a
	call RegisterFrameTask ; $5d9d
	ld a, $01 ; $5da0
	ld hl, CycleDiagramTargetPalette ; $5da2
	call RegisterFrameTask ; $5da5
	ld a, $00 ; $5da8
	ld [wBriefingBracketWidth], a ; $5daa
	ld a, $00 ; $5dad
	ld [wBriefingBracketHeight], a ; $5daf
	ld a, $01 ; $5db2
	ld hl, DrawBriefingTargetBrackets ; $5db4
	call RegisterFrameTask ; $5db7
	ld hl, Text_36_702 ; $5dba
	call DrawBriefingCaption ; $5dbd
.loop2:
	call PoleServeBriefing_TickAnim2 ; $5dc0
	ld c, $01 ; $5dc3
	call AdvanceFrameCheckInput ; $5dc5
	and a ; $5dc8
	jp z, .loop2 ; $5dc9
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
	ld_hl_indexed DrillBriefing_ServeThroughPolesTable ; $5dee
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
	ld_hl_indexed PoleServeBriefing_HMarkerUnflippedTable ; $5e18
	ld a, [hl] ; $5e1f
	ld [wBriefingHMarkerUnflipped], a ; $5e20
	ld a, c ; $5e23
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_HMarkerPosTable ; $5e24
	ld a, [hl] ; $5e2b
	inc hl ; $5e2c
	inc hl ; $5e2d
	ld b, [hl] ; $5e2e
	ld a, a ; $5e2f
	ld [wBriefingHMarkerX], a ; $5e30
	ld a, b ; $5e33
	ld [wBriefingHMarkerY], a ; $5e34
	ld a, [wBriefingAnimStep] ; $5e37
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_RotMarkerDirTable ; $5e3a
	ld a, [hl] ; $5e41
	ld [wBriefingRotMarkerDir], a ; $5e42
	ld a, c ; $5e45
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_RotMarkerPosTable ; $5e46
	ld a, [hl] ; $5e4d
	inc hl ; $5e4e
	inc hl ; $5e4f
	ld b, [hl] ; $5e50
	ld a, a ; $5e51
	ld [wBriefingRotMarkerX], a ; $5e52
	ld a, b ; $5e55
	ld [wBriefingRotMarkerY], a ; $5e56
	ld a, [wBriefingAnimStep] ; $5e59
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5e5c
	ld b, [hl] ; $5e63
	call DrawDiagramTargetOverlay ; $5e64
	ret ; $5e67
PoleServeBriefing_TickAnim2:
	ld a, [wBriefingAnimTimer] ; $5e68
	inc a ; $5e6b
	ld [wBriefingAnimTimer], a ; $5e6c
	cp $78 ; $5e6f
	jr nc, PoleServeBriefing_AdvanceAnim2 ; $5e71
	ret ; $5e73
PoleServeBriefing_AdvanceAnim2:
	xor a ; $5e74
	ld [wBriefingAnimTimer], a ; $5e75
	ld a, [wBriefingAnimStep] ; $5e78
	inc a ; $5e7b
	and $03 ; $5e7c
	ld [wBriefingAnimStep], a ; $5e7e
	sla a ; $5e81
	sla a ; $5e83
	ld c, a ; $5e85
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PlayerPosTable ; $5e86
	ld a, [hl] ; $5e8d
	inc hl ; $5e8e
	inc hl ; $5e8f
	ld b, [hl] ; $5e90
	ld a, a ; $5e91
	ld [wBriefingPlayerX], a ; $5e92
	ld a, b ; $5e95
	ld [wBriefingPlayerY], a ; $5e96
	ld a, c ; $5e99
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_BracketPosTable ; $5e9a
	ld a, [hl] ; $5ea1
	inc hl ; $5ea2
	inc hl ; $5ea3
	ld b, [hl] ; $5ea4
	ld a, a ; $5ea5
	ld [wBriefingBracketX], a ; $5ea6
	ld a, b ; $5ea9
	ld [wBriefingBracketY], a ; $5eaa
	ld a, c ; $5ead
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PolePosTable ; $5eae
	ld a, [hl] ; $5eb5
	inc hl ; $5eb6
	inc hl ; $5eb7
	ld b, [hl] ; $5eb8
	ld a, a ; $5eb9
	ld [wBriefingPole1X], a ; $5eba
	ld a, b ; $5ebd
	ld [wBriefingPole1Y], a ; $5ebe
	ld a, c ; $5ec1
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PolePosTable ; $5ec2
	ld a, [hl] ; $5ec9
	add $08 ; $5eca
	ld [wBriefingPole2X], a ; $5ecc
	ld a, [wBriefingPole1Y] ; $5ecf
	ld [wBriefingPole2Y], a ; $5ed2
	ld a, [wBriefingAnimStep] ; $5ed5
	ld_hl_indexed PoleServeBriefing_HMarkerUnflippedTable ; $5ed8
	ld a, [hl] ; $5edf
	ld [wBriefingHMarkerUnflipped], a ; $5ee0
	ld a, c ; $5ee3
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_HMarkerPosTable ; $5ee4
	ld a, [hl] ; $5eeb
	inc hl ; $5eec
	inc hl ; $5eed
	ld b, [hl] ; $5eee
	ld a, a ; $5eef
	ld [wBriefingHMarkerX], a ; $5ef0
	ld a, b ; $5ef3
	ld [wBriefingHMarkerY], a ; $5ef4
	ld a, [wBriefingAnimStep] ; $5ef7
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5efa
	ld b, [hl] ; $5f01
	call DrawDiagramTargetOverlay ; $5f02
	ret ; $5f05
DrillBriefing_ServeThroughPolesTable:
	; $5f06, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
PoleServeBriefing_AdvanceAnim2_PlayerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_PlayerPosTable.asm" ; $5f16, 16 bytes
PoleServeBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim_BallPosTable.asm" ; $5f26, 16 bytes
PoleServeBriefing_HMarkerUnflippedTable:
	INCBIN "data/bank_017/PoleServeBriefing_HMarkerUnflippedTable.bin" ; $5f36, 4 bytes
PoleServeBriefing_AdvanceAnim_HMarkerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim_HMarkerPosTable.asm" ; $5f3a, 16 bytes
PoleServeBriefing_AdvanceAnim2_HMarkerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_HMarkerPosTable.asm" ; $5f4a, 16 bytes
PoleServeBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/PoleServeBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $5f5a, 4 bytes
PoleServeBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/PoleServeBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $5f5e, 16 bytes
PoleServeBriefing_TargetOverlayTable:
	INCBIN "data/bank_017/PoleServeBriefing_TargetOverlayTable.bin" ; $5f6e, 4 bytes
PoleServeBriefing_AdvanceAnim2_BracketPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_BracketPosTable.asm" ; $5f72, 16 bytes
PoleServeBriefing_AdvanceAnim2_PolePosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_PolePosTable.asm" ; $5f82, 16 bytes
DrillBriefing_ServeAndVolley:
	ld a, $52 ; $5f92
	ld [wBriefingPlayerX], a ; $5f94
	ld a, $44 ; $5f97
	ld [wBriefingPlayerY], a ; $5f99
	ld a, $01 ; $5f9c
	ld hl, DrawBriefingPlayerSprite ; $5f9e
	call RegisterFrameTask ; $5fa1
	ld a, $34 ; $5fa4
	ld [wBriefingOpponentX], a ; $5fa6
	ld a, $06 ; $5fa9
	ld [wBriefingOpponentY], a ; $5fab
	ld a, $01 ; $5fae
	ld hl, DrawBriefingOpponentSprite ; $5fb0
	call RegisterFrameTask ; $5fb3
	ld a, $4e ; $5fb6
	ld [wBriefingBallX], a ; $5fb8
	ld a, $38 ; $5fbb
	ld [wBriefingBallY], a ; $5fbd
	ld a, $01 ; $5fc0
	ld hl, DrawBriefingBallSprite ; $5fc2
	call RegisterFrameTask ; $5fc5
	ld a, $00 ; $5fc8
	ld [wBriefingHMarkerUnflipped], a ; $5fca
	ld a, $3a ; $5fcd
	ld [wBriefingHMarkerX], a ; $5fcf
	ld a, $3c ; $5fd2
	ld [wBriefingHMarkerY], a ; $5fd4
	ld a, $01 ; $5fd7
	ld hl, DrawBriefingMarkerHFlip ; $5fd9
	call RegisterFrameTask ; $5fdc
	ld a, $03 ; $5fdf
	ld [wBriefingRotMarkerDir], a ; $5fe1
	ld a, $52 ; $5fe4
	ld [wBriefingRotMarkerX], a ; $5fe6
	ld a, $40 ; $5fe9
	ld [wBriefingRotMarkerY], a ; $5feb
	ld a, $01 ; $5fee
	ld hl, DrawBriefingMarkerRotated ; $5ff0
	call RegisterFrameTask ; $5ff3
	ld b, $06 ; $5ff6
	call DrawDiagramTargetOverlay ; $5ff8
	ld a, $01 ; $5ffb
	ld hl, CycleDiagramTargetPalette ; $5ffd
	call RegisterFrameTask ; $6000
	ld hl, Text_36_703 ; $6003
	call DrawBriefingCaption ; $6006
	call WaitForInputBlinking ; $6009
	call ClearFrameTasks ; $600c
	ld a, $01 ; $600f
	ld hl, UpdateAnimatedTilesTask_17 ; $6011
	call RegisterFrameTask ; $6014
	call DrawDiagramTargetOverlay ; $6017
	ld a, $03 ; $601a
	ld [wBriefingAnimStep], a ; $601c
	call ServeAndVolleyBriefing_AdvanceAnim ; $601f
	ld a, $01 ; $6022
	ld hl, DrawBriefingPlayerSprite ; $6024
	call RegisterFrameTask ; $6027
	ld a, $01 ; $602a
	ld hl, DrawBriefingOpponentSprite ; $602c
	call RegisterFrameTask ; $602f
	ld a, $01 ; $6032
	ld hl, DrawBriefingBallSprite ; $6034
	call RegisterFrameTask ; $6037
	ld a, $01 ; $603a
	ld hl, DrawBriefingMarkerHFlip ; $603c
	call RegisterFrameTask ; $603f
	ld a, $01 ; $6042
	ld hl, DrawBriefingMarkerRotated ; $6044
	call RegisterFrameTask ; $6047
	ld a, $01 ; $604a
	ld hl, DrawBriefingMarkerVFlip ; $604c
	call RegisterFrameTask ; $604f
	ld a, $0d ; $6052
	ld [wBriefingBracketWidth], a ; $6054
	ld a, $0f ; $6057
	ld [wBriefingBracketHeight], a ; $6059
	ld a, $01 ; $605c
	ld hl, DrawBriefingTargetBrackets ; $605e
	call RegisterFrameTask ; $6061
	ld hl, Text_36_704 ; $6064
	call DrawBriefingCaption ; $6067
	call WaitForInputBlinking ; $606a
	call ClearFrameTasks ; $606d
	ld a, $01 ; $6070
	ld hl, UpdateAnimatedTilesTask_17 ; $6072
	call RegisterFrameTask ; $6075
	ld a, $03 ; $6078
	ld [wBriefingAnimStep], a ; $607a
	call ServeAndVolleyBriefing_AdvanceAnim ; $607d
	ld a, $01 ; $6080
	ld hl, DrawBriefingPlayerSprite ; $6082
	call RegisterFrameTask ; $6085
	ld a, $01 ; $6088
	ld hl, DrawBriefingOpponentSprite ; $608a
	call RegisterFrameTask ; $608d
	ld a, $01 ; $6090
	ld hl, DrawBriefingBallSprite ; $6092
	call RegisterFrameTask ; $6095
	ld a, $01 ; $6098
	ld hl, DrawBriefingMarkerHFlip ; $609a
	call RegisterFrameTask ; $609d
	ld a, $01 ; $60a0
	ld hl, DrawBriefingMarkerRotated ; $60a2
	call RegisterFrameTask ; $60a5
	ld a, $01 ; $60a8
	ld hl, DrawBriefingMarkerVFlip ; $60aa
	call RegisterFrameTask ; $60ad
	ld a, $0d ; $60b0
	ld [wBriefingBracketWidth], a ; $60b2
	ld a, $0f ; $60b5
	ld [wBriefingBracketHeight], a ; $60b7
	ld a, $01 ; $60ba
	ld hl, DrawBriefingTargetBrackets ; $60bc
	call RegisterFrameTask ; $60bf
	ld hl, Text_36_705 ; $60c2
	call DrawBriefingCaption ; $60c5
	xor a ; $60c8
	ld [wBriefingAnimTimer], a ; $60c9
	ld [wBriefingAnimStep], a ; $60cc
.loop:
	call ServeAndVolleyBriefing_TickAnim ; $60cf
	ld c, $01 ; $60d2
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
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnimTable ; $60fe
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
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6150
	ld a, [hl] ; $6157
	ld [wBriefingHMarkerUnflipped], a ; $6158
	ld a, c ; $615b
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable ; $615c
	ld a, [hl] ; $6163
	inc hl ; $6164
	inc hl ; $6165
	ld b, [hl] ; $6166
	ld a, a ; $6167
	ld [wBriefingHMarkerX], a ; $6168
	ld a, b ; $616b
	ld [wBriefingHMarkerY], a ; $616c
	ld a, [wBriefingAnimStep] ; $616f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable ; $6172
	ld a, [hl] ; $6179
	ld [wBriefingRotMarkerDir], a ; $617a
	ld a, c ; $617d
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable ; $617e
	ld a, [hl] ; $6185
	inc hl ; $6186
	inc hl ; $6187
	ld b, [hl] ; $6188
	ld a, a ; $6189
	ld [wBriefingRotMarkerX], a ; $618a
	ld a, b ; $618d
	ld [wBriefingRotMarkerY], a ; $618e
	ld a, [wBriefingAnimStep] ; $6191
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable ; $6194
	ld a, [hl] ; $619b
	ld [wBriefingVMarkerUpright], a ; $619c
	ld a, c ; $619f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable ; $61a0
	ld a, [hl] ; $61a7
	inc hl ; $61a8
	inc hl ; $61a9
	ld b, [hl] ; $61aa
	ld a, a ; $61ab
	ld [wBriefingVMarkerX], a ; $61ac
	ld a, b ; $61af
	ld [wBriefingVMarkerY], a ; $61b0
	ret ; $61b3
ServeAndVolleyBriefing_AdvanceAnimTable:
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
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable.bin" ; $61c4, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_BallPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_BallPosTable.bin" ; $61d4, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $61e4, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $61e8, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $61f8, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $61fc, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable.bin" ; $620c, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable:
	INCLUDE "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable.asm" ; $6210, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable.bin" ; $6220, 16 bytes
