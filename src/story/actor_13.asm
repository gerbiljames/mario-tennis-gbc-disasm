ApplyPartnerCharacterVariant_13:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $62be
	or a ; $62c1
	jr nz, .done ; $62c2
	script_set_objdef OBJ_HARRY, $0d ; $62c4
	script_set_anim $0d, $01 ; $62d0
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
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $6377
	script_set_position $06, $3f00, $3f00 ; $6382
	script_fade_in $04 ; $638d
	call WaitFadeEnd ; $6392
	script_set_position $06, $2200, $3300 ; $6395
	script_move_target $06, $2200, $1d00 ; $63a0
	script_wait_frames $0f ; $63ab
	script_move_player $2200, $1d00 ; $63b2
	script_set_position ACTOR_PLAYER, $2200, $3300 ; $63bc
	script_move_target ACTOR_PLAYER, $2200, $2100 ; $63c7
	script_wait_move ACTOR_PLAYER ; $63d2
	script_wait_frames $0f ; $63d7
	script_move_target ACTOR_PLAYER, $2000, $1f00 ; $63de
	script_wait_move ACTOR_PLAYER ; $63e9
	script_wait_frames $1e ; $63ee
	script_face $06, FACE_LEFT ; $63f5
	script_wait_frames $1e ; $63fc
	script_face ACTOR_PLAYER, FACE_LEFT ; $6403
	script_wait_frames $1e ; $640a
	script_move_player $0c00, $1b00 ; $6411
	farcall WaitPlayerMoveDone ; $641b
	script_wait_frames $1e ; $641e
	script_set_text Text_30_518 ; $6425
	script_speak $06 ; $642b
	script_wait_frames $0f ; $6430
	script_player_speed $0040 ; $6437
	script_move_player $2200, $1d00 ; $643d
	farcall WaitPlayerMoveDone ; $6447
	script_player_speed $0020 ; $644a
	script_set_position $04, $2100, $1d00 ; $6450
	sound SFX_EMOTE ; $645b
	script_wait_frames $32 ; $645d
	script_set_position $04, $3f00, $3f00 ; $6464
	script_set_anim $06, $02 ; $646f
	script_wait_idle $06 ; $6476
	script_speak $06 ; $647b
	script_wait_frames $1e ; $6480
	script_face $06, FACE_DOWN ; $6487
	script_wait_frames $0f ; $648e
	script_speak $06 ; $6495
	script_face $06, FACE_LEFT ; $649a
	script_wait_frames $0f ; $64a1
	script_player_speed $0040 ; $64a8
	script_move_player $0c00, $1600 ; $64ae
	farcall WaitPlayerMoveDone ; $64b8
	script_player_speed $0020 ; $64bb
	script_wait_frames $3c ; $64c1
	script_move_player $0c00, $2200 ; $64c8
	farcall WaitPlayerMoveDone ; $64d2
	script_wait_frames $3c ; $64d5
	script_move_player $0c00, $1b00 ; $64dc
	farcall WaitPlayerMoveDone ; $64e6
	script_speak $06 ; $64e9
	script_wait_frames $0f ; $64ee
	script_player_speed $0040 ; $64f5
	script_move_player $2200, $1d00 ; $64fb
	farcall WaitPlayerMoveDone ; $6505
	script_player_speed $0020 ; $6508
	script_wait_frames $1e ; $650e
	script_face $06, FACE_RIGHT ; $6515
	script_wait_frames $0f ; $651c
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6523
	script_move_player $3000, $2600 ; $652a
	farcall WaitPlayerMoveDone ; $6534
	script_speak $06 ; $6537
	script_wait_frames $0f ; $653c
	script_move_player $3600, $1000 ; $6543
	farcall WaitPlayerMoveDone ; $654d
	script_speak $06 ; $6550
	script_wait_frames $0f ; $6555
	script_player_speed $0040 ; $655c
	script_move_player $2200, $1d00 ; $6562
	farcall WaitPlayerMoveDone ; $656c
	script_player_speed $0020 ; $656f
	script_wait_frames $0f ; $6575
	script_face $06, FACE_DOWN ; $657c
	script_speak $06 ; $6583
	script_wait_frames $1e ; $6588
	script_face ACTOR_PLAYER, FACE_UP ; $658f
	script_set_anim ACTOR_PLAYER, $03 ; $6596
	script_wait_idle ACTOR_PLAYER ; $659d
	script_wait_frames $0f ; $65a2
	script_set_anim $06, $02 ; $65a9
	script_wait_idle $06 ; $65b0
	script_speak $06 ; $65b5
	script_set_anim ACTOR_PLAYER, $02 ; $65ba
	script_wait_idle ACTOR_PLAYER ; $65c1
	script_wait_frames $1e ; $65c6
	script_set_anim $06, $03 ; $65cd
	script_wait_idle $06 ; $65d4
	script_speak $06 ; $65d9
	script_move_target ACTOR_PLAYER, $2200, $1f00 ; $65de
	script_wait_move ACTOR_PLAYER ; $65e9
	script_face ACTOR_PLAYER, FACE_UP ; $65ee
	script_wait_frames $0f ; $65f5
	script_move_target $06, $2200, $0700 ; $65fc
	script_wait_frames $05 ; $6607
	script_move_target ACTOR_PLAYER, $2200, $0700 ; $660e
	script_wait_frames $0a ; $6619
	script_move_player $2200, $0d00 ; $6620
	script_wait_move ACTOR_PLAYER ; $662a
	ld a, $0f ; $662f
	ld [wUnusedExitTriggerIdMirror], a ; $6631
	ld [wStoryModeExitTriggerRequest], a ; $6634
	ret ; $6637
