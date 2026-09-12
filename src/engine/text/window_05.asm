InitTextWindows:
	call ResetTextWindowState ; $4096
	ret ; $4099
FetchShortTextToBuffer:
	push af ; $409a
	push bc ; $409b
	push de ; $409c
	push hl ; $409d
	push_wram_bank WRAM_TEXT ; $409e
	call FetchShortText ; $40a7
	ld hl, wShortTextBuffer ; $40aa
.copyLoop:
	ld a, [hl+] ; $40ad
	ld [de], a ; $40ae
	inc de ; $40af
	cp $00 ; $40b0
	jr nz, .copyLoop ; $40b2
	pop_wram_bank ; $40b4
	pop hl ; $40b9
	pop de ; $40ba
	pop bc ; $40bb
	pop af ; $40bc
	ret ; $40bd
ClearWindowGlyphPage:
	push_wram_bank WRAM_TEXT ; $40be
	ld hl, wWindowShadowTilemap ; $40c7
	ld c, $80 ; $40ca
	call ClearMemory16 ; $40cc
	pop_wram_bank ; $40cf
	ret ; $40d4
QueueGlyphPageDMAOnA:
	ldh a, [hPlayerInputFlags] ; $40d5
	bit PADB_A, a ; $40d7
	jr nz, .startDMA ; $40d9
	jr .done ; $40db
.startDMA:
	xor a ; $40dd
	ldh [rVBK], a ; $40de
	wram_bank WRAM_TEXT ; $40e0
	ld bc, wWindowShadowTilemap ; $40e6
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
	wram_bank WRAM_TEXT ; $40ff
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
Unused_05_ReadShadowMapCell:
	push af ; $4111
	push de ; $4112
	push af ; $4113
	wram_bank WRAM_TEXT ; $4114
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
Unused_05_CopyVisibleTilemapToVRAM:
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
Unused_05_QueueFullTilemapCopy:
	push af ; $41c6
	push bc ; $41c7
	push de ; $41c8
	push hl ; $41c9
	ld a, b ; $41ca
	wram_bank ; $41cb
	ld hl, $d000 ; $41cf
	ld de, vBGMap0 ; $41d2
	ld c, $40 ; $41d5
	call QueueVRAMCopy ; $41d7
	pop hl ; $41da
	pop de ; $41db
	pop bc ; $41dc
	pop af ; $41dd
	ret ; $41de
Unused_05_QueueFullAttrmapCopy:
	push af ; $41df
	push bc ; $41e0
	push de ; $41e1
	push hl ; $41e2
	ld a, b ; $41e3
	wram_bank ; $41e4
	ld hl, $d400 ; $41e8
	ld de, vBGMap0 + VRAM_BANK1 ; $41eb
	ld c, $40 ; $41ee
	call QueueVRAMCopy ; $41f0
	pop hl ; $41f3
	pop de ; $41f4
	pop bc ; $41f5
	pop af ; $41f6
	ret ; $41f7
Unused_05_CopyTilemapRowToVRAM:
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
	ld hl, vBGMap0 + VRAM_BANK1 ; $4229
	add hl, bc ; $422c
	ld d, h ; $422d
	ld e, l ; $422e
	ld hl, $d400 ; $422f
	add hl, bc ; $4232
	ld c, $02 ; $4233
	call QueueVRAMCopy ; $4235
	ret ; $4238
Unused_05_CopyTilemapRowsToVRAM:
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
Unused_05_CopyTilemapRowsAnimated:
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
	call Unused_05_CopyTilemapRowsToVRAM ; $42c7
	pop bc ; $42ca
	ld a, c ; $42cb
	sub b ; $42cc
	ld c, a ; $42cd
.restore:
	pop af ; $42ce
.ge20:
	and $1f ; $42cf
	ld b, $05 ; $42d1
	call Unused_05_CopyTilemapRowsToVRAM ; $42d3
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
	pop_wram_bank ; $433c
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
	pop_wram_bank ; $4365
	pop hl ; $436a
	pop de ; $436b
	pop bc ; $436c
	pop af ; $436d
	ret ; $436e
