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
	map_actor $0000, ActorScript_12_51, 41.0, 25.0, FACE_LEFT, OBJ_EMILY, ANIM_WALK, $00, SENIOR_COURT_EMILY
	map_actor $0000, ActorScript_12_43, 53.0, 30.0, FACE_UP, OBJ_FAY, ANIM_SWING_LOOP, $07, SENIOR_COURT_FAY
	map_actor $0000, ActorScript_12_57, 50.0, 30.0, FACE_RIGHT, OBJ_ALLIE, ANIM_WALK, $05, SENIOR_COURT_ALLIE
	map_actor $0000, ActorScript_12_52, 51.0, 17.0, FACE_LEFT, OBJ_JOY, ANIM_WALK, $04, SENIOR_COURT_JOY
	map_actor $0000, ActorScript_12_51, 41.0, 19.0, FACE_LEFT, OBJ_BRIAN, ANIM_WALK, $06, SENIOR_COURT_BRIAN
	map_actor $0000, ActorScript_12_43, 11.0, 21.0, FACE_UP, OBJ_BETH, ANIM_WALK, $05, SENIOR_COURT_BETH
	map_actor $0000, ActorScript_12_58, 11.0, 19.0, FACE_DOWN, OBJ_CURT, ANIM_WALK, $03, SENIOR_COURT_CURT
	map_actor $0000, ActorScript_12_56, 21.0, 23.0, FACE_UP, OBJ_BOB, ANIM_WALK, $06, SENIOR_COURT_BOB
	map_actor $0000, ActorScript_12_55, 19.0, 11.0, FACE_DOWN, OBJ_PAM, ANIM_WALK, $03, SENIOR_COURT_PAM
	map_actor $05e0, ActorScript_12_52, 9.0, 11.0, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00, SENIOR_COURT_KATE
	map_actor $0000, ActorScript_12_53, 34.0, 19.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, SENIOR_COURT_RACKET_STUDENT_1
	map_actor $0000, ActorScript_12_54, 37.0, 29.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $04, SENIOR_COURT_RACKET_STUDENT_2
	map_actor_end
SeniorCourtActorsA_12:
	; $53b7, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, 45.0, 25.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, SENIOR_COURT_A_EMILY
	map_actor $0000, ActorScript_12_51, 41.0, 27.0, FACE_LEFT, OBJ_FAY, ANIM_WALK, $07, SENIOR_COURT_A_FAY
	map_actor $0000, ActorScript_12_57, 57.0, 29.0, FACE_LEFT, OBJ_ALLIE, ANIM_WALK, $05, SENIOR_COURT_A_ALLIE
	map_actor $0000, ActorScript_12_51, 45.0, 19.0, FACE_RIGHT, OBJ_JOY, ANIM_WALK, $04, SENIOR_COURT_A_JOY
	map_actor $0000, ActorScript_12_51, 43.0, 17.0, FACE_LEFT, OBJ_BRIAN, ANIM_WALK, $06, SENIOR_COURT_A_BRIAN
	map_actor $0000, ActorScript_12_43, 10.0, 21.0, FACE_UP, OBJ_BETH, ANIM_WALK, $05, SENIOR_COURT_A_BETH
	map_actor $0000, ActorScript_12_51, 3.0, 23.0, FACE_RIGHT, OBJ_CURT, ANIM_WALK, $03, SENIOR_COURT_A_CURT
	map_actor $0000, ActorScript_12_57, 18.0, 13.0, FACE_RIGHT, OBJ_BOB, ANIM_WALK, $06, SENIOR_COURT_A_BOB
	map_actor $0000, ActorScript_12_44, 21.0, 13.0, FACE_DOWN, OBJ_PAM, ANIM_SWING_LOOP, $03, SENIOR_COURT_A_PAM
	map_actor $05e0, ActorScript_12_52, 3.0, 11.0, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00, SENIOR_COURT_A_KATE
	map_actor $0000, ActorScript_12_53, 34.0, 17.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, SENIOR_COURT_A_RACKET_STUDENT_1
	map_actor $0000, ActorScript_12_54, 38.0, 29.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, SENIOR_COURT_A_RACKET_STUDENT_2
	map_actor $0000, ActorScript_12_55, 50.0, 17.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, SENIOR_COURT_A_RACKET_STUDENT_3
	map_actor $0000, ActorScript_12_56, 54.0, 29.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $06, SENIOR_COURT_A_RACKET_STUDENT_4
	map_actor $0000, ActorScript_12_51, 64.0, 64.0, FACE_UP, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, SENIOR_COURT_A_BALLOON_SWEAT
	map_actor_end
