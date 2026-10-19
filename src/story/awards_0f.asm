AwardsCeremonyNpc08_0f:
	script_set_text Text_AwardsSpikeSilence ; $5628
	call CheckAwardsCeremonyRivalSceneDone ; $562e
	and $01 ; $5631
	jr z, .speak ; $5633
	script_set_text Text_AwardsSpikeNotNextYear ; $5635
.speak:
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $563b
	ret ; $5640
ReplacePlayerWithStandInActor:
	ld a, [wStoryMainGender] ; $5641
	ld d, OBJ_ALEX_B ; $5644
	add d ; $5646
	ld d, a ; $5647
	script_get_actor_state ACTOR_AWARDS_CEREMONY_ALEX ; $5648
	ld c, l ; $564d
	ld b, h ; $564e
	farcall LoadActorObjectDefIfValid ; $564f
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_WALK ; $5652
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $5659
	ret ; $5664
ActorScript_0f_00:
	; $5665, 19 bytes (actor_script)
	as_set_target 12.0, 19.0
	as_wait_move
	as_set_target 17.0, 19.0
	as_wait_move
	as_set_target 17.0, 15.0
	as_wait_move
	as_halt
	twin wait_script_frames_save_a, 0f ; $5678 WaitScriptFramesSaveA_0f
CutsceneStompScreenShake:
	script_jump_velocity ACTOR_AWARDS_CEREMONY_SPIKE, -2.0 ; $567f
	script_wait_jump ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE ; $5687
	sound SFX_STOMP ; $568c
	ld a, $02 ; $568e
	farcall SetScreenShake ; $5690
	script_delay 8 ; $5693
	ld a, $01 ; $5698
	farcall SetScreenShake ; $569a
	script_delay 8 ; $569d
	ld a, $00 ; $56a2
	farcall SetScreenShake ; $56a4
	ret ; $56a7
AwardsCeremonyEntry0aScene:
	call AwardsCeremonyArrivalIntro ; $56a8
	script_set_anim ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ANIM_BOUNCE ; $56ab
	script_wait_idle ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $56b2
	script_face_toward ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $56b7
	script_delay 10 ; $56bf
	script_set_text Text_AwardsKevinCongrats ; $56c4
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $56ca
	script_set_anim ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ANIM_NOD ; $56cf
	script_wait_idle ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $56d6
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $56db
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $56e0
	script_wait_idle ACTOR_PLAYER ; $56e7
	script_face_toward ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ACTOR_AWARDS_CEREMONY_A_COZ ; $56ec
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $56f4
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $56fb
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5700
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 12.5, 37.5 ; $5705
	sound SFX_APPEAR1 ; $5710
	script_delay 60 ; $5712
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $5717
	script_set_anim ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ANIM_BOUNCE ; $5722
	script_wait_idle ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5729
	script_face_toward ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $572e
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5736
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $573b
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5742
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5747
	script_delay 30 ; $574c
	script_face_pair ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5751
	script_delay 80 ; $5759
	script_face_toward ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $575e
	script_face_pair ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_PLAYER ; $5766
	script_delay 30 ; $576e
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_SHAKE ; $5773
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $577a
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $577f
	script_delay 40 ; $5784
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5789
	script_face ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, FACE_UP ; $578e
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5795
	script_delay 20 ; $579c
	script_player_speed 0.75 ; $57a1
	script_move_player 12.0, 19.0 ; $57a7
	farcall WaitPlayerMoveDone ; $57b1
	script_delay 30 ; $57b4
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, ANIM_BOUNCE ; $57b9
	script_wait_idle ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $57c0
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $57c5
	script_delay 40 ; $57ca
	script_move_player 12.0, 41.0 ; $57cf
	farcall WaitPlayerMoveDone ; $57d9
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_DOWN ; $57dc
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $57e3
	script_face ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, FACE_RIGHT ; $57e8
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $57ef
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $57f6
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $57fb
	script_set_anim ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ANIM_BOUNCE ; $5800
	script_wait_idle ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5807
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_LEFT ; $580c
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5813
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 14.5, 37.5 ; $5818
	sound SFX_APPEAR1 ; $5823
	script_delay 60 ; $5825
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $582a
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5835
	script_delay 40 ; $583c
	script_face ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, FACE_DOWN ; $5841
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5848
	script_set_anim ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ANIM_BOUNCE ; $584d
	script_wait_idle ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5854
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $5859
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $585e
	script_wait_idle ACTOR_PLAYER ; $5865
	script_speak ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS ; $586a
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $586f
	script_wait_idle ACTOR_PLAYER ; $5876
	script_follow ACTOR_AWARDS_CEREMONY_KEVIN_SWEATS, ACTOR_PLAYER ; $587b
	ret ; $5888
