DataPtr_SmallCharTestMapScripts_0f:
	dw SmallCharTestMapScripts_0f ; $4000
DataPtr_AwardsCeremonyMapScripts_0f:
	dw AwardsCeremonyMapScripts_0f ; $4002
DataPtr_TournamentMapScripts_0f:
	dw TournamentMapScripts_0f ; $4004
SmallCharTestMapScripts_0f:
	; $4006, 14 bytes (map_tree)
	dw SmallCharTestEntryPoints_0f ; slot 0 EntryPoints
	dw SmallCharTestExitTriggers_0f ; slot 1 ExitTriggers
	dw SmallCharTestActors_0f ; slot 2 Actors
	dw SmallCharTestNpcScripts_0f ; slot 3 NpcScripts
	dw SmallCharTestFacingScripts_0f ; slot 4 FacingScripts
	dw SmallCharTestTileTriggers_0f ; slot 5 TileTriggers
	dw SmallCharTestInitScript_0f ; slot 6 InitScript
SmallCharTestActors_0f:
	; $4014, 178 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $0700, $0300, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $0300, FACE_DOWN, $2b, $01, $00
	map_actor $0000, ActorScript_0f_09, $0700, $0700, FACE_DOWN, $2c, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $0700, FACE_DOWN, $2d, $01, $00
	map_actor $0000, ActorScript_0f_09, $0500, $0d00, FACE_DOWN, $70, $01, $00
	map_actor $0000, ActorScript_0f_09, $0900, $0d00, FACE_DOWN, $71, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $0d00, FACE_DOWN, $72, $01, $00
	map_actor $0000, ActorScript_0f_09, $1100, $0d00, FACE_DOWN, $73, $01, $00
	map_actor $0000, ActorScript_0f_09, $0500, $1100, FACE_DOWN, $6d, $01, $00
	map_actor $0000, ActorScript_0f_09, $0900, $1100, FACE_DOWN, $6e, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $1100, FACE_DOWN, $48, $01, $00
	map_actor $0000, ActorScript_0f_09, $1100, $1100, FACE_DOWN, $2b, $01, $00
	map_actor_end
SmallCharTestEntryPoints_0f:
	; $40c6, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0b00, $0b00, $0000
	db $ff
SmallCharTestExitTriggers_0f:
	ds 1, $ff ; $40cf, fill
SmallCharTestStageStepDown_0f:
	ld hl, wMapSceneStage ; $40d0
	ld a, [hl] ; $40d3
	dec a ; $40d4
	ld hl, wMapSceneStage2 ; $40d5
	add a ; $40d8
	jr nc, .checkMax ; $40d9
	ld a, [hl] ; $40db
	dec a ; $40dc
	jr .compare ; $40dd
.checkMax:
	rra ; $40df
	cp [hl] ; $40e0
	jr c, .compare ; $40e1
	xor a ; $40e3
.compare:
	cp $29 ; $40e4
	jr nc, SmallCharTestApplyStage_0f ; $40e6
	ld hl, wMapSceneStage2 ; $40e8
	ld a, [hl] ; $40eb
SmallCharTestApplyStage_0f:
	ld hl, wMapSceneStage ; $40ec
	ld [hl], a ; $40ef
	call SetPlayerActorObjectDef ; $40f0
	ret ; $40f3
SmallCharTestNpc03_0f:
	ld hl, wMapSceneStage ; $40f4
	ld a, [hl] ; $40f7
	inc [hl] ; $40f8
	and $03 ; $40f9
	add $26 ; $40fb
	call SetPlayerActorObjectDef ; $40fd
	ret ; $4100
SmallCharTestNpc04_0f:
	ld hl, wMapSceneStage ; $4101
	ld a, [hl] ; $4104
	inc a ; $4105
	ld hl, wMapSceneStage2 ; $4106
	add a ; $4109
	jr nc, .checkMax ; $410a
	ld a, [hl] ; $410c
	dec a ; $410d
	jr .compare ; $410e
.checkMax:
	rra ; $4110
	cp [hl] ; $4111
	jr c, .compare ; $4112
	xor a ; $4114
.compare:
	cp $2a ; $4115
	jr nc, SmallCharTestApplyStage_0f ; $4117
	ld hl, $002a ; $4119
	ld a, l ; $411c
	jr SmallCharTestApplyStage_0f ; $411d
; Instruction-for-instruction the same as SmallCharTestApplyStage_0f just above it: the same four-instruction body assembled twice. Nothing reaches this copy.
UnusedSmallCharTestApplyStage_0f:
	ld hl, wMapSceneStage ; $411f
	ld [hl], a ; $4122
	call SetPlayerActorObjectDef ; $4123
	ret ; $4126
SmallCharTestNpc05_0f:
	script_set_anim ACTOR_PLAYER, $03 ; $4127
	ret ; $412e
SmallCharTestNpc06_0f:
	script_set_anim ACTOR_PLAYER, $04 ; $412f
	ret ; $4136
MapScriptNop_0f:
	ret ; $4137
SmallCharTestNpcScripts_0f:
	; $4138, 97 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, SmallCharTestNpc03_0f, $00, $00
	map_script $04, FACEMASK_ANY, $0000, SmallCharTestNpc04_0f, $00, $00
	map_script $05, FACEMASK_ANY, $0000, SmallCharTestNpc05_0f, $00, $00
	map_script $06, FACEMASK_ANY, $0000, SmallCharTestNpc06_0f, $00, $00
	map_script $07, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $08, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $09, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $0a, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $0b, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $0c, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $0d, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	map_script $0e, FACEMASK_ANY, $0000, MapScriptNop_0f, $01, $00
	db $ff
SmallCharTestFacingScripts_0f:
	ds 1, $ff ; $4199, fill
SmallCharTestTile01_0f:
	ret ; $419a
SmallCharTestTileTriggers_0f:
	; $419b, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, SmallCharTestTile01_0f, $00, $00
	db $ff
