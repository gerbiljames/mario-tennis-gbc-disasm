GetMinigameDrillId:
	ld hl, MinigameDrillIdTable ; $56e9
	add_hl_a ; $56ec
	ld a, [hl] ; $56f1
	ret ; $56f2
MinigameDrillIdTable:
	; $56f3, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
CopyExhibitionCharSlotIds:
	push af ; $56fc
	push_wram_bank WRAM_SCREEN ; $56fd
	ld hl, wCharSelectSlotChars ; $5706
	ld de, wMatchSlotCharRefs ; $5709
	ld a, [hl+] ; $570c
	ld [de], a ; $570d
	inc de ; $570e
	ld a, [hl+] ; $570f
	ld [de], a ; $5710
	inc de ; $5711
	ld a, [hl+] ; $5712
	ld [de], a ; $5713
	inc de ; $5714
	ld a, [hl+] ; $5715
	ld [de], a ; $5716
	pop_wram_bank ; $5717
	pop af ; $571c
	ret ; $571d
Unused_10_CheckAnyStorySlot:
	ld a, [wCurrentStorySlot] ; $571e
	push af ; $5721
	xor a ; $5722
	ld [wCurrentStorySlot], a ; $5723
	farcall CheckStorySlot ; $5726
	cp $fe ; $5729
	jr nz, .restore ; $572b
	ld a, $01 ; $572d
	ld [wCurrentStorySlot], a ; $572f
	farcall CheckStorySlot ; $5732
	cp $fe ; $5735
	jr nz, .restore ; $5737
	ld a, $02 ; $5739
	ld [wCurrentStorySlot], a ; $573b
	farcall CheckStorySlot ; $573e
	cp $fe ; $5741
	jr nz, .restore ; $5743
	pop af ; $5745
	xor a ; $5746
	ld [wCurrentStorySlot], a ; $5747
	ret ; $574a
.restore:
	pop af ; $574b
	ld [wCurrentStorySlot], a ; $574c
	ld a, $01 ; $574f
	ret ; $5751
GetStoryContinueDestination:
	test_flag FLAG_DOUBLES ; $5752
	jr nz, .checkFlag ; $5755
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $5757
	ld a, $02 ; $575a
	jr z, .done ; $575c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $575e
	ld a, $04 ; $5761
	jr z, .done ; $5763
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5765
	jr nz, .dormSingles
	ap_pass AP_ARC_SINGLES, 4
	ld a, $05 ; $5768
	jr nz, .done
.dormSingles:
	ld a, $02 ; $576c
	jr .done ; $576e
.checkFlag:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $5770
	ld a, $02 ; $5773
	jr z, .done ; $5775
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $5777
	ld a, $04 ; $577a
	jr z, .done ; $577c
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $577e
	jr nz, .dormDoubles
	ap_pass AP_ARC_DOUBLES, 4
	ld a, $05 ; $5781
	jr nz, .done
.dormDoubles:
	ld a, $02 ; $5785
	jr .done ; $5787
.done:
	ret ; $5789
ConfirmDiscardSuspendedExhibMatch:
	push af ; $578a
	push bc ; $578b
	farcall ReadExhibitionSaveBlock ; $578c
	bit 7, a ; $578f
	jr nz, .done ; $5791
	ld a, [wSaveAndQuitRequest] ; $5793
	or a ; $5796
	jr z, .done ; $5797
	ld a, [wCurrentStorySlot] ; $5799
	ld b, a ; $579c
	ld a, [wMatchSlotCharRefs] ; $579d
	bit 7, a ; $57a0
	jr z, .checkSlot2 ; $57a2
	and $7f ; $57a4
	srl a ; $57a6
	cp b ; $57a8
	jr z, .prompt ; $57a9
.checkSlot2:
	ld a, [wMatchSlotCharRefs + 1] ; $57ab
	bit 7, a ; $57ae
	jr z, .checkSlot3 ; $57b0
	and $7f ; $57b2
	srl a ; $57b4
	cp b ; $57b6
	jr z, .prompt ; $57b7
.checkSlot3:
	ld a, [wMatchSlotCharRefs + 2] ; $57b9
	bit 7, a ; $57bc
	jr z, .checkSlot4 ; $57be
	and $7f ; $57c0
	srl a ; $57c2
	cp b ; $57c4
	jr z, .prompt ; $57c5
.checkSlot4:
	ld a, [wMatchSlotCharRefs + 3] ; $57c7
	bit 7, a ; $57ca
	jr z, .noMatch ; $57cc
	and $7f ; $57ce
	srl a ; $57d0
	cp b ; $57d2
	jr z, .prompt ; $57d3
.noMatch:
	jr .done ; $57d5
.prompt:
	ld b, $02 ; $57d7
	farcall RunEraseDataConfirmMenu ; $57d9
	or a ; $57dc
	jr z, .discarded ; $57dd
	xor a ; $57df
	ld [wSaveAndQuitRequest], a ; $57e0
	ld [wKeepMatchStatsFlag], a ; $57e3
	farcall WriteExhibitionSaveBlock ; $57e6
	pop bc ; $57e9
	pop af ; $57ea
	ld a, $00 ; $57eb
	ret ; $57ed
.discarded:
	pop bc ; $57ee
	pop af ; $57ef
	ld a, $01 ; $57f0
	ret ; $57f2
.done:
	pop bc ; $57f3
	pop af ; $57f4
	ret ; $57f5
CafeteriaMapScripts_10:
	; $57f6, 14 bytes (map_tree)
	dw CafeteriaEntryPoints_10 ; slot 0 EntryPoints
	dw CafeteriaExitTriggers_10 ; slot 1 ExitTriggers
	dw CafeteriaActors_10 ; slot 2 Actors
	dw CafeteriaNpcScripts_10 ; slot 3 NpcScripts
	dw CafeteriaFacingScripts_10 ; slot 4 FacingScripts
	dw CafeteriaTileTriggers_10 ; slot 5 TileTriggers
	dw CafeteriaInitScript_10 ; slot 6 InitScript
