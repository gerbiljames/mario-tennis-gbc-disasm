RunWaterSpriteSwingContestAndReward:
	script_get_actor_state ACTOR_PLAYER ; $4d07
	ld a, $01 ; $4d0c
	ld e, l ; $4d0e
	ld d, h ; $4d0f
	ld hl, $0018 ; $4d10
	add hl, de ; $4d13
	ld [hl], a ; $4d14
	script_move_player_to_actor ACTOR_PLAYER ; $4d15
	farcall WaitPlayerMoveDone ; $4d1c
	script_move_player 51.0, 12.0 ; $4d1f
	farcall WaitPlayerMoveDone ; $4d29
	script_set_text Text_36_675 ; $4d2c
	script_speak ACTOR_PLAYER ; $4d32
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 63.0, 63.0 ; $4d37
	call WaterSpriteSwingContestScene ; $4d42
	test_flag FLAG_HAVE_SILVER_RACKET ; $4d45
	jp nz, .done ; $4d48
	test_flag FLAG_HAVE_GOLD_RACKET ; $4d4b
	jp nz, .done ; $4d4e
	ld a, [wSwingContestSwings] ; $4d51
	cp $64 ; $4d54
	jp c, .done ; $4d56
	call WaterSpriteRacketRewardScene ; $4d59
.done:
	ret ; $4d5c
WaterSpriteRacketRewardScene:
	script_wait_frames 60 ; $4d5d
	script_set_text Text_36_677 ; $4d64
	script_speak ACTOR_TRAINING_COURT_WALK_76_06 ; $4d6a
	script_wait_frames 30 ; $4d6f
	script_face ACTOR_PLAYER, FACE_LEFT ; $4d76
	script_wait_frames 30 ; $4d7d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4d84
	script_wait_frames 30 ; $4d8b
	script_face ACTOR_PLAYER, FACE_LEFT ; $4d92
	script_wait_frames 30 ; $4d99
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4da0
	script_wait_frames 30 ; $4da7
	script_face ACTOR_PLAYER, FACE_DOWN ; $4dae
	script_wait_frames 30 ; $4db5
	script_set_objdef OBJ_BALLOON_QUESTION, ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE ; $4dbc
	script_set_objdef OBJ_BALLOON_EXCLAIM, ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4dc8
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 52.5, 11.5 ; $4dd4
	sound SFX_EMOTE ; $4ddf
	script_wait_frames 60 ; $4de1
	script_set_position ACTOR_TRAINING_COURT_WALK_76_06, 51.0, 7.0 ; $4de8
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $00 ; $4df3
	script_player_speed $0010 ; $4dfa
	script_move_player_to_actor ACTOR_TRAINING_COURT_WALK_76_06 ; $4e00
	ld hl, WaterSpriteRacketRewardScenePalettes1 ; $4e07
	ld_bg_pals de, 2, 6 ; $4e0a
	call LoadPalettesImmediate ; $4e0d
	script_wait_frames 30 ; $4e10
	ld hl, WaterSpriteRacketRewardScenePalettes2 ; $4e17
	ld_bg_pals de, 2, 6 ; $4e1a
	call LoadPalettesImmediate ; $4e1d
	sound SFX_WATER_SPRITE_MAGIC ; $4e20
	ld a, $10 ; $4e22