AwardsCeremonyEntry0bScene:
	script_null_script ACTOR_PARTNER ; $5889
	script_set_position ACTOR_PARTNER, 11.0, 39.0 ; $588e
	script_face ACTOR_PARTNER, FACE_UP ; $5899
	call AwardsCeremonyArrivalIntro ; $58a0
	script_set_text Text_AwardsPartnerCongrats ; $58a3
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $58a9
	script_wait_idle ACTOR_PARTNER ; $58b0
	script_face ACTOR_PARTNER, FACE_DOWN ; $58b5
	call SpeakPartnerVariantLine ; $58bc
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $58bf
	script_wait_idle ACTOR_PLAYER ; $58c6
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $58cb
	script_wait_idle ACTOR_PARTNER ; $58d2
	call SpeakPartnerVariantLine ; $58d7
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $58da
	script_wait_idle ACTOR_PLAYER ; $58e1
	script_face_toward ACTOR_PARTNER, ACTOR_AWARDS_CEREMONY_A_COZ ; $58e6
	script_delay 10 ; $58ee
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $58f3
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $58fa
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $58ff
	script_face_toward ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_B_COZ ; $5904
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $590c
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 12.5, 37.5 ; $5911
	sound SFX_EMOTE ; $591c
	script_delay 60 ; $591e
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 63.0, 63.0 ; $5923
	script_face ACTOR_PARTNER, FACE_RIGHT ; $592e
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5935
	script_wait_idle ACTOR_PARTNER ; $593c
	call SpeakPartnerVariantLine ; $5941
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $5944
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $594b
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5950
	script_set_anim ACTOR_AWARDS_CEREMONY_B_COZ, ANIM_BOUNCE ; $5955
	script_wait_idle ACTOR_AWARDS_CEREMONY_B_COZ ; $595c
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $5961
	script_delay 30 ; $5966
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $596b
	script_delay 60 ; $5973
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5978
	script_face ACTOR_PARTNER, FACE_RIGHT ; $597f
	script_delay 30 ; $5986
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_DOWN ; $598b
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_SHAKE ; $5992
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5999
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $599e
	script_delay 40 ; $59a3
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $59a8
	script_face ACTOR_PLAYER, FACE_UP ; $59ad
	script_face ACTOR_PARTNER, FACE_UP ; $59b4
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $59bb
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $59c2
	script_delay 20 ; $59c9
	script_player_speed 0.75 ; $59ce
	script_move_player 12.0, 19.0 ; $59d4
	farcall WaitPlayerMoveDone ; $59de
	script_delay 30 ; $59e1
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, ANIM_BOUNCE ; $59e6
	script_wait_idle ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $59ed
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $59f2
	script_delay 40 ; $59f7
	script_move_player 12.0, 41.0 ; $59fc
	farcall WaitPlayerMoveDone ; $5a06
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_LEFT ; $5a09
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5a10
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5a15
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5a1c
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_BOUNCE ; $5a23
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5a2a
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5a2f
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_LEFT ; $5a34
	script_set_anim ACTOR_AWARDS_CEREMONY_B_COZ, ANIM_BOUNCE ; $5a3b
	script_wait_idle ACTOR_AWARDS_CEREMONY_B_COZ ; $5a42
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $5a47
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5a4c
	script_wait_idle ACTOR_PARTNER ; $5a53
	call SpeakPartnerVariantLine ; $5a58
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 14.5, 37.5 ; $5a5b
	sound SFX_APPEAR1 ; $5a66
	script_delay 60 ; $5a68
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 14.5, 39.5 ; $5a6d
	sound SFX_APPEAR1 ; $5a78
	script_delay 60 ; $5a7a
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $5a7f
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5a8a
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $5a91
	script_delay 30 ; $5a98
	script_face_pair ACTOR_PLAYER, ACTOR_PARTNER ; $5a9d
	call SpeakPartnerVariantLine ; $5aa5
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $5aa8
	script_wait_idle ACTOR_PARTNER ; $5aaf
	call SpeakPartnerVariantLine ; $5ab4
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5ab7
	script_wait_idle ACTOR_PLAYER ; $5abe
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5ac3
	script_wait_idle ACTOR_PARTNER ; $5aca
	call SpeakPartnerVariantLine ; $5acf
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5ad2
	script_wait_idle ACTOR_PLAYER ; $5ad9
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $5ade
	ret ; $5aeb
