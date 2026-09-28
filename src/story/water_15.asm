ActorScript_15_01:
	; $55e2, 4 bytes (actor_script)
	as_set_field $18, $0004
ActorScript_15_02:
	; $55e6, 3 bytes (actor_script)
	as_anim ANIM_SWING_LOOP
	as_halt
ActorScript_15_03:
	; $55e9, 7 bytes (actor_script)
	as_anim ANIM_OVERHEAD_SWING
	as_wait $3c
	as_jump ActorScript_15_03
WaterSpriteSwingCountTask:
	ldh a, [hInputRisingEdge] ; $55f0
	and PADF_A | PADF_B ; $55f2
	ld d, a ; $55f4
	ld hl, wSwingContestPrevInput ; $55f5
	ld a, [hl] ; $55f8
	or a ; $55f9
	ld [hl], d ; $55fa
	jr nz, .tick ; $55fb
	ld a, d ; $55fd
	or a ; $55fe
	jr z, .tick ; $55ff
	ld hl, wSwingContestSwings ; $5601
	ld a, [hl+] ; $5604
	ld d, [hl] ; $5605
	ld e, a ; $5606
	inc de ; $5607
	ld hl, wSwingContestSwings ; $5608
	ld a, e ; $560b
	ld [hl+], a ; $560c
	ld [hl], d ; $560d
	push hl ; $560e
	push de ; $560f
	ld h, d ; $5610
	ld l, e ; $5611
	ld de, $0f04 ; $5612
	call PrintHexWord ; $5615
	pop de ; $5618
	pop hl ; $5619
	ld a, [wSwingContestSwingState] ; $561a
	cp $02 ; $561d
	jr z, .firstSwing ; $561f
	ld a, $02 ; $5621
	ld [wSwingContestSwingState], a ; $5623
	jr .tick ; $5626
.firstSwing:
	ld a, $01 ; $5628
	ld [wSwingContestSwingState], a ; $562a
.tick:
	ld hl, wSwingContestTimer ; $562d
	ld a, [hl+] ; $5630
	ld d, [hl] ; $5631
	ld e, a ; $5632
	dec de ; $5633
	ld a, d ; $5634
	or e ; $5635
	jr z, .finish ; $5636
	ld hl, wSwingContestTimer ; $5638
	ld a, e ; $563b
	ld [hl+], a ; $563c
	ld [hl], d ; $563d
	ret ; $563e
.finish:
	ld hl, WaterSpriteSwingCountTask ; $563f
	call UnregisterFrameTask ; $5642
	xor a ; $5645
	ld [wSwingContestSwingState], a ; $5646
	ret ; $5649
WaterSpriteSwingContestScene:
	ld de, $8100 + VRAM_BANK1 ; $564a
	ld b, $0a ; $564d
	ld c, $01 ; $564f
	farcall InitNumberSpriteGfx ; $5651
	ld a, $0a ; $5654
	ld [wDigitSpriteAttr], a ; $5656
	ld a, $10 ; $5659
	ld [wDigitSpriteTileBase], a ; $565b
	call InitWaterSpriteMinigameHud ; $565e
	script_face ACTOR_PLAYER, FACE_DOWN ; $5661
	ld b, $20 ; $5668
	ld e, $10 ; $566a
.contest:
	ld a, $20 ; $566c
	sub b ; $566e
	ld d, a ; $566f
	ld hl, $000a ; $5670
	farcall DrawDecimalNumberSprites_39 ; $5673
	ld a, $18 ; $5676
	sub b ; $5678
	ld [wSwingContestHudMode], a ; $5679
	ld a, $80 ; $567c
	add b ; $567e
	ld d, a ; $567f
	ld hl, $0000 ; $5680
	farcall DrawDecimalNumberSprites_39 ; $5683
	ld a, $74 ; $5686
	add b ; $5688
	ld [wSwingContestHudPage], a ; $5689
	script_wait_frames $01 ; $568c
	dec b ; $5693
	jp nz, .contest ; $5694
	ld de, $0258 ; $5697
	ld hl, wSwingContestTimer ; $569a
	ld a, e ; $569d
	ld [hl+], a ; $569e
	ld [hl], d ; $569f
	ld hl, wSwingContestSwings ; $56a0
	xor a ; $56a3
	ld [hl+], a ; $56a4
	ld [hl+], a ; $56a5
	ld [hl+], a ; $56a6
	ld [hl+], a ; $56a7
	ld a, $01 ; $56a8
	ld [wSwingContestSwingState], a ; $56aa
	ld a, $01 ; $56ad
	ld hl, DrawWaterSpriteMinigameCounters ; $56af
	call RegisterFrameTask ; $56b2
	script_wait_frames $32 ; $56b5
	ld l, $03 ; $56bc
	ld h, $00 ; $56be
	ld de, $502c ; $56c0
