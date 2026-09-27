SpeakNpc03SinglesOrDoublesLine_10:
	test_flag FLAG_DOUBLES ; $73ee
	jr z, .doubles ; $73f1
	farcall AdvanceDialogueTextCursor ; $73f3
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $73f6
	ret ; $73fb
.doubles:
	script_speak ACTOR_ACADEMY_WING_INIT1_WALK_75_06 ; $73fc
	farcall AdvanceDialogueTextCursor ; $7401
	ret ; $7404
ShowNpc03SinglesOrDoublesPrompt_10:
	test_flag FLAG_DOUBLES ; $7405
	jr z, .notDoubles ; $7408
	farcall AdvanceDialogueTextCursor ; $740a
	ld a, $03 ; $740d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $740f
	ret ; $7412
.notDoubles:
	ld a, $03 ; $7413
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7415
	farcall AdvanceDialogueTextCursor ; $7418
	ret ; $741b
ActorScript_10_0:
	; $741c, 13 bytes (actor_script)
	as_set_target $2100, $3b00
	as_wait_move
	as_set_target $3500, $3b00
	as_wait_move
	as_halt
AcademyWingInstallDoorTriggers_10:
	ld a, [wMapSceneStage] ; $7429
	cp ACADEMYWINGSTAGE_COMPLETE ; $742c
	jr nz, .done ; $742e
	ld a, $11 ; $7430
	ld d, $20 ; $7432
	ld e, $3a ; $7434
	farcall WriteBehaviorMapCell ; $7436
	ld a, $21 ; $7439
	ld d, $20 ; $743b
	ld e, $36 ; $743d
	farcall WriteBehaviorMapCell ; $743f
.done:
	ret ; $7442
AcademyWingHideActorByProgressFlag_10:
	script_set_anim $04, $06 ; $7443
	test_flag FLAG_DOUBLES ; $744a
	jr z, .checkFlag ; $744d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $744f
	jr nz, .done ; $7452
	script_set_position $04, $0100, $0100 ; $7454
	jr .done ; $745f
.checkFlag:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7461
	jr nz, .done ; $7464
	script_set_position $05, $0100, $0100 ; $7466
.done:
	ret ; $7471
SetAcademyWingDialogueStage_10:
	ld a, ACADEMYWINGSTAGE_PRE_SENIOR_CHAMP ; $7472
	test_flag FLAG_DOUBLES ; $7474
	jr z, .checkFlag ; $7477
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7479
	jr z, .step ; $747c
	ld a, ACADEMYWINGSTAGE_SENIOR_CHAMP ; $747e
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7480
	jr z, .step ; $7483
	ld a, ACADEMYWINGSTAGE_ISLAND_OPEN ; $7485
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7487
	jr z, .step ; $748a
	ld a, ACADEMYWINGSTAGE_COMPLETE ; $748c
	jr .step ; $748e
.checkFlag:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7490
	jr z, .step ; $7493
	ld a, ACADEMYWINGSTAGE_SENIOR_CHAMP ; $7495
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7497
	jr z, .step ; $749a
	ld a, ACADEMYWINGSTAGE_ISLAND_OPEN ; $749c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $749e
	jr z, .step ; $74a1
	ld a, ACADEMYWINGSTAGE_COMPLETE ; $74a3
.step:
	ld [wMapSceneStage], a ; $74a5
	ret ; $74a8
AcademyMainBldgMapScripts_10:
	; $74a9, 14 bytes (map_tree)
	dw AcademyMainBldgEntryPoints_10 ; slot 0 EntryPoints
	dw AcademyMainBldgExitTriggers_10 ; slot 1 ExitTriggers
	dw AcademyMainBldgActors_10 ; slot 2 Actors
	dw AcademyMainBldgNpcScripts_10 ; slot 3 NpcScripts
	dw AcademyMainBldgFacingScripts_10 ; slot 4 FacingScripts
	dw AcademyMainBldgTileTriggers_10 ; slot 5 TileTriggers
	dw AcademyMainBldgInitScript_10 ; slot 6 InitScript
