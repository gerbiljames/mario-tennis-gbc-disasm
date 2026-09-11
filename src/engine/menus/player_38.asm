ClearPlayerSlotPortrait:
	call GetPlayerSlotBoxAddress ; $55ab
	ld d, b ; $55ae
	ld e, c ; $55af
	ld b, $02 ; $55b0
	ld c, $02 ; $55b2
	ld h, $00 ; $55b4
	push de ; $55b6
	farcall FillTilemapRect ; $55b7
	pop de ; $55ba
	ld b, $02 ; $55bb
	ld c, $02 ; $55bd
	ld hl, $0400 ; $55bf
	add hl, de ; $55c2
	ld d, h ; $55c3
	ld e, l ; $55c4
	ld h, $08 ; $55c5
	farcall FillTilemapRect ; $55c7
	call GetPlayerSlotBoxAddress ; $55ca
	ld hl, $001e ; $55cd
	add hl, bc ; $55d0
	xor a ; $55d1
	ld [hl+], a ; $55d2
	ld [hl], a ; $55d3
	ld a, [wCharSelectSlot] ; $55d4
	cp $02 ; $55d7
	jr nc, .slot0 ; $55d9
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $55db
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $55de
	ld c, $04 ; $55e1
	call QueueVRAMCopy ; $55e3
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $55e6
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $55e9
	ld c, $04 ; $55ec
	call QueueVRAMCopy ; $55ee
	jr .done ; $55f1
.slot0:
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $55f3
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $55f6
	ld c, $04 ; $55f9
	call QueueVRAMCopy ; $55fb
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $55fe
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $5601
	ld c, $04 ; $5604
	call QueueVRAMCopy ; $5606
.done:
	ret ; $5609
; Four shadow-tilemap cell addresses -- rows 6 and 9, columns 14 and
; 16, i.e. the four player slots -- sitting immediately behind
; ClearPlayerSlotPortrait, which instead reaches its cells through
; unrolled per-slot branches with the addresses written out longhand.
; Byte-identical to Unused_38_PortraitCellAddrs1 behind
; DrawPlayerSlotPortrait, which is itself evidence of copy-paste.
;
; The live equivalent is the PlayerSlotBoxAddrs0-5 family, which uses
; columns 13 and 17 and pads unused slots with NO_BOX. These two read
; as the superseded version.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_38_PortraitCellAddrs0:
	; $560a, 8 bytes (ram_ptrs:3)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; record 0
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; record 3
DrawPlayerSlotPortrait:
	ld hl, wCharGridEntries ; $5612
	ld a, b ; $5615
	add a ; $5616
	add a ; $5617
	add l ; $5618
	ld l, a ; $5619
	jr nc, .gotSource ; $561a
	inc h ; $561c
.gotSource:
	ld b, h ; $561d
	ld c, l ; $561e
	ld hl, $0000 ; $561f
	add hl, bc ; $5622
	ld d, [hl] ; $5623
	ld hl, $0001 ; $5624
	add hl, bc ; $5627
	ld e, [hl] ; $5628
	call GetPlayerSlotBoxAddress ; $5629
	ld h, b ; $562c
	ld l, c ; $562d
	ld b, d ; $562e
	ld c, e ; $562f
	ld d, h ; $5630
	ld e, l ; $5631
	dec c ; $5632
	call WriteCharPortraitTiles ; $5633
	call DrawPlayerSlotLeftHandedMark ; $5636
	call DrawPlayerSlotDifficultyMark ; $5639
	ld a, [wCharSelectSlot] ; $563c
	cp $02 ; $563f
	jr nc, .slot0 ; $5641
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $5643
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $5646
	ld c, $04 ; $5649
	call QueueVRAMCopy ; $564b
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $564e
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $5651
	ld c, $04 ; $5654
	call QueueVRAMCopy ; $5656
	jr .done ; $5659
.slot0:
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $565b
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $565e
	ld c, $04 ; $5661
	call QueueVRAMCopy ; $5663
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $5666
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $5669
	ld c, $04 ; $566c
	call QueueVRAMCopy ; $566e
