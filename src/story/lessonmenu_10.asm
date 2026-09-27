RunStrokeLessonMenu:
	ld hl, Text_37_15 ; $4594
	ld de, $0101 ; $4597
	ld a, $01 ; $459a
	farcall RunPagedTextMenu ; $459c
	cp $ff ; $459f
	jp z, RunDoublesMatchListMenu.done ; $45a1
	add MINIGAME_STROKE_PRACTICE_1 ; $45a4
	ld [wCurrentMinigameStoryMatch + 1], a ; $45a6
	ld hl, wStoryModePlayersXPosition ; $45a9
	ld de, wStoryModeSpawnPosition ; $45ac
	ld bc, $0005 ; $45af
	call CopyMemoryBC ; $45b2
	ld a, STORYENTRY_NONE ; $45b5
	ld [wStoryModeEntryPoint], a ; $45b7
	ld [wUnusedExitTriggerIdMirror], a ; $45ba
	ld [wStoryModeExitTriggerRequest], a ; $45bd
	ld c, $10 ; $45c0
	call BeginFadeOut ; $45c2
	call WaitFadeEnd ; $45c5
	farcall ShowDrillBriefingScreen ; $45c8
	ret ; $45cb
ShowRankingBoardSamples:
	ld hl, wStoryModePlayersXPosition ; $45cc
	ld de, wStoryModeSpawnPosition ; $45cf
	ld bc, $0005 ; $45d2
	call CopyMemoryBC ; $45d5
	ld a, STORYENTRY_NONE ; $45d8
	ld [wStoryModeEntryPoint], a ; $45da
	ld [wUnusedExitTriggerIdMirror], a ; $45dd
	ld [wStoryModeExitTriggerRequest], a ; $45e0
	ld c, $10 ; $45e3
	call BeginFadeOut ; $45e5
	call WaitFadeEnd ; $45e8
	call ClearFrameTasks ; $45eb
	xor a ; $45ee
	ldh [hBGColumnBlitPending], a ; $45ef
	ldh [hBGRowBlitPending], a ; $45f1
	ldh [hScrollY], a ; $45f3
	ldh [hScrollX], a ; $45f5
	ld [wCameraX + 1], a ; $45f7
	ld [wCameraY + 1], a ; $45fa
	call ClearFrameTasks ; $45fd
	ld b, $00 ; $4600
	ld c, $01 ; $4602
	ld d, $00 ; $4604
	farcall ShowRankingBoard ; $4606
	xor a ; $4609
	ldh [hBGColumnBlitPending], a ; $460a
	ldh [hBGRowBlitPending], a ; $460c
	ldh [hScrollY], a ; $460e
	ldh [hScrollX], a ; $4610
	ld [wCameraX + 1], a ; $4612
	ld [wCameraY + 1], a ; $4615
	call ClearFrameTasks ; $4618
	ld b, $00 ; $461b
	ld c, $02 ; $461d
	ld d, $00 ; $461f
	farcall ShowRankingBoard ; $4621
	xor a ; $4624
	ldh [hBGColumnBlitPending], a ; $4625
	ldh [hBGRowBlitPending], a ; $4627
	ldh [hScrollY], a ; $4629
	ldh [hScrollX], a ; $462b
	ld [wCameraX + 1], a ; $462d
	ld [wCameraY + 1], a ; $4630
	call ClearFrameTasks ; $4633
	ld b, $00 ; $4636
	ld c, $03 ; $4638
	ld d, $00 ; $463a
	farcall ShowRankingBoard ; $463c
	ret ; $463f
RunMinigameSelectMenu:
	ld hl, Text_31_150 ; $4640
	ld a, $03 ; $4643
	farcall RunPagedTextMenu ; $4645
	cp $ff ; $4648
	jp z, RunDoublesMatchListMenu.done ; $464a
	ld de, MinigameSelectMenuTable ; $464d
	add e ; $4650
	ld e, a ; $4651
	jr nc, .runPagedTextMenu ; $4652
	inc d ; $4654
