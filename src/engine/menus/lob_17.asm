ReturnToTargetBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6958
	inc a ; $695b
	ld [wBriefingAnimTimer], a ; $695c
	cp $78 ; $695f
	jp nc, ReturnToTargetBriefing_AdvanceAnim ; $6961
	ret ; $6964
ReturnToTargetBriefing_AdvanceAnim:
	xor a ; $6965
	ld [wBriefingAnimTimer], a ; $6966
	ld a, [wBriefingAnimStep] ; $6969
	inc a ; $696c
	and $03 ; $696d
	ld [wBriefingAnimStep], a ; $696f
	sla a ; $6972
	sla a ; $6974
	ld c, a ; $6976
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnimTable ; $6977
	ld a, [hl] ; $697e
	inc hl ; $697f
	inc hl ; $6980
	ld b, [hl] ; $6981
	ld a, a ; $6982
	ld [wBriefingPlayerX], a ; $6983
	ld a, b ; $6986
	ld [wBriefingPlayerY], a ; $6987
	ld a, c ; $698a
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable ; $698b
	ld a, [hl] ; $6992
	inc hl ; $6993
	inc hl ; $6994
	ld b, [hl] ; $6995
	ld a, a ; $6996
	ld [wBriefingOpponentX], a ; $6997
	ld a, b ; $699a
	ld [wBriefingOpponentY], a ; $699b
	ld a, c ; $699e
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_BracketPosTable ; $699f
	ld a, [hl] ; $69a6
	inc hl ; $69a7
	inc hl ; $69a8
	ld b, [hl] ; $69a9
	ld a, a ; $69aa
	ld [wBriefingBracketX], a ; $69ab
	ld a, b ; $69ae
	ld [wBriefingBracketY], a ; $69af
	ld a, c ; $69b2
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_BallPosTable ; $69b3
	ld a, [hl] ; $69ba
	inc hl ; $69bb
	inc hl ; $69bc
	ld b, [hl] ; $69bd
	ld a, a ; $69be
	ld [wBriefingBallX], a ; $69bf
	ld a, b ; $69c2
	ld [wBriefingBallY], a ; $69c3
	ld a, [wBriefingAnimStep] ; $69c6
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable ; $69c9
	ld a, [hl] ; $69d0
	ld [wBriefingHMarkerUnflipped], a ; $69d1
	ld a, c ; $69d4
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable ; $69d5
	ld a, [hl] ; $69dc
	inc hl ; $69dd
	inc hl ; $69de
	ld b, [hl] ; $69df
	ld a, a ; $69e0
	ld [wBriefingHMarkerX], a ; $69e1
	ld a, b ; $69e4
	ld [wBriefingHMarkerY], a ; $69e5
	ld a, [wBriefingAnimStep] ; $69e8
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable ; $69eb
	ld a, [hl] ; $69f2
	ld [wBriefingRotMarkerDir], a ; $69f3
	ld a, c ; $69f6
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable ; $69f7
	ld a, [hl] ; $69fe
	inc hl ; $69ff
	inc hl ; $6a00
	ld b, [hl] ; $6a01
	ld a, a ; $6a02
	ld [wBriefingRotMarkerX], a ; $6a03
	ld a, b ; $6a06
	ld [wBriefingRotMarkerY], a ; $6a07
	ret ; $6a0a
