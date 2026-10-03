DrawSpinServeBriefingMarker:
	push_wram_bank WRAM_SCREEN ; $4843
	ld c, $64 ; $484c
	ld b, $09 ; $484e
	ld a, [wBriefingSpinMarkerUnflipped] ; $4850
	cp $01 ; $4853
	jr z, .eq01 ; $4855
	ld b, OAM_BANK1 | OAM_XFLIP | 1 ; $4857
.eq01:
	ld a, [wBriefingSpinMarkerX] ; $4859
	ld d, a ; $485c
	ld a, [wBriefingSpinMarkerY] ; $485d
	ld e, a ; $4860
	ld hl, DrawSpinServeBriefingMarker_SpriteTemplate ; $4861
	call QueueSpriteTemplate ; $4864
	pop_wram_bank ; $4867
	ret ; $486c
DrawSpinServeBriefingMarker_SpriteTemplate:
	; $486d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingMarkerRotated:
	push_wram_bank WRAM_SCREEN ; $4876
	ld hl, BriefingMarkerRotatedTable ; $487f
	ld a, [wBriefingRotMarkerDir] ; $4882
	add l ; $4885
	ld l, a ; $4886
	jr nc, .read ; $4887
	inc h ; $4889
.read:
	ld b, [hl] ; $488a
	ld c, $68 ; $488b
	ld a, [wBriefingRotMarkerX] ; $488d
	ld d, a ; $4890
	ld a, [wBriefingRotMarkerY] ; $4891
	ld e, a ; $4894
	call QueueSprite ; $4895
	pop_wram_bank ; $4898
	ret ; $489d
BriefingMarkerRotatedTable:
	; $489e, 4 bytes (bytes:4)
	db $49, $09, $29, $69 ; 0x00
DrawBlinkingPrompt:
	push_wram_bank WRAM_SCREEN ; $48a2
	ldh a, [hVBlankCounter] ; $48ab
	and $10 ; $48ad
	jr z, .restore ; $48af
	ld c, $72 ; $48b1
	ld b, OAM_BANK1 | 1 ; $48b3
	ld_xy de, $50, $8c ; $48b5
	call QueueSprite ; $48b8
.restore:
	pop_wram_bank ; $48bb
	ret ; $48c0
DrawBriefingTargetBrackets:
	push_wram_bank WRAM_SCREEN ; $48c1
	ld a, [wBriefingBracketX] ; $48ca
	ld d, a ; $48cd
	ldh a, [hVBlankCounter] ; $48ce
	and $10 ; $48d0
	jr z, .maskClear ; $48d2
	inc d ; $48d4
.maskClear:
	ld a, [wBriefingBracketY] ; $48d5
	ld e, a ; $48d8
	ldh a, [hVBlankCounter] ; $48d9
	and $10 ; $48db
	jr z, .maskClear2 ; $48dd
	inc e ; $48df
.maskClear2:
	ld c, $6c ; $48e0
	ld b, OAM_BANK1 | 2 ; $48e2
	call QueueSprite ; $48e4
	ld a, [wBriefingBracketWidth] ; $48e7
	add $03 ; $48ea
	ld b, a ; $48ec
	ld a, [wBriefingBracketX] ; $48ed
	add b ; $48f0
	ld d, a ; $48f1
	ldh a, [hVBlankCounter] ; $48f2
	and $10 ; $48f4
	jr z, .maskClear3 ; $48f6
	dec d ; $48f8
.maskClear3:
	ld a, [wBriefingBracketY] ; $48f9
	ld e, a ; $48fc
	ldh a, [hVBlankCounter] ; $48fd
	and $10 ; $48ff
	jr z, .maskClear4 ; $4901
	inc e ; $4903
.maskClear4:
	ld c, $6c ; $4904
	ld b, OAM_BANK1 | OAM_XFLIP | 2 ; $4906
	call QueueSprite ; $4908
	ld a, [wBriefingBracketWidth] ; $490b
	add $03 ; $490e
	ld b, a ; $4910
	ld a, [wBriefingBracketX] ; $4911
	add b ; $4914
	ld d, a ; $4915
	ldh a, [hVBlankCounter] ; $4916
	and $10 ; $4918
	jr z, .maskClear5 ; $491a
	dec d ; $491c
