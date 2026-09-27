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
	map_actor $0000, ActorScript_12_51, $2900, $1900, FACE_LEFT, OBJ_EMILY, $01, $00, SENIOR_COURT_EMILY
	map_actor $0000, ActorScript_12_43, $3500, $1e00, FACE_UP, OBJ_FAY, $06, $07, SENIOR_COURT_FAY
	map_actor $0000, ActorScript_12_57, $3200, $1e00, FACE_RIGHT, OBJ_ALLIE, $01, $05, SENIOR_COURT_ALLIE
	map_actor $0000, ActorScript_12_52, $3300, $1100, FACE_LEFT, OBJ_JOY, $01, $04, SENIOR_COURT_JOY
	map_actor $0000, ActorScript_12_51, $2900, $1300, FACE_LEFT, OBJ_BRIAN, $01, $06, SENIOR_COURT_BRIAN
	map_actor $0000, ActorScript_12_43, $0b00, $1500, FACE_UP, OBJ_BETH, $01, $05, SENIOR_COURT_BETH
	map_actor $0000, ActorScript_12_58, $0b00, $1300, FACE_DOWN, OBJ_CURT, $01, $03, SENIOR_COURT_CURT
	map_actor $0000, ActorScript_12_56, $1500, $1700, FACE_UP, OBJ_BOB, $01, $06, SENIOR_COURT_BOB
	map_actor $0000, ActorScript_12_55, $1300, $0b00, FACE_DOWN, OBJ_PAM, $01, $03, SENIOR_COURT_PAM
	map_actor $05e0, ActorScript_12_52, $0900, $0b00, FACE_DOWN, OBJ_KATE, $01, $00, SENIOR_COURT_KATE
	map_actor $0000, ActorScript_12_53, $2200, $1300, FACE_DOWN, OBJ_WALK_74_00, $01, $00, SENIOR_COURT_WALK_74_00_1
	map_actor $0000, ActorScript_12_54, $2500, $1d00, FACE_UP, OBJ_WALK_74_00, $01, $04, SENIOR_COURT_WALK_74_00_2
	map_actor_end
SeniorCourtActorsA_12:
	; $53b7, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, $2d00, $1900, FACE_DOWN, OBJ_EMILY, $01, $00, SENIOR_COURT_A_EMILY
	map_actor $0000, ActorScript_12_51, $2900, $1b00, FACE_LEFT, OBJ_FAY, $01, $07, SENIOR_COURT_A_FAY
	map_actor $0000, ActorScript_12_57, $3900, $1d00, FACE_LEFT, OBJ_ALLIE, $01, $05, SENIOR_COURT_A_ALLIE
	map_actor $0000, ActorScript_12_51, $2d00, $1300, FACE_RIGHT, OBJ_JOY, $01, $04, SENIOR_COURT_A_JOY
	map_actor $0000, ActorScript_12_51, $2b00, $1100, FACE_LEFT, OBJ_BRIAN, $01, $06, SENIOR_COURT_A_BRIAN
	map_actor $0000, ActorScript_12_43, $0a00, $1500, FACE_UP, OBJ_BETH, $01, $05, SENIOR_COURT_A_BETH
	map_actor $0000, ActorScript_12_51, $0300, $1700, FACE_RIGHT, OBJ_CURT, $01, $03, SENIOR_COURT_A_CURT
	map_actor $0000, ActorScript_12_57, $1200, $0d00, FACE_RIGHT, OBJ_BOB, $01, $06, SENIOR_COURT_A_BOB
	map_actor $0000, ActorScript_12_44, $1500, $0d00, FACE_DOWN, OBJ_PAM, $06, $03, SENIOR_COURT_A_PAM
	map_actor $05e0, ActorScript_12_52, $0300, $0b00, FACE_DOWN, OBJ_KATE, $01, $00, SENIOR_COURT_A_KATE
	map_actor $0000, ActorScript_12_53, $2200, $1100, FACE_DOWN, OBJ_WALK_74_00, $01, $05, SENIOR_COURT_A_WALK_74_00_1
	map_actor $0000, ActorScript_12_54, $2600, $1d00, FACE_UP, OBJ_WALK_74_00, $01, $00, SENIOR_COURT_A_WALK_74_00_2
	map_actor $0000, ActorScript_12_55, $3200, $1100, FACE_DOWN, OBJ_WALK_74_00, $01, $00, SENIOR_COURT_A_WALK_74_00_3
	map_actor $0000, ActorScript_12_56, $3600, $1d00, FACE_UP, OBJ_WALK_74_00, $01, $06, SENIOR_COURT_A_WALK_74_00_4
	map_actor $0000, ActorScript_12_51, $4000, $4000, FACE_UP, OBJ_WALK_73_19, $01, $00, SENIOR_COURT_A_WALK_73_19
	map_actor_end