AcademyMainBldgActors_10:
	; $74b7, 66 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $1d00, $1780, FACE_DOWN, OBJ_WALK_72_08, $01, $04, ACADEMY_MAIN_BLDG_WALK_72_08_1
	map_actor $0000, ActorScript_10_2, $0e80, $0f00, FACE_LEFT, OBJ_WALK_73_00, $01, $00, ACADEMY_MAIN_BLDG_WALK_73_00
	map_actor $0000, ActorScript_10_2, $0500, $0f80, FACE_DOWN, OBJ_WALK_72_08, $01, $07, ACADEMY_MAIN_BLDG_WALK_72_08_2
	map_actor $0000, ActorScript_10_3, $2800, $1e00, FACE_DOWN, OBJ_WALK_73_01, $01, $03, ACADEMY_MAIN_BLDG_WALK_73_01
	map_actor_end
AcademyMainBldgEntryPoints_10:
	; $74f9, 57 bytes (map_entries)
	map_entry $01, FACE_UP, $2200, $2100, AcademyMainBldgArrival01_10
	map_entry $02, FACE_DOWN, $2200, $0700, AcademyMainBldgArrival02_10
	map_entry $03, FACE_DOWN, $3500, $1900, MapArrivalWalkPair_10
	map_entry $04, FACE_DOWN, $3b00, $3900, MapArrivalWalkPair_10
	map_entry $0d, FACE_UP, $2100, $3b00, $0000
	map_entry $0e, FACE_UP, $2200, $1300, $0000
	map_entry $0f, FACE_UP, $2200, $1d00, $0000
	db $ff
; Instruction-identical to AcademyArrivalArrival01_11 and DormEntranceArrival02_12 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival02, AcademyMainBldgArrival02_10 ; $7532
; Instruction-identical to RestaurantArrival01_10, MapArrivalWalk_11, DormEntranceArrival01_12 and RestaurantPlazaArrival04_13 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival01, AcademyMainBldgArrival01_10 ; $7578
AcademyMainBldgExitTriggers_10:
	; $75be, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $03
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_ACADEMY_WING, $01
	map_script $04, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_ACADEMY_MAIN_BLDG, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $0f
	db $ff
AcademyMainBldgNpc03_10:
	ld a, [wMapSceneStage] ; $75e7
	sra a ; $75ea
	add a ; $75ec
	ld_hl_indexed AcademyMainBldgNpc03TextIds ; $75ed
	ld a, [hl+] ; $75f4
	ld h, [hl] ; $75f5
	ld l, a ; $75f6
	farcall InitDialogueTextCursor ; $75f7
	ld a, [wMapSceneStage] ; $75fa
	sra a ; $75fd
	cp STORYTIER_ISLAND_OPEN ; $75ff
	jr z, .eq03 ; $7601
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_1 ; $7603
	ret ; $7608
.eq03:
	ld a, $03 ; $7609
	farcall ScriptShowSpeakerDialogueRestoreBG ; $760b
	farcall RunDialogueYesNoPrompt ; $760e
	farcall ScriptCloseDialogueWindow ; $7611
	script_wait_frames $05 ; $7614
	and a ; $761b
	jr z, .speak ; $761c
	farcall AdvanceDialogueTextCursor ; $761e
.speak:
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_1 ; $7621
	ret ; $7626
AcademyMainBldgNpc03TextIds:
	; $7627, 10 bytes (text_ids)
	dw Text_30_440 ; record 0
	dw Text_30_443 ; record 1
	dw Text_30_446 ; record 2
	dw Text_30_452 ; record 3
	dw Text_30_457 ; record 4
AcademyMainBldgNpc04_10:
	ld a, [wMapSceneStage] ; $7631
	sra a ; $7634
	add a ; $7636
	ld_hl_indexed AcademyMainBldgNpc04TextIds ; $7637
	ld a, [hl+] ; $763e
	ld h, [hl] ; $763f
	ld l, a ; $7640
	farcall InitDialogueTextCursor ; $7641
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_73_00 ; $7644
	ret ; $7649