CafeteriaActors_10:
	; $5804, 108 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, 59.0, 55.0, FACE_DOWN, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $00, CAFETERIA_STUDENT_LONG_HAIR_1
	map_actor $0000, ActorScript_10_2, 61.0, 57.0, FACE_LEFT, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $05, CAFETERIA_STUDENT_LONG_HAIR_2
	map_actor $0000, ActorScript_10_2, 61.0, 59.0, FACE_LEFT, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $00, CAFETERIA_STUDENT_PIGTAILS_GIRL_1
	map_actor $0000, ActorScript_10_2, 47.0, 49.0, FACE_RIGHT, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $07, CAFETERIA_STUDENT_PIGTAILS_GIRL_2
	map_actor $0000, ActorScript_10_2, 51.0, 49.0, FACE_LEFT, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $00, CAFETERIA_STUDENT_BLACK_HAIR_BOY_1
	map_actor $0000, ActorScript_10_2, 55.0, 47.0, FACE_RIGHT, OBJ_STUDENT_HEADBAND_BOY, ANIM_WALK, $00, CAFETERIA_STUDENT_HEADBAND_BOY
	map_actor $0000, ActorScript_10_2, 59.0, 47.0, FACE_LEFT, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $04, CAFETERIA_STUDENT_BLACK_HAIR_BOY_2
	map_actor_end
CafeteriaEntryPoints_10:
	; $5870, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, 39.0, 55.0, $0000
	db $ff
CafeteriaExitTriggers_10:
	; $5879, 9 bytes (map_scripts:exit)
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_RESTAURANT, $02
	db $ff
CafeteriaNpc03_10:
	ld a, [wMapSceneStage] ; $5882
	add a ; $5885
	ld_hl_indexed CafeteriaNpc03TextIds ; $5886
	ld a, [hl+] ; $588d
	ld h, [hl] ; $588e
	ld l, a ; $588f
	farcall InitDialogueTextCursor ; $5890
	script_speak ACTOR_CAFETERIA_STUDENT_LONG_HAIR_1 ; $5893
	ret ; $5898
CafeteriaNpc03TextIds:
	; $5899, 20 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaSeniorPlaySmart ; record 0
	dw Text_CafeteriaDoublesFormations ; record 1
	dw Text_CafeteriaSeniorAttackNet ; record 2
	dw Text_CafeteriaDoublesForwardAttackNet ; record 3
	dw Text_CafeteriaWonderTravelingTeam ; record 4
	dw Text_CafeteriaWonderTravelingTeam ; record 5
	dw Text_CafeteriaOpenFindYourZone ; record 6
	dw Text_CafeteriaOpenFindYourZone ; record 7
	dw Text_CafeteriaBoldRefinedGame ; record 8
	dw Text_CafeteriaBoldRefinedGame ; record 9
	assert_table_length NUM_STORYRANKS
CafeteriaNpc04_10:
	ld a, [wMapSceneStage2] ; $58ad
	add a ; $58b0
	ld_hl_indexed CafeteriaNpc04TextIds ; $58b1
	ld a, [hl+] ; $58b8
	ld h, [hl] ; $58b9
	ld l, a ; $58ba
	farcall InitDialogueTextCursor ; $58bb
	ld a, [wMapSceneStage2] ; $58be
	cp STORYTIER_ISLAND_OPEN ; $58c1
	jr c, .speak ; $58c3
	ld a, [wMapSceneStage2] ; $58c5
	cp STORYTIER_COMPLETE ; $58c8
	jr z, .prompt ; $58ca
	script_speak_restore ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2 ; $58cc
	farcall RunDialogueYesNoPrompt ; $58d1
	farcall ScriptCloseDialogueWindow ; $58d4
	script_wait_frames 5 ; $58d7
	and a ; $58de
	jr z, .speak ; $58df
	farcall AdvanceDialogueTextCursor ; $58e1
.speak:
	script_speak ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2 ; $58e4
	ret ; $58e9
.prompt:
	ld a, [wMapSceneStage] ; $58ea
	cp STORYRANK_DOUBLES_COMPLETE ; $58ed
	jr nz, .askQuestion ; $58ef
	farcall AdvanceDialogueTextCursor ; $58f1
.askQuestion:
	script_speak_restore ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2 ; $58f4
	farcall RunDialogueYesNoPrompt ; $58f9
	farcall ScriptCloseDialogueWindow ; $58fc
	script_wait_frames 5 ; $58ff
	and a ; $5906
	jr z, .declined ; $5907
	script_set_text Text_CafeteriaZoneAnswerYesPlaceholder ; $5909
	script_speak ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2 ; $590f
	ret ; $5914
.declined:
	script_set_text Text_CafeteriaZoneAnswerNoPlaceholder ; $5915
	script_speak ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2 ; $591b
	ret ; $5920
CafeteriaNpc04TextIds:
	; $5921, 10 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaVarsityArmStrength ; record 0
	dw Text_CafeteriaTopspinAndSlice ; record 1
	dw Text_CafeteriaReturnTopspinWithSlice ; record 2
	dw Text_CafeteriaWhatIsAZone ; record 3
	dw Text_CafeteriaWonByZone ; record 4
	assert_table_length NUM_STORYTIERS
CafeteriaNpc05_10:
	ld a, [wMapSceneStage2] ; $592b
	add a ; $592e
	ld_hl_indexed CafeteriaNpc05TextIds ; $592f
	ld a, [hl+] ; $5936
	ld h, [hl] ; $5937
	ld l, a ; $5938
	farcall InitDialogueTextCursor ; $5939
	ld a, [wMapSceneStage2] ; $593c
	cp STORYTIER_JUNIOR_CHAMP ; $593f
	jr nz, .speak ; $5941
	script_speak_restore ACTOR_CAFETERIA_STUDENT_PIGTAILS_GIRL_1 ; $5943
	farcall RunDialogueYesNoPrompt ; $5948
	farcall ScriptCloseDialogueWindow ; $594b
	script_wait_frames 5 ; $594e
	and a ; $5955
	jr z, .speak ; $5956
	farcall AdvanceDialogueTextCursor ; $5958
.speak:
	script_speak ACTOR_CAFETERIA_STUDENT_PIGTAILS_GIRL_1 ; $595b
	ret ; $5960
CafeteriaNpc05TextIds:
	; $5961, 10 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaBoysAndGirlsPlay ; record 0
	dw Text_CafeteriaHitHardAtFirst ; record 1
	dw Text_CafeteriaWinWithWeakShot ; record 2
	dw Text_CafeteriaBallFrozenMidair ; record 3
	dw Text_CafeteriaPigtailsChampPlaceholder ; record 4
	assert_table_length NUM_STORYTIERS
CafeteriaNpc06_10:
	ld a, [wMapSceneStage] ; $596b
	add a ; $596e
	ld_hl_indexed CafeteriaNpc06TextIds ; $596f
	ld a, [hl+] ; $5976
	ld h, [hl] ; $5977
	ld l, a ; $5978
	farcall InitDialogueTextCursor ; $5979
	script_speak ACTOR_CAFETERIA_STUDENT_PIGTAILS_GIRL_2 ; $597c
	ret ; $5981
