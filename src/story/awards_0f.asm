AwardsCeremonyNpc08_0f:
	script_set_text Text_25_125 ; $5628
	call CheckAwardsCeremonyRivalSceneDone ; $562e
	and $01 ; $5631
	jr z, .speak ; $5633
	script_set_text Text_25_129 ; $5635
.speak:
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $563b
	ret ; $5640
ReplacePlayerWithStandInActor:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5641
	ld d, OBJ_ALEX_B ; $5644
	add d ; $5646
	ld d, a ; $5647
	script_get_actor_state ACTOR_AWARDS_CEREMONY_ALEX ; $5648
	ld c, l ; $564d
	ld b, h ; $564e
	farcall LoadActorObjectDefIfValid ; $564f
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, $01 ; $5652
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $5659
	ret ; $5664
ActorScript_0f_00:
	; $5665, 19 bytes (actor_script)
	as_set_target $0c00, $1300
	as_wait_move
	as_set_target $1100, $1300
	as_wait_move
	as_set_target $1100, $0f00
	as_wait_move
	as_halt
DelayFrames:
	push af ; $5678
	ld a, a ; $5679
	farcall WaitScriptFrames ; $567a
	pop af ; $567d
	ret ; $567e
CutsceneStompScreenShake:
	script_jump_velocity ACTOR_AWARDS_CEREMONY_SPIKE, $ff80 ; $567f
	ld a, $08 ; $5687
	farcall ScriptWaitActorJumpDone ; $5689
	sound SFX_STOMP ; $568c
	ld a, $02 ; $568e
	farcall SetScreenShake ; $5690
	ld a, $08 ; $5693
	call DelayFrames ; $5695
	ld a, $01 ; $5698
	farcall SetScreenShake ; $569a
	ld a, $08 ; $569d
	call DelayFrames ; $569f
	ld a, $00 ; $56a2
	farcall SetScreenShake ; $56a4
	ret ; $56a7
.arrival:
	call AwardsCeremonyArrivalIntro ; $56a8
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_08, $02 ; $56ab
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $56b2
	script_face_toward ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $56b7
	ld a, $0a ; $56bf
	call DelayFrames ; $56c1
	script_set_text Text_25_107 ; $56c4
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $56ca
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_08, $03 ; $56cf
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $56d6
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $56db
	script_set_anim ACTOR_PLAYER, $03 ; $56e0
	script_wait_idle ACTOR_PLAYER ; $56e7
	script_face_toward ACTOR_AWARDS_CEREMONY_WALK_74_08, ACTOR_AWARDS_CEREMONY_A_COZ ; $56ec
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $56f4
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $56fb
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5700
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $0c80, $2580 ; $5705
	sound SFX_APPEAR1 ; $5710
	ld a, $3c ; $5712
	call DelayFrames ; $5714
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $3f00, $3f00 ; $5717
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_08, $02 ; $5722
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5729
	script_face_toward ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $572e
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5736
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $573b
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5742
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5747
	ld a, $1e ; $574c
	call DelayFrames ; $574e
	script_face_pair ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5751
	ld a, $50 ; $5759
	call DelayFrames ; $575b
	script_face_toward ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $575e
	script_face_pair ACTOR_AWARDS_CEREMONY_A_COZ, ACTOR_PLAYER ; $5766
	ld a, $1e ; $576e
	call DelayFrames ; $5770
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $04 ; $5773
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $577a
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $577f
	ld a, $28 ; $5784
	call DelayFrames ; $5786
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5789
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_UP ; $578e
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5795
	ld a, $14 ; $579c
	call DelayFrames ; $579e
	script_player_speed $0018 ; $57a1
	script_move_player $0c00, $1300 ; $57a7
	farcall WaitPlayerMoveDone ; $57b1
	ld a, $1e ; $57b4
	call DelayFrames ; $57b6
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $02 ; $57b9
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $57c0
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $57c5
	ld a, $28 ; $57ca
	call DelayFrames ; $57cc
	script_move_player $0c00, $2900 ; $57cf
	farcall WaitPlayerMoveDone ; $57d9
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_DOWN ; $57dc
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $57e3
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_RIGHT ; $57e8
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $57ef
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $57f6
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $57fb
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_08, $02 ; $5800
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5807
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_LEFT ; $580c
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5813
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $0e80, $2580 ; $5818
	sound SFX_APPEAR1 ; $5823
	ld a, $3c ; $5825
	call DelayFrames ; $5827
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $3f00, $3f00 ; $582a
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5835
	ld a, $28 ; $583c
	call DelayFrames ; $583e
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_DOWN ; $5841
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5848
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_08, $02 ; $584d
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5854
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $5859
	script_set_anim ACTOR_PLAYER, $02 ; $585e
	script_wait_idle ACTOR_PLAYER ; $5865
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $586a
	script_set_anim ACTOR_PLAYER, $03 ; $586f
	script_wait_idle ACTOR_PLAYER ; $5876
	script_get_actor_state ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $587b
	ld c, l ; $5880
	ld b, h ; $5881
	ld de, wActors ; $5882
	farcall AttachActorStepMover ; $5885
	ret ; $5888