SmallCharTestInitScript_0f:
	xor a ; $41a4
	ld [wMapSceneStage], a ; $41a5
	farcall GetObjectDefCount ; $41a8
	ld [wMapSceneStage2], a ; $41ab
	ld a, $01 ; $41ae
	ld hl, SmallCharTestButtonTask_0f ; $41b0
	call RegisterFrameTask ; $41b3
	ret ; $41b6
SmallCharTestButtonTask_0f:
	ldh a, [hInputRisingEdge] ; $41b7
	and $f0 ; $41b9
	jr z, .done ; $41bb
	script_set_anim ACTOR_PLAYER, $01 ; $41bd
.done:
	ret ; $41c4
SetPlayerActorObjectDef:
	ld d, a ; $41c5
	wram_bank WRAM_ACTORS ; $41c6
	ld hl, wPlayerObjDefPending ; $41cc
	ld [hl], $00 ; $41cf
	ld bc, wActors ; $41d1
	farcall LoadActorObjectDefIfValid ; $41d4
	call RestorePalettesFromMaster ; $41d7
	ret ; $41da
AwardsCeremonyMapScripts_0f:
	; $41db, 14 bytes (map_tree)
	dw AwardsCeremonyEntryPoints_0f ; slot 0 EntryPoints
	dw AwardsCeremonyExitTriggers_0f ; slot 1 ExitTriggers
	dw AwardsCeremonyActors_0f ; slot 2 Actors
	dw AwardsCeremonyNpcScripts_0f ; slot 3 NpcScripts
	dw AwardsCeremonyFacingScripts_0f ; slot 4 FacingScripts
	dw AwardsCeremonyTileTriggers_0f ; slot 5 TileTriggers
	dw AwardsCeremonyInitScript_0f ; slot 6 InitScript
AwardsCeremonyActors_0f:
	; $41e9, 290 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $0b00, $2700, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $2700, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_09, $0e80, $1b00, FACE_LEFT, $62, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1f00, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_09, $0700, $2100, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1d00, FACE_RIGHT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_09, $0f00, $1d00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_0f_09, $0980, $1b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor $0000, ActorScript_0f_09, $0800, $1700, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_0f_09, $0ec0, $1780, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $1040, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $1180, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $0f00, $1600, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_09, $1100, $2100, FACE_LEFT, $5b, $01, $00
	map_actor $0000, ActorScript_0f_09, $1000, $1f00, FACE_LEFT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $26, $01, $00
	map_actor_end
AwardsCeremonyActorsDoubles_0f:
	; $430b, 290 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $0f00, $1b00, FACE_LEFT, $5c, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $2700, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_09, $0d00, $2900, FACE_UP, $62, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1f00, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_09, $0700, $2100, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1d00, FACE_RIGHT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_09, $0f00, $1d00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_0f_09, $0900, $1b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_0f_09, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor $0000, ActorScript_0f_09, $0800, $1700, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_0f_09, $0f00, $1780, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $1100, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $2900, $2900, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_09, $0f00, $1600, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_09, $2f00, $2100, FACE_LEFT, $5b, $01, $00
	map_actor $0000, ActorScript_0f_09, $1000, $2000, FACE_LEFT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_0f_09, $fd00, $0100, FACE_DOWN, $26, $01, $00
	map_actor_end
AwardsCeremonyEntryPoints_0f:
	; $442d, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $2900, $0000
	map_entry $0a, FACE_UP, $0c00, $2900, $0000
	map_entry $0b, FACE_UP, $0b00, $2900, $0000
	db $ff
AwardsCeremonyExitTriggers_0f:
	ds 1, $ff ; $4446, fill
AwardsCeremonyNpcScripts_0f:
	; $4447, 81 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, $0000, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_25_115, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_25_132, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_25_122, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_124, $03, $00
	map_script $08, FACEMASK_ANY, $0000, AwardsCeremonyNpc08_0f, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_130, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_131, $03, $00
	map_script $11, FACEMASK_ANY, $0000, Text_25_121, $03, $00
	map_script $12, FACEMASK_ANY, $0000, Text_25_123, $03, $00
	db $ff
AwardsCeremonyFacingScripts_0f:
	; $4498, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AwardsCeremonyFacing01_0f, $00, $00
	db $ff
AwardsCeremonyFacing01_0f:
	ret ; $44a1
AwardsCeremonyTileTriggers_0f:
	; $44a2, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AwardsCeremonyTile01_0f, $00, $00
	map_script $02, FACEMASK_ANY, $0000, AwardsCeremonyTile02_0f, $00, $00
	db $ff
AwardsCeremonyTile01_0f:
	ld b, $0a ; $44b3
	ld c, $1c ; $44b5
	ld d, $0a ; $44b7
	ld e, $1a ; $44b9
	ld h, $04 ; $44bb
	ld l, $02 ; $44bd
	farcall CopyBehaviorMapRect ; $44bf
	call CutsceneStompScreenShake ; $44c2
	call CutsceneStompScreenShake ; $44c5
	script_set_text Text_25_126 ; $44c8
	script_speak $08 ; $44ce
	test_flag FLAG_DOUBLES ; $44d3
	jp z, .doubles ; $44d6
	set_flag FLAG_AWARDS_CEREMONY_SEEN_DOUBLES ; $44d9
	script_set_text Text_25_180 ; $44dc
	script_null_script ACTOR_PARTNER ; $44e2
	script_move_target ACTOR_PARTNER, $0d00, $1b00 ; $44e7
	script_wait_move ACTOR_PARTNER ; $44f2
	script_move_target ACTOR_PLAYER, $0b00, $1b00 ; $44f7
	script_wait_move ACTOR_PLAYER ; $4502
	call ReplacePlayerWithStandInActor ; $4507
	script_set_position $16, $0b00, $1b00 ; $450a
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4515
	ld d, $58 ; $4518
	add d ; $451a
	ld d, a ; $451b
	script_get_actor_state $15 ; $451c
	ld c, l ; $4521
	ld b, h ; $4522
	farcall LoadActorObjectDefIfValid ; $4523
	script_set_anim $15, $01 ; $4526
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $452d
	script_set_position $15, $0d00, $1b00 ; $4538
	script_face $16, FACE_DOWN ; $4543
	script_face $15, FACE_DOWN ; $454a
	script_move_target $08, $0c00, $1d00 ; $4551
	script_wait_move $08 ; $455c
	script_face $08, FACE_UP ; $4561
	script_set_position $13, $0d80, $1b00 ; $4568
	sound SFX_APPEAR1 ; $4573
	script_speak $08 ; $4575
	script_set_position $13, $3f00, $3f00 ; $457a
	script_set_anim $08, $02 ; $4585
	script_wait_idle $08 ; $458c
	script_speak $08 ; $4591
	script_set_position $14, $0c80, $1900 ; $4596
	sound SFX_APPEAR2 ; $45a1
	ld a, $78 ; $45a3
	call DelayFrames ; $45a5
	script_set_position $14, $3f00, $3f00 ; $45a8
	jp .ceremony ; $45b3
