	farptr DecompressCharMugshot ; $4000
	farptr LoadIndexedPaletteThunk ; $4002
	farptr StubNop_1b_05 ; $4004
	farptr StubNop_1b_06 ; $4006
	farptr StubNop_1b_06Alias1, StubNop_1b_06 ; $4008
	farptr StubNop_1b_04 ; $400a
	farptr ResetMugshotPalettes_1b ; $400c
	farptr SetMugshotAttrs ; $400e
	farptr LoadCharMugshotToBuffer ; $4010
	farptr StubNop_1b_01 ; $4012
	farptr StubNop_1b_02 ; $4014
	farptr StubNop_1b_03 ; $4016
	farptr CopyMugshotBufferToVram ; $4018
	farptr ShowRankingBoard ; $401a
	farptr UpdateCharSelectSelection ; $401c
	farptr RunStoryDataConfirmMenu ; $401e
	farptr ShowNoN64DataFoundScreen ; $4020
	farptr RunNewGameSetup ; $4022
	farptr Unused_1b_RunDebugSaveDataFlow ; $4024
	farptr Unused_1b_RunMinigameFlagsDebugScreen ; $4026
	farptr RunMinigameLevelSelect ; $4028
	farptr RunSavedDataTypeSelect ; $402a
	farptr ShowMinigameDataScreen ; $402c
DataPtr_ObjectSceneAGfx0:
	dw ObjectSceneAGfx0 ; $402e
DataPtr_ObjectSceneAGfx1:
	dw ObjectSceneAGfx1 ; $4030
DataPtr_ObjectSceneAGfx2:
	dw ObjectSceneAGfx2 ; $4032
DataPtr_ObjectSceneBGfx0:
	dw ObjectSceneBGfx0 ; $4034
DataPtr_ObjectSceneBGfx1:
	dw ObjectSceneBGfx1 ; $4036
DataPtr_ObjectSceneBGfx2:
	dw ObjectSceneBGfx2 ; $4038
DataPtr_Screen0Gfx:
	dw Screen0Gfx ; $403a
DataPtr_Screen1ObjGfx:
	dw Screen1ObjGfx ; $403c
DataPtr_Screen2ObjGfx:
	dw Screen2ObjGfx ; $403e