AcademyMainBldgNpc04TextIds:
	; $764a, 10 bytes (text_ids)
	dw Text_30_441 ; record 0
	dw Text_30_444 ; record 1
	dw Text_30_447 ; record 2
	dw Text_30_455 ; record 3
	dw Text_30_458 ; record 4
AcademyMainBldgNpc05_10:
	script_set_text Text_30_462 ; $7654
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2 ; $765a
	script_face ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2, FACE_DOWN ; $765f
	test_flag FLAG_DOUBLES ; $7666
	jr nz, AcademyMainBldgNpc05TextIds.setText ; $7669
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2 ; $766b
	ld a, [wMapSceneStage] ; $7670
	sra a ; $7673
	add a ; $7675
	ld_hl_indexed AcademyMainBldgNpc05TextIds ; $7676
	ld a, [hl+] ; $767d
	ld h, [hl] ; $767e
	ld l, a ; $767f
	farcall InitDialogueTextCursor ; $7680
.loop:
	script_wait_frames $14 ; $7683
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2 ; $768a
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2 ; $7692
	ret ; $7697
AcademyMainBldgNpc05TextIds:
	; $7698, 10 bytes (text_ids)
	dw Text_30_464 ; record 0
	dw Text_30_465 ; record 1
	dw Text_30_466 ; record 2
	dw Text_30_467 ; record 3
	dw Text_30_468 ; record 4
.setText:
	script_set_text Text_30_469 ; $76a2
	script_wait_frames $14 ; $76a8
	script_speak $05 ; $76af
	call GetDoublesProgressStage_10 ; $76b4
	add a ; $76b7
	ld_hl_indexed AcademyMainBldgNpc05TextIds2 ; $76b8
	ld a, [hl+] ; $76bf
	ld h, [hl] ; $76c0
	ld l, a ; $76c1
	farcall InitDialogueTextCursor ; $76c2
	jr AcademyMainBldgNpc05_10.loop ; $76c5
AcademyMainBldgNpc05TextIds2:
	; $76c7, 10 bytes (text_ids)
	dw Text_30_470 ; record 0
	dw Text_30_471 ; record 1
	dw Text_30_472 ; record 2
	dw Text_30_473 ; record 3
	dw Text_30_474 ; record 4
AcademyMainBldgNpc06_10:
	ld a, [wMapSceneStage] ; $76d1
	sra a ; $76d4
	add a ; $76d6
	ld_hl_indexed AcademyMainBldgNpc06TextIds ; $76d7
	ld a, [hl+] ; $76de
	ld h, [hl] ; $76df
	ld l, a ; $76e0
	farcall InitDialogueTextCursor ; $76e1
	script_speak ACTOR_ACADEMY_MAIN_BLDG_WALK_73_01 ; $76e4
	ret ; $76e9
AcademyMainBldgNpc06TextIds:
	; $76ea, 10 bytes (text_ids)
	dw Text_30_442 ; record 0
	dw Text_30_445 ; record 1
	dw Text_30_448 ; record 2
	dw Text_30_456 ; record 3
	dw Text_30_459 ; record 4
AcademyMainBldgNpcScripts_10:
	; $76f4, 33 bytes (map_scripts)
	map_script ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_1, FACEMASK_ANY, $0000, AcademyMainBldgNpc03_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ACADEMY_MAIN_BLDG_WALK_73_00, FACEMASK_ANY, $0000, AcademyMainBldgNpc04_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_2, FACEMASK_ANY, $0000, AcademyMainBldgNpc05_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ACADEMY_MAIN_BLDG_WALK_73_01, FACEMASK_ANY, $0000, AcademyMainBldgNpc06_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
AcademyMainBldgFacingScripts_10:
	ds 1, $ff ; $7715, fill
