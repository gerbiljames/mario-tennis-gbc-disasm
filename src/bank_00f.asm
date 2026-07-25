SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

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
	map_actor $0000, ActorScript_0f_7b57, $0700, $0300, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $0300, FACE_DOWN, $2b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0700, $0700, FACE_DOWN, $2c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $0700, FACE_DOWN, $2d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0500, $0d00, FACE_DOWN, $70, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0900, $0d00, FACE_DOWN, $71, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $0d00, FACE_DOWN, $72, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $0d00, FACE_DOWN, $73, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0500, $1100, FACE_DOWN, $6d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0900, $1100, FACE_DOWN, $6e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $1100, FACE_DOWN, $48, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1100, FACE_DOWN, $2b, $01, $00
	map_actor_end
SmallCharTestEntryPoints_0f:
	; $40c6, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0b00, $0b00, $0000
	db $ff
SmallCharTestExitTriggers_0f:
	ds 1, $ff ; $40cf, fill
	ld hl, $c2b0 ; $40d0
	ld a, [hl] ; $40d3
	dec a ; $40d4
	ld hl, $c2b1 ; $40d5
	add a, a ; $40d8
	jr nc, Label_0f_40df ; $40d9
	ld a, [hl] ; $40db
	dec a ; $40dc
	jr Label_0f_40e4 ; $40dd
Label_0f_40df:
	rra ; $40df
	cp a, [hl] ; $40e0
	jr c, Label_0f_40e4 ; $40e1
	xor a, a ; $40e3
Label_0f_40e4:
	cp a, $29 ; $40e4
	jr nc, Label_0f_40ec ; $40e6
	ld hl, $c2b1 ; $40e8
	ld a, [hl] ; $40eb
Label_0f_40ec:
	ld hl, $c2b0 ; $40ec
	ld [hl], a ; $40ef
	call SetPlayerActorObjectDef ; $40f0
	ret ; $40f3
SmallCharTestNpc03_0f:
	ld hl, $c2b0 ; $40f4
	ld a, [hl] ; $40f7
	inc [hl] ; $40f8
	and a, $03 ; $40f9
	add a, $26 ; $40fb
	call SetPlayerActorObjectDef ; $40fd
	ret ; $4100
SmallCharTestNpc04_0f:
	ld hl, $c2b0 ; $4101
	ld a, [hl] ; $4104
	inc a ; $4105
	ld hl, $c2b1 ; $4106
	add a, a ; $4109
	jr nc, Label_0f_4110 ; $410a
	ld a, [hl] ; $410c
	dec a ; $410d
	jr Label_0f_4115 ; $410e
Label_0f_4110:
	rra ; $4110
	cp a, [hl] ; $4111
	jr c, Label_0f_4115 ; $4112
	xor a, a ; $4114
Label_0f_4115:
	cp a, $2a ; $4115
	jr nc, Label_0f_40ec ; $4117
	ld hl, $002a ; $4119
	ld a, l ; $411c
	jr Label_0f_40ec ; $411d
	ld hl, $c2b0 ; $411f
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
	xor a, a ; $41a4
	ld [$c2b0], a ; $41a5
	farcall GetObjectDefCount ; $41a8
	ld [$c2b1], a ; $41ab
	ld a, $01 ; $41ae
	ld hl, SmallCharTestButtonTask_0f ; $41b0
	call RegisterFrameTask ; $41b3
	ret ; $41b6
SmallCharTestButtonTask_0f:
	ldh a, [hInputRisingEdge] ; $41b7
	and a, $f0 ; $41b9
	jr z, Label_0f_41c4 ; $41bb
	script_set_anim ACTOR_PLAYER, $01 ; $41bd
Label_0f_41c4:
	ret ; $41c4
SetPlayerActorObjectDef:
	ld d, a ; $41c5
	wram_bank $04 ; $41c6
	ld hl, $dae9 ; $41cc
	ld [hl], $00 ; $41cf
	ld bc, $d000 ; $41d1
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
	map_actor $0000, ActorScript_0f_7b57, $0b00, $2700, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $2700, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0e80, $1b00, FACE_LEFT, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1f00, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0700, $2100, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1d00, FACE_RIGHT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1d00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0980, $1b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor $0000, ActorScript_0f_7b57, $0800, $1700, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0ec0, $1780, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1040, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1180, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1600, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $2100, FACE_LEFT, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1000, $1f00, FACE_LEFT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $26, $01, $00
	map_actor_end
AwardsCeremonyActorsDoubles_0f:
	; $430b, 290 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1b00, FACE_LEFT, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $2700, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0d00, $2900, FACE_UP, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1f00, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0700, $2100, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1d00, FACE_RIGHT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1d00, FACE_LEFT, $24, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0900, $1b00, FACE_RIGHT, $23, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor $0000, ActorScript_0f_7b57, $0800, $1700, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1780, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $2900, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1600, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2f00, $2100, FACE_LEFT, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1000, $2000, FACE_LEFT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $fd00, $0100, FACE_DOWN, $26, $01, $00
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
	test_flag $05, 7 ; $44d3
	jp z, Label_0f_45b6 ; $44d6
	set_flag $10, 4 ; $44d9
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
	add a, d ; $451a
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
	sound $99 ; $4573
	script_speak $08 ; $4575
	script_set_position $13, $3f00, $3f00 ; $457a
	script_set_anim $08, $02 ; $4585
	script_wait_idle $08 ; $458c
	script_speak $08 ; $4591
	script_set_position $14, $0c80, $1900 ; $4596
	sound $96 ; $45a1
	ld a, $78 ; $45a3
	call DelayFrames ; $45a5
	script_set_position $14, $3f00, $3f00 ; $45a8
	jp Label_0f_4661 ; $45b3
Label_0f_45b6:
	set_flag $10, 3 ; $45b6
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
	sound $99 ; $4621
	script_speak $08 ; $4623
	script_set_position $13, $3f00, $3f00 ; $4628
	script_set_anim $08, $02 ; $4633
	script_wait_idle $08 ; $463a
	script_speak $08 ; $463f
	script_set_position $14, $0d00, $1900 ; $4644
	sound $96 ; $464f
	ld a, $78 ; $4651
	call DelayFrames ; $4653
	script_set_position $14, $3f00, $3f00 ; $4656
Label_0f_4661:
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
	test_flag $05, 7 ; $4699
	jp z, Label_0f_4700 ; $469c
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
	ld de, $d000 ; $46f9
	farcall AttachActorStepMover ; $46fc
	ret ; $46ff
Label_0f_4700:
	script_set_position ACTOR_PLAYER, $0b80, $1b00 ; $4700
	script_face ACTOR_PLAYER, FACE_DOWN ; $470b
	ld a, $01 ; $4712
	call DelayFrames ; $4714
	script_get_actor_state $03 ; $4717
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, $d000 ; $471e
	farcall AttachActorStepMover ; $4721
	ret ; $4724
AwardsCeremonyTile02_0f:
	test_flag $05, 7 ; $4725
	jp nz, Label_0f_4ea7 ; $4728
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
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_5665 ; $479e
	script_set_actor_script $03, ActorScript_0f_5665 ; $47a9
	script_set_actor_script $04, ActorScript_0f_5665 ; $47b4
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
	sound $98 ; $494f
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
	sound $99 ; $4bf5
	script_speak $12 ; $4bf7
	script_set_position $13, $3f00, $3f00 ; $4bfc
	script_set_position $15, $0b80, $0f80 ; $4c07
	sound $98 ; $4c12
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
	add a, d ; $4e43
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
	add a, $04 ; $4e8e
	ld c, a ; $4e90
	farcall RunStorySceneByMode ; $4e91
	ld a, $06 ; $4e94
	ld [wStoryModeCurrentLocation], a ; $4e96
	ld a, $0f ; $4e99
	ld [wStoryModeEntryPoint], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [$c294], a ; $4ea0
	ld [wStoryModeExitLocationRequest], a ; $4ea3
	ret ; $4ea6
Label_0f_4ea7:
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
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_5665 ; $4f3f
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_5665 ; $4f4a
	script_set_actor_script $04, ActorScript_0f_5665 ; $4f55
	script_set_actor_script $05, ActorScript_0f_5665 ; $4f60
	ld a, $b4 ; $4f6b
	call DelayFrames ; $4f6d
	call ReplacePlayerWithStandInActor ; $4f70
	script_set_position $16, $0d00, $0d60 ; $4f73
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4f7e
	ld d, $58 ; $4f81
	add a, d ; $4f83
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
	sound $99 ; $5235
	ld a, $50 ; $5237
	call DelayFrames ; $5239
	script_set_position $04, $3f00, $3f00 ; $523c
	script_speak $13 ; $5247
	script_set_anim $15, $02 ; $524c
	script_wait_idle $15 ; $5253
	script_speak $15 ; $5258
	script_set_position $05, $0b80, $0f80 ; $525d
	sound $98 ; $5268
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
	add a, d ; $5516
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
	xor a, d ; $5568
	or a, c ; $5569
	ld c, a ; $556a
	farcall RunStorySceneByMode ; $556b
	ld a, $06 ; $556e
	ld [wStoryModeCurrentLocation], a ; $5570
	ld a, $0f ; $5573
	ld [wStoryModeEntryPoint], a ; $5575
	ld a, $ff ; $5578
	ld [$c294], a ; $557a
	ld [wStoryModeExitLocationRequest], a ; $557d
	ret ; $5580
AwardsCeremonyInitScript_0f:
	test_flag $05, 7 ; $5581
	jr z, Label_0f_55a9 ; $5584
	ldh a, [hRomBank] ; $5586
	ld hl, AwardsCeremonyActorsDoubles_0f ; $5588
	farcall ScriptRespawnLocationActors ; $558b
	ld hl, AwardsCeremonyScriptsDoubles_0f ; $558e
	ld de, $000c ; $5591
	farcall WriteStoryStateWord ; $5594
	script_copy_scene_rect $1a, $0d, $08, $0d, $08, $03 ; $5597
	farcall BeginCutsceneScriptMode ; $55a6
Label_0f_55a9:
	script_set_anim $0e, $08 ; $55a9
	script_set_anim $0f, $08 ; $55b0
	test_flag $05, 7 ; $55b7
	jr nz, Label_0f_55c3 ; $55ba
	script_set_anim $0d, $06 ; $55bc
Label_0f_55c3:
	call SetPlayerAndPartnerObjectDefs ; $55c3
	ld a, [wStoryModeEntryPoint] ; $55c6
	cp a, $0a ; $55c9
	jp z, Label_0f_56a8 ; $55cb
	cp a, $0b ; $55ce
	jp z, Label_0f_5889 ; $55d0
	call CheckAwardsCeremonyRivalSceneDone ; $55d3
	and a, $01 ; $55d6
	jr z, Label_0f_5600 ; $55d8
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
Label_0f_5600:
	test_flag $05, 7 ; $5600
	jp nz, Label_0f_5627 ; $5603
	call SavePlayerActorPosition ; $5606
	ld hl, $c2b2 ; $5609
	ld a, [hl+] ; $560c
	ld b, [hl] ; $560d
	ld c, a ; $560e
	ld hl, wWaterSpriteMinigameTimer ; $560f
	ld a, [hl+] ; $5612
	ld d, [hl] ; $5613
	ld e, a ; $5614
	ld a, $03 ; $5615
	farcall ScriptSetActorPosition ; $5617
	script_get_actor_state $03 ; $561a
	ld c, l ; $561f
	ld b, h ; $5620
	ld de, $d000 ; $5621
	farcall AttachActorStepMover ; $5624
Label_0f_5627:
	ret ; $5627
AwardsCeremonyNpc08_0f:
	script_set_text Text_25_125 ; $5628
	call CheckAwardsCeremonyRivalSceneDone ; $562e
	and a, $01 ; $5631
	jr z, Label_0f_563b ; $5633
	script_set_text Text_25_129 ; $5635
Label_0f_563b:
	script_speak $08 ; $563b
	ret ; $5640
ReplacePlayerWithStandInActor:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5641
	ld d, $56 ; $5644
	add a, d ; $5646
	ld d, a ; $5647
	script_get_actor_state $16 ; $5648
	ld c, l ; $564d
	ld b, h ; $564e
	farcall LoadActorObjectDefIfValid ; $564f
	script_set_anim $16, $01 ; $5652
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $5659
	ret ; $5664