ReturnToTargetBriefing_AdvanceAnimTable:
	; $6a0b, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6a1b, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_BallPosTable.asm" ; $6a2b, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6a3b, 4 bytes
ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6a3f, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $6a4f, 4 bytes
ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $6a53, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_BracketPosTable.bin" ; $6a63, 16 bytes
DrillBriefing_ReturnLob:
	ld a, $55 ; $6a73
	ld [wBriefingPlayerX], a ; $6a75
	ld a, $44 ; $6a78
	ld [wBriefingPlayerY], a ; $6a7a
	ld a, $01 ; $6a7d
	ld hl, DrawBriefingPlayerSprite ; $6a7f
	call RegisterFrameTask ; $6a82
	ld a, $3a ; $6a85
	ld [wBriefingOpponentX], a ; $6a87
	ld a, $03 ; $6a8a
	ld [wBriefingOpponentY], a ; $6a8c
	ld a, $01 ; $6a8f
	ld hl, DrawBriefingOpponentSprite ; $6a91
	call RegisterFrameTask ; $6a94
	ld a, $56 ; $6a97
	ld [wBriefingBallX], a ; $6a99
	ld a, $28 ; $6a9c
	ld [wBriefingBallY], a ; $6a9e
	ld a, $01 ; $6aa1
	ld hl, DrawBriefingBallSprite ; $6aa3
	call RegisterFrameTask ; $6aa6
	ld a, $01 ; $6aa9
	ld [wBriefingRotMarkerDir], a ; $6aab
	ld a, $4c ; $6aae
	ld [wBriefingRotMarkerX], a ; $6ab0
	ld a, $16 ; $6ab3
	ld [wBriefingRotMarkerY], a ; $6ab5
	ld a, $01 ; $6ab8
	ld hl, DrawBriefingMarkerRotated ; $6aba
	call RegisterFrameTask ; $6abd
	ld hl, Text_37_6 ; $6ac0
	call DrawBriefingCaption ; $6ac3
	call WaitForInputBlinking ; $6ac6
	call ClearFrameTasks ; $6ac9
	ld a, $01 ; $6acc
	ld hl, UpdateAnimatedTilesTask_17 ; $6ace
	call RegisterFrameTask ; $6ad1
	ld a, $03 ; $6ad4
	ld [wBriefingAnimStep], a ; $6ad6
	call ReturnLobBriefing_AdvanceAnim ; $6ad9
	ld a, $01 ; $6adc
	ld hl, DrawBriefingPlayerSprite ; $6ade
	call RegisterFrameTask ; $6ae1
	ld a, $01 ; $6ae4
	ld hl, DrawBriefingOpponentSprite ; $6ae6
	call RegisterFrameTask ; $6ae9
	ld a, $01 ; $6aec
	ld hl, DrawBriefingBallSprite ; $6aee
	call RegisterFrameTask ; $6af1
	ld a, $01 ; $6af4
	ld hl, DrawBriefingMarkerHFlip ; $6af6
	call RegisterFrameTask ; $6af9
	ld a, $01 ; $6afc
	ld hl, DrawBriefingMarkerRotated ; $6afe
	call RegisterFrameTask ; $6b01
	ld a, $01 ; $6b04
	ld hl, DrawBriefingSwingAnim ; $6b06
	call RegisterFrameTask ; $6b09
	ld a, $0d ; $6b0c
	ld [wBriefingBracketWidth], a ; $6b0e
	ld a, $09 ; $6b11
	ld [wBriefingBracketHeight], a ; $6b13
	ld a, $01 ; $6b16
	ld hl, DrawBriefingTargetBrackets ; $6b18
	call RegisterFrameTask ; $6b1b
	ld hl, Text_37_7 ; $6b1e
	call DrawBriefingCaption ; $6b21
	call WaitForInputBlinking ; $6b24
	call ClearFrameTasks ; $6b27
	ld a, $01 ; $6b2a
	ld hl, UpdateAnimatedTilesTask_17 ; $6b2c
	call RegisterFrameTask ; $6b2f
	ld a, $03 ; $6b32
	ld [wBriefingAnimStep], a ; $6b34
	call ReturnLobBriefing_AdvanceAnim ; $6b37
	ld a, $01 ; $6b3a
	ld hl, DrawBriefingPlayerSprite ; $6b3c
	call RegisterFrameTask ; $6b3f
	ld a, $01 ; $6b42
	ld hl, DrawBriefingOpponentSprite ; $6b44
	call RegisterFrameTask ; $6b47
	ld a, $01 ; $6b4a
	ld hl, DrawBriefingBallSprite ; $6b4c
	call RegisterFrameTask ; $6b4f
	ld a, $01 ; $6b52
	ld hl, DrawBriefingMarkerHFlip ; $6b54
	call RegisterFrameTask ; $6b57
	ld a, $01 ; $6b5a
	ld hl, DrawBriefingMarkerRotated ; $6b5c
	call RegisterFrameTask ; $6b5f
	ld a, $01 ; $6b62
	ld hl, DrawBriefingSwingAnim ; $6b64
	call RegisterFrameTask ; $6b67
	ld a, $0d ; $6b6a
	ld [wBriefingBracketWidth], a ; $6b6c
	ld a, $09 ; $6b6f
	ld [wBriefingBracketHeight], a ; $6b71
	ld a, $01 ; $6b74
	ld hl, DrawBriefingTargetBrackets ; $6b76
	call RegisterFrameTask ; $6b79
	ld hl, Text_37_8 ; $6b7c
	call DrawBriefingCaption ; $6b7f
	xor a ; $6b82
	ld [wBriefingAnimTimer], a ; $6b83
	ld [wBriefingAnimStep], a ; $6b86
