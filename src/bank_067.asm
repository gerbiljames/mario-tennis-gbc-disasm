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
DataPtr_67_0c:
	dw Data_67_5440 ; $400c
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
DataPtr_67_2c:
	dw Data_67_7c9e ; $402c
DataPtr_CourtComplexTiles:
	dw CourtComplexTiles ; $402e
FountainCourtSceneConfig:
	INCBIN "data/bank_067/d_4030.bin" ; $4030, 27 bytes
FountainCourtPalettes:
	INCBIN "data/bank_067/d_404b.bin" ; $404b, 64 bytes
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
Data_67_5440:
	INCBIN "data/bank_067/d_5440.bin" ; $5440, 1536 bytes
CafeCourtSceneConfig:
	INCBIN "data/bank_067/d_5a40.bin" ; $5a40, 42 bytes
CafeCourtPalettes:
	INCBIN "data/bank_067/d_5a6a.bin" ; $5a6a, 64 bytes
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
	INCBIN "data/bank_067/d_6a8e.bin" ; $6a8e, 64 bytes
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
Data_67_7c9e:
	INCBIN "data/bank_067/d_7c9e.bin" ; $7c9e, 866 bytes
