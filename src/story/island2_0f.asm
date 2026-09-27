; Instruction-for-instruction the same as TournamentNpc0A_0f: the handler assembled a second time. Nothing points at this copy.
UnusedTournamentNpc0A_0f:
	script_set_text Text_1f_163 ; $6f18
	ld a, $0b ; $6f1e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f20
	farcall RunDialogueYesNoPrompt ; $6f23
	farcall ScriptCloseDialogueWindow ; $6f26
	script_wait_frames $05 ; $6f29
	and a ; $6f30
	jr z, .speakAlt ; $6f31
	farcall AdvanceDialogueTextCursor ; $6f33
.speakAlt:
	script_speak $0b ; $6f36
	ret ; $6f3b
TournamentNpc03_0f:
	script_set_text Text_1f_172 ; $6f3c
	ld a, $03 ; $6f42
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f44
	farcall RunDialogueYesNoPrompt ; $6f47
	farcall ScriptCloseDialogueWindow ; $6f4a
	script_wait_frames $05 ; $6f4d
	and a ; $6f54
	jr nz, .altLine ; $6f55
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_1 ; $6f57
	ret ; $6f5c
.altLine:
	ld hl, $24ae ; $6f5d
	ld a, [wMapSceneStage] ; $6f60
	add l ; $6f63
	ld l, a ; $6f64
	jr nc, .setCursor ; $6f65
	inc h ; $6f67
.setCursor:
	farcall InitDialogueTextCursor ; $6f68
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_1 ; $6f6b
	ret ; $6f70
TournamentNpc04_0f:
	ld hl, $24b2 ; $6f71
	ld a, [wMapSceneStage] ; $6f74
	add l ; $6f77
	ld l, a ; $6f78
	jr nc, .setCursor ; $6f79
	inc h ; $6f7b
.setCursor:
	farcall InitDialogueTextCursor ; $6f7c
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_2 ; $6f7f
	ret ; $6f84
MovePartnerForRoundCall_0f:
	test_flag FLAG_DOUBLES ; $6f85
	jr z, .done ; $6f88
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $6f8a
	jr nz, .done ; $6f8d
	script_null_script ACTOR_TOURNAMENT_B_COZ ; $6f8f
	script_move_target ACTOR_TOURNAMENT_B_COZ, $1900, $1100 ; $6f94
	script_wait_move ACTOR_TOURNAMENT_B_COZ ; $6f9f
	script_move_target ACTOR_TOURNAMENT_B_COZ, $1900, $1300 ; $6fa4
	script_wait_move ACTOR_TOURNAMENT_B_COZ ; $6faf
	script_face ACTOR_TOURNAMENT_A_COZ, FACE_DOWN ; $6fb4
	script_face ACTOR_TOURNAMENT_B_COZ, FACE_DOWN ; $6fbb
.done:
	ret ; $6fc2
