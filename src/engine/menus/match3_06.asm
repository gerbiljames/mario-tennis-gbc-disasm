LoadMatchMenuItemGfx:
	add a ; $5219
	ld_hl_indexed MatchMenuItemGfxPointers ; $521a
	ld a, [hl+] ; $5221
	ld h, [hl] ; $5222
	ld l, a ; $5223
	ld de, wDecompBuffer ; $5224
	push_wram_bank WRAM_STAGING ; $5227
	call DecompressData ; $5230
	ld hl, wDecompBuffer ; $5233
	ld de, vTiles0 + $40 * TILE_SIZE ; $5236
	ld c, $10 ; $5239
	call QueueVRAMCopy ; $523b
	pop_wram_bank ; $523e
	ret ; $5243
MatchMenuItemGfxPointers:
	; $5244, 48 bytes (records:2)
	dw MatchMenuItemGfx_Rules ; record 0
	dw MatchMenuItemGfx_Controls ; record 1
	dw MatchMenuItemGfx_Options ; record 2
	dw MatchMenuItemGfx_Save ; record 3
	dw MatchMenuItemGfx_CameraMode ; record 4
	dw MatchMenuItemGfx_Music ; record 5
	dw MatchMenuItemGfx_Normal ; record 6
	dw MatchMenuItemGfx_Player ; record 7
	dw MatchMenuItemGfx_On ; record 8
	dw MatchMenuItemGfx_Off ; record 9
	dw MatchMenuItemGfx_Cancel ; record 10
	dw MatchMenuItemGfx_SaveNarrow ; record 11
	dw MatchMenuItemGfx_ToMainMenu ; record 12
	dw MatchMenuItemGfx_ToLevelSelect ; record 13
	dw MatchMenuItemGfx_TryAgain ; record 14
	dw MatchMenuItemGfx_TryAgain ; record 15
	dw MatchMenuItemGfx_TryAgain ; record 16
	dw MatchMenuItemGfx_TryAgain ; record 17
	dw MatchMenuItemGfx_TryAgain ; record 18
	dw MatchMenuItemGfx_QuitMatch ; record 19
	dw MatchMenuItemGfx_QuitMinigame ; record 20
	dw MatchMenuItemGfx_QuitMinigame ; record 21
	dw MatchMenuItemGfx_QuitMinigame ; record 22
	dw MatchMenuItemGfx_QuitMinigame ; record 23
	; $5274, 12 bytes (bytes:12)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ScoreboardModeGfxTail:
	INCBIN "data/bank_006/ScoreboardModeGfxTail.bin" ; $5280, 64 bytes
MatchMenuItemGfx_Rules:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Rules.bin" ; $52c0, 130 bytes
MatchMenuItemGfx_Controls:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Controls.bin" ; $5342, 192 bytes
MatchMenuItemGfx_Options:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Options.bin" ; $5402, 147 bytes
MatchMenuItemGfx_Save:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Save.bin" ; $5495, 132 bytes
MatchMenuItemGfx_CameraMode:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_CameraMode.bin" ; $5519, 172 bytes
MatchMenuItemGfx_Music:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Music.bin" ; $55c5, 131 bytes
MatchMenuItemGfx_Normal:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Normal.bin" ; $5648, 121 bytes
MatchMenuItemGfx_Player:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Player.bin" ; $56c1, 132 bytes
MatchMenuItemGfx_On:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_On.bin" ; $5745, 124 bytes
MatchMenuItemGfx_Off:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Off.bin" ; $57c1, 131 bytes
MatchMenuItemGfx_Cancel:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_Cancel.bin" ; $5844, 129 bytes
MatchMenuItemGfx_SaveNarrow:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_SaveNarrow.bin" ; $58c5, 115 bytes
MatchMenuItemGfx_ToMainMenu:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_ToMainMenu.bin" ; $5938, 176 bytes
MatchMenuItemGfx_ToLevelSelect:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_ToLevelSelect.bin" ; $59e8, 178 bytes
MatchMenuItemGfx_TryAgain:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_TryAgain.bin" ; $5a9a, 155 bytes
MatchMenuItemGfx_QuitMatch:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_QuitMatch.bin" ; $5b35, 165 bytes
MatchMenuItemGfx_QuitMinigame:
	INCBIN "data/bank_006/lz_MatchMenuItemGfx_QuitMinigame.bin" ; $5bda, 176 bytes
