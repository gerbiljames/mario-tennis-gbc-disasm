LateStudentCrashCutscene:
	script_set_speed ACTOR_PLAYER, $0010 ; $46cf
	xor a ; $46d7
	ld [wStoryModeShowLocationName], a ; $46d8
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 13.0 ; $46db
	script_set_position ACTOR_PLAYER, 24.0, 55.0 ; $46e6
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2, 63.0, 63.0 ; $46f1
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1, 34.5, 21.0 ; $46fc
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1, FACE_RIGHT ; $4707
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_71_05, 51.0, 21.0 ; $470e
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_72_02, 51.0, 21.0 ; $4719
	script_fade_in $04 ; $4724
	call WaitFadeEnd ; $4729
	script_move_target ACTOR_PLAYER, 24.0, 45.0 ; $472c
	script_wait_move ACTOR_PLAYER ; $4737
	script_face ACTOR_PLAYER, FACE_RIGHT ; $473c
	script_wait_frames $28 ; $4743
	script_face ACTOR_PLAYER, FACE_UP ; $474a
	script_wait_frames $28 ; $4751
	script_face ACTOR_PLAYER, FACE_LEFT ; $4758
	script_wait_frames $28 ; $475f
	script_face ACTOR_PLAYER, FACE_UP ; $4766
	script_wait_frames $28 ; $476d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4774
	script_wait_frames $0a ; $477b
	script_face ACTOR_PLAYER, FACE_DOWN ; $4782
	script_wait_frames $3c ; $4789
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4790
	script_wait_idle ACTOR_PLAYER ; $4797
	script_wait_frames $3c ; $479c
	script_move_target ACTOR_PLAYER, 24.0, 33.0 ; $47a3
	script_player_speed $0040 ; $47ae
	script_move_player 24.0, 18.0 ; $47b4
	farcall WaitPlayerMoveDone ; $47be
	script_wait_frames $3c ; $47c1
	script_set_position ACTOR_PLAYER, 24.0, 32.0 ; $47c8
	script_face ACTOR_PLAYER, FACE_UP ; $47d3
	script_set_speed ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $0024 ; $47da
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 20.0 ; $47e2
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $47ed
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_SHAKE ; $47f2
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $47f9
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_75_06, FACE_UP ; $47fe
	script_set_text Text_36_79 ; $4805
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $480b
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_NOD ; $4810
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4817
	script_set_speed ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $0020 ; $481c
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4824
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_75_06, FACE_DOWN ; $4829
	script_jump_velocity ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $ff80 ; $4830
	ld a, $11 ; $4838
	farcall ScriptWaitActorJumpDone ; $483a
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 23.0 ; $483d
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4848
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 25.5, 21.75 ; $484d
	sound SFX_EMOTE ; $4858
	script_set_speed ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $0010 ; $485a
	script_set_speed ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, $0010 ; $4862
	script_move_target ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 25.5, 24.75 ; $486a
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 26.0 ; $4875
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4880
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4885
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 63.0, 63.0 ; $488a
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 22.0 ; $4895
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $48a0
	script_wait_frames $1e ; $48a5
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $48ac
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 25.5, 20.75 ; $48b3
	sound SFX_CHIME ; $48be
	script_wait_frames $14 ; $48c0
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $48c7
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 63.0, 63.0 ; $48cc
	script_set_speed ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $0020 ; $48d7
	script_jump_velocity ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $ff80 ; $48df
	ld a, $11 ; $48e7
	farcall ScriptWaitActorJumpDone ; $48e9
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 32.0 ; $48ec
	script_wait_frames $1e ; $48f7
	ld bc, wActors + 1 * ACTOR_SIZE ; $48fe
	script_get_actor_state ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4901
	ld e, l ; $4906
	ld d, h ; $4907
	farcall AttachActorWaypointFollower ; $4908
	script_move_target ACTOR_PLAYER, 24.0, 30.0 ; $490b
	script_wait_frames $14 ; $4916
	call LateStudentCrashImpact ; $491d
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4920
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4925
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_SWEAT, 25.0, 30.0 ; $492c
	sound SFX_APPEAR2 ; $4937
	script_wait_frames $3c ; $4939
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_SWEAT, 63.0, 63.0 ; $4940
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 23.0, 34.0 ; $494b
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4956
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $495b
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4963
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 36.0 ; $4968
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4973
	script_null_script ACTOR_PLAYER_SHADOW ; $4978
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $497d
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4985
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $498c
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4991
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_ELLIPSIS, 26.5, 34.5 ; $4996
	script_wait_frames $3c ; $49a1
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_ELLIPSIS, 63.0, 63.0 ; $49a8
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 35.0 ; $49b3
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $49be
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 26.0, 35.0 ; $49c3
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $49ce
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 26.0, 36.0 ; $49d3
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $49de
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 36.0 ; $49e3
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $49ee
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 37.0 ; $49f3
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $49fe
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 26.0, 37.0 ; $4a03
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a0e
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 26.0, 36.0 ; $4a13
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a1e
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 36.0 ; $4a23
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a2e
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a33
	script_wait_frames $3c ; $4a3b
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4a42
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a49
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a4e
	call KnockPlayerAirborneFlipped_11 ; $4a53
	script_lock_facing ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4a56
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_HOP ; $4a5d
	script_wait_frames $14 ; $4a64
	script_jump_velocity ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $ff80 ; $4a6b
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 27.0, 36.0 ; $4a73
	script_wait_frames $14 ; $4a7e
	script_face_toward ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ACTOR_PLAYER ; $4a85
	script_wait_frames $14 ; $4a8d
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4a94
	script_wait_idle ACTOR_PLAYER ; $4a9b
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4aa0
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4aa7
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4aac
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 26.0, 36.0 ; $4ab4
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4abf
	script_unlock_facing ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4ac4
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4acb
	script_wait_idle ACTOR_PLAYER ; $4ad2
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4ad7
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4ade
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4ae3
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4ae8
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4aef
.loop:
	script_set_text Text_36_87 ; $4af4
	ld a, $11 ; $4afa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4afc
	farcall RunDialogueYesNoPrompt ; $4aff
	farcall ScriptCloseDialogueWindow ; $4b02
	script_wait_frames $05 ; $4b05
	and a ; $4b0c
	jr z, .setText ; $4b0d
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4b0f
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4b16
	jr .loop ; $4b1b
