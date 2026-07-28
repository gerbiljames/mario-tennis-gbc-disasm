SECTION "ROM Bank $05", ROMX[$4000], BANK[$05]

	farptr InitTextWindows ; $4000
	farptr CreateWindowWithAttr ; $4002
	farptr CreateWindow ; $4004
	farptr CreateDialogueWindow ; $4006
	farptr CreateMenuWindowFromText ; $4008
	farptr CloseActiveDialogueWindow ; $400a
	farptr StubNop_05_4766 ; $400c
	farptr SetWindowTextId ; $400e
	farptr StubNop_05_4626 ; $4010
	farptr QueueFullTilemapCopy ; $4012
	farptr QueueFullAttrmapCopy ; $4014
	farptr CopyVisibleTilemapToVRAM ; $4016
	farptr RestoreShadowTilemap ; $4018
	farptr WriteWindowCellTileAttr ; $401a
	farptr RenderProportionalTextAt ; $401c
	farptr FetchDialogueText ; $401e
	farptr DrawTileAttrRect ; $4020
	farptr CopyTilemapRowsAnimated ; $4022
	farptr ApplyMessageSpeed ; $4024
	farptr MeasureDialogueWidthTiles ; $4026
	farptr ResetWindowState ; $4028
	farptr SetFixedMenuWindowTextId ; $402a
	farptr RunFixedTextMenu ; $402c
	farptr RenderTextString ; $402e
	farptr RenderActiveWindowText ; $4030
	farptr SetActiveWindowTextId ; $4032
	farptr ShowSpeakerDialogue ; $4034
	farptr ShowSpeakerDialogueRestoreBG ; $4036
	farptr ShowDialogueAtPosition ; $4038
	farptr DrawDialogueAtPosition ; $403a
	farptr RunMenuSelection ; $403c
	farptr RunPagedTextMenu ; $403e
	farptr RunPagedTextMenuAutoSize ; $4040
	farptr RunMenuSelectionShared ; $4042
	farptr AddTextIdOffset ; $4044
	farptr PushTextArgString ; $4046
	farptr PushTextArgNumber ; $4048
	farptr PushTextArgShortTextId ; $404a
	farptr Unused_05_SetTextVar ; $404c
	farptr FetchShortTextToBuffer ; $404e
	farptr RunDebugFlagEditor ; $4050
	farptr RunDebugMenu ; $4052
	farptr RunDebugWarpMenu ; $4054
	farptr WriteStringToWindow ; $4056
	farptr GetTilemapCellAddress ; $4058
	farptr WriteDialogueToWindow ; $405a
	farptr ResetTextWindowsAndRestoreMap ; $405c
	farptr CreateWindowWithTextId ; $405e
	farptr RedrawWindowText ; $4060
	farptr RenderWindowTextToCompletion ; $4062
	farptr RedrawWindowRowsSafe ; $4064
	farptr CloseWindowAlt ; $4066
	farptr ShowDialogueCentered ; $4068
	farptr RestoreTilemapUnderWindow ; $406a
	farptr WriteStringToTilemap ; $406c
	farptr WriteStringToTilemapAlt ; $406e
	farptr WriteStringToTilemapStreamed ; $4070
	farptr RenderTextToBuffer64 ; $4072
	farptr RunDebugWindowDemo ; $4074
	farptr ResetTextWindowState ; $4076
	farptr CreateWindowFromScreenRect ; $4078
	farptr CloseWindow ; $407a
	farptr DrawTextWindowFrame ; $407c
	farptr RedrawWindowRows ; $407e
	farptr RenderMenuWindowText ; $4080
	farptr RedrawTilemapRowRange ; $4082
	farptr RedrawAllTilemapRows ; $4084
	farptr GetWindowStructPtr ; $4086
	farptr FreeWindow ; $4088
	farptr FitWindowToText ; $408a
	farptr PrepareGlyphBuffer ; $408c
	farptr ResetGlyphStream ; $408e
	farptr UploadGlyphBuffer ; $4090
	farptr UploadGlyphTileRange ; $4092
	farptr UploadGlyphBufferFull ; $4094
InitTextWindows:
	call ResetTextWindowState ; $4096
	ret ; $4099
FetchShortTextToBuffer:
	push af ; $409a
	push bc ; $409b
	push de ; $409c
	push hl ; $409d
	ldh a, [hWramBank] ; $409e
	push af ; $40a0
	wram_bank $05 ; $40a1
	call FetchShortText ; $40a7
	ld hl, wShortTextBuffer ; $40aa
.copyLoop:
	ld a, [hl+] ; $40ad
	ld [de], a ; $40ae
	inc de ; $40af
	cp $00 ; $40b0
	jr nz, .copyLoop ; $40b2
	pop af ; $40b4
	wram_bank ; $40b5
	pop hl ; $40b9
	pop de ; $40ba
	pop bc ; $40bb
	pop af ; $40bc
	ret ; $40bd
ClearWindowGlyphPage:
	ldh a, [hWramBank] ; $40be
	push af ; $40c0
	wram_bank $05 ; $40c1
	ld hl, $d000 ; $40c7
	ld c, $80 ; $40ca
	call ClearMemory16 ; $40cc
	pop af ; $40cf
	wram_bank ; $40d0
	ret ; $40d4
QueueGlyphPageDMAOnA:
	ldh a, [hPlayerInputFlags] ; $40d5
	bit PADB_A, a ; $40d7
	jr nz, .startDMA ; $40d9
	jr .done ; $40db
.startDMA:
	xor a ; $40dd
	ldh [rVBK], a ; $40de
	wram_bank $05 ; $40e0
	ld bc, $d000 ; $40e6
	ld de, $1800 ; $40e9
	ld a, $24 ; $40ec
	ld hl, rVDMA_SRC_HIGH ; $40ee
	ld [hl], b ; $40f1
	inc hl ; $40f2
	ld [hl], c ; $40f3
	inc hl ; $40f4
	ld [hl], d ; $40f5
	inc hl ; $40f6
	ld [hl], e ; $40f7
	inc hl ; $40f8
	ld [hl], a ; $40f9
.done:
	ret ; $40fa
WriteTileToShadowMapCell:
	push af ; $40fb
	push de ; $40fc
	push bc ; $40fd
	push af ; $40fe
	wram_bank $05 ; $40ff
	pop af ; $4105
	call GetTilemapCellAddress ; $4106
	or a ; $4109
	jr z, .restore ; $410a
	ld [de], a ; $410c
.restore:
	pop bc ; $410d
	pop de ; $410e
	pop af ; $410f
	ret ; $4110
	push af ; $4111
	push de ; $4112
	push af ; $4113
	wram_bank $05 ; $4114
	pop af ; $411a
	call GetTilemapCellAddress ; $411b
	ld a, [de] ; $411e
	pop de ; $411f
	pop af ; $4120
	ret ; $4121
GetTilemapCellAddress:
	push af ; $4122
	push bc ; $4123
	push hl ; $4124
	ld a, d ; $4125
	and $1f ; $4126
	ld d, a ; $4128
	ld a, e ; $4129
	and $1f ; $412a
	ld e, a ; $412c
	ld bc, $0020 ; $412d
	ld hl, wShadowTilemapPtr ; $4130
	ld a, [hl+] ; $4133
	ld h, [hl] ; $4134
	ld l, a ; $4135
	ld a, e ; $4136
	or a ; $4137
	jr z, .addColumn ; $4138
.rowLoop:
	add hl, bc ; $413a
	dec a ; $413b
	jr nz, .rowLoop ; $413c
.addColumn:
	ld c, d ; $413e
	add hl, bc ; $413f
	ld d, h ; $4140
	ld e, l ; $4141
	pop hl ; $4142
	pop bc ; $4143
	pop af ; $4144
	ret ; $4145
CopyVisibleTilemapToVRAM:
	push af ; $4146
	push bc ; $4147
	push de ; $4148
	push hl ; $4149
	ld a, b ; $414a
	wram_bank ; $414b
	ld a, [wCameraY + 1] ; $414f
	and $1f ; $4152
	ld l, a ; $4154
	ld h, $00 ; $4155
	add hl, hl ; $4157
	add hl, hl ; $4158
	add hl, hl ; $4159
	add hl, hl ; $415a
	add hl, hl ; $415b
	ld b, h ; $415c
	ld c, l ; $415d
	ld hl, $9800 ; $415e
	add hl, bc ; $4161
	ld d, h ; $4162
	ld e, l ; $4163
	ld hl, $d000 ; $4164
	add hl, bc ; $4167
	push bc ; $4168
	ld bc, $0026 ; $4169
	add $12 ; $416c
	sub $20 ; $416e
	jr c, .queueVRAMCopy ; $4170
	jr z, .queueVRAMCopy ; $4172
	sla a ; $4174
	push af ; $4176
	ld b, a ; $4177
	ld a, c ; $4178
	sub b ; $4179
	ld c, a ; $417a
	ld b, $00 ; $417b
	call QueueVRAMCopy ; $417d
	pop af ; $4180
	ld hl, $d000 ; $4181
	ld de, $9800 ; $4184
	ld c, a ; $4187
	ld b, $00 ; $4188
.queueVRAMCopy:
	call QueueVRAMCopy ; $418a
	pop bc ; $418d
	ld hl, $9800 + VRAM_BANK1 ; $418e
	add hl, bc ; $4191
	ld d, h ; $4192
	ld e, l ; $4193
	ld hl, $d400 ; $4194
	add hl, bc ; $4197
	ld a, [wCameraY + 1] ; $4198
	and $1f ; $419b
	ld bc, $0026 ; $419d
	add $12 ; $41a0
	sub $20 ; $41a2
	jr c, .queueVRAMCopy2 ; $41a4
	jr z, .queueVRAMCopy2 ; $41a6
	sla a ; $41a8
	push af ; $41aa
	ld b, a ; $41ab
	ld a, c ; $41ac
	sub b ; $41ad
	ld c, a ; $41ae
	ld b, $00 ; $41af
	call QueueVRAMCopy ; $41b1
	pop af ; $41b4
	ld hl, $d400 ; $41b5
	ld de, $9800 + VRAM_BANK1 ; $41b8
	ld c, a ; $41bb
	ld b, $00 ; $41bc
.queueVRAMCopy2:
	call QueueVRAMCopy ; $41be
	pop hl ; $41c1
	pop de ; $41c2
	pop bc ; $41c3
	pop af ; $41c4
	ret ; $41c5
QueueFullTilemapCopy:
	push af ; $41c6
	push bc ; $41c7
	push de ; $41c8
	push hl ; $41c9
	ld a, b ; $41ca
	wram_bank ; $41cb
	ld hl, $d000 ; $41cf
	ld de, $9800 ; $41d2
	ld c, $40 ; $41d5
	call QueueVRAMCopy ; $41d7
	pop hl ; $41da
	pop de ; $41db
	pop bc ; $41dc
	pop af ; $41dd
	ret ; $41de
QueueFullAttrmapCopy:
	push af ; $41df
	push bc ; $41e0
	push de ; $41e1
	push hl ; $41e2
	ld a, b ; $41e3
	wram_bank ; $41e4
	ld hl, $d400 ; $41e8
	ld de, $9800 + VRAM_BANK1 ; $41eb
	ld c, $40 ; $41ee
	call QueueVRAMCopy ; $41f0
	pop hl ; $41f3
	pop de ; $41f4
	pop bc ; $41f5
	pop af ; $41f6
	ret ; $41f7
	push af ; $41f8
	ld a, b ; $41f9
	wram_bank ; $41fa
	pop af ; $41fe
	and $1f ; $41ff
	ld c, a ; $4201
	ld b, $00 ; $4202
	sla c ; $4204
	rl b ; $4206
	sla c ; $4208
	rl b ; $420a
	sla c ; $420c
	rl b ; $420e
	sla c ; $4210
	rl b ; $4212
	sla c ; $4214
	rl b ; $4216
	ld hl, $9800 ; $4218
	add hl, bc ; $421b
	ld d, h ; $421c
	ld e, l ; $421d
	ld hl, $d000 ; $421e
	add hl, bc ; $4221
	push bc ; $4222
	ld c, $02 ; $4223
	call QueueVRAMCopy ; $4225
	pop bc ; $4228
	ld hl, $9800 + VRAM_BANK1 ; $4229
	add hl, bc ; $422c
	ld d, h ; $422d
	ld e, l ; $422e
	ld hl, $d400 ; $422f
	add hl, bc ; $4232
	ld c, $02 ; $4233
	call QueueVRAMCopy ; $4235
	ret ; $4238
CopyTilemapRowsToVRAM:
	ld d, a ; $4239
	ld a, c ; $423a
	or a ; $423b
	jr z, .done ; $423c
	ld a, b ; $423e
	wram_bank ; $423f
	ld b, d ; $4243
	ld a, c ; $4244
	sla a ; $4245
	push af ; $4247
	ld a, b ; $4248
	ld c, a ; $4249
	ld b, $00 ; $424a
	sla c ; $424c
	rl b ; $424e
	sla c ; $4250
	rl b ; $4252
	sla c ; $4254
	rl b ; $4256
	sla c ; $4258
	rl b ; $425a
	sla c ; $425c
	rl b ; $425e
	ld hl, $9800 ; $4260
	add hl, bc ; $4263
	ld d, h ; $4264
	ld e, l ; $4265
	ld hl, $d000 ; $4266
	add hl, bc ; $4269
	pop af ; $426a
	push af ; $426b
	push bc ; $426c
	ld c, a ; $426d
	call QueueVRAMCopy ; $426e
	pop bc ; $4271
	pop af ; $4272
	ld hl, $9800 + VRAM_BANK1 ; $4273
	add hl, bc ; $4276
	ld d, h ; $4277
	ld e, l ; $4278
	ld hl, $d400 ; $4279
	add hl, bc ; $427c
	push de ; $427d
	ld c, a ; $427e
	call QueueVRAMCopy ; $427f
	pop de ; $4282
.done:
	ret ; $4283
CopyTilemapRowsAnimated:
	push af ; $4284
	push bc ; $4285
	push de ; $4286
	push hl ; $4287
	ld d, a ; $4288
	ld a, c ; $4289
	sub $07 ; $428a
	jr c, .step ; $428c
	jr z, .step ; $428e
	sub $07 ; $4290
	jr c, .step ; $4292
	jr z, .step ; $4294
	jr .step2 ; $4296
.step:
	add $07 ; $4298
.step2:
	ld e, a ; $429a
	ld a, c ; $429b
	ld c, $00 ; $429c
.loop:
	inc c ; $429e
	sub $07 ; $429f
	jr c, .loopB ; $42a1
	jr z, .loopB ; $42a3
	jr .loop ; $42a5
.loopB:
	push af ; $42a7
	push bc ; $42a8
	push de ; $42a9
	push hl ; $42aa
	ld a, c ; $42ab
	ld b, c ; $42ac
	ld c, e ; $42ad
	cp $01 ; $42ae
	jr z, .eq01 ; $42b0
	ld c, $07 ; $42b2
.eq01:
	ld a, d ; $42b4
	cp $20 ; $42b5
	jr nc, .ge20 ; $42b7
	push af ; $42b9
	add c ; $42ba
	cp $20 ; $42bb
	jr c, .restore ; $42bd
	sub $20 ; $42bf
	ld b, a ; $42c1
	push bc ; $42c2
	ld c, a ; $42c3
	xor a ; $42c4
	ld b, $05 ; $42c5
	call CopyTilemapRowsToVRAM ; $42c7
	pop bc ; $42ca
	ld a, c ; $42cb
	sub b ; $42cc
	ld c, a ; $42cd
.restore:
	pop af ; $42ce
.ge20:
	and $1f ; $42cf
	ld b, $05 ; $42d1
	call CopyTilemapRowsToVRAM ; $42d3
	pop hl ; $42d6
	pop de ; $42d7
	pop bc ; $42d8
	pop af ; $42d9
	call AdvanceFrame ; $42da
	ld a, d ; $42dd
	add $07 ; $42de
	ld d, a ; $42e0
	dec c ; $42e1
	jr nz, .loopB ; $42e2
	pop hl ; $42e4
	pop de ; $42e5
	pop bc ; $42e6
	pop af ; $42e7
	ret ; $42e8
RedrawWindowRowsPaddedThunk:
	call RedrawWindowRowsPadded ; $42e9
	ret ; $42ec
RedrawWindowRowsThunk:
	call RedrawWindowRows ; $42ed
	ret ; $42f0
RedrawActiveTextWindow:
	test_flag FLAG_DEBUG_STATIC_TEXT_WINDOW ; $42f1
	ret nz ; $42f4
	push af ; $42f5
	push bc ; $42f6
	ld a, [wDialogueWindowId] ; $42f7
	call RedrawWindowRowsPaddedThunk ; $42fa
	pop bc ; $42fd
	pop af ; $42fe
	ret ; $42ff
GetWindowCellOffset:
	call GetWindowStructPtr ; $4300
	ld a, [hl+] ; $4303
	add d ; $4304
	and $1f ; $4305
	ld d, a ; $4307
	ld a, [hl] ; $4308
	add e ; $4309
	and $1f ; $430a
	ld l, a ; $430c
	ld h, $00 ; $430d
	add hl, hl ; $430f
	add hl, hl ; $4310
	add hl, hl ; $4311
	add hl, hl ; $4312
	add hl, hl ; $4313
	ld a, d ; $4314
	add l ; $4315
	ld l, a ; $4316
	jr nc, .gotPtr ; $4317
	inc h ; $4319
.gotPtr:
	ld d, h ; $431a
	ld e, l ; $431b
	ret ; $431c
WriteWindowCellTileAttr:
	push af ; $431d
	push bc ; $431e
	push de ; $431f
	push hl ; $4320
	call GetWindowCellOffset ; $4321
	ld hl, wShadowTilemapPtr ; $4324
	ld a, [hl+] ; $4327
	ld h, [hl] ; $4328
	ld l, a ; $4329
	ldh a, [hWramBank] ; $432a
	push af ; $432c
	ld a, [wShadowTilemapBank] ; $432d
	ld a, a ; $4330
	wram_bank ; $4331
	add hl, de ; $4335
	ld [hl], c ; $4336
	ld de, $0400 ; $4337
	add hl, de ; $433a
	ld [hl], b ; $433b
	pop af ; $433c
	wram_bank ; $433d
	pop hl ; $4341
	pop de ; $4342
	pop bc ; $4343
	pop af ; $4344
	ret ; $4345
ReadWindowCellTileAttr:
	push af ; $4346
	push bc ; $4347
	push de ; $4348
	push hl ; $4349
	call GetWindowCellOffset ; $434a
	ld hl, wShadowTilemapPtr ; $434d
	ld a, [hl+] ; $4350
	ld h, [hl] ; $4351
	ld l, a ; $4352
	ldh a, [hWramBank] ; $4353
	push af ; $4355
	ld a, [wShadowTilemapBank] ; $4356
	ld a, a ; $4359
	wram_bank ; $435a
	add hl, de ; $435e
	ld c, [hl] ; $435f
	ld de, $0400 ; $4360
	add hl, de ; $4363
	ld b, [hl] ; $4364
	pop af ; $4365
	wram_bank ; $4366
	pop hl ; $436a
	pop de ; $436b
	pop bc ; $436c
	pop af ; $436d
	ret ; $436e
RestoreShadowTilemap:
	push af ; $436f
	push bc ; $4370
	push de ; $4371
	push hl ; $4372
	ldh a, [hWramBank] ; $4373
	push af ; $4375
	call RestoreAllShadowTilemapRows ; $4376
	pop af ; $4379
	wram_bank ; $437a
	pop hl ; $437e
	pop de ; $437f
	pop bc ; $4380
	pop af ; $4381
	ret ; $4382
RestoreAllShadowTilemapRows:
	ld a, [wCameraY + 1] ; $4383
	and $3f ; $4386
	ld c, $04 ; $4388
.loop:
	ld b, $05 ; $438a
.loopB:
	push af ; $438c
	push bc ; $438d
	call RestoreShadowTilemapRow ; $438e
	pop bc ; $4391
	pop af ; $4392
	inc a ; $4393
	and $3f ; $4394
	dec b ; $4396
	jr nz, .loopB ; $4397
	push af ; $4399
	ldh a, [rLCDC] ; $439a
	bit 7, a ; $439c
	jr z, .restore ; $439e
	call AdvanceFrame ; $43a0
.restore:
	pop af ; $43a3
	dec c ; $43a4
	jr nz, .loop ; $43a5
	ret ; $43a7
RestoreTilemapUnderWindow:
	push af ; $43a8
	push bc ; $43a9
	push de ; $43aa
	push hl ; $43ab
	call GetWindowStructPtr ; $43ac
	inc hl ; $43af
	ld b, [hl] ; $43b0
	inc hl ; $43b1
	inc hl ; $43b2
	ld c, [hl] ; $43b3
	ld a, [wCameraY + 1] ; $43b4
	cp b ; $43b7
	jr c, .gotRow ; $43b8
	jr z, .gotRow ; $43ba
	ld a, $20 ; $43bc
	add b ; $43be
	ld b, a ; $43bf
.gotRow:
	ld a, b ; $43c0
.rowLoop:
	push af ; $43c1
	push bc ; $43c2
	ld a, b ; $43c3
	call RestoreShadowTilemapRow ; $43c4
	pop bc ; $43c7
	pop af ; $43c8
	inc b ; $43c9
	dec c ; $43ca
	jr nz, .rowLoop ; $43cb
	pop hl ; $43cd
	pop de ; $43ce
	pop bc ; $43cf
	pop af ; $43d0
	ret ; $43d1
RestoreShadowTilemapRow:
	and $3f ; $43d2
	ld e, a ; $43d4
	ld hl, $d000 ; $43d5
	ld a, $06 ; $43d8
	ld bc, $0040 ; $43da
	ld d, e ; $43dd
.loop:
	rr d ; $43de
	jr nc, .noCarry ; $43e0
	add hl, bc ; $43e2
.noCarry:
	sla c ; $43e3
	rl b ; $43e5
	dec a ; $43e7
	jr nz, .loop ; $43e8
	ld a, [wCameraX + 1] ; $43ea
	and $3f ; $43ed
	ld d, a ; $43ef
	ld c, d ; $43f0
	ld b, $00 ; $43f1
	add hl, bc ; $43f3
	ld b, h ; $43f4
	ld c, l ; $43f5
	push bc ; $43f6
	wram_bank $03 ; $43f7
	ld hl, $c6a0 ; $43fd
	ld a, c ; $4400
	and $1f ; $4401
	add l ; $4403
	ld l, a ; $4404
	jr nc, .gotPtr ; $4405
	inc h ; $4407
.gotPtr:
	ld d, $20 ; $4408
.loopB:
	ld a, [bc] ; $440a
	ld [hl+], a ; $440b
	inc bc ; $440c
	ld a, c ; $440d
	and $1f ; $440e
	jr nz, .next ; $4410
	ld hl, $c6a0 ; $4412
	ld a, c ; $4415
	and $3f ; $4416
	jr nz, .next ; $4418
	dec bc ; $441a
	ld a, c ; $441b
	and $c0 ; $441c
	ld c, a ; $441e
.next:
	dec d ; $441f
	jr nz, .loopB ; $4420
	ld hl, wShadowTilemap ; $4422
	ld a, e ; $4425
	and $1f ; $4426
	ld d, a ; $4428
	ld a, $05 ; $4429
	ld bc, $0020 ; $442b
.loop2:
	rr d ; $442e
	jr nc, .noCarry2 ; $4430
	add hl, bc ; $4432
.noCarry2:
	sla c ; $4433
	rl b ; $4435
	dec a ; $4437
	jr nz, .loop2 ; $4438
	push de ; $443a
	ld d, h ; $443b
	ld e, l ; $443c
	ld hl, $c6a0 ; $443d
	wram_bank $05 ; $4440
	ld bc, $0002 ; $4446
	call CopyMemoryFast ; $4449
	pop de ; $444c
	pop bc ; $444d
	ld hl, $c6a0 ; $444e
	wram_bank $02 ; $4451
	ld a, c ; $4457
	and $1f ; $4458
	add l ; $445a
	ld l, a ; $445b
	jr nc, .gotPtr2 ; $445c
	inc h ; $445e
.gotPtr2:
	ld d, $20 ; $445f
.loop3:
	ld a, [bc] ; $4461
	ld [hl+], a ; $4462
	inc bc ; $4463
	ld a, c ; $4464
	and $1f ; $4465
	jr nz, .next2 ; $4467
	ld hl, $c6a0 ; $4469
	ld a, c ; $446c
	and $3f ; $446d
	jr nz, .next2 ; $446f
	dec bc ; $4471
	ld a, c ; $4472
	and $c0 ; $4473
	ld c, a ; $4475
.next2:
	dec d ; $4476
	jr nz, .loop3 ; $4477
	ld hl, $d400 ; $4479
	ld a, e ; $447c
	and $1f ; $447d
	ld d, a ; $447f
	ld a, $05 ; $4480
	ld bc, $0020 ; $4482
.loop4:
	rr d ; $4485
	jr nc, .noCarry3 ; $4487
	add hl, bc ; $4489
.noCarry3:
	sla c ; $448a
	rl b ; $448c
	dec a ; $448e
	jr nz, .loop4 ; $448f
	ld d, h ; $4491
	ld e, l ; $4492
	ld hl, $c6a0 ; $4493
	wram_bank $05 ; $4496
	ld bc, $0002 ; $449c
	call CopyMemoryFast ; $449f
	ret ; $44a2
RefreshShadowTilemapFromMapBuffer:
	push af ; $44a3
	push bc ; $44a4
	push de ; $44a5
	push hl ; $44a6
	ldh a, [hWramBank] ; $44a7
	push af ; $44a9
	wram_bank $05 ; $44aa
	ld a, [wShadowTilemapBank] ; $44b0
	push af ; $44b3
	ld hl, wShadowTilemapPtr ; $44b4
	ld a, [hl+] ; $44b7
	ld d, [hl] ; $44b8
	ld e, a ; $44b9
	ld hl, $dc76 ; $44ba
	ld a, [hl+] ; $44bd
	ld b, [hl] ; $44be
	ld c, a ; $44bf
	pop af ; $44c0
	ld a, a ; $44c1
	wram_bank ; $44c2
	ldh a, [hScrollY] ; $44c6
	and $f8 ; $44c8
	ld l, a ; $44ca
	ld h, $00 ; $44cb
	add hl, hl ; $44cd
	add hl, hl ; $44ce
	push hl ; $44cf
	add hl, de ; $44d0
	ld d, h ; $44d1
	ld e, l ; $44d2
	pop hl ; $44d3
	add hl, bc ; $44d4
	ld b, $15 ; $44d5
.loop:
	ld c, $02 ; $44d7
	call CopyMemoryFast ; $44d9
	ld a, h ; $44dc
	cp $e0 ; $44dd
	jr nc, .restore ; $44df
	ld a, d ; $44e1
	cp $e0 ; $44e2
	jr nc, .restore ; $44e4
	dec b ; $44e6
	jr nz, .loop ; $44e7
.restore:
	pop af ; $44e9
	wram_bank ; $44ea
	pop hl ; $44ee
	pop de ; $44ef
	pop bc ; $44f0
	pop af ; $44f1
	ret ; $44f2
	ld a, [wCameraY + 1] ; $44f3
	and $3f ; $44f6
	ret ; $44f8
SetFixedMenuWindowTextId:
	push bc ; $44f9
	push de ; $44fa
	push hl ; $44fb
	ldh a, [hWramBank] ; $44fc
	push af ; $44fe
	ld b, a ; $44ff
	call SetWindowTextId ; $4500
	pop af ; $4503
	wram_bank ; $4504
	ld a, b ; $4508
	ld [$d863], a ; $4509
	pop hl ; $450c
	pop de ; $450d
	pop bc ; $450e
	ret ; $450f
RunFixedTextMenu:
	push hl ; $4510
	ldh a, [hWramBank] ; $4511
	push af ; $4513
	ld hl, Text_30_26 ; $4514
	call CreateMenuWindowFromText ; $4517
	call RestoreShadowTilemap ; $451a
	call StubNop_05_4626 ; $451d
	call RunMenuSelection ; $4520
	ld h, a ; $4523
	ld a, [wMenuWindowId] ; $4524
	call CloseWindow ; $4527
	ld a, [$d863] ; $452a
	call CloseWindow ; $452d
	pop af ; $4530
	wram_bank ; $4531
	ld a, h ; $4535
	pop hl ; $4536
	ret ; $4537
SetWindowRect:
	push hl ; $4538
	ld a, d ; $4539
	and $1f ; $453a
	ld [hl+], a ; $453c
	ld a, e ; $453d
	and $1f ; $453e
	ld [hl+], a ; $4540
	ld [hl], b ; $4541
	inc hl ; $4542
	ld [hl], c ; $4543
	pop hl ; $4544
	ret ; $4545
DrawTextWindowFrameSaveRegs:
	push af ; $4546
	push bc ; $4547
	push de ; $4548
	push hl ; $4549
	call DrawTextWindowFrame ; $454a
	pop hl ; $454d
	pop de ; $454e
	pop bc ; $454f
	pop af ; $4550
	ret ; $4551
DrawTileAttrRect:
	push af ; $4552
	push bc ; $4553
	push de ; $4554
	push hl ; $4555
	ld a, [hl+] ; $4556
	ld d, [hl] ; $4557
	inc hl ; $4558
	ld e, [hl] ; $4559
	inc hl ; $455a
	ld b, [hl] ; $455b
	inc hl ; $455c
	ld c, [hl] ; $455d
	inc hl ; $455e
	push af ; $455f
.loop:
	push de ; $4560
	push bc ; $4561
	call GetTilemapCellAddress ; $4562
.loopB:
	ld a, [hl] ; $4565
	inc hl ; $4566
	ld [de], a ; $4567
	ld a, [hl] ; $4568
	inc hl ; $4569
	push hl ; $456a
	ld hl, $0400 ; $456b
	add hl, de ; $456e
	ld [hl], a ; $456f
	ld a, e ; $4570
	and $1f ; $4571
	cp $1f ; $4573
	jr nz, .ne1f ; $4575
	ld hl, $ffe0 ; $4577
	add hl, de ; $457a
	ld d, h ; $457b
	ld e, l ; $457c
.ne1f:
	inc de ; $457d
	pop hl ; $457e
	dec b ; $457f
	jr nz, .loopB ; $4580
	ld a, c ; $4582
	pop bc ; $4583
	ld c, a ; $4584
	pop de ; $4585
	inc e ; $4586
	dec c ; $4587
	jr nz, .loop ; $4588
	pop af ; $458a
	pop hl ; $458b
	pop de ; $458c
	pop bc ; $458d
	pop af ; $458e
	ret ; $458f
	push af ; $4590
	push bc ; $4591
	push de ; $4592
	ld a, [hl+] ; $4593
	ld d, [hl] ; $4594
	inc hl ; $4595
	ld e, [hl] ; $4596
	inc hl ; $4597
	ld b, [hl] ; $4598
	inc hl ; $4599
	ld c, [hl] ; $459a
	inc hl ; $459b
.loop2:
	push de ; $459c
	push bc ; $459d
.loop3:
	ld a, $00 ; $459e
	push de ; $45a0
	call GetTilemapCellAddress ; $45a1
	ld [de], a ; $45a4
	pop de ; $45a5
	dec b ; $45a6
	jr z, .countDone ; $45a7
	inc d ; $45a9
	jr .loop3 ; $45aa
.countDone:
	ld a, c ; $45ac
	pop bc ; $45ad
	ld c, a ; $45ae
	ld a, e ; $45af
	pop de ; $45b0
	ld e, a ; $45b1
	inc e ; $45b2
	dec c ; $45b3
	jr nz, .loop2 ; $45b4
	pop de ; $45b6
	pop bc ; $45b7
	pop af ; $45b8
	ret ; $45b9
	push hl ; $45ba
	push bc ; $45bb
	push de ; $45bc
	push af ; $45bd
	ld b, a ; $45be
	call FreeWindow ; $45bf
	cp $ff ; $45c2
	jr z, .restore ; $45c4
	ld a, b ; $45c6
	call FreeWindow ; $45c7
	ld a, $04 ; $45ca
	add l ; $45cc
	ld l, a ; $45cd
	jr nc, .gotPtr ; $45ce
	inc h ; $45d0
.gotPtr:
	ld d, h ; $45d1
	ld e, l ; $45d2
	ld a, [$d822] ; $45d3
	dec a ; $45d6
	ld [$d822], a ; $45d7
	ld a, [de] ; $45da
	and $02 ; $45db
	jr z, .restore ; $45dd
	ld a, [wMenuDepth] ; $45df
	or a ; $45e2
	jr z, .zero ; $45e3
	dec a ; $45e5
	ld hl, wMenuStack ; $45e6
	sla a ; $45e9
	ld c, a ; $45eb
	ld b, $00 ; $45ec
	add hl, bc ; $45ee
	ld a, [hl] ; $45ef
	and $0f ; $45f0
	ld [wMenuCursorRow], a ; $45f2
.zero:
	ld a, [wMenuDepth] ; $45f5
	dec a ; $45f8
	ld [wMenuDepth], a ; $45f9
	cp $ff ; $45fc
	jr z, .restore ; $45fe
	ld a, [wMenuDepth] ; $4600
	ld hl, wMenuStack ; $4603
	sla a ; $4606
	ld c, a ; $4608
	ld b, $00 ; $4609
	add hl, bc ; $460b
	ld a, [hl] ; $460c
	sra a ; $460d
	sra a ; $460f
	sra a ; $4611
	sra a ; $4613
	and $0f ; $4615
	ld [wMenuRowCount], a ; $4617
	inc hl ; $461a
	ld a, [hl] ; $461b
	and $0f ; $461c
	ld [wMenuWindowId], a ; $461e
.restore:
	pop af ; $4621
	pop de ; $4622
	pop bc ; $4623
	pop hl ; $4624
	ret ; $4625
StubNop_05_4626:
	ret ; $4626
AllocWindowSlotBit:
	push hl ; $4627
	push bc ; $4628
	push de ; $4629
	ld b, $07 ; $462a
	ld a, [wWindowSlotMask] ; $462c
	ld c, $01 ; $462f
.searchLoop:
	rrca ; $4631
	jr nc, .claim ; $4632
	sla c ; $4634
	dec b ; $4636
	jr nz, .searchLoop ; $4637
	ld a, $ff ; $4639
	jr .done ; $463b
.claim:
	ld a, [wWindowSlotMask] ; $463d
	or c ; $4640
	ld [wWindowSlotMask], a ; $4641
	ld a, $07 ; $4644
	sub b ; $4646
.done:
	pop de ; $4647
	pop bc ; $4648
	pop hl ; $4649
	ret ; $464a
GetScreenTopLeftCell:
	push af ; $464b
	push hl ; $464c
	ldh a, [hScrollX] ; $464d
	add $07 ; $464f
	rrca ; $4651
	rrca ; $4652
	rrca ; $4653
	and $1f ; $4654
	ld d, a ; $4656
	ldh a, [hScrollY] ; $4657
	add $07 ; $4659
	rrca ; $465b
	rrca ; $465c
	rrca ; $465d
	and $1f ; $465e
	ld e, a ; $4660
	pop hl ; $4661
	pop af ; $4662
	ret ; $4663
CreateWindowWithAttr:
	push hl ; $4664
	ld h, a ; $4665
	ldh a, [hWramBank] ; $4666
	push af ; $4668
	wram_bank $05 ; $4669
	ld a, h ; $466f
	ld [wWindowTileAttr], a ; $4670
	call CreateWindow ; $4673
	ld h, a ; $4676
	ld a, $80 ; $4677
	ld [wWindowTileAttr], a ; $4679
	pop af ; $467c
	wram_bank ; $467d
	ld a, h ; $4681
	pop hl ; $4682
	ret ; $4683
CreateWindow:
	call CreateWindowFromScreenRect ; $4684
	ret ; $4687
CreateDialogueWindow:
	push hl ; $4688
	ld a, b ; $4689
	ld [wDialogueWindowHeight], a ; $468a
	ld a, c ; $468d
	ld [wDialogueWindowWidth], a ; $468e
	push de ; $4691
	call CreateWindowFromScreenRect ; $4692
	ld [wDialogueWindowId], a ; $4695
	pop de ; $4698
	push af ; $4699
	ld h, d ; $469a
	ld l, e ; $469b
	call GetScreenTopLeftCell ; $469c
	ld a, h ; $469f
	add d ; $46a0
	and $1f ; $46a1
	ld [wDialogueWindowCol], a ; $46a3
	ld a, l ; $46a6
	add e ; $46a7
	and $1f ; $46a8
	ld [wDialogueWindowRow], a ; $46aa
	pop af ; $46ad
	pop hl ; $46ae
	ret ; $46af
CreateMenuWindowFromText:
	push bc ; $46b0
	push de ; $46b1
	push hl ; $46b2
	wram_bank $05 ; $46b3
	call FetchDialogueText ; $46b9
	push hl ; $46bc
	ld h, d ; $46bd
	ld l, e ; $46be
	call GetScreenTopLeftCell ; $46bf
	ld a, h ; $46c2
	add d ; $46c3
	and $1f ; $46c4
	ld d, a ; $46c6
	ld a, l ; $46c7
	add e ; $46c8
	and $1f ; $46c9
	ld e, a ; $46cb
	pop hl ; $46cc
	call MeasureTextDimensions ; $46cd
	ld a, c ; $46d0
	dec a ; $46d1
	sra a ; $46d2
	ld [wMenuRowCount], a ; $46d4
	ld a, b ; $46d7
	srl b ; $46d8
	srl b ; $46da
	srl b ; $46dc
	and $07 ; $46de
	jr z, .gotRows ; $46e0
	inc b ; $46e2
.gotRows:
	inc b ; $46e3
	inc b ; $46e4
	inc b ; $46e5
	call AllocWindowStruct ; $46e6
	ld a, [wWindowId] ; $46e9
	cp $ff ; $46ec
	jp z, .done ; $46ee
	ld a, [wWindowId] ; $46f1
	ld b, a ; $46f4
	call SetWindowTextId ; $46f5
	ld a, [wWindowId] ; $46f8
	ld b, $02 ; $46fb
	call SetWindowState ; $46fd
	ld a, [wMenuDepth] ; $4700
	cp $ff ; $4703
	jr z, .noCursorEntry ; $4705
	ld hl, wMenuStack ; $4707
	sla a ; $470a
	ld c, a ; $470c
	ld b, $00 ; $470d
	add hl, bc ; $470f
	ld a, [wMenuCursorRow] ; $4710
	ld b, a ; $4713
	ld a, [hl] ; $4714
	and $f0 ; $4715
	or b ; $4717
	ld [hl], a ; $4718