SeniorCourtActorsB_12:
	; $5493, 220 bytes (map_actors)
	map_actor $0000, ActorScript_12_51, $2d00, $1900, FACE_DOWN, OBJ_EMILY, $01, $00, SENIOR_COURT_B_EMILY
	map_actor $0000, ActorScript_12_43, $2d00, $1100, FACE_UP, OBJ_FAY, $06, $07, SENIOR_COURT_B_FAY
	map_actor $0000, ActorScript_12_57, $2d00, $0f00, FACE_DOWN, OBJ_ALLIE, $01, $05, SENIOR_COURT_B_ALLIE
	map_actor $0000, ActorScript_12_51, $3900, $1d00, FACE_LEFT, OBJ_JOY, $01, $04, SENIOR_COURT_B_JOY
	map_actor $0000, ActorScript_12_51, $3900, $1b00, FACE_LEFT, OBJ_BRIAN, $01, $06, SENIOR_COURT_B_BRIAN
	map_actor $0000, ActorScript_12_43, $2300, $1e00, FACE_UP, OBJ_BETH, $01, $05, SENIOR_COURT_B_BETH
	map_actor $0000, ActorScript_12_51, $2300, $1c00, FACE_DOWN, OBJ_CURT, $01, $03, SENIOR_COURT_B_CURT
	map_actor $0000, ActorScript_12_51, $0900, $0700, FACE_RIGHT, OBJ_BOB, $01, $06, SENIOR_COURT_B_BOB
	map_actor $0000, ActorScript_12_51, $0b00, $0700, FACE_LEFT, OBJ_PAM, $01, $03, SENIOR_COURT_B_PAM
	map_actor $05e0, ActorScript_12_52, $0300, $0b00, FACE_DOWN, OBJ_KATE, $01, $00, SENIOR_COURT_B_KATE
	map_actor $0000, ActorScript_12_53, $1200, $0b00, FACE_DOWN, OBJ_WALK_74_00, $01, $05, SENIOR_COURT_B_WALK_74_00_1
	map_actor $0000, ActorScript_12_54, $1600, $1600, FACE_UP, OBJ_WALK_74_00, $01, $00, SENIOR_COURT_B_WALK_74_00_2
	map_actor $0000, ActorScript_12_55, $3200, $1100, FACE_DOWN, OBJ_WALK_74_00, $01, $00, SENIOR_COURT_B_WALK_74_00_3
	map_actor $0000, ActorScript_12_56, $3600, $1d00, FACE_UP, OBJ_WALK_74_00, $01, $06, SENIOR_COURT_B_WALK_74_00_4
	map_actor $0000, ActorScript_12_51, $4000, $4000, FACE_UP, OBJ_WALK_73_19, $01, $00, SENIOR_COURT_B_WALK_73_19
	map_actor_end
SeniorCourtEntryPoints_12:
	; $556f, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $2300, $0000
	map_entry $09, FACE_UP, $0b00, $1900, $0000
	db $ff
SeniorCourtExitTriggers_12:
	; $5580, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, SeniorCourtExit01_12, STORYLOC_RESTAURANT_PLAZA, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_12, STORYLOC_SENIOR_CLASS_COURT, $0f
	db $ff
SeniorCourtExit01_12:
	clear_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5591
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $5594
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $559e
	ld c, $10 ; $55a8
	call BeginFadeOut ; $55aa
	script_wait_frames $1e ; $55ad
	ret ; $55b4
.loop:
	ld a, [wMapSceneStage2] ; $55b5
	sub SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $55b8
	add a ; $55ba
	ld_hl_indexed SeniorCourtExit01TextIds ; $55bb
	ld a, [hl+] ; $55c2
	ld h, [hl] ; $55c3
	ld l, a ; $55c4
	farcall InitDialogueTextCursor ; $55c5
	ld a, [wStoryModeGenderOfMainCharacter] ; $55c8
	ld hl, $001d ; $55cb
	add l ; $55ce
	ld l, a ; $55cf
	jr nc, .pushTextArgFetchedString ; $55d0
	inc h ; $55d2
.pushTextArgFetchedString:
	call PushTextArgFetchedString ; $55d3
	script_speak ACTOR_SENIOR_COURT_EMILY ; $55d6
	ret ; $55db
SeniorCourtExit01TextIds:
	; $55dc, 12 bytes (text_ids)
	dw Text_34_141 ; record 0
	dw Text_34_151 ; record 1
	dw Text_34_158 ; record 2
	dw Text_34_168 ; record 3
	dw Text_34_176 ; record 4
	dw Text_34_186 ; record 5