SpeakPartnerVariantLine:
	ld a, [wStoryPartnerGender] ; $5aec
	and a ; $5aef
	jr nz, .femalePartner ; $5af0
	script_speak ACTOR_PARTNER ; $5af2
	farcall AdvanceDialogueTextCursor ; $5af7
	ret ; $5afa
.femalePartner:
	farcall AdvanceDialogueTextCursor ; $5afb
	script_speak ACTOR_PARTNER ; $5afe
	ret ; $5b03
AwardsCeremonyNpcScriptsDoubles_0f:
	; $5b04, 73 bytes (map_scripts)
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_AwardsKevinSeeYourTrophy, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_A_COZ, FACEMASK_ANY, $0000, Text_AwardsACozRuinReputation, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_B_COZ, FACEMASK_ANY, $0000, Text_AwardsBCozBackFromDead, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SAMMI, FACEMASK_ANY, $0000, Text_AwardsSammiAmazedYouBeatThem, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SEAN, FACEMASK_ANY, $0000, Text_AwardsSeanCostellosFreaky, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE, FACEMASK_ANY, $0000, AwardsCeremonyNpc08_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_ISLAND_SPECTATOR_B, FACEMASK_ANY, $0000, Text_AwardsSpectatorExcitingMatch, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_ISLAND_SPECTATOR_A, FACEMASK_ANY, $0000, Text_AwardsSpectatorEveryMonth, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_AwardsEmilyAvengingMyLoss, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
AwardsCeremonyArrivalIntro:
	script_player_speed 7.96875 ; $5b4d
	script_move_player 12.0, 11.0 ; $5b53
	farcall WaitPlayerMoveDone ; $5b5d
	xor a ; $5b60
	ld [wStoryModeShowLocationName], a ; $5b61
	script_fade_in 4 ; $5b64
	call WaitFadeEnd ; $5b69
	script_set_objdef OBJ_STUDENT_LONG_HAIR, ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5b6c
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_WALK ; $5b78
	script_set_objdef OBJ_STUDENT_PIGTAILS_GIRL, ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT ; $5b7f
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, ANIM_WALK ; $5b8b
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 7.0, 1.0 ; $5b92
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 15.0, 1.0 ; $5b9d
	script_set_speed ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 1.0 ; $5ba8
	script_move_target ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 7.0, 5.0 ; $5bb0
	script_wait_move ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5bbb
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_SHAKE ; $5bc0
	script_wait_idle ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5bc7
	script_jump_velocity ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, -2.0 ; $5bcc
	script_wait_jump ACTOR_AWARDS_CEREMONY_DOUBLES_BALLOON_ANGRY ; $5bd4
	script_set_speed ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 1.0 ; $5bd9
	script_move_target ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 15.0, 7.5 ; $5be1
	script_wait_move ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT ; $5bec
	script_jump_velocity ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, -2.0 ; $5bf1
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, ANIM_BOUNCE ; $5bf9
	script_player_speed 0.5 ; $5c00
	script_move_player_to_actor ACTOR_PLAYER ; $5c06
	farcall WaitPlayerMoveDone ; $5c0d
	script_delay 30 ; $5c10
	script_set_objdef OBJ_BALLOON_ANGRY, ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5c15
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_WALK ; $5c21
	script_set_objdef OBJ_BALLOON_SWEAT, ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT ; $5c28
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, ANIM_WALK ; $5c34
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $5c3b
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 63.0, 63.0 ; $5c46
	ret ; $5c51
