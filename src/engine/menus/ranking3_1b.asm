HighlightDoublesRankingRows:
	ld a, [wRankingBoardPlayerRow] ; $5829
	or a ; $582c
	ret z ; $582d
	cp $01 ; $582e
	ret z ; $5830
	cp $02 ; $5831
	jr nz, .ne02 ; $5833
	ld b, $01 ; $5835
	call HighlightDoublesRankingRow ; $5837
	ld b, $02 ; $583a
	call HighlightDoublesRankingRow ; $583c
	ret ; $583f
.ne02:
	ld b, $05 ; $5840
	call HighlightDoublesRankingRow ; $5842
	ret ; $5845
HighlightDoublesRankingRow:
	ld a, b ; $5846
	or a ; $5847
	ret z ; $5848
	add a ; $5849
	ld hl, RankingMarkerHandlers_1b ; $584a
	add l ; $584d
	ld l, a ; $584e
	jr nc, .jumpToHandler ; $584f
	inc h ; $5851
.jumpToHandler:
	ld a, [hl+] ; $5852
	ld h, [hl] ; $5853
	ld l, a ; $5854
	jp hl ; $5855
StubNop_1b_08:
	ret ; $5856
RankingMarkerHandlers_1b:
	dw DrawDoublesRankingMarker0 ; $5857 jumptable
	dw DrawDoublesRankingMarker0 ; $5859 jumptable
	dw DrawDoublesRankingMarker2 ; $585b jumptable
	dw DrawDoublesRankingMarker3 ; $585d jumptable
	dw DrawDoublesRankingMarker4 ; $585f jumptable
	dw DrawDoublesRankingMarker5 ; $5861 jumptable
	dw DrawDoublesRankingMarker6 ; $5863 jumptable
DrawDoublesRankingMarker0:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $5865
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 6 ; $5868
	ld b, $04 ; $586b
	ld c, $04 ; $586d
	farcall CopyTilemapRect ; $586f
	jp StubNop_1b_08 ; $5872
DrawDoublesRankingMarker2:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 4 ; $5875
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 10 ; $5878
	ld b, $04 ; $587b
	ld c, $04 ; $587d
	farcall CopyTilemapRect ; $587f
	jp StubNop_1b_08 ; $5882
DrawDoublesRankingMarker3:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 8 ; $5885
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 6 ; $5888
	ld b, $04 ; $588b
	ld c, $07 ; $588d
	farcall CopyTilemapRect ; $588f
	jp StubNop_1b_08 ; $5892
DrawDoublesRankingMarker4:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 12 ; $5895
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 10 ; $5898
	ld b, $04 ; $589b
	ld c, $07 ; $589d
	farcall CopyTilemapRect ; $589f
	jp StubNop_1b_08 ; $58a2
DrawDoublesRankingMarker5:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 8 ; $58a5
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 6 ; $58a8
	ld b, $08 ; $58ab
	ld c, $07 ; $58ad
	farcall CopyTilemapRect ; $58af
	jp StubNop_1b_08 ; $58b2
DrawDoublesRankingMarker6:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 16 ; $58b5
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 6 ; $58b8
	ld b, $08 ; $58bb
	ld c, $07 ; $58bd
	farcall CopyTilemapRect ; $58bf
	jp StubNop_1b_08 ; $58c2
PushRankingBoardTilemapRows:
	ld hl, wShadowTilemap ; $58c5
	ld de, vBGMap0 ; $58c8
	ld c, 8 * TILEMAP_WIDTH / 16 ; $58cb
	call QueueVRAMCopy ; $58cd
	ld hl, wShadowAttrmap ; $58d0
	ld de, vBGMap0 + VRAM_BANK1 ; $58d3
	ld c, 8 * TILEMAP_WIDTH / 16 ; $58d6
	call QueueVRAMCopy ; $58d8
	call AdvanceFrame ; $58db
	ld hl, wShadowTilemap + 8 * TILEMAP_WIDTH ; $58de
	ld de, vBGMap0 + 8 * TILEMAP_WIDTH ; $58e1
	ld c, 8 * TILEMAP_WIDTH / 16 ; $58e4
	call QueueVRAMCopy ; $58e6
	ld hl, wShadowAttrmap + 8 * TILEMAP_WIDTH ; $58e9
	ld de, vBGMap0 + 8 * TILEMAP_WIDTH + VRAM_BANK1 ; $58ec
	ld c, 8 * TILEMAP_WIDTH / 16 ; $58ef
	call QueueVRAMCopy ; $58f1
	call AdvanceFrame ; $58f4
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $58f7
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH ; $58fa
	ld c, 4 * TILEMAP_WIDTH / 16 ; $58fd
	call QueueVRAMCopy ; $58ff
	ld hl, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $5902
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH + VRAM_BANK1 ; $5905
	ld c, 4 * TILEMAP_WIDTH / 16 ; $5908
	call QueueVRAMCopy ; $590a
	call AdvanceFrame ; $590d
	ret ; $5910
	ret ; $5911
