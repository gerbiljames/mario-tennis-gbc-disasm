ApplyPartnerCharacterVariant_13:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $62be
	or a ; $62c1
	jr nz, .done ; $62c2
	script_set_objdef OBJ_HARRY, $0d ; $62c4
	script_set_anim $0d, ANIM_WALK ; $62d0
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $62d7
.done:
	ret ; $62da
Table_13:
	; $62db, 36 bytes (bytes:12)
	db $0d, $12, $80, $ff, $01, $1e, $0d, $12, $60, $ff, $01, $32 ; 0x00
	db $10, $03, $01, $1e, $10, $01, $10, $03, $01, $5a, $0c, $e9 ; 0x0c
	db $ff, $10, $02, $01, $5a, $10, $04, $01, $96, $0c, $f7, $ff ; 0x18
CourtyardEntryWalkIn_13:
	ld a, [wStoryModeEntryPoint] ; $62ff
	cp STORYENTRY_NONE ; $6302
	jp z, .done ; $6304
	test_flag FLAG_DOUBLES ; $6307
	jr z, .walkOff ; $630a
	script_set_speed ACTOR_PARTNER, $00ff ; $630c
	ld a, [wStoryModeEntryPoint] ; $6314
	dec a ; $6317
	ld_hl_indexed CourtyardEntryWalkInFacings_13 + 3 ; $6318
	ld b, [hl] ; $631f
	ld a, $02 ; $6320
	ld b, b ; $6322
	ld de, $0200 ; $6323
	farcall MoveActorByAngle ; $6326
	script_wait_move ACTOR_PARTNER ; $6329
	ld a, [wStoryModeEntryPoint] ; $632e
	dec a ; $6331
	ld_hl_indexed CourtyardEntryWalkInFacings_13 ; $6332
	ld b, [hl] ; $6339
	ld a, $02 ; $633a
	ld b, b ; $633c
	farcall SetActorFacing ; $633d
	script_set_speed ACTOR_PARTNER, $0010 ; $6340
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $6348
	ld a, [wStoryModeEntryPoint] ; $6350
	dec a ; $6353
	ld_hl_indexed CourtyardEntryWalkInFacings_13 ; $6354
	ld b, [hl] ; $635b
	ld a, $00 ; $635c
	ld b, b ; $635e
	ld de, $0200 ; $635f
	farcall MoveActorByAngle ; $6362
.done:
	ret ; $6365
CourtyardEntryWalkInFacings_13:
	; $6366, 6 bytes (enum:FACE:6)
	db FACE_DOWN, FACE_DOWN, FACE_UP, FACE_UP, FACE_UP, FACE_DOWN ; 0x00
