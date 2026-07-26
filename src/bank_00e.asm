SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

DataPtr_TrainingGymMapScripts_0e:
	dw TrainingGymMapScripts_0e ; $4000
DataPtr_MarioWorldMapScripts_0e:
	dw MarioWorldMapScripts_0e ; $4002
DataPtr_SpecialCourtMapScripts_0e:
	dw SpecialCourtMapScripts_0e ; $4004
TrainingGymMapScripts_0e:
	; $4006, 14 bytes (map_tree)
	dw TrainingGymEntryPoints_0e ; slot 0 EntryPoints
	dw TrainingGymExitTriggers_0e ; slot 1 ExitTriggers
	dw TrainingGymActors_0e ; slot 2 Actors
	dw TrainingGymNpcScripts_0e ; slot 3 NpcScripts
	dw TrainingGymFacingScripts_0e ; slot 4 FacingScripts
	dw TrainingGymTileTriggers_0e ; slot 5 TileTriggers
	dw TrainingGymInitScript_0e ; slot 6 InitScript
TrainingGymActors_0e:
	; $4014, 178 bytes (map_actors)
	map_actor $0000, ActorScript_0e_7c6e, $2500, $0d00, FACE_DOWN, $42, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $2900, $0f00, FACE_DOWN, $45, $01, $05
	map_actor $0000, ActorScript_0e_7c6e, $2500, $1500, FACE_DOWN, $43, $01, $07
	map_actor $0000, ActorScript_0e_7c6e, $2900, $1300, FACE_DOWN, $44, $01, $05
	map_actor $0000, ActorScript_0e_7c6e, $2500, $0500, FACE_DOWN, $47, $01, $07
	map_actor $0000, ActorScript_0e_7c6e, $2700, $0700, FACE_DOWN, $46, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $2900, $0500, FACE_DOWN, $47, $01, $00
	map_actor $0000, ActorScript_0e_4712, $2100, $0c00, FACE_DOWN, $3b, $01, $00
	map_actor $0000, ActorScript_0e_48c9, $2c00, $0b00, FACE_LEFT, $3c, $01, $00
	map_actor $0000, ActorScript_0e_4a80, $2d60, $1700, FACE_RIGHT, $3b, $01, $06
	map_actor $0000, ActorScript_0e_5225, $1900, $1100, FACE_UP, $39, $01, $06
	map_actor $0000, ActorScript_0e_7c6e, $0d00, $1300, FACE_RIGHT, $39, $01, $07
	map_actor_end
TrainingGymEntryPoints_0e:
	; $40c6, 57 bytes (map_entries)
	map_entry $01, FACE_UP, $1600, $1800, TrainingGymArrival01_0e
	map_entry $02, FACE_DOWN, $0b00, $0c00, TrainingGymArrival02_0e
	map_entry $03, FACE_DOWN, $1500, $0c00, TrainingGymArrival03_0e
	map_entry $0b, FACE_DOWN, $0d00, $0f00, $0000
	map_entry $0c, FACE_LEFT, $1100, $1300, $0000
	map_entry $0d, FACE_DOWN, $0d00, $0f00, $0000
	map_entry $0e, FACE_LEFT, $1100, $1300, $0000
	db $ff
TrainingGymArrival01_0e:
	ld a, [wStoryModeEntryPoint] ; $40ff
	cp a, $ff ; $4102
	jp z, Label_0e_4144 ; $4104
	test_flag FLAG_DOUBLES ; $4107
	jr z, Label_0e_4132 ; $410a
	script_set_speed ACTOR_PARTNER, $00ff ; $410c
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $4114
	script_wait_move ACTOR_PARTNER ; $411e
	script_face ACTOR_PARTNER, FACE_UP ; $4123
	script_set_speed ACTOR_PARTNER, $0010 ; $412a
Label_0e_4132:
	script_set_speed ACTOR_PLAYER, $0010 ; $4132
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $413a
Label_0e_4144:
	ret ; $4144
TrainingGymArrival02_0e:
	ld a, [wStoryModeEntryPoint] ; $4145
	cp a, $ff ; $4148
	jp z, Label_0e_41e1 ; $414a
	script_set_speed ACTOR_PLAYER, $0010 ; $414d
	script_set_speed ACTOR_PARTNER, $0010 ; $4155
	farcall WaitPlayerMoveDone ; $415d
	script_copy_scene_rect $0a, $0a, $3d, $0c, $02, $02 ; $4160
	script_copy_scene_rect $3d, $0a, $0a, $0a, $02, $02 ; $416f
	script_wait_frames $02 ; $417e
	script_fade_in $08 ; $4185
	call WaitFadeEnd ; $418a
	script_move_target ACTOR_PLAYER, $0b00, $0e00 ; $418d
	script_wait_move ACTOR_PLAYER ; $4198
	sound $71 ; $419d
	script_wait_frames $02 ; $419f
	script_copy_scene_rect $3a, $0a, $0a, $0a, $02, $02 ; $41a6
	script_wait_frames $02 ; $41b5
	script_copy_scene_rect $37, $0a, $0a, $0a, $02, $02 ; $41bc
	script_wait_frames $02 ; $41cb
	script_copy_scene_rect $3d, $0c, $0a, $0a, $02, $02 ; $41d2
Label_0e_41e1:
	ret ; $41e1
TrainingGymArrival03_0e:
	ld a, [wStoryModeEntryPoint] ; $41e2
	cp a, $ff ; $41e5
	jr z, Label_0e_41e1 ; $41e7
	script_set_speed ACTOR_PLAYER, $0010 ; $41e9
	script_set_speed ACTOR_PARTNER, $0010 ; $41f1
	farcall WaitPlayerMoveDone ; $41f9
	script_copy_scene_rect $0a, $0a, $3d, $0c, $02, $02 ; $41fc
	script_copy_scene_rect $3d, $0a, $14, $0a, $02, $02 ; $420b
	script_fade_in $08 ; $421a
	call WaitFadeEnd ; $421f
	script_move_target ACTOR_PLAYER, $1500, $0e00 ; $4222
	script_wait_move ACTOR_PLAYER ; $422d
	sound $71 ; $4232
	script_wait_frames $02 ; $4234
	script_copy_scene_rect $3a, $0a, $14, $0a, $02, $02 ; $423b
	script_wait_frames $02 ; $424a
	script_copy_scene_rect $37, $0a, $14, $0a, $02, $02 ; $4251
	script_wait_frames $02 ; $4260
	script_copy_scene_rect $3d, $0c, $14, $0a, $02, $02 ; $4267
	ret ; $4276
TrainingGymExitTriggers_0e:
	; $4277, 25 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, $07, $01
	map_script $03, FACEMASK_ANY, $0000, TrainingGymExit03_0e, $12, $01
	map_script $02, FACEMASK_ANY, $0000, TrainingGymExit02_0e, $13, $01
	db $ff
TrainingGymExit02_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $4290
	script_facing_lock ACTOR_PLAYER, $01 ; $4297
	script_set_speed ACTOR_PLAYER, $0018 ; $429e
	script_move_target ACTOR_PLAYER, $0b00, $0d00 ; $42a6
	script_wait_move ACTOR_PLAYER ; $42b1
	farcall WaitPlayerMoveDone ; $42b6
	sound $71 ; $42b9
	script_copy_scene_rect $37, $0a, $0a, $0a, $02, $02 ; $42bb
	script_wait_frames $02 ; $42ca
	script_copy_scene_rect $3a, $0a, $0a, $0a, $02, $02 ; $42d1
	script_wait_frames $02 ; $42e0
	script_copy_scene_rect $3d, $0a, $0a, $0a, $02, $02 ; $42e7
	script_wait_frames $02 ; $42f6
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $42fd
	ld c, $08 ; $4307
	call BeginFadeOut ; $4309
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $430c
	script_wait_frames $0a ; $4313
	ret ; $431a
TrainingGymExit03_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $431b
	script_facing_lock ACTOR_PLAYER, $01 ; $4322
	script_set_speed ACTOR_PLAYER, $0018 ; $4329
	script_move_target ACTOR_PLAYER, $1500, $0d00 ; $4331
	script_wait_move ACTOR_PLAYER ; $433c
	farcall WaitPlayerMoveDone ; $4341
	sound $71 ; $4344
	script_copy_scene_rect $37, $0a, $14, $0a, $02, $02 ; $4346
	script_wait_frames $02 ; $4355
	script_copy_scene_rect $3a, $0a, $14, $0a, $02, $02 ; $435c
	script_wait_frames $02 ; $436b
	script_copy_scene_rect $3d, $0a, $14, $0a, $02, $02 ; $4372
	script_wait_frames $02 ; $4381
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $4388
	ld c, $08 ; $4392
	call BeginFadeOut ; $4394
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $4397
	script_wait_frames $0a ; $439e
	ret ; $43a5
TrainingGymNpc03_0e:
	ld a, [$c2b0] ; $43a6
	add a, a ; $43a9
	add a, $bd ; $43aa
	ld l, a ; $43ac
	adc a, $43 ; $43ad
	sub a, l ; $43af
	ld h, a ; $43b0
	ld a, [hl+] ; $43b1
	ld h, [hl] ; $43b2
	ld l, a ; $43b3
	farcall InitDialogueTextCursor ; $43b4
	script_speak $03 ; $43b7
	ret ; $43bc
	; $43bd, 20 bytes (records:2)
	dw $14a9 ; record 0
	dw $14a9 ; record 1
	dw $14b3 ; record 2
	dw $14b3 ; record 3
	dw $14bd ; record 4
	dw $14be ; record 5
	dw $14cb ; record 6
	dw $14cc ; record 7
	dw $14db ; record 8
	dw $14db ; record 9
TrainingGymNpc04_0e:
	ld a, [$c2b0] ; $43d1
	sra a ; $43d4
	add a, a ; $43d6
	add a, $ea ; $43d7
	ld l, a ; $43d9
	adc a, $43 ; $43da
	sub a, l ; $43dc
	ld h, a ; $43dd
	ld a, [hl+] ; $43de
	ld h, [hl] ; $43df
	ld l, a ; $43e0
	farcall InitDialogueTextCursor ; $43e1
	script_speak $04 ; $43e4
	ret ; $43e9
	; $43ea, 10 bytes (records:2)
	dw $14aa ; record 0
	dw $14b4 ; record 1
	dw $14bf ; record 2
	dw $14cd ; record 3
	dw $14dc ; record 4
TrainingGymNpc05_0e:
	ld a, [$c2b0] ; $43f4
	add a, a ; $43f7
	add a, $0b ; $43f8
	ld l, a ; $43fa
	adc a, $44 ; $43fb
	sub a, l ; $43fd
	ld h, a ; $43fe
	ld a, [hl+] ; $43ff
	ld h, [hl] ; $4400
	ld l, a ; $4401
	farcall InitDialogueTextCursor ; $4402
	script_speak $05 ; $4405
	ret ; $440a
	; $440b, 20 bytes (records:2)
	dw $14ab ; record 0
	dw $14ab ; record 1
	dw $14b5 ; record 2
	dw $14b5 ; record 3
	dw $14c0 ; record 4
	dw $14c1 ; record 5
	dw $14ce ; record 6
	dw $14cf ; record 7
	dw $14dd ; record 8
	dw $14dd ; record 9
TrainingGymNpc06_0e:
	ld a, [$c2b0] ; $441f
	add a, a ; $4422
	add a, $36 ; $4423
	ld l, a ; $4425
	adc a, $44 ; $4426
	sub a, l ; $4428
	ld h, a ; $4429
	ld a, [hl+] ; $442a
	ld h, [hl] ; $442b
	ld l, a ; $442c
	farcall InitDialogueTextCursor ; $442d
	script_speak $06 ; $4430
	ret ; $4435
	; $4436, 20 bytes (records:2)
	dw $14ac ; record 0
	dw $14ac ; record 1
	dw $14b6 ; record 2
	dw $14b6 ; record 3
	dw $14c2 ; record 4
	dw $14c2 ; record 5
	dw $14d0 ; record 6
	dw $14d1 ; record 7
	dw $14de ; record 8
	dw $14de ; record 9
TrainingGymNpc07_0e:
	ld a, [$c2b0] ; $444a
	sra a ; $444d
	cp a, $03 ; $444f
	jr z, Label_0e_4471 ; $4451
	add a, a ; $4453
	add a, $67 ; $4454
	ld l, a ; $4456
	adc a, $44 ; $4457
	sub a, l ; $4459
	ld h, a ; $445a
	ld a, [hl+] ; $445b
	ld h, [hl] ; $445c
	ld l, a ; $445d
	farcall InitDialogueTextCursor ; $445e
	script_speak $07 ; $4461
	ret ; $4466
	; $4467, 10 bytes (records:2)
	dw $14ad ; record 0
	dw $14b7 ; record 1
	dw $14c3 ; record 2
	dw $14d2 ; record 3
	dw $14df ; record 4
Label_0e_4471:
	script_set_text Text_35_210 ; $4471
	ld a, $07 ; $4477
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4479
	farcall RunDialogueYesNoPrompt ; $447c
	farcall ScriptCloseDialogueWindow ; $447f
	script_wait_frames $05 ; $4482
	and a, a ; $4489
	jr z, Label_0e_448f ; $448a
	farcall AdvanceDialogueTextCursor ; $448c
Label_0e_448f:
	script_speak $07 ; $448f
	ret ; $4494
TrainingGymNpc08_0e:
	ld a, [$c2b0] ; $4495
	sra a ; $4498
	add a, a ; $449a
	add a, $ae ; $449b
	ld l, a ; $449d
	adc a, $44 ; $449e
	sub a, l ; $44a0
	ld h, a ; $44a1
	ld a, [hl+] ; $44a2
	ld h, [hl] ; $44a3
	ld l, a ; $44a4
	farcall InitDialogueTextCursor ; $44a5
	script_speak $08 ; $44a8
	ret ; $44ad
	; $44ae, 10 bytes (records:2)
	dw $14ae ; record 0
	dw $14b8 ; record 1
	dw $14c4 ; record 2
	dw $14d5 ; record 3
	dw $14e0 ; record 4
TrainingGymNpc09_0e:
	ld a, [$c2b0] ; $44b8
	sra a ; $44bb
	add a, a ; $44bd
	add a, $d1 ; $44be
	ld l, a ; $44c0
	adc a, $44 ; $44c1
	sub a, l ; $44c3
	ld h, a ; $44c4
	ld a, [hl+] ; $44c5
	ld h, [hl] ; $44c6
	ld l, a ; $44c7
	farcall InitDialogueTextCursor ; $44c8
	script_speak $09 ; $44cb
	ret ; $44d0
	; $44d1, 10 bytes (records:2)
	dw $14af ; record 0
	dw $14b9 ; record 1
	dw $14c5 ; record 2
	dw $14d6 ; record 3
	dw $14e1 ; record 4
TrainingGymNpc0A_0e:
	ld a, [$c2b0] ; $44db
	add a, a ; $44de
	add a, $f2 ; $44df
	ld l, a ; $44e1
	adc a, $44 ; $44e2
	sub a, l ; $44e4
	ld h, a ; $44e5
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	farcall InitDialogueTextCursor ; $44e9
	script_speak $0a ; $44ec
	ret ; $44f1
	; $44f2, 20 bytes (records:2)
	dw $14b0 ; record 0
	dw $14b0 ; record 1
	dw $14ba ; record 2
	dw $14ba ; record 3
	dw $14c6 ; record 4
	dw $14c7 ; record 5
	dw $14d7 ; record 6
	dw $14d7 ; record 7
	dw $14e2 ; record 8
	dw $14e3 ; record 9
TrainingGymNpc0B_0e:
	ld a, [$c2b0] ; $4506
	add a, a ; $4509
	add a, $1d ; $450a
	ld l, a ; $450c
	adc a, $45 ; $450d
	sub a, l ; $450f
	ld h, a ; $4510
	ld a, [hl+] ; $4511
	ld h, [hl] ; $4512
	ld l, a ; $4513
	farcall InitDialogueTextCursor ; $4514
	script_speak $0b ; $4517
	ret ; $451c
	; $451d, 20 bytes (records:2)
	dw $14b1 ; record 0
	dw $14b1 ; record 1
	dw $14bb ; record 2
	dw $14bb ; record 3
	dw $14c8 ; record 4
	dw $14c8 ; record 5
	dw $14d8 ; record 6
	dw $14d9 ; record 7
	dw $14e4 ; record 8
	dw $14e5 ; record 9
TrainingGymNpc0C_0e:
	ld a, [$c2b0] ; $4531
	sra a ; $4534
	add a, a ; $4536
	add a, $4a ; $4537
	ld l, a ; $4539
	adc a, $45 ; $453a
	sub a, l ; $453c
	ld h, a ; $453d
	ld a, [hl+] ; $453e
	ld h, [hl] ; $453f
	ld l, a ; $4540
	farcall InitDialogueTextCursor ; $4541
	script_speak $0c ; $4544
	ret ; $4549
	; $454a, 10 bytes (records:2)
	dw $14b2 ; record 0
	dw $14bc ; record 1
	dw $14c9 ; record 2
	dw $14da ; record 3
	dw $14e6 ; record 4
TrainingGymNpcScripts_0e:
	; $4554, 89 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, TrainingGymNpc03_0e, $03, $00
	map_script $04, FACEMASK_ANY, $0000, TrainingGymNpc04_0e, $03, $00
	map_script $05, FACEMASK_ANY, $0000, TrainingGymNpc05_0e, $03, $00
	map_script $06, FACEMASK_ANY, $0000, TrainingGymNpc06_0e, $03, $00
	map_script $07, FACEMASK_ANY, $0000, TrainingGymNpc07_0e, $00, $00
	map_script $08, FACEMASK_ANY, $0000, TrainingGymNpc08_0e, $00, $00
	map_script $09, FACEMASK_ANY, $0000, TrainingGymNpc09_0e, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, TrainingGymNpc0A_0e, $13, $00
	map_script $0b, FACEMASK_ANY, $0000, TrainingGymNpc0B_0e, $10, $00
	map_script $0c, FACEMASK_ANY, $0000, TrainingGymNpc0C_0e, $13, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_6e_226, $13, $00
	db $ff
TrainingGymFacingScripts_0e:
	; $45ad, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TrainingGymFacing01_0e, $00, $00
	map_script $02, FACEMASK_ANY, $0000, TrainingGymFacing02_0e, $00, $00
	db $ff
