DataPtr_DormEntranceMapScripts_12:
	dw DormEntranceMapScripts_12 ; $4000
DataPtr_WallPracticeRoomMapScripts_12:
	dw WallPracticeRoomMapScripts_12 ; $4002
DataPtr_SeniorCourtMapScripts_12:
	dw SeniorCourtMapScripts_12 ; $4004
DormEntranceMapScripts_12:
	; $4006, 14 bytes (map_tree)
	dw DormEntranceEntryPoints_12 ; slot 0 EntryPoints
	dw DormEntranceExitTriggers_12 ; slot 1 ExitTriggers
	dw DormEntranceActors_12 ; slot 2 Actors
	dw DormEntranceNpcScripts_12 ; slot 3 NpcScripts
	dw DormEntranceFacingScripts_12 ; slot 4 FacingScripts
	dw DormEntranceTileTriggers_12 ; slot 5 TileTriggers
	dw DormEntranceInitScript_12 ; slot 6 InitScript
DormEntranceActors_12:
	; $4014, 66 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, 1.0, 1.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, DORM_ENTRANCE_EMILY
	map_actor $0000, ActorScript_12_51, 1.0, 1.0, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00, DORM_ENTRANCE_KATE
	map_actor $0000, ActorScript_12_51, 1.0, 1.0, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, DORM_ENTRANCE_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_12_51, 1.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, DORM_ENTRANCE_BALLOON_QUESTION
	map_actor_end
DormEntranceEntryPoints_12:
	; $4056, 25 bytes (map_entries)
	map_entry $01, FACE_UP, 22.0, 27.0, DormEntranceArrival01_12
	map_entry $02, FACE_DOWN, 22.0, 13.0, DormEntranceArrival02_12
	map_entry $0f, FACE_UP, 22.0, 27.0, $0000
	db $ff
; Instruction-identical to AcademyMainBldgArrival02_10 and AcademyArrivalArrival01_11 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival02, DormEntranceArrival02_12 ; $406f
; Instruction-identical to AcademyMainBldgArrival01_10, RestaurantArrival01_10, MapArrivalWalk_11 and RestaurantPlazaArrival04_13 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival01, DormEntranceArrival01_12 ; $40b5
DormEntranceExitTriggers_12:
	; $40fb, 25 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_DORM_ROOM, $02
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_RESTAURANT_PLAZA, $01
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_DORM_ROOM, $0f
	db $ff
DormEntranceNpcScripts_12:
	ds 1, $ff ; $4114, fill
DormEntranceFacingScripts_12:
	ds 1, $ff ; $4115, fill
DormEntranceTileTriggers_12:
	; $4116, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DormEntranceTile01_12, $00, $00
	db $ff
DormEntranceTile01_12:
	script_set_active ACTOR_PLAYER, $00 ; $411f
	script_move_target ACTOR_PLAYER, 22.0, 9.0 ; $4126
	script_wait_move ACTOR_PLAYER ; $4131
	script_player_speed $0010 ; $4136
	script_move_player 22.0, 8.0 ; $413c
	script_wait_frames 15 ; $4146
	ld c, $04 ; $414d
	call BeginFadeOut ; $414f
	farcall WaitPlayerMoveDone ; $4152
	call WaitFadeEnd ; $4155
	ld a, [wStoryModeGenderOfMainCharacter] ; $4158
	or a ; $415b
	jr nz, .nonZero ; $415c
	ld a, $01 ; $415e
	ld [wUnusedExitTriggerIdMirror], a ; $4160
	ld [wStoryModeExitTriggerRequest], a ; $4163
	ret ; $4166
.nonZero:
	ld a, $01 ; $4167
	ld [wUnusedExitTriggerIdMirror], a ; $4169
	ld [wStoryModeExitTriggerRequest], a ; $416c
	ret ; $416f
DormEntranceInitScript_12:
	ld a, [wStoryModeEntryPoint] ; $4170
	cp $0f ; $4173
	call z, DormEntranceEntry0FScene ; $4175
	ret ; $4178
