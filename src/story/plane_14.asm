ActorScript_14_1:
	; $563b, 21 bytes (actor_script)
	as_set_target 11.0, 41.0
	as_wait_move
	as_set_target 11.0, 39.0
	as_wait_move
	as_set_pos 1.0, 1.0
	as_halt
	as_halt
	as_halt
	as_halt
	ds ALIGN[4]
PlaneFrontObjTiles_14:
	INCBIN "data/story/PlaneFrontObjTiles_14.bin" ; $5650, 1024 bytes
	ds ALIGN[4]
PlaneRearObjTiles_14:
	INCBIN "data/story/PlaneRearObjTiles_14.bin" ; $5a50, 1024 bytes
PlaneSpriteTemplate_14:
	; $5e50, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
PlaneObjPalette_14:
	INCLUDE "data/story/PlaneObjPalette_14.asm" ; $5e71, 8 bytes (palettes)
LoadPlaneFrontObjGfx_14:
	push_wram_bank WRAM_STAGING ; $5e79
	ld hl, PlaneFrontObjTiles_14 ; $5e82
	ld de, vTiles0 + VRAM_BANK1 ; $5e85
	ld c, (PlaneRearObjTiles_14 - PlaneFrontObjTiles_14) / 16 + 32 ; $5e88
	call QueueVRAMCopy ; $5e8a
	ld hl, PlaneObjPalette_14 ; $5e8d
	ld_obj_pals de, 0, 1 ; $5e90
	call LoadPaletteShadow ; $5e93
	pop_wram_bank ; $5e96
	ret ; $5e9b
QueuePlaneSpriteByHeight_14:
	call GetSceneObjectScreenPos_14 ; $5e9c
	ld b, $00 ; $5e9f
	ld a, [wCutscenePlaneY] ; $5ea1
	sub $88 ; $5ea4
	cp $0a ; $5ea6
	jr c, .queueSpriteTemplate ; $5ea8
	ld b, $10 ; $5eaa
	cp $14 ; $5eac
	jr c, .queueSpriteTemplate ; $5eae
	ld b, $20 ; $5eb0
	cp $1e ; $5eb2
	jr c, .queueSpriteTemplate ; $5eb4
	ld b, $30 ; $5eb6
	cp $50 ; $5eb8
	jr c, .queueSpriteTemplate ; $5eba
	ld b, $20 ; $5ebc
	cp $78 ; $5ebe
	jr c, .queueSpriteTemplate ; $5ec0
	ld b, $10 ; $5ec2
.queueSpriteTemplate:
	ld c, b ; $5ec4
	ld hl, PlaneSpriteTemplate_14 ; $5ec5
	ld b, OAM_BANK1 ; $5ec8
	call QueueSpriteTemplate ; $5eca
	ret ; $5ecd
	; $5ece, 2 bytes (fill)
	ds 2, $00
	ds ALIGN[4]
WaterSplashObjGfx:
	INCBIN "data/story/WaterSplashObjGfx.bin" ; $5ed0, 448 bytes
WaterSplashSpriteTemplate_14:
	; $6090, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
WaterSplashObjPalette_14:
	INCLUDE "data/story/WaterSplashObjPalette_14.asm" ; $6099, 8 bytes (palettes)
LoadWaterSplashObjGfx_14:
	push_wram_bank WRAM_STAGING ; $60a1
	ld hl, WaterSplashObjGfx ; $60aa
	ld de, vTiles0 tile $20 ; $60ad
	ld c, (WaterSplashSpriteTemplate_14 - WaterSplashObjGfx) / 16 ; $60b0
	call QueueVRAMCopy ; $60b2
	ld hl, WaterSplashObjPalette_14 ; $60b5
	ld_obj_pals de, 1, 1 ; $60b8
	call LoadPaletteShadow ; $60bb
	pop_wram_bank ; $60be
	ret ; $60c3
UpdateWaterSplash0_14:
	ldh a, [hScrollX] ; $60c4
	ld b, a ; $60c6
	ld a, [wCutsceneObjX] ; $60c7
	sub b ; $60ca
	ld d, a ; $60cb
	ld a, [wCutsceneObjHalt] ; $60cc
	and a ; $60cf
	jr nz, .computeScreenY ; $60d0
	call AdvanceWaterSplash0Rise_14 ; $60d2