TrainingGymFacing01_0e:
	ld a, $0b ; $45be
	ld [$c2b1], a ; $45c0
	script_player_speed $0040 ; $45c3
	script_move_player $0d00, $1300 ; $45c9
	farcall WaitPlayerMoveDone ; $45d3
	call RunRepairCounterDialogue ; $45d6
	ret ; $45d9
TrainingGymFacing02_0e:
	ld a, $0c ; $45da
	ld [$c2b1], a ; $45dc
	script_player_speed $0040 ; $45df
	script_move_player $0d00, $1300 ; $45e5
	farcall WaitPlayerMoveDone ; $45ef
	call RunRepairCounterDialogue ; $45f2
	ret ; $45f5
TrainingGymTileTriggers_0e:
	; $45f6, 17 bytes (map_scripts)
	map_script $02, FACEMASK_UP, $0000, TrainingGymTile02_0e, $00, $00
	map_script $03, FACEMASK_UP, $0000, TrainingGymTile03_0e, $00, $00
	db $ff
TrainingGymTile02_0e:
	ld a, $02 ; $4607
	ld [$c294], a ; $4609
	ld [wStoryModeExitLocationRequest], a ; $460c
	ret ; $460f
TrainingGymTile03_0e:
	ld a, $03 ; $4610
	ld [$c294], a ; $4612
	ld [wStoryModeExitLocationRequest], a ; $4615
	ret ; $4618
TrainingGymInitScript_0e:
	call ComputeTrainingGymProgressIndex ; $4619
	script_get_actor_state $07 ; $461c
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, $0018 ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	script_get_actor_state $08 ; $462a
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $0018 ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	script_get_actor_state $09 ; $4638
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, $0018 ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	script_set_anim $07, $05 ; $4646
	script_set_anim $08, $05 ; $464d
	script_set_anim $09, $05 ; $4654
	call SetupGymActorsForProgress ; $465b
	ld a, [wStoryModeEntryPoint] ; $465e
	cp a, $0b ; $4661
	jr nz, Label_0e_4669 ; $4663
	call RepairCounterReturnA ; $4665
	ret ; $4668
Label_0e_4669:
	cp a, $0c ; $4669
	jr nz, Label_0e_4671 ; $466b
	call RepairCounterReturnB ; $466d
	ret ; $4670
Label_0e_4671:
	cp a, $0d ; $4671
	jr nz, Label_0e_4679 ; $4673
	call RepairCounterChangedReturnA ; $4675
	ret ; $4678
Label_0e_4679:
	cp a, $0e ; $4679
	jr nz, Label_0e_4680 ; $467b
	call RepairCounterChangedReturnB ; $467d
Label_0e_4680:
	ret ; $4680
SetupGymActorsForProgress:
	ld a, [$c2b0] ; $4681
	sra a ; $4684
	cp a, $01 ; $4686
	jr z, Label_0e_4693 ; $4688
	cp a, $03 ; $468a
	jr z, Label_0e_46b9 ; $468c
	cp a, $04 ; $468e
	jr z, Label_0e_46e9 ; $4690
	ret ; $4692
Label_0e_4693:
	script_set_objdef $34, $04 ; $4693
	script_set_anim $03, $01 ; $469f
	script_set_position $04, $2700, $0f00 ; $46a6
	script_face $04, FACE_RIGHT ; $46b1
	ret ; $46b8
Label_0e_46b9:
	script_set_position $07, $2900, $0700 ; $46b9
	script_set_position $08, $2700, $0500 ; $46c4
	script_set_position $09, $2500, $0700 ; $46cf
	script_get_actor_state $07 ; $46da
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
Label_0e_46e9:
	script_set_position $07, $2900, $0700 ; $46e9
	script_set_position $08, $2700, $0500 ; $46f4
	script_set_position $09, $2500, $0700 ; $46ff
	script_set_anim $07, $02 ; $470a
	ret ; $4711
ActorScript_0e_4712:
	; $4712, 439 bytes (actor_script)
	as_set_target $2100, $0d00
	as_call $4c37
	as_wait_move
	as_set_target $2100, $0e00
	as_call $4c37
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2100, $0f00
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1000
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1100
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1200
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1300
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1400
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1500
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1600
	as_call $4c37
	as_wait_move
	as_set_target $2100, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2200, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2300, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2400, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2500, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2600, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2700, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2800, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2900, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2a00, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2b00, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2c00, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1700
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1600
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1500
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1400
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1300
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1200
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1100
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $1000
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $0f00
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $0e00
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $0d00
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $0c00
	as_call $4c37
	as_wait_move
	as_set_target $2d60, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2c00, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2b00, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2a00, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2900, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2800, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2700, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2600, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2500, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2400, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2300, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2200, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2100, $0b00
	as_call $4c37
	as_wait_move
	as_set_target $2100, $0c00
	as_call $4c37
	as_wait_move
	as_jump ActorScript_0e_4712
ActorScript_0e_48c9:
	; $48c9, 439 bytes (actor_script)
	as_set_target $2b00, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2a00, $0b00
	as_call $4c8e
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2900, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2800, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2700, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2600, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2500, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2400, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2300, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2200, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $0c00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $0d00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $0e00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $0f00
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1000
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1100
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1200
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1300
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1400
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1500
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1600
	as_call $4c8e
	as_wait_move
	as_set_target $2100, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2200, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2300, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2400, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2500, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2600, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2700, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2800, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2900, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2a00, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2b00, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2c00, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1700
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1600
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1500
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1400
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1300
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1200
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1100
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $1000
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $0f00
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $0e00
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $0d00
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $0c00
	as_call $4c8e
	as_wait_move
	as_set_target $2d60, $0b00
	as_call $4c8e
	as_wait_move
	as_set_target $2c00, $0b00
	as_call $4c8e
	as_wait_move
	as_jump ActorScript_0e_48c9
ActorScript_0e_4a80:
	; $4a80, 439 bytes (actor_script)
	as_set_target $2d60, $1600
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1500
	as_call $4ce5
	as_wait_move
	as_flag $01, $05, $02
	as_set_target $2d60, $1400
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1300
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1200
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1100
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1000
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $0f00
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $0e00
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $0d00
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $0c00
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2c00, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2b00, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2a00, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2900, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2800, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2700, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2600, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2500, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2400, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2300, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2200, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $0b00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $0c00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $0d00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $0e00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $0f00
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1000
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1100
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1200
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1300
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1400
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1500
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1600
	as_call $4ce5
	as_wait_move
	as_set_target $2100, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2200, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2300, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2400, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2500, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2600, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2700, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2800, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2900, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2a00, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2b00, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2c00, $1700
	as_call $4ce5
	as_wait_move
	as_set_target $2d60, $1700
	as_call $4ce5
	as_wait_move
	as_jump ActorScript_0e_4a80
	script_get_actor_state $0c ; $4c37
	ld c, l ; $4c3c
	ld b, h ; $4c3d
	ld hl, $000e ; $4c3e
	add hl, bc ; $4c41
	ld a, [hl+] ; $4c42
	ld d, [hl] ; $4c43
	ld e, a ; $4c44
	ld hl, wWaterSpriteMinigameTimer ; $4c45
	ld a, e ; $4c48
	ld [hl+], a ; $4c49
	ld [hl], d ; $4c4a
	ld hl, $000c ; $4c4b
	add hl, bc ; $4c4e
	ld a, [hl+] ; $4c4f
	ld d, [hl] ; $4c50
	ld e, a ; $4c51
	ld hl, $c2b2 ; $4c52
	ld a, e ; $4c55
	ld [hl+], a ; $4c56
	ld [hl], d ; $4c57
	script_get_actor_state $0a ; $4c58
	ld c, l ; $4c5d
	ld b, h ; $4c5e
	ld hl, $000a ; $4c5f
	add hl, bc ; $4c62
	ld a, [hl+] ; $4c63
	ld d, [hl] ; $4c64
	ld e, a ; $4c65
	ld hl, $c2b8 ; $4c66
	ld a, e ; $4c69
	ld [hl+], a ; $4c6a
	ld [hl], d ; $4c6b
	ld hl, $0008 ; $4c6c
	add hl, bc ; $4c6f
	ld a, [hl+] ; $4c70
	ld d, [hl] ; $4c71
	ld e, a ; $4c72
	ld hl, wWaterSpriteMinigameSwingCount ; $4c73
	ld a, e ; $4c76
	ld [hl+], a ; $4c77
	ld [hl], d ; $4c78
	jp Label_0e_4d3c ; $4c79
	script_get_actor_state $0a ; $4c7c
	ld c, l ; $4c81
	ld b, h ; $4c82
	ld hl, $0005 ; $4c83
	add hl, bc ; $4c86
	res 0, [hl] ; $4c87
	ld b, $00 ; $4c89
	ld a, $00 ; $4c8b
	ret ; $4c8d
	script_get_actor_state $0a ; $4c8e
	ld c, l ; $4c93
	ld b, h ; $4c94
	ld hl, $000e ; $4c95
	add hl, bc ; $4c98
	ld a, [hl+] ; $4c99
	ld d, [hl] ; $4c9a
	ld e, a ; $4c9b
	ld hl, wWaterSpriteMinigameTimer ; $4c9c
	ld a, e ; $4c9f
	ld [hl+], a ; $4ca0
	ld [hl], d ; $4ca1
	ld hl, $000c ; $4ca2
	add hl, bc ; $4ca5
	ld a, [hl+] ; $4ca6
	ld d, [hl] ; $4ca7
	ld e, a ; $4ca8
	ld hl, $c2b2 ; $4ca9
	ld a, e ; $4cac
	ld [hl+], a ; $4cad
	ld [hl], d ; $4cae
	script_get_actor_state $0b ; $4caf
	ld c, l ; $4cb4
	ld b, h ; $4cb5
	ld hl, $000a ; $4cb6
	add hl, bc ; $4cb9
	ld a, [hl+] ; $4cba
	ld d, [hl] ; $4cbb
	ld e, a ; $4cbc
	ld hl, $c2b8 ; $4cbd
	ld a, e ; $4cc0
	ld [hl+], a ; $4cc1
	ld [hl], d ; $4cc2
	ld hl, $0008 ; $4cc3
	add hl, bc ; $4cc6
	ld a, [hl+] ; $4cc7
	ld d, [hl] ; $4cc8
	ld e, a ; $4cc9
	ld hl, wWaterSpriteMinigameSwingCount ; $4cca
	ld a, e ; $4ccd
	ld [hl+], a ; $4cce
	ld [hl], d ; $4ccf
	jp Label_0e_4d3c ; $4cd0
	script_get_actor_state $0b ; $4cd3
	ld c, l ; $4cd8
	ld b, h ; $4cd9
	ld hl, $0005 ; $4cda
	add hl, bc ; $4cdd
	res 0, [hl] ; $4cde
	ld b, $00 ; $4ce0
	ld a, $00 ; $4ce2
	ret ; $4ce4
	script_get_actor_state $0b ; $4ce5
	ld c, l ; $4cea
	ld b, h ; $4ceb
	ld hl, $000e ; $4cec
	add hl, bc ; $4cef
	ld a, [hl+] ; $4cf0
	ld d, [hl] ; $4cf1
	ld e, a ; $4cf2
	ld hl, wWaterSpriteMinigameTimer ; $4cf3
	ld a, e ; $4cf6
	ld [hl+], a ; $4cf7
	ld [hl], d ; $4cf8
	ld hl, $000c ; $4cf9
	add hl, bc ; $4cfc
	ld a, [hl+] ; $4cfd
	ld d, [hl] ; $4cfe
	ld e, a ; $4cff
	ld hl, $c2b2 ; $4d00
	ld a, e ; $4d03
	ld [hl+], a ; $4d04
	ld [hl], d ; $4d05
	script_get_actor_state $0c ; $4d06
	ld c, l ; $4d0b
	ld b, h ; $4d0c
	ld hl, $000a ; $4d0d
	add hl, bc ; $4d10
	ld a, [hl+] ; $4d11
	ld d, [hl] ; $4d12
	ld e, a ; $4d13
	ld hl, $c2b8 ; $4d14
	ld a, e ; $4d17
	ld [hl+], a ; $4d18
	ld [hl], d ; $4d19
	ld hl, $0008 ; $4d1a
	add hl, bc ; $4d1d
	ld a, [hl+] ; $4d1e
	ld d, [hl] ; $4d1f
	ld e, a ; $4d20
	ld hl, wWaterSpriteMinigameSwingCount ; $4d21
	ld a, e ; $4d24
	ld [hl+], a ; $4d25
	ld [hl], d ; $4d26
	jp Label_0e_4d3c ; $4d27
	script_get_actor_state $0c ; $4d2a
	ld c, l ; $4d2f
	ld b, h ; $4d30
	ld hl, $0005 ; $4d31
	add hl, bc ; $4d34
	res 0, [hl] ; $4d35
	ld b, $00 ; $4d37
	ld a, $00 ; $4d39
	ret ; $4d3b
Label_0e_4d3c:
	ld hl, wWaterSpriteMinigameTimer ; $4d3c
	ld a, [hl+] ; $4d3f
	ld d, [hl] ; $4d40
	ld e, a ; $4d41
	ld hl, $c2b8 ; $4d42
	ld a, [hl+] ; $4d45
	ld h, [hl] ; $4d46
	ld l, a ; $4d47
	ld a, l ; $4d48
	sub a, e ; $4d49
	ld l, a ; $4d4a
	ld a, h ; $4d4b
	sbc a, d ; $4d4c
	ld h, a ; $4d4d
	bit 7, h ; $4d4e
	jr z, Label_0e_4d58 ; $4d50
	xor a, a ; $4d52
	sub a, l ; $4d53
	ld l, a ; $4d54
	sbc a, a ; $4d55
	sub a, h ; $4d56
	ld h, a ; $4d57
Label_0e_4d58:
	ld a, h ; $4d58
	cp a, $05 ; $4d59
	jr nc, Label_0e_4d83 ; $4d5b
	ld hl, $c2b2 ; $4d5d
	ld a, [hl+] ; $4d60
	ld d, [hl] ; $4d61
	ld e, a ; $4d62
	ld hl, wWaterSpriteMinigameSwingCount ; $4d63
	ld a, [hl+] ; $4d66
	ld h, [hl] ; $4d67
	ld l, a ; $4d68
	ld a, l ; $4d69
	sub a, e ; $4d6a
	ld l, a ; $4d6b
	ld a, h ; $4d6c
	sbc a, d ; $4d6d
	ld h, a ; $4d6e
	bit 7, h ; $4d6f
	jr z, Label_0e_4d79 ; $4d71
	xor a, a ; $4d73
	sub a, l ; $4d74
	ld l, a ; $4d75
	sbc a, a ; $4d76
	sub a, h ; $4d77
	ld h, a ; $4d78
Label_0e_4d79:
	ld a, h ; $4d79
	cp a, $05 ; $4d7a
	jr nc, Label_0e_4d83 ; $4d7c
	ld b, $01 ; $4d7e
	ld a, $01 ; $4d80
	ret ; $4d82
Label_0e_4d83:
	ld b, $00 ; $4d83
	ld a, $00 ; $4d85
	ret ; $4d87
RunRepairCounterDialogue:
	script_face_toward ACTOR_PLAYER, $0e ; $4d88
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $4d90
	jp z, .greeting ; $4d93
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $4d96
	jp z, .noRepair ; $4d99
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $4d9c
	jp z, .repairMenu ; $4d9f
	jp .repairMenu ; $4da2
.greeting:
	test_flag FLAG_DOUBLES ; $4da5
	jr nz, .doublesGreeting ; $4da8
	test_flag FLAG_REPAIR_COUNTER_GREETED ; $4daa
	jr z, .firstGreeting ; $4dad
	script_set_text Text_6e_228 ; $4daf
	jr .speak ; $4db5
.firstGreeting:
	script_set_text Text_6e_227 ; $4db7
	set_flag FLAG_REPAIR_COUNTER_GREETED ; $4dbd
.speak:
	script_speak $0e ; $4dc0
	script_face $0e, FACE_RIGHT ; $4dc5
	ret ; $4dcc
.doublesGreeting:
	test_flag FLAG_REPAIR_COUNTER_GREETED ; $4dcd
	jr z, .firstDoublesGreeting ; $4dd0
	script_set_text Text_6e_230 ; $4dd2
	jr .speak ; $4dd8
.firstDoublesGreeting:
	script_set_text Text_6e_229 ; $4dda
	set_flag FLAG_REPAIR_COUNTER_GREETED ; $4de0
	jr .speak ; $4de3
.repairMenu:
	set_flag FLAG_HAVE_LARGE_RACKET ; $4de5
	set_flag FLAG_HAVE_SMALL_RACKET ; $4de8
	set_flag FLAG_HAVE_LIGHT_SHOES ; $4deb
	script_set_text Text_6e_233 ; $4dee
	jr .done ; $4df4
	set_flag FLAG_HAVE_LARGE_RACKET ; $4df6
	set_flag FLAG_HAVE_SMALL_RACKET ; $4df9
	set_flag FLAG_HAVE_LIGHT_SHOES ; $4dfc
	set_flag FLAG_HAVE_IRON_RACKET ; $4dff
	set_flag FLAG_HAVE_IRON_SHOES ; $4e02
	script_set_text Text_6e_233 ; $4e05
	jr .done ; $4e0b
.noRepair:
	set_flag FLAG_HAVE_LARGE_RACKET ; $4e0d
	test_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $4e10
	jr z, .repaired ; $4e13
	script_set_text Text_6e_233 ; $4e15
	jr .done ; $4e1b
.repaired:
	script_set_text Text_6e_231 ; $4e1d
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $4e23
.done:
	script_face_toward ACTOR_PLAYER, $0e ; $4e26
	ld a, $0e ; $4e2e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e30
	farcall RunDialogueYesNoPrompt ; $4e33
	farcall ScriptCloseDialogueWindow ; $4e36
	script_wait_frames $05 ; $4e39
	and a, a ; $4e40
	jr z, Label_0e_4e4f ; $4e41
RepairCounterFarewell:
	script_set_text Text_6e_234 ; $4e43
	script_speak $0e ; $4e49
	ret ; $4e4e
Label_0e_4e4f:
	script_set_text Text_6e_235 ; $4e4f
	script_speak $0e ; $4e55
	script_wait_frames $05 ; $4e5a
RepairCounterServiceMenu:
	ld hl, $20ec ; $4e61
	ld de, $0101 ; $4e64
	farcall RunMenuFromText ; $4e67
