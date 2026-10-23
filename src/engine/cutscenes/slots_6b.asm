	farptr RunIntroCutscene ; $4000
	farptr RunTitleScreen ; $4002
DataPtr_TitleScreenTilemap:
	dw TitleScreenTilemap ; $4004
DataPtr_TitleScreenAttrmap:
	dw TitleScreenAttrmap ; $4006
DataPtr_TitleScreenPalettes:
	dw TitleScreenPalettes ; $4008
	farptr LoadIntroAwesomeOpponentsCaption ; $400a
	farptr LoadIntroAwesomeOpponentsCaptionAlias1, LoadIntroAwesomeOpponentsCaption ; $400c
	farptr LoadIntroAwesomeOpponentsCaptionAlias2, LoadIntroAwesomeOpponentsCaption ; $400e
	farptr LoadIntroAwesomeOpponentsCaptionAlias3, LoadIntroAwesomeOpponentsCaption ; $4010
	farptr ShowIntroLogoScreen ; $4012
	farptr ScrollOutIntroLogo ; $4014
	farptr LoadIntroTilesAndPalette ; $4016
	farptr QueueIntroSpinningBallFrame ; $4018
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