.done:
	ret ; $5671
; Byte-identical twin of Unused_38_PortraitCellAddrs0, behind
; DrawPlayerSlotPortrait. See that label for the full argument.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_38_PortraitCellAddrs1:
	; $5672, 8 bytes (ram_ptrs:3)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; record 0
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; record 3
DrawPlayerSlotLeftHandedMark:
	ld a, [wCharSelectSlot] ; $567a
	ld hl, wCharSelectSlotLeftHanded ; $567d
	add l ; $5680
	ld l, a ; $5681
	jr nc, .read ; $5682
	inc h ; $5684
.read:
	ld a, [hl] ; $5685
	or a ; $5686
	ret z ; $5687
	call GetPlayerSlotBoxAddress ; $5688
	ld hl, $001f ; $568b
	add hl, bc ; $568e
	ld a, $32 ; $568f
	ld [hl], a ; $5691
	ret ; $5692
DrawPlayerSlotDifficultyMark:
	ld hl, wCharSelectSlotDifficulty ; $5693
	ld a, [wCharSelectSlot] ; $5696
	add l ; $5699
	ld l, a ; $569a
	jr nc, .read ; $569b
	inc h ; $569d
.read:
	ld a, [hl] ; $569e
	ld c, $33 ; $569f
	add c ; $56a1
	push af ; $56a2
	call GetPlayerSlotBoxAddress ; $56a3
	ld hl, $001e ; $56a6
	add hl, bc ; $56a9
	pop af ; $56aa
	ld [hl], a ; $56ab
.done:
	ret ; $56ac
GetPlayerSlotBoxAddress:
	ld a, [wCharSelectMode] ; $56ad
	add a ; $56b0
	ld hl, PlayerSlotBoxAddrPtrs_38 ; $56b1
	add l ; $56b4
	ld l, a ; $56b5
	jr nc, .readTable ; $56b6
	inc h ; $56b8
.readTable:
	ld a, [hl+] ; $56b9
	ld h, [hl] ; $56ba
	ld l, a ; $56bb
	ld a, [wCharSelectSlot] ; $56bc
	add a ; $56bf
	add l ; $56c0
	ld l, a ; $56c1
	jr nc, .readEntry ; $56c2
	inc h ; $56c4
.readEntry:
	ld a, [hl+] ; $56c5
	ld b, [hl] ; $56c6
	ld c, a ; $56c7
	ret ; $56c8
PlayerSlotBoxAddrPtrs_38:
	; $56c9, 12 bytes (records:2)
	dw PlayerSlotBoxAddrs0 ; record 0
	dw PlayerSlotBoxAddrs1 ; record 1
	dw PlayerSlotBoxAddrs2 ; record 2
	dw PlayerSlotBoxAddrs3 ; record 3
	dw PlayerSlotBoxAddrs4 ; record 4
	dw PlayerSlotBoxAddrs5 ; record 5
PlayerSlotBoxAddrs0:
	; $56d5, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; record 0
	dw NO_BOX ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
PlayerSlotBoxAddrs1:
	; $56df, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 13 ; record 0
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 17 ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 13 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 17 ; record 3
	dw NO_BOX ; record 4
PlayerSlotBoxAddrs2:
	; $56e9, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; record 0
	dw NO_BOX ; record 1
	dw NO_BOX ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
PlayerSlotBoxAddrs3:
	; $56f3, 10 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw NO_BOX ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
PlayerSlotBoxAddrs4:
	; $56fd, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 13 ; record 0
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 17 ; record 1
	dw NO_BOX ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
PlayerSlotBoxAddrs5:
	; $5707, 11 bytes (ram_ptrs:3:NO_BOX)
	dw NO_BOX ; record 0
	dw NO_BOX ; record 1
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 13 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 17 ; record 3
	dw NO_BOX ; record 4
	db $c9