Label_0e_4e6a:
	ld [$c2bc], a ; $4e6a
	cp a, $ff ; $4e6d
	jp z, RepairCounterFarewell ; $4e6f
	cp a, $02 ; $4e72
	jp z, RepairCounterFarewell ; $4e74
	cp a, $00 ; $4e77
	jp z, RepairCounterChangeRackets ; $4e79
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $4e7c
	jp nz, RepairCounterChangeShoes ; $4e7f
	script_set_text Text_6e_232 ; $4e82
	script_speak $0e ; $4e88
	script_set_text Text_6e_242 ; $4e8d
	ld a, $0e ; $4e93
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4e95
	farcall RunDialogueYesNoPrompt ; $4e98
	farcall ScriptCloseDialogueWindow ; $4e9b
	script_wait_frames $05 ; $4e9e
	and a, a ; $4ea5
	jr z, RepairCounterServiceMenu ; $4ea6
	jr RepairCounterFarewell ; $4ea8
	script_face $0e, FACE_RIGHT ; $4eaa
	ret ; $4eb1
PrepareEquipmentSelectScreen:
	ld a, [wEquippedRacket] ; $4eb2
	ld [wWaterSpriteMinigameFlag], a ; $4eb5
	ld a, $11 ; $4eb8
	ld [wStoryModeCurrentLocation], a ; $4eba
	ld a, [$c2b1] ; $4ebd
	ld [wStoryModeEntryPoint], a ; $4ec0
	ld a, $ff ; $4ec3
	ld [$c294], a ; $4ec5
	ld [wStoryModeExitLocationRequest], a ; $4ec8
	ld c, $10 ; $4ecb
	call BeginFadeOut ; $4ecd
	call WaitFadeEnd ; $4ed0
	call ClearFrameTasks ; $4ed3
	call DisableLCDSafely ; $4ed6
	farcall LoadMenuFontGfx ; $4ed9
	xor a, a ; $4edc
	ldh [hBGColumnBlitPending], a ; $4edd
	ldh [hBGRowBlitPending], a ; $4edf
	ldh [hScrollY], a ; $4ee1
	ldh [hScrollX], a ; $4ee3
	ld [wCameraX + 1], a ; $4ee5
	ret ; $4ee8
RepairCounterChangeRackets:
	script_set_text Text_6e_237 ; $4ee9
	script_speak $0e ; $4eef
	call PrepareEquipmentSelectScreen ; $4ef4
	farcall RunRacketSelectScreen ; $4ef7
	and a, a ; $4efa
	jr nz, Label_0e_4f1d ; $4efb
	jr RestoreScreenAfterEquipSelect ; $4efd
RepairCounterChangeShoes:
	script_set_text Text_6e_238 ; $4eff
	script_speak $0e ; $4f05
	call PrepareEquipmentSelectScreen ; $4f0a
	farcall RunShoesSelectScreen ; $4f0d
	and a, a ; $4f10
	jr nz, Label_0e_4f1d ; $4f11
RestoreScreenAfterEquipSelect:
	call DisableLCDSafely ; $4f13
	farcall LoadMenuFontGfx ; $4f16
	call EnableLCD ; $4f19
	ret ; $4f1c
Label_0e_4f1d:
	ld a, [$c2b1] ; $4f1d
	add a, $02 ; $4f20
	ld [$c2b1], a ; $4f22
	ld a, $11 ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [$c2b1] ; $4f2a
	ld [wStoryModeEntryPoint], a ; $4f2d
	ld a, $ff ; $4f30
	ld [$c294], a ; $4f32
	ld [wStoryModeExitLocationRequest], a ; $4f35
	call RestoreScreenAfterEquipSelect ; $4f38
	ret ; $4f3b
FetchAndPushShortTextArg:
	ldh a, [hWramBank] ; $4f3c
	push af ; $4f3e
	wram_bank $07 ; $4f3f
	ld de, wTextArgFetchBuffer ; $4f45
	wram_bank $05 ; $4f48
	farcall FetchShortTextToBuffer ; $4f4e
	ld hl, wTextArgFetchBuffer ; $4f51
	farcall PushTextArgString ; $4f54
	pop af ; $4f57
	wram_bank ; $4f58
	ret ; $4f5c
GetEquippedRacketNibble:
	ld a, [$c2bc] ; $4f5d
	and a, a ; $4f60
	jr z, .lowNibble ; $4f61
	jr .highNibble ; $4f63
.lowNibble:
	ld a, [wEquippedRacket] ; $4f65
	and a, $0f ; $4f68
	ret ; $4f6a
.highNibble:
	ld a, [wEquippedRacket] ; $4f6b
	and a, $f0 ; $4f6e
	swap a ; $4f70
	ret ; $4f72
PushEquipmentNameTextArg:
	ld a, [$c2bc] ; $4f73
	and a, a ; $4f76
	jr z, .racket ; $4f77
	jr .shoes ; $4f79
.racket:
	call GetEquippedRacketNibble ; $4f7b
	ld hl, $00e5 ; $4f7e
	add a, l ; $4f81
	ld l, a ; $4f82
	jr nc, .pushRacket ; $4f83
	inc h ; $4f85
.pushRacket:
	call FetchAndPushShortTextArg ; $4f86
	ret ; $4f89
.shoes:
	call GetEquippedRacketNibble ; $4f8a
	ld hl, $00f4 ; $4f8d
	add a, l ; $4f90
	ld l, a ; $4f91
	jr nc, .pushShoes ; $4f92
	inc h ; $4f94
.pushShoes:
	call FetchAndPushShortTextArg ; $4f95
	ret ; $4f98
InitEquipmentHandoutDialogue:
	ld a, [$c2bc] ; $4f99
	and a, a ; $4f9c
	jr z, Label_0e_4fa1 ; $4f9d
	jr Label_0e_4fb0 ; $4f9f
Label_0e_4fa1:
	call GetEquippedRacketNibble ; $4fa1
	ld hl, $2403 ; $4fa4
	add a, l ; $4fa7
	ld l, a ; $4fa8
	jr nc, Label_0e_4fac ; $4fa9
	inc h ; $4fab
Label_0e_4fac:
	farcall InitDialogueTextCursor ; $4fac
	ret ; $4faf
Label_0e_4fb0:
	call GetEquippedRacketNibble ; $4fb0
	ld hl, $240a ; $4fb3
	add a, l ; $4fb6
	ld l, a ; $4fb7
	jr nc, Label_0e_4fbb ; $4fb8
	inc h ; $4fba
Label_0e_4fbb:
	farcall InitDialogueTextCursor ; $4fbb
	ret ; $4fbe
RepairCounterReturnA:
	ld a, $0b ; $4fbf
	ld [$c2b1], a ; $4fc1
	script_face_toward ACTOR_PLAYER, $0e ; $4fc4
	script_set_position ACTOR_PARTNER, $0f00, $0f00 ; $4fcc
	jp RepairCounterCheckEquipChanged ; $4fd7
	ret ; $4fda
RepairCounterReturnB:
	ld a, $0c ; $4fdb
	ld [$c2b1], a ; $4fdd
	farcall WaitPlayerMoveDone ; $4fe0
	script_player_speed $00f0 ; $4fe3
	script_move_player $0d00, $1100 ; $4fe9
	farcall WaitPlayerMoveDone ; $4ff3
	script_set_position ACTOR_PARTNER, $1300, $1300 ; $4ff6
	jp RepairCounterCheckEquipChanged ; $5001
	ret ; $5004
CompareEquippedRacketToMinigameFlag:
	ld a, [wWaterSpriteMinigameFlag] ; $5005
	ld b, a ; $5008
	ld a, [wEquippedRacket] ; $5009
	cp a, b ; $500c
	jr z, Label_0e_5012 ; $500d
	ld a, $00 ; $500f
	ret ; $5011
Label_0e_5012:
	ld a, $ff ; $5012
	ret ; $5014
RepairCounterCheckEquipChanged:
	xor a, a ; $5015
	ld [wStoryModeShowLocationName], a ; $5016
	script_fade_in $08 ; $5019
	call WaitFadeEnd ; $501e
	call CompareEquippedRacketToMinigameFlag ; $5021
	cp a, $ff ; $5024
	jp nz, Label_0e_5056 ; $5026
	ld a, [$c2bc] ; $5029
	ld hl, $2401 ; $502c
	add a, l ; $502f
	ld l, a ; $5030
	jr nc, Label_0e_5034 ; $5031
	inc h ; $5033
Label_0e_5034:
	farcall InitDialogueTextCursor ; $5034
	call PushEquipmentNameTextArg ; $5037
	ld a, $0e ; $503a
	farcall ScriptShowSpeakerDialogueRestoreBG ; $503c
	farcall RunDialogueYesNoPrompt ; $503f
	farcall ScriptCloseDialogueWindow ; $5042
	script_wait_frames $05 ; $5045
	and a, a ; $504c
	jp nz, Label_0e_5080 ; $504d
	ld a, [$c2bc] ; $5050
	jp Label_0e_4e6a ; $5053
Label_0e_5056:
	ld a, [wEquippedRacket] ; $5056
	ld [wWaterSpriteMinigameFlag], a ; $5059
	call InitEquipmentHandoutDialogue ; $505c
	script_speak $0e ; $505f
	call ShowEquipChangeConfirmation ; $5064
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $5067
	script_face_toward ACTOR_PLAYER, $0e ; $506a
	script_set_text Text_6e_241 ; $5072
	call PushEquipmentNameTextArg ; $5078
	script_speak $0e ; $507b
Label_0e_5080:
	script_set_text Text_6e_242 ; $5080
	ld a, $0e ; $5086
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5088
	farcall RunDialogueYesNoPrompt ; $508b
	farcall ScriptCloseDialogueWindow ; $508e
	script_wait_frames $05 ; $5091
	and a, a ; $5098
	jp z, RepairCounterServiceMenu ; $5099
	jp RepairCounterFarewell ; $509c
RepairCounterChangedReturnA:
	ld a, $0b ; $509f
	ld [$c2b1], a ; $50a1
	script_set_position ACTOR_PARTNER, $0f00, $0f00 ; $50a4
	jp RepairCounterReopenServiceMenu ; $50af
	ret ; $50b2
RepairCounterChangedReturnB:
	ld a, $0c ; $50b3
	ld [$c2b1], a ; $50b5
	farcall WaitPlayerMoveDone ; $50b8
	script_player_speed $00f0 ; $50bb
	script_move_player $0d00, $1300 ; $50c1
	farcall WaitPlayerMoveDone ; $50cb
	script_set_position ACTOR_PARTNER, $1300, $1300 ; $50ce
	jp RepairCounterReopenServiceMenu ; $50d9
	ret ; $50dc
RepairCounterReopenServiceMenu:
	xor a, a ; $50dd
	ld [wStoryModeShowLocationName], a ; $50de
	script_set_text Text_6e_239 ; $50e1
	ld hl, $00e6 ; $50e7
	call FetchAndPushShortTextArg ; $50ea
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $50ed
	script_face_toward ACTOR_PLAYER, $0e ; $50f0
	script_fade_in $08 ; $50f8
	call WaitFadeEnd ; $50fd
	ld hl, $20ec ; $5100
	ld de, $0101 ; $5103
	farcall RunMenuFromText ; $5106
	ld [$c2bc], a ; $5109
	cp a, $ff ; $510c
	jp z, RepairCounterFarewell ; $510e
	cp a, $02 ; $5111
	jp z, RepairCounterFarewell ; $5113
	cp a, $00 ; $5116
	jp z, RepairCounterChangeRackets ; $5118
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $511b
	jp nz, RepairCounterChangeShoes ; $511e
	script_set_text Text_6e_232 ; $5121
	script_speak $0e ; $5127
	script_set_text Text_6e_242 ; $512c
	ld a, $0e ; $5132
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5134
	farcall RunDialogueYesNoPrompt ; $5137
	farcall ScriptCloseDialogueWindow ; $513a
	script_wait_frames $05 ; $513d
	and a, a ; $5144
	jp z, RepairCounterServiceMenu ; $5145
	jp RepairCounterFarewell ; $5148
	script_face $0e, FACE_RIGHT ; $514b
	ret ; $5152
ShowEquipChangeConfirmation:
	ld a, [$c2bc] ; $5153
	ld hl, $20ef ; $5156
	add a, l ; $5159
	ld l, a ; $515a
	jr nc, Label_0e_515e ; $515b
	inc h ; $515d
Label_0e_515e:
	farcall InitDialogueTextCursor ; $515e
	call PushEquipmentNameTextArg ; $5161
	ld a, [$c2bc] ; $5164
	and a, a ; $5167
	jr nz, Label_0e_51a3 ; $5168
	call MirrorPlayerSpriteIfLeftHanded ; $516a
	script_set_anim ACTOR_PLAYER, $09 ; $516d
	script_face ACTOR_PLAYER, FACE_DOWN ; $5174
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_51d7 ; $517b
	script_speak $8c ; $5186
	script_null_script ACTOR_PLAYER ; $518b
	script_set_anim ACTOR_PLAYER, $01 ; $5190
	script_face_toward $0e, ACTOR_PLAYER ; $5197
	call MirrorPlayerSpriteIfLeftHanded ; $519f
	ret ; $51a2
Label_0e_51a3:
	script_face ACTOR_PLAYER, FACE_DOWN ; $51a3
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_51e4 ; $51aa
	script_speak $8c ; $51b5
	script_null_script ACTOR_PLAYER ; $51ba
	script_set_anim ACTOR_PLAYER, $01 ; $51bf
	script_set_speed ACTOR_PLAYER, $0020 ; $51c6
	script_face_toward $0e, ACTOR_PLAYER ; $51ce
	ret ; $51d6
ActorScript_0e_51d7:
	; $51d7, 13 bytes (actor_script)
	as_anim $09
	as_wait $1e
	as_anim $0a
	as_sound $91
	as_wait $1e
	as_jump ActorScript_0e_51d7
ActorScript_0e_51e4:
	; $51e4, 43 bytes (actor_script)
	as_anim $0b
	as_set_field $14, FACE_RIGHT
	as_wait $0c
	as_sound $92
	as_wait $28
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
	as_anim $0b
	as_set_field $14, FACE_LEFT
	as_wait $0c
	as_sound $92
	as_wait $28
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
	as_jump ActorScript_0e_51e4
MirrorPlayerSpriteIfLeftHanded:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $520f
	and a, a ; $5212
	jr z, Label_0e_5224 ; $5213
	script_get_actor_state ACTOR_PLAYER ; $5215
	ld c, l ; $521a
	ld b, h ; $521b
	ld hl, $0037 ; $521c
	add hl, bc ; $521f
	ld a, [hl] ; $5220
	xor a, $20 ; $5221
	ld [hl], a ; $5223
Label_0e_5224:
	ret ; $5224
ActorScript_0e_5225:
	; $5225, 35 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L8:
	as_target_rel $fe00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_target_rel $0200, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $4b
	as_jump .L8
MarioWorldMapScripts_0e:
	; $5248, 14 bytes (map_tree)
	dw MarioWorldEntryPoints_0e ; slot 0 EntryPoints
	dw MarioWorldExitTriggers_0e ; slot 1 ExitTriggers
	dw MarioWorldActors_0e ; slot 2 Actors
	dw MarioWorldNpcScripts_0e ; slot 3 NpcScripts
	dw MarioWorldFacingScripts_0e ; slot 4 FacingScripts
	dw MarioWorldTileTriggers_0e ; slot 5 TileTriggers
	dw MarioWorldInitScript_0e ; slot 6 InitScript
MarioWorldActors_0e:
	; $5256, 262 bytes (map_actors)
	map_actor $0000, ActorScript_0e_7c6e, $1500, $3d00, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1500, $3d00, FACE_RIGHT, $4e, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1200, $1300, FACE_DOWN, $2e, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1800, $1200, FACE_DOWN, $2c, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1800, $0f40, FACE_DOWN, $6f, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1800, $0d00, FACE_DOWN, $6d, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $1400, FACE_DOWN, $6e, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0a00, $0f00, FACE_DOWN, $73, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0c00, $1100, FACE_DOWN, $2b, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0c00, $0f00, FACE_DOWN, $2d, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0c00, $0d00, FACE_DOWN, $48, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0e00, $0b00, FACE_DOWN, $72, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1600, $0b00, FACE_DOWN, $2a, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0f00, $1f00, FACE_DOWN, $70, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1500, $1f00, FACE_DOWN, $71, $01, $00
	map_actor_end
MarioWorldEntryPoints_0e:
	; $535c, 41 bytes (map_entries)
	map_entry $01, FACE_UP, $1200, $2100, $0000
	map_entry $02, FACE_DOWN, $1b00, $0b00, $0000
	map_entry $0a, FACE_UP, $1200, $0800, $0000
	map_entry $0e, FACE_UP, $1200, $0f00, $0000
	map_entry $0f, FACE_UP, $1200, $0800, $0000
	db $ff
MarioWorldExitTriggers_0e:
	; $5385, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, $1b, $0e
	db $ff
MarioWorldNpc12Mario_0e:
	script_set_text Text_5e_142 ; $538e
	script_speak $12 ; $5394
	ret ; $5399
MarioWorldNpc11_0e:
	ld hl, $308f ; $539a
	ld a, [$c2b0] ; $539d
	add a, l ; $53a0
	ld l, a ; $53a1
	jr nc, Label_0e_53a5 ; $53a2
	inc h ; $53a4
Label_0e_53a5:
	farcall InitDialogueTextCursor ; $53a5
	script_speak $11 ; $53a8
	ret ; $53ad
MarioWorldNpc0BLuigi_0e:
	ld hl, $3093 ; $53ae
	ld a, [$c2b0] ; $53b1
	add a, l ; $53b4
	ld l, a ; $53b5
	jr nc, Label_0e_53b9 ; $53b6
	inc h ; $53b8
Label_0e_53b9:
	farcall InitDialogueTextCursor ; $53b9
	script_speak $0b ; $53bc
	ret ; $53c1
MarioWorldNpc09Yoshi_0e:
	script_set_text Text_5e_151 ; $53c2
	sound $87 ; $53c8
	script_speak $09 ; $53ca
	ret ; $53cf
MarioWorldNpc0ABabyMario_0e:
	script_set_text Text_5e_152 ; $53d0
	sound $89 ; $53d6
	script_speak $0a ; $53d8
	ret ; $53dd
MarioWorldNpc0C_0e:
	script_set_text Text_5e_153 ; $53de
	sound $88 ; $53e4
	script_speak $0c ; $53e6
	ret ; $53eb
MarioWorldNpc0D_0e:
	script_set_text Text_5e_154 ; $53ec
	sound $86 ; $53f2
	script_speak $0d ; $53f4
	ret ; $53f9