.handOver:
	ld d, a ; $4e24
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $02 ; $4e25
	script_wait_frames 4 ; $4e2c
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $00 ; $4e33
	push af ; $4e3a
	ld a, d ; $4e3b
	farcall WaitScriptFrames ; $4e3c
	pop af ; $4e3f
	ld a, d ; $4e40
	sub $02 ; $4e41
	jp nz, .handOver ; $4e43
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $02 ; $4e46
	script_wait_frames 60 ; $4e4d
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 63.0, 63.0 ; $4e54
	script_face ACTOR_PLAYER, FACE_UP ; $4e5f
	script_wait_frames 30 ; $4e66
	script_set_position ACTOR_TRAINING_COURT_WALK_71_06_3, 52.5, 11.5 ; $4e6d
	sound SFX_CHIME ; $4e78
	script_wait_frames 20 ; $4e7a
	script_jump_velocity ACTOR_TRAINING_COURT_WALK_71_06_3, $ff40 ; $4e81
	script_jump_velocity ACTOR_PLAYER, $ff40 ; $4e89
	ld a, $00 ; $4e91
	farcall ScriptWaitActorJumpDone ; $4e93
	script_set_position ACTOR_TRAINING_COURT_WALK_71_06_3, 63.0, 63.0 ; $4e96
	script_set_anim ACTOR_TRAINING_COURT_WALK_76_06, ANIM_NOD ; $4ea1
	script_wait_idle ACTOR_TRAINING_COURT_WALK_76_06 ; $4ea8
	script_speak ACTOR_TRAINING_COURT_WALK_76_06 ; $4ead
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4eb2
	script_wait_idle ACTOR_PLAYER ; $4eb9
	script_set_anim ACTOR_TRAINING_COURT_WALK_76_06, ANIM_NOD ; $4ebe
	script_wait_idle ACTOR_TRAINING_COURT_WALK_76_06 ; $4ec5
	ld a, [wSwingContestSwings] ; $4eca
	cp $96 ; $4ecd
	jp nc, .alreadyOwned ; $4ecf
	farcall AdvanceDialogueTextCursor ; $4ed2
	script_get_actor_state ACTOR_TRAINING_COURT_RACKET ; $4ed5
	ld c, l ; $4eda
	ld b, h ; $4edb
	ld hl, ACTORF_OAM_ATTR ; $4edc
	add hl, bc ; $4edf
	ld a, [hl] ; $4ee0
	and $f8 ; $4ee1
	or $07 ; $4ee3
	ld [hl], a ; $4ee5
	set_flag FLAG_HAVE_SILVER_RACKET ; $4ee6
	ld a, $05 ; $4ee9
	ld b, a ; $4eeb
	jp .speak ; $4eec
.alreadyOwned:
	set_flag FLAG_HAVE_GOLD_RACKET ; $4eef
	ld a, $04 ; $4ef2
	ld b, a ; $4ef4
.speak:
	ld a, [wEquippedRacket] ; $4ef5
	and $f0 ; $4ef8
	or b ; $4efa
	ld [wEquippedRacket], a ; $4efb
	script_speak ACTOR_TRAINING_COURT_WALK_76_06 ; $4efe
	script_wait_frames 10 ; $4f03
	ld c, $03 ; $4f0a
	call BeginFadeOut ; $4f0c
	call WaitFadeEnd ; $4f0f
	sound SFX_WATER_SPRITE_APPEAR ; $4f12
	script_set_position ACTOR_TRAINING_COURT_RACKET, 51.0, 9.0 ; $4f14
	script_wait_frames 30 ; $4f1f
	script_fade_in $03 ; $4f26
	call WaitFadeEnd ; $4f2b
	script_wait_frames 60 ; $4f2e
	sound SFX_WATER_SPRITE_FLY ; $4f35
	script_set_speed ACTOR_TRAINING_COURT_RACKET, $0005 ; $4f37
	script_move_target ACTOR_TRAINING_COURT_RACKET, 51.0, 13.0 ; $4f3f
	script_wait_move ACTOR_TRAINING_COURT_RACKET ; $4f4a
	script_wait_frames 60 ; $4f4f
	farcall AdvanceDialogueTextCursor ; $4f56
	script_speak ACTOR_PLAYER ; $4f59
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SWEAT, 52.5, 11.5 ; $4f5e
	sound SFX_APPEAR2 ; $4f69
	script_wait_frames 120 ; $4f6b
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SWEAT, 63.0, 63.0 ; $4f72
	script_set_anim ACTOR_TRAINING_COURT_WALK_76_06, ANIM_NOD ; $4f7d
	script_wait_idle ACTOR_TRAINING_COURT_WALK_76_06 ; $4f84
	script_set_text Text_36_683 ; $4f89
	script_speak ACTOR_TRAINING_COURT_WALK_76_06 ; $4f8f
	script_wait_frames 50 ; $4f94
	sound SFX_RACKET_GET ; $4f9b
	ld d, $10 ; $4f9d