WriteCharPortraitTiles:
	ld a, b ; $5712
	add a ; $5713
	add a ; $5714
	ld b, a ; $5715
	ld a, $80 ; $5716
	add b ; $5718
	ld b, a ; $5719
	ld a, c ; $571a
	add $03 ; $571b
	or $08 ; $571d
	ld c, a ; $571f
	push de ; $5720
	ld a, b ; $5721
	ld [de], a ; $5722
	inc b ; $5723
	inc b ; $5724
	inc de ; $5725
	ld a, b ; $5726
	ld [de], a ; $5727
	ld hl, $001f ; $5728
	add hl, de ; $572b
	ld d, h ; $572c
	ld e, l ; $572d
	dec b ; $572e
	ld a, b ; $572f
	ld [de], a ; $5730
	inc b ; $5731
	inc b ; $5732
	inc de ; $5733
	ld a, b ; $5734
	ld [de], a ; $5735
	pop de ; $5736
	ld hl, $0400 ; $5737
	add hl, de ; $573a
	ld d, h ; $573b
	ld e, l ; $573c
	ld h, c ; $573d
	ld b, $02 ; $573e
	ld c, $02 ; $5740
	farcall FillTilemapRect ; $5742
	ret ; $5745
LoadAllCharPortraitTiles:
	xor a ; $5746
.loop:
	push af ; $5747
	push bc ; $5748
	push de ; $5749
	push hl ; $574a
	farcall LoadOnCourtCharTilesA ; $574b
	pop hl ; $574e
	pop de ; $574f
	pop bc ; $5750
	pop af ; $5751
	ld hl, $0040 ; $5752
	add hl, de ; $5755
	ld d, h ; $5756
	ld e, l ; $5757
	inc a ; $5758
	cp $20 ; $5759
	jr nz, .loop ; $575b
	ret ; $575d
RefreshCharInfoPanel:
	push af ; $575e
	push bc ; $575f
	push de ; $5760
	push hl ; $5761
	push_wram_bank $03 ; $5762
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $576b
	ld b, $12 ; $576e
	ld c, $01 ; $5770
	ld h, $03 ; $5772
	farcall FillTilemapRect ; $5774
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; $5777
	ld b, $12 ; $577a
	ld c, $04 ; $577c
	ld h, $20 ; $577e
	farcall FillTilemapRect ; $5780
	ld a, [wCharSelectSlot] ; $5783
	cp $04 ; $5786
	jr nz, .haveSlot ; $5788
	jr .done ; $578a
.haveSlot:
	call GetGridSlotFromCursor ; $578c
	ld d, a ; $578f
	ld c, a ; $5790
	add a ; $5791
	add a ; $5792
	ld hl, wCharGridEntries ; $5793
	add l ; $5796
	ld l, a ; $5797
	jr nc, .readSlot ; $5798
	inc h ; $579a
.readSlot:
	ld a, [hl] ; $579b
	cp $04 ; $579c
	jr nc, .namedChar ; $579e
	inc hl ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld a, [hl] ; $57a3
	ld c, a ; $57a4
	call DrawCreatedCharStats ; $57a5
	jr .done ; $57a8
.namedChar:
	cp $ff ; $57aa
	jr z, .done ; $57ac
	ld c, a ; $57ae
	push bc ; $57af
	call DrawCharNameAndType ; $57b0
	pop bc ; $57b3
	call DrawCharSelectSlotLabel ; $57b4
.done:
	ld hl, wShadowTilemap + 12 * TILEMAP_WIDTH ; $57b7
	ld de, vBGMap0 + 12 * TILEMAP_WIDTH ; $57ba
	ld c, $0a ; $57bd
	call QueueVRAMCopy ; $57bf
	ld hl, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $57c2
	ld de, vBGMap0 + 16 * TILEMAP_WIDTH + VRAM_BANK1 ; $57c5
	ld c, $02 ; $57c8
	call QueueVRAMCopy ; $57ca
	pop_wram_bank ; $57cd
	pop hl ; $57d2
	pop de ; $57d3
	pop bc ; $57d4
	pop af ; $57d5
	ret ; $57d6
