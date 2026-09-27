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
	map_actor $0000, ActorScript_15_00, $0900, $1d80, FACE_DOWN, OBJ_WALK_6F_03, $01, $00, TOURNAMENT_COURTYARD_WALK_6F_03
	map_actor $0000, ActorScript_15_22, $0700, $1d80, FACE_DOWN, OBJ_WALK_6F_04, $01, $00, TOURNAMENT_COURTYARD_WALK_6F_04
	map_actor $0000, ActorScript_15_23, $0d00, $1b00, FACE_LEFT, OBJ_WALK_71_06, $01, $03, TOURNAMENT_COURTYARD_WALK_71_06
	map_actor $0000, ActorScript_15_23, $1d00, $2300, FACE_UP, OBJ_WALK_71_07, $01, $07, TOURNAMENT_COURTYARD_WALK_71_07
	map_actor $0000, ActorScript_15_22, $1f00, $1d00, FACE_LEFT, OBJ_WALK_71_03, $01, $05, TOURNAMENT_COURTYARD_WALK_71_03
	map_actor $0000, ActorScript_15_22, $0b00, $2700, FACE_LEFT, OBJ_WALK_72_02, $01, $00, TOURNAMENT_COURTYARD_WALK_72_02
	map_actor $0000, ActorScript_15_22, $0900, $2900, FACE_UP, OBJ_WALK_72_03, $01, $00, TOURNAMENT_COURTYARD_WALK_72_03
	map_actor $0000, ActorScript_15_22, $1b40, $2640, FACE_LEFT, OBJ_WALK_71_09, $01, $00, TOURNAMENT_COURTYARD_WALK_71_09_1
	map_actor $0000, ActorScript_15_22, $1cc0, $2640, FACE_LEFT, OBJ_WALK_71_09, $01, $00, TOURNAMENT_COURTYARD_WALK_71_09_2
	map_actor $0000, ActorScript_15_22, $0740, $2640, FACE_LEFT, OBJ_WALK_71_09, $01, $00, TOURNAMENT_COURTYARD_WALK_71_09_3
	map_actor $0000, ActorScript_15_22, $08c0, $2640, FACE_LEFT, OBJ_WALK_71_09, $01, $00, TOURNAMENT_COURTYARD_WALK_71_09_4
	map_actor_end
TournamentCourtyardEntryPoints_15:
	; $40b6, 41 bytes (map_entries)
	map_entry $01, FACE_LEFT, $2100, $1400, $0000
	map_entry $02, FACE_RIGHT, $0300, $1400, $0000
	map_entry $03, FACE_DOWN, $1200, $0d00, $0000
	map_entry $04, FACE_UP, $1200, $2900, $0000
	map_entry $0f, FACE_UP, $1100, $3900, $0000
	db $ff
TournamentCourtyardExitTriggers_15:
	; $40df, 33 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_COURT_1, $02
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_COURT_2, $02
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_TOURNAMENT, $05
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_ISLAND_SKY, $02
	db $ff
TournamentCourtyardNpc05_15:
	ld a, [wMapSceneStage] ; $4100
	add a ; $4103
	ld_hl_indexed TournamentCourtyardNpc05TextIds ; $4104
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall InitDialogueTextCursor ; $410e
	test_flag FLAG_DOUBLES ; $4111
	jr z, .altText ; $4114
	test_flag FLAG_TOURNAMENT_NPC05_TALKED_DOUBLES ; $4116
	jr nz, .done ; $4119
	set_flag FLAG_TOURNAMENT_NPC05_TALKED_DOUBLES ; $411b
	jr .speak ; $411e
.altText:
	test_flag FLAG_TOURNAMENT_NPC05_TALKED_SINGLES ; $4120
	jr nz, .done ; $4123
	set_flag FLAG_TOURNAMENT_NPC05_TALKED_SINGLES ; $4125
.speak:
	script_speak ACTOR_TOURNAMENT_COURTYARD_WALK_71_06 ; $4128
	script_set_anim ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, $02 ; $412d
	script_wait_idle ACTOR_TOURNAMENT_COURTYARD_WALK_71_06 ; $4134
	script_speak ACTOR_TOURNAMENT_COURTYARD_WALK_71_06 ; $4139
	ret ; $413e
.done:
	script_set_text Text_1f_32 ; $413f
	script_speak ACTOR_TOURNAMENT_COURTYARD_WALK_71_06 ; $4145
	ret ; $414a
TournamentCourtyardNpc05TextIds:
	; $414b, 14 bytes (text_ids)
	dw Text_1f_30 ; record 0
	dw Text_1f_39 ; record 1
	dw Text_1f_39 ; record 2
	dw Text_1f_39 ; record 3
	dw Text_1f_58 ; record 4
	dw Text_1f_66 ; record 5
	dw Text_1f_74 ; record 6
TournamentCourtyardNpcScripts_15:
	; $4159, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_28, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_29, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_33, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_34, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_35, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_36, $03, $00
	db $ff