IslandOpenRoundCallCutscene:
	script_set_text Text_25_94 ; $6fc3
	script_move_player $1100, $0f00 ; $6fc9
	farcall WaitPlayerMoveDone ; $6fd3
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $0e00, $0c00 ; $6fd6
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $6fe1
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $0c00 ; $6fe6
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $6ff1
	script_face ACTOR_TOURNAMENT_WALK_6F_07_3, FACE_DOWN ; $6ff6
	script_set_anim ACTOR_TOURNAMENT_WALK_6F_07_3, $02 ; $6ffd
	script_wait_idle ACTOR_TOURNAMENT_WALK_6F_07_3 ; $7004
	call QueueUpcomingRoundNameText ; $7009
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_3 ; $700c
	call MovePartnerForRoundCall_0f ; $7011
	script_face ACTOR_TOURNAMENT_WALK_6F_07_2, FACE_UP ; $7014
	script_set_anim ACTOR_TOURNAMENT_WALK_6F_07_2, $03 ; $701b
	script_wait_idle ACTOR_TOURNAMENT_WALK_6F_07_2 ; $7022
	script_face ACTOR_TOURNAMENT_WALK_6F_07_2, FACE_DOWN ; $7027
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_2, $1300, $1700 ; $702e
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $1700 ; $7039
	script_move_player $1100, $1300 ; $7044
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_2 ; $704e
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_2, $1500, $1700 ; $7053
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_2 ; $705e
	script_face ACTOR_TOURNAMENT_WALK_6F_07_2, FACE_UP ; $7063
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $706a
	script_face ACTOR_TOURNAMENT_WALK_6F_07_3, FACE_UP ; $706f
	call QueueUpcomingRoundNameText ; $7076
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_2 ; $7079
	script_face_pair ACTOR_TOURNAMENT_WALK_6F_07_3, ACTOR_TOURNAMENT_WALK_6F_07_2 ; $707e
	script_set_anim ACTOR_TOURNAMENT_WALK_6F_07_2, $03 ; $7086
	script_wait_idle ACTOR_TOURNAMENT_WALK_6F_07_2 ; $708d
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1000, $1700 ; $7092
	ld a, [wMapSceneStage] ; $709d
	cp ISLANDOPENROUND_FINAL ; $70a0
	jr z, .partnerReady ; $70a2
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_2, $1800, $1700 ; $70a4
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_2 ; $70af
	script_face ACTOR_TOURNAMENT_WALK_6F_07_2, FACE_UP ; $70b4
.partnerReady:
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $70bb
	script_face ACTOR_TOURNAMENT_WALK_6F_07_3, FACE_UP ; $70c0
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_2 ; $70c7
	test_flag FLAG_DOUBLES ; $70cc
	jp nz, .afterMatch ; $70cf
	script_set_speed ACTOR_PLAYER, $0020 ; $70d2
	script_face_pair ACTOR_TOURNAMENT_SAMMI, ACTOR_PLAYER ; $70da
	script_wait_frames $1e ; $70e2
	script_face ACTOR_PLAYER, FACE_DOWN ; $70e9
	script_face ACTOR_TOURNAMENT_SAMMI, FACE_DOWN ; $70f0
	script_set_anim ACTOR_TOURNAMENT_SAMMI, $03 ; $70f7
	script_set_anim ACTOR_PLAYER, $03 ; $70fe
	script_wait_idle ACTOR_PLAYER ; $7105
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $710a
	jr z, .doublesWalk ; $710d
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $1700 ; $710f
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $711a
	script_set_actor_script ACTOR_TOURNAMENT_WALK_6F_07_3, ActorScript_0f_05 ; $711f
	script_wait_frames $14 ; $712a
	script_set_actor_script ACTOR_TOURNAMENT_SAMMI, ActorScript_0f_05 ; $7131
	script_wait_frames $14 ; $713c
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_05 ; $7143
	script_wait_frames $14 ; $714e
	script_move_player $1100, $0d00 ; $7155
	farcall WaitPlayerMoveDone ; $715f
	script_wait_frames $1e ; $7162
	jp .startMatch ; $7169
.doublesWalk:
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $1700 ; $716c
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $7177
	script_set_actor_script ACTOR_TOURNAMENT_WALK_6F_07_3, ActorScript_0f_03 ; $717c
	script_wait_frames $14 ; $7187
	script_set_actor_script ACTOR_TOURNAMENT_SAMMI, ActorScript_0f_03 ; $718e
	script_wait_frames $14 ; $7199
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_03 ; $71a0
	script_move_player $1100, $0d00 ; $71ab
	farcall WaitPlayerMoveDone ; $71b5
	script_wait_frames $3c ; $71b8
.startMatch:
	ld c, $10 ; $71bf
	call BeginFadeOut ; $71c1
	call WaitFadeEnd ; $71c4
	call ShowTournamentRankingBoard_0f ; $71c7
	ld a, STORYLOC_TOURNAMENT ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [wStoryModeEntryPoint], a ; $71d1
	ld a, $ff ; $71d4
	ld [wUnusedExitTriggerIdMirror], a ; $71d6
	ld [wStoryModeExitTriggerRequest], a ; $71d9
	farcall InitStoryMatchSettings ; $71dc
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $71df
	jr z, .checkRound2 ; $71e2
	load_match_settings $0013 ; $71e4
	jr .runMatch ; $71f1
