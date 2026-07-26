SECTION "ROM Bank $68", ROMX[$4000], BANK[$68]

DataPtr_ClubCourtSceneConfig:
	dw ClubCourtSceneConfig ; $4000
DataPtr_ClubCourtPalettes:
	dw ClubCourtPalettes ; $4002
DataPtr_ClubCourtTilemap:
	dw ClubCourtTilemap ; $4004
DataPtr_ClubCourtAttrmap:
	dw ClubCourtAttrmap ; $4006
DataPtr_ClubCourtAuxTilemap:
	dw ClubCourtAuxTilemap ; $4008
DataPtr_ClubCourtAuxAttrmap:
	dw ClubCourtAuxAttrmap ; $400a
DataPtr_StadiumGroundsSceneConfig:
	dw StadiumGroundsSceneConfig ; $400c
DataPtr_ClubCourtTiles:
	dw ClubCourtTiles ; $400e
DataPtr_StadiumGroundsSceneConfigAlias1:
	dw StadiumGroundsSceneConfig ; $4010
DataPtr_StadiumGroundsPalettes:
	dw StadiumGroundsPalettes ; $4012
DataPtr_StadiumGroundsTilemap:
	dw StadiumGroundsTilemap ; $4014
DataPtr_StadiumGroundsAttrmap:
	dw StadiumGroundsAttrmap ; $4016
DataPtr_StadiumGroundsAuxTilemap:
	dw StadiumGroundsAuxTilemap ; $4018
DataPtr_StadiumGroundsAuxAttrmap:
	dw StadiumGroundsAuxAttrmap ; $401a
DataPtr_CeremonyHallSceneConfig:
	dw CeremonyHallSceneConfig ; $401c
DataPtr_StadiumGroundsTiles:
	dw StadiumGroundsTiles ; $401e
DataPtr_CeremonyHallSceneConfigAlias1:
	dw CeremonyHallSceneConfig ; $4020
DataPtr_CeremonyHallPalettes:
	dw CeremonyHallPalettes ; $4022
DataPtr_CeremonyHallTilemap:
	dw CeremonyHallTilemap ; $4024
DataPtr_CeremonyHallAttrmap:
	dw CeremonyHallAttrmap ; $4026
DataPtr_CeremonyHallAuxTilemap:
	dw CeremonyHallAuxTilemap ; $4028
DataPtr_CeremonyHallAuxAttrmap:
	dw CeremonyHallAuxAttrmap ; $402a
DataPtr_CeremonyHallSceneUnusedSlot:
	dw CeremonyHallSceneUnusedSlot ; $402c
DataPtr_CeremonyHallTiles:
	dw CeremonyHallTiles ; $402e
ClubCourtSceneConfig:
	INCBIN "data/bank_068/d_4030.bin" ; $4030, 42 bytes
ClubCourtPalettes:
	; $405a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $0220, $7d9f, $7fff, $1006 ; pal 2: #008b00 #ff62ff #ffffff #310020
	dw $0220, $0310, $7fff, $1006 ; pal 3: #008b00 #83c500 #ffffff #310020
	dw $0220, $0310, $021a, $1006 ; pal 4: #008b00 #83c500 #d58300 #310020
	dw $0220, $7fff, $4611, $1006 ; pal 5: #008b00 #ffffff #8b838b #310020
	dw $021a, $0288, $7fff, $1006 ; pal 6: #d58300 #41a400 #ffffff #310020
	dw $0220, $7f00, $7fff, $1006 ; pal 7: #008b00 #00c5ff #ffffff #310020
ClubCourtTiles:
	INCBIN "data/bank_068/lz_409a.bin" ; $409a, 3032 bytes
ClubCourtTilemap:
	INCBIN "data/bank_068/lz_4c72.bin" ; $4c72, 1173 bytes
ClubCourtAttrmap:
	INCBIN "data/bank_068/lz_5107.bin" ; $5107, 702 bytes
