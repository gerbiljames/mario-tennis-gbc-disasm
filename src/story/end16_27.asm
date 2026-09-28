End17AwardCeremonyMapScripts_27:
	; $4018, 14 bytes (map_tree)
	dw End17AwardCeremonyEntryPoints_27 ; slot 0 EntryPoints
	dw End17AwardCeremonyExitTriggers_27 ; slot 1 ExitTriggers
	dw End17AwardCeremonyActors_27 ; slot 2 Actors
	dw End17AwardCeremonyNpcScripts_27 ; slot 3 NpcScripts
	dw End17AwardCeremonyFacingScripts_27 ; slot 4 FacingScripts
	dw End17AwardCeremonyTileTriggers_27 ; slot 5 TileTriggers
	dw End17AwardCeremonyInitScript_27 ; slot 6 InitScript
End17AwardCeremonyActors_27:
	; $4026, 178 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $0f00, $1600, FACE_UP, OBJ_WALK_6F_07, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_6F_07_1
	map_actor $0000, ActorScript_27_27, $0c00, $1300, FACE_UP, OBJ_WALK_75_06, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_75_06
	map_actor $0000, ActorScript_27_27, $0e80, $17c0, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END17_AWARD_CEREMONY_TROPHY
	map_actor $0000, ActorScript_27_27, $0f00, $1600, FACE_UP, OBJ_WALK_6F_07, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_6F_07_2
	map_actor $0000, ActorScript_27_27, $0e00, $0e40, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_74_08
	map_actor $0000, ActorScript_27_27, $0a00, $0dc0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, END17_AWARD_CEREMONY_A_COZ
	map_actor $0000, ActorScript_27_27, $0c00, $0d40, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALEX
	map_actor $0000, ActorScript_27_27, $0700, $0500, FACE_DOWN, OBJ_WALK_71_03, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_71_03
	map_actor $0000, ActorScript_27_27, $0f00, $0700, FACE_DOWN, OBJ_WALK_72_03, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_72_03
	map_actor $0000, ActorScript_27_27, $0e80, $1b00, FACE_UP, OBJ_B_COZ, ANIM_WALK, $00, END17_AWARD_CEREMONY_B_COZ
	map_actor $0000, ActorScript_27_27, $0980, $1b00, FACE_UP, OBJ_WALK_6F_05, ANIM_WALK, $00, END17_AWARD_CEREMONY_WALK_6F_05
	map_actor $0000, ActorScript_27_27, $0800, $1940, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $05, END17_AWARD_CEREMONY_WALK_6F_07_3
	map_actor_end
End17AwardCeremonyActorsAlt_27:
	; $40d8, 178 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $0f00, $1600, FACE_UP, OBJ_WALK_6F_07, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_6F_07_1
	map_actor $0000, ActorScript_27_27, $0e00, $1300, FACE_UP, OBJ_WALK_75_06, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_75_06
	map_actor $0000, ActorScript_27_27, $0e80, $17c0, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_TROPHY
	map_actor $0000, ActorScript_27_27, $0f00, $1600, FACE_UP, OBJ_WALK_6F_07, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_6F_07_2
	map_actor $0000, ActorScript_27_27, $0900, $0e00, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_B_COZ
	map_actor $0000, ActorScript_27_27, $0b00, $0e00, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_A_COZ
	map_actor $0000, ActorScript_27_27, $0d00, $0d60, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_ALEX
	map_actor $0000, ActorScript_27_27, $0700, $0500, FACE_DOWN, OBJ_WALK_71_03, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_71_03
	map_actor $0000, ActorScript_27_27, $0f00, $0700, FACE_DOWN, OBJ_WALK_72_03, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_72_03
	map_actor $0000, ActorScript_27_27, $0f00, $1b00, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_74_08
	map_actor $0000, ActorScript_27_27, $0900, $1b00, FACE_UP, OBJ_WALK_6F_05, ANIM_WALK, $00, END17_AWARD_CEREMONY_ALT_WALK_6F_05
	map_actor $0000, ActorScript_27_27, $0800, $1940, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $05, END17_AWARD_CEREMONY_ALT_WALK_6F_07_3
	map_actor_end
