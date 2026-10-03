CompareEquippedRacketToMinigameFlag:
	ld a, [wMapScratch + 8] ; $5005
	ld b, a ; $5008
	ld a, [wEquippedRacket] ; $5009
	cp b ; $500c
	jr z, .failed ; $500d
	ld a, $00 ; $500f
	ret ; $5011
.failed:
	ld a, $ff ; $5012
	ret ; $5014
RepairCounterCheckEquipChanged:
	xor a ; $5015
	ld [wStoryModeShowLocationName], a ; $5016
	script_fade_in 8 ; $5019
	call WaitFadeEnd ; $501e
	call CompareEquippedRacketToMinigameFlag ; $5021
	cp $ff ; $5024
	jp nz, .repairRacket ; $5026
	ld a, [wMapScratch + 10] ; $5029
	ld hl, Text_1f_1 ; $502c
	add l ; $502f
	ld l, a ; $5030
	jr nc, .askRepair ; $5031
	inc h ; $5033
.askRepair:
	farcall InitDialogueTextCursor ; $5034
	call PushEquipmentNameTextArg ; $5037
	script_speak_restore ACTOR_TRAINING_GYM_WALK_72_02_2 ; $503a
	farcall RunDialogueYesNoPrompt ; $503f
	farcall ScriptCloseDialogueWindow ; $5042
	script_wait_frames 5 ; $5045
	and a ; $504c
	jp nz, .noChange ; $504d
	ld a, [wMapScratch + 10] ; $5050
	jp RepairCounterServiceMenu.loop ; $5053
.repairRacket:
	ld a, [wEquippedRacket] ; $5056
	ld [wMapScratch + 8], a ; $5059
	call InitEquipmentHandoutDialogue ; $505c
	script_speak ACTOR_TRAINING_GYM_WALK_72_02_2 ; $505f
	call ShowEquipChangeConfirmation ; $5064
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $5067
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_GYM_WALK_72_02_2 ; $506a
	script_set_text Text_6e_241 ; $5072
	call PushEquipmentNameTextArg ; $5078
	script_speak ACTOR_TRAINING_GYM_WALK_72_02_2 ; $507b
.noChange:
	script_set_text Text_6e_242 ; $5080
	script_speak_restore ACTOR_TRAINING_GYM_WALK_72_02_2 ; $5086
	farcall RunDialogueYesNoPrompt ; $508b
	farcall ScriptCloseDialogueWindow ; $508e
	script_wait_frames 5 ; $5091
	and a ; $5098
	jp z, RepairCounterServiceMenu ; $5099
	jp RepairCounterFarewell ; $509c
RepairCounterChangedReturnA:
	ld a, $0b ; $509f
	ld [wMapSceneStage2], a ; $50a1
	script_set_position ACTOR_PARTNER, 15.0, 15.0 ; $50a4
	jp RepairCounterReopenServiceMenu ; $50af
	ret ; $50b2
RepairCounterChangedReturnB:
	ld a, $0c ; $50b3
	ld [wMapSceneStage2], a ; $50b5
	farcall WaitPlayerMoveDone ; $50b8
	script_player_speed 7.5 ; $50bb
	script_move_player 13.0, 19.0 ; $50c1
	farcall WaitPlayerMoveDone ; $50cb
	script_set_position ACTOR_PARTNER, 19.0, 19.0 ; $50ce
	jp RepairCounterReopenServiceMenu ; $50d9
	ret ; $50dc
RepairCounterReopenServiceMenu:
	xor a ; $50dd
	ld [wStoryModeShowLocationName], a ; $50de
	script_set_text Text_6e_239 ; $50e1
	ld hl, $00e6 ; $50e7
	call FetchAndPushShortTextArg ; $50ea
	set_flag FLAG_REPAIR_COUNTER_EQUIP_CHANGED ; $50ed
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_GYM_WALK_72_02_2 ; $50f0
	script_fade_in 8 ; $50f8
	call WaitFadeEnd ; $50fd
	ld hl, Text_6e_236 ; $5100
	ld_cell de, $01, $01 ; $5103
	farcall RunMenuFromText ; $5106
	ld [wMapScratch + 10], a ; $5109
	cp $ff ; $510c
	jp z, RepairCounterFarewell ; $510e
	cp $02 ; $5111
	jp z, RepairCounterFarewell ; $5113
	cp $00 ; $5116
	jp z, RepairCounterChangeRackets ; $5118
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $511b
	jp nz, RepairCounterChangeShoes ; $511e
	script_set_text Text_6e_232 ; $5121
	script_speak ACTOR_TRAINING_GYM_WALK_72_02_2 ; $5127
	script_set_text Text_6e_242 ; $512c
	script_speak_restore ACTOR_TRAINING_GYM_WALK_72_02_2 ; $5132
	farcall RunDialogueYesNoPrompt ; $5137
	farcall ScriptCloseDialogueWindow ; $513a
	script_wait_frames 5 ; $513d
	and a ; $5144
	jp z, RepairCounterServiceMenu ; $5145
	jp RepairCounterFarewell ; $5148
	script_face ACTOR_TRAINING_GYM_WALK_72_02_2, FACE_RIGHT ; $514b
	ret ; $5152
