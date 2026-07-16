SECTION "ROM Bank $65", ROMX[$4000], BANK[$65]

DataPtr_SeasideSceneConfig:
	dw SeasideSceneConfig ; $4000
DataPtr_SeasidePalettes:
	dw SeasidePalettes ; $4002
DataPtr_SeasideTilemap:
	dw SeasideTilemap ; $4004
DataPtr_SeasideAttrmap:
	dw SeasideAttrmap ; $4006
DataPtr_SeasideAuxTilemap:
	dw SeasideAuxTilemap ; $4008
DataPtr_SeasideAuxAttrmap:
	dw SeasideAuxAttrmap ; $400a
DataPtr_65_0c:
	dw Data_65_5120 ; $400c
DataPtr_SeasideTiles:
	dw SeasideTiles ; $400e
DataPtr_HedgeCourtSceneConfig:
	dw HedgeCourtSceneConfig ; $4010
DataPtr_HedgeCourtPalettes:
	dw HedgeCourtPalettes ; $4012
DataPtr_HedgeCourtTilemap:
	dw HedgeCourtTilemap ; $4014
DataPtr_HedgeCourtAttrmap:
	dw HedgeCourtAttrmap ; $4016
DataPtr_HedgeCourtAuxTilemap:
	dw HedgeCourtAuxTilemap ; $4018
DataPtr_HedgeCourtAuxAttrmap:
	dw HedgeCourtAuxAttrmap ; $401a
DataPtr_65_1c:
	dw Data_65_6500 ; $401c
DataPtr_HedgeCourtTiles:
	dw HedgeCourtTiles ; $401e
DataPtr_ClayCourtGroundsSceneConfig:
	dw ClayCourtGroundsSceneConfig ; $4020
DataPtr_ClayCourtGroundsPalettes:
	dw ClayCourtGroundsPalettes ; $4022
DataPtr_ClayCourtGroundsTilemap:
	dw ClayCourtGroundsTilemap ; $4024
DataPtr_ClayCourtGroundsAttrmap:
	dw ClayCourtGroundsAttrmap ; $4026
DataPtr_ClayCourtGroundsAuxTilemap:
	dw ClayCourtGroundsAuxTilemap ; $4028
DataPtr_ClayCourtGroundsAuxAttrmap:
	dw ClayCourtGroundsAuxAttrmap ; $402a
DataPtr_65_2c:
	dw Data_65_7d56 ; $402c
DataPtr_ClayCourtGroundsTiles:
	dw ClayCourtGroundsTiles ; $402e
SeasideSceneConfig:
	INCBIN "data/bank_065/d_4030.bin" ; $4030, 27 bytes
SeasidePalettes:
	INCBIN "data/bank_065/d_404b.bin" ; $404b, 64 bytes
SeasideTiles:
	INCBIN "data/bank_065/lz_408b.bin" ; $408b, 2987 bytes
SeasideTilemap:
	INCBIN "data/bank_065/lz_4c36.bin" ; $4c36, 684 bytes
SeasideAttrmap:
	INCBIN "data/bank_065/lz_4ee2.bin" ; $4ee2, 416 bytes
SeasideAuxTilemap:
	INCBIN "data/bank_065/lz_5082.bin" ; $5082, 70 bytes
SeasideAuxAttrmap:
	INCBIN "data/bank_065/lz_50c8.bin" ; $50c8, 73 bytes
	; $5111, 15 bytes (fill)
	ds 15, $00
Data_65_5120:
	INCBIN "data/bank_065/d_5120.bin" ; $5120, 1536 bytes
HedgeCourtSceneConfig:
	INCBIN "data/bank_065/d_5720.bin" ; $5720, 23 bytes
HedgeCourtPalettes:
	; $5737, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0080, $5520, $7ea0, $4460 ; pal 0: #002000 #004aac #00acff #00188b
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $02c0, $005f, $7d80, $029f ; pal 2: #00b400 #ff1000 #0062ff #ffa400
	dw $7c1f, $7c1f, $7c1f, $7c1f ; pal 3: #ff00ff #ff00ff #ff00ff #ff00ff
	dw $01bf, $03f8, $02c0, $08ca ; pal 4: #ff6a00 #c5ff00 #00b400 #523110
	dw $7f80, $02c0, $7fff, $08ca ; pal 5: #00e6ff #00b400 #ffffff #523110
	dw $02c0, $7fff, $4a52, $08ca ; pal 6: #00b400 #ffffff #949494 #523110
	dw $7fff, $029f, $699f, $08ca ; pal 7: #ffffff #ffa400 #ff62d5 #523110
HedgeCourtTiles:
	INCBIN "data/bank_065/lz_5777.bin" ; $5777, 1897 bytes
HedgeCourtTilemap:
	INCBIN "data/bank_065/lz_5ee0.bin" ; $5ee0, 905 bytes
HedgeCourtAttrmap:
	INCBIN "data/bank_065/lz_6269.bin" ; $6269, 517 bytes
HedgeCourtAuxTilemap:
	INCBIN "data/bank_065/lz_646e.bin" ; $646e, 70 bytes
HedgeCourtAuxAttrmap:
	INCBIN "data/bank_065/lz_64b4.bin" ; $64b4, 70 bytes
	; $64fa, 6 bytes (fill)
	ds 6, $00
Data_65_6500:
	INCBIN "data/bank_065/d_6500.bin" ; $6500, 1536 bytes
ClayCourtGroundsSceneConfig:
	INCBIN "data/bank_065/d_6b00.bin" ; $6b00, 42 bytes
ClayCourtGroundsPalettes:
	; $6b2a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0080, $5520, $7ea0, $4460 ; pal 0: #002000 #004aac #00acff #00188b
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $025d, $7fff, $3def, $1006 ; pal 2: #ee9400 #ffffff #7b7b7b #310020
	dw $0220, $0310, $7fff, $1006 ; pal 3: #008b00 #83c500 #ffffff #310020
	dw $025d, $0310, $0220, $1006 ; pal 4: #ee9400 #83c500 #008b00 #310020
	dw $195c, $7fff, $025d, $1006 ; pal 5: #e65231 #ffffff #ee9400 #310020
	dw $7f60, $0220, $7fff, $1006 ; pal 6: #00deff #008b00 #ffffff #310020
	dw $7dff, $0220, $7fff, $1006 ; pal 7: #ff7bff #008b00 #ffffff #310020
ClayCourtGroundsTiles:
	INCBIN "data/bank_065/lz_6b6a.bin" ; $6b6a, 2286 bytes
ClayCourtGroundsTilemap:
	INCBIN "data/bank_065/lz_7458.bin" ; $7458, 1178 bytes
ClayCourtGroundsAttrmap:
	INCBIN "data/bank_065/lz_78f2.bin" ; $78f2, 933 bytes
ClayCourtGroundsAuxTilemap:
	INCBIN "data/bank_065/lz_7c97.bin" ; $7c97, 110 bytes
ClayCourtGroundsAuxAttrmap:
	INCBIN "data/bank_065/lz_7d05.bin" ; $7d05, 81 bytes
Data_65_7d56:
	ds 682, $ff ; $7d56, fill
