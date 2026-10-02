ActorScript_0e_12:
	; $647e, 19 bytes (actor_script)
	as_set_target 16.0, 13.0
	as_wait_move
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_13:
	; $6491, 19 bytes (actor_script)
	as_set_target 16.0, 13.0
	as_wait_move
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceRight_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $64a4
	script_set_speed ACTOR_PARTNER, $0018 ; $64ac
	test_flag FLAG_DOUBLES ; $64b4
	jr nz, .doubles ; $64b7
	script_move_target ACTOR_PLAYER, 16.0, 13.0 ; $64b9
	script_wait_move ACTOR_PLAYER ; $64c4
	script_move_target ACTOR_PLAYER, 18.0, 13.0 ; $64c9
	script_wait_move ACTOR_PLAYER ; $64d4
	script_face ACTOR_PLAYER, FACE_UP ; $64d9
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $64e0
	jp PromptExhibitionMatch ; $64e7
.doubles:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $64ea
	call MoveDoublesPartnerToPlayer ; $64f5
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $64f8
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_12 ; $64ff
	script_wait_frames $14 ; $650a
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_13 ; $6511
	script_wait_actor_script ACTOR_PLAYER ; $651c
	script_wait_actor_script ACTOR_PARTNER ; $6521
	jp PromptExhibitionMatch ; $6526
ActorScript_0e_14:
	; $6529, 19 bytes (actor_script)
	as_set_target 20.0, 13.0
	as_wait_move
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_15:
	; $653c, 19 bytes (actor_script)
	as_set_target 20.0, 13.0
	as_wait_move
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceLeft_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $654f
	script_set_speed ACTOR_PARTNER, $0018 ; $6557
	test_flag FLAG_DOUBLES ; $655f
	jr nz, .doubles ; $6562
	script_move_target ACTOR_PLAYER, 20.0, 13.0 ; $6564
	script_wait_move ACTOR_PLAYER ; $656f
	script_move_target ACTOR_PLAYER, 18.0, 13.0 ; $6574
	script_wait_move ACTOR_PLAYER ; $657f
	script_face ACTOR_PLAYER, FACE_UP ; $6584
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $658b
	jp PromptExhibitionMatch ; $6592
.doubles:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $6595
	call MoveDoublesPartnerToPlayer ; $65a0
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $65a3
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_14 ; $65aa
	script_wait_frames $14 ; $65b5
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_15 ; $65bc
	script_wait_actor_script ACTOR_PLAYER ; $65c7
	script_wait_actor_script ACTOR_PARTNER ; $65cc
	jp PromptExhibitionMatch ; $65d1
PromptExhibitionMatch:
	farcall BeginCutsceneScriptMode ; $65d4
	script_player_speed $0018 ; $65d7
	script_move_player 18.0, 13.0 ; $65dd
	farcall WaitPlayerMoveDone ; $65e7
	ld a, $02 ; $65ea
	ld [wMapScratch + 2], a ; $65ec
	ld hl, wMapScratch ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	test_flag FLAG_DOUBLES ; $65f8
	jr z, .prompt ; $65fb
	ld a, $05 ; $65fd
	ld [wMapScratch + 2], a ; $65ff
	ld hl, wMapScratch ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
.prompt:
	ld hl, wMapScratch ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	farcall InitDialogueTextCursor ; $6611
	script_speak_restore ACTOR_MARIO_WORLD_PEACH ; $6614
	farcall RunDialogueYesNoPrompt ; $6619
	farcall ScriptCloseDialogueWindow ; $661c
	script_wait_frames $05 ; $661f
	and a ; $6626
	jr z, .accepted ; $6627
	script_speak ACTOR_MARIO_WORLD_PEACH ; $6629
	test_flag FLAG_DOUBLES ; $662e
	jr z, .declined ; $6631
	script_get_actor_state ACTOR_PARTNER ; $6633
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, wActors ; $663a
	farcall AttachActorStepMover ; $663d
.declined:
	farcall EndCutsceneScriptMode ; $6640
	ret ; $6643
