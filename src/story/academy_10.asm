AcademyWingMapScripts_10:
	; $61b1, 14 bytes (map_tree)
	dw AcademyWingEntryPoints_10 ; slot 0 EntryPoints
	dw AcademyWingExitTriggers_10 ; slot 1 ExitTriggers
	dw AcademyWingActors_10 ; slot 2 Actors
	dw AcademyWingNpcScripts_10 ; slot 3 NpcScripts
	dw AcademyWingFacingScripts_10 ; slot 4 FacingScripts
	dw AcademyWingTileTriggers_10 ; slot 5 TileTriggers
	dw AcademyWingInitScript_10 ; slot 6 InitScript
AcademyWingActors_10:
	; $61bf, 66 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $3f00, $1900, FACE_RIGHT, OBJ_WALK_75_06, $01, $00, ACADEMY_WING_WALK_75_06
	map_actor $0000, ActorScript_10_2, $1900, $3f00, FACE_RIGHT, OBJ_WALK_71_09, $01, $00, ACADEMY_WING_WALK_71_09
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_WALK_77_07_1
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_WALK_77_07_2
	map_actor_end
AcademyWingEntryPoints_10:
	; $6201, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3b00, $3900, MapArrivalWalkPair_10
	map_entry $0f, FACE_UP, $2000, $3400, MapScriptNop_10
	db $ff
AcademyWingExitTriggers_10:
	; $6212, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $03
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_ACADEMY_MAIN_BLDG, $04
	map_script $04, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_ACADEMY_MAIN_BLDG, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $0f
	db $ff
AcademyWingNpc03_10:
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_WING_WALK_75_06 ; $623b
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $6243
	jr z, .altText ; $6246
	script_set_text Text_30_517 ; $6248
	jr .done ; $624e
.altText:
	script_get_actor_state ACTOR_ACADEMY_WING_WALK_77_07_2 ; $6250
	ld c, l ; $6255
	ld b, h ; $6256
	ld hl, ACTORF_OAM_ATTR ; $6257
	add hl, bc ; $625a
	ld a, [hl] ; $625b
	or $20 ; $625c
	ld [hl], a ; $625e
	script_set_position ACTOR_ACADEMY_WING_WALK_77_07_2, $1b80, $2e00 ; $625f
	sound SFX_CHIME ; $626a
	script_wait_frames $3c ; $626c
	script_set_position ACTOR_ACADEMY_WING_WALK_77_07_2, $0100, $0100 ; $6273
	script_set_text Text_30_513 ; $627e
	test_flag FLAG_DOUBLES ; $6284
	jr z, .speak ; $6287
	farcall AdvanceDialogueTextCursor ; $6289
.speak:
	ld a, $03 ; $628c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $628e
	script_set_text Text_30_515 ; $6291
	farcall RunDialogueYesNoPrompt ; $6297
	farcall ScriptCloseDialogueWindow ; $629a
	script_wait_frames $05 ; $629d
	and a ; $62a4
	jr nz, .done ; $62a5
	script_set_text Text_30_516 ; $62a7
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $62ad
.done:
	script_speak ACTOR_ACADEMY_WING_WALK_75_06 ; $62b0
	ret ; $62b5
AcademyWingNpcScripts_10:
	; $62b6, 9 bytes (map_scripts)
	map_script ACTOR_ACADEMY_WING_WALK_75_06, FACEMASK_ANY, $0000, AcademyWingNpc03_10, NPC_FACE_PLAYER, $00
	db $ff
AcademyWingFacingScripts_10:
	; $62bf, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AcademyWingFacing01_10, $00, $00
	map_script $02, FACEMASK_ANY, $0000, AcademyWingFacing02_10, $00, $00
	db $ff
AcademyWingFacing02_10:
	ld a, [wMapSceneStage] ; $62d0
	cp ACADEMYWINGSTAGE_SENIOR_CHAMP ; $62d3
	jr nz, AcademyWingFacing01_10 ; $62d5
	farcall BeginCutsceneScriptMode ; $62d7
	script_player_speed $0020 ; $62da
	script_move_player $2100, $3300 ; $62e0
	script_set_text Text_30_449 ; $62ea
	script_face ACTOR_ACADEMY_WING_WALK_75_06, FACE_DOWN ; $62f0
	script_wait_frames $0a ; $62f7
	script_speak ACTOR_ACADEMY_WING_WALK_71_09 ; $62fe
	script_wait_frames $0a ; $6303
	script_set_anim ACTOR_PARTNER, $02 ; $630a
	script_set_anim ACTOR_PLAYER, $02 ; $6311
	script_wait_idle ACTOR_PLAYER ; $6318
	script_set_anim ACTOR_ACADEMY_WING_WALK_75_06, $04 ; $631d
	script_wait_idle ACTOR_ACADEMY_WING_WALK_75_06 ; $6324
	script_player_speed $0018 ; $6329
	script_speak ACTOR_ACADEMY_WING_WALK_71_09 ; $632f
	script_face ACTOR_ACADEMY_WING_WALK_75_06, FACE_RIGHT ; $6334
	script_move_player $2100, $3b00 ; $633b
	script_set_anim ACTOR_PLAYER, $02 ; $6345
	script_wait_idle ACTOR_PLAYER ; $634c
	farcall EndCutsceneScriptMode ; $6351
	ret ; $6354
