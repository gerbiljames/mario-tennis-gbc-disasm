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
DataPtr_DreamMatchEpilogueDoublesBoysTilemap:
	dw DreamMatchEpilogueDoublesBoysTilemap ; $401a
DataPtr_DreamMatchEpilogueDoublesBoysAttrmap:
	dw DreamMatchEpilogueDoublesBoysAttrmap ; $401c
DataPtr_DreamMatchEpilogueDoublesBoyGirlTilemap:
	dw DreamMatchEpilogueDoublesBoyGirlTilemap ; $401e
DataPtr_DreamMatchEpilogueDoublesBoyGirlAttrmap:
	dw DreamMatchEpilogueDoublesBoyGirlAttrmap ; $4020
DataPtr_DreamMatchEpilogueDoublesGirlBoyTilemap:
	dw DreamMatchEpilogueDoublesGirlBoyTilemap ; $4022
DataPtr_DreamMatchEpilogueDoublesGirlBoyAttrmap:
	dw DreamMatchEpilogueDoublesGirlBoyAttrmap ; $4024
DataPtr_DreamMatchEpilogueDoublesGirlsTilemap:
	dw DreamMatchEpilogueDoublesGirlsTilemap ; $4026
DataPtr_DreamMatchEpilogueDoublesGirlsAttrmap:
	dw DreamMatchEpilogueDoublesGirlsAttrmap ; $4028