.accepted:
	ld a, [wMapSceneStage] ; $6644
	and $01 ; $6647
	jr z, .startMatchScene ; $6649
	farcall AdvanceDialogueTextCursor ; $664b
	script_speak ACTOR_MARIO_WORLD_PEACH ; $664e
	ld hl, Text_5e_136 ; $6653
	ld de, $0101 ; $6656
	ld a, $01 ; $6659
	farcall RunPagedTextMenu ; $665b
	cp $ff ; $665e
	jp z, .prompt ; $6660
	inc a ; $6663
	test_flag FLAG_DOUBLES ; $6664
	jr z, .storeSelection ; $6667
	add $03 ; $6669
.storeSelection:
	ld [wMapScratch + 2], a ; $666b
.startMatchScene:
	ld hl, wMapScratch ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add l ; $6676
	ld l, a ; $6677
	jr nc, .speakConfirm ; $6678
	inc h ; $667a
.speakConfirm:
	farcall InitDialogueTextCursor ; $667b
	script_speak ACTOR_MARIO_WORLD_PEACH ; $667e
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_UP ; $6683
	script_wait_frames $04 ; $668a
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $6691
	script_wait_frames $04 ; $6698
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $669f
	script_wait_frames $04 ; $66a6
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_UP ; $66ad
	script_wait_frames $04 ; $66b4
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_UP ; $66bb
	script_wait_frames $04 ; $66c2
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $66c9
	script_wait_frames $0a ; $66d0
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $66d7
	script_set_anim ACTOR_MARIO_WORLD_WARIO, ANIM_NOD ; $66de
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_NOD ; $66e5
	script_set_anim ACTOR_MARIO_WORLD_WALK_77_05, ANIM_NOD ; $66ec
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $66f3
	script_set_anim ACTOR_MARIO_WORLD_LUIGI, ANIM_NOD ; $66fa
	script_set_anim ACTOR_MARIO_WORLD_BABY_MARIO, ANIM_NOD ; $6701
	script_set_anim ACTOR_MARIO_WORLD_YOSHI, ANIM_NOD ; $6708
	script_set_anim ACTOR_MARIO_WORLD_DK, ANIM_NOD ; $670f
	script_set_anim ACTOR_MARIO_WORLD_TOAD, ANIM_NOD ; $6716
	script_wait_idle ACTOR_MARIO_WORLD_TOAD ; $671d
	script_player_speed $0018 ; $6722
	script_move_player 21.0, 13.0 ; $6728
	script_set_speed ACTOR_MARIO_WORLD_PEACH, $0020 ; $6732
	script_set_speed ACTOR_MARIO_WORLD_BOWSER, $0020 ; $673a
	script_set_speed ACTOR_MARIO_WORLD_WARIO, $0020 ; $6742
	script_set_speed ACTOR_MARIO_WORLD_WALUIGI, $0020 ; $674a
	script_set_speed ACTOR_MARIO_WORLD_WALK_77_05, $0020 ; $6752
	script_set_speed ACTOR_MARIO_WORLD_MARIO, $0020 ; $675a
	script_set_speed ACTOR_MARIO_WORLD_LUIGI, $0020 ; $6762
	script_set_speed ACTOR_MARIO_WORLD_BABY_MARIO, $0020 ; $676a
	script_set_speed ACTOR_MARIO_WORLD_YOSHI, $0020 ; $6772
	script_set_speed ACTOR_MARIO_WORLD_BOO, $0020 ; $677a
	script_set_speed ACTOR_MARIO_WORLD_DK, $0020 ; $6782
	script_set_speed ACTOR_MARIO_WORLD_TOAD, $0020 ; $678a
	script_set_speed ACTOR_PLAYER, $0020 ; $6792
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_RIGHT ; $679a
	script_wait_frames $0a ; $67a1
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_RIGHT ; $67a8
	script_wait_frames $0a ; $67af
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_RIGHT ; $67b6
	script_wait_frames $14 ; $67bd
	script_set_actor_script ACTOR_MARIO_WORLD_MARIO, ActorScript_0e_06 ; $67c4
	script_wait_frames $14 ; $67cf
	script_set_actor_script ACTOR_MARIO_WORLD_PEACH, ActorScript_0e_06 ; $67d6
	script_wait_frames $14 ; $67e1
	script_set_actor_script ACTOR_MARIO_WORLD_WALK_77_05, ActorScript_0e_06 ; $67e8
	script_wait_frames $64 ; $67f3
	test_flag FLAG_DOUBLES ; $67fa
	jr nz, .doublesWalk ; $67fd
	script_move_target ACTOR_PLAYER, 18.0, 9.0 ; $67ff
	jr .crowdFollows ; $680a