.loop:
	call ReturnLobBriefing_TickAnim ; $6b89
	ld c, $01 ; $6b8c
	call AdvanceFrameCheckInput ; $6b8e
	and a ; $6b91
	jp z, .loop ; $6b92
	call ClearFrameTasks ; $6b95
	ret ; $6b98
ReturnLobBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6b99
	inc a ; $6b9c
	ld [wBriefingAnimTimer], a ; $6b9d
	cp $78 ; $6ba0
	jp nc, ReturnLobBriefing_AdvanceAnim ; $6ba2
	ret ; $6ba5
ReturnLobBriefing_AdvanceAnim:
	xor a ; $6ba6
	ld [wBriefingAnimTimer], a ; $6ba7
	ld a, [wBriefingAnimStep] ; $6baa
	inc a ; $6bad
	and $03 ; $6bae
	ld [wBriefingAnimStep], a ; $6bb0
	sla a ; $6bb3
	sla a ; $6bb5
	ld c, a ; $6bb7
	ld_hl_indexed ReturnLobBriefing_AdvanceAnimTable ; $6bb8
	ld a, [hl] ; $6bbf
	inc hl ; $6bc0
	inc hl ; $6bc1
	ld b, [hl] ; $6bc2
	ld a, a ; $6bc3
	ld [wBriefingPlayerX], a ; $6bc4
	ld a, b ; $6bc7
	ld [wBriefingPlayerY], a ; $6bc8
	ld a, c ; $6bcb
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_OpponentPosTable ; $6bcc
	ld a, [hl] ; $6bd3
	inc hl ; $6bd4
	inc hl ; $6bd5
	ld b, [hl] ; $6bd6
	ld a, a ; $6bd7
	ld [wBriefingOpponentX], a ; $6bd8
	ld a, b ; $6bdb
	ld [wBriefingOpponentY], a ; $6bdc
	ld a, c ; $6bdf
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_BracketPosTable ; $6be0
	ld a, [hl] ; $6be7
	inc hl ; $6be8
	inc hl ; $6be9
	ld b, [hl] ; $6bea
	ld a, a ; $6beb
	ld [wBriefingBracketX], a ; $6bec
	ld a, b ; $6bef
	ld [wBriefingBracketY], a ; $6bf0
	ld a, c ; $6bf3
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_BallPosTable ; $6bf4
	ld a, [hl] ; $6bfb
	inc hl ; $6bfc
	inc hl ; $6bfd
	ld b, [hl] ; $6bfe
	ld a, a ; $6bff
	ld [wBriefingBallX], a ; $6c00
	ld a, b ; $6c03
	ld [wBriefingBallY], a ; $6c04
	ld a, [wBriefingAnimStep] ; $6c07
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6c0a
	ld a, [hl] ; $6c11
	ld [wBriefingHMarkerUnflipped], a ; $6c12
	ld a, c ; $6c15
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_HMarkerPosTable ; $6c16
	ld a, [hl] ; $6c1d
	inc hl ; $6c1e
	inc hl ; $6c1f
	ld b, [hl] ; $6c20
	ld a, a ; $6c21
	ld [wBriefingHMarkerX], a ; $6c22
	ld a, b ; $6c25
	ld [wBriefingHMarkerY], a ; $6c26
	ld a, [wBriefingAnimStep] ; $6c29
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable ; $6c2c
	ld a, [hl] ; $6c33
	ld [wBriefingRotMarkerDir], a ; $6c34
	ld a, c ; $6c37
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable ; $6c38
	ld a, [hl] ; $6c3f
	inc hl ; $6c40
	inc hl ; $6c41
	ld b, [hl] ; $6c42
	ld a, a ; $6c43
	ld [wBriefingRotMarkerX], a ; $6c44
	ld a, b ; $6c47
	ld [wBriefingRotMarkerY], a ; $6c48
	ld a, [wBriefingAnimStep] ; $6c4b
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_SwingFrameTable ; $6c4e
	ld a, [hl] ; $6c55
	ld [wBriefingSwingFrame], a ; $6c56
	ld a, c ; $6c59
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_SwingPosTable ; $6c5a
	ld a, [hl] ; $6c61
	inc hl ; $6c62
	inc hl ; $6c63
	ld b, [hl] ; $6c64
	ld a, a ; $6c65
	ld [wBriefingSwingX], a ; $6c66
	ld a, b ; $6c69
	ld [wBriefingSwingY], a ; $6c6a
	ret ; $6c6d
