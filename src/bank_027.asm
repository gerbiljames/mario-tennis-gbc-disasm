SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

DataPtr_End17AwardCeremonyMapScripts_27:
	dw End17AwardCeremonyMapScripts_27 ; $4000
DataPtr_End16BeforeFinalsMapScripts_27:
	dw End16BeforeFinalsMapScripts_27 ; $4002
DataPtr_End12PrincipalsOfficeMapScripts_27:
	dw End12PrincipalsOfficeMapScripts_27 ; $4004
DataPtr_End11TrainingCourtMapScripts_27:
	dw End11TrainingCourtMapScripts_27 ; $4006
DataPtr_End10VarsityCourtMapScripts_27:
	dw End10VarsityCourtMapScripts_27 ; $4008
DataPtr_End8SrCourtMapScripts_27:
	dw End8SrCourtMapScripts_27 ; $400a
DataPtr_End7TrainingCtrMapScripts_27:
	dw End7TrainingCtrMapScripts_27 ; $400c
DataPtr_End5ServiceAceMapScripts_27:
	dw End5ServiceAceMapScripts_27 ; $400e
DataPtr_End4JrCourtMapScripts_27:
	dw End4JrCourtMapScripts_27 ; $4010
DataPtr_End3DormEntMapScripts_27:
	dw End3DormEntMapScripts_27 ; $4012
DataPtr_EndRestaurantEntMapScripts_27:
	dw EndRestaurantEntMapScripts_27 ; $4014
DataPtr_End1MainBldgMapScripts_27:
	dw End1MainBldgMapScripts_27 ; $4016
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
	map_actor $0000, ActorScript_27_785d, $0f00, $1600, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0c00, $1300, FACE_UP, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e80, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $1600, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e00, $0e40, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_27_785d, $0a00, $0dc0, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_27_785d, $0c00, $0d40, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_27_785d, $0700, $0500, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $0700, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e80, $1b00, FACE_UP, $62, $01, $00
	map_actor $0000, ActorScript_27_785d, $0980, $1b00, FACE_UP, $23, $01, $00
	map_actor $0000, ActorScript_27_785d, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor_end
End17AwardCeremonyActorsAlt_27:
	; $40d8, 178 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $0f00, $1600, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e00, $1300, FACE_UP, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e80, $17c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $1600, FACE_UP, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0900, $0e00, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_27_785d, $0b00, $0e00, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_27_785d, $0d00, $0d60, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_27_785d, $0700, $0500, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $0700, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $1b00, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_27_785d, $0900, $1b00, FACE_UP, $23, $01, $00
	map_actor $0000, ActorScript_27_785d, $0800, $1940, FACE_RIGHT, $25, $01, $05
	map_actor_end
End17AwardCeremonyEntryPoints_27:
	; $418a, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $1100, $0000
	db $ff
End17AwardCeremonyExitTriggers_27:
	; $4193, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $08, $06
	db $ff
End17AwardCeremonyNpcScripts_27:
	ds 1, $ff ; $419c, fill
End17AwardCeremonyFacingScripts_27:
	ds 1, $ff ; $419d, fill
End17AwardCeremonyTileTriggers_27:
	ds 1, $ff ; $419e, fill
End17AwardCeremonyInitScript_27:
	test_flag $05, 7 ; $419f
	jr z, Label_27_41c0 ; $41a2
	ldh a, [hRomBank] ; $41a4
	ld hl, End17AwardCeremonyActorsAlt_27 ; $41a6
	farcall FarPtr_ScriptRespawnLocationActors ; $41a9
	script_copy_scene_rect $1a, $0d, $08, $0d, $08, $03 ; $41ac
	farcall FarPtr_BeginCutsceneScriptMode ; $41bb
	jr Label_27_41c7 ; $41be
Label_27_41c0:
	script_set_anim $05, $06 ; $41c0
Label_27_41c7:
	call Func_27_45be ; $41c7
	jr Label_27_41cd ; $41ca
	ret ; $41cc
Label_27_41cd:
	script_set_position $03, $3f00, $3f00 ; $41cd
	script_set_position $00, $3f00, $3f00 ; $41d8
	xor a, a ; $41e3
	ld [wStoryModeShowLocationName], a ; $41e4
	script_fade_in $04 ; $41e7
	call WaitFadeEnd ; $41ec
	test_flag $05, 7 ; $41ef
	jp nz, Label_27_43c2 ; $41f2
	script_set_speed $03, $0010 ; $41f5
	script_set_speed $04, $0010 ; $41fd
	script_set_speed $05, $0010 ; $4205
	script_set_speed $06, $0010 ; $420d
	script_face $06, $40 ; $4215
	script_delay $1e ; $421c
	script_set_position $05, $0f80, $1600 ; $4221
	script_delay $1e ; $422c
	script_set_position $06, $3f00, $3f00 ; $4231
	script_set_position $03, $0f00, $1600 ; $423c
	script_set_position $05, $0f00, $1500 ; $4247
	script_face $03, $c0 ; $4252
	script_move_target $05, $0f00, $1200 ; $4259
	script_move_target $03, $0f00, $1300 ; $4264
	script_wait_move $03 ; $426f
	script_set_position $03, $3f00, $3f00 ; $4274
	script_set_position $06, $0f00, $1300 ; $427f
	script_set_position $05, $0e00, $1300 ; $428a
	script_face $06, $80 ; $4295
	script_move_target $06, $0e00, $1300 ; $429c
	script_move_target $05, $0d00, $1300 ; $42a7
	script_wait_move $05 ; $42b2
	script_facing_lock $06, $01 ; $42b7
	script_move_target $06, $0f00, $1300 ; $42be
	script_wait_move $06 ; $42c9
	script_facing_lock $06, $00 ; $42ce
	script_move_target $06, $0f00, $1600 ; $42d5
	script_wait_move $06 ; $42e0
	script_face $06, $c0 ; $42e5
	script_move_target $04, $0c00, $1100 ; $42ec
	script_move_target $05, $0c00, $1000 ; $42f7
	script_wait_move $05 ; $4302
	script_delay $50 ; $4307
	script_move_target $04, $0c00, $0f80 ; $430c
	script_move_target $05, $0c00, $0e40 ; $4317
	script_wait_move $05 ; $4322
	script_facing_lock $04, $01 ; $4327
	script_move_target $04, $0c00, $1100 ; $432e
	script_wait_move $04 ; $4339
	script_facing_lock $04, $00 ; $433e
	script_face $04, $c0 ; $4345
	script_set_anim $0e, $02 ; $434c
	script_wait_idle $0e ; $4353
	script_delay $32 ; $4358
	script_face $07, $80 ; $435d
	script_face $08, $00 ; $4364
	script_delay $3c ; $436b
	script_set_position $05, $0b40, $0c40 ; $4370
Label_27_437b:
	ld a, [$c90d] ; $437b
	ld d, $26 ; $437e
	add a, d ; $4380
	ld d, a ; $4381
	script_get_actor_state $09 ; $4382
	ld c, l ; $4387
	ld b, h ; $4388
	farcall FarPtr_LoadActorObjectDefIfValid ; $4389
	script_set_anim $09, $01 ; $438c
	script_face $09, $00 ; $4393
	script_set_anim $09, $08 ; $439a
	script_player_speed $0006 ; $43a1
	script_move_player $0c00, $0d00 ; $43a7
	farcall FarPtr_WaitPlayerMoveDone ; $43b1
	script_delay $32 ; $43b4
	ld a, $01 ; $43b9
	ld [$c294], a ; $43bb
	ld [wStoryModeExitLocationRequest], a ; $43be
	ret ; $43c1
Label_27_43c2:
	script_set_speed $03, $0010 ; $43c2
	script_set_speed $04, $0010 ; $43ca
	script_set_speed $05, $0010 ; $43d2
	script_set_speed $06, $0010 ; $43da
	script_move_target $06, $0f00, $1600 ; $43e2
	script_wait_move $06 ; $43ed
	script_face $06, $40 ; $43f2
	script_delay $14 ; $43f9
	script_set_position $05, $0f80, $1600 ; $43fe
	script_delay $14 ; $4409
	script_set_position $06, $3f00, $3f00 ; $440e
	script_set_position $03, $0f00, $1600 ; $4419
	script_set_position $05, $0f00, $1500 ; $4424
	script_face $03, $c0 ; $442f
	script_move_target $05, $0f00, $1300 ; $4436
	script_move_target $03, $0f00, $1400 ; $4441
	script_wait_move $03 ; $444c
	script_face $06, $c0 ; $4451
	script_facing_lock $03, $01 ; $4458
	script_move_target $03, $0f00, $1600 ; $445f
	script_wait_move $03 ; $446a
	script_facing_lock $03, $00 ; $446f
	script_face $03, $c0 ; $4476
	script_set_position $05, $0ec0, $1300 ; $447d
	script_move_target $04, $0f00, $1300 ; $4488
	script_move_target $05, $0fc0, $1300 ; $4493
	script_wait_move $05 ; $449e
	script_move_target $04, $0f00, $1100 ; $44a3
	script_move_target $05, $0fc0, $1100 ; $44ae
	script_wait_move $05 ; $44b9
	script_delay $3c ; $44be
	script_set_anim $02, $03 ; $44c3
	script_wait_idle $02 ; $44ca
	script_set_anim $04, $03 ; $44cf
	script_wait_idle $04 ; $44d6
	script_delay $3c ; $44db
	script_set_position $05, $0e40, $1100 ; $44e0
	script_move_target $04, $0d00, $1100 ; $44eb
	script_move_target $05, $0c40, $1100 ; $44f6
	script_wait_move $05 ; $4501
	script_delay $04 ; $4506
	script_face $04, $c0 ; $450b
	script_move_target $05, $0d00, $1000 ; $4512
	script_wait_move $05 ; $451d
	script_delay $32 ; $4522
	script_move_target $04, $0d00, $1000 ; $4527
	script_move_target $05, $0d00, $0e80 ; $4532
	script_wait_move $05 ; $453d
	script_delay $05 ; $4542
	script_facing_lock $04, $01 ; $4547
	script_move_target $04, $0d00, $1100 ; $454e
	script_wait_move $04 ; $4559
	script_facing_lock $04, $00 ; $455e
	script_face $04, $c0 ; $4565
	script_set_anim $0e, $02 ; $456c
	script_wait_idle $0e ; $4573
	script_delay $1e ; $4578
	script_set_anim $09, $03 ; $457d
	script_set_anim $02, $03 ; $4584
	script_wait_idle $02 ; $458b
	script_delay $1e ; $4590
	script_face $02, $80 ; $4595
	script_face $07, $00 ; $459c
	script_face $08, $00 ; $45a3
	script_delay $3c ; $45aa
	script_set_position $05, $0c40, $0c60 ; $45af
	jp Label_27_437b ; $45ba
	ret ; $45bd
Func_27_45be:
	test_flag $05, 7 ; $45be
	jp z, Label_27_45f3 ; $45c1
	ld a, [$c94d] ; $45c4
	ld d, $58 ; $45c7
	add a, d ; $45c9
	ld d, a ; $45ca
	script_get_actor_state $02 ; $45cb
	ld c, l ; $45d0
	ld b, h ; $45d1
	farcall FarPtr_LoadActorObjectDefIfValid ; $45d2
	script_set_anim $02, $01 ; $45d5
	script_null_script $02 ; $45dc
	script_set_position $02, $0f00, $0d60 ; $45e1
	script_face $02, $40 ; $45ec
Label_27_45f3:
	ld a, [$c90d] ; $45f3
	ld d, $56 ; $45f6
	add a, d ; $45f8
	ld d, a ; $45f9
	script_get_actor_state $09 ; $45fa
	ld c, l ; $45ff
	ld b, h ; $4600
	farcall FarPtr_LoadActorObjectDefIfValid ; $4601
	script_set_anim $09, $01 ; $4604
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
	map_actor $0000, ActorScript_27_785d, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0100, $0c00, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1100, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_27_787b, $2300, $1700, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_27_785d, $2100, $1100, FACE_RIGHT, $5a, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_27_785d, $1100, $1500, FACE_DOWN, $5d, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $1300, FACE_DOWN, $60, $01, $00
	map_actor $0000, ActorScript_27_785d, $1700, $1300, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $1300, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $1500, FACE_DOWN, $5e, $01, $00
	map_actor $0000, ActorScript_27_785d, $1700, $1500, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_27_785d, $1100, $1300, FACE_DOWN, $1f, $01, $00
	map_actor_end
End16BeforeFinalsEntryPoints_27:
	; $46e8, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $1c00, $2300, $0000
	db $ff
End16BeforeFinalsExitTriggers_27:
	; $46f1, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $18, $01
	db $ff
End16BeforeFinalsNpcScripts_27:
	ds 1, $ff ; $46fa, fill
End16BeforeFinalsFacingScripts_27:
	ds 1, $ff ; $46fb, fill
End16BeforeFinalsTileTriggers_27:
	ds 1, $ff ; $46fc, fill
End16BeforeFinalsInitScript_27:
	test_flag $05, 7 ; $46fd
	jr nz, Label_27_470e ; $4700
	ldh a, [hRomBank] ; $4702
	ld hl, End16BeforeFinalsActorsAlt_27 ; $4704
	farcall FarPtr_ScriptRespawnLocationActors ; $4707
	call Func_27_490c ; $470a
	ret ; $470d
Label_27_470e:
	ldh a, [hRomBank] ; $470e
	ld hl, End16BeforeFinalsActorsAltB_27 ; $4710
	farcall FarPtr_ScriptRespawnLocationActors ; $4713
	call Func_27_490c ; $4716
	ret ; $4719
End16BeforeFinalsActorsAlt_27:
	; $471a, 206 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e00, $0400, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1100, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_27_787b, $2300, $1700, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_27_785d, $1100, $1500, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_27_785d, $2100, $1100, FACE_RIGHT, $5a, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_27_7867, $0700, $1f00, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $1300, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_27_785d, $0500, $2100, FACE_DOWN, $1e, $01, $00
	map_actor $0000, ActorScript_27_787b, $2900, $1500, FACE_DOWN, $1f, $01, $00
	map_actor_end
