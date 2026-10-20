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
	map_actor $0000, ActorScript_15_00, 9.0, 29.5, FACE_DOWN, OBJ_PROGRAM_SELLER, ANIM_WALK, $00, TOURNAMENT_COURTYARD_PROGRAM_SELLER
	map_actor $0000, ActorScript_15_22, 7.0, 29.5, FACE_DOWN, OBJ_SOUVENIR_SELLER, ANIM_WALK, $00, TOURNAMENT_COURTYARD_SOUVENIR_SELLER
	map_actor $0000, ActorScript_15_23, 13.0, 27.0, FACE_LEFT, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $03, TOURNAMENT_COURTYARD_STUDENT_CAP_BOY
	map_actor $0000, ActorScript_15_23, 29.0, 35.0, FACE_UP, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $07, TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL
	map_actor $0000, ActorScript_15_22, 31.0, 29.0, FACE_LEFT, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $05, TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR
	map_actor $0000, ActorScript_15_22, 11.0, 39.0, FACE_LEFT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $00, TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY
	map_actor $0000, ActorScript_15_22, 9.0, 41.0, FACE_UP, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $00, TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL
	map_actor $0000, ActorScript_15_22, 27.25, 38.25, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, TOURNAMENT_COURTYARD_INVISIBLE_1
	map_actor $0000, ActorScript_15_22, 28.75, 38.25, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, TOURNAMENT_COURTYARD_INVISIBLE_2
	map_actor $0000, ActorScript_15_22, 7.25, 38.25, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, TOURNAMENT_COURTYARD_INVISIBLE_3
	map_actor $0000, ActorScript_15_22, 8.75, 38.25, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, TOURNAMENT_COURTYARD_INVISIBLE_4
	map_actor_end
TournamentCourtyardEntryPoints_15:
	; $40b6, 41 bytes (map_entries)
	map_entry $01, FACE_LEFT, 33.0, 20.0, $0000, TOURNAMENT_COURTYARD_FROM_COURT_1
	map_entry $02, FACE_RIGHT, 3.0, 20.0, $0000, TOURNAMENT_COURTYARD_FROM_COURT_2
	map_entry $03, FACE_DOWN, 18.0, 13.0, $0000, TOURNAMENT_COURTYARD_FROM_TOURNAMENT
	map_entry $04, FACE_UP, 18.0, 41.0, $0000, TOURNAMENT_COURTYARD_FROM_ISLAND_SKY
	map_entry $0f, FACE_UP, 17.0, 57.0, $0000, TOURNAMENT_COURTYARD_SITE_ARRIVAL
	db $ff
TournamentCourtyardExitTriggers_15:
	; $40df, 33 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_COURT_1, ENTRY_COURT_1_FROM_TOURNAMENT_COURTYARD, TOURNAMENT_COURTYARD_TO_COURT_1
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_COURT_2, ENTRY_COURT_2_FROM_TOURNAMENT_COURTYARD, TOURNAMENT_COURTYARD_TO_COURT_2
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_TOURNAMENT, ENTRY_TOURNAMENT_FROM_TOURNAMENT_COURTYARD, TOURNAMENT_COURTYARD_TO_TOURNAMENT
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_ISLAND_SKY, ENTRY_ISLAND_SKY_HOME_FROM_ISLAND_OPEN, TOURNAMENT_COURTYARD_FLY_HOME
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
	test_flag FLAG_TALKED_TO_UNION_FAN_DOUBLES ; $4116
	jr nz, .alreadyTalked ; $4119
	set_flag FLAG_TALKED_TO_UNION_FAN_DOUBLES ; $411b
	jr .speak ; $411e
.altText:
	test_flag FLAG_TALKED_TO_UNION_FAN_SINGLES ; $4120
	jr nz, .alreadyTalked ; $4123
	set_flag FLAG_TALKED_TO_UNION_FAN_SINGLES ; $4125
.speak:
	script_speak ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY ; $4128
	script_set_anim ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, ANIM_BOUNCE ; $412d
	script_wait_idle ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY ; $4134
	script_speak ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY ; $4139
	ret ; $413e
.alreadyTalked:
	script_set_text Text_UnionFanRootForYou ; $413f
	script_speak ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY ; $4145
	ret ; $414a
TournamentCourtyardNpc05TextIds:
	; $414b, 14 bytes (text_ids)
	dw Text_UnionFanAllUnionThisYear ; record 0
	dw Text_UnionFanAllLostRoundOne ; record 1
	dw Text_UnionFanAllLostRoundOne ; record 2
	dw Text_UnionFanAllLostRoundOne ; record 3
	dw Text_UnionFanSammiAndSean ; record 4
	dw Text_UnionFanOnlyTeamLost ; record 5
	dw Text_UnionFanWonderWhyWeLost ; record 6