.maskClear5:
	ld a, [wBriefingBracketHeight] ; $491d
	sub $05 ; $4920
	ld b, a ; $4922
	ld a, [wBriefingBracketY] ; $4923
	add b ; $4926
	ld e, a ; $4927
	ldh a, [hVBlankCounter] ; $4928
	and $10 ; $492a
	jr z, .maskClear6 ; $492c
	dec e ; $492e
.maskClear6:
	ld c, $6c ; $492f
	ld b, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP | 2 ; $4931
	call QueueSprite ; $4933
	ld a, [wBriefingBracketX] ; $4936
	ld d, a ; $4939
	ldh a, [hVBlankCounter] ; $493a
	and $10 ; $493c
	jr z, .maskClear7 ; $493e
	inc d ; $4940
.maskClear7:
	ld a, [wBriefingBracketHeight] ; $4941
	sub $05 ; $4944
	ld b, a ; $4946
	ld a, [wBriefingBracketY] ; $4947
	add b ; $494a
	ld e, a ; $494b
	ldh a, [hVBlankCounter] ; $494c
	and $10 ; $494e
	jr z, .maskClear8 ; $4950
	dec e ; $4952
.maskClear8:
	ld c, $6c ; $4953
	ld b, OAM_BANK1 | OAM_YFLIP | 2 ; $4955
	call QueueSprite ; $4957
	pop_wram_bank ; $495a
	ret ; $495f
LoadCourtDiagramScreen:
	ld c, SCREENASSET_CourtDiagram ; $4960
	farcall LoadScreenAssetRecord ; $4962
	call InitCourtDiagramTextWindow ; $4965
	wram_bank WRAM_SCREEN ; $4968
	call DecompressGraphicsList ; $496e
	call LoadCourtDiagramObjPalettes ; $4971
	farcall QueueWram3MapToVRAM ; $4974
	wram_bank WRAM_SCREEN ; $4977
	ret ; $497d
WaitForInputBlinking:
	call AdvanceFrame ; $497e
	ldh a, [hInputRisingEdge] ; $4981
	and PADF_A | PADF_B ; $4983
	jr nz, .done ; $4985
	call DrawBlinkingPrompt ; $4987
	jr WaitForInputBlinking ; $498a
.done:
	ret ; $498c
AdvanceFrameCheckInput:
	call AdvanceFrame ; $498d
	ldh a, [hInputRisingEdge] ; $4990
	and PADF_A | PADF_B ; $4992
	jr nz, .done ; $4994
	dec c ; $4996
	jr z, .noPrompt ; $4997
	call DrawBlinkingPrompt ; $4999
.noPrompt:
	ld a, $00 ; $499c
.done:
	ret ; $499e
InitCourtDiagramTextWindow:
	farcall ResetTextWindowState ; $499f
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $49a2
	ld c, SharedMenuGfx17_SIZE / 16 ; $49a4
	ld de, vTiles2 ; $49a6
	farcall LoadCompressedTileBlock ; $49a9
	wram_bank WRAM_TEXT ; $49ac
	ld a, $03 ; $49b2
	ld [wShadowTilemapBank], a ; $49b4
	ld a, $00 ; $49b7
	ld [wWindowTileAttr], a ; $49b9
	ld d, $00 ; $49bc
	ld e, $0b ; $49be
	ld b, $14 ; $49c0
	ld c, $07 ; $49c2
	farcall CreateWindowFromScreenRect ; $49c4
	farcall DrawTextWindowFrame ; $49c7
	farcall RedrawWindowRows ; $49ca
	ret ; $49cd
ClearBriefingCaptionTilemap:
	push af ; $49ce
	push bc ; $49cf
	push de ; $49d0
	push hl ; $49d1
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH ; $49d2
	ld b, $14 ; $49d5
	ld c, $01 ; $49d7
	ld h, $03 ; $49d9
	farcall FillTilemapRect ; $49db
	ld a, $02 ; $49de
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH], a ; $49e0
	ld a, $04 ; $49e3
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH + 19], a ; $49e5
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $49e8
	ld b, $12 ; $49eb
	ld c, $05 ; $49ed
	ld h, $20 ; $49ef
	farcall FillTilemapRect ; $49f1
	pop hl ; $49f4
	pop de ; $49f5
	pop bc ; $49f6
	pop af ; $49f7
	ret ; $49f8