End16BeforeFinalsActorsAltB_27:
	; $47e8, 192 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2700, $1100, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $1300, $0f00, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $0e00, $0400, FACE_RIGHT, $25, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1100, FACE_DOWN, $5c, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1300, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $1700, FACE_LEFT, $5f, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $1900, FACE_LEFT, $60, $01, $00
	map_actor $0000, ActorScript_27_785d, $0f00, $1300, FACE_DOWN, $61, $01, $00
	map_actor $0000, ActorScript_27_785d, $1100, $1300, FACE_DOWN, $62, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $1100, FACE_RIGHT, $5d, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $1300, FACE_RIGHT, $5e, $01, $00
	map_actor $0000, ActorScript_27_787b, $2900, $1500, FACE_DOWN, $1f, $01, $00
	map_actor $0000, ActorScript_27_787b, $2400, $1800, FACE_DOWN, $1e, $01, $05
	map_actor_end
End16BeforeFinalsScriptBody_27:
	script_move_target $00, $1c00, $1900 ; $48a8
	script_wait_move $00 ; $48b3
	test_flag $05, 7 ; $48b8
	jr nz, Label_27_48f0 ; $48bb
	script_set_actor_script $00, ActorScript_27_48d9 ; $48bd
	script_wait_actor_script $00 ; $48c8
	ret ; $48cd
ActorScript_27_48ce:
	; $48ce, 11 bytes (actor_script)
	as_set_pos $1100, $1500
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_48d9:
	; $48d9, 23 bytes (actor_script)
	as_set_pos $1c00, $1900
	as_wait_move
	as_set_pos $1000, $1700
	as_wait_move
	as_set_pos $0f00, $1500
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
Label_27_48f0:
	script_set_actor_script $00, ActorScript_27_48ce ; $48f0
	script_set_actor_script $02, ActorScript_27_48d9 ; $48fb
	script_wait_actor_script $00 ; $4906
	ret ; $490b
Func_27_490c:
	script_fade_in $08 ; $490c
	call WaitFadeEnd ; $4911
	call End16BeforeFinalsScriptBody_27 ; $4914
	farcall FarPtr_BeginCutsceneScriptMode ; $4917
	script_move_player $1100, $0f00 ; $491a
	farcall FarPtr_WaitPlayerMoveDone ; $4924
	script_move_target $05, $0e00, $0c00 ; $4927
	script_wait_move $05 ; $4932
	script_move_target $05, $1300, $0c00 ; $4937
	script_wait_move $05 ; $4942
	script_face $05, $40 ; $4947
	script_set_anim $05, $02 ; $494e
	script_wait_idle $05 ; $4955
	script_face $04, $c0 ; $495a
	script_set_anim $04, $03 ; $4961
	script_wait_idle $04 ; $4968
	script_face $04, $40 ; $496d
	script_move_target $04, $1300, $1700 ; $4974
	script_move_target $05, $1300, $1700 ; $497f
	script_move_player $1100, $1300 ; $498a
	script_wait_move $04 ; $4994
	script_move_target $04, $1500, $1700 ; $4999
	script_wait_move $04 ; $49a4
	script_face $04, $c0 ; $49a9
	script_wait_move $05 ; $49b0
	script_face $05, $c0 ; $49b5
	script_face_pair $05, $04 ; $49bc
	script_set_anim $04, $03 ; $49c4
	script_wait_idle $04 ; $49cb
	script_move_target $05, $1000, $1700 ; $49d0
	script_wait_move $05 ; $49db
	script_face $05, $c0 ; $49e0
	test_flag $05, 7 ; $49e7
	jp nz, Label_27_4a88 ; $49ea
	script_set_speed $00, $0020 ; $49ed
	script_face_pair $0a, $00 ; $49f5
	script_wait_frames $1e ; $49fd
	script_face $00, $40 ; $4a04
	script_face $0a, $40 ; $4a0b
	script_set_anim $0a, $03 ; $4a12
	script_set_anim $00, $03 ; $4a19
	script_wait_idle $00 ; $4a20
	script_move_target $05, $1300, $1700 ; $4a25
	script_wait_move $05 ; $4a30
	script_set_actor_script $05, ActorScript_27_4b67 ; $4a35
	script_wait_frames $14 ; $4a40
	script_set_actor_script $0a, ActorScript_27_4b67 ; $4a47
	script_wait_frames $14 ; $4a52
	script_set_actor_script $00, ActorScript_27_4b67 ; $4a59
	script_wait_frames $14 ; $4a64
	script_move_player $1100, $0d00 ; $4a6b
	farcall FarPtr_WaitPlayerMoveDone ; $4a75
	script_wait_frames $1e ; $4a78
	ld a, $01 ; $4a7f
	ld [$c294], a ; $4a81
	ld [wStoryModeExitLocationRequest], a ; $4a84
	ret ; $4a87
Label_27_4a88:
	script_face_pair $02, $00 ; $4a88
	script_set_speed $00, $0020 ; $4a90
	script_set_speed $02, $0020 ; $4a98
	script_wait_frames $14 ; $4aa0
	script_set_anim $02, $03 ; $4aa7
	script_set_anim $00, $03 ; $4aae
	script_wait_idle $00 ; $4ab5
	script_face $00, $40 ; $4aba
	script_face $02, $40 ; $4ac1
	script_move_target $05, $1300, $1700 ; $4ac8
	script_wait_move $05 ; $4ad3
	script_set_actor_script $05, ActorScript_27_4b67 ; $4ad8
	script_wait_frames $14 ; $4ae3
	script_set_actor_script $00, ActorScript_27_4b67 ; $4aea
	script_wait_frames $14 ; $4af5
	script_set_actor_script $02, ActorScript_27_4b67 ; $4afc
	script_wait_frames $3c ; $4b07
	script_set_actor_script $0b, ActorScript_27_4b80 ; $4b0e
	script_wait_frames $14 ; $4b19
	script_set_actor_script $0a, ActorScript_27_4b80 ; $4b20
	script_move_player $1100, $0d00 ; $4b2b
	farcall FarPtr_WaitPlayerMoveDone ; $4b35
	ld a, $01 ; $4b38
	ld [$c294], a ; $4b3a
	ld [wStoryModeExitLocationRequest], a ; $4b3d
	ret ; $4b40
	INCBIN "data/bank_027/d_4b41.bin" ; $4b41, 38 bytes
ActorScript_27_4b67:
	; $4b67, 25 bytes (actor_script)
	as_set_pos $1300, $1500
	as_wait_move
	as_set_pos $1300, $0b00
	as_wait_move
	as_set_pos $0e00, $0b00
	as_wait_move
	as_set_pos $0e00, $0700
	as_wait_move
	as_halt
ActorScript_27_4b80:
	; $4b80, 60 bytes (actor_script)
	as_set_pos $1300, $1300
	as_wait_move
	as_set_pos $1300, $0b00
	as_wait_move
	as_set_pos $0e00, $0b00
	as_wait_move
	as_set_pos $0e00, $0700
	as_wait_move
	as_halt
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L21:
	as_target_rel $fe00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_target_rel $0200, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_wait $4b
	as_jump .L21
End12PrincipalsOfficeMapScripts_27:
	; $4bbc, 14 bytes (map_tree)
	dw End12PrincipalsOfficeEntryPoints_27 ; slot 0 EntryPoints
	dw End12PrincipalsOfficeExitTriggers_27 ; slot 1 ExitTriggers
	dw End12PrincipalsOfficeActors_27 ; slot 2 Actors
	dw End12PrincipalsOfficeNpcScripts_27 ; slot 3 NpcScripts
	dw End12PrincipalsOfficeFacingScripts_27 ; slot 4 FacingScripts
	dw End12PrincipalsOfficeTileTriggers_27 ; slot 5 TileTriggers
	dw End12PrincipalsOfficeInitScript_27 ; slot 6 InitScript
End12PrincipalsOfficeActors_27:
	; $4bca, 122 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $51, $01, $00
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_27_785d, $2000, $2f00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $2200, $3300, FACE_LEFT, $4b, $01, $00
	map_actor $0000, ActorScript_27_785d, $2000, $3300, FACE_LEFT, $4a, $01, $00
	map_actor $0000, ActorScript_27_785d, $1e00, $3300, FACE_RIGHT, $49, $01, $00
	map_actor_end
End12PrincipalsOfficeEntryPoints_27:
	; $4c44, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, $1f00, $3b00, $0000
	map_entry $02, FACE_LEFT, $1f00, $3b00, $0000
	db $ff
End12PrincipalsOfficeExitTriggers_27:
	; $4c55, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $14, $01
	db $ff
End12PrincipalsOfficeNpcScripts_27:
	ds 1, $ff ; $4c5e, fill
End12PrincipalsOfficeFacingScripts_27:
	ds 1, $ff ; $4c5f, fill
End12PrincipalsOfficeTileTriggers_27:
	ds 1, $ff ; $4c60, fill
End12PrincipalsOfficeInitScript_27:
	ld a, $16 ; $4c61
	ld [$c329], a ; $4c63
	ld a, $28 ; $4c66
	ld [$c32a], a ; $4c68
	ld a, $40 ; $4c6b
	ld [$c32b], a ; $4c6d
	ld a, $3e ; $4c70
	ld [$c32c], a ; $4c72
	call DisableLCDSafely ; $4c75
	ld a, $00 ; $4c78
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4c7a
	call EnableLCD ; $4c7d
	ld a, [wStoryModeEntryPoint] ; $4c80
	cp a, $02 ; $4c83
	jp z, Label_27_4ff0 ; $4c85
	jp Label_27_4c8c ; $4c88
	ret ; $4c8b
Label_27_4c8c:
	xor a, a ; $4c8c
	ld [wStoryModeShowLocationName], a ; $4c8d
	script_set_position $00, $2b00, $3b00 ; $4c90
	script_set_position $02, $2b00, $3b00 ; $4c9b
	script_fade_in $04 ; $4ca6
	script_delay $14 ; $4cab
	script_move_target $07, $1e00, $2f00 ; $4cb0
	script_wait_move $07 ; $4cbb
	script_face $07, $40 ; $4cc0
	script_delay $1e ; $4cc7
	script_move_target $07, $2200, $2f00 ; $4ccc
	script_wait_move $07 ; $4cd7
	script_face $07, $40 ; $4cdc
	script_delay $1e ; $4ce3
	script_move_target $07, $2000, $2f00 ; $4ce8
	script_wait_move $07 ; $4cf3
	script_face $07, $40 ; $4cf8
	script_delay $0a ; $4cff
	script_set_anim $07, $02 ; $4d04
	script_wait_idle $07 ; $4d0b
	script_face $08, $c0 ; $4d10
	script_face $09, $c0 ; $4d17
	script_face $0a, $c0 ; $4d1e
	sound $96 ; $4d25
	script_set_position $04, $1f80, $3180 ; $4d27
	script_delay $28 ; $4d32
	sound $96 ; $4d37
	script_set_position $06, $2180, $3180 ; $4d39
	script_delay $28 ; $4d44
	sound $96 ; $4d49
	script_set_position $04, $2380, $3180 ; $4d4b
	script_delay $28 ; $4d56
	script_set_position $06, $3f00, $3f00 ; $4d5b
	script_delay $28 ; $4d66
	script_set_position $04, $3f00, $3f00 ; $4d6b
	test_flag $05, 7 ; $4d76
	jp z, Label_27_4e13 ; $4d79
	script_null_script $02 ; $4d7c
	script_set_position $02, $2d00, $3b00 ; $4d81
	script_move_target $00, $2100, $3b00 ; $4d8c
	script_move_target $02, $2300, $3b00 ; $4d97
	script_wait_move $02 ; $4da2
	script_wait_frames $05 ; $4da7
	script_face $00, $c0 ; $4dae
	call Func_27_516b ; $4db5
	script_move_target $00, $2100, $3500 ; $4db8
	script_move_target $02, $2100, $3b00 ; $4dc3
	script_wait_move $02 ; $4dce
	script_move_target $00, $1f00, $3500 ; $4dd3
	script_move_target $02, $2100, $3500 ; $4dde
	script_wait_move $02 ; $4de9
	script_move_target $02, $2100, $3500 ; $4dee
	script_wait_move $02 ; $4df9
	script_face $00, $c0 ; $4dfe
	script_face $02, $c0 ; $4e05
	script_delay $01 ; $4e0c
	jr Label_27_4e59 ; $4e11
Label_27_4e13:
	script_move_target $00, $2100, $3b00 ; $4e13
	script_wait_move $00 ; $4e1e
	script_face $00, $c0 ; $4e23
	call Func_27_516b ; $4e2a
	script_move_target $00, $2100, $3500 ; $4e2d
	script_wait_move $00 ; $4e38
	script_move_target $00, $2000, $3500 ; $4e3d
	script_wait_move $00 ; $4e48
	script_face $00, $c0 ; $4e4d
	script_delay $01 ; $4e54
Label_27_4e59:
	call Func_27_51a1 ; $4e59
	script_set_anim $07, $02 ; $4e5c
	script_set_anim $08, $02 ; $4e63
	script_set_anim $09, $02 ; $4e6a
	script_set_anim $0a, $02 ; $4e71
	script_wait_idle $0a ; $4e78
	script_delay $1e ; $4e7d
	script_move_target $0a, $1d00, $3500 ; $4e82
	script_move_target $09, $2300, $3500 ; $4e8d
	script_move_target $08, $2500, $3500 ; $4e98
	script_wait_move $08 ; $4ea3
	script_face $0a, $00 ; $4ea8
	script_face $09, $80 ; $4eaf
	script_face $08, $80 ; $4eb6
	script_delay $0a ; $4ebd
	test_flag $05, 7 ; $4ec2
	jp z, Label_27_4f62 ; $4ec5
	script_delay $3c ; $4ec8
	script_face_toward $02, $00 ; $4ecd
	script_set_anim $00, $02 ; $4ed5
	script_wait_idle $00 ; $4edc
	script_delay $14 ; $4ee1
	script_face_toward $00, $02 ; $4ee6
	script_delay $01 ; $4eee
	script_set_anim $02, $03 ; $4ef3
	script_wait_idle $02 ; $4efa
	script_delay $14 ; $4eff
	script_face $00, $c0 ; $4f04
	script_face $02, $c0 ; $4f0b
	script_set_anim $08, $03 ; $4f12
	script_set_anim $09, $03 ; $4f19
	script_set_anim $0a, $03 ; $4f20
	script_wait_idle $0a ; $4f27
	script_delay $28 ; $4f2c
	script_set_anim $00, $03 ; $4f31
	script_set_anim $02, $03 ; $4f38
	script_wait_idle $02 ; $4f3f
	script_move_target $00, $1f00, $3200 ; $4f44
	script_move_target $02, $2100, $3200 ; $4f4f
	script_wait_move $02 ; $4f5a
	jp Label_27_4fe7 ; $4f5f