TournamentCourtyardNpcScripts_15:
	; $4159, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerRoundOneSouvenirs, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerHopingCloseMatches, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanCozTwinsWillWin, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanAcademyNoChance, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanSunnySkies, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlLearnTheRules, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
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
	cp ENTRY_TOURNAMENT_COURTYARD_SITE_ARRIVAL ; $41a9
	jr nz, .ne0f ; $41ab
	jp TournamentSiteArrivalScene ; $41ad
.ne0f:
	call LoadPlayerPartnerObjDefs_15 ; $41b0
	call InitTournamentSiteSceneVariant ; $41b3
	call TournamentSiteEntryWalkIn ; $41b6
	ret ; $41b9
ActorScript_15_00:
	; $41ba, 19 bytes (actor_script)
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_anim ANIM_SHAKE
	as_wait 120
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SHAKE
	as_wait 120
	as_jump ActorScript_15_00
TournamentSiteRespawnActors_15:
	; $41cd, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_22, 18.0, 52.0, FACE_DOWN, OBJ_HEADMASTER, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_HEADMASTER
	map_actor $0000, ActorScript_15_22, 17.0, 55.0, FACE_DOWN, OBJ_EMILY_SWEATS, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS
	map_actor $0000, ActorScript_15_22, 19.0, 57.0, FACE_DOWN, OBJ_MARK_SWEATS, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_MARK_SWEATS
	map_actor $0000, ActorScript_15_22, 19.0, 55.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS
	map_actor $0000, ActorScript_15_00, 9.0, 29.5, FACE_DOWN, OBJ_PROGRAM_SELLER, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_PROGRAM_SELLER
	map_actor $0000, ActorScript_15_22, 7.0, 29.5, FACE_DOWN, OBJ_SOUVENIR_SELLER, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_SOUVENIR_SELLER
	map_actor $0000, ActorScript_15_23, 13.0, 27.0, FACE_LEFT, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $03, TOURNAMENT_SITE_RESPAWN_STUDENT_CAP_BOY
	map_actor $0000, ActorScript_15_23, 29.0, 35.0, FACE_UP, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $07, TOURNAMENT_SITE_RESPAWN_STUDENT_WAVY_HAIR_GIRL
	map_actor $0000, ActorScript_15_22, 31.0, 29.0, FACE_LEFT, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $05, TOURNAMENT_SITE_RESPAWN_STUDENT_LONG_HAIR
	map_actor $0000, ActorScript_15_22, 11.0, 39.0, FACE_LEFT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_STUDENT_SIDE_PART_BOY
	map_actor $0000, ActorScript_15_22, 9.0, 41.0, FACE_UP, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $00, TOURNAMENT_SITE_RESPAWN_STUDENT_PIGTAILS_GIRL
	map_actor_end
InitTournamentSiteSceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $4271
	ld [wMapSceneStage], a ; $4273
	test_flag FLAG_DOUBLES ; $4276
	jr nz, .doubles ; $4279
	ld a, BEHAVIOR_TRIGGER | 15 << 4 ; $427b
	map_cell 14, 20 ; $427d
	farcall WriteBehaviorMapCell ; $4281
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4284
	jr z, .checkRound2 ; $4287
	ld hl, TournamentSiteFinalNpcScripts_15 ; $4289
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $428c
	farcall WriteStoryStateWord ; $428f
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $4292
	ld [wMapSceneStage], a ; $4294
	ret ; $4297
.checkRound2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4298
	jr z, .checkRound1 ; $429b
	ld hl, TournamentSiteSemifinalNpcScripts_15 ; $429d
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $42a0
	farcall WriteStoryStateWord ; $42a3
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $42a6
	ld [wMapSceneStage], a ; $42a8
	ret ; $42ab
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $42ac
	jr z, .keepRound1 ; $42af
	ld hl, TournamentSiteRound2NpcScripts_15 ; $42b1
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $42b4
	farcall WriteStoryStateWord ; $42b7
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $42ba
	ld [wMapSceneStage], a ; $42bc
.keepRound1:
	ret ; $42bf
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $42c0
	jr z, .doublesCheckRound1 ; $42c3
	ld hl, TournamentSiteDoublesFinalNpcScripts_15 ; $42c5
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $42c8
	farcall WriteStoryStateWord ; $42cb
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $42ce
	ld [wMapSceneStage], a ; $42d0
	ret ; $42d3
.doublesCheckRound1:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $42d4
	jr z, .doublesRound1 ; $42d7
	ld hl, TournamentSiteDoublesSemifinalNpcScripts_15 ; $42d9
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $42dc
	farcall WriteStoryStateWord ; $42df
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $42e2
	ld [wMapSceneStage], a ; $42e4
	ret ; $42e7
.doublesRound1:
	ld hl, TournamentSiteDoublesRound1NpcScripts_15 ; $42e8
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $42eb
	farcall WriteStoryStateWord ; $42ee
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $42f1
	ld [wMapSceneStage], a ; $42f3
	ret ; $42f6