TournamentCourtyardFacingScripts_15:
	; $4192, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TournamentCourtyardFacing01_15, $00, $00
	db $ff
TournamentCourtyardFacing01_15:
	ret ; $419b
TournamentCourtyardTileTriggers_15:
	; $419c, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TournamentCourtyardTile01_15, $00, $00
	db $ff
TournamentCourtyardTile01_15:
	ret ; $41a5
TournamentCourtyardInitScript_15:
	ld a, [wStoryModeEntryPoint] ; $41a6
	cp $0f ; $41a9
	jr nz, .ne0f ; $41ab
	jp TournamentSiteArrivalScene ; $41ad
.ne0f:
	call SetPlayerPartnerActorSprites ; $41b0
	call InitTournamentSiteSceneVariant ; $41b3
	call TournamentSiteEntryWalkIn ; $41b6
	ret ; $41b9
ActorScript_15_00:
	; $41ba, 19 bytes (actor_script)
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_anim $04
	as_wait $78
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $04
	as_wait $78
	as_jump ActorScript_15_00
TournamentSiteRespawnActors_15:
	; $41cd, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_22, $1200, $3400, FACE_DOWN, OBJ_WALK_75_06, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_75_06
	map_actor $0000, ActorScript_15_22, $1100, $3700, FACE_DOWN, OBJ_WALK_74_06, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_74_06
	map_actor $0000, ActorScript_15_22, $1300, $3900, FACE_DOWN, OBJ_WALK_74_07, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_74_07
	map_actor $0000, ActorScript_15_22, $1300, $3700, FACE_DOWN, OBJ_WALK_74_08, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_74_08
	map_actor $0000, ActorScript_15_00, $0900, $1d80, FACE_DOWN, OBJ_WALK_6F_03, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_6F_03
	map_actor $0000, ActorScript_15_22, $0700, $1d80, FACE_DOWN, OBJ_WALK_6F_04, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_6F_04
	map_actor $0000, ActorScript_15_23, $0d00, $1b00, FACE_LEFT, OBJ_WALK_71_06, $01, $03, TOURNAMENT_SITE_RESPAWN_WALK_71_06
	map_actor $0000, ActorScript_15_23, $1d00, $2300, FACE_UP, OBJ_WALK_71_07, $01, $07, TOURNAMENT_SITE_RESPAWN_WALK_71_07
	map_actor $0000, ActorScript_15_22, $1f00, $1d00, FACE_LEFT, OBJ_WALK_71_03, $01, $05, TOURNAMENT_SITE_RESPAWN_WALK_71_03
	map_actor $0000, ActorScript_15_22, $0b00, $2700, FACE_LEFT, OBJ_WALK_72_02, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_72_02
	map_actor $0000, ActorScript_15_22, $0900, $2900, FACE_UP, OBJ_WALK_72_03, $01, $00, TOURNAMENT_SITE_RESPAWN_WALK_72_03
	map_actor_end
InitTournamentSiteSceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $4271
	ld [wMapSceneStage], a ; $4273
	test_flag FLAG_DOUBLES ; $4276
	jr nz, .doubles ; $4279
	ld a, $f1 ; $427b
	ld d, $0e ; $427d
	ld e, $14 ; $427f
	farcall WriteBehaviorMapCell ; $4281
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4284
	jr z, .stage1 ; $4287
	ld hl, TournamentSiteFinalScripts_15 ; $4289
	ld de, $000c ; $428c
	farcall WriteStoryStateWord ; $428f
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $4292
	ld [wMapSceneStage], a ; $4294
	ret ; $4297
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4298
	jr z, .stage2 ; $429b
	ld hl, TournamentSiteSemifinalScripts_15 ; $429d
	ld de, $000c ; $42a0
	farcall WriteStoryStateWord ; $42a3
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $42a6
	ld [wMapSceneStage], a ; $42a8
	ret ; $42ab
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $42ac
	jr z, .stage3 ; $42af
	ld hl, TournamentSiteRound2Scripts_15 ; $42b1
	ld de, $000c ; $42b4
	farcall WriteStoryStateWord ; $42b7
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $42ba
	ld [wMapSceneStage], a ; $42bc
.stage3:
	ret ; $42bf
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $42c0
	jr z, .doublesStage2 ; $42c3
	ld hl, TournamentSiteDoublesFinalScripts_15 ; $42c5
	ld de, $000c ; $42c8
	farcall WriteStoryStateWord ; $42cb
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $42ce
	ld [wMapSceneStage], a ; $42d0
	ret ; $42d3
.doublesStage2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $42d4
	jr z, .done ; $42d7
	ld hl, TournamentSiteDoublesSemifinalScripts_15 ; $42d9
	ld de, $000c ; $42dc
	farcall WriteStoryStateWord ; $42df
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $42e2
	ld [wMapSceneStage], a ; $42e4
	ret ; $42e7