.doubles:
	script_null_script ACTOR_PARTNER ; $5889
	script_set_position ACTOR_PARTNER, $0b00, $2700 ; $588e
	script_face ACTOR_PARTNER, FACE_UP ; $5899
	call AwardsCeremonyArrivalIntro ; $58a0
	script_set_text Text_25_151 ; $58a3
	script_set_anim ACTOR_PARTNER, $02 ; $58a9
	script_wait_idle ACTOR_PARTNER ; $58b0
	script_face ACTOR_PARTNER, FACE_DOWN ; $58b5
	call SpeakPartnerVariantLine ; $58bc
	script_set_anim ACTOR_PLAYER, $03 ; $58bf
	script_wait_idle ACTOR_PLAYER ; $58c6
	script_set_anim ACTOR_PARTNER, $03 ; $58cb
	script_wait_idle ACTOR_PARTNER ; $58d2
	call SpeakPartnerVariantLine ; $58d7
	script_set_anim ACTOR_PLAYER, $03 ; $58da
	script_wait_idle ACTOR_PLAYER ; $58e1
	script_face_toward ACTOR_PARTNER, ACTOR_AWARDS_CEREMONY_A_COZ ; $58e6
	ld a, $0a ; $58ee
	call DelayFrames ; $58f0
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $58f3
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $58fa
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $58ff
	script_face_toward ACTOR_PLAYER, ACTOR_AWARDS_CEREMONY_B_COZ ; $5904
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $590c
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_13, $0c80, $2580 ; $5911
	sound SFX_EMOTE ; $591c
	ld a, $3c ; $591e
	call DelayFrames ; $5920
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_13, $3f00, $3f00 ; $5923
	script_face ACTOR_PARTNER, FACE_RIGHT ; $592e
	script_set_anim ACTOR_PARTNER, $02 ; $5935
	script_wait_idle ACTOR_PARTNER ; $593c
	call SpeakPartnerVariantLine ; $5941
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $5944
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $594b
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5950
	script_set_anim ACTOR_AWARDS_CEREMONY_B_COZ, $02 ; $5955
	script_wait_idle ACTOR_AWARDS_CEREMONY_B_COZ ; $595c
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $5961
	ld a, $1e ; $5966
	call DelayFrames ; $5968
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $596b
	ld a, $3c ; $5973
	call DelayFrames ; $5975
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5978
	script_face ACTOR_PARTNER, FACE_RIGHT ; $597f
	ld a, $1e ; $5986
	call DelayFrames ; $5988
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_DOWN ; $598b
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $04 ; $5992
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5999
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $599e
	ld a, $28 ; $59a3
	call DelayFrames ; $59a5
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $59a8
	script_face ACTOR_PLAYER, FACE_UP ; $59ad
	script_face ACTOR_PARTNER, FACE_UP ; $59b4
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $59bb
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $59c2
	ld a, $14 ; $59c9
	call DelayFrames ; $59cb
	script_player_speed $0018 ; $59ce
	script_move_player $0c00, $1300 ; $59d4
	farcall WaitPlayerMoveDone ; $59de
	ld a, $1e ; $59e1
	call DelayFrames ; $59e3
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $02 ; $59e6
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $59ed
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $59f2
	ld a, $28 ; $59f7
	call DelayFrames ; $59f9
	script_move_player $0c00, $2900 ; $59fc
	farcall WaitPlayerMoveDone ; $5a06
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_LEFT ; $5a09
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5a10
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5a15
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5a1c
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, $02 ; $5a23
	script_wait_idle ACTOR_AWARDS_CEREMONY_A_COZ ; $5a2a
	script_speak ACTOR_AWARDS_CEREMONY_A_COZ ; $5a2f
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_LEFT ; $5a34
	script_set_anim ACTOR_AWARDS_CEREMONY_B_COZ, $02 ; $5a3b
	script_wait_idle ACTOR_AWARDS_CEREMONY_B_COZ ; $5a42
	script_speak ACTOR_AWARDS_CEREMONY_B_COZ ; $5a47
	script_set_anim ACTOR_PARTNER, $02 ; $5a4c
	script_wait_idle ACTOR_PARTNER ; $5a53
	call SpeakPartnerVariantLine ; $5a58
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $0e80, $2580 ; $5a5b
	sound SFX_APPEAR1 ; $5a66
	ld a, $3c ; $5a68
	call DelayFrames ; $5a6a
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $0e80, $2780 ; $5a6d
	sound SFX_APPEAR1 ; $5a78
	ld a, $3c ; $5a7a
	call DelayFrames ; $5a7c
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $3f00, $3f00 ; $5a7f
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_UP ; $5a8a
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $5a91
	ld a, $1e ; $5a98
	call DelayFrames ; $5a9a
	script_face_pair ACTOR_PLAYER, ACTOR_PARTNER ; $5a9d
	call SpeakPartnerVariantLine ; $5aa5
	script_set_anim ACTOR_PARTNER, $02 ; $5aa8
	script_wait_idle ACTOR_PARTNER ; $5aaf
	call SpeakPartnerVariantLine ; $5ab4
	script_set_anim ACTOR_PLAYER, $02 ; $5ab7
	script_wait_idle ACTOR_PLAYER ; $5abe
	script_set_anim ACTOR_PARTNER, $03 ; $5ac3
	script_wait_idle ACTOR_PARTNER ; $5aca
	call SpeakPartnerVariantLine ; $5acf
	script_set_anim ACTOR_PLAYER, $03 ; $5ad2
	script_wait_idle ACTOR_PLAYER ; $5ad9
	script_get_actor_state ACTOR_PARTNER ; $5ade
	ld c, l ; $5ae3
	ld b, h ; $5ae4
	ld de, wActors ; $5ae5
	farcall AttachActorStepMover ; $5ae8
	ret ; $5aeb
