SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

DataPtr_TournamentCourtyardMapScripts_15:
	dw TournamentCourtyardMapScripts_15 ; $4000
DataPtr_TrainingCourtMapScripts_15:
	dw TrainingCourtMapScripts_15 ; $4002
TournamentCourtyardMapScripts_15:
	; $4004, 14 bytes (map_tree)
	dw TournamentCourtyardEntryPoints_15 ; slot 0 EntryPoints
	dw TournamentCourtyardExitTriggers_15 ; slot 1 ExitTriggers
	dw TournamentCourtyardActors_15 ; slot 2 Actors
	dw TournamentCourtyardNpcScripts_15 ; slot 3 NpcScripts
	dw TournamentCourtyardFacingScripts_15 ; slot 4 FacingScripts
	dw TournamentCourtyardTileTriggers_15 ; slot 5 TileTriggers
	dw TournamentCourtyardInitScript_15 ; slot 6 InitScript
TournamentCourtyardActors_15:
	; $4012, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_41ba, $0900, $1d80, $40, $21, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $0700, $1d80, $40, $22, $01, $00
	map_actor $0000, ActorScript_15_7d77, $0d00, $1b00, $80, $33, $01, $03
	map_actor $0000, ActorScript_15_7d77, $1d00, $2300, $c0, $34, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $1f00, $1d00, $80, $30, $01, $05
	map_actor $0000, ActorScript_15_7d6d, $0b00, $2700, $80, $39, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $0900, $2900, $c0, $3a, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1b40, $2640, $80, $36, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1cc0, $2640, $80, $36, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $0740, $2640, $80, $36, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $08c0, $2640, $80, $36, $01, $00
	map_actor_end
TournamentCourtyardEntryPoints_15:
	; $40b6, 41 bytes (map_entries)
	map_entry $01, $80, $2100, $1400, $0000
	map_entry $02, $00, $0300, $1400, $0000
	map_entry $03, $40, $1200, $0d00, $0000
	map_entry $04, $c0, $1200, $2900, $0000
	map_entry $0f, $c0, $1100, $3900, $0000
	db $ff
TournamentCourtyardExitTriggers_15:
	; $40df, 33 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_15_7d95, $16, $02
	map_script $02, $ff, $0000, Func_15_7d95, $17, $02
	map_script $03, $ff, $0000, Func_15_7d95, $19, $05
	map_script $04, $ff, $0000, Func_15_7d95, $1b, $02
	db $ff
Func_15_4100:
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $4b ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall FarPtr_InitDialogueTextCursor ; $410e
	test_flag $05, 7 ; $4111
	jr z, Label_15_4120 ; $4114
	test_flag $0e, 7 ; $4116
	jr nz, Label_15_413f ; $4119
	set_flag $0e, 7 ; $411b
	jr Label_15_4128 ; $411e
Label_15_4120:
	test_flag $0e, 6 ; $4120
	jr nz, Label_15_413f ; $4123
	set_flag $0e, 6 ; $4125
Label_15_4128:
	script_speak $05 ; $4128
	script_set_anim $05, $02 ; $412d
	script_wait_idle $05 ; $4134
	script_speak $05 ; $4139
	ret ; $413e
Label_15_413f:
	script_set_text $2420 ; $413f
	script_speak $05 ; $4145
	ret ; $414a
	; $414b, 14 bytes (records:2)
	dw $241e ; record 0
	dw $2427 ; record 1
	dw $2427 ; record 2
	dw $2427 ; record 3
	dw $243a ; record 4
	dw $2442 ; record 5
	dw $244a ; record 6
TournamentCourtyardNpcScripts_15:
	; $4159, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $241c, $13, $00
	map_script $04, $ff, $0000, $241d, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $2421, $13, $00
	map_script $07, $ff, $0000, $2422, $03, $00
	map_script $08, $ff, $0000, $2423, $03, $00
	map_script $09, $ff, $0000, $2424, $03, $00
	db $ff
TournamentCourtyardFacingScripts_15:
	; $4192, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_15_419b, $00, $00
	db $ff
Func_15_419b:
	ret ; $419b
TournamentCourtyardTileTriggers_15:
	; $419c, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_15_41a5, $00, $00
	db $ff
Func_15_41a5:
	ret ; $41a5
TournamentCourtyardInitScript_15:
	ld a, [wStoryModeEntryPoint] ; $41a6
	cp a, $0f ; $41a9
	jr nz, Label_15_41b0 ; $41ab
	jp TournamentSiteArrivalScene ; $41ad
Label_15_41b0:
	call SetPlayerPartnerActorSprites ; $41b0
	call InitTournamentSiteSceneVariant ; $41b3
	call TournamentSiteEntryWalkIn ; $41b6
	ret ; $41b9
ActorScript_15_41ba:
	; $41ba, 19 bytes (actor_script)
	as_set_field $14, $0000
	as_anim $04
	as_wait $78
	as_set_field $14, $0040
	as_anim $04
	as_wait $78
	as_jump ActorScript_15_41ba
TournamentSiteRespawnActors_15:
	; $41cd, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_7d6d, $1200, $3400, $40, $63, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1100, $3700, $40, $5a, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1300, $3900, $40, $5b, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1300, $3700, $40, $5c, $01, $00
	map_actor $0000, ActorScript_15_41ba, $0900, $1d80, $40, $21, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $0700, $1d80, $40, $22, $01, $00
	map_actor $0000, ActorScript_15_7d77, $0d00, $1b00, $80, $33, $01, $03
	map_actor $0000, ActorScript_15_7d77, $1d00, $2300, $c0, $34, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $1f00, $1d00, $80, $30, $01, $05
	map_actor $0000, ActorScript_15_7d6d, $0b00, $2700, $80, $39, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $0900, $2900, $c0, $3a, $01, $00
	map_actor_end
InitTournamentSiteSceneVariant:
	ld a, $00 ; $4271
	ld [$c2b0], a ; $4273
	test_flag $05, 7 ; $4276
	jr nz, Label_15_42c0 ; $4279
	ld a, $f1 ; $427b
	ld d, $0e ; $427d
	ld e, $14 ; $427f
	farcall FarPtr_WriteBehaviorMapCell ; $4281
	test_flag $07, 5 ; $4284
	jr z, Label_15_4298 ; $4287
	ld hl, TournamentSiteScripts3_15 ; $4289
	ld de, $000c ; $428c
	farcall FarPtr_WriteStoryStateWord ; $428f
	ld a, $03 ; $4292
	ld [$c2b0], a ; $4294
	ret ; $4297
Label_15_4298:
	test_flag $07, 6 ; $4298
	jr z, Label_15_42ac ; $429b
	ld hl, TournamentSiteScripts2_15 ; $429d
	ld de, $000c ; $42a0
	farcall FarPtr_WriteStoryStateWord ; $42a3
	ld a, $02 ; $42a6
	ld [$c2b0], a ; $42a8
	ret ; $42ab
Label_15_42ac:
	test_flag $07, 7 ; $42ac
	jr z, Label_15_42bf ; $42af
	ld hl, TournamentSiteScripts1_15 ; $42b1
	ld de, $000c ; $42b4
	farcall FarPtr_WriteStoryStateWord ; $42b7
	ld a, $01 ; $42ba
	ld [$c2b0], a ; $42bc
Label_15_42bf:
	ret ; $42bf
Label_15_42c0:
	test_flag $06, 6 ; $42c0
	jr z, Label_15_42d4 ; $42c3
	ld hl, TournamentSiteScripts6_15 ; $42c5
	ld de, $000c ; $42c8
	farcall FarPtr_WriteStoryStateWord ; $42cb
	ld a, $06 ; $42ce
	ld [$c2b0], a ; $42d0
	ret ; $42d3
Label_15_42d4:
	test_flag $06, 7 ; $42d4
	jr z, Label_15_42e8 ; $42d7
	ld hl, TournamentSiteScripts5_15 ; $42d9
	ld de, $000c ; $42dc
	farcall FarPtr_WriteStoryStateWord ; $42df
	ld a, $05 ; $42e2
	ld [$c2b0], a ; $42e4
	ret ; $42e7
Label_15_42e8:
	ld hl, TournamentSiteScripts4_15 ; $42e8
	ld de, $000c ; $42eb
	farcall FarPtr_WriteStoryStateWord ; $42ee
	ld a, $04 ; $42f1
	ld [$c2b0], a ; $42f3
	ret ; $42f6
TournamentSiteScripts1_15:
	; $42f7, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $2425, $13, $00
	map_script $04, $ff, $0000, $2426, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $2429, $13, $00
	map_script $07, $ff, $0000, $242a, $03, $00
	map_script $08, $ff, $0000, $242b, $03, $00
	map_script $09, $ff, $0000, $242c, $03, $00
	db $ff
TournamentSiteScripts2_15:
	; $4330, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $242d, $13, $00
	map_script $04, $ff, $0000, $242e, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $242f, $13, $00
	map_script $07, $ff, $0000, $2430, $03, $00
	map_script $08, $ff, $0000, $2431, $03, $00
	map_script $09, $ff, $0000, $2432, $03, $00
	db $ff
TournamentSiteScripts3_15:
	; $4369, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $2433, $13, $00
	map_script $04, $ff, $0000, $2434, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $2435, $13, $00
	map_script $07, $ff, $0000, $2436, $03, $00
	map_script $08, $ff, $0000, $2437, $03, $00
	map_script $09, $ff, $0000, $2438, $03, $00
	db $ff
TournamentSiteScripts4_15:
	; $43a2, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $241c, $13, $00
	map_script $04, $ff, $0000, $2439, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $243c, $13, $00
	map_script $07, $ff, $0000, $243d, $03, $00
	map_script $08, $ff, $0000, $243e, $03, $00
	map_script $09, $ff, $0000, $243f, $03, $00
	db $ff
TournamentSiteScripts5_15:
	; $43db, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $2440, $13, $00
	map_script $04, $ff, $0000, $2441, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $2444, $13, $00
	map_script $07, $ff, $0000, $2445, $03, $00
	map_script $08, $ff, $0000, $2446, $03, $00
	map_script $09, $ff, $0000, $2447, $03, $00
	db $ff
TournamentSiteScripts6_15:
	; $4414, 57 bytes (map_scripts)
	map_script $03, $ff, $0000, $2448, $13, $00
	map_script $04, $ff, $0000, $2449, $03, $00
	map_script $05, $ff, $0000, Func_15_4100, $13, $00
	map_script $06, $ff, $0000, $244c, $13, $00
	map_script $07, $ff, $0000, $244d, $03, $00
	map_script $08, $ff, $0000, $244e, $03, $00
	map_script $09, $ff, $0000, $244f, $03, $00
	db $ff
TournamentSiteArrivalScene:
	ldh a, [hRomBank] ; $444d
	ld hl, TournamentSiteRespawnActors_15 ; $444f
	farcall FarPtr_ScriptRespawnLocationActors ; $4452
	farcall FarPtr_BeginCutsceneScriptMode ; $4455
	call SetupTournamentSitePartnerActor ; $4458
	script_player_speed $00ff ; $445b
	script_move_player $1200, $2900 ; $4461
	farcall FarPtr_WaitPlayerMoveDone ; $446b
	script_fade_in $04 ; $446e
	call WaitFadeEnd ; $4473
	script_move_target $03, $1200, $2900 ; $4476
	script_move_target $04, $1100, $2c00 ; $4481
	script_move_target $05, $1300, $2e00 ; $448c
	script_move_target $06, $1300, $2c00 ; $4497
	script_move_target $00, $1100, $2e00 ; $44a2
	script_wait_move $00 ; $44ad
	script_player_speed $0020 ; $44b2
	script_move_player $1200, $1000 ; $44b8
	script_move_target $03, $1200, $1000 ; $44c2
	script_move_target $04, $1100, $1300 ; $44cd
	script_move_target $05, $1300, $1500 ; $44d8
	script_move_target $06, $1300, $1300 ; $44e3
	script_move_target $00, $1100, $1500 ; $44ee
	script_wait_move $00 ; $44f9
	script_wait_frames $28 ; $44fe
	script_face $03, $40 ; $4505
	script_set_text $240d ; $450c
	script_speak $03 ; $4512
	script_set_anim $04, $03 ; $4517
	script_set_anim $05, $03 ; $451e
	script_set_anim $06, $03 ; $4525
	script_set_anim $00, $03 ; $452c
	script_wait_idle $00 ; $4533
	script_set_anim $03, $04 ; $4538
	script_wait_idle $03 ; $453f
	script_speak $03 ; $4544
	script_set_anim $06, $03 ; $4549
	script_wait_idle $06 ; $4550
	script_speak $06 ; $4555
	script_set_anim $05, $03 ; $455a
	script_wait_idle $05 ; $4561
	script_speak $05 ; $4566
	script_set_anim $03, $02 ; $456b
	script_wait_idle $03 ; $4572
	script_speak $03 ; $4577
	script_set_anim $04, $03 ; $457c
	script_wait_idle $04 ; $4583
	script_speak $04 ; $4588
	script_set_anim $03, $03 ; $458d
	script_wait_idle $03 ; $4594
	script_speak $03 ; $4599
	script_set_anim $04, $03 ; $459e
	script_set_anim $05, $03 ; $45a5
	script_set_anim $06, $03 ; $45ac
	script_wait_idle $06 ; $45b3
	script_set_anim $03, $03 ; $45b8
	script_wait_idle $03 ; $45bf
	script_face $03, $00 ; $45c4
	script_wait_frames $05 ; $45cb
	script_move_angle $03, $c0, $0800 ; $45d2
	script_wait_frames $3c ; $45dc
	script_face $00, $80 ; $45e3
	script_wait_frames $28 ; $45ea
	script_face $00, $40 ; $45f1
	script_wait_frames $28 ; $45f8
	script_face $00, $80 ; $45ff
	script_wait_frames $28 ; $4606
	script_face $00, $c0 ; $460d
	script_wait_frames $28 ; $4614
	script_face $00, $00 ; $461b
	script_wait_frames $28 ; $4622
	script_face $00, $c0 ; $4629
	script_wait_frames $28 ; $4630
	script_move_target $06, $1200, $1000 ; $4637
	script_wait_move $06 ; $4642
	script_face $06, $40 ; $4647
	script_speak $06 ; $464e
	script_set_anim $00, $03 ; $4653
	script_set_anim $04, $03 ; $465a
	script_set_anim $05, $03 ; $4661
	script_wait_idle $05 ; $4668
	ld a, $19 ; $466d
	ld [wStoryModeCurrentLocation], a ; $466f
	ld a, $0f ; $4672
	ld [wStoryModeEntryPoint], a ; $4674
	ld a, $ff ; $4677
	ld [$c294], a ; $4679
	ld [wStoryModeExitLocationRequest], a ; $467c
	script_move_angle $04, $c0, $0a00 ; $467f
	script_move_angle $05, $c0, $0a00 ; $4689
	script_move_angle $06, $c0, $0a00 ; $4693
	script_move_angle $00, $c0, $0a00 ; $469d
	script_wait_frames $1e ; $46a7
	ld c, $08 ; $46ae
	call BeginFadeOut ; $46b0
	call WaitFadeEnd ; $46b3
	ret ; $46b6
SetupTournamentSitePartnerActor:
	call SetPlayerPartnerActorSprites ; $46b7
	test_flag $05, 7 ; $46ba
	jr z, Label_15_46c9 ; $46bd
	ld a, [$c94d] ; $46bf
	or a, a ; $46c2
	jr nz, Label_15_46ca ; $46c3
	ld d, $58 ; $46c5
	jr Label_15_46ce ; $46c7
Label_15_46c9:
	ret ; $46c9
Label_15_46ca:
	ld d, $59 ; $46ca
	jr Label_15_46ce ; $46cc
Label_15_46ce:
	ld a, $05 ; $46ce
	farcall FarPtr_GetActorStateAddr ; $46d0
	ld c, l ; $46d3
	ld b, h ; $46d4
	farcall FarPtr_LoadActorObjectDefIfValid ; $46d5
	script_set_anim $05, $01 ; $46d8
	script_null_script $02 ; $46df
	script_set_position $02, $3f00, $3f00 ; $46e4
	ret ; $46ef
TournamentSiteEntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $46f0
	cp a, $ff ; $46f3
	jp z, Label_15_4756 ; $46f5
	test_flag $05, 7 ; $46f8
	jr z, Label_15_4739 ; $46fb
	script_set_speed $02, $00ff ; $46fd
	ld a, [wStoryModeEntryPoint] ; $4705
	dec a ; $4708
	add a, $5b ; $4709
	ld l, a ; $470b
	adc a, $47 ; $470c
	sub a, l ; $470e
	ld h, a ; $470f
	ld b, [hl] ; $4710
	ld a, $02 ; $4711
	ld b, b ; $4713
	ld de, $0200 ; $4714
	farcall FarPtr_MoveActorByAngle ; $4717
	script_wait_move $02 ; $471a
	ld a, [wStoryModeEntryPoint] ; $471f
	dec a ; $4722
	add a, $57 ; $4723
	ld l, a ; $4725
	adc a, $47 ; $4726
	sub a, l ; $4728
	ld h, a ; $4729
	ld b, [hl] ; $472a
	ld a, $02 ; $472b
	ld b, b ; $472d
	farcall FarPtr_SetActorFacing ; $472e
	script_set_speed $02, $0010 ; $4731
Label_15_4739:
	script_set_speed $00, $0010 ; $4739
	ld a, [wStoryModeEntryPoint] ; $4741
	dec a ; $4744
	add a, $57 ; $4745
	ld l, a ; $4747
	adc a, $47 ; $4748
	sub a, l ; $474a
	ld h, a ; $474b
	ld b, [hl] ; $474c
	ld a, $00 ; $474d
	ld b, b ; $474f
	ld de, $0200 ; $4750
	farcall FarPtr_MoveActorByAngle ; $4753
Label_15_4756:
	ret ; $4756
	INCBIN "data/bank_015/d_4757.bin" ; $4757, 8 bytes
SetPlayerPartnerActorSprites:
	test_flag $05, 7 ; $475f
	jp z, Label_15_477d ; $4762
	ld a, [$c94d] ; $4765
	ld d, $58 ; $4768
	add a, d ; $476a
	ld d, a ; $476b
	ld a, $02 ; $476c
	farcall FarPtr_GetActorStateAddr ; $476e
	ld c, l ; $4771
	ld b, h ; $4772
	farcall FarPtr_LoadActorObjectDefIfValid ; $4773
	script_set_anim $02, $01 ; $4776
Label_15_477d:
	ld a, [$c90d] ; $477d
	ld d, $56 ; $4780
	add a, d ; $4782
	ld d, a ; $4783
	ld a, $00 ; $4784
	farcall FarPtr_GetActorStateAddr ; $4786
	ld c, l ; $4789
	ld b, h ; $478a
	farcall FarPtr_LoadActorObjectDefIfValid ; $478b
	script_set_anim $00, $01 ; $478e
	ret ; $4795
TrainingCourtMapScripts_15:
	; $4796, 14 bytes (map_tree)
	dw TrainingCourtEntryPoints_15 ; slot 0 EntryPoints
	dw TrainingCourtExitTriggers_15 ; slot 1 ExitTriggers
	dw TrainingCourtActors_15 ; slot 2 Actors
	dw TrainingCourtNpcScripts_15 ; slot 3 NpcScripts
	dw TrainingCourtFacingScripts_15 ; slot 4 FacingScripts
	dw TrainingCourtTileTriggers_15 ; slot 5 TileTriggers
	dw TrainingCourtInitScript_15 ; slot 6 InitScript
TrainingCourtActors_15:
	; $47a4, 304 bytes (map_actors)
	map_actor $0000, ActorScript_15_55e9, $0b00, $0700, $40, $33, $01, $03
	map_actor $0000, ActorScript_15_55e9, $0b00, $1700, $c0, $32, $01, $07
	map_actor $0000, ActorScript_15_55e9, $0e00, $1700, $c0, $34, $01, $05
	map_actor $0000, ActorScript_15_7d6d, $1300, $0b00, $80, $68, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $1300, $1500, $80, $67, $01, $06
	map_actor $0000, ActorScript_15_55e6, $0b00, $2100, $40, $34, $01, $03
	map_actor $0000, ActorScript_15_55e6, $0d00, $2100, $40, $39, $01, $05
	map_actor $0000, ActorScript_15_55e6, $0c00, $2d00, $c0, $33, $01, $04
	map_actor $0000, ActorScript_15_7f3d, $0700, $2d00, $00, $6a, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $1300, $2700, $40, $64, $01, $06
	map_actor $0000, ActorScript_15_7d6d, $1300, $2900, $c0, $68, $01, $04
	map_actor $0000, ActorScript_15_55e6, $3300, $2a00, $c0, $39, $01, $06
	map_actor $0000, ActorScript_15_55e6, $3500, $2400, $40, $32, $01, $03
	map_actor $0000, ActorScript_15_55e6, $3500, $2a00, $c0, $34, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $2d00, $2100, $00, $66, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $2d00, $2900, $00, $6b, $01, $07
	map_actor $0000, ActorScript_15_55e2, $3f00, $0300, $40, $33, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $3f00, $0500, $40, $6c, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $3f00, $0700, $40, $35, $01, $05
	map_actor $0000, ActorScript_15_7d6d, $3f00, $0900, $40, $50, $01, $00
	map_actor $0000, ActorScript_15_7d6d, $3f00, $0b00, $40, $53, $01, $00
	map_actor_end
TrainingCourtEntryPoints_15:
	; $48d4, 57 bytes (map_entries)
	map_entry $01, $00, $0900, $3700, Func_15_490d
	map_entry $02, $40, $1300, $1300, $0000
	map_entry $09, $40, $1300, $1300, $0000
	map_entry $0a, $c0, $1300, $1300, $0000
	map_entry $0b, $40, $1300, $1300, $0000
	map_entry $0c, $c0, $2d00, $2b00, $0000
	map_entry $0d, $80, $1500, $2900, $0000
	db $ff
Func_15_490d:
	ld a, [wStoryModeEntryPoint] ; $490d
	cp a, $ff ; $4910
	jp z, Label_15_4955 ; $4912
	call ClearTrainingCourtNpcFlags ; $4915
	test_flag $05, 7 ; $4918
	jr z, Label_15_4943 ; $491b
	script_set_speed $02, $00ff ; $491d
	script_move_angle $02, $80, $0200 ; $4925
	script_wait_move $02 ; $492f
	script_face $02, $00 ; $4934
	script_set_speed $02, $0010 ; $493b
Label_15_4943:
	script_set_speed $00, $0010 ; $4943
	script_move_angle $00, $00, $0200 ; $494b
Label_15_4955:
	ret ; $4955
TrainingCourtExitTriggers_15:
	; $4956, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, ClearTrainingCourtNpcFlags, $08, $06
	map_script $0f, $ff, $0000, Func_15_7d95, $08, $0e
	db $ff
ClearTrainingCourtNpcFlags:
	clear_flag $17, 2 ; $4967
	clear_flag $17, 5 ; $496a
	clear_flag $17, 3 ; $496d
	clear_flag $17, 6 ; $4970
	clear_flag $17, 4 ; $4973
	clear_flag $17, 7 ; $4976
	ret ; $4979
Func_15_497a:
	ld a, [$c2b0] ; $497a
	add a, a ; $497d
	add a, $91 ; $497e
	ld l, a ; $4980
	adc a, $49 ; $4981
	sub a, l ; $4983
	ld h, a ; $4984
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	farcall FarPtr_InitDialogueTextCursor ; $4988
	script_speak $03 ; $498b
	ret ; $4990
	; $4991, 10 bytes (records:2)
	dw $1a79 ; record 0
	dw $1a7c ; record 1
	dw $1a7f ; record 2
	dw $1a7f ; record 3
	dw $1a7f ; record 4
