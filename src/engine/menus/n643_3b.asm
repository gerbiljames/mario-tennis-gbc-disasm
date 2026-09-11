DrawTrophyRowPair:
	ld c, $00 ; $4aa3
.row1Loop:
	ld a, [hl+] ; $4aa5
	or a ; $4aa6
	jr z, .row1Next ; $4aa7
	call DrawWonTrophyIcon ; $4aa9
.row1Next:
	inc de ; $4aac
	inc de ; $4aad
	ld a, c ; $4aae
	inc a ; $4aaf
	ld c, a ; $4ab0
	cp $03 ; $4ab1
	jr nz, .row1Loop ; $4ab3
	inc de ; $4ab5
	ld c, $00 ; $4ab6
.row2Loop:
	ld a, [hl+] ; $4ab8
	or a ; $4ab9
	jr z, .row2Next ; $4aba
	call DrawWonTrophyIcon ; $4abc
.row2Next:
	inc de ; $4abf
	inc de ; $4ac0
	ld a, c ; $4ac1
	inc a ; $4ac2
	ld c, a ; $4ac3
	cp $03 ; $4ac4
	jr nz, .row2Loop ; $4ac6
	ret ; $4ac8
DrawWonTrophyIcon:
	push af ; $4ac9
	push bc ; $4aca
	push de ; $4acb
	push hl ; $4acc
	ld h, d ; $4acd
	ld l, e ; $4ace
	push hl ; $4acf
	ld a, $60 ; $4ad0
	ld [hl+], a ; $4ad2
	inc a ; $4ad3
	ld [hl], a ; $4ad4
	inc a ; $4ad5
	ld de, $001f ; $4ad6
	add hl, de ; $4ad9
	ld [hl+], a ; $4ada
	inc a ; $4adb
	ld [hl], a ; $4adc
	pop hl ; $4add
	ld de, $0400 ; $4ade
	add hl, de ; $4ae1
	ld a, $0a ; $4ae2
	ld [hl+], a ; $4ae4
	ld [hl], a ; $4ae5
	ld de, $001f ; $4ae6
	add hl, de ; $4ae9
	ld [hl+], a ; $4aea
	ld [hl], a ; $4aeb
	pop hl ; $4aec
	pop de ; $4aed
	pop bc ; $4aee
	pop af ; $4aef
	ret ; $4af0
DrawTrophiesCharSprite:
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4af1
	ld a, c ; $4af4
	add a ; $4af5
	add l ; $4af6
	ld l, a ; $4af7
	jr nc, .copyRect ; $4af8
	inc h ; $4afa
.copyRect:
	ld b, $02 ; $4afb
	ld c, $02 ; $4afd
	push hl ; $4aff
	push de ; $4b00
	farcall CopyTilemapRect ; $4b01
	pop de ; $4b04
	pop hl ; $4b05
	ld bc, $0400 ; $4b06
	add hl, bc ; $4b09
	push hl ; $4b0a
	ld h, d ; $4b0b
	ld l, e ; $4b0c
	add hl, bc ; $4b0d
	ld d, h ; $4b0e
	ld e, l ; $4b0f
	pop hl ; $4b10
	ld b, $02 ; $4b11
	ld c, $02 ; $4b13
	farcall CopyTilemapRect ; $4b15
	ret ; $4b18
CheckTrophiesCheatCode:
	sound BGM_SENIOR_RANKING ; $4b19
	ld a, [wN64RecordsBlock] ; $4b1b
	cp $0c ; $4b1e
	jp nz, .saveStorySlot ; $4b20
	ld a, [wN64RecordsBlock + 1] ; $4b23
	cp $22 ; $4b26
	jp nz, .saveStorySlot ; $4b28
	call ApplyUnlockEverythingCheat ; $4b2b
.saveStorySlot:
	farcall SaveStorySlot ; $4b2e
	xor a ; $4b31
	ret ; $4b32