DormEntranceEntry0FScene:
	script_set_speed ACTOR_DORM_ENTRANCE_EMILY, $0010 ; $4179
	script_set_speed ACTOR_DORM_ENTRANCE_KATE, $0010 ; $4181
	script_set_speed ACTOR_PLAYER, $0010 ; $4189
	script_player_speed $0010 ; $4191
	script_set_position ACTOR_PLAYER, 22.0, 31.0 ; $4197
	script_set_position ACTOR_DORM_ENTRANCE_EMILY, 22.0, 29.0 ; $41a2
	script_face ACTOR_DORM_ENTRANCE_EMILY, FACE_UP ; $41ad
	script_fade_in $20 ; $41b4
	script_wait_frames 20 ; $41b9
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 22.0, 17.0 ; $41c0
	script_move_player 22.0, 15.0 ; $41cb
	script_move_target ACTOR_PLAYER, 22.0, 20.0 ; $41d5
	script_wait_move ACTOR_PLAYER ; $41e0
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 22.0, 17.0 ; $41e5
	script_move_target ACTOR_PLAYER, 22.0, 19.0 ; $41f0
	script_wait_move ACTOR_PLAYER ; $41fb
	script_wait_frames 20 ; $4200
	script_wait_move ACTOR_DORM_ENTRANCE_EMILY ; $4207
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_EMILY ; $420c
	script_set_text Text_31_74 ; $4214
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $421a
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_NOD ; $421f
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $4226
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $422b
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4230
	script_player_speed $0018 ; $4237
	script_move_player 22.0, 11.0 ; $423d
	farcall WaitPlayerMoveDone ; $4247
	script_wait_frames 20 ; $424a
	script_move_player 17.0, 11.0 ; $4251
	farcall WaitPlayerMoveDone ; $425b
	script_wait_frames 10 ; $425e
	script_move_player 26.0, 11.0 ; $4265
	farcall WaitPlayerMoveDone ; $426f
	script_wait_frames 10 ; $4272
	script_move_player 22.0, 11.0 ; $4279
	farcall WaitPlayerMoveDone ; $4283
	script_wait_frames 30 ; $4286
	script_move_player 22.0, 16.0 ; $428d
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4297
	script_wait_idle ACTOR_PLAYER ; $429e
	script_wait_frames 20 ; $42a3
	script_player_speed $0010 ; $42aa
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_EXCLAIM, 23.5, 15.0 ; $42b0
	sound SFX_CHIME ; $42bb
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_BOUNCE ; $42bd
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $42c4
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_EXCLAIM, 1.0, 1.0 ; $42c9
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $42d4
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 22.0, 11.0 ; $42d9
	script_wait_move ACTOR_DORM_ENTRANCE_EMILY ; $42e4
	script_set_position ACTOR_DORM_ENTRANCE_KATE, 23.0, 11.0 ; $42e9
	script_wait_frames 160 ; $42f4
	script_move_target ACTOR_PLAYER, 22.0, 21.0 ; $42fb
	script_wait_move ACTOR_PLAYER ; $4306
	script_face ACTOR_PLAYER, FACE_DOWN ; $430b
	script_wait_frames 20 ; $4312
	script_set_anim ACTOR_PLAYER, ANIM_SHAKE ; $4319
	script_wait_idle ACTOR_PLAYER ; $4320
	script_face ACTOR_PLAYER, FACE_UP ; $4325
	script_wait_frames 160 ; $432c
	script_face ACTOR_PLAYER, FACE_DOWN ; $4333
	script_wait_frames 20 ; $433a
	script_set_anim ACTOR_PLAYER, ANIM_SHAKE ; $4341
	script_wait_idle ACTOR_PLAYER ; $4348
	script_wait_frames 20 ; $434d
	script_set_active ACTOR_DORM_ENTRANCE_EMILY, $00 ; $4354
	script_set_position ACTOR_DORM_ENTRANCE_EMILY, 23.0, 25.0 ; $435b
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $4366
	script_move_target ACTOR_PLAYER, 22.5, 18.0 ; $436b
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4376
	ld a, $00 ; $437e
	farcall ScriptWaitActorJumpDone ; $4380
	script_face ACTOR_PLAYER, FACE_UP ; $4383
	script_set_active ACTOR_DORM_ENTRANCE_EMILY, $02 ; $438a
	script_set_position ACTOR_DORM_ENTRANCE_EMILY, 21.0, 11.0 ; $4391
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $439c
	or a ; $439f
	jr nz, .doubles ; $43a0
	script_set_text Text_31_92 ; $43a2
	script_set_objdef OBJ_HARRY, ACTOR_DORM_ENTRANCE_KATE ; $43a8
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_WALK ; $43b4
.doubles:
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 21.0, 15.0 ; $43bb
	script_wait_move ACTOR_DORM_ENTRANCE_EMILY ; $43c6
	script_move_target ACTOR_DORM_ENTRANCE_KATE, 23.0, 15.0 ; $43cb
	script_wait_move ACTOR_DORM_ENTRANCE_KATE ; $43d6
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_QUESTION, 24.0, 17.0 ; $43db
	sound SFX_EMOTE ; $43e6
	script_wait_frames 60 ; $43e8
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_SHAKE ; $43ef
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $43f6
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_QUESTION, 1.0, 1.0 ; $43fb
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $4406
	script_face_toward ACTOR_DORM_ENTRANCE_KATE, ACTOR_DORM_ENTRANCE_EMILY ; $440b
	script_wait_frames 60 ; $4413
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_EMILY ; $441a
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $4422
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $4427
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $442e
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $4433
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4438
	script_wait_idle ACTOR_PLAYER ; $443f
	script_wait_frames 20 ; $4444
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_NOD ; $444b
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $4452
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $4457
	script_face_toward ACTOR_DORM_ENTRANCE_EMILY, ACTOR_DORM_ENTRANCE_KATE ; $445c
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_SHAKE ; $4464
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $446b
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $4470
	script_face_toward ACTOR_DORM_ENTRANCE_KATE, ACTOR_DORM_ENTRANCE_EMILY ; $4475
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $447d
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $4482
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $4489
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_KATE ; $448e
	script_speak_restore $04 ; $4496
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_EMILY ; $449b
	farcall RunDialogueYesNoPrompt ; $44a3
	farcall ScriptCloseDialogueWindow ; $44a6
	script_wait_frames 5 ; $44a9
	and a ; $44b0
	jr nz, .finish ; $44b1
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $44b3
	farcall AdvanceDialogueTextCursor ; $44b8
	jr .done ; $44bb
