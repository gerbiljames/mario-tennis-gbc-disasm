TennisMachineRoomNpc05TextIds:
	; $4600, 18 bytes (text_ids)
	dw Text_6e_169 ; record 0
	dw Text_6e_180 ; record 1
	dw Text_6e_187 ; record 2
	dw Text_6e_194 ; record 3
	dw Text_6e_201 ; record 4
	dw Text_6e_209 ; record 5
	dw Text_6e_216 ; record 6
	dw Text_6e_209 ; record 7
	dw Text_6e_216 ; record 8
MachinePracticeLevelPrompt:
	ld [wMapScratch + 6], a ; $4612
	call TestMachineLevelClearedFlag ; $4615
	jr z, MachineLevelNotClearedMessage ; $4618
	script_set_text Text_6e_224 ; $461a
	ld a, [wMapScratch + 6] ; $4620
	inc a ; $4623
	ld h, $00 ; $4624
	ld l, a ; $4626
	farcall PushTextArgNumber ; $4627
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $462a
	farcall RunDialogueYesNoPrompt ; $462f
	farcall ScriptCloseDialogueWindow ; $4632
	script_wait_frames 5 ; $4635
	and a ; $463c
	jr nz, .done ; $463d
	script_face ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, FACE_UP ; $463f
	script_set_speed ACTOR_PLAYER, $0020 ; $4646
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $464e
	script_wait_move ACTOR_PLAYER ; $4658
	script_move_target ACTOR_PLAYER, 53.0, 53.0 ; $465d
	script_wait_move ACTOR_PLAYER ; $4668
	ld c, $08 ; $466d
	call BeginFadeOut ; $466f
	call WaitFadeEnd ; $4672
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $4675
	ld [wStoryModeCurrentLocation], a ; $4677
	ld a, $07 ; $467a
	ld [wStoryModeEntryPoint], a ; $467c
	ld a, $ff ; $467f
	ld [wUnusedExitTriggerIdMirror], a ; $4681
	ld [wStoryModeExitTriggerRequest], a ; $4684
	ld a, [wMapScratch + 6] ; $4687
	add MINIGAME_TENNIS_MACHINE_1 ; $468a
	farcall RunTrainingDrillByID ; $468c
	farcall EndCutsceneScriptMode ; $468f
.done:
	ret ; $4692
MachineLevelNotClearedMessage:
	script_set_text Text_6e_225 ; $4693
	script_speak ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $4699
	ret ; $469e
TestMachineLevelClearedFlag:
	add a ; $469f
	ld_hl_indexed TestMachineLevelClearedFlagTable ; $46a0
	ld a, [hl+] ; $46a7
	ld d, [hl] ; $46a8
	ld e, a ; $46a9
	call TestGameFlagByNumber ; $46aa
	ret ; $46ad
; TestMachineLevelClearedFlag with SetGameFlagByNumber in place of TestGameFlagByNumber over the same TestMachineLevelClearedFlagTable: the Set member of the pair. Nothing calls it; the level-cleared flags are set by the machine-room scene scripts directly.
Unused_14_SetMachineLevelClearedFlag:
	add a ; $46ae
	ld_hl_indexed TestMachineLevelClearedFlagTable ; $46af
	ld a, [hl+] ; $46b6
	ld d, [hl] ; $46b7
	ld e, a ; $46b8
	call SetGameFlagByNumber ; $46b9
	ret ; $46bc
TestMachineLevelClearedFlagTable:
	; $46bd, 8 bytes (records:2)
	dw $00d2 ; record 0
	dw $00d3 ; record 1
	dw $00d4 ; record 2
	dw $00d5 ; record 3
MachinePracticeResultScene:
	xor a ; $46c5
	ld [wStoryModeShowLocationName], a ; $46c6
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $46c9
	test_flag FLAG_DOUBLES ; $46cc
	jr z, .placeActors ; $46cf
	script_null_script ACTOR_PARTNER ; $46d1
	script_set_position ACTOR_PARTNER, 41.0, 43.0 ; $46d6
	script_face ACTOR_PARTNER, FACE_RIGHT ; $46e1
	script_wait_frames 10 ; $46e8
