GrantDriveRacketForSpinLead:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $6c62
	jr nz, .isWonSeniorSinglesRank1 ; $6c65
	ret ; $6c67
.isWonSeniorSinglesRank1:
	ld a, [wStoryMainPowerLevel] ; $6c68
	ld b, a ; $6c6b
	ld a, [wStoryMainSpinLevel] ; $6c6c
	sub b ; $6c6f
	bit 7, a ; $6c70
	ret nz ; $6c72
	cp $05 ; $6c73
	jr nc, .setFlag ; $6c75
	ret ; $6c77
.setFlag:
	set_flag FLAG_HAVE_DRIVE_RACKET ; $6c78
	ret ; $6c7b
GrantLargeRacket:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6c7c
	jr nz, .setFlag ; $6c7f
	ret ; $6c81
.setFlag:
	set_flag FLAG_HAVE_LARGE_RACKET ; $6c82
	ret ; $6c85
GrantSmallRacketAndLightShoes:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $6c86
	jr nz, .setFlag ; $6c89
	ret ; $6c8b
.setFlag:
	set_flag FLAG_HAVE_SMALL_RACKET ; $6c8c
	set_flag FLAG_HAVE_LIGHT_SHOES ; $6c8f
	ret ; $6c92
GrantIronRacketAndShoes:
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $6c93
	jr nz, .setFlag ; $6c96
	ret ; $6c98
.setFlag:
	set_flag FLAG_HAVE_IRON_RACKET ; $6c99
	set_flag FLAG_HAVE_IRON_SHOES ; $6c9c
	ret ; $6c9f
GrantRankEquipment:
	call GrantLargeRacket ; $6ca0
	call GrantSmallRacketAndLightShoes ; $6ca3
	call GrantIronRacketAndShoes ; $6ca6
	ret ; $6ca9
SetRewardGameFlag:
	push af ; $6caa
	push bc ; $6cab
	push de ; $6cac
	push hl ; $6cad
	ld a, [wCurrentMatchList] ; $6cae
	add a ; $6cb1
	ld hl, RewardFlagListPtrs_1e ; $6cb2
	add_hl_a ; $6cb5
	ld a, [hl+] ; $6cba
	ld h, [hl] ; $6cbb
	ld l, a ; $6cbc
	call GetRewardTableIndex ; $6cbd
	add a ; $6cc0
	add_hl_a ; $6cc1
	ld a, [hl+] ; $6cc6
	ld d, [hl] ; $6cc7
	ld e, a ; $6cc8
	call SetGameFlag ; $6cc9
	pop hl ; $6ccc
	pop de ; $6ccd
	pop bc ; $6cce
	pop af ; $6ccf
	ret ; $6cd0
TestRewardGameFlag:
	push bc ; $6cd1
	push de ; $6cd2
	push hl ; $6cd3
	ld a, [wCurrentMatchList] ; $6cd4
	add a ; $6cd7
	ld hl, RewardFlagListPtrs_1e ; $6cd8
	add_hl_a ; $6cdb
	ld a, [hl+] ; $6ce0
	ld h, [hl] ; $6ce1
	ld l, a ; $6ce2
	call GetRewardTableIndex ; $6ce3
	add a ; $6ce6
	add_hl_a ; $6ce7
	ld a, [hl+] ; $6cec
	ld d, [hl] ; $6ced
	ld e, a ; $6cee
	call TestGameFlag ; $6cef
	pop hl ; $6cf2
	pop de ; $6cf3
	pop bc ; $6cf4
	ret ; $6cf5
GetRewardTableIndex:
	ld a, [wCurrentMatchList] ; $6cf6
	cp MATCHLIST_TRAINING ; $6cf9
	ld a, [wCurrentMatchIndex] ; $6cfb
	ret nz ; $6cfe
	cp MINIGAME_TENNIS_MACHINE_HIGH_SCORE ; $6cff
	ret c ; $6d01
	jr nz, .wallMaster ; $6d02
	test_flag FLAG_CLEARED_MACHINE_MASTER ; $6d04
	jr z, .doneMachineMaster ; $6d07
	add $02 ; $6d09
