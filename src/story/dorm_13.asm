LoadTourPointerSpriteGfx_13:
	push_wram_bank WRAM_STAGING ; $4cdc
	ld hl, TourPointerTiles_13 ; $4ce5
	ld de, vTiles0 + VRAM_BANK1 ; $4ce8
	ld c, (TourPointerPalette_13 - TourPointerTiles_13) / 16 ; $4ceb
	call QueueVRAMCopy ; $4ced
	ld hl, TourPointerPalette_13 ; $4cf0
	ld_obj_pals de, 0, 1 ; $4cf3
	call LoadPaletteShadow ; $4cf6
	pop_wram_bank ; $4cf9
	ret ; $4cfe
QueueTourPointerSprite_13:
	ld hl, QueueTourPointerSprite_13_SpriteTemplate ; $4cff
	ld c, $00 ; $4d02
	ld b, OAM_BANK1 ; $4d04
	call QueueSpriteTemplate ; $4d06
	ret ; $4d09
AnimateTourPointerSprite_13:
	ld a, [wMapSceneStage] ; $4d0a
	ld d, a ; $4d0d
	ldh a, [hVBlankCounter] ; $4d0e
	srl a ; $4d10
	and $07 ; $4d12
	ld e, a ; $4d14
	ld a, [wMapSceneStage2] ; $4d15
	add $08 ; $4d18
	sub e ; $4d1a
	ld e, a ; $4d1b
	call QueueTourPointerSprite_13 ; $4d1c
	ret ; $4d1f
QueueTourPointerSprite_13_SpriteTemplate:
	; $4d20, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
	; $4d29, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
TourPointerTiles_13:
	INCBIN "data/bank_013/TourPointerTiles_13.bin" ; $4d30, 64 bytes
TourPointerPalette_13:
	INCLUDE "data/bank_013/TourPointerPalette_13.asm" ; $4d70, 8 bytes (palettes)
AnimateDoorOpen_13:
	sound SFX_DOOR ; $4d78
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $4d7a
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $4d89
	script_wait_frames $02 ; $4d98
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $4d9f
	script_wait_frames $02 ; $4dae
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $4db5
	script_wait_frames $02 ; $4dc4
	ret ; $4dcb
AnimateDoorClose_13:
	sound SFX_DOOR ; $4dcc
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $4dce
	script_wait_frames $01 ; $4ddd
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $4de4
	script_wait_frames $01 ; $4df3
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $4dfa
	script_wait_frames $01 ; $4e09
	script_copy_scene_rect $06, $15, $14, $08, $02, $02 ; $4e10
	ret ; $4e1f
DormRoomMapScripts_13:
	; $4e20, 14 bytes (map_tree)
	dw DormRoomEntryPoints_13 ; slot 0 EntryPoints
	dw DormRoomExitTriggers_13 ; slot 1 ExitTriggers
	dw DormRoomActors_13 ; slot 2 Actors
	dw DormRoomNpcScripts_13 ; slot 3 NpcScripts
	dw DormRoomFacingScripts_13 ; slot 4 FacingScripts
	dw DormRoomTileTriggers_13 ; slot 5 TileTriggers
	dw DormRoomInitScript_13 ; slot 6 InitScript
DormRoomActors_13:
	; $4e2e, 52 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, $0b00, $0900, FACE_DOWN, OBJ_KATE, ANIM_WALK, $00, DORM_ROOM_KATE
	map_actor $0000, ActorScript_13_00, $0600, $1080, FACE_DOWN, OBJ_CAT, ANIM_WALK, $00, DORM_ROOM_CAT
	map_actor $0000, ActorScript_13_27, $2900, $2900, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, DORM_ROOM_BALLOON_EXCLAIM
	map_actor_end
DormRoomEntryPoints_13:
	; $4e62, 49 bytes (map_entries)
	map_entry $01, FACE_UP, $0b00, $0d00, $0000
	map_entry $02, FACE_UP, $0b00, $1300, $0000
	map_entry $03, FACE_UP, $0b00, $0d00, $0000
	map_entry $04, FACE_UP, $0b00, $0d00, $0000
	map_entry $0e, FACE_UP, $0b00, $0d00, $0000
	map_entry $0f, FACE_UP, $0b00, $0d00, $0000
	db $ff
