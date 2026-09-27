ExhibitionDeclinedCutscene:
	script_wait_frames $0a ; $7082
	sound SFX_APPEAR1 ; $7089
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, $1400, $0d00 ; $708b
	script_wait_frames $28 ; $7096
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $709d
	script_wait_frames $14 ; $70a2
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, $3f00, $3f00 ; $70a9
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_BOUNCE ; $70b4
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $70bb
	script_speak ACTOR_MARIO_WORLD_PEACH ; $70c0
	script_wait_frames $0a ; $70c5
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $70cc
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $70d3
	script_wait_frames $0a ; $70d8
	script_speak ACTOR_MARIO_WORLD_PEACH ; $70df
	script_jump_velocity ACTOR_MARIO_WORLD_BOWSER, $ff80 ; $70e4
	script_wait_frames $14 ; $70ec
	sound SFX_IMPACT ; $70f3
	ld a, $04 ; $70f5
	farcall SetScreenShake ; $70f7
	script_wait_frames $0a ; $70fa
	ld a, $00 ; $7101
	farcall SetScreenShake ; $7103
	script_wait_frames $1e ; $7106
	script_move_target ACTOR_MARIO_WORLD_WARIO, $0c00, $0d00 ; $710d
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, $0c00, $1100 ; $7118
	script_wait_frames $14 ; $7123
	script_move_target ACTOR_MARIO_WORLD_BOWSER, $0c00, $0f00 ; $712a
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $7135
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $713a
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $7141
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $7148
	ret ; $714f
PlayStarWarpTransition:
	ldh a, [hWramBank] ; $7150
	push af ; $7152
	ld hl, StarWarpPalette ; $7153
	lb de, $09, $01 ; $7156 palette index, count
	call LoadPaletteShadow ; $7159
	ld hl, StarWarpTiles ; $715c
	ld de, vTiles0 + VRAM_BANK1 ; $715f
	ld c, (StarWarpSparkleTiles - StarWarpTiles) / 16 ; $7162
	call QueueVRAMCopy ; $7164
	ld hl, StarWarpSparkleTiles ; $7167
	ld de, vTiles0 + $18 * TILE_SIZE + VRAM_BANK1 ; $716a
	ld c, (StarWarpFrameSprites - StarWarpSparkleTiles) / 16 ; $716d
	call QueueVRAMCopy ; $716f
	wram_bank WRAM_SCENE ; $7172
	xor a ; $7178
	ld hl, wStarWarpFrame ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	script_copy_scene_rect $00, $2b, $1a, $0c, $04, $02 ; $7192
	script_copy_scene_rect $04, $2d, $14, $14, $06, $02 ; $71a1
	script_copy_scene_rect $0a, $2b, $1a, $12, $06, $02 ; $71b0
	sound BGM_WIN ; $71bf
	ld a, $01 ; $71c1
	ld hl, UpdateStarWarpSprite ; $71c3
	call RegisterFrameTask ; $71c6
	wram_bank WRAM_SCENE ; $71c9
.waitLoop:
	call AdvanceFrame ; $71cf
	ld a, [wStarWarpCountdown] ; $71d2
	cp $1e ; $71d5
	jr z, .startFade ; $71d7
	or a ; $71d9
	jr nz, .waitLoop ; $71da
	pop_wram_bank ; $71dc
	ret ; $71e1
.startFade:
	ld c, $03 ; $71e2
	call BeginFadeOut ; $71e4
	jr .waitLoop ; $71e7
UpdateStarWarpSprite:
	wram_bank WRAM_SCENE ; $71e9
	ldh a, [hVBlankCounter] ; $71ef
	and $01 ; $71f1
	jr nz, .draw ; $71f3
	ld hl, wStarWarpFrame ; $71f5
	ld a, [hl] ; $71f8
	inc a ; $71f9
	cp $06 ; $71fa
	jr nz, .store ; $71fc
	xor a ; $71fe
.store:
	ld [hl], a ; $71ff