.doneMachineMaster:
	ret ; $6d0b
.wallMaster:
	test_flag FLAG_CLEARED_WALL_MASTER ; $6d0c
	jr z, .doneWallMaster ; $6d0f
	add $02 ; $6d11
.doneWallMaster:
	ret ; $6d13
RewardFlagListPtrs_1e:
	; $6d14, 8 bytes (records:2)
	dw RewardFlagListSingles_1e ; record 0
	dw RewardFlagListDoubles_1e ; record 1
	dw RewardFlagListTraining_1e ; record 2
	dw $0000 ; record 3
RewardFlagListSingles_1e:
	; $6d1c, 50 bytes (flag_ids)
	dw $0000 ; 0: none
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_4 ; 1
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_3 ; 2
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_2 ; 3
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1 ; 4
	dw $0000 ; 5: none
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_4 ; 6
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_3 ; 7
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_2 ; 8
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1 ; 9
	dw $0000 ; 10: none
	flag_id FLAG_WON_VARSITY_SINGLES_RANK_4 ; 11
	dw $0000 ; 12: none
	dw $0000 ; 13: none
	dw $0000 ; 14: none
	dw $0000 ; 15: none
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; 16
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; 17
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; 18
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 19
	dw $0000 ; 20: none
	dw $0000 ; 21: none
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 22
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 23
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 24
RewardFlagListDoubles_1e:
	; $6d4e, 50 bytes (flag_ids)
	dw $0000 ; 0: none
	dw $0000 ; 1: none
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; 2
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; 3
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; 4
	dw $0000 ; 5: none
	dw $0000 ; 6: none
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_3 ; 7
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_2 ; 8
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1 ; 9
	dw $0000 ; 10: none
	dw $0000 ; 11: none
	dw $0000 ; 12: none
	flag_id FLAG_WON_VARSITY_DOUBLES_RANK_2 ; 13
	dw $0000 ; 14: none
	dw $0000 ; 15: none
	dw $0000 ; 16: none
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; 17
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; 18
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; 19
	dw $0000 ; 20: none
	dw $0000 ; 21: none
	flag_id FLAG_WON_DREAM_MATCH_DOUBLES ; 22
	flag_id FLAG_WON_DREAM_MATCH_DOUBLES ; 23
	flag_id FLAG_WON_DREAM_MATCH_DOUBLES ; 24
ProgressEntryFlagList_1e:
	; $6d80, 2 bytes (flag_ids)
	flag_id FLAG_TEMP_COURT_STAR_EARNED ; 0
; Ten flags here, but CheckAllProgressComplete walks 36 (`ld c, $24`): it runs straight on into RewardFlagListTraining_1e's 26 drill, machine and wall clears. All 36 set -- both Dream Matches, every class's rank-1 win in both arcs, both Island Open finals, every training clear -- is what grants SAVEFLAG_COURT_STAR.
AllProgressFlagList_1e:
	; $6d82, 20 bytes (flag_ids)
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 0
	flag_id FLAG_WON_DREAM_MATCH_DOUBLES ; 1
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1 ; 2
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; 3
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1 ; 4
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1 ; 5
	flag_id FLAG_WON_VARSITY_SINGLES_RANK_4 ; 6
	flag_id FLAG_WON_VARSITY_DOUBLES_RANK_2 ; 7
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 8
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; 9
RewardFlagListTraining_1e:
	; $6d96, 60 bytes (flag_ids)
	flag_id FLAG_CLEARED_SERVICE_MATCH_1 ; 0
	flag_id FLAG_CLEARED_SERVICE_MATCH_2 ; 1
	flag_id FLAG_CLEARED_SERVICE_MATCH_3 ; 2
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_1 ; 3
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_2 ; 4
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_3 ; 5
	flag_id FLAG_CLEARED_NET_GAME_MATCH_1 ; 6
	flag_id FLAG_CLEARED_NET_GAME_MATCH_2 ; 7
	flag_id FLAG_CLEARED_NET_GAME_MATCH_3 ; 8
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_1 ; 9
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_2 ; 10
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_3 ; 11
	flag_id FLAG_CLEARED_STROKE_MATCH_1 ; 12
	flag_id FLAG_CLEARED_STROKE_MATCH_2 ; 13
	flag_id FLAG_CLEARED_STROKE_MATCH_3 ; 14
	flag_id FLAG_CLEARED_STROKE_PRACTICE_1 ; 15
	flag_id FLAG_CLEARED_STROKE_PRACTICE_2 ; 16
	flag_id FLAG_CLEARED_STROKE_PRACTICE_3 ; 17
	flag_id FLAG_CLEARED_MACHINE_LEVEL_1 ; 18
	flag_id FLAG_CLEARED_MACHINE_LEVEL_2 ; 19
	flag_id FLAG_CLEARED_MACHINE_LEVEL_3 ; 20
	flag_id FLAG_CLEARED_MACHINE_LEVEL_4 ; 21
	flag_id FLAG_CLEARED_WALL_LEVEL_1 ; 22
	flag_id FLAG_CLEARED_WALL_LEVEL_2 ; 23
	flag_id FLAG_CLEARED_WALL_LEVEL_3 ; 24
	flag_id FLAG_CLEARED_WALL_LEVEL_4 ; 25
	flag_id FLAG_CLEARED_MACHINE_MASTER ; 26
	flag_id FLAG_CLEARED_WALL_MASTER ; 27
	flag_id FLAG_CLEARED_MACHINE_EXPERT ; 28
	flag_id FLAG_CLEARED_WALL_EXPERT ; 29