; Six bytes, $00 $02 $04 $01 $03 $05 -- the six stat rows in
; column-major order, sitting immediately in front of
; DrawCreatedCharStats.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_38_StatDrawOrder:
	; $57d7, 6 bytes (bytes:6)
	db $00, $02, $04, $01, $03, $05 ; 0x00
DrawCreatedCharStats:
	push af ; $57dd
	push bc ; $57de
	push de ; $57df
	push hl ; $57e0
	push_wram_bank $03 ; $57e1
	ld a, c ; $57ea
	ld de, $0020 ; $57eb
	ld hl, wCreatedCharRecords ; $57ee
.seekRecord:
	or a ; $57f1
	jr z, .drawStats ; $57f2
	add hl, de ; $57f4
	dec a ; $57f5
	jr .seekRecord ; $57f6
.drawStats:
	ld b, h ; $57f8
	ld c, l ; $57f9
	ld a, [hl] ; $57fa
	cp $ff ; $57fb
	jp z, .drawName ; $57fd
	push af ; $5800
	push bc ; $5801
	push de ; $5802
	push hl ; $5803
	ld hl, $0007 ; $5804
	add hl, bc ; $5807
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 3 ; $5808
	call DrawNameWithDiacritics_38 ; $580b
	pop hl ; $580e
	pop de ; $580f
	pop bc ; $5810
	pop af ; $5811
	ld a, $4c ; $5812
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 11], a ; $5814
	ld a, $56 ; $5817
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 12], a ; $5819
	ld hl, $0002 ; $581c
	add hl, bc ; $581f
	ld l, [hl] ; $5820
	ld h, $00 ; $5821
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 14 ; $5823
	ld a, $02 ; $5826
	call DrawDecimalNumber ; $5828
	ld a, $1d ; $582b
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 2], a ; $582d
	ld a, $1e ; $5830
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 3], a ; $5832
	ld a, $1f ; $5835
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 4], a ; $5837
	ld hl, $0003 ; $583a
	add hl, bc ; $583d
	ld l, [hl] ; $583e
	ld h, $00 ; $583f
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 7 ; $5841
	ld a, $02 ; $5844
	call DrawDecimalNumber ; $5846
	ld hl, $0004 ; $5849
	add hl, bc ; $584c
	ld l, [hl] ; $584d
	ld h, $00 ; $584e
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 15 ; $5850
	ld a, $02 ; $5853
	call DrawDecimalNumber ; $5855
	ld a, $14 ; $5858
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 10], a ; $585a
	ld a, $15 ; $585d
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 11], a ; $585f
	ld a, $16 ; $5862
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 12], a ; $5864
	ld a, $17 ; $5867
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 13], a ; $5869
	ld a, $18 ; $586c
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 2], a ; $586e
	ld a, $19 ; $5871
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 3], a ; $5873
	ld a, $1a ; $5876
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 4], a ; $5878
	ld a, $1b ; $587b
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 5], a ; $587d
	ld a, $1c ; $5880
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 6], a ; $5882
	ld hl, $0005 ; $5885
	add hl, bc ; $5888
	ld l, [hl] ; $5889
	ld h, $00 ; $588a
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 7 ; $588c
	ld a, $02 ; $588f
	call DrawDecimalNumber ; $5891
	ld a, $10 ; $5894
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 10], a ; $5896
	ld a, $11 ; $5899
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 11], a ; $589b
	ld a, $12 ; $589e
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 12], a ; $58a0
	ld a, $13 ; $58a3
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 13], a ; $58a5
	ld hl, $0006 ; $58a8
	add hl, bc ; $58ab
	ld l, [hl] ; $58ac
	ld h, $00 ; $58ad
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $58af
	ld a, $02 ; $58b2
	call DrawDecimalNumber ; $58b4
.drawName:
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH + 1 ; $58b7
	ld h, $00 ; $58ba
	ld b, $12 ; $58bc
	ld c, $01 ; $58be
	farcall FillTilemapRect ; $58c0
	pop_wram_bank ; $58c3
	pop hl ; $58c8
	pop de ; $58c9
	pop bc ; $58ca
	pop af ; $58cb
	ret ; $58cc
