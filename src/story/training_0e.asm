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
	map_actor $0000, ActorScript_0e_22, $2500, $0d00, FACE_DOWN, OBJ_WALK_73_02, $01, $00, TRAINING_GYM_WALK_73_02
	map_actor $0000, ActorScript_0e_22, $2900, $0f00, FACE_DOWN, OBJ_WALK_73_05, $01, $05, TRAINING_GYM_WALK_73_05
	map_actor $0000, ActorScript_0e_22, $2500, $1500, FACE_DOWN, OBJ_WALK_73_03, $01, $07, TRAINING_GYM_WALK_73_03
	map_actor $0000, ActorScript_0e_22, $2900, $1300, FACE_DOWN, OBJ_WALK_73_04, $01, $05, TRAINING_GYM_WALK_73_04
	map_actor $0000, ActorScript_0e_22, $2500, $0500, FACE_DOWN, OBJ_WALK_73_07, $01, $07, TRAINING_GYM_WALK_73_07_1
	map_actor $0000, ActorScript_0e_22, $2700, $0700, FACE_DOWN, OBJ_WALK_73_06, $01, $00, TRAINING_GYM_WALK_73_06
	map_actor $0000, ActorScript_0e_22, $2900, $0500, FACE_DOWN, OBJ_WALK_73_07, $01, $00, TRAINING_GYM_WALK_73_07_2
	map_actor $0000, ActorScript_0e_00, $2100, $0c00, FACE_DOWN, OBJ_WALK_72_04, $01, $00, TRAINING_GYM_WALK_72_04_1
	map_actor $0000, ActorScript_0e_01, $2c00, $0b00, FACE_LEFT, OBJ_WALK_72_05, $01, $00, TRAINING_GYM_WALK_72_05
	map_actor $0000, ActorScript_0e_02, $2d60, $1700, FACE_RIGHT, OBJ_WALK_72_04, $01, $06, TRAINING_GYM_WALK_72_04_2
	map_actor $0000, ActorScript_0e_05, $1900, $1100, FACE_UP, OBJ_WALK_72_02, $01, $06, TRAINING_GYM_WALK_72_02_1
	map_actor $0000, ActorScript_0e_22, $0d00, $1300, FACE_RIGHT, OBJ_WALK_72_02, $01, $07, TRAINING_GYM_WALK_72_02_2
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
	cp STORYENTRY_NONE ; $4102
	jp z, .done ; $4104
	test_flag FLAG_DOUBLES ; $4107
	jr z, .walkUp ; $410a
	script_set_speed ACTOR_PARTNER, $00ff ; $410c
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $4114
	script_wait_move ACTOR_PARTNER ; $411e
	script_face ACTOR_PARTNER, FACE_UP ; $4123
	script_set_speed ACTOR_PARTNER, $0010 ; $412a
.walkUp:
	script_set_speed ACTOR_PLAYER, $0010 ; $4132
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $413a
.done:
	ret ; $4144
TrainingGymArrival02_0e:
	ld a, [wStoryModeEntryPoint] ; $4145
	cp STORYENTRY_NONE ; $4148
	jp z, .done ; $414a
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
	sound SFX_DOOR ; $419d
	script_wait_frames $02 ; $419f
	script_copy_scene_rect $3a, $0a, $0a, $0a, $02, $02 ; $41a6
	script_wait_frames $02 ; $41b5
	script_copy_scene_rect $37, $0a, $0a, $0a, $02, $02 ; $41bc
	script_wait_frames $02 ; $41cb
	script_copy_scene_rect $3d, $0c, $0a, $0a, $02, $02 ; $41d2
.done:
	ret ; $41e1