MarioWorldNpc0FBowser_0e:
	ld hl, $309b ; $53fa
	ld a, [$c2b0] ; $53fd
	add a, l ; $5400
	ld l, a ; $5401
	jr nc, Label_0e_5405 ; $5402
	inc h ; $5404
Label_0e_5405:
	farcall InitDialogueTextCursor ; $5405
	script_speak $0f ; $5408
	ret ; $540d
MarioWorldNpc10Wario_0e:
	ld hl, $309f ; $540e
	ld a, [$c2b0] ; $5411
	add a, l ; $5414
	ld l, a ; $5415
	jr nc, Label_0e_5419 ; $5416
	inc h ; $5418
Label_0e_5419:
	farcall InitDialogueTextCursor ; $5419
	script_speak $10 ; $541c
	ret ; $5421
MarioWorldNpc0EWaluigi_0e:
	ld hl, $30a3 ; $5422
	ld a, [$c2b0] ; $5425
	add a, l ; $5428
	ld l, a ; $5429
	jr nc, Label_0e_542d ; $542a
	inc h ; $542c
Label_0e_542d:
	farcall InitDialogueTextCursor ; $542d
	script_speak $0e ; $5430
	ret ; $5435
MarioWorldNpc13_0e:
	script_set_text Text_5e_167 ; $5436
	script_speak $13 ; $543c
	ret ; $5441
MarioWorldNpc14_0e:
	script_set_text Text_5e_168 ; $5442
	script_speak $14 ; $5448
	ret ; $544d
MarioWorldNpcScripts_0e:
	; $544e, 129 bytes (map_scripts)
	map_script $08, FACEMASK_RIGHT, $0000, MarioWorldNpc08FaceRight_0e, $00, $00
	map_script $08, FACEMASK_LEFT, $0000, MarioWorldNpc08FaceLeft_0e, $00, $00
	map_script $08, FACEMASK_UP, $0000, MarioWorldNpc08FaceUp_0e, $00, $00
	map_script $08, FACEMASK_DOWN, $0000, MarioWorldNpc08FaceDown_0e, $03, $00
	map_script $11, FACEMASK_ANY, $0000, MarioWorldNpc11_0e, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, MarioWorldNpc0BLuigi_0e, $03, $00
	map_script $09, FACEMASK_ANY, $0000, MarioWorldNpc09Yoshi_0e, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, MarioWorldNpc0ABabyMario_0e, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, MarioWorldNpc0C_0e, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, MarioWorldNpc0D_0e, $03, $00
	map_script $0f, FACEMASK_ANY, $0000, MarioWorldNpc0FBowser_0e, $03, $00
	map_script $10, FACEMASK_ANY, $0000, MarioWorldNpc10Wario_0e, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, MarioWorldNpc0EWaluigi_0e, $03, $00
	map_script $13, FACEMASK_ANY, $0000, MarioWorldNpc13_0e, $03, $00
	map_script $14, FACEMASK_ANY, $0000, MarioWorldNpc14_0e, $03, $00
	map_script $12, FACEMASK_ANY, $0000, MarioWorldNpc12Mario_0e, $03, $00
	db $ff
MarioWorldFacingScripts_0e:
	ds 1, $ff ; $54cf, fill
MarioWorldTileTriggers_0e:
	db $ff ; $54d0
	ret ; $54d1
MarioWorldInitScript_0e:
	call ComputeMarioWorldProgressIndex ; $54d2
	ld a, [wStoryModeEntryPoint] ; $54d5
	cp a, $0a ; $54d8
	jp z, MarioWorldArrivalSingles ; $54da
	cp a, $0e ; $54dd
	jp z, Label_0e_69ad ; $54df
	cp a, $0f ; $54e2
	jp z, MarioWorldArrivalSingles ; $54e4
	test_flag FLAG_DOUBLES ; $54e7
	jr nz, Label_0e_550c ; $54ea
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $54ec
	ret z ; $54ef
	ld a, [wStoryModeEntryPoint] ; $54f0
	inc a ; $54f3
	jr z, Label_0e_5509 ; $54f4
	script_set_speed ACTOR_PLAYER, $0014 ; $54f6
	script_move_target ACTOR_PLAYER, $1200, $1d00 ; $54fe
Label_0e_5509:
	jp Label_0e_69fb ; $5509
Label_0e_550c:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $550c
	ret z ; $550f
	ld a, [wStoryModeEntryPoint] ; $5510
	inc a ; $5513
	jr z, Label_0e_5529 ; $5514
	script_set_speed ACTOR_PLAYER, $0014 ; $5516
	script_move_target ACTOR_PLAYER, $1200, $1d00 ; $551e
Label_0e_5529:
	jp Label_0e_69fb ; $5529
	ret ; $552c
ActorScript_0e_552d:
	; $552d, 24 bytes (actor_script)
	as_set_target $1900, $0b00
	as_wait_move
	as_set_target $1b00, $0b00
	as_wait_move
	as_set_target $1b40, $0a00
	as_wait_move
	as_set_pos $1500, $3d00
	as_halt
ActorScript_0e_5545:
	; $5545, 24 bytes (actor_script)
	as_set_target $1700, $0b00
	as_wait_move
	as_set_target $1b00, $0b00
	as_wait_move
	as_set_target $1b40, $0a00
	as_wait_move
	as_set_pos $1500, $3d00
	as_halt
ComputeMarioWorldProgressIndex:
	test_flag FLAG_DOUBLES ; $555d
	jr nz, Label_0e_556e ; $5560
	ld a, $00 ; $5562
	test_flag FLAG_WON_DREAM_MATCH_SINGLES ; $5564
	jr z, Label_0e_556a ; $5567
	inc a ; $5569
Label_0e_556a:
	ld [$c2b0], a ; $556a
	ret ; $556d
Label_0e_556e:
	ld a, $02 ; $556e
	test_flag FLAG_WON_DREAM_MATCH_DOUBLES ; $5570
	jr z, Label_0e_556a ; $5573
	inc a ; $5575
	jr Label_0e_556a ; $5576
	ret ; $5578
MarioWorldArrivalSingles:
	test_flag FLAG_DOUBLES ; $5579
	jp nz, MarioWorldArrivalDoubles ; $557c
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $557f
	jr nz, Label_0e_558a ; $5582
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5584
	jp nz, Label_0e_69b3 ; $5587
Label_0e_558a:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $558a
	script_fade_in $04 ; $5595
	call WaitFadeEnd ; $559a
	script_wait_frames $28 ; $559d
	call MarioWorldArrivalIntroCutscene ; $55a4
	script_set_position ACTOR_PLAYER, $1200, $2500 ; $55a7
	script_set_speed ACTOR_PLAYER, $0010 ; $55b2
	script_move_target ACTOR_PLAYER, $1200, $2080 ; $55ba
	script_player_speed $0010 ; $55c5
	script_move_player $1200, $1b00 ; $55cb
	script_wait_frames $50 ; $55d5
	script_face $13, FACE_UP ; $55dc
	script_wait_frames $0a ; $55e3
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $55ea
	jr nz, Label_0e_55ff ; $55ed
	script_set_text Text_5e_75 ; $55ef
	script_speak $13 ; $55f5
	script_speak $13 ; $55fa
Label_0e_55ff:
	script_player_speed $0020 ; $55ff
	script_move_player $1200, $1800 ; $5605
	farcall WaitPlayerMoveDone ; $560f
	script_wait_frames $0a ; $5612
	script_set_anim $08, $03 ; $5619
	script_wait_idle $08 ; $5620
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5625
	jr nz, Label_0e_562f ; $5628
	script_speak $08 ; $562a
Label_0e_562f:
	script_player_speed $0014 ; $562f
	script_set_speed ACTOR_PLAYER, $0014 ; $5635
	script_set_speed $13, $0014 ; $563d
	script_set_speed $08, $0014 ; $5645
	script_move_target ACTOR_PLAYER, $1200, $1100 ; $564d
	script_move_target $13, $1200, $1700 ; $5658
	script_wait_frames $28 ; $5663
	script_move_player $1200, $0d00 ; $566a
	script_wait_move $13 ; $5674
	script_move_target $08, $1200, $0900 ; $5679
	script_move_target $13, $1200, $1300 ; $5684
	script_wait_move $13 ; $568f
	script_move_target $13, $0d00, $1300 ; $5694
	script_wait_move $08 ; $569f
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $56a4
	jr z, Label_0e_56c0 ; $56a7
	script_face $08, FACE_DOWN ; $56a9
	script_wait_frames $14 ; $56b0
	ld a, $01 ; $56b7
	ld [$c294], a ; $56b9
	ld [wStoryModeExitLocationRequest], a ; $56bc
	ret ; $56bf
Label_0e_56c0:
	call MarioWorldWelcomeCutscene ; $56c0
	script_set_speed $0f, $0020 ; $56c3
	script_set_speed $07, $0020 ; $56cb
	script_wait_frames $28 ; $56d3
	script_set_anim $0f, $02 ; $56da
	script_wait_idle $0f ; $56e1
	script_move_target $0f, $0f00, $0e00 ; $56e6
	script_move_target $07, $1000, $0c00 ; $56f1
	script_wait_move $07 ; $56fc
	script_set_position $07, $3f00, $3f00 ; $5701
	script_face $0f, FACE_UP ; $570c
	script_wait_frames $14 ; $5713
	script_speak $0f ; $571a
	script_wait_frames $14 ; $571f
	script_set_speed $10, $0020 ; $5726
	script_set_speed $0e, $0020 ; $572e
	script_move_target $0f, $1000, $0d00 ; $5736
	script_wait_move $0f ; $5741
	script_wait_frames $0a ; $5746
	script_face $10, FACE_RIGHT ; $574d
	script_move_target $10, $0d00, $0d00 ; $5754
	script_wait_move $10 ; $575f
	script_face $10, FACE_UP ; $5764
	script_wait_frames $0a ; $576b
	script_face $0e, FACE_RIGHT ; $5772
	script_move_target $0e, $0e00, $1000 ; $5779
	script_wait_move $0e ; $5784
	script_face $0e, FACE_UP ; $5789
	script_wait_frames $28 ; $5790
	sound $96 ; $5797
	script_set_position $04, $0f00, $0900 ; $5799
	script_wait_frames $04 ; $57a4
	sound $96 ; $57ab
	script_set_position $05, $1300, $0700 ; $57ad
	script_wait_frames $04 ; $57b8
	sound $96 ; $57bf
	script_set_position $06, $1700, $0900 ; $57c1
	script_wait_frames $04 ; $57cc
	script_face $0f, FACE_RIGHT ; $57d3
	script_move_target $0f, $1100, $0d00 ; $57da
	script_wait_move $0f ; $57e5
	script_face $0f, FACE_UP ; $57ea
	script_wait_frames $0a ; $57f1
	script_face $10, FACE_RIGHT ; $57f8
	script_move_target $10, $0f00, $0d00 ; $57ff
	script_wait_move $10 ; $580a
	script_face $10, FACE_UP ; $580f
	script_wait_frames $0a ; $5816
	script_face $0e, FACE_RIGHT ; $581d
	script_move_target $0e, $1100, $0f00 ; $5824
	script_wait_move $0e ; $582f
	script_face $0e, FACE_UP ; $5834
	script_wait_frames $0a ; $583b
	call MarioWorldLuigiDefendsChampCutscene ; $5842
	sound $96 ; $5845
	script_set_position $04, $1380, $0f80 ; $5847
	script_wait_frames $14 ; $5852
	script_face $12, FACE_LEFT ; $5859
	script_wait_frames $28 ; $5860
	script_set_anim $08, $03 ; $5867
	script_set_anim $12, $03 ; $586e
	script_wait_idle $12 ; $5875
	script_wait_frames $0a ; $587a
	script_face $08, FACE_DOWN ; $5881
	script_wait_frames $0a ; $5888
	script_set_speed $08, $0020 ; $588f
	script_move_target $08, $1200, $0b00 ; $5897
	script_wait_move $08 ; $58a2
	script_face $11, FACE_DOWN ; $58a7
	script_face $12, FACE_DOWN ; $58ae
	script_set_position $04, $3f00, $3f00 ; $58b5
	script_speak $08 ; $58c0
	script_wait_frames $0a ; $58c5
	call MarioWorldExhibitionDemandCutscene ; $58cc
	script_move_target $0f, $1300, $0f00 ; $58cf
	script_move_target $10, $1100, $0f00 ; $58da
	script_move_target $0e, $1400, $1100 ; $58e5
	script_wait_move $0e ; $58f0
	script_move_target $0e, $1300, $1300 ; $58f5
	script_wait_move $0e ; $5900
	script_face $0e, FACE_UP ; $5905
	script_wait_frames $28 ; $590c
	set_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5913
	farcall SaveStorySlotWithTimer ; $5916
	ld a, $08 ; $5919
	farcall ScriptShowSpeakerDialogueRestoreBG ; $591b
	farcall RunDialogueYesNoPrompt ; $591e
	farcall ScriptCloseDialogueWindow ; $5921
	script_wait_frames $05 ; $5924
	and a, a ; $592b
	jr z, ExhibitionAcceptedSingles ; $592c
	script_set_text Text_5e_96 ; $592e
	call ExhibitionDeclinedCutscene ; $5934
	ret ; $5937
ExhibitionAcceptedSingles:
	script_wait_frames $0a ; $5938
	script_set_anim $0f, $03 ; $593f
	script_wait_idle $0f ; $5946
	script_wait_frames $0a ; $594b
	script_set_text Text_5e_99 ; $5952
	script_speak $0f ; $5958
	script_speak $08 ; $595d
	script_face $0b, FACE_UP ; $5962
	script_wait_frames $04 ; $5969
	script_face $0f, FACE_UP ; $5970
	script_wait_frames $04 ; $5977
	script_face $10, FACE_UP ; $597e
	script_wait_frames $04 ; $5985
	script_face $0a, FACE_UP ; $598c
	script_wait_frames $04 ; $5993
	script_face $09, FACE_UP ; $599a
	script_wait_frames $04 ; $59a1
	script_face $0e, FACE_UP ; $59a8
	script_wait_frames $0a ; $59af
	script_set_anim $0f, $03 ; $59b6
	script_set_anim $10, $03 ; $59bd
	script_set_anim $0e, $03 ; $59c4
	script_set_anim $11, $03 ; $59cb
	script_set_anim $12, $03 ; $59d2
	script_set_anim $0b, $03 ; $59d9
	script_set_anim $0a, $03 ; $59e0
	script_set_anim $09, $03 ; $59e7
	script_set_anim $0c, $03 ; $59ee
	script_set_anim $13, $03 ; $59f5
	script_wait_idle $13 ; $59fc
	script_player_speed $0010 ; $5a01
	script_move_player $1500, $0d00 ; $5a07
	script_set_speed $08, $0014 ; $5a11
	script_set_speed $0f, $0014 ; $5a19
	script_set_speed $10, $0014 ; $5a21
	script_set_speed $0e, $0014 ; $5a29
	script_set_speed $11, $0014 ; $5a31
	script_set_speed $12, $0014 ; $5a39
	script_set_speed $0b, $0014 ; $5a41
	script_set_speed $0a, $0014 ; $5a49
	script_set_speed $09, $0014 ; $5a51
	script_set_speed $0d, $0014 ; $5a59
	script_set_speed $0c, $0014 ; $5a61
	script_set_speed $13, $0014 ; $5a69
	script_set_speed ACTOR_PLAYER, $0014 ; $5a71
	script_set_actor_script $11, ActorScript_0e_552d ; $5a79
	script_wait_frames $14 ; $5a84
	script_set_actor_script $08, ActorScript_0e_552d ; $5a8b
	script_wait_frames $14 ; $5a96
	script_set_actor_script $12, ActorScript_0e_552d ; $5a9d
	script_wait_frames $64 ; $5aa8
	script_set_actor_script $0b, ActorScript_0e_552d ; $5aaf
	script_set_actor_script $0a, ActorScript_0e_552d ; $5aba
	script_set_actor_script $09, ActorScript_0e_552d ; $5ac5
	script_set_actor_script $0c, ActorScript_0e_552d ; $5ad0
	script_set_actor_script $0d, ActorScript_0e_552d ; $5adb
	script_wait_frames $3c ; $5ae6
	script_set_actor_script $0f, ActorScript_0e_552d ; $5aed
	script_set_actor_script $10, ActorScript_0e_552d ; $5af8
	script_wait_frames $28 ; $5b03
	script_set_actor_script $0e, ActorScript_0e_552d ; $5b0a
	script_wait_actor_script $0e ; $5b15
	script_move_player $1200, $0d00 ; $5b1a
	script_move_target $13, $1000, $0f00 ; $5b24
	script_wait_move $13 ; $5b2f
	script_move_target $13, $1200, $0f00 ; $5b34
	script_wait_move $13 ; $5b3f
	script_face $13, FACE_DOWN ; $5b44
	script_wait_frames $14 ; $5b4b
	script_speak $13 ; $5b52
	script_wait_frames $0a ; $5b57
	script_set_anim ACTOR_PLAYER, $03 ; $5b5e
	script_wait_idle ACTOR_PLAYER ; $5b65
	script_wait_frames $14 ; $5b6a
	script_set_actor_script $13, ActorScript_0e_5545 ; $5b71
	script_wait_frames $14 ; $5b7c
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_5545 ; $5b83
	script_wait_frames $3c ; $5b8e
	script_move_player $1500, $0d00 ; $5b95
	script_wait_actor_script ACTOR_PLAYER ; $5b9f
	call PlayStarWarpTransition ; $5ba4
	ld a, $1c ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [wStoryModeEntryPoint], a ; $5bae
	ld a, $ff ; $5bb1
	ld [$c294], a ; $5bb3
	ld [wStoryModeExitLocationRequest], a ; $5bb6
	ret ; $5bb9
MarioWorldArrivalDoubles:
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5bba
	jr nz, Label_0e_5bc5 ; $5bbd
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $5bbf
	jp nz, Label_0e_69c5 ; $5bc2