ActorScript_0f_5665:
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
	script_jump_velocity $08, $ff80 ; $567f
	ld a, $08 ; $5687
	farcall ScriptWaitActorJumpDone ; $5689
	sound $83 ; $568c
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
Label_0f_56a8:
	call AwardsCeremonyArrivalIntro ; $56a8
	script_set_anim $03, $02 ; $56ab
	script_wait_idle $03 ; $56b2
	script_face_toward ACTOR_PLAYER, $03 ; $56b7
	ld a, $0a ; $56bf
	call DelayFrames ; $56c1
	script_set_text Text_25_107 ; $56c4
	script_speak $03 ; $56ca
	script_set_anim $03, $03 ; $56cf
	script_wait_idle $03 ; $56d6
	script_speak $03 ; $56db
	script_set_anim ACTOR_PLAYER, $03 ; $56e0
	script_wait_idle ACTOR_PLAYER ; $56e7
	script_face_toward $03, $04 ; $56ec
	script_set_anim $04, $02 ; $56f4
	script_wait_idle $04 ; $56fb
	script_speak $04 ; $5700
	script_set_position $13, $0c80, $2580 ; $5705
	sound $99 ; $5710
	ld a, $3c ; $5712
	call DelayFrames ; $5714
	script_set_position $13, $3f00, $3f00 ; $5717
	script_set_anim $03, $02 ; $5722
	script_wait_idle $03 ; $5729
	script_face_toward $04, $03 ; $572e
	script_speak $03 ; $5736
	script_set_anim $04, $02 ; $573b
	script_wait_idle $04 ; $5742
	script_speak $04 ; $5747
	ld a, $1e ; $574c
	call DelayFrames ; $574e
	script_face_pair ACTOR_PLAYER, $03 ; $5751
	ld a, $50 ; $5759
	call DelayFrames ; $575b
	script_face_toward $04, $03 ; $575e
	script_face_pair $04, ACTOR_PLAYER ; $5766
	ld a, $1e ; $576e
	call DelayFrames ; $5770
	script_set_anim $04, $04 ; $5773
	script_wait_idle $04 ; $577a
	script_speak $04 ; $577f
	ld a, $28 ; $5784
	call DelayFrames ; $5786
	script_speak $0b ; $5789
	script_face $03, FACE_UP ; $578e
	script_face $04, FACE_UP ; $5795
	ld a, $14 ; $579c
	call DelayFrames ; $579e
	script_player_speed $0018 ; $57a1
	script_move_player $0c00, $1300 ; $57a7
	farcall WaitPlayerMoveDone ; $57b1
	ld a, $1e ; $57b4
	call DelayFrames ; $57b6
	script_set_anim $0b, $02 ; $57b9
	script_wait_idle $0b ; $57c0
	script_speak $0b ; $57c5
	ld a, $28 ; $57ca
	call DelayFrames ; $57cc
	script_move_player $0c00, $2900 ; $57cf
	farcall WaitPlayerMoveDone ; $57d9
	script_face $04, FACE_DOWN ; $57dc
	script_speak $04 ; $57e3
	script_face $03, FACE_RIGHT ; $57e8
	script_set_anim $04, $02 ; $57ef
	script_wait_idle $04 ; $57f6
	script_speak $04 ; $57fb
	script_set_anim $03, $02 ; $5800
	script_wait_idle $03 ; $5807
	script_face $04, FACE_LEFT ; $580c
	script_speak $03 ; $5813
	script_set_position $13, $0e80, $2580 ; $5818
	sound $99 ; $5823
	ld a, $3c ; $5825
	call DelayFrames ; $5827
	script_set_position $13, $3f00, $3f00 ; $582a
	script_face $04, FACE_UP ; $5835
	ld a, $28 ; $583c
	call DelayFrames ; $583e
	script_face $03, FACE_DOWN ; $5841
	script_speak $03 ; $5848
	script_set_anim $03, $02 ; $584d
	script_wait_idle $03 ; $5854
	script_speak $03 ; $5859
	script_set_anim ACTOR_PLAYER, $02 ; $585e
	script_wait_idle ACTOR_PLAYER ; $5865
	script_speak $03 ; $586a
	script_set_anim ACTOR_PLAYER, $03 ; $586f
	script_wait_idle ACTOR_PLAYER ; $5876
	script_get_actor_state $03 ; $587b
	ld c, l ; $5880
	ld b, h ; $5881
	ld de, $d000 ; $5882
	farcall AttachActorStepMover ; $5885
	ret ; $5888
Label_0f_5889:
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
	script_face_toward ACTOR_PARTNER, $04 ; $58e6
	ld a, $0a ; $58ee
	call DelayFrames ; $58f0
	script_set_anim $04, $02 ; $58f3
	script_wait_idle $04 ; $58fa
	script_speak $04 ; $58ff
	script_face_toward ACTOR_PLAYER, $05 ; $5904
	script_speak $05 ; $590c
	script_set_position $15, $0c80, $2580 ; $5911
	sound $98 ; $591c
	ld a, $3c ; $591e
	call DelayFrames ; $5920
	script_set_position $15, $3f00, $3f00 ; $5923
	script_face ACTOR_PARTNER, FACE_RIGHT ; $592e
	script_set_anim ACTOR_PARTNER, $02 ; $5935
	script_wait_idle ACTOR_PARTNER ; $593c
	call SpeakPartnerVariantLine ; $5941
	script_set_anim $04, $02 ; $5944
	script_wait_idle $04 ; $594b
	script_speak $04 ; $5950
	script_set_anim $05, $02 ; $5955
	script_wait_idle $05 ; $595c
	script_speak $05 ; $5961
	ld a, $1e ; $5966
	call DelayFrames ; $5968
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $596b
	ld a, $3c ; $5973
	call DelayFrames ; $5975
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5978
	script_face ACTOR_PARTNER, FACE_RIGHT ; $597f
	ld a, $1e ; $5986
	call DelayFrames ; $5988
	script_face $04, FACE_DOWN ; $598b
	script_set_anim $04, $04 ; $5992
	script_wait_idle $04 ; $5999
	script_speak $04 ; $599e
	ld a, $28 ; $59a3
	call DelayFrames ; $59a5
	script_speak $0b ; $59a8
	script_face ACTOR_PLAYER, FACE_UP ; $59ad
	script_face ACTOR_PARTNER, FACE_UP ; $59b4
	script_face $04, FACE_UP ; $59bb
	script_face $05, FACE_UP ; $59c2
	ld a, $14 ; $59c9
	call DelayFrames ; $59cb
	script_player_speed $0018 ; $59ce
	script_move_player $0c00, $1300 ; $59d4
	farcall WaitPlayerMoveDone ; $59de
	ld a, $1e ; $59e1
	call DelayFrames ; $59e3
	script_set_anim $0b, $02 ; $59e6
	script_wait_idle $0b ; $59ed
	script_speak $0b ; $59f2
	ld a, $28 ; $59f7
	call DelayFrames ; $59f9
	script_move_player $0c00, $2900 ; $59fc
	farcall WaitPlayerMoveDone ; $5a06
	script_face $04, FACE_LEFT ; $5a09
	script_speak $04 ; $5a10
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5a15
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5a1c
	script_set_anim $04, $02 ; $5a23
	script_wait_idle $04 ; $5a2a
	script_speak $04 ; $5a2f
	script_face $05, FACE_LEFT ; $5a34
	script_set_anim $05, $02 ; $5a3b
	script_wait_idle $05 ; $5a42
	script_speak $05 ; $5a47
	script_set_anim ACTOR_PARTNER, $02 ; $5a4c
	script_wait_idle ACTOR_PARTNER ; $5a53
	call SpeakPartnerVariantLine ; $5a58
	script_set_position $13, $0e80, $2580 ; $5a5b
	sound $99 ; $5a66
	ld a, $3c ; $5a68
	call DelayFrames ; $5a6a
	script_set_position $13, $0e80, $2780 ; $5a6d
	sound $99 ; $5a78
	ld a, $3c ; $5a7a
	call DelayFrames ; $5a7c
	script_set_position $13, $3f00, $3f00 ; $5a7f
	script_face $04, FACE_UP ; $5a8a
	script_face $05, FACE_UP ; $5a91
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
	ld de, $d000 ; $5ae5
	farcall AttachActorStepMover ; $5ae8
	ret ; $5aeb
SpeakPartnerVariantLine:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5aec
	and a, a ; $5aef
	jr nz, Label_0f_5afb ; $5af0
	script_speak ACTOR_PARTNER ; $5af2
	farcall AdvanceDialogueTextCursor ; $5af7
	ret ; $5afa
Label_0f_5afb:
	farcall AdvanceDialogueTextCursor ; $5afb
	script_speak ACTOR_PARTNER ; $5afe
	ret ; $5b03
AwardsCeremonyScriptsDoubles_0f:
	; $5b04, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_25_183, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_25_165, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_25_166, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_25_175, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_177, $03, $00
	map_script $08, FACEMASK_ANY, $0000, AwardsCeremonyNpc08_0f, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_130, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_131, $03, $00
	map_script $12, FACEMASK_ANY, $0000, Text_25_176, $03, $00
	db $ff
AwardsCeremonyArrivalIntro:
	script_player_speed $00ff ; $5b4d
	script_move_player $0c00, $0b00 ; $5b53
	farcall WaitPlayerMoveDone ; $5b5d
	xor a, a ; $5b60
	ld [wStoryModeShowLocationName], a ; $5b61
	script_fade_in $04 ; $5b64
	call WaitFadeEnd ; $5b69
	script_set_objdef $30, $13 ; $5b6c
	script_set_anim $13, $01 ; $5b78
	script_set_objdef $3a, $14 ; $5b7f
	script_set_anim $14, $01 ; $5b8b
	script_set_position $13, $0700, $0100 ; $5b92
	script_set_position $14, $0f00, $0100 ; $5b9d
	script_set_speed $13, $0020 ; $5ba8
	script_move_target $13, $0700, $0500 ; $5bb0
	script_wait_move $13 ; $5bbb
	script_set_anim $13, $04 ; $5bc0
	script_wait_idle $13 ; $5bc7
	script_jump_velocity $13, $ff80 ; $5bcc
	ld a, $13 ; $5bd4
	farcall ScriptWaitActorJumpDone ; $5bd6
	script_set_speed $14, $0020 ; $5bd9
	script_move_target $14, $0f00, $0780 ; $5be1
	script_wait_move $14 ; $5bec
	script_jump_velocity $13, $ff80 ; $5bf1
	script_set_anim $14, $02 ; $5bf9
	script_player_speed $0010 ; $5c00
	script_move_player_to_actor ACTOR_PLAYER ; $5c06
	farcall WaitPlayerMoveDone ; $5c0d
	ld a, $1e ; $5c10
	call DelayFrames ; $5c12
	script_set_objdef $4e, $13 ; $5c15
	script_set_anim $13, $01 ; $5c21
	script_set_objdef $53, $14 ; $5c28
	script_set_anim $14, $01 ; $5c34
	script_set_position $13, $3f00, $3f00 ; $5c3b
	script_set_position $14, $3f00, $3f00 ; $5c46
	ret ; $5c51
AnnounceWinnersToPodiums:
	script_face_pair $0c, $0b ; $5c52
	ld a, $1e ; $5c5a
	call DelayFrames ; $5c5c
	script_set_anim $0b, $03 ; $5c5f
	script_wait_idle $0b ; $5c66
	script_set_anim $0c, $03 ; $5c6b
	script_wait_idle $0c ; $5c72
	ld a, $1e ; $5c77
	call DelayFrames ; $5c79
	script_face $0b, FACE_RIGHT ; $5c7c
	script_face $0c, FACE_RIGHT ; $5c83
	script_set_text Text_25_133 ; $5c8a
	script_speak $0b ; $5c90
	ret ; $5c95
FaceAwardsCeremonyCrowdUp:
	script_face $05, FACE_UP ; $5c96
	script_face $08, FACE_UP ; $5c9d
	script_face $09, FACE_UP ; $5ca4
	script_face $0a, FACE_UP ; $5cab
	script_face $06, FACE_UP ; $5cb2
	script_face $12, FACE_UP ; $5cb9
	script_face $07, FACE_UP ; $5cc0
	script_face $11, FACE_UP ; $5cc7
	ret ; $5cce
