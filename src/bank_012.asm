SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

DataPtr_DormEntranceMapScripts_12:
	dw DormEntranceMapScripts_12 ; $4000
DataPtr_WallPracticeRoomStoryCmds_12:
	dw WallPracticeRoomStoryCmds_12 ; $4002
DataPtr_SeniorCourtStoryCmds_12:
	dw SeniorCourtStoryCmds_12 ; $4004
DormEntranceMapScripts_12:
	; $4006, 14 bytes (map_tree)
	dw DormEntranceEntryPoints_12 ; slot 0 EntryPoints
	dw DormEntranceExitTriggers_12 ; slot 1 ExitTriggers
	dw DormEntranceActors_12 ; slot 2 Actors
	dw DormEntranceNpcScripts_12 ; slot 3 NpcScripts
	dw DormEntranceFacingScripts_12 ; slot 4 FacingScripts
	dw DormEntranceTileTriggers_12 ; slot 5 TileTriggers
	dw DormEntranceInitScript_12 ; slot 6 InitScript
DormEntranceActors_12:
	; $4014, 66 bytes (map_actors)
	map_actor $0000, ActorObjDef_12_7a89, $0100, $0100, $40, $49, $01, $00
	map_actor $0000, ActorObjDef_12_7a89, $0100, $0100, $40, $29, $01, $00
	map_actor $0000, ActorObjDef_12_7a89, $0100, $0100, $40, $4c, $01, $00
	map_actor $0000, ActorObjDef_12_7a89, $0100, $0100, $40, $4d, $01, $00
	map_actor_end
DormEntranceEntryPoints_12:
	; $4056, 25 bytes (map_entries)
	map_entry $01, $c0, $1600, $1b00, Func_12_40b5
	map_entry $02, $40, $1600, $0d00, Func_12_406f
	map_entry $0f, $c0, $1600, $1b00, $0000
	db $ff
Func_12_406f:
	ld a, [wStoryModeEntryPoint] ; $406f
	cp a, $ff ; $4072
	jp z, Label_12_40b4 ; $4074
	test_flag $05, 7 ; $4077
	jr z, Label_12_40a2 ; $407a
	script_set_speed $02, $00ff ; $407c
	script_move_angle $02, $c0, $0200 ; $4084
	script_wait_move $02 ; $408e
	script_face $02, $40 ; $4093
	script_set_speed $02, $0010 ; $409a
Label_12_40a2:
	script_set_speed $00, $0010 ; $40a2
	script_move_angle $00, $40, $0200 ; $40aa
Label_12_40b4:
	ret ; $40b4
Func_12_40b5:
	ld a, [wStoryModeEntryPoint] ; $40b5
	cp a, $ff ; $40b8
	jp z, Label_12_40fa ; $40ba
	test_flag $05, 7 ; $40bd
	jr z, Label_12_40e8 ; $40c0
	script_set_speed $02, $00ff ; $40c2
	script_move_angle $02, $40, $0200 ; $40ca
	script_wait_move $02 ; $40d4
	script_face $02, $c0 ; $40d9
	script_set_speed $02, $0010 ; $40e0
Label_12_40e8:
	script_set_speed $00, $0010 ; $40e8
	script_move_angle $00, $c0, $0200 ; $40f0
Label_12_40fa:
	ret ; $40fa
DormEntranceExitTriggers_12:
	; $40fb, 25 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_12_7ab1, $0a, $02
	map_script $03, $ff, $0000, Func_12_7ab1, $08, $01
	map_script $0f, $ff, $0000, Func_12_7ab1, $0a, $0f
	db $ff
DormEntranceNpcScripts_12:
	ds 1, $ff ; $4114, fill
DormEntranceFacingScripts_12:
	ds 1, $ff ; $4115, fill
DormEntranceTileTriggers_12:
	; $4116, 9 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_12_411f, $00, $00
	db $ff
Func_12_411f:
	script_set_active $00, $00 ; $411f
	script_move_target $00, $1600, $0900 ; $4126
	script_wait_move $00 ; $4131
	script_player_speed $0010 ; $4136
	script_move_player $1600, $0800 ; $413c
	script_wait_frames $0f ; $4146
	ld c, $04 ; $414d
	call BeginFadeOut ; $414f
	farcall FarPtr_WaitPlayerMoveDone ; $4152
	call WaitFadeEnd ; $4155
	ld a, [$c90d] ; $4158
	or a, a ; $415b
	jr nz, Label_12_4167 ; $415c
	ld a, $01 ; $415e
	ld [$c294], a ; $4160
	ld [wStoryModeExitLocationRequest], a ; $4163
	ret ; $4166
Label_12_4167:
	ld a, $01 ; $4167
	ld [$c294], a ; $4169
	ld [wStoryModeExitLocationRequest], a ; $416c
	ret ; $416f
DormEntranceInitScript_12:
	ld a, [wStoryModeEntryPoint] ; $4170
	cp a, $0f ; $4173
	call z, Func_12_4179 ; $4175
	ret ; $4178
Func_12_4179:
	script_set_speed $03, $0010 ; $4179
	script_set_speed $04, $0010 ; $4181
	script_set_speed $00, $0010 ; $4189
	script_player_speed $0010 ; $4191
	script_set_position $00, $1600, $1f00 ; $4197
	script_set_position $03, $1600, $1d00 ; $41a2
	script_face $03, $c0 ; $41ad
	script_fade_in $20 ; $41b4
	script_wait_frames $14 ; $41b9
	script_move_target $03, $1600, $1100 ; $41c0
	script_move_player $1600, $0f00 ; $41cb
	script_move_target $00, $1600, $1400 ; $41d5
	script_wait_move $00 ; $41e0
	script_move_target $03, $1600, $1100 ; $41e5
	script_move_target $00, $1600, $1300 ; $41f0
	script_wait_move $00 ; $41fb
	script_wait_frames $14 ; $4200
	script_wait_move $03 ; $4207
	script_face_toward $00, $03 ; $420c
	script_set_text $044a ; $4214
	script_speak $03 ; $421a
	script_set_anim $03, $03 ; $421f
	script_wait_idle $03 ; $4226
	script_speak $03 ; $422b
	script_set_anim $00, $02 ; $4230
	script_player_speed $0018 ; $4237
	script_move_player $1600, $0b00 ; $423d
	farcall FarPtr_WaitPlayerMoveDone ; $4247
	script_wait_frames $14 ; $424a
	script_move_player $1100, $0b00 ; $4251
	farcall FarPtr_WaitPlayerMoveDone ; $425b
	script_wait_frames $0a ; $425e
	script_move_player $1a00, $0b00 ; $4265
	farcall FarPtr_WaitPlayerMoveDone ; $426f
	script_wait_frames $0a ; $4272
	script_move_player $1600, $0b00 ; $4279
	farcall FarPtr_WaitPlayerMoveDone ; $4283
	script_wait_frames $1e ; $4286
	script_move_player $1600, $1000 ; $428d
	script_set_anim $00, $02 ; $4297
	script_wait_idle $00 ; $429e
	script_wait_frames $14 ; $42a3
	script_player_speed $0010 ; $42aa
	script_set_position $05, $1780, $0f00 ; $42b0
	sound $97 ; $42bb
	script_set_anim $03, $02 ; $42bd
	script_wait_idle $03 ; $42c4
	script_set_position $05, $0100, $0100 ; $42c9
	script_speak $03 ; $42d4
	script_move_target $03, $1600, $0b00 ; $42d9
	script_wait_move $03 ; $42e4
	script_set_position $04, $1700, $0b00 ; $42e9
	script_wait_frames $a0 ; $42f4
	script_move_target $00, $1600, $1500 ; $42fb
	script_wait_move $00 ; $4306
	script_face $00, $40 ; $430b
	script_wait_frames $14 ; $4312
	script_set_anim $00, $04 ; $4319
	script_wait_idle $00 ; $4320
	script_face $00, $c0 ; $4325
	script_wait_frames $a0 ; $432c
	script_face $00, $40 ; $4333
	script_wait_frames $14 ; $433a
	script_set_anim $00, $04 ; $4341
	script_wait_idle $00 ; $4348
	script_wait_frames $14 ; $434d
	script_set_active $03, $00 ; $4354
	script_set_position $03, $1700, $1900 ; $435b
	script_speak $03 ; $4366
	script_move_target $00, $1680, $1200 ; $436b
	script_jump_velocity $00, $ff80 ; $4376
	ld a, $00 ; $437e
	farcall FarPtr_ScriptWaitActorJumpDone ; $4380
	script_face $00, $c0 ; $4383
	script_set_active $03, $02 ; $438a
	script_set_position $03, $1500, $0b00 ; $4391
	ld a, [$c94d] ; $439c
	or a, a ; $439f
	jr nz, Label_12_43bb ; $43a0
	script_set_text $045c ; $43a2
	script_set_objdef $28, $04 ; $43a8
	script_set_anim $04, $01 ; $43b4
Label_12_43bb:
	script_move_target $03, $1500, $0f00 ; $43bb
	script_wait_move $03 ; $43c6
	script_move_target $04, $1700, $0f00 ; $43cb
	script_wait_move $04 ; $43d6
	script_set_position $06, $1800, $1100 ; $43db
	sound $98 ; $43e6
	script_wait_frames $3c ; $43e8
	script_set_anim $03, $04 ; $43ef
	script_wait_idle $03 ; $43f6
	script_set_position $06, $0100, $0100 ; $43fb
	script_speak $03 ; $4406
	script_face_toward $04, $03 ; $440b
	script_wait_frames $3c ; $4413
	script_face_toward $00, $03 ; $441a
	script_speak $03 ; $4422
	script_set_anim $04, $03 ; $4427
	script_wait_idle $04 ; $442e
	script_speak $04 ; $4433
	script_set_anim $00, $03 ; $4438
	script_wait_idle $00 ; $443f
	script_wait_frames $14 ; $4444
	script_set_anim $03, $03 ; $444b
	script_wait_idle $03 ; $4452
	script_speak $03 ; $4457
	script_face_toward $03, $04 ; $445c
	script_set_anim $04, $04 ; $4464
	script_wait_idle $04 ; $446b
	script_speak $04 ; $4470
	script_face_toward $04, $03 ; $4475
	script_speak $03 ; $447d
	script_set_anim $04, $03 ; $4482
	script_wait_idle $04 ; $4489
	script_face_toward $00, $04 ; $448e
	ld a, $04 ; $4496
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4498
	script_face_toward $00, $03 ; $449b
	farcall FarPtr_RunDialogueYesNoPrompt ; $44a3
	farcall FarPtr_ScriptCloseDialogueWindow ; $44a6
	script_wait_frames $05 ; $44a9
	and a, a ; $44b0
	jr nz, Label_12_44bd ; $44b1
	script_speak $04 ; $44b3
	farcall FarPtr_AdvanceDialogueTextCursor ; $44b8
	jr Label_12_44c5 ; $44bb
Label_12_44bd:
	farcall FarPtr_AdvanceDialogueTextCursor ; $44bd
	script_speak $04 ; $44c0
Label_12_44c5:
	script_set_anim $03, $03 ; $44c5
	script_wait_idle $03 ; $44cc
	script_speak $03 ; $44d1
	script_set_anim $04, $03 ; $44d6
	script_wait_idle $04 ; $44dd
	script_set_anim $03, $02 ; $44e2
	script_wait_idle $03 ; $44e9
	script_speak $03 ; $44ee
	script_set_position $06, $1800, $1100 ; $44f3
	sound $98 ; $44fe
	script_wait_frames $3c ; $4500
	script_set_position $06, $0100, $0100 ; $4507
	script_set_anim $04, $03 ; $4512
	script_wait_idle $04 ; $4519
	script_speak $04 ; $451e
	script_face_toward $04, $03 ; $4523
	script_wait_frames $1e ; $452b
	script_face_toward $00, $03 ; $4532
	script_wait_frames $1e ; $453a
	script_set_anim $03, $03 ; $4541
	script_wait_idle $03 ; $4548
	script_set_text $045a ; $454d
	script_speak $04 ; $4553
	script_face_toward $03, $04 ; $4558
	script_set_anim $00, $03 ; $4560
	script_set_anim $04, $03 ; $4567
	script_wait_idle $04 ; $456e
	script_move_player $1600, $1300 ; $4573
	script_move_target $03, $1500, $1300 ; $457d
	script_wait_move $03 ; $4588
	script_face $04, $40 ; $458d
	script_face $00, $40 ; $4594
	script_move_target $03, $1500, $1500 ; $459b
	script_wait_move $03 ; $45a6
	script_face $03, $c0 ; $45ab
	script_face $00, $40 ; $45b2
	script_speak $04 ; $45b9
	script_set_anim $00, $03 ; $45be
	script_set_anim $04, $03 ; $45c5
	script_wait_idle $04 ; $45cc
	script_set_anim $03, $03 ; $45d1
	script_wait_idle $03 ; $45d8
	script_face $03, $40 ; $45dd
	script_wait_frames $1e ; $45e4
	script_move_target $03, $1500, $1f00 ; $45eb
	script_wait_frames $78 ; $45f6
	script_face_pair $00, $04 ; $45fd
	script_set_anim $00, $03 ; $4605
	script_set_anim $04, $03 ; $460c
	script_wait_idle $04 ; $4613
	script_move_player $1500, $0f00 ; $4618
	script_move_target $00, $1500, $0f00 ; $4622
	script_wait_move $00 ; $462d
	script_move_target $04, $1700, $0b00 ; $4632
	script_move_target $00, $1500, $0b00 ; $463d
	script_wait_move $00 ; $4648
	script_move_player $1600, $0b00 ; $464d
	ld b, $0a ; $4657
	ld c, $0f ; $4659
	farcall FarPtr_SaveStoryReturnPoint ; $465b
	farcall FarPtr_SaveStorySlotWithTimer ; $465e
	ld a, $01 ; $4661
	farcall FarPtr_EraseStorySlotSaveData ; $4663
	farcall FarPtr_SaveStorySlotWithTimer ; $4666
	sound $00 ; $4669
	ld c, $04 ; $466b
	call BeginFadeOut ; $466d
	call WaitFadeEnd ; $4670
	ld a, $0f ; $4673
	ld [$c294], a ; $4675
	ld [wStoryModeExitLocationRequest], a ; $4678
	ret ; $467b
WallPracticeRoomStoryCmds_12:
	; $467c, 14 bytes (records:2)
	dw $46da ; record 0
	dw $4716 ; record 1
	dw $468a ; record 2
	dw $4818 ; record 3
	dw $4ca0 ; record 4
	dw $4cc0 ; record 5
	dw $4f03 ; record 6
	; $468a, 80 bytes (bytes:14)
	db $00, $00, $89, $7a, $00, $03, $00, $39, $00, $00, $39, $01, $00, $00 ; 0x00
	db $00, $00, $89, $7a, $00, $08, $00, $37, $c0, $00, $32, $01, $00, $00 ; 0x0e
	db $00, $00, $89, $7a, $00, $0d, $00, $37, $c0, $00, $30, $01, $00, $00 ; 0x1c
	db $00, $00, $89, $7a, $00, $13, $00, $39, $00, $00, $3e, $01, $00, $00 ; 0x2a
	db $00, $00, $89, $7a, $00, $05, $00, $37, $40, $00, $3d, $01, $00, $00 ; 0x38
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x46
	; $46da, 25 bytes (bytes:16)
	db $01, $c0, $00, $0f, $00, $39, $f3, $46, $0a, $c0, $00, $0c, $00, $31, $00, $00 ; 0x00
	db $0b, $c0, $00, $0c, $00, $31, $00, $00, $ff ; 0x10
	ld a, [wStoryModeEntryPoint] ; $46f3
	cp a, $ff ; $46f6
	jp z, Label_12_4715 ; $46f8
	clear_flag $0f, 5 ; $46fb
	test_flag $05, 7 ; $46fe
	jr z, Label_12_4715 ; $4701
	script_set_position $02, $0f00, $3b00 ; $4703
	script_face $02, $c0 ; $470e
Label_12_4715:
	ret ; $4715
	; $4716, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff05, $0000, $7ab1, $0211 ; record 0
	db $ff
	ld a, [$c2b0] ; $471f
	add a, a ; $4722
	add a, $73 ; $4723
	ld l, a ; $4725
	adc a, $47 ; $4726
	sub a, l ; $4728
	ld h, a ; $4729
	ld a, [hl+] ; $472a
	ld h, [hl] ; $472b
	ld l, a ; $472c
	farcall FarPtr_InitDialogueTextCursor ; $472d
	ld a, [$c2b0] ; $4730
	ld a, a ; $4733
	rst Rst00 ; $4734
	dw Label_12_4743 ; $4735 jumptable
	dw Label_12_475b ; $4737 jumptable
	dw Label_12_4743 ; $4739 jumptable
	dw Label_12_4743 ; $473b jumptable
	dw Label_12_4761 ; $473d jumptable
	dw Label_12_4761 ; $473f jumptable
	dw Label_12_475b ; $4741 jumptable
Label_12_4743:
	ld a, $03 ; $4743
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4745
	farcall FarPtr_RunDialogueYesNoPrompt ; $4748
	farcall FarPtr_ScriptCloseDialogueWindow ; $474b
	script_wait_frames $05 ; $474e
	and a, a ; $4755
	jr z, Label_12_475b ; $4756
	farcall FarPtr_AdvanceDialogueTextCursor ; $4758
Label_12_475b:
	script_speak $03 ; $475b
	ret ; $4760
Label_12_4761:
	script_set_anim $03, $02 ; $4761
	script_wait_idle $03 ; $4768
	script_speak $03 ; $476d
	ret ; $4772
	; $4773, 14 bytes (records:2)
	dw $14e7 ; record 0
	dw $1500 ; record 1
	dw $150a ; record 2
	dw $1808 ; record 3
	dw $1815 ; record 4
	dw $1815 ; record 5
	dw $182c ; record 6
	ld a, [$c2b0] ; $4781
	add a, a ; $4784
	add a, $98 ; $4785
	ld l, a ; $4787
	adc a, $47 ; $4788
	sub a, l ; $478a
	ld h, a ; $478b
	ld a, [hl+] ; $478c
	ld h, [hl] ; $478d
	ld l, a ; $478e
	farcall FarPtr_InitDialogueTextCursor ; $478f
	script_speak $04 ; $4792
	ret ; $4797
	; $4798, 14 bytes (records:2)
	dw $14ea ; record 0
	dw $1501 ; record 1
	dw $150d ; record 2
	dw $180b ; record 3
	dw $1816 ; record 4
	dw $1816 ; record 5
	dw $182d ; record 6
	ld a, [$c2b0] ; $47a6
	add a, a ; $47a9
	add a, $e5 ; $47aa
	ld l, a ; $47ac
	adc a, $47 ; $47ad
	sub a, l ; $47af
	ld h, a ; $47b0
	ld a, [hl+] ; $47b1
	ld h, [hl] ; $47b2
	ld l, a ; $47b3
	farcall FarPtr_InitDialogueTextCursor ; $47b4
	ld a, [$c2b0] ; $47b7
	cp a, $04 ; $47ba
	jr c, Label_12_47c4 ; $47bc
	script_speak $05 ; $47be
	ret ; $47c3