.done:
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $00 ; $4f9f
	script_wait_frames 4 ; $4fa6
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $02 ; $4fad
	push af ; $4fb4
	ld a, d ; $4fb5
	farcall WaitScriptFrames ; $4fb6
	pop af ; $4fb9
	ld a, d ; $4fba
	sub $02 ; $4fbb
	ld d, a ; $4fbd
	jp nz, .done ; $4fbe
	script_set_active ACTOR_TRAINING_COURT_WALK_76_06, $00 ; $4fc1
	script_wait_frames 30 ; $4fc8
	script_set_position ACTOR_TRAINING_COURT_WALK_76_06, 51.0, 11.0 ; $4fcf
	script_speak ACTOR_TRAINING_COURT_WALK_76_06 ; $4fda
	script_set_position ACTOR_TRAINING_COURT_RACKET, 63.0, 63.0 ; $4fdf
	ld hl, WaterSpriteRacketRewardScenePalettes1 ; $4fea
	ld_bg_pals de, 2, 6 ; $4fed
	call LoadPalettesImmediate ; $4ff0
	script_wait_frames 30 ; $4ff3
	ld hl, WaterSpriteRacketRewardScenePalettes0 ; $4ffa
	ld_bg_pals de, 2, 6 ; $4ffd
	call LoadPalettesImmediate ; $5000
	script_wait_frames 30 ; $5003
	script_face ACTOR_PLAYER, FACE_LEFT ; $500a
	script_wait_frames 20 ; $5011
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5018
	script_wait_frames 20 ; $501f
	script_face ACTOR_PLAYER, FACE_LEFT ; $5026
	script_wait_frames 20 ; $502d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5034
	script_wait_frames 20 ; $503b
	script_face ACTOR_PLAYER, FACE_UP ; $5042
	script_move_player_to_actor ACTOR_PLAYER ; $5049
	farcall WaitPlayerMoveDone ; $5050
	script_wait_frames 30 ; $5053
	ret ; $505a
TrainingCourtNpcScripts_15:
	; $505b, 161 bytes (map_scripts)
	map_script ACTOR_TRAINING_COURT_WALK_71_06_1, FACEMASK_ANY, $0000, TrainingCourtNpc03_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_05_1, FACEMASK_ANY, $0000, TrainingCourtNpc04_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_07_1, FACEMASK_ANY, $0000, TrainingCourtNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_BOB_1, FACEMASK_ANY, $0000, TrainingCourtNpc06_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_CURT, FACEMASK_DOWN, $0000, TrainingCourtNpc07FaceDown_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_CURT, FACEMASK_ANY, $0000, TrainingCourtNpc07_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_07_2, FACEMASK_ANY, $0000, TrainingCourtNpc08_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_72_02_1, FACEMASK_ANY, $0000, TrainingCourtNpc09_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_06_2, FACEMASK_ANY, $0000, TrainingCourtNpc0A_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_PAM, FACEMASK_ANY, $0000, TrainingCourtNpc0B_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_ALLIE, FACEMASK_ANY, $0000, TrainingCourtNpc0C_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_BOB_2, FACEMASK_UP, $0000, TrainingCourtNpc0DFaceUp_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_BOB_2, FACEMASK_ANY, $0000, TrainingCourtNpc0D_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_WALK_72_02_2, FACEMASK_ANY, $0000, TrainingCourtNpc0E_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_05_2, FACEMASK_ANY, $0000, TrainingCourtNpc0F_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_07_3, FACEMASK_ANY, $0000, TrainingCourtNpc10_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_TRAINING_COURT_BRIAN, FACEMASK_ANY, $0000, TrainingCourtNpc11_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_BETH, FACEMASK_UP, $0000, TrainingCourtNpc12FaceUp_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_BETH, FACEMASK_ANY, $0000, TrainingCourtNpc12_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TRAINING_COURT_WALK_71_06_3, FACEMASK_ANY, $0000, TrainingCourtNpc13_15, $00, $00
	db $ff
