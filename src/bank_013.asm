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
	map_entry $01, $40, $0700, $0840, Func_13_40eb
	map_entry $02, $40, $1500, $0940, Func_13_4163
	map_entry $03, $40, $2500, $0840, Func_13_41cf
	map_entry $04, $c0, $3200, $0f00, Func_13_405f
	map_entry $05, $40, $3700, $0840, Func_13_41cf
	map_entry $06, $80, $3c00, $0d00, Func_13_40a5
	map_entry $0e, $80, $3b00, $0f00, $0000
	map_entry $0f, $80, $3200, $0f00, $0000
	db $ff
Func_13_405f:
	ld a, [wStoryModeEntryPoint] ; $405f
	cp a, $ff ; $4062
	jp z, Label_13_40a4 ; $4064
	test_flag $05, 7 ; $4067
	jr z, Label_13_4092 ; $406a
	script_set_speed $02, $00ff ; $406c
	script_move_angle $02, $40, $0200 ; $4074
	script_wait_move $02 ; $407e
	script_face $02, $c0 ; $4083
	script_set_speed $02, $0010 ; $408a
Label_13_4092:
	script_set_speed $00, $0010 ; $4092
	script_move_angle $00, $c0, $0200 ; $409a
Label_13_40a4:
	ret ; $40a4
Func_13_40a5:
	ld a, [wStoryModeEntryPoint] ; $40a5
	cp a, $ff ; $40a8
	jp z, Label_13_40ea ; $40aa
	test_flag $05, 7 ; $40ad
	jr z, Label_13_40d8 ; $40b0
	script_set_speed $02, $00ff ; $40b2
	script_move_angle $02, $00, $0200 ; $40ba
	script_wait_move $02 ; $40c4
	script_face $02, $80 ; $40c9
	script_set_speed $02, $0010 ; $40d0
Label_13_40d8:
	script_set_speed $00, $0010 ; $40d8
	script_move_angle $00, $80, $0200 ; $40e0
Label_13_40ea:
	ret ; $40ea
Func_13_40eb:
	ld a, [wStoryModeEntryPoint] ; $40eb
	cp a, $ff ; $40ee
	jp z, Label_13_4235 ; $40f0
	script_set_speed $00, $0018 ; $40f3
	script_set_anim $00, $08 ; $40fb
	script_set_speed $02, $0018 ; $4102
	script_set_anim $02, $08 ; $410a
	script_fade_in $08 ; $4111
	script_wait_frames $14 ; $4116
	script_move_target $00, $0700, $0c80 ; $411d
	script_wait_frames $14 ; $4128
	script_move_target $02, $0700, $0b00 ; $412f
	script_wait_frames $14 ; $413a
	script_set_anim $00, $01 ; $4141
	script_wait_frames $0a ; $4148
	script_set_anim $02, $01 ; $414f
	script_wait_move $00 ; $4156
	script_face $00, $00 ; $415b
	ret ; $4162
Func_13_4163:
	ld a, [wStoryModeEntryPoint] ; $4163
	cp a, $ff ; $4166
	jp z, Label_13_4235 ; $4168
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $416b
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $417a
	script_set_speed $00, $0018 ; $4189
	script_fade_in $08 ; $4191
	call WaitFadeEnd ; $4196
	script_wait_frames $05 ; $4199
	sound $50 ; $41a0
	script_wait_frames $05 ; $41a2
	script_move_target $00, $1500, $0d00 ; $41a9
	script_move_target $02, $1500, $0b00 ; $41b4
	test_flag $05, 7 ; $41bf
	jr z, Label_13_41cb ; $41c2
	script_wait_frames $0c ; $41c4
Label_13_41cb:
	call AnimateDoorClose_13 ; $41cb
	ret ; $41ce
Func_13_41cf:
	ld a, [wStoryModeEntryPoint] ; $41cf
	cp a, $ff ; $41d2
	jr z, Label_13_4235 ; $41d4
	script_set_speed $00, $000c ; $41d6
	script_set_anim $00, $08 ; $41de
	script_set_speed $02, $000c ; $41e5
	script_set_anim $02, $08 ; $41ed
	script_fade_in $08 ; $41f4
	script_wait_frames $0a ; $41f9
	script_move_angle $00, $40, $0500 ; $4200
	script_wait_frames $28 ; $420a
	script_move_angle $02, $40, $0400 ; $4211
	script_set_anim $00, $01 ; $421b
	script_wait_frames $10 ; $4222
	script_set_anim $02, $01 ; $4229
	script_wait_move $00 ; $4230
Label_13_4235:
	ret ; $4235
RestaurantPlazaExitTriggers_13:
	; $4236, 73 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_13_7b4d, $09, $01
	map_script $02, $ff, $0000, Func_13_7b4d, $0d, $01
	map_script $03, $ff, $0000, Func_13_7b4d, $10, $01
	map_script $04, $ff, $0000, Func_13_7b4d, $07, $02
	map_script $05, $ff, $0000, Func_13_7b4d, $0b, $01
	map_script $06, $ff, $0000, Func_13_7b4d, $0f, $01
	map_script $0d, $ff, $0000, Func_13_7b4d, $0c, $01
	map_script $0e, $ff, $0000, Func_13_7b4d, $09, $0f
	map_script $0f, $ff, $0000, Func_13_7b4d, $0f, $0f
	db $ff
	script_set_text $1430 ; $427f
	script_speak $00 ; $4285
	ret ; $428a
RestaurantPlazaNpcScripts_13:
	; $428b, 9 bytes (map_scripts)
	map_script $03, $ff, $0000, $1437, $00, $00
	db $ff
RestaurantPlazaFacingScripts_13:
	; $4294, 33 bytes (map_scripts)
	map_script $01, $ff, $0000, $0446, $00, $00
	map_script $02, $ff, $0000, $0447, $00, $00
	map_script $03, $ff, $0000, $0448, $00, $00
	map_script $04, $ff, $0000, $0449, $00, $00
	db $ff
RestaurantPlazaTileTriggers_13:
	; $42b5, 41 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_13_42de, $00, $00
	map_script $02, $ff, $0000, Func_13_430c, $00, $00
	map_script $03, $ff, $0000, Func_13_4357, $00, $00
	map_script $05, $ff, $0000, Func_13_43a1, $00, $00
	map_script $06, $ff, $0000, Func_13_43df, $00, $00
	db $ff
Func_13_42de:
	script_move_target $02, $0700, $0d00 ; $42de
	script_set_speed $00, $0010 ; $42e9
	script_move_angle $00, $c0, $0100 ; $42f1
	script_wait_move $00 ; $42fb
	call StoryActorsWalkOffAndFadeOut_13 ; $4300
	ld a, $01 ; $4303
	ld [$c294], a ; $4305
	ld [wStoryModeExitLocationRequest], a ; $4308
	ret ; $430b
Func_13_430c:
	script_set_speed $00, $0010 ; $430c
	script_move_target $02, $1500, $0d00 ; $4314
	script_move_angle $00, $c2, $0200 ; $431f
	script_wait_move $00 ; $4329
	call AnimateDoorOpen_13 ; $432e
	script_move_angle $00, $c2, $0200 ; $4331
	script_wait_frames $02 ; $433b
	ld c, $10 ; $4342
	call BeginFadeOut ; $4344
	script_wait_frames $1e ; $4347
	ld a, $02 ; $434e
	ld [$c294], a ; $4350
	ld [wStoryModeExitLocationRequest], a ; $4353
	ret ; $4356
Func_13_4357:
	script_set_speed $02, $0040 ; $4357
	script_move_target $02, $2500, $0d00 ; $435f
	script_set_speed $00, $0010 ; $436a
	script_set_speed $02, $0010 ; $4372
	script_move_angle $00, $c0, $0100 ; $437a
	script_wait_move $00 ; $4384
	call StoryActorsWalkOffAndFadeOut_13 ; $4389
	ld c, $10 ; $438c
	call BeginFadeOut ; $438e
	script_wait_frames $1e ; $4391
	ld a, $03 ; $4398
	ld [$c294], a ; $439a
	ld [wStoryModeExitLocationRequest], a ; $439d
	ret ; $43a0
Func_13_43a1:
	script_move_target $02, $3700, $0d00 ; $43a1
	script_set_speed $00, $0010 ; $43ac
	script_set_speed $02, $0010 ; $43b4
	script_move_angle $00, $c0, $0080 ; $43bc
	call StoryActorsWalkOffAndFadeOut_13 ; $43c6
	test_flag $05, 7 ; $43c9
	ld a, $05 ; $43cc
	ld [$c294], a ; $43ce
	ld [wStoryModeExitLocationRequest], a ; $43d1
	jr z, Label_13_43de ; $43d4
	ld a, $0d ; $43d6
	ld [$c294], a ; $43d8
	ld [wStoryModeExitLocationRequest], a ; $43db
Label_13_43de:
	ret ; $43de
Func_13_43df:
	script_set_speed $00, $0020 ; $43df
	script_move_target $02, $3b00, $0d00 ; $43e7
	script_move_angle $00, $00, $0600 ; $43f2
	script_wait_frames $3c ; $43fc
	ld c, $10 ; $4403
	call BeginFadeOut ; $4405
	script_wait_frames $1e ; $4408
	test_flag $05, 7 ; $440f
	ld a, $06 ; $4412
	ld [$c294], a ; $4414
	ld [wStoryModeExitLocationRequest], a ; $4417
	jr z, Label_13_43de ; $441a
	ld a, $06 ; $441c
	ld [$c294], a ; $441e
	ld [wStoryModeExitLocationRequest], a ; $4421
	ret ; $4424
StoryActorsWalkOffAndFadeOut_13:
	test_flag $05, 7 ; $4425
	jr nz, Label_13_446a ; $4428
	script_face $00, $c0 ; $442a
	script_move_angle $00, $c8, $0400 ; $4431
	script_set_speed $00, $0010 ; $443b
	script_wait_frames $28 ; $4443
	script_set_anim $00, $08 ; $444a
	ld c, $08 ; $4451
	call BeginFadeOut ; $4453
	script_wait_move $00 ; $4456
	script_set_active $00, $00 ; $445b
	script_wait_frames $0a ; $4462
	ret ; $4469
Label_13_446a:
	script_wait_move $02 ; $446a
	script_move_angle $00, $c8, $0280 ; $446f
	script_set_speed $00, $0010 ; $4479
	script_set_speed $02, $0010 ; $4481
	script_wait_frames $0a ; $4489
	script_move_angle $02, $ca, $0500 ; $4490
	script_wait_move $00 ; $449a
	script_set_anim $00, $08 ; $449f
	script_move_angle $00, $ca, $0100 ; $44a6
	script_wait_move $02 ; $44b0
	script_set_anim $02, $08 ; $44b5
	script_move_angle $02, $ca, $0200 ; $44bc
	script_wait_move $00 ; $44c6
	script_set_active $00, $00 ; $44cb
	ld c, $10 ; $44d2
	call BeginFadeOut ; $44d4
	script_wait_frames $0a ; $44d7
	ret ; $44de
RestaurantPlazaInitScript_13:
	ld a, [wStoryModeEntryPoint] ; $44df
	cp a, $0f ; $44e2
	jr nz, Label_13_44e9 ; $44e4
	call AcademyCourtsTourCutscene ; $44e6
Label_13_44e9:
	cp a, $0e ; $44e9
	jr nz, Label_13_44f0 ; $44eb
	call ServiceAceCoachIntroCutscene ; $44ed
Label_13_44f0:
	ret ; $44f0
AcademyCourtsTourCutscene:
	ldh a, [hRomBank] ; $44f1
	ld hl, AcademyCourtsTourActors_13 ; $44f3
	farcall FarPtr_ScriptRespawnLocationActors ; $44f6
	farcall FarPtr_BeginCutsceneScriptMode ; $44f9
	script_set_position $00, $3f00, $3f00 ; $44fc
	script_set_position $06, $3f00, $3f00 ; $4507
	call LoadTourPointerSpriteGfx_13 ; $4512
	script_fade_in $04 ; $4515
	call WaitFadeEnd ; $451a
	script_set_position $06, $3200, $1300 ; $451d
	script_move_target $06, $3200, $0d00 ; $4528
	script_wait_frames $0f ; $4533
	script_set_position $00, $3200, $1300 ; $453a
	script_move_target $00, $3200, $0f00 ; $4545
	script_wait_move $00 ; $4550
	script_wait_frames $1e ; $4555
	script_face_toward $00, $06 ; $455c
	script_wait_frames $3c ; $4564
	script_face $06, $00 ; $456b
	script_wait_frames $0f ; $4572
	script_face $00, $00 ; $4579
	script_wait_frames $0f ; $4580
	script_move_player $3600, $0d00 ; $4587
	farcall FarPtr_WaitPlayerMoveDone ; $4591
	ld a, $50 ; $4594
	ld [$c2b0], a ; $4596
	ld a, $48 ; $4599
	ld [$c2b1], a ; $459b
	ld a, $01 ; $459e
	ld hl, $4d0a ; $45a0
	call RegisterFrameTask ; $45a3
	script_set_text $0430 ; $45a6
	script_speak $06 ; $45ac
	ld hl, $4d0a ; $45b1
	call UnregisterFrameTask ; $45b4
	script_move_player $3200, $1300 ; $45b7
	farcall FarPtr_WaitPlayerMoveDone ; $45c1
	script_wait_frames $1e ; $45c4
	script_face_pair $00, $06 ; $45cb
	script_speak $06 ; $45d3
	script_wait_frames $0f ; $45d8
	script_set_anim $00, $03 ; $45df
	script_wait_idle $00 ; $45e6
	script_wait_frames $1e ; $45eb
	script_face $06, $80 ; $45f2
	script_wait_frames $0f ; $45f9
	script_face $00, $80 ; $4600
	script_wait_frames $0f ; $4607
	script_move_player $2a00, $0d00 ; $460e
	farcall FarPtr_WaitPlayerMoveDone ; $4618
	ld a, $20 ; $461b
	ld [$c2b0], a ; $461d
	ld a, $48 ; $4620
	ld [$c2b1], a ; $4622
	ld a, $01 ; $4625
	ld hl, $4d0a ; $4627
	call RegisterFrameTask ; $462a
	script_speak $06 ; $462d
	ld hl, $4d0a ; $4632
	call UnregisterFrameTask ; $4635
	script_move_player $3200, $0d00 ; $4638
	farcall FarPtr_WaitPlayerMoveDone ; $4642
	script_face_pair $00, $06 ; $4645
	script_speak $06 ; $464d
	script_set_anim $00, $03 ; $4652
	script_wait_idle $00 ; $4659
	script_set_anim $06, $03 ; $465e
	script_wait_idle $06 ; $4665
	script_wait_frames $32 ; $466a
	script_face $06, $80 ; $4671
	script_wait_frames $28 ; $4678
	script_face $06, $40 ; $467f
	script_wait_frames $0a ; $4686
	script_face $06, $00 ; $468d
	script_wait_frames $28 ; $4694
	script_face $06, $40 ; $469b
	script_wait_frames $0a ; $46a2
	script_face $06, $80 ; $46a9
	script_wait_frames $28 ; $46b0
	script_face $06, $40 ; $46b7
	script_wait_frames $0a ; $46be
	script_face $06, $00 ; $46c5
	script_wait_frames $32 ; $46cc
	script_set_anim $06, $03 ; $46d3
	script_wait_idle $06 ; $46da
	script_speak $06 ; $46df
	script_move_target $06, $4100, $0d00 ; $46e4
	script_wait_frames $05 ; $46ef
	script_move_player $3600, $0d00 ; $46f6
	script_move_target $00, $3200, $0d20 ; $4700
	script_wait_move $00 ; $470b
	script_move_target $00, $4100, $0d20 ; $4710
	script_wait_move $00 ; $471b
	ld a, $0f ; $4720
	ld [$c294], a ; $4722
	ld [wStoryModeExitLocationRequest], a ; $4725
	farcall FarPtr_EndCutsceneScriptMode ; $4728
	ret ; $472b
AcademyCourtsTourActors_13:
	; $472c, 66 bytes (map_actors)
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4c, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4d, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4f, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3200, $1300, $40, $49, $01, $00
	map_actor_end