TrainingGymArrival03_0e:
	ld a, [wStoryModeEntryPoint] ; $41e2
	cp STORYENTRY_NONE ; $41e5
	jr z, TrainingGymArrival02_0e.done ; $41e7
	script_set_speed ACTOR_PLAYER, $0010 ; $41e9
	script_set_speed ACTOR_PARTNER, $0010 ; $41f1
	farcall WaitPlayerMoveDone ; $41f9
	script_copy_scene_rect $0a, $0a, $3d, $0c, $02, $02 ; $41fc
	script_copy_scene_rect $3d, $0a, $14, $0a, $02, $02 ; $420b
	script_fade_in $08 ; $421a
	call WaitFadeEnd ; $421f
	script_move_target ACTOR_PLAYER, $1500, $0e00 ; $4222
	script_wait_move ACTOR_PLAYER ; $422d
	sound SFX_DOOR ; $4232
	script_wait_frames $02 ; $4234
	script_copy_scene_rect $3a, $0a, $14, $0a, $02, $02 ; $423b
	script_wait_frames $02 ; $424a
	script_copy_scene_rect $37, $0a, $14, $0a, $02, $02 ; $4251
	script_wait_frames $02 ; $4260
	script_copy_scene_rect $3d, $0c, $14, $0a, $02, $02 ; $4267
	ret ; $4276
TrainingGymExitTriggers_0e:
	; $4277, 25 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, STORYLOC_COURTYARD, $01
	map_script $03, FACEMASK_ANY, $0000, TrainingGymExit03_0e, STORYLOC_TENNIS_MACHINE_ROOM, $01
	map_script $02, FACEMASK_ANY, $0000, TrainingGymExit02_0e, STORYLOC_WALL_PRACTICE_ROOM, $01
	db $ff
TrainingGymExit02_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $4290
	script_lock_facing ACTOR_PLAYER ; $4297
	script_set_speed ACTOR_PLAYER, $0018 ; $429e
	script_move_target ACTOR_PLAYER, $0b00, $0d00 ; $42a6
	script_wait_move ACTOR_PLAYER ; $42b1
	farcall WaitPlayerMoveDone ; $42b6
	sound SFX_DOOR ; $42b9
	script_copy_scene_rect $37, $0a, $0a, $0a, $02, $02 ; $42bb
	script_wait_frames $02 ; $42ca
	script_copy_scene_rect $3a, $0a, $0a, $0a, $02, $02 ; $42d1
	script_wait_frames $02 ; $42e0
	script_copy_scene_rect $3d, $0a, $0a, $0a, $02, $02 ; $42e7
	script_wait_frames $02 ; $42f6
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $42fd
	ld c, $08 ; $4307
	call BeginFadeOut ; $4309
	script_unlock_facing ACTOR_PLAYER ; $430c
	script_wait_frames $0a ; $4313
	ret ; $431a
TrainingGymExit03_0e:
	script_face ACTOR_PLAYER, FACE_UP ; $431b
	script_lock_facing ACTOR_PLAYER ; $4322
	script_set_speed ACTOR_PLAYER, $0018 ; $4329
	script_move_target ACTOR_PLAYER, $1500, $0d00 ; $4331
	script_wait_move ACTOR_PLAYER ; $433c
	farcall WaitPlayerMoveDone ; $4341
	sound SFX_DOOR ; $4344
	script_copy_scene_rect $37, $0a, $14, $0a, $02, $02 ; $4346
	script_wait_frames $02 ; $4355
	script_copy_scene_rect $3a, $0a, $14, $0a, $02, $02 ; $435c
	script_wait_frames $02 ; $436b
	script_copy_scene_rect $3d, $0a, $14, $0a, $02, $02 ; $4372
	script_wait_frames $02 ; $4381
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $4388
	ld c, $08 ; $4392
	call BeginFadeOut ; $4394
	script_unlock_facing ACTOR_PLAYER ; $4397
	script_wait_frames $0a ; $439e
	ret ; $43a5
TrainingGymNpc03_0e:
	ld a, [wMapSceneStage] ; $43a6
	add a ; $43a9
	ld_hl_indexed TrainingGymNpc03TextIds ; $43aa
	ld a, [hl+] ; $43b1
	ld h, [hl] ; $43b2
	ld l, a ; $43b3
	farcall InitDialogueTextCursor ; $43b4
	script_speak ACTOR_TRAINING_GYM_WALK_73_02 ; $43b7
	ret ; $43bc
TrainingGymNpc03TextIds:
	; $43bd, 20 bytes (text_ids)
	dw Text_35_169 ; record 0
	dw Text_35_169 ; record 1
	dw Text_35_179 ; record 2
	dw Text_35_179 ; record 3
	dw Text_35_189 ; record 4
	dw Text_35_190 ; record 5
	dw Text_35_203 ; record 6
	dw Text_35_204 ; record 7
	dw Text_35_219 ; record 8
	dw Text_35_219 ; record 9
