SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

DataPtr_StarCourtSceneConfig:
	dw StarCourtSceneConfig ; $4000
DataPtr_StarCourtPalettes:
	dw StarCourtPalettes ; $4002
DataPtr_StarCourtTilemap:
	dw StarCourtTilemap ; $4004
DataPtr_StarCourtAttrmap:
	dw StarCourtAttrmap ; $4006
DataPtr_StarCourtSceneConfigAlias1:
	dw StarCourtSceneConfig ; $4008
DataPtr_StarCourtSceneConfigB:
	dw StarCourtSceneConfigB ; $400a
DataPtr_BowserCourtPalettes:
	dw BowserCourtPalettes ; $400c
DataPtr_StarCourtTiles:
	dw StarCourtTiles ; $400e
DataPtr_BowserCourtSceneConfig:
	dw BowserCourtSceneConfig ; $4010
DataPtr_BowserCourtPalettesAlias1:
	dw BowserCourtPalettes ; $4012
DataPtr_BowserCourtTilemap:
	dw BowserCourtTilemap ; $4014
DataPtr_BowserCourtAttrmap:
	dw BowserCourtAttrmap ; $4016
DataPtr_BowserCourtSceneConfigAlias1:
	dw BowserCourtSceneConfig ; $4018
DataPtr_BowserCourtSceneConfigB:
	dw BowserCourtSceneConfigB ; $401a
DataPtr_WarioCourtPalettes:
	dw WarioCourtPalettes ; $401c
DataPtr_BowserCourtTiles:
	dw BowserCourtTiles ; $401e
DataPtr_WarioCourtSceneConfig:
	dw WarioCourtSceneConfig ; $4020
DataPtr_WarioCourtPalettesAlias1:
	dw WarioCourtPalettes ; $4022
DataPtr_WarioCourtTilemap:
	dw WarioCourtTilemap ; $4024
DataPtr_WarioCourtAttrmap:
	dw WarioCourtAttrmap ; $4026
DataPtr_WarioCourtSceneConfigAlias1:
	dw WarioCourtSceneConfig ; $4028
DataPtr_WarioCourtSceneConfigB:
	dw WarioCourtSceneConfigB ; $402a
DataPtr_PeachCourtPalettes:
	dw PeachCourtPalettes ; $402c
DataPtr_WarioCourtTiles:
	dw WarioCourtTiles ; $402e
DataPtr_PeachCourtSceneConfig:
	dw PeachCourtSceneConfig ; $4030
DataPtr_PeachCourtPalettesAlias1:
	dw PeachCourtPalettes ; $4032
DataPtr_PeachCourtTilemap:
	dw PeachCourtTilemap ; $4034
DataPtr_PeachCourtAttrmap:
	dw PeachCourtAttrmap ; $4036
DataPtr_PeachCourtSceneConfigAlias1:
	dw PeachCourtSceneConfig ; $4038
DataPtr_PeachCourtSceneConfigB:
	dw PeachCourtSceneConfigB ; $403a
DataPtr_62_3c:
	dw Data_62_6f7e ; $403c
DataPtr_PeachCourtTiles:
	dw PeachCourtTiles ; $403e
StarCourtPalettes:
	; $4040, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $034b, $025f, $7fff, $7e60 ; pal 2: #5ad500 #ff9400 #ffffff #009cff
	dw $0247, $011f, $7fff, $0046 ; pal 3: #399400 #ff4100 #ffffff #311000
	dw $034b, $7d9f, $7fff, $0046 ; pal 4: #5ad500 #ff62ff #ffffff #311000
	dw $0247, $025f, $7fff, $0046 ; pal 5: #399400 #ff9400 #ffffff #311000
	dw $0247, $034b, $7fff, $0046 ; pal 6: #399400 #5ad500 #ffffff #311000
	dw $7fff, $034b, $0247, $0163 ; pal 7: #ffffff #5ad500 #399400 #185a00
StarCourtTiles:
	INCBIN "data/bank_062/lz_4080.bin" ; $4080, 1990 bytes
StarCourtTilemap:
	INCBIN "data/bank_062/lz_4846.bin" ; $4846, 508 bytes
StarCourtAttrmap:
	INCBIN "data/bank_062/lz_4a42.bin" ; $4a42, 209 bytes
StarCourtSceneConfig:
	INCBIN "data/bank_062/d_4b13.bin" ; $4b13, 40 bytes
StarCourtSceneConfigB:
	INCBIN "data/bank_062/d_4b3b.bin" ; $4b3b, 40 bytes