.finish:
	farcall AdvanceDialogueTextCursor ; $44bd
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $44c0
.done:
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_NOD ; $44c5
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $44cc
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $44d1
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $44d6
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $44dd
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_BOUNCE ; $44e2
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $44e9
	script_speak ACTOR_DORM_ENTRANCE_EMILY ; $44ee
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_QUESTION, 24.0, 17.0 ; $44f3
	sound SFX_EMOTE ; $44fe
	script_wait_frames 60 ; $4500
	script_set_position ACTOR_DORM_ENTRANCE_BALLOON_QUESTION, 1.0, 1.0 ; $4507
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $4512
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $4519
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $451e
	script_face_toward ACTOR_DORM_ENTRANCE_KATE, ACTOR_DORM_ENTRANCE_EMILY ; $4523
	script_wait_frames 30 ; $452b
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_EMILY ; $4532
	script_wait_frames 30 ; $453a
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_NOD ; $4541
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $4548
	script_set_text Text_31_90 ; $454d
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $4553
	script_face_toward ACTOR_DORM_ENTRANCE_EMILY, ACTOR_DORM_ENTRANCE_KATE ; $4558
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4560
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $4567
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $456e
	script_move_player 22.0, 19.0 ; $4573
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 21.0, 19.0 ; $457d
	script_wait_move ACTOR_DORM_ENTRANCE_EMILY ; $4588
	script_face ACTOR_DORM_ENTRANCE_KATE, FACE_DOWN ; $458d
	script_face ACTOR_PLAYER, FACE_DOWN ; $4594
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 21.0, 21.0 ; $459b
	script_wait_move ACTOR_DORM_ENTRANCE_EMILY ; $45a6
	script_face ACTOR_DORM_ENTRANCE_EMILY, FACE_UP ; $45ab
	script_face ACTOR_PLAYER, FACE_DOWN ; $45b2
	script_speak ACTOR_DORM_ENTRANCE_KATE ; $45b9
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $45be
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $45c5
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $45cc
	script_set_anim ACTOR_DORM_ENTRANCE_EMILY, ANIM_NOD ; $45d1
	script_wait_idle ACTOR_DORM_ENTRANCE_EMILY ; $45d8
	script_face ACTOR_DORM_ENTRANCE_EMILY, FACE_DOWN ; $45dd
	script_wait_frames 30 ; $45e4
	script_move_target ACTOR_DORM_ENTRANCE_EMILY, 21.0, 31.0 ; $45eb
	script_wait_frames 120 ; $45f6
	script_face_pair ACTOR_PLAYER, ACTOR_DORM_ENTRANCE_KATE ; $45fd
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4605
	script_set_anim ACTOR_DORM_ENTRANCE_KATE, ANIM_NOD ; $460c
	script_wait_idle ACTOR_DORM_ENTRANCE_KATE ; $4613
	script_move_player 21.0, 15.0 ; $4618
	script_move_target ACTOR_PLAYER, 21.0, 15.0 ; $4622
	script_wait_move ACTOR_PLAYER ; $462d
	script_move_target ACTOR_DORM_ENTRANCE_KATE, 23.0, 11.0 ; $4632
	script_move_target ACTOR_PLAYER, 21.0, 11.0 ; $463d
	script_wait_move ACTOR_PLAYER ; $4648
	script_move_player 22.0, 11.0 ; $464d
	ld b, STORYLOC_DORM_ROOM ; $4657
	ld c, $0f ; $4659
	farcall SaveStoryReturnPoint ; $465b
	farcall SaveStorySlotWithTimer ; $465e
	ld a, $01 ; $4661
	farcall EraseStorySlotSaveData ; $4663
	farcall SaveStorySlotWithTimer ; $4666
	sound BGM_NONE ; $4669
	ld c, $04 ; $466b
	call BeginFadeOut ; $466d
	call WaitFadeEnd ; $4670
	ld a, $0f ; $4673
	ld [wUnusedExitTriggerIdMirror], a ; $4675
	ld [wStoryModeExitTriggerRequest], a ; $4678
	ret ; $467b
