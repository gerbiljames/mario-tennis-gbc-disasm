RunPlayDoublesTodayPrompt:
	test_flag FLAG_DOUBLES ; $56bb
	jp nz, .accepted ; $56be
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $56c1
	jr nz, .altText ; $56c4
	script_set_text Text_31_310 ; $56c6
	jr .prompt ; $56cc
.altText:
	script_set_text Text_31_304 ; $56ce
.prompt:
	script_speak_restore ACTOR_DORM_ROOM_KATE ; $56d4
	farcall RunDialogueYesNoPrompt ; $56d9
	farcall ScriptCloseDialogueWindow ; $56dc
	script_wait_frames $05 ; $56df
	and a ; $56e6
	jr nz, .declined ; $56e7
	set_flag FLAG_DOUBLES ; $56e9
	call SetRoommateDoublesYesReplyText_13 ; $56ec
	script_speak ACTOR_DORM_ROOM_KATE ; $56ef
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $56f4
	script_wait_idle ACTOR_PLAYER ; $56fb
	script_wait_frames $05 ; $5700
	script_face ACTOR_PLAYER, FACE_DOWN ; $5707
	wram_bank WRAM_ACTORS ; $570e
	ld a, $01 ; $5714
	ld [wMatchIsDoubles], a ; $5716
	call SetDormRoomEventTriggerCells_13 ; $5719
	script_wait_frames $05 ; $571c
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5723
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, wActors ; $572a
	farcall AttachActorStepMover ; $572d
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5730
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, ACTORF_FLAGS ; $5737
	add hl, bc ; $573a
	set ACTORFLAGB_TALKABLE, [hl] ; $573b
	script_wait_frames $05 ; $573d
	script_face ACTOR_PLAYER, FACE_DOWN ; $5744
	ret ; $574b
.declined:
	call SetRoommateDoublesNoReplyText_13 ; $574c
	farcall AdvanceDialogueTextCursor ; $574f
	script_speak ACTOR_DORM_ROOM_KATE ; $5752
	clear_flag FLAG_DOUBLES ; $5757
	wram_bank WRAM_ACTORS ; $575a
	ld a, $00 ; $5760
	ld [wMatchIsDoubles], a ; $5762
	script_null_script ACTOR_DORM_ROOM_KATE ; $5765
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $576a
	ld c, l ; $576f
	ld b, h ; $5770
	ld hl, ACTORF_FLAGS ; $5771
	add hl, bc ; $5774
	set ACTORFLAGB_SOLID, [hl] ; $5775
	call SetDormRoomEventTriggerCells_13 ; $5777
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $577a
	ret ; $5781
.accepted:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5782
	jr nz, .acceptedAlt ; $5785
	script_set_text Text_31_313 ; $5787
	jr .setUpDoubles ; $578d
.acceptedAlt:
	script_set_text Text_31_307 ; $578f
.setUpDoubles:
	script_speak_restore ACTOR_DORM_ROOM_KATE ; $5795
	farcall RunDialogueYesNoPrompt ; $579a
	farcall ScriptCloseDialogueWindow ; $579d
	script_wait_frames $05 ; $57a0
	and a ; $57a7
	jr nz, .done ; $57a8
	call SetRoommateSinglesYesReplyText_13 ; $57aa
	script_speak ACTOR_DORM_ROOM_KATE ; $57ad
	script_null_script ACTOR_DORM_ROOM_KATE ; $57b2
	clear_flag FLAG_DOUBLES ; $57b7
	wram_bank WRAM_ACTORS ; $57ba
	ld a, $00 ; $57c0
	ld [wMatchIsDoubles], a ; $57c2
	script_move_target ACTOR_DORM_ROOM_KATE, 11.0, 9.0 ; $57c5
	script_wait_move ACTOR_DORM_ROOM_KATE ; $57d0
	script_wait_frames $05 ; $57d5
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $57dc
	script_wait_frames $05 ; $57e3
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $57ea
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, ACTORF_FLAGS ; $57f1
	add hl, bc ; $57f4
	set ACTORFLAGB_SOLID, [hl] ; $57f5
	call SetDormRoomEventTriggerCells_13 ; $57f7
	script_null_script ACTOR_DORM_ROOM_KATE ; $57fa
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $57ff
	ret ; $5806