SeniorCourtActorsB_12:
	; $5493, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, 45.0, 25.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, SENIOR_COURT_B_EMILY
	map_actor $0000, ActorScript_12_43, 45.0, 17.0, FACE_UP, OBJ_FAY, ANIM_SWING_LOOP, $07, SENIOR_COURT_B_FAY
	map_actor $0000, ActorScript_12_57, 45.0, 15.0, FACE_DOWN, OBJ_ALLIE, ANIM_WALK, $05, SENIOR_COURT_B_ALLIE
	map_actor $0000, ActorScript_12_51, 57.0, 29.0, FACE_LEFT, OBJ_JOY, ANIM_WALK, $04, SENIOR_COURT_B_JOY
	map_actor $0000, ActorScript_12_51, 57.0, 27.0, FACE_LEFT, OBJ_BRIAN, ANIM_WALK, $06, SENIOR_COURT_B_BRIAN
	map_actor $0000, ActorScript_12_43, 35.0, 30.0, FACE_UP, OBJ_BETH, ANIM_WALK, $05, SENIOR_COURT_B_BETH
	map_actor $0000, ActorScript_12_51, 35.0, 28.0, FACE_DOWN, OBJ_CURT, ANIM_WALK, $03, SENIOR_COURT_B_CURT
	map_actor $0000, ActorScript_12_51, 9.0, 7.0, FACE_RIGHT, OBJ_BOB, ANIM_WALK, $06, SENIOR_COURT_B_BOB
	map_actor $0000, ActorScript_12_51, 11.0, 7.0, FACE_LEFT, OBJ_PAM, ANIM_WALK, $03, SENIOR_COURT_B_PAM
	map_actor $05e0, ActorScript_12_52, 3.0, 11.0, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00, SENIOR_COURT_B_KATE
	map_actor $0000, ActorScript_12_53, 18.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, SENIOR_COURT_B_RACKET_STUDENT_1
	map_actor $0000, ActorScript_12_54, 22.0, 22.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, SENIOR_COURT_B_RACKET_STUDENT_2
	map_actor $0000, ActorScript_12_55, 50.0, 17.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, SENIOR_COURT_B_RACKET_STUDENT_3
	map_actor $0000, ActorScript_12_56, 54.0, 29.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $06, SENIOR_COURT_B_RACKET_STUDENT_4
	map_actor $0000, ActorScript_12_51, 64.0, 64.0, FACE_UP, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, SENIOR_COURT_B_BALLOON_SWEAT
	map_actor_end
SeniorCourtEntryPoints_12:
	; $556f, 17 bytes (map_entries)
	map_entry $01, FACE_UP, 43.0, 35.0, $0000, SENIOR_CLASS_COURT_FROM_RESTAURANT_PLAZA
	map_entry $09, FACE_UP, 11.0, 25.0, $0000, SENIOR_CLASS_COURT_PRACTICE_MATCH_RETURN
	entry_id SENIOR_CLASS_COURT_VICTORY_SCENE, $0d
	entry_id SENIOR_CLASS_COURT_MATCH_WON, $0e
	entry_id SENIOR_CLASS_COURT_MATCH_RETURN, $0f
	db $ff
SeniorCourtExitTriggers_12:
	; $5580, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, SeniorCourtExit01_12, STORYLOC_RESTAURANT_PLAZA, ENTRY_RESTAURANT_PLAZA_FROM_SENIOR_CLASS_COURT, SENIOR_CLASS_COURT_TO_RESTAURANT_PLAZA
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_SENIOR_CLASS_COURT, ENTRY_SENIOR_CLASS_COURT_MATCH_RETURN, SENIOR_CLASS_COURT_RANKING_MATCH
	db $ff
SeniorCourtExit01_12:
	clear_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5591
	script_move_angle ACTOR_PLAYER, FACE_DOWN, 2.0 ; $5594
	script_move_angle ACTOR_PARTNER, FACE_DOWN, 2.0 ; $559e
	script_fade_out 16 ; $55a8
	script_wait_frames 30 ; $55ad
	ret ; $55b4
SpeakEmilyPostChampionLine:
	ld a, [wMapSceneStage2] ; $55b5
	sub SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $55b8
	add a ; $55ba
	ld_hl_indexed EmilyPostChampionTextIds ; $55bb
	ld a, [hl+] ; $55c2
	ld h, [hl] ; $55c3
	ld l, a ; $55c4
	farcall InitDialogueTextCursor ; $55c5
	ld a, [wStoryMainGender] ; $55c8
	ld hl, Text_NameHarry ; $55cb
	add_hl_a ; $55ce
	call PushShortTextArg_12 ; $55d3
	script_speak ACTOR_SENIOR_COURT_EMILY ; $55d6
	ret ; $55db
EmilyPostChampionTextIds:
	; $55dc, 12 bytes (text_ids)
	table_width 2
	dw Text_EmilyMakeTravelingTeamFirst ; record 0
	dw Text_SeniorMadeDoublesVarsity ; record 1
	dw Text_SeniorStandInCoachEmilyAway ; record 2
	dw Text_SeniorOpenNotJustDream ; record 3
	dw Text_SeniorRiseInspiredEveryone ; record 4
	dw Text_SeniorEveryoneHasGoals ; record 5
	assert_table_length NUM_SENIORCOURTSTAGES - SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP
SeniorCourtNpc03_12:
	ld a, [wMapSceneStage2] ; $55e8
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55eb
	jr c, SeniorCourtNpc03FaceUpFlag0000_12.checkDoubles ; $55ed
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $55ef
	jr nc, SpeakEmilyPostChampionLine ; $55f1
	call SeniorRankOfferScenePrep ; $55f3
	ret ; $55f6
SeniorCourtNpc03FaceUpFlag0000_12:
	ld a, [wMapSceneStage2] ; $55f7
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55fa
	jr c, .checkDoubles ; $55fc
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $55fe
	jr nc, SpeakEmilyPostChampionLine ; $5600
	call SeniorRankOfferScenePrepFacingUp ; $5602
	ret ; $5605
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5606
	jp nz, SeniorCourtNpc03FaceUpFlag0840_12.checkFlag ; $5609
	script_set_text Text_EmilyUsedToAcademyLife ; $560c
	script_speak_restore ACTOR_SENIOR_COURT_EMILY ; $5612
	farcall RunDialogueYesNoPrompt ; $5617
	farcall ScriptCloseDialogueWindow ; $561a
	script_wait_frames 5 ; $561d
	and a ; $5624
	jr z, .speak ; $5625
	farcall AdvanceDialogueTextCursor ; $5627
.speak:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $562a
	ret ; $562f
