	farptr RunIntroCutscene ; $4000
	farptr RunTitleScreen ; $4002
DataPtr_TitleScreenTilemap:
	dw TitleScreenTilemap ; $4004
DataPtr_TitleScreenAttrmap:
	dw TitleScreenAttrmap ; $4006
DataPtr_TitleScreenPalettes:
	dw TitleScreenPalettes ; $4008
	farptr DecompressIntroTitleTiles ; $400a
	farptr DecompressIntroTitleTilesAlias1, DecompressIntroTitleTiles ; $400c
	farptr DecompressIntroTitleTilesAlias2, DecompressIntroTitleTiles ; $400e
	farptr DecompressIntroTitleTilesAlias3, DecompressIntroTitleTiles ; $4010
	farptr ShowIntroLogoScreen ; $4012
	farptr ScrollOutIntroLogo ; $4014
	farptr LoadIntroTilesAndPalette ; $4016
	farptr QueueIntroSpriteBlock ; $4018
DataPtr_AwardCeremonyTilemap:
	dw AwardCeremonyTilemap ; $401a
DataPtr_AwardCeremonyAttrmap:
	dw AwardCeremonyAttrmap ; $401c
DataPtr_AwardCeremonyTilemap2:
	dw AwardCeremonyTilemap2 ; $401e
DataPtr_AwardCeremonyAttrmap2:
	dw AwardCeremonyAttrmap2 ; $4020
DataPtr_AwardCeremonyTilemap3:
	dw AwardCeremonyTilemap3 ; $4022
DataPtr_AwardCeremonyAttrmap3:
	dw AwardCeremonyAttrmap3 ; $4024
DataPtr_AwardCeremonyTilemap4:
	dw AwardCeremonyTilemap4 ; $4026
DataPtr_AwardCeremonyAttrmap4:
	dw AwardCeremonyAttrmap4 ; $4028