VarsityCourtTourCutscene:
	ldh a, [hRomBank] ; $636c
	ld hl, VarsityCourtTourActors_13 ; $636e
	farcall ScriptRespawnLocationActors ; $6371
	farcall BeginCutsceneScriptMode ; $6374
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $6377
	script_set_position ACTOR_VARSITY_COURT_TOUR_EMILY, 63.0, 63.0 ; $6382
	script_fade_in $04 ; $638d
	call WaitFadeEnd ; $6392
	script_set_position ACTOR_VARSITY_COURT_TOUR_EMILY, 34.0, 51.0 ; $6395
	script_move_target ACTOR_VARSITY_COURT_TOUR_EMILY, 34.0, 29.0 ; $63a0
	script_wait_frames $0f ; $63ab
	script_move_player 34.0, 29.0 ; $63b2
	script_set_position ACTOR_PLAYER, 34.0, 51.0 ; $63bc
	script_move_target ACTOR_PLAYER, 34.0, 33.0 ; $63c7
	script_wait_move ACTOR_PLAYER ; $63d2
	script_wait_frames $0f ; $63d7
	script_move_target ACTOR_PLAYER, 32.0, 31.0 ; $63de
	script_wait_move ACTOR_PLAYER ; $63e9
	script_wait_frames $1e ; $63ee
	script_face ACTOR_VARSITY_COURT_TOUR_EMILY, FACE_LEFT ; $63f5
	script_wait_frames $1e ; $63fc
	script_face ACTOR_PLAYER, FACE_LEFT ; $6403
	script_wait_frames $1e ; $640a
	script_move_player 12.0, 27.0 ; $6411
	farcall WaitPlayerMoveDone ; $641b
	script_wait_frames $1e ; $641e
	script_set_text Text_30_518 ; $6425
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $642b
	script_wait_frames $0f ; $6430
	script_player_speed $0040 ; $6437
	script_move_player 34.0, 29.0 ; $643d
	farcall WaitPlayerMoveDone ; $6447
	script_player_speed $0020 ; $644a
	script_set_position ACTOR_VARSITY_COURT_TOUR_BALLOON_QUESTION, 33.0, 29.0 ; $6450
	sound SFX_EMOTE ; $645b
	script_wait_frames $32 ; $645d
	script_set_position ACTOR_VARSITY_COURT_TOUR_BALLOON_QUESTION, 63.0, 63.0 ; $6464
	script_set_anim ACTOR_VARSITY_COURT_TOUR_EMILY, ANIM_BOUNCE ; $646f
	script_wait_idle ACTOR_VARSITY_COURT_TOUR_EMILY ; $6476
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $647b
	script_wait_frames $1e ; $6480
	script_face ACTOR_VARSITY_COURT_TOUR_EMILY, FACE_DOWN ; $6487
	script_wait_frames $0f ; $648e
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $6495
	script_face ACTOR_VARSITY_COURT_TOUR_EMILY, FACE_LEFT ; $649a
	script_wait_frames $0f ; $64a1
	script_player_speed $0040 ; $64a8
	script_move_player 12.0, 22.0 ; $64ae
	farcall WaitPlayerMoveDone ; $64b8
	script_player_speed $0020 ; $64bb
	script_wait_frames $3c ; $64c1
	script_move_player 12.0, 34.0 ; $64c8
	farcall WaitPlayerMoveDone ; $64d2
	script_wait_frames $3c ; $64d5
	script_move_player 12.0, 27.0 ; $64dc
	farcall WaitPlayerMoveDone ; $64e6
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $64e9
	script_wait_frames $0f ; $64ee
	script_player_speed $0040 ; $64f5
	script_move_player 34.0, 29.0 ; $64fb
	farcall WaitPlayerMoveDone ; $6505
	script_player_speed $0020 ; $6508
	script_wait_frames $1e ; $650e
	script_face ACTOR_VARSITY_COURT_TOUR_EMILY, FACE_RIGHT ; $6515
	script_wait_frames $0f ; $651c
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6523
	script_move_player 48.0, 38.0 ; $652a
	farcall WaitPlayerMoveDone ; $6534
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $6537
	script_wait_frames $0f ; $653c
	script_move_player 54.0, 16.0 ; $6543
	farcall WaitPlayerMoveDone ; $654d
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $6550
	script_wait_frames $0f ; $6555
	script_player_speed $0040 ; $655c
	script_move_player 34.0, 29.0 ; $6562
	farcall WaitPlayerMoveDone ; $656c
	script_player_speed $0020 ; $656f
	script_wait_frames $0f ; $6575
	script_face ACTOR_VARSITY_COURT_TOUR_EMILY, FACE_DOWN ; $657c
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $6583
	script_wait_frames $1e ; $6588
	script_face ACTOR_PLAYER, FACE_UP ; $658f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $6596
	script_wait_idle ACTOR_PLAYER ; $659d
	script_wait_frames $0f ; $65a2
	script_set_anim ACTOR_VARSITY_COURT_TOUR_EMILY, ANIM_BOUNCE ; $65a9
	script_wait_idle ACTOR_VARSITY_COURT_TOUR_EMILY ; $65b0
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $65b5
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $65ba
	script_wait_idle ACTOR_PLAYER ; $65c1
	script_wait_frames $1e ; $65c6
	script_set_anim ACTOR_VARSITY_COURT_TOUR_EMILY, ANIM_NOD ; $65cd
	script_wait_idle ACTOR_VARSITY_COURT_TOUR_EMILY ; $65d4
	script_speak ACTOR_VARSITY_COURT_TOUR_EMILY ; $65d9
	script_move_target ACTOR_PLAYER, 34.0, 31.0 ; $65de
	script_wait_move ACTOR_PLAYER ; $65e9
	script_face ACTOR_PLAYER, FACE_UP ; $65ee
	script_wait_frames $0f ; $65f5
	script_move_target ACTOR_VARSITY_COURT_TOUR_EMILY, 34.0, 7.0 ; $65fc
	script_wait_frames $05 ; $6607
	script_move_target ACTOR_PLAYER, 34.0, 7.0 ; $660e
	script_wait_frames $0a ; $6619
	script_move_player 34.0, 13.0 ; $6620
	script_wait_move ACTOR_PLAYER ; $662a
	ld a, $0f ; $662f
	ld [wUnusedExitTriggerIdMirror], a ; $6631
	ld [wStoryModeExitTriggerRequest], a ; $6634
	ret ; $6637