.done:
	call SetRoommateSinglesNoReplyText_13 ; $5807
	farcall AdvanceDialogueTextCursor ; $580a
	script_speak ACTOR_DORM_ROOM_KATE ; $580d
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5812
	script_wait_idle ACTOR_PLAYER ; $5819
	script_face ACTOR_PLAYER, FACE_DOWN ; $581e
	script_wait_frames $05 ; $5825
	wram_bank WRAM_ACTORS ; $582c
	ld a, $01 ; $5832
	ld [wMatchIsDoubles], a ; $5834
	set_flag FLAG_DOUBLES ; $5837
	call SetDormRoomEventTriggerCells_13 ; $583a
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $583d
	ld c, l ; $5842
	ld b, h ; $5843
	ld de, wActors ; $5844
	farcall AttachActorStepMover ; $5847
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $584a
	ld c, l ; $584f
	ld b, h ; $5850
	ld hl, ACTORF_FLAGS ; $5851
	add hl, bc ; $5854
	set ACTORFLAGB_TALKABLE, [hl] ; $5855
	script_face ACTOR_PLAYER, FACE_DOWN ; $5857
	ret ; $585e
ActorScript_13_00:
	; $585f, 24 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait $b4
	as_rand_box $02, $02
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $b4
	as_jump .L1
ActorScript_13_01:
	; $5877, 10 bytes (actor_script)
	as_set_pos 15.25, 14.875
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_02:
	; $5881, 10 bytes (actor_script)
	as_set_pos 17.0, 3.5
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_03:
	; $588b, 51 bytes (actor_script)
	as_set_pos 3.0, 7.0
	as_set_field ACTORF_HEADING, FACE_UP
	as_begin_path
.La:
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait $b4
	as_set_target 3.0, 8.0
	as_wait_move2
	as_wait $50
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_wait $12
	as_set_target 3.0, 7.0
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait $f0
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_wait $12
	as_jump .La
RunAcademyQuestionsMenu:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $58be
	jr z, .variantB ; $58c1
	ld hl, wMapScratch ; $58c3
	ld de, $054f ; $58c6
	jr .menuLoop ; $58c9
.variantB:
	ld hl, wMapScratch ; $58cb
	ld de, $0808 ; $58ce
.menuLoop:
	ld a, e ; $58d1
	ld [hl+], a ; $58d2
	ld [hl], d ; $58d3
	ld hl, Text_31_332 ; $58d4
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $58d7
	jr z, .runMenu ; $58da
	ld hl, Text_31_333 ; $58dc
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $58df
	jr z, .runMenu ; $58e2
	ld hl, Text_31_334 ; $58e4
.runMenu:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	farcall RunPagedTextMenu ; $58ec
	cp $ff ; $58ef
	jp z, .done ; $58f1
	add a ; $58f4
	ld_hl_indexed AcademyTopicHandlerTable ; $58f5
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	script_speak ACTOR_DORM_ROOM_KATE ; $5902
	ld hl, wMapScratch ; $5907
	ld a, [hl+] ; $590a
	ld h, [hl] ; $590b
	ld l, a ; $590c
	farcall InitDialogueTextCursor ; $590d
	script_speak_restore ACTOR_DORM_ROOM_KATE ; $5910
	farcall RunDialogueYesNoPrompt ; $5915
	farcall ScriptCloseDialogueWindow ; $5918
	script_wait_frames $05 ; $591b
	and a ; $5922
	jr nz, .done ; $5923
	jr .menuLoop ; $5925
.done:
	ret ; $5927
AcademyTopicHandlerTable:
	; $5928, 14 bytes (records:2)
	dw AcademyTopicSinglesRank ; record 0
	dw AcademyTopicDoublesRank ; record 1
	dw AcademyTopicRules ; record 2
	dw AcademyTopicClassRank ; record 3
	dw AcademyTopicVarsity ; record 4
	dw AcademyTopicIslandOpen ; record 5
	dw AcademyTopicTopRanked ; record 6
AcademyTopicSinglesRank:
	ld de, $0001 ; $5936
	ld hl, wMapScratch ; $5939
	ld a, [hl+] ; $593c
	ld h, [hl] ; $593d
	ld l, a ; $593e
	add hl, de ; $593f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $5940
	jr z, .setCursor ; $5943
	ld a, $01 ; $5945
	add l ; $5947
	ld l, a ; $5948
	jr nc, .rank2 ; $5949
	inc h ; $594b
.rank2:
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $594c
	jr z, .setCursor ; $594f
	ld a, $01 ; $5951
	add l ; $5953
	ld l, a ; $5954
	jr nc, .rank3 ; $5955
	inc h ; $5957
.rank3:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $5958
	jr z, .setCursor ; $595b
	ld a, $01 ; $595d
	add l ; $595f
	ld l, a ; $5960
	jr nc, .setCursor ; $5961
	inc h ; $5963
.setCursor:
	farcall InitDialogueTextCursor ; $5964
	ret ; $5967