ProgressEntryRevealFlags_1e:
	; $6dd2, 74 bytes (flag_ids)
	flag_id FLAG_TEMP_COURT_STAR_EARNED ; 0
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 1
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; 2
	dw $0000 ; 3: none
	dw $0000 ; 4: none
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1 ; 5
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; 6
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1 ; 7
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1 ; 8
	flag_id FLAG_WON_VARSITY_SINGLES_RANK_4 ; 9
	flag_id FLAG_WON_VARSITY_DOUBLES_RANK_2 ; 10
	dw $0000 ; 11: none
	flag_id FLAG_CLEARED_SERVICE_MATCH_1 ; 12
	flag_id FLAG_CLEARED_SERVICE_MATCH_2 ; 13
	dw $0000 ; 14: none
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_1 ; 15
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_2 ; 16
	dw $0000 ; 17: none
	flag_id FLAG_CLEARED_NET_GAME_MATCH_1 ; 18
	flag_id FLAG_CLEARED_NET_GAME_MATCH_2 ; 19
	dw $0000 ; 20: none
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_1 ; 21
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_2 ; 22
	dw $0000 ; 23: none
	flag_id FLAG_CLEARED_STROKE_MATCH_1 ; 24
	flag_id FLAG_CLEARED_STROKE_MATCH_2 ; 25
	dw $0000 ; 26: none
	flag_id FLAG_CLEARED_STROKE_PRACTICE_1 ; 27
	flag_id FLAG_CLEARED_STROKE_PRACTICE_2 ; 28
	dw $0000 ; 29: none
	flag_id FLAG_CLEARED_MACHINE_LEVEL_1 ; 30
	flag_id FLAG_CLEARED_MACHINE_LEVEL_2 ; 31
	flag_id FLAG_CLEARED_MACHINE_LEVEL_3 ; 32
	dw $0000 ; 33: none
	flag_id FLAG_CLEARED_WALL_LEVEL_1 ; 34
	flag_id FLAG_CLEARED_WALL_LEVEL_2 ; 35
	flag_id FLAG_CLEARED_WALL_LEVEL_3 ; 36
ApplyRewardUnlockFlags:
	ld c, $00 ; $6e1c
	ld b, $0d ; $6e1e
	ld a, c ; $6e20
	add a ; $6e21
	add a ; $6e22
	ld hl, RewardUnlockConditionFlags ; $6e23
	add l ; $6e26
	ld l, a ; $6e27
	jr nc, .loop ; $6e28
	inc h ; $6e2a
.loop:
	ld a, [hl+] ; $6e2b
	ld d, [hl] ; $6e2c
	ld e, a ; $6e2d
	inc hl ; $6e2e
	ld a, d ; $6e2f
	or e ; $6e30
	jr z, .read ; $6e31
	call TestGameFlag ; $6e33
	jr z, .read ; $6e36
	call SetRewardUnlockFlag ; $6e38