AnnounceWinnersToPodiums:
	script_face_pair ACTOR_AWARDS_CEREMONY_HEADMASTER, ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5c52
	script_delay 30 ; $5c5a
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, ANIM_NOD ; $5c5f
	script_wait_idle ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5c66
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_NOD ; $5c6b
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5c72
	script_delay 30 ; $5c77
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, FACE_RIGHT ; $5c7c
	script_face ACTOR_AWARDS_CEREMONY_HEADMASTER, FACE_RIGHT ; $5c83
	script_set_text Text_AwardsStaffWinnersToPodiums ; $5c8a
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5c90
	ret ; $5c95
FaceAwardsCeremonyCrowdUp:
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $5c96
	script_face ACTOR_AWARDS_CEREMONY_SPIKE, FACE_UP ; $5c9d
	script_face ACTOR_AWARDS_CEREMONY_ISLAND_SPECTATOR_B, FACE_UP ; $5ca4
	script_face ACTOR_AWARDS_CEREMONY_ISLAND_SPECTATOR_A, FACE_UP ; $5cab
	script_face ACTOR_AWARDS_CEREMONY_SAMMI, FACE_UP ; $5cb2
	script_face ACTOR_AWARDS_CEREMONY_EMILY_SWEATS, FACE_UP ; $5cb9
	script_face ACTOR_AWARDS_CEREMONY_SEAN, FACE_UP ; $5cc0
	script_face ACTOR_AWARDS_CEREMONY_MARK_SWEATS, FACE_UP ; $5cc7
	ret ; $5cce
AwardsCeremonyChairmanSpeech:
	script_delay 30 ; $5ccf
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5cd4
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, ANIM_NOD ; $5cd9
	script_wait_idle ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5ce0
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, FACE_UP ; $5ce5
	script_delay 30 ; $5cec
	script_lock_facing ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5cf1
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, 7.0, 27.0 ; $5cf8
	script_wait_move ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5d03
	script_unlock_facing ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5d08
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, FACE_RIGHT ; $5d0f
	script_move_target ACTOR_AWARDS_CEREMONY_HEADMASTER, 8.0, 25.0 ; $5d16
	script_wait_move ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d21
	script_face ACTOR_AWARDS_CEREMONY_HEADMASTER, FACE_RIGHT ; $5d26
	script_delay 30 ; $5d2d
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_NOD ; $5d32
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d39
	script_speak ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d3e
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_SHAKE ; $5d43
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d4a
	script_speak ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d4f
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_BOUNCE ; $5d54
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d5b
	script_speak ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d60
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_SHAKE ; $5d65
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d6c
	script_speak ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d71
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_NOD ; $5d76
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d7d
	script_speak ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d82
	script_set_anim ACTOR_AWARDS_CEREMONY_HEADMASTER, ANIM_NOD ; $5d87
	script_wait_idle ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5d8e
	script_delay 60 ; $5d93
	script_move_target ACTOR_AWARDS_CEREMONY_HEADMASTER, 8.0, 23.0 ; $5d98
	script_wait_move ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5da3
	script_face ACTOR_AWARDS_CEREMONY_HEADMASTER, FACE_RIGHT ; $5da8
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, 8.0, 25.0 ; $5daf
	script_wait_move ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5dba
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1, FACE_RIGHT ; $5dbf
	script_delay 30 ; $5dc6
	script_speak ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_1 ; $5dcb
	script_set_objdef OBJ_STUDENT_LONG_HAIR, ACTOR_AWARDS_CEREMONY_SEAN ; $5dd0
	script_set_anim ACTOR_AWARDS_CEREMONY_SEAN, ANIM_WALK ; $5ddc
	script_set_objdef OBJ_STUDENT_PIGTAILS_GIRL, ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT ; $5de3
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, ANIM_WALK ; $5def
	script_set_position ACTOR_AWARDS_CEREMONY_SEAN, 7.0, 5.0 ; $5df6
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 15.0, 7.5 ; $5e01
	script_face ACTOR_AWARDS_CEREMONY_SEAN, FACE_DOWN ; $5e0c
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, FACE_DOWN ; $5e13
	script_delay 30 ; $5e1a
	script_move_player 12.0, 17.0 ; $5e1f
	script_move_target ACTOR_AWARDS_CEREMONY_HEADMASTER, 12.0, 23.0 ; $5e29
	script_wait_move ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5e34
	script_move_target ACTOR_AWARDS_CEREMONY_HEADMASTER, 12.0, 19.0 ; $5e39
	script_wait_move ACTOR_AWARDS_CEREMONY_HEADMASTER ; $5e44
	ret ; $5e49