Label_0e_5bc5:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $5bc5
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $5bd0
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $5bdb
	script_fade_in $04 ; $5be6
	call WaitFadeEnd ; $5beb
	script_wait_frames $28 ; $5bee
	call MarioWorldArrivalIntroCutscene ; $5bf5
	script_set_position ACTOR_PLAYER, $1100, $2500 ; $5bf8
	script_set_position ACTOR_PARTNER, $1300, $2500 ; $5c03
	script_set_speed ACTOR_PLAYER, $0010 ; $5c0e
	script_set_speed ACTOR_PARTNER, $0010 ; $5c16
	script_move_target ACTOR_PLAYER, $1100, $2080 ; $5c1e
	script_move_target ACTOR_PARTNER, $1300, $2080 ; $5c29
	script_player_speed $0010 ; $5c34
	script_move_player $1200, $1b00 ; $5c3a
	script_wait_frames $50 ; $5c44
	script_face $13, FACE_UP ; $5c4b
	script_wait_frames $0a ; $5c52
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5c59
	jr nz, Label_0e_5c6e ; $5c5c
	script_set_text Text_5e_102 ; $5c5e
	script_speak $13 ; $5c64
	script_speak $13 ; $5c69
Label_0e_5c6e:
	script_player_speed $0020 ; $5c6e
	script_move_player $1200, $1800 ; $5c74
	farcall WaitPlayerMoveDone ; $5c7e
	script_wait_frames $0a ; $5c81
	script_set_anim $08, $03 ; $5c88
	script_wait_idle $08 ; $5c8f
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5c94
	jr nz, Label_0e_5c9e ; $5c97
	script_speak $08 ; $5c99
Label_0e_5c9e:
	script_player_speed $0014 ; $5c9e
	script_set_speed ACTOR_PLAYER, $0014 ; $5ca4
	script_set_speed ACTOR_PARTNER, $0014 ; $5cac
	script_set_speed $13, $0014 ; $5cb4
	script_set_speed $08, $0014 ; $5cbc
	script_move_target $13, $1200, $1700 ; $5cc4
	script_wait_frames $14 ; $5ccf
	script_move_target ACTOR_PLAYER, $1100, $1100 ; $5cd6
	script_move_target ACTOR_PARTNER, $1300, $1100 ; $5ce1
	script_wait_frames $28 ; $5cec
	script_move_player $1200, $0d00 ; $5cf3
	script_wait_move $13 ; $5cfd
	script_move_target $08, $1200, $0900 ; $5d02
	script_move_target $13, $1200, $1300 ; $5d0d
	script_wait_move $13 ; $5d18
	script_move_target $13, $0d00, $1300 ; $5d1d
	script_wait_move $08 ; $5d28
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5d2d
	jr z, Label_0e_5d49 ; $5d30
	script_face $08, FACE_DOWN ; $5d32
	script_wait_frames $14 ; $5d39
	ld a, $01 ; $5d40
	ld [$c294], a ; $5d42
	ld [wStoryModeExitLocationRequest], a ; $5d45
	ret ; $5d48
Label_0e_5d49:
	call MarioWorldWelcomeCutscene ; $5d49
	script_set_position $07, $3f00, $3f00 ; $5d4c
	script_face $0f, FACE_LEFT ; $5d57
	script_wait_frames $28 ; $5d5e
	script_speak $0f ; $5d65
	script_wait_frames $14 ; $5d6a
	script_jump_velocity $0d, $ff80 ; $5d71
	script_wait_frames $14 ; $5d79
	script_jump_velocity $0d, $ff80 ; $5d80
	script_wait_frames $28 ; $5d88
	sound $86 ; $5d8f
	script_speak $0d ; $5d91
	sound $99 ; $5d96
	script_set_position $07, $0f00, $0d00 ; $5d98
	script_set_speed $0f, $0020 ; $5da3
	script_set_speed $07, $0020 ; $5dab
	script_wait_frames $28 ; $5db3
	script_set_anim $0f, $02 ; $5dba
	script_wait_idle $0f ; $5dc1
	script_move_target $0f, $0f00, $0e00 ; $5dc6
	script_move_target $07, $1000, $0c00 ; $5dd1
	script_wait_move $07 ; $5ddc
	script_set_position $07, $3f00, $3f00 ; $5de1
	script_face $0f, FACE_UP ; $5dec
	script_wait_frames $14 ; $5df3
	script_speak $0f ; $5dfa
	script_set_speed $10, $0020 ; $5dff
	script_set_speed $0e, $0020 ; $5e07
	script_move_target $0f, $0f00, $0d00 ; $5e0f
	script_wait_move $0f ; $5e1a
	script_wait_frames $0a ; $5e1f
	script_face $10, FACE_RIGHT ; $5e26
	script_move_target $10, $0d80, $0d00 ; $5e2d
	script_wait_move $10 ; $5e38
	script_face $10, FACE_UP ; $5e3d
	script_wait_frames $0a ; $5e44
	script_face $0e, FACE_RIGHT ; $5e4b
	script_move_target $0e, $0f80, $0f80 ; $5e52
	script_wait_move $0e ; $5e5d
	script_face $0e, FACE_UP ; $5e62
	script_wait_frames $28 ; $5e69
	sound $99 ; $5e70
	script_set_position $04, $0f00, $0900 ; $5e72
	script_wait_frames $04 ; $5e7d
	sound $99 ; $5e84
	script_set_position $05, $1300, $0700 ; $5e86
	script_wait_frames $04 ; $5e91
	sound $99 ; $5e98
	script_set_position $06, $1700, $0900 ; $5e9a
	script_wait_frames $04 ; $5ea5
	script_face $0f, FACE_RIGHT ; $5eac
	script_move_target $0f, $1100, $0d00 ; $5eb3
	script_wait_move $0f ; $5ebe
	script_face $0f, FACE_UP ; $5ec3
	script_wait_frames $0a ; $5eca
	script_face $10, FACE_RIGHT ; $5ed1
	script_move_target $10, $0f00, $0d00 ; $5ed8
	script_wait_move $10 ; $5ee3
	script_face $10, FACE_UP ; $5ee8
	script_wait_frames $0a ; $5eef
	script_face $0e, FACE_RIGHT ; $5ef6
	script_move_target $0e, $1100, $0f00 ; $5efd
	script_wait_move $0e ; $5f08
	script_face $0e, FACE_UP ; $5f0d
	script_wait_frames $0a ; $5f14
	call MarioWorldLuigiDefendsChampCutscene ; $5f1b
	sound $96 ; $5f1e
	script_set_position $04, $1180, $0f80 ; $5f20
	script_set_position $05, $1380, $0f80 ; $5f2b
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5f36
	script_face ACTOR_PARTNER, FACE_LEFT ; $5f3d
	script_wait_frames $28 ; $5f44
	script_face ACTOR_PLAYER, FACE_UP ; $5f4b
	script_face ACTOR_PARTNER, FACE_UP ; $5f52
	script_wait_frames $14 ; $5f59
	script_set_position $04, $3f00, $3f00 ; $5f60
	script_set_position $05, $3f00, $3f00 ; $5f6b
	script_face $12, FACE_LEFT ; $5f76
	script_wait_frames $28 ; $5f7d
	script_set_anim $08, $03 ; $5f84
	script_set_anim $12, $03 ; $5f8b
	script_wait_idle $12 ; $5f92
	script_wait_frames $0a ; $5f97
	script_face $08, FACE_DOWN ; $5f9e
	script_wait_frames $0a ; $5fa5
	script_set_speed $08, $0020 ; $5fac
	script_move_target $08, $1200, $0b00 ; $5fb4
	script_wait_move $08 ; $5fbf
	script_face $11, FACE_DOWN ; $5fc4
	script_face $12, FACE_DOWN ; $5fcb
	script_speak $08 ; $5fd2
	call MarioWorldExhibitionDemandCutscene ; $5fd7
	script_move_target $0f, $1300, $0f00 ; $5fda
	script_move_target $10, $1100, $0f00 ; $5fe5
	script_move_target $0e, $1500, $0f00 ; $5ff0
	script_wait_move $0e ; $5ffb
	script_move_target $0e, $1500, $1300 ; $6000
	script_wait_move $0e ; $600b
	script_move_target $0e, $1300, $1300 ; $6010
	script_wait_move $0e ; $601b
	script_face $0e, FACE_UP ; $6020
	script_wait_frames $28 ; $6027
	set_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $602e
	farcall SaveStorySlotWithTimer ; $6031
	ld a, $08 ; $6034
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6036
	farcall RunDialogueYesNoPrompt ; $6039
	farcall ScriptCloseDialogueWindow ; $603c
	script_wait_frames $05 ; $603f
	and a, a ; $6046
	jr z, ExhibitionAcceptedDoubles ; $6047
	script_set_text Text_5e_125 ; $6049
	call ExhibitionDeclinedCutscene ; $604f
	script_get_actor_state ACTOR_PARTNER ; $6052
	ld c, l ; $6057
	ld b, h ; $6058
	ld de, $d000 ; $6059
	farcall AttachActorStepMover ; $605c
	ret ; $605f
ExhibitionAcceptedDoubles:
	script_wait_frames $0a ; $6060
	script_set_anim $0f, $03 ; $6067
	script_wait_idle $0f ; $606e
	script_wait_frames $0a ; $6073
	script_set_text Text_5e_128 ; $607a
	script_speak $0f ; $6080
	script_speak $08 ; $6085
	script_face $0b, FACE_UP ; $608a
	script_wait_frames $04 ; $6091
	script_face $0f, FACE_UP ; $6098
	script_wait_frames $04 ; $609f
	script_face $10, FACE_UP ; $60a6
	script_wait_frames $04 ; $60ad
	script_face $0a, FACE_UP ; $60b4
	script_wait_frames $04 ; $60bb
	script_face $09, FACE_UP ; $60c2
	script_wait_frames $04 ; $60c9
	script_face $0e, FACE_UP ; $60d0
	script_wait_frames $0a ; $60d7
	script_set_anim $0f, $03 ; $60de
	script_set_anim $10, $03 ; $60e5
	script_set_anim $0e, $03 ; $60ec
	script_set_anim $11, $03 ; $60f3
	script_set_anim $12, $03 ; $60fa
	script_set_anim $0b, $03 ; $6101
	script_set_anim $0a, $03 ; $6108
	script_set_anim $09, $03 ; $610f
	script_set_anim $0c, $03 ; $6116
	script_set_anim $13, $03 ; $611d
	script_wait_idle $13 ; $6124
	script_player_speed $0010 ; $6129
	script_move_player $1500, $0d00 ; $612f
	script_set_speed $08, $0014 ; $6139
	script_set_speed $0f, $0014 ; $6141
	script_set_speed $10, $0014 ; $6149
	script_set_speed $0e, $0014 ; $6151
	script_set_speed $11, $0014 ; $6159
	script_set_speed $12, $0014 ; $6161
	script_set_speed $0b, $0014 ; $6169
	script_set_speed $0a, $0014 ; $6171
	script_set_speed $09, $0014 ; $6179
	script_set_speed $0d, $0014 ; $6181
	script_set_speed $0c, $0014 ; $6189
	script_set_speed $13, $0014 ; $6191
	script_set_speed ACTOR_PLAYER, $0014 ; $6199
	script_set_actor_script $11, ActorScript_0e_552d ; $61a1
	script_wait_frames $14 ; $61ac
	script_set_actor_script $08, ActorScript_0e_552d ; $61b3
	script_wait_frames $14 ; $61be
	script_set_actor_script $12, ActorScript_0e_552d ; $61c5
	script_wait_frames $64 ; $61d0
	script_set_actor_script $0b, ActorScript_0e_552d ; $61d7
	script_set_actor_script $0a, ActorScript_0e_552d ; $61e2
	script_set_actor_script $09, ActorScript_0e_552d ; $61ed
	script_set_actor_script $0c, ActorScript_0e_552d ; $61f8
	script_set_actor_script $0d, ActorScript_0e_552d ; $6203
	script_wait_frames $3c ; $620e
	script_set_actor_script $0f, ActorScript_0e_552d ; $6215
	script_set_actor_script $10, ActorScript_0e_552d ; $6220
	script_wait_frames $1e ; $622b
	script_move_target $0e, $1500, $1300 ; $6232
	script_wait_move $0e ; $623d
	script_set_actor_script $0e, ActorScript_0e_552d ; $6242
	script_wait_actor_script $0e ; $624d
	script_move_player $1200, $0d00 ; $6252
	script_move_target $13, $1000, $0f00 ; $625c
	script_wait_move $13 ; $6267
	script_move_target $13, $1200, $0f00 ; $626c
	script_wait_move $13 ; $6277
	script_face $13, FACE_DOWN ; $627c
	script_wait_frames $14 ; $6283
	script_speak $13 ; $628a
	script_wait_frames $0a ; $628f
	script_set_anim ACTOR_PARTNER, $03 ; $6296
	script_set_anim ACTOR_PLAYER, $03 ; $629d
	script_wait_idle ACTOR_PLAYER ; $62a4
	script_wait_frames $14 ; $62a9
	script_set_actor_script $13, ActorScript_0e_5545 ; $62b0
	script_wait_frames $14 ; $62bb
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_5545 ; $62c2
	script_wait_frames $32 ; $62cd
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_5545 ; $62d4
	script_wait_frames $3c ; $62df
	script_move_player $1500, $0d00 ; $62e6
	script_wait_actor_script ACTOR_PARTNER ; $62f0
	call PlayStarWarpTransition ; $62f5
	ld a, $1c ; $62f8
	ld [wStoryModeCurrentLocation], a ; $62fa
	ld a, $04 ; $62fd
	ld [wStoryModeEntryPoint], a ; $62ff
	ld a, $ff ; $6302
	ld [$c294], a ; $6304
	ld [wStoryModeExitLocationRequest], a ; $6307
	ret ; $630a
ActorScript_0e_630b:
	; $630b, 25 bytes (actor_script)
	as_set_target $1000, $0900
	as_wait_move
	as_set_target $1000, $0d00
	as_wait_move
	as_set_target $1100, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_6324:
	; $6324, 25 bytes (actor_script)
	as_set_target $1000, $0900
	as_wait_move
	as_set_target $1000, $0d00
	as_wait_move
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceDown_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $633d
	script_set_speed ACTOR_PARTNER, $0018 ; $6345
	test_flag FLAG_DOUBLES ; $634d
	jr nz, Label_0e_639b ; $6350
	script_move_target ACTOR_PLAYER, $1000, $0900 ; $6352
	script_wait_move ACTOR_PLAYER ; $635d
	script_move_target ACTOR_PLAYER, $1000, $0d00 ; $6362
	script_wait_move ACTOR_PLAYER ; $636d
	script_move_target ACTOR_PLAYER, $1200, $0d00 ; $6372
	script_wait_move ACTOR_PLAYER ; $637d
	script_face ACTOR_PLAYER, FACE_UP ; $6382
	script_face $08, FACE_DOWN ; $6389
	script_set_speed ACTOR_PLAYER, $0010 ; $6390
	jp PromptExhibitionMatch ; $6398
Label_0e_639b:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $639b
	call MoveDoublesPartnerToPlayer ; $63a6
	script_face $08, FACE_DOWN ; $63a9
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_630b ; $63b0
	script_wait_frames $14 ; $63bb
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_6324 ; $63c2
	script_wait_actor_script ACTOR_PLAYER ; $63cd
	script_wait_actor_script ACTOR_PARTNER ; $63d2
	jp PromptExhibitionMatch ; $63d7
ActorScript_0e_63da:
	; $63da, 13 bytes (actor_script)
	as_set_target $1100, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_63e7:
	; $63e7, 13 bytes (actor_script)
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceUp_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $63f4
	script_set_speed ACTOR_PARTNER, $0018 ; $63fc
	test_flag FLAG_DOUBLES ; $6404
	jr nz, Label_0e_643f ; $6407
	script_facing_lock ACTOR_PLAYER, $01 ; $6409
	script_move_target ACTOR_PLAYER, $1200, $0d00 ; $6410
	script_wait_move ACTOR_PLAYER ; $641b
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $6420
	script_face ACTOR_PLAYER, FACE_UP ; $6427
	script_face ACTOR_PLAYER, FACE_UP ; $642e
	script_face $08, FACE_DOWN ; $6435
	jp PromptExhibitionMatch ; $643c
Label_0e_643f:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $643f
	call MoveDoublesPartnerToPlayer ; $644a
	script_face $08, FACE_DOWN ; $644d
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_63da ; $6454
	script_wait_frames $14 ; $645f
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_63e7 ; $6466
	script_wait_actor_script ACTOR_PLAYER ; $6471
	script_wait_actor_script ACTOR_PARTNER ; $6476
	jp PromptExhibitionMatch ; $647b
ActorScript_0e_647e:
	; $647e, 19 bytes (actor_script)
	as_set_target $1000, $0d00
	as_wait_move
	as_set_target $1100, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_6491:
	; $6491, 19 bytes (actor_script)
	as_set_target $1000, $0d00
	as_wait_move
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceRight_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $64a4
	script_set_speed ACTOR_PARTNER, $0018 ; $64ac
	test_flag FLAG_DOUBLES ; $64b4
	jr nz, Label_0e_64ea ; $64b7
	script_move_target ACTOR_PLAYER, $1000, $0d00 ; $64b9
	script_wait_move ACTOR_PLAYER ; $64c4
	script_move_target ACTOR_PLAYER, $1200, $0d00 ; $64c9
	script_wait_move ACTOR_PLAYER ; $64d4
	script_face ACTOR_PLAYER, FACE_UP ; $64d9
	script_face $08, FACE_DOWN ; $64e0
	jp PromptExhibitionMatch ; $64e7
Label_0e_64ea:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $64ea
	call MoveDoublesPartnerToPlayer ; $64f5
	script_face $08, FACE_DOWN ; $64f8
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_647e ; $64ff
	script_wait_frames $14 ; $650a
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_6491 ; $6511
	script_wait_actor_script ACTOR_PLAYER ; $651c
	script_wait_actor_script ACTOR_PARTNER ; $6521
	jp PromptExhibitionMatch ; $6526
ActorScript_0e_6529:
	; $6529, 19 bytes (actor_script)
	as_set_target $1400, $0d00
	as_wait_move
	as_set_target $1100, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
ActorScript_0e_653c:
	; $653c, 19 bytes (actor_script)
	as_set_target $1400, $0d00
	as_wait_move
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_wait $1e
	as_halt
MarioWorldNpc08FaceLeft_0e:
	script_set_speed ACTOR_PLAYER, $0018 ; $654f
	script_set_speed ACTOR_PARTNER, $0018 ; $6557
	test_flag FLAG_DOUBLES ; $655f
	jr nz, Label_0e_6595 ; $6562
	script_move_target ACTOR_PLAYER, $1400, $0d00 ; $6564
	script_wait_move ACTOR_PLAYER ; $656f
	script_move_target ACTOR_PLAYER, $1200, $0d00 ; $6574
	script_wait_move ACTOR_PLAYER ; $657f
	script_face ACTOR_PLAYER, FACE_UP ; $6584
	script_face $08, FACE_DOWN ; $658b
	jp PromptExhibitionMatch ; $6592