SeniorCourtNpc03FaceRight_12:
	test_flag FLAG_DOUBLES ; $5630
	jr z, SeniorCourtNpc03_12 ; $5633
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5635
	jp nz, SeniorCourtNpc03FaceUpFlag0840_12.setText ; $5638
	script_set_speed ACTOR_PLAYER, 0.5 ; $563b
	script_set_speed ACTOR_PARTNER, 0.5 ; $5643
	script_null_script ACTOR_PARTNER ; $564b
	script_move_target ACTOR_PLAYER, 41.0, 27.0 ; $5650
	script_move_target ACTOR_PARTNER, 39.0, 29.0 ; $565b
	script_wait_move ACTOR_PARTNER ; $5666
	script_move_target ACTOR_PARTNER, 43.0, 29.0 ; $566b
	script_wait_move ACTOR_PARTNER ; $5676
	script_move_target ACTOR_PARTNER, 43.0, 25.0 ; $567b
	script_wait_move ACTOR_PARTNER ; $5686
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $568b
	script_wait_move ACTOR_PLAYER ; $5693
	jp SeniorCourtNpc03FaceUpFlag0840_12.face ; $5698
SeniorCourtNpc03FaceUpFlag0840_12:
	test_flag FLAG_DOUBLES ; $569b
	jp z, SeniorCourtNpc03FaceUpFlag0000_12 ; $569e
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $56a1
	jp nz, .setText ; $56a4
	script_set_speed ACTOR_PARTNER, 0.5 ; $56a7
	script_set_speed ACTOR_PLAYER, 0.25 ; $56af
	script_face ACTOR_PLAYER, FACE_UP ; $56b7
	script_lock_facing ACTOR_PLAYER ; $56be
	script_null_script ACTOR_PARTNER ; $56c5
	script_move_target ACTOR_PLAYER, 41.0, 27.0 ; $56ca
	script_move_target ACTOR_PARTNER, 43.0, 27.0 ; $56d5
	script_wait_move ACTOR_PARTNER ; $56e0
	script_move_target ACTOR_PARTNER, 43.0, 25.0 ; $56e5
	script_wait_move ACTOR_PARTNER ; $56f0
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $56f5
	script_wait_move ACTOR_PLAYER ; $56fd
	jr .face ; $5702
.checkFlag:
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5704
	jp nz, .setText ; $5707
	script_set_speed ACTOR_PLAYER, 0.5 ; $570a
	script_set_speed ACTOR_PARTNER, 0.5 ; $5712
	script_null_script ACTOR_PARTNER ; $571a
	script_move_target ACTOR_PLAYER, 41.0, 27.0 ; $571f
	script_move_target ACTOR_PARTNER, 43.0, 25.0 ; $572a
	script_wait_move ACTOR_PARTNER ; $5735
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $573a
	script_wait_move ACTOR_PLAYER ; $5742
.face:
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PLAYER ; $5747
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $574f
	script_set_anim ACTOR_SENIOR_COURT_EMILY, ANIM_NOD ; $5757
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $575e
	script_wait_frames 30 ; $5763
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_EMILY ; $576a
	script_set_anim ACTOR_SENIOR_COURT_EMILY, ANIM_NOD ; $5772
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $5779
	script_unlock_facing ACTOR_PLAYER ; $577e
	script_face ACTOR_PLAYER, FACE_UP ; $5785
	script_set_text Text_EmilyPartnerIsMyStudent ; $578c
	set_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5792
	ld a, [wStoryPartnerGender] ; $5795
	or a ; $5798
	jr nz, .speak ; $5799
	script_set_text Text_EmilyThatsWhyPartners ; $579b
.speak:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57a1
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $57a6
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57ae
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $57b3
	script_wait_idle ACTOR_PARTNER ; $57ba
	script_speak ACTOR_PARTNER ; $57bf
	script_set_speed ACTOR_PLAYER, 0.75 ; $57c4
	script_set_speed ACTOR_PARTNER, 0.75 ; $57cc
	script_move_target ACTOR_PARTNER, 43.0, 27.0 ; $57d4
	script_wait_move ACTOR_PARTNER ; $57df
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $57e4
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $57ec
.setText:
	script_set_text Text_EmilyCantWaitToSeeDoubles ; $57f4
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57fa
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $57ff
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $5806
	script_wait_idle ACTOR_PARTNER ; $580d
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $5812
	ret ; $581f
SeniorCourtNpc04_12:
	ld a, [wMapSceneStage2] ; $5820
	add a ; $5823
	ld_hl_indexed SeniorCourtNpc04TextIds ; $5824
	ld a, [hl+] ; $582b
	ld h, [hl] ; $582c
	ld l, a ; $582d
	farcall InitDialogueTextCursor ; $582e
	script_speak ACTOR_ROLE_SENIOR_COURT_FAY ; $5831
	ld a, [wMapSceneStage2] ; $5836
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $5839
	jr nc, .atLeastSinglesRank4 ; $583b
	jr .done ; $583d
.atLeastSinglesRank4:
	ld a, [wMapSceneStage2] ; $583f
	cp SENIORCOURTSTAGE_DOUBLES_RANK3 ; $5842
	jr c, .done ; $5844
.done:
	ret ; $5846
SeniorCourtNpc04TextIds:
	; $5847, 18 bytes (text_ids)
	dw Text_FaySeniorBaselinePlay ; record 0
	dw Text_FaySeniorBaselinePlay ; record 1
	dw Text_FaySeniorHitsLikeBoys ; record 2
	dw Text_FaySeniorHitsLikeBoys ; record 3
	dw Text_FaySeniorHitsLikeBoys ; record 4
	dw Text_FaySeniorChampTakeYouOn ; record 5
	dw Text_FaySeniorDoublesChamps ; record 6
	dw Text_FaySeniorDoublesChamps ; record 7
	dw Text_FaySeniorDoublesNewTeamSecond ; record 8
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
	jr z, .singlesRank2 ; $586f
	script_speak ACTOR_SENIOR_COURT_ALLIE ; $5871
	ret ; $5876