.computeScreenY:
	ldh a, [hScrollY] ; $60d5
	ld b, a ; $60d7
	ld a, [wCutsceneObjY] ; $60d8
	add $20 ; $60db
	sub b ; $60dd
	ld e, a ; $60de
	ld a, [wCutsceneObjHalt] ; $60df
	and a ; $60e2
	jp z, .checkRising ; $60e3
	ld a, [wCutsceneObjLimit] ; $60e6
	ld b, a ; $60e9
	ld a, [wCutsceneObjPhase] ; $60ea
	cp $14 ; $60ed
	jr c, .draw ; $60ef
	cp b ; $60f1
	jr c, .done ; $60f2
.checkRising:
	ld a, [wCutsceneObjRiseTimer] ; $60f4
	and a ; $60f7
	jr z, .tickFrame ; $60f8
	ld a, $08 ; $60fa
	ld [wCutsceneObjTimer], a ; $60fc
	ld a, $00 ; $60ff
	ld [wCutsceneObjPhase], a ; $6101
	jp .draw ; $6104
.tickFrame:
	ld a, [wCutsceneObjTimer] ; $6107
	inc a ; $610a
	ld [wCutsceneObjTimer], a ; $610b
	cp $08 ; $610e
	jr c, .checkFinished ; $6110
	cp $08 ; $6112
	jr z, .nextFrame ; $6114
	sound SFX_SPLASH ; $6116
.nextFrame:
	ld a, [wCutsceneObjX] ; $6118
	inc a ; $611b
	ld [wCutsceneObjX], a ; $611c
	xor a ; $611f
	ld [wCutsceneObjTimer], a ; $6120
	ld a, [wCutsceneObjPhase] ; $6123
	add $04 ; $6126
	ld [wCutsceneObjPhase], a ; $6128
.checkFinished:
	ld a, [wCutsceneObjLimit] ; $612b
	ld b, a ; $612e
	ld a, [wCutsceneObjPhase] ; $612f
	cp $14 ; $6132
	jr c, .draw ; $6134
	cp b ; $6136
	jr c, .done ; $6137
	xor a ; $6139
	ld [wCutsceneObjPhase], a ; $613a
	call AdvanceRandomSeed ; $613d
	ld a, l ; $6140
	and $0f ; $6141
	add a ; $6143
	add $40 ; $6144
	ld [wCutsceneObjX], a ; $6146
	ld a, h ; $6149
	and $3c ; $614a
	ld [wCutsceneObjLimit], a ; $614c
	ld a, h ; $614f
	and $0f ; $6150
	ld [wCutsceneObjY], a ; $6152
	ld a, $10 ; $6155
	ld [wCutsceneObjRiseTimer], a ; $6157
	jr .done ; $615a
.draw:
	ld a, [wCutsceneObjPhase] ; $615c
	add $20 ; $615f
	ld c, a ; $6161
	ld hl, WaterSplashSpriteTemplate_14 ; $6162
	ld b, 1 ; $6165
	call QueueSpriteTemplate ; $6167
.done:
	ret ; $616a
AdvanceWaterSplash0Rise_14:
	ld a, [wCutsceneObjRiseTimer] ; $616b
	and a ; $616e
	jr z, .done ; $616f
	dec a ; $6171
	ld [wCutsceneObjRiseTimer], a ; $6172
	ld a, [wCutsceneObjY] ; $6175
	sub $02 ; $6178
	ld [wCutsceneObjY], a ; $617a
.done:
	ret ; $617d
UpdateWaterSplash1_14:
	ldh a, [hScrollX] ; $617e
	ld b, a ; $6180
	ld a, [wCutsceneObjX + 1] ; $6181
	sub b ; $6184
	ld d, a ; $6185
	ld a, [wCutsceneObjHalt + 1] ; $6186
	and a ; $6189
	jr nz, .computeScreenY ; $618a
	call AdvanceWaterSplash1Rise_14 ; $618c
