GetBehaviorMapCellAddr:
	push bc ; $5f31
	push de ; $5f32
	sra d ; $5f33
	sla d ; $5f35
	sra e ; $5f37
	sla e ; $5f39
	ld h, $00 ; $5f3b
	ld l, e ; $5f3d
	add hl, hl ; $5f3e
	add hl, hl ; $5f3f
	add hl, hl ; $5f40
	add hl, hl ; $5f41
	ld b, $00 ; $5f42
	ld c, d ; $5f44
	sra c ; $5f45
	add hl, bc ; $5f47
	ld bc, wBehaviorMap ; $5f48
	add hl, bc ; $5f4b
	pop de ; $5f4c
	pop bc ; $5f4d
	ret ; $5f4e
ReadBehaviorMapCell:
	push bc ; $5f4f
	push de ; $5f50
	push hl ; $5f51
	call GetBehaviorMapCellAddr ; $5f52
	push_wram_bank WRAM_SCENE ; $5f55
	ld b, [hl] ; $5f5e
	pop_wram_bank ; $5f5f
	ld a, b ; $5f64
	push de ; $5f65
	push af ; $5f66
	ld a, a ; $5f67
	ld de, $0e0e ; $5f68
	call PrintHexByte ; $5f6b
	pop af ; $5f6e
	pop de ; $5f6f
	pop hl ; $5f70
	pop de ; $5f71
	pop bc ; $5f72
	ret ; $5f73
WriteBehaviorMapCell:
	push af ; $5f74
	push bc ; $5f75
	push de ; $5f76
	push hl ; $5f77
	call GetBehaviorMapCellAddr ; $5f78
	ld b, a ; $5f7b
	push_wram_bank WRAM_SCENE ; $5f7c
	ld [hl], b ; $5f85
	pop_wram_bank ; $5f86
	pop hl ; $5f8b
	pop de ; $5f8c
	pop bc ; $5f8d
	pop af ; $5f8e
	ret ; $5f8f
CopyCollisionMapRect:
	push af ; $5f90
	push bc ; $5f91
	push de ; $5f92
	push hl ; $5f93
	ldh a, [hWramBank] ; $5f94
	push af ; $5f96
	sra h ; $5f97
	sra l ; $5f99
	push hl ; $5f9b
	call GetCollisionMapCellAddr ; $5f9c
	push hl ; $5f9f
	ld d, b ; $5fa0
	ld e, c ; $5fa1
	call GetCollisionMapCellAddr ; $5fa2
	pop de ; $5fa5
	pop bc ; $5fa6
	wram_bank WRAM_SCENE ; $5fa7
	ld a, c ; $5fad
	ld c, b ; $5fae
	ld b, $00 ; $5faf
.rowLoop:
	push af ; $5fb1
	push bc ; $5fb2
	push de ; $5fb3
	push hl ; $5fb4
	call CopyMemoryBC ; $5fb5
	pop hl ; $5fb8
	pop de ; $5fb9
	pop bc ; $5fba
	pop af ; $5fbb
	push bc ; $5fbc
	ld bc, $0020 ; $5fbd
	push hl ; $5fc0
	ld h, d ; $5fc1
	ld l, e ; $5fc2
	add hl, bc ; $5fc3
	ld d, h ; $5fc4
	ld e, l ; $5fc5
	pop hl ; $5fc6
	add hl, bc ; $5fc7
	pop bc ; $5fc8
	dec a ; $5fc9
	jr nz, .rowLoop ; $5fca
	pop_wram_bank ; $5fcc
	pop hl ; $5fd1
	pop de ; $5fd2
	pop bc ; $5fd3
	pop af ; $5fd4
	ret ; $5fd5
CopyBehaviorMapRect:
	push af ; $5fd6
	push bc ; $5fd7
	push de ; $5fd8
	push hl ; $5fd9
	ldh a, [hWramBank] ; $5fda
	push af ; $5fdc
	sra h ; $5fdd
	sra l ; $5fdf
	push hl ; $5fe1
	call GetBehaviorMapCellAddr ; $5fe2
	push hl ; $5fe5
	ld d, b ; $5fe6
	ld e, c ; $5fe7
	call GetBehaviorMapCellAddr ; $5fe8
	pop de ; $5feb
	pop bc ; $5fec
	wram_bank WRAM_SCENE ; $5fed
	ld a, c ; $5ff3
	ld c, b ; $5ff4
	ld b, $00 ; $5ff5