RankingBoardAnimTask_1b:
	ld a, [wRankingBannerAnimFrame] ; $5912
	or a ; $5915
	jr nz, .nonZero ; $5916
	ld a, $a0 ; $5918
	ld [wRankingBannerX], a ; $591a
.nonZero:
	ld a, [wRankingBannerAnimFrame] ; $591d
	ld hl, RankingBoardAnimTaskTable ; $5920
	add l ; $5923
	ld l, a ; $5924
	jr nc, .read ; $5925
	inc h ; $5927
.read:
	ld b, [hl] ; $5928
	ld a, [wRankingBannerX] ; $5929
	add b ; $592c
	ld [wRankingBannerX], a ; $592d
	ld hl, RankingBoardAnimTask_1b_SpriteTemplate ; $5930
	ld e, $40 ; $5933
	ld a, [wRankingBoardDoubles] ; $5935
	or a ; $5938
	jr z, .zero ; $5939
	ld e, $50 ; $593b
.zero:
	ld a, [wRankingBannerX] ; $593d
	ld d, a ; $5940
	ld c, $10 ; $5941
	ld b, OAM_BANK1 | 4 ; $5943
	call QueueSpriteTemplate ; $5945
	ld a, [wRankingBannerAnimFrame] ; $5948
	inc a ; $594b
	ld [wRankingBannerAnimFrame], a ; $594c
	cp $87 ; $594f
	jr nz, .done ; $5951
	ld hl, RankingBoardAnimTask_1b ; $5953
	call UnregisterFrameTask ; $5956
.done:
	ret ; $5959
RankingBoardAnimTask_1b_SpriteTemplate:
	; $595a, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
RankingBoardAnimTaskTable:
	INCBIN "data/bank_01b/RankingBoardAnimTaskTable.bin" ; $597b, 137 bytes
RankingCursorBobTask:
	ld a, [wRankingBannerAnimFrame] ; $5a04
	or a ; $5a07
	jr nz, .setBobOffset ; $5a08
.setBobOffset:
	ld de, $3040 ; $5a0a
	ld a, [wRankingBoardDoubles] ; $5a0d
	or a ; $5a10
	jr z, .applySpriteBobOffset ; $5a11
	ld_xy de, $30, $50 ; $5a13
.applySpriteBobOffset:
	farcall ApplySpriteBobOffset ; $5a16
	ld hl, RankingCursorBobTask_SpriteTemplate ; $5a19
	ld c, $20 ; $5a1c
	ld b, OAM_BANK1 | 5 ; $5a1e
	call QueueSpriteTemplate ; $5a20
	ret ; $5a23
RankingCursorBobTask_SpriteTemplate:
	; $5a24, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawRankingMarkersTask:
	ld c, $00 ; $5a45
.loop:
	call GetRankingMarkerSlot ; $5a47
	ld a, [hl+] ; $5a4a
	cp $ff ; $5a4b
	jr z, .eqff ; $5a4d
	ld b, a ; $5a4f
	ld a, [hl+] ; $5a50
	ld d, a ; $5a51
	ld a, [hl+] ; $5a52
	ld e, a ; $5a53
	call QueueRankingMarkerSprite ; $5a54
.eqff:
	ld a, c ; $5a57
	inc a ; $5a58
	ld c, a ; $5a59
	cp $0c ; $5a5a
	jr nz, .loop ; $5a5c
	ret ; $5a5e
