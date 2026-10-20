	farptr LoadScreenAssetRecord ; $4000
	farptr QueueWram3MapToVRAM ; $4002
	farptr UpdateAnimatedTiles ; $4004
	farptr LoadCornerBracketCursorGfx ; $4006
	farptr Unused_39_LoadFixedBgPalette0 ; $4008
	farptr CopyTilemapRect ; $400a
	farptr FillTilemapRect ; $400c
	farptr LoadIndexedPalette ; $400e
	farptr LoadCompressedTileBlock ; $4010
	farptr Unused_39_LoadFixedPaletteSet ; $4012
	farptr ApplySpriteWaveOffset ; $4014
	farptr ApplySpriteBobOffset ; $4016
	farptr LoadMenuArrowSpriteTiles ; $4018
	farptr QueueStackedSpritePair ; $401a
	farptr LoadStadiumBgGraphics ; $401c
	farptr FlushWram3MapRows ; $401e
	farptr RestoreMenuBgAndDrawPanel ; $4020
	farptr ResetScreenAndTextWindows ; $4022
	farptr InitMenuBgScroll ; $4024
	farptr LoadMenuSpritePalettePair ; $4026
	farptr TickMenuBgScroll ; $4028
	farptr LoadMenuFontTiles ; $402a
	farptr QueueWram3MapToVRAMAlias1, QueueWram3MapToVRAM ; $402c
	farptr QueueWram3MapToVRAMAlias2, QueueWram3MapToVRAM ; $402e
	farptr QueueWram3MapToVRAMAlias3, QueueWram3MapToVRAM ; $4030
	farptr QueueWram3MapToVRAMAlias4, QueueWram3MapToVRAM ; $4032
DataPtr_SharedMenuGfx17:
	dw SharedMenuGfx17 ; $4034
DataPtr_SharedMenuGfx17Alias1:
	dw SharedMenuGfx17 ; $4036
DataPtr_SharedMenuGfx17Alias2:
	dw SharedMenuGfx17 ; $4038
DataPtr_SharedMenuGfx17Alias3:
	dw SharedMenuGfx17 ; $403a
DataPtr_SharedMenuGfx17Alias4:
	dw SharedMenuGfx17 ; $403c
DataPtr_SharedMenuGfx17Alias5:
	dw SharedMenuGfx17 ; $403e
DataPtr_SharedMenuGfx17Alias6:
	dw SharedMenuGfx17 ; $4040
DataPtr_SharedMenuGfx17Alias7:
	dw SharedMenuGfx17 ; $4042
DataPtr_SharedMenuGfx17Alias8:
	dw SharedMenuGfx17 ; $4044
DataPtr_SharedMenuGfx17Alias9:
	dw SharedMenuGfx17 ; $4046
DataPtr_SharedMenuGfx17Alias10:
	dw SharedMenuGfx17 ; $4048
DataPtr_SharedMenuGfx17Alias11:
	dw SharedMenuGfx17 ; $404a
DataPtr_SharedMenuGfx17Alias12:
	dw SharedMenuGfx17 ; $404c
DataPtr_SharedMenuGfx17Alias13:
	dw SharedMenuGfx17 ; $404e
DataPtr_SharedMenuGfx17Alias14:
	dw SharedMenuGfx17 ; $4050
DataPtr_SharedMenuGfx17Alias15:
	dw SharedMenuGfx17 ; $4052
DataPtr_SharedMenuGfx17Alias16:
	dw SharedMenuGfx17 ; $4054
DataPtr_SharedMenuGfx17Alias17:
	dw SharedMenuGfx17 ; $4056
DataPtr_NameEntryUnderlineCursorGfx:
	dw NameEntryUnderlineCursorGfx ; $4058
DataPtr_HandednessLRSpriteGfx:
	dw HandednessLRSpriteGfx ; $405a
DataPtr_LargeDigitArrowSpriteGfx:
	dw LargeDigitArrowSpriteGfx ; $405c
DataPtr_StatLabelTiles:
	dw StatLabelTiles ; $405e
	farptr SetMinigameGrid6CellPalette ; $4060
	farptr MoveMinigameGrid6Cursor ; $4062
	farptr InitNumberSpriteGfx ; $4064
	farptr DrawDecimalNumberSprites_39 ; $4066
	farptr ResetCheatCodeBuffer ; $4068
	farptr UpdateCheatCodeEntry ; $406a
DataPtr_SelectRacketLabelGfx:
	dw SelectRacketLabelGfx ; $406c
DataPtr_SelectShoesLabelGfx:
	dw SelectShoesLabelGfx ; $406e
DataPtr_MenuArrowRightGfx:
	dw MenuArrowRightGfx ; $4070
DataPtr_MenuArrowLeftGfx:
	dw MenuArrowLeftGfx ; $4072
DataPtr_MenuArrowUpGfx:
	dw MenuArrowUpGfx ; $4074
DataPtr_MenuArrowDownGfx:
	dw MenuArrowDownGfx ; $4076
DataPtr_CharGridStatLabelSpriteGfx:
	dw CharGridStatLabelSpriteGfx ; $4078
DataPtr_DigitFontTiles:
	dw DigitFontTiles ; $407a
	farptr FillIncrementingBytes ; $407c