.setText:
	script_set_text Text_36_89 ; $4b1d
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_NOD ; $4b23
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4b2a
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4b2f
	script_wait_frames $3c ; $4b34
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 27.5, 33.75 ; $4b3b
	sound SFX_EMOTE ; $4b46
	script_wait_frames $28 ; $4b48
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 63.0, 63.0 ; $4b4f
	script_move_angle ACTOR_ACADEMY_ARRIVAL_WALK_75_06, FACE_LEFT, $0100 ; $4b5a
	script_wait_move ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4b64
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4b69
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4b6e
	script_wait_idle ACTOR_PLAYER ; $4b75
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 26.5, 33.75 ; $4b7a
	script_wait_frames $3c ; $4b85
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 63.0, 63.0 ; $4b8c
	script_wait_frames $3c ; $4b97
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 26.5, 33.75 ; $4b9e
	sound SFX_CHIME ; $4ba9
	script_jump_velocity ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $ff80 ; $4bab
	ld a, $11 ; $4bb3
	farcall ScriptWaitActorJumpDone ; $4bb5
	script_wait_frames $0a ; $4bb8
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 63.0, 63.0 ; $4bbf
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4bca
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4bcf
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4bd6
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4bdb
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4be0
	script_wait_idle ACTOR_PLAYER ; $4be7
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_NOD ; $4bec
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4bf3
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4bf8
	script_wait_frames $0a ; $4bfd
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4c04
	script_wait_idle ACTOR_PLAYER ; $4c0b
	script_wait_frames $3c ; $4c10
	script_player_speed $0060 ; $4c17
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_75_06, FACE_UP ; $4c1d
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4c24
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4c2b
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 26.5, 33.75 ; $4c30
	sound SFX_CHIME ; $4c3b
	script_wait_frames $28 ; $4c3d
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 63.0, 63.0 ; $4c44
	script_face ACTOR_ACADEMY_ARRIVAL_WALK_75_06, FACE_UP ; $4c4f
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_BOUNCE ; $4c56
	script_move_player 24.0, 11.0 ; $4c5d
	farcall WaitPlayerMoveDone ; $4c67
	script_set_active ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $00 ; $4c6a
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 6.0 ; $4c71
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4c7c
	script_set_position ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 25.0, 36.0 ; $4c81
	script_set_active ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $02 ; $4c8c
	script_move_player 24.0, 36.0 ; $4c93
	farcall WaitPlayerMoveDone ; $4c9d
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4ca0
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4ca8
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_75_06, ANIM_NOD ; $4cad
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_75_06 ; $4cb4
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4cb9
	script_wait_idle ACTOR_PLAYER ; $4cc0
	script_jump_velocity ACTOR_ACADEMY_ARRIVAL_WALK_75_06, $ff80 ; $4cc5
	ld a, $11 ; $4ccd
	farcall ScriptWaitActorJumpDone ; $4ccf
	script_move_target ACTOR_ACADEMY_ARRIVAL_WALK_75_06, 24.0, 51.0 ; $4cd2
	script_wait_frames $14 ; $4cdd
	script_face ACTOR_PLAYER, FACE_DOWN ; $4ce4
	script_wait_frames $5a ; $4ceb
	call AcademyArrivalGreetingScene ; $4cf2
	ret ; $4cf5
