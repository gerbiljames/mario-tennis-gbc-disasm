	farptr RunCharacterSelectScreen ; $4000
	farptr RunMatchTypeMenu ; $4002
	farptr RunLinkMatchSequence ; $4004
	farptr RunNameEntryScreen ; $4006
	farptr RunExhibitionCharSelectScreen ; $4008
	farptr UpdateMenuCursorFromLinkInput ; $400a
	farptr RunLinkCharSelectScreen ; $400c
	farptr RunMatchTypeMenuLink ; $400e
	farptr RunLinkMatchSequenceAlias1, RunLinkMatchSequence ; $4010
	farptr ApplySpriteBobOffsetX ; $4012
	farptr ApplySpriteBobOffsetY ; $4014
	farptr IsMarioCastCharacter ; $4016
DrawSelectedOptionBox:
	push de ; $4018
	push bc ; $4019
	ld c, $00 ; $401a
	call ApplySpriteBobOffsetX ; $401c
	ld c, $00 ; $401f
	call ApplySpriteBobOffsetY ; $4021
	ld c, $00 ; $4024
	ld b, $08 ; $4026
	call QueueSprite ; $4028
	pop bc ; $402b
	pop de ; $402c
	push de ; $402d
	push bc ; $402e
	ld a, b ; $402f
	add d ; $4030
	ld d, a ; $4031
	push de ; $4032
	ld c, $01 ; $4033
	call ApplySpriteBobOffsetX ; $4035
	ld c, $00 ; $4038
	call ApplySpriteBobOffsetY ; $403a
	ld c, $00 ; $403d
	ld b, $28 ; $403f
	call QueueSprite ; $4041
	pop de ; $4044
	pop bc ; $4045
	pop de ; $4046
	push de ; $4047
	push bc ; $4048
	ld a, c ; $4049
	add e ; $404a
	ld e, a ; $404b
	ld a, b ; $404c
	add d ; $404d
	ld d, a ; $404e
	push de ; $404f
	ld c, $01 ; $4050
	call ApplySpriteBobOffsetX ; $4052
	ld c, $01 ; $4055
	call ApplySpriteBobOffsetY ; $4057
	ld c, $00 ; $405a
	ld b, $68 ; $405c
	call QueueSprite ; $405e
	pop de ; $4061
	pop bc ; $4062
	pop de ; $4063
	ld a, e ; $4064
	add c ; $4065
	ld e, a ; $4066
	push de ; $4067
	ld c, $00 ; $4068
	call ApplySpriteBobOffsetX ; $406a
	ld c, $01 ; $406d
	call ApplySpriteBobOffsetY ; $406f
	ld c, $00 ; $4072
	ld b, $48 ; $4074
	call QueueSprite ; $4076
	pop de ; $4079
	ret ; $407a
ApplySpriteBobOffsetX:
	ldh a, [hVBlankCounter] ; $407b
	and $0f ; $407d
	ld hl, SpriteBobOffsetXTable ; $407f
	add l ; $4082
	ld l, a ; $4083
	jr nc, .readOffset ; $4084
	inc h ; $4086
.readOffset:
	ld a, [hl] ; $4087
	ld b, a ; $4088
	ld a, c ; $4089
	or a ; $408a
	jr z, .subtract ; $408b
	ld a, b ; $408d
	add d ; $408e
	ld d, a ; $408f
	ret ; $4090
.subtract:
	ld a, d ; $4091
	sub b ; $4092
	ld d, a ; $4093
	ret ; $4094
SpriteBobOffsetXTable:
	; $4095, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySpriteBobOffsetY:
	ldh a, [hVBlankCounter] ; $40a5
	and $0f ; $40a7
	ld hl, SpriteBobOffsetYTable_38 ; $40a9
	add l ; $40ac
	ld l, a ; $40ad
	jr nc, .readOffset ; $40ae
	inc h ; $40b0