Label_12_47c4:
	script_face $05, $c0 ; $47c4
	script_speak $05 ; $47cb
	script_face_toward $00, $05 ; $47d0
	script_speak $05 ; $47d8
	script_face $05, $c0 ; $47dd
	ret ; $47e4
	; $47e5, 14 bytes (records:2)
	dw $14eb ; record 0
	dw $1502 ; record 1
	dw $150e ; record 2
	dw $180c ; record 3
	dw $1817 ; record 4
	dw $1817 ; record 5
	dw $182e ; record 6
	ld a, [$c2b0] ; $47f3
	add a, a ; $47f6
	add a, $0a ; $47f7
	ld l, a ; $47f9
	adc a, $48 ; $47fa
	sub a, l ; $47fc
	ld h, a ; $47fd
	ld a, [hl+] ; $47fe
	ld h, [hl] ; $47ff
	ld l, a ; $4800
	farcall FarPtr_InitDialogueTextCursor ; $4801
	script_speak $06 ; $4804
	ret ; $4809
	; $480a, 14 bytes (records:2)
	dw $14ed ; record 0
	dw $1504 ; record 1
	dw $1510 ; record 2
	dw $180e ; record 3
	dw $1818 ; record 4
	dw $1818 ; record 5
	dw $182f ; record 6
	; $4818, 41 bytes (records:8)
; 5 records x 8 bytes
	dw $ff03, $0000, $471f, $0001 ; record 0
	dw $ff04, $0000, $4781, $0001 ; record 1
	dw $ff05, $0000, $47a6, $0001 ; record 2
	dw $ff06, $0000, $47f3, $0003 ; record 3
	dw $ff07, $0000, $50cc, $0001 ; record 4
	db $ff
WallPracticeMasterResultScript:
	script_fade_in $06 ; $4841
	call WaitFadeEnd ; $4846
	xor a, a ; $4849
	ld [wStoryModeShowLocationName], a ; $484a
	test_flag $1b, 5 ; $484d
	jr z, WallPracticeScoreRetryPrompt ; $4850
	ld a, [wPointWinLoseFlag] ; $4852
	cp a, $01 ; $4855
	jr nz, WallPracticeScoreRetryPrompt ; $4857
	jp WallPracticeMaxScoreScript ; $4859
WallPracticeScoreRetryPrompt:
	script_fade_in $06 ; $485c
	call WaitFadeEnd ; $4861
	xor a, a ; $4864
	ld [wStoryModeShowLocationName], a ; $4865
	ld hl, wMinigamesCurrentScore ; $4868
	ld a, [hl+] ; $486b
	ld b, [hl] ; $486c
	ld c, a ; $486d
	ldh a, [hWramBank] ; $486e
	push af ; $4870
	wram_bank $07 ; $4871
	ld a, $00 ; $4877
	farcall FarPtr_ReadMinigameRecord ; $4879
	ld hl, $de00 ; $487c
	ld a, [hl+] ; $487f
	ld d, [hl] ; $4880
	ld e, a ; $4881
	pop af ; $4882
	wram_bank ; $4883
	ld l, c ; $4887
	ld h, b ; $4888
	inc de ; $4889
	ld a, l ; $488a
	sub a, e ; $488b
	ld l, a ; $488c
	ld a, h ; $488d
	sbc a, d ; $488e
	ld h, a ; $488f
	jp nc, WallPracticeNewRecordScript ; $4890
	ld a, [wPointOutcome] ; $4893
	cp a, $09 ; $4896
	jr nz, Label_12_48a2 ; $4898
	script_set_text $14fa ; $489a
	jr Label_12_48b5 ; $48a0
Label_12_48a2:
	ld a, [wPointOutcome] ; $48a2
	and a, $03 ; $48a5
	add a, a ; $48a7
	add a, $af ; $48a8
	ld l, a ; $48aa
	adc a, $4a ; $48ab
	sub a, l ; $48ad
	ld h, a ; $48ae
	ld a, [hl+] ; $48af
	ld h, [hl] ; $48b0
	ld l, a ; $48b1
	farcall FarPtr_InitDialogueTextCursor ; $48b2
Label_12_48b5:
	ld hl, wMinigamesCurrentScore ; $48b5
	ld a, [hl+] ; $48b8
	ld h, [hl] ; $48b9
	ld l, a ; $48ba
	farcall FarPtr_PushTextArgNumber ; $48bb
	ld a, $07 ; $48be
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $48c0
	farcall FarPtr_RunDialogueYesNoPrompt ; $48c3
	farcall FarPtr_ScriptCloseDialogueWindow ; $48c6
	script_wait_frames $05 ; $48c9
	and a, a ; $48d0
	jp nz, WallPracticeExitCourtScript ; $48d1
	script_face $07, $c0 ; $48d4
	script_set_anim $07, $02 ; $48db
	script_wait_idle $07 ; $48e2
	jp LaunchWallPracticeMinigame ; $48e7
	ret ; $48ea
WallPracticeNewRecordScript:
	ldh a, [hWramBank] ; $48eb
	push af ; $48ed
	wram_bank $07 ; $48ee
	ld hl, wMinigamesCurrentScore ; $48f4
	ld a, [hl+] ; $48f7
	ld d, [hl] ; $48f8
	ld e, a ; $48f9
	ld hl, $de00 ; $48fa
	ld a, e ; $48fd
	ld [hl+], a ; $48fe
	ld [hl], d ; $48ff
	ld a, $00 ; $4900
	farcall FarPtr_UpdateMinigameRecord ; $4902
	pop af ; $4905
	wram_bank ; $4906
	call SetupWallPracticeLevelSigns ; $490a
	script_set_text $1828 ; $490d
	ld hl, wMinigamesCurrentScore ; $4913
	ld a, [hl+] ; $4916
	ld h, [hl] ; $4917
	ld l, a ; $4918
	farcall FarPtr_PushTextArgNumber ; $4919
	ld a, $07 ; $491c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $491e
	farcall FarPtr_RunDialogueYesNoPrompt ; $4921
	farcall FarPtr_ScriptCloseDialogueWindow ; $4924
	script_wait_frames $05 ; $4927
	and a, a ; $492e
	jp nz, WallPracticeExitCourtScript ; $492f
	jp LaunchWallPracticeMinigame ; $4932
	ret ; $4935
WallPracticeMaxScoreScript:
	script_set_text $1829 ; $4936
	script_speak $07 ; $493c
	ldh a, [hWramBank] ; $4941
	push af ; $4943
	wram_bank $07 ; $4944
	ld a, $00 ; $494a
	farcall FarPtr_ReadMinigameRecord ; $494c
	ld hl, $de00 ; $494f
	ld a, [hl+] ; $4952
	ld h, [hl] ; $4953
	ld l, a ; $4954
	pop af ; $4955
	wram_bank ; $4956
	ld de, $270f ; $495a
	ld a, l ; $495d
	sub a, e ; $495e
	ld l, a ; $495f
	ld a, h ; $4960
	sbc a, d ; $4961
	ld h, a ; $4962
	jp c, Label_12_49e5 ; $4963
	script_set_text $182b ; $4966
	ld a, $07 ; $496c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $496e
	farcall FarPtr_RunDialogueYesNoPrompt ; $4971
	farcall FarPtr_ScriptCloseDialogueWindow ; $4974
	script_wait_frames $05 ; $4977
	and a, a ; $497e
	jr z, RelaunchWallPracticeMasterLevel ; $497f
	script_set_speed $00, $0020 ; $4981
	script_move_target $00, $0500, $3100 ; $4989
	script_wait_move $00 ; $4994
	script_move_player $0500, $3700 ; $4999
	script_move_target $00, $0500, $3900 ; $49a3
	script_wait_move $00 ; $49ae
	script_move_target $07, $0500, $3700 ; $49b3
	script_wait_move $07 ; $49be
	script_face $07, $40 ; $49c3
	jp Label_12_4a6c ; $49ca
RelaunchWallPracticeMasterLevel:
	ld a, $13 ; $49cd
	ld [wStoryModeCurrentLocation], a ; $49cf
	ld a, $0a ; $49d2
	ld [wStoryModeEntryPoint], a ; $49d4
	ld a, $ff ; $49d7
	ld [$c294], a ; $49d9
	ld [wStoryModeExitLocationRequest], a ; $49dc
	ld a, $1b ; $49df
	farcall FarPtr_RunTrainingDrillByID ; $49e1
	ret ; $49e4
Label_12_49e5:
	ldh a, [hWramBank] ; $49e5
	push af ; $49e7
	wram_bank $07 ; $49e8
	ld hl, wMinigamesCurrentScore ; $49ee
	ld a, [hl+] ; $49f1
	ld d, [hl] ; $49f2
	ld e, a ; $49f3
	ld hl, $de00 ; $49f4
	ld a, e ; $49f7
	ld [hl+], a ; $49f8
	ld [hl], d ; $49f9
	ld a, $00 ; $49fa
	farcall FarPtr_UpdateMinigameRecord ; $49fc
	pop af ; $49ff
	wram_bank ; $4a00
	script_set_speed $00, $0020 ; $4a04
	script_move_target $00, $0500, $3100 ; $4a0c
	script_wait_move $00 ; $4a17
	script_move_player $0500, $3700 ; $4a1c
	script_move_target $00, $0500, $3900 ; $4a26
	script_wait_move $00 ; $4a31
	script_move_target $07, $0500, $3700 ; $4a36
	script_wait_move $07 ; $4a41
	script_face $07, $40 ; $4a46
	script_face $00, $c0 ; $4a4d
	script_wait_frames $32 ; $4a54
	script_set_anim $07, $02 ; $4a5b
	script_wait_idle $07 ; $4a62
	script_speak $07 ; $4a67
Label_12_4a6c:
	test_flag $05, 7 ; $4a6c
	jr z, Label_12_4aae ; $4a6f
	script_wait_frames $28 ; $4a71
	script_face_pair $02, $00 ; $4a78
	script_wait_frames $1e ; $4a80
	script_set_anim $00, $03 ; $4a87
	script_set_anim $02, $03 ; $4a8e
	script_wait_idle $02 ; $4a95
	ld a, $02 ; $4a9a
	farcall FarPtr_GetActorStateAddr ; $4a9c
	ld c, l ; $4a9f
	ld b, h ; $4aa0
	ld de, $d000 ; $4aa1
	farcall FarPtr_04_20 ; $4aa4
	script_wait_frames $28 ; $4aa7
Label_12_4aae:
	ret ; $4aae
	; $4aaf, 6 bytes (records:2)
	dw $14f7 ; record 0
	dw $14f8 ; record 1
	dw $14f9 ; record 2
WallPracticeLevelResultScript:
	xor a, a ; $4ab5
	ld [wStoryModeShowLocationName], a ; $4ab6
	ld a, [wPointWinLoseFlag] ; $4ab9
	cp a, $01 ; $4abc
	jp nz, Label_12_4ad0 ; $4abe
	ld a, [$c2b0] ; $4ac1
	sub a, $01 ; $4ac4
	ld a, a ; $4ac6
	rst Rst00 ; $4ac7
	dw Label_12_4bee ; $4ac8 jumptable
	dw Label_12_4bde ; $4aca jumptable
	dw Label_12_4bb2 ; $4acc jumptable
	dw Label_12_4ba2 ; $4ace jumptable
Label_12_4ad0:
	ld a, [$c2b0] ; $4ad0
	cp a, $04 ; $4ad3
	jp z, WallPracticeScoreRetryPrompt ; $4ad5
	script_fade_in $06 ; $4ad8
	call WaitFadeEnd ; $4add
	ld a, [wPointOutcome] ; $4ae0
	cp a, $09 ; $4ae3
	jr nz, Label_12_4aef ; $4ae5
	script_set_text $14f6 ; $4ae7
	jr Label_12_4b02 ; $4aed
Label_12_4aef:
	ld a, [wPointOutcome] ; $4aef
	and a, $03 ; $4af2
	add a, a ; $4af4
	add a, $9c ; $4af5
	ld l, a ; $4af7
	adc a, $4b ; $4af8
	sub a, l ; $4afa
	ld h, a ; $4afb
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	farcall FarPtr_InitDialogueTextCursor ; $4aff
Label_12_4b02:
	ld a, $07 ; $4b02
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4b04
	farcall FarPtr_RunDialogueYesNoPrompt ; $4b07
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b0a
	script_wait_frames $05 ; $4b0d
	and a, a ; $4b14
	jp nz, WallPracticeExitCourtScript ; $4b15
	script_face $07, $c0 ; $4b18
	script_set_anim $07, $02 ; $4b1f
	script_wait_idle $07 ; $4b26
	jp LaunchWallPracticeMinigame ; $4b2b
WallPracticeExitCourtScript:
	script_set_text $14fb ; $4b2e
	script_speak $07 ; $4b34
	script_set_speed $00, $0020 ; $4b39
	script_move_target $00, $0500, $3100 ; $4b41
	script_wait_move $00 ; $4b4c
	script_move_player $0500, $3700 ; $4b51
	script_move_target $00, $0500, $3900 ; $4b5b
	script_wait_move $00 ; $4b66
	script_move_target $07, $0500, $3700 ; $4b6b
	script_wait_move $07 ; $4b76
	script_face $07, $40 ; $4b7b
	test_flag $05, 7 ; $4b82
	jr z, Label_12_4b94 ; $4b85
	ld a, $02 ; $4b87
	farcall FarPtr_GetActorStateAddr ; $4b89
	ld c, l ; $4b8c
	ld b, h ; $4b8d
	ld de, $d000 ; $4b8e
	farcall FarPtr_04_20 ; $4b91
Label_12_4b94:
	script_wait_frames $0a ; $4b94
	ret ; $4b9b
	; $4b9c, 6 bytes (records:2)
	dw $14f3 ; record 0
	dw $14f4 ; record 1
	dw $14f5 ; record 2
Label_12_4ba2:
	script_set_text $14ff ; $4ba2
	script_fade_in $06 ; $4ba8
	call WaitFadeEnd ; $4bad
	jr Label_12_4bfc ; $4bb0
Label_12_4bb2:
	ldh a, [hWramBank] ; $4bb2
	push af ; $4bb4
	wram_bank $07 ; $4bb5
	ld de, $0032 ; $4bbb
	ld hl, $de00 ; $4bbe
	ld a, e ; $4bc1
	ld [hl+], a ; $4bc2
	ld [hl], d ; $4bc3
	ld a, $00 ; $4bc4
	farcall FarPtr_UpdateMinigameRecord ; $4bc6
	pop af ; $4bc9
	wram_bank ; $4bca
	script_set_text $14fe ; $4bce
	script_fade_in $06 ; $4bd4
	call WaitFadeEnd ; $4bd9
	jr Label_12_4bfc ; $4bdc
Label_12_4bde:
	script_set_text $14fd ; $4bde
	script_fade_in $06 ; $4be4
	call WaitFadeEnd ; $4be9
	jr Label_12_4bfc ; $4bec
Label_12_4bee:
	script_set_text $14fc ; $4bee
	script_fade_in $06 ; $4bf4
	call WaitFadeEnd ; $4bf9
Label_12_4bfc:
	script_set_anim $07, $02 ; $4bfc
	script_wait_idle $07 ; $4c03
	script_speak $07 ; $4c08
	script_set_speed $00, $0020 ; $4c0d
	script_move_target $00, $0500, $3100 ; $4c15
	script_wait_move $00 ; $4c20
	script_move_player $0500, $3700 ; $4c25
	script_move_target $00, $0500, $3900 ; $4c2f
	script_wait_move $00 ; $4c3a
	script_move_target $07, $0500, $3700 ; $4c3f
	script_wait_move $07 ; $4c4a
	script_face $07, $40 ; $4c4f
	test_flag $05, 7 ; $4c56
	jr z, Label_12_4c98 ; $4c59
	script_wait_frames $1e ; $4c5b
	script_face_pair $02, $00 ; $4c62
	script_wait_frames $1e ; $4c6a
	script_set_anim $00, $03 ; $4c71
	script_set_anim $02, $03 ; $4c78
	script_wait_idle $02 ; $4c7f
	ld a, $02 ; $4c84
	farcall FarPtr_GetActorStateAddr ; $4c86
	ld c, l ; $4c89
	ld b, h ; $4c8a
	ld de, $d000 ; $4c8b
	farcall FarPtr_04_20 ; $4c8e
	script_wait_frames $14 ; $4c91
Label_12_4c98:
	script_wait_frames $0a ; $4c98
	ret ; $4c9f
	; $4ca0, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $4ca9, $0000 ; record 0
	db $ff
	farcall FarPtr_BeginCutsceneScriptMode ; $4ca9
	script_fade_in $10 ; $4cac
	script_set_text $0483 ; $4cb1
	script_speak $00 ; $4cb7
	farcall FarPtr_EndCutsceneScriptMode ; $4cbc
	ret ; $4cbf
	; $4cc0, 8 bytes (records:8)
; 1 records x 8 bytes
	dw $ff02, $9c00, $4ce9, $0000 ; record 0
	; $4cc8, 34 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $4d29, $0001 ; record 0
	dw $ff04, $0000, $4d98, $0001 ; record 1
	dw $ff05, $0000, $4e0d, $0001 ; record 2
	dw $ff06, $0000, $4e82, $0001 ; record 3
	db $ff, $3e
	nop ; $4cea
	ld bc, $0500 ; $4ceb
	ld de, $3900 ; $4cee
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cf1
	script_wait_move $00 ; $4cf4
	script_move_target $07, $0500, $3700 ; $4cf9
	script_wait_move $07 ; $4d04
	script_face $07, $40 ; $4d09
	clear_flag $1c, 0 ; $4d10
	clear_flag $0f, 5 ; $4d13
	test_flag $05, 7 ; $4d16
	jr z, Label_12_4d28 ; $4d19
	ld a, $02 ; $4d1b
	farcall FarPtr_GetActorStateAddr ; $4d1d
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, $d000 ; $4d22
	farcall FarPtr_04_20 ; $4d25
Label_12_4d28:
	ret ; $4d28
	script_set_text $1830 ; $4d29
	ld a, $07 ; $4d2f
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4d31
	farcall FarPtr_RunDialogueYesNoPrompt ; $4d34
	farcall FarPtr_ScriptCloseDialogueWindow ; $4d37
	script_wait_frames $05 ; $4d3a
	and a, a ; $4d41
	jr nz, Label_12_4d97 ; $4d42
	script_face $07, $c0 ; $4d44
	script_set_anim $07, $02 ; $4d4b
	script_set_speed $00, $0020 ; $4d52
	script_move_target $00, $0300, $3100 ; $4d5a
	script_wait_move $00 ; $4d65
	script_move_target $00, $0c00, $3100 ; $4d6a
	ld c, $04 ; $4d75
	call BeginFadeOut ; $4d77
	call WaitFadeEnd ; $4d7a
	ld a, $13 ; $4d7d
	ld [wStoryModeCurrentLocation], a ; $4d7f
	ld a, $0b ; $4d82
	ld [wStoryModeEntryPoint], a ; $4d84
	ld a, $ff ; $4d87
	ld [$c294], a ; $4d89
	ld [wStoryModeExitLocationRequest], a ; $4d8c
	ld a, $16 ; $4d8f
	farcall FarPtr_RunTrainingDrillByID ; $4d91
	farcall FarPtr_EndCutsceneScriptMode ; $4d94