LateStudentCrashImpact:
	script_null_script ACTOR_PLAYER_SHADOW ; $4cf6
	sound SFX_IMPACT ; $4cfb
	ld a, $03 ; $4cfd
	farcall SetScreenShake ; $4cff
	script_wait_frames $0a ; $4d02
	ld a, $00 ; $4d09
	farcall SetScreenShake ; $4d0b
	script_set_speed ACTOR_PLAYER, $0040 ; $4d0e
	script_move_player 24.0, 36.0 ; $4d16
	script_move_target ACTOR_PLAYER, 23.0, 36.0 ; $4d20
	script_jump_velocity ACTOR_PLAYER, $ff00 ; $4d2b
	script_get_actor_state ACTOR_PLAYER ; $4d33
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, ACTORF_OAM_ATTR ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or $40 ; $4d3f
	ld [hl], a ; $4d41
	script_wait_frames $1e ; $4d42
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4d49
	script_wait_idle ACTOR_PLAYER ; $4d50
	script_wait_frames $1e ; $4d55
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_02 ; $4d5c
	ret ; $4d67
KnockPlayerAirborneFlipped_11:
	script_null_script ACTOR_PLAYER ; $4d68
	script_set_speed ACTOR_PLAYER, $0010 ; $4d6d
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4d75
	script_get_actor_state ACTOR_PLAYER ; $4d7d
	ld c, l ; $4d82
	ld b, h ; $4d83
	ld hl, ACTORF_OAM_ATTR ; $4d84
	add hl, bc ; $4d87
	ld a, [hl] ; $4d88
	xor $40 ; $4d89
	ld [hl], a ; $4d8b
	ret ; $4d8c
ActorScript_11_02:
	; $4d8d, 7 bytes (actor_script)
	as_anim ANIM_BOUNCE
	as_wait $50
	as_jump ActorScript_11_02
AcademyArrivalGreetingScene:
	script_player_speed $0010 ; $4d94
	script_set_speed ACTOR_PLAYER, $0018 ; $4d9a
	script_set_speed ACTOR_ACADEMY_ARRIVAL_EMILY, $0018 ; $4da2
	script_move_player 24.0, 19.0 ; $4daa
	script_move_target ACTOR_PLAYER, 24.0, 36.0 ; $4db4
	script_wait_move ACTOR_PLAYER ; $4dbf
	script_move_target ACTOR_PLAYER, 24.0, 19.0 ; $4dc4
	script_set_text Text_30_419 ; $4dcf
	script_wait_frames $78 ; $4dd5
	script_set_position ACTOR_ACADEMY_ARRIVAL_EMILY, 24.0, 15.0 ; $4ddc
	script_wait_move ACTOR_PLAYER ; $4de7
	ld a, [wStoryModeGenderOfMainCharacter] ; $4dec
	or a ; $4def
	jr z, .doubles ; $4df0
	farcall AdvanceDialogueTextCursor ; $4df2