DormRoomExitTriggers_13:
	; $4e93, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_DORM_ENTRANCE, $02
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_MAIN_MENU, $01
	db $ff
DormRoomNpc04_13:
	call AdvanceRandomSeed ; $4ea4
	ld a, l ; $4ea7
	and $07 ; $4ea8
	add $3c ; $4eaa
	ld l, a ; $4eac
	adc $05 ; $4ead
	sub l ; $4eaf
	ld h, a ; $4eb0
	farcall InitDialogueTextCursor ; $4eb1
	script_speak ACTOR_DORM_ROOM_CAT ; $4eb4
	ret ; $4eb9
DormRoomNpcScripts_13:
	; $4eba, 17 bytes (map_scripts)
	map_script ACTOR_DORM_ROOM_KATE, FACEMASK_ANY, $0000, DormRoomNpc03_13, $00, $00
	map_script ACTOR_DORM_ROOM_CAT, FACEMASK_ANY, $0000, DormRoomNpc04_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
DormRoomFacingScripts_13:
	; $4ecb, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DormRoomFacing01_13, $00, $00
	db $ff
DormRoomFacing01_13:
	farcall BeginCutsceneScriptMode ; $4ed4
	script_fade_in $10 ; $4ed7
	script_set_text Text_31_131 ; $4edc
	script_speak ACTOR_PLAYER ; $4ee2
	farcall EndCutsceneScriptMode ; $4ee7
	ret ; $4eea
DormRoomTileTriggers_13:
	; $4eeb, 9 bytes (map_scripts)
	map_script $0f, FACEMASK_DOWN, $0000, DormRoomTile0F_13, $00, $00
	db $ff
DormRoomTile0F_13:
	script_null_script ACTOR_DORM_ROOM_KATE ; $4ef4
	ld a, $03 ; $4ef9
	script_set_text Text_31_324 ; $4efb
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $4f01
	jr z, .notTempSceneVariantA ; $4f04
	script_set_text Text_31_328 ; $4f06
.notTempSceneVariantA:
	script_jump_velocity ACTOR_DORM_ROOM_KATE, $ff80 ; $4f0c
	ld a, $03 ; $4f14
	call ComputeEmoteActorPosition_13 ; $4f16
	call PlaceEmoteActorAtComputedPosition_13 ; $4f19
	sound SFX_CHIME ; $4f1c
	script_wait_frames $46 ; $4f1e
	script_set_position ACTOR_DORM_ROOM_BALLOON_EXCLAIM, $3f00, $3f00 ; $4f25
	script_speak ACTOR_DORM_ROOM_KATE ; $4f30
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ROOM_KATE ; $4f35
	script_face_toward ACTOR_DORM_ROOM_KATE, ACTOR_PLAYER ; $4f3d
	script_set_position $06, $0c00, $0800 ; $4f45
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_BOUNCE ; $4f50
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $4f57
	script_set_position $06, $3f00, $3f00 ; $4f5c
	script_speak ACTOR_DORM_ROOM_KATE ; $4f67
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4f6c
	ld a, $00 ; $4f74
	farcall ScriptWaitActorJumpDone ; $4f76
	test_flag FLAG_DOUBLES ; $4f79
	jr nz, .advanceText ; $4f7c
	script_speak ACTOR_DORM_ROOM_KATE ; $4f7e
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4f83
	script_wait_idle ACTOR_PLAYER ; $4f8a
	script_set_speed ACTOR_PLAYER, $0030 ; $4f8f
	script_move_target ACTOR_PLAYER, $0b00, $1400 ; $4f97
	script_wait_frames $0a ; $4fa2
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ROOM_KATE ; $4fa9
	ld a, STORYLOC_ACADEMY_WING ; $4fb1
	ld [wStoryModeCurrentLocation], a ; $4fb3
	ld a, $0d ; $4fb6
	ld [wStoryModeEntryPoint], a ; $4fb8
	ld a, $ff ; $4fbb
	ld [wUnusedExitTriggerIdMirror], a ; $4fbd
	ld [wStoryModeExitTriggerRequest], a ; $4fc0
	ld c, $04 ; $4fc3
	call BeginFadeOut ; $4fc5
	script_wait_frames $14 ; $4fc8
	ret ; $4fcf