.draw:
	ld a, [wStarWarpFrame] ; $7200
	rlca ; $7203
	ld_hl_indexed StarWarpFrameSprites ; $7204
	push hl ; $720b
	ld c, [hl] ; $720c
	ld b, $09 ; $720d
	ld de, $8026 ; $720f
	call OffsetStarWarpPathPoint ; $7212
	call QueueSprite ; $7215
	pop hl ; $7218
	inc hl ; $7219
	ld c, [hl] ; $721a
	ld b, $09 ; $721b
	ld de, $8826 ; $721d
	call OffsetStarWarpPathPoint ; $7220
	push de ; $7223
	call QueueSprite ; $7224
	pop de ; $7227
	ld a, $fc ; $7228
	add d ; $722a
	ld d, a ; $722b
	ld hl, wStarWarpPathX ; $722c
	ld a, e ; $722f
	ld [hl+], a ; $7230
	ld [hl], d ; $7231
	call UpdateStarWarpTrailSparkles ; $7232
	ld hl, wStarWarpPathIndex ; $7235
	ld a, [hl] ; $7238
	inc a ; $7239
	inc a ; $723a
	ld [hl], a ; $723b
	ld hl, wStarWarpCountdown ; $723c
	ld a, [hl] ; $723f
	dec a ; $7240
	ld [hl], a ; $7241
	ret nz ; $7242
	ld hl, UpdateStarWarpSprite ; $7243
	call UnregisterFrameTask ; $7246
	ret ; $7249
OffsetStarWarpPathPoint:
	ld a, [wStarWarpPathIndex] ; $724a
	ld_hl_indexed StarWarpPathY ; $724d
	ld a, [hl] ; $7254
	add d ; $7255
	ld d, a ; $7256
	ld a, [wStarWarpPathIndex] ; $7257
	ld_hl_indexed StarWarpPathX ; $725a
	ld a, [hl] ; $7261
	add e ; $7262
	ld e, a ; $7263
	ret ; $7264
UpdateStarWarpTrailSparkles:
	ld c, $00 ; $7265
	ld hl, wStarWarpSparkleLife ; $7267
	ld b, $10 ; $726a
.findFreeSlot:
	ld a, [hl] ; $726c
	or a ; $726d
	jr z, .spawnSparkle ; $726e
	inc hl ; $7270
	inc c ; $7271
	dec b ; $7272
	jr nz, .findFreeSlot ; $7273
	jr .drawSparkles ; $7275
.spawnSparkle:
	ld [hl], $10 ; $7277
	ld a, c ; $7279
	rlca ; $727a
	add $14 ; $727b
	ld l, a ; $727d
	adc $d0 ; $727e
	sub l ; $7280
	ld h, a ; $7281
	ld a, [wStarWarpPathX] ; $7282
	ld [hl+], a ; $7285
	ld a, [wStarWarpPathY] ; $7286
	ld [hl], a ; $7289
	dec hl ; $728a
	push hl ; $728b
	ld a, [hl+] ; $728c
	ld d, [hl] ; $728d
	ld e, a ; $728e
	ldh a, [hVBlankCounter] ; $728f
	and $07 ; $7291
	push af ; $7293
	add d ; $7294
	ld d, a ; $7295
	pop af ; $7296
	add e ; $7297
	ld e, a ; $7298
	pop hl ; $7299
	ld a, e ; $729a
	ld [hl+], a ; $729b
	ld [hl], d ; $729c
.drawSparkles:
	ld hl, wStarWarpSparkleLife ; $729d
	ld b, $00 ; $72a0
	ld c, $10 ; $72a2
.drawLoop:
	push bc ; $72a4
	push hl ; $72a5
	ld a, [hl] ; $72a6
	or a ; $72a7
	jr z, .nextSparkle ; $72a8
	and $02 ; $72aa
	jr z, .nextSparkle ; $72ac
	ld a, b ; $72ae
	rlca ; $72af
	add $14 ; $72b0
	ld l, a ; $72b2
	adc $d0 ; $72b3
	sub l ; $72b5
	ld h, a ; $72b6
	ld a, [hl+] ; $72b7
	ld d, [hl] ; $72b8
	ld e, a ; $72b9
	ld b, $09 ; $72ba
	ld c, $18 ; $72bc
	call QueueSprite ; $72be