SpeakPartnerVariantLine:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5aec
	and a ; $5aef
	jr nz, .femalePartner ; $5af0
	script_speak ACTOR_PARTNER ; $5af2
	farcall AdvanceDialogueTextCursor ; $5af7
	ret ; $5afa
.femalePartner:
	farcall AdvanceDialogueTextCursor ; $5afb
	script_speak ACTOR_PARTNER ; $5afe
	ret ; $5b03
AwardsCeremonyScriptsDoubles_0f:
	; $5b04, 73 bytes (map_scripts)
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_WALK_74_08, FACEMASK_ANY, $0000, Text_25_183, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_A_COZ, FACEMASK_ANY, $0000, Text_25_165, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_B_COZ, FACEMASK_ANY, $0000, Text_25_166, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SAMMI, FACEMASK_ANY, $0000, Text_25_175, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SEAN, FACEMASK_ANY, $0000, Text_25_177, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE, FACEMASK_ANY, $0000, AwardsCeremonyNpc08_0f, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_WALK_6F_06, FACEMASK_ANY, $0000, Text_25_130, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_WALK_6F_05, FACEMASK_ANY, $0000, Text_25_131, $03, $00
	map_script ACTOR_AWARDS_CEREMONY_DOUBLES_WALK_74_06, FACEMASK_ANY, $0000, Text_25_176, $03, $00
	db $ff