AcademyWingFacing01_10:
	script_set_text Text_30_451 ; $6355
	script_speak ACTOR_PLAYER ; $635b
	ret ; $6360
AcademyWingTileTriggers_10:
	; $6361, 17 bytes (map_scripts)
	map_script $01, FACEMASK_UP, $0000, AcademyWingTile01_10, $00, $00
	map_script $02, FACEMASK_DOWN, $0000, AcademyWingTile02_10, $00, $00
	db $ff
AcademyWingTile01_10:
	script_set_speed ACTOR_PLAYER, $0014 ; $6372
	script_face ACTOR_PLAYER, FACE_UP ; $637a
	call AcademyWingOpenDoor_10 ; $6381
	test_flag FLAG_DOUBLES ; $6384
	jr z, .walkPlayer ; $6387
	script_move_target ACTOR_PARTNER, $2100, $3d00 ; $6389
	script_wait_move ACTOR_PARTNER ; $6394
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6399
	script_wait_move ACTOR_PLAYER ; $63a4
	script_wait_frames $02 ; $63a9
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $63b0
	script_wait_move ACTOR_PLAYER ; $63ba
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $63bf
	script_wait_move ACTOR_PLAYER ; $63c9
	script_wait_frames $0a ; $63ce
	script_face ACTOR_PLAYER, FACE_UP ; $63d5
	call AcademyWingCloseDoor_10 ; $63dc
	ret ; $63df
AcademyWingTile02_10:
	script_face ACTOR_PLAYER, FACE_DOWN ; $63e0
	script_set_speed ACTOR_PLAYER, $0010 ; $63e7
	call AcademyWingOpenDoor_10 ; $63ef
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $63f2
	test_flag FLAG_DOUBLES ; $63fd
	jr z, .walkPlayer ; $6400
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6402
	script_wait_move ACTOR_PLAYER ; $640d
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $6412
	script_wait_move ACTOR_PLAYER ; $641c
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $6421
	script_wait_move ACTOR_PLAYER ; $642b
	script_wait_frames $05 ; $6430
	call AcademyWingCloseDoor_10 ; $6437
	ret ; $643a
AcademyWingInitScript_10:
	script_set_anim $05, $06 ; $643b
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $6442
	jr nz, .checkDoublesFinal ; $6445
	script_set_position $05, $0100, $0100 ; $6447
.checkDoublesFinal:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6452
	jr nz, .byStage ; $6455
	script_set_position $06, $0100, $0100 ; $6457
.byStage:
	call SetAcademyWingDialogueStage_10 ; $6462
	ld a, [wMapSceneStage] ; $6465
	cp ACADEMYWINGSTAGE_COMPLETE ; $6468
	jr nz, .stage4 ; $646a
	ldh a, [hRomBank] ; $646c
	ld hl, AcademyWingInitActors1_10 ; $646e
	farcall ScriptRespawnLocationActors ; $6471
	farcall BeginCutsceneScriptMode ; $6474
	ld b, $1e ; $6477
	ld c, $38 ; $6479
	ld d, $20 ; $647b
	ld e, $38 ; $647d
	ld h, $02 ; $647f
	ld l, $02 ; $6481
	farcall CopyBehaviorMapRect ; $6483
	call MapArrivalWalkPair_10 ; $6486
	call AcademyWingHideActorByProgressFlag_10 ; $6489
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $1d00, $3000 ; $648c
	script_face ACTOR_ACADEMY_WING_INIT1_WALK_75_06, FACE_UP ; $6497
.stage4:
	ld a, [wMapSceneStage] ; $649e
	cp ACADEMYWINGSTAGE_SENIOR_CHAMP ; $64a1
	jr nz, .stage5 ; $64a3
	script_set_position $03, $19a0, $32c0 ; $64a5
.stage5:
	ld a, $16 ; $64b0
	ld [wMapScrollMinX], a ; $64b2
	ld a, $28 ; $64b5
	ld [wMapScrollMinY], a ; $64b7
	ld a, $40 ; $64ba
	ld [wMapWidthTiles], a ; $64bc
	ld a, $3e ; $64bf
	ld [wMapHeightTiles], a ; $64c1
	call DisableLCDSafely ; $64c4
	ld a, $00 ; $64c7
	farcall CopyScrolledSceneTilemapToVram ; $64c9
	call EnableLCD ; $64cc
	ld a, [wStoryModeEntryPoint] ; $64cf
	cp $0d ; $64d2
	jp z, .stage6 ; $64d4
	cp $0f ; $64d7
	jp z, AcademyWingInitActors0_10.eq0f ; $64d9
	call AcademyWingInstallDoorTriggers_10 ; $64dc
	ret ; $64df
.stage6:
	ldh a, [hRomBank] ; $64e0
	ld hl, AcademyWingInitActors0_10 ; $64e2
	farcall ScriptRespawnLocationActors ; $64e5
	farcall BeginCutsceneScriptMode ; $64e8
	script_set_anim ACTOR_ACADEMY_WING_INIT0_WALK_77_07_1, $06 ; $64eb
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $64f2
	jr nz, .placeActors ; $64f5
	script_set_position ACTOR_ACADEMY_WING_INIT0_WALK_77_07_1, $0100, $0100 ; $64f7