SeniorCourtNpc03_12:
	ld a, [wMapSceneStage2] ; $55e8
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55eb
	jr c, SeniorCourtNpc03FaceUpFlag0000_12.checkDoubles ; $55ed
	cp $09 ; $55ef
	jr nc, SeniorCourtExit01_12.loop ; $55f1
	call SeniorRankOfferScenePrep ; $55f3
	ret ; $55f6
SeniorCourtNpc03FaceUpFlag0000_12:
	ld a, [wMapSceneStage2] ; $55f7
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $55fa
	jr c, .checkDoubles ; $55fc
	cp $09 ; $55fe
	jr nc, SeniorCourtExit01_12.loop ; $5600
	call SeniorRankOfferScenePrepFacingUp ; $5602
	ret ; $5605
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5606
	jp nz, SeniorCourtNpc03FaceUpFlag0840_12.checkFlag ; $5609
	script_set_text Text_34_4 ; $560c
	ld a, $03 ; $5612
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5614
	farcall RunDialogueYesNoPrompt ; $5617
	farcall ScriptCloseDialogueWindow ; $561a
	script_wait_frames $05 ; $561d
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
	script_set_speed ACTOR_PLAYER, $0010 ; $563b
	script_set_speed ACTOR_PARTNER, $0010 ; $5643
	script_null_script ACTOR_PARTNER ; $564b
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $5650
	script_move_target ACTOR_PARTNER, $2700, $1d00 ; $565b
	script_wait_move ACTOR_PARTNER ; $5666
	script_move_target ACTOR_PARTNER, $2b00, $1d00 ; $566b
	script_wait_move ACTOR_PARTNER ; $5676
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $567b
	script_wait_move ACTOR_PARTNER ; $5686
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $568b
	script_wait_move ACTOR_PLAYER ; $5693
	jp SeniorCourtNpc03FaceUpFlag0840_12.face ; $5698
SeniorCourtNpc03FaceUpFlag0840_12:
	test_flag FLAG_DOUBLES ; $569b
	jp z, SeniorCourtNpc03FaceUpFlag0000_12 ; $569e
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $56a1
	jp nz, .setText ; $56a4
	script_set_speed ACTOR_PARTNER, $0010 ; $56a7
	script_set_speed ACTOR_PLAYER, $0008 ; $56af
	script_face ACTOR_PLAYER, FACE_UP ; $56b7
	script_facing_lock ACTOR_PLAYER, $01 ; $56be
	script_null_script ACTOR_PARTNER ; $56c5
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $56ca
	script_move_target ACTOR_PARTNER, $2b00, $1b00 ; $56d5
	script_wait_move ACTOR_PARTNER ; $56e0
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $56e5
	script_wait_move ACTOR_PARTNER ; $56f0
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $56f5
	script_wait_move ACTOR_PLAYER ; $56fd
	jr .face ; $5702
.checkFlag:
	test_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5704
	jp nz, .setText ; $5707
	script_set_speed ACTOR_PLAYER, $0010 ; $570a
	script_set_speed ACTOR_PARTNER, $0010 ; $5712
	script_null_script ACTOR_PARTNER ; $571a
	script_move_target ACTOR_PLAYER, $2900, $1b00 ; $571f
	script_move_target ACTOR_PARTNER, $2b00, $1900 ; $572a
	script_wait_move ACTOR_PARTNER ; $5735
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $573a
	script_wait_move ACTOR_PLAYER ; $5742
.face:
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PLAYER ; $5747
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $574f
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $5757
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $575e
	script_wait_frames $1e ; $5763
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_EMILY ; $576a
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $5772
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $5779
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $577e
	script_face ACTOR_PLAYER, FACE_UP ; $5785
	script_set_text Text_34_7 ; $578c
	set_flag FLAG_SENIOR_COURT_NPC03_TURNED ; $5792
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5795
	or a ; $5798
	jr nz, .speak ; $5799
	script_set_text Text_34_11 ; $579b
.speak:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57a1
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $57a6
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57ae
	script_set_anim ACTOR_PARTNER, $03 ; $57b3
	script_wait_idle ACTOR_PARTNER ; $57ba
	script_speak ACTOR_PARTNER ; $57bf
	script_set_speed ACTOR_PLAYER, $0018 ; $57c4
	script_set_speed ACTOR_PARTNER, $0018 ; $57cc
	script_move_target ACTOR_PARTNER, $2b00, $1b00 ; $57d4
	script_wait_move ACTOR_PARTNER ; $57df
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $57e4
	script_face_toward ACTOR_PARTNER, ACTOR_SENIOR_COURT_EMILY ; $57ec