Label_12_4d97:
	ret ; $4d97
	test_flag $1a, 7 ; $4d98
	jp z, WallPracticeLevelLockedScript ; $4d9b
	script_set_text $1831 ; $4d9e
	ld a, $07 ; $4da4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4da6
	farcall FarPtr_RunDialogueYesNoPrompt ; $4da9
	farcall FarPtr_ScriptCloseDialogueWindow ; $4dac
	script_wait_frames $05 ; $4daf
	and a, a ; $4db6
	jr nz, Label_12_4e0c ; $4db7
	script_face $07, $c0 ; $4db9
	script_set_anim $07, $02 ; $4dc0
	script_set_speed $00, $0020 ; $4dc7
	script_move_target $00, $0700, $3100 ; $4dcf
	script_wait_move $00 ; $4dda
	script_move_target $00, $0c00, $3100 ; $4ddf
	ld c, $04 ; $4dea
	call BeginFadeOut ; $4dec
	call WaitFadeEnd ; $4def
	ld a, $13 ; $4df2
	ld [wStoryModeCurrentLocation], a ; $4df4
	ld a, $0b ; $4df7
	ld [wStoryModeEntryPoint], a ; $4df9
	ld a, $ff ; $4dfc
	ld [$c294], a ; $4dfe
	ld [wStoryModeExitLocationRequest], a ; $4e01
	ld a, $17 ; $4e04
	farcall FarPtr_RunTrainingDrillByID ; $4e06
	farcall FarPtr_EndCutsceneScriptMode ; $4e09
Label_12_4e0c:
	ret ; $4e0c
	test_flag $1b, 0 ; $4e0d
	jp z, WallPracticeLevelLockedScript ; $4e10
	script_set_text $1832 ; $4e13
	ld a, $07 ; $4e19
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e1b
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e1e
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e21
	script_wait_frames $05 ; $4e24
	and a, a ; $4e2b
	jr nz, Label_12_4e81 ; $4e2c
	script_face $07, $c0 ; $4e2e
	script_set_anim $07, $02 ; $4e35
	script_set_speed $00, $0020 ; $4e3c
	script_move_target $00, $1100, $3100 ; $4e44
	script_wait_move $00 ; $4e4f
	script_move_target $00, $0c00, $3100 ; $4e54
	ld c, $04 ; $4e5f
	call BeginFadeOut ; $4e61
	call WaitFadeEnd ; $4e64
	ld a, $13 ; $4e67
	ld [wStoryModeCurrentLocation], a ; $4e69
	ld a, $0b ; $4e6c
	ld [wStoryModeEntryPoint], a ; $4e6e
	ld a, $ff ; $4e71
	ld [$c294], a ; $4e73
	ld [wStoryModeExitLocationRequest], a ; $4e76
	ld a, $18 ; $4e79
	farcall FarPtr_RunTrainingDrillByID ; $4e7b
	farcall FarPtr_EndCutsceneScriptMode ; $4e7e
Label_12_4e81:
	ret ; $4e81
	test_flag $1b, 1 ; $4e82
	jp z, WallPracticeLevelLockedScript ; $4e85
	script_set_text $1833 ; $4e88
	ld a, $07 ; $4e8e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e90
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e93
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e96
	script_wait_frames $05 ; $4e99
	and a, a ; $4ea0
	jr nz, Label_12_4ef6 ; $4ea1
	script_face $07, $c0 ; $4ea3
	script_set_anim $07, $02 ; $4eaa
	script_set_speed $00, $0020 ; $4eb1
	script_move_target $00, $1500, $3100 ; $4eb9
	script_wait_move $00 ; $4ec4
	script_move_target $00, $0c00, $3100 ; $4ec9
	ld c, $04 ; $4ed4
	call BeginFadeOut ; $4ed6
	call WaitFadeEnd ; $4ed9
	ld a, $13 ; $4edc
	ld [wStoryModeCurrentLocation], a ; $4ede
	ld a, $0b ; $4ee1
	ld [wStoryModeEntryPoint], a ; $4ee3
	ld a, $ff ; $4ee6
	ld [$c294], a ; $4ee8
	ld [wStoryModeExitLocationRequest], a ; $4eeb
	ld a, $19 ; $4eee
	farcall FarPtr_RunTrainingDrillByID ; $4ef0
	farcall FarPtr_EndCutsceneScriptMode ; $4ef3
Label_12_4ef6:
	ret ; $4ef6
WallPracticeLevelLockedScript:
	script_set_text $1834 ; $4ef7
	script_speak $07 ; $4efd
	ret ; $4f02
	farcall FarPtr_WaitPlayerMoveDone ; $4f03
	ld a, $00 ; $4f06
	ld [$c329], a ; $4f08
	ld a, $27 ; $4f0b
	ld [$c32a], a ; $4f0d
	ld a, $18 ; $4f10
	ld [$c32b], a ; $4f12
	ld a, $3c ; $4f15
	ld [$c32c], a ; $4f17
	call DisableLCDSafely ; $4f1a
	ld a, $00 ; $4f1d
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4f1f
	call EnableLCD ; $4f22
	call SetupWallPracticeLevelSigns ; $4f25
	ld a, [wStoryModeEntryPoint] ; $4f28
	cp a, $0a ; $4f2b
	jp z, Label_12_4f39 ; $4f2d
	cp a, $0b ; $4f30
	jp z, Label_12_4f8a ; $4f32
	call RestoreWallPracticeRoomActors ; $4f35
	ret ; $4f38
Label_12_4f39:
	test_flag $05, 7 ; $4f39
	jr z, Label_12_4f55 ; $4f3c
	ld a, $02 ; $4f3e
	farcall FarPtr_SetActorNullScript ; $4f40
	script_set_position $02, $0700, $3900 ; $4f43
	script_face $02, $c0 ; $4f4e
Label_12_4f55:
	script_set_position $07, $0300, $3700 ; $4f55
	script_face $07, $00 ; $4f60
	ld a, [wMatchExitRequest] ; $4f67
	cp a, $01 ; $4f6a
	jp nz, Label_12_4f7e ; $4f6c
	script_fade_in $06 ; $4f6f
	call WaitFadeEnd ; $4f74
	xor a, a ; $4f77
	ld [wStoryModeShowLocationName], a ; $4f78
	jp WallPracticeExitCourtScript ; $4f7b
Label_12_4f7e:
	ld a, [$c2b0] ; $4f7e
	cp a, $05 ; $4f81
	jp nc, WallPracticeMasterResultScript ; $4f83
	jp WallPracticeLevelResultScript ; $4f86
	ret ; $4f89
Label_12_4f8a:
	test_flag $05, 7 ; $4f8a
	jr z, Label_12_4fa6 ; $4f8d
	ld a, $02 ; $4f8f
	farcall FarPtr_SetActorNullScript ; $4f91
	script_set_position $02, $0700, $3900 ; $4f94
	script_face $02, $c0 ; $4f9f
Label_12_4fa6:
	set_flag $1c, 0 ; $4fa6
	script_set_position $07, $0300, $3700 ; $4fa9
	script_face $07, $00 ; $4fb4
	script_fade_in $06 ; $4fbb
	call WaitFadeEnd ; $4fc0
	xor a, a ; $4fc3
	ld [wStoryModeShowLocationName], a ; $4fc4
	ld a, [wMatchExitRequest] ; $4fc7
	cp a, $01 ; $4fca
	jp z, Label_12_505e ; $4fcc
	ld a, [wPointWinLoseFlag] ; $4fcf
	cp a, $01 ; $4fd2
	jr nz, Label_12_4ff3 ; $4fd4
	script_set_text $1835 ; $4fd6
	ld a, $07 ; $4fdc
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4fde
	farcall FarPtr_RunDialogueYesNoPrompt ; $4fe1
	farcall FarPtr_ScriptCloseDialogueWindow ; $4fe4
	script_wait_frames $05 ; $4fe7
	and a, a ; $4fee
	jr nz, Label_12_505e ; $4fef
	jr Label_12_502b ; $4ff1
Label_12_4ff3:
	ld a, [wPointOutcome] ; $4ff3
	cp a, $09 ; $4ff6
	jr nz, Label_12_5002 ; $4ff8
	script_set_text $14f6 ; $4ffa
	jr Label_12_5015 ; $5000
Label_12_5002:
	ld a, [wPointOutcome] ; $5002
	and a, $03 ; $5005
	add a, a ; $5007
	add a, $9c ; $5008
	ld l, a ; $500a
	adc a, $4b ; $500b
	sub a, l ; $500d
	ld h, a ; $500e
	ld a, [hl+] ; $500f
	ld h, [hl] ; $5010
	ld l, a ; $5011
	farcall FarPtr_InitDialogueTextCursor ; $5012
Label_12_5015:
	ld a, $07 ; $5015
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5017
	farcall FarPtr_RunDialogueYesNoPrompt ; $501a
	farcall FarPtr_ScriptCloseDialogueWindow ; $501d
	script_wait_frames $05 ; $5020
	and a, a ; $5027
	jp nz, Label_12_505e ; $5028
Label_12_502b:
	script_face $07, $c0 ; $502b
	script_set_anim $07, $02 ; $5032
	script_wait_idle $07 ; $5039
	ld c, $04 ; $503e
	call BeginFadeOut ; $5040
	call WaitFadeEnd ; $5043
	ld a, $13 ; $5046
	ld [wStoryModeCurrentLocation], a ; $5048
	ld a, $0b ; $504b
	ld [wStoryModeEntryPoint], a ; $504d
	ld a, $ff ; $5050
	ld [$c294], a ; $5052
	ld [wStoryModeExitLocationRequest], a ; $5055
	ld a, [$c8f7] ; $5058
	farcall FarPtr_RunTrainingDrillByID ; $505b
Label_12_505e:
	ret ; $505e
SetupWallPracticeLevelSigns:
	ld a, $00 ; $505f
	test_flag $1a, 6 ; $5061
	jp z, Label_12_50c8 ; $5064
	script_copy_scene_rect $1e, $2c, $02, $2c, $02, $02 ; $5067
	ld a, $01 ; $5076
	test_flag $1a, 7 ; $5078
	jr z, Label_12_50c8 ; $507b
	script_copy_scene_rect $1e, $30, $06, $2c, $02, $02 ; $507d
	ld a, $02 ; $508c
	test_flag $1b, 0 ; $508e
	jr z, Label_12_50c8 ; $5091
	script_copy_scene_rect $1e, $34, $10, $2c, $02, $02 ; $5093
	ld a, $03 ; $50a2
	test_flag $1b, 1 ; $50a4
	jr z, Label_12_50c8 ; $50a7
	script_copy_scene_rect $1e, $38, $14, $2c, $02, $02 ; $50a9
	ld a, $04 ; $50b8
	test_flag $1b, 3 ; $50ba
	jr z, Label_12_50c8 ; $50bd
	ld a, $05 ; $50bf
	test_flag $1b, 5 ; $50c1
	jr z, Label_12_50c8 ; $50c4
	ld a, $06 ; $50c6
Label_12_50c8:
	ld [$c2b0], a ; $50c8
	ret ; $50cb
	test_flag $1c, 0 ; $50cc
	jr z, Label_12_50dd ; $50cf
	script_set_text $1508 ; $50d1
	script_speak $07 ; $50d7
	ret ; $50dc
Label_12_50dd:
	ld a, [$c2b0] ; $50dd
	add a, a ; $50e0
	add a, $71 ; $50e1
	ld l, a ; $50e3
	adc a, $52 ; $50e4
	sub a, l ; $50e6
	ld h, a ; $50e7
	ld a, [hl+] ; $50e8
	ld h, [hl] ; $50e9
	ld l, a ; $50ea
	farcall FarPtr_InitDialogueTextCursor ; $50eb
	ld a, [$c2b0] ; $50ee
	cp a, $05 ; $50f1
	jr nz, Label_12_5111 ; $50f3
	ldh a, [hWramBank] ; $50f5
	push af ; $50f7
	wram_bank $07 ; $50f8
	ld a, $00 ; $50fe
	farcall FarPtr_ReadMinigameRecord ; $5100
	ld hl, $de00 ; $5103
	ld a, [hl+] ; $5106
	ld h, [hl] ; $5107
	ld l, a ; $5108
	pop af ; $5109
	wram_bank ; $510a
	farcall FarPtr_PushTextArgNumber ; $510e
Label_12_5111:
	ld a, $07 ; $5111
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5113
	farcall FarPtr_RunDialogueYesNoPrompt ; $5116
	farcall FarPtr_ScriptCloseDialogueWindow ; $5119
	script_wait_frames $05 ; $511c
	and a, a ; $5123
	jp z, Label_12_51ba ; $5124
	ld a, [$c2b0] ; $5127
	add a, a ; $512a
	add a, $7f ; $512b
	ld l, a ; $512d
	adc a, $52 ; $512e
	sub a, l ; $5130
	ld h, a ; $5131
	ld a, [hl+] ; $5132
	ld h, [hl] ; $5133
	ld l, a ; $5134
	farcall FarPtr_InitDialogueTextCursor ; $5135
	ld a, $07 ; $5138
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $513a
	farcall FarPtr_RunDialogueYesNoPrompt ; $513d
	farcall FarPtr_ScriptCloseDialogueWindow ; $5140
	script_wait_frames $05 ; $5143
	and a, a ; $514a
	jp nz, Label_12_51b1 ; $514b
	ld a, [$c2b0] ; $514e
	and a, a ; $5151
	jp z, Label_12_51b4 ; $5152
	script_move_target $07, $0300, $3700 ; $5155
	script_wait_move $07 ; $5160
	script_face $07, $00 ; $5165
	script_speak $07 ; $516c
	test_flag $05, 7 ; $5171
	jr z, Label_12_5192 ; $5174
	ld a, $02 ; $5176
	farcall FarPtr_SetActorNullScript ; $5178
	script_move_target $02, $0700, $3900 ; $517b
	script_wait_move $02 ; $5186
	script_face $02, $c0 ; $518b
Label_12_5192:
	script_set_speed $00, $0020 ; $5192
	script_move_target $00, $0500, $3500 ; $519a
	script_wait_move $00 ; $51a5
	set_flag $1c, 0 ; $51aa
	set_flag $0f, 5 ; $51ad
	ret ; $51b0
Label_12_51b1:
	farcall FarPtr_AdvanceDialogueTextCursor ; $51b1
Label_12_51b4:
	script_speak $07 ; $51b4
	ret ; $51b9
Label_12_51ba:
	script_set_anim $07, $03 ; $51ba
	script_wait_idle $07 ; $51c1
	script_speak $07 ; $51c6
	script_move_target $07, $0300, $3700 ; $51cb
	script_wait_move $07 ; $51d6
	script_face $07, $00 ; $51db
	test_flag $05, 7 ; $51e2
	jr z, Label_12_522c ; $51e5
	script_wait_frames $14 ; $51e7
	ld a, $02 ; $51ee
	farcall FarPtr_SetActorNullScript ; $51f0
	script_move_target $02, $0700, $3900 ; $51f3
	script_wait_move $02 ; $51fe
	script_face_pair $02, $00 ; $5203
	script_wait_frames $1e ; $520b
	script_set_anim $00, $03 ; $5212
	script_set_anim $02, $03 ; $5219
	script_wait_idle $02 ; $5220
	script_wait_frames $14 ; $5225
Label_12_522c:
	script_set_speed $00, $0020 ; $522c
	script_move_target $00, $0500, $3700 ; $5234
	script_wait_move $00 ; $523f
	script_move_target $00, $0500, $3100 ; $5244
	script_wait_move $00 ; $524f
	script_face $07, $c0 ; $5254
	script_set_anim $07, $02 ; $525b
	script_move_target $00, $0c00, $3100 ; $5262
	jp LaunchWallPracticeMinigame ; $526d
	ret ; $5270
	; $5271, 14 bytes (records:2)
	dw $14ee ; record 0
	dw $1505 ; record 1
	dw $1803 ; record 2
	dw $180f ; record 3
	dw $1819 ; record 4
	dw $181e ; record 5
	dw $1823 ; record 6
	; $527f, 14 bytes (records:2)
	dw $14f0 ; record 0
	dw $1507 ; record 1
	dw $1805 ; record 2
	dw $1811 ; record 3
	dw $181b ; record 4
	dw $1820 ; record 5
	dw $1825 ; record 6
LaunchWallPracticeMinigame:
	ld c, $04 ; $528d
	call BeginFadeOut ; $528f
	call WaitFadeEnd ; $5292
	ld a, $13 ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [wStoryModeEntryPoint], a ; $529c
	ld a, $ff ; $529f
	ld [$c294], a ; $52a1
	ld [wStoryModeExitLocationRequest], a ; $52a4
	ld a, [$c2b0] ; $52a7
	add a, $b9 ; $52aa
	ld l, a ; $52ac
	adc a, $52 ; $52ad
	sub a, l ; $52af
	ld h, a ; $52b0
	ld a, [hl] ; $52b1
	farcall FarPtr_RunTrainingDrillByID ; $52b2
	farcall FarPtr_EndCutsceneScriptMode ; $52b5
	ret ; $52b8
	; $52b9, 7 bytes (bytes:16)
	db $16, $17, $18, $19, $1b, $1b, $1b ; 0x00
RestoreWallPracticeRoomActors:
	test_flag $0f, 5 ; $52c0
	jr z, Label_12_52f6 ; $52c3
	set_flag $1c, 0 ; $52c5
	script_set_position $07, $0300, $3700 ; $52c8
	script_face $07, $00 ; $52d3
	test_flag $05, 7 ; $52da
	jr z, Label_12_52f6 ; $52dd
	ld a, $02 ; $52df
	farcall FarPtr_SetActorNullScript ; $52e1
	script_set_position $02, $0700, $3900 ; $52e4
	script_face $02, $c0 ; $52ef
Label_12_52f6:
	ret ; $52f6
SeniorCourtStoryCmds_12:
	; $52f7, 14 bytes (map_tree)
	dw SeniorCourtEntryPoints_12 ; slot 0 EntryPoints
	dw SeniorCourtExitTriggers_12 ; slot 1 ExitTriggers
	dw SeniorCourtActors_12 ; slot 2 Actors
	dw SeniorCourtNpcScripts_12 ; slot 3 NpcScripts
	dw SeniorCourtFacingScripts_12 ; slot 4 FacingScripts
	dw SeniorCourtTileTriggers_12 ; slot 5 TileTriggers
	dw SeniorCourtInitScript_12 ; slot 6 InitScript