ServiceAceCoachIntroCutscene:
	ldh a, [hRomBank] ; $476e
	ld hl, ServiceAceCoachIntroActors_13 ; $4770
	farcall FarPtr_ScriptRespawnLocationActors ; $4773
	farcall FarPtr_BeginCutsceneScriptMode ; $4776
	script_set_position $00, $3f00, $3f00 ; $4779
	script_set_position $06, $3f00, $3f00 ; $4784
	script_set_position $07, $3f00, $3f00 ; $478f
	script_set_position $08, $3f00, $3f00 ; $479a
	script_fade_in $04 ; $47a5
	call WaitFadeEnd ; $47aa
	script_set_position $06, $4100, $0d00 ; $47ad
	script_move_target $06, $1b00, $0d00 ; $47b8
	script_set_position $00, $4300, $0d00 ; $47c3
	script_move_target $00, $1d00, $0d00 ; $47ce
	script_wait_frames $0f ; $47d9
	script_move_player $1b00, $0d00 ; $47e0
	script_wait_move $00 ; $47ea
	script_wait_frames $1e ; $47ef
	script_face_toward $00, $06 ; $47f6
	script_set_text $0435 ; $47fe
	script_speak $06 ; $4804
	script_set_anim $00, $03 ; $4809
	script_wait_idle $00 ; $4810
	script_face $06, $c0 ; $4815
	script_wait_frames $0f ; $481c
	script_face $00, $c0 ; $4823
	script_speak $06 ; $482a
	script_set_anim $00, $03 ; $482f
	script_wait_idle $00 ; $4836
	script_wait_frames $1e ; $483b
	call AnimateDoorOpen_13 ; $4842
	script_speak $07 ; $4845
	script_wait_frames $0f ; $484a
	script_set_position $03, $1c00, $0b00 ; $4851
	sound $97 ; $485c
	script_wait_frames $1e ; $485e
	script_set_position $03, $3f00, $3f00 ; $4865
	script_face $06, $80 ; $4870
	script_wait_frames $0f ; $4877
	script_face $00, $80 ; $487e
	script_move_player $1800, $0d00 ; $4885
	script_wait_frames $0f ; $488f
	script_set_position $07, $1500, $0980 ; $4896
	script_wait_frames $0f ; $48a1
	script_set_speed $07, $0010 ; $48a8
	script_move_target $07, $1500, $0d00 ; $48b0
	script_wait_move $07 ; $48bb
	script_face $07, $00 ; $48c0
	script_set_position $08, $1500, $0900 ; $48c7
	script_wait_frames $0f ; $48d2
	script_set_speed $08, $0010 ; $48d9
	script_move_target $08, $1500, $0b00 ; $48e1
	script_wait_move $08 ; $48ec
	call AnimateDoorClose_13 ; $48f1
	script_face $08, $00 ; $48f4
	script_wait_frames $0f ; $48fb
	script_set_anim $06, $02 ; $4902
	script_wait_idle $06 ; $4909
	script_speak $06 ; $490e
	script_face $07, $40 ; $4913
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
	script_face_toward $00, $06 ; $49a1
	script_wait_frames $32 ; $49a9
	script_face_toward $07, $06 ; $49b0
	ld a, [$c90d] ; $49b8
	or a, a ; $49bb
	jr z, Label_13_49c1 ; $49bc
	farcall FarPtr_AdvanceDialogueTextCursor ; $49be
Label_13_49c1:
	script_speak $06 ; $49c1
	script_set_text $043e ; $49c6
	script_wait_frames $0f ; $49cc
	script_set_speed $00, $0018 ; $49d3
	script_move_target $00, $1d00, $0c00 ; $49db
	script_wait_move $00 ; $49e6
	script_move_target $00, $1b00, $0b00 ; $49eb
	script_wait_move $00 ; $49f6
	script_face $00, $80 ; $49fb
	script_set_speed $00, $0020 ; $4a02
	script_wait_frames $0f ; $4a0a
	script_set_anim $00, $03 ; $4a11
	script_wait_idle $00 ; $4a18
	script_wait_frames $0f ; $4a1d
	script_face_pair $08, $07 ; $4a24
	script_wait_frames $46 ; $4a2c
	script_face_toward $00, $07 ; $4a33
	script_face_toward $00, $08 ; $4a3b
	script_wait_frames $0f ; $4a43
	script_speak $07 ; $4a4a
	script_set_anim $07, $03 ; $4a4f
	script_wait_idle $07 ; $4a56
	script_speak $07 ; $4a5b
	script_set_anim $00, $03 ; $4a60
	script_wait_idle $00 ; $4a67
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
	script_face_toward $06, $00 ; $4b25
	script_wait_frames $0f ; $4b2d
	script_set_position $05, $1c00, $0900 ; $4b34
	script_wait_frames $5a ; $4b3f
	script_set_position $05, $3f00, $3f00 ; $4b46
	script_wait_frames $0f ; $4b51
	script_speak $06 ; $4b58
	script_face_toward $00, $06 ; $4b5d
	script_wait_frames $1e ; $4b65
	script_speak $06 ; $4b6c
	script_set_anim $00, $02 ; $4b71
	script_wait_idle $00 ; $4b78
	script_wait_frames $3c ; $4b7d
	script_move_target $06, $1500, $0d00 ; $4b84
	script_wait_move $06 ; $4b8f
	script_face_toward $00, $06 ; $4b94
	script_wait_frames $1e ; $4b9c
	script_speak $06 ; $4ba3
	script_wait_frames $0f ; $4ba8
	script_move_target $00, $1700, $0d00 ; $4baf
	script_wait_move $00 ; $4bba
	script_wait_frames $0a ; $4bbf
	script_move_target $06, $0700, $0d00 ; $4bc6
	script_wait_frames $0a ; $4bd1
	script_move_player $0900, $0d00 ; $4bd8
	script_move_target $00, $0700, $0d00 ; $4be2
	script_wait_move $06 ; $4bed
	script_face $06, $c0 ; $4bf2
	script_move_angle $06, $c0, $0500 ; $4bf9
	script_set_speed $06, $000b ; $4c03
	script_wait_frames $0a ; $4c0b
	script_wait_move $00 ; $4c12
	script_face $00, $c0 ; $4c17
	script_move_angle $00, $c0, $0500 ; $4c1e
	script_set_speed $00, $000b ; $4c28
	script_wait_move $06 ; $4c30
	script_set_anim $06, $08 ; $4c35
	script_move_angle $06, $c0, $0100 ; $4c3c
	script_wait_move $00 ; $4c46
	script_set_anim $00, $08 ; $4c4b
	script_move_angle $00, $c0, $0100 ; $4c52
	script_set_position $06, $3f00, $3f00 ; $4c5c
	script_set_position $00, $3f00, $3f00 ; $4c67
	ld a, $0e ; $4c72
	ld [$c294], a ; $4c74
	ld [wStoryModeExitLocationRequest], a ; $4c77
	farcall FarPtr_EndCutsceneScriptMode ; $4c7a
	ret ; $4c7d
ServiceAceCoachIntroActors_13:
	; $4c7e, 94 bytes (map_actors)
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4c, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4d, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $fd00, $0100, $40, $4f, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $4100, $0d00, $80, $49, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $1500, $0d00, $40, $4a, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $1300, $0d00, $40, $4b, $01, $00
	map_actor_end
LoadTourPointerSpriteGfx_13:
	ldh a, [hWramBank] ; $4cdc
	push af ; $4cde
	wram_bank $01 ; $4cdf
	ld hl, $4d30 ; $4ce5
	ld de, $a000 ; $4ce8
	ld c, $04 ; $4ceb
	call QueueVRAMCopy ; $4ced
	ld hl, $4d70 ; $4cf0
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
	ld a, [$c2b0] ; $4d0a
	ld d, a ; $4d0d
	ldh a, [hVBlankCounter] ; $4d0e
	srl a ; $4d10
	and a, $07 ; $4d12
	ld e, a ; $4d14
	ld a, [$c2b1] ; $4d15
	add a, $08 ; $4d18
	sub a, e ; $4d1a
	ld e, a ; $4d1b
	call QueueTourPointerSprite_13 ; $4d1c
	ret ; $4d1f
SpriteTemplate_13_4d20:
	; $4d20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
	INCBIN "data/bank_013/d_4d29.bin" ; $4d29, 79 bytes
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
	map_actor $0000, ActorObjDef_13_7b25, $0b00, $0900, $40, $29, $01, $00
	map_actor $0000, ActorObjDef_13_585f, $0600, $1080, $40, $55, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $2900, $2900, $40, $4c, $01, $00
	map_actor_end
DormRoomEntryPoints_13:
	; $4e62, 49 bytes (map_entries)
	map_entry $01, $c0, $0b00, $0d00, $0000
	map_entry $02, $c0, $0b00, $1300, $0000
	map_entry $03, $c0, $0b00, $0d00, $0000
	map_entry $04, $c0, $0b00, $0d00, $0000
	map_entry $0e, $c0, $0b00, $0d00, $0000
	map_entry $0f, $c0, $0b00, $0d00, $0000
	db $ff
DormRoomExitTriggers_13:
	; $4e93, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_13_7b4d, $09, $02
	map_script $02, $ff, $0000, Func_13_7b4d, $00, $01
	db $ff
Func_13_4ea4:
	call AdvanceRandomSeed ; $4ea4
	ld a, l ; $4ea7
	and a, $07 ; $4ea8
	add a, $3c ; $4eaa
	ld l, a ; $4eac
	adc a, $05 ; $4ead
	sub a, l ; $4eaf
	ld h, a ; $4eb0
	farcall FarPtr_InitDialogueTextCursor ; $4eb1
	script_speak $04 ; $4eb4
	ret ; $4eb9
DormRoomNpcScripts_13:
	; $4eba, 17 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_13_52b0, $00, $00
	map_script $04, $ff, $0000, Func_13_4ea4, $13, $00
	db $ff
DormRoomFacingScripts_13:
	; $4ecb, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_13_4ed4, $00, $00
	db $ff
Func_13_4ed4:
	farcall FarPtr_BeginCutsceneScriptMode ; $4ed4
	script_fade_in $10 ; $4ed7
	script_set_text $0483 ; $4edc
	script_speak $00 ; $4ee2
	farcall FarPtr_EndCutsceneScriptMode ; $4ee7
	ret ; $4eea
DormRoomTileTriggers_13:
	; $4eeb, 9 bytes (map_scripts)
	map_script $0f, $80, $0000, Func_13_4ef4, $00, $00
	db $ff
Func_13_4ef4:
	ld a, $03 ; $4ef4
	farcall FarPtr_SetActorNullScript ; $4ef6
	ld a, $03 ; $4ef9
	script_set_text $0544 ; $4efb
	test_flag $1c, 0 ; $4f01
	jr z, Label_13_4f0c ; $4f04
	script_set_text $0548 ; $4f06
Label_13_4f0c:
	script_jump_velocity $03, $ff80 ; $4f0c
	ld a, $03 ; $4f14
	call Func_13_5bfb ; $4f16
	call Func_13_5c27 ; $4f19
	sound $97 ; $4f1c
	script_wait_frames $46 ; $4f1e
	script_set_position $05, $3f00, $3f00 ; $4f25
	script_speak $03 ; $4f30
	script_face_toward $00, $03 ; $4f35
	script_face_toward $03, $00 ; $4f3d
	script_set_position $06, $0c00, $0800 ; $4f45
	script_set_anim $03, $02 ; $4f50
	script_wait_idle $03 ; $4f57
	script_set_position $06, $3f00, $3f00 ; $4f5c
	script_speak $03 ; $4f67
	script_jump_velocity $00, $ff80 ; $4f6c
	ld a, $00 ; $4f74
	farcall FarPtr_ScriptWaitActorJumpDone ; $4f76
	test_flag $05, 7 ; $4f79
	jr nz, Label_13_4fd0 ; $4f7c
	script_speak $03 ; $4f7e
	script_set_anim $00, $03 ; $4f83
	script_wait_idle $00 ; $4f8a
	script_set_speed $00, $0030 ; $4f8f
	script_move_target $00, $0b00, $1400 ; $4f97
	script_wait_frames $0a ; $4fa2
	script_face_toward $00, $03 ; $4fa9
	ld a, $06 ; $4fb1
	ld [wStoryModeCurrentLocation], a ; $4fb3
	ld a, $0d ; $4fb6
	ld [wStoryModeEntryPoint], a ; $4fb8
	ld a, $ff ; $4fbb
	ld [$c294], a ; $4fbd
	ld [wStoryModeExitLocationRequest], a ; $4fc0
	ld c, $04 ; $4fc3
	call BeginFadeOut ; $4fc5
	script_wait_frames $14 ; $4fc8
	ret ; $4fcf
Label_13_4fd0:
	farcall FarPtr_AdvanceDialogueTextCursor ; $4fd0
	script_speak $03 ; $4fd3
	script_set_anim $00, $03 ; $4fd8
	script_wait_idle $00 ; $4fdf
	ld a, $03 ; $4fe4
	farcall FarPtr_GetActorStateAddr ; $4fe6
	ld c, l ; $4fe9
	ld b, h ; $4fea
	ld de, $d000 ; $4feb
	farcall FarPtr_04_20 ; $4fee
	script_set_speed $00, $0030 ; $4ff1
	script_move_target $00, $0b00, $1400 ; $4ff9
	script_wait_frames $0a ; $5004
	ld a, $06 ; $500b
	ld [wStoryModeCurrentLocation], a ; $500d
	ld a, $0d ; $5010
	ld [wStoryModeEntryPoint], a ; $5012
	ld a, $ff ; $5015
	ld [$c294], a ; $5017
	ld [wStoryModeExitLocationRequest], a ; $501a
	ld c, $04 ; $501d
	call BeginFadeOut ; $501f
	script_wait_frames $14 ; $5022
	ret ; $5029
DormRoomInitScript_13:
	xor a, a ; $502a
	ld [wStoryModeShowLocationName], a ; $502b
	ld a, [wStoryModeEntryPoint] ; $502e
	cp a, $0a ; $5031
	jp z, Label_13_5a76 ; $5033
	cp a, $09 ; $5036
	jp z, Label_13_5a92 ; $5038
	cp a, $08 ; $503b
	jp z, Label_13_5aae ; $503d
	call ComputeStoryRankTier_13 ; $5040
	call Func_13_5130 ; $5043
	call Func_13_51b0 ; $5046
	call Func_13_5067 ; $5049
	ld a, [wStoryModeEntryPoint] ; $504c
	cp a, $0f ; $504f
	jp z, Label_13_53a1 ; $5051
	sound $1c ; $5054
	ld a, [wStoryModeEntryPoint] ; $5056
	cp a, $01 ; $5059
	jp z, Label_13_52e7 ; $505b
	cp a, $02 ; $505e
	jp z, Label_13_5593 ; $5060
	farcall FarPtr_EndCutsceneScriptMode ; $5063
	ret ; $5066
Func_13_5067:
	test_flag $05, 7 ; $5067
	jr nz, Label_13_507c ; $506a
	test_flag $0b, 0 ; $506c
	jr nz, Label_13_5074 ; $506f
	jr Label_13_50de ; $5071
	ret ; $5073
Label_13_5074:
	test_flag $15, 6 ; $5074
	jr z, Label_13_508c ; $5077
	jr Label_13_50de ; $5079
	ret ; $507b
Label_13_507c:
	test_flag $09, 0 ; $507c
	jr nz, Label_13_5084 ; $507f
	jr Label_13_50de ; $5081
	ret ; $5083
Label_13_5084:
	test_flag $15, 7 ; $5084
	jr z, Label_13_508c ; $5087
	jr Label_13_50de ; $5089
	ret ; $508b
Label_13_508c:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	farcall FarPtr_WriteBehaviorMapCell ; $5092
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	farcall FarPtr_WriteBehaviorMapCell ; $509b
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	farcall FarPtr_WriteBehaviorMapCell ; $50a4
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	farcall FarPtr_WriteBehaviorMapCell ; $50ad
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	farcall FarPtr_WriteBehaviorMapCell ; $50b6
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	farcall FarPtr_WriteBehaviorMapCell ; $50bf
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	farcall FarPtr_WriteBehaviorMapCell ; $50c8
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	farcall FarPtr_WriteBehaviorMapCell ; $50d1
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	farcall FarPtr_WriteBehaviorMapCell ; $50da
	ret ; $50dd
Label_13_50de:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	farcall FarPtr_WriteBehaviorMapCell ; $50e4
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	farcall FarPtr_WriteBehaviorMapCell ; $50ed
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	farcall FarPtr_WriteBehaviorMapCell ; $50f6
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	farcall FarPtr_WriteBehaviorMapCell ; $50ff
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	farcall FarPtr_WriteBehaviorMapCell ; $5108
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	farcall FarPtr_WriteBehaviorMapCell ; $5111
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	farcall FarPtr_WriteBehaviorMapCell ; $511a
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	farcall FarPtr_WriteBehaviorMapCell ; $5123
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	farcall FarPtr_WriteBehaviorMapCell ; $512c
	ret ; $512f