.doubles:
	set_flag FLAG_AWARDS_CEREMONY_SEEN_SINGLES ; $45b6
	script_null_script $03 ; $45b9
	script_move_target ACTOR_PLAYER, $0b80, $1b00 ; $45be
	script_wait_move ACTOR_PLAYER ; $45c9
	call ReplacePlayerWithStandInActor ; $45ce
	script_set_position $16, $0b80, $1b00 ; $45d1
	script_move_target $03, $0d00, $1d00 ; $45dc
	script_wait_move $03 ; $45e7
	script_face $03, FACE_LEFT ; $45ec
	ld a, $01 ; $45f3
	call DelayFrames ; $45f5
	script_move_target $08, $0b00, $1d00 ; $45f8
	script_wait_move $08 ; $4603
	script_face $16, FACE_DOWN ; $4608
	script_face $08, FACE_UP ; $460f
	script_set_position $13, $0c80, $1b00 ; $4616
	sound SFX_APPEAR1 ; $4621
	script_speak $08 ; $4623
	script_set_position $13, $3f00, $3f00 ; $4628
	script_set_anim $08, $02 ; $4633
	script_wait_idle $08 ; $463a
	script_speak $08 ; $463f
	script_set_position $14, $0d00, $1900 ; $4644
	sound SFX_APPEAR2 ; $464f
	ld a, $78 ; $4651
	call DelayFrames ; $4653
	script_set_position $14, $3f00, $3f00 ; $4656
.ceremony:
	call CutsceneStompScreenShake ; $4661
	call CutsceneStompScreenShake ; $4664
	script_speak $08 ; $4667
	call CutsceneStompScreenShake ; $466c
	call CutsceneStompScreenShake ; $466f
	script_move_target $08, $0900, $1d00 ; $4672
	script_wait_move $08 ; $467d
	script_face $08, FACE_RIGHT ; $4682
	ld a, $01 ; $4689
	call DelayFrames ; $468b
	script_set_position $16, $3f00, $3f00 ; $468e
	test_flag FLAG_DOUBLES ; $4699
	jp z, .done ; $469c
	script_set_position $15, $3f00, $3f00 ; $469f
	script_set_objdef $4d, $15 ; $46aa
	script_set_anim $15, $01 ; $46b6
	script_face ACTOR_PLAYER, FACE_DOWN ; $46bd
	script_set_position ACTOR_PLAYER, $0b00, $1b00 ; $46c4
	script_set_position ACTOR_PARTNER, $0d00, $1b00 ; $46cf
	ld a, $01 ; $46da
	call DelayFrames ; $46dc
	script_face ACTOR_PLAYER, FACE_DOWN ; $46df
	script_face ACTOR_PARTNER, FACE_DOWN ; $46e6
	ld a, $01 ; $46ed
	call DelayFrames ; $46ef
	script_get_actor_state ACTOR_PARTNER ; $46f2
	ld c, l ; $46f7
	ld b, h ; $46f8
	ld de, wActors ; $46f9
	farcall AttachActorStepMover ; $46fc
	ret ; $46ff
.done:
	script_set_position ACTOR_PLAYER, $0b80, $1b00 ; $4700
	script_face ACTOR_PLAYER, FACE_DOWN ; $470b
	ld a, $01 ; $4712
	call DelayFrames ; $4714
	script_get_actor_state $03 ; $4717
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, wActors ; $471e
	farcall AttachActorStepMover ; $4721
	ret ; $4724
