WalkToStrokeChallengeCourtCutscene:
	script_null_script ACTOR_PARTNER ; $6f51
	script_move_player 24.0, 39.0 ; $6f56
	script_set_actor_script ACTOR_TRAINING_COURT_ALLIE, ActorScript_15_10 ; $6f60
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_11 ; $6f6b
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_12 ; $6f76
	script_wait_actor_script ACTOR_PLAYER ; $6f81
	call PlayerPartnerGestureCutscene ; $6f86
	ld a, STORYLOC_TRAINING_COURT ; $6f89
	ld [wStoryModeCurrentLocation], a ; $6f8b
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $6f8e
	ld [wStoryModeEntryPoint], a ; $6f90
	ld a, EXITTRIGGER_DIRECT ; $6f93
	ld [wUnusedExitTriggerIdMirror], a ; $6f95
	ld [wStoryModeExitTriggerRequest], a ; $6f98
	ret ; $6f9b
ActorScript_15_10:
	; $6f9c, 11 bytes (actor_script)
	as_set_target 23.0, 31.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_11:
	; $6fa7, 23 bytes (actor_script)
	as_set_target 17.0, 39.0
	as_wait_move
	as_set_target 17.0, 43.0
	as_wait_move
	as_set_target 25.0, 46.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_12:
	; $6fbe, 17 bytes (actor_script)
	as_set_target 17.0, 41.0
	as_wait_move
	as_set_target 19.0, 45.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
NetCoachVolleyLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_BETH, ACTOR_PARTNER ; $6fcf
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6fd7
	jr nz, .notJunior ; $6fda
	script_set_text Text_BethJuniorNetPractice ; $6fdc
	jr .prompt ; $6fe2
.notJunior:
	script_set_text Text_BethHerePracticeNetGame ; $6fe4
.prompt:
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $6fea
	farcall RunDialogueYesNoPrompt ; $6fef
	farcall ScriptCloseDialogueWindow ; $6ff2
	script_wait_frames 5 ; $6ff5
	and a ; $6ffc
	jr nz, .declined ; $6ffd
	farcall AdvanceDialogueTextCursor ; $6fff
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $7002
	farcall RunDialogueYesNoPrompt ; $7007
	farcall ScriptCloseDialogueWindow ; $700a
	script_wait_frames 5 ; $700d
	and a ; $7014
	jr nz, .declined ; $7015
	farcall AdvanceDialogueTextCursor ; $7017
	script_speak ACTOR_TRAINING_COURT_BETH ; $701a
	call MovePartyToNetCoachSpot ; $701f
	script_face ACTOR_TRAINING_COURT_BETH, FACE_LEFT ; $7022
	script_speak ACTOR_TRAINING_COURT_BETH ; $7029
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $702e
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7035
	script_set_text Text_BethServeVolleyBasics ; $703a
	script_speak ACTOR_TRAINING_COURT_BETH ; $7040
	ld a, MINIGAME_NET_GAME_PRACTICE_1 ; $7045
	ld [wCurrentMatchIndex], a ; $7047
	ld a, STORYLOC_TRAINING_COURT ; $704a
	ld [wStoryModeCurrentLocation], a ; $704c
	ld a, ENTRY_TRAINING_COURT_PENDING_LESSON ; $704f
	ld [wStoryModeEntryPoint], a ; $7051
	ld a, EXITTRIGGER_DIRECT ; $7054
	ld [wUnusedExitTriggerIdMirror], a ; $7056
	ld [wStoryModeExitTriggerRequest], a ; $7059
	script_fade_out 16 ; $705c
	call WaitFadeEnd ; $7061
	farcall ShowDrillBriefingScreen ; $7064
	ret ; $7067
.declined:
	script_speak ACTOR_TRAINING_COURT_BETH ; $7068
	ret ; $706d
NetCoachSmashLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_BETH, ACTOR_PARTNER ; $706e
	script_set_text Text_BethSmashLessonOffer ; $7076
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $707c
	farcall RunDialogueYesNoPrompt ; $7081
	farcall ScriptCloseDialogueWindow ; $7084
	script_wait_frames 5 ; $7087
	and a ; $708e
	jr nz, NetCoachVolleyLessonScene.declined ; $708f
	farcall AdvanceDialogueTextCursor ; $7091
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $7094
	farcall RunDialogueYesNoPrompt ; $7099
	farcall ScriptCloseDialogueWindow ; $709c
	script_wait_frames 5 ; $709f
	and a ; $70a6
	jr nz, NetCoachVolleyLessonScene.declined ; $70a7
	farcall AdvanceDialogueTextCursor ; $70a9
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $70ac
	farcall RunDialogueYesNoPrompt ; $70b1
	farcall ScriptCloseDialogueWindow ; $70b4
	script_wait_frames 5 ; $70b7
	and a ; $70be
	jr nz, NetCoachVolleyLessonScene.declined ; $70bf
	farcall AdvanceDialogueTextCursor ; $70c1
	script_speak ACTOR_TRAINING_COURT_BETH ; $70c4
	call MovePartyToNetCoachSpot ; $70c9
	script_face ACTOR_TRAINING_COURT_BETH, FACE_LEFT ; $70cc
	script_speak ACTOR_TRAINING_COURT_BETH ; $70d3
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $70d8
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $70df
	script_speak ACTOR_TRAINING_COURT_BETH ; $70e4
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_NOD ; $70e9
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $70f0
	script_speak ACTOR_TRAINING_COURT_BETH ; $70f5
	ld a, MINIGAME_NET_GAME_PRACTICE_2 ; $70fa
	ld [wCurrentMatchIndex], a ; $70fc
	ld a, STORYLOC_TRAINING_COURT ; $70ff
	ld [wStoryModeCurrentLocation], a ; $7101
	ld a, ENTRY_TRAINING_COURT_PENDING_LESSON ; $7104
	ld [wStoryModeEntryPoint], a ; $7106
	ld a, EXITTRIGGER_DIRECT ; $7109
	ld [wUnusedExitTriggerIdMirror], a ; $710b
	ld [wStoryModeExitTriggerRequest], a ; $710e
	script_fade_out 16 ; $7111
	call WaitFadeEnd ; $7116
	farcall ShowDrillBriefingScreen ; $7119
	ret ; $711c
NetCoachDropShotLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_BETH, ACTOR_PARTNER ; $711d
	script_set_text Text_BethDropShotLessonOffer ; $7125
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $712b
	farcall RunDialogueYesNoPrompt ; $7130
	farcall ScriptCloseDialogueWindow ; $7133
	script_wait_frames 5 ; $7136
	and a ; $713d
	jp nz, NetCoachVolleyLessonScene.declined ; $713e
	farcall AdvanceDialogueTextCursor ; $7141
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $7144
	farcall RunDialogueYesNoPrompt ; $7149
	farcall ScriptCloseDialogueWindow ; $714c
	script_wait_frames 5 ; $714f
	and a ; $7156
	jp nz, NetCoachVolleyLessonScene.declined ; $7157
	farcall AdvanceDialogueTextCursor ; $715a
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $715d
	farcall RunDialogueYesNoPrompt ; $7162
	farcall ScriptCloseDialogueWindow ; $7165
	script_wait_frames 5 ; $7168
	and a ; $716f
	jp nz, NetCoachVolleyLessonScene.declined ; $7170
	farcall AdvanceDialogueTextCursor ; $7173
	script_speak ACTOR_TRAINING_COURT_BETH ; $7176
	call MovePartyToNetCoachSpot ; $717b
	script_face ACTOR_TRAINING_COURT_BETH, FACE_LEFT ; $717e
	script_speak ACTOR_TRAINING_COURT_BETH ; $7185
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $718a
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7191
	script_speak ACTOR_TRAINING_COURT_BETH ; $7196
	ld a, MINIGAME_NET_GAME_PRACTICE_3 ; $719b
	ld [wCurrentMatchIndex], a ; $719d
	ld a, STORYLOC_TRAINING_COURT ; $71a0
	ld [wStoryModeCurrentLocation], a ; $71a2
	ld a, ENTRY_TRAINING_COURT_PENDING_LESSON ; $71a5
	ld [wStoryModeEntryPoint], a ; $71a7
	ld a, EXITTRIGGER_DIRECT ; $71aa
	ld [wUnusedExitTriggerIdMirror], a ; $71ac
	ld [wStoryModeExitTriggerRequest], a ; $71af
	script_fade_out 16 ; $71b2
	call WaitFadeEnd ; $71b7
	farcall ShowDrillBriefingScreen ; $71ba
	ret ; $71bd
HideServeChallengerActor:
	test_flag FLAG_SERVE_CHALLENGER_DEFEATED ; $71be
	jr nz, .hide ; $71c1
	call TestServeChallengerGameFlag ; $71c3
	jr z, .done ; $71c6
