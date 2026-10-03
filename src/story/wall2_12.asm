RelaunchWallPracticeMasterLevel:
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $49cd
	ld [wStoryModeCurrentLocation], a ; $49cf
	ld a, $0a ; $49d2
	ld [wStoryModeEntryPoint], a ; $49d4
	ld a, $ff ; $49d7
	ld [wUnusedExitTriggerIdMirror], a ; $49d9
	ld [wStoryModeExitTriggerRequest], a ; $49dc
	ld a, MINIGAME_WALL_PRACTICE_HIGH_SCORE ; $49df
	farcall RunTrainingDrillByID ; $49e1
	ret ; $49e4
.carry:
	push_wram_bank WRAM_SOUND ; $49e5
	ld hl, wMinigamesCurrentScore ; $49ee
	ld a, [hl+] ; $49f1
	ld d, [hl] ; $49f2
	ld e, a ; $49f3
	ld hl, wMinigameRecordValue ; $49f4
	ld a, e ; $49f7
	ld [hl+], a ; $49f8
	ld [hl], d ; $49f9
	ld a, $00 ; $49fa
	farcall UpdateMinigameRecord ; $49fc
	pop_wram_bank ; $49ff
	script_set_speed ACTOR_PLAYER, $0020 ; $4a04
	script_move_target ACTOR_PLAYER, 5.0, 49.0 ; $4a0c
	script_wait_move ACTOR_PLAYER ; $4a17
	script_move_player 5.0, 55.0 ; $4a1c
	script_move_target ACTOR_PLAYER, 5.0, 57.0 ; $4a26
	script_wait_move ACTOR_PLAYER ; $4a31
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 5.0, 55.0 ; $4a36
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4a41
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_DOWN ; $4a46
	script_face ACTOR_PLAYER, FACE_UP ; $4a4d
	script_wait_frames 50 ; $4a54
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4a5b
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4a62
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4a67
.checkDoubles:
	test_flag FLAG_DOUBLES ; $4a6c
	jr z, .done ; $4a6f
	script_wait_frames 40 ; $4a71
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $4a78
	script_wait_frames 30 ; $4a80
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4a87
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4a8e
	script_wait_idle ACTOR_PARTNER ; $4a95
	script_get_actor_state ACTOR_PARTNER ; $4a9a
	ld c, l ; $4a9f
	ld b, h ; $4aa0
	ld de, wActors ; $4aa1
	farcall AttachActorStepMover ; $4aa4
	script_wait_frames 40 ; $4aa7
.done:
	ret ; $4aae
WallPracticeScoreRetryPromptTextIds:
	; $4aaf, 6 bytes (text_ids)
	dw Text_35_247 ; record 0
	dw Text_35_248 ; record 1
	dw Text_35_249 ; record 2
WallPracticeLevelResultScript:
	xor a ; $4ab5
	ld [wStoryModeShowLocationName], a ; $4ab6
	ld a, [wPointWinLoseFlag] ; $4ab9
	cp WINLOSE_WIN ; $4abc
	jp nz, .checkLevel ; $4abe
	ld a, [wMapSceneStage] ; $4ac1
	sub $01 ; $4ac4
	ld a, a ; $4ac6
	rst Rst00 ; $4ac7
	dw WallPracticeLevelResultScript.variant4 ; $4ac8 jumptable
	dw WallPracticeLevelResultScript.variant3 ; $4aca jumptable
	dw WallPracticeLevelResultScript.variant2 ; $4acc jumptable
	dw WallPracticeLevelResultScript.variant1 ; $4ace jumptable
.checkLevel:
	ld a, [wMapSceneStage] ; $4ad0
	cp WALLPRACTICESTAGE_MASTER ; $4ad3
	jp z, WallPracticeScoreRetryPrompt ; $4ad5
	script_fade_in $06 ; $4ad8
	call WaitFadeEnd ; $4add
	ld a, [wPointOutcome] ; $4ae0
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4ae3
	jr nz, .fromOutcome ; $4ae5
	script_set_text Text_35_246 ; $4ae7
	jr .speak ; $4aed
