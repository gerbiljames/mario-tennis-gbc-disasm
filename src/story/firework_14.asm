LoadFireworkObjGfx_14:
	push_wram_bank WRAM_STAGING ; $6427
	ld hl, FireworkObjTiles_14 ; $6430
	ld de, vTiles0 tile $10 ; $6433
	ld c, (FireworkSpriteTemplate_14 - FireworkObjTiles_14) / 16 ; $6436
	call QueueVRAMCopy ; $6438
	ld hl, FireworkObjPalettes_14 ; $643b
	ld_obj_pals de, 1, 4 ; $643e
	call LoadPaletteShadow ; $6441
	pop_wram_bank ; $6444
	ret ; $6449
UpdateFirework0_14:
	ld a, [wCutsceneObjPhase] ; $644a
	cp $04 ; $644d
	jp nc, .done ; $644f
	ld a, [wCutsceneObjPhase] ; $6452
	and a ; $6455
	jr nz, .draw ; $6456
	call AdvanceFirework0Ascent_14 ; $6458
.draw:
	ldh a, [hScrollX] ; $645b
	ld b, a ; $645d
	ld a, [wCutsceneObjX] ; $645e
	sub b ; $6461
	ld d, a ; $6462
	ldh a, [hScrollY] ; $6463
	ld b, a ; $6465
	ld a, [wCutsceneObjY] ; $6466
	sub b ; $6469
	ld e, a ; $646a
	ld a, [wCutsceneObjTimer] ; $646b
	dec a ; $646e
	ld [wCutsceneObjTimer], a ; $646f
	and a ; $6472
	jp nz, .burstSprite ; $6473
	ld a, [wCutsceneObjPhase] ; $6476
	inc a ; $6479
	ld [wCutsceneObjPhase], a ; $647a
	cp $04 ; $647d
	jp nc, .done ; $647f
	ld a, [wCutsceneObjPhase] ; $6482
	ld_hl_indexed FireworkPhaseDurations_14 ; $6485
	ld a, [hl] ; $648c
	ld [wCutsceneObjTimer], a ; $648d
	ld a, [wCutsceneObjPhase] ; $6490
	cp $01 ; $6493
	jr nz, .burstSprite ; $6495
	ld a, [wCutsceneObjTimer] ; $6497
	cp $0c ; $649a
	jr nz, .burstSprite ; $649c
	sound SFX_FIREWORK ; $649e
.burstSprite:
	ld a, [wCutsceneObjPhase] ; $64a0
	ld_hl_indexed FireworkPhaseTileBases0_14 ; $64a3
	ld a, [hl] ; $64aa
	add $10 ; $64ab
	ld c, a ; $64ad
	ld a, [wCutsceneObjTimer] ; $64ae
	srl a ; $64b1
	and $03 ; $64b3
	inc a ; $64b5
	ld b, a ; $64b6
	ld hl, FireworkSpriteTemplate_14 ; $64b7
	call QueueSpriteTemplate ; $64ba
.done:
	ret ; $64bd
AdvanceFirework0Ascent_14:
	ld b, $03 ; $64be
	ld a, [wCutsceneObjTimer] ; $64c0
	cp $14 ; $64c3
	jr nc, .rise ; $64c5
	dec b ; $64c7
	cp $0a ; $64c8
	jr nc, .rise ; $64ca
	dec b ; $64cc
.rise:
	ld a, [wCutsceneObjY] ; $64cd
	sub b ; $64d0
	ld [wCutsceneObjY], a ; $64d1
	ret ; $64d4
FireworkPhaseDurations_14:
	; $64d5, 4 bytes (bytes:4)
	db $00, $0c, $0e, $10 ; 0x00
FireworkPhaseTileBases0_14:
	INCLUDE "data/story/FireworkPhaseTileBases0_14.asm" ; $64d9, 4 bytes (bytes:4)
FireworkPhaseTileBases1_14:
	INCLUDE "data/story/FireworkPhaseTileBases1_14.asm" ; $64dd, 4 bytes (bytes:4)