.advanceText:
	farcall AdvanceDialogueTextCursor ; $4fd0
	script_speak ACTOR_DORM_ROOM_KATE ; $4fd3
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4fd8
	script_wait_idle ACTOR_PLAYER ; $4fdf
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $4fe4
	ld c, l ; $4fe9
	ld b, h ; $4fea
	ld de, wActors ; $4feb
	farcall AttachActorStepMover ; $4fee
	script_set_speed ACTOR_PLAYER, $0030 ; $4ff1
	script_move_target ACTOR_PLAYER, $0b00, $1400 ; $4ff9
	script_wait_frames $0a ; $5004
	ld a, STORYLOC_ACADEMY_WING ; $500b
	ld [wStoryModeCurrentLocation], a ; $500d
	ld a, $0d ; $5010
	ld [wStoryModeEntryPoint], a ; $5012
	ld a, $ff ; $5015
	ld [wUnusedExitTriggerIdMirror], a ; $5017
	ld [wStoryModeExitTriggerRequest], a ; $501a
	ld c, $04 ; $501d
	call BeginFadeOut ; $501f
	script_wait_frames $14 ; $5022
	ret ; $5029
DormRoomInitScript_13:
	xor a ; $502a
	ld [wStoryModeShowLocationName], a ; $502b
	ld a, [wStoryModeEntryPoint] ; $502e
	cp $0a ; $5031
	jp z, ShowStoryNarration_13.setText ; $5033
	cp $09 ; $5036
	jp z, ShowStoryNarration_13.setText2 ; $5038
	cp $08 ; $503b
	jp z, ShowStoryNarration_13.setText3 ; $503d
	call ComputeStoryRankTier_13 ; $5040
	call SetupDormRoomSceneVariant ; $5043
	call PlaceDormRoomArrivalActors_13 ; $5046
	call SetDormRoomEventTriggerCells_13 ; $5049
	ld a, [wStoryModeEntryPoint] ; $504c
	cp $0f ; $504f
	jp z, DormRoomNpc03_13.walkToBed ; $5051
	sound BGM_DORM_ROOM ; $5054
	ld a, [wStoryModeEntryPoint] ; $5056
	cp $01 ; $5059
	jp z, DormRoomNpc03_13.byStage ; $505b
	cp $02 ; $505e
	jp z, DormRoomNpc03_13.morningDoubles ; $5060
	farcall EndCutsceneScriptMode ; $5063
	ret ; $5066
SetDormRoomEventTriggerCells_13:
	test_flag FLAG_DOUBLES ; $5067
	jr nz, .doubles ; $506a
	test_flag FLAG_WON_VARSITY_SINGLES_RANK_4 ; $506c
	jr nz, .checkIslandSingles ; $506f
	jr .clearTriggers ; $5071
	ret ; $5073
.checkIslandSingles:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $5074
	jr z, .enableTriggers ; $5077
	jr .clearTriggers ; $5079
	ret ; $507b
.doubles:
	test_flag FLAG_WON_VARSITY_DOUBLES_RANK_2 ; $507c
	jr nz, .checkIslandDoubles ; $507f
	jr .clearTriggers ; $5081
	ret ; $5083
.checkIslandDoubles:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $5084
	jr z, .enableTriggers ; $5087
	jr .clearTriggers ; $5089
	ret ; $508b
.enableTriggers:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	farcall WriteBehaviorMapCell ; $5092
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	farcall WriteBehaviorMapCell ; $509b
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	farcall WriteBehaviorMapCell ; $50a4
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	farcall WriteBehaviorMapCell ; $50ad
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	farcall WriteBehaviorMapCell ; $50b6
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	farcall WriteBehaviorMapCell ; $50bf
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	farcall WriteBehaviorMapCell ; $50c8
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	farcall WriteBehaviorMapCell ; $50d1
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	farcall WriteBehaviorMapCell ; $50da
	ret ; $50dd
.clearTriggers:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	farcall WriteBehaviorMapCell ; $50e4
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	farcall WriteBehaviorMapCell ; $50ed
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	farcall WriteBehaviorMapCell ; $50f6
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	farcall WriteBehaviorMapCell ; $50ff
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	farcall WriteBehaviorMapCell ; $5108
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	farcall WriteBehaviorMapCell ; $5111
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	farcall WriteBehaviorMapCell ; $511a
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	farcall WriteBehaviorMapCell ; $5123
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	farcall WriteBehaviorMapCell ; $512c
	ret ; $512f
