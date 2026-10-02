	farptr Unused_1a_RunMinigameModePauseMenu ; $4000
	farptr Unused_1a_QueueWindowTileWrite ; $4002
	farptr Unused_1a_ResetCharDataScreenAnim ; $4004
	farptr Unused_1a_CheckDebugExpEditorHotkey ; $4006
	farptr Unused_1a_RunDebugCharViewer ; $4008
	farptr Unused_1a_ShowExpGainScreen ; $400a
	farptr RunCharDataConfirmScreen ; $400c
	farptr CharDataScreen_BuildStats ; $400e
	farptr CharDataScreen_LoadGfx ; $4010
	farptr DrawStatChangeArrows ; $4012
Unused_1a_RunMinigameModePauseMenu:
	ldh a, [hWramBank] ; $4014
	push af ; $4016
	call Unused_1a_ForceInstantMessageSpeed ; $4017
	call Unused_1a_BuildMinigameModePauseMenu ; $401a
	call Unused_1a_RunPauseMenuWindow ; $401d
	call Unused_1a_RestoreMessageSpeed ; $4020
	pop_wram_bank ; $4023
	ld a, [wPauseMenuIsMinigame] ; $4028
	ret ; $402b
Unused_1a_RunPauseMenuWindow:
	xor a ; $402c
	ld [wPauseMenuIsMinigame], a ; $402d
	wram_bank WRAM_TEXT ; $4030
	farcall CreateMenuWindowFromText ; $4036
	set_flag FLAG_VRAM_UPDATE_BUSY ; $4039
	ld [wPauseMenuWindowId], a ; $403c
	farcall RestoreShadowTilemap ; $403f
	farcall RenderMenuWindowText ; $4042
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $4045
.menuLoop:
	call Unused_1a_DrawPauseMenuSettingValues ; $4048
	ld a, [wPauseMenuWindowId] ; $404b
	farcall Unused_05_RunMenuSelectionShared ; $404e
	push af ; $4051
	push bc ; $4052
	cp $ff ; $4053
	jr z, .checkEnabled ; $4055
	ld a, [wMenuKeepOpenRowMask] ; $4057
	bit 7, a ; $405a
	jr z, .checkEnabled ; $405c
	and $7f ; $405e
	ld b, a ; $4060
	ld a, [wMenuCursorRow] ; $4061
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
	cp $ff ; $407e
	jr z, .done ; $4080
	add a ; $4082
	add c ; $4083
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
	call Unused_1a_ResetPauseMenuState ; $408e
	ret ; $4091
Unused_1a_ResetPauseMenuState:
	xor a ; $4092
	ld [wMenuInitialRow], a ; $4093
	ld [wMenuAdjustRowMask], a ; $4096
	ld [wPauseMenuOptionBits], a ; $4099
	ld [wMenuKeepOpenRowMask], a ; $409c
	ret ; $409f
Unused_1a_DrawPauseMenuSettingValues:
	push af ; $40a0
	push bc ; $40a1
	push de ; $40a2
	push hl ; $40a3
	ld a, [wPauseMenuOptionBits] ; $40a4
	bit 5, a ; $40a7
	jr nz, .checkMessageSpeed ; $40a9
	pop hl ; $40ab
	pop de ; $40ac
	pop bc ; $40ad
	pop af ; $40ae
	ret ; $40af
.checkMessageSpeed:
	ld a, [wMessageSpeed] ; $40b0
	and $7f ; $40b3
	jr z, .maskClear ; $40b5
	dec a ; $40b7
	jr z, .countDone ; $40b8
	ld l, $75 ; $40ba
	lb de, $0a, $05 ; $40bc column, row
	call Unused_1a_QueueWindowTileWrite ; $40bf
	ld l, $7f ; $40c2
	lb de, $0b, $05 ; $40c4 column, row
	call Unused_1a_QueueWindowTileWrite ; $40c7
	ld l, $72 ; $40ca
	lb de, $0c, $05 ; $40cc column, row
	call Unused_1a_QueueWindowTileWrite ; $40cf
	jr .checkMusic ; $40d2
.countDone:
	ld l, $8c ; $40d4
	lb de, $0a, $05 ; $40d6 column, row
	call Unused_1a_QueueWindowTileWrite ; $40d9
	ld l, $82 ; $40dc
	lb de, $0b, $05 ; $40de column, row
	call Unused_1a_QueueWindowTileWrite ; $40e1
	ld l, $73 ; $40e4
	lb de, $0c, $05 ; $40e6 column, row
	call Unused_1a_QueueWindowTileWrite ; $40e9
	jr .checkMusic ; $40ec