TrainingCourtNpc06_15:
	test_flag FLAG_CLEARED_SERVICE_MATCH_1 ; $50fc
	jr nz, .checkFlag ; $50ff
	call ServiceAceMatchChallengeScene ; $5101
	ret ; $5104
.checkFlag:
	test_flag FLAG_CLEARED_SERVICE_MATCH_2 ; $5105
	jr nz, .isClearedServiceMatch2 ; $5108
	call CenterLineServeMatchChallengeScene ; $510a
	ret ; $510d
.isClearedServiceMatch2:
	call AcademyRulesServeMatchChallengeScene ; $510e
	ret ; $5111
TrainingCourtNpc07FaceDown_15:
	script_set_speed ACTOR_PLAYER, $0008 ; $5112
	script_lock_facing ACTOR_PLAYER ; $511a
	script_move_target ACTOR_PLAYER, 19.0, 19.0 ; $5121
	script_wait_move ACTOR_PLAYER ; $512c
	script_unlock_facing ACTOR_PLAYER ; $5131
	script_face ACTOR_PLAYER, FACE_DOWN ; $5138
TrainingCourtNpc07_15:
	test_flag FLAG_CLEARED_SERVICE_PRACTICE_1 ; $513f
	jr nz, .lesson2 ; $5142
	call ServeCoachJuniorLessonScene ; $5144
	ret ; $5147
.lesson2:
	test_flag FLAG_CLEARED_SERVICE_PRACTICE_2 ; $5148
	jr nz, .lesson3 ; $514b
	test_flag FLAG_SERVE_COACH_GREETED ; $514d
	jr nz, .lesson2Line ; $5150
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5152
	jr z, .lesson2Line ; $5155
	call ServeCoachSeniorLessonScene ; $5157
	ret ; $515a
.lesson2Line:
	script_set_text Text_37_33 ; $515b
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5161
	jr z, .speak ; $5164
	script_set_text Text_37_34 ; $5166
.speak:
	script_speak ACTOR_TRAINING_COURT_CURT ; $516c
	ret ; $5171
.lesson3:
	test_flag FLAG_CLEARED_SERVICE_PRACTICE_3 ; $5172
	jr nz, .done ; $5175
	test_flag FLAG_SERVE_COACH_GREETED ; $5177
	jr nz, .lesson3Line ; $517a
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $517c
	jr z, .lesson3Line ; $517f
	call ServeCoachVarsityLessonScene ; $5181
	ret ; $5184
.lesson3Line:
	script_set_text Text_37_50 ; $5185
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $518b
	jr z, .speakLesson3 ; $518e
	script_set_text Text_37_34 ; $5190
.speakLesson3:
	script_speak ACTOR_TRAINING_COURT_CURT ; $5196
	ret ; $519b
.done:
	script_set_text Text_37_61 ; $519c
	script_speak ACTOR_TRAINING_COURT_CURT ; $51a2
	ret ; $51a7
TrainingCourtNpc11_15:
	test_flag FLAG_CLEARED_NET_GAME_MATCH_1 ; $51a8
	jr nz, .checkFlag ; $51ab
	call VolleyMatchChallengeScene ; $51ad
	ret ; $51b0
.checkFlag:
	test_flag FLAG_CLEARED_NET_GAME_MATCH_2 ; $51b1
	jr nz, .isClearedNetGameMatch2 ; $51b4
	call SmashMatchChallengeScene ; $51b6
	ret ; $51b9
.isClearedNetGameMatch2:
	call DropShotMatchChallengeScene ; $51ba
	ret ; $51bd
TrainingCourtNpc12FaceUp_15:
	script_set_speed ACTOR_PLAYER, $0008 ; $51be
	script_lock_facing ACTOR_PLAYER ; $51c6
	script_move_target ACTOR_PLAYER, 45.0, 43.0 ; $51cd
	script_wait_move ACTOR_PLAYER ; $51d8
	script_unlock_facing ACTOR_PLAYER ; $51dd
	script_face ACTOR_PLAYER, FACE_UP ; $51e4