QueueRankingMarkerSprite:
	push af ; $5a5f
	push bc ; $5a60
	ld a, b ; $5a61
	add a ; $5a62
	ld c, a ; $5a63
	ld a, b ; $5a64
	or $08 ; $5a65
	ld b, a ; $5a67
	call QueueSprite ; $5a68
	pop bc ; $5a6b
	pop af ; $5a6c
	ret ; $5a6d
StartRankingMarkerAnim0:
	ld b, h ; $5a6e
	ld c, l ; $5a6f
	ld hl, wRankingAnimSlotPtrs ; $5a70
	ld a, c ; $5a73
	ld [hl+], a ; $5a74
	ld [hl], b ; $5a75
	ld hl, wRankingAnimScriptPtrs ; $5a76
	ld a, e ; $5a79
	ld [hl+], a ; $5a7a
	ld [hl], d ; $5a7b
	xor a ; $5a7c
	ld [wRankingAnimStepIndex], a ; $5a7d
	ld a, $01 ; $5a80
	ld hl, UpdateScriptedOffsetChannel0 ; $5a82
	call RegisterFrameTask ; $5a85
	ret ; $5a88
StartRankingMarkerAnim1:
	ld b, h ; $5a89
	ld c, l ; $5a8a
	ld hl, wRankingAnimSlotPtrs + 2 ; $5a8b
	ld a, c ; $5a8e
	ld [hl+], a ; $5a8f
	ld [hl], b ; $5a90
	ld hl, wRankingAnimScriptPtrs + 2 ; $5a91
	ld a, e ; $5a94
	ld [hl+], a ; $5a95
	ld [hl], d ; $5a96
	xor a ; $5a97
	ld [wRankingAnimStepIndex + 1], a ; $5a98
	ld a, $01 ; $5a9b
	ld hl, UpdateScriptedOffsetChannel1 ; $5a9d
	call RegisterFrameTask ; $5aa0
	ret ; $5aa3
StartRankingMarkerAnim2:
	ld b, h ; $5aa4
	ld c, l ; $5aa5
	ld hl, wRankingAnimSlotPtrs + 4 ; $5aa6
	ld a, c ; $5aa9
	ld [hl+], a ; $5aaa
	ld [hl], b ; $5aab
	ld hl, wRankingAnimScriptPtrs + 4 ; $5aac
	ld a, e ; $5aaf
	ld [hl+], a ; $5ab0
	ld [hl], d ; $5ab1
	xor a ; $5ab2
	ld [wRankingAnimStepIndex + 2], a ; $5ab3
	ld a, $01 ; $5ab6
	ld hl, UpdateScriptedOffsetChannel2 ; $5ab8
	call RegisterFrameTask ; $5abb
	ret ; $5abe
StartRankingMarkerAnim3:
	ld b, h ; $5abf
	ld c, l ; $5ac0
	ld hl, wRankingAnimSlotPtrs + 6 ; $5ac1
	ld a, c ; $5ac4
	ld [hl+], a ; $5ac5
	ld [hl], b ; $5ac6
	ld hl, wRankingAnimScriptPtrs + 6 ; $5ac7
	ld a, e ; $5aca
	ld [hl+], a ; $5acb
	ld [hl], d ; $5acc
	xor a ; $5acd
	ld [wRankingAnimStepIndex + 3], a ; $5ace
	ld a, $01 ; $5ad1
	ld hl, UpdateScriptedOffsetChannel3 ; $5ad3
	call RegisterFrameTask ; $5ad6
	ret ; $5ad9
UpdateScriptedOffsetChannel0:
	ld hl, wRankingAnimScriptPtrs ; $5ada
	ld a, [hl+] ; $5add
	ld d, [hl] ; $5ade
	ld e, a ; $5adf
	ld a, [wRankingAnimStepIndex] ; $5ae0
	ld h, $00 ; $5ae3
	ld l, a ; $5ae5
	add hl, de ; $5ae6
	ld a, [hl] ; $5ae7
	cp $40 ; $5ae8
	jr z, .eq40 ; $5aea
	ld c, a ; $5aec
	ld hl, wRankingAnimSlotPtrs ; $5aed
	ld a, [hl+] ; $5af0
	ld h, [hl] ; $5af1
	ld l, a ; $5af2
	inc hl ; $5af3
	ld a, [hl] ; $5af4
	add c ; $5af5
	ld [hl], a ; $5af6
	jr .checkTextPageBreakRequest ; $5af7
