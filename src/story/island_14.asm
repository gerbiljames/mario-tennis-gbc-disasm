IslandSkyTilesA_14:
	INCBIN "data/bank_014/IslandSkyTilesA_14.bin" ; $7190, 256 bytes
IslandSkyTilesB_14:
	INCBIN "data/bank_014/IslandSkyTilesB_14.bin" ; $7290, 192 bytes
IslandSkySpriteData_14:
	INCBIN "data/bank_014/IslandSkySpriteData_14.bin" ; $7350, 33 bytes
AnimateIslandSkyEffectSprites_14_SpriteTemplate:
	; $7371, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
IslandSkyPalettes_14:
	INCLUDE "data/bank_014/IslandSkyPalettes_14.asm" ; $738a, 32 bytes (palettes)
LoadIslandSkyEffectObjGfx_14:
	push_wram_bank WRAM_STAGING ; $73aa
	ld hl, IslandSkyTilesA_14 ; $73b3
	ld de, vTiles0 + $10 * TILE_SIZE ; $73b6
	ld c, $40 ; $73b9
	call QueueVRAMCopy ; $73bb
	ld hl, IslandSkyTilesB_14 ; $73be
	ld de, vTiles0 + $20 * TILE_SIZE ; $73c1
	ld c, $30 ; $73c4
	call QueueVRAMCopy ; $73c6
	ld hl, IslandSkyPalettes_14 ; $73c9
	lb de, $09, $03 ; $73cc palette index, count
	call LoadPaletteShadow ; $73cf
	pop_wram_bank ; $73d2
	ret ; $73d7
AnimateIslandSkyEffectSprites_14:
	ldh a, [hScrollX] ; $73d8
	ld b, a ; $73da
	ld a, $40 ; $73db
	sub b ; $73dd
	ld d, a ; $73de
	ldh a, [hScrollY] ; $73df
	ld b, a ; $73e1
	ld a, $40 ; $73e2
	sub b ; $73e4
	ld e, a ; $73e5
	ld c, $10 ; $73e6
	ld hl, IslandSkySpriteData_14 ; $73e8
	ld a, [wCutsceneObjActive] ; $73eb
	and a ; $73ee
	jr nz, .nonZero ; $73ef
	ld a, [wCutsceneObjLimit] ; $73f1
	inc a ; $73f4
	ld [wCutsceneObjLimit], a ; $73f5
.nonZero:
	ld a, [wCutsceneObjLimit] ; $73f8
	swap a ; $73fb
	and $03 ; $73fd
	cp $03 ; $73ff
	jr nz, .ne03 ; $7401
	ld a, $00 ; $7403
	ld [wCutsceneObjLimit], a ; $7405
.ne03:
	inc a ; $7408
	ld b, a ; $7409
	call QueueSpriteTemplate ; $740a
	ldh a, [hScrollX] ; $740d
	ld b, a ; $740f
	ld a, $68 ; $7410
	sub b ; $7412
	ld d, a ; $7413
	ldh a, [hScrollY] ; $7414
	ld b, a ; $7416
	ld a, $50 ; $7417
	sub b ; $7419
	ld e, a ; $741a
	ld c, $20 ; $741b
	ld hl, AnimateIslandSkyEffectSprites_14_SpriteTemplate ; $741d
	ld a, [wCutsceneObjLimit] ; $7420
	swap a ; $7423
	and $03 ; $7425
	inc a ; $7427
	ld b, a ; $7428
	call QueueSpriteTemplate ; $7429
	ret ; $742c
	; $742d, 3 bytes (fill)
	ds 3, $00
DistantPlaneObjGfx:
	INCBIN "data/bank_014/DistantPlaneObjGfx.bin" ; $7430, 256 bytes
SpriteTemplate_14_3:
	; $7530, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
LoadDistantPlaneObjGfx_14:
	push_wram_bank WRAM_STAGING ; $7539
	ld hl, DistantPlaneObjGfx ; $7542
	ld de, vTiles0 + VRAM_BANK1 ; $7545
	ld c, (SpriteTemplate_14_3 - DistantPlaneObjGfx) / 16 ; $7548
	call QueueVRAMCopy ; $754a
	ld hl, IslandObjPalette_14 ; $754d
	lb de, $08, $01 ; $7550 palette index, count
	call LoadPaletteShadow ; $7553
	pop_wram_bank ; $7556
	ret ; $755b