ApplyUnlockEverythingCheat:
	ld de, SAVEFLAG_COURT_STAR ; $4b33
	farcall SetSaveFlag ; $4b36
	ld de, SAVEFLAG_COURT_CASTLE ; $4b39
	farcall SetSaveFlag ; $4b3c
	ld de, SAVEFLAG_COURT_TROPICS ; $4b3f
	farcall SetSaveFlag ; $4b42
	ld de, SAVEFLAG_COURT_JUNGLE ; $4b45
	farcall SetSaveFlag ; $4b48
	ld de, SAVEFLAG_COURT_WAREHOUSE ; $4b4b
	farcall SetSaveFlag ; $4b4e
	ld de, SAVEFLAG_UNLOCKED_FAY ; $4b51
	farcall SetSaveFlag ; $4b54
	ld de, SAVEFLAG_UNLOCKED_CURT ; $4b57
	farcall SetSaveFlag ; $4b5a
	ld de, SAVEFLAG_UNLOCKED_MARK ; $4b5d
	farcall SetSaveFlag ; $4b60
	ld de, SAVEFLAG_UNLOCKED_SEAN ; $4b63
	farcall SetSaveFlag ; $4b66
	ld de, SAVEFLAG_UNLOCKED_SAMMI ; $4b69
	farcall SetSaveFlag ; $4b6c
	ld de, SAVEFLAG_UNLOCKED_ELDEN ; $4b6f
	farcall SetSaveFlag ; $4b72
	ld de, SAVEFLAG_CLEARED_BOO_BLAST_1 ; $4b75
	farcall SetSaveFlag ; $4b78
	ld de, SAVEFLAG_CLEARED_BOO_BLAST_2 ; $4b7b
	farcall SetSaveFlag ; $4b7e
	ld de, SAVEFLAG_CLEARED_SHOOTING_STAR_1 ; $4b81
	farcall SetSaveFlag ; $4b84
	ld de, SAVEFLAG_CLEARED_SHOOTING_STAR_2 ; $4b87
	farcall SetSaveFlag ; $4b8a
	ld de, SAVEFLAG_CLEARED_PERFECT_SHOT_1 ; $4b8d
	farcall SetSaveFlag ; $4b90
	ld de, SAVEFLAG_CLEARED_PERFECT_SHOT_2 ; $4b93
	farcall SetSaveFlag ; $4b96
	ld de, SAVEFLAG_CLEARED_TARGET_SHOT_1 ; $4b99
	farcall SetSaveFlag ; $4b9c
	ld de, SAVEFLAG_CLEARED_TARGET_SHOT_2 ; $4b9f
	farcall SetSaveFlag ; $4ba2
	ld de, SAVEFLAG_CLEARED_FRUIT_FANTASY_1 ; $4ba5
	farcall SetSaveFlag ; $4ba8
	ld de, SAVEFLAG_CLEARED_FRUIT_FANTASY_2 ; $4bab
	farcall SetSaveFlag ; $4bae
	ld de, SAVEFLAG_CLEARED_BANANA_BUNCH_1 ; $4bb1
	farcall SetSaveFlag ; $4bb4
	ld de, SAVEFLAG_CLEARED_BANANA_BUNCH_2 ; $4bb7
	farcall SetSaveFlag ; $4bba
	ld de, SAVEFLAG_CLEARED_TREASURE_BOX_1 ; $4bbd
	farcall SetSaveFlag ; $4bc0
	ld de, SAVEFLAG_CLEARED_TREASURE_BOX_2 ; $4bc3
	farcall SetSaveFlag ; $4bc6
	ld de, SAVEFLAG_CLEARED_MEDALLION_MATCH_1 ; $4bc9
	farcall SetSaveFlag ; $4bcc
	ld de, SAVEFLAG_CLEARED_MEDALLION_MATCH_2 ; $4bcf
	farcall SetSaveFlag ; $4bd2
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_1 ; $4bd5
	farcall SetSaveFlag ; $4bd8
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_2 ; $4bdb
	farcall SetSaveFlag ; $4bde
	ld a, [wCurrentStorySlot] ; $4be1
	push af ; $4be4
	ld c, $00 ; $4be5