LoadScoreboardModeGfx:
	ld a, [wGameMode] ; $5c8a
	cp GAMEMODE_TRAINING_DRILL ; $5c8d
	jr z, .eq05 ; $5c8f
	add a ; $5c91
	ld_hl_indexed ScoreboardModeGfxPointers ; $5c92
	jr .checkWramBank ; $5c99
.eq05:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5c9b
	add a ; $5c9e
	ld_hl_indexed ScoreboardMinigameGfxPointers ; $5c9f
.checkWramBank:
	push_wram_bank WRAM_STAGING ; $5ca6
	ld a, [hl+] ; $5caf
	ld h, [hl] ; $5cb0
	ld l, a ; $5cb1
	ld de, wDecompBuffer ; $5cb2
	call DecompressData ; $5cb5
	ld hl, wDecompBuffer ; $5cb8
	ld de, vTiles0 + $50 * TILE_SIZE ; $5cbb
	ld c, $14 ; $5cbe
	call QueueVRAMCopy ; $5cc0
	pop_wram_bank ; $5cc3
	ret ; $5cc8
ScoreboardModeGfxPointers:
	; $5cc9, 22 bytes (records:2)
	dw ScoreboardModeGfx_RankingMatch ; record 0
	dw ScoreboardModeGfx_RankingMatch ; record 1
	dw ScoreboardModeGfx_IslandOpen ; record 2
	dw ScoreboardModeGfx_PracticeMatch ; record 3
	dw ScoreboardModeGfx_Exhibition ; record 4
	dw ScoreboardModeGfx_MiniGames ; record 5
	dw ScoreboardModeGfx_TennisMachine ; record 6
	dw ScoreboardModeGfx_WallPractice ; record 7
	dw ScoreboardModeGfx_MarioMiniGames ; record 8
	dw ScoreboardModeGfx_LinkedMatch ; record 9
	dw ScoreboardModeGfx_Exhibition ; record 10
ScoreboardMinigameGfxPointers:
	; $5cdf, 84 bytes (records:2)
	dw ScoreboardModeGfx_ServiceMatch ; record 0
	dw ScoreboardModeGfx_ServiceMatch ; record 1
	dw ScoreboardModeGfx_ServiceMatch ; record 2
	dw ScoreboardModeGfx_ServicePractice ; record 3
	dw ScoreboardModeGfx_ServicePractice ; record 4
	dw ScoreboardModeGfx_ServicePractice ; record 5
	dw ScoreboardModeGfx_NetPlayMatch ; record 6
	dw ScoreboardModeGfx_NetPlayMatch ; record 7
	dw ScoreboardModeGfx_NetPlayMatch ; record 8
	dw ScoreboardModeGfx_NetPlayPractice ; record 9
	dw ScoreboardModeGfx_NetPlayPractice ; record 10
	dw ScoreboardModeGfx_NetPlayPractice ; record 11
	dw ScoreboardModeGfx_StrokeMatch ; record 12
	dw ScoreboardModeGfx_StrokeMatch ; record 13
	dw ScoreboardModeGfx_StrokeMatch ; record 14
	dw ScoreboardModeGfx_StrokePractice ; record 15
	dw ScoreboardModeGfx_StrokePractice ; record 16
	dw ScoreboardModeGfx_StrokePractice ; record 17
	dw ScoreboardModeGfx_MarioMiniGames ; record 18
	dw ScoreboardModeGfx_MarioMiniGames ; record 19
	dw ScoreboardModeGfx_MarioMiniGames ; record 20
	dw ScoreboardModeGfx_MarioMiniGames ; record 21
	dw ScoreboardModeGfx_MarioMiniGames ; record 22
	dw ScoreboardModeGfx_MarioMiniGames ; record 23
	dw ScoreboardModeGfx_MarioMiniGames ; record 24
	dw ScoreboardModeGfx_MarioMiniGames ; record 25
	dw ScoreboardModeGfx_MarioMiniGames ; record 26
	dw ScoreboardModeGfx_MarioMiniGames ; record 27
	dw ScoreboardModeGfx_MarioMiniGames ; record 28
	dw ScoreboardModeGfx_MarioMiniGames ; record 29
	dw ScoreboardModeGfx_MarioMiniGames ; record 30
	dw ScoreboardModeGfx_MarioMiniGames ; record 31
	dw ScoreboardModeGfx_MarioMiniGames ; record 32
	dw ScoreboardModeGfx_MarioMiniGames ; record 33
	dw ScoreboardModeGfx_MarioMiniGames ; record 34
	dw ScoreboardModeGfx_MarioMiniGames ; record 35
	dw ScoreboardModeGfx_MarioMiniGames ; record 36
	dw ScoreboardModeGfx_MarioMiniGames ; record 37
	dw ScoreboardModeGfx_MarioMiniGames ; record 38
	dw ScoreboardModeGfx_MarioMiniGames ; record 39
	dw ScoreboardModeGfx_MarioMiniGames ; record 40
	dw ScoreboardModeGfx_MarioMiniGames ; record 41
	; $5d33, 13 bytes (bytes:13)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ScoreboardModeGfx_RankingMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_RankingMatch.bin" ; $5d40, 181 bytes