.doubles:
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4df5
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 25.25, 17.75 ; $4dfa
	sound SFX_CHIME ; $4e05
	script_wait_frames $28 ; $4e07
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_EXCLAIM, 63.0, 63.0 ; $4e0e
	script_face_toward ACTOR_ACADEMY_ARRIVAL_EMILY, ACTOR_PLAYER ; $4e19
	script_player_speed $0020 ; $4e21
	script_move_target ACTOR_ACADEMY_ARRIVAL_EMILY, 24.0, 17.0 ; $4e27
	script_wait_frames $0f ; $4e32
	script_move_player 24.0, 17.0 ; $4e39
	farcall WaitPlayerMoveDone ; $4e43
	script_wait_frames $3c ; $4e46
	script_face_pair ACTOR_PLAYER, ACTOR_ACADEMY_ARRIVAL_EMILY ; $4e4d
	script_wait_frames $1e ; $4e55
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4e5c
	script_wait_idle ACTOR_PLAYER ; $4e63
	script_wait_frames $0f ; $4e68
	script_set_anim ACTOR_ACADEMY_ARRIVAL_EMILY, ANIM_NOD ; $4e6f
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_EMILY ; $4e76
	script_set_text Text_30_421 ; $4e7b
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1 ; $4e81
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 25.25, 17.75 ; $4e86
	sound SFX_EMOTE ; $4e91
	script_wait_frames $32 ; $4e93
	script_set_position ACTOR_ACADEMY_ARRIVAL_BALLOON_QUESTION, 63.0, 63.0 ; $4e9a
	script_set_anim ACTOR_ACADEMY_ARRIVAL_EMILY, ANIM_NOD ; $4ea5
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_EMILY ; $4eac
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4eb1
	script_wait_frames $0f ; $4eb6
	script_set_anim ACTOR_ACADEMY_ARRIVAL_EMILY, ANIM_BOUNCE ; $4ebd
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_EMILY ; $4ec4
	ld a, $12 ; $4ec9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4ecb
	farcall RunDialogueYesNoPrompt ; $4ece
	farcall ScriptCloseDialogueWindow ; $4ed1
	script_wait_frames $05 ; $4ed4
	and a ; $4edb
	jr z, .finish ; $4edc
	farcall AdvanceDialogueTextCursor ; $4ede
.finish:
	ld a, $12 ; $4ee1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4ee3
	farcall RunDialogueYesNoPrompt ; $4ee6
	farcall ScriptCloseDialogueWindow ; $4ee9
	script_wait_frames $05 ; $4eec
	and a ; $4ef3
	jr z, .done ; $4ef4
	xor a ; $4ef6
	ld [wStoryModeShowLocationName], a ; $4ef7
	script_set_text Text_30_427 ; $4efa
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f00
	set_flag FLAG_STORY_MENU_LOCKED ; $4f05
	call ArmAcademyEntranceTileTrigger ; $4f08
	ret ; $4f0b
.done:
	script_set_text Text_30_426 ; $4f0c
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f12
	call FollowGuideIntoAcademy ; $4f17
	ret ; $4f1a
ArmAcademyEntranceTileTrigger:
	ld a, $f1 ; $4f1b
	ld d, $16 ; $4f1d
	ld e, $10 ; $4f1f
	farcall WriteBehaviorMapCell ; $4f21
	ld a, $f1 ; $4f24
	ld d, $18 ; $4f26
	ld e, $10 ; $4f28
	farcall WriteBehaviorMapCell ; $4f2a
	ld a, $f1 ; $4f2d
	ld d, $16 ; $4f2f
	ld e, $12 ; $4f31
	farcall WriteBehaviorMapCell ; $4f33
	ld a, $f1 ; $4f36
	ld d, $18 ; $4f38
	ld e, $12 ; $4f3a
	farcall WriteBehaviorMapCell ; $4f3c
	ret ; $4f3f
