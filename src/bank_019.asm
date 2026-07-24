SECTION "ROM Bank $19", ROMX[$4000], BANK[$19]

DataPtr_VictoryCutsceneTiles:
	dw VictoryCutsceneTiles ; $4000
DataPtr_VictoryCutscenePalettes:
	dw VictoryCutscenePalettes ; $4002
DataPtr_VictoryCutsceneTilemap:
	dw VictoryCutsceneTilemap ; $4004
DataPtr_VictoryCutsceneAttrmap:
	dw VictoryCutsceneAttrmap ; $4006
DataPtr_VictoryCutsceneTilemap2:
	dw VictoryCutsceneTilemap2 ; $4008
DataPtr_VictoryCutsceneAttrmap2:
	dw VictoryCutsceneAttrmap2 ; $400a
DataPtr_VictoryCutsceneTilemap3:
	dw VictoryCutsceneTilemap3 ; $400c
DataPtr_VictoryCutsceneAttrmap3:
	dw VictoryCutsceneAttrmap3 ; $400e
DataPtr_VictoryCutsceneTilemap4:
	dw VictoryCutsceneTilemap4 ; $4010
DataPtr_VictoryCutsceneAttrmap4:
	dw VictoryCutsceneAttrmap4 ; $4012
DataPtr_VictoryCutsceneTilemap5:
	dw VictoryCutsceneTilemap5 ; $4014
DataPtr_VictoryCutsceneAttrmap5:
	dw VictoryCutsceneAttrmap5 ; $4016
DataPtr_VictoryCutsceneTilemap6:
	dw VictoryCutsceneTilemap6 ; $4018
DataPtr_VictoryCutsceneAttrmap6:
	dw VictoryCutsceneAttrmap6 ; $401a
DataPtr_ShopCutsceneTiles:
	dw ShopCutsceneTiles ; $401c
DataPtr_ShopCutscenePalettes:
	dw ShopCutscenePalettes ; $401e
DataPtr_ShopCutsceneTilemap:
	dw ShopCutsceneTilemap ; $4020
DataPtr_ShopCutsceneAttrmap:
	dw ShopCutsceneAttrmap ; $4022
DataPtr_ShopCutsceneTilemap2:
	dw ShopCutsceneTilemap2 ; $4024
DataPtr_ShopCutsceneAttrmap2:
	dw ShopCutsceneAttrmap2 ; $4026
DataPtr_ShopCutsceneTilemap3:
	dw ShopCutsceneTilemap3 ; $4028
DataPtr_ShopCutsceneAttrmap3:
	dw ShopCutsceneAttrmap3 ; $402a
DataPtr_ShopCutsceneTilemap4:
	dw ShopCutsceneTilemap4 ; $402c
DataPtr_ShopCutsceneAttrmap4:
	dw ShopCutsceneAttrmap4 ; $402e
DataPtr_ShopCutsceneTilemap5:
	dw ShopCutsceneTilemap5 ; $4030
DataPtr_ShopCutsceneAttrmap5:
	dw ShopCutsceneAttrmap5 ; $4032
DataPtr_ShopCutsceneTilemap6:
	dw ShopCutsceneTilemap6 ; $4034
DataPtr_ShopCutsceneAttrmap6:
	dw ShopCutsceneAttrmap6 ; $4036
DataPtr_ChampionMedalTiles:
	dw ChampionMedalTiles ; $4038
DataPtr_ChampionMedalPalettes:
	dw ChampionMedalPalettes ; $403a
DataPtr_ChampionMedalTilemap:
	dw ChampionMedalTilemap ; $403c
DataPtr_ChampionMedalAttrmap:
	dw ChampionMedalAttrmap ; $403e
DataPtr_ChampionMedalTilemap2:
	dw ChampionMedalTilemap2 ; $4040
DataPtr_ChampionMedalAttrmap2:
	dw ChampionMedalAttrmap2 ; $4042
DataPtr_ChampionMedalTilemap3:
	dw ChampionMedalTilemap3 ; $4044
DataPtr_ChampionMedalAttrmap3:
	dw ChampionMedalAttrmap3 ; $4046
DataPtr_ChampionMedalTilemap4:
	dw ChampionMedalTilemap4 ; $4048
DataPtr_ChampionMedalAttrmap4:
	dw ChampionMedalAttrmap4 ; $404a
VictoryCutsceneTiles:
	INCBIN "data/bank_019/lz_404c.bin" ; $404c, 3118 bytes
VictoryCutscenePalettes:
	; $4c7a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 3: #525252 #525252 #525252 #525252
	dw $7e80, $6bff, $505c, $0000 ; pal 4: #00a4ff #ffffd5 #e610a4 #000000
	dw $7e80, $6bff, $01df, $0000 ; pal 5: #00a4ff #ffffd5 #ff7300 #000000
	dw $7e80, $6bff, $011f, $0000 ; pal 6: #00a4ff #ffffd5 #ff4100 #000000
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
VictoryCutsceneTilemap:
	INCBIN "data/bank_019/lz_4cba.bin" ; $4cba, 265 bytes
VictoryCutsceneAttrmap:
	INCBIN "data/bank_019/lz_4dc3.bin" ; $4dc3, 99 bytes
VictoryCutsceneTilemap2:
	INCBIN "data/bank_019/lz_4e26.bin" ; $4e26, 258 bytes
VictoryCutsceneAttrmap2:
	INCBIN "data/bank_019/lz_4f28.bin" ; $4f28, 123 bytes
VictoryCutsceneTilemap3:
	INCBIN "data/bank_019/lz_4fa3.bin" ; $4fa3, 271 bytes
VictoryCutsceneAttrmap3:
	INCBIN "data/bank_019/lz_50b2.bin" ; $50b2, 84 bytes