AcademyTopicDoublesRank:
	ld de, $0005 ; $5968
	ld hl, wMapScratch ; $596b
	ld a, [hl+] ; $596e
	ld h, [hl] ; $596f
	ld l, a ; $5970
	add hl, de ; $5971
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5972
	jr z, .setCursor ; $5975
	ld a, $01 ; $5977
	add l ; $5979
	ld l, a ; $597a
	jr nc, .rank2 ; $597b
	inc h ; $597d
.rank2:
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $597e
	jr z, .setCursor ; $5981
	ld a, $01 ; $5983
	add l ; $5985
	ld l, a ; $5986
	jr nc, .rank3 ; $5987
	inc h ; $5989
.rank3:
	test_flag FLAG_WON_VARSITY_DOUBLES_RANK_2 ; $598a
	jr z, .setCursor ; $598d
	ld a, $01 ; $598f
	add l ; $5991
	ld l, a ; $5992
	jr nc, .rank4 ; $5993
	inc h ; $5995
.rank4:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $5996
	jr z, .setCursor ; $5999
	ld a, $01 ; $599b
	add l ; $599d
	ld l, a ; $599e
	jr nc, .setCursor ; $599f
	inc h ; $59a1
.setCursor:
	farcall InitDialogueTextCursor ; $59a2
	ret ; $59a5
AcademyTopicRules:
	ld de, $000a ; $59a6
	ld hl, wMapScratch ; $59a9
	ld a, [hl+] ; $59ac
	ld h, [hl] ; $59ad
	ld l, a ; $59ae
	add hl, de ; $59af
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $59b0
	jr z, .setCursor ; $59b3
	ld a, $01 ; $59b5
	add l ; $59b7
	ld l, a ; $59b8
	jr nc, .setCursor ; $59b9
	inc h ; $59bb
.setCursor:
	farcall InitDialogueTextCursor ; $59bc
	ret ; $59bf
AcademyTopicClassRank:
	ld de, $000c ; $59c0
	ld hl, wMapScratch ; $59c3
	ld a, [hl+] ; $59c6
	ld h, [hl] ; $59c7
	ld l, a ; $59c8
	add hl, de ; $59c9
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $59ca
	jr z, .setCursor ; $59cd
	ld a, $01 ; $59cf
	add l ; $59d1
	ld l, a ; $59d2
	jr nc, .rank2 ; $59d3
	inc h ; $59d5
.rank2:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $59d6
	jr z, .setCursor ; $59d9
	ld a, $01 ; $59db
	add l ; $59dd
	ld l, a ; $59de
	jr nc, .setCursor ; $59df
	inc h ; $59e1
.setCursor:
	farcall InitDialogueTextCursor ; $59e2
	ret ; $59e5
AcademyTopicVarsity:
	ld de, $000f ; $59e6
	ld hl, wMapScratch ; $59e9
	ld a, [hl+] ; $59ec
	ld h, [hl] ; $59ed
	ld l, a ; $59ee
	add hl, de ; $59ef
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $59f0
	jr z, .setCursor ; $59f3
	ld a, $01 ; $59f5
	add l ; $59f7
	ld l, a ; $59f8
	jr nc, .setCursor ; $59f9
	inc h ; $59fb
.setCursor:
	farcall InitDialogueTextCursor ; $59fc
	ret ; $59ff
AcademyTopicIslandOpen:
	ld de, $0011 ; $5a00
	ld hl, wMapScratch ; $5a03
	ld a, [hl+] ; $5a06
	ld h, [hl] ; $5a07
	ld l, a ; $5a08
	add hl, de ; $5a09
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $5a0a
	jr z, .setCursor ; $5a0d
	ld a, $01 ; $5a0f
	add l ; $5a11
	ld l, a ; $5a12
	jr nc, .setCursor ; $5a13
	inc h ; $5a15
.setCursor:
	farcall InitDialogueTextCursor ; $5a16
	ret ; $5a19
AcademyTopicTopRanked:
	ld de, $0013 ; $5a1a
	ld hl, wMapScratch ; $5a1d
	ld a, [hl+] ; $5a20
	ld h, [hl] ; $5a21
	ld l, a ; $5a22
	add hl, de ; $5a23
	farcall InitDialogueTextCursor ; $5a24
	ret ; $5a27
