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
; Instruction-identical to AcademyMainBldgArrival01_10, RestaurantArrival01_10, MapArrivalWalk_11 and DormEntranceArrival01_12 (one copy per bank); a change here belongs in every copy.
RestaurantPlazaArrival04_13:
	ld a, [wStoryModeEntryPoint] ; $405f
	cp STORYENTRY_NONE ; $4062
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
; Instruction-identical to Court2EntryWalkIn (one copy per bank); a change here belongs in every copy.
RestaurantPlazaArrival06_13:
	ld a, [wStoryModeEntryPoint] ; $40a5
	cp STORYENTRY_NONE ; $40a8
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
	cp STORYENTRY_NONE ; $40ee
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
	cp STORYENTRY_NONE ; $4166
	jp z, RestaurantPlazaArrivalWalkIn_13.done ; $4168
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $416b
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $417a
	script_set_speed ACTOR_PLAYER, $0018 ; $4189
	script_fade_in $08 ; $4191
	call WaitFadeEnd ; $4196
	script_wait_frames $05 ; $4199
	sound SFX_STOP ; $41a0
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
	cp STORYENTRY_NONE ; $41d2
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
	; $4236, 73 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_DORM_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_RESTAURANT, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_SENIOR_CLASS_COURT, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_COURTYARD, $02
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $01
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_TRAINING_COURT, $01
	map_script $0d, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES, $01
	map_script $0e, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_DORM_ENTRANCE, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_TRAINING_COURT, $0f
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
	ld [wUnusedExitTriggerIdMirror], a ; $4305
	ld [wStoryModeExitTriggerRequest], a ; $4308
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
	ld [wUnusedExitTriggerIdMirror], a ; $4350
	ld [wStoryModeExitTriggerRequest], a ; $4353
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
	ld [wUnusedExitTriggerIdMirror], a ; $439a
	ld [wStoryModeExitTriggerRequest], a ; $439d
	ret ; $43a0
RestaurantPlazaTile05_13:
	script_move_target ACTOR_PARTNER, $3700, $0d00 ; $43a1
	script_set_speed ACTOR_PLAYER, $0010 ; $43ac
	script_set_speed ACTOR_PARTNER, $0010 ; $43b4
	script_move_angle ACTOR_PLAYER, FACE_UP, $0080 ; $43bc
	call StoryActorsWalkOffAndFadeOut_13 ; $43c6
	test_flag FLAG_DOUBLES ; $43c9
	ld a, $05 ; $43cc
	ld [wUnusedExitTriggerIdMirror], a ; $43ce
	ld [wStoryModeExitTriggerRequest], a ; $43d1
	jr z, .done ; $43d4
	ld a, $0d ; $43d6
	ld [wUnusedExitTriggerIdMirror], a ; $43d8
	ld [wStoryModeExitTriggerRequest], a ; $43db
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
	ld [wUnusedExitTriggerIdMirror], a ; $4414
	ld [wStoryModeExitTriggerRequest], a ; $4417
	jr z, RestaurantPlazaTile05_13.done ; $441a
	ld a, $06 ; $441c
	ld [wUnusedExitTriggerIdMirror], a ; $441e
	ld [wStoryModeExitTriggerRequest], a ; $4421
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
	ld [wUnusedExitTriggerIdMirror], a ; $4722
	ld [wStoryModeExitTriggerRequest], a ; $4725
	farcall EndCutsceneScriptMode ; $4728
	ret ; $472b
AcademyCourtsTourActors_13:
	; $472c, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_13_27, $3200, $1300, FACE_DOWN, $49, $01, $00
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
	sound SFX_CHIME ; $485c
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
	sound SFX_EMOTE ; $497a
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
	ld [wUnusedExitTriggerIdMirror], a ; $4c74
	ld [wStoryModeExitTriggerRequest], a ; $4c77
	farcall EndCutsceneScriptMode ; $4c7a
	ret ; $4c7d
ServiceAceCoachIntroActors_13:
	; $4c7e, 94 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_13_27, $4100, $0d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_13_27, $1500, $0d00, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_13_27, $1300, $0d00, FACE_DOWN, $4b, $01, $00
	map_actor_end
