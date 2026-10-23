VolleyLessonPassedScene:
	script_set_text Text_BethClearedAllVolleys ; $757a
	call InitNetCoachScene ; $7580
	script_speak ACTOR_TRAINING_COURT_BETH ; $7583
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BETH ; $7588
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7590
	jr z, .animate ; $7593
	script_set_text Text_BethClearedBeginnerLevel ; $7595
.animate:
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_NOD ; $759b
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $75a2
	script_speak ACTOR_TRAINING_COURT_BETH ; $75a7
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $75ac
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $75b3
	script_speak ACTOR_TRAINING_COURT_BETH ; $75b8
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_SHAKE ; $75bd
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $75c4
	script_speak ACTOR_TRAINING_COURT_BETH ; $75c9
	script_face ACTOR_TRAINING_COURT_BETH, FACE_RIGHT ; $75ce
	set_flag FLAG_NET_COACH_LESSON_PASSED_THIS_VISIT ; $75d5
	ret ; $75d8
SmashLessonPassedScene:
	call InitNetCoachScene ; $75d9
	script_set_text Text_BethExcellentSmashes ; $75dc
	script_speak ACTOR_TRAINING_COURT_BETH ; $75e2
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BETH ; $75e7
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_NOD ; $75ef
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $75f6
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $75fb
	jr z, .speak ; $75fe
	script_set_text Text_BethClearedIntermediate ; $7600
.speak:
	script_speak ACTOR_TRAINING_COURT_BETH ; $7606
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $760b
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7612
	script_speak ACTOR_TRAINING_COURT_BETH ; $7617
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_SHAKE ; $761c
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7623
	script_speak ACTOR_TRAINING_COURT_BETH ; $7628
	script_face ACTOR_TRAINING_COURT_BETH, FACE_RIGHT ; $762d
	set_flag FLAG_NET_COACH_LESSON_PASSED_THIS_VISIT ; $7634
	ret ; $7637
DropShotLessonPassedScene:
	call InitNetCoachScene ; $7638
	script_set_text Text_BethNiceDropShots ; $763b
	script_speak ACTOR_TRAINING_COURT_BETH ; $7641
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BETH ; $7646
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_NOD ; $764e
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7655
	script_speak ACTOR_TRAINING_COURT_BETH ; $765a
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_BOUNCE ; $765f
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7666
	script_speak ACTOR_TRAINING_COURT_BETH ; $766b
	script_set_anim ACTOR_TRAINING_COURT_BETH, ANIM_NOD ; $7670
	script_wait_idle ACTOR_TRAINING_COURT_BETH ; $7677
	script_speak ACTOR_TRAINING_COURT_BETH ; $767c
	script_face ACTOR_TRAINING_COURT_BETH, FACE_RIGHT ; $7681
	set_flag FLAG_NET_COACH_LESSON_PASSED_THIS_VISIT ; $7688
	ret ; $768b
NetLessonAllFaultsScene:
	call InitNetCoachScene ; $768c
	script_set_text Text_BethFaultedEveryTime ; $768f
	call NetCoachResultRetryPrompt ; $7695
	ret ; $7698
NetLessonDoubleFaultScene:
	call InitNetCoachScene ; $7699
	script_set_text Text_BethServeNeedsPractice ; $769c
	call NetCoachResultRetryPrompt ; $76a2
	ret ; $76a5
VolleyLessonMissedScene:
	call InitNetCoachScene ; $76a6
	script_set_text Text_BethMissedVolleysSlow ; $76a9
	call NetCoachResultRetryPrompt ; $76af
	ret ; $76b2
VolleyLessonWrongSideScene:
	call InitNetCoachScene ; $76b3
	script_set_text Text_BethVolleyToOppositeSide ; $76b6
	call NetCoachResultRetryPrompt ; $76bc
	ret ; $76bf
NetLessonAlmostScene:
	call InitNetCoachScene ; $76c0
	script_set_text Text_BethAlmostNextTime ; $76c3
	call NetCoachRetryPrompt ; $76c9
	ret ; $76cc
SmashLessonNotAllSidesScene:
	call InitNetCoachScene ; $76cd
	script_set_text Text_BethSmashNotAllSides ; $76d0
	call NetCoachResultRetryPrompt ; $76d6
	ret ; $76d9