CafeteriaNpc06TextIds:
	; $5982, 20 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaMixedRankPartners ; record 0
	dw Text_CafeteriaMixedRankPartners ; record 1
	dw Text_CafeteriaSeniorBetterOpponents ; record 2
	dw Text_CafeteriaSeniorDoublesBetterOpponents ; record 3
	dw Text_CafeteriaTravelingTeamCompetition ; record 4
	dw Text_CafeteriaDoublesTravelingCompetition ; record 5
	dw Text_CafeteriaLargeRacket ; record 6
	dw Text_CafeteriaRepairCounterShoes ; record 7
	dw Text_CafeteriaLargeRacket ; record 8
	dw Text_CafeteriaRepairCounterShoes ; record 9
	assert_table_length NUM_STORYRANKS
CafeteriaNpc07_10:
	ld a, [wMapSceneStage] ; $5996
	add a ; $5999
	ld_hl_indexed CafeteriaNpc07TextIds ; $599a
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	farcall InitDialogueTextCursor ; $59a4
	script_speak ACTOR_CAFETERIA_STUDENT_BLACK_HAIR_BOY_1 ; $59a7
	ret ; $59ac
CafeteriaNpc07TextIds:
	; $59ad, 20 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaPartnerMakesItEasier ; record 0
	dw Text_CafeteriaPartnerMakesItEasier ; record 1
	dw Text_CafeteriaMovedUpToSenior ; record 2
	dw Text_CafeteriaTeamMovedUpToSenior ; record 3
	dw Text_CafeteriaMoreCompetitionBetterPlay ; record 4
	dw Text_CafeteriaDoublesVarsityCompetition ; record 5
	dw Text_CafeteriaSmallRacket ; record 6
	dw Text_CafeteriaLightShoes ; record 7
	dw Text_CafeteriaSmallRacket ; record 8
	dw Text_CafeteriaLightShoes ; record 9
	assert_table_length NUM_STORYRANKS
CafeteriaNpc08_10:
	ld a, [wMapSceneStage] ; $59c1
	add a ; $59c4
	ld_hl_indexed CafeteriaNpc08TextIds ; $59c5
	ld a, [hl+] ; $59cc
	ld h, [hl] ; $59cd
	ld l, a ; $59ce
	farcall InitDialogueTextCursor ; $59cf
	script_speak ACTOR_CAFETERIA_STUDENT_HEADBAND_BOY ; $59d2
	ret ; $59d7
CafeteriaNpc08TextIds:
	; $59d8, 20 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaVarsityCompetitors ; record 0
	dw Text_CafeteriaVarsityCompetitors ; record 1
	dw Text_CafeteriaReadYourOpponent ; record 2
	dw Text_CafeteriaReadYourOpponent ; record 3
	dw Text_CafeteriaCantTellYouRivals ; record 4
	dw Text_CafeteriaCantTellYouTwoRivals ; record 5
	dw Text_CafeteriaIronRacketTraining ; record 6
	dw Text_CafeteriaRepairCounterChoose ; record 7
	dw Text_CafeteriaHeadbandChampPlaceholder ; record 8
	dw Text_CafeteriaRepairCounterChoose ; record 9
	assert_table_length NUM_STORYRANKS
CafeteriaNpc09_10:
	ld a, [wMapSceneStage] ; $59ec
	add a ; $59ef
	ld_hl_indexed CafeteriaNpc09TextIds ; $59f0
	ld a, [hl+] ; $59f7
	ld h, [hl] ; $59f8
	ld l, a ; $59f9
	farcall InitDialogueTextCursor ; $59fa
	script_speak ACTOR_CAFETERIA_STUDENT_BLACK_HAIR_BOY_2 ; $59fd
	ret ; $5a02
CafeteriaNpc09TextIds:
	; $5a03, 20 bytes (text_ids)
	table_width 2
	dw Text_CafeteriaDreamOfPros ; record 0
	dw Text_CafeteriaDreamOfPros ; record 1
	dw Text_CafeteriaSliceTopspinCorners ; record 2
	dw Text_CafeteriaSliceTopspinCorners ; record 3
	dw Text_CafeteriaVarsityPlayManyMatches ; record 4
	dw Text_CafeteriaVarsityPlayManyMatches ; record 5
	dw Text_CafeteriaIronGearFreedom ; record 6
	dw Text_CafeteriaRepairCounterImprove ; record 7
	dw Text_CafeteriaIronGearFreedom ; record 8
	dw Text_CafeteriaRepairCounterImprove ; record 9
	assert_table_length NUM_STORYRANKS
CafeteriaNpcScripts_10:
	; $5a17, 57 bytes (map_scripts)
	map_script ACTOR_CAFETERIA_STUDENT_LONG_HAIR_1, FACEMASK_ANY, $0000, CafeteriaNpc03_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_LONG_HAIR_2, FACEMASK_ANY, $0000, CafeteriaNpc04_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_PIGTAILS_GIRL_1, FACEMASK_ANY, $0000, CafeteriaNpc05_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_PIGTAILS_GIRL_2, FACEMASK_ANY, $0000, CafeteriaNpc06_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_BLACK_HAIR_BOY_1, FACEMASK_ANY, $0000, CafeteriaNpc07_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_HEADBAND_BOY, FACEMASK_ANY, $0000, CafeteriaNpc08_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_CAFETERIA_STUDENT_BLACK_HAIR_BOY_2, FACEMASK_ANY, $0000, CafeteriaNpc09_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
CafeteriaFacingScripts_10:
	ds 1, $ff ; $5a50, fill
CafeteriaTileTriggers_10:
	ds 1, $ff ; $5a51, fill
CafeteriaInitScript_10:
	call SetStoryDialogueStage_10 ; $5a52
	ld a, [wMapSceneStage] ; $5a55
	sra a ; $5a58
	ld [wMapSceneStage2], a ; $5a5a
	ld a, $22 ; $5a5d
	ld [wMapScrollMinX], a ; $5a5f
	ld a, $26 ; $5a62
	ld [wMapScrollMinY], a ; $5a64
	ld a, $40 ; $5a67
	ld [wMapWidthTiles], a ; $5a69
	ld a, $3e ; $5a6c
	ld [wMapHeightTiles], a ; $5a6e
	call DisableLCDSafely ; $5a71
	ld a, SCENECOPY_FROM_PLAYER ; $5a74
	farcall CopyScrolledSceneTilemapToVram ; $5a76
	call EnableLCD ; $5a79
	call MapArrivalWalkPair_10 ; $5a7c
	ret ; $5a7f
