SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

	farptr RunMinigameModePauseMenu ; $4000
	farptr QueueWindowTileWrite ; $4002
	farptr ResetCharDataScreenAnim ; $4004
	farptr CheckDebugExpEditorHotkey ; $4006
	farptr RunDebugCharViewer ; $4008
	farptr ShowExpGainScreen ; $400a
	farptr RunCharDataConfirmScreen ; $400c
	farptr CharDataScreen_BuildStats ; $400e
	farptr CharDataScreen_LoadGfx ; $4010
	farptr DrawStatChangeArrows ; $4012
RunMinigameModePauseMenu:
	ldh a, [hWramBank] ; $4014
	push af ; $4016
	call ForceInstantMessageSpeed ; $4017
	call BuildMinigameModePauseMenu ; $401a
	call RunPauseMenuWindow ; $401d
	call RestoreMessageSpeed ; $4020
	pop af ; $4023
	wram_bank ; $4024
	ld a, [$cb2b] ; $4028
	ret ; $402b
RunPauseMenuWindow:
	xor a, a ; $402c
	ld [$cb2b], a ; $402d
	wram_bank $05 ; $4030
	farcall CreateMenuWindowFromText ; $4036
	set_flag FLAG_VRAM_UPDATE_BUSY ; $4039
	ld [wPauseMenuWindowId], a ; $403c
	farcall RestoreShadowTilemap ; $403f
	farcall RenderMenuWindowText ; $4042
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $4045
.menuLoop:
	call DrawPauseMenuSettingValues ; $4048
	ld a, [wPauseMenuWindowId] ; $404b
	farcall RunMenuSelectionShared ; $404e
	push af ; $4051
	push bc ; $4052
	cp a, $ff ; $4053
	jr z, .checkEnabled ; $4055
	ld a, [wMenuKeepOpenRowMask] ; $4057
	bit 7, a ; $405a
	jr z, .checkEnabled ; $405c
	and a, $7f ; $405e
	ld b, a ; $4060
	ld a, [w5_d830] ; $4061
	inc a ; $4064
.rotateLoop:
	rrc b ; $4065
	dec a ; $4067
	jr nz, .rotateLoop ; $4068
	rlc b ; $406a
	bit 0, b ; $406c
	jr nz, .apply ; $406e
.checkEnabled:
	ld a, [wPauseMenuWindowId] ; $4070
	set_flag FLAG_VRAM_UPDATE_BUSY ; $4073
	farcall CloseWindow ; $4076
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $4079
.apply:
	pop bc ; $407c
	pop af ; $407d
	cp a, $ff ; $407e
	jr z, .done ; $4080
	add a, a ; $4082
	add a, c ; $4083
	ld c, a ; $4084
	jr nc, .redraw ; $4085
	inc b ; $4087
.redraw:
	ld h, b ; $4088
	ld l, c ; $4089
	ld a, [hl+] ; $408a
	ld h, [hl] ; $408b
	ld l, a ; $408c
	jp hl ; $408d
.done:
	call ResetPauseMenuState ; $408e
	ret ; $4091
ResetPauseMenuState:
	xor a, a ; $4092
	ld [wMenuInitialRow], a ; $4093
	ld [wMenuAdjustRowMask], a ; $4096
	ld [$cb2a], a ; $4099
	ld [wMenuKeepOpenRowMask], a ; $409c
	ret ; $409f
DrawPauseMenuSettingValues:
	push af ; $40a0
	push bc ; $40a1
	push de ; $40a2
	push hl ; $40a3
	ld a, [$cb2a] ; $40a4
	bit 5, a ; $40a7
	jr nz, .checkMessageSpeed ; $40a9
	pop hl ; $40ab
	pop de ; $40ac
	pop bc ; $40ad
	pop af ; $40ae
	ret ; $40af
.checkMessageSpeed:
	ld a, [wMessageSpeed] ; $40b0
	and a, $7f ; $40b3
	jr z, .maskClear ; $40b5
	dec a ; $40b7
	jr z, .countDone ; $40b8
	ld l, $75 ; $40ba
	ld de, $0a05 ; $40bc
	call QueueWindowTileWrite ; $40bf
	ld l, $7f ; $40c2
	ld de, $0b05 ; $40c4
	call QueueWindowTileWrite ; $40c7
	ld l, $72 ; $40ca
	ld de, $0c05 ; $40cc
	call QueueWindowTileWrite ; $40cf
	jr .checkMusic ; $40d2
.countDone:
	ld l, $8c ; $40d4
	ld de, $0a05 ; $40d6
	call QueueWindowTileWrite ; $40d9
	ld l, $82 ; $40dc
	ld de, $0b05 ; $40de
	call QueueWindowTileWrite ; $40e1
	ld l, $73 ; $40e4
	ld de, $0c05 ; $40e6
	call QueueWindowTileWrite ; $40e9
	jr .checkMusic ; $40ec
.maskClear:
	ld l, $8a ; $40ee
	ld de, $0a05 ; $40f0
	call QueueWindowTileWrite ; $40f3
	ld l, $94 ; $40f6
	ld de, $0b05 ; $40f8
	call QueueWindowTileWrite ; $40fb
	ld l, $72 ; $40fe
	ld de, $0c05 ; $4100
	call QueueWindowTileWrite ; $4103
	jr .checkMusic ; $4106
.checkMusic:
	ldh a, [hMusic] ; $4108
	push af ; $410a
	push bc ; $410b
	push de ; $410c
	push hl ; $410d
	ld de, $0404 ; $410e
	call PrintHexByte ; $4111
	ld a, [$c8a3] ; $4114
	ld de, $0405 ; $4117
	call PrintHexByte ; $411a
	pop hl ; $411d
	pop de ; $411e
	pop bc ; $411f
	pop af ; $4120
	and a, $01 ; $4121
	jr nz, .maskSet ; $4123
	ld l, $dd ; $4125
	ld de, $0b07 ; $4127
	call QueueWindowTileWrite ; $412a
	jr .restore ; $412d
.maskSet:
	ld l, $cc ; $412f
	ld de, $0b07 ; $4131
	call QueueWindowTileWrite ; $4134
.restore:
	pop hl ; $4137
	pop de ; $4138
	pop bc ; $4139
	pop af ; $413a
	ret ; $413b
QueueWindowTileWrite:
	ld h, $80 ; $413c
	call GetTilemapBufferCellDest ; $413e
	call QueueBGTileWrite ; $4141
	ret ; $4144
GetTilemapBufferCellDest:
	push af ; $4145
	push bc ; $4146
	push hl ; $4147
	push de ; $4148
	ld a, [wPauseMenuWindowId] ; $4149
	farcall GetWindowStructPtr ; $414c
	ld d, [hl] ; $414f
	inc hl ; $4150
	ld e, [hl] ; $4151
	pop hl ; $4152
	ld a, h ; $4153
	add a, d ; $4154
	ld d, a ; $4155
	ld a, l ; $4156
	add a, e ; $4157
	ld e, a ; $4158
	farcall GetTilemapCellAddress ; $4159
	ld h, d ; $415c
	ld l, e ; $415d
	ld de, $3000 ; $415e
	add hl, de ; $4161
	ld de, $9800 ; $4162
	add hl, de ; $4165
	ld d, h ; $4166
	ld e, l ; $4167
	pop hl ; $4168
	pop bc ; $4169
	pop af ; $416a
	ret ; $416b
MessageSpeedSettingPtrs:
	; $416c, 10 bytes (records:2)
	dw Label_1a_4176 ; record 0
	dw ShowGameProgressScreenThunk ; record 1
	dw AdjustMessageSpeedSettingThunk ; record 2
	dw ToggleMusicSettingThunk ; record 3
	dw Label_1a_41d6 ; record 4
Label_1a_4176:
	ld a, $01 ; $4176
	farcall ShowCharDataScreen ; $4178
	ld hl, wStoryModePlayersXPosition ; $417b
	ld de, wStoryModeSpawnPosition ; $417e
	ld bc, $0005 ; $4181
	call CopyMemoryBC ; $4184
	ld a, $ff ; $4187
	ld [wStoryModeEntryPoint], a ; $4189
	ld [wUnusedExitLocationMirror], a ; $418c
	ld [wStoryModeExitLocationRequest], a ; $418f
	jp RunPauseMenuWindow.done ; $4192
ShowGameProgressScreenThunk:
	farcall ShowGameProgressScreen ; $4195
	ld hl, wStoryModePlayersXPosition ; $4198
	ld de, wStoryModeSpawnPosition ; $419b
	ld bc, $0005 ; $419e
	call CopyMemoryBC ; $41a1
	ld a, $ff ; $41a4
	ld [wStoryModeEntryPoint], a ; $41a6
	ld [wUnusedExitLocationMirror], a ; $41a9
	ld [wStoryModeExitLocationRequest], a ; $41ac
	jp RunPauseMenuWindow.done ; $41af
AdjustMessageSpeedSettingThunk:
	call AdjustMessageSpeedSetting ; $41b2
	ld a, [$d830] ; $41b5
	ld [wMenuInitialRow], a ; $41b8
	ld bc, MessageSpeedSettingPtrs ; $41bb
	ld a, [wPauseMenuWindowId] ; $41be
	jp RunPauseMenuWindow.menuLoop ; $41c1
ToggleMusicSettingThunk:
	call ToggleMusicSetting ; $41c4
	ld a, [$d830] ; $41c7
	ld [wMenuInitialRow], a ; $41ca
	ld bc, MessageSpeedSettingPtrs ; $41cd
	ld a, [wPauseMenuWindowId] ; $41d0
	jp RunPauseMenuWindow.menuLoop ; $41d3
Label_1a_41d6:
	xor a, a ; $41d6
	ld [$cb2c], a ; $41d7
	jp RestoreMessageSpeed.scriptShowSpeakerDialogueRestoreBG ; $41da
MusicSettingPtrs:
	; $41dd, 4 bytes (records:2)
	dw Label_1a_41e1 ; record 0
	dw Label_1a_420f ; record 1
Label_1a_41e1:
	ld a, [$cb2a] ; $41e1
	and a, $0f ; $41e4
	jr z, .storeMenuInitialRow ; $41e6
	cp a, $03 ; $41e8
	jr z, .storeMenuInitialRow ; $41ea
	sound $9b ; $41ec
	bit 0, a ; $41ee
	jr z, .bit0Clear ; $41f0
	res 0, a ; $41f2
	jr .storeMenuInitialRow ; $41f4
.bit0Clear:
	set 0, a ; $41f6
.storeMenuInitialRow:
	ld a, [$cb2a] ; $41f8
	or a, $c0 ; $41fb
	ld [$cb2a], a ; $41fd
	ld a, [$d830] ; $4200
	ld [wMenuInitialRow], a ; $4203
	ld bc, MusicSettingPtrs ; $4206
	ld a, [wPauseMenuWindowId] ; $4209
	jp RunPauseMenuWindow.menuLoop ; $420c
Label_1a_420f:
	ld a, [$cb2a] ; $420f
	and a, $0f ; $4212
	and a, a ; $4214
	jr z, .storeMenuInitialRow2 ; $4215
	cp a, $03 ; $4217
	jr z, .storeMenuInitialRow2 ; $4219
	sound $9b ; $421b
	bit 1, a ; $421d
	jr z, .bit1Clear ; $421f
	res 1, a ; $4221
	jr .storeMenuInitialRow2 ; $4223
.bit1Clear:
	set 1, a ; $4225
.storeMenuInitialRow2:
	ld a, [$cb2a] ; $4227
	or a, $c0 ; $422a
	ld [$cb2a], a ; $422c
	ld a, [$d830] ; $422f
	ld [wMenuInitialRow], a ; $4232
	ld bc, MusicSettingPtrs ; $4235
	ld a, [wPauseMenuWindowId] ; $4238
	jp RunPauseMenuWindow.menuLoop ; $423b
	call ResetPauseMenuState ; $423e
	ld a, $c0 ; $4241
	ld [$cb2a], a ; $4243
	ld hl, wMenuAdjustRowMask ; $4246
	ld [hl], $83 ; $4249
	ld hl, wMenuKeepOpenRowMask ; $424b
	ld [hl], $83 ; $424e
	ld hl, $049b ; $4250
	ld bc, MusicSettingPtrs ; $4253
	ld de, $0305 ; $4256
	set_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4259
	call RunPauseMenuWindow ; $425c
	call ResetPauseMenuState ; $425f
	ld hl, $cb2a ; $4262
	set 7, [hl] ; $4265
	clear_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4267
	ret ; $426a
AdjustMessageSpeedSetting:
	ld a, [$cb2a] ; $426b
	and a, $0f ; $426e
	cp a, $02 ; $4270
	jr z, .playSfx2 ; $4272
	cp a, $01 ; $4274
	jr z, .playSfx ; $4276
	jr .done ; $4278
.playSfx:
	sound $5e ; $427a
	ld hl, wMessageSpeed ; $427c
	ld a, [hl] ; $427f
	and a, $7f ; $4280
	inc a ; $4282
	ld b, a ; $4283
	sub a, $03 ; $4284
	jr z, .zero ; $4286
	ld a, b ; $4288
	or a, $80 ; $4289
	ld [hl], a ; $428b
	jr .done ; $428c
.zero:
	ld a, $80 ; $428e
	ld [hl], a ; $4290
	jr .done ; $4291
.playSfx2:
	sound $5e ; $4293
	ld hl, wMessageSpeed ; $4295
	ld a, [hl] ; $4298
	and a, $7f ; $4299
	dec a ; $429b
	bit 7, a ; $429c
	jr nz, .negative ; $429e
	or a, $80 ; $42a0
	ld [hl], a ; $42a2
	jr .done ; $42a3
.negative:
	ld a, $82 ; $42a5
	ld [hl], a ; $42a7
.done:
	ret ; $42a8
ToggleMusicSetting:
	sound $5e ; $42a9
	ld a, [$c8a3] ; $42ab
	ld b, a ; $42ae
	and a, $01 ; $42af
	xor a, $01 ; $42b1
	ld c, a ; $42b3
	ld a, b ; $42b4
	and a, $fe ; $42b5
	or a, c ; $42b7
	ld [$c8a3], a ; $42b8
	ret ; $42bb
ForceInstantMessageSpeed:
	ld a, [wMessageSpeed] ; $42bc
	set 7, a ; $42bf
	ld [wMessageSpeed], a ; $42c1
	ret ; $42c4
RestoreMessageSpeed:
	ld a, [wMessageSpeed] ; $42c5
	res 7, a ; $42c8
	ld [wMessageSpeed], a ; $42ca
	ret ; $42cd
.scriptShowSpeakerDialogueRestoreBG:
	clear_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $42ce
	script_set_text Text_31_156 ; $42d1
	ld a, $80 ; $42d7
	farcall ScriptShowSpeakerDialogueRestoreBG ; $42d9
	farcall RunDialogueYesNoPrompt ; $42dc
	farcall ScriptCloseDialogueWindow ; $42df
	script_wait_frames $05 ; $42e2
	and a, a ; $42e9
	jr nz, .compare ; $42ea
	ld a, $01 ; $42ec
	ld [$c8a5], a ; $42ee
	ld a, [wMessageSpeed] ; $42f1
	res 7, a ; $42f4
	ld [wMessageSpeed], a ; $42f6
	ld bc, rIE ; $42f9
	farcall SaveStoryReturnPoint ; $42fc
	farcall SaveStorySlotWithTimer ; $42ff
	ld a, $00 ; $4302
	ld [wStoryModeCurrentLocation], a ; $4304
	ld a, $01 ; $4307
	ld [wStoryModeEntryPoint], a ; $4309
	ld a, $ff ; $430c
	ld [wUnusedExitLocationMirror], a ; $430e
	ld [wStoryModeExitLocationRequest], a ; $4311
	jp RunPauseMenuWindow.done ; $4314
.compare:
	cp a, $ff ; $4317
	jr nz, .setText ; $4319
	call BuildMinigameModePauseMenu ; $431b
	ld a, $03 ; $431e
	ld [wMenuInitialRow], a ; $4320
	ld a, [$cb2c] ; $4323
	and a, a ; $4326
	jr nz, .runPauseMenuWindow ; $4327
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4329
	jr .runPauseMenuWindow ; $432c
.runPauseMenuWindow:
	jp RunPauseMenuWindow ; $432e
.setText:
	script_set_text Text_31_157 ; $4331
	ld a, $80 ; $4337
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4339
	ld a, $01 ; $433c
	ld [wMenuInitialRow], a ; $433e
	farcall RunDialogueYesNoPrompt ; $4341
	farcall ScriptCloseDialogueWindow ; $4344
	script_wait_frames $05 ; $4347
	and a, a ; $434e
	jr nz, .buildMinigameModePauseMenu ; $434f
	ld a, $00 ; $4351
	ld [wStoryModeCurrentLocation], a ; $4353
	ld a, $ff ; $4356
	ld [wStoryModeEntryPoint], a ; $4358
	ld a, $ff ; $435b
	ld [wUnusedExitLocationMirror], a ; $435d
	ld [wStoryModeExitLocationRequest], a ; $4360
	jp RunPauseMenuWindow.done ; $4363
.buildMinigameModePauseMenu:
	call BuildMinigameModePauseMenu ; $4366
	ld a, $03 ; $4369
	ld [wMenuInitialRow], a ; $436b
	ld a, [$cb2c] ; $436e
	and a, a ; $4371
	jr nz, .runPauseMenuWindow2 ; $4372
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4374
	jr .runPauseMenuWindow2 ; $4377
.runPauseMenuWindow2:
	jp RunPauseMenuWindow ; $4379
BuildMinigameModePauseMenu:
	call ResetPauseMenuState ; $437c
	ld a, $a0 ; $437f
	ld [$cb2a], a ; $4381
	ld a, $8c ; $4384
	ld [wMenuAdjustRowMask], a ; $4386
	ld [wMenuKeepOpenRowMask], a ; $4389
	ld hl, $049a ; $438c
	ld bc, MessageSpeedSettingPtrs ; $438f
	ld de, $0304 ; $4392
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4395
	ret ; $4398
CheckDebugExpEditorHotkey:
	push af ; $4399
	ldh a, [hDebugStepMode] ; $439a
	or a, a ; $439c
	jr z, .restore ; $439d
	ldh a, [hPlayerInputFlags] ; $439f
	bit PADB_SELECT, a ; $43a1
	jr z, .restore ; $43a3
	call RunDebugExpEditor ; $43a5
.restore:
	pop af ; $43a8
	ret ; $43a9
RunDebugExpEditor:
	push af ; $43aa
	push bc ; $43ab
	push de ; $43ac
	push hl ; $43ad
	ldh a, [hWramBank] ; $43ae
	push af ; $43b0
	wram_bank $05 ; $43b1
	ld de, $0000 ; $43b7
	ld bc, $1404 ; $43ba
	farcall CreateWindow ; $43bd
	ld [wPauseMenuWindowId], a ; $43c0
	farcall RestoreShadowTilemap ; $43c3
	farcall StubNop_05_4626 ; $43c6
	ld c, $00 ; $43c9
.loop:
	ld hl, $c92c ; $43cb
	ld a, [hl+] ; $43ce
	ld h, [hl] ; $43cf
	ld l, a ; $43d0
	ld a, $04 ; $43d1
	ld de, $d000 ; $43d3
	call FormatDecimalNumber ; $43d6
	ld hl, $d000 ; $43d9
	ld de, $0801 ; $43dc
	ld a, [wPauseMenuWindowId] ; $43df
	farcall WriteStringToWindow ; $43e2
	ld hl, $c96c ; $43e5
	ld a, [hl+] ; $43e8
	ld h, [hl] ; $43e9
	ld l, a ; $43ea
	ld a, $04 ; $43eb
	ld de, $d000 ; $43ed
	call FormatDecimalNumber ; $43f0
	ld hl, $d000 ; $43f3
	ld de, $0802 ; $43f6
	ld a, [wPauseMenuWindowId] ; $43f9
	farcall WriteStringToWindow ; $43fc
	farcall RestoreShadowTilemap ; $43ff
	farcall StubNop_05_4626 ; $4402
	call AdvanceFrame ; $4405
	ldh a, [hPlayerInputFlags] ; $4408
	and a, PADF_A ; $440a
	jr z, .checkPlayerInputFlags ; $440c
	sound $5f ; $440e
	ld de, $0064 ; $4410
	call DebugAddExp ; $4413
	jr .loop ; $4416
.checkPlayerInputFlags:
	ldh a, [hPlayerInputFlags] ; $4418
	and a, PADF_RIGHT ; $441a
	jr z, .checkPlayerInputFlags2 ; $441c
	sound $5e ; $441e
	ld de, $000a ; $4420
	call DebugAddExp ; $4423
	jr .loop ; $4426