QueueDistantPlaneSprite_14:
	call GetSceneObjectScreenPos_14 ; $755c
	ld a, [wCutsceneObjPhase] ; $755f
	ld c, a ; $7562
	ld c, a ; $7563
	ld hl, SpriteTemplate_14_3 ; $7564
	ld b, $08 ; $7567
	call QueueSpriteTemplate ; $7569
	ret ; $756c
GetSceneObjectScreenPos_14:
	ldh a, [hScrollX] ; $756d
	ld b, a ; $756f
	ld a, [wMapSceneStage] ; $7570
	sub b ; $7573
	ld d, a ; $7574
	ldh a, [hScrollY] ; $7575
	ld b, a ; $7577
	ld a, [wMapSceneStage2] ; $7578
	sub b ; $757b
	ld e, a ; $757c
	ret ; $757d
	; $757e, 2 bytes (fill)
	ds 2, $00
TwinkleObjGfx:
	INCBIN "data/bank_014/TwinkleObjGfx.bin" ; $7580, 256 bytes
TwinkleObjPalette_14:
	INCLUDE "data/bank_014/TwinkleObjPalette_14.asm" ; $7680, 8 bytes (palettes)
LoadTwinkleObjGfx_14:
	push_wram_bank WRAM_STAGING ; $7688
	ld hl, TwinkleObjGfx ; $7691
	ld de, vTiles0 + VRAM_BANK1 ; $7694
	ld c, (TwinkleObjPalette_14 - TwinkleObjGfx) / 16 ; $7697
	call QueueVRAMCopy ; $7699
	ld hl, TwinkleObjPalette_14 ; $769c
	lb de, $08, $01 ; $769f palette index, count
	call LoadPaletteShadow ; $76a2
	pop_wram_bank ; $76a5
	ret ; $76aa
QueueTwinkleSprite_14:
	ldh a, [hScrollX] ; $76ab
	ld b, a ; $76ad
	ld a, $54 ; $76ae
	sub b ; $76b0
	ld d, a ; $76b1
	ldh a, [hScrollY] ; $76b2
	ld b, a ; $76b4
	ld a, $58 ; $76b5
	sub b ; $76b7
	ld e, a ; $76b8
	ld a, [wCutsceneObjPhase] ; $76b9
	ld c, a ; $76bc
	ld hl, SpriteTemplate_14_3 ; $76bd
	ld b, $08 ; $76c0
	call QueueSpriteTemplate ; $76c2
	ret ; $76c5
.queue:
	call DisableLCDSafely ; $76c6
	call LoadIslandSkyEffectObjGfx_14 ; $76c9
	call LoadTwinkleObjGfx_14 ; $76cc
	call EnableLCD ; $76cf
	ld a, $00 ; $76d2
	ld [wCutsceneObjLimit], a ; $76d4
	ld [wCutsceneObjLimit + 1], a ; $76d7
	ld a, $01 ; $76da
	ld hl, AnimateIslandSkyEffectSprites_14 ; $76dc
	call RegisterFrameTask ; $76df
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $76e2
	test_flag FLAG_DOUBLES ; $76ed
	jp z, .loadScene ; $76f0
	script_null_script ACTOR_PARTNER ; $76f3
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $76f8
.loadScene:
	xor a ; $7703
	ld [wStoryModeShowLocationName], a ; $7704
	script_fade_in $06 ; $7707
	call WaitFadeEnd ; $770c
	script_wait_frames $3c ; $770f
	call PlayTwinkleAnimation_14 ; $7716
	script_wait_frames $1e ; $7719
	call LoadDistantPlaneObjGfx_14 ; $7720
	ld a, $08 ; $7723
	ld [wCutsceneObjPhase], a ; $7725
	ld a, $54 ; $7728
	ld [wMapSceneStage], a ; $772a
	ld a, $58 ; $772d
	ld [wMapSceneStage2], a ; $772f
	ld a, $01 ; $7732
	ld hl, QueueDistantPlaneSprite_14 ; $7734
	call RegisterFrameTask ; $7737
	ld h, $4b ; $773a