AwardsCeremonyArrivalIntro:
	script_player_speed $00ff ; $5b4d
	script_move_player $0c00, $0b00 ; $5b53
	farcall WaitPlayerMoveDone ; $5b5d
	xor a ; $5b60
	ld [wStoryModeShowLocationName], a ; $5b61
	script_fade_in $04 ; $5b64
	call WaitFadeEnd ; $5b69
	script_set_objdef OBJ_WALK_71_03, ACTOR_AWARDS_CEREMONY_WALK_73_14 ; $5b6c
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_14, $01 ; $5b78
	script_set_objdef OBJ_WALK_72_03, ACTOR_AWARDS_CEREMONY_WALK_73_19 ; $5b7f
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_19, $01 ; $5b8b
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $0700, $0100 ; $5b92
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_19, $0f00, $0100 ; $5b9d
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_73_14, $0020 ; $5ba8
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_73_14, $0700, $0500 ; $5bb0
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_73_14 ; $5bbb
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_14, $04 ; $5bc0
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_73_14 ; $5bc7
	script_jump_velocity ACTOR_AWARDS_CEREMONY_WALK_73_14, $ff80 ; $5bcc
	ld a, $13 ; $5bd4
	farcall ScriptWaitActorJumpDone ; $5bd6
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_73_19, $0020 ; $5bd9
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_73_19, $0f00, $0780 ; $5be1
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_73_19 ; $5bec
	script_jump_velocity ACTOR_AWARDS_CEREMONY_WALK_73_14, $ff80 ; $5bf1
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_19, $02 ; $5bf9
	script_player_speed $0010 ; $5c00
	script_move_player_to_actor ACTOR_PLAYER ; $5c06
	farcall WaitPlayerMoveDone ; $5c0d
	ld a, $1e ; $5c10
	call DelayFrames ; $5c12
	script_set_objdef OBJ_WALK_73_14, ACTOR_AWARDS_CEREMONY_WALK_73_14 ; $5c15
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_14, $01 ; $5c21
	script_set_objdef OBJ_WALK_73_19, ACTOR_AWARDS_CEREMONY_WALK_73_19 ; $5c28
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_19, $01 ; $5c34
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_14, $3f00, $3f00 ; $5c3b
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_19, $3f00, $3f00 ; $5c46
	ret ; $5c51
AnnounceWinnersToPodiums:
	script_face_pair ACTOR_AWARDS_CEREMONY_WALK_75_06, ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5c52
	ld a, $1e ; $5c5a
	call DelayFrames ; $5c5c
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $03 ; $5c5f
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5c66
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $03 ; $5c6b
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5c72
	ld a, $1e ; $5c77
	call DelayFrames ; $5c79
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, FACE_RIGHT ; $5c7c
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_RIGHT ; $5c83
	script_set_text Text_25_133 ; $5c8a
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5c90
	ret ; $5c95
FaceAwardsCeremonyCrowdUp:
	script_face ACTOR_AWARDS_CEREMONY_B_COZ, FACE_UP ; $5c96
	script_face ACTOR_AWARDS_CEREMONY_SPIKE, FACE_UP ; $5c9d
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_06, FACE_UP ; $5ca4
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_05, FACE_UP ; $5cab
	script_face ACTOR_AWARDS_CEREMONY_SAMMI, FACE_UP ; $5cb2
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_06, FACE_UP ; $5cb9
	script_face ACTOR_AWARDS_CEREMONY_SEAN, FACE_UP ; $5cc0
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_UP ; $5cc7
	ret ; $5cce
