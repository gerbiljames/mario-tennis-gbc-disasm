SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

DataPtr_ClubhouseSceneAuxTilemap:
	dw ClubhouseSceneAuxTilemap ; $4000
DataPtr_5f_02:
	dw Data_5f_4020 ; $4002
DataPtr_ClubhouseSceneTilemap:
	dw ClubhouseSceneTilemap ; $4004
DataPtr_ClubhouseSceneAttrmap:
	dw ClubhouseSceneAttrmap ; $4006
DataPtr_ClubhouseSceneAuxTilemapAlias1:
	dw ClubhouseSceneAuxTilemap ; $4008
DataPtr_ClubhouseSceneAuxAttrmap:
	dw ClubhouseSceneAuxAttrmap ; $400a
DataPtr_Data_5f_4c63:
	dw Data_5f_4c63 ; $400c
DataPtr_ClubhouseSceneTiles:
	dw ClubhouseSceneTiles ; $400e
DataPtr_CourtyardSceneAuxTilemap:
	dw CourtyardSceneAuxTilemap ; $4010
DataPtr_Data_5f_4c63Alias1:
	dw Data_5f_4c63 ; $4012
DataPtr_CourtyardSceneTilemap:
	dw CourtyardSceneTilemap ; $4014
DataPtr_CourtyardSceneAttrmap:
	dw CourtyardSceneAttrmap ; $4016
DataPtr_CourtyardSceneAuxTilemapAlias1:
	dw CourtyardSceneAuxTilemap ; $4018
DataPtr_CourtyardSceneAuxAttrmap:
	dw CourtyardSceneAuxAttrmap ; $401a
DataPtr_5f_1c:
	dw Data_5f_5954 ; $401c
DataPtr_CourtyardSceneTiles:
	dw CourtyardSceneTiles ; $401e
Data_5f_4020:
	; $4020, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $000f, $0154, $0000 ; pal 1: #004a00 #7b0000 #a45200 #000000
	dw $421f, $2959, $7fff, $004f ; pal 2: #ff8383 #cd5252 #ffffff #7b1000
	dw $03f4, $0300, $2959, $004f ; pal 3: #a4ff00 #00c500 #cd5252 #7b1000
	dw $0300, $01df, $7fff, $008c ; pal 4: #00c500 #ff7300 #ffffff #622000
	dw $03f4, $0300, $7fff, $01a0 ; pal 5: #a4ff00 #00c500 #ffffff #006a00
	dw $02e0, $7f20, $7fff, $6d20 ; pal 6: #00bd00 #00cdff #ffffff #004ade
	dw $7fff, $601f, $4e33, $2088 ; pal 7: #ffffff #ff00c5 #9c8b9c #412041
ClubhouseSceneTiles:
	INCBIN "data/bank_05f/lz_4060.bin" ; $4060, 2037 bytes
ClubhouseSceneTilemap:
	INCBIN "data/bank_05f/lz_4855.bin" ; $4855, 625 bytes
ClubhouseSceneAttrmap:
	INCBIN "data/bank_05f/lz_4ac6.bin" ; $4ac6, 333 bytes
ClubhouseSceneAuxTilemap:
	INCBIN "data/bank_05f/d_4c13.bin" ; $4c13, 40 bytes
ClubhouseSceneAuxAttrmap:
	INCBIN "data/bank_05f/d_4c3b.bin" ; $4c3b, 40 bytes
Data_5f_4c63:
	; $4c63, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0000, $0000, $0000, $0000 ; pal 1: #000000 #000000 #000000 #000000
	dw $02c0, $7d5f, $7fff, $2cc3 ; pal 2: #00b400 #ff52ff #ffffff #18315a
	dw $02c0, $7ec0, $7fff, $2cc3 ; pal 3: #00b400 #00b4ff #ffffff #18315a
	dw $02c0, $7fff, $5650, $2cc3 ; pal 4: #00b400 #ffffff #8394ac #18315a
	dw $7e3f, $7d5f, $7fff, $2cc3 ; pal 5: #ff8bff #ff52ff #ffffff #18315a
	dw $7e3f, $304c, $7fff, $02df ; pal 6: #ff8bff #621062 #ffffff #ffb400
	dw $7e3f, $7d5f, $7fff, $02df ; pal 7: #ff8bff #ff52ff #ffffff #ffb400
CourtyardSceneTiles:
	INCBIN "data/bank_05f/lz_4ca3.bin" ; $4ca3, 2384 bytes
CourtyardSceneTilemap:
	INCBIN "data/bank_05f/lz_55f3.bin" ; $55f3, 491 bytes
CourtyardSceneAttrmap:
	INCBIN "data/bank_05f/lz_57de.bin" ; $57de, 294 bytes
CourtyardSceneAuxTilemap:
	INCBIN "data/bank_05f/d_5904.bin" ; $5904, 40 bytes
CourtyardSceneAuxAttrmap:
	INCBIN "data/bank_05f/d_592c.bin" ; $592c, 40 bytes
Data_5f_5954:
	; $5954, 9900 bytes fill to bank end (linker-padded)
