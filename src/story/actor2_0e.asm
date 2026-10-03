ExhibitionAcceptedSingles:
	script_wait_frames 10 ; $5938
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $593f
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $5946
	script_wait_frames 10 ; $594b
	script_set_text Text_5e_99 ; $5952
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $5958
	script_speak ACTOR_MARIO_WORLD_PEACH ; $595d
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_UP ; $5962
	script_wait_frames 4 ; $5969
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $5970
	script_wait_frames 4 ; $5977
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $597e
	script_wait_frames 4 ; $5985
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_UP ; $598c
	script_wait_frames 4 ; $5993
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_UP ; $599a
	script_wait_frames 4 ; $59a1
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $59a8
	script_wait_frames 10 ; $59af
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $59b6
	script_set_anim ACTOR_MARIO_WORLD_WARIO, ANIM_NOD ; $59bd
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_NOD ; $59c4
	script_set_anim ACTOR_MARIO_WORLD_WALK_77_05, ANIM_NOD ; $59cb
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $59d2
	script_set_anim ACTOR_MARIO_WORLD_LUIGI, ANIM_NOD ; $59d9
	script_set_anim ACTOR_MARIO_WORLD_BABY_MARIO, ANIM_NOD ; $59e0
	script_set_anim ACTOR_MARIO_WORLD_YOSHI, ANIM_NOD ; $59e7
	script_set_anim ACTOR_MARIO_WORLD_DK, ANIM_NOD ; $59ee
	script_set_anim ACTOR_MARIO_WORLD_TOAD, ANIM_NOD ; $59f5
	script_wait_idle ACTOR_MARIO_WORLD_TOAD ; $59fc
	script_player_speed $0010 ; $5a01
	script_move_player 21.0, 13.0 ; $5a07
	script_set_speed ACTOR_MARIO_WORLD_PEACH, $0014 ; $5a11
	script_set_speed ACTOR_MARIO_WORLD_BOWSER, $0014 ; $5a19
	script_set_speed ACTOR_MARIO_WORLD_WARIO, $0014 ; $5a21
	script_set_speed ACTOR_MARIO_WORLD_WALUIGI, $0014 ; $5a29
	script_set_speed ACTOR_MARIO_WORLD_WALK_77_05, $0014 ; $5a31
	script_set_speed ACTOR_MARIO_WORLD_MARIO, $0014 ; $5a39
	script_set_speed ACTOR_MARIO_WORLD_LUIGI, $0014 ; $5a41
	script_set_speed ACTOR_MARIO_WORLD_BABY_MARIO, $0014 ; $5a49
	script_set_speed ACTOR_MARIO_WORLD_YOSHI, $0014 ; $5a51
	script_set_speed ACTOR_MARIO_WORLD_BOO, $0014 ; $5a59
	script_set_speed ACTOR_MARIO_WORLD_DK, $0014 ; $5a61
	script_set_speed ACTOR_MARIO_WORLD_TOAD, $0014 ; $5a69
	script_set_speed ACTOR_PLAYER, $0014 ; $5a71
	script_set_actor_script ACTOR_MARIO_WORLD_WALK_77_05, ActorScript_0e_06 ; $5a79
	script_wait_frames 20 ; $5a84
	script_set_actor_script ACTOR_MARIO_WORLD_PEACH, ActorScript_0e_06 ; $5a8b
	script_wait_frames 20 ; $5a96
	script_set_actor_script ACTOR_MARIO_WORLD_MARIO, ActorScript_0e_06 ; $5a9d
	script_wait_frames 100 ; $5aa8
	script_set_actor_script ACTOR_MARIO_WORLD_LUIGI, ActorScript_0e_06 ; $5aaf
	script_set_actor_script ACTOR_MARIO_WORLD_BABY_MARIO, ActorScript_0e_06 ; $5aba
	script_set_actor_script ACTOR_MARIO_WORLD_YOSHI, ActorScript_0e_06 ; $5ac5
	script_set_actor_script ACTOR_MARIO_WORLD_DK, ActorScript_0e_06 ; $5ad0
	script_set_actor_script ACTOR_MARIO_WORLD_BOO, ActorScript_0e_06 ; $5adb
	script_wait_frames 60 ; $5ae6
	script_set_actor_script ACTOR_MARIO_WORLD_BOWSER, ActorScript_0e_06 ; $5aed
	script_set_actor_script ACTOR_MARIO_WORLD_WARIO, ActorScript_0e_06 ; $5af8
	script_wait_frames 40 ; $5b03
	script_set_actor_script ACTOR_MARIO_WORLD_WALUIGI, ActorScript_0e_06 ; $5b0a
	script_wait_actor_script ACTOR_MARIO_WORLD_WALUIGI ; $5b15
	script_move_player 18.0, 13.0 ; $5b1a
	script_move_target ACTOR_MARIO_WORLD_TOAD, 16.0, 15.0 ; $5b24
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $5b2f
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 15.0 ; $5b34
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $5b3f
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_DOWN ; $5b44
	script_wait_frames 20 ; $5b4b
	script_speak ACTOR_MARIO_WORLD_TOAD ; $5b52
	script_wait_frames 10 ; $5b57
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b5e
	script_wait_idle ACTOR_PLAYER ; $5b65
	script_wait_frames 20 ; $5b6a
	script_set_actor_script ACTOR_MARIO_WORLD_TOAD, ActorScript_0e_07 ; $5b71
	script_wait_frames 20 ; $5b7c
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_07 ; $5b83
	script_wait_frames 60 ; $5b8e
	script_move_player 21.0, 13.0 ; $5b95
	script_wait_actor_script ACTOR_PLAYER ; $5b9f
	call PlayStarWarpTransition ; $5ba4
	ld a, STORYLOC_SPECIAL_COURT ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [wStoryModeEntryPoint], a ; $5bae
	ld a, $ff ; $5bb1
	ld [wUnusedExitTriggerIdMirror], a ; $5bb3
	ld [wStoryModeExitTriggerRequest], a ; $5bb6
	ret ; $5bb9