.placeActors:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6502
	jr nz, .done ; $6505
	script_set_position $0b, $0100, $0100 ; $6507
.done:
	script_player_speed $00f0 ; $6512
	script_move_player $1f00, $3b00 ; $6518
	farcall WaitPlayerMoveDone ; $6522
	script_set_position ACTOR_PLAYER, $3500, $3b00 ; $6525
	xor a ; $6530
	ld [wStoryModeShowLocationName], a ; $6531
	script_set_position ACTOR_PLAYER, $2b00, $3b00 ; $6534
	script_fade_in $08 ; $653f
	call WaitFadeEnd ; $6544
	script_wait_frames $3c ; $6547
	script_set_anim $06, $02 ; $654e
	script_wait_idle $06 ; $6555
	script_set_text Text_30_475 ; $655a
	script_speak $06 ; $6560
	script_set_anim $07, $02 ; $6565
	script_set_anim $08, $02 ; $656c
	script_set_anim $09, $02 ; $6573
	script_wait_idle $09 ; $657a
	script_face_pair $07, $08 ; $657f
	script_wait_frames $28 ; $6587
	script_face $07, FACE_UP ; $658e
	script_face $08, FACE_UP ; $6595
	script_wait_frames $28 ; $659c
	script_set_position $05, $2380, $3100 ; $65a3
	sound SFX_CHIME ; $65ae
	script_speak $07 ; $65b0
	script_set_position $05, $3f00, $3f00 ; $65b5
	script_set_anim $06, $03 ; $65c0
	script_wait_idle $06 ; $65c7
	script_speak $06 ; $65cc
	test_flag FLAG_DOUBLES ; $65d1
	jp z, .placeActors2 ; $65d4
	script_set_position $03, $2180, $3100 ; $65d7
	sound SFX_APPEAR1 ; $65e2
	script_wait_frames $0a ; $65e4
	farcall AdvanceDialogueTextCursor ; $65eb
	script_speak $08 ; $65ee
	script_set_position $03, $3f00, $3f00 ; $65f3
	script_face_toward $08, $07 ; $65fe
	script_wait_frames $01 ; $6606
	script_lock_facing $07 ; $660d
	script_move_target $07, $2100, $3300 ; $6614
	script_wait_move $07 ; $661f
	script_set_anim $08, $02 ; $6624
	script_move_target $07, $2200, $3300 ; $662b
	script_wait_move $07 ; $6636
	script_unlock_facing $07 ; $663b
	script_face_pair $08, $07 ; $6642
	script_speak $07 ; $664a
	script_face_toward $08, $09 ; $664f
	script_wait_frames $01 ; $6657
	script_lock_facing $09 ; $665e
	script_move_target $09, $1f00, $3300 ; $6665
	script_wait_move $09 ; $6670
	script_set_anim $08, $02 ; $6675
	script_move_target $09, $1e00, $3300 ; $667c
	script_wait_move $09 ; $6687
	script_unlock_facing $09 ; $668c
	script_face_pair $08, $09 ; $6693
	script_speak $09 ; $669b
	jr .face ; $66a0
.placeActors2:
	script_set_position $05, $2180, $3100 ; $66a2
	sound SFX_CHIME ; $66ad
	script_wait_frames $1e ; $66af
	script_speak $08 ; $66b6
	script_set_position $05, $3f00, $3f00 ; $66bb