.singlesRank2:
	script_speak_restore ACTOR_SENIOR_COURT_A_ALLIE ; $5877
	farcall RunDialogueYesNoPrompt ; $587c
	farcall ScriptCloseDialogueWindow ; $587f
	script_wait_frames 5 ; $5882
	and a ; $5889
	jr z, .speak ; $588a
	farcall AdvanceDialogueTextCursor ; $588c
.speak:
	script_speak ACTOR_SENIOR_COURT_ALLIE ; $588f
	ret ; $5894
SeniorCourtNpc05TextIds_12:
	; $5895, 30 bytes (text_ids)
	table_width 2
	dw Text_AllieSeniorPartnerIsChamp ; record 0
	dw Text_AllieSeniorPartnerHitsHard ; record 1
	dw Text_AllieSeniorChampTooGood ; record 2
	dw Text_AllieSeniorChampTooGood ; record 3
	dw Text_AllieSeniorCarryYouHigher ; record 4
	dw Text_AllieSeniorServeVolleyLost ; record 5
	dw Text_AllieSeniorDoublesChampWontYield ; record 6
	dw Text_AllieSeniorDoublesChampWontYield ; record 7
	dw Text_AllieSeniorDoublesWontMakeChamp ; record 8
	dw Text_AllieSeniorAlreadyVarsity ; record 9
	dw Text_SeniorMadeDoublesVarsity ; record 10
	dw Text_AllieSeniorMissEmilyCoaching ; record 11
	dw Text_SeniorOpenNotJustDream ; record 12
	dw Text_AllieSeniorEmilyBestCoach ; record 13
	dw Text_SeniorEveryoneHasGoals ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
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
	jr z, .doublesRank3 ; $58c9
	script_speak ACTOR_ROLE_SENIOR_COURT_JOY ; $58cb
	ret ; $58d0
.doublesRank3:
	script_speak_restore ACTOR_SENIOR_COURT_B_JOY ; $58d1
	farcall RunDialogueYesNoPrompt ; $58d6
	farcall ScriptCloseDialogueWindow ; $58d9
	script_wait_frames 5 ; $58dc
	and a ; $58e3
	jr z, .speak ; $58e4
	farcall AdvanceDialogueTextCursor ; $58e6
	ld a, [wStoryPartnerGender] ; $58e9
	or a ; $58ec
	jr nz, .speak ; $58ed
	farcall AdvanceDialogueTextCursor ; $58ef
.speak:
	script_speak ACTOR_SENIOR_COURT_B_JOY ; $58f2
	ret ; $58f7
SeniorCourtNpc06TextIds_12:
	; $58f8, 30 bytes (text_ids)
	table_width 2
	dw Text_JoySeniorDoubleVsSingleHanded ; record 0
	dw Text_JoySeniorDoubleVsSingleHanded ; record 1
	dw Text_JoySeniorSecondConceited ; record 2
	dw Text_JoySeniorImNextForYou ; record 3
	dw Text_JoySeniorNowNumberThree ; record 4
	dw Text_JoySeniorRelievedYouBeatSecond ; record 5
	dw Text_JoySeniorHardToMakeSenior ; record 6
	dw Text_JoySeniorDoublesFaceEachOther ; record 7
	dw Text_JoySeniorDoublesThrillingLoss ; record 8
	dw Text_JoySeniorYoullMakeTravelingTeam ; record 9
	dw Text_JoySeniorDoublesFormidable ; record 10
	dw Text_JoySeniorHopeKevinWins ; record 11
	dw Text_JoySeniorAlreadyGoingToOpen ; record 12
	dw Text_JoySeniorGladYouWonOpen ; record 13
	dw Text_JoySeniorYouTwoOpenChamps ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
SeniorCourtNpc07_12:
	ld a, [wMapSceneStage2] ; $5916
	add a ; $5919
	ld_hl_indexed SeniorCourtNpc07TextIds ; $591a
	ld a, [hl+] ; $5921
	ld h, [hl] ; $5922
	ld l, a ; $5923
	farcall InitDialogueTextCursor ; $5924
	script_speak ACTOR_SENIOR_COURT_BRIAN ; $5927
	ret ; $592c
SeniorCourtNpc07TextIds:
	; $592d, 30 bytes (text_ids)
	table_width 2
	dw Text_BrianSeniorSliceKeepsMeFourth ; record 0
	dw Text_BrianSeniorMasterSlice ; record 1
	dw Text_BrianSeniorNotSoEasy ; record 2
	dw Text_BrianSeniorSkillIsReal ; record 3
	dw Text_BrianSeniorSkillIsReal ; record 4
	dw Text_BrianSeniorSkillIsReal ; record 5
	dw Text_BrianSeniorFloundering ; record 6
	dw Text_BrianSeniorDoublesShowExperience ; record 7
	dw Text_BrianSeniorDoublesExperienceFailed ; record 8
	dw Text_BrianSeniorOnlyFourTravel ; record 9
	dw Text_BrianSeniorDoublesTopRankOpens ; record 10
	dw Text_BrianSeniorRootingForEmily ; record 11
	dw Text_BrianSeniorDoublesCommunicate ; record 12
	dw Text_BrianSeniorEmilyDidWell ; record 13
	dw Text_BrianSeniorChampsPointers ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
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
	script_face ACTOR_SENIOR_COURT_BETH, FACE_UP ; $5965
	script_set_anim ACTOR_SENIOR_COURT_BETH, ANIM_SWING_LOOP ; $596c