Label_0e_6595:
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $6595
	call MoveDoublesPartnerToPlayer ; $65a0
	script_face $08, FACE_DOWN ; $65a3
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_6529 ; $65aa
	script_wait_frames $14 ; $65b5
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_653c ; $65bc
	script_wait_actor_script ACTOR_PLAYER ; $65c7
	script_wait_actor_script ACTOR_PARTNER ; $65cc
	jp PromptExhibitionMatch ; $65d1
PromptExhibitionMatch:
	farcall BeginCutsceneScriptMode ; $65d4
	script_player_speed $0018 ; $65d7
	script_move_player $1200, $0d00 ; $65dd
	farcall WaitPlayerMoveDone ; $65e7
	ld a, $02 ; $65ea
	ld [wWaterSpriteMinigameTimer], a ; $65ec
	ld hl, $c2b2 ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	test_flag FLAG_DOUBLES ; $65f8
	jr z, .prompt ; $65fb
	ld a, $05 ; $65fd
	ld [wWaterSpriteMinigameTimer], a ; $65ff
	ld hl, $c2b2 ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
.prompt:
	ld hl, $c2b2 ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	farcall InitDialogueTextCursor ; $6611
	ld a, $08 ; $6614
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6616
	farcall RunDialogueYesNoPrompt ; $6619
	farcall ScriptCloseDialogueWindow ; $661c
	script_wait_frames $05 ; $661f
	and a, a ; $6626
	jr z, .accepted ; $6627
	script_speak $08 ; $6629
	test_flag FLAG_DOUBLES ; $662e
	jr z, .declined ; $6631
	script_get_actor_state ACTOR_PARTNER ; $6633
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, $d000 ; $663a
	farcall AttachActorStepMover ; $663d
.declined:
	farcall EndCutsceneScriptMode ; $6640
	ret ; $6643
.accepted:
	ld a, [$c2b0] ; $6644
	and a, $01 ; $6647
	jr z, .startMatchScene ; $6649
	farcall AdvanceDialogueTextCursor ; $664b
	script_speak $08 ; $664e
	ld hl, $3088 ; $6653
	ld de, $0101 ; $6656
	ld a, $01 ; $6659
	farcall RunPagedTextMenu ; $665b
	cp a, $ff ; $665e
	jp z, .prompt ; $6660
	inc a ; $6663
	test_flag FLAG_DOUBLES ; $6664
	jr z, .storeSelection ; $6667
	add a, $03 ; $6669
.storeSelection:
	ld [wWaterSpriteMinigameTimer], a ; $666b
.startMatchScene:
	ld hl, $c2b2 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add a, l ; $6676
	ld l, a ; $6677
	jr nc, .speakConfirm ; $6678
	inc h ; $667a
.speakConfirm:
	farcall InitDialogueTextCursor ; $667b
	script_speak $08 ; $667e
	script_face $0b, FACE_UP ; $6683
	script_wait_frames $04 ; $668a
	script_face $0f, FACE_UP ; $6691
	script_wait_frames $04 ; $6698
	script_face $10, FACE_UP ; $669f
	script_wait_frames $04 ; $66a6
	script_face $0a, FACE_UP ; $66ad
	script_wait_frames $04 ; $66b4
	script_face $09, FACE_UP ; $66bb
	script_wait_frames $04 ; $66c2
	script_face $0e, FACE_UP ; $66c9
	script_wait_frames $0a ; $66d0
	script_set_anim $0f, $03 ; $66d7
	script_set_anim $10, $03 ; $66de
	script_set_anim $0e, $03 ; $66e5
	script_set_anim $11, $03 ; $66ec
	script_set_anim $12, $03 ; $66f3
	script_set_anim $0b, $03 ; $66fa
	script_set_anim $0a, $03 ; $6701
	script_set_anim $09, $03 ; $6708
	script_set_anim $0c, $03 ; $670f
	script_set_anim $13, $03 ; $6716
	script_wait_idle $13 ; $671d
	script_player_speed $0018 ; $6722
	script_move_player $1500, $0d00 ; $6728
	script_set_speed $08, $0020 ; $6732
	script_set_speed $0f, $0020 ; $673a
	script_set_speed $10, $0020 ; $6742
	script_set_speed $0e, $0020 ; $674a
	script_set_speed $11, $0020 ; $6752
	script_set_speed $12, $0020 ; $675a
	script_set_speed $0b, $0020 ; $6762
	script_set_speed $0a, $0020 ; $676a
	script_set_speed $09, $0020 ; $6772
	script_set_speed $0d, $0020 ; $677a
	script_set_speed $0c, $0020 ; $6782
	script_set_speed $13, $0020 ; $678a
	script_set_speed ACTOR_PLAYER, $0020 ; $6792
	script_face $12, FACE_RIGHT ; $679a
	script_wait_frames $0a ; $67a1
	script_face $08, FACE_RIGHT ; $67a8
	script_wait_frames $0a ; $67af
	script_face $11, FACE_RIGHT ; $67b6
	script_wait_frames $14 ; $67bd
	script_set_actor_script $12, ActorScript_0e_552d ; $67c4
	script_wait_frames $14 ; $67cf
	script_set_actor_script $08, ActorScript_0e_552d ; $67d6
	script_wait_frames $14 ; $67e1
	script_set_actor_script $11, ActorScript_0e_552d ; $67e8
	script_wait_frames $64 ; $67f3
	test_flag FLAG_DOUBLES ; $67fa
	jr nz, .doublesWalk ; $67fd
	script_move_target ACTOR_PLAYER, $1200, $0900 ; $67ff
	jr .crowdFollows ; $680a
.doublesWalk:
	script_set_speed ACTOR_PARTNER, $0020 ; $680c
	script_move_target ACTOR_PLAYER, $1100, $0900 ; $6814
	script_move_target ACTOR_PARTNER, $1300, $0900 ; $681f
.crowdFollows:
	script_set_actor_script $0b, ActorScript_0e_552d ; $682a
	script_set_actor_script $0a, ActorScript_0e_552d ; $6835
	script_set_actor_script $09, ActorScript_0e_552d ; $6840
	script_set_actor_script $0c, ActorScript_0e_552d ; $684b
	script_set_actor_script $0d, ActorScript_0e_552d ; $6856
	script_wait_frames $1e ; $6861
	script_face ACTOR_PLAYER, FACE_DOWN ; $6868
	test_flag FLAG_DOUBLES ; $686f
	jr z, .dismissCrowd ; $6872
	script_face ACTOR_PARTNER, FACE_DOWN ; $6874
.dismissCrowd:
	script_set_actor_script $0f, ActorScript_0e_552d ; $687b
	script_wait_frames $28 ; $6886
	script_set_actor_script $10, ActorScript_0e_552d ; $688d
	script_wait_frames $14 ; $6898
	script_set_actor_script $0e, ActorScript_0e_552d ; $689f
	script_wait_actor_script $0e ; $68aa
	script_move_player $1200, $0d00 ; $68af
	test_flag FLAG_DOUBLES ; $68b9
	jr nz, .doublesApproach ; $68bc
	script_move_target ACTOR_PLAYER, $1200, $0b00 ; $68be
	jr .coachArrives ; $68c9
.doublesApproach:
	script_move_target ACTOR_PLAYER, $1100, $0b00 ; $68cb
	script_move_target ACTOR_PARTNER, $1300, $0b00 ; $68d6
.coachArrives:
	script_move_target $13, $1200, $0d00 ; $68e1
	script_wait_move $13 ; $68ec
	script_face $13, FACE_UP ; $68f1
	script_wait_frames $14 ; $68f8
	script_speak $13 ; $68ff
	script_wait_frames $0a ; $6904
	script_set_anim ACTOR_PLAYER, $03 ; $690b
	test_flag FLAG_DOUBLES ; $6912
	jr z, .bothReady ; $6915
	script_set_anim ACTOR_PARTNER, $03 ; $6917
.bothReady:
	script_wait_idle ACTOR_PLAYER ; $691e
	script_wait_frames $14 ; $6923
	script_set_actor_script $13, ActorScript_0e_5545 ; $692a
	script_wait_frames $14 ; $6935
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_5545 ; $693c
	test_flag FLAG_DOUBLES ; $6947
	jr z, .leave ; $694a
	script_wait_frames $28 ; $694c
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_5545 ; $6953
.leave:
	script_move_player $1500, $0d00 ; $695e
	script_wait_actor_script ACTOR_PLAYER ; $6968
	call PlayStarWarpTransition ; $696d
	ld a, $1c ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wWaterSpriteMinigameTimer] ; $6975
	ld [wStoryModeEntryPoint], a ; $6978
	ld a, $ff ; $697b
	ld [$c294], a ; $697d
	ld [wStoryModeExitLocationRequest], a ; $6980
	farcall EndCutsceneScriptMode ; $6983
	ret ; $6986
MoveDoublesPartnerToPlayer:
	wram_bank $04 ; $6987
	script_get_actor_state ACTOR_PLAYER ; $698d
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, $000e ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, $000c ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	farcall ScriptSetActorMoveTarget ; $69a4
	script_wait_move ACTOR_PARTNER ; $69a7
	ret ; $69ac
Label_0e_69ad:
	test_flag FLAG_DOUBLES ; $69ad
	jp nz, Label_0e_69c5 ; $69b0
Label_0e_69b3:
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $69b3
	ret z ; $69b6
	script_set_position ACTOR_PLAYER, $1200, $0f00 ; $69b7
	jp Label_0e_69fb ; $69c2
Label_0e_69c5:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $69c5
	ret z ; $69c8
	farcall BeginCutsceneScriptMode ; $69c9
	script_player_speed $0010 ; $69cc
	script_move_player $1100, $0f00 ; $69d2
	farcall WaitPlayerMoveDone ; $69dc
	script_set_position ACTOR_PLAYER, $1100, $0f00 ; $69df
	script_set_position ACTOR_PARTNER, $1300, $0f00 ; $69ea
	farcall EndCutsceneScriptMode ; $69f5
	jp Label_0e_69fb ; $69f8
Label_0e_69fb:
	script_set_position $08, $1200, $0b00 ; $69fb
	script_face $10, FACE_RIGHT ; $6a06
	script_face $0f, FACE_RIGHT ; $6a0d
	script_face $0d, FACE_RIGHT ; $6a14
	script_face $0e, FACE_RIGHT ; $6a1b
	script_face $0b, FACE_LEFT ; $6a22
	script_face $0a, FACE_LEFT ; $6a29
	script_face $09, FACE_LEFT ; $6a30
	script_face $0c, FACE_LEFT ; $6a37
	script_set_position $13, $0d00, $1300 ; $6a3e
	script_face $13, FACE_RIGHT ; $6a49
	ret ; $6a50
MarioWorldArrivalIntroCutscene:
	script_player_speed $0020 ; $6a51
	script_move_player $1200, $0f00 ; $6a57
	farcall WaitPlayerMoveDone ; $6a61
	script_wait_frames $28 ; $6a64
	script_player_speed $0040 ; $6a6b
	script_move_player $1200, $1900 ; $6a71
	farcall WaitPlayerMoveDone ; $6a7b
	sound $97 ; $6a7e
	script_set_position $03, $1000, $1d00 ; $6a80
	script_wait_frames $0a ; $6a8b
	script_jump_velocity $13, $ff80 ; $6a92
	script_jump_velocity $03, $ff80 ; $6a9a
	script_wait_frames $1e ; $6aa2
	script_set_position $03, $3f00, $3f00 ; $6aa9
	script_set_speed $13, $0040 ; $6ab4
	ld a, $13 ; $6abc
	ld bc, $0300 ; $6abe
	ld de, rJOYP ; $6ac1
	farcall MoveActorByDelta ; $6ac4
	script_wait_move $13 ; $6ac7
	script_face $13, FACE_DOWN ; $6acc
	ret ; $6ad3
MarioWorldWelcomeCutscene:
	script_wait_frames $0a ; $6ad4
	script_face $08, FACE_DOWN ; $6adb
	script_wait_frames $04 ; $6ae2
	script_face $10, FACE_RIGHT ; $6ae9
	script_wait_frames $04 ; $6af0
	script_face $0f, FACE_RIGHT ; $6af7
	script_wait_frames $04 ; $6afe
	script_face $0d, FACE_RIGHT ; $6b05
	script_wait_frames $04 ; $6b0c
	script_face $0e, FACE_RIGHT ; $6b13
	script_wait_frames $04 ; $6b1a
	script_face $0b, FACE_LEFT ; $6b21
	script_wait_frames $04 ; $6b28
	script_face $0a, FACE_LEFT ; $6b2f
	script_wait_frames $04 ; $6b36
	script_face $09, FACE_LEFT ; $6b3d
	script_wait_frames $04 ; $6b44
	script_face $13, FACE_UP ; $6b4b
	script_wait_frames $04 ; $6b52
	script_face $0c, FACE_UP ; $6b59
	script_wait_frames $14 ; $6b60
	script_set_anim $08, $03 ; $6b67
	script_wait_idle $08 ; $6b6e
	script_speak $08 ; $6b73
	script_wait_frames $14 ; $6b78
	script_set_anim $11, $03 ; $6b7f
	script_wait_idle $11 ; $6b86
	script_speak $11 ; $6b8b
	script_face $08, FACE_LEFT ; $6b90
	script_wait_frames $0a ; $6b97
	script_face $11, FACE_RIGHT ; $6b9e
	script_wait_frames $14 ; $6ba5
	script_set_anim $11, $03 ; $6bac
	script_set_anim $08, $03 ; $6bb3
	script_wait_idle $08 ; $6bba
	script_wait_frames $0a ; $6bbf
	script_face $08, FACE_DOWN ; $6bc6
	script_wait_frames $0a ; $6bcd
	script_face $11, FACE_DOWN ; $6bd4
	script_wait_frames $1e ; $6bdb
	script_speak $08 ; $6be2
	script_face $08, FACE_RIGHT ; $6be7
	script_wait_frames $0a ; $6bee
	script_face $12, FACE_LEFT ; $6bf5
	script_wait_frames $14 ; $6bfc
	script_set_anim $12, $03 ; $6c03
	script_set_anim $08, $03 ; $6c0a
	script_wait_idle $08 ; $6c11
	script_wait_frames $0a ; $6c16
	script_face $08, FACE_DOWN ; $6c1d
	script_wait_frames $0a ; $6c24
	script_face $12, FACE_DOWN ; $6c2b
	script_wait_frames $1e ; $6c32
	script_speak $08 ; $6c39
	script_wait_frames $14 ; $6c3e
	script_jump_velocity $10, $ff80 ; $6c45
	script_wait_frames $14 ; $6c4d
	script_face $10, FACE_UP ; $6c54
	script_set_anim $10, $02 ; $6c5b
	script_wait_idle $10 ; $6c62
	script_speak $10 ; $6c67
	script_wait_frames $0a ; $6c6c
	script_jump_velocity $0e, $ff40 ; $6c73
	script_wait_frames $28 ; $6c7b
	script_face $0e, FACE_UP ; $6c82
	script_set_anim $0e, $02 ; $6c89
	script_wait_idle $0e ; $6c90
	script_speak $0e ; $6c95
	script_wait_frames $14 ; $6c9a
	sound $96 ; $6ca1
	script_set_position $04, $0f00, $0900 ; $6ca3
	script_wait_frames $04 ; $6cae
	sound $96 ; $6cb5
	script_set_position $05, $1300, $0700 ; $6cb7
	script_wait_frames $04 ; $6cc2
	sound $96 ; $6cc9
	script_set_position $06, $1700, $0900 ; $6ccb
	script_wait_frames $28 ; $6cd6
	script_face $08, FACE_LEFT ; $6cdd
	script_wait_frames $0a ; $6ce4
	script_face $11, FACE_RIGHT ; $6ceb
	script_wait_frames $28 ; $6cf2
	script_face $08, FACE_RIGHT ; $6cf9
	script_wait_frames $0a ; $6d00
	script_face $12, FACE_LEFT ; $6d07
	script_wait_frames $3c ; $6d0e
	script_move_target $0f, $0e00, $0f00 ; $6d15
	script_wait_move $0f ; $6d20
	script_face $0f, FACE_UP ; $6d25
	script_wait_frames $04 ; $6d2c
	script_face $11, FACE_DOWN ; $6d33
	script_wait_frames $04 ; $6d3a
	script_face $08, FACE_DOWN ; $6d41
	script_wait_frames $04 ; $6d48
	script_face $12, FACE_DOWN ; $6d4f
	script_wait_frames $14 ; $6d56
	script_set_position $04, $3f00, $3f00 ; $6d5d
	script_set_position $05, $3f00, $3f00 ; $6d68
	script_set_position $06, $3f00, $3f00 ; $6d73
	script_speak $0f ; $6d7e
	script_wait_frames $0a ; $6d83
	script_set_anim $0f, $04 ; $6d8a
	script_wait_idle $0f ; $6d91
	script_face $0f, FACE_RIGHT ; $6d96
	sound $99 ; $6d9d
	script_set_position $07, $0f00, $0d00 ; $6d9f
	script_wait_frames $14 ; $6daa
	script_speak $0f ; $6db1
	ret ; $6db6