.face:
	script_face_toward $08, $07 ; $66c6
	script_wait_frames $01 ; $66ce
	script_lock_facing $07 ; $66d5
	script_move_target $07, $2100, $3300 ; $66dc
	script_wait_move $07 ; $66e7
	script_move_target $07, $2200, $3300 ; $66ec
	script_wait_move $07 ; $66f7
	script_unlock_facing $07 ; $66fc
	script_face_pair $08, $07 ; $6703
	script_set_anim $08, $02 ; $670b
	script_wait_idle $08 ; $6712
	script_face_toward $08, $09 ; $6717
	script_wait_frames $01 ; $671f
	script_lock_facing $09 ; $6726
	script_move_target $09, $1f00, $3300 ; $672d
	script_wait_move $09 ; $6738
	script_move_target $09, $1e00, $3300 ; $673d
	script_wait_move $09 ; $6748
	script_unlock_facing $09 ; $674d
	script_face_pair $08, $09 ; $6754
	script_set_anim $08, $02 ; $675c
	script_wait_idle $08 ; $6763
	script_set_anim $09, $03 ; $6768
	script_set_anim $07, $03 ; $676f
	script_wait_idle $07 ; $6776
	script_move_target $06, $1e00, $2f00 ; $677b
	script_wait_move $06 ; $6786
	script_face $06, FACE_DOWN ; $678b
	script_wait_frames $1e ; $6792
	script_move_target $06, $2200, $2f00 ; $6799
	script_wait_move $06 ; $67a4
	script_face $06, FACE_DOWN ; $67a9
	script_wait_frames $1e ; $67b0
	script_move_target $06, $2000, $2f00 ; $67b7
	script_wait_move $06 ; $67c2
	script_face $06, FACE_DOWN ; $67c7
	script_wait_frames $0a ; $67ce
	script_set_anim $06, $02 ; $67d5
	script_wait_idle $06 ; $67dc
	script_face $07, FACE_UP ; $67e1
	script_face $08, FACE_UP ; $67e8
	script_face $09, FACE_UP ; $67ef
	script_set_text Text_30_482 ; $67f6
	script_speak $06 ; $67fc
	script_set_objdef OBJ_WALK_73_19, $03 ; $6801
	script_set_anim $03, $01 ; $680d
	script_set_objdef OBJ_WALK_73_19, $05 ; $6814
	script_set_anim $05, $01 ; $6820
	script_set_position $03, $1f80, $3100 ; $6827
	sound SFX_APPEAR2 ; $6832
	script_wait_frames $28 ; $6834
	script_set_position $04, $2180, $3100 ; $683b
	sound SFX_APPEAR2 ; $6846
	script_wait_frames $28 ; $6848
	script_set_position $03, $3f00, $3f00 ; $684f
	script_set_position $05, $2380, $3100 ; $685a
	sound SFX_APPEAR2 ; $6865
	script_wait_frames $28 ; $6867
	script_set_position $04, $3f00, $3f00 ; $686e
	script_wait_frames $28 ; $6879
	script_set_position $05, $3f00, $3f00 ; $6880
	script_face $07, FACE_DOWN ; $688b
	script_face $08, FACE_DOWN ; $6892
	script_face $09, FACE_DOWN ; $6899
	script_wait_frames $78 ; $68a0
	script_face $07, FACE_UP ; $68a7
	script_face $08, FACE_UP ; $68ae
	script_face $09, FACE_UP ; $68b5
	script_wait_frames $28 ; $68bc
	script_face_toward $07, $08 ; $68c3
	script_wait_frames $01 ; $68cb
	script_set_anim $08, $02 ; $68d2
	script_wait_idle $08 ; $68d9
	script_set_position $05, $2380, $3100 ; $68de
	sound SFX_APPEAR2 ; $68e9
	script_wait_frames $3c ; $68eb
	script_face_toward $09, $08 ; $68f2
	script_wait_frames $01 ; $68fa
	script_set_anim $08, $02 ; $6901
	script_wait_idle $08 ; $6908
	script_set_position $03, $1f80, $3100 ; $690d
	sound SFX_APPEAR2 ; $6918
	script_wait_frames $3c ; $691a
	test_flag FLAG_DOUBLES ; $6921
	jp z, .walkPlayer ; $6924
	script_null_script ACTOR_PARTNER ; $6927
	script_set_position ACTOR_PARTNER, $2d00, $3b00 ; $692c
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $6937
	script_move_target ACTOR_PARTNER, $2300, $3b00 ; $6942
	script_wait_move ACTOR_PARTNER ; $694d
	script_wait_frames $05 ; $6952
	script_face ACTOR_PLAYER, FACE_UP ; $6959
	call AcademyWingOpenDoor_10 ; $6960
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $6963
	script_move_target ACTOR_PARTNER, $2100, $3b00 ; $696e
	script_wait_move ACTOR_PARTNER ; $6979
	script_move_target ACTOR_PLAYER, $1f00, $3500 ; $697e
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $6989
	script_wait_move ACTOR_PARTNER ; $6994
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $6999
	script_wait_move ACTOR_PARTNER ; $69a4
	script_face ACTOR_PLAYER, FACE_UP ; $69a9
	script_face ACTOR_PARTNER, FACE_UP ; $69b0
	script_wait_frames $01 ; $69b7
	jr .academyWingCloseDoor ; $69be
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $69c0
	script_wait_move ACTOR_PLAYER ; $69cb
	script_face ACTOR_PLAYER, FACE_UP ; $69d0
	call AcademyWingOpenDoor_10 ; $69d7
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $69da
	script_wait_move ACTOR_PLAYER ; $69e5
	script_move_target ACTOR_PLAYER, $2000, $3500 ; $69ea
	script_wait_move ACTOR_PLAYER ; $69f5
	script_face ACTOR_PLAYER, FACE_UP ; $69fa
	script_wait_frames $01 ; $6a01