Func_15_499b:
	ld a, [$c2b0] ; $499b
	add a, a ; $499e
	add a, $b2 ; $499f
	ld l, a ; $49a1
	adc a, $49 ; $49a2
	sub a, l ; $49a4
	ld h, a ; $49a5
	ld a, [hl+] ; $49a6
	ld h, [hl] ; $49a7
	ld l, a ; $49a8
	farcall FarPtr_InitDialogueTextCursor ; $49a9
	script_speak $04 ; $49ac
	ret ; $49b1
	; $49b2, 10 bytes (records:2)
	dw $1a7a ; record 0
	dw $1a7d ; record 1
	dw $1a80 ; record 2
	dw $1a80 ; record 3
	dw $1a80 ; record 4
Func_15_49bc:
	ld a, [$c2b0] ; $49bc
	add a, a ; $49bf
	add a, $d3 ; $49c0
	ld l, a ; $49c2
	adc a, $49 ; $49c3
	sub a, l ; $49c5
	ld h, a ; $49c6
	ld a, [hl+] ; $49c7
	ld h, [hl] ; $49c8
	ld l, a ; $49c9
	farcall FarPtr_InitDialogueTextCursor ; $49ca
	script_speak $05 ; $49cd
	ret ; $49d2
	; $49d3, 10 bytes (records:2)
	dw $1a7b ; record 0
	dw $1a7e ; record 1
	dw $1a81 ; record 2
	dw $1a81 ; record 3
	dw $1a81 ; record 4
Func_15_49dd:
	ld a, [$c2b0] ; $49dd
	add a, a ; $49e0
	add a, $f4 ; $49e1
	ld l, a ; $49e3
	adc a, $49 ; $49e4
	sub a, l ; $49e6
	ld h, a ; $49e7
	ld a, [hl+] ; $49e8
	ld h, [hl] ; $49e9
	ld l, a ; $49ea
	farcall FarPtr_InitDialogueTextCursor ; $49eb
	script_speak $08 ; $49ee
	ret ; $49f3
	; $49f4, 10 bytes (records:2)
	dw $1a8f ; record 0
	dw $1a95 ; record 1
	dw $1a99 ; record 2
	dw $1a99 ; record 3
	dw $1a99 ; record 4
Func_15_49fe:
	ld a, [$c2b0] ; $49fe
	add a, a ; $4a01
	add a, $15 ; $4a02
	ld l, a ; $4a04
	adc a, $4a ; $4a05
	sub a, l ; $4a07
	ld h, a ; $4a08
	ld a, [hl+] ; $4a09
	ld h, [hl] ; $4a0a
	ld l, a ; $4a0b
	farcall FarPtr_InitDialogueTextCursor ; $4a0c
	script_speak $09 ; $4a0f
	ret ; $4a14
	INCBIN "data/bank_015/d_4a15.bin" ; $4a15, 10 bytes
Func_15_4a1f:
	ld a, [$c2b0] ; $4a1f
	add a, a ; $4a22
	add a, $36 ; $4a23
	ld l, a ; $4a25
	adc a, $4a ; $4a26
	sub a, l ; $4a28
	ld h, a ; $4a29
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	farcall FarPtr_InitDialogueTextCursor ; $4a2d
	script_speak $0a ; $4a30
	ret ; $4a35
	; $4a36, 10 bytes (records:2)
	dw $1a91 ; record 0
	dw $1a97 ; record 1
	dw $1a9b ; record 2
	dw $1a9b ; record 3
	dw $1a9b ; record 4
Func_15_4a40:
	ld a, [$c2b0] ; $4a40
	add a, a ; $4a43
	add a, $76 ; $4a44
	ld l, a ; $4a46
	adc a, $4a ; $4a47
	sub a, l ; $4a49
	ld h, a ; $4a4a
	ld a, [hl+] ; $4a4b
	ld h, [hl] ; $4a4c
	ld l, a ; $4a4d
	farcall FarPtr_InitDialogueTextCursor ; $4a4e
	ld a, [$c2b0] ; $4a51
	cp a, $01 ; $4a54
	jr z, Label_15_4a70 ; $4a56
	ld a, $0b ; $4a58
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4a5a
	farcall FarPtr_RunDialogueYesNoPrompt ; $4a5d
	farcall FarPtr_ScriptCloseDialogueWindow ; $4a60
	script_wait_frames $05 ; $4a63
	and a, a ; $4a6a
	jr z, Label_15_4a70 ; $4a6b
	farcall FarPtr_AdvanceDialogueTextCursor ; $4a6d
Label_15_4a70:
	script_speak $0b ; $4a70
	ret ; $4a75
	; $4a76, 10 bytes (records:2)
	dw $1a92 ; record 0
	dw $1a98 ; record 1
	dw $1a9c ; record 2
	dw $1a9c ; record 3
	dw $1a9c ; record 4
Func_15_4a80:
	ld a, [$c2b0] ; $4a80
	add a, a ; $4a83
	add a, $97 ; $4a84
	ld l, a ; $4a86
	adc a, $4a ; $4a87
	sub a, l ; $4a89
	ld h, a ; $4a8a
	ld a, [hl+] ; $4a8b
	ld h, [hl] ; $4a8c
	ld l, a ; $4a8d
	farcall FarPtr_InitDialogueTextCursor ; $4a8e
	script_speak $0f ; $4a91
	ret ; $4a96
	; $4a97, 10 bytes (records:2)
	dw $1a82 ; record 0
	dw $1a87 ; record 1
	dw $1a8a ; record 2
	dw $1a8a ; record 3
	dw $1a8a ; record 4
Func_15_4aa1:
	ld a, [$c2b0] ; $4aa1
	add a, a ; $4aa4
	add a, $d7 ; $4aa5
	ld l, a ; $4aa7
	adc a, $4a ; $4aa8
	sub a, l ; $4aaa
	ld h, a ; $4aab
	ld a, [hl+] ; $4aac
	ld h, [hl] ; $4aad
	ld l, a ; $4aae
	farcall FarPtr_InitDialogueTextCursor ; $4aaf
	ld a, [$c2b0] ; $4ab2
	cp a, $01 ; $4ab5
	jr nc, Label_15_4ad1 ; $4ab7
	ld a, $0f ; $4ab9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4abb
	farcall FarPtr_RunDialogueYesNoPrompt ; $4abe
	farcall FarPtr_ScriptCloseDialogueWindow ; $4ac1
	script_wait_frames $05 ; $4ac4
	and a, a ; $4acb
	jr z, Label_15_4ad1 ; $4acc
	farcall FarPtr_AdvanceDialogueTextCursor ; $4ace
Label_15_4ad1:
	script_speak $0f ; $4ad1
	ret ; $4ad6
	; $4ad7, 10 bytes (records:2)
	dw $1a83 ; record 0
	dw $1a88 ; record 1
	dw $1a8b ; record 2
	dw $1a8b ; record 3
	dw $1a8b ; record 4
Func_15_4ae1:
	ld a, [$c2b0] ; $4ae1
	add a, a ; $4ae4
	add a, $17 ; $4ae5
	ld l, a ; $4ae7
	adc a, $4b ; $4ae8
	sub a, l ; $4aea
	ld h, a ; $4aeb
	ld a, [hl+] ; $4aec
	ld h, [hl] ; $4aed
	ld l, a ; $4aee
	farcall FarPtr_InitDialogueTextCursor ; $4aef
	ld a, [$c2b0] ; $4af2
	cp a, $02 ; $4af5
	jr c, Label_15_4b11 ; $4af7
	ld a, $10 ; $4af9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4afb
	farcall FarPtr_RunDialogueYesNoPrompt ; $4afe
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b01
	script_wait_frames $05 ; $4b04
	and a, a ; $4b0b
	jr z, Label_15_4b11 ; $4b0c
	farcall FarPtr_AdvanceDialogueTextCursor ; $4b0e
Label_15_4b11:
	script_speak $10 ; $4b11
	ret ; $4b16
	INCBIN "data/bank_015/d_4b17.bin" ; $4b17, 10 bytes
Func_15_4b21:
	script_move_player_to_actor $13 ; $4b21
	farcall FarPtr_WaitPlayerMoveDone ; $4b28
	ld a, $00 ; $4b2b
	farcall FarPtr_GetActorStateAddr ; $4b2d
	ld a, $01 ; $4b30
	ld e, l ; $4b32
	ld d, h ; $4b33
	ld hl, $0018 ; $4b34
	add hl, de ; $4b37
	ld [hl], a ; $4b38
	script_set_text $1a9f ; $4b39
	ld a, $13 ; $4b3f
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4b41
	farcall FarPtr_RunDialogueYesNoPrompt ; $4b44
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b47
	script_wait_frames $05 ; $4b4a
	and a, a ; $4b51
	jp nz, Label_15_4b6e ; $4b52
	script_set_anim $00, $03 ; $4b55
	script_wait_idle $00 ; $4b5c
	script_speak $13 ; $4b61
	script_wait_frames $0a ; $4b66
	ret ; $4b6d
Label_15_4b6e:
	set_flag $10, 0 ; $4b6e
	script_set_anim $00, $04 ; $4b71
	script_wait_idle $00 ; $4b78
	script_set_anim $13, $01 ; $4b7d
	script_wait_idle $13 ; $4b84
	script_face $13, $80 ; $4b89
	ld a, $13 ; $4b90
	farcall FarPtr_GetActorStateAddr ; $4b92
	ld a, $02 ; $4b95
	ld e, l ; $4b97
	ld d, h ; $4b98
	ld hl, $0018 ; $4b99
	add hl, de ; $4b9c
	ld [hl], a ; $4b9d
	script_set_anim $13, $02 ; $4b9e
	script_wait_idle $13 ; $4ba5
	ld a, $13 ; $4baa
	farcall FarPtr_GetActorStateAddr ; $4bac
	ld a, $01 ; $4baf
	ld e, l ; $4bb1
	ld d, h ; $4bb2
	ld hl, $0018 ; $4bb3
	add hl, de ; $4bb6
	ld [hl], a ; $4bb7
	script_set_position $16, $3680, $0d80 ; $4bb8
	sound $99 ; $4bc3
	farcall FarPtr_AdvanceDialogueTextCursor ; $4bc5
	script_speak $13 ; $4bc8
	script_set_speed $00, $0012 ; $4bcd
	script_set_anim $00, $03 ; $4bd5
	script_wait_idle $00 ; $4bdc
	script_move_target $00, $3300, $0f00 ; $4be1
	script_wait_move $00 ; $4bec
	script_face $00, $40 ; $4bf1
	script_wait_frames $0a ; $4bf8
	script_set_position $16, $3f00, $3f00 ; $4bff
	script_wait_frames $14 ; $4c0a
	script_set_anim $00, $06 ; $4c11
	script_wait_frames $b4 ; $4c18
	script_set_anim $00, $01 ; $4c1f
	script_wait_idle $00 ; $4c26
	script_face $00, $00 ; $4c2b
	script_face $13, $40 ; $4c32
	script_wait_frames $01 ; $4c39
	script_set_anim $13, $04 ; $4c40
	script_wait_idle $13 ; $4c47
	script_face $13, $80 ; $4c4c
	script_wait_frames $01 ; $4c53
	script_speak $13 ; $4c5a
	script_wait_frames $1e ; $4c5f
	script_set_speed $00, $0020 ; $4c66
	script_face $00, $40 ; $4c6e
	script_wait_frames $01 ; $4c75
	script_facing_lock $00, $01 ; $4c7c
	script_set_anim $00, $02 ; $4c83
	script_move_target $00, $3300, $0d00 ; $4c8a
	script_move_target $13, $3300, $0f00 ; $4c95
	script_wait_move $13 ; $4ca0
	script_move_target $13, $3300, $1500 ; $4ca5
	script_wait_move $13 ; $4cb0
	script_move_target $13, $1f00, $1500 ; $4cb5
	script_wait_move $13 ; $4cc0
	script_set_position $13, $3f00, $3f00 ; $4cc5
	script_facing_lock $00, $00 ; $4cd0
	script_face $00, $40 ; $4cd7
	ld a, $00 ; $4cde
	farcall FarPtr_GetActorStateAddr ; $4ce0
	ld a, $02 ; $4ce3
	ld e, l ; $4ce5
	ld d, h ; $4ce6
	ld hl, $0018 ; $4ce7
	add hl, de ; $4cea
	ld [hl], a ; $4ceb
	script_set_anim $00, $02 ; $4cec
	script_set_position $16, $3480, $0b80 ; $4cf3
	sound $99 ; $4cfe
	script_wait_frames $50 ; $4d00
Func_15_4d07:
	ld a, $00 ; $4d07
	farcall FarPtr_GetActorStateAddr ; $4d09
	ld a, $01 ; $4d0c
	ld e, l ; $4d0e
	ld d, h ; $4d0f
	ld hl, $0018 ; $4d10
	add hl, de ; $4d13
	ld [hl], a ; $4d14
	script_move_player_to_actor $00 ; $4d15
	farcall FarPtr_WaitPlayerMoveDone ; $4d1c
	script_move_player $3300, $0c00 ; $4d1f
	farcall FarPtr_WaitPlayerMoveDone ; $4d29
	script_set_text $1aa3 ; $4d2c
	script_speak $00 ; $4d32
	script_set_position $16, $3f00, $3f00 ; $4d37
	call WaterSpriteSwingContestScene ; $4d42
	test_flag $0c, 4 ; $4d45
	jp nz, Label_15_4d5c ; $4d48
	test_flag $0c, 5 ; $4d4b
	jp nz, Label_15_4d5c ; $4d4e
	ld a, [wWaterSpriteMinigameSwingCount] ; $4d51
	cp a, $64 ; $4d54
	jp c, Label_15_4d5c ; $4d56
	call WaterSpriteRacketRewardScene ; $4d59
Label_15_4d5c:
	ret ; $4d5c
WaterSpriteRacketRewardScene:
	script_wait_frames $3c ; $4d5d
	script_set_text $1aa5 ; $4d64
	script_speak $14 ; $4d6a
	script_wait_frames $1e ; $4d6f
	script_face $00, $80 ; $4d76
	script_wait_frames $1e ; $4d7d
	script_face $00, $00 ; $4d84
	script_wait_frames $1e ; $4d8b
	script_face $00, $80 ; $4d92
	script_wait_frames $1e ; $4d99
	script_face $00, $00 ; $4da0
	script_wait_frames $1e ; $4da7
	script_face $00, $40 ; $4dae
	script_wait_frames $1e ; $4db5
	script_set_objdef $4d, $16 ; $4dbc
	script_set_objdef $4c, $13 ; $4dc8
	script_set_position $16, $3480, $0b80 ; $4dd4
	sound $98 ; $4ddf
	script_wait_frames $3c ; $4de1
	script_set_position $14, $3300, $0700 ; $4de8
	script_set_active $14, $00 ; $4df3
	script_player_speed $0010 ; $4dfa
	script_move_player_to_actor $14 ; $4e00
	ld hl, $5950 ; $4e07
	ld de, $0206 ; $4e0a
	call LoadPalettesImmediate ; $4e0d
	script_wait_frames $1e ; $4e10
	ld hl, $5990 ; $4e17
	ld de, $0206 ; $4e1a
	call LoadPalettesImmediate ; $4e1d
	sound $8a ; $4e20
	ld a, $10 ; $4e22
Label_15_4e24:
	ld d, a ; $4e24
	script_set_active $14, $02 ; $4e25
	script_wait_frames $04 ; $4e2c
	script_set_active $14, $00 ; $4e33
	push af ; $4e3a
	ld a, d ; $4e3b
	farcall FarPtr_WaitScriptFrames ; $4e3c
	pop af ; $4e3f
	ld a, d ; $4e40
	sub a, $02 ; $4e41
	jp nz, Label_15_4e24 ; $4e43
	script_set_active $14, $02 ; $4e46
	script_wait_frames $3c ; $4e4d
	script_set_position $16, $3f00, $3f00 ; $4e54
	script_face $00, $c0 ; $4e5f
	script_wait_frames $1e ; $4e66
	script_set_position $13, $3480, $0b80 ; $4e6d
	sound $97 ; $4e78
	script_wait_frames $14 ; $4e7a
	script_jump_velocity $13, $ff40 ; $4e81
	script_jump_velocity $00, $ff40 ; $4e89
	ld a, $00 ; $4e91
	farcall FarPtr_ScriptWaitActorJumpDone ; $4e93
	script_set_position $13, $3f00, $3f00 ; $4e96
	script_set_anim $14, $03 ; $4ea1
	script_wait_idle $14 ; $4ea8
	script_speak $14 ; $4ead
	script_set_anim $00, $02 ; $4eb2
	script_wait_idle $00 ; $4eb9
	script_set_anim $14, $03 ; $4ebe
	script_wait_idle $14 ; $4ec5
	ld a, [wWaterSpriteMinigameSwingCount] ; $4eca
	cp a, $96 ; $4ecd
	jp nc, Label_15_4eef ; $4ecf
	farcall FarPtr_AdvanceDialogueTextCursor ; $4ed2
	ld a, $15 ; $4ed5
	farcall FarPtr_GetActorStateAddr ; $4ed7
	ld c, l ; $4eda
	ld b, h ; $4edb
	ld hl, $0037 ; $4edc
	add hl, bc ; $4edf
	ld a, [hl] ; $4ee0
	and a, $f8 ; $4ee1
	or a, $07 ; $4ee3
	ld [hl], a ; $4ee5
	set_flag $0c, 4 ; $4ee6
	ld a, $05 ; $4ee9
	ld b, a ; $4eeb
	jp Label_15_4ef5 ; $4eec
Label_15_4eef:
	set_flag $0c, 5 ; $4eef
	ld a, $04 ; $4ef2
	ld b, a ; $4ef4
Label_15_4ef5:
	ld a, [wEquippedRacket] ; $4ef5
	and a, $f0 ; $4ef8
	or a, b ; $4efa
	ld [wEquippedRacket], a ; $4efb
	script_speak $14 ; $4efe
	script_wait_frames $0a ; $4f03
	ld c, $03 ; $4f0a
	call BeginFadeOut ; $4f0c
	call WaitFadeEnd ; $4f0f
	sound $8e ; $4f12
	script_set_position $15, $3300, $0900 ; $4f14
	script_wait_frames $1e ; $4f1f
	script_fade_in $03 ; $4f26
	call WaitFadeEnd ; $4f2b
	script_wait_frames $3c ; $4f2e
	sound $8f ; $4f35
	script_set_speed $15, $0005 ; $4f37
	script_move_target $15, $3300, $0d00 ; $4f3f
	script_wait_move $15 ; $4f4a
	script_wait_frames $3c ; $4f4f
	farcall FarPtr_AdvanceDialogueTextCursor ; $4f56
	script_speak $00 ; $4f59
	script_set_position $17, $3480, $0b80 ; $4f5e
	sound $96 ; $4f69
	script_wait_frames $78 ; $4f6b
	script_set_position $17, $3f00, $3f00 ; $4f72
	script_set_anim $14, $03 ; $4f7d
	script_wait_idle $14 ; $4f84
	script_set_text $1aab ; $4f89
	script_speak $14 ; $4f8f
	script_wait_frames $32 ; $4f94
	sound $90 ; $4f9b
	ld d, $10 ; $4f9d
Label_15_4f9f:
	script_set_active $14, $00 ; $4f9f
	script_wait_frames $04 ; $4fa6
	script_set_active $14, $02 ; $4fad
	push af ; $4fb4
	ld a, d ; $4fb5
	farcall FarPtr_WaitScriptFrames ; $4fb6
	pop af ; $4fb9
	ld a, d ; $4fba
	sub a, $02 ; $4fbb
	ld d, a ; $4fbd
	jp nz, Label_15_4f9f ; $4fbe
	script_set_active $14, $00 ; $4fc1
	script_wait_frames $1e ; $4fc8
	script_set_position $14, $3300, $0b00 ; $4fcf
	script_speak $14 ; $4fda
	script_set_position $15, $3f00, $3f00 ; $4fdf
	ld hl, $5950 ; $4fea
	ld de, $0206 ; $4fed
	call LoadPalettesImmediate ; $4ff0
	script_wait_frames $1e ; $4ff3
	ld hl, $5910 ; $4ffa
	ld de, $0206 ; $4ffd
	call LoadPalettesImmediate ; $5000
	script_wait_frames $1e ; $5003
	script_face $00, $80 ; $500a
	script_wait_frames $14 ; $5011
	script_face $00, $00 ; $5018
	script_wait_frames $14 ; $501f
	script_face $00, $80 ; $5026
	script_wait_frames $14 ; $502d
	script_face $00, $00 ; $5034
	script_wait_frames $14 ; $503b
	script_face $00, $c0 ; $5042
	script_move_player_to_actor $00 ; $5049
	farcall FarPtr_WaitPlayerMoveDone ; $5050
	script_wait_frames $1e ; $5053
	ret ; $505a
TrainingCourtNpcScripts_15:
	; $505b, 161 bytes (map_scripts)
	map_script $03, $ff, $0000, Func_15_497a, $1b, $00
	map_script $04, $ff, $0000, Func_15_499b, $1b, $00
	map_script $05, $ff, $0000, Func_15_49bc, $1b, $00
	map_script $06, $ff, $0000, Func_15_50fc, $03, $00
	map_script $07, $80, $0000, Func_15_5112, $03, $00
	map_script $07, $ff, $0000, Func_15_513f, $03, $00
	map_script $08, $ff, $0000, Func_15_49dd, $1b, $00
	map_script $09, $ff, $0000, Func_15_49fe, $1b, $00
	map_script $0a, $ff, $0000, Func_15_4a1f, $1b, $00
	map_script $0b, $ff, $0000, Func_15_4a40, $1b, $00
	map_script $0c, $ff, $0000, Func_15_5254, $03, $00
	map_script $0d, $40, $0000, Func_15_526a, $03, $00
	map_script $0d, $ff, $0000, Func_15_5297, $03, $00
	map_script $0e, $ff, $0000, Func_15_4a80, $1b, $00
	map_script $0f, $ff, $0000, Func_15_4aa1, $1b, $00
	map_script $10, $ff, $0000, Func_15_4ae1, $1b, $00
	map_script $11, $ff, $0000, Func_15_51a8, $03, $00
	map_script $12, $40, $0000, Func_15_51be, $03, $00
	map_script $12, $ff, $0000, Func_15_51eb, $03, $00
	map_script $13, $ff, $0000, Func_15_4b21, $00, $00
	db $ff
Func_15_50fc:
	test_flag $18, 0 ; $50fc
	jr nz, Label_15_5105 ; $50ff
	call Func_15_63e1 ; $5101
	ret ; $5104
Label_15_5105:
	test_flag $18, 1 ; $5105
	jr nz, Label_15_510e ; $5108
	call Func_15_64a8 ; $510a
	ret ; $510d
Label_15_510e:
	call Func_15_6586 ; $510e
	ret ; $5111
Func_15_5112:
	script_set_speed $00, $0008 ; $5112
	script_facing_lock $00, $01 ; $511a
	script_move_target $00, $1300, $1300 ; $5121
	script_wait_move $00 ; $512c
	script_facing_lock $00, $00 ; $5131
	script_face $00, $40 ; $5138
Func_15_513f:
	test_flag $18, 3 ; $513f
	jr nz, Label_15_5148 ; $5142
	call Func_15_66f5 ; $5144
	ret ; $5147
Label_15_5148:
	test_flag $18, 4 ; $5148
	jr nz, Label_15_5172 ; $514b
	test_flag $17, 5 ; $514d
	jr nz, Label_15_515b ; $5150
	test_flag $0a, 3 ; $5152
	jr z, Label_15_515b ; $5155
	call Func_15_677e ; $5157
	ret ; $515a
Label_15_515b:
	script_set_text $1c21 ; $515b
	test_flag $0a, 3 ; $5161
	jr z, Label_15_516c ; $5164
	script_set_text $1c22 ; $5166
Label_15_516c:
	script_speak $07 ; $516c
	ret ; $5171
Label_15_5172:
	test_flag $18, 5 ; $5172
	jr nz, Label_15_519c ; $5175
	test_flag $17, 5 ; $5177
	jr nz, Label_15_5185 ; $517a
	test_flag $0a, 7 ; $517c
	jr z, Label_15_5185 ; $517f
	call Func_15_67fc ; $5181
	ret ; $5184