Func_13_5130:
	ld a, [$c94d] ; $5130
	or a, a ; $5133
	jr nz, Label_13_51ac ; $5134
	farcall FarPtr_WaitPlayerMoveDone ; $5136
	ld b, $20 ; $5139
	ld c, $00 ; $513b
	ld d, $00 ; $513d
	ld e, $00 ; $513f
	ld h, $16 ; $5141
	ld l, $16 ; $5143
	farcall FarPtr_CopyCollisionMapRect ; $5145
	ld b, $20 ; $5148
	ld c, $00 ; $514a
	ld d, $00 ; $514c
	ld e, $00 ; $514e
	ld h, $16 ; $5150
	ld l, $16 ; $5152
	farcall FarPtr_CopyBehaviorMapRect ; $5154
	script_copy_scene_rect $20, $00, $00, $00, $16, $18 ; $5157
	script_set_objdef $28, $03 ; $5166
	script_set_anim $03, $01 ; $5172
	script_set_position $04, $1f00, $1500 ; $5179
	ld a, $04 ; $5184
	farcall FarPtr_SetActorNullScript ; $5186
	set_flag $1c, 0 ; $5189
	ld a, $02 ; $518c
	ld [$c329], a ; $518e
	ld a, $02 ; $5191
	ld [$c32a], a ; $5193
	ld a, $16 ; $5196
	ld [$c32b], a ; $5198
	ld a, $14 ; $519b
	ld [$c32c], a ; $519d
	call DisableLCDSafely ; $51a0
	ld a, $00 ; $51a3
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $51a5
	call EnableLCD ; $51a8
	ret ; $51ab
Label_13_51ac:
	call Func_13_524e ; $51ac
	ret ; $51af
Func_13_51b0:
	ld a, [wStoryModeEntryPoint] ; $51b0
	cp a, $ff ; $51b3
	jr z, Label_13_521b ; $51b5
	cp a, $01 ; $51b7
	jr z, Label_13_51d3 ; $51b9
	wram_bank $04 ; $51bb
	test_flag $05, 7 ; $51c1
	jp nz, Label_13_527a ; $51c4
	script_set_position $03, $0b00, $0a00 ; $51c7
	ret ; $51d2
Label_13_51d3:
	test_flag $05, 7 ; $51d3
	jr z, Label_13_5208 ; $51d6
	script_set_position $03, $0b00, $0a00 ; $51d8
	script_face $03, $40 ; $51e3
	ld a, $02 ; $51ea
	farcall FarPtr_SetActorNullScript ; $51ec
	script_set_position $02, $0100, $0100 ; $51ef
	ld a, $03 ; $51fa
	farcall FarPtr_GetActorStateAddr ; $51fc
	ld c, l ; $51ff
	ld b, h ; $5200
	ld hl, $0005 ; $5201
	add hl, bc ; $5204
	set 4, [hl] ; $5205
	ret ; $5207
Label_13_5208:
	script_set_position $03, $0b00, $0a00 ; $5208
	script_face $03, $40 ; $5213
	ret ; $521a
Label_13_521b:
	test_flag $05, 7 ; $521b
	jr z, Label_13_5208 ; $521e
	ld a, $02 ; $5220
	farcall FarPtr_SetActorNullScript ; $5222
	script_set_position $02, $0100, $0100 ; $5225
	call Func_13_5c39 ; $5230
	ld a, $03 ; $5233
	farcall FarPtr_GetActorStateAddr ; $5235
	ld c, l ; $5238
	ld b, h ; $5239
	ld de, $d000 ; $523a
	farcall FarPtr_04_20 ; $523d
	ld a, $03 ; $5240
	farcall FarPtr_GetActorStateAddr ; $5242
	ld c, l ; $5245
	ld b, h ; $5246
	ld hl, $0005 ; $5247
	add hl, bc ; $524a
	set 4, [hl] ; $524b
	ret ; $524d
Func_13_524e:
	call AdvanceRandomSeed ; $524e
	ld a, l ; $5251
	and a, $07 ; $5252
	add a, a ; $5254
	add a, $6a ; $5255
	ld l, a ; $5257
	adc a, $52 ; $5258
	sub a, l ; $525a
	ld h, a ; $525b
	ld a, [hl+] ; $525c
	ld h, [hl] ; $525d
	ld l, a ; $525e
	ld e, l ; $525f
	ld d, h ; $5260
	ldh a, [hRomBank] ; $5261
	ld b, a ; $5263
	ld a, $04 ; $5264
	farcall FarPtr_ScriptSetActorScript ; $5266
	ret ; $5269
StoryCmdHandlersC_13:
	; $526a, 16 bytes (records:2)
	dw ActorObjDef_13_585f ; record 0
	dw $5877 ; record 1
	dw $5881 ; record 2
	dw $588b ; record 3
	dw ActorObjDef_13_585f ; record 4
	dw ActorObjDef_13_585f ; record 5
	dw $588b ; record 6
	dw $588b ; record 7
Label_13_527a:
	ld a, $02 ; $527a
	farcall FarPtr_SetActorNullScript ; $527c
	script_set_position $02, $1500, $1f00 ; $527f
	script_set_position $03, $0b00, $1000 ; $528a
	script_face $03, $c0 ; $5295
	script_fade_in $04 ; $529c
	call WaitFadeEnd ; $52a1
	script_move_target $03, $0b00, $0a00 ; $52a4
	ret ; $52af
Func_13_52b0:
	script_face_toward $00, $03 ; $52b0
	test_flag $1c, 0 ; $52b8
	jr z, Label_13_52c5 ; $52bb
	script_set_text $0521 ; $52bd
	jr Label_13_52cb ; $52c3
Label_13_52c5:
	script_set_text $04ff ; $52c5
Label_13_52cb:
	ld a, $03 ; $52cb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $52cd
	farcall FarPtr_RunDialogueYesNoPrompt ; $52d0
	farcall FarPtr_ScriptCloseDialogueWindow ; $52d3
	script_wait_frames $05 ; $52d6
	and a, a ; $52dd
	jr nz, Label_13_52e3 ; $52de
	call RunAcademyQuestionsMenu ; $52e0
Label_13_52e3:
	call RunPlayDoublesTodayPrompt ; $52e3
	ret ; $52e6
Label_13_52e7:
	call Func_13_5aca ; $52e7
	cp a, $01 ; $52ea
	jp z, Label_13_5aee ; $52ec
	test_flag $1c, 0 ; $52ef
	jr z, Label_13_52fc ; $52f2
	script_set_text $0507 ; $52f4
	jr Label_13_5302 ; $52fa
Label_13_52fc:
	script_set_text $0502 ; $52fc
Label_13_5302:
	ld a, $02 ; $5302
	farcall FarPtr_SetActorNullScript ; $5304
	script_set_position $02, $0b00, $1e00 ; $5307
	script_face $02, $40 ; $5312
	script_set_position $03, $0b00, $0a00 ; $5319
	script_face $03, $40 ; $5324
	script_fade_in $04 ; $532b
	call WaitFadeEnd ; $5330
	test_flag $05, 7 ; $5333
	jr z, Label_13_538f ; $5336
	farcall FarPtr_AdvanceDialogueTextCursor ; $5338
	test_flag $15, 7 ; $533b
	jr nz, Label_13_5355 ; $533e
	script_speak $03 ; $5340
	test_flag $08, 2 ; $5345
	jr z, Label_13_5355 ; $5348
	farcall FarPtr_AdvanceDialogueTextCursor ; $534a
	test_flag $08, 6 ; $534d
	jr z, Label_13_5355 ; $5350
	farcall FarPtr_AdvanceDialogueTextCursor ; $5352
Label_13_5355:
	script_speak $03 ; $5355
	script_set_anim $00, $03 ; $535a
	script_wait_idle $00 ; $5361
	ld a, $03 ; $5366
	farcall FarPtr_GetActorStateAddr ; $5368
	ld c, l ; $536b
	ld b, h ; $536c
	ld de, $d000 ; $536d
	farcall FarPtr_04_20 ; $5370
	script_face $00, $40 ; $5373
	ld a, $03 ; $537a
	farcall FarPtr_GetActorStateAddr ; $537c
	ld c, l ; $537f
	ld b, h ; $5380
	ld hl, $0005 ; $5381
	add hl, bc ; $5384
	set 4, [hl] ; $5385
	script_wait_frames $05 ; $5387
	ret ; $538e
Label_13_538f:
	script_speak $03 ; $538f
	script_set_anim $00, $03 ; $5394
	script_wait_idle $00 ; $539b
	ret ; $53a0
Label_13_53a1:
	sound $41 ; $53a1
	script_set_speed $00, $0010 ; $53a3
	script_player_speed $0040 ; $53ab
	test_flag $1c, 0 ; $53b1
	jr z, Label_13_53be ; $53b4
	script_set_text $0516 ; $53b6
	jr Label_13_53c4 ; $53bc
Label_13_53be:
	script_set_text $04f4 ; $53be
Label_13_53c4:
	script_set_position $00, $0b00, $0e00 ; $53c4
	script_set_position $03, $0b00, $0a00 ; $53cf
	script_move_player $0b00, $0a00 ; $53da
	farcall FarPtr_WaitPlayerMoveDone ; $53e4
	script_wait_frames $78 ; $53e7
	script_wait_frames $b4 ; $53ee
	script_fade_in $04 ; $53f5
	call WaitJingleEnd ; $53fa
	sound $1c ; $53fd
	script_wait_frames $0a ; $53ff
	ld a, $03 ; $5406
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5408
	farcall FarPtr_RunDialogueYesNoPrompt ; $540b
	farcall FarPtr_ScriptCloseDialogueWindow ; $540e
	script_wait_frames $05 ; $5411
	and a, a ; $5418
	jr nz, Label_13_5425 ; $5419
	script_speak $03 ; $541b
	farcall FarPtr_AdvanceDialogueTextCursor ; $5420
	jr Label_13_5430 ; $5423
Label_13_5425:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5425
	script_speak $03 ; $5428
	set_flag $1c, 1 ; $542d
Label_13_5430:
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
	script_face_toward $00, $03 ; $5483
	ld a, $03 ; $548b
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $548d
	farcall FarPtr_RunDialogueYesNoPrompt ; $5490
	farcall FarPtr_ScriptCloseDialogueWindow ; $5493
	script_wait_frames $05 ; $5496
	and a, a ; $549d
	jr nz, Label_13_54aa ; $549e
	script_speak $03 ; $54a0
	farcall FarPtr_AdvanceDialogueTextCursor ; $54a5
	jr Label_13_54b2 ; $54a8
Label_13_54aa:
	farcall FarPtr_AdvanceDialogueTextCursor ; $54aa
	script_speak $03 ; $54ad
Label_13_54b2:
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
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $54f2
	farcall FarPtr_RunDialogueYesNoPrompt ; $54f5
	farcall FarPtr_ScriptCloseDialogueWindow ; $54f8
	script_wait_frames $05 ; $54fb
	and a, a ; $5502
	jr nz, Label_13_5508 ; $5503
	call RunAcademyQuestionsMenu ; $5505
Label_13_5508:
	test_flag $1c, 0 ; $5508
	jr nz, Label_13_5550 ; $550b
	test_flag $1c, 1 ; $550d
	jr nz, Label_13_5531 ; $5510
	script_wait_frames $14 ; $5512
	script_set_anim $03, $03 ; $5519
	script_wait_idle $03 ; $5520
	script_set_text $0500 ; $5525
	script_speak $03 ; $552b
	ret ; $5530
Label_13_5531:
	script_wait_frames $14 ; $5531
	script_set_anim $03, $03 ; $5538
	script_wait_idle $03 ; $553f
	script_set_text $0501 ; $5544
	script_speak $03 ; $554a
	ret ; $554f
Label_13_5550:
	test_flag $1c, 1 ; $5550
	jr nz, Label_13_5574 ; $5553
	script_wait_frames $14 ; $5555
	script_set_anim $03, $03 ; $555c
	script_wait_idle $03 ; $5563
	script_set_text $0523 ; $5568
	script_speak $03 ; $556e
	ret ; $5573
Label_13_5574:
	script_wait_frames $14 ; $5574
	script_set_anim $03, $03 ; $557b
	script_wait_idle $03 ; $5582
	script_set_text $0522 ; $5587
	script_speak $03 ; $558d
	ret ; $5592
Label_13_5593:
	test_flag $1c, 0 ; $5593
	jr z, Label_13_55a3 ; $5596
	ld hl, $c2b2 ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr Label_13_55ac ; $55a1
Label_13_55a3:
	ld hl, $c2b2 ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
Label_13_55ac:
	ld hl, $c2b2 ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	farcall FarPtr_InitDialogueTextCursor ; $55b2
	test_flag $05, 7 ; $55b5
	jr z, Label_13_55bd ; $55b8
	farcall FarPtr_AdvanceDialogueTextCursor ; $55ba
Label_13_55bd:
	script_wait_frames $1e ; $55bd
	script_move_target $00, $0b00, $0e00 ; $55c4
	script_fade_in $04 ; $55cf
	call WaitFadeEnd ; $55d4
	script_move_player $0b00, $0c40 ; $55d7
	farcall FarPtr_WaitPlayerMoveDone ; $55e1
	script_face $03, $40 ; $55e4
	script_set_anim $03, $03 ; $55eb
	script_wait_idle $03 ; $55f2
	script_speak $03 ; $55f7
	call Func_13_5aca ; $55fc
	and a, a ; $55ff
	jp z, Label_13_560d ; $5600
	ld hl, $c2b2 ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr Label_13_5615 ; $560b
Label_13_560d:
	ld hl, $c2b2 ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
Label_13_5615:
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_13_561a ; $5617
	inc h ; $5619
Label_13_561a:
	farcall FarPtr_InitDialogueTextCursor ; $561a
	script_set_anim $03, $04 ; $561d
	script_wait_idle $03 ; $5624
	ld a, $03 ; $5629
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $562b
	farcall FarPtr_RunDialogueYesNoPrompt ; $562e
	farcall FarPtr_ScriptCloseDialogueWindow ; $5631
	script_wait_frames $05 ; $5634
	and a, a ; $563b
	jr nz, Label_13_568f ; $563c
	ld hl, $c2b2 ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add a, l ; $5646
	ld l, a ; $5647
	jr nc, Label_13_564b ; $5648
	inc h ; $564a
Label_13_564b:
	farcall FarPtr_InitDialogueTextCursor ; $564b
	script_speak $03 ; $564e
	sound $00 ; $5653
	script_wait_frames $02 ; $5655
	sound $41 ; $565c
	script_set_anim $00, $03 ; $565e
	script_set_anim $03, $03 ; $5665
	script_wait_idle $03 ; $566c
	call WaitJingleEnd ; $5671
	ld c, $04 ; $5674
	call BeginFadeOut ; $5676
	call WaitFadeEnd ; $5679
	ld a, $02 ; $567c
	ld [$c294], a ; $567e
	ld [wStoryModeExitLocationRequest], a ; $5681
	ld b, $0a ; $5684
	ld c, $01 ; $5686
	farcall FarPtr_SaveStoryReturnPoint ; $5688
	farcall FarPtr_SaveStorySlotWithTimer ; $568b
	ret ; $568e
Label_13_568f:
	ld hl, $c2b2 ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add a, l ; $5697
	ld l, a ; $5698
	jr nc, Label_13_569c ; $5699
	inc h ; $569b
Label_13_569c:
	farcall FarPtr_InitDialogueTextCursor ; $569c
	ld a, $03 ; $569f
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $56a1
	farcall FarPtr_RunDialogueYesNoPrompt ; $56a4
	farcall FarPtr_ScriptCloseDialogueWindow ; $56a7
	script_wait_frames $05 ; $56aa
	and a, a ; $56b1
	jr nz, Label_13_56b7 ; $56b2
	call RunAcademyQuestionsMenu ; $56b4
Label_13_56b7:
	call RunPlayDoublesTodayPrompt ; $56b7
	ret ; $56ba
RunPlayDoublesTodayPrompt:
	test_flag $05, 7 ; $56bb
	jp nz, Label_13_5782 ; $56be
	test_flag $1c, 0 ; $56c1
	jr nz, Label_13_56ce ; $56c4
	script_set_text $0536 ; $56c6
	jr Label_13_56d4 ; $56cc
Label_13_56ce:
	script_set_text $0530 ; $56ce