.loop:
	push bc ; $4be7
	ld a, c ; $4be8
	ld [wCurrentStorySlot], a ; $4be9
	farcall CheckStorySlot ; $4bec
	cp $fe ; $4bef
	jr z, .restore ; $4bf1
	ld_flag_id de, FLAG_CHEAT_UNLOCK_0 ; $4bf3
	call SetGameFlag ; $4bf6
	ld_flag_id de, FLAG_CHEAT_UNLOCK_1 ; $4bf9
	call SetGameFlag ; $4bfc
	ld_flag_id de, FLAG_CHEAT_UNLOCK_2 ; $4bff
	call SetGameFlag ; $4c02
	ld_flag_id de, FLAG_CHEAT_UNLOCK_3 ; $4c05
	call SetGameFlag ; $4c08
	ld_flag_id de, FLAG_CHEAT_UNLOCK_4 ; $4c0b
	call SetGameFlag ; $4c0e
	ld_flag_id de, FLAG_CHEAT_UNLOCK_5 ; $4c11
	call SetGameFlag ; $4c14
	ld_flag_id de, FLAG_CHEAT_UNLOCK_6 ; $4c17
	call SetGameFlag ; $4c1a
	ld_flag_id de, FLAG_CHEAT_UNLOCK_7 ; $4c1d
	call SetGameFlag ; $4c20
	ld_flag_id de, FLAG_CHEAT_UNLOCK_8 ; $4c23
	call SetGameFlag ; $4c26
	ld_flag_id de, FLAG_CHEAT_UNLOCK_9 ; $4c29
	call SetGameFlag ; $4c2c
	ld_flag_id de, FLAG_CHEAT_UNLOCK_10 ; $4c2f
	call SetGameFlag ; $4c32
	ld_flag_id de, FLAG_CHEAT_UNLOCK_11 ; $4c35
	call SetGameFlag ; $4c38
	ld_flag_id de, FLAG_CHEAT_UNLOCK_12 ; $4c3b
	call SetGameFlag ; $4c3e
	farcall SaveStorySlot ; $4c41
.restore:
	pop bc ; $4c44
	inc c ; $4c45
	ld a, c ; $4c46
	cp $03 ; $4c47
	jr nz, .loop ; $4c49
	pop af ; $4c4b
	ld [wCurrentStorySlot], a ; $4c4c
	farcall SetAllUnlockablesInSaveBlock ; $4c4f
	ret ; $4c52
DecodeTrophyCounts:
	wram_bank $03 ; $4c53
	ld hl, wTrophyCellsMainSet1 ; $4c59
	ld bc, $0018 ; $4c5c
	call ClearBytes ; $4c5f
	ld de, wTrophyCellsMainSet1 ; $4c62
	ld a, [wN64TrophyCounts] ; $4c65
	and $03 ; $4c68
	ld b, a ; $4c6a
	call FillTrophyCountCells ; $4c6b
	ld de, wTrophyCellsMainSet1 + 3 ; $4c6e
	ld a, [wN64TrophyCounts] ; $4c71
	swap a ; $4c74
	and $03 ; $4c76
	ld b, a ; $4c78
	call FillTrophyCountCells ; $4c79
	ld de, wTrophyCellsMainSet2 ; $4c7c
	ld a, [wN64TrophyCounts] ; $4c7f
	srl a ; $4c82
	srl a ; $4c84
	and $03 ; $4c86
	ld b, a ; $4c88
	call FillTrophyCountCells ; $4c89
	ld de, wTrophyCellsMainSet2 + 3 ; $4c8c
	ld a, [wN64TrophyCounts] ; $4c8f
	swap a ; $4c92
	srl a ; $4c94
	srl a ; $4c96
	and $03 ; $4c98
	ld b, a ; $4c9a
	call FillTrophyCountCells ; $4c9b
	ld de, wTrophyCellsPartnerSet1 ; $4c9e
	ld a, [wN64TrophyCounts + 1] ; $4ca1
	and $03 ; $4ca4
	ld b, a ; $4ca6
	call FillTrophyCountCells ; $4ca7
	ld de, wTrophyCellsPartnerSet1 + 3 ; $4caa
	ld a, [wN64TrophyCounts + 1] ; $4cad
	swap a ; $4cb0
	and $03 ; $4cb2
	ld b, a ; $4cb4
	call FillTrophyCountCells ; $4cb5
	ld de, wTrophyCellsPartnerSet2 ; $4cb8
	ld a, [wN64TrophyCounts + 1] ; $4cbb
	srl a ; $4cbe
	srl a ; $4cc0
	and $03 ; $4cc2
	ld b, a ; $4cc4
	call FillTrophyCountCells ; $4cc5
	ld de, wTrophyCellsPartnerSet2 + 3 ; $4cc8
	ld a, [wN64TrophyCounts + 1] ; $4ccb
	swap a ; $4cce
	srl a ; $4cd0
	srl a ; $4cd2
	and $03 ; $4cd4
	ld b, a ; $4cd6
	call FillTrophyCountCells ; $4cd7
	ld a, [wTrophyCellsMainSet2] ; $4cda
	or a ; $4cdd
	jr nz, .step ; $4cde
	ld a, [wTrophyCellsMainSet2 + 3] ; $4ce0
	or a ; $4ce3
	jr nz, .step ; $4ce4
	ld a, [wTrophyCellsPartnerSet2] ; $4ce6
	or a ; $4ce9
	jr nz, .step ; $4cea
	ld a, [wTrophyCellsPartnerSet2 + 3] ; $4cec
	or a ; $4cef
	jr nz, .step ; $4cf0
	jr .done ; $4cf2