.win:
	sound SFX_CONTEST_WIN ; $56c3
	ld b, $3c ; $56c5
.lose:
	farcall DrawDecimalNumberSprites_39 ; $56c7
	script_wait_frames $01 ; $56ca
	dec b ; $56d1
	jp nz, .lose ; $56d2
	dec l ; $56d5
	jp nz, .win ; $56d6
	sound SFX_COUNTDOWN_GO ; $56d9
	call TogglePlayerSpriteXFlip ; $56db
	ld a, $01 ; $56de
	ld hl, WaterSpriteSwingCountTask ; $56e0
	call RegisterFrameTask ; $56e3
.reward:
	call AdvanceFrame ; $56e6
	ld a, [wSwingContestSwingState] ; $56e9
	cp $00 ; $56ec
	jr z, .finish ; $56ee
	cp $01 ; $56f0
	jr z, .rewardWait ; $56f2
	ld a, $09 ; $56f4
	ld d, a ; $56f6
	ld a, $00 ; $56f7
	farcall ScriptSetActorAnimation ; $56f9
	jr .reward ; $56fc
.rewardWait:
	ld a, $0a ; $56fe
	ld d, a ; $5700
	ld a, $00 ; $5701
	farcall ScriptSetActorAnimation ; $5703
	jr .reward ; $5706
.finish:
	sound SFX_CONTEST_FINISH ; $5708
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $570a
	script_wait_idle ACTOR_PLAYER ; $5711
	script_wait_frames $3c ; $5716
	call TogglePlayerSpriteXFlip ; $571d
	ld hl, DrawWaterSpriteMinigameCounters ; $5720
	call UnregisterFrameTask ; $5723
	ld b, $30 ; $5726
	ld e, $10 ; $5728
.done:
	ld a, b ; $572a
	sub $10 ; $572b
	ld d, a ; $572d
	ld hl, $0000 ; $572e
	farcall DrawDecimalNumberSprites_39 ; $5731
	ld a, $e8 ; $5734
	add b ; $5736
	ld [wSwingContestHudMode], a ; $5737
	ld a, $b0 ; $573a
	sub b ; $573c
	ld d, a ; $573d
	ld hl, wSwingContestSwings ; $573e
	ld a, [hl+] ; $5741
	ld h, [hl] ; $5742
	ld l, a ; $5743
	farcall DrawDecimalNumberSprites_39 ; $5744
	ld a, $a4 ; $5747
	sub b ; $5749
	ld [wSwingContestHudPage], a ; $574a
	script_wait_frames $01 ; $574d
	dec b ; $5754
	jp nz, .done ; $5755
	ld hl, QueueWaterSpriteMinigameHudPanels ; $5758
	call UnregisterFrameTask ; $575b
	wait_frames $3c ; $575e
	script_set_text Text_36_676 ; $5762
	ld hl, wSwingContestSwings ; $5768
	ld a, [hl+] ; $576b
	ld h, [hl] ; $576c
	ld l, a ; $576d
	farcall PushTextArgNumber ; $576e
	script_speak ACTOR_PLAYER ; $5771
	ret ; $5776
; Instruction-identical to MirrorPlayerSpriteIfLeftHanded (one copy per bank); a change here belongs in every copy.
	twin_named mirror_player_sprite_if_left_handed, TogglePlayerSpriteXFlip ; $5777
DrawWaterSpriteMinigameCounters:
	ld hl, wSwingContestTimer ; $578d
	ld a, [hl+] ; $5790
	ld h, [hl] ; $5791
	ld l, a ; $5792
	ld a, $00 ; $5793
	ld e, $3c ; $5795
	call DivAHLByE ; $5797
	ld de, $2010 ; $579a
	farcall DrawDecimalNumberSprites_39 ; $579d
	ld hl, wSwingContestSwings ; $57a0
	ld a, [hl+] ; $57a3
	ld h, [hl] ; $57a4
	ld l, a ; $57a5
	ld de, $8010 ; $57a6
	farcall DrawDecimalNumberSprites_39 ; $57a9
	ret ; $57ac
QueueWaterSpriteMinigameTimerPanel_SpriteTemplate:
	; $57ad, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
QueueWaterSpriteMinigameCounterPanel_SpriteTemplate:
	; $57ba, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
	; $57c7, 9 bytes (fill)
	ds 9, $00
	ds ALIGN[4]