Label_13_56d4:
	ld a, $03 ; $56d4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $56d6
	farcall FarPtr_RunDialogueYesNoPrompt ; $56d9
	farcall FarPtr_ScriptCloseDialogueWindow ; $56dc
	script_wait_frames $05 ; $56df
	and a, a ; $56e6
	jr nz, Label_13_574c ; $56e7
	set_flag $05, 7 ; $56e9
	call Func_13_5bdf ; $56ec
	script_speak $03 ; $56ef
	script_set_anim $00, $03 ; $56f4
	script_wait_idle $00 ; $56fb
	script_wait_frames $05 ; $5700
	script_face $00, $40 ; $5707
	wram_bank $04 ; $570e
	ld a, $01 ; $5714
	ld [wMatchIsDoubles], a ; $5716
	call Func_13_5067 ; $5719
	script_wait_frames $05 ; $571c
	ld a, $03 ; $5723
	farcall FarPtr_GetActorStateAddr ; $5725
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, $d000 ; $572a
	farcall FarPtr_04_20 ; $572d
	ld a, $03 ; $5730
	farcall FarPtr_GetActorStateAddr ; $5732
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, $0005 ; $5737
	add hl, bc ; $573a
	set 4, [hl] ; $573b
	script_wait_frames $05 ; $573d
	script_face $00, $40 ; $5744
	ret ; $574b
Label_13_574c:
	call Func_13_5b8b ; $574c
	farcall FarPtr_AdvanceDialogueTextCursor ; $574f
	script_speak $03 ; $5752
	clear_flag $05, 7 ; $5757
	wram_bank $04 ; $575a
	ld a, $00 ; $5760
	ld [wMatchIsDoubles], a ; $5762
	ld a, $03 ; $5765
	farcall FarPtr_SetActorNullScript ; $5767
	ld a, $03 ; $576a
	farcall FarPtr_GetActorStateAddr ; $576c
	ld c, l ; $576f
	ld b, h ; $5770
	ld hl, $0005 ; $5771
	add hl, bc ; $5774
	set 3, [hl] ; $5775
	call Func_13_5067 ; $5777
	script_face $03, $40 ; $577a
	ret ; $5781
Label_13_5782:
	test_flag $1c, 0 ; $5782
	jr nz, Label_13_578f ; $5785
	script_set_text $0539 ; $5787
	jr Label_13_5795 ; $578d
Label_13_578f:
	script_set_text $0533 ; $578f
Label_13_5795:
	ld a, $03 ; $5795
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5797
	farcall FarPtr_RunDialogueYesNoPrompt ; $579a
	farcall FarPtr_ScriptCloseDialogueWindow ; $579d
	script_wait_frames $05 ; $57a0
	and a, a ; $57a7
	jr nz, Label_13_5807 ; $57a8
	call Func_13_5bc3 ; $57aa
	script_speak $03 ; $57ad
	ld a, $03 ; $57b2
	farcall FarPtr_SetActorNullScript ; $57b4
	clear_flag $05, 7 ; $57b7
	wram_bank $04 ; $57ba
	ld a, $00 ; $57c0
	ld [wMatchIsDoubles], a ; $57c2
	script_move_target $03, $0b00, $0900 ; $57c5
	script_wait_move $03 ; $57d0
	script_wait_frames $05 ; $57d5
	script_face $03, $40 ; $57dc
	script_wait_frames $05 ; $57e3
	ld a, $03 ; $57ea
	farcall FarPtr_GetActorStateAddr ; $57ec
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, $0005 ; $57f1
	add hl, bc ; $57f4
	set 3, [hl] ; $57f5
	call Func_13_5067 ; $57f7
	ld a, $03 ; $57fa
	farcall FarPtr_SetActorNullScript ; $57fc
	script_face $03, $40 ; $57ff
	ret ; $5806
Label_13_5807:
	call Func_13_5ba7 ; $5807
	farcall FarPtr_AdvanceDialogueTextCursor ; $580a
	script_speak $03 ; $580d
	script_set_anim $00, $03 ; $5812
	script_wait_idle $00 ; $5819
	script_face $00, $40 ; $581e
	script_wait_frames $05 ; $5825
	wram_bank $04 ; $582c
	ld a, $01 ; $5832
	ld [wMatchIsDoubles], a ; $5834
	set_flag $05, 7 ; $5837
	call Func_13_5067 ; $583a
	ld a, $03 ; $583d
	farcall FarPtr_GetActorStateAddr ; $583f
	ld c, l ; $5842
	ld b, h ; $5843
	ld de, $d000 ; $5844
	farcall FarPtr_04_20 ; $5847
	ld a, $03 ; $584a
	farcall FarPtr_GetActorStateAddr ; $584c
	ld c, l ; $584f
	ld b, h ; $5850
	ld hl, $0005 ; $5851
	add hl, bc ; $5854
	set 4, [hl] ; $5855
	script_face $00, $40 ; $5857
	ret ; $585e
ActorObjDef_13_585f:
	inc de ; $585f
	add hl, bc ; $5860
	ld [bc], a ; $5861
	ld [bc], a ; $5862
	inc d ; $5863
	dec c ; $5864
	inc d ; $5865
	ld b, b ; $5866
	nop ; $5867
	ld bc, $09b4 ; $5868
	ld [bc], a ; $586b
	ld [bc], a ; $586c
	inc d ; $586d
	dec c ; $586e
	inc d ; $586f
	ret nz ; $5870
	nop ; $5871
	ld bc, $0cb4 ; $5872
	db $eb ; $5875
	db $ff ; $5876
	inc bc ; $5877
	ld b, b ; $5878
	rrca ; $5879
	ldh [$ff0e], a ; $587a
	dec c ; $587c
	inc d ; $587d
	ld b, b ; $587e
	nop ; $587f
	nop ; $5880
	inc bc ; $5881
	nop ; $5882
	ld de, $0380 ; $5883
	dec c ; $5886
	inc d ; $5887
	ret nz ; $5888
	nop ; $5889
	nop ; $588a
	inc bc ; $588b
	nop ; $588c
	inc bc ; $588d
	nop ; $588e
	rlca ; $588f
	dec c ; $5890
	inc d ; $5891
	ret nz ; $5892
	nop ; $5893
	inc de ; $5894
	dec c ; $5895
	inc d ; $5896
	ld b, b ; $5897
	nop ; $5898
	ld bc, $04b4 ; $5899
	nop ; $589c
	inc bc ; $589d
	nop ; $589e
	ld [$0114], sp ; $589f
	ld d, b ; $58a2
	dec c ; $58a3
	inc d ; $58a4
	nop ; $58a5
	nop ; $58a6
	ld bc, $0412 ; $58a7
	nop ; $58aa
	inc bc ; $58ab
	nop ; $58ac
	rlca ; $58ad
	inc d ; $58ae
	dec c ; $58af
	inc d ; $58b0
	ret nz ; $58b1
	nop ; $58b2
	ld bc, $0df0 ; $58b3
	inc d ; $58b6
	nop ; $58b7
	nop ; $58b8
	ld bc, $0c12 ; $58b9
	reti ; $58bc
	ds 1, $ff ; $58bd, fill
RunAcademyQuestionsMenu:
	test_flag $1c, 0 ; $58be
	jr z, Label_13_58cb ; $58c1
	ld hl, $c2b2 ; $58c3
	ld de, $054f ; $58c6
	jr Label_13_58d1 ; $58c9
Label_13_58cb:
	ld hl, $c2b2 ; $58cb
	ld de, $0808 ; $58ce
Label_13_58d1:
	ld a, e ; $58d1
	ld [hl+], a ; $58d2
	ld [hl], d ; $58d3
	ld hl, $054c ; $58d4
	test_flag $0a, 7 ; $58d7
	jr z, Label_13_58e7 ; $58da
	ld hl, $054d ; $58dc
	test_flag $0b, 0 ; $58df
	jr z, Label_13_58e7 ; $58e2
	ld hl, $054e ; $58e4
Label_13_58e7:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	farcall FarPtr_RunPagedTextMenu ; $58ec
	cp a, $ff ; $58ef
	jp z, Label_13_5927 ; $58f1
	add a, a ; $58f4
	add a, $28 ; $58f5
	ld l, a ; $58f7
	adc a, $59 ; $58f8
	sub a, l ; $58fa
	ld h, a ; $58fb
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	script_speak $03 ; $5902
	ld hl, $c2b2 ; $5907
	ld a, [hl+] ; $590a
	ld h, [hl] ; $590b
	ld l, a ; $590c
	farcall FarPtr_InitDialogueTextCursor ; $590d
	ld a, $03 ; $5910
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5912
	farcall FarPtr_RunDialogueYesNoPrompt ; $5915
	farcall FarPtr_ScriptCloseDialogueWindow ; $5918
	script_wait_frames $05 ; $591b
	and a, a ; $5922
	jr nz, Label_13_5927 ; $5923
	jr Label_13_58d1 ; $5925
Label_13_5927:
	ret ; $5927
	ld [hl], $59 ; $5928
	ld l, b ; $592a
	ld e, c ; $592b
	and a, [hl] ; $592c
	ld e, c ; $592d
	ret nz ; $592e
	ld e, c ; $592f
	and a, $59 ; $5930
	nop ; $5932
	ld e, d ; $5933
	ld a, [de] ; $5934
	ld e, d ; $5935
	ld de, $0001 ; $5936
	ld hl, $c2b2 ; $5939
	ld a, [hl+] ; $593c
	ld h, [hl] ; $593d
	ld l, a ; $593e
	add hl, de ; $593f
	test_flag $0a, 7 ; $5940
	jr z, Label_13_5964 ; $5943
	ld a, $01 ; $5945
	add a, l ; $5947
	ld l, a ; $5948
	jr nc, Label_13_594c ; $5949
	inc h ; $594b
Label_13_594c:
	test_flag $0b, 0 ; $594c
	jr z, Label_13_5964 ; $594f
	ld a, $01 ; $5951
	add a, l ; $5953
	ld l, a ; $5954
	jr nc, Label_13_5958 ; $5955
	inc h ; $5957
Label_13_5958:
	test_flag $07, 4 ; $5958
	jr z, Label_13_5964 ; $595b
	ld a, $01 ; $595d
	add a, l ; $595f
	ld l, a ; $5960
	jr nc, Label_13_5964 ; $5961
	inc h ; $5963
Label_13_5964:
	farcall FarPtr_InitDialogueTextCursor ; $5964
	ret ; $5967
	ld de, $0005 ; $5968
	ld hl, $c2b2 ; $596b
	ld a, [hl+] ; $596e
	ld h, [hl] ; $596f
	ld l, a ; $5970
	add hl, de ; $5971
	test_flag $08, 2 ; $5972
	jr z, Label_13_59a2 ; $5975
	ld a, $01 ; $5977
	add a, l ; $5979
	ld l, a ; $597a
	jr nc, Label_13_597e ; $597b
	inc h ; $597d
Label_13_597e:
	test_flag $08, 6 ; $597e
	jr z, Label_13_59a2 ; $5981
	ld a, $01 ; $5983
	add a, l ; $5985
	ld l, a ; $5986
	jr nc, Label_13_598a ; $5987
	inc h ; $5989
Label_13_598a:
	test_flag $09, 0 ; $598a
	jr z, Label_13_59a2 ; $598d
	ld a, $01 ; $598f
	add a, l ; $5991
	ld l, a ; $5992
	jr nc, Label_13_5996 ; $5993
	inc h ; $5995
Label_13_5996:
	test_flag $06, 5 ; $5996
	jr z, Label_13_59a2 ; $5999
	ld a, $01 ; $599b
	add a, l ; $599d
	ld l, a ; $599e
	jr nc, Label_13_59a2 ; $599f
	inc h ; $59a1
Label_13_59a2:
	farcall FarPtr_InitDialogueTextCursor ; $59a2
	ret ; $59a5
	ld de, $000a ; $59a6
	ld hl, $c2b2 ; $59a9
	ld a, [hl+] ; $59ac
	ld h, [hl] ; $59ad
	ld l, a ; $59ae
	add hl, de ; $59af
	test_flag $0a, 3 ; $59b0
	jr z, Label_13_59bc ; $59b3
	ld a, $01 ; $59b5
	add a, l ; $59b7
	ld l, a ; $59b8
	jr nc, Label_13_59bc ; $59b9
	inc h ; $59bb
Label_13_59bc:
	farcall FarPtr_InitDialogueTextCursor ; $59bc
	ret ; $59bf
	ld de, $000c ; $59c0
	ld hl, $c2b2 ; $59c3
	ld a, [hl+] ; $59c6
	ld h, [hl] ; $59c7
	ld l, a ; $59c8
	add hl, de ; $59c9
	test_flag $0a, 3 ; $59ca
	jr z, Label_13_59e2 ; $59cd
	ld a, $01 ; $59cf
	add a, l ; $59d1
	ld l, a ; $59d2
	jr nc, Label_13_59d6 ; $59d3
	inc h ; $59d5
Label_13_59d6:
	test_flag $0a, 7 ; $59d6
	jr z, Label_13_59e2 ; $59d9
	ld a, $01 ; $59db
	add a, l ; $59dd
	ld l, a ; $59de
	jr nc, Label_13_59e2 ; $59df
	inc h ; $59e1
Label_13_59e2:
	farcall FarPtr_InitDialogueTextCursor ; $59e2
	ret ; $59e5
	ld de, $000f ; $59e6
	ld hl, $c2b2 ; $59e9
	ld a, [hl+] ; $59ec
	ld h, [hl] ; $59ed
	ld l, a ; $59ee
	add hl, de ; $59ef
	test_flag $0b, 0 ; $59f0
	jr z, Label_13_59fc ; $59f3
	ld a, $01 ; $59f5
	add a, l ; $59f7
	ld l, a ; $59f8
	jr nc, Label_13_59fc ; $59f9
	inc h ; $59fb
Label_13_59fc:
	farcall FarPtr_InitDialogueTextCursor ; $59fc
	ret ; $59ff
	ld de, $0011 ; $5a00
	ld hl, $c2b2 ; $5a03
	ld a, [hl+] ; $5a06
	ld h, [hl] ; $5a07
	ld l, a ; $5a08
	add hl, de ; $5a09
	test_flag $0b, 0 ; $5a0a
	jr z, Label_13_5a16 ; $5a0d
	ld a, $01 ; $5a0f
	add a, l ; $5a11
	ld l, a ; $5a12
	jr nc, Label_13_5a16 ; $5a13
	inc h ; $5a15
Label_13_5a16:
	farcall FarPtr_InitDialogueTextCursor ; $5a16
	ret ; $5a19
	ld de, $0013 ; $5a1a
	ld hl, $c2b2 ; $5a1d
	ld a, [hl+] ; $5a20
	ld h, [hl] ; $5a21
	ld l, a ; $5a22
	add hl, de ; $5a23
	farcall FarPtr_InitDialogueTextCursor ; $5a24
	ret ; $5a27
ShowStoryNarration_13:
	sound $00 ; $5a28
	script_set_position $03, $3f00, $3f00 ; $5a2a
	script_set_position $04, $3f00, $3f00 ; $5a35
	script_set_active $00, $00 ; $5a40
	script_set_active $02, $00 ; $5a47
	script_copy_scene_rect $00, $20, $00, $00, $16, $18 ; $5a4e
	script_fade_in $08 ; $5a5d
	script_wait_frames $04 ; $5a62
	script_speak $85 ; $5a69
	script_wait_frames $04 ; $5a6e
	ret ; $5a75
Label_13_5a76:
	script_set_text $01f0 ; $5a76
	call ShowStoryNarration_13 ; $5a7c
	ld a, $14 ; $5a7f
	ld [wStoryModeCurrentLocation], a ; $5a81
	ld a, $0a ; $5a84
	ld [wStoryModeEntryPoint], a ; $5a86
	ld a, $ff ; $5a89
	ld [$c294], a ; $5a8b
	ld [wStoryModeExitLocationRequest], a ; $5a8e
	ret ; $5a91
Label_13_5a92:
	script_set_text $01f1 ; $5a92
	call ShowStoryNarration_13 ; $5a98
	ld a, $15 ; $5a9b
	ld [wStoryModeCurrentLocation], a ; $5a9d
	ld a, $0f ; $5aa0
	ld [wStoryModeEntryPoint], a ; $5aa2
	ld a, $ff ; $5aa5
	ld [$c294], a ; $5aa7
	ld [wStoryModeExitLocationRequest], a ; $5aaa
	ret ; $5aad
Label_13_5aae:
	script_set_text $01f0 ; $5aae
	call ShowStoryNarration_13 ; $5ab4
	ld a, $14 ; $5ab7
	ld [wStoryModeCurrentLocation], a ; $5ab9
	ld a, $0a ; $5abc
	ld [wStoryModeEntryPoint], a ; $5abe
	ld a, $ff ; $5ac1
	ld [$c294], a ; $5ac3
	ld [wStoryModeExitLocationRequest], a ; $5ac6
	ret ; $5ac9