SeniorCourtActors_12:
	; $5305, 618 bytes (map_actors)
	map_actor $0000, ActorObjDef_12_7a89, $2900, $1900, $80, $49, $01, $00
	map_actor $0000, ActorObjDef_12_79e3, $3500, $1e00, $c0, $65, $06, $07
	map_actor $0000, ActorObjDef_12_7c59, $3200, $1e00, $00, $64, $01, $05
	map_actor $0000, ActorObjDef_12_7a93, $3300, $1100, $80, $69, $01, $04
	map_actor $0000, ActorObjDef_12_7a89, $2900, $1300, $80, $66, $01, $06
	map_actor $0000, ActorObjDef_12_79e3, $0b00, $1500, $c0, $6b, $01, $05
	map_actor $0000, ActorObjDef_12_7c66, $0b00, $1300, $40, $67, $01, $03
	map_actor $0000, ActorObjDef_12_7bf0, $1500, $1700, $c0, $68, $01, $06
	map_actor $0000, ActorObjDef_12_7b89, $1300, $0b00, $40, $6a, $01, $03
	map_actor $05e0, ActorObjDef_12_7a93, $0900, $0b00, $40, $29, $01, $00
	map_actor $0000, ActorObjDef_12_7abf, $2200, $1300, $40, $54, $01, $00
	map_actor $0000, ActorObjDef_12_7b22, $2500, $1d00, $c0, $54, $01, $04
	map_actor_end
	map_actor $0000, ActorObjDef_12_7a89, $2d00, $1900, $40, $49, $01, $00
	map_actor $0000, ActorObjDef_12_7a89, $2900, $1b00, $80, $65, $01, $07
	map_actor $0000, ActorObjDef_12_7c59, $3900, $1d00, $80, $64, $01, $05
	map_actor $0000, ActorObjDef_12_7a89, $2d00, $1300, $00, $69, $01, $04
	map_actor $0000, ActorObjDef_12_7a89, $2b00, $1100, $80, $66, $01, $06
	map_actor $0000, ActorObjDef_12_79e3, $0a00, $1500, $c0, $6b, $01, $05
	map_actor $0000, ActorObjDef_12_7a89, $0300, $1700, $00, $67, $01, $03
	map_actor $0000, ActorObjDef_12_7c59, $1200, $0d00, $00, $68, $01, $06
	map_actor $0000, ActorObjDef_12_79ea, $1500, $0d00, $40, $6a, $06, $03
	map_actor $05e0, ActorObjDef_12_7a93, $0300, $0b00, $40, $29, $01, $00
	map_actor $0000, ActorObjDef_12_7abf, $2200, $1100, $40, $54, $01, $05
	map_actor $0000, ActorObjDef_12_7b22, $2600, $1d00, $c0, $54, $01, $00
	map_actor $0000, ActorObjDef_12_7b89, $3200, $1100, $40, $54, $01, $00
	map_actor $0000, ActorObjDef_12_7bf0, $3600, $1d00, $c0, $54, $01, $06
	map_actor $0000, ActorObjDef_12_7a89, $4000, $4000, $c0, $53, $01, $00
	map_actor_end
	map_actor $0000, ActorObjDef_12_7a89, $2d00, $1900, $40, $49, $01, $00
	map_actor $0000, ActorObjDef_12_79e3, $2d00, $1100, $c0, $65, $06, $07
	map_actor $0000, ActorObjDef_12_7c59, $2d00, $0f00, $40, $64, $01, $05
	map_actor $0000, ActorObjDef_12_7a89, $3900, $1d00, $80, $69, $01, $04
	map_actor $0000, ActorObjDef_12_7a89, $3900, $1b00, $80, $66, $01, $06
	map_actor $0000, ActorObjDef_12_79e3, $2300, $1e00, $c0, $6b, $01, $05
	map_actor $0000, ActorObjDef_12_7a89, $2300, $1c00, $40, $67, $01, $03
	map_actor $0000, ActorObjDef_12_7a89, $0900, $0700, $00, $68, $01, $06
	map_actor $0000, ActorObjDef_12_7a89, $0b00, $0700, $80, $6a, $01, $03
	map_actor $05e0, ActorObjDef_12_7a93, $0300, $0b00, $40, $29, $01, $00
	map_actor $0000, ActorObjDef_12_7abf, $1200, $0b00, $40, $54, $01, $05
	map_actor $0000, ActorObjDef_12_7b22, $1600, $1600, $c0, $54, $01, $00
	map_actor $0000, ActorObjDef_12_7b89, $3200, $1100, $40, $54, $01, $00
	map_actor $0000, ActorObjDef_12_7bf0, $3600, $1d00, $c0, $54, $01, $06
	map_actor $0000, ActorObjDef_12_7a89, $4000, $4000, $c0, $53, $01, $00
	map_actor_end
SeniorCourtEntryPoints_12:
	; $556f, 17 bytes (map_entries)
	map_entry $01, $c0, $2b00, $2300, $0000
	map_entry $09, $c0, $0b00, $1900, $0000
	db $ff
SeniorCourtExitTriggers_12:
	; $5580, 17 bytes (map_scripts)
	map_script $01, $ff, $0000, Func_12_5591, $08, $03
	map_script $0f, $ff, $0000, Func_12_7ab1, $10, $0f
	db $ff
Func_12_5591:
	clear_flag $0f, 4 ; $5591
	script_move_angle $00, $40, $0200 ; $5594
	script_move_angle $02, $40, $0200 ; $559e
	ld c, $10 ; $55a8
	call BeginFadeOut ; $55aa
	script_wait_frames $1e ; $55ad
	ret ; $55b4
Label_12_55b5:
	ld a, [$c2b1] ; $55b5
	sub a, $09 ; $55b8
	add a, a ; $55ba
	add a, $dc ; $55bb
	ld l, a ; $55bd
	adc a, $55 ; $55be
	sub a, l ; $55c0
	ld h, a ; $55c1
	ld a, [hl+] ; $55c2
	ld h, [hl] ; $55c3
	ld l, a ; $55c4
	farcall FarPtr_InitDialogueTextCursor ; $55c5
	ld a, [$c90d] ; $55c8
	ld hl, $001d ; $55cb
	add a, l ; $55ce
	ld l, a ; $55cf
	jr nc, Label_12_55d3 ; $55d0
	inc h ; $55d2
Label_12_55d3:
	call PushTextArgFetchedString ; $55d3
	script_speak $03 ; $55d6
	ret ; $55db
	; $55dc, 12 bytes (records:2)
	dw $108d ; record 0
	dw $1097 ; record 1
	dw $109e ; record 2
	dw $10a8 ; record 3
	dw $10b0 ; record 4
	dw $10ba ; record 5
Label_12_55e8:
	ld a, [$c2b1] ; $55e8
	cp a, $02 ; $55eb
	jr c, Label_12_5606 ; $55ed
	cp a, $09 ; $55ef
	jr nc, Label_12_55b5 ; $55f1
	call Func_12_5ef1 ; $55f3
	ret ; $55f6
Label_12_55f7:
	ld a, [$c2b1] ; $55f7
	cp a, $02 ; $55fa
	jr c, Label_12_5606 ; $55fc
	cp a, $09 ; $55fe
	jr nc, Label_12_55b5 ; $5600
	call Func_12_5f03 ; $5602
	ret ; $5605
Label_12_5606:
	test_flag $05, 7 ; $5606
	jp nz, Label_12_5704 ; $5609
	script_set_text $1004 ; $560c
	ld a, $03 ; $5612
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5614
	farcall FarPtr_RunDialogueYesNoPrompt ; $5617
	farcall FarPtr_ScriptCloseDialogueWindow ; $561a
	script_wait_frames $05 ; $561d
	and a, a ; $5624
	jr z, Label_12_562a ; $5625
	farcall FarPtr_AdvanceDialogueTextCursor ; $5627
Label_12_562a:
	script_speak $03 ; $562a
	ret ; $562f
Func_12_5630:
	test_flag $05, 7 ; $5630
	jr z, Label_12_55e8 ; $5633
	test_flag $0e, 4 ; $5635
	jp nz, Label_12_57f4 ; $5638
	script_set_speed $00, $0010 ; $563b
	script_set_speed $02, $0010 ; $5643
	ld a, $02 ; $564b
	farcall FarPtr_SetActorNullScript ; $564d
	script_move_target $00, $2900, $1b00 ; $5650
	script_move_target $02, $2700, $1d00 ; $565b
	script_wait_move $02 ; $5666
	script_move_target $02, $2b00, $1d00 ; $566b
	script_wait_move $02 ; $5676
	script_move_target $02, $2b00, $1900 ; $567b
	script_wait_move $02 ; $5686
	script_face_toward $03, $02 ; $568b
	script_wait_move $00 ; $5693
	jp Label_12_5747 ; $5698
Func_12_569b:
	test_flag $05, 7 ; $569b
	jp z, Label_12_55f7 ; $569e
	test_flag $0e, 4 ; $56a1
	jp nz, Label_12_57f4 ; $56a4
	script_set_speed $02, $0010 ; $56a7
	script_set_speed $00, $0008 ; $56af
	script_face $00, $c0 ; $56b7
	script_facing_lock $00, $01 ; $56be
	ld a, $02 ; $56c5
	farcall FarPtr_SetActorNullScript ; $56c7
	script_move_target $00, $2900, $1b00 ; $56ca
	script_move_target $02, $2b00, $1b00 ; $56d5
	script_wait_move $02 ; $56e0
	script_move_target $02, $2b00, $1900 ; $56e5
	script_wait_move $02 ; $56f0
	script_face_toward $03, $02 ; $56f5
	script_wait_move $00 ; $56fd
	jr Label_12_5747 ; $5702
Label_12_5704:
	test_flag $0e, 4 ; $5704
	jp nz, Label_12_57f4 ; $5707
	script_set_speed $00, $0010 ; $570a
	script_set_speed $02, $0010 ; $5712
	ld a, $02 ; $571a
	farcall FarPtr_SetActorNullScript ; $571c
	script_move_target $00, $2900, $1b00 ; $571f
	script_move_target $02, $2b00, $1900 ; $572a
	script_wait_move $02 ; $5735
	script_face_toward $03, $02 ; $573a
	script_wait_move $00 ; $5742
Label_12_5747:
	script_face_toward $03, $00 ; $5747
	script_face_toward $02, $03 ; $574f
	script_set_anim $03, $03 ; $5757
	script_wait_idle $03 ; $575e
	script_wait_frames $1e ; $5763
	script_face_toward $00, $03 ; $576a
	script_set_anim $03, $03 ; $5772
	script_wait_idle $03 ; $5779
	script_facing_lock $00, $00 ; $577e
	script_face $00, $c0 ; $5785
	script_set_text $1007 ; $578c
	set_flag $0e, 4 ; $5792
	ld a, [$c94d] ; $5795
	or a, a ; $5798
	jr nz, Label_12_57a1 ; $5799
	script_set_text $100b ; $579b
Label_12_57a1:
	script_speak $03 ; $57a1
	script_face_toward $02, $03 ; $57a6
	script_speak $03 ; $57ae
	script_set_anim $02, $03 ; $57b3
	script_wait_idle $02 ; $57ba
	script_speak $02 ; $57bf
	script_set_speed $00, $0018 ; $57c4
	script_set_speed $02, $0018 ; $57cc
	script_move_target $02, $2b00, $1b00 ; $57d4
	script_wait_move $02 ; $57df
	script_face_toward $03, $02 ; $57e4
	script_face_toward $02, $03 ; $57ec
Label_12_57f4:
	script_set_text $100a ; $57f4
	script_speak $03 ; $57fa
	script_set_anim $00, $03 ; $57ff
	script_set_anim $02, $03 ; $5806
	script_wait_idle $02 ; $580d
	ld a, $02 ; $5812
	farcall FarPtr_GetActorStateAddr ; $5814
	ld c, l ; $5817
	ld b, h ; $5818
	ld de, $d000 ; $5819
	farcall FarPtr_04_20 ; $581c
	ret ; $581f
Func_12_5820:
	ld a, [$c2b1] ; $5820
	add a, a ; $5823
	add a, $47 ; $5824
	ld l, a ; $5826
	adc a, $58 ; $5827
	sub a, l ; $5829
	ld h, a ; $582a
	ld a, [hl+] ; $582b
	ld h, [hl] ; $582c
	ld l, a ; $582d
	farcall FarPtr_InitDialogueTextCursor ; $582e
	script_speak $04 ; $5831
	ld a, [$c2b1] ; $5836
	cp a, $02 ; $5839
	jr nc, Label_12_583f ; $583b
	jr Label_12_5846 ; $583d
Label_12_583f:
	ld a, [$c2b1] ; $583f
	cp a, $06 ; $5842
	jr c, Label_12_5846 ; $5844
Label_12_5846:
	ret ; $5846
	; $5847, 18 bytes (records:2)
	dw $100e ; record 0
	dw $100e ; record 1
	dw $101a ; record 2
	dw $101a ; record 3
	dw $101a ; record 4
	dw $101b ; record 5
	dw $1055 ; record 6
	dw $1055 ; record 7
	dw $1056 ; record 8
Func_12_5859:
	ld a, [$c2b1] ; $5859
	add a, a ; $585c
	add a, $95 ; $585d
	ld l, a ; $585f
	adc a, $58 ; $5860
	sub a, l ; $5862
	ld h, a ; $5863
	ld a, [hl+] ; $5864
	ld h, [hl] ; $5865
	ld l, a ; $5866
	farcall FarPtr_InitDialogueTextCursor ; $5867
	ld a, [$c2b1] ; $586a
	cp a, $04 ; $586d
	jr z, Label_12_5877 ; $586f
	script_speak $05 ; $5871
	ret ; $5876
Label_12_5877:
	ld a, $05 ; $5877
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5879
	farcall FarPtr_RunDialogueYesNoPrompt ; $587c
	farcall FarPtr_ScriptCloseDialogueWindow ; $587f
	script_wait_frames $05 ; $5882
	and a, a ; $5889
	jr z, Label_12_588f ; $588a
	farcall FarPtr_AdvanceDialogueTextCursor ; $588c
Label_12_588f:
	script_speak $05 ; $588f
	ret ; $5894
	INCBIN "data/bank_012/d_5895.bin" ; $5895, 30 bytes
Func_12_58b3:
	ld a, [$c2b1] ; $58b3
	add a, a ; $58b6
	add a, $f8 ; $58b7
	ld l, a ; $58b9
	adc a, $58 ; $58ba
	sub a, l ; $58bc
	ld h, a ; $58bd
	ld a, [hl+] ; $58be
	ld h, [hl] ; $58bf
	ld l, a ; $58c0
	farcall FarPtr_InitDialogueTextCursor ; $58c1
	ld a, [$c2b1] ; $58c4
	cp a, $06 ; $58c7
	jr z, Label_12_58d1 ; $58c9
	script_speak $06 ; $58cb
	ret ; $58d0
Label_12_58d1:
	ld a, $06 ; $58d1
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $58d3
	farcall FarPtr_RunDialogueYesNoPrompt ; $58d6
	farcall FarPtr_ScriptCloseDialogueWindow ; $58d9
	script_wait_frames $05 ; $58dc
	and a, a ; $58e3
	jr z, Label_12_58f2 ; $58e4
	farcall FarPtr_AdvanceDialogueTextCursor ; $58e6
	ld a, [$c94d] ; $58e9
	or a, a ; $58ec
	jr nz, Label_12_58f2 ; $58ed
	farcall FarPtr_AdvanceDialogueTextCursor ; $58ef
Label_12_58f2:
	script_speak $06 ; $58f2
	ret ; $58f7
	INCBIN "data/bank_012/d_58f8.bin" ; $58f8, 30 bytes
Func_12_5916:
	ld a, [$c2b1] ; $5916
	add a, a ; $5919
	add a, $2d ; $591a
	ld l, a ; $591c
	adc a, $59 ; $591d
	sub a, l ; $591f
	ld h, a ; $5920
	ld a, [hl+] ; $5921
	ld h, [hl] ; $5922
	ld l, a ; $5923
	farcall FarPtr_InitDialogueTextCursor ; $5924
	script_speak $07 ; $5927
	ret ; $592c
	; $592d, 30 bytes (records:2)
	dw $1011 ; record 0
	dw $1019 ; record 1
	dw $1025 ; record 2
	dw $1026 ; record 3
	dw $1026 ; record 4
	dw $1026 ; record 5
	dw $105d ; record 6
	dw $105f ; record 7
	dw $1061 ; record 8
	dw $1090 ; record 9
	dw $1099 ; record 10
	dw $10a1 ; record 11
	dw $10aa ; record 12
	dw $10b3 ; record 13
	dw $10bc ; record 14
Func_12_594b:
	ld a, [$c2b1] ; $594b
	add a, a ; $594e
	add a, $2b ; $594f
	ld l, a ; $5951
	adc a, $5a ; $5952
	sub a, l ; $5954
	ld h, a ; $5955
	ld a, [hl+] ; $5956
	ld h, [hl] ; $5957
	ld l, a ; $5958
	farcall FarPtr_InitDialogueTextCursor ; $5959
	ld a, [$c2b1] ; $595c
	cp a, $02 ; $595f
	jr z, Label_12_5979 ; $5961
	jr nc, Label_12_5973 ; $5963
	script_face $08, $c0 ; $5965
	script_set_anim $08, $06 ; $596c
Label_12_5973:
	script_speak $08 ; $5973
	ret ; $5978
Label_12_5979:
	ld a, $08 ; $5979
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $597b
	farcall FarPtr_RunDialogueYesNoPrompt ; $597e
	farcall FarPtr_ScriptCloseDialogueWindow ; $5981
	script_wait_frames $05 ; $5984
	and a, a ; $598b
	jr z, Label_12_5994 ; $598c
	script_speak $08 ; $598e
	ret ; $5993
Label_12_5994:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5994
	script_set_anim $08, $02 ; $5997
	script_wait_idle $08 ; $599e
	ld a, $08 ; $59a3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $59a5
	farcall FarPtr_RunDialogueYesNoPrompt ; $59a8
	farcall FarPtr_ScriptCloseDialogueWindow ; $59ab
	script_wait_frames $05 ; $59ae
	and a, a ; $59b5
	jr z, Label_12_59be ; $59b6
	script_speak $08 ; $59b8
	ret ; $59bd
Label_12_59be:
	script_wait_frames $0a ; $59be
	script_set_actor_script $00, $7a5a ; $59c5
	script_move_target $08, $0c00, $1500 ; $59d0
	script_wait_move $08 ; $59db
	script_set_actor_script $08, $7a41 ; $59e0
	script_move_player $0a00, $1100 ; $59eb
	farcall FarPtr_WaitPlayerMoveDone ; $59f5
	ld a, $08 ; $59f8
	farcall FarPtr_WaitActorScriptDone ; $59fa
	ld hl, wStoryModePlayersXPosition ; $59fd
	ld de, wStoryModeSpawnPosition ; $5a00
	ld bc, $0005 ; $5a03
	call CopyMemoryBC ; $5a06
	ld a, $ff ; $5a09
	ld [wStoryModeEntryPoint], a ; $5a0b
	ld [$c294], a ; $5a0e
	ld [wStoryModeExitLocationRequest], a ; $5a11
	farcall FarPtr_InitStoryMatchSettings ; $5a14
	load_match_settings $0005 ; $5a17
	farcall FarPtr_RunStoryMatch ; $5a24
	farcall FarPtr_RestoreOverworldAfterMatch ; $5a27
	ret ; $5a2a
	; $5a2b, 30 bytes (records:2)
	dw $1012 ; record 0
	dw $1012 ; record 1
	dw $1027 ; record 2
	dw $1030 ; record 3
	dw $1030 ; record 4
	dw $1030 ; record 5
	dw $1062 ; record 6
	dw $1063 ; record 7
	dw $1063 ; record 8
	dw $1091 ; record 9
	dw $109a ; record 10
	dw $10a2 ; record 11
	dw $10ab ; record 12
	dw $10b4 ; record 13
	dw $10bd ; record 14