VarsityCourtTourActors_13:
	; $6638, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, VARSITY_COURT_TOUR_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_13_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, VARSITY_COURT_TOUR_BALLOON_QUESTION
	map_actor $0000, ActorScript_13_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_ELLIPSIS, ANIM_WALK, $00, VARSITY_COURT_TOUR_BALLOON_ELLIPSIS
	map_actor $0000, ActorScript_13_27, 43.0, 11.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, VARSITY_COURT_TOUR_EMILY
	map_actor_end
Unused_13_DecompressVarsityCourtTourRecords:
	push_wram_bank WRAM_STAGING ; $667a
	ld c, $04 ; $6683
	xor a ; $6685
.loop:
	push bc ; $6686
	push af ; $6687
	ld hl, VarsityCourtTourLzPtrs_13 ; $6688
	sla a ; $668b
	add l ; $668d
	ld l, a ; $668e
	jr nc, .read ; $668f
	inc h ; $6691
.read:
	ld a, [hl+] ; $6692
	ld h, [hl] ; $6693
	ld l, a ; $6694
	ld de, wDecompBuffer ; $6695
	call DecompressData ; $6698
	pop af ; $669b
	push af ; $669c
	ld hl, vTiles0 + VRAM_BANK1 ; $669d
	ld d, a ; $66a0
	ld e, $00 ; $66a1
	add hl, de ; $66a3
	ld d, h ; $66a4
	ld e, l ; $66a5
	ld hl, wDecompBuffer ; $66a6
	ld c, $10 ; $66a9
	call QueueVRAMCopy ; $66ab
	pop af ; $66ae
	pop bc ; $66af
	inc a ; $66b0
	dec c ; $66b1
	jr nz, .loop ; $66b2
	ld hl, VarsityCourtTourPalette_13 ; $66b4
	ld_obj_pals de, 0, 1 ; $66b7
	call LoadPaletteShadow ; $66ba
	pop_wram_bank ; $66bd
	ret ; $66c2
Unused_13_QueueVarsityCourtTourSprites:
	ld a, [wCameraX + 1] ; $66c3
	cp $18 ; $66c6
	ret c ; $66c8
	ld a, [wCameraY + 1] ; $66c9
	cp $10 ; $66cc
	ret c ; $66ce
	ldh a, [hVBlankCounter] ; $66cf
	srl a ; $66d1
	srl a ; $66d3
	srl a ; $66d5
	and $03 ; $66d7
	push af ; $66d9
	ld hl, VarsityCourtTourSpritePtrs_13 ; $66da
	sla a ; $66dd
	add l ; $66df
	ld l, a ; $66e0
	jr nc, .read ; $66e1
	inc h ; $66e3