.nextSparkle:
	pop hl ; $72c1
	pop bc ; $72c2
	ld a, [hl] ; $72c3
	or a ; $72c4
	jr z, .done ; $72c5
	dec [hl] ; $72c7
.done:
	inc hl ; $72c8
	inc b ; $72c9
	dec c ; $72ca
	jr nz, .drawLoop ; $72cb
	ret ; $72cd
StarWarpPalette:
	INCLUDE "data/bank_00e/StarWarpPalette.asm" ; $72ce, 8 bytes (palettes)
	; $72d6, 10 bytes (fill)
	ds 10, $00
StarWarpTiles:
	INCBIN "data/bank_00e/StarWarpTiles.bin" ; $72e0, 384 bytes
StarWarpSparkleTiles:
	INCBIN "data/bank_00e/StarWarpSparkleTiles.bin" ; $7460, 32 bytes
StarWarpFrameSprites:
	; $7480, 12 bytes (bytes:2)
	db $00, $02 ; 0x00
	db $04, $06 ; 0x02
	db $08, $0a ; 0x04
	db $0c, $0e ; 0x06
	db $10, $12 ; 0x08
	db $14, $16 ; 0x0a
StarWarpPathY:
	; $748c, 181 bytes (bytes:16)
	db $00, $ff, $fd, $fb, $f9, $f7, $f5, $f3, $f0, $ee, $eb, $e9, $e6, $e4, $e1, $de ; 0x00
	db $db, $d9, $d6, $d3, $d0, $cd, $cb, $c8, $c5, $c3, $c0, $bd, $bb, $b8, $b6, $b3 ; 0x10
	db $b1, $ae, $ac, $a9, $a7, $a5, $a3, $a1, $9f, $9d, $9b, $99, $98, $96, $95, $94 ; 0x20
	db $92, $91, $90, $90, $8f, $8f, $8f, $8f, $8f, $8f, $90, $91, $93, $94, $96, $98 ; 0x30
	db $9b, $9d, $a0, $a2, $a5, $a8, $aa, $ad, $b0, $b3, $b5, $b8, $bb, $bd, $bf, $c1 ; 0x40
	db $c3, $c4, $c5, $c5, $c6, $c6, $c5, $c5, $c4, $c2, $c1, $bf, $bc, $ba, $b7, $b5 ; 0x50
	db $b2, $af, $ac, $aa, $a7, $a5, $a3, $a1, $9f, $9d, $9c, $9b, $9a, $99, $98, $97 ; 0x60
	db $96, $96, $95, $95, $95, $95, $95, $95, $96, $97, $97, $99, $9a, $9c, $9d, $a0 ; 0x70
	db $a2, $a4, $a7, $a9, $ac, $ae, $b1, $b4, $b7, $b9, $bc, $bf, $c2, $c4, $c7, $ca ; 0x80
	db $cd, $cf, $d2, $d5, $d8, $da, $dd, $e0, $e2, $e5, $e7, $ea, $ec, $ee, $f1, $f3 ; 0x90
	db $f5, $f8, $fa, $fc, $fe, $00, $01, $03, $05, $07, $09, $0b, $0d, $0e, $10, $12 ; 0xa0
	db $13, $15, $17, $18, $1a ; 0xb0