Label_15_5185:
	script_set_text $1c32 ; $5185
	test_flag $0a, 7 ; $518b
	jr z, Label_15_5196 ; $518e
	script_set_text $1c22 ; $5190
Label_15_5196:
	script_speak $07 ; $5196
	ret ; $519b
Label_15_519c:
	script_set_text $1c3d ; $519c
	script_speak $07 ; $51a2
	ret ; $51a7
Func_15_51a8:
	test_flag $18, 6 ; $51a8
	jr nz, Label_15_51b1 ; $51ab
	call Func_15_688f ; $51ad
	ret ; $51b0
Label_15_51b1:
	test_flag $18, 7 ; $51b1
	jr nz, Label_15_51ba ; $51b4
	call Func_15_6963 ; $51b6
	ret ; $51b9
Label_15_51ba:
	call Func_15_6a2d ; $51ba
	ret ; $51bd
Func_15_51be:
	script_set_speed $00, $0008 ; $51be
	script_facing_lock $00, $01 ; $51c6
	script_move_target $00, $2d00, $2b00 ; $51cd
	script_wait_move $00 ; $51d8
	script_facing_lock $00, $00 ; $51dd
	script_face $00, $c0 ; $51e4
Func_15_51eb:
	test_flag $19, 1 ; $51eb
	jr nz, Label_15_51f4 ; $51ee
	call NetCoachVolleyLessonScene ; $51f0
	ret ; $51f3
Label_15_51f4:
	test_flag $19, 2 ; $51f4
	jr nz, Label_15_521e ; $51f7
	test_flag $17, 6 ; $51f9
	jr nz, Label_15_5207 ; $51fc
	test_flag $0a, 3 ; $51fe
	jr z, Label_15_5207 ; $5201
	call NetCoachSmashLessonScene ; $5203
	ret ; $5206
Label_15_5207:
	script_set_text $1c80 ; $5207
	test_flag $0a, 7 ; $520d
	jr z, Label_15_5218 ; $5210
	script_set_text $1c83 ; $5212
Label_15_5218:
	script_speak $12 ; $5218
	ret ; $521d
Label_15_521e:
	test_flag $19, 3 ; $521e
	jr nz, Label_15_5248 ; $5221
	test_flag $17, 6 ; $5223
	jr nz, Label_15_5231 ; $5226
	test_flag $0a, 7 ; $5228
	jr z, Label_15_5231 ; $522b
	call NetCoachDropShotLessonScene ; $522d
	ret ; $5230
Label_15_5231:
	script_set_text $1c9e ; $5231
	test_flag $0a, 7 ; $5237
	jr z, Label_15_5242 ; $523a
	script_set_text $1c9c ; $523c
Label_15_5242:
	script_speak $12 ; $5242
	ret ; $5247
Label_15_5248:
	script_set_text $1cbb ; $5248
	script_speak $12 ; $524e
	ret ; $5253
Func_15_5254:
	test_flag $19, 4 ; $5254
	jr nz, Label_15_525d ; $5257
	call StrokeMatchChallengeScene ; $5259
	ret ; $525c
Label_15_525d:
	test_flag $19, 5 ; $525d
	jr nz, Label_15_5266 ; $5260
	call LobMatchChallengeScene ; $5262
	ret ; $5265
Label_15_5266:
	call ReturnMatchChallengeScene ; $5266
	ret ; $5269
Func_15_526a:
	script_set_speed $00, $0008 ; $526a
	script_facing_lock $00, $01 ; $5272
	script_move_target $00, $1300, $2b00 ; $5279
	script_wait_move $00 ; $5284
	script_facing_lock $00, $00 ; $5289
	script_face $00, $c0 ; $5290
Func_15_5297:
	test_flag $19, 7 ; $5297
	jr nz, Label_15_52a0 ; $529a
	call ReturnCoachReturnLessonScene ; $529c
	ret ; $529f
Label_15_52a0:
	test_flag $1a, 0 ; $52a0
	jr nz, Label_15_52d5 ; $52a3
	test_flag $17, 7 ; $52a5
	jr nz, Label_15_52b3 ; $52a8
	test_flag $0a, 3 ; $52aa
	jr z, Label_15_52b3 ; $52ad
	call ReturnCoachLobLessonScene ; $52af
	ret ; $52b2
Label_15_52b3:
	script_set_text $1ce1 ; $52b3
	test_flag $0a, 3 ; $52b9
	jr z, Label_15_52cf ; $52bc
	script_set_text $1ce2 ; $52be
	test_flag $0a, 7 ; $52c4
	jr z, Label_15_52cf ; $52c7
	script_set_text $1ce2 ; $52c9
Label_15_52cf:
	script_speak $0d ; $52cf
	ret ; $52d4
Label_15_52d5:
	test_flag $1a, 1 ; $52d5
	jr nz, Label_15_52f4 ; $52d8
	test_flag $17, 7 ; $52da
	jr nz, Label_15_52e8 ; $52dd
	test_flag $0a, 7 ; $52df
	jr z, Label_15_52e8 ; $52e2
	call ReturnCoachPassingShotLessonScene ; $52e4
	ret ; $52e7
Label_15_52e8:
	script_set_text $1cf8 ; $52e8
	script_speak $0d ; $52ee
	ret ; $52f3
Label_15_52f4:
	script_set_text $2012 ; $52f4
	script_speak $0d ; $52fa
	ret ; $52ff
TrainingCourtFacingScripts_15:
	; $5300, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_15_5309, $00, $00
	db $ff
Func_15_5309:
	ret ; $5309
TrainingCourtTileTriggers_15:
	; $530a, 9 bytes (map_scripts)
	map_script $01, $40, $9000, Func_15_5313, $00, $00
	db $ff
Func_15_5313:
	script_move_target $00, $3300, $0d00 ; $5313
	script_wait_move $00 ; $531e
	script_face $00, $40 ; $5323
	call Func_15_4d07 ; $532a
	ret ; $532d
TrainingCourtInitScript_15:
	call ComputeTrainingCourtProgressIndex ; $532e
	ld a, [$c2b0] ; $5331
	cp a, $05 ; $5334
	jr c, Label_15_5340 ; $5336
	ld a, [$c2b0] ; $5338
	sub a, $06 ; $533b
	ld [$c2b0], a ; $533d
Label_15_5340:
	ld a, [wStoryModeEntryPoint] ; $5340
	cp a, $0f ; $5343
	jr nz, Label_15_534b ; $5345
	call TrainingCourtIntroTourScene ; $5347
	ret ; $534a
Label_15_534b:
	call HideServeChallengerActor ; $534b
	call HideStrokeChallengerActor ; $534e
	call HideNetChallengerActor ; $5351
	call PlaceSwingPracticeKidActor ; $5354
	ld a, [wStoryModeEntryPoint] ; $5357
	cp a, $0a ; $535a
	jr nz, Label_15_5362 ; $535c
	call TrainingCourtResultDispatch ; $535e
	ret ; $5361
Label_15_5362:
	ld a, [wStoryModeEntryPoint] ; $5362
	cp a, $09 ; $5365
	jr nz, Label_15_536c ; $5367
	call StartPendingLessonScene ; $5369
Label_15_536c:
	ret ; $536c
TrainingCourtResultDispatch:
	ld a, [wMatchExitRequest] ; $536d
	cp a, $01 ; $5370
	jr nz, Label_15_5378 ; $5372
	call TrainingCourtReentryDispatch ; $5374
	ret ; $5377
Label_15_5378:
	ld a, [$c8f7] ; $5378
	cp a, $12 ; $537b
	jr c, Label_15_5380 ; $537d
	ret ; $537f
Label_15_5380:
	ld a, [$c8f7] ; $5380
	ld a, a ; $5383
	rst Rst00 ; $5384
	dw Label_15_5e85 ; $5385 jumptable
	dw Label_15_5eb7 ; $5387 jumptable
	dw Label_15_5edf ; $5389 jumptable
	dw Label_15_7290 ; $538b jumptable
	dw Label_15_729f ; $538d jumptable
	dw Label_15_72b4 ; $538f jumptable
	dw Label_15_62bf ; $5391 jumptable
	dw Label_15_6300 ; $5393 jumptable
	dw Label_15_6328 ; $5395 jumptable
	dw Label_15_7539 ; $5397 jumptable
	dw Label_15_754e ; $5399 jumptable
	dw Label_15_7563 ; $539b jumptable
	dw Label_15_6350 ; $539d jumptable
	dw Label_15_6391 ; $539f jumptable
	dw Label_15_63b9 ; $53a1 jumptable
	dw Label_15_77aa ; $53a3 jumptable
	dw Label_15_77bd ; $53a5 jumptable
	dw Label_15_77d0 ; $53a7 jumptable
TrainingCourtReentryDispatch:
	ld a, [$c8f7] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	dw Label_15_53d2 ; $53ae jumptable
	dw Label_15_53d2 ; $53b0 jumptable
	dw Label_15_53d2 ; $53b2 jumptable
	dw Label_15_5437 ; $53b4 jumptable
	dw Label_15_5437 ; $53b6 jumptable
	dw Label_15_5437 ; $53b8 jumptable
	dw Label_15_5482 ; $53ba jumptable
	dw Label_15_5482 ; $53bc jumptable
	dw Label_15_5482 ; $53be jumptable
	dw Label_15_54e7 ; $53c0 jumptable
	dw Label_15_54e7 ; $53c2 jumptable
	dw Label_15_54e7 ; $53c4 jumptable
	dw Label_15_5532 ; $53c6 jumptable
	dw Label_15_5532 ; $53c8 jumptable
	dw Label_15_5532 ; $53ca jumptable
	dw Label_15_5597 ; $53cc jumptable
	dw Label_15_5597 ; $53ce jumptable
	dw Label_15_5597 ; $53d0 jumptable
Label_15_53d2:
	xor a, a ; $53d2
	ld [wStoryModeShowLocationName], a ; $53d3
	ld a, $06 ; $53d6
	ld [$c2b1], a ; $53d8
	script_set_position $00, $1800, $1100 ; $53db
	script_face $00, $c0 ; $53e6
	ld a, [$c2b1] ; $53ed
	ld bc, $1800 ; $53f0
	ld de, $0d00 ; $53f3
	farcall FarPtr_ScriptSetActorPosition ; $53f6
	ld a, [$c2b1] ; $53f9
	ld b, $40 ; $53fc
	farcall FarPtr_SetActorFacing ; $53fe
	script_null_script $02 ; $5401
	script_set_position $02, $1300, $1100 ; $5406
	script_face $02, $00 ; $5411
	script_player_speed $00f0 ; $5418
	script_move_player $1800, $0f00 ; $541e
	farcall FarPtr_WaitPlayerMoveDone ; $5428
	script_fade_in $08 ; $542b
	call WaitFadeEnd ; $5430
	call WalkChallengerOntoCourt ; $5433
	ret ; $5436
Label_15_5437:
	xor a, a ; $5437
	ld [wStoryModeShowLocationName], a ; $5438
	script_player_speed $00f0 ; $543b
	script_set_position $00, $1300, $1300 ; $5441
	script_set_position $02, $1300, $1100 ; $544c
	script_move_player $1300, $1300 ; $5457
	farcall FarPtr_WaitPlayerMoveDone ; $5461
	script_face $00, $40 ; $5464
	script_face $02, $40 ; $546b
	script_face $07, $80 ; $5472
	script_fade_in $04 ; $5479
	call WaitFadeEnd ; $547e
	ret ; $5481
Label_15_5482:
	xor a, a ; $5482
	ld [wStoryModeShowLocationName], a ; $5483
	ld a, $11 ; $5486
	ld [$c2b1], a ; $5488
	script_set_position $00, $2800, $2a00 ; $548b
	script_face $00, $c0 ; $5496
	ld a, [$c2b1] ; $549d
	ld bc, $2800 ; $54a0
	ld de, $2500 ; $54a3
	farcall FarPtr_ScriptSetActorPosition ; $54a6
	ld a, [$c2b1] ; $54a9
	ld b, $40 ; $54ac
	farcall FarPtr_SetActorFacing ; $54ae
	script_null_script $02 ; $54b1
	script_set_position $02, $2d00, $2d00 ; $54b6
	script_face $02, $80 ; $54c1
	script_player_speed $00f0 ; $54c8
	script_move_player $2800, $2900 ; $54ce
	farcall FarPtr_WaitPlayerMoveDone ; $54d8
	script_fade_in $08 ; $54db
	call WaitFadeEnd ; $54e0
	call WalkChallengerOntoCourt ; $54e3
	ret ; $54e6
Label_15_54e7:
	xor a, a ; $54e7
	ld [wStoryModeShowLocationName], a ; $54e8
	script_player_speed $00f0 ; $54eb
	script_set_position $00, $2d00, $2b00 ; $54f1
	script_set_position $02, $2f00, $2b00 ; $54fc
	script_move_player $2d00, $2b00 ; $5507
	farcall FarPtr_WaitPlayerMoveDone ; $5511
	script_face $00, $c0 ; $5514
	script_face $02, $c0 ; $551b
	script_face $12, $00 ; $5522
	script_fade_in $04 ; $5529
	call WaitFadeEnd ; $552e
	ret ; $5531
Label_15_5532:
	xor a, a ; $5532
	ld [wStoryModeShowLocationName], a ; $5533
	ld a, $0c ; $5536
	ld [$c2b1], a ; $5538
	script_set_position $00, $1800, $2a00 ; $553b
	script_face $00, $c0 ; $5546
	ld a, [$c2b1] ; $554d
	ld bc, $1800 ; $5550
	ld de, $2500 ; $5553
	farcall FarPtr_ScriptSetActorPosition ; $5556
	ld a, [$c2b1] ; $5559
	ld b, $40 ; $555c
	farcall FarPtr_SetActorFacing ; $555e
	script_null_script $02 ; $5561
	script_set_position $02, $1300, $2d00 ; $5566
	script_face $02, $00 ; $5571
	script_player_speed $00f0 ; $5578
	script_move_player $1800, $2800 ; $557e
	farcall FarPtr_WaitPlayerMoveDone ; $5588
	script_fade_in $08 ; $558b
	call WaitFadeEnd ; $5590
	call WalkChallengerOntoCourt ; $5593
	ret ; $5596
Label_15_5597:
	xor a, a ; $5597
	ld [wStoryModeShowLocationName], a ; $5598
	script_player_speed $00f0 ; $559b
	script_set_position $00, $1300, $2b00 ; $55a1
	script_set_position $02, $1100, $2b00 ; $55ac
	script_move_player $1300, $2b00 ; $55b7
	farcall FarPtr_WaitPlayerMoveDone ; $55c1
	script_face $00, $c0 ; $55c4
	script_face $02, $c0 ; $55cb
	script_face $0d, $c0 ; $55d2
	script_fade_in $04 ; $55d9
	call WaitFadeEnd ; $55de
	ret ; $55e1
ActorScript_15_55e2:
	; $55e2, 4 bytes (actor_script)
	as_set_field $18, $0004
ActorScript_15_55e6:
	; $55e6, 3 bytes (actor_script)
	as_anim $06
	as_halt
ActorScript_15_55e9:
	; $55e9, 7 bytes (actor_script)
	as_anim $08
	as_wait $3c
	as_jump ActorScript_15_55e9
	ldh a, [hInputRisingEdge] ; $55f0
	and a, $03 ; $55f2
	ld d, a ; $55f4
	ld hl, $c2b8 ; $55f5
	ld a, [hl] ; $55f8
	or a, a ; $55f9
	ld [hl], d ; $55fa
	jr nz, Label_15_562d ; $55fb
	ld a, d ; $55fd
	or a, a ; $55fe
	jr z, Label_15_562d ; $55ff
	ld hl, wWaterSpriteMinigameSwingCount ; $5601
	ld a, [hl+] ; $5604
	ld d, [hl] ; $5605
	ld e, a ; $5606
	inc de ; $5607
	ld hl, wWaterSpriteMinigameSwingCount ; $5608
	ld a, e ; $560b
	ld [hl+], a ; $560c
	ld [hl], d ; $560d
	push hl ; $560e
	push de ; $560f
	ld h, d ; $5610
	ld l, e ; $5611
	ld de, $0f04 ; $5612
	call PrintHexWord ; $5615
	pop de ; $5618
	pop hl ; $5619
	ld a, [$c2b9] ; $561a
	cp a, $02 ; $561d
	jr z, Label_15_5628 ; $561f
	ld a, $02 ; $5621
	ld [$c2b9], a ; $5623
	jr Label_15_562d ; $5626
Label_15_5628:
	ld a, $01 ; $5628
	ld [$c2b9], a ; $562a
Label_15_562d:
	ld hl, wWaterSpriteMinigameTimer ; $562d
	ld a, [hl+] ; $5630
	ld d, [hl] ; $5631
	ld e, a ; $5632
	dec de ; $5633
	ld a, d ; $5634
	or a, e ; $5635
	jr z, Label_15_563f ; $5636
	ld hl, wWaterSpriteMinigameTimer ; $5638
	ld a, e ; $563b
	ld [hl+], a ; $563c
	ld [hl], d ; $563d
	ret ; $563e
Label_15_563f:
	ld hl, $55f0 ; $563f
	call UnregisterFrameTask ; $5642
	xor a, a ; $5645
	ld [$c2b9], a ; $5646
	ret ; $5649
WaterSpriteSwingContestScene:
	ld de, $a100 ; $564a
	ld b, $0a ; $564d
	ld c, $01 ; $564f
	farcall FarPtr_39_64 ; $5651
	ld a, $0a ; $5654
	ld [$cb6c], a ; $5656
	ld a, $10 ; $5659
	ld [$cb6b], a ; $565b
	call InitWaterSpriteMinigameHud ; $565e
	script_face $00, $40 ; $5661
	ld b, $20 ; $5668
	ld e, $10 ; $566a
Label_15_566c:
	ld a, $20 ; $566c
	sub a, b ; $566e
	ld d, a ; $566f
	ld hl, $000a ; $5670
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5673
	ld a, $18 ; $5676
	sub a, b ; $5678
	ld [wWaterSpriteMinigameFlag], a ; $5679
	ld a, $80 ; $567c
	add a, b ; $567e
	ld d, a ; $567f
	ld hl, $0000 ; $5680
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5683
	ld a, $74 ; $5686
	add a, b ; $5688
	ld [$c2bb], a ; $5689
	script_wait_frames $01 ; $568c
	dec b ; $5693
	jp nz, Label_15_566c ; $5694
	ld de, $0258 ; $5697
	ld hl, wWaterSpriteMinigameTimer ; $569a
	ld a, e ; $569d
	ld [hl+], a ; $569e
	ld [hl], d ; $569f
	ld hl, wWaterSpriteMinigameSwingCount ; $56a0
	xor a, a ; $56a3
	ld [hl+], a ; $56a4
	ld [hl+], a ; $56a5
	ld [hl+], a ; $56a6
	ld [hl+], a ; $56a7
	ld a, $01 ; $56a8
	ld [$c2b9], a ; $56aa
	ld a, $01 ; $56ad
	ld hl, $578d ; $56af
	call RegisterFrameTask ; $56b2
	script_wait_frames $32 ; $56b5
	ld l, $03 ; $56bc
	ld h, $00 ; $56be
	ld de, $502c ; $56c0
Label_15_56c3:
	sound $8c ; $56c3
	ld b, $3c ; $56c5
Label_15_56c7:
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $56c7
	script_wait_frames $01 ; $56ca
	dec b ; $56d1
	jp nz, Label_15_56c7 ; $56d2
	dec l ; $56d5
	jp nz, Label_15_56c3 ; $56d6
	sound $75 ; $56d9
	call Func_15_5777 ; $56db
	ld a, $01 ; $56de
	ld hl, $55f0 ; $56e0
	call RegisterFrameTask ; $56e3
Label_15_56e6:
	call AdvanceFrame ; $56e6
	ld a, [$c2b9] ; $56e9
	cp a, $00 ; $56ec
	jr z, Label_15_5708 ; $56ee
	cp a, $01 ; $56f0
	jr z, Label_15_56fe ; $56f2
	ld a, $09 ; $56f4
	ld d, a ; $56f6
	ld a, $00 ; $56f7
	farcall FarPtr_ScriptSetActorAnimation ; $56f9
	jr Label_15_56e6 ; $56fc
Label_15_56fe:
	ld a, $0a ; $56fe
	ld d, a ; $5700
	ld a, $00 ; $5701
	farcall FarPtr_ScriptSetActorAnimation ; $5703
	jr Label_15_56e6 ; $5706
Label_15_5708:
	sound $8d ; $5708
	script_set_anim $00, $02 ; $570a
	script_wait_idle $00 ; $5711
	script_wait_frames $3c ; $5716
	call Func_15_5777 ; $571d
	ld hl, $578d ; $5720
	call UnregisterFrameTask ; $5723
	ld b, $30 ; $5726
	ld e, $10 ; $5728
Label_15_572a:
	ld a, b ; $572a
	sub a, $10 ; $572b
	ld d, a ; $572d
	ld hl, $0000 ; $572e
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5731
	ld a, $e8 ; $5734
	add a, b ; $5736
	ld [wWaterSpriteMinigameFlag], a ; $5737
	ld a, $b0 ; $573a
	sub a, b ; $573c
	ld d, a ; $573d
	ld hl, wWaterSpriteMinigameSwingCount ; $573e
	ld a, [hl+] ; $5741
	ld h, [hl] ; $5742
	ld l, a ; $5743
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5744
	ld a, $a4 ; $5747
	sub a, b ; $5749
	ld [$c2bb], a ; $574a
	script_wait_frames $01 ; $574d
	dec b ; $5754
	jp nz, Label_15_572a ; $5755
	ld hl, $58d1 ; $5758
	call UnregisterFrameTask ; $575b
	call WaitFramesCmd ; $575e
	db $3c ; $5761 inline arg
	script_set_text $1aa4 ; $5762
	ld hl, wWaterSpriteMinigameSwingCount ; $5768
	ld a, [hl+] ; $576b
	ld h, [hl] ; $576c
	ld l, a ; $576d
	farcall FarPtr_PushTextArgNumber ; $576e
	script_speak $00 ; $5771
	ret ; $5776
Func_15_5777:
	ld a, [$c90e] ; $5777
	and a, a ; $577a
	jr z, Label_15_578c ; $577b
	ld a, $00 ; $577d
	farcall FarPtr_GetActorStateAddr ; $577f
	ld c, l ; $5782
	ld b, h ; $5783
	ld hl, $0037 ; $5784
	add hl, bc ; $5787
	ld a, [hl] ; $5788
	xor a, $20 ; $5789
	ld [hl], a ; $578b
Label_15_578c:
	ret ; $578c
	ld hl, wWaterSpriteMinigameTimer ; $578d
	ld a, [hl+] ; $5790
	ld h, [hl] ; $5791
	ld l, a ; $5792
	ld a, $00 ; $5793
	ld e, $3c ; $5795
	call DivAHLByE ; $5797
	ld de, $2010 ; $579a
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $579d
	ld hl, wWaterSpriteMinigameSwingCount ; $57a0
	ld a, [hl+] ; $57a3
	ld h, [hl] ; $57a4
	ld l, a ; $57a5
	ld de, $8010 ; $57a6
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $57a9
	ret ; $57ac
SpriteTemplate_15_57ad:
	; $57ad, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
SpriteTemplate_15_57ba:
	; $57ba, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
	INCBIN "data/bank_015/d_57c7.bin" ; $57c7, 209 bytes
LoadWaterSpriteMinigameHudGfx:
	ldh a, [hWramBank] ; $5898
	push af ; $589a
	wram_bank $01 ; $589b
	ld hl, $57d0 ; $58a1
	ld de, $a000 ; $58a4
	ld c, $0c ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, $5890 ; $58ac
	ld de, $0802 ; $58af
	call LoadPaletteShadow ; $58b2
	pop af ; $58b5
	wram_bank ; $58b6
	ret ; $58ba