AcademyMainBldgTileTriggers_10:
	ds 1, $ff ; $7716, fill
AcademyMainBldgInitScript_10:
	call SetStoryDialogueStage_10 ; $7717
	ld a, [wMapSceneStage] ; $771a
	sra a ; $771d
	cp STORYTIER_SENIOR_CHAMP ; $771f
	jr nz, .ne02 ; $7721
	script_set_actor_script ACTOR_ACADEMY_MAIN_BLDG_WALK_72_08_1, ActorScript_10_1 ; $7723
.ne02:
	ld a, $01 ; $772e
	ld hl, UpdatePlayerPairTileAnimState_10 ; $7730
	call RegisterFrameTask ; $7733
	ld a, [wStoryModeEntryPoint] ; $7736
	cp $0f ; $7739
	jr nz, .done ; $773b
	call AcademyMainBldgNewStudentCutscene_10 ; $773d
.done:
	ret ; $7740
AcademyMainBldgNewStudentCutscene_10:
	ldh a, [hRomBank] ; $7741
	ld hl, AcademyMainBldgNewStudentActors_10 ; $7743
	farcall ScriptRespawnLocationActors ; $7746
	farcall BeginCutsceneScriptMode ; $7749
	script_set_position ACTOR_PLAYER, $2200, $2580 ; $774c
	script_set_position ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY, $2200, $2400 ; $7757
	script_fade_in $04 ; $7762
	script_wait_frames $1e ; $7767
	script_face ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY, FACE_UP ; $776e
	script_wait_frames $0a ; $7775
	script_set_anim ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, $02 ; $777c
	script_wait_frames $1e ; $7783
	script_move_target ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY, $2200, $1700 ; $778a
	script_move_player $2200, $1700 ; $7795
	script_wait_frames $0a ; $779f
	script_move_target ACTOR_PLAYER, $2200, $1900 ; $77a6
	script_face ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, FACE_RIGHT ; $77b1
	farcall WaitPlayerMoveDone ; $77b8
	script_set_text Text_30_430 ; $77bb
	script_speak ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08 ; $77c1
	script_wait_move ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $77c6
	script_wait_frames $0a ; $77cb
	script_move_player $1d00, $1900 ; $77d2
	script_face_toward ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $77dc
	script_wait_frames $1e ; $77e4
	script_face_toward ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, ACTOR_PLAYER ; $77eb
	script_wait_frames $1e ; $77f3
	farcall WaitPlayerMoveDone ; $77fa
	script_set_anim ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, $03 ; $77fd
	script_wait_idle ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08 ; $7804
	script_speak ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08 ; $7809
	script_wait_frames $0a ; $780e
	script_set_anim ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY, $03 ; $7815
	script_wait_idle ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $781c
	script_speak ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $7821
	script_face_toward ACTOR_PLAYER, ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $7826
	script_wait_frames $32 ; $782e
	script_face_toward ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08, ACTOR_ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY ; $7835
	script_wait_frames $1e ; $783d
	ld a, [wStoryModeGenderOfMainCharacter] ; $7844
	or a ; $7847
	jr z, .speak ; $7848
	farcall AdvanceDialogueTextCursor ; $784a
.speak:
	script_speak $03 ; $784d
	ld a, [wStoryModeGenderOfMainCharacter] ; $7852
	or a ; $7855
	jr nz, .wait ; $7856
	farcall AdvanceDialogueTextCursor ; $7858