.maskClear:
	ld l, $8a ; $40ee
	lb de, $0a, $05 ; $40f0 column, row
	call Unused_1a_QueueWindowTileWrite ; $40f3
	ld l, $94 ; $40f6
	lb de, $0b, $05 ; $40f8 column, row
	call Unused_1a_QueueWindowTileWrite ; $40fb
	ld l, $72 ; $40fe
	lb de, $0c, $05 ; $4100 column, row
	call Unused_1a_QueueWindowTileWrite ; $4103
	jr .checkMusic ; $4106
.checkMusic:
	ldh a, [hMusic] ; $4108
	push af ; $410a
	push bc ; $410b
	push de ; $410c
	push hl ; $410d
	ld de, $0404 ; $410e
	call PrintHexByte ; $4111
	ld a, [wSoundOptionBits] ; $4114
	ld de, $0405 ; $4117
	call PrintHexByte ; $411a
	pop hl ; $411d
	pop de ; $411e
	pop bc ; $411f
	pop af ; $4120
	and $01 ; $4121
	jr nz, .maskSet ; $4123
	ld l, $dd ; $4125
	lb de, $0b, $07 ; $4127 column, row
	call Unused_1a_QueueWindowTileWrite ; $412a
	jr .restore ; $412d
.maskSet:
	ld l, $cc ; $412f
	lb de, $0b, $07 ; $4131 column, row
	call Unused_1a_QueueWindowTileWrite ; $4134
.restore:
	pop hl ; $4137
	pop de ; $4138
	pop bc ; $4139
	pop af ; $413a
	ret ; $413b
Unused_1a_QueueWindowTileWrite:
	ld h, $80 ; $413c
	call Unused_1a_GetTilemapBufferCellDest ; $413e
	call QueueBGTileWrite ; $4141
	ret ; $4144
Unused_1a_GetTilemapBufferCellDest:
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
	add d ; $4154
	ld d, a ; $4155
	ld a, l ; $4156
	add e ; $4157
	ld e, a ; $4158
	farcall GetTilemapCellAddress ; $4159
	ld h, d ; $415c
	ld l, e ; $415d
	ld de, $3000 ; $415e
	add hl, de ; $4161
	ld de, vBGMap0 ; $4162
	add hl, de ; $4165
	ld d, h ; $4166
	ld e, l ; $4167
	pop hl ; $4168
	pop bc ; $4169
	pop af ; $416a
	ret ; $416b
MessageSpeedSettingPtrs:
	; $416c, 10 bytes (records:2)
	dw Unused_1a_MessageSpeedSettingHandler0 ; record 0
	dw Unused_1a_ShowGameProgressScreenThunk ; record 1
	dw Unused_1a_AdjustMessageSpeedSettingThunk ; record 2
	dw Unused_1a_ToggleMusicSettingThunk ; record 3
	dw Unused_1a_MessageSpeedSettingHandler4 ; record 4
Unused_1a_MessageSpeedSettingHandler0:
	ld a, $01 ; $4176
	farcall ShowCharDataScreen ; $4178
	ld hl, wStoryModePlayersXPosition ; $417b
	ld de, wStoryModeSpawnPosition ; $417e
	ld bc, $0005 ; $4181
	call CopyMemoryBC ; $4184
	ld a, STORYENTRY_NONE ; $4187
	ld [wStoryModeEntryPoint], a ; $4189
	ld [wUnusedExitTriggerIdMirror], a ; $418c
	ld [wStoryModeExitTriggerRequest], a ; $418f
	jp Unused_1a_RunPauseMenuWindow.done ; $4192
Unused_1a_ShowGameProgressScreenThunk:
	farcall ShowGameProgressScreen ; $4195
	ld hl, wStoryModePlayersXPosition ; $4198
	ld de, wStoryModeSpawnPosition ; $419b
	ld bc, $0005 ; $419e
	call CopyMemoryBC ; $41a1
	ld a, STORYENTRY_NONE ; $41a4
	ld [wStoryModeEntryPoint], a ; $41a6
	ld [wUnusedExitTriggerIdMirror], a ; $41a9
	ld [wStoryModeExitTriggerRequest], a ; $41ac
	jp Unused_1a_RunPauseMenuWindow.done ; $41af
Unused_1a_AdjustMessageSpeedSettingThunk:
	call Unused_1a_AdjustMessageSpeedSetting ; $41b2
	ld a, [wCharDataPageSlot1 + 2 * TILEMAP_WIDTH + 16] ; $41b5
	ld [wMenuInitialRow], a ; $41b8
	ld bc, MessageSpeedSettingPtrs ; $41bb
	ld a, [wPauseMenuWindowId] ; $41be
	jp Unused_1a_RunPauseMenuWindow.menuLoop ; $41c1