End17AwardCeremonyEntryPoints_27:
	; $418a, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $1100, $0000
	db $ff
End17AwardCeremonyExitTriggers_27:
	; $4193, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_RESTAURANT_PLAZA, $06
	db $ff
End17AwardCeremonyNpcScripts_27:
	ds 1, $ff ; $419c, fill
End17AwardCeremonyFacingScripts_27:
	ds 1, $ff ; $419d, fill
End17AwardCeremonyTileTriggers_27:
	ds 1, $ff ; $419e, fill
End17AwardCeremonyInitScript_27:
	test_flag FLAG_DOUBLES ; $419f
	jr z, .animate ; $41a2
	ldh a, [hRomBank] ; $41a4
	ld hl, End17AwardCeremonyActorsAlt_27 ; $41a6
	farcall ScriptRespawnLocationActors ; $41a9
	script_copy_scene_rect $1a, $0d, $08, $0d, $08, $03 ; $41ac
	farcall BeginCutsceneScriptMode ; $41bb
	jr .setEnd17CeremonyObjectDefs ; $41be
.animate:
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, ANIM_TROPHY_SINGLES ; $41c0
.setEnd17CeremonyObjectDefs:
	call SetEnd17CeremonyObjectDefs_27 ; $41c7
	jr .placeActors ; $41ca
	ret ; $41cc
.placeActors:
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $3f00, $3f00 ; $41cd
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $41d8
	xor a ; $41e3
	ld [wStoryModeShowLocationName], a ; $41e4
	script_fade_in $04 ; $41e7
	call WaitFadeEnd ; $41ec
	test_flag FLAG_DOUBLES ; $41ef
	jp nz, .isDoubles ; $41f2
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0010 ; $41f5
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0010 ; $41fd
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0010 ; $4205
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0010 ; $420d
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, FACE_DOWN ; $4215
	script_delay $1e ; $421c
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f80, $1600 ; $4221
	script_delay $1e ; $422c
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $3f00, $3f00 ; $4231
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0f00, $1600 ; $423c
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f00, $1500 ; $4247
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, FACE_UP ; $4252
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f00, $1200 ; $4259
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0f00, $1300 ; $4264
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1 ; $426f
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $3f00, $3f00 ; $4274
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0f00, $1300 ; $427f
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0e00, $1300 ; $428a
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, FACE_LEFT ; $4295
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0e00, $1300 ; $429c
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0d00, $1300 ; $42a7
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $42b2
	script_lock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2 ; $42b7
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0f00, $1300 ; $42be
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2 ; $42c9
	script_unlock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2 ; $42ce
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0f00, $1600 ; $42d5
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2 ; $42e0
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, FACE_UP ; $42e5
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0c00, $1100 ; $42ec
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0c00, $1000 ; $42f7
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $4302
	script_delay $50 ; $4307
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0c00, $0f80 ; $430c
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0c00, $0e40 ; $4317
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $4322
	script_lock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $4327
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0c00, $1100 ; $432e
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $4339
	script_unlock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $433e
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, FACE_UP ; $4345
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_3, ANIM_BOUNCE ; $434c
	script_wait_idle ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_3 ; $4353
	script_delay $32 ; $4358
	script_face $07, FACE_LEFT ; $435d
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_A_COZ, FACE_RIGHT ; $4364
	script_delay $3c ; $436b
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0b40, $0c40 ; $4370
.loop:
	ld a, [wStoryModeGenderOfMainCharacter] ; $437b
	ld d, OBJ_ALEX ; $437e
	add d ; $4380
	ld d, a ; $4381
	script_get_actor_state ACTOR_END17_AWARD_CEREMONY_ALT_ALEX ; $4382
	ld c, l ; $4387
	ld b, h ; $4388
	farcall LoadActorObjectDefIfValid ; $4389
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_ALEX, ANIM_WALK ; $438c
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_ALEX, FACE_RIGHT ; $4393
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_ALEX, ANIM_DISTANT ; $439a
	script_player_speed $0006 ; $43a1
	script_move_player $0c00, $0d00 ; $43a7
	farcall WaitPlayerMoveDone ; $43b1
	script_delay $32 ; $43b4
	ld a, $01 ; $43b9
	ld [wUnusedExitTriggerIdMirror], a ; $43bb
	ld [wStoryModeExitTriggerRequest], a ; $43be
	ret ; $43c1