.readOffset:
	ld a, [hl] ; $40b1
	ld b, a ; $40b2
	ld a, c ; $40b3
	or a ; $40b4
	jr z, .subtract ; $40b5
	ld a, b ; $40b7
	add e ; $40b8
	ld e, a ; $40b9
	ret ; $40ba
.subtract:
	ld a, e ; $40bb
	sub b ; $40bc
	ld e, a ; $40bd
	ret ; $40be
SpriteBobOffsetYTable_38:
	; $40bf, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to DrawCornerBrackets_1b, DrawCornerBrackets_3b and DrawCornerBrackets_3e (one copy per bank); a change here belongs in every copy.
DrawCornerBrackets_38:
	push de ; $40cf
	push bc ; $40d0
	ld c, $00 ; $40d1
	ld b, $09 ; $40d3
	call QueueSprite ; $40d5
	pop bc ; $40d8
	pop de ; $40d9
	push de ; $40da
	push bc ; $40db
	ld a, b ; $40dc
	add d ; $40dd
	ld d, a ; $40de
	push de ; $40df
	ld c, $00 ; $40e0
	ld b, $29 ; $40e2
	call QueueSprite ; $40e4
	pop de ; $40e7
	pop bc ; $40e8
	pop de ; $40e9
	push de ; $40ea
	push bc ; $40eb
	ld a, c ; $40ec
	add e ; $40ed
	ld e, a ; $40ee
	ld a, b ; $40ef
	add d ; $40f0
	ld d, a ; $40f1
	push de ; $40f2
	ld c, $00 ; $40f3
	ld b, $69 ; $40f5
	call QueueSprite ; $40f7
	pop de ; $40fa
	pop bc ; $40fb
	pop de ; $40fc
	ld a, e ; $40fd
	add c ; $40fe
	ld e, a ; $40ff
	push de ; $4100
	ld c, $00 ; $4101
	ld b, $49 ; $4103
	call QueueSprite ; $4105
	pop de ; $4108
	ret ; $4109
; Instruction-identical to MoveMenuCursorGrid_3b and MoveMenuCursorGrid_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_38:
	ld a, [wMenuCursorX] ; $410a
	ld d, a ; $410d
	ld a, [wMenuCursorY] ; $410e
	ld e, a ; $4111
	ld a, [wMenuInputPressed] ; $4112
	bit PADB_RIGHT, a ; $4115
	jr z, .checkLeft ; $4117
	ld a, [wMenuCursorX] ; $4119
	inc a ; $411c
	add a ; $411d
	jr nc, .wrapRight ; $411e
	ld a, b ; $4120
	dec a ; $4121
	jr .storeRight ; $4122
.wrapRight:
	rra ; $4124
	cp b ; $4125
	jr c, .storeRight ; $4126
	xor a ; $4128
.storeRight:
	ld [wMenuCursorX], a ; $4129
	jr .compare ; $412c
.checkLeft:
	bit 5, a ; $412e
	jr z, .checkUp ; $4130
	ld a, [wMenuCursorX] ; $4132
	dec a ; $4135
	add a ; $4136
	jr nc, .wrapLeft ; $4137
	ld a, b ; $4139
	dec a ; $413a
	jr .storeLeft ; $413b
.wrapLeft:
	rra ; $413d
	cp b ; $413e
	jr c, .storeLeft ; $413f
	xor a ; $4141
.storeLeft:
	ld [wMenuCursorX], a ; $4142
	jr .compare ; $4145
.checkUp:
	bit 6, a ; $4147
	jr z, .checkDown ; $4149
	ld a, [wMenuCursorY] ; $414b
	dec a ; $414e
	add a ; $414f
	jr nc, .wrapUp ; $4150
	ld a, c ; $4152
	dec a ; $4153
	jr .storeUp ; $4154
.wrapUp:
	rra ; $4156
	cp c ; $4157
	jr c, .storeUp ; $4158
	xor a ; $415a
.storeUp:
	ld [wMenuCursorY], a ; $415b
	jr .compare ; $415e