.fromOutcome:
	ld a, [wPointOutcome] ; $4aef
	and $03 ; $4af2
	add a ; $4af4
	ld_hl_indexed WallPracticeLevelResultScriptTextIds ; $4af5
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	farcall InitDialogueTextCursor ; $4aff
.speak:
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4b02
	farcall RunDialogueYesNoPrompt ; $4b07
	farcall ScriptCloseDialogueWindow ; $4b0a
	script_wait_frames 5 ; $4b0d
	and a ; $4b14
	jp nz, WallPracticeExitCourtScript ; $4b15
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $4b18
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4b1f
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4b26
	jp LaunchWallPracticeMinigame ; $4b2b
WallPracticeExitCourtScript:
	script_set_text Text_35_251 ; $4b2e
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4b34
	script_set_speed ACTOR_PLAYER, $0020 ; $4b39
	script_move_target ACTOR_PLAYER, 5.0, 49.0 ; $4b41
	script_wait_move ACTOR_PLAYER ; $4b4c
	script_move_player 5.0, 55.0 ; $4b51
	script_move_target ACTOR_PLAYER, 5.0, 57.0 ; $4b5b
	script_wait_move ACTOR_PLAYER ; $4b66
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 5.0, 55.0 ; $4b6b
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4b76
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_DOWN ; $4b7b
	test_flag FLAG_DOUBLES ; $4b82
	jr z, .done ; $4b85
	script_get_actor_state ACTOR_PARTNER ; $4b87
	ld c, l ; $4b8c
	ld b, h ; $4b8d
	ld de, wActors ; $4b8e
	farcall AttachActorStepMover ; $4b91
.done:
	script_wait_frames 10 ; $4b94
	ret ; $4b9b
WallPracticeLevelResultScriptTextIds:
	; $4b9c, 6 bytes (text_ids)
	dw Text_35_243 ; record 0
	dw Text_35_244 ; record 1
	dw Text_35_245 ; record 2
WallPracticeLevelResultScript.variant1:
	script_set_text Text_35_255 ; $4ba2
	script_fade_in $06 ; $4ba8
	call WaitFadeEnd ; $4bad
	jr WallPracticeLevelResultScript.speakAndLeave ; $4bb0
WallPracticeLevelResultScript.variant2:
	push_wram_bank WRAM_SOUND ; $4bb2
	ld de, $0032 ; $4bbb
	ld hl, wMinigameRecordValue ; $4bbe
	ld a, e ; $4bc1
	ld [hl+], a ; $4bc2
	ld [hl], d ; $4bc3
	ld a, $00 ; $4bc4
	farcall UpdateMinigameRecord ; $4bc6
	pop_wram_bank ; $4bc9
	script_set_text Text_35_254 ; $4bce
	script_fade_in $06 ; $4bd4
	call WaitFadeEnd ; $4bd9
	jr WallPracticeLevelResultScript.speakAndLeave ; $4bdc
WallPracticeLevelResultScript.variant3:
	script_set_text Text_35_253 ; $4bde
	script_fade_in $06 ; $4be4
	call WaitFadeEnd ; $4be9
	jr WallPracticeLevelResultScript.speakAndLeave ; $4bec
WallPracticeLevelResultScript.variant4:
	script_set_text Text_35_252 ; $4bee
	script_fade_in $06 ; $4bf4
	call WaitFadeEnd ; $4bf9
WallPracticeLevelResultScript.speakAndLeave:
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4bfc
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4c03
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4c08
	script_set_speed ACTOR_PLAYER, $0020 ; $4c0d
	script_move_target ACTOR_PLAYER, 5.0, 49.0 ; $4c15
	script_wait_move ACTOR_PLAYER ; $4c20
	script_move_player 5.0, 55.0 ; $4c25
	script_move_target ACTOR_PLAYER, 5.0, 57.0 ; $4c2f
	script_wait_move ACTOR_PLAYER ; $4c3a
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 5.0, 55.0 ; $4c3f
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4c4a
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_DOWN ; $4c4f
	test_flag FLAG_DOUBLES ; $4c56
	jr z, WallPracticeLevelResultScript.wait ; $4c59
	script_wait_frames 30 ; $4c5b
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $4c62
	script_wait_frames 30 ; $4c6a
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4c71
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4c78
	script_wait_idle ACTOR_PARTNER ; $4c7f
	script_get_actor_state ACTOR_PARTNER ; $4c84
	ld c, l ; $4c89
	ld b, h ; $4c8a
	ld de, wActors ; $4c8b
	farcall AttachActorStepMover ; $4c8e
	script_wait_frames 20 ; $4c91
