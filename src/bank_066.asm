SECTION "ROM Bank $66", ROMX[$4000], BANK[$66]

DataPtr_HardCourtGroundsSceneConfig:
	dw HardCourtGroundsSceneConfig ; $4000
DataPtr_HardCourtGroundsPalettes:
	dw HardCourtGroundsPalettes ; $4002
DataPtr_HardCourtGroundsTilemap:
	dw HardCourtGroundsTilemap ; $4004
DataPtr_HardCourtGroundsAttrmap:
	dw HardCourtGroundsAttrmap ; $4006
DataPtr_HardCourtGroundsAuxTilemap:
	dw HardCourtGroundsAuxTilemap ; $4008
DataPtr_HardCourtGroundsAuxAttrmap:
	dw HardCourtGroundsAuxAttrmap ; $400a
DataPtr_SpaResortSceneConfig:
	dw SpaResortSceneConfig ; $400c
DataPtr_HardCourtGroundsTiles:
	dw HardCourtGroundsTiles ; $400e
DataPtr_SpaResortSceneConfigAlias1:
	dw SpaResortSceneConfig ; $4010
DataPtr_SpaResortPalettes:
	dw SpaResortPalettes ; $4012
DataPtr_SpaResortTilemap:
	dw SpaResortTilemap ; $4014
DataPtr_SpaResortAttrmap:
	dw SpaResortAttrmap ; $4016
DataPtr_SpaResortAuxTilemap:
	dw SpaResortAuxTilemap ; $4018
DataPtr_SpaResortAuxAttrmap:
	dw SpaResortAuxAttrmap ; $401a
DataPtr_MainBuildingSceneConfig:
	dw MainBuildingSceneConfig ; $401c
DataPtr_SpaResortTiles:
	dw SpaResortTiles ; $401e
DataPtr_MainBuildingSceneConfigAlias1:
	dw MainBuildingSceneConfig ; $4020
DataPtr_MainBuildingPalettes:
	dw MainBuildingPalettes ; $4022
DataPtr_MainBuildingTilemap:
	dw MainBuildingTilemap ; $4024
DataPtr_MainBuildingAttrmap:
	dw MainBuildingAttrmap ; $4026
DataPtr_MainBuildingAuxTilemap:
	dw MainBuildingAuxTilemap ; $4028
DataPtr_MainBuildingAuxAttrmap:
	dw MainBuildingAuxAttrmap ; $402a
DataPtr_GardenPavilionSceneConfig:
	dw GardenPavilionSceneConfig ; $402c
DataPtr_MainBuildingTiles:
	dw MainBuildingTiles ; $402e
DataPtr_GardenPavilionSceneConfigAlias1:
	dw GardenPavilionSceneConfig ; $4030
DataPtr_GardenPavilionPalettes:
	dw GardenPavilionPalettes ; $4032
DataPtr_GardenPavilionTilemap:
	dw GardenPavilionTilemap ; $4034
DataPtr_GardenPavilionAttrmap:
	dw GardenPavilionAttrmap ; $4036
DataPtr_GardenPavilionAuxTilemap:
	dw GardenPavilionAuxTilemap ; $4038
DataPtr_GardenPavilionAuxAttrmap:
	dw GardenPavilionAuxAttrmap ; $403a
DataPtr_GardenPavilionSceneUnusedSlot:
	dw GardenPavilionSceneUnusedSlot ; $403c
DataPtr_GardenPavilionTiles:
	dw GardenPavilionTiles ; $403e
HardCourtGroundsSceneConfig:
	INCBIN "data/bank_066/d_4040.bin" ; $4040, 42 bytes
HardCourtGroundsPalettes:
	; $406a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0080, $5520, $7ea0, $2cb7 ; pal 0: #002000 #004aac #00acff #bd295a
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $7ef0, $0214, $781f, $781f ; pal 2: #83bdff #a48300 #ff00f6 #ff00f6
	dw $0220, $02d0, $7fff, $1006 ; pal 3: #008b00 #83b400 #ffffff #310020
	dw $021a, $02d0, $0220, $1006 ; pal 4: #d58300 #83b400 #008b00 #310020
	dw $7ef0, $7e28, $7fff, $1006 ; pal 5: #83bdff #418bff #ffffff #310020
	dw $0214, $7fff, $3e93, $1006 ; pal 6: #a48300 #ffffff #9ca47b #310020
	dw $7ef0, $7fff, $3def, $1006 ; pal 7: #83bdff #ffffff #7b7b7b #310020
HardCourtGroundsTiles:
	INCBIN "data/bank_066/lz_40aa.bin" ; $40aa, 1292 bytes
HardCourtGroundsTilemap:
	INCBIN "data/bank_066/lz_45b6.bin" ; $45b6, 1012 bytes
HardCourtGroundsAttrmap:
	INCBIN "data/bank_066/lz_49aa.bin" ; $49aa, 760 bytes
HardCourtGroundsAuxTilemap:
	INCBIN "data/bank_066/lz_4ca2.bin" ; $4ca2, 101 bytes
HardCourtGroundsAuxAttrmap:
	INCBIN "data/bank_066/lz_4d07.bin" ; $4d07, 72 bytes
SpaResortSceneConfig:
	INCBIN "data/bank_066/d_4d4f.bin" ; $4d4f, 42 bytes