Label_27_4f62:
	sound $96 ; $4f62
	script_set_position $04, $2180, $3380 ; $4f64
	script_delay $50 ; $4f6f
	script_set_position $04, $3f00, $3f00 ; $4f74
	script_face_toward $0a, $00 ; $4f7f
	script_delay $28 ; $4f87
	script_face_toward $00, $0a ; $4f8c
	script_delay $01 ; $4f94
	script_set_anim $0a, $03 ; $4f99
	script_wait_idle $0a ; $4fa0
	script_delay $14 ; $4fa5
	script_face $00, $c0 ; $4faa
	script_set_anim $08, $03 ; $4fb1
	script_set_anim $09, $03 ; $4fb8
	script_set_anim $0a, $03 ; $4fbf
	script_wait_idle $0a ; $4fc6
	script_delay $28 ; $4fcb
	script_set_anim $00, $03 ; $4fd0
	script_move_target $00, $2000, $3200 ; $4fd7
	script_wait_move $00 ; $4fe2
Label_27_4fe7:
	ld a, $01 ; $4fe7
	ld [$c294], a ; $4fe9
	ld [wStoryModeExitLocationRequest], a ; $4fec
	ret ; $4fef
Label_27_4ff0:
	ldh a, [hRomBank] ; $4ff0
	ld hl, End12PrincipalsOfficeActorsAlt_27 ; $4ff2
	farcall FarPtr_ScriptRespawnLocationActors ; $4ff5
	farcall FarPtr_BeginCutsceneScriptMode ; $4ff8
	script_set_anim $04, $06 ; $4ffb
	test_flag $05, 7 ; $5002
	jp z, Label_27_503c ; $5005
	script_null_script $02 ; $5008
	script_set_position $00, $1f00, $3400 ; $500d
	script_set_position $02, $2100, $3400 ; $5018
	script_face $02, $c0 ; $5023
	test_flag $07, 4 ; $502a
	jr nz, Label_27_5057 ; $502d
	script_set_position $04, $3f00, $3f00 ; $502f
	jr Label_27_5057 ; $503a
Label_27_503c:
	script_set_position $00, $2000, $3400 ; $503c
	test_flag $06, 5 ; $5047
	jr nz, Label_27_5057 ; $504a
	script_set_position $05, $3f00, $3f00 ; $504c
Label_27_5057:
	script_face $00, $c0 ; $5057
	xor a, a ; $505e
	ld [wStoryModeShowLocationName], a ; $505f
	script_fade_in $04 ; $5062
	call WaitFadeEnd ; $5067
	test_flag $05, 7 ; $506a
	jp z, Label_27_50ff ; $506d
	script_set_anim $00, $03 ; $5070
	script_wait_idle $00 ; $5077
	script_set_anim $03, $03 ; $507c
	script_wait_idle $03 ; $5083
	script_delay $3c ; $5088
	script_face_pair $02, $00 ; $508d
	script_delay $1e ; $5095
	script_set_anim $00, $03 ; $509a
	script_set_anim $02, $03 ; $50a1
	script_wait_idle $02 ; $50a8
	script_face $02, $40 ; $50ad
	script_move_target $00, $2100, $3600 ; $50b4
	script_wait_move $00 ; $50bf
	script_move_target $00, $2100, $3700 ; $50c4
	script_move_target $02, $2100, $3500 ; $50cf
	script_wait_move $02 ; $50da
	call Func_27_516b ; $50df
	script_set_actor_script $00, ActorScript_27_51d0 ; $50e2
	script_set_actor_script $02, ActorScript_27_51d0 ; $50ed
	script_delay $14 ; $50f8
	jr Label_27_514f ; $50fd
Label_27_50ff:
	script_set_anim $00, $03 ; $50ff
	script_wait_idle $00 ; $5106
	script_set_anim $03, $03 ; $510b
	script_wait_idle $03 ; $5112
	script_delay $3c ; $5117
	script_move_target $00, $2100, $3400 ; $511c
	script_wait_move $00 ; $5127
	script_move_target $00, $2100, $3700 ; $512c
	script_wait_move $00 ; $5137
	call Func_27_516b ; $513c
	script_set_actor_script $00, ActorScript_27_51d0 ; $513f
	script_delay $14 ; $514a
Label_27_514f:
	call Func_27_51a1 ; $514f
	script_delay $3c ; $5152
	set_flag $0d, 5 ; $5157
	ld c, $04 ; $515a
	call BeginFadeOut ; $515c
	call WaitFadeEnd ; $515f
	ld a, $01 ; $5162
	ld [$c294], a ; $5164
	ld [wStoryModeExitLocationRequest], a ; $5167
	ret ; $516a
Func_27_516b:
	script_wait_frames $0a ; $516b
	sound $79 ; $5172
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $5174
	script_wait_frames $02 ; $5183
	script_copy_scene_rect $0b, $38, $20, $38, $02, $02 ; $518a
	script_wait_frames $04 ; $5199
	ret ; $51a0
Func_27_51a1:
	sound $79 ; $51a1
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $51a3
	script_wait_frames $02 ; $51b2
	script_copy_scene_rect $03, $38, $20, $38, $02, $02 ; $51b9
	script_wait_frames $04 ; $51c8
	ret ; $51cf
ActorScript_27_51d0:
	; $51d0, 13 bytes (actor_script)
	as_set_pos $2100, $3b00
	as_wait_move
	as_set_pos $3500, $3b00
	as_wait_move
	as_halt
End12PrincipalsOfficeActorsAlt_27:
	; $51dd, 52 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2000, $3000, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_27_785d, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor_end
End11TrainingCourtMapScripts_27:
	; $5211, 14 bytes (map_tree)
	dw End11TrainingCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End11TrainingCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End11TrainingCourtActors_27 ; slot 2 Actors
	dw End11TrainingCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End11TrainingCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End11TrainingCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End11TrainingCourtInitScript_27 ; slot 6 InitScript
End11TrainingCourtActors_27:
	; $521f, 52 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $3f00, $0500, FACE_DOWN, $6c, $01, $00
	map_actor $0000, ActorScript_27_785d, $3f00, $0500, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_27_785d, $3f00, $0500, FACE_DOWN, $4c, $01, $00
	map_actor_end
End11TrainingCourtEntryPoints_27:
	; $5253, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3300, $0d00, $0000
	map_entry $02, FACE_UP, $1800, $1100, $0000
	db $ff
End11TrainingCourtExitTriggers_27:
	; $5264, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $08, $00
	db $ff
End11TrainingCourtNpcScripts_27:
	ds 1, $ff ; $526d, fill
End11TrainingCourtFacingScripts_27:
	ds 1, $ff ; $526e, fill
End11TrainingCourtTileTriggers_27:
	ds 1, $ff ; $526f, fill
End11TrainingCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $5270
	cp a, $01 ; $5273
	jp z, Label_27_527e ; $5275
	cp a, $02 ; $5278
	jp z, Label_27_53f9 ; $527a
	ret ; $527d
Label_27_527e:
	test_flag $05, 7 ; $527e
	jr z, Label_27_5299 ; $5281
	script_set_actor_script $02, ActorScript_27_785d ; $5283
	script_set_position $02, $3f00, $3f00 ; $528e
Label_27_5299:
	ld a, [$c90e] ; $5299
	and a, a ; $529c
	jr z, Label_27_52ae ; $529d
	script_get_actor_state $00 ; $529f
	ld c, l ; $52a4
	ld b, h ; $52a5
	ld hl, $0037 ; $52a6
	add hl, bc ; $52a9
	ld a, [hl] ; $52aa
	xor a, $20 ; $52ab
	ld [hl], a ; $52ad
Label_27_52ae:
	script_face $00, $40 ; $52ae
	script_set_actor_script $00, ActorScript_27_555e ; $52b5
	xor a, a ; $52c0
	ld [wStoryModeShowLocationName], a ; $52c1
	script_fade_in $04 ; $52c4
	script_delay $78 ; $52c9
	script_get_actor_state $00 ; $52ce
	ld a, $01 ; $52d3
	ld e, l ; $52d5
	ld d, h ; $52d6
	ld hl, $0018 ; $52d7
	add hl, de ; $52da
	ld [hl], a ; $52db
	script_set_anim $00, $02 ; $52dc
	script_wait_idle $00 ; $52e3
	script_null_script $00 ; $52e8
	script_set_anim $00, $01 ; $52ed
	script_delay $3c ; $52f4
	script_face $00, $80 ; $52f9
	script_delay $1e ; $5300
	script_face $00, $00 ; $5305
	script_delay $1e ; $530c
	script_face $00, $80 ; $5311
	script_delay $1e ; $5318
	script_face $00, $00 ; $531d
	script_delay $1e ; $5324
	script_face $00, $40 ; $5329
	script_delay $1e ; $5330
	sound $98 ; $5335
	script_set_position $04, $3480, $0b80 ; $5337
	script_delay $3c ; $5342
	script_set_position $03, $3300, $0700 ; $5347
	script_set_active $03, $00 ; $5352
	script_player_speed $0010 ; $5359
	script_move_player_to_actor $03 ; $535f
	ld hl, $5580 ; $5366
	ld de, $0206 ; $5369
	call LoadPalettesImmediate ; $536c
	script_delay $1e ; $536f
	ld hl, $55c0 ; $5374
	ld de, $0206 ; $5377
	call LoadPalettesImmediate ; $537a
	ld a, $10 ; $537d
Label_27_537f:
	ld d, a ; $537f
	script_set_active $03, $02 ; $5380
	script_wait_frames $04 ; $5387
	script_set_active $03, $00 ; $538e
	push af ; $5395
	ld a, d ; $5396
	farcall FarPtr_WaitScriptFrames ; $5397
	pop af ; $539a
	ld a, d ; $539b
	sub a, $02 ; $539c
	jp nz, Label_27_537f ; $539e
	script_set_active $03, $02 ; $53a1
	script_delay $3c ; $53a8
	script_set_position $04, $3f00, $3f00 ; $53ad
	script_face $00, $c0 ; $53b8
	script_delay $1e ; $53bf
	sound $97 ; $53c4
	script_set_position $05, $3480, $0b80 ; $53c6
	script_delay $14 ; $53d1
	script_jump_velocity $05, $ff40 ; $53d6
	script_jump_velocity $00, $ff40 ; $53de
	ld a, $00 ; $53e6
	farcall FarPtr_ScriptWaitActorJumpDone ; $53e8
	script_delay $1e ; $53eb
	ld a, $01 ; $53f0
	ld [$c294], a ; $53f2
	ld [wStoryModeExitLocationRequest], a ; $53f5
	ret ; $53f8
Label_27_53f9:
	ldh a, [hRomBank] ; $53f9
	ld hl, End11TrainingCourtActorsAlt_27 ; $53fb
	farcall FarPtr_ScriptRespawnLocationActors ; $53fe
	script_set_position $00, $1800, $1100 ; $5401
	farcall FarPtr_BeginCutsceneScriptMode ; $540c
	script_face $00, $c0 ; $540f
	script_set_position $06, $1800, $0d00 ; $5416
	script_face $06, $40 ; $5421
	script_null_script $02 ; $5428
	script_set_position $02, $1300, $1100 ; $542d
	script_face $02, $00 ; $5438
	script_move_player $1800, $0f00 ; $543f
	farcall FarPtr_WaitPlayerMoveDone ; $5449
	script_fade_in $08 ; $544c
	call WaitFadeEnd ; $5451
	script_wait_frames $1e ; $5454
	script_set_anim $06, $02 ; $545b
	script_wait_idle $06 ; $5462
	script_facing_lock $06, $01 ; $5467
	script_move_angle $06, $c0, $0100 ; $546e
	script_wait_move $06 ; $5478
	script_wait_frames $28 ; $547d
	script_move_angle $06, $c0, $0100 ; $5484
	script_wait_move $06 ; $548e
	script_set_anim $06, $02 ; $5493
	script_wait_idle $06 ; $549a
	script_facing_lock $06, $00 ; $549f
	script_set_speed $06, $0030 ; $54a6
	script_get_actor_state $06 ; $54ae
	ld a, $04 ; $54b3
	ld e, l ; $54b5
	ld d, h ; $54b6
	ld hl, $0018 ; $54b7
	add hl, de ; $54ba
	ld [hl], a ; $54bb
	script_move_target $06, $1f00, $0b00 ; $54bc
	script_wait_move $06 ; $54c7
	script_move_target $06, $1f00, $1100 ; $54cc
	script_wait_move $06 ; $54d7
	script_face $00, $40 ; $54dc
	script_move_target $06, $1f00, $1f00 ; $54e3
	script_wait_move $06 ; $54ee
	script_set_position $06, $3f00, $3f00 ; $54f3
	ld a, $01 ; $54fe
	ld [$c294], a ; $5500
	ld [wStoryModeExitLocationRequest], a ; $5503
	ret ; $5506
End11TrainingCourtActorsAlt_27:
	; $5507, 80 bytes (map_actors)
	map_actor $0000, ActorScript_27_5557, $0b00, $0700, FACE_DOWN, $33, $01, $03
	map_actor $0000, ActorScript_27_5557, $0b00, $1700, FACE_UP, $32, $01, $07
	map_actor $0000, ActorScript_27_5557, $0e00, $1700, FACE_UP, $34, $01, $05
	map_actor $0000, ActorScript_27_785d, $1300, $0b00, FACE_LEFT, $68, $01, $00
	map_actor $0000, ActorScript_27_785d, $1300, $1500, FACE_LEFT, $67, $01, $06
	map_actor_end
ActorScript_27_5557:
	; $5557, 7 bytes (actor_script)
	as_anim $08
	as_wait $3c
	as_jump ActorScript_27_5557