RestaurantMapScripts_10:
	; $5a80, 14 bytes (map_tree)
	dw RestaurantEntryPoints_10 ; slot 0 EntryPoints
	dw RestaurantExitTriggers_10 ; slot 1 ExitTriggers
	dw RestaurantActors_10 ; slot 2 Actors
	dw RestaurantNpcScripts_10 ; slot 3 NpcScripts
	dw RestaurantFacingScripts_10 ; slot 4 FacingScripts
	dw RestaurantTileTriggers_10 ; slot 5 TileTriggers
	dw RestaurantInitScript_10 ; slot 6 InitScript
RestaurantActors_10:
	; $5a8e, 248 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, 17.0, 25.0, FACE_LEFT, OBJ_RESTAURANT_SERVER, ANIM_WALK, $00, RESTAURANT_RESTAURANT_SERVER_1
	map_actor $0000, ActorScript_10_2, 33.0, 21.0, FACE_UP, OBJ_RESTAURANT_SERVER, ANIM_WALK, $07, RESTAURANT_RESTAURANT_SERVER_2
	map_actor $0000, ActorScript_10_2, 22.0, 19.0, FACE_DOWN, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $00, RESTAURANT_STUDENT_LONG_HAIR_1
	map_actor $0000, ActorScript_10_2, 29.0, 23.0, FACE_UP, OBJ_CHEF, ANIM_WALK, $00, RESTAURANT_CHEF
	map_actor $0000, ActorScript_10_2, 41.0, 41.0, FACE_RIGHT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, RESTAURANT_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_10_2, 33.0, 17.0, FACE_RIGHT, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $00, RESTAURANT_STUDENT_CAP_BOY_1
	map_actor $0000, ActorScript_10_2, 9.0, 15.0, FACE_RIGHT, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $00, RESTAURANT_STUDENT_WAVY_HAIR_GIRL
	map_actor $0000, ActorScript_10_3, 11.0, 25.0, FACE_LEFT, OBJ_STUDENT_LONG_HAIR, ANIM_WALK, $06, RESTAURANT_STUDENT_LONG_HAIR_2
	map_actor $0000, ActorScript_10_2, 13.0, 15.0, FACE_LEFT, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $00, RESTAURANT_STUDENT_PIGTAILS_GIRL_1
	map_actor $0000, ActorScript_10_2, 21.0, 11.0, FACE_LEFT, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $00, RESTAURANT_STUDENT_CAP_BOY_2
	map_actor $0000, ActorScript_10_2, 29.0, 11.0, FACE_LEFT, OBJ_STUDENT_HEADBAND_BOY, ANIM_WALK, $04, RESTAURANT_STUDENT_HEADBAND_BOY_1
	map_actor $0000, ActorScript_10_2, 27.0, 9.0, FACE_DOWN, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $00, RESTAURANT_STUDENT_BLACK_HAIR_BOY_1
	map_actor $0000, ActorScript_10_2, 29.0, 15.0, FACE_LEFT, OBJ_STUDENT_HEADBAND_BOY, ANIM_WALK, $00, RESTAURANT_STUDENT_HEADBAND_BOY_2
	map_actor $0000, ActorScript_10_2, 25.0, 15.0, FACE_RIGHT, OBJ_STUDENT_BLACK_HAIR_BOY, ANIM_WALK, $06, RESTAURANT_STUDENT_BLACK_HAIR_BOY_2
	map_actor $0000, ActorScript_10_2, 41.0, 41.0, FACE_RIGHT, OBJ_BALLOON_ELLIPSIS, ANIM_WALK, $00, RESTAURANT_BALLOON_ELLIPSIS
	map_actor $0000, ActorScript_10_2, 27.0, 18.0, FACE_DOWN, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $00, RESTAURANT_STUDENT_PIGTAILS_GIRL_2
	map_actor $0000, ActorScript_10_2, 25.0, 9.0, FACE_DOWN, OBJ_RACKET, ANIM_WALK, $00, RESTAURANT_RACKET
	map_actor_end
RestaurantEntryPoints_10:
	; $5b86, 17 bytes (map_entries)
	map_entry $01, FACE_UP, 12.0, 33.0, RestaurantArrival01_10
	map_entry $02, FACE_DOWN, 5.0, 23.0, MapArrivalWalkPair_10
	db $ff
	twin_named academy_main_bldg_arrival01, RestaurantArrival01_10 ; $5b97
RestaurantExitTriggers_10:
	; $5bdd, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, RestaurantExit01_10, STORYLOC_RESTAURANT_PLAZA, $02
	map_script $02, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_CAFETERIA, $01
	db $ff
RestaurantExit01_10:
	clear_flag FLAG_RESTAURANT_NPC08_MOVED ; $5bee
	ret ; $5bf1
RestaurantNpc03_10:
	ld a, [wMapSceneStage2] ; $5bf2
	add a ; $5bf5
	ld_hl_indexed RestaurantNpc03TextIds ; $5bf6
	ld a, [hl+] ; $5bfd
	ld h, [hl] ; $5bfe
	ld l, a ; $5bff
	farcall InitDialogueTextCursor ; $5c00
	ld a, [wMapSceneStage] ; $5c03
	cp STORYRANK_DOUBLES_JUNIOR_CHAMP ; $5c06
	jr nz, .speak ; $5c08
	farcall AdvanceDialogueTextCursor ; $5c0a
.speak:
	script_speak ACTOR_RESTAURANT_RESTAURANT_SERVER_1 ; $5c0d
	ret ; $5c12
RestaurantNpc03TextIds:
	; $5c13, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantServerSelfService ; record 0
	dw Text_RestaurantServerSeniorEatALot ; record 1
	dw Text_RestaurantServerEatUp ; record 2
	dw Text_RestaurantServerOpenStarted ; record 3
	dw Text_RestaurantServerVarsityEnergy ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc04_10:
	ld a, [wMapSceneStage2] ; $5c1d
	add a ; $5c20
	ld_hl_indexed RestaurantNpc04TextIds ; $5c21
	ld a, [hl+] ; $5c28
	ld h, [hl] ; $5c29
	ld l, a ; $5c2a
	farcall InitDialogueTextCursor ; $5c2b
	script_speak ACTOR_RESTAURANT_RESTAURANT_SERVER_2 ; $5c2e
	ret ; $5c33