.rowLoop:
	push af ; $5ff7
	push bc ; $5ff8
	push de ; $5ff9
	push hl ; $5ffa
	call CopyMemoryBC ; $5ffb
	pop hl ; $5ffe
	pop de ; $5fff
	pop bc ; $6000
	pop af ; $6001
	push bc ; $6002
	ld bc, $0020 ; $6003
	push hl ; $6006
	ld h, d ; $6007
	ld l, e ; $6008
	add hl, bc ; $6009
	ld d, h ; $600a
	ld e, l ; $600b
	pop hl ; $600c
	add hl, bc ; $600d
	pop bc ; $600e
	dec a ; $600f
	jr nz, .rowLoop ; $6010
	pop_wram_bank ; $6012
	pop hl ; $6017
	pop de ; $6018
	pop bc ; $6019
	pop af ; $601a
	ret ; $601b
Unused_0a_InitSceneViewer:
	push af ; $601c
	push bc ; $601d
	push de ; $601e
	push hl ; $601f
	push af ; $6020
	and $7f ; $6021
	ld [wCurrentScene], a ; $6023
	xor a ; $6026
	ldh [hScrollY], a ; $6027
	ldh [hScrollX], a ; $6029
	dec a ; $602b
	ld [wUnusedPrevSceneIndex], a ; $602c
	ld hl, SceneGfxSlotTable ; $602f
	ld bc, $ffff ; $6032
.slotLoop:
	inc bc ; $6035
	ld a, [hl+] ; $6036
	ld d, a ; $6037
	ld a, [hl+] ; $6038
	or d ; $6039
	jr nz, .slotLoop ; $603a
	ld h, b ; $603c
	ld l, c ; $603d
	ld de, $0009 ; $603e
	call DivHLByDE ; $6041
	ld a, l ; $6044
	ld [wScrollListLength], a ; $6045
	pop af ; $6048
	bit 7, a ; $6049
	jr nz, .clearScroll ; $604b
	and $7f ; $604d
	ld b, $00 ; $604f
	call Unused_0a_LoadAndDisplayScene ; $6051
.clearScroll:
	xor a ; $6054
	ldh [hBGColumnBlitPending], a ; $6055
	ldh [hBGRowBlitPending], a ; $6057
	farcall InitTextWindows ; $6059
	ld a, $01 ; $605c
	ld hl, Unused_0a_StubNop ; $605e
	call RegisterFrameTask ; $6061
	ld a, [wCurrentScene] ; $6064
	call InitSceneTileAnimations ; $6067
	pop hl ; $606a
	pop de ; $606b
	pop bc ; $606c
	pop af ; $606d
	ret ; $606e
UnusedUnregisterSceneViewerFrameTask:
	ld hl, Unused_0a_StubNop ; $606f
	call UnregisterFrameTask ; $6072
	ret ; $6075
Unused_0a_InitSceneViewerDefault:
	push af ; $6076
	push bc ; $6077
	push de ; $6078
	push hl ; $6079
	xor a ; $607a
	ldh [hScrollY], a ; $607b
	ldh [hScrollX], a ; $607d
	ld hl, SceneGfxSlotTable ; $607f
	ld bc, $ffff ; $6082
.slotLoop:
	inc c ; $6085
	ld a, [hl+] ; $6086
	ld d, a ; $6087
	ld a, [hl+] ; $6088
	or d ; $6089
	jr nz, .slotLoop ; $608a
	ld h, b ; $608c
	ld l, c ; $608d
	ld de, $0009 ; $608e
	call DivHLByDE ; $6091
	ld a, l ; $6094
	ld [wScrollListLength], a ; $6095
	ld a, $00 ; $6098
	ld [wCurrentScene], a ; $609a
	ld b, $00 ; $609d
	call Unused_0a_LoadAndDisplayScene ; $609f
	farcall InitTextWindows ; $60a2
	farcall RestoreShadowTilemap ; $60a5
	ld a, [wCurrentScene] ; $60a8
	call InitSceneTileAnimations ; $60ab
	pop hl ; $60ae
	pop de ; $60af
	pop bc ; $60b0
	pop af ; $60b1
	ret ; $60b2