TournamentSiteRound2NpcScripts_15:
	; $42f7, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerFactoryHat, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerEveryoneDoBest, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanAllMadeRoundTwo, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanSpikeWillWin, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanYouDidWellUnseeded, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlYoureGood, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteSemifinalNpcScripts_15:
	; $4330, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerSemifinalists, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerPlayerUnseededGood, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanOnlyACozLeft, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanHopeSpikesVictorWins, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanYouBeatSpike, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlWantAutograph, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteFinalNpcScripts_15:
	; $4369, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerFinalACozVsPlayer, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerACozToughFinal, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanACozMadeFinals, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanCountingOnYou, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanUpsetOverEmily, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlYouMadeFinals, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteDoublesRound1NpcScripts_15:
	; $43a2, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerRoundOneSouvenirs, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerHopeForSales, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanCozBrothersDoubles, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanAcademyNoChanceDoubles, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanDoublesStrategic, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlWhatsDoubles, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteDoublesSemifinalNpcScripts_15:
	; $43db, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerGetSouvenirsWhileYouCan, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerGoodFirstRound, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanEasySemifinal, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanEllisEdgarLost, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanGreatTeamwork, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlYourTeamsGood, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteDoublesFinalNpcScripts_15:
	; $4414, 57 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_COURTYARD_PROGRAM_SELLER, FACEMASK_ANY, $0000, Text_ProgramSellerDoublesFinalCrowd, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_SOUVENIR_SELLER, FACEMASK_ANY, $0000, Text_SouvenirSellerCozBrothersFinals, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_CAP_BOY, FACEMASK_ANY, $0000, TournamentCourtyardNpc05_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, Text_FactoryFanCozBeatAcademySeeds, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_LONG_HAIR, FACEMASK_ANY, $0000, Text_EmpireFanSpikeEdgarLost, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_SIDE_PART_BOY, FACEMASK_ANY, $0000, Text_CourtyardFanDoublesSoDeep, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_COURTYARD_STUDENT_PIGTAILS_GIRL, FACEMASK_ANY, $0000, Text_CourtyardGirlDoublesFinalists, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentSiteArrivalScene:
	script_respawn_actors TournamentSiteRespawnActors_15 ; $444d
	farcall BeginCutsceneScriptMode ; $4455
	call SetupTournamentSitePartnerActor ; $4458
	script_player_speed 7.96875 ; $445b
	script_move_player 18.0, 41.0 ; $4461
	farcall WaitPlayerMoveDone ; $446b
	script_fade_in 4 ; $446e
	call WaitFadeEnd ; $4473
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, 18.0, 41.0 ; $4476
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, 17.0, 44.0 ; $4481
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, 19.0, 46.0 ; $448c
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, 19.0, 44.0 ; $4497
	script_move_target ACTOR_PLAYER, 17.0, 46.0 ; $44a2
	script_wait_move ACTOR_PLAYER ; $44ad
	script_player_speed 1.0 ; $44b2
	script_move_player 18.0, 16.0 ; $44b8
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, 18.0, 16.0 ; $44c2
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, 17.0, 19.0 ; $44cd
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, 19.0, 21.0 ; $44d8
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, 19.0, 19.0 ; $44e3
	script_move_target ACTOR_PLAYER, 17.0, 21.0 ; $44ee
	script_wait_move ACTOR_PLAYER ; $44f9
	script_wait_frames 40 ; $44fe
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, FACE_DOWN ; $4505
	script_set_text Text_HeadmasterTournamentSiteArrival ; $450c
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4512
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, ANIM_NOD ; $4517
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, ANIM_NOD ; $451e
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, ANIM_NOD ; $4525
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $452c
	script_wait_idle ACTOR_PLAYER ; $4533
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, ANIM_SHAKE ; $4538
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $453f
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4544
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, ANIM_NOD ; $4549
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS ; $4550
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS ; $4555
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, ANIM_NOD ; $455a
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS ; $4561
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS ; $4566
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, ANIM_BOUNCE ; $456b
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4572
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4577
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, ANIM_NOD ; $457c
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS ; $4583
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS ; $4588
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, ANIM_NOD ; $458d
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4594
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $4599
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, ANIM_NOD ; $459e
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, ANIM_NOD ; $45a5
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, ANIM_NOD ; $45ac
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS ; $45b3
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, ANIM_NOD ; $45b8
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER ; $45bf
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, FACE_RIGHT ; $45c4
	script_wait_frames 5 ; $45cb
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_HEADMASTER, FACE_UP, 8.0 ; $45d2
	script_wait_frames 60 ; $45dc
	script_face ACTOR_PLAYER, FACE_LEFT ; $45e3
	script_wait_frames 40 ; $45ea
	script_face ACTOR_PLAYER, FACE_DOWN ; $45f1
	script_wait_frames 40 ; $45f8
	script_face ACTOR_PLAYER, FACE_LEFT ; $45ff
	script_wait_frames 40 ; $4606
	script_face ACTOR_PLAYER, FACE_UP ; $460d
	script_wait_frames 40 ; $4614
	script_face ACTOR_PLAYER, FACE_RIGHT ; $461b
	script_wait_frames 40 ; $4622
	script_face ACTOR_PLAYER, FACE_UP ; $4629
	script_wait_frames 40 ; $4630
	script_move_target ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, 18.0, 16.0 ; $4637
	script_wait_move ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS ; $4642
	script_face ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, FACE_DOWN ; $4647
	script_speak ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS ; $464e
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4653
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, ANIM_NOD ; $465a
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, ANIM_NOD ; $4661
	script_wait_idle ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS ; $4668
	ld a, STORYLOC_TOURNAMENT ; $466d
	ld [wStoryModeCurrentLocation], a ; $466f
	ld a, ENTRY_TOURNAMENT_ARRIVAL ; $4672
	ld [wStoryModeEntryPoint], a ; $4674
	ld a, EXITTRIGGER_DIRECT ; $4677
	ld [wUnusedExitTriggerIdMirror], a ; $4679
	ld [wStoryModeExitTriggerRequest], a ; $467c
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_EMILY_SWEATS, FACE_UP, 10.0 ; $467f
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, FACE_UP, 10.0 ; $4689
	script_move_angle ACTOR_TOURNAMENT_SITE_RESPAWN_KEVIN_SWEATS, FACE_UP, 10.0 ; $4693
	script_move_angle ACTOR_PLAYER, FACE_UP, 10.0 ; $469d
	script_wait_frames 30 ; $46a7
	script_fade_out 8 ; $46ae
	call WaitFadeEnd ; $46b3
	ret ; $46b6