RestaurantNpc04TextIds:
	; $5c34, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantServerDontOvereat ; record 0
	dw Text_RestaurantServerVitamins ; record 1
	dw Text_RestaurantServerBalancedDiet ; record 2
	dw Text_RestaurantServerWonderOpenIsland ; record 3
	dw Text_RestaurantServerLikeOpenChamp ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc05_10:
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c3e
	ld a, [wMapSceneStage] ; $5c46
	add a ; $5c49
	ld_hl_indexed RestaurantNpc05TextIds ; $5c4a
	ld a, [hl+] ; $5c51
	ld h, [hl] ; $5c52
	ld l, a ; $5c53
	farcall InitDialogueTextCursor ; $5c54
	script_speak ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c57
	script_face ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1, FACE_DOWN ; $5c5c
	script_set_anim ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1, ANIM_BOUNCE ; $5c63
	script_wait_idle ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c6a
	script_speak ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c6f
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c74
	script_set_anim ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1, ANIM_SHAKE ; $5c7c
	script_wait_idle ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c83
	script_speak ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1 ; $5c88
	script_wait_frames 20 ; $5c8d
	script_face ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1, FACE_DOWN ; $5c94
	ret ; $5c9b
RestaurantNpc05TextIds:
	; $5c9c, 20 bytes (text_ids)
	table_width 2
	dw Text_RestaurantWhatShouldIEat ; record 0
	dw Text_RestaurantWhatShouldIEat ; record 1
	dw Text_RestaurantWhatllItBe ; record 2
	dw Text_RestaurantWhatllItBe ; record 3
	dw Text_RestaurantFromVarsity ; record 4
	dw Text_RestaurantHealthyFoodBland ; record 5
	dw Text_RestaurantWhatAboutOpen ; record 6
	dw Text_RestaurantWhatAboutOpenPair ; record 7
	dw Text_RestaurantCalorieCount ; record 8
	dw Text_RestaurantCalorieCount ; record 9
	assert_table_length NUM_STORYRANKS
RestaurantNpc06_10:
	script_set_anim ACTOR_RESTAURANT_CHEF, ANIM_SHAKE ; $5cb0
	script_wait_idle ACTOR_RESTAURANT_CHEF ; $5cb7
	ld a, [wMapSceneStage2] ; $5cbc
	add a ; $5cbf
	ld_hl_indexed RestaurantNpc06TextIds_10 ; $5cc0
	ld a, [hl+] ; $5cc7
	ld h, [hl] ; $5cc8
	ld l, a ; $5cc9
	farcall InitDialogueTextCursor ; $5cca
	ld a, [wMapSceneStage] ; $5ccd
	cp STORYRANK_DOUBLES_SENIOR_CHAMP ; $5cd0
	jr nz, .speak ; $5cd2
	farcall AdvanceDialogueTextCursor ; $5cd4
	farcall AdvanceDialogueTextCursor ; $5cd7
.speak:
	script_speak ACTOR_RESTAURANT_CHEF ; $5cda
	ld a, [wMapSceneStage2] ; $5cdf
	cp STORYTIER_ACADEMY ; $5ce2
	jr nz, .animate ; $5ce4
	call RestaurantShowActor11NearPlayer_10 ; $5ce6
.animate:
	script_set_anim ACTOR_RESTAURANT_CHEF, ANIM_NOD ; $5ce9
	script_wait_idle ACTOR_RESTAURANT_CHEF ; $5cf0
	script_speak ACTOR_RESTAURANT_CHEF ; $5cf5
	ret ; $5cfa
RestaurantNpc06TextIds_10:
	; $5cfb, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantChefWhatAreYouEating ; record 0
	dw Text_RestaurantChefTofuSteak ; record 1
	dw Text_RestaurantChefVarsityDoingGreat ; record 2
	dw Text_RestaurantChefOpenBegun ; record 3
	dw Text_RestaurantChefFishMeuniere ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc12_10:
	call TestRestaurantNpc12StageFlag_10 ; $5d05
	jp nz, .speak ; $5d08
	script_set_anim ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, ANIM_NOD ; $5d0b
	script_wait_idle ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d12
	ld a, [wMapSceneStage2] ; $5d17
	add a ; $5d1a
	ld_hl_indexed RestaurantNpc12TextIds ; $5d1b
	ld a, [hl+] ; $5d22
	ld h, [hl] ; $5d23
	ld l, a ; $5d24
	farcall InitDialogueTextCursor ; $5d25
	script_speak ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d28
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d2d
	script_set_position ACTOR_RESTAURANT_BALLOON_EXCLAIM, 28.0, 17.0 ; $5d35
	sound SFX_CHIME ; $5d40
	script_set_anim ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, ANIM_BOUNCE ; $5d42
	script_wait_frames 40 ; $5d49
	script_set_position ACTOR_RESTAURANT_BALLOON_EXCLAIM, 63.0, 63.0 ; $5d50
	script_speak ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d5b
	script_face ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, FACE_DOWN ; $5d60
	script_wait_frames 20 ; $5d67
	script_lock_facing ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d6e
	script_move_angle ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, FACE_UP, 1.0 ; $5d75
	call SetRestaurantNpc12StageFlag_10 ; $5d7f
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5d82
	ld a, [wMapSceneStage2] ; $5d8a
	add a ; $5d8d
	ld_hl_indexed RestaurantNpc12TextIds ; $5d8e
	ld a, [hl+] ; $5d95
	ld h, [hl] ; $5d96
	ld l, a ; $5d97
	ld a, $02 ; $5d98
	add_hl_a ; $5d9a
	farcall InitDialogueTextCursor ; $5d9f
	script_speak ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5da2
	script_unlock_facing ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5da7
	script_face ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, FACE_DOWN ; $5dae
	ret ; $5db5
.speak:
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5db6
	ld a, [wMapSceneStage2] ; $5dbe
	add a ; $5dc1
	ld_hl_indexed RestaurantNpc12TextIds ; $5dc2
	ld a, [hl+] ; $5dc9
	ld h, [hl] ; $5dca
	ld l, a ; $5dcb
	ld a, $02 ; $5dcc
	add_hl_a ; $5dce
	farcall InitDialogueTextCursor ; $5dd3
	script_speak ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2 ; $5dd6
	ret ; $5ddb
RestaurantNpc12TextIds:
	; $5ddc, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantFruitAndCake ; record 0
	dw Text_RestaurantEatLightBeforeMatch ; record 1
	dw Text_RestaurantParfaitSoldOut ; record 2
	dw Text_RestaurantCoachesAwayEasyPractice ; record 3
	dw Text_RestaurantCakeAndAerobics ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc08FaceDown_10:
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $5de6
RestaurantNpc08_10:
	test_flag FLAG_RESTAURANT_NPC08_MOVED ; $5de9
	jr nz, .speak ; $5dec
	ld a, [wMapSceneStage2] ; $5dee
	add a ; $5df1
	ld_hl_indexed RestaurantNpc08TextIds ; $5df2
	ld a, [hl+] ; $5df9
	ld h, [hl] ; $5dfa
	ld l, a ; $5dfb
	farcall InitDialogueTextCursor ; $5dfc
	script_speak ACTOR_RESTAURANT_STUDENT_CAP_BOY_1 ; $5dff
	script_set_speed ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, 0.5 ; $5e04
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $5e0c
	jr z, .altText ; $5e0f
	script_jump_velocity ACTOR_PLAYER, -2.0 ; $5e11
	script_move_target ACTOR_PLAYER, 31.0, 15.0 ; $5e19
	script_wait_move ACTOR_PLAYER ; $5e24
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5e29
.altText:
	script_move_target ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, 33.25, 15.0 ; $5e30
	script_wait_move ACTOR_RESTAURANT_STUDENT_CAP_BOY_1 ; $5e3b
	script_wait_frames 10 ; $5e40
	script_set_anim ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, ANIM_BOUNCE ; $5e47
	script_face ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, FACE_RIGHT ; $5e4e
	set_flag FLAG_RESTAURANT_NPC08_MOVED ; $5e55
	clear_flag FLAG_TEMP_SCENE_VARIANT_B ; $5e58
	ret ; $5e5b