.runPagedTextMenu:
	ld hl, Text_31_153 ; $4655
	ld a, $01 ; $4658
	farcall RunPagedTextMenu ; $465a
	cp $ff ; $465d
	jp z, RunMinigameSelectMenu ; $465f
	ld [wMinigameLevel], a ; $4662
	ld a, [de] ; $4665
	set_flag FLAG_DRILL_FROM_MENU ; $4666
	farcall RunTrainingDrillByID ; $4669
	ld hl, wStoryModePlayersXPosition ; $466c
	ld de, wStoryModeSpawnPosition ; $466f
	ld bc, $0005 ; $4672
	call CopyMemoryBC ; $4675
	ld a, STORYENTRY_NONE ; $4678
	ld [wStoryModeEntryPoint], a ; $467a
	ld [wUnusedExitTriggerIdMirror], a ; $467d
	ld [wStoryModeExitTriggerRequest], a ; $4680
	ret ; $4683
MinigameSelectMenuTable:
	; $4684, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
Test2MapScripts_10:
	; $468d, 14 bytes (map_tree)
	dw Test2EntryPoints_10 ; slot 0 EntryPoints
	dw Test2ExitTriggers_10 ; slot 1 ExitTriggers
	dw Test2Actors_10 ; slot 2 Actors
	dw Test2NpcScripts_10 ; slot 3 NpcScripts
	dw Test2FacingScripts_10 ; slot 4 FacingScripts
	dw Test2TileTriggers_10 ; slot 5 TileTriggers
	dw Test2InitScript_10 ; slot 6 InitScript
Test2Actors_10:
	; $469b, 234 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $0500, $0f00, FACE_DOWN, OBJ_WALK_74_01, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0500, FACE_DOWN, OBJ_NINA, $01, $07
	map_actor $0000, ActorScript_10_2, $0500, $0300, FACE_DOWN, OBJ_ALEX, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0900, FACE_DOWN, OBJ_KATE, $01, $05
	map_actor $0000, ActorScript_10_2, $0500, $0700, FACE_DOWN, OBJ_HARRY, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0d00, FACE_DOWN, OBJ_MARIO, $01, $07
	map_actor $0000, ActorScript_10_2, $0500, $0b00, FACE_DOWN, OBJ_BOWSER, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $1100, FACE_DOWN, OBJ_WALUIGI, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0300, FACE_DOWN, OBJ_WALK_71_02, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0500, FACE_DOWN, OBJ_WALK_71_02, $01, $07
	map_actor $0000, ActorScript_10_2, $0d00, $0700, FACE_DOWN, OBJ_WALK_71_03, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0900, FACE_DOWN, OBJ_WALK_71_03, $01, $05
	map_actor $0000, ActorScript_10_2, $0d00, $0b00, FACE_DOWN, OBJ_WALK_71_02, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0d00, FACE_DOWN, OBJ_WALK_71_02, $01, $07
	map_actor $0000, ActorScript_10_2, $0d00, $0f00, FACE_DOWN, OBJ_WALK_71_03, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $1100, FACE_DOWN, OBJ_WALK_71_03, $01, $00
	map_actor_end
Test2EntryPoints_10:
	; $4785, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0900, $0d00, $0000
	db $ff
Test2ExitTriggers_10:
	; $478e, 65 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0b
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0c
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0d
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES, $0f
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_SENIOR_CLASS_COURT, $01
	map_script $07, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $01
	map_script $08, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_MAIN_MENU, $01
	db $ff
	ld hl, wStoryModePlayersXPosition ; $47cf
	ld de, wStoryModeSpawnPosition ; $47d2
	ld bc, $0005 ; $47d5
	call CopyMemoryBC ; $47d8
	ld a, STORYENTRY_NONE ; $47db
	ld [wStoryModeEntryPoint], a ; $47dd
	ld [wUnusedExitTriggerIdMirror], a ; $47e0
	ld [wStoryModeExitTriggerRequest], a ; $47e3
	set_flag FLAG_DRILL_FROM_MENU ; $47e6
	ld hl, $0001 ; $47e9
	farcall PushTextArgNumber ; $47ec
	script_set_text Text_30_353 ; $47ef
	script_speak $80 ; $47f5
	ld a, MINIGAME_SERVICE_MATCH_2 ; $47fa
	farcall RunTrainingDrillByID ; $47fc
	ret ; $47ff