MarioWorldArrivalDoubles:
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5bba
	jr nz, .arrive ; $5bbd
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $5bbf
	jp nz, MoveDoublesPartnerToPlayer.doubles ; $5bc2
.arrive:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $5bc5
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $5bd0
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $5bdb
	script_fade_in $04 ; $5be6
	call WaitFadeEnd ; $5beb
	script_wait_frames 40 ; $5bee
	call MarioWorldArrivalIntroCutscene ; $5bf5
	script_set_position ACTOR_PLAYER, 17.0, 37.0 ; $5bf8
	script_set_position ACTOR_PARTNER, 19.0, 37.0 ; $5c03
	script_set_speed ACTOR_PLAYER, $0010 ; $5c0e
	script_set_speed ACTOR_PARTNER, $0010 ; $5c16
	script_move_target ACTOR_PLAYER, 17.0, 32.5 ; $5c1e
	script_move_target ACTOR_PARTNER, 19.0, 32.5 ; $5c29
	script_player_speed $0010 ; $5c34
	script_move_player 18.0, 27.0 ; $5c3a
	script_wait_frames 80 ; $5c44
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_UP ; $5c4b
	script_wait_frames 10 ; $5c52
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5c59
	jr nz, .walkIn ; $5c5c
	script_set_text Text_5e_102 ; $5c5e
	script_speak ACTOR_MARIO_WORLD_TOAD ; $5c64
	script_speak ACTOR_MARIO_WORLD_TOAD ; $5c69
.walkIn:
	script_player_speed $0020 ; $5c6e
	script_move_player 18.0, 24.0 ; $5c74
	farcall WaitPlayerMoveDone ; $5c7e
	script_wait_frames 10 ; $5c81
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $5c88
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $5c8f
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5c94
	jr nz, .approach ; $5c97
	script_speak ACTOR_MARIO_WORLD_PEACH ; $5c99