AwardsCeremonyChairmanSpeech:
	ld a, $1e ; $5ccf
	call DelayFrames ; $5cd1
	script_speak $0b ; $5cd4
	script_set_anim $0b, $03 ; $5cd9
	script_wait_idle $0b ; $5ce0
	script_face $0b, FACE_UP ; $5ce5
	ld a, $1e ; $5cec
	call DelayFrames ; $5cee
	script_facing_lock $0b, $01 ; $5cf1
	script_move_target $0b, $0700, $1b00 ; $5cf8
	script_wait_move $0b ; $5d03
	script_facing_lock $0b, FACE_RIGHT ; $5d08
	script_face $0b, FACE_RIGHT ; $5d0f
	script_move_target $0c, $0800, $1900 ; $5d16
	script_wait_move $0c ; $5d21
	script_face $0c, FACE_RIGHT ; $5d26
	ld a, $1e ; $5d2d
	call DelayFrames ; $5d2f
	script_set_anim $0c, $03 ; $5d32
	script_wait_idle $0c ; $5d39
	script_speak $0c ; $5d3e
	script_set_anim $0c, $04 ; $5d43
	script_wait_idle $0c ; $5d4a
	script_speak $0c ; $5d4f
	script_set_anim $0c, $02 ; $5d54
	script_wait_idle $0c ; $5d5b
	script_speak $0c ; $5d60
	script_set_anim $0c, $04 ; $5d65
	script_wait_idle $0c ; $5d6c
	script_speak $0c ; $5d71
	script_set_anim $0c, $03 ; $5d76
	script_wait_idle $0c ; $5d7d
	script_speak $0c ; $5d82
	script_set_anim $0c, $03 ; $5d87
	script_wait_idle $0c ; $5d8e
	ld a, $3c ; $5d93
	call DelayFrames ; $5d95
	script_move_target $0c, $0800, $1700 ; $5d98
	script_wait_move $0c ; $5da3
	script_face $0c, FACE_RIGHT ; $5da8
	script_move_target $0b, $0800, $1900 ; $5daf
	script_wait_move $0b ; $5dba
	script_face $0b, FACE_RIGHT ; $5dbf
	ld a, $1e ; $5dc6
	call DelayFrames ; $5dc8
	script_speak $0b ; $5dcb
	script_set_objdef $30, $07 ; $5dd0
	script_set_anim $07, $01 ; $5ddc
	script_set_objdef $3a, $14 ; $5de3
	script_set_anim $14, $01 ; $5def
	script_set_position $07, $0700, $0500 ; $5df6
	script_set_position $14, $0f00, $0780 ; $5e01
	script_face $07, FACE_DOWN ; $5e0c
	script_face $14, FACE_DOWN ; $5e13
	ld a, $1e ; $5e1a
	call DelayFrames ; $5e1c
	script_move_player $0c00, $1100 ; $5e1f
	script_move_target $0c, $0c00, $1700 ; $5e29
	script_wait_move $0c ; $5e34
	script_move_target $0c, $0c00, $1300 ; $5e39
	script_wait_move $0c ; $5e44
	ret ; $5e49
AwardsCeremonySwapActors_0f:
	script_set_objdef $74, $10 ; $5e4a
	script_set_anim $10, $01 ; $5e56
	script_set_objdef $25, $0f ; $5e5d
	script_set_anim $0f, $01 ; $5e69
	script_set_position $0f, $1100, $1600 ; $5e70
	script_set_position $10, $1100, $1500 ; $5e7b
	script_face $0f, FACE_UP ; $5e86
	script_set_anim $10, $08 ; $5e8d
	script_move_target $10, $1100, $1200 ; $5e94
	script_move_target $0f, $1100, $1300 ; $5e9f
	script_wait_move $0f ; $5eaa
	script_set_objdef $25, $10 ; $5eaf
	script_set_anim $10, $01 ; $5ebb
	script_set_objdef $74, $0f ; $5ec2
	script_set_anim $0f, $01 ; $5ece
	script_set_position $10, $1100, $1300 ; $5ed5
	script_set_position $0f, $1000, $1300 ; $5ee0
	script_face $10, FACE_LEFT ; $5eeb
	script_set_anim $0f, $08 ; $5ef2
	script_move_target $10, $1000, $1300 ; $5ef9
	script_move_target $0f, $0f00, $1300 ; $5f04
	script_wait_move $0f ; $5f0f
	script_facing_lock $10, $01 ; $5f14
	script_move_target $10, $1100, $1300 ; $5f1b
	script_wait_move $10 ; $5f26
	script_facing_lock $10, FACE_RIGHT ; $5f2b
	script_set_speed $10, $0020 ; $5f32
	script_move_target $10, $1100, $1600 ; $5f3a
	script_wait_move $10 ; $5f45
	script_face $10, FACE_UP ; $5f4a
	ret ; $5f51
SavePlayerActorPosition:
	wram_bank $04 ; $5f52
	script_get_actor_state ACTOR_PLAYER ; $5f58
	ld c, l ; $5f5d
	ld b, h ; $5f5e
	ld hl, $000c ; $5f5f
	add hl, bc ; $5f62
	ld a, [hl+] ; $5f63
	ld d, [hl] ; $5f64
	ld e, a ; $5f65
	ld hl, $c2b2 ; $5f66
	ld a, e ; $5f69
	ld [hl+], a ; $5f6a
	ld [hl], d ; $5f6b
	ld hl, $000e ; $5f6c
	add hl, bc ; $5f6f
	ld a, [hl+] ; $5f70
	ld d, [hl] ; $5f71
	ld e, a ; $5f72
	ld hl, wWaterSpriteMinigameTimer ; $5f73
	ld a, e ; $5f76
	ld [hl+], a ; $5f77
	ld [hl], d ; $5f78
	ret ; $5f79
CheckAwardsCeremonyRivalSceneDone:
	test_flag $05, 7 ; $5f7a
	jr z, Label_0f_5f8a ; $5f7d
	ld a, $00 ; $5f7f
	test_flag $10, 4 ; $5f81
	jr z, Label_0f_5f93 ; $5f84
	ld a, $01 ; $5f86
	jr Label_0f_5f93 ; $5f88
Label_0f_5f8a:
	ld a, $00 ; $5f8a
	test_flag $10, 3 ; $5f8c
	jr z, Label_0f_5f93 ; $5f8f
	ld a, $01 ; $5f91
Label_0f_5f93:
	ret ; $5f93
TournamentMapScripts_0f:
	; $5f94, 14 bytes (map_tree)
	dw TournamentEntryPoints_0f ; slot 0 EntryPoints
	dw TournamentExitTriggers_0f ; slot 1 ExitTriggers
	dw TournamentActors_0f ; slot 2 Actors
	dw TournamentNpcScripts_0f ; slot 3 NpcScripts
	dw TournamentFacingScripts_0f ; slot 4 FacingScripts
	dw TournamentTileTriggers_0f ; slot 5 TileTriggers
	dw TournamentInitScript_0f ; slot 6 InitScript
TournamentActors_0f:
	; $5fa2, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $0c00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2300, $1100, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2300, $1700, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2100, $1100, FACE_RIGHT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1500, FACE_DOWN, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1300, FACE_DOWN, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1300, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1300, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1500, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1500, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1300, FACE_DOWN, $1f, $01, $00
	map_actor_end
TournamentEntryPoints_0f:
	; $6070, 65 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0e00, $0900, $0000
	map_entry $02, FACE_DOWN, $2a00, $0900, $0000
	map_entry $03, FACE_RIGHT, $0500, $0b00, $0000
	map_entry $04, FACE_LEFT, $3300, $0b00, $0000
	map_entry $05, FACE_UP, $1c00, $2300, $0000
	map_entry $0a, FACE_DOWN, $2500, $1100, $0000
	map_entry $0b, FACE_DOWN, $2300, $1100, $0000
	map_entry $0f, FACE_UP, $1b00, $3100, $0000
	db $ff
TournamentExitTriggers_0f:
	; $60b1, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TournamentExit_0f, $18, $01
	map_script $02, FACEMASK_ANY, $0000, TournamentExit_0f, $18, $02
	map_script $03, FACEMASK_ANY, $0000, TournamentExit_0f, $17, $01
	map_script $04, FACEMASK_ANY, $0000, TournamentExit_0f, $16, $01
	map_script $05, FACEMASK_ANY, $0000, TournamentExit_0f, $15, $03
	db $ff
TournamentExit_0f:
	clear_flag $17, 1 ; $60da
	ret ; $60dd
TournamentNpc0A_0f:
	script_set_text Text_1f_163 ; $60de
	ld a, $0b ; $60e4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $60e6
	farcall RunDialogueYesNoPrompt ; $60e9
	farcall ScriptCloseDialogueWindow ; $60ec
	script_wait_frames $05 ; $60ef
	and a, a ; $60f6
	jr z, Label_0f_60fc ; $60f7
	farcall AdvanceDialogueTextCursor ; $60f9
Label_0f_60fc:
	script_speak $0b ; $60fc
	ret ; $6101
TournamentNpcScripts_0f:
	; $6102, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_1f_159, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_1f_160, $13, $00
	map_script $08, FACEMASK_ANY, $0000, Text_1f_161, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_1f_162, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, TournamentNpc0A_0f, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_1f_166, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_1f_167, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_1f_168, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_1f_169, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_1f_170, $03, $00
	map_script $10, FACEMASK_ANY, $0000, Text_1f_171, $03, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
TournamentFacingScripts_0f:
	; $616b, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TournamentFacing01_0f, $00, $00
	db $ff
TournamentFacing01_0f:
	xor a, a ; $6174
	ldh [hBGColumnBlitPending], a ; $6175
	ldh [hBGRowBlitPending], a ; $6177
	ldh [hScrollY], a ; $6179
	ldh [hScrollX], a ; $617b
	ld [wCameraX + 1], a ; $617d
	ld [wCameraY + 1], a ; $6180
	call ClearFrameTasks ; $6183
	call GetIslandOpenRoundParams ; $6186
	ld d, $03 ; $6189
	farcall ShowRankingBoard ; $618b
	ld hl, wStoryModePlayersXPosition ; $618e
	ld de, wStoryModeSpawnPosition ; $6191
	ld bc, $0005 ; $6194
	call CopyMemoryBC ; $6197
	ld a, $ff ; $619a
	ld [wStoryModeEntryPoint], a ; $619c
	ld [$c294], a ; $619f
	ld [wStoryModeExitLocationRequest], a ; $61a2
	ret ; $61a5
TournamentTileTriggers_0f:
	; $61a6, 17 bytes (map_scripts)
	map_script $0e, FACEMASK_ANY, $0000, TournamentTile0E_0f, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, TournamentTile0F_0f, $00, $00
	db $ff
TournamentTile0E_0f:
	ld a, $01 ; $61b7
	ld [$c2b1], a ; $61b9
	script_null_script ACTOR_PARTNER ; $61bc
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_61e0 ; $61c1
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_61eb ; $61cc
	script_wait_actor_script ACTOR_PLAYER ; $61d7
	call IslandOpenRoundCallCutscene ; $61dc
	ret ; $61df
ActorScript_0f_61e0:
	; $61e0, 11 bytes (actor_script)
	as_set_target $1100, $1500
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_0f_61eb:
	; $61eb, 11 bytes (actor_script)
	as_set_target $0f00, $1500
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
TournamentTile0F_0f:
	ld a, $00 ; $61f6
	ld [$c2b1], a ; $61f8
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_61eb ; $61fb
	script_wait_actor_script ACTOR_PLAYER ; $6206
	call IslandOpenRoundCallCutscene ; $620b
	ret ; $620e
TournamentInitScript_0f:
	ld a, $01 ; $620f
	ld hl, UpdateTournamentActorDrawModes_0f ; $6211
	call RegisterFrameTask ; $6214
	ld a, [wStoryModeEntryPoint] ; $6217
	cp a, $ff ; $621a
	jr z, Label_0f_6221 ; $621c
	clear_flag $17, 1 ; $621e
Label_0f_6221:
	test_flag $17, 1 ; $6221
	jp z, Label_0f_62eb ; $6224
	call ComputeIslandOpenRound ; $6227
	ld a, [$c2b0] ; $622a
	and a, a ; $622d
	jr nz, Label_0f_628e ; $622e
	ldh a, [hRomBank] ; $6230
	ld hl, IslandOpenRoundActors_0f ; $6232
	farcall ScriptRespawnLocationActors ; $6235
	ld hl, IslandOpenRoundScripts_0f ; $6238
	ld de, $000c ; $623b
	farcall WriteStoryStateWord ; $623e
	farcall BeginCutsceneScriptMode ; $6241
	script_set_position $03, $1c00, $1c00 ; $6244
	script_set_position $04, $1c00, $1f00 ; $624f
	script_set_position $05, $1d00, $2100 ; $625a
	script_face $03, FACE_DOWN ; $6265
	script_face $04, FACE_DOWN ; $626c
	script_face $05, FACE_LEFT ; $6273
	test_flag $05, 7 ; $627a
	jr z, Label_0f_628a ; $627d
	script_set_position $05, $3f00, $3f00 ; $627f
Label_0f_628a:
	call SetPlayerAndPartnerObjectDefs ; $628a
	ret ; $628d
