MapMinigameRowToMugshotSlot:
	push hl ; $768a
	ld hl, MapMinigameRowToMugshotSlotTable ; $768b
	ld a, c ; $768e
	add l ; $768f
	ld l, a ; $7690
	jr nc, .read ; $7691
	inc h ; $7693
.read:
	ld c, [hl] ; $7694
	pop hl ; $7695
	ret ; $7696
MapMinigameRowToMugshotSlotTable:
	; $7697, 10 bytes (bytes:10)
	db $00, $01, $02, $03, $04, $05, $07, $08, $0c, $10 ; 0x00
GetMinigameRowTilemapDest:
	ld hl, MinigameRowTilemapDestTable ; $76a1
	ld a, b ; $76a4
	add a ; $76a5
	add l ; $76a6
	ld l, a ; $76a7
	jr nc, .read ; $76a8
	inc h ; $76aa
.read:
	ld a, [hl+] ; $76ab
	ld h, [hl] ; $76ac
	ld l, a ; $76ad
	ret ; $76ae
MinigameRowTilemapDestTable:
	; $76af, 10 bytes (bytes:10)
	db $c3, $d0, $03, $d1, $43, $d1, $83, $d1, $c3, $d1 ; 0x00
DrawMinigameDataScrollArrows:
	call CheckMinigameDataScrollable ; $76b9
	or a ; $76bc
	ret z ; $76bd
	ld a, [wMenuCursorY] ; $76be
	or a ; $76c1
	jr z, .checkMenuCursorY ; $76c2
	ld de, $1128 ; $76c4
	ld c, $01 ; $76c7
	call ApplyArrowBobOffset ; $76c9
	ld b, $08 ; $76cc
	ld c, $00 ; $76ce
	ld h, $02 ; $76d0
	farcall QueueStackedSpritePair ; $76d2
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $76d5
	cp $04 ; $76d8
	jr z, .done ; $76da
	ld de, $1184 ; $76dc
	ld c, $00 ; $76df
	call ApplyArrowBobOffset ; $76e1
	ld b, $08 ; $76e4
	ld c, $00 ; $76e6
	ld h, $03 ; $76e8
	farcall QueueStackedSpritePair ; $76ea
.done:
	ret ; $76ed
DrawMinigameDataMarks:
	call ClearMinigameMarkColumns ; $76ee
	call DrawMinigameClearMarks ; $76f1
	call DrawMinigameStarMarks ; $76f4
	call DrawMinigameSpecialMark ; $76f7
	ret ; $76fa
DrawMinigameClearMarks:
	ld hl, wMinigameDataClearFlags ; $76fb
	ld a, [wMenuCursorY] ; $76fe
	add l ; $7701
	ld l, a ; $7702
	jr nc, .gotPtr ; $7703
	inc h ; $7705
.gotPtr:
	ld c, $00 ; $7706
.loop:
	ld b, $00 ; $7708
	ld a, [hl+] ; $770a
	or a ; $770b
	jr z, .zero ; $770c
	call DrawMinigameMarkTile ; $770e
.zero:
	ld a, c ; $7711
	inc a ; $7712
	ld c, a ; $7713
	cp $05 ; $7714
	jr nz, .loop ; $7716
	ret ; $7718
DrawMinigameStarMarks:
	ld hl, wMinigameDataStarFlags ; $7719
	ld a, [wMenuCursorY] ; $771c
	add l ; $771f
	ld l, a ; $7720
	jr nc, .gotPtr ; $7721
	inc h ; $7723
.gotPtr:
	ld c, $00 ; $7724
.loop:
	ld b, $01 ; $7726
	ld a, [hl+] ; $7728
	or a ; $7729
	jr z, .zero ; $772a
	call DrawMinigameMarkTile ; $772c
.zero:
	ld a, c ; $772f
	inc a ; $7730
	ld c, a ; $7731
	cp $05 ; $7732
	jr nz, .loop ; $7734
	ret ; $7736
DrawMinigameSpecialMark:
	ld a, [wMenuCursorY] ; $7737
	cp $04 ; $773a
	ret nz ; $773c
	ld hl, wMinigameDataTwoOnOneCleared ; $773d
	ld a, [hl+] ; $7740
	ld b, [hl] ; $7741
	or b ; $7742
	ret z ; $7743
	ld b, $02 ; $7744
	ld c, $04 ; $7746
	call DrawMinigameMarkTile ; $7748
	ret ; $774b