StarWarpPathX:
	; $7541, 181 bytes (bytes:16)
	db $00, $fe, $fc, $fa, $f8, $f6, $f4, $f3, $f1, $f0, $ef, $ee, $ed, $ec, $eb, $eb ; 0x00
	db $ea, $ea, $ea, $ea, $eb, $eb, $eb, $ec, $ec, $ed, $ee, $ef, $f0, $f1, $f2, $f3 ; 0x10
	db $f5, $f6, $f7, $f9, $fb, $fc, $fe, $00, $01, $03, $05, $07, $09, $0c, $0e, $11 ; 0x20
	db $13, $16, $19, $1b, $1e, $21, $23, $26, $29, $2c, $2e, $31, $33, $36, $38, $3a ; 0x30
	db $3b, $3d, $3e, $3f, $3f, $40, $40, $40, $3f, $3f, $3e, $3d, $3c, $3a, $39, $37 ; 0x40
	db $34, $32, $2f, $2d, $2a, $27, $24, $22, $1f, $1c, $1a, $18, $17, $15, $14, $14 ; 0x50
	db $13, $13, $14, $15, $16, $18, $19, $1c, $1e, $20, $22, $25, $27, $2a, $2d, $2f ; 0x60
	db $32, $35, $38, $3a, $3d, $40, $43, $45, $48, $4b, $4e, $50, $53, $55, $57, $59 ; 0x70
	db $5b, $5c, $5d, $5e, $5f, $60, $61, $61, $62, $62, $62, $62, $62, $62, $62, $62 ; 0x80
	db $61, $61, $60, $60, $5f, $5e, $5d, $5c, $5b, $5a, $59, $57, $56, $55, $53, $52 ; 0x90
	db $50, $4e, $4d, $4b, $49, $47, $45, $43, $41, $3f, $3d, $3b, $39, $37, $35, $32 ; 0xa0
	db $30, $2e, $2c, $29, $27 ; 0xb0
SpecialCourtMapScripts_0e:
	; $75f6, 14 bytes (map_tree)
	dw SpecialCourtEntryPoints_0e ; slot 0 EntryPoints
	dw SpecialCourtExitTriggers_0e ; slot 1 ExitTriggers
	dw SpecialCourtActors_0e ; slot 2 Actors
	dw SpecialCourtNpcScripts_0e ; slot 3 NpcScripts
	dw SpecialCourtFacingScripts_0e ; slot 4 FacingScripts
	dw SpecialCourtTileTriggers_0e ; slot 5 TileTriggers
	dw SpecialCourtInitScript_0e ; slot 6 InitScript
SpecialCourtActors_0e:
	; $7604, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0e_22, $0f00, $0500, FACE_DOWN, OBJ_PEACH, ANIM_WALK, $00, SPECIAL_COURT_PEACH
	map_actor $0000, ActorScript_0e_22, $1700, $0d00, FACE_LEFT, OBJ_LUIGI, ANIM_WALK, $00, SPECIAL_COURT_LUIGI
	map_actor $0000, ActorScript_0e_22, $1700, $0f00, FACE_LEFT, OBJ_BABY_MARIO, ANIM_WALK, $00, SPECIAL_COURT_BABY_MARIO
	map_actor $0000, ActorScript_0e_22, $1700, $1100, FACE_LEFT, OBJ_YOSHI, ANIM_WALK, $00, SPECIAL_COURT_YOSHI
	map_actor $0000, ActorScript_0e_22, $1700, $1900, FACE_LEFT, OBJ_DK, ANIM_WALK, $00, SPECIAL_COURT_DK
	map_actor $0000, ActorScript_0e_22, $0480, $0f00, FACE_RIGHT, OBJ_BOO, ANIM_WALK, $00, SPECIAL_COURT_BOO
	map_actor $0000, ActorScript_0e_22, $0500, $1100, FACE_RIGHT, OBJ_BOWSER, ANIM_WALK, $00, SPECIAL_COURT_BOWSER
	map_actor $0000, ActorScript_0e_22, $0500, $1900, FACE_RIGHT, OBJ_WARIO, ANIM_WALK, $00, SPECIAL_COURT_WARIO
	map_actor $0000, ActorScript_0e_22, $0500, $1b00, FACE_RIGHT, OBJ_WALUIGI, ANIM_WALK, $00, SPECIAL_COURT_WALUIGI
	map_actor $0000, ActorScript_0e_22, $0d00, $0500, FACE_DOWN, OBJ_WALK_77_05, ANIM_WALK, $00, SPECIAL_COURT_WALK_77_05
	map_actor $0000, ActorScript_0e_22, $0d00, $1700, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00, SPECIAL_COURT_MARIO
	map_actor $0000, ActorScript_0e_22, $0500, $1f00, FACE_UP, OBJ_TOAD, ANIM_WALK, $00, SPECIAL_COURT_TOAD
	map_actor $0000, ActorScript_0e_22, $0500, $0d00, FACE_RIGHT, OBJ_BOB_OMB, ANIM_WALK, $00, SPECIAL_COURT_BOB_OMB_1
	map_actor $0000, ActorScript_0e_22, $1700, $1b00, FACE_LEFT, OBJ_BOB_OMB, ANIM_WALK, $00, SPECIAL_COURT_BOB_OMB_2
	map_actor_end