IslandSkyVictoryFireworksScene:
	script_respawn_actors FireworkMapActors_14 ; $64e1
	farcall BeginCutsceneScriptMode ; $64e9
	call DisableLCDSafely ; $64ec
	call LoadFireworkObjGfx_14 ; $64ef
	call EnableLCD ; $64f2
	test_flag FLAG_DOUBLES ; $64f5
	jp z, .hidePlayer ; $64f8
	script_null_script ACTOR_PARTNER ; $64fb
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $6500
.hidePlayer:
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $650b
	xor a ; $6516
	ld [wStoryModeShowLocationName], a ; $6517
	script_fade_in 4 ; $651a
	call WaitFadeEnd ; $651f
	script_player_speed 0.1875 ; $6522
	script_move_player 5.0, 35.0 ; $6528
	farcall WaitPlayerMoveDone ; $6532
	script_wait_frames 50 ; $6535
	ld a, $50 ; $653c
	ld [wCutsceneObjX + 1], a ; $653e
	ld a, $28 ; $6541
	ld [wCutsceneObjY + 1], a ; $6543
	ld a, $00 ; $6546
	ld [wCutsceneObjPhase + 1], a ; $6548
	ld a, $1e ; $654b
	ld [wCutsceneObjTimer + 1], a ; $654d
	frame_task UpdateFirework1_14 ; $6550
	script_wait_frames 80 ; $6558
	ld a, $40 ; $655f
	ld [wCutsceneObjX], a ; $6561
	ld a, $20 ; $6564
	ld [wCutsceneObjY], a ; $6566
	ld a, $00 ; $6569
	ld [wCutsceneObjPhase], a ; $656b
	ld a, $1e ; $656e
	ld [wCutsceneObjTimer], a ; $6570
	frame_task UpdateFirework0_14 ; $6573
	script_wait_frames 80 ; $657b
	ld a, $48 ; $6582
	ld [wCutsceneObjX + 1], a ; $6584
	ld a, $28 ; $6587
	ld [wCutsceneObjY + 1], a ; $6589
	ld a, $00 ; $658c
	ld [wCutsceneObjPhase + 1], a ; $658e
	ld a, $1e ; $6591
	ld [wCutsceneObjTimer + 1], a ; $6593
	script_wait_frames 40 ; $6596
	ld a, $38 ; $659d
	ld [wCutsceneObjX], a ; $659f
	ld a, $20 ; $65a2
	ld [wCutsceneObjY], a ; $65a4
	ld a, $00 ; $65a7
	ld [wCutsceneObjPhase], a ; $65a9
	ld a, $1e ; $65ac
	ld [wCutsceneObjTimer], a ; $65ae
	script_wait_frames 40 ; $65b1
	ld a, $50 ; $65b8
	ld [wCutsceneObjX + 1], a ; $65ba
	ld a, $28 ; $65bd
	ld [wCutsceneObjY + 1], a ; $65bf
	ld a, $00 ; $65c2
	ld [wCutsceneObjPhase + 1], a ; $65c4
	ld a, $19 ; $65c7
	ld [wCutsceneObjTimer + 1], a ; $65c9
	script_wait_frames 40 ; $65cc
	ld a, $38 ; $65d3
	ld [wCutsceneObjX], a ; $65d5
	ld a, $20 ; $65d8
	ld [wCutsceneObjY], a ; $65da
	ld a, $00 ; $65dd
	ld [wCutsceneObjPhase], a ; $65df
	ld a, $1a ; $65e2
	ld [wCutsceneObjTimer], a ; $65e4
	script_wait_frames 40 ; $65e7
	ld a, $58 ; $65ee
	ld [wCutsceneObjX + 1], a ; $65f0
	ld a, $28 ; $65f3
	ld [wCutsceneObjY + 1], a ; $65f5
	ld a, $00 ; $65f8
	ld [wCutsceneObjPhase + 1], a ; $65fa
	ld a, $1c ; $65fd
	ld [wCutsceneObjTimer + 1], a ; $65ff
	script_wait_frames 40 ; $6602
	ld a, $40 ; $6609
	ld [wCutsceneObjX], a ; $660b
	ld a, $20 ; $660e
	ld [wCutsceneObjY], a ; $6610
	ld a, $00 ; $6613
	ld [wCutsceneObjPhase], a ; $6615
	ld a, $16 ; $6618
	ld [wCutsceneObjTimer], a ; $661a
	script_wait_frames 50 ; $661d
	ld a, $48 ; $6624
	ld [wCutsceneObjX + 1], a ; $6626
	ld a, $28 ; $6629
	ld [wCutsceneObjY + 1], a ; $662b
	ld a, $00 ; $662e
	ld [wCutsceneObjPhase + 1], a ; $6630
	ld a, $1c ; $6633
	ld [wCutsceneObjTimer + 1], a ; $6635
	script_wait_frames 72 ; $6638
	script_fade_out 4 ; $663f
	call WaitFadeEnd ; $6644
	call ClearFrameTasks ; $6647
	test_flag FLAG_DOUBLES ; $664a
	jr z, .notDoubles ; $664d
	ld a, STORYLOC_AWARDS_CEREMONY ; $664f
	ld [wStoryModeCurrentLocation], a ; $6651
	ld a, ENTRY_AWARDS_CEREMONY_DOUBLES ; $6654
	ld [wStoryModeEntryPoint], a ; $6656
	ld a, EXITTRIGGER_DIRECT ; $6659
	ld [wUnusedExitTriggerIdMirror], a ; $665b
	ld [wStoryModeExitTriggerRequest], a ; $665e
	ret ; $6661
