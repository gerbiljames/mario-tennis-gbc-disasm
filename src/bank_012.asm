SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

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
	map_actor $0000, ActorScript_12_51, $0100, $0100, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_12_51, $0100, $0100, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_12_51, $0100, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_12_51, $0100, $0100, FACE_DOWN, $4d, $01, $00
	map_actor_end
DormEntranceEntryPoints_12:
	; $4056, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $1600, $1b00, DormEntranceArrival01_12
	map_entry $02, FACE_DOWN, $1600, $0d00, DormEntranceArrival02_12
	map_entry $0f, FACE_UP, $1600, $1b00, $0000
	db $ff
DormEntranceArrival02_12:
	ld a, [wStoryModeEntryPoint] ; $406f
	cp STORYENTRY_NONE ; $4072
	jp z, .done ; $4074
	test_flag FLAG_DOUBLES ; $4077
	jr z, .walkOff ; $407a
	script_set_speed ACTOR_PARTNER, $00ff ; $407c
	script_move_angle ACTOR_PARTNER, FACE_UP, $0200 ; $4084
	script_wait_move ACTOR_PARTNER ; $408e
	script_face ACTOR_PARTNER, FACE_DOWN ; $4093
	script_set_speed ACTOR_PARTNER, $0010 ; $409a
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $40a2
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $40aa
.done:
	ret ; $40b4
DormEntranceArrival01_12:
	ld a, [wStoryModeEntryPoint] ; $40b5
	cp STORYENTRY_NONE ; $40b8
	jp z, .done ; $40ba
	test_flag FLAG_DOUBLES ; $40bd
	jr z, .walkOff ; $40c0
	script_set_speed ACTOR_PARTNER, $00ff ; $40c2
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $40ca
	script_wait_move ACTOR_PARTNER ; $40d4
	script_face ACTOR_PARTNER, FACE_UP ; $40d9
	script_set_speed ACTOR_PARTNER, $0010 ; $40e0
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $40e8
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $40f0
.done:
	ret ; $40fa
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
	script_move_target ACTOR_PLAYER, $1600, $0900 ; $4126
	script_wait_move ACTOR_PLAYER ; $4131
	script_player_speed $0010 ; $4136
	script_move_player $1600, $0800 ; $413c
	script_wait_frames $0f ; $4146
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
	script_set_speed $03, $0010 ; $4179
	script_set_speed $04, $0010 ; $4181
	script_set_speed ACTOR_PLAYER, $0010 ; $4189
	script_player_speed $0010 ; $4191
	script_set_position ACTOR_PLAYER, $1600, $1f00 ; $4197
	script_set_position $03, $1600, $1d00 ; $41a2
	script_face $03, FACE_UP ; $41ad
	script_fade_in $20 ; $41b4
	script_wait_frames $14 ; $41b9
	script_move_target $03, $1600, $1100 ; $41c0
	script_move_player $1600, $0f00 ; $41cb
	script_move_target ACTOR_PLAYER, $1600, $1400 ; $41d5
	script_wait_move ACTOR_PLAYER ; $41e0
	script_move_target $03, $1600, $1100 ; $41e5
	script_move_target ACTOR_PLAYER, $1600, $1300 ; $41f0
	script_wait_move ACTOR_PLAYER ; $41fb
	script_wait_frames $14 ; $4200
	script_wait_move $03 ; $4207
	script_face_toward ACTOR_PLAYER, $03 ; $420c
	script_set_text Text_31_74 ; $4214
	script_speak $03 ; $421a
	script_set_anim $03, $03 ; $421f
	script_wait_idle $03 ; $4226
	script_speak $03 ; $422b
	script_set_anim ACTOR_PLAYER, $02 ; $4230
	script_player_speed $0018 ; $4237
	script_move_player $1600, $0b00 ; $423d
	farcall WaitPlayerMoveDone ; $4247
	script_wait_frames $14 ; $424a
	script_move_player $1100, $0b00 ; $4251
	farcall WaitPlayerMoveDone ; $425b
	script_wait_frames $0a ; $425e
	script_move_player $1a00, $0b00 ; $4265
	farcall WaitPlayerMoveDone ; $426f
	script_wait_frames $0a ; $4272
	script_move_player $1600, $0b00 ; $4279
	farcall WaitPlayerMoveDone ; $4283
	script_wait_frames $1e ; $4286
	script_move_player $1600, $1000 ; $428d
	script_set_anim ACTOR_PLAYER, $02 ; $4297
	script_wait_idle ACTOR_PLAYER ; $429e
	script_wait_frames $14 ; $42a3
	script_player_speed $0010 ; $42aa
	script_set_position $05, $1780, $0f00 ; $42b0
	sound $97 ; $42bb
	script_set_anim $03, $02 ; $42bd
	script_wait_idle $03 ; $42c4
	script_set_position $05, $0100, $0100 ; $42c9
	script_speak $03 ; $42d4
	script_move_target $03, $1600, $0b00 ; $42d9
	script_wait_move $03 ; $42e4
	script_set_position $04, $1700, $0b00 ; $42e9
	script_wait_frames $a0 ; $42f4
	script_move_target ACTOR_PLAYER, $1600, $1500 ; $42fb
	script_wait_move ACTOR_PLAYER ; $4306
	script_face ACTOR_PLAYER, FACE_DOWN ; $430b
	script_wait_frames $14 ; $4312
	script_set_anim ACTOR_PLAYER, $04 ; $4319
	script_wait_idle ACTOR_PLAYER ; $4320
	script_face ACTOR_PLAYER, FACE_UP ; $4325
	script_wait_frames $a0 ; $432c
	script_face ACTOR_PLAYER, FACE_DOWN ; $4333
	script_wait_frames $14 ; $433a
	script_set_anim ACTOR_PLAYER, $04 ; $4341
	script_wait_idle ACTOR_PLAYER ; $4348
	script_wait_frames $14 ; $434d
	script_set_active $03, $00 ; $4354
	script_set_position $03, $1700, $1900 ; $435b
	script_speak $03 ; $4366
	script_move_target ACTOR_PLAYER, $1680, $1200 ; $436b
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4376
	ld a, $00 ; $437e
	farcall ScriptWaitActorJumpDone ; $4380
	script_face ACTOR_PLAYER, FACE_UP ; $4383
	script_set_active $03, $02 ; $438a
	script_set_position $03, $1500, $0b00 ; $4391
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $439c
	or a ; $439f
	jr nz, .doubles ; $43a0
	script_set_text Text_31_92 ; $43a2
	script_set_objdef $28, $04 ; $43a8
	script_set_anim $04, $01 ; $43b4
.doubles:
	script_move_target $03, $1500, $0f00 ; $43bb
	script_wait_move $03 ; $43c6
	script_move_target $04, $1700, $0f00 ; $43cb
	script_wait_move $04 ; $43d6
	script_set_position $06, $1800, $1100 ; $43db
	sound $98 ; $43e6
	script_wait_frames $3c ; $43e8
	script_set_anim $03, $04 ; $43ef
	script_wait_idle $03 ; $43f6
	script_set_position $06, $0100, $0100 ; $43fb
	script_speak $03 ; $4406
	script_face_toward $04, $03 ; $440b
	script_wait_frames $3c ; $4413
	script_face_toward ACTOR_PLAYER, $03 ; $441a
	script_speak $03 ; $4422
	script_set_anim $04, $03 ; $4427
	script_wait_idle $04 ; $442e
	script_speak $04 ; $4433
	script_set_anim ACTOR_PLAYER, $03 ; $4438
	script_wait_idle ACTOR_PLAYER ; $443f
	script_wait_frames $14 ; $4444
	script_set_anim $03, $03 ; $444b
	script_wait_idle $03 ; $4452
	script_speak $03 ; $4457
	script_face_toward $03, $04 ; $445c
	script_set_anim $04, $04 ; $4464
	script_wait_idle $04 ; $446b
	script_speak $04 ; $4470
	script_face_toward $04, $03 ; $4475
	script_speak $03 ; $447d
	script_set_anim $04, $03 ; $4482
	script_wait_idle $04 ; $4489
	script_face_toward ACTOR_PLAYER, $04 ; $448e
	ld a, $04 ; $4496
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4498
	script_face_toward ACTOR_PLAYER, $03 ; $449b
	farcall RunDialogueYesNoPrompt ; $44a3
	farcall ScriptCloseDialogueWindow ; $44a6
	script_wait_frames $05 ; $44a9
	and a ; $44b0
	jr nz, .finish ; $44b1
	script_speak $04 ; $44b3
	farcall AdvanceDialogueTextCursor ; $44b8
	jr .done ; $44bb
.finish:
	farcall AdvanceDialogueTextCursor ; $44bd
	script_speak $04 ; $44c0
.done:
	script_set_anim $03, $03 ; $44c5
	script_wait_idle $03 ; $44cc
	script_speak $03 ; $44d1
	script_set_anim $04, $03 ; $44d6
	script_wait_idle $04 ; $44dd
	script_set_anim $03, $02 ; $44e2
	script_wait_idle $03 ; $44e9
	script_speak $03 ; $44ee
	script_set_position $06, $1800, $1100 ; $44f3
	sound $98 ; $44fe
	script_wait_frames $3c ; $4500
	script_set_position $06, $0100, $0100 ; $4507
	script_set_anim $04, $03 ; $4512
	script_wait_idle $04 ; $4519
	script_speak $04 ; $451e
	script_face_toward $04, $03 ; $4523
	script_wait_frames $1e ; $452b
	script_face_toward ACTOR_PLAYER, $03 ; $4532
	script_wait_frames $1e ; $453a
	script_set_anim $03, $03 ; $4541
	script_wait_idle $03 ; $4548
	script_set_text Text_31_90 ; $454d
	script_speak $04 ; $4553
	script_face_toward $03, $04 ; $4558
	script_set_anim ACTOR_PLAYER, $03 ; $4560
	script_set_anim $04, $03 ; $4567
	script_wait_idle $04 ; $456e
	script_move_player $1600, $1300 ; $4573
	script_move_target $03, $1500, $1300 ; $457d
	script_wait_move $03 ; $4588
	script_face $04, FACE_DOWN ; $458d
	script_face ACTOR_PLAYER, FACE_DOWN ; $4594
	script_move_target $03, $1500, $1500 ; $459b
	script_wait_move $03 ; $45a6
	script_face $03, FACE_UP ; $45ab
	script_face ACTOR_PLAYER, FACE_DOWN ; $45b2
	script_speak $04 ; $45b9
	script_set_anim ACTOR_PLAYER, $03 ; $45be
	script_set_anim $04, $03 ; $45c5
	script_wait_idle $04 ; $45cc
	script_set_anim $03, $03 ; $45d1
	script_wait_idle $03 ; $45d8
	script_face $03, FACE_DOWN ; $45dd
	script_wait_frames $1e ; $45e4
	script_move_target $03, $1500, $1f00 ; $45eb
	script_wait_frames $78 ; $45f6
	script_face_pair ACTOR_PLAYER, $04 ; $45fd
	script_set_anim ACTOR_PLAYER, $03 ; $4605
	script_set_anim $04, $03 ; $460c
	script_wait_idle $04 ; $4613
	script_move_player $1500, $0f00 ; $4618
	script_move_target ACTOR_PLAYER, $1500, $0f00 ; $4622
	script_wait_move ACTOR_PLAYER ; $462d
	script_move_target $04, $1700, $0b00 ; $4632
	script_move_target ACTOR_PLAYER, $1500, $0b00 ; $463d
	script_wait_move ACTOR_PLAYER ; $4648
	script_move_player $1600, $0b00 ; $464d
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
	map_actor $0000, ActorScript_12_51, $0300, $3900, FACE_RIGHT, $39, $01, $00
	map_actor $0000, ActorScript_12_51, $0800, $3700, FACE_UP, $32, $01, $00
	map_actor $0000, ActorScript_12_51, $0d00, $3700, FACE_UP, $30, $01, $00
	map_actor $0000, ActorScript_12_51, $1300, $3900, FACE_RIGHT, $3e, $01, $00
	map_actor $0000, ActorScript_12_51, $0500, $3700, FACE_DOWN, $3d, $01, $00
	map_actor_end
WallPracticeRoomEntryPoints_12:
	; $46da, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $0f00, $3900, WallPracticeRoomArrival01_12
	map_entry $0a, FACE_UP, $0c00, $3100, $0000
	map_entry $0b, FACE_UP, $0c00, $3100, $0000
	db $ff
WallPracticeRoomArrival01_12:
	ld a, [wStoryModeEntryPoint] ; $46f3
	cp STORYENTRY_NONE ; $46f6
	jp z, .done ; $46f8
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $46fb
	test_flag FLAG_DOUBLES ; $46fe
	jr z, .done ; $4701
	script_set_position ACTOR_PARTNER, $0f00, $3b00 ; $4703
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
	ld a, $03 ; $4743
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4745
	farcall RunDialogueYesNoPrompt ; $4748
	farcall ScriptCloseDialogueWindow ; $474b
	script_wait_frames $05 ; $474e
	and a ; $4755
	jr z, .speak ; $4756
	farcall AdvanceDialogueTextCursor ; $4758
.speak:
	script_speak $03 ; $475b
	ret ; $4760
.done:
	script_set_anim $03, $02 ; $4761
	script_wait_idle $03 ; $4768
	script_speak $03 ; $476d
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
	script_speak $04 ; $4792
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
	script_speak $05 ; $47be
	ret ; $47c3
.face:
	script_face $05, FACE_UP ; $47c4
	script_speak $05 ; $47cb
	script_face_toward ACTOR_PLAYER, $05 ; $47d0
	script_speak $05 ; $47d8
	script_face $05, FACE_UP ; $47dd
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
	script_speak $06 ; $4804
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
	map_script $03, FACEMASK_ANY, $0000, WallPracticeRoomNpc03_12, $01, $00
	map_script $04, FACEMASK_ANY, $0000, WallPracticeRoomNpc04_12, $01, $00
	map_script $05, FACEMASK_ANY, $0000, WallPracticeRoomNpc05_12, $01, $00
	map_script $06, FACEMASK_ANY, $0000, WallPracticeRoomNpc06_12, $03, $00
	map_script $07, FACEMASK_ANY, $0000, WallPracticeRoomNpc07_12, $01, $00
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
	push_wram_bank $07 ; $486e
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
	ld a, $07 ; $48be
	farcall ScriptShowSpeakerDialogueRestoreBG ; $48c0
	farcall RunDialogueYesNoPrompt ; $48c3
	farcall ScriptCloseDialogueWindow ; $48c6
	script_wait_frames $05 ; $48c9
	and a ; $48d0
	jp nz, WallPracticeExitCourtScript ; $48d1
	script_face $07, FACE_UP ; $48d4
	script_set_anim $07, $02 ; $48db
	script_wait_idle $07 ; $48e2
	jp LaunchWallPracticeMinigame ; $48e7
	ret ; $48ea
WallPracticeNewRecordScript:
	push_wram_bank $07 ; $48eb
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
	ld a, $07 ; $491c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $491e
	farcall RunDialogueYesNoPrompt ; $4921
	farcall ScriptCloseDialogueWindow ; $4924
	script_wait_frames $05 ; $4927
	and a ; $492e
	jp nz, WallPracticeExitCourtScript ; $492f
	jp LaunchWallPracticeMinigame ; $4932
	ret ; $4935
WallPracticeMaxScoreScript:
	script_set_text Text_36_41 ; $4936
	script_speak $07 ; $493c
	push_wram_bank $07 ; $4941
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
	ld a, $07 ; $496c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $496e
	farcall RunDialogueYesNoPrompt ; $4971
	farcall ScriptCloseDialogueWindow ; $4974
	script_wait_frames $05 ; $4977
	and a ; $497e
	jr z, RelaunchWallPracticeMasterLevel ; $497f
	script_set_speed ACTOR_PLAYER, $0020 ; $4981
	script_move_target ACTOR_PLAYER, $0500, $3100 ; $4989
	script_wait_move ACTOR_PLAYER ; $4994
	script_move_player $0500, $3700 ; $4999
	script_move_target ACTOR_PLAYER, $0500, $3900 ; $49a3
	script_wait_move ACTOR_PLAYER ; $49ae
	script_move_target $07, $0500, $3700 ; $49b3
	script_wait_move $07 ; $49be
	script_face $07, FACE_DOWN ; $49c3
	jp RelaunchWallPracticeMasterLevel.checkDoubles ; $49ca
RelaunchWallPracticeMasterLevel:
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $49cd
	ld [wStoryModeCurrentLocation], a ; $49cf
	ld a, $0a ; $49d2
	ld [wStoryModeEntryPoint], a ; $49d4
	ld a, $ff ; $49d7
	ld [wUnusedExitTriggerIdMirror], a ; $49d9
	ld [wStoryModeExitTriggerRequest], a ; $49dc
	ld a, MINIGAME_WALL_PRACTICE_HIGH_SCORE ; $49df
	farcall RunTrainingDrillByID ; $49e1
	ret ; $49e4
.carry:
	push_wram_bank $07 ; $49e5
	ld hl, wMinigamesCurrentScore ; $49ee
	ld a, [hl+] ; $49f1
	ld d, [hl] ; $49f2
	ld e, a ; $49f3
	ld hl, wMinigameRecordValue ; $49f4
	ld a, e ; $49f7
	ld [hl+], a ; $49f8
	ld [hl], d ; $49f9
	ld a, $00 ; $49fa
	farcall UpdateMinigameRecord ; $49fc
	pop_wram_bank ; $49ff
	script_set_speed ACTOR_PLAYER, $0020 ; $4a04
	script_move_target ACTOR_PLAYER, $0500, $3100 ; $4a0c
	script_wait_move ACTOR_PLAYER ; $4a17
	script_move_player $0500, $3700 ; $4a1c
	script_move_target ACTOR_PLAYER, $0500, $3900 ; $4a26
	script_wait_move ACTOR_PLAYER ; $4a31
	script_move_target $07, $0500, $3700 ; $4a36
	script_wait_move $07 ; $4a41
	script_face $07, FACE_DOWN ; $4a46
	script_face ACTOR_PLAYER, FACE_UP ; $4a4d
	script_wait_frames $32 ; $4a54
	script_set_anim $07, $02 ; $4a5b
	script_wait_idle $07 ; $4a62
	script_speak $07 ; $4a67
.checkDoubles:
	test_flag FLAG_DOUBLES ; $4a6c
	jr z, .done ; $4a6f
	script_wait_frames $28 ; $4a71
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $4a78
	script_wait_frames $1e ; $4a80
	script_set_anim ACTOR_PLAYER, $03 ; $4a87
	script_set_anim ACTOR_PARTNER, $03 ; $4a8e
	script_wait_idle ACTOR_PARTNER ; $4a95
	script_get_actor_state ACTOR_PARTNER ; $4a9a
	ld c, l ; $4a9f
	ld b, h ; $4aa0
	ld de, wActors ; $4aa1
	farcall AttachActorStepMover ; $4aa4
	script_wait_frames $28 ; $4aa7