.done:
	ld hl, TournamentSiteDoublesRound1Scripts_15 ; $42e8
	ld de, $000c ; $42eb
	farcall WriteStoryStateWord ; $42ee
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $42f1
	ld [wMapSceneStage], a ; $42f3
	ret ; $42f6
TournamentSiteRound2Scripts_15:
	; $42f7, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_37, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_38, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_41, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_42, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_43, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_44, $03, $00
	db $ff
TournamentSiteSemifinalScripts_15:
	; $4330, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_45, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_46, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_47, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_48, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_49, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_50, $03, $00
	db $ff
TournamentSiteFinalScripts_15:
	; $4369, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_51, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_52, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_53, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_54, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_55, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_56, $03, $00
	db $ff
TournamentSiteDoublesRound1Scripts_15:
	; $43a2, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_28, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_57, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_60, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_61, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_62, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_63, $03, $00
	db $ff
TournamentSiteDoublesSemifinalScripts_15:
	; $43db, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_64, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_65, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_68, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_69, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_70, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_71, $03, $00
	db $ff
TournamentSiteDoublesFinalScripts_15:
	; $4414, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_03, FACEMASK_ANY, $0000, Text_1f_72, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_6F_04, FACEMASK_ANY, $0000, Text_1f_73, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_06, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_07, FACEMASK_ANY, $0000, Text_1f_76, $13, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_71_03, FACEMASK_ANY, $0000, Text_1f_77, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_02, FACEMASK_ANY, $0000, Text_1f_78, $03, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_WALK_72_03, FACEMASK_ANY, $0000, Text_1f_79, $03, $00
	db $ff
TournamentSiteArrivalScene:
	ldh a, [hRomBank] ; $444d
	ld hl, TournamentSiteRespawnActors_15 ; $444f
	farcall ScriptRespawnLocationActors ; $4452
	farcall BeginCutsceneScriptMode ; $4455
	call SetupTournamentSitePartnerActor ; $4458
	script_player_speed $00ff ; $445b
	script_move_player $1200, $2900 ; $4461
	farcall WaitPlayerMoveDone ; $446b
	script_fade_in $04 ; $446e
	call WaitFadeEnd ; $4473
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $1200, $2900 ; $4476
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $1100, $2c00 ; $4481
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $1300, $2e00 ; $448c
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $1300, $2c00 ; $4497
	script_move_target ACTOR_PLAYER, $1100, $2e00 ; $44a2
	script_wait_move ACTOR_PLAYER ; $44ad
	script_player_speed $0020 ; $44b2
	script_move_player $1200, $1000 ; $44b8
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $1200, $1000 ; $44c2
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $1100, $1300 ; $44cd
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $1300, $1500 ; $44d8
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $1300, $1300 ; $44e3
	script_move_target ACTOR_PLAYER, $1100, $1500 ; $44ee
	script_wait_move ACTOR_PLAYER ; $44f9
	script_wait_frames $28 ; $44fe
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, FACE_DOWN ; $4505
	script_set_text Text_1f_13 ; $450c
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4512
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $03 ; $4517
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $03 ; $451e
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $03 ; $4525
	script_set_anim ACTOR_PLAYER, $03 ; $452c
	script_wait_idle ACTOR_PLAYER ; $4533
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $04 ; $4538
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $453f
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4544
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $03 ; $4549
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08 ; $4550
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08 ; $4555
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $03 ; $455a
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07 ; $4561
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07 ; $4566
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $02 ; $456b
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4572
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4577
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $03 ; $457c
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06 ; $4583
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06 ; $4588
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $03 ; $458d
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4594
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $4599
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $03 ; $459e
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $03 ; $45a5
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $03 ; $45ac
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08 ; $45b3
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, $03 ; $45b8
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06 ; $45bf
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, FACE_RIGHT ; $45c4
	script_wait_frames $05 ; $45cb
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_75_06, FACE_UP, $0800 ; $45d2
	script_wait_frames $3c ; $45dc
	script_face ACTOR_PLAYER, FACE_LEFT ; $45e3
	script_wait_frames $28 ; $45ea
	script_face ACTOR_PLAYER, FACE_DOWN ; $45f1
	script_wait_frames $28 ; $45f8
	script_face ACTOR_PLAYER, FACE_LEFT ; $45ff
	script_wait_frames $28 ; $4606
	script_face ACTOR_PLAYER, FACE_UP ; $460d
	script_wait_frames $28 ; $4614
	script_face ACTOR_PLAYER, FACE_RIGHT ; $461b
	script_wait_frames $28 ; $4622
	script_face ACTOR_PLAYER, FACE_UP ; $4629
	script_wait_frames $28 ; $4630
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, $1200, $1000 ; $4637
	script_wait_move ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08 ; $4642
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, FACE_DOWN ; $4647
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08 ; $464e
	script_set_anim ACTOR_PLAYER, $03 ; $4653
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, $03 ; $465a
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, $03 ; $4661
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07 ; $4668
	ld a, STORYLOC_TOURNAMENT ; $466d
	ld [wStoryModeCurrentLocation], a ; $466f
	ld a, $0f ; $4672
	ld [wStoryModeEntryPoint], a ; $4674
	ld a, $ff ; $4677
	ld [wUnusedExitTriggerIdMirror], a ; $4679
	ld [wStoryModeExitTriggerRequest], a ; $467c
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_06, FACE_UP, $0a00 ; $467f
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_07, FACE_UP, $0a00 ; $4689
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_WALK_74_08, FACE_UP, $0a00 ; $4693
	script_move_angle ACTOR_PLAYER, FACE_UP, $0a00 ; $469d
	script_wait_frames $1e ; $46a7
	ld c, $08 ; $46ae
	call BeginFadeOut ; $46b0
	call WaitFadeEnd ; $46b3
	ret ; $46b6