QueueWaterSpriteMinigameTimerPanel:
	ld hl, SpriteTemplate_15_57ad ; $58bb
	ld c, $00 ; $58be
	ld b, $08 ; $58c0
	call QueueSpriteTemplate ; $58c2
	ret ; $58c5
QueueWaterSpriteMinigameCounterPanel:
	ld hl, SpriteTemplate_15_57ba ; $58c6
	ld c, $06 ; $58c9
	ld b, $08 ; $58cb
	call QueueSpriteTemplate ; $58cd
	ret ; $58d0
	ld a, [wWaterSpriteMinigameFlag] ; $58d1
	ld d, a ; $58d4
	ld e, $18 ; $58d5
	call QueueWaterSpriteMinigameTimerPanel ; $58d7
	ld a, [$c2bb] ; $58da
	ld d, a ; $58dd
	ld e, $18 ; $58de
	call QueueWaterSpriteMinigameCounterPanel ; $58e0
	ret ; $58e3
InitWaterSpriteMinigameHud:
	call LoadWaterSpriteMinigameHudGfx ; $58e4
	ld a, $e8 ; $58e7
	ld [wWaterSpriteMinigameFlag], a ; $58e9
	ld a, $a0 ; $58ec
	ld [$c2bb], a ; $58ee
	ld a, $01 ; $58f1
	ld hl, $58d1 ; $58f3
	call RegisterFrameTask ; $58f6
	ret ; $58f9
	INCBIN "data/bank_015/d_58fa.bin" ; $58fa, 198 bytes
TrainingCourtIntroTourScene:
	xor a, a ; $59c0
	ld [wStoryModeShowLocationName], a ; $59c1
	ldh a, [hRomBank] ; $59c4
	ld hl, TrainingCourtTourActors_15 ; $59c6
	farcall FarPtr_ScriptRespawnLocationActors ; $59c9
	farcall FarPtr_BeginCutsceneScriptMode ; $59cc
	script_set_position $00, $3f00, $3f00 ; $59cf
	script_set_position $0d, $3f00, $3f00 ; $59da
	script_set_position $0d, $0700, $36c0 ; $59e5
	script_move_target $0d, $1f00, $36c0 ; $59f0
	script_wait_frames $0a ; $59fb
	script_set_position $00, $0500, $3700 ; $5a02
	script_move_target $00, $1f00, $3700 ; $5a0d
	script_move_player $1f00, $3700 ; $5a18
	script_fade_in $04 ; $5a22
	call WaitFadeEnd ; $5a27
	script_wait_move $0d ; $5a2a
	script_move_target $0d, $1f00, $2b00 ; $5a2f
	script_wait_move $00 ; $5a3a
	script_move_target $00, $1f00, $2d00 ; $5a3f
	farcall FarPtr_WaitPlayerMoveDone ; $5a4a
	script_move_player $1f00, $2d00 ; $5a4d
	farcall FarPtr_WaitPlayerMoveDone ; $5a57
	script_wait_frames $3c ; $5a5a
	script_face $0d, $00 ; $5a61
	script_wait_frames $3c ; $5a68
	script_face $0d, $80 ; $5a6f
	script_wait_frames $3c ; $5a76
	script_face $0d, $40 ; $5a7d
	script_wait_frames $3c ; $5a84
	script_face $0d, $00 ; $5a8b
	script_player_speed $0040 ; $5a92
	script_set_text $1a73 ; $5a98
	script_speak $0d ; $5a9e
	script_set_anim $00, $03 ; $5aa3
	script_wait_idle $00 ; $5aaa
	script_face $00, $00 ; $5aaf
	script_move_player $2d00, $2900 ; $5ab6
	farcall FarPtr_WaitPlayerMoveDone ; $5ac0
	script_speak $0d ; $5ac3
	script_wait_frames $3c ; $5ac8
	script_face_toward $00, $0d ; $5acf
	script_move_player $1f00, $2d00 ; $5ad7
	farcall FarPtr_WaitPlayerMoveDone ; $5ae1
	script_set_anim $00, $03 ; $5ae4
	script_wait_idle $00 ; $5aeb
	script_face $0d, $80 ; $5af0
	script_wait_frames $28 ; $5af7
	script_face $00, $80 ; $5afe
	script_speak $0d ; $5b05
	script_move_player_to_actor $0b ; $5b0a
	farcall FarPtr_WaitPlayerMoveDone ; $5b11
	script_wait_frames $3c ; $5b14
	script_face_toward $00, $0d ; $5b1b
	script_move_player_to_actor $0d ; $5b23
	farcall FarPtr_WaitPlayerMoveDone ; $5b2a
	script_set_anim $00, $03 ; $5b2d
	script_wait_idle $00 ; $5b34
	script_speak $0d ; $5b39
	script_face_toward $0d, $00 ; $5b3e
	script_set_anim $00, $02 ; $5b46
	script_wait_idle $00 ; $5b4d
	script_speak $0d ; $5b52
	script_set_anim $00, $03 ; $5b57
	script_wait_idle $00 ; $5b5e
	script_set_anim $0d, $03 ; $5b63
	script_wait_idle $0d ; $5b6a
	script_speak $0d ; $5b6f
	script_set_anim $00, $03 ; $5b74
	script_wait_idle $00 ; $5b7b
	script_player_speed $0020 ; $5b80
	script_face $00, $80 ; $5b86
	script_move_target $0d, $1e00, $2b00 ; $5b8d
	script_wait_move $0d ; $5b98
	script_facing_lock $00, $01 ; $5b9d
	script_move_target $00, $2000, $2d00 ; $5ba4
	script_move_target $0d, $1e00, $2f00 ; $5baf
	script_wait_move $0d ; $5bba
	script_move_target $00, $1f00, $2d00 ; $5bbf
	script_wait_move $00 ; $5bca
	script_facing_lock $00, $00 ; $5bcf
	script_move_target $0d, $1f00, $2f00 ; $5bd6
	script_wait_move $0d ; $5be1
	script_move_target $00, $1f00, $3700 ; $5be6
	script_move_player $1f00, $3700 ; $5bf1
	script_move_target $0d, $1f00, $3700 ; $5bfb
	script_wait_move $0d ; $5c06
	script_move_target $0d, $0300, $3700 ; $5c0b
	script_move_player $0900, $3700 ; $5c16
	script_wait_move $00 ; $5c20
	script_move_target $00, $0300, $3700 ; $5c25
	script_wait_frames $5a ; $5c30
	ld c, $08 ; $5c37
	call BeginFadeOut ; $5c39
	script_wait_frames $14 ; $5c3c
	ld a, $0f ; $5c43
	ld [$c294], a ; $5c45
	ld [wStoryModeExitLocationRequest], a ; $5c48
	farcall FarPtr_EndCutsceneScriptMode ; $5c4b
	ret ; $5c4e
TrainingCourtTourActors_15:
	; $5c4f, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_55e6, $3300, $2a00, $c0, $39, $01, $06
	map_actor $0000, ActorScript_15_55e6, $3500, $2300, $40, $32, $01, $03
	map_actor $0000, ActorScript_15_55e6, $3500, $2a00, $c0, $34, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $2d00, $2100, $00, $66, $01, $07
	map_actor $0000, ActorScript_15_55e6, $0b00, $2300, $40, $34, $01, $03
	map_actor $0000, ActorScript_15_55e6, $0d00, $2300, $40, $39, $01, $05
	map_actor $0000, ActorScript_15_55e6, $0c00, $2900, $c0, $33, $01, $04
	map_actor $0000, ActorScript_15_7d6d, $1300, $2700, $40, $64, $01, $06
	map_actor $0000, ActorScript_15_7d6d, $1300, $2900, $c0, $68, $01, $04
	map_actor $0000, ActorScript_15_7d6d, $2d00, $2900, $00, $6b, $01, $07
	map_actor $0000, ActorScript_15_7d6d, $0100, $0100, $40, $49, $01, $00
	map_actor_end
ServeChallengerResultScene:
	xor a, a ; $5cf3
	ld [wStoryModeShowLocationName], a ; $5cf4
	ld a, $06 ; $5cf7
	ld [$c2b1], a ; $5cf9
	script_set_position $00, $1800, $1100 ; $5cfc
	script_face $00, $c0 ; $5d07
	ld a, [$c2b1] ; $5d0e
	ld bc, $1800 ; $5d11
	ld de, $0d00 ; $5d14
	farcall FarPtr_ScriptSetActorPosition ; $5d17
	ld a, [$c2b1] ; $5d1a
	ld b, $40 ; $5d1d
	farcall FarPtr_SetActorFacing ; $5d1f
	script_null_script $02 ; $5d22
	script_set_position $02, $1300, $1100 ; $5d27
	script_face $02, $00 ; $5d32
	script_player_speed $00f0 ; $5d39
	script_move_player $1800, $0f00 ; $5d3f
	farcall FarPtr_WaitPlayerMoveDone ; $5d49
	script_fade_in $08 ; $5d4c
	call WaitFadeEnd ; $5d51
	ld a, [wPointWinLoseFlag] ; $5d54
	inc a ; $5d57
	cp a, $01 ; $5d58
	jr nz, Label_15_5d69 ; $5d5a
	ld hl, $c2b2 ; $5d5c
	ld de, $201d ; $5d5f
	ld a, e ; $5d62
	ld [hl+], a ; $5d63
	ld [hl], d ; $5d64
	ld a, [wPointWinLoseFlag] ; $5d65
	inc a ; $5d68
Label_15_5d69:
	ld a, a ; $5d69
	rst Rst00 ; $5d6a
	dw Label_15_5f58 ; $5d6b jumptable
	dw Label_15_5f07 ; $5d6d jumptable
	dw Label_15_5fc2 ; $5d6f jumptable
	dw Label_15_5e74 ; $5d71 jumptable
	ret ; $5d73
NetChallengerResultScene:
	xor a, a ; $5d74
	ld [wStoryModeShowLocationName], a ; $5d75
	ld a, $11 ; $5d78
	ld [$c2b1], a ; $5d7a
	script_set_position $00, $2800, $2a00 ; $5d7d
	script_face $00, $c0 ; $5d88
	ld a, [$c2b1] ; $5d8f
	ld bc, $2800 ; $5d92
	ld de, $2500 ; $5d95
	farcall FarPtr_ScriptSetActorPosition ; $5d98
	ld a, [$c2b1] ; $5d9b
	ld b, $40 ; $5d9e
	farcall FarPtr_SetActorFacing ; $5da0
	script_null_script $02 ; $5da3
	script_set_position $02, $2d00, $2d00 ; $5da8
	script_face $02, $80 ; $5db3
	script_player_speed $00f0 ; $5dba
	script_move_player $2800, $2900 ; $5dc0
	farcall FarPtr_WaitPlayerMoveDone ; $5dca
	script_fade_in $08 ; $5dcd
	call WaitFadeEnd ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp a, $01 ; $5dd9
	jr nz, Label_15_5dea ; $5ddb
	ld hl, $c2b2 ; $5ddd
	ld de, $204a ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
Label_15_5dea:
	ld a, a ; $5dea
	rst Rst00 ; $5deb
	dw Label_15_5f58 ; $5dec jumptable
	dw Label_15_5f07 ; $5dee jumptable
	dw Label_15_5fc2 ; $5df0 jumptable
	ret ; $5df2
StrokeChallengerResultScene:
	xor a, a ; $5df3
	ld [wStoryModeShowLocationName], a ; $5df4
	ld a, $0c ; $5df7
	ld [$c2b1], a ; $5df9
	script_set_position $00, $1800, $2a00 ; $5dfc
	script_face $00, $c0 ; $5e07
	ld a, [$c2b1] ; $5e0e
	ld bc, $1800 ; $5e11
	ld de, $2500 ; $5e14
	farcall FarPtr_ScriptSetActorPosition ; $5e17
	ld a, [$c2b1] ; $5e1a
	ld b, $40 ; $5e1d
	farcall FarPtr_SetActorFacing ; $5e1f
	script_null_script $02 ; $5e22
	script_set_position $02, $1300, $2d00 ; $5e27
	script_face $02, $00 ; $5e32
	script_player_speed $00f0 ; $5e39
	script_move_player $1800, $2800 ; $5e3f
	farcall FarPtr_WaitPlayerMoveDone ; $5e49
	script_fade_in $08 ; $5e4c
	call WaitFadeEnd ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp a, $01 ; $5e58
	jr nz, Label_15_5e69 ; $5e5a
	ld hl, $c2b2 ; $5e5c
	ld de, $2078 ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
Label_15_5e69:
	ld a, a ; $5e69
	rst Rst00 ; $5e6a
	dw Label_15_5f58 ; $5e6b jumptable
	dw Label_15_5f07 ; $5e6d jumptable
	dw Label_15_5fc2 ; $5e6f jumptable
	dw Label_15_5e74 ; $5e71 jumptable
	ret ; $5e73
Label_15_5e74:
	script_jump_velocity $00, $ff40 ; $5e74
	ld a, $00 ; $5e7c
	farcall FarPtr_ScriptWaitActorJumpDone ; $5e7e
	jp Label_15_5f58 ; $5e81
	ret ; $5e84
Label_15_5e85:
	ld hl, wWaterSpriteMinigameFlag ; $5e85
	ld de, $2020 ; $5e88
	ld a, e ; $5e8b
	ld [hl+], a ; $5e8c
	ld [hl], d ; $5e8d
	ld hl, wWaterSpriteMinigameTimer ; $5e8e
	ld de, $201d ; $5e91
	ld a, e ; $5e94
	ld [hl+], a ; $5e95
	ld [hl], d ; $5e96
	ld hl, wWaterSpriteMinigameSwingCount ; $5e97
	test_flag $0a, 3 ; $5e9a
	jr z, Label_15_5ea4 ; $5e9d
	ld de, $2023 ; $5e9f
	jr Label_15_5ea7 ; $5ea2
Label_15_5ea4:
	ld de, $2022 ; $5ea4
Label_15_5ea7:
	ld a, e ; $5ea7
	ld [hl+], a ; $5ea8
	ld [hl], d ; $5ea9
	ld hl, $c2b8 ; $5eaa
	ld de, $2024 ; $5ead
	ld a, e ; $5eb0
	ld [hl+], a ; $5eb1
	ld [hl], d ; $5eb2
	call ServeChallengerResultScene ; $5eb3
	ret ; $5eb6
Label_15_5eb7:
	ld hl, wWaterSpriteMinigameFlag ; $5eb7
	ld de, $2020 ; $5eba
	ld a, e ; $5ebd
	ld [hl+], a ; $5ebe
	ld [hl], d ; $5ebf
	ld hl, wWaterSpriteMinigameTimer ; $5ec0
	ld de, $201d ; $5ec3
	ld a, e ; $5ec6
	ld [hl+], a ; $5ec7
	ld [hl], d ; $5ec8
	ld hl, wWaterSpriteMinigameSwingCount ; $5ec9
	ld de, $2031 ; $5ecc
	ld a, e ; $5ecf
	ld [hl+], a ; $5ed0
	ld [hl], d ; $5ed1
	ld hl, $c2b8 ; $5ed2
	ld de, $2032 ; $5ed5
	ld a, e ; $5ed8
	ld [hl+], a ; $5ed9
	ld [hl], d ; $5eda
	call ServeChallengerResultScene ; $5edb
	ret ; $5ede
Label_15_5edf:
	ld hl, wWaterSpriteMinigameFlag ; $5edf
	ld de, $2020 ; $5ee2
	ld a, e ; $5ee5
	ld [hl+], a ; $5ee6
	ld [hl], d ; $5ee7
	ld hl, wWaterSpriteMinigameTimer ; $5ee8
	ld de, $201d ; $5eeb
	ld a, e ; $5eee
	ld [hl+], a ; $5eef
	ld [hl], d ; $5ef0
	ld hl, wWaterSpriteMinigameSwingCount ; $5ef1
	ld de, $203d ; $5ef4
	ld a, e ; $5ef7
	ld [hl+], a ; $5ef8
	ld [hl], d ; $5ef9
	ld hl, $c2b8 ; $5efa
	ld de, $203e ; $5efd
	ld a, e ; $5f00
	ld [hl+], a ; $5f01
	ld [hl], d ; $5f02
	call ServeChallengerResultScene ; $5f03
	ret ; $5f06
Label_15_5f07:
	ld hl, wWaterSpriteMinigameTimer ; $5f07
	ld a, [hl+] ; $5f0a
	ld h, [hl] ; $5f0b
	ld l, a ; $5f0c
	farcall FarPtr_InitDialogueTextCursor ; $5f0d
	ld a, [$c2b1] ; $5f10
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f13
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f16
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f19
	script_wait_frames $05 ; $5f1c
	and a, a ; $5f23
	jr nz, Label_15_5f48 ; $5f24
	ld a, [$c2b1] ; $5f26
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f29
	ld a, $0f ; $5f2c
	ld [wStoryModeCurrentLocation], a ; $5f2e
	ld a, $0a ; $5f31
	ld [wStoryModeEntryPoint], a ; $5f33
	ld a, $ff ; $5f36
	ld [$c294], a ; $5f38
	ld [wStoryModeExitLocationRequest], a ; $5f3b
	ld a, [$c8f7] ; $5f3e
	farcall FarPtr_RunTrainingDrillByID ; $5f41
	farcall FarPtr_EndCutsceneScriptMode ; $5f44
	ret ; $5f47
Label_15_5f48:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f48
	ld a, [$c2b1] ; $5f4b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f4e
	call WalkChallengerOntoCourt ; $5f51
	farcall FarPtr_EndCutsceneScriptMode ; $5f54
	ret ; $5f57
Label_15_5f58:
	ld hl, wWaterSpriteMinigameSwingCount ; $5f58
	ld a, [hl+] ; $5f5b
	ld h, [hl] ; $5f5c
	ld l, a ; $5f5d
	farcall FarPtr_InitDialogueTextCursor ; $5f5e
	ld a, [$c2b1] ; $5f61
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f64
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f67
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f6a
	script_wait_frames $05 ; $5f6d
	and a, a ; $5f74
	jr nz, Label_15_5fa2 ; $5f75
	ld hl, wWaterSpriteMinigameFlag ; $5f77
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall FarPtr_InitDialogueTextCursor ; $5f7d
	ld a, [$c2b1] ; $5f80
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f83
	ld a, $0f ; $5f86
	ld [wStoryModeCurrentLocation], a ; $5f88
	ld a, $0a ; $5f8b
	ld [wStoryModeEntryPoint], a ; $5f8d
	ld a, $ff ; $5f90
	ld [$c294], a ; $5f92
	ld [wStoryModeExitLocationRequest], a ; $5f95
	ld a, [$c8f7] ; $5f98
	farcall FarPtr_RunTrainingDrillByID ; $5f9b
	farcall FarPtr_EndCutsceneScriptMode ; $5f9e
	ret ; $5fa1
Label_15_5fa2:
	ld hl, wWaterSpriteMinigameFlag ; $5fa2
	ld a, [hl+] ; $5fa5
	ld h, [hl] ; $5fa6
	ld l, a ; $5fa7
	farcall FarPtr_InitDialogueTextCursor ; $5fa8
	farcall FarPtr_AdvanceDialogueTextCursor ; $5fab
	ld a, [$c2b1] ; $5fae
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fb1
	call WalkChallengerOntoCourt ; $5fb4
	farcall FarPtr_EndCutsceneScriptMode ; $5fb7
	ret ; $5fba
	call WalkChallengerOntoCourt ; $5fbb
	farcall FarPtr_EndCutsceneScriptMode ; $5fbe
	ret ; $5fc1
Label_15_5fc2:
	ld a, [$c2b1] ; $5fc2
	ld d, $02 ; $5fc5
	farcall FarPtr_ScriptSetActorAnimation ; $5fc7
	ld a, [$c2b1] ; $5fca
	farcall FarPtr_ScriptWaitActorIdle ; $5fcd
	ld hl, $c2b8 ; $5fd0
	ld a, [hl+] ; $5fd3
	ld h, [hl] ; $5fd4
	ld l, a ; $5fd5
	farcall FarPtr_InitDialogueTextCursor ; $5fd6
	ld a, [$c2b1] ; $5fd9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fdc
	ld a, [$c2b1] ; $5fdf
	ld b, $01 ; $5fe2
	farcall FarPtr_ScriptSetActorFacingLock ; $5fe4
	ld a, [$c2b1] ; $5fe7
	ld b, $c0 ; $5fea
	ld de, $0100 ; $5fec
	farcall FarPtr_MoveActorByAngle ; $5fef
	ld a, [$c2b1] ; $5ff2
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ff5
	script_wait_frames $28 ; $5ff8
	ld a, [$c2b1] ; $5fff
	ld b, $c0 ; $6002
	ld de, $0100 ; $6004
	farcall FarPtr_MoveActorByAngle ; $6007
	ld a, [$c2b1] ; $600a
	farcall FarPtr_ScriptWaitActorMoveDone ; $600d
	ld a, [$c2b1] ; $6010
	ld d, $02 ; $6013
	farcall FarPtr_ScriptSetActorAnimation ; $6015
	ld a, [$c2b1] ; $6018
	farcall FarPtr_ScriptWaitActorIdle ; $601b
	ld a, [$c2b1] ; $601e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6021
	ld a, [$c2b1] ; $6024
	ld b, $00 ; $6027
	farcall FarPtr_ScriptSetActorFacingLock ; $6029
	call WalkChallengerAwayDefeated ; $602c
	ld a, [$c2b1] ; $602f
	ld bc, $3f00 ; $6032
	ld de, $3f00 ; $6035
	farcall FarPtr_ScriptSetActorPosition ; $6038
	call MovePlayerToLessonCourtSpot ; $603b
	farcall FarPtr_EndCutsceneScriptMode ; $603e
	ret ; $6041
WalkChallengerAwayDefeated:
	ld a, [$c8f7] ; $6042
	sub a, $0a ; $6045
	jp nc, Label_15_60f6 ; $6047
	ld a, [$c8f7] ; $604a
	sub a, $04 ; $604d
	jp c, Label_15_6056 ; $604f
	jp Label_15_60af ; $6052
	ret ; $6055
Label_15_6056:
	ld a, [$c2b1] ; $6056
	ld bc, $0030 ; $6059
	farcall FarPtr_ScriptSetActorMoveSpeed ; $605c
	ld a, [$c2b1] ; $605f
	farcall FarPtr_GetActorStateAddr ; $6062
	ld a, $04 ; $6065
	ld e, l ; $6067
	ld d, h ; $6068
	ld hl, $0018 ; $6069
	add hl, de ; $606c
	ld [hl], a ; $606d
	ld a, [$c2b1] ; $606e
	ld bc, $1f00 ; $6071
	ld de, $0b00 ; $6074
	farcall FarPtr_ScriptSetActorMoveTarget ; $6077
	ld a, [$c2b1] ; $607a
	farcall FarPtr_ScriptWaitActorMoveDone ; $607d
	ld a, [$c2b1] ; $6080
	ld bc, $1f00 ; $6083
	ld de, $1100 ; $6086
	farcall FarPtr_ScriptSetActorMoveTarget ; $6089
	ld a, [$c2b1] ; $608c
	farcall FarPtr_ScriptWaitActorMoveDone ; $608f
	script_face $00, $40 ; $6092
	ld a, [$c2b1] ; $6099
	ld bc, $1f00 ; $609c
	ld de, $1f00 ; $609f
	farcall FarPtr_ScriptSetActorMoveTarget ; $60a2
	ld a, [$c2b1] ; $60a5
	farcall FarPtr_ScriptWaitActorMoveDone ; $60a8
	set_flag $17, 2 ; $60ab
	ret ; $60ae