SpaResortPalettes:
	; $4d79, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $3d60, $0000, $35ad, $4e94 ; pal 0: #005a7b #000000 #6a6a6a #a4a49c
	dw $7c1f, $7c1f, $7c1f, $7c1f ; pal 1: #ff00ff #ff00ff #ff00ff #ff00ff
	dw $7fff, $7f10, $5e09, $3924 ; pal 2: #ffffff #83c5ff #4a83bd #204a73
	dw $019f, $7fff, $7de0, $208c ; pal 3: #ff6200 #ffffff #007bff #622041
	dw $285d, $7fff, $02c0, $208c ; pal 4: #ee1052 #ffffff #00b400 #622041
	dw $7fff, $5a5f, $415b, $2cb5 ; pal 5: #ffffff #ff94b4 #de5283 #ac295a
	dw $7fe0, $7fff, $5eb7, $356d ; pal 6: #00ffff #ffffff #bdacbd #6a5a6a
	dw $7fff, $36ba, $1db1, $0cc9 ; pal 7: #ffffff #d5ac6a #8b6a39 #4a3118
SpaResortTiles:
	INCBIN "data/bank_066/lz_4db9.bin" ; $4db9, 2034 bytes
SpaResortTilemap:
	INCBIN "data/bank_066/lz_55ab.bin" ; $55ab, 1086 bytes
SpaResortAttrmap:
	INCBIN "data/bank_066/lz_59e9.bin" ; $59e9, 675 bytes
SpaResortAuxTilemap:
	INCBIN "data/bank_066/lz_5c8c.bin" ; $5c8c, 118 bytes
SpaResortAuxAttrmap:
	INCBIN "data/bank_066/lz_5d02.bin" ; $5d02, 128 bytes
MainBuildingSceneConfig:
	INCBIN "data/bank_066/d_5d82.bin" ; $5d82, 9 bytes
MainBuildingPalettes:
	; $5d8b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7ce0, $5520, $7ea0, $3400 ; pal 0: #0039ff #004aac #00acff #00006a
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $781f, $781f, $781f, $781f ; pal 2: #ff00f6 #ff00f6 #ff00f6 #ff00f6
	dw $0220, $02d0, $7fff, $1006 ; pal 3: #008b00 #83b400 #ffffff #310020
	dw $021a, $02d0, $0220, $1006 ; pal 4: #d58300 #83b400 #008b00 #310020
	dw $0220, $7fff, $4631, $1006 ; pal 5: #008b00 #ffffff #8b8b8b #310020
	dw $0220, $011f, $7fff, $1006 ; pal 6: #008b00 #ff4100 #ffffff #310020
	dw $7e40, $3236, $7fff, $1006 ; pal 7: #0094ff #b48b62 #ffffff #310020
MainBuildingTiles:
	INCBIN "data/bank_066/lz_5dcb.bin" ; $5dcb, 2301 bytes
MainBuildingTilemap:
	INCBIN "data/bank_066/lz_66c8.bin" ; $66c8, 1096 bytes
MainBuildingAttrmap:
	INCBIN "data/bank_066/lz_6b10.bin" ; $6b10, 572 bytes
MainBuildingAuxTilemap:
	INCBIN "data/bank_066/lz_6d4c.bin" ; $6d4c, 97 bytes
MainBuildingAuxAttrmap:
	INCBIN "data/bank_066/lz_6dad.bin" ; $6dad, 75 bytes
GardenPavilionSceneConfig:
	INCBIN "data/bank_066/d_6df8.bin" ; $6df8, 42 bytes
GardenPavilionPalettes:
	; $6e22, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0080, $5520, $7ea0, $00e0 ; pal 0: #002000 #004aac #00acff #003900
	dw $2508, $2508, $2508, $2508 ; pal 1: #41414a #41414a #41414a #41414a
	dw $0220, $019f, $7fff, $1006 ; pal 2: #008b00 #ff6200 #ffffff #310020
	dw $0220, $02d0, $7fff, $1006 ; pal 3: #008b00 #83b400 #ffffff #310020
	dw $021a, $02d0, $0220, $1006 ; pal 4: #d58300 #83b400 #008b00 #310020
	dw $0220, $7fff, $4631, $1006 ; pal 5: #008b00 #ffffff #8b8b8b #310020
	dw $599f, $1c12, $7fff, $1006 ; pal 6: #ff62b4 #940039 #ffffff #310020
	dw $7fe4, $3236, $7fff, $1006 ; pal 7: #20ffff #b48b62 #ffffff #310020
GardenPavilionTiles:
	INCBIN "data/bank_066/lz_6e62.bin" ; $6e62, 1916 bytes
GardenPavilionTilemap:
	INCBIN "data/bank_066/lz_75de.bin" ; $75de, 971 bytes
GardenPavilionAttrmap:
	INCBIN "data/bank_066/lz_79a9.bin" ; $79a9, 474 bytes
GardenPavilionAuxTilemap:
	INCBIN "data/bank_066/lz_7b83.bin" ; $7b83, 95 bytes
GardenPavilionAuxAttrmap:
	INCBIN "data/bank_066/lz_7be2.bin" ; $7be2, 75 bytes
GardenPavilionSceneUnusedSlot:
	; $7c2d, 979 bytes fill to bank end (linker-padded)