SetupTournamentSitePartnerActor:
	call SetPlayerPartnerActorSprites ; $46b7
	test_flag FLAG_DOUBLES ; $46ba
	jr z, .noPartner ; $46bd
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $46bf
	or a ; $46c2
	jr nz, .female ; $46c3
	ld d, $58 ; $46c5
	jr .apply ; $46c7
.noPartner:
	ret ; $46c9
.female:
	ld d, OBJ_KATE_B ; $46ca
	jr .apply ; $46cc
.apply:
	script_get_actor_state $05 ; $46ce
	ld c, l ; $46d3
	ld b, h ; $46d4
	farcall LoadActorObjectDefIfValid ; $46d5
	script_set_anim $05, $01 ; $46d8
	script_null_script ACTOR_PARTNER ; $46df
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $46e4
	ret ; $46ef
TournamentSiteEntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $46f0
	cp STORYENTRY_NONE ; $46f3
	jp z, .done ; $46f5
	test_flag FLAG_DOUBLES ; $46f8
	jr z, .walkOff ; $46fb
	script_set_speed ACTOR_PARTNER, $00ff ; $46fd
	ld a, [wStoryModeEntryPoint] ; $4705
	dec a ; $4708
	ld_hl_indexed TournamentSiteEntryWalkInFacings + 4 ; $4709
	ld b, [hl] ; $4710
	ld a, $02 ; $4711
	ld b, b ; $4713
	ld de, $0200 ; $4714
	farcall MoveActorByAngle ; $4717
	script_wait_move ACTOR_PARTNER ; $471a
	ld a, [wStoryModeEntryPoint] ; $471f
	dec a ; $4722
	ld_hl_indexed TournamentSiteEntryWalkInFacings ; $4723
	ld b, [hl] ; $472a
	ld a, $02 ; $472b
	ld b, b ; $472d
	farcall SetActorFacing ; $472e
	script_set_speed ACTOR_PARTNER, $0010 ; $4731
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4739
	ld a, [wStoryModeEntryPoint] ; $4741
	dec a ; $4744
	ld_hl_indexed TournamentSiteEntryWalkInFacings ; $4745
	ld b, [hl] ; $474c
	ld a, $00 ; $474d
	ld b, b ; $474f
	ld de, $0200 ; $4750
	farcall MoveActorByAngle ; $4753
.done:
	ret ; $4756
TournamentSiteEntryWalkInFacings:
	; $4757, 8 bytes (enum:FACE:8)
	db FACE_LEFT, FACE_RIGHT, FACE_DOWN, FACE_UP, FACE_RIGHT, FACE_LEFT, FACE_UP, FACE_DOWN ; 0x00