.doublesWalk:
	script_set_speed ACTOR_PARTNER, $0020 ; $680c
	script_move_target ACTOR_PLAYER, 17.0, 9.0 ; $6814
	script_move_target ACTOR_PARTNER, 19.0, 9.0 ; $681f
.crowdFollows:
	script_set_actor_script ACTOR_MARIO_WORLD_LUIGI, ActorScript_0e_06 ; $682a
	script_set_actor_script ACTOR_MARIO_WORLD_BABY_MARIO, ActorScript_0e_06 ; $6835
	script_set_actor_script ACTOR_MARIO_WORLD_YOSHI, ActorScript_0e_06 ; $6840
	script_set_actor_script ACTOR_MARIO_WORLD_DK, ActorScript_0e_06 ; $684b
	script_set_actor_script ACTOR_MARIO_WORLD_BOO, ActorScript_0e_06 ; $6856
	script_wait_frames $1e ; $6861
	script_face ACTOR_PLAYER, FACE_DOWN ; $6868
	test_flag FLAG_DOUBLES ; $686f
	jr z, .dismissCrowd ; $6872
	script_face ACTOR_PARTNER, FACE_DOWN ; $6874
.dismissCrowd:
	script_set_actor_script ACTOR_MARIO_WORLD_BOWSER, ActorScript_0e_06 ; $687b
	script_wait_frames $28 ; $6886
	script_set_actor_script ACTOR_MARIO_WORLD_WARIO, ActorScript_0e_06 ; $688d
	script_wait_frames $14 ; $6898
	script_set_actor_script ACTOR_MARIO_WORLD_WALUIGI, ActorScript_0e_06 ; $689f
	script_wait_actor_script ACTOR_MARIO_WORLD_WALUIGI ; $68aa
	script_move_player 18.0, 13.0 ; $68af
	test_flag FLAG_DOUBLES ; $68b9
	jr nz, .doublesApproach ; $68bc
	script_move_target ACTOR_PLAYER, 18.0, 11.0 ; $68be
	jr .coachArrives ; $68c9
.doublesApproach:
	script_move_target ACTOR_PLAYER, 17.0, 11.0 ; $68cb
	script_move_target ACTOR_PARTNER, 19.0, 11.0 ; $68d6
.coachArrives:
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 13.0 ; $68e1
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $68ec
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_UP ; $68f1
	script_wait_frames $14 ; $68f8
	script_speak ACTOR_MARIO_WORLD_TOAD ; $68ff
	script_wait_frames $0a ; $6904
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $690b
	test_flag FLAG_DOUBLES ; $6912
	jr z, .bothReady ; $6915
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $6917
.bothReady:
	script_wait_idle ACTOR_PLAYER ; $691e
	script_wait_frames $14 ; $6923
	script_set_actor_script ACTOR_MARIO_WORLD_TOAD, ActorScript_0e_07 ; $692a
	script_wait_frames $14 ; $6935
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_07 ; $693c
	test_flag FLAG_DOUBLES ; $6947
	jr z, .leave ; $694a
	script_wait_frames $28 ; $694c
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_07 ; $6953
.leave:
	script_move_player 21.0, 13.0 ; $695e
	script_wait_actor_script ACTOR_PLAYER ; $6968
	call PlayStarWarpTransition ; $696d
	ld a, STORYLOC_SPECIAL_COURT ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wMapScratch + 2] ; $6975
	ld [wStoryModeEntryPoint], a ; $6978
	ld a, $ff ; $697b
	ld [wUnusedExitTriggerIdMirror], a ; $697d
	ld [wStoryModeExitTriggerRequest], a ; $6980
	farcall EndCutsceneScriptMode ; $6983
	ret ; $6986
MoveDoublesPartnerToPlayer:
	wram_bank WRAM_ACTORS ; $6987
	script_get_actor_state ACTOR_PLAYER ; $698d
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, ACTORF_Y ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, ACTORF_X ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	farcall ScriptSetActorMoveTarget ; $69a4
	script_wait_move ACTOR_PARTNER ; $69a7
	ret ; $69ac
.checkDoubles:
	test_flag FLAG_DOUBLES ; $69ad
	jp nz, .doubles ; $69b0
.singles:
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $69b3
	ret z ; $69b6
	script_set_position ACTOR_PLAYER, 18.0, 15.0 ; $69b7
	jp .placeActors ; $69c2