.checkRound2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $71f3
	jr z, .checkRound1 ; $71f6
	load_match_settings $0012 ; $71f8
	jr .runMatch ; $7205
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $7207
	jr z, .round1Settings ; $720a
	load_match_settings $0011 ; $720c
	jr .runMatch ; $7219
.round1Settings:
	load_match_settings $0010 ; $721b
.runMatch:
	farcall RunStoryMatch ; $7228
	farcall RestoreOverworldAfterMatch ; $722b
	ret ; $722e
.afterMatch:
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $722f
	script_set_speed ACTOR_PLAYER, $0020 ; $7237
	script_set_speed ACTOR_PARTNER, $0020 ; $723f
	script_wait_frames $14 ; $7247
	script_set_anim ACTOR_PARTNER, $03 ; $724e
	script_set_anim ACTOR_PLAYER, $03 ; $7255
	script_wait_idle ACTOR_PLAYER ; $725c
	script_face ACTOR_PLAYER, FACE_DOWN ; $7261
	script_face ACTOR_PARTNER, FACE_DOWN ; $7268
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $726f
	jp z, .afterMatchDoubles ; $7272
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $1700 ; $7275
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $7280
	script_set_actor_script ACTOR_TOURNAMENT_WALK_6F_07_3, ActorScript_0f_05 ; $7285
	script_wait_frames $14 ; $7290
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_05 ; $7297
	script_wait_frames $14 ; $72a2
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_05 ; $72a9
	script_wait_frames $3c ; $72b4
	script_set_actor_script ACTOR_TOURNAMENT_ELDEN, ActorScript_0f_06 ; $72bb
	script_wait_frames $14 ; $72c6
	script_set_actor_script ACTOR_TOURNAMENT_SAMMI, ActorScript_0f_06 ; $72cd
	script_move_player $1100, $0d00 ; $72d8
	farcall WaitPlayerMoveDone ; $72e2
	jp .walkOff ; $72e5
.afterMatchDoubles:
	script_move_target ACTOR_TOURNAMENT_WALK_6F_07_3, $1300, $1700 ; $72e8
	script_wait_move ACTOR_TOURNAMENT_WALK_6F_07_3 ; $72f3
	script_set_actor_script ACTOR_TOURNAMENT_WALK_6F_07_3, ActorScript_0f_03 ; $72f8
	script_wait_frames $14 ; $7303
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_03 ; $730a
	script_wait_frames $14 ; $7315
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_03 ; $731c
	script_wait_frames $3c ; $7327
	script_set_actor_script ACTOR_TOURNAMENT_ELDEN, ActorScript_0f_04 ; $732e
	script_wait_frames $14 ; $7339
	script_set_actor_script ACTOR_TOURNAMENT_SAMMI, ActorScript_0f_04 ; $7340
	script_move_player $1100, $0d00 ; $734b
	farcall WaitPlayerMoveDone ; $7355
	script_wait_frames $3c ; $7358
.walkOff:
	ld c, $10 ; $735f
	call BeginFadeOut ; $7361
	call WaitFadeEnd ; $7364
	call ShowTournamentRankingBoard_0f ; $7367
	ld a, STORYLOC_TOURNAMENT ; $736a
	ld [wStoryModeCurrentLocation], a ; $736c
	ld a, $0b ; $736f
	ld [wStoryModeEntryPoint], a ; $7371
	ld a, $ff ; $7374
	ld [wUnusedExitTriggerIdMirror], a ; $7376
	ld [wStoryModeExitTriggerRequest], a ; $7379
	farcall InitStoryMatchSettings ; $737c
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $737f
	jp z, .walkOffDoubles ; $7382
	load_match_settings $0113 ; $7385
	jr .done ; $7392
.walkOffDoubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $7394
	jp z, .fadeOut ; $7397
	load_match_settings $0112 ; $739a
	jp .done ; $73a7
.fadeOut:
	load_match_settings $0111 ; $73aa