.checkPlayerInputFlags2:
	ldh a, [hPlayerInputFlags] ; $4428
	and a, PADF_LEFT ; $442a
	jr z, .checkPlayerInputFlags3 ; $442c
	sound $5e ; $442e
	ld de, $0001 ; $4430
	call DebugAddExp ; $4433
	jr .loop ; $4436
.checkPlayerInputFlags3:
	ldh a, [hPlayerInputFlags] ; $4438
	and a, PADF_UP | PADF_DOWN ; $443a
	jr z, .checkPlayerInputFlags4 ; $443c
	sound $62 ; $443e
	ld a, c ; $4440
	xor a, $01 ; $4441
	ld c, a ; $4443
	jr .loop ; $4444
.checkPlayerInputFlags4:
	ldh a, [hPlayerInputFlags] ; $4446
	and a, PADF_B ; $4448
	jp z, .loop ; $444a
	ld a, [wPauseMenuWindowId] ; $444d
	farcall CloseWindow ; $4450
	ld hl, $c92c ; $4453
	ld a, [hl+] ; $4456
	ld d, [hl] ; $4457
	ld e, a ; $4458
	ld l, $00 ; $4459
	call ResetCharDataScreenAnim ; $445b
	ld hl, $c96c ; $445e
	ld a, [hl+] ; $4461
	ld d, [hl] ; $4462
	ld e, a ; $4463
	ld l, $01 ; $4464
	call ResetCharDataScreenAnim ; $4466
	pop af ; $4469
	wram_bank ; $446a
	pop hl ; $446e
	pop de ; $446f
	pop bc ; $4470
	pop af ; $4471
	ret ; $4472
DebugAddExp:
	ld a, c ; $4473
	or a, a ; $4474
	jr nz, .nonZero ; $4475
	push bc ; $4477
	farcall AddPlayerExp ; $4478
	pop bc ; $447b
	ret ; $447c
.nonZero:
	push bc ; $447d
	farcall AddPlayerExp ; $447e
	pop bc ; $4481
	ret ; $4482
ExtendModifierByteTable0:
	; $4483, 24 bytes (bytes:16)
	db $01, $01, $01, $7e, $de, $9d, $76, $72, $89, $82, $82, $de, $77, $66, $20, $20 ; 0x00
	db $20, $20, $20, $20, $20, $20, $20, $00 ; 0x10
ExtendModifierByteGfx1:
	INCBIN "data/bank_01a/d_449b.bin" ; $449b, 13 bytes
ExtendModifierByteTable2:
	; $44a8, 25 bytes (bytes:16)
	db $01, $01, $01, $81, $6d, $73, $80, $de, $9d, $c3, $de, $b0, $c0, $76, $de, $20 ; 0x00
	db $77, $74, $83, $7c, $8f, $72, $8f, $7d, $00 ; 0x10
ExtendModifierByteGfx3:
	INCBIN "data/bank_01a/d_44c1.bin" ; $44c1, 23 bytes
ShowExpGainScreen:
	push bc ; $44d8
	push de ; $44d9
	push hl ; $44da
	push af ; $44db
	ld a, l ; $44dc
	ld [wStoryCharacterSlot], a ; $44dd
	pop af ; $44e0
	ld h, a ; $44e1
	ldh a, [hWramBank] ; $44e2
	push af ; $44e4
	push hl ; $44e5
	ld c, $10 ; $44e6
	call BeginFadeOut ; $44e8
	call WaitFadeEnd ; $44eb
	call ClearFrameTasks ; $44ee
	farcall InitTextWindows ; $44f1
	farcall LoadMenuFontGfx ; $44f4
	call DisableLCDSafely ; $44f7
	call ClearSpriteQueue ; $44fa
	xor a, a ; $44fd
	ldh [hScrollY], a ; $44fe
	ldh [hScrollX], a ; $4500
	pop hl ; $4502
	push hl ; $4503
	call LoadExpScreenGfx ; $4504
	call DrawExpScreenNameAndLevel ; $4507
	pop hl ; $450a
	ld a, h ; $450b
	cp a, $00 ; $450c
	jr nz, .done ; $450e
	call DrawExpScreenYesNoBox ; $4510
	ld a, $0e ; $4513
	ld hl, StubNop_1a_4779 ; $4515
	call RegisterFrameTask ; $4518
	call StubNop_1a_4bb9 ; $451b
	jp .queueVRAMCopy ; $451e
	call StubNop_1a_4bba ; $4521
	jp .queueVRAMCopy ; $4524
.done:
	pop af ; $4527
	wram_bank ; $4528
	pop hl ; $452c
	pop de ; $452d
	ld b, h ; $452e
	ldh a, [hWramBank] ; $452f
	push af ; $4531
	push hl ; $4532
	push de ; $4533
	ld a, b ; $4534
	call DrawExpScreenCaption ; $4535
	wram_bank $06 ; $4538
	push af ; $453e
	ld hl, wStoryModeNameOfMainCharacter ; $453f
	ld a, [wStoryCharacterSlot] ; $4542
	or a, a ; $4545
	jr z, .gotRecord ; $4546
	ld l, $40 ; $4548
.gotRecord:
	ld a, l ; $454a
	add a, $18 ; $454b
	ld l, a ; $454d
	ld a, h ; $454e
	adc a, $00 ; $454f
	ld h, a ; $4551
	pop af ; $4552
	ld a, [hl] ; $4553
	cp a, $63 ; $4554
	jr z, .captionMaxLevel ; $4556
	ld a, $02 ; $4558
	call DrawExpScreenCaption ; $455a
	jr .captionDrawn ; $455d
.captionMaxLevel:
	ld a, $05 ; $455f
	call DrawExpScreenCaption ; $4561
.captionDrawn:
	pop de ; $4564
	push de ; $4565
	wram_bank $06 ; $4566
	ld hl, w6_d230 ; $456c
	ld a, e ; $456f
	ld [hl+], a ; $4570
	ld [hl], d ; $4571
	inc hl ; $4572
	xor a, a ; $4573
	ld [hl+], a ; $4574
	ld [hl+], a ; $4575
	ld a, $1c ; $4576
	ld [hl+], a ; $4578
	ld a, $6c ; $4579
	ld [hl+], a ; $457b
	ld a, $ca ; $457c
	ld [hl+], a ; $457e
	ld a, $0f ; $457f
	ld [hl+], a ; $4581
	xor a, a ; $4582
	ld [hl+], a ; $4583
	ld [hl+], a ; $4584
	ld [hl], a ; $4585
	pop de ; $4586
	pop hl ; $4587
	push hl ; $4588
	push de ; $4589
	ld a, l ; $458a
	ld [w6_d254], a ; $458b
	ld de, $0000 ; $458e
	farcall GetExpRemainingToNextLevel ; $4591
	ld d, h ; $4594
	ld e, l ; $4595
	ld hl, $d23c ; $4596
	ld a, e ; $4599
	ld [hl+], a ; $459a
	ld [hl], d ; $459b
	ld hl, $d242 ; $459c
	ld a, e ; $459f
	ld [hl+], a ; $45a0
	ld [hl], d ; $45a1
	ld hl, $d23e ; $45a2
	ld a, $68 ; $45a5
	ld [hl+], a ; $45a7
	ld a, $84 ; $45a8
	ld [hl+], a ; $45aa
	ld a, $ca ; $45ab
	ld [hl+], a ; $45ad
	ld a, $08 ; $45ae
	ld [hl+], a ; $45b0
	xor a, a ; $45b1
	ld [w6_d23b], a ; $45b2
	ld [$d151], a ; $45b5
	wram_bank $01 ; $45b8
	ld hl, $d000 ; $45be
	ld de, $b800 ; $45c1
	ld c, $24 ; $45c4
	call QueueVRAMCopy ; $45c6
	ld hl, $d400 ; $45c9
	ld de, $9800 ; $45cc
	ld c, $24 ; $45cf
	call QueueVRAMCopy ; $45d1
	call CopyMapToScrollBuffers ; $45d4
	ld a, $0f ; $45d7
	ld hl, ExpScreenDrawTask ; $45d9
	call RegisterFrameTask ; $45dc
	call EnableLCD ; $45df
	script_fade_in $10 ; $45e2
	call WaitFadeEnd ; $45e7
	ld a, $0f ; $45ea
	ld hl, ExpScreenNumberTask ; $45ec
	call RegisterFrameTask ; $45ef
	wram_bank $06 ; $45f2
	pop de ; $45f8
	pop hl ; $45f9
	push hl ; $45fa
	push de ; $45fb
	ld a, h ; $45fc
	sub a, $04 ; $45fd
	jp z, .finish ; $45ff
	ld hl, w6_d230 ; $4602
	ld a, [hl+] ; $4605
	ld h, [hl] ; $4606
	ld l, a ; $4607
	ld a, h ; $4608
	or a, l ; $4609
	jp z, .finish ; $460a
.fillLoop:
	call AdvanceExpGaugeFill ; $460d
	ld a, [w6_d238] ; $4610
	and a, a ; $4613
	jr nz, .levelUp ; $4614
	ld a, [w6_d239] ; $4616
	and a, a ; $4619
	jr nz, .gaugeFull ; $461a
	ldh a, [hPlayerInputFlags] ; $461c
	and a, PADF_A | PADF_B ; $461e
	jr nz, .gaugeFull ; $4620
	sound $5e ; $4622
	call WaitFramesCmd ; $4624
	db $04 ; $4627 inline arg
	jr .fillLoop ; $4628
.gaugeFull:
	ld a, $01 ; $462a
	ld [w6_d239], a ; $462c
	sound $5f ; $462f
	call AdvanceExpGaugeFill ; $4631
	ld hl, w6_d230 ; $4634
	ld a, [hl+] ; $4637
	ld h, [hl] ; $4638
	ld l, a ; $4639
	ld de, $fc18 ; $463a
	add hl, de ; $463d
	jr nc, .nextFrame ; $463e
	ld hl, w6_d230 ; $4640
	ld a, [hl+] ; $4643
	ld h, [hl] ; $4644
	ld l, a ; $4645
	ld de, $d8f0 ; $4646
	add hl, de ; $4649
	jr nc, .fastFill ; $464a
	call AdvanceExpGaugeFill ; $464c
	call AdvanceExpGaugeFill ; $464f
	call AdvanceExpGaugeFill ; $4652
	call AdvanceExpGaugeFill ; $4655
	call AdvanceExpGaugeFill ; $4658
	call AdvanceExpGaugeFill ; $465b
	call AdvanceExpGaugeFill ; $465e
	call AdvanceExpGaugeFill ; $4661
.fastFill:
	call AdvanceExpGaugeFill ; $4664
	call AdvanceExpGaugeFill ; $4667
	call AdvanceExpGaugeFill ; $466a
	call AdvanceExpGaugeFill ; $466d
	call AdvanceExpGaugeFill ; $4670
	call AdvanceExpGaugeFill ; $4673
.nextFrame:
	call AdvanceFrame ; $4676
	jr .fillLoop ; $4679
.levelUp:
	sound $5f ; $467b
	ld a, [$c36f] ; $467d
	and a, a ; $4680
	jr z, .finish ; $4681
	push af ; $4683
	wram_bank $06 ; $4684
	ld c, $00 ; $468a
	ld a, [$d000] ; $468c
	and a, a ; $468f
	jr nz, .storeScroll ; $4690
	ld c, $fc ; $4692
.storeScroll:
	ld a, c ; $4694
	ld hl, w6_d23a ; $4695
	ld [hl], a ; $4698
	ld b, $28 ; $4699
.bonusWaitLoop:
	ld hl, w6_d23a ; $469b
	ld a, [hl] ; $469e
	and a, a ; $469f
	jr z, .bonusFrame ; $46a0
	inc a ; $46a2
	ld [hl], a ; $46a3
.bonusFrame:
	call AdvanceFrame ; $46a4
	dec b ; $46a7
	jr z, .bonusDone ; $46a8
	ldh a, [hInputRisingEdge] ; $46aa
	or a, a ; $46ac
	jr z, .bonusWaitLoop ; $46ad
.bonusDone:
	pop af ; $46af
	call DrawExpBonusMessage ; $46b0
	sound $5f ; $46b3
	call WaitFramesCmd ; $46b5
	db $14 ; $46b8 inline arg
	wram_bank $06 ; $46b9
	ld hl, $c370 ; $46bf
	ld a, [hl+] ; $46c2
	ld d, [hl] ; $46c3
	ld e, a ; $46c4
	ld hl, w6_d230 ; $46c5
	ld a, [hl+] ; $46c8
	ld h, [hl] ; $46c9
	ld l, a ; $46ca
	add hl, de ; $46cb
	ld d, h ; $46cc
	ld e, l ; $46cd
	ld hl, w6_d230 ; $46ce
	ld a, e ; $46d1
	ld [hl+], a ; $46d2
	ld [hl], d ; $46d3
	xor a, a ; $46d4
	ld [$c36f], a ; $46d5
	ld [w6_d238], a ; $46d8
	jp .fillLoop ; $46db
.finish:
	wram_bank $06 ; $46de
	ld c, $00 ; $46e4
	ld a, [$d000] ; $46e6
	and a, a ; $46e9
	jr nz, .storeFinalScroll ; $46ea
	ld c, $fc ; $46ec
.storeFinalScroll:
	ld a, c ; $46ee
	ld hl, w6_d23a ; $46ef
	ld [hl], a ; $46f2
	ld b, $f0 ; $46f3
.finalWaitLoop:
	ld hl, w6_d23a ; $46f5
	ld a, [hl] ; $46f8
	and a, a ; $46f9
	jr z, .finalFrame ; $46fa
	inc a ; $46fc
	ld [hl], a ; $46fd
.finalFrame:
	call AdvanceFrame ; $46fe
	dec b ; $4701
	jr z, .fadeOut ; $4702
	ldh a, [hInputRisingEdge] ; $4704
	or a, a ; $4706
	jr z, .finalWaitLoop ; $4707
.fadeOut:
	ld c, $10 ; $4709
	call BeginFadeOut ; $470b
	call WaitFadeEnd ; $470e
	ld hl, ExpScreenDrawTask ; $4711
	call UnregisterFrameTask ; $4714
	ld hl, ExpScreenNumberTask ; $4717
	call UnregisterFrameTask ; $471a
	call AdvanceFrame ; $471d
	pop de ; $4720
	pop hl ; $4721
	pop af ; $4722
	wram_bank ; $4723
	pop bc ; $4727
	wram_bank $06 ; $4728
	ld hl, w6_d230 ; $472e
	ld a, [hl+] ; $4731
	ld d, [hl] ; $4732
	ld e, a ; $4733
	ld a, d ; $4734
	or a, e ; $4735
	ret z ; $4736
	ld a, [w6_d254] ; $4737
	farcall AddPlayerExp ; $473a
	ret ; $473d
.queueVRAMCopy:
	wram_bank $01 ; $473e
	ld hl, $d000 ; $4744
	ld de, $b800 ; $4747
	ld c, $24 ; $474a
	call QueueVRAMCopy ; $474c
	ld hl, $d400 ; $474f
	ld de, $9800 ; $4752
	ld c, $24 ; $4755
	call QueueVRAMCopy ; $4757
	call CopyMapToScrollBuffers ; $475a
	ld a, $0f ; $475d
	ld hl, ExpScreenDrawTask ; $475f
	call RegisterFrameTask ; $4762
	call EnableLCD ; $4765
	script_fade_in $10 ; $4768
	call WaitFadeEnd ; $476d
	pop af ; $4770
	wram_bank ; $4771
	pop hl ; $4775
	pop de ; $4776
	pop bc ; $4777
	ret ; $4778
StubNop_1a_4779:
	ret ; $4779
ExpScreenDrawTask:
	push af ; $477a
	push bc ; $477b
	push de ; $477c
	push hl ; $477d
	ldh a, [hWramBank] ; $477e
	push af ; $4780
	wram_bank $06 ; $4781
	ld a, [$d151] ; $4787
	or a, a ; $478a
	jr nz, .checkStoryModeMainCharacterOverworldSprite ; $478b
	ld de, $a000 ; $478d
.checkStoryModeMainCharacterOverworldSprite:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4790
	rlca ; $4793
	add a, LOW(Data_1a_4809) ; $4794
	ld l, a ; $4796
	adc a, HIGH(Data_1a_4809) ; $4797
	sub a, l ; $4799
	ld h, a ; $479a
	ld a, [hl+] ; $479b
	ld d, [hl] ; $479c
	ld e, a ; $479d
	ld bc, $0e00 ; $479e
	ld hl, SpriteTemplate_1a_4840 ; $47a1
	ld bc, $09c0 ; $47a4
	ld de, $7058 ; $47a7
	call QueueSpriteTemplate ; $47aa
	ld a, [$d151] ; $47ad
	and a, $80 ; $47b0
	jr z, .restore ; $47b2
	wram_bank $02 ; $47b4
	ld a, $01 ; $47ba
	ld hl, $d800 ; $47bc
	ld b, $40 ; $47bf
.loop:
	ld [hl+], a ; $47c1
	dec b ; $47c2
	jr nz, .loop ; $47c3
	ld hl, $d800 ; $47c5
	ld de, $b9e0 ; $47c8
	ld c, $04 ; $47cb
	call QueueVRAMCopy ; $47cd
	wram_bank $03 ; $47d0
	ld a, $20 ; $47d6
	ld hl, w3_d800 ; $47d8
	ld b, $40 ; $47db
.loopB:
	ld [hl+], a ; $47dd
	dec b ; $47de
	jr nz, .loopB ; $47df
	ld a, $03 ; $47e1
	call DrawExpScreenCaption ; $47e3
	ld hl, w3_d800 ; $47e6
	ld de, $99e0 ; $47e9
	ld c, $04 ; $47ec
	call QueueVRAMCopy ; $47ee
	wram_bank $06 ; $47f1
	ld a, [$d151] ; $47f7
	and a, $7f ; $47fa
	ld [$d151], a ; $47fc
.restore:
	pop af ; $47ff
	wram_bank ; $4800
	pop hl ; $4804
	pop de ; $4805
	pop bc ; $4806
	pop af ; $4807
	ret ; $4808
Data_1a_4809:
	; $4809, 55 bytes (bytes:16)
	db $2c, $7b, $2e, $7b, $2d, $7b, $2e, $79, $2a, $7b, $2f, $7a, $30, $7b, $2e, $7a ; 0x00
	db $2c, $7b, $30, $7b, $2f, $7b, $2a, $7b, $30, $7a, $2c, $7c, $2a, $7c, $2a, $7b ; 0x10
	db $2c, $7b, $2c, $7b, $2c, $7b, $2c, $7b, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x20
	db $00, $00, $00, $00, $00, $00, $00 ; 0x30
SpriteTemplate_1a_4840:
	; $4840, 17 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite $10, $00, $04, $00
	oam_sprite $10, $08, $06, $00
	oam_sprite_end
	db $00 ; $4851
LoadExpScreenGfx:
	wram_bank $01 ; $4852
	push hl ; $4858
	ld hl, ExpScreenGfx0 ; $4859
	ld de, $d000 ; $485c
	call DecompressData ; $485f
	ld hl, $d000 ; $4862
	ld de, $b000 ; $4865
	ld c, $80 ; $4868
	call QueueVRAMCopy ; $486a
	ld hl, $d800 ; $486d
	ld de, $a800 ; $4870
	ld c, $50 ; $4873
	call QueueVRAMCopy ; $4875
	ld hl, ExpScreenGfxPalettes0 ; $4878
	ld de, $0008 ; $487b
	call LoadPalettesMasterOnly ; $487e
	wram_bank $01 ; $4881
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $4887
	ld d, $0e ; $488a
	farcall LoadIndexedPalette_18 ; $488c
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $488f
	ld b, $00 ; $4892
	wram_bank $01 ; $4894
	ld hl, ExpScreenGfx6 ; $489a
	ld de, $d000 ; $489d
	call DecompressData ; $48a0
	ld hl, $d000 ; $48a3
	ld de, $ac00 ; $48a6
	ld c, $04 ; $48a9
	call QueueVRAMCopy ; $48ab
	ld hl, ExpScreenGfx7 ; $48ae
	ld de, $d000 ; $48b1
	call DecompressData ; $48b4
	ld hl, $d000 ; $48b7
	ld de, $ac40 ; $48ba
	ld c, $04 ; $48bd
	call QueueVRAMCopy ; $48bf
	ld hl, ExpScreenGfxPalettes2 ; $48c2
	ld de, $0901 ; $48c5
	call LoadPalettesMasterOnly ; $48c8
	pop hl ; $48cb
	ld a, h ; $48cc
	cp a, $01 ; $48cd
	jr z, .processVRAMCopyQueues ; $48cf
	ld hl, ExpScreenGfx5 ; $48d1
	ld de, $d000 ; $48d4
	call DecompressData ; $48d7
	ld hl, $d000 ; $48da
	ld de, $ac80 ; $48dd
	ld c, $02 ; $48e0
	call QueueVRAMCopy ; $48e2
	ld hl, ExpScreenGfxPalettes1 ; $48e5
	ld de, $0a01 ; $48e8
	call LoadPalettesMasterOnly ; $48eb
	jr .copyMemoryFast ; $48ee
