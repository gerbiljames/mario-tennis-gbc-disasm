; Advances an object along its move curve. wObjSlotWork + 14 selects the curve
; in MoveCurveTable_09 and + 13 is the step within it. Two terminators: $80
; holds the object where it is, $81 ends the sequence and frees the slot by
; writing $ff to the record's +$00. Returns nz while the curve is still
; producing values.
GetNextMoveCurveValue:
	ld a, [wObjSlotWork + 14] ; $4782
	add a ; $4785
	ld_hl_indexed MoveCurveTable_09 ; $4786
	ld a, [hl+] ; $478d
	ld h, [hl] ; $478e
	ld l, a ; $478f
	ld a, [wObjSlotWork + 13] ; $4790
	add l ; $4793
	ld l, a ; $4794
	jr nc, .readValue ; $4795
	inc h ; $4797
.readValue:
	ld a, [hl] ; $4798
	cp $80 ; $4799
	jr z, .done ; $479b
	cp $81 ; $479d
	jr z, .markFinished ; $479f
	ld [wObjSlotWork + 10], a ; $47a1
	xor a ; $47a4
	inc a ; $47a5
	ret ; $47a6
.markFinished:
	ld a, $ff ; $47a7
	ld [wObjSlotWork], a ; $47a9
.done:
	xor a ; $47ac
	ret ; $47ad
MoveCurveTable_09:
	INCBIN "data/bank_009/MoveCurveTable_09.bin" ; $47ae, 197 bytes
LoadTilesetGfx:
	add a ; $4873
	add a ; $4874
	ld_hl_indexed VramTileset_09 ; $4875
	ld a, [hl+] ; $487c
	ld e, a ; $487d
	ld a, [hl+] ; $487e
	ld d, a ; $487f
	ld c, [hl] ; $4880
	ld l, e ; $4881
	ld h, d ; $4882
	ld de, vTiles0 + $20 * TILE_SIZE ; $4883
	call QueueVRAMCopy ; $4886
	ret ; $4889
VramTileset_09:
	; $488a, 118 bytes (records:4)
; 29 records x 4 bytes
	dw TilesetTiles_09, $0020 ; record 0
	dw TilesetTiles_09 + $200, $0008 ; record 1
	dw TilesetTiles_09 + $280, $0010 ; record 2
	dw TilesetTiles_09 + $380, $0008 ; record 3
	dw TilesetTiles_09 + $3e0, $0008 ; record 4
	dw TilesetTiles_09 + $440, $0008 ; record 5
	dw TilesetTiles_09 + $4a0, $000a ; record 6
	dw TilesetTiles_09 + $540, $0010 ; record 7
	dw TilesetTiles_09 + $640, $0010 ; record 8
	dw TilesetTiles_09 + $740, $0010 ; record 9
	dw TilesetTiles_09 + $840, $0010 ; record 10
	dw TilesetTiles_09 + $940, $0010 ; record 11
	dw TilesetTiles_09 + $9c0, $0010 ; record 12
	dw TilesetTiles_09 + $a40, $0010 ; record 13
	dw TilesetTiles_09 + $ac0, $0008 ; record 14
	dw TilesetTiles_09 + $b20, $0020 ; record 15
	dw TilesetTiles_09 + $d20, $0010 ; record 16
	dw TilesetTiles_09, $0001 ; record 17
	dw TilesetTiles_09 + $e80, $000e ; record 18
	dw TilesetTiles_09 + $f60, $000e ; record 19
	dw TilesetTiles_09 + $1040, $000e ; record 20
	dw TilesetTiles_09 + $1120, $000e ; record 21
	dw TilesetTiles_09 + $1200, $000e ; record 22
	dw TilesetTiles_09 + $12e0, $000e ; record 23
	dw TilesetTiles_09 + $13c0, $0010 ; record 24
	dw TilesetTiles_09 + $14c0, $0010 ; record 25
	dw TilesetTiles_09 + $15c0, $0010 ; record 26
	dw TilesetTiles_09 + $16c0, $0004 ; record 27
	dw TilesetTiles_09 + $1700, $0010 ; record 28
	db $00, $00
	ds ALIGN[4]
