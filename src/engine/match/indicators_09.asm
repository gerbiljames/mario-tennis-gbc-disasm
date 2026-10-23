; Advances an object along its move curve. OBJSLOT_CURVE selects the curve in
; MoveCurveTable_09 and OBJSLOT_CURVE_STEP is the step within it. Two
; terminators: $80 holds the object where it is, $81 ends the sequence and
; frees the slot by writing $ff to OBJSLOT_ID. Returns nz while the curve is
; still producing values.
GetNextMoveCurveValue:
	ld a, [wObjSlotWork + OBJSLOT_CURVE] ; $4782
	add a ; $4785
	ld_hl_indexed MoveCurveTable_09 ; $4786
	ld a, [hl+] ; $478d
	ld h, [hl] ; $478e
	ld l, a ; $478f
	ld a, [wObjSlotWork + OBJSLOT_CURVE_STEP] ; $4790
	add_hl_a ; $4793
	ld a, [hl] ; $4798
	cp $80 ; $4799
	jr z, .done ; $479b
	cp $81 ; $479d
	jr z, .markFinished ; $479f
	ld [wObjSlotWork + OBJSLOT_CURVE_X], a ; $47a1
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
	dw MoveCurve00_09 ; $47ae
	dw MoveCurve01_09 ; $47b0
	dw MoveCurve02_09 ; $47b2
	dw MoveCurve03_09 ; $47b4
	dw MoveCurve04_09 ; $47b6
	dw MoveCurve05_09 ; $47b8
	dw MoveCurve06_09 ; $47ba
	dw MoveCurve07_09 ; $47bc
	dw MoveCurve08_09 ; $47be
	dw MoveCurve09_09 ; $47c0
	dw MoveCurve10_09 ; $47c2
	dw MoveCurve11_09 ; $47c4
	dw MoveCurve12_09 ; $47c6
	dw MoveCurve13_09 ; $47c8
	dw MoveCurve14_09 ; $47ca
	dw MoveCurve15_09 ; $47cc
MoveCurve00_09:
	INCLUDE "data/engine/match/MoveCurve00_09.asm" ; $47ce, 13 bytes (move_curve)
MoveCurve01_09:
	INCLUDE "data/engine/match/MoveCurve01_09.asm" ; $47db, 13 bytes (move_curve)
MoveCurve02_09:
	INCLUDE "data/engine/match/MoveCurve02_09.asm" ; $47e8, 13 bytes (move_curve)
MoveCurve03_09:
	INCLUDE "data/engine/match/MoveCurve03_09.asm" ; $47f5, 13 bytes (move_curve)
MoveCurve04_09:
	INCLUDE "data/engine/match/MoveCurve04_09.asm" ; $4802, 9 bytes (move_curve)
MoveCurve05_09:
	INCLUDE "data/engine/match/MoveCurve05_09.asm" ; $480b, 9 bytes (move_curve)
MoveCurve06_09:
	INCLUDE "data/engine/match/MoveCurve06_09.asm" ; $4814, 9 bytes (move_curve)
MoveCurve07_09:
	INCLUDE "data/engine/match/MoveCurve07_09.asm" ; $481d, 9 bytes (move_curve)
MoveCurve08_09:
	INCLUDE "data/engine/match/MoveCurve08_09.asm" ; $4826, 9 bytes (move_curve)
MoveCurve09_09:
	INCLUDE "data/engine/match/MoveCurve09_09.asm" ; $482f, 9 bytes (move_curve)
MoveCurve10_09:
	INCLUDE "data/engine/match/MoveCurve10_09.asm" ; $4838, 9 bytes (move_curve)
MoveCurve11_09:
	INCLUDE "data/engine/match/MoveCurve11_09.asm" ; $4841, 9 bytes (move_curve)
MoveCurve15_09:
	INCLUDE "data/engine/match/MoveCurve15_09.asm" ; $484a, 10 bytes (move_curve)
	ASSERT @ == MoveCurve14_09, "MoveCurve15_09 has no terminator and runs on into MoveCurve14_09"
MoveCurve14_09:
	INCLUDE "data/engine/match/MoveCurve14_09.asm" ; $4854, 10 bytes (move_curve)
	ASSERT @ == MoveCurve13_09, "MoveCurve14_09 has no terminator and runs on into MoveCurve13_09"