ShowEquipChangeConfirmation:
	ld a, [wMapScratch + 10] ; $5153
	ld hl, Text_6e_239 ; $5156
	add l ; $5159
	ld l, a ; $515a
	jr nc, .speak ; $515b
	inc h ; $515d
.speak:
	farcall InitDialogueTextCursor ; $515e
	call PushEquipmentNameTextArg ; $5161
	ld a, [wMapScratch + 10] ; $5164
	and a ; $5167
	jr nz, .handOver ; $5168
	call MirrorPlayerSpriteIfLeftHanded ; $516a
	script_set_anim ACTOR_PLAYER, ANIM_SWING_BACK ; $516d
	script_face ACTOR_PLAYER, FACE_DOWN ; $5174
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_03 ; $517b
	script_speak SPEAKER_NONE | 12 ; $5186
	script_null_script ACTOR_PLAYER ; $518b
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $5190
	script_face_toward ACTOR_TRAINING_GYM_WALK_72_02_2, ACTOR_PLAYER ; $5197
	call MirrorPlayerSpriteIfLeftHanded ; $519f
	ret ; $51a2
.handOver:
	script_face ACTOR_PLAYER, FACE_DOWN ; $51a3
	script_set_actor_script ACTOR_PLAYER, ActorScript_0e_04 ; $51aa
	script_speak SPEAKER_NONE | 12 ; $51b5
	script_null_script ACTOR_PLAYER ; $51ba
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $51bf
	script_set_speed ACTOR_PLAYER, 1.0 ; $51c6
	script_face_toward ACTOR_TRAINING_GYM_WALK_72_02_2, ACTOR_PLAYER ; $51ce
	ret ; $51d6
ActorScript_0e_03:
	; $51d7, 13 bytes (actor_script)
	as_anim ANIM_SWING_BACK
	as_wait 30
	as_anim ANIM_SWING_THROUGH
	as_sound $91
	as_wait 30
	as_jump ActorScript_0e_03
ActorScript_0e_04:
	; $51e4, 43 bytes (actor_script)
	as_anim ANIM_SIDESTEP
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_wait 12
	as_sound $92
	as_wait 40
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_WALK
	as_wait 1
	as_anim ANIM_SIDESTEP
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_wait 12
	as_sound $92
	as_wait 40
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_WALK
	as_wait 1
	as_jump ActorScript_0e_04
; Instruction-identical to TogglePlayerSpriteXFlip (one copy per bank); a change here belongs in every copy.
	twin_named mirror_player_sprite_if_left_handed, MirrorPlayerSpriteIfLeftHanded ; $520f
ActorScript_0e_05:
	; $5225, 35 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0010
.L8:
	as_target_rel -2.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait 75
	as_target_rel 2.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_wait 75
	as_jump .L8
MarioWorldMapScripts_0e:
	; $5248, 14 bytes (map_tree)
	dw MarioWorldEntryPoints_0e ; slot 0 EntryPoints
	dw MarioWorldExitTriggers_0e ; slot 1 ExitTriggers
	dw MarioWorldActors_0e ; slot 2 Actors
	dw MarioWorldNpcScripts_0e ; slot 3 NpcScripts
	dw MarioWorldFacingScripts_0e ; slot 4 FacingScripts
	dw MarioWorldTileTriggers_0e ; slot 5 TileTriggers
	dw MarioWorldInitScript_0e ; slot 6 InitScript