.placeActors:
	script_set_position ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, 45.0, 41.0 ; $46ef
	script_face ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, FACE_DOWN ; $46fa
	script_fade_in $06 ; $4701
	call WaitFadeEnd ; $4706
	script_wait_frames 40 ; $4709
	ld a, [wMatchExitRequest] ; $4710
	and a ; $4713
	jp nz, .done ; $4714
	script_set_text Text_6e_219 ; $4717
	ld hl, wMinigamesTargetScore ; $471d
	ld a, [hl+] ; $4720
	ld h, [hl] ; $4721
	ld l, a ; $4722
	farcall PushTextArgNumber ; $4723
	ld hl, wMinigamesCurrentScore ; $4726
	ld a, [hl+] ; $4729
	ld h, [hl] ; $472a
	ld l, a ; $472b
	farcall PushTextArgNumber ; $472c
	script_set_speed ACTOR_PLAYER, $0020 ; $472f
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $4737
	farcall RunDialogueYesNoPrompt ; $473c
	farcall ScriptCloseDialogueWindow ; $473f
	script_wait_frames 5 ; $4742
	and a ; $4749
	jp z, MachineCourtRestartLevel ; $474a
.done:
	ret ; $474d
MachineCourtHandleRetryChoice:
	script_speak_restore ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $474e
	farcall RunDialogueYesNoPrompt ; $4753
	farcall ScriptCloseDialogueWindow ; $4756
	script_wait_frames 5 ; $4759
	and a ; $4760
	jr z, MachineCourtRestartLevel ; $4761
	script_set_text Text_6e_220 ; $4763
	script_speak ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $4769
	script_move_target ACTOR_PLAYER, 51.0, 54.0 ; $476e
	script_wait_move ACTOR_PLAYER ; $4779
	script_move_player 47.0, 45.0 ; $477e
	script_move_target ACTOR_PLAYER, 51.0, 43.0 ; $4788
	script_wait_move ACTOR_PLAYER ; $4793
	script_move_target ACTOR_PLAYER, 43.0, 43.0 ; $4798
	script_wait_move ACTOR_PLAYER ; $47a3
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, 45.0, 43.0 ; $47a8
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $47b3
	script_face ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, FACE_LEFT ; $47b8
	script_get_actor_state ACTOR_PARTNER ; $47bf
	ld c, l ; $47c4
	ld b, h ; $47c5
	ld de, wActors ; $47c6
	farcall AttachActorStepMover ; $47c9
	ret ; $47cc
MachineCourtRestartLevel:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $47cd
	cp MINIGAME_TENNIS_MACHINE_HIGH_SCORE ; $47d0
	jr z, .storeStoryModeCurrentLocation ; $47d2
	sub MINIGAME_TENNIS_MACHINE_1 ; $47d4
	call TestMachineLevelClearedFlag ; $47d6
	jr z, .storeStoryModeCurrentLocation ; $47d9
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $47db
	ld [wStoryModeCurrentLocation], a ; $47dd
	ld a, $07 ; $47e0
	ld [wStoryModeEntryPoint], a ; $47e2
	ld a, $ff ; $47e5
	ld [wUnusedExitTriggerIdMirror], a ; $47e7
	ld [wStoryModeExitTriggerRequest], a ; $47ea
	jr .runTrainingDrillByID ; $47ed
.storeStoryModeCurrentLocation:
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $47ef
	ld [wStoryModeCurrentLocation], a ; $47f1
	ld a, $05 ; $47f4
	ld [wStoryModeEntryPoint], a ; $47f6
	ld a, $ff ; $47f9
	ld [wUnusedExitTriggerIdMirror], a ; $47fb
	ld [wStoryModeExitTriggerRequest], a ; $47fe
.runTrainingDrillByID:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4801
	farcall RunTrainingDrillByID ; $4804
	ret ; $4807
ActorScript_14_0:
	; $4808, 11 bytes (actor_script)
	as_set_target 41.0, 43.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
; Reads tennis-machine record $01 and then throws the result away, storing the constant $0050 into wMinigameRecordValue instead, before sending the player back to the machine room at entry point $01. Nothing calls it (no textual or ROM-wide pointer reference), and it never calls UpdateMinigameRecord, so even if it ran the 80 would not persist -- it reads as an abandoned debug helper. The name states what the body does, not what it was for
UnusedMachineRecordOverrideAndReturn_14:
	push_wram_bank WRAM_SOUND ; $4813
	ld a, $01 ; $481c
	farcall ReadMinigameRecord ; $481e
	ld de, $0050 ; $4821
	ld hl, wMinigameRecordValue ; $4824
	ld a, e ; $4827
	ld [hl+], a ; $4828
	ld [hl], d ; $4829
	pop_wram_bank ; $482a
	ld a, STORYLOC_TENNIS_MACHINE_ROOM ; $482f
	ld [wStoryModeCurrentLocation], a ; $4831
	ld a, $01 ; $4834
	ld [wStoryModeEntryPoint], a ; $4836
	ld a, $ff ; $4839
	ld [wUnusedExitTriggerIdMirror], a ; $483b
	ld [wStoryModeExitTriggerRequest], a ; $483e
	ret ; $4841