Func_12_5a49:
	ld a, [$c2b1] ; $5a49
	add a, a ; $5a4c
	add a, $6e ; $5a4d
	ld l, a ; $5a4f
	adc a, $5a ; $5a50
	sub a, l ; $5a52
	ld h, a ; $5a53
	ld a, [hl+] ; $5a54
	ld h, [hl] ; $5a55
	ld l, a ; $5a56
	farcall FarPtr_InitDialogueTextCursor ; $5a57
	ld a, [$c2b1] ; $5a5a
	cp a, $02 ; $5a5d
	jr nc, Label_12_5a68 ; $5a5f
	script_face $09, $40 ; $5a61
Label_12_5a68:
	script_speak $09 ; $5a68
	ret ; $5a6d
	; $5a6e, 30 bytes (records:2)
	dw $1013 ; record 0
	dw $1013 ; record 1
	dw $102b ; record 2
	dw $1031 ; record 3
	dw $1031 ; record 4
	dw $1031 ; record 5
	dw $1064 ; record 6
	dw $1065 ; record 7
	dw $1065 ; record 8
	dw $1092 ; record 9
	dw $109b ; record 10
	dw $10a3 ; record 11
	dw $10ac ; record 12
	dw $10b5 ; record 13
	dw $10be ; record 14
Func_12_5a8c:
	ld a, [$c2b1] ; $5a8c
	add a, a ; $5a8f
	add a, $75 ; $5a90
	ld l, a ; $5a92
	adc a, $5b ; $5a93
	sub a, l ; $5a95
	ld h, a ; $5a96
	ld a, [hl+] ; $5a97
	ld h, [hl] ; $5a98
	ld l, a ; $5a99
	farcall FarPtr_InitDialogueTextCursor ; $5a9a
	ld a, [$c2b1] ; $5a9d
	cp a, $06 ; $5aa0
	jr z, Label_12_5aaa ; $5aa2
	script_speak $0a ; $5aa4
	ret ; $5aa9
Label_12_5aaa:
	ld a, $0a ; $5aaa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5aac
	farcall FarPtr_RunDialogueYesNoPrompt ; $5aaf
	farcall FarPtr_ScriptCloseDialogueWindow ; $5ab2
	script_wait_frames $05 ; $5ab5
	and a, a ; $5abc
	jr z, Label_12_5ac5 ; $5abd
	script_speak $0a ; $5abf
	ret ; $5ac4
Label_12_5ac5:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5ac5
	ld a, $0a ; $5ac8
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5aca
	farcall FarPtr_RunDialogueYesNoPrompt ; $5acd
	farcall FarPtr_ScriptCloseDialogueWindow ; $5ad0
	script_wait_frames $05 ; $5ad3
	and a, a ; $5ada
	jr z, Label_12_5ae3 ; $5adb
	script_speak $0a ; $5add
	ret ; $5ae2
Label_12_5ae3:
	ld a, $0a ; $5ae3
	farcall FarPtr_GetActorStateAddr ; $5ae5
	ld e, l ; $5ae8
	ld d, h ; $5ae9
	ld hl, $0005 ; $5aea
	add hl, de ; $5aed
	res 0, [hl] ; $5aee
	res 1, [hl] ; $5af0
	script_set_speed $00, $0020 ; $5af2
	script_set_speed $02, $0020 ; $5afa
	script_set_actor_script $00, $7a07 ; $5b02
	script_wait_frames $20 ; $5b0d
	script_set_actor_script $02, $7a24 ; $5b14
	script_set_actor_script $0a, $79f1 ; $5b1f
	script_set_actor_script $0b, $79fc ; $5b2a
	script_move_player $0a00, $1100 ; $5b35
	farcall FarPtr_WaitPlayerMoveDone ; $5b3f
	ld a, $00 ; $5b42
	farcall FarPtr_WaitActorScriptDone ; $5b44
	ld hl, wStoryModePlayersXPosition ; $5b47
	ld de, wStoryModeSpawnPosition ; $5b4a
	ld bc, $0005 ; $5b4d
	call CopyMemoryBC ; $5b50
	ld a, $ff ; $5b53
	ld [wStoryModeEntryPoint], a ; $5b55
	ld [$c294], a ; $5b58
	ld [wStoryModeExitLocationRequest], a ; $5b5b
	farcall FarPtr_InitStoryMatchSettings ; $5b5e
	load_match_settings $0105 ; $5b61
	farcall FarPtr_RunStoryMatch ; $5b6e
	farcall FarPtr_RestoreOverworldAfterMatch ; $5b71
	ret ; $5b74
	; $5b75, 30 bytes (records:2)
	dw $1014 ; record 0
	dw $1014 ; record 1
	dw $102c ; record 2
	dw $1032 ; record 3
	dw $1032 ; record 4
	dw $1032 ; record 5
	dw $1066 ; record 6
	dw $106c ; record 7
	dw $106c ; record 8
	dw $1093 ; record 9
	dw $109c ; record 10
	dw $10a4 ; record 11
	dw $10ad ; record 12
	dw $10b6 ; record 13
	dw $10bf ; record 14
Func_12_5b93:
	ld a, [$c2b1] ; $5b93
	add a, a ; $5b96
	add a, $bf ; $5b97
	ld l, a ; $5b99
	adc a, $5b ; $5b9a
	sub a, l ; $5b9c
	ld h, a ; $5b9d
	ld a, [hl+] ; $5b9e
	ld h, [hl] ; $5b9f
	ld l, a ; $5ba0
	farcall FarPtr_InitDialogueTextCursor ; $5ba1
	ld a, [$c2b1] ; $5ba4
	cp a, $0c ; $5ba7
	jr c, Label_12_5bb9 ; $5ba9
	test_flag $05, 7 ; $5bab
	jr z, Label_12_5bb9 ; $5bae
	ld a, [$c94d] ; $5bb0
	and a, a ; $5bb3
	jr nz, Label_12_5bb9 ; $5bb4
	farcall FarPtr_AdvanceDialogueTextCursor ; $5bb6
Label_12_5bb9:
	script_speak $0b ; $5bb9
	ret ; $5bbe
	; $5bbf, 30 bytes (records:2)
	dw $1015 ; record 0
	dw $1015 ; record 1
	dw $102d ; record 2
	dw $1033 ; record 3
	dw $1033 ; record 4
	dw $1033 ; record 5
	dw $106b ; record 6
	dw $106d ; record 7
	dw $106d ; record 8
	dw $1094 ; record 9
	dw $109d ; record 10
	dw $10a5 ; record 11
	dw $10ae ; record 12
	dw $10b7 ; record 13
	dw $10ae ; record 14
Func_12_5bdd:
	ld a, [$c94d] ; $5bdd
	or a, a ; $5be0
	jr nz, Label_12_5bfa ; $5be1
	ld a, [$c2b1] ; $5be3
	add a, a ; $5be6
	add a, $2f ; $5be7
	ld l, a ; $5be9
	adc a, $5c ; $5bea
	sub a, l ; $5bec
	ld h, a ; $5bed
	ld a, [hl+] ; $5bee
	ld h, [hl] ; $5bef
	ld l, a ; $5bf0
	farcall FarPtr_InitDialogueTextCursor ; $5bf1
	script_speak $0c ; $5bf4
	ret ; $5bf9
Label_12_5bfa:
	ld a, [$c2b1] ; $5bfa
	add a, a ; $5bfd
	add a, $11 ; $5bfe
	ld l, a ; $5c00
	adc a, $5c ; $5c01
	sub a, l ; $5c03
	ld h, a ; $5c04
	ld a, [hl+] ; $5c05
	ld h, [hl] ; $5c06
	ld l, a ; $5c07
	farcall FarPtr_InitDialogueTextCursor ; $5c08
	script_speak $0c ; $5c0b
	ret ; $5c10
	; $5c11, 60 bytes (records:2)
	dw $1016 ; record 0
	dw $1016 ; record 1
	dw $102e ; record 2
	dw $1034 ; record 3
	dw $1034 ; record 4
	dw $1034 ; record 5
	dw $106c ; record 6
	dw $106e ; record 7
	dw $106e ; record 8
	dw $1095 ; record 9
	dw $109e ; record 10
	dw $10a6 ; record 11
	dw $10af ; record 12
	dw $10b8 ; record 13
	dw $10ba ; record 14
	dw $1017 ; record 15
	dw $1017 ; record 16
	dw $102f ; record 17
	dw $1035 ; record 18
	dw $1035 ; record 19
	dw $1035 ; record 20
	dw $106c ; record 21
	dw $106e ; record 22
	dw $106e ; record 23
	dw $1096 ; record 24
	dw $109e ; record 25
	dw $10a7 ; record 26
	dw $10af ; record 27
	dw $10b9 ; record 28
	dw $10ba ; record 29
SeniorCourtNpcScripts_12:
	; $5c4d, 121 bytes (map_scripts)
	map_script $03, $10, $0840, Func_12_5630, $01, $00
	map_script $03, $40, $0840, Func_12_569b, $01, $00
	map_script $03, $40, $0000, Label_12_55f7, $01, $00
	map_script $03, $ff, $0000, Label_12_55e8, $01, $00
	map_script $04, $ff, $0000, Func_12_5820, $1b, $00
	map_script $05, $ff, $0000, Func_12_5859, $13, $00
	map_script $06, $ff, $08a0, Func_12_58b3, $13, $00
	map_script $06, $ff, $0000, Func_12_58b3, $11, $00
	map_script $07, $ff, $08a0, Func_12_5916, $03, $00
	map_script $07, $ff, $0000, Func_12_5916, $01, $00
	map_script $08, $ff, $0000, Func_12_594b, $0b, $00
	map_script $09, $ff, $0000, Func_12_5a49, $13, $00
	map_script $0a, $ff, $0000, Func_12_5a8c, $13, $00
	map_script $0b, $ff, $0000, Func_12_5b93, $1b, $00
	map_script $0c, $ff, $0000, Func_12_5bdd, $13, $00
	db $ff
SeniorCourtFacingScripts_12:
	ds 1, $ff ; $5cc6, fill
SeniorCourtTileTriggers_12:
	; $5cc7, 9 bytes (map_scripts)
	map_script $01, $ff, $0f80, Func_12_5cd0, $00, $00
	db $ff
Func_12_5cd0:
	set_flag $0f, 4 ; $5cd0
	ld a, $0a ; $5cd3
	farcall FarPtr_SetActorNullScript ; $5cd5
	ld a, $0b ; $5cd8
	farcall FarPtr_SetActorNullScript ; $5cda
	script_set_anim $0a, $01 ; $5cdd
	script_set_anim $0b, $01 ; $5ce4
	script_move_target $0a, $1400, $1300 ; $5ceb
	script_move_target $0b, $1400, $0f00 ; $5cf6
	script_wait_move $0a ; $5d01
	script_wait_move $0b ; $5d06
	script_face_toward $00, $0a ; $5d0b
	script_face_toward $00, $0b ; $5d13
	ret ; $5d1b
SeniorCourtInitScript_12:
	call ComputeSeniorCourtStageB ; $5d1c
	call ComputeSeniorCourtStage ; $5d1f
	ld a, [$c2b1] ; $5d22
	cp a, $02 ; $5d25
	jr nc, Label_12_5d7b ; $5d27
	ld b, $00 ; $5d29
	ld c, $2a ; $5d2b
	ld d, $10 ; $5d2d
	ld e, $0a ; $5d2f
	ld h, $08 ; $5d31
	ld l, $0e ; $5d33
	farcall FarPtr_CopyBehaviorMapRect ; $5d35
	test_flag $0f, 4 ; $5d38
	jr z, Label_12_5d7b ; $5d3b
	ld a, $0a ; $5d3d
	farcall FarPtr_SetActorNullScript ; $5d3f
	ld a, $0b ; $5d42
	farcall FarPtr_SetActorNullScript ; $5d44
	script_set_anim $0a, $01 ; $5d47
	script_set_anim $0b, $01 ; $5d4e
	script_set_position $0a, $1400, $1300 ; $5d55
	script_set_position $0b, $1400, $0f00 ; $5d60
	script_face_toward $00, $0a ; $5d6b
	script_face_toward $00, $0b ; $5d73
Label_12_5d7b:
	test_flag $05, 7 ; $5d7b
	jr nz, Label_12_5daf ; $5d7e
	test_flag $0a, 3 ; $5d80
	jr z, Label_12_5d8d ; $5d83
	ldh a, [hRomBank] ; $5d85
	ld hl, $53b7 ; $5d87
	farcall FarPtr_ScriptRespawnLocationActors ; $5d8a
Label_12_5d8d:
	call Func_12_5e12 ; $5d8d
	call Func_12_5e91 ; $5d90
	ld a, [wStoryModeEntryPoint] ; $5d93
	cp a, $0f ; $5d96
	jp z, SeniorCourtPostMatchReturn ; $5d98
	cp a, $0e ; $5d9b
	jp z, Label_12_6d8a ; $5d9d
	cp a, $0d ; $5da0
	jp z, SeniorMatchVictorySceneDispatch ; $5da2
	call Func_12_5dbe ; $5da5
	farcall FarPtr_EndCutsceneScriptMode ; $5da8
	call Func_12_5eab ; $5dab
	ret ; $5dae
Label_12_5daf:
	test_flag $08, 2 ; $5daf
	jr z, Label_12_5d8d ; $5db2
	ldh a, [hRomBank] ; $5db4
	ld hl, $5493 ; $5db6
	farcall FarPtr_ScriptRespawnLocationActors ; $5db9
	jr Label_12_5d8d ; $5dbc
Func_12_5dbe:
	ld a, [$c2b1] ; $5dbe
	cp a, $0b ; $5dc1
	jr c, Label_12_5ddc ; $5dc3
	cp a, $0d ; $5dc5
	jr nc, Label_12_5ddc ; $5dc7
	ld a, $03 ; $5dc9
	farcall FarPtr_GetActorStateAddr ; $5dcb
	ld c, l ; $5dce
	ld b, h ; $5dcf
	ld d, $3b ; $5dd0
	farcall FarPtr_LoadActorObjectDefIfValid ; $5dd2
	script_set_anim $03, $01 ; $5dd5
Label_12_5ddc:
	test_flag $05, 7 ; $5ddc
	jr nz, Label_12_5df4 ; $5ddf
	ld a, [$c2b1] ; $5de1
	cp a, $09 ; $5de4
	jr c, Label_12_5df3 ; $5de6
	script_set_position $04, $3f00, $3f00 ; $5de8
Label_12_5df3:
	ret ; $5df3
Label_12_5df4:
	ld a, [$c2b1] ; $5df4
	cp a, $0a ; $5df7
	jr c, Label_12_5df3 ; $5df9
	script_set_position $04, $3f00, $3f00 ; $5dfb
	script_set_position $05, $3f00, $3f00 ; $5e06
	ret ; $5e11
Func_12_5e12:
	test_flag $05, 7 ; $5e12
	jr nz, Label_12_5e38 ; $5e15
	ld a, [$c2b1] ; $5e17
	cp a, $03 ; $5e1a
	jr c, Label_12_5e30 ; $5e1c
	script_set_position $07, $1b00, $0d00 ; $5e1e
	script_face $07, $80 ; $5e29
Label_12_5e30:
	ld a, [$c2b1] ; $5e30
	cp a, $09 ; $5e33
	jr c, Label_12_5e37 ; $5e35
Label_12_5e37:
	ret ; $5e37
Label_12_5e38:
	ld a, [$c2b1] ; $5e38
	cp a, $07 ; $5e3b
	jr c, Label_12_5e73 ; $5e3d
	cp a, $09 ; $5e3f
	jr nc, Label_12_5e73 ; $5e41
	script_set_position $09, $1b00, $0b00 ; $5e43
	script_set_position $08, $1b00, $0d00 ; $5e4e
	script_face $09, $80 ; $5e59
	script_face $08, $80 ; $5e60
	ld a, $08 ; $5e67
	farcall FarPtr_SetActorNullScript ; $5e69
	script_set_anim $08, $01 ; $5e6c
Label_12_5e73:
	ld a, [$c2b1] ; $5e73
	cp a, $0a ; $5e76
	jr c, Label_12_5e30 ; $5e78
	script_set_position $04, $3f00, $3f00 ; $5e7a
	script_set_position $05, $3f00, $3f00 ; $5e85
	ret ; $5e90
Func_12_5e91:
	ld a, [$c94d] ; $5e91
	or a, a ; $5e94
	jr nz, Label_12_5eaa ; $5e95
	ld a, $0c ; $5e97
	farcall FarPtr_GetActorStateAddr ; $5e99
	ld c, l ; $5e9c
	ld b, h ; $5e9d
	ld d, $28 ; $5e9e
	farcall FarPtr_LoadActorObjectDefIfValid ; $5ea0
	script_set_anim $0c, $01 ; $5ea3
Label_12_5eaa:
	ret ; $5eaa
Func_12_5eab:
	ld a, [wStoryModeEntryPoint] ; $5eab
	cp a, $01 ; $5eae
	jp nz, Label_12_5ef0 ; $5eb0
	test_flag $05, 7 ; $5eb3
	jr z, Label_12_5ede ; $5eb6
	script_set_speed $02, $00ff ; $5eb8
	script_move_angle $02, $40, $0200 ; $5ec0
	script_wait_move $02 ; $5eca
	script_face $02, $c0 ; $5ecf
	script_set_speed $02, $0010 ; $5ed6
Label_12_5ede:
	script_set_speed $00, $0010 ; $5ede
	script_move_angle $00, $c0, $0200 ; $5ee6
Label_12_5ef0:
	ret ; $5ef0
Func_12_5ef1:
	script_set_speed $00, $0010 ; $5ef1
	test_flag $05, 7 ; $5ef9
	jp z, SeniorSinglesRankOfferScene ; $5efc
	call SeniorDoublesRankOfferScene ; $5eff
	ret ; $5f02
Func_12_5f03:
	script_set_speed $00, $0008 ; $5f03
	script_face $00, $c0 ; $5f0b
	script_facing_lock $00, $01 ; $5f12
	test_flag $05, 7 ; $5f19
	jr z, SeniorSinglesRankOfferScene ; $5f1c
	call SeniorDoublesRankOfferScene ; $5f1e
	ret ; $5f21
SeniorSinglesRankOfferScene:
	script_move_target $00, $2d00, $1b00 ; $5f22
	script_wait_move $00 ; $5f2d
	script_wait_frames $0a ; $5f32
	script_facing_lock $00, $00 ; $5f39
	script_face_toward $03, $00 ; $5f40
	script_face_toward $00, $03 ; $5f48
	script_set_text $103c ; $5f50
	test_flag $0a, 4 ; $5f56
	jr z, Label_12_5f5e ; $5f59
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f5b
Label_12_5f5e:
	ld a, $03 ; $5f5e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f60
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f63
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f66
	script_wait_frames $05 ; $5f69
	and a, a ; $5f70
	jp nz, Label_12_5fb8 ; $5f71
	script_set_text $1040 ; $5f74
	test_flag $0a, 4 ; $5f7a
	jr z, Label_12_5f92 ; $5f7d
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f7f
	test_flag $0a, 5 ; $5f82
	jr z, Label_12_5f92 ; $5f85
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f87
	test_flag $0a, 6 ; $5f8a
	jr z, Label_12_5f92 ; $5f8d
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f8f
Label_12_5f92:
	script_speak $03 ; $5f92
	call RunSeniorRankingMatchIntro ; $5f97
	script_face $00, $c0 ; $5f9a
	script_wait_frames $0f ; $5fa1
	script_set_anim $03, $02 ; $5fa8
	script_wait_idle $03 ; $5faf
	call SeniorSinglesMatchConfirm ; $5fb4
	ret ; $5fb7
