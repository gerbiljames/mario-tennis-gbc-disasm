SECTION "ROM Bank $61", ROMX[$4000], BANK[$61]

DataPtr_MachineCourtSceneConfig:
	dw MachineCourtSceneConfig ; $4000
DataPtr_MachineCourtPalettes:
	dw MachineCourtPalettes ; $4002
DataPtr_MachineCourtTilemap:
	dw MachineCourtTilemap ; $4004
DataPtr_MachineCourtAttrmap:
	dw MachineCourtAttrmap ; $4006
DataPtr_MachineCourtSceneConfigAlias1:
	dw MachineCourtSceneConfig ; $4008
DataPtr_MachineCourtSceneConfigB:
	dw MachineCourtSceneConfigB ; $400a
DataPtr_CenterCourtPalettes:
	dw CenterCourtPalettes ; $400c
DataPtr_MachineCourtTiles:
	dw MachineCourtTiles ; $400e
DataPtr_CenterCourtSceneConfig:
	dw CenterCourtSceneConfig ; $4010
DataPtr_CenterCourtPalettesAlias1:
	dw CenterCourtPalettes ; $4012
DataPtr_CenterCourtTilemap:
	dw CenterCourtTilemap ; $4014
DataPtr_CenterCourtAttrmap:
	dw CenterCourtAttrmap ; $4016
DataPtr_CenterCourtSceneConfigAlias1:
	dw CenterCourtSceneConfig ; $4018
DataPtr_CenterCourtSceneConfigB:
	dw CenterCourtSceneConfigB ; $401a
DataPtr_PracticeCourtPalettes:
	dw PracticeCourtPalettes ; $401c
DataPtr_CenterCourtTiles:
	dw CenterCourtTiles ; $401e
DataPtr_PracticeCourtSceneConfig:
	dw PracticeCourtSceneConfig ; $4020
DataPtr_PracticeCourtPalettesAlias1:
	dw PracticeCourtPalettes ; $4022
DataPtr_PracticeCourtTilemap:
	dw PracticeCourtTilemap ; $4024
DataPtr_PracticeCourtAttrmap:
	dw PracticeCourtAttrmap ; $4026
DataPtr_PracticeCourtSceneConfigAlias1:
	dw PracticeCourtSceneConfig ; $4028
DataPtr_PracticeCourtSceneConfigB:
	dw PracticeCourtSceneConfigB ; $402a
DataPtr_YoshiCourtPalettes:
	dw YoshiCourtPalettes ; $402c
DataPtr_PracticeCourtTiles:
	dw PracticeCourtTiles ; $402e
DataPtr_YoshiCourtSceneConfig:
	dw YoshiCourtSceneConfig ; $4030
DataPtr_YoshiCourtPalettesAlias1:
	dw YoshiCourtPalettes ; $4032
DataPtr_YoshiCourtTilemap:
	dw YoshiCourtTilemap ; $4034
DataPtr_YoshiCourtAttrmap:
	dw YoshiCourtAttrmap ; $4036
DataPtr_YoshiCourtSceneConfigAlias1:
	dw YoshiCourtSceneConfig ; $4038
DataPtr_YoshiCourtSceneConfigB:
	dw YoshiCourtSceneConfigB ; $403a
DataPtr_61_3c:
	dw Data_61_7a97 ; $403c
DataPtr_YoshiCourtTiles:
	dw YoshiCourtTiles ; $403e
MachineCourtPalettes:
	; $4040, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $7f4b, $025f, $7fff, $28a0 ; pal 2: #5ad5ff #ff9400 #ffffff #002952
	dw $7f4b, $309f, $7fff, $28a0 ; pal 3: #5ad5ff #ff2062 #ffffff #002952
	dw $7286, $309f, $7fff, $28a0 ; pal 4: #31a4e6 #ff2062 #ffffff #002952
	dw $7286, $7f4b, $7fff, $28a0 ; pal 5: #31a4e6 #5ad5ff #ffffff #002952
	dw $7286, $025f, $7fff, $28a0 ; pal 6: #31a4e6 #ff9400 #ffffff #002952
	dw $7fff, $3f80, $2ea0, $21e0 ; pal 7: #ffffff #00e67b #00ac5a #007b41
MachineCourtTiles:
	INCBIN "data/bank_061/lz_4080.bin" ; $4080, 2350 bytes
MachineCourtTilemap:
	INCBIN "data/bank_061/lz_49ae.bin" ; $49ae, 461 bytes
MachineCourtAttrmap:
	INCBIN "data/bank_061/lz_4b7b.bin" ; $4b7b, 158 bytes