ActorScript_27_555e:
	; $555e, 146 bytes (actor_script)
	as_set_field $18, $0006
	as_anim $06
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	as_halt
	INCBIN "data/bank_027/d_5570.bin" ; $5570, 128 bytes (unclassified tail)
End10VarsityCourtMapScripts_27:
	; $55f0, 14 bytes (map_tree)
	dw End10VarsityCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End10VarsityCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End10VarsityCourtActors_27 ; slot 2 Actors
	dw End10VarsityCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End10VarsityCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End10VarsityCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End10VarsityCourtInitScript_27 ; slot 6 InitScript
End10VarsityCourtActors_27:
	; $55fe, 10 bytes (map_actors)
	map_actor_end
End10VarsityCourtEntryPoints_27:
	; $5608, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0f00, $1f00, $0000
	db $ff
End10VarsityCourtExitTriggers_27:
	; $5611, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, $0000, $25, $01
	db $ff
End10VarsityCourtNpcScripts_27:
	ds 1, $ff ; $561a, fill
End10VarsityCourtFacingScripts_27:
	ds 1, $ff ; $561b, fill
End10VarsityCourtTileTriggers_27:
	ds 1, $ff ; $561c, fill
End10VarsityCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $561d
	cp a, $01 ; $5620
	jp z, Label_27_5643 ; $5622
	ret ; $5625
Func_27_5626:
	ld a, [$c94d] ; $5626
	or a, a ; $5629
	jr nz, Label_27_5642 ; $562a
	script_set_objdef $28, $0d ; $562c
	script_set_anim $0d, $01 ; $5638
	set_flag $1c, 0 ; $563f
Label_27_5642:
	ret ; $5642
Label_27_5643:
	test_flag $05, 7 ; $5643
	jr z, Label_27_564b ; $5646
	jp Label_27_582c ; $5648
Label_27_564b:
	wram_bank $06 ; $564b
	ldh a, [hRomBank] ; $5651
	ld hl, End10VarsityCourtActorsAlt_27 ; $5653
	farcall FarPtr_ScriptRespawnLocationActors ; $5656
	script_null_script $01 ; $5659
	script_player_speed $00f0 ; $565e
	call Func_27_5626 ; $5664
	script_set_position $00, $0b00, $1d00 ; $5667
	script_set_position $02, $0d00, $2300 ; $5672
	script_face $00, $c0 ; $567d
	script_face $02, $c0 ; $5684
	script_move_player $0b00, $1100 ; $568b
	farcall FarPtr_WaitPlayerMoveDone ; $5695
	script_fade_in $04 ; $5698
	script_player_speed $0020 ; $569d
	script_move_player $0b00, $1700 ; $56a3
	farcall FarPtr_WaitPlayerMoveDone ; $56ad
	script_move_target $04, $0b00, $1700 ; $56b0
	script_wait_move $04 ; $56bb
	sound $98 ; $56c0
	script_set_position $0c, $0c40, $1bc0 ; $56c2
	script_wait_frames $28 ; $56cd
	script_set_position $0c, $3f00, $3f00 ; $56d4
	script_face $00, $00 ; $56df
	script_move_player_to_actor $0d ; $56e6
	script_set_actor_script $08, ActorScript_27_5c30 ; $56ed
	script_set_actor_script $09, ActorScript_27_5c94 ; $56f8
	script_set_actor_script $0d, ActorScript_27_5c8d ; $5703
	script_wait_frames $0a ; $570e
	script_set_actor_script $03, ActorScript_27_5c6a ; $5715
	script_wait_frames $1e ; $5720
	script_move_player_to_actor $00 ; $5727
	farcall FarPtr_WaitPlayerMoveDone ; $572e
	script_wait_actor_script $03 ; $5731
	script_face_toward $00, $0d ; $5736
	test_flag $1c, 0 ; $573e
	jr z, Label_27_5759 ; $5741
	script_set_anim $0d, $02 ; $5743
	script_wait_idle $0d ; $574a
	script_face_toward $0d, $00 ; $574f
	jr Label_27_576d ; $5757
Label_27_5759:
	script_set_anim $0d, $02 ; $5759
	script_wait_idle $0d ; $5760
	script_face_toward $0d, $00 ; $5765
Label_27_576d:
	script_set_anim $09, $04 ; $576d
	script_wait_idle $09 ; $5774
	script_face_toward $09, $00 ; $5779
	script_set_anim $00, $02 ; $5781
	script_wait_idle $00 ; $5788
	script_wait_frames $14 ; $578d
	script_move_target $08, $0a00, $1f00 ; $5794
	script_wait_move $08 ; $579f
	script_wait_frames $14 ; $57a4
	script_face_toward $08, $00 ; $57ab
	script_face_toward $08, $0d ; $57b3
	script_wait_frames $14 ; $57bb
	script_wait_frames $14 ; $57c2
	script_move_target $03, $0c00, $1f00 ; $57c9
	script_wait_move $03 ; $57d4
	script_wait_frames $14 ; $57d9
	script_set_anim $03, $02 ; $57e0
	script_wait_idle $03 ; $57e7
	script_set_anim $0d, $02 ; $57ec
	script_wait_idle $0d ; $57f3
	script_face_toward $00, $0d ; $57f8
	test_flag $1c, 0 ; $5800
	jr z, Label_27_5805 ; $5803
Label_27_5805:
	script_face_toward $0d, $00 ; $5805
	script_wait_frames $0a ; $580d
	script_face_toward $08, $00 ; $5814
	script_wait_frames $0a ; $581c
	ld a, $01 ; $5823
	ld [$c294], a ; $5825
	ld [wStoryModeExitLocationRequest], a ; $5828
	ret ; $582b
Label_27_582c:
	ldh a, [hRomBank] ; $582c
	ld hl, End10VarsityCourtActorsAltB_27 ; $582e
	farcall FarPtr_ScriptRespawnLocationActors ; $5831
	farcall FarPtr_BeginCutsceneScriptMode ; $5834
	call Func_27_5626 ; $5837
	script_null_script $02 ; $583a
	script_null_script $01 ; $583f
	script_player_speed $00f0 ; $5844
	script_set_position $00, $0b00, $1d00 ; $584a
	ld a, $02 ; $5855
	ld bc, $0d00 ; $5857
	ld de, $2300 ; $585a
SceneSharedData_27:
	farcall FarPtr_ScriptSetActorPosition ; $585d
	script_face $00, $c0 ; $5860
	script_face $02, $c0 ; $5867
	script_move_player $0b00, $1100 ; $586e
	farcall FarPtr_WaitPlayerMoveDone ; $5878
	script_fade_in $04 ; $587b
	script_player_speed $0020 ; $5880
	script_move_player $0b00, $1700 ; $5886
	farcall FarPtr_WaitPlayerMoveDone ; $5890
	script_move_target $02, $0d00, $1d00 ; $5893
	script_move_target $09, $0b00, $1700 ; $589e
	script_wait_move $09 ; $58a9
	script_set_anim $09, $04 ; $58ae
	script_wait_idle $09 ; $58b5
	script_set_anim $04, $02 ; $58ba
	script_wait_idle $04 ; $58c1
	script_set_anim $02, $03 ; $58c6
	script_set_anim $00, $03 ; $58cd
	script_wait_idle $00 ; $58d4
	script_face_toward $00, $02 ; $58d9
	script_wait_frames $1e ; $58e1
	script_set_anim $02, $03 ; $58e8
	script_wait_idle $02 ; $58ef
	test_flag $1c, 0 ; $58f4
	jp z, Label_27_5a25 ; $58f7
	script_face_toward $02, $00 ; $58fa
	script_set_anim $02, $02 ; $5902
	script_wait_idle $02 ; $5909
	script_face $00, $80 ; $590e
	script_set_anim $00, $02 ; $5915
	sound $96 ; $591c
	script_set_position $0a, $0c00, $1b80 ; $591e
	script_wait_frames $28 ; $5929
	script_set_position $0a, $3f00, $3f00 ; $5930
	script_face_toward $02, $00 ; $593b
	script_wait_frames $0a ; $5943
	script_facing_lock $00, $01 ; $594a
	script_wait_frames $0a ; $5951
	script_move_angle $00, $00, $0100 ; $5958
	script_wait_move $00 ; $5962
	script_set_anim $00, $02 ; $5967
	script_wait_idle $00 ; $596e
	script_move_angle $00, $80, $0100 ; $5973
	script_wait_move $00 ; $597d
	script_get_actor_state $02 ; $5982
	ld de, $0018 ; $5987
	add hl, de ; $598a
	ld [hl], $04 ; $598b
	script_set_anim $02, $02 ; $598d
	script_wait_idle $02 ; $5994
	script_face $02, $c0 ; $5999
	script_set_anim $02, $02 ; $59a0
	script_wait_idle $02 ; $59a7
	script_set_anim $02, $02 ; $59ac
	script_wait_idle $02 ; $59b3
	script_face $02, $40 ; $59b8
	script_set_anim $02, $02 ; $59bf
	script_wait_idle $02 ; $59c6
	script_face $02, $c0 ; $59cb
	script_set_anim $02, $02 ; $59d2
	script_wait_idle $02 ; $59d9
	script_set_anim $02, $02 ; $59de
	script_wait_idle $02 ; $59e5
	script_get_actor_state $02 ; $59ea
	ld de, $0018 ; $59ef
	add hl, de ; $59f2
	ld [hl], $01 ; $59f3
	script_face $02, $80 ; $59f5
	script_wait_frames $14 ; $59fc
	script_set_anim $02, $03 ; $5a03
	script_wait_idle $02 ; $5a0a
	script_wait_frames $14 ; $5a0f
	script_set_anim $00, $03 ; $5a16
	script_wait_idle $00 ; $5a1d
	jp Label_27_5b0c ; $5a22
Label_27_5a25:
	script_set_anim $02, $02 ; $5a25
	script_wait_idle $02 ; $5a2c
	script_face_toward $02, $00 ; $5a31
	sound $96 ; $5a39
	script_set_position $0a, $0c00, $1b80 ; $5a3b
	script_wait_frames $28 ; $5a46
	script_set_position $0a, $3f00, $3f00 ; $5a4d
	script_wait_frames $0a ; $5a58
	script_facing_lock $00, $01 ; $5a5f
	script_wait_frames $0a ; $5a66
	script_move_angle $00, $00, $0100 ; $5a6d
	script_wait_move $00 ; $5a77
	script_set_anim $00, $02 ; $5a7c
	script_wait_idle $00 ; $5a83
	script_move_angle $00, $80, $0100 ; $5a88
	script_wait_move $00 ; $5a92
	script_get_actor_state $02 ; $5a97
	ld de, $0018 ; $5a9c
	add hl, de ; $5a9f
	ld [hl], $03 ; $5aa0
	script_set_anim $02, $02 ; $5aa2
	script_wait_idle $02 ; $5aa9
	script_face $02, $40 ; $5aae
	script_set_anim $02, $02 ; $5ab5
	script_wait_idle $02 ; $5abc
	script_wait_frames $28 ; $5ac1
	script_set_anim $02, $02 ; $5ac8
	script_wait_idle $02 ; $5acf
	script_get_actor_state $02 ; $5ad4
	ld de, $0018 ; $5ad9
	add hl, de ; $5adc
	ld [hl], $01 ; $5add
	script_face $02, $80 ; $5adf
	script_wait_frames $14 ; $5ae6
	script_set_anim $02, $03 ; $5aed
	script_wait_idle $02 ; $5af4
	script_wait_frames $14 ; $5af9
	script_set_anim $00, $03 ; $5b00
	script_wait_idle $00 ; $5b07
Label_27_5b0c:
	script_wait_frames $14 ; $5b0c
	script_facing_lock $00, $00 ; $5b13
	script_face $00, $00 ; $5b1a
	script_face $02, $00 ; $5b21
	script_set_actor_script $08, ActorScript_27_5c30 ; $5b28
	script_set_actor_script $03, ActorScript_27_5c4d ; $5b33
	script_wait_frames $14 ; $5b3e
	script_set_actor_script $09, ActorScript_27_5cb6 ; $5b45
	script_move_player $0b00, $1d00 ; $5b50
	farcall FarPtr_WaitPlayerMoveDone ; $5b5a
	script_wait_actor_script $09 ; $5b5d
	script_face_toward $00, $09 ; $5b62
	script_face_toward $03, $02 ; $5b6a
	script_set_anim $09, $04 ; $5b72
	script_wait_idle $09 ; $5b79
	script_face_toward $09, $00 ; $5b7e
	script_move_target $08, $0a00, $1f00 ; $5b86
	script_wait_move $08 ; $5b91
	script_face_toward $08, $00 ; $5b96
	script_face_toward $03, $02 ; $5b9e
	script_set_anim $08, $03 ; $5ba6
	script_wait_idle $08 ; $5bad
	script_move_target $03, $0c00, $1f00 ; $5bb2
	script_wait_move $03 ; $5bbd
	script_set_anim $03, $02 ; $5bc2
	script_wait_idle $03 ; $5bc9
	script_face_toward $00, $02 ; $5bce
	script_set_anim $02, $03 ; $5bd6
	script_wait_idle $02 ; $5bdd
	test_flag $1c, 0 ; $5be2
	jr z, Label_27_5be7 ; $5be5
Label_27_5be7:
	script_face_toward $02, $00 ; $5be7
	script_set_anim $00, $03 ; $5bef
	script_wait_idle $00 ; $5bf6
	script_wait_frames $0a ; $5bfb
	script_face_toward $08, $00 ; $5c02
	script_face_toward $03, $02 ; $5c0a
	script_wait_frames $0a ; $5c12
	script_set_anim $00, $03 ; $5c19
	script_set_anim $02, $03 ; $5c20
	ld a, $01 ; $5c27
	ld [$c294], a ; $5c29
	ld [wStoryModeExitLocationRequest], a ; $5c2c
	ret ; $5c2f