.speak:
	ld a, [wMapSceneStage2] ; $5e5c
	add a ; $5e5f
	ld_hl_indexed RestaurantNpc08TextIds ; $5e60
	ld a, [hl+] ; $5e67
	ld h, [hl] ; $5e68
	ld l, a ; $5e69
	ld a, $01 ; $5e6a
	add_hl_a ; $5e6c
	farcall InitDialogueTextCursor ; $5e71
	script_speak ACTOR_RESTAURANT_STUDENT_CAP_BOY_1 ; $5e74
	script_face ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, FACE_RIGHT ; $5e79
	ret ; $5e80
RestaurantNpc08TextIds:
	; $5e81, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantCoffeeAfterEating ; record 0
	dw Text_RestaurantPlanGameOverCoffee ; record 1
	dw Text_RestaurantRankingFellSniff ; record 2
	dw Text_RestaurantNonTravelersDepressed ; record 3
	dw Text_RestaurantNextOpenStrategy ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc09_10:
	ld a, [wMapSceneStage] ; $5e8b
	add a ; $5e8e
	ld_hl_indexed RestaurantNpc09TextIds ; $5e8f
	ld a, [hl+] ; $5e96
	ld h, [hl] ; $5e97
	ld l, a ; $5e98
	farcall InitDialogueTextCursor ; $5e99
	ld a, [wMapSceneStage] ; $5e9c
	cp STORYRANK_SINGLES_ISLAND_OPEN ; $5e9f
	jr nc, .altText ; $5ea1
	script_speak ACTOR_RESTAURANT_STUDENT_WAVY_HAIR_GIRL ; $5ea3
	ret ; $5ea8
.altText:
	script_speak_restore ACTOR_RESTAURANT_STUDENT_WAVY_HAIR_GIRL ; $5ea9
	farcall RunDialogueYesNoPrompt ; $5eae
	farcall ScriptCloseDialogueWindow ; $5eb1
	script_wait_frames 5 ; $5eb4
	and a ; $5ebb
	jr nz, .done ; $5ebc
	script_set_text Text_RestaurantSoLuckyJealous ; $5ebe
	test_flag FLAG_DOUBLES ; $5ec4
	jr z, .speak ; $5ec7
	farcall AdvanceDialogueTextCursor ; $5ec9
.speak:
	script_speak ACTOR_RESTAURANT_STUDENT_WAVY_HAIR_GIRL ; $5ecc
	ret ; $5ed1
.done:
	script_set_text Text_RestaurantDontBeModest ; $5ed2
	script_speak ACTOR_RESTAURANT_STUDENT_WAVY_HAIR_GIRL ; $5ed8
	ret ; $5edd
RestaurantNpc09TextIds:
	; $5ede, 20 bytes (text_ids)
	table_width 2
	dw Text_RestaurantHamburgSteak ; record 0
	dw Text_RestaurantHamburgSteak ; record 1
	dw Text_RestaurantJealousYouMadeSenior ; record 2
	dw Text_RestaurantJealousYouTwoMadeSenior ; record 3
	dw Text_RestaurantJealousMadeVarsity ; record 4
	dw Text_RestaurantJealousMadeVarsityDoubles ; record 5
	dw Text_RestaurantTravelingTeamPutsYouInOpen ; record 6
	dw Text_RestaurantTravelingTeamPutsYouInOpen ; record 7
	dw Text_RestaurantWonOpenFirstTime ; record 8
	dw Text_RestaurantWonOpenFirstTime ; record 9
	assert_table_length NUM_STORYRANKS
RestaurantNpc0A_10:
	script_face_toward ACTOR_PLAYER, ACTOR_RESTAURANT_STUDENT_LONG_HAIR_2 ; $5ef2
	ld a, [wMapSceneStage] ; $5efa
	add a ; $5efd
	ld_hl_indexed RestaurantNpc0ATextIds ; $5efe
	ld a, [hl+] ; $5f05
	ld h, [hl] ; $5f06
	ld l, a ; $5f07
	farcall InitDialogueTextCursor ; $5f08
	ld a, [wMapSceneStage] ; $5f0b
	cp STORYRANK_SINGLES_ISLAND_OPEN ; $5f0e
	jr nc, .speak ; $5f10
	script_speak_restore ACTOR_RESTAURANT_STUDENT_LONG_HAIR_2 ; $5f12
	farcall RunDialogueYesNoPrompt ; $5f17
	farcall ScriptCloseDialogueWindow ; $5f1a
	script_wait_frames 5 ; $5f1d
	and a ; $5f24
	jr z, .speak ; $5f25
	farcall AdvanceDialogueTextCursor ; $5f27
.speak:
	script_speak ACTOR_RESTAURANT_STUDENT_LONG_HAIR_2 ; $5f2a
	ret ; $5f2f
RestaurantNpc0ATextIds:
	; $5f30, 20 bytes (text_ids)
	table_width 2
	dw Text_RestaurantNewJuniorKid ; record 0
	dw Text_RestaurantYouTwoJuniorClass ; record 1
	dw Text_RestaurantJustEnteredAlreadySenior ; record 2
	dw Text_RestaurantAlreadyInSenior ; record 3
	dw Text_RestaurantSecretIsHeart ; record 4
	dw Text_RestaurantSecretIsHeart ; record 5
	dw Text_RestaurantSkillAndLuck ; record 6
	dw Text_RestaurantSkillAndLuck ; record 7
	dw Text_RestaurantTournamentSecret ; record 8
	dw Text_RestaurantTournamentSecret ; record 9
	assert_table_length NUM_STORYRANKS