MachineCourtSceneConfig:
	INCBIN "data/bank_061/d_4c19.bin" ; $4c19, 40 bytes
MachineCourtSceneConfigB:
	INCBIN "data/bank_061/d_4c41.bin" ; $4c41, 40 bytes
CenterCourtPalettes:
	; $4c69, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $2300, $2be0, $7fff, $3bf2 ; pal 2: #00c541 #00ff52 #ffffff #94ff73
	dw $2300, $025f, $7fff, $3105 ; pal 3: #00c541 #ff9400 #ffffff #294162
	dw $2300, $1a41, $7fff, $2b6e ; pal 4: #00c541 #089431 #ffffff #73de52
	dw $2300, $1a41, $7fff, $2880 ; pal 5: #00c541 #089431 #ffffff #002052
	dw $1582, $1a41, $7fff, $1aea ; pal 6: #106229 #089431 #ffffff #52bd31
	dw $7c44, $7fb9, $4da8, $34c1 ; pal 7: #2010ff #cdeeff #416a9c #08316a
CenterCourtTiles:
	INCBIN "data/bank_061/lz_4ca9.bin" ; $4ca9, 3057 bytes
CenterCourtTilemap:
	INCBIN "data/bank_061/lz_589a.bin" ; $589a, 596 bytes
CenterCourtAttrmap:
	INCBIN "data/bank_061/lz_5aee.bin" ; $5aee, 269 bytes
CenterCourtSceneConfig:
	INCBIN "data/bank_061/d_5bfb.bin" ; $5bfb, 40 bytes
CenterCourtSceneConfigB:
	INCBIN "data/bank_061/d_5c23.bin" ; $5c23, 40 bytes
PracticeCourtPalettes:
	; $5c4b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $7e80, $02e0, $7fff, $0904 ; pal 2: #00a4ff #00bd00 #ffffff #204110
	dw $47e7, $3b45, $32c3, $7fff ; pal 3: #39ff8b #29d573 #18b462 #ffffff
	dw $3b45, $0000, $4b1f, $609f ; pal 4: #29d573 #000000 #ffc594 #ff20c5
	dw $32c3, $3b45, $7fff, $2066 ; pal 5: #18b462 #29d573 #ffffff #311841
	dw $21a0, $2a21, $32c3, $7fff ; pal 6: #006a41 #088b52 #18b462 #ffffff
	dw $02e0, $4672, $7fff, $0904 ; pal 7: #00bd00 #949c8b #ffffff #204110
PracticeCourtTiles:
	INCBIN "data/bank_061/lz_5c8b.bin" ; $5c8b, 2761 bytes
PracticeCourtTilemap:
	INCBIN "data/bank_061/lz_6754.bin" ; $6754, 547 bytes
PracticeCourtAttrmap:
	INCBIN "data/bank_061/lz_6977.bin" ; $6977, 132 bytes
PracticeCourtSceneConfig:
	INCBIN "data/bank_061/d_69fb.bin" ; $69fb, 40 bytes
PracticeCourtSceneConfigB:
	INCBIN "data/bank_061/d_6a23.bin" ; $6a23, 40 bytes
YoshiCourtPalettes:
	; $6a4b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $02e7, $28c0, $47e0, $03ab ; pal 2: #39bd00 #003152 #00ff8b #5aee00
	dw $02e7, $7fff, $01df, $00ca ; pal 3: #39bd00 #ffffff #ff7300 #523100
	dw $021f, $03ab, $7fff, $00ce ; pal 4: #ff8300 #5aee00 #ffffff #733100
	dw $02e7, $03ab, $7fff, $1500 ; pal 5: #39bd00 #5aee00 #ffffff #004129
	dw $02e7, $001f, $7fff, $00ca ; pal 6: #39bd00 #ff0000 #ffffff #523100
	dw $02e7, $0244, $7fff, $03ab ; pal 7: #39bd00 #209400 #ffffff #5aee00
YoshiCourtTiles:
	INCBIN "data/bank_061/lz_6a8b.bin" ; $6a8b, 3003 bytes
YoshiCourtTilemap:
	INCBIN "data/bank_061/lz_7646.bin" ; $7646, 708 bytes
YoshiCourtAttrmap:
	INCBIN "data/bank_061/lz_790a.bin" ; $790a, 317 bytes
YoshiCourtSceneConfig:
	INCBIN "data/bank_061/d_7a47.bin" ; $7a47, 40 bytes
YoshiCourtSceneConfigB:
	INCBIN "data/bank_061/d_7a6f.bin" ; $7a6f, 40 bytes
Data_61_7a97:
	ds 1385, $ff ; $7a97, fill