SetupTournamentSitePartnerActor:
	call LoadPlayerPartnerObjDefs_15 ; $46b7
	test_flag FLAG_DOUBLES ; $46ba
	jr z, .noPartner ; $46bd
	ld a, [wStoryPartnerGender] ; $46bf
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
	script_get_actor_state ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS ; $46ce
	ld c, l ; $46d3
	ld b, h ; $46d4
	farcall LoadActorObjectDefIfValid ; $46d5
	script_set_anim ACTOR_TOURNAMENT_SITE_RESPAWN_MARK_SWEATS, ANIM_WALK ; $46d8
	script_null_script ACTOR_PARTNER ; $46df
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $46e4
	ret ; $46ef
TournamentSiteEntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $46f0
	cp STORYENTRY_NONE ; $46f3
	jp z, .done ; $46f5
	test_flag FLAG_DOUBLES ; $46f8
	jr z, .playerWalkIn ; $46fb
	script_set_speed ACTOR_PARTNER, 7.96875 ; $46fd
	ld a, [wStoryModeEntryPoint] ; $4705
	dec a ; $4708
	ld_hl_indexed TournamentSiteEntryWalkInFacings + 4 ; $4709
	ld b, [hl] ; $4710
	script_move_angle ACTOR_PARTNER, b, 2.0 ; $4711
	script_wait_move ACTOR_PARTNER ; $471a
	ld a, [wStoryModeEntryPoint] ; $471f
	dec a ; $4722
	ld_hl_indexed TournamentSiteEntryWalkInFacings ; $4723
	ld b, [hl] ; $472a
	script_face ACTOR_PARTNER, b ; $472b
	script_set_speed ACTOR_PARTNER, 0.5 ; $4731
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 0.5 ; $4739
	ld a, [wStoryModeEntryPoint] ; $4741
	dec a ; $4744
	ld_hl_indexed TournamentSiteEntryWalkInFacings ; $4745
	ld b, [hl] ; $474c
	script_move_angle ACTOR_PLAYER, b, 2.0 ; $474d
.done:
	ret ; $4756