.read:
	ld a, [hl+] ; $6e3b
	ld d, [hl] ; $6e3c
	ld e, a ; $6e3d
	inc hl ; $6e3e
	ld a, d ; $6e3f
	or e ; $6e40
	jr z, .next ; $6e41
	call TestGameFlag ; $6e43
	jr z, .next ; $6e46
	call SetRewardUnlockFlag ; $6e48
.next:
	inc c ; $6e4b
	dec b ; $6e4c
	jr nz, .loop ; $6e4d
	ret ; $6e4f
SetRewardUnlockFlag:
	push hl ; $6e50
	ld a, c ; $6e51
	add a ; $6e52
	ld hl, RewardUnlockCharFlags ; $6e53
	add_hl_a ; $6e56
	ld a, [hl+] ; $6e5b
	ld d, [hl] ; $6e5c
	ld e, a ; $6e5d
	call SetGameFlag ; $6e5e
	pop hl ; $6e61
	ret ; $6e62
RewardUnlockCharFlags:
	; $6e63, 26 bytes (flag_ids)
	flag_id FLAG_UNLOCKED_PAM
	flag_id FLAG_UNLOCKED_BOB
	flag_id FLAG_UNLOCKED_BETH
	flag_id FLAG_UNLOCKED_FAY
	flag_id FLAG_UNLOCKED_CURT
	flag_id FLAG_UNLOCKED_MARK
	flag_id FLAG_UNLOCKED_SEAN
	flag_id FLAG_UNLOCKED_SAMMI
	flag_id FLAG_UNLOCKED_ELDEN
	flag_id FLAG_UNLOCKED_SPIKE
	flag_id FLAG_UNLOCKED_EMILY
	flag_id FLAG_UNLOCKED_B_COZ
	flag_id FLAG_UNLOCKED_A_COZ
RewardUnlockConditionFlags:
	; $6e7d, 52 bytes (flag_ids)
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1
	flag_id FLAG_WON_JUNIOR_SINGLES_RANK_1
	flag_id FLAG_WON_JUNIOR_DOUBLES_RANK_1
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1
	flag_id FLAG_WON_SENIOR_SINGLES_RANK_1
	flag_id FLAG_WON_SENIOR_DOUBLES_RANK_1
	flag_id FLAG_WON_VARSITY_DOUBLES_RANK_2
	dw $0000
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1
	dw $0000
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL
	dw $0000
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL
	dw $0000
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL
	dw $0000
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL
	flag_id FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL
UnlockCourtForMinigameRecord:
	ld a, [wCurrentMatchIndex] ; $6eb1
	cp MINIGAME_SHOOTING_STAR ; $6eb4
	jr nz, .notShootingStar ; $6eb6
	push de ; $6eb8
	ld de, SAVEFLAG_COURT_CASTLE ; $6eb9
	farcall SetSaveFlag ; $6ebc
	pop de ; $6ebf
	ret ; $6ec0
.notShootingStar:
	cp MINIGAME_TARGET_SHOT ; $6ec1
	jr nz, .notTargetShot ; $6ec3
	push de ; $6ec5
	ld de, SAVEFLAG_COURT_TROPICS ; $6ec6
	farcall SetSaveFlag ; $6ec9
	pop de ; $6ecc
	ret ; $6ecd
.notTargetShot:
	cp MINIGAME_BANANA_BUNCH ; $6ece
	jr nz, .done ; $6ed0
	push de ; $6ed2
	ld de, SAVEFLAG_COURT_JUNGLE ; $6ed3
	farcall SetSaveFlag ; $6ed6
	pop de ; $6ed9
	ret ; $6eda
.done:
	ret ; $6edb