; Instruction-identical to LoadCourtPlayerPartnerObjDefs_14 (one copy per bank); a change here belongs in every copy.
	twin_named load_court_player_partner_obj_defs, SetPlayerPartnerActorSprites ; $475f
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
	map_actor $0000, ActorScript_15_03, $0b00, $0700, FACE_DOWN, OBJ_WALK_71_06, $01, $03, TRAINING_COURT_WALK_71_06_1
	map_actor $0000, ActorScript_15_03, $0b00, $1700, FACE_UP, OBJ_WALK_71_05, $01, $07, TRAINING_COURT_WALK_71_05_1
	map_actor $0000, ActorScript_15_03, $0e00, $1700, FACE_UP, OBJ_WALK_71_07, $01, $05, TRAINING_COURT_WALK_71_07_1
	map_actor $0000, ActorScript_15_22, $1300, $0b00, FACE_LEFT, OBJ_BOB, $01, $00, TRAINING_COURT_BOB_1
	map_actor $0000, ActorScript_15_22, $1300, $1500, FACE_LEFT, OBJ_CURT, $01, $06, TRAINING_COURT_CURT
	map_actor $0000, ActorScript_15_02, $0b00, $2100, FACE_DOWN, OBJ_WALK_71_07, $01, $03, TRAINING_COURT_WALK_71_07_2
	map_actor $0000, ActorScript_15_02, $0d00, $2100, FACE_DOWN, OBJ_WALK_72_02, $01, $05, TRAINING_COURT_WALK_72_02_1
	map_actor $0000, ActorScript_15_02, $0c00, $2d00, FACE_UP, OBJ_WALK_71_06, $01, $04, TRAINING_COURT_WALK_71_06_2
	map_actor $0000, ActorScript_15_25, $0700, $2d00, FACE_RIGHT, OBJ_PAM, $01, $07, TRAINING_COURT_PAM
	map_actor $0000, ActorScript_15_22, $1300, $2700, FACE_DOWN, OBJ_ALLIE, $01, $06, TRAINING_COURT_ALLIE
	map_actor $0000, ActorScript_15_22, $1300, $2900, FACE_UP, OBJ_BOB, $01, $04, TRAINING_COURT_BOB_2
	map_actor $0000, ActorScript_15_02, $3300, $2a00, FACE_UP, OBJ_WALK_72_02, $01, $06, TRAINING_COURT_WALK_72_02_2
	map_actor $0000, ActorScript_15_02, $3500, $2400, FACE_DOWN, OBJ_WALK_71_05, $01, $03, TRAINING_COURT_WALK_71_05_2
	map_actor $0000, ActorScript_15_02, $3500, $2a00, FACE_UP, OBJ_WALK_71_07, $01, $07, TRAINING_COURT_WALK_71_07_3
	map_actor $0000, ActorScript_15_22, $2d00, $2100, FACE_RIGHT, OBJ_BRIAN, $01, $07, TRAINING_COURT_BRIAN
	map_actor $0000, ActorScript_15_22, $2d00, $2900, FACE_RIGHT, OBJ_BETH, $01, $07, TRAINING_COURT_BETH
	map_actor $0000, ActorScript_15_01, $3f00, $0300, FACE_DOWN, OBJ_WALK_71_06, $01, $07, TRAINING_COURT_WALK_71_06_3
	map_actor $0000, ActorScript_15_22, $3f00, $0500, FACE_DOWN, OBJ_WALK_76_06, $01, $00, TRAINING_COURT_WALK_76_06
	map_actor $0000, ActorScript_15_22, $3f00, $0700, FACE_DOWN, OBJ_WALK_71_08, $01, $05, TRAINING_COURT_WALK_71_08
	map_actor $0000, ActorScript_15_22, $3f00, $0900, FACE_DOWN, OBJ_WALK_73_16, $01, $00, TRAINING_COURT_WALK_73_16
	map_actor $0000, ActorScript_15_22, $3f00, $0b00, FACE_DOWN, OBJ_WALK_73_19, $01, $00, TRAINING_COURT_WALK_73_19
	map_actor_end
TrainingCourtEntryPoints_15:
	; $48d4, 57 bytes (map_entries)
	map_entry $01, FACE_RIGHT, $0900, $3700, TrainingCourtArrival01_15
	map_entry $02, FACE_DOWN, $1300, $1300, $0000
	map_entry $09, FACE_DOWN, $1300, $1300, $0000
	map_entry $0a, FACE_UP, $1300, $1300, $0000
	map_entry $0b, FACE_DOWN, $1300, $1300, $0000
	map_entry $0c, FACE_UP, $2d00, $2b00, $0000
	map_entry $0d, FACE_LEFT, $1500, $2900, $0000
	db $ff
TrainingCourtArrival01_15:
	ld a, [wStoryModeEntryPoint] ; $490d
	cp STORYENTRY_NONE ; $4910
	jp z, .done ; $4912
	call ClearTrainingCourtNpcFlags ; $4915
	test_flag FLAG_DOUBLES ; $4918
	jr z, .walkOff ; $491b
	script_set_speed ACTOR_PARTNER, $00ff ; $491d
	script_move_angle ACTOR_PARTNER, FACE_LEFT, $0200 ; $4925
	script_wait_move ACTOR_PARTNER ; $492f
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4934
	script_set_speed ACTOR_PARTNER, $0010 ; $493b
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4943
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $494b
.done:
	ret ; $4955
TrainingCourtExitTriggers_15:
	; $4956, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, ClearTrainingCourtNpcFlags, STORYLOC_RESTAURANT_PLAZA, $06
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_RESTAURANT_PLAZA, $0e
	db $ff
ClearTrainingCourtNpcFlags:
	clear_flag FLAG_SERVE_CHALLENGER_DEFEATED ; $4967
	clear_flag FLAG_SERVE_COACH_GREETED ; $496a
	clear_flag FLAG_NET_CHALLENGER_DEFEATED ; $496d
	clear_flag FLAG_NET_COACH_GREETED ; $4970
	clear_flag FLAG_STROKE_CHALLENGER_DEFEATED ; $4973
	clear_flag FLAG_RETURN_COACH_GREETED ; $4976
	ret ; $4979
TrainingCourtNpc03_15:
	ld a, [wMapSceneStage] ; $497a
	add a ; $497d
	ld_hl_indexed TrainingCourtNpc03TextIds ; $497e
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	farcall InitDialogueTextCursor ; $4988
	script_speak ACTOR_TRAINING_COURT_WALK_71_06_1 ; $498b
	ret ; $4990
