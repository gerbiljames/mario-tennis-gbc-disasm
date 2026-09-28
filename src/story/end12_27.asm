ActorScript_27_02:
	; $4b67, 25 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
ActorScript_27_03:
	; $4b80, 60 bytes (actor_script)
	as_set_target $1300, $1300
	as_wait_move
	as_set_target $1300, $0b00
	as_wait_move
	as_set_target $0e00, $0b00
	as_wait_move
	as_set_target $0e00, $0700
	as_wait_move
	as_halt
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L21:
	as_target_rel $fe00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait $4b
	as_target_rel $0200, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
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
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, OBJ_BALLOON_ANGRY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_ANGRY
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, OBJ_BALLOON_MUSIC, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_MUSIC
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_2
	map_actor $0000, ActorScript_27_27, $2000, $2f00, FACE_DOWN, OBJ_WALK_75_06, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_WALK_75_06
	map_actor $0000, ActorScript_27_27, $2200, $3300, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_KEVIN
	map_actor $0000, ActorScript_27_27, $2000, $3300, FACE_LEFT, OBJ_MARK, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_MARK
	map_actor $0000, ActorScript_27_27, $1e00, $3300, FACE_RIGHT, OBJ_EMILY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_EMILY
	map_actor_end
End12PrincipalsOfficeEntryPoints_27:
	; $4c44, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, $1f00, $3b00, $0000
	map_entry $02, FACE_LEFT, $1f00, $3b00, $0000
	db $ff
End12PrincipalsOfficeExitTriggers_27:
	; $4c55, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ACADEMY_ENTRANCE, $01
	db $ff
End12PrincipalsOfficeNpcScripts_27:
	ds 1, $ff ; $4c5e, fill
End12PrincipalsOfficeFacingScripts_27:
	ds 1, $ff ; $4c5f, fill
End12PrincipalsOfficeTileTriggers_27:
	ds 1, $ff ; $4c60, fill
End12PrincipalsOfficeInitScript_27:
	ld a, $16 ; $4c61
	ld [wMapScrollMinX], a ; $4c63
	ld a, $28 ; $4c66
	ld [wMapScrollMinY], a ; $4c68
	ld a, $40 ; $4c6b
	ld [wMapWidthTiles], a ; $4c6d
	ld a, $3e ; $4c70
	ld [wMapHeightTiles], a ; $4c72
	call DisableLCDSafely ; $4c75
	ld a, $00 ; $4c78
	farcall CopyScrolledSceneTilemapToVram ; $4c7a
	call EnableLCD ; $4c7d
	ld a, [wStoryModeEntryPoint] ; $4c80
	cp $02 ; $4c83
	jp z, .eq02 ; $4c85
	jp .clearStoryModeShowLocationName ; $4c88
	ret ; $4c8b