.altText:
	script_speak ACTOR_SENIOR_COURT_BETH ; $5973
	ret ; $5978
.speak:
	script_speak_restore ACTOR_SENIOR_COURT_A_BETH ; $5979
	farcall RunDialogueYesNoPrompt ; $597e
	farcall ScriptCloseDialogueWindow ; $5981
	script_wait_frames 5 ; $5984
	and a ; $598b
	jr z, .doublesLine ; $598c
	script_speak ACTOR_SENIOR_COURT_BETH ; $598e
	ret ; $5993
.doublesLine:
	farcall AdvanceDialogueTextCursor ; $5994
	script_set_anim ACTOR_SENIOR_COURT_BETH, ANIM_BOUNCE ; $5997
	script_wait_idle ACTOR_SENIOR_COURT_BETH ; $599e
	script_speak_restore ACTOR_SENIOR_COURT_A_BETH ; $59a3
	farcall RunDialogueYesNoPrompt ; $59a8
	farcall ScriptCloseDialogueWindow ; $59ab
	script_wait_frames 5 ; $59ae
	and a ; $59b5
	jr z, .done ; $59b6
	script_speak ACTOR_SENIOR_COURT_BETH ; $59b8
	ret ; $59bd
.done:
	script_wait_frames 10 ; $59be
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_50 ; $59c5
	script_move_target ACTOR_SENIOR_COURT_BETH, 12.0, 21.0 ; $59d0
	script_wait_move ACTOR_SENIOR_COURT_BETH ; $59db
	script_set_actor_script ACTOR_SENIOR_COURT_BETH, ActorScript_12_49 ; $59e0
	script_move_player 10.0, 17.0 ; $59eb
	farcall WaitPlayerMoveDone ; $59f5
	script_wait_actor_script ACTOR_SENIOR_COURT_BETH ; $59f8
	ld hl, wStoryModePlayersXPosition ; $59fd
	ld de, wStoryModeSpawnPosition ; $5a00
	ld bc, wStoryModeSpawnPosition_SIZE ; $5a03
	call CopyMemoryBC ; $5a06
	ld a, STORYENTRY_NONE ; $5a09
	ld [wStoryModeEntryPoint], a ; $5a0b
	ld [wUnusedExitTriggerIdMirror], a ; $5a0e
	ld [wStoryModeExitTriggerRequest], a ; $5a11
	farcall InitStoryMatchSettings ; $5a14
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_PRACTICE ; $5a17
	farcall RunStoryMatch ; $5a24
	farcall RestoreOverworldAfterMatch ; $5a27
	ret ; $5a2a
SeniorCourtNpc08TextIds:
	; $5a2b, 30 bytes (text_ids)
	table_width 2
	dw Text_BethSeniorMoveFeetForServe ; record 0
	dw Text_BethSeniorMoveFeetForServe ; record 1
	dw Text_BethSeniorPracticeMatchOffer ; record 2
	dw Text_BethSeniorRankedBeforeMe ; record 3
	dw Text_BethSeniorRankedBeforeMe ; record 4
	dw Text_BethSeniorRankedBeforeMe ; record 5
	dw Text_BethSeniorDoublesWontHandOver ; record 6
	dw Text_BethSeniorDoublesLostRanking ; record 7
	dw Text_BethSeniorDoublesLostRanking ; record 8
	dw Text_BethSeniorTalentOutdoesExperience ; record 9
	dw Text_BethSeniorChanceToRerank ; record 10
	dw Text_BethSeniorMarkCoolGroovy ; record 11
	dw Text_BethSeniorBelieveYoureBest ; record 12
	dw Text_BethSeniorFocusNextOpen ; record 13
	dw Text_BethSeniorBelieveInEachOther ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
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
	script_face ACTOR_SENIOR_COURT_CURT, FACE_DOWN ; $5a61
.speak:
	script_speak ACTOR_ROLE_SENIOR_COURT_CURT ; $5a68
	ret ; $5a6d
SeniorCourtNpc09TextIds:
	; $5a6e, 30 bytes (text_ids)
	table_width 2
	dw Text_CurtSeniorRhythmToToss ; record 0
	dw Text_CurtSeniorRhythmToToss ; record 1
	dw Text_CurtSeniorCenterLineDefense ; record 2
	dw Text_CurtSeniorShowedRankers ; record 3
	dw Text_CurtSeniorShowedRankers ; record 4
	dw Text_CurtSeniorShowedRankers ; record 5
	dw Text_CurtSeniorDoublesThirdIsPride ; record 6
	dw Text_CurtSeniorDoublesPrideGone ; record 7
	dw Text_CurtSeniorDoublesPrideGone ; record 8
	dw Text_CurtSeniorVarsityRankingsTournament ; record 9
	dw Text_CurtSeniorGratefulButMad ; record 10
	dw Text_CurtSeniorFavoritePlayers ; record 11
	dw Text_CurtSeniorNeverGiveUpOpen ; record 12
	dw Text_CurtSeniorWhatPlayWins ; record 13
	dw Text_CurtSeniorNeverGiveUpChamps ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
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
	script_speak ACTOR_ROLE_SENIOR_COURT_BOB ; $5aa4
	ret ; $5aa9
.altText:
	script_speak_restore ACTOR_SENIOR_COURT_B_BOB ; $5aaa
	farcall RunDialogueYesNoPrompt ; $5aaf
	farcall ScriptCloseDialogueWindow ; $5ab2
	script_wait_frames 5 ; $5ab5
	and a ; $5abc
	jr z, .speak ; $5abd
	script_speak ACTOR_SENIOR_COURT_B_BOB ; $5abf
	ret ; $5ac4