; Test2Npc0B_10 with actor $04 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc04:
	ld hl, wStoryModePlayersXPosition ; $4800
	ld de, wStoryModeSpawnPosition ; $4803
	ld bc, $0005 ; $4806
	call CopyMemoryBC ; $4809
	ld a, STORYENTRY_NONE ; $480c
	ld [wStoryModeEntryPoint], a ; $480e
	ld [wUnusedExitTriggerIdMirror], a ; $4811
	ld [wStoryModeExitTriggerRequest], a ; $4814
	set_flag FLAG_DRILL_FROM_MENU ; $4817
	ld hl, $0002 ; $481a
	farcall PushTextArgNumber ; $481d
	script_set_text Text_30_353 ; $4820
	script_speak $80 ; $4826
	ld a, MINIGAME_SERVICE_MATCH_3 ; $482b
	farcall RunTrainingDrillByID ; $482d
	ret ; $4830
; Test2Npc0B_10 with actor $05 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc05:
	ld hl, wStoryModePlayersXPosition ; $4831
	ld de, wStoryModeSpawnPosition ; $4834
	ld bc, $0005 ; $4837
	call CopyMemoryBC ; $483a
	ld a, STORYENTRY_NONE ; $483d
	ld [wStoryModeEntryPoint], a ; $483f
	ld [wUnusedExitTriggerIdMirror], a ; $4842
	ld [wStoryModeExitTriggerRequest], a ; $4845
	set_flag FLAG_DRILL_FROM_MENU ; $4848
	ld hl, $0003 ; $484b
	farcall PushTextArgNumber ; $484e
	script_set_text Text_30_353 ; $4851
	script_speak $80 ; $4857
	ld a, MINIGAME_SERVICE_PRACTICE_1 ; $485c
	farcall RunTrainingDrillByID ; $485e
	ret ; $4861
; Test2Npc0B_10 with actor $06 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc06:
	ld hl, wStoryModePlayersXPosition ; $4862
	ld de, wStoryModeSpawnPosition ; $4865
	ld bc, $0005 ; $4868
	call CopyMemoryBC ; $486b
	ld a, STORYENTRY_NONE ; $486e
	ld [wStoryModeEntryPoint], a ; $4870
	ld [wUnusedExitTriggerIdMirror], a ; $4873
	ld [wStoryModeExitTriggerRequest], a ; $4876
	set_flag FLAG_DRILL_FROM_MENU ; $4879
	ld hl, $0004 ; $487c
	farcall PushTextArgNumber ; $487f
	script_set_text Text_30_353 ; $4882
	script_speak $80 ; $4888
	ld a, MINIGAME_SERVICE_PRACTICE_2 ; $488d
	farcall RunTrainingDrillByID ; $488f
	ret ; $4892
; Test2Npc0B_10 with actor $07 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc07:
	ld hl, wStoryModePlayersXPosition ; $4893
	ld de, wStoryModeSpawnPosition ; $4896
	ld bc, $0005 ; $4899
	call CopyMemoryBC ; $489c
	ld a, STORYENTRY_NONE ; $489f
	ld [wStoryModeEntryPoint], a ; $48a1
	ld [wUnusedExitTriggerIdMirror], a ; $48a4
	ld [wStoryModeExitTriggerRequest], a ; $48a7
	set_flag FLAG_DRILL_FROM_MENU ; $48aa
	ld hl, $0005 ; $48ad
	farcall PushTextArgNumber ; $48b0
	script_set_text Text_30_353 ; $48b3
	script_speak $80 ; $48b9
	ld a, MINIGAME_SERVICE_PRACTICE_3 ; $48be
	farcall RunTrainingDrillByID ; $48c0
	ret ; $48c3
; Test2Npc0B_10 with actor $08 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc08:
	ld hl, wStoryModePlayersXPosition ; $48c4
	ld de, wStoryModeSpawnPosition ; $48c7
	ld bc, $0005 ; $48ca
	call CopyMemoryBC ; $48cd
	ld a, STORYENTRY_NONE ; $48d0
	ld [wStoryModeEntryPoint], a ; $48d2
	ld [wUnusedExitTriggerIdMirror], a ; $48d5
	ld [wStoryModeExitTriggerRequest], a ; $48d8
	set_flag FLAG_DRILL_FROM_MENU ; $48db
	ld hl, $0006 ; $48de
	farcall PushTextArgNumber ; $48e1
	script_set_text Text_30_353 ; $48e4
	script_speak $80 ; $48ea
	ld a, MINIGAME_NET_GAME_MATCH_1 ; $48ef
	farcall RunTrainingDrillByID ; $48f1
	ret ; $48f4