.clearStoryModeShowLocationName:
	xor a ; $4c8c
	ld [wStoryModeShowLocationName], a ; $4c8d
	script_set_position ACTOR_PLAYER, $2b00, $3b00 ; $4c90
	script_set_position ACTOR_PARTNER, $2b00, $3b00 ; $4c9b
	script_fade_in $04 ; $4ca6
	script_delay $14 ; $4cab
	script_move_target $07, $1e00, $2f00 ; $4cb0
	script_wait_move $07 ; $4cbb
	script_face $07, FACE_DOWN ; $4cc0
	script_delay $1e ; $4cc7
	script_move_target $07, $2200, $2f00 ; $4ccc
	script_wait_move $07 ; $4cd7
	script_face $07, FACE_DOWN ; $4cdc
	script_delay $1e ; $4ce3
	script_move_target $07, $2000, $2f00 ; $4ce8
	script_wait_move $07 ; $4cf3
	script_face $07, FACE_DOWN ; $4cf8
	script_delay $0a ; $4cff
	script_set_anim $07, ANIM_BOUNCE ; $4d04
	script_wait_idle $07 ; $4d0b
	script_face $08, FACE_UP ; $4d10
	script_face $09, FACE_UP ; $4d17
	script_face $0a, FACE_UP ; $4d1e
	sound SFX_APPEAR2 ; $4d25
	script_set_position $04, $1f80, $3180 ; $4d27
	script_delay $28 ; $4d32
	sound SFX_APPEAR2 ; $4d37
	script_set_position $06, $2180, $3180 ; $4d39
	script_delay $28 ; $4d44
	sound SFX_APPEAR2 ; $4d49
	script_set_position $04, $2380, $3180 ; $4d4b
	script_delay $28 ; $4d56
	script_set_position $06, $3f00, $3f00 ; $4d5b
	script_delay $28 ; $4d66
	script_set_position $04, $3f00, $3f00 ; $4d6b
	test_flag FLAG_DOUBLES ; $4d76
	jp z, .walkPlayer ; $4d79
	script_null_script ACTOR_PARTNER ; $4d7c
	script_set_position ACTOR_PARTNER, $2d00, $3b00 ; $4d81
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $4d8c
	script_move_target ACTOR_PARTNER, $2300, $3b00 ; $4d97
	script_wait_move ACTOR_PARTNER ; $4da2
	script_wait_frames $05 ; $4da7
	script_face ACTOR_PLAYER, FACE_UP ; $4dae
	call OpenPrincipalsOfficeDoor_27 ; $4db5
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $4db8
	script_move_target ACTOR_PARTNER, $2100, $3b00 ; $4dc3
	script_wait_move ACTOR_PARTNER ; $4dce
	script_move_target ACTOR_PLAYER, $1f00, $3500 ; $4dd3
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $4dde
	script_wait_move ACTOR_PARTNER ; $4de9
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $4dee
	script_wait_move ACTOR_PARTNER ; $4df9
	script_face ACTOR_PLAYER, FACE_UP ; $4dfe
	script_face ACTOR_PARTNER, FACE_UP ; $4e05
	script_delay $01 ; $4e0c
	jr .closePrincipalsOfficeDoor ; $4e11
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $4e13
	script_wait_move ACTOR_PLAYER ; $4e1e
	script_face ACTOR_PLAYER, FACE_UP ; $4e23
	call OpenPrincipalsOfficeDoor_27 ; $4e2a
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $4e2d
	script_wait_move ACTOR_PLAYER ; $4e38
	script_move_target ACTOR_PLAYER, $2000, $3500 ; $4e3d
	script_wait_move ACTOR_PLAYER ; $4e48
	script_face ACTOR_PLAYER, FACE_UP ; $4e4d
	script_delay $01 ; $4e54
.closePrincipalsOfficeDoor:
	call ClosePrincipalsOfficeDoor_27 ; $4e59
	script_set_anim $07, ANIM_BOUNCE ; $4e5c
	script_set_anim $08, ANIM_BOUNCE ; $4e63
	script_set_anim $09, ANIM_BOUNCE ; $4e6a
	script_set_anim $0a, ANIM_BOUNCE ; $4e71
	script_wait_idle $0a ; $4e78
	script_delay $1e ; $4e7d
	script_move_target $0a, $1d00, $3500 ; $4e82
	script_move_target $09, $2300, $3500 ; $4e8d
	script_move_target $08, $2500, $3500 ; $4e98
	script_wait_move $08 ; $4ea3
	script_face $0a, FACE_RIGHT ; $4ea8
	script_face $09, FACE_LEFT ; $4eaf
	script_face $08, FACE_LEFT ; $4eb6
	script_delay $0a ; $4ebd
	test_flag FLAG_DOUBLES ; $4ec2
	jp z, .playSfx ; $4ec5
	script_delay $3c ; $4ec8
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $4ecd
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4ed5
	script_wait_idle ACTOR_PLAYER ; $4edc
	script_delay $14 ; $4ee1
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $4ee6
	script_delay $01 ; $4eee
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4ef3
	script_wait_idle ACTOR_PARTNER ; $4efa
	script_delay $14 ; $4eff
	script_face ACTOR_PLAYER, FACE_UP ; $4f04
	script_face ACTOR_PARTNER, FACE_UP ; $4f0b
	script_set_anim $08, ANIM_NOD ; $4f12
	script_set_anim $09, ANIM_NOD ; $4f19
	script_set_anim $0a, ANIM_NOD ; $4f20
	script_wait_idle $0a ; $4f27
	script_delay $28 ; $4f2c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4f31
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4f38
	script_wait_idle ACTOR_PARTNER ; $4f3f
	script_move_target ACTOR_PLAYER, $1f00, $3200 ; $4f44
	script_move_target ACTOR_PARTNER, $2100, $3200 ; $4f4f
	script_wait_move ACTOR_PARTNER ; $4f5a
	jp .storeStoryModeExitLocationRequest ; $4f5f