.setText:
	script_set_text Text_34_10 ; $57f4
	script_speak ACTOR_SENIOR_COURT_EMILY ; $57fa
	script_set_anim ACTOR_PLAYER, $03 ; $57ff
	script_set_anim ACTOR_PARTNER, $03 ; $5806
	script_wait_idle ACTOR_PARTNER ; $580d
	script_get_actor_state ACTOR_PARTNER ; $5812
	ld c, l ; $5817
	ld b, h ; $5818
	ld de, wActors ; $5819
	farcall AttachActorStepMover ; $581c
	ret ; $581f
SeniorCourtNpc04_12:
	ld a, [wMapSceneStage2] ; $5820
	add a ; $5823
	ld_hl_indexed SeniorCourtNpc04TextIds ; $5824
	ld a, [hl+] ; $582b
	ld h, [hl] ; $582c
	ld l, a ; $582d
	farcall InitDialogueTextCursor ; $582e
	script_speak ACTOR_SENIOR_COURT_FAY ; $5831
	ld a, [wMapSceneStage2] ; $5836
	cp SENIORCOURTSTAGE_SINGLES_RANK4 ; $5839
	jr nc, .ge02 ; $583b
	jr .done ; $583d
.ge02:
	ld a, [wMapSceneStage2] ; $583f
	cp SENIORCOURTSTAGE_DOUBLES_RANK3 ; $5842
	jr c, .done ; $5844
.done:
	ret ; $5846
SeniorCourtNpc04TextIds:
	; $5847, 18 bytes (text_ids)
	dw Text_34_14 ; record 0
	dw Text_34_14 ; record 1
	dw Text_34_26 ; record 2
	dw Text_34_26 ; record 3
	dw Text_34_26 ; record 4
	dw Text_34_27 ; record 5
	dw Text_34_85 ; record 6
	dw Text_34_85 ; record 7
	dw Text_34_86 ; record 8
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
	jr z, .eq04 ; $586f
	script_speak ACTOR_SENIOR_COURT_ALLIE ; $5871
	ret ; $5876
.eq04:
	ld a, $05 ; $5877
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5879
	farcall RunDialogueYesNoPrompt ; $587c
	farcall ScriptCloseDialogueWindow ; $587f
	script_wait_frames $05 ; $5882
	and a ; $5889
	jr z, .speak ; $588a
	farcall AdvanceDialogueTextCursor ; $588c
.speak:
	script_speak ACTOR_SENIOR_COURT_ALLIE ; $588f
	ret ; $5894
SeniorCourtNpc05TextIds_12:
	; $5895, 30 bytes (text_ids)
	dw Text_34_15 ; record 0
	dw Text_34_24 ; record 1
	dw Text_34_28 ; record 2
	dw Text_34_28 ; record 3
	dw Text_34_29 ; record 4
	dw Text_34_32 ; record 5
	dw Text_34_87 ; record 6
	dw Text_34_87 ; record 7
	dw Text_34_88 ; record 8
	dw Text_34_142 ; record 9
	dw Text_34_151 ; record 10
	dw Text_34_159 ; record 11
	dw Text_34_168 ; record 12
	dw Text_34_177 ; record 13
	dw Text_34_186 ; record 14
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
	jr z, .eq06 ; $58c9
	script_speak ACTOR_SENIOR_COURT_JOY ; $58cb
	ret ; $58d0
.eq06:
	ld a, $06 ; $58d1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58d3
	farcall RunDialogueYesNoPrompt ; $58d6
	farcall ScriptCloseDialogueWindow ; $58d9
	script_wait_frames $05 ; $58dc
	and a ; $58e3
	jr z, .speak ; $58e4
	farcall AdvanceDialogueTextCursor ; $58e6
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $58e9
	or a ; $58ec
	jr nz, .speak ; $58ed
	farcall AdvanceDialogueTextCursor ; $58ef
.speak:
	script_speak ACTOR_SENIOR_COURT_JOY ; $58f2
	ret ; $58f7