.eq40:
	ld hl, UpdateScriptedOffsetChannel0 ; $5af9
	call UnregisterFrameTask ; $5afc
	ret ; $5aff
.checkTextPageBreakRequest:
	ld a, [wRankingAnimStepIndex] ; $5b00
	inc a ; $5b03
	ld [wRankingAnimStepIndex], a ; $5b04
	ret ; $5b07
UpdateScriptedOffsetChannel1:
	ld hl, wRankingAnimScriptPtrs + 2 ; $5b08
	ld a, [hl+] ; $5b0b
	ld d, [hl] ; $5b0c
	ld e, a ; $5b0d
	ld a, [wRankingAnimStepIndex + 1] ; $5b0e
	ld h, $00 ; $5b11
	ld l, a ; $5b13
	add hl, de ; $5b14
	ld a, [hl] ; $5b15
	cp $40 ; $5b16
	jr z, .eq40 ; $5b18
	ld c, a ; $5b1a
	ld hl, wRankingAnimSlotPtrs + 2 ; $5b1b
	ld a, [hl+] ; $5b1e
	ld h, [hl] ; $5b1f
	ld l, a ; $5b20
	inc hl ; $5b21
	ld a, [hl] ; $5b22
	add c ; $5b23
	ld [hl], a ; $5b24
	jr .step2 ; $5b25
.eq40:
	ld hl, UpdateScriptedOffsetChannel1 ; $5b27
	call UnregisterFrameTask ; $5b2a
	ret ; $5b2d
.step2:
	ld a, [wRankingAnimStepIndex + 1] ; $5b2e
	inc a ; $5b31
	ld [wRankingAnimStepIndex + 1], a ; $5b32
	ret ; $5b35
UpdateScriptedOffsetChannel2:
	ld hl, wRankingAnimScriptPtrs + 4 ; $5b36
	ld a, [hl+] ; $5b39
	ld d, [hl] ; $5b3a
	ld e, a ; $5b3b
	ld a, [wRankingAnimStepIndex + 2] ; $5b3c
	ld h, $00 ; $5b3f
	ld l, a ; $5b41
	add hl, de ; $5b42
	ld a, [hl] ; $5b43
	cp $40 ; $5b44
	jr z, .eq40 ; $5b46
	ld c, a ; $5b48
	ld hl, wRankingAnimSlotPtrs + 4 ; $5b49
	ld a, [hl+] ; $5b4c
	ld h, [hl] ; $5b4d
	ld l, a ; $5b4e
	inc hl ; $5b4f
	inc hl ; $5b50
	ld a, [hl] ; $5b51
	add c ; $5b52
	ld [hl], a ; $5b53
	jr .step2 ; $5b54
.eq40:
	ld hl, UpdateScriptedOffsetChannel2 ; $5b56
	call UnregisterFrameTask ; $5b59
	ret ; $5b5c
.step2:
	ld a, [wRankingAnimStepIndex + 2] ; $5b5d
	inc a ; $5b60
	ld [wRankingAnimStepIndex + 2], a ; $5b61
	ret ; $5b64
UpdateScriptedOffsetChannel3:
	ld hl, wRankingAnimScriptPtrs + 6 ; $5b65
	ld a, [hl+] ; $5b68
	ld d, [hl] ; $5b69
	ld e, a ; $5b6a
	ld a, [wRankingAnimStepIndex + 3] ; $5b6b
	ld h, $00 ; $5b6e
	ld l, a ; $5b70
	add hl, de ; $5b71
	ld a, [hl] ; $5b72
	cp $40 ; $5b73
	jr z, .eq40 ; $5b75
	ld c, a ; $5b77
	ld hl, wRankingAnimSlotPtrs + 6 ; $5b78
	ld a, [hl+] ; $5b7b
	ld h, [hl] ; $5b7c
	ld l, a ; $5b7d
	inc hl ; $5b7e
	inc hl ; $5b7f
	ld a, [hl] ; $5b80
	add c ; $5b81
	ld [hl], a ; $5b82
	jr .step2 ; $5b83