WaterSpriteHudTiles_15:
	INCBIN "data/bank_015/WaterSpriteHudTiles_15.bin" ; $57d0, 192 bytes
WaterSpriteHudPalette_15:
	INCLUDE "data/bank_015/WaterSpriteHudPalette_15.asm" ; $5890, 8 bytes (palettes)
LoadWaterSpriteMinigameHudGfx:
	push_wram_bank WRAM_STAGING ; $5898
	ld hl, WaterSpriteHudTiles_15 ; $58a1
	ld de, vTiles0 + VRAM_BANK1 ; $58a4
	ld c, (WaterSpriteHudPalette_15 - WaterSpriteHudTiles_15) / 16 ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, WaterSpriteHudPalette_15 ; $58ac
	lb de, $08, $02 ; $58af palette index, count
	call LoadPaletteShadow ; $58b2
	pop_wram_bank ; $58b5
	ret ; $58ba
QueueWaterSpriteMinigameTimerPanel:
	ld hl, QueueWaterSpriteMinigameTimerPanel_SpriteTemplate ; $58bb
	ld c, $00 ; $58be
	ld b, $08 ; $58c0
	call QueueSpriteTemplate ; $58c2
	ret ; $58c5
QueueWaterSpriteMinigameCounterPanel:
	ld hl, QueueWaterSpriteMinigameCounterPanel_SpriteTemplate ; $58c6
	ld c, $06 ; $58c9
	ld b, $08 ; $58cb
	call QueueSpriteTemplate ; $58cd
	ret ; $58d0
QueueWaterSpriteMinigameHudPanels:
	ld a, [wSwingContestHudMode] ; $58d1
	ld d, a ; $58d4
	ld e, $18 ; $58d5
	call QueueWaterSpriteMinigameTimerPanel ; $58d7
	ld a, [wSwingContestHudPage] ; $58da
	ld d, a ; $58dd
	ld e, $18 ; $58de
	call QueueWaterSpriteMinigameCounterPanel ; $58e0
	ret ; $58e3
InitWaterSpriteMinigameHud:
	call LoadWaterSpriteMinigameHudGfx ; $58e4
	ld a, $e8 ; $58e7
	ld [wSwingContestHudMode], a ; $58e9
	ld a, $a0 ; $58ec
	ld [wSwingContestHudPage], a ; $58ee
	ld a, $01 ; $58f1
	ld hl, QueueWaterSpriteMinigameHudPanels ; $58f3
	call RegisterFrameTask ; $58f6
	ret ; $58f9
	; $58fa, 6 bytes (fill)
	ds 6, $00
Palettes_15_0:
	INCLUDE "data/bank_015/Palettes_15_0.asm" ; $5900, 16 bytes (palettes)
WaterSpriteRacketRewardScenePalettes0:
	INCLUDE "data/bank_015/WaterSpriteRacketRewardScenePalettes0.asm" ; $5910, 64 bytes (palettes)
WaterSpriteRacketRewardScenePalettes1:
	INCLUDE "data/bank_015/WaterSpriteRacketRewardScenePalettes1.asm" ; $5950, 64 bytes (palettes)
WaterSpriteRacketRewardScenePalettes2:
	INCLUDE "data/bank_015/WaterSpriteRacketRewardScenePalettes2.asm" ; $5990, 48 bytes (palettes)