.computeScreenY:
	ldh a, [hScrollY] ; $618f
	ld b, a ; $6191
	ld a, [wCutsceneObjY + 1] ; $6192
	add $20 ; $6195
	sub b ; $6197
	ld e, a ; $6198
	ld a, [wCutsceneObjHalt + 1] ; $6199
	and a ; $619c
	jp z, .checkRising ; $619d
	ld a, [wCutsceneObjLimit + 1] ; $61a0
	ld b, a ; $61a3
	ld a, [wCutsceneObjPhase + 1] ; $61a4
	cp $14 ; $61a7
	jr c, .draw ; $61a9
	cp b ; $61ab
	jr c, .done ; $61ac
.checkRising:
	ld a, [wCutsceneObjRiseTimer + 1] ; $61ae
	and a ; $61b1
	jr z, .tickFrame ; $61b2
	ld a, $08 ; $61b4
	ld [wCutsceneObjTimer + 1], a ; $61b6
	ld a, $00 ; $61b9
	ld [wCutsceneObjPhase + 1], a ; $61bb
	jp .draw ; $61be
.tickFrame:
	ld a, [wCutsceneObjTimer + 1] ; $61c1
	inc a ; $61c4
	ld [wCutsceneObjTimer + 1], a ; $61c5
	cp $08 ; $61c8
	jr c, .checkFinished ; $61ca
	cp $08 ; $61cc
	jr z, .nextFrame ; $61ce
	sound SFX_SPLASH ; $61d0
.nextFrame:
	ld a, [wCutsceneObjX + 1] ; $61d2
	inc a ; $61d5
	ld [wCutsceneObjX + 1], a ; $61d6
	xor a ; $61d9
	ld [wCutsceneObjTimer + 1], a ; $61da
	ld a, [wCutsceneObjPhase + 1] ; $61dd
	add $04 ; $61e0
	ld [wCutsceneObjPhase + 1], a ; $61e2
.checkFinished:
	ld a, [wCutsceneObjLimit + 1] ; $61e5
	ld b, a ; $61e8
	ld a, [wCutsceneObjPhase + 1] ; $61e9
	cp $14 ; $61ec
	jr c, .draw ; $61ee
	cp b ; $61f0
	jr c, .done ; $61f1
	xor a ; $61f3
	ld [wCutsceneObjPhase + 1], a ; $61f4
	call AdvanceRandomSeed ; $61f7
	ld a, l ; $61fa
	and $0f ; $61fb
	add a ; $61fd
	add $40 ; $61fe
	ld [wCutsceneObjX + 1], a ; $6200
	ld a, l ; $6203
	and $3f ; $6204
	ld [wCutsceneObjLimit + 1], a ; $6206
	ld a, h ; $6209
	and $0f ; $620a
	ld [wCutsceneObjY + 1], a ; $620c
	ld a, $10 ; $620f
	ld [wCutsceneObjRiseTimer + 1], a ; $6211
	jr .done ; $6214
.draw:
	ld a, [wCutsceneObjPhase + 1] ; $6216
	add $20 ; $6219
	ld c, a ; $621b
	ld hl, WaterSplashSpriteTemplate_14 ; $621c
	ld b, 1 ; $621f
	call QueueSpriteTemplate ; $6221
.done:
	ret ; $6224
AdvanceWaterSplash1Rise_14:
	ld a, [wCutsceneObjRiseTimer + 1] ; $6225
	and a ; $6228
	jr z, .done ; $6229
	dec a ; $622b
	ld [wCutsceneObjRiseTimer + 1], a ; $622c
	ld a, [wCutsceneObjY + 1] ; $622f
	sub $02 ; $6232
	ld [wCutsceneObjY + 1], a ; $6234
.done:
	ret ; $6237
LoadPlaneRearObjGfx_14:
	push_wram_bank WRAM_STAGING ; $6238
	ld hl, PlaneRearObjTiles_14 ; $6241
	ld de, vTiles0 + VRAM_BANK1 ; $6244
	ld c, 96 ; $6247 -- PlaneRearObjTiles_14's 64 tiles, then 512 bytes of template, palette and code
	call QueueVRAMCopy ; $6249
	ld hl, PlaneObjPalette_14 ; $624c
	ld_obj_pals de, 0, 1 ; $624f
	call LoadPaletteShadow ; $6252
	pop_wram_bank ; $6255
	ret ; $625a