.done:
	ret ; $4aae
WallPracticeScoreRetryPromptTextIds:
	; $4aaf, 6 bytes (text_ids)
	dw Text_35_247 ; record 0
	dw Text_35_248 ; record 1
	dw Text_35_249 ; record 2
WallPracticeLevelResultScript:
	xor a ; $4ab5
	ld [wStoryModeShowLocationName], a ; $4ab6
	ld a, [wPointWinLoseFlag] ; $4ab9
	cp WINLOSE_WIN ; $4abc
	jp nz, .checkLevel ; $4abe
	ld a, [wMapSceneStage] ; $4ac1
	sub $01 ; $4ac4
	ld a, a ; $4ac6
	rst Rst00 ; $4ac7
	dw WallPracticeLevelResultScriptTextIds.variant4 ; $4ac8 jumptable
	dw WallPracticeLevelResultScriptTextIds.variant3 ; $4aca jumptable
	dw WallPracticeLevelResultScriptTextIds.variant2 ; $4acc jumptable
	dw WallPracticeLevelResultScriptTextIds.variant1 ; $4ace jumptable
.checkLevel:
	ld a, [wMapSceneStage] ; $4ad0
	cp WALLPRACTICESTAGE_MASTER ; $4ad3
	jp z, WallPracticeScoreRetryPrompt ; $4ad5
	script_fade_in $06 ; $4ad8
	call WaitFadeEnd ; $4add
	ld a, [wPointOutcome] ; $4ae0
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4ae3
	jr nz, .fromOutcome ; $4ae5
	script_set_text Text_35_246 ; $4ae7
	jr .speak ; $4aed
.fromOutcome:
	ld a, [wPointOutcome] ; $4aef
	and $03 ; $4af2
	add a ; $4af4
	ld_hl_indexed WallPracticeLevelResultScriptTextIds ; $4af5
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	farcall InitDialogueTextCursor ; $4aff
.speak:
	ld a, $07 ; $4b02
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4b04
	farcall RunDialogueYesNoPrompt ; $4b07
	farcall ScriptCloseDialogueWindow ; $4b0a
	script_wait_frames $05 ; $4b0d
	and a ; $4b14
	jp nz, WallPracticeExitCourtScript ; $4b15
	script_face $07, FACE_UP ; $4b18
	script_set_anim $07, $02 ; $4b1f
	script_wait_idle $07 ; $4b26
	jp LaunchWallPracticeMinigame ; $4b2b
WallPracticeExitCourtScript:
	script_set_text Text_35_251 ; $4b2e
	script_speak $07 ; $4b34
	script_set_speed ACTOR_PLAYER, $0020 ; $4b39
	script_move_target ACTOR_PLAYER, $0500, $3100 ; $4b41
	script_wait_move ACTOR_PLAYER ; $4b4c
	script_move_player $0500, $3700 ; $4b51
	script_move_target ACTOR_PLAYER, $0500, $3900 ; $4b5b
	script_wait_move ACTOR_PLAYER ; $4b66
	script_move_target $07, $0500, $3700 ; $4b6b
	script_wait_move $07 ; $4b76
	script_face $07, FACE_DOWN ; $4b7b
	test_flag FLAG_DOUBLES ; $4b82
	jr z, .done ; $4b85
	script_get_actor_state ACTOR_PARTNER ; $4b87
	ld c, l ; $4b8c
	ld b, h ; $4b8d
	ld de, wActors ; $4b8e
	farcall AttachActorStepMover ; $4b91
.done:
	script_wait_frames $0a ; $4b94
	ret ; $4b9b
WallPracticeLevelResultScriptTextIds:
	; $4b9c, 6 bytes (text_ids)
	dw Text_35_243 ; record 0
	dw Text_35_244 ; record 1
	dw Text_35_245 ; record 2
.variant1:
	script_set_text Text_35_255 ; $4ba2
	script_fade_in $06 ; $4ba8
	call WaitFadeEnd ; $4bad
	jr .speakAndLeave ; $4bb0
.variant2:
	push_wram_bank $07 ; $4bb2
	ld de, $0032 ; $4bbb
	ld hl, wMinigameRecordValue ; $4bbe
	ld a, e ; $4bc1
	ld [hl+], a ; $4bc2
	ld [hl], d ; $4bc3
	ld a, $00 ; $4bc4
	farcall UpdateMinigameRecord ; $4bc6
	pop_wram_bank ; $4bc9
	script_set_text Text_35_254 ; $4bce
	script_fade_in $06 ; $4bd4
	call WaitFadeEnd ; $4bd9
	jr .speakAndLeave ; $4bdc
.variant3:
	script_set_text Text_35_253 ; $4bde
	script_fade_in $06 ; $4be4
	call WaitFadeEnd ; $4be9
	jr .speakAndLeave ; $4bec
.variant4:
	script_set_text Text_35_252 ; $4bee
	script_fade_in $06 ; $4bf4
	call WaitFadeEnd ; $4bf9
.speakAndLeave:
	script_set_anim $07, $02 ; $4bfc
	script_wait_idle $07 ; $4c03
	script_speak $07 ; $4c08
	script_set_speed ACTOR_PLAYER, $0020 ; $4c0d
	script_move_target ACTOR_PLAYER, $0500, $3100 ; $4c15
	script_wait_move ACTOR_PLAYER ; $4c20
	script_move_player $0500, $3700 ; $4c25
	script_move_target ACTOR_PLAYER, $0500, $3900 ; $4c2f
	script_wait_move ACTOR_PLAYER ; $4c3a
	script_move_target $07, $0500, $3700 ; $4c3f
	script_wait_move $07 ; $4c4a
	script_face $07, FACE_DOWN ; $4c4f
	test_flag FLAG_DOUBLES ; $4c56
	jr z, .wait ; $4c59
	script_wait_frames $1e ; $4c5b
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $4c62
	script_wait_frames $1e ; $4c6a
	script_set_anim ACTOR_PLAYER, $03 ; $4c71
	script_set_anim ACTOR_PARTNER, $03 ; $4c78
	script_wait_idle ACTOR_PARTNER ; $4c7f
	script_get_actor_state ACTOR_PARTNER ; $4c84
	ld c, l ; $4c89
	ld b, h ; $4c8a
	ld de, wActors ; $4c8b
	farcall AttachActorStepMover ; $4c8e
	script_wait_frames $14 ; $4c91
.wait:
	script_wait_frames $0a ; $4c98
	ret ; $4c9f
WallPracticeRoomFacingScripts_12:
	; $4ca0, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, WallPracticeRoomFacing01_12, $00, $00
	db $ff
WallPracticeRoomFacing01_12:
	farcall BeginCutsceneScriptMode ; $4ca9
	script_fade_in $10 ; $4cac
	script_set_text Text_31_131 ; $4cb1
	script_speak ACTOR_PLAYER ; $4cb7
	farcall EndCutsceneScriptMode ; $4cbc
	ret ; $4cbf
WallPracticeRoomTileTriggers_12:
	; $4cc0, 41 bytes (map_scripts)
	map_script $02, FACEMASK_ANY, $9c00, WallPracticeRoomTile02_12, $00, $00
	map_script $03, FACEMASK_ANY, $0000, WallPracticeRoomTile03_12, $01, $00
	map_script $04, FACEMASK_ANY, $0000, WallPracticeRoomTile04_12, $01, $00
	map_script $05, FACEMASK_ANY, $0000, WallPracticeRoomTile05_12, $01, $00
	map_script $06, FACEMASK_ANY, $0000, WallPracticeRoomTile06_12, $01, $00
	db $ff
WallPracticeRoomTile02_12:
	script_move_target ACTOR_PLAYER, $0500, $3900 ; $4ce9
	script_wait_move ACTOR_PLAYER ; $4cf4
	script_move_target $07, $0500, $3700 ; $4cf9
	script_wait_move $07 ; $4d04
	script_face $07, FACE_DOWN ; $4d09
	clear_flag FLAG_TEMP_SCENE_VARIANT_A ; $4d10
	clear_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $4d13
	test_flag FLAG_DOUBLES ; $4d16
	jr z, .done ; $4d19
	script_get_actor_state ACTOR_PARTNER ; $4d1b
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, wActors ; $4d22
	farcall AttachActorStepMover ; $4d25
.done:
	ret ; $4d28
WallPracticeRoomTile03_12:
	script_set_text Text_36_48 ; $4d29
	ld a, $07 ; $4d2f
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4d31
	farcall RunDialogueYesNoPrompt ; $4d34
	farcall ScriptCloseDialogueWindow ; $4d37
	script_wait_frames $05 ; $4d3a
	and a ; $4d41
	jr nz, .done ; $4d42
	script_face $07, FACE_UP ; $4d44
	script_set_anim $07, $02 ; $4d4b
	script_set_speed ACTOR_PLAYER, $0020 ; $4d52
	script_move_target ACTOR_PLAYER, $0300, $3100 ; $4d5a
	script_wait_move ACTOR_PLAYER ; $4d65
	script_move_target ACTOR_PLAYER, $0c00, $3100 ; $4d6a
	ld c, $04 ; $4d75
	call BeginFadeOut ; $4d77
	call WaitFadeEnd ; $4d7a
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4d7d
	ld [wStoryModeCurrentLocation], a ; $4d7f
	ld a, $0b ; $4d82
	ld [wStoryModeEntryPoint], a ; $4d84
	ld a, $ff ; $4d87
	ld [wUnusedExitTriggerIdMirror], a ; $4d89
	ld [wStoryModeExitTriggerRequest], a ; $4d8c
	ld a, MINIGAME_WALL_PRACTICE_1 ; $4d8f
	farcall RunTrainingDrillByID ; $4d91
	farcall EndCutsceneScriptMode ; $4d94
.done:
	ret ; $4d97
WallPracticeRoomTile04_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_2 ; $4d98
	jp z, WallPracticeLevelLockedScript ; $4d9b
	script_set_text Text_36_49 ; $4d9e
	ld a, $07 ; $4da4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4da6
	farcall RunDialogueYesNoPrompt ; $4da9
	farcall ScriptCloseDialogueWindow ; $4dac
	script_wait_frames $05 ; $4daf
	and a ; $4db6
	jr nz, .done ; $4db7
	script_face $07, FACE_UP ; $4db9
	script_set_anim $07, $02 ; $4dc0
	script_set_speed ACTOR_PLAYER, $0020 ; $4dc7
	script_move_target ACTOR_PLAYER, $0700, $3100 ; $4dcf
	script_wait_move ACTOR_PLAYER ; $4dda
	script_move_target ACTOR_PLAYER, $0c00, $3100 ; $4ddf
	ld c, $04 ; $4dea
	call BeginFadeOut ; $4dec
	call WaitFadeEnd ; $4def
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4df2
	ld [wStoryModeCurrentLocation], a ; $4df4
	ld a, $0b ; $4df7
	ld [wStoryModeEntryPoint], a ; $4df9
	ld a, $ff ; $4dfc
	ld [wUnusedExitTriggerIdMirror], a ; $4dfe
	ld [wStoryModeExitTriggerRequest], a ; $4e01
	ld a, MINIGAME_WALL_PRACTICE_2 ; $4e04
	farcall RunTrainingDrillByID ; $4e06
	farcall EndCutsceneScriptMode ; $4e09
.done:
	ret ; $4e0c
WallPracticeRoomTile05_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_3 ; $4e0d
	jp z, WallPracticeLevelLockedScript ; $4e10
	script_set_text Text_36_50 ; $4e13
	ld a, $07 ; $4e19
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e1b
	farcall RunDialogueYesNoPrompt ; $4e1e
	farcall ScriptCloseDialogueWindow ; $4e21
	script_wait_frames $05 ; $4e24
	and a ; $4e2b
	jr nz, .done ; $4e2c
	script_face $07, FACE_UP ; $4e2e
	script_set_anim $07, $02 ; $4e35
	script_set_speed ACTOR_PLAYER, $0020 ; $4e3c
	script_move_target ACTOR_PLAYER, $1100, $3100 ; $4e44
	script_wait_move ACTOR_PLAYER ; $4e4f
	script_move_target ACTOR_PLAYER, $0c00, $3100 ; $4e54
	ld c, $04 ; $4e5f
	call BeginFadeOut ; $4e61
	call WaitFadeEnd ; $4e64
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4e67
	ld [wStoryModeCurrentLocation], a ; $4e69
	ld a, $0b ; $4e6c
	ld [wStoryModeEntryPoint], a ; $4e6e
	ld a, $ff ; $4e71
	ld [wUnusedExitTriggerIdMirror], a ; $4e73
	ld [wStoryModeExitTriggerRequest], a ; $4e76
	ld a, MINIGAME_WALL_PRACTICE_3 ; $4e79
	farcall RunTrainingDrillByID ; $4e7b
	farcall EndCutsceneScriptMode ; $4e7e
.done:
	ret ; $4e81
WallPracticeRoomTile06_12:
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $4e82
	jp z, WallPracticeLevelLockedScript ; $4e85
	script_set_text Text_36_51 ; $4e88
	ld a, $07 ; $4e8e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e90
	farcall RunDialogueYesNoPrompt ; $4e93
	farcall ScriptCloseDialogueWindow ; $4e96
	script_wait_frames $05 ; $4e99
	and a ; $4ea0
	jr nz, .done ; $4ea1
	script_face $07, FACE_UP ; $4ea3
	script_set_anim $07, $02 ; $4eaa
	script_set_speed ACTOR_PLAYER, $0020 ; $4eb1
	script_move_target ACTOR_PLAYER, $1500, $3100 ; $4eb9
	script_wait_move ACTOR_PLAYER ; $4ec4
	script_move_target ACTOR_PLAYER, $0c00, $3100 ; $4ec9
	ld c, $04 ; $4ed4
	call BeginFadeOut ; $4ed6
	call WaitFadeEnd ; $4ed9
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $4edc
	ld [wStoryModeCurrentLocation], a ; $4ede
	ld a, $0b ; $4ee1
	ld [wStoryModeEntryPoint], a ; $4ee3
	ld a, $ff ; $4ee6
	ld [wUnusedExitTriggerIdMirror], a ; $4ee8
	ld [wStoryModeExitTriggerRequest], a ; $4eeb
	ld a, MINIGAME_WALL_PRACTICE_4 ; $4eee
	farcall RunTrainingDrillByID ; $4ef0
	farcall EndCutsceneScriptMode ; $4ef3
.done:
	ret ; $4ef6
WallPracticeLevelLockedScript:
	script_set_text Text_36_52 ; $4ef7
	script_speak $07 ; $4efd
	ret ; $4f02
WallPracticeRoomInitScript_12:
	farcall WaitPlayerMoveDone ; $4f03
	ld a, $00 ; $4f06
	ld [wMapScrollMinX], a ; $4f08
	ld a, $27 ; $4f0b
	ld [wMapScrollMinY], a ; $4f0d
	ld a, $18 ; $4f10
	ld [wMapWidthTiles], a ; $4f12
	ld a, $3c ; $4f15
	ld [wMapHeightTiles], a ; $4f17
	call DisableLCDSafely ; $4f1a
	ld a, $00 ; $4f1d
	farcall CopyScrolledSceneTilemapToVram ; $4f1f
	call EnableLCD ; $4f22
	call SetupWallPracticeLevelSigns ; $4f25
	ld a, [wStoryModeEntryPoint] ; $4f28
	cp $0a ; $4f2b
	jp z, .fromMatch ; $4f2d
	cp $0b ; $4f30
	jp z, .reentry ; $4f32
	call RestoreWallPracticeRoomActors ; $4f35
	ret ; $4f38
.fromMatch:
	test_flag FLAG_DOUBLES ; $4f39
	jr z, .placeNpc ; $4f3c
	script_null_script ACTOR_PARTNER ; $4f3e
	script_set_position ACTOR_PARTNER, $0700, $3900 ; $4f43
	script_face ACTOR_PARTNER, FACE_UP ; $4f4e
.placeNpc:
	script_set_position $07, $0300, $3700 ; $4f55
	script_face $07, FACE_RIGHT ; $4f60
	ld a, [wMatchExitRequest] ; $4f67
	cp $01 ; $4f6a
	jp nz, .showResult ; $4f6c
	script_fade_in $06 ; $4f6f
	call WaitFadeEnd ; $4f74
	xor a ; $4f77
	ld [wStoryModeShowLocationName], a ; $4f78
	jp WallPracticeExitCourtScript ; $4f7b
.showResult:
	ld a, [wMapSceneStage] ; $4f7e
	cp WALLPRACTICESTAGE_EXPERT ; $4f81
	jp nc, WallPracticeMasterResultScript ; $4f83
	jp WallPracticeLevelResultScript ; $4f86
	ret ; $4f89
.reentry:
	test_flag FLAG_DOUBLES ; $4f8a
	jr z, .reentryPlaceNpc ; $4f8d
	script_null_script ACTOR_PARTNER ; $4f8f
	script_set_position ACTOR_PARTNER, $0700, $3900 ; $4f94
	script_face ACTOR_PARTNER, FACE_UP ; $4f9f
.reentryPlaceNpc:
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $4fa6
	script_set_position $07, $0300, $3700 ; $4fa9
	script_face $07, FACE_RIGHT ; $4fb4
	script_fade_in $06 ; $4fbb
	call WaitFadeEnd ; $4fc0
	xor a ; $4fc3
	ld [wStoryModeShowLocationName], a ; $4fc4
	ld a, [wMatchExitRequest] ; $4fc7
	cp $01 ; $4fca
	jp z, .done ; $4fcc
	ld a, [wPointWinLoseFlag] ; $4fcf
	cp WINLOSE_WIN ; $4fd2
	jr nz, .checkSession ; $4fd4
	script_set_text Text_36_53 ; $4fd6
	ld a, $07 ; $4fdc
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4fde
	farcall RunDialogueYesNoPrompt ; $4fe1
	farcall ScriptCloseDialogueWindow ; $4fe4
	script_wait_frames $05 ; $4fe7
	and a ; $4fee
	jr nz, .done ; $4fef
	jr .placeActors ; $4ff1
.checkSession:
	ld a, [wPointOutcome] ; $4ff3
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $4ff6
	jr nz, .sessionActive ; $4ff8
	script_set_text Text_35_246 ; $4ffa
	jr .normalEntry ; $5000
.sessionActive:
	ld a, [wPointOutcome] ; $5002
	and $03 ; $5005
	add a ; $5007
	ld_hl_indexed WallPracticeLevelResultScriptTextIds ; $5008
	ld a, [hl+] ; $500f
	ld h, [hl] ; $5010
	ld l, a ; $5011
	farcall InitDialogueTextCursor ; $5012