.noCursorEntry:
	ld a, [wMenuDepth] ; $4719
	inc a ; $471c
	ld [wMenuDepth], a ; $471d
	ld hl, wMenuStack ; $4720
	sla a ; $4723
	ld c, a ; $4725
	ld b, $00 ; $4726
	add hl, bc ; $4728
	ld a, [wMenuRowCount] ; $4729
	sla a ; $472c
	sla a ; $472e
	sla a ; $4730
	sla a ; $4732
	ld [hl+], a ; $4734
	ld a, [wWindowId] ; $4735
	ld [wMenuWindowId], a ; $4738
	ld [hl], a ; $473b
	xor a ; $473c
	ld [wMenuCursorRow], a ; $473d
	ld a, [wWindowId] ; $4740
.done:
	pop hl ; $4743
	pop de ; $4744
	pop bc ; $4745
	ret ; $4746
CreateMenuWindowPaged:
	call CreateMenuWindowFromText ; $4747
	push af ; $474a
	push bc ; $474b
	ld a, [wWindowId] ; $474c
	ld b, $03 ; $474f
	call SetWindowState ; $4751
	pop bc ; $4754
	pop af ; $4755
	ret ; $4756
ResetWindowState:
	push af ; $4757
	call GetWindowStructPtr ; $4758
	ld a, $04 ; $475b
	add l ; $475d
	ld l, a ; $475e
	jr nc, .store ; $475f
	inc h ; $4761
.store:
	ld [hl], $ff ; $4762
	pop af ; $4764
	ret ; $4765
StubNop_05_4766:
	ret ; $4766
SetWindowState:
	call GetWindowStructPtr ; $4767
	ld a, $04 ; $476a
	add l ; $476c
	ld l, a ; $476d
	jr nc, .store ; $476e
	inc h ; $4770
.store:
	ld [hl], b ; $4771
	ret ; $4772
GetWindowState:
	call GetWindowStructPtr ; $4773
	ld a, $04 ; $4776
	add l ; $4778
	ld l, a ; $4779
	jr nc, .read ; $477a
	inc h ; $477c
.read:
	ld a, [hl] ; $477d
	ret ; $477e
RunMenuSelection:
	push bc ; $477f
	push de ; $4780
	push hl ; $4781
	ldh a, [hWramBank] ; $4782
	push af ; $4784
	wram_bank $05 ; $4785
	xor a ; $478b
	ld [w5_d844], a ; $478c
	ld [w5_d845], a ; $478f
	ld a, $ff ; $4792
	ld hl, $d842 ; $4794
	ld [hl+], a ; $4797
	ld [hl], a ; $4798
	ld a, [wMenuWindowId] ; $4799
	call GetWindowStructPtr ; $479c
	ld d, [hl] ; $479f
	inc hl ; $47a0
	ld e, [hl] ; $47a1
	inc d ; $47a2
	inc e ; $47a3
	push af ; $47a4
	push bc ; $47a5
	push de ; $47a6
	push hl ; $47a7
	ld a, [wMenuCursorRow] ; $47a8
	sla a ; $47ab
	add e ; $47ad
	ld e, a ; $47ae
	call GetTilemapCellAddress ; $47af
	xor a ; $47b2
	ld hl, wTextArrowBlinkCounter ; $47b3
	ld [hl+], a ; $47b6
	ld [hl], e ; $47b7
	inc hl ; $47b8
	ld [hl], d ; $47b9
	ld a, $01 ; $47ba
	ld hl, AnimateTextArrowTask ; $47bc
	call RegisterFrameTask ; $47bf
	pop hl ; $47c2
	pop de ; $47c3
	pop bc ; $47c4
	pop af ; $47c5
	ld a, [wMenuCursorRow] ; $47c6
	ld b, a ; $47c9
.inputLoop:
	call AdvanceFrame ; $47ca
	ldh a, [hInputRisingEdge] ; $47cd
	bit PADB_A, a ; $47cf
	jr nz, .confirm ; $47d1
	ldh a, [hInputPressed] ; $47d3
	bit PADB_UP, a ; $47d5
	jr z, .checkDown ; $47d7
	dec b ; $47d9
	bit 7, b ; $47da
	jr z, .moveCursor ; $47dc
	ld a, [wMenuRowCount] ; $47de
	dec a ; $47e1
	ld b, a ; $47e2
	jr .moveCursor ; $47e3
.checkDown:
	ldh a, [hInputPressed] ; $47e5
	and PADF_DOWN ; $47e7
	jp z, .checkStart ; $47e9
	ld a, [wMenuRowCount] ; $47ec
	ld c, a ; $47ef
	inc b ; $47f0
	ld a, b ; $47f1
	cp c ; $47f2
	jr c, .moveCursor ; $47f3
	ld b, $00 ; $47f5
.moveCursor:
	sound $5e ; $47f7
	push de ; $47f9
	xor a ; $47fa
	ld [wTextArrowBlinkCounter], a ; $47fb
	ld a, b ; $47fe
	sla a ; $47ff
	add e ; $4801
	ld e, a ; $4802
	ld a, $20 ; $4803
	call WriteTileToShadowMapCell ; $4805
	push af ; $4808
	push bc ; $4809
	push de ; $480a
	push hl ; $480b
	ld hl, $d842 ; $480c
	ld a, [hl+] ; $480f
	ld h, [hl] ; $4810
	ld l, a ; $4811
	ld de, $3000 ; $4812
	add hl, de ; $4815
	ld de, $9800 ; $4816
	add hl, de ; $4819
	ld d, h ; $481a
	ld e, l ; $481b
	ld hl, w5_d844 ; $481c
	ld a, e ; $481f
	ld [hl+], a ; $4820
	ld a, d ; $4821
	ld [hl], a ; $4822
	pop hl ; $4823
	pop de ; $4824
	pop bc ; $4825
	pop af ; $4826
	pop de ; $4827
	push de ; $4828
	ld a, b ; $4829
	sla a ; $482a
	add e ; $482c
	ld e, a ; $482d
	push hl ; $482e
	call GetTilemapCellAddress ; $482f
	ld hl, $d842 ; $4832
	ld [hl], e ; $4835
	inc hl ; $4836
	ld [hl], d ; $4837
	pop hl ; $4838
	pop de ; $4839
	ld a, b ; $483a
	ld [wMenuCursorRow], a ; $483b
	jr .checkStart ; $483e
.confirm:
	ld a, b ; $4840
	ld [wMenuCursorRow], a ; $4841
	sound $5f ; $4844
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld hl, AnimateTextArrowTask ; $484a
	call UnregisterFrameTask ; $484d
	call AdvanceFrame ; $4850
	ld a, [wMenuCursorRow] ; $4853
	sla a ; $4856
	inc a ; $4858
	ld e, a ; $4859
	ld d, $01 ; $485a
	ld a, [wMenuWindowId] ; $485c
	ld c, $0d ; $485f
	ld b, $80 ; $4861
	call WriteWindowCellTileAttr ; $4863
	pop hl ; $4866
	pop de ; $4867
	pop bc ; $4868
	pop af ; $4869
	jp .done ; $486a
.checkStart:
	ldh a, [hInputRisingEdge] ; $486d
	and PADF_START ; $486f
	jp z, .checkB ; $4871
	sound $62 ; $4874
	ld a, $ff ; $4876
	jp .cancel ; $4878
.checkB:
	ldh a, [hInputPressed] ; $487b
	and PADF_B ; $487d
	jp z, .checkSideScroll ; $487f
	sound $62 ; $4882
	ld a, $ff ; $4884
	jr .cancel ; $4886
.checkSideScroll:
	call GetWindowState ; $4888
	cp $03 ; $488b
	jp nz, .inputLoop ; $488d
	ld a, [wScrollListLength] ; $4890
	dec a ; $4893
	srl a ; $4894
	srl a ; $4896
	jp z, .inputLoop ; $4898
	ldh a, [hInputPressed] ; $489b
	and PADF_LEFT ; $489d
	jp z, .checkRight ; $489f
	ld a, $fe ; $48a2
	jr .cancel ; $48a4
.checkRight:
	ldh a, [hInputPressed] ; $48a6
	and PADF_RIGHT ; $48a8
	jp z, .inputLoop ; $48aa
	ld a, $fd ; $48ad
.cancel:
	ld [wMenuCursorRow], a ; $48af
	push af ; $48b2
	push bc ; $48b3
	push de ; $48b4
	push hl ; $48b5
	ld hl, AnimateTextArrowTask ; $48b6
	call UnregisterFrameTask ; $48b9
	call AdvanceFrame ; $48bc
	ld a, [wMenuDepth] ; $48bf
	or a ; $48c2
	jr z, .restored ; $48c3
	dec a ; $48c5
	ld hl, wMenuStack ; $48c6
	sla a ; $48c9
	ld c, a ; $48cb
	ld b, $00 ; $48cc
	add hl, bc ; $48ce
	ld a, [hl+] ; $48cf
	and $0f ; $48d0
	sla a ; $48d2
	inc a ; $48d4
	ld e, a ; $48d5
	ld d, $01 ; $48d6
	ld a, [hl] ; $48d8
	and $0f ; $48d9
	ld c, $20 ; $48db
	ld b, $80 ; $48dd
	call WriteWindowCellTileAttr ; $48df
.restored:
	pop hl ; $48e2
	pop de ; $48e3
	pop bc ; $48e4
	pop af ; $48e5
.done:
	ld b, a ; $48e6
	pop af ; $48e7
	wram_bank ; $48e8
	ld a, b ; $48ec
	pop hl ; $48ed
	pop de ; $48ee
	pop bc ; $48ef
	ret ; $48f0
AnimateTextArrowTask:
	push af ; $48f1
	push bc ; $48f2
	push de ; $48f3
	push hl ; $48f4
	wram_bank $05 ; $48f5
	ld hl, wTextArrowBlinkCounter ; $48fb
	ld a, [hl+] ; $48fe
	and $10 ; $48ff
	or a ; $4901
	jr z, .zero ; $4902
	ld a, $20 ; $4904
	jr .read ; $4906
.zero:
	ld a, $0d ; $4908
.read:
	ld e, [hl] ; $490a
	inc hl ; $490b
	ld d, [hl] ; $490c
	ld h, d ; $490d
	ld l, e ; $490e
	ld de, $3000 ; $490f
	add hl, de ; $4912
	ld de, $9800 ; $4913
	add hl, de ; $4916
	ld d, h ; $4917
	ld e, l ; $4918
	ld l, a ; $4919
	ld h, $80 ; $491a
	push de ; $491c
	call QueueBGTileWrite ; $491d
	pop de ; $4920
	ld a, [wTextArrowBlinkCounter] ; $4921
	inc a ; $4924
	ld [wTextArrowBlinkCounter], a ; $4925
	ld a, [w5_d844] ; $4928
	or a ; $492b
	jr z, .restore ; $492c
	ld e, a ; $492e
	ld a, [w5_d845] ; $492f
	ld d, a ; $4932
	ld a, $20 ; $4933
	ld l, a ; $4935
	ld h, $80 ; $4936
	call QueueBGTileWrite ; $4938
	xor a ; $493b
	ld [w5_d844], a ; $493c
.restore:
	pop hl ; $493f
	pop de ; $4940
	pop bc ; $4941
	pop af ; $4942
	ret ; $4943
RunPagedTextMenu:
	push bc ; $4944
	push de ; $4945
	push hl ; $4946
	ld b, a ; $4947
	ldh a, [hWramBank] ; $4948
	push af ; $494a
	wram_bank $05 ; $494b
	ld a, b ; $4951
	add sp, -3 ; $4952
	ld b, h ; $4954
	ld c, l ; $4955
	ld hl, sp + 0 ; $4956
	ld [hl], b ; $4958
	ld hl, sp + 1 ; $4959
	ld [hl], c ; $495b
	ld hl, sp + 2 ; $495c
	ld [hl], a ; $495e
	wram_bank $05 ; $495f
	xor a ; $4965
	ld [w5_d846], a ; $4966
.pageLoop:
	ld hl, sp + 0 ; $4969
	ld b, [hl] ; $496b
	ld hl, sp + 1 ; $496c
	ld c, [hl] ; $496e
	ld a, [w5_d846] ; $496f
	ld h, $00 ; $4972
	ld l, a ; $4974
	add hl, bc ; $4975
	ld d, $01 ; $4976
	ld e, $01 ; $4978
	call CreateMenuWindowPaged ; $497a
	farcall RestoreShadowTilemap ; $497d
	call RenderMenuWindowText ; $4980
	call RunMenuSelection ; $4983
	push af ; $4986
	ld a, [wMenuWindowId] ; $4987
	call CloseWindow ; $498a
	ld a, $ff ; $498d
	ld [wMenuWindowId], a ; $498f
	pop af ; $4992
	cp $7f ; $4993
	jr nc, .checkCancel ; $4995
	ld b, a ; $4997
	ld a, [w5_d846] ; $4998
	sla a ; $499b
	sla a ; $499d
	add b ; $499f
	jr .done ; $49a0
.checkCancel:
	cp $ff ; $49a2
	jr z, .done ; $49a4
	cp $fe ; $49a6
	jr nz, .pageNext ; $49a8
	ld a, [w5_d846] ; $49aa
	dec a ; $49ad
	cp $ff ; $49ae
	jr nz, .storePagePrev ; $49b0
	ld hl, sp + 2 ; $49b2
	ld a, [hl] ; $49b4
	dec a ; $49b5
.storePagePrev:
	ld [w5_d846], a ; $49b6
	jr .pageLoop ; $49b9
.pageNext:
	ld a, [w5_d846] ; $49bb
	inc a ; $49be
	ld hl, sp + 2 ; $49bf
	ld b, [hl] ; $49c1
	cp b ; $49c2
	jr c, .storePageNext ; $49c3
	xor a ; $49c5
.storePageNext:
	ld [w5_d846], a ; $49c6
	jp .pageLoop ; $49c9
.done:
	ld [wMenuCursorRow], a ; $49cc
	add sp, 3 ; $49cf
	ld b, a ; $49d1
	pop af ; $49d2
	wram_bank ; $49d3
	ld a, b ; $49d7
	pop hl ; $49d8
	pop de ; $49d9
	pop bc ; $49da
	ret ; $49db
; Registered as a per-frame task by RunPagedTextMenuAutoSize and unregistered
; when the menu closes, so it does run every frame -- but its body reads
; wMenuCursorRow into a and then `pop af` discards it, leaving no effect. Not
; a bare `ret` stub: the register/unregister pair around it is real, only the
; work is missing.
PagedMenuFrameTask:
	push af ; $49dc
	push bc ; $49dd
	push de ; $49de
	push hl ; $49df
	ldh a, [hWramBank] ; $49e0
	push af ; $49e2
	wram_bank $05 ; $49e3
	ld a, [wMenuCursorRow] ; $49e9
	pop af ; $49ec
	wram_bank ; $49ed
	pop hl ; $49f1
	pop de ; $49f2
	pop bc ; $49f3
	pop af ; $49f4
	ret ; $49f5
RunPagedTextMenuAutoSize:
	push bc ; $49f6
	push de ; $49f7
	push hl ; $49f8
	ld b, a ; $49f9
	ldh a, [hWramBank] ; $49fa
	push af ; $49fc
	wram_bank $05 ; $49fd
	ld a, b ; $4a03
	add sp, -3 ; $4a04
	ld b, h ; $4a06
	ld c, l ; $4a07
	ld hl, sp + 0 ; $4a08
	ld [hl], b ; $4a0a
	ld hl, sp + 1 ; $4a0b
	ld [hl], c ; $4a0d
	ld hl, sp + 2 ; $4a0e
	ld [hl], a ; $4a10
	wram_bank $05 ; $4a11
	xor a ; $4a17
	ld [w5_d846], a ; $4a18
	ld a, $01 ; $4a1b
	ld hl, PagedMenuFrameTask ; $4a1d
	call RegisterFrameTask ; $4a20
.loop:
	call FetchDialogueText ; $4a23
	call MeasureTextDimensions ; $4a26
	ld a, $01 ; $4a29
	sra b ; $4a2b
	add b ; $4a2d
	ld d, a ; $4a2e
	ld hl, sp + 0 ; $4a2f
	ld b, [hl] ; $4a31
	ld hl, sp + 1 ; $4a32
	ld c, [hl] ; $4a34
	ld a, [w5_d846] ; $4a35
	ld h, $00 ; $4a38
	ld l, a ; $4a3a
	add hl, bc ; $4a3b
	ld e, $05 ; $4a3c
	call CreateMenuWindowPaged ; $4a3e
	call RestoreShadowTilemap ; $4a41
	call StubNop_05_4626 ; $4a44
	call RunMenuSelection ; $4a47
	push af ; $4a4a
	ld a, [wMenuWindowId] ; $4a4b
	call CloseWindow ; $4a4e
	ld a, $ff ; $4a51
	ld [wMenuWindowId], a ; $4a53
	pop af ; $4a56
	cp $7f ; $4a57
	jr nc, .compare ; $4a59
	ld b, a ; $4a5b
	ld a, [w5_d846] ; $4a5c
	sla a ; $4a5f
	sla a ; $4a61
	add b ; $4a63
	jr .store3 ; $4a64
.compare:
	cp $ff ; $4a66
	jr z, .store3 ; $4a68
	cp $fe ; $4a6a
	jr nz, .nefe ; $4a6c
	ld a, [w5_d846] ; $4a6e
	dec a ; $4a71
	cp $ff ; $4a72
	jr nz, .store ; $4a74
	ld hl, sp + 2 ; $4a76
	ld a, [hl] ; $4a78
	dec a ; $4a79
.store:
	ld [w5_d846], a ; $4a7a
	jr .loop ; $4a7d
.nefe:
	ld a, [w5_d846] ; $4a7f
	inc a ; $4a82
	ld hl, sp + 2 ; $4a83
	ld b, [hl] ; $4a85
	cp b ; $4a86
	jr c, .store2 ; $4a87
	xor a ; $4a89
.store2:
	ld [w5_d846], a ; $4a8a
	jp .loop ; $4a8d
.store3:
	ld [wMenuCursorRow], a ; $4a90
	add sp, 3 ; $4a93
	push af ; $4a95
	ld hl, PagedMenuFrameTask ; $4a96
	call UnregisterFrameTask ; $4a99
	pop af ; $4a9c
	ld b, a ; $4a9d
	pop af ; $4a9e
	wram_bank ; $4a9f
	ld a, b ; $4aa3
	pop hl ; $4aa4
	pop de ; $4aa5
	pop bc ; $4aa6
	ret ; $4aa7
RunMenuSelectionShared:
	push bc ; $4aa8
	push de ; $4aa9
	push hl ; $4aaa
	ldh a, [hWramBank] ; $4aab
	push af ; $4aad
	wram_bank $05 ; $4aae
	xor a ; $4ab4
	ld [w5_d844], a ; $4ab5
	ld [w5_d845], a ; $4ab8
	ld a, $ff ; $4abb
	ld hl, $d842 ; $4abd
	ld [hl+], a ; $4ac0
	ld [hl], a ; $4ac1
	ld a, [wMenuWindowId] ; $4ac2
	call GetWindowStructPtr ; $4ac5
	ld d, [hl] ; $4ac8
	inc hl ; $4ac9
	ld e, [hl] ; $4aca
	inc d ; $4acb
	inc e ; $4acc
	push af ; $4acd
	push bc ; $4ace
	push de ; $4acf
	push hl ; $4ad0
	ld a, [wMenuInitialRow] ; $4ad1
	ld [wMenuCursorRow], a ; $4ad4
	xor a ; $4ad7
	ld [wMenuInitialRow], a ; $4ad8
	ld a, [wMenuCursorRow] ; $4adb
	sla a ; $4ade
	add e ; $4ae0
	ld e, a ; $4ae1
	call GetTilemapCellAddress ; $4ae2
	xor a ; $4ae5
	ld hl, wTextArrowBlinkCounter ; $4ae6
	ld [hl+], a ; $4ae9
	ld [hl], e ; $4aea
	inc hl ; $4aeb
	ld [hl], d ; $4aec
	ld a, $01 ; $4aed
	ld hl, AnimateMenuScrollArrowsTask ; $4aef
	call RegisterFrameTask ; $4af2
	pop hl ; $4af5
	pop de ; $4af6
	pop bc ; $4af7
	pop af ; $4af8
	ld a, [wMenuCursorRow] ; $4af9
	ld b, a ; $4afc
.loop:
	call AdvanceFrame ; $4afd
	ldh a, [hInputPressed] ; $4b00
	bit PADB_A, a ; $4b02
	jp nz, LoadOverworldSpriteDef.isCursorOnAdjustRow ; $4b04
	bit 6, a ; $4b07
	jr z, .bit6Clear ; $4b09
	dec b ; $4b0b
	bit 7, b ; $4b0c
	jr z, .playSfx ; $4b0e
	ld a, [wMenuRowCount] ; $4b10
	dec a ; $4b13
	ld b, a ; $4b14
	jr .playSfx ; $4b15
.bit6Clear:
	ldh a, [hInputPressed] ; $4b17
	and PADF_DOWN ; $4b19
	jp z, LoadOverworldSpriteDef.checkInputRisingEdge ; $4b1b
	ld a, [wMenuRowCount] ; $4b1e
	ld c, a ; $4b21
	inc b ; $4b22
	ld a, b ; $4b23
	cp c ; $4b24
	jr c, .playSfx ; $4b25
	ld b, $00 ; $4b27
.playSfx:
	sound $5e ; $4b29
	push de ; $4b2b
	xor a ; $4b2c
	ld [wTextArrowBlinkCounter], a ; $4b2d
	ld a, b ; $4b30
	sla a ; $4b31
	add e ; $4b33
	ld e, a ; $4b34
	ld a, $20 ; $4b35
	call WriteTileToShadowMapCell ; $4b37
	push af ; $4b3a
	push bc ; $4b3b
	push de ; $4b3c
	push hl ; $4b3d
	ld hl, $d842 ; $4b3e
	ld a, [hl+] ; $4b41
	ld h, [hl] ; $4b42
	ld l, a ; $4b43
	ld de, $3000 ; $4b44
	add hl, de ; $4b47
	ld de, $9800 ; $4b48
	add hl, de ; $4b4b
	ld d, h ; $4b4c
	ld e, l ; $4b4d
	ld hl, w5_d844 ; $4b4e
	ld a, e ; $4b51
	ld [hl+], a ; $4b52
	ld a, d ; $4b53
	ld [hl], a ; $4b54
	pop hl ; $4b55
	pop de ; $4b56
	pop bc ; $4b57
	pop af ; $4b58
	pop de ; $4b59
	push de ; $4b5a
	ld a, b ; $4b5b
	sla a ; $4b5c
	add e ; $4b5e
	ld e, a ; $4b5f
	push hl ; $4b60
	call GetTilemapCellAddress ; $4b61
	ld hl, $d842 ; $4b64
	ld [hl], e ; $4b67
LoadOverworldSpriteDef:
	inc hl ; $4b68
	ld [hl], d ; $4b69
	pop hl ; $4b6a
	pop de ; $4b6b
	ld a, b ; $4b6c
	ld [wMenuCursorRow], a ; $4b6d
	jr .checkInputRisingEdge ; $4b70
.isCursorOnAdjustRow:
	call IsCursorOnAdjustRow ; $4b72
	or a ; $4b75
	jr nz, RunMenuSelectionShared.loop ; $4b76
	sound $5f ; $4b78
	ld a, b ; $4b7a
	ld [wMenuCursorRow], a ; $4b7b
	push af ; $4b7e
	push bc ; $4b7f
	push de ; $4b80
	push hl ; $4b81
	ld hl, AnimateMenuScrollArrowsTask ; $4b82
	call UnregisterFrameTask ; $4b85
	call AdvanceFrame ; $4b88
	ld a, [wMenuCursorRow] ; $4b8b
	sla a ; $4b8e
	inc a ; $4b90
	ld e, a ; $4b91
	ld d, $01 ; $4b92
	ld a, [wMenuWindowId] ; $4b94
	ld c, $0d ; $4b97
	ld b, $80 ; $4b99
	call WriteWindowCellTileAttr ; $4b9b
	pop hl ; $4b9e
	pop de ; $4b9f
	pop bc ; $4ba0
	pop af ; $4ba1
	jp .step7 ; $4ba2
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $4ba5
	and PADF_START ; $4ba7
	jp z, .checkInputPressed ; $4ba9
	sound $62 ; $4bac
	ld a, [wPauseMenuOptionBits] ; $4bae
	and $f0 ; $4bb1
	ld [wPauseMenuOptionBits], a ; $4bb3
	ld a, $ff ; $4bb6
	jp .store ; $4bb8
.checkInputPressed:
	ldh a, [hInputPressed] ; $4bbb
	and PADF_B ; $4bbd
	jp z, .isCursorOnAdjustRow2 ; $4bbf
	sound $62 ; $4bc2
	ld a, [wPauseMenuOptionBits] ; $4bc4
	and $f0 ; $4bc7
	ld [wPauseMenuOptionBits], a ; $4bc9
	ld a, $ff ; $4bcc
	jp .store ; $4bce
.isCursorOnAdjustRow2:
	push af ; $4bd1
	push bc ; $4bd2
	push de ; $4bd3
	push hl ; $4bd4
	call IsCursorOnAdjustRow ; $4bd5
	or a ; $4bd8
	jr z, .restore ; $4bd9
	ldh a, [hInputPressed] ; $4bdb
	and PADF_LEFT ; $4bdd
	jp z, .zero ; $4bdf
	ld a, [wPauseMenuOptionBits] ; $4be2
	and $f0 ; $4be5
	or $01 ; $4be7
	ld [wPauseMenuOptionBits], a ; $4be9
	jr .restore2 ; $4bec
.zero:
	ldh a, [hInputPressed] ; $4bee
	and PADF_RIGHT ; $4bf0
	jr z, .restore ; $4bf2
	ld a, [wPauseMenuOptionBits] ; $4bf4
	and $f0 ; $4bf7
	or $02 ; $4bf9
	ld [wPauseMenuOptionBits], a ; $4bfb
	jr .restore2 ; $4bfe
.restore:
	pop hl ; $4c00
	pop de ; $4c01
	pop bc ; $4c02
	pop af ; $4c03
	call GetWindowState ; $4c04
	cp $03 ; $4c07
	jp nz, RunMenuSelectionShared.loop ; $4c09
	ld a, [wScrollListLength] ; $4c0c
	dec a ; $4c0f
	sra a ; $4c10
	sra a ; $4c12
	jp z, RunMenuSelectionShared.loop ; $4c14
	ldh a, [hInputPressed] ; $4c17
	and PADF_LEFT ; $4c19
	jp z, .runMenuSelectionShared ; $4c1b
	ld a, $fe ; $4c1e
	jr .store ; $4c20
.runMenuSelectionShared:
	ldh a, [hInputPressed] ; $4c22
	and PADF_RIGHT ; $4c24
	jp z, RunMenuSelectionShared.loop ; $4c26
	ld a, $fd ; $4c29
.store:
	ld [wMenuCursorRow], a ; $4c2b
	jr .unregisterFrameTask ; $4c2e
.restore2:
	pop hl ; $4c30
	pop de ; $4c31
	pop bc ; $4c32
	pop af ; $4c33
	ld a, [wMenuCursorRow] ; $4c34
.unregisterFrameTask:
	push af ; $4c37
	push bc ; $4c38
	push de ; $4c39
	push hl ; $4c3a
	ld hl, AnimateMenuScrollArrowsTask ; $4c3b
	call UnregisterFrameTask ; $4c3e
	call AdvanceFrame ; $4c41
	ld a, [wMenuDepth] ; $4c44
	or a ; $4c47
	jr z, .restore3 ; $4c48
	dec a ; $4c4a
	ld hl, wMenuStack ; $4c4b
	sla a ; $4c4e
	ld c, a ; $4c50
	ld b, $00 ; $4c51
	add hl, bc ; $4c53
	ld a, [hl+] ; $4c54
	and $0f ; $4c55
	sla a ; $4c57
	inc a ; $4c59
	ld e, a ; $4c5a
	ld d, $01 ; $4c5b
	ld a, [hl] ; $4c5d
	and $0f ; $4c5e
	ld c, $20 ; $4c60
	ld b, $80 ; $4c62
	call WriteWindowCellTileAttr ; $4c64
.restore3:
	pop hl ; $4c67
	pop de ; $4c68
	pop bc ; $4c69
	pop af ; $4c6a
.step7:
	ld b, a ; $4c6b
	pop af ; $4c6c
	wram_bank ; $4c6d
	ld a, b ; $4c71
	pop hl ; $4c72
	pop de ; $4c73
	pop bc ; $4c74
	ret ; $4c75
IsCursorOnAdjustRow:
	push bc ; $4c76
	ld a, [wMenuAdjustRowMask] ; $4c77
	bit 7, a ; $4c7a
	jr z, .restore ; $4c7c
	and $7f ; $4c7e
	ld b, a ; $4c80
	ld a, [wMenuCursorRow] ; $4c81
	inc a ; $4c84
.loop:
	rrc b ; $4c85
	dec a ; $4c87
	jr nz, .loop ; $4c88
	rlc b ; $4c8a
	bit 0, b ; $4c8c
	jr z, .restore ; $4c8e
	ldh a, [hInputPressed] ; $4c90
	and PADF_UP | PADF_DOWN ; $4c92
	jr nz, .restore ; $4c94
	pop bc ; $4c96
	ld a, $01 ; $4c97
	ret ; $4c99
.restore:
	pop bc ; $4c9a
	xor a ; $4c9b
	ret ; $4c9c
AnimateMenuScrollArrowsTask:
	wram_bank $05 ; $4c9d
	ld a, [wMenuAdjustRowMask] ; $4ca3
	bit 7, a ; $4ca6
	jr z, .checkFlag ; $4ca8
	and $7f ; $4caa
	ld b, a ; $4cac
	ld a, [wMenuCursorRow] ; $4cad
	inc a ; $4cb0
.loop:
	rrc b ; $4cb1
	dec a ; $4cb3
	jr nz, .loop ; $4cb4
	rlc b ; $4cb6
	bit 0, b ; $4cb8
	jr z, .checkFlag ; $4cba
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4cbc
	jp nz, .step5 ; $4cbf
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4cc2
	jp nz, .step5 ; $4cc5
.checkFlag:
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4cc8
	jr nz, .isPauseOptionsMenuOpen ; $4ccb
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4ccd
	jp nz, .isMinigamePauseMenuOpen ; $4cd0
	jp .step3 ; $4cd3
.isPauseOptionsMenuOpen:
	ld l, $20 ; $4cd6
	ld de, $0b01 ; $4cd8
	farcall QueueWindowTileWrite ; $4cdb
	ld l, $20 ; $4cde
	ld de, $0b03 ; $4ce0
	farcall QueueWindowTileWrite ; $4ce3
	jr .step3 ; $4ce6
.isMinigamePauseMenuOpen:
	ld l, $20 ; $4ce8
	ld de, $0d05 ; $4cea
	farcall QueueWindowTileWrite ; $4ced
	ld l, $20 ; $4cf0
	ld de, $0d07 ; $4cf2
	farcall QueueWindowTileWrite ; $4cf5
	jr .step3 ; $4cf8
.step3:
	ld hl, wTextArrowBlinkCounter ; $4cfa
	ld a, [hl+] ; $4cfd
	and $10 ; $4cfe
	or a ; $4d00
	jr z, .zero ; $4d01
	ld a, $20 ; $4d03
	jr .read ; $4d05
.zero:
	ld a, $0d ; $4d07
.read:
	ld e, [hl] ; $4d09
	inc hl ; $4d0a
	ld d, [hl] ; $4d0b
	ld h, d ; $4d0c
	ld l, e ; $4d0d
	ld de, $3000 ; $4d0e
	add hl, de ; $4d11
	ld de, $9800 ; $4d12
	add hl, de ; $4d15
	ld d, h ; $4d16
	ld e, l ; $4d17
	ld l, a ; $4d18
	ld h, $80 ; $4d19
	push de ; $4d1b
	call QueueBGTileWrite ; $4d1c
	pop de ; $4d1f
	ld a, [wTextArrowBlinkCounter] ; $4d20
	inc a ; $4d23
	ld [wTextArrowBlinkCounter], a ; $4d24
	ld a, [w5_d845] ; $4d27
	or a ; $4d2a
	jr z, .done ; $4d2b
	ld d, a ; $4d2d
	ld a, [w5_d844] ; $4d2e
	ld e, a ; $4d31
	ld a, $20 ; $4d32
	ld l, a ; $4d34
	ld h, $80 ; $4d35
	call QueueBGTileWrite ; $4d37
	xor a ; $4d3a
	ld [w5_d845], a ; $4d3b
.done:
	ret ; $4d3e
.step5:
	ld a, [w5_d845] ; $4d3f
	or a ; $4d42
	jr z, .zero2 ; $4d43
	ld d, a ; $4d45
	ld a, [w5_d844] ; $4d46
	ld e, a ; $4d49
	ld a, $20 ; $4d4a
	ld l, a ; $4d4c
	ld h, $80 ; $4d4d
	call QueueBGTileWrite ; $4d4f
	xor a ; $4d52
	ld [w5_d845], a ; $4d53
.zero2:
	wram_bank $05 ; $4d56
	ld hl, wTextArrowBlinkCounter ; $4d5c
	inc [hl] ; $4d5f
	test_flag FLAG_PAUSE_OPTIONS_MENU_OPEN ; $4d60
	jr nz, .isPauseOptionsMenuOpen2 ; $4d63
	test_flag FLAG_MINIGAME_PAUSE_MENU_OPEN ; $4d65
	jr nz, .isMinigamePauseMenuOpen2 ; $4d68
	jp .doneB ; $4d6a
.isPauseOptionsMenuOpen2:
	ld l, $20 ; $4d6d
	ld de, $0b01 ; $4d6f
	farcall QueueWindowTileWrite ; $4d72
	ld l, $20 ; $4d75
	ld de, $0b03 ; $4d77
	farcall QueueWindowTileWrite ; $4d7a
	ld a, [wMenuCursorRow] ; $4d7d
	and a ; $4d80
	jr nz, .getMenuCursorBlinkPhase ; $4d81
	call GetMenuCursorBlinkPhase ; $4d83
	and a ; $4d86
	ld de, $0101 ; $4d87
	jp z, .queueWindowTileWrite ; $4d8a
	ld l, $0c ; $4d8d
	ld de, $0101 ; $4d8f
	farcall QueueWindowTileWrite ; $4d92
	ld l, $0d ; $4d95
	ld de, $0b01 ; $4d97
	farcall QueueWindowTileWrite ; $4d9a
	jp .doneB ; $4d9d
.getMenuCursorBlinkPhase:
	call GetMenuCursorBlinkPhase ; $4da0
	and a ; $4da3
	ld de, $0103 ; $4da4
	jp z, .queueWindowTileWrite ; $4da7
	ld l, $0c ; $4daa
	ld de, $0103 ; $4dac
	farcall QueueWindowTileWrite ; $4daf
	ld l, $0d ; $4db2
	ld de, $0b03 ; $4db4
	farcall QueueWindowTileWrite ; $4db7
	jp .doneB ; $4dba
.isMinigamePauseMenuOpen2:
	ld l, $20 ; $4dbd
	ld de, $0d05 ; $4dbf
	farcall QueueWindowTileWrite ; $4dc2
	ld l, $20 ; $4dc5
	ld de, $0d07 ; $4dc7
	farcall QueueWindowTileWrite ; $4dca
	ld a, [wMenuCursorRow] ; $4dcd
	cp $03 ; $4dd0
	jr z, .getMenuCursorBlinkPhase2 ; $4dd2
	call GetMenuCursorBlinkPhase ; $4dd4
	or a ; $4dd7
	ld de, $0105 ; $4dd8
	jr z, .queueWindowTileWrite ; $4ddb
	ld l, $0c ; $4ddd
	ld de, $0105 ; $4ddf
	farcall QueueWindowTileWrite ; $4de2
	ld l, $0d ; $4de5
	ld de, $0d05 ; $4de7
	farcall QueueWindowTileWrite ; $4dea
	jr .doneB ; $4ded
.getMenuCursorBlinkPhase2:
	call GetMenuCursorBlinkPhase ; $4def
	or a ; $4df2
	ld de, $0107 ; $4df3
	jr z, .queueWindowTileWrite ; $4df6
	ld l, $0c ; $4df8
	ld de, $0107 ; $4dfa
	farcall QueueWindowTileWrite ; $4dfd
	ld l, $0d ; $4e00
	ld de, $0d07 ; $4e02
	farcall QueueWindowTileWrite ; $4e05
	jr .doneB ; $4e08
.queueWindowTileWrite:
	ld l, $20 ; $4e0a
	farcall QueueWindowTileWrite ; $4e0c
.doneB:
	ret ; $4e0f
GetMenuCursorBlinkPhase:
	wram_bank $05 ; $4e10
	ld a, [wTextArrowBlinkCounter] ; $4e16
	and $10 ; $4e19
	or a ; $4e1b
	jr z, .visible ; $4e1c
	xor a ; $4e1e
	ret ; $4e1f
.visible:
	ld a, $01 ; $4e20
	ret ; $4e22
RenderTextString:
	push bc ; $4e23
	ld a, [$d84f] ; $4e24
	or a ; $4e27
	jr z, .zero ; $4e28
	ld bc, $3a00 ; $4e2a
	add hl, bc ; $4e2d
	ld b, h ; $4e2e
	ld c, l ; $4e2f
	ld hl, $d84e ; $4e30
	ld a, [hl+] ; $4e33
	ld h, [hl] ; $4e34
	ld l, a ; $4e35
	add hl, bc ; $4e36
	xor a ; $4e37
	ld [$d84f], a ; $4e38