QueueCaptionRowToVRAM:
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH ; $49f9
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH ; $49fc
	ld c, 6 * TILEMAP_WIDTH / 16 ; $49ff
	call QueueVRAMCopy ; $4a01
	ret ; $4a04
Unused_17_StubRet:
	ret ; $4a05
Unused_17_DrawSecondCaptionRow:
	ld hl, Text_30_309 ; $4a06
	ld de, $d1c1 ; $4a09
	farcall RenderProportionalTextAt ; $4a0c
	ld hl, $d1a0 ; $4a0f
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $4a12
	ld c, $0c ; $4a15
	call QueueVRAMCopy ; $4a17
	ret ; $4a1a
; Queues the two-sprite template at $4a29 through QueueSpriteTemplate at
; screen position de = $2020, with c = $04 (tile base) and b = $09
; (flags; bit 5 would mirror it).
;
; No proven caller, so what it draws is not established -- it sits
; between QueueCaptionRowToVRAM and RestoreDiagramServiceBoxes in the
; court-diagram code. Named for what it does, not what it is for.
Unused_17_QueueSpritePair:
	ld c, $04 ; $4a1b
	ld b, OAM_BANK1 | 1 ; $4a1d
	ld hl, QueueSpritePair_17_SpriteTemplate ; $4a1f
	ld_xy de, $20, $20 ; $4a22
	call QueueSpriteTemplate ; $4a25
	ret ; $4a28
QueueSpritePair_17_SpriteTemplate:
	; $4a29, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
RestoreDiagramServiceBoxes:
	push af ; $4a32
	push bc ; $4a33
	push de ; $4a34
	push hl ; $4a35
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 6 ; $4a36
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 7 ; $4a39
	ld c, $06 ; $4a3c
	ld b, $06 ; $4a3e
	farcall CopyTilemapRect ; $4a40
	pop hl ; $4a43
	pop de ; $4a44
	pop bc ; $4a45
	pop af ; $4a46
	ret ; $4a47
QueueDiagramServiceBoxesToVRAM:
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $4a48
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $4a4b
	ld c, 6 * TILEMAP_WIDTH / 16 ; $4a4e
	call QueueVRAMCopy ; $4a50
	ret ; $4a53
DrawDiagramTargetPatch:
	ld a, b ; $4a54
	or a ; $4a55
	ret z ; $4a56
	dec a ; $4a57
	add a ; $4a58
	ld c, a ; $4a59
	add a ; $4a5a
	add c ; $4a5b
	ld hl, DiagramTargetPatchRecords_17 ; $4a5c
	add l ; $4a5f
	ld l, a ; $4a60
	jr nc, .read ; $4a61
	inc h ; $4a63
.read:
	ld a, [hl+] ; $4a64
	ld b, [hl] ; $4a65
	ld c, a ; $4a66
	inc hl ; $4a67
	ld a, [hl+] ; $4a68
	ld d, [hl] ; $4a69
	ld e, a ; $4a6a
	inc hl ; $4a6b
	push bc ; $4a6c
	ld b, [hl] ; $4a6d
	inc hl ; $4a6e
	ld c, [hl] ; $4a6f
	pop hl ; $4a70
	farcall CopyTilemapRect ; $4a71
	ret ; $4a74
DiagramTargetPatchRecords_17:
	; $4a75, 36 bytes (records:6)
; 6 records x 6 bytes
	dw $d243, $d08a, $0203 ; record 0
	dw $d283, $d0ca, $0203 ; record 1
	dw $d280, $d0c7, $0203 ; record 2
	dw $d240, $d087, $0203 ; record 3
	dw $d2c0, $d067, $0206 ; record 4
	dw $d300, $d0e7, $0206 ; record 5
DecompressGraphicsList:
	ld hl, CourtDiagramGraphicsList ; $4a99
.loop:
	ld a, [hl+] ; $4a9c
	ld b, [hl] ; $4a9d
	dec hl ; $4a9e
	or b ; $4a9f
	jr z, .done ; $4aa0
	push hl ; $4aa2
	push hl ; $4aa3
	inc hl ; $4aa4
	inc hl ; $4aa5
	ld a, [hl+] ; $4aa6
	ld d, [hl] ; $4aa7
	ld e, a ; $4aa8
	pop hl ; $4aa9
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	call DecompressData ; $4aad
	pop hl ; $4ab0
	ld a, $04 ; $4ab1
	add l ; $4ab3
	ld l, a ; $4ab4
	jr nc, .gotPtr ; $4ab5
	inc h ; $4ab7