.normalEntry:
	ld a, $07 ; $5015
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5017
	farcall RunDialogueYesNoPrompt ; $501a
	farcall ScriptCloseDialogueWindow ; $501d
	script_wait_frames $05 ; $5020
	and a ; $5027
	jp nz, .done ; $5028
.placeActors:
	script_face $07, FACE_UP ; $502b
	script_set_anim $07, $02 ; $5032
	script_wait_idle $07 ; $5039
	ld c, $04 ; $503e
	call BeginFadeOut ; $5040
	call WaitFadeEnd ; $5043
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $5046
	ld [wStoryModeCurrentLocation], a ; $5048
	ld a, $0b ; $504b
	ld [wStoryModeEntryPoint], a ; $504d
	ld a, $ff ; $5050
	ld [wUnusedExitTriggerIdMirror], a ; $5052
	ld [wStoryModeExitTriggerRequest], a ; $5055
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5058
	farcall RunTrainingDrillByID ; $505b
.done:
	ret ; $505e
SetupWallPracticeLevelSigns:
	ld a, WALLPRACTICESTAGE_LEVEL1 ; $505f
	test_flag FLAG_CLEARED_WALL_LEVEL_1 ; $5061
	jp z, .step ; $5064
	script_copy_scene_rect $1e, $2c, $02, $2c, $02, $02 ; $5067
	ld a, WALLPRACTICESTAGE_LEVEL2 ; $5076
	test_flag FLAG_CLEARED_WALL_LEVEL_2 ; $5078
	jr z, .step ; $507b
	script_copy_scene_rect $1e, $30, $06, $2c, $02, $02 ; $507d
	ld a, WALLPRACTICESTAGE_LEVEL3 ; $508c
	test_flag FLAG_CLEARED_WALL_LEVEL_3 ; $508e
	jr z, .step ; $5091
	script_copy_scene_rect $1e, $34, $10, $2c, $02, $02 ; $5093
	ld a, WALLPRACTICESTAGE_LEVEL4 ; $50a2
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $50a4
	jr z, .step ; $50a7
	script_copy_scene_rect $1e, $38, $14, $2c, $02, $02 ; $50a9
	ld a, WALLPRACTICESTAGE_MASTER ; $50b8
	test_flag FLAG_CLEARED_WALL_MASTER ; $50ba
	jr z, .step ; $50bd
	ld a, WALLPRACTICESTAGE_EXPERT ; $50bf
	test_flag FLAG_CLEARED_WALL_EXPERT ; $50c1
	jr z, .step ; $50c4
	ld a, WALLPRACTICESTAGE_COMPLETE ; $50c6
.step:
	ld [wMapSceneStage], a ; $50c8
	ret ; $50cb
WallPracticeRoomNpc07_12:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $50cc
	jr z, .scoreLine ; $50cf
	script_set_text Text_35_264 ; $50d1
	script_speak $07 ; $50d7
	ret ; $50dc
.scoreLine:
	ld a, [wMapSceneStage] ; $50dd
	add a ; $50e0
	ld_hl_indexed WallPracticeRoomNpc07TextIds ; $50e1
	ld a, [hl+] ; $50e8
	ld h, [hl] ; $50e9
	ld l, a ; $50ea
	farcall InitDialogueTextCursor ; $50eb
	ld a, [wMapSceneStage] ; $50ee
	cp WALLPRACTICESTAGE_EXPERT ; $50f1
	jr nz, .prompt ; $50f3
	push_wram_bank $07 ; $50f5
	ld a, $00 ; $50fe
	farcall ReadMinigameRecord ; $5100
	ld hl, wMinigameRecordValue ; $5103
	ld a, [hl+] ; $5106
	ld h, [hl] ; $5107
	ld l, a ; $5108
	pop_wram_bank ; $5109
	farcall PushTextArgNumber ; $510e
.prompt:
	ld a, $07 ; $5111
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5113
	farcall RunDialogueYesNoPrompt ; $5116
	farcall ScriptCloseDialogueWindow ; $5119
	script_wait_frames $05 ; $511c
	and a ; $5123
	jp z, .doublesDeclined ; $5124
	ld a, [wMapSceneStage] ; $5127
	add a ; $512a
	ld_hl_indexed WallPracticeRoomNpc07TextIds2 ; $512b
	ld a, [hl+] ; $5132
	ld h, [hl] ; $5133
	ld l, a ; $5134
	farcall InitDialogueTextCursor ; $5135
	ld a, $07 ; $5138
	farcall ScriptShowSpeakerDialogueRestoreBG ; $513a
	farcall RunDialogueYesNoPrompt ; $513d
	farcall ScriptCloseDialogueWindow ; $5140
	script_wait_frames $05 ; $5143
	and a ; $514a
	jp nz, .declined ; $514b
	ld a, [wMapSceneStage] ; $514e
	and a ; $5151
	jp z, .speakDeclined ; $5152
	script_move_target $07, $0300, $3700 ; $5155
	script_wait_move $07 ; $5160
	script_face $07, FACE_RIGHT ; $5165
	script_speak $07 ; $516c
	test_flag FLAG_DOUBLES ; $5171
	jr z, .walkToCourt ; $5174
	script_null_script ACTOR_PARTNER ; $5176
	script_move_target ACTOR_PARTNER, $0700, $3900 ; $517b
	script_wait_move ACTOR_PARTNER ; $5186
	script_face ACTOR_PARTNER, FACE_UP ; $518b
.walkToCourt:
	script_set_speed ACTOR_PLAYER, $0020 ; $5192
	script_move_target ACTOR_PLAYER, $0500, $3500 ; $519a
	script_wait_move ACTOR_PLAYER ; $51a5
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $51aa
	set_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $51ad
	ret ; $51b0
.declined:
	farcall AdvanceDialogueTextCursor ; $51b1
.speakDeclined:
	script_speak $07 ; $51b4
	ret ; $51b9
.doublesDeclined:
	script_set_anim $07, $03 ; $51ba
	script_wait_idle $07 ; $51c1
	script_speak $07 ; $51c6
	script_move_target $07, $0300, $3700 ; $51cb
	script_wait_move $07 ; $51d6
	script_face $07, FACE_RIGHT ; $51db
	test_flag FLAG_DOUBLES ; $51e2
	jr z, .done ; $51e5
	script_wait_frames $14 ; $51e7
	script_null_script ACTOR_PARTNER ; $51ee
	script_move_target ACTOR_PARTNER, $0700, $3900 ; $51f3
	script_wait_move ACTOR_PARTNER ; $51fe
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $5203
	script_wait_frames $1e ; $520b
	script_set_anim ACTOR_PLAYER, $03 ; $5212
	script_set_anim ACTOR_PARTNER, $03 ; $5219
	script_wait_idle ACTOR_PARTNER ; $5220
	script_wait_frames $14 ; $5225
.done:
	script_set_speed ACTOR_PLAYER, $0020 ; $522c
	script_move_target ACTOR_PLAYER, $0500, $3700 ; $5234
	script_wait_move ACTOR_PLAYER ; $523f
	script_move_target ACTOR_PLAYER, $0500, $3100 ; $5244
	script_wait_move ACTOR_PLAYER ; $524f
	script_face $07, FACE_UP ; $5254
	script_set_anim $07, $02 ; $525b
	script_move_target ACTOR_PLAYER, $0c00, $3100 ; $5262
	jp LaunchWallPracticeMinigame ; $526d
	ret ; $5270
WallPracticeRoomNpc07TextIds:
	; $5271, 14 bytes (text_ids)
	dw Text_35_238 ; record 0
	dw Text_35_261 ; record 1
	dw Text_36_3 ; record 2
	dw Text_36_15 ; record 3
	dw Text_36_25 ; record 4
	dw Text_36_30 ; record 5
	dw Text_36_35 ; record 6
WallPracticeRoomNpc07TextIds2:
	; $527f, 14 bytes (text_ids)
	dw Text_35_240 ; record 0
	dw Text_35_263 ; record 1
	dw Text_36_5 ; record 2
	dw Text_36_17 ; record 3
	dw Text_36_27 ; record 4
	dw Text_36_32 ; record 5
	dw Text_36_37 ; record 6
LaunchWallPracticeMinigame:
	ld c, $04 ; $528d
	call BeginFadeOut ; $528f
	call WaitFadeEnd ; $5292
	ld a, STORYLOC_WALL_PRACTICE_ROOM ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [wStoryModeEntryPoint], a ; $529c
	ld a, $ff ; $529f
	ld [wUnusedExitTriggerIdMirror], a ; $52a1
	ld [wStoryModeExitTriggerRequest], a ; $52a4
	ld a, [wMapSceneStage] ; $52a7
	ld_hl_indexed LaunchWallPracticeMinigameTable ; $52aa
	ld a, [hl] ; $52b1
	farcall RunTrainingDrillByID ; $52b2
	farcall EndCutsceneScriptMode ; $52b5
	ret ; $52b8
LaunchWallPracticeMinigameTable:
	; $52b9, 7 bytes (bytes:16)
	db $16, $17, $18, $19, $1b, $1b, $1b ; 0x00
RestoreWallPracticeRoomActors:
	test_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $52c0
	jr z, .done ; $52c3
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $52c5
	script_set_position $07, $0300, $3700 ; $52c8
	script_face $07, FACE_RIGHT ; $52d3
	test_flag FLAG_DOUBLES ; $52da
	jr z, .done ; $52dd
	script_null_script ACTOR_PARTNER ; $52df
	script_set_position ACTOR_PARTNER, $0700, $3900 ; $52e4
	script_face ACTOR_PARTNER, FACE_UP ; $52ef
.done:
	ret ; $52f6
SeniorCourtMapScripts_12:
	; $52f7, 14 bytes (map_tree)
	dw SeniorCourtEntryPoints_12 ; slot 0 EntryPoints
	dw SeniorCourtExitTriggers_12 ; slot 1 ExitTriggers
	dw SeniorCourtActors_12 ; slot 2 Actors
	dw SeniorCourtNpcScripts_12 ; slot 3 NpcScripts
	dw SeniorCourtFacingScripts_12 ; slot 4 FacingScripts
	dw SeniorCourtTileTriggers_12 ; slot 5 TileTriggers
	dw SeniorCourtInitScript_12 ; slot 6 InitScript
SeniorCourtActors_12:
	; $5305, 178 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, $2900, $1900, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_12_43, $3500, $1e00, FACE_UP, $65, $06, $07
	map_actor $0000, ActorScript_12_57, $3200, $1e00, FACE_RIGHT, $64, $01, $05
	map_actor $0000, ActorScript_12_52, $3300, $1100, FACE_LEFT, $69, $01, $04
	map_actor $0000, ActorScript_12_51, $2900, $1300, FACE_LEFT, $66, $01, $06
	map_actor $0000, ActorScript_12_43, $0b00, $1500, FACE_UP, $6b, $01, $05
	map_actor $0000, ActorScript_12_58, $0b00, $1300, FACE_DOWN, $67, $01, $03
	map_actor $0000, ActorScript_12_56, $1500, $1700, FACE_UP, $68, $01, $06
	map_actor $0000, ActorScript_12_55, $1300, $0b00, FACE_DOWN, $6a, $01, $03
	map_actor $05e0, ActorScript_12_52, $0900, $0b00, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_12_53, $2200, $1300, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_12_54, $2500, $1d00, FACE_UP, $54, $01, $04
	map_actor_end
SeniorCourtActorsA_12:
	; $53b7, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, $2d00, $1900, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_12_51, $2900, $1b00, FACE_LEFT, $65, $01, $07
	map_actor $0000, ActorScript_12_57, $3900, $1d00, FACE_LEFT, $64, $01, $05
	map_actor $0000, ActorScript_12_51, $2d00, $1300, FACE_RIGHT, $69, $01, $04
	map_actor $0000, ActorScript_12_51, $2b00, $1100, FACE_LEFT, $66, $01, $06
	map_actor $0000, ActorScript_12_43, $0a00, $1500, FACE_UP, $6b, $01, $05
	map_actor $0000, ActorScript_12_51, $0300, $1700, FACE_RIGHT, $67, $01, $03
	map_actor $0000, ActorScript_12_57, $1200, $0d00, FACE_RIGHT, $68, $01, $06
	map_actor $0000, ActorScript_12_44, $1500, $0d00, FACE_DOWN, $6a, $06, $03
	map_actor $05e0, ActorScript_12_52, $0300, $0b00, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_12_53, $2200, $1100, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_12_54, $2600, $1d00, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_12_55, $3200, $1100, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_12_56, $3600, $1d00, FACE_UP, $54, $01, $06
	map_actor $0000, ActorScript_12_51, $4000, $4000, FACE_UP, $53, $01, $00
	map_actor_end
SeniorCourtActorsB_12:
	; $5493, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, $2d00, $1900, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_12_43, $2d00, $1100, FACE_UP, $65, $06, $07
	map_actor $0000, ActorScript_12_57, $2d00, $0f00, FACE_DOWN, $64, $01, $05
	map_actor $0000, ActorScript_12_51, $3900, $1d00, FACE_LEFT, $69, $01, $04
	map_actor $0000, ActorScript_12_51, $3900, $1b00, FACE_LEFT, $66, $01, $06
	map_actor $0000, ActorScript_12_43, $2300, $1e00, FACE_UP, $6b, $01, $05
	map_actor $0000, ActorScript_12_51, $2300, $1c00, FACE_DOWN, $67, $01, $03
	map_actor $0000, ActorScript_12_51, $0900, $0700, FACE_RIGHT, $68, $01, $06
	map_actor $0000, ActorScript_12_51, $0b00, $0700, FACE_LEFT, $6a, $01, $03
	map_actor $05e0, ActorScript_12_52, $0300, $0b00, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_12_53, $1200, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_12_54, $1600, $1600, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_12_55, $3200, $1100, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_12_56, $3600, $1d00, FACE_UP, $54, $01, $06
	map_actor $0000, ActorScript_12_51, $4000, $4000, FACE_UP, $53, $01, $00
	map_actor_end
SeniorCourtEntryPoints_12:
	; $556f, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $2300, $0000
	map_entry $09, FACE_UP, $0b00, $1900, $0000
	db $ff
SeniorCourtExitTriggers_12:
	; $5580, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, SeniorCourtExit01_12, STORYLOC_RESTAURANT_PLAZA, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_SENIOR_CLASS_COURT, $0f
	db $ff
SeniorCourtExit01_12:
	clear_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5591
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $5594
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $559e
	ld c, $10 ; $55a8
	call BeginFadeOut ; $55aa
	script_wait_frames $1e ; $55ad
	ret ; $55b4
.loop:
	ld a, [wMapSceneStage2] ; $55b5
	sub $09 ; $55b8
	add a ; $55ba
	ld_hl_indexed SeniorCourtExit01TextIds ; $55bb
	ld a, [hl+] ; $55c2
	ld h, [hl] ; $55c3
	ld l, a ; $55c4
	farcall InitDialogueTextCursor ; $55c5
	ld a, [wStoryModeGenderOfMainCharacter] ; $55c8
	ld hl, $001d ; $55cb
	add l ; $55ce
	ld l, a ; $55cf
	jr nc, .pushTextArgFetchedString ; $55d0
	inc h ; $55d2
.pushTextArgFetchedString:
	call PushTextArgFetchedString ; $55d3
	script_speak $03 ; $55d6
	ret ; $55db
SeniorCourtExit01TextIds:
	; $55dc, 12 bytes (text_ids)
	dw Text_34_141 ; record 0
	dw Text_34_151 ; record 1
	dw Text_34_158 ; record 2
	dw Text_34_168 ; record 3
	dw Text_34_176 ; record 4
	dw Text_34_186 ; record 5
SeniorCourtNpc03_12:
	ld a, [wMapSceneStage2] ; $55e8
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55eb
	jr c, SeniorCourtNpc03FaceUpFlag0000_12.checkDoubles ; $55ed
	cp $09 ; $55ef
	jr nc, SeniorCourtExit01_12.loop ; $55f1
	call SeniorRankOfferScenePrep ; $55f3
	ret ; $55f6
SeniorCourtNpc03FaceUpFlag0000_12:
	ld a, [wMapSceneStage2] ; $55f7
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55fa
	jr c, .checkDoubles ; $55fc
	cp $09 ; $55fe
	jr nc, SeniorCourtExit01_12.loop ; $5600
	call SeniorRankOfferScenePrepFacingUp ; $5602
	ret ; $5605
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5606
	jp nz, SeniorCourtNpc03FaceUpFlag0840_12.checkFlag ; $5609
	script_set_text Text_34_4 ; $560c
	ld a, $03 ; $5612
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5614
	farcall RunDialogueYesNoPrompt ; $5617
	farcall ScriptCloseDialogueWindow ; $561a
	script_wait_frames $05 ; $561d
	and a ; $5624
	jr z, .speak ; $5625
	farcall AdvanceDialogueTextCursor ; $5627
.speak:
	script_speak $03 ; $562a
	ret ; $562f
SeniorCourtNpc03FaceRight_12:
	test_flag FLAG_DOUBLES ; $5630
	jr z, SeniorCourtNpc03_12 ; $5633
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5635
	jp nz, SeniorCourtNpc03FaceUpFlag0840_12.setText ; $5638
	script_set_speed ACTOR_PLAYER, $0010 ; $563b
	script_set_speed ACTOR_PARTNER, $0010 ; $5643
	script_null_script ACTOR_PARTNER ; $564b
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $5650
	script_move_target ACTOR_PARTNER, $2700, $1d00 ; $565b
	script_wait_move ACTOR_PARTNER ; $5666
	script_move_target ACTOR_PARTNER, $2b00, $1d00 ; $566b
	script_wait_move ACTOR_PARTNER ; $5676
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $567b
	script_wait_move ACTOR_PARTNER ; $5686
	script_face_toward $03, ACTOR_PARTNER ; $568b
	script_wait_move ACTOR_PLAYER ; $5693
	jp SeniorCourtNpc03FaceUpFlag0840_12.face ; $5698
SeniorCourtNpc03FaceUpFlag0840_12:
	test_flag FLAG_DOUBLES ; $569b
	jp z, SeniorCourtNpc03FaceUpFlag0000_12 ; $569e
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $56a1
	jp nz, .setText ; $56a4
	script_set_speed ACTOR_PARTNER, $0010 ; $56a7
	script_set_speed ACTOR_PLAYER, $0008 ; $56af
	script_face ACTOR_PLAYER, FACE_UP ; $56b7
	script_facing_lock ACTOR_PLAYER, $01 ; $56be
	script_null_script ACTOR_PARTNER ; $56c5
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $56ca
	script_move_target ACTOR_PARTNER, $2b00, $1b00 ; $56d5
	script_wait_move ACTOR_PARTNER ; $56e0
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $56e5
	script_wait_move ACTOR_PARTNER ; $56f0
	script_face_toward $03, ACTOR_PARTNER ; $56f5
	script_wait_move ACTOR_PLAYER ; $56fd
	jr .face ; $5702