.doubles:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $69c5
	ret z ; $69c8
	farcall BeginCutsceneScriptMode ; $69c9
	script_player_speed $0010 ; $69cc
	script_move_player 17.0, 15.0 ; $69d2
	farcall WaitPlayerMoveDone ; $69dc
	script_set_position ACTOR_PLAYER, 17.0, 15.0 ; $69df
	script_set_position ACTOR_PARTNER, 19.0, 15.0 ; $69ea
	farcall EndCutsceneScriptMode ; $69f5
	jp .placeActors ; $69f8
.placeActors:
	script_set_position ACTOR_MARIO_WORLD_PEACH, 18.0, 11.0 ; $69fb
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $6a06
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $6a0d
	script_face ACTOR_MARIO_WORLD_BOO, FACE_RIGHT ; $6a14
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $6a1b
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_LEFT ; $6a22
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_LEFT ; $6a29
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_LEFT ; $6a30
	script_face ACTOR_MARIO_WORLD_DK, FACE_LEFT ; $6a37
	script_set_position ACTOR_MARIO_WORLD_TOAD, 13.0, 19.0 ; $6a3e
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_RIGHT ; $6a49
	ret ; $6a50
MarioWorldArrivalIntroCutscene:
	script_player_speed $0020 ; $6a51
	script_move_player 18.0, 15.0 ; $6a57
	farcall WaitPlayerMoveDone ; $6a61
	script_wait_frames $28 ; $6a64
	script_player_speed $0040 ; $6a6b
	script_move_player 18.0, 25.0 ; $6a71
	farcall WaitPlayerMoveDone ; $6a7b
	sound SFX_CHIME ; $6a7e
	script_set_position ACTOR_MARIO_WORLD_BALLOON_EXCLAIM, 16.0, 29.0 ; $6a80
	script_wait_frames $0a ; $6a8b
	script_jump_velocity ACTOR_MARIO_WORLD_TOAD, $ff80 ; $6a92
	script_jump_velocity ACTOR_MARIO_WORLD_BALLOON_EXCLAIM, $ff80 ; $6a9a
	script_wait_frames $1e ; $6aa2
	script_set_position ACTOR_MARIO_WORLD_BALLOON_EXCLAIM, 63.0, 63.0 ; $6aa9
	script_set_speed ACTOR_MARIO_WORLD_TOAD, $0040 ; $6ab4
	ld a, $13 ; $6abc
	ld bc, $0300 ; $6abe
	ld de, rJOYP ; $6ac1
	farcall MoveActorByDelta ; $6ac4
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $6ac7
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_DOWN ; $6acc
	ret ; $6ad3