SpecialCourtEntryPoints_0e:
	; $76d2, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0500, $2100, $0000
	db $ff
SpecialCourtExitTriggers_0e:
	; $76db, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, STORYLOC_RESTAURANT_PLAZA, $06
	db $ff
SpecialCourtNpcScripts_0e:
	ds 1, $ff ; $76e4, fill
SpecialCourtFacingScripts_0e:
	ds 1, $ff ; $76e5, fill
SpecialCourtTileTriggers_0e:
	ds 1, $ff ; $76e6, fill
SpecialCourtInitScript_0e:
	ld a, [wStoryModeEntryPoint] ; $76e7
	cp $07 ; $76ea
	jr c, .intro ; $76ec
	cp $0a ; $76ee
	jr z, .result ; $76f0
	ret ; $76f2
.result:
	call HandleExhibitionMatchResult ; $76f3
	ret ; $76f6
.intro:
	call ExhibitionMatchIntroCutscene ; $76f7
	ret ; $76fa
ExhibitionMatchIntroCutscene:
	xor a ; $76fb
	ld [wStoryModeShowLocationName], a ; $76fc
	ld a, [wStoryModeEntryPoint] ; $76ff
	dec a ; $7702
	ld [wMapScratch + 2], a ; $7703
	test_flag FLAG_DOUBLES ; $7706
	jp nz, .startMatch ; $7709
	script_set_speed ACTOR_SPECIAL_COURT_TOAD, $0014 ; $770c
	script_set_speed ACTOR_PLAYER, $0014 ; $7714
	script_set_position ACTOR_SPECIAL_COURT_TOAD, $0500, $2300 ; $771c
	script_set_position ACTOR_PLAYER, $0500, $2500 ; $7727
	script_set_position ACTOR_PARTNER, $0500, $2500 ; $7732
	script_move_target ACTOR_SPECIAL_COURT_TOAD, $0500, $1f00 ; $773d
	script_move_target ACTOR_PLAYER, $0500, $2100 ; $7748
	script_move_target ACTOR_PARTNER, $0500, $2300 ; $7753
	script_player_speed $0014 ; $775e
	script_move_player $0e00, $1b00 ; $7764
	script_fade_in $04 ; $776e
	call WaitFadeEnd ; $7773
	script_wait_move ACTOR_SPECIAL_COURT_TOAD ; $7776
	script_set_actor_script ACTOR_SPECIAL_COURT_TOAD, ActorScript_0e_16 ; $777b
	script_move_target ACTOR_PLAYER, $0500, $1f00 ; $7786
	script_wait_move ACTOR_PLAYER ; $7791
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_16 ; $7796
	script_wait_frames $5a ; $77a1
	script_move_player $0e00, $1700 ; $77a8
	script_wait_actor_script ACTOR_SPECIAL_COURT_TOAD ; $77b2
	script_set_speed ACTOR_SPECIAL_COURT_TOAD, $0020 ; $77b7
	script_set_actor_script ACTOR_SPECIAL_COURT_TOAD, ActorScript_0e_17 ; $77bf
	script_wait_actor_script ACTOR_SPECIAL_COURT_TOAD ; $77ca
	script_wait_frames $3c ; $77cf
	script_set_anim ACTOR_SPECIAL_COURT_MARIO, ANIM_NOD ; $77d6
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $77dd
	script_wait_idle ACTOR_PLAYER ; $77e4
	script_wait_frames $14 ; $77e9
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $77f0
	jr z, .doubles ; $77f3
	ld a, $01 ; $77f5
	ld [wUnusedExitTriggerIdMirror], a ; $77f7
	ld [wStoryModeExitTriggerRequest], a ; $77fa
	ret ; $77fd