WallPracticeRoomMapScripts_12:
	; $467c, 14 bytes (map_tree)
	dw WallPracticeRoomEntryPoints_12 ; slot 0 EntryPoints
	dw WallPracticeRoomExitTriggers_12 ; slot 1 ExitTriggers
	dw WallPracticeRoomActors_12 ; slot 2 Actors
	dw WallPracticeRoomNpcScripts_12 ; slot 3 NpcScripts
	dw WallPracticeRoomFacingScripts_12 ; slot 4 FacingScripts
	dw WallPracticeRoomTileTriggers_12 ; slot 5 TileTriggers
	dw WallPracticeRoomInitScript_12 ; slot 6 InitScript
WallPracticeRoomActors_12:
	; $468a, 80 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, 3.0, 57.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $00, WALL_PRACTICE_ROOM_WALK_72_02
	map_actor $0000, ActorScript_12_51, 8.0, 55.0, FACE_UP, OBJ_WALK_71_05, ANIM_WALK, $00, WALL_PRACTICE_ROOM_WALK_71_05
	map_actor $0000, ActorScript_12_51, 13.0, 55.0, FACE_UP, OBJ_WALK_71_03, ANIM_WALK, $00, WALL_PRACTICE_ROOM_WALK_71_03
	map_actor $0000, ActorScript_12_51, 19.0, 57.0, FACE_RIGHT, OBJ_WALK_72_07, ANIM_WALK, $00, WALL_PRACTICE_ROOM_WALK_72_07
	map_actor $0000, ActorScript_12_51, 5.0, 55.0, FACE_DOWN, OBJ_WALK_72_06, ANIM_WALK, $00, WALL_PRACTICE_ROOM_WALK_72_06
	map_actor_end
WallPracticeRoomEntryPoints_12:
	; $46da, 25 bytes (map_entries)
	map_entry $01, FACE_UP, 15.0, 57.0, WallPracticeRoomArrival01_12
	map_entry $0a, FACE_UP, 12.0, 49.0, $0000
	map_entry $0b, FACE_UP, 12.0, 49.0, $0000
	db $ff