SeniorCourtNpc06TextIds_12:
	; $58f8, 30 bytes (text_ids)
	dw Text_34_16 ; record 0
	dw Text_34_16 ; record 1
	dw Text_34_33 ; record 2
	dw Text_34_34 ; record 3
	dw Text_34_35 ; record 4
	dw Text_34_36 ; record 5
	dw Text_34_89 ; record 6
	dw Text_34_94 ; record 7
	dw Text_34_96 ; record 8
	dw Text_34_143 ; record 9
	dw Text_34_152 ; record 10
	dw Text_34_160 ; record 11
	dw Text_34_169 ; record 12
	dw Text_34_178 ; record 13
	dw Text_34_187 ; record 14
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
	dw Text_34_17 ; record 0
	dw Text_34_25 ; record 1
	dw Text_34_37 ; record 2
	dw Text_34_38 ; record 3
	dw Text_34_38 ; record 4
	dw Text_34_38 ; record 5
	dw Text_34_93 ; record 6
	dw Text_34_95 ; record 7
	dw Text_34_97 ; record 8
	dw Text_34_144 ; record 9
	dw Text_34_153 ; record 10
	dw Text_34_161 ; record 11
	dw Text_34_170 ; record 12
	dw Text_34_179 ; record 13
	dw Text_34_188 ; record 14
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
	script_set_anim ACTOR_SENIOR_COURT_BETH, $06 ; $596c
.altText:
	script_speak ACTOR_SENIOR_COURT_BETH ; $5973
	ret ; $5978
.speak:
	ld a, $08 ; $5979
	farcall ScriptShowSpeakerDialogueRestoreBG ; $597b
	farcall RunDialogueYesNoPrompt ; $597e
	farcall ScriptCloseDialogueWindow ; $5981
	script_wait_frames $05 ; $5984
	and a ; $598b
	jr z, .doublesLine ; $598c
	script_speak ACTOR_SENIOR_COURT_BETH ; $598e
	ret ; $5993
.doublesLine:
	farcall AdvanceDialogueTextCursor ; $5994
	script_set_anim ACTOR_SENIOR_COURT_BETH, $02 ; $5997
	script_wait_idle ACTOR_SENIOR_COURT_BETH ; $599e
	ld a, $08 ; $59a3
	farcall ScriptShowSpeakerDialogueRestoreBG ; $59a5
	farcall RunDialogueYesNoPrompt ; $59a8
	farcall ScriptCloseDialogueWindow ; $59ab
	script_wait_frames $05 ; $59ae
	and a ; $59b5
	jr z, .done ; $59b6
	script_speak ACTOR_SENIOR_COURT_BETH ; $59b8
	ret ; $59bd
.done:
	script_wait_frames $0a ; $59be
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_50 ; $59c5
	script_move_target ACTOR_SENIOR_COURT_BETH, $0c00, $1500 ; $59d0
	script_wait_move ACTOR_SENIOR_COURT_BETH ; $59db
	script_set_actor_script ACTOR_SENIOR_COURT_BETH, ActorScript_12_49 ; $59e0
	script_move_player $0a00, $1100 ; $59eb
	farcall WaitPlayerMoveDone ; $59f5
	script_wait_actor_script ACTOR_SENIOR_COURT_BETH ; $59f8
	ld hl, wStoryModePlayersXPosition ; $59fd
	ld de, wStoryModeSpawnPosition ; $5a00
	ld bc, $0005 ; $5a03
	call CopyMemoryBC ; $5a06
	ld a, STORYENTRY_NONE ; $5a09
	ld [wStoryModeEntryPoint], a ; $5a0b
	ld [wUnusedExitTriggerIdMirror], a ; $5a0e
	ld [wStoryModeExitTriggerRequest], a ; $5a11
	farcall InitStoryMatchSettings ; $5a14
	load_match_settings $0005 ; $5a17
	farcall RunStoryMatch ; $5a24
	farcall RestoreOverworldAfterMatch ; $5a27
	ret ; $5a2a
SeniorCourtNpc08TextIds:
	; $5a2b, 30 bytes (text_ids)
	dw Text_34_18 ; record 0
	dw Text_34_18 ; record 1
	dw Text_34_39 ; record 2
	dw Text_34_48 ; record 3
	dw Text_34_48 ; record 4
	dw Text_34_48 ; record 5
	dw Text_34_98 ; record 6
	dw Text_34_99 ; record 7
	dw Text_34_99 ; record 8
	dw Text_34_145 ; record 9
	dw Text_34_154 ; record 10
	dw Text_34_162 ; record 11
	dw Text_34_171 ; record 12
	dw Text_34_180 ; record 13
	dw Text_34_189 ; record 14
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
	script_speak ACTOR_SENIOR_COURT_CURT ; $5a68
	ret ; $5a6d