ActorScript_27_5c30:
	; $5c30, 29 bytes (actor_script)
	as_set_pos $1100, $1d00
	as_wait_move
	as_set_pos $1100, $2300
	as_wait_move
	as_set_pos $0a00, $2300
	as_wait_move
	as_set_pos $0a00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_27_5c4d:
	; $5c4d, 29 bytes (actor_script)
	as_set_pos $1100, $1d00
	as_wait_move
	as_set_pos $1100, $2300
	as_wait_move
	as_set_pos $0c00, $2300
	as_wait_move
	as_set_pos $0c00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_27_5c6a:
	; $5c6a, 35 bytes (actor_script)
	as_set_pos $1900, $1d00
	as_wait_move
	as_set_pos $1100, $1d00
	as_wait_move
	as_set_pos $1100, $2300
	as_wait_move
	as_set_pos $0c00, $2300
	as_wait_move
	as_set_pos $0c00, $2100
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_27_5c8d:
	; $5c8d, 7 bytes (actor_script)
	as_set_pos $0d00, $1d00
	as_wait_move
	as_halt
ActorScript_27_5c94:
	; $5c94, 34 bytes (actor_script)
	as_set_pos $1100, $1d00
	as_wait_move
	as_set_pos $1100, $2300
	as_wait_move
	as_set_pos $0700, $2300
	as_wait_move
	as_set_pos $0700, $1d00
	as_set_pos $0900, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_27_5cb6:
	; $5cb6, 23 bytes (actor_script)
	as_set_pos $0700, $1700
	as_wait_move
	as_set_pos $0700, $1d00
	as_wait_move
	as_set_pos $0900, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
End10VarsityCourtActorsAlt_27:
	; $5ccd, 164 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1900, $1f00, FACE_LEFT, $4b, $01, $00
	map_actor $0000, ActorScript_27_785d, $0b00, $1300, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_27_785d, $1300, $2100, FACE_LEFT, $65, $01, $03
	map_actor $0000, ActorScript_27_785d, $1300, $2300, FACE_LEFT, $67, $01, $06
	map_actor $0000, ActorScript_27_785d, $1300, $1700, FACE_LEFT, $6b, $01, $06
	map_actor $0000, ActorScript_27_785d, $1b00, $1d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $1d00, FACE_LEFT, $4a, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $53, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $4d, $01, $00
	map_actor $0000, ActorScript_27_785d, $1700, $1d00, FACE_LEFT, $29, $01, $00
	map_actor_end
End10VarsityCourtActorsAltB_27:
	; $5d71, 164 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1900, $1d00, FACE_LEFT, $4b, $01, $00
	map_actor $0000, ActorScript_27_785d, $0d00, $1700, FACE_DOWN, $68, $01, $07
	map_actor $0000, ActorScript_27_785d, $1300, $2100, FACE_LEFT, $65, $01, $03
	map_actor $0000, ActorScript_27_785d, $1300, $2300, FACE_LEFT, $67, $01, $06
	map_actor $0000, ActorScript_27_785d, $1300, $1700, FACE_LEFT, $6b, $01, $06
	map_actor $0000, ActorScript_27_785d, $1700, $1d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $0b00, $1300, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $53, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $3d00, $3d00, FACE_LEFT, $4c, $01, $00
	map_actor_end
End8SrCourtMapScripts_27:
	; $5e15, 14 bytes (map_tree)
	dw End8SrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End8SrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End8SrCourtActors_27 ; slot 2 Actors
	dw End8SrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End8SrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End8SrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End8SrCourtInitScript_27 ; slot 6 InitScript
End8SrCourtActors_27:
	; $5e23, 94 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2b00, $2700, FACE_UP, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $2200, $0f00, FACE_DOWN, $65, $01, $07
	map_actor $0000, ActorScript_27_785d, $2d00, $1300, FACE_RIGHT, $69, $01, $04
	map_actor $0000, ActorScript_27_785d, $1b00, $0d00, FACE_LEFT, $66, $01, $06
	map_actor $0000, ActorScript_27_785d, $2900, $1300, FACE_LEFT, $54, $01, $05
	map_actor $0000, ActorScript_27_785d, $2900, $1900, FACE_LEFT, $54, $01, $00
	map_actor_end
End8SrCourtActorsAlt_27:
	; $5e81, 66 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2b00, $2700, FACE_UP, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $2500, $0f00, FACE_DOWN, $65, $01, $07
	map_actor $0000, ActorScript_27_785d, $2300, $1300, FACE_DOWN, $64, $01, $05
	map_actor $0000, ActorScript_27_785d, $1b00, $0d00, FACE_LEFT, $6b, $01, $05
	map_actor_end
End8SrCourtEntryPoints_27:
	; $5ec3, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $2400, $1500, $0000
	db $ff
End8SrCourtExitTriggers_27:
	; $5ecc, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $24, $01
	db $ff
End8SrCourtNpcScripts_27:
	ds 1, $ff ; $5ed5, fill
End8SrCourtFacingScripts_27:
	ds 1, $ff ; $5ed6, fill
End8SrCourtTileTriggers_27:
	ds 1, $ff ; $5ed7, fill
End8SrCourtInitScript_27:
	test_flag $05, 7 ; $5ed8
	jp z, Label_27_6075 ; $5edb
	ldh a, [hRomBank] ; $5ede
	ld hl, End8SrCourtActorsAlt_27 ; $5ee0
	farcall FarPtr_ScriptRespawnLocationActors ; $5ee3
	farcall FarPtr_BeginCutsceneScriptMode ; $5ee6
	jr Label_27_5eec ; $5ee9
	ret ; $5eeb
Label_27_5eec:
	script_null_script $02 ; $5eec
	script_set_position $00, $2500, $1b00 ; $5ef1
	script_face $00, $c0 ; $5efc
	script_set_position $02, $2300, $1b00 ; $5f03
	script_face $02, $c0 ; $5f0e
	script_face $03, $80 ; $5f15
	xor a, a ; $5f1c
	ld [wStoryModeShowLocationName], a ; $5f1d
	script_fade_in $04 ; $5f20
	script_move_target $04, $2500, $1300 ; $5f25
	script_wait_move $04 ; $5f30
	script_face_pair $05, $04 ; $5f35
	script_set_anim $04, $02 ; $5f3d
	script_delay $32 ; $5f44
	script_face $05, $40 ; $5f49
	script_set_anim $05, $04 ; $5f50
	script_wait_idle $05 ; $5f57
	script_delay $32 ; $5f5c
	script_set_anim $04, $02 ; $5f61
	script_set_anim $05, $02 ; $5f68
	script_set_anim $02, $02 ; $5f6f
	script_set_anim $00, $02 ; $5f76
	script_face $00, $40 ; $5f7d
	script_face $02, $40 ; $5f84
	script_face $04, $40 ; $5f8b
	script_delay $1e ; $5f92
	script_player_speed $0030 ; $5f97
	script_set_speed $03, $0010 ; $5f9d
	script_move_player $2b00, $1f00 ; $5fa5
	script_move_target $03, $2b00, $2000 ; $5faf
	script_delay $5a ; $5fba
	script_player_speed $0010 ; $5fbf
	script_move_player $2400, $1b00 ; $5fc5
	script_move_target $03, $2500, $1f00 ; $5fcf
	script_wait_move $03 ; $5fda
	script_face $03, $c0 ; $5fdf
	script_set_anim $03, $02 ; $5fe6
	script_wait_idle $03 ; $5fed
	script_delay $14 ; $5ff2
	script_face_pair $02, $00 ; $5ff7
	script_delay $28 ; $5fff
	script_face $00, $40 ; $6004
	script_face $02, $40 ; $600b
	script_set_anim $02, $03 ; $6012
	script_set_anim $00, $03 ; $6019
	script_wait_idle $00 ; $6020
	script_set_anim $03, $03 ; $6025
	script_wait_idle $03 ; $602c
	script_delay $14 ; $6031
	script_move_target $03, $2500, $1d00 ; $6036
	script_wait_move $03 ; $6041
	script_set_anim $03, $02 ; $6046
	script_wait_idle $03 ; $604d
	script_wait_frames $1e ; $6052
	script_set_anim $03, $03 ; $6059
	script_set_anim $00, $03 ; $6060
	script_wait_idle $00 ; $6067
	ld a, $01 ; $606c
	ld [$c294], a ; $606e
	ld [wStoryModeExitLocationRequest], a ; $6071
	ret ; $6074
Label_27_6075:
	script_set_speed $04, $0018 ; $6075
	script_set_position $00, $2400, $1b00 ; $607d
	script_face $00, $c0 ; $6088
	xor a, a ; $608f
	ld [wStoryModeShowLocationName], a ; $6090
	script_fade_in $04 ; $6093
	script_move_target $04, $2400, $1300 ; $6098
	script_wait_move $04 ; $60a3
	script_delay $14 ; $60a8
	script_delay $28 ; $60ad
	script_set_anim $04, $02 ; $60b2
	script_set_anim $00, $02 ; $60b9
	script_wait_idle $00 ; $60c0
	script_face $00, $40 ; $60c5
	script_delay $1e ; $60cc
	script_player_speed $0030 ; $60d1
	script_set_speed $03, $0010 ; $60d7
	script_move_player $2b00, $1f00 ; $60df
	script_move_target $03, $2b00, $1f00 ; $60e9
	script_delay $5a ; $60f4
	script_player_speed $0010 ; $60f9
	script_move_player $2400, $1b00 ; $60ff
	script_wait_move $03 ; $6109
	script_move_target $03, $2400, $1f00 ; $610e
	script_wait_move $03 ; $6119
	script_move_target $03, $2400, $1e00 ; $611e
	script_wait_move $03 ; $6129
	script_move_target $03, $2400, $1d00 ; $612e
	script_wait_move $03 ; $6139
	script_delay $1e ; $613e
	script_set_anim $03, $02 ; $6143
	script_wait_idle $03 ; $614a
	script_delay $1e ; $614f
	script_set_anim $00, $03 ; $6154
	script_wait_idle $00 ; $615b
	script_delay $14 ; $6160
	script_set_anim $03, $03 ; $6165
	script_wait_idle $03 ; $616c
	script_delay $28 ; $6171
	ld a, $01 ; $6176
	ld [$c294], a ; $6178
	ld [wStoryModeExitLocationRequest], a ; $617b
	ret ; $617e
End7TrainingCtrMapScripts_27:
	; $617f, 14 bytes (map_tree)
	dw End7TrainingCtrEntryPoints_27 ; slot 0 EntryPoints
	dw End7TrainingCtrExitTriggers_27 ; slot 1 ExitTriggers
	dw End7TrainingCtrActors_27 ; slot 2 Actors
	dw End7TrainingCtrNpcScripts_27 ; slot 3 NpcScripts
	dw End7TrainingCtrFacingScripts_27 ; slot 4 FacingScripts
	dw End7TrainingCtrTileTriggers_27 ; slot 5 TileTriggers
	dw End7TrainingCtrInitScript_27 ; slot 6 InitScript
End7TrainingCtrActors_27:
	; $618d, 80 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $2b00, $3300, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_27_785d, $2b00, $3100, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_27_785d, $2d00, $2b00, FACE_LEFT, $3e, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $1100, FACE_UP, $39, $01, $06
	map_actor $0000, ActorScript_27_785d, $0d00, $1300, FACE_RIGHT, $39, $01, $07
	map_actor_end
End7TrainingCtrEntryPoints_27:
	; $61dd, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $3900, $0000
	map_entry $02, FACE_UP, $1600, $1800, $0000
	db $ff
End7TrainingCtrExitTriggers_27:
	; $61ee, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $11, $03
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_27, $11, $03
	db $ff
End7TrainingCtrNpcScripts_27:
	ds 1, $ff ; $61ff, fill
End7TrainingCtrFacingScripts_27:
	ds 1, $ff ; $6200, fill
End7TrainingCtrTileTriggers_27:
	ds 1, $ff ; $6201, fill
End7TrainingCtrInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6202
	cp a, $01 ; $6205
	jr z, Label_27_6270 ; $6207
	cp a, $02 ; $6209
	jp z, Label_27_6370 ; $620b
	ret ; $620e
Func_27_620f:
	ld a, $00 ; $620f
	test_flag $1a, 2 ; $6211
	jp z, Label_27_626c ; $6214
	script_copy_scene_rect $1e, $2c, $30, $2c, $02, $02 ; $6217
	ld a, $01 ; $6226
	test_flag $1a, 3 ; $6228
	jp z, Label_27_626c ; $622b
	script_copy_scene_rect $1e, $30, $30, $30, $02, $02 ; $622e
	ld a, $02 ; $623d
	test_flag $1a, 4 ; $623f
	jr z, Label_27_626c ; $6242
	script_copy_scene_rect $1e, $34, $30, $34, $02, $02 ; $6244
	ld a, $03 ; $6253
	test_flag $1a, 5 ; $6255
	jr z, Label_27_626c ; $6258
	script_copy_scene_rect $1e, $38, $30, $38, $02, $02 ; $625a
	ld a, $04 ; $6269
	ld b, a ; $626b
Label_27_626c:
	ld [$c2b0], a ; $626c
	ret ; $626f
Label_27_6270:
	ld a, $26 ; $6270
	ld [$c329], a ; $6272
	ld a, $23 ; $6275
	ld [$c32a], a ; $6277
	ld a, $40 ; $627a
	ld [$c32b], a ; $627c
	ld a, $3c ; $627f
	ld [$c32c], a ; $6281
	call DisableLCDSafely ; $6284
	ld a, $00 ; $6287
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $6289
	call EnableLCD ; $628c
	call Func_27_620f ; $628f
	farcall FarPtr_WaitPlayerMoveDone ; $6292
	script_set_position $00, $2900, $3700 ; $6295
	script_set_position $02, $2900, $3700 ; $62a0
	script_fade_in $04 ; $62ab
	script_move_player $2900, $2b00 ; $62b0
	script_move_target $00, $2900, $2b00 ; $62ba
	script_wait_move $00 ; $62c5
	script_move_target $00, $2b00, $2b00 ; $62ca
	script_wait_move $00 ; $62d5
	script_face $02, $00 ; $62da
	script_face $00, $00 ; $62e1
	script_wait_frames $1e ; $62e8
	script_set_anim $05, $03 ; $62ef
	script_wait_idle $05 ; $62f6
	script_move_target $05, $2d00, $2900 ; $62fb
	script_wait_move $05 ; $6306
	script_face $05, $40 ; $630b
	script_null_script $02 ; $6312
	script_set_speed $00, $0020 ; $6317
	script_move_player $3800, $3300 ; $631f
	script_move_target $00, $3300, $2b00 ; $6329
	script_wait_move $00 ; $6334
	script_move_target $00, $3300, $3300 ; $6339
	script_wait_move $00 ; $6344
	script_move_target $00, $3800, $3500 ; $6349
	script_wait_move $00 ; $6354
	script_face $00, $c0 ; $6359
	script_wait_frames $0a ; $6360
	ld a, $01 ; $6367
	ld [$c294], a ; $6369
	ld [wStoryModeExitLocationRequest], a ; $636c
	ret ; $636f