TrainingCourtNpc03TextIds:
	; $4991, 10 bytes (text_ids)
	dw Text_36_633 ; record 0
	dw Text_36_636 ; record 1
	dw Text_36_639 ; record 2
	dw Text_36_639 ; record 3
	dw Text_36_639 ; record 4
TrainingCourtNpc04_15:
	ld a, [wMapSceneStage] ; $499b
	add a ; $499e
	ld_hl_indexed TrainingCourtNpc04TextIds ; $499f
	ld a, [hl+] ; $49a6
	ld h, [hl] ; $49a7
	ld l, a ; $49a8
	farcall InitDialogueTextCursor ; $49a9
	script_speak ACTOR_TRAINING_COURT_WALK_71_05_1 ; $49ac
	ret ; $49b1
TrainingCourtNpc04TextIds:
	; $49b2, 10 bytes (text_ids)
	dw Text_36_634 ; record 0
	dw Text_36_637 ; record 1
	dw Text_36_640 ; record 2
	dw Text_36_640 ; record 3
	dw Text_36_640 ; record 4
TrainingCourtNpc05_15:
	ld a, [wMapSceneStage] ; $49bc
	add a ; $49bf
	ld_hl_indexed TrainingCourtNpc05TextIds ; $49c0
	ld a, [hl+] ; $49c7
	ld h, [hl] ; $49c8
	ld l, a ; $49c9
	farcall InitDialogueTextCursor ; $49ca
	script_speak ACTOR_TRAINING_COURT_WALK_71_07_1 ; $49cd
	ret ; $49d2
TrainingCourtNpc05TextIds:
	; $49d3, 10 bytes (text_ids)
	dw Text_36_635 ; record 0
	dw Text_36_638 ; record 1
	dw Text_36_641 ; record 2
	dw Text_36_641 ; record 3
	dw Text_36_641 ; record 4
TrainingCourtNpc08_15:
	ld a, [wMapSceneStage] ; $49dd
	add a ; $49e0
	ld_hl_indexed TrainingCourtNpc08TextIds ; $49e1
	ld a, [hl+] ; $49e8
	ld h, [hl] ; $49e9
	ld l, a ; $49ea
	farcall InitDialogueTextCursor ; $49eb
	script_speak ACTOR_TRAINING_COURT_WALK_71_07_2 ; $49ee
	ret ; $49f3
TrainingCourtNpc08TextIds:
	; $49f4, 10 bytes (text_ids)
	dw Text_36_655 ; record 0
	dw Text_36_661 ; record 1
	dw Text_36_665 ; record 2
	dw Text_36_665 ; record 3
	dw Text_36_665 ; record 4
TrainingCourtNpc09_15:
	ld a, [wMapSceneStage] ; $49fe
	add a ; $4a01
	ld_hl_indexed TrainingCourtNpc09TextIds_15 ; $4a02
	ld a, [hl+] ; $4a09
	ld h, [hl] ; $4a0a
	ld l, a ; $4a0b
	farcall InitDialogueTextCursor ; $4a0c
	script_speak ACTOR_TRAINING_COURT_WALK_72_02_1 ; $4a0f
	ret ; $4a14
TrainingCourtNpc09TextIds_15:
	; $4a15, 10 bytes (text_ids)
	dw Text_36_656 ; record 0
	dw Text_36_662 ; record 1
	dw Text_36_666 ; record 2
	dw Text_36_666 ; record 3
	dw Text_36_666 ; record 4
TrainingCourtNpc0A_15:
	ld a, [wMapSceneStage] ; $4a1f
	add a ; $4a22
	ld_hl_indexed TrainingCourtNpc0ATextIds ; $4a23
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	farcall InitDialogueTextCursor ; $4a2d
	script_speak ACTOR_TRAINING_COURT_WALK_71_06_2 ; $4a30
	ret ; $4a35
TrainingCourtNpc0ATextIds:
	; $4a36, 10 bytes (text_ids)
	dw Text_36_657 ; record 0
	dw Text_36_663 ; record 1
	dw Text_36_667 ; record 2
	dw Text_36_667 ; record 3
	dw Text_36_667 ; record 4
TrainingCourtNpc0B_15:
	ld a, [wMapSceneStage] ; $4a40
	add a ; $4a43
	ld_hl_indexed TrainingCourtNpc0BTextIds ; $4a44
	ld a, [hl+] ; $4a4b
	ld h, [hl] ; $4a4c
	ld l, a ; $4a4d
	farcall InitDialogueTextCursor ; $4a4e
	ld a, [wMapSceneStage] ; $4a51
	cp STORYTIER_JUNIOR_CHAMP ; $4a54
	jr z, .speak ; $4a56
	ld a, $0b ; $4a58
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4a5a
	farcall RunDialogueYesNoPrompt ; $4a5d
	farcall ScriptCloseDialogueWindow ; $4a60
	script_wait_frames $05 ; $4a63
	and a ; $4a6a
	jr z, .speak ; $4a6b
	farcall AdvanceDialogueTextCursor ; $4a6d