.academyWingCloseDoor:
	call AcademyWingCloseDoor_10 ; $6a08
	script_set_position $03, $3f00, $3f00 ; $6a0b
	script_set_position $05, $3f00, $3f00 ; $6a16
	script_wait_frames $0a ; $6a21
	script_face $07, FACE_DOWN ; $6a28
	script_face $08, FACE_DOWN ; $6a2f
	script_face $09, FACE_DOWN ; $6a36
	script_wait_frames $01 ; $6a3d
	script_set_anim $06, $02 ; $6a44
	script_set_anim $07, $02 ; $6a4b
	script_set_anim $08, $02 ; $6a52
	script_set_anim $09, $02 ; $6a59
	script_wait_idle $09 ; $6a60
	script_wait_frames $1e ; $6a65
	script_move_target $08, $2300, $3300 ; $6a6c
	script_move_target $07, $2500, $3300 ; $6a77
	script_move_target $09, $1d00, $3500 ; $6a82
	script_wait_move $09 ; $6a8d
	script_face $09, FACE_RIGHT ; $6a92
	script_move_target $08, $2300, $3500 ; $6a99
	script_move_target $07, $2500, $3500 ; $6aa4
	script_wait_move $07 ; $6aaf
	script_face $08, FACE_LEFT ; $6ab4
	script_face $07, FACE_LEFT ; $6abb
	script_wait_frames $0a ; $6ac2
	test_flag FLAG_DOUBLES ; $6ac9
	jp z, .placeActors3 ; $6acc
	script_wait_frames $3c ; $6acf
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $6ad6
	script_set_anim ACTOR_PLAYER, $02 ; $6ade
	script_wait_idle ACTOR_PLAYER ; $6ae5
	script_wait_frames $14 ; $6aea
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $6af1
	script_wait_frames $01 ; $6af9
	script_set_anim ACTOR_PARTNER, $03 ; $6b00
	script_wait_idle ACTOR_PARTNER ; $6b07
	script_wait_frames $14 ; $6b0c
	script_face ACTOR_PLAYER, FACE_UP ; $6b13
	script_face ACTOR_PARTNER, FACE_UP ; $6b1a
	script_set_anim $07, $03 ; $6b21
	script_set_anim $08, $03 ; $6b28
	script_set_anim $09, $03 ; $6b2f
	script_wait_idle $09 ; $6b36
	script_wait_frames $28 ; $6b3b
	script_set_anim ACTOR_PLAYER, $03 ; $6b42
	script_set_anim ACTOR_PARTNER, $03 ; $6b49
	script_wait_idle ACTOR_PARTNER ; $6b50
	script_move_target ACTOR_PLAYER, $1f00, $3200 ; $6b55
	script_move_target ACTOR_PARTNER, $2100, $3200 ; $6b60
	script_wait_move ACTOR_PARTNER ; $6b6b
	jp .wait ; $6b70
.placeActors3:
	script_set_position $04, $2180, $3300 ; $6b73
	sound SFX_APPEAR2 ; $6b7e
	script_wait_frames $50 ; $6b80
	script_set_position $04, $3f00, $3f00 ; $6b87
	script_face_toward $09, ACTOR_PLAYER ; $6b92
	script_wait_frames $28 ; $6b9a
	script_face_toward ACTOR_PLAYER, $09 ; $6ba1
	script_wait_frames $01 ; $6ba9
	script_set_anim $09, $03 ; $6bb0
	script_wait_idle $09 ; $6bb7
	script_wait_frames $14 ; $6bbc
	script_face ACTOR_PLAYER, FACE_UP ; $6bc3
	script_set_anim $07, $03 ; $6bca
	script_set_anim $08, $03 ; $6bd1
	script_set_anim $09, $03 ; $6bd8
	script_wait_idle $09 ; $6bdf
	script_wait_frames $28 ; $6be4
	script_set_anim ACTOR_PLAYER, $03 ; $6beb
	script_move_target ACTOR_PLAYER, $2000, $3200 ; $6bf2
	script_wait_move ACTOR_PLAYER ; $6bfd
.wait:
	script_wait_frames $01 ; $6c02
	script_move_target $09, $1e00, $3500 ; $6c09
	script_move_target $08, $2000, $3500 ; $6c14
	script_move_target $07, $2200, $3500 ; $6c1f
	script_wait_move $07 ; $6c2a
	script_face $09, FACE_UP ; $6c2f
	script_face $08, FACE_UP ; $6c36
	script_face $07, FACE_UP ; $6c3d
	script_set_anim $06, $03 ; $6c44
	script_wait_idle $06 ; $6c4b
	ld h, $00 ; $6c50
	ld l, $02 ; $6c52
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $6c54
	jr z, .checkFlag ; $6c57
	inc l ; $6c59
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $6c5a
	jr z, .pushArg ; $6c5d
	inc l ; $6c5f