TrainingCourtIntroTourScene:
	xor a ; $59c0
	ld [wStoryModeShowLocationName], a ; $59c1
	ldh a, [hRomBank] ; $59c4
	ld hl, TrainingCourtTourActors_15 ; $59c6
	farcall ScriptRespawnLocationActors ; $59c9
	farcall BeginCutsceneScriptMode ; $59cc
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $59cf
	script_set_position ACTOR_TRAINING_COURT_TOUR_EMILY, $3f00, $3f00 ; $59da
	script_set_position ACTOR_TRAINING_COURT_TOUR_EMILY, $0700, $36c0 ; $59e5
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1f00, $36c0 ; $59f0
	script_wait_frames $0a ; $59fb
	script_set_position ACTOR_PLAYER, $0500, $3700 ; $5a02
	script_move_target ACTOR_PLAYER, $1f00, $3700 ; $5a0d
	script_move_player $1f00, $3700 ; $5a18
	script_fade_in $04 ; $5a22
	call WaitFadeEnd ; $5a27
	script_wait_move ACTOR_TRAINING_COURT_TOUR_EMILY ; $5a2a
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1f00, $2b00 ; $5a2f
	script_wait_move ACTOR_PLAYER ; $5a3a
	script_move_target ACTOR_PLAYER, $1f00, $2d00 ; $5a3f
	farcall WaitPlayerMoveDone ; $5a4a
	script_move_player $1f00, $2d00 ; $5a4d
	farcall WaitPlayerMoveDone ; $5a57
	script_wait_frames $3c ; $5a5a
	script_face ACTOR_TRAINING_COURT_TOUR_EMILY, FACE_RIGHT ; $5a61
	script_wait_frames $3c ; $5a68
	script_face ACTOR_TRAINING_COURT_TOUR_EMILY, FACE_LEFT ; $5a6f
	script_wait_frames $3c ; $5a76
	script_face ACTOR_TRAINING_COURT_TOUR_EMILY, FACE_DOWN ; $5a7d
	script_wait_frames $3c ; $5a84
	script_face ACTOR_TRAINING_COURT_TOUR_EMILY, FACE_RIGHT ; $5a8b
	script_player_speed $0040 ; $5a92
	script_set_text Text_36_627 ; $5a98
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5a9e
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5aa3
	script_wait_idle ACTOR_PLAYER ; $5aaa
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5aaf
	script_move_player $2d00, $2900 ; $5ab6
	farcall WaitPlayerMoveDone ; $5ac0
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5ac3
	script_wait_frames $3c ; $5ac8
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_TOUR_EMILY ; $5acf
	script_move_player $1f00, $2d00 ; $5ad7
	farcall WaitPlayerMoveDone ; $5ae1
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5ae4
	script_wait_idle ACTOR_PLAYER ; $5aeb
	script_face ACTOR_TRAINING_COURT_TOUR_EMILY, FACE_LEFT ; $5af0
	script_wait_frames $28 ; $5af7
	script_face ACTOR_PLAYER, FACE_LEFT ; $5afe
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b05
	script_move_player_to_actor ACTOR_TRAINING_COURT_TOUR_BOB ; $5b0a
	farcall WaitPlayerMoveDone ; $5b11
	script_wait_frames $3c ; $5b14
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b1b
	script_move_player_to_actor ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b23
	farcall WaitPlayerMoveDone ; $5b2a
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b2d
	script_wait_idle ACTOR_PLAYER ; $5b34
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b39
	script_face_toward ACTOR_TRAINING_COURT_TOUR_EMILY, ACTOR_PLAYER ; $5b3e
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $5b46
	script_wait_idle ACTOR_PLAYER ; $5b4d
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b52
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b57
	script_wait_idle ACTOR_PLAYER ; $5b5e
	script_set_anim ACTOR_TRAINING_COURT_TOUR_EMILY, ANIM_NOD ; $5b63
	script_wait_idle ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b6a
	script_speak ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b6f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5b74
	script_wait_idle ACTOR_PLAYER ; $5b7b
	script_player_speed $0020 ; $5b80
	script_face ACTOR_PLAYER, FACE_LEFT ; $5b86
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1e00, $2b00 ; $5b8d
	script_wait_move ACTOR_TRAINING_COURT_TOUR_EMILY ; $5b98
	script_lock_facing ACTOR_PLAYER ; $5b9d
	script_move_target ACTOR_PLAYER, $2000, $2d00 ; $5ba4
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1e00, $2f00 ; $5baf
	script_wait_move ACTOR_TRAINING_COURT_TOUR_EMILY ; $5bba
	script_move_target ACTOR_PLAYER, $1f00, $2d00 ; $5bbf
	script_wait_move ACTOR_PLAYER ; $5bca
	script_unlock_facing ACTOR_PLAYER ; $5bcf
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1f00, $2f00 ; $5bd6
	script_wait_move ACTOR_TRAINING_COURT_TOUR_EMILY ; $5be1
	script_move_target ACTOR_PLAYER, $1f00, $3700 ; $5be6
	script_move_player $1f00, $3700 ; $5bf1
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $1f00, $3700 ; $5bfb
	script_wait_move ACTOR_TRAINING_COURT_TOUR_EMILY ; $5c06
	script_move_target ACTOR_TRAINING_COURT_TOUR_EMILY, $0300, $3700 ; $5c0b
	script_move_player $0900, $3700 ; $5c16
	script_wait_move ACTOR_PLAYER ; $5c20
	script_move_target ACTOR_PLAYER, $0300, $3700 ; $5c25
	script_wait_frames $5a ; $5c30
	ld c, $08 ; $5c37
	call BeginFadeOut ; $5c39
	script_wait_frames $14 ; $5c3c
	ld a, $0f ; $5c43
	ld [wUnusedExitTriggerIdMirror], a ; $5c45
	ld [wStoryModeExitTriggerRequest], a ; $5c48
	farcall EndCutsceneScriptMode ; $5c4b
	ret ; $5c4e