.checkFlag:
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5704
	jp nz, .setText ; $5707
	script_set_speed ACTOR_PLAYER, $0010 ; $570a
	script_set_speed ACTOR_PARTNER, $0010 ; $5712
	script_null_script ACTOR_PARTNER ; $571a
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $571f
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $572a
	script_wait_move ACTOR_PARTNER ; $5735
	script_face_toward $03, ACTOR_PARTNER ; $573a
	script_wait_move ACTOR_PLAYER ; $5742
.face:
	script_face_toward $03, ACTOR_PLAYER ; $5747
	script_face_toward ACTOR_PARTNER, $03 ; $574f
	script_set_anim $03, $03 ; $5757
	script_wait_idle $03 ; $575e
	script_wait_frames $1e ; $5763
	script_face_toward ACTOR_PLAYER, $03 ; $576a
	script_set_anim $03, $03 ; $5772
	script_wait_idle $03 ; $5779
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $577e
	script_face ACTOR_PLAYER, FACE_UP ; $5785
	script_set_text Text_34_7 ; $578c
	set_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5792
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5795
	or a ; $5798
	jr nz, .speak ; $5799
	script_set_text Text_34_11 ; $579b
.speak:
	script_speak $03 ; $57a1
	script_face_toward ACTOR_PARTNER, $03 ; $57a6
	script_speak $03 ; $57ae
	script_set_anim ACTOR_PARTNER, $03 ; $57b3
	script_wait_idle ACTOR_PARTNER ; $57ba
	script_speak ACTOR_PARTNER ; $57bf
	script_set_speed ACTOR_PLAYER, $0018 ; $57c4
	script_set_speed ACTOR_PARTNER, $0018 ; $57cc
	script_move_target ACTOR_PARTNER, $2b00, $1b00 ; $57d4
	script_wait_move ACTOR_PARTNER ; $57df
	script_face_toward $03, ACTOR_PARTNER ; $57e4
	script_face_toward ACTOR_PARTNER, $03 ; $57ec
.setText:
	script_set_text Text_34_10 ; $57f4
	script_speak $03 ; $57fa
	script_set_anim ACTOR_PLAYER, $03 ; $57ff
	script_set_anim ACTOR_PARTNER, $03 ; $5806
	script_wait_idle ACTOR_PARTNER ; $580d
	script_get_actor_state ACTOR_PARTNER ; $5812
	ld c, l ; $5817
	ld b, h ; $5818
	ld de, wActors ; $5819
	farcall AttachActorStepMover ; $581c
	ret ; $581f
SeniorCourtNpc04_12:
	ld a, [wMapSceneStage2] ; $5820
	add a ; $5823
	ld_hl_indexed SeniorCourtNpc04TextIds ; $5824
	ld a, [hl+] ; $582b
	ld h, [hl] ; $582c
	ld l, a ; $582d
	farcall InitDialogueTextCursor ; $582e
	script_speak $04 ; $5831
	ld a, [wMapSceneStage2] ; $5836
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $5839
	jr nc, .ge02 ; $583b
	jr .done ; $583d
.ge02:
	ld a, [wMapSceneStage2] ; $583f
	cp SENIORCOURTSTAGE_DOUBLES_RANK3 ; $5842
	jr c, .done ; $5844
.done:
	ret ; $5846
SeniorCourtNpc04TextIds:
	; $5847, 18 bytes (text_ids)
	dw Text_34_14 ; record 0
	dw Text_34_14 ; record 1
	dw Text_34_26 ; record 2
	dw Text_34_26 ; record 3
	dw Text_34_26 ; record 4
	dw Text_34_27 ; record 5
	dw Text_34_85 ; record 6
	dw Text_34_85 ; record 7
	dw Text_34_86 ; record 8
SeniorCourtNpc05_12:
	ld a, [wMapSceneStage2] ; $5859
	add a ; $585c
	ld_hl_indexed SeniorCourtNpc05TextIds_12 ; $585d
	ld a, [hl+] ; $5864
	ld h, [hl] ; $5865
	ld l, a ; $5866
	farcall InitDialogueTextCursor ; $5867
	ld a, [wMapSceneStage2] ; $586a
	cp SENIORCOURTSTAGE_SINGLES_RANK2 ; $586d
	jr z, .eq04 ; $586f
	script_speak $05 ; $5871
	ret ; $5876
.eq04:
	ld a, $05 ; $5877
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5879
	farcall RunDialogueYesNoPrompt ; $587c
	farcall ScriptCloseDialogueWindow ; $587f
	script_wait_frames $05 ; $5882
	and a ; $5889
	jr z, .speak ; $588a
	farcall AdvanceDialogueTextCursor ; $588c
.speak:
	script_speak $05 ; $588f
	ret ; $5894
SeniorCourtNpc05TextIds_12:
	; $5895, 30 bytes (text_ids)
	dw Text_34_15 ; record 0
	dw Text_34_24 ; record 1
	dw Text_34_28 ; record 2
	dw Text_34_28 ; record 3
	dw Text_34_29 ; record 4
	dw Text_34_32 ; record 5
	dw Text_34_87 ; record 6
	dw Text_34_87 ; record 7
	dw Text_34_88 ; record 8
	dw Text_34_142 ; record 9
	dw Text_34_151 ; record 10
	dw Text_34_159 ; record 11
	dw Text_34_168 ; record 12
	dw Text_34_177 ; record 13
	dw Text_34_186 ; record 14
SeniorCourtNpc06_12:
	ld a, [wMapSceneStage2] ; $58b3
	add a ; $58b6
	ld_hl_indexed SeniorCourtNpc06TextIds_12 ; $58b7
	ld a, [hl+] ; $58be
	ld h, [hl] ; $58bf
	ld l, a ; $58c0
	farcall InitDialogueTextCursor ; $58c1
	ld a, [wMapSceneStage2] ; $58c4
	cp SENIORCOURTSTAGE_DOUBLES_RANK3 ; $58c7
	jr z, .eq06 ; $58c9
	script_speak $06 ; $58cb
	ret ; $58d0
.eq06:
	ld a, $06 ; $58d1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58d3
	farcall RunDialogueYesNoPrompt ; $58d6
	farcall ScriptCloseDialogueWindow ; $58d9
	script_wait_frames $05 ; $58dc
	and a ; $58e3
	jr z, .speak ; $58e4
	farcall AdvanceDialogueTextCursor ; $58e6
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $58e9
	or a ; $58ec
	jr nz, .speak ; $58ed
	farcall AdvanceDialogueTextCursor ; $58ef
.speak:
	script_speak $06 ; $58f2
	ret ; $58f7
SeniorCourtNpc06TextIds_12:
	; $58f8, 30 bytes (text_ids)
	dw Text_34_16 ; record 0
	dw Text_34_16 ; record 1
	dw Text_34_33 ; record 2
	dw Text_34_34 ; record 3
	dw Text_34_35 ; record 4
	dw Text_34_36 ; record 5
	dw Text_34_89 ; record 6
	dw Text_34_94 ; record 7
	dw Text_34_96 ; record 8
	dw Text_34_143 ; record 9
	dw Text_34_152 ; record 10
	dw Text_34_160 ; record 11
	dw Text_34_169 ; record 12
	dw Text_34_178 ; record 13
	dw Text_34_187 ; record 14
SeniorCourtNpc07_12:
	ld a, [wMapSceneStage2] ; $5916
	add a ; $5919
	ld_hl_indexed SeniorCourtNpc07TextIds ; $591a
	ld a, [hl+] ; $5921
	ld h, [hl] ; $5922
	ld l, a ; $5923
	farcall InitDialogueTextCursor ; $5924
	script_speak $07 ; $5927
	ret ; $592c
SeniorCourtNpc07TextIds:
	; $592d, 30 bytes (text_ids)
	dw Text_34_17 ; record 0
	dw Text_34_25 ; record 1
	dw Text_34_37 ; record 2
	dw Text_34_38 ; record 3
	dw Text_34_38 ; record 4
	dw Text_34_38 ; record 5
	dw Text_34_93 ; record 6
	dw Text_34_95 ; record 7
	dw Text_34_97 ; record 8
	dw Text_34_144 ; record 9
	dw Text_34_153 ; record 10
	dw Text_34_161 ; record 11
	dw Text_34_170 ; record 12
	dw Text_34_179 ; record 13
	dw Text_34_188 ; record 14
SeniorCourtNpc08_12:
	ld a, [wMapSceneStage2] ; $594b
	add a ; $594e
	ld_hl_indexed SeniorCourtNpc08TextIds ; $594f
	ld a, [hl+] ; $5956
	ld h, [hl] ; $5957
	ld l, a ; $5958
	farcall InitDialogueTextCursor ; $5959
	ld a, [wMapSceneStage2] ; $595c
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $595f
	jr z, .speak ; $5961
	jr nc, .altText ; $5963
	script_face $08, FACE_UP ; $5965
	script_set_anim $08, $06 ; $596c
.altText:
	script_speak $08 ; $5973
	ret ; $5978
.speak:
	ld a, $08 ; $5979
	farcall ScriptShowSpeakerDialogueRestoreBG ; $597b
	farcall RunDialogueYesNoPrompt ; $597e
	farcall ScriptCloseDialogueWindow ; $5981
	script_wait_frames $05 ; $5984
	and a ; $598b
	jr z, .doublesLine ; $598c
	script_speak $08 ; $598e
	ret ; $5993
.doublesLine:
	farcall AdvanceDialogueTextCursor ; $5994
	script_set_anim $08, $02 ; $5997
	script_wait_idle $08 ; $599e
	ld a, $08 ; $59a3
	farcall ScriptShowSpeakerDialogueRestoreBG ; $59a5
	farcall RunDialogueYesNoPrompt ; $59a8
	farcall ScriptCloseDialogueWindow ; $59ab
	script_wait_frames $05 ; $59ae
	and a ; $59b5
	jr z, .done ; $59b6
	script_speak $08 ; $59b8
	ret ; $59bd
.done:
	script_wait_frames $0a ; $59be
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_50 ; $59c5
	script_move_target $08, $0c00, $1500 ; $59d0
	script_wait_move $08 ; $59db
	script_set_actor_script $08, ActorScript_12_49 ; $59e0
	script_move_player $0a00, $1100 ; $59eb
	farcall WaitPlayerMoveDone ; $59f5
	script_wait_actor_script $08 ; $59f8
	ld hl, wStoryModePlayersXPosition ; $59fd
	ld de, wStoryModeSpawnPosition ; $5a00
	ld bc, $0005 ; $5a03
	call CopyMemoryBC ; $5a06
	ld a, $ff ; $5a09
	ld [wStoryModeEntryPoint], a ; $5a0b
	ld [wUnusedExitTriggerIdMirror], a ; $5a0e
	ld [wStoryModeExitTriggerRequest], a ; $5a11
	farcall InitStoryMatchSettings ; $5a14
	load_match_settings $0005 ; $5a17
	farcall RunStoryMatch ; $5a24
	farcall RestoreOverworldAfterMatch ; $5a27
	ret ; $5a2a
SeniorCourtNpc08TextIds:
	; $5a2b, 30 bytes (text_ids)
	dw Text_34_18 ; record 0
	dw Text_34_18 ; record 1
	dw Text_34_39 ; record 2
	dw Text_34_48 ; record 3
	dw Text_34_48 ; record 4
	dw Text_34_48 ; record 5
	dw Text_34_98 ; record 6
	dw Text_34_99 ; record 7
	dw Text_34_99 ; record 8
	dw Text_34_145 ; record 9
	dw Text_34_154 ; record 10
	dw Text_34_162 ; record 11
	dw Text_34_171 ; record 12
	dw Text_34_180 ; record 13
	dw Text_34_189 ; record 14
SeniorCourtNpc09_12:
	ld a, [wMapSceneStage2] ; $5a49
	add a ; $5a4c
	ld_hl_indexed SeniorCourtNpc09TextIds ; $5a4d
	ld a, [hl+] ; $5a54
	ld h, [hl] ; $5a55
	ld l, a ; $5a56
	farcall InitDialogueTextCursor ; $5a57
	ld a, [wMapSceneStage2] ; $5a5a
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $5a5d
	jr nc, .speak ; $5a5f
	script_face $09, FACE_DOWN ; $5a61
.speak:
	script_speak $09 ; $5a68
	ret ; $5a6d
SeniorCourtNpc09TextIds:
	; $5a6e, 30 bytes (text_ids)
	dw Text_34_19 ; record 0
	dw Text_34_19 ; record 1
	dw Text_34_43 ; record 2
	dw Text_34_49 ; record 3
	dw Text_34_49 ; record 4
	dw Text_34_49 ; record 5
	dw Text_34_100 ; record 6
	dw Text_34_101 ; record 7
	dw Text_34_101 ; record 8
	dw Text_34_146 ; record 9
	dw Text_34_155 ; record 10
	dw Text_34_163 ; record 11
	dw Text_34_172 ; record 12
	dw Text_34_181 ; record 13
	dw Text_34_190 ; record 14
SeniorCourtNpc0A_12:
	ld a, [wMapSceneStage2] ; $5a8c
	add a ; $5a8f
	ld_hl_indexed SeniorCourtNpc0ATextIds ; $5a90
	ld a, [hl+] ; $5a97
	ld h, [hl] ; $5a98
	ld l, a ; $5a99
	farcall InitDialogueTextCursor ; $5a9a
	ld a, [wMapSceneStage2] ; $5a9d
	cp SENIORCOURTSTAGE_DOUBLES_RANK3 ; $5aa0
	jr z, .altText ; $5aa2
	script_speak $0a ; $5aa4
	ret ; $5aa9
.altText:
	ld a, $0a ; $5aaa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5aac
	farcall RunDialogueYesNoPrompt ; $5aaf
	farcall ScriptCloseDialogueWindow ; $5ab2
	script_wait_frames $05 ; $5ab5
	and a ; $5abc
	jr z, .speak ; $5abd
	script_speak $0a ; $5abf
	ret ; $5ac4
.speak:
	farcall AdvanceDialogueTextCursor ; $5ac5
	ld a, $0a ; $5ac8
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5aca
	farcall RunDialogueYesNoPrompt ; $5acd
	farcall ScriptCloseDialogueWindow ; $5ad0
	script_wait_frames $05 ; $5ad3
	and a ; $5ada
	jr z, .done ; $5adb
	script_speak $0a ; $5add
	ret ; $5ae2
.done:
	script_get_actor_state $0a ; $5ae3
	ld e, l ; $5ae8
	ld d, h ; $5ae9
	ld hl, $0005 ; $5aea
	add hl, de ; $5aed
	res 0, [hl] ; $5aee
	res 1, [hl] ; $5af0
	script_set_speed ACTOR_PLAYER, $0020 ; $5af2
	script_set_speed ACTOR_PARTNER, $0020 ; $5afa
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_47 ; $5b02
	script_wait_frames $20 ; $5b0d
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_48 ; $5b14
	script_set_actor_script $0a, ActorScript_12_45 ; $5b1f
	script_set_actor_script $0b, ActorScript_12_46 ; $5b2a
	script_move_player $0a00, $1100 ; $5b35
	farcall WaitPlayerMoveDone ; $5b3f
	script_wait_actor_script ACTOR_PLAYER ; $5b42
	ld hl, wStoryModePlayersXPosition ; $5b47
	ld de, wStoryModeSpawnPosition ; $5b4a
	ld bc, $0005 ; $5b4d
	call CopyMemoryBC ; $5b50
	ld a, $ff ; $5b53
	ld [wStoryModeEntryPoint], a ; $5b55
	ld [wUnusedExitTriggerIdMirror], a ; $5b58
	ld [wStoryModeExitTriggerRequest], a ; $5b5b
	farcall InitStoryMatchSettings ; $5b5e
	load_match_settings $0105 ; $5b61
	farcall RunStoryMatch ; $5b6e
	farcall RestoreOverworldAfterMatch ; $5b71
	ret ; $5b74
SeniorCourtNpc0ATextIds:
	; $5b75, 30 bytes (text_ids)
	dw Text_34_20 ; record 0
	dw Text_34_20 ; record 1
	dw Text_34_44 ; record 2
	dw Text_34_50 ; record 3
	dw Text_34_50 ; record 4
	dw Text_34_50 ; record 5
	dw Text_34_102 ; record 6
	dw Text_34_108 ; record 7
	dw Text_34_108 ; record 8
	dw Text_34_147 ; record 9
	dw Text_34_156 ; record 10
	dw Text_34_164 ; record 11
	dw Text_34_173 ; record 12
	dw Text_34_182 ; record 13
	dw Text_34_191 ; record 14
SeniorCourtNpc0B_12:
	ld a, [wMapSceneStage2] ; $5b93
	add a ; $5b96
	ld_hl_indexed SeniorCourtNpc0BTextIds ; $5b97
	ld a, [hl+] ; $5b9e
	ld h, [hl] ; $5b9f
	ld l, a ; $5ba0
	farcall InitDialogueTextCursor ; $5ba1
	ld a, [wMapSceneStage2] ; $5ba4
	cp SENIORCOURTSTAGE_DOUBLES_ISLAND_OPEN ; $5ba7
	jr c, .speak ; $5ba9
	test_flag FLAG_DOUBLES ; $5bab
	jr z, .speak ; $5bae
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5bb0
	and a ; $5bb3
	jr nz, .speak ; $5bb4
	farcall AdvanceDialogueTextCursor ; $5bb6
.speak:
	script_speak $0b ; $5bb9
	ret ; $5bbe
SeniorCourtNpc0BTextIds:
	; $5bbf, 30 bytes (text_ids)
	dw Text_34_21 ; record 0
	dw Text_34_21 ; record 1
	dw Text_34_45 ; record 2
	dw Text_34_51 ; record 3
	dw Text_34_51 ; record 4
	dw Text_34_51 ; record 5
	dw Text_34_107 ; record 6
	dw Text_34_109 ; record 7
	dw Text_34_109 ; record 8
	dw Text_34_148 ; record 9
	dw Text_34_157 ; record 10
	dw Text_34_165 ; record 11
	dw Text_34_174 ; record 12
	dw Text_34_183 ; record 13
	dw Text_34_174 ; record 14
SeniorCourtNpc0C_12:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5bdd
	or a ; $5be0
	jr nz, .nonZero ; $5be1
	ld a, [wMapSceneStage2] ; $5be3
	add a ; $5be6
	ld_hl_indexed SeniorCourtNpc0C_12Table ; $5be7
	ld a, [hl+] ; $5bee
	ld h, [hl] ; $5bef
	ld l, a ; $5bf0
	farcall InitDialogueTextCursor ; $5bf1
	script_speak $0c ; $5bf4
	ret ; $5bf9