BowserCourtPalettes:
	; $4b63, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $7fff, $0012, $011f, $005d ; pal 2: #ffffff #940000 #ff4100 #ee1000
	dw $7fff, $0012, $011f, $01bf ; pal 3: #ffffff #940000 #ff4100 #ff6a00
	dw $0012, $419c, $731f, $2cd0 ; pal 4: #940000 #e66283 #ffc5e6 #83315a
	dw $011f, $0012, $7fff, $140a ; pal 5: #ff4100 #940000 #ffffff #520029
	dw $0012, $6985, $7fff, $140a ; pal 6: #940000 #2962d5 #ffffff #520029
	dw $005d, $3118, $629f, $140a ; pal 7: #ee1000 #c54162 #ffa4c5 #520029
BowserCourtTiles:
	INCBIN "data/bank_062/lz_4ba3.bin" ; $4ba3, 1770 bytes
BowserCourtTilemap:
	INCBIN "data/bank_062/lz_528d.bin" ; $528d, 598 bytes
BowserCourtAttrmap:
	INCBIN "data/bank_062/lz_54e3.bin" ; $54e3, 285 bytes
BowserCourtSceneConfig:
	INCBIN "data/bank_062/d_5600.bin" ; $5600, 40 bytes
BowserCourtSceneConfigB:
	INCBIN "data/bank_062/d_5628.bin" ; $5628, 40 bytes
WarioCourtPalettes:
	; $5650, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $2118, $0000 ; pal 1: #004a00 #7b0000 #c54141 #000000
	dw $025f, $1dfc, $1153, $0488 ; pal 2: #ff9400 #e67b39 #9c5220 #412008
	dw $4b1f, $1995, $10ed, $2481 ; pal 3: #ffc594 #ac6231 #6a3920 #08204a
	dw $33ff, $02c0, $001c, $28a2 ; pal 4: #ffff62 #00b400 #e60000 #102952
	dw $025f, $4810, $7fff, $28a2 ; pal 5: #ff9400 #830094 #ffffff #102952
	dw $025f, $4810, $7fff, $40df ; pal 6: #ff9400 #830094 #ffffff #ff3183
	dw $025f, $02c0, $33ff, $28a2 ; pal 7: #ff9400 #00b400 #ffff62 #102952
WarioCourtTiles:
	INCBIN "data/bank_062/lz_5690.bin" ; $5690, 2412 bytes
WarioCourtTilemap:
	INCBIN "data/bank_062/lz_5ffc.bin" ; $5ffc, 723 bytes
WarioCourtAttrmap:
	INCBIN "data/bank_062/lz_62cf.bin" ; $62cf, 274 bytes
WarioCourtSceneConfig:
	INCBIN "data/bank_062/d_63e1.bin" ; $63e1, 40 bytes
WarioCourtSceneConfigB:
	INCBIN "data/bank_062/d_6409.bin" ; $6409, 40 bytes
PeachCourtPalettes:
	; $6431, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0000, $0000, $0000, $0000 ; pal 1: #000000 #000000 #000000 #000000
	dw $02c0, $7d5f, $7fff, $2cc3 ; pal 2: #00b400 #ff52ff #ffffff #18315a
	dw $02c0, $7f00, $7fff, $2cc3 ; pal 3: #00b400 #00c5ff #ffffff #18315a
	dw $02c0, $7fff, $5650, $2cc3 ; pal 4: #00b400 #ffffff #8394ac #18315a
	dw $7e3f, $7d5f, $7fff, $2cc3 ; pal 5: #ff8bff #ff52ff #ffffff #18315a
	dw $5019, $7d5f, $7fff, $02df ; pal 6: #cd00a4 #ff52ff #ffffff #ffb400
	dw $7e3f, $7d5f, $7fff, $02df ; pal 7: #ff8bff #ff52ff #ffffff #ffb400
PeachCourtTiles:
	INCBIN "data/bank_062/lz_6471.bin" ; $6471, 1874 bytes
PeachCourtTilemap:
	INCBIN "data/bank_062/lz_6bc3.bin" ; $6bc3, 562 bytes
PeachCourtAttrmap:
	INCBIN "data/bank_062/lz_6df5.bin" ; $6df5, 313 bytes
PeachCourtSceneConfig:
	INCBIN "data/bank_062/d_6f2e.bin" ; $6f2e, 40 bytes
PeachCourtSceneConfigB:
	INCBIN "data/bank_062/d_6f56.bin" ; $6f56, 40 bytes
Data_62_6f7e:
	; $6f7e, 4226 bytes fill to bank end (linker-padded)
