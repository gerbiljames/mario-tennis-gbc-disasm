SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

DataPtr_DormBedroomSceneConfig:
	dw DormBedroomSceneConfig ; $4000
DataPtr_DormBedroomPalettes:
	dw DormBedroomPalettes ; $4002
DataPtr_DormBedroomTilemap:
	dw DormBedroomTilemap ; $4004
DataPtr_DormBedroomAttrmap:
	dw DormBedroomAttrmap ; $4006
DataPtr_DormBedroomAuxTilemap:
	dw DormBedroomAuxTilemap ; $4008
DataPtr_DormBedroomAuxAttrmap:
	dw DormBedroomAuxAttrmap ; $400a
DataPtr_CountrysideSceneConfig:
	dw CountrysideSceneConfig ; $400c
DataPtr_DormBedroomTiles:
	dw DormBedroomTiles ; $400e
DataPtr_CountrysideSceneConfigAlias1:
	dw CountrysideSceneConfig ; $4010
DataPtr_CountrysidePalettes:
	dw CountrysidePalettes ; $4012
DataPtr_CountrysideTilemap:
	dw CountrysideTilemap ; $4014
DataPtr_CountrysideAttrmap:
	dw CountrysideAttrmap ; $4016
DataPtr_CountrysideAuxTilemap:
	dw CountrysideAuxTilemap ; $4018
DataPtr_CountrysideAuxAttrmap:
	dw CountrysideAuxAttrmap ; $401a
DataPtr_AcademyGroundsSceneConfig:
	dw AcademyGroundsSceneConfig ; $401c
DataPtr_CountrysideTiles:
	dw CountrysideTiles ; $401e
DataPtr_AcademyGroundsSceneConfigAlias1:
	dw AcademyGroundsSceneConfig ; $4020
DataPtr_AcademyGroundsPalettes:
	dw AcademyGroundsPalettes ; $4022
DataPtr_AcademyGroundsTilemap:
	dw AcademyGroundsTilemap ; $4024
DataPtr_AcademyGroundsAttrmap:
	dw AcademyGroundsAttrmap ; $4026
DataPtr_AcademyGroundsAuxTilemap:
	dw AcademyGroundsAuxTilemap ; $4028
DataPtr_AcademyGroundsAuxAttrmap:
	dw AcademyGroundsAuxAttrmap ; $402a
DataPtr_64_2c:
	dw Data_64_7730 ; $402c
DataPtr_AcademyGroundsTiles:
	dw AcademyGroundsTiles ; $402e
DormBedroomSceneConfig:
	INCBIN "data/bank_064/d_4030.bin" ; $4030, 42 bytes
DormBedroomPalettes:
	; $405a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0160, $5520, $7ea0, $781f ; pal 0: #005a00 #004aac #00acff #ff00f6
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $7fff, $311a, $6988, $1882 ; pal 2: #ffffff #d54162 #4162d5 #102031
	dw $7fff, $5a70, $3547, $1882 ; pal 3: #ffffff #839cb4 #39526a #102031
	dw $285d, $7fff, $1ee4, $10c1 ; pal 4: #ee1052 #ffffff #20bd39 #083120
	dw $7f35, $6e0c, $5525, $2c81 ; pal 5: #accdff #6283de #294aac #08205a
	dw $629f, $419b, $24b5, $102b ; pal 6: #ffa4c5 #de6283 #ac294a #5a0820
	dw $679f, $4276, $216e, $0487 ; pal 7: #ffe6cd #b49c83 #735a41 #392008
DormBedroomTiles:
	INCBIN "data/bank_064/lz_409a.bin" ; $409a, 2307 bytes
DormBedroomTilemap:
	INCBIN "data/bank_064/lz_499d.bin" ; $499d, 706 bytes
DormBedroomAttrmap:
	INCBIN "data/bank_064/lz_4c5f.bin" ; $4c5f, 511 bytes
DormBedroomAuxTilemap:
	INCBIN "data/bank_064/lz_4e5e.bin" ; $4e5e, 118 bytes
DormBedroomAuxAttrmap:
	INCBIN "data/bank_064/lz_4ed4.bin" ; $4ed4, 72 bytes
CountrysideSceneConfig:
	INCBIN "data/bank_064/d_4f1c.bin" ; $4f1c, 42 bytes
CountrysidePalettes:
	; $4f46, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $09ea, $5520, $7ea0, $7fff ; pal 0: #527b10 #004aac #00acff #ffffff
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $0300, $0118, $039f, $3088 ; pal 2: #00c500 #c54100 #ffe600 #412062
	dw $3bf2, $7fe8, $0300, $3088 ; pal 3: #94ff73 #41ffff #00c500 #412062
	dw $039f, $0118, $025f, $3088 ; pal 4: #ffe600 #c54100 #ff9400 #412062
	dw $7fff, $3088, $4631, $0300 ; pal 5: #ffffff #412062 #8b8b8b #00c500
	dw $7fe8, $7fff, $011f, $3088 ; pal 6: #41ffff #ffffff #ff4100 #412062
	dw $2508, $2508, $2508, $2508 ; pal 7: #41414a #41414a #41414a #41414a
CountrysideTiles:
	INCBIN "data/bank_064/lz_4f86.bin" ; $4f86, 3238 bytes
CountrysideTilemap:
	INCBIN "data/bank_064/lz_5c2c.bin" ; $5c2c, 802 bytes
CountrysideAttrmap:
	INCBIN "data/bank_064/lz_5f4e.bin" ; $5f4e, 411 bytes
CountrysideAuxTilemap:
	INCBIN "data/bank_064/lz_60e9.bin" ; $60e9, 80 bytes
CountrysideAuxAttrmap:
	INCBIN "data/bank_064/lz_6139.bin" ; $6139, 90 bytes
AcademyGroundsSceneConfig:
	INCBIN "data/bank_064/d_6193.bin" ; $6193, 27 bytes
AcademyGroundsPalettes:
	; $61ae, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $3240, $4b80, $7fff, $1006 ; pal 2: #009462 #00e694 #ffffff #310020
	dw $0220, $02d0, $7fff, $1006 ; pal 3: #008b00 #83b400 #ffffff #310020
	dw $021a, $02d0, $0220, $1006 ; pal 4: #d58300 #83b400 #008b00 #310020
	dw $0220, $7fff, $4210, $1006 ; pal 5: #008b00 #ffffff #838383 #310020
	dw $0220, $7c1f, $7fff, $1006 ; pal 6: #008b00 #ff00ff #ffffff #310020
	dw $7ec0, $3def, $7fff, $1006 ; pal 7: #00b4ff #7b7b7b #ffffff #310020
AcademyGroundsTiles:
	INCBIN "data/bank_064/lz_61ee.bin" ; $61ee, 3100 bytes
AcademyGroundsTilemap:
	INCBIN "data/bank_064/lz_6e0a.bin" ; $6e0a, 1429 bytes
AcademyGroundsAttrmap:
	INCBIN "data/bank_064/lz_739f.bin" ; $739f, 679 bytes
AcademyGroundsAuxTilemap:
	INCBIN "data/bank_064/lz_7646.bin" ; $7646, 147 bytes
AcademyGroundsAuxAttrmap:
	INCBIN "data/bank_064/lz_76d9.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
Data_64_7730:
	INCBIN "data/bank_064/d_7730.bin" ; $7730, 2256 bytes