WallPracticeLevelResultScript.wait:
	script_wait_frames 10 ; $4c98
	ret ; $4c9f
WallPracticeRoomFacingScripts_12:
	; $4ca0, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, WallPracticeRoomFacing01_12, $00, $00
	db $ff
WallPracticeRoomFacing01_12:
	farcall BeginCutsceneScriptMode ; $4ca9
	script_fade_in $10 ; $4cac
	script_set_text Text_31_131 ; $4cb1
	script_speak ACTOR_PLAYER ; $4cb7
	farcall EndCutsceneScriptMode ; $4cbc
	ret ; $4cbf
WallPracticeRoomTileTriggers_12:
	; $4cc0, 41 bytes (map_scripts)
	map_script $02, FACEMASK_ANY, $9c00, WallPracticeRoomTile02_12, $00, $00
	map_script $03, FACEMASK_ANY, $0000, WallPracticeRoomTile03_12, TILETRIGGER_PRESS_ONLY, $00
	map_script $04, FACEMASK_ANY, $0000, WallPracticeRoomTile04_12, TILETRIGGER_PRESS_ONLY, $00
	map_script $05, FACEMASK_ANY, $0000, WallPracticeRoomTile05_12, TILETRIGGER_PRESS_ONLY, $00
	map_script $06, FACEMASK_ANY, $0000, WallPracticeRoomTile06_12, TILETRIGGER_PRESS_ONLY, $00
	db $ff
WallPracticeRoomTile02_12:
	script_move_target ACTOR_PLAYER, 5.0, 57.0 ; $4ce9
	script_wait_move ACTOR_PLAYER ; $4cf4
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 5.0, 55.0 ; $4cf9
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4d04
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_DOWN ; $4d09
	clear_flag FLAG_TEMP_SCENE_VARIANT_A ; $4d10
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $4d13
	test_flag FLAG_DOUBLES ; $4d16
	jr z, .done ; $4d19
	script_get_actor_state ACTOR_PARTNER ; $4d1b
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, wActors ; $4d22
	farcall AttachActorStepMover ; $4d25
.done:
	ret ; $4d28
WallPracticeRoomTile03_12:
	script_set_text Text_36_48 ; $4d29
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4d2f
	farcall RunDialogueYesNoPrompt ; $4d34
	farcall ScriptCloseDialogueWindow ; $4d37
	script_wait_frames 5 ; $4d3a
	and a ; $4d41
	jr nz, .done ; $4d42
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $4d44
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4d4b
	script_set_speed ACTOR_PLAYER, $0020 ; $4d52
	script_move_target ACTOR_PLAYER, 3.0, 49.0 ; $4d5a
	script_wait_move ACTOR_PLAYER ; $4d65
	script_move_target ACTOR_PLAYER, 12.0, 49.0 ; $4d6a
	ld c, $04 ; $4d75
	call BeginFadeOut ; $4d77
	call WaitFadeEnd ; $4d7a
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4d7d
	ld [wStoryModeCurrentLocation], a ; $4d7f
	ld a, $0b ; $4d82
	ld [wStoryModeEntryPoint], a ; $4d84
	ld a, $ff ; $4d87
	ld [wUnusedExitTriggerIdMirror], a ; $4d89
	ld [wStoryModeExitTriggerRequest], a ; $4d8c
	ld a, MINIGAME_WALL_PRACTICE_1 ; $4d8f
	farcall RunTrainingDrillByID ; $4d91
	farcall EndCutsceneScriptMode ; $4d94
.done:
	ret ; $4d97