MarioWorldLuigiDefendsChampCutscene:
	script_jump_velocity $0b, $ff80 ; $6db7
	script_wait_frames $14 ; $6dbf
	script_speak $0b ; $6dc6
	script_set_position $04, $3f00, $3f00 ; $6dcb
	script_set_position $05, $3f00, $3f00 ; $6dd6
	script_set_position $06, $3f00, $3f00 ; $6de1
	script_wait_frames $0a ; $6dec
	script_face $0f, FACE_RIGHT ; $6df3
	script_wait_frames $04 ; $6dfa
	script_face $10, FACE_RIGHT ; $6e01
	script_wait_frames $04 ; $6e08
	script_face $0e, FACE_RIGHT ; $6e0f
	script_wait_frames $04 ; $6e16
	script_face $08, FACE_RIGHT ; $6e1d
	script_face $0a, FACE_UP ; $6e24
	script_wait_frames $04 ; $6e2b
	script_face $11, FACE_RIGHT ; $6e32
	script_face $09, FACE_UP ; $6e39
	script_set_speed $0b, $0020 ; $6e40
	script_move_target $0b, $1600, $0d00 ; $6e48
	script_wait_move $0b ; $6e53
	script_wait_frames $0a ; $6e58
	script_speak $0b ; $6e5f
	script_wait_frames $0a ; $6e64
	script_face $0f, FACE_RIGHT ; $6e6b
	sound $99 ; $6e72
	script_set_position $07, $1200, $0b00 ; $6e74
	script_wait_frames $0a ; $6e7f
	script_set_anim $0f, $02 ; $6e86
	script_wait_idle $0f ; $6e8d
	script_wait_frames $0a ; $6e92
	script_speak $0f ; $6e99
	script_face $10, FACE_RIGHT ; $6e9e
	script_face $0e, FACE_RIGHT ; $6ea5
	script_set_position $07, $3f00, $3f00 ; $6eac
	script_move_target $0f, $1300, $0d00 ; $6eb7
	script_wait_move $0f ; $6ec2
	script_wait_frames $0a ; $6ec7
	script_face $0a, FACE_LEFT ; $6ece
	script_move_target $10, $1100, $0d00 ; $6ed5
	script_wait_frames $0a ; $6ee0
	script_face $09, FACE_LEFT ; $6ee7
	script_move_target $0e, $1300, $0f00 ; $6eee
	script_wait_move $0e ; $6ef9
	script_wait_frames $0a ; $6efe
	script_facing_lock $0b, $01 ; $6f05
	script_move_target $0b, $1800, $0d00 ; $6f0c
	script_wait_move $0b ; $6f17
	script_face $0b, FACE_LEFT ; $6f1c
	script_facing_lock $0b, FACE_RIGHT ; $6f23
	ret ; $6f2a
MarioWorldExhibitionDemandCutscene:
	script_face $10, FACE_UP ; $6f2b
	script_wait_frames $0a ; $6f32
	script_speak $10 ; $6f39
	script_wait_frames $0a ; $6f3e
	script_face $0f, FACE_DOWN ; $6f45
	script_wait_frames $0a ; $6f4c
	script_face $0e, FACE_UP ; $6f53
	script_wait_frames $28 ; $6f5a
	script_set_anim $0f, $03 ; $6f61
	script_set_anim $0e, $03 ; $6f68
	script_wait_idle $0e ; $6f6f
	script_wait_frames $0a ; $6f74
	script_face $0f, FACE_UP ; $6f7b
	script_wait_frames $04 ; $6f82
	script_face $0e, FACE_UP ; $6f89
	script_wait_frames $0a ; $6f90
	script_jump_velocity $0e, $ff40 ; $6f97
	script_wait_frames $28 ; $6f9f
	script_speak $0e ; $6fa6
	script_wait_frames $0a ; $6fab
	sound $96 ; $6fb2
	script_set_position $04, $1300, $0900 ; $6fb4
	script_set_position $05, $1700, $0900 ; $6fbf
	script_wait_frames $14 ; $6fca
	script_face $08, FACE_RIGHT ; $6fd1
	script_wait_frames $0a ; $6fd8
	script_face $12, FACE_LEFT ; $6fdf
	script_wait_frames $14 ; $6fe6
	script_set_position $04, $3f00, $3f00 ; $6fed
	script_set_position $05, $3f00, $3f00 ; $6ff8
	script_wait_frames $14 ; $7003
	script_set_anim $08, $03 ; $700a
	script_set_anim $12, $03 ; $7011
	script_wait_idle $12 ; $7018
	script_wait_frames $0a ; $701d
	script_face $08, FACE_DOWN ; $7024
	script_wait_frames $0a ; $702b
	script_face $12, FACE_DOWN ; $7032
	script_speak $08 ; $7039
	script_wait_frames $14 ; $703e
	script_set_anim $0f, $03 ; $7045
	script_set_anim $10, $03 ; $704c
	script_set_anim $0e, $03 ; $7053
	script_wait_idle $0e ; $705a
	script_wait_frames $14 ; $705f
	script_jump_velocity $10, $ff80 ; $7066
	script_wait_frames $28 ; $706e
	script_speak $10 ; $7075
	script_wait_frames $0a ; $707a
	ret ; $7081
ExhibitionDeclinedCutscene:
	script_wait_frames $0a ; $7082
	sound $99 ; $7089
	script_set_position $07, $1400, $0d00 ; $708b
	script_wait_frames $28 ; $7096
	script_speak $0f ; $709d
	script_wait_frames $14 ; $70a2
	script_set_position $07, $3f00, $3f00 ; $70a9
	script_set_anim $08, $02 ; $70b4
	script_wait_idle $08 ; $70bb
	script_speak $08 ; $70c0
	script_wait_frames $0a ; $70c5
	script_set_anim $08, $03 ; $70cc
	script_wait_idle $08 ; $70d3
	script_wait_frames $0a ; $70d8
	script_speak $08 ; $70df
	script_jump_velocity $0f, $ff80 ; $70e4
	script_wait_frames $14 ; $70ec
	sound $70 ; $70f3
	ld a, $04 ; $70f5
	farcall SetScreenShake ; $70f7
	script_wait_frames $0a ; $70fa
	ld a, $00 ; $7101
	farcall SetScreenShake ; $7103
	script_wait_frames $1e ; $7106
	script_move_target $10, $0c00, $0d00 ; $710d
	script_move_target $0e, $0c00, $1100 ; $7118
	script_wait_frames $14 ; $7123
	script_move_target $0f, $0c00, $0f00 ; $712a
	script_wait_move $0f ; $7135
	script_face $10, FACE_RIGHT ; $713a
	script_face $0e, FACE_RIGHT ; $7141
	script_face $0f, FACE_RIGHT ; $7148
	ret ; $714f
PlayStarWarpTransition:
	ldh a, [hWramBank] ; $7150
	push af ; $7152
	ld hl, StarWarpPalette ; $7153
	ld de, $0901 ; $7156
	call LoadPaletteShadow ; $7159
	ld hl, StarWarpTiles ; $715c
	ld de, $a000 ; $715f
	ld c, $18 ; $7162
	call QueueVRAMCopy ; $7164
	ld hl, StarWarpSparkleTiles ; $7167
	ld de, $a180 ; $716a
	ld c, $02 ; $716d
	call QueueVRAMCopy ; $716f
	wram_bank $06 ; $7172
	xor a, a ; $7178
	ld hl, $d000 ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a, a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	script_copy_scene_rect $00, $2b, $1a, $0c, $04, $02 ; $7192
	script_copy_scene_rect $04, $2d, $14, $14, $06, $02 ; $71a1
	script_copy_scene_rect $0a, $2b, $1a, $12, $06, $02 ; $71b0
	sound $09 ; $71bf
	ld a, $01 ; $71c1
	ld hl, UpdateStarWarpSprite ; $71c3
	call RegisterFrameTask ; $71c6
	wram_bank $06 ; $71c9
.waitLoop:
	call AdvanceFrame ; $71cf
	ld a, [$d002] ; $71d2
	cp a, $1e ; $71d5
	jr z, .startFade ; $71d7
	or a, a ; $71d9
	jr nz, .waitLoop ; $71da
	pop af ; $71dc
	wram_bank ; $71dd
	ret ; $71e1
.startFade:
	ld c, $03 ; $71e2
	call BeginFadeOut ; $71e4
	jr .waitLoop ; $71e7
UpdateStarWarpSprite:
	wram_bank $06 ; $71e9
	ldh a, [hVBlankCounter] ; $71ef
	and a, $01 ; $71f1
	jr nz, Label_0e_7200 ; $71f3
	ld hl, $d000 ; $71f5
	ld a, [hl] ; $71f8
	inc a ; $71f9
	cp a, $06 ; $71fa
	jr nz, Label_0e_71ff ; $71fc
	xor a, a ; $71fe
Label_0e_71ff:
	ld [hl], a ; $71ff
Label_0e_7200:
	ld a, [$d000] ; $7200
	rlca ; $7203
	add a, $80 ; $7204
	ld l, a ; $7206
	adc a, $74 ; $7207
	sub a, l ; $7209
	ld h, a ; $720a
	push hl ; $720b
	ld c, [hl] ; $720c
	ld b, $09 ; $720d
	ld de, $8026 ; $720f
	call OffsetStarWarpPathPoint ; $7212
	call QueueSprite ; $7215
	pop hl ; $7218
	inc hl ; $7219
	ld c, [hl] ; $721a
	ld b, $09 ; $721b
	ld de, $8826 ; $721d
	call OffsetStarWarpPathPoint ; $7220
	push de ; $7223
	call QueueSprite ; $7224
	pop de ; $7227
	ld a, $fc ; $7228
	add a, d ; $722a
	ld d, a ; $722b
	ld hl, $d040 ; $722c
	ld a, e ; $722f
	ld [hl+], a ; $7230
	ld [hl], d ; $7231
	call UpdateStarWarpTrailSparkles ; $7232
	ld hl, $d001 ; $7235
	ld a, [hl] ; $7238
	inc a ; $7239
	inc a ; $723a
	ld [hl], a ; $723b
	ld hl, $d002 ; $723c
	ld a, [hl] ; $723f
	dec a ; $7240
	ld [hl], a ; $7241
	ret nz ; $7242
	ld hl, UpdateStarWarpSprite ; $7243
	call UnregisterFrameTask ; $7246
	ret ; $7249
OffsetStarWarpPathPoint:
	ld a, [$d001] ; $724a
	add a, $8c ; $724d
	ld l, a ; $724f
	adc a, $74 ; $7250
	sub a, l ; $7252
	ld h, a ; $7253
	ld a, [hl] ; $7254
	add a, d ; $7255
	ld d, a ; $7256
	ld a, [$d001] ; $7257
	add a, $41 ; $725a
	ld l, a ; $725c
	adc a, $75 ; $725d
	sub a, l ; $725f
	ld h, a ; $7260
	ld a, [hl] ; $7261
	add a, e ; $7262
	ld e, a ; $7263
	ret ; $7264
UpdateStarWarpTrailSparkles:
	ld c, $00 ; $7265
	ld hl, $d003 ; $7267
	ld b, $10 ; $726a
Label_0e_726c:
	ld a, [hl] ; $726c
	or a, a ; $726d
	jr z, Label_0e_7277 ; $726e
	inc hl ; $7270
	inc c ; $7271
	dec b ; $7272
	jr nz, Label_0e_726c ; $7273
	jr Label_0e_729d ; $7275
Label_0e_7277:
	ld [hl], $10 ; $7277
	ld a, c ; $7279
	rlca ; $727a
	add a, $14 ; $727b
	ld l, a ; $727d
	adc a, $d0 ; $727e
	sub a, l ; $7280
	ld h, a ; $7281
	ld a, [$d040] ; $7282
	ld [hl+], a ; $7285
	ld a, [$d041] ; $7286
	ld [hl], a ; $7289
	dec hl ; $728a
	push hl ; $728b
	ld a, [hl+] ; $728c
	ld d, [hl] ; $728d
	ld e, a ; $728e
	ldh a, [hVBlankCounter] ; $728f
	and a, $07 ; $7291
	push af ; $7293
	add a, d ; $7294
	ld d, a ; $7295
	pop af ; $7296
	add a, e ; $7297
	ld e, a ; $7298
	pop hl ; $7299
	ld a, e ; $729a
	ld [hl+], a ; $729b
	ld [hl], d ; $729c
Label_0e_729d:
	ld hl, $d003 ; $729d
	ld b, $00 ; $72a0
	ld c, $10 ; $72a2
Label_0e_72a4:
	push bc ; $72a4
	push hl ; $72a5
	ld a, [hl] ; $72a6
	or a, a ; $72a7
	jr z, Label_0e_72c1 ; $72a8
	and a, $02 ; $72aa
	jr z, Label_0e_72c1 ; $72ac
	ld a, b ; $72ae
	rlca ; $72af
	add a, $14 ; $72b0
	ld l, a ; $72b2
	adc a, $d0 ; $72b3
	sub a, l ; $72b5
	ld h, a ; $72b6
	ld a, [hl+] ; $72b7
	ld d, [hl] ; $72b8
	ld e, a ; $72b9
	ld b, $09 ; $72ba
	ld c, $18 ; $72bc
	call QueueSprite ; $72be
Label_0e_72c1:
	pop hl ; $72c1
	pop bc ; $72c2
	ld a, [hl] ; $72c3
	or a, a ; $72c4
	jr z, Label_0e_72c8 ; $72c5
	dec [hl] ; $72c7
Label_0e_72c8:
	inc hl ; $72c8
	inc b ; $72c9
	dec c ; $72ca
	jr nz, Label_0e_72a4 ; $72cb
	ret ; $72cd
StarWarpPalette:
	; $72ce, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7e1f, $7fff, $021f, $008d ; pal 0: #ff83ff #ffffff #ff8300 #6a2000
	; $72d6, 10 bytes (fill)
	ds 10, $00
StarWarpTiles:
	INCBIN "data/bank_00e/d_72e0.bin" ; $72e0, 384 bytes
StarWarpSparkleTiles:
	INCBIN "data/bank_00e/d_7460.bin" ; $7460, 32 bytes
StarWarpFrameSprites:
	; $7480, 12 bytes (bytes:2)
	db $00, $02 ; 0x00
	db $04, $06 ; 0x02
	db $08, $0a ; 0x04
	db $0c, $0e ; 0x06
	db $10, $12 ; 0x08
	db $14, $16 ; 0x0a
StarWarpPathY:
	; $748c, 181 bytes (bytes:16)
	db $00, $ff, $fd, $fb, $f9, $f7, $f5, $f3, $f0, $ee, $eb, $e9, $e6, $e4, $e1, $de ; 0x00
	db $db, $d9, $d6, $d3, $d0, $cd, $cb, $c8, $c5, $c3, $c0, $bd, $bb, $b8, $b6, $b3 ; 0x10
	db $b1, $ae, $ac, $a9, $a7, $a5, $a3, $a1, $9f, $9d, $9b, $99, $98, $96, $95, $94 ; 0x20
	db $92, $91, $90, $90, $8f, $8f, $8f, $8f, $8f, $8f, $90, $91, $93, $94, $96, $98 ; 0x30
	db $9b, $9d, $a0, $a2, $a5, $a8, $aa, $ad, $b0, $b3, $b5, $b8, $bb, $bd, $bf, $c1 ; 0x40
	db $c3, $c4, $c5, $c5, $c6, $c6, $c5, $c5, $c4, $c2, $c1, $bf, $bc, $ba, $b7, $b5 ; 0x50
	db $b2, $af, $ac, $aa, $a7, $a5, $a3, $a1, $9f, $9d, $9c, $9b, $9a, $99, $98, $97 ; 0x60
	db $96, $96, $95, $95, $95, $95, $95, $95, $96, $97, $97, $99, $9a, $9c, $9d, $a0 ; 0x70
	db $a2, $a4, $a7, $a9, $ac, $ae, $b1, $b4, $b7, $b9, $bc, $bf, $c2, $c4, $c7, $ca ; 0x80
	db $cd, $cf, $d2, $d5, $d8, $da, $dd, $e0, $e2, $e5, $e7, $ea, $ec, $ee, $f1, $f3 ; 0x90
	db $f5, $f8, $fa, $fc, $fe, $00, $01, $03, $05, $07, $09, $0b, $0d, $0e, $10, $12 ; 0xa0
	db $13, $15, $17, $18, $1a ; 0xb0
StarWarpPathX:
	; $7541, 181 bytes (bytes:16)
	db $00, $fe, $fc, $fa, $f8, $f6, $f4, $f3, $f1, $f0, $ef, $ee, $ed, $ec, $eb, $eb ; 0x00
	db $ea, $ea, $ea, $ea, $eb, $eb, $eb, $ec, $ec, $ed, $ee, $ef, $f0, $f1, $f2, $f3 ; 0x10
	db $f5, $f6, $f7, $f9, $fb, $fc, $fe, $00, $01, $03, $05, $07, $09, $0c, $0e, $11 ; 0x20
	db $13, $16, $19, $1b, $1e, $21, $23, $26, $29, $2c, $2e, $31, $33, $36, $38, $3a ; 0x30
	db $3b, $3d, $3e, $3f, $3f, $40, $40, $40, $3f, $3f, $3e, $3d, $3c, $3a, $39, $37 ; 0x40
	db $34, $32, $2f, $2d, $2a, $27, $24, $22, $1f, $1c, $1a, $18, $17, $15, $14, $14 ; 0x50
	db $13, $13, $14, $15, $16, $18, $19, $1c, $1e, $20, $22, $25, $27, $2a, $2d, $2f ; 0x60
	db $32, $35, $38, $3a, $3d, $40, $43, $45, $48, $4b, $4e, $50, $53, $55, $57, $59 ; 0x70
	db $5b, $5c, $5d, $5e, $5f, $60, $61, $61, $62, $62, $62, $62, $62, $62, $62, $62 ; 0x80
	db $61, $61, $60, $60, $5f, $5e, $5d, $5c, $5b, $5a, $59, $57, $56, $55, $53, $52 ; 0x90
	db $50, $4e, $4d, $4b, $49, $47, $45, $43, $41, $3f, $3d, $3b, $39, $37, $35, $32 ; 0xa0
	db $30, $2e, $2c, $29, $27 ; 0xb0
SpecialCourtMapScripts_0e:
	; $75f6, 14 bytes (map_tree)
	dw SpecialCourtEntryPoints_0e ; slot 0 EntryPoints
	dw SpecialCourtExitTriggers_0e ; slot 1 ExitTriggers
	dw SpecialCourtActors_0e ; slot 2 Actors
	dw SpecialCourtNpcScripts_0e ; slot 3 NpcScripts
	dw SpecialCourtFacingScripts_0e ; slot 4 FacingScripts
	dw SpecialCourtTileTriggers_0e ; slot 5 TileTriggers
	dw SpecialCourtInitScript_0e ; slot 6 InitScript
SpecialCourtActors_0e:
	; $7604, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0e_7c6e, $0f00, $0500, FACE_DOWN, $2e, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $0d00, FACE_LEFT, $6d, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $0f00, FACE_LEFT, $6f, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $1100, FACE_LEFT, $2c, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $1900, FACE_LEFT, $6e, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0480, $0f00, FACE_RIGHT, $73, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0500, $1100, FACE_RIGHT, $2d, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0500, $1900, FACE_RIGHT, $48, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0500, $1b00, FACE_RIGHT, $2b, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0d00, $0500, FACE_DOWN, $72, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0d00, $1700, FACE_DOWN, $2a, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0500, $1f00, FACE_UP, $70, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $0500, $0d00, FACE_RIGHT, $71, $01, $00
	map_actor $0000, ActorScript_0e_7c6e, $1700, $1b00, FACE_LEFT, $71, $01, $00
	map_actor_end
SpecialCourtEntryPoints_0e:
	; $76d2, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0500, $2100, $0000
	db $ff