.done:
	farcall RunStoryMatch ; $73b7
	farcall RestoreOverworldAfterMatch ; $73ba
	ret ; $73bd
ActorScript_0f_03:
	; $73be, 19 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0100, $0b00
	as_wait_move
	as_halt
ActorScript_0f_04:
	; $73d1, 19 bytes (actor_script)
	as_set_target $1300, $1300
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0100, $0b00
	as_wait_move
	as_halt
ActorScript_0f_05:
	; $73e4, 25 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
ActorScript_0f_06:
	; $73fd, 25 bytes (actor_script)
	as_set_target $1300, $1300
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
GetIslandOpenRoundParams:
	test_flag FLAG_DOUBLES ; $7416
	jr nz, .doubles ; $7419
	ld b, $00 ; $741b
	ld a, [wMapSceneStage] ; $741d
	inc a ; $7420
	ld c, a ; $7421
	ld d, $00 ; $7422
	ret ; $7424
.doubles:
	ld b, $01 ; $7425
	ld a, [wMapSceneStage] ; $7427
	inc a ; $742a
	cp $03 ; $742b
	jr c, .store ; $742d
	dec a ; $742f
.store:
	ld c, a ; $7430
	ld d, $00 ; $7431
	ret ; $7433
ShowTournamentRankingBoard_0f:
	xor a ; $7434
	ldh [hBGColumnBlitPending], a ; $7435
	ldh [hBGRowBlitPending], a ; $7437
	ldh [hScrollY], a ; $7439
	ldh [hScrollX], a ; $743b
	ld [wCameraX + 1], a ; $743d
	ld [wCameraY + 1], a ; $7440
	call ClearFrameTasks ; $7443
	call GetIslandOpenRoundParams ; $7446
	farcall ShowRankingBoard ; $7449
	ret ; $744c
QueueUpcomingRoundNameText:
	ld a, [wMapSceneStage] ; $744d
	ld hl, Text_25_97 ; $7450
	add l ; $7453
	ld l, a ; $7454
	jr nc, .queue ; $7455
	inc h ; $7457
.queue:
	call QueueShortText ; $7458
	ret ; $745b
CheckIslandOpenVictoryTransition:
	test_flag FLAG_DOUBLES ; $745c
	jr nz, .doubles ; $745f
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $7461
	jr nz, .transition ; $7464
	jr .stay ; $7466
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7468
	jr nz, .transition ; $746b
	jr .stay ; $746d
.transition:
	ld a, STORYLOC_ISLAND_SKY ; $746f
	ld [wStoryModeCurrentLocation], a ; $7471
	ld a, $08 ; $7474
	ld [wStoryModeEntryPoint], a ; $7476
	ld a, $ff ; $7479
	ld [wUnusedExitTriggerIdMirror], a ; $747b
	ld [wStoryModeExitTriggerRequest], a ; $747e
	ld a, $01 ; $7481
	ret ; $7483
.stay:
	ld a, $00 ; $7484
	ret ; $7486
IslandOpenSinglesMatchReturn:
	wram_bank WRAM_ACTORS ; $7487
	ld a, [wMatchExitRequest] ; $748d
	cp $01 ; $7490
	jr z, .quitOrLost ; $7492
	ld a, [wMatchWinLoseFlag] ; $7494
	cp WINLOSE_WIN ; $7497
	jp z, .wonRound ; $7499
.quitOrLost:
	call LoadIslandOpenRoundNpcs ; $749c
	call SetPlayerAndPartnerObjectDefs ; $749f
	ret ; $74a2
.wonRound:
	clear_flag FLAG_TOURNAMENT_NPC05_TALKED_SINGLES ; $74a3
	clear_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $74a6
	call CheckIslandOpenVictoryTransition ; $74a9
	and a ; $74ac
	jr z, .returnToSite ; $74ad
	ret ; $74af