DrawMinigameMarkTile:
	push af ; $774c
	push bc ; $774d
	push de ; $774e
	push hl ; $774f
	ld hl, MinigameMarkTileTable ; $7750
	ld a, b ; $7753
	add a ; $7754
	add l ; $7755
	ld l, a ; $7756
	jr nc, .read ; $7757
	inc h ; $7759
.read:
	ld a, [hl+] ; $775a
	ld h, [hl] ; $775b
	ld l, a ; $775c
	ld a, c ; $775d
	add a ; $775e
	add l ; $775f
	ld l, a ; $7760
	jr nc, .readB ; $7761
	inc h ; $7763
.readB:
	ld a, [hl+] ; $7764
	ld d, [hl] ; $7765
	ld e, a ; $7766
	push de ; $7767
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 21 ; $7768
	rect_size $02, $02 ; $776b
	farcall CopyTilemapRect ; $776f
	pop de ; $7772
	ld hl, $0400 ; $7773
	add hl, de ; $7776
	ld d, h ; $7777
	ld e, l ; $7778
	ld hl, wShadowAttrmap + 2 * TILEMAP_WIDTH + 21 ; $7779
	rect_size $02, $02 ; $777c
	farcall CopyTilemapRect ; $7780
	pop hl ; $7783
	pop de ; $7784
	pop bc ; $7785
	pop af ; $7786
	ret ; $7787
MinigameMarkTileTable:
	; $7788, 6 bytes (records:2)
	dw MinigameStarRow0 ; record 0
	dw MinigameStarRow1 ; record 1
	dw MinigameStarRow2 ; record 2
MinigameStarRow0:
	; $778e, 10 bytes (records:2)
	dw $d0c6 ; record 0
	dw $d106 ; record 1
	dw $d146 ; record 2
	dw $d186 ; record 3
	dw $d1c6 ; record 4
MinigameStarRow1:
	; $7798, 10 bytes (records:2)
	dw $d0ca ; record 0
	dw $d10a ; record 1
	dw $d14a ; record 2
	dw $d18a ; record 3
	dw $d1ca ; record 4
MinigameStarRow2:
	; $77a2, 10 bytes (records:2)
	dw $d0ce ; record 0
	dw $d10e ; record 1
	dw $d14e ; record 2
	dw $d18e ; record 3
	dw $d1ce ; record 4
ClearMinigameMarkColumns:
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77ac
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 6 ; $77af
	rect_size $02, $0a ; $77b2
	farcall CopyTilemapRect ; $77b6
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77b9
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 6 ; $77bc
	rect_size $02, $0a ; $77bf
	farcall CopyTilemapRect ; $77c3
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77c6
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 10 ; $77c9
	rect_size $02, $0a ; $77cc
	farcall CopyTilemapRect ; $77d0
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77d3
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 10 ; $77d6
	rect_size $02, $0a ; $77d9
	farcall CopyTilemapRect ; $77dd
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77e0
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; $77e3
	rect_size $02, $0a ; $77e6
	farcall CopyTilemapRect ; $77ea
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77ed
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 14 ; $77f0
	rect_size $02, $0a ; $77f3
	farcall CopyTilemapRect ; $77f7
	ret ; $77fa
DrawStarLegendMark:
	ld hl, wMinigameDataStarFlags ; $77fb
	ld c, $00 ; $77fe
.loop:
	ld a, [hl+] ; $7800
	or a ; $7801
	jr nz, .nonZero ; $7802
	ld a, c ; $7804
	inc a ; $7805
	ld c, a ; $7806
	cp $09 ; $7807
	jr nz, .loop ; $7809
	ret ; $780b
.nonZero:
	ld hl, wShadowTilemap + 22 ; $780c
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; $780f
	rect_size $02, $02 ; $7812
	farcall CopyTilemapRect ; $7816
	ld hl, wShadowAttrmap + 22 ; $7819
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; $781c
	rect_size $02, $02 ; $781f
	farcall CopyTilemapRect ; $7823
	ret ; $7826
DrawMinigameHighScoreNumbers:
	push_wram_bank WRAM_SCREEN ; $7827
	ld a, [wMenuCursorY] ; $7830
	ld c, a ; $7833
	ld b, $00 ; $7834