ResumeAcademyGuideTour:
	script_set_anim ACTOR_ACADEMY_ARRIVAL_EMILY, ANIM_BOUNCE ; $4f40
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f47
	script_move_target ACTOR_PLAYER, 24.0, 19.0 ; $4f4c
	script_wait_move ACTOR_PLAYER ; $4f57
	script_face_toward ACTOR_ACADEMY_ARRIVAL_EMILY, ACTOR_PLAYER ; $4f5c
	script_set_anim ACTOR_ACADEMY_ARRIVAL_EMILY, ANIM_NOD ; $4f64
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f6b
	script_set_text Text_30_428 ; $4f70
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f76
	script_speak ACTOR_ACADEMY_ARRIVAL_EMILY ; $4f7b
	call FollowGuideIntoAcademy ; $4f80
	ret ; $4f83
FollowGuideIntoAcademy:
	script_set_speed ACTOR_PLAYER, $0018 ; $4f84
	script_set_speed ACTOR_ACADEMY_ARRIVAL_EMILY, $0018 ; $4f8c
	clear_flag FLAG_STORY_MENU_LOCKED ; $4f94
	script_move_target ACTOR_ACADEMY_ARRIVAL_EMILY, 24.0, 14.0 ; $4f97
	script_move_target ACTOR_PLAYER, 24.0, 14.0 ; $4fa2
	script_wait_frames $1e ; $4fad
	ld a, $0f ; $4fb4
	ld [wUnusedExitTriggerIdMirror], a ; $4fb6
	ld [wStoryModeExitTriggerRequest], a ; $4fb9
	ld c, $04 ; $4fbc
	call BeginFadeOut ; $4fbe
	call WaitFadeEnd ; $4fc1
	ret ; $4fc4
AcademyArrivalInitScriptActorListEnd_11:
	; $4fc5, 10 bytes (bytes:10)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x00
.scriptRespawnLocationActors:
	ldh a, [hRomBank] ; $4fcf
	ld hl, ActorList_11_0 ; $4fd1
	farcall ScriptRespawnLocationActors ; $4fd4
	farcall BeginCutsceneScriptMode ; $4fd7
	test_flag FLAG_DOUBLES ; $4fda
	jp z, .notDoubles ; $4fdd
	script_null_script ACTOR_PARTNER ; $4fe0
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $4fe5
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4ff0
	ld d, OBJ_HARRY_B ; $4ff3
	add d ; $4ff5
	ld d, a ; $4ff6
	script_get_actor_state ACTOR_LIST_11_0_WALK_74_07 ; $4ff7
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	farcall LoadActorObjectDefIfValid ; $4ffe
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_WALK ; $5001
	script_set_position ACTOR_LIST_11_0_MARK, 26.0, 17.0 ; $5008
	script_face ACTOR_LIST_11_0_MARK, FACE_DOWN ; $5013
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter] ; $501a
	ld d, OBJ_ALEX_B ; $501d
	add d ; $501f
	ld d, a ; $5020
	script_get_actor_state ACTOR_PLAYER ; $5021
	ld c, l ; $5026
	ld b, h ; $5027
	farcall LoadActorObjectDefIfValid ; $5028
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $502b
	script_set_position ACTOR_PLAYER, 23.0, 23.0 ; $5032
	script_face ACTOR_PLAYER, FACE_UP ; $503d
	script_move_player_to_actor ACTOR_LIST_11_0_WALK_75_06 ; $5044
	farcall WaitPlayerMoveDone ; $504b
	script_fade_in $08 ; $504e
	call WaitFadeEnd ; $5053
	script_wait_frames $3c ; $5056
	script_set_text Text_30_493 ; $505d
	script_speak ACTOR_LIST_11_0_WALK_75_06 ; $5063
	test_flag FLAG_DOUBLES ; $5068
	jp z, .animate ; $506b
	script_set_anim ACTOR_LIST_11_0_WALK_74_08, ANIM_NOD ; $506e
	script_set_anim ACTOR_LIST_11_0_WALK_74_06, ANIM_NOD ; $5075
	script_wait_idle ACTOR_LIST_11_0_WALK_74_06 ; $507c
	script_wait_frames $1e ; $5081
	script_face_pair ACTOR_LIST_11_0_WALK_74_07, ACTOR_PLAYER ; $5088
	script_wait_frames $1e ; $5090
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5097
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_NOD ; $509e
	script_wait_idle ACTOR_LIST_11_0_WALK_74_07 ; $50a5
	script_wait_frames $1e ; $50aa
	script_face ACTOR_LIST_11_0_WALK_74_07, FACE_UP ; $50b1
	script_wait_frames $1e ; $50b8
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $50bf
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_NOD ; $50c6
	script_wait_idle ACTOR_LIST_11_0_WALK_74_07 ; $50cd
	script_wait_frames $1e ; $50d2
	script_set_anim ACTOR_LIST_11_0_WALK_75_06, ANIM_NOD ; $50d9
	script_wait_idle ACTOR_LIST_11_0_WALK_75_06 ; $50e0
	script_wait_frames $0a ; $50e5
	script_set_anim ACTOR_LIST_11_0_MARK, ANIM_BOUNCE ; $50ec
	script_wait_idle ACTOR_LIST_11_0_MARK ; $50f3
	script_speak ACTOR_LIST_11_0_MARK ; $50f8
	script_set_anim ACTOR_LIST_11_0_WALK_74_08, ANIM_NOD ; $50fd
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_NOD ; $5104
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $510b
	script_set_anim ACTOR_LIST_11_0_WALK_74_06, ANIM_NOD ; $5112
	script_wait_idle ACTOR_LIST_11_0_WALK_74_06 ; $5119
	script_wait_frames $1e ; $511e
	script_face_pair ACTOR_LIST_11_0_MARK, ACTOR_LIST_11_0_WALK_75_06 ; $5125
	script_set_anim ACTOR_LIST_11_0_WALK_75_06, ANIM_NOD ; $512d
	script_set_anim ACTOR_LIST_11_0_MARK, ANIM_NOD ; $5134
	script_wait_idle ACTOR_LIST_11_0_MARK ; $513b
	script_face ACTOR_LIST_11_0_MARK, FACE_DOWN ; $5140
	script_face ACTOR_LIST_11_0_WALK_75_06, FACE_DOWN ; $5147
	script_wait_frames $1e ; $514e
	jp .speak ; $5155