Label_12_5fb8:
	script_set_text $103e ; $5fb8
	script_speak $03 ; $5fbe
	farcall FarPtr_EndCutsceneScriptMode ; $5fc3
	ret ; $5fc6
SeniorDoublesRankOfferScene:
	ld a, $02 ; $5fc7
	farcall FarPtr_SetActorNullScript ; $5fc9
	script_wait_frames $0a ; $5fcc
	script_move_target $02, $2d00, $1d00 ; $5fd3
	script_move_target $00, $2d00, $1b00 ; $5fde
	script_wait_frames $0a ; $5fe9
	script_wait_move $00 ; $5ff0
	script_facing_lock $00, $00 ; $5ff5
	script_face_toward $03, $00 ; $5ffc
	script_wait_move $02 ; $6004
	script_face_toward $03, $02 ; $6009
	script_wait_frames $1e ; $6011
	script_face_toward $00, $03 ; $6018
	script_set_text $106e ; $6020
	test_flag $08, 4 ; $6026
	jr z, Label_12_602e ; $6029
	farcall FarPtr_AdvanceDialogueTextCursor ; $602b
Label_12_602e:
	ld a, $03 ; $602e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6030
	farcall FarPtr_RunDialogueYesNoPrompt ; $6033
	farcall FarPtr_ScriptCloseDialogueWindow ; $6036
	script_wait_frames $05 ; $6039
	and a, a ; $6040
	jp nz, Label_12_6087 ; $6041
	script_set_text $1071 ; $6044
	test_flag $08, 4 ; $604a
	jr z, Label_12_605a ; $604d
	farcall FarPtr_AdvanceDialogueTextCursor ; $604f
	test_flag $08, 5 ; $6052
	jr z, Label_12_605a ; $6055
	farcall FarPtr_AdvanceDialogueTextCursor ; $6057
Label_12_605a:
	script_speak $03 ; $605a
	call RunSeniorRankingMatchIntro ; $605f
	script_face $00, $c0 ; $6062
	script_face $02, $c0 ; $6069
	script_wait_frames $0f ; $6070
	script_set_anim $03, $02 ; $6077
	script_wait_idle $03 ; $607e
	call SeniorDoublesMatchConfirm ; $6083
	ret ; $6086
Label_12_6087:
	script_set_text $1070 ; $6087
	script_speak $03 ; $608d
	ld a, $02 ; $6092
	farcall FarPtr_GetActorStateAddr ; $6094
	ld c, l ; $6097
	ld b, h ; $6098
	ld de, $d000 ; $6099
	farcall FarPtr_04_20 ; $609c
	ret ; $609f
StartSeniorRankingMatch:
	script_set_speed $00, $0020 ; $60a0
	script_set_speed $02, $0020 ; $60a8
	ld a, [$c2b1] ; $60b0
	sub a, $02 ; $60b3
	rst Rst00 ; $60b5
	dw Label_12_6232 ; $60b6 jumptable
	dw Label_12_628a ; $60b8 jumptable
	dw Label_12_62e9 ; $60ba jumptable
	dw Label_12_6348 ; $60bc jumptable
	dw Label_12_60c4 ; $60be jumptable
	dw Label_12_6136 ; $60c0 jumptable
	dw Label_12_61b2 ; $60c2 jumptable
Label_12_60c4:
	script_face $03, $80 ; $60c4
	script_wait_frames $0f ; $60cb
	script_set_actor_script $09, $7876 ; $60d2
	script_set_actor_script $08, $7838 ; $60dd
	script_set_actor_script $02, $6d0e ; $60e8
	script_set_actor_script $00, $6cec ; $60f3
	script_move_player $2400, $1700 ; $60fe
	farcall FarPtr_WaitPlayerMoveDone ; $6108
	ld a, $08 ; $610b
	farcall FarPtr_WaitActorScriptDone ; $610d
	script_wait_frames $1e ; $6110
	ld a, $0f ; $6117
	ld [$c294], a ; $6119
	ld [wStoryModeExitLocationRequest], a ; $611c
	farcall FarPtr_InitStoryMatchSettings ; $611f
	load_match_settings $0107 ; $6122
	farcall FarPtr_RunStoryMatch ; $612f
	farcall FarPtr_RestoreOverworldAfterMatch ; $6132
	ret ; $6135
Label_12_6136:
	script_face $03, $00 ; $6136
	script_wait_frames $0f ; $613d
	script_face $00, $00 ; $6144
	script_face $02, $00 ; $614b
	script_face $07, $00 ; $6152
	script_face $06, $00 ; $6159
	call Func_12_63d3 ; $6160
	script_set_actor_script $06, $78d9 ; $6163
	script_set_actor_script $07, $78ea ; $616e
	script_set_actor_script $02, $6d1f ; $6179
	farcall FarPtr_WaitPlayerMoveDone ; $6184
	ld a, $07 ; $6187
	farcall FarPtr_WaitActorScriptDone ; $6189
	script_wait_frames $1e ; $618c
	ld a, $0f ; $6193
	ld [$c294], a ; $6195
	ld [wStoryModeExitLocationRequest], a ; $6198
	farcall FarPtr_InitStoryMatchSettings ; $619b
	load_match_settings $0108 ; $619e
	farcall FarPtr_RunStoryMatch ; $61ab
	farcall FarPtr_RestoreOverworldAfterMatch ; $61ae
	ret ; $61b1
Label_12_61b2:
	script_face $03, $80 ; $61b2
	script_wait_frames $0f ; $61b9
	script_face $00, $80 ; $61c0
	script_face $07, $80 ; $61c7
	script_set_actor_script $05, $796f ; $61ce
	script_set_actor_script $04, $7980 ; $61d9
	script_set_actor_script $02, $6d0e ; $61e4
	script_set_actor_script $00, $6cec ; $61ef
	script_move_player $2400, $1700 ; $61fa
	farcall FarPtr_WaitPlayerMoveDone ; $6204
	ld a, $04 ; $6207
	farcall FarPtr_WaitActorScriptDone ; $6209
	script_wait_frames $1e ; $620c
	ld a, $0f ; $6213
	ld [$c294], a ; $6215
	ld [wStoryModeExitLocationRequest], a ; $6218
	farcall FarPtr_InitStoryMatchSettings ; $621b
	load_match_settings $0109 ; $621e
	farcall FarPtr_RunStoryMatch ; $622b
	farcall FarPtr_RestoreOverworldAfterMatch ; $622e
	ret ; $6231
Label_12_6232:
	script_face $03, $80 ; $6232
	script_wait_frames $0f ; $6239
	script_face $00, $80 ; $6240
	script_face $07, $80 ; $6247
	call Func_12_63a2 ; $624e
	script_set_actor_script $07, $6c18 ; $6251
	farcall FarPtr_WaitPlayerMoveDone ; $625c
	ld a, $07 ; $625f
	farcall FarPtr_WaitActorScriptDone ; $6261
	script_wait_frames $1e ; $6264
	ld a, $0f ; $626b
	ld [$c294], a ; $626d
	ld [wStoryModeExitLocationRequest], a ; $6270
	farcall FarPtr_InitStoryMatchSettings ; $6273
	load_match_settings $0006 ; $6276
	farcall FarPtr_RunStoryMatch ; $6283
	farcall FarPtr_RestoreOverworldAfterMatch ; $6286
	ret ; $6289
Label_12_628a:
	script_face $03, $00 ; $628a
	script_wait_frames $0f ; $6291
	script_face $00, $00 ; $6298
	script_face $06, $00 ; $629f
	script_wait_frames $1e ; $62a6
	call Func_12_63d3 ; $62ad
	script_set_actor_script $06, $6c62 ; $62b0
	farcall FarPtr_WaitPlayerMoveDone ; $62bb
	ld a, $06 ; $62be
	farcall FarPtr_WaitActorScriptDone ; $62c0
	script_wait_frames $1e ; $62c3
	ld a, $0f ; $62ca
	ld [$c294], a ; $62cc
	ld [wStoryModeExitLocationRequest], a ; $62cf
	farcall FarPtr_InitStoryMatchSettings ; $62d2
	load_match_settings $0007 ; $62d5
	farcall FarPtr_RunStoryMatch ; $62e2
	farcall FarPtr_RestoreOverworldAfterMatch ; $62e5
	ret ; $62e8
Label_12_62e9:
	script_face $03, $00 ; $62e9
	script_wait_frames $0f ; $62f0
	script_face $00, $00 ; $62f7
	script_face $05, $00 ; $62fe
	script_wait_frames $1e ; $6305
	call Func_12_63d3 ; $630c
	script_set_actor_script $05, $6c62 ; $630f
	farcall FarPtr_WaitPlayerMoveDone ; $631a
	script_wait_frames $78 ; $631d
	script_wait_move $00 ; $6324
	ld a, $0f ; $6329
	ld [$c294], a ; $632b
	ld [wStoryModeExitLocationRequest], a ; $632e
	farcall FarPtr_InitStoryMatchSettings ; $6331
	load_match_settings $0008 ; $6334
	farcall FarPtr_RunStoryMatch ; $6341
	farcall FarPtr_RestoreOverworldAfterMatch ; $6344
	ret ; $6347
Label_12_6348:
	script_face $03, $80 ; $6348
	script_wait_frames $0f ; $634f
	script_face $00, $80 ; $6356
	script_face $04, $80 ; $635d
	script_wait_frames $1e ; $6364
	call Func_12_63a2 ; $636b
	script_set_actor_script $04, $6c18 ; $636e
	farcall FarPtr_WaitPlayerMoveDone ; $6379
	script_wait_frames $b4 ; $637c
	ld a, $0f ; $6383
	ld [$c294], a ; $6385
	ld [wStoryModeExitLocationRequest], a ; $6388
	farcall FarPtr_InitStoryMatchSettings ; $638b
	load_match_settings $0009 ; $638e
	farcall FarPtr_RunStoryMatch ; $639b
	farcall FarPtr_RestoreOverworldAfterMatch ; $639e
	ret ; $63a1
Func_12_63a2:
	script_set_actor_script $0d, $6d30 ; $63a2
	script_set_actor_script $0e, $6d3f ; $63ad
	ld a, $0e ; $63b8
	farcall FarPtr_WaitActorScriptDone ; $63ba
	script_move_player $2400, $1700 ; $63bd
	script_set_actor_script $00, $6cec ; $63c7
	ret ; $63d2
Func_12_63d3:
	script_set_actor_script $0f, $6d4e ; $63d3
	script_set_actor_script $10, $6d5d ; $63de
	ld a, $0f ; $63e9
	farcall FarPtr_WaitActorScriptDone ; $63eb
	script_move_player $3500, $1700 ; $63ee
	script_set_actor_script $00, $6cfd ; $63f8
	ret ; $6403
PlaceSeniorCourtPairA:
	ld a, $0d ; $6404
	farcall FarPtr_SetActorNullScript ; $6406
	ld a, $0e ; $6409
	farcall FarPtr_SetActorNullScript ; $640b
	script_set_position $0d, $2900, $1300 ; $640e
	script_set_position $0e, $2900, $1900 ; $6419
	script_face $0d, $80 ; $6424
	script_face $0e, $80 ; $642b
	ret ; $6432
PlaceSeniorCourtPairB:
	ld a, $0f ; $6433
	farcall FarPtr_SetActorNullScript ; $6435
	ld a, $10 ; $6438
	farcall FarPtr_SetActorNullScript ; $643a
	script_set_position $0f, $3900, $1300 ; $643d
	script_set_position $10, $3900, $1900 ; $6448
	script_face $0f, $80 ; $6453
	script_face $10, $80 ; $645a
	script_wait_frames $14 ; $6461
	ret ; $6468
StartSeniorCourtPairARally:
	script_move_target $0d, $2200, $1100 ; $6469
	script_move_target $0e, $2500, $1d00 ; $6474
	script_wait_move $0d ; $647f
	script_wait_move $0e ; $6484
	script_set_actor_script $0d, ActorObjDef_12_7abf ; $6489
	script_set_actor_script $0e, ActorObjDef_12_7b22 ; $6494
	ret ; $649f
StartSeniorCourtPairBRally:
	script_move_target $0f, $3200, $1100 ; $64a0
	script_move_target $10, $3600, $1d00 ; $64ab
	script_wait_move $0f ; $64b6
	script_wait_move $10 ; $64bb
	script_face $10, $c0 ; $64c0
	script_set_actor_script $0f, ActorObjDef_12_7b89 ; $64c7
	script_set_actor_script $10, ActorObjDef_12_7bf0 ; $64d2
	ret ; $64dd
RunSeniorRankingMatchIntro:
	ld a, [$c2b1] ; $64de
	sub a, $02 ; $64e1
	add a, a ; $64e3
	add a, $f2 ; $64e4
	ld l, a ; $64e6
	adc a, $64 ; $64e7
	sub a, l ; $64e9
	ld h, a ; $64ea
	ld a, [hl+] ; $64eb
	ld h, [hl] ; $64ec
	ld l, a ; $64ed
	call JumpToHL ; $64ee
	ret ; $64f1
	; $64f2, 14 bytes (records:2)
	dw $67a1 ; record 0
	dw $683b ; record 1
	dw $68f3 ; record 2
	dw $69a9 ; record 3
	dw $6500 ; record 4
	dw $65e9 ; record 5
	dw $66af ; record 6
	script_wait_frames $0f ; $6500
	script_face_toward $09, $03 ; $6507
	script_wait_frames $1e ; $650f
	script_face_toward $09, $00 ; $6516
	script_face_toward $09, $02 ; $651e
	script_wait_frames $1e ; $6526
	script_player_speed $0020 ; $652d
	script_move_player_to_actor $09 ; $6533
	farcall FarPtr_WaitPlayerMoveDone ; $653a
	ld bc, $d040 ; $653d
	ld a, $09 ; $6540
	farcall FarPtr_GetActorStateAddr ; $6542
	ld e, l ; $6545
	ld d, h ; $6546
	farcall FarPtr_04_1e ; $6547
	script_face_toward $03, $09 ; $654a
	ld a, $08 ; $6552
	farcall FarPtr_SetActorNullScript ; $6554
	script_set_anim $08, $01 ; $6557
	script_face_toward $03, $08 ; $655e
	script_set_anim $09, $03 ; $6566
	script_wait_idle $09 ; $656d
	script_set_actor_script $09, $782d ; $6572
	script_set_actor_script $08, $786b ; $657d
	script_face $03, $40 ; $6588
	ld a, $09 ; $658f
	farcall FarPtr_WaitActorScriptDone ; $6591
	ld a, $01 ; $6594
	farcall FarPtr_SetActorNullScript ; $6596
	script_move_player_to_actor $00 ; $6599
	farcall FarPtr_WaitPlayerMoveDone ; $65a0
	script_face_toward $09, $00 ; $65a3
	script_set_text $107e ; $65ab
	script_set_anim $08, $03 ; $65b1
	script_wait_idle $08 ; $65b8
	script_speak $08 ; $65bd
	script_set_anim $09, $03 ; $65c2
	script_wait_idle $09 ; $65c9
	script_speak $09 ; $65ce
	script_face $09, $c0 ; $65d3
	script_face $08, $c0 ; $65da
	script_face $02, $c0 ; $65e1
	ret ; $65e8
	script_wait_frames $0f ; $65e9
	script_face_toward $06, $03 ; $65f0
	script_wait_frames $1e ; $65f8
	script_face_toward $07, $00 ; $65ff
	script_face_toward $06, $02 ; $6607
	script_wait_frames $1e ; $660f
	script_player_speed $0020 ; $6616
	script_move_player_to_actor $07 ; $661c
	farcall FarPtr_WaitPlayerMoveDone ; $6623
	ld bc, $d040 ; $6626
	ld a, $07 ; $6629
	farcall FarPtr_GetActorStateAddr ; $662b
	ld e, l ; $662e
	ld d, h ; $662f
	farcall FarPtr_04_1e ; $6630
	script_face_toward $03, $07 ; $6633
	script_set_anim $07, $03 ; $663b
	script_wait_idle $07 ; $6642
	script_set_actor_script $07, $78ab ; $6647
	script_set_actor_script $06, $78c2 ; $6652
	script_face $03, $40 ; $665d
	ld a, $07 ; $6664
	farcall FarPtr_WaitActorScriptDone ; $6666
	ld a, $01 ; $6669
	farcall FarPtr_SetActorNullScript ; $666b
	script_move_player_to_actor $00 ; $666e
	farcall FarPtr_WaitPlayerMoveDone ; $6675
	script_set_text $107c ; $6678
	script_set_anim $06, $03 ; $667e
	script_wait_idle $06 ; $6685
	script_speak $06 ; $668a
	script_set_anim $07, $03 ; $668f
	script_wait_idle $07 ; $6696
	script_speak $07 ; $669b
	script_face $07, $c0 ; $66a0
	script_face $06, $c0 ; $66a7
	ret ; $66ae
	script_wait_frames $0f ; $66af
	script_face_toward $05, $03 ; $66b6
	script_wait_frames $1e ; $66be
	script_face_toward $04, $00 ; $66c5
	script_face_toward $05, $02 ; $66cd
	ld a, $04 ; $66d5
	farcall FarPtr_SetActorNullScript ; $66d7
	script_set_anim $04, $01 ; $66da
	script_wait_frames $1e ; $66e1
	script_player_speed $0020 ; $66e8
	ld a, $04 ; $66ee
	farcall FarPtr_SetActorNullScript ; $66f0
	script_face $04, $40 ; $66f3
	script_move_target $05, $2b00, $1100 ; $66fa
	script_move_player_to_actor $05 ; $6705
	farcall FarPtr_WaitPlayerMoveDone ; $670c
	script_face $05, $40 ; $670f
	script_face_toward $03, $05 ; $6716
	script_set_anim $05, $03 ; $671e
	script_wait_idle $05 ; $6725
	script_set_actor_script $05, $7953 ; $672a
	script_wait_frames $0f ; $6735
	script_move_player_to_actor $00 ; $673c
	script_set_actor_script $04, $795e ; $6743
	script_face $03, $40 ; $674e
	ld a, $04 ; $6755
	farcall FarPtr_WaitActorScriptDone ; $6757
	script_face_toward $04, $00 ; $675a
	script_face_toward $05, $02 ; $6762
	script_set_text $107a ; $676a
	script_set_anim $04, $03 ; $6770
	script_wait_idle $04 ; $6777
	script_speak $04 ; $677c
	script_set_anim $05, $03 ; $6781
	script_wait_idle $05 ; $6788
	script_speak $05 ; $678d
	script_face $05, $c0 ; $6792
	script_face $04, $c0 ; $6799
	ret ; $67a0
	script_wait_frames $0f ; $67a1
	script_face_toward $07, $03 ; $67a8
	script_wait_frames $1e ; $67b0
	script_face_toward $07, $00 ; $67b7
	script_wait_frames $1e ; $67bf
	script_player_speed $0020 ; $67c6
	script_move_player_to_actor $07 ; $67cc
	farcall FarPtr_WaitPlayerMoveDone ; $67d3
	ld bc, $d040 ; $67d6
	ld a, $07 ; $67d9
	farcall FarPtr_GetActorStateAddr ; $67db
	ld e, l ; $67de
	ld d, h ; $67df
	farcall FarPtr_04_1e ; $67e0
	script_face_toward $03, $07 ; $67e3
	script_set_anim $07, $03 ; $67eb
	script_wait_idle $07 ; $67f2
	script_set_actor_script $07, $6c0d ; $67f7
	script_face $03, $40 ; $6802
	ld a, $07 ; $6809
	farcall FarPtr_WaitActorScriptDone ; $680b
	ld a, $01 ; $680e
	farcall FarPtr_SetActorNullScript ; $6810
	script_face_toward $07, $00 ; $6813
	script_set_anim $07, $02 ; $681b
	script_wait_idle $07 ; $6822
	script_set_anim $07, $03 ; $6827
	script_wait_idle $07 ; $682e
	script_face $07, $c0 ; $6833
	ret ; $683a
	script_wait_frames $0f ; $683b
	script_face_toward $06, $03 ; $6842
	script_wait_frames $1e ; $684a
	script_face_toward $06, $00 ; $6851
	script_wait_frames $1e ; $6859
	script_player_speed $0020 ; $6860
	script_move_player_to_actor $06 ; $6866
	farcall FarPtr_WaitPlayerMoveDone ; $686d
	ld bc, $d040 ; $6870
	ld a, $06 ; $6873
	farcall FarPtr_GetActorStateAddr ; $6875
	ld e, l ; $6878
	ld d, h ; $6879
	farcall FarPtr_04_1e ; $687a
	script_face_toward $03, $06 ; $687d
	script_set_anim $06, $03 ; $6885
	script_wait_idle $06 ; $688c
	script_set_actor_script $06, $6c51 ; $6891
	script_face $03, $40 ; $689c
	script_move_player_to_actor $00 ; $68a3
	ld a, $06 ; $68aa
	farcall FarPtr_WaitActorScriptDone ; $68ac
	ld a, $01 ; $68af
	farcall FarPtr_SetActorNullScript ; $68b1
	script_face_pair $00, $06 ; $68b4
	script_set_anim $06, $02 ; $68bc
	script_wait_idle $06 ; $68c3
	script_set_text $103a ; $68c8
	script_speak $06 ; $68ce
	script_set_anim $06, $03 ; $68d3
	script_wait_idle $06 ; $68da
	script_speak $06 ; $68df
	script_wait_frames $0f ; $68e4
	script_face $06, $c0 ; $68eb
	ret ; $68f2
	script_wait_frames $0f ; $68f3
	script_face_toward $05, $03 ; $68fa
	script_wait_frames $1e ; $6902
	script_face_toward $05, $00 ; $6909
	script_wait_frames $1e ; $6911
	script_player_speed $0020 ; $6918
	script_move_player_to_actor $05 ; $691e
	farcall FarPtr_WaitPlayerMoveDone ; $6925
	ld bc, $d040 ; $6928
	ld a, $05 ; $692b
	farcall FarPtr_GetActorStateAddr ; $692d
	ld e, l ; $6930
	ld d, h ; $6931
	farcall FarPtr_04_1e ; $6932
	script_face_toward $03, $05 ; $6935
	script_set_anim $05, $03 ; $693d
	script_wait_idle $05 ; $6944
	script_set_actor_script $05, $6c95 ; $6949
	script_face $03, $40 ; $6954
	ld a, $01 ; $695b
	farcall FarPtr_SetActorNullScript ; $695d
	script_move_player_to_actor $00 ; $6960
	farcall FarPtr_WaitPlayerMoveDone ; $6967
	script_face_toward $00, $05 ; $696a
	script_set_anim $05, $02 ; $6972
	script_wait_idle $05 ; $6979
	script_set_text $1038 ; $697e
	script_speak $05 ; $6984
	script_set_anim $05, $03 ; $6989
	script_wait_idle $05 ; $6990
	script_speak $05 ; $6995
	script_wait_frames $0f ; $699a
	script_face $05, $c0 ; $69a1
	ret ; $69a8
	script_wait_frames $0f ; $69a9
	script_face_toward $04, $03 ; $69b0
	script_wait_frames $1e ; $69b8
	script_face_toward $04, $00 ; $69bf
	script_wait_frames $1e ; $69c7
	script_player_speed $0020 ; $69ce
	script_move_player_to_actor $04 ; $69d4
	farcall FarPtr_WaitPlayerMoveDone ; $69db
	script_face_toward $03, $04 ; $69de
	script_set_anim $04, $03 ; $69e6
	script_wait_idle $04 ; $69ed
	script_set_actor_script $04, $6cda ; $69f2
	script_face $03, $40 ; $69fd
	script_move_player_to_actor $00 ; $6a04
	farcall FarPtr_WaitPlayerMoveDone ; $6a0b
	script_face_toward $00, $04 ; $6a0e
	script_set_text $1036 ; $6a16
	script_speak $04 ; $6a1c
	script_set_anim $04, $03 ; $6a21
	script_wait_idle $04 ; $6a28
	script_speak $04 ; $6a2d
	script_wait_frames $0f ; $6a32
	script_face $04, $c0 ; $6a39
	ret ; $6a40