.wait:
	script_wait_frames $0f ; $785b
	script_set_anim $04, $03 ; $7862
	script_wait_idle $04 ; $7869
	script_speak $04 ; $786e
	script_wait_frames $0f ; $7873
	script_set_anim ACTOR_PLAYER, $03 ; $787a
	script_wait_idle ACTOR_PLAYER ; $7881
	script_wait_frames $0f ; $7886
	script_set_anim $04, $03 ; $788d
	script_wait_idle $04 ; $7894
	script_speak $04 ; $7899
	script_wait_frames $0f ; $789e
	script_set_anim $03, $02 ; $78a5
	script_wait_idle $03 ; $78ac
	script_speak $03 ; $78b1
	script_face_toward $03, ACTOR_PLAYER ; $78b6
	script_set_position $06, $2300, $1700 ; $78be
	sound SFX_EMOTE ; $78c9
	script_wait_frames $3c ; $78cb
	script_set_position $06, $3f00, $3f00 ; $78d2
	script_set_anim $04, $03 ; $78dd
	script_wait_idle $04 ; $78e4
	script_speak $04 ; $78e9
	script_set_anim ACTOR_PLAYER, $02 ; $78ee
	script_wait_idle ACTOR_PLAYER ; $78f5
	script_wait_frames $0a ; $78fa
	script_face_toward $04, ACTOR_PLAYER ; $7901
	script_set_anim ACTOR_PLAYER, $03 ; $7909
	script_wait_idle ACTOR_PLAYER ; $7910
	script_wait_frames $0f ; $7915
	script_face_pair $04, $03 ; $791c
	script_set_anim $03, $03 ; $7924
	script_set_anim $04, $03 ; $792b
	script_wait_idle $04 ; $7932
	script_move_player $2200, $1700 ; $7937
	script_wait_frames $28 ; $7941
	script_move_target $03, $2200, $0300 ; $7948
	script_wait_frames $0a ; $7953
	script_move_player $2200, $0300 ; $795a
	script_move_target ACTOR_PLAYER, $2200, $0300 ; $7964
	script_wait_move ACTOR_PLAYER ; $796f
	ld a, $0f ; $7974
	ld [wUnusedExitTriggerIdMirror], a ; $7976
	ld [wStoryModeExitTriggerRequest], a ; $7979
	farcall EndCutsceneScriptMode ; $797c
	ret ; $797f
AcademyMainBldgNewStudentActors_10:
	; $7980, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $2b00, $0b00, FACE_DOWN, OBJ_EMILY, $01, $00, ACADEMY_MAIN_BLDG_NEW_STUDENT_EMILY
	map_actor $0000, ActorScript_10_2, $1d00, $1700, FACE_DOWN, OBJ_WALK_72_08, $01, $04, ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_72_08
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_12, $01, $00, ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_73_12
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_13, $01, $00, ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_73_13
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_15, $01, $00, ACADEMY_MAIN_BLDG_NEW_STUDENT_WALK_73_15
	map_actor_end
UpdatePlayerPairTileAnimState_10:
	ld a, $00 ; $79d0
	call UpdateActorTileAnimState_10 ; $79d2
	test_flag FLAG_DOUBLES ; $79d5
	ret z ; $79d8
	ld a, $02 ; $79d9
	call UpdateActorTileAnimState_10 ; $79db
	ret ; $79de
UpdateActorTileAnimState_10:
	ld h, a ; $79df
	ld l, $00 ; $79e0
	push af ; $79e2
	wram_bank WRAM_ACTORS ; $79e3
	srl h ; $79e9
	rr l ; $79eb
	srl h ; $79ed
	rr l ; $79ef
	ld bc, wActors ; $79f1
	add hl, bc ; $79f4
	ld b, h ; $79f5
	ld c, l ; $79f6
	ld hl, ACTORF_X ; $79f7
	add hl, bc ; $79fa
	ld a, [hl+] ; $79fb
	ld h, [hl] ; $79fc
	ld l, a ; $79fd
	ld de, $ffb0 ; $79fe
	add hl, de ; $7a01
	ld d, h ; $7a02
	ld hl, ACTORF_Y ; $7a03
	add hl, bc ; $7a06
	ld a, [hl+] ; $7a07
	add $40 ; $7a08
	ld a, [hl] ; $7a0a
	adc $00 ; $7a0b
	ld e, a ; $7a0d
	dec e ; $7a0e
	pop af ; $7a0f
	or a ; $7a10
	jr z, .readCell ; $7a11
	dec e ; $7a13
	dec e ; $7a14
