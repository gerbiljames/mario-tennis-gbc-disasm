SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

DataPtr_RestaurantPlazaMapScripts_13:
	dw RestaurantPlazaMapScripts_13 ; $4000
DataPtr_DormRoomMapScripts_13:
	dw DormRoomMapScripts_13 ; $4002
DataPtr_CourtyardMapScripts_13:
	dw CourtyardMapScripts_13 ; $4004
RestaurantPlazaMapScripts_13:
	; $4006, 14 bytes (map_tree)
	dw RestaurantPlazaEntryPoints_13 ; slot 0 EntryPoints
	dw RestaurantPlazaExitTriggers_13 ; slot 1 ExitTriggers
	dw RestaurantPlazaActors_13 ; slot 2 Actors
	dw RestaurantPlazaNpcScripts_13 ; slot 3 NpcScripts
	dw RestaurantPlazaFacingScripts_13 ; slot 4 FacingScripts
	dw RestaurantPlazaTileTriggers_13 ; slot 5 TileTriggers
	dw RestaurantPlazaInitScript_13 ; slot 6 InitScript
RestaurantPlazaActors_13:
	; $4014, 10 bytes (map_actors)
	map_actor_end
RestaurantPlazaEntryPoints_13:
	; $401e, 65 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0700, $0840, RestaurantPlazaArrival01_13
	map_entry $02, FACE_DOWN, $1500, $0940, RestaurantPlazaArrival02_13
	map_entry $03, FACE_DOWN, $2500, $0840, RestaurantPlazaArrivalWalkIn_13
	map_entry $04, FACE_UP, $3200, $0f00, RestaurantPlazaArrival04_13
	map_entry $05, FACE_DOWN, $3700, $0840, RestaurantPlazaArrivalWalkIn_13
	map_entry $06, FACE_LEFT, $3c00, $0d00, RestaurantPlazaArrival06_13
	map_entry $0e, FACE_LEFT, $3b00, $0f00, $0000
	map_entry $0f, FACE_LEFT, $3200, $0f00, $0000
	db $ff
RestaurantPlazaArrival04_13:
	ld a, [wStoryModeEntryPoint] ; $405f
	cp $ff ; $4062
	jp z, .done ; $4064
	test_flag FLAG_DOUBLES ; $4067
	jr z, .walkOff ; $406a
	script_set_speed ACTOR_PARTNER, $00ff ; $406c
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $4074
	script_wait_move ACTOR_PARTNER ; $407e
	script_face ACTOR_PARTNER, FACE_UP ; $4083
	script_set_speed ACTOR_PARTNER, $0010 ; $408a
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4092
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $409a
.done:
	ret ; $40a4
RestaurantPlazaArrival06_13:
	ld a, [wStoryModeEntryPoint] ; $40a5
	cp $ff ; $40a8
	jp z, .done ; $40aa
	test_flag FLAG_DOUBLES ; $40ad
	jr z, .walkOff ; $40b0
	script_set_speed ACTOR_PARTNER, $00ff ; $40b2
	script_move_angle ACTOR_PARTNER, FACE_RIGHT, $0200 ; $40ba
	script_wait_move ACTOR_PARTNER ; $40c4
	script_face ACTOR_PARTNER, FACE_LEFT ; $40c9
	script_set_speed ACTOR_PARTNER, $0010 ; $40d0
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $40d8
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $40e0
.done:
	ret ; $40ea
RestaurantPlazaArrival01_13:
	ld a, [wStoryModeEntryPoint] ; $40eb
	cp $ff ; $40ee
	jp z, RestaurantPlazaArrivalWalkIn_13.done ; $40f0
	script_set_speed ACTOR_PLAYER, $0018 ; $40f3
	script_set_anim ACTOR_PLAYER, $08 ; $40fb
	script_set_speed ACTOR_PARTNER, $0018 ; $4102
	script_set_anim ACTOR_PARTNER, $08 ; $410a
	script_fade_in $08 ; $4111
	script_wait_frames $14 ; $4116
	script_move_target ACTOR_PLAYER, $0700, $0c80 ; $411d
	script_wait_frames $14 ; $4128
	script_move_target ACTOR_PARTNER, $0700, $0b00 ; $412f
	script_wait_frames $14 ; $413a
	script_set_anim ACTOR_PLAYER, $01 ; $4141
	script_wait_frames $0a ; $4148
	script_set_anim ACTOR_PARTNER, $01 ; $414f
	script_wait_move ACTOR_PLAYER ; $4156
	script_face ACTOR_PLAYER, FACE_RIGHT ; $415b
	ret ; $4162
RestaurantPlazaArrival02_13:
	ld a, [wStoryModeEntryPoint] ; $4163
	cp $ff ; $4166
	jp z, RestaurantPlazaArrivalWalkIn_13.done ; $4168
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $416b
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $417a
	script_set_speed ACTOR_PLAYER, $0018 ; $4189
	script_fade_in $08 ; $4191
	call WaitFadeEnd ; $4196
	script_wait_frames $05 ; $4199
	sound $50 ; $41a0
	script_wait_frames $05 ; $41a2
	script_move_target ACTOR_PLAYER, $1500, $0d00 ; $41a9
	script_move_target ACTOR_PARTNER, $1500, $0b00 ; $41b4
	test_flag FLAG_DOUBLES ; $41bf
	jr z, .notDoubles ; $41c2
	script_wait_frames $0c ; $41c4
.notDoubles:
	call AnimateDoorClose_13 ; $41cb
	ret ; $41ce
RestaurantPlazaArrivalWalkIn_13:
	ld a, [wStoryModeEntryPoint] ; $41cf
	cp $ff ; $41d2
	jr z, .done ; $41d4
	script_set_speed ACTOR_PLAYER, $000c ; $41d6
	script_set_anim ACTOR_PLAYER, $08 ; $41de
	script_set_speed ACTOR_PARTNER, $000c ; $41e5
	script_set_anim ACTOR_PARTNER, $08 ; $41ed
	script_fade_in $08 ; $41f4
	script_wait_frames $0a ; $41f9
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0500 ; $4200
	script_wait_frames $28 ; $420a
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0400 ; $4211
	script_set_anim ACTOR_PLAYER, $01 ; $421b
	script_wait_frames $10 ; $4222
	script_set_anim ACTOR_PARTNER, $01 ; $4229
	script_wait_move ACTOR_PLAYER ; $4230
.done:
	ret ; $4235
RestaurantPlazaExitTriggers_13:
	; $4236, 73 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_13, $09, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_13, $0d, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_13, $10, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_13, $07, $02
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_13, $0b, $01
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_13, $0f, $01
	map_script $0d, FACEMASK_ANY, $0000, MapScriptNop_13, $0c, $01
	map_script $0e, FACEMASK_ANY, $0000, MapScriptNop_13, $09, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_13, $0f, $0f
	db $ff
	script_set_text Text_35_48 ; $427f
	script_speak ACTOR_PLAYER ; $4285
	ret ; $428a
RestaurantPlazaNpcScripts_13:
	; $428b, 9 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_35_55, $00, $00
	db $ff
RestaurantPlazaFacingScripts_13:
	; $4294, 33 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Text_31_70, $00, $00
	map_script $02, FACEMASK_ANY, $0000, Text_31_71, $00, $00
	map_script $03, FACEMASK_ANY, $0000, Text_31_72, $00, $00
	map_script $04, FACEMASK_ANY, $0000, Text_31_73, $00, $00
	db $ff
RestaurantPlazaTileTriggers_13:
	; $42b5, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, RestaurantPlazaTile01_13, $00, $00
	map_script $02, FACEMASK_ANY, $0000, RestaurantPlazaTile02_13, $00, $00
	map_script $03, FACEMASK_ANY, $0000, RestaurantPlazaTile03_13, $00, $00
	map_script $05, FACEMASK_ANY, $0000, RestaurantPlazaTile05_13, $00, $00
	map_script $06, FACEMASK_ANY, $0000, RestaurantPlazaTile06_13, $00, $00
	db $ff
RestaurantPlazaTile01_13:
	script_move_target ACTOR_PARTNER, $0700, $0d00 ; $42de
	script_set_speed ACTOR_PLAYER, $0010 ; $42e9
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $42f1
	script_wait_move ACTOR_PLAYER ; $42fb
	call StoryActorsWalkOffAndFadeOut_13 ; $4300
	ld a, $01 ; $4303
	ld [wUnusedExitLocationMirror], a ; $4305
	ld [wStoryModeExitLocationRequest], a ; $4308
	ret ; $430b
RestaurantPlazaTile02_13:
	script_set_speed ACTOR_PLAYER, $0010 ; $430c
	script_move_target ACTOR_PARTNER, $1500, $0d00 ; $4314
	script_move_angle ACTOR_PLAYER, $c2, $0200 ; $431f
	script_wait_move ACTOR_PLAYER ; $4329
	call AnimateDoorOpen_13 ; $432e
	script_move_angle ACTOR_PLAYER, $c2, $0200 ; $4331
	script_wait_frames $02 ; $433b
	ld c, $10 ; $4342
	call BeginFadeOut ; $4344
	script_wait_frames $1e ; $4347
	ld a, $02 ; $434e
	ld [wUnusedExitLocationMirror], a ; $4350
	ld [wStoryModeExitLocationRequest], a ; $4353
	ret ; $4356
RestaurantPlazaTile03_13:
	script_set_speed ACTOR_PARTNER, $0040 ; $4357
	script_move_target ACTOR_PARTNER, $2500, $0d00 ; $435f
	script_set_speed ACTOR_PLAYER, $0010 ; $436a
	script_set_speed ACTOR_PARTNER, $0010 ; $4372
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $437a
	script_wait_move ACTOR_PLAYER ; $4384
	call StoryActorsWalkOffAndFadeOut_13 ; $4389
	ld c, $10 ; $438c
	call BeginFadeOut ; $438e
	script_wait_frames $1e ; $4391
	ld a, $03 ; $4398
	ld [wUnusedExitLocationMirror], a ; $439a
	ld [wStoryModeExitLocationRequest], a ; $439d
	ret ; $43a0
RestaurantPlazaTile05_13:
	script_move_target ACTOR_PARTNER, $3700, $0d00 ; $43a1
	script_set_speed ACTOR_PLAYER, $0010 ; $43ac
	script_set_speed ACTOR_PARTNER, $0010 ; $43b4
	script_move_angle ACTOR_PLAYER, FACE_UP, $0080 ; $43bc
	call StoryActorsWalkOffAndFadeOut_13 ; $43c6
	test_flag FLAG_DOUBLES ; $43c9
	ld a, $05 ; $43cc
	ld [wUnusedExitLocationMirror], a ; $43ce
	ld [wStoryModeExitLocationRequest], a ; $43d1
	jr z, .done ; $43d4
	ld a, $0d ; $43d6
	ld [wUnusedExitLocationMirror], a ; $43d8
	ld [wStoryModeExitLocationRequest], a ; $43db
.done:
	ret ; $43de
RestaurantPlazaTile06_13:
	script_set_speed ACTOR_PLAYER, $0020 ; $43df
	script_move_target ACTOR_PARTNER, $3b00, $0d00 ; $43e7
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0600 ; $43f2
	script_wait_frames $3c ; $43fc
	ld c, $10 ; $4403
	call BeginFadeOut ; $4405
	script_wait_frames $1e ; $4408
	test_flag FLAG_DOUBLES ; $440f
	ld a, $06 ; $4412
	ld [wUnusedExitLocationMirror], a ; $4414
	ld [wStoryModeExitLocationRequest], a ; $4417
	jr z, RestaurantPlazaTile05_13.done ; $441a
	ld a, $06 ; $441c
	ld [wUnusedExitLocationMirror], a ; $441e
	ld [wStoryModeExitLocationRequest], a ; $4421
	ret ; $4424
StoryActorsWalkOffAndFadeOut_13:
	test_flag FLAG_DOUBLES ; $4425
	jr nz, StoryActorsWalkOffAndFadeOutDoubles_13 ; $4428
	script_face ACTOR_PLAYER, FACE_UP ; $442a
	script_move_angle ACTOR_PLAYER, $c8, $0400 ; $4431
	script_set_speed ACTOR_PLAYER, $0010 ; $443b
	script_wait_frames $28 ; $4443
	script_set_anim ACTOR_PLAYER, $08 ; $444a
	ld c, $08 ; $4451
	call BeginFadeOut ; $4453
	script_wait_move ACTOR_PLAYER ; $4456
	script_set_active ACTOR_PLAYER, $00 ; $445b
	script_wait_frames $0a ; $4462
	ret ; $4469
StoryActorsWalkOffAndFadeOutDoubles_13:
	script_wait_move ACTOR_PARTNER ; $446a
	script_move_angle ACTOR_PLAYER, $c8, $0280 ; $446f
	script_set_speed ACTOR_PLAYER, $0010 ; $4479
	script_set_speed ACTOR_PARTNER, $0010 ; $4481
	script_wait_frames $0a ; $4489
	script_move_angle ACTOR_PARTNER, $ca, $0500 ; $4490
	script_wait_move ACTOR_PLAYER ; $449a
	script_set_anim ACTOR_PLAYER, $08 ; $449f
	script_move_angle ACTOR_PLAYER, $ca, $0100 ; $44a6
	script_wait_move ACTOR_PARTNER ; $44b0
	script_set_anim ACTOR_PARTNER, $08 ; $44b5
	script_move_angle ACTOR_PARTNER, $ca, $0200 ; $44bc
	script_wait_move ACTOR_PLAYER ; $44c6
	script_set_active ACTOR_PLAYER, $00 ; $44cb
	ld c, $10 ; $44d2
	call BeginFadeOut ; $44d4
	script_wait_frames $0a ; $44d7
	ret ; $44de
RestaurantPlazaInitScript_13:
	ld a, [wStoryModeEntryPoint] ; $44df
	cp $0f ; $44e2
	jr nz, .ne0f ; $44e4
	call AcademyCourtsTourCutscene ; $44e6
.ne0f:
	cp $0e ; $44e9
	jr nz, .done ; $44eb
	call ServiceAceCoachIntroCutscene ; $44ed
.done:
	ret ; $44f0
AcademyCourtsTourCutscene:
	ldh a, [hRomBank] ; $44f1
	ld hl, AcademyCourtsTourActors_13 ; $44f3
	farcall ScriptRespawnLocationActors ; $44f6
	farcall BeginCutsceneScriptMode ; $44f9
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $44fc
	script_set_position $06, $3f00, $3f00 ; $4507
	call LoadTourPointerSpriteGfx_13 ; $4512
	script_fade_in $04 ; $4515
	call WaitFadeEnd ; $451a
	script_set_position $06, $3200, $1300 ; $451d
	script_move_target $06, $3200, $0d00 ; $4528
	script_wait_frames $0f ; $4533
	script_set_position ACTOR_PLAYER, $3200, $1300 ; $453a
	script_move_target ACTOR_PLAYER, $3200, $0f00 ; $4545
	script_wait_move ACTOR_PLAYER ; $4550
	script_wait_frames $1e ; $4555
	script_face_toward ACTOR_PLAYER, $06 ; $455c
	script_wait_frames $3c ; $4564
	script_face $06, FACE_RIGHT ; $456b
	script_wait_frames $0f ; $4572
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4579
	script_wait_frames $0f ; $4580
	script_move_player $3600, $0d00 ; $4587
	farcall WaitPlayerMoveDone ; $4591
	ld a, $50 ; $4594
	ld [wMapSceneStage], a ; $4596
	ld a, $48 ; $4599
	ld [wMapSceneStage2], a ; $459b
	ld a, $01 ; $459e
	ld hl, AnimateTourPointerSprite_13 ; $45a0
	call RegisterFrameTask ; $45a3
	script_set_text Text_31_48 ; $45a6
	script_speak $06 ; $45ac
	ld hl, AnimateTourPointerSprite_13 ; $45b1
	call UnregisterFrameTask ; $45b4
	script_move_player $3200, $1300 ; $45b7
	farcall WaitPlayerMoveDone ; $45c1
	script_wait_frames $1e ; $45c4
	script_face_pair ACTOR_PLAYER, $06 ; $45cb
	script_speak $06 ; $45d3
	script_wait_frames $0f ; $45d8
	script_set_anim ACTOR_PLAYER, $03 ; $45df
	script_wait_idle ACTOR_PLAYER ; $45e6
	script_wait_frames $1e ; $45eb
	script_face $06, FACE_LEFT ; $45f2
	script_wait_frames $0f ; $45f9
	script_face ACTOR_PLAYER, FACE_LEFT ; $4600
	script_wait_frames $0f ; $4607
	script_move_player $2a00, $0d00 ; $460e
	farcall WaitPlayerMoveDone ; $4618
	ld a, $20 ; $461b
	ld [wMapSceneStage], a ; $461d
	ld a, $48 ; $4620
	ld [wMapSceneStage2], a ; $4622
	ld a, $01 ; $4625
	ld hl, AnimateTourPointerSprite_13 ; $4627
	call RegisterFrameTask ; $462a
	script_speak $06 ; $462d
	ld hl, AnimateTourPointerSprite_13 ; $4632
	call UnregisterFrameTask ; $4635
	script_move_player $3200, $0d00 ; $4638
	farcall WaitPlayerMoveDone ; $4642
	script_face_pair ACTOR_PLAYER, $06 ; $4645
	script_speak $06 ; $464d
	script_set_anim ACTOR_PLAYER, $03 ; $4652
	script_wait_idle ACTOR_PLAYER ; $4659
	script_set_anim $06, $03 ; $465e
	script_wait_idle $06 ; $4665
	script_wait_frames $32 ; $466a
	script_face $06, FACE_LEFT ; $4671
	script_wait_frames $28 ; $4678
	script_face $06, FACE_DOWN ; $467f
	script_wait_frames $0a ; $4686
	script_face $06, FACE_RIGHT ; $468d
	script_wait_frames $28 ; $4694
	script_face $06, FACE_DOWN ; $469b
	script_wait_frames $0a ; $46a2
	script_face $06, FACE_LEFT ; $46a9
	script_wait_frames $28 ; $46b0
	script_face $06, FACE_DOWN ; $46b7
	script_wait_frames $0a ; $46be
	script_face $06, FACE_RIGHT ; $46c5
	script_wait_frames $32 ; $46cc
	script_set_anim $06, $03 ; $46d3
	script_wait_idle $06 ; $46da
	script_speak $06 ; $46df
	script_move_target $06, $4100, $0d00 ; $46e4
	script_wait_frames $05 ; $46ef
	script_move_player $3600, $0d00 ; $46f6
	script_move_target ACTOR_PLAYER, $3200, $0d20 ; $4700
	script_wait_move ACTOR_PLAYER ; $470b
	script_move_target ACTOR_PLAYER, $4100, $0d20 ; $4710
	script_wait_move ACTOR_PLAYER ; $471b
	ld a, $0f ; $4720
	ld [wUnusedExitLocationMirror], a ; $4722
	ld [wStoryModeExitLocationRequest], a ; $4725
	farcall EndCutsceneScriptMode ; $4728
	ret ; $472b