.speak:
	farcall AdvanceDialogueTextCursor ; $5ac5
	script_speak_restore ACTOR_SENIOR_COURT_B_BOB ; $5ac8
	farcall RunDialogueYesNoPrompt ; $5acd
	farcall ScriptCloseDialogueWindow ; $5ad0
	script_wait_frames 5 ; $5ad3
	and a ; $5ada
	jr z, .done ; $5adb
	script_speak ACTOR_SENIOR_COURT_B_BOB ; $5add
	ret ; $5ae2
.done:
	script_get_actor_state ACTOR_SENIOR_COURT_B_BOB ; $5ae3
	ld e, l ; $5ae8
	ld d, h ; $5ae9
	ld hl, ACTORF_FLAGS ; $5aea
	add hl, de ; $5aed
	res ACTORFLAGB_PAUSED, [hl] ; $5aee
	res 1, [hl] ; $5af0
	script_set_speed ACTOR_PLAYER, 1.0 ; $5af2
	script_set_speed ACTOR_PARTNER, 1.0 ; $5afa
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_47 ; $5b02
	script_wait_frames 32 ; $5b0d
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_48 ; $5b14
	script_set_actor_script ACTOR_SENIOR_COURT_B_BOB, ActorScript_12_45 ; $5b1f
	script_set_actor_script ACTOR_SENIOR_COURT_B_PAM, ActorScript_12_46 ; $5b2a
	script_move_player 10.0, 17.0 ; $5b35
	farcall WaitPlayerMoveDone ; $5b3f
	script_wait_actor_script ACTOR_PLAYER ; $5b42
	ld hl, wStoryModePlayersXPosition ; $5b47
	ld de, wStoryModeSpawnPosition ; $5b4a
	ld bc, wStoryModeSpawnPosition_SIZE ; $5b4d
	call CopyMemoryBC ; $5b50
	ld a, STORYENTRY_NONE ; $5b53
	ld [wStoryModeEntryPoint], a ; $5b55
	ld [wUnusedExitTriggerIdMirror], a ; $5b58
	ld [wStoryModeExitTriggerRequest], a ; $5b5b
	farcall InitStoryMatchSettings ; $5b5e
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_PRACTICE ; $5b61
	farcall RunStoryMatch ; $5b6e
	farcall RestoreOverworldAfterMatch ; $5b71
	ret ; $5b74
SeniorCourtNpc0ATextIds:
	; $5b75, 30 bytes (text_ids)
	table_width 2
	dw Text_BobSeniorWorstWantRankings ; record 0
	dw Text_BobSeniorWorstWantRankings ; record 1
	dw Text_BobSeniorAttackBallNotOpponent ; record 2
	dw Text_BobSeniorWayToGoRanked ; record 3
	dw Text_BobSeniorWayToGoRanked ; record 4
	dw Text_BobSeniorWayToGoRanked ; record 5
	dw Text_BobSeniorDoublesPracticeOffer ; record 6
	dw Text_BobSeniorAlwaysUnranked ; record 7
	dw Text_BobSeniorAlwaysUnranked ; record 8
	dw Text_BobSeniorTravelingRepresentAcademy ; record 9
	dw Text_BobSeniorNetPlayLesson ; record 10
	dw Text_BobSeniorIronGearNotGeniuses ; record 11
	dw Text_BobSeniorAttackWeakerPlayer ; record 12
	dw Text_BobSeniorMastersFromEffort ; record 13
	dw Text_BobSeniorAlwaysHitToPartner ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
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
	ld a, [wStoryPartnerGender] ; $5bb0
	and a ; $5bb3
	jr nz, .speak ; $5bb4
	farcall AdvanceDialogueTextCursor ; $5bb6
.speak:
	script_speak ACTOR_ROLE_SENIOR_COURT_PAM ; $5bb9
	ret ; $5bbe
SeniorCourtNpc0BTextIds:
	; $5bbf, 30 bytes (text_ids)
	table_width 2
	dw Text_PamSeniorKeepOffCourt ; record 0
	dw Text_PamSeniorKeepOffCourt ; record 1
	dw Text_PamSeniorServeAndRush ; record 2
	dw Text_PamSeniorAggressivePlayer ; record 3
	dw Text_PamSeniorAggressivePlayer ; record 4
	dw Text_PamSeniorAggressivePlayer ; record 5
	dw Text_PamSeniorNeedExperience ; record 6
	dw Text_PamSeniorRankedTeamwork ; record 7
	dw Text_PamSeniorRankedTeamwork ; record 8
	dw Text_PamSeniorNoCheapPlay ; record 9
	dw Text_PamSeniorGrabTournamentChance ; record 10
	dw Text_PamSeniorWonderOpenRackets ; record 11
	dw Text_PamSeniorJealousPartnerSameLevel ; record 12
	dw Text_PamSeniorMostUsedRacket ; record 13
	dw Text_PamSeniorJealousPartnerSameLevel ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
SeniorCourtNpc0C_12:
	ld a, [wStoryPartnerGender] ; $5bdd
	or a ; $5be0
	jr nz, .partnerFemale ; $5be1
	ld a, [wMapSceneStage2] ; $5be3
	add a ; $5be6
	ld_hl_indexed SeniorCourtNpc0C_12Table ; $5be7
	ld a, [hl+] ; $5bee
	ld h, [hl] ; $5bef
	ld l, a ; $5bf0
	farcall InitDialogueTextCursor ; $5bf1
	script_speak ACTOR_SENIOR_COURT_KATE ; $5bf4
	ret ; $5bf9