Label_15_60af:
	ld a, [$c2b1] ; $60af
	ld bc, $0030 ; $60b2
	farcall FarPtr_ScriptSetActorMoveSpeed ; $60b5
	ld a, [$c2b1] ; $60b8
	farcall FarPtr_GetActorStateAddr ; $60bb
	ld a, $04 ; $60be
	ld e, l ; $60c0
	ld d, h ; $60c1
	ld hl, $0018 ; $60c2
	add hl, de ; $60c5
	ld [hl], a ; $60c6
	ld a, [$c2b1] ; $60c7
	ld bc, $2100 ; $60ca
	ld de, $2500 ; $60cd
	farcall FarPtr_ScriptSetActorMoveTarget ; $60d0
	ld a, [$c2b1] ; $60d3
	farcall FarPtr_ScriptWaitActorMoveDone ; $60d6
	script_face $00, $40 ; $60d9
	ld a, [$c2b1] ; $60e0
	ld bc, $1f00 ; $60e3
	ld de, $3500 ; $60e6
	farcall FarPtr_ScriptSetActorMoveTarget ; $60e9
	ld a, [$c2b1] ; $60ec
	farcall FarPtr_ScriptWaitActorMoveDone ; $60ef
	set_flag $17, 3 ; $60f2
	ret ; $60f5
Label_15_60f6:
	ld a, [$c2b1] ; $60f6
	ld b, $c0 ; $60f9
	farcall FarPtr_SetActorFacing ; $60fb
	ld a, [$c2b1] ; $60fe
	ld d, $02 ; $6101
	farcall FarPtr_ScriptSetActorAnimation ; $6103
	ld a, [$c2b1] ; $6106
	farcall FarPtr_ScriptWaitActorIdle ; $6109
	ld a, [$c2b1] ; $610c
	ld d, $02 ; $610f
	farcall FarPtr_ScriptSetActorAnimation ; $6111
	ld a, [$c2b1] ; $6114
	farcall FarPtr_ScriptWaitActorIdle ; $6117
	ld a, [$c2b1] ; $611a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $611d
	ld a, [$c2b1] ; $6120
	ld bc, $0030 ; $6123
	farcall FarPtr_ScriptSetActorMoveSpeed ; $6126
	ld a, [$c2b1] ; $6129
	farcall FarPtr_GetActorStateAddr ; $612c
	ld a, $04 ; $612f
	ld e, l ; $6131
	ld d, h ; $6132
	ld hl, $0018 ; $6133
	add hl, de ; $6136
	ld [hl], a ; $6137
	ld a, [$c2b1] ; $6138
	ld bc, $1f00 ; $613b
	ld de, $2500 ; $613e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6141
	ld a, [$c2b1] ; $6144
	farcall FarPtr_ScriptWaitActorMoveDone ; $6147
	ld a, [$c2b1] ; $614a
	ld bc, $1f00 ; $614d
	ld de, $2900 ; $6150
	farcall FarPtr_ScriptSetActorMoveTarget ; $6153
	ld a, [$c2b1] ; $6156
	farcall FarPtr_ScriptWaitActorMoveDone ; $6159
	script_face $00, $40 ; $615c
	ld a, [$c2b1] ; $6163
	ld bc, $1f00 ; $6166
	ld de, $3500 ; $6169
	farcall FarPtr_ScriptSetActorMoveTarget ; $616c
	ld a, [$c2b1] ; $616f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6172
	set_flag $17, 4 ; $6175
	ret ; $6178
WalkChallengerOntoCourt:
	ld a, [$c8f7] ; $6179
	sub a, $0a ; $617c
	jr nc, Label_15_618b ; $617e
	ld a, [$c8f7] ; $6180
	sub a, $04 ; $6183
	jr c, Label_15_61d5 ; $6185
	jp Label_15_6214 ; $6187
	ret ; $618a
Label_15_618b:
	ld a, [$c2b1] ; $618b
	ld bc, $1300 ; $618e
	ld de, $2500 ; $6191
	farcall FarPtr_ScriptSetActorMoveTarget ; $6194
	ld a, [$c2b1] ; $6197
	farcall FarPtr_ScriptWaitActorMoveDone ; $619a
	ld a, [$c2b1] ; $619d
	ld bc, $1300 ; $61a0
	ld de, $2700 ; $61a3
	farcall FarPtr_ScriptSetActorMoveTarget ; $61a6
	script_move_target $00, $1300, $2b00 ; $61a9
	script_wait_move $00 ; $61b4
	ld a, $02 ; $61b9
	farcall FarPtr_GetActorStateAddr ; $61bb
	ld c, l ; $61be
	ld b, h ; $61bf
	ld de, $d000 ; $61c0
	farcall FarPtr_04_20 ; $61c3
	ld a, [$c2b1] ; $61c6
	farcall FarPtr_ScriptWaitActorMoveDone ; $61c9
	ld a, [$c2b1] ; $61cc
	ld b, $40 ; $61cf
	farcall FarPtr_SetActorFacing ; $61d1
	ret ; $61d4
Label_15_61d5:
	ld a, [$c2b1] ; $61d5
	ld bc, $1300 ; $61d8
	ld de, $0b00 ; $61db
	farcall FarPtr_ScriptSetActorMoveTarget ; $61de
	script_wait_frames $1e ; $61e1
	script_move_target $00, $1300, $1300 ; $61e8
	script_wait_move $00 ; $61f3
	ld a, $02 ; $61f8
	farcall FarPtr_GetActorStateAddr ; $61fa
	ld c, l ; $61fd
	ld b, h ; $61fe
	ld de, $d000 ; $61ff
	farcall FarPtr_04_20 ; $6202
	ld a, [$c2b1] ; $6205
	farcall FarPtr_ScriptWaitActorMoveDone ; $6208
	ld a, [$c2b1] ; $620b
	ld b, $00 ; $620e
	farcall FarPtr_SetActorFacing ; $6210
	ret ; $6213
Label_15_6214:
	ld a, [$c2b1] ; $6214
	ld bc, $2d00 ; $6217
	ld de, $2100 ; $621a
	farcall FarPtr_ScriptSetActorMoveTarget ; $621d
	script_wait_frames $1e ; $6220
	script_move_target $00, $2d00, $2b00 ; $6227
	script_wait_move $00 ; $6232
	ld a, $02 ; $6237
	farcall FarPtr_GetActorStateAddr ; $6239
	ld c, l ; $623c
	ld b, h ; $623d
	ld de, $d000 ; $623e
	farcall FarPtr_04_20 ; $6241
	ld a, [$c2b1] ; $6244
	farcall FarPtr_ScriptWaitActorMoveDone ; $6247
	ld a, [$c2b1] ; $624a
	ld b, $00 ; $624d
	farcall FarPtr_SetActorFacing ; $624f
	ret ; $6252
MovePlayerToLessonCourtSpot:
	ld a, [$c8f7] ; $6253
	sub a, $0a ; $6256
	jr nc, Label_15_6265 ; $6258
	ld a, [$c8f7] ; $625a
	sub a, $04 ; $625d
	jr c, Label_15_6283 ; $625f
	jp Label_15_62a1 ; $6261
	ret ; $6264
Label_15_6265:
	script_move_target $00, $1300, $2b00 ; $6265
	script_wait_move $00 ; $6270
	ld a, $02 ; $6275
	farcall FarPtr_GetActorStateAddr ; $6277
	ld c, l ; $627a
	ld b, h ; $627b
	ld de, $d000 ; $627c
	farcall FarPtr_04_20 ; $627f
	ret ; $6282
Label_15_6283:
	script_move_target $00, $1300, $1300 ; $6283
	script_wait_move $00 ; $628e
	ld a, $02 ; $6293
	farcall FarPtr_GetActorStateAddr ; $6295
	ld c, l ; $6298
	ld b, h ; $6299
	ld de, $d000 ; $629a
	farcall FarPtr_04_20 ; $629d
	ret ; $62a0
Label_15_62a1:
	script_move_target $00, $2d00, $2b00 ; $62a1
	script_wait_move $00 ; $62ac
	ld a, $02 ; $62b1
	farcall FarPtr_GetActorStateAddr ; $62b3
	ld c, l ; $62b6
	ld b, h ; $62b7
	ld de, $d000 ; $62b8
	farcall FarPtr_04_20 ; $62bb
	ret ; $62be
Label_15_62bf:
	ld hl, wWaterSpriteMinigameFlag ; $62bf
	ld de, $204d ; $62c2
	ld a, e ; $62c5
	ld [hl+], a ; $62c6
	ld [hl], d ; $62c7
	ld hl, wWaterSpriteMinigameTimer ; $62c8
	ld de, $204a ; $62cb
	ld a, e ; $62ce
	ld [hl+], a ; $62cf
	ld [hl], d ; $62d0
	test_flag $0a, 3 ; $62d1
	jr z, Label_15_62ea ; $62d4
	ld hl, wWaterSpriteMinigameSwingCount ; $62d6
	ld de, $2050 ; $62d9
	ld a, e ; $62dc
	ld [hl+], a ; $62dd
	ld [hl], d ; $62de
	ld hl, $c2b8 ; $62df
	ld de, $2053 ; $62e2
	ld a, e ; $62e5
	ld [hl+], a ; $62e6
	ld [hl], d ; $62e7
	jr Label_15_62fc ; $62e8
Label_15_62ea:
	ld hl, wWaterSpriteMinigameSwingCount ; $62ea
	ld de, $204f ; $62ed
	ld a, e ; $62f0
	ld [hl+], a ; $62f1
	ld [hl], d ; $62f2
	ld hl, $c2b8 ; $62f3
	ld de, $2051 ; $62f6
	ld a, e ; $62f9
	ld [hl+], a ; $62fa
	ld [hl], d ; $62fb
Label_15_62fc:
	call NetChallengerResultScene ; $62fc
	ret ; $62ff
Label_15_6300:
	ld hl, wWaterSpriteMinigameFlag ; $6300
	ld de, $204d ; $6303
	ld a, e ; $6306
	ld [hl+], a ; $6307
	ld [hl], d ; $6308
	ld hl, wWaterSpriteMinigameTimer ; $6309
	ld de, $204a ; $630c
	ld a, e ; $630f
	ld [hl+], a ; $6310
	ld [hl], d ; $6311
	ld hl, wWaterSpriteMinigameSwingCount ; $6312
	ld de, $205f ; $6315
	ld a, e ; $6318
	ld [hl+], a ; $6319
	ld [hl], d ; $631a
	ld hl, $c2b8 ; $631b
	ld de, $2060 ; $631e
	ld a, e ; $6321
	ld [hl+], a ; $6322
	ld [hl], d ; $6323
	call NetChallengerResultScene ; $6324
	ret ; $6327
Label_15_6328:
	ld hl, wWaterSpriteMinigameFlag ; $6328
	ld de, $204d ; $632b
	ld a, e ; $632e
	ld [hl+], a ; $632f
	ld [hl], d ; $6330
	ld hl, wWaterSpriteMinigameTimer ; $6331
	ld de, $204a ; $6334
	ld a, e ; $6337
	ld [hl+], a ; $6338
	ld [hl], d ; $6339
	ld hl, wWaterSpriteMinigameSwingCount ; $633a
	ld de, $206c ; $633d
	ld a, e ; $6340
	ld [hl+], a ; $6341
	ld [hl], d ; $6342
	ld hl, $c2b8 ; $6343
	ld de, $206d ; $6346
	ld a, e ; $6349
	ld [hl+], a ; $634a
	ld [hl], d ; $634b
	call NetChallengerResultScene ; $634c
	ret ; $634f
Label_15_6350:
	ld hl, wWaterSpriteMinigameFlag ; $6350
	ld de, $207b ; $6353
	ld a, e ; $6356
	ld [hl+], a ; $6357
	ld [hl], d ; $6358
	ld hl, wWaterSpriteMinigameTimer ; $6359
	ld de, $2078 ; $635c
	ld a, e ; $635f
	ld [hl+], a ; $6360
	ld [hl], d ; $6361
	test_flag $0a, 3 ; $6362
	jr z, Label_15_637b ; $6365
	ld hl, wWaterSpriteMinigameSwingCount ; $6367
	ld de, $207e ; $636a
	ld a, e ; $636d
	ld [hl+], a ; $636e
	ld [hl], d ; $636f
	ld hl, $c2b8 ; $6370
	ld de, $2082 ; $6373
	ld a, e ; $6376
	ld [hl+], a ; $6377
	ld [hl], d ; $6378
	jr Label_15_638d ; $6379
Label_15_637b:
	ld hl, wWaterSpriteMinigameSwingCount ; $637b
	ld de, $207d ; $637e
	ld a, e ; $6381
	ld [hl+], a ; $6382
	ld [hl], d ; $6383
	ld hl, $c2b8 ; $6384
	ld de, $207f ; $6387
	ld a, e ; $638a
	ld [hl+], a ; $638b
	ld [hl], d ; $638c
Label_15_638d:
	call StrokeChallengerResultScene ; $638d
	ret ; $6390
Label_15_6391:
	ld hl, wWaterSpriteMinigameFlag ; $6391
	ld de, $207b ; $6394
	ld a, e ; $6397
	ld [hl+], a ; $6398
	ld [hl], d ; $6399
	ld hl, wWaterSpriteMinigameTimer ; $639a
	ld de, $2078 ; $639d
	ld a, e ; $63a0
	ld [hl+], a ; $63a1
	ld [hl], d ; $63a2
	ld hl, wWaterSpriteMinigameSwingCount ; $63a3
	ld de, $2091 ; $63a6
	ld a, e ; $63a9
	ld [hl+], a ; $63aa
	ld [hl], d ; $63ab
	ld hl, $c2b8 ; $63ac
	ld de, $2092 ; $63af
	ld a, e ; $63b2
	ld [hl+], a ; $63b3
	ld [hl], d ; $63b4
	call StrokeChallengerResultScene ; $63b5
	ret ; $63b8
Label_15_63b9:
	ld hl, wWaterSpriteMinigameFlag ; $63b9
	ld de, $207b ; $63bc
	ld a, e ; $63bf
	ld [hl+], a ; $63c0
	ld [hl], d ; $63c1
	ld hl, wWaterSpriteMinigameTimer ; $63c2
	ld de, $2078 ; $63c5
	ld a, e ; $63c8
	ld [hl+], a ; $63c9
	ld [hl], d ; $63ca
	ld hl, wWaterSpriteMinigameSwingCount ; $63cb
	ld de, $20a3 ; $63ce
	ld a, e ; $63d1
	ld [hl+], a ; $63d2
	ld [hl], d ; $63d3
	ld hl, $c2b8 ; $63d4
	ld de, $20a4 ; $63d7
	ld a, e ; $63da
	ld [hl+], a ; $63db
	ld [hl], d ; $63dc
	call StrokeChallengerResultScene ; $63dd
	ret ; $63e0
Func_15_63e1:
	script_face_toward $06, $02 ; $63e1
	script_set_text $2014 ; $63e9
	ld a, $06 ; $63ef
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $63f1
	farcall FarPtr_RunDialogueYesNoPrompt ; $63f4
	farcall FarPtr_ScriptCloseDialogueWindow ; $63f7
	script_wait_frames $05 ; $63fa
	and a, a ; $6401
	jp nz, Label_15_64a2 ; $6402
	farcall FarPtr_AdvanceDialogueTextCursor ; $6405
	ld a, $06 ; $6408
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $640a
	farcall FarPtr_RunDialogueYesNoPrompt ; $640d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6410
	script_wait_frames $05 ; $6413
	and a, a ; $641a
	jp nz, Label_15_64a2 ; $641b
	farcall FarPtr_AdvanceDialogueTextCursor ; $641e
	script_speak $06 ; $6421
	script_set_anim $06, $03 ; $6426
	script_wait_idle $06 ; $642d
	script_face $06, $00 ; $6432
	script_wait_frames $28 ; $6439
	script_face_toward $00, $06 ; $6440
	script_speak $06 ; $6448
	script_set_anim $06, $03 ; $644d
	script_wait_idle $06 ; $6454
	script_speak $06 ; $6459
	script_wait_frames $28 ; $645e
	script_set_anim $06, $02 ; $6465
	script_wait_idle $06 ; $646c
	script_speak $06 ; $6471
	script_set_anim $06, $03 ; $6476
	script_wait_idle $06 ; $647d
	script_speak $06 ; $6482
	call WalkToServeChallengeCourtCutscene ; $6487
	ld a, $0f ; $648a
	ld [wStoryModeCurrentLocation], a ; $648c
	ld a, $0a ; $648f
	ld [wStoryModeEntryPoint], a ; $6491
	ld a, $ff ; $6494
	ld [$c294], a ; $6496
	ld [wStoryModeExitLocationRequest], a ; $6499
	ld a, $00 ; $649c
	farcall FarPtr_RunTrainingDrillByID ; $649e
	ret ; $64a1
Label_15_64a2:
	script_speak $06 ; $64a2
	ret ; $64a7
Func_15_64a8:
	script_face_toward $06, $02 ; $64a8
	script_set_text $2026 ; $64b0
	ld a, $06 ; $64b6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $64b8
	farcall FarPtr_RunDialogueYesNoPrompt ; $64bb
	farcall FarPtr_ScriptCloseDialogueWindow ; $64be
	script_wait_frames $05 ; $64c1
	and a, a ; $64c8
	jp nz, Label_15_64a2 ; $64c9
	farcall FarPtr_AdvanceDialogueTextCursor ; $64cc
	ld a, $06 ; $64cf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $64d1
	farcall FarPtr_RunDialogueYesNoPrompt ; $64d4
	farcall FarPtr_ScriptCloseDialogueWindow ; $64d7
	script_wait_frames $05 ; $64da
	and a, a ; $64e1
	jp nz, Label_15_64a2 ; $64e2
	farcall FarPtr_AdvanceDialogueTextCursor ; $64e5
	script_speak $06 ; $64e8
	script_set_anim $06, $03 ; $64ed
	script_wait_idle $06 ; $64f4
	script_face $06, $00 ; $64f9
	script_wait_frames $28 ; $6500
	script_face_toward $00, $06 ; $6507
	script_speak $06 ; $650f
	script_set_anim $06, $04 ; $6514
	script_wait_idle $06 ; $651b
	script_speak $06 ; $6520
	script_wait_frames $14 ; $6525
	script_speak $06 ; $652c
	script_set_anim $06, $03 ; $6531
	script_wait_idle $06 ; $6538
	script_speak $06 ; $653d
	script_wait_frames $14 ; $6542
	script_set_anim $06, $02 ; $6549
	script_wait_idle $06 ; $6550
	script_speak $06 ; $6555
	script_set_anim $06, $03 ; $655a
	script_wait_idle $06 ; $6561
	script_speak $06 ; $6566
	call WalkToServeChallengeCourtCutscene ; $656b
	ld a, $0f ; $656e
	ld [wStoryModeCurrentLocation], a ; $6570
	ld a, $0a ; $6573
	ld [wStoryModeEntryPoint], a ; $6575
	ld a, $ff ; $6578
	ld [$c294], a ; $657a
	ld [wStoryModeExitLocationRequest], a ; $657d
	ld a, $01 ; $6580
	farcall FarPtr_RunTrainingDrillByID ; $6582
	ret ; $6585
Func_15_6586:
	script_face_toward $06, $02 ; $6586
	script_set_text $2034 ; $658e
	ld a, $06 ; $6594
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6596
	farcall FarPtr_RunDialogueYesNoPrompt ; $6599
	farcall FarPtr_ScriptCloseDialogueWindow ; $659c
	script_wait_frames $05 ; $659f
	and a, a ; $65a6
	jp nz, Label_15_64a2 ; $65a7
	farcall FarPtr_AdvanceDialogueTextCursor ; $65aa
	ld a, $06 ; $65ad
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $65af
	farcall FarPtr_RunDialogueYesNoPrompt ; $65b2
	farcall FarPtr_ScriptCloseDialogueWindow ; $65b5
	script_wait_frames $05 ; $65b8
	and a, a ; $65bf
	jp nz, Label_15_64a2 ; $65c0
	farcall FarPtr_AdvanceDialogueTextCursor ; $65c3
	script_speak $06 ; $65c6
	script_set_anim $06, $03 ; $65cb
	script_wait_idle $06 ; $65d2
	script_face $06, $00 ; $65d7
	script_wait_frames $28 ; $65de
	script_face_toward $00, $06 ; $65e5
	script_speak $06 ; $65ed
	script_set_anim $06, $03 ; $65f2
	script_wait_idle $06 ; $65f9
	script_speak $06 ; $65fe
	script_wait_frames $28 ; $6603
	script_set_anim $06, $02 ; $660a
	script_wait_idle $06 ; $6611
	script_speak $06 ; $6616
	script_set_anim $06, $03 ; $661b
	script_wait_idle $06 ; $6622
	script_speak $06 ; $6627
	call WalkToServeChallengeCourtCutscene ; $662c
	ld a, $0f ; $662f
	ld [wStoryModeCurrentLocation], a ; $6631
	ld a, $0a ; $6634
	ld [wStoryModeEntryPoint], a ; $6636
	ld a, $ff ; $6639
	ld [$c294], a ; $663b
	ld [wStoryModeExitLocationRequest], a ; $663e
	ld a, $02 ; $6641
	farcall FarPtr_RunTrainingDrillByID ; $6643
	ret ; $6646
PlayerPartnerGestureCutscene:
	test_flag $05, 7 ; $6647
	jr z, Label_15_667b ; $664a
	script_face_toward $02, $00 ; $664c
	script_set_anim $00, $03 ; $6654
	script_wait_idle $00 ; $665b
	script_set_anim $02, $03 ; $6660
	script_wait_idle $02 ; $6667
	script_face $00, $c0 ; $666c
	script_wait_frames $0a ; $6673
	ret ; $667a
Label_15_667b:
	script_set_anim $00, $03 ; $667b
	script_wait_idle $00 ; $6682
	script_wait_frames $0a ; $6687
	ret ; $668e
WalkToServeChallengeCourtCutscene:
	script_null_script $02 ; $668f
	script_move_player $1800, $0f00 ; $6694
	script_set_actor_script $00, ActorScript_15_66d3 ; $669e
	script_set_actor_script $06, ActorScript_15_66c8 ; $66a9
	script_set_actor_script $02, ActorScript_15_66e4 ; $66b4
	ld a, $00 ; $66bf
	farcall FarPtr_WaitActorScriptDone ; $66c1
	call PlayerPartnerGestureCutscene ; $66c4
	ret ; $66c7
ActorScript_15_66c8:
	; $66c8, 11 bytes (actor_script)
	as_set_pos $1700, $0700
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_66d3:
	; $66d3, 17 bytes (actor_script)
	as_set_pos $1300, $1300
	as_wait_move
	as_set_pos $1900, $1700
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_66e4:
	; $66e4, 11 bytes (actor_script)
	as_set_pos $1300, $1100
	as_wait_move
	as_set_field $14, $0000
	as_halt
Label_15_66ef:
	script_speak $07 ; $66ef
	ret ; $66f4
Func_15_66f5:
	script_face_toward $07, $02 ; $66f5
	test_flag $0a, 3 ; $66fd
	jr nz, Label_15_670a ; $6700
	script_set_text $1c10 ; $6702
	jr Label_15_6710 ; $6708
Label_15_670a:
	script_set_text $1c16 ; $670a
Label_15_6710:
	ld a, $07 ; $6710
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6712
	farcall FarPtr_RunDialogueYesNoPrompt ; $6715
	farcall FarPtr_ScriptCloseDialogueWindow ; $6718
	script_wait_frames $05 ; $671b
	and a, a ; $6722
	jr nz, Label_15_66ef ; $6723
	farcall FarPtr_AdvanceDialogueTextCursor ; $6725
	ld a, $07 ; $6728
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $672a
	farcall FarPtr_RunDialogueYesNoPrompt ; $672d
	farcall FarPtr_ScriptCloseDialogueWindow ; $6730
	script_wait_frames $05 ; $6733
	and a, a ; $673a
	jr nz, Label_15_66ef ; $673b
	farcall FarPtr_AdvanceDialogueTextCursor ; $673d
	script_speak $07 ; $6740
	call Func_15_7c62 ; $6745
	script_face $07, $00 ; $6748
	script_wait_frames $14 ; $674f
	script_speak $07 ; $6756
	ld a, $03 ; $675b
	ld [$c8f7], a ; $675d
	ld a, $0f ; $6760
	ld [wStoryModeCurrentLocation], a ; $6762
	ld a, $09 ; $6765
	ld [wStoryModeEntryPoint], a ; $6767
	ld a, $ff ; $676a
	ld [$c294], a ; $676c
	ld [wStoryModeExitLocationRequest], a ; $676f
	ld c, $10 ; $6772
	call BeginFadeOut ; $6774
	call WaitFadeEnd ; $6777
	farcall FarPtr_ShowDrillBriefingScreen ; $677a
	ret ; $677d