SmashLessonMissedScene:
	call InitNetCoachScene ; $76da
	script_set_text Text_BethMissedSmashesSlow ; $76dd
	call NetCoachRetryPrompt ; $76e3
	ret ; $76e6
DropShotLessonServeShallowScene:
	call InitNetCoachScene ; $76e7
	script_set_text Text_BethDropShotServeDeeper ; $76ea
	call NetCoachResultRetryPrompt ; $76f0
	ret ; $76f3
DropShotLessonNotAllSidesScene:
	call InitNetCoachScene ; $76f4
	script_set_text Text_BethDropShotTimingSides ; $76f7
	call NetCoachResultRetryPrompt ; $76fd
	ret ; $7700
DropShotLessonMissedScene:
	call InitNetCoachScene ; $7701
	script_set_text Text_BethDropShotSlowShallow ; $7704
	call NetCoachRetryPrompt ; $770a
	ret ; $770d
SmashLessonJudgePositionScene:
	call InitNetCoachScene ; $770e
	script_set_text Text_BethSmashJudgePosition ; $7711
	call NetCoachResultRetryPrompt ; $7717
	ret ; $771a
DropShotLessonTimingScene:
	call InitNetCoachScene ; $771b
	script_set_text Text_BethDropShotTimingAllSides ; $771e
	call NetCoachResultRetryPrompt ; $7724
	ret ; $7727
NetCoachResultRetryPrompt:
	script_speak ACTOR_TRAINING_COURT_BETH ; $7728
NetCoachRetryPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_BETH ; $772d
	farcall RunDialogueYesNoPrompt ; $7732
	farcall ScriptCloseDialogueWindow ; $7735
	script_wait_frames 5 ; $7738
	and a ; $773f
	jp z, .retry ; $7740
	farcall AdvanceDialogueTextCursor ; $7743
	jp InitNetCoachScene.speak ; $7746
.retry:
	script_speak ACTOR_TRAINING_COURT_BETH ; $7749
	call NetCoachWalkToCourtAndStartLesson ; $774e
	ret ; $7751
InitNetCoachScene:
	xor a ; $7752
	ld [wStoryModeShowLocationName], a ; $7753
	script_player_speed 7.5 ; $7756
	script_set_position ACTOR_PLAYER, 45.0, 43.0 ; $775c
	script_set_position ACTOR_PARTNER, 47.0, 43.0 ; $7767
	script_move_player 45.0, 43.0 ; $7772
	farcall WaitPlayerMoveDone ; $777c
	script_face ACTOR_PLAYER, FACE_UP ; $777f
	script_face ACTOR_PARTNER, FACE_UP ; $7786
	script_face ACTOR_TRAINING_COURT_BETH, FACE_DOWN ; $778d
	script_fade_in 4 ; $7794
	call WaitFadeEnd ; $7799
	ret ; $779c
.speak:
	script_speak ACTOR_TRAINING_COURT_BETH ; $779d
	script_face ACTOR_TRAINING_COURT_BETH, FACE_RIGHT ; $77a2
	ret ; $77a9
StrokePractice1ResultScene:
	ld a, [wDrillLessonResult] ; $77aa
	jumptable a ; $77ad
	dw ReturnLessonPassedScene ; $77af jumptable
	dw ReturnLessonAllOutScene ; $77b1 jumptable
	dw ReturnLessonInaccurateScene ; $77b3 jumptable
	dw ReturnLessonMissedEveryTargetScene ; $77b5 jumptable
	dw ReturnLessonInconsistentScene ; $77b7 jumptable
	dw StrokeLessonAlmostScene ; $77b9 jumptable
	dw StrokeLessonAlmostScene ; $77bb jumptable
StrokePractice2ResultScene:
	ld a, [wDrillLessonResult] ; $77bd
	jumptable a ; $77c0
	dw LobLessonPassedScene ; $77c2 jumptable
	dw LobLessonTooFewScene ; $77c4 jumptable
	dw LobLessonVolleyedScene ; $77c6 jumptable
	dw LobLessonSmashedScene ; $77c8 jumptable
	dw LobLessonNoControlScene ; $77ca jumptable
	dw StrokeLessonAlmostScene ; $77cc jumptable
	dw ReturnLessonAllOutScene ; $77ce jumptable