TilesetTiles_09:
	INCBIN "data/bank_009/TilesetTiles_09.bin" ; $4900, 6144 bytes
LoadScoreDigitGfx:
	ld hl, VramGfxPtrTable_09 ; $6100
	call GetGfxSourcePtr ; $6103
	ld c, $04 ; $6106
	call QueueVRAMCopy ; $6108
	ret ; $610b
LoadPlayer1PointsDigitGfx:
	ld hl, VramGfxPtrTable_09 ; $610c
	call GetGfxSourcePtr ; $610f
	ld de, vTiles0 + $78 * TILE_SIZE ; $6112
	ld c, $04 ; $6115
	call QueueVRAMCopy ; $6117
	ret ; $611a
LoadPlayer2PointsDigitGfx:
	ld hl, VramGfxPtrTable_09 ; $611b
	call GetGfxSourcePtr ; $611e
	ld de, vTiles0 + $7c * TILE_SIZE ; $6121
	ld c, $04 ; $6124
	call QueueVRAMCopy ; $6126
	ret ; $6129
LoadPlayer1ScoreDigitGfx:
	ld hl, Player1ScoreDigitGfxSource ; $612a
	call GetGfxSourcePtr ; $612d
	ld de, vTiles0 + $30 * TILE_SIZE ; $6130
	ld c, $04 ; $6133
	call QueueVRAMCopy ; $6135
	ret ; $6138
LoadPlayer2ScoreDigitGfx:
	ld hl, LoadPlayer2ScoreDigitGfxTable ; $6139
	call GetGfxSourcePtr ; $613c
	ld de, vTiles0 + $34 * TILE_SIZE ; $613f
	ld c, $04 ; $6142
	call QueueVRAMCopy ; $6144
	ret ; $6147
LoadDeuceAdvantageGfx:
	ld hl, DeuceAdvantageTiles ; $6148
	ld de, vTiles0 + $30 * TILE_SIZE ; $614b
	ld c, (LoadServeGfx - DeuceAdvantageTiles) / 16 ; $614e
	call QueueVRAMCopy ; $6150
	ret ; $6153
GetGfxSourcePtr:
	push af ; $6154
	ld a, b ; $6155
	add a ; $6156
	add l ; $6157
	ld l, a ; $6158
	jr nc, .read ; $6159
	inc h ; $615b
.read:
	ld a, [hl+] ; $615c
	ld h, [hl] ; $615d
	ld l, a ; $615e
	pop af ; $615f
	ld b, a ; $6160
	ld c, $00 ; $6161
	sra b ; $6163
	rr c ; $6165
	sra b ; $6167
	rr c ; $6169
	add hl, bc ; $616b
	ret ; $616c
VramGfxPtrTable_09:
	INCBIN "data/bank_009/VramGfxPtrTable_09.bin" ; $616d, 4 bytes
Player1ScoreDigitGfxSource:
	INCBIN "data/bank_009/Player1ScoreDigitGfxSource.bin" ; $6171, 4 bytes
LoadPlayer2ScoreDigitGfxTable:
	INCBIN "data/bank_009/LoadPlayer2ScoreDigitGfxTable.bin" ; $6175, 2635 bytes
	ds ALIGN[4]
DeuceAdvantageTiles:
	INCBIN "data/bank_009/DeuceAdvantageTiles.bin" ; $6bc0, 128 bytes