.processVRAMCopyQueues:
	call ProcessVRAMCopyQueues ; $48f0
	ld hl, ExpScreenGfxPalettes3 ; $48f3
	ld de, $0f01 ; $48f6
	call LoadPalettesMasterOnly ; $48f9
	wram_bank $01 ; $48fc
	ld hl, ExpScreenGfx8 ; $4902
	ld de, $de00 ; $4905
	call DecompressData ; $4908
	ld hl, $de00 ; $490b
	ld de, $aca0 ; $490e
	ld c, $14 ; $4911
	call QueueVRAMCopy ; $4913
	wram_bank $01 ; $4916
	ld hl, ExpScreenGfx2 ; $491c
	ld de, $d000 ; $491f
	ld c, (ExpScreenGfx3 - ExpScreenGfx2) / 16 ; $4922
	call CopyMemoryFast ; $4924
	ld hl, ExpScreenGfx1 ; $4927
	ld de, $d400 ; $492a
	ld c, (ExpScreenGfx2 - ExpScreenGfx1) / 16 ; $492d
	call CopyMemoryFast ; $492f
	ret ; $4932
.copyMemoryFast:
	wram_bank $01 ; $4933
	ld hl, ExpScreenGfx4 ; $4939
	ld de, $d000 ; $493c
	ld c, $24 ; $493f
	call CopyMemoryFast ; $4941
	ld hl, ExpScreenGfx3 ; $4944
	ld de, $d400 ; $4947
	ld c, (ExpScreenGfx4 - ExpScreenGfx3) / 16 ; $494a
	call CopyMemoryFast ; $494c
	ret ; $494f
ExpScreenMessageBoxTilemap:
	; $4950, 200 bytes (records:2)
	dw $0b00 ; record 0
	dw $0b01 ; record 1
	dw $0b01 ; record 2
	dw $0b01 ; record 3
	dw $0b01 ; record 4
	dw $0b01 ; record 5
	dw $0b01 ; record 6
	dw $0b01 ; record 7
	dw $0b01 ; record 8
	dw $0b01 ; record 9
	dw $0b01 ; record 10
	dw $0b01 ; record 11
	dw $0b01 ; record 12
	dw $0b01 ; record 13
	dw $0b01 ; record 14
	dw $0b01 ; record 15
	dw $0b01 ; record 16
	dw $0b01 ; record 17
	dw $0b01 ; record 18
	dw $0b02 ; record 19
	dw $0b10 ; record 20
	dw $0120 ; record 21
	dw $0120 ; record 22
	dw $0120 ; record 23
	dw $0120 ; record 24
	dw $0120 ; record 25
	dw $0120 ; record 26
	dw $0120 ; record 27
	dw $0120 ; record 28
	dw $0120 ; record 29
	dw $0120 ; record 30
	dw $0120 ; record 31
	dw $0120 ; record 32
	dw $0120 ; record 33
	dw $0120 ; record 34
	dw $0120 ; record 35
	dw $0120 ; record 36
	dw $0120 ; record 37
	dw $0120 ; record 38
	dw $0b12 ; record 39
	dw $0b10 ; record 40
	dw $0120 ; record 41
	dw $0120 ; record 42
	dw $0120 ; record 43
	dw $0120 ; record 44
	dw $0120 ; record 45
	dw $0120 ; record 46
	dw $0120 ; record 47
	dw $0120 ; record 48
	dw $0120 ; record 49
	dw $0120 ; record 50
	dw $0120 ; record 51
	dw $0120 ; record 52
	dw $0120 ; record 53
	dw $0120 ; record 54
	dw $0120 ; record 55
	dw $0120 ; record 56
	dw $0120 ; record 57
	dw $0120 ; record 58
	dw $0b12 ; record 59
	dw $0b10 ; record 60
	dw $0120 ; record 61
	dw $0120 ; record 62
	dw $0120 ; record 63
	dw $0120 ; record 64
	dw $0120 ; record 65
	dw $0120 ; record 66
	dw $0120 ; record 67
	dw $0120 ; record 68
	dw $0120 ; record 69
	dw $0120 ; record 70
	dw $0120 ; record 71
	dw $0120 ; record 72
	dw $0120 ; record 73
	dw $0120 ; record 74
	dw $0120 ; record 75
	dw $0120 ; record 76
	dw $0120 ; record 77
	dw $0120 ; record 78
	dw $0b12 ; record 79
	dw $0b20 ; record 80
	dw $0b21 ; record 81
	dw $0b21 ; record 82
	dw $0b21 ; record 83
	dw $0b21 ; record 84
	dw $0b21 ; record 85
	dw $0b21 ; record 86
	dw $0b21 ; record 87
	dw $0b21 ; record 88
	dw $0b21 ; record 89
	dw $0b21 ; record 90
	dw $0b21 ; record 91
	dw $0b21 ; record 92
	dw $0b21 ; record 93
	dw $0b21 ; record 94
	dw $0b21 ; record 95
	dw $0b21 ; record 96
	dw $0b21 ; record 97
	dw $0b21 ; record 98
	dw $0b22 ; record 99
DrawExpScreenMessageBox:
	push af ; $4a18
	push bc ; $4a19
	push de ; $4a1a
	push hl ; $4a1b
	ld c, $00 ; $4a1c
	ld hl, ExpScreenMessageBoxTilemap ; $4a1e
.loop:
	ld a, c ; $4a21
	cp a, $05 ; $4a22
	jr z, .restore ; $4a24
	ld b, $00 ; $4a26
.loopB:
	ld a, b ; $4a28
	cp a, $14 ; $4a29
	jr z, .eq14 ; $4a2b
	ld a, [hl] ; $4a2d
	ld d, a ; $4a2e
	inc hl ; $4a2f
	ld a, [hl] ; $4a30
	ld e, a ; $4a31
	call WriteTileBufferCell ; $4a32
	inc hl ; $4a35
	inc b ; $4a36
	jr .loopB ; $4a37
.eq14:
	inc c ; $4a39
	jr .loop ; $4a3a
.restore:
	pop hl ; $4a3c
	pop de ; $4a3d
	pop bc ; $4a3e
	pop af ; $4a3f
	ret ; $4a40
ExpScreenYesNoBoxTilemap:
	; $4a41, 60 bytes (records:2)
	dw $0b00 ; record 0
	dw $0b01 ; record 1
	dw $0b01 ; record 2
	dw $0b01 ; record 3
	dw $0b01 ; record 4
	dw $0b02 ; record 5
	dw $0b10 ; record 6
	dw $0120 ; record 7
	dw $0120 ; record 8
	dw $0120 ; record 9
	dw $0120 ; record 10
	dw $0b12 ; record 11
	dw $0b10 ; record 12
	dw $0120 ; record 13
	dw $0120 ; record 14
	dw $0120 ; record 15
	dw $0120 ; record 16
	dw $0b12 ; record 17
	dw $0b10 ; record 18
	dw $0120 ; record 19
	dw $0120 ; record 20
	dw $0120 ; record 21
	dw $0120 ; record 22
	dw $0b12 ; record 23
	dw $0b20 ; record 24
	dw $0b21 ; record 25
	dw $0b21 ; record 26
	dw $0b21 ; record 27
	dw $0b21 ; record 28
	dw $0b22 ; record 29
DrawExpScreenYesNoBox:
	push af ; $4a7d
	push bc ; $4a7e
	push de ; $4a7f
	push hl ; $4a80
	ld bc, $0005 ; $4a81
	ld a, $00 ; $4a84
	ld hl, ExpScreenYesNoBoxTilemap ; $4a86
.loop:
	ld a, c ; $4a89
	cp a, $0a ; $4a8a
	jr z, .eq0a ; $4a8c
	ld b, $00 ; $4a8e
.loopB:
	ld a, b ; $4a90
	cp a, $06 ; $4a91
	jr z, .eq06 ; $4a93
	ld a, [hl] ; $4a95
	ld d, a ; $4a96
	inc hl ; $4a97
	ld a, [hl] ; $4a98
	ld e, a ; $4a99
	call WriteTileBufferCell ; $4a9a
	inc hl ; $4a9d
	inc b ; $4a9e
	jr .loopB ; $4a9f
.eq06:
	inc c ; $4aa1
	jr .loop ; $4aa2
.eq0a:
	ld de, $d4c2 ; $4aa4
	ld hl, $04eb ; $4aa7
	ld c, $20 ; $4aaa
	farcall RenderProportionalTextAt ; $4aac
	pop hl ; $4aaf
	pop de ; $4ab0
	pop bc ; $4ab1
	pop af ; $4ab2
	ret ; $4ab3
	; $4ab4, 64 bytes (records:2)
	dw $0b38 ; record 0
	dw $0b39 ; record 1
	dw $0b3a ; record 2
	dw $0b3b ; record 3
	dw $0b3c ; record 4
	dw $0b3d ; record 5
	dw $0b3e ; record 6
	dw $0b3f ; record 7
	dw $0b48 ; record 8
	dw $0b49 ; record 9
	dw $0b4a ; record 10
	dw $0b4b ; record 11
	dw $0b4c ; record 12
	dw $0b4d ; record 13
	dw $0b4e ; record 14
	dw $0b4f ; record 15
	dw $0b58 ; record 16
	dw $0b59 ; record 17
	dw $0b5a ; record 18
	dw $0b5b ; record 19
	dw $0b5c ; record 20
	dw $0b5d ; record 21
	dw $0b5e ; record 22
	dw $0b5f ; record 23
	dw $0b68 ; record 24
	dw $0b69 ; record 25
	dw $0b6a ; record 26
	dw $0b6b ; record 27
	dw $0b6c ; record 28
	dw $0b6d ; record 29
	dw $0b6e ; record 30
	dw $0b6f ; record 31
Data_1a_4af4:
	INCBIN "data/bank_01a/d_4af4.bin" ; $4af4, 43 bytes
DrawExpScreenNameAndLevel:
	push af ; $4b1f
	push bc ; $4b20
	push de ; $4b21
	push hl ; $4b22
	call ClearExpScreenNameBox ; $4b23
	wram_bank $01 ; $4b26
	push af ; $4b2c
	ld hl, wStoryModeNameOfMainCharacter ; $4b2d
	ld a, [wStoryCharacterSlot] ; $4b30
	or a, a ; $4b33
	jr z, .zero ; $4b34
	ld l, $40 ; $4b36
.zero:
	ld a, l ; $4b38
	add a, $00 ; $4b39
	ld l, a ; $4b3b
	ld a, h ; $4b3c
	adc a, $00 ; $4b3d
	ld h, a ; $4b3f
	pop af ; $4b40
	ld de, $d4c7 ; $4b41
	call CopyNameToTileBuffer ; $4b44
	push af ; $4b47
	ld hl, wStoryModeNameOfMainCharacter ; $4b48
	ld a, [wStoryCharacterSlot] ; $4b4b
	or a, a ; $4b4e
	jr z, .zero2 ; $4b4f
	ld l, $40 ; $4b51
.zero2:
	ld a, l ; $4b53
	add a, $18 ; $4b54
	ld l, a ; $4b56
	ld a, h ; $4b57
	adc a, $00 ; $4b58
	ld h, a ; $4b5a
	pop af ; $4b5b
	ld a, [hl] ; $4b5c
	ld l, a ; $4b5d
	ld h, $00 ; $4b5e
	farcall PushTextArgNumber ; $4b60
	ld de, $d507 ; $4b63
	ld hl, $04ed ; $4b66
	ld c, $20 ; $4b69
	farcall RenderProportionalTextAt ; $4b6b
	pop hl ; $4b6e
	pop de ; $4b6f
	pop bc ; $4b70
	pop af ; $4b71
	ret ; $4b72
CopyNameToTileBuffer:
	ld a, [hl+] ; $4b73
	or a, a ; $4b74
	ret z ; $4b75
	cp a, $de ; $4b76
	jr z, .moveTileBufferDestUpRow ; $4b78
	cp a, $df ; $4b7a
	jr z, .moveTileBufferDestUpRow ; $4b7c
	ld [de], a ; $4b7e
	inc de ; $4b7f
	jr CopyNameToTileBuffer ; $4b80
.moveTileBufferDestUpRow:
	call MoveTileBufferDestUpRow ; $4b82
	ld [de], a ; $4b85
	ld a, $21 ; $4b86
	add a, e ; $4b88
	ld e, a ; $4b89
	jr nc, .copyNameToTileBuffer ; $4b8a
	inc d ; $4b8c
.copyNameToTileBuffer:
	jr CopyNameToTileBuffer ; $4b8d
MoveTileBufferDestUpRow:
	ld b, $21 ; $4b8f
.loop:
	dec de ; $4b91
	dec b ; $4b92
	jr nz, .loop ; $4b93
	ret ; $4b95
ClearExpScreenNameBox:
	push af ; $4b96
	push bc ; $4b97
	push de ; $4b98
	push hl ; $4b99
	ld c, $05 ; $4b9a
.loop:
	ld a, c ; $4b9c
	cp a, $09 ; $4b9d
	jr z, .restore ; $4b9f
	ld b, $07 ; $4ba1
.loopB:
	ld a, b ; $4ba3
	cp a, $0d ; $4ba4
	jr z, .eq0d ; $4ba6
	ld de, $2000 ; $4ba8
	call WriteTileBufferCell ; $4bab
	inc b ; $4bae
	jr .loopB ; $4baf
.eq0d:
	inc c ; $4bb1
	jr .loop ; $4bb2
.restore:
	pop hl ; $4bb4
	pop de ; $4bb5
	pop bc ; $4bb6
	pop af ; $4bb7
	ret ; $4bb8
StubNop_1a_4bb9:
	ret ; $4bb9
StubNop_1a_4bba:
	ret ; $4bba
DrawPositionedStringToTileBuffer:
	push af ; $4bbb
	push bc ; $4bbc
	push de ; $4bbd
	push hl ; $4bbe
	ld a, [hl] ; $4bbf
	ld b, a ; $4bc0
	inc hl ; $4bc1
	ld a, [hl] ; $4bc2
	ld c, a ; $4bc3
	inc hl ; $4bc4
	ld a, [hl] ; $4bc5
	ld e, a ; $4bc6
	inc hl ; $4bc7
	call DrawStringToTileBuffer ; $4bc8
	pop hl ; $4bcb
	pop de ; $4bcc
	pop bc ; $4bcd
	pop af ; $4bce
	ret ; $4bcf
DrawStringToTileBuffer:
	push af ; $4bd0
	push bc ; $4bd1
	push de ; $4bd2
	push hl ; $4bd3
.charLoop:
	ld a, [hl] ; $4bd4
	cp a, $00 ; $4bd5
	jr z, .done ; $4bd7
	cp a, $9e ; $4bd9
	jr z, .specialChar ; $4bdb
	cp a, $9f ; $4bdd
	jr z, .specialChar ; $4bdf
	cp a, $de ; $4be1
	jr z, .specialChar ; $4be3
	cp a, $df ; $4be5
	jr z, .specialChar ; $4be7
	ld d, a ; $4be9
	call WriteTileBufferCell ; $4bea
	inc b ; $4bed
	inc hl ; $4bee
	jr .charLoop ; $4bef
.specialChar:
	push bc ; $4bf1
	dec b ; $4bf2
	dec c ; $4bf3
	push af ; $4bf4
	ld a, c ; $4bf5
	cp a, $00 ; $4bf6
	jr z, .noRoom ; $4bf8
	pop af ; $4bfa
	ld d, a ; $4bfb
	call WriteTileBufferCell ; $4bfc
	pop bc ; $4bff
	inc hl ; $4c00
	jr .charLoop ; $4c01
.noRoom:
	pop af ; $4c03
	push de ; $4c04
	cp a, $9e ; $4c05
	jr z, .altTile ; $4c07
	cp a, $de ; $4c09
	jr z, .altTile ; $4c0b
	ld de, $040b ; $4c0d
	jr .writeTile ; $4c10
.altTile:
	ld de, $030b ; $4c12
.writeTile:
	call WriteTileBufferCell ; $4c15
	pop de ; $4c18
	pop bc ; $4c19
	inc hl ; $4c1a
	jr .charLoop ; $4c1b
.done:
	pop hl ; $4c1d
	pop de ; $4c1e
	pop bc ; $4c1f
	pop af ; $4c20
	ret ; $4c21
GetTileBufferCellAddr:
	push af ; $4c22
	push de ; $4c23
	ld hl, $0020 ; $4c24
	ld a, c ; $4c27
	call MulHLByA ; $4c28
	ld d, $00 ; $4c2b
	ld e, b ; $4c2d
	add hl, de ; $4c2e
	push hl ; $4c2f
	pop de ; $4c30
	ld hl, $d000 ; $4c31
	add hl, de ; $4c34
	pop de ; $4c35
	pop af ; $4c36
	ret ; $4c37
WriteTileBufferCell:
	push af ; $4c38
	push bc ; $4c39
	push de ; $4c3a
	push hl ; $4c3b
	ldh a, [hWramBank] ; $4c3c
	push af ; $4c3e
	wram_bank $01 ; $4c3f
	call GetTileBufferCellAddr ; $4c45
	ld a, e ; $4c48
	ld [hl], a ; $4c49
	push de ; $4c4a
	ld de, $0400 ; $4c4b
	add hl, de ; $4c4e
	pop de ; $4c4f
	ld a, d ; $4c50
	ld [hl], a ; $4c51
	pop af ; $4c52
	wram_bank ; $4c53
	pop hl ; $4c57
	pop de ; $4c58
	pop bc ; $4c59
	pop af ; $4c5a
	ret ; $4c5b
WriteStatModifierToTileBuffer:
	push af ; $4c5c
	push bc ; $4c5d
	push de ; $4c5e
	push hl ; $4c5f
	ld d, a ; $4c60
	push bc ; $4c61
	push de ; $4c62
	call SignExtendModifierByte ; $4c63
	push hl ; $4c66
	pop bc ; $4c67
	ld de, $0000 ; $4c68
	call CompareBCToDE ; $4c6b
	cp a, $00 ; $4c6e
	jr z, .zero ; $4c70
	bit 7, h ; $4c72
	jr nz, .negative ; $4c74
	ld a, $2b ; $4c76
	jr .writeSign ; $4c78
.negative:
	ld a, $2d ; $4c7a
	jr .writeSign ; $4c7c
.zero:
	ld a, $60 ; $4c7e
.writeSign:
	pop de ; $4c80
	pop bc ; $4c81
	push de ; $4c82
	ld d, a ; $4c83
	ld e, $01 ; $4c84
	call WriteTileBufferCell ; $4c86
	pop de ; $4c89
	inc b ; $4c8a
	ld a, d ; $4c8b
	cp a, $00 ; $4c8c
	jr z, .tens ; $4c8e
	push bc ; $4c90
	push de ; $4c91
	call SignExtendModifierByte ; $4c92
	bit 7, h ; $4c95
	jr z, .divide ; $4c97
	push hl ; $4c99
	pop de ; $4c9a
	ld hl, $0000 ; $4c9b
	ld a, l ; $4c9e
	sub a, e ; $4c9f
	ld l, a ; $4ca0
	ld a, h ; $4ca1
	sbc a, d ; $4ca2
	ld h, a ; $4ca3
.divide:
	ld de, $0064 ; $4ca4
	call DivHLByDE ; $4ca7
	pop de ; $4caa
	pop bc ; $4cab
	ld a, l ; $4cac
	cp a, $00 ; $4cad
	jr z, .tens ; $4caf
	push de ; $4cb1
	ld d, $31 ; $4cb2
	ld e, $01 ; $4cb4
	call WriteTileBufferCell ; $4cb6
	pop de ; $4cb9
	inc b ; $4cba
.tens:
	ld a, d ; $4cbb
	call GetModifierTensDigit ; $4cbc
	cp a, $00 ; $4cbf
	jr nz, .writeTens ; $4cc1
	ld a, d ; $4cc3
	sub a, $64 ; $4cc4
	bit 7, a ; $4cc6
	jr nz, .ones ; $4cc8
	ld a, $00 ; $4cca
.writeTens:
	add a, $30 ; $4ccc
	push de ; $4cce
	ld d, a ; $4ccf
	ld e, $01 ; $4cd0
	call WriteTileBufferCell ; $4cd2
	pop de ; $4cd5
	inc b ; $4cd6