ResumeSeniorOpponentScripts:
	ld a, [$c2b1] ; $6a41
	sub a, $02 ; $6a44
	add a, a ; $6a46
	add a, $55 ; $6a47
	ld l, a ; $6a49
	adc a, $6a ; $6a4a
	sub a, l ; $6a4c
	ld h, a ; $6a4d
	ld a, [hl+] ; $6a4e
	ld h, [hl] ; $6a4f
	ld l, a ; $6a50
	call JumpToHL ; $6a51
	ret ; $6a54
	; $6a55, 14 bytes (records:2)
	dw $6ab8 ; record 0
	dw $6ac4 ; record 1
	dw $6ad0 ; record 2
	dw $6adc ; record 3
	dw $6a63 ; record 4
	dw $6a7a ; record 5
	dw $6a91 ; record 6
	script_set_actor_script $09, $7849 ; $6a63
	script_set_actor_script $08, $7887 ; $6a6e
	ret ; $6a79
	script_set_actor_script $07, $78fb ; $6a7a
	script_set_actor_script $06, $7912 ; $6a85
	ret ; $6a90
	script_set_actor_script $05, $7991 ; $6a91
	script_set_actor_script $04, $79a2 ; $6a9c
	ld a, $05 ; $6aa7
	farcall FarPtr_WaitActorScriptDone ; $6aa9
	script_set_actor_script $05, ActorObjDef_12_7c59 ; $6aac
	ret ; $6ab7
	script_set_actor_script $07, $6c29 ; $6ab8
	ret ; $6ac3
	script_set_actor_script $06, $6c73 ; $6ac4
	ret ; $6acf
	script_set_actor_script $05, $6cac ; $6ad0
	ret ; $6adb
	script_set_actor_script $04, $6ce5 ; $6adc
	ret ; $6ae7
SeniorSinglesMatchConfirm:
	script_set_text $1044 ; $6ae8
	test_flag $0a, 4 ; $6aee
	jr z, Label_12_6af6 ; $6af1
	farcall FarPtr_AdvanceDialogueTextCursor ; $6af3
Label_12_6af6:
	ld a, $03 ; $6af6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6af8
	farcall FarPtr_RunDialogueYesNoPrompt ; $6afb
	farcall FarPtr_ScriptCloseDialogueWindow ; $6afe
	script_wait_frames $05 ; $6b01
	and a, a ; $6b08
	jp nz, Label_12_6b57 ; $6b09
	script_set_anim $03, $03 ; $6b0c
	script_wait_idle $03 ; $6b13
Label_12_6b18:
	script_set_anim $03, $03 ; $6b18
	script_wait_idle $03 ; $6b1f
	script_set_text $1046 ; $6b24
	script_speak $03 ; $6b2a
	call StartSeniorRankingMatch ; $6b2f
	farcall FarPtr_EndCutsceneScriptMode ; $6b32
	ret ; $6b35
Label_12_6b36:
	script_set_text $1048 ; $6b36
	test_flag $0a, 4 ; $6b3c
	jr z, Label_12_6b44 ; $6b3f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b41
Label_12_6b44:
	script_speak $03 ; $6b44
	call ResumeSeniorOpponentScripts ; $6b49
	script_wait_frames $1e ; $6b4c
	farcall FarPtr_EndCutsceneScriptMode ; $6b53
	ret ; $6b56
Label_12_6b57:
	script_set_text $1047 ; $6b57
	ld a, $03 ; $6b5d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b5f
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b62
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b65
	script_wait_frames $05 ; $6b68
	and a, a ; $6b6f
	jr z, Label_12_6b36 ; $6b70
	jp Label_12_6b18 ; $6b72
	ret ; $6b75
SeniorDoublesMatchConfirm:
	script_set_text $1074 ; $6b76
	test_flag $08, 5 ; $6b7c
	jr z, Label_12_6b84 ; $6b7f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b81
Label_12_6b84:
	ld a, $03 ; $6b84
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b86
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b89
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b8c
	script_wait_frames $05 ; $6b8f
	and a, a ; $6b96
	jp nz, Label_12_6be4 ; $6b97
	script_set_anim $03, $03 ; $6b9a
	script_wait_idle $03 ; $6ba1
	script_set_anim $03, $03 ; $6ba6
	script_wait_idle $03 ; $6bad
	script_set_text $1076 ; $6bb2
	script_speak $03 ; $6bb8
Label_12_6bbd:
	call StartSeniorRankingMatch ; $6bbd
	farcall FarPtr_EndCutsceneScriptMode ; $6bc0
	ret ; $6bc3
Label_12_6bc4:
	script_speak $03 ; $6bc4
	call ResumeSeniorOpponentScripts ; $6bc9
	script_wait_frames $1e ; $6bcc
	ld a, $02 ; $6bd3
	farcall FarPtr_GetActorStateAddr ; $6bd5
	ld c, l ; $6bd8
	ld b, h ; $6bd9
	ld de, $d000 ; $6bda
	farcall FarPtr_04_20 ; $6bdd
	farcall FarPtr_EndCutsceneScriptMode ; $6be0
	ret ; $6be3
Label_12_6be4:
	script_set_text $1077 ; $6be4
	ld a, $03 ; $6bea
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6bec
	farcall FarPtr_RunDialogueYesNoPrompt ; $6bef
	farcall FarPtr_ScriptCloseDialogueWindow ; $6bf2
	script_wait_frames $05 ; $6bf5
	and a, a ; $6bfc
	jr z, Label_12_6bc4 ; $6bfd
	script_set_text $1079 ; $6bff
	script_speak $03 ; $6c05
	jp Label_12_6bbd ; $6c0a
	INCBIN "data/bank_012/d_6c0d.bin" ; $6c0d, 381 bytes
Label_12_6d8a:
	ld a, $10 ; $6d8a
	ld [wStoryModeCurrentLocation], a ; $6d8c
	ld a, $0d ; $6d8f
	ld [wStoryModeEntryPoint], a ; $6d91
	ld a, $ff ; $6d94
	ld [$c294], a ; $6d96
	ld [wStoryModeExitLocationRequest], a ; $6d99
	farcall FarPtr_StubNop_1e ; $6d9c
	ret ; $6d9f
SeniorCourtPostMatchReturn:
	wram_bank $04 ; $6da0
	ld a, [wMatchExitRequest] ; $6da6
	cp a, $01 ; $6da9
	jr z, Label_12_6db5 ; $6dab
	ld a, [wMatchWinLoseFlag] ; $6dad
	cp a, $01 ; $6db0
	jp z, SeniorMatchVictorySceneDispatch ; $6db2
Label_12_6db5:
	script_player_speed $0040 ; $6db5
	script_move_player $2d00, $1b00 ; $6dbb
	script_set_position $00, $2d00, $1b00 ; $6dc5
	script_face $00, $c0 ; $6dd0
	script_set_position $02, $2d00, $1d00 ; $6dd7
	script_face $02, $c0 ; $6de2
	farcall FarPtr_WaitPlayerMoveDone ; $6de9
	ret ; $6dec