.checkDown:
	bit 7, a ; $4160
	jr z, .compare ; $4162
	ld a, [wMenuCursorY] ; $4164
	inc a ; $4167
	add a ; $4168
	jr nc, .wrapDown ; $4169
	ld a, c ; $416b
	dec a ; $416c
	jr .storeDown ; $416d
.wrapDown:
	rra ; $416f
	cp c ; $4170
	jr c, .storeDown ; $4171
	xor a ; $4173
.storeDown:
	ld [wMenuCursorY], a ; $4174
.compare:
	ld a, [wMenuCursorX] ; $4177
	cp d ; $417a
	jr nz, .moved ; $417b
	ld a, [wMenuCursorY] ; $417d
	cp e ; $4180
	jr nz, .moved ; $4181
	xor a ; $4183
	ret ; $4184
.moved:
	ld a, $01 ; $4185
	ret ; $4187
; Instruction-identical to MoveMenuCursorGridFromLinkInput_16 and MoveMenuCursorGridFromLinkInput_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridFromLinkInput_38:
	ld a, [wMenuCursorX] ; $4188
	ld d, a ; $418b
	ld a, [wMenuCursorY] ; $418c
	ld e, a ; $418f
	ldh a, [hLinkInput] ; $4190
	bit 4, a ; $4192
	jr z, .checkLeft ; $4194
	ld a, [wMenuCursorX] ; $4196
	inc a ; $4199
	add a ; $419a
	jr nc, .wrapRight ; $419b
	ld a, b ; $419d
	dec a ; $419e
	jr .storeRight ; $419f
.wrapRight:
	rra ; $41a1
	cp b ; $41a2
	jr c, .storeRight ; $41a3
	xor a ; $41a5
.storeRight:
	ld [wMenuCursorX], a ; $41a6
	jr .compare ; $41a9
.checkLeft:
	bit 5, a ; $41ab
	jr z, .checkUp ; $41ad
	ld a, [wMenuCursorX] ; $41af
	dec a ; $41b2
	add a ; $41b3
	jr nc, .wrapLeft ; $41b4
	ld a, b ; $41b6
	dec a ; $41b7
	jr .storeLeft ; $41b8
.wrapLeft:
	rra ; $41ba
	cp b ; $41bb
	jr c, .storeLeft ; $41bc
	xor a ; $41be
.storeLeft:
	ld [wMenuCursorX], a ; $41bf
	jr .compare ; $41c2
.checkUp:
	bit 6, a ; $41c4
	jr z, .checkDown ; $41c6
	ld a, [wMenuCursorY] ; $41c8
	dec a ; $41cb
	add a ; $41cc
	jr nc, .wrapUp ; $41cd
	ld a, c ; $41cf
	dec a ; $41d0
	jr .storeUp ; $41d1
.wrapUp:
	rra ; $41d3
	cp c ; $41d4
	jr c, .storeUp ; $41d5
	xor a ; $41d7
.storeUp:
	ld [wMenuCursorY], a ; $41d8
	jr .compare ; $41db
.checkDown:
	bit 7, a ; $41dd
	jr z, .compare ; $41df
	ld a, [wMenuCursorY] ; $41e1
	inc a ; $41e4
	add a ; $41e5
	jr nc, .wrapDown ; $41e6
	ld a, c ; $41e8
	dec a ; $41e9
	jr .storeDown ; $41ea
.wrapDown:
	rra ; $41ec
	cp c ; $41ed
	jr c, .storeDown ; $41ee
	xor a ; $41f0
.storeDown:
	ld [wMenuCursorY], a ; $41f1
.compare:
	ld a, [wMenuCursorX] ; $41f4
	cp d ; $41f7
	jr nz, .moved ; $41f8
	ld a, [wMenuCursorY] ; $41fa
	cp e ; $41fd
	jr nz, .moved ; $41fe
	xor a ; $4200
	ret ; $4201
.moved:
	ld a, $01 ; $4202
	ret ; $4204