.doubles:
	script_move_target ACTOR_PLAYER, $0f00, $1a00 ; $77fe
	script_wait_move ACTOR_PLAYER ; $7809
	script_move_target ACTOR_PLAYER, $0f00, $1700 ; $780e
	script_wait_move ACTOR_PLAYER ; $7819
	script_face ACTOR_SPECIAL_COURT_MARIO, FACE_UP ; $781e
	script_wait_frames $14 ; $7825
	script_player_speed $0020 ; $782c
	script_move_player $0e00, $0900 ; $7832
	farcall WaitPlayerMoveDone ; $783c
	script_wait_frames $14 ; $783f
	script_set_speed ACTOR_SPECIAL_COURT_PEACH, $0014 ; $7846
	script_move_target ACTOR_SPECIAL_COURT_PEACH, $0f00, $0700 ; $784e
	script_wait_move ACTOR_SPECIAL_COURT_PEACH ; $7859
	script_set_anim ACTOR_SPECIAL_COURT_PEACH, ANIM_NOD ; $785e
	script_wait_idle ACTOR_SPECIAL_COURT_PEACH ; $7865
	script_set_text Text_5e_169 ; $786a
	script_speak ACTOR_SPECIAL_COURT_PEACH ; $7870
	script_player_speed $0040 ; $7875
	script_move_player $0e00, $1400 ; $787b
	farcall WaitPlayerMoveDone ; $7885
	script_wait_frames $14 ; $7888
	script_face ACTOR_SPECIAL_COURT_MARIO, FACE_RIGHT ; $788f
	script_face ACTOR_PLAYER, FACE_LEFT ; $7896
	script_wait_frames $28 ; $789d
	script_set_anim ACTOR_SPECIAL_COURT_MARIO, ANIM_NOD ; $78a4
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $78ab
	script_wait_idle ACTOR_PLAYER ; $78b2
	script_wait_frames $14 ; $78b7
	script_set_speed ACTOR_PLAYER, $0020 ; $78be
	script_set_speed ACTOR_SPECIAL_COURT_MARIO, $0020 ; $78c6
	script_move_target ACTOR_PLAYER, $0f00, $1d00 ; $78ce
	script_move_target ACTOR_SPECIAL_COURT_MARIO, $0900, $1700 ; $78d9
	script_wait_move ACTOR_SPECIAL_COURT_MARIO ; $78e4
	script_move_target ACTOR_SPECIAL_COURT_MARIO, $0900, $0d00 ; $78e9
	script_wait_move ACTOR_PLAYER ; $78f4
	script_face ACTOR_PLAYER, FACE_UP ; $78f9
	script_wait_move ACTOR_SPECIAL_COURT_MARIO ; $7900
	script_move_target ACTOR_SPECIAL_COURT_MARIO, $0d00, $0d00 ; $7905
	script_wait_move ACTOR_SPECIAL_COURT_MARIO ; $7910
	script_face ACTOR_SPECIAL_COURT_MARIO, FACE_DOWN ; $7915
	script_wait_frames $28 ; $791c
	call PrepareStoryMatch ; $7923
	ret ; $7926