; Test2Npc0B_10 with actor $09 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc09:
	ld hl, wStoryModePlayersXPosition ; $48f5
	ld de, wStoryModeSpawnPosition ; $48f8
	ld bc, $0005 ; $48fb
	call CopyMemoryBC ; $48fe
	ld a, STORYENTRY_NONE ; $4901
	ld [wStoryModeEntryPoint], a ; $4903
	ld [wUnusedExitTriggerIdMirror], a ; $4906
	ld [wStoryModeExitTriggerRequest], a ; $4909
	set_flag FLAG_DRILL_FROM_MENU ; $490c
	ld hl, $0007 ; $490f
	farcall PushTextArgNumber ; $4912
	script_set_text Text_30_353 ; $4915
	script_speak $80 ; $491b
	ld a, MINIGAME_NET_GAME_MATCH_2 ; $4920
	farcall RunTrainingDrillByID ; $4922
	ret ; $4925
; Test2Npc0B_10 with actor $0a in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc0A:
	ld hl, wStoryModePlayersXPosition ; $4926
	ld de, wStoryModeSpawnPosition ; $4929
	ld bc, $0005 ; $492c
	call CopyMemoryBC ; $492f
	ld a, STORYENTRY_NONE ; $4932
	ld [wStoryModeEntryPoint], a ; $4934
	ld [wUnusedExitTriggerIdMirror], a ; $4937
	ld [wStoryModeExitTriggerRequest], a ; $493a
	set_flag FLAG_DRILL_FROM_MENU ; $493d
	ld hl, $0008 ; $4940
	farcall PushTextArgNumber ; $4943
	script_set_text Text_30_353 ; $4946
	script_speak $80 ; $494c
	ld a, MINIGAME_NET_GAME_MATCH_3 ; $4951
	farcall RunTrainingDrillByID ; $4953
	ret ; $4956
Test2Npc0B_10:
	ld hl, wStoryModePlayersXPosition ; $4957
	ld de, wStoryModeSpawnPosition ; $495a
	ld bc, $0005 ; $495d
	call CopyMemoryBC ; $4960
	ld a, STORYENTRY_NONE ; $4963
	ld [wStoryModeEntryPoint], a ; $4965
	ld [wUnusedExitTriggerIdMirror], a ; $4968
	ld [wStoryModeExitTriggerRequest], a ; $496b
	set_flag FLAG_DRILL_FROM_MENU ; $496e
	ld hl, $0009 ; $4971
	farcall PushTextArgNumber ; $4974
	script_set_text Text_30_353 ; $4977
	script_speak $80 ; $497d
	ld a, MINIGAME_NET_GAME_PRACTICE_1 ; $4982
	farcall RunTrainingDrillByID ; $4984
	ret ; $4987
Test2Npc0C_10:
	ld hl, wStoryModePlayersXPosition ; $4988
	ld de, wStoryModeSpawnPosition ; $498b
	ld bc, $0005 ; $498e
	call CopyMemoryBC ; $4991
	ld a, STORYENTRY_NONE ; $4994
	ld [wStoryModeEntryPoint], a ; $4996
	ld [wUnusedExitTriggerIdMirror], a ; $4999
	ld [wStoryModeExitTriggerRequest], a ; $499c
	set_flag FLAG_DRILL_FROM_MENU ; $499f
	ld hl, $000a ; $49a2
	farcall PushTextArgNumber ; $49a5
	script_set_text Text_30_353 ; $49a8
	script_speak $80 ; $49ae
	ld a, MINIGAME_NET_GAME_PRACTICE_2 ; $49b3
	farcall RunTrainingDrillByID ; $49b5
	ret ; $49b8
Test2Npc0D_10:
	ld hl, wStoryModePlayersXPosition ; $49b9
	ld de, wStoryModeSpawnPosition ; $49bc
	ld bc, $0005 ; $49bf
	call CopyMemoryBC ; $49c2
	ld a, STORYENTRY_NONE ; $49c5
	ld [wStoryModeEntryPoint], a ; $49c7
	ld [wUnusedExitTriggerIdMirror], a ; $49ca
	ld [wStoryModeExitTriggerRequest], a ; $49cd
	set_flag FLAG_DRILL_FROM_MENU ; $49d0
	ld hl, $000b ; $49d3
	farcall PushTextArgNumber ; $49d6
	script_set_text Text_30_353 ; $49d9
	script_speak $80 ; $49df
	ld a, MINIGAME_NET_GAME_PRACTICE_3 ; $49e4
	farcall RunTrainingDrillByID ; $49e6
	ret ; $49e9
