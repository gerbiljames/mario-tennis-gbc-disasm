SECTION "ROM Bank $69", ROMX[$4000], BANK[$69]

DataPtr_TrainingHallSceneConfig:
	dw TrainingHallSceneConfig ; $4000
DataPtr_TrainingHallPalettes:
	dw TrainingHallPalettes ; $4002
DataPtr_TrainingHallTilemap:
	dw TrainingHallTilemap ; $4004
DataPtr_TrainingHallAttrmap:
	dw TrainingHallAttrmap ; $4006
DataPtr_TrainingHallAuxTilemap:
	dw TrainingHallAuxTilemap ; $4008
DataPtr_TrainingHallAuxAttrmap:
	dw TrainingHallAuxAttrmap ; $400a
DataPtr_CenterCourtHallSceneConfig:
	dw CenterCourtHallSceneConfig ; $400c
DataPtr_TrainingHallTiles:
	dw TrainingHallTiles ; $400e
DataPtr_CenterCourtHallSceneConfigAlias1:
	dw CenterCourtHallSceneConfig ; $4010
DataPtr_CenterCourtHallPalettes:
	dw CenterCourtHallPalettes ; $4012
DataPtr_CenterCourtHallTilemap:
	dw CenterCourtHallTilemap ; $4014
DataPtr_CenterCourtHallAttrmap:
	dw CenterCourtHallAttrmap ; $4016
DataPtr_CenterCourtHallAuxTilemap:
	dw CenterCourtHallAuxTilemap ; $4018
DataPtr_CenterCourtHallAuxAttrmap:
	dw CenterCourtHallAuxAttrmap ; $401a
DataPtr_ClubroomInteriorSceneConfig:
	dw ClubroomInteriorSceneConfig ; $401c
DataPtr_CenterCourtHallTiles:
	dw CenterCourtHallTiles ; $401e
DataPtr_ClubroomInteriorSceneConfigAlias1:
	dw ClubroomInteriorSceneConfig ; $4020
DataPtr_ClubroomInteriorPalettes:
	dw ClubroomInteriorPalettes ; $4022
DataPtr_ClubroomInteriorTilemap:
	dw ClubroomInteriorTilemap ; $4024
DataPtr_ClubroomInteriorAttrmap:
	dw ClubroomInteriorAttrmap ; $4026
DataPtr_ClubroomInteriorAuxTilemap:
	dw ClubroomInteriorAuxTilemap ; $4028
DataPtr_ClubroomInteriorAuxAttrmap:
	dw ClubroomInteriorAuxAttrmap ; $402a
DataPtr_69_2c:
	dw Data_69_7660 ; $402c
DataPtr_ClubroomInteriorTiles:
	dw ClubroomInteriorTiles ; $402e
TrainingHallSceneConfig:
	INCBIN "data/bank_069/d_4030.bin" ; $4030, 42 bytes
TrainingHallPalettes:
	; $405a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $3d63, $0000, $35ad, $4e94 ; pal 0: #185a7b #000000 #6a6a6a #a4a49c
	dw $7c1f, $7c1f, $7c1f, $7c1f ; pal 1: #ff00ff #ff00ff #ff00ff #ff00ff
	dw $7fff, $5272, $7e80, $28a0 ; pal 2: #ffffff #949ca4 #00a4ff #002952
	dw $5f9f, $4297, $25af, $04a7 ; pal 3: #ffe6bd #bda483 #7b6a4a #392908
	dw $285d, $7fff, $1ee4, $10c1 ; pal 4: #ee1052 #ffffff #20bd39 #083120
	dw $7fff, $4b8f, $2a88, $1183 ; pal 5: #ffffff #7be694 #41a452 #186220
	dw $7f14, $6e4e, $5d88, $50e3 ; pal 6: #a4c5ff #7394de #4162bd #1839a4
	dw $7fff, $5272, $3569, $1860 ; pal 7: #ffffff #949ca4 #4a5a6a #001831