SeniorCourtNpc09TextIds:
	; $5a6e, 30 bytes (text_ids)
	dw Text_34_19 ; record 0
	dw Text_34_19 ; record 1
	dw Text_34_43 ; record 2
	dw Text_34_49 ; record 3
	dw Text_34_49 ; record 4
	dw Text_34_49 ; record 5
	dw Text_34_100 ; record 6
	dw Text_34_101 ; record 7
	dw Text_34_101 ; record 8
	dw Text_34_146 ; record 9
	dw Text_34_155 ; record 10
	dw Text_34_163 ; record 11
	dw Text_34_172 ; record 12
	dw Text_34_181 ; record 13
	dw Text_34_190 ; record 14
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
	script_speak ACTOR_SENIOR_COURT_BOB ; $5aa4
	ret ; $5aa9
.altText:
	ld a, $0a ; $5aaa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5aac
	farcall RunDialogueYesNoPrompt ; $5aaf
	farcall ScriptCloseDialogueWindow ; $5ab2
	script_wait_frames $05 ; $5ab5
	and a ; $5abc
	jr z, .speak ; $5abd
	script_speak ACTOR_SENIOR_COURT_BOB ; $5abf
	ret ; $5ac4
.speak:
	farcall AdvanceDialogueTextCursor ; $5ac5
	ld a, $0a ; $5ac8
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5aca
	farcall RunDialogueYesNoPrompt ; $5acd
	farcall ScriptCloseDialogueWindow ; $5ad0
	script_wait_frames $05 ; $5ad3
	and a ; $5ada
	jr z, .done ; $5adb
	script_speak ACTOR_SENIOR_COURT_BOB ; $5add
	ret ; $5ae2
.done:
	script_get_actor_state ACTOR_SENIOR_COURT_BOB ; $5ae3
	ld e, l ; $5ae8
	ld d, h ; $5ae9
	ld hl, $0005 ; $5aea
	add hl, de ; $5aed
	res 0, [hl] ; $5aee
	res 1, [hl] ; $5af0
	script_set_speed ACTOR_PLAYER, $0020 ; $5af2
	script_set_speed ACTOR_PARTNER, $0020 ; $5afa
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_47 ; $5b02
	script_wait_frames $20 ; $5b0d
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_48 ; $5b14
	script_set_actor_script ACTOR_SENIOR_COURT_BOB, ActorScript_12_45 ; $5b1f
	script_set_actor_script ACTOR_SENIOR_COURT_PAM, ActorScript_12_46 ; $5b2a
	script_move_player $0a00, $1100 ; $5b35
	farcall WaitPlayerMoveDone ; $5b3f
	script_wait_actor_script ACTOR_PLAYER ; $5b42
	ld hl, wStoryModePlayersXPosition ; $5b47
	ld de, wStoryModeSpawnPosition ; $5b4a
	ld bc, $0005 ; $5b4d
	call CopyMemoryBC ; $5b50
	ld a, STORYENTRY_NONE ; $5b53
	ld [wStoryModeEntryPoint], a ; $5b55
	ld [wUnusedExitTriggerIdMirror], a ; $5b58
	ld [wStoryModeExitTriggerRequest], a ; $5b5b
	farcall InitStoryMatchSettings ; $5b5e
	load_match_settings $0105 ; $5b61
	farcall RunStoryMatch ; $5b6e
	farcall RestoreOverworldAfterMatch ; $5b71
	ret ; $5b74
SeniorCourtNpc0ATextIds:
	; $5b75, 30 bytes (text_ids)
	dw Text_34_20 ; record 0
	dw Text_34_20 ; record 1
	dw Text_34_44 ; record 2
	dw Text_34_50 ; record 3
	dw Text_34_50 ; record 4
	dw Text_34_50 ; record 5
	dw Text_34_102 ; record 6
	dw Text_34_108 ; record 7
	dw Text_34_108 ; record 8
	dw Text_34_147 ; record 9
	dw Text_34_156 ; record 10
	dw Text_34_164 ; record 11
	dw Text_34_173 ; record 12
	dw Text_34_182 ; record 13
	dw Text_34_191 ; record 14
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
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5bb0
	and a ; $5bb3
	jr nz, .speak ; $5bb4
	farcall AdvanceDialogueTextCursor ; $5bb6
.speak:
	script_speak ACTOR_SENIOR_COURT_PAM ; $5bb9
	ret ; $5bbe
SeniorCourtNpc0BTextIds:
	; $5bbf, 30 bytes (text_ids)
	dw Text_34_21 ; record 0
	dw Text_34_21 ; record 1
	dw Text_34_45 ; record 2
	dw Text_34_51 ; record 3
	dw Text_34_51 ; record 4
	dw Text_34_51 ; record 5
	dw Text_34_107 ; record 6
	dw Text_34_109 ; record 7
	dw Text_34_109 ; record 8
	dw Text_34_148 ; record 9
	dw Text_34_157 ; record 10
	dw Text_34_165 ; record 11
	dw Text_34_174 ; record 12
	dw Text_34_183 ; record 13
	dw Text_34_174 ; record 14