WallPracticeRoomTile04_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_2 ; $4d98
	jp z, WallPracticeLevelLockedScript ; $4d9b
	script_set_text Text_36_49 ; $4d9e
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4da4
	farcall RunDialogueYesNoPrompt ; $4da9
	farcall ScriptCloseDialogueWindow ; $4dac
	script_wait_frames 5 ; $4daf
	and a ; $4db6
	jr nz, .done ; $4db7
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $4db9
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4dc0
	script_set_speed ACTOR_PLAYER, $0020 ; $4dc7
	script_move_target ACTOR_PLAYER, 7.0, 49.0 ; $4dcf
	script_wait_move ACTOR_PLAYER ; $4dda
	script_move_target ACTOR_PLAYER, 12.0, 49.0 ; $4ddf
	ld c, $04 ; $4dea
	call BeginFadeOut ; $4dec
	call WaitFadeEnd ; $4def
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4df2
	ld [wStoryModeCurrentLocation], a ; $4df4
	ld a, $0b ; $4df7
	ld [wStoryModeEntryPoint], a ; $4df9
	ld a, $ff ; $4dfc
	ld [wUnusedExitTriggerIdMirror], a ; $4dfe
	ld [wStoryModeExitTriggerRequest], a ; $4e01
	ld a, MINIGAME_WALL_PRACTICE_2 ; $4e04
	farcall RunTrainingDrillByID ; $4e06
	farcall EndCutsceneScriptMode ; $4e09
.done:
	ret ; $4e0c
WallPracticeRoomTile05_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_3 ; $4e0d
	jp z, WallPracticeLevelLockedScript ; $4e10
	script_set_text Text_36_50 ; $4e13
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4e19
	farcall RunDialogueYesNoPrompt ; $4e1e
	farcall ScriptCloseDialogueWindow ; $4e21
	script_wait_frames 5 ; $4e24
	and a ; $4e2b
	jr nz, .done ; $4e2c
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $4e2e
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4e35
	script_set_speed ACTOR_PLAYER, $0020 ; $4e3c
	script_move_target ACTOR_PLAYER, 17.0, 49.0 ; $4e44
	script_wait_move ACTOR_PLAYER ; $4e4f
	script_move_target ACTOR_PLAYER, 12.0, 49.0 ; $4e54
	ld c, $04 ; $4e5f
	call BeginFadeOut ; $4e61
	call WaitFadeEnd ; $4e64
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4e67
	ld [wStoryModeCurrentLocation], a ; $4e69
	ld a, $0b ; $4e6c
	ld [wStoryModeEntryPoint], a ; $4e6e
	ld a, $ff ; $4e71
	ld [wUnusedExitTriggerIdMirror], a ; $4e73
	ld [wStoryModeExitTriggerRequest], a ; $4e76
	ld a, MINIGAME_WALL_PRACTICE_3 ; $4e79
	farcall RunTrainingDrillByID ; $4e7b
	farcall EndCutsceneScriptMode ; $4e7e
.done:
	ret ; $4e81
WallPracticeRoomTile06_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $4e82
	jp z, WallPracticeLevelLockedScript ; $4e85
	script_set_text Text_36_51 ; $4e88
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4e8e
	farcall RunDialogueYesNoPrompt ; $4e93
	farcall ScriptCloseDialogueWindow ; $4e96
	script_wait_frames 5 ; $4e99
	and a ; $4ea0
	jr nz, .done ; $4ea1
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $4ea3
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $4eaa
	script_set_speed ACTOR_PLAYER, $0020 ; $4eb1
	script_move_target ACTOR_PLAYER, 21.0, 49.0 ; $4eb9
	script_wait_move ACTOR_PLAYER ; $4ec4
	script_move_target ACTOR_PLAYER, 12.0, 49.0 ; $4ec9
	ld c, $04 ; $4ed4
	call BeginFadeOut ; $4ed6
	call WaitFadeEnd ; $4ed9
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4edc
	ld [wStoryModeCurrentLocation], a ; $4ede
	ld a, $0b ; $4ee1
	ld [wStoryModeEntryPoint], a ; $4ee3
	ld a, $ff ; $4ee6
	ld [wUnusedExitTriggerIdMirror], a ; $4ee8
	ld [wStoryModeExitTriggerRequest], a ; $4eeb
	ld a, MINIGAME_WALL_PRACTICE_4 ; $4eee
	farcall RunTrainingDrillByID ; $4ef0
	farcall EndCutsceneScriptMode ; $4ef3
.done:
	ret ; $4ef6
WallPracticeLevelLockedScript:
	script_set_text Text_36_52 ; $4ef7
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4efd
	ret ; $4f02