.animate:
	script_set_anim ACTOR_LIST_11_0_WALK_74_08, ANIM_NOD ; $5158
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_NOD ; $515f
	script_wait_idle ACTOR_LIST_11_0_WALK_74_07 ; $5166
	script_wait_frames $1e ; $516b
	script_face_pair ACTOR_LIST_11_0_WALK_74_06, ACTOR_PLAYER ; $5172
	script_wait_frames $1e ; $517a
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5181
	script_set_anim ACTOR_LIST_11_0_WALK_74_06, ANIM_NOD ; $5188
	script_wait_idle ACTOR_LIST_11_0_WALK_74_06 ; $518f
	script_wait_frames $1e ; $5194
	script_face ACTOR_PLAYER, FACE_UP ; $519b
	script_face ACTOR_LIST_11_0_WALK_74_06, FACE_UP ; $51a2
	script_wait_frames $1e ; $51a9
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $51b0
	script_set_anim ACTOR_LIST_11_0_WALK_74_06, ANIM_NOD ; $51b7
	script_wait_idle ACTOR_LIST_11_0_WALK_74_06 ; $51be
	script_wait_frames $1e ; $51c3
	script_set_anim ACTOR_LIST_11_0_WALK_75_06, ANIM_NOD ; $51ca
	script_wait_idle ACTOR_LIST_11_0_WALK_75_06 ; $51d1
	farcall AdvanceDialogueTextCursor ; $51d6