.gotPtr:
	jr .loop ; $4ab8
.done:
	ret ; $4aba
CourtDiagramGraphicsList:
	; $4abb, 82 bytes (bytes:4)
	db $02, $4f, $00, $80 ; 0x00
	db $3d, $4f, $40, $80 ; 0x04
	db $7c, $4f, $80, $80 ; 0x08
	db $0b, $50, $20, $81 ; 0x0c
	db $9a, $50, $c0, $81 ; 0x10
	db $2d, $51, $60, $82 ; 0x14
	db $8f, $51, $c0, $82 ; 0x18
	db $f1, $51, $60, $83 ; 0x1c
	db $80, $52, $00, $84 ; 0x20
	db $0f, $53, $a0, $84 ; 0x24
	db $a0, $53, $40, $85 ; 0x28
	db $09, $54, $a0, $85 ; 0x2c
	db $6d, $54, $00, $86 ; 0x30
	db $b7, $54, $40, $86 ; 0x34
	db $d8, $54, $80, $86 ; 0x38
	db $ff, $54, $a0, $86 ; 0x3c
	db $11, $55, $c0, $86 ; 0x40
	db $23, $55, $e0, $86 ; 0x44
	db $36, $55, $00, $87 ; 0x48
	db $4e, $55, $20, $87 ; 0x4c
	db $00, $00 ; 0x50
LoadCourtDiagramObjPalettes:
	ld hl, CourtDiagramObjPalettes ; $4b0d
	ld_obj_pals de, 0, 3 ; $4b10
	call LoadPaletteShadow ; $4b13
	ret ; $4b16
CourtDiagramTiles:
	INCBIN "data/bank_017/lz_CourtDiagramTiles.bin" ; $4b17, 590 bytes
CourtDiagramTilemap:
	INCBIN "data/bank_017/lz_CourtDiagramTilemap.bin" ; $4d65, 221 bytes
CourtDiagramAttrmap:
	INCBIN "data/bank_017/lz_CourtDiagramAttrmap.bin" ; $4e42, 128 bytes
CourtDiagramPalettes:
	INCLUDE "data/bank_017/CourtDiagramPalettes.asm" ; $4ec2, 16 bytes (palettes)
CycleDiagramTargetPaletteData:
	INCLUDE "data/bank_017/CycleDiagramTargetPaletteData.asm" ; $4ed2, 48 bytes (palettes)
CourtDiagramGfx0:
	INCBIN "data/bank_017/CourtDiagramGfx0.bin" ; $4f02, 59 bytes
CourtDiagramGfx1:
	INCBIN "data/bank_017/CourtDiagramGfx1.bin" ; $4f3d, 63 bytes
CourtDiagramGfx2:
	INCBIN "data/bank_017/CourtDiagramGfx2.bin" ; $4f7c, 143 bytes
CourtDiagramGfx3:
	INCBIN "data/bank_017/CourtDiagramGfx3.bin" ; $500b, 143 bytes
CourtDiagramGfx4:
	INCBIN "data/bank_017/CourtDiagramGfx4.bin" ; $509a, 147 bytes
CourtDiagramGfx5:
	INCBIN "data/bank_017/CourtDiagramGfx5.bin" ; $512d, 98 bytes
CourtDiagramGfx6:
	INCBIN "data/bank_017/CourtDiagramGfx6.bin" ; $518f, 98 bytes
CourtDiagramGfx7:
	INCBIN "data/bank_017/CourtDiagramGfx7.bin" ; $51f1, 143 bytes
CourtDiagramGfx8:
	INCBIN "data/bank_017/CourtDiagramGfx8.bin" ; $5280, 143 bytes
CourtDiagramGfx9:
	INCBIN "data/bank_017/CourtDiagramGfx9.bin" ; $530f, 145 bytes
CourtDiagramGfx10:
	INCBIN "data/bank_017/CourtDiagramGfx10.bin" ; $53a0, 105 bytes
CourtDiagramGfx11:
	INCBIN "data/bank_017/CourtDiagramGfx11.bin" ; $5409, 100 bytes
CourtDiagramGfx12:
	INCBIN "data/bank_017/CourtDiagramGfx12.bin" ; $546d, 74 bytes