ClubCourtAuxTilemap:
	INCBIN "data/bank_068/lz_53c5.bin" ; $53c5, 108 bytes
ClubCourtAuxAttrmap:
	INCBIN "data/bank_068/lz_5431.bin" ; $5431, 74 bytes
StadiumGroundsSceneConfig:
	INCBIN "data/bank_068/d_547b.bin" ; $547b, 42 bytes
StadiumGroundsPalettes:
	; $54a5, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $7fff, $394e, $017f, $1886 ; pal 2: #ffffff #735273 #ff5a00 #312031
	dw $50df, $0280, $7fff, $1006 ; pal 3: #ff31a4 #00a400 #ffffff #310020
	dw $3bff, $021f, $394e, $1886 ; pal 4: #ffff73 #ff8300 #735273 #312031
	dw $5254, $7fff, $394e, $1886 ; pal 5: #a494a4 #ffffff #735273 #312031
	dw $0312, $0280, $7fff, $1006 ; pal 6: #94c500 #00a400 #ffffff #310020
	dw $7fff, $394e, $7e60, $1886 ; pal 7: #ffffff #735273 #009cff #312031
StadiumGroundsTiles:
	INCBIN "data/bank_068/lz_54e5.bin" ; $54e5, 2108 bytes
StadiumGroundsTilemap:
	INCBIN "data/bank_068/lz_5d21.bin" ; $5d21, 1091 bytes
StadiumGroundsAttrmap:
	INCBIN "data/bank_068/lz_6164.bin" ; $6164, 620 bytes
StadiumGroundsAuxTilemap:
	INCBIN "data/bank_068/lz_63d0.bin" ; $63d0, 101 bytes
StadiumGroundsAuxAttrmap:
	INCBIN "data/bank_068/lz_6435.bin" ; $6435, 75 bytes
CeremonyHallSceneConfig:
	INCBIN "data/bank_068/d_6480.bin" ; $6480, 23 bytes
CeremonyHallPalettes:
	; $6497, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c00, $6bff, $1e58, $294a ; pal 0: #0000ff #ffffd5 #c59439 #525252
	dw $0120, $7fff, $0154, $0000 ; pal 1: #004a00 #ffffff #a45200 #000000
	dw $7956, $7fff, $021f, $008d ; pal 2: #b452f6 #ffffff #ff8300 #6a2000
	dw $209f, $7fff, $027f, $008d ; pal 3: #ff2041 #ffffff #ff9c00 #6a2000
	dw $7e1f, $7fff, $021f, $008d ; pal 4: #ff83ff #ffffff #ff8300 #6a2000
	dw $7fff, $005f, $7d80, $0340 ; pal 5: #ffffff #ff1000 #0062ff #00d500
	dw $7e1f, $6b9f, $3e37, $08ca ; pal 6: #ff83ff #ffe6d5 #bd8b7b #523110
	dw $7fff, $7fec, $4967, $1886 ; pal 7: #ffffff #62ffff #395a94 #312031
CeremonyHallTiles:
	INCBIN "data/bank_068/lz_64d7.bin" ; $64d7, 2325 bytes
CeremonyHallTilemap:
	INCBIN "data/bank_068/lz_6dec.bin" ; $6dec, 849 bytes
CeremonyHallAttrmap:
	INCBIN "data/bank_068/lz_713d.bin" ; $713d, 595 bytes
CeremonyHallAuxTilemap:
	INCBIN "data/bank_068/lz_7390.bin" ; $7390, 103 bytes
CeremonyHallAuxAttrmap:
	INCBIN "data/bank_068/lz_73f7.bin" ; $73f7, 74 bytes
	; $7441, 15 bytes (fill)
	ds 15, $00
CeremonyHallSceneUnusedSlot:
	INCBIN "data/bank_068/d_7450.bin" ; $7450, 2992 bytes