.playSfx:
	sound SFX_APPEAR2 ; $4f62
	script_set_position $04, $2180, $3380 ; $4f64
	script_delay $50 ; $4f6f
	script_set_position $04, $3f00, $3f00 ; $4f74
	script_face_toward $0a, ACTOR_PLAYER ; $4f7f
	script_delay $28 ; $4f87
	script_face_toward ACTOR_PLAYER, $0a ; $4f8c
	script_delay $01 ; $4f94
	script_set_anim $0a, ANIM_NOD ; $4f99
	script_wait_idle $0a ; $4fa0
	script_delay $14 ; $4fa5
	script_face ACTOR_PLAYER, FACE_UP ; $4faa
	script_set_anim $08, ANIM_NOD ; $4fb1
	script_set_anim $09, ANIM_NOD ; $4fb8
	script_set_anim $0a, ANIM_NOD ; $4fbf
	script_wait_idle $0a ; $4fc6
	script_delay $28 ; $4fcb
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4fd0
	script_move_target ACTOR_PLAYER, $2000, $3200 ; $4fd7
	script_wait_move ACTOR_PLAYER ; $4fe2
.storeStoryModeExitLocationRequest:
	ld a, $01 ; $4fe7
	ld [wUnusedExitTriggerIdMirror], a ; $4fe9
	ld [wStoryModeExitTriggerRequest], a ; $4fec
	ret ; $4fef
.eq02:
	ldh a, [hRomBank] ; $4ff0
	ld hl, End12PrincipalsOfficeActorsAlt_27 ; $4ff2
	farcall ScriptRespawnLocationActors ; $4ff5
	farcall BeginCutsceneScriptMode ; $4ff8
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_ALT_TROPHY_1, ANIM_TROPHY_SINGLES ; $4ffb
	test_flag FLAG_DOUBLES ; $5002
	jp z, .placeActors ; $5005
	script_null_script ACTOR_PARTNER ; $5008
	script_set_position ACTOR_PLAYER, $1f00, $3400 ; $500d
	script_set_position ACTOR_PARTNER, $2100, $3400 ; $5018
	script_face ACTOR_PARTNER, FACE_UP ; $5023
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $502a
	jr nz, .face ; $502d
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_ALT_TROPHY_1, $3f00, $3f00 ; $502f
	jr .face ; $503a
.placeActors:
	script_set_position ACTOR_PLAYER, $2000, $3400 ; $503c
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $5047
	jr nz, .face ; $504a
	script_set_position $05, $3f00, $3f00 ; $504c
.face:
	script_face ACTOR_PLAYER, FACE_UP ; $5057
	xor a ; $505e
	ld [wStoryModeShowLocationName], a ; $505f
	script_fade_in $04 ; $5062
	call WaitFadeEnd ; $5067
	test_flag FLAG_DOUBLES ; $506a
	jp z, .animate ; $506d
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5070
	script_wait_idle ACTOR_PLAYER ; $5077
	script_set_anim $03, ANIM_NOD ; $507c
	script_wait_idle $03 ; $5083
	script_delay $3c ; $5088
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $508d
	script_delay $1e ; $5095
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $509a
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $50a1
	script_wait_idle ACTOR_PARTNER ; $50a8
	script_face ACTOR_PARTNER, FACE_DOWN ; $50ad
	script_move_target ACTOR_PLAYER, $2100, $3600 ; $50b4
	script_wait_move ACTOR_PLAYER ; $50bf
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $50c4
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $50cf
	script_wait_move ACTOR_PARTNER ; $50da
	call OpenPrincipalsOfficeDoor_27 ; $50df
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_04 ; $50e2
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_04 ; $50ed
	script_delay $14 ; $50f8
	jr .closePrincipalsOfficeDoor2 ; $50fd