TournamentSiteEntryWalkInFacings:
	; $4757, 8 bytes (enum:FACE:8)
	db FACE_LEFT, FACE_RIGHT, FACE_DOWN, FACE_UP, FACE_RIGHT, FACE_LEFT, FACE_UP, FACE_DOWN ; 0x00
	twin load_player_partner_obj_defs, 15 ; $475f LoadPlayerPartnerObjDefs_15
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
	map_actor $0000, ActorScript_15_03, 11.0, 7.0, FACE_DOWN, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $03, TRAINING_COURT_STUDENT_CAP_BOY_1
	map_actor $0000, ActorScript_15_03, 11.0, 23.0, FACE_UP, OBJ_STUDENT_PONYTAIL_GIRL, ANIM_WALK, $07, TRAINING_COURT_STUDENT_PONYTAIL_GIRL_1
	map_actor $0000, ActorScript_15_03, 14.0, 23.0, FACE_UP, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $05, TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_1
	map_actor $0000, ActorScript_15_22, 19.0, 11.0, FACE_LEFT, OBJ_BOB, ANIM_WALK, $00, TRAINING_COURT_BOB_1
	map_actor $0000, ActorScript_15_22, 19.0, 21.0, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, TRAINING_COURT_CURT
	map_actor $0000, ActorScript_15_02, 11.0, 33.0, FACE_DOWN, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $03, TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_2
	map_actor $0000, ActorScript_15_02, 13.0, 33.0, FACE_DOWN, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $05, TRAINING_COURT_STUDENT_SIDE_PART_BOY_1
	map_actor $0000, ActorScript_15_02, 12.0, 45.0, FACE_UP, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $04, TRAINING_COURT_STUDENT_CAP_BOY_2
	map_actor $0000, ActorScript_15_25, 7.0, 45.0, FACE_RIGHT, OBJ_PAM, ANIM_WALK, $07, TRAINING_COURT_PAM
	map_actor $0000, ActorScript_15_22, 19.0, 39.0, FACE_DOWN, OBJ_ALLIE, ANIM_WALK, $06, TRAINING_COURT_ALLIE
	map_actor $0000, ActorScript_15_22, 19.0, 41.0, FACE_UP, OBJ_BOB, ANIM_WALK, $04, TRAINING_COURT_BOB_2
	map_actor $0000, ActorScript_15_02, 51.0, 42.0, FACE_UP, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $06, TRAINING_COURT_STUDENT_SIDE_PART_BOY_2
	map_actor $0000, ActorScript_15_02, 53.0, 36.0, FACE_DOWN, OBJ_STUDENT_PONYTAIL_GIRL, ANIM_WALK, $03, TRAINING_COURT_STUDENT_PONYTAIL_GIRL_2
	map_actor $0000, ActorScript_15_02, 53.0, 42.0, FACE_UP, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $07, TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_3
	map_actor $0000, ActorScript_15_22, 45.0, 33.0, FACE_RIGHT, OBJ_BRIAN, ANIM_WALK, $07, TRAINING_COURT_BRIAN
	map_actor $0000, ActorScript_15_22, 45.0, 41.0, FACE_RIGHT, OBJ_BETH, ANIM_WALK, $07, TRAINING_COURT_BETH
	map_actor $0000, ActorScript_15_01, 63.0, 3.0, FACE_DOWN, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $07, TRAINING_COURT_STUDENT_CAP_BOY_3
	map_actor $0000, ActorScript_15_22, 63.0, 5.0, FACE_DOWN, OBJ_WATER_SPRITE, ANIM_WALK, $00, TRAINING_COURT_WATER_SPRITE
	map_actor $0000, ActorScript_15_22, 63.0, 7.0, FACE_DOWN, OBJ_RACKET, ANIM_WALK, $05, TRAINING_COURT_RACKET
	map_actor $0000, ActorScript_15_22, 63.0, 9.0, FACE_DOWN, OBJ_BALLOON_SCRIBBLE, ANIM_WALK, $00, TRAINING_COURT_BALLOON_SCRIBBLE
	map_actor $0000, ActorScript_15_22, 63.0, 11.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, TRAINING_COURT_BALLOON_SWEAT
	map_actor_end
TrainingCourtEntryPoints_15:
	; $48d4, 57 bytes (map_entries)
	map_entry $01, FACE_RIGHT, 9.0, 55.0, TrainingCourtArrival01_15, TRAINING_COURT_FROM_RESTAURANT_PLAZA
	map_entry $02, FACE_DOWN, 19.0, 19.0, $0000 ; debug warp only
	map_entry $09, FACE_DOWN, 19.0, 19.0, $0000, TRAINING_COURT_PENDING_LESSON
	map_entry $0a, FACE_UP, 19.0, 19.0, $0000, TRAINING_COURT_DRILL_RESULT
	map_entry $0b, FACE_DOWN, 19.0, 19.0, $0000, TRAINING_COURT_AT_SERVE_COACH
	map_entry $0c, FACE_UP, 45.0, 43.0, $0000, TRAINING_COURT_AT_NET_COACH
	map_entry $0d, FACE_LEFT, 21.0, 41.0, $0000, TRAINING_COURT_AT_RETURN_COACH
	entry_id TRAINING_COURT_TOUR, $0f
	db $ff
TrainingCourtArrival01_15:
	ld a, [wStoryModeEntryPoint] ; $490d
	cp STORYENTRY_NONE ; $4910
	jp z, .done ; $4912
	call ClearTrainingCourtNpcFlags ; $4915
	test_flag FLAG_DOUBLES ; $4918
	jr z, .playerWalkIn ; $491b
	script_set_speed ACTOR_PARTNER, 7.96875 ; $491d
	script_move_angle ACTOR_PARTNER, FACE_LEFT, 2.0 ; $4925
	script_wait_move ACTOR_PARTNER ; $492f
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4934
	script_set_speed ACTOR_PARTNER, 0.5 ; $493b
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 0.5 ; $4943
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, 2.0 ; $494b
.done:
	ret ; $4955