UnusedSceneViewerMainLoop:
	call Unused_0a_InitSceneViewerDefault ; $60b3
.clearScroll:
	call Unused_0a_UpdateSceneViewerScroll ; $60b6
	call Unused_0a_SceneViewerSelectScene ; $60b9
	call AdvanceFrame ; $60bc
	jr .clearScroll ; $60bf
Unused_0a_StubNop:
	ret ; $60c1
Unused_0a_UpdateSceneViewerScroll:
	ld a, [wCameraX + 1] ; $60c2
	push af ; $60c5
	ld a, [wCameraY + 1] ; $60c6
	push af ; $60c9
	call Unused_0a_MoveSceneViewerCamera ; $60ca
	pop hl ; $60cd
	ld a, [wCameraY + 1] ; $60ce
	cp h ; $60d1
	jr z, .checkVertical ; $60d2
	jr c, .scrollLeft ; $60d4
	ld bc, $fb13 ; $60d6
	call BlitBGRowFrom64 ; $60d9
	jr .checkVertical ; $60dc
.scrollLeft:
	ld bc, $fb00 ; $60de
	call BlitBGRowFrom64 ; $60e1
.checkVertical:
	pop hl ; $60e4
	ld a, [wCameraX + 1] ; $60e5
	cp h ; $60e8
	jr z, .store ; $60e9
	jr c, .scrollUp ; $60eb
	ld bc, $15fa ; $60ed
	call BlitBGColumnFrom64 ; $60f0
	jr .store ; $60f3
.scrollUp:
	ld bc, $00fa ; $60f5
	call BlitBGColumnFrom64 ; $60f8
.store:
	ld a, [wCameraY] ; $60fb
	ld c, a ; $60fe
	ld a, [wCameraY + 1] ; $60ff
	sla c ; $6102
	rla ; $6104
	sla c ; $6105
	rla ; $6107
	sla c ; $6108
	rla ; $610a
	ldh [hScrollY], a ; $610b
	ld a, [wCameraX] ; $610d
	ld c, a ; $6110
	ld a, [wCameraX + 1] ; $6111
	sla c ; $6114
	rla ; $6116
	sla c ; $6117
	rla ; $6119
	sla c ; $611a
	rla ; $611c
	ldh [hScrollX], a ; $611d
	ret ; $611f
DPadMoveVectors_0a:
	; $6120, 64 bytes (records:4)
; 16 records x 4 bytes
	dw $0000, $0000 ; record 0
	dw $0040, $0000 ; record 1
	dw $ffc0, $0000 ; record 2
	dw $0000, $0000 ; record 3
	dw $0000, $ffc0 ; record 4
	dw $002d, $ffd3 ; record 5
	dw $ffd3, $ffd3 ; record 6
	dw $0000, $ffc0 ; record 7
	dw $0000, $0040 ; record 8
	dw $002d, $002d ; record 9
	dw $ffd3, $002d ; record 10
	dw $0000, $0040 ; record 11
	dw $0000, $0000 ; record 12
	dw $0040, $0000 ; record 13
	dw $ffc0, $0000 ; record 14
	dw $0000, $0000 ; record 15
Unused_0a_MoveSceneViewerCamera:
	ldh a, [hPlayerInputFlags] ; $6160
	rra ; $6162
	rra ; $6163
	and $3c ; $6164
	ld hl, DPadMoveVectors_0a ; $6166
	ld d, $00 ; $6169
	ld e, a ; $616b
	add hl, de ; $616c
	ld d, h ; $616d
	ld e, l ; $616e
	ld a, [wCameraX] ; $616f
	ld l, a ; $6172
	ld a, [wCameraX + 1] ; $6173
	ld h, a ; $6176
	ld a, [de] ; $6177
	ld c, a ; $6178
	inc de ; $6179
	ld a, [de] ; $617a
	ld b, a ; $617b
	inc de ; $617c
	add hl, bc ; $617d
	ld a, l ; $617e
	ld [wCameraX], a ; $617f
	ld a, h ; $6182
	ld [wCameraX + 1], a ; $6183
	ld a, [wCameraY] ; $6186
	ld l, a ; $6189
	ld a, [wCameraY + 1] ; $618a
	ld h, a ; $618d
	ld a, [de] ; $618e
	ld c, a ; $618f
	inc de ; $6190
	ld a, [de] ; $6191
	ld b, a ; $6192
	inc de ; $6193
	add hl, bc ; $6194
	ld a, l ; $6195
	ld [wCameraY], a ; $6196
	ld a, h ; $6199
	ld [wCameraY + 1], a ; $619a
	ret ; $619d