.ones:
	ld a, d ; $4cd7
	call GetModifierOnesDigit ; $4cd8
	add a, $30 ; $4cdb
	push de ; $4cdd
	ld d, a ; $4cde
	ld e, $01 ; $4cdf
	call WriteTileBufferCell ; $4ce1
	pop de ; $4ce4
	pop hl ; $4ce5
	pop de ; $4ce6
	pop bc ; $4ce7
	pop af ; $4ce8
	ret ; $4ce9
CompareBCToDE:
	push bc ; $4cea
	push de ; $4ceb
	push hl ; $4cec
	push bc ; $4ced
	pop hl ; $4cee
	ld a, l ; $4cef
	sub a, e ; $4cf0
	ld l, a ; $4cf1
	ld a, h ; $4cf2
	sbc a, d ; $4cf3
	ld h, a ; $4cf4
	bit 7, h ; $4cf5
	jr nz, .negative ; $4cf7
	ld a, h ; $4cf9
	cp a, $00 ; $4cfa
	jr nz, .step ; $4cfc
	ld a, l ; $4cfe
	cp a, $00 ; $4cff
	jr nz, .step ; $4d01
	ld a, $00 ; $4d03
	jr .restore ; $4d05
.step:
	ld a, $01 ; $4d07
	jr .restore ; $4d09
.negative:
	ld a, $02 ; $4d0b
.restore:
	pop hl ; $4d0d
	pop de ; $4d0e
	pop bc ; $4d0f
	ret ; $4d10
GetModifierTensDigit:
	push bc ; $4d11
	push de ; $4d12
	push hl ; $4d13
	call SignExtendModifierByte ; $4d14
	bit 7, h ; $4d17
	jr z, .positive ; $4d19
	push hl ; $4d1b
	pop de ; $4d1c
	ld hl, $0000 ; $4d1d
	ld a, l ; $4d20
	sub a, e ; $4d21
	ld l, a ; $4d22
	ld a, h ; $4d23
	sbc a, d ; $4d24
	ld h, a ; $4d25
.positive:
	push hl ; $4d26
	pop bc ; $4d27
	ld de, $0064 ; $4d28
	ld a, l ; $4d2b
	sub a, e ; $4d2c
	ld l, a ; $4d2d
	ld a, h ; $4d2e
	sbc a, d ; $4d2f
	ld h, a ; $4d30
	bit 7, h ; $4d31
	jr nz, .negative ; $4d33
	push hl ; $4d35
	pop bc ; $4d36
.negative:
	push bc ; $4d37
	pop hl ; $4d38
	ld de, $000a ; $4d39
	call DivHLByDE ; $4d3c
	ld a, l ; $4d3f
	pop hl ; $4d40
	pop de ; $4d41
	pop bc ; $4d42
	ret ; $4d43
GetModifierOnesDigit:
	push bc ; $4d44
	push de ; $4d45
	push hl ; $4d46
	call SignExtendModifierByte ; $4d47
	bit 7, h ; $4d4a
	jr z, .positive ; $4d4c
	push hl ; $4d4e
	pop de ; $4d4f
	ld hl, $0000 ; $4d50
	ld a, l ; $4d53
	sub a, e ; $4d54
	ld l, a ; $4d55
	ld a, h ; $4d56
	sbc a, d ; $4d57
	ld h, a ; $4d58
.positive:
	push hl ; $4d59
	pop bc ; $4d5a
	ld de, $0064 ; $4d5b
	ld a, l ; $4d5e
	sub a, e ; $4d5f
	ld l, a ; $4d60
	ld a, h ; $4d61
	sbc a, d ; $4d62
	ld h, a ; $4d63
	bit 7, h ; $4d64
	jr nz, .negative ; $4d66
	push hl ; $4d68
	pop bc ; $4d69
.negative:
	push bc ; $4d6a
	pop hl ; $4d6b
	ld de, $000a ; $4d6c
	call DivHLByDE ; $4d6f
	ld a, $0a ; $4d72
	call MulHLByA ; $4d74
	push hl ; $4d77
	pop de ; $4d78
	push bc ; $4d79
	pop hl ; $4d7a
	ld a, l ; $4d7b
	sub a, e ; $4d7c
	ld l, a ; $4d7d
	ld a, h ; $4d7e
	sbc a, d ; $4d7f
	ld h, a ; $4d80
	ld a, l ; $4d81
	pop hl ; $4d82
	pop de ; $4d83
	pop bc ; $4d84
	ret ; $4d85
SignExtendModifierByte:
	push af ; $4d86
	push bc ; $4d87
	push de ; $4d88
	ld l, a ; $4d89
	ld h, $00 ; $4d8a
	push hl ; $4d8c
	pop bc ; $4d8d
	ld d, $00 ; $4d8e
	ld e, $91 ; $4d90
	ld a, l ; $4d92
	sub a, e ; $4d93
	ld l, a ; $4d94
	ld a, h ; $4d95
	sbc a, d ; $4d96
	ld h, a ; $4d97
	bit 7, h ; $4d98
	jr nz, .positive ; $4d9a
	push bc ; $4d9c
	pop hl ; $4d9d
	ld h, $ff ; $4d9e
	jr .done ; $4da0
.positive:
	push bc ; $4da2
	pop hl ; $4da3
.done:
	pop de ; $4da4
	pop bc ; $4da5
	pop af ; $4da6
	ret ; $4da7
	ret ; $4da8
	push af ; $4da9
	push bc ; $4daa
	push de ; $4dab
	push hl ; $4dac
	ldh a, [hWramBank] ; $4dad
	push af ; $4daf
	wram_bank $06 ; $4db0
	ld a, [$d151] ; $4db6
	or a, $01 ; $4db9
	ld [$d151], a ; $4dbb
	call AdvanceFrame ; $4dbe
	call DrawExpScreenMessageBox ; $4dc1
	ld hl, ExtendModifierByteTable0 ; $4dc4
	call DrawPositionedStringToTileBuffer ; $4dc7
	ld hl, ExtendModifierByteGfx1 ; $4dca
	call DrawPositionedStringToTileBuffer ; $4dcd
	wram_bank $01 ; $4dd0
	ld hl, $d000 ; $4dd6
	ld de, $b800 ; $4dd9
	ld c, $08 ; $4ddc
	call QueueVRAMCopy ; $4dde
	ld hl, $d400 ; $4de1
	ld de, $9800 ; $4de4
	ld c, $08 ; $4de7
	call QueueVRAMCopy ; $4de9
	call AdvanceFrame ; $4dec
	wram_bank $06 ; $4def
	ld a, [$d151] ; $4df5
	and a, $fe ; $4df8
	ld [$d151], a ; $4dfa
	pop af ; $4dfd
	wram_bank ; $4dfe
	pop hl ; $4e02
	pop de ; $4e03
	pop bc ; $4e04
	pop af ; $4e05
	ret ; $4e06
	push af ; $4e07
	push bc ; $4e08
	push de ; $4e09
	push hl ; $4e0a
	ldh a, [hWramBank] ; $4e0b
	push af ; $4e0d
	wram_bank $06 ; $4e0e
	ld a, [$d151] ; $4e14
	or a, $01 ; $4e17
	ld [$d151], a ; $4e19
	call AdvanceFrame ; $4e1c
	call DrawExpScreenMessageBox ; $4e1f
	ld hl, ExtendModifierByteTable2 ; $4e22
	call DrawPositionedStringToTileBuffer ; $4e25
	ld hl, ExtendModifierByteGfx3 ; $4e28
	call DrawPositionedStringToTileBuffer ; $4e2b
	wram_bank $01 ; $4e2e
	ld hl, $d000 ; $4e34
	ld de, $b800 ; $4e37
	ld c, $08 ; $4e3a
	call QueueVRAMCopy ; $4e3c
	ld hl, $d400 ; $4e3f
	ld de, $9800 ; $4e42
	ld c, $08 ; $4e45
	call QueueVRAMCopy ; $4e47
	call AdvanceFrame ; $4e4a
	wram_bank $06 ; $4e4d
	ld a, [$d151] ; $4e53
	and a, $fe ; $4e56
	ld [$d151], a ; $4e58
	pop af ; $4e5b
	wram_bank ; $4e5c
	pop hl ; $4e60
	pop de ; $4e61
	pop bc ; $4e62
	pop af ; $4e63
	ret ; $4e64
ExpScreenNumberTask:
	wram_bank $06 ; $4e65
	ld hl, $d232 ; $4e6b
	ld a, [hl+] ; $4e6e
	ld h, [hl] ; $4e6f
	ld l, a ; $4e70
	ld de, $d24e ; $4e71
	ld a, $05 ; $4e74
	call FormatDecimalNumberUnsigned ; $4e76
	ld hl, w6_d234 ; $4e79
	ld d, [hl] ; $4e7c
	inc hl ; $4e7d
	ld e, [hl] ; $4e7e
	ld hl, $d24e ; $4e7f
	ld a, $05 ; $4e82
	call QueueNumberSpritesShifted ; $4e84
	wram_bank $06 ; $4e87
	push af ; $4e8d
	ld hl, wStoryModeNameOfMainCharacter ; $4e8e
	ld a, [wStoryCharacterSlot] ; $4e91
	or a, a ; $4e94
	jr z, .zero ; $4e95
	ld l, $40 ; $4e97
.zero:
	ld a, l ; $4e99
	add a, $18 ; $4e9a
	ld l, a ; $4e9c
	ld a, h ; $4e9d
	adc a, $00 ; $4e9e
	ld h, a ; $4ea0
	pop af ; $4ea1
	ld a, [hl] ; $4ea2
	cp a, $63 ; $4ea3
	ret z ; $4ea5
	ld a, [$d000] ; $4ea6
	and a, a ; $4ea9
	jp nz, .nonZero ; $4eaa
	ld a, [w6_d23b] ; $4ead
	and a, a ; $4eb0
	ret nz ; $4eb1
	ld hl, $d242 ; $4eb2
	ld a, [hl+] ; $4eb5
	ld h, [hl] ; $4eb6
	ld l, a ; $4eb7
	ld a, h ; $4eb8
	or a, l ; $4eb9
	jr z, .step2 ; $4eba
	ld de, $d244 ; $4ebc
	ld a, $05 ; $4ebf
	call FormatDecimalNumberUnsigned ; $4ec1
	ld hl, $d23e ; $4ec4
	ld d, [hl] ; $4ec7
	inc hl ; $4ec8
	ld e, [hl] ; $4ec9
	ld hl, $d244 ; $4eca
	ld a, $05 ; $4ecd
	call QueueNumberSprites ; $4ecf
	ret ; $4ed2
.step2:
	ld a, [w6_d23b] ; $4ed3
	and a, a ; $4ed6
	ret nz ; $4ed7
	ld a, [$d151] ; $4ed8
	or a, $80 ; $4edb
	ld [$d151], a ; $4edd
	ld a, $01 ; $4ee0
	ld [w6_d23b], a ; $4ee2
.nonZero:
	ld hl, $d23c ; $4ee5
	ld a, [hl+] ; $4ee8
	ld h, [hl] ; $4ee9
	ld l, a ; $4eea
	ld de, $d244 ; $4eeb
	ld a, $05 ; $4eee
	call FormatDecimalNumberUnsigned ; $4ef0
	ld hl, $d23e ; $4ef3
	ld d, [hl] ; $4ef6
	inc hl ; $4ef7
	ld e, [hl] ; $4ef8
	ld hl, $d244 ; $4ef9
	ld a, $05 ; $4efc
	call QueueNumberSprites ; $4efe
	ret ; $4f01
QueueNumberSpritesShifted:
	push af ; $4f02
	push de ; $4f03
	ld a, [w6_d23a] ; $4f04
	add a, d ; $4f07
	ld d, a ; $4f08
	push hl ; $4f09
	push bc ; $4f0a
	ld a, [hl] ; $4f0b
	sub a, $20 ; $4f0c
	jr z, .restore ; $4f0e
	sub a, $10 ; $4f10
	add a, a ; $4f12
	ld b, a ; $4f13
	ld a, [w6_d236] ; $4f14
	ld c, a ; $4f17
	ld a, b ; $4f18
	add a, c ; $4f19
	ld c, a ; $4f1a
	ld a, [w6_d237] ; $4f1b
	ld b, a ; $4f1e
	call QueueSprite ; $4f1f
.restore:
	pop bc ; $4f22
	pop hl ; $4f23
	pop de ; $4f24
	dec bc ; $4f25
	inc hl ; $4f26
	ld a, d ; $4f27
	add a, $08 ; $4f28
	ld d, a ; $4f2a
	pop af ; $4f2b
	dec a ; $4f2c
	jr nz, QueueNumberSpritesShifted ; $4f2d
	ret ; $4f2f
AdvanceExpGaugeFill:
	wram_bank $06 ; $4f30
	ld a, [w6_d238] ; $4f36
	and a, a ; $4f39
	jr nz, .updateRemaining ; $4f3a
	ld hl, $d232 ; $4f3c
	ld a, [hl+] ; $4f3f
	ld d, [hl] ; $4f40
	ld e, a ; $4f41
	inc de ; $4f42
	dec hl ; $4f43
	ld a, e ; $4f44
	ld [hl+], a ; $4f45
	ld [hl], d ; $4f46
	ld hl, w6_d230 ; $4f47
	ld a, [hl+] ; $4f4a
	ld h, [hl] ; $4f4b
	ld l, a ; $4f4c
	ld a, l ; $4f4d
	sub a, e ; $4f4e
	ld l, a ; $4f4f
	ld a, h ; $4f50
	sbc a, d ; $4f51
	ld h, a ; $4f52
	ld a, h ; $4f53
	or a, l ; $4f54
	jr nz, .updateRemaining ; $4f55
	ld a, $01 ; $4f57
	ld [w6_d238], a ; $4f59
.updateRemaining:
	ld hl, $d232 ; $4f5c
	ld a, [hl+] ; $4f5f
	ld b, [hl] ; $4f60
	ld c, a ; $4f61
	ld hl, $d23c ; $4f62
	ld a, [hl+] ; $4f65
	ld h, [hl] ; $4f66
	ld l, a ; $4f67
	ld a, l ; $4f68
	sub a, c ; $4f69
	ld l, a ; $4f6a
	ld a, h ; $4f6b
	sbc a, b ; $4f6c
	ld h, a ; $4f6d
	bit 7, h ; $4f6e
	jr nz, .clampToZero ; $4f70
	ld d, h ; $4f72
	ld e, l ; $4f73
	ld hl, $d242 ; $4f74
	ld a, e ; $4f77
	ld [hl+], a ; $4f78
	ld [hl], d ; $4f79
	ret ; $4f7a
.clampToZero:
	xor a, a ; $4f7b
	ld hl, $d242 ; $4f7c
	ld [hl+], a ; $4f7f
	ld [hl+], a ; $4f80
	ret ; $4f81
QueueNumberSprites:
	push af ; $4f82
	push de ; $4f83
	push hl ; $4f84
	push bc ; $4f85
	ld a, [hl] ; $4f86
	sub a, $20 ; $4f87
	jr z, .restore ; $4f89
	sub a, $10 ; $4f8b
	add a, a ; $4f8d
	ld b, a ; $4f8e
	ld a, [w6_d236] ; $4f8f
	ld c, a ; $4f92
	ld a, b ; $4f93
	add a, c ; $4f94
	ld c, a ; $4f95
	ld a, [w6_d237] ; $4f96
	ld b, a ; $4f99
	call QueueSprite ; $4f9a
.restore:
	pop bc ; $4f9d
	pop hl ; $4f9e
	pop de ; $4f9f
	dec bc ; $4fa0
	inc hl ; $4fa1
	ld a, d ; $4fa2
	add a, $08 ; $4fa3
	ld d, a ; $4fa5
	pop af ; $4fa6
	dec a ; $4fa7
	jr nz, QueueNumberSprites ; $4fa8
	ret ; $4faa
DrawExpScreenCaption:
	and a, a ; $4fab
	jr z, .caption0 ; $4fac
	dec a ; $4fae
	jr z, .caption1 ; $4faf
	dec a ; $4fb1
	jr z, .caption2 ; $4fb2
	dec a ; $4fb4
	jr z, .caption3 ; $4fb5
	dec a ; $4fb7
	jr z, .caption4 ; $4fb8
	dec a ; $4fba
	jp z, .caption5 ; $4fbb
	ret ; $4fbe
.caption0:
	ld hl, Text_31_238 ; $4fbf
	call LoadDialogueTextToBuffer ; $4fc2
	wram_bank $01 ; $4fc5
	ld hl, $d800 ; $4fcb
	ld bc, $0302 ; $4fce
	ld e, $01 ; $4fd1
	call DrawStringToTileBuffer ; $4fd3
	ret ; $4fd6
.caption1:
	ld hl, Text_31_239 ; $4fd7
	call LoadDialogueTextToBuffer ; $4fda
	wram_bank $01 ; $4fdd
	ld hl, $d800 ; $4fe3
	ld bc, $0101 ; $4fe6
	ld e, $01 ; $4fe9
	call DrawStringToTileBuffer ; $4feb
	ld hl, Text_31_240 ; $4fee
	call LoadDialogueTextToBuffer ; $4ff1
	ld hl, $d800 ; $4ff4
	ld bc, $0103 ; $4ff7
	ld e, $01 ; $4ffa
	call DrawStringToTileBuffer ; $4ffc
	ret ; $4fff
.caption2:
	ld hl, Text_31_241 ; $5000
	call LoadDialogueTextToBuffer ; $5003
	wram_bank $01 ; $5006
	ld hl, $d800 ; $500c
	ld bc, $0110 ; $500f
	ld e, $01 ; $5012
	call DrawStringToTileBuffer ; $5014
	ret ; $5017
.caption3:
	wram_bank $03 ; $5018
	ld hl, $04f2 ; $501e
	ld de, w3_d82b ; $5021
	ld c, $20 ; $5024
	farcall RenderProportionalTextAt ; $5026
	sound $73 ; $5029
	ret ; $502b
.caption4:
	ld hl, Text_31_243 ; $502c
	call LoadDialogueTextToBuffer ; $502f
	wram_bank $01 ; $5032
	ld hl, $d800 ; $5038
	ld bc, $0302 ; $503b
	ld e, $01 ; $503e
	call DrawStringToTileBuffer ; $5040
	ret ; $5043
.caption5:
	sound $00 ; $5044
	ld hl, Text_31_244 ; $5046
	call LoadDialogueTextToBuffer ; $5049
	wram_bank $01 ; $504c
	ld hl, $d800 ; $5052
	ld bc, $0a10 ; $5055
	ld e, $01 ; $5058
	call DrawStringToTileBuffer ; $505a
	ret ; $505d
LoadDialogueTextToBuffer:
	wram_bank $05 ; $505e
	farcall FetchDialogueText ; $5064
	ld hl, wTextBuffer ; $5067
	ld de, $d800 ; $506a
.copyLoop:
	wram_bank $05 ; $506d
	ld b, [hl] ; $5073
	wram_bank $01 ; $5074
	ld a, b ; $507a
	ld [de], a ; $507b
	inc hl ; $507c
	inc de ; $507d
	and a, a ; $507e
	jr nz, .copyLoop ; $507f
	ret ; $5081
ResetCharDataScreenAnim:
	push af ; $5082
	push bc ; $5083
	push de ; $5084
	push hl ; $5085
	ldh a, [hWramBank] ; $5086
	push af ; $5088
	wram_bank $06 ; $5089
	xor a, a ; $508f
	ld [$d000], a ; $5090
	pop af ; $5093
	wram_bank ; $5094
	pop hl ; $5098
	pop de ; $5099
	pop bc ; $509a
	pop af ; $509b
	push af ; $509c
	push bc ; $509d
	push de ; $509e
	push hl ; $509f
	ldh a, [hWramBank] ; $50a0
	push af ; $50a2
	ld a, $01 ; $50a3
	call ShowExpGainScreen ; $50a5
	wram_bank $06 ; $50a8
	ld a, [w6_d23b] ; $50ae
	and a, a ; $50b1
	jr z, .restore ; $50b2
	wram_bank $06 ; $50b4
	ld a, $01 ; $50ba
	ld [$d000], a ; $50bc
	ld a, $01 ; $50bf
	ld de, $0000 ; $50c1
	ld h, $04 ; $50c4
	call ShowExpGainScreen ; $50c6
.restore:
	pop af ; $50c9
	wram_bank ; $50ca
	pop hl ; $50ce
	pop de ; $50cf
	pop bc ; $50d0
	pop af ; $50d1
	ret ; $50d2