.isDoubles:
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0010 ; $43c2
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0010 ; $43ca
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0010 ; $43d2
	script_set_speed ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0010 ; $43da
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $0f00, $1600 ; $43e2
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2 ; $43ed
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, FACE_DOWN ; $43f2
	script_delay $14 ; $43f9
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f80, $1600 ; $43fe
	script_delay $14 ; $4409
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, $3f00, $3f00 ; $440e
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0f00, $1600 ; $4419
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f00, $1500 ; $4424
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, FACE_UP ; $442f
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0f00, $1300 ; $4436
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0f00, $1400 ; $4441
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1 ; $444c
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_2, FACE_UP ; $4451
	script_lock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1 ; $4458
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, $0f00, $1600 ; $445f
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1 ; $446a
	script_unlock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1 ; $446f
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_1, FACE_UP ; $4476
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0ec0, $1300 ; $447d
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0f00, $1300 ; $4488
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0fc0, $1300 ; $4493
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $449e
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0f00, $1100 ; $44a3
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0fc0, $1100 ; $44ae
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $44b9
	script_delay $3c ; $44be
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $44c3
	script_wait_idle ACTOR_PARTNER ; $44ca
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, ANIM_NOD ; $44cf
	script_wait_idle ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $44d6
	script_delay $3c ; $44db
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0e40, $1100 ; $44e0
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0d00, $1100 ; $44eb
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0c40, $1100 ; $44f6
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $4501
	script_delay $04 ; $4506
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, FACE_UP ; $450b
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0d00, $1000 ; $4512
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $451d
	script_delay $32 ; $4522
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0d00, $1000 ; $4527
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0d00, $0e80 ; $4532
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY ; $453d
	script_delay $05 ; $4542
	script_lock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $4547
	script_move_target ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, $0d00, $1100 ; $454e
	script_wait_move ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $4559
	script_unlock_facing ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06 ; $455e
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_WALK_75_06, FACE_UP ; $4565
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_3, ANIM_BOUNCE ; $456c
	script_wait_idle ACTOR_END17_AWARD_CEREMONY_ALT_WALK_6F_07_3 ; $4573
	script_delay $1e ; $4578
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_ALEX, ANIM_NOD ; $457d
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4584
	script_wait_idle ACTOR_PARTNER ; $458b
	script_delay $1e ; $4590
	script_face ACTOR_PARTNER, FACE_LEFT ; $4595
	script_face $07, FACE_RIGHT ; $459c
	script_face ACTOR_END17_AWARD_CEREMONY_ALT_A_COZ, FACE_RIGHT ; $45a3
	script_delay $3c ; $45aa
	script_set_position ACTOR_END17_AWARD_CEREMONY_ALT_TROPHY, $0c40, $0c60 ; $45af
	jp .loop ; $45ba
	ret ; $45bd
SetEnd17CeremonyObjectDefs_27:
	test_flag FLAG_DOUBLES ; $45be
	jp z, .checkStoryModeGenderOfMainCharacter ; $45c1
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $45c4
	ld d, OBJ_HARRY_B ; $45c7
	add d ; $45c9
	ld d, a ; $45ca
	script_get_actor_state ACTOR_PARTNER ; $45cb
	ld c, l ; $45d0
	ld b, h ; $45d1
	farcall LoadActorObjectDefIfValid ; $45d2
	script_set_anim ACTOR_PARTNER, ANIM_WALK ; $45d5
	script_null_script ACTOR_PARTNER ; $45dc
	script_set_position ACTOR_PARTNER, $0f00, $0d60 ; $45e1
	script_face ACTOR_PARTNER, FACE_DOWN ; $45ec
.checkStoryModeGenderOfMainCharacter:
	ld a, [wStoryModeGenderOfMainCharacter] ; $45f3
	ld d, OBJ_ALEX_B ; $45f6
	add d ; $45f8
	ld d, a ; $45f9
	script_get_actor_state ACTOR_END17_AWARD_CEREMONY_ALT_ALEX ; $45fa
	ld c, l ; $45ff
	ld b, h ; $4600
	farcall LoadActorObjectDefIfValid ; $4601
	script_set_anim ACTOR_END17_AWARD_CEREMONY_ALT_ALEX, ANIM_WALK ; $4604
	ret ; $460b