AcademyCourtsTourActors_13:
	; $472c, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3200, $1300, FACE_DOWN, $49, $01, $00
	map_actor_end
ServiceAceCoachIntroCutscene:
	ldh a, [hRomBank] ; $476e
	ld hl, ServiceAceCoachIntroActors_13 ; $4770
	farcall ScriptRespawnLocationActors ; $4773
	farcall BeginCutsceneScriptMode ; $4776
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $4779
	script_set_position $06, $3f00, $3f00 ; $4784
	script_set_position $07, $3f00, $3f00 ; $478f
	script_set_position $08, $3f00, $3f00 ; $479a
	script_fade_in $04 ; $47a5
	call WaitFadeEnd ; $47aa
	script_set_position $06, $4100, $0d00 ; $47ad
	script_move_target $06, $1b00, $0d00 ; $47b8
	script_set_position ACTOR_PLAYER, $4300, $0d00 ; $47c3
	script_move_target ACTOR_PLAYER, $1d00, $0d00 ; $47ce
	script_wait_frames $0f ; $47d9
	script_move_player $1b00, $0d00 ; $47e0
	script_wait_move ACTOR_PLAYER ; $47ea
	script_wait_frames $1e ; $47ef
	script_face_toward ACTOR_PLAYER, $06 ; $47f6
	script_set_text Text_31_53 ; $47fe
	script_speak $06 ; $4804
	script_set_anim ACTOR_PLAYER, $03 ; $4809
	script_wait_idle ACTOR_PLAYER ; $4810
	script_face $06, FACE_UP ; $4815
	script_wait_frames $0f ; $481c
	script_face ACTOR_PLAYER, FACE_UP ; $4823
	script_speak $06 ; $482a
	script_set_anim ACTOR_PLAYER, $03 ; $482f
	script_wait_idle ACTOR_PLAYER ; $4836
	script_wait_frames $1e ; $483b
	call AnimateDoorOpen_13 ; $4842
	script_speak $07 ; $4845
	script_wait_frames $0f ; $484a
	script_set_position $03, $1c00, $0b00 ; $4851
	sound $97 ; $485c
	script_wait_frames $1e ; $485e
	script_set_position $03, $3f00, $3f00 ; $4865
	script_face $06, FACE_LEFT ; $4870
	script_wait_frames $0f ; $4877
	script_face ACTOR_PLAYER, FACE_LEFT ; $487e
	script_move_player $1800, $0d00 ; $4885
	script_wait_frames $0f ; $488f
	script_set_position $07, $1500, $0980 ; $4896
	script_wait_frames $0f ; $48a1
	script_set_speed $07, $0010 ; $48a8
	script_move_target $07, $1500, $0d00 ; $48b0
	script_wait_move $07 ; $48bb
	script_face $07, FACE_RIGHT ; $48c0
	script_set_position $08, $1500, $0900 ; $48c7
	script_wait_frames $0f ; $48d2
	script_set_speed $08, $0010 ; $48d9
	script_move_target $08, $1500, $0b00 ; $48e1
	script_wait_move $08 ; $48ec
	call AnimateDoorClose_13 ; $48f1
	script_face $08, FACE_RIGHT ; $48f4
	script_wait_frames $0f ; $48fb
	script_set_anim $06, $02 ; $4902
	script_wait_idle $06 ; $4909
	script_speak $06 ; $490e
	script_face $07, FACE_DOWN ; $4913
	script_set_anim $07, $04 ; $491a
	script_wait_idle $07 ; $4921
	script_wait_frames $1e ; $4926
	script_face_toward $06, $07 ; $492d
	script_speak $07 ; $4935
	script_set_anim $06, $02 ; $493a
	script_wait_idle $06 ; $4941
	script_speak $06 ; $4946
	script_set_anim $08, $03 ; $494b
	script_wait_idle $08 ; $4952
	script_speak $08 ; $4957
	script_wait_frames $0f ; $495c
	script_set_anim $08, $02 ; $4963
	script_wait_idle $08 ; $496a
	script_set_position $04, $1640, $0940 ; $496f
	sound $98 ; $497a
	script_wait_frames $1e ; $497c
	script_set_position $04, $3f00, $3f00 ; $4983
	script_wait_frames $1e ; $498e
	script_set_anim $06, $02 ; $4995
	script_wait_idle $06 ; $499c
	script_face_toward ACTOR_PLAYER, $06 ; $49a1
	script_wait_frames $32 ; $49a9
	script_face_toward $07, $06 ; $49b0
	ld a, [wStoryModeGenderOfMainCharacter] ; $49b8
	or a ; $49bb
	jr z, .speak ; $49bc
	farcall AdvanceDialogueTextCursor ; $49be
.speak:
	script_speak $06 ; $49c1
	script_set_text Text_31_62 ; $49c6
	script_wait_frames $0f ; $49cc
	script_set_speed ACTOR_PLAYER, $0018 ; $49d3
	script_move_target ACTOR_PLAYER, $1d00, $0c00 ; $49db
	script_wait_move ACTOR_PLAYER ; $49e6
	script_move_target ACTOR_PLAYER, $1b00, $0b00 ; $49eb
	script_wait_move ACTOR_PLAYER ; $49f6
	script_face ACTOR_PLAYER, FACE_LEFT ; $49fb
	script_set_speed ACTOR_PLAYER, $0020 ; $4a02
	script_wait_frames $0f ; $4a0a
	script_set_anim ACTOR_PLAYER, $03 ; $4a11
	script_wait_idle ACTOR_PLAYER ; $4a18
	script_wait_frames $0f ; $4a1d
	script_face_pair $08, $07 ; $4a24
	script_wait_frames $46 ; $4a2c
	script_face_toward ACTOR_PLAYER, $07 ; $4a33
	script_face_toward ACTOR_PLAYER, $08 ; $4a3b
	script_wait_frames $0f ; $4a43
	script_speak $07 ; $4a4a
	script_set_anim $07, $03 ; $4a4f
	script_wait_idle $07 ; $4a56
	script_speak $07 ; $4a5b
	script_set_anim ACTOR_PLAYER, $03 ; $4a60
	script_wait_idle ACTOR_PLAYER ; $4a67
	script_wait_frames $1e ; $4a6c
	script_set_anim $08, $02 ; $4a73
	script_wait_idle $08 ; $4a7a
	script_speak $08 ; $4a7f
	script_set_anim $08, $03 ; $4a84
	script_wait_idle $08 ; $4a8b
	script_speak $08 ; $4a90
	script_wait_frames $5a ; $4a95
	script_move_target $08, $1500, $0980 ; $4a9c
	call AnimateDoorOpen_13 ; $4aa7
	script_move_target $08, $14c0, $0900 ; $4aaa
	script_move_target $07, $1500, $0b00 ; $4ab5
	script_set_position $08, $3f00, $3f00 ; $4ac0
	script_wait_move $07 ; $4acb
	script_wait_frames $0f ; $4ad0
	script_face_toward $06, $07 ; $4ad7
	script_speak $07 ; $4adf
	script_move_target $07, $1500, $0980 ; $4ae4
	script_wait_move $07 ; $4aef
	script_move_target $07, $14c0, $0900 ; $4af4
	script_wait_frames $0f ; $4aff
	script_set_position $07, $3f00, $3f00 ; $4b06
	call AnimateDoorClose_13 ; $4b11
	script_move_player $1b00, $0d00 ; $4b14
	script_wait_frames $3c ; $4b1e
	script_face_toward $06, ACTOR_PLAYER ; $4b25
	script_wait_frames $0f ; $4b2d
	script_set_position $05, $1c00, $0900 ; $4b34
	script_wait_frames $5a ; $4b3f
	script_set_position $05, $3f00, $3f00 ; $4b46
	script_wait_frames $0f ; $4b51
	script_speak $06 ; $4b58
	script_face_toward ACTOR_PLAYER, $06 ; $4b5d
	script_wait_frames $1e ; $4b65
	script_speak $06 ; $4b6c
	script_set_anim ACTOR_PLAYER, $02 ; $4b71
	script_wait_idle ACTOR_PLAYER ; $4b78
	script_wait_frames $3c ; $4b7d
	script_move_target $06, $1500, $0d00 ; $4b84
	script_wait_move $06 ; $4b8f
	script_face_toward ACTOR_PLAYER, $06 ; $4b94
	script_wait_frames $1e ; $4b9c
	script_speak $06 ; $4ba3
	script_wait_frames $0f ; $4ba8
	script_move_target ACTOR_PLAYER, $1700, $0d00 ; $4baf
	script_wait_move ACTOR_PLAYER ; $4bba
	script_wait_frames $0a ; $4bbf
	script_move_target $06, $0700, $0d00 ; $4bc6
	script_wait_frames $0a ; $4bd1
	script_move_player $0900, $0d00 ; $4bd8
	script_move_target ACTOR_PLAYER, $0700, $0d00 ; $4be2
	script_wait_move $06 ; $4bed
	script_face $06, FACE_UP ; $4bf2
	script_move_angle $06, FACE_UP, $0500 ; $4bf9
	script_set_speed $06, $000b ; $4c03
	script_wait_frames $0a ; $4c0b
	script_wait_move ACTOR_PLAYER ; $4c12
	script_face ACTOR_PLAYER, FACE_UP ; $4c17
	script_move_angle ACTOR_PLAYER, FACE_UP, $0500 ; $4c1e
	script_set_speed ACTOR_PLAYER, $000b ; $4c28
	script_wait_move $06 ; $4c30
	script_set_anim $06, $08 ; $4c35
	script_move_angle $06, FACE_UP, $0100 ; $4c3c
	script_wait_move ACTOR_PLAYER ; $4c46
	script_set_anim ACTOR_PLAYER, $08 ; $4c4b
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $4c52
	script_set_position $06, $3f00, $3f00 ; $4c5c
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $4c67
	ld a, $0e ; $4c72
	ld [wUnusedExitLocationMirror], a ; $4c74
	ld [wStoryModeExitLocationRequest], a ; $4c77
	farcall EndCutsceneScriptMode ; $4c7a
	ret ; $4c7d
ServiceAceCoachIntroActors_13:
	; $4c7e, 94 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_13_7b25, $4100, $0d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_13_7b25, $1500, $0d00, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_13_7b25, $1300, $0d00, FACE_DOWN, $4b, $01, $00
	map_actor_end
LoadTourPointerSpriteGfx_13:
	ldh a, [hWramBank] ; $4cdc
	push af ; $4cde
	wram_bank $01 ; $4cdf
	ld hl, TourPointerTiles_13 ; $4ce5
	ld de, $8000 + VRAM_BANK1 ; $4ce8
	ld c, (TourPointerPalette_13 - TourPointerTiles_13) / 16 ; $4ceb
	call QueueVRAMCopy ; $4ced
	ld hl, TourPointerPalette_13 ; $4cf0
	ld de, $0801 ; $4cf3
	call LoadPaletteShadow ; $4cf6
	pop af ; $4cf9
	wram_bank ; $4cfa
	ret ; $4cfe
QueueTourPointerSprite_13:
	ld hl, SpriteTemplate_13_4d20 ; $4cff
	ld c, $00 ; $4d02
	ld b, $08 ; $4d04
	call QueueSpriteTemplate ; $4d06
	ret ; $4d09
AnimateTourPointerSprite_13:
	ld a, [wMapSceneStage] ; $4d0a
	ld d, a ; $4d0d
	ldh a, [hVBlankCounter] ; $4d0e
	srl a ; $4d10
	and $07 ; $4d12
	ld e, a ; $4d14
	ld a, [wMapSceneStage2] ; $4d15
	add $08 ; $4d18
	sub e ; $4d1a
	ld e, a ; $4d1b
	call QueueTourPointerSprite_13 ; $4d1c
	ret ; $4d1f
SpriteTemplate_13_4d20:
	; $4d20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
	; $4d29, 7 bytes (fill)
	ds 7, $00
TourPointerTiles_13:
	INCBIN "data/bank_013/d_4d30.bin" ; $4d30, 64 bytes
TourPointerPalette_13:
	INCLUDE "data/bank_013/palettes_4d70.asm" ; $4d70, 8 bytes (palettes)
AnimateDoorOpen_13:
	sound $71 ; $4d78
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $4d7a
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $4d89
	script_wait_frames $02 ; $4d98
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $4d9f
	script_wait_frames $02 ; $4dae
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $4db5
	script_wait_frames $02 ; $4dc4
	ret ; $4dcb
AnimateDoorClose_13:
	sound $71 ; $4dcc
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $4dce
	script_wait_frames $01 ; $4ddd
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $4de4
	script_wait_frames $01 ; $4df3
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $4dfa
	script_wait_frames $01 ; $4e09
	script_copy_scene_rect $06, $15, $14, $08, $02, $02 ; $4e10
	ret ; $4e1f
DormRoomMapScripts_13:
	; $4e20, 14 bytes (map_tree)
	dw DormRoomEntryPoints_13 ; slot 0 EntryPoints
	dw DormRoomExitTriggers_13 ; slot 1 ExitTriggers
	dw DormRoomActors_13 ; slot 2 Actors
	dw DormRoomNpcScripts_13 ; slot 3 NpcScripts
	dw DormRoomFacingScripts_13 ; slot 4 FacingScripts
	dw DormRoomTileTriggers_13 ; slot 5 TileTriggers
	dw DormRoomInitScript_13 ; slot 6 InitScript
DormRoomActors_13:
	; $4e2e, 52 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $0b00, $0900, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_13_585f, $0600, $1080, FACE_DOWN, $55, $01, $00
	map_actor $0000, ActorScript_13_7b25, $2900, $2900, FACE_DOWN, $4c, $01, $00
	map_actor_end
DormRoomEntryPoints_13:
	; $4e62, 49 bytes (map_entries)
	map_entry $01, FACE_UP, $0b00, $0d00, $0000
	map_entry $02, FACE_UP, $0b00, $1300, $0000
	map_entry $03, FACE_UP, $0b00, $0d00, $0000
	map_entry $04, FACE_UP, $0b00, $0d00, $0000
	map_entry $0e, FACE_UP, $0b00, $0d00, $0000
	map_entry $0f, FACE_UP, $0b00, $0d00, $0000
	db $ff
DormRoomExitTriggers_13:
	; $4e93, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_13, $09, $02
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_13, $00, $01
	db $ff
DormRoomNpc04_13:
	call AdvanceRandomSeed ; $4ea4
	ld a, l ; $4ea7
	and $07 ; $4ea8
	add $3c ; $4eaa
	ld l, a ; $4eac
	adc $05 ; $4ead
	sub l ; $4eaf
	ld h, a ; $4eb0
	farcall InitDialogueTextCursor ; $4eb1
	script_speak $04 ; $4eb4
	ret ; $4eb9
DormRoomNpcScripts_13:
	; $4eba, 17 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, DormRoomNpc03_13, $00, $00
	map_script $04, FACEMASK_ANY, $0000, DormRoomNpc04_13, $13, $00
	db $ff
DormRoomFacingScripts_13:
	; $4ecb, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DormRoomFacing01_13, $00, $00
	db $ff
DormRoomFacing01_13:
	farcall BeginCutsceneScriptMode ; $4ed4
	script_fade_in $10 ; $4ed7
	script_set_text Text_31_131 ; $4edc
	script_speak ACTOR_PLAYER ; $4ee2
	farcall EndCutsceneScriptMode ; $4ee7
	ret ; $4eea
DormRoomTileTriggers_13:
	; $4eeb, 9 bytes (map_scripts)
	map_script $0f, FACEMASK_DOWN, $0000, DormRoomTile0F_13, $00, $00
	db $ff
DormRoomTile0F_13:
	script_null_script $03 ; $4ef4
	ld a, $03 ; $4ef9
	script_set_text Text_31_324 ; $4efb
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $4f01
	jr z, .notTempSceneVariantA ; $4f04
	script_set_text Text_31_328 ; $4f06
.notTempSceneVariantA:
	script_jump_velocity $03, $ff80 ; $4f0c
	ld a, $03 ; $4f14
	call ComputeEmoteActorPosition_13 ; $4f16
	call PlaceEmoteActorAtComputedPosition_13 ; $4f19
	sound $97 ; $4f1c
	script_wait_frames $46 ; $4f1e
	script_set_position $05, $3f00, $3f00 ; $4f25
	script_speak $03 ; $4f30
	script_face_toward ACTOR_PLAYER, $03 ; $4f35
	script_face_toward $03, ACTOR_PLAYER ; $4f3d
	script_set_position $06, $0c00, $0800 ; $4f45
	script_set_anim $03, $02 ; $4f50
	script_wait_idle $03 ; $4f57
	script_set_position $06, $3f00, $3f00 ; $4f5c
	script_speak $03 ; $4f67
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4f6c
	ld a, $00 ; $4f74
	farcall ScriptWaitActorJumpDone ; $4f76
	test_flag FLAG_DOUBLES ; $4f79
	jr nz, .advanceText ; $4f7c
	script_speak $03 ; $4f7e
	script_set_anim ACTOR_PLAYER, $03 ; $4f83
	script_wait_idle ACTOR_PLAYER ; $4f8a
	script_set_speed ACTOR_PLAYER, $0030 ; $4f8f
	script_move_target ACTOR_PLAYER, $0b00, $1400 ; $4f97
	script_wait_frames $0a ; $4fa2
	script_face_toward ACTOR_PLAYER, $03 ; $4fa9
	ld a, $06 ; $4fb1
	ld [wStoryModeCurrentLocation], a ; $4fb3
	ld a, $0d ; $4fb6
	ld [wStoryModeEntryPoint], a ; $4fb8
	ld a, $ff ; $4fbb
	ld [wUnusedExitLocationMirror], a ; $4fbd
	ld [wStoryModeExitLocationRequest], a ; $4fc0
	ld c, $04 ; $4fc3
	call BeginFadeOut ; $4fc5
	script_wait_frames $14 ; $4fc8
	ret ; $4fcf