MoveCurve13_09:
	INCLUDE "data/engine/match/MoveCurve13_09.asm" ; $485e, 10 bytes (move_curve)
	ASSERT @ == MoveCurve12_09, "MoveCurve13_09 has no terminator and runs on into MoveCurve12_09"
MoveCurve12_09:
	INCLUDE "data/engine/match/MoveCurve12_09.asm" ; $4868, 11 bytes (move_curve)
LoadCourtBannerGfx:
	add a ; $4873
	add a ; $4874
	ld_hl_indexed CourtBannerTileRanges_09 ; $4875
	ld a, [hl+] ; $487c
	ld e, a ; $487d
	ld a, [hl+] ; $487e
	ld d, a ; $487f
	ld c, [hl] ; $4880
	ld l, e ; $4881
	ld h, d ; $4882
	ld de, vTiles0 tile $20 ; $4883
	call QueueVRAMCopy ; $4886
	ret ; $4889
CourtBannerTileRanges_09:
	; $488a, 118 bytes (records:4)
; 29 records x 4 bytes
	dw CourtBannerTiles_09, $0020 ; record 0
	dw CourtBannerTiles_09 + $200, $0008 ; record 1
	dw CourtBannerTiles_09 + $280, $0010 ; record 2
	dw CourtBannerTiles_09 + $380, $0008 ; record 3
	dw CourtBannerTiles_09 + $3e0, $0008 ; record 4
	dw CourtBannerTiles_09 + $440, $0008 ; record 5
	dw CourtBannerTiles_09 + $4a0, $000a ; record 6
	dw CourtBannerTiles_09 + $540, $0010 ; record 7
	dw CourtBannerTiles_09 + $640, $0010 ; record 8
	dw CourtBannerTiles_09 + $740, $0010 ; record 9
	dw CourtBannerTiles_09 + $840, $0010 ; record 10
	dw CourtBannerTiles_09 + $940, $0010 ; record 11
	dw CourtBannerTiles_09 + $9c0, $0010 ; record 12
	dw CourtBannerTiles_09 + $a40, $0010 ; record 13
	dw CourtBannerTiles_09 + $ac0, $0008 ; record 14
	dw CourtBannerTiles_09 + $b20, $0020 ; record 15
	dw CourtBannerTiles_09 + $d20, $0010 ; record 16
	dw CourtBannerTiles_09, $0001 ; record 17
	dw CourtBannerTiles_09 + $e80, $000e ; record 18
	dw CourtBannerTiles_09 + $f60, $000e ; record 19
	dw CourtBannerTiles_09 + $1040, $000e ; record 20
	dw CourtBannerTiles_09 + $1120, $000e ; record 21
	dw CourtBannerTiles_09 + $1200, $000e ; record 22
	dw CourtBannerTiles_09 + $12e0, $000e ; record 23
	dw CourtBannerTiles_09 + $13c0, $0010 ; record 24
	dw CourtBannerTiles_09 + $14c0, $0010 ; record 25
	dw CourtBannerTiles_09 + $15c0, $0010 ; record 26
	dw CourtBannerTiles_09 + $16c0, $0004 ; record 27
	dw CourtBannerTiles_09 + $1700, $0010 ; record 28
	db $00, $00
	ds ALIGN[4]
CourtBannerTiles_09:
	INCBIN "data/engine/match/CourtBannerTiles_09.bin" ; $4900, 6144 bytes
LoadScoreDigitGfx:
	ld hl, ScoreDigitGfxPtrs_09 ; $6100
	call GetGfxSourcePtr ; $6103
	ld c, 4 ; $6106
	call QueueVRAMCopy ; $6108
	ret ; $610b
LoadPlayer1PointsDigitGfx:
	ld hl, ScoreDigitGfxPtrs_09 ; $610c
	call GetGfxSourcePtr ; $610f
	ld de, vTiles0 tile $78 ; $6112
	ld c, 4 ; $6115
	call QueueVRAMCopy ; $6117
	ret ; $611a
LoadPlayer2PointsDigitGfx:
	ld hl, ScoreDigitGfxPtrs_09 ; $611b
	call GetGfxSourcePtr ; $611e
	ld de, vTiles0 tile $7c ; $6121
	ld c, 4 ; $6124
	call QueueVRAMCopy ; $6126
	ret ; $6129