MachineExpertResultScene:
	test_flag FLAG_CLEARED_MACHINE_EXPERT ; $4842
	jr z, .notClearedMachineExpert ; $4845
	ld a, [wPointWinLoseFlag] ; $4847
	cp WINLOSE_WIN ; $484a
	jp z, MachineExpertCounterMaxScene ; $484c
.notClearedMachineExpert:
	ld bc, $0001 ; $484f
	push_wram_bank WRAM_SOUND ; $4852
	ld hl, wMinigamesCurrentScore ; $485b
	ld a, [hl+] ; $485e
	ld d, [hl] ; $485f
	ld e, a ; $4860
	pop_wram_bank ; $4861
	ld l, c ; $4866
	ld h, b ; $4867
	ld a, l ; $4868
	sub e ; $4869
	ld l, a ; $486a
	ld a, h ; $486b
	sbc d ; $486c
	ld h, a ; $486d
	jp nc, MachineExpertRetryPrompt ; $486e
	ld bc, $270f ; $4871
	push_wram_bank WRAM_SOUND ; $4874
	ld a, $01 ; $487d
	farcall ReadMinigameRecord ; $487f
	ld hl, wMinigameRecordValue ; $4882
	ld a, [hl+] ; $4885
	ld d, [hl] ; $4886
	ld e, a ; $4887
	pop_wram_bank ; $4888
	ld l, c ; $488d
	ld h, b ; $488e
	ld a, l ; $488f
	sub e ; $4890
	ld l, a ; $4891
	ld a, h ; $4892
	sbc d ; $4893
	ld h, a ; $4894
	jp z, MachineExpertRetryPrompt ; $4895
	ld hl, wMinigamesCurrentScore ; $4898
	ld a, [hl+] ; $489b
	ld b, [hl] ; $489c
	ld c, a ; $489d
	push_wram_bank WRAM_SOUND ; $489e
	ld hl, wMinigameRecordValue ; $48a7
	ld a, [hl+] ; $48aa
	ld d, [hl] ; $48ab
	ld e, a ; $48ac
	pop_wram_bank ; $48ad
	ld l, c ; $48b2
	ld h, b ; $48b3
	inc de ; $48b4
	ld a, l ; $48b5
	sub e ; $48b6
	ld l, a ; $48b7
	ld a, h ; $48b8
	sbc d ; $48b9
	ld h, a ; $48ba
	jp nc, MachineExpertNewRecordScene ; $48bb
MachineExpertRetryPrompt:
	script_set_text Text_6e_221 ; $48be
	ld hl, wMinigamesCurrentScore ; $48c4
	ld a, [hl+] ; $48c7
	ld h, [hl] ; $48c8
	ld l, a ; $48c9
	farcall PushTextArgNumber ; $48ca
	jp MachineCourtHandleRetryChoice ; $48cd
	ret ; $48d0
MachineExpertNewRecordScene:
	call SaveMachineExpertRecord ; $48d1
	script_set_text Text_6e_206 ; $48d4
	ld hl, wMinigamesCurrentScore ; $48da
	ld a, [hl+] ; $48dd
	ld h, [hl] ; $48de
	ld l, a ; $48df
	farcall PushTextArgNumber ; $48e0
	call MachineCourtWalkToAttendantCutscene ; $48e3
	script_speak ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $48e6
	script_get_actor_state ACTOR_PARTNER ; $48eb
	ld c, l ; $48f0
	ld b, h ; $48f1
	ld de, wActors ; $48f2
	farcall AttachActorStepMover ; $48f5
	ret ; $48f8