MarioWorldActors_0e:
	; $5256, 262 bytes (map_actors)
	map_actor $0000, ActorScript_0e_22, 21.0, 61.0, FACE_RIGHT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, MARIO_WORLD_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_0e_22, 21.0, 61.0, FACE_RIGHT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, MARIO_WORLD_BALLOON_SWEAT_1
	map_actor $0000, ActorScript_0e_22, 21.0, 61.0, FACE_RIGHT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, MARIO_WORLD_BALLOON_SWEAT_2
	map_actor $0000, ActorScript_0e_22, 21.0, 61.0, FACE_RIGHT, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, MARIO_WORLD_BALLOON_SWEAT_3
	map_actor $0000, ActorScript_0e_22, 21.0, 61.0, FACE_RIGHT, OBJ_BALLOON_ANGRY, ANIM_WALK, $00, MARIO_WORLD_BALLOON_ANGRY
	map_actor $0000, ActorScript_0e_22, 18.0, 19.0, FACE_DOWN, OBJ_PEACH, ANIM_WALK, $00, MARIO_WORLD_PEACH
	map_actor $0000, ActorScript_0e_22, 24.0, 18.0, FACE_DOWN, OBJ_YOSHI, ANIM_WALK, $00, MARIO_WORLD_YOSHI
	map_actor $0000, ActorScript_0e_22, 24.0, 15.25, FACE_DOWN, OBJ_BABY_MARIO, ANIM_WALK, $00, MARIO_WORLD_BABY_MARIO
	map_actor $0000, ActorScript_0e_22, 24.0, 13.0, FACE_DOWN, OBJ_LUIGI, ANIM_WALK, $00, MARIO_WORLD_LUIGI
	map_actor $0000, ActorScript_0e_22, 23.0, 20.0, FACE_DOWN, OBJ_DK, ANIM_WALK, $00, MARIO_WORLD_DK
	map_actor $0000, ActorScript_0e_22, 10.0, 15.0, FACE_DOWN, OBJ_BOO, ANIM_WALK, $00, MARIO_WORLD_BOO
	map_actor $0000, ActorScript_0e_22, 12.0, 17.0, FACE_DOWN, OBJ_WALUIGI, ANIM_WALK, $00, MARIO_WORLD_WALUIGI
	map_actor $0000, ActorScript_0e_22, 12.0, 15.0, FACE_DOWN, OBJ_BOWSER, ANIM_WALK, $00, MARIO_WORLD_BOWSER
	map_actor $0000, ActorScript_0e_22, 12.0, 13.0, FACE_DOWN, OBJ_WARIO, ANIM_WALK, $00, MARIO_WORLD_WARIO
	map_actor $0000, ActorScript_0e_22, 14.0, 11.0, FACE_DOWN, OBJ_WALK_77_05, ANIM_WALK, $00, MARIO_WORLD_WALK_77_05
	map_actor $0000, ActorScript_0e_22, 22.0, 11.0, FACE_DOWN, OBJ_MARIO, ANIM_WALK, $00, MARIO_WORLD_MARIO
	map_actor $0000, ActorScript_0e_22, 15.0, 31.0, FACE_DOWN, OBJ_TOAD, ANIM_WALK, $00, MARIO_WORLD_TOAD
	map_actor $0000, ActorScript_0e_22, 21.0, 31.0, FACE_DOWN, OBJ_BOB_OMB, ANIM_WALK, $00, MARIO_WORLD_BOB_OMB
	map_actor_end
MarioWorldEntryPoints_0e:
	; $535c, 41 bytes (map_entries)
	map_entry $01, FACE_UP, 18.0, 33.0, $0000
	map_entry $02, FACE_DOWN, 27.0, 11.0, $0000
	map_entry $0a, FACE_UP, 18.0, 8.0, $0000
	map_entry $0e, FACE_UP, 18.0, 15.0, $0000
	map_entry $0f, FACE_UP, 18.0, 8.0, $0000
	db $ff
MarioWorldExitTriggers_0e:
	; $5385, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_0e, STORYLOC_ISLAND_SKY, $0e
	db $ff
MarioWorldNpc12Mario_0e:
	script_set_text Text_5e_142 ; $538e
	script_speak ACTOR_MARIO_WORLD_MARIO ; $5394
	ret ; $5399