TrainingCourtNpc12_15:
	test_flag FLAG_CLEARED_NET_GAME_PRACTICE_1 ; $51eb
	jr nz, .lesson2 ; $51ee
	call NetCoachVolleyLessonScene ; $51f0
	ret ; $51f3
.lesson2:
	test_flag FLAG_CLEARED_NET_GAME_PRACTICE_2 ; $51f4
	jr nz, .lesson3 ; $51f7
	test_flag FLAG_NET_COACH_GREETED ; $51f9
	jr nz, .lesson2Line ; $51fc
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $51fe
	jr z, .lesson2Line ; $5201
	call NetCoachSmashLessonScene ; $5203
	ret ; $5206
.lesson2Line:
	script_set_text Text_37_128 ; $5207
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $520d
	jr z, .speak ; $5210
	script_set_text Text_37_131 ; $5212
.speak:
	script_speak ACTOR_TRAINING_COURT_BETH ; $5218
	ret ; $521d
.lesson3:
	test_flag FLAG_CLEARED_NET_GAME_PRACTICE_3 ; $521e
	jr nz, .done ; $5221
	test_flag FLAG_NET_COACH_GREETED ; $5223
	jr nz, .lesson3Line ; $5226
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $5228
	jr z, .lesson3Line ; $522b
	call NetCoachDropShotLessonScene ; $522d
	ret ; $5230
.lesson3Line:
	script_set_text Text_37_158 ; $5231
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $5237
	jr z, .speakLesson3 ; $523a
	script_set_text Text_37_156 ; $523c
.speakLesson3:
	script_speak ACTOR_TRAINING_COURT_BETH ; $5242
	ret ; $5247
.done:
	script_set_text Text_37_187 ; $5248
	script_speak ACTOR_TRAINING_COURT_BETH ; $524e
	ret ; $5253
TrainingCourtNpc0C_15:
	test_flag FLAG_CLEARED_STROKE_MATCH_1 ; $5254
	jr nz, .checkFlag ; $5257
	call StrokeMatchChallengeScene ; $5259
	ret ; $525c
.checkFlag:
	test_flag FLAG_CLEARED_STROKE_MATCH_2 ; $525d
	jr nz, .isClearedStrokeMatch2 ; $5260
	call LobMatchChallengeScene ; $5262
	ret ; $5265
.isClearedStrokeMatch2:
	call ReturnMatchChallengeScene ; $5266
	ret ; $5269
TrainingCourtNpc0DFaceUp_15:
	script_set_speed ACTOR_PLAYER, $0008 ; $526a
	script_lock_facing ACTOR_PLAYER ; $5272
	script_move_target ACTOR_PLAYER, 19.0, 43.0 ; $5279
	script_wait_move ACTOR_PLAYER ; $5284
	script_unlock_facing ACTOR_PLAYER ; $5289
	script_face ACTOR_PLAYER, FACE_UP ; $5290
TrainingCourtNpc0D_15:
	test_flag FLAG_CLEARED_STROKE_PRACTICE_1 ; $5297
	jr nz, .lesson2 ; $529a
	call ReturnCoachReturnLessonScene ; $529c
	ret ; $529f
.lesson2:
	test_flag FLAG_CLEARED_STROKE_PRACTICE_2 ; $52a0
	jr nz, .lesson3 ; $52a3
	test_flag FLAG_RETURN_COACH_GREETED ; $52a5
	jr nz, .lesson2Line ; $52a8
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $52aa
	jr z, .lesson2Line ; $52ad
	call ReturnCoachLobLessonScene ; $52af
	ret ; $52b2
.lesson2Line:
	script_set_text Text_37_225 ; $52b3
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $52b9
	jr z, .speak ; $52bc
	script_set_text Text_37_226 ; $52be
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $52c4
	jr z, .speak ; $52c7
	script_set_text Text_37_226 ; $52c9
.speak:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $52cf
	ret ; $52d4