WallPracticeRoomInitScript_12:
	farcall WaitPlayerMoveDone ; $4f03
	ld a, $00 ; $4f06
	ld [wMapScrollMinX], a ; $4f08
	ld a, $27 ; $4f0b
	ld [wMapScrollMinY], a ; $4f0d
	ld a, $18 ; $4f10
	ld [wMapWidthTiles], a ; $4f12
	ld a, $3c ; $4f15
	ld [wMapHeightTiles], a ; $4f17
	call DisableLCDSafely ; $4f1a
	ld a, $00 ; $4f1d
	farcall CopyScrolledSceneTilemapToVram ; $4f1f
	call EnableLCD ; $4f22
	call SetupWallPracticeLevelSigns ; $4f25
	ld a, [wStoryModeEntryPoint] ; $4f28
	cp $0a ; $4f2b
	jp z, .fromMatch ; $4f2d
	cp $0b ; $4f30
	jp z, .reentry ; $4f32
	call RestoreWallPracticeRoomActors ; $4f35
	ret ; $4f38
.fromMatch:
	test_flag FLAG_DOUBLES ; $4f39
	jr z, .placeNpc ; $4f3c
	script_null_script ACTOR_PARTNER ; $4f3e
	script_set_position ACTOR_PARTNER, 7.0, 57.0 ; $4f43
	script_face ACTOR_PARTNER, FACE_UP ; $4f4e
.placeNpc:
	script_set_position ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 3.0, 55.0 ; $4f55
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_RIGHT ; $4f60
	ld a, [wMatchExitRequest] ; $4f67
	cp $01 ; $4f6a
	jp nz, .showResult ; $4f6c
	script_fade_in $06 ; $4f6f
	call WaitFadeEnd ; $4f74
	xor a ; $4f77
	ld [wStoryModeShowLocationName], a ; $4f78
	jp WallPracticeExitCourtScript ; $4f7b
.showResult:
	ld a, [wMapSceneStage] ; $4f7e
	cp WALLPRACTICESTAGE_EXPERT ; $4f81
	jp nc, WallPracticeMasterResultScript ; $4f83
	jp WallPracticeLevelResultScript ; $4f86
	ret ; $4f89
.reentry:
	test_flag FLAG_DOUBLES ; $4f8a
	jr z, .reentryPlaceNpc ; $4f8d
	script_null_script ACTOR_PARTNER ; $4f8f
	script_set_position ACTOR_PARTNER, 7.0, 57.0 ; $4f94
	script_face ACTOR_PARTNER, FACE_UP ; $4f9f
.reentryPlaceNpc:
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $4fa6
	script_set_position ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 3.0, 55.0 ; $4fa9
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_RIGHT ; $4fb4
	script_fade_in $06 ; $4fbb
	call WaitFadeEnd ; $4fc0
	xor a ; $4fc3
	ld [wStoryModeShowLocationName], a ; $4fc4
	ld a, [wMatchExitRequest] ; $4fc7
	cp $01 ; $4fca
	jp z, .done ; $4fcc
	ld a, [wPointWinLoseFlag] ; $4fcf
	cp WINLOSE_WIN ; $4fd2
	jr nz, .checkSession ; $4fd4
	script_set_text Text_36_53 ; $4fd6
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $4fdc
	farcall RunDialogueYesNoPrompt ; $4fe1
	farcall ScriptCloseDialogueWindow ; $4fe4
	script_wait_frames 5 ; $4fe7
	and a ; $4fee
	jr nz, .done ; $4fef
	jr .placeActors ; $4ff1
.checkSession:
	ld a, [wPointOutcome] ; $4ff3
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4ff6
	jr nz, .sessionActive ; $4ff8
	script_set_text Text_35_246 ; $4ffa
	jr .normalEntry ; $5000
.sessionActive:
	ld a, [wPointOutcome] ; $5002
	and $03 ; $5005
	add a ; $5007
	ld_hl_indexed WallPracticeLevelResultScriptTextIds ; $5008
	ld a, [hl+] ; $500f
	ld h, [hl] ; $5010
	ld l, a ; $5011
	farcall InitDialogueTextCursor ; $5012
.normalEntry:
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $5015
	farcall RunDialogueYesNoPrompt ; $501a
	farcall ScriptCloseDialogueWindow ; $501d
	script_wait_frames 5 ; $5020
	and a ; $5027
	jp nz, .done ; $5028