.partnerFemale:
	ld a, [wMapSceneStage2] ; $5bfa
	add a ; $5bfd
	ld_hl_indexed SeniorCourtNpc0CTextIds ; $5bfe
	ld a, [hl+] ; $5c05
	ld h, [hl] ; $5c06
	ld l, a ; $5c07
	farcall InitDialogueTextCursor ; $5c08
	script_speak ACTOR_SENIOR_COURT_KATE ; $5c0b
	ret ; $5c10
SeniorCourtNpc0CTextIds:
	; $5c11, 30 bytes (text_ids)
	table_width 2
	dw Text_KateSeniorSingleHandedRange ; record 0
	dw Text_KateSeniorSingleHandedRange ; record 1
	dw Text_KateSeniorFeelMoreConfident ; record 2
	dw Text_KateSeniorHappyRankedPartner ; record 3
	dw Text_KateSeniorHappyRankedPartner ; record 4
	dw Text_KateSeniorHappyRankedPartner ; record 5
	dw Text_BobSeniorAlwaysUnranked ; record 6
	dw Text_EmilyOfferDoublesRanking ; record 7
	dw Text_EmilyOfferDoublesRanking ; record 8
	dw Text_KateSeniorWorkOnDoubles ; record 9
	dw Text_SeniorStandInCoachEmilyAway ; record 10
	dw Text_KateSeniorRootingForYou ; record 11
	dw Text_KateSeniorJealousPartnerNoBetter ; record 12
	dw Text_KateSeniorPartnerIsOpenChamp ; record 13
	dw Text_SeniorEveryoneHasGoals ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
SeniorCourtNpc0C_12Table:
	; $5c2f, 30 bytes (text_ids)
	table_width 2
	dw Text_KateSeniorSingleHandedRangeAlt ; record 0
	dw Text_KateSeniorSingleHandedRangeAlt ; record 1
	dw Text_KateSeniorKeepAtItRankings ; record 2
	dw Text_KateSeniorYouBeatMeToRankings ; record 3
	dw Text_KateSeniorYouBeatMeToRankings ; record 4
	dw Text_KateSeniorYouBeatMeToRankings ; record 5
	dw Text_BobSeniorAlwaysUnranked ; record 6
	dw Text_EmilyOfferDoublesRanking ; record 7
	dw Text_EmilyOfferDoublesRanking ; record 8
	dw Text_KateSeniorFocusOnDoubles ; record 9
	dw Text_SeniorStandInCoachEmilyAway ; record 10
	dw Text_KateSeniorWhoCaresRootingForYou ; record 11
	dw Text_KateSeniorJealousPartnerNoBetter ; record 12
	dw Text_KateSeniorLuckyChampPartner ; record 13
	dw Text_SeniorEveryoneHasGoals ; record 14
	assert_table_length NUM_SENIORCOURTSTAGES
SeniorCourtNpcScripts_12:
	; $5c4d, 121 bytes (map_scripts)
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_RIGHT, $0840, SeniorCourtNpc03FaceRight_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_UP, $0840, SeniorCourtNpc03FaceUpFlag0840_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_UP, $0000, SeniorCourtNpc03FaceUpFlag0000_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_ANY, $0000, SeniorCourtNpc03_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_ROLE_SENIOR_COURT_FAY, FACEMASK_ANY, $0000, SeniorCourtNpc04_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_SENIOR_COURT_ALLIE, FACEMASK_ANY, $0000, SeniorCourtNpc05_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ROLE_SENIOR_COURT_JOY, FACEMASK_ANY, $08a0, SeniorCourtNpc06_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ROLE_SENIOR_COURT_JOY, FACEMASK_ANY, $0000, SeniorCourtNpc06_12, NPC_FACE_PLAYER | NPC_FREEZE, $00
	map_script ACTOR_SENIOR_COURT_BRIAN, FACEMASK_ANY, $08a0, SeniorCourtNpc07_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_SENIOR_COURT_BRIAN, FACEMASK_ANY, $0000, SeniorCourtNpc07_12, NPC_FACE_PLAYER, $00
	map_script ACTOR_SENIOR_COURT_BETH, FACEMASK_ANY, $0000, SeniorCourtNpc08_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM, $00
	map_script ACTOR_ROLE_SENIOR_COURT_CURT, FACEMASK_ANY, $0000, SeniorCourtNpc09_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ROLE_SENIOR_COURT_BOB, FACEMASK_ANY, $0000, SeniorCourtNpc0A_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ROLE_SENIOR_COURT_PAM, FACEMASK_ANY, $0000, SeniorCourtNpc0B_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_SENIOR_COURT_KATE, FACEMASK_ANY, $0000, SeniorCourtNpc0C_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
SeniorCourtFacingScripts_12:
	ds 1, $ff ; $5cc6, fill
SeniorCourtTileTriggers_12:
	; $5cc7, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0f80, SeniorCourtTile01_12, $00, $00
	db $ff
SeniorCourtTile01_12:
	set_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5cd0
	script_null_script ACTOR_ROLE_SENIOR_COURT_BOB ; $5cd3
	script_null_script ACTOR_ROLE_SENIOR_COURT_PAM ; $5cd8
	script_set_anim ACTOR_ROLE_SENIOR_COURT_BOB, ANIM_WALK ; $5cdd
	script_set_anim ACTOR_ROLE_SENIOR_COURT_PAM, ANIM_WALK ; $5ce4
	script_move_target ACTOR_ROLE_SENIOR_COURT_BOB, 20.0, 19.0 ; $5ceb
	script_move_target ACTOR_ROLE_SENIOR_COURT_PAM, 20.0, 15.0 ; $5cf6
	script_wait_move ACTOR_ROLE_SENIOR_COURT_BOB ; $5d01
	script_wait_move ACTOR_ROLE_SENIOR_COURT_PAM ; $5d06
	script_face_toward ACTOR_PLAYER, ACTOR_ROLE_SENIOR_COURT_BOB ; $5d0b
	script_face_toward ACTOR_PLAYER, ACTOR_ROLE_SENIOR_COURT_PAM ; $5d13
	ret ; $5d1b
