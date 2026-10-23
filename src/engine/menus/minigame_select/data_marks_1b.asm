MapMinigameRowToMugshotSlot:
	push hl ; $768a
	ld hl, MapMinigameRowToMugshotSlotTable ; $768b
	ld a, c ; $768e
	add_hl_a ; $768f
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
	add_hl_a ; $76a6
	ld a, [hl+] ; $76ab
	ld h, [hl] ; $76ac
	ld l, a ; $76ad
	ret ; $76ae
MinigameRowTilemapDestTable:
	; $76af, 10 bytes (ram_ptrs:3)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 3 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 3 ; record 1
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 3 ; record 2
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 3 ; record 3
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 3 ; record 4
DrawMinigameDataScrollArrows:
	call CheckMinigameDataScrollable ; $76b9
	or a ; $76bc
	ret z ; $76bd
	ld a, [wMenuCursorY] ; $76be
	or a ; $76c1
	jr z, .checkMenuCursorY ; $76c2
	ld de, $1128 ; $76c4
	ld c, BOBDIR_POS ; $76c7
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
	ld c, BOBDIR_NEG ; $76df
	call ApplyArrowBobOffset ; $76e1
	ld b, $08 ; $76e4
	ld c, $00 ; $76e6
	ld h, $03 ; $76e8
	farcall QueueStackedSpritePair ; $76ea
.done:
	ret ; $76ed
DrawMinigameDataMarks:
	call ClearMinigameMarkColumns ; $76ee
	call DrawMinigameLevel1Marks ; $76f1
	call DrawMinigameLevel2Marks ; $76f4
	call DrawTwoOnOneChallengeMark ; $76f7
	ret ; $76fa
DrawMinigameLevel1Marks:
	ld hl, wMinigameDataLevel1Cleared ; $76fb
	ld a, [wMenuCursorY] ; $76fe
	add_hl_a ; $7701
	ld c, $00 ; $7706
.loop:
	ld b, $00 ; $7708
	ld a, [hl+] ; $770a
	or a ; $770b
	jr z, .notCleared ; $770c
	call DrawMinigameMarkTile ; $770e
.notCleared:
	ld a, c ; $7711
	inc a ; $7712
	ld c, a ; $7713
	cp $05 ; $7714
	jr nz, .loop ; $7716
	ret ; $7718
DrawMinigameLevel2Marks:
	ld hl, wMinigameDataLevel2Cleared ; $7719
	ld a, [wMenuCursorY] ; $771c
	add_hl_a ; $771f
	ld c, $00 ; $7724
.loop:
	ld b, $01 ; $7726
	ld a, [hl+] ; $7728
	or a ; $7729
	jr z, .notCleared ; $772a
	call DrawMinigameMarkTile ; $772c
.notCleared:
	ld a, c ; $772f
	inc a ; $7730
	ld c, a ; $7731
	cp $05 ; $7732
	jr nz, .loop ; $7734
	ret ; $7736
DrawTwoOnOneChallengeMark:
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
	ld hl, MinigameMarkDestPtrs ; $7750
	ld a, b ; $7753
	add a ; $7754
	add_hl_a ; $7755
	ld a, [hl+] ; $775a
	ld h, [hl] ; $775b
	ld l, a ; $775c
	ld a, c ; $775d
	add a ; $775e
	add_hl_a ; $775f
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
MinigameMarkDestPtrs:
	; $7788, 6 bytes (records:2)
	dw MinigameLevel1MarkDests ; record 0
	dw MinigameLevel2MarkDests ; record 1
	dw MinigameChallengeMarkDests ; record 2
MinigameLevel1MarkDests:
	; $778e, 10 bytes (records:2)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 6 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 6 ; record 1
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 6 ; record 2
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 6 ; record 3
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 6 ; record 4
MinigameLevel2MarkDests:
	; $7798, 10 bytes (records:2)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 10 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 10 ; record 1
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 10 ; record 2
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 10 ; record 3
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 10 ; record 4
MinigameChallengeMarkDests:
	; $77a2, 10 bytes (records:2)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 14 ; record 1
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 14 ; record 3
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 14 ; record 4
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
DrawChallengeColumnHeader:
	ld hl, wMinigameDataLevel2Cleared ; $77fb
	ld c, $00 ; $77fe