SetupDormRoomSceneVariant:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5130
	or a ; $5133
	jr nz, .nonZero ; $5134
	farcall WaitPlayerMoveDone ; $5136
	ld b, $20 ; $5139
	ld c, $00 ; $513b
	ld d, $00 ; $513d
	ld e, $00 ; $513f
	ld h, $16 ; $5141
	ld l, $16 ; $5143
	farcall CopyCollisionMapRect ; $5145
	ld b, $20 ; $5148
	ld c, $00 ; $514a
	ld d, $00 ; $514c
	ld e, $00 ; $514e
	ld h, $16 ; $5150
	ld l, $16 ; $5152
	farcall CopyBehaviorMapRect ; $5154
	script_copy_scene_rect $20, $00, $00, $00, $16, $18 ; $5157
	script_set_objdef OBJ_HARRY, ACTOR_DORM_ROOM_KATE ; $5166
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_WALK ; $5172
	script_set_position ACTOR_DORM_ROOM_CAT, $1f00, $1500 ; $5179
	script_null_script ACTOR_DORM_ROOM_CAT ; $5184
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $5189
	ld a, $02 ; $518c
	ld [wMapScrollMinX], a ; $518e
	ld a, $02 ; $5191
	ld [wMapScrollMinY], a ; $5193
	ld a, $16 ; $5196
	ld [wMapWidthTiles], a ; $5198
	ld a, $14 ; $519b
	ld [wMapHeightTiles], a ; $519d
	call DisableLCDSafely ; $51a0
	ld a, $00 ; $51a3
	farcall CopyScrolledSceneTilemapToVram ; $51a5
	call EnableLCD ; $51a8
	ret ; $51ab
.nonZero:
	call SetRandomDormRoomNpc04Script_13 ; $51ac
	ret ; $51af
PlaceDormRoomArrivalActors_13:
	ld a, [wStoryModeEntryPoint] ; $51b0
	cp STORYENTRY_NONE ; $51b3
	jr z, .stage3 ; $51b5
	cp $01 ; $51b7
	jr z, .stage2 ; $51b9
	wram_bank WRAM_ACTORS ; $51bb
	test_flag FLAG_DOUBLES ; $51c1
	jp nz, DormRoomNpc04IdleScripts_13.isDoubles ; $51c4
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $51c7
	ret ; $51d2
.stage2:
	test_flag FLAG_DOUBLES ; $51d3
	jr z, .stage2Singles ; $51d6
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $51d8
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $51e3
	script_null_script ACTOR_PARTNER ; $51ea
	script_set_position ACTOR_PARTNER, $0100, $0100 ; $51ef
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $51fa
	ld c, l ; $51ff
	ld b, h ; $5200
	ld hl, ACTORF_FLAGS ; $5201
	add hl, bc ; $5204
	set ACTORFLAGB_TALKABLE, [hl] ; $5205
	ret ; $5207
.stage2Singles:
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $5208
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $5213
	ret ; $521a
.stage3:
	test_flag FLAG_DOUBLES ; $521b
	jr z, .stage2Singles ; $521e
	script_null_script ACTOR_PARTNER ; $5220
	script_set_position ACTOR_PARTNER, $0100, $0100 ; $5225
	call PlaceRoommateAtPlayerTarget_13 ; $5230
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5233
	ld c, l ; $5238
	ld b, h ; $5239
	ld de, wActors ; $523a
	farcall AttachActorStepMover ; $523d
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5240
	ld c, l ; $5245
	ld b, h ; $5246
	ld hl, ACTORF_FLAGS ; $5247
	add hl, bc ; $524a
	set ACTORFLAGB_TALKABLE, [hl] ; $524b
	ret ; $524d
SetRandomDormRoomNpc04Script_13:
	call AdvanceRandomSeed ; $524e
	ld a, l ; $5251
	and $07 ; $5252
	add a ; $5254
	ld_hl_indexed DormRoomNpc04IdleScripts_13 ; $5255
	ld a, [hl+] ; $525c
	ld h, [hl] ; $525d
	ld l, a ; $525e
	ld e, l ; $525f
	ld d, h ; $5260
	ldh a, [hRomBank] ; $5261
	ld b, a ; $5263
	ld a, $04 ; $5264
	farcall ScriptSetActorScript ; $5266
	ret ; $5269