.nonZero:
	ld a, [wMapSceneStage2] ; $5bfa
	add a ; $5bfd
	ld_hl_indexed SeniorCourtNpc0CTextIds ; $5bfe
	ld a, [hl+] ; $5c05
	ld h, [hl] ; $5c06
	ld l, a ; $5c07
	farcall InitDialogueTextCursor ; $5c08
	script_speak $0c ; $5c0b
	ret ; $5c10
SeniorCourtNpc0CTextIds:
	; $5c11, 30 bytes (text_ids)
	dw Text_34_22 ; record 0
	dw Text_34_22 ; record 1
	dw Text_34_46 ; record 2
	dw Text_34_52 ; record 3
	dw Text_34_52 ; record 4
	dw Text_34_52 ; record 5
	dw Text_34_108 ; record 6
	dw Text_34_110 ; record 7
	dw Text_34_110 ; record 8
	dw Text_34_149 ; record 9
	dw Text_34_158 ; record 10
	dw Text_34_166 ; record 11
	dw Text_34_175 ; record 12
	dw Text_34_184 ; record 13
	dw Text_34_186 ; record 14
SeniorCourtNpc0C_12Table:
	INCBIN "data/bank_012/SeniorCourtNpc0C_12Table.bin" ; $5c2f, 30 bytes
SeniorCourtNpcScripts_12:
	; $5c4d, 121 bytes (map_scripts)
	map_script $03, FACEMASK_RIGHT, $0840, SeniorCourtNpc03FaceRight_12, $01, $00
	map_script $03, FACEMASK_UP, $0840, SeniorCourtNpc03FaceUpFlag0840_12, $01, $00
	map_script $03, FACEMASK_UP, $0000, SeniorCourtNpc03FaceUpFlag0000_12, $01, $00
	map_script $03, FACEMASK_ANY, $0000, SeniorCourtNpc03_12, $01, $00
	map_script $04, FACEMASK_ANY, $0000, SeniorCourtNpc04_12, $1b, $00
	map_script $05, FACEMASK_ANY, $0000, SeniorCourtNpc05_12, $13, $00
	map_script $06, FACEMASK_ANY, $08a0, SeniorCourtNpc06_12, $13, $00
	map_script $06, FACEMASK_ANY, $0000, SeniorCourtNpc06_12, $11, $00
	map_script $07, FACEMASK_ANY, $08a0, SeniorCourtNpc07_12, $03, $00
	map_script $07, FACEMASK_ANY, $0000, SeniorCourtNpc07_12, $01, $00
	map_script $08, FACEMASK_ANY, $0000, SeniorCourtNpc08_12, $0b, $00
	map_script $09, FACEMASK_ANY, $0000, SeniorCourtNpc09_12, $13, $00
	map_script $0a, FACEMASK_ANY, $0000, SeniorCourtNpc0A_12, $13, $00
	map_script $0b, FACEMASK_ANY, $0000, SeniorCourtNpc0B_12, $1b, $00
	map_script $0c, FACEMASK_ANY, $0000, SeniorCourtNpc0C_12, $13, $00
	db $ff
SeniorCourtFacingScripts_12:
	ds 1, $ff ; $5cc6, fill
SeniorCourtTileTriggers_12:
	; $5cc7, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0f80, SeniorCourtTile01_12, $00, $00
	db $ff
SeniorCourtTile01_12:
	set_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5cd0
	script_null_script $0a ; $5cd3
	script_null_script $0b ; $5cd8
	script_set_anim $0a, $01 ; $5cdd
	script_set_anim $0b, $01 ; $5ce4
	script_move_target $0a, $1400, $1300 ; $5ceb
	script_move_target $0b, $1400, $0f00 ; $5cf6
	script_wait_move $0a ; $5d01
	script_wait_move $0b ; $5d06
	script_face_toward ACTOR_PLAYER, $0a ; $5d0b
	script_face_toward ACTOR_PLAYER, $0b ; $5d13
	ret ; $5d1b
SeniorCourtInitScript_12:
	call ComputeSeniorCourtStageB ; $5d1c
	call ComputeSeniorCourtStage ; $5d1f
	ld a, [wMapSceneStage2] ; $5d22
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $5d25
	jr nc, .fromMatch ; $5d27
	ld b, $00 ; $5d29
	ld c, $2a ; $5d2b
	ld d, $10 ; $5d2d
	ld e, $0a ; $5d2f
	ld h, $08 ; $5d31
	ld l, $0e ; $5d33
	farcall CopyBehaviorMapRect ; $5d35
	test_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5d38
	jr z, .fromMatch ; $5d3b
	script_null_script $0a ; $5d3d
	script_null_script $0b ; $5d42
	script_set_anim $0a, $01 ; $5d47
	script_set_anim $0b, $01 ; $5d4e
	script_set_position $0a, $1400, $1300 ; $5d55
	script_set_position $0b, $1400, $0f00 ; $5d60
	script_face_toward ACTOR_PLAYER, $0a ; $5d6b
	script_face_toward ACTOR_PLAYER, $0b ; $5d73
.fromMatch:
	test_flag FLAG_DOUBLES ; $5d7b
	jr nz, .done ; $5d7e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5d80
	jr z, .placeActors ; $5d83
	ldh a, [hRomBank] ; $5d85
	ld hl, SeniorCourtActorsA_12 ; $5d87
	farcall ScriptRespawnLocationActors ; $5d8a
.placeActors:
	call SeniorCourtPositionActorsByProgressA ; $5d8d
	call SetPartnerObjDefByGender_12 ; $5d90
	ld a, [wStoryModeEntryPoint] ; $5d93
	cp $0f ; $5d96
	jp z, SeniorCourtPostMatchReturn ; $5d98
	cp $0e ; $5d9b
	jp z, SeniorCourtReloadIntoVictoryScene ; $5d9d
	cp $0d ; $5da0
	jp z, SeniorMatchVictorySceneDispatch ; $5da2
	call SeniorCourtPositionActorsByProgressB ; $5da5
	farcall EndCutsceneScriptMode ; $5da8
	call SeniorCourtWalkPlayersOntoCourt ; $5dab
	ret ; $5dae
.done:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5daf
	jr z, .placeActors ; $5db2
	ldh a, [hRomBank] ; $5db4
	ld hl, SeniorCourtActorsB_12 ; $5db6
	farcall ScriptRespawnLocationActors ; $5db9
	jr .placeActors ; $5dbc
SeniorCourtPositionActorsByProgressB:
	ld a, [wMapSceneStage2] ; $5dbe
	cp SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN ; $5dc1
	jr c, .checkDoubles ; $5dc3
	cp $0d ; $5dc5
	jr nc, .checkDoubles ; $5dc7
	script_get_actor_state $03 ; $5dc9
	ld c, l ; $5dce
	ld b, h ; $5dcf
	ld d, $3b ; $5dd0
	farcall LoadActorObjectDefIfValid ; $5dd2
	script_set_anim $03, $01 ; $5dd5
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5ddc
	jr nz, .doubles ; $5ddf
	ld a, [wMapSceneStage2] ; $5de1
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $5de4
	jr c, .done ; $5de6
	script_set_position $04, $3f00, $3f00 ; $5de8
.done:
	ret ; $5df3
.doubles:
	ld a, [wMapSceneStage2] ; $5df4
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5df7
	jr c, .done ; $5df9
	script_set_position $04, $3f00, $3f00 ; $5dfb
	script_set_position $05, $3f00, $3f00 ; $5e06
	ret ; $5e11
SeniorCourtPositionActorsByProgressA:
	test_flag FLAG_DOUBLES ; $5e12
	jr nz, .isDoubles ; $5e15
	ld a, [wMapSceneStage2] ; $5e17
	cp SENIORCOURTSTAGE_SINGLES_RANK3 ; $5e1a
	jr c, .checkStage9 ; $5e1c
	script_set_position $07, $1b00, $0d00 ; $5e1e
	script_face $07, FACE_LEFT ; $5e29
.checkStage9:
	ld a, [wMapSceneStage2] ; $5e30
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $5e33
	jr c, .done ; $5e35
.done:
	ret ; $5e37
.isDoubles:
	ld a, [wMapSceneStage2] ; $5e38
	cp SENIORCOURTSTAGE_DOUBLES_RANK2 ; $5e3b
	jr c, .checkStage10 ; $5e3d
	cp $09 ; $5e3f
	jr nc, .checkStage10 ; $5e41
	script_set_position $09, $1b00, $0b00 ; $5e43
	script_set_position $08, $1b00, $0d00 ; $5e4e
	script_face $09, FACE_LEFT ; $5e59
	script_face $08, FACE_LEFT ; $5e60
	script_null_script $08 ; $5e67
	script_set_anim $08, $01 ; $5e6c
.checkStage10:
	ld a, [wMapSceneStage2] ; $5e73
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5e76
	jr c, .checkStage9 ; $5e78
	script_set_position $04, $3f00, $3f00 ; $5e7a
	script_set_position $05, $3f00, $3f00 ; $5e85
	ret ; $5e90
SetPartnerObjDefByGender_12:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5e91
	or a ; $5e94
	jr nz, .done ; $5e95
	script_get_actor_state $0c ; $5e97
	ld c, l ; $5e9c
	ld b, h ; $5e9d
	ld d, $28 ; $5e9e
	farcall LoadActorObjectDefIfValid ; $5ea0
	script_set_anim $0c, $01 ; $5ea3
.done:
	ret ; $5eaa
SeniorCourtWalkPlayersOntoCourt:
	ld a, [wStoryModeEntryPoint] ; $5eab
	cp $01 ; $5eae
	jp nz, .done ; $5eb0
	test_flag FLAG_DOUBLES ; $5eb3
	jr z, .walkOff ; $5eb6
	script_set_speed ACTOR_PARTNER, $00ff ; $5eb8
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $5ec0
	script_wait_move ACTOR_PARTNER ; $5eca
	script_face ACTOR_PARTNER, FACE_UP ; $5ecf
	script_set_speed ACTOR_PARTNER, $0010 ; $5ed6
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $5ede
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $5ee6
.done:
	ret ; $5ef0
SeniorRankOfferScenePrep:
	script_set_speed ACTOR_PLAYER, $0010 ; $5ef1
	test_flag FLAG_DOUBLES ; $5ef9
	jp z, SeniorSinglesRankOfferScene ; $5efc
	call SeniorDoublesRankOfferScene ; $5eff
	ret ; $5f02
SeniorRankOfferScenePrepFacingUp:
	script_set_speed ACTOR_PLAYER, $0008 ; $5f03
	script_face ACTOR_PLAYER, FACE_UP ; $5f0b
	script_facing_lock ACTOR_PLAYER, $01 ; $5f12
	test_flag FLAG_DOUBLES ; $5f19
	jr z, SeniorSinglesRankOfferScene ; $5f1c
	call SeniorDoublesRankOfferScene ; $5f1e
	ret ; $5f21
SeniorSinglesRankOfferScene:
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $5f22
	script_wait_move ACTOR_PLAYER ; $5f2d
	script_wait_frames $0a ; $5f32
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $5f39
	script_face_toward $03, ACTOR_PLAYER ; $5f40
	script_face_toward ACTOR_PLAYER, $03 ; $5f48
	script_set_text Text_34_60 ; $5f50
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $5f56
	jr z, .prompt ; $5f59
	farcall AdvanceDialogueTextCursor ; $5f5b
.prompt:
	ld a, $03 ; $5f5e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f60
	farcall RunDialogueYesNoPrompt ; $5f63
	farcall ScriptCloseDialogueWindow ; $5f66
	script_wait_frames $05 ; $5f69
	and a ; $5f70
	jp nz, .done ; $5f71
	script_set_text Text_34_64 ; $5f74
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $5f7a
	jr z, .accepted ; $5f7d
	farcall AdvanceDialogueTextCursor ; $5f7f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $5f82
	jr z, .accepted ; $5f85
	farcall AdvanceDialogueTextCursor ; $5f87
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $5f8a
	jr z, .accepted ; $5f8d
	farcall AdvanceDialogueTextCursor ; $5f8f
.accepted:
	script_speak $03 ; $5f92
	call RunSeniorRankingMatchIntro ; $5f97
	script_face ACTOR_PLAYER, FACE_UP ; $5f9a
	script_wait_frames $0f ; $5fa1
	script_set_anim $03, $02 ; $5fa8
	script_wait_idle $03 ; $5faf
	call SeniorSinglesMatchConfirm ; $5fb4
	ret ; $5fb7
.done:
	script_set_text Text_34_62 ; $5fb8
	script_speak $03 ; $5fbe
	farcall EndCutsceneScriptMode ; $5fc3
	ret ; $5fc6
SeniorDoublesRankOfferScene:
	script_null_script ACTOR_PARTNER ; $5fc7
	script_wait_frames $0a ; $5fcc
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $5fd3
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $5fde
	script_wait_frames $0a ; $5fe9
	script_wait_move ACTOR_PLAYER ; $5ff0
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $5ff5
	script_face_toward $03, ACTOR_PLAYER ; $5ffc
	script_wait_move ACTOR_PARTNER ; $6004
	script_face_toward $03, ACTOR_PARTNER ; $6009
	script_wait_frames $1e ; $6011
	script_face_toward ACTOR_PLAYER, $03 ; $6018
	script_set_text Text_34_110 ; $6020
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $6026
	jr z, .prompt ; $6029
	farcall AdvanceDialogueTextCursor ; $602b
.prompt:
	ld a, $03 ; $602e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6030
	farcall RunDialogueYesNoPrompt ; $6033
	farcall ScriptCloseDialogueWindow ; $6036
	script_wait_frames $05 ; $6039
	and a ; $6040
	jp nz, .setText ; $6041
	script_set_text Text_34_113 ; $6044
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $604a
	jr z, .accepted ; $604d
	farcall AdvanceDialogueTextCursor ; $604f
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $6052
	jr z, .accepted ; $6055
	farcall AdvanceDialogueTextCursor ; $6057
.accepted:
	script_speak $03 ; $605a
	call RunSeniorRankingMatchIntro ; $605f
	script_face ACTOR_PLAYER, FACE_UP ; $6062
	script_face ACTOR_PARTNER, FACE_UP ; $6069
	script_wait_frames $0f ; $6070
	script_set_anim $03, $02 ; $6077
	script_wait_idle $03 ; $607e
	call SeniorDoublesMatchConfirm ; $6083
	ret ; $6086
.setText:
	script_set_text Text_34_112 ; $6087
	script_speak $03 ; $608d
	script_get_actor_state ACTOR_PARTNER ; $6092
	ld c, l ; $6097
	ld b, h ; $6098
	ld de, wActors ; $6099
	farcall AttachActorStepMover ; $609c
	ret ; $609f
StartSeniorRankingMatch:
	script_set_speed ACTOR_PLAYER, $0020 ; $60a0
	script_set_speed ACTOR_PARTNER, $0020 ; $60a8
	ld a, [wMapSceneStage2] ; $60b0
	sub $02 ; $60b3
	rst Rst00 ; $60b5
	dw StartSeniorRankingMatch.rank4 ; $60b6 jumptable
	dw StartSeniorRankingMatch.rank5 ; $60b8 jumptable
	dw StartSeniorRankingMatch.rank6 ; $60ba jumptable
	dw StartSeniorRankingMatch.rank7 ; $60bc jumptable
	dw StartSeniorRankingMatch.rank1 ; $60be jumptable
	dw StartSeniorRankingMatch.rank2 ; $60c0 jumptable
	dw StartSeniorRankingMatch.rank3 ; $60c2 jumptable
.rank1:
	script_face $03, FACE_LEFT ; $60c4
	script_wait_frames $0f ; $60cb
	script_set_actor_script $09, ActorScript_12_26 ; $60d2
	script_set_actor_script $08, ActorScript_12_22 ; $60dd
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_15 ; $60e8
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $60f3
	script_move_player $2400, $1700 ; $60fe
	farcall WaitPlayerMoveDone ; $6108
	script_wait_actor_script $08 ; $610b
	script_wait_frames $1e ; $6110
	ld a, $0f ; $6117
	ld [wUnusedExitTriggerIdMirror], a ; $6119
	ld [wStoryModeExitTriggerRequest], a ; $611c
	farcall InitStoryMatchSettings ; $611f
	load_match_settings $0107 ; $6122
	farcall RunStoryMatch ; $612f
	farcall RestoreOverworldAfterMatch ; $6132
	ret ; $6135
.rank2:
	script_face $03, FACE_RIGHT ; $6136
	script_wait_frames $0f ; $613d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6144
	script_face ACTOR_PARTNER, FACE_RIGHT ; $614b
	script_face $07, FACE_RIGHT ; $6152
	script_face $06, FACE_RIGHT ; $6159
	call ApproachSeniorCourtPairB ; $6160
	script_set_actor_script $06, ActorScript_12_31 ; $6163
	script_set_actor_script $07, ActorScript_12_32 ; $616e
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_16 ; $6179
	farcall WaitPlayerMoveDone ; $6184
	script_wait_actor_script $07 ; $6187
	script_wait_frames $1e ; $618c
	ld a, $0f ; $6193
	ld [wUnusedExitTriggerIdMirror], a ; $6195
	ld [wStoryModeExitTriggerRequest], a ; $6198
	farcall InitStoryMatchSettings ; $619b
	load_match_settings $0108 ; $619e
	farcall RunStoryMatch ; $61ab
	farcall RestoreOverworldAfterMatch ; $61ae
	ret ; $61b1
.rank3:
	script_face $03, FACE_LEFT ; $61b2
	script_wait_frames $0f ; $61b9
	script_face ACTOR_PLAYER, FACE_LEFT ; $61c0
	script_face $07, FACE_LEFT ; $61c7
	script_set_actor_script $05, ActorScript_12_39 ; $61ce
	script_set_actor_script $04, ActorScript_12_40 ; $61d9
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_15 ; $61e4
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $61ef
	script_move_player $2400, $1700 ; $61fa
	farcall WaitPlayerMoveDone ; $6204
	script_wait_actor_script $04 ; $6207
	script_wait_frames $1e ; $620c
	ld a, $0f ; $6213
	ld [wUnusedExitTriggerIdMirror], a ; $6215
	ld [wStoryModeExitTriggerRequest], a ; $6218
	farcall InitStoryMatchSettings ; $621b
	load_match_settings $0109 ; $621e
	farcall RunStoryMatch ; $622b
	farcall RestoreOverworldAfterMatch ; $622e
	ret ; $6231
.rank4:
	script_face $03, FACE_LEFT ; $6232
	script_wait_frames $0f ; $6239
	script_face ACTOR_PLAYER, FACE_LEFT ; $6240
	script_face $07, FACE_LEFT ; $6247
	call ApproachSeniorCourtPairA ; $624e
	script_set_actor_script $07, ActorScript_12_01 ; $6251
	farcall WaitPlayerMoveDone ; $625c
	script_wait_actor_script $07 ; $625f
	script_wait_frames $1e ; $6264
	ld a, $0f ; $626b
	ld [wUnusedExitTriggerIdMirror], a ; $626d
	ld [wStoryModeExitTriggerRequest], a ; $6270
	farcall InitStoryMatchSettings ; $6273
	load_match_settings $0006 ; $6276
	farcall RunStoryMatch ; $6283
	farcall RestoreOverworldAfterMatch ; $6286
	ret ; $6289