Label_27_6370:
	script_set_position $02, $1600, $1a00 ; $6370
	script_set_speed $02, $0010 ; $637b
	script_set_speed $00, $0010 ; $6383
	script_player_speed $0018 ; $638b
	script_fade_in $04 ; $6391
	script_move_angle $00, $c0, $0400 ; $6396
	script_wait_move $00 ; $63a0
	script_move_player $0f00, $1300 ; $63a5
	script_move_target $00, $1100, $1300 ; $63af
	script_wait_move $00 ; $63ba
	script_face_toward $00, $07 ; $63bf
	script_wait_frames $14 ; $63c7
	script_set_anim $00, $02 ; $63ce
	script_wait_idle $00 ; $63d5
	script_set_anim $07, $03 ; $63da
	script_wait_idle $07 ; $63e1
	script_face $00, $40 ; $63e6
	script_set_actor_script $00, ActorScript_27_6424 ; $63ed
	script_wait_frames $78 ; $63f8
	script_null_script $00 ; $63ff
	script_set_anim $00, $01 ; $6404
	script_set_speed $00, $0020 ; $640b
	script_face_toward $07, $00 ; $6413
	ld a, $01 ; $641b
	ld [$c294], a ; $641d
	ld [wStoryModeExitLocationRequest], a ; $6420
	ret ; $6423
ActorScript_27_6424:
	; $6424, 35 bytes (actor_script)
	as_anim $0b
	as_set_field $14, FACE_RIGHT
	as_wait $32
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
	as_anim $0b
	as_set_field $14, FACE_LEFT
	as_wait $32
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
	as_jump ActorScript_27_6424
End5ServiceAceMapScripts_27:
	; $6447, 14 bytes (map_tree)
	dw End5ServiceAceEntryPoints_27 ; slot 0 EntryPoints
	dw End5ServiceAceExitTriggers_27 ; slot 1 ExitTriggers
	dw End5ServiceAceActors_27 ; slot 2 Actors
	dw End5ServiceAceNpcScripts_27 ; slot 3 NpcScripts
	dw End5ServiceAceFacingScripts_27 ; slot 4 FacingScripts
	dw End5ServiceAceTileTriggers_27 ; slot 5 TileTriggers
	dw End5ServiceAceInitScript_27 ; slot 6 InitScript
End5ServiceAceActors_27:
	; $6455, 248 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1100, $1900, FACE_LEFT, $2f, $01, $00
	map_actor $0000, ActorScript_27_785d, $2100, $1500, FACE_UP, $2f, $01, $07
	map_actor $0000, ActorScript_27_785d, $1600, $1300, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $1700, FACE_UP, $31, $01, $00
	map_actor $0000, ActorScript_27_785d, $2900, $2900, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $2100, $1100, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_27_785d, $0900, $0f00, FACE_RIGHT, $34, $01, $00
	map_actor $0000, ActorScript_27_7867, $0b00, $1900, FACE_LEFT, $30, $01, $06
	map_actor $0000, ActorScript_27_785d, $0d00, $0f00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $0b00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $0b00, FACE_LEFT, $3c, $01, $04
	map_actor $0000, ActorScript_27_785d, $1b00, $0900, FACE_DOWN, $3b, $01, $00
	map_actor $0000, ActorScript_27_785d, $1d00, $0f00, FACE_LEFT, $3c, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $0f00, FACE_RIGHT, $3b, $01, $06
	map_actor $0000, ActorScript_27_785d, $2900, $2900, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_27_785d, $1b00, $1200, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $0900, FACE_DOWN, $35, $01, $00
	map_actor_end
End5ServiceAceEntryPoints_27:
	; $654d, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, $0d00, $1d00, $0000
	map_entry $02, FACE_DOWN, $0500, $1700, $0000
	db $ff
End5ServiceAceExitTriggers_27:
	; $655e, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $22, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, $0e, $01
	db $ff
Func_27_656f:
	farcall FarPtr_BeginCutsceneScriptMode ; $656f
	script_player_speed $0010 ; $6572
	script_move_player $0f00, $1100 ; $6578
	script_fade_in $08 ; $6582
	script_set_speed $00, $0018 ; $6587
	script_move_target $00, $0d00, $1700 ; $658f
	script_wait_move $00 ; $659a
	script_move_target $00, $0f00, $1700 ; $659f
	script_wait_move $00 ; $65aa
	script_move_target $00, $0f00, $1100 ; $65af
	script_wait_move $00 ; $65ba
	script_player_speed $0018 ; $65bf
	script_move_player $1900, $1100 ; $65c5
	script_move_target $00, $1900, $1100 ; $65cf
	script_wait_move $00 ; $65da
	script_wait_frames $14 ; $65df
	script_face $12, $80 ; $65e6
	script_wait_frames $28 ; $65ed
	sound $97 ; $65f4
	script_set_position $07, $1c00, $1100 ; $65f6
	script_set_anim $12, $02 ; $6601
	script_wait_frames $3c ; $6608
	ld a, $01 ; $660f
	ld [$c294], a ; $6611
	ld [wStoryModeExitLocationRequest], a ; $6614
	farcall FarPtr_EndCutsceneScriptMode ; $6617
	ret ; $661a
End5ServiceAceNpcScripts_27:
	ds 1, $ff ; $661b, fill
End5ServiceAceFacingScripts_27:
	ds 1, $ff ; $661c, fill
End5ServiceAceTileTriggers_27:
	ds 1, $ff ; $661d, fill
End5ServiceAceInitScript_27:
	call Func_27_656f ; $661e
	ret ; $6621
End4JrCourtMapScripts_27:
	; $6622, 14 bytes (map_tree)
	dw End4JrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End4JrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End4JrCourtActors_27 ; slot 2 Actors
	dw End4JrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End4JrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End4JrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End4JrCourtInitScript_27 ; slot 6 InitScript
End4JrCourtActors_27:
	; $6630, 234 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_27_785d, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_27_785d, $1300, $0d00, FACE_RIGHT, $67, $01, $07
	map_actor $0000, ActorScript_27_785d, $1f00, $1500, FACE_LEFT, $6a, $01, $07
	map_actor $0000, ActorScript_27_785d, $2500, $0900, FACE_RIGHT, $66, $01, $03
	map_actor $0000, ActorScript_27_785d, $3100, $1500, FACE_RIGHT, $65, $01, $06
	map_actor $0000, ActorScript_27_785d, $3d00, $1900, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_27_682f, $3100, $0700, FACE_DOWN, $69, $01, $03
	map_actor $0000, ActorScript_27_795d, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_79c4, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_7893, $1800, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_27_78f6, $1c00, $1700, FACE_UP, $54, $01, $05
	map_actor $0000, ActorScript_27_795d, $3400, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_79c4, $3800, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_785d, $4000, $4000, FACE_UP, $53, $01, $00
	map_actor_end
End4JrCourtActorsAlt_27:
	; $671a, 192 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_27_785d, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_27_785d, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_27_785d, $2100, $1500, FACE_DOWN, $67, $01, $07
	map_actor $0000, ActorScript_27_785d, $0500, $1300, FACE_RIGHT, $6a, $01, $07
	map_actor $0000, ActorScript_27_785d, $1b00, $1300, FACE_DOWN, $66, $01, $03
	map_actor $0000, ActorScript_27_785d, $1b00, $1500, FACE_UP, $65, $01, $06
	map_actor $0000, ActorScript_27_785d, $3700, $0700, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_27_785d, $3500, $0700, FACE_RIGHT, $69, $01, $03
	map_actor $0000, ActorScript_27_795d, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_79c4, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_7893, $2a00, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_27_78f6, $2e00, $1700, FACE_UP, $54, $01, $05
	map_actor_end
End4JrCourtEntryPoints_27:
	; $67da, 10 bytes (map_entries)
	map_entry $01, FACE_UP, $1300, $2100, $0000
	db $ff, $c9
End4JrCourtExitTriggers_27:
	; $67e4, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $08, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, $0b, $0f
	db $ff
End4JrCourtNpcScripts_27:
	ds 1, $ff ; $67f5, fill
End4JrCourtFacingScripts_27:
	ds 1, $ff ; $67f6, fill
End4JrCourtTileTriggers_27:
	ds 1, $ff ; $67f7, fill
End4JrCourtInitScript_27:
	test_flag $05, 7 ; $67f8
	jr z, Label_27_6808 ; $67fb
	ldh a, [hRomBank] ; $67fd
	ld hl, End4JrCourtActorsAlt_27 ; $67ff
	farcall FarPtr_ScriptRespawnLocationActors ; $6802
	farcall FarPtr_BeginCutsceneScriptMode ; $6805
Label_27_6808:
	ld a, [wStoryModeEntryPoint] ; $6808
	cp a, $01 ; $680b
	jp z, Label_27_6a54 ; $680d
	ret ; $6810
ActorScript_27_6811:
	; $6811, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_pos $1f00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_6820:
	; $6820, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_pos $1f00, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_682f:
	; $682f, 55 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0008
.L8:
	as_set_pos $2d00, $0700
	as_wait_move2
	as_set_field $14, FACE_DOWN
	as_wait $c8
	as_wait $f0
	as_set_pos $3300, $0700
	as_wait_move2
	as_wait $3c
	as_set_pos $2d00, $0700
	as_wait_move2
	as_wait $3c
	as_set_pos $3300, $0700
	as_wait_move2
	as_set_field $14, FACE_DOWN
	as_wait $f0
	as_wait $f0
	as_jump .L8
Func_27_6866:
	script_wait_frames $0f ; $6866
	script_face_toward $07, $03 ; $686d
	script_wait_frames $0a ; $6875
	script_face_toward $07, $00 ; $687c
	script_wait_frames $1e ; $6884
	script_player_speed $0020 ; $688b
	script_move_player_to_actor $07 ; $6891
	farcall FarPtr_WaitPlayerMoveDone ; $6898
	script_face_toward $03, $07 ; $689b
	script_set_anim $07, $03 ; $68a3
	script_wait_idle $07 ; $68aa
	script_face $07, $40 ; $68af
	script_wait_frames $0a ; $68b6
	script_set_actor_script $07, ActorScript_27_6918 ; $68bd
	script_wait_frames $14 ; $68c8
	script_move_player_to_actor $00 ; $68cf
	script_face $03, $40 ; $68d6
	script_move_player_to_actor $00 ; $68dd
	script_wait_actor_script $07 ; $68e4
	script_face_toward $00, $07 ; $68e9
	script_set_anim $07, $02 ; $68f1
	script_wait_idle $07 ; $68f8
	script_set_anim $07, $03 ; $68fd
	script_wait_idle $07 ; $6904
	script_wait_frames $0f ; $6909
	script_face $07, $c0 ; $6910
	ret ; $6917
ActorScript_27_6918:
	; $6918, 23 bytes (actor_script)
	as_set_pos $1f00, $1900
	as_wait_move
	as_set_pos $1500, $1900
	as_wait_move
	as_set_pos $1500, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_692f:
	; $692f, 17 bytes (actor_script)
	as_set_pos $1500, $0900
	as_wait_move
	as_set_pos $1900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_6940:
	; $6940, 17 bytes (actor_script)
	as_set_pos $1300, $1900
	as_wait_move
	as_set_pos $1b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
Func_27_6951:
	farcall FarPtr_BeginCutsceneScriptMode ; $6951
	script_face $03, $40 ; $6954
	call Func_27_6866 ; $695b
	script_face $00, $c0 ; $695e
	script_wait_frames $0f ; $6965
	script_set_anim $03, $02 ; $696c
	script_wait_idle $03 ; $6973
	script_face $03, $00 ; $6978
	script_wait_frames $0f ; $697f
	script_face $00, $00 ; $6986
	script_face $07, $00 ; $698d
	script_wait_frames $1e ; $6994
	script_set_actor_script $0e, ActorScript_27_6811 ; $699b
	script_set_actor_script $0f, ActorScript_27_6820 ; $69a6
	script_wait_actor_script $0f ; $69b1
	script_move_player $1700, $1100 ; $69b6
	script_set_actor_script $07, ActorScript_27_692f ; $69c0
	script_set_actor_script $00, ActorScript_27_6940 ; $69cb
	farcall FarPtr_WaitPlayerMoveDone ; $69d6
	script_wait_actor_script $07 ; $69d9
	script_wait_frames $14 ; $69de
	ld a, $01 ; $69e5
	ld [$c294], a ; $69e7
	ld [wStoryModeExitLocationRequest], a ; $69ea
	ret ; $69ed
Label_27_69ee:
	farcall FarPtr_BeginCutsceneScriptMode ; $69ee
	script_face_toward $03, $00 ; $69f1
	script_wait_frames $1e ; $69f9
	script_face_toward $00, $03 ; $6a00
	call Func_27_6a7d ; $6a08
	script_face $00, $c0 ; $6a0b
	script_wait_frames $0f ; $6a12
	script_set_anim $03, $02 ; $6a19
	script_wait_idle $03 ; $6a20
	script_face $03, $00 ; $6a25
	script_wait_frames $0f ; $6a2c
	script_face $00, $00 ; $6a33
	script_face $07, $00 ; $6a3a
	script_wait_frames $1e ; $6a41
	call Func_27_6b21 ; $6a48
	ld a, $01 ; $6a4b
	ld [$c294], a ; $6a4d
	ld [wStoryModeExitLocationRequest], a ; $6a50
	ret ; $6a53
Label_27_6a54:
	script_move_player $1300, $1500 ; $6a54
	script_fade_in $04 ; $6a5e
	script_move_target $00, $1300, $1500 ; $6a63
	script_wait_move $00 ; $6a6e
	test_flag $05, 7 ; $6a73
	jp nz, Label_27_69ee ; $6a76
	call Func_27_6951 ; $6a79
	ret ; $6a7c