.returnToSite:
	ldh a, [hRomBank] ; $74b0
	ld hl, IslandOpenRoundActorsSingles_0f ; $74b2
	farcall ScriptRespawnLocationActors ; $74b5
	ld hl, IslandOpenRoundNpcScriptsSingles_0f ; $74b8
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $74bb
	farcall WriteStoryStateWord ; $74be
	call ComputeIslandOpenRound ; $74c1
	farcall BeginCutsceneScriptMode ; $74c4
	call SetPlayerAndPartnerObjectDefs ; $74c7
	script_get_actor_state ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_73_12 ; $74ca
	ld c, l ; $74cf
	ld b, h ; $74d0
	ld hl, ACTORF_OAM_ATTR ; $74d1
	add hl, bc ; $74d4
	ld a, [hl] ; $74d5
	xor $20 ; $74d6
	ld [hl], a ; $74d8
	script_fade_in $04 ; $74d9
	call WaitFadeEnd ; $74de
	ld a, [wMapSceneStage] ; $74e1
	add a ; $74e4
	ld_hl_indexed IslandOpenSinglesStageTextPtrs_0f ; $74e5
	ld a, [hl+] ; $74ec
	ld h, [hl] ; $74ed
	ld l, a ; $74ee
	farcall InitDialogueTextCursor ; $74ef
	script_set_position ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_73_12, $2200, $0f80 ; $74f2
	sound SFX_CHIME ; $74fd
	script_wait_frames $2d ; $74ff
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_08, $02 ; $7506
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_08 ; $750d
	script_face_toward ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_08, ACTOR_PLAYER ; $7512
	script_set_position ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_73_12, $3f00, $3f00 ; $751a
	script_speak ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_08 ; $7525
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_07, $02 ; $752a
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_07 ; $7531
	script_face_toward ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_07, ACTOR_PLAYER ; $7536
	script_speak ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_07 ; $753e
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06, $03 ; $7543
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06 ; $754a
	script_face_toward ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06, ACTOR_PLAYER ; $754f
	script_speak ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06 ; $7557
	call IslandOpenBreakCutscene ; $755c
	script_set_text Text_25_73 ; $755f
	ld a, [wMapSceneStage] ; $7565
	dec a ; $7568
	ld hl, Text_25_98 ; $7569
	add l ; $756c
	ld l, a ; $756d
	jr nc, .done ; $756e
	inc h ; $7570
.done:
	call QueueShortText ; $7571
	script_face $04, FACE_UP ; $7574
	script_face $03, FACE_RIGHT ; $757b
	script_face_toward $04, ACTOR_PLAYER ; $7582
	script_speak $04 ; $758a
	script_move_angle $04, FACE_RIGHT, $0200 ; $758f
	script_wait_move $04 ; $7599
	script_wait_frames $0a ; $759e
	script_wait_frames $0a ; $75a5
	script_face $04, FACE_LEFT ; $75ac
	set_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $75b3
	ret ; $75b6
IslandOpenRoundActorsSingles_0f:
	; $75b7, 94 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2300, $1100, FACE_RIGHT, OBJ_WALK_74_08, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $2500, $1300, FACE_UP, OBJ_WALK_74_06, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_74_07, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_6F_07, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_6F_07, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_73_12, $01, $00, ISLAND_OPEN_ROUND_SINGLES_WALK_73_12
	map_actor_end
IslandOpenRoundNpcScriptsSingles_0f:
	; $7615, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $05, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc05_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
; Instruction-identical to IslandOpenRoundDoublesNpc04_0f (in this bank); a change here belongs in every copy.
	twin_named island_open_round_doubles_npc04, IslandOpenRoundSinglesNpc04_0f ; $762e
IslandOpenRoundSinglesNpc03_0f:
	ld a, [wMapSceneStage] ; $7649
	add a ; $764c
	ld_hl_indexed IslandOpenSinglesStageTextPtrs_0f ; $764d
	ld a, [hl+] ; $7654
	ld h, [hl] ; $7655
	ld l, a ; $7656
	farcall InitDialogueTextCursor ; $7657
	script_set_anim ACTOR_TOURNAMENT_WALK_6F_07_1, $03 ; $765a
	script_wait_idle ACTOR_TOURNAMENT_WALK_6F_07_1 ; $7661
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_1 ; $7666
	ret ; $766b