.step:
	ld a, $01 ; $4cf4
	ld [wTrophySecondSetPresent], a ; $4cf6
.done:
	ret ; $4cf9
RunN64TnmtData:
	sound BGM_STATUS_SCREEN ; $4cfa
	call DisableLCDSafely ; $4cfc
	call BuildN64TnmtDataScreen ; $4cff
	xor a ; $4d02
	ld [wAnimatedTileSet], a ; $4d03
	ld a, $01 ; $4d06
	ld hl, UpdateAnimatedTilesTask_3b ; $4d08
	call RegisterFrameTask ; $4d0b
	ld a, $01 ; $4d0e
	ld hl, N64TnmtScrollArrowsTask ; $4d10
	call RegisterFrameTask ; $4d13
	call EnableLCD ; $4d16
	script_fade_in $10 ; $4d19
	call WaitFadeEnd ; $4d1e
	wram_bank $03 ; $4d21
.loop:
	ldh a, [hInputPressed] ; $4d27
	ld [wMenuInputPressed], a ; $4d29
	call ScrollN64TnmtDataCursor ; $4d2c
	call AdvanceFrame ; $4d2f
	ld a, [wMenuInputPressed] ; $4d32
	bit PADB_A, a ; $4d35
	jr nz, .playSfx ; $4d37
	bit 1, a ; $4d39
	jr nz, .playSfx2 ; $4d3b
	jr .loop ; $4d3d
.playSfx:
	sound SFX_MENU_SELECT ; $4d3f
	ld c, $10 ; $4d41
	call BeginFadeOut ; $4d43
	call WaitFadeEnd ; $4d46
	call ClearFrameTasks ; $4d49
	ret ; $4d4c
.playSfx2:
	sound SFX_MENU_CANCEL ; $4d4d
	ld c, $10 ; $4d4f
	call BeginFadeOut ; $4d51
	call WaitFadeEnd ; $4d54
	call ClearFrameTasks ; $4d57
	ld a, $ff ; $4d5a
	ret ; $4d5c
ScrollN64TnmtDataCursor:
	ld a, [wMenuInputPressed] ; $4d5d
	bit PADB_LEFT, a ; $4d60
	jr z, .step ; $4d62
	ld a, [wDataScreenPage] ; $4d64
	or a ; $4d67
	jr z, .done ; $4d68
	xor a ; $4d6a
	ld [wDataScreenPage], a ; $4d6b
	sound SFX_MENU_MOVE ; $4d6e
	call RedrawN64TnmtDataWindow ; $4d70
	jr .done ; $4d73
.step:
	bit 4, a ; $4d75
	jr z, .bit4Clear ; $4d77
	ld a, [wScreenScratch] ; $4d79
	or a ; $4d7c
	jr z, .done ; $4d7d
	ld a, [wDataScreenPage] ; $4d7f
	or a ; $4d82
	jr nz, .done ; $4d83
	ld a, $01 ; $4d85
	ld [wDataScreenPage], a ; $4d87
	sound SFX_MENU_MOVE ; $4d8a
	call RedrawN64TnmtDataWindow ; $4d8c
	jr .done ; $4d8f
.bit4Clear:
	bit 6, a ; $4d91
	jr z, .bit6Clear ; $4d93
	ld a, [wDataScreenCursorRow] ; $4d95
	or a ; $4d98
	jr z, .done ; $4d99
	dec a ; $4d9b
	ld [wDataScreenCursorRow], a ; $4d9c
	sound SFX_MENU_MOVE ; $4d9f
	call RedrawN64TnmtDataWindow ; $4da1
	jr .done ; $4da4
.bit6Clear:
	bit 7, a ; $4da6
	jr z, .done ; $4da8
	ld a, [wDataScreenCursorRow] ; $4daa
	cp $0b ; $4dad
	jr z, .done ; $4daf
	inc a ; $4db1
	ld [wDataScreenCursorRow], a ; $4db2
	sound SFX_MENU_MOVE ; $4db5
	call RedrawN64TnmtDataWindow ; $4db7
	jr .done ; $4dba