Func_27_6a7d:
	script_player_speed $0020 ; $6a7d
	script_face $03, $00 ; $6a83
	script_move_player_to_actor $08 ; $6a8a
	farcall FarPtr_WaitPlayerMoveDone ; $6a91
	script_face $00, $00 ; $6a94
	script_face $02, $00 ; $6a9b
	script_null_script $08 ; $6aa2
	script_face $08, $80 ; $6aa7
	script_set_anim $08, $02 ; $6aae
	script_wait_idle $08 ; $6ab5
	script_move_player_to_actor $00 ; $6aba
	script_move_target $08, $1500, $1500 ; $6ac1
	script_move_target $09, $1500, $1700 ; $6acc
	script_wait_move $09 ; $6ad7
	script_face $09, $80 ; $6adc
	script_face $03, $40 ; $6ae3
	script_set_anim $08, $02 ; $6aea
	script_wait_idle $08 ; $6af1
	script_set_anim $09, $03 ; $6af6
	script_wait_frames $0f ; $6afd
	script_face $00, $c0 ; $6b04
	script_face $02, $c0 ; $6b0b
	script_face $08, $c0 ; $6b12
	script_face $09, $c0 ; $6b19
	ret ; $6b20
Func_27_6b21:
	script_face $03, $00 ; $6b21
	script_wait_frames $1e ; $6b28
	script_null_script $02 ; $6b2f
	script_move_player $1900, $1100 ; $6b34
	script_set_actor_script $08, ActorScript_27_6bf0 ; $6b3e
	script_set_actor_script $09, ActorScript_27_6c04 ; $6b49
	script_move_target $00, $1b00, $1900 ; $6b54
	script_wait_frames $0a ; $6b5f
	script_move_target $02, $1900, $1500 ; $6b66
	script_wait_move $00 ; $6b71
	script_face $00, $c0 ; $6b76
	script_face $02, $c0 ; $6b7d
	script_wait_frames $3c ; $6b84
	ld a, $0f ; $6b8b
	ld [$c294], a ; $6b8d
	ld [wStoryModeExitLocationRequest], a ; $6b90
	ret ; $6b93
	INCBIN "data/bank_027/d_6b94.bin" ; $6b94, 92 bytes
ActorScript_27_6bf0:
	; $6bf0, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_pos $1500, $0900
	as_wait_move
	as_set_pos $1700, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_6c04:
	; $6c04, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_pos $1500, $0e00
	as_wait_move
	as_set_pos $1b00, $0e00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
End3DormEntMapScripts_27:
	; $6c18, 14 bytes (map_tree)
	dw End3DormEntEntryPoints_27 ; slot 0 EntryPoints
	dw End3DormEntExitTriggers_27 ; slot 1 ExitTriggers
	dw End3DormEntActors_27 ; slot 2 Actors
	dw End3DormEntNpcScripts_27 ; slot 3 NpcScripts
	dw End3DormEntFacingScripts_27 ; slot 4 FacingScripts
	dw End3DormEntTileTriggers_27 ; slot 5 TileTriggers
	dw End3DormEntInitScript_27 ; slot 6 InitScript
End3DormEntActors_27:
	; $6c26, 66 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $0100, $0100, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $0100, $0100, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_27_785d, $0100, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $0100, $0100, FACE_DOWN, $4d, $01, $00
	map_actor_end
End3DormEntEntryPoints_27:
	; $6c68, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $1600, $1b00, $0000
	map_entry $02, FACE_DOWN, $1600, $0d00, $0000
	map_entry $0f, FACE_UP, $1600, $1b00, $0000
	db $ff
End3DormEntExitTriggers_27:
	ds 1, $ff ; $6c81, fill
End3DormEntNpcScripts_27:
	ds 1, $ff ; $6c82, fill
End3DormEntFacingScripts_27:
	ds 1, $ff ; $6c83, fill
End3DormEntTileTriggers_27:
	ds 1, $ff ; $6c84, fill
End3DormEntInitScript_27:
	farcall FarPtr_BeginCutsceneScriptMode ; $6c85
	ld a, [wStoryModeEntryPoint] ; $6c88
	cp a, $01 ; $6c8b
	call z, Func_27_6c94 ; $6c8d
	farcall FarPtr_EndCutsceneScriptMode ; $6c90
	ret ; $6c93
Func_27_6c94:
	test_flag $05, 7 ; $6c94
	jr z, Label_27_6caf ; $6c97
	script_set_actor_script $02, ActorScript_27_785d ; $6c99
	script_set_position $02, $3f00, $3f00 ; $6ca4
Label_27_6caf:
	script_set_speed $03, $0010 ; $6caf
	script_set_speed $04, $0010 ; $6cb7
	script_set_speed $00, $0010 ; $6cbf
	script_player_speed $0010 ; $6cc7
	script_set_position $00, $1600, $1f00 ; $6ccd
	script_set_position $03, $1600, $1d00 ; $6cd8
	script_face $03, $c0 ; $6ce3
	script_fade_in $20 ; $6cea
	script_move_target $03, $1600, $1100 ; $6cef
	script_move_player $1600, $0f00 ; $6cfa
	script_move_target $00, $1600, $1400 ; $6d04
	script_wait_move $00 ; $6d0f
	script_move_target $03, $1600, $1100 ; $6d14
	script_move_target $00, $1600, $1300 ; $6d1f
	script_wait_move $00 ; $6d2a
	script_wait_frames $14 ; $6d2f
	script_wait_move $03 ; $6d36
	script_face_toward $00, $03 ; $6d3b
	script_set_anim $03, $03 ; $6d43
	script_wait_idle $03 ; $6d4a
	script_set_anim $00, $02 ; $6d4f
	script_player_speed $0018 ; $6d56
	script_move_player $1600, $0b00 ; $6d5c
	farcall FarPtr_WaitPlayerMoveDone ; $6d66
	script_wait_frames $14 ; $6d69
	script_move_player $1100, $0b00 ; $6d70
	farcall FarPtr_WaitPlayerMoveDone ; $6d7a
	script_wait_frames $0a ; $6d7d
	script_move_player $1a00, $0b00 ; $6d84
	farcall FarPtr_WaitPlayerMoveDone ; $6d8e
	script_wait_frames $0a ; $6d91
	script_move_player $1600, $0b00 ; $6d98
	farcall FarPtr_WaitPlayerMoveDone ; $6da2
	script_wait_frames $1e ; $6da5
	script_move_player $1600, $1000 ; $6dac
	script_set_anim $00, $02 ; $6db6
	script_wait_idle $00 ; $6dbd
	script_wait_frames $14 ; $6dc2
	script_player_speed $0010 ; $6dc9
	sound $97 ; $6dcf
	script_set_position $05, $1780, $0f00 ; $6dd1
	script_set_anim $03, $02 ; $6ddc
	script_wait_idle $03 ; $6de3
	script_set_position $05, $0100, $0100 ; $6de8
	script_move_target $03, $1600, $0b00 ; $6df3
	script_wait_move $03 ; $6dfe
	script_set_position $04, $1700, $0b00 ; $6e03
	script_wait_frames $3c ; $6e0e
	script_face $00, $40 ; $6e15
	script_wait_frames $14 ; $6e1c
	script_set_anim $00, $04 ; $6e23
	script_wait_idle $00 ; $6e2a
	script_wait_frames $14 ; $6e2f
	script_face $00, $c0 ; $6e36
	script_set_active $03, $02 ; $6e3d
	script_set_position $03, $1500, $0b00 ; $6e44
	ld a, [$c94d] ; $6e4f
	or a, a ; $6e52
	jr nz, Label_27_6e68 ; $6e53
	script_set_objdef $28, $04 ; $6e55
	script_set_anim $04, $01 ; $6e61
Label_27_6e68:
	script_move_target $03, $1500, $0f00 ; $6e68
	script_wait_move $03 ; $6e73
	script_move_target $04, $1700, $0f00 ; $6e78
	script_wait_move $04 ; $6e83
	sound $98 ; $6e88
	script_set_position $06, $1780, $1100 ; $6e8a
	script_wait_frames $3c ; $6e95
	script_set_anim $03, $04 ; $6e9c
	script_wait_idle $03 ; $6ea3
	script_set_position $06, $0100, $0100 ; $6ea8
	script_face_toward $04, $03 ; $6eb3
	script_wait_frames $3c ; $6ebb
	script_face_toward $00, $03 ; $6ec2
	script_set_anim $04, $03 ; $6eca
	script_wait_idle $04 ; $6ed1
	ld a, $0f ; $6ed6
	ld [$c294], a ; $6ed8
	ld [wStoryModeExitLocationRequest], a ; $6edb
	ret ; $6ede
EndRestaurantEntMapScripts_27:
	; $6edf, 14 bytes (map_tree)
	dw EndRestaurantEntEntryPoints_27 ; slot 0 EntryPoints
	dw EndRestaurantEntExitTriggers_27 ; slot 1 ExitTriggers
	dw EndRestaurantEntActors_27 ; slot 2 Actors
	dw EndRestaurantEntNpcScripts_27 ; slot 3 NpcScripts
	dw EndRestaurantEntFacingScripts_27 ; slot 4 FacingScripts
	dw EndRestaurantEntTileTriggers_27 ; slot 5 TileTriggers
	dw EndRestaurantEntInitScript_27 ; slot 6 InitScript
EndRestaurantEntActors_27:
	; $6eed, 10 bytes (map_actors)
	map_actor_end
EndRestaurantEntEntryPoints_27:
	; $6ef7, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0700, $0840, $0000
	db $ff
EndRestaurantEntExitTriggers_27:
	; $6f00, 73 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $09, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, $0d, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_27, $10, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_27, $07, $02
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_27, $0b, $01
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_27, $0f, $01
	map_script $0d, FACEMASK_ANY, $0000, MapScriptNop_27, $0c, $01
	map_script $0e, FACEMASK_ANY, $0000, MapScriptNop_27, $09, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, $0f, $0f
	db $ff
EndRestaurantEntNpcScripts_27:
	ds 1, $ff ; $6f49, fill
EndRestaurantEntFacingScripts_27:
	ds 1, $ff ; $6f4a, fill
EndRestaurantEntTileTriggers_27:
	ds 1, $ff ; $6f4b, fill
EndRestaurantEntInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6f4c
	cp a, $01 ; $6f4f
	jr nz, Label_27_6f56 ; $6f51
	call Func_27_6f57 ; $6f53
Label_27_6f56:
	ret ; $6f56
Func_27_6f57:
	ldh a, [hRomBank] ; $6f57
	ld hl, EndRestaurantEntActorsAlt_27 ; $6f59
	farcall FarPtr_ScriptRespawnLocationActors ; $6f5c
	farcall FarPtr_BeginCutsceneScriptMode ; $6f5f
	test_flag $05, 7 ; $6f62
	jr z, Label_27_6f7d ; $6f65
	script_set_actor_script $02, ActorScript_27_785d ; $6f67
	script_set_position $02, $3f00, $3f00 ; $6f72
Label_27_6f7d:
	script_set_position $00, $3f00, $3f00 ; $6f7d
	script_set_position $06, $3f00, $3f00 ; $6f88
	script_set_position $07, $3f00, $3f00 ; $6f93
	script_set_position $08, $3f00, $3f00 ; $6f9e
	script_fade_in $04 ; $6fa9
	script_set_position $06, $4100, $0d00 ; $6fae
	script_move_target $06, $1b00, $0d00 ; $6fb9
	script_set_position $00, $4300, $0d00 ; $6fc4
	script_move_target $00, $1d00, $0d00 ; $6fcf
	script_wait_frames $0f ; $6fda
	script_move_player $1b00, $0d00 ; $6fe1
	script_wait_move $00 ; $6feb
	script_wait_frames $1e ; $6ff0
	script_face_toward $00, $06 ; $6ff7
	script_set_anim $00, $03 ; $6fff
	script_wait_idle $00 ; $7006
	script_face $06, $c0 ; $700b
	script_wait_frames $0f ; $7012
	script_face $00, $c0 ; $7019
	script_set_anim $00, $03 ; $7020
	script_wait_idle $00 ; $7027
	script_wait_frames $1e ; $702c
	call Func_27_716b ; $7033
	script_wait_frames $0f ; $7036
	sound $97 ; $703d
	script_set_position $03, $1c00, $0b00 ; $703f
	script_wait_frames $1e ; $704a
	script_set_position $03, $3f00, $3f00 ; $7051
	script_face $06, $80 ; $705c
	script_wait_frames $0f ; $7063
	script_face $00, $80 ; $706a
	script_move_player $1800, $0d00 ; $7071
	script_wait_frames $0f ; $707b
	script_set_position $07, $1500, $0980 ; $7082
	script_wait_frames $0f ; $708d
	script_set_speed $07, $0010 ; $7094
	script_move_target $07, $1500, $0d00 ; $709c
	script_wait_move $07 ; $70a7
	script_face $07, $00 ; $70ac
	script_set_position $08, $1500, $0900 ; $70b3
	script_wait_frames $0f ; $70be
	script_set_speed $08, $0010 ; $70c5
	script_move_target $08, $1500, $0b00 ; $70cd
	script_wait_move $08 ; $70d8
	call Func_27_71bf ; $70dd
	script_face $08, $00 ; $70e0
	script_wait_frames $0f ; $70e7
	script_set_anim $06, $02 ; $70ee
	script_wait_idle $06 ; $70f5
	script_face $07, $40 ; $70fa
	ld a, $0e ; $7101
	ld [$c294], a ; $7103
	ld [wStoryModeExitLocationRequest], a ; $7106
	farcall FarPtr_EndCutsceneScriptMode ; $7109
	ret ; $710c
EndRestaurantEntActorsAlt_27:
	; $710d, 94 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_27_785d, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_27_785d, $4100, $0d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $0d00, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_27_785d, $1300, $0d00, FACE_DOWN, $4b, $01, $00
	map_actor_end
Func_27_716b:
	sound $71 ; $716b
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $716d
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $717c
	script_wait_frames $02 ; $718b
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $7192
	script_wait_frames $02 ; $71a1
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $71a8
	script_wait_frames $02 ; $71b7
	ret ; $71be