IslandOpenRoundSinglesNpc05_0f:
	ld a, [wMapSceneStage] ; $766c
	dec a ; $766f
	add a ; $7670
	ld_hl_indexed IslandOpenRoundSinglesNpc05_0fTable ; $7671
	ld a, [hl+] ; $7678
	ld h, [hl] ; $7679
	ld l, a ; $767a
	farcall InitDialogueTextCursor ; $767b
	script_jump_velocity ACTOR_TOURNAMENT_WALK_6F_07_3, $ff80 ; $767e
	ld a, $05 ; $7686
	farcall ScriptWaitActorJumpDone ; $7688
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_3 ; $768b
	ret ; $7690
IslandOpenRoundSinglesNpc05_0fTable:
	; $7691, 8 bytes (text_ids)
	dw Text_25_71 ; record 0
	dw Text_25_75 ; record 1
	dw Text_25_79 ; record 2
	dw Text_25_79 ; record 3
IslandOpenSinglesStageTextPtrs_0f:
	; $7699, 10 bytes (text_ids)
	dw Text_25_70 ; record 0
	dw Text_25_70 ; record 1
	dw Text_25_74 ; record 2
	dw Text_25_78 ; record 3
	dw Text_25_82 ; record 4
IslandOpenDoublesMatchReturn:
	wram_bank WRAM_ACTORS ; $76a3
	ld a, [wMatchExitRequest] ; $76a9
	cp $01 ; $76ac
	jr z, .quitOrLost ; $76ae
	ld a, [wMatchWinLoseFlag] ; $76b0
	cp WINLOSE_WIN ; $76b3
	jp z, .wonRound ; $76b5
.quitOrLost:
	call LoadIslandOpenRoundNpcs ; $76b8
	call SetPlayerAndPartnerObjectDefs ; $76bb
	script_set_position ACTOR_PLAYER, $2500, $1100 ; $76be
	script_move_player $2500, $1100 ; $76c9
	script_set_position ACTOR_PARTNER, $2500, $1300 ; $76d3
	script_face ACTOR_PARTNER, FACE_UP ; $76de
	farcall WaitPlayerMoveDone ; $76e5
	ret ; $76e8
.wonRound:
	clear_flag FLAG_TOURNAMENT_NPC05_TALKED_DOUBLES ; $76e9
	clear_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $76ec
	call CheckIslandOpenVictoryTransition ; $76ef
	and a ; $76f2
	jr z, .accepted ; $76f3
	ret ; $76f5
.accepted:
	ldh a, [hRomBank] ; $76f6
	ld hl, IslandOpenRoundActorsDoubles_0f ; $76f8
	farcall ScriptRespawnLocationActors ; $76fb
	farcall BeginCutsceneScriptMode ; $76fe
	ld hl, IslandOpenRoundNpcScriptsDoubles_0f ; $7701
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $7704
	farcall WriteStoryStateWord ; $7707
	call SetPlayerAndPartnerObjectDefs ; $770a
	script_null_script ACTOR_PARTNER ; $770d
	script_set_position ACTOR_PARTNER, $2500, $1100 ; $7712
	script_face ACTOR_PARTNER, FACE_UP ; $771d
	script_fade_in $04 ; $7724
	call WaitFadeEnd ; $7729
	call ComputeIslandOpenRound ; $772c
	farcall BeginCutsceneScriptMode ; $772f
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7732
	script_fade_in $04 ; $773a
	call WaitFadeEnd ; $773f
	ld a, [wMapSceneStage] ; $7742
	dec a ; $7745
	add a ; $7746
	ld_hl_indexed IslandOpenRoundSinglesNpc05TextIds ; $7747
	ld a, [hl+] ; $774e
	ld h, [hl] ; $774f
	ld l, a ; $7750
	farcall InitDialogueTextCursor ; $7751
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7754
	or a ; $7757
	jr nz, .declined ; $7758
	farcall AdvanceDialogueTextCursor ; $775a
	farcall AdvanceDialogueTextCursor ; $775d
	farcall AdvanceDialogueTextCursor ; $7760