.read:
	ld a, [hl+] ; $66e4
	ld h, [hl] ; $66e5
	ld l, a ; $66e6
	pop af ; $66e7
	swap a ; $66e8
	ld c, a ; $66ea
	ldh a, [hScrollX] ; $66eb
	ld b, a ; $66ed
	ld a, $70 ; $66ee
	sub b ; $66f0
	ld d, a ; $66f1
	ldh a, [hScrollY] ; $66f2
	ld b, a ; $66f4
	ld a, $20 ; $66f5
	sub b ; $66f7
	ld e, a ; $66f8
	ld b, OAM_BANK1 ; $66f9
	call QueueSpriteTemplate ; $66fb
	ret ; $66fe
VarsityCourtTourSpritePtrs_13:
	; $66ff, 8 bytes (records:2)
	dw VarsityCourtTourSprite0_13 ; record 0
	dw VarsityCourtTourSprite1_13 ; record 1
	dw VarsityCourtTourSprite2_13 ; record 2
	dw VarsityCourtTourSprite3_13 ; record 3
VarsityCourtTourSprite0_13:
	; $6707, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
VarsityCourtTourSprite1_13:
	; $6728, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
VarsityCourtTourSprite2_13:
	; $6749, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
VarsityCourtTourSprite3_13:
	; $676a, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
VarsityCourtTourLzPtrs_13:
	; $678b, 8 bytes (records:2)
	dw VarsityCourtTourLz0_13 ; record 0
	dw VarsityCourtTourLz1_13 ; record 1
	dw VarsityCourtTourLz2_13 ; record 2
	dw VarsityCourtTourLz3_13 ; record 3
VarsityCourtTourLz0_13:
	INCBIN "data/bank_013/lz_VarsityCourtTourLz0_13.bin" ; $6793, 158 bytes
VarsityCourtTourLz1_13:
	INCBIN "data/bank_013/lz_VarsityCourtTourLz1_13.bin" ; $6831, 157 bytes
VarsityCourtTourLz2_13:
	INCBIN "data/bank_013/lz_VarsityCourtTourLz2_13.bin" ; $68ce, 161 bytes
VarsityCourtTourLz3_13:
	INCBIN "data/bank_013/lz_VarsityCourtTourLz3_13.bin" ; $696f, 153 bytes
VarsityCourtTourPalette_13:
	INCBIN "data/bank_013/VarsityCourtTourPalette_13.bin" ; $6a08, 8 bytes
SetupStoryMinigameMatch0:
	script_null_script ACTOR_VARSITY_COURT_A_FAY ; $6a10
	script_set_anim ACTOR_VARSITY_COURT_A_FAY, ANIM_WALK ; $6a15
	script_null_script ACTOR_VARSITY_COURT_A_BETH ; $6a1c
	script_set_speed ACTOR_VARSITY_COURT_A_BETH, $0018 ; $6a21
	script_set_actor_script ACTOR_VARSITY_COURT_A_KEVIN, ActorScript_13_04 ; $6a29
	script_set_actor_script ACTOR_VARSITY_COURT_A_CURT, ActorScript_13_06 ; $6a34
	script_set_actor_script ACTOR_VARSITY_COURT_A_BETH, ActorScript_13_08 ; $6a3f
	script_set_actor_script ACTOR_VARSITY_COURT_A_FAY, ActorScript_13_10 ; $6a4a
	script_move_player 12.0, 28.0 ; $6a55
	farcall WaitPlayerMoveDone ; $6a5f
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $6a62
	script_wait_actor_script ACTOR_VARSITY_COURT_A_FAY ; $6a6d
	farcall InitStoryMatchSettings ; $6a72
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_VARSITY_PRACTICE ; $6a75
	farcall RunStoryMatch ; $6a82
	farcall RestoreOverworldAfterMatch ; $6a85
	ret ; $6a88