.eq40:
	ld hl, UpdateScriptedOffsetChannel3 ; $5b85
	call UnregisterFrameTask ; $5b88
	ret ; $5b8b
.step2:
	ld a, [wRankingAnimStepIndex + 3] ; $5b8c
	inc a ; $5b8f
	ld [wRankingAnimStepIndex + 3], a ; $5b90
	ret ; $5b93
RankingBoardAnimState_5077Table0:
	; $5b94, 1 bytes (bytes:1)
	db $01 ; 0x00
RankingBoardAnimState_5077Table1:
	; $5b95, 3 bytes (bytes:3)
	db $01, $01, $01 ; 0x00
RankingBoardAnimState_546dTable:
	; $5b98, 5 bytes (bytes:5)
	db $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5077Table2:
	; $5b9d, 8 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5077Table3:
	; $5ba5, 13 bytes (bytes:13)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5077Table4:
	; $5bb2, 9 bytes (bytes:9)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_516fTable0:
	; $5bbb, 1 bytes (bytes:1)
	db $01 ; 0x00
RankingBoardAnimState_516fTable1:
	; $5bbc, 7 bytes (bytes:7)
	db $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_516fTable2:
	; $5bc3, 2 bytes (bytes:2)
	db $01, $01 ; 0x00
RankingBoardAnimState_5387Table0:
	; $5bc5, 7 bytes (bytes:7)
	db $01, $01, $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_516fTable3:
	ds 1, $ff ; $5bcc, fill
RankingBoardAnimState_516fTable4:
	ds 7, $ff ; $5bcd, fill
RankingBoardAnimState_516fTable5:
	; $5bd4, 9 bytes (bytes:9)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5368Table0:
	; $5bdd, 5 bytes (bytes:5)
	db $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5368Table1:
	; $5be2, 5 bytes (bytes:5)
	db $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5273Table0:
	; $5be7, 8 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_53faTable:
	; $5bef, 8 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_5387Table1:
	; $5bf7, 21 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
	db $01, $01, $01, $01, $40 ; 0x10
RankingBoardAnimState_5273Table1:
	; $5c0c, 37 bytes (bytes:16)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $ff, $ff, $ff, $ff, $40 ; 0x20
ClearRankingMarkerSlots:
	ld hl, wRankingMarkerSlots ; $5c31
	ld bc, $0030 ; $5c34
	call ClearBytes ; $5c37
	ret ; $5c3a
LoadRankingMarkerCoords:
	ld a, [wRankingBoardDoubles] ; $5c3b
	or a ; $5c3e
	jr nz, .nonZero ; $5c3f
	ld hl, RankingMarkerCoordsTable ; $5c41
	ld a, [wRankingBoardMode] ; $5c44
	or a ; $5c47
	jr z, .zero ; $5c48
	ld hl, RankingMarkerCoordsTable0 ; $5c4a
.zero:
	ld a, [wRankingBoardPlayerRow] ; $5c4d
	add a ; $5c50
	add l ; $5c51
	ld l, a ; $5c52
	jr nc, .read ; $5c53
	inc h ; $5c55
.read:
	ld a, [hl+] ; $5c56
	ld h, [hl] ; $5c57
	ld l, a ; $5c58
	push hl ; $5c59
	call GetRankingMarkerSlot ; $5c5a
	ld d, h ; $5c5d
	ld e, l ; $5c5e
	pop hl ; $5c5f
	ld bc, $0030 ; $5c60
	call CopyMemoryBC ; $5c63
	ret ; $5c66
.nonZero:
	ld hl, RankingMarkerCoordsTable2 ; $5c67
	ld a, [wRankingBoardMode] ; $5c6a
	or a ; $5c6d
	jr z, .zero2 ; $5c6e
	ld hl, RankingMarkerCoordsTable1 ; $5c70