RestaurantNpc0B_10:
	ld a, [wMapSceneStage2] ; $5f44
	add a ; $5f47
	ld_hl_indexed RestaurantNpc0BTextIds ; $5f48
	ld a, [hl+] ; $5f4f
	ld h, [hl] ; $5f50
	ld l, a ; $5f51
	farcall InitDialogueTextCursor ; $5f52
	ld a, [wMapSceneStage] ; $5f55
	cp STORYRANK_DOUBLES_ACADEMY ; $5f58
	jr nz, .speak ; $5f5a
	farcall AdvanceDialogueTextCursor ; $5f5c
.speak:
	script_speak ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_1 ; $5f5f
	ret ; $5f64
RestaurantNpc0BTextIds:
	; $5f65, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantMustWinSinglesToday ; record 0
	dw Text_RestaurantRankingLosingStreak ; record 1
	dw Text_RestaurantIMovedUpToo ; record 2
	dw Text_RestaurantAssumeYoullLose ; record 3
	dw Text_RestaurantAssumeLossBackfires ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc0C_10:
	ld a, [wMapSceneStage2] ; $5f6f
	add a ; $5f72
	ld_hl_indexed RestaurantNpc0CTextIds ; $5f73
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall InitDialogueTextCursor ; $5f7d
	ld a, [wMapSceneStage2] ; $5f80
	cp STORYTIER_ACADEMY ; $5f83
	jr z, .speak ; $5f85
	cp $03 ; $5f87
	jr nc, .islandOpenOrLater ; $5f89
	script_speak_restore ACTOR_RESTAURANT_STUDENT_CAP_BOY_2 ; $5f8b
	farcall RunDialogueYesNoPrompt ; $5f90
	farcall ScriptCloseDialogueWindow ; $5f93
	script_wait_frames 5 ; $5f96
	and a ; $5f9d
	jr z, .speak ; $5f9e
	farcall AdvanceDialogueTextCursor ; $5fa0
	ld a, [wMapSceneStage] ; $5fa3
	cp STORYRANK_DOUBLES_SENIOR_CHAMP ; $5fa6
	jr nz, .speak ; $5fa8
	farcall AdvanceDialogueTextCursor ; $5faa
	jr .speak ; $5fad
.islandOpenOrLater:
	ld a, [wMapSceneStage] ; $5faf
	and $01 ; $5fb2
	jr z, .speak ; $5fb4
	farcall AdvanceDialogueTextCursor ; $5fb6
.speak:
	script_speak ACTOR_RESTAURANT_STUDENT_CAP_BOY_2 ; $5fb9
	ret ; $5fbe
RestaurantNpc0CTextIds:
	; $5fbf, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantCoachesSayProtein ; record 0
	dw Text_RestaurantSeniorAskTrainingCenter ; record 1
	dw Text_RestaurantVarsityAskTrainingCenter ; record 2
	dw Text_RestaurantWhenDoYouEat ; record 3
	dw Text_RestaurantTrainingCenterLikeYou ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc0D_10:
	ld a, [wMapSceneStage2] ; $5fc9
	add a ; $5fcc
	ld_hl_indexed RestaurantNpc0DTextIds ; $5fcd
	ld a, [hl+] ; $5fd4
	ld h, [hl] ; $5fd5
	ld l, a ; $5fd6
	farcall InitDialogueTextCursor ; $5fd7
	ld a, [wMapSceneStage2] ; $5fda
	cp STORYTIER_ISLAND_OPEN ; $5fdd
	jr nz, .advanceDialogueTextCursor ; $5fdf
	script_speak_restore ACTOR_RESTAURANT_STUDENT_HEADBAND_BOY_1 ; $5fe1
	farcall RunDialogueYesNoPrompt ; $5fe6
	farcall ScriptCloseDialogueWindow ; $5fe9
	script_wait_frames 5 ; $5fec
	and a ; $5ff3
	jr z, .advanceDialogueTextCursor ; $5ff4
	farcall AdvanceDialogueTextCursor ; $5ff6
.advanceDialogueTextCursor:
	ld a, [wMapSceneStage] ; $5ff9
	cp STORYRANK_DOUBLES_JUNIOR_CHAMP ; $5ffc
	jr nz, .speak ; $5ffe
	farcall AdvanceDialogueTextCursor ; $6000
.speak:
	script_speak ACTOR_RESTAURANT_STUDENT_HEADBAND_BOY_1 ; $6003
	ret ; $6008
RestaurantNpc0DTextIds:
	; $6009, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantProteinAndTraining ; record 0
	dw Text_RestaurantSeniorPushHarder ; record 1
	dw Text_RestaurantVarsityAllAroundAbility ; record 2
	dw Text_RestaurantWhenIEnteredOpen ; record 3
	dw Text_RestaurantMarioRumor ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc0E_10:
	ld a, [wMapSceneStage2] ; $6013
	add a ; $6016
	ld_hl_indexed RestaurantNpc0ETextIds ; $6017
	ld a, [hl+] ; $601e
	ld h, [hl] ; $601f
	ld l, a ; $6020
	farcall InitDialogueTextCursor ; $6021
	script_speak ACTOR_RESTAURANT_STUDENT_BLACK_HAIR_BOY_1 ; $6024
	ret ; $6029
RestaurantNpc0ETextIds:
	; $602a, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantAvoidOilyFoods ; record 0
	dw Text_RestaurantFixWeaknesses ; record 1
	dw Text_RestaurantVarsityTennisMachine ; record 2
	dw Text_RestaurantSomethingToLose ; record 3
	dw Text_RestaurantMarioStory ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc0F_10:
	ld a, [wMapSceneStage2] ; $6034
	add a ; $6037
	ld_hl_indexed RestaurantNpc0FTextIds ; $6038
	ld a, [hl+] ; $603f
	ld h, [hl] ; $6040
	ld l, a ; $6041
	farcall InitDialogueTextCursor ; $6042
	script_speak ACTOR_RESTAURANT_STUDENT_HEADBAND_BOY_2 ; $6045
	ret ; $604a
RestaurantNpc0FTextIds:
	; $604b, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantSportsmanDiet ; record 0
	dw Text_RestaurantStrengthsOrWeaknesses ; record 1
	dw Text_RestaurantVarsityRivals ; record 2
	dw Text_RestaurantPlayHardForMe ; record 3
	dw Text_RestaurantJustMomentum ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpc10_10:
	ld a, [wMapSceneStage2] ; $6055
	add a ; $6058
	ld_hl_indexed RestaurantNpc10TextIds ; $6059
	ld a, [hl+] ; $6060
	ld h, [hl] ; $6061
	ld l, a ; $6062
	farcall InitDialogueTextCursor ; $6063
	script_speak ACTOR_RESTAURANT_STUDENT_BLACK_HAIR_BOY_2 ; $6066
	ret ; $606b