.lesson3:
	test_flag FLAG_CLEARED_STROKE_PRACTICE_3 ; $52d5
	jr nz, .done ; $52d8
	test_flag FLAG_RETURN_COACH_GREETED ; $52da
	jr nz, .lesson3Line ; $52dd
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $52df
	jr z, .lesson3Line ; $52e2
	call ReturnCoachPassingShotLessonScene ; $52e4
	ret ; $52e7
.lesson3Line:
	script_set_text Text_37_248 ; $52e8
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $52ee
	ret ; $52f3
.done:
	script_set_text Text_6e_18 ; $52f4
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $52fa
	ret ; $52ff
TrainingCourtFacingScripts_15:
	; $5300, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TrainingCourtFacing01_15, $00, $00
	db $ff
TrainingCourtFacing01_15:
	ret ; $5309
TrainingCourtTileTriggers_15:
	; $530a, 9 bytes (map_scripts)
	map_script $01, FACEMASK_UP, $9000, TrainingCourtTile01_15, $00, $00
	db $ff
TrainingCourtTile01_15:
	script_move_target ACTOR_PLAYER, 51.0, 13.0 ; $5313
	script_wait_move ACTOR_PLAYER ; $531e
	script_face ACTOR_PLAYER, FACE_DOWN ; $5323
	call RunWaterSpriteSwingContestAndReward ; $532a
	ret ; $532d
TrainingCourtInitScript_15:
	call ComputeStoryRankTier_15 ; $532e
	ld a, [wMapSceneStage] ; $5331
	cp $05 ; $5334
	jr c, .fromLesson ; $5336
	ld a, [wMapSceneStage] ; $5338
	sub $06 ; $533b
	ld [wMapSceneStage], a ; $533d
.fromLesson:
	ld a, [wStoryModeEntryPoint] ; $5340
	cp $0f ; $5343
	jr nz, .fromMatch ; $5345
	call TrainingCourtIntroTourScene ; $5347
	ret ; $534a
.fromMatch:
	call HideServeChallengerActor ; $534b
	call HideStrokeChallengerActor ; $534e
	call HideNetChallengerActor ; $5351
	call PlaceSwingPracticeKidActor ; $5354
	ld a, [wStoryModeEntryPoint] ; $5357
	cp $0a ; $535a
	jr nz, .placeActors ; $535c
	call TrainingCourtResultDispatch ; $535e
	ret ; $5361
.placeActors:
	ld a, [wStoryModeEntryPoint] ; $5362
	cp $09 ; $5365
	jr nz, .done ; $5367
	call StartPendingLessonScene ; $5369
.done:
	ret ; $536c
TrainingCourtResultDispatch:
	ld a, [wMatchExitRequest] ; $536d
	cp $01 ; $5370
	jr nz, .ne01 ; $5372
	call TrainingCourtReentryDispatch ; $5374
	ret ; $5377
.ne01:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5378
	cp MINIGAME_TENNIS_MACHINE_1 ; $537b
	jr c, .lt12 ; $537d
	ret ; $537f
.lt12:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5380
	ld a, a ; $5383
	rst Rst00 ; $5384
	dw StrokeChallengerResultScene.celebrate ; $5385 jumptable
	dw StrokeChallengerResultScene.speakWin ; $5387 jumptable
	dw StrokeChallengerResultScene.partnerJoins ; $5389 jumptable
	dw TrainingCourtResultDispatch.dispatchStage ; $538b jumptable
	dw TrainingCourtResultDispatch.dispatchStage2 ; $538d jumptable
	dw TrainingCourtResultDispatch.dispatchStage3 ; $538f jumptable
	dw MovePlayerToLessonCourtSpot.netResultText ; $5391 jumptable
	dw MovePlayerToLessonCourtSpot.netResultDoubles ; $5393 jumptable
	dw MovePlayerToLessonCourtSpot.serveResultText ; $5395 jumptable
	dw InitServeCoachScene.dispatchStage ; $5397 jumptable
	dw InitServeCoachScene.dispatchStage2 ; $5399 jumptable
	dw InitServeCoachScene.dispatchStage3 ; $539b jumptable
	dw MovePlayerToLessonCourtSpot.serveResultTextAlt ; $539d jumptable
	dw MovePlayerToLessonCourtSpot.strokeResultText ; $539f jumptable
	dw MovePlayerToLessonCourtSpot.strokeResult ; $53a1 jumptable
	dw InitNetCoachScene.dispatchStage ; $53a3 jumptable
	dw InitNetCoachScene.dispatchStage2 ; $53a5 jumptable
	dw InitNetCoachScene.dispatchStage3 ; $53a7 jumptable