DrawExpBonusMessage:
	push af ; $50d3
	call DrawExpScreenMessageBox ; $50d4
	pop af ; $50d7
	cp a, $01 ; $50d8
	jp z, .eq01 ; $50da
	cp a, $02 ; $50dd
	jp z, .eq02 ; $50df
	cp a, $03 ; $50e2
	jp z, .eq03 ; $50e4
	cp a, $14 ; $50e7
	jp z, .eq14 ; $50e9
	cp a, $15 ; $50ec
	jp z, .eq15 ; $50ee
	cp a, $16 ; $50f1
	jp z, .eq16 ; $50f3
	cp a, $17 ; $50f6
	jp z, .eq17 ; $50f8
	cp a, $18 ; $50fb
	jp z, .eq18 ; $50fd
	cp a, $19 ; $5100
	jp z, .eq19 ; $5102
	cp a, $1a ; $5105
	jp z, .eq1a ; $5107
	cp a, $1b ; $510a
	jp z, .eq1b ; $510c
	cp a, $1c ; $510f
	jp z, .eq1c ; $5111
	cp a, $1d ; $5114
	jp z, .eq1d ; $5116
	cp a, $1e ; $5119
	jp z, .eq1e ; $511b
	jp .loadDialogueTextToBuffer ; $511e
.eq01:
	ld hl, Text_31_245 ; $5121
	call LoadDialogueTextToBuffer ; $5124
	wram_bank $01 ; $5127
	ld hl, $d800 ; $512d
	ld bc, $0201 ; $5130
	ld e, $01 ; $5133
	call DrawStringToTileBuffer ; $5135
	jp .loadDialogueTextToBuffer2 ; $5138
.eq02:
	ld hl, Text_31_246 ; $513b
	call LoadDialogueTextToBuffer ; $513e
	wram_bank $01 ; $5141
	ld hl, $d800 ; $5147
	ld bc, $0201 ; $514a
	ld e, $01 ; $514d
	call DrawStringToTileBuffer ; $514f
	jp .loadDialogueTextToBuffer2 ; $5152
.eq03:
	ld hl, Text_31_247 ; $5155
	call LoadDialogueTextToBuffer ; $5158
	wram_bank $01 ; $515b
	ld hl, $d800 ; $5161
	ld bc, $0201 ; $5164
	ld e, $01 ; $5167
	call DrawStringToTileBuffer ; $5169
	jp .loadDialogueTextToBuffer2 ; $516c
.eq14:
	ld hl, Text_31_248 ; $516f
	call LoadDialogueTextToBuffer ; $5172
	wram_bank $01 ; $5175
	ld hl, $d800 ; $517b
	ld bc, $0201 ; $517e
	ld e, $01 ; $5181
	call DrawStringToTileBuffer ; $5183
	ld hl, Text_30_31 ; $5186
	call LoadDialogueTextToBuffer ; $5189
	wram_bank $01 ; $518c
	ld hl, $d800 ; $5192
	ld bc, $0601 ; $5195
	ld e, $01 ; $5198
	call DrawStringToTileBuffer ; $519a
	ld hl, Text_31_249 ; $519d
	call LoadDialogueTextToBuffer ; $51a0
	wram_bank $01 ; $51a3
	ld hl, $d800 ; $51a9
	ld bc, $0901 ; $51ac
	ld e, $01 ; $51af
	call DrawStringToTileBuffer ; $51b1
	jp .loadDialogueTextToBuffer2 ; $51b4
.eq15:
	ld hl, Text_31_248 ; $51b7
	call LoadDialogueTextToBuffer ; $51ba
	wram_bank $01 ; $51bd
	ld hl, $d800 ; $51c3
	ld bc, $0201 ; $51c6
	ld e, $01 ; $51c9
	call DrawStringToTileBuffer ; $51cb
	ld hl, Text_30_32 ; $51ce
	call LoadDialogueTextToBuffer ; $51d1
	wram_bank $01 ; $51d4
	ld hl, $d800 ; $51da
	ld bc, $0601 ; $51dd
	ld e, $01 ; $51e0
	call DrawStringToTileBuffer ; $51e2
	ld hl, Text_31_249 ; $51e5
	call LoadDialogueTextToBuffer ; $51e8
	wram_bank $01 ; $51eb
	ld hl, $d800 ; $51f1
	ld bc, $0a01 ; $51f4
	ld e, $01 ; $51f7
	call DrawStringToTileBuffer ; $51f9
	jp .loadDialogueTextToBuffer2 ; $51fc
.eq16:
	ld hl, Text_31_248 ; $51ff
	call LoadDialogueTextToBuffer ; $5202
	wram_bank $01 ; $5205
	ld hl, $d800 ; $520b
	ld bc, $0201 ; $520e
	ld e, $01 ; $5211
	call DrawStringToTileBuffer ; $5213
	ld hl, Text_30_33 ; $5216
	call LoadDialogueTextToBuffer ; $5219
	wram_bank $01 ; $521c
	ld hl, $d800 ; $5222
	ld bc, $0601 ; $5225
	ld e, $01 ; $5228
	call DrawStringToTileBuffer ; $522a
	ld hl, Text_31_249 ; $522d
	call LoadDialogueTextToBuffer ; $5230
	wram_bank $01 ; $5233
	ld hl, $d800 ; $5239
	ld bc, $0a01 ; $523c
	ld e, $01 ; $523f
	call DrawStringToTileBuffer ; $5241
	jp .loadDialogueTextToBuffer2 ; $5244
.eq17:
	ld hl, Text_31_248 ; $5247
	call LoadDialogueTextToBuffer ; $524a
	wram_bank $01 ; $524d
	ld hl, $d800 ; $5253
	ld bc, $0201 ; $5256
	ld e, $01 ; $5259
	call DrawStringToTileBuffer ; $525b
	ld hl, Text_30_34 ; $525e
	call LoadDialogueTextToBuffer ; $5261
	wram_bank $01 ; $5264
	ld hl, $d800 ; $526a
	ld bc, $0601 ; $526d
	ld e, $01 ; $5270
	call DrawStringToTileBuffer ; $5272
	ld hl, Text_31_249 ; $5275
	call LoadDialogueTextToBuffer ; $5278
	wram_bank $01 ; $527b
	ld hl, $d800 ; $5281
	ld bc, $0901 ; $5284
	ld e, $01 ; $5287
	call DrawStringToTileBuffer ; $5289
	jp .loadDialogueTextToBuffer2 ; $528c
.eq18:
	ld hl, Text_31_248 ; $528f
	call LoadDialogueTextToBuffer ; $5292
	wram_bank $01 ; $5295
	ld hl, $d800 ; $529b
	ld bc, $0201 ; $529e
	ld e, $01 ; $52a1
	call DrawStringToTileBuffer ; $52a3
	ld hl, Text_30_35 ; $52a6
	call LoadDialogueTextToBuffer ; $52a9
	wram_bank $01 ; $52ac
	ld hl, $d800 ; $52b2
	ld bc, $0601 ; $52b5
	ld e, $01 ; $52b8
	call DrawStringToTileBuffer ; $52ba
	ld hl, Text_31_249 ; $52bd
	call LoadDialogueTextToBuffer ; $52c0
	wram_bank $01 ; $52c3
	ld hl, $d800 ; $52c9
	ld bc, $0901 ; $52cc
	ld e, $01 ; $52cf
	call DrawStringToTileBuffer ; $52d1
	jp .loadDialogueTextToBuffer2 ; $52d4
.eq19:
	ld hl, Text_31_248 ; $52d7
	call LoadDialogueTextToBuffer ; $52da
	wram_bank $01 ; $52dd
	ld hl, $d800 ; $52e3
	ld bc, $0201 ; $52e6
	ld e, $01 ; $52e9
	call DrawStringToTileBuffer ; $52eb
	ld hl, Text_30_36 ; $52ee
	call LoadDialogueTextToBuffer ; $52f1
	wram_bank $01 ; $52f4
	ld hl, $d800 ; $52fa
	ld bc, $0601 ; $52fd
	ld e, $01 ; $5300
	call DrawStringToTileBuffer ; $5302
	ld hl, Text_31_249 ; $5305
	call LoadDialogueTextToBuffer ; $5308
	wram_bank $01 ; $530b
	ld hl, $d800 ; $5311
	ld bc, $0a01 ; $5314
	ld e, $01 ; $5317
	call DrawStringToTileBuffer ; $5319
	jp .loadDialogueTextToBuffer2 ; $531c
.eq1a:
	ld hl, Text_31_248 ; $531f
	call LoadDialogueTextToBuffer ; $5322
	wram_bank $01 ; $5325
	ld hl, $d800 ; $532b
	ld bc, $0201 ; $532e
	ld e, $01 ; $5331
	call DrawStringToTileBuffer ; $5333
	ld hl, Text_30_37 ; $5336
	call LoadDialogueTextToBuffer ; $5339
	wram_bank $01 ; $533c
	ld hl, $d800 ; $5342
	ld bc, $0601 ; $5345
	ld e, $01 ; $5348
	call DrawStringToTileBuffer ; $534a
	ld hl, Text_31_249 ; $534d
	call LoadDialogueTextToBuffer ; $5350
	wram_bank $01 ; $5353
	ld hl, $d800 ; $5359
	ld bc, $0a01 ; $535c
	ld e, $01 ; $535f
	call DrawStringToTileBuffer ; $5361
	jp .loadDialogueTextToBuffer2 ; $5364
.eq1b:
	ld hl, Text_31_248 ; $5367
	call LoadDialogueTextToBuffer ; $536a
	wram_bank $01 ; $536d
	ld hl, $d800 ; $5373
	ld bc, $0201 ; $5376
	ld e, $01 ; $5379
	call DrawStringToTileBuffer ; $537b
	ld hl, Text_30_38 ; $537e
	call LoadDialogueTextToBuffer ; $5381
	wram_bank $01 ; $5384
	ld hl, $d800 ; $538a
	ld bc, $0601 ; $538d
	ld e, $01 ; $5390
	call DrawStringToTileBuffer ; $5392
	ld hl, Text_31_249 ; $5395
	call LoadDialogueTextToBuffer ; $5398
	wram_bank $01 ; $539b
	ld hl, $d800 ; $53a1
	ld bc, $0901 ; $53a4
	ld e, $01 ; $53a7
	call DrawStringToTileBuffer ; $53a9
	jp .loadDialogueTextToBuffer2 ; $53ac
.eq1c:
	ld hl, Text_31_248 ; $53af
	call LoadDialogueTextToBuffer ; $53b2
	wram_bank $01 ; $53b5
	ld hl, $d800 ; $53bb
	ld bc, $0201 ; $53be
	ld e, $01 ; $53c1
	call DrawStringToTileBuffer ; $53c3
	ld hl, Text_30_39 ; $53c6
	call LoadDialogueTextToBuffer ; $53c9
	wram_bank $01 ; $53cc
	ld hl, $d800 ; $53d2
	ld bc, $0601 ; $53d5
	ld e, $01 ; $53d8
	call DrawStringToTileBuffer ; $53da
	ld hl, Text_31_249 ; $53dd
	call LoadDialogueTextToBuffer ; $53e0
	wram_bank $01 ; $53e3
	ld hl, $d800 ; $53e9
	ld bc, $0901 ; $53ec
	ld e, $01 ; $53ef
	call DrawStringToTileBuffer ; $53f1
	jp .loadDialogueTextToBuffer2 ; $53f4
.eq1d:
	ld hl, Text_31_248 ; $53f7
	call LoadDialogueTextToBuffer ; $53fa
	wram_bank $01 ; $53fd
	ld hl, $d800 ; $5403
	ld bc, $0201 ; $5406
	ld e, $01 ; $5409
	call DrawStringToTileBuffer ; $540b
	ld hl, Text_30_40 ; $540e
	call LoadDialogueTextToBuffer ; $5411
	wram_bank $01 ; $5414
	ld hl, $d800 ; $541a
	ld bc, $0601 ; $541d
	ld e, $01 ; $5420
	call DrawStringToTileBuffer ; $5422
	ld hl, Text_31_249 ; $5425
	call LoadDialogueTextToBuffer ; $5428
	wram_bank $01 ; $542b
	ld hl, $d800 ; $5431
	ld bc, $0a01 ; $5434
	ld e, $01 ; $5437
	call DrawStringToTileBuffer ; $5439
	jp .loadDialogueTextToBuffer2 ; $543c
.eq1e:
	ld hl, Text_31_248 ; $543f
	call LoadDialogueTextToBuffer ; $5442
	wram_bank $01 ; $5445
	ld hl, $d800 ; $544b
	ld bc, $0201 ; $544e
	ld e, $01 ; $5451
	call DrawStringToTileBuffer ; $5453
	ld hl, Text_30_41 ; $5456
	call LoadDialogueTextToBuffer ; $5459
	wram_bank $01 ; $545c
	ld hl, $d800 ; $5462
	ld bc, $0601 ; $5465
	ld e, $01 ; $5468
	call DrawStringToTileBuffer ; $546a
	ld hl, Text_31_249 ; $546d
	call LoadDialogueTextToBuffer ; $5470
	wram_bank $01 ; $5473
	ld hl, $d800 ; $5479
	ld bc, $0b01 ; $547c
	ld e, $01 ; $547f
	call DrawStringToTileBuffer ; $5481
	jr .loadDialogueTextToBuffer2 ; $5484
.loadDialogueTextToBuffer:
	ld hl, Text_31_248 ; $5486
	call LoadDialogueTextToBuffer ; $5489
	wram_bank $01 ; $548c
	ld hl, $d800 ; $5492
	ld bc, $0201 ; $5495
	ld e, $01 ; $5498
	call DrawStringToTileBuffer ; $549a
	ld hl, Text_30_42 ; $549d
	call LoadDialogueTextToBuffer ; $54a0
	wram_bank $01 ; $54a3
	ld hl, $d800 ; $54a9
	ld bc, $0601 ; $54ac
	ld e, $01 ; $54af
	call DrawStringToTileBuffer ; $54b1
	ld hl, Text_31_249 ; $54b4
	call LoadDialogueTextToBuffer ; $54b7
	wram_bank $01 ; $54ba
	ld hl, $d800 ; $54c0
	ld bc, $0901 ; $54c3
	ld e, $01 ; $54c6
	call DrawStringToTileBuffer ; $54c8
	jr .loadDialogueTextToBuffer2 ; $54cb
.loadDialogueTextToBuffer2:
	ld hl, Text_31_244 ; $54cd
	call LoadDialogueTextToBuffer ; $54d0
	wram_bank $01 ; $54d3
	ld hl, $d800 ; $54d9
	ld bc, $0203 ; $54dc
	ld e, $01 ; $54df
	call DrawStringToTileBuffer ; $54e1
	wram_bank $06 ; $54e4
	ld a, [$d151] ; $54ea
	or a, $01 ; $54ed
	ld [$d151], a ; $54ef
	call AdvanceFrame ; $54f2
	wram_bank $01 ; $54f5
	ld hl, $d000 ; $54fb
	ld de, $b800 ; $54fe
	ld c, $08 ; $5501
	call QueueVRAMCopy ; $5503
	ld hl, $d400 ; $5506
	ld de, $9800 ; $5509
	ld c, $08 ; $550c
	call QueueVRAMCopy ; $550e
	call AdvanceFrame ; $5511
	wram_bank $06 ; $5514
	ld a, [$d151] ; $551a
	and a, $fe ; $551d
	ld [$d151], a ; $551f
	ret ; $5522
Padding_1a_5523:
	; $5523, 13 bytes (fill)
	ds 13, $00
ExpScreenGfx0:
	INCBIN "data/bank_01a/d_5530.bin" ; $5530, 1712 bytes
ExpScreenGfx1:
	INCBIN "data/bank_01a/d_5be0.bin" ; $5be0, 576 bytes
ExpScreenGfx2:
	INCBIN "data/bank_01a/d_5e20.bin" ; $5e20, 576 bytes
ExpScreenGfx3:
	INCBIN "data/bank_01a/d_6060.bin" ; $6060, 576 bytes
ExpScreenGfx4:
	INCBIN "data/bank_01a/d_62a0.bin" ; $62a0, 396 bytes
StatChangeArrows0:
	INCBIN "data/bank_01a/d_642c.bin" ; $642c, 16 bytes
StatChangeArrows1:
	INCBIN "data/bank_01a/d_643c.bin" ; $643c, 24 bytes
StatChangeArrows2:
	INCBIN "data/bank_01a/d_6454.bin" ; $6454, 16 bytes
StatChangeArrows3:
	INCBIN "data/bank_01a/d_6464.bin" ; $6464, 16 bytes
StatChangeArrows4:
	INCBIN "data/bank_01a/d_6474.bin" ; $6474, 16 bytes
StatChangeArrows5:
	INCBIN "data/bank_01a/d_6484.bin" ; $6484, 92 bytes
ExpScreenGfxPalettes0:
	INCBIN "data/bank_01a/d_64e0.bin" ; $64e0, 368 bytes
ExpScreenGfx5:
	INCBIN "data/bank_01a/d_6650.bin" ; $6650, 24 bytes
ExpScreenGfxPalettes1:
	INCBIN "data/bank_01a/d_6668.bin" ; $6668, 24 bytes
ExpScreenGfx6:
	INCBIN "data/bank_01a/d_6680.bin" ; $6680, 72 bytes
ExpScreenGfx7:
	INCBIN "data/bank_01a/d_66c8.bin" ; $66c8, 73 bytes
ExpScreenGfxPalettes2:
	INCBIN "data/bank_01a/d_6711.bin" ; $6711, 16 bytes
ExpScreenGfxPalettes3:
	INCBIN "data/bank_01a/d_6721.bin" ; $6721, 8 bytes
ExpScreenGfx8:
	INCBIN "data/bank_01a/d_6729.bin" ; $6729, 171 bytes
RunDebugCharViewer:
	xor a, a ; $67d4
	ld [wDebugCharViewerPage], a ; $67d5
	ld [wDebugCharViewerIndex], a ; $67d8
.loop:
	call ClearFrameTasks ; $67db
	call DisableLCDSafely ; $67de
	farcall LoadMenuFontGfx ; $67e1
	xor a, a ; $67e4
	ldh [hScrollX], a ; $67e5
	ldh [hScrollY], a ; $67e7
	ld [wCameraX], a ; $67e9
	ld [wCameraX + 1], a ; $67ec
	ld [wCameraY], a ; $67ef
	ld [wCameraY + 1], a ; $67f2
	ld a, $90 ; $67f5
	ldh [rWY], a ; $67f7
	call ClearSpriteQueue ; $67f9
	farcall InitActorEngine ; $67fc
	farcall ResetTextWindowState ; $67ff
	call RunCharViewerSelectGrid ; $6802
	cp a, $ff ; $6805
	jr z, .eqff ; $6807
	ld c, $40 ; $6809
	call BeginFadeOut ; $680b
	call WaitFadeEnd ; $680e
	call DisableLCDSafely ; $6811
	call InitCharViewerState ; $6814
	call LoadCharViewerScreen ; $6817
	call SetupCharViewerScene ; $681a
	call EnableLCD ; $681d
	ld a, $01 ; $6820
	ld hl, DrawCharViewerCursorSprite ; $6822
	call RegisterFrameTask ; $6825
	call ApplyCharViewerPalette ; $6828
	call RefreshCharViewerSelection ; $682b
	call AdvanceFrame ; $682e
	wram_bank $06 ; $6831
	ld a, [$d002] ; $6837
	ld de, $8700 ; $683a
	farcall LoadOnCourtCharTilesA ; $683d
	call AdvanceFrame ; $6840
	script_fade_in $10 ; $6843
	call WaitFadeEnd ; $6848
	call RunCharViewerInputLoop ; $684b
	ld hl, DrawCharViewerCursorSprite ; $684e
	call UnregisterFrameTask ; $6851
.eqff:
	ld c, $10 ; $6854
	call BeginFadeOut ; $6856
	call WaitFadeEnd ; $6859
	call DisableLCDSafely ; $685c
	farcall LoadMenuFontGfx ; $685f
	call EnableLCD ; $6862
	call AdvanceFrame ; $6865
	jp .loop ; $6868
	ret ; $686b
RunCharViewerSelectGrid:
	wram_bank $06 ; $686c
	xor a, a ; $6872
	ld hl, Palette_1a_70d9 ; $6873
	ld de, $0008 ; $6876
	call LoadPaletteShadow ; $6879
	ld hl, Palette_1a_70d9 ; $687c
	ld de, $0808 ; $687f
	call LoadPaletteShadow ; $6882
	wram_bank $01 ; $6885
	ld hl, CharViewerScreenGfx0 ; $688b
	ld de, $d000 ; $688e
	call DecompressData ; $6891
	ld hl, $d000 ; $6894
	ld de, $b000 ; $6897
	ld c, $80 ; $689a
	call QueueVRAMCopy ; $689c
	ld hl, $d800 ; $689f
	ld de, $a800 ; $68a2
	ld c, $80 ; $68a5
	call QueueVRAMCopy ; $68a7
	call LoadCharViewerGridTilemap ; $68aa
	ld a, [wDebugCharViewerPage] ; $68ad
	call DrawCharViewerPageNames ; $68b0
	wram_bank $03 ; $68b3
	ld hl, $d000 ; $68b9
	ld de, $9800 ; $68bc
	ld c, $24 ; $68bf
	call QueueVRAMCopy ; $68c1
	wram_bank $02 ; $68c4
	ld hl, $d000 ; $68ca
	ld de, $b800 ; $68cd
	ld c, $24 ; $68d0
	call QueueVRAMCopy ; $68d2
	call EnableLCD ; $68d5
	ld a, $01 ; $68d8
	ld hl, DrawCharViewerGridCursor ; $68da
	call RegisterFrameTask ; $68dd
	script_fade_in $10 ; $68e0
	call WaitFadeEnd ; $68e5