Unused_1a_ToggleMusicSettingThunk:
	call Unused_1a_ToggleMusicSetting ; $41c4
	ld a, [wCharDataPageSlot1 + 2 * TILEMAP_WIDTH + 16] ; $41c7
	ld [wMenuInitialRow], a ; $41ca
	ld bc, MessageSpeedSettingPtrs ; $41cd
	ld a, [wPauseMenuWindowId] ; $41d0
	jp Unused_1a_RunPauseMenuWindow.menuLoop ; $41d3
Unused_1a_MessageSpeedSettingHandler4:
	xor a ; $41d6
	ld [wSuppressMinigamePauseFlag], a ; $41d7
	jp Unused_1a_RestoreMessageSpeed.scriptShowSpeakerDialogueRestoreBG ; $41da
MusicSettingPtrs:
	; $41dd, 4 bytes (records:2)
	dw Unused_1a_MusicSettingHandler0 ; record 0
	dw Unused_1a_MusicSettingHandler1 ; record 1
Unused_1a_MusicSettingHandler0:
	ld a, [wPauseMenuOptionBits] ; $41e1
	and $0f ; $41e4
	jr z, .storeMenuInitialRow ; $41e6
	cp $03 ; $41e8
	jr z, .storeMenuInitialRow ; $41ea
	sound SFX_OPTION_TOGGLE ; $41ec
	bit 0, a ; $41ee
	jr z, .bit0Clear ; $41f0
	res 0, a ; $41f2
	jr .storeMenuInitialRow ; $41f4
.bit0Clear:
	set 0, a ; $41f6
.storeMenuInitialRow:
	ld a, [wPauseMenuOptionBits] ; $41f8
	or $c0 ; $41fb
	ld [wPauseMenuOptionBits], a ; $41fd
	ld a, [wCharDataPageSlot1 + 2 * TILEMAP_WIDTH + 16] ; $4200
	ld [wMenuInitialRow], a ; $4203
	ld bc, MusicSettingPtrs ; $4206
	ld a, [wPauseMenuWindowId] ; $4209
	jp Unused_1a_RunPauseMenuWindow.menuLoop ; $420c
Unused_1a_MusicSettingHandler1:
	ld a, [wPauseMenuOptionBits] ; $420f
	and $0f ; $4212
	and a ; $4214
	jr z, .storeMenuInitialRow2 ; $4215
	cp $03 ; $4217
	jr z, .storeMenuInitialRow2 ; $4219
	sound SFX_OPTION_TOGGLE ; $421b
	bit 1, a ; $421d
	jr z, .bit1Clear ; $421f
	res 1, a ; $4221
	jr .storeMenuInitialRow2 ; $4223
.bit1Clear:
	set 1, a ; $4225
.storeMenuInitialRow2:
	ld a, [wPauseMenuOptionBits] ; $4227
	or $c0 ; $422a
	ld [wPauseMenuOptionBits], a ; $422c
	ld a, [wCharDataPageSlot1 + 2 * TILEMAP_WIDTH + 16] ; $422f
	ld [wMenuInitialRow], a ; $4232
	ld bc, MusicSettingPtrs ; $4235
	ld a, [wPauseMenuWindowId] ; $4238
	jp Unused_1a_RunPauseMenuWindow.menuLoop ; $423b
UnusedRunMusicSettingMenu:
	call Unused_1a_ResetPauseMenuState ; $423e
	ld a, $c0 ; $4241
	ld [wPauseMenuOptionBits], a ; $4243
	ld hl, wMenuAdjustRowMask ; $4246
	ld [hl], $83 ; $4249
	ld hl, wMenuKeepOpenRowMask ; $424b
	ld [hl], $83 ; $424e
	ld hl, $049b ; $4250
	ld bc, MusicSettingPtrs ; $4253
	ld de, $0305 ; $4256
	set_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4259
	call Unused_1a_RunPauseMenuWindow ; $425c
	call Unused_1a_ResetPauseMenuState ; $425f
	ld hl, wPauseMenuOptionBits ; $4262
	set 7, [hl] ; $4265
	clear_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4267
	ret ; $426a
Unused_1a_AdjustMessageSpeedSetting:
	ld a, [wPauseMenuOptionBits] ; $426b
	and $0f ; $426e
	cp $02 ; $4270
	jr z, .playSfx2 ; $4272
	cp $01 ; $4274
	jr z, .playSfx ; $4276
	jr .done ; $4278
.playSfx:
	sound SFX_MENU_MOVE ; $427a
	ld hl, wMessageSpeed ; $427c
	ld a, [hl] ; $427f
	and $7f ; $4280
	inc a ; $4282
	ld b, a ; $4283
	sub $03 ; $4284
	jr z, .zero ; $4286
	ld a, b ; $4288
	or $80 ; $4289
	ld [hl], a ; $428b
	jr .done ; $428c
.zero:
	ld a, $80 ; $428e
	ld [hl], a ; $4290
	jr .done ; $4291
