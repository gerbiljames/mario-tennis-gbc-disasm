VolleyMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BRIAN, ACTOR_PARTNER ; $688f
	script_set_text Text_6e_64 ; $6897
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $689d
	farcall RunDialogueYesNoPrompt ; $68a2
	farcall ScriptCloseDialogueWindow ; $68a5
	script_wait_frames 5 ; $68a8
	and a ; $68af
	jp nz, .done ; $68b0
	farcall AdvanceDialogueTextCursor ; $68b3
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $68b6
	farcall RunDialogueYesNoPrompt ; $68bb
	farcall ScriptCloseDialogueWindow ; $68be
	script_wait_frames 5 ; $68c1
	and a ; $68c8
	jp nz, .done ; $68c9
	farcall AdvanceDialogueTextCursor ; $68cc
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $68cf
	farcall RunDialogueYesNoPrompt ; $68d4
	farcall ScriptCloseDialogueWindow ; $68d7
	script_wait_frames 5 ; $68da
	and a ; $68e1
	jp z, .accepted ; $68e2
.prompt:
	script_set_text Text_6e_69 ; $68e5
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $68eb
	farcall RunDialogueYesNoPrompt ; $68f0
	farcall ScriptCloseDialogueWindow ; $68f3
	script_wait_frames 5 ; $68f6
	and a ; $68fd
	jr nz, .prompt ; $68fe
.accepted:
	script_set_text Text_6e_70 ; $6900
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6906
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $690d
	script_face ACTOR_TRAINING_COURT_BRIAN, FACE_LEFT ; $6912
	script_wait_frames 40 ; $6919
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BRIAN ; $6920
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6928
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $692d
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6934
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6939
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $693e
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6943
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $694a
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $694f
	call WalkToNetChallengeCourtCutscene ; $6954
	ld a, MINIGAME_NET_GAME_MATCH_1 ; $6957
	farcall RunTrainingDrillByID ; $6959
	ret ; $695c
.done:
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $695d
	ret ; $6962
SmashMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BRIAN, ACTOR_PARTNER ; $6963
	script_set_text Text_6e_85 ; $696b
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $6971
	farcall RunDialogueYesNoPrompt ; $6976
	farcall ScriptCloseDialogueWindow ; $6979
	script_wait_frames 5 ; $697c
	and a ; $6983
	jp nz, .speak ; $6984
	farcall AdvanceDialogueTextCursor ; $6987
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $698a
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $698f
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6996
	script_face ACTOR_TRAINING_COURT_BRIAN, FACE_LEFT ; $699b
	script_wait_frames 40 ; $69a2
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BRIAN ; $69a9
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $69b1
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $69b6
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $69bd
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $69c2
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_SHAKE ; $69c7
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $69ce
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $69d3
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_BOUNCE ; $69d8
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $69df
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $69e4
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $69e9
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $69f0
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $69f5
	farcall RunDialogueYesNoPrompt ; $69fa
	farcall ScriptCloseDialogueWindow ; $69fd
	script_wait_frames 5 ; $6a00
	and a ; $6a07
	jr nz, .speak ; $6a08
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6a0a
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6a11
	farcall AdvanceDialogueTextCursor ; $6a16
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a19
	call WalkToNetChallengeCourtCutscene ; $6a1e
	ld a, MINIGAME_NET_GAME_MATCH_2 ; $6a21
	farcall RunTrainingDrillByID ; $6a23
	ret ; $6a26
.speak:
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a27
	ret ; $6a2c
DropShotMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BRIAN, ACTOR_PARTNER ; $6a2d
	script_set_text Text_6e_98 ; $6a35
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $6a3b
	farcall RunDialogueYesNoPrompt ; $6a40
	farcall ScriptCloseDialogueWindow ; $6a43
	script_wait_frames 5 ; $6a46
	and a ; $6a4d
	jp nz, .speak ; $6a4e
	farcall AdvanceDialogueTextCursor ; $6a51
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a54
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6a59
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6a60
	script_face ACTOR_TRAINING_COURT_BRIAN, FACE_LEFT ; $6a65
	script_wait_frames 40 ; $6a6c
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BRIAN ; $6a73
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a7b
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6a80
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6a87
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a8c
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_SHAKE ; $6a91
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6a98
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6a9d
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_BOUNCE ; $6aa2
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6aa9
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6aae
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6ab3
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6aba
	script_speak_restore ACTOR_TRAINING_COURT_BRIAN ; $6abf
	farcall RunDialogueYesNoPrompt ; $6ac4
	farcall ScriptCloseDialogueWindow ; $6ac7
	script_wait_frames 5 ; $6aca
	and a ; $6ad1
	jr nz, .speak ; $6ad2
	farcall AdvanceDialogueTextCursor ; $6ad4
	script_set_anim ACTOR_TRAINING_COURT_BRIAN, ANIM_NOD ; $6ad7
	script_wait_idle ACTOR_TRAINING_COURT_BRIAN ; $6ade
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6ae3
	call WalkToNetChallengeCourtCutscene ; $6ae8
	ld a, MINIGAME_NET_GAME_MATCH_3 ; $6aeb
	farcall RunTrainingDrillByID ; $6aed
	ret ; $6af0