MarioWorldNpc11_0e:
	ld hl, Text_5e_143 ; $539a
	ld a, [wMapSceneStage] ; $539d
	add l ; $53a0
	ld l, a ; $53a1
	jr nc, .speak ; $53a2
	inc h ; $53a4
.speak:
	farcall InitDialogueTextCursor ; $53a5
	script_speak ACTOR_MARIO_WORLD_WALK_77_05 ; $53a8
	ret ; $53ad
MarioWorldNpc0BLuigi_0e:
	ld hl, Text_5e_147 ; $53ae
	ld a, [wMapSceneStage] ; $53b1
	add l ; $53b4
	ld l, a ; $53b5
	jr nc, .speak ; $53b6
	inc h ; $53b8
.speak:
	farcall InitDialogueTextCursor ; $53b9
	script_speak ACTOR_MARIO_WORLD_LUIGI ; $53bc
	ret ; $53c1
MarioWorldNpc09Yoshi_0e:
	script_set_text Text_5e_151 ; $53c2
	sound SFX_VOICE_YOSHI ; $53c8
	script_speak ACTOR_MARIO_WORLD_YOSHI ; $53ca
	ret ; $53cf
MarioWorldNpc0ABabyMario_0e:
	script_set_text Text_5e_152 ; $53d0
	sound SFX_VOICE_BABY_MARIO ; $53d6
	script_speak ACTOR_MARIO_WORLD_BABY_MARIO ; $53d8
	ret ; $53dd
MarioWorldNpc0C_0e:
	script_set_text Text_5e_153 ; $53de
	sound SFX_PEACH_FANFARE ; $53e4
	script_speak ACTOR_MARIO_WORLD_DK ; $53e6
	ret ; $53eb
MarioWorldNpc0D_0e:
	script_set_text Text_5e_154 ; $53ec
	sound SFX_THUD ; $53f2
	script_speak ACTOR_MARIO_WORLD_BOO ; $53f4
	ret ; $53f9
MarioWorldNpc0FBowser_0e:
	ld hl, Text_5e_155 ; $53fa
	ld a, [wMapSceneStage] ; $53fd
	add l ; $5400
	ld l, a ; $5401
	jr nc, .speak ; $5402
	inc h ; $5404
.speak:
	farcall InitDialogueTextCursor ; $5405
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $5408
	ret ; $540d
MarioWorldNpc10Wario_0e:
	ld hl, Text_5e_159 ; $540e
	ld a, [wMapSceneStage] ; $5411
	add l ; $5414
	ld l, a ; $5415
	jr nc, .speak ; $5416
	inc h ; $5418
.speak:
	farcall InitDialogueTextCursor ; $5419
	script_speak ACTOR_MARIO_WORLD_WARIO ; $541c
	ret ; $5421
MarioWorldNpc0EWaluigi_0e:
	ld hl, Text_5e_163 ; $5422
	ld a, [wMapSceneStage] ; $5425
	add l ; $5428
	ld l, a ; $5429
	jr nc, .speak ; $542a
	inc h ; $542c
.speak:
	farcall InitDialogueTextCursor ; $542d
	script_speak ACTOR_MARIO_WORLD_WALUIGI ; $5430
	ret ; $5435
MarioWorldNpc13_0e:
	script_set_text Text_5e_167 ; $5436
	script_speak ACTOR_MARIO_WORLD_TOAD ; $543c
	ret ; $5441
MarioWorldNpc14_0e:
	script_set_text Text_5e_168 ; $5442
	script_speak ACTOR_MARIO_WORLD_BOB_OMB ; $5448
	ret ; $544d