; Instruction-identical to MoveMenuCursorGridRemote_16 and MoveMenuCursorGridRemote_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridRemote_38:
	ld a, [wMenuCursorX] ; $4205
	ld d, a ; $4208
	ld a, [wMenuCursorY] ; $4209
	ld e, a ; $420c
	ldh a, [hLinkState] ; $420d
	cp LINKSTATE_SLAVE ; $420f
	jr z, .asSlave ; $4211
	cp LINKSTATE_MASTER ; $4213
	jr z, .asMaster ; $4215
	call LinkErrorReset ; $4217
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $421a
	jr .haveInput ; $421c
.asSlave:
	ldh a, [hLinkRemoteInput] ; $421e
.haveInput:
	ld h, a ; $4220
	ld a, [wMenuCursorLockFlags] ; $4221
	and $01 ; $4224
	ld a, h ; $4226
	jr nz, .checkLock ; $4227
	bit 4, a ; $4229
	jr z, .checkLeft ; $422b
	ld a, [wMenuCursorX] ; $422d
	inc a ; $4230
	add a ; $4231
	jr nc, .wrapRight ; $4232
	ld a, b ; $4234
	dec a ; $4235
	jr .storeRight ; $4236
.wrapRight:
	rra ; $4238
	cp b ; $4239
	jr c, .storeRight ; $423a
	xor a ; $423c
.storeRight:
	ld [wMenuCursorX], a ; $423d
	jr .compare ; $4240
.checkLeft:
	bit 5, a ; $4242
	jr z, .checkUp ; $4244
	ld a, [wMenuCursorX] ; $4246
	dec a ; $4249
	add a ; $424a
	jr nc, .wrapLeft ; $424b
	ld a, b ; $424d
	dec a ; $424e
	jr .storeLeft ; $424f
.wrapLeft:
	rra ; $4251
	cp b ; $4252
	jr c, .storeLeft ; $4253
	xor a ; $4255
.storeLeft:
	ld [wMenuCursorX], a ; $4256
	jr .compare ; $4259
.checkUp:
	bit 6, a ; $425b
	jr z, .checkDown ; $425d
	ld a, [wMenuCursorY] ; $425f
	dec a ; $4262
	add a ; $4263
	jr nc, .wrapUp ; $4264
	ld a, c ; $4266
	dec a ; $4267
	jr .storeUp ; $4268
.wrapUp:
	rra ; $426a
	cp c ; $426b
	jr c, .storeUp ; $426c
	xor a ; $426e
.storeUp:
	ld [wMenuCursorY], a ; $426f
	jr .compare ; $4272
.checkDown:
	bit 7, a ; $4274
	jr z, .checkLock ; $4276
	ld a, [wMenuCursorY] ; $4278
	inc a ; $427b
	add a ; $427c
	jr nc, .wrapDown ; $427d
	ld a, c ; $427f
	dec a ; $4280
	jr .storeDown ; $4281
.wrapDown:
	rra ; $4283
	cp c ; $4284
	jr c, .storeDown ; $4285
	xor a ; $4287
.storeDown:
	ld [wMenuCursorY], a ; $4288
	jr .compare ; $428b
.checkLock:
	bit 0, a ; $428d
	jr z, .checkUnlock ; $428f
	sound SFX_MENU_SELECT ; $4291
	ld a, [wMenuCursorLockFlags] ; $4293
	ld b, a ; $4296
	and $01 ; $4297
	jr nz, .compare ; $4299
	sound SFX_MENU_SELECT ; $429b
	ld a, b ; $429d
	or $01 ; $429e
	ld [wMenuCursorLockFlags], a ; $42a0
	jr .compare ; $42a3
.checkUnlock:
	bit 1, a ; $42a5
	jr z, .compare ; $42a7
	sound SFX_MENU_CANCEL ; $42a9
	ld a, [wMenuCursorLockFlags] ; $42ab
	ld b, a ; $42ae
	and $03 ; $42af
	ld a, b ; $42b1
	jr nz, .clearLock ; $42b2
	and $fa ; $42b4
	or $04 ; $42b6
	jr .storeLock ; $42b8
