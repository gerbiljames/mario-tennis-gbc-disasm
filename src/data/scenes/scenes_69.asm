DataPtr_TrainingCenterSceneConfig:
	dw TrainingCenterSceneConfig ; $4000
DataPtr_TrainingCenterPalettes:
	dw TrainingCenterPalettes ; $4002
DataPtr_TrainingCenterTilemap:
	dw TrainingCenterTilemap ; $4004
DataPtr_TrainingCenterAttrmap:
	dw TrainingCenterAttrmap ; $4006
DataPtr_TrainingCenterCollisionMap:
	dw TrainingCenterCollisionMap ; $4008
DataPtr_TrainingCenterBehaviorMap:
	dw TrainingCenterBehaviorMap ; $400a
DataPtr_TournamentSceneConfig:
	dw TournamentSceneConfig ; $400c
DataPtr_TrainingCenterTiles:
	dw TrainingCenterTiles ; $400e
DataPtr_TournamentSceneConfigAlias1:
	dw TournamentSceneConfig ; $4010
DataPtr_TournamentPalettes:
	dw TournamentPalettes ; $4012
DataPtr_TournamentTilemap:
	dw TournamentTilemap ; $4014
DataPtr_TournamentAttrmap:
	dw TournamentAttrmap ; $4016
DataPtr_TournamentCollisionMap:
	dw TournamentCollisionMap ; $4018
DataPtr_TournamentBehaviorMap:
	dw TournamentBehaviorMap ; $401a
DataPtr_AwardsCeremonySceneConfig:
	dw AwardsCeremonySceneConfig ; $401c
DataPtr_TournamentTiles:
	dw TournamentTiles ; $401e
DataPtr_AwardsCeremonySceneConfigAlias1:
	dw AwardsCeremonySceneConfig ; $4020
DataPtr_AwardsCeremonyPalettes:
	dw AwardsCeremonyPalettes ; $4022
DataPtr_AwardsCeremonyTilemap:
	dw AwardsCeremonyTilemap ; $4024
DataPtr_AwardsCeremonyAttrmap:
	dw AwardsCeremonyAttrmap ; $4026
DataPtr_AwardsCeremonyCollisionMap:
	dw AwardsCeremonyCollisionMap ; $4028
DataPtr_AwardsCeremonyBehaviorMap:
	dw AwardsCeremonyBehaviorMap ; $402a
DataPtr_AwardsCeremonySceneUnusedSlot:
	dw AwardsCeremonySceneUnusedSlot ; $402c
DataPtr_AwardsCeremonyTiles:
	dw AwardsCeremonyTiles ; $402e
TrainingCenterSceneConfig:
	INCLUDE "data/scenes/TrainingCenterSceneConfig.asm" ; $4030, 42 bytes (scene_config)
TrainingCenterPalettes:
	INCLUDE "data/scenes/TrainingCenterPalettes.asm" ; $405a, 64 bytes (palettes)
TrainingCenterTiles:
	INCBIN "data/scenes/lz_TrainingCenterTiles.bin" ; $409a, 3011 bytes
TrainingCenterTilemap:
	INCBIN "data/scenes/lz_TrainingCenterTilemap.bin" ; $4c5d, 1214 bytes
TrainingCenterAttrmap:
	INCBIN "data/scenes/lz_TrainingCenterAttrmap.bin" ; $511b, 759 bytes
TrainingCenterCollisionMap:
	INCBIN "data/scenes/lz_TrainingCenterCollisionMap.bin" ; $5412, 129 bytes
TrainingCenterBehaviorMap:
	INCBIN "data/scenes/lz_TrainingCenterBehaviorMap.bin" ; $5493, 129 bytes
TournamentSceneConfig:
	INCLUDE "data/scenes/TournamentSceneConfig.asm" ; $5514, 42 bytes (scene_config)
TournamentPalettes:
	INCLUDE "data/scenes/TournamentPalettes.asm" ; $553e, 64 bytes (palettes)
TournamentTiles:
	INCBIN "data/scenes/lz_TournamentTiles.bin" ; $557e, 2082 bytes
TournamentTilemap:
	INCBIN "data/scenes/lz_TournamentTilemap.bin" ; $5da0, 991 bytes
TournamentAttrmap:
	INCBIN "data/scenes/lz_TournamentAttrmap.bin" ; $617f, 751 bytes
TournamentCollisionMap:
	INCBIN "data/scenes/lz_TournamentCollisionMap.bin" ; $646e, 125 bytes
TournamentBehaviorMap:
	INCBIN "data/scenes/lz_TournamentBehaviorMap.bin" ; $64eb, 87 bytes
AwardsCeremonySceneConfig:
	INCLUDE "data/scenes/AwardsCeremonySceneConfig.asm" ; $6542, 27 bytes (scene_config)
AwardsCeremonyPalettes:
	INCLUDE "data/scenes/AwardsCeremonyPalettes.asm" ; $655d, 64 bytes (palettes)
AwardsCeremonyTiles:
	INCBIN "data/scenes/lz_AwardsCeremonyTiles.bin" ; $659d, 2486 bytes
AwardsCeremonyTilemap:
	INCBIN "data/scenes/lz_AwardsCeremonyTilemap.bin" ; $6f53, 999 bytes
AwardsCeremonyAttrmap:
	INCBIN "data/scenes/lz_AwardsCeremonyAttrmap.bin" ; $733a, 647 bytes
AwardsCeremonyCollisionMap:
	INCBIN "data/scenes/lz_AwardsCeremonyCollisionMap.bin" ; $75c1, 84 bytes
AwardsCeremonyBehaviorMap:
	INCBIN "data/scenes/lz_AwardsCeremonyBehaviorMap.bin" ; $7615, 75 bytes
AwardsCeremonySceneUnusedSlot:
	INCBIN "data/scenes/AwardsCeremonySceneUnusedSlot.bin" ; $7660, 2464 bytes