AwardsCeremonyChairmanSpeech:
	ld a, $1e ; $5ccf
	call DelayFrames ; $5cd1
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5cd4
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $03 ; $5cd9
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5ce0
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, FACE_UP ; $5ce5
	ld a, $1e ; $5cec
	call DelayFrames ; $5cee
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5cf1
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $0700, $1b00 ; $5cf8
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5d03
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5d08
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, FACE_RIGHT ; $5d0f
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, $0800, $1900 ; $5d16
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d21
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_RIGHT ; $5d26
	ld a, $1e ; $5d2d
	call DelayFrames ; $5d2f
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $03 ; $5d32
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d39
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d3e
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $04 ; $5d43
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d4a
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d4f
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $02 ; $5d54
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d5b
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d60
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $04 ; $5d65
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d6c
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d71
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $03 ; $5d76
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d7d
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d82
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, $03 ; $5d87
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5d8e
	ld a, $3c ; $5d93
	call DelayFrames ; $5d95
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, $0800, $1700 ; $5d98
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5da3
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_RIGHT ; $5da8
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, $0800, $1900 ; $5daf
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5dba
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, FACE_RIGHT ; $5dbf
	ld a, $1e ; $5dc6
	call DelayFrames ; $5dc8
	script_speak ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $5dcb
	script_set_objdef OBJ_WALK_71_03, ACTOR_AWARDS_CEREMONY_SEAN ; $5dd0
	script_set_anim ACTOR_AWARDS_CEREMONY_SEAN, $01 ; $5ddc
	script_set_objdef OBJ_WALK_72_03, ACTOR_AWARDS_CEREMONY_WALK_73_19 ; $5de3
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_73_19, $01 ; $5def
	script_set_position ACTOR_AWARDS_CEREMONY_SEAN, $0700, $0500 ; $5df6
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_73_19, $0f00, $0780 ; $5e01
	script_face ACTOR_AWARDS_CEREMONY_SEAN, FACE_DOWN ; $5e0c
	script_face ACTOR_AWARDS_CEREMONY_WALK_73_19, FACE_DOWN ; $5e13
	ld a, $1e ; $5e1a
	call DelayFrames ; $5e1c
	script_move_player $0c00, $1100 ; $5e1f
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, $0c00, $1700 ; $5e29
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5e34
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, $0c00, $1300 ; $5e39
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5e44
	ret ; $5e49
AwardsCeremonySwapActors_0f:
	script_set_objdef OBJ_WALK_77_07, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5e4a
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $01 ; $5e56
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_WALK_77_07_3 ; $5e5d
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $01 ; $5e69
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $1100, $1600 ; $5e70
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1100, $1500 ; $5e7b
	script_face ACTOR_AWARDS_CEREMONY_WALK_77_07_3, FACE_UP ; $5e86
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $08 ; $5e8d
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1100, $1200 ; $5e94
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $1100, $1300 ; $5e9f
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_77_07_3 ; $5eaa
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5eaf
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $01 ; $5ebb
	script_set_objdef OBJ_WALK_77_07, ACTOR_AWARDS_CEREMONY_WALK_77_07_3 ; $5ec2
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $01 ; $5ece
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1100, $1300 ; $5ed5
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $1000, $1300 ; $5ee0
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_LEFT ; $5eeb
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $08 ; $5ef2
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1000, $1300 ; $5ef9
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_77_07_3, $0f00, $1300 ; $5f04
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_77_07_3 ; $5f0f
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5f14
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1100, $1300 ; $5f1b
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5f26
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5f2b
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $0020 ; $5f32
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, $1100, $1600 ; $5f3a
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5f45
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $5f4a
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