MarioWorldNpcScripts_0e:
	; $544e, 129 bytes (map_scripts)
	map_script ACTOR_MARIO_WORLD_PEACH, FACEMASK_RIGHT, $0000, MarioWorldNpc08FaceRight_0e, $00, $00
	map_script ACTOR_MARIO_WORLD_PEACH, FACEMASK_LEFT, $0000, MarioWorldNpc08FaceLeft_0e, $00, $00
	map_script ACTOR_MARIO_WORLD_PEACH, FACEMASK_UP, $0000, MarioWorldNpc08FaceUp_0e, $00, $00
	map_script ACTOR_MARIO_WORLD_PEACH, FACEMASK_DOWN, $0000, MarioWorldNpc08FaceDown_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_WALK_77_05, FACEMASK_ANY, $0000, MarioWorldNpc11_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_LUIGI, FACEMASK_ANY, $0000, MarioWorldNpc0BLuigi_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_YOSHI, FACEMASK_ANY, $0000, MarioWorldNpc09Yoshi_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_BABY_MARIO, FACEMASK_ANY, $0000, MarioWorldNpc0ABabyMario_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_DK, FACEMASK_ANY, $0000, MarioWorldNpc0C_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_BOO, FACEMASK_ANY, $0000, MarioWorldNpc0D_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_BOWSER, FACEMASK_ANY, $0000, MarioWorldNpc0FBowser_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_WARIO, FACEMASK_ANY, $0000, MarioWorldNpc10Wario_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_WALUIGI, FACEMASK_ANY, $0000, MarioWorldNpc0EWaluigi_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_TOAD, FACEMASK_ANY, $0000, MarioWorldNpc13_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_BOB_OMB, FACEMASK_ANY, $0000, MarioWorldNpc14_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_MARIO_WORLD_MARIO, FACEMASK_ANY, $0000, MarioWorldNpc12Mario_0e, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
MarioWorldFacingScripts_0e:
	ds 1, $ff ; $54cf, fill
MarioWorldTileTriggers_0e:
	db $ff ; $54d0
Unused_0e_StubNop:
	ret ; $54d1
MarioWorldInitScript_0e:
	call ComputeMarioWorldProgressIndex ; $54d2
	ld a, [wStoryModeEntryPoint] ; $54d5
	cp $0a ; $54d8
	jp z, MarioWorldArrivalSingles ; $54da
	cp $0e ; $54dd
	jp z, MarioWorldEntry0eScene ; $54df
	cp $0f ; $54e2
	jp z, MarioWorldArrivalSingles ; $54e4
	test_flag FLAG_DOUBLES ; $54e7
	jr nz, .placeActors ; $54ea
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $54ec
	ret z ; $54ef
	ld a, [wStoryModeEntryPoint] ; $54f0
	inc a ; $54f3
	jr z, .doubles ; $54f4
	script_set_speed ACTOR_PLAYER, 0.625 ; $54f6
	script_move_target ACTOR_PLAYER, 18.0, 29.0 ; $54fe
.doubles:
	jp MarioWorldEntry0eScene.placeActors ; $5509
.placeActors:
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $550c
	ret z ; $550f
	ld a, [wStoryModeEntryPoint] ; $5510
	inc a ; $5513
	jr z, .done ; $5514
	script_set_speed ACTOR_PLAYER, 0.625 ; $5516
	script_move_target ACTOR_PLAYER, 18.0, 29.0 ; $551e
.done:
	jp MarioWorldEntry0eScene.placeActors ; $5529
	ret ; $552c
ActorScript_0e_06:
	; $552d, 24 bytes (actor_script)
	as_set_target 25.0, 11.0
	as_wait_move
	as_set_target 27.0, 11.0
	as_wait_move
	as_set_target 27.25, 10.0
	as_wait_move
	as_set_pos 21.0, 61.0
	as_halt
ActorScript_0e_07:
	; $5545, 24 bytes (actor_script)
	as_set_target 23.0, 11.0
	as_wait_move
	as_set_target 27.0, 11.0
	as_wait_move
	as_set_target 27.25, 10.0
	as_wait_move
	as_set_pos 21.0, 61.0
	as_halt
ComputeMarioWorldProgressIndex:
	test_flag FLAG_DOUBLES ; $555d
	jr nz, .doublesStage ; $5560
	ld a, $00 ; $5562
	test_flag FLAG_WON_DREAM_MATCH_SINGLES ; $5564
	jr z, .loop ; $5567
	inc a ; $5569
.loop:
	ld [wMapSceneStage], a ; $556a
	ret ; $556d
.doublesStage:
	ld a, $02 ; $556e
	test_flag FLAG_WON_DREAM_MATCH_DOUBLES ; $5570
	jr z, .loop ; $5573
	inc a ; $5575
	jr .loop ; $5576
	ret ; $5578
MarioWorldArrivalSingles:
	test_flag FLAG_DOUBLES ; $5579
	jp nz, MarioWorldArrivalDoubles ; $557c
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $557f
	jr nz, .arrive ; $5582
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5584
	jp nz, MarioWorldEntry0eScene.singles ; $5587