.animate:
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $50ff
	script_wait_idle ACTOR_PLAYER ; $5106
	script_set_anim $03, ANIM_NOD ; $510b
	script_wait_idle $03 ; $5112
	script_delay $3c ; $5117
	script_move_target ACTOR_PLAYER, $2100, $3400 ; $511c
	script_wait_move ACTOR_PLAYER ; $5127
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $512c
	script_wait_move ACTOR_PLAYER ; $5137
	call OpenPrincipalsOfficeDoor_27 ; $513c
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_04 ; $513f
	script_delay $14 ; $514a
.closePrincipalsOfficeDoor2:
	call ClosePrincipalsOfficeDoor_27 ; $514f
	script_delay $3c ; $5152
	set_flag FLAG_ENDING_CREDITS_PENDING ; $5157
	ld c, $04 ; $515a
	call BeginFadeOut ; $515c
	call WaitFadeEnd ; $515f
	ld a, $01 ; $5162
	ld [wUnusedExitTriggerIdMirror], a ; $5164
	ld [wStoryModeExitTriggerRequest], a ; $5167
	ret ; $516a
OpenPrincipalsOfficeDoor_27:
	script_wait_frames $0a ; $516b
	sound SFX_DOOR_ALT ; $5172
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $5174
	script_wait_frames $02 ; $5183
	script_copy_scene_rect $0b, $38, $20, $38, $02, $02 ; $518a
	script_wait_frames $04 ; $5199
	ret ; $51a0
ClosePrincipalsOfficeDoor_27:
	sound SFX_DOOR_ALT ; $51a1
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $51a3
	script_wait_frames $02 ; $51b2
	script_copy_scene_rect $03, $38, $20, $38, $02, $02 ; $51b9
	script_wait_frames $04 ; $51c8
	ret ; $51cf
ActorScript_27_04:
	; $51d0, 13 bytes (actor_script)
	as_set_target $2100, $3b00
	as_wait_move
	as_set_target $3500, $3b00
	as_wait_move
	as_halt
End12PrincipalsOfficeActorsAlt_27:
	; $51dd, 52 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $2000, $3000, FACE_DOWN, OBJ_WALK_75_06, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_WALK_75_06
	map_actor $0000, ActorScript_27_27, $2700, $3240, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_TROPHY_1
	map_actor $0000, ActorScript_27_27, $2700, $30c0, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_TROPHY_2
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
	map_actor $0000, ActorScript_27_27, $3f00, $0500, FACE_DOWN, OBJ_WALK_76_06, ANIM_WALK, $00, END11_TRAINING_COURT_WALK_76_06
	map_actor $0000, ActorScript_27_27, $3f00, $0500, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, END11_TRAINING_COURT_BALLOON_QUESTION
	map_actor $0000, ActorScript_27_27, $3f00, $0500, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END11_TRAINING_COURT_BALLOON_EXCLAIM
	map_actor_end
End11TrainingCourtEntryPoints_27:
	; $5253, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3300, $0d00, $0000
	map_entry $02, FACE_UP, $1800, $1100, $0000
	db $ff
End11TrainingCourtExitTriggers_27:
	; $5264, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_RESTAURANT_PLAZA, $00
	db $ff
End11TrainingCourtNpcScripts_27:
	ds 1, $ff ; $526d, fill
End11TrainingCourtFacingScripts_27:
	ds 1, $ff ; $526e, fill