AwardsCeremonySwapActors_0f:
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5e4a
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, ANIM_WALK ; $5e56
	script_set_objdef OBJ_TOURNAMENT_STAFF, ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $5e5d
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_3, ANIM_WALK ; $5e69
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.0, 22.0 ; $5e70
	script_set_position ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 17.0, 21.0 ; $5e7b
	script_face ACTOR_AWARDS_CEREMONY_TROPHY_3, FACE_UP ; $5e86
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, ANIM_TROPHY_SMALL ; $5e8d
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 17.0, 18.0 ; $5e94
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.0, 19.0 ; $5e9f
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $5eaa
	script_set_objdef OBJ_TOURNAMENT_STAFF, ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5eaf
	script_set_anim ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, ANIM_WALK ; $5ebb
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $5ec2
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_3, ANIM_WALK ; $5ece
	script_set_position ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 17.0, 19.0 ; $5ed5
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 16.0, 19.0 ; $5ee0
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, FACE_LEFT ; $5eeb
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_3, ANIM_TROPHY_SMALL ; $5ef2
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 16.0, 19.0 ; $5ef9
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 15.0, 19.0 ; $5f04
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $5f0f
	script_lock_facing ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5f14
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 17.0, 19.0 ; $5f1b
	script_wait_move ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5f26
	script_unlock_facing ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5f2b
	script_set_speed ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 1.0 ; $5f32
	script_move_target ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, 17.0, 22.0 ; $5f3a
	script_wait_move ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2 ; $5f45
	script_face ACTOR_AWARDS_CEREMONY_TOURNAMENT_STAFF_2, FACE_UP ; $5f4a
	ret ; $5f51
SavePlayerActorPosition:
	wram_bank WRAM_ACTORS ; $5f52
	script_get_actor_state ACTOR_PLAYER ; $5f58
	ld c, l ; $5f5d
	ld b, h ; $5f5e
	ld hl, ACTORF_X ; $5f5f
	add hl, bc ; $5f62
	ld a, [hl+] ; $5f63
	ld d, [hl] ; $5f64
	ld e, a ; $5f65
	ld hl, wMapScratch ; $5f66
	ld a, e ; $5f69
	ld [hl+], a ; $5f6a
	ld [hl], d ; $5f6b
	ld hl, ACTORF_Y ; $5f6c
	add hl, bc ; $5f6f
	ld a, [hl+] ; $5f70
	ld d, [hl] ; $5f71
	ld e, a ; $5f72
	ld hl, wMapScratch + 2 ; $5f73
	ld a, e ; $5f76
	ld [hl+], a ; $5f77
	ld [hl], d ; $5f78
	ret ; $5f79