Label_0f_628e:
	test_flag $05, 7 ; $628e
	jr nz, Label_0f_62c4 ; $6291
	ldh a, [hRomBank] ; $6293
	ld hl, IslandOpenRoundActorsSingles_0f ; $6295
	farcall ScriptRespawnLocationActors ; $6298
	ld hl, IslandOpenRoundScriptsSingles_0f ; $629b
	ld de, $000c ; $629e
	farcall WriteStoryStateWord ; $62a1
	farcall BeginCutsceneScriptMode ; $62a4
	call SetPlayerAndPartnerObjectDefs ; $62a7
	script_face $03, FACE_RIGHT ; $62aa
	script_set_position $04, $2700, $1300 ; $62b1
	script_face $04, FACE_LEFT ; $62bc
	ret ; $62c3
Label_0f_62c4:
	ldh a, [hRomBank] ; $62c4
	ld hl, IslandOpenRoundActorsDoubles_0f ; $62c6
	farcall ScriptRespawnLocationActors ; $62c9
	ld hl, IslandOpenRoundScriptsDoubles_0f ; $62cc
	ld de, $000c ; $62cf
	farcall WriteStoryStateWord ; $62d2
	farcall BeginCutsceneScriptMode ; $62d5
	call SetPlayerAndPartnerObjectDefs ; $62d8
	script_face_toward ACTOR_PLAYER, $04 ; $62db
	script_face $03, FACE_RIGHT ; $62e3
	ret ; $62ea
Label_0f_62eb:
	ld a, [wStoryModeEntryPoint] ; $62eb
	cp a, $0f ; $62ee
	jr nz, Label_0f_62f6 ; $62f0
	call IslandOpenArrivalCutscene ; $62f2
	ret ; $62f5
Label_0f_62f6:
	cp a, $0a ; $62f6
	jr nz, Label_0f_62fe ; $62f8
	call IslandOpenSinglesMatchReturn ; $62fa
	ret ; $62fd
Label_0f_62fe:
	cp a, $0b ; $62fe
	jr nz, Label_0f_6306 ; $6300
	call $76a3 ; $6302
	ret ; $6305
Label_0f_6306:
	call LoadIslandOpenRoundNpcs ; $6306
	call SetPlayerAndPartnerObjectDefs ; $6309
	call WalkActorsInFromEntryPoint_0f ; $630c
	ret ; $630f
UpdateTournamentActorDrawModes_0f:
	ld a, $00 ; $6310
	call SetActorDrawModeFromSceneTile_0f ; $6312
	test_flag $05, 7 ; $6315
	ret z ; $6318
	ld a, $02 ; $6319
	call SetActorDrawModeFromSceneTile_0f ; $631b
	ret ; $631e
SetActorDrawModeFromSceneTile_0f:
	ld h, a ; $631f
	ld l, $00 ; $6320
	push af ; $6322
	wram_bank $04 ; $6323
	srl h ; $6329
	rr l ; $632b
	srl h ; $632d
	rr l ; $632f
	ld bc, $d000 ; $6331
	add hl, bc ; $6334
	ld b, h ; $6335
	ld c, l ; $6336
	ld hl, $000c ; $6337
	add hl, bc ; $633a
	ld a, [hl+] ; $633b
	ld h, [hl] ; $633c
	ld l, a ; $633d
	ld de, $ffb0 ; $633e
	add hl, de ; $6341
	ld d, h ; $6342
	ld hl, $000e ; $6343
	add hl, bc ; $6346
	ld a, [hl+] ; $6347
	add a, $40 ; $6348
	ld a, [hl] ; $634a
	adc a, $00 ; $634b
	ld e, a ; $634d
	dec e ; $634e
	pop af ; $634f
	or a, a ; $6350
	jr z, Label_0f_6355 ; $6351
	dec e ; $6353
	dec e ; $6354
Label_0f_6355:
	push de ; $6355
	call ReadSceneTilemapTile_0f ; $6356
	pop de ; $6359
	and a, $87 ; $635a
	cp a, $05 ; $635c
	jr nz, Label_0f_636f ; $635e
	wram_bank $04 ; $6360
	ld hl, $0020 ; $6366
	add hl, bc ; $6369
	ld a, [hl] ; $636a
	xor a, $01 ; $636b
	ld [hl], a ; $636d
	ret ; $636e
Label_0f_636f:
	inc d ; $636f
	call ReadSceneTilemapTile_0f ; $6370
	and a, $07 ; $6373
	cp a, $05 ; $6375
	jr nz, Label_0f_6388 ; $6377
	wram_bank $04 ; $6379
	ld hl, $0020 ; $637f
	add hl, bc ; $6382
	ld a, [hl] ; $6383
	xor a, $01 ; $6384
	ld [hl], a ; $6386
	ret ; $6387
Label_0f_6388:
	wram_bank $04 ; $6388
	ld hl, $0020 ; $638e
	add hl, bc ; $6391
	ld a, $02 ; $6392
	ld [hl], a ; $6394
	ret ; $6395
	ld h, a ; $6396
	ld l, $00 ; $6397
	wram_bank $04 ; $6399
	srl h ; $639f
	rr l ; $63a1
	srl h ; $63a3
	rr l ; $63a5
	ld bc, $d000 ; $63a7
	add hl, bc ; $63aa
	ld b, h ; $63ab
	ld c, l ; $63ac
	ld hl, $000c ; $63ad
	add hl, bc ; $63b0
	ld a, [hl+] ; $63b1
	ld h, [hl] ; $63b2
	ld l, a ; $63b3
	ld de, $ffb0 ; $63b4
	add hl, de ; $63b7
	ld d, h ; $63b8
	ld hl, $000e ; $63b9
	add hl, bc ; $63bc
	ld a, [hl+] ; $63bd
	add a, $40 ; $63be
	ld a, [hl] ; $63c0
	adc a, $00 ; $63c1
	ld e, a ; $63c3
	dec e ; $63c4
	dec e ; $63c5
	dec e ; $63c6
	push de ; $63c7
	call ReadSceneTilemapTile_0f ; $63c8
	pop de ; $63cb
	and a, $87 ; $63cc
	cp a, $05 ; $63ce
	jr nz, Label_0f_63e1 ; $63d0
	wram_bank $04 ; $63d2
	ld hl, $0020 ; $63d8
	add hl, bc ; $63db
	ld a, [hl] ; $63dc
	xor a, $01 ; $63dd
	ld [hl], a ; $63df
	ret ; $63e0
Label_0f_63e1:
	inc d ; $63e1
	call ReadSceneTilemapTile_0f ; $63e2
	and a, $07 ; $63e5
	cp a, $05 ; $63e7
	jr nz, Label_0f_63fa ; $63e9
	wram_bank $04 ; $63eb
	ld hl, $0020 ; $63f1
	add hl, bc ; $63f4
	ld a, [hl] ; $63f5
	xor a, $01 ; $63f6
	ld [hl], a ; $63f8
	ret ; $63f9
Label_0f_63fa:
	wram_bank $04 ; $63fa
	ld hl, $0020 ; $6400
	add hl, bc ; $6403
	ld a, $02 ; $6404
	ld [hl], a ; $6406
	ret ; $6407
ReadSceneTilemapTile_0f:
	wram_bank $02 ; $6408
	ld h, e ; $640e
	ld l, $00 ; $640f
	srl h ; $6411
	rr l ; $6413
	srl h ; $6415
	rr l ; $6417
	ld a, d ; $6419
	add a, l ; $641a
	ld l, a ; $641b
	jr nc, Label_0f_641f ; $641c
	inc h ; $641e
Label_0f_641f:
	ld d, h ; $641f
	ld e, l ; $6420
	ld l, c ; $6421
	ld h, b ; $6422
	add hl, de ; $6423
	ld a, [hl] ; $6424
	ret ; $6425
IslandOpenArrivalCutscene:
	set_flag $17, 1 ; $6426
	ldh a, [hRomBank] ; $6429
	ld hl, IslandOpenRoundActors_0f ; $642b
	farcall ScriptRespawnLocationActors ; $642e
	ld hl, IslandOpenRoundScripts_0f ; $6431
	ld de, $000c ; $6434
	farcall WriteStoryStateWord ; $6437
	farcall BeginCutsceneScriptMode ; $643a
	call ReplacePartnerWithStandInActor ; $643d
	script_player_speed $00ff ; $6440
	script_move_player $1c00, $2500 ; $6446
	farcall WaitPlayerMoveDone ; $6450
	script_fade_in $04 ; $6453
	call WaitFadeEnd ; $6458
	script_player_speed $0018 ; $645b
	script_move_player $1c00, $1b00 ; $6461
	script_move_target $03, $1c00, $1c00 ; $646b
	script_move_target $04, $1c00, $1f00 ; $6476
	script_move_target $05, $1d00, $2100 ; $6481
	script_move_target ACTOR_PLAYER, $1b00, $2100 ; $648c
	script_wait_move ACTOR_PLAYER ; $6497
	script_wait_frames $28 ; $649c
	script_face $03, FACE_DOWN ; $64a3
	script_set_text Text_1f_21 ; $64aa
	script_face ACTOR_PLAYER, FACE_DOWN ; $64b0
	script_wait_frames $28 ; $64b7
	script_face ACTOR_PLAYER, FACE_LEFT ; $64be
	script_wait_frames $28 ; $64c5
	script_face ACTOR_PLAYER, FACE_UP ; $64cc
	script_wait_frames $28 ; $64d3
	script_face ACTOR_PLAYER, FACE_RIGHT ; $64da
	script_wait_frames $28 ; $64e1
	script_face ACTOR_PLAYER, FACE_DOWN ; $64e8
	script_wait_frames $28 ; $64ef
	script_set_anim ACTOR_PLAYER, $02 ; $64f6
	script_wait_idle ACTOR_PLAYER ; $64fd
	script_face $04, FACE_RIGHT ; $6502
	script_face $04, FACE_DOWN ; $6509
	script_face $05, FACE_LEFT ; $6510
	script_wait_frames $14 ; $6517
	script_set_anim $04, $04 ; $651e
	script_wait_idle $04 ; $6525
	script_speak $04 ; $652a
	script_face ACTOR_PLAYER, FACE_UP ; $652f
	script_wait_frames $28 ; $6536
	script_set_anim ACTOR_PLAYER, $03 ; $653d
	script_wait_idle ACTOR_PLAYER ; $6544
	script_set_anim $03, $02 ; $6549
	script_wait_idle $03 ; $6550
	script_speak $03 ; $6555
	script_set_anim ACTOR_PLAYER, $02 ; $655a
	script_wait_idle ACTOR_PLAYER ; $6561
	test_flag $05, 7 ; $6566
	jr nz, Label_0f_6582 ; $6569
	script_set_anim $05, $03 ; $656b
	script_wait_idle $05 ; $6572
	script_speak $05 ; $6577
	set_flag $15, 6 ; $657c
	jr Label_0f_65a6 ; $657f
	ret ; $6581
Label_0f_6582:
	farcall AdvanceDialogueTextCursor ; $6582
	script_set_anim $04, $03 ; $6585
	script_wait_idle $04 ; $658c
	script_speak $04 ; $6591
	script_get_actor_state $05 ; $6596
	ld c, l ; $659b
	ld b, h ; $659c
	ld de, $d000 ; $659d
	farcall AttachActorStepMover ; $65a0
	set_flag $15, 7 ; $65a3
Label_0f_65a6:
	script_player_speed $0018 ; $65a6
	script_move_player $1c00, $1d00 ; $65ac
	farcall WaitPlayerMoveDone ; $65b6
	ld a, $00 ; $65b9
	ld [$c2b0], a ; $65bb
	farcall SaveStorySlotWithTimer ; $65be
	ret ; $65c1
IslandOpenRoundActors_0f:
	; $65c2, 52 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $1c00, $2c00, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1c00, $2f00, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $3100, FACE_UP, $5b, $01, $00
	map_actor_end
IslandOpenRoundScripts_0f:
	; $65f6, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_1f_25, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_1f_26, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_1f_27, $03, $00
	db $ff
ComputeIslandOpenRound:
	test_flag $05, 7 ; $660f
	jr nz, Label_0f_663b ; $6612
	test_flag $07, 5 ; $6614
	jr z, Label_0f_661f ; $6617
	ld a, $03 ; $6619
	ld [$c2b0], a ; $661b
	ret ; $661e
Label_0f_661f:
	test_flag $07, 6 ; $661f
	jr z, Label_0f_662a ; $6622
	ld a, $02 ; $6624
	ld [$c2b0], a ; $6626
	ret ; $6629
Label_0f_662a:
	test_flag $07, 7 ; $662a
	jr z, Label_0f_6635 ; $662d
	ld a, $01 ; $662f
	ld [$c2b0], a ; $6631
	ret ; $6634
Label_0f_6635:
	ld a, $00 ; $6635
	ld [$c2b0], a ; $6637
	ret ; $663a
Label_0f_663b:
	test_flag $06, 6 ; $663b
	jr z, Label_0f_6646 ; $663e
	ld a, $03 ; $6640
	ld [$c2b0], a ; $6642
	ret ; $6645