.speak:
	script_speak ACTOR_TRAINING_COURT_PAM ; $4a70
	ret ; $4a75
TrainingCourtNpc0BTextIds:
	; $4a76, 10 bytes (text_ids)
	dw Text_36_658 ; record 0
	dw Text_36_664 ; record 1
	dw Text_36_668 ; record 2
	dw Text_36_668 ; record 3
	dw Text_36_668 ; record 4
TrainingCourtNpc0E_15:
	ld a, [wMapSceneStage] ; $4a80
	add a ; $4a83
	ld_hl_indexed TrainingCourtNpc0ETextIds ; $4a84
	ld a, [hl+] ; $4a8b
	ld h, [hl] ; $4a8c
	ld l, a ; $4a8d
	farcall InitDialogueTextCursor ; $4a8e
	script_speak ACTOR_TRAINING_COURT_WALK_71_05_2 ; $4a91
	ret ; $4a96
TrainingCourtNpc0ETextIds:
	; $4a97, 10 bytes (text_ids)
	dw Text_36_642 ; record 0
	dw Text_36_647 ; record 1
	dw Text_36_650 ; record 2
	dw Text_36_650 ; record 3
	dw Text_36_650 ; record 4
TrainingCourtNpc0F_15:
	ld a, [wMapSceneStage] ; $4aa1
	add a ; $4aa4
	ld_hl_indexed TrainingCourtNpc0FTextIds ; $4aa5
	ld a, [hl+] ; $4aac
	ld h, [hl] ; $4aad
	ld l, a ; $4aae
	farcall InitDialogueTextCursor ; $4aaf
	ld a, [wMapSceneStage] ; $4ab2
	cp STORYTIER_JUNIOR_CHAMP ; $4ab5
	jr nc, .speak ; $4ab7
	ld a, $0f ; $4ab9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4abb
	farcall RunDialogueYesNoPrompt ; $4abe
	farcall ScriptCloseDialogueWindow ; $4ac1
	script_wait_frames $05 ; $4ac4
	and a ; $4acb
	jr z, .speak ; $4acc
	farcall AdvanceDialogueTextCursor ; $4ace
.speak:
	script_speak ACTOR_TRAINING_COURT_WALK_71_05_2 ; $4ad1
	ret ; $4ad6
TrainingCourtNpc0FTextIds:
	; $4ad7, 10 bytes (text_ids)
	dw Text_36_643 ; record 0
	dw Text_36_648 ; record 1
	dw Text_36_651 ; record 2
	dw Text_36_651 ; record 3
	dw Text_36_651 ; record 4
TrainingCourtNpc10_15:
	ld a, [wMapSceneStage] ; $4ae1
	add a ; $4ae4
	ld_hl_indexed TrainingCourtNpc10TextIds_15 ; $4ae5
	ld a, [hl+] ; $4aec
	ld h, [hl] ; $4aed
	ld l, a ; $4aee
	farcall InitDialogueTextCursor ; $4aef
	ld a, [wMapSceneStage] ; $4af2
	cp STORYTIER_SENIOR_CHAMP ; $4af5
	jr c, .speak ; $4af7
	ld a, $10 ; $4af9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4afb
	farcall RunDialogueYesNoPrompt ; $4afe
	farcall ScriptCloseDialogueWindow ; $4b01
	script_wait_frames $05 ; $4b04
	and a ; $4b0b
	jr z, .speak ; $4b0c
	farcall AdvanceDialogueTextCursor ; $4b0e
.speak:
	script_speak ACTOR_TRAINING_COURT_WALK_71_07_3 ; $4b11
	ret ; $4b16
TrainingCourtNpc10TextIds_15:
	; $4b17, 10 bytes (text_ids)
	dw Text_36_646 ; record 0
	dw Text_36_649 ; record 1
	dw Text_36_652 ; record 2
	dw Text_36_652 ; record 3
	dw Text_36_652 ; record 4
TrainingCourtNpc13_15:
	script_move_player_to_actor ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4b21
	farcall WaitPlayerMoveDone ; $4b28
	script_get_actor_state ACTOR_PLAYER ; $4b2b
	ld a, $01 ; $4b30
	ld e, l ; $4b32
	ld d, h ; $4b33
	ld hl, $0018 ; $4b34
	add hl, de ; $4b37
	ld [hl], a ; $4b38
	script_set_text Text_36_671 ; $4b39
	ld a, $13 ; $4b3f
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4b41
	farcall RunDialogueYesNoPrompt ; $4b44
	farcall ScriptCloseDialogueWindow ; $4b47
	script_wait_frames $05 ; $4b4a
	and a ; $4b51
	jp nz, .setFlag ; $4b52
	script_set_anim ACTOR_PLAYER, $03 ; $4b55
	script_wait_idle ACTOR_PLAYER ; $4b5c
	script_speak ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4b61
	script_wait_frames $0a ; $4b66
	ret ; $4b6d
