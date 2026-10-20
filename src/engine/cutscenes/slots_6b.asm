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
DataPtr_DreamMatchEpilogueTilemap:
	dw DreamMatchEpilogueTilemap ; $401a
DataPtr_DreamMatchEpilogueAttrmap:
	dw DreamMatchEpilogueAttrmap ; $401c
DataPtr_DreamMatchEpilogueTilemap2:
	dw DreamMatchEpilogueTilemap2 ; $401e
DataPtr_DreamMatchEpilogueAttrmap2:
	dw DreamMatchEpilogueAttrmap2 ; $4020
DataPtr_DreamMatchEpilogueTilemap3:
	dw DreamMatchEpilogueTilemap3 ; $4022
DataPtr_DreamMatchEpilogueAttrmap3:
	dw DreamMatchEpilogueAttrmap3 ; $4024
DataPtr_DreamMatchEpilogueTilemap4:
	dw DreamMatchEpilogueTilemap4 ; $4026
DataPtr_DreamMatchEpilogueAttrmap4:
	dw DreamMatchEpilogueAttrmap4 ; $4028