TrainingGymNpc04_0e:
	ld a, [wMapSceneStage] ; $43d1
	sra a ; $43d4
	add a ; $43d6
	ld_hl_indexed TrainingGymNpc04TextIds ; $43d7
	ld a, [hl+] ; $43de
	ld h, [hl] ; $43df
	ld l, a ; $43e0
	farcall InitDialogueTextCursor ; $43e1
	script_speak ACTOR_TRAINING_GYM_WALK_73_05 ; $43e4
	ret ; $43e9
TrainingGymNpc04TextIds:
	; $43ea, 10 bytes (text_ids)
	dw Text_35_170 ; record 0
	dw Text_35_180 ; record 1
	dw Text_35_191 ; record 2
	dw Text_35_205 ; record 3
	dw Text_35_220 ; record 4
TrainingGymNpc05_0e:
	ld a, [wMapSceneStage] ; $43f4
	add a ; $43f7
	ld_hl_indexed TrainingGymNpc05TextIds ; $43f8
	ld a, [hl+] ; $43ff
	ld h, [hl] ; $4400
	ld l, a ; $4401
	farcall InitDialogueTextCursor ; $4402
	script_speak ACTOR_TRAINING_GYM_WALK_73_03 ; $4405
	ret ; $440a
TrainingGymNpc05TextIds:
	; $440b, 20 bytes (text_ids)
	dw Text_35_171 ; record 0
	dw Text_35_171 ; record 1
	dw Text_35_181 ; record 2
	dw Text_35_181 ; record 3
	dw Text_35_192 ; record 4
	dw Text_35_193 ; record 5
	dw Text_35_206 ; record 6
	dw Text_35_207 ; record 7
	dw Text_35_221 ; record 8
	dw Text_35_221 ; record 9
TrainingGymNpc06_0e:
	ld a, [wMapSceneStage] ; $441f
	add a ; $4422
	ld_hl_indexed TrainingGymNpc06TextIds ; $4423
	ld a, [hl+] ; $442a
	ld h, [hl] ; $442b
	ld l, a ; $442c
	farcall InitDialogueTextCursor ; $442d
	script_speak ACTOR_TRAINING_GYM_WALK_73_04 ; $4430
	ret ; $4435
TrainingGymNpc06TextIds:
	; $4436, 20 bytes (text_ids)
	dw Text_35_172 ; record 0
	dw Text_35_172 ; record 1
	dw Text_35_182 ; record 2
	dw Text_35_182 ; record 3
	dw Text_35_194 ; record 4
	dw Text_35_194 ; record 5
	dw Text_35_208 ; record 6
	dw Text_35_209 ; record 7
	dw Text_35_222 ; record 8
	dw Text_35_222 ; record 9
TrainingGymNpc07_0e:
	ld a, [wMapSceneStage] ; $444a
	sra a ; $444d
	cp STORYTIER_ISLAND_OPEN ; $444f
	jr z, TrainingGymNpc07TextIds.speak ; $4451
	add a ; $4453
	ld_hl_indexed TrainingGymNpc07TextIds ; $4454
	ld a, [hl+] ; $445b
	ld h, [hl] ; $445c
	ld l, a ; $445d
	farcall InitDialogueTextCursor ; $445e
	script_speak ACTOR_TRAINING_GYM_WALK_73_07_1 ; $4461
	ret ; $4466
TrainingGymNpc07TextIds:
	; $4467, 10 bytes (text_ids)
	dw Text_35_173 ; record 0
	dw Text_35_183 ; record 1
	dw Text_35_195 ; record 2
	dw Text_35_210 ; record 3
	dw Text_35_223 ; record 4
.speak:
	script_set_text Text_35_210 ; $4471
	ld a, $07 ; $4477
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4479
	farcall RunDialogueYesNoPrompt ; $447c
	farcall ScriptCloseDialogueWindow ; $447f
	script_wait_frames $05 ; $4482
	and a ; $4489
	jr z, .speakLine ; $448a
	farcall AdvanceDialogueTextCursor ; $448c