.notDoubles:
	ld a, STORYLOC_AWARDS_CEREMONY ; $6662
	ld [wStoryModeCurrentLocation], a ; $6664
	ld a, ENTRY_AWARDS_CEREMONY_SINGLES ; $6667
	ld [wStoryModeEntryPoint], a ; $6669
	ld a, EXITTRIGGER_DIRECT ; $666c
	ld [wUnusedExitTriggerIdMirror], a ; $666e
	ld [wStoryModeExitTriggerRequest], a ; $6671
	ret ; $6674
FireworkMapActors_14:
	; $6675, 11 bytes (map_actors)
	map_actor_end
	db $00 ; padding after the list end
	ds ALIGN[4]
FireworkObjTiles_14:
	INCBIN "data/story/FireworkObjTiles_14.bin" ; $6680, 2048 bytes
FireworkSpriteTemplate_14:
	; $6e80, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
FireworkObjPalettes_14:
	INCLUDE "data/story/FireworkObjPalettes_14.asm" ; $6ea1, 32 bytes (palettes)
; Sits after FireworkObjPalettes_14's four palettes, unreferenced: when hInputRisingEdge bit 1 is newly pressed it resets both cutscene firework objects -- X $40/$68, Y $30/$38, phase 0, timer $1e each -- and returns. Nothing calls or jumps to it; UpdateFirework1_14, which follows, is the live routine.
Unused_14_ResetFireworkObjOnButton:
	ldh a, [hInputRisingEdge] ; $6ec1
	and PADF_B ; $6ec3
	jr z, .done ; $6ec5
	ld a, $40 ; $6ec7
	ld [wCutsceneObjX], a ; $6ec9
	ld a, $30 ; $6ecc
	ld [wCutsceneObjY], a ; $6ece
	ld a, $00 ; $6ed1
	ld [wCutsceneObjPhase], a ; $6ed3
	ld a, $1e ; $6ed6
	ld [wCutsceneObjTimer], a ; $6ed8
	ld a, $68 ; $6edb
	ld [wCutsceneObjX + 1], a ; $6edd
	ld a, $38 ; $6ee0
	ld [wCutsceneObjY + 1], a ; $6ee2
	ld a, $00 ; $6ee5
	ld [wCutsceneObjPhase + 1], a ; $6ee7
	ld a, $1e ; $6eea
	ld [wCutsceneObjTimer + 1], a ; $6eec
.done:
	ret ; $6eef
UpdateFirework1_14:
	ld a, [wCutsceneObjPhase + 1] ; $6ef0
	cp $04 ; $6ef3
	jp nc, .done ; $6ef5
	ld a, [wCutsceneObjPhase + 1] ; $6ef8
	and a ; $6efb
	jr nz, .draw ; $6efc
	call AdvanceFirework1Ascent_14 ; $6efe