SeniorCourtNpc0C_12:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5bdd
	or a ; $5be0
	jr nz, .nonZero ; $5be1
	ld a, [wMapSceneStage2] ; $5be3
	add a ; $5be6
	ld_hl_indexed SeniorCourtNpc0C_12Table ; $5be7
	ld a, [hl+] ; $5bee
	ld h, [hl] ; $5bef
	ld l, a ; $5bf0
	farcall InitDialogueTextCursor ; $5bf1
	script_speak ACTOR_SENIOR_COURT_KATE ; $5bf4
	ret ; $5bf9
.nonZero:
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
	dw Text_34_22 ; record 0
	dw Text_34_22 ; record 1
	dw Text_34_46 ; record 2
	dw Text_34_52 ; record 3
	dw Text_34_52 ; record 4
	dw Text_34_52 ; record 5
	dw Text_34_108 ; record 6
	dw Text_34_110 ; record 7
	dw Text_34_110 ; record 8
	dw Text_34_149 ; record 9
	dw Text_34_158 ; record 10
	dw Text_34_166 ; record 11
	dw Text_34_175 ; record 12
	dw Text_34_184 ; record 13
	dw Text_34_186 ; record 14
SeniorCourtNpc0C_12Table:
	INCBIN "data/bank_012/SeniorCourtNpc0C_12Table.bin" ; $5c2f, 30 bytes
SeniorCourtNpcScripts_12:
	; $5c4d, 121 bytes (map_scripts)
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_RIGHT, $0840, SeniorCourtNpc03FaceRight_12, $01, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_UP, $0840, SeniorCourtNpc03FaceUpFlag0840_12, $01, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_UP, $0000, SeniorCourtNpc03FaceUpFlag0000_12, $01, $00
	map_script ACTOR_SENIOR_COURT_EMILY, FACEMASK_ANY, $0000, SeniorCourtNpc03_12, $01, $00
	map_script ACTOR_SENIOR_COURT_FAY, FACEMASK_ANY, $0000, SeniorCourtNpc04_12, $1b, $00
	map_script ACTOR_SENIOR_COURT_ALLIE, FACEMASK_ANY, $0000, SeniorCourtNpc05_12, $13, $00
	map_script ACTOR_SENIOR_COURT_JOY, FACEMASK_ANY, $08a0, SeniorCourtNpc06_12, $13, $00
	map_script ACTOR_SENIOR_COURT_JOY, FACEMASK_ANY, $0000, SeniorCourtNpc06_12, $11, $00
	map_script ACTOR_SENIOR_COURT_BRIAN, FACEMASK_ANY, $08a0, SeniorCourtNpc07_12, $03, $00
	map_script ACTOR_SENIOR_COURT_BRIAN, FACEMASK_ANY, $0000, SeniorCourtNpc07_12, $01, $00
	map_script ACTOR_SENIOR_COURT_BETH, FACEMASK_ANY, $0000, SeniorCourtNpc08_12, $0b, $00
	map_script ACTOR_SENIOR_COURT_CURT, FACEMASK_ANY, $0000, SeniorCourtNpc09_12, $13, $00
	map_script ACTOR_SENIOR_COURT_BOB, FACEMASK_ANY, $0000, SeniorCourtNpc0A_12, $13, $00
	map_script ACTOR_SENIOR_COURT_PAM, FACEMASK_ANY, $0000, SeniorCourtNpc0B_12, $1b, $00
	map_script ACTOR_SENIOR_COURT_KATE, FACEMASK_ANY, $0000, SeniorCourtNpc0C_12, $13, $00
	db $ff
SeniorCourtFacingScripts_12:
	ds 1, $ff ; $5cc6, fill
SeniorCourtTileTriggers_12:
	; $5cc7, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0f80, SeniorCourtTile01_12, $00, $00
	db $ff
SeniorCourtTile01_12:
	set_flag FLAG_SENIOR_COURT_TILE01_TRIGGERED ; $5cd0
	script_null_script ACTOR_SENIOR_COURT_BOB ; $5cd3
	script_null_script ACTOR_SENIOR_COURT_PAM ; $5cd8
	script_set_anim ACTOR_SENIOR_COURT_BOB, $01 ; $5cdd
	script_set_anim ACTOR_SENIOR_COURT_PAM, $01 ; $5ce4
	script_move_target ACTOR_SENIOR_COURT_BOB, $1400, $1300 ; $5ceb
	script_move_target ACTOR_SENIOR_COURT_PAM, $1400, $0f00 ; $5cf6
	script_wait_move ACTOR_SENIOR_COURT_BOB ; $5d01
	script_wait_move ACTOR_SENIOR_COURT_PAM ; $5d06
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_BOB ; $5d0b
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_PAM ; $5d13
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
	script_null_script $0a ; $5d3d
	script_null_script $0b ; $5d42
	script_set_anim $0a, $01 ; $5d47
	script_set_anim $0b, $01 ; $5d4e
	script_set_position $0a, $1400, $1300 ; $5d55
	script_set_position $0b, $1400, $0f00 ; $5d60
	script_face_toward ACTOR_PLAYER, $0a ; $5d6b
	script_face_toward ACTOR_PLAYER, $0b ; $5d73