.rank5:
	script_face $03, FACE_RIGHT ; $628a
	script_wait_frames $0f ; $6291
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6298
	script_face $06, FACE_RIGHT ; $629f
	script_wait_frames $1e ; $62a6
	call ApproachSeniorCourtPairB ; $62ad
	script_set_actor_script $06, ActorScript_12_05 ; $62b0
	farcall WaitPlayerMoveDone ; $62bb
	script_wait_actor_script $06 ; $62be
	script_wait_frames $1e ; $62c3
	ld a, $0f ; $62ca
	ld [wUnusedExitTriggerIdMirror], a ; $62cc
	ld [wStoryModeExitTriggerRequest], a ; $62cf
	farcall InitStoryMatchSettings ; $62d2
	load_match_settings $0007 ; $62d5
	farcall RunStoryMatch ; $62e2
	farcall RestoreOverworldAfterMatch ; $62e5
	ret ; $62e8
.rank6:
	script_face $03, FACE_RIGHT ; $62e9
	script_wait_frames $0f ; $62f0
	script_face ACTOR_PLAYER, FACE_RIGHT ; $62f7
	script_face $05, FACE_RIGHT ; $62fe
	script_wait_frames $1e ; $6305
	call ApproachSeniorCourtPairB ; $630c
	script_set_actor_script $05, ActorScript_12_05 ; $630f
	farcall WaitPlayerMoveDone ; $631a
	script_wait_frames $78 ; $631d
	script_wait_move ACTOR_PLAYER ; $6324
	ld a, $0f ; $6329
	ld [wUnusedExitTriggerIdMirror], a ; $632b
	ld [wStoryModeExitTriggerRequest], a ; $632e
	farcall InitStoryMatchSettings ; $6331
	load_match_settings $0008 ; $6334
	farcall RunStoryMatch ; $6341
	farcall RestoreOverworldAfterMatch ; $6344
	ret ; $6347
.rank7:
	script_face $03, FACE_LEFT ; $6348
	script_wait_frames $0f ; $634f
	script_face ACTOR_PLAYER, FACE_LEFT ; $6356
	script_face $04, FACE_LEFT ; $635d
	script_wait_frames $1e ; $6364
	call ApproachSeniorCourtPairA ; $636b
	script_set_actor_script $04, ActorScript_12_01 ; $636e
	farcall WaitPlayerMoveDone ; $6379
	script_wait_frames $b4 ; $637c
	ld a, $0f ; $6383
	ld [wUnusedExitTriggerIdMirror], a ; $6385
	ld [wStoryModeExitTriggerRequest], a ; $6388
	farcall InitStoryMatchSettings ; $638b
	load_match_settings $0009 ; $638e
	farcall RunStoryMatch ; $639b
	farcall RestoreOverworldAfterMatch ; $639e
	ret ; $63a1
ApproachSeniorCourtPairA:
	script_set_actor_script $0d, ActorScript_12_17 ; $63a2
	script_set_actor_script $0e, ActorScript_12_18 ; $63ad
	script_wait_actor_script $0e ; $63b8
	script_move_player $2400, $1700 ; $63bd
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $63c7
	ret ; $63d2
ApproachSeniorCourtPairB:
	script_set_actor_script $0f, ActorScript_12_19 ; $63d3
	script_set_actor_script $10, ActorScript_12_20 ; $63de
	script_wait_actor_script $0f ; $63e9
	script_move_player $3500, $1700 ; $63ee
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_14 ; $63f8
	ret ; $6403
PlaceSeniorCourtPairA:
	script_null_script $0d ; $6404
	script_null_script $0e ; $6409
	script_set_position $0d, $2900, $1300 ; $640e
	script_set_position $0e, $2900, $1900 ; $6419
	script_face $0d, FACE_LEFT ; $6424
	script_face $0e, FACE_LEFT ; $642b
	ret ; $6432
PlaceSeniorCourtPairB:
	script_null_script $0f ; $6433
	script_null_script $10 ; $6438
	script_set_position $0f, $3900, $1300 ; $643d
	script_set_position $10, $3900, $1900 ; $6448
	script_face $0f, FACE_LEFT ; $6453
	script_face $10, FACE_LEFT ; $645a
	script_wait_frames $14 ; $6461
	ret ; $6468
StartSeniorCourtPairARally:
	script_move_target $0d, $2200, $1100 ; $6469
	script_move_target $0e, $2500, $1d00 ; $6474
	script_wait_move $0d ; $647f
	script_wait_move $0e ; $6484
	script_set_actor_script $0d, ActorScript_12_53 ; $6489
	script_set_actor_script $0e, ActorScript_12_54 ; $6494
	ret ; $649f
StartSeniorCourtPairBRally:
	script_move_target $0f, $3200, $1100 ; $64a0
	script_move_target $10, $3600, $1d00 ; $64ab
	script_wait_move $0f ; $64b6
	script_wait_move $10 ; $64bb
	script_face $10, FACE_UP ; $64c0
	script_set_actor_script $0f, ActorScript_12_55 ; $64c7
	script_set_actor_script $10, ActorScript_12_56 ; $64d2
	ret ; $64dd
RunSeniorRankingMatchIntro:
	ld a, [wMapSceneStage2] ; $64de
	sub $02 ; $64e1
	add a ; $64e3
	ld_hl_indexed SeniorRankingMatchIntroPtrs ; $64e4
	ld a, [hl+] ; $64eb
	ld h, [hl] ; $64ec
	ld l, a ; $64ed
	call JumpToHL ; $64ee
	ret ; $64f1
SeniorRankingMatchIntroPtrs:
	; $64f2, 14 bytes (records:2)
	dw SeniorSinglesRank4Intro ; record 0
	dw SeniorSinglesRank3Intro ; record 1
	dw SeniorSinglesRank2Intro ; record 2
	dw SeniorSinglesRank1Intro ; record 3
	dw SeniorDoublesRank3Intro ; record 4
	dw SeniorDoublesRank2Intro ; record 5
	dw SeniorDoublesRank1Intro ; record 6
SeniorDoublesRank3Intro:
	script_wait_frames $0f ; $6500
	script_face_toward $09, $03 ; $6507
	script_wait_frames $1e ; $650f
	script_face_toward $09, ACTOR_PLAYER ; $6516
	script_face_toward $09, ACTOR_PARTNER ; $651e
	script_wait_frames $1e ; $6526
	script_player_speed $0020 ; $652d
	script_move_player_to_actor $09 ; $6533
	farcall WaitPlayerMoveDone ; $653a
	ld bc, wActors + 1 * ACTOR_SIZE ; $653d
	script_get_actor_state $09 ; $6540
	ld e, l ; $6545
	ld d, h ; $6546
	farcall AttachActorWaypointFollower ; $6547
	script_face_toward $03, $09 ; $654a
	script_null_script $08 ; $6552
	script_set_anim $08, $01 ; $6557
	script_face_toward $03, $08 ; $655e
	script_set_anim $09, $03 ; $6566
	script_wait_idle $09 ; $656d
	script_set_actor_script $09, ActorScript_12_21 ; $6572
	script_set_actor_script $08, ActorScript_12_25 ; $657d
	script_face $03, FACE_DOWN ; $6588
	script_wait_actor_script $09 ; $658f
	script_null_script ACTOR_PLAYER_SHADOW ; $6594
	script_move_player_to_actor ACTOR_PLAYER ; $6599
	farcall WaitPlayerMoveDone ; $65a0
	script_face_toward $09, ACTOR_PLAYER ; $65a3
	script_set_text Text_34_126 ; $65ab
	script_set_anim $08, $03 ; $65b1
	script_wait_idle $08 ; $65b8
	script_speak $08 ; $65bd
	script_set_anim $09, $03 ; $65c2
	script_wait_idle $09 ; $65c9
	script_speak $09 ; $65ce
	script_face $09, FACE_UP ; $65d3
	script_face $08, FACE_UP ; $65da
	script_face ACTOR_PARTNER, FACE_UP ; $65e1
	ret ; $65e8
SeniorDoublesRank2Intro:
	script_wait_frames $0f ; $65e9
	script_face_toward $06, $03 ; $65f0
	script_wait_frames $1e ; $65f8
	script_face_toward $07, ACTOR_PLAYER ; $65ff
	script_face_toward $06, ACTOR_PARTNER ; $6607
	script_wait_frames $1e ; $660f
	script_player_speed $0020 ; $6616
	script_move_player_to_actor $07 ; $661c
	farcall WaitPlayerMoveDone ; $6623
	ld bc, wActors + 1 * ACTOR_SIZE ; $6626
	script_get_actor_state $07 ; $6629
	ld e, l ; $662e
	ld d, h ; $662f
	farcall AttachActorWaypointFollower ; $6630
	script_face_toward $03, $07 ; $6633
	script_set_anim $07, $03 ; $663b
	script_wait_idle $07 ; $6642
	script_set_actor_script $07, ActorScript_12_29 ; $6647
	script_set_actor_script $06, ActorScript_12_30 ; $6652
	script_face $03, FACE_DOWN ; $665d
	script_wait_actor_script $07 ; $6664
	script_null_script ACTOR_PLAYER_SHADOW ; $6669
	script_move_player_to_actor ACTOR_PLAYER ; $666e
	farcall WaitPlayerMoveDone ; $6675
	script_set_text Text_34_124 ; $6678
	script_set_anim $06, $03 ; $667e
	script_wait_idle $06 ; $6685
	script_speak $06 ; $668a
	script_set_anim $07, $03 ; $668f
	script_wait_idle $07 ; $6696
	script_speak $07 ; $669b
	script_face $07, FACE_UP ; $66a0
	script_face $06, FACE_UP ; $66a7
	ret ; $66ae
SeniorDoublesRank1Intro:
	script_wait_frames $0f ; $66af
	script_face_toward $05, $03 ; $66b6
	script_wait_frames $1e ; $66be
	script_face_toward $04, ACTOR_PLAYER ; $66c5
	script_face_toward $05, ACTOR_PARTNER ; $66cd
	script_null_script $04 ; $66d5
	script_set_anim $04, $01 ; $66da
	script_wait_frames $1e ; $66e1
	script_player_speed $0020 ; $66e8
	script_null_script $04 ; $66ee
	script_face $04, FACE_DOWN ; $66f3
	script_move_target $05, $2b00, $1100 ; $66fa
	script_move_player_to_actor $05 ; $6705
	farcall WaitPlayerMoveDone ; $670c
	script_face $05, FACE_DOWN ; $670f
	script_face_toward $03, $05 ; $6716
	script_set_anim $05, $03 ; $671e
	script_wait_idle $05 ; $6725
	script_set_actor_script $05, ActorScript_12_37 ; $672a
	script_wait_frames $0f ; $6735
	script_move_player_to_actor ACTOR_PLAYER ; $673c
	script_set_actor_script $04, ActorScript_12_38 ; $6743
	script_face $03, FACE_DOWN ; $674e
	script_wait_actor_script $04 ; $6755
	script_face_toward $04, ACTOR_PLAYER ; $675a
	script_face_toward $05, ACTOR_PARTNER ; $6762
	script_set_text Text_34_122 ; $676a
	script_set_anim $04, $03 ; $6770
	script_wait_idle $04 ; $6777
	script_speak $04 ; $677c
	script_set_anim $05, $03 ; $6781
	script_wait_idle $05 ; $6788
	script_speak $05 ; $678d
	script_face $05, FACE_UP ; $6792
	script_face $04, FACE_UP ; $6799
	ret ; $67a0
SeniorSinglesRank4Intro:
	script_wait_frames $0f ; $67a1
	script_face_toward $07, $03 ; $67a8
	script_wait_frames $1e ; $67b0
	script_face_toward $07, ACTOR_PLAYER ; $67b7
	script_wait_frames $1e ; $67bf
	script_player_speed $0020 ; $67c6
	script_move_player_to_actor $07 ; $67cc
	farcall WaitPlayerMoveDone ; $67d3
	ld bc, wActors + 1 * ACTOR_SIZE ; $67d6
	script_get_actor_state $07 ; $67d9
	ld e, l ; $67de
	ld d, h ; $67df
	farcall AttachActorWaypointFollower ; $67e0
	script_face_toward $03, $07 ; $67e3
	script_set_anim $07, $03 ; $67eb
	script_wait_idle $07 ; $67f2
	script_set_actor_script $07, ActorScript_12_00 ; $67f7
	script_face $03, FACE_DOWN ; $6802
	script_wait_actor_script $07 ; $6809
	script_null_script ACTOR_PLAYER_SHADOW ; $680e
	script_face_toward $07, ACTOR_PLAYER ; $6813
	script_set_anim $07, $02 ; $681b
	script_wait_idle $07 ; $6822
	script_set_anim $07, $03 ; $6827
	script_wait_idle $07 ; $682e
	script_face $07, FACE_UP ; $6833
	ret ; $683a
SeniorSinglesRank3Intro:
	script_wait_frames $0f ; $683b
	script_face_toward $06, $03 ; $6842
	script_wait_frames $1e ; $684a
	script_face_toward $06, ACTOR_PLAYER ; $6851
	script_wait_frames $1e ; $6859
	script_player_speed $0020 ; $6860
	script_move_player_to_actor $06 ; $6866
	farcall WaitPlayerMoveDone ; $686d
	ld bc, wActors + 1 * ACTOR_SIZE ; $6870
	script_get_actor_state $06 ; $6873
	ld e, l ; $6878
	ld d, h ; $6879
	farcall AttachActorWaypointFollower ; $687a
	script_face_toward $03, $06 ; $687d
	script_set_anim $06, $03 ; $6885
	script_wait_idle $06 ; $688c
	script_set_actor_script $06, ActorScript_12_04 ; $6891
	script_face $03, FACE_DOWN ; $689c
	script_move_player_to_actor ACTOR_PLAYER ; $68a3
	script_wait_actor_script $06 ; $68aa
	script_null_script ACTOR_PLAYER_SHADOW ; $68af
	script_face_pair ACTOR_PLAYER, $06 ; $68b4
	script_set_anim $06, $02 ; $68bc
	script_wait_idle $06 ; $68c3
	script_set_text Text_34_58 ; $68c8
	script_speak $06 ; $68ce
	script_set_anim $06, $03 ; $68d3
	script_wait_idle $06 ; $68da
	script_speak $06 ; $68df
	script_wait_frames $0f ; $68e4
	script_face $06, FACE_UP ; $68eb
	ret ; $68f2
SeniorSinglesRank2Intro:
	script_wait_frames $0f ; $68f3
	script_face_toward $05, $03 ; $68fa
	script_wait_frames $1e ; $6902
	script_face_toward $05, ACTOR_PLAYER ; $6909
	script_wait_frames $1e ; $6911
	script_player_speed $0020 ; $6918
	script_move_player_to_actor $05 ; $691e
	farcall WaitPlayerMoveDone ; $6925
	ld bc, wActors + 1 * ACTOR_SIZE ; $6928
	script_get_actor_state $05 ; $692b
	ld e, l ; $6930
	ld d, h ; $6931
	farcall AttachActorWaypointFollower ; $6932
	script_face_toward $03, $05 ; $6935
	script_set_anim $05, $03 ; $693d
	script_wait_idle $05 ; $6944
	script_set_actor_script $05, ActorScript_12_08 ; $6949
	script_face $03, FACE_DOWN ; $6954
	script_null_script ACTOR_PLAYER_SHADOW ; $695b
	script_move_player_to_actor ACTOR_PLAYER ; $6960
	farcall WaitPlayerMoveDone ; $6967
	script_face_toward ACTOR_PLAYER, $05 ; $696a
	script_set_anim $05, $02 ; $6972
	script_wait_idle $05 ; $6979
	script_set_text Text_34_56 ; $697e
	script_speak $05 ; $6984
	script_set_anim $05, $03 ; $6989
	script_wait_idle $05 ; $6990
	script_speak $05 ; $6995
	script_wait_frames $0f ; $699a
	script_face $05, FACE_UP ; $69a1
	ret ; $69a8
SeniorSinglesRank1Intro:
	script_wait_frames $0f ; $69a9
	script_face_toward $04, $03 ; $69b0
	script_wait_frames $1e ; $69b8
	script_face_toward $04, ACTOR_PLAYER ; $69bf
	script_wait_frames $1e ; $69c7
	script_player_speed $0020 ; $69ce
	script_move_player_to_actor $04 ; $69d4
	farcall WaitPlayerMoveDone ; $69db
	script_face_toward $03, $04 ; $69de
	script_set_anim $04, $03 ; $69e6
	script_wait_idle $04 ; $69ed
	script_set_actor_script $04, ActorScript_12_11 ; $69f2
	script_face $03, FACE_DOWN ; $69fd
	script_move_player_to_actor ACTOR_PLAYER ; $6a04
	farcall WaitPlayerMoveDone ; $6a0b
	script_face_toward ACTOR_PLAYER, $04 ; $6a0e
	script_set_text Text_34_54 ; $6a16
	script_speak $04 ; $6a1c
	script_set_anim $04, $03 ; $6a21
	script_wait_idle $04 ; $6a28
	script_speak $04 ; $6a2d
	script_wait_frames $0f ; $6a32
	script_face $04, FACE_UP ; $6a39
	ret ; $6a40
ResumeSeniorOpponentScripts:
	ld a, [wMapSceneStage2] ; $6a41
	sub $02 ; $6a44
	add a ; $6a46
	ld_hl_indexed ResumeSeniorOpponentScriptsPtrs ; $6a47
	ld a, [hl+] ; $6a4e
	ld h, [hl] ; $6a4f
	ld l, a ; $6a50
	call JumpToHL ; $6a51
	ret ; $6a54
ResumeSeniorOpponentScriptsPtrs:
	; $6a55, 14 bytes (records:2)
	dw ResumeSeniorSinglesRank4Opponents ; record 0
	dw ResumeSeniorSinglesRank3Opponents ; record 1
	dw ResumeSeniorSinglesRank2Opponents ; record 2
	dw ResumeSeniorSinglesRank1Opponents ; record 3
	dw ResumeSeniorDoublesRank3Opponents ; record 4
	dw ResumeSeniorDoublesRank2Opponents ; record 5
	dw ResumeSeniorDoublesRank1Opponents ; record 6
ResumeSeniorDoublesRank3Opponents:
	script_set_actor_script $09, ActorScript_12_23 ; $6a63
	script_set_actor_script $08, ActorScript_12_27 ; $6a6e
	ret ; $6a79
