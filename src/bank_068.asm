SECTION "ROM Bank $68", ROMX[$4000], BANK[$68]

DataPtr_ClubCourtSceneConfig:
	dw ClubCourtSceneConfig ; $4000
DataPtr_ClubCourtPalettes:
	dw ClubCourtPalettes ; $4002
DataPtr_ClubCourtTilemap:
	dw ClubCourtTilemap ; $4004
DataPtr_ClubCourtAttrmap:
	dw ClubCourtAttrmap ; $4006
DataPtr_ClubCourtCollisionMap:
	dw ClubCourtCollisionMap ; $4008
DataPtr_ClubCourtBehaviorMap:
	dw ClubCourtBehaviorMap ; $400a
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
DataPtr_StadiumGroundsCollisionMap:
	dw StadiumGroundsCollisionMap ; $4018
DataPtr_StadiumGroundsBehaviorMap:
	dw StadiumGroundsBehaviorMap ; $401a
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
DataPtr_CeremonyHallCollisionMap:
	dw CeremonyHallCollisionMap ; $4028
DataPtr_CeremonyHallBehaviorMap:
	dw CeremonyHallBehaviorMap ; $402a
DataPtr_CeremonyHallSceneUnusedSlot:
	dw CeremonyHallSceneUnusedSlot ; $402c
DataPtr_CeremonyHallTiles:
	dw CeremonyHallTiles ; $402e
ClubCourtSceneConfig:
	INCBIN "data/bank_068/d_4030.bin" ; $4030, 42 bytes
ClubCourtPalettes:
	INCLUDE "data/bank_068/palettes_405a.asm" ; $405a, 64 bytes (palettes)
ClubCourtTiles:
	INCBIN "data/bank_068/lz_409a.bin" ; $409a, 3032 bytes
ClubCourtTilemap:
	INCBIN "data/bank_068/lz_4c72.bin" ; $4c72, 1173 bytes
ClubCourtAttrmap:
	INCBIN "data/bank_068/lz_5107.bin" ; $5107, 702 bytes
ClubCourtCollisionMap:
	INCBIN "data/bank_068/lz_53c5.bin" ; $53c5, 108 bytes
ClubCourtBehaviorMap:
	INCBIN "data/bank_068/lz_5431.bin" ; $5431, 74 bytes
StadiumGroundsSceneConfig:
	INCBIN "data/bank_068/d_547b.bin" ; $547b, 42 bytes
StadiumGroundsPalettes:
	INCLUDE "data/bank_068/palettes_54a5.asm" ; $54a5, 64 bytes (palettes)
StadiumGroundsTiles:
	INCBIN "data/bank_068/lz_54e5.bin" ; $54e5, 2108 bytes
StadiumGroundsTilemap:
	INCBIN "data/bank_068/lz_5d21.bin" ; $5d21, 1091 bytes
StadiumGroundsAttrmap:
	INCBIN "data/bank_068/lz_6164.bin" ; $6164, 620 bytes
StadiumGroundsCollisionMap:
	INCBIN "data/bank_068/lz_63d0.bin" ; $63d0, 101 bytes
StadiumGroundsBehaviorMap:
	INCBIN "data/bank_068/lz_6435.bin" ; $6435, 75 bytes
CeremonyHallSceneConfig:
	INCBIN "data/bank_068/d_6480.bin" ; $6480, 23 bytes
CeremonyHallPalettes:
	INCLUDE "data/bank_068/palettes_6497.asm" ; $6497, 64 bytes (palettes)
CeremonyHallTiles:
	INCBIN "data/bank_068/lz_64d7.bin" ; $64d7, 2325 bytes
CeremonyHallTilemap:
	INCBIN "data/bank_068/lz_6dec.bin" ; $6dec, 849 bytes
CeremonyHallAttrmap:
	INCBIN "data/bank_068/lz_713d.bin" ; $713d, 595 bytes
CeremonyHallCollisionMap:
	INCBIN "data/bank_068/lz_7390.bin" ; $7390, 103 bytes
CeremonyHallBehaviorMap:
	INCBIN "data/bank_068/lz_73f7.bin" ; $73f7, 74 bytes
	; $7441, 15 bytes (fill)
	ds 15, $00
CeremonyHallSceneUnusedSlot:
	INCBIN "data/bank_068/d_7450.bin" ; $7450, 2992 bytes
