SECTION "ROM Bank $63", ROMX[$4000], BANK[$63]

DataPtr_IslandOpenCourtSceneConfig:
	dw IslandOpenCourtSceneConfig ; $4000
DataPtr_IslandOpenCourtPalettes:
	dw IslandOpenCourtPalettes ; $4002
DataPtr_IslandOpenCourtTilemap:
	dw IslandOpenCourtTilemap ; $4004
DataPtr_IslandOpenCourtAttrmap:
	dw IslandOpenCourtAttrmap ; $4006
DataPtr_IslandOpenCourtSceneConfigAlias1:
	dw IslandOpenCourtSceneConfig ; $4008
DataPtr_IslandOpenCourtSceneConfigB:
	dw IslandOpenCourtSceneConfigB ; $400a
DataPtr_DKCourtPalettes:
	dw DKCourtPalettes ; $400c
DataPtr_IslandOpenCourtTiles:
	dw IslandOpenCourtTiles ; $400e
DataPtr_DKCourtSceneConfig:
	dw DKCourtSceneConfig ; $4010
DataPtr_DKCourtPalettesAlias1:
	dw DKCourtPalettes ; $4012
DataPtr_DKCourtTilemap:
	dw DKCourtTilemap ; $4014
DataPtr_DKCourtAttrmap:
	dw DKCourtAttrmap ; $4016
DataPtr_DKCourtSceneConfigAlias1:
	dw DKCourtSceneConfig ; $4018
DataPtr_DKCourtSceneConfigB:
	dw DKCourtSceneConfigB ; $401a
DataPtr_StarPatternBgSceneConfig:
	dw StarPatternBgSceneConfig ; $401c
DataPtr_DKCourtTiles:
	dw DKCourtTiles ; $401e
DataPtr_StarPatternBgSceneConfigAlias1:
	dw StarPatternBgSceneConfig ; $4020
DataPtr_StarPatternBgPalettes:
	dw StarPatternBgPalettes ; $4022
DataPtr_StarPatternBgTilemap:
	dw StarPatternBgTilemap ; $4024
DataPtr_StarPatternBgAttrmap:
	dw StarPatternBgAttrmap ; $4026
DataPtr_StarPatternBgAuxTilemap:
	dw StarPatternBgAuxTilemap ; $4028
DataPtr_StarPatternBgAuxAttrmap:
	dw StarPatternBgAuxAttrmap ; $402a
DataPtr_DormInteriorSceneConfig:
	dw DormInteriorSceneConfig ; $402c
DataPtr_StarPatternBgTiles:
	dw StarPatternBgTiles ; $402e
DataPtr_DormInteriorSceneConfigAlias1:
	dw DormInteriorSceneConfig ; $4030
DataPtr_DormInteriorPalettes:
	dw DormInteriorPalettes ; $4032
DataPtr_DormInteriorTilemap:
	dw DormInteriorTilemap ; $4034
DataPtr_DormInteriorAttrmap:
	dw DormInteriorAttrmap ; $4036
DataPtr_DormInteriorAuxTilemap:
	dw DormInteriorAuxTilemap ; $4038
DataPtr_DormInteriorAuxAttrmap:
	dw DormInteriorAuxAttrmap ; $403a
DataPtr_DormInteriorSceneUnusedSlot:
	dw DormInteriorSceneUnusedSlot ; $403c
DataPtr_DormInteriorTiles:
	dw DormInteriorTiles ; $403e
IslandOpenCourtPalettes:
	; $4040, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $7fff, $00df, $7ea8, $28a0 ; pal 2: #ffffff #ff3100 #41acff #002952
	dw $7fff, $3b60, $49d2, $2088 ; pal 3: #ffffff #00de73 #947394 #412041
	dw $7fff, $021f, $49d2, $2088 ; pal 4: #ffffff #ff8300 #947394 #412041
	dw $7fff, $7ea8, $5da2, $28a0 ; pal 5: #ffffff #41acff #106abd #002952
	dw $3b60, $2240, $7fff, $0046 ; pal 6: #00de73 #009441 #ffffff #311000
	dw $7fff, $3b60, $2240, $1580 ; pal 7: #ffffff #00de73 #009441 #006229
IslandOpenCourtTiles:
	INCBIN "data/bank_063/lz_4080.bin" ; $4080, 2042 bytes
IslandOpenCourtTilemap:
	INCBIN "data/bank_063/lz_487a.bin" ; $487a, 635 bytes
IslandOpenCourtAttrmap:
	INCBIN "data/bank_063/lz_4af5.bin" ; $4af5, 185 bytes
IslandOpenCourtSceneConfig:
	INCBIN "data/bank_063/d_4bae.bin" ; $4bae, 40 bytes
IslandOpenCourtSceneConfigB:
	INCBIN "data/bank_063/d_4bd6.bin" ; $4bd6, 40 bytes