TrainingCourtExitTriggers_15:
	; $4956, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, ClearTrainingCourtNpcFlags, STORYLOC_RESTAURANT_PLAZA, ENTRY_RESTAURANT_PLAZA_FROM_TRAINING_COURT, TRAINING_COURT_TO_RESTAURANT_PLAZA
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_15, STORYLOC_RESTAURANT_PLAZA, ENTRY_RESTAURANT_PLAZA_SERVICE_ACE_INTRO, TRAINING_COURT_TOUR
	db $ff
ClearTrainingCourtNpcFlags:
	clear_flag FLAG_SERVE_CHALLENGER_DEFEATED ; $4967
	clear_flag FLAG_SERVE_COACH_LESSON_PASSED_THIS_VISIT ; $496a
	clear_flag FLAG_NET_CHALLENGER_DEFEATED ; $496d
	clear_flag FLAG_NET_COACH_LESSON_PASSED_THIS_VISIT ; $4970
	clear_flag FLAG_STROKE_CHALLENGER_DEFEATED ; $4973
	clear_flag FLAG_RETURN_COACH_LESSON_PASSED_THIS_VISIT ; $4976
	ret ; $4979
TrainingCourtNpc03_15:
	ld a, [wMapSceneStage] ; $497a
	add a ; $497d
	ld_hl_indexed TrainingCourtNpc03TextIds ; $497e
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	farcall InitDialogueTextCursor ; $4988
	script_speak ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_1 ; $498b
	ret ; $4990
TrainingCourtNpc03TextIds:
	; $4991, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtServeStudentImproveServe ; record 0
	dw Text_CourtServeStudentSeniorServe ; record 1
	dw Text_CourtServeStudentDownLineDefined ; record 2
	dw Text_CourtServeStudentDownLineDefined ; record 3
	dw Text_CourtServeStudentDownLineDefined ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc04_15:
	ld a, [wMapSceneStage] ; $499b
	add a ; $499e
	ld_hl_indexed TrainingCourtNpc04TextIds ; $499f
	ld a, [hl+] ; $49a6
	ld h, [hl] ; $49a7
	ld l, a ; $49a8
	farcall InitDialogueTextCursor ; $49a9
	script_speak ACTOR_TRAINING_COURT_STUDENT_PONYTAIL_GIRL_1 ; $49ac
	ret ; $49b1
TrainingCourtNpc04TextIds:
	; $49b2, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtServeStudentGoodToss ; record 0
	dw Text_CourtServeStudentCornerServe ; record 1
	dw Text_CourtServeStudentAngledVsLine ; record 2
	dw Text_CourtServeStudentAngledVsLine ; record 3
	dw Text_CourtServeStudentAngledVsLine ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc05_15:
	ld a, [wMapSceneStage] ; $49bc
	add a ; $49bf
	ld_hl_indexed TrainingCourtNpc05TextIds ; $49c0
	ld a, [hl+] ; $49c7
	ld h, [hl] ; $49c8
	ld l, a ; $49c9
	farcall InitDialogueTextCursor ; $49ca
	script_speak ACTOR_TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_1 ; $49cd
	ret ; $49d2
TrainingCourtNpc05TextIds:
	; $49d3, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtServeStudentFirstServeTip ; record 0
	dw Text_CourtServeStudentSpinByCorner ; record 1
	dw Text_CourtServeStudentFirstServeLine ; record 2
	dw Text_CourtServeStudentFirstServeLine ; record 3
	dw Text_CourtServeStudentFirstServeLine ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc08_15:
	ld a, [wMapSceneStage] ; $49dd
	add a ; $49e0
	ld_hl_indexed TrainingCourtNpc08TextIds ; $49e1
	ld a, [hl+] ; $49e8
	ld h, [hl] ; $49e9
	ld l, a ; $49ea
	farcall InitDialogueTextCursor ; $49eb
	script_speak ACTOR_TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_2 ; $49ee
	ret ; $49f3
TrainingCourtNpc08TextIds:
	; $49f4, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtStrokeStudentStrokeBasics ; record 0
	dw Text_CourtStrokeStudentLobVsNet ; record 1
	dw Text_CourtStrokeStudentBreakService ; record 2
	dw Text_CourtStrokeStudentBreakService ; record 3
	dw Text_CourtStrokeStudentBreakService ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc09_15:
	ld a, [wMapSceneStage] ; $49fe
	add a ; $4a01
	ld_hl_indexed TrainingCourtNpc09TextIds_15 ; $4a02
	ld a, [hl+] ; $4a09
	ld h, [hl] ; $4a0a
	ld l, a ; $4a0b
	farcall InitDialogueTextCursor ; $4a0c
	script_speak ACTOR_TRAINING_COURT_STUDENT_SIDE_PART_BOY_1 ; $4a0f
	ret ; $4a14