.draw:
	ldh a, [hScrollX] ; $6f01
	ld b, a ; $6f03
	ld a, [wCutsceneObjX + 1] ; $6f04
	sub b ; $6f07
	ld d, a ; $6f08
	ldh a, [hScrollY] ; $6f09
	ld b, a ; $6f0b
	ld a, [wCutsceneObjY + 1] ; $6f0c
	sub b ; $6f0f
	ld e, a ; $6f10
	ld a, [wCutsceneObjTimer + 1] ; $6f11
	dec a ; $6f14
	ld [wCutsceneObjTimer + 1], a ; $6f15
	and a ; $6f18
	jp nz, .burstSprite ; $6f19
	ld a, [wCutsceneObjPhase + 1] ; $6f1c
	inc a ; $6f1f
	ld [wCutsceneObjPhase + 1], a ; $6f20
	cp $04 ; $6f23
	jp nc, .done ; $6f25
	ld a, [wCutsceneObjPhase + 1] ; $6f28
	ld_hl_indexed FireworkPhaseDurations_14 ; $6f2b
	ld a, [hl] ; $6f32
	ld [wCutsceneObjTimer + 1], a ; $6f33
	ld a, [wCutsceneObjPhase + 1] ; $6f36
	cp $01 ; $6f39
	jr nz, .burstSprite ; $6f3b
	ld a, [wCutsceneObjTimer + 1] ; $6f3d
	cp $0c ; $6f40
	jr nz, .burstSprite ; $6f42
	sound SFX_FIREWORK ; $6f44
.burstSprite:
	ld a, [wCutsceneObjPhase + 1] ; $6f46
	ld_hl_indexed FireworkPhaseTileBases1_14 ; $6f49
	ld a, [hl] ; $6f50
	add $10 ; $6f51
	ld c, a ; $6f53
	ld a, [wCutsceneObjTimer + 1] ; $6f54
	srl a ; $6f57
	and $03 ; $6f59
	inc a ; $6f5b
	ld b, a ; $6f5c
	ld hl, FireworkSpriteTemplate_14 ; $6f5d
	call QueueSpriteTemplate ; $6f60
.done:
	ret ; $6f63
AdvanceFirework1Ascent_14:
	ld b, $03 ; $6f64
	ld a, [wCutsceneObjTimer + 1] ; $6f66
	cp $14 ; $6f69
	jr nc, .store ; $6f6b
	dec b ; $6f6d
	cp $0a ; $6f6e
	jr nc, .store ; $6f70
	dec b ; $6f72
.store:
	ld a, [wCutsceneObjY + 1] ; $6f73
	sub b ; $6f76
	ld [wCutsceneObjY + 1], a ; $6f77
	ret ; $6f7a
IslandSkyToPeachsCastleScene:
	call DisableLCDSafely ; $6f7b
	call LoadPlaneFrontObjGfx_14 ; $6f7e
	call LoadRainbowObjGfx_14 ; $6f81
	call EnableLCD ; $6f84
	ld a, $50 ; $6f87
	ld [wCutscenePlaneX], a ; $6f89
	ld a, $88 ; $6f8c
	ld [wCutscenePlaneY], a ; $6f8e
	frame_task QueuePlaneSpriteByHeight_14 ; $6f91
	ld a, $00 ; $6f99
	ld [wCutsceneObjLimit], a ; $6f9b
	ld [wCutsceneObjLimit + 1], a ; $6f9e
	ld [wCutsceneObjHalt], a ; $6fa1
	frame_task AnimateRainbowSprites_14 ; $6fa4
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $6fac
	test_flag FLAG_DOUBLES ; $6fb7
	jp z, .fadeIn ; $6fba
	script_null_script ACTOR_PARTNER ; $6fbd
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $6fc2
.fadeIn:
	xor a ; $6fcd
	ld [wStoryModeShowLocationName], a ; $6fce
	script_fade_in 6 ; $6fd1
	call WaitFadeEnd ; $6fd6
	sound SFX_PLANE_START ; $6fd9
	script_wait_frames 60 ; $6fdb
	ld h, $08 ; $6fe2