StrokePractice3ResultScene:
	ld a, [wDrillLessonResult] ; $77d0
	jumptable a ; $77d3
	dw PassingShotLessonPassedScene ; $77d5 jumptable
	dw PassingShotLessonAllOutScene ; $77d7 jumptable
	dw PassingShotLessonInaccurateScene ; $77d9 jumptable
	dw PassingShotLessonNoPassesScene ; $77db jumptable
	dw PassingShotLessonInconsistentScene ; $77dd jumptable
	dw StrokeLessonAlmostScene ; $77df jumptable
	dw ReturnLessonAllOutScene ; $77e1 jumptable
ReturnLessonPassedScene:
	call InitReturnCoachScene ; $77e3
	script_set_text Text_ReturnCoachReturnedAllFour ; $77e6
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $77ec
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_2 ; $77f1
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_NOD ; $77f9
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $7800
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $7805
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $780a
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $7811
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7816
	jr z, .speakNextLessonLine ; $7819
	farcall AdvanceDialogueTextCursor ; $781b
.speakNextLessonLine:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $781e
	script_set_text Text_ReturnCoachMakeSeniorClass ; $7823
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_SHAKE ; $7829
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $7830
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7835
	jr z, .speakFollowUp ; $7838
	farcall AdvanceDialogueTextCursor ; $783a
.speakFollowUp:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $783d
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_UP ; $7842
	set_flag FLAG_RETURN_COACH_LESSON_PASSED_THIS_VISIT ; $7849
	ret ; $784c
LobLessonPassedScene:
	call InitReturnCoachScene ; $784d
	script_set_text Text_ReturnCoachAllLobsCorrect ; $7850
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $7856
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_2 ; $785b
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_NOD ; $7863
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $786a
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $786f
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $7874
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $787b
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $7880
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_SHAKE ; $7885
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $788c
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $7891
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_UP ; $7896
	set_flag FLAG_RETURN_COACH_LESSON_PASSED_THIS_VISIT ; $789d
	ret ; $78a0
PassingShotLessonPassedScene:
	call InitReturnCoachScene ; $78a1
	script_set_text Text_ReturnCoachAllPassingShots ; $78a4
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $78aa
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_2 ; $78af
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_NOD ; $78b7
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $78be
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $78c3
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $78c8
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $78cf
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $78d4
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_NOD ; $78d9
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $78e0
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $78e5
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_UP ; $78ea
	set_flag FLAG_RETURN_COACH_LESSON_PASSED_THIS_VISIT ; $78f1
	ret ; $78f4
ReturnLessonAllOutScene:
	call InitReturnCoachScene ; $78f5
	script_set_text Text_ReturnCoachReturnInBounds ; $78f8
	call ReturnCoachResultRetryPrompt ; $78fe
	ret ; $7901
ReturnLessonInaccurateScene:
	call InitReturnCoachScene ; $7902
	script_set_text Text_ReturnCoachPoorAccuracy ; $7905
	call ReturnCoachResultRetryPrompt ; $790b
	ret ; $790e
ReturnLessonMissedEveryTargetScene:
	call InitReturnCoachScene ; $790f
	script_set_text Text_ReturnCoachMissedEveryTarget ; $7912
	call ReturnCoachResultRetryPrompt ; $7918
	ret ; $791b
ReturnLessonInconsistentScene:
	call InitReturnCoachScene ; $791c
	script_set_text Text_ReturnCoachSlowReaction ; $791f
	call ReturnCoachRetryPrompt ; $7925
	ret ; $7928
StrokeLessonAlmostScene:
	call InitReturnCoachScene ; $7929
	script_set_text Text_ReturnCoachOnTheVerge ; $792c
	call ReturnCoachRetryPrompt ; $7932
	ret ; $7935
LobLessonTooFewScene:
	call InitReturnCoachScene ; $7936
	script_set_text Text_ReturnCoachNotHittingLobs ; $7939
	call ReturnCoachRetryPrompt ; $793f
	ret ; $7942