VarsityCourtTourActors_13:
	; $6638, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_12, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_13, $01, $00
	map_actor $0000, ActorScript_13_27, $fd00, $0100, FACE_DOWN, OBJ_WALK_73_15, $01, $00
	map_actor $0000, ActorScript_13_27, $2b00, $0b00, FACE_DOWN, OBJ_EMILY, $01, $00
	map_actor_end
DecompressVarsityCourtTourRecords_13:
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
	ld hl, $8000 + VRAM_BANK1 ; $669d
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
	lb de, $08, $01 ; $66b7 palette index, count
	call LoadPaletteShadow ; $66ba
	pop_wram_bank ; $66bd
	ret ; $66c2
QueueVarsityCourtTourSprites_13:
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
	ld b, $08 ; $66f9
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
	script_null_script $05 ; $6a10
	script_set_anim $05, $01 ; $6a15
	script_null_script $07 ; $6a1c
	script_set_speed $07, $0018 ; $6a21
	script_set_actor_script $03, ActorScript_13_04 ; $6a29
	script_set_actor_script $06, ActorScript_13_06 ; $6a34
	script_set_actor_script $07, ActorScript_13_08 ; $6a3f
	script_set_actor_script $05, ActorScript_13_10 ; $6a4a
	script_move_player $0c00, $1c00 ; $6a55
	farcall WaitPlayerMoveDone ; $6a5f
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $6a62
	script_wait_actor_script $05 ; $6a6d
	farcall InitStoryMatchSettings ; $6a72
	load_match_settings $000a ; $6a75
	farcall RunStoryMatch ; $6a82
	farcall RestoreOverworldAfterMatch ; $6a85
	ret ; $6a88
SetupVarsityCourtDoublesMatch_13:
	script_null_script $05 ; $6a89
	script_null_script $07 ; $6a8e
	script_set_speed $07, $0018 ; $6a93
	script_set_anim $05, $01 ; $6a9b
	script_set_anim $05, $03 ; $6aa2
	script_wait_idle $05 ; $6aa9
	script_set_actor_script $05, ActorScript_13_10 ; $6aae
	script_set_actor_script $06, ActorScript_13_11 ; $6ab9
	script_set_actor_script $07, ActorScript_13_08 ; $6ac4
	script_set_actor_script ACTOR_PLAYER, ActorScript_13_16 ; $6acf
	script_set_actor_script ACTOR_PARTNER, ActorScript_13_15 ; $6ada
	script_set_actor_script $03, ActorScript_13_04 ; $6ae5
	script_move_player $0c00, $1c00 ; $6af0
	farcall WaitPlayerMoveDone ; $6afa
	script_wait_actor_script $05 ; $6afd
	farcall InitStoryMatchSettings ; $6b02
	load_match_settings $010a ; $6b05
	farcall RunStoryMatch ; $6b12
	farcall RestoreOverworldAfterMatch ; $6b15
	ret ; $6b18
ActorScript_13_04:
	; $6b19, 11 bytes (actor_script)
	as_set_target $1100, $1d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_05:
	; $6b24, 13 bytes (actor_script)
	as_anim $01
	as_set_target $1300, $2100
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_06:
	; $6b31, 11 bytes (actor_script)
	as_set_target $1300, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_07:
	; $6b3c, 11 bytes (actor_script)
	as_set_target $1300, $2300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_08:
	; $6b47, 17 bytes (actor_script)
	as_set_target $1100, $1800
	as_wait_move
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_09:
	; $6b58, 17 bytes (actor_script)
	as_set_target $1100, $1300
	as_wait_move
	as_set_target $1300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_13_10:
	; $6b69, 23 bytes (actor_script)
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_11:
	; $6b80, 23 bytes (actor_script)
	as_set_target $0700, $2300
	as_wait_move
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0d00, $1700
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_12:
	; $6b97, 23 bytes (actor_script)
	as_set_target $0700, $1d00
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_13:
	; $6bae, 23 bytes (actor_script)
	as_set_target $0700, $2100
	as_wait_move
	as_set_target $0700, $1700
	as_wait_move
	as_set_target $0d00, $1700
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_14:
	; $6bc5, 23 bytes (actor_script)
	as_set_target $0700, $1f00
	as_wait_move
	as_set_target $0700, $1300
	as_wait_move
	as_set_target $0b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_13_15:
	; $6bdc, 11 bytes (actor_script)
	as_set_target $0b00, $1f00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_16:
	; $6be7, 11 bytes (actor_script)
	as_set_target $0d00, $2300
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_17:
	; $6bf2, 11 bytes (actor_script)
	as_set_target $0500, $1d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_13_18:
	; $6bfd, 11 bytes (actor_script)
	as_set_target $0500, $2300
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_13_19:
	; $6c08, 11 bytes (actor_script)
	as_set_target $0500, $2100
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