SeniorCourtInitScript_12:
	call ComputeRankingProgressIndex_12 ; $5d1c
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
	script_null_script ACTOR_SENIOR_COURT_BOB ; $5d3d
	script_null_script ACTOR_SENIOR_COURT_PAM ; $5d42
	script_set_anim ACTOR_SENIOR_COURT_BOB, ANIM_WALK ; $5d47
	script_set_anim ACTOR_SENIOR_COURT_PAM, ANIM_WALK ; $5d4e
	script_set_position ACTOR_SENIOR_COURT_BOB, 20.0, 19.0 ; $5d55
	script_set_position ACTOR_SENIOR_COURT_PAM, 20.0, 15.0 ; $5d60
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_BOB ; $5d6b
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_PAM ; $5d73
.fromMatch:
	test_flag FLAG_DOUBLES ; $5d7b
	jr nz, .done ; $5d7e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5d80
	jr z, .placeActors ; $5d83
	script_respawn_actors SeniorCourtActorsA_12 ; $5d85
.placeActors:
	call SeniorCourtPositionActorsByProgressA ; $5d8d
	call SetPartnerObjDefByGender_12 ; $5d90
	ld a, [wStoryModeEntryPoint] ; $5d93
	cp ENTRY_SENIOR_CLASS_COURT_MATCH_RETURN ; $5d96
	jp z, SeniorCourtPostMatchReturn ; $5d98
	cp ENTRY_SENIOR_CLASS_COURT_MATCH_WON ; $5d9b
	jp z, SeniorCourtReloadIntoVictoryScene ; $5d9d
	cp ENTRY_SENIOR_CLASS_COURT_VICTORY_SCENE ; $5da0
	jp z, SeniorMatchVictorySceneDispatch ; $5da2
	call SeniorCourtPositionActorsByProgressB ; $5da5
	farcall EndCutsceneScriptMode ; $5da8
	call SeniorCourtWalkPlayersOntoCourt ; $5dab
	ret ; $5dae
.done:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5daf
	jr z, .placeActors ; $5db2
	script_respawn_actors SeniorCourtActorsB_12 ; $5db4
	jr .placeActors ; $5dbc
SeniorCourtPositionActorsByProgressB:
	ld a, [wMapSceneStage2] ; $5dbe
	cp SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN ; $5dc1
	jr c, .checkDoubles ; $5dc3
	cp SENIORCOURTSTAGE_SINGLES_COMPLETE ; $5dc5
	jr nc, .checkDoubles ; $5dc7
	script_get_actor_state ACTOR_SENIOR_COURT_A_EMILY ; $5dc9
	ld c, l ; $5dce
	ld b, h ; $5dcf
	ld d, OBJ_STUDENT_BLACK_HAIR_BOY ; $5dd0
	farcall LoadActorObjectDefIfValid ; $5dd2
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_WALK ; $5dd5
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5ddc
	jr nz, .doubles ; $5ddf
	ld a, [wMapSceneStage2] ; $5de1
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $5de4
	jr c, .done ; $5de6
	script_set_position ACTOR_ROLE_SENIOR_COURT_FAY, 63.0, 63.0 ; $5de8
.done:
	ret ; $5df3
.doubles:
	ld a, [wMapSceneStage2] ; $5df4
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5df7
	jr c, .done ; $5df9
	script_set_position ACTOR_ROLE_SENIOR_COURT_FAY, 63.0, 63.0 ; $5dfb
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, 63.0, 63.0 ; $5e06
	ret ; $5e11
SeniorCourtPositionActorsByProgressA:
	test_flag FLAG_DOUBLES ; $5e12
	jr nz, .isDoubles ; $5e15
	ld a, [wMapSceneStage2] ; $5e17
	cp SENIORCOURTSTAGE_SINGLES_RANK3 ; $5e1a
	jr c, .checkStage9 ; $5e1c
	script_set_position ACTOR_SENIOR_COURT_A_BRIAN, 27.0, 13.0 ; $5e1e
	script_face ACTOR_SENIOR_COURT_A_BRIAN, FACE_LEFT ; $5e29
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
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $5e3f
	jr nc, .checkStage10 ; $5e41
	script_set_position ACTOR_SENIOR_COURT_A_CURT, 27.0, 11.0 ; $5e43
	script_set_position ACTOR_SENIOR_COURT_A_BETH, 27.0, 13.0 ; $5e4e
	script_face ACTOR_SENIOR_COURT_A_CURT, FACE_LEFT ; $5e59
	script_face ACTOR_SENIOR_COURT_A_BETH, FACE_LEFT ; $5e60
	script_null_script ACTOR_SENIOR_COURT_A_BETH ; $5e67
	script_set_anim ACTOR_SENIOR_COURT_A_BETH, ANIM_WALK ; $5e6c
.checkStage10:
	ld a, [wMapSceneStage2] ; $5e73
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5e76
	jr c, .checkStage9 ; $5e78
	script_set_position ACTOR_ROLE_SENIOR_COURT_FAY, 63.0, 63.0 ; $5e7a
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, 63.0, 63.0 ; $5e85
	ret ; $5e90