Func_15_677e:
	script_face_toward $07, $02 ; $677e
	script_set_text $1c24 ; $6786
	ld a, $07 ; $678c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $678e
	farcall FarPtr_RunDialogueYesNoPrompt ; $6791
	farcall FarPtr_ScriptCloseDialogueWindow ; $6794
	script_wait_frames $05 ; $6797
	and a, a ; $679e
	jp nz, Label_15_66ef ; $679f
	farcall FarPtr_AdvanceDialogueTextCursor ; $67a2
	ld a, $07 ; $67a5
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $67a7
	farcall FarPtr_RunDialogueYesNoPrompt ; $67aa
	farcall FarPtr_ScriptCloseDialogueWindow ; $67ad
	script_wait_frames $05 ; $67b0
	and a, a ; $67b7
	jp nz, Label_15_66ef ; $67b8
	farcall FarPtr_AdvanceDialogueTextCursor ; $67bb
	script_speak $07 ; $67be
	call Func_15_7c62 ; $67c3
	script_face $07, $00 ; $67c6
	script_wait_frames $14 ; $67cd
	script_speak $07 ; $67d4
	ld a, $04 ; $67d9
	ld [$c8f7], a ; $67db
	ld a, $0f ; $67de
	ld [wStoryModeCurrentLocation], a ; $67e0
	ld a, $09 ; $67e3
	ld [wStoryModeEntryPoint], a ; $67e5
	ld a, $ff ; $67e8
	ld [$c294], a ; $67ea
	ld [wStoryModeExitLocationRequest], a ; $67ed
	ld c, $10 ; $67f0
	call BeginFadeOut ; $67f2
	call WaitFadeEnd ; $67f5
	farcall FarPtr_ShowDrillBriefingScreen ; $67f8
	ret ; $67fb
Func_15_67fc:
	script_face_toward $07, $02 ; $67fc
	script_set_text $1c33 ; $6804
	ld a, $07 ; $680a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $680c
	farcall FarPtr_RunDialogueYesNoPrompt ; $680f
	farcall FarPtr_ScriptCloseDialogueWindow ; $6812
	script_wait_frames $05 ; $6815
	and a, a ; $681c
	jp nz, Label_15_66ef ; $681d
	farcall FarPtr_AdvanceDialogueTextCursor ; $6820
	ld a, $07 ; $6823
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6825
	farcall FarPtr_RunDialogueYesNoPrompt ; $6828
	farcall FarPtr_ScriptCloseDialogueWindow ; $682b
	script_wait_frames $05 ; $682e
	and a, a ; $6835
	jp nz, Label_15_66ef ; $6836
	farcall FarPtr_AdvanceDialogueTextCursor ; $6839
	script_speak $07 ; $683c
	call Func_15_7c62 ; $6841
	script_face $07, $00 ; $6844
	script_wait_frames $14 ; $684b
	script_speak $07 ; $6852
	ld a, $05 ; $6857
	ld [$c8f7], a ; $6859
	ld a, $0f ; $685c
	ld [wStoryModeCurrentLocation], a ; $685e
	ld a, $09 ; $6861
	ld [wStoryModeEntryPoint], a ; $6863
	ld a, $ff ; $6866
	ld [$c294], a ; $6868
	ld [wStoryModeExitLocationRequest], a ; $686b
	ld c, $10 ; $686e
	call BeginFadeOut ; $6870
	call WaitFadeEnd ; $6873
	farcall FarPtr_ShowDrillBriefingScreen ; $6876
	ret ; $6879
	INCBIN "data/bank_015/d_687a.bin" ; $687a, 21 bytes
Func_15_688f:
	script_face_toward $11, $02 ; $688f
	script_set_text $2040 ; $6897
	ld a, $11 ; $689d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $689f
	farcall FarPtr_RunDialogueYesNoPrompt ; $68a2
	farcall FarPtr_ScriptCloseDialogueWindow ; $68a5
	script_wait_frames $05 ; $68a8
	and a, a ; $68af
	jp nz, Label_15_695d ; $68b0
	farcall FarPtr_AdvanceDialogueTextCursor ; $68b3
	ld a, $11 ; $68b6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $68b8
	farcall FarPtr_RunDialogueYesNoPrompt ; $68bb
	farcall FarPtr_ScriptCloseDialogueWindow ; $68be
	script_wait_frames $05 ; $68c1
	and a, a ; $68c8
	jp nz, Label_15_695d ; $68c9
	farcall FarPtr_AdvanceDialogueTextCursor ; $68cc
	ld a, $11 ; $68cf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $68d1
	farcall FarPtr_RunDialogueYesNoPrompt ; $68d4
	farcall FarPtr_ScriptCloseDialogueWindow ; $68d7
	script_wait_frames $05 ; $68da
	and a, a ; $68e1
	jp z, Label_15_6900 ; $68e2
Label_15_68e5:
	script_set_text $2045 ; $68e5
	ld a, $11 ; $68eb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $68ed
	farcall FarPtr_RunDialogueYesNoPrompt ; $68f0
	farcall FarPtr_ScriptCloseDialogueWindow ; $68f3
	script_wait_frames $05 ; $68f6
	and a, a ; $68fd
	jr nz, Label_15_68e5 ; $68fe
Label_15_6900:
	script_set_text $2046 ; $6900
	script_set_anim $11, $03 ; $6906
	script_wait_idle $11 ; $690d
	script_face $11, $80 ; $6912
	script_wait_frames $28 ; $6919
	script_face_toward $00, $11 ; $6920
	script_speak $11 ; $6928
	script_set_anim $11, $03 ; $692d
	script_wait_idle $11 ; $6934
	script_speak $11 ; $6939
	script_speak $11 ; $693e
	script_set_anim $11, $03 ; $6943
	script_wait_idle $11 ; $694a
	script_speak $11 ; $694f
	call Func_15_6af7 ; $6954
	ld a, $06 ; $6957
	farcall FarPtr_RunTrainingDrillByID ; $6959
	ret ; $695c
Label_15_695d:
	script_speak $11 ; $695d
	ret ; $6962
Func_15_6963:
	script_face_toward $11, $02 ; $6963
	script_set_text $2055 ; $696b
	ld a, $11 ; $6971
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6973
	farcall FarPtr_RunDialogueYesNoPrompt ; $6976
	farcall FarPtr_ScriptCloseDialogueWindow ; $6979
	script_wait_frames $05 ; $697c
	and a, a ; $6983
	jp nz, Label_15_6a27 ; $6984
	farcall FarPtr_AdvanceDialogueTextCursor ; $6987
	script_speak $11 ; $698a
	script_set_anim $11, $03 ; $698f
	script_wait_idle $11 ; $6996
	script_face $11, $80 ; $699b
	script_wait_frames $28 ; $69a2
	script_face_toward $00, $11 ; $69a9
	script_speak $11 ; $69b1
	script_set_anim $11, $03 ; $69b6
	script_wait_idle $11 ; $69bd
	script_speak $11 ; $69c2
	script_set_anim $11, $04 ; $69c7
	script_wait_idle $11 ; $69ce
	script_speak $11 ; $69d3
	script_set_anim $11, $02 ; $69d8
	script_wait_idle $11 ; $69df
	script_speak $11 ; $69e4
	script_set_anim $11, $03 ; $69e9
	script_wait_idle $11 ; $69f0
	ld a, $11 ; $69f5
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $69f7
	farcall FarPtr_RunDialogueYesNoPrompt ; $69fa
	farcall FarPtr_ScriptCloseDialogueWindow ; $69fd
	script_wait_frames $05 ; $6a00
	and a, a ; $6a07
	jr nz, Label_15_6a27 ; $6a08
	script_set_anim $11, $03 ; $6a0a
	script_wait_idle $11 ; $6a11
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a16
	script_speak $11 ; $6a19
	call Func_15_6af7 ; $6a1e
	ld a, $07 ; $6a21
	farcall FarPtr_RunTrainingDrillByID ; $6a23
	ret ; $6a26
Label_15_6a27:
	script_speak $11 ; $6a27
	ret ; $6a2c
Func_15_6a2d:
	script_face_toward $11, $02 ; $6a2d
	script_set_text $2062 ; $6a35
	ld a, $11 ; $6a3b
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6a3d
	farcall FarPtr_RunDialogueYesNoPrompt ; $6a40
	farcall FarPtr_ScriptCloseDialogueWindow ; $6a43
	script_wait_frames $05 ; $6a46
	and a, a ; $6a4d
	jp nz, Label_15_6af1 ; $6a4e
	farcall FarPtr_AdvanceDialogueTextCursor ; $6a51
	script_speak $11 ; $6a54
	script_set_anim $11, $03 ; $6a59
	script_wait_idle $11 ; $6a60
	script_face $11, $80 ; $6a65
	script_wait_frames $28 ; $6a6c
	script_face_toward $00, $11 ; $6a73
	script_speak $11 ; $6a7b
	script_set_anim $11, $03 ; $6a80
	script_wait_idle $11 ; $6a87
	script_speak $11 ; $6a8c
	script_set_anim $11, $04 ; $6a91
	script_wait_idle $11 ; $6a98
	script_speak $11 ; $6a9d
	script_set_anim $11, $02 ; $6aa2
	script_wait_idle $11 ; $6aa9
	script_speak $11 ; $6aae
	script_set_anim $11, $03 ; $6ab3
	script_wait_idle $11 ; $6aba
	ld a, $11 ; $6abf
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ac1
	farcall FarPtr_RunDialogueYesNoPrompt ; $6ac4
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ac7
	script_wait_frames $05 ; $6aca
	and a, a ; $6ad1
	jr nz, Label_15_6af1 ; $6ad2
	farcall FarPtr_AdvanceDialogueTextCursor ; $6ad4
	script_set_anim $11, $03 ; $6ad7
	script_wait_idle $11 ; $6ade
	script_speak $11 ; $6ae3
	call Func_15_6af7 ; $6ae8
	ld a, $08 ; $6aeb
	farcall FarPtr_RunTrainingDrillByID ; $6aed
	ret ; $6af0
Label_15_6af1:
	script_speak $11 ; $6af1
	ret ; $6af6
Func_15_6af7:
	script_null_script $02 ; $6af7
	script_move_player $2800, $2700 ; $6afc
	script_set_actor_script $11, ActorScript_15_6b49 ; $6b06
	script_set_actor_script $00, ActorScript_15_6b54 ; $6b11
	script_wait_frames $0a ; $6b1c
	script_set_actor_script $02, ActorScript_15_6b71 ; $6b23
	ld a, $00 ; $6b2e
	farcall FarPtr_WaitActorScriptDone ; $6b30
	call PlayerPartnerGestureCutscene ; $6b33
	ld a, $0f ; $6b36
	ld [wStoryModeCurrentLocation], a ; $6b38
	ld a, $0a ; $6b3b
	ld [wStoryModeEntryPoint], a ; $6b3d
	ld a, $ff ; $6b40
	ld [$c294], a ; $6b42
	ld [wStoryModeExitLocationRequest], a ; $6b45
	ret ; $6b48
ActorScript_15_6b49:
	; $6b49, 11 bytes (actor_script)
	as_set_pos $2700, $1f00
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_6b54:
	; $6b54, 29 bytes (actor_script)
	as_set_pos $2d00, $2300
	as_wait_move
	as_set_pos $2f00, $2300
	as_wait_move
	as_set_pos $2f00, $2b00
	as_wait_move
	as_set_pos $2900, $2e00
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_6b71:
	; $6b71, 29 bytes (actor_script)
	as_set_pos $2d00, $2300
	as_wait_move
	as_set_pos $2f00, $2300
	as_wait_move
	as_set_pos $2f00, $2d00
	as_wait_move
	as_set_pos $2d00, $2d00
	as_wait_move
	as_set_field $14, $0080
	as_halt
Label_15_6b8e:
	script_speak $0c ; $6b8e
	ret ; $6b93
StrokeMatchChallengeScene:
	script_face_toward $0c, $02 ; $6b94
	script_set_text $206f ; $6b9c
	ld a, $0c ; $6ba2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ba4
	farcall FarPtr_RunDialogueYesNoPrompt ; $6ba7
	farcall FarPtr_ScriptCloseDialogueWindow ; $6baa
	script_wait_frames $05 ; $6bad
	and a, a ; $6bb4
	jp nz, Label_15_6b8e ; $6bb5
	farcall FarPtr_AdvanceDialogueTextCursor ; $6bb8
	ld a, $0c ; $6bbb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6bbd
	farcall FarPtr_RunDialogueYesNoPrompt ; $6bc0
	farcall FarPtr_ScriptCloseDialogueWindow ; $6bc3
	script_wait_frames $05 ; $6bc6
	and a, a ; $6bcd
	jp nz, Label_15_6b8e ; $6bce
	farcall FarPtr_AdvanceDialogueTextCursor ; $6bd1
	script_face $0c, $00 ; $6bd4
	script_wait_frames $28 ; $6bdb
	script_face_toward $00, $0c ; $6be2
	script_speak $0c ; $6bea
	script_set_anim $0c, $03 ; $6bef
	script_wait_idle $0c ; $6bf6
	script_speak $0c ; $6bfb
	script_set_anim $0c, $02 ; $6c00
	script_wait_idle $0c ; $6c07
	script_speak $0c ; $6c0c
	script_set_anim $0c, $04 ; $6c11
	script_wait_idle $0c ; $6c18
	script_speak $0c ; $6c1d
	script_set_anim $0c, $03 ; $6c22
	script_wait_idle $0c ; $6c29
	script_speak $0c ; $6c2e
	call WalkToStrokeChallengeCourtCutscene ; $6c33
	ld a, $0c ; $6c36
	farcall FarPtr_RunTrainingDrillByID ; $6c38
	ret ; $6c3b
LobMatchChallengeScene:
	script_face_toward $0c, $02 ; $6c3c
	script_set_text $2085 ; $6c44
	ld a, $0c ; $6c4a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c4c
	farcall FarPtr_RunDialogueYesNoPrompt ; $6c4f
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c52
	script_wait_frames $05 ; $6c55
	and a, a ; $6c5c
	jp nz, Label_15_6b8e ; $6c5d
	farcall FarPtr_AdvanceDialogueTextCursor ; $6c60
	ld a, $0c ; $6c63
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6c65
	farcall FarPtr_RunDialogueYesNoPrompt ; $6c68
	farcall FarPtr_ScriptCloseDialogueWindow ; $6c6b
	script_wait_frames $05 ; $6c6e
	and a, a ; $6c75
	jp nz, Label_15_6b8e ; $6c76
	farcall FarPtr_AdvanceDialogueTextCursor ; $6c79
	script_speak $0c ; $6c7c
	script_face $0c, $00 ; $6c81
	script_wait_frames $28 ; $6c88
	script_face_toward $00, $0c ; $6c8f
	script_set_anim $0c, $03 ; $6c97
	script_wait_idle $0c ; $6c9e
	script_speak $0c ; $6ca3
	script_set_anim $0c, $02 ; $6ca8
	script_wait_idle $0c ; $6caf
	script_speak $0c ; $6cb4
	script_set_anim $0c, $04 ; $6cb9
	script_wait_idle $0c ; $6cc0
	script_speak $0c ; $6cc5
	script_set_anim $0c, $03 ; $6cca
	script_wait_idle $0c ; $6cd1
	script_speak $0c ; $6cd6
	call WalkToStrokeChallengeCourtCutscene ; $6cdb
	ld a, $0d ; $6cde
	farcall FarPtr_RunTrainingDrillByID ; $6ce0
	ret ; $6ce3
ReturnMatchChallengeScene:
	script_face_toward $0c, $02 ; $6ce4
	script_set_text $2095 ; $6cec
	ld a, $0c ; $6cf2
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6cf4
	farcall FarPtr_RunDialogueYesNoPrompt ; $6cf7
	farcall FarPtr_ScriptCloseDialogueWindow ; $6cfa
	script_wait_frames $05 ; $6cfd
	and a, a ; $6d04
	jp nz, Label_15_6b8e ; $6d05
	farcall FarPtr_AdvanceDialogueTextCursor ; $6d08
	script_speak $0c ; $6d0b
	ld a, $0c ; $6d10
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d12
	farcall FarPtr_RunDialogueYesNoPrompt ; $6d15
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d18
	script_wait_frames $05 ; $6d1b
	and a, a ; $6d22
	jp nz, Label_15_6b8e ; $6d23
	farcall FarPtr_AdvanceDialogueTextCursor ; $6d26
	script_set_anim $0c, $03 ; $6d29
	script_wait_idle $0c ; $6d30
	script_face $0c, $00 ; $6d35
	script_wait_frames $28 ; $6d3c
	script_face_toward $00, $0c ; $6d43
	script_speak $0c ; $6d4b
	script_set_anim $0c, $03 ; $6d50
	script_wait_idle $0c ; $6d57
	script_speak $0c ; $6d5c
	script_set_anim $0c, $02 ; $6d61
	script_wait_idle $0c ; $6d68
	script_speak $0c ; $6d6d
	script_set_anim $0c, $04 ; $6d72
	script_wait_idle $0c ; $6d79
	script_speak $0c ; $6d7e
	script_set_anim $0c, $02 ; $6d83
	script_wait_idle $0c ; $6d8a
	script_speak $0c ; $6d8f
	script_set_anim $0c, $03 ; $6d94
	script_wait_idle $0c ; $6d9b
	script_speak $0c ; $6da0
	call WalkToStrokeChallengeCourtCutscene ; $6da5
	ld a, $0e ; $6da8
	farcall FarPtr_RunTrainingDrillByID ; $6daa
	ret ; $6dad
Label_15_6dae:
	script_speak $0d ; $6dae
	ret ; $6db3
ReturnCoachReturnLessonScene:
	script_set_text $1cc4 ; $6db4
	test_flag $0a, 3 ; $6dba
	jr z, Label_15_6dc2 ; $6dbd
	farcall FarPtr_AdvanceDialogueTextCursor ; $6dbf
Label_15_6dc2:
	script_face_toward $0d, $02 ; $6dc2
	ld a, $0d ; $6dca
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6dcc
	script_set_text $1cc6 ; $6dcf
	farcall FarPtr_RunDialogueYesNoPrompt ; $6dd5
	farcall FarPtr_ScriptCloseDialogueWindow ; $6dd8
	script_wait_frames $05 ; $6ddb
	and a, a ; $6de2
	jp nz, Label_15_6dae ; $6de3
	farcall FarPtr_AdvanceDialogueTextCursor ; $6de6
	ld a, $0d ; $6de9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6deb
	farcall FarPtr_RunDialogueYesNoPrompt ; $6dee
	farcall FarPtr_ScriptCloseDialogueWindow ; $6df1
	script_wait_frames $05 ; $6df4
	and a, a ; $6dfb
	jp nz, Label_15_6dae ; $6dfc
	farcall FarPtr_AdvanceDialogueTextCursor ; $6dff
	script_speak $0d ; $6e02
	call MovePartyToReturnCoachSpot ; $6e07
	script_face $0d, $00 ; $6e0a
	script_set_text $1cca ; $6e11
	script_speak $0d ; $6e17
	script_set_anim $0d, $02 ; $6e1c
	script_wait_idle $0d ; $6e23
	ld a, $0f ; $6e28
	ld [$c8f7], a ; $6e2a
	ld a, $0f ; $6e2d
	ld [wStoryModeCurrentLocation], a ; $6e2f
	ld a, $09 ; $6e32
	ld [wStoryModeEntryPoint], a ; $6e34
	ld a, $ff ; $6e37
	ld [$c294], a ; $6e39
	ld [wStoryModeExitLocationRequest], a ; $6e3c
	ld c, $10 ; $6e3f
	call BeginFadeOut ; $6e41
	call WaitFadeEnd ; $6e44
	farcall FarPtr_ShowDrillBriefingScreen ; $6e47
	ret ; $6e4a
ReturnCoachLobLessonScene:
	script_face_toward $0d, $02 ; $6e4b
	script_set_text $1ce3 ; $6e53
	ld a, $0d ; $6e59
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e5b
	farcall FarPtr_RunDialogueYesNoPrompt ; $6e5e
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e61
	script_wait_frames $05 ; $6e64
	and a, a ; $6e6b
	jp nz, Label_15_6dae ; $6e6c
	farcall FarPtr_AdvanceDialogueTextCursor ; $6e6f
	ld a, $0d ; $6e72
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e74
	farcall FarPtr_RunDialogueYesNoPrompt ; $6e77
	farcall FarPtr_ScriptCloseDialogueWindow ; $6e7a
	script_wait_frames $05 ; $6e7d
	and a, a ; $6e84
	jp nz, Label_15_6dae ; $6e85
	farcall FarPtr_AdvanceDialogueTextCursor ; $6e88
	script_speak $0d ; $6e8b
	call MovePartyToReturnCoachSpot ; $6e90
	script_face $0d, $00 ; $6e93
	script_speak $0d ; $6e9a
	script_set_anim $0d, $02 ; $6e9f
	script_wait_idle $0d ; $6ea6
	ld a, $10 ; $6eab
	ld [$c8f7], a ; $6ead
	ld a, $0f ; $6eb0
	ld [wStoryModeCurrentLocation], a ; $6eb2
	ld a, $09 ; $6eb5
	ld [wStoryModeEntryPoint], a ; $6eb7
	ld a, $ff ; $6eba
	ld [$c294], a ; $6ebc
	ld [wStoryModeExitLocationRequest], a ; $6ebf
	ld c, $10 ; $6ec2
	call BeginFadeOut ; $6ec4
	call WaitFadeEnd ; $6ec7
	farcall FarPtr_ShowDrillBriefingScreen ; $6eca
	ret ; $6ecd
ReturnCoachPassingShotLessonScene:
	script_face_toward $0d, $02 ; $6ece
	script_set_text $1cf9 ; $6ed6
	ld a, $0d ; $6edc
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ede
	farcall FarPtr_RunDialogueYesNoPrompt ; $6ee1
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ee4
	script_wait_frames $05 ; $6ee7
	and a, a ; $6eee
	jp nz, Label_15_6dae ; $6eef
	farcall FarPtr_AdvanceDialogueTextCursor ; $6ef2
	ld a, $0d ; $6ef5
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6ef7
	farcall FarPtr_RunDialogueYesNoPrompt ; $6efa
	farcall FarPtr_ScriptCloseDialogueWindow ; $6efd
	script_wait_frames $05 ; $6f00
	and a, a ; $6f07
	jp nz, Label_15_6dae ; $6f08
	farcall FarPtr_AdvanceDialogueTextCursor ; $6f0b
	script_speak $0d ; $6f0e
	call MovePartyToReturnCoachSpot ; $6f13
	script_face $0d, $00 ; $6f16
	script_speak $0d ; $6f1d
	script_set_anim $0d, $02 ; $6f22
	script_wait_idle $0d ; $6f29
	ld a, $11 ; $6f2e
	ld [$c8f7], a ; $6f30
	ld a, $0f ; $6f33
	ld [wStoryModeCurrentLocation], a ; $6f35
	ld a, $09 ; $6f38
	ld [wStoryModeEntryPoint], a ; $6f3a
	ld a, $ff ; $6f3d
	ld [$c294], a ; $6f3f
	ld [wStoryModeExitLocationRequest], a ; $6f42
	ld c, $10 ; $6f45
	call BeginFadeOut ; $6f47
	call WaitFadeEnd ; $6f4a
	farcall FarPtr_ShowDrillBriefingScreen ; $6f4d
	ret ; $6f50