.advanceText:
	farcall AdvanceDialogueTextCursor ; $4fd0
	script_speak $03 ; $4fd3
	script_set_anim ACTOR_PLAYER, $03 ; $4fd8
	script_wait_idle ACTOR_PLAYER ; $4fdf
	script_get_actor_state $03 ; $4fe4
	ld c, l ; $4fe9
	ld b, h ; $4fea
	ld de, $d000 ; $4feb
	farcall AttachActorStepMover ; $4fee
	script_set_speed ACTOR_PLAYER, $0030 ; $4ff1
	script_move_target ACTOR_PLAYER, $0b00, $1400 ; $4ff9
	script_wait_frames $0a ; $5004
	ld a, $06 ; $500b
	ld [wStoryModeCurrentLocation], a ; $500d
	ld a, $0d ; $5010
	ld [wStoryModeEntryPoint], a ; $5012
	ld a, $ff ; $5015
	ld [wUnusedExitLocationMirror], a ; $5017
	ld [wStoryModeExitLocationRequest], a ; $501a
	ld c, $04 ; $501d
	call BeginFadeOut ; $501f
	script_wait_frames $14 ; $5022
	ret ; $5029
DormRoomInitScript_13:
	xor a ; $502a
	ld [wStoryModeShowLocationName], a ; $502b
	ld a, [wStoryModeEntryPoint] ; $502e
	cp $0a ; $5031
	jp z, ShowStoryNarration_13.setText ; $5033
	cp $09 ; $5036
	jp z, ShowStoryNarration_13.setText2 ; $5038
	cp $08 ; $503b
	jp z, ShowStoryNarration_13.setText3 ; $503d
	call ComputeStoryRankTier_13 ; $5040
	call SetupDormRoomSceneVariant ; $5043
	call PlaceDormRoomArrivalActors_13 ; $5046
	call SetDormRoomEventTriggerCells_13 ; $5049
	ld a, [wStoryModeEntryPoint] ; $504c
	cp $0f ; $504f
	jp z, DormRoomNpc03_13.walkToBed ; $5051
	sound $1c ; $5054
	ld a, [wStoryModeEntryPoint] ; $5056
	cp $01 ; $5059
	jp z, DormRoomNpc03_13.byStage ; $505b
	cp $02 ; $505e
	jp z, DormRoomNpc03_13.morningDoubles ; $5060
	farcall EndCutsceneScriptMode ; $5063
	ret ; $5066
SetDormRoomEventTriggerCells_13:
	test_flag FLAG_DOUBLES ; $5067
	jr nz, .doubles ; $506a
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $506c
	jr nz, .checkIslandSingles ; $506f
	jr .clearTriggers ; $5071
	ret ; $5073
.checkIslandSingles:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $5074
	jr z, .enableTriggers ; $5077
	jr .clearTriggers ; $5079
	ret ; $507b
.doubles:
	test_flag FLAG_WON_VARSITY_DOUBLES_RANK_2 ; $507c
	jr nz, .checkIslandDoubles ; $507f
	jr .clearTriggers ; $5081
	ret ; $5083
.checkIslandDoubles:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $5084
	jr z, .enableTriggers ; $5087
	jr .clearTriggers ; $5089
	ret ; $508b
.enableTriggers:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	farcall WriteBehaviorMapCell ; $5092
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	farcall WriteBehaviorMapCell ; $509b
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	farcall WriteBehaviorMapCell ; $50a4
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	farcall WriteBehaviorMapCell ; $50ad
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	farcall WriteBehaviorMapCell ; $50b6
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	farcall WriteBehaviorMapCell ; $50bf
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	farcall WriteBehaviorMapCell ; $50c8
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	farcall WriteBehaviorMapCell ; $50d1
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	farcall WriteBehaviorMapCell ; $50da
	ret ; $50dd
.clearTriggers:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	farcall WriteBehaviorMapCell ; $50e4
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	farcall WriteBehaviorMapCell ; $50ed
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	farcall WriteBehaviorMapCell ; $50f6
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	farcall WriteBehaviorMapCell ; $50ff
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	farcall WriteBehaviorMapCell ; $5108
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	farcall WriteBehaviorMapCell ; $5111
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	farcall WriteBehaviorMapCell ; $511a
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	farcall WriteBehaviorMapCell ; $5123
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	farcall WriteBehaviorMapCell ; $512c
	ret ; $512f
SetupDormRoomSceneVariant:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5130
	or a ; $5133
	jr nz, .nonZero ; $5134
	farcall WaitPlayerMoveDone ; $5136
	ld b, $20 ; $5139
	ld c, $00 ; $513b
	ld d, $00 ; $513d
	ld e, $00 ; $513f
	ld h, $16 ; $5141
	ld l, $16 ; $5143
	farcall CopyCollisionMapRect ; $5145
	ld b, $20 ; $5148
	ld c, $00 ; $514a
	ld d, $00 ; $514c
	ld e, $00 ; $514e
	ld h, $16 ; $5150
	ld l, $16 ; $5152
	farcall CopyBehaviorMapRect ; $5154
	script_copy_scene_rect $20, $00, $00, $00, $16, $18 ; $5157
	script_set_objdef $28, $03 ; $5166
	script_set_anim $03, $01 ; $5172
	script_set_position $04, $1f00, $1500 ; $5179
	script_null_script $04 ; $5184
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $5189
	ld a, $02 ; $518c
	ld [wMapScrollMinX], a ; $518e
	ld a, $02 ; $5191
	ld [wMapScrollMinY], a ; $5193
	ld a, $16 ; $5196
	ld [wMapWidthTiles], a ; $5198
	ld a, $14 ; $519b
	ld [wMapHeightTiles], a ; $519d
	call DisableLCDSafely ; $51a0
	ld a, $00 ; $51a3
	farcall CopyScrolledSceneTilemapToVram ; $51a5
	call EnableLCD ; $51a8
	ret ; $51ab
.nonZero:
	call SetRandomDormRoomNpc04Script_13 ; $51ac
	ret ; $51af
PlaceDormRoomArrivalActors_13:
	ld a, [wStoryModeEntryPoint] ; $51b0
	cp $ff ; $51b3
	jr z, .stage3 ; $51b5
	cp $01 ; $51b7
	jr z, .stage2 ; $51b9
	wram_bank $04 ; $51bb
	test_flag FLAG_DOUBLES ; $51c1
	jp nz, DormRoomNpc04IdleScripts_13.isDoubles ; $51c4
	script_set_position $03, $0b00, $0a00 ; $51c7
	ret ; $51d2
.stage2:
	test_flag FLAG_DOUBLES ; $51d3
	jr z, .stage2Singles ; $51d6
	script_set_position $03, $0b00, $0a00 ; $51d8
	script_face $03, FACE_DOWN ; $51e3
	script_null_script ACTOR_PARTNER ; $51ea
	script_set_position ACTOR_PARTNER, $0100, $0100 ; $51ef
	script_get_actor_state $03 ; $51fa
	ld c, l ; $51ff
	ld b, h ; $5200
	ld hl, $0005 ; $5201
	add hl, bc ; $5204
	set 4, [hl] ; $5205
	ret ; $5207
.stage2Singles:
	script_set_position $03, $0b00, $0a00 ; $5208
	script_face $03, FACE_DOWN ; $5213
	ret ; $521a
.stage3:
	test_flag FLAG_DOUBLES ; $521b
	jr z, .stage2Singles ; $521e
	script_null_script ACTOR_PARTNER ; $5220
	script_set_position ACTOR_PARTNER, $0100, $0100 ; $5225
	call PlaceRoommateAtPlayerTarget_13 ; $5230
	script_get_actor_state $03 ; $5233
	ld c, l ; $5238
	ld b, h ; $5239
	ld de, $d000 ; $523a
	farcall AttachActorStepMover ; $523d
	script_get_actor_state $03 ; $5240
	ld c, l ; $5245
	ld b, h ; $5246
	ld hl, $0005 ; $5247
	add hl, bc ; $524a
	set 4, [hl] ; $524b
	ret ; $524d
SetRandomDormRoomNpc04Script_13:
	call AdvanceRandomSeed ; $524e
	ld a, l ; $5251
	and $07 ; $5252
	add a ; $5254
	add LOW(DormRoomNpc04IdleScripts_13) ; $5255
	ld l, a ; $5257
	adc HIGH(DormRoomNpc04IdleScripts_13) ; $5258
	sub l ; $525a
	ld h, a ; $525b
	ld a, [hl+] ; $525c
	ld h, [hl] ; $525d
	ld l, a ; $525e
	ld e, l ; $525f
	ld d, h ; $5260
	ldh a, [hRomBank] ; $5261
	ld b, a ; $5263
	ld a, $04 ; $5264
	farcall ScriptSetActorScript ; $5266
	ret ; $5269
DormRoomNpc04IdleScripts_13:
	; $526a, 16 bytes (records:2)
	dw ActorScript_13_585f ; record 0
	dw ActorScript_13_5877 ; record 1
	dw ActorScript_13_5881 ; record 2
	dw ActorScript_13_588b ; record 3
	dw ActorScript_13_585f ; record 4
	dw ActorScript_13_585f ; record 5
	dw ActorScript_13_588b ; record 6
	dw ActorScript_13_588b ; record 7
.isDoubles:
	script_null_script ACTOR_PARTNER ; $527a
	script_set_position ACTOR_PARTNER, $1500, $1f00 ; $527f
	script_set_position $03, $0b00, $1000 ; $528a
	script_face $03, FACE_UP ; $5295
	script_fade_in $04 ; $529c
	call WaitFadeEnd ; $52a1
	script_move_target $03, $0b00, $0a00 ; $52a4
	ret ; $52af
DormRoomNpc03_13:
	script_face_toward ACTOR_PLAYER, $03 ; $52b0
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $52b8
	jr z, .altGreeting ; $52bb
	script_set_text Text_31_289 ; $52bd
	jr .prompt ; $52c3
.altGreeting:
	script_set_text Text_31_255 ; $52c5
.prompt:
	ld a, $03 ; $52cb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $52cd
	farcall RunDialogueYesNoPrompt ; $52d0
	farcall ScriptCloseDialogueWindow ; $52d3
	script_wait_frames $05 ; $52d6
	and a ; $52dd
	jr nz, .doublesPrompt ; $52de
	call RunAcademyQuestionsMenu ; $52e0
.doublesPrompt:
	call RunPlayDoublesTodayPrompt ; $52e3
	ret ; $52e6
.byStage:
	call GetDormRoomStoryStage_13 ; $52e7
	cp $01 ; $52ea
	jp z, DormRoomArrivalCutscene_13 ; $52ec
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $52ef
	jr z, .stage2Text ; $52f2
	script_set_text Text_31_263 ; $52f4
	jr .placeActors ; $52fa
.stage2Text:
	script_set_text Text_31_258 ; $52fc
.placeActors:
	script_null_script ACTOR_PARTNER ; $5302
	script_set_position ACTOR_PARTNER, $0b00, $1e00 ; $5307
	script_face ACTOR_PARTNER, FACE_DOWN ; $5312
	script_set_position $03, $0b00, $0a00 ; $5319
	script_face $03, FACE_DOWN ; $5324
	script_fade_in $04 ; $532b
	call WaitFadeEnd ; $5330
	test_flag FLAG_DOUBLES ; $5333
	jr z, .speakShort ; $5336
	farcall AdvanceDialogueTextCursor ; $5338
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $533b
	jr nz, .speak ; $533e
	script_speak $03 ; $5340
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5345
	jr z, .speak ; $5348
	farcall AdvanceDialogueTextCursor ; $534a
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $534d
	jr z, .speak ; $5350
	farcall AdvanceDialogueTextCursor ; $5352
.speak:
	script_speak $03 ; $5355
	script_set_anim ACTOR_PLAYER, $03 ; $535a
	script_wait_idle ACTOR_PLAYER ; $5361
	script_get_actor_state $03 ; $5366
	ld c, l ; $536b
	ld b, h ; $536c
	ld de, $d000 ; $536d
	farcall AttachActorStepMover ; $5370
	script_face ACTOR_PLAYER, FACE_DOWN ; $5373
	script_get_actor_state $03 ; $537a
	ld c, l ; $537f
	ld b, h ; $5380
	ld hl, $0005 ; $5381
	add hl, bc ; $5384
	set 4, [hl] ; $5385
	script_wait_frames $05 ; $5387
	ret ; $538e
.speakShort:
	script_speak $03 ; $538f
	script_set_anim ACTOR_PLAYER, $03 ; $5394
	script_wait_idle ACTOR_PLAYER ; $539b
	ret ; $53a0
.walkToBed:
	sound $41 ; $53a1
	script_set_speed ACTOR_PLAYER, $0010 ; $53a3
	script_player_speed $0040 ; $53ab
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $53b1
	jr z, .altBedText ; $53b4
	script_set_text Text_31_278 ; $53b6
	jr .bedScene ; $53bc
.altBedText:
	script_set_text Text_31_244 ; $53be
.bedScene:
	script_set_position ACTOR_PLAYER, $0b00, $0e00 ; $53c4
	script_set_position $03, $0b00, $0a00 ; $53cf
	script_move_player $0b00, $0a00 ; $53da
	farcall WaitPlayerMoveDone ; $53e4
	script_wait_frames $78 ; $53e7
	script_wait_frames $b4 ; $53ee
	script_fade_in $04 ; $53f5
	call WaitJingleEnd ; $53fa
	sound $1c ; $53fd
	script_wait_frames $0a ; $53ff
	ld a, $03 ; $5406
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5408
	farcall RunDialogueYesNoPrompt ; $540b
	farcall ScriptCloseDialogueWindow ; $540e
	script_wait_frames $05 ; $5411
	and a ; $5418
	jr nz, .variantB ; $5419
	script_speak $03 ; $541b
	farcall AdvanceDialogueTextCursor ; $5420
	jr .roommateWalks ; $5423
.variantB:
	farcall AdvanceDialogueTextCursor ; $5425
	script_speak $03 ; $5428
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $542d
.roommateWalks:
	script_set_speed $03, $0010 ; $5430
	script_set_anim $03, $03 ; $5438
	script_wait_idle $03 ; $543f
	script_speak $03 ; $5444
	script_move_target $03, $0900, $0a00 ; $5449
	script_speak $03 ; $5454
	script_wait_move $03 ; $5459
	script_move_target $03, $0d00, $0a00 ; $545e
	script_speak $03 ; $5469
	script_wait_move $03 ; $546e
	script_move_target $03, $0b00, $0a00 ; $5473
	script_wait_move $03 ; $547e
	script_face_toward ACTOR_PLAYER, $03 ; $5483
	ld a, $03 ; $548b
	farcall ScriptShowSpeakerDialogueRestoreBG ; $548d
	farcall RunDialogueYesNoPrompt ; $5490
	farcall ScriptCloseDialogueWindow ; $5493
	script_wait_frames $05 ; $5496
	and a ; $549d
	jr nz, .variantBAlt ; $549e
	script_speak $03 ; $54a0
	farcall AdvanceDialogueTextCursor ; $54a5
	jr .continueScene ; $54a8
.variantBAlt:
	farcall AdvanceDialogueTextCursor ; $54aa
	script_speak $03 ; $54ad
.continueScene:
	script_move_target $03, $0b00, $0b00 ; $54b2
	script_wait_move $03 ; $54bd
	script_set_anim $03, $02 ; $54c2
	script_wait_idle $03 ; $54c9
	script_speak $03 ; $54ce
	script_set_anim $03, $03 ; $54d3
	script_wait_idle $03 ; $54da
	script_speak $03 ; $54df
	script_set_anim $03, $03 ; $54e4
	script_wait_idle $03 ; $54eb
	ld a, $03 ; $54f0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $54f2
	farcall RunDialogueYesNoPrompt ; $54f5
	farcall ScriptCloseDialogueWindow ; $54f8
	script_wait_frames $05 ; $54fb
	and a ; $5502
	jr nz, .sleepScene ; $5503
	call RunAcademyQuestionsMenu ; $5505
.sleepScene:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5508
	jr nz, .morningText ; $550b
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $550d
	jr nz, .wakeScene ; $5510
	script_wait_frames $14 ; $5512
	script_set_anim $03, $03 ; $5519
	script_wait_idle $03 ; $5520
	script_set_text Text_31_256 ; $5525
	script_speak $03 ; $552b
	ret ; $5530
.wakeScene:
	script_wait_frames $14 ; $5531
	script_set_anim $03, $03 ; $5538
	script_wait_idle $03 ; $553f
	script_set_text Text_31_257 ; $5544
	script_speak $03 ; $554a
	ret ; $554f
.morningText:
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $5550
	jr nz, .morningSpeak ; $5553
	script_wait_frames $14 ; $5555
	script_set_anim $03, $03 ; $555c
	script_wait_idle $03 ; $5563
	script_set_text Text_31_291 ; $5568
	script_speak $03 ; $556e
	ret ; $5573
.morningSpeak:
	script_wait_frames $14 ; $5574
	script_set_anim $03, $03 ; $557b
	script_wait_idle $03 ; $5582
	script_set_text Text_31_290 ; $5587
	script_speak $03 ; $558d
	ret ; $5592
.morningDoubles:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5593
	jr z, .morningAlt ; $5596
	ld hl, wMapScratch ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr .morningEnd ; $55a1
.morningAlt:
	ld hl, wMapScratch ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
.morningEnd:
	ld hl, wMapScratch ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	farcall InitDialogueTextCursor ; $55b2
	test_flag FLAG_DOUBLES ; $55b5
	jr z, .dayStart ; $55b8
	farcall AdvanceDialogueTextCursor ; $55ba