.fadeIn:
	script_wait_frames $02 ; $773c
	call PlayPlaneMoveSfx_14 ; $7743
	ld a, [wMapSceneStage2] ; $7746
	inc a ; $7749
	ld [wMapSceneStage2], a ; $774a
	ld a, [wMapSceneStage] ; $774d
	inc a ; $7750
	ld [wMapSceneStage], a ; $7751
	ld a, h ; $7754
	cp $2d ; $7755
	jr nz, .fireworkLoop ; $7757
	ld a, $0c ; $7759
	ld [wCutsceneObjPhase], a ; $775b
.fireworkLoop:
	dec h ; $775e
	jr nz, .fadeIn ; $775f
	ld hl, QueueDistantPlaneSprite_14 ; $7761
	call UnregisterFrameTask ; $7764
	script_player_speed $0012 ; $7767
	script_move_player $0b00, $1800 ; $776d
	ld h, $3c ; $7777
.burst:
	script_wait_frames $02 ; $7779
	call PlayPlaneMoveSfx_14 ; $7780
	dec h ; $7783
	jr nz, .burst ; $7784
	call LoadPlaneObjGfx2_14 ; $7786
	ld a, $a4 ; $7789
	ld [wMapSceneStage], a ; $778b
	ld a, $c6 ; $778e
	ld [wMapSceneStage2], a ; $7790
	ld a, $3c ; $7793
	ld [wCutsceneObjX], a ; $7795
	ld a, $01 ; $7798
	ld hl, QueuePlaneSpriteByFrameCounter_14 ; $779a
	call RegisterFrameTask ; $779d
	ld h, $20 ; $77a0
.nextBurst:
	script_wait_frames $02 ; $77a2
	call PlayPlaneMoveSfx_14 ; $77a9
	ld a, [wMapSceneStage] ; $77ac
	dec a ; $77af
	ld [wMapSceneStage], a ; $77b0
	and $03 ; $77b3
	cp $03 ; $77b5
	jr nz, .finale ; $77b7
	ld a, [wMapSceneStage2] ; $77b9
	dec a ; $77bc
	ld [wMapSceneStage2], a ; $77bd
.finale:
	call AdvancePlaneFrameCounter2_14 ; $77c0
	dec h ; $77c3
	jr nz, .nextBurst ; $77c4
	ld h, $18 ; $77c6
.finaleLoop:
	script_wait_frames $02 ; $77c8
	call PlayPlaneMoveSfx_14 ; $77cf
	ld a, [wMapSceneStage] ; $77d2
	dec a ; $77d5
	ld [wMapSceneStage], a ; $77d6
	and $01 ; $77d9
	ld b, a ; $77db
	ld a, [wMapSceneStage2] ; $77dc
	sub b ; $77df
	ld [wMapSceneStage2], a ; $77e0
	call AdvancePlaneFrameCounter2_14 ; $77e3
	dec h ; $77e6
	jr nz, .finaleLoop ; $77e7
	script_move_player $0b00, $1200 ; $77e9
	ld h, $18 ; $77f3
.speak:
	script_wait_frames $03 ; $77f5
	call PlayPlaneMoveSfx_14 ; $77fc
	ld a, [wMapSceneStage2] ; $77ff
	dec a ; $7802
	ld [wMapSceneStage2], a ; $7803
	ld a, [wMapSceneStage] ; $7806
	dec a ; $7809
	ld [wMapSceneStage], a ; $780a
	call AdvancePlaneFrameCounter2_14 ; $780d
	dec h ; $7810
	jr nz, .speak ; $7811
	ld h, $08 ; $7813
.fadeOut:
	script_wait_frames $04 ; $7815
	call PlayPlaneMoveSfx_14 ; $781c
	ld a, [wMapSceneStage2] ; $781f
	dec a ; $7822
	ld [wMapSceneStage2], a ; $7823
	and $01 ; $7826
	ld b, a ; $7828
	ld a, [wMapSceneStage] ; $7829
	sub b ; $782c
	ld [wMapSceneStage], a ; $782d
	call AdvancePlaneFrameCounter2_14 ; $7830
	dec h ; $7833
	jr nz, .fadeOut ; $7834
	ld h, $0c ; $7836