MachineExpertCounterMaxScene:
	push_wram_bank WRAM_SOUND ; $48f9
	ld a, $01 ; $4902
	farcall ReadMinigameRecord ; $4904
	ld hl, wMinigameRecordValue ; $4907
	ld a, [hl+] ; $490a
	ld h, [hl] ; $490b
	ld l, a ; $490c
	pop_wram_bank ; $490d
	ld de, 9999 ; $4912
	ld a, l ; $4915
	sub e ; $4916
	ld l, a ; $4917
	ld a, h ; $4918
	sbc d ; $4919
	ld h, a ; $491a
	jp z, MachineExpertRetryPrompt ; $491b
	call SaveMachineExpertRecord ; $491e
	script_set_text Text_6e_212 ; $4921
	ld hl, wMinigamesCurrentScore ; $4927
	ld a, [hl+] ; $492a
	ld h, [hl] ; $492b
	ld l, a ; $492c
	farcall PushTextArgNumber ; $492d
	script_set_text Text_6e_212 ; $4930
	call MachineCourtWalkToAttendantCutscene ; $4936
	script_speak ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $4939
	script_speak ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $493e
	script_get_actor_state ACTOR_PARTNER ; $4943
	ld c, l ; $4948
	ld b, h ; $4949
	ld de, wActors ; $494a
	farcall AttachActorStepMover ; $494d
	ret ; $4950
Unused_14_CompareMinigameScoreToRecord:
	ld hl, wMinigamesCurrentScore ; $4951
	ld a, [hl+] ; $4954
	ld b, [hl] ; $4955
	ld c, a ; $4956
	push_wram_bank WRAM_SOUND ; $4957
	ld hl, wMinigameRecordValue ; $4960
	ld a, [hl+] ; $4963
	ld d, [hl] ; $4964
	ld e, a ; $4965
	pop_wram_bank ; $4966
	ld l, c ; $496b
	ld h, b ; $496c
	ld a, l ; $496d
	sub e ; $496e
	ld l, a ; $496f
	ld a, h ; $4970
	sbc d ; $4971
	ld h, a ; $4972
	ret ; $4973
SaveMachineExpertRecord:
	push_wram_bank WRAM_SOUND ; $4974
	ld hl, wMinigamesCurrentScore ; $497d
	ld a, [hl+] ; $4980
	ld d, [hl] ; $4981
	ld e, a ; $4982
	ld hl, wMinigameRecordValue ; $4983
	ld a, e ; $4986
	ld [hl+], a ; $4987
	ld [hl], d ; $4988
	ld a, $01 ; $4989
	farcall UpdateMinigameRecord ; $498b
	pop_wram_bank ; $498e
	call ComputeMachineCourtProgress ; $4993
	ret ; $4996
MachineCourtWalkToAttendantCutscene:
	script_move_target ACTOR_PLAYER, 51.0, 54.0 ; $4997
	script_wait_move ACTOR_PLAYER ; $49a2
	script_move_player 47.0, 45.0 ; $49a7
	script_move_target ACTOR_PLAYER, 51.0, 43.0 ; $49b1
	script_wait_move ACTOR_PLAYER ; $49bc
	script_move_target ACTOR_PLAYER, 42.5, 43.0 ; $49c1
	script_wait_move ACTOR_PLAYER ; $49cc
	script_move_target ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, 45.0, 43.0 ; $49d1
	script_wait_move ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07 ; $49dc
	script_face ACTOR_PLAYER, FACE_RIGHT ; $49e1
	script_move_target ACTOR_PLAYER, 43.0, 43.0 ; $49e8
	script_wait_move ACTOR_PLAYER ; $49f3
	script_face ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, FACE_LEFT ; $49f8
	ret ; $49ff
.practiceRoom:
	test_flag FLAG_PRACTICE_ROOM_SESSION_ACTIVE ; $4a00
	jr z, .done ; $4a03
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $4a05
	script_set_position ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, 45.0, 41.0 ; $4a08
	script_face ACTOR_TENNIS_MACHINE_ROOM_WALK_72_07, FACE_DOWN ; $4a13
	script_null_script ACTOR_PARTNER ; $4a1a
	script_wait_frames 1 ; $4a1f
	script_set_position ACTOR_PARTNER, 41.0, 43.0 ; $4a26
	script_face ACTOR_PARTNER, FACE_RIGHT ; $4a31
.done:
	ret ; $4a38