ResumeSeniorDoublesRank2Opponents:
	script_set_actor_script $07, ActorScript_12_33 ; $6a7a
	script_set_actor_script $06, ActorScript_12_34 ; $6a85
	ret ; $6a90
ResumeSeniorDoublesRank1Opponents:
	script_set_actor_script $05, ActorScript_12_41 ; $6a91
	script_set_actor_script $04, ActorScript_12_42 ; $6a9c
	script_wait_actor_script $05 ; $6aa7
	script_set_actor_script $05, ActorScript_12_57 ; $6aac
	ret ; $6ab7
ResumeSeniorSinglesRank4Opponents:
	script_set_actor_script $07, ActorScript_12_02 ; $6ab8
	ret ; $6ac3
ResumeSeniorSinglesRank3Opponents:
	script_set_actor_script $06, ActorScript_12_06 ; $6ac4
	ret ; $6acf
ResumeSeniorSinglesRank2Opponents:
	script_set_actor_script $05, ActorScript_12_09 ; $6ad0
	ret ; $6adb
ResumeSeniorSinglesRank1Opponents:
	script_set_actor_script $04, ActorScript_12_12 ; $6adc
	ret ; $6ae7
SeniorSinglesMatchConfirm:
	script_set_text Text_34_68 ; $6ae8
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $6aee
	jr z, .prompt ; $6af1
	farcall AdvanceDialogueTextCursor ; $6af3
.prompt:
	ld a, $03 ; $6af6
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6af8
	farcall RunDialogueYesNoPrompt ; $6afb
	farcall ScriptCloseDialogueWindow ; $6afe
	script_wait_frames $05 ; $6b01
	and a ; $6b08
	jp nz, .done ; $6b09
	script_set_anim $03, $03 ; $6b0c
	script_wait_idle $03 ; $6b13
.declined:
	script_set_anim $03, $03 ; $6b18
	script_wait_idle $03 ; $6b1f
	script_set_text Text_34_70 ; $6b24
	script_speak $03 ; $6b2a
	call StartSeniorRankingMatch ; $6b2f
	farcall EndCutsceneScriptMode ; $6b32
	ret ; $6b35
.accepted:
	script_set_text Text_34_72 ; $6b36
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $6b3c
	jr z, .startMatch ; $6b3f
	farcall AdvanceDialogueTextCursor ; $6b41
.startMatch:
	script_speak $03 ; $6b44
	call ResumeSeniorOpponentScripts ; $6b49
	script_wait_frames $1e ; $6b4c
	farcall EndCutsceneScriptMode ; $6b53
	ret ; $6b56
.done:
	script_set_text Text_34_71 ; $6b57
	ld a, $03 ; $6b5d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b5f
	farcall RunDialogueYesNoPrompt ; $6b62
	farcall ScriptCloseDialogueWindow ; $6b65
	script_wait_frames $05 ; $6b68
	and a ; $6b6f
	jr z, .accepted ; $6b70
	jp .declined ; $6b72
	ret ; $6b75
SeniorDoublesMatchConfirm:
	script_set_text Text_34_116 ; $6b76
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $6b7c
	jr z, .prompt ; $6b7f
	farcall AdvanceDialogueTextCursor ; $6b81
.prompt:
	ld a, $03 ; $6b84
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b86
	farcall RunDialogueYesNoPrompt ; $6b89
	farcall ScriptCloseDialogueWindow ; $6b8c
	script_wait_frames $05 ; $6b8f
	and a ; $6b96
	jp nz, .done ; $6b97
	script_set_anim $03, $03 ; $6b9a
	script_wait_idle $03 ; $6ba1
	script_set_anim $03, $03 ; $6ba6
	script_wait_idle $03 ; $6bad
	script_set_text Text_34_118 ; $6bb2
	script_speak $03 ; $6bb8
.declined:
	call StartSeniorRankingMatch ; $6bbd
	farcall EndCutsceneScriptMode ; $6bc0
	ret ; $6bc3
.accepted:
	script_speak $03 ; $6bc4
	call ResumeSeniorOpponentScripts ; $6bc9
	script_wait_frames $1e ; $6bcc
	script_get_actor_state ACTOR_PARTNER ; $6bd3
	ld c, l ; $6bd8
	ld b, h ; $6bd9
	ld de, wActors ; $6bda
	farcall AttachActorStepMover ; $6bdd
	farcall EndCutsceneScriptMode ; $6be0
	ret ; $6be3
.done:
	script_set_text Text_34_119 ; $6be4
	ld a, $03 ; $6bea
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6bec
	farcall RunDialogueYesNoPrompt ; $6bef
	farcall ScriptCloseDialogueWindow ; $6bf2
	script_wait_frames $05 ; $6bf5
	and a ; $6bfc
	jr z, .accepted ; $6bfd
	script_set_text Text_34_121 ; $6bff
	script_speak $03 ; $6c05
	jp .declined ; $6c0a
ActorScript_12_00:
	; $6c0d, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_01:
	; $6c18, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_02:
	; $6c29, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2b00, $1100
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_03:
	; $6c3a, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_04:
	; $6c51, 17 bytes (actor_script)
	as_set_target $2f00, $1300
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_05:
	; $6c62, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $3300, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_06:
	; $6c73, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $2f00, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_07:
	; $6c84, 17 bytes (actor_script)
	as_set_target $2d00, $0f00
	as_wait_move
	as_set_target $2d00, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_08:
	; $6c95, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_09:
	; $6cac, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_10:
	; $6cc3, 23 bytes (actor_script)
	as_set_target $3900, $0f00
	as_wait_move
	as_set_target $3b00, $1700
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_11:
	; $6cda, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_12:
	; $6ce5, 7 bytes (actor_script)
	as_set_target $2900, $1b00
	as_wait_move
	as_halt
ActorScript_12_13:
	; $6cec, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $2500, $1f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_14:
	; $6cfd, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $3700, $1f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_15:
	; $6d0e, 17 bytes (actor_script)
	as_set_target $2900, $1f00
	as_wait_move
	as_set_target $2300, $1c00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_16:
	; $6d1f, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $3300, $1b00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_17:
	; $6d30, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $2900, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_18:
	; $6d3f, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $2900, $1900
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_19:
	; $6d4e, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $3900, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_20:
	; $6d5d, 45 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $3900, $1900
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
	as_anim $01
	as_wait $0a
	as_set_target $0500, $0b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
	as_anim $01
	as_wait $0a
	as_set_target $0500, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
SeniorCourtReloadIntoVictoryScene:
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $6d8a
	ld [wStoryModeCurrentLocation], a ; $6d8c
	ld a, $0d ; $6d8f
	ld [wStoryModeEntryPoint], a ; $6d91
	ld a, $ff ; $6d94
	ld [wUnusedExitTriggerIdMirror], a ; $6d96
	ld [wStoryModeExitTriggerRequest], a ; $6d99
	farcall StubNop_1e ; $6d9c
	ret ; $6d9f
SeniorCourtPostMatchReturn:
	wram_bank $04 ; $6da0
	ld a, [wMatchExitRequest] ; $6da6
	cp $01 ; $6da9
	jr z, .eq01 ; $6dab
	ld a, [wMatchWinLoseFlag] ; $6dad
	cp WINLOSE_WIN ; $6db0
	jp z, SeniorMatchVictorySceneDispatch ; $6db2
.eq01:
	script_player_speed $0040 ; $6db5
	script_move_player $2d00, $1b00 ; $6dbb
	script_set_position ACTOR_PLAYER, $2d00, $1b00 ; $6dc5
	script_face ACTOR_PLAYER, FACE_UP ; $6dd0
	script_set_position ACTOR_PARTNER, $2d00, $1d00 ; $6dd7
	script_face ACTOR_PARTNER, FACE_UP ; $6de2
	farcall WaitPlayerMoveDone ; $6de9
	ret ; $6dec
SeniorMatchVictorySceneDispatch:
	xor a ; $6ded
	ld [wStoryModeShowLocationName], a ; $6dee
	script_null_script ACTOR_PLAYER_SHADOW ; $6df1
	ld a, [wMapSceneStage2] ; $6df6
	sub $02 ; $6df9
	add a ; $6dfb
	ld_hl_indexed SeniorMatchVictorySceneDispatchPtrs ; $6dfc
	ld a, [hl+] ; $6e03
	ld h, [hl] ; $6e04
	ld l, a ; $6e05
	call JumpToHL ; $6e06
	call ComputeSeniorCourtStage ; $6e09
	ret ; $6e0c
SeniorMatchVictorySceneDispatchPtrs:
	; $6e0d, 18 bytes (records:2)
	dw SeniorSinglesRank4And3Victory ; record 0
	dw SeniorSinglesRank4And3Victory ; record 1
	dw SeniorSinglesRank2Victory ; record 2
	dw SeniorSinglesRank1Victory ; record 3
	dw SeniorSharedVictoryScene ; record 4
	dw SeniorDoublesRank2Victory ; record 5
	dw SeniorDoublesRank1Victory ; record 6
	dw SeniorSharedVictoryScene ; record 7
	dw IslandOpenDoublesVictory ; record 8
SeniorDoublesRank2Victory:
	script_null_script ACTOR_PARTNER ; $6e1f
	script_null_script $08 ; $6e24
	script_face $03, FACE_LEFT ; $6e29
	script_set_position $08, $2500, $1300 ; $6e30
	script_face $08, FACE_DOWN ; $6e3b
	script_set_position $09, $2300, $0f00 ; $6e42
	script_face $09, FACE_DOWN ; $6e4d
	script_set_text Text_34_128 ; $6e54
	script_set_position ACTOR_PLAYER, $2500, $1b00 ; $6e5a
	script_set_position ACTOR_PARTNER, $2300, $1b00 ; $6e65
	script_face ACTOR_PLAYER, FACE_UP ; $6e70
	script_face ACTOR_PARTNER, FACE_UP ; $6e77
	script_player_speed $0040 ; $6e7e
	script_move_player $2600, $1700 ; $6e84
	farcall WaitPlayerMoveDone ; $6e8e
	script_fade_in $08 ; $6e91
	call WaitFadeEnd ; $6e96
	script_wait_frames $3c ; $6e99
	script_move_target $09, $2300, $1300 ; $6ea0
	script_wait_move $09 ; $6eab
	script_face_pair $09, $08 ; $6eb0
	script_wait_frames $14 ; $6eb8
	script_set_position $11, $2400, $1180 ; $6ebf
	sound $96 ; $6eca
	script_wait_frames $1e ; $6ecc
	script_set_anim $08, $04 ; $6ed3
	script_wait_idle $08 ; $6eda
	script_set_position $11, $3f00, $3f00 ; $6edf
	script_jump_velocity $03, $ff80 ; $6eea
	ld a, $03 ; $6ef2
	farcall ScriptWaitActorJumpDone ; $6ef4
	script_speak $03 ; $6ef7
	script_set_actor_script $08, ActorScript_12_28 ; $6efc
	script_set_actor_script $09, ActorScript_12_24 ; $6f07
	script_wait_frames $3c ; $6f12
	script_move_target $03, $2d00, $1900 ; $6f19
	script_move_player $2d00, $1b00 ; $6f24
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $6f2e
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $6f39
	script_wait_frames $3c ; $6f44
	script_face $03, FACE_DOWN ; $6f4b
	script_face ACTOR_PLAYER, FACE_DOWN ; $6f52
	script_get_actor_state ACTOR_PARTNER ; $6f59
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, wActors ; $6f60
	farcall AttachActorStepMover ; $6f63
	farcall EndCutsceneScriptMode ; $6f66
	ret ; $6f69
SeniorDoublesRank1Victory:
	script_null_script ACTOR_PARTNER ; $6f6a
	script_face $03, FACE_RIGHT ; $6f6f
	script_set_position $07, $3300, $1100 ; $6f76
	script_face $07, FACE_DOWN ; $6f81
	script_set_position $06, $3500, $1300 ; $6f88
	script_face $06, FACE_DOWN ; $6f93
	script_set_position ACTOR_PLAYER, $3300, $1b00 ; $6f9a
	script_set_position ACTOR_PARTNER, $3500, $1b00 ; $6fa5
	script_face ACTOR_PLAYER, FACE_UP ; $6fb0
	script_face ACTOR_PARTNER, FACE_UP ; $6fb7
	call FadeInSeniorCourtNearPairB ; $6fbe
	script_set_text Text_34_129 ; $6fc1
	script_wait_frames $28 ; $6fc7
	script_set_anim $07, $02 ; $6fce
	script_wait_idle $07 ; $6fd5
	script_wait_frames $14 ; $6fda
	script_jump_velocity $03, $ff80 ; $6fe1
	ld a, $03 ; $6fe9
	farcall ScriptWaitActorJumpDone ; $6feb
	script_jump_velocity $03, $ff80 ; $6fee
	ld a, $03 ; $6ff6
	farcall ScriptWaitActorJumpDone ; $6ff8
	script_speak $03 ; $6ffb
	script_wait_frames $3c ; $7000
	script_move_target $03, $2d00, $1900 ; $7007
	script_move_player $2d00, $1b00 ; $7012
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $701c
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $7027
	script_set_actor_script $07, ActorScript_12_36 ; $7032
	script_set_actor_script $06, ActorScript_12_35 ; $703d
	call StartSeniorCourtPairBRally ; $7048
	script_face $03, FACE_DOWN ; $704b
	script_face ACTOR_PLAYER, FACE_DOWN ; $7052
	script_face ACTOR_PARTNER, FACE_DOWN ; $7059
	script_get_actor_state ACTOR_PARTNER ; $7060
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, wActors ; $7067
	farcall AttachActorStepMover ; $706a
	farcall EndCutsceneScriptMode ; $706d
	ret ; $7070
IslandOpenDoublesVictory:
	script_set_position $09, $1b00, $0b00 ; $7071
	script_set_position $08, $1b00, $0d00 ; $707c
	script_face $09, FACE_LEFT ; $7087
	script_face $08, FACE_LEFT ; $708e
	script_null_script $08 ; $7095
	script_set_anim $08, $01 ; $709a
	script_null_script ACTOR_PARTNER ; $70a1
	script_set_position $03, $2b00, $2700 ; $70a6
	script_set_position $04, $2500, $0f00 ; $70b1
	script_face $04, FACE_DOWN ; $70bc
	script_null_script $04 ; $70c3
	script_set_anim $04, $01 ; $70c8
	script_set_position $05, $2300, $1300 ; $70cf
	script_face $05, FACE_DOWN ; $70da
	script_null_script $05 ; $70e1
	script_set_anim $05, $01 ; $70e6
	script_set_position ACTOR_PLAYER, $2500, $1b00 ; $70ed
	script_face ACTOR_PLAYER, FACE_UP ; $70f8
	script_set_position ACTOR_PARTNER, $2300, $1b00 ; $70ff
	script_face ACTOR_PARTNER, FACE_UP ; $710a
	script_player_speed $0040 ; $7111
	script_move_player $2400, $1500 ; $7117
	farcall WaitPlayerMoveDone ; $7121
	script_face $03, FACE_LEFT ; $7124
	farcall WaitPlayerMoveDone ; $712b
	script_fade_in $20 ; $712e
	call WaitFadeEnd ; $7133
	script_set_text Text_34_130 ; $7136
	script_move_target $04, $2500, $1300 ; $713c
	script_wait_move $04 ; $7147
	script_face_pair $05, $04 ; $714c
	script_set_anim $04, $02 ; $7154
	script_speak $04 ; $715b
	script_face $05, FACE_DOWN ; $7160
	script_set_anim $05, $04 ; $7167
	script_wait_idle $05 ; $716e
	script_speak $05 ; $7173
	script_set_anim $03, $03 ; $7178
	script_speak $03 ; $717f
	script_set_anim $04, $02 ; $7184
	script_set_anim $05, $02 ; $718b
	script_set_anim ACTOR_PARTNER, $02 ; $7192
	script_set_anim ACTOR_PLAYER, $02 ; $7199
	script_face ACTOR_PLAYER, FACE_DOWN ; $71a0
	script_face ACTOR_PARTNER, FACE_DOWN ; $71a7
	script_face $04, FACE_DOWN ; $71ae
	script_player_speed $0010 ; $71b5
	script_set_speed $03, $0010 ; $71bb
	script_move_player $2b00, $2000 ; $71c3
	script_move_target $03, $2b00, $2000 ; $71cd
	script_wait_move $03 ; $71d8
	farcall WaitPlayerMoveDone ; $71dd
	script_move_player $2400, $1b00 ; $71e0
	script_move_target $03, $2500, $1f00 ; $71ea
	script_wait_move $03 ; $71f5
	script_face $03, FACE_UP ; $71fa
	script_set_anim $03, $02 ; $7201
	script_wait_idle $03 ; $7208
	script_speak $03 ; $720d
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7212
	script_wait_frames $1e ; $721a
	script_face ACTOR_PLAYER, FACE_DOWN ; $7221
	script_face ACTOR_PARTNER, FACE_DOWN ; $7228
	script_set_anim ACTOR_PARTNER, $03 ; $722f
	script_set_anim ACTOR_PLAYER, $03 ; $7236
	script_wait_idle ACTOR_PLAYER ; $723d
	script_set_anim $03, $03 ; $7242
	script_wait_idle $03 ; $7249
	script_set_text Text_34_135 ; $724e
	script_speak $03 ; $7254
	script_move_target $03, $2500, $1d00 ; $7259
	script_wait_move $03 ; $7264
	script_set_anim $03, $02 ; $7269
	script_wait_idle $03 ; $7270
	script_wait_frames $1e ; $7275
	script_set_anim $03, $03 ; $727c
	script_set_anim ACTOR_PLAYER, $03 ; $7283
	script_wait_idle ACTOR_PLAYER ; $728a
	script_speak ACTOR_PLAYER ; $728f
	script_set_anim $03, $02 ; $7294
	script_wait_idle $03 ; $729b
	script_speak $03 ; $72a0
	script_set_anim $03, $03 ; $72a5
	script_wait_idle $03 ; $72ac
	script_speak $03 ; $72b1
	script_set_anim ACTOR_PLAYER, $03 ; $72b6
	script_wait_idle ACTOR_PLAYER ; $72bd
	script_set_anim $03, $03 ; $72c2
	script_wait_idle $03 ; $72c9
	script_set_anim ACTOR_PLAYER, $02 ; $72ce
	script_wait_idle ACTOR_PLAYER ; $72d5
	script_face ACTOR_PLAYER, FACE_UP ; $72da
	script_face ACTOR_PARTNER, FACE_UP ; $72e1
	script_wait_frames $28 ; $72e8
	script_move_player $2400, $1700 ; $72ef
	farcall WaitPlayerMoveDone ; $72f9
	script_set_anim $05, $02 ; $72fc
	script_wait_frames $28 ; $7303
	script_speak $05 ; $730a
	script_move_target $04, $2500, $1500 ; $730f
	script_wait_move $04 ; $731a
	script_speak $04 ; $731f
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7324
	script_wait_frames $0a ; $732c
	script_set_anim ACTOR_PLAYER, $02 ; $7333
	script_set_anim ACTOR_PARTNER, $02 ; $733a
	script_wait_idle ACTOR_PARTNER ; $7341
	script_face ACTOR_PLAYER, FACE_UP ; $7346
	script_face ACTOR_PARTNER, FACE_UP ; $734d
	script_set_anim ACTOR_PARTNER, $03 ; $7354
	script_set_anim ACTOR_PLAYER, $03 ; $735b
	script_wait_idle ACTOR_PLAYER ; $7362
	script_wait_frames $0a ; $7367
	script_set_anim $04, $03 ; $736e
	script_set_anim $05, $03 ; $7375
	script_wait_idle $05 ; $737c
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [wStoryModeEntryPoint], a ; $7388
	ld a, $ff ; $738b
	ld [wUnusedExitTriggerIdMirror], a ; $738d
	ld [wStoryModeExitTriggerRequest], a ; $7390
	script_set_anim $03, $03 ; $7393
	script_wait_idle $03 ; $739a
	script_wait_frames $1e ; $739f
	ld c, $08 ; $73a6
	call BeginFadeOut ; $73a8
	call WaitFadeEnd ; $73ab
	farcall EndCutsceneScriptMode ; $73ae
	ret ; $73b1