TrainingCourtReentryDispatch:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	dw TrainingCourtReentryDispatch.serveCourt ; $53ae jumptable
	dw TrainingCourtReentryDispatch.serveCourt ; $53b0 jumptable
	dw TrainingCourtReentryDispatch.serveCourt ; $53b2 jumptable
	dw TrainingCourtReentryDispatch.netCourt ; $53b4 jumptable
	dw TrainingCourtReentryDispatch.netCourt ; $53b6 jumptable
	dw TrainingCourtReentryDispatch.netCourt ; $53b8 jumptable
	dw TrainingCourtReentryDispatch.strokeCourt ; $53ba jumptable
	dw TrainingCourtReentryDispatch.strokeCourt ; $53bc jumptable
	dw TrainingCourtReentryDispatch.strokeCourt ; $53be jumptable
	dw TrainingCourtReentryDispatch.serveCourtDoubles ; $53c0 jumptable
	dw TrainingCourtReentryDispatch.serveCourtDoubles ; $53c2 jumptable
	dw TrainingCourtReentryDispatch.serveCourtDoubles ; $53c4 jumptable
	dw TrainingCourtReentryDispatch.netCourtDoubles ; $53c6 jumptable
	dw TrainingCourtReentryDispatch.netCourtDoubles ; $53c8 jumptable
	dw TrainingCourtReentryDispatch.netCourtDoubles ; $53ca jumptable
	dw TrainingCourtReentryDispatch.strokeCourtDoubles ; $53cc jumptable
	dw TrainingCourtReentryDispatch.strokeCourtDoubles ; $53ce jumptable
	dw TrainingCourtReentryDispatch.strokeCourtDoubles ; $53d0 jumptable
.serveCourt:
	xor a ; $53d2
	ld [wStoryModeShowLocationName], a ; $53d3
	ld a, $06 ; $53d6
	ld [wMapSceneStage2], a ; $53d8
	script_set_position ACTOR_PLAYER, 24.0, 17.0 ; $53db
	script_face ACTOR_PLAYER, FACE_UP ; $53e6
	ld a, [wMapSceneStage2] ; $53ed
	ld bc, $1800 ; $53f0
	ld de, $0d00 ; $53f3
	farcall ScriptSetActorPosition ; $53f6
	ld a, [wMapSceneStage2] ; $53f9
	ld b, $40 ; $53fc
	farcall SetActorFacing ; $53fe
	script_null_script ACTOR_PARTNER ; $5401
	script_set_position ACTOR_PARTNER, 19.0, 17.0 ; $5406
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5411
	script_player_speed $00f0 ; $5418
	script_move_player 24.0, 15.0 ; $541e
	farcall WaitPlayerMoveDone ; $5428
	script_fade_in $08 ; $542b
	call WaitFadeEnd ; $5430
	call WalkChallengerOntoCourt ; $5433
	ret ; $5436
.netCourt:
	xor a ; $5437
	ld [wStoryModeShowLocationName], a ; $5438
	script_player_speed $00f0 ; $543b
	script_set_position ACTOR_PLAYER, 19.0, 19.0 ; $5441
	script_set_position ACTOR_PARTNER, 19.0, 17.0 ; $544c
	script_move_player 19.0, 19.0 ; $5457
	farcall WaitPlayerMoveDone ; $5461
	script_face ACTOR_PLAYER, FACE_DOWN ; $5464
	script_face ACTOR_PARTNER, FACE_DOWN ; $546b
	script_face ACTOR_TRAINING_COURT_CURT, FACE_LEFT ; $5472
	script_fade_in $04 ; $5479
	call WaitFadeEnd ; $547e
	ret ; $5481