.pushArg:
	farcall PushTextArgNumber ; $6c60
	script_speak $06 ; $6c63
	script_set_anim ACTOR_PLAYER, $02 ; $6c68
	script_wait_idle ACTOR_PLAYER ; $6c6f
	script_speak $06 ; $6c74
	script_set_anim ACTOR_PLAYER, $03 ; $6c79
	script_wait_idle ACTOR_PLAYER ; $6c80
	script_set_objdef OBJ_WALK_73_17, $05 ; $6c85
	script_set_anim $05, $01 ; $6c91
	script_set_position $05, $2380, $3300 ; $6c98
	sound SFX_CHIME ; $6ca3
	script_wait_frames $14 ; $6ca5
	script_speak $07 ; $6cac
	script_set_position $05, $3f00, $3f00 ; $6cb1
	script_set_anim $06, $03 ; $6cbc
	script_wait_idle $06 ; $6cc3
	script_speak $06 ; $6cc8
	script_face_pair $08, $07 ; $6ccd
	script_set_anim $07, $03 ; $6cd5
	script_set_anim $08, $03 ; $6cdc
	script_wait_idle $08 ; $6ce3
	script_wait_frames $28 ; $6ce8
	script_face_pair $08, $09 ; $6cef
	script_set_anim $09, $03 ; $6cf7
	script_set_anim $08, $03 ; $6cfe
	script_wait_idle $08 ; $6d05
	script_wait_frames $28 ; $6d0a
	script_face $07, FACE_UP ; $6d11
	script_face $08, FACE_UP ; $6d18
	script_face $09, FACE_UP ; $6d1f
	script_wait_frames $28 ; $6d26
	script_set_anim $09, $03 ; $6d2d
	script_set_anim $07, $03 ; $6d34
	script_set_anim $08, $03 ; $6d3b
	script_wait_idle $08 ; $6d42
	script_wait_frames $3c ; $6d47
	script_set_objdef OBJ_WALK_73_13, $05 ; $6d4e
	script_set_anim $05, $01 ; $6d5a
	script_set_position $05, $2180, $2d80 ; $6d61
	sound SFX_EMOTE ; $6d6c
	script_wait_frames $50 ; $6d6e
	script_set_position $05, $3f00, $3f00 ; $6d75
	ld a, $06 ; $6d80
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d82
	farcall RunDialogueYesNoPrompt ; $6d85
	farcall ScriptCloseDialogueWindow ; $6d88
	script_wait_frames $05 ; $6d8b
	and a ; $6d92
	jp z, .animate ; $6d93
	script_set_anim $06, $02 ; $6d96
	script_wait_idle $06 ; $6d9d
	script_speak $06 ; $6da2
	test_flag FLAG_DOUBLES ; $6da7
	jp z, .walk ; $6daa
	script_move_target $08, $2000, $3400 ; $6dad
	script_wait_move $08 ; $6db8
	script_face_toward $08, ACTOR_PLAYER ; $6dbd
	script_face_toward $08, ACTOR_PARTNER ; $6dc5
	script_speak $08 ; $6dcd
	script_wait_frames $1e ; $6dd2
	script_move_target $07, $2200, $3400 ; $6dd9
	script_wait_move $07 ; $6de4
	script_face_toward $07, ACTOR_PLAYER ; $6de9
	script_face_toward $07, ACTOR_PARTNER ; $6df1
	script_speak $07 ; $6df9
	script_wait_frames $1e ; $6dfe
	script_move_target $09, $1d00, $3200 ; $6e05
	script_wait_move $09 ; $6e10
	script_face_pair $09, ACTOR_PLAYER ; $6e15
	script_face_toward $09, ACTOR_PARTNER ; $6e1d
	jr .loop ; $6e25
.walk:
	script_move_target $08, $2000, $3400 ; $6e27
	script_wait_move $08 ; $6e32
	script_face_toward $08, ACTOR_PLAYER ; $6e37
	script_speak $08 ; $6e3f
	script_wait_frames $1e ; $6e44
	script_move_target $07, $2200, $3400 ; $6e4b
	script_wait_move $07 ; $6e56
	script_face_toward $07, ACTOR_PLAYER ; $6e5b
	script_speak $07 ; $6e63
	script_wait_frames $1e ; $6e68
	script_move_target $09, $1e00, $3200 ; $6e6f
	script_wait_move $09 ; $6e7a
	script_face_pair $09, ACTOR_PLAYER ; $6e7f
.loop:
	script_set_anim $09, $04 ; $6e87
	script_wait_idle $09 ; $6e8e
	script_set_text Text_30_491 ; $6e93
	ld a, $09 ; $6e99
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e9b
	farcall RunDialogueYesNoPrompt ; $6e9e
	farcall ScriptCloseDialogueWindow ; $6ea1
	script_wait_frames $05 ; $6ea4
	and a ; $6eab
	jr nz, .loop ; $6eac
.animate:
	script_set_anim $06, $03 ; $6eae
	script_wait_idle $06 ; $6eb5
	script_face $07, FACE_UP ; $6eba
	script_face $08, FACE_UP ; $6ec1
	script_face $09, FACE_UP ; $6ec8
	script_face ACTOR_PLAYER, FACE_UP ; $6ecf
	test_flag FLAG_DOUBLES ; $6ed6
	jp z, .wait2 ; $6ed9
	script_face ACTOR_PARTNER, FACE_UP ; $6edc
.wait2:
	script_wait_frames $14 ; $6ee3
	script_set_anim $07, $03 ; $6eea
	script_set_anim $08, $03 ; $6ef1
	script_set_anim $09, $03 ; $6ef8
	test_flag FLAG_DOUBLES ; $6eff
	jp z, .animate2 ; $6f02
	script_set_anim ACTOR_PARTNER, $03 ; $6f05
.animate2:
	script_set_anim ACTOR_PLAYER, $03 ; $6f0c
	script_wait_idle ACTOR_PLAYER ; $6f13
	script_set_text Text_30_492 ; $6f18
	script_speak $06 ; $6f1e
	ld c, $04 ; $6f23
	call BeginFadeOut ; $6f25
	call WaitFadeEnd ; $6f28
	script_wait_frames $32 ; $6f2b
	ld a, STORYLOC_DORM_ROOM ; $6f32
	ld [wStoryModeCurrentLocation], a ; $6f34
	ld a, $0a ; $6f37
	ld [wStoryModeEntryPoint], a ; $6f39
	ld a, $ff ; $6f3c
	ld [wUnusedExitTriggerIdMirror], a ; $6f3e
	ld [wStoryModeExitTriggerRequest], a ; $6f41
	ret ; $6f44