SpecialCourtExitTriggers_0e:
	; $76db, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, $08, $06
	db $ff
SpecialCourtNpcScripts_0e:
	ds 1, $ff ; $76e4, fill
SpecialCourtFacingScripts_0e:
	ds 1, $ff ; $76e5, fill
SpecialCourtTileTriggers_0e:
	ds 1, $ff ; $76e6, fill
SpecialCourtInitScript_0e:
	ld a, [wStoryModeEntryPoint] ; $76e7
	cp a, $07 ; $76ea
	jr c, Label_0e_76f7 ; $76ec
	cp a, $0a ; $76ee
	jr z, Label_0e_76f3 ; $76f0
	ret ; $76f2
Label_0e_76f3:
	call HandleExhibitionMatchResult ; $76f3
	ret ; $76f6
Label_0e_76f7:
	call ExhibitionMatchIntroCutscene ; $76f7
	ret ; $76fa
ExhibitionMatchIntroCutscene:
	xor a, a ; $76fb
	ld [wStoryModeShowLocationName], a ; $76fc
	ld a, [wStoryModeEntryPoint] ; $76ff
	dec a ; $7702
	ld [wWaterSpriteMinigameTimer], a ; $7703
	test_flag FLAG_DOUBLES ; $7706
	jp nz, Label_0e_7927 ; $7709
	script_set_speed $0e, $0014 ; $770c
	script_set_speed ACTOR_PLAYER, $0014 ; $7714
	script_set_position $0e, $0500, $2300 ; $771c
	script_set_position ACTOR_PLAYER, $0500, $2500 ; $7727
	script_set_position ACTOR_PARTNER, $0500, $2500 ; $7732
	script_move_target $0e, $0500, $1f00 ; $773d
	script_move_target ACTOR_PLAYER, $0500, $2100 ; $7748
	script_move_target ACTOR_PARTNER, $0500, $2300 ; $7753
	script_player_speed $0014 ; $775e
	script_move_player $0e00, $1b00 ; $7764
	script_fade_in $04 ; $776e
	call WaitFadeEnd ; $7773
	script_wait_move $0e ; $7776
	script_set_actor_script $0e, ActorScript_0e_7b11 ; $777b
	script_move_target ACTOR_PLAYER, $0500, $1f00 ; $7786
	script_wait_move ACTOR_PLAYER ; $7791
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_7b11 ; $7796
	script_wait_frames $5a ; $77a1
	script_move_player $0e00, $1700 ; $77a8
	script_wait_actor_script $0e ; $77b2
	script_set_speed $0e, $0020 ; $77b7
	script_set_actor_script $0e, ActorScript_0e_7b24 ; $77bf
	script_wait_actor_script $0e ; $77ca
	script_wait_frames $3c ; $77cf
	script_set_anim $0d, $03 ; $77d6
	script_set_anim ACTOR_PLAYER, $03 ; $77dd
	script_wait_idle ACTOR_PLAYER ; $77e4
	script_wait_frames $14 ; $77e9
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $77f0
	jr z, Label_0e_77fe ; $77f3
	ld a, $01 ; $77f5
	ld [$c294], a ; $77f7
	ld [wStoryModeExitLocationRequest], a ; $77fa
	ret ; $77fd
Label_0e_77fe:
	script_move_target ACTOR_PLAYER, $0f00, $1a00 ; $77fe
	script_wait_move ACTOR_PLAYER ; $7809
	script_move_target ACTOR_PLAYER, $0f00, $1700 ; $780e
	script_wait_move ACTOR_PLAYER ; $7819
	script_face $0d, FACE_UP ; $781e
	script_wait_frames $14 ; $7825
	script_player_speed $0020 ; $782c
	script_move_player $0e00, $0900 ; $7832
	farcall WaitPlayerMoveDone ; $783c
	script_wait_frames $14 ; $783f
	script_set_speed $03, $0014 ; $7846
	script_move_target $03, $0f00, $0700 ; $784e
	script_wait_move $03 ; $7859
	script_set_anim $03, $03 ; $785e
	script_wait_idle $03 ; $7865
	script_set_text Text_5e_169 ; $786a
	script_speak $03 ; $7870
	script_player_speed $0040 ; $7875
	script_move_player $0e00, $1400 ; $787b
	farcall WaitPlayerMoveDone ; $7885
	script_wait_frames $14 ; $7888
	script_face $0d, FACE_RIGHT ; $788f
	script_face ACTOR_PLAYER, FACE_LEFT ; $7896
	script_wait_frames $28 ; $789d
	script_set_anim $0d, $03 ; $78a4
	script_set_anim ACTOR_PLAYER, $03 ; $78ab
	script_wait_idle ACTOR_PLAYER ; $78b2
	script_wait_frames $14 ; $78b7
	script_set_speed ACTOR_PLAYER, $0020 ; $78be
	script_set_speed $0d, $0020 ; $78c6
	script_move_target ACTOR_PLAYER, $0f00, $1d00 ; $78ce
	script_move_target $0d, $0900, $1700 ; $78d9
	script_wait_move $0d ; $78e4
	script_move_target $0d, $0900, $0d00 ; $78e9
	script_wait_move ACTOR_PLAYER ; $78f4
	script_face ACTOR_PLAYER, FACE_UP ; $78f9
	script_wait_move $0d ; $7900
	script_move_target $0d, $0d00, $0d00 ; $7905
	script_wait_move $0d ; $7910
	script_face $0d, FACE_DOWN ; $7915
	script_wait_frames $28 ; $791c
	call PrepareStoryMatch ; $7923
	ret ; $7926
Label_0e_7927:
	script_set_speed $0e, $0014 ; $7927
	script_set_speed ACTOR_PLAYER, $0014 ; $792f
	script_set_speed ACTOR_PARTNER, $0014 ; $7937
	script_set_position $03, $0f00, $1700 ; $793f
	script_null_script ACTOR_PARTNER ; $794a
	script_set_position $0e, $0500, $2300 ; $794f
	script_set_position ACTOR_PLAYER, $0500, $2500 ; $795a
	script_set_position ACTOR_PARTNER, $0500, $2500 ; $7965
	script_move_target $0e, $0500, $1f00 ; $7970
	script_move_target ACTOR_PLAYER, $0500, $2100 ; $797b
	script_move_target ACTOR_PARTNER, $0500, $2300 ; $7986
	script_player_speed $0014 ; $7991
	script_move_player $0e00, $1b00 ; $7997
	script_fade_in $04 ; $79a1
	call WaitFadeEnd ; $79a6
	script_wait_move $0e ; $79a9
	script_set_actor_script $0e, ActorScript_0e_7b11 ; $79ae
	script_move_target ACTOR_PLAYER, $0500, $1f00 ; $79b9
	script_move_target ACTOR_PARTNER, $0500, $2100 ; $79c4
	script_wait_move ACTOR_PLAYER ; $79cf
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_7b11 ; $79d4
	script_move_target ACTOR_PARTNER, $0500, $1f00 ; $79df
	script_wait_move ACTOR_PARTNER ; $79ea
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7b11 ; $79ef
	script_wait_frames $5a ; $79fa
	script_move_player $0e00, $1700 ; $7a01
	script_wait_actor_script $0e ; $7a0b
	script_set_speed $0e, $0020 ; $7a10
	script_set_actor_script $0e, ActorScript_0e_7b24 ; $7a18
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7c6e ; $7a23
	script_move_target ACTOR_PARTNER, $0f00, $1b00 ; $7a2e
	script_wait_actor_script $0e ; $7a39
	script_wait_frames $3c ; $7a3e
	script_set_anim $03, $03 ; $7a45
	script_wait_idle $03 ; $7a4c
	script_wait_frames $14 ; $7a51
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $7a58
	jr z, Label_0e_7a66 ; $7a5b
	ld a, $01 ; $7a5d
	ld [$c294], a ; $7a5f
	ld [wStoryModeExitLocationRequest], a ; $7a62
	ret ; $7a65
Label_0e_7a66:
	script_set_text Text_5e_170 ; $7a66
	script_speak $03 ; $7a6c
	script_wait_frames $14 ; $7a71
	script_set_anim $0d, $03 ; $7a78
	script_set_anim $03, $03 ; $7a7f
	script_set_anim ACTOR_PARTNER, $03 ; $7a86
	script_set_anim ACTOR_PLAYER, $03 ; $7a8d
	script_wait_idle ACTOR_PLAYER ; $7a94
	script_wait_frames $14 ; $7a99
	script_player_speed $0020 ; $7aa0
	script_move_player $0e00, $1400 ; $7aa6
	script_set_speed ACTOR_PLAYER, $0020 ; $7ab0
	script_set_speed ACTOR_PARTNER, $0020 ; $7ab8
	script_set_speed $0d, $0020 ; $7ac0
	script_set_speed $03, $0020 ; $7ac8
	script_set_actor_script $0d, ActorScript_0e_7b2f ; $7ad0
	script_set_actor_script $03, ActorScript_0e_7b46 ; $7adb
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_7b5d ; $7ae6
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_7b6e ; $7af1
	script_wait_actor_script $0d ; $7afc
	script_wait_actor_script $03 ; $7b01
	script_wait_frames $3c ; $7b06
	call PrepareStoryMatch ; $7b0d
	ret ; $7b10
ActorScript_0e_7b11:
	; $7b11, 19 bytes (actor_script)
	as_set_target $0500, $1f00
	as_wait_move
	as_set_target $0d00, $1f00
	as_wait_move
	as_set_target $0d00, $1b00
	as_wait_move
	as_halt
ActorScript_0e_7b24:
	; $7b24, 11 bytes (actor_script)
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_0e_7b2f:
	; $7b2f, 23 bytes (actor_script)
	as_set_target $0900, $1700
	as_wait_move
	as_set_target $0900, $0d00
	as_wait_move
	as_set_target $0d00, $0d00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_0e_7b46:
	; $7b46, 23 bytes (actor_script)
	as_set_target $0900, $1700
	as_wait_move
	as_set_target $0900, $1100
	as_wait_move
	as_set_target $0f00, $1100
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_0e_7b5d:
	; $7b5d, 17 bytes (actor_script)
	as_set_target $0d00, $1d00
	as_wait_move
	as_set_target $0f00, $1d00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_0e_7b6e:
	; $7b6e, 17 bytes (actor_script)
	as_set_target $0f00, $1900
	as_wait_move
	as_set_target $0d00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
PrepareStoryMatch:
	ld a, $1c ; $7b7f
	ld [wStoryModeCurrentLocation], a ; $7b81
	ld a, $0a ; $7b84
	ld [wStoryModeEntryPoint], a ; $7b86
	ld a, $ff ; $7b89
	ld [$c294], a ; $7b8b
	ld [wStoryModeExitLocationRequest], a ; $7b8e
	farcall InitStoryMatchSettings ; $7b91
	ld a, [wWaterSpriteMinigameTimer] ; $7b94
	add a, a ; $7b97
	add a, $ac ; $7b98
	ld l, a ; $7b9a
	adc a, $7b ; $7b9b
	sub a, l ; $7b9d
	ld h, a ; $7b9e
	ld a, [hl+] ; $7b9f
	ld h, [hl] ; $7ba0
	ld l, a ; $7ba1
	call JumpToHL ; $7ba2
	farcall RunStoryMatch ; $7ba5
	farcall RestoreOverworldAfterMatch ; $7ba8
	ret ; $7bab
	dw LoadExhibitionMatchSettings0 ; $7bac
	dw LoadExhibitionMatchSettings1 ; $7bae
	dw LoadExhibitionMatchSettings2 ; $7bb0
	dw LoadExhibitionMatchSettings3 ; $7bb2
	dw LoadExhibitionMatchSettings4 ; $7bb4
	dw LoadExhibitionMatchSettings5 ; $7bb6
LoadExhibitionMatchSettings0:
	load_match_settings $0018 ; $7bb8
	ret ; $7bc5
LoadExhibitionMatchSettings1:
	load_match_settings $0017 ; $7bc6
	ret ; $7bd3
LoadExhibitionMatchSettings2:
	load_match_settings $0016 ; $7bd4
	ret ; $7be1
LoadExhibitionMatchSettings3:
	load_match_settings $0118 ; $7be2
	ret ; $7bef
LoadExhibitionMatchSettings4:
	load_match_settings $0117 ; $7bf0
	ret ; $7bfd
LoadExhibitionMatchSettings5:
	load_match_settings $0116 ; $7bfe
	ret ; $7c0b
HandleExhibitionMatchResult:
	ld a, [wMatchWinLoseFlag] ; $7c0c
	cp a, $01 ; $7c0f
	jr nz, Label_0e_7c24 ; $7c11
	test_flag FLAG_DOUBLES ; $7c13
	jr nz, Label_0e_7c1f ; $7c16
	test_flag FLAG_WON_DREAM_MATCH_SINGLES ; $7c18
	jr nz, Label_0e_7c37 ; $7c1b
	jr Label_0e_7c24 ; $7c1d
Label_0e_7c1f:
	test_flag FLAG_WON_DREAM_MATCH_DOUBLES ; $7c1f
	jr nz, Label_0e_7c37 ; $7c22
Label_0e_7c24:
	ld a, $1d ; $7c24
	ld [wStoryModeCurrentLocation], a ; $7c26
	ld a, $0e ; $7c29
	ld [wStoryModeEntryPoint], a ; $7c2b
	ld a, $ff ; $7c2e
	ld [$c294], a ; $7c30
	ld [wStoryModeExitLocationRequest], a ; $7c33
	ret ; $7c36
Label_0e_7c37:
	test_flag FLAG_DOUBLES ; $7c37
	jr nz, Label_0e_7c49 ; $7c3a
	ld b, $02 ; $7c3c
	ld a, [wStoryModeGenderOfMainCharacter] ; $7c3e
	add a, $04 ; $7c41
	ld c, a ; $7c43
	farcall RunStorySceneByMode ; $7c44
	jr Label_0e_7c5b ; $7c47
Label_0e_7c49:
	ld b, $02 ; $7c49
	ld a, [wStoryModeGenderOfMainCharacter] ; $7c4b
	ld d, a ; $7c4e
	sla a ; $7c4f
	ld c, a ; $7c51
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $7c52
	xor a, d ; $7c55
	or a, c ; $7c56
	ld c, a ; $7c57
	farcall RunStorySceneByMode ; $7c58
Label_0e_7c5b:
	ld a, $00 ; $7c5b
	ld [wStoryModeCurrentLocation], a ; $7c5d
	ld a, $0a ; $7c60
	ld [wStoryModeEntryPoint], a ; $7c62
	ld a, $ff ; $7c65
	ld [$c294], a ; $7c67
	ld [wStoryModeExitLocationRequest], a ; $7c6a
	ret ; $7c6d
ActorScript_0e_7c6e:
	; $7c6e, 40 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
	as_begin_path
.Lb:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .L15
	as_begin_path
.L1f:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1f
MapScriptNop_0e:
	ret ; $7c96
MapScriptClearActiveFlag_0e:
	xor a, a ; $7c97
	ld [$c2da], a ; $7c98
	ret ; $7c9b
MapScriptPlaySoundA2_0e:
	sound $a2 ; $7c9c
	ret ; $7c9e
MapScriptHideLocationName_0e:
	xor a, a ; $7c9f
	ld [wStoryModeShowLocationName], a ; $7ca0
	ret ; $7ca3
ActorScript_0e_7ca4:
	; $7ca4, 103 bytes (actor_script)
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
	as_jump ActorScript_0e_7ca4
	as_anim $00
	as_wait $3c
ActorScript_0e_7d0b:
	; $7d0b, 103 bytes (actor_script)
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
	as_jump ActorScript_0e_7d0b
	as_anim $00
	as_wait $1e
ActorScript_0e_7d72:
	; $7d72, 105 bytes (actor_script)
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
	as_jump ActorScript_0e_7d72
	as_anim $00
	as_wait $1e
	as_wait $3c
ActorScript_0e_7ddb:
	; $7ddb, 99 bytes (actor_script)
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
	as_jump ActorScript_0e_7ddb
ActorScript_0e_7e3e:
	; $7e3e, 13 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_0e_7e3e
ActorScript_0e_7e4b:
	; $7e4b, 15 bytes (actor_script)
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump ActorScript_0e_7e4b
ComputeTrainingGymProgressIndex:
	test_flag FLAG_DOUBLES ; $7e5a
	jr nz, Label_0e_7e81 ; $7e5d
	ld a, $00 ; $7e5f
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7e61
	jr z, Label_0e_7e7d ; $7e64
	ld a, $02 ; $7e66
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7e68
	jr z, Label_0e_7e7d ; $7e6b
	ld a, $04 ; $7e6d
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7e6f
	jr z, Label_0e_7e7d ; $7e72
	ld a, $06 ; $7e74
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7e76
	jr z, Label_0e_7e7d ; $7e79
	ld a, $08 ; $7e7b
Label_0e_7e7d:
	ld [$c2b0], a ; $7e7d
	ret ; $7e80
Label_0e_7e81:
	ld a, $01 ; $7e81
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7e83
	jr z, Label_0e_7e7d ; $7e86
	ld a, $03 ; $7e88
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7e8a
	jr z, Label_0e_7e7d ; $7e8d
	ld a, $05 ; $7e8f
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7e91
	jr z, Label_0e_7e7d ; $7e94
	ld a, $07 ; $7e96
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e98
	jr z, Label_0e_7e7d ; $7e9b
	ld a, $09 ; $7e9d
	jr Label_0e_7e7d ; $7e9f
	ld a, $00 ; $7ea1
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7ea3
	jr z, Label_0e_7ec0 ; $7ea6
	inc a ; $7ea8
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7ea9
	jr z, Label_0e_7ec0 ; $7eac
	inc a ; $7eae
	test_flag FLAG_DOUBLES ; $7eaf
	jr nz, Label_0e_7ec4 ; $7eb2
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7eb4
	jr z, Label_0e_7ec0 ; $7eb7
	inc a ; $7eb9
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7eba
	jr z, Label_0e_7ec0 ; $7ebd
	inc a ; $7ebf
Label_0e_7ec0:
	ld [$c2b0], a ; $7ec0
	ret ; $7ec3
Label_0e_7ec4:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7ec4
	jr z, Label_0e_7ec0 ; $7ec7
	inc a ; $7ec9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7eca
	jr z, Label_0e_7ec0 ; $7ecd
	inc a ; $7ecf
	jr Label_0e_7ec0 ; $7ed0
	; $7ed2, 302 bytes fill to bank end (linker-padded)