.dayStart:
	script_wait_frames $1e ; $55bd
	script_move_target ACTOR_PLAYER, $0b00, $0e00 ; $55c4
	script_fade_in $04 ; $55cf
	call WaitFadeEnd ; $55d4
	script_move_player $0b00, $0c40 ; $55d7
	farcall WaitPlayerMoveDone ; $55e1
	script_face $03, FACE_DOWN ; $55e4
	script_set_anim $03, $03 ; $55eb
	script_wait_idle $03 ; $55f2
	script_speak $03 ; $55f7
	call GetDormRoomStoryStage_13 ; $55fc
	and a ; $55ff
	jp z, .dayText ; $5600
	ld hl, wMapScratch ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr .daySpeak ; $560b
.dayText:
	ld hl, wMapScratch ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
.daySpeak:
	add l ; $5615
	ld l, a ; $5616
	jr nc, .dayScene ; $5617
	inc h ; $5619
.dayScene:
	farcall InitDialogueTextCursor ; $561a
	script_set_anim $03, $04 ; $561d
	script_wait_idle $03 ; $5624
	ld a, $03 ; $5629
	farcall ScriptShowSpeakerDialogueRestoreBG ; $562b
	farcall RunDialogueYesNoPrompt ; $562e
	farcall ScriptCloseDialogueWindow ; $5631
	script_wait_frames $05 ; $5634
	and a ; $563b
	jr nz, .finalText ; $563c
	ld hl, wMapScratch ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add l ; $5646
	ld l, a ; $5647
	jr nc, .dayEnd ; $5648
	inc h ; $564a
.dayEnd:
	farcall InitDialogueTextCursor ; $564b
	script_speak $03 ; $564e
	sound $00 ; $5653
	script_wait_frames $02 ; $5655
	sound $41 ; $565c
	script_set_anim ACTOR_PLAYER, $03 ; $565e
	script_set_anim $03, $03 ; $5665
	script_wait_idle $03 ; $566c
	call WaitJingleEnd ; $5671
	ld c, $04 ; $5674
	call BeginFadeOut ; $5676
	call WaitFadeEnd ; $5679
	ld a, $02 ; $567c
	ld [wUnusedExitLocationMirror], a ; $567e
	ld [wStoryModeExitLocationRequest], a ; $5681
	ld b, $0a ; $5684
	ld c, $01 ; $5686
	farcall SaveStoryReturnPoint ; $5688
	farcall SaveStorySlotWithTimer ; $568b
	ret ; $568e
.finalText:
	ld hl, wMapScratch ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add l ; $5697
	ld l, a ; $5698
	jr nc, .finalSpeak ; $5699
	inc h ; $569b
.finalSpeak:
	farcall InitDialogueTextCursor ; $569c
	ld a, $03 ; $569f
	farcall ScriptShowSpeakerDialogueRestoreBG ; $56a1
	farcall RunDialogueYesNoPrompt ; $56a4
	farcall ScriptCloseDialogueWindow ; $56a7
	script_wait_frames $05 ; $56aa
	and a ; $56b1
	jr nz, .done ; $56b2
	call RunAcademyQuestionsMenu ; $56b4
.done:
	call RunPlayDoublesTodayPrompt ; $56b7
	ret ; $56ba
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
	ld a, $03 ; $56d4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $56d6
	farcall RunDialogueYesNoPrompt ; $56d9
	farcall ScriptCloseDialogueWindow ; $56dc
	script_wait_frames $05 ; $56df
	and a ; $56e6
	jr nz, .declined ; $56e7
	set_flag FLAG_DOUBLES ; $56e9
	call SetRoommateDoublesYesReplyText_13 ; $56ec
	script_speak $03 ; $56ef
	script_set_anim ACTOR_PLAYER, $03 ; $56f4
	script_wait_idle ACTOR_PLAYER ; $56fb
	script_wait_frames $05 ; $5700
	script_face ACTOR_PLAYER, FACE_DOWN ; $5707
	wram_bank $04 ; $570e
	ld a, $01 ; $5714
	ld [wMatchIsDoubles], a ; $5716
	call SetDormRoomEventTriggerCells_13 ; $5719
	script_wait_frames $05 ; $571c
	script_get_actor_state $03 ; $5723
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, wActors ; $572a
	farcall AttachActorStepMover ; $572d
	script_get_actor_state $03 ; $5730
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, $0005 ; $5737
	add hl, bc ; $573a
	set 4, [hl] ; $573b
	script_wait_frames $05 ; $573d
	script_face ACTOR_PLAYER, FACE_DOWN ; $5744
	ret ; $574b
.declined:
	call SetRoommateDoublesNoReplyText_13 ; $574c
	farcall AdvanceDialogueTextCursor ; $574f
	script_speak $03 ; $5752
	clear_flag FLAG_DOUBLES ; $5757
	wram_bank $04 ; $575a
	ld a, $00 ; $5760
	ld [wMatchIsDoubles], a ; $5762
	script_null_script $03 ; $5765
	script_get_actor_state $03 ; $576a
	ld c, l ; $576f
	ld b, h ; $5770
	ld hl, $0005 ; $5771
	add hl, bc ; $5774
	set 3, [hl] ; $5775
	call SetDormRoomEventTriggerCells_13 ; $5777
	script_face $03, FACE_DOWN ; $577a
	ret ; $5781
.accepted:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5782
	jr nz, .acceptedAlt ; $5785
	script_set_text Text_31_313 ; $5787
	jr .setUpDoubles ; $578d
.acceptedAlt:
	script_set_text Text_31_307 ; $578f
.setUpDoubles:
	ld a, $03 ; $5795
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5797
	farcall RunDialogueYesNoPrompt ; $579a
	farcall ScriptCloseDialogueWindow ; $579d
	script_wait_frames $05 ; $57a0
	and a ; $57a7
	jr nz, .done ; $57a8
	call SetRoommateSinglesYesReplyText_13 ; $57aa
	script_speak $03 ; $57ad
	script_null_script $03 ; $57b2
	clear_flag FLAG_DOUBLES ; $57b7
	wram_bank $04 ; $57ba
	ld a, $00 ; $57c0
	ld [wMatchIsDoubles], a ; $57c2
	script_move_target $03, $0b00, $0900 ; $57c5
	script_wait_move $03 ; $57d0
	script_wait_frames $05 ; $57d5
	script_face $03, FACE_DOWN ; $57dc
	script_wait_frames $05 ; $57e3
	script_get_actor_state $03 ; $57ea
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, $0005 ; $57f1
	add hl, bc ; $57f4
	set 3, [hl] ; $57f5
	call SetDormRoomEventTriggerCells_13 ; $57f7
	script_null_script $03 ; $57fa
	script_face $03, FACE_DOWN ; $57ff
	ret ; $5806
.done:
	call SetRoommateSinglesNoReplyText_13 ; $5807
	farcall AdvanceDialogueTextCursor ; $580a
	script_speak $03 ; $580d
	script_set_anim ACTOR_PLAYER, $03 ; $5812
	script_wait_idle ACTOR_PLAYER ; $5819
	script_face ACTOR_PLAYER, FACE_DOWN ; $581e
	script_wait_frames $05 ; $5825
	wram_bank $04 ; $582c
	ld a, $01 ; $5832
	ld [wMatchIsDoubles], a ; $5834
	set_flag FLAG_DOUBLES ; $5837
	call SetDormRoomEventTriggerCells_13 ; $583a
	script_get_actor_state $03 ; $583d
	ld c, l ; $5842
	ld b, h ; $5843
	ld de, wActors ; $5844
	farcall AttachActorStepMover ; $5847
	script_get_actor_state $03 ; $584a
	ld c, l ; $584f
	ld b, h ; $5850
	ld hl, $0005 ; $5851
	add hl, bc ; $5854
	set 4, [hl] ; $5855
	script_face ACTOR_PLAYER, FACE_DOWN ; $5857
	ret ; $585e
ActorScript_13_585f:
	; $585f, 24 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_set_field $14, FACE_DOWN
	as_wait $b4
	as_rand_box $02, $02
	as_wait_move2
	as_set_field $14, FACE_UP
	as_wait $b4
	as_jump .L1
ActorScript_13_5877:
	; $5877, 10 bytes (actor_script)
	as_set_pos $0f40, $0ee0
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_5881:
	; $5881, 10 bytes (actor_script)
	as_set_pos $1100, $0380
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_588b:
	; $588b, 51 bytes (actor_script)
	as_set_pos $0300, $0700
	as_set_field $14, FACE_UP
	as_begin_path
.La:
	as_set_field $14, FACE_DOWN
	as_wait $b4
	as_set_target $0300, $0800
	as_wait_move2
	as_wait $50
	as_set_field $14, FACE_RIGHT
	as_wait $12
	as_set_target $0300, $0700
	as_wait_move2
	as_set_field $14, FACE_UP
	as_wait $f0
	as_set_field $14, FACE_RIGHT
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
	ld hl, $054c ; $58d4
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $58d7
	jr z, .runMenu ; $58da
	ld hl, $054d ; $58dc
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $58df
	jr z, .runMenu ; $58e2
	ld hl, $054e ; $58e4
.runMenu:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	farcall RunPagedTextMenu ; $58ec
	cp $ff ; $58ef
	jp z, .done ; $58f1
	add a ; $58f4
	add $28 ; $58f5
	ld l, a ; $58f7
	adc $59 ; $58f8
	sub l ; $58fa
	ld h, a ; $58fb
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	script_speak $03 ; $5902
	ld hl, wMapScratch ; $5907
	ld a, [hl+] ; $590a
	ld h, [hl] ; $590b
	ld l, a ; $590c
	farcall InitDialogueTextCursor ; $590d
	ld a, $03 ; $5910
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5912
	farcall RunDialogueYesNoPrompt ; $5915
	farcall ScriptCloseDialogueWindow ; $5918
	script_wait_frames $05 ; $591b
	and a ; $5922
	jr nz, .done ; $5923
	jr .menuLoop ; $5925
.done:
	ret ; $5927
	ld [hl], $59 ; $5928
	ld l, b ; $592a
	ld e, c ; $592b
	and [hl] ; $592c
	ld e, c ; $592d
	ret nz ; $592e
	ld e, c ; $592f
	and $59 ; $5930
	nop ; $5932
	ld e, d ; $5933
	ld a, [de] ; $5934
	ld e, d ; $5935
	ld de, $0001 ; $5936
	ld hl, wMapScratch ; $5939
	ld a, [hl+] ; $593c
	ld h, [hl] ; $593d
	ld l, a ; $593e
	add hl, de ; $593f
AcademyTopicSinglesRank:
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
	ld de, $0013 ; $5a1a
	ld hl, wMapScratch ; $5a1d
	ld a, [hl+] ; $5a20
	ld h, [hl] ; $5a21
	ld l, a ; $5a22
	add hl, de ; $5a23
	farcall InitDialogueTextCursor ; $5a24
	ret ; $5a27
ShowStoryNarration_13:
	sound $00 ; $5a28
	script_set_position $03, $3f00, $3f00 ; $5a2a
	script_set_position $04, $3f00, $3f00 ; $5a35
	script_set_active ACTOR_PLAYER, $00 ; $5a40
	script_set_active ACTOR_PARTNER, $00 ; $5a47
	script_copy_scene_rect $00, $20, $00, $00, $16, $18 ; $5a4e
	script_fade_in $08 ; $5a5d
	script_wait_frames $04 ; $5a62
	script_speak $85 ; $5a69
	script_wait_frames $04 ; $5a6e
	ret ; $5a75
.setText:
	script_set_text Text_30_496 ; $5a76
	call ShowStoryNarration_13 ; $5a7c
	ld a, $14 ; $5a7f
	ld [wStoryModeCurrentLocation], a ; $5a81
	ld a, $0a ; $5a84
	ld [wStoryModeEntryPoint], a ; $5a86
	ld a, $ff ; $5a89
	ld [wUnusedExitLocationMirror], a ; $5a8b
	ld [wStoryModeExitLocationRequest], a ; $5a8e
	ret ; $5a91
.setText2:
	script_set_text Text_30_497 ; $5a92
	call ShowStoryNarration_13 ; $5a98
	ld a, $15 ; $5a9b
	ld [wStoryModeCurrentLocation], a ; $5a9d
	ld a, $0f ; $5aa0
	ld [wStoryModeEntryPoint], a ; $5aa2
	ld a, $ff ; $5aa5
	ld [wUnusedExitLocationMirror], a ; $5aa7
	ld [wStoryModeExitLocationRequest], a ; $5aaa
	ret ; $5aad
.setText3:
	script_set_text Text_30_496 ; $5aae
	call ShowStoryNarration_13 ; $5ab4
	ld a, $14 ; $5ab7
	ld [wStoryModeCurrentLocation], a ; $5ab9
	ld a, $0a ; $5abc
	ld [wStoryModeEntryPoint], a ; $5abe
	ld a, $ff ; $5ac1
	ld [wUnusedExitLocationMirror], a ; $5ac3
	ld [wStoryModeExitLocationRequest], a ; $5ac6
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
	script_set_position ACTOR_PARTNER, $0b00, $1e00 ; $5b06
	script_face ACTOR_PARTNER, FACE_DOWN ; $5b11
	script_set_position $03, $0b00, $0a00 ; $5b18
	script_face $03, FACE_DOWN ; $5b23
	script_fade_in $04 ; $5b2a
	call WaitFadeEnd ; $5b2f
	test_flag FLAG_DOUBLES ; $5b32
	jr z, .singles ; $5b35
	farcall AdvanceDialogueTextCursor ; $5b37
	script_speak $03 ; $5b3a
	script_speak $03 ; $5b3f
	script_set_anim ACTOR_PLAYER, $03 ; $5b44
	script_wait_idle ACTOR_PLAYER ; $5b4b
	script_face ACTOR_PLAYER, FACE_DOWN ; $5b50
	script_wait_frames $05 ; $5b57
	script_get_actor_state $03 ; $5b5e
	ld c, l ; $5b63
	ld b, h ; $5b64
	ld de, $d000 ; $5b65
	farcall AttachActorStepMover ; $5b68
	script_get_actor_state $03 ; $5b6b
	ld c, l ; $5b70
	ld b, h ; $5b71
	ld hl, $0005 ; $5b72
	add hl, bc ; $5b75
	set 4, [hl] ; $5b76
	ret ; $5b78
.singles:
	script_speak $03 ; $5b79
	script_set_anim ACTOR_PLAYER, $03 ; $5b7e
	script_wait_idle ACTOR_PLAYER ; $5b85
	ret ; $5b8a
SetRoommateDoublesNoReplyText_13:
	call GetDormRoomStoryStage_13 ; $5b8b
	cp $01 ; $5b8e
	jp nz, .done ; $5b90
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5b93
	jr z, .setText ; $5b96
	script_set_text Text_31_275 ; $5b98
	jr .done ; $5b9e
.setText:
	script_set_text Text_31_270 ; $5ba0
.done:
	ret ; $5ba6
SetRoommateSinglesNoReplyText_13:
	call GetDormRoomStoryStage_13 ; $5ba7
	cp $01 ; $5baa
	jp nz, .done ; $5bac
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5baf
	jr z, .setText ; $5bb2
	script_set_text Text_31_276 ; $5bb4
	jr .done ; $5bba
.setText:
	script_set_text Text_31_271 ; $5bbc
.done:
	ret ; $5bc2
SetRoommateSinglesYesReplyText_13:
	call GetDormRoomStoryStage_13 ; $5bc3
	cp $01 ; $5bc6
	jp nz, .done ; $5bc8
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5bcb
	jr z, .setText ; $5bce
	script_set_text Text_31_276 ; $5bd0
	jr .done ; $5bd6
.setText:
	script_set_text Text_31_271 ; $5bd8
.done:
	ret ; $5bde
SetRoommateDoublesYesReplyText_13:
	call GetDormRoomStoryStage_13 ; $5bdf
	cp $01 ; $5be2
	jp nz, .done ; $5be4
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5be7
	jr z, .setText ; $5bea
	script_set_text Text_31_277 ; $5bec
	jr .done ; $5bf2
.setText:
	script_set_text Text_31_272 ; $5bf4
.done:
	ret ; $5bfa
ComputeEmoteActorPosition_13:
	farcall GetActorStateAddr ; $5bfb
	ld c, l ; $5bfe
	ld b, h ; $5bff
	ld hl, $000c ; $5c00
	add hl, bc ; $5c03
	ld a, [hl+] ; $5c04
	ld h, [hl] ; $5c05
	ld l, a ; $5c06
	ld de, $0180 ; $5c07
	add hl, de ; $5c0a
	ld e, l ; $5c0b
	ld d, h ; $5c0c
	ld hl, wMapScratch + 6 ; $5c0d
	ld a, e ; $5c10
	ld [hl+], a ; $5c11
	ld [hl], d ; $5c12
	ld hl, $000e ; $5c13
	add hl, bc ; $5c16
	ld a, [hl+] ; $5c17
	ld h, [hl] ; $5c18
	ld l, a ; $5c19
	ld de, $fe80 ; $5c1a
	add hl, de ; $5c1d
	ld e, l ; $5c1e
	ld d, h ; $5c1f
	ld hl, wMapScratch + 8 ; $5c20
	ld a, e ; $5c23
	ld [hl+], a ; $5c24
	ld [hl], d ; $5c25
	ret ; $5c26
PlaceEmoteActorAtComputedPosition_13:
	ld hl, wMapScratch + 6 ; $5c27
	ld a, [hl+] ; $5c2a
	ld b, [hl] ; $5c2b
	ld c, a ; $5c2c
	ld hl, wMapScratch + 8 ; $5c2d
	ld a, [hl+] ; $5c30
	ld d, [hl] ; $5c31
	ld e, a ; $5c32
	ld a, $05 ; $5c33
	farcall ScriptSetActorPosition ; $5c35
	ret ; $5c38