.readCell:
	push de ; $7a15
	call ReadSceneTilemapTile_10 ; $7a16
	pop de ; $7a19
	and $87 ; $7a1a
	cp $06 ; $7a1c
	jr nz, .checkBelow ; $7a1e
	wram_bank WRAM_ACTORS ; $7a20
	ld hl, ACTORF_MODE ; $7a26
	add hl, bc ; $7a29
	ld a, [hl] ; $7a2a
	xor $01 ; $7a2b
	ld [hl], a ; $7a2d
	ret ; $7a2e
.checkBelow:
	inc d ; $7a2f
	call ReadSceneTilemapTile_10 ; $7a30
	and $07 ; $7a33
	cp $06 ; $7a35
	jr nz, .actorLoop ; $7a37
	wram_bank WRAM_ACTORS ; $7a39
	ld hl, ACTORF_MODE ; $7a3f
	add hl, bc ; $7a42
	ld a, [hl] ; $7a43
	xor $01 ; $7a44
	ld [hl], a ; $7a46
	ret ; $7a47
.actorLoop:
	wram_bank WRAM_ACTORS ; $7a48
	ld hl, ACTORF_MODE ; $7a4e
	add hl, bc ; $7a51
	ld a, $02 ; $7a52
	ld [hl], a ; $7a54
	ret ; $7a55
; UpdateActorTileAnimState_10 without the push af / pop af / or a / jr z zero-argument guard. Nothing calls it.
Unused_10_UpdateActorTileAnimStateByIndex:
	ld h, a ; $7a56
	ld l, $00 ; $7a57
	wram_bank WRAM_ACTORS ; $7a59
	srl h ; $7a5f
	rr l ; $7a61
	srl h ; $7a63
	rr l ; $7a65
	ld bc, wActors ; $7a67
	add hl, bc ; $7a6a
	ld b, h ; $7a6b
	ld c, l ; $7a6c
	ld hl, ACTORF_X ; $7a6d
	add hl, bc ; $7a70
	ld a, [hl+] ; $7a71
	ld h, [hl] ; $7a72
	ld l, a ; $7a73
	ld de, $ffb0 ; $7a74
	add hl, de ; $7a77
	ld d, h ; $7a78
	ld hl, ACTORF_Y ; $7a79
	add hl, bc ; $7a7c
	ld a, [hl+] ; $7a7d
	add $40 ; $7a7e
	ld a, [hl] ; $7a80
	adc $00 ; $7a81
	ld e, a ; $7a83
	dec e ; $7a84
	dec e ; $7a85
	dec e ; $7a86
	push de ; $7a87
	call ReadSceneTilemapTile_10 ; $7a88
	pop de ; $7a8b
	and $87 ; $7a8c
	cp $06 ; $7a8e
	jr nz, .nextActor ; $7a90
	wram_bank WRAM_ACTORS ; $7a92
	ld hl, ACTORF_MODE ; $7a98
	add hl, bc ; $7a9b
	ld a, [hl] ; $7a9c
	xor $01 ; $7a9d
	ld [hl], a ; $7a9f
	ret ; $7aa0
.nextActor:
	inc d ; $7aa1
	call ReadSceneTilemapTile_10 ; $7aa2
	and $07 ; $7aa5
	cp $06 ; $7aa7
	jr nz, .done ; $7aa9
	wram_bank WRAM_ACTORS ; $7aab
	ld hl, ACTORF_MODE ; $7ab1
	add hl, bc ; $7ab4
	ld a, [hl] ; $7ab5
	xor $01 ; $7ab6
	ld [hl], a ; $7ab8
	ret ; $7ab9
.done:
	wram_bank WRAM_ACTORS ; $7aba
	ld hl, ACTORF_MODE ; $7ac0
	add hl, bc ; $7ac3
	ld a, $02 ; $7ac4
	ld [hl], a ; $7ac6
	ret ; $7ac7