.approach:
	script_player_speed $0014 ; $5c9e
	script_set_speed ACTOR_PLAYER, $0014 ; $5ca4
	script_set_speed ACTOR_PARTNER, $0014 ; $5cac
	script_set_speed ACTOR_MARIO_WORLD_TOAD, $0014 ; $5cb4
	script_set_speed ACTOR_MARIO_WORLD_PEACH, $0014 ; $5cbc
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 23.0 ; $5cc4
	script_wait_frames 20 ; $5ccf
	script_move_target ACTOR_PLAYER, 17.0, 17.0 ; $5cd6
	script_move_target ACTOR_PARTNER, 19.0, 17.0 ; $5ce1
	script_wait_frames 40 ; $5cec
	script_move_player 18.0, 13.0 ; $5cf3
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $5cfd
	script_move_target ACTOR_MARIO_WORLD_PEACH, 18.0, 9.0 ; $5d02
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 19.0 ; $5d0d
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $5d18
	script_move_target ACTOR_MARIO_WORLD_TOAD, 13.0, 19.0 ; $5d1d
	script_wait_move ACTOR_MARIO_WORLD_PEACH ; $5d28
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5d2d
	jr z, .done ; $5d30
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $5d32
	script_wait_frames 20 ; $5d39
	ld a, $01 ; $5d40
	ld [wUnusedExitTriggerIdMirror], a ; $5d42
	ld [wStoryModeExitTriggerRequest], a ; $5d45
	ret ; $5d48