.placeActors:
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $502b
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $5032
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $5039
	ld c, $04 ; $503e
	call BeginFadeOut ; $5040
	call WaitFadeEnd ; $5043
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $5046
	ld [wStoryModeCurrentLocation], a ; $5048
	ld a, $0b ; $504b
	ld [wStoryModeEntryPoint], a ; $504d
	ld a, $ff ; $5050
	ld [wUnusedExitTriggerIdMirror], a ; $5052
	ld [wStoryModeExitTriggerRequest], a ; $5055
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5058
	farcall RunTrainingDrillByID ; $505b
.done:
	ret ; $505e
SetupWallPracticeLevelSigns:
	ld a, WALLPRACTICESTAGE_LEVEL1 ; $505f
	test_flag FLAG_CLEARED_WALL_LEVEL_1 ; $5061
	jp z, .step ; $5064
	script_copy_scene_rect 30, 44, 2, 44, 2, 2 ; $5067
	ld a, WALLPRACTICESTAGE_LEVEL2 ; $5076
	test_flag FLAG_CLEARED_WALL_LEVEL_2 ; $5078
	jr z, .step ; $507b
	script_copy_scene_rect 30, 48, 6, 44, 2, 2 ; $507d
	ld a, WALLPRACTICESTAGE_LEVEL3 ; $508c
	test_flag FLAG_CLEARED_WALL_LEVEL_3 ; $508e
	jr z, .step ; $5091
	script_copy_scene_rect 30, 52, 16, 44, 2, 2 ; $5093
	ld a, WALLPRACTICESTAGE_LEVEL4 ; $50a2
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $50a4
	jr z, .step ; $50a7
	script_copy_scene_rect 30, 56, 20, 44, 2, 2 ; $50a9
	ld a, WALLPRACTICESTAGE_MASTER ; $50b8
	test_flag FLAG_CLEARED_WALL_MASTER ; $50ba
	jr z, .step ; $50bd
	ld a, WALLPRACTICESTAGE_EXPERT ; $50bf
	test_flag FLAG_CLEARED_WALL_EXPERT ; $50c1
	jr z, .step ; $50c4
	ld a, WALLPRACTICESTAGE_COMPLETE ; $50c6
.step:
	ld [wMapSceneStage], a ; $50c8
	ret ; $50cb
WallPracticeRoomNpc07_12:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $50cc
	jr z, .scoreLine ; $50cf
	script_set_text Text_35_264 ; $50d1
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $50d7
	ret ; $50dc
.scoreLine:
	ld a, [wMapSceneStage] ; $50dd
	add a ; $50e0
	ld_hl_indexed WallPracticeRoomNpc07TextIds ; $50e1
	ld a, [hl+] ; $50e8
	ld h, [hl] ; $50e9
	ld l, a ; $50ea
	farcall InitDialogueTextCursor ; $50eb
	ld a, [wMapSceneStage] ; $50ee
	cp WALLPRACTICESTAGE_EXPERT ; $50f1
	jr nz, .prompt ; $50f3
	push_wram_bank WRAM_SOUND ; $50f5
	ld a, $00 ; $50fe
	farcall ReadMinigameRecord ; $5100
	ld hl, wMinigameRecordValue ; $5103
	ld a, [hl+] ; $5106
	ld h, [hl] ; $5107
	ld l, a ; $5108
	pop_wram_bank ; $5109
	farcall PushTextArgNumber ; $510e
.prompt:
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $5111
	farcall RunDialogueYesNoPrompt ; $5116
	farcall ScriptCloseDialogueWindow ; $5119
	script_wait_frames 5 ; $511c
	and a ; $5123
	jp z, .doublesDeclined ; $5124
	ld a, [wMapSceneStage] ; $5127
	add a ; $512a
	ld_hl_indexed WallPracticeRoomNpc07TextIds2 ; $512b
	ld a, [hl+] ; $5132
	ld h, [hl] ; $5133
	ld l, a ; $5134
	farcall InitDialogueTextCursor ; $5135
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $5138
	farcall RunDialogueYesNoPrompt ; $513d
	farcall ScriptCloseDialogueWindow ; $5140
	script_wait_frames 5 ; $5143
	and a ; $514a
	jp nz, .declined ; $514b
	ld a, [wMapSceneStage] ; $514e
	and a ; $5151
	jp z, .speakDeclined ; $5152
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 3.0, 55.0 ; $5155
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $5160
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_RIGHT ; $5165
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $516c
	test_flag FLAG_DOUBLES ; $5171
	jr z, .walkToCourt ; $5174
	script_null_script ACTOR_PARTNER ; $5176
	script_move_target ACTOR_PARTNER, 7.0, 57.0 ; $517b
	script_wait_move ACTOR_PARTNER ; $5186
	script_face ACTOR_PARTNER, FACE_UP ; $518b