Func_13_5aca:
	test_flag $05, 7 ; $5aca
	jr nz, Label_13_5ae2 ; $5acd
	test_flag $16, 0 ; $5acf
	jr nz, Label_13_5adf ; $5ad2
	test_flag $15, 6 ; $5ad4
	jr nz, Label_13_5adc ; $5ad7
Label_13_5ad9:
	ld a, $00 ; $5ad9
	ret ; $5adb
Label_13_5adc:
	ld a, $01 ; $5adc
	ret ; $5ade
Label_13_5adf:
	ld a, $02 ; $5adf
	ret ; $5ae1
Label_13_5ae2:
	test_flag $16, 1 ; $5ae2
	jr nz, Label_13_5adf ; $5ae5
	test_flag $15, 7 ; $5ae7
	jr nz, Label_13_5adc ; $5aea
	jr Label_13_5ad9 ; $5aec
Label_13_5aee:
	test_flag $1c, 0 ; $5aee
	jr z, Label_13_5afb ; $5af1
	script_set_text $0511 ; $5af3
	jr Label_13_5b01 ; $5af9
Label_13_5afb:
	script_set_text $050c ; $5afb
Label_13_5b01:
	ld a, $02 ; $5b01
	farcall FarPtr_SetActorNullScript ; $5b03
	script_set_position $02, $0b00, $1e00 ; $5b06
	script_face $02, $40 ; $5b11
	script_set_position $03, $0b00, $0a00 ; $5b18
	script_face $03, $40 ; $5b23
	script_fade_in $04 ; $5b2a
	call WaitFadeEnd ; $5b2f
	test_flag $05, 7 ; $5b32
	jr z, Label_13_5b79 ; $5b35
	farcall FarPtr_AdvanceDialogueTextCursor ; $5b37
	script_speak $03 ; $5b3a
	script_speak $03 ; $5b3f
	script_set_anim $00, $03 ; $5b44
	script_wait_idle $00 ; $5b4b
	script_face $00, $40 ; $5b50
	script_wait_frames $05 ; $5b57
	ld a, $03 ; $5b5e
	farcall FarPtr_GetActorStateAddr ; $5b60
	ld c, l ; $5b63
	ld b, h ; $5b64
	ld de, $d000 ; $5b65
	farcall FarPtr_04_20 ; $5b68
	ld a, $03 ; $5b6b
	farcall FarPtr_GetActorStateAddr ; $5b6d
	ld c, l ; $5b70
	ld b, h ; $5b71
	ld hl, $0005 ; $5b72
	add hl, bc ; $5b75
	set 4, [hl] ; $5b76
	ret ; $5b78
Label_13_5b79:
	script_speak $03 ; $5b79
	script_set_anim $00, $03 ; $5b7e
	script_wait_idle $00 ; $5b85
	ret ; $5b8a
Func_13_5b8b:
	call Func_13_5aca ; $5b8b
	cp a, $01 ; $5b8e
	jp nz, Label_13_5ba6 ; $5b90
	test_flag $1c, 0 ; $5b93
	jr z, Label_13_5ba0 ; $5b96
	script_set_text $0513 ; $5b98
	jr Label_13_5ba6 ; $5b9e
Label_13_5ba0:
	script_set_text $050e ; $5ba0
Label_13_5ba6:
	ret ; $5ba6
Func_13_5ba7:
	call Func_13_5aca ; $5ba7
	cp a, $01 ; $5baa
	jp nz, Label_13_5bc2 ; $5bac
	test_flag $1c, 0 ; $5baf
	jr z, Label_13_5bbc ; $5bb2
	script_set_text $0514 ; $5bb4
	jr Label_13_5bc2 ; $5bba
Label_13_5bbc:
	script_set_text $050f ; $5bbc
Label_13_5bc2:
	ret ; $5bc2
Func_13_5bc3:
	call Func_13_5aca ; $5bc3
	cp a, $01 ; $5bc6
	jp nz, Label_13_5bde ; $5bc8
	test_flag $1c, 0 ; $5bcb
	jr z, Label_13_5bd8 ; $5bce
	script_set_text $0514 ; $5bd0
	jr Label_13_5bde ; $5bd6
Label_13_5bd8:
	script_set_text $050f ; $5bd8
Label_13_5bde:
	ret ; $5bde
Func_13_5bdf:
	call Func_13_5aca ; $5bdf
	cp a, $01 ; $5be2
	jp nz, Label_13_5bfa ; $5be4
	test_flag $1c, 0 ; $5be7
	jr z, Label_13_5bf4 ; $5bea
	script_set_text $0515 ; $5bec
	jr Label_13_5bfa ; $5bf2
Label_13_5bf4:
	script_set_text $0510 ; $5bf4
Label_13_5bfa:
	ret ; $5bfa
Func_13_5bfb:
	farcall FarPtr_GetActorStateAddr ; $5bfb
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
	ld hl, $c2b8 ; $5c0d
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
	ld hl, wWaterSpriteMinigameFlag ; $5c20
	ld a, e ; $5c23
	ld [hl+], a ; $5c24
	ld [hl], d ; $5c25
	ret ; $5c26
Func_13_5c27:
	ld hl, $c2b8 ; $5c27
	ld a, [hl+] ; $5c2a
	ld b, [hl] ; $5c2b
	ld c, a ; $5c2c
	ld hl, wWaterSpriteMinigameFlag ; $5c2d
	ld a, [hl+] ; $5c30
	ld d, [hl] ; $5c31
	ld e, a ; $5c32
	ld a, $05 ; $5c33
	farcall FarPtr_ScriptSetActorPosition ; $5c35
	ret ; $5c38
Func_13_5c39:
	ld a, $00 ; $5c39
	farcall FarPtr_GetActorStateAddr ; $5c3b
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
	ld hl, $c2b8 ; $5c4d
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
	ld hl, wWaterSpriteMinigameFlag ; $5c60
	ld a, e ; $5c63
	ld [hl+], a ; $5c64
	ld [hl], d ; $5c65
	ld hl, $c2b8 ; $5c66
	ld a, [hl+] ; $5c69
	ld b, [hl] ; $5c6a
	ld c, a ; $5c6b
	ld hl, wWaterSpriteMinigameFlag ; $5c6c
	ld a, [hl+] ; $5c6f
	ld d, [hl] ; $5c70
	ld e, a ; $5c71
	ld a, $03 ; $5c72
	farcall FarPtr_ScriptSetActorPosition ; $5c74
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
	; $5c86, 442 bytes (map_actors)
	map_actor $0000, ActorObjDef_13_7b25, $0d00, $1d00, $40, $4b, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0500, $1d00, $00, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $2300, $c0, $65, $06, $03
	map_actor $0000, ActorObjDef_13_7b25, $0800, $1300, $c0, $67, $01, $06
	map_actor $0000, ActorObjDef_13_7b2f, $0f00, $1700, $40, $6b, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $10c0, $1a60, $80, $36, $01, $00
	map_actor_end
	map_actor $0000, ActorObjDef_13_7b25, $0d00, $1d00, $40, $4b, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0500, $1d00, $00, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $2300, $c0, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b25, $0800, $1300, $c0, $67, $01, $04
	map_actor $0000, ActorObjDef_13_7b2f, $0f00, $1700, $40, $6b, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $2d00, $3d00, $40, $49, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $10c0, $1a60, $80, $36, $01, $00
	map_actor_end
	map_actor $0000, ActorObjDef_13_7b25, $0d00, $1d00, $40, $4b, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0500, $2300, $c0, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $2500, $c0, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b25, $1000, $2500, $80, $67, $01, $04
	map_actor $0000, ActorObjDef_13_7b25, $0800, $1300, $c0, $6b, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $2d00, $3d00, $40, $49, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0500, $2100, $40, $4a, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $10c0, $1a60, $80, $36, $01, $00
	map_actor_end
	map_actor $0000, ActorObjDef_13_7a40, $1000, $1500, $40, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $2500, $c0, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b25, $10c0, $1a60, $80, $36, $01, $00
	map_actor_end
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $1d00, $40, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7a40, $0d00, $2300, $c0, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b2f, $0900, $1500, $40, $4a, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $10c0, $1a60, $80, $36, $01, $00
	map_actor_end
CourtyardEntryPoints_13:
	; $5e40, 57 bytes (map_entries)
	map_entry $01, $40, $3600, $1600, $0000
	map_entry $02, $40, $2200, $0b00, $0000
	map_entry $03, $c0, $2200, $3100, $0000
	map_entry $0a, $c0, $1100, $1d00, $0000
	map_entry $0d, $c0, $0d00, $1f00, $0000
	map_entry $0e, $c0, $0f00, $1f00, $0000
	map_entry $0f, $c0, $2200, $2f00, $0000
	db $ff
CourtyardExitTriggers_13:
	; $5e79, 49 bytes (map_scripts)
	map_script $01, $ff, $0000, $0000, $11, $01
	map_script $02, $ff, $0000, $0000, $08, $04
	map_script $03, $ff, $0000, $0000, $05, $02
	map_script $0a, $ff, $0000, Func_13_7b4d, $00, $0a
	map_script $0e, $ff, $0000, $0000, $07, $0e
	map_script $0f, $ff, $0000, $0000, $08, $0f
	db $ff
Func_13_5eaa:
	script_set_text $020f ; $5eaa
	test_flag $05, 7 ; $5eb0
	jr z, Label_13_5ebb ; $5eb3
	script_set_text $0211 ; $5eb5
Label_13_5ebb:
	ld a, $03 ; $5ebb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5ebd
	farcall FarPtr_RunDialogueYesNoPrompt ; $5ec0
	farcall FarPtr_ScriptCloseDialogueWindow ; $5ec3
	script_wait_frames $05 ; $5ec6
	and a, a ; $5ecd
	jr nz, Label_13_5ed6 ; $5ece
	script_set_text $0213 ; $5ed0
Label_13_5ed6:
	script_speak $03 ; $5ed6
	ret ; $5edb
CourtyardNpcScripts_13:
	; $5edc, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_13_5eaa, $03, $00
	map_script $04, $ff, $05e0, $0214, $03, $00
	map_script $05, $ff, $05e0, $0215, $1b, $00
	map_script $04, $ff, $0000, $0218, $03, $00
	map_script $05, $ff, $0000, $0219, $1b, $00
	map_script $06, $ff, $0000, $0216, $03, $00
	map_script $07, $ff, $0000, $0217, $13, $00
	db $ff
Func_13_5f15:
	ld a, $05 ; $5f15
	farcall FarPtr_SetActorNullScript ; $5f17
	script_set_anim $05, $01 ; $5f1a
	script_set_text $021b ; $5f21
	ld a, $05 ; $5f27
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f29
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f2c
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f2f
	script_wait_frames $05 ; $5f32
	and a, a ; $5f39
	jr z, Label_13_5f4d ; $5f3a
	script_speak $05 ; $5f3c
	script_set_actor_script $05, ActorObjDef_13_7a40 ; $5f41
	ret ; $5f4c
Label_13_5f4d:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f4d
	script_speak $05 ; $5f50
	ld hl, wStoryModePlayersXPosition ; $5f55
	ld de, wStoryModeSpawnPosition ; $5f58
	ld bc, $0005 ; $5f5b
	call CopyMemoryBC ; $5f5e
	ld a, $ff ; $5f61
	ld [wStoryModeEntryPoint], a ; $5f63
	ld [$c294], a ; $5f66
	ld [wStoryModeExitLocationRequest], a ; $5f69
	call SetupStoryMinigameMatch0 ; $5f6c
	ret ; $5f6f
VarsityCourtNpcScriptsA_13:
	; $5f70, 49 bytes (map_scripts)
	map_script $03, $40, $0000, Func_13_6c13, $03, $00
	map_script $03, $ff, $0000, Func_13_6c40, $03, $00
	map_script $04, $ff, $0000, $021a, $03, $00
	map_script $05, $ff, $0000, Func_13_5f15, $03, $00
	map_script $06, $ff, $0000, $021e, $13, $00
	map_script $07, $ff, $0000, $021f, $13, $00
	db $ff
Func_13_5fa1:
	script_set_text $0403 ; $5fa1
	ld a, $09 ; $5fa7
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5fa9
	farcall FarPtr_RunDialogueYesNoPrompt ; $5fac
	farcall FarPtr_ScriptCloseDialogueWindow ; $5faf
	script_wait_frames $05 ; $5fb2
	and a, a ; $5fb9
	jr z, Label_13_5fbf ; $5fba
	farcall FarPtr_AdvanceDialogueTextCursor ; $5fbc
Label_13_5fbf:
	script_speak $09 ; $5fbf
	ret ; $5fc4
Func_13_5fc5:
	ld a, $05 ; $5fc5
	farcall FarPtr_SetActorNullScript ; $5fc7
	script_set_anim $05, $01 ; $5fca
	script_set_text $0407 ; $5fd1
	ld a, $05 ; $5fd7
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5fd9
	farcall FarPtr_RunDialogueYesNoPrompt ; $5fdc
	farcall FarPtr_ScriptCloseDialogueWindow ; $5fdf
	script_wait_frames $05 ; $5fe2
	and a, a ; $5fe9
	jr z, Label_13_5ffd ; $5fea
	script_speak $05 ; $5fec
	script_set_actor_script $05, ActorObjDef_13_7a40 ; $5ff1
	ret ; $5ffc
Label_13_5ffd:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5ffd
	script_speak $05 ; $6000
	ld hl, wStoryModePlayersXPosition ; $6005
	ld de, wStoryModeSpawnPosition ; $6008
	ld bc, $0005 ; $600b
	call CopyMemoryBC ; $600e
	ld a, $ff ; $6011
	ld [wStoryModeEntryPoint], a ; $6013
	ld [$c294], a ; $6016
	ld [wStoryModeExitLocationRequest], a ; $6019
	call Func_13_6a89 ; $601c
	ret ; $601f
VarsityCourtNpcScriptsB_13:
	; $6020, 57 bytes (map_scripts)
	map_script $03, $40, $0000, Func_13_6e20, $03, $00
	map_script $03, $ff, $0000, Func_13_6e4d, $03, $00
	map_script $04, $ff, $0000, $0406, $03, $00
	map_script $05, $ff, $0000, Func_13_5fc5, $03, $00
	map_script $06, $ff, $0000, $040a, $03, $00
	map_script $07, $ff, $0000, $040b, $13, $00
	map_script $09, $ff, $0000, Func_13_5fa1, $03, $00
	db $ff
Func_13_6059:
	ld a, $03 ; $6059
	farcall FarPtr_SetActorNullScript ; $605b
	script_set_anim $03, $01 ; $605e
	script_set_text $0422 ; $6065
	script_speak $03 ; $606b
	script_set_actor_script $03, ActorObjDef_13_7a40 ; $6070
	ret ; $607b
Func_13_607c:
	ld a, $03 ; $607c
	farcall FarPtr_SetActorNullScript ; $607e
	script_set_anim $04, $01 ; $6081
	script_set_text $0423 ; $6088
	script_speak $04 ; $608e
	script_set_actor_script $04, ActorObjDef_13_7a40 ; $6093
	ret ; $609e
VarsityCourtNpcScriptsC_13:
	; $609f, 25 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_13_6059, $03, $00
	map_script $04, $ff, $0000, Func_13_607c, $03, $00
	map_script $05, $ff, $0000, Func_13_60b8, $13, $00
	db $ff
Func_13_60b8:
	script_set_text $0424 ; $60b8
	test_flag $07, 6 ; $60be
	jr z, Label_13_60c6 ; $60c1
	farcall FarPtr_AdvanceDialogueTextCursor ; $60c3
Label_13_60c6:
	script_speak $05 ; $60c6
	ret ; $60cb
Func_13_60cc:
	ld a, $05 ; $60cc
	farcall FarPtr_SetActorNullScript ; $60ce
	script_set_anim $05, $01 ; $60d1
	script_set_text $0428 ; $60d8
	script_speak $05 ; $60de
	script_set_actor_script $05, ActorObjDef_13_7a40 ; $60e3
	ret ; $60ee
VarsityCourtNpcScriptsD_13:
	; $60ef, 41 bytes (map_scripts)
	map_script $03, $ff, $0000, $0426, $03, $00
	map_script $04, $ff, $0000, $0427, $03, $00
	map_script $05, $ff, $0000, Func_13_60cc, $03, $00
	map_script $06, $ff, $0000, $0429, $03, $00
	map_script $07, $ff, $0000, $042a, $13, $00
	db $ff
Func_13_6118:
	ld a, $05 ; $6118
	farcall FarPtr_SetActorNullScript ; $611a
	script_set_anim $05, $01 ; $611d
	script_set_text $042d ; $6124
	script_speak $05 ; $612a
	script_set_actor_script $05, ActorObjDef_13_7a40 ; $612f
	ret ; $613a