.zero:
	ld a, [wGlyphWindowId] ; $4e3b
	or a ; $4e3e
	jr nz, .initGlyphStreamForWindow ; $4e3f
	xor a ; $4e41
	ld [wGlyphRowStartCol], a ; $4e42
	ld [wGlyphFlushedCol], a ; $4e45
.initGlyphStreamForWindow:
	call InitGlyphStreamForWindow ; $4e48
	call RedrawActiveTextWindow ; $4e4b
	ld a, d ; $4e4e
	and $1f ; $4e4f
	ld [$d82a], a ; $4e51
	ld a, e ; $4e54
	and $1f ; $4e55
	ld [$d82b], a ; $4e57
	call GetTilemapCellAddress ; $4e5a
TextInterpreterLoop:
	ld a, [wTextPageBreakRequest] ; $4e5d
	or a ; $4e60
	jr z, .zero ; $4e61
	ld a, l ; $4e63
	ld [$d84e], a ; $4e64
	ld a, h ; $4e67
	ld [$d84f], a ; $4e68
	pop bc ; $4e6b
	ret ; $4e6c
.zero:
	ld a, l ; $4e6d
	ld [wTextStreamPtr], a ; $4e6e
	ld a, h ; $4e71
	ld [wTextStreamPtr + 1], a ; $4e72
	ld a, [hl] ; $4e75
	inc hl ; $4e76
	ld b, a ; $4e77
	or a ; $4e78
	jr nz, .compare ; $4e79
	test_flag FLAG_TEXT_RENDER_ACTIVE ; $4e7b
	jr nz, .restore ; $4e7e
	call FlushGlyphRow ; $4e80
.restore:
	pop bc ; $4e83
	ret ; $4e84
.compare:
	cp $de ; $4e85
	jr z, .eqde ; $4e87
	cp $df ; $4e89
	jr z, .eqdf ; $4e8b
	cp $0e ; $4e8d
	jr z, .eq0e ; $4e8f
	cp $20 ; $4e91
	jr nc, .ge20 ; $4e93
	jr .dispatchControlCode ; $4e95
.eqde:
	ld a, $1e ; $4e97
	jr .dispatchControlCode ; $4e99
.eqdf:
	ld a, $1f ; $4e9b
	jr .dispatchControlCode ; $4e9d
.eq0e:
	push af ; $4e9f
	ld a, [hl+] ; $4ea0
	ld [wTextCharNameArg], a ; $4ea1
	pop af ; $4ea4
.dispatchControlCode:
	call DispatchControlCode ; $4ea5
	call RedrawActiveTextWindow ; $4ea8
	jr TextInterpreterLoop ; $4eab
.ge20:
	ld a, b ; $4ead
	call WrapTextCellPointer ; $4eae
	call DrawStreamGlyph ; $4eb1
	call UploadLastGlyphTiles ; $4eb4
	call DelayTextCharacter ; $4eb7
	inc de ; $4eba
	ld a, e ; $4ebb
	and $1f ; $4ebc
	jp nz, TextInterpreterLoop ; $4ebe
	push hl ; $4ec1
	push de ; $4ec2
	ld h, d ; $4ec3
	ld l, e ; $4ec4
	ld de, $ffe0 ; $4ec5
	add hl, de ; $4ec8
	ld d, h ; $4ec9
	ld e, l ; $4eca
	pop de ; $4ecb
	pop hl ; $4ecc
	jp TextInterpreterLoop ; $4ecd
TextCmdNewline:
	call DrawStreamGlyph ; $4ed0
	push af ; $4ed3
	ld a, [$d82b] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	and $1f ; $4ed9
	ld [$d82b], a ; $4edb
	ld e, a ; $4ede
	ld a, [$d82a] ; $4edf
	ld d, a ; $4ee2
	call GetTilemapCellAddress ; $4ee3
	pop af ; $4ee6
	ret ; $4ee7
TextCmdNop:
	ret ; $4ee8
TextCmdNextGlyphStreamRow:
	push af ; $4ee9
	push bc ; $4eea
	push hl ; $4eeb
	ld hl, wGlyphTileWritePtr ; $4eec
	ld a, [hl+] ; $4eef
	ld h, [hl] ; $4ef0
	ld l, a ; $4ef1
	ld a, $40 ; $4ef2
	add l ; $4ef4
	ld l, a ; $4ef5
	jr nc, .gotPtr ; $4ef6
	inc h ; $4ef8
.gotPtr:
	ld b, h ; $4ef9
	ld c, l ; $4efa
	ld hl, wGlyphTileWritePtr ; $4efb
	ld a, c ; $4efe
	ld [hl+], a ; $4eff
	ld [hl], b ; $4f00
	call StartGlyphStreamRow ; $4f01
	ldh a, [hWramBank] ; $4f04
	push af ; $4f06
	wram_bank $05 ; $4f07
	ld hl, wGlyphVramDest ; $4f0d
	ld a, [hl+] ; $4f10
	ld h, [hl] ; $4f11
	ld l, a ; $4f12
	ld a, [wTextRowIndent] ; $4f13
	cpl ; $4f16
	inc a ; $4f17
	sla a ; $4f18
	add l ; $4f1a
	ld l, a ; $4f1b
	jr nc, .storeGlyphVramDest ; $4f1c
	inc h ; $4f1e
.storeGlyphVramDest:
	ld a, l ; $4f1f
	ld [wGlyphVramDest], a ; $4f20
	ld a, h ; $4f23
	ld [wGlyphVramDest + 1], a ; $4f24
	ld d, h ; $4f27
	ld e, l ; $4f28
	pop af ; $4f29
	wram_bank ; $4f2a
	pop hl ; $4f2e
	pop bc ; $4f2f
	pop af ; $4f30
	ret ; $4f31
TextCmdDelay30:
	push af ; $4f32
	ld a, [wTextRedrawGuard] ; $4f33
	or a ; $4f36
	jr nz, .nonZero ; $4f37
	ld a, $01 ; $4f39
	ld [wTextRedrawGuard], a ; $4f3b
	call RedrawActiveTextWindow ; $4f3e
	xor a ; $4f41
	ld [wTextRedrawGuard], a ; $4f42
.nonZero:
	ld a, $1e ; $4f45
.loop:
	call AdvanceFrame ; $4f47
	dec a ; $4f4a
	jr nz, .loop ; $4f4b
	pop af ; $4f4d
	ret ; $4f4e
TextCmdDelay15Skippable:
	push af ; $4f4f
	push bc ; $4f50
	ld a, [wTextRedrawGuard] ; $4f51
	or a ; $4f54
	jr nz, .nonZero ; $4f55
	ld a, $01 ; $4f57
	ld [wTextRedrawGuard], a ; $4f59
	call RedrawActiveTextWindow ; $4f5c
	xor a ; $4f5f
	ld [wTextRedrawGuard], a ; $4f60
.nonZero:
	ld b, $0f ; $4f63
.loop:
	call AdvanceFrame ; $4f65
	ldh a, [hInputPressed] ; $4f68
	and $f3 ; $4f6a
	jr nz, .restore ; $4f6c
	dec b ; $4f6e
	jr nz, .loop ; $4f6f
.restore:
	pop bc ; $4f71
	pop af ; $4f72
	ret ; $4f73
TextCmdWaitButtonPage:
	push af ; $4f74
	push de ; $4f75
	ld a, $01 ; $4f76
	call WrapTextCellPointer ; $4f78
	call GetTextContinueArrowCell ; $4f7b
	call GetTilemapCellAddress ; $4f7e
	ld [de], a ; $4f81
	call RedrawActiveTextWindow ; $4f82
	xor a ; $4f85
	ld hl, wTextArrowBlinkCounter ; $4f86
	ld [hl+], a ; $4f89
	ld [hl], e ; $4f8a
	inc hl ; $4f8b
	ld [hl], d ; $4f8c
	push af ; $4f8d
	push bc ; $4f8e
	push de ; $4f8f
	push hl ; $4f90
	ld a, $01 ; $4f91
	ld hl, TextContinueArrowBlinkTask ; $4f93
	call RegisterFrameTask ; $4f96
	call WaitTextAdvanceInput ; $4f99
	ld a, $10 ; $4f9c
	ld [wTextArrowBlinkCounter], a ; $4f9e
	call AdvanceFrame ; $4fa1
	ld hl, TextContinueArrowBlinkTask ; $4fa4
	call UnregisterFrameTask ; $4fa7
	set_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4faa
	call AdvanceFrame ; $4fad
	clear_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4fb0
	pop hl ; $4fb3
	pop de ; $4fb4
	pop bc ; $4fb5
	pop af ; $4fb6
	ld a, $01 ; $4fb7
	ld [wTextPageBreakRequest], a ; $4fb9
	pop de ; $4fbc
	pop af ; $4fbd
	ret ; $4fbe
GetTextContinueArrowCell:
	test_flag FLAG_DEBUG_STATIC_TEXT_WINDOW ; $4fbf
	jr z, .notDebugStaticTextWindow ; $4fc2
	ld d, $0a ; $4fc4
	ld e, $11 ; $4fc6
	ret ; $4fc8
.notDebugStaticTextWindow:
	push af ; $4fc9
	push bc ; $4fca
	push hl ; $4fcb
	ld a, [wDialogueWindowId] ; $4fcc
	call GetWindowStructPtr ; $4fcf
	ld d, [hl] ; $4fd2
	inc hl ; $4fd3
	ld e, [hl] ; $4fd4
	inc hl ; $4fd5
	ld a, [hl+] ; $4fd6
	sra a ; $4fd7
	add d ; $4fd9
	ld d, a ; $4fda
	ld a, [hl+] ; $4fdb
	dec a ; $4fdc
	add e ; $4fdd
	ld e, a ; $4fde
	pop hl ; $4fdf
	pop bc ; $4fe0
	pop af ; $4fe1
	ret ; $4fe2
TextContinueArrowBlinkTask:
	push af ; $4fe3
	push bc ; $4fe4
	push de ; $4fe5
	push hl ; $4fe6
	wram_bank $05 ; $4fe7
	ld hl, wTextArrowBlinkCounter ; $4fed
	ld a, [hl+] ; $4ff0
	and $10 ; $4ff1
	or a ; $4ff3
	jr z, .zero ; $4ff4
	ld a, $08 ; $4ff6
	jr .read ; $4ff8
.zero:
	ld a, $01 ; $4ffa
.read:
	ld e, [hl] ; $4ffc
	inc hl ; $4ffd
	ld d, [hl] ; $4ffe
	ld h, d ; $4fff
	ld l, e ; $5000
	ld de, $3000 ; $5001
	add hl, de ; $5004
	ld de, $9800 ; $5005
	add hl, de ; $5008
	ld d, h ; $5009
	ld e, l ; $500a
	ld l, a ; $500b
	ld h, $80 ; $500c
	call QueueBGTileWrite ; $500e
	ld a, [wTextArrowBlinkCounter] ; $5011
	inc a ; $5014
	ld [wTextArrowBlinkCounter], a ; $5015
	pop hl ; $5018
	pop de ; $5019
	pop bc ; $501a
	pop af ; $501b
	ret ; $501c
WaitTextAdvanceInput:
	push af ; $501d
	push bc ; $501e
	ld a, [wTextRedrawGuard] ; $501f
	or a ; $5022
	jr nz, .redrawActiveTextWindow ; $5023
	ld a, $01 ; $5025
	ld [wTextRedrawGuard], a ; $5027
	call RedrawActiveTextWindow ; $502a
	xor a ; $502d
	ld [wTextRedrawGuard], a ; $502e
.redrawActiveTextWindow:
	call RedrawActiveTextWindow ; $5031
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $5034
	jr nz, .restore ; $5037
	call FlushGlyphRow ; $5039
	ldh a, [hPlayerInputFlags] ; $503c
	and $f3 ; $503e
	jr z, .loopB ; $5040
	ld b, $1e ; $5042
.loop:
	call AdvanceFrame ; $5044
	ldh a, [hPlayerInputFlags] ; $5047
	and $f3 ; $5049
	jr z, .loopB ; $504b
	dec b ; $504d
	jr nz, .loop ; $504e
.loopB:
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $5050
	jr nz, .restore ; $5053
	call AdvanceRandomSeed ; $5055
	call AdvanceFrame ; $5058
	ldh a, [hInputPressed] ; $505b
	and $f3 ; $505d
	jr z, .loopB ; $505f
.restore:
	pop bc ; $5061
	pop af ; $5062
	ret ; $5063
TextCmdDelay150Skippable:
	push af ; $5064
	push bc ; $5065
	ld a, [wTextRedrawGuard] ; $5066
	or a ; $5069
	jr nz, .nonZero ; $506a
	ld a, $01 ; $506c
	ld [wTextRedrawGuard], a ; $506e
	call RedrawActiveTextWindow ; $5071
	xor a ; $5074
	ld [wTextRedrawGuard], a ; $5075
.nonZero:
	ld b, $96 ; $5078
.loop:
	call AdvanceFrame ; $507a
	ldh a, [hInputPressed] ; $507d
	and $f3 ; $507f
	jr nz, .restore ; $5081
	dec b ; $5083
	jr nz, .loop ; $5084
.restore:
	pop bc ; $5086
	pop af ; $5087
	ret ; $5088
TextCmdPrintArgString:
	push af ; $5089
	push bc ; $508a
	ldh a, [hWramBank] ; $508b
	push af ; $508d
	wram_bank $05 ; $508e
	ld hl, wTextArgStringQueue ; $5094
	ld a, [wTextArgStringCount] ; $5097
	ld b, a ; $509a
	ld a, [wTextArgStringWriteIndex] ; $509b
	cp b ; $509e
	jr z, .restore ; $509f
	ld c, a ; $50a1
	sla c ; $50a2
	inc a ; $50a4
	ld [wTextArgStringWriteIndex], a ; $50a5
	ld b, $00 ; $50a8
	add hl, bc ; $50aa
	ld b, h ; $50ab
	ld c, l ; $50ac
	inc bc ; $50ad
	ld a, [hl+] ; $50ae
	ld h, [hl] ; $50af
	ld l, a ; $50b0
	ld a, h ; $50b1
	or a ; $50b2
	jr z, .restore ; $50b3
	xor a ; $50b5
	ld [bc], a ; $50b6
	ld a, h ; $50b7
	sra a ; $50b8
	sra a ; $50ba
	sra a ; $50bc
	sra a ; $50be
	or a ; $50c0
	jr z, .zero ; $50c1
	ld b, a ; $50c3
	ld a, h ; $50c4
	and $0f ; $50c5
	or $d0 ; $50c7
	ld h, a ; $50c9
	ld a, b ; $50ca
	wram_bank ; $50cb
	jr .copyMemoryBC ; $50cf
.zero:
	ld b, a ; $50d1
	ld a, h ; $50d2
	and $0f ; $50d3
	or $c0 ; $50d5
	ld h, a ; $50d7
.copyMemoryBC:
	push de ; $50d8
	ld de, wInlineTextBuffer ; $50d9
	ld bc, $0020 ; $50dc
	call CopyMemoryBC ; $50df
	pop de ; $50e2
	wram_bank $05 ; $50e3
	ld hl, wInlineTextBuffer ; $50e9
	call RenderInlineString ; $50ec
.restore:
	pop af ; $50ef
	wram_bank ; $50f0
	pop bc ; $50f4
	pop af ; $50f5
	ret ; $50f6
PushTextArgString:
	push af ; $50f7
	push bc ; $50f8
	push de ; $50f9
	push hl ; $50fa
	ld a, h ; $50fb
	and $f0 ; $50fc
	cp $d0 ; $50fe
	jr nz, .maskId ; $5100
	ld a, h ; $5102
	and $0f ; $5103
	ld b, a ; $5105
	ldh a, [hWramBank] ; $5106
	sla a ; $5108
	sla a ; $510a
	sla a ; $510c
	sla a ; $510e
	or b ; $5110
	ld h, a ; $5111
	jr .push ; $5112
.maskId:
	ld a, h ; $5114
	and $0f ; $5115
	ld h, a ; $5117
.push:
	ldh a, [hWramBank] ; $5118
	push af ; $511a
	wram_bank $05 ; $511b
	ld d, h ; $5121
	ld e, l ; $5122
	ld a, [wTextArgStringWriteIndex] ; $5123
	cp $10 ; $5126
	jr z, .done ; $5128
	ld b, $00 ; $512a
	ld c, a ; $512c
	sla c ; $512d
	inc a ; $512f
	ld [wTextArgStringWriteIndex], a ; $5130
	ld [wTextArgStringCount], a ; $5133
	ld hl, wTextArgStringQueue ; $5136
	add hl, bc ; $5139
	ld [hl], e ; $513a
	inc hl ; $513b
	ld [hl], d ; $513c
.done:
	pop af ; $513d
	wram_bank ; $513e
	pop hl ; $5142
	pop de ; $5143
	pop bc ; $5144
	pop af ; $5145
	ret ; $5146
PushTextArgNumber:
	push af ; $5147
	push bc ; $5148
	push de ; $5149
	push hl ; $514a
	ldh a, [hWramBank] ; $514b
	push af ; $514d
	wram_bank $05 ; $514e
	ld d, h ; $5154
	ld e, l ; $5155
	ld a, [w5_d848] ; $5156
	cp $10 ; $5159
	jr z, .done ; $515b
	ld b, $00 ; $515d
	ld c, a ; $515f
	sla c ; $5160
	inc a ; $5162
	ld [w5_d848], a ; $5163
	ld [w5_d84b], a ; $5166
	ld hl, wTextArgNumberQueue ; $5169
	add hl, bc ; $516c
	ld [hl], e ; $516d
	inc hl ; $516e
	ld [hl], d ; $516f
.done:
	pop af ; $5170
	wram_bank ; $5171
	pop hl ; $5175
	pop de ; $5176
	pop bc ; $5177
	pop af ; $5178
	ret ; $5179
PushTextArgShortTextId:
	push af ; $517a
	push bc ; $517b
	push de ; $517c
	push hl ; $517d
	ld d, a ; $517e
	ldh a, [hWramBank] ; $517f
	push af ; $5181
	wram_bank $05 ; $5182
	ld a, [wTextArgShortTextWriteIndex] ; $5188
	cp $10 ; $518b
	jr z, .restore ; $518d
	ld b, $00 ; $518f
	ld c, a ; $5191
	inc a ; $5192
	ld [wTextArgShortTextWriteIndex], a ; $5193
	ld [w5_d84c], a ; $5196
	ld hl, $d8f0 ; $5199
	add hl, bc ; $519c
	ld [hl], d ; $519d
.restore:
	pop af ; $519e
	wram_bank ; $519f
	pop hl ; $51a3
	pop de ; $51a4
	pop bc ; $51a5
	pop af ; $51a6
	ret ; $51a7
TextCmdApplyDakuten:
	push de ; $51a8
	dec de ; $51a9
	ld h, $ff ; $51aa
	ld l, $e0 ; $51ac
	add hl, de ; $51ae
	ld d, h ; $51af
	ld e, l ; $51b0
	call WrapTextCellPointerPrevRow ; $51b1
	ld a, [de] ; $51b4
	cp $03 ; $51b5
	jr nz, .ne03 ; $51b7
	ld a, $0e ; $51b9
	jr .store ; $51bb
.ne03:
	ld a, $de ; $51bd
.store:
	ld [de], a ; $51bf
	pop de ; $51c0
	call RedrawActiveTextWindow ; $51c1
	call DelayTextCharacter ; $51c4
	ret ; $51c7
TextCmdApplyHandakuten:
	push de ; $51c8
	dec de ; $51c9
	ld h, $ff ; $51ca
	ld l, $e0 ; $51cc
	add hl, de ; $51ce
	ld d, h ; $51cf
	ld e, l ; $51d0
	call WrapTextCellPointerPrevRow ; $51d1
	ld a, [de] ; $51d4
	cp $03 ; $51d5
	jr nz, .ne03 ; $51d7
	ld a, $0f ; $51d9
	jr .store ; $51db
.ne03:
	ld a, $df ; $51dd
.store:
	ld [de], a ; $51df
	pop de ; $51e0
	call RedrawActiveTextWindow ; $51e1
	call DelayTextCharacter ; $51e4
	ret ; $51e7
TextCmdPrintPlayerName:
	push af ; $51e8
	push bc ; $51e9
	ld hl, wStoryModeNameOfMainCharacter ; $51ea
	call RenderInlineString ; $51ed
	pop bc ; $51f0
	pop af ; $51f1
	ret ; $51f2
TextCmdPrintPartnerName:
	push af ; $51f3
	push bc ; $51f4
	ld hl, wStoryModeNameOfPartnerCharacter ; $51f5
	call RenderInlineString ; $51f8
	pop bc ; $51fb
	pop af ; $51fc
	ret ; $51fd
MeasureNextArgStringWidth:
	push bc ; $51fe
	push hl ; $51ff
	wram_bank $05 ; $5200
	ld a, [w5_d866] ; $5206
	ld b, $00 ; $5209
	ld c, a ; $520b
	inc a ; $520c
	ld [w5_d866], a ; $520d
	sla c ; $5210
	ld hl, wTextArgStringQueue ; $5212
	add hl, bc ; $5215
	ld a, [hl+] ; $5216
	ld h, [hl] ; $5217
	ld l, a ; $5218
	ld a, h ; $5219
	sra a ; $521a
	res 7, a ; $521c
	sra a ; $521e
	sra a ; $5220
	sra a ; $5222
	or a ; $5224
	jr z, .zero ; $5225
	ld b, a ; $5227
	ld a, h ; $5228
	and $0f ; $5229
	or $d0 ; $522b
	ld h, a ; $522d
	ld a, b ; $522e
	wram_bank ; $522f
	jr .copyMemoryBC ; $5233
.zero:
	ld b, a ; $5235
	ld a, h ; $5236
	and $0f ; $5237
	or $c0 ; $5239
	ld h, a ; $523b
	ld a, b ; $523c
	wram_bank ; $523d
.copyMemoryBC:
	push de ; $5241
	ld de, wInlineTextBuffer ; $5242
	ld bc, $0020 ; $5245
	call CopyMemoryBC ; $5248
	pop de ; $524b
	wram_bank $05 ; $524c
	ld hl, wInlineTextBuffer ; $5252
	ld b, $00 ; $5255
.loop:
	ld a, [hl+] ; $5257
	or a ; $5258
	jr z, .zero2 ; $5259
	call GetGlyphWidth ; $525b
	ld a, c ; $525e
	add b ; $525f
	ld b, a ; $5260
	jr .loop ; $5261
.zero2:
	ld a, b ; $5263
	pop hl ; $5264
	pop bc ; $5265
	ret ; $5266
MeasureMainCharacterNameWidth:
	push bc ; $5267
	push hl ; $5268
	ld hl, wStoryModeNameOfMainCharacter ; $5269
	ld b, $00 ; $526c
.loop:
	ld a, [hl+] ; $526e
	cp $00 ; $526f
	jr z, .eq00 ; $5271
	call GetGlyphWidth ; $5273
	ld a, c ; $5276
	add b ; $5277
	ld b, a ; $5278
	jr .loop ; $5279
.eq00:
	ld a, b ; $527b
	pop hl ; $527c
	pop bc ; $527d
	ret ; $527e
MeasurePartnerCharacterNameWidth:
	push bc ; $527f
	push hl ; $5280
	ld hl, wStoryModeNameOfPartnerCharacter ; $5281
	ld b, $00 ; $5284
.loop:
	ld a, [hl+] ; $5286
	cp $00 ; $5287
	jr z, .eq00 ; $5289
	call GetGlyphWidth ; $528b
	ld a, c ; $528e
	add b ; $528f
	ld b, a ; $5290
	jr .loop ; $5291
.eq00:
	ld a, b ; $5293
	pop hl ; $5294
	pop bc ; $5295
	ret ; $5296
TextCmdNop2:
	ret ; $5297
GetNextArgShortTextLength:
	push bc ; $5298
	push hl ; $5299
	ld a, [$d868] ; $529a
	ld b, $00 ; $529d
	ld c, a ; $529f
	inc a ; $52a0
	ld [$d868], a ; $52a1
	ld hl, $d8f0 ; $52a4
	add hl, bc ; $52a7
	ld a, [hl] ; $52a8
	ld l, a ; $52a9
	ld h, $00 ; $52aa
	ld b, h ; $52ac
	ld c, l ; $52ad
	ld hl, $0000 ; $52ae
	add hl, bc ; $52b1
	call FetchShortText ; $52b2
	ld hl, wShortTextBuffer ; $52b5
	ld b, $00 ; $52b8
.loop:
	ld a, [hl+] ; $52ba
	cp $00 ; $52bb
	jr z, .eq00 ; $52bd
	cp $de ; $52bf
	jr z, .loop ; $52c1
	cp $df ; $52c3
	jr z, .loop ; $52c5
	inc b ; $52c7
	jr .loop ; $52c8
.eq00:
	ld a, b ; $52ca
	pop hl ; $52cb
	pop bc ; $52cc
	ret ; $52cd
TextCmdPrintArgNumber:
	push bc ; $52ce
	ldh a, [hWramBank] ; $52cf
	push af ; $52d1
	wram_bank $05 ; $52d2
	ld a, [w5_d84b] ; $52d8
	ld b, a ; $52db
	ld a, [w5_d848] ; $52dc
	cp b ; $52df
	jr z, .restore ; $52e0
	ld b, $00 ; $52e2
	ld c, a ; $52e4
	sla c ; $52e5
	inc a ; $52e7
	ld [w5_d848], a ; $52e8
	ld hl, wTextArgNumberQueue ; $52eb
	add hl, bc ; $52ee
	ld c, [hl] ; $52ef
	inc hl ; $52f0
	ld b, [hl] ; $52f1
	pop af ; $52f2
	wram_bank ; $52f3
	ld h, b ; $52f7
	ld l, c ; $52f8
	call RenderInlineNumber ; $52f9
	jr .restore2 ; $52fc
.restore:
	pop af ; $52fe
	wram_bank ; $52ff
.restore2:
	pop bc ; $5303
	ret ; $5304
MeasureNextArgNumberWidth:
	push hl ; $5305
	push bc ; $5306
	push de ; $5307
	ld a, [$d867] ; $5308
	ld b, $00 ; $530b
	ld c, a ; $530d
	sla c ; $530e
	inc a ; $5310
	ld [$d867], a ; $5311
	ld hl, wTextArgNumberQueue ; $5314
	add hl, bc ; $5317
	ld e, [hl] ; $5318
	inc hl ; $5319
	ld d, [hl] ; $531a
	ld h, d ; $531b
	ld l, e ; $531c
	ld bc, $d8f0 ; $531d
	ld de, $2710 ; $5320
	add hl, bc ; $5323
	ld a, $05 ; $5324
	bit 7, h ; $5326
	jr z, IsTileBlockedAt.step ; $5328
	add hl, de ; $532a
.loop:
	add hl, bc ; $532b
	bit 7, h ; $532c
	jr z, .loop ; $532e
	add hl, de ; $5330
	ld bc, $fc18 ; $5331
	ld de, $03e8 ; $5334
	add hl, bc ; $5337
	ld a, $04 ; $5338
	bit 7, h ; $533a
	jr z, IsTileBlockedAt.step ; $533c
	add hl, de ; $533e
.loopB:
	add hl, bc ; $533f
	bit 7, h ; $5340
	jr z, .loopB ; $5342
	add hl, de ; $5344
	ld bc, hSpriteQueueBase ; $5345
	ld de, $0064 ; $5348
IsTileBlockedAt:
	add hl, bc ; $534b
	ld a, $03 ; $534c
	bit 7, h ; $534e
	jr z, .step ; $5350
	add hl, de ; $5352
.loop:
	add hl, bc ; $5353
	bit 7, h ; $5354
	jr z, .loop ; $5356
	add hl, de ; $5358
	ld bc, $fff6 ; $5359
	ld de, $000a ; $535c
	add hl, bc ; $535f
	ld a, $02 ; $5360
	bit 7, h ; $5362
	jr z, .step ; $5364
	add hl, de ; $5366
.loopB:
	add hl, bc ; $5367
	bit 7, h ; $5368
	jr z, .loopB ; $536a
	add hl, de ; $536c
	ld a, $01 ; $536d
.step:
	ld b, $00 ; $536f
.loop2:
	push af ; $5371
	push hl ; $5372
	dec a ; $5373
	add a ; $5374
	ld hl, PowersOfTen_05 ; $5375
	add l ; $5378
	ld l, a ; $5379
	jr nc, .read ; $537a
	inc h ; $537c
.read:
	ld a, [hl+] ; $537d
	ld d, [hl] ; $537e
	ld e, a ; $537f
	pop hl ; $5380
	xor a ; $5381
.loop3:
	ld a, l ; $5382
	sub e ; $5383
	ld l, a ; $5384
	ld a, h ; $5385
	sbc d ; $5386
	ld h, a ; $5387
	bit 7, h ; $5388
	jr nz, .offset ; $538a
	inc a ; $538c
	jr .loop3 ; $538d
.offset:
	add hl, de ; $538f
	ld c, $30 ; $5390
	add c ; $5392
	call GetGlyphWidth ; $5393
	ld a, c ; $5396
	add b ; $5397
	ld b, a ; $5398
	pop af ; $5399
	dec a ; $539a
	jr nz, .loop2 ; $539b
	ld a, b ; $539d
	pop de ; $539e
	pop bc ; $539f
	pop hl ; $53a0
	ret ; $53a1
PowersOfTen_05:
	; $53a2, 10 bytes (records:2)
	dw $0001 ; record 0
	dw $000a ; record 1
	dw $0064 ; record 2
	dw $03e8 ; record 3
	dw $2710 ; record 4
Unused_05_53ac:
	ret ; $53ac
	ret ; $53ad
Unused_05_SetTextVar:
	push af ; $53ae
	push bc ; $53af
	push de ; $53b0
	push hl ; $53b1
	ld b, a ; $53b2
	ldh a, [hWramBank] ; $53b3
	push af ; $53b5
	wram_bank $05 ; $53b6
	ld a, b ; $53bc
	ld [w5_d85d], a ; $53bd
	pop af ; $53c0
	wram_bank ; $53c1
	pop hl ; $53c5
	pop de ; $53c6
	pop bc ; $53c7
	pop af ; $53c8
	ret ; $53c9
TextCmdPrintShortText:
	push af ; $53ca
	push bc ; $53cb
	ld a, [wTextCharNameArg] ; $53cc
	push de ; $53cf
	ld hl, $001b ; $53d0
	add l ; $53d3
	ld l, a ; $53d4
	jr nc, .fetchShortTextToBuffer ; $53d5
	inc h ; $53d7
.fetchShortTextToBuffer:
	ld de, wInlineTextBuffer ; $53d8
	call FetchShortTextToBuffer ; $53db
	pop de ; $53de
	ld hl, wInlineTextBuffer ; $53df
	call RenderInlineString ; $53e2
	pop bc ; $53e5
	pop af ; $53e6
	ret ; $53e7
MeasureIndexedShortTextWidth:
	push bc ; $53e8
	push de ; $53e9
	push hl ; $53ea
	ld a, [wTextCharNameArg] ; $53eb
	ld hl, $001b ; $53ee
	add l ; $53f1
	ld l, a ; $53f2
	jr nc, .fetchShortTextToBuffer ; $53f3
	inc h ; $53f5
.fetchShortTextToBuffer:
	ld de, wInlineTextBuffer ; $53f6
	farcall FetchShortTextToBuffer ; $53f9
	ld hl, wInlineTextBuffer ; $53fc
	ld b, $00 ; $53ff
.loop:
	ld a, [hl+] ; $5401
	cp $00 ; $5402
	jr z, .eq00 ; $5404
	call GetGlyphWidth ; $5406
	ld a, c ; $5409
	add b ; $540a
	ld b, a ; $540b
	jr .loop ; $540c
.eq00:
	ld a, b ; $540e
	pop hl ; $540f
	pop de ; $5410
	pop bc ; $5411
	ret ; $5412
WrapTextCellPointer:
	push af ; $5413
	push hl ; $5414
	ld h, d ; $5415
	ld l, e ; $5416
	srl h ; $5417
	rr l ; $5419
	srl h ; $541b
	rr l ; $541d
	srl l ; $541f
	sra l ; $5421
	sra l ; $5423
	ld a, [$d82b] ; $5425
	cp l ; $5428
	jr z, .step ; $5429
	ld a, e ; $542b
	sub $20 ; $542c
	ld e, a ; $542e
	jr nc, .step ; $542f
	ld e, a ; $5431
	dec d ; $5432
.step:
	ld a, d ; $5433
	and $03 ; $5434
	ld h, a ; $5436
	or $d0 ; $5437
	ld d, a ; $5439
	pop hl ; $543a
	pop af ; $543b
	ret ; $543c
WrapTextCellPointerPrevRow:
	push af ; $543d
	push hl ; $543e
	ld h, d ; $543f
	ld l, e ; $5440
	srl h ; $5441
	rr l ; $5443
	srl h ; $5445
	rr l ; $5447
	srl l ; $5449
	srl l ; $544b
	srl l ; $544d
	ld a, [$d82b] ; $544f
	dec a ; $5452
	and $1f ; $5453
	cp l ; $5455
	jr z, .step ; $5456
	ld a, e ; $5458
	sub $20 ; $5459
	ld e, a ; $545b
	jr nc, .step ; $545c
	and $3f ; $545e
	ld e, a ; $5460
	dec d ; $5461
.step:
	ld a, d ; $5462
	and $03 ; $5463
	ld h, a ; $5465
	or $d0 ; $5466
	ld d, a ; $5468
	pop hl ; $5469
	pop af ; $546a
	ret ; $546b
DispatchControlCode:
	push hl ; $546c
	ld hl, ControlCodeDispatchReturn ; $546d
	push hl ; $5470
	push af ; $5471
	push bc ; $5472
	push de ; $5473
	sla a ; $5474
	ld hl, ControlCodeHandlers_05 ; $5476
	ld c, a ; $5479
	ld b, $00 ; $547a
	add hl, bc ; $547c
	ld d, h ; $547d
	ld e, l ; $547e
	ld a, [de] ; $547f
	ld l, a ; $5480
	inc de ; $5481
	ld a, [de] ; $5482
	ld h, a ; $5483
	pop de ; $5484
	pop bc ; $5485
	pop af ; $5486
	jp hl ; $5487
ControlCodeDispatchReturn:
	pop hl ; $5488
	ret ; $5489
ControlCodeHandler16:
	ret ; $548a
ControlCodeHandler17:
	ret ; $548b
ControlCodeHandler18:
	ret ; $548c
ControlCodeHandler19:
	ret ; $548d
TextCmdNop0:
	ret ; $548e
ControlCodeHandlers_05:
	; $548f, 64 bytes (records:2)
	dw TextCmdNop0 ; record 0
	dw TextCmdNewline ; record 1
	dw TextCmdWaitButtonPage ; record 2
	dw WaitTextAdvanceInput ; record 3
	dw TextCmdPrintArgString ; record 4
	dw TextCmdDelay30 ; record 5
	dw TextCmdDelay15Skippable ; record 6
	dw TextCmdPrintPlayerName ; record 7
	dw TextCmdNop2 ; record 8
	dw TextCmdPrintArgNumber ; record 9
	dw TextCmdNop ; record 10
	dw TextCmdPrintPartnerName ; record 11
	dw TextCmdDelay150Skippable ; record 12
	dw TextCmdNextGlyphStreamRow ; record 13
	dw TextCmdPrintShortText ; record 14
	dw TextCmdNewline ; record 15
	dw ControlCodeHandler16 ; record 16
	dw ControlCodeHandler17 ; record 17
	dw ControlCodeHandler18 ; record 18
	dw ControlCodeHandler19 ; record 19
	dw TextCmdNewline ; record 20
	dw TextCmdNewline ; record 21
	dw TextCmdNewline ; record 22
	dw TextCmdNewline ; record 23
	dw TextCmdNewline ; record 24
	dw TextCmdNewline ; record 25
	dw TextCmdNewline ; record 26
	dw TextCmdNewline ; record 27
	dw TextCmdNewline ; record 28
	dw TextCmdNewline ; record 29
	dw TextCmdApplyDakuten ; record 30
	dw TextCmdApplyHandakuten ; record 31
RenderInlineString:
	push af ; $54cf
	ld a, [wTextStreamPtr + 1] ; $54d0
	cp $c6 ; $54d3
	jr nz, .checkWrap ; $54d5
	ld a, [wTextStreamPtr] ; $54d7
	or a ; $54da
	jr z, .charLoop ; $54db
.checkWrap:
	dec de ; $54dd
	ld a, [de] ; $54de
	inc de ; $54df
	cp $05 ; $54e0
	jr z, .charLoop ; $54e2
	ld a, e ; $54e4
	and $1f ; $54e5
	jr nz, .charLoop ; $54e7
	push hl ; $54e9
	ld h, d ; $54ea
	ld l, e ; $54eb
	ld de, $ffe0 ; $54ec
	add hl, de ; $54ef
	ld d, h ; $54f0
	ld e, l ; $54f1
	pop hl ; $54f2
.charLoop:
	ld a, [hl] ; $54f3
	cp $00 ; $54f4
	jr z, .done ; $54f6
	test_flag FLAG_PROPORTIONAL_TEXT_MODE ; $54f8
	jr nz, .proportional ; $54fb
	call DrawInlineGlyph ; $54fd
	call UploadLastGlyphTiles ; $5500
	jr .checkMark ; $5503
.proportional:
	call StampGlyphTileAtPen ; $5505
	call DrawInlineGlyph ; $5508
	call StampGlyphTileAtPen ; $550b
	call UploadLastGlyphTiles ; $550e
.checkMark:
	inc hl ; $5511
	ld a, [hl] ; $5512
	cp $de ; $5513
	jr z, .markChar ; $5515
	cp $df ; $5517
	jr nz, .nextCell ; $5519
.markChar:
	push hl ; $551b
	push bc ; $551c
	ld h, d ; $551d
	ld l, e ; $551e
	ld bc, $ffe0 ; $551f
	add hl, bc ; $5522
	push af ; $5523
	ld a, [wShadowTilemapPtr + 1] ; $5524
	ld c, a ; $5527
	ld a, h ; $5528
	cp c ; $5529
	jr nc, .cellPtrOk ; $552a
	ld bc, $0400 ; $552c
	add hl, bc ; $552f