Label_0f_6646:
	test_flag $06, 7 ; $6646
	jr z, Label_0f_6635 ; $6649
	ld a, $02 ; $664b
	ld [$c2b0], a ; $664d
	ret ; $6650
LoadIslandOpenRoundNpcs:
	ld a, $00 ; $6651
	ld [$c2b0], a ; $6653
	test_flag $05, 7 ; $6656
	jr nz, Label_0f_66b8 ; $6659
	ld a, $f1 ; $665b
	ld d, $0e ; $665d
	ld e, $14 ; $665f
	farcall WriteBehaviorMapCell ; $6661
	test_flag $07, 5 ; $6664
	jr z, Label_0f_6680 ; $6667
	ldh a, [hRomBank] ; $6669
	ld hl, IslandOpenRound3Actors_0f ; $666b
	farcall ScriptRespawnLocationActors ; $666e
	ld hl, IslandOpenRound3Scripts_0f ; $6671
	ld de, $000c ; $6674
	farcall WriteStoryStateWord ; $6677
	ld a, $03 ; $667a
	ld [$c2b0], a ; $667c
	ret ; $667f
Label_0f_6680:
	test_flag $07, 6 ; $6680
	jr z, Label_0f_669c ; $6683
	ldh a, [hRomBank] ; $6685
	ld hl, IslandOpenRound2Actors_0f ; $6687
	farcall ScriptRespawnLocationActors ; $668a
	ld hl, IslandOpenRound2Scripts_0f ; $668d
	ld de, $000c ; $6690
	farcall WriteStoryStateWord ; $6693
	ld a, $02 ; $6696
	ld [$c2b0], a ; $6698
	ret ; $669b
Label_0f_669c:
	test_flag $07, 7 ; $669c
	jr z, Label_0f_66b7 ; $669f
	ldh a, [hRomBank] ; $66a1
	ld hl, IslandOpenRound1Actors_0f ; $66a3
	farcall ScriptRespawnLocationActors ; $66a6
	ld hl, IslandOpenRound1Scripts_0f ; $66a9
	ld de, $000c ; $66ac
	farcall WriteStoryStateWord ; $66af
	ld a, $01 ; $66b2
	ld [$c2b0], a ; $66b4
Label_0f_66b7:
	ret ; $66b7
Label_0f_66b8:
	ld a, $e1 ; $66b8
	ld d, $0e ; $66ba
	ld e, $14 ; $66bc
	farcall WriteBehaviorMapCell ; $66be
	ld a, $e1 ; $66c1
	ld d, $10 ; $66c3
	ld e, $14 ; $66c5
	farcall WriteBehaviorMapCell ; $66c7
	test_flag $06, 6 ; $66ca
	jr z, Label_0f_66e6 ; $66cd
	ldh a, [hRomBank] ; $66cf
	ld hl, IslandOpenRound3ActorsDoubles_0f ; $66d1
	farcall ScriptRespawnLocationActors ; $66d4
	ld hl, IslandOpenRound3ScriptsDoubles_0f ; $66d7
	ld de, $000c ; $66da
	farcall WriteStoryStateWord ; $66dd
	ld a, $03 ; $66e0
	ld [$c2b0], a ; $66e2
	ret ; $66e5
Label_0f_66e6:
	test_flag $06, 7 ; $66e6
	jr z, Label_0f_6702 ; $66e9
	ldh a, [hRomBank] ; $66eb
	ld hl, IslandOpenRound2ActorsDoubles_0f ; $66ed
	farcall ScriptRespawnLocationActors ; $66f0
	ld hl, IslandOpenRound2ScriptsDoubles_0f ; $66f3
	ld de, $000c ; $66f6
	farcall WriteStoryStateWord ; $66f9
	ld a, $02 ; $66fc
	ld [$c2b0], a ; $66fe
	ret ; $6701
Label_0f_6702:
	ldh a, [hRomBank] ; $6702
	ld hl, IslandOpenRound1ActorsDoubles_0f ; $6704
	farcall ScriptRespawnLocationActors ; $6707
	ld hl, IslandOpenRound1ScriptsDoubles_0f ; $670a
	ld de, $000c ; $670d
	farcall WriteStoryStateWord ; $6710
	ret ; $6713
IslandOpenRound1Actors_0f:
	; $6714, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $0b00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1500, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1300, FACE_DOWN, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1300, FACE_DOWN, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1500, FACE_DOWN, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1300, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1300, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1500, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1500, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_0f_7a73, $2900, $1300, FACE_DOWN, $1f, $01, $00
	map_actor_end
IslandOpenRound1Scripts_0f:
	; $67e2, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_1f_182, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_1f_183, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_1f_184, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_1f_185, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_1f_186, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_1f_187, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_1f_188, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_1f_189, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_1f_190, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_1f_191, $03, $00
	map_script $10, FACEMASK_ANY, $0000, Text_1f_192, $13, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound2Actors_0f:
	; $684b, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $0b00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1500, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2300, $1700, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1500, FACE_DOWN, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1500, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b61, $0700, $1f00, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1300, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0500, $2100, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_0f_7a73, $2900, $1300, FACE_DOWN, $1f, $01, $00
	map_actor_end
IslandOpenRound2Scripts_0f:
	; $6919, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_4, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_5, $13, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_6, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_7, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_8, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_9, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_10, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_11, $13, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_12, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_13, $03, $00
	map_script $10, FACEMASK_ANY, $0000, Text_25_14, $13, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound3Actors_0f:
	; $6982, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0e00, $0400, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2300, $1100, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2300, $1700, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1500, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2100, $1100, FACE_RIGHT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b61, $0700, $1f00, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1300, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0500, $2100, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_0f_7a73, $2900, $1300, FACE_DOWN, $1f, $01, $00
	map_actor_end
IslandOpenRound3Scripts_0f:
	; $6a50, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_15, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_16, $13, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_17, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_18, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_19, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_20, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_21, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_22, $13, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_23, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_24, $03, $00
	map_script $10, FACEMASK_ANY, $0000, Text_25_25, $13, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound1ActorsDoubles_0f:
	; $6ab9, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $0b00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2300, $1100, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2300, $1700, FACE_RIGHT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1300, FACE_DOWN, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1300, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1300, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_7a50, $1900, $10c0, FACE_LEFT, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1500, FACE_DOWN, $1f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1500, FACE_DOWN, $1e, $01, $05
	map_actor_end
IslandOpenRound1ScriptsDoubles_0f:
	; $6b79, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_26, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_27, $13, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_28, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_29, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0A_0f, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0B_0f, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_36, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0D_0f, $13, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_40, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_41, $03, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound1DoublesNpc0A_0f:
	script_set_text Text_25_30 ; $6bda
	ld a, $0a ; $6be0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6be2
	farcall RunDialogueYesNoPrompt ; $6be5
	farcall ScriptCloseDialogueWindow ; $6be8
	script_wait_frames $05 ; $6beb
	and a, a ; $6bf2
	jr z, Label_0f_6bf8 ; $6bf3
	farcall AdvanceDialogueTextCursor ; $6bf5
Label_0f_6bf8:
	script_speak $0a ; $6bf8
	ret ; $6bfd
IslandOpenRound1DoublesNpc0B_0f:
	script_set_text Text_25_33 ; $6bfe
	ld a, $0b ; $6c04
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c06
	farcall RunDialogueYesNoPrompt ; $6c09
	farcall ScriptCloseDialogueWindow ; $6c0c
	script_wait_frames $05 ; $6c0f
	and a, a ; $6c16
	jr z, Label_0f_6c1c ; $6c17
	farcall AdvanceDialogueTextCursor ; $6c19
Label_0f_6c1c:
	script_speak $0b ; $6c1c
	ret ; $6c21
IslandOpenRound1DoublesNpc0D_0f:
	script_set_text Text_25_37 ; $6c22
	ld a, $0d ; $6c28
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c2a
	farcall RunDialogueYesNoPrompt ; $6c2d
	farcall ScriptCloseDialogueWindow ; $6c30
	script_wait_frames $05 ; $6c33
	and a, a ; $6c3a
	jr z, Label_0f_6c40 ; $6c3b
	farcall AdvanceDialogueTextCursor ; $6c3d
Label_0f_6c40:
	script_speak $0d ; $6c40
	ret ; $6c45
IslandOpenRound2ActorsDoubles_0f:
	; $6c46, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $0b00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1500, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1900, $1500, FACE_DOWN, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1500, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1300, FACE_DOWN, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1300, FACE_DOWN, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1700, $1300, FACE_UP, $61, $01, $00
	map_actor $0000, ActorScript_0f_7a50, $1900, $10c0, FACE_LEFT, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1300, FACE_UP, $1f, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2500, $1900, FACE_DOWN, $1e, $01, $05
	map_actor_end
IslandOpenRound2ScriptsDoubles_0f:
	; $6d06, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_42, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_43, $03, $00
	map_script $08, FACEMASK_ANY, $0000, IslandOpenRound2DoublesNpc08_0f, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_47, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_48, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_49, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_50, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, IslandOpenRound2DoublesNpc0D_0f, $13, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_54, $13, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_55, $13, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound2DoublesNpc08_0f:
	script_set_text Text_25_44 ; $6d67
	ld a, $08 ; $6d6d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d6f
	farcall RunDialogueYesNoPrompt ; $6d72
	farcall ScriptCloseDialogueWindow ; $6d75
	script_wait_frames $05 ; $6d78
	and a, a ; $6d7f
	jr z, Label_0f_6d85 ; $6d80
	farcall AdvanceDialogueTextCursor ; $6d82
Label_0f_6d85:
	script_speak $08 ; $6d85
	ret ; $6d8a
IslandOpenRound2DoublesNpc0D_0f:
	script_set_text Text_25_51 ; $6d8b
	ld a, $0d ; $6d91
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d93
	farcall RunDialogueYesNoPrompt ; $6d96
	farcall ScriptCloseDialogueWindow ; $6d99
	script_wait_frames $05 ; $6d9c
	and a, a ; $6da3
	jr z, Label_0f_6da9 ; $6da4
	farcall AdvanceDialogueTextCursor ; $6da6
Label_0f_6da9:
	script_speak $0d ; $6da9
	ret ; $6dae
IslandOpenRound3ActorsDoubles_0f:
	; $6daf, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0e00, $0400, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2300, $1100, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2300, $1300, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0f00, $1300, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1100, $1300, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $1d00, $1500, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2900, $1500, FACE_DOWN, $1f, $01, $00
	map_actor $0000, ActorScript_0f_7b75, $2400, $1800, FACE_DOWN, $1e, $01, $05
	map_actor_end
IslandOpenRound3ScriptsDoubles_0f:
	; $6e6f, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_56, $03, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_57, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_58, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_59, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_60, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, IslandOpenRound3DoublesNpc0B_0f, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, IslandOpenRound3DoublesNpc0C_0f, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_67, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_68, $13, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_69, $13, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, $03, $00
	db $ff
IslandOpenRound3DoublesNpc0C_0f:
	script_set_text Text_25_64 ; $6ed0
	ld a, $0c ; $6ed6
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6ed8
	farcall RunDialogueYesNoPrompt ; $6edb
	farcall ScriptCloseDialogueWindow ; $6ede
	script_wait_frames $05 ; $6ee1
	and a, a ; $6ee8
	jr z, Label_0f_6eee ; $6ee9
	farcall AdvanceDialogueTextCursor ; $6eeb
Label_0f_6eee:
	script_speak $0c ; $6eee
	ret ; $6ef3
IslandOpenRound3DoublesNpc0B_0f:
	script_set_text Text_25_61 ; $6ef4
	ld a, $0b ; $6efa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6efc
	farcall RunDialogueYesNoPrompt ; $6eff
	farcall ScriptCloseDialogueWindow ; $6f02
	script_wait_frames $05 ; $6f05
	and a, a ; $6f0c
	jr z, Label_0f_6f12 ; $6f0d
	farcall AdvanceDialogueTextCursor ; $6f0f
Label_0f_6f12:
	script_speak $0b ; $6f12
	ret ; $6f17
	script_set_text Text_1f_163 ; $6f18
	ld a, $0b ; $6f1e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f20
	farcall RunDialogueYesNoPrompt ; $6f23
	farcall ScriptCloseDialogueWindow ; $6f26
	script_wait_frames $05 ; $6f29
	and a, a ; $6f30
	jr z, Label_0f_6f36 ; $6f31
	farcall AdvanceDialogueTextCursor ; $6f33
Label_0f_6f36:
	script_speak $0b ; $6f36
	ret ; $6f3b