TrainingCourtTourActors_15:
	; $5c4f, 164 bytes (map_actors)
	map_actor $0000, ActorScript_15_02, $3300, $2a00, FACE_UP, OBJ_WALK_72_02, ANIM_WALK, $06, TRAINING_COURT_TOUR_WALK_72_02_1
	map_actor $0000, ActorScript_15_02, $3500, $2300, FACE_DOWN, OBJ_WALK_71_05, ANIM_WALK, $03, TRAINING_COURT_TOUR_WALK_71_05
	map_actor $0000, ActorScript_15_02, $3500, $2a00, FACE_UP, OBJ_WALK_71_07, ANIM_WALK, $07, TRAINING_COURT_TOUR_WALK_71_07_1
	map_actor $0000, ActorScript_15_22, $2d00, $2100, FACE_RIGHT, OBJ_BRIAN, ANIM_WALK, $07, TRAINING_COURT_TOUR_BRIAN
	map_actor $0000, ActorScript_15_02, $0b00, $2300, FACE_DOWN, OBJ_WALK_71_07, ANIM_WALK, $03, TRAINING_COURT_TOUR_WALK_71_07_2
	map_actor $0000, ActorScript_15_02, $0d00, $2300, FACE_DOWN, OBJ_WALK_72_02, ANIM_WALK, $05, TRAINING_COURT_TOUR_WALK_72_02_2
	map_actor $0000, ActorScript_15_02, $0c00, $2900, FACE_UP, OBJ_WALK_71_06, ANIM_WALK, $04, TRAINING_COURT_TOUR_WALK_71_06
	map_actor $0000, ActorScript_15_22, $1300, $2700, FACE_DOWN, OBJ_ALLIE, ANIM_WALK, $06, TRAINING_COURT_TOUR_ALLIE
	map_actor $0000, ActorScript_15_22, $1300, $2900, FACE_UP, OBJ_BOB, ANIM_WALK, $04, TRAINING_COURT_TOUR_BOB
	map_actor $0000, ActorScript_15_22, $2d00, $2900, FACE_RIGHT, OBJ_BETH, ANIM_WALK, $07, TRAINING_COURT_TOUR_BETH
	map_actor $0000, ActorScript_15_22, $0100, $0100, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, TRAINING_COURT_TOUR_EMILY
	map_actor_end
ServeChallengerResultScene:
	xor a ; $5cf3
	ld [wStoryModeShowLocationName], a ; $5cf4
	ld a, $06 ; $5cf7
	ld [wMapSceneStage2], a ; $5cf9
	script_set_position ACTOR_PLAYER, $1800, $1100 ; $5cfc
	script_face ACTOR_PLAYER, FACE_UP ; $5d07
	ld a, [wMapSceneStage2] ; $5d0e
	ld bc, $1800 ; $5d11
	ld de, $0d00 ; $5d14
	farcall ScriptSetActorPosition ; $5d17
	ld a, [wMapSceneStage2] ; $5d1a
	ld b, $40 ; $5d1d
	farcall SetActorFacing ; $5d1f
	script_null_script ACTOR_PARTNER ; $5d22
	script_set_position ACTOR_PARTNER, $1300, $1100 ; $5d27
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5d32
	script_player_speed $00f0 ; $5d39
	script_move_player $1800, $0f00 ; $5d3f
	farcall WaitPlayerMoveDone ; $5d49
	script_fade_in $08 ; $5d4c
	call WaitFadeEnd ; $5d51
	ld a, [wPointWinLoseFlag] ; $5d54
	inc a ; $5d57
	cp $01 ; $5d58
	jr nz, .dispatch ; $5d5a
	ld hl, wUnusedChallengerLoseTextId ; $5d5c
	ld de, Text_6e_29 ; $5d5f
	ld a, e ; $5d62
	ld [hl+], a ; $5d63
	ld [hl], d ; $5d64
	ld a, [wPointWinLoseFlag] ; $5d65
	inc a ; $5d68
.dispatch:
	ld a, a ; $5d69
	rst Rst00 ; $5d6a
	dw StrokeChallengerResultScene.finish ; $5d6b jumptable
	dw StrokeChallengerResultScene.lose ; $5d6d jumptable
	dw StrokeChallengerResultScene.draw ; $5d6f jumptable
	dw StrokeChallengerResultScene.jumpForJoy ; $5d71 jumptable
	ret ; $5d73