MarioWorldWelcomeCutscene:
	script_wait_frames $0a ; $6ad4
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6adb
	script_wait_frames $04 ; $6ae2
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $6ae9
	script_wait_frames $04 ; $6af0
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $6af7
	script_wait_frames $04 ; $6afe
	script_face ACTOR_MARIO_WORLD_BOO, FACE_RIGHT ; $6b05
	script_wait_frames $04 ; $6b0c
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $6b13
	script_wait_frames $04 ; $6b1a
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_LEFT ; $6b21
	script_wait_frames $04 ; $6b28
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_LEFT ; $6b2f
	script_wait_frames $04 ; $6b36
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_LEFT ; $6b3d
	script_wait_frames $04 ; $6b44
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_UP ; $6b4b
	script_wait_frames $04 ; $6b52
	script_face ACTOR_MARIO_WORLD_DK, FACE_UP ; $6b59
	script_wait_frames $14 ; $6b60
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $6b67
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $6b6e
	script_speak ACTOR_MARIO_WORLD_PEACH ; $6b73
	script_wait_frames $14 ; $6b78
	script_set_anim ACTOR_MARIO_WORLD_WALK_77_05, ANIM_NOD ; $6b7f
	script_wait_idle ACTOR_MARIO_WORLD_WALK_77_05 ; $6b86
	script_speak ACTOR_MARIO_WORLD_WALK_77_05 ; $6b8b
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_LEFT ; $6b90
	script_wait_frames $0a ; $6b97
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_RIGHT ; $6b9e
	script_wait_frames $14 ; $6ba5
	script_set_anim ACTOR_MARIO_WORLD_WALK_77_05, ANIM_NOD ; $6bac
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $6bb3
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $6bba
	script_wait_frames $0a ; $6bbf
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6bc6
	script_wait_frames $0a ; $6bcd
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_DOWN ; $6bd4
	script_wait_frames $1e ; $6bdb
	script_speak ACTOR_MARIO_WORLD_PEACH ; $6be2
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_RIGHT ; $6be7
	script_wait_frames $0a ; $6bee
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_LEFT ; $6bf5
	script_wait_frames $14 ; $6bfc
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $6c03
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $6c0a
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $6c11
	script_wait_frames $0a ; $6c16
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6c1d
	script_wait_frames $0a ; $6c24
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_DOWN ; $6c2b
	script_wait_frames $1e ; $6c32
	script_speak ACTOR_MARIO_WORLD_PEACH ; $6c39
	script_wait_frames $14 ; $6c3e
	script_jump_velocity ACTOR_MARIO_WORLD_WARIO, $ff80 ; $6c45
	script_wait_frames $14 ; $6c4d
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $6c54
	script_set_anim ACTOR_MARIO_WORLD_WARIO, ANIM_BOUNCE ; $6c5b
	script_wait_idle ACTOR_MARIO_WORLD_WARIO ; $6c62
	script_speak ACTOR_MARIO_WORLD_WARIO ; $6c67
	script_wait_frames $0a ; $6c6c
	script_jump_velocity ACTOR_MARIO_WORLD_WALUIGI, $ff40 ; $6c73
	script_wait_frames $28 ; $6c7b
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $6c82
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_BOUNCE ; $6c89
	script_wait_idle ACTOR_MARIO_WORLD_WALUIGI ; $6c90
	script_speak ACTOR_MARIO_WORLD_WALUIGI ; $6c95
	script_wait_frames $14 ; $6c9a
	sound SFX_APPEAR2 ; $6ca1
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 15.0, 9.0 ; $6ca3
	script_wait_frames $04 ; $6cae
	sound SFX_APPEAR2 ; $6cb5
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 19.0, 7.0 ; $6cb7
	script_wait_frames $04 ; $6cc2
	sound SFX_APPEAR2 ; $6cc9
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_3, 23.0, 9.0 ; $6ccb
	script_wait_frames $28 ; $6cd6
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_LEFT ; $6cdd
	script_wait_frames $0a ; $6ce4
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_RIGHT ; $6ceb
	script_wait_frames $28 ; $6cf2
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_RIGHT ; $6cf9
	script_wait_frames $0a ; $6d00
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_LEFT ; $6d07
	script_wait_frames $3c ; $6d0e
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 14.0, 15.0 ; $6d15
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $6d20
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $6d25
	script_wait_frames $04 ; $6d2c
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_DOWN ; $6d33
	script_wait_frames $04 ; $6d3a
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $6d41
	script_wait_frames $04 ; $6d48
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_DOWN ; $6d4f
	script_wait_frames $14 ; $6d56
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 63.0, 63.0 ; $6d5d
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 63.0, 63.0 ; $6d68
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_3, 63.0, 63.0 ; $6d73
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $6d7e
	script_wait_frames $0a ; $6d83
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_SHAKE ; $6d8a
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $6d91
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $6d96
	sound SFX_APPEAR1 ; $6d9d
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 15.0, 13.0 ; $6d9f
	script_wait_frames $14 ; $6daa
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $6db1
	ret ; $6db6