.hide:
	script_set_position ACTOR_TRAINING_COURT_BOB_1, 63.0, 63.0 ; $71c8
.done:
	ret ; $71d3
TestServeChallengerGameFlag:
	ld a, [wMapSceneStage] ; $71d4
	add a ; $71d7
	ld_hl_indexed TestServeChallengerGameFlagTable ; $71d8
	ld a, [hl+] ; $71df
	ld d, [hl] ; $71e0
	ld e, a ; $71e1
	call TestGameFlagByNumber ; $71e2
	ret ; $71e5
; TestServeChallengerGameFlag with SetGameFlagByNumber in place of TestGameFlagByNumber over the same table: the Set member of the pair. Nothing calls it.
Unused_15_SetServeChallengerGameFlag:
	ld a, [wMapSceneStage] ; $71e6
	add a ; $71e9
	ld_hl_indexed TestServeChallengerGameFlagTable ; $71ea
	ld a, [hl+] ; $71f1
	ld d, [hl] ; $71f2
	ld e, a ; $71f3
	call SetGameFlagByNumber ; $71f4
	ret ; $71f7
TestServeChallengerGameFlagTable:
	; $71f8, 12 bytes (flag numbers, for *GameFlagByNumber)
	dw FLAG_CLEARED_SERVICE_MATCH_1 ; record 0
	dw FLAG_CLEARED_SERVICE_MATCH_2 ; record 1
	dw FLAG_CLEARED_SERVICE_MATCH_3 ; record 2
	dw FLAG_CLEARED_SERVICE_MATCH_3 ; record 3
	dw FLAG_CLEARED_SERVICE_MATCH_3 ; record 4
	dw FLAG_CLEARED_SERVICE_MATCH_3 ; record 5
HideNetChallengerActor:
	test_flag FLAG_NET_CHALLENGER_DEFEATED ; $7204
	jr nz, .hide ; $7207
	call TestNetChallengerGameFlag ; $7209
	jr z, .done ; $720c
.hide:
	script_set_position ACTOR_TRAINING_COURT_BRIAN, 63.0, 63.0 ; $720e
.done:
	ret ; $7219
TestNetChallengerGameFlag:
	ld a, [wMapSceneStage] ; $721a
	add a ; $721d
	ld_hl_indexed TestNetChallengerGameFlagTable ; $721e
	ld a, [hl+] ; $7225
	ld d, [hl] ; $7226
	ld e, a ; $7227
	call TestGameFlagByNumber ; $7228
	ret ; $722b
; TestNetChallengerGameFlag with SetGameFlagByNumber in place of TestGameFlagByNumber over the same table: the Set member of the pair. Nothing calls it.
Unused_15_SetNetChallengerGameFlag:
	ld a, [wMapSceneStage] ; $722c
	add a ; $722f
	ld_hl_indexed TestNetChallengerGameFlagTable ; $7230
	ld a, [hl+] ; $7237
	ld d, [hl] ; $7238
	ld e, a ; $7239
	call SetGameFlagByNumber ; $723a
	ret ; $723d
TestNetChallengerGameFlagTable:
	; $723e, 12 bytes (flag numbers, for *GameFlagByNumber)
	dw FLAG_CLEARED_NET_GAME_MATCH_1 ; record 0
	dw FLAG_CLEARED_NET_GAME_MATCH_2 ; record 1
	dw FLAG_CLEARED_NET_GAME_MATCH_3 ; record 2
	dw FLAG_CLEARED_NET_GAME_MATCH_3 ; record 3
	dw FLAG_CLEARED_NET_GAME_MATCH_3 ; record 4
	dw FLAG_CLEARED_NET_GAME_MATCH_3 ; record 5
HideStrokeChallengerActor:
	test_flag FLAG_STROKE_CHALLENGER_DEFEATED ; $724a
	jr nz, .hide ; $724d
	call TestStrokeChallengerGameFlag ; $724f
	jr z, .done ; $7252
.hide:
	script_set_position ACTOR_TRAINING_COURT_ALLIE, 63.0, 63.0 ; $7254
.done:
	ret ; $725f
TestStrokeChallengerGameFlag:
	ld a, [wMapSceneStage] ; $7260
	add a ; $7263
	ld_hl_indexed TestStrokeChallengerGameFlagTable ; $7264
	ld a, [hl+] ; $726b
	ld d, [hl] ; $726c
	ld e, a ; $726d
	call TestGameFlagByNumber ; $726e
	ret ; $7271