DormRoomNpc04IdleScripts_13:
	; $526a, 16 bytes (records:2)
	dw ActorScript_13_00 ; record 0
	dw ActorScript_13_01 ; record 1
	dw ActorScript_13_02 ; record 2
	dw ActorScript_13_03 ; record 3
	dw ActorScript_13_00 ; record 4
	dw ActorScript_13_00 ; record 5
	dw ActorScript_13_03 ; record 6
	dw ActorScript_13_03 ; record 7
.isDoubles:
	script_null_script ACTOR_PARTNER ; $527a
	script_set_position ACTOR_PARTNER, $1500, $1f00 ; $527f
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $1000 ; $528a
	script_face ACTOR_DORM_ROOM_KATE, FACE_UP ; $5295
	script_fade_in $04 ; $529c
	call WaitFadeEnd ; $52a1
	script_move_target ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $52a4
	ret ; $52af
DormRoomNpc03_13:
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ROOM_KATE ; $52b0
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $52b8
	jr z, .altGreeting ; $52bb
	script_set_text Text_31_289 ; $52bd
	jr .prompt ; $52c3
.altGreeting:
	script_set_text Text_31_255 ; $52c5
.prompt:
	ld a, $03 ; $52cb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $52cd
	farcall RunDialogueYesNoPrompt ; $52d0
	farcall ScriptCloseDialogueWindow ; $52d3
	script_wait_frames $05 ; $52d6
	and a ; $52dd
	jr nz, .doublesPrompt ; $52de
	call RunAcademyQuestionsMenu ; $52e0
.doublesPrompt:
	call RunPlayDoublesTodayPrompt ; $52e3
	ret ; $52e6
.byStage:
	call GetDormRoomStoryStage_13 ; $52e7
	cp $01 ; $52ea
	jp z, DormRoomArrivalCutscene_13 ; $52ec
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $52ef
	jr z, .stage2Text ; $52f2
	script_set_text Text_31_263 ; $52f4
	jr .placeActors ; $52fa
.stage2Text:
	script_set_text Text_31_258 ; $52fc
.placeActors:
	script_null_script ACTOR_PARTNER ; $5302
	script_set_position ACTOR_PARTNER, $0b00, $1e00 ; $5307
	script_face ACTOR_PARTNER, FACE_DOWN ; $5312
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $5319
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $5324
	script_fade_in $04 ; $532b
	call WaitFadeEnd ; $5330
	test_flag FLAG_DOUBLES ; $5333
	jr z, .speakShort ; $5336
	farcall AdvanceDialogueTextCursor ; $5338
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $533b
	jr nz, .speak ; $533e
	script_speak ACTOR_DORM_ROOM_KATE ; $5340
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5345
	jr z, .speak ; $5348
	farcall AdvanceDialogueTextCursor ; $534a
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $534d
	jr z, .speak ; $5350
	farcall AdvanceDialogueTextCursor ; $5352
.speak:
	script_speak ACTOR_DORM_ROOM_KATE ; $5355
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $535a
	script_wait_idle ACTOR_PLAYER ; $5361
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $5366
	ld c, l ; $536b
	ld b, h ; $536c
	ld de, wActors ; $536d
	farcall AttachActorStepMover ; $5370
	script_face ACTOR_PLAYER, FACE_DOWN ; $5373
	script_get_actor_state ACTOR_DORM_ROOM_KATE ; $537a
	ld c, l ; $537f
	ld b, h ; $5380
	ld hl, ACTORF_FLAGS ; $5381
	add hl, bc ; $5384
	set ACTORFLAGB_TALKABLE, [hl] ; $5385
	script_wait_frames $05 ; $5387
	ret ; $538e
.speakShort:
	script_speak ACTOR_DORM_ROOM_KATE ; $538f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5394
	script_wait_idle ACTOR_PLAYER ; $539b
	ret ; $53a0
.walkToBed:
	sound JINGLE_DONE_FOR_THE_DAY ; $53a1
	script_set_speed ACTOR_PLAYER, $0010 ; $53a3
	script_player_speed $0040 ; $53ab
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $53b1
	jr z, .altBedText ; $53b4
	script_set_text Text_31_278 ; $53b6
	jr .bedScene ; $53bc
.altBedText:
	script_set_text Text_31_244 ; $53be