.cellPtrOk:
	pop af ; $5530
	ld b, a ; $5531
	ld a, [hl] ; $5532
	cp $03 ; $5533
	ld a, b ; $5535
	jr nz, .writeMark ; $5536
	sub $d0 ; $5538
.writeMark:
	ld [hl], a ; $553a
	pop bc ; $553b
	pop hl ; $553c
	inc hl ; $553d
.nextCell:
	call DelayTextCharacter ; $553e
	inc de ; $5541
	ld a, e ; $5542
	and $1f ; $5543
	jr nz, .charLoop ; $5545
	push hl ; $5547
	ld h, d ; $5548
	ld l, e ; $5549
	ld de, $ffe0 ; $554a
	add hl, de ; $554d
	ld d, h ; $554e
	ld e, l ; $554f
	pop hl ; $5550
	jr .charLoop ; $5551
.done:
	pop af ; $5553
	ret ; $5554
	push af ; $5555
	push bc ; $5556
	push hl ; $5557
	add sp, -10 ; $5558
	ld hl, sp + 0 ; $555a
	push de ; $555c
	ld d, h ; $555d
	ld e, l ; $555e
	ld b, h ; $555f
	ld c, l ; $5560
	ld h, $00 ; $5561
	ld l, a ; $5563
	call FormatHexWord ; $5564
	jp RenderInlineNumber.zero ; $5567
	push af ; $556a
	push bc ; $556b
	push hl ; $556c
	ld b, h ; $556d
	ld c, l ; $556e
	add sp, -10 ; $556f
	ld hl, sp + 0 ; $5571
	push de ; $5573
	ld d, h ; $5574
	ld e, l ; $5575
	ld h, b ; $5576
	ld l, c ; $5577
	ld b, d ; $5578
	ld c, e ; $5579
	call FormatHexWord ; $557a
	jp RenderInlineNumber.zero ; $557d
	push af ; $5580
	push bc ; $5581
	push hl ; $5582
	add sp, -10 ; $5583
	ld hl, sp + 0 ; $5585
	push de ; $5587
	ld d, h ; $5588
	ld e, l ; $5589
	ld b, h ; $558a
	ld c, l ; $558b
	ld h, $00 ; $558c
	ld l, a ; $558e
	ld a, $04 ; $558f
	call FormatDecimalNumber ; $5591
	jp RenderInlineNumber.zero ; $5594
RenderInlineNumber:
	push af ; $5597
	push bc ; $5598
	push hl ; $5599
	ld b, h ; $559a
	ld c, l ; $559b
	add sp, -10 ; $559c
	ld hl, sp + 0 ; $559e
	push de ; $55a0
	ld d, h ; $55a1
	ld e, l ; $55a2
	ld h, b ; $55a3
	ld l, c ; $55a4
	ld b, d ; $55a5
	ld c, e ; $55a6
	ld a, $00 ; $55a7
	call FormatDecimalNumber ; $55a9
	ld a, [wTextNumberRightAlign] ; $55ac
	or a ; $55af
	jr z, .zero ; $55b0
	push bc ; $55b2
	ld h, b ; $55b3
	ld l, c ; $55b4
	ld d, $00 ; $55b5
	ld e, $05 ; $55b7
.loop:
	ld a, [hl+] ; $55b9
	or a ; $55ba
	jr z, .restore ; $55bb
	dec e ; $55bd
	jr nz, .loop ; $55be
.restore:
	pop bc ; $55c0
	pop hl ; $55c1
	add hl, de ; $55c2
	ld d, h ; $55c3
	ld e, l ; $55c4
	ld h, b ; $55c5
	ld l, c ; $55c6
	jr .renderInlineString ; $55c7
.zero:
	ld h, b ; $55c9
	ld l, c ; $55ca
	pop de ; $55cb
.renderInlineString:
	call RenderInlineString ; $55cc
	add sp, 10 ; $55cf
	pop hl ; $55d1
	pop bc ; $55d2
	pop af ; $55d3
	ret ; $55d4
SetWindowTextId:
	ld d, h ; $55d5
	ld e, l ; $55d6
	ld a, b ; $55d7
	call GetWindowStructPtr ; $55d8
	ld a, $06 ; $55db
	add l ; $55dd
	ld l, a ; $55de
	jr nc, .store ; $55df
	inc h ; $55e1
.store:
	ld a, e ; $55e2
	ld [hl+], a ; $55e3
	ld [hl], d ; $55e4
	ret ; $55e5
SetActiveWindowTextId:
	push af ; $55e6
	push bc ; $55e7
	xor a ; $55e8
	call AddTextIdOffset ; $55e9
	push hl ; $55ec
	ld a, [wDialogueWindowId] ; $55ed
	ld b, a ; $55f0
	call SetWindowTextId ; $55f1
	pop hl ; $55f4
	pop bc ; $55f5
	pop af ; $55f6
	ret ; $55f7
RenderWindowText:
	push af ; $55f8
	push bc ; $55f9
	push de ; $55fa
	push hl ; $55fb
	ld a, b ; $55fc
	call GetWindowStructPtr ; $55fd
	push hl ; $5600
	ld a, $06 ; $5601
	add l ; $5603
	ld l, a ; $5604
	jr nc, .read ; $5605
	inc h ; $5607
.read:
	ld a, [hl+] ; $5608
	ld b, [hl] ; $5609
	ld c, a ; $560a
	pop de ; $560b
	ld a, b ; $560c
	and $3f ; $560d
	ld b, a ; $560f
	ld a, [wTextPageBreakRequest] ; $5610
	or a ; $5613
	jr z, .zero ; $5614
	xor a ; $5616
	ld [wTextPageBreakRequest], a ; $5617
.zero:
	ld a, b ; $561a
	cp $03 ; $561b
	ld a, $01 ; $561d
	ld [$d85f], a ; $561f
	jr z, .restore ; $5622
	xor a ; $5624
	ld [$d85f], a ; $5625
	ld h, d ; $5628
	ld l, e ; $5629
	push hl ; $562a
	push hl ; $562b
	ld h, b ; $562c
	ld l, c ; $562d
	call FetchDialogueText ; $562e
	pop hl ; $5631
	ld a, [hl+] ; $5632
	inc a ; $5633
	and $1f ; $5634
	ld d, a ; $5636
	ld a, [hl+] ; $5637
	inc a ; $5638
	and $1f ; $5639
	ld e, a ; $563b
	pop hl ; $563c
	ld hl, wTextBuffer ; $563d
	call RenderTextString ; $5640
.restore:
	pop hl ; $5643
	pop de ; $5644
	pop bc ; $5645
	pop af ; $5646
	ret ; $5647
RenderActiveWindowText:
	push af ; $5648
	push bc ; $5649
	ld a, [wDialogueWindowId] ; $564a
	ld b, a ; $564d
	call RenderWindowText ; $564e
	pop bc ; $5651
	pop af ; $5652
	ret ; $5653
FitWindowToText:
	push af ; $5654
	push bc ; $5655
	push de ; $5656
	push hl ; $5657
	ld hl, wTextBuffer ; $5658
	ld a, [$d84f] ; $565b
	or a ; $565e
	jr z, .measure ; $565f
	ld hl, $d84e ; $5661
	ld a, [hl+] ; $5664
	ld h, [hl] ; $5665
	ld l, a ; $5666
.measure:
	xor a ; $5667
	ld b, a ; $5668
	ld d, a ; $5669
	ld e, a ; $566a
.charLoop:
	ld a, [hl+] ; $566b
	cp $00 ; $566c
	jp z, .lastLine ; $566e
	cp $02 ; $5671
	jp z, .lastLine ; $5673
	cp $01 ; $5676
	jr z, .newline ; $5678
	jr .checkArgShortText ; $567a
.newline:
	inc e ; $567c
	ld a, d ; $567d
	cp b ; $567e
	ld a, b ; $567f
	ld b, $00 ; $5680
	jr nc, .charLoop ; $5682
	ld d, a ; $5684
	jr .charLoop ; $5685
.checkArgShortText:
	cp $08 ; $5687
	jr nz, .checkArgNumber ; $5689
	call GetNextArgShortTextLength ; $568b
	add b ; $568e
	ld b, a ; $568f
	jr .charLoop ; $5690
.checkArgNumber:
	cp $09 ; $5692
	jr nz, .checkMainCharName ; $5694
	call MeasureNextArgNumberWidth ; $5696
	add b ; $5699
	ld b, a ; $569a
	jr .charLoop ; $569b
.checkMainCharName:
	cp $07 ; $569d
	jr nz, .checkArgString ; $569f
	call MeasureMainCharacterNameWidth ; $56a1
	add b ; $56a4
	ld b, a ; $56a5
	jr .charLoop ; $56a6
.checkArgString:
	cp $04 ; $56a8
	jr nz, .checkPartnerName ; $56aa
	call MeasureNextArgStringWidth ; $56ac
	add b ; $56af
	ld b, a ; $56b0
	jr .charLoop ; $56b1
.checkPartnerName:
	cp $0b ; $56b3
	jr nz, .checkIndexedShortText ; $56b5
	call MeasurePartnerCharacterNameWidth ; $56b7
	add b ; $56ba
	ld b, a ; $56bb
	jr .charLoop ; $56bc
.checkIndexedShortText:
	cp $0e ; $56be
	jr nz, .glyph ; $56c0
	ld a, [hl+] ; $56c2
	ld [wTextCharNameArg], a ; $56c3
	call MeasureIndexedShortTextWidth ; $56c6
	add b ; $56c9
	ld b, a ; $56ca
	jr .charLoop ; $56cb
.glyph:
	cp $20 ; $56cd
	jp c, .charLoop ; $56cf
	cp $7b ; $56d2
	jp nc, .charLoop ; $56d4
	call GetGlyphWidth ; $56d7
	ld a, c ; $56da
	add b ; $56db
	ld b, a ; $56dc
	jp .charLoop ; $56dd
.lastLine:
	inc e ; $56e0
	ld a, d ; $56e1
	cp b ; $56e2
	jr nc, .toCells ; $56e3
	ld d, b ; $56e5
.toCells:
	ld a, d ; $56e6
	and $07 ; $56e7
	jr z, .roundedWidth ; $56e9
	ld a, $01 ; $56eb
.roundedWidth:
	srl d ; $56ed
	srl d ; $56ef
	srl d ; $56f1
	add d ; $56f3
	ld d, a ; $56f4
	ld a, d ; $56f5
	ld [$d854], a ; $56f6
	ld a, e ; $56f9
	ld [$d86f], a ; $56fa
	inc d ; $56fd
	inc d ; $56fe
	sla e ; $56ff
	inc e ; $5701
	push de ; $5702
	ld a, [wDialogueWindowId] ; $5703
	cp $ff ; $5706
	jr nz, .placeWindow ; $5708
	xor a ; $570a
.placeWindow:
	sla a ; $570b
	sla a ; $570d
	ld b, $00 ; $570f
	ld c, a ; $5711
	ld hl, $d800 ; $5712
	add hl, bc ; $5715
	ld c, [hl] ; $5716
	inc hl ; $5717
	ld b, [hl] ; $5718
	ld h, b ; $5719
	ld l, c ; $571a
	pop bc ; $571b
	ld a, [wDialogueWindowHeight] ; $571c
	sub b ; $571f
	srl a ; $5720
	ld d, a ; $5722
	ld a, [wDialogueWindowCol] ; $5723
WaitActorsIdleTimeout:
	add d ; $5726
	ld d, a ; $5727
	ld a, [wDialogueWindowWidth] ; $5728
	sub c ; $572b
	srl a ; $572c
	ld e, a ; $572e
	ld a, [wDialogueWindowRow] ; $572f
	add e ; $5732
	ld e, a ; $5733
	ld a, [wDialogueWindowId] ; $5734
	call GetWindowStructPtr ; $5737
	call SetWindowRect ; $573a
	ld [$d867], a ; $573d
	pop hl ; $5740
	pop de ; $5741
	pop bc ; $5742
	pop af ; $5743
	ret ; $5744
MeasureTextDimensions:
	push af ; $5745
	push de ; $5746
	push hl ; $5747
	ld hl, wTextBuffer ; $5748
	xor a ; $574b
	ld b, a ; $574c
	ld d, a ; $574d
	ld e, a ; $574e
.loop:
	ld a, [hl+] ; $574f
	cp $00 ; $5750
	jr z, .eq00 ; $5752
	cp $01 ; $5754
	jr nz, .compare ; $5756
	inc e ; $5758
	ld a, d ; $5759
	cp b ; $575a
	ld a, b ; $575b
	ld b, $00 ; $575c
	jr nc, .loop ; $575e
	ld d, a ; $5760
	jr .loop ; $5761
.compare:
	cp $08 ; $5763
	jr nz, .compare2 ; $5765
	call GetNextArgShortTextLength ; $5767
	add b ; $576a
	ld b, a ; $576b
	jr .loop ; $576c
.compare2:
	cp $09 ; $576e
	jr nz, .compare3 ; $5770
	call MeasureNextArgNumberWidth ; $5772
	add b ; $5775
	ld b, a ; $5776
	jr .loop ; $5777
.compare3:
	cp $20 ; $5779
	jr c, .loop ; $577b
	cp $7b ; $577d
	jr nc, .loop ; $577f
	call GetGlyphWidth ; $5781
	ld a, c ; $5784
	add b ; $5785
	ld b, a ; $5786
	jr .loop ; $5787
.eq00:
	inc e ; $5789
	ld a, d ; $578a
	cp b ; $578b
	jr nc, .countLeft ; $578c
	ld d, b ; $578e
.countLeft:
	inc d ; $578f
	inc d ; $5790
	inc d ; $5791
	sla e ; $5792
	inc e ; $5794
	push de ; $5795
	pop bc ; $5796
	pop hl ; $5797
	pop de ; $5798
	pop af ; $5799
	ret ; $579a
DelayTextCharacter:
	push af ; $579b
	push bc ; $579c
	push de ; $579d
	push hl ; $579e
	ld c, a ; $579f
	ldh a, [hWramBank] ; $57a0
	push af ; $57a2
	wram_bank $05 ; $57a3
	ld a, [wTextRedrawGuard] ; $57a9
	or a ; $57ac
	ld b, a ; $57ad
	jr z, .restore ; $57ae
	ld a, c ; $57b0
	cp $20 ; $57b1
	jr nz, .checkSpeed ; $57b3
	ld b, $04 ; $57b5
	jr .waitFrame ; $57b7
.checkSpeed:
	ld a, [w5_d862] ; $57b9
	cp $08 ; $57bc
	jr z, .waitFrame ; $57be
	push bc ; $57c0
	ld e, a ; $57c1
	sla e ; $57c2
	sla e ; $57c4
	ld d, $9a ; $57c6
	ld a, c ; $57c8
	and $03 ; $57c9
	add e ; $57cb
	add d ; $57cc
	call PlaySoundManaged ; $57cd
	pop bc ; $57d0
.waitFrame:
	call AdvanceFrame ; $57d1
	ldh a, [hPlayerInputFlags] ; $57d4
	and $f3 ; $57d6
	jr nz, .restore ; $57d8
	dec b ; $57da
	jr nz, .waitFrame ; $57db
.restore:
	pop af ; $57dd
	wram_bank ; $57de
	pop hl ; $57e2
	pop de ; $57e3
	pop bc ; $57e4
	pop af ; $57e5
	ret ; $57e6
ApplyMessageSpeed:
	push af ; $57e7
	ldh a, [hWramBank] ; $57e8
	push af ; $57ea
	wram_bank $05 ; $57eb
	ld a, [wMessageSpeed] ; $57f1
	bit 7, a ; $57f4
	jr z, .speed1 ; $57f6
	xor a ; $57f8
	ld [wTextRedrawGuard], a ; $57f9
	jr .store ; $57fc
.speed1:
	or a ; $57fe
	jr nz, .speed2 ; $57ff
	ld a, $00 ; $5801
	ld [wTextRedrawGuard], a ; $5803
	jr .store ; $5806
.speed2:
	cp $01 ; $5808
	jr nz, .speed3 ; $580a
	ld a, $02 ; $580c
	ld [wTextRedrawGuard], a ; $580e
	jr .store ; $5811
.speed3:
	ld a, $04 ; $5813
	ld [wTextRedrawGuard], a ; $5815
.store:
	pop af ; $5818
	wram_bank ; $5819
	pop af ; $581d
	ret ; $581e
ShowSpeakerDialogue:
	push af ; $581f
	push bc ; $5820
	push de ; $5821
	ld b, a ; $5822
	ldh a, [hWramBank] ; $5823
	push af ; $5825
	wram_bank $05 ; $5826
	xor a ; $582c
	ld [wTextArgStringWriteIndex], a ; $582d
	ld [w5_d866], a ; $5830
	ld [w5_d848], a ; $5833
	ld [w5_d867], a ; $5836
	ld [wTextArgShortTextWriteIndex], a ; $5839
	ld [w5_d868], a ; $583c
	call AddTextIdOffset ; $583f
	ld a, b ; $5842
	cp $ff ; $5843
	jr nz, .store ; $5845
	ld a, $00 ; $5847
.store:
	ld [w5_d851], a ; $5849
	call ApplyMessageSpeed ; $584c
	bit 7, a ; $584f
	ld b, $08 ; $5851
	jr nz, .negative ; $5853
	call GetSpeakerVoice ; $5855
	ld b, a ; $5858
.negative:
	ld a, b ; $5859
	ld [w5_d862], a ; $585a
	ld a, [wDialogueWindowId] ; $585d
	cp $ff ; $5860
	jr nz, .loop ; $5862
	xor a ; $5864
	ld [wGlyphRowStartCol], a ; $5865
	ld [wGlyphFlushedCol], a ; $5868
	ldh a, [hWramBank] ; $586b
	push af ; $586d
	wram_bank $07 ; $586e
	call ClearGlyphBuffer ; $5874
	call UploadGlyphBufferFull ; $5877
	pop af ; $587a
	wram_bank ; $587b
	ld a, [$d851] ; $587f
	call OpenSpeechBubble ; $5882
	call RestoreShadowTilemap ; $5885
.loop:
	xor a ; $5888
	ld [wGlyphRowStartCol], a ; $5889
	ld [wGlyphFlushedCol], a ; $588c
	ldh a, [hWramBank] ; $588f
	push af ; $5891
	wram_bank $07 ; $5892
	call ClearGlyphBuffer ; $5898
	call UploadGlyphBufferFull ; $589b
	pop af ; $589e
	wram_bank ; $589f
	call SetActiveWindowTextId ; $58a3
	ld a, [wDialogueWindowId] ; $58a6
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $58a9
	call DrawTextWindowFrame ; $58ac
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $58af
	call RedrawWindowRowsPadded ; $58b2
	call RenderActiveWindowText ; $58b5
	ld a, [wTextPageBreakRequest] ; $58b8
	or a ; $58bb
	jr z, .zero ; $58bc
	ld a, [wDialogueWindowId] ; $58be
	call RestoreTilemapUnderWindow ; $58c1
	call FitWindowToText ; $58c4
	jr .loop ; $58c7
.zero:
	ld a, [wDialogueWindowId] ; $58c9
	call CloseWindow ; $58cc
	ld a, $ff ; $58cf
	ld [wDialogueWindowId], a ; $58d1
	xor a ; $58d4
	ld [wTextArgStringWriteIndex], a ; $58d5
	ld [$d866], a ; $58d8
	ld [$d848], a ; $58db
	ld [$d867], a ; $58de
	ld [wTextArgShortTextWriteIndex], a ; $58e1
	ld [$d868], a ; $58e4
	pop af ; $58e7
	wram_bank ; $58e8
	pop de ; $58ec
	pop bc ; $58ed
	pop af ; $58ee
	ret ; $58ef
ShowSpeakerDialogueRestoreBG:
	push af ; $58f0
	push bc ; $58f1
	push de ; $58f2
	ld b, a ; $58f3
	ldh a, [hWramBank] ; $58f4
	push af ; $58f6
	wram_bank $05 ; $58f7
	xor a ; $58fd
	ld [wTextArgStringWriteIndex], a ; $58fe
	ld [w5_d866], a ; $5901
	ld [w5_d848], a ; $5904
	ld [w5_d867], a ; $5907
	ld [wTextArgShortTextWriteIndex], a ; $590a
	ld [w5_d868], a ; $590d
	call AddTextIdOffset ; $5910
	ld a, b ; $5913
	cp $ff ; $5914
	jr nz, .store ; $5916
	ld a, $00 ; $5918
.store:
	ld [w5_d851], a ; $591a
	call ApplyMessageSpeed ; $591d
	bit 7, a ; $5920
	ld b, $08 ; $5922
	jr nz, .negative ; $5924
	call GetSpeakerVoice ; $5926
	ld b, a ; $5929
.negative:
	ld a, b ; $592a
	ld [w5_d862], a ; $592b
	ld a, [wDialogueWindowId] ; $592e
	cp $ff ; $5931
	jr nz, .loop ; $5933
	xor a ; $5935
	ld [wGlyphRowStartCol], a ; $5936
	ld [wGlyphFlushedCol], a ; $5939
	ldh a, [hWramBank] ; $593c
	push af ; $593e
	wram_bank $07 ; $593f
	call ClearGlyphBuffer ; $5945
	call UploadGlyphBufferFull ; $5948
	pop af ; $594b
	wram_bank ; $594c
	ld a, [$d851] ; $5950
	call OpenSpeechBubble ; $5953
.loop:
	xor a ; $5956
	ld [wGlyphRowStartCol], a ; $5957
	ld [wGlyphFlushedCol], a ; $595a
	ldh a, [hWramBank] ; $595d
	push af ; $595f
	wram_bank $07 ; $5960
	call ClearGlyphBuffer ; $5966
	call UploadGlyphBufferFull ; $5969
	pop af ; $596c
	wram_bank ; $596d
	call SetActiveWindowTextId ; $5971
	call RestoreShadowTilemap ; $5974
	ld a, [wDialogueWindowId] ; $5977
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $597a
	call DrawTextWindowFrame ; $597d
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $5980
	call RedrawWindowRowsPadded ; $5983
	call RenderActiveWindowText ; $5986
	ld a, [wTextPageBreakRequest] ; $5989
	or a ; $598c
	jr z, .clearTextArgStringWriteIndex ; $598d
	call FitWindowToText ; $598f
	jr .loop ; $5992
.clearTextArgStringWriteIndex:
	xor a ; $5994
	ld [wTextArgStringWriteIndex], a ; $5995
	ld [$d866], a ; $5998
	ld [$d848], a ; $599b
	ld [$d867], a ; $599e
	ld [wTextArgShortTextWriteIndex], a ; $59a1
	ld [$d868], a ; $59a4
	pop af ; $59a7
	wram_bank ; $59a8
	pop de ; $59ac
	pop bc ; $59ad
	pop af ; $59ae
	ret ; $59af
ShowDialogueAtPosition:
	push af ; $59b0
	push bc ; $59b1
	push de ; $59b2
	ld b, a ; $59b3
	ldh a, [hWramBank] ; $59b4
	push af ; $59b6
	wram_bank $05 ; $59b7
	xor a ; $59bd
	ld [wTextArgStringWriteIndex], a ; $59be
	ld [w5_d866], a ; $59c1
	ld [w5_d848], a ; $59c4
	ld [w5_d867], a ; $59c7
	ld [wTextArgShortTextWriteIndex], a ; $59ca
	ld [w5_d868], a ; $59cd
	call AddTextIdOffset ; $59d0
	ld a, b ; $59d3
	bit 7, a ; $59d4
	ld b, $08 ; $59d6
	jr nz, .applyMessageSpeed ; $59d8
	call GetSpeakerVoice ; $59da
	ld b, a ; $59dd
.applyMessageSpeed:
	ld a, b ; $59de
	ld [w5_d862], a ; $59df
	call ApplyMessageSpeed ; $59e2
	ld a, [wDialogueWindowId] ; $59e5
	cp $ff ; $59e8
	jr nz, .loop ; $59ea
	call OpenDialogueWindowCentered ; $59ec
	call RefreshShadowTilemapFromMapBuffer ; $59ef
.loop:
	xor a ; $59f2
	ld [wGlyphRowStartCol], a ; $59f3
	ld [wGlyphFlushedCol], a ; $59f6
	ldh a, [hWramBank] ; $59f9
	push af ; $59fb
	wram_bank $07 ; $59fc
	call ClearGlyphBuffer ; $5a02
	call UploadGlyphBufferFull ; $5a05
	pop af ; $5a08
	wram_bank ; $5a09
	call SetActiveWindowTextId ; $5a0d
	ld a, [wDialogueWindowId] ; $5a10
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $5a13
	call DrawTextWindowFrame ; $5a16
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $5a19
	call RedrawWindowRowsPadded ; $5a1c
	call RenderActiveWindowText ; $5a1f
	ld a, [wTextPageBreakRequest] ; $5a22
	or a ; $5a25
	jr nz, .loop ; $5a26
	ld a, [wDialogueWindowId] ; $5a28
	call CloseWindow ; $5a2b
	ld a, $ff ; $5a2e
	ld [wDialogueWindowId], a ; $5a30
	xor a ; $5a33
	ld [wTextArgStringWriteIndex], a ; $5a34
	ld [$d866], a ; $5a37
	ld [$d848], a ; $5a3a
	ld [$d867], a ; $5a3d
	ld [wTextArgShortTextWriteIndex], a ; $5a40
	ld [$d868], a ; $5a43
	pop af ; $5a46
	wram_bank ; $5a47
	pop de ; $5a4b
	pop bc ; $5a4c
	pop af ; $5a4d
	ret ; $5a4e
DrawDialogueAtPosition:
	push af ; $5a4f
	push bc ; $5a50
	push de ; $5a51
	ld a, d ; $5a52
	sub $0a ; $5a53
	ld d, a ; $5a55
	ld a, e ; $5a56
	sub $09 ; $5a57
	ld e, a ; $5a59
	ld b, a ; $5a5a
	ldh a, [hWramBank] ; $5a5b
	push af ; $5a5d
	wram_bank $05 ; $5a5e
	ld a, b ; $5a64
	bit 7, a ; $5a65
	ld a, $08 ; $5a67
	jr nz, .store ; $5a69
	call GetSpeakerVoice ; $5a6b
.store:
	ld [w5_d862], a ; $5a6e
	ld a, [wDialogueWindowId] ; $5a71
	cp $ff ; $5a74
	jr nz, .loop ; $5a76
	call OpenDialogueWindowCentered ; $5a78
.loop:
	call SetActiveWindowTextId ; $5a7b
	call RestoreShadowTilemap ; $5a7e
	call StubNop_05_4626 ; $5a81
	ld a, [wTextPageBreakRequest] ; $5a84
	or a ; $5a87
	jr nz, .loop ; $5a88
	pop af ; $5a8a
	wram_bank ; $5a8b
	pop de ; $5a8f
	pop bc ; $5a90
	pop af ; $5a91
	ret ; $5a92
CloseActiveDialogueWindow:
	push af ; $5a93
	ldh a, [hWramBank] ; $5a94
	push af ; $5a96
	wram_bank $05 ; $5a97
	ld a, [wDialogueWindowId] ; $5a9d
	call CloseWindow ; $5aa0
	ld a, $ff ; $5aa3
	ld [wDialogueWindowId], a ; $5aa5
	pop af ; $5aa8
	wram_bank ; $5aa9
	pop af ; $5aad
	ret ; $5aae
OpenSpeechBubble:
	push af ; $5aaf
	push bc ; $5ab0
	push de ; $5ab1
	push hl ; $5ab2
	push hl ; $5ab3
	ld b, a ; $5ab4
	ldh a, [hWramBank] ; $5ab5
	push af ; $5ab7
	ld a, b ; $5ab8
	and $3f ; $5ab9
	ld e, a ; $5abb
	rl b ; $5abc
	jr nc, .getObjectSlotPointer ; $5abe
	jr .step2 ; $5ac0
.getObjectSlotPointer:
	call GetObjectSlotPointer ; $5ac2
	ld a, [wCameraY + 1] ; $5ac5
	ld b, a ; $5ac8
	ld a, l ; $5ac9
	ldh [hActorPtr], a ; $5aca
	ld a, h ; $5acc
	ldh [hActorPtr + 1], a ; $5acd
	wram_bank $04 ; $5acf
	ld hl, hActorPtr ; $5ad5
	ld a, [hl+] ; $5ad8
	ld h, [hl] ; $5ad9
	add $0e ; $5ada
	ld l, a ; $5adc
	inc hl ; $5add
	ld a, [hl] ; $5ade
	sub b ; $5adf
	cp $0a ; $5ae0
	jr c, .lt0a ; $5ae2
	ld e, $00 ; $5ae4
	ld b, $00 ; $5ae6
	jr .step2 ; $5ae8
.lt0a:
	ld e, $0a ; $5aea
	ld b, $01 ; $5aec
.step2:
	wram_bank $05 ; $5aee
	ld a, b ; $5af4
	ld [w5_d85c], a ; $5af5
	pop af ; $5af8
	wram_bank ; $5af9
	ld b, $14 ; $5afd
	ld c, $07 ; $5aff
	ld d, $00 ; $5b01
	call CreateDialogueWindow ; $5b03
	pop hl ; $5b06
	call FetchDialogueText ; $5b07
	call FitWindowToText ; $5b0a
	xor a ; $5b0d
	ld [$d866], a ; $5b0e
	ld [$d868], a ; $5b11
	ld a, [wDialogueWindowId] ; $5b14
	call GetWindowStructPtr ; $5b17
	wram_bank $05 ; $5b1a
	ld a, [wDialogueWindowCol] ; $5b20
	add $08 ; $5b23
	and $1f ; $5b25
	ld d, a ; $5b27
	ld a, [wDialogueWindowRow] ; $5b28
	add $02 ; $5b2b
	and $1f ; $5b2d
	ld e, a ; $5b2f
	ld b, $03 ; $5b30
	ld c, $03 ; $5b32
	ld a, $08 ; $5b34
	inc hl ; $5b36
	inc hl ; $5b37
	ld a, [hl] ; $5b38
	rr a ; $5b39
	jr c, .carry ; $5b3b
	inc b ; $5b3d
.carry:
	dec hl ; $5b3e
	dec hl ; $5b3f
	call RestoreShadowTilemap ; $5b40
	push af ; $5b43
	ld a, [wWindowId] ; $5b44
	call SaveWindowStruct ; $5b47
	pop af ; $5b4a
.loop:
	push af ; $5b4b
	ld a, [wWindowId] ; $5b4c
	call GetWindowStructPtr ; $5b4f
	call SetWindowRect ; $5b52
	ld a, [wWindowId] ; $5b55
	call DrawTextWindowFrame ; $5b58
	ld hl, $dc78 ; $5b5b
	ld a, [wWindowId] ; $5b5e
	call RedrawWindowRowsPadded ; $5b61
	ld a, d ; $5b64
	cp [hl] ; $5b65
	jr z, .step4 ; $5b66
	dec a ; $5b68
	and $1f ; $5b69
	ld d, a ; $5b6b
.step4:
	jr .next ; $5b6c
	dec d ; $5b6e
	bit 7, d ; $5b6f
	jr z, .next ; $5b71
	ld d, $00 ; $5b73
.next:
	inc hl ; $5b75
	dec e ; $5b76
	ld a, e ; $5b77
	sub [hl] ; $5b78
	bit 7, a ; $5b79
	jr z, .positive ; $5b7b
	ld a, [hl] ; $5b7d
	ld e, a ; $5b7e
.positive:
	inc hl ; $5b7f
	inc b ; $5b80
	inc b ; $5b81
	ld a, [hl] ; $5b82
	cp b ; $5b83
	jr nc, .countLeft ; $5b84
	ld b, a ; $5b86
.countLeft:
	inc hl ; $5b87
	inc c ; $5b88
	ld a, [hl] ; $5b89
	cp c ; $5b8a
	jr nc, .countLeft2 ; $5b8b
	ld c, a ; $5b8d
.countLeft2:
	dec hl ; $5b8e
	dec hl ; $5b8f
	dec hl ; $5b90
	pop af ; $5b91
	dec a ; $5b92
	jr nz, .loop ; $5b93
	ld a, [wDialogueWindowId] ; $5b95
	call RestoreWindowStruct ; $5b98
	pop hl ; $5b9b
	pop de ; $5b9c
	pop bc ; $5b9d
	pop af ; $5b9e
	ret ; $5b9f
OpenDialogueWindowCentered:
	push af ; $5ba0
	push bc ; $5ba1
	push de ; $5ba2
	push hl ; $5ba3
	push de ; $5ba4
	push hl ; $5ba5
	ld de, $0000 ; $5ba6
	ld b, $14 ; $5ba9
	ld c, $07 ; $5bab
	call CreateDialogueWindow ; $5bad
	pop hl ; $5bb0
	call FetchDialogueText ; $5bb1
	call FitWindowToText ; $5bb4
	pop de ; $5bb7
	ld a, [wDialogueWindowId] ; $5bb8
	call GetWindowStructPtr ; $5bbb
	inc hl ; $5bbe
	inc hl ; $5bbf
	ld a, d ; $5bc0
	ld d, [hl] ; $5bc1
	sra d ; $5bc2
	sub d ; $5bc4
	and $1f ; $5bc5
	ld d, a ; $5bc7
	inc hl ; $5bc8
	ld a, e ; $5bc9
	ld e, [hl] ; $5bca
	sra e ; $5bcb
	sub e ; $5bcd
	and $1f ; $5bce
	ld e, a ; $5bd0
	dec hl ; $5bd1
	dec hl ; $5bd2
	ld [hl-], a ; $5bd3
	ld [hl], d ; $5bd4
	ldh a, [hScrollY] ; $5bd5
	ld b, a ; $5bd7
	srl b ; $5bd8
	srl b ; $5bda
	srl b ; $5bdc
	srl b ; $5bde
	srl b ; $5be0
	srl b ; $5be2
	ld a, e ; $5be4
	sub b ; $5be5
	dec hl ; $5be6
	push hl ; $5be7
	ld a, [hl+] ; $5be8
	ld d, [hl] ; $5be9
	inc hl ; $5bea
	ld e, [hl] ; $5beb
	inc hl ; $5bec
	ld b, [hl] ; $5bed
	inc hl ; $5bee
	ld c, [hl] ; $5bef
	pop hl ; $5bf0
	ld a, [wWindowId] ; $5bf1
	call DrawTextWindowFrame ; $5bf4
	pop hl ; $5bf7
	pop de ; $5bf8
	pop bc ; $5bf9
	pop af ; $5bfa
	ret ; $5bfb
MeasureDialogueWidthTiles:
	push bc ; $5bfc
	ldh a, [hWramBank] ; $5bfd
	push af ; $5bff
	wram_bank $05 ; $5c00
	call FetchDialogueText ; $5c06
	call FitWindowToText ; $5c09
	ld a, [w5_d854] ; $5c0c
	ld b, a ; $5c0f
	pop af ; $5c10
	wram_bank ; $5c11
	ld a, b ; $5c15
	pop bc ; $5c16
	ret ; $5c17
FetchDialogueText:
	push af ; $5c18
	push bc ; $5c19
	push de ; $5c1a
	push hl ; $5c1b
	bit 7, h ; $5c1c
	jr nz, FetchDialogueTextFromSram ; $5c1e
	ld d, h ; $5c20
	ld e, l ; $5c21
	ld b, d ; $5c22
	ld a, d ; $5c23
	and $03 ; $5c24
	ld d, a ; $5c26
	ld a, b ; $5c27
	srl a ; $5c28
	srl a ; $5c2a
	and $0f ; $5c2c
	ld hl, DialogueTextFetchers_05 ; $5c2e
	add a ; $5c31
	add l ; $5c32
	ld l, a ; $5c33
	jr nc, .readFetcher ; $5c34
	inc h ; $5c36
.readFetcher:
	ld a, [hl+] ; $5c37
	ld h, [hl] ; $5c38
	ld l, a ; $5c39
	jp hl ; $5c3a
DialogueTextFetchers_05:
	; $5c3b, 32 bytes (records:2)
	dw FetchDialogueTextBank30 ; record 0
	dw FetchDialogueTextBank31 ; record 1
	dw FetchDialogueTextBank32 ; record 2
	dw FetchDialogueTextBank33 ; record 3
	dw FetchDialogueTextBank34 ; record 4
	dw FetchDialogueTextBank35 ; record 5
	dw FetchDialogueTextBank36 ; record 6
	dw FetchDialogueTextBank37 ; record 7
	dw FetchDialogueText_6eThunk ; record 8
	dw FetchDialogueText_1fThunk ; record 9
	dw FetchDialogueText_25Thunk ; record 10
	dw FetchDialogueText_26Thunk ; record 11
	dw FetchDialogueText_5eThunk ; record 12
	dw FetchDialogueTextBank30 ; record 13
	dw FetchDialogueTextBank30 ; record 14
	dw FetchDialogueTextBank30 ; record 15
FetchDialogueTextBank30:
	farcall FetchDialogueText_30 ; $5c5b
	jr FetchDialogueTextDone ; $5c5e
FetchDialogueTextBank31:
	farcall FetchDialogueText_31 ; $5c60
	jr FetchDialogueTextDone ; $5c63
FetchDialogueTextBank32:
	farcall FetchDialogueText_32 ; $5c65
	jr FetchDialogueTextDone ; $5c68
FetchDialogueTextBank33:
	farcall FetchDialogueText_33 ; $5c6a
	jr FetchDialogueTextDone ; $5c6d
FetchDialogueTextBank34:
	farcall FetchDialogueText_34 ; $5c6f
	jr FetchDialogueTextDone ; $5c72
FetchDialogueTextBank35:
	farcall FetchDialogueText_35 ; $5c74
	jr FetchDialogueTextDone ; $5c77
FetchDialogueTextBank36:
	farcall FetchDialogueText_36 ; $5c79
	jr FetchDialogueTextDone ; $5c7c
FetchDialogueTextBank37:
	farcall FetchDialogueText_37 ; $5c7e
	jr FetchDialogueTextDone ; $5c81
FetchDialogueText_6eThunk:
	farcall FetchDialogueText_6e ; $5c83
	jr FetchDialogueTextDone ; $5c86
FetchDialogueText_1fThunk:
	farcall FetchDialogueText_1f ; $5c88
	jr FetchDialogueTextDone ; $5c8b