.speakLine:
	script_speak $07 ; $448f
	ret ; $4494
TrainingGymNpc08_0e:
	ld a, [wMapSceneStage] ; $4495
	sra a ; $4498
	add a ; $449a
	ld_hl_indexed TrainingGymNpc08TextIds ; $449b
	ld a, [hl+] ; $44a2
	ld h, [hl] ; $44a3
	ld l, a ; $44a4
	farcall InitDialogueTextCursor ; $44a5
	script_speak ACTOR_TRAINING_GYM_WALK_73_06 ; $44a8
	ret ; $44ad
TrainingGymNpc08TextIds:
	; $44ae, 10 bytes (text_ids)
	dw Text_35_174 ; record 0
	dw Text_35_184 ; record 1
	dw Text_35_196 ; record 2
	dw Text_35_213 ; record 3
	dw Text_35_224 ; record 4
TrainingGymNpc09_0e:
	ld a, [wMapSceneStage] ; $44b8
	sra a ; $44bb
	add a ; $44bd
	ld_hl_indexed TrainingGymNpc09TextIds ; $44be
	ld a, [hl+] ; $44c5
	ld h, [hl] ; $44c6
	ld l, a ; $44c7
	farcall InitDialogueTextCursor ; $44c8
	script_speak ACTOR_TRAINING_GYM_WALK_73_07_2 ; $44cb
	ret ; $44d0
TrainingGymNpc09TextIds:
	; $44d1, 10 bytes (text_ids)
	dw Text_35_175 ; record 0
	dw Text_35_185 ; record 1
	dw Text_35_197 ; record 2
	dw Text_35_214 ; record 3
	dw Text_35_225 ; record 4
TrainingGymNpc0A_0e:
	ld a, [wMapSceneStage] ; $44db
	add a ; $44de
	ld_hl_indexed TrainingGymNpc0ATextIds ; $44df
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	farcall InitDialogueTextCursor ; $44e9
	script_speak ACTOR_TRAINING_GYM_WALK_72_04_1 ; $44ec
	ret ; $44f1
TrainingGymNpc0ATextIds:
	; $44f2, 20 bytes (text_ids)
	dw Text_35_176 ; record 0
	dw Text_35_176 ; record 1
	dw Text_35_186 ; record 2
	dw Text_35_186 ; record 3
	dw Text_35_198 ; record 4
	dw Text_35_199 ; record 5
	dw Text_35_215 ; record 6
	dw Text_35_215 ; record 7
	dw Text_35_226 ; record 8
	dw Text_35_227 ; record 9
TrainingGymNpc0B_0e:
	ld a, [wMapSceneStage] ; $4506
	add a ; $4509
	ld_hl_indexed TrainingGymNpc0BTextIds ; $450a
	ld a, [hl+] ; $4511
	ld h, [hl] ; $4512
	ld l, a ; $4513
	farcall InitDialogueTextCursor ; $4514
	script_speak ACTOR_TRAINING_GYM_WALK_72_05 ; $4517
	ret ; $451c
TrainingGymNpc0BTextIds:
	; $451d, 20 bytes (text_ids)
	dw Text_35_177 ; record 0
	dw Text_35_177 ; record 1
	dw Text_35_187 ; record 2
	dw Text_35_187 ; record 3
	dw Text_35_200 ; record 4
	dw Text_35_200 ; record 5
	dw Text_35_216 ; record 6
	dw Text_35_217 ; record 7
	dw Text_35_228 ; record 8
	dw Text_35_229 ; record 9
TrainingGymNpc0C_0e:
	ld a, [wMapSceneStage] ; $4531
	sra a ; $4534
	add a ; $4536
	ld_hl_indexed TrainingGymNpc0CTextIds ; $4537
	ld a, [hl+] ; $453e
	ld h, [hl] ; $453f
	ld l, a ; $4540
	farcall InitDialogueTextCursor ; $4541
	script_speak ACTOR_TRAINING_GYM_WALK_72_04_2 ; $4544
	ret ; $4549
TrainingGymNpc0CTextIds:
	; $454a, 10 bytes (text_ids)
	dw Text_35_178 ; record 0
	dw Text_35_188 ; record 1
	dw Text_35_201 ; record 2
	dw Text_35_218 ; record 3
	dw Text_35_230 ; record 4