Court2MapScripts_14:
	; $4a39, 14 bytes (map_tree)
	dw Court2EntryPoints_14 ; slot 0 EntryPoints
	dw Court2ExitTriggers_14 ; slot 1 ExitTriggers
	dw Court2Actors_14 ; slot 2 Actors
	dw Court2NpcScripts_14 ; slot 3 NpcScripts
	dw Court2FacingScripts_14 ; slot 4 FacingScripts
	dw Court2TileTriggers_14 ; slot 5 TileTriggers
	dw Court2InitScript_14 ; slot 6 InitScript
Court2Actors_14:
	; $4a47, 248 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 29.0, 21.0, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT2_WALK_6F_07_1
	map_actor $0000, ActorScript_14_2, 25.0, 24.0, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT2_WALK_6F_07_2
	map_actor $0000, ActorScript_14_2, 27.0, 28.0, FACE_LEFT, OBJ_WALK_71_03, ANIM_WALK, $05, COURT2_WALK_71_03
	map_actor $0000, ActorScript_14_2, 27.0, 26.0, FACE_LEFT, OBJ_WALK_72_02, ANIM_WALK, $05, COURT2_WALK_72_02_1
	map_actor $0000, ActorScript_14_3, 7.0, 49.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $04, COURT2_WALK_72_02_2
	map_actor $0000, ActorScript_14_2, 9.0, 35.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $04, COURT2_WALK_72_02_3
	map_actor $0000, ActorScript_14_2, 11.0, 35.0, FACE_LEFT, OBJ_WALK_72_03, ANIM_WALK, $00, COURT2_WALK_72_03_1
	map_actor $0000, ActorScript_14_2, 11.0, 43.0, FACE_RIGHT, OBJ_WALK_6F_05, ANIM_WALK, $00, COURT2_WALK_6F_05
	map_actor $0000, ActorScript_14_2, 15.0, 43.0, FACE_LEFT, OBJ_WALK_6F_06, ANIM_WALK, $00, COURT2_WALK_6F_06
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, COURT2_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, COURT2_BALLOON_SWEAT
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, COURT2_BALLOON_QUESTION
	map_actor $0000, ActorScript_14_2, 27.0, 12.0, FACE_LEFT, OBJ_WALK_72_02, ANIM_WALK, $00, COURT2_WALK_72_02_4
	map_actor $0000, ActorScript_14_2, 25.0, 14.0, FACE_LEFT, OBJ_WALK_72_02, ANIM_WALK, $06, COURT2_WALK_72_02_5
	map_actor $0000, ActorScript_14_2, 27.0, 16.0, FACE_LEFT, OBJ_WALK_72_03, ANIM_WALK, $03, COURT2_WALK_72_03_2
	map_actor $0000, ActorScript_14_2, 5.0, 27.0, FACE_RIGHT, OBJ_WALK_71_06, ANIM_WALK, $00, COURT2_WALK_71_06
	map_actor $0000, ActorScript_14_2, 5.0, 29.0, FACE_RIGHT, OBJ_WALK_72_03, ANIM_WALK, $04, COURT2_WALK_72_03_3
	map_actor_end
Court2EntryPoints_14:
	; $4b3f, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, 37.0, 21.0, $0000
	map_entry $02, FACE_LEFT, 37.0, 37.0, $0000
	db $ff
Court2ExitTriggers_14:
	; $4b50, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT, $03
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT_COURTYARD, $02
	db $ff
Court2Npc03_14:
	script_set_text Text_1f_145 ; $4b61
	script_speak ACTOR_COURT2_WALK_6F_07_1 ; $4b67
	ret ; $4b6c
Court2Npc04_14:
	ld a, [wMapSceneStage] ; $4b6d
	add a ; $4b70
	ld_hl_indexed Court2Npc04TextIds ; $4b71
	ld a, [hl+] ; $4b78
	ld h, [hl] ; $4b79
	ld l, a ; $4b7a
	farcall InitDialogueTextCursor ; $4b7b
	script_speak ACTOR_COURT2_WALK_6F_07_2 ; $4b7e
	ret ; $4b83
Court2Npc04TextIds:
	; $4b84, 14 bytes (text_ids)
	dw Text_1f_146 ; record 0
	dw Text_1f_146 ; record 1
	dw Text_1f_146 ; record 2
	dw Text_1f_151 ; record 3
	dw Text_1f_146 ; record 4
	dw Text_1f_146 ; record 5
	dw Text_1f_151 ; record 6