SetMinigameClearFlag:
	ld a, [wCurrentMatchIndex] ; $6edc
	sub MINIGAME_BOO_BLAST ; $6edf
	bit 7, a ; $6ee1
	ret nz ; $6ee3
	add a ; $6ee4
	ld h, $00 ; $6ee5
	ld l, a ; $6ee7
	add hl, hl ; $6ee8
	add_hl_a ; $6ee9
	ld a, [wMinigameLevel] ; $6eee
	add a ; $6ef1
	add_hl_a ; $6ef2
	ld de, MinigameClearFlagTable_1e ; $6ef7
	add hl, de ; $6efa
	ld a, [hl+] ; $6efb
	ld d, [hl] ; $6efc
	ld e, a ; $6efd
	farcall SetSaveFlag ; $6efe
	ret ; $6f01
MinigameClearFlagTable_1e:
	; $6f02, 54 bytes (save_flag_ids)
	dw SAVEFLAG_CLEARED_BOO_BLAST_1 ; 0
	dw SAVEFLAG_CLEARED_BOO_BLAST_2 ; 1
	dw SAVEFLAG_CLEARED_BOO_BLAST_3 ; 2
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_1 ; 3
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_2 ; 4
	dw SAVEFLAG_CLEARED_SHOOTING_STAR_3 ; 5
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_1 ; 6
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_2 ; 7
	dw SAVEFLAG_CLEARED_PERFECT_SHOT_3 ; 8
	dw SAVEFLAG_CLEARED_TARGET_SHOT_1 ; 9
	dw SAVEFLAG_CLEARED_TARGET_SHOT_2 ; 10
	dw SAVEFLAG_CLEARED_TARGET_SHOT_3 ; 11
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_1 ; 12
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_2 ; 13
	dw SAVEFLAG_CLEARED_FRUIT_FANTASY_3 ; 14
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_1 ; 15
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_2 ; 16
	dw SAVEFLAG_CLEARED_BANANA_BUNCH_3 ; 17
	dw SAVEFLAG_CLEARED_TREASURE_BOX_1 ; 18
	dw SAVEFLAG_CLEARED_TREASURE_BOX_2 ; 19
	dw SAVEFLAG_CLEARED_TREASURE_BOX_3 ; 20
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_1 ; 21
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_2 ; 22
	dw SAVEFLAG_CLEARED_MEDALLION_MATCH_3 ; 23
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_1 ; 24
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_2 ; 25
	dw SAVEFLAG_CLEARED_TWO_ON_ONE_3 ; 26
UpdateMinigameBestScore:
	ldh a, [hWramBank] ; $6f38
	push af ; $6f3a
	ld a, [wMinigameLevel] ; $6f3b
	cp MINIGAMELEVEL_HIGH_SCORE ; $6f3e
	jr nz, .restore ; $6f40
	ld a, [wCurrentMatchIndex] ; $6f42
	sub MINIGAME_BOO_BLAST ; $6f45
	bit 7, a ; $6f47
	jr nz, .restore ; $6f49
	cp $09 ; $6f4b
	jr nc, .restore ; $6f4d
	inc a ; $6f4f
	inc a ; $6f50
	farcall ReadMinigameRecord ; $6f51
	wram_bank WRAM_SOUND ; $6f54
	ld hl, wMinigameRecordValue ; $6f5a
	ld a, [hl+] ; $6f5d
	ld d, [hl] ; $6f5e
	ld e, a ; $6f5f
	ld hl, wMinigamesCurrentScore ; $6f60
	ld a, [hl+] ; $6f63
	ld b, [hl] ; $6f64
	ld c, a ; $6f65
	ld h, d ; $6f66
	ld l, e ; $6f67
	ld d, b ; $6f68
	ld e, c ; $6f69
	sub_hl_bc ; $6f6a
	bit 7, h ; $6f70
	jr z, .restore ; $6f72
	ld hl, wMinigameRecordValue ; $6f74
	ld a, e ; $6f77
	ld [hl+], a ; $6f78
	ld [hl], d ; $6f79
	ld a, [wCurrentMatchIndex] ; $6f7a
	sub MINIGAME_BOO_BLAST ; $6f7d
	inc a ; $6f7f
	inc a ; $6f80
	farcall UpdateMinigameRecord ; $6f81
	call UnlockCourtForMinigameRecord ; $6f84
.restore:
	pop_wram_bank ; $6f87
	ret ; $6f8c