MarioWorldLuigiDefendsChampCutscene:
	script_jump_velocity ACTOR_MARIO_WORLD_LUIGI, $ff80 ; $6db7
	script_wait_frames $14 ; $6dbf
	script_speak ACTOR_MARIO_WORLD_LUIGI ; $6dc6
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 63.0, 63.0 ; $6dcb
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 63.0, 63.0 ; $6dd6
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_3, 63.0, 63.0 ; $6de1
	script_wait_frames $0a ; $6dec
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $6df3
	script_wait_frames $04 ; $6dfa
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $6e01
	script_wait_frames $04 ; $6e08
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $6e0f
	script_wait_frames $04 ; $6e16
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_RIGHT ; $6e1d
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_UP ; $6e24
	script_wait_frames $04 ; $6e2b
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_RIGHT ; $6e32
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_UP ; $6e39
	script_set_speed ACTOR_MARIO_WORLD_LUIGI, $0020 ; $6e40
	script_move_target ACTOR_MARIO_WORLD_LUIGI, 22.0, 13.0 ; $6e48
	script_wait_move ACTOR_MARIO_WORLD_LUIGI ; $6e53
	script_wait_frames $0a ; $6e58
	script_speak ACTOR_MARIO_WORLD_LUIGI ; $6e5f
	script_wait_frames $0a ; $6e64
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $6e6b
	sound SFX_APPEAR1 ; $6e72
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 18.0, 11.0 ; $6e74
	script_wait_frames $0a ; $6e7f
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_BOUNCE ; $6e86
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $6e8d
	script_wait_frames $0a ; $6e92
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $6e99
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $6e9e
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $6ea5
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 63.0, 63.0 ; $6eac
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 19.0, 13.0 ; $6eb7
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $6ec2
	script_wait_frames $0a ; $6ec7
	script_face ACTOR_MARIO_WORLD_BABY_MARIO, FACE_LEFT ; $6ece
	script_move_target ACTOR_MARIO_WORLD_WARIO, 17.0, 13.0 ; $6ed5
	script_wait_frames $0a ; $6ee0
	script_face ACTOR_MARIO_WORLD_YOSHI, FACE_LEFT ; $6ee7
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 19.0, 15.0 ; $6eee
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $6ef9
	script_wait_frames $0a ; $6efe
	script_lock_facing ACTOR_MARIO_WORLD_LUIGI ; $6f05
	script_move_target ACTOR_MARIO_WORLD_LUIGI, 24.0, 13.0 ; $6f0c
	script_wait_move ACTOR_MARIO_WORLD_LUIGI ; $6f17
	script_face ACTOR_MARIO_WORLD_LUIGI, FACE_LEFT ; $6f1c
	script_unlock_facing ACTOR_MARIO_WORLD_LUIGI ; $6f23
	ret ; $6f2a
MarioWorldExhibitionDemandCutscene:
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $6f2b
	script_wait_frames $0a ; $6f32
	script_speak ACTOR_MARIO_WORLD_WARIO ; $6f39
	script_wait_frames $0a ; $6f3e
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_DOWN ; $6f45
	script_wait_frames $0a ; $6f4c
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $6f53
	script_wait_frames $28 ; $6f5a
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $6f61
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_NOD ; $6f68
	script_wait_idle ACTOR_MARIO_WORLD_WALUIGI ; $6f6f
	script_wait_frames $0a ; $6f74
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $6f7b
	script_wait_frames $04 ; $6f82
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $6f89
	script_wait_frames $0a ; $6f90
	script_jump_velocity ACTOR_MARIO_WORLD_WALUIGI, $ff40 ; $6f97
	script_wait_frames $28 ; $6f9f
	script_speak ACTOR_MARIO_WORLD_WALUIGI ; $6fa6
	script_wait_frames $0a ; $6fab
	sound SFX_APPEAR2 ; $6fb2
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 19.0, 9.0 ; $6fb4
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 23.0, 9.0 ; $6fbf
	script_wait_frames $14 ; $6fca
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_RIGHT ; $6fd1
	script_wait_frames $0a ; $6fd8
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_LEFT ; $6fdf
	script_wait_frames $14 ; $6fe6
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 63.0, 63.0 ; $6fed
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 63.0, 63.0 ; $6ff8
	script_wait_frames $14 ; $7003
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $700a
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $7011
	script_wait_idle ACTOR_MARIO_WORLD_MARIO ; $7018
	script_wait_frames $0a ; $701d
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $7024
	script_wait_frames $0a ; $702b
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_DOWN ; $7032
	script_speak ACTOR_MARIO_WORLD_PEACH ; $7039
	script_wait_frames $14 ; $703e
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_NOD ; $7045
	script_set_anim ACTOR_MARIO_WORLD_WARIO, ANIM_NOD ; $704c
	script_set_anim ACTOR_MARIO_WORLD_WALUIGI, ANIM_NOD ; $7053
	script_wait_idle ACTOR_MARIO_WORLD_WALUIGI ; $705a
	script_wait_frames $14 ; $705f
	script_jump_velocity ACTOR_MARIO_WORLD_WARIO, $ff80 ; $7066
	script_wait_frames $28 ; $706e
	script_speak ACTOR_MARIO_WORLD_WARIO ; $7075
	script_wait_frames $0a ; $707a
	ret ; $7081