FetchDialogueText_25Thunk:
	farcall FetchDialogueText_25 ; $5c8d
	jr FetchDialogueTextDone ; $5c90
FetchDialogueText_26Thunk:
	farcall FetchDialogueText_26 ; $5c92
	jr FetchDialogueTextDone ; $5c95
FetchDialogueText_5eThunk:
	farcall FetchDialogueText_5e ; $5c97
	jr FetchDialogueTextDone ; $5c9a
FetchDialogueTextFromSram:
	ld a, h ; $5c9c
	and $03 ; $5c9d
	ld h, a ; $5c9f
	call FetchSRAMDialogueText ; $5ca0
FetchDialogueTextDone:
	pop hl ; $5ca3
	pop de ; $5ca4
	pop bc ; $5ca5
	pop af ; $5ca6
	ret ; $5ca7
FetchShortText:
	push af ; $5ca8
	push bc ; $5ca9
	push de ; $5caa
	push hl ; $5cab
	ld d, h ; $5cac
	ld e, l ; $5cad
	ld b, d ; $5cae
	ld a, d ; $5caf
	and $03 ; $5cb0
	ld d, a ; $5cb2
	ld a, b ; $5cb3
	srl a ; $5cb4
	srl a ; $5cb6
	and $0f ; $5cb8
	ld hl, ShortTextFetchers_05 ; $5cba
	add a ; $5cbd
	add l ; $5cbe
	ld l, a ; $5cbf
	jr nc, .read ; $5cc0
	inc h ; $5cc2
.read:
	ld a, [hl+] ; $5cc3
	ld h, [hl] ; $5cc4
	ld l, a ; $5cc5
	jp hl ; $5cc6
ShortTextFetchers_05:
	; $5cc7, 32 bytes (records:2)
	dw FetchShortTextBank30 ; record 0
	dw FetchShortTextBank31 ; record 1
	dw FetchShortTextBank32 ; record 2
	dw FetchShortTextBank33 ; record 3
	dw FetchShortTextBank34 ; record 4
	dw FetchShortTextBank35 ; record 5
	dw FetchShortTextBank36 ; record 6
	dw FetchShortTextBank37 ; record 7
	dw FetchShortText_6eThunk ; record 8
	dw FetchShortText_1fThunk ; record 9
	dw FetchShortText_25Thunk ; record 10
	dw FetchShortText_26Thunk ; record 11
	dw FetchShortText_5eThunk ; record 12
	dw FetchShortTextBank30 ; record 13
	dw FetchShortTextBank30 ; record 14
	dw FetchShortTextBank30 ; record 15
FetchShortTextBank30:
	farcall FetchShortText_30 ; $5ce7
	jr FetchShortText_5eThunk.restore ; $5cea
FetchShortTextBank31:
	farcall FetchShortText_31 ; $5cec
	jr FetchShortText_5eThunk.restore ; $5cef
FetchShortTextBank32:
	farcall FetchShortText_32 ; $5cf1
	jr FetchShortText_5eThunk.restore ; $5cf4
FetchShortTextBank33:
	farcall FetchShortText_33 ; $5cf6
	jr FetchShortText_5eThunk.restore ; $5cf9
FetchShortTextBank34:
	farcall FetchShortText_34 ; $5cfb
	jr FetchShortText_5eThunk.restore ; $5cfe
FetchShortTextBank35:
	farcall FetchShortText_35 ; $5d00
	jr FetchShortText_5eThunk.restore ; $5d03
FetchShortTextBank36:
	farcall FetchShortText_36 ; $5d05
	jr FetchShortText_5eThunk.restore ; $5d08
FetchShortTextBank37:
	farcall FetchShortText_37 ; $5d0a
	jr FetchShortText_5eThunk.restore ; $5d0d
FetchShortText_6eThunk:
	farcall FetchShortText_6e ; $5d0f
	jr FetchShortText_5eThunk.restore ; $5d12
FetchShortText_1fThunk:
	farcall FetchShortText_1f ; $5d14
	jr FetchShortText_5eThunk.restore ; $5d17
FetchShortText_25Thunk:
	farcall FetchShortText_25 ; $5d19
	jr FetchShortText_5eThunk.restore ; $5d1c
FetchShortText_26Thunk:
	farcall FetchShortText_26 ; $5d1e
	jr FetchShortText_5eThunk.restore ; $5d21
FetchShortText_5eThunk:
	farcall FetchShortText_5e ; $5d23
.restore:
	pop hl ; $5d26
	pop de ; $5d27
	pop bc ; $5d28
	pop af ; $5d29
	ret ; $5d2a
AddTextIdOffset:
	bit 7, h ; $5d2b
	ret nz ; $5d2d
	push af ; $5d2e
	push bc ; $5d2f
	push de ; $5d30
	add sp, -2 ; $5d31
	push hl ; $5d33
	ld b, $00 ; $5d34
	ld c, a ; $5d36
	ld a, h ; $5d37
	ld e, h ; $5d38
	and $03 ; $5d39
	ld h, a ; $5d3b
	add hl, bc ; $5d3c
	ld b, h ; $5d3d
	ld c, l ; $5d3e
	ld a, e ; $5d3f
	and $3c ; $5d40
	ld e, a ; $5d42
	ld a, h ; $5d43
	or e ; $5d44
	ld d, a ; $5d45
	ld e, l ; $5d46
	ld hl, sp + 2 ; $5d47
	ld [hl], e ; $5d49
	inc hl ; $5d4a
	ld [hl], d ; $5d4b
	pop hl ; $5d4c
	ld a, h ; $5d4d
	and $3c ; $5d4e
	sra a ; $5d50
	ld e, a ; $5d52
	ld d, $00 ; $5d53
	ld hl, WordLookupTable_05_5d99 ; $5d55
	add hl, de ; $5d58
	ld e, [hl] ; $5d59
	inc hl ; $5d5a
	ld d, [hl] ; $5d5b
	ld a, b ; $5d5c
	xor $ff ; $5d5d
	ld b, a ; $5d5f
	ld a, c ; $5d60
	xor $ff ; $5d61
	ld c, a ; $5d63
	inc bc ; $5d64
	ld h, d ; $5d65
	ld l, e ; $5d66
	add hl, bc ; $5d67
	push hl ; $5d68
	ld hl, sp + 2 ; $5d69
	ld c, [hl] ; $5d6b
	inc hl ; $5d6c
	ld b, [hl] ; $5d6d
	pop hl ; $5d6e
	ld a, l ; $5d6f
	or h ; $5d70
	jr z, .underflow ; $5d71
	bit 7, h ; $5d73
	jr z, .done ; $5d75
.underflow:
	ld a, b ; $5d77
	and $3c ; $5d78
	add $04 ; $5d7a
	ld d, a ; $5d7c
	ld a, b ; $5d7d
	and $c0 ; $5d7e
	or d ; $5d80
	ld b, a ; $5d81
	ld a, h ; $5d82
	xor $ff ; $5d83
	ld h, a ; $5d85
	ld a, l ; $5d86
	xor $ff ; $5d87
	ld l, a ; $5d89
	inc hl ; $5d8a
	ld a, h ; $5d8b
	and $03 ; $5d8c
	or b ; $5d8e
	ld b, a ; $5d8f
	ld c, l ; $5d90
.done:
	ld h, b ; $5d91
	ld l, c ; $5d92
	add sp, 2 ; $5d93
	pop de ; $5d95
	pop bc ; $5d96
	pop af ; $5d97
	ret ; $5d98
WordLookupTable_05_5d99:
	; $5d99, 26 bytes (records:2)
	dw $0230 ; record 0
	dw $015b ; record 1
	dw $00bb ; record 2
	dw $00dd ; record 3
	dw $011f ; record 4
	dw $010e ; record 5
	dw $02c7 ; record 6
	dw $0100 ; record 7
	dw $00f2 ; record 8
	dw $00bd ; record 9
	dw $010b ; record 10
	dw $00f9 ; record 11
	dw $0143 ; record 12
RenderProportionalTextAt:
	push af ; $5db3
	push bc ; $5db4
	push de ; $5db5
	push hl ; $5db6
	set_flag FLAG_PROPORTIONAL_TEXT_MODE ; $5db7
	push bc ; $5dba
	push de ; $5dbb
	push hl ; $5dbc
	ld hl, wGlyphTileWritePtr ; $5dbd
	ld a, e ; $5dc0
	ld [hl+], a ; $5dc1
	ld [hl], d ; $5dc2
	pop hl ; $5dc3
	call InitGlyphStreamAt ; $5dc4
	ldh a, [hWramBank] ; $5dc7
	push af ; $5dc9
	wram_bank $05 ; $5dca
	xor a ; $5dd0
	call AddTextIdOffset ; $5dd1
	xor a ; $5dd4
	ld [wTextArgStringWriteIndex], a ; $5dd5
	ld [w5_d866], a ; $5dd8
	ld [w5_d848], a ; $5ddb
	ld [w5_d867], a ; $5dde
	ld [wTextArgShortTextWriteIndex], a ; $5de1
	ld [w5_d868], a ; $5de4
	ld a, [wShadowTilemapPtr + 1] ; $5de7
	add $03 ; $5dea
	cp d ; $5dec
	jr nc, .destOk ; $5ded
	ld a, d ; $5def
	sub $04 ; $5df0
	ld d, a ; $5df2
.destOk:
	ld a, e ; $5df3
	ld [wGlyphVramDest], a ; $5df4
	ld a, d ; $5df7
	ld [wGlyphVramDest + 1], a ; $5df8
	ld c, $20 ; $5dfb
	ld b, $ff ; $5dfd
	ld a, c ; $5dff
	cpl ; $5e00
	inc a ; $5e01
	ld c, a ; $5e02
	ld [wTextRowIndent], a ; $5e03
	call FetchDialogueText ; $5e06
	ld hl, wTextBuffer ; $5e09
	xor a ; $5e0c
	ld [$cb78], a ; $5e0d
	ld a, [wWindowId] ; $5e10
	ld b, a ; $5e13
	ld a, [wMenuWindowId] ; $5e14
	cp b ; $5e17
	jr z, .markerChecked ; $5e18
	ld a, $01 ; $5e1a
	ld [$cb78], a ; $5e1c
.markerChecked:
	pop af ; $5e1f
	wram_bank ; $5e20
.charLoop:
	ld a, [hl] ; $5e24
	cp $20 ; $5e25
	jr nc, Label_05_5e82.glyph ; $5e27
	push hl ; $5e29
	push af ; $5e2a
	add a ; $5e2b
	ld hl, ProportionalTextCodeHandlers_05 ; $5e2c
	add l ; $5e2f
	ld l, a ; $5e30
	jr nc, .readVector ; $5e31
	inc h ; $5e33
.readVector:
	ld a, [hl+] ; $5e34
	ld h, [hl] ; $5e35
	ld l, a ; $5e36
	pop af ; $5e37
	jp hl ; $5e38
ProportionalTextCodeHandlers_05:
	; $5e39, 32 bytes (records:2)
	dw Label_05_5ecd ; record 0
	dw Label_05_5e72 ; record 1
	dw Label_05_5ecd ; record 2
	dw Label_05_5ecd ; record 3
	dw Label_05_5e7b ; record 4
	dw Label_05_5e82 ; record 5
	dw Label_05_5e82 ; record 6
	dw Label_05_5e7b ; record 7
	dw Label_05_5e7b ; record 8
	dw Label_05_5e7b ; record 9
	dw Label_05_5e82 ; record 10
	dw Label_05_5e7b ; record 11
	dw Label_05_5e82 ; record 12
	dw Label_05_5e82 ; record 13
	dw Label_05_5e59 ; record 14
	dw Label_05_5e82 ; record 15
Label_05_5e59:
	pop hl ; $5e59
	inc hl ; $5e5a
	push af ; $5e5b
	wram_bank $05 ; $5e5c
	ld a, [hl] ; $5e62
	ld [wTextCharNameArg], a ; $5e63
	pop af ; $5e66
	wram_bank ; $5e67
	pop af ; $5e6b
	call DispatchControlCode ; $5e6c
	inc hl ; $5e6f
	jr RenderProportionalTextAt.charLoop ; $5e70
Label_05_5e72:
	pop hl ; $5e72
	ld a, $0d ; $5e73
	call DispatchControlCode ; $5e75
	inc hl ; $5e78
	jr RenderProportionalTextAt.charLoop ; $5e79
Label_05_5e7b:
	pop hl ; $5e7b
	call DispatchControlCode ; $5e7c
	inc hl ; $5e7f
	jr RenderProportionalTextAt.charLoop ; $5e80
Label_05_5e82:
	pop hl ; $5e82
.glyph:
	push af ; $5e83
	ld a, [wShadowTilemapBank] ; $5e84
	wram_bank ; $5e87
	pop af ; $5e8b
	call StampGlyphTileAtPen ; $5e8c
	call DrawInlineGlyph ; $5e8f
	call StampGlyphTileAtPen ; $5e92
	inc hl ; $5e95
	ld a, [hl] ; $5e96
	cp $de ; $5e97
	jr z, .markFollows ; $5e99
	cp $df ; $5e9b
	jr nz, .nextCell ; $5e9d
.markFollows:
	push hl ; $5e9f
	ld h, d ; $5ea0
	ld l, e ; $5ea1
	add hl, bc ; $5ea2
	ld b, a ; $5ea3
	ld a, [wShadowTilemapPtr + 1] ; $5ea4
	dec a ; $5ea7
	cp h ; $5ea8
	jr c, .readCell ; $5ea9
	ld a, h ; $5eab
	add $04 ; $5eac
	ld h, a ; $5eae
.readCell:
	ld a, [hl] ; $5eaf
	cp $03 ; $5eb0
	ld a, b ; $5eb2
	ld b, $ff ; $5eb3
	jr nz, .writeCell ; $5eb5
	sub $d0 ; $5eb7
.writeCell:
	ld [hl], a ; $5eb9
	pop hl ; $5eba
	inc hl ; $5ebb
.nextCell:
	inc de ; $5ebc
	ld a, e ; $5ebd
	and $1f ; $5ebe
	jp nz, RenderProportionalTextAt.charLoop ; $5ec0
	push hl ; $5ec3
	ld h, d ; $5ec4
	ld l, e ; $5ec5
	add hl, bc ; $5ec6
	ld d, h ; $5ec7
	ld e, l ; $5ec8
	pop hl ; $5ec9
	jp RenderProportionalTextAt.charLoop ; $5eca
Label_05_5ecd:
	pop hl ; $5ecd
	ldh a, [hWramBank] ; $5ece
	push af ; $5ed0
	wram_bank $05 ; $5ed1
	xor a ; $5ed7
	ld [wTextRowIndent], a ; $5ed8
	ld [wTextArgStringWriteIndex], a ; $5edb
	ld [w5_d866], a ; $5ede
	ld [w5_d848], a ; $5ee1
	ld [w5_d867], a ; $5ee4
	ld [wTextArgShortTextWriteIndex], a ; $5ee7
	ld [w5_d868], a ; $5eea
	pop af ; $5eed
	wram_bank ; $5eee
	ld hl, wGlyphPenX ; $5ef2
	ld a, [hl+] ; $5ef5
	ld h, [hl] ; $5ef6
	ld l, a ; $5ef7
	sla l ; $5ef8
	rl h ; $5efa
	ld a, h ; $5efc
	ld [wGlyphRowStartCol], a ; $5efd
	pop de ; $5f00
	pop bc ; $5f01
	call SaveGlyphPenColumns ; $5f02
	clear_flag FLAG_PROPORTIONAL_TEXT_MODE ; $5f05
	pop hl ; $5f08
	pop de ; $5f09
	pop bc ; $5f0a
	pop af ; $5f0b
	ret ; $5f0c
StampGlyphTileAtPen:
	push af ; $5f0d
	push bc ; $5f0e
	push de ; $5f0f
	push hl ; $5f10
	ld a, [$cb78] ; $5f11
	or a ; $5f14
	jr z, .restore ; $5f15
	ld hl, wGlyphTileWritePtr ; $5f17
	ld a, [hl+] ; $5f1a
	ld d, [hl] ; $5f1b
	ld e, a ; $5f1c
	ld a, [wGlyphFlushedCol] ; $5f1d
	ld b, a ; $5f20
	ld hl, wGlyphPenX ; $5f21
	ld a, [hl+] ; $5f24
	ld h, [hl] ; $5f25
	ld l, a ; $5f26
	sla l ; $5f27
	rl h ; $5f29
	ld a, h ; $5f2b
	ld c, a ; $5f2c
	sub b ; $5f2d
	ld h, e ; $5f2e
	add e ; $5f2f
	ld e, a ; $5f30
	jr nc, .cellPtrOk ; $5f31
	inc d ; $5f33
.cellPtrOk:
	ld a, e ; $5f34
	and $20 ; $5f35
	ld l, a ; $5f37
	ld a, h ; $5f38
	and $20 ; $5f39
	xor l ; $5f3b
	jr z, .checkCell ; $5f3c
	ld hl, $ffe0 ; $5f3e
	add hl, de ; $5f41
	ld d, h ; $5f42
	ld e, l ; $5f43
.checkCell:
	ld a, [de] ; $5f44
	cp $06 ; $5f45
	jr z, .restore ; $5f47
	ld a, c ; $5f49
	add $80 ; $5f4a
	ld [de], a ; $5f4c
.restore:
	pop hl ; $5f4d
	pop de ; $5f4e
	pop bc ; $5f4f
	pop af ; $5f50
	ret ; $5f51
RenderTextToBuffer64:
	push af ; $5f52
	push bc ; $5f53
	push de ; $5f54
	push hl ; $5f55
	ldh a, [hWramBank] ; $5f56
	push af ; $5f58
	wram_bank $05 ; $5f59
	xor a ; $5f5f
	call AddTextIdOffset ; $5f60
	ld a, e ; $5f63
	ld [wGlyphVramDest], a ; $5f64
	ld a, d ; $5f67
	ld [wGlyphVramDest + 1], a ; $5f68
	ld b, $ff ; $5f6b
	ld a, c ; $5f6d
	cpl ; $5f6e
	inc a ; $5f6f
	ld c, a ; $5f70
	ld [wTextRowIndent], a ; $5f71
	call FetchDialogueText ; $5f74
	ld hl, wTextBuffer ; $5f77
	pop af ; $5f7a
	wram_bank ; $5f7b
.charLoop:
	ld a, [hl] ; $5f7f
	cp $20 ; $5f80
	jr nc, TextCodeLiteral_05.store ; $5f82
	push hl ; $5f84
	push af ; $5f85
	add a ; $5f86
	ld hl, TextControlCodeHandlers_05 ; $5f87
	add l ; $5f8a
	ld l, a ; $5f8b
	jr nc, .readVector ; $5f8c
	inc h ; $5f8e
.readVector:
	ld a, [hl+] ; $5f8f
	ld h, [hl] ; $5f90
	ld l, a ; $5f91
	pop af ; $5f92
	jp hl ; $5f93
TextControlCodeHandlers_05:
	; $5f94, 32 bytes (records:2)
	dw TextCodeEnd_05 ; record 0
	dw TextCodeLineBreak_05 ; record 1
	dw TextCodeLiteral_05 ; record 2
	dw TextCodeEnd_05 ; record 3
	dw TextCodeLiteral_05 ; record 4
	dw TextCodeLiteral_05 ; record 5
	dw TextCodeLiteral_05 ; record 6
	dw TextCodeLiteral_05 ; record 7
	dw TextCodeLiteral_05 ; record 8
	dw TextCodeLiteral_05 ; record 9
	dw TextCodeLiteral_05 ; record 10
	dw TextCodeLiteral_05 ; record 11
	dw TextCodeLiteral_05 ; record 12
	dw TextCodeLiteral_05 ; record 13
	dw TextCodeLiteral_05 ; record 14
	dw TextCodeLiteral_05 ; record 15
TextCodeLineBreak_05:
	pop hl ; $5fb4
	ld a, $0d ; $5fb5
	call DispatchControlCode ; $5fb7
	inc hl ; $5fba
	jr RenderTextToBuffer64.charLoop ; $5fbb
TextCodeLiteral_05:
	pop hl ; $5fbd
.store:
	ld [de], a ; $5fbe
	inc hl ; $5fbf
	ld a, [hl] ; $5fc0
	cp $de ; $5fc1
	jr z, .eqde ; $5fc3
	cp $df ; $5fc5
	jr nz, .nedf ; $5fc7
.eqde:
	push hl ; $5fc9
	ld h, d ; $5fca
	ld l, e ; $5fcb
	add hl, bc ; $5fcc
	ld b, a ; $5fcd
	ld a, [hl] ; $5fce
	cp $03 ; $5fcf
	ld a, b ; $5fd1
	ld b, $ff ; $5fd2
	jr nz, .store2 ; $5fd4
	sub $d0 ; $5fd6
.store2:
	ld [hl], a ; $5fd8
	pop hl ; $5fd9
	inc hl ; $5fda
.nedf:
	inc de ; $5fdb
	ld a, e ; $5fdc
	and $3f ; $5fdd
	jp nz, RenderTextToBuffer64.charLoop ; $5fdf
	push hl ; $5fe2
	ld h, d ; $5fe3
	ld l, e ; $5fe4
	add hl, bc ; $5fe5
	ld d, h ; $5fe6
	ld e, l ; $5fe7
	pop hl ; $5fe8
	jp RenderTextToBuffer64.charLoop ; $5fe9
TextCodeEnd_05:
	pop hl ; $5fec
	pop hl ; $5fed
	pop de ; $5fee
	pop bc ; $5fef
	pop af ; $5ff0
	ret ; $5ff1
GetObjectSlotPointer:
	ld hl, $0000 ; $5ff2
	cp $ff ; $5ff5
	ret z ; $5ff7
	ld hl, $d000 ; $5ff8
	cp $18 ; $5ffb
	jr nc, .done ; $5ffd
	push bc ; $5fff
	ld c, $00 ; $6000
	ld b, a ; $6002
	sra b ; $6003
	rr c ; $6005
	sra b ; $6007
	rr c ; $6009
	add hl, bc ; $600b
	pop bc ; $600c
.done:
	ret ; $600d
WriteStringToWindow:
	push af ; $600e
	push bc ; $600f
	push de ; $6010
	push hl ; $6011
.charLoop:
	ld b, a ; $6012
	ld a, [hl] ; $6013
	or a ; $6014
	jr z, .done ; $6015
	cp $de ; $6017
	jr z, .markChar ; $6019
	cp $df ; $601b
	jr z, .markChar ; $601d
	jr .writeChar ; $601f
.markChar:
	push bc ; $6021
	ld a, b ; $6022
	dec d ; $6023
	dec e ; $6024
	call ReadWindowCellTileAttr ; $6025
	inc d ; $6028
	inc e ; $6029
	ld b, a ; $602a
	ld a, c ; $602b
	cp $03 ; $602c
	ld a, [hl] ; $602e
	jr nz, .writeMark ; $602f
	sub $d0 ; $6031
.writeMark:
	pop bc ; $6033
	push bc ; $6034
	ld c, a ; $6035
	ld a, b ; $6036
	ld b, $80 ; $6037
	dec d ; $6039
	dec e ; $603a
	call WriteWindowCellTileAttr ; $603b
	inc d ; $603e
	inc e ; $603f
	inc hl ; $6040
	pop bc ; $6041
	ld a, b ; $6042
	jr .charLoop ; $6043
.writeChar:
	inc hl ; $6045
	ld c, a ; $6046
	ld a, b ; $6047
	ld b, $80 ; $6048
	call WriteWindowCellTileAttr ; $604a
	inc d ; $604d
	jr .charLoop ; $604e
.done:
	pop hl ; $6050
	pop de ; $6051
	pop bc ; $6052
	pop af ; $6053
	ret ; $6054
WriteDialogueToWindow:
	push af ; $6055
	push bc ; $6056
	push de ; $6057
	push hl ; $6058
	call FetchDialogueText ; $6059
	ld hl, wTextBuffer ; $605c
	call WriteStringToWindow ; $605f
	pop hl ; $6062
	pop de ; $6063
	pop bc ; $6064
	pop af ; $6065
	ret ; $6066
	push af ; $6067
	push bc ; $6068
	push de ; $6069
	push hl ; $606a
	call PushTextArgNumber ; $606b
	ld b, a ; $606e
	ld a, $01 ; $606f
	ld [wTextNumberRightAlign], a ; $6071
	ld a, b ; $6074
	ld hl, Text_30_310 ; $6075
	call FetchDialogueText ; $6078
	ld hl, wTextBuffer ; $607b
	call WriteStringToWindow ; $607e
	xor a ; $6081
	ld [wTextNumberRightAlign], a ; $6082
	pop hl ; $6085
	pop de ; $6086
	pop bc ; $6087
	pop af ; $6088
	ret ; $6089
GetSpeakerVoice:
	push bc ; $608a
	push de ; $608b
	push hl ; $608c
	call GetObjectSlotPointer ; $608d
	ld a, h ; $6090
	ld b, $08 ; $6091
	or l ; $6093
	jr z, .done ; $6094
	ldh a, [hWramBank] ; $6096
	push af ; $6098
	wram_bank $04 ; $6099
	ld a, l ; $609f
	ldh [hActorPtr], a ; $60a0
	ld a, h ; $60a2
	ldh [hActorPtr + 1], a ; $60a3
	ld hl, hActorPtr ; $60a5
	ld a, [hl+] ; $60a8
	ld h, [hl] ; $60a9
	add $21 ; $60aa
	ld l, a ; $60ac
	ld a, [hl] ; $60ad
	ld c, a ; $60ae
	sub $1e ; $60af
	bit 7, a ; $60b1
	ld b, $08 ; $60b3
	jr nz, .done ; $60b5
	ld l, a ; $60b7
	ld h, $00 ; $60b8
	add hl, hl ; $60ba
	ld de, ActorTypePropertyTable_05_60cb ; $60bb
	add hl, de ; $60be
	inc hl ; $60bf
	ld b, [hl] ; $60c0
	pop af ; $60c1
	wram_bank ; $60c2
.done:
	ld a, b ; $60c6
	pop hl ; $60c7
	pop de ; $60c8
	pop bc ; $60c9
	ret ; $60ca
ActorTypePropertyTable_05_60cb:
	; $60cb, 175 bytes (bytes:2)
	db $1e, $04 ; 0x00
	db $1f, $03 ; 0x02
	db $20, $04 ; 0x04
	db $21, $06 ; 0x06
	db $22, $05 ; 0x08
	db $23, $07 ; 0x0a
	db $24, $07 ; 0x0c
	db $25, $04 ; 0x0e
	db $26, $08 ; 0x10
	db $27, $08 ; 0x12
	db $28, $04 ; 0x14
	db $29, $03 ; 0x16
	db $2a, $05 ; 0x18
	db $2b, $07 ; 0x1a
	db $2c, $08 ; 0x1c
	db $2d, $06 ; 0x1e
	db $2e, $01 ; 0x20
	db $2f, $03 ; 0x22
	db $30, $04 ; 0x24
	db $31, $04 ; 0x26
	db $32, $04 ; 0x28
	db $33, $02 ; 0x2a
	db $34, $04 ; 0x2c
	db $35, $08 ; 0x2e
	db $36, $08 ; 0x30
	db $37, $04 ; 0x32
	db $38, $03 ; 0x34
	db $39, $02 ; 0x36
	db $3a, $01 ; 0x38
	db $3b, $03 ; 0x3a
	db $3c, $04 ; 0x3c
	db $3d, $04 ; 0x3e
	db $3e, $03 ; 0x40
	db $3f, $03 ; 0x42
	db $40, $04 ; 0x44
	db $41, $07 ; 0x46
	db $42, $04 ; 0x48
	db $43, $04 ; 0x4a
	db $44, $03 ; 0x4c
	db $45, $03 ; 0x4e
	db $46, $03 ; 0x50
	db $47, $04 ; 0x52
	db $48, $06 ; 0x54
	db $49, $03 ; 0x56
	db $4a, $02 ; 0x58
	db $4b, $04 ; 0x5a
	db $4c, $08 ; 0x5c
	db $4d, $08 ; 0x5e
	db $4e, $08 ; 0x60
	db $4f, $08 ; 0x62
	db $50, $08 ; 0x64
	db $51, $08 ; 0x66
	db $52, $08 ; 0x68
	db $53, $08 ; 0x6a
	db $54, $04 ; 0x6c
	db $55, $00 ; 0x6e
	db $56, $02 ; 0x70
	db $57, $01 ; 0x72
	db $58, $04 ; 0x74
	db $59, $03 ; 0x76
	db $5a, $03 ; 0x78
	db $5b, $02 ; 0x7a
	db $5c, $04 ; 0x7c
	db $5d, $01 ; 0x7e
	db $5e, $02 ; 0x80
	db $5f, $05 ; 0x82
	db $60, $06 ; 0x84
	db $61, $04 ; 0x86
	db $62, $06 ; 0x88
	db $63, $05 ; 0x8a
	db $64, $02 ; 0x8c
	db $65, $03 ; 0x8e
	db $66, $04 ; 0x90
	db $67, $06 ; 0x92
	db $68, $04 ; 0x94
	db $69, $01 ; 0x96
	db $6a, $03 ; 0x98
	db $6b, $05 ; 0x9a
	db $6c, $03 ; 0x9c
	db $6d, $02 ; 0x9e
	db $6e, $08 ; 0xa0
	db $6f, $08 ; 0xa2
	db $70, $00 ; 0xa4
	db $71, $02 ; 0xa6
	db $72, $03 ; 0xa8
	db $73, $08 ; 0xaa
	db $74, $08 ; 0xac
	db $ff ; 0xae
ResetTextWindowsAndRestoreMap:
	call InitTextWindows ; $617a
	call RestoreShadowTilemap ; $617d
	ret ; $6180
CreateWindowWithTextId:
	push bc ; $6181
	ldh a, [hWramBank] ; $6182
	push af ; $6184
	wram_bank $05 ; $6185
	call CreateWindow ; $618b
	bit 7, h ; $618e
	jr nz, .negative ; $6190
	ld b, a ; $6192
	call SetWindowTextId ; $6193
.negative:
	ld a, [wWindowId] ; $6196
	ld b, a ; $6199
	pop af ; $619a
	wram_bank ; $619b
	ld a, b ; $619f
	pop bc ; $61a0
	ret ; $61a1
RedrawWindowText:
	push af ; $61a2
	push bc ; $61a3
	push de ; $61a4
	push hl ; $61a5
	ld b, a ; $61a6
	ldh a, [hWramBank] ; $61a7
	push af ; $61a9
	wram_bank $05 ; $61aa
	ld a, [wDialogueWindowId] ; $61b0
	cp b ; $61b3
	jr nz, .getWindowStructPtr ; $61b4
	ld [wGlyphWindowId], a ; $61b6
.loop:
	xor a ; $61b9
	ld [wGlyphRowStartCol], a ; $61ba
	ld [wGlyphFlushedCol], a ; $61bd
	ldh a, [hWramBank] ; $61c0
	push af ; $61c2
	wram_bank $07 ; $61c3
	call ClearGlyphBuffer ; $61c9
	call UploadGlyphTilesPartial ; $61cc
	pop af ; $61cf
	wram_bank ; $61d0
	ld a, [wDialogueWindowId] ; $61d4
	push af ; $61d7
	call GetWindowStructPtr ; $61d8
	ld bc, $0006 ; $61db
	add hl, bc ; $61de
	ld a, [hl+] ; $61df
	ld h, [hl] ; $61e0
	ld l, a ; $61e1
	call MeasureDialogueWidthTiles ; $61e2
	pop af ; $61e5
	call DrawTextWindowFrame ; $61e6
	call RenderActiveWindowText ; $61e9
	ld a, [wDialogueWindowId] ; $61ec
	call RestoreTilemapUnderWindow ; $61ef
	ld a, [wTextPageBreakRequest] ; $61f2
	or a ; $61f5
	jr nz, .loop ; $61f6
	jr .restore ; $61f8
.getWindowStructPtr:
	ld a, b ; $61fa
	call GetWindowStructPtr ; $61fb
	ld b, h ; $61fe
	ld c, l ; $61ff
	ld d, [hl] ; $6200
	inc d ; $6201
	inc hl ; $6202
	ld e, [hl] ; $6203
	inc e ; $6204
	ld hl, $0004 ; $6205
	add hl, bc ; $6208
	ld a, [hl] ; $6209
	and $02 ; $620a
	jr z, .maskClear ; $620c
	inc d ; $620e
.maskClear:
	ld hl, $0006 ; $620f
	add hl, bc ; $6212
	ld a, [hl+] ; $6213
	ld h, [hl] ; $6214
	ld l, a ; $6215
	ld a, h ; $6216
	cp $ff ; $6217
	jr z, .restore ; $6219
	call FetchDialogueText ; $621b
	ld hl, wTextBuffer ; $621e
	call RenderTextString ; $6221
.restore:
	pop af ; $6224
	wram_bank ; $6225
	pop hl ; $6229
	pop de ; $622a
	pop bc ; $622b
	pop af ; $622c
	ret ; $622d
UploadGlyphTilesPartial:
	ldh a, [hWramBank] ; $622e
	push af ; $6230
	wram_bank $07 ; $6231
	ld hl, $d300 ; $6237
	ld de, $8800 ; $623a
	ld c, $1b ; $623d
	call QueueVRAMCopy ; $623f
	push af ; $6242
	ldh a, [rLCDC] ; $6243
	bit 7, a ; $6245
	jr z, .restore ; $6247
	call AdvanceFrame ; $6249
.restore:
	pop af ; $624c
	ld hl, $d4b0 ; $624d
	ld de, $89b0 ; $6250
	ld c, $1b ; $6253
	call QueueVRAMCopy ; $6255
	push af ; $6258
	ldh a, [rLCDC] ; $6259
	bit 7, a ; $625b
	jr z, .restore2 ; $625d
	call AdvanceFrame ; $625f
.restore2:
	pop af ; $6262
	pop af ; $6263
	wram_bank ; $6264
	ret ; $6268
RenderWindowTextToCompletion:
	push af ; $6269
	push bc ; $626a
	push de ; $626b
	push hl ; $626c
	ld b, a ; $626d
	ldh a, [hWramBank] ; $626e
	push af ; $6270
	wram_bank $05 ; $6271
	ld a, [wDialogueWindowId] ; $6277
	cp b ; $627a
	jr nz, .getWindowStructPtr ; $627b
	ld [wGlyphWindowId], a ; $627d
.loop:
	ld a, [wDialogueWindowId] ; $6280
	call DrawTextWindowFrame ; $6283
	call RenderActiveWindowText ; $6286
	ld a, [wTextPageBreakRequest] ; $6289
	or a ; $628c
	jr nz, .loop ; $628d
	jr .restore ; $628f
.getWindowStructPtr:
	ld a, b ; $6291
	call GetWindowStructPtr ; $6292
	ld b, h ; $6295
	ld c, l ; $6296
	ld d, [hl] ; $6297
	inc d ; $6298
	inc hl ; $6299
	ld e, [hl] ; $629a
	inc e ; $629b
	ld hl, $0004 ; $629c
	add hl, bc ; $629f
	ld a, [hl] ; $62a0
	and $02 ; $62a1
	jr z, .maskClear ; $62a3
	inc d ; $62a5
.maskClear:
	ld hl, $0006 ; $62a6
	add hl, bc ; $62a9
	ld a, [hl+] ; $62aa
	ld h, [hl] ; $62ab
	ld l, a ; $62ac
	ld a, h ; $62ad
	cp $ff ; $62ae
	jr z, .restore ; $62b0
.restore:
	pop af ; $62b2
	wram_bank ; $62b3
	pop hl ; $62b7
	pop de ; $62b8
	pop bc ; $62b9
	pop af ; $62ba
	ret ; $62bb
RedrawWindowRowsSafe:
	push af ; $62bc
	push bc ; $62bd
	push de ; $62be
	push hl ; $62bf
	ld b, a ; $62c0
	ldh a, [hWramBank] ; $62c1
	push af ; $62c3
	wram_bank $05 ; $62c4
	ld a, b ; $62ca
	call RedrawWindowRowsThunk ; $62cb
	pop af ; $62ce
	wram_bank ; $62cf
	pop hl ; $62d3
	pop de ; $62d4
	pop bc ; $62d5
	pop af ; $62d6
	ret ; $62d7
CloseWindowAlt:
	push af ; $62d8
	call RestoreTilemapUnderWindow ; $62d9
	call RedrawWindowRowsThunk ; $62dc
	call ResetWindowState ; $62df
	call FreeWindow ; $62e2
	pop af ; $62e5
	ret ; $62e6
ShowDialogueCentered:
	push af ; $62e7
	push bc ; $62e8
	push de ; $62e9
	ldh a, [hWramBank] ; $62ea
	push af ; $62ec
	wram_bank $05 ; $62ed
	xor a ; $62f3
	ld [wTextArgStringWriteIndex], a ; $62f4
	ld [w5_d866], a ; $62f7
	ld [w5_d848], a ; $62fa
	ld [w5_d867], a ; $62fd
	ld [wTextArgShortTextWriteIndex], a ; $6300
	ld [w5_d868], a ; $6303
	call AddTextIdOffset ; $6306
	call ApplyMessageSpeed ; $6309
	ld a, [wDialogueWindowId] ; $630c
	cp $ff ; $630f
	jr nz, .loop ; $6311
	call OpenCenteredDialogueWindow ; $6313
.loop:
	call SetActiveWindowTextId ; $6316
	ld a, [wDialogueWindowId] ; $6319
	call RedrawWindowText ; $631c
	call RedrawWindowRowsThunk ; $631f
	ld a, [wTextPageBreakRequest] ; $6322
	or a ; $6325
	jr nz, .loop ; $6326
	ld a, [wDialogueWindowId] ; $6328
	call CloseWindowAlt ; $632b
	ld a, $ff ; $632e
	ld [wDialogueWindowId], a ; $6330
	xor a ; $6333
	ld [wTextArgStringWriteIndex], a ; $6334
	ld [w5_d866], a ; $6337
	ld [w5_d848], a ; $633a
	ld [w5_d867], a ; $633d
	ld [wTextArgShortTextWriteIndex], a ; $6340
	ld [w5_d868], a ; $6343
	pop af ; $6346
	wram_bank ; $6347
	pop de ; $634b
	pop bc ; $634c
	pop af ; $634d
	ret ; $634e