TournamentNpc03_0f:
	script_set_text Text_1f_172 ; $6f3c
	ld a, $03 ; $6f42
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6f44
	farcall RunDialogueYesNoPrompt ; $6f47
	farcall ScriptCloseDialogueWindow ; $6f4a
	script_wait_frames $05 ; $6f4d
	and a, a ; $6f54
	jr nz, Label_0f_6f5d ; $6f55
	script_speak $03 ; $6f57
	ret ; $6f5c
Label_0f_6f5d:
	ld hl, $24ae ; $6f5d
	ld a, [$c2b0] ; $6f60
	add a, l ; $6f63
	ld l, a ; $6f64
	jr nc, Label_0f_6f68 ; $6f65
	inc h ; $6f67
Label_0f_6f68:
	farcall InitDialogueTextCursor ; $6f68
	script_speak $03 ; $6f6b
	ret ; $6f70
TournamentNpc04_0f:
	ld hl, $24b2 ; $6f71
	ld a, [$c2b0] ; $6f74
	add a, l ; $6f77
	ld l, a ; $6f78
	jr nc, Label_0f_6f7c ; $6f79
	inc h ; $6f7b
Label_0f_6f7c:
	farcall InitDialogueTextCursor ; $6f7c
	script_speak $04 ; $6f7f
	ret ; $6f84
MovePartnerForRoundCall_0f:
	test_flag $05, 7 ; $6f85
	jr z, Label_0f_6fc2 ; $6f88
	test_flag $06, 6 ; $6f8a
	jr nz, Label_0f_6fc2 ; $6f8d
	script_null_script $0d ; $6f8f
	script_move_target $0d, $1900, $1100 ; $6f94
	script_wait_move $0d ; $6f9f
	script_move_target $0d, $1900, $1300 ; $6fa4
	script_wait_move $0d ; $6faf
	script_face $0c, FACE_DOWN ; $6fb4
	script_face $0d, FACE_DOWN ; $6fbb
Label_0f_6fc2:
	ret ; $6fc2
IslandOpenRoundCallCutscene:
	script_set_text Text_25_94 ; $6fc3
	script_move_player $1100, $0f00 ; $6fc9
	farcall WaitPlayerMoveDone ; $6fd3
	script_move_target $05, $0e00, $0c00 ; $6fd6
	script_wait_move $05 ; $6fe1
	script_move_target $05, $1300, $0c00 ; $6fe6
	script_wait_move $05 ; $6ff1
	script_face $05, FACE_DOWN ; $6ff6
	script_set_anim $05, $02 ; $6ffd
	script_wait_idle $05 ; $7004
	call QueueUpcomingRoundNameText ; $7009
	script_speak $05 ; $700c
	call MovePartnerForRoundCall_0f ; $7011
	script_face $04, FACE_UP ; $7014
	script_set_anim $04, $03 ; $701b
	script_wait_idle $04 ; $7022
	script_face $04, FACE_DOWN ; $7027
	script_move_target $04, $1300, $1700 ; $702e
	script_move_target $05, $1300, $1700 ; $7039
	script_move_player $1100, $1300 ; $7044
	script_wait_move $04 ; $704e
	script_move_target $04, $1500, $1700 ; $7053
	script_wait_move $04 ; $705e
	script_face $04, FACE_UP ; $7063
	script_wait_move $05 ; $706a
	script_face $05, FACE_UP ; $706f
	call QueueUpcomingRoundNameText ; $7076
	script_speak $04 ; $7079
	script_face_pair $05, $04 ; $707e
	script_set_anim $04, $03 ; $7086
	script_wait_idle $04 ; $708d
	script_move_target $05, $1000, $1700 ; $7092
	ld a, [$c2b0] ; $709d
	cp a, $03 ; $70a0
	jr z, Label_0f_70bb ; $70a2
	script_move_target $04, $1800, $1700 ; $70a4
	script_wait_move $04 ; $70af
	script_face $04, FACE_UP ; $70b4
Label_0f_70bb:
	script_wait_move $05 ; $70bb
	script_face $05, FACE_UP ; $70c0
	script_speak $04 ; $70c7
	test_flag $05, 7 ; $70cc
	jp nz, Label_0f_722f ; $70cf
	script_set_speed ACTOR_PLAYER, $0020 ; $70d2
	script_face_pair $0a, ACTOR_PLAYER ; $70da
	script_wait_frames $1e ; $70e2
	script_face ACTOR_PLAYER, FACE_DOWN ; $70e9
	script_face $0a, FACE_DOWN ; $70f0
	script_set_anim $0a, $03 ; $70f7
	script_set_anim ACTOR_PLAYER, $03 ; $70fe
	script_wait_idle ACTOR_PLAYER ; $7105
	test_flag $07, 5 ; $710a
	jr z, Label_0f_716c ; $710d
	script_move_target $05, $1300, $1700 ; $710f
	script_wait_move $05 ; $711a
	script_set_actor_script $05, ActorScript_0f_73e4 ; $711f
	script_wait_frames $14 ; $712a
	script_set_actor_script $0a, ActorScript_0f_73e4 ; $7131
	script_wait_frames $14 ; $713c
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_73e4 ; $7143
	script_wait_frames $14 ; $714e
	script_move_player $1100, $0d00 ; $7155
	farcall WaitPlayerMoveDone ; $715f
	script_wait_frames $1e ; $7162
	jp Label_0f_71bf ; $7169
Label_0f_716c:
	script_move_target $05, $1300, $1700 ; $716c
	script_wait_move $05 ; $7177
	script_set_actor_script $05, ActorScript_0f_73be ; $717c
	script_wait_frames $14 ; $7187
	script_set_actor_script $0a, ActorScript_0f_73be ; $718e
	script_wait_frames $14 ; $7199
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_73be ; $71a0
	script_move_player $1100, $0d00 ; $71ab
	farcall WaitPlayerMoveDone ; $71b5
	script_wait_frames $3c ; $71b8
Label_0f_71bf:
	ld c, $10 ; $71bf
	call BeginFadeOut ; $71c1
	call WaitFadeEnd ; $71c4
	call ShowTournamentRankingBoard_0f ; $71c7
	ld a, $19 ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [wStoryModeEntryPoint], a ; $71d1
	ld a, $ff ; $71d4
	ld [$c294], a ; $71d6
	ld [wStoryModeExitLocationRequest], a ; $71d9
	farcall InitStoryMatchSettings ; $71dc
	test_flag $07, 5 ; $71df
	jr z, Label_0f_71f3 ; $71e2
	load_match_settings $0013 ; $71e4
	jr Label_0f_7228 ; $71f1
Label_0f_71f3:
	test_flag $07, 6 ; $71f3
	jr z, Label_0f_7207 ; $71f6
	load_match_settings $0012 ; $71f8
	jr Label_0f_7228 ; $7205
Label_0f_7207:
	test_flag $07, 7 ; $7207
	jr z, Label_0f_721b ; $720a
	load_match_settings $0011 ; $720c
	jr Label_0f_7228 ; $7219
Label_0f_721b:
	load_match_settings $0010 ; $721b
Label_0f_7228:
	farcall RunStoryMatch ; $7228
	farcall RestoreOverworldAfterMatch ; $722b
	ret ; $722e
Label_0f_722f:
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $722f
	script_set_speed ACTOR_PLAYER, $0020 ; $7237
	script_set_speed ACTOR_PARTNER, $0020 ; $723f
	script_wait_frames $14 ; $7247
	script_set_anim ACTOR_PARTNER, $03 ; $724e
	script_set_anim ACTOR_PLAYER, $03 ; $7255
	script_wait_idle ACTOR_PLAYER ; $725c
	script_face ACTOR_PLAYER, FACE_DOWN ; $7261
	script_face ACTOR_PARTNER, FACE_DOWN ; $7268
	test_flag $06, 6 ; $726f
	jp z, Label_0f_72e8 ; $7272
	script_move_target $05, $1300, $1700 ; $7275
	script_wait_move $05 ; $7280
	script_set_actor_script $05, ActorScript_0f_73e4 ; $7285
	script_wait_frames $14 ; $7290
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_73e4 ; $7297
	script_wait_frames $14 ; $72a2
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_73e4 ; $72a9
	script_wait_frames $3c ; $72b4
	script_set_actor_script $0b, ActorScript_0f_73fd ; $72bb
	script_wait_frames $14 ; $72c6
	script_set_actor_script $0a, ActorScript_0f_73fd ; $72cd
	script_move_player $1100, $0d00 ; $72d8
	farcall WaitPlayerMoveDone ; $72e2
	jp Label_0f_735f ; $72e5
Label_0f_72e8:
	script_move_target $05, $1300, $1700 ; $72e8
	script_wait_move $05 ; $72f3
	script_set_actor_script $05, ActorScript_0f_73be ; $72f8
	script_wait_frames $14 ; $7303
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_73be ; $730a
	script_wait_frames $14 ; $7315
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_73be ; $731c
	script_wait_frames $3c ; $7327
	script_set_actor_script $0b, ActorScript_0f_73d1 ; $732e
	script_wait_frames $14 ; $7339
	script_set_actor_script $0a, ActorScript_0f_73d1 ; $7340
	script_move_player $1100, $0d00 ; $734b
	farcall WaitPlayerMoveDone ; $7355
	script_wait_frames $3c ; $7358
Label_0f_735f:
	ld c, $10 ; $735f
	call BeginFadeOut ; $7361
	call WaitFadeEnd ; $7364
	call ShowTournamentRankingBoard_0f ; $7367
	ld a, $19 ; $736a
	ld [wStoryModeCurrentLocation], a ; $736c
	ld a, $0b ; $736f
	ld [wStoryModeEntryPoint], a ; $7371
	ld a, $ff ; $7374
	ld [$c294], a ; $7376
	ld [wStoryModeExitLocationRequest], a ; $7379
	farcall InitStoryMatchSettings ; $737c
	test_flag $06, 6 ; $737f
	jp z, Label_0f_7394 ; $7382
	load_match_settings $0113 ; $7385
	jr Label_0f_73b7 ; $7392
Label_0f_7394:
	test_flag $06, 7 ; $7394
	jp z, Label_0f_73aa ; $7397
	load_match_settings $0112 ; $739a
	jp Label_0f_73b7 ; $73a7
Label_0f_73aa:
	load_match_settings $0111 ; $73aa
Label_0f_73b7:
	farcall RunStoryMatch ; $73b7
	farcall RestoreOverworldAfterMatch ; $73ba
	ret ; $73bd
ActorScript_0f_73be:
	; $73be, 19 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0100, $0b00
	as_wait_move
	as_halt
ActorScript_0f_73d1:
	; $73d1, 19 bytes (actor_script)
	as_set_target $1300, $1300
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0100, $0b00
	as_wait_move
	as_halt
ActorScript_0f_73e4:
	; $73e4, 25 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
ActorScript_0f_73fd:
	; $73fd, 25 bytes (actor_script)
	as_set_target $1300, $1300
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
GetIslandOpenRoundParams:
	test_flag $05, 7 ; $7416
	jr nz, Label_0f_7425 ; $7419
	ld b, $00 ; $741b
	ld a, [$c2b0] ; $741d
	inc a ; $7420
	ld c, a ; $7421
	ld d, $00 ; $7422
	ret ; $7424
Label_0f_7425:
	ld b, $01 ; $7425
	ld a, [$c2b0] ; $7427
	inc a ; $742a
	cp a, $03 ; $742b
	jr c, Label_0f_7430 ; $742d
	dec a ; $742f
Label_0f_7430:
	ld c, a ; $7430
	ld d, $00 ; $7431
	ret ; $7433
ShowTournamentRankingBoard_0f:
	xor a, a ; $7434
	ldh [hBGColumnBlitPending], a ; $7435
	ldh [hBGRowBlitPending], a ; $7437
	ldh [hScrollY], a ; $7439
	ldh [hScrollX], a ; $743b
	ld [wCameraX + 1], a ; $743d
	ld [wCameraY + 1], a ; $7440
	call ClearFrameTasks ; $7443
	call GetIslandOpenRoundParams ; $7446
	farcall ShowRankingBoard ; $7449
	ret ; $744c
QueueUpcomingRoundNameText:
	ld a, [$c2b0] ; $744d
	ld hl, $2861 ; $7450
	add a, l ; $7453
	ld l, a ; $7454
	jr nc, Label_0f_7458 ; $7455
	inc h ; $7457
Label_0f_7458:
	call QueueShortText ; $7458
	ret ; $745b
CheckIslandOpenVictoryTransition:
	test_flag $05, 7 ; $745c
	jr nz, Label_0f_7468 ; $745f
	test_flag $07, 4 ; $7461
	jr nz, Label_0f_746f ; $7464
	jr Label_0f_7484 ; $7466