TrainingCourtNpc09TextIds_15:
	; $4a15, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtStrokeStudentTopspin ; record 0
	dw Text_CourtStrokeStudentLobDeep ; record 1
	dw Text_CourtStrokeStudentPressureServer ; record 2
	dw Text_CourtStrokeStudentPressureServer ; record 3
	dw Text_CourtStrokeStudentPressureServer ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc0A_15:
	ld a, [wMapSceneStage] ; $4a1f
	add a ; $4a22
	ld_hl_indexed TrainingCourtNpc0ATextIds ; $4a23
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	farcall InitDialogueTextCursor ; $4a2d
	script_speak ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_2 ; $4a30
	ret ; $4a35
TrainingCourtNpc0ATextIds:
	; $4a36, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtStrokeStudentRallyPatience ; record 0
	dw Text_CourtStrokeStudentShortLobRisk ; record 1
	dw Text_CourtStrokeStudentPassingShotAim ; record 2
	dw Text_CourtStrokeStudentPassingShotAim ; record 3
	dw Text_CourtStrokeStudentPassingShotAim ; record 4
	assert_table_length NUM_STORYTIERS
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
	script_speak_restore ACTOR_TRAINING_COURT_PAM ; $4a58
	farcall RunDialogueYesNoPrompt ; $4a5d
	farcall ScriptCloseDialogueWindow ; $4a60
	script_wait_frames 5 ; $4a63
	and a ; $4a6a
	jr z, .speak ; $4a6b
	farcall AdvanceDialogueTextCursor ; $4a6d
.speak:
	script_speak ACTOR_TRAINING_COURT_PAM ; $4a70
	ret ; $4a75
TrainingCourtNpc0BTextIds:
	; $4a76, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtStrokeStudentRallySecret ; record 0
	dw Text_CourtStrokeStudentHighDeepLob ; record 1
	dw Text_CourtStrokeStudentPassingShot ; record 2
	dw Text_CourtStrokeStudentPassingShot ; record 3
	dw Text_CourtStrokeStudentPassingShot ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc0E_15:
	ld a, [wMapSceneStage] ; $4a80
	add a ; $4a83
	ld_hl_indexed TrainingCourtNpc0ETextIds ; $4a84
	ld a, [hl+] ; $4a8b
	ld h, [hl] ; $4a8c
	ld l, a ; $4a8d
	farcall InitDialogueTextCursor ; $4a8e
	script_speak ACTOR_TRAINING_COURT_STUDENT_PONYTAIL_GIRL_2 ; $4a91
	ret ; $4a96
TrainingCourtNpc0ETextIds:
	; $4a97, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtNetStudentNetPlayWins ; record 0
	dw Text_CourtNetStudentNetPressure ; record 1
	dw Text_CourtNetStudentMixTechniques ; record 2
	dw Text_CourtNetStudentMixTechniques ; record 3
	dw Text_CourtNetStudentMixTechniques ; record 4
	assert_table_length NUM_STORYTIERS
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
	script_speak_restore ACTOR_TRAINING_COURT_STUDENT_PONYTAIL_GIRL_2 ; $4ab9
	farcall RunDialogueYesNoPrompt ; $4abe
	farcall ScriptCloseDialogueWindow ; $4ac1
	script_wait_frames 5 ; $4ac4
	and a ; $4acb
	jr z, .speak ; $4acc
	farcall AdvanceDialogueTextCursor ; $4ace
.speak:
	script_speak ACTOR_TRAINING_COURT_STUDENT_PONYTAIL_GIRL_2 ; $4ad1
	ret ; $4ad6
TrainingCourtNpc0FTextIds:
	; $4ad7, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtNetStudentTooCloseToNet ; record 0
	dw Text_CourtNetStudentUseSmashes ; record 1
	dw Text_CourtNetStudentDropShotTip ; record 2
	dw Text_CourtNetStudentDropShotTip ; record 3
	dw Text_CourtNetStudentDropShotTip ; record 4
	assert_table_length NUM_STORYTIERS
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
	script_speak_restore ACTOR_TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_3 ; $4af9
	farcall RunDialogueYesNoPrompt ; $4afe
	farcall ScriptCloseDialogueWindow ; $4b01
	script_wait_frames 5 ; $4b04
	and a ; $4b0b
	jr z, .speak ; $4b0c
	farcall AdvanceDialogueTextCursor ; $4b0e
.speak:
	script_speak ACTOR_TRAINING_COURT_STUDENT_WAVY_HAIR_GIRL_3 ; $4b11
	ret ; $4b16
TrainingCourtNpc10TextIds_15:
	; $4b17, 10 bytes (text_ids)
	table_width 2
	dw Text_CourtNetStudentWatchForLobs ; record 0
	dw Text_CourtNetStudentWeakLobSmash ; record 1
	dw Text_CourtNetStudentDropBallHard ; record 2
	dw Text_CourtNetStudentDropBallHard ; record 3
	dw Text_CourtNetStudentDropBallHard ; record 4
	assert_table_length NUM_STORYTIERS