WalkToStrokeChallengeCourtCutscene:
	script_null_script $02 ; $6f51
	script_move_player $1800, $2700 ; $6f56
	script_set_actor_script $0c, ActorScript_15_6f9c ; $6f60
	script_set_actor_script $00, ActorScript_15_6fa7 ; $6f6b
	script_set_actor_script $02, ActorScript_15_6fbe ; $6f76
	ld a, $00 ; $6f81
	farcall FarPtr_WaitActorScriptDone ; $6f83
	call PlayerPartnerGestureCutscene ; $6f86
	ld a, $0f ; $6f89
	ld [wStoryModeCurrentLocation], a ; $6f8b
	ld a, $0a ; $6f8e
	ld [wStoryModeEntryPoint], a ; $6f90
	ld a, $ff ; $6f93
	ld [$c294], a ; $6f95
	ld [wStoryModeExitLocationRequest], a ; $6f98
	ret ; $6f9b
ActorScript_15_6f9c:
	; $6f9c, 11 bytes (actor_script)
	as_set_pos $1700, $1f00
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_6fa7:
	; $6fa7, 23 bytes (actor_script)
	as_set_pos $1100, $2700
	as_wait_move
	as_set_pos $1100, $2b00
	as_wait_move
	as_set_pos $1900, $2e00
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_6fbe:
	; $6fbe, 17 bytes (actor_script)
	as_set_pos $1100, $2900
	as_wait_move
	as_set_pos $1300, $2d00
	as_wait_move
	as_set_field $14, $0000
	as_halt
NetCoachVolleyLessonScene:
	script_face_toward $12, $02 ; $6fcf
	test_flag $0a, 3 ; $6fd7
	jr nz, Label_15_6fe4 ; $6fda
	script_set_text $1c5d ; $6fdc
	jr Label_15_6fea ; $6fe2
Label_15_6fe4:
	script_set_text $1c64 ; $6fe4
Label_15_6fea:
	ld a, $12 ; $6fea
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6fec
	farcall FarPtr_RunDialogueYesNoPrompt ; $6fef
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ff2
	script_wait_frames $05 ; $6ff5
	and a, a ; $6ffc
	jr nz, Label_15_7068 ; $6ffd
	farcall FarPtr_AdvanceDialogueTextCursor ; $6fff
	ld a, $12 ; $7002
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7004
	farcall FarPtr_RunDialogueYesNoPrompt ; $7007
	farcall FarPtr_ScriptCloseDialogueWindow ; $700a
	script_wait_frames $05 ; $700d
	and a, a ; $7014
	jr nz, Label_15_7068 ; $7015
	farcall FarPtr_AdvanceDialogueTextCursor ; $7017
	script_speak $12 ; $701a
	call MovePartyToNetCoachSpot ; $701f
	script_face $12, $80 ; $7022
	script_speak $12 ; $7029
	script_set_anim $12, $02 ; $702e
	script_wait_idle $12 ; $7035
	script_set_text $1c63 ; $703a
	script_speak $12 ; $7040
	ld a, $09 ; $7045
	ld [$c8f7], a ; $7047
	ld a, $0f ; $704a
	ld [wStoryModeCurrentLocation], a ; $704c
	ld a, $09 ; $704f
	ld [wStoryModeEntryPoint], a ; $7051
	ld a, $ff ; $7054
	ld [$c294], a ; $7056
	ld [wStoryModeExitLocationRequest], a ; $7059
	ld c, $10 ; $705c
	call BeginFadeOut ; $705e
	call WaitFadeEnd ; $7061
	farcall FarPtr_ShowDrillBriefingScreen ; $7064
	ret ; $7067
Label_15_7068:
	script_speak $12 ; $7068
	ret ; $706d
NetCoachSmashLessonScene:
	script_face_toward $12, $02 ; $706e
	script_set_text $1c86 ; $7076
	ld a, $12 ; $707c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $707e
	farcall FarPtr_RunDialogueYesNoPrompt ; $7081
	farcall FarPtr_ScriptCloseDialogueWindow ; $7084
	script_wait_frames $05 ; $7087
	and a, a ; $708e
	jr nz, Label_15_7068 ; $708f
	farcall FarPtr_AdvanceDialogueTextCursor ; $7091
	ld a, $12 ; $7094
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7096
	farcall FarPtr_RunDialogueYesNoPrompt ; $7099
	farcall FarPtr_ScriptCloseDialogueWindow ; $709c
	script_wait_frames $05 ; $709f
	and a, a ; $70a6
	jr nz, Label_15_7068 ; $70a7
	farcall FarPtr_AdvanceDialogueTextCursor ; $70a9
	ld a, $12 ; $70ac
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $70ae
	farcall FarPtr_RunDialogueYesNoPrompt ; $70b1
	farcall FarPtr_ScriptCloseDialogueWindow ; $70b4
	script_wait_frames $05 ; $70b7
	and a, a ; $70be
	jr nz, Label_15_7068 ; $70bf
	farcall FarPtr_AdvanceDialogueTextCursor ; $70c1
	script_speak $12 ; $70c4
	call MovePartyToNetCoachSpot ; $70c9
	script_face $12, $80 ; $70cc
	script_speak $12 ; $70d3
	script_set_anim $12, $02 ; $70d8
	script_wait_idle $12 ; $70df
	script_speak $12 ; $70e4
	script_set_anim $12, $03 ; $70e9
	script_wait_idle $12 ; $70f0
	script_speak $12 ; $70f5
	ld a, $0a ; $70fa
	ld [$c8f7], a ; $70fc
	ld a, $0f ; $70ff
	ld [wStoryModeCurrentLocation], a ; $7101
	ld a, $09 ; $7104
	ld [wStoryModeEntryPoint], a ; $7106
	ld a, $ff ; $7109
	ld [$c294], a ; $710b
	ld [wStoryModeExitLocationRequest], a ; $710e
	ld c, $10 ; $7111
	call BeginFadeOut ; $7113
	call WaitFadeEnd ; $7116
	farcall FarPtr_ShowDrillBriefingScreen ; $7119
	ret ; $711c
NetCoachDropShotLessonScene:
	script_face_toward $12, $02 ; $711d
	script_set_text $1c9f ; $7125
	ld a, $12 ; $712b
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $712d
	farcall FarPtr_RunDialogueYesNoPrompt ; $7130
	farcall FarPtr_ScriptCloseDialogueWindow ; $7133
	script_wait_frames $05 ; $7136
	and a, a ; $713d
	jp nz, Label_15_7068 ; $713e
	farcall FarPtr_AdvanceDialogueTextCursor ; $7141
	ld a, $12 ; $7144
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7146
	farcall FarPtr_RunDialogueYesNoPrompt ; $7149
	farcall FarPtr_ScriptCloseDialogueWindow ; $714c
	script_wait_frames $05 ; $714f
	and a, a ; $7156
	jp nz, Label_15_7068 ; $7157
	farcall FarPtr_AdvanceDialogueTextCursor ; $715a
	ld a, $12 ; $715d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $715f
	farcall FarPtr_RunDialogueYesNoPrompt ; $7162
	farcall FarPtr_ScriptCloseDialogueWindow ; $7165
	script_wait_frames $05 ; $7168
	and a, a ; $716f
	jp nz, Label_15_7068 ; $7170
	farcall FarPtr_AdvanceDialogueTextCursor ; $7173
	script_speak $12 ; $7176
	call MovePartyToNetCoachSpot ; $717b
	script_face $12, $80 ; $717e
	script_speak $12 ; $7185
	script_set_anim $12, $02 ; $718a
	script_wait_idle $12 ; $7191
	script_speak $12 ; $7196
	ld a, $0b ; $719b
	ld [$c8f7], a ; $719d
	ld a, $0f ; $71a0
	ld [wStoryModeCurrentLocation], a ; $71a2
	ld a, $09 ; $71a5
	ld [wStoryModeEntryPoint], a ; $71a7
	ld a, $ff ; $71aa
	ld [$c294], a ; $71ac
	ld [wStoryModeExitLocationRequest], a ; $71af
	ld c, $10 ; $71b2
	call BeginFadeOut ; $71b4
	call WaitFadeEnd ; $71b7
	farcall FarPtr_ShowDrillBriefingScreen ; $71ba
	ret ; $71bd
HideServeChallengerActor:
	test_flag $17, 2 ; $71be
	jr nz, Label_15_71c8 ; $71c1
	call TestServeChallengerGameFlag ; $71c3
	jr z, Label_15_71d3 ; $71c6
Label_15_71c8:
	script_set_position $06, $3f00, $3f00 ; $71c8
Label_15_71d3:
	ret ; $71d3
TestServeChallengerGameFlag:
	ld a, [$c2b0] ; $71d4
	add a, a ; $71d7
	add a, $f8 ; $71d8
	ld l, a ; $71da
	adc a, $71 ; $71db
	sub a, l ; $71dd
	ld h, a ; $71de
	ld a, [hl+] ; $71df
	ld d, [hl] ; $71e0
	ld e, a ; $71e1
	call TestGameFlagByNumber ; $71e2
	ret ; $71e5
	ld a, [$c2b0] ; $71e6
	add a, a ; $71e9
	add a, $f8 ; $71ea
	ld l, a ; $71ec
	adc a, $71 ; $71ed
	sub a, l ; $71ef
	ld h, a ; $71f0
	ld a, [hl+] ; $71f1
	ld d, [hl] ; $71f2
	ld e, a ; $71f3
	call SetGameFlagByNumber ; $71f4
	ret ; $71f7
	; $71f8, 12 bytes (records:2)
	dw $00c0 ; record 0
	dw $00c1 ; record 1
	dw $00c2 ; record 2
	dw $00c2 ; record 3
	dw $00c2 ; record 4
	dw $00c2 ; record 5
HideNetChallengerActor:
	test_flag $17, 3 ; $7204
	jr nz, Label_15_720e ; $7207
	call TestNetChallengerGameFlag ; $7209
	jr z, Label_15_7219 ; $720c
Label_15_720e:
	script_set_position $11, $3f00, $3f00 ; $720e
Label_15_7219:
	ret ; $7219
TestNetChallengerGameFlag:
	ld a, [$c2b0] ; $721a
	add a, a ; $721d
	add a, $3e ; $721e
	ld l, a ; $7220
	adc a, $72 ; $7221
	sub a, l ; $7223
	ld h, a ; $7224
	ld a, [hl+] ; $7225
	ld d, [hl] ; $7226
	ld e, a ; $7227
	call TestGameFlagByNumber ; $7228
	ret ; $722b
	ld a, [$c2b0] ; $722c
	add a, a ; $722f
	add a, $3e ; $7230
	ld l, a ; $7232
	adc a, $72 ; $7233
	sub a, l ; $7235
	ld h, a ; $7236
	ld a, [hl+] ; $7237
	ld d, [hl] ; $7238
	ld e, a ; $7239
	call SetGameFlagByNumber ; $723a
	ret ; $723d
	; $723e, 12 bytes (records:2)
	dw $00c6 ; record 0
	dw $00c7 ; record 1
	dw $00c8 ; record 2
	dw $00c8 ; record 3
	dw $00c8 ; record 4
	dw $00c8 ; record 5
HideStrokeChallengerActor:
	test_flag $17, 4 ; $724a
	jr nz, Label_15_7254 ; $724d
	call TestStrokeChallengerGameFlag ; $724f
	jr z, Label_15_725f ; $7252
Label_15_7254:
	script_set_position $0c, $3f00, $3f00 ; $7254
Label_15_725f:
	ret ; $725f
TestStrokeChallengerGameFlag:
	ld a, [$c2b0] ; $7260
	add a, a ; $7263
	add a, $84 ; $7264
	ld l, a ; $7266
	adc a, $72 ; $7267
	sub a, l ; $7269
	ld h, a ; $726a
	ld a, [hl+] ; $726b
	ld d, [hl] ; $726c
	ld e, a ; $726d
	call TestGameFlagByNumber ; $726e
	ret ; $7271
	ld a, [$c2b0] ; $7272
	add a, a ; $7275
	add a, $84 ; $7276
	ld l, a ; $7278
	adc a, $72 ; $7279
	sub a, l ; $727b
	ld h, a ; $727c
	ld a, [hl+] ; $727d
	ld d, [hl] ; $727e
	ld e, a ; $727f
	call SetGameFlagByNumber ; $7280
	ret ; $7283
	; $7284, 12 bytes (records:2)
	dw $00cc ; record 0
	dw $00cd ; record 1
	dw $00ce ; record 2
	dw $00ce ; record 3
	dw $00ce ; record 4
	dw $00ce ; record 5
Label_15_7290:
	ld a, [$c2e3] ; $7290
	ld a, a ; $7293
	rst Rst00 ; $7294
	dw Label_15_72c7 ; $7295 jumptable
	dw Label_15_73f0 ; $7297 jumptable
	dw Label_15_73fd ; $7299 jumptable
	dw Label_15_740a ; $729b jumptable
	dw Label_15_73f0 ; $729d jumptable
Label_15_729f:
	ld a, [$c2e3] ; $729f
	ld a, a ; $72a2
	rst Rst00 ; $72a3
	dw Label_15_7336 ; $72a4 jumptable
	dw Label_15_73f0 ; $72a6 jumptable
	dw Label_15_73fd ; $72a8 jumptable
	dw Label_15_7417 ; $72aa jumptable
	dw Label_15_7424 ; $72ac jumptable
	dw Label_15_7431 ; $72ae jumptable
	dw Label_15_743e ; $72b0 jumptable
	dw Label_15_73f0 ; $72b2 jumptable
Label_15_72b4:
	ld a, [$c2e3] ; $72b4
	ld a, a ; $72b7
	rst Rst00 ; $72b8
	dw Label_15_739c ; $72b9 jumptable
	dw Label_15_73f0 ; $72bb jumptable
	dw Label_15_73fd ; $72bd jumptable
	dw Label_15_7417 ; $72bf jumptable
	dw Label_15_744b ; $72c1 jumptable
	dw Label_15_7458 ; $72c3 jumptable
	dw Label_15_73f0 ; $72c5 jumptable
Label_15_72c7:
	call InitServeCoachScene ; $72c7
	script_set_text $1c1c ; $72ca
	script_speak $07 ; $72d0
	test_flag $0a, 3 ; $72d5
	jr z, Label_15_72dd ; $72d8
	farcall FarPtr_AdvanceDialogueTextCursor ; $72da
Label_15_72dd:
	script_face_toward $00, $07 ; $72dd
	script_set_anim $07, $03 ; $72e5
	script_wait_idle $07 ; $72ec
	script_speak $07 ; $72f1
	script_set_anim $07, $02 ; $72f6
	script_wait_idle $07 ; $72fd
	script_set_text $1c1f ; $7302
	script_speak $07 ; $7308
	script_set_anim $07, $04 ; $730d
	script_wait_idle $07 ; $7314
	script_speak $07 ; $7319
	test_flag $0a, 3 ; $731e
	jr z, Label_15_7326 ; $7321
	farcall FarPtr_AdvanceDialogueTextCursor ; $7323
Label_15_7326:
	script_speak $07 ; $7326
	script_face $07, $80 ; $732b
	set_flag $17, 5 ; $7332
	ret ; $7335
Label_15_7336:
	call InitServeCoachScene ; $7336
	script_set_text $1c2a ; $7339
	test_flag $0a, 7 ; $733f
	jr z, Label_15_734a ; $7342
	script_set_text $1c2e ; $7344
Label_15_734a:
	script_speak $07 ; $734a
	script_face_toward $00, $07 ; $734f
	script_set_anim $07, $03 ; $7357
	script_wait_idle $07 ; $735e
	script_speak $07 ; $7363
	script_set_anim $07, $02 ; $7368
	script_wait_idle $07 ; $736f
	script_speak $07 ; $7374
	script_set_anim $07, $04 ; $7379
	script_wait_idle $07 ; $7380
	script_speak $07 ; $7385
	script_face $07, $80 ; $738a
	script_wait_frames $05 ; $7391
	set_flag $17, 5 ; $7398
	ret ; $739b
Label_15_739c:
	call InitServeCoachScene ; $739c
	script_set_text $1c39 ; $739f
	script_speak $07 ; $73a5
	script_face_toward $00, $07 ; $73aa
	script_set_anim $07, $03 ; $73b2
	script_wait_idle $07 ; $73b9
	script_speak $07 ; $73be
	script_set_anim $07, $02 ; $73c3
	script_wait_idle $07 ; $73ca
	script_speak $07 ; $73cf
	script_set_anim $07, $03 ; $73d4
	script_wait_idle $07 ; $73db
	script_speak $07 ; $73e0
	script_face $07, $80 ; $73e5
	set_flag $17, 5 ; $73ec
	ret ; $73ef
Label_15_73f0:
	call InitServeCoachScene ; $73f0
	script_set_text $1c3e ; $73f3
	call ServeCoachChainedRetryPrompt ; $73f9
	ret ; $73fc
Label_15_73fd:
	call InitServeCoachScene ; $73fd
	script_set_text $1c43 ; $7400
	call ServeCoachTwoStageRetryPrompt ; $7406
	ret ; $7409
Label_15_740a:
	call InitServeCoachScene ; $740a
	script_set_text $1c48 ; $740d
	call ServeCoachRetryPrompt ; $7413
	ret ; $7416
Label_15_7417:
	call InitServeCoachScene ; $7417
	script_set_text $1c4b ; $741a
	call ServeCoachRetryPrompt ; $7420
	ret ; $7423
Label_15_7424:
	call InitServeCoachScene ; $7424
	script_set_text $1c4e ; $7427
	call ServeCoachRetryPrompt ; $742d
	ret ; $7430
Label_15_7431:
	call InitServeCoachScene ; $7431
	script_set_text $1c51 ; $7434
	call ServeCoachRetryPrompt ; $743a
	ret ; $743d
Label_15_743e:
	call InitServeCoachScene ; $743e
	script_set_text $1c54 ; $7441
	call ServeCoachRetryPrompt ; $7447
	ret ; $744a
Label_15_744b:
	call InitServeCoachScene ; $744b
	script_set_text $1c57 ; $744e
	call ServeCoachRetryPrompt ; $7454
	ret ; $7457
Label_15_7458:
	call InitServeCoachScene ; $7458
	script_set_text $1c5a ; $745b
	call ServeCoachRetryPrompt ; $7461
	ret ; $7464
ServeCoachChainedRetryPrompt:
	ld a, $07 ; $7465
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7467
	farcall FarPtr_RunDialogueYesNoPrompt ; $746a
	farcall FarPtr_ScriptCloseDialogueWindow ; $746d
	script_wait_frames $05 ; $7470
	and a, a ; $7477
	jp nz, Label_15_752c ; $7478
	farcall FarPtr_AdvanceDialogueTextCursor ; $747b
ServeCoachRetryPrompt:
	ld a, $07 ; $747e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7480
	farcall FarPtr_RunDialogueYesNoPrompt ; $7483
	farcall FarPtr_ScriptCloseDialogueWindow ; $7486
	script_wait_frames $05 ; $7489
	and a, a ; $7490
	jp z, Label_15_74d2 ; $7491
	farcall FarPtr_AdvanceDialogueTextCursor ; $7494
	jp Label_15_752c ; $7497
ServeCoachTwoStageRetryPrompt:
	ld a, $07 ; $749a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $749c
	farcall FarPtr_RunDialogueYesNoPrompt ; $749f
	farcall FarPtr_ScriptCloseDialogueWindow ; $74a2
	script_wait_frames $05 ; $74a5
	and a, a ; $74ac
	jp nz, Label_15_74b3 ; $74ad
	farcall FarPtr_AdvanceDialogueTextCursor ; $74b0
Label_15_74b3:
	ld a, $07 ; $74b3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $74b5
	farcall FarPtr_RunDialogueYesNoPrompt ; $74b8
	farcall FarPtr_ScriptCloseDialogueWindow ; $74bb
	script_wait_frames $05 ; $74be
	and a, a ; $74c5
	jp z, Label_15_74d2 ; $74c6
	script_set_text $1c47 ; $74c9
	jp Label_15_752c ; $74cf
Label_15_74d2:
	script_set_text $1c41 ; $74d2
	script_speak $07 ; $74d8
	call ServeCoachWalkToCourtAndStartLesson ; $74dd
	ret ; $74e0
InitServeCoachScene:
	xor a, a ; $74e1
	ld [wStoryModeShowLocationName], a ; $74e2
	script_player_speed $00f0 ; $74e5
	script_set_position $00, $1300, $1300 ; $74eb
	script_set_position $02, $1300, $1100 ; $74f6
	script_move_player $1300, $1300 ; $7501
	farcall FarPtr_WaitPlayerMoveDone ; $750b
	script_face $00, $40 ; $750e
	script_face $02, $40 ; $7515
	script_face $07, $c0 ; $751c
	script_fade_in $04 ; $7523
	call WaitFadeEnd ; $7528
	ret ; $752b
Label_15_752c:
	script_speak $07 ; $752c
	script_face $07, $80 ; $7531
	ret ; $7538
Label_15_7539:
	ld a, [$c2e3] ; $7539
	ld a, a ; $753c
	rst Rst00 ; $753d
	dw Label_15_757a ; $753e jumptable
	dw Label_15_768c ; $7540 jumptable
	dw Label_15_7699 ; $7542 jumptable
	dw Label_15_76a6 ; $7544 jumptable
	dw Label_15_76b3 ; $7546 jumptable
	dw Label_15_76c0 ; $7548 jumptable
	dw Label_15_768c ; $754a jumptable
	dw Label_15_768c ; $754c jumptable
Label_15_754e:
	ld a, [$c2e3] ; $754e
	ld a, a ; $7551
	rst Rst00 ; $7552
	dw Label_15_75d9 ; $7553 jumptable
	dw Label_15_768c ; $7555 jumptable
	dw Label_15_7699 ; $7557 jumptable
	dw Label_15_76cd ; $7559 jumptable
	dw Label_15_770e ; $755b jumptable
	dw Label_15_76da ; $755d jumptable
	dw Label_15_76c0 ; $755f jumptable
	dw Label_15_768c ; $7561 jumptable
Label_15_7563:
	ld a, [$c2e3] ; $7563
	ld a, a ; $7566
	rst Rst00 ; $7567
	dw Label_15_7638 ; $7568 jumptable
	dw Label_15_768c ; $756a jumptable
	dw Label_15_7699 ; $756c jumptable
	dw Label_15_76e7 ; $756e jumptable
	dw Label_15_76f4 ; $7570 jumptable
	dw Label_15_771b ; $7572 jumptable
	dw Label_15_7701 ; $7574 jumptable
	dw Label_15_76c0 ; $7576 jumptable
	dw Label_15_768c ; $7578 jumptable
Label_15_757a:
	script_set_text $1c7e ; $757a
	call InitNetCoachScene ; $7580
	script_speak $12 ; $7583
	script_face_toward $00, $12 ; $7588
	test_flag $0a, 3 ; $7590
	jr z, Label_15_759b ; $7593
	script_set_text $1c82 ; $7595
Label_15_759b:
	script_set_anim $12, $03 ; $759b
	script_wait_idle $12 ; $75a2
	script_speak $12 ; $75a7
	script_set_anim $12, $02 ; $75ac
	script_wait_idle $12 ; $75b3
	script_speak $12 ; $75b8
	script_set_anim $12, $04 ; $75bd
	script_wait_idle $12 ; $75c4
	script_speak $12 ; $75c9
	script_face $12, $00 ; $75ce
	set_flag $17, 6 ; $75d5
	ret ; $75d8
Label_15_75d9:
	call InitNetCoachScene ; $75d9
	script_set_text $1c97 ; $75dc
	script_speak $12 ; $75e2
	script_face_toward $00, $12 ; $75e7
	script_set_anim $12, $03 ; $75ef
	script_wait_idle $12 ; $75f6
	test_flag $0a, 7 ; $75fb
	jr z, Label_15_7606 ; $75fe
	script_set_text $1c9b ; $7600