AwardsCeremonyTile02_0f:
	test_flag FLAG_DOUBLES ; $4725
	jp nz, .doubles ; $4728
	script_null_script $03 ; $472b
	script_move_target ACTOR_PLAYER, $0c00, $1900 ; $4730
	script_move_target $03, $0c00, $1b00 ; $473b
	script_wait_move $03 ; $4746
	ld a, $0a ; $474b
	call DelayFrames ; $474d
	script_face_toward $0b, ACTOR_PLAYER ; $4750
	script_face $03, FACE_UP ; $4758
	ld a, $3c ; $475f
	call DelayFrames ; $4761
	call AnnounceWinnersToPodiums ; $4764
	script_face ACTOR_PLAYER, FACE_DOWN ; $4767
	script_move_target $04, $0c00, $1d00 ; $476e
	script_wait_move $04 ; $4779
	ld a, $0a ; $477e
	call DelayFrames ; $4780
	call FaceAwardsCeremonyCrowdUp ; $4783
	script_set_speed ACTOR_PLAYER, $0020 ; $4786
	script_set_speed $03, $0020 ; $478e
	script_set_speed $04, $0020 ; $4796
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_00 ; $479e
	script_set_actor_script $03, ActorScript_0f_00 ; $47a9
	script_set_actor_script $04, ActorScript_0f_00 ; $47b4
	ld a, $b4 ; $47bf
	call DelayFrames ; $47c1
	script_set_position ACTOR_PLAYER, $0c00, $0d40 ; $47c4
	script_set_position $03, $0e00, $0e40 ; $47cf
	script_set_position $04, $0a00, $0dc0 ; $47da
	call ReplacePlayerWithStandInActor ; $47e5
	script_set_position $16, $0c00, $0d40 ; $47e8
	script_face $16, FACE_DOWN ; $47f3
	script_face $03, FACE_DOWN ; $47fa
	script_face $04, FACE_DOWN ; $4801
	script_player_speed $0006 ; $4808
	script_move_player $0c00, $1300 ; $480e
	farcall WaitPlayerMoveDone ; $4818
	call AwardsCeremonyChairmanSpeech ; $481b
	script_move_target $0c, $0e00, $1300 ; $481e
	script_wait_move $0c ; $4829
	script_face $0c, FACE_UP ; $482e
	script_set_speed $0f, $0010 ; $4835
	script_set_speed $10, $0010 ; $483d
	script_move_target $10, $1100, $1600 ; $4845
	script_wait_move $10 ; $4850
	script_face $10, FACE_DOWN ; $4855
	ld a, $14 ; $485c
	call DelayFrames ; $485e
	script_set_position $0f, $1180, $1600 ; $4861
	ld a, $14 ; $486c
	call DelayFrames ; $486e
	call AwardsCeremonySwapActors_0f ; $4871
	script_set_objdef $5c, $11 ; $4874
	script_set_anim $11, $01 ; $4880
	script_set_position $03, $3f00, $3f00 ; $4887
	script_set_position $11, $0e00, $0e40 ; $4892
	script_face $11, FACE_DOWN ; $489d
	script_set_speed $0c, $0010 ; $48a4
	script_set_speed $0f, $0010 ; $48ac
	script_move_target $0c, $0e00, $1100 ; $48b4
	script_move_target $0f, $0e00, $1000 ; $48bf
	script_wait_move $0f ; $48ca
	ld a, $1e ; $48cf
	call DelayFrames ; $48d1
	script_speak $0c ; $48d4
	ld a, $1e ; $48d9
	call DelayFrames ; $48db
	script_move_target $0c, $0e00, $1040 ; $48de
	script_move_target $0f, $0e00, $0f40 ; $48e9
	script_wait_move $0f ; $48f4
	ld a, $05 ; $48f9
	call DelayFrames ; $48fb
	script_facing_lock $0c, $01 ; $48fe
	script_move_target $0c, $0e00, $1100 ; $4905
	script_wait_move $0c ; $4910
	script_facing_lock $0c, FACE_RIGHT ; $4915
	script_face $0c, FACE_UP ; $491c
	ld a, $14 ; $4923
	call DelayFrames ; $4925
	script_set_position $0f, $3f00, $3f00 ; $4928
	script_set_anim $11, $02 ; $4933
	script_wait_idle $11 ; $493a
	script_speak $11 ; $493f
	script_set_position $15, $0f80, $0f80 ; $4944
	sound SFX_EMOTE ; $494f
	ld a, $78 ; $4951
	call DelayFrames ; $4953
	script_set_position $15, $3f00, $3f00 ; $4956
	script_set_anim $11, $04 ; $4961
	script_wait_idle $11 ; $4968
	script_speak $11 ; $496d
	script_get_actor_state $16 ; $4972
	ld a, $01 ; $4977
	ld e, l ; $4979
	ld d, h ; $497a
	ld hl, $0018 ; $497b
	add hl, de ; $497e
	ld [hl], a ; $497f
	script_get_actor_state $0c ; $4980
	ld a, $01 ; $4985
	ld e, l ; $4987
	ld d, h ; $4988
	ld hl, $0018 ; $4989
	add hl, de ; $498c
	ld [hl], a ; $498d
	script_set_anim $16, $02 ; $498e
	script_wait_idle $16 ; $4995
	script_set_anim $0c, $03 ; $499a
	script_wait_idle $0c ; $49a1
	script_speak $0c ; $49a6
	ld a, $1e ; $49ab
	call DelayFrames ; $49ad
	script_move_target $0c, $0e00, $1300 ; $49b0
	script_wait_move $0c ; $49bb
	script_move_target $0c, $0a00, $1300 ; $49c0
	script_wait_move $0c ; $49cb
	script_face $0c, FACE_UP ; $49d0
	ld a, $14 ; $49d7
	call DelayFrames ; $49d9
	script_set_speed $0e, $0010 ; $49dc
	script_set_speed $10, $0010 ; $49e4
	script_move_target $10, $1000, $1600 ; $49ec
	script_wait_move $10 ; $49f7
	script_face $10, FACE_DOWN ; $49fc
	ld a, $14 ; $4a03
	call DelayFrames ; $4a05
	script_set_position $0e, $1080, $1600 ; $4a08
	ld a, $14 ; $4a13
	call DelayFrames ; $4a15
	script_set_objdef $74, $10 ; $4a18
	script_set_anim $10, $01 ; $4a24
	script_set_objdef $25, $0e ; $4a2b
	script_set_anim $0e, $01 ; $4a37
	script_set_position $0e, $1000, $1600 ; $4a3e
	script_set_position $10, $1000, $1500 ; $4a49
	script_face $0e, FACE_UP ; $4a54
	script_set_anim $10, $08 ; $4a5b
	script_move_target $10, $1000, $1200 ; $4a62
	script_move_target $0e, $1000, $1300 ; $4a6d
	script_wait_move $0e ; $4a78
	script_set_objdef $25, $10 ; $4a7d
	script_set_anim $10, $01 ; $4a89
	script_set_objdef $74, $0e ; $4a90
	script_set_anim $0e, $01 ; $4a9c
	script_set_position $10, $1000, $1300 ; $4aa3
	script_set_position $0e, $0f00, $1300 ; $4aae
	script_face $10, FACE_LEFT ; $4ab9
	script_set_anim $0e, $08 ; $4ac0
	script_move_target $10, $0c00, $1300 ; $4ac7
	script_move_target $0e, $0b00, $1300 ; $4ad2
	script_wait_move $0e ; $4add
	script_facing_lock $10, $01 ; $4ae2
	script_move_target $10, $0e00, $1300 ; $4ae9
	script_wait_move $10 ; $4af4
	script_facing_lock $10, FACE_RIGHT ; $4af9
	script_set_speed $10, $0020 ; $4b00
	script_move_target $10, $1000, $1600 ; $4b08
	script_wait_move $10 ; $4b13
	script_face $10, FACE_UP ; $4b18
	script_set_objdef $61, $12 ; $4b1f
	script_set_anim $12, $01 ; $4b2b
	script_set_position $04, $3f00, $3f00 ; $4b32
	script_set_position $12, $0a00, $0dc0 ; $4b3d
	script_face $12, FACE_DOWN ; $4b48
	script_set_speed $0c, $0010 ; $4b4f
	script_set_speed $0e, $0010 ; $4b57
	script_move_target $0c, $0a00, $1100 ; $4b5f
	script_move_target $0e, $0a00, $1000 ; $4b6a
	script_wait_move $0e ; $4b75
	ld a, $1e ; $4b7a
	call DelayFrames ; $4b7c
	script_speak $0c ; $4b7f
	ld a, $1e ; $4b84
	call DelayFrames ; $4b86
	script_move_target $0c, $0a00, $0fc0 ; $4b89
	script_move_target $0e, $0a00, $0ec0 ; $4b94
	script_wait_move $0e ; $4b9f
	ld a, $05 ; $4ba4
	call DelayFrames ; $4ba6
	script_set_anim $12, $02 ; $4ba9
	script_wait_idle $12 ; $4bb0
	script_facing_lock $0c, $01 ; $4bb5
	script_move_target $0c, $0a00, $1100 ; $4bbc
	script_wait_move $0c ; $4bc7
	script_facing_lock $0c, FACE_RIGHT ; $4bcc
	script_face $0c, FACE_UP ; $4bd3
	ld a, $14 ; $4bda
	call DelayFrames ; $4bdc
	script_set_position $0e, $3f00, $3f00 ; $4bdf
	script_set_position $13, $0b80, $0c40 ; $4bea
	sound SFX_APPEAR1 ; $4bf5
	script_speak $12 ; $4bf7
	script_set_position $13, $3f00, $3f00 ; $4bfc
	script_set_position $15, $0b80, $0f80 ; $4c07
	sound SFX_EMOTE ; $4c12
	ld a, $78 ; $4c14
	call DelayFrames ; $4c16
	script_set_position $15, $3f00, $3f00 ; $4c19
	script_set_anim $12, $04 ; $4c24
	script_wait_idle $12 ; $4c2b
	script_speak $12 ; $4c30
	script_set_anim $0c, $03 ; $4c35
	script_wait_idle $0c ; $4c3c
	script_speak $0c ; $4c41
	ld a, $1e ; $4c46
	call DelayFrames ; $4c48
	script_move_target $0c, $0a00, $1300 ; $4c4b
	script_wait_move $0c ; $4c56
	script_move_target $0c, $0c00, $1300 ; $4c5b
	script_wait_move $0c ; $4c66
	script_face $0c, FACE_UP ; $4c6b
	script_set_speed $0d, $0010 ; $4c72
	script_set_speed $10, $0010 ; $4c7a
	script_move_target $10, $0f00, $1600 ; $4c82
	script_wait_move $10 ; $4c8d
	script_face $10, FACE_DOWN ; $4c92
	ld a, $14 ; $4c99
	call DelayFrames ; $4c9b
	script_set_position $0d, $0f80, $1600 ; $4c9e
	ld a, $14 ; $4ca9
	call DelayFrames ; $4cab
	script_set_objdef $74, $10 ; $4cae
	script_set_anim $10, $01 ; $4cba
	script_set_objdef $25, $0d ; $4cc1
	script_set_anim $0d, $01 ; $4ccd
	script_set_position $0d, $0f00, $1600 ; $4cd4
	script_set_position $10, $0f00, $1500 ; $4cdf
	script_face $0d, FACE_UP ; $4cea
	script_set_anim $10, $06 ; $4cf1
	script_move_target $10, $0f00, $1200 ; $4cf8
	script_move_target $0d, $0f00, $1300 ; $4d03
	script_wait_move $0d ; $4d0e
	script_set_objdef $25, $10 ; $4d13
	script_set_anim $10, $01 ; $4d1f
	script_set_objdef $74, $0d ; $4d26
	script_set_anim $0d, $01 ; $4d32
	script_set_position $10, $0f00, $1300 ; $4d39
	script_set_position $0d, $0e00, $1300 ; $4d44
	script_face $10, FACE_LEFT ; $4d4f
	script_set_anim $0d, $06 ; $4d56
	script_move_target $10, $0e00, $1300 ; $4d5d
	script_move_target $0d, $0d00, $1300 ; $4d68
	script_wait_move $0d ; $4d73
	script_facing_lock $10, $01 ; $4d78
	script_move_target $10, $0f00, $1300 ; $4d7f
	script_wait_move $10 ; $4d8a
	script_facing_lock $10, FACE_RIGHT ; $4d8f
	script_set_speed $10, $0020 ; $4d96
	script_move_target $10, $0f00, $1600 ; $4d9e
	script_wait_move $10 ; $4da9
	script_face $10, FACE_UP ; $4dae
	script_move_target $0c, $0c00, $1100 ; $4db5
	script_move_target $0d, $0c00, $1000 ; $4dc0
	script_wait_move $0d ; $4dcb
	script_speak $0c ; $4dd0
	ld a, $14 ; $4dd5
	call DelayFrames ; $4dd7
	script_move_target $0c, $0c00, $0f80 ; $4dda
	script_move_target $0d, $0c00, $0e40 ; $4de5
	script_wait_move $0d ; $4df0
	script_facing_lock $0c, $01 ; $4df5
	script_move_target $0c, $0c00, $1100 ; $4dfc
	script_wait_move $0c ; $4e07
	script_facing_lock $0c, FACE_RIGHT ; $4e0c
	script_face $0c, FACE_UP ; $4e13
	script_set_anim $0b, $02 ; $4e1a
	script_wait_idle $0b ; $4e21
	script_speak $16 ; $4e26
	script_face $11, FACE_LEFT ; $4e2b
	script_face $12, FACE_RIGHT ; $4e32
	ld a, $3c ; $4e39
	call DelayFrames ; $4e3b
	ld a, [wStoryModeGenderOfMainCharacter] ; $4e3e
	ld d, $26 ; $4e41
	add d ; $4e43
	ld d, a ; $4e44
	script_get_actor_state $16 ; $4e45
	ld c, l ; $4e4a
	ld b, h ; $4e4b
	farcall LoadActorObjectDefIfValid ; $4e4c
	script_set_anim $16, $01 ; $4e4f
	script_face $16, FACE_RIGHT ; $4e56
	script_set_anim $16, $08 ; $4e5d
	script_set_position $0d, $0b40, $0c40 ; $4e64
	script_move_player $0c00, $0d00 ; $4e6f
	farcall WaitPlayerMoveDone ; $4e79
	ld a, $b4 ; $4e7c
	call DelayFrames ; $4e7e
	ld c, $01 ; $4e81
	call BeginFadeOut ; $4e83
	call WaitFadeEnd ; $4e86
	ld b, $01 ; $4e89
	ld a, [wStoryModeGenderOfMainCharacter] ; $4e8b
	add $04 ; $4e8e
	ld c, a ; $4e90
	farcall RunStorySceneByMode ; $4e91
	ld a, STORYLOC_ACADEMY_WING ; $4e94
	ld [wStoryModeCurrentLocation], a ; $4e96
	ld a, $0f ; $4e99
	ld [wStoryModeEntryPoint], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [wUnusedExitTriggerIdMirror], a ; $4ea0
	ld [wStoryModeExitTriggerRequest], a ; $4ea3
	ret ; $4ea6