PlaceRoommateAtPlayerTarget_13:
	script_get_actor_state ACTOR_PLAYER ; $5c39
	ld c, l ; $5c3e
	ld b, h ; $5c3f
	ld hl, $000c ; $5c40
	add hl, bc ; $5c43
	ld a, [hl+] ; $5c44
	ld h, [hl] ; $5c45
	ld l, a ; $5c46
	ld de, $0000 ; $5c47
	add hl, de ; $5c4a
	ld e, l ; $5c4b
	ld d, h ; $5c4c
	ld hl, wMapScratch + 6 ; $5c4d
	ld a, e ; $5c50
	ld [hl+], a ; $5c51
	ld [hl], d ; $5c52
	ld hl, $000e ; $5c53
	add hl, bc ; $5c56
	ld a, [hl+] ; $5c57
	ld h, [hl] ; $5c58
	ld l, a ; $5c59
	ld de, $0000 ; $5c5a
	add hl, de ; $5c5d
	ld e, l ; $5c5e
	ld d, h ; $5c5f
	ld hl, wMapScratch + 8 ; $5c60
	ld a, e ; $5c63
	ld [hl+], a ; $5c64
	ld [hl], d ; $5c65
	ld hl, wMapScratch + 6 ; $5c66
	ld a, [hl+] ; $5c69
	ld b, [hl] ; $5c6a
	ld c, a ; $5c6b
	ld hl, wMapScratch + 8 ; $5c6c
	ld a, [hl+] ; $5c6f
	ld d, [hl] ; $5c70
	ld e, a ; $5c71
	ld a, $03 ; $5c72
	farcall ScriptSetActorPosition ; $5c74
	ret ; $5c77
CourtyardMapScripts_13:
	; $5c78, 14 bytes (map_tree)
	dw CourtyardEntryPoints_13 ; slot 0 EntryPoints
	dw CourtyardExitTriggers_13 ; slot 1 ExitTriggers
	dw CourtyardActors_13 ; slot 2 Actors
	dw CourtyardNpcScripts_13 ; slot 3 NpcScripts
	dw CourtyardFacingScripts_13 ; slot 4 FacingScripts
	dw CourtyardTileTriggers_13 ; slot 5 TileTriggers
	dw CourtyardInitScript_13 ; slot 6 InitScript
CourtyardActors_13:
	; $5c86, 94 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $0d00, $1d00, FACE_DOWN, $4b, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0500, $1d00, FACE_RIGHT, $68, $01, $07
	map_actor $0000, ActorScript_13_7a40, $0d00, $2300, FACE_UP, $65, $06, $03
	map_actor $0000, ActorScript_13_7b25, $0800, $1300, FACE_UP, $67, $01, $06
	map_actor $0000, ActorScript_13_7b2f, $0f00, $1700, FACE_DOWN, $6b, $01, $06
	map_actor $0000, ActorScript_13_7b25, $10c0, $1a60, FACE_LEFT, $36, $01, $00
	map_actor_end
VarsityCourtActorsA_13:
	; $5ce4, 108 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $0d00, $1d00, FACE_DOWN, $4b, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0500, $1d00, FACE_RIGHT, $68, $01, $07
	map_actor $0000, ActorScript_13_7a40, $0d00, $2300, FACE_UP, $65, $01, $03
	map_actor $0000, ActorScript_13_7b25, $0800, $1300, FACE_UP, $67, $01, $04
	map_actor $0000, ActorScript_13_7b2f, $0f00, $1700, FACE_DOWN, $6b, $01, $06
	map_actor $0000, ActorScript_13_7b25, $2d00, $3d00, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_13_7b25, $10c0, $1a60, FACE_LEFT, $36, $01, $00
	map_actor_end
VarsityCourtActorsB_13:
	; $5d50, 122 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $0d00, $1d00, FACE_DOWN, $4b, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0500, $2300, FACE_UP, $68, $01, $07
	map_actor $0000, ActorScript_13_7a40, $0d00, $2500, FACE_UP, $65, $01, $03
	map_actor $0000, ActorScript_13_7b25, $1000, $2500, FACE_LEFT, $67, $01, $04
	map_actor $0000, ActorScript_13_7b25, $0800, $1300, FACE_UP, $6b, $01, $06
	map_actor $0000, ActorScript_13_7b25, $2d00, $3d00, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0500, $2100, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_13_7b25, $10c0, $1a60, FACE_LEFT, $36, $01, $00
	map_actor_end
VarsityCourtActorsC_13:
	; $5dca, 52 bytes (map_actors)
	map_actor $0000, ActorScript_13_7a40, $1000, $1500, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_13_7a40, $0d00, $2500, FACE_UP, $65, $01, $03
	map_actor $0000, ActorScript_13_7b25, $10c0, $1a60, FACE_LEFT, $36, $01, $00
	map_actor_end
VarsityCourtActorsD_13:
	; $5dfe, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_7a40, $0d00, $1d00, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_13_7a40, $0d00, $2300, FACE_UP, $65, $01, $03
	map_actor $0000, ActorScript_13_7b2f, $0900, $1500, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_13_7b25, $10c0, $1a60, FACE_LEFT, $36, $01, $00
	map_actor_end
CourtyardEntryPoints_13:
	; $5e40, 57 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3600, $1600, $0000
	map_entry $02, FACE_DOWN, $2200, $0b00, $0000
	map_entry $03, FACE_UP, $2200, $3100, $0000
	map_entry $0a, FACE_UP, $1100, $1d00, $0000
	map_entry $0d, FACE_UP, $0d00, $1f00, $0000
	map_entry $0e, FACE_UP, $0f00, $1f00, $0000
	map_entry $0f, FACE_UP, $2200, $2f00, $0000
	db $ff
CourtyardExitTriggers_13:
	; $5e79, 49 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, $0000, $11, $01
	map_script $02, FACEMASK_ANY, $0000, $0000, $08, $04
	map_script $03, FACEMASK_ANY, $0000, $0000, $05, $02
	map_script $0a, FACEMASK_ANY, $0000, MapScriptNop_13, $00, $0a
	map_script $0e, FACEMASK_ANY, $0000, $0000, $07, $0e
	map_script $0f, FACEMASK_ANY, $0000, $0000, $08, $0f
	db $ff
CourtyardNpc03_13:
	script_set_text Text_30_527 ; $5eaa
	test_flag FLAG_DOUBLES ; $5eb0
	jr z, .notDoubles ; $5eb3
	script_set_text Text_30_529 ; $5eb5
.notDoubles:
	ld a, $03 ; $5ebb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5ebd
	farcall RunDialogueYesNoPrompt ; $5ec0
	farcall ScriptCloseDialogueWindow ; $5ec3
	script_wait_frames $05 ; $5ec6
	and a ; $5ecd
	jr nz, .speak ; $5ece
	script_set_text Text_30_531 ; $5ed0
.speak:
	script_speak $03 ; $5ed6
	ret ; $5edb
CourtyardNpcScripts_13:
	; $5edc, 57 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, CourtyardNpc03_13, $03, $00
	map_script $04, FACEMASK_ANY, $05e0, Text_30_532, $03, $00
	map_script $05, FACEMASK_ANY, $05e0, Text_30_533, $1b, $00
	map_script $04, FACEMASK_ANY, $0000, Text_30_536, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_30_537, $1b, $00
	map_script $06, FACEMASK_ANY, $0000, Text_30_534, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_30_535, $13, $00
	db $ff
VarsityCourtANpc05_13:
	script_null_script $05 ; $5f15
	script_set_anim $05, $01 ; $5f1a
	script_set_text Text_30_539 ; $5f21
	ld a, $05 ; $5f27
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f29
	farcall RunDialogueYesNoPrompt ; $5f2c
	farcall ScriptCloseDialogueWindow ; $5f2f
	script_wait_frames $05 ; $5f32
	and a ; $5f39
	jr z, .advanceText ; $5f3a
	script_speak $05 ; $5f3c
	script_set_actor_script $05, ActorScript_13_7a40 ; $5f41
	ret ; $5f4c
.advanceText:
	farcall AdvanceDialogueTextCursor ; $5f4d
	script_speak $05 ; $5f50
	ld hl, wStoryModePlayersXPosition ; $5f55
	ld de, wStoryModeSpawnPosition ; $5f58
	ld bc, $0005 ; $5f5b
	call CopyMemoryBC ; $5f5e
	ld a, $ff ; $5f61
	ld [wStoryModeEntryPoint], a ; $5f63
	ld [wUnusedExitLocationMirror], a ; $5f66
	ld [wStoryModeExitLocationRequest], a ; $5f69
	call SetupStoryMinigameMatch0 ; $5f6c
	ret ; $5f6f
VarsityCourtNpcScriptsA_13:
	; $5f70, 49 bytes (map_scripts)
	map_script $03, FACEMASK_UP, $0000, VarsityCourtANpc03FaceUp_13, $03, $00
	map_script $03, FACEMASK_ANY, $0000, VarsityCourtANpc03_13, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_30_538, $03, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtANpc05_13, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_30_542, $13, $00
	map_script $07, FACEMASK_ANY, $0000, Text_30_543, $13, $00
	db $ff
VarsityCourtBNpc09_13:
	script_set_text Text_31_3 ; $5fa1
	ld a, $09 ; $5fa7
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5fa9
	farcall RunDialogueYesNoPrompt ; $5fac
	farcall ScriptCloseDialogueWindow ; $5faf
	script_wait_frames $05 ; $5fb2
	and a ; $5fb9
	jr z, .speak ; $5fba
	farcall AdvanceDialogueTextCursor ; $5fbc
.speak:
	script_speak $09 ; $5fbf
	ret ; $5fc4
VarsityCourtBNpc05_13:
	script_null_script $05 ; $5fc5
	script_set_anim $05, $01 ; $5fca
	script_set_text Text_31_7 ; $5fd1
	ld a, $05 ; $5fd7
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5fd9
	farcall RunDialogueYesNoPrompt ; $5fdc
	farcall ScriptCloseDialogueWindow ; $5fdf
	script_wait_frames $05 ; $5fe2
	and a ; $5fe9
	jr z, .advanceText ; $5fea
	script_speak $05 ; $5fec
	script_set_actor_script $05, ActorScript_13_7a40 ; $5ff1
	ret ; $5ffc
.advanceText:
	farcall AdvanceDialogueTextCursor ; $5ffd
	script_speak $05 ; $6000
	ld hl, wStoryModePlayersXPosition ; $6005
	ld de, wStoryModeSpawnPosition ; $6008
	ld bc, $0005 ; $600b
	call CopyMemoryBC ; $600e
	ld a, $ff ; $6011
	ld [wStoryModeEntryPoint], a ; $6013
	ld [wUnusedExitLocationMirror], a ; $6016
	ld [wStoryModeExitLocationRequest], a ; $6019
	call SetupVarsityCourtDoublesMatch_13 ; $601c
	ret ; $601f
VarsityCourtNpcScriptsB_13:
	; $6020, 57 bytes (map_scripts)
	map_script $03, FACEMASK_UP, $0000, VarsityCourtBNpc03FaceUp_13, $03, $00
	map_script $03, FACEMASK_ANY, $0000, VarsityCourtBNpc03_13, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_31_6, $03, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtBNpc05_13, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_31_10, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_31_11, $13, $00
	map_script $09, FACEMASK_ANY, $0000, VarsityCourtBNpc09_13, $03, $00
	db $ff
VarsityCourtCNpc03_13:
	script_null_script $03 ; $6059
	script_set_anim $03, $01 ; $605e
	script_set_text Text_31_34 ; $6065
	script_speak $03 ; $606b
	script_set_actor_script $03, ActorScript_13_7a40 ; $6070
	ret ; $607b
VarsityCourtCNpc04_13:
	script_null_script $03 ; $607c
	script_set_anim $04, $01 ; $6081
	script_set_text Text_31_35 ; $6088
	script_speak $04 ; $608e
	script_set_actor_script $04, ActorScript_13_7a40 ; $6093
	ret ; $609e
VarsityCourtNpcScriptsC_13:
	; $609f, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, VarsityCourtCNpc03_13, $03, $00
	map_script $04, FACEMASK_ANY, $0000, VarsityCourtCNpc04_13, $03, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtCNpc05_13, $13, $00
	db $ff
VarsityCourtCNpc05_13:
	script_set_text Text_31_36 ; $60b8
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $60be
	jr z, .speak ; $60c1
	farcall AdvanceDialogueTextCursor ; $60c3
.speak:
	script_speak $05 ; $60c6
	ret ; $60cb
VarsityCourtDNpc05_13:
	script_null_script $05 ; $60cc
	script_set_anim $05, $01 ; $60d1
	script_set_text Text_31_40 ; $60d8
	script_speak $05 ; $60de
	script_set_actor_script $05, ActorScript_13_7a40 ; $60e3
	ret ; $60ee
VarsityCourtNpcScriptsD_13:
	; $60ef, 41 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_31_38, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_31_39, $03, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtDNpc05_13, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_31_41, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_31_42, $13, $00
	db $ff
VarsityCourtENpc05_13:
	script_null_script $05 ; $6118
	script_set_anim $05, $01 ; $611d
	script_set_text Text_31_45 ; $6124
	script_speak $05 ; $612a
	script_set_actor_script $05, ActorScript_13_7a40 ; $612f
	ret ; $613a
VarsityCourtNpcScriptsE_13:
	; $613b, 41 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_31_43, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_31_44, $03, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtENpc05_13, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_31_46, $13, $00
	map_script $07, FACEMASK_ANY, $0000, Text_31_47, $13, $00
	db $ff
CourtyardFacingScripts_13:
	; $6164, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, CourtyardFacing01_13, $00, $00
	db $ff
CourtyardFacing01_13:
	call ShowStoryTournamentBracket_13 ; $616d
	ld hl, wStoryModePlayersXPosition ; $6170
	ld de, wStoryModeSpawnPosition ; $6173
	ld bc, $0005 ; $6176
	call CopyMemoryBC ; $6179
	ld a, $ff ; $617c
	ld [wStoryModeEntryPoint], a ; $617e
	ld [wUnusedExitLocationMirror], a ; $6181
	ld [wStoryModeExitLocationRequest], a ; $6184
	ret ; $6187
CourtyardTileTriggers_13:
	ds 1, $ff ; $6188, fill
CourtyardInitScript_13:
	call SetupVarsityCourtSceneVariant ; $6189
	ld a, [wStoryModeEntryPoint] ; $618c
	cp $0f ; $618f
	jr nz, .doubles ; $6191
	jp VarsityCourtTourCutscene ; $6193
.doubles:
	cp $0d ; $6196
	jr nz, .placeActors ; $6198
	call RunTravelingTeamBracketIfWon_13 ; $619a
	ret ; $619d
.placeActors:
	cp $0e ; $619e
	jr nz, .done ; $61a0
	jp RunTravelingTeamVictoryCutscene_13 ; $61a2
.done:
	call CourtyardEntryWalkIn_13 ; $61a5
	ret ; $61a8
SetupVarsityCourtSceneVariant:
	test_flag FLAG_DOUBLES ; $61a9
	jr nz, .stage3 ; $61ac
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $61ae
	jr z, .stage1 ; $61b1
	ld hl, VarsityCourtNpcScriptsD_13 ; $61b3
	ld de, $000c ; $61b6
	farcall WriteStoryStateWord ; $61b9
	ld a, $18 ; $61bc
	ld d, $08 ; $61be
	ld e, $10 ; $61c0
	farcall WriteBehaviorMapCell ; $61c2
	ld a, $18 ; $61c5
	ld d, $06 ; $61c7
	ld e, $10 ; $61c9
	farcall WriteBehaviorMapCell ; $61cb
	script_set_position $06, $0500, $1500 ; $61ce
	script_face $06, FACE_RIGHT ; $61d9
	ret ; $61e0
.stage1:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $61e1
	jr z, .stage2 ; $61e4
	ldh a, [hRomBank] ; $61e6
	ld hl, VarsityCourtActorsC_13 ; $61e8
	farcall ScriptRespawnLocationActors ; $61eb
	ld hl, VarsityCourtNpcScriptsC_13 ; $61ee
	ld de, $000c ; $61f1
	farcall WriteStoryStateWord ; $61f4
	ld a, $18 ; $61f7
	ld d, $08 ; $61f9
	ld e, $10 ; $61fb
	farcall WriteBehaviorMapCell ; $61fd
	ld a, $18 ; $6200
	ld d, $06 ; $6202
	ld e, $10 ; $6204
	farcall WriteBehaviorMapCell ; $6206
	ret ; $6209
.stage2:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $620a
	jp z, .done ; $620d
	ldh a, [hRomBank] ; $6210
	ld hl, VarsityCourtActorsA_13 ; $6212
	farcall ScriptRespawnLocationActors ; $6215
	ld hl, VarsityCourtNpcScriptsA_13 ; $6218
	ld de, $000c ; $621b
	farcall WriteStoryStateWord ; $621e
	ret ; $6221
.stage3:
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $6222
	jr z, .stage4 ; $6225
	ldh a, [hRomBank] ; $6227
	ld hl, VarsityCourtActorsB_13 ; $6229
	farcall ScriptRespawnLocationActors ; $622c
	ld hl, VarsityCourtNpcScriptsE_13 ; $622f
	ld de, $000c ; $6232
	farcall WriteStoryStateWord ; $6235
	script_set_position $09, $3f00, $3f00 ; $6238
	script_face $04, FACE_RIGHT ; $6243
	script_set_actor_script $06, ActorScript_13_7cf5 ; $624a
	ld a, $18 ; $6255
	ld d, $08 ; $6257
	ld e, $10 ; $6259
	farcall WriteBehaviorMapCell ; $625b
	ld a, $18 ; $625e
	ld d, $06 ; $6260
	ld e, $10 ; $6262
	farcall WriteBehaviorMapCell ; $6264
	script_set_position $07, $0f00, $1700 ; $6267
	script_set_actor_script $07, ActorScript_13_7b2f ; $6272
	ret ; $627d
.stage4:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $627e
	jr z, .stage5 ; $6281
	ldh a, [hRomBank] ; $6283
	ld hl, VarsityCourtActorsD_13 ; $6285
	farcall ScriptRespawnLocationActors ; $6288
	ld hl, VarsityCourtNpcScriptsC_13 ; $628b
	ld de, $000c ; $628e
	farcall WriteStoryStateWord ; $6291
	ld a, $18 ; $6294
	ld d, $08 ; $6296
	ld e, $10 ; $6298
	farcall WriteBehaviorMapCell ; $629a
	ld a, $18 ; $629d
	ld d, $06 ; $629f
	ld e, $10 ; $62a1
	farcall WriteBehaviorMapCell ; $62a3
	ret ; $62a6