LoadServeGfx:
	ld a, [wCurrentServingPlayer] ; $6c40
	add a ; $6c43
	ld_hl_indexed ServeGfxPtrTable_09 ; $6c44
	ld a, [hl+] ; $6c4b
	ld h, [hl] ; $6c4c
	ld l, a ; $6c4d
	ld a, [wServeFaultFlag] ; $6c4e
	and $01 ; $6c51
	ld b, a ; $6c53
	ld a, [wServingCharCourtPos] ; $6c54
	and $02 ; $6c57
	or b ; $6c59
	add a ; $6c5a
	add a ; $6c5b
	add a ; $6c5c
	add a ; $6c5d
	add a ; $6c5e
	add a ; $6c5f
	add l ; $6c60
	ld l, a ; $6c61
	jr nc, .queue ; $6c62
	inc h ; $6c64
.queue:
	ld de, vTiles0 + $38 * TILE_SIZE ; $6c65
	ld c, $04 ; $6c68
	call QueueVRAMCopy ; $6c6a
	ret ; $6c6d
ServeGfxPtrTable_09:
	INCBIN "data/bank_009/ServeGfxPtrTable_09.bin" ; $6c6e, 1042 bytes
; A column of up to eight 8x16 objects one tile apart, tiles $0e down to $00;
; an object template enters it part-way to draw fewer (the entry labels
; say how many rows remain). ServeGfxPtrTable_09 used to swallow its head.
ObjColumn8SpriteTemplate_09:
	; $7080, 33 bytes (sprite_template)
	oam_sprite $10, $40, $0e, $00
.rows7:
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $30, $0a, $00
.rows5:
	oam_sprite $10, $28, $08, $00
.rows4:
	oam_sprite $10, $20, $06, $00
.rows3:
	oam_sprite $10, $18, $04, $00
.rows2:
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
ObjTwoColumn8SpriteTemplate_09:
	; $70a1, 65 bytes (sprite_template)
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite_end
ObjTwoColumn4SpriteTemplate_09:
	; $70e2, 33 bytes (sprite_template)
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $28, $0e, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $20, $0a, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $18, $06, $00
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $10, $02, $00
	oam_sprite_end
GetPlayer1ServeIndicatorSprites:
	ld a, [wOnCourtCharCountMinus1] ; $7103
	add a ; $7106
	ld_hl_indexed Player1ServeIndicatorSpritePtrs_09 ; $7107
	ld a, [hl+] ; $710e
	ld d, [hl] ; $710f
	ld e, a ; $7110
	ret ; $7111
Player1ServeIndicatorSpritePtrs_09:
	; $7112, 8 bytes (records:2)
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 0
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 1
	dw Player1ServeIndicatorSpriteTemplate0_09 ; record 2
	dw Player1ServeIndicatorSpriteTemplate1_09 ; record 3
GetPlayer2ServeIndicatorSprites:
	ld a, [wOnCourtCharCountMinus1] ; $711a
	add a ; $711d
	ld_hl_indexed Player2ServeIndicatorSpritePtrs_09 ; $711e
	ld a, [hl+] ; $7125
	ld d, [hl] ; $7126
	ld e, a ; $7127
	ret ; $7128
Player2ServeIndicatorSpritePtrs_09:
	; $7129, 8 bytes (records:2)
	dw Player2ServeIndicatorSpriteTemplate0_09 ; record 0
	dw Player2ServeIndicatorSpriteTemplate0_09 ; record 1
	dw Player2ServeIndicatorSpriteTemplate1_09 ; record 2
	dw Player2ServeIndicatorSpriteTemplate1_09 ; record 3
Player1ServeIndicatorSpriteTemplate0_09:
	; $7131, 25 bytes (sprite_template)
	oam_sprite $10, $08, $14, $00
	oam_sprite $10, $10, $04, $04
	oam_sprite $10, $18, $06, $04
	oam_sprite $10, $20, $14, $00
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player1ServeIndicatorSpriteTemplate1_09:
	; $714a, 25 bytes (sprite_template)
	oam_sprite $10, $08, $04, $04
	oam_sprite $10, $10, $06, $04
	oam_sprite $10, $18, $14, $06
	oam_sprite $10, $20, $16, $06
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player2ServeIndicatorSpriteTemplate0_09:
	; $7163, 25 bytes (sprite_template)
	oam_sprite $20, $08, $14, $00
	oam_sprite $20, $10, $0c, $05
	oam_sprite $20, $18, $0e, $05
	oam_sprite $20, $20, $14, $00
	oam_sprite $20, $28, $7c, $01
	oam_sprite $20, $30, $7e, $01
	oam_sprite_end