RestaurantNpc10TextIds:
	; $606c, 10 bytes (text_ids)
	table_width 2
	dw Text_RestaurantDessertAfterTraining ; record 0
	dw Text_RestaurantEightyPercentFull ; record 1
	dw Text_RestaurantTravelingTeamEntersOpen ; record 2
	dw Text_RestaurantEveryoneWantsOpen ; record 3
	dw Text_RestaurantWinningOpenDream ; record 4
	assert_table_length NUM_STORYTIERS
RestaurantNpcScripts_10:
	; $6076, 121 bytes (map_scripts)
	map_script ACTOR_RESTAURANT_RESTAURANT_SERVER_1, FACEMASK_ANY, $0000, RestaurantNpc03_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_RESTAURANT_SERVER_2, FACEMASK_ANY, $0000, RestaurantNpc04_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_LONG_HAIR_1, FACEMASK_ANY, $0000, RestaurantNpc05_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_CHEF, FACEMASK_ANY, $0000, RestaurantNpc06_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, FACEMASK_ANY, $0000, RestaurantNpc12_10, $00, $00
	map_script ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, FACEMASK_DOWN, $0000, RestaurantNpc08FaceDown_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, FACEMASK_ANY, $0000, RestaurantNpc08_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_WAVY_HAIR_GIRL, FACEMASK_ANY, $0000, RestaurantNpc09_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_LONG_HAIR_2, FACEMASK_ANY, $0000, RestaurantNpc0A_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_1, FACEMASK_ANY, $0000, RestaurantNpc0B_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_CAP_BOY_2, FACEMASK_ANY, $0000, RestaurantNpc0C_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_HEADBAND_BOY_1, FACEMASK_ANY, $0000, RestaurantNpc0D_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_BLACK_HAIR_BOY_1, FACEMASK_ANY, $0000, RestaurantNpc0E_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_RESTAURANT_STUDENT_HEADBAND_BOY_2, FACEMASK_ANY, $0000, RestaurantNpc0F_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_RESTAURANT_STUDENT_BLACK_HAIR_BOY_2, FACEMASK_ANY, $0000, RestaurantNpc10_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
RestaurantFacingScripts_10:
	ds 1, $ff ; $60ef, fill
RestaurantTileTriggers_10:
	ds 1, $ff ; $60f0, fill
RestaurantInitScript_10:
	call SetStoryDialogueStage_10 ; $60f1
	ld a, [wMapSceneStage] ; $60f4
	sra a ; $60f7
	ld [wMapSceneStage2], a ; $60f9
	call RestaurantRestoreNpc12Position_10 ; $60fc
	call RestaurantRestoreNpc08Position_10 ; $60ff
	ret ; $6102
RestaurantRestoreNpc08Position_10:
	test_flag FLAG_RESTAURANT_NPC08_MOVED ; $6103
	jr z, .done ; $6106
	script_set_position ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, 33.25, 15.0 ; $6108
	script_face ACTOR_RESTAURANT_STUDENT_CAP_BOY_1, FACE_RIGHT ; $6113
.done:
	ret ; $611a
RestaurantRestoreNpc12Position_10:
	call TestRestaurantNpc12StageFlag_10 ; $611b
	jr z, .done ; $611e
	script_set_position ACTOR_RESTAURANT_STUDENT_PIGTAILS_GIRL_2, 27.0, 17.0 ; $6120
.done:
	ret ; $612b
TestRestaurantNpc12StageFlag_10:
	ld a, [wMapSceneStage2] ; $612c
	add a ; $612f
	ld_hl_indexed RestaurantNpc12StageFlagTable_10 ; $6130
	ld a, [hl+] ; $6137
	ld d, [hl] ; $6138
	ld e, a ; $6139
	call TestGameFlagByNumber ; $613a
	ret ; $613d
SetRestaurantNpc12StageFlag_10:
	ld a, [wMapSceneStage2] ; $613e
	add a ; $6141
	ld_hl_indexed RestaurantNpc12StageFlagTable_10 ; $6142
	ld a, [hl+] ; $6149
	ld d, [hl] ; $614a
	ld e, a ; $614b
	call SetGameFlagByNumber ; $614c
	ret ; $614f
RestaurantNpc12StageFlagTable_10:
	; $6150, 10 bytes (flag numbers, for *GameFlagByNumber)
	table_width 2
	dw FLAG_RESTAURANT_NPC12_MOVED_STAGE_0 ; 0
	dw FLAG_RESTAURANT_NPC12_MOVED_STAGE_1 ; 1
	dw FLAG_RESTAURANT_NPC12_MOVED_STAGE_2 ; 2
	dw FLAG_RESTAURANT_NPC12_MOVED_STAGE_3 ; 3
	dw FLAG_RESTAURANT_NPC12_MOVED_STAGE_4 ; 4
	assert_table_length NUM_STORYTIERS
RestaurantShowActor11NearPlayer_10:
	wram_bank WRAM_ACTORS ; $615a
	script_get_actor_state ACTOR_PLAYER ; $6160
	ld c, l ; $6165
	ld b, h ; $6166
	ld hl, ACTORF_X ; $6167
	add hl, bc ; $616a
	ld a, [hl+] ; $616b
	ld h, [hl] ; $616c
	ld l, a ; $616d
	ld de, $0180 ; $616e
	add hl, de ; $6171
	ld e, l ; $6172
	ld d, h ; $6173
	ld hl, wMapScratch + 6 ; $6174
	ld a, e ; $6177
	ld [hl+], a ; $6178
	ld [hl], d ; $6179
	ld hl, ACTORF_Y ; $617a
	add hl, bc ; $617d
	ld a, [hl+] ; $617e
	ld h, [hl] ; $617f
	ld l, a ; $6180
	ld de, $fe80 ; $6181
	add hl, de ; $6184
	ld e, l ; $6185
	ld d, h ; $6186
	ld hl, wMapScratch + 8 ; $6187
	ld a, e ; $618a
	ld [hl+], a ; $618b
	ld [hl], d ; $618c
	ld hl, wMapScratch + 6 ; $618d
	ld a, [hl+] ; $6190
	ld b, [hl] ; $6191
	ld c, a ; $6192
	ld hl, wMapScratch + 8 ; $6193
	ld a, [hl+] ; $6196
	ld d, [hl] ; $6197
	ld e, a ; $6198
	ld a, $11 ; $6199
	farcall ScriptSetActorPosition ; $619b
	script_wait_frames 70 ; $619e
	script_set_position ACTOR_RESTAURANT_BALLOON_ELLIPSIS, 63.0, 63.0 ; $61a5
	ret ; $61b0