.done:
	call MarioWorldWelcomeCutscene ; $5d49
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 63.0, 63.0 ; $5d4c
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_LEFT ; $5d57
	script_wait_frames 40 ; $5d5e
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $5d65
	script_wait_frames 20 ; $5d6a
	script_jump_velocity ACTOR_MARIO_WORLD_BOO, $ff80 ; $5d71
	script_wait_frames 20 ; $5d79
	script_jump_velocity ACTOR_MARIO_WORLD_BOO, $ff80 ; $5d80
	script_wait_frames 40 ; $5d88
	sound SFX_THUD ; $5d8f
	script_speak ACTOR_MARIO_WORLD_BOO ; $5d91
	sound SFX_APPEAR1 ; $5d96
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 15.0, 13.0 ; $5d98
	script_set_speed ACTOR_MARIO_WORLD_BOWSER, $0020 ; $5da3
	script_set_speed ACTOR_MARIO_WORLD_BALLOON_ANGRY, $0020 ; $5dab
	script_wait_frames 40 ; $5db3
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_BOUNCE ; $5dba
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $5dc1
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 15.0, 14.0 ; $5dc6
	script_move_target ACTOR_MARIO_WORLD_BALLOON_ANGRY, 16.0, 12.0 ; $5dd1
	script_wait_move ACTOR_MARIO_WORLD_BALLOON_ANGRY ; $5ddc
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 63.0, 63.0 ; $5de1
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $5dec
	script_wait_frames 20 ; $5df3
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $5dfa
	script_set_speed ACTOR_MARIO_WORLD_WARIO, $0020 ; $5dff
	script_set_speed ACTOR_MARIO_WORLD_WALUIGI, $0020 ; $5e07
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 15.0, 13.0 ; $5e0f
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $5e1a
	script_wait_frames 10 ; $5e1f
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $5e26
	script_move_target ACTOR_MARIO_WORLD_WARIO, 13.5, 13.0 ; $5e2d
	script_wait_move ACTOR_MARIO_WORLD_WARIO ; $5e38
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $5e3d
	script_wait_frames 10 ; $5e44
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $5e4b
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 15.5, 15.5 ; $5e52
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $5e5d
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $5e62
	script_wait_frames 40 ; $5e69
	sound SFX_APPEAR1 ; $5e70
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 15.0, 9.0 ; $5e72
	script_wait_frames 4 ; $5e7d
	sound SFX_APPEAR1 ; $5e84
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 19.0, 7.0 ; $5e86
	script_wait_frames 4 ; $5e91
	sound SFX_APPEAR1 ; $5e98
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_3, 23.0, 9.0 ; $5e9a
	script_wait_frames 4 ; $5ea5
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $5eac
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 17.0, 13.0 ; $5eb3
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $5ebe
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $5ec3
	script_wait_frames 10 ; $5eca
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $5ed1
	script_move_target ACTOR_MARIO_WORLD_WARIO, 15.0, 13.0 ; $5ed8
	script_wait_move ACTOR_MARIO_WORLD_WARIO ; $5ee3
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $5ee8
	script_wait_frames 10 ; $5eef
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $5ef6
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 17.0, 15.0 ; $5efd
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $5f08
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $5f0d
	script_wait_frames 10 ; $5f14
	call MarioWorldLuigiDefendsChampCutscene ; $5f1b
	sound SFX_APPEAR2 ; $5f1e
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 17.5, 15.5 ; $5f20
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 19.5, 15.5 ; $5f2b
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5f36
	script_face ACTOR_PARTNER, FACE_LEFT ; $5f3d
	script_wait_frames 40 ; $5f44
	script_face ACTOR_PLAYER, FACE_UP ; $5f4b
	script_face ACTOR_PARTNER, FACE_UP ; $5f52
	script_wait_frames 20 ; $5f59
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 63.0, 63.0 ; $5f60
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 63.0, 63.0 ; $5f6b
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_LEFT ; $5f76
	script_wait_frames 40 ; $5f7d
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $5f84
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $5f8b
	script_wait_idle ACTOR_MARIO_WORLD_MARIO ; $5f92
	script_wait_frames 10 ; $5f97
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $5f9e
	script_wait_frames 10 ; $5fa5
	script_set_speed ACTOR_MARIO_WORLD_PEACH, $0020 ; $5fac
	script_move_target ACTOR_MARIO_WORLD_PEACH, 18.0, 11.0 ; $5fb4
	script_wait_move ACTOR_MARIO_WORLD_PEACH ; $5fbf
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_DOWN ; $5fc4
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_DOWN ; $5fcb
	script_speak ACTOR_MARIO_WORLD_PEACH ; $5fd2
	call MarioWorldExhibitionDemandCutscene ; $5fd7
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 19.0, 15.0 ; $5fda
	script_move_target ACTOR_MARIO_WORLD_WARIO, 17.0, 15.0 ; $5fe5
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 21.0, 15.0 ; $5ff0
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $5ffb
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 21.0, 19.0 ; $6000
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $600b
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 19.0, 19.0 ; $6010
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $601b
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $6020
	script_wait_frames 40 ; $6027
	set_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $602e
	farcall SaveStorySlotWithTimer ; $6031
	script_speak_restore ACTOR_MARIO_WORLD_PEACH ; $6034
	farcall RunDialogueYesNoPrompt ; $6039
	farcall ScriptCloseDialogueWindow ; $603c
	script_wait_frames 5 ; $603f
	and a ; $6046
	jr z, ExhibitionAcceptedDoubles ; $6047
	script_set_text Text_5e_125 ; $6049
	call ExhibitionDeclinedCutscene ; $604f
	script_get_actor_state ACTOR_PARTNER ; $6052
	ld c, l ; $6057
	ld b, h ; $6058
	ld de, wActors ; $6059
	farcall AttachActorStepMover ; $605c
	ret ; $605f