AcademyWingInitActors0_10:
	; $6f45, 136 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_14, $01, $00, ACADEMY_WING_INIT0_WALK_73_14
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_19, $01, $00, ACADEMY_WING_INIT0_WALK_73_19
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_17, $01, $00, ACADEMY_WING_INIT0_WALK_73_17
	map_actor $0000, ActorScript_10_2, $2000, $2f00, FACE_DOWN, OBJ_WALK_75_06, $01, $00, ACADEMY_WING_INIT0_WALK_75_06
	map_actor $0000, ActorScript_10_2, $2200, $3300, FACE_UP, OBJ_KEVIN, $01, $00, ACADEMY_WING_INIT0_KEVIN
	map_actor $0000, ActorScript_10_2, $2000, $3300, FACE_UP, OBJ_MARK, $01, $00, ACADEMY_WING_INIT0_MARK
	map_actor $0000, ActorScript_10_2, $1e00, $3300, FACE_UP, OBJ_EMILY, $01, $00, ACADEMY_WING_INIT0_EMILY
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_INIT0_WALK_77_07_1
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_INIT0_WALK_77_07_2
	map_actor_end
.eq0f:
	ldh a, [hRomBank] ; $6fcd
	ld hl, AcademyWingInitActors1_10 ; $6fcf
	farcall ScriptRespawnLocationActors ; $6fd2
	farcall BeginCutsceneScriptMode ; $6fd5
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_77_07_1, $06 ; $6fd8
	test_flag FLAG_DOUBLES ; $6fdf
	jp z, .checkFlag2 ; $6fe2
	script_null_script ACTOR_PARTNER ; $6fe5
	script_set_position ACTOR_PLAYER, $1f00, $3400 ; $6fea
	script_set_position ACTOR_PARTNER, $2100, $3400 ; $6ff5
	script_face ACTOR_PARTNER, FACE_UP ; $7000
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $7007
	jr nz, .face2 ; $700a
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_77_07_1, $3f00, $3f00 ; $700c
	jr .face2 ; $7017
.checkFlag2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7019
	jr nz, .face2 ; $701c
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_77_07_2, $3f00, $3f00 ; $701e
.face2:
	script_face ACTOR_PLAYER, FACE_UP ; $7029
	xor a ; $7030
	ld [wStoryModeShowLocationName], a ; $7031
	script_fade_in $04 ; $7034
	call WaitFadeEnd ; $7039
	script_wait_frames $3c ; $703c
	script_set_text Text_30_498 ; $7043
	call SpeakNpc03SinglesOrDoublesLine_10 ; $7049
	test_flag FLAG_DOUBLES ; $704c
	jp z, .animate3 ; $704f
	script_set_anim ACTOR_PARTNER, $02 ; $7052
.animate3:
	script_set_anim ACTOR_PLAYER, $02 ; $7059
	script_wait_idle ACTOR_PLAYER ; $7060
	call ShowNpc03SinglesOrDoublesPrompt_10 ; $7065
	farcall RunDialogueYesNoPrompt ; $7068
	farcall ScriptCloseDialogueWindow ; $706b
	script_wait_frames $05 ; $706e
	and a ; $7075
	jr nz, .animate4 ; $7076
	script_set_anim ACTOR_PLAYER, $03 ; $7078
	script_wait_idle ACTOR_PLAYER ; $707f
	farcall AdvanceDialogueTextCursor ; $7084
	jr .wait3 ; $7087
.animate4:
	script_set_anim ACTOR_PLAYER, $04 ; $7089
	script_wait_idle ACTOR_PLAYER ; $7090
.wait3:
	script_wait_frames $0a ; $7095
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $709c
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $70a3
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $70a8
	script_face ACTOR_ACADEMY_WING_INIT1_WALK_75_06, FACE_UP ; $70ad
	script_wait_frames $50 ; $70b4
	script_set_text Text_30_504 ; $70bb
	call SpeakNpc03SinglesOrDoublesLine_10 ; $70c1
	test_flag FLAG_DOUBLES ; $70c4
	jp z, .placeActors4 ; $70c7
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_1, $2080, $3200 ; $70ca
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_2, $2280, $3200 ; $70d5
	sound SFX_CHIME ; $70e0
	script_wait_frames $50 ; $70e2
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_1, $3f00, $3f00 ; $70e9
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_2, $3f00, $3f00 ; $70f4
	jr .face3 ; $70ff
.placeActors4:
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_1, $2180, $3200 ; $7101
	sound SFX_CHIME ; $710c
	script_wait_frames $50 ; $710e
	script_set_position ACTOR_ACADEMY_WING_INIT1_WALK_73_12_1, $3f00, $3f00 ; $7115