.loop:
	call DrawMinigameHighScoreNumber ; $7836
	inc c ; $7839
	ld a, b ; $783a
	inc b ; $783b
	ld a, b ; $783c
	cp $05 ; $783d
	jr nz, .loop ; $783f
	pop_wram_bank ; $7841
	ret ; $7846
DrawMinigameHighScoreNumber:
	ld a, c ; $7847
	cp $08 ; $7848
	ret z ; $784a
	ld a, b ; $784b
	add a ; $784c
	ld hl, MinigameHighScoreNumberTable ; $784d
	add l ; $7850
	ld l, a ; $7851
	jr nc, .read ; $7852
	inc h ; $7854
.read:
	ld a, [hl+] ; $7855
	ld d, [hl] ; $7856
	ld e, a ; $7857
	ld a, c ; $7858
	ld hl, wMinigameDataStarFlags ; $7859
	add l ; $785c
	ld l, a ; $785d
	jr nc, .readB ; $785e
	inc h ; $7860
.readB:
	ld a, [hl] ; $7861
	or a ; $7862
	ret z ; $7863
	ld a, c ; $7864
	add a ; $7865
	ld hl, wMinigameDataHighScores ; $7866
	add l ; $7869
	ld l, a ; $786a
	jr nc, .read2 ; $786b
	inc h ; $786d
.read2:
	ld a, [hl+] ; $786e
	ld h, [hl] ; $786f
	ld l, a ; $7870
	farcall DrawDecimalNumberSprites_39 ; $7871
	ret ; $7874
MinigameHighScoreNumberTable:
	; $7875, 10 bytes (bytes:10)
	db $35, $84, $45, $84, $55, $84, $65, $84, $75, $84 ; 0x00
CheckMinigameDataScrollable:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, $04 ; $7882
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7884
	cp CHAR_UNUSED_15 ; $7887
	jr nz, .scrollable ; $7889
	pop hl ; $788b
	pop de ; $788c
	pop bc ; $788d
	xor a ; $788e
	ret ; $788f
.scrollable:
	pop hl ; $7890
	pop de ; $7891
	pop bc ; $7892
	ld a, $01 ; $7893
	ret ; $7895
CompactMinigameDataRows:
	push_wram_bank WRAM_SCREEN ; $7896
	ld a, [wMinigameDataClearFlags + 5] ; $789f
	ld [wMinigameDataClearFlags + 4], a ; $78a2
	ld a, [wMinigameDataStarFlags + 5] ; $78a5
	ld [wMinigameDataStarFlags + 4], a ; $78a8
	ld a, [wMinigameDataHighScores + 10] ; $78ab
	ld [wMinigameDataHighScores + 8], a ; $78ae
	ld a, [wMinigameDataHighScores + 11] ; $78b1
	ld [wMinigameDataHighScores + 9], a ; $78b4
	pop_wram_bank ; $78b7
	ret ; $78bc
ObjectSceneAGfx0:
	INCBIN "data/bank_01b/lz_ObjectSceneAGfx0.bin" ; $78bd, 179 bytes
ObjectSceneAGfx1:
	INCBIN "data/bank_01b/lz_ObjectSceneAGfx1.bin" ; $7970, 80 bytes
ObjectSceneAGfx2:
	INCBIN "data/bank_01b/lz_ObjectSceneAGfx2.bin" ; $79c0, 184 bytes
ObjectSceneBGfx0:
	INCBIN "data/bank_01b/lz_ObjectSceneBGfx0.bin" ; $7a78, 61 bytes
ObjectSceneBGfx1:
	INCBIN "data/bank_01b/lz_ObjectSceneBGfx1.bin" ; $7ab5, 65 bytes
ObjectSceneBGfx2:
	INCBIN "data/bank_01b/lz_ObjectSceneBGfx2.bin" ; $7af6, 65 bytes
Screen0Gfx:
	INCBIN "data/bank_01b/lz_Screen0Gfx.bin" ; $7b37, 503 bytes
Screen1ObjGfx:
	INCBIN "data/bank_01b/lz_Screen1ObjGfx.bin" ; $7d2e, 321 bytes
Screen2ObjGfx:
	INCBIN "data/bank_01b/lz_Screen2ObjGfx.bin" ; $7e6f, 323 bytes
	; $7fb2, 78 bytes fill to bank end (linker-padded)