CourtDiagramGfx13:
	INCBIN "data/bank_017/lz_CourtDiagramGfx13.bin" ; $54b7, 33 bytes
CourtDiagramGfx14:
	INCBIN "data/bank_017/CourtDiagramGfx14.bin" ; $54d8, 39 bytes
CourtDiagramGfx15:
	INCBIN "data/bank_017/CourtDiagramGfx15.bin" ; $54ff, 18 bytes
CourtDiagramGfx16:
	INCBIN "data/bank_017/CourtDiagramGfx16.bin" ; $5511, 18 bytes
CourtDiagramGfx17:
	INCBIN "data/bank_017/CourtDiagramGfx17.bin" ; $5523, 19 bytes
CourtDiagramGfx18:
	INCBIN "data/bank_017/CourtDiagramGfx18.bin" ; $5536, 24 bytes
CourtDiagramGfx19:
	INCBIN "data/bank_017/CourtDiagramGfx19.bin" ; $554e, 25 bytes
CourtDiagramObjPalettes:
	INCLUDE "data/bank_017/CourtDiagramObjPalettes.asm" ; $5567, 24 bytes (palettes)
DrillBriefing_ServeToTargets:
	ld a, $03 ; $557f
	ld [wBriefingAnimStep], a ; $5581
	call ServeToTargetsBriefing_AdvanceAnim ; $5584
	ld a, $01 ; $5587
	ld hl, DrawBriefingPlayerSprite ; $5589
	call RegisterFrameTask ; $558c
	ld a, $01 ; $558f
	ld hl, DrawBriefingBallSprite ; $5591
	call RegisterFrameTask ; $5594
	ld a, $01 ; $5597
	ld hl, DrawBriefingMarkerHFlip ; $5599
	call RegisterFrameTask ; $559c
	ld a, $01 ; $559f
	ld hl, DrawBriefingMarkerRotated ; $55a1
	call RegisterFrameTask ; $55a4
	ld a, $01 ; $55a7
	ld hl, CycleDiagramTargetPalette ; $55a9
	call RegisterFrameTask ; $55ac
	ld hl, Text_36_688 ; $55af
	call DrawBriefingCaption ; $55b2
	xor a ; $55b5
	ld [wBriefingAnimTimer], a ; $55b6
	ld [wBriefingAnimStep], a ; $55b9
.loop:
	call ServeToTargetsBriefing_TickAnim ; $55bc
	ld c, $00 ; $55bf
	call AdvanceFrameCheckInput ; $55c1
	and a ; $55c4
	jp z, .loop ; $55c5
	call ClearFrameTasks ; $55c8
	ld a, $01 ; $55cb
	ld hl, UpdateAnimatedTilesTask_17 ; $55cd
	call RegisterFrameTask ; $55d0
	ld a, $03 ; $55d3
	ld [wBriefingAnimStep], a ; $55d5
	call ServeToTargetsBriefing_AdvanceAnim ; $55d8
	ld a, $01 ; $55db
	ld hl, DrawBriefingPlayerSprite ; $55dd
	call RegisterFrameTask ; $55e0
	ld a, $01 ; $55e3
	ld hl, DrawBriefingMarkerHFlip ; $55e5
	call RegisterFrameTask ; $55e8
	ld a, $01 ; $55eb
	ld hl, CycleDiagramTargetPalette ; $55ed
	call RegisterFrameTask ; $55f0
	ld a, $00 ; $55f3
	ld [wBriefingBracketWidth], a ; $55f5
	ld a, $00 ; $55f8
	ld [wBriefingBracketHeight], a ; $55fa
	ld a, $01 ; $55fd
	ld hl, DrawBriefingTargetBrackets ; $55ff
	call RegisterFrameTask ; $5602
	ld hl, Text_36_689 ; $5605
	call DrawBriefingCaption ; $5608
	xor a ; $560b
	ld [wBriefingAnimTimer], a ; $560c
	ld [wBriefingAnimStep], a ; $560f