.bedScene:
	script_set_position ACTOR_PLAYER, $0b00, $0e00 ; $53c4
	script_set_position ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $53cf
	script_move_player $0b00, $0a00 ; $53da
	farcall WaitPlayerMoveDone ; $53e4
	script_wait_frames $78 ; $53e7
	script_wait_frames $b4 ; $53ee
	script_fade_in $04 ; $53f5
	call WaitJingleEnd ; $53fa
	sound BGM_DORM_ROOM ; $53fd
	script_wait_frames $0a ; $53ff
	ld a, $03 ; $5406
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5408
	farcall RunDialogueYesNoPrompt ; $540b
	farcall ScriptCloseDialogueWindow ; $540e
	script_wait_frames $05 ; $5411
	and a ; $5418
	jr nz, .variantB ; $5419
	script_speak ACTOR_DORM_ROOM_KATE ; $541b
	farcall AdvanceDialogueTextCursor ; $5420
	jr .roommateWalks ; $5423
.variantB:
	farcall AdvanceDialogueTextCursor ; $5425
	script_speak ACTOR_DORM_ROOM_KATE ; $5428
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $542d
.roommateWalks:
	script_set_speed ACTOR_DORM_ROOM_KATE, $0010 ; $5430
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $5438
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $543f
	script_speak ACTOR_DORM_ROOM_KATE ; $5444
	script_move_target ACTOR_DORM_ROOM_KATE, $0900, $0a00 ; $5449
	script_speak ACTOR_DORM_ROOM_KATE ; $5454
	script_wait_move ACTOR_DORM_ROOM_KATE ; $5459
	script_move_target ACTOR_DORM_ROOM_KATE, $0d00, $0a00 ; $545e
	script_speak ACTOR_DORM_ROOM_KATE ; $5469
	script_wait_move ACTOR_DORM_ROOM_KATE ; $546e
	script_move_target ACTOR_DORM_ROOM_KATE, $0b00, $0a00 ; $5473
	script_wait_move ACTOR_DORM_ROOM_KATE ; $547e
	script_face_toward ACTOR_PLAYER, ACTOR_DORM_ROOM_KATE ; $5483
	ld a, $03 ; $548b
	farcall ScriptShowSpeakerDialogueRestoreBG ; $548d
	farcall RunDialogueYesNoPrompt ; $5490
	farcall ScriptCloseDialogueWindow ; $5493
	script_wait_frames $05 ; $5496
	and a ; $549d
	jr nz, .variantBAlt ; $549e
	script_speak ACTOR_DORM_ROOM_KATE ; $54a0
	farcall AdvanceDialogueTextCursor ; $54a5
	jr .continueScene ; $54a8
.variantBAlt:
	farcall AdvanceDialogueTextCursor ; $54aa
	script_speak ACTOR_DORM_ROOM_KATE ; $54ad
.continueScene:
	script_move_target ACTOR_DORM_ROOM_KATE, $0b00, $0b00 ; $54b2
	script_wait_move ACTOR_DORM_ROOM_KATE ; $54bd
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_BOUNCE ; $54c2
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $54c9
	script_speak ACTOR_DORM_ROOM_KATE ; $54ce
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $54d3
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $54da
	script_speak ACTOR_DORM_ROOM_KATE ; $54df
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $54e4
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $54eb
	ld a, $03 ; $54f0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $54f2
	farcall RunDialogueYesNoPrompt ; $54f5
	farcall ScriptCloseDialogueWindow ; $54f8
	script_wait_frames $05 ; $54fb
	and a ; $5502
	jr nz, .sleepScene ; $5503
	call RunAcademyQuestionsMenu ; $5505
.sleepScene:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5508
	jr nz, .morningText ; $550b
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $550d
	jr nz, .wakeScene ; $5510
	script_wait_frames $14 ; $5512
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $5519
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $5520
	script_set_text Text_31_256 ; $5525
	script_speak ACTOR_DORM_ROOM_KATE ; $552b
	ret ; $5530
.wakeScene:
	script_wait_frames $14 ; $5531
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $5538
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $553f
	script_set_text Text_31_257 ; $5544
	script_speak ACTOR_DORM_ROOM_KATE ; $554a
	ret ; $554f