.clearLock:
	and $fe ; $42ba
.storeLock:
	ld [wMenuCursorLockFlags], a ; $42bc
.compare:
	ld a, [wMenuCursorX] ; $42bf
	cp d ; $42c2
	jr nz, .moved ; $42c3
	ld a, [wMenuCursorY] ; $42c5
	cp e ; $42c8
	jr nz, .moved ; $42c9
	xor a ; $42cb
	ret ; $42cc
.moved:
	ld a, $01 ; $42cd
	ret ; $42cf
MoveMenuCursor2GridRemote_38:
	ld a, [wMenuCursor2X] ; $42d0
	ld d, a ; $42d3
	ld a, [wMenuCursor2Y] ; $42d4
	ld e, a ; $42d7
	ldh a, [hLinkState] ; $42d8
	cp LINKSTATE_SLAVE ; $42da
	jr z, .asSlave ; $42dc
	cp LINKSTATE_MASTER ; $42de
	jr z, .asMaster ; $42e0
	call LinkErrorReset ; $42e2
.asMaster:
	ldh a, [hLinkRemoteInput] ; $42e5
	jr .haveInput2 ; $42e7
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $42e9
.haveInput2:
	ld h, a ; $42eb
	ld a, [wMenuCursorLockFlags] ; $42ec
	and $02 ; $42ef
	ld a, h ; $42f1
	jr nz, .checkLock2 ; $42f2
	bit 4, a ; $42f4
	jr z, .checkLeft2 ; $42f6
	ld a, [wMenuCursor2X] ; $42f8
	inc a ; $42fb
	add a ; $42fc
	jr nc, .wrapRight2 ; $42fd
	ld a, b ; $42ff
	dec a ; $4300
	jr .storeRight2 ; $4301
.wrapRight2:
	rra ; $4303
	cp b ; $4304
	jr c, .storeRight2 ; $4305
	xor a ; $4307
.storeRight2:
	ld [wMenuCursor2X], a ; $4308
	jr .compare2 ; $430b
.checkLeft2:
	bit 5, a ; $430d
	jr z, .checkUp2 ; $430f
	ld a, [wMenuCursor2X] ; $4311
	dec a ; $4314
	add a ; $4315
	jr nc, .wrapLeft2 ; $4316
	ld a, b ; $4318
	dec a ; $4319
	jr .storeLeft2 ; $431a
.wrapLeft2:
	rra ; $431c
	cp b ; $431d
	jr c, .storeLeft2 ; $431e
	xor a ; $4320
.storeLeft2:
	ld [wMenuCursor2X], a ; $4321
	jr .compare2 ; $4324
.checkUp2:
	bit 6, a ; $4326
	jr z, .checkDown2 ; $4328
	ld a, [wMenuCursor2Y] ; $432a
	dec a ; $432d
	add a ; $432e
	jr nc, .wrapUp2 ; $432f
	ld a, c ; $4331
	dec a ; $4332
	jr .storeUp2 ; $4333
.wrapUp2:
	rra ; $4335
	cp c ; $4336
	jr c, .storeUp2 ; $4337
	xor a ; $4339
.storeUp2:
	ld [wMenuCursor2Y], a ; $433a
	jr .compare2 ; $433d
.checkDown2:
	bit 7, a ; $433f
	jr z, .checkLock2 ; $4341
	ld a, [wMenuCursor2Y] ; $4343
	inc a ; $4346
	add a ; $4347
	jr nc, .wrapDown2 ; $4348
	ld a, c ; $434a
	dec a ; $434b
	jr .storeDown2 ; $434c
.wrapDown2:
	rra ; $434e
	cp c ; $434f
	jr c, .storeDown2 ; $4350
	xor a ; $4352
.storeDown2:
	ld [wMenuCursor2Y], a ; $4353
	jr .compare2 ; $4356