OpenCenteredDialogueWindow:
	push af ; $634f
	push bc ; $6350
	push de ; $6351
	push hl ; $6352
	push de ; $6353
	push hl ; $6354
	ld de, $0000 ; $6355
	ld b, $14 ; $6358
	ld c, $07 ; $635a
	call CreateDialogueWindow ; $635c
	pop hl ; $635f
	call FetchDialogueText ; $6360
	pop de ; $6363
	ld a, [wDialogueWindowId] ; $6364
	call GetWindowStructPtr ; $6367
	inc hl ; $636a
	inc hl ; $636b
	ld a, d ; $636c
	ld d, [hl] ; $636d
	sra d ; $636e
	sub d ; $6370
	ld d, a ; $6371
	inc hl ; $6372
	ld a, e ; $6373
	ld e, [hl] ; $6374
	sra e ; $6375
	sub e ; $6377
	ld e, a ; $6378
	dec hl ; $6379
	dec hl ; $637a
	ld [hl-], a ; $637b
	ld [hl], d ; $637c
	ld a, [wDialogueWindowId] ; $637d
	call DrawTextWindowFrame ; $6380
	pop hl ; $6383
	pop de ; $6384
	pop bc ; $6385
	pop af ; $6386
	ret ; $6387
	push af ; $6388
	push bc ; $6389
	push hl ; $638a
	ld b, a ; $638b
	ldh a, [hWramBank] ; $638c
	push af ; $638e
	ld a, b ; $638f
	and $3f ; $6390
	ld e, a ; $6392
	rl b ; $6393
	jr c, .step2 ; $6395
	call GetObjectSlotPointer ; $6397
	ld a, [wCameraY + 1] ; $639a
	ld b, a ; $639d
	ld a, l ; $639e
	ldh [hActorPtr], a ; $639f
	ld a, h ; $63a1
	ldh [hActorPtr + 1], a ; $63a2
	wram_bank $04 ; $63a4
	ld hl, hActorPtr ; $63aa
	ld a, [hl+] ; $63ad
	ld h, [hl] ; $63ae
	add $0e ; $63af
	ld l, a ; $63b1
	inc hl ; $63b2
	ld a, [hl] ; $63b3
	sub b ; $63b4
	cp $0a ; $63b5
	jr c, .lt0a ; $63b7
	ld e, $00 ; $63b9
	ld b, $00 ; $63bb
	jr .step2 ; $63bd
.lt0a:
	ld e, $0b ; $63bf
	ld b, $01 ; $63c1
.step2:
	wram_bank $05 ; $63c3
	ld a, b ; $63c9
	ld [w5_d85c], a ; $63ca
	pop af ; $63cd
	wram_bank ; $63ce
	ld d, $00 ; $63d2
	pop hl ; $63d4
	pop bc ; $63d5
	pop af ; $63d6
	ret ; $63d7
DebugToggleSelectedFlag:
	push af ; $63d8
	push bc ; $63d9
	push de ; $63da
	push hl ; $63db
	ld a, [wDebugFlagPage] ; $63dc
	add a ; $63df
	add a ; $63e0
	add a ; $63e1
	add a ; $63e2
	add a ; $63e3
	add a ; $63e4
	ld l, a ; $63e5
	ld a, [wDebugFlagByte] ; $63e6
	add a ; $63e9
	add a ; $63ea
	add a ; $63eb
	add l ; $63ec
	ld l, a ; $63ed
	ld a, [wDebugFlagBit] ; $63ee
	add l ; $63f1
	ld e, a ; $63f2
	ld d, $00 ; $63f3
	call TestGameFlagByNumber ; $63f5
	jr z, .setGameFlagByNumber ; $63f8
	call ClearGameFlagByNumber ; $63fa
	jr .restore ; $63fd
.setGameFlagByNumber:
	call SetGameFlagByNumber ; $63ff
.restore:
	pop hl ; $6402
	pop de ; $6403
	pop bc ; $6404
	pop af ; $6405
	ret ; $6406
DebugDrawFlagsWindow1:
	push af ; $6407
	push bc ; $6408
	push de ; $6409
	push hl ; $640a
	ld hl, wDebugFlagWindow1Id ; $640b
	ld b, [hl] ; $640e
	ld a, [wDebugFlagPage] ; $640f
	add a ; $6412
	add a ; $6413
	add a ; $6414
	add a ; $6415
	add a ; $6416
	add a ; $6417
	ld de, $0101 ; $6418
	call DebugDrawHexRowLabel ; $641b
	ld de, $0401 ; $641e
	call DebugDrawFlagBitRow ; $6421
	add $08 ; $6424
	ld de, $0402 ; $6426
	call DebugDrawFlagBitRow ; $6429
	add $08 ; $642c
	ld de, $0104 ; $642e
	call DebugDrawHexRowLabel ; $6431
	ld de, $0404 ; $6434
	call DebugDrawFlagBitRow ; $6437
	add $08 ; $643a
	ld de, $0405 ; $643c
	call DebugDrawFlagBitRow ; $643f
	pop hl ; $6442
	pop de ; $6443
	pop bc ; $6444
	pop af ; $6445
	ret ; $6446
DebugDrawFlagsWindow2:
	push af ; $6447
	push bc ; $6448
	push de ; $6449
	push hl ; $644a
	ld hl, wDebugFlagWindow2Id ; $644b
	ld b, [hl] ; $644e
	ld a, [wDebugFlagPage] ; $644f
	add a ; $6452
	inc a ; $6453
	add a ; $6454
	add a ; $6455
	add a ; $6456
	add a ; $6457
	add a ; $6458
	ld de, $0101 ; $6459
	call DebugDrawHexRowLabel ; $645c
	ld de, $0401 ; $645f
	call DebugDrawFlagBitRow ; $6462
	add $08 ; $6465
	ld de, $0402 ; $6467
	call DebugDrawFlagBitRow ; $646a
	add $08 ; $646d
	ld de, $0104 ; $646f
	call DebugDrawHexRowLabel ; $6472
	ld de, $0404 ; $6475
	call DebugDrawFlagBitRow ; $6478
	add $08 ; $647b
	ld de, $0405 ; $647d
	call DebugDrawFlagBitRow ; $6480
	pop hl ; $6483
	pop de ; $6484
	pop bc ; $6485
	pop af ; $6486
	ret ; $6487
HexDigitChars_05:
	INCBIN "data/bank_005/d_6488.bin" ; $6488, 16 bytes
DebugDrawHexRowLabel:
	push af ; $6498
	push bc ; $6499
	push de ; $649a
	push hl ; $649b
	ld hl, HexDigitChars_05 ; $649c
	swap a ; $649f
	and $0f ; $64a1
	add l ; $64a3
	ld l, a ; $64a4
	jr nc, .writeCell ; $64a5
	inc h ; $64a7
.writeCell:
	ld c, [hl] ; $64a8
	ld a, b ; $64a9
	ld b, $80 ; $64aa
	call WriteWindowCellTileAttr ; $64ac
	inc d ; $64af
	ld c, $3f ; $64b0
	call WriteWindowCellTileAttr ; $64b2
	pop hl ; $64b5
	pop de ; $64b6
	pop bc ; $64b7
	pop af ; $64b8
	ret ; $64b9
DebugDrawFlagBitRow:
	push af ; $64ba
	push bc ; $64bb
	push de ; $64bc
	push hl ; $64bd
	ld l, a ; $64be
	ld h, $00 ; $64bf
	ld c, $08 ; $64c1
.bitLoop:
	push de ; $64c3
	ld e, l ; $64c4
	ld d, h ; $64c5
	call TestGameFlagByNumber ; $64c6
	pop de ; $64c9
	push bc ; $64ca
	ld c, $65 ; $64cb
	jr z, .writeCell ; $64cd
	ld c, $40 ; $64cf
.writeCell:
	ld a, b ; $64d1
	ld b, $80 ; $64d2
	call WriteWindowCellTileAttr ; $64d4
	inc hl ; $64d7
	inc d ; $64d8
	inc d ; $64d9
	pop bc ; $64da
	dec c ; $64db
	jr nz, .bitLoop ; $64dc
	pop hl ; $64de
	pop de ; $64df
	pop bc ; $64e0
	pop af ; $64e1
	ret ; $64e2
DebugDrawFlagCursor:
	push af ; $64e3
	push bc ; $64e4
	push de ; $64e5
	push hl ; $64e6
	ld a, [wDebugFlagBit] ; $64e7
	add a ; $64ea
	add $03 ; $64eb
	ld d, a ; $64ed
	ld a, [wDebugFlagByte] ; $64ee
	and $03 ; $64f1
	add $01 ; $64f3
	cp $03 ; $64f5
	jr c, .lt03 ; $64f7
	inc a ; $64f9
.lt03:
	ld e, a ; $64fa
	ld hl, wDebugFlagWindow1Id ; $64fb
	ld a, [wDebugFlagByte] ; $64fe
	bit 2, a ; $6501
	jr z, .read ; $6503
	ld hl, wDebugFlagWindow2Id ; $6505
.read:
	ld a, [hl] ; $6508
	ld bc, $800d ; $6509
	call WriteWindowCellTileAttr ; $650c
	pop hl ; $650f
	pop de ; $6510
	pop bc ; $6511
	pop af ; $6512
	ret ; $6513
DebugEraseFlagCursor:
	push af ; $6514
	push bc ; $6515
	push de ; $6516
	push hl ; $6517
	ld a, [wDebugFlagBit] ; $6518
	add a ; $651b
	add $03 ; $651c
	ld d, a ; $651e
	ld a, [wDebugFlagByte] ; $651f
	and $03 ; $6522
	add $01 ; $6524
	cp $03 ; $6526
	jr c, .lt03 ; $6528
	inc a ; $652a
.lt03:
	ld e, a ; $652b
	ld hl, wDebugFlagWindow1Id ; $652c
	ld a, [wDebugFlagByte] ; $652f
	bit 2, a ; $6532
	jr z, .read ; $6534
	ld hl, wDebugFlagWindow2Id ; $6536
.read:
	ld a, [hl] ; $6539
	ld b, $80 ; $653a
	ld c, $20 ; $653c
	call WriteWindowCellTileAttr ; $653e
	pop hl ; $6541
	pop de ; $6542
	pop bc ; $6543
	pop af ; $6544
	ret ; $6545
DebugMoveFlagCursor:
	push af ; $6546
	push bc ; $6547
	push de ; $6548
	push hl ; $6549
	ld a, [wDebugFlagBit] ; $654a
	ld d, a ; $654d
	ld a, [wDebugFlagByte] ; $654e
	ld e, a ; $6551
	ldh a, [hPlayerInputFlags] ; $6552
	bit PADB_LEFT, a ; $6554
	jr nz, .next ; $6556
	bit 4, a ; $6558
	jr nz, .bit4Set ; $655a
	bit 6, a ; $655c
	jr nz, .bit6Set ; $655e
	bit 7, a ; $6560
	jr nz, .negative ; $6562
	jr .step5 ; $6564
.next:
	dec d ; $6566
	jr .step5 ; $6567
.bit4Set:
	inc d ; $6569
	jr .step5 ; $656a
.bit6Set:
	dec e ; $656c
	jr .step5 ; $656d
.negative:
	inc e ; $656f
.step5:
	ld a, d ; $6570
	and $07 ; $6571
	ld [wDebugFlagBit], a ; $6573
	ld a, e ; $6576
	and $07 ; $6577
	ld [wDebugFlagByte], a ; $6579
	pop hl ; $657c
	pop de ; $657d
	pop bc ; $657e
	pop af ; $657f
	ret ; $6580
StubNop_05_6581:
	ret ; $6581
HexDigitHeaderRow0_05:
	; $6582, 16 bytes (ascii)
	db "0 1 2 3 4 5 6 7", $00
HexDigitHeaderRow1_05:
	; $6592, 16 bytes (ascii)
	db "8 9 A B C D E F", $00
RunDebugFlagEditor:
	push af ; $65a2
	push bc ; $65a3
	push de ; $65a4
	push hl ; $65a5
	test_flag FLAG_DEBUG_FLAG_EDITOR_OPEN ; $65a6
	jr z, .notDebugFlagEditorOpen ; $65a9
	set_flag FLAG_DEBUG_FLAG_EDITOR_OPEN ; $65ab
	xor a ; $65ae
	ld [wDebugFlagBit], a ; $65af
	ld [wDebugFlagByte], a ; $65b2
	ld [wDebugFlagPage], a ; $65b5
.notDebugFlagEditorOpen:
	ld de, $0000 ; $65b8
	ld bc, $1404 ; $65bb
	call CreateWindow ; $65be
	ld [wDebugFlagHeaderWindowId], a ; $65c1
	call DrawTextWindowFrame ; $65c4
	ld hl, HexDigitHeaderRow0_05 ; $65c7
	ld de, $0401 ; $65ca
	call WriteStringToWindow ; $65cd
	ld hl, HexDigitHeaderRow1_05 ; $65d0
	ld de, $0402 ; $65d3
	call WriteStringToWindow ; $65d6
	ld de, $0004 ; $65d9
	ld bc, $1407 ; $65dc
	call CreateWindow ; $65df
	ld [wDebugFlagWindow1Id], a ; $65e2
	call DrawTextWindowFrame ; $65e5
	ld de, $000b ; $65e8
	ld bc, $1407 ; $65eb
	call CreateWindow ; $65ee
	ld [wDebugFlagWindow2Id], a ; $65f1
	call DrawTextWindowFrame ; $65f4
	call DebugDrawFlagsWindow1 ; $65f7
	call DebugDrawFlagsWindow2 ; $65fa
	call DebugDrawFlagCursor ; $65fd
	ld a, [wDebugFlagHeaderWindowId] ; $6600
	call RedrawWindowRows ; $6603
	ld a, [wDebugFlagWindow1Id] ; $6606
	call RedrawWindowRows ; $6609
	ld a, [wDebugFlagWindow2Id] ; $660c
	call RedrawWindowRows ; $660f
	ld a, $0f ; $6612
	ld hl, StubNop_05_6581 ; $6614
	call RegisterFrameTask ; $6617
.loop:
	ldh a, [hInputRisingEdge] ; $661a
	bit PADB_B, a ; $661c
	jr nz, .closeWindow ; $661e
	ldh a, [hInputRisingEdge] ; $6620
	bit PADB_A, a ; $6622
	jr z, .checkInputRisingEdge ; $6624
	call DebugToggleSelectedFlag ; $6626
	call DebugDrawFlagsWindow1 ; $6629
	call DebugDrawFlagsWindow2 ; $662c
	ld a, [wDebugFlagWindow1Id] ; $662f
	call RedrawWindowRows ; $6632
	ld a, [wDebugFlagWindow2Id] ; $6635
	call RedrawWindowRows ; $6638
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $663b
	bit PADB_START, a ; $663d
	jr z, .checkPlayerInputFlags ; $663f
	ld a, [wDebugFlagPage] ; $6641
	inc a ; $6644
	and $03 ; $6645
	ld [wDebugFlagPage], a ; $6647
	call DebugDrawFlagsWindow1 ; $664a
	call DebugDrawFlagsWindow2 ; $664d
	ld a, [wDebugFlagWindow1Id] ; $6650
	call RedrawWindowRows ; $6653
	ld a, [wDebugFlagWindow2Id] ; $6656
	call RedrawWindowRows ; $6659
.checkPlayerInputFlags:
	ldh a, [hPlayerInputFlags] ; $665c
	and $f0 ; $665e
	jr z, .advanceFrame ; $6660
	call DebugEraseFlagCursor ; $6662
	call DebugMoveFlagCursor ; $6665
	call DebugDrawFlagCursor ; $6668
	ld a, [wDebugFlagHeaderWindowId] ; $666b
	call RedrawWindowRows ; $666e
	ld a, [wDebugFlagWindow1Id] ; $6671
	call RedrawWindowRows ; $6674
	ld a, [wDebugFlagWindow2Id] ; $6677
	call RedrawWindowRows ; $667a
.advanceFrame:
	call AdvanceFrame ; $667d
	jp .loop ; $6680
.closeWindow:
	ld a, [wDebugFlagHeaderWindowId] ; $6683
	call CloseWindow ; $6686
	ld a, [wDebugFlagWindow1Id] ; $6689
	call CloseWindow ; $668c
	ld a, [wDebugFlagWindow2Id] ; $668f
	call CloseWindow ; $6692
	ld hl, StubNop_05_6581 ; $6695
	call UnregisterFrameTask ; $6698
	pop hl ; $669b
	pop de ; $669c
	pop bc ; $669d
	pop af ; $669e
	ret ; $669f
RunDebugMenu:
	ldh a, [hDebugStepMode] ; $66a0
	or a ; $66a2
	ret z ; $66a3
	push af ; $66a4
	push bc ; $66a5
	push de ; $66a6
	push hl ; $66a7
.loop:
	ld hl, Text_30_311 ; $66a8
	ld de, $0a01 ; $66ab
	call CreateMenuWindowFromText ; $66ae
	ld [wDebugMenuWindowId], a ; $66b1
	farcall RestoreShadowTilemap ; $66b4
	call RenderMenuWindowText ; $66b7
	ld a, [wDebugMenuWindowId] ; $66ba
	call RunMenuSelection ; $66bd
	push af ; $66c0
	ld a, [wDebugMenuWindowId] ; $66c1
	call CloseWindow ; $66c4
	pop af ; $66c7
	cp $ff ; $66c8
	jr z, .restore ; $66ca
	ld hl, TextSubcmdHandlers_05 ; $66cc
	add a ; $66cf
	add l ; $66d0
	ld l, a ; $66d1
	jr nc, .read ; $66d2
	inc h ; $66d4
.read:
	ld a, [hl+] ; $66d5
	ld h, [hl] ; $66d6
	ld l, a ; $66d7
	jp hl ; $66d8
.restore:
	pop hl ; $66d9
	pop de ; $66da
	pop bc ; $66db
	pop af ; $66dc
	ret ; $66dd
TextSubcmdHandlers_05:
	; $66de, 8 bytes (records:2)
	dw RunDebugWarpMenuThunk ; record 0
	dw TextSubcmdHandler1 ; record 1
	dw StartDebugPaletteEditorThunk ; record 2
	dw RunDebugFlagEditorThunk ; record 3
RunDebugWarpMenuThunk:
	call RunDebugWarpMenu ; $66e6
	jr RunDebugMenu.loop ; $66e9
TextSubcmdHandler1:
	ld c, $10 ; $66eb
	call BeginFadeOut ; $66ed
	call WaitFadeEnd ; $66f0
	ld hl, wStoryModePlayersXPosition ; $66f3
	ld de, wStoryModeSpawnPosition ; $66f6
	ld bc, $0005 ; $66f9
	call CopyMemoryBC ; $66fc
	ld a, $ff ; $66ff
	ld [wStoryModeEntryPoint], a ; $6701
	ld [wUnusedExitLocationMirror], a ; $6704
	ld [wStoryModeExitLocationRequest], a ; $6707
	set_flag FLAG_CHAR_DATA_START_EXITS ; $670a
	ld c, $00 ; $670d
	farcall CharDataScreen_Show ; $670f
	ld c, $01 ; $6712
	farcall CharDataScreen_Show ; $6714
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6717
	farcall SaveStorySlotWithTimer ; $671a
	pop hl ; $671d
	pop de ; $671e
	pop bc ; $671f
	pop af ; $6720
	ret ; $6721
StartDebugPaletteEditorThunk:
	call StartDebugPaletteEditor ; $6722
	jr RunDebugMenu.loop ; $6725
RunDebugFlagEditorThunk:
	call RunDebugFlagEditor ; $6727
	jp RunDebugMenu.loop ; $672a
DebugDrawWarpMenu:
	ld a, [wDebugWarpWindowId] ; $672d
	call DrawTextWindowFrameSaveRegs ; $6730
	ld a, [wDebugMenuWindowId] ; $6733
	ld h, $00 ; $6736
	ld l, a ; $6738
	ld de, $0d02 ; $6739
	ld a, [wDebugWarpWindowId] ; $673c
	ld a, [wDebugMenuWindowId] ; $673f
	ld hl, $0179 ; $6742
	add l ; $6745
	ld l, a ; $6746
	jr nc, .draw ; $6747
	inc h ; $6749
.draw:
	ld de, $0102 ; $674a
	ld a, [wDebugWarpWindowId] ; $674d
	call WriteDialogueToWindow ; $6750
	ld hl, EnterNumberPrompt_05 ; $6753
	ld de, $c720 ; $6756
	ld c, $01 ; $6759
	call CopyMemoryFast ; $675b
	ld hl, $c720 ; $675e
	ld de, $0104 ; $6761
	ld a, [wDebugWarpWindowId] ; $6764
	call WriteStringToWindow ; $6767
	ld de, $c720 ; $676a
	ld a, [wDebugMenuWindowId] ; $676d
	ld h, $00 ; $6770
	ld l, a ; $6772
	ld a, $02 ; $6773
	call FormatDecimalNumber ; $6775
	ld hl, $c720 ; $6778
	ld de, $1102 ; $677b
	ld a, [wDebugWarpWindowId] ; $677e
	call WriteStringToWindow ; $6781
	ld de, $c720 ; $6784
	ld a, [wDebugWarpEntryPoint] ; $6787
	ld h, $00 ; $678a
	ld l, a ; $678c
	ld a, $02 ; $678d
	call FormatDecimalNumber ; $678f
	ld hl, $c720 ; $6792
	ld de, $1104 ; $6795
	ld a, [wDebugWarpWindowId] ; $6798
	call WriteStringToWindow ; $679b
	ld d, $10 ; $679e
	ld a, [$c703] ; $67a0
	add a ; $67a3
	add $02 ; $67a4
	ld e, a ; $67a6
	ld bc, $800d ; $67a7
	ld a, [wDebugWarpWindowId] ; $67aa
	call WriteWindowCellTileAttr ; $67ad
	ld a, [wDebugWarpWindowId] ; $67b0
	call RedrawWindowRows ; $67b3
	ret ; $67b6
EnterNumberPrompt_05:
	; $67b7, 13 bytes (ascii)
	db "- ENTER NO -", $00
RunDebugWarpMenu:
	push af ; $67c4
	push bc ; $67c5
	push de ; $67c6
	push hl ; $67c7
	wram_bank $05 ; $67c8
	xor a ; $67ce
	ld [$c703], a ; $67cf
	ld [wDebugWarpEntryPoint], a ; $67d2
	ld a, [wStoryModeCurrentLocation] ; $67d5
	ld [wDebugMenuWindowId], a ; $67d8
	farcall GetStoryLocationCount ; $67db
	ld [wDebugWarpLocationCount], a ; $67de
	ld de, $0000 ; $67e1
	ld bc, $1406 ; $67e4
	call CreateWindow ; $67e7
	ld [wDebugWarpWindowId], a ; $67ea
	call DebugDrawWarpMenu ; $67ed
	call AdvanceFrame ; $67f0
.loop:
	ldh a, [hInputRisingEdge] ; $67f3
	and PADF_B ; $67f5
	jr nz, .closeWindow ; $67f7
	ldh a, [hInputRisingEdge] ; $67f9
	and PADF_A ; $67fb
	jr z, .checkInputPressed ; $67fd
	ld a, [wDebugMenuWindowId] ; $67ff
	ld [wStoryModeCurrentLocation], a ; $6802
	ld a, [wDebugWarpEntryPoint] ; $6805
	ld [wStoryModeEntryPoint], a ; $6808
	ld a, $ff ; $680b
	ld [wUnusedExitLocationMirror], a ; $680d
	ld [wStoryModeExitLocationRequest], a ; $6810
	jr .closeWindow ; $6813
.checkInputPressed:
	ldh a, [hInputPressed] ; $6815
	and PADF_UP | PADF_DOWN ; $6817
	jr z, .step2 ; $6819
	ld hl, $c703 ; $681b
	ld a, [hl] ; $681e
	xor $01 ; $681f
	ld [hl], a ; $6821
	call DebugDrawWarpMenu ; $6822
.step2:
	ld a, [$c703] ; $6825
	cp $01 ; $6828
	jr z, .eq01 ; $682a
	ld a, [wDebugWarpLocationCount] ; $682c
	ld d, a ; $682f
	ld hl, wDebugMenuWindowId ; $6830
	ld a, [hl] ; $6833
	call DebugStepValueWithDpad ; $6834
	cp [hl] ; $6837
	jr z, .advanceFrame ; $6838
	ld [hl], a ; $683a
	call DebugDrawWarpMenu ; $683b
	jr .advanceFrame ; $683e
.eq01:
	ld d, $10 ; $6840
	ld hl, wDebugWarpEntryPoint ; $6842
	ld a, [hl] ; $6845
	call DebugStepValueWithDpad ; $6846
	cp [hl] ; $6849
	jr z, .advanceFrame ; $684a
	ld [hl], a ; $684c
	call DebugDrawWarpMenu ; $684d
	jr .advanceFrame ; $6850
.advanceFrame:
	call AdvanceFrame ; $6852
	jr .loop ; $6855
.closeWindow:
	ld a, [wDebugWarpWindowId] ; $6857
	call CloseWindow ; $685a
	pop hl ; $685d
	pop de ; $685e
	pop bc ; $685f
	pop af ; $6860
	ret ; $6861
DebugStepValueWithDpad:
	push bc ; $6862
	ld b, a ; $6863
	ldh a, [hInputPressed] ; $6864
	bit PADB_RIGHT, a ; $6866
	jr nz, .next ; $6868
	bit 5, a ; $686a
	jr nz, .bit5Set ; $686c
	ld a, b ; $686e
	pop bc ; $686f
	ret ; $6870
.next:
	inc b ; $6871
	jr .step3 ; $6872
.bit5Set:
	dec b ; $6874
	jr .step3 ; $6875
.step3:
	ld a, b ; $6877
	add a ; $6878
	jr nc, .noCarry ; $6879
	ld a, d ; $687b
	dec a ; $687c
	jr .restore ; $687d
.noCarry:
	rra ; $687f
	cp d ; $6880
	jr c, .restore ; $6881
	xor a ; $6883
.restore:
	pop bc ; $6884
	ret ; $6885
	; $6886, 10 bytes (fill)
	ds 10, $00
PaletteEditorCursorTiles_05:
	INCBIN "data/bank_005/d_6890.bin" ; $6890, 192 bytes
GetSelectedBGPaletteColorPtr:
	ld hl, wDebugPaletteIndex ; $6950
	ld a, [hl] ; $6953
	add a ; $6954
	add a ; $6955
	ld hl, wDebugPaletteColorIndex ; $6956
	add [hl] ; $6959
	add a ; $695a
	ld hl, wBGPalettes ; $695b
	add l ; $695e
	ld l, a ; $695f
	jr nc, .done ; $6960
	inc h ; $6962
.done:
	ret ; $6963
DebugDrawColorComponents:
	push af ; $6964
	push bc ; $6965
	push de ; $6966
	push hl ; $6967
	call GetSelectedBGPaletteColorPtr ; $6968
	ld a, [hl+] ; $696b
	ld b, [hl] ; $696c
	ld c, a ; $696d
	call SplitColorComponents ; $696e
	push de ; $6971
	ld h, $00 ; $6972
	ld l, a ; $6974
	ld de, wDebugMenuWindowId ; $6975
	ld a, $03 ; $6978
	call FormatDecimalNumber ; $697a
	ld h, $00 ; $697d
	ld l, b ; $697f
	ld de, $c703 ; $6980
	ld a, $03 ; $6983
	call FormatDecimalNumber ; $6985
	ld h, $00 ; $6988
	ld l, c ; $698a
	ld de, $c706 ; $698b
	ld a, $03 ; $698e
	call FormatDecimalNumber ; $6990
	pop de ; $6993
	ld a, e ; $6994
	add a ; $6995
	add e ; $6996
	add $00 ; $6997
	ld l, a ; $6999
	adc $c7 ; $699a
	sub l ; $699c
	ld h, a ; $699d
	ld [hl], $0d ; $699e
	xor a ; $69a0
	ld [$c709], a ; $69a1
	ld hl, wDebugMenuWindowId ; $69a4
	ld de, $0102 ; $69a7
	ld a, [wDebugColorEditorWindowId] ; $69aa
	call WriteStringToWindow ; $69ad
	ld a, [wDebugColorEditorWindowId] ; $69b0
	call RedrawWindowRows ; $69b3
	pop hl ; $69b6
	pop de ; $69b7
	pop bc ; $69b8
	pop af ; $69b9
	ret ; $69ba
ColorEditorHeader_05:
	; $69bb, 10 bytes (ascii)
	db "--R--G--B", $00
RunDebugColorEditor:
	ld de, $0700 ; $69c5
	ld bc, $0b04 ; $69c8
	farcall CreateWindow ; $69cb
	ld [wDebugColorEditorWindowId], a ; $69ce
	call DrawTextWindowFrame ; $69d1
	call RedrawWindowRows ; $69d4
	ld hl, ColorEditorHeader_05 ; $69d7
	ld de, $0101 ; $69da
	ld a, [wDebugColorEditorWindowId] ; $69dd
	call WriteStringToWindow ; $69e0
	ld e, $00 ; $69e3
	call DebugDrawColorComponents ; $69e5
.loop:
	ldh a, [hInputRisingEdge] ; $69e8
	and PADF_A | PADF_B ; $69ea
	jr nz, .closeWindow ; $69ec
	ldh a, [hPlayerInputFlags] ; $69ee
	bit PADB_LEFT, a ; $69f0
	jr z, .step ; $69f2
	dec e ; $69f4
	jr .step4 ; $69f5
.step:
	bit 4, a ; $69f7
	jr z, .bit4Clear ; $69f9
	inc e ; $69fb
	jr .step4 ; $69fc
.bit4Clear:
	bit 6, a ; $69fe
	jr z, .bit6Clear ; $6a00
	ld d, $01 ; $6a02
	jr .getSelectedBGPaletteColorPtr ; $6a04
.bit6Clear:
	bit 7, a ; $6a06
	jr z, .advanceFrame ; $6a08
	ld d, $ff ; $6a0a
	jr .getSelectedBGPaletteColorPtr ; $6a0c
.advanceFrame:
	call AdvanceFrame ; $6a0e
	jr .loop ; $6a11
.step4:
	ld a, e ; $6a13
	cp $ff ; $6a14
	jr nz, .compare ; $6a16
	ld e, $02 ; $6a18
.compare:
	cp $03 ; $6a1a
	jr nz, .debugDrawColorComponents ; $6a1c
	ld e, $00 ; $6a1e
.debugDrawColorComponents:
	call DebugDrawColorComponents ; $6a20
	jr .loop ; $6a23
.getSelectedBGPaletteColorPtr:
	call GetSelectedBGPaletteColorPtr ; $6a25
	ld a, [hl+] ; $6a28
	ld c, a ; $6a29
	ld a, [hl-] ; $6a2a
	ld b, a ; $6a2b
	ld a, e ; $6a2c
	and $03 ; $6a2d
	jr nz, .maskSet ; $6a2f
	call AdjustColorRed ; $6a31
.maskSet:
	dec a ; $6a34
	jr nz, .countLeft ; $6a35
	call AdjustColorGreen ; $6a37
.countLeft:
	dec a ; $6a3a
	jr nz, .countLeft2 ; $6a3b
	call AdjustColorBlue ; $6a3d
.countLeft2:
	ld a, c ; $6a40
	ld [hl+], a ; $6a41
	ld a, b ; $6a42
	ld [hl-], a ; $6a43
	ld a, $03 ; $6a44
	ldh [hPaletteDirtyFlags], a ; $6a46
	call DebugDrawColorComponents ; $6a48
	jr .loop ; $6a4b
.closeWindow:
	ld a, [wDebugColorEditorWindowId] ; $6a4d
	call CloseWindow ; $6a50
	ret ; $6a53
RunDebugPaletteViewer:
	wram_bank $05 ; $6a54
	ld de, $0000 ; $6a5a
	ld bc, $0712 ; $6a5d
	ld a, $00 ; $6a60
	farcall CreateWindowWithAttr ; $6a62
	ld [wDebugPaletteViewerWindowId], a ; $6a65
	ld a, [wDebugPaletteViewerWindowId] ; $6a68
	call DrawTextWindowFrame ; $6a6b
	ld h, $10 ; $6a6e
	ld de, $0101 ; $6a70
	ld bc, $0030 ; $6a73
.loop:
	call WriteWindowCellTileAttr ; $6a76
	inc e ; $6a79
	inc c ; $6a7a
	res 3, c ; $6a7b
	dec h ; $6a7d
	jr nz, .loop ; $6a7e
	ld h, $08 ; $6a80
	ld e, $01 ; $6a82
	ld b, $00 ; $6a84
.loopB:
	ld d, $02 ; $6a86
	ld c, $a0 ; $6a88
	call WriteWindowCellTileAttr ; $6a8a
	inc d ; $6a8d
	ld c, $a1 ; $6a8e
	call WriteWindowCellTileAttr ; $6a90
	inc d ; $6a93
	ld c, $a2 ; $6a94
	call WriteWindowCellTileAttr ; $6a96
	inc d ; $6a99
	ld c, $a3 ; $6a9a
	call WriteWindowCellTileAttr ; $6a9c
	inc e ; $6a9f
	inc b ; $6aa0
	dec h ; $6aa1
	jr nz, .loopB ; $6aa2
	ld a, [wDebugPaletteViewerWindowId] ; $6aa4
	call RedrawWindowRows ; $6aa7
	ld a, $0f ; $6aaa
	ld hl, DrawPaletteCursorSprites ; $6aac
	call RegisterFrameTask ; $6aaf
.loop2:
	ldh a, [hInputRisingEdge] ; $6ab2
	bit PADB_B, a ; $6ab4
	jr nz, .closeWindow ; $6ab6
	bit 0, a ; $6ab8
	jr z, .bit0Clear ; $6aba
	call RunDebugColorEditor ; $6abc
.bit0Clear:
	ld a, [wDebugPaletteColorIndex] ; $6abf
	ld d, a ; $6ac2
	ld a, [wDebugPaletteIndex] ; $6ac3
	ld e, a ; $6ac6
	ldh a, [hInputPressed] ; $6ac7
	bit PADB_LEFT, a ; $6ac9
	jr z, .step2 ; $6acb
	dec d ; $6acd
	jr .step5 ; $6ace
.step2:
	bit 4, a ; $6ad0
	jr z, .bit4Clear ; $6ad2
	inc d ; $6ad4
	jr .step5 ; $6ad5
.bit4Clear:
	bit 6, a ; $6ad7
	jr z, .bit6Clear ; $6ad9
	dec e ; $6adb
	jr .step5 ; $6adc
.bit6Clear:
	bit 7, a ; $6ade
	jr z, .step5 ; $6ae0
	inc e ; $6ae2
	jr .step5 ; $6ae3
.step5:
	ld a, d ; $6ae5
	and $03 ; $6ae6
	ld [wDebugPaletteColorIndex], a ; $6ae8
	ld a, e ; $6aeb
	and $0f ; $6aec
	ld [wDebugPaletteIndex], a ; $6aee
	call AdvanceFrame ; $6af1
	jr .loop2 ; $6af4
.closeWindow:
	ld a, [wDebugPaletteViewerWindowId] ; $6af6
	call CloseWindow ; $6af9
	ld hl, DrawPaletteCursorSprites ; $6afc
	call UnregisterFrameTask ; $6aff
	ret ; $6b02
DrawPaletteCursorSprites:
	ld a, [wCameraX] ; $6b03
	rlca ; $6b06
	rlca ; $6b07
	rlca ; $6b08
	add $04 ; $6b09
	and $07 ; $6b0b
	ld h, a ; $6b0d
	ld a, [wCameraY] ; $6b0e
	rlca ; $6b11
	rlca ; $6b12
	rlca ; $6b13
	add $04 ; $6b14
	and $07 ; $6b16
	ld l, a ; $6b18
	ld a, [wDebugPaletteColorIndex] ; $6b19
	add a ; $6b1c
	add a ; $6b1d
	add a ; $6b1e
	add $18 ; $6b1f
	sub h ; $6b21
	ld d, a ; $6b22
	ld a, [wDebugPaletteIndex] ; $6b23
	add a ; $6b26
	add a ; $6b27
	add a ; $6b28
	add $18 ; $6b29
	sub l ; $6b2b
	ld e, a ; $6b2c
	ld b, $01 ; $6b2d
	ld c, $60 ; $6b2f
	push hl ; $6b31
	call QueueSprite16 ; $6b32
	pop hl ; $6b35
	ld a, $50 ; $6b36
	sub l ; $6b38
	ld e, a ; $6b39
	ld b, $00 ; $6b3a
	ld a, $08 ; $6b3c
.loop:
	push af ; $6b3e
	push hl ; $6b3f
	ld a, $20 ; $6b40
	sub h ; $6b42
	ld d, a ; $6b43
	ld c, $66 ; $6b44
	push de ; $6b46
	call QueueSprite ; $6b47
	pop de ; $6b4a
	ld a, d ; $6b4b
	add $08 ; $6b4c
	ld d, a ; $6b4e
	inc c ; $6b4f
	inc c ; $6b50
	push de ; $6b51
	call QueueSprite ; $6b52
	pop de ; $6b55
	ld a, d ; $6b56
	add $08 ; $6b57
	ld d, a ; $6b59
	inc c ; $6b5a
	inc c ; $6b5b
	push de ; $6b5c
	call QueueSprite ; $6b5d
	pop de ; $6b60
	ld a, e ; $6b61
	add $08 ; $6b62
	ld e, a ; $6b64
	inc b ; $6b65
	pop hl ; $6b66
	pop af ; $6b67
	dec a ; $6b68
	jr nz, .loop ; $6b69
	ret ; $6b6b
StartDebugPaletteEditor:
	ld hl, PaletteEditorCursorTiles_05 ; $6b6c
	ld de, $8600 ; $6b6f
	ld c, (GetSelectedBGPaletteColorPtr - PaletteEditorCursorTiles_05) / 16 ; $6b72
	call QueueVRAMCopy ; $6b74
	xor a ; $6b77
	ld [wDebugPaletteColorIndex], a ; $6b78
	ld [wDebugPaletteIndex], a ; $6b7b
	call RunDebugPaletteViewer ; $6b7e
	ret ; $6b81
WriteStringToTilemap:
	push af ; $6b82