.doubles:
	script_null_script ACTOR_PARTNER ; $4ea7
	script_move_target ACTOR_PLAYER, $0c00, $1900 ; $4eac
	script_move_target ACTOR_PARTNER, $0c00, $1b00 ; $4eb7
	script_wait_move ACTOR_PARTNER ; $4ec2
	ld a, $0a ; $4ec7
	call DelayFrames ; $4ec9
	script_face_toward $0b, ACTOR_PLAYER ; $4ecc
	script_face ACTOR_PARTNER, FACE_UP ; $4ed4
	ld a, $3c ; $4edb
	call DelayFrames ; $4edd
	call AnnounceWinnersToPodiums ; $4ee0
	script_face ACTOR_PLAYER, FACE_DOWN ; $4ee3
	script_get_actor_state $05 ; $4eea
	ld c, l ; $4eef
	ld b, h ; $4ef0
	script_get_actor_state $04 ; $4ef1
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	farcall AttachActorStepMover ; $4ef8
	script_move_target $04, $0c00, $1d00 ; $4efb
	script_wait_move $04 ; $4f06
	ld a, $0a ; $4f0b
	call DelayFrames ; $4f0d
	script_null_script $05 ; $4f10
	call FaceAwardsCeremonyCrowdUp ; $4f15
	script_face $03, FACE_UP ; $4f18
	script_set_speed ACTOR_PLAYER, $0020 ; $4f1f
	script_set_speed ACTOR_PARTNER, $0020 ; $4f27
	script_set_speed $04, $0020 ; $4f2f
	script_set_speed $05, $0020 ; $4f37
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_00 ; $4f3f
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_00 ; $4f4a
	script_set_actor_script $04, ActorScript_0f_00 ; $4f55
	script_set_actor_script $05, ActorScript_0f_00 ; $4f60
	ld a, $b4 ; $4f6b
	call DelayFrames ; $4f6d
	call ReplacePlayerWithStandInActor ; $4f70
	script_set_position $16, $0d00, $0d60 ; $4f73
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4f7e
	ld d, $58 ; $4f81
	add d ; $4f83
	ld d, a ; $4f84
	script_get_actor_state $11 ; $4f85
	ld c, l ; $4f8a
	ld b, h ; $4f8b
	farcall LoadActorObjectDefIfValid ; $4f8c
	script_set_anim $11, $01 ; $4f8f
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $4f96
	script_set_position $11, $0f00, $0d60 ; $4fa1
	script_set_objdef $61, $13 ; $4fac
	script_set_anim $13, $01 ; $4fb8
	script_set_objdef $62, $15 ; $4fbf
	script_set_anim $15, $01 ; $4fcb
	script_set_position $04, $3f00, $3f00 ; $4fd2
	script_set_position $05, $3f00, $3f00 ; $4fdd
	script_set_position $13, $0b00, $0e00 ; $4fe8
	script_set_position $15, $0900, $0e00 ; $4ff3
	script_set_objdef $4e, $04 ; $4ffe
	script_set_anim $04, $01 ; $500a
	script_set_objdef $4d, $05 ; $5011
	script_set_anim $05, $01 ; $501d
	script_face $16, FACE_DOWN ; $5024
	script_face $11, FACE_DOWN ; $502b
	script_face $13, FACE_DOWN ; $5032
	script_face $15, FACE_DOWN ; $5039
	script_player_speed $0006 ; $5040
	script_move_player $0c00, $1300 ; $5046
	farcall WaitPlayerMoveDone ; $5050
	call AwardsCeremonyChairmanSpeech ; $5053
	script_move_target $0c, $0a00, $1300 ; $5056
	script_wait_move $0c ; $5061
	script_face $0c, FACE_UP ; $5066
	script_set_speed $10, $0010 ; $506d
	script_set_speed $09, $0010 ; $5075
	script_set_speed $0f, $0010 ; $507d
	script_move_target $10, $1100, $1600 ; $5085
	script_wait_move $10 ; $5090
	script_face $10, FACE_DOWN ; $5095
	ld a, $14 ; $509c
	call DelayFrames ; $509e
	script_set_position $0e, $3f00, $3f00 ; $50a1
	script_set_position $0f, $1100, $1600 ; $50ac
	ld a, $14 ; $50b7
	call DelayFrames ; $50b9
	script_set_objdef $25, $09 ; $50bc
	script_set_anim $09, $01 ; $50c8
	script_set_position $10, $3f00, $3f00 ; $50cf
	script_set_position $09, $1100, $1600 ; $50da
	script_set_position $0f, $1100, $1500 ; $50e5
	script_face $09, FACE_UP ; $50f0
	script_set_anim $0f, $08 ; $50f7
	script_move_target $0f, $1100, $1200 ; $50fe
	script_move_target $09, $1100, $1300 ; $5109
	script_wait_move $09 ; $5114
	script_set_position $09, $3f00, $3f00 ; $5119
	script_set_position $10, $1100, $1300 ; $5124
	script_set_position $0f, $1000, $1300 ; $512f
	script_face $10, FACE_LEFT ; $513a
	script_move_target $10, $0c00, $1300 ; $5141
	script_move_target $0f, $0b00, $1300 ; $514c
	script_wait_move $0f ; $5157
	script_facing_lock $10, $01 ; $515c
	script_move_target $10, $0f00, $1300 ; $5163
	script_wait_move $10 ; $516e
	script_facing_lock $10, FACE_RIGHT ; $5173
	script_move_target $10, $1100, $1600 ; $517a
	script_wait_move $10 ; $5185
	script_face $10, FACE_UP ; $518a
	script_set_text Text_25_185 ; $5191
	script_set_speed $0c, $0010 ; $5197
	script_move_target $0c, $0a00, $1100 ; $519f
	script_move_target $0f, $0a00, $1000 ; $51aa
	script_wait_move $0f ; $51b5
	ld a, $1e ; $51ba
	call DelayFrames ; $51bc
	script_speak $0c ; $51bf
	ld a, $1e ; $51c4
	call DelayFrames ; $51c6
	script_move_target $0c, $0a00, $1000 ; $51c9
	script_move_target $0f, $0a00, $0f00 ; $51d4
	script_wait_move $0f ; $51df
	ld a, $05 ; $51e4
	call DelayFrames ; $51e6
	script_set_anim $13, $02 ; $51e9
	script_wait_idle $13 ; $51f0
	script_facing_lock $0c, $01 ; $51f5
	script_move_target $0c, $0a00, $1100 ; $51fc
	script_wait_move $0c ; $5207
	script_facing_lock $0c, FACE_RIGHT ; $520c
	script_face $0c, FACE_UP ; $5213
	ld a, $32 ; $521a
	call DelayFrames ; $521c
	script_set_position $0f, $3f00, $3f00 ; $521f
	script_set_position $04, $0c80, $0c80 ; $522a
	sound SFX_APPEAR1 ; $5235
	ld a, $50 ; $5237
	call DelayFrames ; $5239
	script_set_position $04, $3f00, $3f00 ; $523c
	script_speak $13 ; $5247
	script_set_anim $15, $02 ; $524c
	script_wait_idle $15 ; $5253
	script_speak $15 ; $5258
	script_set_position $05, $0b80, $0f80 ; $525d
	sound SFX_EMOTE ; $5268
	ld a, $78 ; $526a
	call DelayFrames ; $526c
	script_set_position $05, $3f00, $3f00 ; $526f
	script_set_anim $13, $04 ; $527a
	script_wait_idle $13 ; $5281
	script_speak $13 ; $5286
	script_set_anim $16, $02 ; $528b
	script_set_anim $11, $02 ; $5292
	script_wait_idle $11 ; $5299
	script_face $16, FACE_LEFT ; $529e
	script_face $11, FACE_LEFT ; $52a5
	ld a, $3c ; $52ac
	call DelayFrames ; $52ae
	script_face $16, FACE_DOWN ; $52b1
	script_face $11, FACE_DOWN ; $52b8
	script_set_anim $15, $02 ; $52bf
	script_wait_idle $15 ; $52c6
	script_speak $15 ; $52cb
	script_set_anim $0c, $03 ; $52d0
	script_wait_idle $0c ; $52d7
	script_speak $0c ; $52dc
	ld a, $1e ; $52e1
	call DelayFrames ; $52e3
	script_move_target $0c, $0a00, $1300 ; $52e6
	script_wait_move $0c ; $52f1
	script_move_target $0c, $0e00, $1300 ; $52f6
	script_wait_move $0c ; $5301
	script_face $0c, FACE_UP ; $5306
	ld a, $14 ; $530d
	call DelayFrames ; $530f
	script_set_speed $0d, $0010 ; $5312
	script_move_target $10, $0f00, $1600 ; $531a
	script_wait_move $10 ; $5325
	script_face $10, FACE_DOWN ; $532a
	ld a, $14 ; $5331
	call DelayFrames ; $5333
	script_set_position $0d, $0f80, $1600 ; $5336
	ld a, $14 ; $5341
	call DelayFrames ; $5343
	script_set_position $10, $3f00, $3f00 ; $5346
	script_set_position $09, $0f00, $1600 ; $5351
	script_set_position $0d, $0f00, $1500 ; $535c
	script_face $09, FACE_UP ; $5367
	script_set_anim $0d, $08 ; $536e
	script_move_target $0d, $0f00, $1300 ; $5375
	script_move_target $09, $0f00, $1400 ; $5380
	script_wait_move $09 ; $538b
	script_set_position $09, $3f00, $3f00 ; $5390
	script_set_position $10, $0f00, $1400 ; $539b
	script_face $10, FACE_UP ; $53a6
	script_facing_lock $10, $01 ; $53ad
	script_move_target $10, $0f00, $1600 ; $53b4
	script_wait_move $10 ; $53bf
	script_facing_lock $10, FACE_RIGHT ; $53c4
	script_face $10, FACE_UP ; $53cb
	script_set_position $0d, $0ec0, $1300 ; $53d2
	script_move_target $0c, $0f00, $1300 ; $53dd
	script_move_target $0d, $0fc0, $1300 ; $53e8
	script_wait_move $0d ; $53f3
	script_move_target $0c, $0f00, $1100 ; $53f8
	script_move_target $0d, $0fc0, $1100 ; $5403
	script_wait_move $0d ; $540e
	ld a, $1e ; $5413
	call DelayFrames ; $5415
	script_speak $0c ; $5418
	ld a, $0a ; $541d
	call DelayFrames ; $541f
	script_set_anim $11, $03 ; $5422
	script_wait_idle $11 ; $5429
	script_speak $11 ; $542e
	ld a, $14 ; $5433
	call DelayFrames ; $5435
	script_set_position $0d, $0e40, $1100 ; $5438
	script_move_target $0c, $0d00, $1100 ; $5443
	script_move_target $0d, $0c40, $1100 ; $544e
	script_wait_move $0d ; $5459
	ld a, $04 ; $545e
	call DelayFrames ; $5460
	script_face $0c, FACE_UP ; $5463
	script_move_target $0d, $0d00, $1000 ; $546a
	script_wait_move $0d ; $5475
	ld a, $14 ; $547a
	call DelayFrames ; $547c
	script_speak $0c ; $547f
	ld a, $1e ; $5484
	call DelayFrames ; $5486
	script_move_target $0c, $0d00, $1000 ; $5489
	script_move_target $0d, $0d00, $0e80 ; $5494
	script_wait_move $0d ; $549f
	ld a, $05 ; $54a4
	call DelayFrames ; $54a6
	script_facing_lock $0c, $01 ; $54a9
	script_move_target $0c, $0d00, $1100 ; $54b0
	script_wait_move $0c ; $54bb
	script_facing_lock $0c, FACE_RIGHT ; $54c0
	script_face $0c, FACE_UP ; $54c7
	script_set_anim $0b, $02 ; $54ce
	script_wait_idle $0b ; $54d5
	script_speak $16 ; $54da
	script_set_anim $16, $03 ; $54df
	script_set_anim $11, $03 ; $54e6
	script_wait_idle $11 ; $54ed
	script_speak $16 ; $54f2
	script_face $11, FACE_LEFT ; $54f7
	script_face $13, FACE_RIGHT ; $54fe
	script_face $15, FACE_RIGHT ; $5505
	ld a, $3c ; $550c
	call DelayFrames ; $550e
	ld a, [wStoryModeGenderOfMainCharacter] ; $5511
	ld d, $26 ; $5514
	add d ; $5516
	ld d, a ; $5517
	script_get_actor_state $16 ; $5518
	ld c, l ; $551d
	ld b, h ; $551e
	farcall LoadActorObjectDefIfValid ; $551f
	script_set_anim $16, $01 ; $5522
	script_face $16, FACE_RIGHT ; $5529
	script_set_anim $16, $08 ; $5530
	script_set_position $0d, $0c40, $0c60 ; $5537
	script_move_player $0c00, $0d00 ; $5542
	farcall WaitPlayerMoveDone ; $554c
	ld a, $b4 ; $554f
	call DelayFrames ; $5551
	ld c, $01 ; $5554
	call BeginFadeOut ; $5556
	call WaitFadeEnd ; $5559
	ld b, $01 ; $555c
	ld a, [wStoryModeGenderOfMainCharacter] ; $555e
	ld d, a ; $5561
	sla a ; $5562
	ld c, a ; $5564
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5565
	xor d ; $5568
	or c ; $5569
	ld c, a ; $556a
	farcall RunStorySceneByMode ; $556b
	ld a, STORYLOC_ACADEMY_WING ; $556e
	ld [wStoryModeCurrentLocation], a ; $5570
	ld a, $0f ; $5573
	ld [wStoryModeEntryPoint], a ; $5575
	ld a, $ff ; $5578
	ld [wUnusedExitTriggerIdMirror], a ; $557a
	ld [wStoryModeExitTriggerRequest], a ; $557d
	ret ; $5580