End16BeforeFinalsMapScripts_27:
	; $460c, 14 bytes (map_tree)
	dw End16BeforeFinalsEntryPoints_27 ; slot 0 EntryPoints
	dw End16BeforeFinalsExitTriggers_27 ; slot 1 ExitTriggers
	dw End16BeforeFinalsActors_27 ; slot 2 Actors
	dw End16BeforeFinalsNpcScripts_27 ; slot 3 NpcScripts
	dw End16BeforeFinalsFacingScripts_27 ; slot 4 FacingScripts
	dw End16BeforeFinalsTileTriggers_27 ; slot 5 TileTriggers
	dw End16BeforeFinalsInitScript_27 ; slot 6 InitScript
End16BeforeFinalsActors_27:
	; $461a, 206 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_6F_07_1
	map_actor $0000, ActorScript_27_27, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_6F_07_2
	map_actor $0000, ActorScript_27_27, $0100, $0c00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_6F_07_3
	map_actor $0000, ActorScript_27_27, $2300, $1100, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_74_08
	map_actor $0000, ActorScript_27_29, $2300, $1700, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_74_07
	map_actor $0000, ActorScript_27_27, $2100, $1100, FACE_RIGHT, OBJ_WALK_74_06, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_74_06
	map_actor $0000, ActorScript_27_27, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, END16_BEFORE_FINALS_SPIKE
	map_actor $0000, ActorScript_27_27, $1100, $1500, FACE_DOWN, OBJ_SAMMI, ANIM_WALK, $00, END16_BEFORE_FINALS_SAMMI
	map_actor $0000, ActorScript_27_27, $1900, $1300, FACE_DOWN, OBJ_ELDEN, ANIM_WALK, $00, END16_BEFORE_FINALS_ELDEN
	map_actor $0000, ActorScript_27_27, $1700, $1300, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_A_COZ
	map_actor $0000, ActorScript_27_27, $0f00, $1300, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_B_COZ
	map_actor $0000, ActorScript_27_27, $1900, $1500, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, END16_BEFORE_FINALS_SEAN
	map_actor $0000, ActorScript_27_27, $1700, $1500, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_6F_00
	map_actor $0000, ActorScript_27_27, $1100, $1300, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, END16_BEFORE_FINALS_WALK_6F_01
	map_actor_end
End16BeforeFinalsEntryPoints_27:
	; $46e8, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $1c00, $2300, $0000
	db $ff
End16BeforeFinalsExitTriggers_27:
	; $46f1, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_CENTER_COURT, $01
	db $ff
End16BeforeFinalsNpcScripts_27:
	ds 1, $ff ; $46fa, fill
End16BeforeFinalsFacingScripts_27:
	ds 1, $ff ; $46fb, fill
End16BeforeFinalsTileTriggers_27:
	ds 1, $ff ; $46fc, fill
End16BeforeFinalsInitScript_27:
	test_flag FLAG_DOUBLES ; $46fd
	jr nz, .isDoubles ; $4700
	ldh a, [hRomBank] ; $4702
	ld hl, End16BeforeFinalsActorsAlt_27 ; $4704
	farcall ScriptRespawnLocationActors ; $4707
	call End16BeforeFinalsCutscene_27 ; $470a
	ret ; $470d
.isDoubles:
	ldh a, [hRomBank] ; $470e
	ld hl, End16BeforeFinalsActorsAltB_27 ; $4710
	farcall ScriptRespawnLocationActors ; $4713
	call End16BeforeFinalsCutscene_27 ; $4716
	ret ; $4719