.loop:
	ld a, [hl] ; $6b83
	cp $00 ; $6b84
	jr z, .restore ; $6b86
	ld [de], a ; $6b88
	inc hl ; $6b89
	ld a, [hl] ; $6b8a
	cp $de ; $6b8b
	jr z, .eqde ; $6b8d
	cp $df ; $6b8f
	jr nz, .nedf ; $6b91
.eqde:
	push hl ; $6b93
	push bc ; $6b94
	ld h, d ; $6b95
	ld l, e ; $6b96
	ld bc, $ffe0 ; $6b97
	add hl, bc ; $6b9a
	ld b, a ; $6b9b
	ld a, [hl] ; $6b9c
	cp $03 ; $6b9d
	ld a, b ; $6b9f
	jr nz, .store ; $6ba0
	sub $d0 ; $6ba2
.store:
	ld [hl], a ; $6ba4
	pop bc ; $6ba5
	pop hl ; $6ba6
	inc hl ; $6ba7
.nedf:
	inc de ; $6ba8
	ld a, e ; $6ba9
	and $1f ; $6baa
	jr nz, .loop ; $6bac
	push hl ; $6bae
	ld h, d ; $6baf
	ld l, e ; $6bb0
	add hl, de ; $6bb1
	ld d, h ; $6bb2
	ld e, l ; $6bb3
	pop hl ; $6bb4
	jr .loop ; $6bb5
.restore:
	pop af ; $6bb7
	ret ; $6bb8
WriteStringToTilemapAlt:
	push af ; $6bb9
.loop:
	ld a, [hl] ; $6bba
	cp $00 ; $6bbb
	jr z, .restore ; $6bbd
	ld [de], a ; $6bbf
	inc hl ; $6bc0
	ld a, [hl] ; $6bc1
	cp $de ; $6bc2
	jr z, .eqde ; $6bc4
	cp $df ; $6bc6
	jr nz, .nedf ; $6bc8
.eqde:
	push hl ; $6bca
	push bc ; $6bcb
	ld h, d ; $6bcc
	ld l, e ; $6bcd
	ld bc, $ffe0 ; $6bce
	add hl, bc ; $6bd1
	ld b, a ; $6bd2
	ld a, [hl] ; $6bd3
	cp $0e ; $6bd4
	ld a, b ; $6bd6
	jr nz, .store ; $6bd7
	sub $82 ; $6bd9
.store:
	ld [hl], a ; $6bdb
	pop bc ; $6bdc
	pop hl ; $6bdd
	inc hl ; $6bde
.nedf:
	inc de ; $6bdf
	ld a, e ; $6be0
	and $1f ; $6be1
	jr nz, .loop ; $6be3
	push hl ; $6be5
	ld h, d ; $6be6
	ld l, e ; $6be7
	add hl, de ; $6be8
	ld d, h ; $6be9
	ld e, l ; $6bea
	pop hl ; $6beb
	jr .loop ; $6bec
.restore:
	pop af ; $6bee
	ret ; $6bef
WriteStringToTilemapStreamed:
	push af ; $6bf0
	ld a, d ; $6bf1
	ld [$dc05], a ; $6bf2
	ld a, e ; $6bf5
	ld [$dc06], a ; $6bf6
	xor a ; $6bf9
	ld [$dc09], a ; $6bfa
.loop:
	ld a, [hl] ; $6bfd
	cp $00 ; $6bfe
	jr z, .restore ; $6c00
	cp $01 ; $6c02
	jr nz, .ne01 ; $6c04
	ld c, a ; $6c06
	ld a, [$dc05] ; $6c07
	ld d, a ; $6c0a
	ld a, [$dc06] ; $6c0b
	ld e, a ; $6c0e
	push hl ; $6c0f
	ld h, d ; $6c10
	ld l, e ; $6c11
	ld d, $00 ; $6c12
	ld e, $40 ; $6c14
	add hl, de ; $6c16
	ld d, h ; $6c17
	ld e, l ; $6c18
	ld a, d ; $6c19
	ld [$dc05], a ; $6c1a
	ld a, e ; $6c1d
	ld [$dc06], a ; $6c1e
	pop hl ; $6c21
	ld a, c ; $6c22
	inc hl ; $6c23
	ld a, [hl] ; $6c24
.ne01:
	ld c, $00 ; $6c25
	cp $02 ; $6c27
	jr nz, .ne02 ; $6c29
	ld a, $01 ; $6c2b
	ld [$dc09], a ; $6c2d
	inc hl ; $6c30
	ld a, h ; $6c31
	ld [$dc07], a ; $6c32
	ld a, l ; $6c35
	ld [$dc08], a ; $6c36
	jr .restore ; $6c39
.ne02:
	ld c, $01 ; $6c3b
	cp $03 ; $6c3d
	jr nz, .store ; $6c3f
	ld a, $01 ; $6c41
	ld [$dc0a], a ; $6c43
	jr .restore ; $6c46
.store:
	ld [de], a ; $6c48
	inc hl ; $6c49
	ld a, [hl] ; $6c4a
	cp $de ; $6c4b
	jr z, .eqde ; $6c4d
	cp $df ; $6c4f
	jr nz, .nedf ; $6c51
.eqde:
	push hl ; $6c53
	push bc ; $6c54
	ld h, d ; $6c55
	ld l, e ; $6c56
	ld bc, $ffe0 ; $6c57
	add hl, bc ; $6c5a
	ld b, a ; $6c5b
	ld a, [hl] ; $6c5c
	cp $0e ; $6c5d
	ld a, b ; $6c5f
	jr nz, .store2 ; $6c60
	sub $82 ; $6c62
.store2:
	ld [hl], a ; $6c64
	pop bc ; $6c65
	pop hl ; $6c66
	inc hl ; $6c67
.nedf:
	inc de ; $6c68
	ld a, e ; $6c69
	and $1f ; $6c6a
	jr nz, .loop ; $6c6c
	push hl ; $6c6e
	ld h, d ; $6c6f
	ld l, e ; $6c70
	add hl, de ; $6c71
	ld d, h ; $6c72
	ld e, l ; $6c73
	pop hl ; $6c74
	jr .loop ; $6c75
.restore:
	pop af ; $6c77
	ret ; $6c78
	push af ; $6c79
	push bc ; $6c7a
	push de ; $6c7b
	push hl ; $6c7c
	ldh a, [hWramBank] ; $6c7d
	push af ; $6c7f
	wram_bank $05 ; $6c80
	xor a ; $6c86
	call AddTextIdOffset ; $6c87
	xor a ; $6c8a
	ld [wTextArgStringWriteIndex], a ; $6c8b
	ld [w5_d866], a ; $6c8e
	ld [w5_d848], a ; $6c91
	ld [w5_d867], a ; $6c94
	ld [wTextArgShortTextWriteIndex], a ; $6c97
	ld [w5_d868], a ; $6c9a
	ld a, e ; $6c9d
	ld [wGlyphVramDest], a ; $6c9e
	ld a, d ; $6ca1
	ld [wGlyphVramDest + 1], a ; $6ca2
	ld b, $ff ; $6ca5
	ld a, c ; $6ca7
	cpl ; $6ca8
	inc a ; $6ca9
	ld c, a ; $6caa
	ld [wTextRowIndent], a ; $6cab
	call FetchDialogueText ; $6cae
	ld hl, wTextBuffer ; $6cb1
	pop af ; $6cb4
	wram_bank ; $6cb5
.loopB:
	ld a, [hl] ; $6cb9
	or a ; $6cba
	jr z, .checkWramBank ; $6cbb
	cp $03 ; $6cbd
	jr z, .checkWramBank ; $6cbf
	inc hl ; $6cc1
	push af ; $6cc2
	ld a, [hl] ; $6cc3
	ld [wTextCharNameArg], a ; $6cc4
	pop af ; $6cc7
	jr .dispatchControlCode ; $6cc8
	cp $01 ; $6cca
	jr nz, .store3 ; $6ccc
	ld a, $0d ; $6cce
.dispatchControlCode:
	call DispatchControlCode ; $6cd0
	inc hl ; $6cd3
	jr .loopB ; $6cd4
.store3:
	ld [de], a ; $6cd6
	inc hl ; $6cd7
	ld a, [hl] ; $6cd8
	cp $de ; $6cd9
	jr z, .eqde2 ; $6cdb
	cp $df ; $6cdd
	jr nz, .nedf2 ; $6cdf
.eqde2:
	push hl ; $6ce1
	ld h, d ; $6ce2
	ld l, e ; $6ce3
	add hl, bc ; $6ce4
	ld b, a ; $6ce5
	ld a, [hl] ; $6ce6
	cp $0e ; $6ce7
	ld a, b ; $6ce9
	ld b, $ff ; $6cea
	jr nz, .store4 ; $6cec
	sub $82 ; $6cee
.store4:
	ld [hl], a ; $6cf0
	pop hl ; $6cf1
	inc hl ; $6cf2
.nedf2:
	inc de ; $6cf3
	ld a, e ; $6cf4
	and $3f ; $6cf5
	jr nz, .loopB ; $6cf7
	push hl ; $6cf9
	ld h, d ; $6cfa
	ld l, e ; $6cfb
	add hl, bc ; $6cfc
	ld d, h ; $6cfd
	ld e, l ; $6cfe
	pop hl ; $6cff
	jr .loopB ; $6d00
.checkWramBank:
	ldh a, [hWramBank] ; $6d02
	push af ; $6d04
	wram_bank $05 ; $6d05
	xor a ; $6d0b
	ld [wTextRowIndent], a ; $6d0c
	ld [wTextArgStringWriteIndex], a ; $6d0f
	ld [w5_d866], a ; $6d12
	ld [w5_d848], a ; $6d15
	ld [w5_d867], a ; $6d18
	ld [wTextArgShortTextWriteIndex], a ; $6d1b
	ld [w5_d868], a ; $6d1e
	pop af ; $6d21
	wram_bank ; $6d22
	pop hl ; $6d26
	pop de ; $6d27
	pop bc ; $6d28
	pop af ; $6d29
	ret ; $6d2a
FetchSRAMDialogueText:
	push af ; $6d2b
	ld a, $00 ; $6d2c
	call FetchSRAMText ; $6d2e
	pop af ; $6d31
	ret ; $6d32
	push af ; $6d33
	ld a, $01 ; $6d34
	call FetchSRAMText ; $6d36
	pop af ; $6d39
	ret ; $6d3a
FetchSRAMText:
	push bc ; $6d3b
	push de ; $6d3c
	push hl ; $6d3d
	ld hl, SramTextOffsetTable_05 ; $6d3e
	sla e ; $6d41
	rl d ; $6d43
	add hl, de ; $6d45
	ld e, [hl] ; $6d46
	inc hl ; $6d47
	ld d, [hl] ; $6d48
	ld hl, $a800 ; $6d49
	add hl, de ; $6d4c
	or a ; $6d4d
	jr nz, .nonZero ; $6d4e
	ld de, wTextBuffer ; $6d50
	ld bc, $0180 ; $6d53
	jr .copyMemoryBC ; $6d56
.nonZero:
	ld de, wShortTextBuffer ; $6d58
	ld bc, $0020 ; $6d5b
.copyMemoryBC:
	call CopyMemoryBC ; $6d5e
	pop hl ; $6d61
	pop de ; $6d62
	pop bc ; $6d63
	ret ; $6d64
SramTextOffsetTable_05:
	; $6d65, 32 bytes (records:2)
	dw $0009 ; record 0
	dw $0089 ; record 1
	dw $0109 ; record 2
	dw $0189 ; record 3
	dw $0209 ; record 4
	dw $0289 ; record 5
	dw $0309 ; record 6
	dw $0389 ; record 7
	dw $0409 ; record 8
	dw $0489 ; record 9
	dw $0509 ; record 10
	dw $0589 ; record 11
	dw $0609 ; record 12
	dw $0689 ; record 13
	dw $0709 ; record 14
	dw $0789 ; record 15
RunDebugWindowDemo:
	ldh a, [hWramBank] ; $6d85
	push af ; $6d87
	xor a ; $6d88
	ld a, $02 ; $6d89
	ldh [hScrollX], a ; $6d8b
	ldh [hScrollY], a ; $6d8d
	script_fade_in $7f ; $6d8f
	call WaitFadeEnd ; $6d94
	call RestoreShadowTilemap ; $6d97
	call WaitFramesCmd ; $6d9a
	db $1e ; $6d9d inline arg
	call DisableLCDSafely ; $6d9e
	call ResetTextWindowState ; $6da1
	ld de, $d000 ; $6da4
	ld hl, wShadowTilemapPtr ; $6da7
	ld a, e ; $6daa
	ld [hl+], a ; $6dab
	ld [hl], d ; $6dac
	ld a, $05 ; $6dad
	ld [wShadowTilemapBank], a ; $6daf
	ld a, $80 ; $6db2
	ld [wWindowTileAttr], a ; $6db4
	ld d, $00 ; $6db7
	ld e, $02 ; $6db9
	ld b, $10 ; $6dbb
	ld c, $07 ; $6dbd
	call CreateWindowFromScreenRect ; $6dbf
	call DrawTextWindowFrame ; $6dc2
	call RedrawWindowRows ; $6dc5
	ld d, $02 ; $6dc8
	ld e, $04 ; $6dca
	ld b, $08 ; $6dcc
	ld c, $0c ; $6dce
	call CreateWindowFromScreenRect ; $6dd0
	call DrawTextWindowFrame ; $6dd3
	call RedrawWindowRows ; $6dd6
	call EnableLCD ; $6dd9
	pop af ; $6ddc
	wram_bank ; $6ddd
	sound $72 ; $6de1
.loop:
	ldh a, [hPlayerInputFlags] ; $6de3
	ld hl, hScrollX ; $6de5
	bit PADB_RIGHT, a ; $6de8
	jr z, .step ; $6dea
	inc [hl] ; $6dec
	jr .step2 ; $6ded
.step:
	bit 5, a ; $6def
	jr z, .step2 ; $6df1
	dec [hl] ; $6df3
.step2:
	ld hl, hScrollY ; $6df4
	bit 6, a ; $6df7
	jr z, .bit6Clear ; $6df9
	dec [hl] ; $6dfb
	jr .advanceFrame ; $6dfc
.bit6Clear:
	bit 7, a ; $6dfe
	jr z, .advanceFrame ; $6e00
	inc [hl] ; $6e02
.advanceFrame:
	call AdvanceFrame ; $6e03
	jr .loop ; $6e06
	ret ; $6e08
ResetTextWindowState:
	push af ; $6e09
	push bc ; $6e0a
	push de ; $6e0b
	push hl ; $6e0c
	wram_bank $05 ; $6e0d
	ld hl, $d000 ; $6e13
	ld c, $80 ; $6e16
	call ClearMemory16 ; $6e18
	ld hl, $d800 ; $6e1b
	ld c, $80 ; $6e1e
	call ClearMemory16 ; $6e20
	ld de, $d000 ; $6e23
	ld hl, wShadowTilemapPtr ; $6e26
	ld a, e ; $6e29
	ld [hl+], a ; $6e2a
	ld [hl], d ; $6e2b
	ld a, $05 ; $6e2c
	ld [wShadowTilemapBank], a ; $6e2e
	ld a, $80 ; $6e31
	ld [wWindowTileAttr], a ; $6e33
	ld a, $ff ; $6e36
	ld [wDialogueWindowId], a ; $6e38
	ld a, $fe ; $6e3b
	ld [wMenuWindowId], a ; $6e3d
	pop hl ; $6e40
	pop de ; $6e41
	pop bc ; $6e42
	pop af ; $6e43
	ret ; $6e44
CreateWindowFromScreenRect:
	push bc ; $6e45
	push de ; $6e46
	push hl ; $6e47
	call PrepareGlyphBuffer ; $6e48
	wram_bank $05 ; $6e4b
	ld h, d ; $6e51
	ld l, e ; $6e52
	call GetScreenTopLeftCell ; $6e53
	ld a, h ; $6e56
	add d ; $6e57
	ld d, a ; $6e58
	ld a, l ; $6e59
	add e ; $6e5a
	ld e, a ; $6e5b
	call AllocWindowStruct ; $6e5c
	ld a, [wWindowId] ; $6e5f
	cp $ff ; $6e62
	jr z, .done ; $6e64
	ld a, [wWindowId] ; $6e66
.done:
	pop hl ; $6e69
	pop de ; $6e6a
	pop bc ; $6e6b
	ret ; $6e6c
AllocWindowStruct:
	push de ; $6e6d
	push bc ; $6e6e
	push hl ; $6e6f
	wram_bank $05 ; $6e70
	call AllocWindowId ; $6e76
	cp $ff ; $6e79
	jr z, .restore ; $6e7b
	ld [wWindowId], a ; $6e7d
	add a ; $6e80
	add a ; $6e81
	add a ; $6e82
	ld hl, $dc00 ; $6e83
	add l ; $6e86
	ld l, a ; $6e87
	jr nc, .store ; $6e88
	inc h ; $6e8a
.store:
	ld [hl], d ; $6e8b
	inc hl ; $6e8c
	ld [hl], e ; $6e8d
	inc hl ; $6e8e
	ld [hl], b ; $6e8f
	inc hl ; $6e90
	ld [hl], c ; $6e91
.restore:
	pop hl ; $6e92
	pop bc ; $6e93
	pop de ; $6e94
	ret ; $6e95
AllocWindowId:
	push hl ; $6e96
	push bc ; $6e97
	push de ; $6e98
	ld b, $07 ; $6e99
	ld a, [wWindowSlotMask] ; $6e9b
	ld c, $01 ; $6e9e
.loop:
	rrca ; $6ea0
	jr nc, .step ; $6ea1
	sla c ; $6ea3
	dec b ; $6ea5
	jr nz, .loop ; $6ea6
	ld a, $ff ; $6ea8
	jr .restore ; $6eaa
.step:
	ld a, [wWindowSlotMask] ; $6eac
	or c ; $6eaf
	ld [wWindowSlotMask], a ; $6eb0
	ld a, $07 ; $6eb3
	sub b ; $6eb5
.restore:
	pop de ; $6eb6
	pop bc ; $6eb7
	pop hl ; $6eb8
	ret ; $6eb9
FreeWindow:
	push bc ; $6eba
	push de ; $6ebb
	ld d, a ; $6ebc
	call GetWindowStructPtr ; $6ebd
	xor a ; $6ec0
	ld c, $08 ; $6ec1
.clearLoop:
	ld [hl+], a ; $6ec3
	dec c ; $6ec4
	jr nz, .clearLoop ; $6ec5
	ld c, d ; $6ec7
	inc c ; $6ec8
	ld a, $01 ; $6ec9
.maskLoop:
	dec c ; $6ecb
	jr z, .clearBit ; $6ecc
	sla a ; $6ece
	jr .maskLoop ; $6ed0
.clearBit:
	ld b, a ; $6ed2
	ld a, [wWindowSlotMask] ; $6ed3
	and b ; $6ed6
	ld a, $ff ; $6ed7
	jr z, .restore ; $6ed9
	ld a, b ; $6edb
	xor $ff ; $6edc
	ld b, a ; $6ede
	ld a, [wWindowSlotMask] ; $6edf
	and b ; $6ee2
	ld [wWindowSlotMask], a ; $6ee3
	ld a, d ; $6ee6
.restore:
	pop de ; $6ee7
	pop bc ; $6ee8
	ret ; $6ee9
GetWindowStructPtr:
	push af ; $6eea
	and $07 ; $6eeb
	add a ; $6eed
	add a ; $6eee
	add a ; $6eef
	ld hl, $dc00 ; $6ef0
	add l ; $6ef3
	ld l, a ; $6ef4
	jr nc, .done ; $6ef5
	inc h ; $6ef7
.done:
	pop af ; $6ef8
	ret ; $6ef9
SaveWindowStruct:
	push af ; $6efa
	push bc ; $6efb
	push de ; $6efc
	push hl ; $6efd
	call GetWindowStructPtr ; $6efe
	ld de, $dc78 ; $6f01
	ld c, $08 ; $6f04
.loop:
	ld a, [hl+] ; $6f06
	ld [de], a ; $6f07
	inc de ; $6f08
	dec c ; $6f09
	jr nz, .loop ; $6f0a
	pop hl ; $6f0c
	pop de ; $6f0d
	pop bc ; $6f0e
	pop af ; $6f0f
	ret ; $6f10
RestoreWindowStruct:
	push af ; $6f11
	push bc ; $6f12
	push de ; $6f13
	push hl ; $6f14
	call GetWindowStructPtr ; $6f15
	ld d, h ; $6f18
	ld e, l ; $6f19
	ld hl, $dc78 ; $6f1a
	ld c, $08 ; $6f1d
.loop:
	ld a, [hl+] ; $6f1f
	ld [de], a ; $6f20
	inc de ; $6f21
	dec c ; $6f22
	jr nz, .loop ; $6f23
	pop hl ; $6f25
	pop de ; $6f26
	pop bc ; $6f27
	pop af ; $6f28
	ret ; $6f29
WrapCellPtrToRowStart:
	push af ; $6f2a
	ld a, l ; $6f2b
	and $1f ; $6f2c
	jr nz, .done ; $6f2e
	push bc ; $6f30
	ld bc, $ffe0 ; $6f31
	add hl, bc ; $6f34
	pop bc ; $6f35
.done:
	pop af ; $6f36
	ret ; $6f37
ClampCellPtrToShadowMap:
	push af ; $6f38
	ldh a, [hWramBank] ; $6f39
	push af ; $6f3b
	wram_bank $05 ; $6f3c
	ld a, [wShadowTilemapPtr + 1] ; $6f42
	add $03 ; $6f45
	cp h ; $6f47
	jr nc, .restore ; $6f48
	sub $03 ; $6f4a
	ld h, a ; $6f4c
.restore:
	pop af ; $6f4d
	wram_bank ; $6f4e
	pop af ; $6f52
	ret ; $6f53
ClampCellPtrToAttrMap:
	push af ; $6f54
	ldh a, [hWramBank] ; $6f55
	push af ; $6f57
	wram_bank $05 ; $6f58
	ld a, [wShadowTilemapPtr + 1] ; $6f5e
	add $07 ; $6f61
	cp h ; $6f63
	jr nc, .restore ; $6f64
	sub $03 ; $6f66
	ld h, a ; $6f68
.restore:
	pop af ; $6f69
	wram_bank ; $6f6a
	pop af ; $6f6e
	ret ; $6f6f
DrawTextWindowFrame:
	push af ; $6f70
	push bc ; $6f71
	push de ; $6f72
	push hl ; $6f73
	ld b, a ; $6f74
	ldh a, [hWramBank] ; $6f75
	push af ; $6f77
	ld a, b ; $6f78
	call GetWindowStructPtr ; $6f79
	ld d, [hl] ; $6f7c
	inc hl ; $6f7d
	ld e, [hl] ; $6f7e
	inc hl ; $6f7f
	ld b, [hl] ; $6f80
	inc hl ; $6f81
	ld c, [hl] ; $6f82
	inc hl ; $6f83
	ld a, [hl] ; $6f84
	cp $ff ; $6f85
	jp z, .done ; $6f87
	ld l, e ; $6f8a
	ld h, $00 ; $6f8b
	add hl, hl ; $6f8d
	add hl, hl ; $6f8e
	add hl, hl ; $6f8f
	add hl, hl ; $6f90
	add hl, hl ; $6f91
	ld a, d ; $6f92
	add l ; $6f93
	ld l, a ; $6f94
	jr nc, .gotOffset ; $6f95
	inc h ; $6f97
.gotOffset:
	ld d, h ; $6f98
	ld e, l ; $6f99
	ld hl, wShadowTilemapPtr ; $6f9a
	ld a, [hl+] ; $6f9d
	ld h, [hl] ; $6f9e
	ld l, a ; $6f9f
	add hl, de ; $6fa0
	ld a, [wShadowTilemapPtr + 1] ; $6fa1
	add $03 ; $6fa4
	cp h ; $6fa6
	jr nc, .mapPtrOk ; $6fa7
	ld a, h ; $6fa9
	sub $04 ; $6faa
	ld h, a ; $6fac
.mapPtrOk:
	ld e, b ; $6fad
	ld d, c ; $6fae
	ld a, [wWindowTileAttr] ; $6faf
	push af ; $6fb2
	push de ; $6fb3
	push hl ; $6fb4
	dec d ; $6fb5
	dec d ; $6fb6
	dec e ; $6fb7
	dec e ; $6fb8
	ld a, [wShadowTilemapBank] ; $6fb9
	ld a, a ; $6fbc
	wram_bank ; $6fbd
	ld a, [wGlyphRowStartCol] ; $6fc1
	add $80 ; $6fc4
	ld [$cb75], a ; $6fc6
	push hl ; $6fc9
	ld [hl], $02 ; $6fca
	inc hl ; $6fcc
	call WrapCellPtrToRowStart ; $6fcd
	ld b, e ; $6fd0
	ld a, $03 ; $6fd1
.topLoop:
	ld [hl+], a ; $6fd3
	call WrapCellPtrToRowStart ; $6fd4
	dec b ; $6fd7
	jr nz, .topLoop ; $6fd8
	ld [hl], $04 ; $6fda
	inc hl ; $6fdc
	call WrapCellPtrToRowStart ; $6fdd
	pop hl ; $6fe0
	ld a, $20 ; $6fe1
	add l ; $6fe3
	ld l, a ; $6fe4
	jr nc, .topRowDone ; $6fe5
	inc h ; $6fe7
.topRowDone:
	call ClampCellPtrToShadowMap ; $6fe8
.midRowLoop:
	push hl ; $6feb
	ld [hl], $05 ; $6fec
	inc hl ; $6fee
	call WrapCellPtrToRowStart ; $6fef
	ld b, e ; $6ff2
	bit 0, d ; $6ff3
	jr z, .fillBlank ; $6ff5
	ld a, [$cb75] ; $6ff7
.textCellLoop:
	test_flag FLAG_TEXT_RENDER_ACTIVE ; $6ffa
	jr z, .blankCell ; $6ffd
	ld [hl+], a ; $6fff
	jr .nextTextCell ; $7000
.blankCell:
	ld [hl], $20 ; $7002
	inc hl ; $7004
.nextTextCell:
	call WrapCellPtrToRowStart ; $7005
	inc a ; $7008
	dec b ; $7009
	jr nz, .textCellLoop ; $700a
	ld [$cb75], a ; $700c
	jr .midRowEnd ; $700f
.fillBlank:
	ld a, $20 ; $7011
.blankLoop:
	ld [hl+], a ; $7013
	call WrapCellPtrToRowStart ; $7014
	dec b ; $7017
	jr nz, .blankLoop ; $7018
.midRowEnd:
	ld [hl], $06 ; $701a
	inc hl ; $701c
	call WrapCellPtrToRowStart ; $701d
	pop hl ; $7020
	ld a, $20 ; $7021
	add l ; $7023
	ld l, a ; $7024
	jr nc, .midRowDone ; $7025
	inc h ; $7027
.midRowDone:
	call ClampCellPtrToShadowMap ; $7028
	dec d ; $702b
	jr nz, .midRowLoop ; $702c
	push hl ; $702e
	ld [hl], $07 ; $702f
	inc hl ; $7031
	call WrapCellPtrToRowStart ; $7032
	ld b, e ; $7035
	ld a, $08 ; $7036
.bottomLoop:
	ld [hl+], a ; $7038
	call WrapCellPtrToRowStart ; $7039
	dec b ; $703c
	jr nz, .bottomLoop ; $703d
	ld [hl], $09 ; $703f
	inc hl ; $7041
	call WrapCellPtrToRowStart ; $7042
	pop hl ; $7045
	ld a, $20 ; $7046
	add l ; $7048
	ld l, a ; $7049
	jr nc, .bottomRowDone ; $704a
	inc h ; $704c
.bottomRowDone:
	call ClampCellPtrToShadowMap ; $704d
	pop hl ; $7050
	ld bc, $0400 ; $7051
	add hl, bc ; $7054
	pop de ; $7055
	pop af ; $7056
	dec e ; $7057
	dec e ; $7058
	ld c, a ; $7059
.attrRowLoop:
	push hl ; $705a
	ld [hl], c ; $705b
	inc hl ; $705c
	call WrapCellPtrToRowStart ; $705d
	ld b, e ; $7060
.attrCellLoop:
	ld [hl], c ; $7061
	inc hl ; $7062
	call WrapCellPtrToRowStart ; $7063
	dec b ; $7066
	jr nz, .attrCellLoop ; $7067
	ld [hl], c ; $7069
	inc hl ; $706a
	call WrapCellPtrToRowStart ; $706b
	pop hl ; $706e
	ld a, $20 ; $706f
	add l ; $7071
	ld l, a ; $7072
	jr nc, .attrRowDone ; $7073
	inc h ; $7075
.attrRowDone:
	call ClampCellPtrToAttrMap ; $7076
	dec d ; $7079
	jr nz, .attrRowLoop ; $707a
.done:
	pop af ; $707c
	wram_bank ; $707d
	pop hl ; $7081
	pop de ; $7082
	pop bc ; $7083
	pop af ; $7084
	ret ; $7085
MarkTilemapRowsDirty:
	push af ; $7086
	push bc ; $7087
	push de ; $7088
	push hl ; $7089
	ld a, d ; $708a
	and $1f ; $708b
	ld d, a ; $708d
	call SetRowDirtyFlags ; $708e
	pop hl ; $7091
	pop de ; $7092
	pop bc ; $7093
	pop af ; $7094
	ret ; $7095
MarkWindowRowsDirty:
	push af ; $7096
	push bc ; $7097
	push de ; $7098
	push hl ; $7099
	call GetWindowStructPtr ; $709a
	inc hl ; $709d
	ld d, [hl] ; $709e
	inc hl ; $709f
	inc hl ; $70a0
	ld e, [hl] ; $70a1
	call SetRowDirtyFlags ; $70a2
	pop hl ; $70a5
	pop de ; $70a6
	pop bc ; $70a7
	pop af ; $70a8
	ret ; $70a9
SetRowDirtyFlags:
	ld hl, $dc40 ; $70aa
	ld c, $20 ; $70ad
	xor a ; $70af
.loop:
	ld [hl+], a ; $70b0
	dec c ; $70b1
	jr nz, .loop ; $70b2
	ld hl, $dc40 ; $70b4
	ld a, d ; $70b7
	and $1f ; $70b8
	ld d, a ; $70ba
	add l ; $70bb
	ld l, a ; $70bc
	jr nc, .gotPtr ; $70bd
	inc h ; $70bf
.gotPtr:
	ld a, $01 ; $70c0
.loopB:
	ld [hl+], a ; $70c2
	inc d ; $70c3
	bit 5, d ; $70c4
	jr z, .bit5Clear ; $70c6
	res 5, d ; $70c8
	ld hl, $dc40 ; $70ca
.bit5Clear:
	dec e ; $70cd
	jr nz, .loopB ; $70ce
	ret ; $70d0
MarkWindowRowsDirtyMin7:
	push af ; $70d1
	push bc ; $70d2
	push de ; $70d3
	push hl ; $70d4
	call GetWindowStructPtr ; $70d5
	inc hl ; $70d8
	ld d, [hl] ; $70d9
	inc hl ; $70da
	inc hl ; $70db
	ld e, [hl] ; $70dc
	ld a, e ; $70dd
	cp $07 ; $70de
	jr nc, .ge07 ; $70e0
	ld a, $07 ; $70e2
	sub e ; $70e4
	srl a ; $70e5
	ld e, a ; $70e7
	ld a, d ; $70e8
	sub e ; $70e9
	and $1f ; $70ea
	ld d, a ; $70ec
	ld e, $07 ; $70ed
.ge07:
	ld hl, $dc40 ; $70ef
	ld c, $20 ; $70f2
	xor a ; $70f4
.loop:
	ld [hl+], a ; $70f5
	dec c ; $70f6
	jr nz, .loop ; $70f7
	ld hl, $dc40 ; $70f9
	ld a, d ; $70fc
	and $1f ; $70fd
	ld d, a ; $70ff
	add l ; $7100
	ld l, a ; $7101
	jr nc, .gotPtr ; $7102
	inc h ; $7104
.gotPtr:
	ld a, $01 ; $7105
.loopB:
	ld [hl+], a ; $7107
	inc d ; $7108
	bit 5, d ; $7109
	jr z, .bit5Clear ; $710b
	res 5, d ; $710d
	ld hl, $dc40 ; $710f
.bit5Clear:
	dec e ; $7112
	jr nz, .loopB ; $7113
	pop hl ; $7115
	pop de ; $7116
	pop bc ; $7117
	pop af ; $7118
	ret ; $7119
FlushDirtyRowsPerFrame:
	push af ; $711a
	push bc ; $711b
	push de ; $711c
	push hl ; $711d
	call BuildDirtyRowRuns ; $711e
	set_flag FLAG_VRAM_UPDATE_BUSY ; $7121
	ld hl, $dc60 ; $7124
.loop:
	ld a, [hl] ; $7127
	cp $ff ; $7128
	jr z, .eqff ; $712a
	ld c, [hl] ; $712c
	inc hl ; $712d
	ld b, [hl] ; $712e
	inc hl ; $712f
	call CopyDirtyRowSpanToVRAM ; $7130
	push af ; $7133
	ldh a, [rLCDC] ; $7134
	bit 7, a ; $7136
	jr z, .restore ; $7138
	call AdvanceFrame ; $713a
.restore:
	pop af ; $713d
	jr .loop ; $713e
.eqff:
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7140
	pop hl ; $7143
	pop de ; $7144
	pop bc ; $7145
	pop af ; $7146
	ret ; $7147
FlushDirtyRowsNow:
	push af ; $7148
	push bc ; $7149
	push de ; $714a
	push hl ; $714b
	call BuildDirtyRowRuns ; $714c
	set_flag FLAG_VRAM_UPDATE_BUSY ; $714f
	ld hl, $dc60 ; $7152
.loop:
	ld a, [hl] ; $7155
	cp $ff ; $7156
	jr z, .eqff ; $7158
	ld c, [hl] ; $715a
	inc hl ; $715b
	ld b, [hl] ; $715c
	inc hl ; $715d
	call CopyDirtyRowSpanToVRAM ; $715e
	jr .loop ; $7161
.eqff:
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7163
	push af ; $7166
	ldh a, [rLCDC] ; $7167
	bit 7, a ; $7169
	jr z, .restore ; $716b
	call AdvanceFrame ; $716d
.restore:
	pop af ; $7170
	pop hl ; $7171
	pop de ; $7172
	pop bc ; $7173
	pop af ; $7174
	ret ; $7175
CopyDirtyRowSpanToVRAM:
	push af ; $7176
	push bc ; $7177
	push de ; $7178
	push hl ; $7179
	ld l, c ; $717a
	ld h, $00 ; $717b
	add hl, hl ; $717d
	add hl, hl ; $717e
	add hl, hl ; $717f
	add hl, hl ; $7180
	add hl, hl ; $7181
	ld d, h ; $7182
	ld e, l ; $7183
	ld hl, wShadowTilemapPtr ; $7184
	ld a, [hl+] ; $7187
	ld h, [hl] ; $7188
	ld l, a ; $7189
	add hl, de ; $718a
	push hl ; $718b
	ld hl, $9800 ; $718c
	add hl, de ; $718f
	ld d, h ; $7190
	ld e, l ; $7191
	pop hl ; $7192
	ld c, b ; $7193
	sla c ; $7194
	ld a, [wShadowTilemapBank] ; $7196
	ld b, a ; $7199
	ldh a, [hWramBank] ; $719a
	push af ; $719c
	ld a, b ; $719d
	wram_bank ; $719e
	push hl ; $71a2
	push de ; $71a3
	push bc ; $71a4
	call QueueVRAMCopy ; $71a5
	pop bc ; $71a8
	pop de ; $71a9
	ld hl, $2000 ; $71aa
	add hl, de ; $71ad
	ld d, h ; $71ae
	ld e, l ; $71af
	pop hl ; $71b0
	push de ; $71b1
	ld de, $0400 ; $71b2
	add hl, de ; $71b5
	pop de ; $71b6
	call QueueVRAMCopy ; $71b7
	pop af ; $71ba
	wram_bank ; $71bb
	pop hl ; $71bf
	pop de ; $71c0
	pop bc ; $71c1
	pop af ; $71c2
	ret ; $71c3
BuildDirtyRowRuns:
	ld c, $00 ; $71c4
	ld hl, $dc40 ; $71c6
	ld de, $dc60 ; $71c9
.loop:
	ld a, c ; $71cc
	cp $20 ; $71cd
	jr nc, .ge20 ; $71cf
	ld a, [hl] ; $71d1
	or a ; $71d2
	jr nz, .nonZero ; $71d3
	inc hl ; $71d5
	inc c ; $71d6
	jr .loop ; $71d7
.nonZero:
	push hl ; $71d9
	ld h, d ; $71da
	ld l, e ; $71db
	ld [hl], c ; $71dc
	inc hl ; $71dd
	ld d, h ; $71de
	ld e, l ; $71df
	pop hl ; $71e0
	ld b, $00 ; $71e1
.loopB:
	ld a, c ; $71e3
	cp $20 ; $71e4
	jr nc, .step2 ; $71e6
	ld a, [hl] ; $71e8
	or a ; $71e9
	jr z, .step2 ; $71ea
	inc hl ; $71ec
	inc c ; $71ed
	inc b ; $71ee
	ld a, b ; $71ef
	cp $07 ; $71f0
	jr nc, .step2 ; $71f2
	jr .loopB ; $71f4
.step2:
	push hl ; $71f6
	ld h, d ; $71f7
	ld l, e ; $71f8
	ld [hl], b ; $71f9
	inc hl ; $71fa
	ld d, h ; $71fb
	ld e, l ; $71fc
	pop hl ; $71fd
	jr .loop ; $71fe
.ge20:
	ld h, d ; $7200
	ld l, e ; $7201
	ld [hl], $ff ; $7202
	ret ; $7204
RedrawWindowRows:
	push af ; $7205
	push bc ; $7206
	push de ; $7207
	push hl ; $7208
	call MarkWindowRowsDirty ; $7209
	call FlushDirtyRowsPerFrame ; $720c
	pop hl ; $720f
	pop de ; $7210
	pop bc ; $7211
	pop af ; $7212
	ret ; $7213