LoadFirstScoreDigitGfx:
	ld hl, FirstScoreDigitGfxSource ; $612a
	call GetGfxSourcePtr ; $612d
	ld de, vTiles0 tile $30 ; $6130
	ld c, 4 ; $6133
	call QueueVRAMCopy ; $6135
	ret ; $6138
LoadSecondScoreDigitGfx:
	ld hl, SecondScoreDigitGfxSource ; $6139
	call GetGfxSourcePtr ; $613c
	ld de, vTiles0 tile $34 ; $613f
	ld c, 4 ; $6142
	call QueueVRAMCopy ; $6144
	ret ; $6147
LoadDeuceGfx:
	ld hl, DeuceTiles ; $6148
	ld de, vTiles0 tile $30 ; $614b
	ld c, (LoadServeGfx - DeuceTiles) / 16 ; $614e
	call QueueVRAMCopy ; $6150
	ret ; $6153
GetGfxSourcePtr:
	push af ; $6154
	ld a, b ; $6155
	add a ; $6156
	add_hl_a ; $6157
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
ScoreDigitGfxPtrs_09:
	dw TennisCallDigitGfx_09, NumeralDigitGfx_09 ; $616d
FirstScoreDigitGfxSource:
	dw Player1TennisCallDigitGfx_09, Player1NumeralDigitGfx_09 ; $6171
SecondScoreDigitGfxSource:
	dw Player2TennisCallDigitGfx_09, Player2NumeralDigitGfx_09 ; $6175
	ds ALIGN[4]
TennisCallDigitGfx_09:
	INCBIN "data/engine/match/TennisCallDigitGfx_09.bin" ; $6180, 384 bytes
	ds ALIGN[4]
NumeralDigitGfx_09:
	INCBIN "data/engine/match/NumeralDigitGfx_09.bin" ; $6300, 576 bytes
	ds ALIGN[4]
Player1TennisCallDigitGfx_09:
	INCBIN "data/engine/match/Player1TennisCallDigitGfx_09.bin" ; $6540, 320 bytes
	ds ALIGN[4]
Player1NumeralDigitGfx_09:
	INCBIN "data/engine/match/Player1NumeralDigitGfx_09.bin" ; $6680, 512 bytes
	ds ALIGN[4]
Player2TennisCallDigitGfx_09:
	INCBIN "data/engine/match/Player2TennisCallDigitGfx_09.bin" ; $6880, 320 bytes
	ds ALIGN[4]
Player2NumeralDigitGfx_09:
	INCBIN "data/engine/match/Player2NumeralDigitGfx_09.bin" ; $69c0, 512 bytes
	ds ALIGN[4]
DeuceTiles:
	INCBIN "data/engine/match/DeuceTiles.bin" ; $6bc0, 128 bytes
LoadServeGfx:
	ld a, [wCurrentServingPlayer] ; $6c40
	add a ; $6c43
	ld_hl_indexed ServeIndicatorGfxPtrs_09 ; $6c44
	ld a, [hl+] ; $6c4b
	ld h, [hl] ; $6c4c
	ld l, a ; $6c4d
	ld a, [wServeFaultFlag] ; $6c4e
	and $01 ; $6c51
	ld b, a ; $6c53
	ld a, [wServingCharCourtPos] ; $6c54
	and COURTPOSF_FAR ; $6c57
	or b ; $6c59
	add a ; $6c5a
	add a ; $6c5b
	add a ; $6c5c
	add a ; $6c5d
	add a ; $6c5e
	add a ; $6c5f
	add_hl_a ; $6c60
	ld de, vTiles0 tile $38 ; $6c65
	ld c, 4 ; $6c68
	call QueueVRAMCopy ; $6c6a
	ret ; $6c6d
ServeIndicatorGfxPtrs_09:
	dw ServeIndicatorP1Gfx_09, ServeIndicatorP2Gfx_09, ServeIndicatorP3Gfx_09, ServeIndicatorP4Gfx_09 ; $6c6e
	ds ALIGN[4]
ServeIndicatorP1Gfx_09:
	INCBIN "data/engine/match/ServeIndicatorP1Gfx_09.bin" ; $6c80, 256 bytes
	ds ALIGN[4]