.loop:
	wram_bank $06 ; $68e8
	call AdvanceFrame ; $68ee
	ldh a, [hInputPressed] ; $68f1
	bit PADB_UP, a ; $68f3
	jr nz, .checkDebugCharViewerIndex ; $68f5
	bit 7, a ; $68f7
	jr nz, .checkDebugCharViewerIndex2 ; $68f9
	bit 5, a ; $68fb
	jr nz, .checkDebugCharViewerIndex3 ; $68fd
	bit 4, a ; $68ff
	jr nz, .checkDebugCharViewerIndex5 ; $6901
	bit 0, a ; $6903
	jp nz, .bit0Set ; $6905
	bit 1, a ; $6908
	jp nz, .bit1Set ; $690a
	jr .loop ; $690d
	ld c, $10 ; $690f
	call BeginFadeOut ; $6911
	call WaitFadeEnd ; $6914
	call DisableLCDSafely ; $6917
	ret ; $691a
.checkDebugCharViewerIndex:
	ld a, [wDebugCharViewerIndex] ; $691b
	dec a ; $691e
	cp a, $ff ; $691f
	jr z, .eqff ; $6921
	cp a, $07 ; $6923
	jr nz, .store ; $6925
	ld a, $0f ; $6927
	jr .store ; $6929
.eqff:
	ld a, $07 ; $692b
.store:
	ld [wDebugCharViewerIndex], a ; $692d
	sound $5e ; $6930
	jr .loop ; $6932
.checkDebugCharViewerIndex2:
	ld a, [wDebugCharViewerIndex] ; $6934
	inc a ; $6937
	cp a, $08 ; $6938
	jr z, .eq08 ; $693a
	cp a, $10 ; $693c
	jr nz, .store2 ; $693e
	ld a, $08 ; $6940
	jr .store2 ; $6942
.eq08:
	xor a, a ; $6944
.store2:
	ld [wDebugCharViewerIndex], a ; $6945
	sound $5e ; $6948
	jr .loop ; $694a
.checkDebugCharViewerIndex3:
	ld a, [wDebugCharViewerIndex] ; $694c
	sub a, $08 ; $694f
	jr nc, .store3 ; $6951
	add a, $10 ; $6953
	ld [wDebugCharViewerIndex], a ; $6955
	ld a, [wDebugCharViewerPage] ; $6958
	or a, a ; $695b
	jr z, .checkDebugCharViewerIndex4 ; $695c
	dec a ; $695e
	ld [wDebugCharViewerPage], a ; $695f
	sound $5e ; $6962
	jr .loadCharViewerGridTilemap ; $6964
.store3:
	ld [wDebugCharViewerIndex], a ; $6966
	sound $5e ; $6969
	jp .loop ; $696b
.checkDebugCharViewerIndex4:
	ld a, [wDebugCharViewerIndex] ; $696e
	sub a, $08 ; $6971
	ld [wDebugCharViewerIndex], a ; $6973
	jp .loop ; $6976
.checkDebugCharViewerIndex5:
	ld a, [wDebugCharViewerIndex] ; $6979
	add a, $08 ; $697c
	cp a, $10 ; $697e
	jr c, .store4 ; $6980
	sub a, $10 ; $6982
	ld [wDebugCharViewerIndex], a ; $6984
	ld a, [wDebugCharViewerPage] ; $6987
	cp a, $01 ; $698a
	jr z, .checkDebugCharViewerIndex6 ; $698c
	inc a ; $698e
	ld [wDebugCharViewerPage], a ; $698f
	sound $5e ; $6992
	jr .loadCharViewerGridTilemap ; $6994
.store4:
	ld [wDebugCharViewerIndex], a ; $6996
	sound $5e ; $6999
	jp .loop ; $699b
.checkDebugCharViewerIndex6:
	ld a, [wDebugCharViewerIndex] ; $699e
	add a, $08 ; $69a1
	ld [wDebugCharViewerIndex], a ; $69a3
	jp .loop ; $69a6
.loadCharViewerGridTilemap:
	push af ; $69a9
	call LoadCharViewerGridTilemap ; $69aa
	pop af ; $69ad
	call DrawCharViewerPageNames ; $69ae
	wram_bank $03 ; $69b1
	ld hl, $d020 ; $69b7
	ld de, $9820 ; $69ba
	ld c, $20 ; $69bd
	call QueueVRAMCopy ; $69bf
	call AdvanceFrame ; $69c2
	jp .loop ; $69c5
.bit0Set:
	ld hl, DrawCharViewerGridCursor ; $69c8
	call UnregisterFrameTask ; $69cb
	sound $5f ; $69ce
	ld a, [wDebugCharViewerPage] ; $69d0
	rlca ; $69d3
	rlca ; $69d4
	rlca ; $69d5
	rlca ; $69d6
	ld b, a ; $69d7
	ld a, [wDebugCharViewerIndex] ; $69d8
	add a, b ; $69db
	ld [$d002], a ; $69dc
	ret ; $69df
.bit1Set:
	ld hl, DrawCharViewerGridCursor ; $69e0
	call UnregisterFrameTask ; $69e3
	sound $62 ; $69e6
	ld a, $ff ; $69e8
	ret ; $69ea
LoadCharViewerGridTilemap:
	wram_bank $01 ; $69eb
	ld hl, CharViewerGridTilemap0 ; $69f1
	ld de, $d000 ; $69f4
	call DecompressData ; $69f7
	ld hl, $d000 ; $69fa
	ld bc, $0240 ; $69fd
	call CopyBank1ToBank3Buffer ; $6a00
	wram_bank $01 ; $6a03
	ld hl, CharViewerGridTilemap1 ; $6a09
	ld de, $d000 ; $6a0c
	call DecompressData ; $6a0f
	ld hl, $d000 ; $6a12
	ld bc, $0240 ; $6a15
	call CopyBank1ToBank2Buffer ; $6a18
	wram_bank $02 ; $6a1b
	ld hl, $d021 ; $6a21
	ld c, $10 ; $6a24
.loop:
	push hl ; $6a26
	ld b, $12 ; $6a27
.loopB:
	xor a, a ; $6a29
	ld [hl+], a ; $6a2a
	dec b ; $6a2b
	jr nz, .loopB ; $6a2c
	pop hl ; $6a2e
	ld a, $20 ; $6a2f
	add a, l ; $6a31
	ld l, a ; $6a32
	jr nc, .gotPtr ; $6a33
	inc h ; $6a35
.gotPtr:
	dec c ; $6a36
	jr nz, .loop ; $6a37
	ret ; $6a39
DrawCharViewerPageNames:
	or a, a ; $6a3a
	jr z, .zero ; $6a3b
	dec a ; $6a3d
	jr z, .countDone ; $6a3e
	dec a ; $6a40
	jr z, .countDone2 ; $6a41
	ret ; $6a43
.zero:
	wram_bank $03 ; $6a44
	ld hl, Text_30_27 ; $6a4a
	ld de, $d043 ; $6a4d
	ld c, $08 ; $6a50
	call RenderTextColumnToBuffer64 ; $6a52
	ld hl, Text_30_35 ; $6a55
	ld de, $d04b ; $6a58
	ld c, $08 ; $6a5b
	call RenderTextColumnToBuffer64 ; $6a5d
	ret ; $6a60
.countDone:
	wram_bank $03 ; $6a61
	ld hl, Text_30_43 ; $6a67
	ld de, $d043 ; $6a6a
	ld c, $08 ; $6a6d
	call RenderTextColumnToBuffer64 ; $6a6f
	ld hl, Text_30_51 ; $6a72
	ld de, $d04b ; $6a75
	ld c, $08 ; $6a78
	call RenderTextColumnToBuffer64 ; $6a7a
	ret ; $6a7d
.countDone2:
	wram_bank $03 ; $6a7e
	ld hl, Text_30_59 ; $6a84
	ld de, $d043 ; $6a87
	ld c, $08 ; $6a8a
	call RenderTextColumnToBuffer64 ; $6a8c
	ld hl, Text_30_67 ; $6a8f
	ld de, $d04b ; $6a92
	ld c, $08 ; $6a95
	call RenderTextColumnToBuffer64 ; $6a97
	ret ; $6a9a
RenderTextColumnToBuffer64:
	push bc ; $6a9b
	push de ; $6a9c
	push hl ; $6a9d
	ld c, $20 ; $6a9e
	farcall RenderTextToBuffer64 ; $6aa0
	pop hl ; $6aa3
	pop de ; $6aa4
	pop bc ; $6aa5
	dec c ; $6aa6
	ret z ; $6aa7
	inc hl ; $6aa8
	push hl ; $6aa9
	ld hl, $0040 ; $6aaa
	add hl, de ; $6aad
	ld d, h ; $6aae
	ld e, l ; $6aaf
	pop hl ; $6ab0
	jr RenderTextColumnToBuffer64 ; $6ab1
DrawCharViewerGridCursor:
	wram_bank $06 ; $6ab3
	ldh a, [hVBlankCounter] ; $6ab9
	and a, $1c ; $6abb
	jr z, .checkVBlankCounter ; $6abd
	ld a, [wDebugCharViewerPage] ; $6abf
	dec a ; $6ac2
	jr z, .queueSprite ; $6ac3
	dec a ; $6ac5
	jr z, .queueSprite ; $6ac6
	ld b, $0a ; $6ac8
	ld c, $86 ; $6aca
	ld de, $964a ; $6acc
	call QueueSprite ; $6acf
	jr .checkVBlankCounter ; $6ad2
	ld b, $0a ; $6ad4
	ld c, $84 ; $6ad6
	ld de, $0a4a ; $6ad8
	call QueueSprite ; $6adb
	ld b, $0a ; $6ade
	ld c, $86 ; $6ae0
	ld de, $964a ; $6ae2
	call QueueSprite ; $6ae5
	jr .checkVBlankCounter ; $6ae8
.queueSprite:
	ld b, $0a ; $6aea
	ld c, $84 ; $6aec
	ld de, $0a4a ; $6aee
	call QueueSprite ; $6af1
.checkVBlankCounter:
	ldh a, [hVBlankCounter] ; $6af4
	and a, $2a ; $6af6
	ret z ; $6af8
	ld a, [wDebugCharViewerIndex] ; $6af9
	rlca ; $6afc
	add a, LOW(Data_1a_6b0f) ; $6afd
	ld l, a ; $6aff
	adc a, HIGH(Data_1a_6b0f) ; $6b00
	sub a, l ; $6b02
	ld h, a ; $6b03
	ld a, [hl+] ; $6b04
	ld d, [hl] ; $6b05
	ld e, a ; $6b06
	ld b, $08 ; $6b07
	ld c, $88 ; $6b09
	call QueueSprite ; $6b0b
	ret ; $6b0e
Data_1a_6b0f:
	; $6b0f, 32 bytes (bytes:16)
	db $14, $13, $24, $13, $34, $13, $44, $13, $54, $13, $64, $13, $74, $13, $84, $13 ; 0x00
	db $14, $53, $24, $53, $34, $53, $44, $53, $54, $53, $64, $53, $74, $53, $84, $53 ; 0x10
LoadCharViewerScreen:
	call LoadCharViewerScreenGfx ; $6b2f
	wram_bank $03 ; $6b32
	ld hl, $d000 ; $6b38
	ld de, $9800 ; $6b3b
	ld c, $24 ; $6b3e
	call QueueVRAMCopy ; $6b40
	wram_bank $02 ; $6b43
	ld hl, $d000 ; $6b49
	ld de, $b800 ; $6b4c
	ld c, $24 ; $6b4f
	call QueueVRAMCopy ; $6b51
	ret ; $6b54
LoadCharViewerScreenGfx:
	ld hl, Palette_1a_70d9 ; $6b55
	ld de, $0008 ; $6b58
	call LoadPaletteShadow ; $6b5b
	wram_bank $01 ; $6b5e
	ld hl, CharViewerScreenGfx0 ; $6b64
	ld de, $d000 ; $6b67
	call DecompressData ; $6b6a
	ld hl, $d000 ; $6b6d
	ld de, $b000 ; $6b70
	ld c, $80 ; $6b73
	call QueueVRAMCopy ; $6b75
	ld hl, $d800 ; $6b78
	ld de, $a800 ; $6b7b
	ld c, $80 ; $6b7e
	call QueueVRAMCopy ; $6b80
	wram_bank $01 ; $6b83
	ld hl, CharViewerScreenGfx1 ; $6b89
	ld de, $d000 ; $6b8c
	call DecompressData ; $6b8f
	ld hl, $d000 ; $6b92
	ld bc, $0240 ; $6b95
	call CopyBank1ToBank3Buffer ; $6b98
	wram_bank $01 ; $6b9b
	ld hl, CharViewerScreenGfx2 ; $6ba1
	ld de, $d000 ; $6ba4
	call DecompressData ; $6ba7
	ld hl, $d000 ; $6baa
	ld bc, $0240 ; $6bad
	call CopyBank1ToBank2Buffer ; $6bb0
	wram_bank $02 ; $6bb3
	ld hl, $d1e1 ; $6bb9
	xor a, a ; $6bbc
	ld [hl+], a ; $6bbd
	ld [hl+], a ; $6bbe
	ld [hl+], a ; $6bbf
	ld [hl+], a ; $6bc0
	ld [hl+], a ; $6bc1
	ld [hl+], a ; $6bc2
	ld [hl+], a ; $6bc3
	ld [hl+], a ; $6bc4
	ld [hl+], a ; $6bc5
	ld [hl+], a ; $6bc6
	ld [hl+], a ; $6bc7
	ld [hl+], a ; $6bc8
	ld [hl+], a ; $6bc9
	ld [hl+], a ; $6bca
	ld [hl+], a ; $6bcb
	ld [hl+], a ; $6bcc
	ld hl, $d201 ; $6bcd
	ld [hl+], a ; $6bd0
	ld [hl+], a ; $6bd1
	ld [hl+], a ; $6bd2
	ld [hl+], a ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl+], a ; $6bd5
	ld [hl+], a ; $6bd6
	ld [hl+], a ; $6bd7
	ld [hl+], a ; $6bd8
	ld [hl+], a ; $6bd9
	ld [hl+], a ; $6bda
	ld [hl+], a ; $6bdb
	ld [hl+], a ; $6bdc
	ld [hl+], a ; $6bdd
	ld [hl+], a ; $6bde
	ld [hl+], a ; $6bdf
	ret ; $6be0
CopyBank1ToBank3Buffer:
	wram_bank $01 ; $6be1
	ld d, [hl] ; $6be7
	wram_bank $03 ; $6be8
	ld [hl], d ; $6bee
	inc hl ; $6bef
	dec bc ; $6bf0
	ld a, b ; $6bf1
	or a, c ; $6bf2
	jr nz, CopyBank1ToBank3Buffer ; $6bf3
	ret ; $6bf5
CopyBank1ToBank2Buffer:
	wram_bank $01 ; $6bf6
	ld d, [hl] ; $6bfc
	wram_bank $02 ; $6bfd
	ld [hl], d ; $6c03
	inc hl ; $6c04
	dec bc ; $6c05
	ld a, b ; $6c06
	or a, c ; $6c07
	jr nz, CopyBank1ToBank2Buffer ; $6c08
	ret ; $6c0a
InitCharViewerState:
	wram_bank $06 ; $6c0b
	xor a, a ; $6c11
	ld [$d001], a ; $6c12
	ld [$d000], a ; $6c15
	ld [$d003], a ; $6c18
	ld [w6_d005], a ; $6c1b
	ld a, [$d002] ; $6c1e
	farcall GetCharPaletteIndex ; $6c21
	ld [w6_d004], a ; $6c24
	ret ; $6c27
DrawCharViewerCursorSprite:
	wram_bank $06 ; $6c28
	ld a, [$d000] ; $6c2e
	or a, a ; $6c31
	jr nz, .nonZero ; $6c32
	ld a, [$d001] ; $6c34
	rlca ; $6c37
	add a, LOW(Data_1a_6c69) ; $6c38
	ld l, a ; $6c3a
	adc a, HIGH(Data_1a_6c69) ; $6c3b
	sub a, l ; $6c3d
	ld h, a ; $6c3e
	ld a, [hl+] ; $6c3f
	ld d, [hl] ; $6c40
	ld e, a ; $6c41
	jr .queueSprite ; $6c42
.nonZero:
	ld a, [$d001] ; $6c44
	rlca ; $6c47
	add a, LOW(Data_1a_6c95) ; $6c48
	ld l, a ; $6c4a
	adc a, HIGH(Data_1a_6c95) ; $6c4b
	sub a, l ; $6c4d
	ld h, a ; $6c4e
	ld a, [hl+] ; $6c4f
	ld d, [hl] ; $6c50
	ld e, a ; $6c51
.queueSprite:
	push de ; $6c52
	ldh a, [hVBlankCounter] ; $6c53
	ld b, $0d ; $6c55
	ld c, $80 ; $6c57
	call QueueSprite ; $6c59
	pop de ; $6c5c
	ld a, $08 ; $6c5d
	add a, d ; $6c5f
	ld d, a ; $6c60
	ld b, $0d ; $6c61
	ld c, $82 ; $6c63
	call QueueSprite ; $6c65
	ret ; $6c68
Data_1a_6c69:
	; $6c69, 44 bytes (bytes:16)
	db $50, $38, $50, $40, $50, $48, $50, $50, $50, $58, $50, $60, $50, $68, $50, $70 ; 0x00
	db $50, $78, $50, $80, $50, $88, $58, $38, $58, $40, $58, $48, $58, $50, $58, $58 ; 0x10
	db $58, $60, $58, $68, $58, $70, $58, $78, $58, $80, $58, $88 ; 0x20
Data_1a_6c95:
	INCBIN "data/bank_01a/d_6c95.bin" ; $6c95, 10 bytes
RunCharViewerInputLoop:
	call DrawCharViewerCharSprite ; $6c9f
	wram_bank $06 ; $6ca2
	call AdvanceFrame ; $6ca8
	ldh a, [hInputPressed] ; $6cab
	bit PADB_UP, a ; $6cad
	jr nz, .up ; $6caf
	bit 7, a ; $6cb1
	jr nz, .down ; $6cb3
	bit 5, a ; $6cb5
	jp nz, .left ; $6cb7
	bit 4, a ; $6cba
	jp nz, .right ; $6cbc
	bit 0, a ; $6cbf
	jp nz, .confirm ; $6cc1
	bit 1, a ; $6cc4
	jp nz, .exit ; $6cc6
	bit 3, a ; $6cc9
	jp nz, .prevPose ; $6ccb
	bit 2, a ; $6cce
	jp nz, .nextPose ; $6cd0
	jr RunCharViewerInputLoop ; $6cd3
.up:
	sound $5e ; $6cd5
	wram_bank $06 ; $6cd7
	ld a, [$d000] ; $6cdd
	or a, a ; $6ce0
	jr nz, .upWrapToChar ; $6ce1
	ld a, [$d001] ; $6ce3
	cp a, $0b ; $6ce6
	jr c, .upWrapToPalette ; $6ce8
	ld a, [$d001] ; $6cea
	sub a, $0b ; $6ced
	ld [$d001], a ; $6cef
	jp .refresh ; $6cf2
.upWrapToPalette:
	wram_bank $06 ; $6cf5
	ld a, [$d000] ; $6cfb
	xor a, $01 ; $6cfe
	ld [$d000], a ; $6d00
	ld a, [w6_d004] ; $6d03
	ld [$d001], a ; $6d06
	jp .refresh ; $6d09
.upWrapToChar:
	wram_bank $06 ; $6d0c
	ld a, [$d000] ; $6d12
	xor a, $01 ; $6d15
	ld [$d000], a ; $6d17
	ld a, [$d003] ; $6d1a
	ld [$d001], a ; $6d1d
	jp .refresh ; $6d20
.down:
	sound $5e ; $6d23
	wram_bank $06 ; $6d25
	ld a, [$d000] ; $6d2b
	or a, a ; $6d2e
	jr nz, .downWrapToChar ; $6d2f
	ld a, [$d001] ; $6d31
	cp a, $0b ; $6d34
	jr nc, .downWrapToPalette ; $6d36
	ld a, [$d001] ; $6d38
	add a, $0b ; $6d3b
	ld [$d001], a ; $6d3d
	jp .refresh ; $6d40