ExhibitionAcceptedDoubles:
	script_wait_frames 10 ; $6060
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $6067
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $606e
	script_wait_frames 10 ; $6073
	script_set_text Text_5e_128 ; $607a
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $6080
	script_speak ACTOR_MARIO_WORLD_PEACH ; $6085
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_UP ; $608a
	script_wait_frames 4 ; $6091
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $6098
	script_wait_frames 4 ; $609f
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $60a6
	script_wait_frames 4 ; $60ad
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_UP ; $60b4
	script_wait_frames 4 ; $60bb
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_UP ; $60c2
	script_wait_frames 4 ; $60c9
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $60d0
	script_wait_frames 10 ; $60d7
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $60de
	script_set_anim ACTOR_MARIO_WORLD_WARIO, ANIM_NOD ; $60e5
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_NOD ; $60ec
	script_set_anim ACTOR_MARIO_WORLD_WALK_77_05, ANIM_NOD ; $60f3
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $60fa
	script_set_anim ACTOR_MARIO_WORLD_LUIGI, ANIM_NOD ; $6101
	script_set_anim ACTOR_MARIO_WORLD_BABY_MARIO, ANIM_NOD ; $6108
	script_set_anim ACTOR_MARIO_WORLD_YOSHI, ANIM_NOD ; $610f
	script_set_anim ACTOR_MARIO_WORLD_DK, ANIM_NOD ; $6116
	script_set_anim ACTOR_MARIO_WORLD_TOAD, ANIM_NOD ; $611d
	script_wait_idle ACTOR_MARIO_WORLD_TOAD ; $6124
	script_player_speed $0010 ; $6129
	script_move_player 21.0, 13.0 ; $612f
	script_set_speed ACTOR_MARIO_WORLD_PEACH, $0014 ; $6139
	script_set_speed ACTOR_MARIO_WORLD_BOWSER, $0014 ; $6141
	script_set_speed ACTOR_MARIO_WORLD_WARIO, $0014 ; $6149
	script_set_speed ACTOR_MARIO_WORLD_WALUIGI, $0014 ; $6151
	script_set_speed ACTOR_MARIO_WORLD_WALK_77_05, $0014 ; $6159
	script_set_speed ACTOR_MARIO_WORLD_MARIO, $0014 ; $6161
	script_set_speed ACTOR_MARIO_WORLD_LUIGI, $0014 ; $6169
	script_set_speed ACTOR_MARIO_WORLD_BABY_MARIO, $0014 ; $6171
	script_set_speed ACTOR_MARIO_WORLD_YOSHI, $0014 ; $6179
	script_set_speed ACTOR_MARIO_WORLD_BOO, $0014 ; $6181
	script_set_speed ACTOR_MARIO_WORLD_DK, $0014 ; $6189
	script_set_speed ACTOR_MARIO_WORLD_TOAD, $0014 ; $6191
	script_set_speed ACTOR_PLAYER, $0014 ; $6199
	script_set_actor_script ACTOR_MARIO_WORLD_WALK_77_05, ActorScript_0e_06 ; $61a1
	script_wait_frames 20 ; $61ac
	script_set_actor_script ACTOR_MARIO_WORLD_PEACH, ActorScript_0e_06 ; $61b3
	script_wait_frames 20 ; $61be
	script_set_actor_script ACTOR_MARIO_WORLD_MARIO, ActorScript_0e_06 ; $61c5
	script_wait_frames 100 ; $61d0
	script_set_actor_script ACTOR_MARIO_WORLD_LUIGI, ActorScript_0e_06 ; $61d7
	script_set_actor_script ACTOR_MARIO_WORLD_BABY_MARIO, ActorScript_0e_06 ; $61e2
	script_set_actor_script ACTOR_MARIO_WORLD_YOSHI, ActorScript_0e_06 ; $61ed
	script_set_actor_script ACTOR_MARIO_WORLD_DK, ActorScript_0e_06 ; $61f8
	script_set_actor_script ACTOR_MARIO_WORLD_BOO, ActorScript_0e_06 ; $6203
	script_wait_frames 60 ; $620e
	script_set_actor_script ACTOR_MARIO_WORLD_BOWSER, ActorScript_0e_06 ; $6215
	script_set_actor_script ACTOR_MARIO_WORLD_WARIO, ActorScript_0e_06 ; $6220
	script_wait_frames 30 ; $622b
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 21.0, 19.0 ; $6232
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $623d
	script_set_actor_script ACTOR_MARIO_WORLD_WALUIGI, ActorScript_0e_06 ; $6242
	script_wait_actor_script ACTOR_MARIO_WORLD_WALUIGI ; $624d
	script_move_player 18.0, 13.0 ; $6252
	script_move_target ACTOR_MARIO_WORLD_TOAD, 16.0, 15.0 ; $625c
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $6267
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 15.0 ; $626c
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $6277
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_DOWN ; $627c
	script_wait_frames 20 ; $6283
	script_speak ACTOR_MARIO_WORLD_TOAD ; $628a
	script_wait_frames 10 ; $628f
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $6296
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $629d
	script_wait_idle ACTOR_PLAYER ; $62a4
	script_wait_frames 20 ; $62a9
	script_set_actor_script ACTOR_MARIO_WORLD_TOAD, ActorScript_0e_07 ; $62b0
	script_wait_frames 20 ; $62bb
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_07 ; $62c2
	script_wait_frames 50 ; $62cd
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_07 ; $62d4
	script_wait_frames 60 ; $62df
	script_move_player 21.0, 13.0 ; $62e6
	script_wait_actor_script ACTOR_PARTNER ; $62f0
	call PlayStarWarpTransition ; $62f5
	ld a, STORYLOC_SPECIAL_COURT ; $62f8
	ld [wStoryModeCurrentLocation], a ; $62fa
	ld a, $04 ; $62fd
	ld [wStoryModeEntryPoint], a ; $62ff
	ld a, $ff ; $6302
	ld [wUnusedExitTriggerIdMirror], a ; $6304
	ld [wStoryModeExitTriggerRequest], a ; $6307
	ret ; $630a