VarsityCourtNpcScriptsE_13:
	; $613b, 41 bytes (map_scripts)
	map_script $03, $ff, $0000, $042b, $03, $00
	map_script $04, $ff, $0000, $042c, $03, $00
	map_script $05, $ff, $0000, Func_13_6118, $03, $00
	map_script $06, $ff, $0000, $042e, $13, $00
	map_script $07, $ff, $0000, $042f, $13, $00
	db $ff
CourtyardFacingScripts_13:
	; $6164, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_13_616d, $00, $00
	db $ff
Func_13_616d:
	call Func_13_7ae0 ; $616d
	ld hl, wStoryModePlayersXPosition ; $6170
	ld de, wStoryModeSpawnPosition ; $6173
	ld bc, $0005 ; $6176
	call CopyMemoryBC ; $6179
	ld a, $ff ; $617c
	ld [wStoryModeEntryPoint], a ; $617e
	ld [$c294], a ; $6181
	ld [wStoryModeExitLocationRequest], a ; $6184
	ret ; $6187
CourtyardTileTriggers_13:
	ds 1, $ff ; $6188, fill
CourtyardInitScript_13:
	call SetupVarsityCourtSceneVariant ; $6189
	ld a, [wStoryModeEntryPoint] ; $618c
	cp a, $0f ; $618f
	jr nz, Label_13_6196 ; $6191
	jp VarsityCourtTourCutscene ; $6193
Label_13_6196:
	cp a, $0d ; $6196
	jr nz, Label_13_619e ; $6198
	call Func_13_7995 ; $619a
	ret ; $619d
Label_13_619e:
	cp a, $0e ; $619e
	jr nz, Label_13_61a5 ; $61a0
	jp Label_13_7988 ; $61a2
Label_13_61a5:
	call Func_13_62ff ; $61a5
	ret ; $61a8
SetupVarsityCourtSceneVariant:
	test_flag $05, 7 ; $61a9
	jr nz, Label_13_6222 ; $61ac
	test_flag $16, 0 ; $61ae
	jr z, Label_13_61e1 ; $61b1
	ld hl, VarsityCourtNpcScriptsD_13 ; $61b3
	ld de, $000c ; $61b6
	farcall FarPtr_WriteStoryStateWord ; $61b9
	ld a, $18 ; $61bc
	ld d, $08 ; $61be
	ld e, $10 ; $61c0
	farcall FarPtr_WriteBehaviorMapCell ; $61c2
	ld a, $18 ; $61c5
	ld d, $06 ; $61c7
	ld e, $10 ; $61c9
	farcall FarPtr_WriteBehaviorMapCell ; $61cb
	script_set_position $06, $0500, $1500 ; $61ce
	script_face $06, $00 ; $61d9
	ret ; $61e0
Label_13_61e1:
	test_flag $15, 6 ; $61e1
	jr z, Label_13_620a ; $61e4
	ldh a, [hRomBank] ; $61e6
	ld hl, $5dca ; $61e8
	farcall FarPtr_ScriptRespawnLocationActors ; $61eb
	ld hl, VarsityCourtNpcScriptsC_13 ; $61ee
	ld de, $000c ; $61f1
	farcall FarPtr_WriteStoryStateWord ; $61f4
	ld a, $18 ; $61f7
	ld d, $08 ; $61f9
	ld e, $10 ; $61fb
	farcall FarPtr_WriteBehaviorMapCell ; $61fd
	ld a, $18 ; $6200
	ld d, $06 ; $6202
	ld e, $10 ; $6204
	farcall FarPtr_WriteBehaviorMapCell ; $6206
	ret ; $6209
Label_13_620a:
	test_flag $0a, 7 ; $620a
	jp z, Label_13_62bd ; $620d
	ldh a, [hRomBank] ; $6210
	ld hl, $5ce4 ; $6212
	farcall FarPtr_ScriptRespawnLocationActors ; $6215
	ld hl, VarsityCourtNpcScriptsA_13 ; $6218
	ld de, $000c ; $621b
	farcall FarPtr_WriteStoryStateWord ; $621e
	ret ; $6221
Label_13_6222:
	test_flag $16, 1 ; $6222
	jr z, Label_13_627e ; $6225
	ldh a, [hRomBank] ; $6227
	ld hl, $5d50 ; $6229
	farcall FarPtr_ScriptRespawnLocationActors ; $622c
	ld hl, VarsityCourtNpcScriptsE_13 ; $622f
	ld de, $000c ; $6232
	farcall FarPtr_WriteStoryStateWord ; $6235
	script_set_position $09, $3f00, $3f00 ; $6238
	script_face $04, $00 ; $6243
	script_set_actor_script $06, $7cf5 ; $624a
	ld a, $18 ; $6255
	ld d, $08 ; $6257
	ld e, $10 ; $6259
	farcall FarPtr_WriteBehaviorMapCell ; $625b
	ld a, $18 ; $625e
	ld d, $06 ; $6260
	ld e, $10 ; $6262
	farcall FarPtr_WriteBehaviorMapCell ; $6264
	script_set_position $07, $0f00, $1700 ; $6267
	script_set_actor_script $07, ActorObjDef_13_7b2f ; $6272
	ret ; $627d
Label_13_627e:
	test_flag $15, 7 ; $627e
	jr z, Label_13_62a7 ; $6281
	ldh a, [hRomBank] ; $6283
	ld hl, $5dfe ; $6285
	farcall FarPtr_ScriptRespawnLocationActors ; $6288
	ld hl, VarsityCourtNpcScriptsC_13 ; $628b
	ld de, $000c ; $628e
	farcall FarPtr_WriteStoryStateWord ; $6291
	ld a, $18 ; $6294
	ld d, $08 ; $6296
	ld e, $10 ; $6298
	farcall FarPtr_WriteBehaviorMapCell ; $629a
	ld a, $18 ; $629d
	ld d, $06 ; $629f
	ld e, $10 ; $62a1
	farcall FarPtr_WriteBehaviorMapCell ; $62a3
	ret ; $62a6
Label_13_62a7:
	test_flag $08, 6 ; $62a7
	jr z, Label_13_62bd ; $62aa
	ldh a, [hRomBank] ; $62ac
	ld hl, $5d50 ; $62ae
	farcall FarPtr_ScriptRespawnLocationActors ; $62b1
	ld hl, VarsityCourtNpcScriptsB_13 ; $62b4
	ld de, $000c ; $62b7
	farcall FarPtr_WriteStoryStateWord ; $62ba
Label_13_62bd:
	ret ; $62bd
Func_13_62be:
	ld a, [$c94d] ; $62be
	or a, a ; $62c1
	jr nz, Label_13_62da ; $62c2
	script_set_objdef $28, $0d ; $62c4
	script_set_anim $0d, $01 ; $62d0
	set_flag $1c, 0 ; $62d7
Label_13_62da:
	ret ; $62da
	INCBIN "data/bank_013/d_62db.bin" ; $62db, 36 bytes
Func_13_62ff:
	ld a, [wStoryModeEntryPoint] ; $62ff
	cp a, $ff ; $6302
	jp z, Label_13_6365 ; $6304
	test_flag $05, 7 ; $6307
	jr z, Label_13_6348 ; $630a
	script_set_speed $02, $00ff ; $630c
	ld a, [wStoryModeEntryPoint] ; $6314
	dec a ; $6317
	add a, $69 ; $6318
	ld l, a ; $631a
	adc a, $63 ; $631b
	sub a, l ; $631d
	ld h, a ; $631e
	ld b, [hl] ; $631f
	ld a, $02 ; $6320
	ld b, b ; $6322
	ld de, $0200 ; $6323
	farcall FarPtr_MoveActorByAngle ; $6326
	script_wait_move $02 ; $6329
	ld a, [wStoryModeEntryPoint] ; $632e
	dec a ; $6331
	add a, $66 ; $6332
	ld l, a ; $6334
	adc a, $63 ; $6335
	sub a, l ; $6337
	ld h, a ; $6338
	ld b, [hl] ; $6339
	ld a, $02 ; $633a
	ld b, b ; $633c
	farcall FarPtr_SetActorFacing ; $633d
	script_set_speed $02, $0010 ; $6340
Label_13_6348:
	script_set_speed $00, $0010 ; $6348
	ld a, [wStoryModeEntryPoint] ; $6350
	dec a ; $6353
	add a, $66 ; $6354
	ld l, a ; $6356
	adc a, $63 ; $6357
	sub a, l ; $6359
	ld h, a ; $635a
	ld b, [hl] ; $635b
	ld a, $00 ; $635c
	ld b, b ; $635e
	ld de, $0200 ; $635f
	farcall FarPtr_MoveActorByAngle ; $6362
Label_13_6365:
	ret ; $6365
	INCBIN "data/bank_013/d_6366.bin" ; $6366, 6 bytes
VarsityCourtTourCutscene:
	ldh a, [hRomBank] ; $636c
	ld hl, $6638 ; $636e
	farcall FarPtr_ScriptRespawnLocationActors ; $6371
	farcall FarPtr_BeginCutsceneScriptMode ; $6374
	script_set_position $00, $3f00, $3f00 ; $6377
	script_set_position $06, $3f00, $3f00 ; $6382
	script_fade_in $04 ; $638d
	call WaitFadeEnd ; $6392
	script_set_position $06, $2200, $3300 ; $6395
	script_move_target $06, $2200, $1d00 ; $63a0
	script_wait_frames $0f ; $63ab
	script_move_player $2200, $1d00 ; $63b2
	script_set_position $00, $2200, $3300 ; $63bc
	script_move_target $00, $2200, $2100 ; $63c7
	script_wait_move $00 ; $63d2
	script_wait_frames $0f ; $63d7
	script_move_target $00, $2000, $1f00 ; $63de
	script_wait_move $00 ; $63e9
	script_wait_frames $1e ; $63ee
	script_face $06, $80 ; $63f5
	script_wait_frames $1e ; $63fc
	script_face $00, $80 ; $6403
	script_wait_frames $1e ; $640a
	script_move_player $0c00, $1b00 ; $6411
	farcall FarPtr_WaitPlayerMoveDone ; $641b
	script_wait_frames $1e ; $641e
	script_set_text $0206 ; $6425
	script_speak $06 ; $642b
	script_wait_frames $0f ; $6430
	script_player_speed $0040 ; $6437
	script_move_player $2200, $1d00 ; $643d
	farcall FarPtr_WaitPlayerMoveDone ; $6447
	script_player_speed $0020 ; $644a
	script_set_position $04, $2100, $1d00 ; $6450
	sound $98 ; $645b
	script_wait_frames $32 ; $645d
	script_set_position $04, $3f00, $3f00 ; $6464
	script_set_anim $06, $02 ; $646f
	script_wait_idle $06 ; $6476
	script_speak $06 ; $647b
	script_wait_frames $1e ; $6480
	script_face $06, $40 ; $6487
	script_wait_frames $0f ; $648e
	script_speak $06 ; $6495
	script_face $06, $80 ; $649a
	script_wait_frames $0f ; $64a1
	script_player_speed $0040 ; $64a8
	script_move_player $0c00, $1600 ; $64ae
	farcall FarPtr_WaitPlayerMoveDone ; $64b8
	script_player_speed $0020 ; $64bb
	script_wait_frames $3c ; $64c1
	script_move_player $0c00, $2200 ; $64c8
	farcall FarPtr_WaitPlayerMoveDone ; $64d2
	script_wait_frames $3c ; $64d5
	script_move_player $0c00, $1b00 ; $64dc
	farcall FarPtr_WaitPlayerMoveDone ; $64e6
	script_speak $06 ; $64e9
	script_wait_frames $0f ; $64ee
	script_player_speed $0040 ; $64f5
	script_move_player $2200, $1d00 ; $64fb
	farcall FarPtr_WaitPlayerMoveDone ; $6505
	script_player_speed $0020 ; $6508
	script_wait_frames $1e ; $650e
	script_face $06, $00 ; $6515
	script_wait_frames $0f ; $651c
	script_face $00, $00 ; $6523
	script_move_player $3000, $2600 ; $652a
	farcall FarPtr_WaitPlayerMoveDone ; $6534
	script_speak $06 ; $6537
	script_wait_frames $0f ; $653c
	script_move_player $3600, $1000 ; $6543
	farcall FarPtr_WaitPlayerMoveDone ; $654d
	script_speak $06 ; $6550
	script_wait_frames $0f ; $6555
	script_player_speed $0040 ; $655c
	script_move_player $2200, $1d00 ; $6562
	farcall FarPtr_WaitPlayerMoveDone ; $656c
	script_player_speed $0020 ; $656f
	script_wait_frames $0f ; $6575
	script_face $06, $40 ; $657c
	script_speak $06 ; $6583
	script_wait_frames $1e ; $6588
	script_face $00, $c0 ; $658f
	script_set_anim $00, $03 ; $6596
	script_wait_idle $00 ; $659d
	script_wait_frames $0f ; $65a2
	script_set_anim $06, $02 ; $65a9
	script_wait_idle $06 ; $65b0
	script_speak $06 ; $65b5
	script_set_anim $00, $02 ; $65ba
	script_wait_idle $00 ; $65c1
	script_wait_frames $1e ; $65c6
	script_set_anim $06, $03 ; $65cd
	script_wait_idle $06 ; $65d4
	script_speak $06 ; $65d9
	script_move_target $00, $2200, $1f00 ; $65de
	script_wait_move $00 ; $65e9
	script_face $00, $c0 ; $65ee
	script_wait_frames $0f ; $65f5
	script_move_target $06, $2200, $0700 ; $65fc
	script_wait_frames $05 ; $6607
	script_move_target $00, $2200, $0700 ; $660e
	script_wait_frames $0a ; $6619
	script_move_player $2200, $0d00 ; $6620
	script_wait_move $00 ; $662a
	ld a, $0f ; $662f
	ld [$c294], a ; $6631
	ld [wStoryModeExitLocationRequest], a ; $6634
	ret ; $6637
	INCBIN "data/bank_013/d_6638.bin" ; $6638, 984 bytes
SetupStoryMinigameMatch0:
	ld a, $05 ; $6a10
	farcall FarPtr_SetActorNullScript ; $6a12
	script_set_anim $05, $01 ; $6a15
	ld a, $07 ; $6a1c
	farcall FarPtr_SetActorNullScript ; $6a1e
	script_set_speed $07, $0018 ; $6a21
	script_set_actor_script $03, $6b19 ; $6a29
	script_set_actor_script $06, $6b31 ; $6a34
	script_set_actor_script $07, $6b47 ; $6a3f
	script_set_actor_script $05, $6b69 ; $6a4a
	script_move_player $0c00, $1c00 ; $6a55
	farcall FarPtr_WaitPlayerMoveDone ; $6a5f
	script_set_actor_script $00, $6be7 ; $6a62
	ld a, $05 ; $6a6d
	farcall FarPtr_WaitActorScriptDone ; $6a6f
	farcall FarPtr_InitStoryMatchSettings ; $6a72
	load_match_settings $000a ; $6a75
	farcall FarPtr_RunStoryMatch ; $6a82
	farcall FarPtr_RestoreOverworldAfterMatch ; $6a85
	ret ; $6a88
Func_13_6a89:
	ld a, $05 ; $6a89
	farcall FarPtr_SetActorNullScript ; $6a8b
	ld a, $07 ; $6a8e
	farcall FarPtr_SetActorNullScript ; $6a90
	script_set_speed $07, $0018 ; $6a93
	script_set_anim $05, $01 ; $6a9b
	script_set_anim $05, $03 ; $6aa2
	script_wait_idle $05 ; $6aa9
	script_set_actor_script $05, $6b69 ; $6aae
	script_set_actor_script $06, $6b80 ; $6ab9
	script_set_actor_script $07, $6b47 ; $6ac4
	script_set_actor_script $00, $6be7 ; $6acf
	script_set_actor_script $02, $6bdc ; $6ada
	script_set_actor_script $03, $6b19 ; $6ae5
	script_move_player $0c00, $1c00 ; $6af0
	farcall FarPtr_WaitPlayerMoveDone ; $6afa
	ld a, $05 ; $6afd
	farcall FarPtr_WaitActorScriptDone ; $6aff
	farcall FarPtr_InitStoryMatchSettings ; $6b02
	load_match_settings $010a ; $6b05
	farcall FarPtr_RunStoryMatch ; $6b12
	farcall FarPtr_RestoreOverworldAfterMatch ; $6b15
	ret ; $6b18
	INCBIN "data/bank_013/d_6b19.bin" ; $6b19, 250 bytes