.face3:
	script_face ACTOR_ACADEMY_WING_INIT1_WALK_75_06, FACE_DOWN ; $7120
	script_wait_frames $01 ; $7127
	call SpeakNpc03SinglesOrDoublesLine_10 ; $712e
	script_wait_frames $1e ; $7131
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $7138
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $713f
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $7144
	script_set_speed ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $0010 ; $7149
	script_move_target ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $2200, $3000 ; $7151
	script_wait_move ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $715c
	script_wait_frames $28 ; $7161
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $7168
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $716f
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $7174
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $717b
	script_move_target ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $2000, $3000 ; $7180
	script_wait_move ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $718b
	script_face ACTOR_ACADEMY_WING_INIT1_WALK_75_06, FACE_DOWN ; $7190
	script_wait_frames $0a ; $7197
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $719e
	script_set_anim ACTOR_PLAYER, $02 ; $71a3
	script_wait_idle ACTOR_PLAYER ; $71aa
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $71af
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $71b6
.loopB:
	ld a, $03 ; $71bb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $71bd
	farcall RunDialogueYesNoPrompt ; $71c0
	farcall ScriptCloseDialogueWindow ; $71c3
	script_wait_frames $05 ; $71c6
	and a ; $71cd
	jr z, .checkDoubles ; $71ce
	script_set_anim ACTOR_PLAYER, $04 ; $71d0
	script_wait_idle ACTOR_PLAYER ; $71d7
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $02 ; $71dc
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $71e3
	script_set_text Text_30_511 ; $71e8
	jr .loopB ; $71ee
.checkDoubles:
	test_flag FLAG_DOUBLES ; $71f0
	jp z, .animate5 ; $71f3
	script_set_anim ACTOR_PLAYER, $03 ; $71f6
	script_wait_idle ACTOR_PLAYER ; $71fd
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $7202
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $7209
	script_set_text Text_30_512 ; $720e
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $7214
	script_set_anim ACTOR_PLAYER, $03 ; $7219
	script_set_anim ACTOR_PARTNER, $03 ; $7220
	script_wait_idle ACTOR_PARTNER ; $7227
	script_wait_frames $0a ; $722c
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7233
	script_wait_frames $1e ; $723b
	script_set_anim ACTOR_PLAYER, $03 ; $7242
	script_set_anim ACTOR_PARTNER, $03 ; $7249
	script_wait_idle ACTOR_PARTNER ; $7250
	script_face ACTOR_PARTNER, FACE_DOWN ; $7255
	script_move_target ACTOR_PLAYER, $2100, $3600 ; $725c
	script_wait_move ACTOR_PLAYER ; $7267
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $726c
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $7277
	script_wait_move ACTOR_PARTNER ; $7282
	call AcademyWingOpenDoor_10 ; $7287
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_0 ; $728a
	script_set_actor_script ACTOR_PARTNER, ActorScript_10_0 ; $7295
	script_wait_frames $28 ; $72a0
	jr .academyWingCloseDoor2 ; $72a7
.animate5:
	script_set_anim ACTOR_PLAYER, $03 ; $72a9
	script_wait_idle ACTOR_PLAYER ; $72b0
	script_set_anim ACTOR_ACADEMY_WING_INIT1_WALK_75_06, $03 ; $72b5
	script_wait_idle ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $72bc
	script_set_text Text_30_512 ; $72c1
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $72c7
	script_set_anim ACTOR_PLAYER, $03 ; $72cc
	script_wait_idle ACTOR_PLAYER ; $72d3
	script_wait_frames $1e ; $72d8
	script_move_target ACTOR_PLAYER, $2100, $3400 ; $72df
	script_wait_move ACTOR_PLAYER ; $72ea
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $72ef
	script_wait_move ACTOR_PLAYER ; $72fa
	call AcademyWingOpenDoor_10 ; $72ff
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_0 ; $7302
	script_wait_frames $14 ; $730d
.academyWingCloseDoor2:
	call AcademyWingCloseDoor_10 ; $7314
	script_wait_frames $3c ; $7317
	ld c, $02 ; $731e
	call BeginFadeOut ; $7320
	call WaitFadeEnd ; $7323
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $7326
	ld [wStoryModeCurrentLocation], a ; $7328
	ld a, $0c ; $732b
	ld [wStoryModeEntryPoint], a ; $732d
	ld a, $ff ; $7330
	ld [wUnusedExitTriggerIdMirror], a ; $7332
	ld [wStoryModeExitTriggerRequest], a ; $7335
	ret ; $7338
AcademyWingOpenDoor_10:
	script_wait_frames $0a ; $7339
	sound SFX_DOOR_ALT ; $7340
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7342
	script_wait_frames $02 ; $7351
	script_copy_scene_rect $0b, $38, $20, $38, $02, $02 ; $7358
	script_wait_frames $04 ; $7367
	ret ; $736e
AcademyWingCloseDoor_10:
	sound SFX_DOOR_ALT ; $736f
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7371
	script_wait_frames $02 ; $7380
	script_copy_scene_rect $03, $38, $20, $38, $02, $02 ; $7387
	script_wait_frames $04 ; $7396
	ret ; $739d
AcademyWingInitActors1_10:
	; $739e, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $2000, $3000, FACE_DOWN, OBJ_WALK_75_06, $01, $00, ACADEMY_WING_INIT1_WALK_75_06
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_INIT1_WALK_77_07_1
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, OBJ_WALK_77_07, $01, $00, ACADEMY_WING_INIT1_WALK_77_07_2
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_12, $01, $00, ACADEMY_WING_INIT1_WALK_73_12_1
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_12, $01, $00, ACADEMY_WING_INIT1_WALK_73_12_2
	map_actor_end