.arrive:
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $558a
	script_fade_in 4 ; $5595
	call WaitFadeEnd ; $559a
	script_wait_frames 40 ; $559d
	call MarioWorldArrivalIntroCutscene ; $55a4
	script_set_position ACTOR_PLAYER, 18.0, 37.0 ; $55a7
	script_set_speed ACTOR_PLAYER, 0.5 ; $55b2
	script_move_target ACTOR_PLAYER, 18.0, 32.5 ; $55ba
	script_player_speed 0.5 ; $55c5
	script_move_player 18.0, 27.0 ; $55cb
	script_wait_frames 80 ; $55d5
	script_face ACTOR_MARIO_WORLD_TOAD, FACE_UP ; $55dc
	script_wait_frames 10 ; $55e3
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $55ea
	jr nz, .walkIn ; $55ed
	script_set_text Text_5e_75 ; $55ef
	script_speak ACTOR_MARIO_WORLD_TOAD ; $55f5
	script_speak ACTOR_MARIO_WORLD_TOAD ; $55fa
.walkIn:
	script_player_speed 1.0 ; $55ff
	script_move_player 18.0, 24.0 ; $5605
	farcall WaitPlayerMoveDone ; $560f
	script_wait_frames 10 ; $5612
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $5619
	script_wait_idle ACTOR_MARIO_WORLD_PEACH ; $5620
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $5625
	jr nz, .approach ; $5628
	script_speak ACTOR_MARIO_WORLD_PEACH ; $562a
.approach:
	script_player_speed 0.625 ; $562f
	script_set_speed ACTOR_PLAYER, 0.625 ; $5635
	script_set_speed ACTOR_MARIO_WORLD_TOAD, 0.625 ; $563d
	script_set_speed ACTOR_MARIO_WORLD_PEACH, 0.625 ; $5645
	script_move_target ACTOR_PLAYER, 18.0, 17.0 ; $564d
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 23.0 ; $5658
	script_wait_frames 40 ; $5663
	script_move_player 18.0, 13.0 ; $566a
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $5674
	script_move_target ACTOR_MARIO_WORLD_PEACH, 18.0, 9.0 ; $5679
	script_move_target ACTOR_MARIO_WORLD_TOAD, 18.0, 19.0 ; $5684
	script_wait_move ACTOR_MARIO_WORLD_TOAD ; $568f
	script_move_target ACTOR_MARIO_WORLD_TOAD, 13.0, 19.0 ; $5694
	script_wait_move ACTOR_MARIO_WORLD_PEACH ; $569f
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $56a4
	jr z, .done ; $56a7
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $56a9
	script_wait_frames 20 ; $56b0
	ld a, $01 ; $56b7
	ld [wUnusedExitTriggerIdMirror], a ; $56b9
	ld [wStoryModeExitTriggerRequest], a ; $56bc
	ret ; $56bf