End16BeforeFinalsActorsAlt_27:
	; $471a, 206 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_6F_07_1
	map_actor $0000, ActorScript_27_27, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_6F_07_2
	map_actor $0000, ActorScript_27_27, $0e00, $0400, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_6F_07_3
	map_actor $0000, ActorScript_27_27, $2300, $1100, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_74_08
	map_actor $0000, ActorScript_27_29, $2300, $1700, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_74_07
	map_actor $0000, ActorScript_27_27, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_SAMMI
	map_actor $0000, ActorScript_27_27, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_SPIKE
	map_actor $0000, ActorScript_27_27, $1100, $1500, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_A_COZ
	map_actor $0000, ActorScript_27_27, $2100, $1100, FACE_RIGHT, OBJ_WALK_74_06, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_74_06
	map_actor $0000, ActorScript_27_27, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_ELDEN
	map_actor $0000, ActorScript_27_28, $0700, $1f00, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_COZ
	map_actor $0000, ActorScript_27_27, $1d00, $1300, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_SEAN
	map_actor $0000, ActorScript_27_27, $0500, $2100, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_6F_00
	map_actor $0000, ActorScript_27_29, $2900, $1500, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_WALK_6F_01
	map_actor_end
End16BeforeFinalsActorsAltB_27:
	; $47e8, 192 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_6F_07_1
	map_actor $0000, ActorScript_27_27, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_6F_07_2
	map_actor $0000, ActorScript_27_27, $0e00, $0400, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_6F_07_3
	map_actor $0000, ActorScript_27_27, $2300, $1100, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_74_08
	map_actor $0000, ActorScript_27_27, $2300, $1300, FACE_UP, OBJ_WALK_74_06, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_74_06
	map_actor $0000, ActorScript_27_27, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_SPIKE
	map_actor $0000, ActorScript_27_27, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_ELDEN
	map_actor $0000, ActorScript_27_27, $0f00, $1300, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_A_COZ
	map_actor $0000, ActorScript_27_27, $1100, $1300, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_B_COZ
	map_actor $0000, ActorScript_27_27, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_SAMMI
	map_actor $0000, ActorScript_27_27, $1d00, $1300, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_SEAN
	map_actor $0000, ActorScript_27_29, $2900, $1500, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, END16_BEFORE_FINALS_ALT_B_WALK_6F_01
	map_actor $0000, ActorScript_27_29, $2400, $1800, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $05, END16_BEFORE_FINALS_ALT_B_WALK_6F_00
	map_actor_end
End16BeforeFinalsScriptBody_27:
	script_move_target ACTOR_PLAYER, $1c00, $1900 ; $48a8
	script_wait_move ACTOR_PLAYER ; $48b3
	test_flag FLAG_DOUBLES ; $48b8
	jr nz, SetEnd16BeforeFinalsDoublesWalkScripts_27 ; $48bb
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_01 ; $48bd
	script_wait_actor_script ACTOR_PLAYER ; $48c8
	ret ; $48cd
ActorScript_27_00:
	; $48ce, 11 bytes (actor_script)
	as_set_target $1100, $1500
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_27_01:
	; $48d9, 23 bytes (actor_script)
	as_set_target $1c00, $1900
	as_wait_move
	as_set_target $1000, $1700
	as_wait_move
	as_set_target $0f00, $1500
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
SetEnd16BeforeFinalsDoublesWalkScripts_27:
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_00 ; $48f0
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_01 ; $48fb
	script_wait_actor_script ACTOR_PLAYER ; $4906
	ret ; $490b