TrainingHallTiles:
	INCBIN "data/bank_069/lz_409a.bin" ; $409a, 3011 bytes
TrainingHallTilemap:
	INCBIN "data/bank_069/lz_4c5d.bin" ; $4c5d, 1214 bytes
TrainingHallAttrmap:
	INCBIN "data/bank_069/lz_511b.bin" ; $511b, 759 bytes
TrainingHallAuxTilemap:
	INCBIN "data/bank_069/lz_5412.bin" ; $5412, 129 bytes
TrainingHallAuxAttrmap:
	INCBIN "data/bank_069/lz_5493.bin" ; $5493, 129 bytes
CenterCourtHallSceneConfig:
	INCBIN "data/bank_069/d_5514.bin" ; $5514, 42 bytes
CenterCourtHallPalettes:
	; $553e, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $7fff, $36eb, $2628, $1584 ; pal 2: #ffffff #5abd6a #418b4a #206229
	dw $7fff, $7e69, $61c5, $4500 ; pal 3: #ffffff #4a9cff #2973c5 #00418b
	dw $309f, $7fff, $1344, $10c1 ; pal 4: #ff2062 #ffffff #20d520 #083120
	dw $7f14, $6e4e, $5d88, $50e3 ; pal 5: #a4c5ff #7394de #4162bd #1839a4
	dw $04a7, $4297, $25af, $5f9f ; pal 6: #392908 #bda483 #7b6a4a #ffe6bd
	dw $5675, $7fff, $3d6f, $1886 ; pal 7: #ac9cac #ffffff #7b5a7b #312031
CenterCourtHallTiles:
	INCBIN "data/bank_069/lz_557e.bin" ; $557e, 2082 bytes
CenterCourtHallTilemap:
	INCBIN "data/bank_069/lz_5da0.bin" ; $5da0, 991 bytes
CenterCourtHallAttrmap:
	INCBIN "data/bank_069/lz_617f.bin" ; $617f, 751 bytes
CenterCourtHallAuxTilemap:
	INCBIN "data/bank_069/lz_646e.bin" ; $646e, 125 bytes
CenterCourtHallAuxAttrmap:
	INCBIN "data/bank_069/lz_64eb.bin" ; $64eb, 87 bytes
ClubroomInteriorSceneConfig:
	INCBIN "data/bank_069/d_6542.bin" ; $6542, 27 bytes
ClubroomInteriorPalettes:
	; $655d, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $6bff, $001f, $021f, $0000 ; pal 2: #ffffd5 #ff0000 #ff8300 #000000
	dw $6bff, $0244, $7d8a, $0000 ; pal 3: #ffffd5 #209400 #5262ff #000000
	dw $021a, $0244, $6bff, $0000 ; pal 4: #d58300 #209400 #ffffd5 #000000
	dw $6bff, $0244, $7d3f, $0000 ; pal 5: #ffffd5 #209400 #ff4aff #000000
	dw $0244, $6bff, $4e53, $0000 ; pal 6: #209400 #ffffd5 #9c949c #000000
	dw $021a, $6bff, $4e53, $0000 ; pal 7: #d58300 #ffffd5 #9c949c #000000
ClubroomInteriorTiles:
	INCBIN "data/bank_069/lz_659d.bin" ; $659d, 2486 bytes
ClubroomInteriorTilemap:
	INCBIN "data/bank_069/lz_6f53.bin" ; $6f53, 999 bytes
ClubroomInteriorAttrmap:
	INCBIN "data/bank_069/lz_733a.bin" ; $733a, 647 bytes
ClubroomInteriorAuxTilemap:
	INCBIN "data/bank_069/lz_75c1.bin" ; $75c1, 84 bytes
ClubroomInteriorAuxAttrmap:
	INCBIN "data/bank_069/lz_7615.bin" ; $7615, 75 bytes
Data_69_7660:
	INCBIN "data/bank_069/d_7660.bin" ; $7660, 2464 bytes