.done:
	ret ; $4dbc
BuildN64TnmtDataScreen:
	ld c, SCREENASSET_ModeSelect ; $4dbd
	farcall LoadScreenAssetRecord ; $4dbf
	wram_bank $03 ; $4dc2
	xor a ; $4dc8
	ld [wScreenScratch], a ; $4dc9
	ld a, $00 ; $4dcc
	ld [wDataScreenPage], a ; $4dce
	ld a, $00 ; $4dd1
	ld [wDataScreenCursorRow], a ; $4dd3
	call LoadN64TnmtDataRecords ; $4dd6
	wram_bank $03 ; $4dd9
	ld de, $8ac0 + VRAM_BANK1 ; $4ddf
	call LoadChartWindowTiles ; $4de2
	ld de, vTiles0 + VRAM_BANK1 ; $4de5
	farcall LoadMenuArrowSpriteTiles ; $4de8
	ld b, $08 ; $4deb
	ld c, $0f ; $4ded
	farcall LoadIndexedPalette ; $4def
	call DrawN64TnmtRowIcons ; $4df2
	call DrawN64TnmtPageLabels ; $4df5
	call DrawN64TnmtTrophyRows ; $4df8
	farcall QueueWram3MapToVRAM ; $4dfb
	ret ; $4dfe
LoadN64TnmtDataRecords:
	wram_bank $03 ; $4dff
	ld hl, wScreenScratch ; $4e05
	ld bc, $0080 ; $4e08
	call ClearMemory16 ; $4e0b
	ld hl, N64TnmtData ; $4e0e
	ld de, wN64TnmtLayout ; $4e11
	ld bc, $0010 ; $4e14
	call CopyMemoryBC ; $4e17
	call ReadN64RecordsSaveBlock ; $4e1a
	ld hl, wN64RecordsBlock + 344 ; $4e1d
	ld a, [hl] ; $4e20
	ld b, a ; $4e21
	and $01 ; $4e22
	jr nz, .maskSet ; $4e24
	ld a, $10 ; $4e26
	ld [wN64TnmtLayout + 14], a ; $4e28
.maskSet:
	ld a, b ; $4e2b
	and $02 ; $4e2c
	jr nz, .buildN64TnmtTrophyGrid ; $4e2e
	ld a, $10 ; $4e30
	ld [wN64TnmtLayout + 15], a ; $4e32
.buildN64TnmtTrophyGrid:
	call BuildN64TnmtTrophyGrid ; $4e35
	call CheckN64TnmtSecondPage ; $4e38
	or a ; $4e3b
	jr z, .done ; $4e3c
	ld a, $01 ; $4e3e
	ld [wScreenScratch], a ; $4e40
.done:
	ret ; $4e43
N64TnmtData:
	; $4e44, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
BuildN64TnmtTrophyGrid:
	ld de, wN64TnmtTrophyCells ; $4e54
	ld hl, wN64RecordsBlock + 8 ; $4e57
	ld c, $00 ; $4e5a
.loop:
	ld b, c ; $4e5c
	call GetN64CharTrophyRowPtr ; $4e5d
	call DecodeN64CharTrophyCounts ; $4e60
	push hl ; $4e63
	ld hl, $000c ; $4e64
	add hl, de ; $4e67
	ld d, h ; $4e68
	ld e, l ; $4e69
	pop hl ; $4e6a
	inc hl ; $4e6b
	ld a, c ; $4e6c
	inc a ; $4e6d
	ld c, a ; $4e6e
	cp $10 ; $4e6f
	jr nz, .loop ; $4e71
	ret ; $4e73
GetN64CharTrophyRowPtr:
	ld a, b ; $4e74
	ld hl, N64CharTrophyRowPtrTable ; $4e75
	add l ; $4e78
	ld l, a ; $4e79
	jr nc, .read ; $4e7a
	inc h ; $4e7c
.read:
	ld a, [hl] ; $4e7d
	ld hl, wN64RecordsBlock + 8 ; $4e7e
	add l ; $4e81
	ld l, a ; $4e82
	jr nc, .done ; $4e83
	inc h ; $4e85
.done:
	ret ; $4e86
N64CharTrophyRowPtrTable:
	; $4e87, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