.setFlag:
	set_flag FLAG_SWING_PRACTICE_KID_PLACED ; $4b6e
	script_set_anim ACTOR_PLAYER, $04 ; $4b71
	script_wait_idle ACTOR_PLAYER ; $4b78
	script_set_anim ACTOR_TRAINING_COURT_WALK_71_06_3, $01 ; $4b7d
	script_wait_idle ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4b84
	script_face ACTOR_TRAINING_COURT_WALK_71_06_3, FACE_LEFT ; $4b89
	script_get_actor_state ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4b90
	ld a, $02 ; $4b95
	ld e, l ; $4b97
	ld d, h ; $4b98
	ld hl, $0018 ; $4b99
	add hl, de ; $4b9c
	ld [hl], a ; $4b9d
	script_set_anim ACTOR_TRAINING_COURT_WALK_71_06_3, $02 ; $4b9e
	script_wait_idle ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4ba5
	script_get_actor_state ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4baa
	ld a, $01 ; $4baf
	ld e, l ; $4bb1
	ld d, h ; $4bb2
	ld hl, $0018 ; $4bb3
	add hl, de ; $4bb6
	ld [hl], a ; $4bb7
	script_set_position ACTOR_TRAINING_COURT_WALK_73_16, $3680, $0d80 ; $4bb8
	sound SFX_APPEAR1 ; $4bc3
	farcall AdvanceDialogueTextCursor ; $4bc5
	script_speak ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4bc8
	script_set_speed ACTOR_PLAYER, $0012 ; $4bcd
	script_set_anim ACTOR_PLAYER, $03 ; $4bd5
	script_wait_idle ACTOR_PLAYER ; $4bdc
	script_move_target ACTOR_PLAYER, $3300, $0f00 ; $4be1
	script_wait_move ACTOR_PLAYER ; $4bec
	script_face ACTOR_PLAYER, FACE_DOWN ; $4bf1
	script_wait_frames $0a ; $4bf8
	script_set_position ACTOR_TRAINING_COURT_WALK_73_16, $3f00, $3f00 ; $4bff
	script_wait_frames $14 ; $4c0a
	script_set_anim ACTOR_PLAYER, $06 ; $4c11
	script_wait_frames $b4 ; $4c18
	script_set_anim ACTOR_PLAYER, $01 ; $4c1f
	script_wait_idle ACTOR_PLAYER ; $4c26
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4c2b
	script_face ACTOR_TRAINING_COURT_WALK_71_06_3, FACE_DOWN ; $4c32
	script_wait_frames $01 ; $4c39
	script_set_anim ACTOR_TRAINING_COURT_WALK_71_06_3, $04 ; $4c40
	script_wait_idle ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4c47
	script_face ACTOR_TRAINING_COURT_WALK_71_06_3, FACE_LEFT ; $4c4c
	script_wait_frames $01 ; $4c53
	script_speak ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4c5a
	script_wait_frames $1e ; $4c5f
	script_set_speed ACTOR_PLAYER, $0020 ; $4c66
	script_face ACTOR_PLAYER, FACE_DOWN ; $4c6e
	script_wait_frames $01 ; $4c75
	script_lock_facing ACTOR_PLAYER ; $4c7c
	script_set_anim ACTOR_PLAYER, $02 ; $4c83
	script_move_target ACTOR_PLAYER, $3300, $0d00 ; $4c8a
	script_move_target ACTOR_TRAINING_COURT_WALK_71_06_3, $3300, $0f00 ; $4c95
	script_wait_move ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4ca0
	script_move_target ACTOR_TRAINING_COURT_WALK_71_06_3, $3300, $1500 ; $4ca5
	script_wait_move ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4cb0
	script_move_target ACTOR_TRAINING_COURT_WALK_71_06_3, $1f00, $1500 ; $4cb5
	script_wait_move ACTOR_TRAINING_COURT_WALK_71_06_3 ; $4cc0
	script_set_position ACTOR_TRAINING_COURT_WALK_71_06_3, $3f00, $3f00 ; $4cc5
	script_unlock_facing ACTOR_PLAYER ; $4cd0
	script_face ACTOR_PLAYER, FACE_DOWN ; $4cd7
	script_get_actor_state ACTOR_PLAYER ; $4cde
	ld a, $02 ; $4ce3
	ld e, l ; $4ce5
	ld d, h ; $4ce6
	ld hl, $0018 ; $4ce7
	add hl, de ; $4cea
	ld [hl], a ; $4ceb
	script_set_anim ACTOR_PLAYER, $02 ; $4cec
	script_set_position ACTOR_TRAINING_COURT_WALK_73_16, $3480, $0b80 ; $4cf3
	sound SFX_APPEAR1 ; $4cfe
	script_wait_frames $50 ; $4d00