ReturnLobBriefing_AdvanceAnimTable:
	; $6c6e, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnLobBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6c7e, 16 bytes
ReturnLobBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_BallPosTable.asm" ; $6c8e, 16 bytes
ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6c9e, 4 bytes
ReturnLobBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6ca2, 16 bytes
ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $6cb2, 4 bytes
ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $6cb6, 16 bytes
ReturnLobBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_BracketPosTable.bin" ; $6cc6, 16 bytes
ReturnLobBriefing_AdvanceAnim_SwingFrameTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_SwingFrameTable.bin" ; $6cd6, 4 bytes
ReturnLobBriefing_AdvanceAnim_SwingPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_SwingPosTable.asm" ; $6cda, 16 bytes
DrillBriefing_ReturnDownLine:
	ld a, $55 ; $6cea
	ld [wBriefingPlayerX], a ; $6cec
	ld a, $44 ; $6cef
	ld [wBriefingPlayerY], a ; $6cf1
	ld a, $01 ; $6cf4
	ld hl, DrawBriefingPlayerSprite ; $6cf6
	call RegisterFrameTask ; $6cf9
	ld a, $3a ; $6cfc
	ld [wBriefingOpponentX], a ; $6cfe
	ld a, $03 ; $6d01
	ld [wBriefingOpponentY], a ; $6d03
	ld a, $01 ; $6d06
	ld hl, DrawBriefingOpponentSprite ; $6d08
	call RegisterFrameTask ; $6d0b
	ld a, $54 ; $6d0e
	ld [wBriefingBallX], a ; $6d10
	ld a, $28 ; $6d13
	ld [wBriefingBallY], a ; $6d15
	ld a, $01 ; $6d18
	ld hl, DrawBriefingBallSprite ; $6d1a
	call RegisterFrameTask ; $6d1d
	ld a, $01 ; $6d20
	ld [wBriefingRotMarkerDir], a ; $6d22
	ld a, $4c ; $6d25
	ld [wBriefingRotMarkerX], a ; $6d27
	ld a, $16 ; $6d2a
	ld [wBriefingRotMarkerY], a ; $6d2c
	ld a, $01 ; $6d2f
	ld hl, DrawBriefingMarkerRotated ; $6d31
	call RegisterFrameTask ; $6d34
	ld hl, Text_37_9 ; $6d37
	call DrawBriefingCaption ; $6d3a
	call WaitForInputBlinking ; $6d3d
	call ClearFrameTasks ; $6d40
	ld a, $01 ; $6d43
	ld hl, UpdateAnimatedTilesTask_17 ; $6d45
	call RegisterFrameTask ; $6d48
	ld a, $03 ; $6d4b
	ld [wBriefingAnimStep], a ; $6d4d
	call ReturnDownLineBriefing_AdvanceAnim ; $6d50
	ld a, $01 ; $6d53
	ld hl, DrawBriefingPlayerSprite ; $6d55
	call RegisterFrameTask ; $6d58
	ld a, $01 ; $6d5b
	ld hl, DrawBriefingOpponentSprite ; $6d5d
	call RegisterFrameTask ; $6d60
	ld a, $01 ; $6d63
	ld hl, DrawBriefingBallSprite ; $6d65
	call RegisterFrameTask ; $6d68
	ld a, $01 ; $6d6b
	ld hl, DrawBriefingMarkerHFlip ; $6d6d
	call RegisterFrameTask ; $6d70
	ld a, $01 ; $6d73
	ld hl, DrawBriefingMarkerVFlip ; $6d75
	call RegisterFrameTask ; $6d78
	ld a, $00 ; $6d7b
	ld [wBriefingBracketWidth], a ; $6d7d
	ld a, $09 ; $6d80
	ld [wBriefingBracketHeight], a ; $6d82
	ld a, $01 ; $6d85
	ld hl, DrawBriefingTargetBrackets ; $6d87
	call RegisterFrameTask ; $6d8a
	ld hl, Text_37_10 ; $6d8d
	call DrawBriefingCaption ; $6d90
	call WaitForInputBlinking ; $6d93
	call ClearFrameTasks ; $6d96
	ld a, $01 ; $6d99
	ld hl, UpdateAnimatedTilesTask_17 ; $6d9b
	call RegisterFrameTask ; $6d9e
	ld a, $03 ; $6da1
	ld [wBriefingAnimStep], a ; $6da3
	call ReturnDownLineBriefing_AdvanceAnim ; $6da6
	ld a, $01 ; $6da9
	ld hl, DrawBriefingPlayerSprite ; $6dab
	call RegisterFrameTask ; $6dae
	ld a, $01 ; $6db1
	ld hl, DrawBriefingOpponentSprite ; $6db3
	call RegisterFrameTask ; $6db6
	ld a, $01 ; $6db9
	ld hl, DrawBriefingBallSprite ; $6dbb
	call RegisterFrameTask ; $6dbe
	ld a, $01 ; $6dc1
	ld hl, DrawBriefingMarkerHFlip ; $6dc3
	call RegisterFrameTask ; $6dc6
	ld a, $01 ; $6dc9
	ld hl, DrawBriefingMarkerVFlip ; $6dcb
	call RegisterFrameTask ; $6dce
	ld a, $00 ; $6dd1
	ld [wBriefingBracketWidth], a ; $6dd3
	ld a, $09 ; $6dd6
	ld [wBriefingBracketHeight], a ; $6dd8
	ld a, $01 ; $6ddb
	ld hl, DrawBriefingTargetBrackets ; $6ddd
	call RegisterFrameTask ; $6de0
	ld hl, Text_37_11 ; $6de3
	call DrawBriefingCaption ; $6de6
	xor a ; $6de9
	ld [wBriefingAnimTimer], a ; $6dea
	ld [wBriefingAnimStep], a ; $6ded
.loop:
	call ReturnDownLineBriefing_TickAnim ; $6df0
	ld c, $01 ; $6df3
	call AdvanceFrameCheckInput ; $6df5
	and a ; $6df8
	jp z, .loop ; $6df9
	call ClearFrameTasks ; $6dfc
	ret ; $6dff