.stage5:
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $62a7
	jr z, .done ; $62aa
	ldh a, [hRomBank] ; $62ac
	ld hl, VarsityCourtActorsB_13 ; $62ae
	farcall ScriptRespawnLocationActors ; $62b1
	ld hl, VarsityCourtNpcScriptsB_13 ; $62b4
	ld de, $000c ; $62b7
	farcall WriteStoryStateWord ; $62ba
.done:
	ret ; $62bd
ApplyPartnerCharacterVariant_13:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $62be
	or a ; $62c1
	jr nz, .done ; $62c2
	script_set_objdef $28, $0d ; $62c4
	script_set_anim $0d, $01 ; $62d0
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $62d7
.done:
	ret ; $62da
Table_13_62db:
	; $62db, 36 bytes (bytes:12)
	db $0d, $12, $80, $ff, $01, $1e, $0d, $12, $60, $ff, $01, $32 ; 0x00
	db $10, $03, $01, $1e, $10, $01, $10, $03, $01, $5a, $0c, $e9 ; 0x0c
	db $ff, $10, $02, $01, $5a, $10, $04, $01, $96, $0c, $f7, $ff ; 0x18
CourtyardEntryWalkIn_13:
	ld a, [wStoryModeEntryPoint] ; $62ff
	cp $ff ; $6302
	jp z, .done ; $6304
	test_flag FLAG_DOUBLES ; $6307
	jr z, .walkOff ; $630a
	script_set_speed ACTOR_PARTNER, $00ff ; $630c
	ld a, [wStoryModeEntryPoint] ; $6314
	dec a ; $6317
	add $69 ; $6318
	ld l, a ; $631a
	adc $63 ; $631b
	sub l ; $631d
	ld h, a ; $631e
	ld b, [hl] ; $631f
	ld a, $02 ; $6320
	ld b, b ; $6322
	ld de, $0200 ; $6323
	farcall MoveActorByAngle ; $6326
	script_wait_move ACTOR_PARTNER ; $6329
	ld a, [wStoryModeEntryPoint] ; $632e
	dec a ; $6331
	add LOW(Facings_13_6366) ; $6332
	ld l, a ; $6334
	adc HIGH(Facings_13_6366) ; $6335
	sub l ; $6337
	ld h, a ; $6338
	ld b, [hl] ; $6339
	ld a, $02 ; $633a
	ld b, b ; $633c
	farcall SetActorFacing ; $633d
	script_set_speed ACTOR_PARTNER, $0010 ; $6340
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $6348
	ld a, [wStoryModeEntryPoint] ; $6350
	dec a ; $6353
	add LOW(Facings_13_6366) ; $6354
	ld l, a ; $6356
	adc HIGH(Facings_13_6366) ; $6357
	sub l ; $6359
	ld h, a ; $635a
	ld b, [hl] ; $635b
	ld a, $00 ; $635c
	ld b, b ; $635e
	ld de, $0200 ; $635f
	farcall MoveActorByAngle ; $6362
.done:
	ret ; $6365
Facings_13_6366:
	; $6366, 6 bytes (enum:FACE:6)
	db FACE_DOWN, FACE_DOWN, FACE_UP, FACE_UP, FACE_UP, FACE_DOWN ; 0x00
VarsityCourtTourCutscene:
	ldh a, [hRomBank] ; $636c
	ld hl, VarsityCourtTourActors_13 ; $636e
	farcall ScriptRespawnLocationActors ; $6371
	farcall BeginCutsceneScriptMode ; $6374
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $6377
	script_set_position $06, $3f00, $3f00 ; $6382
	script_fade_in $04 ; $638d
	call WaitFadeEnd ; $6392
	script_set_position $06, $2200, $3300 ; $6395
	script_move_target $06, $2200, $1d00 ; $63a0
	script_wait_frames $0f ; $63ab
	script_move_player $2200, $1d00 ; $63b2
	script_set_position ACTOR_PLAYER, $2200, $3300 ; $63bc
	script_move_target ACTOR_PLAYER, $2200, $2100 ; $63c7
	script_wait_move ACTOR_PLAYER ; $63d2
	script_wait_frames $0f ; $63d7
	script_move_target ACTOR_PLAYER, $2000, $1f00 ; $63de
	script_wait_move ACTOR_PLAYER ; $63e9
	script_wait_frames $1e ; $63ee
	script_face $06, FACE_LEFT ; $63f5
	script_wait_frames $1e ; $63fc
	script_face ACTOR_PLAYER, FACE_LEFT ; $6403
	script_wait_frames $1e ; $640a
	script_move_player $0c00, $1b00 ; $6411
	farcall WaitPlayerMoveDone ; $641b
	script_wait_frames $1e ; $641e
	script_set_text Text_30_518 ; $6425
	script_speak $06 ; $642b
	script_wait_frames $0f ; $6430
	script_player_speed $0040 ; $6437
	script_move_player $2200, $1d00 ; $643d
	farcall WaitPlayerMoveDone ; $6447
	script_player_speed $0020 ; $644a
	script_set_position $04, $2100, $1d00 ; $6450
	sound $98 ; $645b
	script_wait_frames $32 ; $645d
	script_set_position $04, $3f00, $3f00 ; $6464
	script_set_anim $06, $02 ; $646f
	script_wait_idle $06 ; $6476
	script_speak $06 ; $647b
	script_wait_frames $1e ; $6480
	script_face $06, FACE_DOWN ; $6487
	script_wait_frames $0f ; $648e
	script_speak $06 ; $6495
	script_face $06, FACE_LEFT ; $649a
	script_wait_frames $0f ; $64a1
	script_player_speed $0040 ; $64a8
	script_move_player $0c00, $1600 ; $64ae
	farcall WaitPlayerMoveDone ; $64b8
	script_player_speed $0020 ; $64bb
	script_wait_frames $3c ; $64c1
	script_move_player $0c00, $2200 ; $64c8
	farcall WaitPlayerMoveDone ; $64d2
	script_wait_frames $3c ; $64d5
	script_move_player $0c00, $1b00 ; $64dc
	farcall WaitPlayerMoveDone ; $64e6
	script_speak $06 ; $64e9
	script_wait_frames $0f ; $64ee
	script_player_speed $0040 ; $64f5
	script_move_player $2200, $1d00 ; $64fb
	farcall WaitPlayerMoveDone ; $6505
	script_player_speed $0020 ; $6508
	script_wait_frames $1e ; $650e
	script_face $06, FACE_RIGHT ; $6515
	script_wait_frames $0f ; $651c
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6523
	script_move_player $3000, $2600 ; $652a
	farcall WaitPlayerMoveDone ; $6534
	script_speak $06 ; $6537
	script_wait_frames $0f ; $653c
	script_move_player $3600, $1000 ; $6543
	farcall WaitPlayerMoveDone ; $654d
	script_speak $06 ; $6550
	script_wait_frames $0f ; $6555
	script_player_speed $0040 ; $655c
	script_move_player $2200, $1d00 ; $6562
	farcall WaitPlayerMoveDone ; $656c
	script_player_speed $0020 ; $656f
	script_wait_frames $0f ; $6575
	script_face $06, FACE_DOWN ; $657c
	script_speak $06 ; $6583
	script_wait_frames $1e ; $6588
	script_face ACTOR_PLAYER, FACE_UP ; $658f
	script_set_anim ACTOR_PLAYER, $03 ; $6596
	script_wait_idle ACTOR_PLAYER ; $659d
	script_wait_frames $0f ; $65a2
	script_set_anim $06, $02 ; $65a9
	script_wait_idle $06 ; $65b0
	script_speak $06 ; $65b5
	script_set_anim ACTOR_PLAYER, $02 ; $65ba
	script_wait_idle ACTOR_PLAYER ; $65c1
	script_wait_frames $1e ; $65c6
	script_set_anim $06, $03 ; $65cd
	script_wait_idle $06 ; $65d4
	script_speak $06 ; $65d9
	script_move_target ACTOR_PLAYER, $2200, $1f00 ; $65de
	script_wait_move ACTOR_PLAYER ; $65e9
	script_face ACTOR_PLAYER, FACE_UP ; $65ee
	script_wait_frames $0f ; $65f5
	script_move_target $06, $2200, $0700 ; $65fc
	script_wait_frames $05 ; $6607
	script_move_target ACTOR_PLAYER, $2200, $0700 ; $660e
	script_wait_frames $0a ; $6619
	script_move_player $2200, $0d00 ; $6620
	script_wait_move ACTOR_PLAYER ; $662a
	ld a, $0f ; $662f
	ld [wUnusedExitLocationMirror], a ; $6631
	ld [wStoryModeExitLocationRequest], a ; $6634
	ret ; $6637
VarsityCourtTourActors_13:
	; $6638, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_13_7b25, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_13_7b25, $2b00, $0b00, FACE_DOWN, $49, $01, $00
	map_actor_end
DecompressVarsityCourtTourRecords_13:
	ldh a, [hWramBank] ; $667a
	push af ; $667c
	wram_bank $01 ; $667d
	ld c, $04 ; $6683
	xor a ; $6685
.loop:
	push bc ; $6686
	push af ; $6687
	ld hl, VarsityCourtTourLzPtrs_13 ; $6688
	sla a ; $668b
	add l ; $668d
	ld l, a ; $668e
	jr nc, .read ; $668f
	inc h ; $6691
.read:
	ld a, [hl+] ; $6692
	ld h, [hl] ; $6693
	ld l, a ; $6694
	ld de, $d000 ; $6695
	call DecompressData ; $6698
	pop af ; $669b
	push af ; $669c
	ld hl, $8000 + VRAM_BANK1 ; $669d
	ld d, a ; $66a0
	ld e, $00 ; $66a1
	add hl, de ; $66a3
	ld d, h ; $66a4
	ld e, l ; $66a5
	ld hl, $d000 ; $66a6
	ld c, $10 ; $66a9
	call QueueVRAMCopy ; $66ab
	pop af ; $66ae
	pop bc ; $66af
	inc a ; $66b0
	dec c ; $66b1
	jr nz, .loop ; $66b2
	ld hl, VarsityCourtTourPalette_13 ; $66b4
	ld de, $0801 ; $66b7
	call LoadPaletteShadow ; $66ba
	pop af ; $66bd
	wram_bank ; $66be
	ret ; $66c2
QueueVarsityCourtTourSprites_13:
	ld a, [wCameraX + 1] ; $66c3
	cp $18 ; $66c6
	ret c ; $66c8
	ld a, [wCameraY + 1] ; $66c9
	cp $10 ; $66cc
	ret c ; $66ce
	ldh a, [hVBlankCounter] ; $66cf
	srl a ; $66d1
	srl a ; $66d3
	srl a ; $66d5
	and $03 ; $66d7
	push af ; $66d9
	ld hl, VarsityCourtTourSpritePtrs_13 ; $66da
	sla a ; $66dd
	add l ; $66df
	ld l, a ; $66e0
	jr nc, .read ; $66e1
	inc h ; $66e3
.read:
	ld a, [hl+] ; $66e4
	ld h, [hl] ; $66e5
	ld l, a ; $66e6
	pop af ; $66e7
	swap a ; $66e8
	ld c, a ; $66ea
	ldh a, [hScrollX] ; $66eb
	ld b, a ; $66ed
	ld a, $70 ; $66ee
	sub b ; $66f0
	ld d, a ; $66f1
	ldh a, [hScrollY] ; $66f2
	ld b, a ; $66f4
	ld a, $20 ; $66f5
	sub b ; $66f7
	ld e, a ; $66f8
	ld b, $08 ; $66f9
	call QueueSpriteTemplate ; $66fb
	ret ; $66fe
VarsityCourtTourSpritePtrs_13:
	; $66ff, 8 bytes (records:2)
	dw VarsityCourtTourSprite0_13 ; record 0
	dw VarsityCourtTourSprite1_13 ; record 1
	dw VarsityCourtTourSprite2_13 ; record 2
	dw VarsityCourtTourSprite3_13 ; record 3
VarsityCourtTourSprite0_13:
	INCBIN "data/bank_013/d_6707.bin" ; $6707, 33 bytes
VarsityCourtTourSprite1_13:
	INCBIN "data/bank_013/d_6728.bin" ; $6728, 33 bytes
VarsityCourtTourSprite2_13:
	INCBIN "data/bank_013/d_6749.bin" ; $6749, 33 bytes
VarsityCourtTourSprite3_13:
	INCBIN "data/bank_013/d_676a.bin" ; $676a, 33 bytes
VarsityCourtTourLzPtrs_13:
	; $678b, 8 bytes (records:2)
	dw VarsityCourtTourLz0_13 ; record 0
	dw VarsityCourtTourLz1_13 ; record 1
	dw VarsityCourtTourLz2_13 ; record 2
	dw VarsityCourtTourLz3_13 ; record 3
VarsityCourtTourLz0_13:
	INCBIN "data/bank_013/d_6793.bin" ; $6793, 158 bytes
VarsityCourtTourLz1_13:
	INCBIN "data/bank_013/d_6831.bin" ; $6831, 157 bytes
VarsityCourtTourLz2_13:
	INCBIN "data/bank_013/d_68ce.bin" ; $68ce, 161 bytes
VarsityCourtTourLz3_13:
	INCBIN "data/bank_013/d_696f.bin" ; $696f, 153 bytes
VarsityCourtTourPalette_13:
	INCBIN "data/bank_013/d_6a08.bin" ; $6a08, 8 bytes
SetupStoryMinigameMatch0:
	script_null_script $05 ; $6a10
	script_set_anim $05, $01 ; $6a15
	script_null_script $07 ; $6a1c
	script_set_speed $07, $0018 ; $6a21
	script_set_actor_script $03, ActorScript_13_6b19 ; $6a29
	script_set_actor_script $06, ActorScript_13_6b31 ; $6a34
	script_set_actor_script $07, ActorScript_13_6b47 ; $6a3f
	script_set_actor_script $05, ActorScript_13_6b69 ; $6a4a
	script_move_player $0c00, $1c00 ; $6a55
	farcall WaitPlayerMoveDone ; $6a5f
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_6be7 ; $6a62
	script_wait_actor_script $05 ; $6a6d
	farcall InitStoryMatchSettings ; $6a72
	load_match_settings $000a ; $6a75
	farcall RunStoryMatch ; $6a82
	farcall RestoreOverworldAfterMatch ; $6a85
	ret ; $6a88
SetupVarsityCourtDoublesMatch_13:
	script_null_script $05 ; $6a89
	script_null_script $07 ; $6a8e
	script_set_speed $07, $0018 ; $6a93
	script_set_anim $05, $01 ; $6a9b
	script_set_anim $05, $03 ; $6aa2
	script_wait_idle $05 ; $6aa9
	script_set_actor_script $05, ActorScript_13_6b69 ; $6aae
	script_set_actor_script $06, ActorScript_13_6b80 ; $6ab9
	script_set_actor_script $07, ActorScript_13_6b47 ; $6ac4
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_6be7 ; $6acf
	script_set_actor_script ACTOR_PARTNER, ActorScript_13_6bdc ; $6ada
	script_set_actor_script $03, ActorScript_13_6b19 ; $6ae5
	script_move_player $0c00, $1c00 ; $6af0
	farcall WaitPlayerMoveDone ; $6afa
	script_wait_actor_script $05 ; $6afd
	farcall InitStoryMatchSettings ; $6b02
	load_match_settings $010a ; $6b05
	farcall RunStoryMatch ; $6b12
	farcall RestoreOverworldAfterMatch ; $6b15
	ret ; $6b18
ActorScript_13_6b19:
	; $6b19, 11 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b24:
	; $6b24, 13 bytes (actor_script)
	as_anim $01
	as_set_target $1300, $2100
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b31:
	; $6b31, 11 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b3c:
	; $6b3c, 11 bytes (actor_script)
	as_set_target $1300, $2300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b47:
	; $6b47, 17 bytes (actor_script)
	as_set_target $1100, $1800
	as_wait_move
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b58:
	; $6b58, 17 bytes (actor_script)
	as_set_target $1100, $1300
	as_wait_move
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_6b69:
	; $6b69, 23 bytes (actor_script)
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_6b80:
	; $6b80, 23 bytes (actor_script)
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0d00, $1700
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_6b97:
	; $6b97, 23 bytes (actor_script)
	as_set_target $0700, $1d00
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_6bae:
	; $6bae, 23 bytes (actor_script)
	as_set_target $0700, $2100
	as_wait_move
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0d00, $1700
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_6bc5:
	; $6bc5, 23 bytes (actor_script)
	as_set_target $0700, $1f00
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_6bdc:
	; $6bdc, 11 bytes (actor_script)
	as_set_target $0b00, $1f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_6be7:
	; $6be7, 11 bytes (actor_script)
	as_set_target $0d00, $2300
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_6bf2:
	; $6bf2, 11 bytes (actor_script)
	as_set_target $0500, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_13_6bfd:
	; $6bfd, 11 bytes (actor_script)
	as_set_target $0500, $2300
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_6c08:
	; $6c08, 11 bytes (actor_script)
	as_set_target $0500, $2100
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
VarsityCourtANpc03FaceUp_13:
	script_set_speed ACTOR_PLAYER, $0008 ; $6c13
	script_facing_lock ACTOR_PLAYER, $01 ; $6c1b
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6c22
	script_wait_move ACTOR_PLAYER ; $6c2d
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $6c32
	script_face ACTOR_PLAYER, FACE_UP ; $6c39