End11TrainingCourtTileTriggers_27:
	ds 1, $ff ; $526f, fill
End11TrainingCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $5270
	cp $01 ; $5273
	jp z, .checkDoubles ; $5275
	cp $02 ; $5278
	jp z, .eq02 ; $527a
	ret ; $527d
.checkDoubles:
	test_flag FLAG_DOUBLES ; $527e
	jr z, .checkStoryModeMainCharacterLeftHanded ; $5281
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_27 ; $5283
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $528e
.checkStoryModeMainCharacterLeftHanded:
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5299
	and a ; $529c
	jr z, .face ; $529d
	script_get_actor_state ACTOR_PLAYER ; $529f
	ld c, l ; $52a4
	ld b, h ; $52a5
	ld hl, ACTORF_OAM_ATTR ; $52a6
	add hl, bc ; $52a9
	ld a, [hl] ; $52aa
	xor $20 ; $52ab
	ld [hl], a ; $52ad
.face:
	script_face ACTOR_PLAYER, FACE_DOWN ; $52ae
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_06 ; $52b5
	xor a ; $52c0
	ld [wStoryModeShowLocationName], a ; $52c1
	script_fade_in $04 ; $52c4
	script_delay $78 ; $52c9
	script_get_actor_state ACTOR_PLAYER ; $52ce
	ld a, $01 ; $52d3
	ld e, l ; $52d5
	ld d, h ; $52d6
	ld hl, $0018 ; $52d7
	add hl, de ; $52da
	ld [hl], a ; $52db
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $52dc
	script_wait_idle ACTOR_PLAYER ; $52e3
	script_null_script ACTOR_PLAYER ; $52e8
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $52ed
	script_delay $3c ; $52f4
	script_face ACTOR_PLAYER, FACE_LEFT ; $52f9
	script_delay $1e ; $5300
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5305
	script_delay $1e ; $530c
	script_face ACTOR_PLAYER, FACE_LEFT ; $5311
	script_delay $1e ; $5318
	script_face ACTOR_PLAYER, FACE_RIGHT ; $531d
	script_delay $1e ; $5324
	script_face ACTOR_PLAYER, FACE_DOWN ; $5329
	script_delay $1e ; $5330
	sound SFX_EMOTE ; $5335
	script_set_position $04, $3480, $0b80 ; $5337
	script_delay $3c ; $5342
	script_set_position $03, $3300, $0700 ; $5347
	script_set_active $03, $00 ; $5352
	script_player_speed $0010 ; $5359
	script_move_player_to_actor $03 ; $535f
	ld hl, End11TrainingCourtInitScriptPalette0_27 ; $5366
	lb de, $02, $06 ; $5369 palette index, count
	call LoadPalettesImmediate ; $536c
	script_delay $1e ; $536f
	ld hl, End11TrainingCourtInitScriptPalette1_27 ; $5374
	lb de, $02, $06 ; $5377 palette index, count
	call LoadPalettesImmediate ; $537a
	ld a, $10 ; $537d
.loop:
	ld d, a ; $537f
	script_set_active $03, $02 ; $5380
	script_wait_frames $04 ; $5387
	script_set_active $03, $00 ; $538e
	push af ; $5395
	ld a, d ; $5396
	farcall WaitScriptFrames ; $5397
	pop af ; $539a
	ld a, d ; $539b
	sub $02 ; $539c
	jp nz, .loop ; $539e
	script_set_active $03, $02 ; $53a1
	script_delay $3c ; $53a8
	script_set_position $04, $3f00, $3f00 ; $53ad
	script_face ACTOR_PLAYER, FACE_UP ; $53b8
	script_delay $1e ; $53bf
	sound SFX_CHIME ; $53c4
	script_set_position $05, $3480, $0b80 ; $53c6
	script_delay $14 ; $53d1
	script_jump_velocity $05, $ff40 ; $53d6
	script_jump_velocity ACTOR_PLAYER, $ff40 ; $53de
	ld a, $00 ; $53e6
	farcall ScriptWaitActorJumpDone ; $53e8
	script_delay $1e ; $53eb
	ld a, $01 ; $53f0
	ld [wUnusedExitTriggerIdMirror], a ; $53f2
	ld [wStoryModeExitTriggerRequest], a ; $53f5
	ret ; $53f8