DKCourtPalettes:
	; $4bfe, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $01a0, $000f, $2118, $0000 ; pal 1: #006a00 #7b0000 #c54141 #000000
	dw $0360, $021f, $00d3, $0066 ; pal 2: #00de00 #ff8300 #9c3100 #311800
	dw $21e0, $43f6, $0360, $10a0 ; pal 3: #007b41 #b4ff83 #00de00 #002920
	dw $0360, $7d1f, $7fff, $0066 ; pal 4: #00de00 #ff41ff #ffffff #311800
	dw $0336, $0360, $7fff, $0066 ; pal 5: #b4cd00 #00de00 #ffffff #311800
	dw $7fff, $0360, $0336, $03fc ; pal 6: #ffffff #00de00 #b4cd00 #e6ff00
	dw $7fff, $0360, $0336, $0292 ; pal 7: #ffffff #00de00 #b4cd00 #94a400
DKCourtTiles:
	INCBIN "data/bank_063/lz_4c3e.bin" ; $4c3e, 3291 bytes
DKCourtTilemap:
	INCBIN "data/bank_063/lz_5919.bin" ; $5919, 713 bytes
DKCourtAttrmap:
	INCBIN "data/bank_063/lz_5be2.bin" ; $5be2, 323 bytes
DKCourtSceneConfig:
	INCBIN "data/bank_063/d_5d25.bin" ; $5d25, 40 bytes
DKCourtSceneConfigB:
	INCBIN "data/bank_063/d_5d4d.bin" ; $5d4d, 40 bytes
StarPatternBgSceneConfig:
	INCBIN "data/bank_063/d_5d75.bin" ; $5d75, 42 bytes
StarPatternBgPalettes:
	; $5d9f, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7fe0, $6bff, $1e58, $0000 ; pal 0: #00ffff #ffffd5 #c59439 #000000
	dw $0000, $7800, $001e, $03c0 ; pal 1: #000000 #0000f6 #f60000 #00f600
	dw $7e5e, $7dd8, $7d92, $7d0e ; pal 2: #f694ff #c573ff #9462ff #7341ff
	dw $7e9c, $4bff, $375c, $7df7 ; pal 3: #e6a4ff #ffff94 #e6d56a #bd7bff
	dw $2508, $2508, $2508, $2508 ; pal 4: #41414a #41414a #41414a #41414a
	dw $2508, $2508, $2508, $2508 ; pal 5: #41414a #41414a #41414a #41414a
	dw $4a3f, $6bff, $20ff, $0000 ; pal 6: #ff8b94 #ffffd5 #ff3941 #000000
	dw $5e1f, $6bff, $7cd8, $0000 ; pal 7: #ff83bd #ffffd5 #c531ff #000000
StarPatternBgTiles:
	INCBIN "data/bank_063/lz_5ddf.bin" ; $5ddf, 685 bytes
StarPatternBgTilemap:
	INCBIN "data/bank_063/lz_608c.bin" ; $608c, 274 bytes
StarPatternBgAttrmap:
	INCBIN "data/bank_063/lz_619e.bin" ; $619e, 263 bytes
StarPatternBgAuxTilemap:
	INCBIN "data/bank_063/lz_62a5.bin" ; $62a5, 70 bytes
StarPatternBgAuxAttrmap:
	INCBIN "data/bank_063/lz_62eb.bin" ; $62eb, 70 bytes
DormInteriorSceneConfig:
	INCBIN "data/bank_063/d_6331.bin" ; $6331, 42 bytes
DormInteriorPalettes:
	; $635b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $781f, $781f, $781f, $781f ; pal 2: #ff00f6 #ff00f6 #ff00f6 #ff00f6
	dw $1ca2, $45ed, $62f6, $7fff ; pal 3: #102939 #6a7b8b #b4bdc5 #ffffff
	dw $19c5, $57f1, $36eb, $00c0 ; pal 4: #297331 #8bffac #5abd6a #003100
	dw $102b, $2cf7, $49dd, $66bf ; pal 5: #5a0820 #bd395a #ee7394 #ffaccd
	dw $7f14, $6e4e, $5d88, $50e3 ; pal 6: #a4c5ff #7394de #4162bd #1839a4
	dw $5f9f, $4297, $25af, $04a7 ; pal 7: #ffe6bd #bda483 #7b6a4a #392908
DormInteriorTiles:
	INCBIN "data/bank_063/d_639b.bin" ; $639b, 3510 bytes
DormInteriorTilemap:
	INCBIN "data/bank_063/d_7151.bin" ; $7151, 1470 bytes
DormInteriorAttrmap:
	INCBIN "data/bank_063/d_770f.bin" ; $770f, 769 bytes
DormInteriorAuxTilemap:
	INCBIN "data/bank_063/d_7a10.bin" ; $7a10, 147 bytes
DormInteriorAuxAttrmap:
	INCBIN "data/bank_063/d_7aa3.bin" ; $7aa3, 94 bytes
DormInteriorSceneUnusedSlot:
	; $7b01, 1279 bytes fill to bank end (linker-padded)