.fromMatch:
	test_flag FLAG_DOUBLES ; $5d7b
	jr nz, .done ; $5d7e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5d80
	jr z, .placeActors ; $5d83
	ldh a, [hRomBank] ; $5d85
	ld hl, SeniorCourtActorsA_12 ; $5d87
	farcall ScriptRespawnLocationActors ; $5d8a
.placeActors:
	call SeniorCourtPositionActorsByProgressA ; $5d8d
	call SetPartnerObjDefByGender_12 ; $5d90
	ld a, [wStoryModeEntryPoint] ; $5d93
	cp $0f ; $5d96
	jp z, SeniorCourtPostMatchReturn ; $5d98
	cp $0e ; $5d9b
	jp z, SeniorCourtReloadIntoVictoryScene ; $5d9d
	cp $0d ; $5da0
	jp z, SeniorMatchVictorySceneDispatch ; $5da2
	call SeniorCourtPositionActorsByProgressB ; $5da5
	farcall EndCutsceneScriptMode ; $5da8
	call SeniorCourtWalkPlayersOntoCourt ; $5dab
	ret ; $5dae
.done:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5daf
	jr z, .placeActors ; $5db2
	ldh a, [hRomBank] ; $5db4
	ld hl, SeniorCourtActorsB_12 ; $5db6
	farcall ScriptRespawnLocationActors ; $5db9
	jr .placeActors ; $5dbc
SeniorCourtPositionActorsByProgressB:
	ld a, [wMapSceneStage2] ; $5dbe
	cp SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN ; $5dc1
	jr c, .checkDoubles ; $5dc3
	cp $0d ; $5dc5
	jr nc, .checkDoubles ; $5dc7
	script_get_actor_state ACTOR_SENIOR_COURT_A_EMILY ; $5dc9
	ld c, l ; $5dce
	ld b, h ; $5dcf
	ld d, OBJ_WALK_72_04 ; $5dd0
	farcall LoadActorObjectDefIfValid ; $5dd2
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, $01 ; $5dd5
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5ddc
	jr nz, .doubles ; $5ddf
	ld a, [wMapSceneStage2] ; $5de1
	cp SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $5de4
	jr c, .done ; $5de6
	script_set_position $04, $3f00, $3f00 ; $5de8
.done:
	ret ; $5df3
.doubles:
	ld a, [wMapSceneStage2] ; $5df4
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5df7
	jr c, .done ; $5df9
	script_set_position $04, $3f00, $3f00 ; $5dfb
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, $3f00, $3f00 ; $5e06
	ret ; $5e11
SeniorCourtPositionActorsByProgressA:
	test_flag FLAG_DOUBLES ; $5e12
	jr nz, .isDoubles ; $5e15
	ld a, [wMapSceneStage2] ; $5e17
	cp SENIORCOURTSTAGE_SINGLES_RANK3 ; $5e1a
	jr c, .checkStage9 ; $5e1c
	script_set_position ACTOR_SENIOR_COURT_A_BRIAN, $1b00, $0d00 ; $5e1e
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
	cp $09 ; $5e3f
	jr nc, .checkStage10 ; $5e41
	script_set_position $09, $1b00, $0b00 ; $5e43
	script_set_position ACTOR_SENIOR_COURT_A_BETH, $1b00, $0d00 ; $5e4e
	script_face $09, FACE_LEFT ; $5e59
	script_face ACTOR_SENIOR_COURT_A_BETH, FACE_LEFT ; $5e60
	script_null_script ACTOR_SENIOR_COURT_A_BETH ; $5e67
	script_set_anim ACTOR_SENIOR_COURT_A_BETH, $01 ; $5e6c
.checkStage10:
	ld a, [wMapSceneStage2] ; $5e73
	cp SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $5e76
	jr c, .checkStage9 ; $5e78
	script_set_position $04, $3f00, $3f00 ; $5e7a
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, $3f00, $3f00 ; $5e85
	ret ; $5e90