.downWrapToPalette:
	wram_bank $06 ; $6d43
	ld a, [$d000] ; $6d49
	xor a, $01 ; $6d4c
	ld [$d000], a ; $6d4e
	ld a, [w6_d004] ; $6d51
	ld [$d001], a ; $6d54
	jp .refresh ; $6d57
.downWrapToChar:
	wram_bank $06 ; $6d5a
	ld a, [$d000] ; $6d60
	xor a, $01 ; $6d63
	ld [$d000], a ; $6d65
	ld a, [$d003] ; $6d68
	ld [$d001], a ; $6d6b
	jp .refresh ; $6d6e
.left:
	sound $5e ; $6d71
	wram_bank $06 ; $6d73
	ld a, [$d000] ; $6d79
	or a, a ; $6d7c
	jr nz, .leftPalette ; $6d7d
	ld a, [$d001] ; $6d7f
	dec a ; $6d82
	ld [$d001], a ; $6d83
	cp a, $ff ; $6d86
	jr nz, .leftWrapRow ; $6d88
	ld a, $0a ; $6d8a
	ld [$d001], a ; $6d8c
	jp .refresh ; $6d8f
.leftWrapRow:
	cp a, $0a ; $6d92
	jp nz, .refresh ; $6d94
	ld a, $15 ; $6d97
	ld [$d001], a ; $6d99
	jp .refresh ; $6d9c
.leftPalette:
	ld a, [$d001] ; $6d9f
	dec a ; $6da2
	cp a, $ff ; $6da3
	jr nz, .storeLeftPalette ; $6da5
	ld a, $04 ; $6da7
.storeLeftPalette:
	ld [$d001], a ; $6da9
	jr .refresh ; $6dac
.right:
	sound $5e ; $6dae
	wram_bank $06 ; $6db0
	ld a, [$d000] ; $6db6
	or a, a ; $6db9
	jr nz, .rightPalette ; $6dba
	ld a, [$d001] ; $6dbc
	inc a ; $6dbf
	ld [$d001], a ; $6dc0
	cp a, $0b ; $6dc3
	jr nz, .rightWrapRow ; $6dc5
	xor a, a ; $6dc7
	ld [$d001], a ; $6dc8
.rightWrapRow:
	cp a, $16 ; $6dcb
	jr nz, .refresh ; $6dcd
	ld a, $0b ; $6dcf
	ld [$d001], a ; $6dd1
	jr .refresh ; $6dd4
.rightPalette:
	ld a, [$d001] ; $6dd6
	inc a ; $6dd9
	cp a, $05 ; $6dda
	jr nz, .storeRightPalette ; $6ddc
	xor a, a ; $6dde
.storeRightPalette:
	ld [$d001], a ; $6ddf
	jr .refresh ; $6de2
.confirm:
	sound $5e ; $6de4
	wram_bank $06 ; $6de6
	ld a, [$d000] ; $6dec
	or a, a ; $6def
	jr nz, .selectPalette ; $6df0
	ld a, [$d001] ; $6df2
	ld [$d003], a ; $6df5
	ld hl, CharViewerInputLoopTable ; $6df8
	add a, l ; $6dfb
	ld l, a ; $6dfc
	jr nc, .readAnimId ; $6dfd
	inc h ; $6dff
.readAnimId:
	ld d, [hl] ; $6e00
	wram_bank $04 ; $6e01
	farcall SetCharAnimation ; $6e07
	wram_bank $06 ; $6e0a
	jr .refresh ; $6e10
.selectPalette:
	ld a, [$d001] ; $6e12
	ld [w6_d004], a ; $6e15
	call ApplyCharViewerPalette ; $6e18
	jr .refresh ; $6e1b
.exit:
	sound $62 ; $6e1d
	ret ; $6e1f
.refresh:
	call RefreshCharViewerSelection ; $6e20
	call AdvanceFrame ; $6e23
	jp RunCharViewerInputLoop ; $6e26
.prevPose:
	ld a, [w6_d005] ; $6e29
	dec a ; $6e2c
	and a, $07 ; $6e2d
	ld [w6_d005], a ; $6e2f
	jp RunCharViewerInputLoop ; $6e32
.nextPose:
	ld a, [w6_d005] ; $6e35
	inc a ; $6e38
	and a, $07 ; $6e39
	ld [w6_d005], a ; $6e3b
	jp RunCharViewerInputLoop ; $6e3e
RefreshCharViewerSelection:
	wram_bank $02 ; $6e41
	ld a, $09 ; $6e47
	ld hl, $d128 ; $6e49
	ld [hl+], a ; $6e4c
	ld [hl+], a ; $6e4d
	ld [hl+], a ; $6e4e
	ld [hl+], a ; $6e4f
	ld [hl+], a ; $6e50
	ld [hl+], a ; $6e51
	ld [hl+], a ; $6e52
	ld [hl+], a ; $6e53
	ld [hl+], a ; $6e54
	ld [hl+], a ; $6e55
	ld [hl+], a ; $6e56
	ld hl, $d148 ; $6e57
	ld [hl+], a ; $6e5a
	ld [hl+], a ; $6e5b
	ld [hl+], a ; $6e5c
	ld [hl+], a ; $6e5d
	ld [hl+], a ; $6e5e
	ld [hl+], a ; $6e5f
	ld [hl+], a ; $6e60
	ld [hl+], a ; $6e61
	ld [hl+], a ; $6e62
	ld [hl+], a ; $6e63
	ld [hl+], a ; $6e64
	ld hl, $d1c8 ; $6e65
	ld [hl+], a ; $6e68
	ld [hl+], a ; $6e69
	ld [hl+], a ; $6e6a
	ld [hl+], a ; $6e6b
	ld [hl+], a ; $6e6c
	wram_bank $06 ; $6e6d
	ld a, [$d003] ; $6e73
	cp a, $0b ; $6e76
	jr nc, .ge0b ; $6e78
	add a, $28 ; $6e7a
	ld l, a ; $6e7c
	adc a, $d1 ; $6e7d
	sub a, l ; $6e7f
	ld h, a ; $6e80
	jr .queueVRAMCopy ; $6e81
.ge0b:
	sub a, $0b ; $6e83
	add a, $48 ; $6e85
	ld l, a ; $6e87
	adc a, $d1 ; $6e88
	sub a, l ; $6e8a
	ld h, a ; $6e8b
.queueVRAMCopy:
	wram_bank $02 ; $6e8c
	ld a, $08 ; $6e92
	ld [hl], a ; $6e94
	ld hl, $d120 ; $6e95
	ld de, $b920 ; $6e98
	ld c, $04 ; $6e9b
	call QueueVRAMCopy ; $6e9d
	wram_bank $06 ; $6ea0
	ld a, [w6_d004] ; $6ea6
	add a, $c8 ; $6ea9
	ld l, a ; $6eab
	adc a, $d1 ; $6eac
	sub a, l ; $6eae
	ld h, a ; $6eaf
	wram_bank $02 ; $6eb0
	ld a, $08 ; $6eb6
	ld [hl], a ; $6eb8
	ld hl, $d1c0 ; $6eb9
	ld de, $b9c0 ; $6ebc
	ld c, $02 ; $6ebf
	call QueueVRAMCopy ; $6ec1
	wram_bank $03 ; $6ec4
	ld hl, $d1e1 ; $6eca
	ld a, $20 ; $6ecd
	ld [hl+], a ; $6ecf
	ld [hl+], a ; $6ed0
	ld [hl+], a ; $6ed1
	ld [hl+], a ; $6ed2
	ld [hl+], a ; $6ed3
	ld [hl+], a ; $6ed4
	ld [hl+], a ; $6ed5
	ld [hl+], a ; $6ed6
	ld [hl+], a ; $6ed7
	ld [hl+], a ; $6ed8
	ld [hl+], a ; $6ed9
	ld [hl+], a ; $6eda
	ld [hl+], a ; $6edb
	ld [hl+], a ; $6edc
	ld [hl+], a ; $6edd
	ld [hl+], a ; $6ede
	ld hl, $d201 ; $6edf
	ld [hl+], a ; $6ee2
	ld [hl+], a ; $6ee3
	ld [hl+], a ; $6ee4
	ld [hl+], a ; $6ee5
	ld [hl+], a ; $6ee6
	ld [hl+], a ; $6ee7
	ld [hl+], a ; $6ee8
	ld [hl+], a ; $6ee9
	ld [hl+], a ; $6eea
	ld [hl+], a ; $6eeb
	ld [hl+], a ; $6eec
	ld [hl+], a ; $6eed
	ld [hl+], a ; $6eee
	ld [hl+], a ; $6eef
	ld [hl+], a ; $6ef0
	ld [hl+], a ; $6ef1
	wram_bank $06 ; $6ef2
	ld a, [$d000] ; $6ef8
	or a, a ; $6efb
	jr nz, .nonZero ; $6efc
	ld a, [$d001] ; $6efe
	add a, $01 ; $6f01
	add a, $c0 ; $6f03
	ld l, a ; $6f05
	adc a, $10 ; $6f06
	sub a, l ; $6f08
	ld h, a ; $6f09
	ld de, $d201 ; $6f0a
	ld c, $20 ; $6f0d
	wram_bank $03 ; $6f0f
	farcall RenderTextToBuffer64 ; $6f15
	jr .queueVRAMCopy2 ; $6f18
.nonZero:
	wram_bank $03 ; $6f1a
	ld hl, Text_34_192 ; $6f20
	ld de, $d201 ; $6f23
	ld c, $20 ; $6f26
	farcall RenderTextToBuffer64 ; $6f28
.queueVRAMCopy2:
	wram_bank $03 ; $6f2b
	ld hl, $d1e0 ; $6f31
	ld de, $99e0 ; $6f34
	ld c, $04 ; $6f37
	call QueueVRAMCopy ; $6f39
	ret ; $6f3c
SetupCharViewerScene:
	call LoadCharViewerMugshot ; $6f3d
	wram_bank $06 ; $6f40
	ld a, [$d002] ; $6f46
	farcall LookupTileId ; $6f49
	ld d, a ; $6f4c
	wram_bank $04 ; $6f4d
	ldh a, [hRomBank] ; $6f53
	ld hl, CharViewerSceneActors_1a ; $6f55
	farcall SpawnActorsFromList ; $6f58
	ld bc, $d000 ; $6f5b
	farcall LoadActorObjectDefIfValid ; $6f5e
	ld bc, $d040 ; $6f61
	farcall LoadActorObjectDefIfValid ; $6f64
	ld bc, $d080 ; $6f67
	farcall LoadActorObjectDefIfValid ; $6f6a
	ld bc, $d0c0 ; $6f6d
	farcall LoadActorObjectDefIfValid ; $6f70
	ld d, $01 ; $6f73
	ld bc, $d000 ; $6f75
	farcall SetActorAnimationChecked ; $6f78
	ld bc, $d040 ; $6f7b
	farcall SetActorAnimationChecked ; $6f7e
	ld bc, $d080 ; $6f81
	farcall SetActorAnimationChecked ; $6f84
	ld bc, $d0c0 ; $6f87
	farcall SetActorAnimationChecked ; $6f8a
	ld a, $07 ; $6f8d
	ld [w4_d037], a ; $6f8f
	ld [w4_d077], a ; $6f92
	ld [w4_d0b7], a ; $6f95
	ld [w4_d0f7], a ; $6f98
	wram_bank $06 ; $6f9b
	ld a, [$d002] ; $6fa1
	ld [wMatchPlayerChar], a ; $6fa4
	ld d, a ; $6fa7
	wram_bank $04 ; $6fa8
	ld hl, wCharPosX ; $6fae
	ld c, $10 ; $6fb1
	call ClearMemory16 ; $6fb3
	ld a, $00 ; $6fb6
	farcall InitChar ; $6fb8
	ld a, $07 ; $6fbb
	ld [$df37], a ; $6fbd
	ld de, $8600 ; $6fc0
	ld hl, $df26 ; $6fc3
	ld a, e ; $6fc6
	ld [hl+], a ; $6fc7
	ld [hl], d ; $6fc8
	ld hl, $df36 ; $6fc9
	ld [hl], $60 ; $6fcc
	ret ; $6fce
CharViewerSceneActors_1a:
	; $6fcf, 67 bytes (map_actors)
	map_actor $0000, $7011, $0f00, $0400, FACE_DOWN, $26, $01, $00
	map_actor $0000, $7011, $1180, $0400, FACE_LEFT, $26, $01, $00
	map_actor $0000, $7011, $0f00, $0680, FACE_UP, $26, $01, $00
	map_actor $0000, $7011, $1180, $0680, FACE_RIGHT, $26, $01, $00
	map_actor_end
	db $00
DrawCharViewerCharSprite:
	ld bc, $0770 ; $7012
	ld de, $4615 ; $7015
	call QueueSprite ; $7018
	ld bc, $0772 ; $701b
	ld de, $4e15 ; $701e
	call QueueSprite ; $7021
	wram_bank $04 ; $7024
	ld hl, wCharPosX ; $702a
	ld b, h ; $702d
	ld c, l ; $702e
	farcall StepCharAnimation ; $702f
	wram_bank $06 ; $7032
	ld a, [w6_d005] ; $7038
	ld d, a ; $703b
	wram_bank $04 ; $703c
	push de ; $7042
	farcall ReloadCharFacingTiles ; $7043
	pop de ; $7046
	ld a, d ; $7047
	add a, LOW(Data_1a_708e) ; $7048
	ld l, a ; $704a
	adc a, HIGH(Data_1a_708e) ; $704b
	sub a, l ; $704d
	ld h, a ; $704e
	ld b, [hl] ; $704f
	ld hl, $df36 ; $7050
	ld a, [hl+] ; $7053
	ld c, a ; $7054
	ld a, [hl] ; $7055
	or a, b ; $7056
	ld b, a ; $7057
	push bc ; $7058
	push de ; $7059
	ld d, $20 ; $705a
	ld e, $68 ; $705c
	ld a, d ; $705e
	ld [wCharScreenX], a ; $705f
	ld a, e ; $7062
	ld [wCharScreenY], a ; $7063
	pop hl ; $7066
	add hl, hl ; $7067
	add hl, hl ; $7068
	add hl, hl ; $7069
	pop bc ; $706a
	push hl ; $706b
	ld hl, wCharSpriteSlot ; $706c
	ld a, c ; $706f
	ld [hl+], a ; $7070
	ld a, b ; $7071
	ld [hl+], a ; $7072
	ld a, e ; $7073
	ld [hl+], a ; $7074
	ld a, d ; $7075
	ld [hl+], a ; $7076
	ld a, [wCharSpriteFrame + 2] ; $7077
	ld [hl+], a ; $707a
	ld a, [wCharSpriteFrame + 1] ; $707b
	ld [hl+], a ; $707e
	ld a, [wCharSpriteFrame] ; $707f
	ld [hl+], a ; $7082
	pop af ; $7083
	add a, $80 ; $7084
	ld [hl+], a ; $7086
	ld hl, wCharSpriteSlot ; $7087
	farcall DrawCharSprite ; $708a
	ret ; $708d
Data_1a_708e:
	; $708e, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
LoadCharViewerMugshot:
	xor a, a ; $7096
	ld de, $0701 ; $7097
	farcall LoadIndexedPaletteThunk ; $709a
	wram_bank $06 ; $709d
	ld a, [$d002] ; $70a3
	ld b, a ; $70a6
	wram_bank $01 ; $70a7
	ld a, b ; $70ad
	ld de, $d000 ; $70ae
	farcall DecompressCharMugshot ; $70b1
	ld hl, $d000 ; $70b4
	ld de, $b100 ; $70b7
	ld c, $09 ; $70ba
	call QueueVRAMCopy ; $70bc
	ret ; $70bf
ApplyCharViewerPalette:
	wram_bank $06 ; $70c0
	ld a, [w6_d004] ; $70c6
	ld de, $0701 ; $70c9
	farcall LoadIndexedPaletteThunk ; $70cc
	ld a, [w6_d004] ; $70cf
	ld de, $0f01 ; $70d2
	farcall LoadIndexedPaletteThunk ; $70d5
	ret ; $70d8
Palette_1a_70d9:
	INCLUDE "data/bank_01a/palettes_70d9.asm" ; $70d9, 64 bytes (palettes)
CharViewerScreenGfx0:
	INCBIN "data/bank_01a/d_7119.bin" ; $7119, 1636 bytes
CharViewerScreenGfx1:
	INCBIN "data/bank_01a/d_777d.bin" ; $777d, 180 bytes
CharViewerScreenGfx2:
	INCBIN "data/bank_01a/d_7831.bin" ; $7831, 129 bytes
CharViewerGridTilemap0:
	INCBIN "data/bank_01a/d_78b2.bin" ; $78b2, 58 bytes
CharViewerGridTilemap1:
	INCBIN "data/bank_01a/d_78ec.bin" ; $78ec, 67 bytes
CharViewerInputLoopTable:
	; $792f, 22 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $0b, $0c, $0d ; 0x10
RunCharDataConfirmScreen:
	farcall InitCharDataScreenVideo ; $7945
	farcall LoadCharDataScreenTilemaps ; $7948
	wram_bank $01 ; $794b
	ld hl, CharDataConfirmScreenGfx1 ; $7951
	ld de, $dea0 ; $7954
	call DecompressData ; $7957
	ld hl, $dea0 ; $795a
	ld bc, $002a ; $795d
	call CopyBank1ToBank3BufferAlt ; $7960
	wram_bank $01 ; $7963
	ld hl, CharDataConfirmScreenGfx2 ; $7969
	ld de, $dea0 ; $796c
	call DecompressData ; $796f
	ld hl, $dea0 ; $7972
	ld bc, $002a ; $7975
	call CopyBank1ToBank2BufferAlt ; $7978
	ld hl, CharDataConfirmScreenTable0 ; $797b
	ld bc, $dea0 ; $797e
	call ApplyTilemapPatchList_1a ; $7981
	farcall DrawCharDataConfirmPrompt ; $7984
	wram_bank $03 ; $7987
	ld hl, $d000 ; $798d
	ld de, $9800 ; $7990
	ld c, $24 ; $7993
	call QueueVRAMCopy ; $7995
	wram_bank $02 ; $7998
	ld hl, $d000 ; $799e
	ld de, $b800 ; $79a1
	ld c, $24 ; $79a4
	call QueueVRAMCopy ; $79a6
	call EnableLCD ; $79a9
	call AdvanceFrame ; $79ac
	farcall StartCharDataScreenAnimTask ; $79af
	farcall StartCharDataValuesSyncTask ; $79b2
	script_fade_in $10 ; $79b5
	call WaitFadeEnd ; $79ba
	wram_bank $06 ; $79bd
	ld a, $01 ; $79c3
	ld [w6_d025], a ; $79c5
.loop:
	call DrawCharDataPromptCursor ; $79c8
	call AdvanceFrame ; $79cb
	ldh a, [hInputRisingEdge] ; $79ce
	bit PADB_A, a ; $79d0
	jr nz, .step ; $79d2
	bit 1, a ; $79d4
	jr nz, .beginFadeOut2 ; $79d6
	and a, $c0 ; $79d8
	jr z, .loop ; $79da
	sound $5e ; $79dc
	ld a, [w6_d025] ; $79de
	xor a, $01 ; $79e1
	ld [w6_d025], a ; $79e3
	jr .loop ; $79e6
.step:
	wram_bank $06 ; $79e8
	ld a, [w6_d025] ; $79ee
	or a, a ; $79f1
	jr nz, .beginFadeOut2 ; $79f2
	sound $5f ; $79f4
	jr .beginFadeOut ; $79f6
.beginFadeOut2:
	wram_bank $06 ; $79f8
	ld a, $01 ; $79fe
	ld [w6_d025], a ; $7a00
	sound $62 ; $7a03
.beginFadeOut:
	ld c, $10 ; $7a05
	call BeginFadeOut ; $7a07
	call WaitFadeEnd ; $7a0a
	farcall StopCharDataValuesSyncTask ; $7a0d
	farcall StopCharDataScreenAnimTask ; $7a10
	wram_bank $06 ; $7a13
	ld a, [w6_d025] ; $7a19
	ret ; $7a1c
DrawCharDataPromptCursor:
	wram_bank $06 ; $7a1d
	ld a, [w6_d025] ; $7a23
	or a, a ; $7a26
	jr nz, .nonZero ; $7a27
	ld bc, $0fd4 ; $7a29
	ld de, $7a0c ; $7a2c
	call QueueSprite ; $7a2f
	ret ; $7a32
.nonZero:
	ld bc, $0fd4 ; $7a33
	ld de, $7a14 ; $7a36
	call QueueSprite ; $7a39
	ret ; $7a3c