SeniorMatchVictorySceneDispatch:
	xor a, a ; $6ded
	ld [wStoryModeShowLocationName], a ; $6dee
	ld a, $01 ; $6df1
	farcall FarPtr_SetActorNullScript ; $6df3
	ld a, [$c2b1] ; $6df6
	sub a, $02 ; $6df9
	add a, a ; $6dfb
	add a, $0d ; $6dfc
	ld l, a ; $6dfe
	adc a, $6e ; $6dff
	sub a, l ; $6e01
	ld h, a ; $6e02
	ld a, [hl+] ; $6e03
	ld h, [hl] ; $6e04
	ld l, a ; $6e05
	call JumpToHL ; $6e06
	call ComputeSeniorCourtStage ; $6e09
	ret ; $6e0c
	; $6e0d, 18 bytes (records:2)
	dw $73b2 ; record 0
	dw $73b2 ; record 1
	dw $7449 ; record 2
	dw $74b8 ; record 3
	dw $752a ; record 4
	dw $6e1f ; record 5
	dw $6f6a ; record 6
	dw $752a ; record 7
	dw $7071 ; record 8
	ld a, $02 ; $6e1f
	farcall FarPtr_SetActorNullScript ; $6e21
	ld a, $08 ; $6e24
	farcall FarPtr_SetActorNullScript ; $6e26
	script_face $03, $80 ; $6e29
	script_set_position $08, $2500, $1300 ; $6e30
	script_face $08, $40 ; $6e3b
	script_set_position $09, $2300, $0f00 ; $6e42
	script_face $09, $40 ; $6e4d
	script_set_text $1080 ; $6e54
	script_set_position $00, $2500, $1b00 ; $6e5a
	script_set_position $02, $2300, $1b00 ; $6e65
	script_face $00, $c0 ; $6e70
	script_face $02, $c0 ; $6e77
	script_player_speed $0040 ; $6e7e
	script_move_player $2600, $1700 ; $6e84
	farcall FarPtr_WaitPlayerMoveDone ; $6e8e
	script_fade_in $08 ; $6e91
	call WaitFadeEnd ; $6e96
	script_wait_frames $3c ; $6e99
	script_move_target $09, $2300, $1300 ; $6ea0
	script_wait_move $09 ; $6eab
	script_face_pair $09, $08 ; $6eb0
	script_wait_frames $14 ; $6eb8
	script_set_position $11, $2400, $1180 ; $6ebf
	sound $96 ; $6eca
	script_wait_frames $1e ; $6ecc
	script_set_anim $08, $04 ; $6ed3
	script_wait_idle $08 ; $6eda
	script_set_position $11, $3f00, $3f00 ; $6edf
	script_jump_velocity $03, $ff80 ; $6eea
	ld a, $03 ; $6ef2
	farcall FarPtr_ScriptWaitActorJumpDone ; $6ef4
	script_speak $03 ; $6ef7
	script_set_actor_script $08, $7894 ; $6efc
	script_set_actor_script $09, $7854 ; $6f07
	script_wait_frames $3c ; $6f12
	script_move_target $03, $2d00, $1900 ; $6f19
	script_move_player $2d00, $1b00 ; $6f24
	script_move_target $00, $2d00, $1b00 ; $6f2e
	script_move_target $02, $2d00, $1d00 ; $6f39
	script_wait_frames $3c ; $6f44
	script_face $03, $40 ; $6f4b
	script_face $00, $40 ; $6f52
	ld a, $02 ; $6f59
	farcall FarPtr_GetActorStateAddr ; $6f5b
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, $d000 ; $6f60
	farcall FarPtr_04_20 ; $6f63
	farcall FarPtr_EndCutsceneScriptMode ; $6f66
	ret ; $6f69
	ld a, $02 ; $6f6a
	farcall FarPtr_SetActorNullScript ; $6f6c
	script_face $03, $00 ; $6f6f
	script_set_position $07, $3300, $1100 ; $6f76
	script_face $07, $40 ; $6f81
	script_set_position $06, $3500, $1300 ; $6f88
	script_face $06, $40 ; $6f93
	script_set_position $00, $3300, $1b00 ; $6f9a
	script_set_position $02, $3500, $1b00 ; $6fa5
	script_face $00, $c0 ; $6fb0
	script_face $02, $c0 ; $6fb7
	call FadeInSeniorCourtNearPairB ; $6fbe
	script_set_text $1081 ; $6fc1
	script_wait_frames $28 ; $6fc7
	script_set_anim $07, $02 ; $6fce
	script_wait_idle $07 ; $6fd5
	script_wait_frames $14 ; $6fda
	script_jump_velocity $03, $ff80 ; $6fe1
	ld a, $03 ; $6fe9
	farcall FarPtr_ScriptWaitActorJumpDone ; $6feb
	script_jump_velocity $03, $ff80 ; $6fee
	ld a, $03 ; $6ff6
	farcall FarPtr_ScriptWaitActorJumpDone ; $6ff8
	script_speak $03 ; $6ffb
	script_wait_frames $3c ; $7000
	script_move_target $03, $2d00, $1900 ; $7007
	script_move_player $2d00, $1b00 ; $7012
	script_move_target $00, $2d00, $1b00 ; $701c
	script_move_target $02, $2d00, $1d00 ; $7027
	script_set_actor_script $07, $7940 ; $7032
	script_set_actor_script $06, $7929 ; $703d
	call StartSeniorCourtPairBRally ; $7048
	script_face $03, $40 ; $704b
	script_face $00, $40 ; $7052
	script_face $02, $40 ; $7059
	ld a, $02 ; $7060
	farcall FarPtr_GetActorStateAddr ; $7062
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, $d000 ; $7067
	farcall FarPtr_04_20 ; $706a
	farcall FarPtr_EndCutsceneScriptMode ; $706d
	ret ; $7070
	script_set_position $09, $1b00, $0b00 ; $7071
	script_set_position $08, $1b00, $0d00 ; $707c
	script_face $09, $80 ; $7087
	script_face $08, $80 ; $708e
	ld a, $08 ; $7095
	farcall FarPtr_SetActorNullScript ; $7097
	script_set_anim $08, $01 ; $709a
	ld a, $02 ; $70a1
	farcall FarPtr_SetActorNullScript ; $70a3
	script_set_position $03, $2b00, $2700 ; $70a6
	script_set_position $04, $2500, $0f00 ; $70b1
	script_face $04, $40 ; $70bc
	ld a, $04 ; $70c3
	farcall FarPtr_SetActorNullScript ; $70c5
	script_set_anim $04, $01 ; $70c8
	script_set_position $05, $2300, $1300 ; $70cf
	script_face $05, $40 ; $70da
	ld a, $05 ; $70e1
	farcall FarPtr_SetActorNullScript ; $70e3
	script_set_anim $05, $01 ; $70e6
	script_set_position $00, $2500, $1b00 ; $70ed
	script_face $00, $c0 ; $70f8
	script_set_position $02, $2300, $1b00 ; $70ff
	script_face $02, $c0 ; $710a
	script_player_speed $0040 ; $7111
	script_move_player $2400, $1500 ; $7117
	farcall FarPtr_WaitPlayerMoveDone ; $7121
	script_face $03, $80 ; $7124
	farcall FarPtr_WaitPlayerMoveDone ; $712b
	script_fade_in $20 ; $712e
	call WaitFadeEnd ; $7133
	script_set_text $1082 ; $7136
	script_move_target $04, $2500, $1300 ; $713c
	script_wait_move $04 ; $7147
	script_face_pair $05, $04 ; $714c
	script_set_anim $04, $02 ; $7154
	script_speak $04 ; $715b
	script_face $05, $40 ; $7160
	script_set_anim $05, $04 ; $7167
	script_wait_idle $05 ; $716e
	script_speak $05 ; $7173
	script_set_anim $03, $03 ; $7178
	script_speak $03 ; $717f
	script_set_anim $04, $02 ; $7184
	script_set_anim $05, $02 ; $718b
	script_set_anim $02, $02 ; $7192
	script_set_anim $00, $02 ; $7199
	script_face $00, $40 ; $71a0
	script_face $02, $40 ; $71a7
	script_face $04, $40 ; $71ae
	script_player_speed $0010 ; $71b5
	script_set_speed $03, $0010 ; $71bb
	script_move_player $2b00, $2000 ; $71c3
	script_move_target $03, $2b00, $2000 ; $71cd
	script_wait_move $03 ; $71d8
	farcall FarPtr_WaitPlayerMoveDone ; $71dd
	script_move_player $2400, $1b00 ; $71e0
	script_move_target $03, $2500, $1f00 ; $71ea
	script_wait_move $03 ; $71f5
	script_face $03, $c0 ; $71fa
	script_set_anim $03, $02 ; $7201
	script_wait_idle $03 ; $7208
	script_speak $03 ; $720d
	script_face_pair $02, $00 ; $7212
	script_wait_frames $1e ; $721a
	script_face $00, $40 ; $7221
	script_face $02, $40 ; $7228
	script_set_anim $02, $03 ; $722f
	script_set_anim $00, $03 ; $7236
	script_wait_idle $00 ; $723d
	script_set_anim $03, $03 ; $7242
	script_wait_idle $03 ; $7249
	script_set_text $1087 ; $724e
	script_speak $03 ; $7254
	script_move_target $03, $2500, $1d00 ; $7259
	script_wait_move $03 ; $7264
	script_set_anim $03, $02 ; $7269
	script_wait_idle $03 ; $7270
	script_wait_frames $1e ; $7275
	script_set_anim $03, $03 ; $727c
	script_set_anim $00, $03 ; $7283
	script_wait_idle $00 ; $728a
	script_speak $00 ; $728f
	script_set_anim $03, $02 ; $7294
	script_wait_idle $03 ; $729b
	script_speak $03 ; $72a0
	script_set_anim $03, $03 ; $72a5
	script_wait_idle $03 ; $72ac
	script_speak $03 ; $72b1
	script_set_anim $00, $03 ; $72b6
	script_wait_idle $00 ; $72bd
	script_set_anim $03, $03 ; $72c2
	script_wait_idle $03 ; $72c9
	script_set_anim $00, $02 ; $72ce
	script_wait_idle $00 ; $72d5
	script_face $00, $c0 ; $72da
	script_face $02, $c0 ; $72e1
	script_wait_frames $28 ; $72e8
	script_move_player $2400, $1700 ; $72ef
	farcall FarPtr_WaitPlayerMoveDone ; $72f9
	script_set_anim $05, $02 ; $72fc
	script_wait_frames $28 ; $7303
	script_speak $05 ; $730a
	script_move_target $04, $2500, $1500 ; $730f
	script_wait_move $04 ; $731a
	script_speak $04 ; $731f
	script_face_pair $02, $00 ; $7324
	script_wait_frames $0a ; $732c
	script_set_anim $00, $02 ; $7333
	script_set_anim $02, $02 ; $733a
	script_wait_idle $02 ; $7341
	script_face $00, $c0 ; $7346
	script_face $02, $c0 ; $734d
	script_set_anim $02, $03 ; $7354
	script_set_anim $00, $03 ; $735b
	script_wait_idle $00 ; $7362
	script_wait_frames $0a ; $7367
	script_set_anim $04, $03 ; $736e
	script_set_anim $05, $03 ; $7375
	script_wait_idle $05 ; $737c
	ld a, $10 ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [wStoryModeEntryPoint], a ; $7388
	ld a, $ff ; $738b
	ld [$c294], a ; $738d
	ld [wStoryModeExitLocationRequest], a ; $7390
	script_set_anim $03, $03 ; $7393
	script_wait_idle $03 ; $739a
	script_wait_frames $1e ; $739f
	ld c, $08 ; $73a6
	call BeginFadeOut ; $73a8
	call WaitFadeEnd ; $73ab
	farcall FarPtr_EndCutsceneScriptMode ; $73ae
	ret ; $73b1
	script_set_position $07, $2300, $0f00 ; $73b2
	script_face $07, $40 ; $73bd
	call FadeInSeniorCourtNearPairA ; $73c4
	script_set_text $104a ; $73c7
	script_speak $07 ; $73cd
	script_jump_velocity $03, $ff80 ; $73d2
	ld a, $03 ; $73da
	farcall FarPtr_ScriptWaitActorJumpDone ; $73dc
	script_speak $03 ; $73df
	script_set_actor_script $07, $6c3a ; $73e4
	script_wait_frames $3c ; $73ef
	script_move_target $03, $2d00, $1900 ; $73f6
	script_move_player $2d00, $1b00 ; $7401
	script_move_target $00, $2400, $1d00 ; $740b
	script_wait_move $00 ; $7416
	script_move_target $00, $2d00, $1d00 ; $741b
	script_wait_frames $3c ; $7426
	call StartSeniorCourtPairARally ; $742d
	script_face $03, $40 ; $7430
	script_face $00, $40 ; $7437
	script_wait_frames $01 ; $743e
	farcall FarPtr_EndCutsceneScriptMode ; $7445
	ret ; $7448
	set_flag $0a, 5 ; $7449
	script_set_position $06, $3300, $0f00 ; $744c
	script_face $06, $40 ; $7457
	call FadeInSeniorCourtNearPairB ; $745e
	script_set_position $00, $3400, $1b00 ; $7461
	script_set_text $1023 ; $746c
	script_speak $06 ; $7472
	script_jump_velocity $03, $ff80 ; $7477
	ld a, $03 ; $747f
	farcall FarPtr_ScriptWaitActorJumpDone ; $7481
	script_set_text $104c ; $7484
	script_speak $03 ; $748a
	script_set_actor_script $06, $6c84 ; $748f
	script_move_target $00, $2d00, $1b00 ; $749a
	script_wait_move $00 ; $74a5
	script_face $00, $40 ; $74aa
	call StartSeniorCourtPairBRally ; $74b1
	farcall FarPtr_EndCutsceneScriptMode ; $74b4
	ret ; $74b7
	set_flag $0a, 6 ; $74b8
	call PlaceSeniorCourtPairB ; $74bb
	script_set_position $05, $3300, $0f00 ; $74be
	script_face $05, $40 ; $74c9
	call FadeInSeniorCourtNearPairB ; $74d0
	script_set_position $00, $3400, $1b00 ; $74d3
	script_set_text $1020 ; $74de
	script_speak $05 ; $74e4
	script_jump_velocity $03, $ff80 ; $74e9
	ld a, $03 ; $74f1
	farcall FarPtr_ScriptWaitActorJumpDone ; $74f3
	script_set_text $104d ; $74f6
	script_speak $03 ; $74fc
	script_set_actor_script $05, $6cc3 ; $7501
	script_move_target $00, $2d00, $1b00 ; $750c
	script_wait_move $00 ; $7517
	script_face $00, $40 ; $751c
	call StartSeniorCourtPairBRally ; $7523
	farcall FarPtr_EndCutsceneScriptMode ; $7526
	ret ; $7529
	script_player_speed $0040 ; $752a
	script_set_speed $04, $0018 ; $7530
	script_set_position $03, $2b00, $2700 ; $7538
	script_set_position $04, $2200, $0f00 ; $7543
	script_set_position $00, $2400, $1b00 ; $754e
	script_move_player $2400, $1500 ; $7559
	farcall FarPtr_WaitPlayerMoveDone ; $7563
	script_face $00, $c0 ; $7566
	script_face $04, $40 ; $756d
	script_face $03, $c0 ; $7574
	call PlaceSeniorCourtPairA ; $757b
	script_fade_in $08 ; $757e
	call WaitFadeEnd ; $7583
	script_wait_frames $1e ; $7586
	script_set_text $104e ; $758d
	script_move_target $04, $2400, $1300 ; $7593
	script_wait_move $04 ; $759e
	script_set_anim $04, $02 ; $75a3
	script_speak $04 ; $75aa
	script_set_anim $03, $03 ; $75af
	script_speak $03 ; $75b6
	script_set_anim $04, $02 ; $75bb
	script_set_anim $00, $02 ; $75c2
	script_face $00, $40 ; $75c9
	script_player_speed $0010 ; $75d0
	script_set_speed $03, $0010 ; $75d6
	script_move_player $2b00, $2000 ; $75de
	script_move_target $03, $2b00, $1f00 ; $75e8
	script_wait_move $03 ; $75f3
	farcall FarPtr_WaitPlayerMoveDone ; $75f8
	script_move_player $2400, $1e00 ; $75fb
	script_move_target $03, $2400, $1f00 ; $7605
	script_wait_move $03 ; $7610
	script_move_target $03, $2400, $1e00 ; $7615
	script_wait_move $03 ; $7620
	script_set_anim $03, $02 ; $7625
	script_wait_idle $03 ; $762c
	script_speak $03 ; $7631
	script_set_anim $00, $03 ; $7636
	script_wait_idle $00 ; $763d
	script_set_anim $03, $03 ; $7642
	script_wait_idle $03 ; $7649
	script_speak $03 ; $764e
	script_move_target $03, $2400, $1d00 ; $7653
	script_wait_move $03 ; $765e
	script_set_anim $03, $02 ; $7663
	script_wait_idle $03 ; $766a
	script_wait_frames $1e ; $766f
	script_set_anim $03, $03 ; $7676
	script_set_anim $00, $03 ; $767d
	script_wait_idle $00 ; $7684
	script_speak $00 ; $7689
	script_set_anim $03, $02 ; $768e
	script_wait_idle $03 ; $7695
	script_speak $03 ; $769a
	script_set_anim $00, $03 ; $769f
	script_wait_idle $00 ; $76a6
	script_set_anim $03, $03 ; $76ab
	script_wait_idle $03 ; $76b2
	script_set_anim $00, $02 ; $76b7
	script_wait_idle $00 ; $76be
	script_face $00, $c0 ; $76c3
	script_set_position $11, $2580, $1980 ; $76ca
	sound $96 ; $76d5
	script_wait_frames $28 ; $76d7
	script_move_player $2400, $1700 ; $76de
	farcall FarPtr_WaitPlayerMoveDone ; $76e8
	script_set_anim $04, $02 ; $76eb
	script_wait_frames $28 ; $76f2
	script_move_target $04, $2400, $1500 ; $76f9
	script_wait_move $04 ; $7704
	script_set_position $11, $3f00, $3f00 ; $7709
	script_speak $04 ; $7714
	ld a, $10 ; $7719
	ld [wStoryModeCurrentLocation], a ; $771b
	ld a, $01 ; $771e
	ld [wStoryModeEntryPoint], a ; $7720
	ld a, $ff ; $7723
	ld [$c294], a ; $7725
	ld [wStoryModeExitLocationRequest], a ; $7728
	script_set_anim $03, $03 ; $772b
	script_wait_idle $03 ; $7732
	script_set_anim $00, $02 ; $7737
	script_wait_idle $00 ; $773e
	script_wait_frames $1e ; $7743
	ld c, $08 ; $774a
	call BeginFadeOut ; $774c
	call WaitFadeEnd ; $774f
	farcall FarPtr_EndCutsceneScriptMode ; $7752
	ret ; $7755
ComputeSeniorCourtStage:
	test_flag $05, 7 ; $7756
	jp nz, Label_12_7793 ; $7759
	ld a, $00 ; $775c
	test_flag $0a, 3 ; $775e
	jr z, Label_12_778f ; $7761
	ld a, $02 ; $7763
	test_flag $0a, 4 ; $7765
	jr z, Label_12_778f ; $7768
	ld a, $03 ; $776a
	test_flag $0a, 5 ; $776c
	jr z, Label_12_778f ; $776f
	ld a, $04 ; $7771
	test_flag $0a, 6 ; $7773
	jr z, Label_12_778f ; $7776
	ld a, $05 ; $7778
	test_flag $0a, 7 ; $777a
	jr z, Label_12_778f ; $777d
	ld a, $09 ; $777f
	test_flag $15, 6 ; $7781
	jr z, Label_12_778f ; $7784
	ld a, $0b ; $7786
	test_flag $16, 0 ; $7788
	jr z, Label_12_778f ; $778b
	ld a, $0d ; $778d
Label_12_778f:
	ld [$c2b1], a ; $778f
	ret ; $7792
Label_12_7793:
	ld a, $01 ; $7793
	test_flag $08, 2 ; $7795
	jr z, Label_12_778f ; $7798
	ld a, $06 ; $779a
	test_flag $08, 4 ; $779c
	jr z, Label_12_778f ; $779f
	ld a, $07 ; $77a1
	test_flag $08, 5 ; $77a3
	jr z, Label_12_778f ; $77a6
	ld a, $08 ; $77a8
	test_flag $08, 6 ; $77aa
	jr z, Label_12_778f ; $77ad
	ld a, $0a ; $77af
	test_flag $15, 7 ; $77b1
	jr z, Label_12_778f ; $77b4
	ld a, $0c ; $77b6
	test_flag $16, 1 ; $77b8
	jr z, Label_12_778f ; $77bb
	ld a, $0e ; $77bd
	jr Label_12_778f ; $77bf
	ret ; $77c1
FadeInSeniorCourtNearPairA:
	call PlaceSeniorCourtPairA ; $77c2
	script_player_speed $0040 ; $77c5
	script_set_position $00, $2400, $1b00 ; $77cb
	script_move_player $2400, $1500 ; $77d6
	farcall FarPtr_WaitPlayerMoveDone ; $77e0
	script_face $00, $c0 ; $77e3
	script_face $03, $80 ; $77ea
	farcall FarPtr_WaitPlayerMoveDone ; $77f1
	script_fade_in $20 ; $77f4
	call WaitFadeEnd ; $77f9
	ret ; $77fc
FadeInSeniorCourtNearPairB:
	call PlaceSeniorCourtPairB ; $77fd
	script_player_speed $0040 ; $7800
	script_move_player $3500, $1500 ; $7806
	farcall FarPtr_WaitPlayerMoveDone ; $7810
	script_face $00, $c0 ; $7813
	script_face $03, $00 ; $781a
	farcall FarPtr_WaitPlayerMoveDone ; $7821
	script_fade_in $20 ; $7824
	call WaitFadeEnd ; $7829
	ret ; $782c
	INCBIN "data/bank_012/d_782d.bin" ; $782d, 438 bytes
ActorObjDef_12_79e3:
	INCBIN "data/bank_012/d_79e3.bin" ; $79e3, 7 bytes
ActorObjDef_12_79ea:
	INCBIN "data/bank_012/d_79ea.bin" ; $79ea, 126 bytes
PushTextArgFetchedString:
	ldh a, [hWramBank] ; $7a68
	push af ; $7a6a
	wram_bank $07 ; $7a6b
	ld de, $df00 ; $7a71
	wram_bank $05 ; $7a74
	farcall FarPtr_FetchShortTextToBuffer ; $7a7a
	ld hl, $df00 ; $7a7d
	farcall FarPtr_PushTextArgString ; $7a80
	pop af ; $7a83
	wram_bank ; $7a84
	ret ; $7a88
ActorObjDef_12_7a89:
	INCBIN "data/bank_012/d_7a89.bin" ; $7a89, 10 bytes
ActorObjDef_12_7a93:
	INCBIN "data/bank_012/d_7a93.bin" ; $7a93, 30 bytes
Func_12_7ab1:
	ret ; $7ab1
	INCBIN "data/bank_012/d_7ab2.bin" ; $7ab2, 13 bytes
ActorObjDef_12_7abf:
	INCBIN "data/bank_012/d_7abf.bin" ; $7abf, 99 bytes
ActorObjDef_12_7b22:
	INCBIN "data/bank_012/d_7b22.bin" ; $7b22, 103 bytes
ActorObjDef_12_7b89:
	INCBIN "data/bank_012/d_7b89.bin" ; $7b89, 103 bytes
ActorObjDef_12_7bf0:
	INCBIN "data/bank_012/d_7bf0.bin" ; $7bf0, 105 bytes
ActorObjDef_12_7c59:
	INCBIN "data/bank_012/d_7c59.bin" ; $7c59, 13 bytes
ActorObjDef_12_7c66:
	INCBIN "data/bank_012/d_7c66.bin" ; $7c66, 15 bytes
ComputeSeniorCourtStageB:
	test_flag $05, 7 ; $7c75
	jr nz, Label_12_7c9c ; $7c78
	ld a, $00 ; $7c7a
	test_flag $0a, 3 ; $7c7c
	jr z, Label_12_7c98 ; $7c7f
	ld a, $02 ; $7c81
	test_flag $0a, 7 ; $7c83
	jr z, Label_12_7c98 ; $7c86
	ld a, $04 ; $7c88
	test_flag $15, 6 ; $7c8a
	jr z, Label_12_7c98 ; $7c8d
	ld a, $06 ; $7c8f
	test_flag $16, 0 ; $7c91
	jr z, Label_12_7c98 ; $7c94
	ld a, $08 ; $7c96
Label_12_7c98:
	ld [$c2b0], a ; $7c98
	ret ; $7c9b
Label_12_7c9c:
	ld a, $01 ; $7c9c
	test_flag $08, 2 ; $7c9e
	jr z, Label_12_7c98 ; $7ca1
	ld a, $03 ; $7ca3
	test_flag $08, 6 ; $7ca5
	jr z, Label_12_7c98 ; $7ca8
	ld a, $05 ; $7caa
	test_flag $15, 7 ; $7cac
	jr z, Label_12_7c98 ; $7caf
	ld a, $07 ; $7cb1
	test_flag $16, 1 ; $7cb3
	jr z, Label_12_7c98 ; $7cb6
	ld a, $09 ; $7cb8
	jr Label_12_7c98 ; $7cba
	ld a, $00 ; $7cbc
	test_flag $0a, 3 ; $7cbe
	jr z, Label_12_7cdb ; $7cc1
	inc a ; $7cc3
	test_flag $0a, 7 ; $7cc4
	jr z, Label_12_7cdb ; $7cc7
	inc a ; $7cc9
	test_flag $05, 7 ; $7cca
	jr nz, Label_12_7cdf ; $7ccd
	test_flag $15, 6 ; $7ccf
	jr z, Label_12_7cdb ; $7cd2
	inc a ; $7cd4
	test_flag $16, 0 ; $7cd5
	jr z, Label_12_7cdb ; $7cd8
	inc a ; $7cda
Label_12_7cdb:
	ld [$c2b0], a ; $7cdb
	ret ; $7cde
Label_12_7cdf:
	test_flag $15, 7 ; $7cdf
	jr z, Label_12_7cdb ; $7ce2
	inc a ; $7ce4
	test_flag $16, 1 ; $7ce5
	jr z, Label_12_7cdb ; $7ce8
	inc a ; $7cea
	jr Label_12_7cdb ; $7ceb
	ds 787, $ff ; $7ced, fill