SeniorSinglesRank4And3Victory:
	script_set_position $07, $2300, $0f00 ; $73b2
	script_face $07, FACE_DOWN ; $73bd
	call FadeInSeniorCourtNearPairA ; $73c4
	script_set_text Text_34_74 ; $73c7
	script_speak $07 ; $73cd
	script_jump_velocity $03, $ff80 ; $73d2
	ld a, $03 ; $73da
	farcall ScriptWaitActorJumpDone ; $73dc
	script_speak $03 ; $73df
	script_set_actor_script $07, ActorScript_12_03 ; $73e4
	script_wait_frames $3c ; $73ef
	script_move_target $03, $2d00, $1900 ; $73f6
	script_move_player $2d00, $1b00 ; $7401
	script_move_target ACTOR_PLAYER, $2400, $1d00 ; $740b
	script_wait_move ACTOR_PLAYER ; $7416
	script_move_target ACTOR_PLAYER, $2d00, $1d00 ; $741b
	script_wait_frames $3c ; $7426
	call StartSeniorCourtPairARally ; $742d
	script_face $03, FACE_DOWN ; $7430
	script_face ACTOR_PLAYER, FACE_DOWN ; $7437
	script_wait_frames $01 ; $743e
	farcall EndCutsceneScriptMode ; $7445
	ret ; $7448
SeniorSinglesRank2Victory:
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $7449
	script_set_position $06, $3300, $0f00 ; $744c
	script_face $06, FACE_DOWN ; $7457
	call FadeInSeniorCourtNearPairB ; $745e
	script_set_position ACTOR_PLAYER, $3400, $1b00 ; $7461
	script_set_text Text_34_35 ; $746c
	script_speak $06 ; $7472
	script_jump_velocity $03, $ff80 ; $7477
	ld a, $03 ; $747f
	farcall ScriptWaitActorJumpDone ; $7481
	script_set_text Text_34_76 ; $7484
	script_speak $03 ; $748a
	script_set_actor_script $06, ActorScript_12_07 ; $748f
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $749a
	script_wait_move ACTOR_PLAYER ; $74a5
	script_face ACTOR_PLAYER, FACE_DOWN ; $74aa
	call StartSeniorCourtPairBRally ; $74b1
	farcall EndCutsceneScriptMode ; $74b4
	ret ; $74b7
SeniorSinglesRank1Victory:
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $74b8
	call PlaceSeniorCourtPairB ; $74bb
	script_set_position $05, $3300, $0f00 ; $74be
	script_face $05, FACE_DOWN ; $74c9
	call FadeInSeniorCourtNearPairB ; $74d0
	script_set_position ACTOR_PLAYER, $3400, $1b00 ; $74d3
	script_set_text Text_34_32 ; $74de
	script_speak $05 ; $74e4
	script_jump_velocity $03, $ff80 ; $74e9
	ld a, $03 ; $74f1
	farcall ScriptWaitActorJumpDone ; $74f3
	script_set_text Text_34_77 ; $74f6
	script_speak $03 ; $74fc
	script_set_actor_script $05, ActorScript_12_10 ; $7501
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $750c
	script_wait_move ACTOR_PLAYER ; $7517
	script_face ACTOR_PLAYER, FACE_DOWN ; $751c
	call StartSeniorCourtPairBRally ; $7523
	farcall EndCutsceneScriptMode ; $7526
	ret ; $7529
SeniorSharedVictoryScene:
	script_player_speed $0040 ; $752a
	script_set_speed $04, $0018 ; $7530
	script_set_position $03, $2b00, $2700 ; $7538
	script_set_position $04, $2200, $0f00 ; $7543
	script_set_position ACTOR_PLAYER, $2400, $1b00 ; $754e
	script_move_player $2400, $1500 ; $7559
	farcall WaitPlayerMoveDone ; $7563
	script_face ACTOR_PLAYER, FACE_UP ; $7566
	script_face $04, FACE_DOWN ; $756d
	script_face $03, FACE_UP ; $7574
	call PlaceSeniorCourtPairA ; $757b
	script_fade_in $08 ; $757e
	call WaitFadeEnd ; $7583
	script_wait_frames $1e ; $7586
	script_set_text Text_34_78 ; $758d
	script_move_target $04, $2400, $1300 ; $7593
	script_wait_move $04 ; $759e
	script_set_anim $04, $02 ; $75a3
	script_speak $04 ; $75aa
	script_set_anim $03, $03 ; $75af
	script_speak $03 ; $75b6
	script_set_anim $04, $02 ; $75bb
	script_set_anim ACTOR_PLAYER, $02 ; $75c2
	script_face ACTOR_PLAYER, FACE_DOWN ; $75c9
	script_player_speed $0010 ; $75d0
	script_set_speed $03, $0010 ; $75d6
	script_move_player $2b00, $2000 ; $75de
	script_move_target $03, $2b00, $1f00 ; $75e8
	script_wait_move $03 ; $75f3
	farcall WaitPlayerMoveDone ; $75f8
	script_move_player $2400, $1e00 ; $75fb
	script_move_target $03, $2400, $1f00 ; $7605
	script_wait_move $03 ; $7610
	script_move_target $03, $2400, $1e00 ; $7615
	script_wait_move $03 ; $7620
	script_set_anim $03, $02 ; $7625
	script_wait_idle $03 ; $762c
	script_speak $03 ; $7631
	script_set_anim ACTOR_PLAYER, $03 ; $7636
	script_wait_idle ACTOR_PLAYER ; $763d
	script_set_anim $03, $03 ; $7642
	script_wait_idle $03 ; $7649
	script_speak $03 ; $764e
	script_move_target $03, $2400, $1d00 ; $7653
	script_wait_move $03 ; $765e
	script_set_anim $03, $02 ; $7663
	script_wait_idle $03 ; $766a
	script_wait_frames $1e ; $766f
	script_set_anim $03, $03 ; $7676
	script_set_anim ACTOR_PLAYER, $03 ; $767d
	script_wait_idle ACTOR_PLAYER ; $7684
	script_speak ACTOR_PLAYER ; $7689
	script_set_anim $03, $02 ; $768e
	script_wait_idle $03 ; $7695
	script_speak $03 ; $769a
	script_set_anim ACTOR_PLAYER, $03 ; $769f
	script_wait_idle ACTOR_PLAYER ; $76a6
	script_set_anim $03, $03 ; $76ab
	script_wait_idle $03 ; $76b2
	script_set_anim ACTOR_PLAYER, $02 ; $76b7
	script_wait_idle ACTOR_PLAYER ; $76be
	script_face ACTOR_PLAYER, FACE_UP ; $76c3
	script_set_position $11, $2580, $1980 ; $76ca
	sound $96 ; $76d5
	script_wait_frames $28 ; $76d7
	script_move_player $2400, $1700 ; $76de
	farcall WaitPlayerMoveDone ; $76e8
	script_set_anim $04, $02 ; $76eb
	script_wait_frames $28 ; $76f2
	script_move_target $04, $2400, $1500 ; $76f9
	script_wait_move $04 ; $7704
	script_set_position $11, $3f00, $3f00 ; $7709
	script_speak $04 ; $7714
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $7719
	ld [wStoryModeCurrentLocation], a ; $771b
	ld a, $01 ; $771e
	ld [wStoryModeEntryPoint], a ; $7720
	ld a, $ff ; $7723
	ld [wUnusedExitTriggerIdMirror], a ; $7725
	ld [wStoryModeExitTriggerRequest], a ; $7728
	script_set_anim $03, $03 ; $772b
	script_wait_idle $03 ; $7732
	script_set_anim ACTOR_PLAYER, $02 ; $7737
	script_wait_idle ACTOR_PLAYER ; $773e
	script_wait_frames $1e ; $7743
	ld c, $08 ; $774a
	call BeginFadeOut ; $774c
	call WaitFadeEnd ; $774f
	farcall EndCutsceneScriptMode ; $7752
	ret ; $7755
ComputeSeniorCourtStage:
	test_flag FLAG_DOUBLES ; $7756
	jp nz, .isDoubles ; $7759
	ld a, SENIORCOURTSTAGE_SINGLES_PRE_JUNIOR ; $775c
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $775e
	jr z, .loop ; $7761
	ld a, SENIORCOURTSTAGE_SINGLES_RANK4 ; $7763
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $7765
	jr z, .loop ; $7768
	ld a, SENIORCOURTSTAGE_SINGLES_RANK3 ; $776a
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $776c
	jr z, .loop ; $776f
	ld a, SENIORCOURTSTAGE_SINGLES_RANK2 ; $7771
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $7773
	jr z, .loop ; $7776
	ld a, SENIORCOURTSTAGE_SINGLES_RANK1 ; $7778
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $777a
	jr z, .loop ; $777d
	ld a, SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $777f
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7781
	jr z, .loop ; $7784
	ld a, SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN ; $7786
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7788
	jr z, .loop ; $778b
	ld a, SENIORCOURTSTAGE_SINGLES_COMPLETE ; $778d
.loop:
	ld [wMapSceneStage2], a ; $778f
	ret ; $7792
.isDoubles:
	ld a, SENIORCOURTSTAGE_DOUBLES_PRE_JUNIOR ; $7793
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7795
	jr z, .loop ; $7798
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK3 ; $779a
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $779c
	jr z, .loop ; $779f
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK2 ; $77a1
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $77a3
	jr z, .loop ; $77a6
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK1 ; $77a8
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $77aa
	jr z, .loop ; $77ad
	ld a, SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $77af
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $77b1
	jr z, .loop ; $77b4
	ld a, SENIORCOURTSTAGE_DOUBLES_ISLAND_OPEN ; $77b6
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $77b8
	jr z, .loop ; $77bb
	ld a, SENIORCOURTSTAGE_DOUBLES_COMPLETE ; $77bd
	jr .loop ; $77bf
	ret ; $77c1
FadeInSeniorCourtNearPairA:
	call PlaceSeniorCourtPairA ; $77c2
	script_player_speed $0040 ; $77c5
	script_set_position ACTOR_PLAYER, $2400, $1b00 ; $77cb
	script_move_player $2400, $1500 ; $77d6
	farcall WaitPlayerMoveDone ; $77e0
	script_face ACTOR_PLAYER, FACE_UP ; $77e3
	script_face $03, FACE_LEFT ; $77ea
	farcall WaitPlayerMoveDone ; $77f1
	script_fade_in $20 ; $77f4
	call WaitFadeEnd ; $77f9
	ret ; $77fc
FadeInSeniorCourtNearPairB:
	call PlaceSeniorCourtPairB ; $77fd
	script_player_speed $0040 ; $7800
	script_move_player $3500, $1500 ; $7806
	farcall WaitPlayerMoveDone ; $7810
	script_face ACTOR_PLAYER, FACE_UP ; $7813
	script_face $03, FACE_RIGHT ; $781a
	farcall WaitPlayerMoveDone ; $7821
	script_fade_in $20 ; $7824
	call WaitFadeEnd ; $7829
	ret ; $782c
ActorScript_12_21:
	; $782d, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_22:
	; $7838, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_23:
	; $7849, 11 bytes (actor_script)
	as_set_target $2300, $1c00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_24:
	; $7854, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0b00
	as_wait_move
	as_set_target $1b00, $0b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_25:
	; $786b, 11 bytes (actor_script)
	as_set_target $2b00, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_26:
	; $7876, 17 bytes (actor_script)
	as_set_target $2b00, $1300
	as_wait_move
	as_set_target $2500, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_27:
	; $7887, 13 bytes (actor_script)
	as_set_target $2300, $1e00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $06
	as_halt
ActorScript_12_28:
	; $7894, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_29:
	; $78ab, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_30:
	; $78c2, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_31:
	; $78d9, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $3300, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_32:
	; $78ea, 17 bytes (actor_script)
	as_set_target $2f00, $1300
	as_wait_move
	as_set_target $3500, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_33:
	; $78fb, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_34:
	; $7912, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_35:
	; $7929, 23 bytes (actor_script)
	as_set_target $3900, $0f00
	as_wait_move
	as_set_target $3b00, $1300
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_36:
	; $7940, 19 bytes (actor_script)
	as_wait $10
	as_set_target $3b00, $1300
	as_wait_move
	as_set_target $3900, $1b00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_37:
	; $7953, 11 bytes (actor_script)
	as_set_target $2b00, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_38:
	; $795e, 17 bytes (actor_script)
	as_set_target $2b00, $1100
	as_wait_move
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_12_39:
	; $796f, 17 bytes (actor_script)
	as_set_target $2b00, $1300
	as_wait_move
	as_set_target $2500, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_40:
	; $7980, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_41:
	; $7991, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2d00, $0f00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_42:
	; $79a2, 65 bytes (actor_script)
	as_set_target $2b00, $1100
	as_wait_move
	as_set_target $2d00, $1100
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $06
	as_halt
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_12_43:
	; $79e3, 7 bytes (actor_script)
	as_set_field $14, FACE_UP
	as_anim $06
	as_halt
ActorScript_12_44:
	; $79ea, 7 bytes (actor_script)
	as_set_field $14, FACE_DOWN
	as_anim $06
	as_halt
ActorScript_12_45:
	; $79f1, 11 bytes (actor_script)
	as_set_target $0900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_46:
	; $79fc, 11 bytes (actor_script)
	as_set_target $0b00, $0d00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_47:
	; $7a07, 29 bytes (actor_script)
	as_set_target $0700, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $0b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_48:
	; $7a24, 29 bytes (actor_script)
	as_set_target $0700, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_target $0900, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_12_49:
	; $7a41, 25 bytes (actor_script)
	as_anim $02
	as_set_target $0f00, $1500
	as_wait_move
	as_set_target $0f00, $0900
	as_wait_move
	as_set_target $0900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_12_50:
	; $7a5a, 11 bytes (actor_script)
	as_set_target $0b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
Unclassified_12:
	; $7a65, 3 bytes (bytes:3)
	db $fa, $4d, $c9 ; 0x00
PushTextArgFetchedString:
	push_wram_bank $07 ; $7a68
	ld de, wTextArgFetchBuffer ; $7a71
	wram_bank $05 ; $7a74
	farcall FetchShortTextToBuffer ; $7a7a
	ld hl, wTextArgFetchBuffer ; $7a7d
	farcall PushTextArgString ; $7a80
	pop_wram_bank ; $7a83
	ret ; $7a88
ActorScript_12_51:
	; $7a89, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_12_52:
	; $7a93, 30 bytes (actor_script)
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
MapScriptNop_12:
	ret ; $7ab1
MapScriptClearActiveFlag_12:
	xor a ; $7ab2
	ld [wStoryScriptRan], a ; $7ab3
	ret ; $7ab6
MapScriptPlaySoundA2_12:
	sound $a2 ; $7ab7
	ret ; $7ab9
MapScriptHideLocationName_12:
	xor a ; $7aba
	ld [wStoryModeShowLocationName], a ; $7abb
	ret ; $7abe
ActorScript_12_53:
	; $7abf, 99 bytes (actor_script)
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
	as_jump ActorScript_12_53
ActorScript_12_54:
	; $7b22, 103 bytes (actor_script)
	as_anim $00
	as_wait $3c
.L4:
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
	as_jump .L4
ActorScript_12_55:
	; $7b89, 103 bytes (actor_script)
	as_anim $00
	as_wait $1e
.L4:
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
	as_jump .L4
ActorScript_12_56:
	; $7bf0, 105 bytes (actor_script)
	as_anim $00
	as_wait $1e
	as_wait $3c
.L6:
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
	as_jump .L6
ActorScript_12_57:
	; $7c59, 13 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_12_57
ActorScript_12_58:
	; $7c66, 15 bytes (actor_script)
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump ActorScript_12_58
ComputeSeniorCourtStageB:
	test_flag FLAG_DOUBLES ; $7c75
	jr nz, .doubles ; $7c78
	ld a, STORYRANK_SINGLES_ACADEMY ; $7c7a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7c7c
	jr z, .store ; $7c7f
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7c81
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7c83
	jr z, .store ; $7c86
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7c88
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7c8a
	jr z, .store ; $7c8d
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7c8f
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7c91
	jr z, .store ; $7c94
	ld a, STORYRANK_SINGLES_COMPLETE ; $7c96
.store:
	ld [wMapSceneStage], a ; $7c98
	ret ; $7c9b
.doubles:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7c9c
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7c9e
	jr z, .store ; $7ca1
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7ca3
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7ca5
	jr z, .store ; $7ca8
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7caa
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7cac
	jr z, .store ; $7caf
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7cb1
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7cb3
	jr z, .store ; $7cb6
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7cb8
	jr .store ; $7cba
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_12_ComputeStoryRankTier:
	ld a, $00 ; $7cbc
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7cbe
	jr z, .storeIsland ; $7cc1
	inc a ; $7cc3
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7cc4
	jr z, .storeIsland ; $7cc7
	inc a ; $7cc9
	test_flag FLAG_DOUBLES ; $7cca
	jr nz, .doublesIsland ; $7ccd
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7ccf
	jr z, .storeIsland ; $7cd2
	inc a ; $7cd4
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7cd5
	jr z, .storeIsland ; $7cd8
	inc a ; $7cda
.storeIsland:
	ld [wMapSceneStage], a ; $7cdb
	ret ; $7cde
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7cdf
	jr z, .storeIsland ; $7ce2
	inc a ; $7ce4
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7ce5
	jr z, .storeIsland ; $7ce8
	inc a ; $7cea
	jr .storeIsland ; $7ceb
	; $7ced, 787 bytes fill to bank end (linker-padded)