.speak:
	script_speak ACTOR_TRAINING_COURT_BRIAN ; $6af1
	ret ; $6af6
WalkToNetChallengeCourtCutscene:
	script_null_script ACTOR_PARTNER ; $6af7
	script_move_player 40.0, 39.0 ; $6afc
	script_set_actor_script ACTOR_TRAINING_COURT_BRIAN, ActorScript_15_07 ; $6b06
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_08 ; $6b11
	script_wait_frames 10 ; $6b1c
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_09 ; $6b23
	script_wait_actor_script ACTOR_PLAYER ; $6b2e
	call PlayerPartnerGestureCutscene ; $6b33
	ld a, STORYLOC_TRAINING_COURT ; $6b36
	ld [wStoryModeCurrentLocation], a ; $6b38
	ld a, $0a ; $6b3b
	ld [wStoryModeEntryPoint], a ; $6b3d
	ld a, $ff ; $6b40
	ld [wUnusedExitTriggerIdMirror], a ; $6b42
	ld [wStoryModeExitTriggerRequest], a ; $6b45
	ret ; $6b48
ActorScript_15_07:
	; $6b49, 11 bytes (actor_script)
	as_set_target 39.0, 31.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_08:
	; $6b54, 29 bytes (actor_script)
	as_set_target 45.0, 35.0
	as_wait_move
	as_set_target 47.0, 35.0
	as_wait_move
	as_set_target 47.0, 43.0
	as_wait_move
	as_set_target 41.0, 46.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_09:
	; $6b71, 29 bytes (actor_script)
	as_set_target 45.0, 35.0
	as_wait_move
	as_set_target 47.0, 35.0
	as_wait_move
	as_set_target 47.0, 45.0
	as_wait_move
	as_set_target 45.0, 45.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
SpeakStrokeChallengerDeclineLine:
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6b8e
	ret ; $6b93
StrokeMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_ALLIE, ACTOR_PARTNER ; $6b94
	script_set_text Text_6e_111 ; $6b9c
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6ba2
	farcall RunDialogueYesNoPrompt ; $6ba7
	farcall ScriptCloseDialogueWindow ; $6baa
	script_wait_frames 5 ; $6bad
	and a ; $6bb4
	jp nz, SpeakStrokeChallengerDeclineLine ; $6bb5
	farcall AdvanceDialogueTextCursor ; $6bb8
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6bbb
	farcall RunDialogueYesNoPrompt ; $6bc0
	farcall ScriptCloseDialogueWindow ; $6bc3
	script_wait_frames 5 ; $6bc6
	and a ; $6bcd
	jp nz, SpeakStrokeChallengerDeclineLine ; $6bce
	farcall AdvanceDialogueTextCursor ; $6bd1
	script_face ACTOR_TRAINING_COURT_ALLIE, FACE_RIGHT ; $6bd4
	script_wait_frames 40 ; $6bdb
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_ALLIE ; $6be2
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6bea
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6bef
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6bf6
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6bfb
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_BOUNCE ; $6c00
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6c07
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6c0c
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_SHAKE ; $6c11
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6c18
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6c1d
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6c22
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6c29
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6c2e
	call WalkToStrokeChallengeCourtCutscene ; $6c33
	ld a, MINIGAME_STROKE_MATCH_1 ; $6c36
	farcall RunTrainingDrillByID ; $6c38
	ret ; $6c3b
LobMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_ALLIE, ACTOR_PARTNER ; $6c3c
	script_set_text Text_6e_133 ; $6c44
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6c4a
	farcall RunDialogueYesNoPrompt ; $6c4f
	farcall ScriptCloseDialogueWindow ; $6c52
	script_wait_frames 5 ; $6c55
	and a ; $6c5c
	jp nz, SpeakStrokeChallengerDeclineLine ; $6c5d
	farcall AdvanceDialogueTextCursor ; $6c60
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6c63
	farcall RunDialogueYesNoPrompt ; $6c68
	farcall ScriptCloseDialogueWindow ; $6c6b
	script_wait_frames 5 ; $6c6e
	and a ; $6c75
	jp nz, SpeakStrokeChallengerDeclineLine ; $6c76
	farcall AdvanceDialogueTextCursor ; $6c79
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6c7c
	script_face ACTOR_TRAINING_COURT_ALLIE, FACE_RIGHT ; $6c81
	script_wait_frames 40 ; $6c88
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_ALLIE ; $6c8f
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6c97
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6c9e
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6ca3
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_BOUNCE ; $6ca8
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6caf
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6cb4
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_SHAKE ; $6cb9
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6cc0
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6cc5
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6cca
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6cd1
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6cd6
	call WalkToStrokeChallengeCourtCutscene ; $6cdb
	ld a, MINIGAME_STROKE_MATCH_2 ; $6cde
	farcall RunTrainingDrillByID ; $6ce0
	ret ; $6ce3
ReturnMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_ALLIE, ACTOR_PARTNER ; $6ce4
	script_set_text Text_6e_149 ; $6cec
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6cf2
	farcall RunDialogueYesNoPrompt ; $6cf7
	farcall ScriptCloseDialogueWindow ; $6cfa
	script_wait_frames 5 ; $6cfd
	and a ; $6d04
	jp nz, SpeakStrokeChallengerDeclineLine ; $6d05
	farcall AdvanceDialogueTextCursor ; $6d08
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d0b
	script_speak_restore ACTOR_TRAINING_COURT_ALLIE ; $6d10
	farcall RunDialogueYesNoPrompt ; $6d15
	farcall ScriptCloseDialogueWindow ; $6d18
	script_wait_frames 5 ; $6d1b
	and a ; $6d22
	jp nz, SpeakStrokeChallengerDeclineLine ; $6d23
	farcall AdvanceDialogueTextCursor ; $6d26
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6d29
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d30
	script_face ACTOR_TRAINING_COURT_ALLIE, FACE_RIGHT ; $6d35
	script_wait_frames 40 ; $6d3c
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_ALLIE ; $6d43
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d4b
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6d50
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d57
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d5c
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_BOUNCE ; $6d61
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d68
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d6d
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_SHAKE ; $6d72
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d79
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d7e
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_BOUNCE ; $6d83
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d8a
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6d8f
	script_set_anim ACTOR_TRAINING_COURT_ALLIE, ANIM_NOD ; $6d94
	script_wait_idle ACTOR_TRAINING_COURT_ALLIE ; $6d9b
	script_speak ACTOR_TRAINING_COURT_ALLIE ; $6da0
	call WalkToStrokeChallengeCourtCutscene ; $6da5
	ld a, MINIGAME_STROKE_MATCH_3 ; $6da8
	farcall RunTrainingDrillByID ; $6daa
	ret ; $6dad
.loop:
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6dae
	ret ; $6db3
ReturnCoachReturnLessonScene:
	script_set_text Text_37_196 ; $6db4
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6dba
	jr z, .face ; $6dbd
	farcall AdvanceDialogueTextCursor ; $6dbf
.face:
	script_face_toward ACTOR_TRAINING_COURT_BOB_2, ACTOR_PARTNER ; $6dc2
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6dca
	script_set_text Text_37_198 ; $6dcf
	farcall RunDialogueYesNoPrompt ; $6dd5
	farcall ScriptCloseDialogueWindow ; $6dd8
	script_wait_frames 5 ; $6ddb
	and a ; $6de2
	jp nz, ReturnMatchChallengeScene.loop ; $6de3
	farcall AdvanceDialogueTextCursor ; $6de6
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6de9
	farcall RunDialogueYesNoPrompt ; $6dee
	farcall ScriptCloseDialogueWindow ; $6df1
	script_wait_frames 5 ; $6df4
	and a ; $6dfb
	jp nz, ReturnMatchChallengeScene.loop ; $6dfc
	farcall AdvanceDialogueTextCursor ; $6dff
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6e02
	call MovePartyToReturnCoachSpot ; $6e07
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_RIGHT ; $6e0a
	script_set_text Text_37_202 ; $6e11
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6e17
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $6e1c
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $6e23
	ld a, MINIGAME_STROKE_PRACTICE_1 ; $6e28
	ld [wCurrentMinigameStoryMatch + 1], a ; $6e2a
	ld a, STORYLOC_TRAINING_COURT ; $6e2d
	ld [wStoryModeCurrentLocation], a ; $6e2f
	ld a, $09 ; $6e32
	ld [wStoryModeEntryPoint], a ; $6e34
	ld a, $ff ; $6e37
	ld [wUnusedExitTriggerIdMirror], a ; $6e39
	ld [wStoryModeExitTriggerRequest], a ; $6e3c
	ld c, 16 ; $6e3f
	call BeginFadeOut ; $6e41
	call WaitFadeEnd ; $6e44
	farcall ShowDrillBriefingScreen ; $6e47
	ret ; $6e4a
ReturnCoachLobLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_BOB_2, ACTOR_PARTNER ; $6e4b
	script_set_text Text_37_227 ; $6e53
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6e59
	farcall RunDialogueYesNoPrompt ; $6e5e
	farcall ScriptCloseDialogueWindow ; $6e61
	script_wait_frames 5 ; $6e64
	and a ; $6e6b
	jp nz, ReturnMatchChallengeScene.loop ; $6e6c
	farcall AdvanceDialogueTextCursor ; $6e6f
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6e72
	farcall RunDialogueYesNoPrompt ; $6e77
	farcall ScriptCloseDialogueWindow ; $6e7a
	script_wait_frames 5 ; $6e7d
	and a ; $6e84
	jp nz, ReturnMatchChallengeScene.loop ; $6e85
	farcall AdvanceDialogueTextCursor ; $6e88
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6e8b
	call MovePartyToReturnCoachSpot ; $6e90
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_RIGHT ; $6e93
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6e9a
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $6e9f
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $6ea6
	ld a, MINIGAME_STROKE_PRACTICE_2 ; $6eab
	ld [wCurrentMinigameStoryMatch + 1], a ; $6ead
	ld a, STORYLOC_TRAINING_COURT ; $6eb0
	ld [wStoryModeCurrentLocation], a ; $6eb2
	ld a, $09 ; $6eb5
	ld [wStoryModeEntryPoint], a ; $6eb7
	ld a, $ff ; $6eba
	ld [wUnusedExitTriggerIdMirror], a ; $6ebc
	ld [wStoryModeExitTriggerRequest], a ; $6ebf
	ld c, 16 ; $6ec2
	call BeginFadeOut ; $6ec4
	call WaitFadeEnd ; $6ec7
	farcall ShowDrillBriefingScreen ; $6eca
	ret ; $6ecd
ReturnCoachPassingShotLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_BOB_2, ACTOR_PARTNER ; $6ece
	script_set_text Text_37_249 ; $6ed6
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6edc
	farcall RunDialogueYesNoPrompt ; $6ee1
	farcall ScriptCloseDialogueWindow ; $6ee4
	script_wait_frames 5 ; $6ee7
	and a ; $6eee
	jp nz, ReturnMatchChallengeScene.loop ; $6eef
	farcall AdvanceDialogueTextCursor ; $6ef2
	script_speak_restore ACTOR_TRAINING_COURT_BOB_2 ; $6ef5
	farcall RunDialogueYesNoPrompt ; $6efa
	farcall ScriptCloseDialogueWindow ; $6efd
	script_wait_frames 5 ; $6f00
	and a ; $6f07
	jp nz, ReturnMatchChallengeScene.loop ; $6f08
	farcall AdvanceDialogueTextCursor ; $6f0b
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6f0e
	call MovePartyToReturnCoachSpot ; $6f13
	script_face ACTOR_TRAINING_COURT_BOB_2, FACE_RIGHT ; $6f16
	script_speak ACTOR_TRAINING_COURT_BOB_2 ; $6f1d
	script_set_anim ACTOR_TRAINING_COURT_BOB_2, ANIM_BOUNCE ; $6f22
	script_wait_idle ACTOR_TRAINING_COURT_BOB_2 ; $6f29
	ld a, MINIGAME_STROKE_PRACTICE_3 ; $6f2e
	ld [wCurrentMinigameStoryMatch + 1], a ; $6f30
	ld a, STORYLOC_TRAINING_COURT ; $6f33
	ld [wStoryModeCurrentLocation], a ; $6f35
	ld a, $09 ; $6f38
	ld [wStoryModeEntryPoint], a ; $6f3a
	ld a, $ff ; $6f3d
	ld [wUnusedExitTriggerIdMirror], a ; $6f3f
	ld [wStoryModeExitTriggerRequest], a ; $6f42
	ld c, 16 ; $6f45
	call BeginFadeOut ; $6f47
	call WaitFadeEnd ; $6f4a
	farcall ShowDrillBriefingScreen ; $6f4d
	ret ; $6f50