.zero2:
	ld a, [wRankingBoardPlayerRow] ; $5c73
	add a ; $5c76
	add l ; $5c77
	ld l, a ; $5c78
	jr nc, .readB ; $5c79
	inc h ; $5c7b
.readB:
	ld a, [hl+] ; $5c7c
	ld h, [hl] ; $5c7d
	ld l, a ; $5c7e
	push hl ; $5c7f
	call GetRankingMarkerSlot ; $5c80
	ld d, h ; $5c83
	ld e, l ; $5c84
	pop hl ; $5c85
	ld bc, $0030 ; $5c86
	call CopyMemoryBC ; $5c89
	ret ; $5c8c
RankingMarkerCoordsTable:
	; $5c8d, 10 bytes (records:2)
	dw RankingMarkerCoordSet0 ; record 0
	dw RankingMarkerCoordSet0 ; record 1
	dw RankingMarkerCoordSet1 ; record 2
	dw RankingMarkerCoordSet2 ; record 3
	dw RankingMarkerCoordSet3 ; record 4
RankingMarkerCoordSet0:
	; $5c97, 48 bytes (bytes:4)
	db $00, $34, $0c, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $34, $54, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $34, $80, $00 ; 0x14
	db $02, $6b, $0c, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $6b, $38, $00 ; 0x20
	db $02, $6b, $54, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordSet1:
	; $5cc7, 48 bytes (bytes:4)
	db $00, $3c, $18, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $34, $80, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $6b, $38, $00 ; 0x20
	db $02, $64, $60, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordSet2:
	; $5cf7, 48 bytes (bytes:4)
	db $00, $44, $28, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $44, $70, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $5c, $28, $00 ; 0x20
	db $02, $5c, $70, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordSet3:
	; $5d27, 48 bytes (bytes:4)
	db $00, $4c, $4c, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $44, $70, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $5c, $28, $00 ; 0x20
	db $02, $54, $4c, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordsTable0:
	; $5d57, 10 bytes (records:2)
	dw RankingMarkerCoordsTable0Set0 ; record 0
	dw RankingMarkerCoordsTable0Set0 ; record 1
	dw RankingMarkerCoordsTable0Set1 ; record 2
	dw RankingMarkerCoordsTable0Set2 ; record 3
	dw RankingMarkerCoordsTable0Set3 ; record 4
RankingMarkerCoordsTable0Set0:
	; $5d61, 48 bytes (bytes:4)
	db $00, $3c, $0c, $00 ; 0x00
	db $01, $3c, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $34, $54, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $34, $80, $00 ; 0x14
	db $02, $6b, $0c, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $6b, $38, $00 ; 0x20
	db $02, $6b, $54, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordsTable0Set1:
	; $5d91, 48 bytes (bytes:4)
	db $00, $44, $18, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $44, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $34, $80, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $6b, $38, $00 ; 0x20
	db $02, $64, $60, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordsTable0Set2:
	; $5dc1, 48 bytes (bytes:4)
	db $00, $4c, $28, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $4c, $70, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $5c, $28, $00 ; 0x20
	db $02, $5c, $70, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordsTable0Set3:
	; $5df1, 48 bytes (bytes:4)
	db $00, $50, $4c, $00 ; 0x00
	db $01, $34, $24, $00 ; 0x04
	db $03, $34, $38, $00 ; 0x08
	db $02, $3c, $60, $00 ; 0x0c
	db $03, $34, $6c, $00 ; 0x10
	db $00, $4c, $70, $00 ; 0x14
	db $02, $64, $18, $00 ; 0x18
	db $01, $6b, $24, $00 ; 0x1c
	db $00, $5c, $28, $00 ; 0x20
	db $02, $50, $4c, $00 ; 0x24
	db $03, $6b, $6c, $00 ; 0x28
	db $00, $6b, $80, $00 ; 0x2c
RankingMarkerCoordsTable2:
	; $5e21, 8 bytes (records:2)
	dw RankingMarkerCoordsTable2Set0 ; record 0
	dw RankingMarkerCoordsTable2Set0 ; record 1
	dw RankingMarkerCoordsTable2Set1 ; record 2
	dw RankingMarkerCoordsTable2Set2 ; record 3