.startMatch:
	script_set_speed ACTOR_SPECIAL_COURT_TOAD, $0014 ; $7927
	script_set_speed ACTOR_PLAYER, $0014 ; $792f
	script_set_speed ACTOR_PARTNER, $0014 ; $7937
	script_set_position ACTOR_SPECIAL_COURT_PEACH, $0f00, $1700 ; $793f
	script_null_script ACTOR_PARTNER ; $794a
	script_set_position ACTOR_SPECIAL_COURT_TOAD, $0500, $2300 ; $794f
	script_set_position ACTOR_PLAYER, $0500, $2500 ; $795a
	script_set_position ACTOR_PARTNER, $0500, $2500 ; $7965
	script_move_target ACTOR_SPECIAL_COURT_TOAD, $0500, $1f00 ; $7970
	script_move_target ACTOR_PLAYER, $0500, $2100 ; $797b
	script_move_target ACTOR_PARTNER, $0500, $2300 ; $7986
	script_player_speed $0014 ; $7991
	script_move_player $0e00, $1b00 ; $7997
	script_fade_in $04 ; $79a1
	call WaitFadeEnd ; $79a6
	script_wait_move ACTOR_SPECIAL_COURT_TOAD ; $79a9
	script_set_actor_script ACTOR_SPECIAL_COURT_TOAD, ActorScript_0e_16 ; $79ae
	script_move_target ACTOR_PLAYER, $0500, $1f00 ; $79b9
	script_move_target ACTOR_PARTNER, $0500, $2100 ; $79c4
	script_wait_move ACTOR_PLAYER ; $79cf
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_16 ; $79d4
	script_move_target ACTOR_PARTNER, $0500, $1f00 ; $79df
	script_wait_move ACTOR_PARTNER ; $79ea
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_16 ; $79ef
	script_wait_frames $5a ; $79fa
	script_move_player $0e00, $1700 ; $7a01
	script_wait_actor_script ACTOR_SPECIAL_COURT_TOAD ; $7a0b
	script_set_speed ACTOR_SPECIAL_COURT_TOAD, $0020 ; $7a10
	script_set_actor_script ACTOR_SPECIAL_COURT_TOAD, ActorScript_0e_17 ; $7a18
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_22 ; $7a23
	script_move_target ACTOR_PARTNER, $0f00, $1b00 ; $7a2e
	script_wait_actor_script ACTOR_SPECIAL_COURT_TOAD ; $7a39
	script_wait_frames $3c ; $7a3e
	script_set_anim ACTOR_SPECIAL_COURT_PEACH, ANIM_NOD ; $7a45
	script_wait_idle ACTOR_SPECIAL_COURT_PEACH ; $7a4c
	script_wait_frames $14 ; $7a51
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $7a58
	jr z, .done ; $7a5b
	ld a, $01 ; $7a5d
	ld [wUnusedExitTriggerIdMirror], a ; $7a5f
	ld [wStoryModeExitTriggerRequest], a ; $7a62
	ret ; $7a65
.done:
	script_set_text Text_5e_170 ; $7a66
	script_speak ACTOR_SPECIAL_COURT_PEACH ; $7a6c
	script_wait_frames $14 ; $7a71
	script_set_anim ACTOR_SPECIAL_COURT_MARIO, ANIM_NOD ; $7a78
	script_set_anim ACTOR_SPECIAL_COURT_PEACH, ANIM_NOD ; $7a7f
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $7a86
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7a8d
	script_wait_idle ACTOR_PLAYER ; $7a94
	script_wait_frames $14 ; $7a99
	script_player_speed $0020 ; $7aa0
	script_move_player $0e00, $1400 ; $7aa6
	script_set_speed ACTOR_PLAYER, $0020 ; $7ab0
	script_set_speed ACTOR_PARTNER, $0020 ; $7ab8
	script_set_speed ACTOR_SPECIAL_COURT_MARIO, $0020 ; $7ac0
	script_set_speed ACTOR_SPECIAL_COURT_PEACH, $0020 ; $7ac8
	script_set_actor_script ACTOR_SPECIAL_COURT_MARIO, ActorScript_0e_18 ; $7ad0
	script_set_actor_script ACTOR_SPECIAL_COURT_PEACH, ActorScript_0e_19 ; $7adb
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_20 ; $7ae6
	script_set_actor_script ACTOR_PARTNER, ActorScript_0e_21 ; $7af1
	script_wait_actor_script ACTOR_SPECIAL_COURT_MARIO ; $7afc
	script_wait_actor_script ACTOR_SPECIAL_COURT_PEACH ; $7b01
	script_wait_frames $3c ; $7b06
	call PrepareStoryMatch ; $7b0d
	ret ; $7b10