ScoreboardModeGfx_IslandOpen:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_IslandOpen.bin" ; $5df5, 188 bytes
ScoreboardModeGfx_PracticeMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_PracticeMatch.bin" ; $5eb1, 197 bytes
ScoreboardModeGfx_Exhibition:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_Exhibition.bin" ; $5f76, 129 bytes
ScoreboardModeGfx_MiniGames:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_MiniGames.bin" ; $5ff7, 148 bytes
ScoreboardModeGfx_TennisMachine:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_TennisMachine.bin" ; $608b, 179 bytes
ScoreboardModeGfx_WallPractice:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_WallPractice.bin" ; $613e, 184 bytes
ScoreboardModeGfx_MarioMiniGames:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_MarioMiniGames.bin" ; $61f6, 197 bytes
ScoreboardModeGfx_LinkedMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_LinkedMatch.bin" ; $62bb, 170 bytes
ScoreboardModeGfx_ServiceMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_ServiceMatch.bin" ; $6365, 173 bytes
ScoreboardModeGfx_ServicePractice:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_ServicePractice.bin" ; $6412, 202 bytes
ScoreboardModeGfx_NetPlayMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_NetPlayMatch.bin" ; $64dc, 211 bytes
ScoreboardModeGfx_NetPlayPractice:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_NetPlayPractice.bin" ; $65af, 216 bytes
ScoreboardModeGfx_StrokeMatch:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_StrokeMatch.bin" ; $6687, 173 bytes
ScoreboardModeGfx_StrokePractice:
	INCBIN "data/bank_006/lz_ScoreboardModeGfx_StrokePractice.bin" ; $6734, 206 bytes
DrawMatchMenuItem:
	push af ; $6802
	push de ; $6803
	add a ; $6804
	add a ; $6805
	ld_hl_indexed MatchMenuItemRectPointers ; $6806
	ld a, [hl+] ; $680d
	ld h, [hl] ; $680e
	ld l, a ; $680f
	push hl ; $6810
	call GetShadowTilemapAddr ; $6811
	pop hl ; $6814
	lb bc, $03, $02 ; $6815 width, rows
	call CopyTextRect ; $6818
	pop de ; $681b
	pop af ; $681c
	add a ; $681d
	add a ; $681e
	ld_hl_indexed MatchMenuItemRectPointers + 2 ; $681f
	ld a, [hl+] ; $6826
	ld h, [hl] ; $6827
	ld l, a ; $6828
	push hl ; $6829
	call GetShadowAttrmapAddr ; $682a
	pop hl ; $682d
	lb bc, $03, $02 ; $682e width, rows
	call CopyTextRect ; $6831
	ret ; $6834