LobLessonVolleyedScene:
	call InitReturnCoachScene ; $7943
	script_set_text Text_ReturnCoachServerVolleyedLob ; $7946
	call ReturnCoachRetryPrompt ; $794c
	ret ; $794f
LobLessonSmashedScene:
	call InitReturnCoachScene ; $7950
	script_set_text Text_ReturnCoachLobsTooShort ; $7953
	call ReturnCoachRetryPrompt ; $7959
	ret ; $795c
LobLessonNoControlScene:
	call InitReturnCoachScene ; $795d
	script_set_text Text_ReturnCoachLobNeedsControl ; $7960
	call ReturnCoachRetryPrompt ; $7966
	ret ; $7969
PassingShotLessonAllOutScene:
	call InitReturnCoachScene ; $796a
	script_set_text Text_ReturnCoachAllShotsOut ; $796d
	call ReturnCoachResultRetryPrompt ; $7973
	ret ; $7976
PassingShotLessonInaccurateScene:
	call InitReturnCoachScene ; $7977
	script_set_text Text_ReturnCoachStillTooFarOff ; $797a
	call ReturnCoachResultRetryPrompt ; $7980
	ret ; $7983
PassingShotLessonNoPassesScene:
	call InitReturnCoachScene ; $7984
	script_set_text Text_ReturnCoachNotAPassingShot ; $7987
	call ReturnCoachResultRetryPrompt ; $798d
	ret ; $7990
PassingShotLessonInconsistentScene:
	call InitReturnCoachScene ; $7991
	script_set_text Text_ReturnCoachPassingInconsistent ; $7994
	call ReturnCoachResultRetryPrompt ; $799a
	ret ; $799d
ReturnCoachResultRetryPrompt:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $799e
ReturnCoachRetryPrompt:
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $79a3
	farcall RunDialogueYesNoPrompt ; $79a8
	farcall ScriptCloseDialogueWindow ; $79ab
	script_wait_frames 5 ; $79ae
	and a ; $79b5
	jp z, .retry ; $79b6
	jp InitReturnCoachScene.speak ; $79b9
.retry:
	farcall AdvanceDialogueTextCursor ; $79bc
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $79bf
	call ReturnCoachWalkToCourtAndStartLesson ; $79c4
	farcall EndCutsceneScriptMode ; $79c7
	ret ; $79ca
InitReturnCoachScene:
	xor a ; $79cb
	ld [wStoryModeShowLocationName], a ; $79cc
	script_player_speed 7.5 ; $79cf
	script_set_position ACTOR_PLAYER, 19.0, 43.0 ; $79d5
	script_set_position ACTOR_PARTNER, 17.0, 43.0 ; $79e0
	script_move_player 19.0, 43.0 ; $79eb
	farcall WaitPlayerMoveDone ; $79f5
	script_face ACTOR_PLAYER, FACE_UP ; $79f8
	script_face ACTOR_PARTNER, FACE_UP ; $79ff
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_DOWN ; $7a06
	script_fade_in 4 ; $7a0d
	call WaitFadeEnd ; $7a12
	ret ; $7a15
.speak:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $7a16
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_UP ; $7a1b
	ret ; $7a22
Unused_15_ActorScriptBlink3:
	; $7a23, 17 bytes (actor_script)
	as_set_pos 47.0, 1.0
	as_wait 3
	as_set_pos 47.0, 7.0
	as_wait 3
	as_jump Unused_15_ActorScriptBlink3
Unused_15_ActorScriptBlink5:
	; $7a34, 17 bytes (actor_script)
	as_set_pos 47.0, 1.0
	as_wait 5
	as_set_pos 47.0, 7.0
	as_wait 5
	as_jump Unused_15_ActorScriptBlink5
PlaceSwingPracticeKidActor:
	test_flag FLAG_DOUBLES ; $7a45
	jp nz, .done ; $7a48
	ld a, [wStoryMainEquipment] ; $7a4b
	and $0f ; $7a4e
	cp $03 ; $7a50
	jp nz, .done ; $7a52
	test_flag FLAG_SWING_PRACTICE_KID_LEFT ; $7a55
	jp nz, .done ; $7a58
	script_set_position ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, 53.0, 15.0 ; $7a5b