Test2Npc0E_10:
	ld hl, wStoryModePlayersXPosition ; $49ea
	ld de, wStoryModeSpawnPosition ; $49ed
	ld bc, $0005 ; $49f0
	call CopyMemoryBC ; $49f3
	ld a, STORYENTRY_NONE ; $49f6
	ld [wStoryModeEntryPoint], a ; $49f8
	ld [wUnusedExitTriggerIdMirror], a ; $49fb
	ld [wStoryModeExitTriggerRequest], a ; $49fe
	set_flag FLAG_DRILL_FROM_MENU ; $4a01
	ld hl, $000c ; $4a04
	farcall PushTextArgNumber ; $4a07
	script_set_text Text_30_353 ; $4a0a
	script_speak $80 ; $4a10
	ld a, MINIGAME_STROKE_MATCH_1 ; $4a15
	farcall RunTrainingDrillByID ; $4a17
	ret ; $4a1a
Test2Npc0F_10:
	ld hl, wStoryModePlayersXPosition ; $4a1b
	ld de, wStoryModeSpawnPosition ; $4a1e
	ld bc, $0005 ; $4a21
	call CopyMemoryBC ; $4a24
	ld a, STORYENTRY_NONE ; $4a27
	ld [wStoryModeEntryPoint], a ; $4a29
	ld [wUnusedExitTriggerIdMirror], a ; $4a2c
	ld [wStoryModeExitTriggerRequest], a ; $4a2f
	set_flag FLAG_DRILL_FROM_MENU ; $4a32
	ld hl, $000d ; $4a35
	farcall PushTextArgNumber ; $4a38
	script_set_text Text_30_353 ; $4a3b
	script_speak $80 ; $4a41
	ld a, MINIGAME_STROKE_MATCH_2 ; $4a46
	farcall RunTrainingDrillByID ; $4a48
	ret ; $4a4b
Test2Npc10_10:
	ld hl, wStoryModePlayersXPosition ; $4a4c
	ld de, wStoryModeSpawnPosition ; $4a4f
	ld bc, $0005 ; $4a52
	call CopyMemoryBC ; $4a55
	ld a, STORYENTRY_NONE ; $4a58
	ld [wStoryModeEntryPoint], a ; $4a5a
	ld [wUnusedExitTriggerIdMirror], a ; $4a5d
	ld [wStoryModeExitTriggerRequest], a ; $4a60
	set_flag FLAG_DRILL_FROM_MENU ; $4a63
	ld hl, $000e ; $4a66
	farcall PushTextArgNumber ; $4a69
	script_set_text Text_30_353 ; $4a6c
	script_speak $80 ; $4a72
	ld a, MINIGAME_STROKE_MATCH_3 ; $4a77
	farcall RunTrainingDrillByID ; $4a79
	ret ; $4a7c
Test2Npc11_10:
	ld hl, wStoryModePlayersXPosition ; $4a7d
	ld de, wStoryModeSpawnPosition ; $4a80
	ld bc, $0005 ; $4a83
	call CopyMemoryBC ; $4a86
	ld a, STORYENTRY_NONE ; $4a89
	ld [wStoryModeEntryPoint], a ; $4a8b
	ld [wUnusedExitTriggerIdMirror], a ; $4a8e
	ld [wStoryModeExitTriggerRequest], a ; $4a91
	set_flag FLAG_DRILL_FROM_MENU ; $4a94
	ld hl, $000f ; $4a97
	farcall PushTextArgNumber ; $4a9a
	script_set_text Text_30_353 ; $4a9d
	script_speak $80 ; $4aa3
	ld a, MINIGAME_STROKE_PRACTICE_1 ; $4aa8
	farcall RunTrainingDrillByID ; $4aaa
	ret ; $4aad