TrainingCourtNpc13_15:
	script_move_player_to_actor ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4b21
	farcall WaitPlayerMoveDone ; $4b28
	script_get_actor_state ACTOR_PLAYER ; $4b2b
	ld a, $01 ; $4b30
	ld e, l ; $4b32
	ld d, h ; $4b33
	ld hl, ACTORF_ANIM_RATE ; $4b34
	add hl, de ; $4b37
	ld [hl], a ; $4b38
	script_set_text Text_SwingStudentPracticeSwing ; $4b39
	script_speak_restore ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4b3f
	farcall RunDialogueYesNoPrompt ; $4b44
	farcall ScriptCloseDialogueWindow ; $4b47
	script_wait_frames 5 ; $4b4a
	and a ; $4b51
	jp nz, .setFlag ; $4b52
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4b55
	script_wait_idle ACTOR_PLAYER ; $4b5c
	script_speak ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4b61
	script_wait_frames 10 ; $4b66
	ret ; $4b6d
.setFlag:
	set_flag FLAG_SWING_PRACTICE_KID_LEFT ; $4b6e
	script_set_anim ACTOR_PLAYER, ANIM_SHAKE ; $4b71
	script_wait_idle ACTOR_PLAYER ; $4b78
	script_set_anim ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, ANIM_WALK ; $4b7d
	script_wait_idle ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4b84
	script_face ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, FACE_LEFT ; $4b89
	script_get_actor_state ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4b90
	ld a, $02 ; $4b95
	ld e, l ; $4b97
	ld d, h ; $4b98
	ld hl, ACTORF_ANIM_RATE ; $4b99
	add hl, de ; $4b9c
	ld [hl], a ; $4b9d
	script_set_anim ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, ANIM_BOUNCE ; $4b9e
	script_wait_idle ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4ba5
	script_get_actor_state ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4baa
	ld a, $01 ; $4baf
	ld e, l ; $4bb1
	ld d, h ; $4bb2
	ld hl, ACTORF_ANIM_RATE ; $4bb3
	add hl, de ; $4bb6
	ld [hl], a ; $4bb7
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 54.5, 13.5 ; $4bb8
	sound SFX_APPEAR1 ; $4bc3
	farcall AdvanceDialogueTextCursor ; $4bc5
	script_speak ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4bc8
	script_set_speed ACTOR_PLAYER, 0.5625 ; $4bcd
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4bd5
	script_wait_idle ACTOR_PLAYER ; $4bdc
	script_move_target ACTOR_PLAYER, 51.0, 15.0 ; $4be1
	script_wait_move ACTOR_PLAYER ; $4bec
	script_face ACTOR_PLAYER, FACE_DOWN ; $4bf1
	script_wait_frames 10 ; $4bf8
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 63.0, 63.0 ; $4bff
	script_wait_frames 20 ; $4c0a
	script_set_anim ACTOR_PLAYER, ANIM_SWING_LOOP ; $4c11
	script_wait_frames 180 ; $4c18
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $4c1f
	script_wait_idle ACTOR_PLAYER ; $4c26
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4c2b
	script_face ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, FACE_DOWN ; $4c32
	script_wait_frames 1 ; $4c39
	script_set_anim ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, ANIM_SHAKE ; $4c40
	script_wait_idle ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4c47
	script_face ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, FACE_LEFT ; $4c4c
	script_wait_frames 1 ; $4c53
	script_speak ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4c5a
	script_wait_frames 30 ; $4c5f
	script_set_speed ACTOR_PLAYER, 1.0 ; $4c66
	script_face ACTOR_PLAYER, FACE_DOWN ; $4c6e
	script_wait_frames 1 ; $4c75
	script_lock_facing ACTOR_PLAYER ; $4c7c
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4c83
	script_move_target ACTOR_PLAYER, 51.0, 13.0 ; $4c8a
	script_move_target ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, 51.0, 15.0 ; $4c95
	script_wait_move ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4ca0
	script_move_target ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, 51.0, 21.0 ; $4ca5
	script_wait_move ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4cb0
	script_move_target ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, 31.0, 21.0 ; $4cb5
	script_wait_move ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3 ; $4cc0
	script_set_position ACTOR_TRAINING_COURT_STUDENT_CAP_BOY_3, 63.0, 63.0 ; $4cc5
	script_unlock_facing ACTOR_PLAYER ; $4cd0
	script_face ACTOR_PLAYER, FACE_DOWN ; $4cd7
	script_get_actor_state ACTOR_PLAYER ; $4cde
	ld a, $02 ; $4ce3
	ld e, l ; $4ce5
	ld d, h ; $4ce6
	ld hl, ACTORF_ANIM_RATE ; $4ce7
	add hl, de ; $4cea
	ld [hl], a ; $4ceb
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4cec
	script_set_position ACTOR_TRAINING_COURT_BALLOON_SCRIBBLE, 52.5, 11.5 ; $4cf3
	sound SFX_APPEAR1 ; $4cfe
	script_wait_frames 80 ; $4d00