ServeIndicatorP2Gfx_09:
	INCBIN "data/engine/match/ServeIndicatorP2Gfx_09.bin" ; $6d80, 256 bytes
	ds ALIGN[4]
ServeIndicatorP3Gfx_09:
	INCBIN "data/engine/match/ServeIndicatorP3Gfx_09.bin" ; $6e80, 256 bytes
	ds ALIGN[4]
ServeIndicatorP4Gfx_09:
	INCBIN "data/engine/match/ServeIndicatorP4Gfx_09.bin" ; $6f80, 256 bytes
; A column of up to eight 8x16 objects one tile apart, tiles $0e down to $00;
; an object template enters it part-way to draw fewer (the entry labels
; say how many rows remain).
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
	dw Player1ServeIndicatorSoloSpriteTemplate_09 ; record 0
	dw Player1ServeIndicatorSoloSpriteTemplate_09 ; record 1
	dw Player1ServeIndicatorSoloSpriteTemplate_09 ; record 2
	dw Player1ServeIndicatorDuoSpriteTemplate_09 ; record 3
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
	dw Player2ServeIndicatorSoloSpriteTemplate_09 ; record 0
	dw Player2ServeIndicatorSoloSpriteTemplate_09 ; record 1
	dw Player2ServeIndicatorDuoSpriteTemplate_09 ; record 2
	dw Player2ServeIndicatorDuoSpriteTemplate_09 ; record 3
Player1ServeIndicatorSoloSpriteTemplate_09:
	; $7131, 25 bytes (sprite_template)
	oam_sprite $10, $08, $14, $00
	oam_sprite $10, $10, $04, $04
	oam_sprite $10, $18, $06, $04
	oam_sprite $10, $20, $14, $00
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player1ServeIndicatorDuoSpriteTemplate_09:
	; $714a, 25 bytes (sprite_template)
	oam_sprite $10, $08, $04, $04
	oam_sprite $10, $10, $06, $04
	oam_sprite $10, $18, $14, $06
	oam_sprite $10, $20, $16, $06
	oam_sprite $10, $28, $78, $01
	oam_sprite $10, $30, $7a, $01
	oam_sprite_end
Player2ServeIndicatorSoloSpriteTemplate_09:
	; $7163, 25 bytes (sprite_template)
	oam_sprite $20, $08, $14, $00
	oam_sprite $20, $10, $0c, $05
	oam_sprite $20, $18, $0e, $05
	oam_sprite $20, $20, $14, $00
	oam_sprite $20, $28, $7c, $01
	oam_sprite $20, $30, $7e, $01
	oam_sprite_end
Player2ServeIndicatorDuoSpriteTemplate_09:
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
	dw Player1CharIconSoloSpriteTemplate_09 ; record 0
	dw Player1CharIconSoloSpriteTemplate_09 ; record 1
	dw Player1CharIconSoloSpriteTemplate_09 ; record 2
	dw Player1CharIconDuoSpriteTemplate_09 ; record 3
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
	dw Player2CharIconSoloSpriteTemplate_09 ; record 0
	dw Player2CharIconSoloSpriteTemplate_09 ; record 1
	dw Player2CharIconDuoSpriteTemplate_09 ; record 2
	dw Player2CharIconDuoSpriteTemplate_09 ; record 3
Player1CharIconSoloSpriteTemplate_09:
	; $71c3, 9 bytes (sprite_template)
	oam_sprite $10, $10, $00, $04
	oam_sprite $10, $18, $02, $04
	oam_sprite_end
Player1CharIconDuoSpriteTemplate_09:
	; $71cc, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $04
	oam_sprite $10, $10, $02, $04
	oam_sprite $10, $18, $10, $06
	oam_sprite $10, $20, $12, $06
	oam_sprite_end
Player2CharIconSoloSpriteTemplate_09:
	; $71dd, 9 bytes (sprite_template)
	oam_sprite $10, $10, $08, $05
	oam_sprite $10, $18, $0a, $05
	oam_sprite_end
Player2CharIconDuoSpriteTemplate_09:
	; $71e6, 17 bytes (sprite_template)
	oam_sprite $10, $08, $08, $05
	oam_sprite $10, $10, $0a, $05
	oam_sprite $10, $18, $18, $07
	oam_sprite $10, $20, $1a, $07
	oam_sprite_end
LessonScorePanelSpriteTemplate_09:
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