.loopB:
	call ServeToTargetsBriefing_TickAnim ; $5612
	ld c, $00 ; $5615
	call AdvanceFrameCheckInput ; $5617
	and a ; $561a
	jp z, .loopB ; $561b
	call ClearFrameTasks ; $561e
	ld a, $01 ; $5621
	ld hl, UpdateAnimatedTilesTask_17 ; $5623
	call RegisterFrameTask ; $5626
	ld a, $54 ; $5629
	ld [wBriefingPlayerX], a ; $562b
	ld a, $44 ; $562e
	ld [wBriefingPlayerY], a ; $5630
	ld a, $01 ; $5633
	ld hl, DrawBriefingPlayerSprite ; $5635
	call RegisterFrameTask ; $5638
	ld a, $4e ; $563b
	ld [wBriefingBallX], a ; $563d
	ld a, $38 ; $5640
	ld [wBriefingBallY], a ; $5642
	ld a, $01 ; $5645
	ld hl, DrawBriefingBallSprite ; $5647
	call RegisterFrameTask ; $564a
	ld a, $00 ; $564d
	ld [wBriefingHMarkerUnflipped], a ; $564f
	ld a, $3a ; $5652
	ld [wBriefingHMarkerX], a ; $5654
	ld a, $24 ; $5657
	ld [wBriefingHMarkerY], a ; $5659
	ld a, $01 ; $565c
	ld hl, DrawBriefingMarkerHFlip ; $565e
	call RegisterFrameTask ; $5661
	ld a, $03 ; $5664
	ld [wBriefingRotMarkerDir], a ; $5666
	ld a, $52 ; $5669
	ld [wBriefingRotMarkerX], a ; $566b
	ld a, $40 ; $566e
	ld [wBriefingRotMarkerY], a ; $5670
	ld a, $01 ; $5673
	ld hl, DrawBriefingMarkerRotated ; $5675
	call RegisterFrameTask ; $5678
	ld b, $04 ; $567b
	call DrawDiagramTargetOverlay ; $567d
	ld a, $01 ; $5680
	ld hl, CycleDiagramTargetPalette ; $5682
	call RegisterFrameTask ; $5685
	ld a, $00 ; $5688
	ld [wBriefingBracketWidth], a ; $568a
	ld a, $00 ; $568d
	ld [wBriefingBracketHeight], a ; $568f
	ld a, $40 ; $5692
	ld [wBriefingBracketX], a ; $5694
	ld a, $24 ; $5697
	ld [wBriefingBracketY], a ; $5699
	ld a, $01 ; $569c
	ld hl, DrawBriefingTargetBrackets ; $569e
	call RegisterFrameTask ; $56a1
	ld hl, Text_36_690 ; $56a4
	call DrawBriefingCaption ; $56a7
	call WaitForInputBlinking ; $56aa
	call ClearFrameTasks ; $56ad
	ld a, $01 ; $56b0
	ld hl, UpdateAnimatedTilesTask_17 ; $56b2
	call RegisterFrameTask ; $56b5
	ld a, $03 ; $56b8
	ld [wBriefingAnimStep], a ; $56ba
	call ServeToTargetsBriefing_AdvanceAnim ; $56bd
	ld a, $01 ; $56c0
	ld hl, DrawBriefingPlayerSprite ; $56c2
	call RegisterFrameTask ; $56c5
	ld a, $01 ; $56c8
	ld hl, DrawBriefingBallSprite ; $56ca
	call RegisterFrameTask ; $56cd
	ld a, $01 ; $56d0
	ld hl, DrawBriefingMarkerRotated ; $56d2
	call RegisterFrameTask ; $56d5
	ld a, $01 ; $56d8
	ld hl, CycleDiagramTargetPalette ; $56da
	call RegisterFrameTask ; $56dd
	ld a, $00 ; $56e0
	ld [wBriefingBracketWidth], a ; $56e2
	ld a, $00 ; $56e5
	ld [wBriefingBracketHeight], a ; $56e7
	ld a, $01 ; $56ea
	ld hl, DrawBriefingTargetBrackets ; $56ec
	call RegisterFrameTask ; $56ef
	ld hl, Text_36_691 ; $56f2
	call DrawBriefingCaption ; $56f5
	xor a ; $56f8
	ld [wBriefingAnimTimer], a ; $56f9
	ld [wBriefingAnimStep], a ; $56fc
.loop2:
	call ServeToTargetsBriefing_TickAnim ; $56ff
	ld c, $01 ; $5702
	call AdvanceFrameCheckInput ; $5704
	and a ; $5707
	jp z, .loop2 ; $5708
	call ClearFrameTasks ; $570b
	ret ; $570e