RedrawWindowRowsPadded:
	push af ; $7214
	push bc ; $7215
	push de ; $7216
	push hl ; $7217
	call MarkWindowRowsDirtyMin7 ; $7218
	call FlushDirtyRowsNow ; $721b
	pop hl ; $721e
	pop de ; $721f
	pop bc ; $7220
	pop af ; $7221
	ret ; $7222
RedrawTilemapRowRange:
	push af ; $7223
	push bc ; $7224
	push de ; $7225
	push hl ; $7226
	call MarkTilemapRowsDirty ; $7227
	call FlushDirtyRowsPerFrame ; $722a
	pop hl ; $722d
	pop de ; $722e
	pop bc ; $722f
	pop af ; $7230
	ret ; $7231
RenderMenuWindowText:
	push af ; $7232
	push bc ; $7233
	push de ; $7234
	push hl ; $7235
	ld a, [wMenuWindowId] ; $7236
	or a ; $7239
	jr nz, .draw ; $723a
	call PrepareGlyphBuffer ; $723c
.draw:
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $723f
	ld a, [wMenuWindowId] ; $7242
	call DrawTextWindowFrame ; $7245
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $7248
	farcall GetWindowStructPtr ; $724b
	ld b, h ; $724e
	ld c, l ; $724f
	ld d, [hl] ; $7250
	inc hl ; $7251
	ld e, [hl] ; $7252
	ld hl, $0006 ; $7253
	add hl, bc ; $7256
	ld a, [hl+] ; $7257
	ld h, [hl] ; $7258
	ld l, a ; $7259
	push hl ; $725a
	inc d ; $725b
	inc d ; $725c
	ld a, d ; $725d
RenderTextAtWindowCell:
	and $1f ; $725e
	ld d, a ; $7260
	inc e ; $7261
	ld a, e ; $7262
	and $1f ; $7263
	ld e, a ; $7265
	ld h, $00 ; $7266
	ld l, e ; $7268
	add hl, hl ; $7269
	add hl, hl ; $726a
	add hl, hl ; $726b
	add hl, hl ; $726c
	add hl, hl ; $726d
	ld a, d ; $726e
	add l ; $726f
	ld l, a ; $7270
	jr nc, .gotPtr ; $7271
	inc h ; $7273
.gotPtr:
	ld d, h ; $7274
	ld e, l ; $7275
	ld hl, wShadowTilemapPtr ; $7276
	ld a, [hl+] ; $7279
	ld h, [hl] ; $727a
	ld l, a ; $727b
	add hl, de ; $727c
	ld d, h ; $727d
	ld e, l ; $727e
	pop hl ; $727f
	ldh a, [hWramBank] ; $7280
	push af ; $7282
	wram_bank $05 ; $7283
	ld a, [wMenuWindowId] ; $7289
	ld c, a ; $728c
	ld a, [wShadowTilemapBank] ; $728d
	ld a, a ; $7290
	wram_bank ; $7291
	push de ; $7295
	push hl ; $7296
	ld a, c ; $7297
	call GetWindowStructPtr ; $7298
	ld a, $02 ; $729b
	add l ; $729d
	ld l, a ; $729e
	jr nc, .read ; $729f
	inc h ; $72a1
.read:
	ld c, [hl] ; $72a2
	dec c ; $72a3
	dec c ; $72a4
	pop hl ; $72a5
	pop de ; $72a6
	call RenderProportionalTextAt ; $72a7
	call UploadGlyphBuffer ; $72aa
	pop af ; $72ad
	wram_bank ; $72ae
	ld a, [wMenuWindowId] ; $72b2
	call RedrawWindowRows ; $72b5
	pop hl ; $72b8
	pop de ; $72b9
	pop bc ; $72ba
	pop af ; $72bb
	ret ; $72bc
CloseWindow:
	push af ; $72bd
	push bc ; $72be
	push de ; $72bf
	push hl ; $72c0
	call RestoreTilemapUnderWindow ; $72c1
	call RedrawWindowRows ; $72c4
	call ResetWindowState ; $72c7
	call FreeWindow ; $72ca
	pop hl ; $72cd
	pop de ; $72ce
	pop bc ; $72cf
	pop af ; $72d0
	ret ; $72d1
RedrawAllTilemapRows:
	push de ; $72d2
	ld d, $00 ; $72d3
	ld e, $20 ; $72d5
	call RedrawTilemapRowRange ; $72d7
	pop de ; $72da
	ret ; $72db
PrepareGlyphBuffer:
	push af ; $72dc
	push bc ; $72dd
	push de ; $72de
	push hl ; $72df
	ldh a, [hWramBank] ; $72e0
	push af ; $72e2
	wram_bank $05 ; $72e3
	ld a, [$d822] ; $72e9
	or a ; $72ec
	jr nz, .keepBuffer ; $72ed
	wram_bank $07 ; $72ef
	call ClearGlyphBuffer ; $72f5
	call ResetGlyphStream ; $72f8
	jr .done ; $72fb
.keepBuffer:
	ld a, [wGlyphRowStartCol] ; $72fd
	ld [wGlyphFlushedCol], a ; $7300
.done:
	pop af ; $7303
	wram_bank ; $7304
	pop hl ; $7308
	pop de ; $7309
	pop bc ; $730a
	pop af ; $730b
	ret ; $730c
ResetGlyphStream:
	push af ; $730d
	push hl ; $730e
	xor a ; $730f
	ld hl, wGlyphPenX ; $7310
	ld [hl+], a ; $7313
	ld [hl+], a ; $7314
	ld [hl+], a ; $7315
	ld [hl+], a ; $7316
	ld [hl+], a ; $7317
	ld [hl+], a ; $7318
	ld [hl+], a ; $7319
	ld [hl+], a ; $731a
	ld [hl], a ; $731b
	ld [$cb75], a ; $731c
	pop hl ; $731f
	pop af ; $7320
	ret ; $7321
DrawGlyph:
	push af ; $7322
	push bc ; $7323
	push hl ; $7324
	sub $20 ; $7325
	push af ; $7327
	ld h, $00 ; $7328
	ld l, a ; $732a
	add hl, hl ; $732b
	add hl, hl ; $732c
	add hl, hl ; $732d
	add hl, hl ; $732e
	ld bc, FontGlyphs ; $732f
	add hl, bc ; $7332
	push de ; $7333
	ld c, $10 ; $7334
.rowLoop:
	ld a, [hl+] ; $7336
	call PlotGlyphRow ; $7337
	ld a, $08 ; $733a
	add e ; $733c
	ld e, a ; $733d
	jr nc, .nextRow ; $733e
	inc d ; $7340
.nextRow:
	dec c ; $7341
	jr nz, .rowLoop ; $7342
	pop de ; $7344
	pop af ; $7345
	call GetGlyphWidthByIndex ; $7346
	ld a, e ; $7349
	and $07 ; $734a
	add c ; $734c
	ld b, a ; $734d
	bit 3, a ; $734e
	jr z, .alignPen ; $7350
	ld a, $80 ; $7352
	add e ; $7354
	ld e, a ; $7355
	jr nc, .alignPen ; $7356
	inc d ; $7358
.alignPen:
	ld a, b ; $7359
	and $07 ; $735a
	ld b, a ; $735c
	ld a, e ; $735d
	and $f8 ; $735e
	or b ; $7360
	ld e, a ; $7361
	pop hl ; $7362
	pop bc ; $7363
	pop af ; $7364
	ret ; $7365
GetGlyphWidth:
	push af ; $7366
	push hl ; $7367
	sub $20 ; $7368
	call GetGlyphWidthByIndex ; $736a
	pop hl ; $736d
	pop af ; $736e
	ret ; $736f
GetGlyphWidthByIndex:
	ld hl, GlyphWidths_05 ; $7370
	add l ; $7373
	ld l, a ; $7374
	jr nc, .read ; $7375
	inc h ; $7377
.read:
	ld c, [hl] ; $7378
	ret ; $7379
PlotGlyphRow:
	push bc ; $737a
	push de ; $737b
	push hl ; $737c
	ld b, a ; $737d
	ld a, e ; $737e
	and $07 ; $737f
	ld c, a ; $7381
	push de ; $7382
	ld de, rIE ; $7383
	push bc ; $7386
	or a ; $7387
	ld a, b ; $7388
	jr z, .restore ; $7389
.loop:
	srl a ; $738b
	srl e ; $738d
	dec c ; $738f
	jr nz, .loop ; $7390
.restore:
	pop bc ; $7392
	ld h, a ; $7393
	ld a, $08 ; $7394
	sub c ; $7396
	ld c, a ; $7397
	or a ; $7398
	ld a, b ; $7399
	jr z, .zero ; $739a
.loopB:
	sla a ; $739c
	sla d ; $739e
	dec c ; $73a0
	jr nz, .loopB ; $73a1
.zero:
	ld c, a ; $73a3
	ld b, h ; $73a4
	ld h, d ; $73a5
	ld l, e ; $73a6
	pop de ; $73a7
	push hl ; $73a8
	sra d ; $73a9
	rr e ; $73ab
	sra d ; $73ad
	rr e ; $73af
	sra d ; $73b1
	rr e ; $73b3
	ld hl, $d300 ; $73b5
	add hl, de ; $73b8
	pop de ; $73b9
	ld a, [hl] ; $73ba
	and d ; $73bb
	or b ; $73bc
	ld [hl+], a ; $73bd
	ld b, e ; $73be
	ld de, $000f ; $73bf
	add hl, de ; $73c2
	ld a, [hl] ; $73c3
	and b ; $73c4
	or c ; $73c5
	ld [hl], a ; $73c6
	pop hl ; $73c7
	pop de ; $73c8
	pop bc ; $73c9
	ret ; $73ca
ClearGlyphBuffer:
	push af ; $73cb
	push bc ; $73cc
	push de ; $73cd
	push hl ; $73ce
	ld de, $d300 ; $73cf
	ld b, $80 ; $73d2
.glyphLoop:
	ld hl, FontGlyphs ; $73d4
	ld c, $01 ; $73d7
	call CopyMemoryFast ; $73d9
	dec b ; $73dc
	jr nz, .glyphLoop ; $73dd
	pop hl ; $73df
	pop de ; $73e0
	pop bc ; $73e1
	pop af ; $73e2
	ret ; $73e3
ClearWindowGlyphTiles:
	push af ; $73e4
	push bc ; $73e5
	push de ; $73e6
	push hl ; $73e7
	wram_bank $05 ; $73e8
	ld a, [wGlyphWindowId] ; $73ee
	farcall GetWindowStructPtr ; $73f1
	inc hl ; $73f4
	inc hl ; $73f5
	ld a, [hl+] ; $73f6
	dec a ; $73f7
	dec a ; $73f8
	ld b, [hl] ; $73f9
	dec b ; $73fa
	dec b ; $73fb
	sra b ; $73fc
	inc b ; $73fe
	ld l, b ; $73ff
	ld h, $00 ; $7400
	call MulHLByA ; $7402
	ld b, l ; $7405
	ld de, $d300 ; $7406
	ld a, [wGlyphRowStartCol] ; $7409
	ld l, a ; $740c
	ld h, $00 ; $740d
	add hl, hl ; $740f
	add hl, hl ; $7410
	add hl, hl ; $7411
	add hl, hl ; $7412
	add hl, de ; $7413
	ld d, h ; $7414
	ld e, l ; $7415
	wram_bank $07 ; $7416
.loop:
	ld hl, FontGlyphs ; $741c
	ld c, $01 ; $741f
	call CopyMemoryFast ; $7421
	dec b ; $7424
	jr nz, .loop ; $7425
	pop hl ; $7427
	pop de ; $7428
	pop bc ; $7429
	pop af ; $742a
	ret ; $742b
UploadGlyphBufferFull:
	push af ; $742c
	push bc ; $742d
	push de ; $742e
	push hl ; $742f
	ldh a, [hWramBank] ; $7430
	push af ; $7432
	set_flag FLAG_VRAM_UPDATE_BUSY ; $7433
	push af ; $7436
	ldh a, [rLCDC] ; $7437
	bit 7, a ; $7439
	jr z, .lcdSettled ; $743b
	call AdvanceFrame ; $743d
.lcdSettled:
	pop af ; $7440
	ld hl, $8c00 ; $7441
	wram_bank $05 ; $7444
	ld a, [wWindowTileAttr] ; $744a
	bit 3, a ; $744d
	jr z, .pushPageDests ; $744f
	ld hl, $8c00 + VRAM_BANK1 ; $7451
.pushPageDests:
	push hl ; $7454
	ld de, $ff00 ; $7455
	add hl, de ; $7458
	push hl ; $7459
	add hl, de ; $745a
	push hl ; $745b
	add hl, de ; $745c
	push hl ; $745d
	add hl, de ; $745e
	ld d, h ; $745f
	ld e, l ; $7460
	wram_bank $07 ; $7461
	ld hl, $d300 ; $7467
	ld c, $10 ; $746a
	call QueueVRAMCopy ; $746c
	push af ; $746f
	ldh a, [rLCDC] ; $7470
	bit 7, a ; $7472
	jr z, .page2 ; $7474
	call AdvanceFrame ; $7476
.page2:
	pop af ; $7479
	ld hl, $d400 ; $747a
	pop de ; $747d
	ld c, $10 ; $747e
	call QueueVRAMCopy ; $7480
	push af ; $7483
	ldh a, [rLCDC] ; $7484
	bit 7, a ; $7486
	jr z, .page3 ; $7488
	call AdvanceFrame ; $748a
.page3:
	pop af ; $748d
	ld hl, $d500 ; $748e
	pop de ; $7491
	ld c, $10 ; $7492
	call QueueVRAMCopy ; $7494
	push af ; $7497
	ldh a, [rLCDC] ; $7498
	bit 7, a ; $749a
	jr z, .page4 ; $749c
	call AdvanceFrame ; $749e
.page4:
	pop af ; $74a1
	ld hl, $d600 ; $74a2
	pop de ; $74a5
	ld c, $10 ; $74a6
	call QueueVRAMCopy ; $74a8
	push af ; $74ab
	ldh a, [rLCDC] ; $74ac
	bit 7, a ; $74ae
	jr z, .page5 ; $74b0
	call AdvanceFrame ; $74b2
.page5:
	pop af ; $74b5
	ld c, $10 ; $74b6
	test_flag FLAG_DEBUG_SHORT_GLYPH_UPLOAD ; $74b8
	jr z, .uploadPage5 ; $74bb
	ld c, $07 ; $74bd
.uploadPage5:
	ld hl, $d700 ; $74bf
	pop de ; $74c2
	call QueueVRAMCopy ; $74c3
	push af ; $74c6
	ldh a, [rLCDC] ; $74c7
	bit 7, a ; $74c9
	jr z, .done ; $74cb
	call AdvanceFrame ; $74cd
.done:
	pop af ; $74d0
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $74d1
	pop af ; $74d4
	wram_bank ; $74d5
	pop hl ; $74d9
	pop de ; $74da
	pop bc ; $74db
	pop af ; $74dc
	ret ; $74dd
DrawWindowGlyphRun:
	push af ; $74de
	push bc ; $74df
	push de ; $74e0
	push hl ; $74e1
	ldh a, [hWramBank] ; $74e2
	push af ; $74e4
	push hl ; $74e5
	wram_bank $05 ; $74e6
	ld a, [wGlyphWindowId] ; $74ec
	farcall GetWindowStructPtr ; $74ef
	inc hl ; $74f2
	inc hl ; $74f3
	ld b, [hl] ; $74f4
	dec b ; $74f5
	dec b ; $74f6
	ld c, b ; $74f7
	pop hl ; $74f8
	wram_bank $07 ; $74f9
	call ClearGlyphBuffer ; $74ff
	ld de, $0000 ; $7502
.glyphLoop:
	ld a, [hl+] ; $7505
	cp $02 ; $7506
	jr z, .done ; $7508
	cp $03 ; $750a
	jr z, .done ; $750c
	cp $01 ; $750e
	jr nz, .drawGlyph ; $7510
	ld e, $00 ; $7512
	ld d, c ; $7514
	sra d ; $7515
	rr e ; $7517
	ld a, c ; $7519
	add b ; $751a
	ld c, a ; $751b
	jr .glyphLoop ; $751c
.drawGlyph:
	call DrawGlyph ; $751e
	jr .glyphLoop ; $7521
.done:
	pop af ; $7523
	wram_bank ; $7524
	pop hl ; $7528
	pop de ; $7529
	pop bc ; $752a
	pop af ; $752b
	ret ; $752c
InitGlyphStreamForWindow:
	push af ; $752d
	push bc ; $752e
	push de ; $752f
	push hl ; $7530
	ldh a, [hWramBank] ; $7531
	push af ; $7533
	wram_bank $05 ; $7534
	ld de, $0000 ; $753a
	ld a, [wGlyphWindowId] ; $753d
	or a ; $7540
	jr z, .zero ; $7541
	ld a, [wGlyphRowStartCol] ; $7543
	ld d, a ; $7546
	ld e, $00 ; $7547
	sra d ; $7549
	rr e ; $754b
.zero:
	ld hl, wGlyphPenX ; $754d
	ld [hl], e ; $7550
	inc hl ; $7551
	ld [hl], d ; $7552
	ld a, [wGlyphWindowId] ; $7553
	farcall GetWindowStructPtr ; $7556
	inc hl ; $7559
	inc hl ; $755a
	ld a, [hl] ; $755b
	dec a ; $755c
	dec a ; $755d
	ld d, a ; $755e
	ld e, a ; $755f
	ld a, [wGlyphWindowId] ; $7560
	or a ; $7563
	jr z, .zero2 ; $7564
	ld a, [wGlyphRowStartCol] ; $7566
	add e ; $7569
	ld e, a ; $756a
.zero2:
	ld hl, $c3b9 ; $756b
	ld [hl], d ; $756e
	inc hl ; $756f
	ld [hl], e ; $7570
	call ClearWindowGlyphTiles ; $7571
	pop af ; $7574
	wram_bank ; $7575
	pop hl ; $7579
	pop de ; $757a
	pop bc ; $757b
	pop af ; $757c
	ret ; $757d
DrawStreamGlyph:
	push af ; $757e
	push bc ; $757f
	push de ; $7580
	push hl ; $7581
	ldh a, [hWramBank] ; $7582
	push af ; $7584
	wram_bank $05 ; $7585
	ld hl, $c3b9 ; $758b
	ld b, [hl] ; $758e
	inc hl ; $758f
	ld c, [hl] ; $7590
	ld hl, wGlyphPenX ; $7591
	ld a, [hl+] ; $7594
	ld d, [hl] ; $7595
	ld e, a ; $7596
	ld hl, wTextStreamPtr ; $7597
	ld a, [hl+] ; $759a
	ld h, [hl] ; $759b
	ld l, a ; $759c
	ld a, [hl+] ; $759d
	cp $02 ; $759e
	jr z, .step2 ; $75a0
	cp $03 ; $75a2
	jr z, .step2 ; $75a4
	cp $01 ; $75a6
	jr nz, .ne01 ; $75a8
	ld e, $00 ; $75aa
	ld d, c ; $75ac
	sra d ; $75ad
	rr e ; $75af
	ld a, c ; $75b1
	add b ; $75b2
	ld [$c3ba], a ; $75b3
	jr .step2 ; $75b6
.ne01:
	push af ; $75b8
	wram_bank $07 ; $75b9
	pop af ; $75bf
	call DrawGlyph ; $75c0
.step2:
	ld hl, wGlyphPenX ; $75c3
	ld a, e ; $75c6
	ld [hl+], a ; $75c7
	ld [hl], d ; $75c8
	sla e ; $75c9
	rl d ; $75cb
	ld a, d ; $75cd
	ld [wGlyphRowStartCol], a ; $75ce
	pop af ; $75d1
	wram_bank ; $75d2
	pop hl ; $75d6
	pop de ; $75d7
	pop bc ; $75d8
	pop af ; $75d9
	ret ; $75da
StartGlyphStreamRow:
	push af ; $75db
	push bc ; $75dc
	push de ; $75dd
	push hl ; $75de
	ld hl, $c3b9 ; $75df
	ld b, [hl] ; $75e2
	inc hl ; $75e3
	ld c, [hl] ; $75e4
	ld e, $00 ; $75e5
	ld d, c ; $75e7
	sra d ; $75e8
	rr e ; $75ea
	ld a, c ; $75ec
	add b ; $75ed
	ld [$c3ba], a ; $75ee
	ld hl, wGlyphPenX ; $75f1
	ld a, e ; $75f4
	ld [hl+], a ; $75f5
	ld [hl], d ; $75f6
	sla e ; $75f7
	rl d ; $75f9
	ld a, d ; $75fb
	ld [wGlyphRowStartCol], a ; $75fc
	ld [wGlyphFlushedCol], a ; $75ff
	pop hl ; $7602
	pop de ; $7603
	pop bc ; $7604
	pop af ; $7605
	ret ; $7606
UploadLastGlyphTiles:
	push af ; $7607
	push bc ; $7608
	push de ; $7609
	push hl ; $760a
	ld a, [wGlyphWindowId] ; $760b
	ld b, a ; $760e
	ld a, [wWindowId] ; $760f
	cp b ; $7612
	jr nz, .restore ; $7613
	ld b, a ; $7615
	ld a, [wDialogueWindowId] ; $7616
	cp b ; $7619
	jr z, .checkMessageSpeed ; $761a
	pop hl ; $761c
	pop de ; $761d
	pop bc ; $761e
	pop af ; $761f
	ret ; $7620
.checkMessageSpeed:
	ld a, [wMessageSpeed] ; $7621
	bit 7, a ; $7624
	jr nz, .restore ; $7626
	and $7f ; $7628
	jr nz, .maskSet ; $762a
.restore:
	pop hl ; $762c
	pop de ; $762d
	pop bc ; $762e
	pop af ; $762f
	ret ; $7630
.maskSet:
	ldh a, [hWramBank] ; $7631
	push af ; $7633
	wram_bank $07 ; $7634
	ld a, [wKeepMatchStatsFlag] ; $763a
	or a ; $763d
	jr z, .zero ; $763e
	ld b, $5f ; $7640
	jr .step3 ; $7642
.zero:
	ld b, $7f ; $7644
.step3:
	ld a, [wGlyphRowStartCol] ; $7646
	cp b ; $7649
	jr nc, .restore2 ; $764a
	ld hl, wGlyphPenX ; $764c
	ld a, [hl+] ; $764f
	ld h, [hl] ; $7650
	ld l, a ; $7651
	rl l ; $7652
	ld l, h ; $7654
	rl l ; $7655
	ld h, $00 ; $7657
	rl h ; $7659
	ld a, h ; $765b
	or l ; $765c
	jr z, .offset ; $765d
	dec hl ; $765f
.offset:
	add hl, hl ; $7660
	add hl, hl ; $7661
	add hl, hl ; $7662
	add hl, hl ; $7663
	ld d, h ; $7664
	ld e, l ; $7665
	ld bc, $d300 ; $7666
	add hl, bc ; $7669
	push hl ; $766a
	ld hl, $8800 ; $766b
	add hl, de ; $766e
	ld d, h ; $766f
	ld e, l ; $7670
	pop hl ; $7671
	ld c, $02 ; $7672
	call QueueVRAMCopy ; $7674
.restore2:
	pop af ; $7677
	wram_bank ; $7678
	pop hl ; $767c
	pop de ; $767d
	pop bc ; $767e
	pop af ; $767f
	ret ; $7680
DrawInlineGlyph:
	push af ; $7681
	push bc ; $7682
	push de ; $7683
	push hl ; $7684
	ldh a, [hWramBank] ; $7685
	push af ; $7687
	push hl ; $7688
	ld hl, $c3b9 ; $7689
	ld b, [hl] ; $768c
	inc hl ; $768d
	ld c, [hl] ; $768e
	ld hl, wGlyphPenX ; $768f
	ld a, [hl+] ; $7692
	ld d, [hl] ; $7693
	ld e, a ; $7694
	pop hl ; $7695
	ld a, [hl+] ; $7696
	cp $02 ; $7697
	jr z, .step3 ; $7699
	cp $03 ; $769b
	jr z, .step3 ; $769d
	cp $01 ; $769f
	jr z, .eq01 ; $76a1
	jr .drawGlyph ; $76a3
.eq01:
	ld e, $00 ; $76a5
	ld d, c ; $76a7
	sra d ; $76a8
	rr e ; $76aa
	ld a, c ; $76ac
	add b ; $76ad
	ld [$c3ba], a ; $76ae
	ld [wGlyphRowStartCol], a ; $76b1
	jr .step3 ; $76b4
.drawGlyph:
	push af ; $76b6
	wram_bank $07 ; $76b7
	pop af ; $76bd
	call DrawGlyph ; $76be
.step3:
	ld hl, wGlyphPenX ; $76c1
	ld a, e ; $76c4
	ld [hl+], a ; $76c5
	ld [hl], d ; $76c6
	pop af ; $76c7
	wram_bank ; $76c8
	pop hl ; $76cc
	pop de ; $76cd
	pop bc ; $76ce
	pop af ; $76cf
	ret ; $76d0
	push af ; $76d1
	push bc ; $76d2
	push de ; $76d3
	push hl ; $76d4
	ldh a, [hWramBank] ; $76d5
	push af ; $76d7
	xor a ; $76d8
	ld hl, wGlyphPenX ; $76d9
	ld [hl+], a ; $76dc
	ld [hl+], a ; $76dd
	ld [hl+], a ; $76de
	ld [hl+], a ; $76df
	ld [hl+], a ; $76e0
	ld [hl], a ; $76e1
	wram_bank $07 ; $76e2
	call ClearGlyphBuffer ; $76e8
	pop af ; $76eb
	wram_bank ; $76ec
	pop hl ; $76f0
	pop de ; $76f1
	pop bc ; $76f2
	pop af ; $76f3
	ret ; $76f4
	push af ; $76f5
	push bc ; $76f6
	push de ; $76f7
	push hl ; $76f8
	ldh a, [hWramBank] ; $76f9
	push af ; $76fb
	xor a ; $76fc
	ld hl, wGlyphPenX ; $76fd
	ld [hl+], a ; $7700
	ld [hl+], a ; $7701
	ld [hl+], a ; $7702
	ld [hl+], a ; $7703
	ld a, $00 ; $7704
	ld [hl+], a ; $7706
	ld [hl+], a ; $7707
	wram_bank $07 ; $7708
	call ClearGlyphBuffer ; $770e
	pop af ; $7711
	wram_bank ; $7712
	pop hl ; $7716
	pop de ; $7717
	pop bc ; $7718
	pop af ; $7719
	ret ; $771a
InitGlyphStreamAt:
	push af ; $771b
	push bc ; $771c
	push de ; $771d
	push hl ; $771e
	ldh a, [hWramBank] ; $771f
	push af ; $7721
	wram_bank $05 ; $7722
	xor a ; $7728
	ld hl, wGlyphPenX ; $7729
	ld [hl+], a ; $772c
	ld [hl+], a ; $772d
	ld [hl+], a ; $772e
	inc hl ; $772f
	inc hl ; $7730
	inc hl ; $7731
	ld [hl+], a ; $7732
	ld [hl+], a ; $7733
	ld [hl], a ; $7734
	ld [$cb75], a ; $7735
	ld a, [$c3ba] ; $7738
	ld d, a ; $773b
	ld e, c ; $773c
	ld a, [wMenuWindowId] ; $773d
	ld b, a ; $7740
	ld a, [wWindowId] ; $7741
	cp b ; $7744
	jr nz, .step ; $7745
	test_flag FLAG_TEMP_WIDE_GLYPH_STREAM ; $7747
	jr nz, .step ; $774a
	inc d ; $774c
	ld e, c ; $774d
	inc c ; $774e
.step:
	ld b, e ; $774f
	ld e, $00 ; $7750
	ld hl, wGlyphRowStartCol ; $7752
	ld [hl], d ; $7755
	inc hl ; $7756
	ld [hl], d ; $7757
	sra d ; $7758
	rr e ; $775a
	ld hl, wGlyphPenX ; $775c
	ld [hl], e ; $775f
	inc hl ; $7760
	ld [hl], d ; $7761
	ld hl, $c3b9 ; $7762
	ld [hl], b ; $7765
	inc hl ; $7766
	ld a, [hl] ; $7767
	add c ; $7768
	ld [hl], a ; $7769
	pop af ; $776a
	wram_bank ; $776b
	pop hl ; $776f
	pop de ; $7770
	pop bc ; $7771
	pop af ; $7772
	ret ; $7773
SaveGlyphPenColumns:
	push af ; $7774
	push bc ; $7775
	push hl ; $7776
	ld a, [wWindowId] ; $7777
	ld b, a ; $777a
	ld a, [wMenuWindowId] ; $777b
	cp b ; $777e
	jr z, .restore ; $777f
	ld hl, wGlyphRowStartCol ; $7781
	ld a, [hl+] ; $7784
	ld b, [hl] ; $7785
	ld c, a ; $7786
	sub b ; $7787
	inc hl ; $7788
	ld [hl+], a ; $7789
	ld [hl], b ; $778a
	dec hl ; $778b
	dec hl ; $778c
	ld [hl], c ; $778d
.restore:
	pop hl ; $778e
	pop bc ; $778f
	pop af ; $7790
	ret ; $7791
UploadGlyphBuffer:
	push af ; $7792
	ldh a, [rLCDC] ; $7793
	bit 7, a ; $7795
	jr z, .lcdOff ; $7797
	call UploadGlyphBufferQueued ; $7799
	jr .done ; $779c
.lcdOff:
	call UploadGlyphBufferDMA ; $779e
.done:
	pop af ; $77a1
	ret ; $77a2
FlushGlyphRow:
	push af ; $77a3
	push bc ; $77a4
	ld a, [wGlyphWindowId] ; $77a5
	ld b, a ; $77a8
	ld a, [wDialogueWindowId] ; $77a9
	cp b ; $77ac
	jr nz, .uploadGlyphBufferQueued ; $77ad
	ld a, [wMessageSpeed] ; $77af
	bit 7, a ; $77b2
	jr nz, .uploadGlyphBufferQueued ; $77b4
	and $7f ; $77b6
	jr nz, .step2 ; $77b8
.uploadGlyphBufferQueued:
	ldh a, [rLCDC] ; $77ba
	bit 7, a ; $77bc
	jr z, .uploadGlyphBufferDMA ; $77be
	call UploadGlyphBufferQueued ; $77c0
	jr .step2 ; $77c3
.uploadGlyphBufferDMA:
	call UploadGlyphBufferDMA ; $77c5
.step2:
	ld hl, $c3b9 ; $77c8
	ld b, [hl] ; $77cb
	inc hl ; $77cc
	ld c, [hl] ; $77cd
	ld a, [wGlyphRowStartCol] ; $77ce
	ld [wGlyphFlushedCol], a ; $77d1
	ld a, c ; $77d4
	add b ; $77d5
	ld [hl], a ; $77d6
	ld [wGlyphRowStartCol], a ; $77d7
	pop bc ; $77da
	pop af ; $77db
	ret ; $77dc
UploadGlyphBufferQueued:
	push af ; $77dd
	push bc ; $77de
	push de ; $77df
	push hl ; $77e0
	ldh a, [hWramBank] ; $77e1
	push af ; $77e3
	set_flag FLAG_VRAM_UPDATE_BUSY ; $77e4
	wram_bank $07 ; $77e7
	ld a, [wKeepMatchStatsFlag] ; $77ed
	or a ; $77f0
	jr z, .zero ; $77f1
	ld b, $60 ; $77f3
	jr .step2 ; $77f5
.zero:
	ld b, $80 ; $77f7
.step2:
	ld a, [wGlyphRowStartCol] ; $77f9
	inc a ; $77fc
	cp b ; $77fd
	jr c, .countLeft ; $77fe
	ld a, b ; $7800
.countLeft:
	ld b, $00 ; $7801
.loop:
	inc b ; $7803
	sub $12 ; $7804
	jr c, .carry ; $7806
	jr .loop ; $7808
.carry:
	push bc ; $780a
	ld hl, $0000 ; $780b
	ld b, h ; $780e
	ld c, l ; $780f
	ld de, $8800 ; $7810
	add hl, de ; $7813
	ldh a, [hWramBank] ; $7814
	push af ; $7816
	wram_bank $05 ; $7817
	ld a, [wWindowTileAttr] ; $781d
	bit 3, a ; $7820
	jr z, .restore ; $7822
	ld de, $2000 ; $7824
	add hl, de ; $7827
.restore:
	pop af ; $7828
	wram_bank ; $7829
	push hl ; $782d
	ld h, b ; $782e
	ld l, c ; $782f
	ld de, $d300 ; $7830
	add hl, de ; $7833
	pop de ; $7834
	pop bc ; $7835
	ld c, $12 ; $7836
.loopB:
	push bc ; $7838
	push hl ; $7839
	push de ; $783a
	call QueueVRAMCopy ; $783b
	ld bc, $0120 ; $783e
	pop hl ; $7841
	add hl, bc ; $7842
	ld d, h ; $7843
	ld e, l ; $7844
	pop hl ; $7845
	add hl, bc ; $7846
	pop bc ; $7847
	ld a, [wLinkSessionActive] ; $7848
	or a ; $784b
	jr nz, .stepMatchFrame ; $784c
	call AdvanceFrame ; $784e
	jr .next ; $7851
.stepMatchFrame:
	farcall StepMatchFrame ; $7853
.next:
	dec b ; $7856
	jr nz, .loopB ; $7857
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $7859
	pop af ; $785c
	wram_bank ; $785d
	pop hl ; $7861
	pop de ; $7862
	pop bc ; $7863
	pop af ; $7864
	ret ; $7865
UploadGlyphBufferDMA:
	push af ; $7866
	push bc ; $7867
	push de ; $7868
	push hl ; $7869
	ldh a, [hWramBank] ; $786a
	push af ; $786c
	ld a, [wGlyphRowStartCol] ; $786d
	inc a ; $7870
	ld b, a ; $7871
	wram_bank $07 ; $7872
	ld a, b ; $7878
	ld b, $00 ; $7879
.loop:
	inc b ; $787b
	sub $20 ; $787c
	jr z, .step ; $787e
	jr c, .step ; $7880
	jr .loop ; $7882
.step:
	ld hl, $d300 ; $7884
	ld de, $8800 ; $7887
	ld c, $20 ; $788a
.loopB:
	push bc ; $788c
	push hl ; $788d
	push de ; $788e
	ld a, $00 ; $788f
	ldh [rVBK], a ; $7891
	call StartVRAMDMAFromHL ; $7893
	ld bc, $0200 ; $7896
	pop hl ; $7899
	add hl, bc ; $789a
	ld d, h ; $789b
	ld e, l ; $789c
	pop hl ; $789d
	add hl, bc ; $789e
	pop bc ; $789f
	dec b ; $78a0
	jr nz, .loopB ; $78a1
	pop af ; $78a3
	wram_bank ; $78a4
	pop hl ; $78a8
	pop de ; $78a9
	pop bc ; $78aa
	pop af ; $78ab
	ret ; $78ac
UploadGlyphTileRange:
	push bc ; $78ad
	push de ; $78ae
	push hl ; $78af
	ldh a, [hWramBank] ; $78b0
	push af ; $78b2
	wram_bank $07 ; $78b3
	ld a, [$c3be] ; $78b9
	ld l, a ; $78bc
	ld h, $00 ; $78bd
	add hl, hl ; $78bf
	add hl, hl ; $78c0
	add hl, hl ; $78c1
	add hl, hl ; $78c2
	ld b, h ; $78c3
	ld c, l ; $78c4
	ld de, $8800 ; $78c5
	add hl, de ; $78c8
	ld a, [$c3bf] ; $78c9
	or a ; $78cc
	jr z, .zero ; $78cd
	ld de, $2000 ; $78cf
	add hl, de ; $78d2
.zero:
	push hl ; $78d3
	ld h, b ; $78d4
	ld l, c ; $78d5
	ld de, $d300 ; $78d6
	add hl, de ; $78d9
	pop de ; $78da
	ld a, [$c3bd] ; $78db
	cp $20 ; $78de
	jr c, .lt20 ; $78e0
	ld a, $20 ; $78e2
.lt20:
	ld c, a ; $78e4
	call QueueVRAMCopy ; $78e5
	ld b, a ; $78e8
	pop af ; $78e9
	wram_bank ; $78ea
	ld a, b ; $78ee
	pop hl ; $78ef
	pop de ; $78f0
	pop bc ; $78f1
	ret ; $78f2
	push af ; $78f3
	push bc ; $78f4
	push de ; $78f5
	push hl ; $78f6
	ld a, d ; $78f7
	and $0f ; $78f8
	ld d, a ; $78fa
	sla e ; $78fb
	rl d ; $78fd
	sla e ; $78ff
	rl d ; $7901
	sla e ; $7903
	rl d ; $7905
.loop:
	ld a, [hl+] ; $7907
	cp $00 ; $7908
	jr z, .restore ; $790a
	call DrawGlyph ; $790c
	jr .loop ; $790f
.restore:
	pop hl ; $7911
	pop de ; $7912
	pop bc ; $7913
	pop af ; $7914
	ret ; $7915
	; $7916, 10 bytes (fill)
	ds 10, $00
FontGlyphs:
	INCBIN "data/bank_005/d_7920.bin" ; $7920, 1632 bytes
GlyphWidths_05:
	; $7f80, 96 bytes (bytes:16)
	db $05, $04, $06, $06, $06, $06, $07, $04, $04, $04, $06, $06, $04, $06, $04, $06 ; 0x00
	db $06, $04, $06, $06, $06, $06, $06, $06, $06, $06, $04, $04, $05, $06, $05, $06 ; 0x10
	db $08, $06, $06, $06, $06, $06, $06, $06, $06, $04, $05, $06, $06, $08, $06, $07 ; 0x20
	db $06, $07, $06, $06, $06, $06, $06, $08, $06, $06, $06, $04, $06, $04, $06, $06 ; 0x30
	db $05, $07, $06, $06, $06, $06, $04, $06, $06, $03, $04, $06, $04, $08, $06, $06 ; 0x40
	db $06, $06, $05, $06, $04, $06, $06, $08, $06, $06, $06, $05, $05, $05, $05, $05 ; 0x50
	; $7fe0, 32 bytes fill to bank end (linker-padded)
