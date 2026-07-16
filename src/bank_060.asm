SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

DataPtr_GrassCourtSceneConfig:
	dw GrassCourtSceneConfig ; $4000
DataPtr_GrassCourtPalettes:
	dw GrassCourtPalettes ; $4002
DataPtr_GrassCourtTilemap:
	dw GrassCourtTilemap ; $4004
DataPtr_GrassCourtAttrmap:
	dw GrassCourtAttrmap ; $4006
DataPtr_GrassCourtSceneConfigAlias1:
	dw GrassCourtSceneConfig ; $4008
DataPtr_GrassCourtSceneConfigB:
	dw GrassCourtSceneConfigB ; $400a
DataPtr_HardCourtPalettes:
	dw HardCourtPalettes ; $400c
DataPtr_GrassCourtTiles:
	dw GrassCourtTiles ; $400e
DataPtr_HardCourtSceneConfig:
	dw HardCourtSceneConfig ; $4010
DataPtr_HardCourtPalettesAlias1:
	dw HardCourtPalettes ; $4012
DataPtr_HardCourtTilemap:
	dw HardCourtTilemap ; $4014
DataPtr_HardCourtAttrmap:
	dw HardCourtAttrmap ; $4016
DataPtr_HardCourtSceneConfigAlias1:
	dw HardCourtSceneConfig ; $4018
DataPtr_HardCourtSceneConfigB:
	dw HardCourtSceneConfigB ; $401a
DataPtr_ClayCourtPalettes:
	dw ClayCourtPalettes ; $401c
DataPtr_HardCourtTiles:
	dw HardCourtTiles ; $401e
DataPtr_ClayCourtSceneConfig:
	dw ClayCourtSceneConfig ; $4020
DataPtr_ClayCourtPalettesAlias1:
	dw ClayCourtPalettes ; $4022
DataPtr_ClayCourtTilemap:
	dw ClayCourtTilemap ; $4024
DataPtr_ClayCourtAttrmap:
	dw ClayCourtAttrmap ; $4026
DataPtr_ClayCourtSceneConfigAlias1:
	dw ClayCourtSceneConfig ; $4028
DataPtr_ClayCourtSceneConfigB:
	dw ClayCourtSceneConfigB ; $402a
DataPtr_CompositionCourtPalettes:
	dw CompositionCourtPalettes ; $402c
DataPtr_ClayCourtTiles:
	dw ClayCourtTiles ; $402e
DataPtr_CompositionCourtSceneConfig:
	dw CompositionCourtSceneConfig ; $4030
DataPtr_CompositionCourtPalettesAlias1:
	dw CompositionCourtPalettes ; $4032
DataPtr_CompositionCourtTilemap:
	dw CompositionCourtTilemap ; $4034
DataPtr_CompositionCourtAttrmap:
	dw CompositionCourtAttrmap ; $4036
DataPtr_CompositionCourtSceneConfigAlias1:
	dw CompositionCourtSceneConfig ; $4038
DataPtr_CompositionCourtSceneConfigB:
	dw CompositionCourtSceneConfigB ; $403a
DataPtr_60_3c:
	dw Data_60_7bfd ; $403c
DataPtr_CompositionCourtTiles:
	dw CompositionCourtTiles ; $403e
GrassCourtPalettes:
	; $4040, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $0706, $03ea, $7fff, $36be ; pal 2: #31c508 #52ff00 #ffffff #f6ac6a
	dw $0706, $11da, $7fff, $0000 ; pal 3: #31c508 #d57320 #ffffff #000000
	dw $0706, $0a44, $7fff, $2a5b ; pal 4: #31c508 #209410 #ffffff #de9452
	dw $0706, $0a44, $7fff, $28e3 ; pal 5: #31c508 #209410 #ffffff #183952
	dw $0da2, $0a44, $7fff, $1df8 ; pal 6: #106a18 #209410 #ffffff #c57b39
	dw $7d80, $7fff, $5251, $2d27 ; pal 7: #0062ff #ffffff #8b94a4 #394a5a
GrassCourtTiles:
	INCBIN "data/bank_060/lz_4080.bin" ; $4080, 3233 bytes
GrassCourtTilemap:
	INCBIN "data/bank_060/lz_4d21.bin" ; $4d21, 604 bytes
GrassCourtAttrmap:
	INCBIN "data/bank_060/lz_4f7d.bin" ; $4f7d, 268 bytes
GrassCourtSceneConfig:
	INCBIN "data/bank_060/d_5089.bin" ; $5089, 40 bytes
GrassCourtSceneConfigB:
	INCBIN "data/bank_060/d_50b1.bin" ; $50b1, 40 bytes