Label_0f_7468:
	test_flag $06, 5 ; $7468
	jr nz, Label_0f_746f ; $746b
	jr Label_0f_7484 ; $746d
Label_0f_746f:
	ld a, $1b ; $746f
	ld [wStoryModeCurrentLocation], a ; $7471
	ld a, $08 ; $7474
	ld [wStoryModeEntryPoint], a ; $7476
	ld a, $ff ; $7479
	ld [$c294], a ; $747b
	ld [wStoryModeExitLocationRequest], a ; $747e
	ld a, $01 ; $7481
	ret ; $7483
Label_0f_7484:
	ld a, $00 ; $7484
	ret ; $7486
IslandOpenSinglesMatchReturn:
	wram_bank $04 ; $7487
	ld a, [wMatchExitRequest] ; $748d
	cp a, $01 ; $7490
	jr z, Label_0f_749c ; $7492
	ld a, [wMatchWinLoseFlag] ; $7494
	cp a, $01 ; $7497
	jp z, Label_0f_74a3 ; $7499
Label_0f_749c:
	call LoadIslandOpenRoundNpcs ; $749c
	call SetPlayerAndPartnerObjectDefs ; $749f
	ret ; $74a2
Label_0f_74a3:
	clear_flag $0e, 6 ; $74a3
	clear_flag $0f, 0 ; $74a6
	call CheckIslandOpenVictoryTransition ; $74a9
	and a, a ; $74ac
	jr z, Label_0f_74b0 ; $74ad
	ret ; $74af
Label_0f_74b0:
	ldh a, [hRomBank] ; $74b0
	ld hl, IslandOpenRoundActorsSingles_0f ; $74b2
	farcall ScriptRespawnLocationActors ; $74b5
	ld hl, IslandOpenRoundScriptsSingles_0f ; $74b8
	ld de, $000c ; $74bb
	farcall WriteStoryStateWord ; $74be
	call ComputeIslandOpenRound ; $74c1
	farcall BeginCutsceneScriptMode ; $74c4
	call SetPlayerAndPartnerObjectDefs ; $74c7
	script_get_actor_state $08 ; $74ca
	ld c, l ; $74cf
	ld b, h ; $74d0
	ld hl, $0037 ; $74d1
	add hl, bc ; $74d4
	ld a, [hl] ; $74d5
	xor a, $20 ; $74d6
	ld [hl], a ; $74d8
	script_fade_in $04 ; $74d9
	call WaitFadeEnd ; $74de
	ld a, [$c2b0] ; $74e1
	add a, a ; $74e4
	add a, $99 ; $74e5
	ld l, a ; $74e7
	adc a, $76 ; $74e8
	sub a, l ; $74ea
	ld h, a ; $74eb
	ld a, [hl+] ; $74ec
	ld h, [hl] ; $74ed
	ld l, a ; $74ee
	farcall InitDialogueTextCursor ; $74ef
	script_set_position $08, $2200, $0f80 ; $74f2
	sound $97 ; $74fd
	script_wait_frames $2d ; $74ff
	script_set_anim $03, $02 ; $7506
	script_wait_idle $03 ; $750d
	script_face_toward $03, ACTOR_PLAYER ; $7512
	script_set_position $08, $3f00, $3f00 ; $751a
	script_speak $03 ; $7525
	script_set_anim $05, $02 ; $752a
	script_wait_idle $05 ; $7531
	script_face_toward $05, ACTOR_PLAYER ; $7536
	script_speak $05 ; $753e
	script_set_anim $04, $03 ; $7543
	script_wait_idle $04 ; $754a
	script_face_toward $04, ACTOR_PLAYER ; $754f
	script_speak $04 ; $7557
	call IslandOpenBreakCutscene ; $755c
	script_set_text Text_25_73 ; $755f
	ld a, [$c2b0] ; $7565
	dec a ; $7568
	ld hl, $2862 ; $7569
	add a, l ; $756c
	ld l, a ; $756d
	jr nc, Label_0f_7571 ; $756e
	inc h ; $7570
Label_0f_7571:
	call QueueShortText ; $7571
	script_face $04, FACE_UP ; $7574
	script_face $03, FACE_RIGHT ; $757b
	script_face_toward $04, ACTOR_PLAYER ; $7582
	script_speak $04 ; $758a
	script_move_angle $04, FACE_RIGHT, $0200 ; $758f
	script_wait_move $04 ; $7599
	script_wait_frames $0a ; $759e
	script_wait_frames $0a ; $75a5
	script_face $04, FACE_LEFT ; $75ac
	set_flag $17, 1 ; $75b3
	ret ; $75b6
IslandOpenRoundActorsSingles_0f:
	; $75b7, 94 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2300, $1100, FACE_RIGHT, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2500, $1300, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $4c, $01, $00
	map_actor_end
IslandOpenRoundScriptsSingles_0f:
	; $7615, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc04_0f, $03, $00
	map_script $05, FACEMASK_ANY, $0000, IslandOpenRoundSinglesNpc05_0f, $03, $00
	db $ff
IslandOpenRoundSinglesNpc04_0f:
	script_set_text Text_25_73 ; $762e
	ld a, [$c2b0] ; $7634
	dec a ; $7637
	ld hl, $2862 ; $7638
	add a, l ; $763b
	ld l, a ; $763c
	jr nc, Label_0f_7640 ; $763d
	inc h ; $763f
Label_0f_7640:
	call QueueShortText ; $7640
	script_speak $04 ; $7643
	ret ; $7648
IslandOpenRoundSinglesNpc03_0f:
	ld a, [$c2b0] ; $7649
	add a, a ; $764c
	add a, $99 ; $764d
	ld l, a ; $764f
	adc a, $76 ; $7650
	sub a, l ; $7652
	ld h, a ; $7653
	ld a, [hl+] ; $7654
	ld h, [hl] ; $7655
	ld l, a ; $7656
	farcall InitDialogueTextCursor ; $7657
	script_set_anim $03, $03 ; $765a
	script_wait_idle $03 ; $7661
	script_speak $03 ; $7666
	ret ; $766b
IslandOpenRoundSinglesNpc05_0f:
	ld a, [$c2b0] ; $766c
	dec a ; $766f
	add a, a ; $7670
	add a, $91 ; $7671
	ld l, a ; $7673
	adc a, $76 ; $7674
	sub a, l ; $7676
	ld h, a ; $7677
	ld a, [hl+] ; $7678
	ld h, [hl] ; $7679
	ld l, a ; $767a
	farcall InitDialogueTextCursor ; $767b
	script_jump_velocity $05, $ff80 ; $767e
	ld a, $05 ; $7686
	farcall ScriptWaitActorJumpDone ; $7688
	script_speak $05 ; $768b
	ret ; $7690
	db $47 ; $7691
	; $7692, 18 bytes (records:2)
	dw $4b28 ; record 0
	dw $4f28 ; record 1
	dw $4f28 ; record 2
	dw $4628 ; record 3
	dw $4628 ; record 4
	dw $4a28 ; record 5
	dw $4e28 ; record 6
	dw $5228 ; record 7
	dw $3e28 ; record 8
	inc b ; $76a4
	wram_bank ; $76a5
	ld a, [wMatchExitRequest] ; $76a9
	cp a, $01 ; $76ac
	jr z, Label_0f_76b8 ; $76ae
	ld a, [wMatchWinLoseFlag] ; $76b0
	cp a, $01 ; $76b3
	jp z, $76e9 ; $76b5
Label_0f_76b8:
	call LoadIslandOpenRoundNpcs ; $76b8
	call SetPlayerAndPartnerObjectDefs ; $76bb
	script_set_position ACTOR_PLAYER, $2500, $1100 ; $76be
	script_move_player $2500, $1100 ; $76c9
	script_set_position ACTOR_PARTNER, $2500, $1300 ; $76d3
	script_face ACTOR_PARTNER, FACE_UP ; $76de
	farcall WaitPlayerMoveDone ; $76e5
	ret ; $76e8
	db $ef ; $76e9
	ldh [$ff0e], a ; $76ea
	clear_flag $0f, 1 ; $76ec
	call CheckIslandOpenVictoryTransition ; $76ef
	and a, a ; $76f2
	jr z, Label_0f_76f6 ; $76f3
	ret ; $76f5
Label_0f_76f6:
	ldh a, [hRomBank] ; $76f6
	ld hl, IslandOpenRoundActorsDoubles_0f ; $76f8
	farcall ScriptRespawnLocationActors ; $76fb
	farcall BeginCutsceneScriptMode ; $76fe
	ld hl, IslandOpenRoundScriptsDoubles_0f ; $7701
	ld de, $000c ; $7704
	farcall WriteStoryStateWord ; $7707
	call SetPlayerAndPartnerObjectDefs ; $770a
	script_null_script ACTOR_PARTNER ; $770d
	script_set_position ACTOR_PARTNER, $2500, $1100 ; $7712
	script_face ACTOR_PARTNER, FACE_UP ; $771d
	script_fade_in $04 ; $7724
	call WaitFadeEnd ; $7729
	call ComputeIslandOpenRound ; $772c
	farcall BeginCutsceneScriptMode ; $772f
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7732
	script_fade_in $04 ; $773a
	call WaitFadeEnd ; $773f
	ld a, [$c2b0] ; $7742
	dec a ; $7745
	add a, a ; $7746
	add a, $3a ; $7747
	ld l, a ; $7749
	adc a, $78 ; $774a
	sub a, l ; $774c
	ld h, a ; $774d
	ld a, [hl+] ; $774e
	ld h, [hl] ; $774f
	ld l, a ; $7750
	farcall InitDialogueTextCursor ; $7751
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7754
	or a, a ; $7757
	jr nz, Label_0f_7763 ; $7758
	farcall AdvanceDialogueTextCursor ; $775a
	farcall AdvanceDialogueTextCursor ; $775d
	farcall AdvanceDialogueTextCursor ; $7760
Label_0f_7763:
	script_get_actor_state $08 ; $7763
	ld c, l ; $7768
	ld b, h ; $7769
	ld hl, $0037 ; $776a
	add hl, bc ; $776d
	ld a, [hl] ; $776e
	xor a, $20 ; $776f
	ld [hl], a ; $7771
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $7772
	script_jump_velocity ACTOR_PARTNER, $ff80 ; $777a
	ld a, $02 ; $7782
	farcall ScriptWaitActorJumpDone ; $7784
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $7787
	script_speak ACTOR_PARTNER ; $778f
	script_set_position $08, $2000, $0f80 ; $7794
	sound $97 ; $779f
	script_wait_frames $2d ; $77a1
	script_set_anim $03, $02 ; $77a8
	script_wait_idle $03 ; $77af
	script_set_position $08, $3f00, $3f00 ; $77b4
	script_face_toward $03, ACTOR_PLAYER ; $77bf
	script_speak $03 ; $77c7
	script_set_anim $04, $03 ; $77cc
	script_wait_idle $04 ; $77d3
	script_face_toward $04, ACTOR_PLAYER ; $77d8
	script_face_toward $04, ACTOR_PARTNER ; $77e0
	script_speak $04 ; $77e8
	call IslandOpenBreakCutscene ; $77ed
	script_face_toward ACTOR_PLAYER, $04 ; $77f0
	script_face $03, FACE_RIGHT ; $77f8
	script_set_text Text_25_73 ; $77ff
	ld a, [$c2b0] ; $7805
	dec a ; $7808
	ld hl, $2862 ; $7809
	add a, l ; $780c
	ld l, a ; $780d
	jr nc, Label_0f_7811 ; $780e
	inc h ; $7810
Label_0f_7811:
	call QueueShortText ; $7811
	script_face_toward $04, ACTOR_PLAYER ; $7814
	script_face_toward $04, ACTOR_PARTNER ; $781c
	script_speak $03 ; $7824
	set_flag $17, 1 ; $7829
	script_get_actor_state ACTOR_PARTNER ; $782c
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, $d000 ; $7833
	farcall AttachActorStepMover ; $7836
	ret ; $7839
	; $783a, 8 bytes (records:2)
	dw $2852 ; record 0
	dw $2852 ; record 1
	dw $2858 ; record 2
	dw $284e ; record 3
IslandOpenRoundActorsDoubles_0f:
	; $7842, 94 bytes (map_actors)
	map_actor $0000, ActorScript_0f_7b57, $2100, $1100, FACE_RIGHT, $5c, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $2700, $1100, FACE_LEFT, $5a, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $3d00, $3d00, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_0f_7b57, $0100, $3100, FACE_UP, $4c, $01, $00
	map_actor_end
IslandOpenRoundScriptsDoubles_0f:
	; $78a0, 17 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, IslandOpenRoundDoublesNpc03_0f, $03, $00
	map_script $04, FACEMASK_ANY, $0000, IslandOpenRoundDoublesNpc04_0f, $03, $00
	db $ff