Court2Npc05_14:
	ld a, [wMapSceneStage] ; $4b92
	add a ; $4b95
	ld_hl_indexed Court2Npc05TextIds ; $4b96
	ld a, [hl+] ; $4b9d
	ld h, [hl] ; $4b9e
	ld l, a ; $4b9f
	farcall InitDialogueTextCursor ; $4ba0
	script_speak ACTOR_COURT2_WALK_71_03 ; $4ba3
	ret ; $4ba8
Court2Npc05TextIds:
	; $4ba9, 14 bytes (text_ids)
	dw Text_1f_147 ; record 0
	dw Text_1f_147 ; record 1
	dw Text_1f_149 ; record 2
	dw Text_1f_152 ; record 3
	dw Text_1f_153 ; record 4
	dw Text_1f_155 ; record 5
	dw Text_1f_157 ; record 6
Court2Npc06_14:
	ld a, [wMapSceneStage] ; $4bb7
	add a ; $4bba
	ld_hl_indexed Court2Npc06TextIds ; $4bbb
	ld a, [hl+] ; $4bc2
	ld h, [hl] ; $4bc3
	ld l, a ; $4bc4
	farcall InitDialogueTextCursor ; $4bc5
	script_speak ACTOR_ROLE_COURT2_SPECTATOR ; $4bc8
	ret ; $4bcd
Court2Npc06TextIds:
	; $4bce, 14 bytes (text_ids)
	dw Text_1f_148 ; record 0
	dw Text_1f_148 ; record 1
	dw Text_1f_150 ; record 2
	dw Text_1f_150 ; record 3
	dw Text_1f_154 ; record 4
	dw Text_1f_156 ; record 5
	dw Text_1f_158 ; record 6
Court2SpectatorChat_14:
	test_flag FLAG_DOUBLES ; $4bdc
	jr z, .checkFlag ; $4bdf
	test_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be1
	jp nz, Court2SpectatorsRepeatChat ; $4be4
	set_flag FLAG_COURT2_SPECTATORS_TALKED_DOUBLES ; $4be7
	jr .step ; $4bea
.checkFlag:
	test_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bec
	jp nz, Court2SpectatorsRepeatChat ; $4bef
	set_flag FLAG_COURT2_SPECTATORS_TALKED_SINGLES ; $4bf2
.step:
	ld a, [wMapSceneStage] ; $4bf5
	add a ; $4bf8
	ld_hl_indexed Court2SpectatorChatTextIds ; $4bf9
	ld a, [hl+] ; $4c00
	ld h, [hl] ; $4c01
	ld l, a ; $4c02
	farcall InitDialogueTextCursor ; $4c03
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_SHAKE ; $4c06
	script_wait_idle ACTOR_COURT2_WALK_72_02_3 ; $4c0d
	script_speak ACTOR_COURT2_WALK_72_02_3 ; $4c12
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 12.5, 33.5 ; $4c17
	sound SFX_CHIME ; $4c22
	script_wait_frames 20 ; $4c24
	script_speak ACTOR_COURT2_WALK_72_03_1 ; $4c2b
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 63.0, 63.0 ; $4c30
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_NOD ; $4c3b
	script_wait_idle ACTOR_COURT2_WALK_72_02_3 ; $4c42
	script_speak ACTOR_COURT2_WALK_72_02_3 ; $4c47
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_BOUNCE ; $4c4c
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4c53
	script_speak ACTOR_COURT2_WALK_72_03_1 ; $4c58
	script_face_toward ACTOR_PLAYER, ACTOR_COURT2_WALK_72_02_3 ; $4c5d
	script_wait_frames 20 ; $4c65
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 10.5, 33.5 ; $4c6c
	sound SFX_CHIME ; $4c77
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_BOUNCE ; $4c79
	script_wait_idle ACTOR_COURT2_WALK_72_02_3 ; $4c80
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 63.0, 63.0 ; $4c85
	script_wait_frames 10 ; $4c90
	script_set_position ACTOR_COURT2_BALLOON_SWEAT, 10.5, 33.5 ; $4c97
	sound SFX_APPEAR2 ; $4ca2
	script_wait_frames 20 ; $4ca4
	script_speak ACTOR_COURT2_WALK_72_02_3 ; $4cab
	script_set_position ACTOR_COURT2_BALLOON_SWEAT, 63.0, 63.0 ; $4cb0
	script_set_position ACTOR_COURT2_BALLOON_QUESTION, 12.5, 33.5 ; $4cbb
	sound SFX_EMOTE ; $4cc6
	script_wait_frames 60 ; $4cc8
	script_set_position ACTOR_COURT2_BALLOON_QUESTION, 63.0, 63.0 ; $4ccf
	script_face_toward ACTOR_PLAYER, ACTOR_COURT2_WALK_72_03_1 ; $4cda
	script_wait_frames 20 ; $4ce2
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 12.5, 33.5 ; $4ce9
	sound SFX_CHIME ; $4cf4
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_BOUNCE ; $4cf6
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4cfd
	script_set_position ACTOR_COURT2_BALLOON_EXCLAIM, 63.0, 63.0 ; $4d02
	script_wait_frames 10 ; $4d0d
	script_set_position ACTOR_COURT2_BALLOON_SWEAT, 12.5, 33.5 ; $4d14
	sound SFX_APPEAR2 ; $4d1f
	script_wait_frames 20 ; $4d21
	script_speak ACTOR_COURT2_WALK_72_03_1 ; $4d28
	script_set_position ACTOR_COURT2_BALLOON_SWEAT, 63.0, 63.0 ; $4d2d
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_NOD ; $4d38
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_NOD ; $4d3f
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4d46
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_NOD ; $4d4b
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_NOD ; $4d52
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4d59
	ret ; $4d5e