.speak:
	script_speak ACTOR_LIST_11_0_WALK_75_06 ; $51d9
	script_wait_frames $1e ; $51de
	script_set_anim ACTOR_LIST_11_0_WALK_74_08, ANIM_NOD ; $51e5
	script_set_anim ACTOR_LIST_11_0_WALK_74_07, ANIM_NOD ; $51ec
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $51f3
	script_set_anim ACTOR_LIST_11_0_WALK_74_06, ANIM_NOD ; $51fa
	script_wait_idle ACTOR_LIST_11_0_WALK_74_06 ; $5201
	script_wait_frames $14 ; $5206
	script_face_pair ACTOR_LIST_11_0_WALK_74_06, ACTOR_PLAYER ; $520d
	script_face_pair ACTOR_LIST_11_0_WALK_74_08, ACTOR_LIST_11_0_WALK_74_07 ; $5215
	script_wait_frames $0a ; $521d
	script_lock_facing ACTOR_PLAYER ; $5224
	script_lock_facing ACTOR_LIST_11_0_WALK_74_06 ; $522b
	script_lock_facing ACTOR_LIST_11_0_WALK_74_07 ; $5232
	script_lock_facing ACTOR_LIST_11_0_WALK_74_08 ; $5239
	script_move_target ACTOR_PLAYER, 22.0, 23.0 ; $5240
	script_move_target ACTOR_LIST_11_0_WALK_74_06, 26.0, 23.0 ; $524b
	script_move_target ACTOR_LIST_11_0_WALK_74_07, 21.0, 21.0 ; $5256
	script_move_target ACTOR_LIST_11_0_WALK_74_08, 27.0, 21.0 ; $5261
	script_wait_move ACTOR_LIST_11_0_WALK_74_08 ; $526c
	script_move_player 24.0, 47.0 ; $5271
	script_move_target ACTOR_LIST_11_0_WALK_75_06, 24.0, 25.0 ; $527b
	script_wait_move ACTOR_LIST_11_0_WALK_75_06 ; $5286
	script_unlock_facing ACTOR_PLAYER ; $528b
	script_unlock_facing ACTOR_LIST_11_0_WALK_74_06 ; $5292
	script_unlock_facing ACTOR_LIST_11_0_WALK_74_07 ; $5299
	script_unlock_facing ACTOR_LIST_11_0_WALK_74_08 ; $52a0
	script_move_target ACTOR_PLAYER, 22.0, 43.0 ; $52a7
	script_move_target ACTOR_LIST_11_0_WALK_74_06, 26.0, 43.0 ; $52b2
	script_move_target ACTOR_LIST_11_0_WALK_74_07, 21.0, 41.0 ; $52bd
	script_move_target ACTOR_LIST_11_0_WALK_74_08, 27.0, 41.0 ; $52c8
	script_move_target ACTOR_LIST_11_0_WALK_75_06, 24.0, 45.0 ; $52d3
	script_wait_move ACTOR_LIST_11_0_WALK_75_06 ; $52de
	script_set_anim ACTOR_LIST_11_0_WALK_71_03, ANIM_NOD ; $52e3
	script_move_target ACTOR_PLAYER, 23.0, 47.0 ; $52ea
	script_move_target ACTOR_LIST_11_0_WALK_74_06, 25.0, 47.0 ; $52f5
	script_move_target ACTOR_LIST_11_0_WALK_74_07, 23.0, 45.0 ; $5300
	script_move_target ACTOR_LIST_11_0_WALK_74_08, 25.0, 45.0 ; $530b
	script_move_target ACTOR_LIST_11_0_WALK_75_06, 24.0, 49.0 ; $5316
	script_wait_move ACTOR_LIST_11_0_WALK_75_06 ; $5321
	script_move_target ACTOR_PLAYER, 23.0, 59.0 ; $5326
	script_move_target ACTOR_LIST_11_0_WALK_74_06, 25.0, 59.0 ; $5331
	script_move_target ACTOR_LIST_11_0_WALK_74_07, 23.0, 57.0 ; $533c
	script_move_target ACTOR_LIST_11_0_WALK_74_08, 25.0, 57.0 ; $5347
	script_move_target ACTOR_LIST_11_0_WALK_75_06, 24.0, 61.0 ; $5352
	script_wait_move ACTOR_LIST_11_0_WALK_75_06 ; $535d
	ld c, $04 ; $5362
	call BeginFadeOut ; $5364
	call WaitFadeEnd ; $5367
	ld a, STORYLOC_ISLAND_SKY ; $536a
	ld [wStoryModeCurrentLocation], a ; $536c
	ld a, $01 ; $536f
	ld [wStoryModeEntryPoint], a ; $5371
	ld a, $ff ; $5374
	ld [wUnusedExitTriggerIdMirror], a ; $5376
	ld [wStoryModeExitTriggerRequest], a ; $5379
	ret ; $537c