WallPracticeRoomArrival01_12:
	ld a, [wStoryModeEntryPoint] ; $46f3
	cp STORYENTRY_NONE ; $46f6
	jp z, .done ; $46f8
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $46fb
	test_flag FLAG_DOUBLES ; $46fe
	jr z, .done ; $4701
	script_set_position ACTOR_PARTNER, 15.0, 59.0 ; $4703
	script_face ACTOR_PARTNER, FACE_UP ; $470e
.done:
	ret ; $4715
WallPracticeRoomExitTriggers_12:
	; $4716, 9 bytes (map_scripts:exit)
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_TRAINING_CENTER, $02
	db $ff
WallPracticeRoomNpc03_12:
	ld a, [wMapSceneStage] ; $471f
	add a ; $4722
	ld_hl_indexed WallPracticeRoomNpc03TextIds ; $4723
	ld a, [hl+] ; $472a
	ld h, [hl] ; $472b
	ld l, a ; $472c
	farcall InitDialogueTextCursor ; $472d
	ld a, [wMapSceneStage] ; $4730
	ld a, a ; $4733
	rst Rst00 ; $4734
	dw WallPracticeRoomNpc03_12.altText ; $4735 jumptable
	dw WallPracticeRoomNpc03_12.speak ; $4737 jumptable
	dw WallPracticeRoomNpc03_12.altText ; $4739 jumptable
	dw WallPracticeRoomNpc03_12.altText ; $473b jumptable
	dw WallPracticeRoomNpc03_12.done ; $473d jumptable
	dw WallPracticeRoomNpc03_12.done ; $473f jumptable
	dw WallPracticeRoomNpc03_12.speak ; $4741 jumptable
.altText:
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_02 ; $4743
	farcall RunDialogueYesNoPrompt ; $4748
	farcall ScriptCloseDialogueWindow ; $474b
	script_wait_frames 5 ; $474e
	and a ; $4755
	jr z, .speak ; $4756
	farcall AdvanceDialogueTextCursor ; $4758
.speak:
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_02 ; $475b
	ret ; $4760
.done:
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_02, ANIM_BOUNCE ; $4761
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_02 ; $4768
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_02 ; $476d
	ret ; $4772
WallPracticeRoomNpc03TextIds:
	; $4773, 14 bytes (text_ids)
	dw Text_35_231 ; record 0
	dw Text_35_256 ; record 1
	dw Text_35_266 ; record 2
	dw Text_36_8 ; record 3
	dw Text_36_21 ; record 4
	dw Text_36_21 ; record 5
	dw Text_36_44 ; record 6
WallPracticeRoomNpc04_12:
	ld a, [wMapSceneStage] ; $4781
	add a ; $4784
	ld_hl_indexed WallPracticeRoomNpc04TextIds ; $4785
	ld a, [hl+] ; $478c
	ld h, [hl] ; $478d
	ld l, a ; $478e
	farcall InitDialogueTextCursor ; $478f
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_71_05 ; $4792
	ret ; $4797
WallPracticeRoomNpc04TextIds:
	; $4798, 14 bytes (text_ids)
	dw Text_35_234 ; record 0
	dw Text_35_257 ; record 1
	dw Text_35_269 ; record 2
	dw Text_36_11 ; record 3
	dw Text_36_22 ; record 4
	dw Text_36_22 ; record 5
	dw Text_36_45 ; record 6
WallPracticeRoomNpc05_12:
	ld a, [wMapSceneStage] ; $47a6
	add a ; $47a9
	ld_hl_indexed WallPracticeRoomNpc05TextIds ; $47aa
	ld a, [hl+] ; $47b1
	ld h, [hl] ; $47b2
	ld l, a ; $47b3
	farcall InitDialogueTextCursor ; $47b4
	ld a, [wMapSceneStage] ; $47b7
	cp WALLPRACTICESTAGE_MASTER ; $47ba
	jr c, .face ; $47bc
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_71_03 ; $47be
	ret ; $47c3