Court2SpectatorChatTextIds:
	; $4d5f, 14 bytes (text_ids)
	dw Text_1f_107 ; record 0
	dw Text_1f_107 ; record 1
	dw Text_1f_107 ; record 2
	dw Text_1f_114 ; record 3
	dw Text_1f_120 ; record 4
	dw Text_1f_120 ; record 5
	dw Text_1f_126 ; record 6
Court2SpectatorsRepeatChat:
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_BOUNCE ; $4d6d
	script_wait_idle ACTOR_COURT2_WALK_72_02_3 ; $4d74
	script_face_toward ACTOR_PLAYER, ACTOR_COURT2_WALK_72_02_3 ; $4d79
	script_set_text Text_1f_111 ; $4d81
	script_speak ACTOR_COURT2_WALK_72_02_3 ; $4d87
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_BOUNCE ; $4d8c
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4d93
	script_face_toward ACTOR_PLAYER, ACTOR_COURT2_WALK_72_03_1 ; $4d98
	script_speak ACTOR_COURT2_WALK_72_03_1 ; $4da0
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_NOD ; $4da5
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_NOD ; $4dac
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4db3
	script_set_anim ACTOR_COURT2_WALK_72_02_3, ANIM_NOD ; $4db8
	script_set_anim ACTOR_COURT2_WALK_72_03_1, ANIM_NOD ; $4dbf
	script_wait_idle ACTOR_COURT2_WALK_72_03_1 ; $4dc6
	ret ; $4dcb
Court2Npc0A_14:
	script_set_text Text_1f_106 ; $4dcc
	test_flag FLAG_DOUBLES ; $4dd2
	jr nz, .isDoubles ; $4dd5
	ld a, [wMapSceneStage] ; $4dd7
	cp ISLANDOPENSTAGE_SINGLES_FINAL ; $4dda
	jr nz, .speak ; $4ddc
	script_set_text Text_1f_113 ; $4dde
	jr .speak ; $4de4
.isDoubles:
	ld a, [wMapSceneStage] ; $4de6
	cp ISLANDOPENSTAGE_DOUBLES_FINAL ; $4de9
	jr nz, .speak ; $4deb
	script_set_text Text_1f_113 ; $4ded
.speak:
	script_speak ACTOR_COURT2_WALK_6F_05 ; $4df3
	ret ; $4df8
Court2NpcScripts_14:
	; $4df9, 73 bytes (map_scripts)
	map_script ACTOR_COURT2_WALK_6F_07_1, FACEMASK_ANY, $0000, Court2Npc03_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT2_WALK_6F_07_2, FACEMASK_ANY, $0000, Court2Npc04_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT2_WALK_71_03, FACEMASK_ANY, $0000, Court2Npc05_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ROLE_COURT2_SPECTATOR, FACEMASK_ANY, $0000, Court2Npc06_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_COURT2_WALK_72_02_2, FACEMASK_ANY, $0000, Text_1f_104, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_COURT2_WALK_72_02_3, FACEMASK_ANY, $0000, Court2SpectatorChat_14, $00, $00
	map_script ACTOR_COURT2_WALK_72_03_1, FACEMASK_ANY, $0000, Court2SpectatorChat_14, $00, $00
	map_script ACTOR_COURT2_WALK_6F_05, FACEMASK_ANY, $0000, Court2Npc0A_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT2_WALK_6F_06, FACEMASK_ANY, $0000, Text_1f_105, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