TrainingGymNpcScripts_0e:
	; $4554, 89 bytes (map_scripts)
	map_script ACTOR_TRAINING_GYM_WALK_73_02, FACEMASK_ANY, $0000, TrainingGymNpc03_0e, $03, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_05, FACEMASK_ANY, $0000, TrainingGymNpc04_0e, $03, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_03, FACEMASK_ANY, $0000, TrainingGymNpc05_0e, $03, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_04, FACEMASK_ANY, $0000, TrainingGymNpc06_0e, $03, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_07_1, FACEMASK_ANY, $0000, TrainingGymNpc07_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_06, FACEMASK_ANY, $0000, TrainingGymNpc08_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_WALK_73_07_2, FACEMASK_ANY, $0000, TrainingGymNpc09_0e, $00, $00
	map_script ACTOR_TRAINING_GYM_WALK_72_04_1, FACEMASK_ANY, $0000, TrainingGymNpc0A_0e, $13, $00
	map_script ACTOR_TRAINING_GYM_WALK_72_05, FACEMASK_ANY, $0000, TrainingGymNpc0B_0e, $10, $00
	map_script ACTOR_TRAINING_GYM_WALK_72_04_2, FACEMASK_ANY, $0000, TrainingGymNpc0C_0e, $13, $00
	map_script ACTOR_TRAINING_GYM_WALK_72_02_1, FACEMASK_ANY, $0000, Text_6e_226, $13, $00
	db $ff
TrainingGymFacingScripts_0e:
	; $45ad, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TrainingGymFacing01_0e, $00, $00
	map_script $02, FACEMASK_ANY, $0000, TrainingGymFacing02_0e, $00, $00
	db $ff
TrainingGymFacing01_0e:
	ld a, $0b ; $45be
	ld [wMapSceneStage2], a ; $45c0
	script_player_speed $0040 ; $45c3
	script_move_player $0d00, $1300 ; $45c9
	farcall WaitPlayerMoveDone ; $45d3
	call RunRepairCounterDialogue ; $45d6
	ret ; $45d9
TrainingGymFacing02_0e:
	ld a, $0c ; $45da
	ld [wMapSceneStage2], a ; $45dc
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
	ld [wUnusedExitTriggerIdMirror], a ; $4609
	ld [wStoryModeExitTriggerRequest], a ; $460c
	ret ; $460f
TrainingGymTile03_0e:
	ld a, $03 ; $4610
	ld [wUnusedExitTriggerIdMirror], a ; $4612
	ld [wStoryModeExitTriggerRequest], a ; $4615
	ret ; $4618
TrainingGymInitScript_0e:
	call ComputeRankingProgressIndex_0e ; $4619
	script_get_actor_state ACTOR_TRAINING_GYM_WALK_73_07_1 ; $461c
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, $0018 ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	script_get_actor_state ACTOR_TRAINING_GYM_WALK_73_06 ; $462a
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $0018 ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	script_get_actor_state ACTOR_TRAINING_GYM_WALK_73_07_2 ; $4638
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, $0018 ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	script_set_anim ACTOR_TRAINING_GYM_WALK_73_07_1, $05 ; $4646
	script_set_anim ACTOR_TRAINING_GYM_WALK_73_06, $05 ; $464d
	script_set_anim ACTOR_TRAINING_GYM_WALK_73_07_2, $05 ; $4654
	call SetupGymActorsForProgress ; $465b
	ld a, [wStoryModeEntryPoint] ; $465e
	cp $0b ; $4661
	jr nz, .entry0c ; $4663
	call RepairCounterReturnA ; $4665
	ret ; $4668
.entry0c:
	cp $0c ; $4669
	jr nz, .entry0d ; $466b
	call RepairCounterReturnB ; $466d
	ret ; $4670
.entry0d:
	cp $0d ; $4671
	jr nz, .entry0e ; $4673
	call RepairCounterChangedReturnA ; $4675
	ret ; $4678
.entry0e:
	cp $0e ; $4679
	jr nz, .done ; $467b
	call RepairCounterChangedReturnB ; $467d
.done:
	ret ; $4680