VictoryCutsceneTilemap4:
	INCBIN "data/bank_019/lz_5106.bin" ; $5106, 259 bytes
VictoryCutsceneAttrmap4:
	INCBIN "data/bank_019/lz_5209.bin" ; $5209, 106 bytes
VictoryCutsceneTilemap5:
	INCBIN "data/bank_019/lz_5273.bin" ; $5273, 209 bytes
VictoryCutsceneAttrmap5:
	INCBIN "data/bank_019/lz_5344.bin" ; $5344, 140 bytes
VictoryCutsceneTilemap6:
	INCBIN "data/bank_019/lz_53d0.bin" ; $53d0, 221 bytes
VictoryCutsceneAttrmap6:
	INCBIN "data/bank_019/lz_54ad.bin" ; $54ad, 114 bytes
ShopCutsceneTiles:
	INCBIN "data/bank_019/lz_551f.bin" ; $551f, 3077 bytes
ShopCutscenePalettes:
	; $6124, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $0000, $0000, $0000 ; pal 0: #b4b4b4 #000000 #000000 #000000
	dw $79ea, $6bff, $7f2a, $0000 ; pal 1: #527bf6 #ffffd5 #52cdff #000000
	dw $79ea, $6bff, $011f, $0000 ; pal 2: #527bf6 #ffffd5 #ff4100 #000000
	dw $79ea, $6bff, $01df, $0000 ; pal 3: #527bf6 #ffffd5 #ff7300 #000000
	dw $79ea, $6bff, $505c, $0000 ; pal 4: #527bf6 #ffffd5 #e610a4 #000000
	dw $7ed6, $7ed6, $7ed6, $7ed6 ; pal 5: #b4b4ff #b4b4ff #b4b4ff #b4b4ff
	dw $281f, $6bff, $2a00, $0000 ; pal 6: #ff0052 #ffffd5 #008352 #000000
	dw $7ed6, $7ed6, $7ed6, $7ed6 ; pal 7: #b4b4ff #b4b4ff #b4b4ff #b4b4ff
ShopCutsceneTilemap:
	INCBIN "data/bank_019/lz_6164.bin" ; $6164, 257 bytes
ShopCutsceneAttrmap:
	INCBIN "data/bank_019/lz_6265.bin" ; $6265, 129 bytes
ShopCutsceneTilemap2:
	INCBIN "data/bank_019/lz_62e6.bin" ; $62e6, 250 bytes
ShopCutsceneAttrmap2:
	INCBIN "data/bank_019/lz_63e0.bin" ; $63e0, 110 bytes
ShopCutsceneTilemap3:
	INCBIN "data/bank_019/lz_644e.bin" ; $644e, 271 bytes
ShopCutsceneAttrmap3:
	INCBIN "data/bank_019/lz_655d.bin" ; $655d, 132 bytes
ShopCutsceneTilemap4:
	INCBIN "data/bank_019/lz_65e1.bin" ; $65e1, 264 bytes
ShopCutsceneAttrmap4:
	INCBIN "data/bank_019/lz_66e9.bin" ; $66e9, 132 bytes
ShopCutsceneTilemap5:
	INCBIN "data/bank_019/lz_676d.bin" ; $676d, 215 bytes
ShopCutsceneAttrmap5:
	INCBIN "data/bank_019/lz_6844.bin" ; $6844, 109 bytes
ShopCutsceneTilemap6:
	INCBIN "data/bank_019/lz_68b1.bin" ; $68b1, 226 bytes
ShopCutsceneAttrmap6:
	INCBIN "data/bank_019/lz_6993.bin" ; $6993, 125 bytes
ChampionMedalTiles:
	INCBIN "data/bank_019/lz_6a10.bin" ; $6a10, 3355 bytes
ChampionMedalPalettes:
	; $772b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $3a9f, $77ff, $01d6, $0000 ; pal 2: #ffa473 #ffffee #b47300 #000000
	dw $3a9f, $6154, $01d6, $0000 ; pal 3: #ffa473 #a452c5 #b47300 #000000
	dw $6154, $77ff, $505c, $0000 ; pal 4: #a452c5 #ffffee #e610a4 #000000
	dw $3a9f, $77ff, $6154, $0000 ; pal 5: #ffa473 #ffffee #a452c5 #000000
	dw $6154, $77ff, $011f, $0000 ; pal 6: #a452c5 #ffffee #ff4100 #000000
	dw $6154, $77ff, $01df, $0000 ; pal 7: #a452c5 #ffffee #ff7300 #000000
ChampionMedalTilemap:
	INCBIN "data/bank_019/lz_776b.bin" ; $776b, 275 bytes
ChampionMedalAttrmap:
	INCBIN "data/bank_019/lz_787e.bin" ; $787e, 128 bytes
ChampionMedalTilemap2:
	INCBIN "data/bank_019/lz_78fe.bin" ; $78fe, 275 bytes
ChampionMedalAttrmap2:
	INCBIN "data/bank_019/lz_7a11.bin" ; $7a11, 125 bytes
ChampionMedalTilemap3:
	INCBIN "data/bank_019/lz_7a8e.bin" ; $7a8e, 275 bytes
ChampionMedalAttrmap3:
	INCBIN "data/bank_019/lz_7ba1.bin" ; $7ba1, 147 bytes
ChampionMedalTilemap4:
	INCBIN "data/bank_019/lz_7c34.bin" ; $7c34, 275 bytes
ChampionMedalAttrmap4:
	INCBIN "data/bank_019/lz_7d47.bin" ; $7d47, 144 bytes
	; $7dd7, 553 bytes fill to bank end (linker-padded)