.checkLock2:
	bit 0, a ; $4358
	jr z, .checkUnlock2 ; $435a
	ld a, [wMenuCursorLockFlags] ; $435c
	ld b, a ; $435f
	and $02 ; $4360
	jr nz, .compare2 ; $4362
	sound SFX_MENU_SELECT ; $4364
	ld a, b ; $4366
	or $02 ; $4367
	ld [wMenuCursorLockFlags], a ; $4369
	jr .compare2 ; $436c
.checkUnlock2:
	bit 1, a ; $436e
	jr z, .compare2 ; $4370
	sound SFX_MENU_CANCEL ; $4372
	ld a, [wMenuCursorLockFlags] ; $4374
	ld b, a ; $4377
	and $03 ; $4378
	ld a, b ; $437a
	jr nz, .clearLock2 ; $437b
	and $f5 ; $437d
	or $08 ; $437f
	jr .storeLock2 ; $4381
.clearLock2:
	and $fd ; $4383
.storeLock2:
	ld [wMenuCursorLockFlags], a ; $4385
.compare2:
	ld a, [wMenuCursor2X] ; $4388
	cp d ; $438b
	jr nz, .moved2 ; $438c
	ld a, [wMenuCursor2Y] ; $438e
	cp e ; $4391
	jr nz, .moved2 ; $4392
	xor a ; $4394
	ret ; $4395
.moved2:
	ld a, $01 ; $4396
	ret ; $4398
; Instruction-identical to GetMenuCursorIndex_16, GetMenuCursorIndex_1b, GetMenuCursorIndex_3b and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
GetMenuCursorIndex_38:
	ld a, [wMenuCursorY] ; $4399
	ld b, a ; $439c
	xor a ; $439d
	inc b ; $439e
.mulLoop:
	dec b ; $439f
	jr z, .addColumn ; $43a0
	add c ; $43a2
	jr .mulLoop ; $43a3
.addColumn:
	ld b, a ; $43a5
	ld a, [wMenuCursorX] ; $43a6
	add b ; $43a9
	ret ; $43aa
; Instruction-identical to GetMenuCursorIndexFromPtr_1b (one copy per bank); a change here belongs in every copy.
GetMenuCursorIndexFromPtr_38:
	push bc ; $43ab
	ld a, [hl-] ; $43ac
	ld b, a ; $43ad
	xor a ; $43ae
	inc b ; $43af
.mulLoop:
	dec b ; $43b0
	jr z, .addColumn ; $43b1
	add c ; $43b3
	jr .mulLoop ; $43b4
.addColumn:
	ld b, a ; $43b6
	ld a, [hl] ; $43b7
	add b ; $43b8
	pop bc ; $43b9
	ret ; $43ba
; Instruction-identical to SetMenuCursorFromIndex_16, SetMenuCursorFromIndex_3b and SetMenuCursorFromIndex_3e (one copy per bank); a change here belongs in every copy.
SetMenuCursorFromIndex_38:
	ld d, $00 ; $43bb
	ld a, c ; $43bd
.divLoop:
	cp b ; $43be
	jr c, .store ; $43bf
	inc d ; $43c1
	sub b ; $43c2
	jr .divLoop ; $43c3
.store:
	ld [wMenuCursorX], a ; $43c5
	ld a, d ; $43c8
	ld [wMenuCursorY], a ; $43c9
	ret ; $43cc
; Instruction-identical to SetMenuCursorFromIndexToPtr_16 and SetMenuCursorFromIndexToPtr_3e (one copy per bank); a change here belongs in every copy.
SetMenuCursorFromIndexToPtr_38:
	ld d, $00 ; $43cd
	ld a, c ; $43cf
.divLoop:
	cp b ; $43d0
	jr c, .store ; $43d1
	inc d ; $43d3
	sub b ; $43d4
	jr .divLoop ; $43d5
.store:
	ld [hl+], a ; $43d7
	ld a, d ; $43d8
	ld [hl], a ; $43d9
	ret ; $43da