.planeLoop:
	script_wait_frames 6 ; $6fe4
	call PlayPlaneMoveSfx_14 ; $6feb
	ld a, [wCutscenePlaneY] ; $6fee
	inc a ; $6ff1
	ld [wCutscenePlaneY], a ; $6ff2
	dec h ; $6ff5
	jr nz, .planeLoop ; $6ff6
	ld h, $08 ; $6ff8
.driftLoop:
	script_wait_frames 4 ; $6ffa
	call PlayPlaneMoveSfx_14 ; $7001
	ld a, [wCutscenePlaneY] ; $7004
	inc a ; $7007
	ld [wCutscenePlaneY], a ; $7008
	and $01 ; $700b
	ld b, a ; $700d
	ld a, [wCutscenePlaneX] ; $700e
	add b ; $7011
	ld [wCutscenePlaneX], a ; $7012
	dec h ; $7015
	jr nz, .driftLoop ; $7016
	ld h, $18 ; $7018
.diagonalLoop:
	script_wait_frames 3 ; $701a
	call PlayPlaneMoveSfx_14 ; $7021
	ld a, [wCutscenePlaneY] ; $7024
	inc a ; $7027
	ld [wCutscenePlaneY], a ; $7028
	ld a, [wCutscenePlaneX] ; $702b
	inc a ; $702e
	ld [wCutscenePlaneX], a ; $702f
	dec h ; $7032
	jr nz, .diagonalLoop ; $7033
	script_player_speed 0.5625 ; $7035
	script_move_player 11.0, 24.0 ; $703b
	ld h, $18 ; $7045
.levelOutLoop:
	script_wait_frames 2 ; $7047
	call PlayPlaneMoveSfx_14 ; $704e
	ld a, [wCutscenePlaneX] ; $7051
	inc a ; $7054
	ld [wCutscenePlaneX], a ; $7055
	and $01 ; $7058
	ld b, a ; $705a
	ld a, [wCutscenePlaneY] ; $705b
	add b ; $705e
	ld [wCutscenePlaneY], a ; $705f
	dec h ; $7062
	jr nz, .levelOutLoop ; $7063
	ld h, $20 ; $7065
.cruiseLoop:
	script_wait_frames 2 ; $7067
	call PlayPlaneMoveSfx_14 ; $706e
	ld a, [wCutscenePlaneX] ; $7071
	inc a ; $7074
	ld [wCutscenePlaneX], a ; $7075
	and $03 ; $7078
	cp $03 ; $707a
	jr nz, .cruiseStep ; $707c
	ld a, [wCutscenePlaneY] ; $707e
	inc a ; $7081
	ld [wCutscenePlaneY], a ; $7082
.cruiseStep:
	dec h ; $7085
	jr nz, .cruiseLoop ; $7086
	ld hl, QueuePlaneSpriteByHeight_14 ; $7088
	call UnregisterFrameTask ; $708b
	ld h, $1e ; $708e
.waitLoop:
	script_wait_frames 2 ; $7090
	call PlayPlaneMoveSfx_14 ; $7097
	dec h ; $709a
	jr nz, .waitLoop ; $709b
	script_move_player 11.0, 13.0 ; $709d
	call LoadDistantPlaneObjGfx_14 ; $70a7
	ld a, $04 ; $70aa
	ld [wCutsceneObjPhase], a ; $70ac
	ld a, $a8 ; $70af
	ld [wCutscenePlaneY], a ; $70b1
	frame_task QueueDistantPlaneSprite_14 ; $70b4
	ld h, $50 ; $70bc
.distantPlaneLoop:
	script_wait_frames 2 ; $70be
	call PlayPlaneMoveSfx_14 ; $70c5
	ld a, [wCutscenePlaneY] ; $70c8
	dec a ; $70cb
	ld [wCutscenePlaneY], a ; $70cc
	ld a, [wCutscenePlaneX] ; $70cf
	dec a ; $70d2
	ld [wCutscenePlaneX], a ; $70d3
	ld a, h ; $70d6
	cp $1e ; $70d7
	jr nz, .distantPlaneStep ; $70d9
	ld a, $00 ; $70db
	ld [wCutsceneObjPhase], a ; $70dd