MatchMenuItemRectPointers:
	; $6835, 96 bytes (rect_ptrs)
	rect_ptrs MatchMenuItemRect_Rules, MatchMenuItemAttr_Rules ; item 0
	rect_ptrs MatchMenuItemRect_Controls, MatchMenuItemAttr_Controls ; item 1
	rect_ptrs MatchMenuItemRect_Options, MatchMenuItemAttr_Options ; item 2
	rect_ptrs MatchMenuItemRect_Save, MatchMenuItemAttr_Save ; item 3
	rect_ptrs MatchMenuItemRect_CameraMode, MatchMenuItemAttr_CameraMode ; item 4
	rect_ptrs MatchMenuItemRect_Music, MatchMenuItemAttr_Music ; item 5
	rect_ptrs MatchMenuItemRect_Normal, MatchMenuItemAttr_Normal ; item 6
	rect_ptrs MatchMenuItemRect_Player, MatchMenuItemAttr_Player ; item 7
	rect_ptrs MatchMenuItemRect_On, MatchMenuItemAttr_On ; item 8
	rect_ptrs MatchMenuItemRect_Off, MatchMenuItemAttr_Off ; item 9
	rect_ptrs MatchMenuItemRect_Cancel, MatchMenuItemAttr_Cancel ; item 10
	rect_ptrs MatchMenuItemRect_SaveNarrow, MatchMenuItemAttr_SaveNarrow ; item 11
	rect_ptrs MatchMenuItemRect_ToMainMenu, MatchMenuItemAttr_ToMainMenu ; item 12
	rect_ptrs MatchMenuItemRect_ToLevelSelect, MatchMenuItemAttr_ToLevelSelect ; item 13
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 14
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 15
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 16
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 17
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 18
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 19
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 20
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 21
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 22
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 23
MatchMenuItemRect_Rules:
	; $6895, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $44, $45, $46 ; row 0
	tilemap_row $54, $55, $56 ; row 1
	tilemap_end
MatchMenuItemRect_Controls:
	; $689b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $47, $48, $49 ; row 0
	tilemap_row $57, $58, $59 ; row 1
	tilemap_end
MatchMenuItemRect_Options:
	; $68a1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $40, $41, $40 ; row 0
	tilemap_row $50, $51, $50 ; row 1
	tilemap_end
MatchMenuItemRect_Save:
	; $68a7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $67, $68, $69 ; row 0
	tilemap_row $77, $78, $79 ; row 1
	tilemap_end
MatchMenuItemRect_CameraMode:
	; $68ad, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $2a, $2b, $2c ; row 0
	tilemap_row $3a, $3b, $3c ; row 1
	tilemap_end
MatchMenuItemRect_Music:
	; $68b3, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $2d, $2e, $2f ; row 0
	tilemap_row $3d, $3e, $3f ; row 1
	tilemap_end
MatchMenuItemRect_Normal:
	; $68b9, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $17, $18, $29 ; row 0
	tilemap_row $37, $38, $39 ; row 1
	tilemap_end
MatchMenuItemRect_Player:
	; $68bf, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $27, $28, $29 ; row 0
	tilemap_row $37, $38, $39 ; row 1
	tilemap_end
MatchMenuItemRect_On:
	; $68c5, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $60, $61, $60 ; row 0
	tilemap_row $70, $71, $70 ; row 1
	tilemap_end
MatchMenuItemRect_Off:
	; $68cb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $62, $63, $62 ; row 0
	tilemap_row $72, $73, $72 ; row 1
	tilemap_end
MatchMenuItemRect_Cancel:
	; $68d1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $6d, $6e, $6f ; row 0
	tilemap_row $7d, $7e, $7f ; row 1
	tilemap_end
MatchMenuItemRect_SaveNarrow:
	; $68d7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $46, $42, $43 ; row 0
	tilemap_row $56, $52, $53 ; row 1
	tilemap_end
MatchMenuItemRect_ToMainMenu:
	; $68dd, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4a, $4b, $4c ; row 0
	tilemap_row $5a, $5b, $5c ; row 1
	tilemap_end
MatchMenuItemRect_ToLevelSelect:
	; $68e3, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4d, $4e, $4f ; row 0
	tilemap_row $5d, $5e, $5f ; row 1
	tilemap_end
MatchMenuItemRect_TryAgain:
	; $68e9, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $6a, $6b, $6c ; row 0
	tilemap_row $7a, $7b, $7c ; row 1
	tilemap_end
MatchMenuItemRect_Quit:
	; $68ef, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $64, $65, $66 ; row 0
	tilemap_row $74, $75, $76 ; row 1
	tilemap_end
MatchMenuItemAttr_Rules:
	; $68f5, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Controls:
	; $68fb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Options:
	; $6901, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Save:
	; $6907, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_CameraMode:
	; $690d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Music:
	; $6913, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Normal:
	; $6919, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Player:
	; $691f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_On:
	; $6925, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Off:
	; $692b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Cancel:
	; $6931, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_SaveNarrow:
	; $6937, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $20, $00, $00 ; row 0
	tilemap_row $20, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_ToMainMenu:
	; $693d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_ToLevelSelect:
	; $6943, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_TryAgain:
	; $6949, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Quit:
	; $694f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MenuItemAttrRect3x2:
	; $6955, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
Unused_06_DrawMusicMenuRowTextRect:
	; $695b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