.strokeCourt:
	xor a ; $5482
	ld [wStoryModeShowLocationName], a ; $5483
	ld a, $11 ; $5486
	ld [wMapSceneStage2], a ; $5488
	script_set_position ACTOR_PLAYER, 40.0, 42.0 ; $548b
	script_face ACTOR_PLAYER, FACE_UP ; $5496
	ld a, [wMapSceneStage2] ; $549d
	ld bc, $2800 ; $54a0
	ld de, $2500 ; $54a3
	farcall ScriptSetActorPosition ; $54a6
	ld a, [wMapSceneStage2] ; $54a9
	ld b, $40 ; $54ac
	farcall SetActorFacing ; $54ae
	script_null_script ACTOR_PARTNER ; $54b1
	script_set_position ACTOR_PARTNER, 45.0, 45.0 ; $54b6
	script_face ACTOR_PARTNER, FACE_LEFT ; $54c1
	script_player_speed $00f0 ; $54c8
	script_move_player 40.0, 41.0 ; $54ce
	farcall WaitPlayerMoveDone ; $54d8
	script_fade_in $08 ; $54db
	call WaitFadeEnd ; $54e0
	call WalkChallengerOntoCourt ; $54e3
	ret ; $54e6
.serveCourtDoubles:
	xor a ; $54e7
	ld [wStoryModeShowLocationName], a ; $54e8
	script_player_speed $00f0 ; $54eb
	script_set_position ACTOR_PLAYER, 45.0, 43.0 ; $54f1
	script_set_position ACTOR_PARTNER, 47.0, 43.0 ; $54fc
	script_move_player 45.0, 43.0 ; $5507
	farcall WaitPlayerMoveDone ; $5511
	script_face ACTOR_PLAYER, FACE_UP ; $5514
	script_face ACTOR_PARTNER, FACE_UP ; $551b
	script_face ACTOR_TRAINING_COURT_BETH, FACE_RIGHT ; $5522
	script_fade_in $04 ; $5529
	call WaitFadeEnd ; $552e
	ret ; $5531
.netCourtDoubles:
	xor a ; $5532
	ld [wStoryModeShowLocationName], a ; $5533
	ld a, $0c ; $5536
	ld [wMapSceneStage2], a ; $5538
	script_set_position ACTOR_PLAYER, 24.0, 42.0 ; $553b
	script_face ACTOR_PLAYER, FACE_UP ; $5546
	ld a, [wMapSceneStage2] ; $554d
	ld bc, $1800 ; $5550
	ld de, $2500 ; $5553
	farcall ScriptSetActorPosition ; $5556
	ld a, [wMapSceneStage2] ; $5559
	ld b, $40 ; $555c
	farcall SetActorFacing ; $555e
	script_null_script ACTOR_PARTNER ; $5561
	script_set_position ACTOR_PARTNER, 19.0, 45.0 ; $5566
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5571
	script_player_speed $00f0 ; $5578
	script_move_player 24.0, 40.0 ; $557e
	farcall WaitPlayerMoveDone ; $5588
	script_fade_in $08 ; $558b
	call WaitFadeEnd ; $5590
	call WalkChallengerOntoCourt ; $5593
	ret ; $5596
.strokeCourtDoubles:
	xor a ; $5597
	ld [wStoryModeShowLocationName], a ; $5598
	script_player_speed $00f0 ; $559b
	script_set_position ACTOR_PLAYER, 19.0, 43.0 ; $55a1
	script_set_position ACTOR_PARTNER, 17.0, 43.0 ; $55ac
	script_move_player 19.0, 43.0 ; $55b7
	farcall WaitPlayerMoveDone ; $55c1
	script_face ACTOR_PLAYER, FACE_UP ; $55c4
	script_face ACTOR_PARTNER, FACE_UP ; $55cb
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_UP ; $55d2
	script_fade_in $04 ; $55d9
	call WaitFadeEnd ; $55de
	ret ; $55e1