HardCourtPalettes:
	; $50d9, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $7c1f, $7c1f, $7c1f, $7c1f ; pal 1: #ff00ff #ff00ff #ff00ff #ff00ff
	dw $1c7d, $02e0, $7fff, $1902 ; pal 2: #ee1839 #00bd00 #ffffff #104131
	dw $1c7d, $029f, $7fff, $1902 ; pal 3: #ee1839 #ffa400 #ffffff #104131
	dw $3be0, $1c7d, $7fff, $029f ; pal 4: #00ff73 #ee1839 #ffffff #ffa400
	dw $7f00, $029f, $7fff, $1902 ; pal 5: #00c5ff #ffa400 #ffffff #104131
	dw $0220, $7d80, $7fff, $015f ; pal 6: #008b00 #0062ff #ffffff #ff5200
	dw $0220, $1c7d, $7fff, $015f ; pal 7: #008b00 #ee1839 #ffffff #ff5200
HardCourtTiles:
	INCBIN "data/bank_060/lz_5119.bin" ; $5119, 2352 bytes
HardCourtTilemap:
	INCBIN "data/bank_060/lz_5a49.bin" ; $5a49, 637 bytes
HardCourtAttrmap:
	INCBIN "data/bank_060/lz_5cc6.bin" ; $5cc6, 155 bytes
HardCourtSceneConfig:
	INCBIN "data/bank_060/d_5d61.bin" ; $5d61, 40 bytes
HardCourtSceneConfigB:
	INCBIN "data/bank_060/d_5d89.bin" ; $5d89, 40 bytes
ClayCourtPalettes:
	; $5db1, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $7e80, $02c0, $7fff, $24c2 ; pal 2: #00a4ff #00b400 #ffffff #10314a
	dw $421f, $319b, $2138, $7fff ; pal 3: #ff8383 #de6262 #c54a41 #ffffff
	dw $319b, $1c80, $4b5f, $7dc0 ; pal 4: #de6262 #002039 #ffd594 #0073ff
	dw $2138, $319b, $7fff, $24c2 ; pal 5: #c54a41 #de6262 #ffffff #10314a
	dw $0051, $10b4, $2138, $7fff ; pal 6: #8b1000 #a42920 #c54a41 #ffffff
	dw $7d1f, $02c0, $7fff, $24c2 ; pal 7: #ff41ff #00b400 #ffffff #10314a
ClayCourtTiles:
	INCBIN "data/bank_060/lz_5df1.bin" ; $5df1, 2993 bytes
ClayCourtTilemap:
	INCBIN "data/bank_060/lz_69a2.bin" ; $69a2, 582 bytes
ClayCourtAttrmap:
	INCBIN "data/bank_060/lz_6be8.bin" ; $6be8, 166 bytes
ClayCourtSceneConfig:
	INCBIN "data/bank_060/d_6c8e.bin" ; $6c8e, 40 bytes
ClayCourtSceneConfigB:
	INCBIN "data/bank_060/d_6cb6.bin" ; $6cb6, 40 bytes
CompositionCourtPalettes:
	; $6cde, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $7d1f, $02c0, $7fff, $24c2 ; pal 2: #ff41ff #00b400 #ffffff #10314a
	dw $7f2c, $6aa9, $5a26, $7fff ; pal 3: #62cdff #4aacd5 #318bb4 #ffffff
	dw $6aa9, $24c2, $4b1f, $609f ; pal 4: #4aacd5 #10314a #ffc594 #ff20c5
	dw $5a26, $6aa9, $7fff, $24c2 ; pal 5: #318bb4 #4aacd5 #ffffff #10314a
	dw $3940, $49a3, $5a26, $7fff ; pal 6: #005273 #186a94 #318bb4 #ffffff
	dw $7e80, $02c0, $7fff, $24c2 ; pal 7: #00a4ff #00b400 #ffffff #10314a
CompositionCourtTiles:
	INCBIN "data/bank_060/lz_6d1e.bin" ; $6d1e, 2994 bytes
CompositionCourtTilemap:
	INCBIN "data/bank_060/lz_78d0.bin" ; $78d0, 573 bytes
CompositionCourtAttrmap:
	INCBIN "data/bank_060/lz_7b0d.bin" ; $7b0d, 160 bytes
CompositionCourtSceneConfig:
	INCBIN "data/bank_060/d_7bad.bin" ; $7bad, 40 bytes
CompositionCourtSceneConfigB:
	INCBIN "data/bank_060/d_7bd5.bin" ; $7bd5, 40 bytes
Data_60_7bfd:
	ds 1027, $ff ; $7bfd, fill