CopySceneTilemapRect:
	push af ; $619e
	push bc ; $619f
	push de ; $61a0
	push hl ; $61a1
	ldh a, [hWramBank] ; $61a2
	push af ; $61a4
	push de ; $61a5
	push hl ; $61a6
	push hl ; $61a7
	ld h, d ; $61a8
	ld l, e ; $61a9
	call GetSceneTilemapAddr ; $61aa
	ld d, h ; $61ad
	ld e, l ; $61ae
	ld h, b ; $61af
	ld l, c ; $61b0
	call GetSceneTilemapAddr ; $61b1
	pop bc ; $61b4
	push hl ; $61b5
	push de ; $61b6
	push bc ; $61b7
	wram_bank WRAM_COURT_PLANES ; $61b8
	ld a, c ; $61be
	ld c, b ; $61bf
	ld b, $00 ; $61c0
.rowLoop:
	push af ; $61c2
	push bc ; $61c3
	push de ; $61c4
	push hl ; $61c5
	call CopyMemoryBC ; $61c6
	pop hl ; $61c9
	pop de ; $61ca
	pop bc ; $61cb
	pop af ; $61cc
	push bc ; $61cd
	ld bc, $0040 ; $61ce
	push hl ; $61d1
	ld h, d ; $61d2
	ld l, e ; $61d3
	add hl, bc ; $61d4
	ld d, h ; $61d5
	ld e, l ; $61d6
	pop hl ; $61d7
	add hl, bc ; $61d8
	pop bc ; $61d9
	dec a ; $61da
	jr nz, .rowLoop ; $61db
	pop bc ; $61dd
	pop de ; $61de
	pop hl ; $61df
	wram_bank WRAM_SCREEN ; $61e0
	ld a, c ; $61e6
	ld c, b ; $61e7
	ld b, $00 ; $61e8
.rowLoop2:
	push af ; $61ea
	push bc ; $61eb
	push de ; $61ec
	push hl ; $61ed
	call CopyMemoryBC ; $61ee
	pop hl ; $61f1
	pop de ; $61f2
	pop bc ; $61f3
	pop af ; $61f4
	push bc ; $61f5
	ld bc, $0040 ; $61f6
	push hl ; $61f9
	ld h, d ; $61fa
	ld l, e ; $61fb
	add hl, bc ; $61fc
	ld d, h ; $61fd
	ld e, l ; $61fe
	pop hl ; $61ff
	add hl, bc ; $6200
	pop bc ; $6201
	dec a ; $6202
	jr nz, .rowLoop2 ; $6203
	pop hl ; $6205
	pop de ; $6206
	wram_bank WRAM_TEXT ; $6207
	farcall RestoreShadowTilemap ; $620d
	ld d, e ; $6210
	ld e, l ; $6211
	farcall RedrawTilemapRowRange ; $6212
	pop_wram_bank ; $6215
	pop hl ; $621a
	pop de ; $621b
	pop bc ; $621c
	pop af ; $621d
	ret ; $621e
GetSceneTilemapAddr:
	push bc ; $621f
	ld c, $00 ; $6220
	ld b, l ; $6222
	sra b ; $6223
	rr c ; $6225
	sra b ; $6227
	rr c ; $6229
	ld l, h ; $622b
	ld h, $00 ; $622c
	add hl, bc ; $622e
	ld bc, wMapBuffer64 ; $622f
	add hl, bc ; $6232
	pop bc ; $6233
	ret ; $6234