.done:
	script_wait_frames $06 ; $7838
	call PlayPlaneMoveSfx_14 ; $783f
	ld a, [wMapSceneStage2] ; $7842
	dec a ; $7845
	ld [wMapSceneStage2], a ; $7846
	call AdvancePlaneFrameCounter2_14 ; $7849
	dec h ; $784c
	jr nz, .done ; $784d
	sound SFX_FIREWORK_SPARKLE ; $784f
	script_wait_frames $46 ; $7851
	ld c, $04 ; $7858
	call BeginFadeOut ; $785a
	call WaitFadeEnd ; $785d
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [wStoryModeEntryPoint], a ; $7867
	ld a, $ff ; $786a
	ld [wUnusedExitTriggerIdMirror], a ; $786c
	ld [wStoryModeExitTriggerRequest], a ; $786f
	ret ; $7872
AdvancePlaneFrameCounter2_14:
	ld a, [wCutsceneObjX] ; $7873
	inc a ; $7876
	ld [wCutsceneObjX], a ; $7877
	ret ; $787a
PlayTwinkleAnimation_14:
	xor a ; $787b
	ld [wCutsceneObjPhase], a ; $787c
	call AdvanceFrame ; $787f
	ld a, $01 ; $7882
	ld hl, QueueTwinkleSprite_14 ; $7884
	call RegisterFrameTask ; $7887
	sound SFX_TWINKLE ; $788a
	ld h, $04 ; $788c
.loop:
	script_wait_frames $04 ; $788e
	ld a, [wCutsceneObjPhase] ; $7895
	add $04 ; $7898
	ld [wCutsceneObjPhase], a ; $789a
	dec h ; $789d
	jr nz, .loop ; $789e
	ld hl, QueueTwinkleSprite_14 ; $78a0
	call UnregisterFrameTask ; $78a3
	ret ; $78a6
PlayPlaneMoveSfx_14:
	ld a, h ; $78a7
	srl a ; $78a8
	and $01 ; $78aa
	jr z, .done ; $78ac
	sound SFX_PLANE ; $78ae
.done:
	ret ; $78b0
ActorScript_14_2:
	; $78b1, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_14_3:
	; $78bb, 30 bytes (actor_script)
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
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L15
MapScriptNop_14:
	ret ; $78d9
MapScriptClearActiveFlag_14:
	xor a ; $78da
	ld [wStoryScriptRan], a ; $78db
	ret ; $78de
MapScriptPlaySoundA2_14:
	sound SFX_STORY_CUE ; $78df
	ret ; $78e1
MapScriptHideLocationName_14:
	xor a ; $78e2
	ld [wStoryModeShowLocationName], a ; $78e3
	ret ; $78e6
ActorScript_14_4:
	; $78e7, 438 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_14_4
	as_anim $00
	as_wait $3c
.L67:
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L67
	as_anim $00
	as_wait $1e
.Lce:
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump .Lce
	as_anim $00
	as_wait $1e
	as_wait $3c
.L137:
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L137
.L19a:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L19a
.L1a7:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L1a7
; Instruction-identical to ComputeRankingProgressIndex_13 and ComputeRankingProgressIndex_15 (one copy per bank); a change here belongs in every copy.
	twin compute_ranking_progress_index_13, 14 ; $7a9d ComputeRankingProgressIndex_14
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_14_ComputeStoryRankTier:
	ld a, $00 ; $7ae4
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7ae6
	jr z, .loopB ; $7ae9
	inc a ; $7aeb
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7aec
	jr z, .loopB ; $7aef
	inc a ; $7af1
	test_flag FLAG_DOUBLES ; $7af2
	jr nz, .checkFlag ; $7af5
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7af7
	jr z, .loopB ; $7afa
	inc a ; $7afc
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7afd
	jr z, .loopB ; $7b00
	inc a ; $7b02
.loopB:
	ld [wMapSceneStage], a ; $7b03
	ret ; $7b06
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7b07
	jr z, .loopB ; $7b0a
	inc a ; $7b0c
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7b0d
	jr z, .loopB ; $7b10
	inc a ; $7b12
	jr .loopB ; $7b13
	; $7b15, 1259 bytes fill to bank end (linker-padded)