.playSfx2:
	sound SFX_MENU_MOVE ; $4293
	ld hl, wMessageSpeed ; $4295
	ld a, [hl] ; $4298
	and $7f ; $4299
	dec a ; $429b
	bit 7, a ; $429c
	jr nz, .negative ; $429e
	or $80 ; $42a0
	ld [hl], a ; $42a2
	jr .done ; $42a3
.negative:
	ld a, $82 ; $42a5
	ld [hl], a ; $42a7
.done:
	ret ; $42a8
Unused_1a_ToggleMusicSetting:
	sound SFX_MENU_MOVE ; $42a9
	ld a, [wSoundOptionBits] ; $42ab
	ld b, a ; $42ae
	and $01 ; $42af
	xor $01 ; $42b1
	ld c, a ; $42b3
	ld a, b ; $42b4
	and $fe ; $42b5
	or c ; $42b7
	ld [wSoundOptionBits], a ; $42b8
	ret ; $42bb
Unused_1a_ForceInstantMessageSpeed:
	ld a, [wMessageSpeed] ; $42bc
	set 7, a ; $42bf
	ld [wMessageSpeed], a ; $42c1
	ret ; $42c4
Unused_1a_RestoreMessageSpeed:
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
	and a ; $42e9
	jr nz, .compare ; $42ea
	ld a, $01 ; $42ec
	ld [wSaveAndQuitRequest], a ; $42ee
	ld a, [wMessageSpeed] ; $42f1
	res 7, a ; $42f4
	ld [wMessageSpeed], a ; $42f6
	ld bc, $ffff ; $42f9
	farcall SaveStoryReturnPoint ; $42fc
	farcall SaveStorySlotWithTimer ; $42ff
	ld a, STORYLOC_MAIN_MENU ; $4302
	ld [wStoryModeCurrentLocation], a ; $4304
	ld a, $01 ; $4307
	ld [wStoryModeEntryPoint], a ; $4309
	ld a, $ff ; $430c
	ld [wUnusedExitTriggerIdMirror], a ; $430e
	ld [wStoryModeExitTriggerRequest], a ; $4311
	jp Unused_1a_RunPauseMenuWindow.done ; $4314
.compare:
	cp $ff ; $4317
	jr nz, .setText ; $4319
	call Unused_1a_BuildMinigameModePauseMenu ; $431b
	ld a, $03 ; $431e
	ld [wMenuInitialRow], a ; $4320
	ld a, [wSuppressMinigamePauseFlag] ; $4323
	and a ; $4326
	jr nz, .runPauseMenuWindow ; $4327
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4329
	jr .runPauseMenuWindow ; $432c
.runPauseMenuWindow:
	jp Unused_1a_RunPauseMenuWindow ; $432e
.setText:
	script_set_text Text_31_157 ; $4331
	ld a, $80 ; $4337
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4339
	ld a, $01 ; $433c
	ld [wMenuInitialRow], a ; $433e
	farcall RunDialogueYesNoPrompt ; $4341
	farcall ScriptCloseDialogueWindow ; $4344
	script_wait_frames $05 ; $4347
	and a ; $434e
	jr nz, .buildMinigameModePauseMenu ; $434f
	ld a, STORYLOC_MAIN_MENU ; $4351
	ld [wStoryModeCurrentLocation], a ; $4353
	ld a, STORYENTRY_NONE ; $4356
	ld [wStoryModeEntryPoint], a ; $4358
	ld a, $ff ; $435b
	ld [wUnusedExitTriggerIdMirror], a ; $435d
	ld [wStoryModeExitTriggerRequest], a ; $4360
	jp Unused_1a_RunPauseMenuWindow.done ; $4363
.buildMinigameModePauseMenu:
	call Unused_1a_BuildMinigameModePauseMenu ; $4366
	ld a, $03 ; $4369
	ld [wMenuInitialRow], a ; $436b
	ld a, [wSuppressMinigamePauseFlag] ; $436e
	and a ; $4371
	jr nz, .runPauseMenuWindow2 ; $4372
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4374
	jr .runPauseMenuWindow2 ; $4377
.runPauseMenuWindow2:
	jp Unused_1a_RunPauseMenuWindow ; $4379
Unused_1a_BuildMinigameModePauseMenu:
	call Unused_1a_ResetPauseMenuState ; $437c
	ld a, $a0 ; $437f
	ld [wPauseMenuOptionBits], a ; $4381
	ld a, $8c ; $4384
	ld [wMenuAdjustRowMask], a ; $4386
	ld [wMenuKeepOpenRowMask], a ; $4389
	ld hl, $049a ; $438c
	ld bc, MessageSpeedSettingPtrs ; $438f
	ld de, $0304 ; $4392
	set_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4395
	ret ; $4398