Player2ServeIndicatorSpriteTemplate1_09:
	; $717c, 25 bytes (sprite_template)
	oam_sprite $20, $08, $0c, $05
	oam_sprite $20, $10, $0e, $05
	oam_sprite $20, $18, $1c, $07
	oam_sprite $20, $20, $1e, $07
	oam_sprite $20, $28, $7c, $01
	oam_sprite $20, $30, $7e, $01
	oam_sprite_end
GetPlayer1CharIconSprites:
	ld a, [wOnCourtCharCountMinus1] ; $7195
	add a ; $7198
	ld_hl_indexed Player1CharIconSpritePtrs_09 ; $7199
	ld a, [hl+] ; $71a0
	ld d, [hl] ; $71a1
	ld e, a ; $71a2
	ret ; $71a3
Player1CharIconSpritePtrs_09:
	; $71a4, 8 bytes (records:2)
	dw Player1CharIconSpriteTemplate0_09 ; record 0
	dw Player1CharIconSpriteTemplate0_09 ; record 1
	dw Player1CharIconSpriteTemplate0_09 ; record 2
	dw Player1CharIconSpriteTemplate1_09 ; record 3
GetPlayer2CharIconSprites:
	ld a, [wOnCourtCharCountMinus1] ; $71ac
	add a ; $71af
	ld_hl_indexed Player2CharIconSpritePtrs_09 ; $71b0
	ld a, [hl+] ; $71b7
	ld d, [hl] ; $71b8
	ld e, a ; $71b9
	ret ; $71ba
Player2CharIconSpritePtrs_09:
	; $71bb, 8 bytes (records:2)
	dw Player2CharIconSpriteTemplate0_09 ; record 0
	dw Player2CharIconSpriteTemplate0_09 ; record 1
	dw Player2CharIconSpriteTemplate1_09 ; record 2
	dw Player2CharIconSpriteTemplate1_09 ; record 3
Player1CharIconSpriteTemplate0_09:
	; $71c3, 9 bytes (sprite_template)
	oam_sprite $10, $10, $00, $04
	oam_sprite $10, $18, $02, $04
	oam_sprite_end
Player1CharIconSpriteTemplate1_09:
	; $71cc, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $04
	oam_sprite $10, $10, $02, $04
	oam_sprite $10, $18, $10, $06
	oam_sprite $10, $20, $12, $06
	oam_sprite_end
Player2CharIconSpriteTemplate0_09:
	; $71dd, 9 bytes (sprite_template)
	oam_sprite $10, $10, $08, $05
	oam_sprite $10, $18, $0a, $05
	oam_sprite_end
Player2CharIconSpriteTemplate1_09:
	; $71e6, 17 bytes (sprite_template)
	oam_sprite $10, $08, $08, $05
	oam_sprite $10, $10, $0a, $05
	oam_sprite $10, $18, $18, $07
	oam_sprite $10, $20, $1a, $07
	oam_sprite_end
SpriteTemplate_09_8:
	; $71f7, 33 bytes (sprite_template)
	oam_sprite $08, $18, $00, $04
	oam_sprite $08, $20, $02, $04
	oam_sprite $18, $08, $28, $09
	oam_sprite $18, $10, $2a, $09
	oam_sprite $18, $18, $2c, $09
	oam_sprite $18, $20, $2e, $09
	oam_sprite $18, $28, $78, $01
	oam_sprite $18, $30, $7a, $01
	oam_sprite_end
	; $7218, 3560 bytes fill to bank end (linker-padded)