VarsityCourtANpc03_13:
	script_set_text Text_30_544 ; $6c40
	ld a, $03 ; $6c46
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c48
	farcall RunDialogueYesNoPrompt ; $6c4b
	farcall ScriptCloseDialogueWindow ; $6c4e
	script_wait_frames $05 ; $6c51
	and a ; $6c58
	jp nz, .stage3 ; $6c59
	farcall AdvanceDialogueTextCursor ; $6c5c
	script_set_speed ACTOR_PLAYER, $0010 ; $6c5f
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6c67
	script_wait_move ACTOR_PLAYER ; $6c72
	script_face_toward $03, ACTOR_PLAYER ; $6c77
	script_wait_frames $1e ; $6c7f
	script_face_toward ACTOR_PLAYER, $03 ; $6c86
	script_speak $03 ; $6c8e
	script_set_speed ACTOR_PLAYER, $0020 ; $6c93
	script_wait_frames $0f ; $6c9b
	script_face_toward $04, $03 ; $6ca2
	script_wait_frames $1e ; $6caa
	script_face_toward $04, ACTOR_PLAYER ; $6cb1
	script_wait_frames $1e ; $6cb9
	script_player_speed $0020 ; $6cc0
	script_move_player_to_actor $04 ; $6cc6
	farcall WaitPlayerMoveDone ; $6ccd
	script_set_anim $04, $03 ; $6cd0
	script_wait_idle $04 ; $6cd7
	script_move_target $04, $0b00, $1f00 ; $6cdc
	script_move_player_to_actor ACTOR_PLAYER ; $6ce7
	script_wait_move $04 ; $6cee
	script_face $03, FACE_DOWN ; $6cf3
	script_wait_frames $0f ; $6cfa
	script_face $04, FACE_UP ; $6d01
	script_face ACTOR_PLAYER, FACE_UP ; $6d08
	script_wait_frames $0f ; $6d0f
	script_set_anim $03, $02 ; $6d16
	script_wait_idle $03 ; $6d1d
	ld a, $03 ; $6d22
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d24
	farcall RunDialogueYesNoPrompt ; $6d27
	farcall ScriptCloseDialogueWindow ; $6d2a
	script_wait_frames $05 ; $6d2d
	and a ; $6d34
	jp nz, .speak ; $6d35
	script_set_anim $03, $03 ; $6d38
	script_wait_idle $03 ; $6d3f
.stage2:
	script_set_text Text_30_548 ; $6d44
	script_set_anim $03, $03 ; $6d4a
	script_wait_idle $03 ; $6d51
	script_speak $03 ; $6d56
	ld a, $07 ; $6d5b
	ld [wStoryModeCurrentLocation], a ; $6d5d
	ld a, $0d ; $6d60
	ld [wStoryModeEntryPoint], a ; $6d62
	ld a, $ff ; $6d65
	ld [wUnusedExitLocationMirror], a ; $6d67
	ld [wStoryModeExitLocationRequest], a ; $6d6a
	script_null_script $07 ; $6d6d
	script_set_speed ACTOR_PLAYER, $0020 ; $6d72
	script_set_speed ACTOR_PARTNER, $0020 ; $6d7a
	script_set_speed $07, $0018 ; $6d82
	script_set_actor_script $04, ActorScript_13_6b97 ; $6d8a
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_6be7 ; $6d95
	script_set_actor_script $07, ActorScript_13_6b47 ; $6da0
	script_set_actor_script $03, ActorScript_13_6b19 ; $6dab
	script_set_actor_script $05, ActorScript_13_6b24 ; $6db6
	script_set_actor_script $06, ActorScript_13_6b31 ; $6dc1
	script_move_player $0c00, $1b00 ; $6dcc
	farcall WaitPlayerMoveDone ; $6dd6
	script_wait_actor_script $04 ; $6dd9
	farcall InitStoryMatchSettings ; $6dde
	load_match_settings $000b ; $6de1
	farcall RunStoryMatch ; $6dee
	farcall RestoreOverworldAfterMatch ; $6df1
	ret ; $6df4
.stage3:
	script_speak $03 ; $6df5
	ret ; $6dfa
.speak:
	farcall AdvanceDialogueTextCursor ; $6dfb
	ld a, $03 ; $6dfe
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e00
	farcall RunDialogueYesNoPrompt ; $6e03
	farcall ScriptCloseDialogueWindow ; $6e06
	script_wait_frames $05 ; $6e09
	and a ; $6e10
	jr z, .done ; $6e11
	jp .stage2 ; $6e13
	ret ; $6e16
.done:
	script_speak $03 ; $6e17
	call ReturnVarsityCourtANpc04ToSpawn_13 ; $6e1c
	ret ; $6e1f
VarsityCourtBNpc03FaceUp_13:
	script_set_speed ACTOR_PLAYER, $0008 ; $6e20
	script_facing_lock ACTOR_PLAYER, $01 ; $6e28
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6e2f
	script_wait_move ACTOR_PLAYER ; $6e3a
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $6e3f
	script_face ACTOR_PLAYER, FACE_UP ; $6e46
VarsityCourtBNpc03_13:
	script_null_script ACTOR_PARTNER ; $6e4d
	script_set_text Text_31_12 ; $6e52
	ld a, $03 ; $6e58
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e5a
	farcall RunDialogueYesNoPrompt ; $6e5d
	farcall ScriptCloseDialogueWindow ; $6e60
	script_wait_frames $05 ; $6e63
	and a ; $6e6a
	jp nz, .stage3 ; $6e6b
	farcall AdvanceDialogueTextCursor ; $6e6e
	script_set_speed ACTOR_PLAYER, $0010 ; $6e71
	script_set_speed ACTOR_PARTNER, $0010 ; $6e79
	script_move_target ACTOR_PARTNER, $0d00, $2100 ; $6e81
	script_move_target ACTOR_PLAYER, $0d00, $1f00 ; $6e8c
	script_wait_move ACTOR_PLAYER ; $6e97
	script_face_toward $03, ACTOR_PLAYER ; $6e9c
	script_wait_move ACTOR_PARTNER ; $6ea4
	script_face_toward $03, ACTOR_PARTNER ; $6ea9
	script_wait_frames $1e ; $6eb1
	script_set_speed ACTOR_PLAYER, $0020 ; $6eb8
	script_set_speed ACTOR_PARTNER, $0020 ; $6ec0
	script_face_toward ACTOR_PLAYER, $03 ; $6ec8
	script_speak $03 ; $6ed0
	script_wait_frames $0f ; $6ed5
	script_face_toward $04, $03 ; $6edc
	script_wait_frames $1e ; $6ee4
	script_face_toward $09, ACTOR_PLAYER ; $6eeb
	script_face_toward $04, ACTOR_PARTNER ; $6ef3
	script_wait_frames $1e ; $6efb
	script_player_speed $0020 ; $6f02
	script_move_player_to_actor $04 ; $6f08
	farcall WaitPlayerMoveDone ; $6f0f
	script_face_toward ACTOR_PLAYER, $04 ; $6f12
	script_face_toward ACTOR_PLAYER, $09 ; $6f1a
	script_set_anim $04, $03 ; $6f22
	script_wait_idle $04 ; $6f29
	script_move_target $04, $0b00, $2100 ; $6f2e
	script_move_target $09, $0b00, $1f00 ; $6f39
	script_move_player_to_actor ACTOR_PLAYER ; $6f44
	script_wait_frames $0f ; $6f4b
	script_face $03, FACE_DOWN ; $6f52
	script_wait_frames $0f ; $6f59
	script_wait_move $04 ; $6f60
	script_face $04, FACE_UP ; $6f65
	script_face $09, FACE_UP ; $6f6c
	script_face ACTOR_PLAYER, FACE_UP ; $6f73
	script_face ACTOR_PARTNER, FACE_UP ; $6f7a
	script_wait_frames $0f ; $6f81
	script_set_anim $03, $02 ; $6f88
	script_wait_idle $03 ; $6f8f
	ld a, $03 ; $6f94
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f96
	farcall RunDialogueYesNoPrompt ; $6f99
	farcall ScriptCloseDialogueWindow ; $6f9c
	script_wait_frames $05 ; $6f9f
	and a ; $6fa6
	jp nz, .speak ; $6fa7
	script_set_anim $03, $03 ; $6faa
	script_wait_idle $03 ; $6fb1
.stage2:
	script_set_text Text_31_16 ; $6fb6
	script_set_anim $03, $03 ; $6fbc
	script_wait_idle $03 ; $6fc3
	script_speak $03 ; $6fc8
	ld a, $07 ; $6fcd
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [wStoryModeEntryPoint], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [wUnusedExitLocationMirror], a ; $6fd9
	ld [wStoryModeExitLocationRequest], a ; $6fdc
	script_set_speed ACTOR_PLAYER, $0020 ; $6fdf
	script_set_speed ACTOR_PARTNER, $0020 ; $6fe7
	script_set_actor_script $04, ActorScript_13_6bae ; $6fef
	script_set_actor_script $09, ActorScript_13_6bc5 ; $6ffa
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_6be7 ; $7005
	script_set_actor_script ACTOR_PARTNER, ActorScript_13_6bdc ; $7010
	script_null_script $07 ; $701b
	script_set_speed $07, $0018 ; $7020
	script_set_actor_script $03, ActorScript_13_6b19 ; $7028
	script_set_actor_script $05, ActorScript_13_6b24 ; $7033
	script_set_actor_script $06, ActorScript_13_6b3c ; $703e
	script_set_actor_script $07, ActorScript_13_6b58 ; $7049
	script_move_player $0c00, $1b00 ; $7054
	farcall WaitPlayerMoveDone ; $705e
	script_wait_actor_script $04 ; $7061
	farcall InitStoryMatchSettings ; $7066
	load_match_settings $010d ; $7069
	farcall RunStoryMatch ; $7076
	farcall RestoreOverworldAfterMatch ; $7079
	ret ; $707c
.stage3:
	script_speak $03 ; $707d
	script_get_actor_state ACTOR_PARTNER ; $7082
	ld c, l ; $7087
	ld b, h ; $7088
	ld de, $d000 ; $7089
	farcall AttachActorStepMover ; $708c
	ret ; $708f
.speak:
	farcall AdvanceDialogueTextCursor ; $7090
	ld a, $03 ; $7093
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7095
	farcall RunDialogueYesNoPrompt ; $7098
	farcall ScriptCloseDialogueWindow ; $709b
	script_wait_frames $05 ; $709e
	and a ; $70a5
	jr z, .done ; $70a6
	jp .stage2 ; $70a8
	ret ; $70ab
.done:
	script_speak $03 ; $70ac
	call ReturnVarsityCourtBNpcsToSpawn_13 ; $70b1
	script_wait_frames $3c ; $70b4
	script_get_actor_state ACTOR_PARTNER ; $70bb
	ld c, l ; $70c0
	ld b, h ; $70c1
	ld de, $d000 ; $70c2
	farcall AttachActorStepMover ; $70c5
	ret ; $70c8
ReturnVarsityCourtANpc04ToSpawn_13:
	script_set_actor_script $04, ActorScript_13_6bf2 ; $70c9
	ret ; $70d4
ReturnVarsityCourtBNpcsToSpawn_13:
	script_set_actor_script $04, ActorScript_13_6bfd ; $70d5
	script_set_actor_script $09, ActorScript_13_6c08 ; $70e0
	ret ; $70eb
	wram_bank $04 ; $70ec
	ld a, [wMatchWinLoseFlag] ; $70f2
	cp $01 ; $70f5
	jp z, SinglesTravelingTeamVictoryCutscene ; $70f7
	ret ; $70fa
SinglesTravelingTeamVictoryCutscene:
	wram_bank $06 ; $70fb
	ldh a, [hRomBank] ; $7101
	ld hl, SinglesTravelingTeamActors_13 ; $7103
	farcall ScriptRespawnLocationActors ; $7106
	script_null_script ACTOR_PLAYER_SHADOW ; $7109
	script_player_speed $0040 ; $710e
	call ApplyPartnerCharacterVariant_13 ; $7114
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7117
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $7122
	script_face ACTOR_PLAYER, FACE_UP ; $712d
	script_face ACTOR_PARTNER, FACE_UP ; $7134
	script_move_player $0b00, $1100 ; $713b
	farcall WaitPlayerMoveDone ; $7145
	script_fade_in $04 ; $7148
	call WaitFadeEnd ; $714d
	script_wait_frames $3c ; $7150
	script_set_text Text_30_554 ; $7157
	script_player_speed $0020 ; $715d
	script_move_player $0b00, $1700 ; $7163
	farcall WaitPlayerMoveDone ; $716d
	script_move_target $04, $0b00, $1700 ; $7170
	script_wait_move $04 ; $717b
	script_speak $04 ; $7180
	script_set_anim ACTOR_PLAYER, $03 ; $7185
	script_wait_idle ACTOR_PLAYER ; $718c
	script_speak $0d ; $7191
	script_set_position $0c, $0c40, $1bc0 ; $7196
	sound $98 ; $71a1
	script_wait_frames $28 ; $71a3
	script_set_position $0c, $3f00, $3f00 ; $71aa
	script_face ACTOR_PLAYER, FACE_RIGHT ; $71b5
	script_move_player_to_actor $0d ; $71bc
	farcall WaitPlayerMoveDone ; $71c3
	script_wait_frames $28 ; $71c6
	script_move_player_to_actor ACTOR_PLAYER ; $71cd
	script_set_actor_script $08, ActorScript_13_7a43 ; $71d4
	script_set_actor_script $09, ActorScript_13_7aa7 ; $71df
	script_set_actor_script $0d, ActorScript_13_7aa0 ; $71ea
	script_wait_frames $0a ; $71f5
	script_set_actor_script $03, ActorScript_13_7a7d ; $71fc
	farcall WaitPlayerMoveDone ; $7207
	script_wait_actor_script $03 ; $720a
	script_face_toward ACTOR_PLAYER, $0d ; $720f
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7217
	jr z, .variantB ; $721a
	farcall AdvanceDialogueTextCursor ; $721c
	script_set_anim $0d, $02 ; $721f
	script_wait_idle $0d ; $7226
	script_speak $0d ; $722b
	script_face_toward $0d, ACTOR_PLAYER ; $7230
	script_set_anim $0d, $03 ; $7238
	script_set_anim ACTOR_PLAYER, $03 ; $723f
	script_wait_idle ACTOR_PLAYER ; $7246
	jr .celebrate ; $724b
.variantB:
	script_set_anim $0d, $02 ; $724d
	script_wait_idle $0d ; $7254
	script_speak $0d ; $7259
	script_face_toward $0d, ACTOR_PLAYER ; $725e
	script_set_anim $0d, $03 ; $7266
	script_set_anim ACTOR_PLAYER, $03 ; $726d
	script_wait_idle ACTOR_PLAYER ; $7274
	farcall AdvanceDialogueTextCursor ; $7279
.celebrate:
	script_face $09, FACE_DOWN ; $727c
	script_set_anim $09, $04 ; $7283
	script_wait_idle $09 ; $728a
	script_face $09, FACE_RIGHT ; $728f
	script_face_toward $09, ACTOR_PLAYER ; $7296
	script_speak $09 ; $729e
	script_set_anim ACTOR_PLAYER, $02 ; $72a3
	script_wait_idle ACTOR_PLAYER ; $72aa
	script_wait_frames $14 ; $72af
	script_move_target $08, $0a00, $1f00 ; $72b6
	script_wait_move $08 ; $72c1
	script_wait_frames $14 ; $72c6
	script_face_toward $08, ACTOR_PLAYER ; $72cd
	script_face_toward $08, $0d ; $72d5
	script_wait_frames $14 ; $72dd
	script_set_anim $08, $03 ; $72e4
	script_wait_idle $08 ; $72eb
	script_speak $08 ; $72f0
	script_wait_frames $14 ; $72f5
	script_move_target $03, $0c00, $1f00 ; $72fc
	script_wait_move $03 ; $7307
	script_wait_frames $14 ; $730c
	script_set_anim $03, $02 ; $7313
	script_wait_idle $03 ; $731a
	script_speak $03 ; $731f
	script_set_anim $0d, $02 ; $7324
	script_wait_idle $0d ; $732b
	script_face_toward ACTOR_PLAYER, $0d ; $7330
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7338
	jr z, .done ; $733b
	farcall AdvanceDialogueTextCursor ; $733d
.done:
	script_speak $0d ; $7340
	script_face_toward $0d, ACTOR_PLAYER ; $7345
	script_set_anim ACTOR_PLAYER, $03 ; $734d
	script_wait_idle ACTOR_PLAYER ; $7354
	script_wait_frames $0a ; $7359
	script_face_toward $08, ACTOR_PLAYER ; $7360
	script_wait_frames $0a ; $7368
	script_set_anim ACTOR_PLAYER, $03 ; $736f
	ld c, $02 ; $7376
	call BeginFadeOut ; $7378
	call WaitFadeEnd ; $737b
	ld b, $00 ; $737e
	ld a, [wStoryModeGenderOfMainCharacter] ; $7380
	add $04 ; $7383
	ld c, a ; $7385
	farcall RunStorySceneByMode ; $7386
	ld a, $00 ; $7389
	ld [wStoryModeCurrentLocation], a ; $738b
	ld a, $0a ; $738e
	ld [wStoryModeEntryPoint], a ; $7390
	ld a, $ff ; $7393
	ld [wUnusedExitLocationMirror], a ; $7395
	ld [wStoryModeExitLocationRequest], a ; $7398
	ret ; $739b
SinglesTravelingTeamActors_13:
	; $739c, 164 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $1900, $1f00, FACE_LEFT, $4b, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0b00, $1300, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_13_7b25, $1300, $2100, FACE_LEFT, $65, $01, $03
	map_actor $0000, ActorScript_13_7b25, $1300, $2300, FACE_LEFT, $67, $01, $06
	map_actor $0000, ActorScript_13_7b25, $1300, $1700, FACE_LEFT, $6b, $01, $06
	map_actor $0000, ActorScript_13_7b25, $1b00, $1d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_13_7b25, $1900, $1d00, FACE_LEFT, $4a, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $53, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $4d, $01, $00
	map_actor $0000, ActorScript_13_7b25, $1700, $1d00, FACE_LEFT, $29, $01, $00
	map_actor_end
RunDoublesTravelingTeamVictoryIfWon_13:
	wram_bank $04 ; $7440
	ld a, [wMatchWinLoseFlag] ; $7446
	cp $01 ; $7449
	jp z, DoublesTravelingTeamVictoryCutscene ; $744b
	ret ; $744e