Label_15_7606:
	script_speak $12 ; $7606
	script_set_anim $12, $02 ; $760b
	script_wait_idle $12 ; $7612
	script_speak $12 ; $7617
	script_set_anim $12, $04 ; $761c
	script_wait_idle $12 ; $7623
	script_speak $12 ; $7628
	script_face $12, $00 ; $762d
	set_flag $17, 6 ; $7634
	ret ; $7637
Label_15_7638:
	call InitNetCoachScene ; $7638
	script_set_text $1cb7 ; $763b
	script_speak $12 ; $7641
	script_face_toward $00, $12 ; $7646
	script_set_anim $12, $03 ; $764e
	script_wait_idle $12 ; $7655
	script_speak $12 ; $765a
	script_set_anim $12, $02 ; $765f
	script_wait_idle $12 ; $7666
	script_speak $12 ; $766b
	script_set_anim $12, $03 ; $7670
	script_wait_idle $12 ; $7677
	script_speak $12 ; $767c
	script_face $12, $00 ; $7681
	set_flag $17, 6 ; $7688
	ret ; $768b
Label_15_768c:
	call InitNetCoachScene ; $768c
	script_set_text $1c6b ; $768f
	call NetCoachResultRetryPrompt ; $7695
	ret ; $7698
Label_15_7699:
	call InitNetCoachScene ; $7699
	script_set_text $1c6f ; $769c
	call NetCoachResultRetryPrompt ; $76a2
	ret ; $76a5
Label_15_76a6:
	call InitNetCoachScene ; $76a6
	script_set_text $1c73 ; $76a9
	call NetCoachResultRetryPrompt ; $76af
	ret ; $76b2
Label_15_76b3:
	call InitNetCoachScene ; $76b3
	script_set_text $1c77 ; $76b6
	call NetCoachResultRetryPrompt ; $76bc
	ret ; $76bf
Label_15_76c0:
	call InitNetCoachScene ; $76c0
	script_set_text $1c7b ; $76c3
	call NetCoachRetryPrompt ; $76c9
	ret ; $76cc
Label_15_76cd:
	call InitNetCoachScene ; $76cd
	script_set_text $1c90 ; $76d0
	call NetCoachResultRetryPrompt ; $76d6
	ret ; $76d9
Label_15_76da:
	call InitNetCoachScene ; $76da
	script_set_text $1c94 ; $76dd
	call NetCoachRetryPrompt ; $76e3
	ret ; $76e6
Label_15_76e7:
	call InitNetCoachScene ; $76e7
	script_set_text $1cac ; $76ea
	call NetCoachResultRetryPrompt ; $76f0
	ret ; $76f3
Label_15_76f4:
	call InitNetCoachScene ; $76f4
	script_set_text $1cb0 ; $76f7
	call NetCoachResultRetryPrompt ; $76fd
	ret ; $7700
Label_15_7701:
	call InitNetCoachScene ; $7701
	script_set_text $1cb4 ; $7704
	call NetCoachRetryPrompt ; $770a
	ret ; $770d
Label_15_770e:
	call InitNetCoachScene ; $770e
	script_set_text $1cbc ; $7711
	call NetCoachResultRetryPrompt ; $7717
	ret ; $771a
Label_15_771b:
	call InitNetCoachScene ; $771b
	script_set_text $1cc0 ; $771e
	call NetCoachResultRetryPrompt ; $7724
	ret ; $7727
NetCoachResultRetryPrompt:
	script_speak $12 ; $7728
NetCoachRetryPrompt:
	ld a, $12 ; $772d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $772f
	farcall FarPtr_RunDialogueYesNoPrompt ; $7732
	farcall FarPtr_ScriptCloseDialogueWindow ; $7735
	script_wait_frames $05 ; $7738
	and a, a ; $773f
	jp z, Label_15_7749 ; $7740
	farcall FarPtr_AdvanceDialogueTextCursor ; $7743
	jp Label_15_779d ; $7746
Label_15_7749:
	script_speak $12 ; $7749
	call NetCoachWalkToCourtAndStartLesson ; $774e
	ret ; $7751
InitNetCoachScene:
	xor a, a ; $7752
	ld [wStoryModeShowLocationName], a ; $7753
	script_player_speed $00f0 ; $7756
	script_set_position $00, $2d00, $2b00 ; $775c
	script_set_position $02, $2f00, $2b00 ; $7767
	script_move_player $2d00, $2b00 ; $7772
	farcall FarPtr_WaitPlayerMoveDone ; $777c
	script_face $00, $c0 ; $777f
	script_face $02, $c0 ; $7786
	script_face $12, $40 ; $778d
	script_fade_in $04 ; $7794
	call WaitFadeEnd ; $7799
	ret ; $779c
Label_15_779d:
	script_speak $12 ; $779d
	script_face $12, $00 ; $77a2
	ret ; $77a9
Label_15_77aa:
	ld a, [$c2e3] ; $77aa
	ld a, a ; $77ad
	rst Rst00 ; $77ae
	dw Label_15_77e3 ; $77af jumptable
	dw Label_15_78f5 ; $77b1 jumptable
	dw Label_15_7902 ; $77b3 jumptable
	dw Label_15_790f ; $77b5 jumptable
	dw Label_15_791c ; $77b7 jumptable
	dw Label_15_7929 ; $77b9 jumptable
	dw Label_15_7929 ; $77bb jumptable
Label_15_77bd:
	ld a, [$c2e3] ; $77bd
	ld a, a ; $77c0
	rst Rst00 ; $77c1
	dw Label_15_784d ; $77c2 jumptable
	dw Label_15_7936 ; $77c4 jumptable
	dw Label_15_7943 ; $77c6 jumptable
	dw Label_15_7950 ; $77c8 jumptable
	dw Label_15_795d ; $77ca jumptable
	dw Label_15_7929 ; $77cc jumptable
	dw Label_15_78f5 ; $77ce jumptable
Label_15_77d0:
	ld a, [$c2e3] ; $77d0
	ld a, a ; $77d3
	rst Rst00 ; $77d4
	dw Label_15_78a1 ; $77d5 jumptable
	dw Label_15_796a ; $77d7 jumptable
	dw Label_15_7977 ; $77d9 jumptable
	dw Label_15_7984 ; $77db jumptable
	dw Label_15_7991 ; $77dd jumptable
	dw Label_15_7929 ; $77df jumptable
	dw Label_15_78f5 ; $77e1 jumptable
Label_15_77e3:
	call InitReturnCoachScene ; $77e3
	script_set_text $1cdd ; $77e6
	script_speak $0d ; $77ec
	script_face_toward $00, $0d ; $77f1
	script_set_anim $0d, $03 ; $77f9
	script_wait_idle $0d ; $7800
	script_speak $0d ; $7805
	script_set_anim $0d, $02 ; $780a
	script_wait_idle $0d ; $7811
	test_flag $0a, 3 ; $7816
	jr z, Label_15_781e ; $7819
	farcall FarPtr_AdvanceDialogueTextCursor ; $781b
Label_15_781e:
	script_speak $0d ; $781e
	script_set_text $1ce1 ; $7823
	script_set_anim $0d, $04 ; $7829
	script_wait_idle $0d ; $7830
	test_flag $0a, 3 ; $7835
	jr z, Label_15_783d ; $7838
	farcall FarPtr_AdvanceDialogueTextCursor ; $783a
Label_15_783d:
	script_speak $0d ; $783d
	script_face $0d, $c0 ; $7842
	set_flag $17, 7 ; $7849
	ret ; $784c
Label_15_784d:
	call InitReturnCoachScene ; $784d
	script_set_text $1cf5 ; $7850
	script_speak $0d ; $7856
	script_face_toward $00, $0d ; $785b
	script_set_anim $0d, $03 ; $7863
	script_wait_idle $0d ; $786a
	script_speak $0d ; $786f
	script_set_anim $0d, $02 ; $7874
	script_wait_idle $0d ; $787b
	script_speak $0d ; $7880
	script_set_anim $0d, $04 ; $7885
	script_wait_idle $0d ; $788c
	script_speak $0d ; $7891
	script_face $0d, $c0 ; $7896
	set_flag $17, 7 ; $789d
	ret ; $78a0
Label_15_78a1:
	call InitReturnCoachScene ; $78a1
	script_set_text $200f ; $78a4
	script_speak $0d ; $78aa
	script_face_toward $00, $0d ; $78af
	script_set_anim $0d, $03 ; $78b7
	script_wait_idle $0d ; $78be
	script_speak $0d ; $78c3
	script_set_anim $0d, $02 ; $78c8
	script_wait_idle $0d ; $78cf
	script_speak $0d ; $78d4
	script_set_anim $0d, $03 ; $78d9
	script_wait_idle $0d ; $78e0
	script_speak $0d ; $78e5
	script_face $0d, $c0 ; $78ea
	set_flag $17, 7 ; $78f1
	ret ; $78f4
Label_15_78f5:
	call InitReturnCoachScene ; $78f5
	script_set_text $1ccb ; $78f8
	call ReturnCoachResultRetryPrompt ; $78fe
	ret ; $7901
Label_15_7902:
	call InitReturnCoachScene ; $7902
	script_set_text $1ccf ; $7905
	call ReturnCoachResultRetryPrompt ; $790b
	ret ; $790e
Label_15_790f:
	call InitReturnCoachScene ; $790f
	script_set_text $1cd3 ; $7912
	call ReturnCoachResultRetryPrompt ; $7918
	ret ; $791b
Label_15_791c:
	call InitReturnCoachScene ; $791c
	script_set_text $1cd7 ; $791f
	call ReturnCoachRetryPrompt ; $7925
	ret ; $7928
Label_15_7929:
	call InitReturnCoachScene ; $7929
	script_set_text $1cda ; $792c
	call ReturnCoachRetryPrompt ; $7932
	ret ; $7935
Label_15_7936:
	call InitReturnCoachScene ; $7936
	script_set_text $1ce9 ; $7939
	call ReturnCoachRetryPrompt ; $793f
	ret ; $7942
Label_15_7943:
	call InitReturnCoachScene ; $7943
	script_set_text $1cec ; $7946
	call ReturnCoachRetryPrompt ; $794c
	ret ; $794f
Label_15_7950:
	call InitReturnCoachScene ; $7950
	script_set_text $1cef ; $7953
	call ReturnCoachRetryPrompt ; $7959
	ret ; $795c
Label_15_795d:
	call InitReturnCoachScene ; $795d
	script_set_text $1cf2 ; $7960
	call ReturnCoachRetryPrompt ; $7966
	ret ; $7969
Label_15_796a:
	call InitReturnCoachScene ; $796a
	script_set_text $1cff ; $796d
	call ReturnCoachResultRetryPrompt ; $7973
	ret ; $7976
Label_15_7977:
	call InitReturnCoachScene ; $7977
	script_set_text $2003 ; $797a
	call ReturnCoachResultRetryPrompt ; $7980
	ret ; $7983
Label_15_7984:
	call InitReturnCoachScene ; $7984
	script_set_text $2007 ; $7987
	call ReturnCoachResultRetryPrompt ; $798d
	ret ; $7990
Label_15_7991:
	call InitReturnCoachScene ; $7991
	script_set_text $200b ; $7994
	call ReturnCoachResultRetryPrompt ; $799a
	ret ; $799d
ReturnCoachResultRetryPrompt:
	script_speak $0d ; $799e
ReturnCoachRetryPrompt:
	ld a, $0d ; $79a3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $79a5
	farcall FarPtr_RunDialogueYesNoPrompt ; $79a8
	farcall FarPtr_ScriptCloseDialogueWindow ; $79ab
	script_wait_frames $05 ; $79ae
	and a, a ; $79b5
	jp z, Label_15_79bc ; $79b6
	jp Label_15_7a16 ; $79b9
Label_15_79bc:
	farcall FarPtr_AdvanceDialogueTextCursor ; $79bc
	script_speak $0d ; $79bf
	call ReturnCoachWalkToCourtAndStartLesson ; $79c4
	farcall FarPtr_EndCutsceneScriptMode ; $79c7
	ret ; $79ca
InitReturnCoachScene:
	xor a, a ; $79cb
	ld [wStoryModeShowLocationName], a ; $79cc
	script_player_speed $00f0 ; $79cf
	script_set_position $00, $1300, $2b00 ; $79d5
	script_set_position $02, $1100, $2b00 ; $79e0
	script_move_player $1300, $2b00 ; $79eb
	farcall FarPtr_WaitPlayerMoveDone ; $79f5
	script_face $00, $c0 ; $79f8
	script_face $02, $c0 ; $79ff
	script_face $0d, $40 ; $7a06
	script_fade_in $04 ; $7a0d
	call WaitFadeEnd ; $7a12
	ret ; $7a15
Label_15_7a16:
	script_speak $0d ; $7a16
	script_face $0d, $c0 ; $7a1b
	ret ; $7a22
	INCBIN "data/bank_015/d_7a23.bin" ; $7a23, 34 bytes
PlaceSwingPracticeKidActor:
	test_flag $05, 7 ; $7a45
	jp nz, Label_15_7a66 ; $7a48
	ld a, [wEquippedRacket] ; $7a4b
	and a, $0f ; $7a4e
	cp a, $03 ; $7a50
	jp nz, Label_15_7a66 ; $7a52
	test_flag $10, 0 ; $7a55
	jp nz, Label_15_7a66 ; $7a58
	script_set_position $13, $3500, $0f00 ; $7a5b
Label_15_7a66:
	ret ; $7a66
StartPendingLessonScene:
	ld a, [$c8f7] ; $7a67
	cp a, $06 ; $7a6a
	jr nc, Label_15_7a75 ; $7a6c
	call InitServeCoachScene ; $7a6e
	call ServeCoachWalkToCourtAndStartLesson ; $7a71
	ret ; $7a74
Label_15_7a75:
	cp a, $0c ; $7a75
	jr nc, Label_15_7a8b ; $7a77
	call InitNetCoachScene ; $7a79
	script_set_text $1c6a ; $7a7c
	script_speak $12 ; $7a82
	call NetCoachWalkToCourtAndStartLesson ; $7a87
	ret ; $7a8a
Label_15_7a8b:
	cp a, $12 ; $7a8b
	jr nc, Label_15_7a95 ; $7a8d
	call InitReturnCoachScene ; $7a8f
	call ReturnCoachWalkToCourtAndStartLesson ; $7a92
Label_15_7a95:
	ret ; $7a95
ServeCoachWalkToCourtAndStartLesson:
	script_null_script $02 ; $7a96
	script_player_speed $0020 ; $7a9b
	script_wait_frames $14 ; $7aa1
	script_set_actor_script $07, ActorScript_15_7b03 ; $7aa8
	script_set_actor_script $00, ActorScript_15_7b1a ; $7ab3
	script_set_actor_script $02, ActorScript_15_7b25 ; $7abe
	script_move_player $1800, $0f00 ; $7ac9
	ld a, $00 ; $7ad3
	farcall FarPtr_WaitActorScriptDone ; $7ad5
	farcall FarPtr_WaitPlayerMoveDone ; $7ad8
	ld a, $07 ; $7adb
	farcall FarPtr_WaitActorScriptDone ; $7add
	script_wait_frames $05 ; $7ae0
	call PlayerPartnerGestureCutscene ; $7ae7
	ld a, $0f ; $7aea
	ld [wStoryModeCurrentLocation], a ; $7aec
	ld a, $0a ; $7aef
	ld [wStoryModeEntryPoint], a ; $7af1
	ld a, $ff ; $7af4
	ld [$c294], a ; $7af6
	ld [wStoryModeExitLocationRequest], a ; $7af9
	ld a, [$c8f7] ; $7afc
	farcall FarPtr_RunTrainingDrillByID ; $7aff
	ret ; $7b02
ActorScript_15_7b03:
	; $7b03, 23 bytes (actor_script)
	as_set_pos $1100, $1500
	as_wait_move
	as_set_pos $1300, $0f00
	as_wait_move
	as_set_pos $1700, $0700
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_7b1a:
	; $7b1a, 11 bytes (actor_script)
	as_set_pos $1900, $1700
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_7b25:
	; $7b25, 11 bytes (actor_script)
	as_set_pos $1300, $1500
	as_wait_move
	as_set_field $14, $0000
	as_halt
NetCoachWalkToCourtAndStartLesson:
	script_player_speed $0020 ; $7b30
	script_null_script $02 ; $7b36
	script_set_actor_script $12, ActorScript_15_7b96 ; $7b3b
	script_set_actor_script $00, ActorScript_15_7bb3 ; $7b46
	script_set_actor_script $02, ActorScript_15_7bbe ; $7b51
	script_move_player $2800, $2600 ; $7b5c
	ld a, $00 ; $7b66
	farcall FarPtr_WaitActorScriptDone ; $7b68
	farcall FarPtr_WaitPlayerMoveDone ; $7b6b
	ld a, $12 ; $7b6e
	farcall FarPtr_WaitActorScriptDone ; $7b70
	script_wait_frames $05 ; $7b73
	call PlayerPartnerGestureCutscene ; $7b7a
	ld a, $0f ; $7b7d
	ld [wStoryModeCurrentLocation], a ; $7b7f
	ld a, $0a ; $7b82
	ld [wStoryModeEntryPoint], a ; $7b84
	ld a, $ff ; $7b87
	ld [$c294], a ; $7b89
	ld [wStoryModeExitLocationRequest], a ; $7b8c
	ld a, [$c8f7] ; $7b8f
	farcall FarPtr_RunTrainingDrillByID ; $7b92
	ret ; $7b95
ActorScript_15_7b96:
	; $7b96, 29 bytes (actor_script)
	as_set_pos $2f00, $2900
	as_wait_move
	as_set_pos $2f00, $2300
	as_wait_move
	as_set_pos $2d00, $2300
	as_wait_move
	as_set_pos $2700, $1f00
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_7bb3:
	; $7bb3, 11 bytes (actor_script)
	as_set_pos $2900, $2f00
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_7bbe:
	; $7bbe, 11 bytes (actor_script)
	as_set_pos $2d00, $2d00
	as_wait_move
	as_set_field $14, $0080
	as_halt
ReturnCoachWalkToCourtAndStartLesson:
	script_null_script $02 ; $7bc9
	script_player_speed $0020 ; $7bce
	script_set_actor_script $0d, ActorScript_15_7c2f ; $7bd4
	script_set_actor_script $00, ActorScript_15_7c4c ; $7bdf
	script_set_actor_script $02, ActorScript_15_7c57 ; $7bea
	script_move_player $1800, $2700 ; $7bf5
	ld a, $00 ; $7bff
	farcall FarPtr_WaitActorScriptDone ; $7c01
	farcall FarPtr_WaitPlayerMoveDone ; $7c04
	ld a, $0d ; $7c07
	farcall FarPtr_WaitActorScriptDone ; $7c09
	script_wait_frames $05 ; $7c0c
	call PlayerPartnerGestureCutscene ; $7c13
	ld a, $0f ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, $0a ; $7c1b
	ld [wStoryModeEntryPoint], a ; $7c1d
	ld a, $ff ; $7c20
	ld [$c294], a ; $7c22
	ld [wStoryModeExitLocationRequest], a ; $7c25
	ld a, [$c8f7] ; $7c28
	farcall FarPtr_RunTrainingDrillByID ; $7c2b
	ret ; $7c2e
ActorScript_15_7c2f:
	; $7c2f, 29 bytes (actor_script)
	as_set_pos $1100, $2900
	as_wait_move
	as_set_pos $1100, $2500
	as_wait_move
	as_set_pos $1300, $2500
	as_wait_move
	as_set_pos $1700, $1f00
	as_wait_move
	as_set_field $14, $0040
	as_halt
ActorScript_15_7c4c:
	; $7c4c, 11 bytes (actor_script)
	as_set_pos $1900, $2f00
	as_wait_move
	as_set_field $14, $00c0
	as_halt
ActorScript_15_7c57:
	; $7c57, 11 bytes (actor_script)
	as_set_pos $1300, $2d00
	as_wait_move
	as_set_field $14, $0000
	as_halt
Func_15_7c62:
	script_set_speed $00, $0010 ; $7c62
	script_set_speed $02, $0010 ; $7c6a
	script_move_target $00, $1300, $1300 ; $7c72
	test_flag $05, 7 ; $7c7d
	jr z, Label_15_7c97 ; $7c80
	script_null_script $02 ; $7c82
	script_move_target $02, $1300, $1100 ; $7c87
	script_wait_move $02 ; $7c92
Label_15_7c97:
	script_wait_move $00 ; $7c97
	script_face $00, $00 ; $7c9c
	script_face $02, $00 ; $7ca3
	script_set_speed $00, $0020 ; $7caa
	script_set_speed $02, $0020 ; $7cb2
	ret ; $7cba
MovePartyToNetCoachSpot:
	script_set_speed $00, $0010 ; $7cbb
	script_set_speed $02, $0010 ; $7cc3
	script_move_target $00, $2d00, $2b00 ; $7ccb
	test_flag $05, 7 ; $7cd6
	jr z, Label_15_7cf0 ; $7cd9
	script_null_script $02 ; $7cdb
	script_move_target $02, $2f00, $2b00 ; $7ce0
	script_wait_move $02 ; $7ceb
Label_15_7cf0:
	script_wait_move $00 ; $7cf0
	script_face $00, $80 ; $7cf5
	script_face $02, $80 ; $7cfc
	script_set_speed $00, $0020 ; $7d03
	script_set_speed $02, $0020 ; $7d0b
	ret ; $7d13
MovePartyToReturnCoachSpot:
	script_set_speed $00, $0010 ; $7d14
	script_set_speed $02, $0010 ; $7d1c
	script_move_target $00, $1300, $2b00 ; $7d24
	test_flag $05, 7 ; $7d2f
	jr z, Label_15_7d49 ; $7d32
	script_null_script $02 ; $7d34
	script_move_target $02, $1100, $2b00 ; $7d39
	script_wait_move $02 ; $7d44
Label_15_7d49:
	script_wait_move $00 ; $7d49
	script_face $00, $00 ; $7d4e
	script_face $02, $00 ; $7d55
	script_set_speed $00, $0020 ; $7d5c
	script_set_speed $02, $0020 ; $7d64
	ret ; $7d6c
ActorScript_15_7d6d:
	; $7d6d, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_15_7d77:
	; $7d77, 30 bytes (actor_script)
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
Func_15_7d95:
	ret ; $7d95
	INCBIN "data/bank_015/d_7d96.bin" ; $7d96, 423 bytes
ActorScript_15_7f3d:
	; $7f3d, 99 bytes (actor_script)
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump ActorScript_15_7f3d
.Ld:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .Ld
	INCBIN "data/bank_015/d_7f59.bin" ; $7f59, 71 bytes (unclassified tail)
ComputeTrainingCourtProgressIndex:
	ld a, $00 ; $7fa0
	test_flag $0a, 3 ; $7fa2
	jr z, Label_15_7fbf ; $7fa5
	inc a ; $7fa7
	test_flag $0a, 7 ; $7fa8
	jr z, Label_15_7fbf ; $7fab
	inc a ; $7fad
	test_flag $05, 7 ; $7fae
	jr nz, Label_15_7fc3 ; $7fb1
	test_flag $15, 6 ; $7fb3
	jr z, Label_15_7fbf ; $7fb6
	inc a ; $7fb8
	test_flag $16, 0 ; $7fb9
	jr z, Label_15_7fbf ; $7fbc
	inc a ; $7fbe
Label_15_7fbf:
	ld [$c2b0], a ; $7fbf
	ret ; $7fc2
Label_15_7fc3:
	test_flag $15, 7 ; $7fc3
	jr z, Label_15_7fbf ; $7fc6
	inc a ; $7fc8
	test_flag $16, 1 ; $7fc9
	jr z, Label_15_7fbf ; $7fcc
	inc a ; $7fce
	jr Label_15_7fbf ; $7fcf
	ds 47, $ff ; $7fd1, fill