.done:
	call MarioWorldWelcomeCutscene ; $56c0
	script_set_speed ACTOR_MARIO_WORLD_BOWSER, 1.0 ; $56c3
	script_set_speed ACTOR_MARIO_WORLD_BALLOON_ANGRY, 1.0 ; $56cb
	script_wait_frames 40 ; $56d3
	script_set_anim ACTOR_MARIO_WORLD_BOWSER, ANIM_BOUNCE ; $56da
	script_wait_idle ACTOR_MARIO_WORLD_BOWSER ; $56e1
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 15.0, 14.0 ; $56e6
	script_move_target ACTOR_MARIO_WORLD_BALLOON_ANGRY, 16.0, 12.0 ; $56f1
	script_wait_move ACTOR_MARIO_WORLD_BALLOON_ANGRY ; $56fc
	script_set_position ACTOR_MARIO_WORLD_BALLOON_ANGRY, 63.0, 63.0 ; $5701
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $570c
	script_wait_frames 20 ; $5713
	script_speak ACTOR_MARIO_WORLD_BOWSER ; $571a
	script_wait_frames 20 ; $571f
	script_set_speed ACTOR_MARIO_WORLD_WARIO, 1.0 ; $5726
	script_set_speed ACTOR_MARIO_WORLD_WALUIGI, 1.0 ; $572e
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 16.0, 13.0 ; $5736
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $5741
	script_wait_frames 10 ; $5746
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $574d
	script_move_target ACTOR_MARIO_WORLD_WARIO, 13.0, 13.0 ; $5754
	script_wait_move ACTOR_MARIO_WORLD_WARIO ; $575f
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $5764
	script_wait_frames 10 ; $576b
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $5772
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 14.0, 16.0 ; $5779
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $5784
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $5789
	script_wait_frames 40 ; $5790
	sound SFX_APPEAR2 ; $5797
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 15.0, 9.0 ; $5799
	script_wait_frames 4 ; $57a4
	sound SFX_APPEAR2 ; $57ab
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_2, 19.0, 7.0 ; $57ad
	script_wait_frames 4 ; $57b8
	sound SFX_APPEAR2 ; $57bf
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_3, 23.0, 9.0 ; $57c1
	script_wait_frames 4 ; $57cc
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_RIGHT ; $57d3
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 17.0, 13.0 ; $57da
	script_wait_move ACTOR_MARIO_WORLD_BOWSER ; $57e5
	script_face ACTOR_MARIO_WORLD_BOWSER, FACE_UP ; $57ea
	script_wait_frames 10 ; $57f1
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_RIGHT ; $57f8
	script_move_target ACTOR_MARIO_WORLD_WARIO, 15.0, 13.0 ; $57ff
	script_wait_move ACTOR_MARIO_WORLD_WARIO ; $580a
	script_face ACTOR_MARIO_WORLD_WARIO, FACE_UP ; $580f
	script_wait_frames 10 ; $5816
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_RIGHT ; $581d
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 17.0, 15.0 ; $5824
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $582f
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $5834
	script_wait_frames 10 ; $583b
	call MarioWorldLuigiDefendsChampCutscene ; $5842
	sound SFX_APPEAR2 ; $5845
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 19.5, 15.5 ; $5847
	script_wait_frames 20 ; $5852
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_LEFT ; $5859
	script_wait_frames 40 ; $5860
	script_set_anim ACTOR_MARIO_WORLD_PEACH, ANIM_NOD ; $5867
	script_set_anim ACTOR_MARIO_WORLD_MARIO, ANIM_NOD ; $586e
	script_wait_idle ACTOR_MARIO_WORLD_MARIO ; $5875
	script_wait_frames 10 ; $587a
	script_face ACTOR_MARIO_WORLD_PEACH, FACE_DOWN ; $5881
	script_wait_frames 10 ; $5888
	script_set_speed ACTOR_MARIO_WORLD_PEACH, 1.0 ; $588f
	script_move_target ACTOR_MARIO_WORLD_PEACH, 18.0, 11.0 ; $5897
	script_wait_move ACTOR_MARIO_WORLD_PEACH ; $58a2
	script_face ACTOR_MARIO_WORLD_WALK_77_05, FACE_DOWN ; $58a7
	script_face ACTOR_MARIO_WORLD_MARIO, FACE_DOWN ; $58ae
	script_set_position ACTOR_MARIO_WORLD_BALLOON_SWEAT_1, 63.0, 63.0 ; $58b5
	script_speak ACTOR_MARIO_WORLD_PEACH ; $58c0
	script_wait_frames 10 ; $58c5
	call MarioWorldExhibitionDemandCutscene ; $58cc
	script_move_target ACTOR_MARIO_WORLD_BOWSER, 19.0, 15.0 ; $58cf
	script_move_target ACTOR_MARIO_WORLD_WARIO, 17.0, 15.0 ; $58da
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 20.0, 17.0 ; $58e5
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $58f0
	script_move_target ACTOR_MARIO_WORLD_WALUIGI, 19.0, 19.0 ; $58f5
	script_wait_move ACTOR_MARIO_WORLD_WALUIGI ; $5900
	script_face ACTOR_MARIO_WORLD_WALUIGI, FACE_UP ; $5905
	script_wait_frames 40 ; $590c
	set_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5913
	farcall SaveStorySlotWithTimer ; $5916
	script_speak_restore ACTOR_MARIO_WORLD_PEACH ; $5919
	farcall RunDialogueYesNoPrompt ; $591e
	farcall ScriptCloseDialogueWindow ; $5921
	script_wait_frames 5 ; $5924
	and a ; $592b
	jr z, ExhibitionAcceptedSingles ; $592c
	script_set_text Text_5e_96 ; $592e
	call ExhibitionDeclinedCutscene ; $5934
	ret ; $5937