.eq02:
	ldh a, [hRomBank] ; $53f9
	ld hl, End11TrainingCourtActorsAlt_27 ; $53fb
	farcall ScriptRespawnLocationActors ; $53fe
	script_set_position ACTOR_PLAYER, $1800, $1100 ; $5401
	farcall BeginCutsceneScriptMode ; $540c
	script_face ACTOR_PLAYER, FACE_UP ; $540f
	script_set_position ACTOR_END11_TRAINING_COURT_ALT_BOB, $1800, $0d00 ; $5416
	script_face ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_DOWN ; $5421
	script_null_script ACTOR_PARTNER ; $5428
	script_set_position ACTOR_PARTNER, $1300, $1100 ; $542d
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5438
	script_move_player $1800, $0f00 ; $543f
	farcall WaitPlayerMoveDone ; $5449
	script_fade_in $08 ; $544c
	call WaitFadeEnd ; $5451
	script_wait_frames $1e ; $5454
	script_set_anim ACTOR_END11_TRAINING_COURT_ALT_BOB, ANIM_BOUNCE ; $545b
	script_wait_idle ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5462
	script_lock_facing ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5467
	script_move_angle ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_UP, $0100 ; $546e
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5478
	script_wait_frames $28 ; $547d
	script_move_angle ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_UP, $0100 ; $5484
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $548e
	script_set_anim ACTOR_END11_TRAINING_COURT_ALT_BOB, ANIM_BOUNCE ; $5493
	script_wait_idle ACTOR_END11_TRAINING_COURT_ALT_BOB ; $549a
	script_unlock_facing ACTOR_END11_TRAINING_COURT_ALT_BOB ; $549f
	script_set_speed ACTOR_END11_TRAINING_COURT_ALT_BOB, $0030 ; $54a6
	script_get_actor_state ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54ae
	ld a, $04 ; $54b3
	ld e, l ; $54b5
	ld d, h ; $54b6
	ld hl, $0018 ; $54b7
	add hl, de ; $54ba
	ld [hl], a ; $54bb
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, $1f00, $0b00 ; $54bc
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54c7
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, $1f00, $1100 ; $54cc
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54d7
	script_face ACTOR_PLAYER, FACE_DOWN ; $54dc
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, $1f00, $1f00 ; $54e3
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54ee
	script_set_position ACTOR_END11_TRAINING_COURT_ALT_BOB, $3f00, $3f00 ; $54f3
	ld a, $01 ; $54fe
	ld [wUnusedExitTriggerIdMirror], a ; $5500
	ld [wStoryModeExitTriggerRequest], a ; $5503
	ret ; $5506
End11TrainingCourtActorsAlt_27:
	; $5507, 80 bytes (map_actors)
	map_actor $0000, ActorScript_27_05, $0b00, $0700, FACE_DOWN, OBJ_WALK_71_06, ANIM_WALK, $03, END11_TRAINING_COURT_ALT_WALK_71_06
	map_actor $0000, ActorScript_27_05, $0b00, $1700, FACE_UP, OBJ_WALK_71_05, ANIM_WALK, $07, END11_TRAINING_COURT_ALT_WALK_71_05
	map_actor $0000, ActorScript_27_05, $0e00, $1700, FACE_UP, OBJ_WALK_71_07, ANIM_WALK, $05, END11_TRAINING_COURT_ALT_WALK_71_07
	map_actor $0000, ActorScript_27_27, $1300, $0b00, FACE_LEFT, OBJ_BOB, ANIM_WALK, $00, END11_TRAINING_COURT_ALT_BOB
	map_actor $0000, ActorScript_27_27, $1300, $1500, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, END11_TRAINING_COURT_ALT_CURT
	map_actor_end