QueuePlaneSpriteByFrameCounter_14:
	call GetSceneObjectScreenPos_14 ; $625b
	ld b, $10 ; $625e
	ld a, [wCutsceneObjX] ; $6260
	cp $14 ; $6263
	jr c, .queue ; $6265
	ld b, $20 ; $6267
	cp $1e ; $6269
	jr c, .queue ; $626b
	ld b, $30 ; $626d
	cp $5a ; $626f
	jr c, .queue ; $6271
	ld b, $20 ; $6273
	cp $78 ; $6275
	jr c, .queue ; $6277
	ld b, $10 ; $6279
	cp $8c ; $627b
	jr c, .queue ; $627d
	ld b, $00 ; $627f
.queue:
	ld c, b ; $6281
	ld hl, PlaneSpriteTemplate_14 ; $6282
	ld b, OAM_BANK1 ; $6285
	call QueueSpriteTemplate ; $6287
	ret ; $628a
IslandSkyHomeFromIslandOpenScene:
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $628b
	call DisableLCDSafely ; $628e
	call LoadPlaneRearObjGfx_14 ; $6291
	call EnableLCD ; $6294
	ld a, $20 ; $6297
	ld [wCutscenePlaneX], a ; $6299
	ld a, $28 ; $629c
	ld [wCutscenePlaneY], a ; $629e
	ld a, $00 ; $62a1
	ld [wCutsceneObjX], a ; $62a3
	frame_task QueuePlaneSpriteByFrameCounter_14 ; $62a6
	script_set_actor_mode ACTOR_PLAYER, ACTORMODE_HIDDEN ; $62ae
	script_set_actor_mode ACTOR_ISLAND_SKY_HEADMASTER, ACTORMODE_HIDDEN ; $62b5
	test_flag FLAG_DOUBLES ; $62bc
	jp z, .fadeIn ; $62bf
	script_null_script ACTOR_PARTNER ; $62c2
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $62c7
.fadeIn:
	xor a ; $62d2
	ld [wStoryModeShowLocationName], a ; $62d3
	script_fade_in 6 ; $62d6
	call WaitFadeEnd ; $62db
	sound SFX_FIREWORK_LAUNCH ; $62de
	script_wait_frames 60 ; $62e0
	script_set_position ACTOR_PLAYER, 12.0, 19.0 ; $62e7
	ld h, $08 ; $62f2
.levelFlightLoop:
	script_wait_frames 6 ; $62f4
	call PlayPlaneMoveSfx_14 ; $62fb
	ld a, [wCutscenePlaneY] ; $62fe
	dec a ; $6301
	ld [wCutscenePlaneY], a ; $6302
	call AdvancePlaneFrameCounter_14 ; $6305
	dec h ; $6308
	jr nz, .levelFlightLoop ; $6309
	ld h, $08 ; $630b
.shallowFlightLoop:
	script_wait_frames 5 ; $630d
	call PlayPlaneMoveSfx_14 ; $6314
	ld a, h ; $6317
	and $01 ; $6318
	jr z, .shallowFlightStep ; $631a
	ld a, [wCutscenePlaneX] ; $631c
	inc a ; $631f
	ld [wCutscenePlaneX], a ; $6320
.shallowFlightStep:
	ld a, [wCutscenePlaneY] ; $6323
	dec a ; $6326
	ld [wCutscenePlaneY], a ; $6327
	call AdvancePlaneFrameCounter_14 ; $632a
	dec h ; $632d
	jr nz, .shallowFlightLoop ; $632e
	ld h, $08 ; $6330