.face:
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_71_03, FACE_UP ; $47c4
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_71_03 ; $47cb
	script_face_toward ACTOR_PLAYER, ACTOR_WALL_PRACTICE_ROOM_WALK_71_03 ; $47d0
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_71_03 ; $47d8
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_71_03, FACE_UP ; $47dd
	ret ; $47e4
WallPracticeRoomNpc05TextIds:
	; $47e5, 14 bytes (text_ids)
	dw Text_35_235 ; record 0
	dw Text_35_258 ; record 1
	dw Text_35_270 ; record 2
	dw Text_36_12 ; record 3
	dw Text_36_23 ; record 4
	dw Text_36_23 ; record 5
	dw Text_36_46 ; record 6
WallPracticeRoomNpc06_12:
	ld a, [wMapSceneStage] ; $47f3
	add a ; $47f6
	ld_hl_indexed WallPracticeRoomNpc06TextIds ; $47f7
	ld a, [hl+] ; $47fe
	ld h, [hl] ; $47ff
	ld l, a ; $4800
	farcall InitDialogueTextCursor ; $4801
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_07 ; $4804
	ret ; $4809
WallPracticeRoomNpc06TextIds:
	; $480a, 14 bytes (text_ids)
	dw Text_35_237 ; record 0
	dw Text_35_260 ; record 1
	dw Text_35_272 ; record 2
	dw Text_36_14 ; record 3
	dw Text_36_24 ; record 4
	dw Text_36_24 ; record 5
	dw Text_36_47 ; record 6
WallPracticeRoomNpcScripts_12:
	; $4818, 41 bytes (map_scripts)
	map_script ACTOR_WALL_PRACTICE_ROOM_WALK_72_02, FACEMASK_ANY, $0000, WallPracticeRoomNpc03_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_WALL_PRACTICE_ROOM_WALK_71_05, FACEMASK_ANY, $0000, WallPracticeRoomNpc04_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_WALL_PRACTICE_ROOM_WALK_71_03, FACEMASK_ANY, $0000, WallPracticeRoomNpc05_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_WALL_PRACTICE_ROOM_WALK_72_07, FACEMASK_ANY, $0000, WallPracticeRoomNpc06_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACEMASK_ANY, $0000, WallPracticeRoomNpc07_12, NPC_FACE_PLAYER, $00
	db $ff
WallPracticeMasterResultScript:
	script_fade_in $06 ; $4841
	call WaitFadeEnd ; $4846
	xor a ; $4849
	ld [wStoryModeShowLocationName], a ; $484a
	test_flag FLAG_CLEARED_WALL_EXPERT ; $484d
	jr z, WallPracticeScoreRetryPrompt ; $4850
	ld a, [wPointWinLoseFlag] ; $4852
	cp WINLOSE_WIN ; $4855
	jr nz, WallPracticeScoreRetryPrompt ; $4857
	jp WallPracticeMaxScoreScript ; $4859
WallPracticeScoreRetryPrompt:
	script_fade_in $06 ; $485c
	call WaitFadeEnd ; $4861
	xor a ; $4864
	ld [wStoryModeShowLocationName], a ; $4865
	ld hl, wMinigamesCurrentScore ; $4868
	ld a, [hl+] ; $486b
	ld b, [hl] ; $486c
	ld c, a ; $486d
	push_wram_bank WRAM_SOUND ; $486e
	ld a, $00 ; $4877
	farcall ReadMinigameRecord ; $4879
	ld hl, wMinigameRecordValue ; $487c
	ld a, [hl+] ; $487f
	ld d, [hl] ; $4880
	ld e, a ; $4881
	pop_wram_bank ; $4882
	ld l, c ; $4887
	ld h, b ; $4888
	inc de ; $4889
	ld a, l ; $488a
	sub e ; $488b
	ld l, a ; $488c
	ld a, h ; $488d
	sbc d ; $488e
	ld h, a ; $488f
	jp nc, WallPracticeNewRecordScript ; $4890
	ld a, [wPointOutcome] ; $4893
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4896
	jr nz, .ne09 ; $4898
	script_set_text Text_35_250 ; $489a
	jr .pushTextArgNumber ; $48a0