.walkToCourt:
	script_set_speed ACTOR_PLAYER, $0020 ; $5192
	script_move_target ACTOR_PLAYER, 5.0, 53.0 ; $519a
	script_wait_move ACTOR_PLAYER ; $51a5
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $51aa
	set_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $51ad
	ret ; $51b0
.declined:
	farcall AdvanceDialogueTextCursor ; $51b1
.speakDeclined:
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $51b4
	ret ; $51b9
.doublesDeclined:
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_NOD ; $51ba
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $51c1
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $51c6
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 3.0, 55.0 ; $51cb
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $51d6
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_RIGHT ; $51db
	test_flag FLAG_DOUBLES ; $51e2
	jr z, .done ; $51e5
	script_wait_frames 20 ; $51e7
	script_null_script ACTOR_PARTNER ; $51ee
	script_move_target ACTOR_PARTNER, 7.0, 57.0 ; $51f3
	script_wait_move ACTOR_PARTNER ; $51fe
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $5203
	script_wait_frames 30 ; $520b
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5212
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5219
	script_wait_idle ACTOR_PARTNER ; $5220
	script_wait_frames 20 ; $5225
.done:
	script_set_speed ACTOR_PLAYER, $0020 ; $522c
	script_move_target ACTOR_PLAYER, 5.0, 55.0 ; $5234
	script_wait_move ACTOR_PLAYER ; $523f
	script_move_target ACTOR_PLAYER, 5.0, 49.0 ; $5244
	script_wait_move ACTOR_PLAYER ; $524f
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $5254
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $525b
	script_move_target ACTOR_PLAYER, 12.0, 49.0 ; $5262
	jp LaunchWallPracticeMinigame ; $526d
	ret ; $5270
WallPracticeRoomNpc07TextIds:
	; $5271, 14 bytes (text_ids)
	dw Text_35_238 ; record 0
	dw Text_35_261 ; record 1
	dw Text_36_3 ; record 2
	dw Text_36_15 ; record 3
	dw Text_36_25 ; record 4
	dw Text_36_30 ; record 5
	dw Text_36_35 ; record 6
WallPracticeRoomNpc07TextIds2:
	; $527f, 14 bytes (text_ids)
	dw Text_35_240 ; record 0
	dw Text_35_263 ; record 1
	dw Text_36_5 ; record 2
	dw Text_36_17 ; record 3
	dw Text_36_27 ; record 4
	dw Text_36_32 ; record 5
	dw Text_36_37 ; record 6
LaunchWallPracticeMinigame:
	ld c, $04 ; $528d
	call BeginFadeOut ; $528f
	call WaitFadeEnd ; $5292
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [wStoryModeEntryPoint], a ; $529c
	ld a, $ff ; $529f
	ld [wUnusedExitTriggerIdMirror], a ; $52a1
	ld [wStoryModeExitTriggerRequest], a ; $52a4
	ld a, [wMapSceneStage] ; $52a7
	ld_hl_indexed LaunchWallPracticeMinigameTable ; $52aa
	ld a, [hl] ; $52b1
	farcall RunTrainingDrillByID ; $52b2
	farcall EndCutsceneScriptMode ; $52b5
	ret ; $52b8
LaunchWallPracticeMinigameTable:
	; $52b9, 7 bytes (bytes:16)
	db $16, $17, $18, $19, $1b, $1b, $1b ; 0x00
RestoreWallPracticeRoomActors:
	test_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $52c0
	jr z, .done ; $52c3
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $52c5
	script_set_position ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 3.0, 55.0 ; $52c8
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_RIGHT ; $52d3
	test_flag FLAG_DOUBLES ; $52da
	jr z, .done ; $52dd
	script_null_script ACTOR_PARTNER ; $52df
	script_set_position ACTOR_PARTNER, 7.0, 57.0 ; $52e4
	script_face ACTOR_PARTNER, FACE_UP ; $52ef
.done:
	ret ; $52f6