ActorScript_0e_08:
	; $630b, 25 bytes (actor_script)
	as_set_target 16.0, 9.0
	as_wait_move
	as_set_target 16.0, 13.0
	as_wait_move
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait 30
	as_halt
ActorScript_0e_09:
	; $6324, 25 bytes (actor_script)
	as_set_target 16.0, 9.0
	as_wait_move
	as_set_target 16.0, 13.0
	as_wait_move
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait 30
	as_halt
MarioWorldNpc08FaceDown_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $633d
	script_set_speed ACTOR_PARTNER, $0018 ; $6345
	test_flag FLAG_DOUBLES ; $634d
	jr nz, .doubles ; $6350
	script_move_target ACTOR_PLAYER, 16.0, 9.0 ; $6352
	script_wait_move ACTOR_PLAYER ; $635d
	script_move_target ACTOR_PLAYER, 16.0, 13.0 ; $6362
	script_wait_move ACTOR_PLAYER ; $636d
	script_move_target ACTOR_PLAYER, 18.0, 13.0 ; $6372
	script_wait_move ACTOR_PLAYER ; $637d
	script_face ACTOR_PLAYER, FACE_UP ; $6382
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6389
	script_set_speed ACTOR_PLAYER, $0010 ; $6390
	jp PromptExhibitionMatch ; $6398
.doubles:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $639b
	call MoveDoublesPartnerToPlayer ; $63a6
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $63a9
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_08 ; $63b0
	script_wait_frames 20 ; $63bb
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_09 ; $63c2
	script_wait_actor_script ACTOR_PLAYER ; $63cd
	script_wait_actor_script ACTOR_PARTNER ; $63d2
	jp PromptExhibitionMatch ; $63d7
ActorScript_0e_10:
	; $63da, 13 bytes (actor_script)
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait 30
	as_halt
ActorScript_0e_11:
	; $63e7, 13 bytes (actor_script)
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait 30
	as_halt
MarioWorldNpc08FaceUp_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $63f4
	script_set_speed ACTOR_PARTNER, $0018 ; $63fc
	test_flag FLAG_DOUBLES ; $6404
	jr nz, .doubles ; $6407
	script_lock_facing ACTOR_PLAYER ; $6409
	script_move_target ACTOR_PLAYER, 18.0, 13.0 ; $6410
	script_wait_move ACTOR_PLAYER ; $641b
	script_unlock_facing ACTOR_PLAYER ; $6420
	script_face ACTOR_PLAYER, FACE_UP ; $6427
	script_face ACTOR_PLAYER, FACE_UP ; $642e
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6435
	jp PromptExhibitionMatch ; $643c
.doubles:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $643f
	call MoveDoublesPartnerToPlayer ; $644a
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $644d
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_10 ; $6454
	script_wait_frames 20 ; $645f
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_11 ; $6466
	script_wait_actor_script ACTOR_PLAYER ; $6471
	script_wait_actor_script ACTOR_PARTNER ; $6476
	jp PromptExhibitionMatch ; $647b