; TestStrokeChallengerGameFlag with SetGameFlagByNumber in place of TestGameFlagByNumber over the same table: the Set member of the pair. Nothing calls it.
Unused_15_SetStrokeChallengerGameFlag:
	ld a, [wMapSceneStage] ; $7272
	add a ; $7275
	ld_hl_indexed TestStrokeChallengerGameFlagTable ; $7276
	ld a, [hl+] ; $727d
	ld d, [hl] ; $727e
	ld e, a ; $727f
	call SetGameFlagByNumber ; $7280
	ret ; $7283
TestStrokeChallengerGameFlagTable:
	; $7284, 12 bytes (flag numbers, for *GameFlagByNumber)
	dw FLAG_CLEARED_STROKE_MATCH_1 ; record 0
	dw FLAG_CLEARED_STROKE_MATCH_2 ; record 1
	dw FLAG_CLEARED_STROKE_MATCH_3 ; record 2
	dw FLAG_CLEARED_STROKE_MATCH_3 ; record 3
	dw FLAG_CLEARED_STROKE_MATCH_3 ; record 4
	dw FLAG_CLEARED_STROKE_MATCH_3 ; record 5
ServicePractice1ResultScene:
	ld a, [wDrillLessonResult] ; $7290
	jumptable a ; $7293
	dw ServeLessonPassedScene ; $7295 jumptable
	dw ServeLessonNoPointsScene ; $7297 jumptable
	dw ServeLessonDoubleFaultScene ; $7299 jumptable
	dw ServeLessonMissedBigTargetScene ; $729b jumptable
	dw ServeLessonNoPointsScene ; $729d jumptable
ServicePractice2ResultScene:
	ld a, [wDrillLessonResult] ; $729f
	jumptable a ; $72a2
	dw SpinServeLessonPassedScene ; $72a4 jumptable
	dw ServeLessonNoPointsScene ; $72a6 jumptable
	dw ServeLessonDoubleFaultScene ; $72a8 jumptable
	dw ServeLessonMissedTargetScene ; $72aa jumptable
	dw SpinServeLessonNoSpinScene ; $72ac jumptable
	dw SpinServeLessonLeftOnlyScene ; $72ae jumptable
	dw SpinServeLessonRightOnlyScene ; $72b0 jumptable
	dw ServeLessonNoPointsScene ; $72b2 jumptable
ServicePractice3ResultScene:
	ld a, [wDrillLessonResult] ; $72b4
	jumptable a ; $72b7
	dw ServeLineLessonPassedScene ; $72b9 jumptable
	dw ServeLessonNoPointsScene ; $72bb jumptable
	dw ServeLessonDoubleFaultScene ; $72bd jumptable
	dw ServeLessonMissedTargetScene ; $72bf jumptable
	dw ServeLineLessonTimingScene ; $72c1 jumptable
	dw ServeLineLessonNotCenterScene ; $72c3 jumptable
	dw ServeLessonNoPointsScene ; $72c5 jumptable
ServeLessonPassedScene:
	call InitServeCoachScene ; $72c7
	script_set_text Text_CurtClearedAllFourTargets ; $72ca
	script_speak ACTOR_TRAINING_COURT_CURT ; $72d0
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $72d5
	jr z, .speakLevelPassed ; $72d8
	farcall AdvanceDialogueTextCursor ; $72da
.speakLevelPassed:
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_CURT ; $72dd
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_NOD ; $72e5
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $72ec
	script_speak ACTOR_TRAINING_COURT_CURT ; $72f1
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_BOUNCE ; $72f6
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $72fd
	script_set_text Text_CurtKeepPracticingAfterPass ; $7302
	script_speak ACTOR_TRAINING_COURT_CURT ; $7308
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_SHAKE ; $730d
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $7314
	script_speak ACTOR_TRAINING_COURT_CURT ; $7319
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $731e
	jr z, .speakComeBackLine ; $7321
	farcall AdvanceDialogueTextCursor ; $7323
.speakComeBackLine:
	script_speak ACTOR_TRAINING_COURT_CURT ; $7326
	script_face ACTOR_TRAINING_COURT_CURT, FACE_LEFT ; $732b
	set_flag FLAG_SERVE_COACH_LESSON_PASSED_THIS_VISIT ; $7332
	ret ; $7335
