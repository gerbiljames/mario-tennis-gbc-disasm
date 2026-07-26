SECTION "ROM Bank $67", ROMX[$4000], BANK[$67]

DataPtr_FountainCourtSceneConfig:
	dw FountainCourtSceneConfig ; $4000
DataPtr_FountainCourtPalettes:
	dw FountainCourtPalettes ; $4002
DataPtr_FountainCourtTilemap:
	dw FountainCourtTilemap ; $4004
DataPtr_FountainCourtAttrmap:
	dw FountainCourtAttrmap ; $4006
DataPtr_FountainCourtAuxTilemap:
	dw FountainCourtAuxTilemap ; $4008
DataPtr_FountainCourtAuxAttrmap:
	dw FountainCourtAuxAttrmap ; $400a
DataPtr_FountainCourtSceneUnusedSlot:
	dw FountainCourtSceneUnusedSlot ; $400c
DataPtr_FountainCourtTiles:
	dw FountainCourtTiles ; $400e
DataPtr_CafeCourtSceneConfig:
	dw CafeCourtSceneConfig ; $4010
DataPtr_CafeCourtPalettes:
	dw CafeCourtPalettes ; $4012
DataPtr_CafeCourtTilemap:
	dw CafeCourtTilemap ; $4014
DataPtr_CafeCourtAttrmap:
	dw CafeCourtAttrmap ; $4016
DataPtr_CafeCourtAuxTilemap:
	dw CafeCourtAuxTilemap ; $4018
DataPtr_CafeCourtAuxAttrmap:
	dw CafeCourtAuxAttrmap ; $401a
DataPtr_CourtComplexSceneConfig:
	dw CourtComplexSceneConfig ; $401c
DataPtr_CafeCourtTiles:
	dw CafeCourtTiles ; $401e
DataPtr_CourtComplexSceneConfigAlias1:
	dw CourtComplexSceneConfig ; $4020
DataPtr_CourtComplexPalettes:
	dw CourtComplexPalettes ; $4022
DataPtr_CourtComplexTilemap:
	dw CourtComplexTilemap ; $4024
DataPtr_CourtComplexAttrmap:
	dw CourtComplexAttrmap ; $4026
DataPtr_CourtComplexAuxTilemap:
	dw CourtComplexAuxTilemap ; $4028
DataPtr_CourtComplexAuxAttrmap:
	dw CourtComplexAuxAttrmap ; $402a
DataPtr_CourtComplexSceneUnusedSlot:
	dw CourtComplexSceneUnusedSlot ; $402c
DataPtr_CourtComplexTiles:
	dw CourtComplexTiles ; $402e
FountainCourtSceneConfig:
	INCBIN "data/bank_067/d_4030.bin" ; $4030, 27 bytes
FountainCourtPalettes:
	; $404b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $0220, $7d9f, $7fff, $1006 ; pal 2: #008b00 #ff62ff #ffffff #310020
	dw $0220, $0310, $7fff, $1006 ; pal 3: #008b00 #83c500 #ffffff #310020
	dw $0220, $4611, $7fff, $1006 ; pal 4: #008b00 #8b838b #ffffff #310020
	dw $021a, $0310, $0220, $1006 ; pal 5: #d58300 #83c500 #008b00 #310020
	dw $021a, $0288, $7fff, $1006 ; pal 6: #d58300 #41a400 #ffffff #310020
	dw $4611, $7f40, $7fff, $1006 ; pal 7: #8b838b #00d5ff #ffffff #310020
FountainCourtTiles:
	INCBIN "data/bank_067/lz_408b.bin" ; $408b, 3052 bytes
FountainCourtTilemap:
	INCBIN "data/bank_067/lz_4c77.bin" ; $4c77, 1101 bytes
FountainCourtAttrmap:
	INCBIN "data/bank_067/lz_50c4.bin" ; $50c4, 689 bytes
FountainCourtAuxTilemap:
	INCBIN "data/bank_067/lz_5375.bin" ; $5375, 106 bytes
FountainCourtAuxAttrmap:
	INCBIN "data/bank_067/lz_53df.bin" ; $53df, 83 bytes
	; $5432, 14 bytes (fill)
	ds 14, $00
FountainCourtSceneUnusedSlot:
	INCBIN "data/bank_067/d_5440.bin" ; $5440, 1536 bytes
CafeCourtSceneConfig:
	INCBIN "data/bank_067/d_5a40.bin" ; $5a40, 42 bytes
CafeCourtPalettes:
	; $5a6a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0000, $0000 ; pal 1: #004a00 #ffffff #000000 #000000
	dw $0220, $7d9f, $7fff, $1006 ; pal 2: #008b00 #ff62ff #ffffff #310020
	dw $0220, $0310, $7fff, $1006 ; pal 3: #008b00 #83c500 #ffffff #310020
	dw $0220, $0310, $021a, $1006 ; pal 4: #008b00 #83c500 #d58300 #310020
	dw $0220, $7fff, $4611, $1006 ; pal 5: #008b00 #ffffff #8b838b #310020
	dw $021a, $0288, $7fff, $1006 ; pal 6: #d58300 #41a400 #ffffff #310020
	dw $0220, $7f00, $7fff, $1006 ; pal 7: #008b00 #00c5ff #ffffff #310020
CafeCourtTiles:
	INCBIN "data/bank_067/lz_5aaa.bin" ; $5aaa, 2357 bytes
CafeCourtTilemap:
	INCBIN "data/bank_067/lz_63df.bin" ; $63df, 922 bytes
CafeCourtAttrmap:
	INCBIN "data/bank_067/lz_6779.bin" ; $6779, 569 bytes
CafeCourtAuxTilemap:
	INCBIN "data/bank_067/lz_69b2.bin" ; $69b2, 103 bytes
CafeCourtAuxAttrmap:
	INCBIN "data/bank_067/lz_6a19.bin" ; $6a19, 75 bytes
CourtComplexSceneConfig:
	INCBIN "data/bank_067/d_6a64.bin" ; $6a64, 42 bytes
CourtComplexPalettes:
	; $6a8e, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0080, $5520, $7ea0, $4460 ; pal 0: #002000 #004aac #00acff #00188b
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $195c, $0330, $7fff, $1006 ; pal 2: #e65231 #83cd00 #ffffff #310020
	dw $0260, $0330, $7fff, $1006 ; pal 3: #009c00 #83cd00 #ffffff #310020
	dw $025d, $0330, $0260, $1006 ; pal 4: #ee9400 #83cd00 #009c00 #310020
	dw $7f60, $0260, $7fff, $1006 ; pal 5: #00deff #009c00 #ffffff #310020
	dw $025d, $7fff, $3def, $1006 ; pal 6: #ee9400 #ffffff #7b7b7b #310020
	dw $7e20, $01bf, $0260, $7fff ; pal 7: #008bff #ff6a00 #009c00 #ffffff
CourtComplexTiles:
	INCBIN "data/bank_067/lz_6ace.bin" ; $6ace, 2316 bytes
CourtComplexTilemap:
	INCBIN "data/bank_067/lz_73da.bin" ; $73da, 1330 bytes
CourtComplexAttrmap:
	INCBIN "data/bank_067/lz_790c.bin" ; $790c, 710 bytes
CourtComplexAuxTilemap:
	INCBIN "data/bank_067/lz_7bd2.bin" ; $7bd2, 128 bytes
CourtComplexAuxAttrmap:
	INCBIN "data/bank_067/lz_7c52.bin" ; $7c52, 76 bytes
CourtComplexSceneUnusedSlot:
	; $7c9e, 866 bytes fill to bank end (linker-padded)