Court2FacingScripts_14:
	; $4e42, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court2Facing01_14, $00, $00
	db $ff
Court2Facing01_14:
	ret ; $4e4b
Court2TileTriggers_14:
	; $4e4c, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court2Tile01_14, $00, $00
	db $ff
Court2Tile01_14:
	ret ; $4e55
Court2InitScript_14:
	call InitCourt2SceneVariant ; $4e56
	call LoadCourtPlayerPartnerObjDefs_14 ; $4e59
	call Court2EntryWalkIn ; $4e5c
	ret ; $4e5f
InitCourt2SceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $4e60
	ld [wMapSceneStage], a ; $4e62
	test_flag FLAG_DOUBLES ; $4e65
	jr nz, .doubles ; $4e68
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $4e6a
	jr z, .stage1 ; $4e6d
	ldh a, [hRomBank] ; $4e6f
	ld hl, Court2ActorsAlt_14 ; $4e71
	farcall ScriptRespawnLocationActors ; $4e74
	farcall BeginCutsceneScriptMode ; $4e77
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $4e7a
	jr .stage3 ; $4e7c
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $4e7e
	jr z, .stage2 ; $4e81
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $4e83
	jr .stage3 ; $4e85
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $4e87
	jr z, .stage4 ; $4e8a
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $4e8c
.stage3:
	ld [wMapSceneStage], a ; $4e8e
.stage4:
	ret ; $4e91
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $4e92
	jr z, .doublesStage2 ; $4e95
	ldh a, [hRomBank] ; $4e97
	ld hl, Court2ActorsAlt_14 ; $4e99
	farcall ScriptRespawnLocationActors ; $4e9c
	farcall BeginCutsceneScriptMode ; $4e9f
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $4ea2
	jr .stage3 ; $4ea4
.doublesStage2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4ea6
	jr z, .done ; $4ea9
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $4eab
	jr .stage3 ; $4ead
.done:
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $4eaf
	jr .stage3 ; $4eb1
	ret ; $4eb3
Court2ActorsAlt_14:
	; $4eb4, 178 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 29.0, 21.0, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT2_ALT_WALK_6F_07_1
	map_actor $0000, ActorScript_14_2, 27.0, 35.0, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT2_ALT_WALK_6F_07_2
	map_actor $0000, ActorScript_14_2, 31.0, 45.0, FACE_LEFT, OBJ_WALK_71_03, ANIM_WALK, $05, COURT2_ALT_WALK_71_03
	map_actor $0000, ActorScript_14_3, 29.0, 48.0, FACE_UP, OBJ_WALK_72_02, ANIM_WALK, $05, COURT2_ALT_WALK_72_02_1
	map_actor $0000, ActorScript_14_3, 7.0, 49.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $04, COURT2_ALT_WALK_72_02_2
	map_actor $0000, ActorScript_14_2, 9.0, 35.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $04, COURT2_ALT_WALK_72_02_3
	map_actor $0000, ActorScript_14_2, 11.0, 35.0, FACE_LEFT, OBJ_WALK_72_03, ANIM_WALK, $00, COURT2_ALT_WALK_72_03
	map_actor $0000, ActorScript_14_2, 11.0, 43.0, FACE_RIGHT, OBJ_WALK_6F_05, ANIM_WALK, $00, COURT2_ALT_WALK_6F_05
	map_actor $0000, ActorScript_14_2, 15.0, 43.0, FACE_LEFT, OBJ_WALK_6F_06, ANIM_WALK, $00, COURT2_ALT_WALK_6F_06
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, COURT2_ALT_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, COURT2_ALT_BALLOON_SWEAT
	map_actor $0000, ActorScript_14_2, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, COURT2_ALT_BALLOON_QUESTION
	map_actor_end
; Instruction-identical to RestaurantPlazaArrival06_13 (one copy per bank); a change here belongs in every copy.
	twin_named restaurant_plaza_arrival06, Court2EntryWalkIn ; $4f66