SpinServeLessonPassedScene:
	call InitServeCoachScene ; $7336
	script_set_text Text_CurtClearedAllSpinServes ; $7339
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $733f
	jr z, .speak ; $7342
	script_set_text Text_CurtClearedAllSpinServesRanked ; $7344
.speak:
	script_speak ACTOR_TRAINING_COURT_CURT ; $734a
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_CURT ; $734f
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_NOD ; $7357
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $735e
	script_speak ACTOR_TRAINING_COURT_CURT ; $7363
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_BOUNCE ; $7368
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $736f
	script_speak ACTOR_TRAINING_COURT_CURT ; $7374
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_SHAKE ; $7379
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $7380
	script_speak ACTOR_TRAINING_COURT_CURT ; $7385
	script_face ACTOR_TRAINING_COURT_CURT, FACE_LEFT ; $738a
	script_wait_frames 5 ; $7391
	set_flag FLAG_SERVE_COACH_LESSON_PASSED_THIS_VISIT ; $7398
	ret ; $739b
ServeLineLessonPassedScene:
	call InitServeCoachScene ; $739c
	script_set_text Text_CurtClearedAllDownLine ; $739f
	script_speak ACTOR_TRAINING_COURT_CURT ; $73a5
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_CURT ; $73aa
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_NOD ; $73b2
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $73b9
	script_speak ACTOR_TRAINING_COURT_CURT ; $73be
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_BOUNCE ; $73c3
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $73ca
	script_speak ACTOR_TRAINING_COURT_CURT ; $73cf
	script_set_anim ACTOR_TRAINING_COURT_CURT, ANIM_NOD ; $73d4
	script_wait_idle ACTOR_TRAINING_COURT_CURT ; $73db
	script_speak ACTOR_TRAINING_COURT_CURT ; $73e0
	script_face ACTOR_TRAINING_COURT_CURT, FACE_LEFT ; $73e5
	set_flag FLAG_SERVE_COACH_LESSON_PASSED_THIS_VISIT ; $73ec
	ret ; $73ef
ServeLessonNoPointsScene:
	call InitServeCoachScene ; $73f0
	script_set_text Text_CurtMissedEveryTarget ; $73f3
	call ServeCoachChainedRetryPrompt ; $73f9
	ret ; $73fc
ServeLessonDoubleFaultScene:
	call InitServeCoachScene ; $73fd
	script_set_text Text_CurtDoubleFaults ; $7400
	call ServeCoachTwoStageRetryPrompt ; $7406
	ret ; $7409
ServeLessonMissedBigTargetScene:
	call InitServeCoachScene ; $740a
	script_set_text Text_CurtMissedBigTarget ; $740d
	call ServeCoachRetryPrompt ; $7413
	ret ; $7416
ServeLessonMissedTargetScene:
	call InitServeCoachScene ; $7417
	script_set_text Text_CurtHitTargetAtYourLevel ; $741a
	call ServeCoachRetryPrompt ; $7420
	ret ; $7423
SpinServeLessonNoSpinScene:
	call InitServeCoachScene ; $7424
	script_set_text Text_CurtNotPuttingSpin ; $7427
	call ServeCoachRetryPrompt ; $742d
	ret ; $7430
SpinServeLessonLeftOnlyScene:
	call InitServeCoachScene ; $7431
	script_set_text Text_CurtClearedLeftNotRight ; $7434
	call ServeCoachRetryPrompt ; $743a
	ret ; $743d
SpinServeLessonRightOnlyScene:
	call InitServeCoachScene ; $743e
	script_set_text Text_CurtClearedRightNotLeft ; $7441
	call ServeCoachRetryPrompt ; $7447
	ret ; $744a
ServeLineLessonTimingScene:
	call InitServeCoachScene ; $744b
	script_set_text Text_CurtServeLineFastTiming ; $744e
	call ServeCoachRetryPrompt ; $7454
	ret ; $7457
ServeLineLessonNotCenterScene:
	call InitServeCoachScene ; $7458
	script_set_text Text_CurtServeLineFromCenter ; $745b
	call ServeCoachRetryPrompt ; $7461
	ret ; $7464
ServeCoachChainedRetryPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $7465
	farcall RunDialogueYesNoPrompt ; $746a
	farcall ScriptCloseDialogueWindow ; $746d
	script_wait_frames 5 ; $7470
	and a ; $7477
	jp nz, InitServeCoachScene.speak ; $7478
	farcall AdvanceDialogueTextCursor ; $747b
ServeCoachRetryPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $747e
	farcall RunDialogueYesNoPrompt ; $7483
	farcall ScriptCloseDialogueWindow ; $7486
	script_wait_frames 5 ; $7489
	and a ; $7490
	jp z, ServeCoachTwoStageRetryPrompt.retry ; $7491
	farcall AdvanceDialogueTextCursor ; $7494
	jp InitServeCoachScene.speak ; $7497
ServeCoachTwoStageRetryPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $749a
	farcall RunDialogueYesNoPrompt ; $749f
	farcall ScriptCloseDialogueWindow ; $74a2
	script_wait_frames 5 ; $74a5
	and a ; $74ac
	jp nz, .secondPrompt ; $74ad
	farcall AdvanceDialogueTextCursor ; $74b0
.secondPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $74b3
	farcall RunDialogueYesNoPrompt ; $74b8
	farcall ScriptCloseDialogueWindow ; $74bb
	script_wait_frames 5 ; $74be
	and a ; $74c5
	jp z, .retry ; $74c6
	script_set_text Text_CurtPracticeFirstTryLater ; $74c9
	jp InitServeCoachScene.speak ; $74cf
.retry:
	script_set_text Text_CurtOkLetsDoIt ; $74d2
	script_speak ACTOR_TRAINING_COURT_CURT ; $74d8
	call ServeCoachWalkToCourtAndStartLesson ; $74dd
	ret ; $74e0
InitServeCoachScene:
	xor a ; $74e1
	ld [wStoryModeShowLocationName], a ; $74e2
	script_player_speed 7.5 ; $74e5
	script_set_position ACTOR_PLAYER, 19.0, 19.0 ; $74eb
	script_set_position ACTOR_PARTNER, 19.0, 17.0 ; $74f6
	script_move_player 19.0, 19.0 ; $7501
	farcall WaitPlayerMoveDone ; $750b
	script_face ACTOR_PLAYER, FACE_DOWN ; $750e
	script_face ACTOR_PARTNER, FACE_DOWN ; $7515
	script_face ACTOR_TRAINING_COURT_CURT, FACE_UP ; $751c
	script_fade_in 4 ; $7523
	call WaitFadeEnd ; $7528
	ret ; $752b
.speak:
	script_speak ACTOR_TRAINING_COURT_CURT ; $752c
	script_face ACTOR_TRAINING_COURT_CURT, FACE_LEFT ; $7531
	ret ; $7538
NetGamePractice1ResultScene:
	ld a, [wDrillLessonResult] ; $7539
	jumptable a ; $753c
	dw VolleyLessonPassedScene ; $753e jumptable
	dw NetLessonAllFaultsScene ; $7540 jumptable
	dw NetLessonDoubleFaultScene ; $7542 jumptable
	dw VolleyLessonMissedScene ; $7544 jumptable
	dw VolleyLessonWrongSideScene ; $7546 jumptable
	dw NetLessonAlmostScene ; $7548 jumptable
	dw NetLessonAllFaultsScene ; $754a jumptable
	dw NetLessonAllFaultsScene ; $754c jumptable
NetGamePractice2ResultScene:
	ld a, [wDrillLessonResult] ; $754e
	jumptable a ; $7551
	dw SmashLessonPassedScene ; $7553 jumptable
	dw NetLessonAllFaultsScene ; $7555 jumptable
	dw NetLessonDoubleFaultScene ; $7557 jumptable
	dw SmashLessonNotAllSidesScene ; $7559 jumptable
	dw SmashLessonJudgePositionScene ; $755b jumptable
	dw SmashLessonMissedScene ; $755d jumptable
	dw NetLessonAlmostScene ; $755f jumptable
	dw NetLessonAllFaultsScene ; $7561 jumptable
NetGamePractice3ResultScene:
	ld a, [wDrillLessonResult] ; $7563
	jumptable a ; $7566
	dw DropShotLessonPassedScene ; $7568 jumptable
	dw NetLessonAllFaultsScene ; $756a jumptable
	dw NetLessonDoubleFaultScene ; $756c jumptable
	dw DropShotLessonServeShallowScene ; $756e jumptable
	dw DropShotLessonNotAllSidesScene ; $7570 jumptable
	dw DropShotLessonTimingScene ; $7572 jumptable
	dw DropShotLessonMissedScene ; $7574 jumptable
	dw NetLessonAlmostScene ; $7576 jumptable
	dw NetLessonAllFaultsScene ; $7578 jumptable