CopyBank1ToBank3BufferAlt:
	wram_bank $01 ; $7a3d
	ld d, [hl] ; $7a43
	wram_bank $03 ; $7a44
	ld [hl], d ; $7a4a
	inc hl ; $7a4b
	dec bc ; $7a4c
	ld a, b ; $7a4d
	or a, c ; $7a4e
	jr nz, CopyBank1ToBank3BufferAlt ; $7a4f
	ret ; $7a51
CopyBank1ToBank2BufferAlt:
	wram_bank $01 ; $7a52
	ld d, [hl] ; $7a58
	wram_bank $02 ; $7a59
	ld [hl], d ; $7a5f
	inc hl ; $7a60
	dec bc ; $7a61
	ld a, b ; $7a62
	or a, c ; $7a63
	jr nz, CopyBank1ToBank2BufferAlt ; $7a64
	ret ; $7a66
ApplyTilemapPatchList_1a:
	ld a, [hl] ; $7a67
	cp a, $ff ; $7a68
	ret z ; $7a6a
	push hl ; $7a6b
	ld d, [hl] ; $7a6c
	inc hl ; $7a6d
	ld e, [hl] ; $7a6e
	push hl ; $7a6f
	ld hl, $d000 ; $7a70
	add hl, de ; $7a73
	ld d, h ; $7a74
	ld e, l ; $7a75
	pop hl ; $7a76
	inc hl ; $7a77
	push hl ; $7a78
	ld a, [hl] ; $7a79
	ld h, b ; $7a7a
	ld l, c ; $7a7b
	add a, l ; $7a7c
	ld l, a ; $7a7d
	jr nc, .gotPtr ; $7a7e
	inc h ; $7a80
.gotPtr:
	wram_bank $06 ; $7a81
	ld a, l ; $7a87
	ld [w6_d08e], a ; $7a88
	ld a, h ; $7a8b
	ld [w6_d08f], a ; $7a8c
	pop hl ; $7a8f
	push bc ; $7a90
	inc hl ; $7a91
	ld c, [hl] ; $7a92
	ld hl, w6_d08e ; $7a93
	ld a, [hl+] ; $7a96
	ld h, [hl] ; $7a97
	ld l, a ; $7a98
.loop:
	wram_bank $03 ; $7a99
	ld a, [hl] ; $7a9f
	ld [de], a ; $7aa0
	wram_bank $02 ; $7aa1
	ld a, [hl+] ; $7aa7
	ld [de], a ; $7aa8
	inc de ; $7aa9
	dec c ; $7aaa
	jr nz, .loop ; $7aab
	pop bc ; $7aad
	pop hl ; $7aae
	inc hl ; $7aaf
	inc hl ; $7ab0
	inc hl ; $7ab1
	inc hl ; $7ab2
	jr ApplyTilemapPatchList_1a ; $7ab3
CharDataScreen_BuildStats:
	ld a, [wStoryCharacterSlot] ; $7ab5
	or a, a ; $7ab8
	ret nz ; $7ab9
	wram_bank $06 ; $7aba
	xor a, a ; $7ac0
	ld hl, w6_d0ab ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a, a ; $7ad2
	ret z ; $7ad3
	farcall RecomputeStatsWithoutRacket ; $7ad4
	ld hl, $c920 ; $7ad7
	ld de, w6_d0a0 ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, w6_d0a0 ; $7afd
	ld c, [hl] ; $7b00
	ld a, [w6_d00e] ; $7b01
	dec a ; $7b04
	sub a, c ; $7b05
	ld [w6_d0ab], a ; $7b06
	ld hl, w6_d0a1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [w6_d00f] ; $7b0d
	dec a ; $7b10
	sub a, c ; $7b11
	ld [w6_d0ac], a ; $7b12
	ld hl, w6_d0a2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [w6_d010] ; $7b19
	dec a ; $7b1c
	sub a, c ; $7b1d
	ld [w6_d0ad], a ; $7b1e
	ld hl, w6_d0a3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [w6_d011] ; $7b25
	dec a ; $7b28
	sub a, c ; $7b29
	ld [w6_d0ae], a ; $7b2a
	ld hl, w6_d0a4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [w6_d012] ; $7b31
	dec a ; $7b34
	sub a, c ; $7b35
	ld [w6_d0af], a ; $7b36
	ld hl, w6_d0a5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [$d013] ; $7b3d
	dec a ; $7b40
	sub a, c ; $7b41
	ld [w6_d0b0], a ; $7b42
	ld hl, w6_d0a6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [$d014] ; $7b49
	dec a ; $7b4c
	sub a, c ; $7b4d
	ld [w6_d0b1], a ; $7b4e
	ld hl, w6_d0a7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [w6_d015] ; $7b55
	dec a ; $7b58
	sub a, c ; $7b59
	ld [w6_d0b2], a ; $7b5a
	ld hl, w6_d0a8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [w6_d016] ; $7b61
	dec a ; $7b64
	sub a, c ; $7b65
	ld [w6_d0b3], a ; $7b66
	ld hl, w6_d0a9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [w6_d017] ; $7b6d
	dec a ; $7b70
	sub a, c ; $7b71
	ld [w6_d0b4], a ; $7b72
	ld hl, w6_d0aa ; $7b75
	ld c, [hl] ; $7b78
	ld a, [w6_d018] ; $7b79
	dec a ; $7b7c
	sub a, c ; $7b7d
	ld [w6_d0b5], a ; $7b7e
	farcall RefreshMainCharacterStats ; $7b81
	ret ; $7b84
CharDataScreen_LoadGfx:
	ld hl, Palette_1a_7e7e ; $7b85
	ld de, $0c02 ; $7b88
	call LoadPaletteShadow ; $7b8b
	wram_bank $01 ; $7b8e
	ld hl, CharDataScreenGfx0 ; $7b94
	ld de, $d000 ; $7b97
	call DecompressData ; $7b9a
	ld hl, $d000 ; $7b9d
	ld de, $a780 ; $7ba0
	ld c, $02 ; $7ba3
	call QueueVRAMCopy ; $7ba5
	ld hl, CharDataScreenGfx1 ; $7ba8
	ld de, $d000 ; $7bab
	call DecompressData ; $7bae
	ld hl, $d000 ; $7bb1
	ld de, $a7a0 ; $7bb4
	ld c, $02 ; $7bb7
	call QueueVRAMCopy ; $7bb9
	ld hl, CharDataScreenGfx2 ; $7bbc
	ld de, $d000 ; $7bbf
	call DecompressData ; $7bc2
	ld hl, $d000 ; $7bc5
	ld de, $a7c0 ; $7bc8
	ld c, $02 ; $7bcb
	call QueueVRAMCopy ; $7bcd
	ld hl, CharDataScreenGfx3 ; $7bd0
	ld de, $d000 ; $7bd3
	call DecompressData ; $7bd6
	ld hl, $d000 ; $7bd9
	ld de, $a7e0 ; $7bdc
	ld c, $02 ; $7bdf
	call QueueVRAMCopy ; $7be1
	ret ; $7be4
DrawStatChangeArrows:
	wram_bank $06 ; $7be5
	ld a, [$d142] ; $7beb
	dec a ; $7bee
	ret nz ; $7bef
	ld hl, $d145 ; $7bf0
	ld a, [hl+] ; $7bf3
	ld h, [hl] ; $7bf4
	ld l, a ; $7bf5
	ld a, h ; $7bf6
	or a, l ; $7bf7
	ret nz ; $7bf8
	ldh a, [hVBlankCounter] ; $7bf9
	and a, $18 ; $7bfb
	ret z ; $7bfd
	ld a, [w6_d0ab] ; $7bfe
	or a, a ; $7c01
	jr z, .getStatArrowSpriteAttr ; $7c02
	call GetStatArrowSpriteAttr ; $7c04
	call GetStatArrowTile ; $7c07
	push af ; $7c0a
	ld a, [w6_d0a0] ; $7c0b
	ld l, a ; $7c0e
	ld a, [w6_d019] ; $7c0f
	add a, l ; $7c12
	ld de, $142c ; $7c13
	call ComputeStatArrowSpriteX ; $7c16
	push de ; $7c19
	call QueueSprite ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a, a ; $7c1f
	jr z, .getStatArrowSpriteAttr ; $7c20
	call GetStatArrowExtraTile ; $7c22
	call OffsetStatArrowSpriteX ; $7c25
	call QueueSprite ; $7c28
.getStatArrowSpriteAttr:
	ld a, [w6_d0ac] ; $7c2b
	or a, a ; $7c2e
	jr z, .getStatArrowSpriteAttr2 ; $7c2f
	call GetStatArrowSpriteAttr ; $7c31
	call GetStatArrowTile ; $7c34
	push af ; $7c37
	ld a, [w6_d0a1] ; $7c38
	ld l, a ; $7c3b
	ld a, [w6_d01a] ; $7c3c
	add a, l ; $7c3f
	ld de, $143c ; $7c40
	call ComputeStatArrowSpriteX ; $7c43
	push de ; $7c46
	call QueueSprite ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a, a ; $7c4c
	jr z, .getStatArrowSpriteAttr2 ; $7c4d
	call GetStatArrowExtraTile ; $7c4f
	call OffsetStatArrowSpriteX ; $7c52
	call QueueSprite ; $7c55
.getStatArrowSpriteAttr2:
	ld a, [w6_d0ad] ; $7c58
	or a, a ; $7c5b
	jr z, .getStatArrowSpriteAttr3 ; $7c5c
	call GetStatArrowSpriteAttr ; $7c5e
	call GetStatArrowTile ; $7c61
	push af ; $7c64
	ld a, [w6_d0a2] ; $7c65
	ld l, a ; $7c68
	ld a, [w6_d01b] ; $7c69
	add a, l ; $7c6c
	ld de, $1454 ; $7c6d
	call ComputeStatArrowSpriteX ; $7c70
	push de ; $7c73
	call QueueSprite ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a, a ; $7c79
	jr z, .getStatArrowSpriteAttr3 ; $7c7a
	call GetStatArrowExtraTile ; $7c7c
	call OffsetStatArrowSpriteX ; $7c7f
	call QueueSprite ; $7c82
.getStatArrowSpriteAttr3:
	ld a, [w6_d0ae] ; $7c85
	or a, a ; $7c88
	jr z, .getStatArrowSpriteAttr4 ; $7c89
	call GetStatArrowSpriteAttr ; $7c8b
	call GetStatArrowTile ; $7c8e
	push af ; $7c91
	ld a, [w6_d0a3] ; $7c92
	ld l, a ; $7c95
	ld a, [w6_d01c] ; $7c96
	add a, l ; $7c99
	ld de, $1464 ; $7c9a
	call ComputeStatArrowSpriteX ; $7c9d
	push de ; $7ca0
	call QueueSprite ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a, a ; $7ca6
	jr z, .getStatArrowSpriteAttr4 ; $7ca7
	call GetStatArrowExtraTile ; $7ca9
	call OffsetStatArrowSpriteX ; $7cac
	call QueueSprite ; $7caf
.getStatArrowSpriteAttr4:
	ld a, [w6_d0af] ; $7cb2
	or a, a ; $7cb5
	jr z, .getStatArrowSpriteAttr5 ; $7cb6
	call GetStatArrowSpriteAttr ; $7cb8
	call GetStatArrowTile ; $7cbb
	push af ; $7cbe
	ld a, [w6_d0a4] ; $7cbf
	ld l, a ; $7cc2
	ld a, [w6_d01d] ; $7cc3
	add a, l ; $7cc6
	ld de, $1474 ; $7cc7
	call ComputeStatArrowSpriteX ; $7cca
	push de ; $7ccd
	call QueueSprite ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a, a ; $7cd3
	jr z, .getStatArrowSpriteAttr5 ; $7cd4
	call GetStatArrowExtraTile ; $7cd6
	call OffsetStatArrowSpriteX ; $7cd9
	call QueueSprite ; $7cdc
.getStatArrowSpriteAttr5:
	ld a, [w6_d0b0] ; $7cdf
	or a, a ; $7ce2
	jr z, .getStatArrowSpriteAttr6 ; $7ce3
	call GetStatArrowSpriteAttr ; $7ce5
	call GetStatArrowTile ; $7ce8
	push af ; $7ceb
	ld a, [w6_d0a5] ; $7cec
	ld l, a ; $7cef
	ld a, [w6_d01e] ; $7cf0
	add a, l ; $7cf3
	ld de, StatChangeArrows0 ; $7cf4
	call ComputeStatArrowSpriteX ; $7cf7
	push de ; $7cfa
	call QueueSprite ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a, a ; $7d00
	jr z, .getStatArrowSpriteAttr6 ; $7d01
	call GetStatArrowExtraTile ; $7d03
	call OffsetStatArrowSpriteX ; $7d06
	call QueueSprite ; $7d09
.getStatArrowSpriteAttr6:
	ld a, [w6_d0b1] ; $7d0c
	or a, a ; $7d0f
	jr z, .getStatArrowSpriteAttr7 ; $7d10
	call GetStatArrowSpriteAttr ; $7d12
	call GetStatArrowTile ; $7d15
	push af ; $7d18
	ld a, [w6_d0a6] ; $7d19
	ld l, a ; $7d1c
	ld a, [w6_d01f] ; $7d1d
	add a, l ; $7d20
	ld de, StatChangeArrows1 ; $7d21
	call ComputeStatArrowSpriteX ; $7d24
	push de ; $7d27
	call QueueSprite ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a, a ; $7d2d
	jr z, .getStatArrowSpriteAttr7 ; $7d2e
	call GetStatArrowExtraTile ; $7d30
	call OffsetStatArrowSpriteX ; $7d33
	call QueueSprite ; $7d36
.getStatArrowSpriteAttr7:
	ld a, [w6_d0b2] ; $7d39
	or a, a ; $7d3c
	jr z, .getStatArrowSpriteAttr8 ; $7d3d
	call GetStatArrowSpriteAttr ; $7d3f
	call GetStatArrowTile ; $7d42
	push af ; $7d45
	ld a, [w6_d0a7] ; $7d46
	ld l, a ; $7d49
	ld a, [$d020] ; $7d4a
	add a, l ; $7d4d
	ld de, StatChangeArrows2 ; $7d4e
	call ComputeStatArrowSpriteX ; $7d51
	push de ; $7d54
	call QueueSprite ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a, a ; $7d5a
	jr z, .getStatArrowSpriteAttr8 ; $7d5b
	call GetStatArrowExtraTile ; $7d5d
	call OffsetStatArrowSpriteX ; $7d60
	call QueueSprite ; $7d63
.getStatArrowSpriteAttr8:
	ld a, [w6_d0b3] ; $7d66
	or a, a ; $7d69
	jr z, .getStatArrowSpriteAttr9 ; $7d6a
	call GetStatArrowSpriteAttr ; $7d6c
	call GetStatArrowTile ; $7d6f
	push af ; $7d72
	ld a, [w6_d0a8] ; $7d73
	ld l, a ; $7d76
	ld a, [w6_d021] ; $7d77
	add a, l ; $7d7a
	ld de, StatChangeArrows3 ; $7d7b
	call ComputeStatArrowSpriteX ; $7d7e
	push de ; $7d81
	call QueueSprite ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a, a ; $7d87
	jr z, .getStatArrowSpriteAttr9 ; $7d88
	call GetStatArrowExtraTile ; $7d8a
	call OffsetStatArrowSpriteX ; $7d8d
	call QueueSprite ; $7d90
.getStatArrowSpriteAttr9:
	ld a, [w6_d0b4] ; $7d93
	or a, a ; $7d96
	jr z, .getStatArrowSpriteAttr10 ; $7d97
	call GetStatArrowSpriteAttr ; $7d99
	call GetStatArrowTile ; $7d9c
	push af ; $7d9f
	ld a, [w6_d0a9] ; $7da0
	ld l, a ; $7da3
	ld a, [w6_d022] ; $7da4
	add a, l ; $7da7
	ld de, StatChangeArrows4 ; $7da8
	call ComputeStatArrowSpriteX ; $7dab
	push de ; $7dae
	call QueueSprite ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a, a ; $7db4
	jr z, .getStatArrowSpriteAttr10 ; $7db5
	call GetStatArrowExtraTile ; $7db7
	call OffsetStatArrowSpriteX ; $7dba
	call QueueSprite ; $7dbd
.getStatArrowSpriteAttr10:
	ld a, [w6_d0b5] ; $7dc0
	or a, a ; $7dc3
	jr z, .done ; $7dc4
	call GetStatArrowSpriteAttr ; $7dc6
	call GetStatArrowTile ; $7dc9
	push af ; $7dcc
	ld a, [w6_d0aa] ; $7dcd
	ld l, a ; $7dd0
	ld a, [w6_d023] ; $7dd1
	add a, l ; $7dd4
	ld de, StatChangeArrows5 ; $7dd5
	call ComputeStatArrowSpriteX ; $7dd8
	push de ; $7ddb
	call QueueSprite ; $7ddc
	pop de ; $7ddf
	pop af ; $7de0
	or a, a ; $7de1
	jr z, .done ; $7de2
	call GetStatArrowExtraTile ; $7de4
	call OffsetStatArrowSpriteX ; $7de7
	call QueueSprite ; $7dea
.done:
	ret ; $7ded
GetStatArrowSpriteAttr:
	ld b, $0c ; $7dee
	bit 7, a ; $7df0
	ret z ; $7df2
	inc b ; $7df3
	ret ; $7df4
GetStatArrowTile:
	bit 7, a ; $7df5
	jr nz, .down ; $7df7
	dec a ; $7df9
	jr z, .upSingle ; $7dfa
	dec a ; $7dfc
	ld c, $7e ; $7dfd
	ld h, $02 ; $7dff
	ret ; $7e01
.upSingle:
	ld c, $7c ; $7e02
	ld h, $02 ; $7e04
	ret ; $7e06
.down:
	inc a ; $7e07
	jr z, .downSingle ; $7e08
	inc a ; $7e0a
	ld c, $7a ; $7e0b
	ld h, $01 ; $7e0d
	ret ; $7e0f
.downSingle:
	ld c, $78 ; $7e10
	ld h, $01 ; $7e12
	ret ; $7e14
GetStatArrowExtraTile:
	bit 7, a ; $7e15
	jr nz, .down ; $7e17
	ld c, $7c ; $7e19
	ld h, $03 ; $7e1b
	ret ; $7e1d
.down:
	ld c, $78 ; $7e1e
	ld h, $00 ; $7e20
	ret ; $7e22
ComputeStatArrowSpriteX:
	inc a ; $7e23
	rlca ; $7e24
	rlca ; $7e25
	add a, d ; $7e26
	ld d, a ; $7e27
	ld a, h ; $7e28
	add a, LOW(Data_1a_7e34) ; $7e29
	ld l, a ; $7e2b
	adc a, HIGH(Data_1a_7e34) ; $7e2c
	sub a, l ; $7e2e
	ld h, a ; $7e2f
	ld a, [hl] ; $7e30
	add a, d ; $7e31
	ld d, a ; $7e32
	ret ; $7e33
Data_1a_7e34:
	; $7e34, 4 bytes (bytes:4)
	db $f0, $f8, $00, $08 ; 0x00
OffsetStatArrowSpriteX:
	bit 7, a ; $7e38
	jr nz, .shiftLeft ; $7e3a
	ld a, $08 ; $7e3c
	add a, d ; $7e3e
	ld d, a ; $7e3f
	ret ; $7e40
.shiftLeft:
	ld a, $f8 ; $7e41
	add a, d ; $7e43
	ld d, a ; $7e44
	ret ; $7e45
CharDataConfirmScreenTable0:
	; $7e46, 13 bytes (bytes:13)
	db $00, $00, $00, $0e, $00, $20, $0e, $0e, $00, $40, $1c, $0e, $ff ; 0x00
CharDataConfirmScreenGfx1:
	INCBIN "data/bank_01a/d_7e53.bin" ; $7e53, 34 bytes
CharDataConfirmScreenGfx2:
	INCBIN "data/bank_01a/d_7e75.bin" ; $7e75, 9 bytes
Palette_1a_7e7e:
	INCLUDE "data/bank_01a/palettes_7e7e.asm" ; $7e7e, 16 bytes (palettes)
CharDataScreenGfx0:
	INCBIN "data/bank_01a/d_7e8e.bin" ; $7e8e, 11 bytes
CharDataScreenGfx1:
	INCBIN "data/bank_01a/d_7e99.bin" ; $7e99, 11 bytes
CharDataScreenGfx2:
	INCBIN "data/bank_01a/d_7ea4.bin" ; $7ea4, 11 bytes
CharDataScreenGfx3:
	INCBIN "data/bank_01a/d_7eaf.bin" ; $7eaf, 11 bytes
	; $7eba, 326 bytes fill to bank end (linker-padded)