Func_13_6c13:
	script_set_speed $00, $0008 ; $6c13
	script_facing_lock $00, $01 ; $6c1b
	script_move_target $00, $0d00, $1f00 ; $6c22
	script_wait_move $00 ; $6c2d
	script_facing_lock $00, $00 ; $6c32
	script_face $00, $c0 ; $6c39
Func_13_6c40:
	script_set_text $0220 ; $6c40
	ld a, $03 ; $6c46
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c48
	farcall FarPtr_RunDialogueYesNoPrompt ; $6c4b
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c4e
	script_wait_frames $05 ; $6c51
	and a, a ; $6c58
	jp nz, Label_13_6df5 ; $6c59
	farcall FarPtr_AdvanceDialogueTextCursor ; $6c5c
	script_set_speed $00, $0010 ; $6c5f
	script_move_target $00, $0d00, $1f00 ; $6c67
	script_wait_move $00 ; $6c72
	script_face_toward $03, $00 ; $6c77
	script_wait_frames $1e ; $6c7f
	script_face_toward $00, $03 ; $6c86
	script_speak $03 ; $6c8e
	script_set_speed $00, $0020 ; $6c93
	script_wait_frames $0f ; $6c9b
	script_face_toward $04, $03 ; $6ca2
	script_wait_frames $1e ; $6caa
	script_face_toward $04, $00 ; $6cb1
	script_wait_frames $1e ; $6cb9
	script_player_speed $0020 ; $6cc0
	script_move_player_to_actor $04 ; $6cc6
	farcall FarPtr_WaitPlayerMoveDone ; $6ccd
	script_set_anim $04, $03 ; $6cd0
	script_wait_idle $04 ; $6cd7
	script_move_target $04, $0b00, $1f00 ; $6cdc
	script_move_player_to_actor $00 ; $6ce7
	script_wait_move $04 ; $6cee
	script_face $03, $40 ; $6cf3
	script_wait_frames $0f ; $6cfa
	script_face $04, $c0 ; $6d01
	script_face $00, $c0 ; $6d08
	script_wait_frames $0f ; $6d0f
	script_set_anim $03, $02 ; $6d16
	script_wait_idle $03 ; $6d1d
	ld a, $03 ; $6d22
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d24
	farcall FarPtr_RunDialogueYesNoPrompt ; $6d27
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d2a
	script_wait_frames $05 ; $6d2d
	and a, a ; $6d34
	jp nz, Label_13_6dfb ; $6d35
	script_set_anim $03, $03 ; $6d38
	script_wait_idle $03 ; $6d3f
Label_13_6d44:
	script_set_text $0224 ; $6d44
	script_set_anim $03, $03 ; $6d4a
	script_wait_idle $03 ; $6d51
	script_speak $03 ; $6d56
	ld a, $07 ; $6d5b
	ld [wStoryModeCurrentLocation], a ; $6d5d
	ld a, $0d ; $6d60
	ld [wStoryModeEntryPoint], a ; $6d62
	ld a, $ff ; $6d65
	ld [$c294], a ; $6d67
	ld [wStoryModeExitLocationRequest], a ; $6d6a
	ld a, $07 ; $6d6d
	farcall FarPtr_SetActorNullScript ; $6d6f
	script_set_speed $00, $0020 ; $6d72
	script_set_speed $02, $0020 ; $6d7a
	script_set_speed $07, $0018 ; $6d82
	script_set_actor_script $04, $6b97 ; $6d8a
	script_set_actor_script $00, $6be7 ; $6d95
	script_set_actor_script $07, $6b47 ; $6da0
	script_set_actor_script $03, $6b19 ; $6dab
	script_set_actor_script $05, $6b24 ; $6db6
	script_set_actor_script $06, $6b31 ; $6dc1
	script_move_player $0c00, $1b00 ; $6dcc
	farcall FarPtr_WaitPlayerMoveDone ; $6dd6
	ld a, $04 ; $6dd9
	farcall FarPtr_WaitActorScriptDone ; $6ddb
	farcall FarPtr_InitStoryMatchSettings ; $6dde
	load_match_settings $000b ; $6de1
	farcall FarPtr_RunStoryMatch ; $6dee
	farcall FarPtr_RestoreOverworldAfterMatch ; $6df1
	ret ; $6df4
Label_13_6df5:
	script_speak $03 ; $6df5
	ret ; $6dfa
Label_13_6dfb:
	farcall FarPtr_AdvanceDialogueTextCursor ; $6dfb
	ld a, $03 ; $6dfe
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e00
	farcall FarPtr_RunDialogueYesNoPrompt ; $6e03
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e06
	script_wait_frames $05 ; $6e09
	and a, a ; $6e10
	jr z, Label_13_6e17 ; $6e11
	jp Label_13_6d44 ; $6e13
	ret ; $6e16
Label_13_6e17:
	script_speak $03 ; $6e17
	call Func_13_70c9 ; $6e1c
	ret ; $6e1f
Func_13_6e20:
	script_set_speed $00, $0008 ; $6e20
	script_facing_lock $00, $01 ; $6e28
	script_move_target $00, $0d00, $1f00 ; $6e2f
	script_wait_move $00 ; $6e3a
	script_facing_lock $00, $00 ; $6e3f
	script_face $00, $c0 ; $6e46
Func_13_6e4d:
	ld a, $02 ; $6e4d
	farcall FarPtr_SetActorNullScript ; $6e4f
	script_set_text $040c ; $6e52
	ld a, $03 ; $6e58
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e5a
	farcall FarPtr_RunDialogueYesNoPrompt ; $6e5d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e60
	script_wait_frames $05 ; $6e63
	and a, a ; $6e6a
	jp nz, Label_13_707d ; $6e6b
	farcall FarPtr_AdvanceDialogueTextCursor ; $6e6e
	script_set_speed $00, $0010 ; $6e71
	script_set_speed $02, $0010 ; $6e79
	script_move_target $02, $0d00, $2100 ; $6e81
	script_move_target $00, $0d00, $1f00 ; $6e8c
	script_wait_move $00 ; $6e97
	script_face_toward $03, $00 ; $6e9c
	script_wait_move $02 ; $6ea4
	script_face_toward $03, $02 ; $6ea9
	script_wait_frames $1e ; $6eb1
	script_set_speed $00, $0020 ; $6eb8
	script_set_speed $02, $0020 ; $6ec0
	script_face_toward $00, $03 ; $6ec8
	script_speak $03 ; $6ed0
	script_wait_frames $0f ; $6ed5
	script_face_toward $04, $03 ; $6edc
	script_wait_frames $1e ; $6ee4
	script_face_toward $09, $00 ; $6eeb
	script_face_toward $04, $02 ; $6ef3
	script_wait_frames $1e ; $6efb
	script_player_speed $0020 ; $6f02
	script_move_player_to_actor $04 ; $6f08
	farcall FarPtr_WaitPlayerMoveDone ; $6f0f
	script_face_toward $00, $04 ; $6f12
	script_face_toward $00, $09 ; $6f1a
	script_set_anim $04, $03 ; $6f22
	script_wait_idle $04 ; $6f29
	script_move_target $04, $0b00, $2100 ; $6f2e
	script_move_target $09, $0b00, $1f00 ; $6f39
	script_move_player_to_actor $00 ; $6f44
	script_wait_frames $0f ; $6f4b
	script_face $03, $40 ; $6f52
	script_wait_frames $0f ; $6f59
	script_wait_move $04 ; $6f60
	script_face $04, $c0 ; $6f65
	script_face $09, $c0 ; $6f6c
	script_face $00, $c0 ; $6f73
	script_face $02, $c0 ; $6f7a
	script_wait_frames $0f ; $6f81
	script_set_anim $03, $02 ; $6f88
	script_wait_idle $03 ; $6f8f
	ld a, $03 ; $6f94
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6f96
	farcall FarPtr_RunDialogueYesNoPrompt ; $6f99
	farcall FarPtr_ScriptCloseDialogueWindow ; $6f9c
	script_wait_frames $05 ; $6f9f
	and a, a ; $6fa6
	jp nz, Label_13_7090 ; $6fa7
	script_set_anim $03, $03 ; $6faa
	script_wait_idle $03 ; $6fb1
Label_13_6fb6:
	script_set_text $0410 ; $6fb6
	script_set_anim $03, $03 ; $6fbc
	script_wait_idle $03 ; $6fc3
	script_speak $03 ; $6fc8
	ld a, $07 ; $6fcd
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [wStoryModeEntryPoint], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [$c294], a ; $6fd9
	ld [wStoryModeExitLocationRequest], a ; $6fdc
	script_set_speed $00, $0020 ; $6fdf
	script_set_speed $02, $0020 ; $6fe7
	script_set_actor_script $04, $6bae ; $6fef
	script_set_actor_script $09, $6bc5 ; $6ffa
	script_set_actor_script $00, $6be7 ; $7005
	script_set_actor_script $02, $6bdc ; $7010
	ld a, $07 ; $701b
	farcall FarPtr_SetActorNullScript ; $701d
	script_set_speed $07, $0018 ; $7020
	script_set_actor_script $03, $6b19 ; $7028
	script_set_actor_script $05, $6b24 ; $7033
	script_set_actor_script $06, $6b3c ; $703e
	script_set_actor_script $07, $6b58 ; $7049
	script_move_player $0c00, $1b00 ; $7054
	farcall FarPtr_WaitPlayerMoveDone ; $705e
	ld a, $04 ; $7061
	farcall FarPtr_WaitActorScriptDone ; $7063
	farcall FarPtr_InitStoryMatchSettings ; $7066
	load_match_settings $010d ; $7069
	farcall FarPtr_RunStoryMatch ; $7076
	farcall FarPtr_RestoreOverworldAfterMatch ; $7079
	ret ; $707c
Label_13_707d:
	script_speak $03 ; $707d
	ld a, $02 ; $7082
	farcall FarPtr_GetActorStateAddr ; $7084
	ld c, l ; $7087
	ld b, h ; $7088
	ld de, $d000 ; $7089
	farcall FarPtr_04_20 ; $708c
	ret ; $708f
Label_13_7090:
	farcall FarPtr_AdvanceDialogueTextCursor ; $7090
	ld a, $03 ; $7093
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7095
	farcall FarPtr_RunDialogueYesNoPrompt ; $7098
	farcall FarPtr_ScriptCloseDialogueWindow ; $709b
	script_wait_frames $05 ; $709e
	and a, a ; $70a5
	jr z, Label_13_70ac ; $70a6
	jp Label_13_6fb6 ; $70a8
	ret ; $70ab
Label_13_70ac:
	script_speak $03 ; $70ac
	call Func_13_70d5 ; $70b1
	script_wait_frames $3c ; $70b4
	ld a, $02 ; $70bb
	farcall FarPtr_GetActorStateAddr ; $70bd
	ld c, l ; $70c0
	ld b, h ; $70c1
	ld de, $d000 ; $70c2
	farcall FarPtr_04_20 ; $70c5
	ret ; $70c8
Func_13_70c9:
	script_set_actor_script $04, $6bf2 ; $70c9
	ret ; $70d4
Func_13_70d5:
	script_set_actor_script $04, $6bfd ; $70d5
	script_set_actor_script $09, $6c08 ; $70e0
	ret ; $70eb
	wram_bank $04 ; $70ec
	ld a, [wMatchWinLoseFlag] ; $70f2
	cp a, $01 ; $70f5
	jp z, SinglesTravelingTeamVictoryCutscene ; $70f7
	ret ; $70fa
SinglesTravelingTeamVictoryCutscene:
	wram_bank $06 ; $70fb
	ldh a, [hRomBank] ; $7101
	ld hl, SinglesTravelingTeamActors_13 ; $7103
	farcall FarPtr_ScriptRespawnLocationActors ; $7106
	ld a, $01 ; $7109
	farcall FarPtr_SetActorNullScript ; $710b
	script_player_speed $0040 ; $710e
	call Func_13_62be ; $7114
	script_set_position $00, $0b00, $1d00 ; $7117
	script_set_position $02, $0d00, $2300 ; $7122
	script_face $00, $c0 ; $712d
	script_face $02, $c0 ; $7134
	script_move_player $0b00, $1100 ; $713b
	farcall FarPtr_WaitPlayerMoveDone ; $7145
	script_fade_in $04 ; $7148
	call WaitFadeEnd ; $714d
	script_wait_frames $3c ; $7150
	script_set_text $022a ; $7157
	script_player_speed $0020 ; $715d
	script_move_player $0b00, $1700 ; $7163
	farcall FarPtr_WaitPlayerMoveDone ; $716d
	script_move_target $04, $0b00, $1700 ; $7170
	script_wait_move $04 ; $717b
	script_speak $04 ; $7180
	script_set_anim $00, $03 ; $7185
	script_wait_idle $00 ; $718c
	script_speak $0d ; $7191
	script_set_position $0c, $0c40, $1bc0 ; $7196
	sound $98 ; $71a1
	script_wait_frames $28 ; $71a3
	script_set_position $0c, $3f00, $3f00 ; $71aa
	script_face $00, $00 ; $71b5
	script_move_player_to_actor $0d ; $71bc
	farcall FarPtr_WaitPlayerMoveDone ; $71c3
	script_wait_frames $28 ; $71c6
	script_move_player_to_actor $00 ; $71cd
	script_set_actor_script $08, $7a43 ; $71d4
	script_set_actor_script $09, $7aa7 ; $71df
	script_set_actor_script $0d, $7aa0 ; $71ea
	script_wait_frames $0a ; $71f5
	script_set_actor_script $03, $7a7d ; $71fc
	farcall FarPtr_WaitPlayerMoveDone ; $7207
	ld a, $03 ; $720a
	farcall FarPtr_WaitActorScriptDone ; $720c
	script_face_toward $00, $0d ; $720f
	test_flag $1c, 0 ; $7217
	jr z, Label_13_724d ; $721a
	farcall FarPtr_AdvanceDialogueTextCursor ; $721c
	script_set_anim $0d, $02 ; $721f
	script_wait_idle $0d ; $7226
	script_speak $0d ; $722b
	script_face_toward $0d, $00 ; $7230
	script_set_anim $0d, $03 ; $7238
	script_set_anim $00, $03 ; $723f
	script_wait_idle $00 ; $7246
	jr Label_13_727c ; $724b
Label_13_724d:
	script_set_anim $0d, $02 ; $724d
	script_wait_idle $0d ; $7254
	script_speak $0d ; $7259
	script_face_toward $0d, $00 ; $725e
	script_set_anim $0d, $03 ; $7266
	script_set_anim $00, $03 ; $726d
	script_wait_idle $00 ; $7274
	farcall FarPtr_AdvanceDialogueTextCursor ; $7279
Label_13_727c:
	script_face $09, $40 ; $727c
	script_set_anim $09, $04 ; $7283
	script_wait_idle $09 ; $728a
	script_face $09, $00 ; $728f
	script_face_toward $09, $00 ; $7296
	script_speak $09 ; $729e
	script_set_anim $00, $02 ; $72a3
	script_wait_idle $00 ; $72aa
	script_wait_frames $14 ; $72af
	script_move_target $08, $0a00, $1f00 ; $72b6
	script_wait_move $08 ; $72c1
	script_wait_frames $14 ; $72c6
	script_face_toward $08, $00 ; $72cd
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
	script_face_toward $00, $0d ; $7330
	test_flag $1c, 0 ; $7338
	jr z, Label_13_7340 ; $733b
	farcall FarPtr_AdvanceDialogueTextCursor ; $733d
Label_13_7340:
	script_speak $0d ; $7340
	script_face_toward $0d, $00 ; $7345
	script_set_anim $00, $03 ; $734d
	script_wait_idle $00 ; $7354
	script_wait_frames $0a ; $7359
	script_face_toward $08, $00 ; $7360
	script_wait_frames $0a ; $7368
	script_set_anim $00, $03 ; $736f
	ld c, $02 ; $7376
	call BeginFadeOut ; $7378
	call WaitFadeEnd ; $737b
	ld b, $00 ; $737e
	ld a, [$c90d] ; $7380
	add a, $04 ; $7383
	ld c, a ; $7385
	farcall FarPtr_18_8e ; $7386
	ld a, $00 ; $7389
	ld [wStoryModeCurrentLocation], a ; $738b
	ld a, $0a ; $738e
	ld [wStoryModeEntryPoint], a ; $7390
	ld a, $ff ; $7393
	ld [$c294], a ; $7395
	ld [wStoryModeExitLocationRequest], a ; $7398
	ret ; $739b
SinglesTravelingTeamActors_13:
	; $739c, 164 bytes (map_actors)
	map_actor $0000, ActorObjDef_13_7b25, $1900, $1f00, $80, $4b, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0b00, $1300, $40, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7b25, $1300, $2100, $80, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b25, $1300, $2300, $80, $67, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $1300, $1700, $80, $6b, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $1b00, $1d00, $80, $49, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $1900, $1d00, $80, $4a, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $53, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $4c, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $4d, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $1700, $1d00, $80, $29, $01, $00
	map_actor_end