.distantPlaneStep:
	dec h ; $70e0
	jr nz, .distantPlaneLoop ; $70e1
	ld hl, QueueDistantPlaneSprite_14 ; $70e3
	call UnregisterFrameTask ; $70e6
	call LoadTwinkleObjGfx_14 ; $70e9
	call PlayTwinkleAnimation_14 ; $70ec
	script_wait_frames 70 ; $70ef
	ld a, [wStoryModeEntryPoint] ; $70f6
	cp ENTRY_ISLAND_SKY_CREDITS_TO_PEACHS_CASTLE ; $70f9
	jp nz, .markStoryComplete ; $70fb
	ld a, $01 ; $70fe
	ld [wCutsceneObjHalt], a ; $7100
	ld a, EXIT_ISLAND_SKY_DONE ; $7103
	ld [wUnusedExitTriggerIdMirror], a ; $7105
	ld [wStoryModeExitTriggerRequest], a ; $7108
	ret ; $710b
.markStoryComplete:
	test_flag FLAG_DOUBLES ; $710c
	jp z, .singles ; $710f
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7112
	jr nz, .doublesRevisitCheck ; $7115
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL
	jr z, .doublesRevisitCheck
	set_flag FLAG_STORY_COMPLETE_DOUBLES ; $7117
	jr .saveAndReturnToTitle ; $711a
.singles:
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $711c
	jr nz, .singlesRevisitCheck ; $711f
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL
	jr z, .singlesRevisitCheck
	set_flag FLAG_STORY_COMPLETE_SINGLES ; $7121
.saveAndReturnToTitle:
	ld b, STORYLOC_PEACHS_CASTLE ; $7124
	ld c, ENTRY_PEACHS_CASTLE_FIRST_VISIT ; $7126
	farcall SaveStoryReturnPoint ; $7128
	farcall SaveStorySlotWithTimer ; $712b
	script_fade_out 1 ; $712e
	call WaitFadeEnd ; $7133
	ld a, STORYLOC_MAIN_MENU ; $7136
	ld [wStoryModeCurrentLocation], a ; $7138
	ld a, ENTRY_MAIN_MENU_TITLE ; $713b
	ld [wStoryModeEntryPoint], a ; $713d
	ld a, EXITTRIGGER_DIRECT ; $7140
	ld [wUnusedExitTriggerIdMirror], a ; $7142
	ld [wStoryModeExitTriggerRequest], a ; $7145
	ret ; $7148
.doublesRevisitCheck:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $7149
	jr z, .firstVisit ; $714c
	jr .revisit ; $714e
.singlesRevisitCheck:
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $7150
	jr z, .firstVisit ; $7153
.revisit:
	script_fade_out 4 ; $7155
	call WaitFadeEnd ; $715a
	ld a, STORYLOC_PEACHS_CASTLE ; $715d
	ld [wStoryModeCurrentLocation], a ; $715f
	ld a, ENTRY_PEACHS_CASTLE_REVISIT ; $7162
	ld [wStoryModeEntryPoint], a ; $7164
	ld a, EXITTRIGGER_DIRECT ; $7167
	ld [wUnusedExitTriggerIdMirror], a ; $7169
	ld [wStoryModeExitTriggerRequest], a ; $716c
	ret ; $716f
.firstVisit:
	script_fade_out 4 ; $7170
	call WaitFadeEnd ; $7175
	ld a, STORYLOC_PEACHS_CASTLE ; $7178
	ld [wStoryModeCurrentLocation], a ; $717a
	ld a, ENTRY_PEACHS_CASTLE_FIRST_VISIT ; $717d
	ld [wStoryModeEntryPoint], a ; $717f
	ld a, EXITTRIGGER_DIRECT ; $7182
	ld [wUnusedExitTriggerIdMirror], a ; $7184
	ld [wStoryModeExitTriggerRequest], a ; $7187
	ret ; $718a
	; $718b, 5 bytes (fill)
	ds 5, $00