Func_27_71bf:
	sound $71 ; $71bf
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $71c1
	script_wait_frames $01 ; $71d0
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $71d7
	script_wait_frames $01 ; $71e6
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $71ed
	script_wait_frames $01 ; $71fc
	script_copy_scene_rect $06, $15, $14, $08, $02, $02 ; $7203
	ret ; $7212
End1MainBldgMapScripts_27:
	; $7213, 14 bytes (map_tree)
	dw End1MainBldgEntryPoints_27 ; slot 0 EntryPoints
	dw End1MainBldgExitTriggers_27 ; slot 1 ExitTriggers
	dw End1MainBldgActors_27 ; slot 2 Actors
	dw End1MainBldgNpcScripts_27 ; slot 3 NpcScripts
	dw End1MainBldgFacingScripts_27 ; slot 4 FacingScripts
	dw End1MainBldgTileTriggers_27 ; slot 5 TileTriggers
	dw End1MainBldgInitScript_27 ; slot 6 InitScript
End1MainBldgActors_27:
	; $7221, 150 bytes (map_actors)
	map_actor $0000, ActorScript_27_785d, $1500, $3d00, FACE_RIGHT, $4d, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $3d00, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $3d00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $1500, $3d00, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_27_785d, $1800, $1100, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_785d, $1a00, $1500, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_27_785d, $1600, $1500, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_27_785d, $1900, $1700, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_27_785d, $0100, $1900, FACE_UP, $4a, $01, $00
	map_actor_end
End1MainBldgEntryPoints_27:
	; $72b7, 25 bytes (map_entries)
	map_entry $01, FACE_DOWN, $1800, $1100, $0000
	map_entry $02, FACE_UP, $1800, $1100, $0000
	map_entry $0f, FACE_UP, $1800, $2f00, $0000
	db $ff
End1MainBldgExitTriggers_27:
	; $72d0, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, $05, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, $1b, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_27, $1b, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_27, $1e, $02
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, $05, $0f
	db $ff
End1MainBldgNpcScripts_27:
	ds 1, $ff ; $72f9, fill
End1MainBldgFacingScripts_27:
	ds 1, $ff ; $72fa, fill
End1MainBldgTileTriggers_27:
	ds 1, $ff ; $72fb, fill
End1MainBldgInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $72fc
	cp a, $01 ; $72ff
	jp z, Label_27_730a ; $7301
	cp a, $02 ; $7304
	jp z, Label_27_760e ; $7306
	ret ; $7309
Label_27_730a:
	script_set_speed $00, $0010 ; $730a
	xor a, a ; $7312
	ld [wStoryModeShowLocationName], a ; $7313
	script_set_position $06, $1800, $0d00 ; $7316
	script_set_position $00, $1800, $3700 ; $7321
	script_set_position $0b, $3f00, $3f00 ; $732c
	script_set_position $0a, $3f00, $3f00 ; $7337
	script_set_position $09, $3f00, $3f00 ; $7342
	script_set_position $08, $3f00, $3f00 ; $734d
	script_set_position $0c, $3f00, $3f00 ; $7358
	test_flag $05, 7 ; $7363
	jr z, Label_27_737e ; $7366
	script_set_actor_script $02, ActorScript_27_785d ; $7368
	script_set_position $02, $3f00, $3f00 ; $7373
Label_27_737e:
	script_player_speed $0040 ; $737e
	script_move_player $1800, $1200 ; $7384
	farcall FarPtr_WaitPlayerMoveDone ; $738e
	script_fade_in $04 ; $7391
	call WaitFadeEnd ; $7396
	script_move_target $00, $1800, $2100 ; $7399
	script_wait_frames $14 ; $73a4
	script_set_position $00, $1800, $2000 ; $73ab
	script_face $00, $c0 ; $73b6
	script_set_speed $06, $0024 ; $73bd
	script_move_target $06, $1800, $1400 ; $73c5
	script_wait_move $06 ; $73d0
	script_set_anim $06, $04 ; $73d5
	script_wait_idle $06 ; $73dc
	script_face $06, $c0 ; $73e1
	script_set_anim $06, $03 ; $73e8
	script_wait_idle $06 ; $73ef
	script_set_speed $06, $0020 ; $73f4
	script_face $06, $40 ; $73fc
	script_jump_velocity $06, $ff80 ; $7403
	ld a, $06 ; $740b
	farcall FarPtr_ScriptWaitActorJumpDone ; $740d
	script_move_target $06, $1800, $1700 ; $7410
	script_wait_move $06 ; $741b
	sound $98 ; $7420
	script_set_position $03, $1980, $15c0 ; $7422
	script_set_speed $06, $0010 ; $742d
	script_set_speed $03, $0010 ; $7435
	script_move_target $03, $1980, $18c0 ; $743d
	script_move_target $06, $1800, $1a00 ; $7448
	script_wait_move $06 ; $7453
	script_set_position $03, $3f00, $3f00 ; $7458
	script_move_target $06, $1800, $1600 ; $7463
	script_wait_move $06 ; $746e
	script_wait_frames $1e ; $7473
	script_set_anim $06, $02 ; $747a
	sound $97 ; $7481
	script_set_position $04, $1980, $14c0 ; $7483
	script_wait_frames $14 ; $748e
	script_set_position $04, $3f00, $3f00 ; $7495
	script_set_speed $06, $0020 ; $74a0
	script_jump_velocity $06, $ff80 ; $74a8
	ld a, $06 ; $74b0
	farcall FarPtr_ScriptWaitActorJumpDone ; $74b2
	script_move_target $06, $1800, $2000 ; $74b5
	script_wait_frames $1e ; $74c0
	ld bc, $d040 ; $74c7
	script_get_actor_state $06 ; $74ca
	ld e, l ; $74cf
	ld d, h ; $74d0
	farcall FarPtr_04_1e ; $74d1
	script_move_target $00, $1800, $1e00 ; $74d4
	script_wait_frames $14 ; $74df
	call Func_27_7595 ; $74e6
	script_wait_move $06 ; $74e9
	script_set_anim $06, $02 ; $74ee
	sound $96 ; $74f5
	script_set_position $05, $1900, $1e00 ; $74f7
	script_wait_frames $3c ; $7502
	script_set_position $05, $3f00, $3f00 ; $7509
	script_move_target $06, $1700, $2200 ; $7514
	script_wait_move $06 ; $751f
	script_face_toward $00, $06 ; $7524
	script_wait_frames $14 ; $752c
	script_move_target $06, $1900, $2400 ; $7533
	script_wait_move $06 ; $753e
	script_null_script $01 ; $7543
	script_face_toward $00, $06 ; $7548
	script_set_anim $06, $02 ; $7550
	script_wait_idle $06 ; $7557
	script_wait_frames $14 ; $755c
	script_set_position $07, $1a80, $2280 ; $7563
	script_wait_frames $3c ; $756e
	script_set_position $07, $3f00, $3f00 ; $7575
	script_set_anim $06, $02 ; $7580
	script_wait_idle $06 ; $7587
	ld a, $01 ; $758c
	ld [$c294], a ; $758e
	ld [wStoryModeExitLocationRequest], a ; $7591
	ret ; $7594
Func_27_7595:
	sound $70 ; $7595
	script_null_script $01 ; $7597
	ld a, $03 ; $759c
	farcall FarPtr_SetScreenShake ; $759e
	script_wait_frames $0a ; $75a1
	ld a, $00 ; $75a8
	farcall FarPtr_SetScreenShake ; $75aa
	script_set_speed $00, $0040 ; $75ad
	script_move_player $1800, $2400 ; $75b5
	script_move_target $00, $1700, $2400 ; $75bf
	script_jump_velocity $00, $ff00 ; $75ca
	script_get_actor_state $00 ; $75d2
	ld c, l ; $75d7
	ld b, h ; $75d8
	ld hl, $0037 ; $75d9
	add hl, bc ; $75dc
	ld a, [hl] ; $75dd
	or a, $40 ; $75de
	ld [hl], a ; $75e0
	script_wait_frames $1e ; $75e1
	script_set_anim $00, $02 ; $75e8
	script_wait_idle $00 ; $75ef
	script_wait_frames $1e ; $75f4
	script_set_actor_script $00, ActorScript_27_7607 ; $75fb
	ret ; $7606
ActorScript_27_7607:
	; $7607, 7 bytes (actor_script)
	as_anim $02
	as_wait $50
	as_jump ActorScript_27_7607
Label_27_760e:
	script_set_position $06, $3f00, $3f00 ; $760e
	test_flag $05, 7 ; $7619
	jp z, Label_27_7659 ; $761c
	script_null_script $02 ; $761f
	script_set_position $02, $3f00, $3f00 ; $7624
	ld a, [$c94d] ; $762f
	ld d, $58 ; $7632
	add a, d ; $7634
	ld d, a ; $7635
	script_get_actor_state $0a ; $7636
	ld c, l ; $763b
	ld b, h ; $763c
	farcall FarPtr_LoadActorObjectDefIfValid ; $763d
	script_set_anim $0a, $01 ; $7640
	script_set_position $0c, $1a00, $1100 ; $7647
	script_face $0c, $40 ; $7652
Label_27_7659:
	ld a, [$c90d] ; $7659
	ld d, $56 ; $765c
	add a, d ; $765e
	ld d, a ; $765f
	script_get_actor_state $00 ; $7660
	ld c, l ; $7665
	ld b, h ; $7666
	farcall FarPtr_LoadActorObjectDefIfValid ; $7667
	script_set_anim $00, $01 ; $766a
	script_set_position $00, $1700, $1700 ; $7671
	script_face $00, $c0 ; $767c
	script_fade_in $04 ; $7683
	call WaitFadeEnd ; $7688
	script_delay $3c ; $768b
	test_flag $05, 7 ; $7690
	jp z, Label_27_7704 ; $7693
	script_face_pair $0a, $00 ; $7696
	script_delay $1e ; $769e
	script_set_anim $00, $03 ; $76a3
	script_set_anim $0a, $03 ; $76aa
	script_wait_idle $0a ; $76b1
	script_delay $1e ; $76b6
	script_face $0a, $c0 ; $76bb
	script_delay $1e ; $76c2
	script_set_anim $0c, $02 ; $76c7
	script_wait_idle $0c ; $76ce
	script_delay $32 ; $76d3
	script_face_pair $0c, $08 ; $76d8
	script_set_anim $08, $03 ; $76e0
	script_set_anim $0c, $03 ; $76e7
	script_wait_idle $0c ; $76ee
	script_face $0c, $40 ; $76f3
	script_face $08, $40 ; $76fa
	jp Label_27_7748 ; $7701
Label_27_7704:
	script_face_pair $0b, $00 ; $7704
	script_delay $1e ; $770c
	script_set_anim $00, $03 ; $7711
	script_set_anim $0b, $03 ; $7718
	script_wait_idle $0b ; $771f
	script_delay $0a ; $7724
	script_face $00, $c0 ; $7729
	script_face $0b, $c0 ; $7730
	script_delay $14 ; $7737
	script_set_anim $08, $03 ; $773c
	script_wait_idle $08 ; $7743
Label_27_7748:
	script_delay $28 ; $7748
	script_set_anim $09, $03 ; $774d
	script_set_anim $0a, $03 ; $7754
	script_set_anim $00, $03 ; $775b
	script_set_anim $0b, $03 ; $7762
	script_wait_idle $0b ; $7769
	script_delay $14 ; $776e
	script_face_pair $0b, $00 ; $7773
	script_face_pair $09, $0a ; $777b
	script_delay $0a ; $7783
	script_facing_lock $00, $01 ; $7788
	script_facing_lock $0b, $01 ; $778f
	script_facing_lock $0a, $01 ; $7796
	script_facing_lock $09, $01 ; $779d
	script_move_target $00, $1600, $1700 ; $77a4
	script_move_target $0b, $1a00, $1700 ; $77af
	script_move_target $0a, $1500, $1500 ; $77ba
	script_move_target $09, $1b00, $1500 ; $77c5
	script_wait_move $09 ; $77d0
	script_player_speed $0020 ; $77d5
	script_move_player $1800, $2f00 ; $77db
	script_move_target $08, $1800, $1900 ; $77e5
	script_wait_move $08 ; $77f0
	script_facing_lock $00, $00 ; $77f5
	script_facing_lock $0b, $00 ; $77fc
	script_facing_lock $0a, $00 ; $7803
	script_facing_lock $09, $00 ; $780a
	script_move_target $00, $1600, $1f00 ; $7811
	script_move_target $0b, $1a00, $1f00 ; $781c
	script_move_target $0a, $1500, $1d00 ; $7827
	script_move_target $09, $1b00, $1d00 ; $7832
	script_move_target $08, $1800, $2100 ; $783d
	script_wait_move $08 ; $7848
	ld a, $05 ; $784d
	ld [$c294], a ; $784f
	ld [wStoryModeExitLocationRequest], a ; $7852
	ret ; $7855
WaitScriptFramesSaveA:
	push af ; $7856
	ld a, a ; $7857
	farcall FarPtr_WaitScriptFrames ; $7858
	pop af ; $785b
	ret ; $785c
ActorScript_27_785d:
	; $785d, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_27_7867:
	; $7867, 20 bytes (actor_script)
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
ActorScript_27_787b:
	; $787b, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L1
MapScriptNop_27:
	ret ; $7885
	INCBIN "data/bank_027/d_7886.bin" ; $7886, 13 bytes
ActorScript_27_7893:
	; $7893, 99 bytes (actor_script)
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
	as_jump ActorScript_27_7893
ActorScript_27_78f6:
	; $78f6, 103 bytes (actor_script)
	as_anim $00
	as_wait $3c
.L4:
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
	as_jump .L4
ActorScript_27_795d:
	; $795d, 103 bytes (actor_script)
	as_anim $00
	as_wait $1e
.L4:
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
	as_jump .L4
ActorScript_27_79c4:
	; $79c4, 253 bytes (actor_script)
	as_anim $00
	as_wait $1e
	as_wait $3c
.L6:
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
	as_jump .L6
.L69:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L69
.L76:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L76
	INCBIN "data/bank_027/d_7a49.bin" ; $7a49, 120 bytes (unclassified tail)
	ds 1343, $ff ; $7ac1, fill