RunDoublesTravelingTeamVictoryIfWon_13:
	wram_bank $04 ; $7440
	ld a, [wMatchWinLoseFlag] ; $7446
	cp a, $01 ; $7449
	jp z, DoublesTravelingTeamVictoryCutscene ; $744b
	ret ; $744e
DoublesTravelingTeamVictoryCutscene:
	script_set_text $0416 ; $744f
	ldh a, [hRomBank] ; $7455
	ld hl, DoublesTravelingTeamActors_13 ; $7457
	farcall FarPtr_ScriptRespawnLocationActors ; $745a
	farcall FarPtr_BeginCutsceneScriptMode ; $745d
	call Func_13_62be ; $7460
	ld a, $02 ; $7463
	farcall FarPtr_SetActorNullScript ; $7465
	ld a, $01 ; $7468
	farcall FarPtr_SetActorNullScript ; $746a
	script_player_speed $0040 ; $746d
	script_set_position $00, $0b00, $1d00 ; $7473
	script_set_position $02, $0d00, $2300 ; $747e
	script_face $00, $c0 ; $7489
	script_face $02, $c0 ; $7490
	script_move_player $0b00, $1100 ; $7497
	farcall FarPtr_WaitPlayerMoveDone ; $74a1
	script_fade_in $04 ; $74a4
	call WaitFadeEnd ; $74a9
	script_wait_frames $3c ; $74ac
	script_player_speed $0020 ; $74b3
	script_move_player $0b00, $1700 ; $74b9
	farcall FarPtr_WaitPlayerMoveDone ; $74c3
	script_move_target $02, $0d00, $1d00 ; $74c6
	script_move_target $09, $0b00, $1700 ; $74d1
	script_wait_move $09 ; $74dc
	script_set_anim $09, $04 ; $74e1
	script_wait_idle $09 ; $74e8
	script_speak $09 ; $74ed
	script_set_anim $04, $02 ; $74f2
	script_wait_idle $04 ; $74f9
	script_speak $04 ; $74fe
	script_set_anim $02, $03 ; $7503
	script_set_anim $00, $03 ; $750a
	script_wait_idle $00 ; $7511
	script_face_toward $00, $02 ; $7516
	script_wait_frames $1e ; $751e
	script_set_anim $02, $03 ; $7525
	script_wait_idle $02 ; $752c
	test_flag $1c, 0 ; $7531
	jp z, Label_13_7672 ; $7534
	script_set_text $041a ; $7537
	script_speak $02 ; $753d
	script_face_toward $02, $00 ; $7542
	script_set_anim $02, $02 ; $754a
	script_wait_idle $02 ; $7551
	script_speak $02 ; $7556
	script_face $00, $80 ; $755b
	script_set_anim $00, $02 ; $7562
	script_set_position $0a, $0c00, $1b80 ; $7569
	sound $96 ; $7574
	script_wait_frames $28 ; $7576
	script_set_position $0a, $3f00, $3f00 ; $757d
	script_face_toward $02, $00 ; $7588
	script_wait_frames $0a ; $7590
	script_facing_lock $00, $01 ; $7597
	script_wait_frames $0a ; $759e
	script_move_angle $00, $00, $0100 ; $75a5
	script_wait_move $00 ; $75af
	script_set_anim $00, $02 ; $75b4
	script_wait_idle $00 ; $75bb
	script_move_angle $00, $80, $0100 ; $75c0
	script_wait_move $00 ; $75ca
	ld a, $02 ; $75cf
	farcall FarPtr_GetActorStateAddr ; $75d1
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	ld [hl], $04 ; $75d8
	script_set_anim $02, $02 ; $75da
	script_wait_idle $02 ; $75e1
	script_face $02, $c0 ; $75e6
	script_set_anim $02, $02 ; $75ed
	script_wait_idle $02 ; $75f4
	script_set_anim $02, $02 ; $75f9
	script_wait_idle $02 ; $7600
	script_face $02, $40 ; $7605
	script_set_anim $02, $02 ; $760c
	script_wait_idle $02 ; $7613
	script_face $02, $c0 ; $7618
	script_set_anim $02, $02 ; $761f
	script_wait_idle $02 ; $7626
	script_set_anim $02, $02 ; $762b
	script_wait_idle $02 ; $7632
	ld a, $02 ; $7637
	farcall FarPtr_GetActorStateAddr ; $7639
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	script_face $02, $80 ; $7642
	script_wait_frames $14 ; $7649
	script_set_anim $02, $03 ; $7650
	script_wait_idle $02 ; $7657
	script_wait_frames $14 ; $765c
	script_set_anim $00, $03 ; $7663
	script_wait_idle $00 ; $766a
	jp Label_13_7769 ; $766f
Label_13_7672:
	script_set_text $0418 ; $7672
	script_speak $02 ; $7678
	script_set_anim $02, $02 ; $767d
	script_wait_idle $02 ; $7684
	script_speak $02 ; $7689
	script_face_toward $02, $00 ; $768e
	script_set_position $0a, $0c00, $1b80 ; $7696
	sound $96 ; $76a1
	script_wait_frames $28 ; $76a3
	script_set_position $0a, $3f00, $3f00 ; $76aa
	script_wait_frames $0a ; $76b5
	script_facing_lock $00, $01 ; $76bc
	script_wait_frames $0a ; $76c3
	script_move_angle $00, $00, $0100 ; $76ca
	script_wait_move $00 ; $76d4
	script_set_anim $00, $02 ; $76d9
	script_wait_idle $00 ; $76e0
	script_move_angle $00, $80, $0100 ; $76e5
	script_wait_move $00 ; $76ef
	ld a, $02 ; $76f4
	farcall FarPtr_GetActorStateAddr ; $76f6
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	ld [hl], $03 ; $76fd
	script_set_anim $02, $02 ; $76ff
	script_wait_idle $02 ; $7706
	script_face $02, $40 ; $770b
	script_set_anim $02, $02 ; $7712
	script_wait_idle $02 ; $7719
	script_wait_frames $28 ; $771e
	script_set_anim $02, $02 ; $7725
	script_wait_idle $02 ; $772c
	ld a, $02 ; $7731
	farcall FarPtr_GetActorStateAddr ; $7733
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	script_face $02, $80 ; $773c
	script_wait_frames $14 ; $7743
	script_set_anim $02, $03 ; $774a
	script_wait_idle $02 ; $7751
	script_wait_frames $14 ; $7756
	script_set_anim $00, $03 ; $775d
	script_wait_idle $00 ; $7764
Label_13_7769:
	script_set_text $041c ; $7769
	script_wait_frames $14 ; $776f
	script_speak $08 ; $7776
	script_facing_lock $00, $00 ; $777b
	script_face $00, $00 ; $7782
	script_face $02, $00 ; $7789
	script_set_actor_script $08, $7a43 ; $7790
	script_set_actor_script $03, $7a60 ; $779b
	script_wait_frames $14 ; $77a6
	script_set_actor_script $09, $7ac9 ; $77ad
	script_move_player $0b00, $1d00 ; $77b8
	farcall FarPtr_WaitPlayerMoveDone ; $77c2
	ld a, $09 ; $77c5
	farcall FarPtr_WaitActorScriptDone ; $77c7
	script_face_toward $00, $09 ; $77ca
	script_face_toward $03, $02 ; $77d2
	script_set_anim $09, $04 ; $77da
	script_wait_idle $09 ; $77e1
	script_face_toward $09, $00 ; $77e6
	script_speak $09 ; $77ee
	script_move_target $08, $0a00, $1f00 ; $77f3
	script_wait_move $08 ; $77fe
	script_face_toward $08, $00 ; $7803
	script_face_toward $03, $02 ; $780b
	script_set_anim $08, $03 ; $7813
	script_wait_idle $08 ; $781a
	script_speak $08 ; $781f
	script_move_target $03, $0c00, $1f00 ; $7824
	script_wait_move $03 ; $782f
	script_set_anim $03, $02 ; $7834
	script_wait_idle $03 ; $783b
	script_speak $03 ; $7840
	script_face_toward $00, $02 ; $7845
	script_set_anim $02, $03 ; $784d
	script_wait_idle $02 ; $7854
	test_flag $1c, 0 ; $7859
	jr z, Label_13_7861 ; $785c
	farcall FarPtr_AdvanceDialogueTextCursor ; $785e
Label_13_7861:
	script_speak $02 ; $7861
	script_face_toward $02, $00 ; $7866
	script_set_anim $00, $03 ; $786e
	script_wait_idle $00 ; $7875
	script_wait_frames $0a ; $787a
	script_face_toward $08, $00 ; $7881
	script_face_toward $03, $02 ; $7889
	script_wait_frames $0a ; $7891
	script_set_anim $00, $03 ; $7898
	script_set_anim $02, $03 ; $789f
	ld c, $02 ; $78a6
	call BeginFadeOut ; $78a8
	call WaitFadeEnd ; $78ab
	call Func_13_78c4 ; $78ae
	ld a, $00 ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [wStoryModeEntryPoint], a ; $78b8
	ld a, $ff ; $78bb
	ld [$c294], a ; $78bd
	ld [wStoryModeExitLocationRequest], a ; $78c0
	ret ; $78c3
Func_13_78c4:
	ld b, $00 ; $78c4
	ld a, [$c90d] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [$c94d] ; $78cd
	xor a, d ; $78d0
	or a, c ; $78d1
	ld c, a ; $78d2
	farcall FarPtr_18_8e ; $78d3
	ret ; $78d6
DoublesTravelingTeamActors_13:
	; $78d7, 164 bytes (map_actors)
	map_actor $0000, ActorObjDef_13_7b25, $1900, $1d00, $80, $4b, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0d00, $1700, $40, $68, $01, $07
	map_actor $0000, ActorObjDef_13_7b25, $1300, $2100, $80, $65, $01, $03
	map_actor $0000, ActorObjDef_13_7b25, $1300, $2300, $80, $67, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $1300, $1700, $80, $6b, $01, $06
	map_actor $0000, ActorObjDef_13_7b25, $1700, $1d00, $80, $49, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $0b00, $1300, $40, $4a, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $53, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $4c, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $4c, $01, $00
	map_actor $0000, ActorObjDef_13_7b25, $3d00, $3d00, $80, $4c, $01, $00
	map_actor_end
DoublesTravelingTeamInitScript_13:
	set_flag $0a, 3 ; $797b
	set_flag $0a, 7 ; $797e
	set_flag $08, 2 ; $7981
	set_flag $08, 6 ; $7984
	ret ; $7987
Label_13_7988:
	test_flag $05, 7 ; $7988
	jr z, Label_13_7991 ; $798b
	call DoublesTravelingTeamVictoryCutscene ; $798d
	ret ; $7990
Label_13_7991:
	call SinglesTravelingTeamVictoryCutscene ; $7991
	ret ; $7994
Func_13_7995:
	wram_bank $04 ; $7995
	ld a, [wMatchWinLoseFlag] ; $799b
	cp a, $01 ; $799e
	jp z, Label_13_79a4 ; $79a0
	ret ; $79a3
Label_13_79a4:
	ld a, $07 ; $79a4
	ld [wStoryModeCurrentLocation], a ; $79a6
	ld a, $0e ; $79a9
	ld [wStoryModeEntryPoint], a ; $79ab
	ld a, $ff ; $79ae
	ld [$c294], a ; $79b0
	ld [wStoryModeExitLocationRequest], a ; $79b3
	test_flag $05, 7 ; $79b6
	jr nz, Label_13_79e5 ; $79b9
	ldh a, [hRomBank] ; $79bb
	ld hl, SinglesTravelingTeamActors_13 ; $79bd
	farcall FarPtr_ScriptRespawnLocationActors ; $79c0
	farcall FarPtr_BeginCutsceneScriptMode ; $79c3
	script_fade_in $04 ; $79c6
	call WaitFadeEnd ; $79cb
	script_player_speed $0018 ; $79ce
	script_move_player $0900, $1300 ; $79d4
	farcall FarPtr_WaitPlayerMoveDone ; $79de
	call Func_13_7ae0 ; $79e1
	ret ; $79e4
Label_13_79e5:
	ldh a, [hRomBank] ; $79e5
	ld hl, DoublesTravelingTeamActors_13 ; $79e7
	farcall FarPtr_ScriptRespawnLocationActors ; $79ea
	farcall FarPtr_BeginCutsceneScriptMode ; $79ed
	call Func_13_62be ; $79f0
	ld a, $02 ; $79f3
	farcall FarPtr_SetActorNullScript ; $79f5
	ld a, $01 ; $79f8
	farcall FarPtr_SetActorNullScript ; $79fa
	script_player_speed $0040 ; $79fd
	script_set_position $00, $0b00, $1d00 ; $7a03
	script_set_position $02, $0d00, $2300 ; $7a0e
	script_face $00, $c0 ; $7a19
	script_face $02, $c0 ; $7a20
	script_fade_in $04 ; $7a27
	call WaitFadeEnd ; $7a2c
	script_move_player $0900, $1300 ; $7a2f
	farcall FarPtr_WaitPlayerMoveDone ; $7a39
	call Func_13_7ae0 ; $7a3c
	ret ; $7a3f
ActorObjDef_13_7a40:
	INCBIN "data/bank_013/d_7a40.bin" ; $7a40, 160 bytes
Func_13_7ae0:
	ld c, $08 ; $7ae0
	call BeginFadeOut ; $7ae2
	call WaitFadeEnd ; $7ae5
	xor a, a ; $7ae8
	ldh [hBGColumnBlitPending], a ; $7ae9
	ldh [hBGRowBlitPending], a ; $7aeb
	ldh [hScrollY], a ; $7aed
	ldh [hScrollX], a ; $7aef
	ld [$c321], a ; $7af1
	ld [$c323], a ; $7af4
	call ClearFrameTasks ; $7af7
	test_flag $05, 7 ; $7afa
	jr nz, Label_13_7b10 ; $7afd
	test_flag $07, 4 ; $7aff
	jr nz, Label_13_7b0a ; $7b02
	ld b, $00 ; $7b04
	ld c, $04 ; $7b06
	jr Label_13_7b1b ; $7b08
Label_13_7b0a:
	ld b, $00 ; $7b0a
	ld c, $01 ; $7b0c
	jr Label_13_7b1b ; $7b0e
Label_13_7b10:
	test_flag $06, 5 ; $7b10
	jr nz, Label_13_7b1f ; $7b13
	ld b, $01 ; $7b15
	ld c, $02 ; $7b17
	jr Label_13_7b1b ; $7b19
Label_13_7b1b:
	farcall FarPtr_ShowTournamentBracket ; $7b1b
	ret ; $7b1e
Label_13_7b1f:
	ld b, $01 ; $7b1f
	ld c, $01 ; $7b21
	jr Label_13_7b1b ; $7b23
ActorObjDef_13_7b25:
	INCBIN "data/bank_013/d_7b25.bin" ; $7b25, 10 bytes
ActorObjDef_13_7b2f:
	INCBIN "data/bank_013/d_7b2f.bin" ; $7b2f, 30 bytes
Func_13_7b4d:
	ret ; $7b4d
	xor a, a ; $7b4e
	ld [$c2da], a ; $7b4f
	ret ; $7b52
	sound $a2 ; $7b53
	ret ; $7b55
	INCBIN "data/bank_013/d_7b56.bin" ; $7b56, 514 bytes
ComputeStoryRankTier_13:
	ld a, $00 ; $7d58
	test_flag $0a, 3 ; $7d5a
	jr z, Label_13_7d77 ; $7d5d
	inc a ; $7d5f
	test_flag $0a, 7 ; $7d60
	jr z, Label_13_7d77 ; $7d63
	inc a ; $7d65
	test_flag $05, 7 ; $7d66
	jr nz, Label_13_7d7b ; $7d69
	test_flag $15, 6 ; $7d6b
	jr z, Label_13_7d77 ; $7d6e
	inc a ; $7d70
	test_flag $16, 0 ; $7d71
	jr z, Label_13_7d77 ; $7d74
	inc a ; $7d76
Label_13_7d77:
	ld [$c2b0], a ; $7d77
	ret ; $7d7a
Label_13_7d7b:
	test_flag $15, 7 ; $7d7b
	jr z, Label_13_7d77 ; $7d7e
	inc a ; $7d80
	test_flag $16, 1 ; $7d81
	jr z, Label_13_7d77 ; $7d84
	inc a ; $7d86
	jr Label_13_7d77 ; $7d87
	ds 631, $ff ; $7d89, fill