RankingMarkerCoordsTable2Set0:
	; $5e29, 48 bytes (bytes:4)
	db $00, $34, $1c, $00 ; 0x00
	db $01, $34, $44, $00 ; 0x04
	db $03, $34, $70, $00 ; 0x08
	db $02, $6c, $1c, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
RankingMarkerCoordsTable2Set1:
	; $5e59, 48 bytes (bytes:4)
	db $00, $3c, $30, $00 ; 0x00
	db $01, $34, $44, $00 ; 0x04
	db $03, $34, $70, $00 ; 0x08
	db $02, $64, $30, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
RankingMarkerCoordsTable2Set2:
	; $5e89, 48 bytes (bytes:4)
	db $00, $44, $4c, $00 ; 0x00
	db $01, $34, $44, $00 ; 0x04
	db $03, $34, $70, $00 ; 0x08
	db $02, $5c, $4c, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
RankingMarkerCoordsTable1:
	; $5eb9, 8 bytes (records:2)
	dw RankingMarkerCoordsTable1Set0 ; record 0
	dw RankingMarkerCoordsTable1Set0 ; record 1
	dw RankingMarkerCoordsTable1Set1 ; record 2
	dw RankingMarkerCoordsTable1Set2 ; record 3
RankingMarkerCoordsTable1Set0:
	; $5ec1, 48 bytes (bytes:4)
	db $00, $3c, $1c, $00 ; 0x00
	db $01, $3c, $44, $00 ; 0x04
	db $03, $34, $70, $00 ; 0x08
	db $02, $6c, $1c, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
RankingMarkerCoordsTable1Set1:
	; $5ef1, 48 bytes (bytes:4)
	db $00, $44, $30, $00 ; 0x00
	db $01, $34, $44, $00 ; 0x04
	db $03, $44, $70, $00 ; 0x08
	db $02, $64, $30, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
RankingMarkerCoordsTable1Set2:
	; $5f21, 48 bytes (bytes:4)
	db $00, $4c, $4c, $00 ; 0x00
	db $01, $34, $44, $00 ; 0x04
	db $03, $34, $70, $00 ; 0x08
	db $02, $54, $4c, $00 ; 0x0c
	db $03, $6c, $44, $00 ; 0x10
	db $00, $6c, $70, $00 ; 0x14
	db $ff, $ff, $ff, $ff ; 0x18
	db $ff, $ff, $ff, $ff ; 0x1c
	db $ff, $ff, $ff, $ff ; 0x20
	db $ff, $ff, $ff, $ff ; 0x24
	db $ff, $ff, $ff, $ff ; 0x28
	db $ff, $ff, $ff, $ff ; 0x2c
GetRankingMarkerSlot:
	push af ; $5f51
	ld a, c ; $5f52
	add a ; $5f53
	add a ; $5f54
	ld hl, wRankingMarkerSlots ; $5f55
	add l ; $5f58
	ld l, a ; $5f59
	jr nc, .done ; $5f5a
	inc h ; $5f5c
.done:
	pop af ; $5f5d
	ret ; $5f5e
Unused_1b_WriteRankingMarkerSlot:
	push af ; $5f5f
	ld a, b ; $5f60
	ld [hl+], a ; $5f61
	ld a, d ; $5f62
	ld [hl+], a ; $5f63
	ld a, e ; $5f64
	ld [hl+], a ; $5f65
	inc hl ; $5f66
	pop af ; $5f67
	ret ; $5f68
Unused_1b_AddRankingMarkerSlotByte1:
	push hl ; $5f69
	push af ; $5f6a
	inc hl ; $5f6b
	ld a, [hl] ; $5f6c
	add b ; $5f6d
	ld [hl], a ; $5f6e
	pop af ; $5f6f
	pop hl ; $5f70
	ret ; $5f71
Unused_1b_AddRankingMarkerSlotByte2:
	push hl ; $5f72
	push af ; $5f73
	inc hl ; $5f74
	inc hl ; $5f75
	ld a, [hl] ; $5f76
	add b ; $5f77
	ld [hl], a ; $5f78
	pop af ; $5f79
	pop hl ; $5f7a
	ret ; $5f7b