SetupVarsityCourtDoublesMatch_13:
	script_null_script ACTOR_VARSITY_COURT_B_FAY ; $6a89
	script_null_script ACTOR_VARSITY_COURT_B_BETH ; $6a8e
	script_set_speed ACTOR_VARSITY_COURT_B_BETH, $0018 ; $6a93
	script_set_anim ACTOR_VARSITY_COURT_B_FAY, ANIM_WALK ; $6a9b
	script_set_anim ACTOR_VARSITY_COURT_B_FAY, ANIM_NOD ; $6aa2
	script_wait_idle ACTOR_VARSITY_COURT_B_FAY ; $6aa9
	script_set_actor_script ACTOR_VARSITY_COURT_B_FAY, ActorScript_13_10 ; $6aae
	script_set_actor_script ACTOR_VARSITY_COURT_B_CURT, ActorScript_13_11 ; $6ab9
	script_set_actor_script ACTOR_VARSITY_COURT_B_BETH, ActorScript_13_08 ; $6ac4
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $6acf
	script_set_actor_script ACTOR_PARTNER, ActorScript_13_15 ; $6ada
	script_set_actor_script ACTOR_VARSITY_COURT_B_KEVIN, ActorScript_13_04 ; $6ae5
	script_move_player 12.0, 28.0 ; $6af0
	farcall WaitPlayerMoveDone ; $6afa
	script_wait_actor_script ACTOR_VARSITY_COURT_B_FAY ; $6afd
	farcall InitStoryMatchSettings ; $6b02
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_VARSITY_PRACTICE ; $6b05
	farcall RunStoryMatch ; $6b12
	farcall RestoreOverworldAfterMatch ; $6b15
	ret ; $6b18
ActorScript_13_04:
	; $6b19, 11 bytes (actor_script)
	as_set_target 17.0, 29.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_05:
	; $6b24, 13 bytes (actor_script)
	as_anim ANIM_WALK
	as_set_target 19.0, 33.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_06:
	; $6b31, 11 bytes (actor_script)
	as_set_target 19.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_07:
	; $6b3c, 11 bytes (actor_script)
	as_set_target 19.0, 35.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_08:
	; $6b47, 17 bytes (actor_script)
	as_set_target 17.0, 24.0
	as_wait_move
	as_set_target 19.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_09:
	; $6b58, 17 bytes (actor_script)
	as_set_target 17.0, 19.0
	as_wait_move
	as_set_target 19.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_13_10:
	; $6b69, 23 bytes (actor_script)
	as_set_target 7.0, 35.0
	as_wait_move
	as_set_target 7.0, 19.0
	as_wait_move
	as_set_target 11.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_11:
	; $6b80, 23 bytes (actor_script)
	as_set_target 7.0, 35.0
	as_wait_move
	as_set_target 7.0, 23.0
	as_wait_move
	as_set_target 13.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_12:
	; $6b97, 23 bytes (actor_script)
	as_set_target 7.0, 29.0
	as_wait_move
	as_set_target 7.0, 19.0
	as_wait_move
	as_set_target 11.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_13:
	; $6bae, 23 bytes (actor_script)
	as_set_target 7.0, 33.0
	as_wait_move
	as_set_target 7.0, 23.0
	as_wait_move
	as_set_target 13.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_14:
	; $6bc5, 23 bytes (actor_script)
	as_set_target 7.0, 31.0
	as_wait_move
	as_set_target 7.0, 19.0
	as_wait_move
	as_set_target 11.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_13_15:
	; $6bdc, 11 bytes (actor_script)
	as_set_target 11.0, 31.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_16:
	; $6be7, 11 bytes (actor_script)
	as_set_target 13.0, 35.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_17:
	; $6bf2, 11 bytes (actor_script)
	as_set_target 5.0, 29.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_13_18:
	; $6bfd, 11 bytes (actor_script)
	as_set_target 5.0, 35.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_13_19:
	; $6c08, 11 bytes (actor_script)
	as_set_target 5.0, 33.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