ShowStoryNarration_13:
	sound BGM_NONE ; $5a28
	script_set_position ACTOR_DORM_ROOM_KATE, 63.0, 63.0 ; $5a2a
	script_set_position ACTOR_DORM_ROOM_CAT, 63.0, 63.0 ; $5a35
	script_set_active ACTOR_PLAYER, $00 ; $5a40
	script_set_active ACTOR_PARTNER, $00 ; $5a47
	script_copy_scene_rect $00, $20, $00, $00, $16, $18 ; $5a4e
	script_fade_in $08 ; $5a5d
	script_wait_frames $04 ; $5a62
	script_speak SPEAKER_NONE | 5 ; $5a69
	script_wait_frames $04 ; $5a6e
	ret ; $5a75
.setText:
	script_set_text Text_30_496 ; $5a76
	call ShowStoryNarration_13 ; $5a7c
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $5a7f
	ld [wStoryModeCurrentLocation], a ; $5a81
	ld a, $0a ; $5a84
	ld [wStoryModeEntryPoint], a ; $5a86
	ld a, $ff ; $5a89
	ld [wUnusedExitTriggerIdMirror], a ; $5a8b
	ld [wStoryModeExitTriggerRequest], a ; $5a8e
	ret ; $5a91
.setText2:
	script_set_text Text_30_497 ; $5a92
	call ShowStoryNarration_13 ; $5a98
	ld a, STORYLOC_TOURNAMENT_COURTYARD ; $5a9b
	ld [wStoryModeCurrentLocation], a ; $5a9d
	ld a, $0f ; $5aa0
	ld [wStoryModeEntryPoint], a ; $5aa2
	ld a, $ff ; $5aa5
	ld [wUnusedExitTriggerIdMirror], a ; $5aa7
	ld [wStoryModeExitTriggerRequest], a ; $5aaa
	ret ; $5aad
.setText3:
	script_set_text Text_30_496 ; $5aae
	call ShowStoryNarration_13 ; $5ab4
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $5ab7
	ld [wStoryModeCurrentLocation], a ; $5ab9
	ld a, $0a ; $5abc
	ld [wStoryModeEntryPoint], a ; $5abe
	ld a, $ff ; $5ac1
	ld [wUnusedExitTriggerIdMirror], a ; $5ac3
	ld [wStoryModeExitTriggerRequest], a ; $5ac6
	ret ; $5ac9
GetDormRoomStoryStage_13:
	test_flag FLAG_DOUBLES ; $5aca
	jr nz, .doubles ; $5acd
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $5acf
	jr nz, .stage2 ; $5ad2
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $5ad4
	jr nz, .stage1 ; $5ad7
.stage0:
	ld a, $00 ; $5ad9
	ret ; $5adb
.stage1:
	ld a, $01 ; $5adc
	ret ; $5ade
.stage2:
	ld a, $02 ; $5adf
	ret ; $5ae1
.doubles:
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $5ae2
	jr nz, .stage2 ; $5ae5
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $5ae7
	jr nz, .stage1 ; $5aea
	jr .stage0 ; $5aec
DormRoomArrivalCutscene_13:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5aee
	jr z, .variantB ; $5af1
	script_set_text Text_31_273 ; $5af3
	jr .placeActors ; $5af9
.variantB:
	script_set_text Text_31_268 ; $5afb
.placeActors:
	script_null_script ACTOR_PARTNER ; $5b01
	script_set_position ACTOR_PARTNER, 11.0, 30.0 ; $5b06
	script_face ACTOR_PARTNER, FACE_DOWN ; $5b11
	script_set_position ACTOR_DORM_ROOM_KATE, 11.0, 10.0 ; $5b18
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $5b23
	script_fade_in $04 ; $5b2a
	call WaitFadeEnd ; $5b2f
	test_flag FLAG_DOUBLES ; $5b32
	jr z, .singles ; $5b35
	farcall AdvanceDialogueTextCursor ; $5b37
	script_speak ACTOR_DORM_ROOM_KATE ; $5b3a
	script_speak ACTOR_DORM_ROOM_KATE ; $5b3f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b44
	script_wait_idle ACTOR_PLAYER ; $5b4b
	script_face ACTOR_PLAYER, FACE_DOWN ; $5b50
	script_wait_frames $05 ; $5b57
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5b5e
	ld c, l ; $5b63
	ld b, h ; $5b64
	ld de, wActors ; $5b65
	farcall AttachActorStepMover ; $5b68
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5b6b
	ld c, l ; $5b70
	ld b, h ; $5b71
	ld hl, ACTORF_FLAGS ; $5b72
	add hl, bc ; $5b75
	set ACTORFLAGB_TALKABLE, [hl] ; $5b76
	ret ; $5b78
.singles:
	script_speak ACTOR_DORM_ROOM_KATE ; $5b79
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b7e
	script_wait_idle ACTOR_PLAYER ; $5b85
	ret ; $5b8a