AwardsCeremonyInitScript_0f:
	test_flag FLAG_DOUBLES ; $5581
	jr z, .setAnims ; $5584
	ldh a, [hRomBank] ; $5586
	ld hl, AwardsCeremonyActorsDoubles_0f ; $5588
	farcall ScriptRespawnLocationActors ; $558b
	ld hl, AwardsCeremonyScriptsDoubles_0f ; $558e
	ld de, $000c ; $5591
	farcall WriteStoryStateWord ; $5594
	script_copy_scene_rect $1a, $0d, $08, $0d, $08, $03 ; $5597
	farcall BeginCutsceneScriptMode ; $55a6
.setAnims:
	script_set_anim $0e, $08 ; $55a9
	script_set_anim $0f, $08 ; $55b0
	test_flag FLAG_DOUBLES ; $55b7
	jr nz, .setObjectDefs ; $55ba
	script_set_anim $0d, $06 ; $55bc
.setObjectDefs:
	call SetPlayerAndPartnerObjectDefs ; $55c3
	ld a, [wStoryModeEntryPoint] ; $55c6
	cp $0a ; $55c9
	jp z, CutsceneStompScreenShake.arrival ; $55cb
	cp $0b ; $55ce
	jp z, CutsceneStompScreenShake.doubles ; $55d0
	call CheckAwardsCeremonyRivalSceneDone ; $55d3
	and $01 ; $55d6
	jr z, .checkDoubles ; $55d8
	script_move_target $08, $0900, $1d00 ; $55da
	script_wait_move $08 ; $55e5
	script_face $08, FACE_RIGHT ; $55ea
	ld b, $0a ; $55f1
	ld c, $1c ; $55f3
	ld d, $0a ; $55f5
	ld e, $1a ; $55f7
	ld h, $04 ; $55f9
	ld l, $02 ; $55fb
	farcall CopyBehaviorMapRect ; $55fd
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5600
	jp nz, .done ; $5603
	call SavePlayerActorPosition ; $5606
	ld hl, wMapScratch ; $5609
	ld a, [hl+] ; $560c
	ld b, [hl] ; $560d
	ld c, a ; $560e
	ld hl, wMapScratch + 2 ; $560f
	ld a, [hl+] ; $5612
	ld d, [hl] ; $5613
	ld e, a ; $5614
	ld a, $03 ; $5615
	farcall ScriptSetActorPosition ; $5617
	script_get_actor_state $03 ; $561a
	ld c, l ; $561f
	ld b, h ; $5620
	ld de, wActors ; $5621
	farcall AttachActorStepMover ; $5624
.done:
	ret ; $5627