.done:
	ret ; $7a66
StartPendingLessonScene:
	ld a, [wCurrentMatchIndex] ; $7a67
	cp MINIGAME_NET_GAME_MATCH_1 ; $7a6a
	jr nc, .netLesson ; $7a6c
	call InitServeCoachScene ; $7a6e
	call ServeCoachWalkToCourtAndStartLesson ; $7a71
	ret ; $7a74
.netLesson:
	cp MINIGAME_STROKE_MATCH_1 ; $7a75
	jr nc, .returnLesson ; $7a77
	call InitNetCoachScene ; $7a79
	script_set_text Text_BethLetsDoItThen ; $7a7c
	script_speak ACTOR_TRAINING_COURT_BETH ; $7a82
	call NetCoachWalkToCourtAndStartLesson ; $7a87
	ret ; $7a8a
.returnLesson:
	cp MINIGAME_TENNIS_MACHINE_1 ; $7a8b
	jr nc, .done ; $7a8d
	call InitReturnCoachScene ; $7a8f
	call ReturnCoachWalkToCourtAndStartLesson ; $7a92
.done:
	ret ; $7a95
ServeCoachWalkToCourtAndStartLesson:
	script_null_script ACTOR_PARTNER ; $7a96
	script_player_speed 1.0 ; $7a9b
	script_wait_frames 20 ; $7aa1
	script_set_actor_script ACTOR_TRAINING_COURT_CURT, ActorScript_15_13 ; $7aa8
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_14 ; $7ab3
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_15 ; $7abe
	script_move_player 24.0, 15.0 ; $7ac9
	script_wait_actor_script ACTOR_PLAYER ; $7ad3
	farcall WaitPlayerMoveDone ; $7ad8
	script_wait_actor_script ACTOR_TRAINING_COURT_CURT ; $7adb
	script_wait_frames 5 ; $7ae0
	call PlayerPartnerGestureCutscene ; $7ae7
	ld a, STORYLOC_TRAINING_COURT ; $7aea
	ld [wStoryModeCurrentLocation], a ; $7aec
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $7aef
	ld [wStoryModeEntryPoint], a ; $7af1
	ld a, EXITTRIGGER_DIRECT ; $7af4
	ld [wUnusedExitTriggerIdMirror], a ; $7af6
	ld [wStoryModeExitTriggerRequest], a ; $7af9
	ld a, [wCurrentMatchIndex] ; $7afc
	farcall RunTrainingDrillByID ; $7aff
	ret ; $7b02
ActorScript_15_13:
	; $7b03, 23 bytes (actor_script)
	as_set_target 17.0, 21.0
	as_wait_move
	as_set_target 19.0, 15.0
	as_wait_move
	as_set_target 23.0, 7.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_14:
	; $7b1a, 11 bytes (actor_script)
	as_set_target 25.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_15:
	; $7b25, 11 bytes (actor_script)
	as_set_target 19.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
NetCoachWalkToCourtAndStartLesson:
	script_player_speed 1.0 ; $7b30
	script_null_script ACTOR_PARTNER ; $7b36
	script_set_actor_script ACTOR_TRAINING_COURT_BETH, ActorScript_15_16 ; $7b3b
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_17 ; $7b46
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_18 ; $7b51
	script_move_player 40.0, 38.0 ; $7b5c
	script_wait_actor_script ACTOR_PLAYER ; $7b66
	farcall WaitPlayerMoveDone ; $7b6b
	script_wait_actor_script ACTOR_TRAINING_COURT_BETH ; $7b6e
	script_wait_frames 5 ; $7b73
	call PlayerPartnerGestureCutscene ; $7b7a
	ld a, STORYLOC_TRAINING_COURT ; $7b7d
	ld [wStoryModeCurrentLocation], a ; $7b7f
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $7b82
	ld [wStoryModeEntryPoint], a ; $7b84
	ld a, EXITTRIGGER_DIRECT ; $7b87
	ld [wUnusedExitTriggerIdMirror], a ; $7b89
	ld [wStoryModeExitTriggerRequest], a ; $7b8c
	ld a, [wCurrentMatchIndex] ; $7b8f
	farcall RunTrainingDrillByID ; $7b92
	ret ; $7b95