.ne09:
	ld a, [wPointOutcome] ; $48a2
	and $03 ; $48a5
	add a ; $48a7
	ld_hl_indexed WallPracticeScoreRetryPromptTextIds ; $48a8
	ld a, [hl+] ; $48af
	ld h, [hl] ; $48b0
	ld l, a ; $48b1
	farcall InitDialogueTextCursor ; $48b2
.pushTextArgNumber:
	ld hl, wMinigamesCurrentScore ; $48b5
	ld a, [hl+] ; $48b8
	ld h, [hl] ; $48b9
	ld l, a ; $48ba
	farcall PushTextArgNumber ; $48bb
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $48be
	farcall RunDialogueYesNoPrompt ; $48c3
	farcall ScriptCloseDialogueWindow ; $48c6
	script_wait_frames 5 ; $48c9
	and a ; $48d0
	jp nz, WallPracticeExitCourtScript ; $48d1
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_UP ; $48d4
	script_set_anim ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, ANIM_BOUNCE ; $48db
	script_wait_idle ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $48e2
	jp LaunchWallPracticeMinigame ; $48e7
	ret ; $48ea
WallPracticeNewRecordScript:
	push_wram_bank WRAM_SOUND ; $48eb
	ld hl, wMinigamesCurrentScore ; $48f4
	ld a, [hl+] ; $48f7
	ld d, [hl] ; $48f8
	ld e, a ; $48f9
	ld hl, wMinigameRecordValue ; $48fa
	ld a, e ; $48fd
	ld [hl+], a ; $48fe
	ld [hl], d ; $48ff
	ld a, $00 ; $4900
	farcall UpdateMinigameRecord ; $4902
	pop_wram_bank ; $4905
	call SetupWallPracticeLevelSigns ; $490a
	script_set_text Text_36_40 ; $490d
	ld hl, wMinigamesCurrentScore ; $4913
	ld a, [hl+] ; $4916
	ld h, [hl] ; $4917
	ld l, a ; $4918
	farcall PushTextArgNumber ; $4919
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $491c
	farcall RunDialogueYesNoPrompt ; $4921
	farcall ScriptCloseDialogueWindow ; $4924
	script_wait_frames 5 ; $4927
	and a ; $492e
	jp nz, WallPracticeExitCourtScript ; $492f
	jp LaunchWallPracticeMinigame ; $4932
	ret ; $4935
WallPracticeMaxScoreScript:
	script_set_text Text_36_41 ; $4936
	script_speak ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $493c
	push_wram_bank WRAM_SOUND ; $4941
	ld a, $00 ; $494a
	farcall ReadMinigameRecord ; $494c
	ld hl, wMinigameRecordValue ; $494f
	ld a, [hl+] ; $4952
	ld h, [hl] ; $4953
	ld l, a ; $4954
	pop_wram_bank ; $4955
	ld de, $270f ; $495a
	ld a, l ; $495d
	sub e ; $495e
	ld l, a ; $495f
	ld a, h ; $4960
	sbc d ; $4961
	ld h, a ; $4962
	jp c, RelaunchWallPracticeMasterLevel.carry ; $4963
	script_set_text Text_36_43 ; $4966
	script_speak_restore ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $496c
	farcall RunDialogueYesNoPrompt ; $4971
	farcall ScriptCloseDialogueWindow ; $4974
	script_wait_frames 5 ; $4977
	and a ; $497e
	jr z, RelaunchWallPracticeMasterLevel ; $497f
	script_set_speed ACTOR_PLAYER, $0020 ; $4981
	script_move_target ACTOR_PLAYER, 5.0, 49.0 ; $4989
	script_wait_move ACTOR_PLAYER ; $4994
	script_move_player 5.0, 55.0 ; $4999
	script_move_target ACTOR_PLAYER, 5.0, 57.0 ; $49a3
	script_wait_move ACTOR_PLAYER ; $49ae
	script_move_target ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, 5.0, 55.0 ; $49b3
	script_wait_move ACTOR_WALL_PRACTICE_ROOM_WALK_72_06 ; $49be
	script_face ACTOR_WALL_PRACTICE_ROOM_WALK_72_06, FACE_DOWN ; $49c3
	jp RelaunchWallPracticeMasterLevel.checkDoubles ; $49ca