.steepFlightLoop:
	script_wait_frames 4 ; $6332
	call PlayPlaneMoveSfx_14 ; $6339
	ld a, [wCutscenePlaneX] ; $633c
	inc a ; $633f
	ld [wCutscenePlaneX], a ; $6340
	ld a, [wCutscenePlaneY] ; $6343
	dec a ; $6346
	ld [wCutscenePlaneY], a ; $6347
	call AdvancePlaneFrameCounter_14 ; $634a
	dec h ; $634d
	jr nz, .steepFlightLoop ; $634e
	script_player_speed 0.5625 ; $6350
	script_move_player_to_actor ACTOR_PLAYER ; $6356
	ld h, $1c ; $635d
.boardFlightLoop:
	script_wait_frames 3 ; $635f
	call PlayPlaneMoveSfx_14 ; $6366
	ld a, h ; $6369
	and $01 ; $636a
	jr z, .boardFlightStep ; $636c
	ld a, [wCutscenePlaneX] ; $636e
	inc a ; $6371
	ld [wCutscenePlaneX], a ; $6372
.boardFlightStep:
	ld a, [wCutscenePlaneY] ; $6375
	dec a ; $6378
	ld [wCutscenePlaneY], a ; $6379
	call AdvancePlaneFrameCounter_14 ; $637c
	dec h ; $637f
	jr nz, .boardFlightLoop ; $6380
	ld h, $00 ; $6382
.climbOutLoop:
	script_wait_frames 3 ; $6384
	inc h ; $638b
	call PlayPlaneMoveSfx_14 ; $638c
	ld a, [wCutscenePlaneY] ; $638f
	dec a ; $6392
	ld [wCutscenePlaneY], a ; $6393
	and $03 ; $6396
	cp $03 ; $6398
	jr nz, .climbOutStep ; $639a
	ld a, [wCutscenePlaneX] ; $639c
	inc a ; $639f
	ld [wCutscenePlaneX], a ; $63a0
.climbOutStep:
	call AdvancePlaneFrameCounter_14 ; $63a3
	ld a, [wCutscenePlaneX] ; $63a6
	cp $50 ; $63a9
	jr nz, .climbOutLoop ; $63ab
	ld h, $08 ; $63ad
.riseLoop:
	script_wait_frames 4 ; $63af
	call PlayPlaneMoveSfx_14 ; $63b6
	ld a, [wCutscenePlaneY] ; $63b9
	dec a ; $63bc
	ld [wCutscenePlaneY], a ; $63bd
	call AdvancePlaneFrameCounter_14 ; $63c0
	dec h ; $63c3
	jr nz, .riseLoop ; $63c4
	ld h, $08 ; $63c6
.slowRiseLoop:
	script_wait_frames 6 ; $63c8
	call PlayPlaneMoveSfx_14 ; $63cf
	ld a, [wCutscenePlaneY] ; $63d2
	dec a ; $63d5
	ld [wCutscenePlaneY], a ; $63d6
	call AdvancePlaneFrameCounter_14 ; $63d9
	dec h ; $63dc
	jr nz, .slowRiseLoop ; $63dd
	ld h, $08 ; $63df
.slowestRiseLoop:
	script_wait_frames 8 ; $63e1
	call PlayPlaneMoveSfx_14 ; $63e8
	ld a, [wCutscenePlaneY] ; $63eb
	dec a ; $63ee
	ld [wCutscenePlaneY], a ; $63ef
	call AdvancePlaneFrameCounter_14 ; $63f2
	dec h ; $63f5
	jr nz, .slowestRiseLoop ; $63f6
	sound SFX_FIREWORK_SPARKLE ; $63f8
	script_wait_frames 50 ; $63fa
	script_fade_out 4 ; $6401
	call WaitFadeEnd ; $6406
	call ClearFrameTasks ; $6409
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $640c
	ld [wStoryModeCurrentLocation], a ; $640e
	ld a, ENTRY_ACADEMY_ENTRANCE_FROM_ISLAND_SKY ; $6411
	ld [wStoryModeEntryPoint], a ; $6413
	ld a, EXITTRIGGER_DIRECT ; $6416
	ld [wUnusedExitTriggerIdMirror], a ; $6418
	ld [wStoryModeExitTriggerRequest], a ; $641b
	ret ; $641e
	twin_named advance_plane_frame_counter, AdvancePlaneFrameCounter_14 ; $641f