End16BeforeFinalsCutscene_27:
	script_fade_in $08 ; $490c
	call WaitFadeEnd ; $4911
	call End16BeforeFinalsScriptBody_27 ; $4914
	farcall BeginCutsceneScriptMode ; $4917
	script_move_player $1100, $0f00 ; $491a
	farcall WaitPlayerMoveDone ; $4924
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $0e00, $0c00 ; $4927
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $4932
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $1300, $0c00 ; $4937
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $4942
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, FACE_DOWN ; $4947
	script_set_anim ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, ANIM_BOUNCE ; $494e
	script_wait_idle ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $4955
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, FACE_UP ; $495a
	script_set_anim ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, ANIM_NOD ; $4961
	script_wait_idle ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2 ; $4968
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, FACE_DOWN ; $496d
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, $1300, $1700 ; $4974
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $1300, $1700 ; $497f
	script_move_player $1100, $1300 ; $498a
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2 ; $4994
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, $1500, $1700 ; $4999
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2 ; $49a4
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, FACE_UP ; $49a9
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $49b0
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, FACE_UP ; $49b5
	script_face_pair ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2 ; $49bc
	script_set_anim ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2, ANIM_NOD ; $49c4
	script_wait_idle ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_2 ; $49cb
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $1000, $1700 ; $49d0
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $49db
	script_face ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, FACE_UP ; $49e0
	test_flag FLAG_DOUBLES ; $49e7
	jp nz, .face ; $49ea
	script_set_speed ACTOR_PLAYER, $0020 ; $49ed
	script_face_pair ACTOR_END16_BEFORE_FINALS_ALT_B_A_COZ, ACTOR_PLAYER ; $49f5
	script_wait_frames $1e ; $49fd
	script_face ACTOR_PLAYER, FACE_DOWN ; $4a04
	script_face ACTOR_END16_BEFORE_FINALS_ALT_B_A_COZ, FACE_DOWN ; $4a0b
	script_set_anim ACTOR_END16_BEFORE_FINALS_ALT_B_A_COZ, ANIM_NOD ; $4a12
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4a19
	script_wait_idle ACTOR_PLAYER ; $4a20
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $1300, $1700 ; $4a25
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $4a30
	script_set_actor_script ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, ActorScript_27_02 ; $4a35
	script_wait_frames $14 ; $4a40
	script_set_actor_script ACTOR_END16_BEFORE_FINALS_ALT_B_A_COZ, ActorScript_27_02 ; $4a47
	script_wait_frames $14 ; $4a52
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_02 ; $4a59
	script_wait_frames $14 ; $4a64
	script_move_player $1100, $0d00 ; $4a6b
	farcall WaitPlayerMoveDone ; $4a75
	script_wait_frames $1e ; $4a78
	ld a, $01 ; $4a7f
	ld [wUnusedExitTriggerIdMirror], a ; $4a81
	ld [wStoryModeExitTriggerRequest], a ; $4a84
	ret ; $4a87
.face:
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $4a88
	script_set_speed ACTOR_PLAYER, $0020 ; $4a90
	script_set_speed ACTOR_PARTNER, $0020 ; $4a98
	script_wait_frames $14 ; $4aa0
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4aa7
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4aae
	script_wait_idle ACTOR_PLAYER ; $4ab5
	script_face ACTOR_PLAYER, FACE_DOWN ; $4aba
	script_face ACTOR_PARTNER, FACE_DOWN ; $4ac1
	script_move_target ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, $1300, $1700 ; $4ac8
	script_wait_move ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3 ; $4ad3
	script_set_actor_script ACTOR_END16_BEFORE_FINALS_ALT_WALK_6F_07_3, ActorScript_27_02 ; $4ad8
	script_wait_frames $14 ; $4ae3
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_02 ; $4aea
	script_wait_frames $14 ; $4af5
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_02 ; $4afc
	script_wait_frames $3c ; $4b07
	script_set_actor_script $0b, ActorScript_27_03 ; $4b0e
	script_wait_frames $14 ; $4b19
	script_set_actor_script ACTOR_END16_BEFORE_FINALS_ALT_B_A_COZ, ActorScript_27_03 ; $4b20
	script_move_player $1100, $0d00 ; $4b2b
	farcall WaitPlayerMoveDone ; $4b35
	ld a, $01 ; $4b38
	ld [wUnusedExitTriggerIdMirror], a ; $4b3a
	ld [wStoryModeExitTriggerRequest], a ; $4b3d
	ret ; $4b40
; Two lists of three 6-byte records, each terminated by a $00 byte, in
; the shape of this bank's actor lists. The two differ in one byte
; (record 0 field 4 is $15 in the first list, $13 in the second), so
; they look like two variants of the same scene population.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_27_ActorLists:
	; $4b41, 38 bytes (bytes:6)
	db $04, $00, $13, $00, $15, $02 ; 0x00
	db $04, $00, $13, $00, $0b, $02 ; 0x06
	db $04, $00, $01, $00, $0b, $02 ; 0x0c
	db $00, $04, $00, $13, $00, $13 ; 0x12
	db $02, $04, $00, $13, $00, $0b ; 0x18
	db $02, $04, $00, $01, $00, $0b ; 0x1e
	db $02, $00 ; 0x24