.loop:
	ld a, [hl+] ; $7800
	or a ; $7801
	jr nz, .drawLegend ; $7802
	ld a, c ; $7804
	inc a ; $7805
	ld c, a ; $7806
	cp $09 ; $7807
	jr nz, .loop ; $7809
	ret ; $780b
.drawLegend:
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
	ld hl, MinigameHighScoreNumberPositions ; $784d
	add_hl_a ; $7850
	ld a, [hl+] ; $7855
	ld d, [hl] ; $7856
	ld e, a ; $7857
	ld a, c ; $7858
	ld hl, wMinigameDataLevel2Cleared ; $7859
	add_hl_a ; $785c
	ld a, [hl] ; $7861
	or a ; $7862
	ret z ; $7863
	ld a, c ; $7864
	add a ; $7865
	ld hl, wMinigameDataHighScores ; $7866
	add_hl_a ; $7869
	ld a, [hl+] ; $786e
	ld h, [hl] ; $786f
	ld l, a ; $7870
	farcall DrawDecimalNumberSprites_39 ; $7871
	ret ; $7874
MinigameHighScoreNumberPositions:
	; $7875, 10 bytes (bytes:10)
	db $35, $84, $45, $84, $55, $84, $65, $84, $75, $84 ; 0x00
CheckMinigameDataScrollable:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, MARIOGAME_FRUIT_FANTASY ; $7882
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7884
	cp CHAR_BALL_MACHINE ; $7887
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
	ld a, [wMinigameDataLevel1Cleared + 5] ; $789f
	ld [wMinigameDataLevel1Cleared + 4], a ; $78a2
	ld a, [wMinigameDataLevel2Cleared + 5] ; $78a5
	ld [wMinigameDataLevel2Cleared + 4], a ; $78a8
	ld a, [wMinigameDataHighScores + 10] ; $78ab
	ld [wMinigameDataHighScores + 8], a ; $78ae
	ld a, [wMinigameDataHighScores + 11] ; $78b1
	ld [wMinigameDataHighScores + 9], a ; $78b4
	pop_wram_bank ; $78b7
	ret ; $78bc
AwardsCeremonyConfettiGfx0:
	INCBIN "data/engine/menus/minigame_select/lz_AwardsCeremonyConfettiGfx0.bin" ; $78bd, 179 bytes
AwardsCeremonyConfettiGfx1:
	INCBIN "data/engine/menus/minigame_select/lz_AwardsCeremonyConfettiGfx1.bin" ; $7970, 80 bytes
AwardsCeremonyConfettiGfx2:
	INCBIN "data/engine/menus/minigame_select/lz_AwardsCeremonyConfettiGfx2.bin" ; $79c0, 184 bytes
DreamMatchEpilogueConfettiGfx0:
	INCBIN "data/engine/menus/minigame_select/lz_DreamMatchEpilogueConfettiGfx0.bin" ; $7a78, 61 bytes
DreamMatchEpilogueConfettiGfx1:
	INCBIN "data/engine/menus/minigame_select/lz_DreamMatchEpilogueConfettiGfx1.bin" ; $7ab5, 65 bytes
DreamMatchEpilogueConfettiGfx2:
	INCBIN "data/engine/menus/minigame_select/lz_DreamMatchEpilogueConfettiGfx2.bin" ; $7af6, 65 bytes
ToBeContinuedGfx:
	INCBIN "data/engine/menus/minigame_select/lz_ToBeContinuedGfx.bin" ; $7b37, 503 bytes
ToBeContinuedOutlineGfx:
	INCBIN "data/engine/menus/minigame_select/lz_ToBeContinuedOutlineGfx.bin" ; $7d2e, 321 bytes
TheEndGfx:
	INCBIN "data/engine/menus/minigame_select/lz_TheEndGfx.bin" ; $7e6f, 323 bytes
	; $7fb2, 78 bytes fill to bank end (linker-padded)