.morningText:
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $5550
	jr nz, .morningSpeak ; $5553
	script_wait_frames $14 ; $5555
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $555c
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $5563
	script_set_text Text_31_291 ; $5568
	script_speak ACTOR_DORM_ROOM_KATE ; $556e
	ret ; $5573
.morningSpeak:
	script_wait_frames $14 ; $5574
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $557b
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $5582
	script_set_text Text_31_290 ; $5587
	script_speak ACTOR_DORM_ROOM_KATE ; $558d
	ret ; $5592
.morningDoubles:
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5593
	jr z, .morningAlt ; $5596
	ld hl, wMapScratch ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr .morningEnd ; $55a1
.morningAlt:
	ld hl, wMapScratch ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
.morningEnd:
	ld hl, wMapScratch ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	farcall InitDialogueTextCursor ; $55b2
	test_flag FLAG_DOUBLES ; $55b5
	jr z, .dayStart ; $55b8
	farcall AdvanceDialogueTextCursor ; $55ba
.dayStart:
	script_wait_frames $1e ; $55bd
	script_move_target ACTOR_PLAYER, $0b00, $0e00 ; $55c4
	script_fade_in $04 ; $55cf
	call WaitFadeEnd ; $55d4
	script_move_player $0b00, $0c40 ; $55d7
	farcall WaitPlayerMoveDone ; $55e1
	script_face ACTOR_DORM_ROOM_KATE, FACE_DOWN ; $55e4
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $55eb
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $55f2
	script_speak ACTOR_DORM_ROOM_KATE ; $55f7
	call GetDormRoomStoryStage_13 ; $55fc
	and a ; $55ff
	jp z, .dayText ; $5600
	ld hl, wMapScratch ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr .daySpeak ; $560b
.dayText:
	ld hl, wMapScratch ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
.daySpeak:
	add l ; $5615
	ld l, a ; $5616
	jr nc, .dayScene ; $5617
	inc h ; $5619
.dayScene:
	farcall InitDialogueTextCursor ; $561a
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_SHAKE ; $561d
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $5624
	ld a, $03 ; $5629
	farcall ScriptShowSpeakerDialogueRestoreBG ; $562b
	farcall RunDialogueYesNoPrompt ; $562e
	farcall ScriptCloseDialogueWindow ; $5631
	script_wait_frames $05 ; $5634
	and a ; $563b
	jr nz, .finalText ; $563c
	ld hl, wMapScratch ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add l ; $5646
	ld l, a ; $5647
	jr nc, .dayEnd ; $5648
	inc h ; $564a
.dayEnd:
	farcall InitDialogueTextCursor ; $564b
	script_speak ACTOR_DORM_ROOM_KATE ; $564e
	sound BGM_NONE ; $5653
	script_wait_frames $02 ; $5655
	sound JINGLE_DONE_FOR_THE_DAY ; $565c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $565e
	script_set_anim ACTOR_DORM_ROOM_KATE, ANIM_NOD ; $5665
	script_wait_idle ACTOR_DORM_ROOM_KATE ; $566c
	call WaitJingleEnd ; $5671
	ld c, $04 ; $5674
	call BeginFadeOut ; $5676
	call WaitFadeEnd ; $5679
	ld a, $02 ; $567c
	ld [wUnusedExitTriggerIdMirror], a ; $567e
	ld [wStoryModeExitTriggerRequest], a ; $5681
	ld b, STORYLOC_DORM_ROOM ; $5684
	ld c, $01 ; $5686
	farcall SaveStoryReturnPoint ; $5688
	farcall SaveStorySlotWithTimer ; $568b
	ret ; $568e
.finalText:
	ld hl, wMapScratch ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add l ; $5697
	ld l, a ; $5698
	jr nc, .finalSpeak ; $5699
	inc h ; $569b
.finalSpeak:
	farcall InitDialogueTextCursor ; $569c
	ld a, $03 ; $569f
	farcall ScriptShowSpeakerDialogueRestoreBG ; $56a1
	farcall RunDialogueYesNoPrompt ; $56a4
	farcall ScriptCloseDialogueWindow ; $56a7
	script_wait_frames $05 ; $56aa
	and a ; $56b1
	jr nz, .done ; $56b2
	call RunAcademyQuestionsMenu ; $56b4
.done:
	call RunPlayDoublesTodayPrompt ; $56b7
	ret ; $56ba