.declined:
	script_get_actor_state $08 ; $7763
	ld c, l ; $7768
	ld b, h ; $7769
	ld hl, ACTORF_OAM_ATTR ; $776a
	add hl, bc ; $776d
	ld a, [hl] ; $776e
	xor $20 ; $776f
	ld [hl], a ; $7771
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7772
	script_jump_velocity ACTOR_PARTNER, $ff80 ; $777a
	ld a, $02 ; $7782
	farcall ScriptWaitActorJumpDone ; $7784
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7787
	script_speak ACTOR_PARTNER ; $778f
	script_set_position $08, $2000, $0f80 ; $7794
	sound SFX_CHIME ; $779f
	script_wait_frames $2d ; $77a1
	script_set_anim $03, $02 ; $77a8
	script_wait_idle $03 ; $77af
	script_set_position $08, $3f00, $3f00 ; $77b4
	script_face_toward $03, ACTOR_PLAYER ; $77bf
	script_speak $03 ; $77c7
	script_set_anim $04, $03 ; $77cc
	script_wait_idle $04 ; $77d3
	script_face_toward $04, ACTOR_PLAYER ; $77d8
	script_face_toward $04, ACTOR_PARTNER ; $77e0
	script_speak $04 ; $77e8
	call IslandOpenBreakCutscene ; $77ed
	script_face_toward ACTOR_PLAYER, $04 ; $77f0
	script_face $03, FACE_RIGHT ; $77f8
	script_set_text Text_25_73 ; $77ff
	ld a, [wMapSceneStage] ; $7805
	dec a ; $7808
	ld hl, Text_25_98 ; $7809
	add l ; $780c
	ld l, a ; $780d
	jr nc, .done ; $780e
	inc h ; $7810
.done:
	call QueueShortText ; $7811
	script_face_toward $04, ACTOR_PLAYER ; $7814
	script_face_toward $04, ACTOR_PARTNER ; $781c
	script_speak $03 ; $7824
	set_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $7829
	script_get_actor_state ACTOR_PARTNER ; $782c
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, wActors ; $7833
	farcall AttachActorStepMover ; $7836
	ret ; $7839
IslandOpenRoundSinglesNpc05TextIds:
	; $783a, 8 bytes (text_ids)
	dw Text_25_82 ; record 0
	dw Text_25_82 ; record 1
	dw Text_25_88 ; record 2
	dw Text_25_78 ; record 3
IslandOpenRoundActorsDoubles_0f:
	; $7842, 94 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2100, $1100, FACE_RIGHT, OBJ_WALK_74_08, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_74_06, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $3d00, $3d00, FACE_UP, OBJ_WALK_74_07, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_6F_07, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_6F_07, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $3100, FACE_UP, OBJ_WALK_73_12, $01, $00, ISLAND_OPEN_ROUND_DOUBLES_WALK_73_12
	map_actor_end
IslandOpenRoundNpcScriptsDoubles_0f:
	; $78a0, 17 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, IslandOpenRoundDoublesNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, IslandOpenRoundDoublesNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
; Instruction-identical to IslandOpenRoundSinglesNpc04_0f (in this bank); a change here belongs in every copy.
	twin_named island_open_round_doubles_npc04, IslandOpenRoundDoublesNpc04_0f ; $78b1
IslandOpenRoundDoublesNpc03_0f:
	ld a, [wMapSceneStage] ; $78cc
	dec a ; $78cf
	add a ; $78d0
	ld_hl_indexed IslandOpenRoundDoublesNpc03TextIds ; $78d1
	ld a, [hl+] ; $78d8
	ld h, [hl] ; $78d9
	ld l, a ; $78da
	farcall InitDialogueTextCursor ; $78db
	script_speak ACTOR_TOURNAMENT_WALK_6F_07_1 ; $78de
	ret ; $78e3
IslandOpenRoundDoublesNpc03TextIds:
	; $78e4, 8 bytes (text_ids)
	dw Text_25_83 ; record 0
	dw Text_25_83 ; record 1
	dw Text_25_89 ; record 2
	dw Text_25_79 ; record 3