IslandOpenRoundDoublesNpc04_0f:
	script_set_text Text_25_73 ; $78b1
	ld a, [$c2b0] ; $78b7
	dec a ; $78ba
	ld hl, $2862 ; $78bb
	add a, l ; $78be
	ld l, a ; $78bf
	jr nc, Label_0f_78c3 ; $78c0
	inc h ; $78c2
Label_0f_78c3:
	call QueueShortText ; $78c3
	script_speak $04 ; $78c6
	ret ; $78cb
IslandOpenRoundDoublesNpc03_0f:
	ld a, [$c2b0] ; $78cc
	dec a ; $78cf
	add a, a ; $78d0
	add a, $e4 ; $78d1
	ld l, a ; $78d3
	adc a, $78 ; $78d4
	sub a, l ; $78d6
	ld h, a ; $78d7
	ld a, [hl+] ; $78d8
	ld h, [hl] ; $78d9
	ld l, a ; $78da
	farcall InitDialogueTextCursor ; $78db
	script_speak $03 ; $78de
	ret ; $78e3
	; $78e4, 8 bytes (records:2)
	dw $2853 ; record 0
	dw $2853 ; record 1
	dw $2859 ; record 2
	dw $284f ; record 3
QueueFinishedRoundNameText:
	test_flag $05, 7 ; $78ec
	jr nz, Label_0f_7901 ; $78ef
	ld a, [$c2b0] ; $78f1
	dec a ; $78f4
	ld hl, $2861 ; $78f5
	add a, l ; $78f8
	ld l, a ; $78f9
	jr nc, Label_0f_78fd ; $78fa
	inc h ; $78fc
Label_0f_78fd:
	call QueueShortText ; $78fd
	ret ; $7900
Label_0f_7901:
	ld a, [$c2b0] ; $7901
	dec a ; $7904
	ld hl, $2865 ; $7905
	add a, l ; $7908
	ld l, a ; $7909
	jr nc, Label_0f_790d ; $790a
	inc h ; $790c
Label_0f_790d:
	call QueueShortText ; $790d
	ret ; $7910
IslandOpenBreakCutscene:
	script_set_position $06, $1500, $1700 ; $7911
	script_set_position $07, $1700, $1700 ; $791c
	script_move_target $06, $2300, $1700 ; $7927
	script_move_target $07, $2500, $1700 ; $7932
	script_wait_move $07 ; $793d
	script_set_text Text_25_105 ; $7942
	script_move_player $2300, $1100 ; $7948
	farcall WaitPlayerMoveDone ; $7952
	script_face $03, FACE_DOWN ; $7955
	script_face $04, FACE_DOWN ; $795c
	script_face $05, FACE_DOWN ; $7963
	script_face ACTOR_PLAYER, FACE_DOWN ; $796a
	script_face ACTOR_PARTNER, FACE_DOWN ; $7971
	script_face $06, FACE_UP ; $7978
	script_face $07, FACE_UP ; $797f
	script_set_anim $06, $03 ; $7986
	script_wait_idle $06 ; $798d
	call QueueFinishedRoundNameText ; $7992
	script_speak $06 ; $7995
	script_set_anim $06, $03 ; $799a
	script_wait_idle $06 ; $79a1
	ld a, [$c2b0] ; $79a6
	ld hl, $2861 ; $79a9
	add a, l ; $79ac
	ld l, a ; $79ad
	jr nc, Label_0f_79b1 ; $79ae
	inc h ; $79b0
Label_0f_79b1:
	call QueueShortText ; $79b1
	script_speak $06 ; $79b4
	script_face_pair $07, $06 ; $79b9
	script_wait_frames $14 ; $79c1
	script_set_anim $06, $03 ; $79c8
	script_set_anim $07, $03 ; $79cf
	script_wait_idle $07 ; $79d6
	script_move_target $06, $1500, $1700 ; $79db
	script_move_target $07, $1700, $1700 ; $79e6
	script_wait_move $07 ; $79f1
	script_move_player_to_actor ACTOR_PLAYER ; $79f6
	script_set_position $06, $3f00, $3f00 ; $79fd
	script_set_position $07, $3f00, $3f00 ; $7a08
	farcall WaitPlayerMoveDone ; $7a13
	ret ; $7a16
ReplacePartnerWithStandInActor:
	call SetPlayerAndPartnerObjectDefs ; $7a17
	test_flag $05, 7 ; $7a1a
	jr z, Label_0f_7a29 ; $7a1d
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7a1f
	or a, a ; $7a22
	jr nz, Label_0f_7a2a ; $7a23
	ld d, $58 ; $7a25
	jr Label_0f_7a2e ; $7a27
Label_0f_7a29:
	ret ; $7a29
Label_0f_7a2a:
	ld d, $59 ; $7a2a
	jr Label_0f_7a2e ; $7a2c
Label_0f_7a2e:
	script_get_actor_state $05 ; $7a2e
	ld c, l ; $7a33
	ld b, h ; $7a34
	farcall LoadActorObjectDefIfValid ; $7a35
	script_set_anim $05, $01 ; $7a38
	script_null_script ACTOR_PARTNER ; $7a3f
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $7a44
	ret ; $7a4f
ActorScript_0f_7a50:
	; $7a50, 35 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L8:
	as_target_rel $fe00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_target_rel $0200, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_jump .L8
ActorScript_0f_7a73:
	; $7a73, 27 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0006
.L8:
	as_set_target $2700, $1300
	as_wait_move
	as_wait $4b
	as_set_target $2900, $1300
	as_wait_move
	as_wait $78
	as_jump .L8
QueueShortText:
	ldh a, [hWramBank] ; $7a8e
	push af ; $7a90
	wram_bank $07 ; $7a91
	ld de, wTextArgFetchBuffer ; $7a97
	wram_bank $05 ; $7a9a
	farcall FetchShortTextToBuffer ; $7aa0
	ld hl, wTextArgFetchBuffer ; $7aa3
	farcall PushTextArgString ; $7aa6
	pop af ; $7aa9
	wram_bank ; $7aaa
	ret ; $7aae
WalkActorsInFromEntryPoint_0f:
	ld a, [wStoryModeEntryPoint] ; $7aaf
	cp a, $ff ; $7ab2
	jp z, Label_0f_7b15 ; $7ab4
	test_flag $05, 7 ; $7ab7
	jr z, Label_0f_7af8 ; $7aba
	script_set_speed ACTOR_PARTNER, $00ff ; $7abc
	ld a, [wStoryModeEntryPoint] ; $7ac4
	dec a ; $7ac7
	add a, $1b ; $7ac8
	ld l, a ; $7aca
	adc a, $7b ; $7acb
	sub a, l ; $7acd
	ld h, a ; $7ace
	ld b, [hl] ; $7acf
	ld a, $02 ; $7ad0
	ld b, b ; $7ad2
	ld de, $0200 ; $7ad3
	farcall MoveActorByAngle ; $7ad6
	script_wait_move ACTOR_PARTNER ; $7ad9
	ld a, [wStoryModeEntryPoint] ; $7ade
	dec a ; $7ae1
	add a, $16 ; $7ae2
	ld l, a ; $7ae4
	adc a, $7b ; $7ae5
	sub a, l ; $7ae7
	ld h, a ; $7ae8
	ld b, [hl] ; $7ae9
	ld a, $02 ; $7aea
	ld b, b ; $7aec
	farcall SetActorFacing ; $7aed
	script_set_speed ACTOR_PARTNER, $0010 ; $7af0
Label_0f_7af8:
	script_set_speed ACTOR_PLAYER, $0010 ; $7af8
	ld a, [wStoryModeEntryPoint] ; $7b00
	dec a ; $7b03
	add a, $16 ; $7b04
	ld l, a ; $7b06
	adc a, $7b ; $7b07
	sub a, l ; $7b09
	ld h, a ; $7b0a
	ld b, [hl] ; $7b0b
	ld a, $00 ; $7b0c
	ld b, b ; $7b0e
	ld de, $0200 ; $7b0f
	farcall MoveActorByAngle ; $7b12
Label_0f_7b15:
	ret ; $7b15
Facings_0f_7b16:
	; $7b16, 10 bytes (enum:FACE:10)
	db FACE_DOWN, FACE_DOWN, FACE_RIGHT, FACE_LEFT, FACE_UP, FACE_UP, FACE_UP, FACE_LEFT, FACE_RIGHT, FACE_DOWN ; 0x00
SetPlayerAndPartnerObjectDefs:
	test_flag $05, 7 ; $7b20
	jp z, Label_0f_7b3e ; $7b23
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7b26
	ld d, $58 ; $7b29
	add a, d ; $7b2b
	ld d, a ; $7b2c
	script_get_actor_state ACTOR_PARTNER ; $7b2d
	ld c, l ; $7b32
	ld b, h ; $7b33
	farcall LoadActorObjectDefIfValid ; $7b34
	script_set_anim ACTOR_PARTNER, $01 ; $7b37
Label_0f_7b3e:
	ld a, [wStoryModeGenderOfMainCharacter] ; $7b3e
	ld d, $56 ; $7b41
	add a, d ; $7b43
	ld d, a ; $7b44
	script_get_actor_state ACTOR_PLAYER ; $7b45
	ld c, l ; $7b4a
	ld b, h ; $7b4b
	farcall LoadActorObjectDefIfValid ; $7b4c
	script_set_anim ACTOR_PLAYER, $01 ; $7b4f
	ret ; $7b56
ActorScript_0f_7b57:
	; $7b57, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_0f_7b61:
	; $7b61, 20 bytes (actor_script)
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
ActorScript_0f_7b75:
	; $7b75, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1
	ret ; $7b7f
	xor a, a ; $7b80
	ld [$c2da], a ; $7b81
	ret ; $7b84
	sound $a2 ; $7b85
	ret ; $7b87
	xor a, a ; $7b88
	ld [wStoryModeShowLocationName], a ; $7b89
	ret ; $7b8c
ActorScript_0f_7b8d:
	; $7b8d, 438 bytes (actor_script)
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
	as_jump ActorScript_0f_7b8d
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
.L19a:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L19a
.L1a7:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L1a7
	test_flag $05, 7 ; $7d43
	jr nz, Label_0f_7d6a ; $7d46
	ld a, $00 ; $7d48
	test_flag $0a, 3 ; $7d4a
	jr z, Label_0f_7d66 ; $7d4d
	ld a, $02 ; $7d4f
	test_flag $0a, 7 ; $7d51
	jr z, Label_0f_7d66 ; $7d54
	ld a, $04 ; $7d56
	test_flag $15, 6 ; $7d58
	jr z, Label_0f_7d66 ; $7d5b
	ld a, $06 ; $7d5d
	test_flag $16, 0 ; $7d5f
	jr z, Label_0f_7d66 ; $7d62
	ld a, $08 ; $7d64
Label_0f_7d66:
	ld [$c2b0], a ; $7d66
	ret ; $7d69
Label_0f_7d6a:
	ld a, $01 ; $7d6a
	test_flag $08, 2 ; $7d6c
	jr z, Label_0f_7d66 ; $7d6f
	ld a, $03 ; $7d71
	test_flag $08, 6 ; $7d73
	jr z, Label_0f_7d66 ; $7d76
	ld a, $05 ; $7d78
	test_flag $15, 7 ; $7d7a
	jr z, Label_0f_7d66 ; $7d7d
	ld a, $07 ; $7d7f
	test_flag $16, 1 ; $7d81
	jr z, Label_0f_7d66 ; $7d84
	ld a, $09 ; $7d86
	jr Label_0f_7d66 ; $7d88
	ld a, $00 ; $7d8a
	test_flag $0a, 3 ; $7d8c
	jr z, Label_0f_7da9 ; $7d8f
	inc a ; $7d91
	test_flag $0a, 7 ; $7d92
	jr z, Label_0f_7da9 ; $7d95
	inc a ; $7d97
	test_flag $05, 7 ; $7d98
	jr nz, Label_0f_7dad ; $7d9b
	test_flag $15, 6 ; $7d9d
	jr z, Label_0f_7da9 ; $7da0
	inc a ; $7da2
	test_flag $16, 0 ; $7da3
	jr z, Label_0f_7da9 ; $7da6
	inc a ; $7da8
Label_0f_7da9:
	ld [$c2b0], a ; $7da9
	ret ; $7dac
Label_0f_7dad:
	test_flag $15, 7 ; $7dad
	jr z, Label_0f_7da9 ; $7db0
	inc a ; $7db2
	test_flag $16, 1 ; $7db3
	jr z, Label_0f_7da9 ; $7db6
	inc a ; $7db8
	jr Label_0f_7da9 ; $7db9
	; $7dbb, 581 bytes fill to bank end (linker-padded)