Test2Npc12_10:
	ld hl, wStoryModePlayersXPosition ; $4aae
	ld de, wStoryModeSpawnPosition ; $4ab1
	ld bc, $0005 ; $4ab4
	call CopyMemoryBC ; $4ab7
	ld a, STORYENTRY_NONE ; $4aba
	ld [wStoryModeEntryPoint], a ; $4abc
	ld [wUnusedExitTriggerIdMirror], a ; $4abf
	ld [wStoryModeExitTriggerRequest], a ; $4ac2
	set_flag FLAG_DRILL_FROM_MENU ; $4ac5
	ld hl, $0010 ; $4ac8
	farcall PushTextArgNumber ; $4acb
	script_set_text Text_30_353 ; $4ace
	script_speak $80 ; $4ad4
	ld a, MINIGAME_STROKE_PRACTICE_2 ; $4ad9
	farcall RunTrainingDrillByID ; $4adb
	ret ; $4ade
Test2NpcScripts_10:
	; $4adf, 129 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_33_33, $00, $00
	map_script $04, FACEMASK_ANY, $0000, Text_33_34, $00, $00
	map_script $05, FACEMASK_ANY, $0000, Text_33_35, $00, $00
	map_script $06, FACEMASK_ANY, $0000, Text_33_36, $00, $00
	map_script $07, FACEMASK_ANY, $0000, Text_33_37, $00, $00
	map_script $08, FACEMASK_ANY, $0000, Text_33_38, $00, $00
	map_script $09, FACEMASK_ANY, $0000, Text_33_39, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_33_40, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, Test2Npc0B_10, $00, $00
	map_script $0c, FACEMASK_ANY, $0000, Test2Npc0C_10, $00, $00
	map_script $0d, FACEMASK_ANY, $0000, Test2Npc0D_10, $00, $00
	map_script $0e, FACEMASK_ANY, $0000, Test2Npc0E_10, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, Test2Npc0F_10, $00, $00
	map_script $10, FACEMASK_ANY, $0000, Test2Npc10_10, $00, $00
	map_script $11, FACEMASK_ANY, $0000, Test2Npc11_10, $00, $00
	map_script $12, FACEMASK_ANY, $0000, Test2Npc12_10, $00, $00
	db $ff
Test2FacingScripts_10:
	; $4b60, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Test2Facing01_10, $00, $00
	db $ff
Test2Facing01_10:
	farcall BeginCutsceneScriptMode ; $4b69
	script_fade_in $10 ; $4b6c
	script_set_text Text_31_131 ; $4b71
	script_speak ACTOR_PLAYER ; $4b77
	farcall EndCutsceneScriptMode ; $4b7c
	ret ; $4b7f
Test2TileTriggers_10:
	; $4b80, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Test2Tile01_10, $00, $00
	db $ff
Test2Tile01_10:
	farcall BeginCutsceneScriptMode ; $4b89
	script_set_text Text_31_128 ; $4b8c
	script_speak ACTOR_PLAYER ; $4b92
	farcall EndCutsceneScriptMode ; $4b97
	ret ; $4b9a
Test2InitScript_10:
	ld a, [wStoryModeEntryPoint] ; $4b9b
	cp $0f ; $4b9e
	ret z ; $4ba0
	farcall ClearStatusSetupMenuEntry ; $4ba1
	ld a, a ; $4ba4
	ld [wUnusedExitTriggerIdMirror], a ; $4ba5
	ld [wStoryModeExitTriggerRequest], a ; $4ba8
	ret ; $4bab
Unused_10_RunWaterSpriteMinigame:
	farcall InitMinigameMatchSettings ; $4bac
	ld a, COURT_GRASS ; $4baf
	ld [wCurrentlyUsedCourt], a ; $4bb1
	ld a, $02 ; $4bb4
	ld [wOnCourtCharCount], a ; $4bb6
	ldh a, [hRomBank] ; $4bb9
	ld de, WaterSpriteModeHooks_10 ; $4bbb
	farcall SetModeHookTable ; $4bbe
	ld de, Test2InitScriptMinigamePointTable_10 ; $4bc1
	farcall SetMinigamePointTable ; $4bc4
	ld a, CHAR_MARIO ; $4bc7
	ld [wMatchPlayerChar], a ; $4bc9
	ld a, CHAR_ALLIE ; $4bcc
	ld [wMatchOpponentChar], a ; $4bce
	farcall RunN64ExhibData ; $4bd1
	farcall RunMinigameMatch ; $4bd4
	ret ; $4bd7