DoublesTravelingTeamVictoryCutscene:
	script_set_text Text_31_22 ; $744f
	ldh a, [hRomBank] ; $7455
	ld hl, DoublesTravelingTeamActors_13 ; $7457
	farcall ScriptRespawnLocationActors ; $745a
	farcall BeginCutsceneScriptMode ; $745d
	call ApplyPartnerCharacterVariant_13 ; $7460
	script_null_script ACTOR_PARTNER ; $7463
	script_null_script ACTOR_PLAYER_SHADOW ; $7468
	script_player_speed $0040 ; $746d
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7473
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $747e
	script_face ACTOR_PLAYER, FACE_UP ; $7489
	script_face ACTOR_PARTNER, FACE_UP ; $7490
	script_move_player $0b00, $1100 ; $7497
	farcall WaitPlayerMoveDone ; $74a1
	script_fade_in $04 ; $74a4
	call WaitFadeEnd ; $74a9
	script_wait_frames $3c ; $74ac
	script_player_speed $0020 ; $74b3
	script_move_player $0b00, $1700 ; $74b9
	farcall WaitPlayerMoveDone ; $74c3
	script_move_target ACTOR_PARTNER, $0d00, $1d00 ; $74c6
	script_move_target $09, $0b00, $1700 ; $74d1
	script_wait_move $09 ; $74dc
	script_set_anim $09, $04 ; $74e1
	script_wait_idle $09 ; $74e8
	script_speak $09 ; $74ed
	script_set_anim $04, $02 ; $74f2
	script_wait_idle $04 ; $74f9
	script_speak $04 ; $74fe
	script_set_anim ACTOR_PARTNER, $03 ; $7503
	script_set_anim ACTOR_PLAYER, $03 ; $750a
	script_wait_idle ACTOR_PLAYER ; $7511
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7516
	script_wait_frames $1e ; $751e
	script_set_anim ACTOR_PARTNER, $03 ; $7525
	script_wait_idle ACTOR_PARTNER ; $752c
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7531
	jp z, .variantB ; $7534
	script_set_text Text_31_26 ; $7537
	script_speak ACTOR_PARTNER ; $753d
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7542
	script_set_anim ACTOR_PARTNER, $02 ; $754a
	script_wait_idle ACTOR_PARTNER ; $7551
	script_speak ACTOR_PARTNER ; $7556
	script_face ACTOR_PLAYER, FACE_LEFT ; $755b
	script_set_anim ACTOR_PLAYER, $02 ; $7562
	script_set_position $0a, $0c00, $1b80 ; $7569
	sound $96 ; $7574
	script_wait_frames $28 ; $7576
	script_set_position $0a, $3f00, $3f00 ; $757d
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7588
	script_wait_frames $0a ; $7590
	script_facing_lock ACTOR_PLAYER, $01 ; $7597
	script_wait_frames $0a ; $759e
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $75a5
	script_wait_move ACTOR_PLAYER ; $75af
	script_set_anim ACTOR_PLAYER, $02 ; $75b4
	script_wait_idle ACTOR_PLAYER ; $75bb
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $75c0
	script_wait_move ACTOR_PLAYER ; $75ca
	script_get_actor_state ACTOR_PARTNER ; $75cf
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	ld [hl], $04 ; $75d8
	script_set_anim ACTOR_PARTNER, $02 ; $75da
	script_wait_idle ACTOR_PARTNER ; $75e1
	script_face ACTOR_PARTNER, FACE_UP ; $75e6
	script_set_anim ACTOR_PARTNER, $02 ; $75ed
	script_wait_idle ACTOR_PARTNER ; $75f4
	script_set_anim ACTOR_PARTNER, $02 ; $75f9
	script_wait_idle ACTOR_PARTNER ; $7600
	script_face ACTOR_PARTNER, FACE_DOWN ; $7605
	script_set_anim ACTOR_PARTNER, $02 ; $760c
	script_wait_idle ACTOR_PARTNER ; $7613
	script_face ACTOR_PARTNER, FACE_UP ; $7618
	script_set_anim ACTOR_PARTNER, $02 ; $761f
	script_wait_idle ACTOR_PARTNER ; $7626
	script_set_anim ACTOR_PARTNER, $02 ; $762b
	script_wait_idle ACTOR_PARTNER ; $7632
	script_get_actor_state ACTOR_PARTNER ; $7637
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	script_face ACTOR_PARTNER, FACE_LEFT ; $7642
	script_wait_frames $14 ; $7649
	script_set_anim ACTOR_PARTNER, $03 ; $7650
	script_wait_idle ACTOR_PARTNER ; $7657
	script_wait_frames $14 ; $765c
	script_set_anim ACTOR_PLAYER, $03 ; $7663
	script_wait_idle ACTOR_PLAYER ; $766a
	jp .celebrate ; $766f
.variantB:
	script_set_text Text_31_24 ; $7672
	script_speak ACTOR_PARTNER ; $7678
	script_set_anim ACTOR_PARTNER, $02 ; $767d
	script_wait_idle ACTOR_PARTNER ; $7684
	script_speak ACTOR_PARTNER ; $7689
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $768e
	script_set_position $0a, $0c00, $1b80 ; $7696
	sound $96 ; $76a1
	script_wait_frames $28 ; $76a3
	script_set_position $0a, $3f00, $3f00 ; $76aa
	script_wait_frames $0a ; $76b5
	script_facing_lock ACTOR_PLAYER, $01 ; $76bc
	script_wait_frames $0a ; $76c3
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0100 ; $76ca
	script_wait_move ACTOR_PLAYER ; $76d4
	script_set_anim ACTOR_PLAYER, $02 ; $76d9
	script_wait_idle ACTOR_PLAYER ; $76e0
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0100 ; $76e5
	script_wait_move ACTOR_PLAYER ; $76ef
	script_get_actor_state ACTOR_PARTNER ; $76f4
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	ld [hl], $03 ; $76fd
	script_set_anim ACTOR_PARTNER, $02 ; $76ff
	script_wait_idle ACTOR_PARTNER ; $7706
	script_face ACTOR_PARTNER, FACE_DOWN ; $770b
	script_set_anim ACTOR_PARTNER, $02 ; $7712
	script_wait_idle ACTOR_PARTNER ; $7719
	script_wait_frames $28 ; $771e
	script_set_anim ACTOR_PARTNER, $02 ; $7725
	script_wait_idle ACTOR_PARTNER ; $772c
	script_get_actor_state ACTOR_PARTNER ; $7731
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	script_face ACTOR_PARTNER, FACE_LEFT ; $773c
	script_wait_frames $14 ; $7743
	script_set_anim ACTOR_PARTNER, $03 ; $774a
	script_wait_idle ACTOR_PARTNER ; $7751
	script_wait_frames $14 ; $7756
	script_set_anim ACTOR_PLAYER, $03 ; $775d
	script_wait_idle ACTOR_PLAYER ; $7764
.celebrate:
	script_set_text Text_31_28 ; $7769
	script_wait_frames $14 ; $776f
	script_speak $08 ; $7776
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $777b
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7782
	script_face ACTOR_PARTNER, FACE_RIGHT ; $7789
	script_set_actor_script $08, ActorScript_13_7a43 ; $7790
	script_set_actor_script $03, ActorScript_13_7a60 ; $779b
	script_wait_frames $14 ; $77a6
	script_set_actor_script $09, ActorScript_13_7ac9 ; $77ad
	script_move_player $0b00, $1d00 ; $77b8
	farcall WaitPlayerMoveDone ; $77c2
	script_wait_actor_script $09 ; $77c5
	script_face_toward ACTOR_PLAYER, $09 ; $77ca
	script_face_toward $03, ACTOR_PARTNER ; $77d2
	script_set_anim $09, $04 ; $77da
	script_wait_idle $09 ; $77e1
	script_face_toward $09, ACTOR_PLAYER ; $77e6
	script_speak $09 ; $77ee
	script_move_target $08, $0a00, $1f00 ; $77f3
	script_wait_move $08 ; $77fe
	script_face_toward $08, ACTOR_PLAYER ; $7803
	script_face_toward $03, ACTOR_PARTNER ; $780b
	script_set_anim $08, $03 ; $7813
	script_wait_idle $08 ; $781a
	script_speak $08 ; $781f
	script_move_target $03, $0c00, $1f00 ; $7824
	script_wait_move $03 ; $782f
	script_set_anim $03, $02 ; $7834
	script_wait_idle $03 ; $783b
	script_speak $03 ; $7840
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7845
	script_set_anim ACTOR_PARTNER, $03 ; $784d
	script_wait_idle ACTOR_PARTNER ; $7854
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $7859
	jr z, .done ; $785c
	farcall AdvanceDialogueTextCursor ; $785e
.done:
	script_speak ACTOR_PARTNER ; $7861
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7866
	script_set_anim ACTOR_PLAYER, $03 ; $786e
	script_wait_idle ACTOR_PLAYER ; $7875
	script_wait_frames $0a ; $787a
	script_face_toward $08, ACTOR_PLAYER ; $7881
	script_face_toward $03, ACTOR_PARTNER ; $7889
	script_wait_frames $0a ; $7891
	script_set_anim ACTOR_PLAYER, $03 ; $7898
	script_set_anim ACTOR_PARTNER, $03 ; $789f
	ld c, $02 ; $78a6
	call BeginFadeOut ; $78a8
	call WaitFadeEnd ; $78ab
	call PlayDoublesTravelingTeamScreenSequence_13 ; $78ae
	ld a, $00 ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [wStoryModeEntryPoint], a ; $78b8
	ld a, $ff ; $78bb
	ld [wUnusedExitLocationMirror], a ; $78bd
	ld [wStoryModeExitLocationRequest], a ; $78c0
	ret ; $78c3
PlayDoublesTravelingTeamScreenSequence_13:
	ld b, $00 ; $78c4
	ld a, [wStoryModeGenderOfMainCharacter] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $78cd
	xor d ; $78d0
	or c ; $78d1
	ld c, a ; $78d2
	farcall RunStorySceneByMode ; $78d3
	ret ; $78d6
DoublesTravelingTeamActors_13:
	; $78d7, 164 bytes (map_actors)
	map_actor $0000, ActorScript_13_7b25, $1900, $1d00, FACE_LEFT, $4b, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0d00, $1700, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_13_7b25, $1300, $2100, FACE_LEFT, $65, $01, $03
	map_actor $0000, ActorScript_13_7b25, $1300, $2300, FACE_LEFT, $67, $01, $06
	map_actor $0000, ActorScript_13_7b25, $1300, $1700, FACE_LEFT, $6b, $01, $06
	map_actor $0000, ActorScript_13_7b25, $1700, $1d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_13_7b25, $0b00, $1300, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $53, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_13_7b25, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor_end
DoublesTravelingTeamInitScript_13:
	set_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $797b
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $797e
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7981
	set_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7984
	ret ; $7987
RunTravelingTeamVictoryCutscene_13:
	test_flag FLAG_DOUBLES ; $7988
	jr z, .notDoubles ; $798b
	call DoublesTravelingTeamVictoryCutscene ; $798d
	ret ; $7990
.notDoubles:
	call SinglesTravelingTeamVictoryCutscene ; $7991
	ret ; $7994
RunTravelingTeamBracketIfWon_13:
	wram_bank $04 ; $7995
	ld a, [wMatchWinLoseFlag] ; $799b
	cp $01 ; $799e
	jp z, .eq01 ; $79a0
	ret ; $79a3
.eq01:
	ld a, $07 ; $79a4
	ld [wStoryModeCurrentLocation], a ; $79a6
	ld a, $0e ; $79a9
	ld [wStoryModeEntryPoint], a ; $79ab
	ld a, $ff ; $79ae
	ld [wUnusedExitLocationMirror], a ; $79b0
	ld [wStoryModeExitLocationRequest], a ; $79b3
	test_flag FLAG_DOUBLES ; $79b6
	jr nz, .isDoubles ; $79b9
	ldh a, [hRomBank] ; $79bb
	ld hl, SinglesTravelingTeamActors_13 ; $79bd
	farcall ScriptRespawnLocationActors ; $79c0
	farcall BeginCutsceneScriptMode ; $79c3
	script_fade_in $04 ; $79c6
	call WaitFadeEnd ; $79cb
	script_player_speed $0018 ; $79ce
	script_move_player $0900, $1300 ; $79d4
	farcall WaitPlayerMoveDone ; $79de
	call ShowStoryTournamentBracket_13 ; $79e1
	ret ; $79e4
.isDoubles:
	ldh a, [hRomBank] ; $79e5
	ld hl, DoublesTravelingTeamActors_13 ; $79e7
	farcall ScriptRespawnLocationActors ; $79ea
	farcall BeginCutsceneScriptMode ; $79ed
	call ApplyPartnerCharacterVariant_13 ; $79f0
	script_null_script ACTOR_PARTNER ; $79f3
	script_null_script ACTOR_PLAYER_SHADOW ; $79f8
	script_player_speed $0040 ; $79fd
	script_set_position ACTOR_PLAYER, $0b00, $1d00 ; $7a03
	script_set_position ACTOR_PARTNER, $0d00, $2300 ; $7a0e
	script_face ACTOR_PLAYER, FACE_UP ; $7a19
	script_face ACTOR_PARTNER, FACE_UP ; $7a20
	script_fade_in $04 ; $7a27
	call WaitFadeEnd ; $7a2c
	script_move_player $0900, $1300 ; $7a2f
	farcall WaitPlayerMoveDone ; $7a39
	call ShowStoryTournamentBracket_13 ; $7a3c
	ret ; $7a3f
ActorScript_13_7a40:
	; $7a40, 3 bytes (actor_script)
	as_anim $06
	as_halt
ActorScript_13_7a43:
	; $7a43, 29 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0a00, $2300
	as_wait_move
	as_set_target $0a00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_7a60:
	; $7a60, 29 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0c00, $2300
	as_wait_move
	as_set_target $0c00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_7a7d:
	; $7a7d, 35 bytes (actor_script)
	as_set_target $1900, $1d00
	as_wait_move
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0c00, $2300
	as_wait_move
	as_set_target $0c00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_7aa0:
	; $7aa0, 7 bytes (actor_script)
	as_set_target $0d00, $1d00
	as_wait_move
	as_halt
ActorScript_13_7aa7:
	; $7aa7, 34 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_target $1100, $2300
	as_wait_move
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1d00
	as_set_target $0900, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_13_7ac9:
	; $7ac9, 23 bytes (actor_script)
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0700, $1d00
	as_wait_move
	as_set_target $0900, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ShowStoryTournamentBracket_13:
	ld c, $08 ; $7ae0
	call BeginFadeOut ; $7ae2
	call WaitFadeEnd ; $7ae5
	xor a ; $7ae8
	ldh [hBGColumnBlitPending], a ; $7ae9
	ldh [hBGRowBlitPending], a ; $7aeb
	ldh [hScrollY], a ; $7aed
	ldh [hScrollX], a ; $7aef
	ld [wCameraX + 1], a ; $7af1
	ld [wCameraY + 1], a ; $7af4
	call ClearFrameTasks ; $7af7
	test_flag FLAG_DOUBLES ; $7afa
	jr nz, .doublesBracket ; $7afd
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $7aff
	jr nz, .juniorBracket ; $7b02
	ld b, $00 ; $7b04
	ld c, $04 ; $7b06
	jr .show ; $7b08
.juniorBracket:
	ld b, $00 ; $7b0a
	ld c, $01 ; $7b0c
	jr .show ; $7b0e
.doublesBracket:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7b10
	jr nz, .doublesFinal ; $7b13
	ld b, $01 ; $7b15
	ld c, $02 ; $7b17
	jr .show ; $7b19
.show:
	farcall ShowTournamentBracket ; $7b1b
	ret ; $7b1e
.doublesFinal:
	ld b, $01 ; $7b1f
	ld c, $01 ; $7b21
	jr .show ; $7b23
ActorScript_13_7b25:
	; $7b25, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_13_7b2f:
	; $7b2f, 30 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L15
MapScriptNop_13:
	ret ; $7b4d
	xor a ; $7b4e
	ld [wStoryScriptRan], a ; $7b4f
	ret ; $7b52
	sound $a2 ; $7b53
	ret ; $7b55
	xor a ; $7b56
	ld [wStoryModeShowLocationName], a ; $7b57
	ret ; $7b5a
ActorScript_13_7b5b:
	; $7b5b, 410 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_13_7b5b
	as_anim $00
	as_wait $3c
.L67:
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L67
	as_anim $00
	as_wait $1e
.Lce:
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump .Lce
	as_anim $00
	as_wait $1e
	as_wait $3c
.L137:
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L137
ActorScript_13_7cf5:
	; $7cf5, 28 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_13_7cf5
.Ld:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .Ld
	test_flag FLAG_DOUBLES ; $7d11
	jr nz, .isDoubles ; $7d14
	ld a, $00 ; $7d16
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d18
	jr z, .loop ; $7d1b
	ld a, $02 ; $7d1d
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d1f
	jr z, .loop ; $7d22
	ld a, $04 ; $7d24
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d26
	jr z, .loop ; $7d29
	ld a, $06 ; $7d2b
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7d2d
	jr z, .loop ; $7d30
	ld a, $08 ; $7d32
.loop:
	ld [wMapSceneStage], a ; $7d34
	ret ; $7d37
.isDoubles:
	ld a, $01 ; $7d38
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7d3a
	jr z, .loop ; $7d3d
	ld a, $03 ; $7d3f
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7d41
	jr z, .loop ; $7d44
	ld a, $05 ; $7d46
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7d48
	jr z, .loop ; $7d4b
	ld a, $07 ; $7d4d
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7d4f
	jr z, .loop ; $7d52
	ld a, $09 ; $7d54
	jr .loop ; $7d56
ComputeStoryRankTier_13:
	ld a, $00 ; $7d58
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d5a
	jr z, .loop ; $7d5d
	inc a ; $7d5f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7d60
	jr z, .loop ; $7d63
	inc a ; $7d65
	test_flag FLAG_DOUBLES ; $7d66
	jr nz, .checkFlag ; $7d69
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7d6b
	jr z, .loop ; $7d6e
	inc a ; $7d70
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7d71
	jr z, .loop ; $7d74
	inc a ; $7d76
.loop:
	ld [wMapSceneStage], a ; $7d77
	ret ; $7d7a
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7d7b
	jr z, .loop ; $7d7e
	inc a ; $7d80
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7d81
	jr z, .loop ; $7d84
	inc a ; $7d86
	jr .loop ; $7d87
	; $7d89, 631 bytes fill to bank end (linker-padded)
