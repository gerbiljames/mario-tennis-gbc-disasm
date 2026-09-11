SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc" ; DEF SharedMenuGfx17_SIZE EQU its decoded length, generated from the .bin by make

	farptr ShowCourtDiagramTestScreen ; $4000
DataPtr_CourtDiagramTiles:
	dw CourtDiagramTiles ; $4002
DataPtr_CourtDiagramTilemap:
	dw CourtDiagramTilemap ; $4004
DataPtr_CourtDiagramAttrmap:
	dw CourtDiagramAttrmap ; $4006
DataPtr_CourtDiagramPalettes:
	dw CourtDiagramPalettes ; $4008
	farptr ShowDrillBriefingScreen ; $400a
	farptr ShowRulesScreen ; $400c
DataPtr_RulesScreenTiles:
	dw RulesScreenTiles ; $400e
DataPtr_RulesScreenTilemap:
	dw RulesScreenTilemap ; $4010
DataPtr_RulesScreenAttrmap:
	dw RulesScreenAttrmap ; $4012
DataPtr_RulesScreenPalettes:
	dw RulesScreenPalettes ; $4014
	push de ; $4016
	push bc ; $4017
	ld c, $00 ; $4018
	call ApplySpriteWobbleX_17 ; $401a
	ld c, $00 ; $401d
	call ApplySpriteWobbleY_17 ; $401f
	ld c, $00 ; $4022
	ld b, $08 ; $4024
	call QueueSprite ; $4026
	pop bc ; $4029
	pop de ; $402a
	push de ; $402b
	push bc ; $402c
	ld a, b ; $402d
	add d ; $402e
	ld d, a ; $402f
	push de ; $4030
	ld c, $01 ; $4031
	call ApplySpriteWobbleX_17 ; $4033
	ld c, $00 ; $4036
	call ApplySpriteWobbleY_17 ; $4038
	ld c, $00 ; $403b
	ld b, $28 ; $403d
	call QueueSprite ; $403f
	pop de ; $4042
	pop bc ; $4043
	pop de ; $4044
	push de ; $4045
	push bc ; $4046
	ld a, c ; $4047
	add e ; $4048
	ld e, a ; $4049
	ld a, b ; $404a
	add d ; $404b
	ld d, a ; $404c
	push de ; $404d
	ld c, $01 ; $404e
	call ApplySpriteWobbleX_17 ; $4050
	ld c, $01 ; $4053
	call ApplySpriteWobbleY_17 ; $4055
	ld c, $00 ; $4058
	ld b, $68 ; $405a
	call QueueSprite ; $405c
	pop de ; $405f
	pop bc ; $4060
	pop de ; $4061
	ld a, e ; $4062
	add c ; $4063
	ld e, a ; $4064
	push de ; $4065
	ld c, $00 ; $4066
	call ApplySpriteWobbleX_17 ; $4068
	ld c, $01 ; $406b
	call ApplySpriteWobbleY_17 ; $406d
	ld c, $00 ; $4070
	ld b, $48 ; $4072
	call QueueSprite ; $4074
	pop de ; $4077
	ret ; $4078
; Instruction-identical to ApplySpriteWobbleX_16 (one copy per bank); a change here belongs in every copy.
ApplySpriteWobbleX_17:
	ldh a, [hVBlankCounter] ; $4079
	and $0f ; $407b
	ld hl, SpriteWobbleXTable ; $407d
	add l ; $4080
	ld l, a ; $4081
	jr nc, .readOffset ; $4082
	inc h ; $4084
.readOffset:
	ld a, [hl] ; $4085
	ld b, a ; $4086
	ld a, c ; $4087
	or a ; $4088
	jr z, .subtract ; $4089
	ld a, b ; $408b
	add d ; $408c
	ld d, a ; $408d
	ret ; $408e
.subtract:
	ld a, d ; $408f
	sub b ; $4090
	ld d, a ; $4091
	ret ; $4092
SpriteWobbleXTable:
	; $4093, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to ApplySpriteWobbleY_16 (one copy per bank); a change here belongs in every copy.
ApplySpriteWobbleY_17:
	ldh a, [hVBlankCounter] ; $40a3
	and $0f ; $40a5
	ld hl, SpriteWobbleYTable_17 ; $40a7
	add l ; $40aa
	ld l, a ; $40ab
	jr nc, .readOffset ; $40ac
	inc h ; $40ae
.readOffset:
	ld a, [hl] ; $40af
	ld b, a ; $40b0
	ld a, c ; $40b1
	or a ; $40b2
	jr z, .subtract ; $40b3
	ld a, b ; $40b5
	add e ; $40b6
	ld e, a ; $40b7
	ret ; $40b8
.subtract:
	ld a, e ; $40b9
	sub b ; $40ba
	ld e, a ; $40bb
	ret ; $40bc
SpriteWobbleYTable_17:
	; $40bd, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	push de ; $40cd
	push bc ; $40ce
	ld c, $00 ; $40cf
	ld b, $09 ; $40d1
	call QueueSprite ; $40d3
	pop bc ; $40d6
	pop de ; $40d7
	push de ; $40d8
	push bc ; $40d9
	ld a, b ; $40da
	add d ; $40db
	ld d, a ; $40dc
	push de ; $40dd
	ld c, $00 ; $40de
	ld b, $29 ; $40e0
	call QueueSprite ; $40e2
	pop de ; $40e5
	pop bc ; $40e6
	pop de ; $40e7
	push de ; $40e8
	push bc ; $40e9
	ld a, c ; $40ea
	add e ; $40eb
	ld e, a ; $40ec
	ld a, b ; $40ed
	add d ; $40ee
	ld d, a ; $40ef
	push de ; $40f0
	ld c, $00 ; $40f1
	ld b, $69 ; $40f3
	call QueueSprite ; $40f5
	pop de ; $40f8
	pop bc ; $40f9
	pop de ; $40fa
	ld a, e ; $40fb
	add c ; $40fc
	ld e, a ; $40fd
	push de ; $40fe
	ld c, $00 ; $40ff
	ld b, $49 ; $4101
	call QueueSprite ; $4103
	pop de ; $4106
	ret ; $4107
; Instruction-identical to MoveMenuCursorGrid_1b (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_17:
	ld a, [wMenuCursorX] ; $4108
	ld d, a ; $410b
	ld a, [wMenuCursorY] ; $410c
	ld e, a ; $410f
	ld a, [wMenuInputPressed] ; $4110
	bit PADB_RIGHT, a ; $4113
	jr z, .checkMenuCursorX4 ; $4115
	ld a, [wMenuCursorX] ; $4117
	inc a ; $411a
	add a ; $411b
	jr nc, .noCarry ; $411c
	ld a, b ; $411e
	dec a ; $411f
	jr .store ; $4120
.noCarry:
	rra ; $4122
	cp b ; $4123
	jr c, .store ; $4124
	xor a ; $4126
.store:
	ld [wMenuCursorX], a ; $4127
	jr .checkMenuCursorX ; $412a
.checkMenuCursorX4:
	bit 5, a ; $412c
	jr z, .bit5Clear ; $412e
	ld a, [wMenuCursorX] ; $4130
	dec a ; $4133
	add a ; $4134
	jr nc, .noCarry2 ; $4135
	ld a, b ; $4137
	dec a ; $4138
	jr .store2 ; $4139
.noCarry2:
	rra ; $413b
	cp b ; $413c
	jr c, .store2 ; $413d
	xor a ; $413f
.store2:
	ld [wMenuCursorX], a ; $4140
	jr .checkMenuCursorX ; $4143
.bit5Clear:
	bit 6, a ; $4145
	jr z, .bit6Clear ; $4147
	ld a, [wMenuCursorY] ; $4149
	dec a ; $414c
	add a ; $414d
	jr nc, .noCarry3 ; $414e
	ld a, c ; $4150
	dec a ; $4151
	jr .store3 ; $4152
.noCarry3:
	rra ; $4154
	cp c ; $4155
	jr c, .store3 ; $4156
	xor a ; $4158
.store3:
	ld [wMenuCursorY], a ; $4159
	jr .checkMenuCursorX ; $415c
.bit6Clear:
	bit 7, a ; $415e
	jr z, .checkMenuCursorX ; $4160
	ld a, [wMenuCursorY] ; $4162
	inc a ; $4165
	add a ; $4166
	jr nc, .noCarry4 ; $4167
	ld a, c ; $4169
	dec a ; $416a
	jr .store4 ; $416b
.noCarry4:
	rra ; $416d
	cp c ; $416e
	jr c, .store4 ; $416f
	xor a ; $4171
.store4:
	ld [wMenuCursorY], a ; $4172
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $4175
	cp d ; $4178
	jr nz, .checkMenuCursorX5 ; $4179
	ld a, [wMenuCursorY] ; $417b
	cp e ; $417e
	jr nz, .checkMenuCursorX5 ; $417f
	xor a ; $4181
	ret ; $4182
.checkMenuCursorX5:
	ld a, $01 ; $4183
	ret ; $4185
; Instruction-identical to MoveMenuCursorGridFromLinkInput_1b (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridFromLinkInput_17:
	ld a, [wMenuCursorX] ; $4186
	ld d, a ; $4189
	ld a, [wMenuCursorY] ; $418a
	ld e, a ; $418d
	ldh a, [hLinkInput] ; $418e
	bit 4, a ; $4190
	jr z, .bit4Clear ; $4192
	ld a, [wMenuCursorX] ; $4194
	inc a ; $4197
	add a ; $4198
	jr nc, .noCarry5 ; $4199
	ld a, b ; $419b
	dec a ; $419c
	jr .store5 ; $419d
.noCarry5:
	rra ; $419f
	cp b ; $41a0
	jr c, .store5 ; $41a1
	xor a ; $41a3
.store5:
	ld [wMenuCursorX], a ; $41a4
	jr .checkMenuCursorX2 ; $41a7
.bit4Clear:
	bit 5, a ; $41a9
	jr z, .bit5Clear2 ; $41ab
	ld a, [wMenuCursorX] ; $41ad
	dec a ; $41b0
	add a ; $41b1
	jr nc, .noCarry6 ; $41b2
	ld a, b ; $41b4
	dec a ; $41b5
	jr .store6 ; $41b6
.noCarry6:
	rra ; $41b8
	cp b ; $41b9
	jr c, .store6 ; $41ba
	xor a ; $41bc
.store6:
	ld [wMenuCursorX], a ; $41bd
	jr .checkMenuCursorX2 ; $41c0
.bit5Clear2:
	bit 6, a ; $41c2
	jr z, .bit6Clear2 ; $41c4
	ld a, [wMenuCursorY] ; $41c6
	dec a ; $41c9
	add a ; $41ca
	jr nc, .noCarry7 ; $41cb
	ld a, c ; $41cd
	dec a ; $41ce
	jr .store7 ; $41cf
.noCarry7:
	rra ; $41d1
	cp c ; $41d2
	jr c, .store7 ; $41d3
	xor a ; $41d5
.store7:
	ld [wMenuCursorY], a ; $41d6
	jr .checkMenuCursorX2 ; $41d9
.bit6Clear2:
	bit 7, a ; $41db
	jr z, .checkMenuCursorX2 ; $41dd
	ld a, [wMenuCursorY] ; $41df
	inc a ; $41e2
	add a ; $41e3
	jr nc, .noCarry8 ; $41e4
	ld a, c ; $41e6
	dec a ; $41e7
	jr .store8 ; $41e8
.noCarry8:
	rra ; $41ea
	cp c ; $41eb
	jr c, .store8 ; $41ec
	xor a ; $41ee
.store8:
	ld [wMenuCursorY], a ; $41ef
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $41f2
	cp d ; $41f5
	jr nz, .checkMenuCursorX6 ; $41f6
	ld a, [wMenuCursorY] ; $41f8
	cp e ; $41fb
	jr nz, .checkMenuCursorX6 ; $41fc
	xor a ; $41fe
	ret ; $41ff
.checkMenuCursorX6:
	ld a, $01 ; $4200
	ret ; $4202
MoveMenuCursorGridRemote_17:
	ld a, [wMenuCursorX] ; $4203
	ld d, a ; $4206
	ld a, [wMenuCursorY] ; $4207
	ld e, a ; $420a
	ldh a, [hLinkState] ; $420b
	cp $02 ; $420d
	jr z, .eq02 ; $420f
	cp $01 ; $4211
	jr z, .eq01 ; $4213
	call LinkErrorReset ; $4215
.eq01:
	ldh a, [hLinkRemoteInputBuf] ; $4218
	jr .checkMenuCursorLockFlags ; $421a
.eq02:
	ldh a, [hLinkRemoteInput] ; $421c
.checkMenuCursorLockFlags:
	ld h, a ; $421e
	ld a, [wMenuCursorLockFlags] ; $421f
	and $01 ; $4222
	ld a, h ; $4224
	jr nz, .checkMenuCursorLockFlags4 ; $4225
	bit 4, a ; $4227
	jr z, .bit4Clear2 ; $4229
	ld a, [wMenuCursorX] ; $422b
	inc a ; $422e
	add a ; $422f
	jr nc, .noCarry9 ; $4230
	ld a, b ; $4232
	dec a ; $4233
	jr .store9 ; $4234
.noCarry9:
	rra ; $4236
	cp b ; $4237
	jr c, .store9 ; $4238
	xor a ; $423a
.store9:
	ld [wMenuCursorX], a ; $423b
	jr .checkMenuCursorX3 ; $423e
.bit4Clear2:
	bit 5, a ; $4240
	jr z, .bit5Clear3 ; $4242
	ld a, [wMenuCursorX] ; $4244
	dec a ; $4247
	add a ; $4248
	jr nc, .noCarry10 ; $4249
	ld a, b ; $424b
	dec a ; $424c
	jr .store10 ; $424d
.noCarry10:
	rra ; $424f
	cp b ; $4250
	jr c, .store10 ; $4251
	xor a ; $4253
.store10:
	ld [wMenuCursorX], a ; $4254
	jr .checkMenuCursorX3 ; $4257
.bit5Clear3:
	bit 6, a ; $4259
	jr z, .bit6Clear3 ; $425b
	ld a, [wMenuCursorY] ; $425d
	dec a ; $4260
	add a ; $4261
	jr nc, .noCarry11 ; $4262
	ld a, c ; $4264
	dec a ; $4265
	jr .store11 ; $4266
.noCarry11:
	rra ; $4268
	cp c ; $4269
	jr c, .store11 ; $426a
	xor a ; $426c
.store11:
	ld [wMenuCursorY], a ; $426d
	jr .checkMenuCursorX3 ; $4270
.bit6Clear3:
	bit 7, a ; $4272
	jr z, .checkMenuCursorLockFlags4 ; $4274
	ld a, [wMenuCursorY] ; $4276
	inc a ; $4279
	add a ; $427a
	jr nc, .noCarry12 ; $427b
	ld a, c ; $427d
	dec a ; $427e
	jr .store12 ; $427f
.noCarry12:
	rra ; $4281
	cp c ; $4282
	jr c, .store12 ; $4283
	xor a ; $4285
.store12:
	ld [wMenuCursorY], a ; $4286
	jr .checkMenuCursorX3 ; $4289
.checkMenuCursorLockFlags4:
	bit 0, a ; $428b
	jr z, .bit0Clear ; $428d
	sound SFX_MENU_SELECT ; $428f
	ld a, [wMenuCursorLockFlags] ; $4291
	ld b, a ; $4294
	and $01 ; $4295
	jr nz, .checkMenuCursorX3 ; $4297
	sound SFX_MENU_SELECT ; $4299
	ld a, b ; $429b
	or $01 ; $429c
	ld [wMenuCursorLockFlags], a ; $429e
	jr .checkMenuCursorX3 ; $42a1
.bit0Clear:
	bit 1, a ; $42a3
	jr z, .checkMenuCursorX3 ; $42a5
	sound SFX_MENU_CANCEL ; $42a7
	ld a, [wMenuCursorLockFlags] ; $42a9
	ld b, a ; $42ac
	and $03 ; $42ad
	ld a, b ; $42af
	jr nz, .storeMenuCursorLockFlags ; $42b0
	and $fa ; $42b2
	or $04 ; $42b4
	jr .store13 ; $42b6
.storeMenuCursorLockFlags:
	and $fe ; $42b8
.store13:
	ld [wMenuCursorLockFlags], a ; $42ba
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $42bd
	cp d ; $42c0
	jr nz, .checkMenuCursor2X2 ; $42c1
	ld a, [wMenuCursorY] ; $42c3
	cp e ; $42c6
	jr nz, .checkMenuCursor2X2 ; $42c7
	xor a ; $42c9
	ret ; $42ca
.checkMenuCursor2X2:
	ld a, $01 ; $42cb
	ret ; $42cd
MoveMenuCursor2GridRemote_17:
	ld a, [wMenuCursor2X] ; $42ce
	ld d, a ; $42d1
	ld a, [wMenuCursor2Y] ; $42d2
	ld e, a ; $42d5
	ldh a, [hLinkState] ; $42d6
	cp $02 ; $42d8
	jr z, .eq022 ; $42da
	cp $01 ; $42dc
	jr z, .eq012 ; $42de
	call LinkErrorReset ; $42e0
.eq012:
	ldh a, [hLinkRemoteInput] ; $42e3
	jr .checkMenuCursorLockFlags2 ; $42e5
.eq022:
	ldh a, [hLinkRemoteInputBuf] ; $42e7
.checkMenuCursorLockFlags2:
	ld h, a ; $42e9
	ld a, [wMenuCursorLockFlags] ; $42ea
	and $02 ; $42ed
	ld a, h ; $42ef
	jr nz, .checkMenuCursorLockFlags3 ; $42f0
	bit 4, a ; $42f2
	jr z, .bit4Clear3 ; $42f4
	ld a, [wMenuCursor2X] ; $42f6
	inc a ; $42f9
	add a ; $42fa
	jr nc, .noCarry13 ; $42fb
	ld a, b ; $42fd
	dec a ; $42fe
	jr .store14 ; $42ff
.noCarry13:
	rra ; $4301
	cp b ; $4302
	jr c, .store14 ; $4303
	xor a ; $4305
.store14:
	ld [wMenuCursor2X], a ; $4306
	jr .checkMenuCursor2X ; $4309
.bit4Clear3:
	bit 5, a ; $430b
	jr z, .bit5Clear4 ; $430d
	ld a, [wMenuCursor2X] ; $430f
	dec a ; $4312
	add a ; $4313
	jr nc, .noCarry14 ; $4314
	ld a, b ; $4316
	dec a ; $4317
	jr .store15 ; $4318
.noCarry14:
	rra ; $431a
	cp b ; $431b
	jr c, .store15 ; $431c
	xor a ; $431e
.store15:
	ld [wMenuCursor2X], a ; $431f
	jr .checkMenuCursor2X ; $4322
.bit5Clear4:
	bit 6, a ; $4324
	jr z, .bit6Clear4 ; $4326
	ld a, [wMenuCursor2Y] ; $4328
	dec a ; $432b
	add a ; $432c
	jr nc, .noCarry15 ; $432d
	ld a, c ; $432f
	dec a ; $4330
	jr .store16 ; $4331
.noCarry15:
	rra ; $4333
	cp c ; $4334
	jr c, .store16 ; $4335
	xor a ; $4337
.store16:
	ld [wMenuCursor2Y], a ; $4338
	jr .checkMenuCursor2X ; $433b
.bit6Clear4:
	bit 7, a ; $433d
	jr z, .checkMenuCursorLockFlags3 ; $433f
	ld a, [wMenuCursor2Y] ; $4341
	inc a ; $4344
	add a ; $4345
	jr nc, .noCarry16 ; $4346
	ld a, c ; $4348
	dec a ; $4349
	jr .store17 ; $434a
.noCarry16:
	rra ; $434c
	cp c ; $434d
	jr c, .store17 ; $434e
	xor a ; $4350
.store17:
	ld [wMenuCursor2Y], a ; $4351
	jr .checkMenuCursor2X ; $4354
.checkMenuCursorLockFlags3:
	bit 0, a ; $4356
	jr z, .bit0Clear2 ; $4358
	ld a, [wMenuCursorLockFlags] ; $435a
	ld b, a ; $435d
	and $02 ; $435e
	jr nz, .checkMenuCursor2X ; $4360
	sound SFX_MENU_SELECT ; $4362
	ld a, b ; $4364
	or $02 ; $4365
	ld [wMenuCursorLockFlags], a ; $4367
	jr .checkMenuCursor2X ; $436a
.bit0Clear2:
	bit 1, a ; $436c
	jr z, .checkMenuCursor2X ; $436e
	sound SFX_MENU_CANCEL ; $4370
	ld a, [wMenuCursorLockFlags] ; $4372
	ld b, a ; $4375
	and $03 ; $4376
	ld a, b ; $4378
	jr nz, .storeMenuCursorLockFlags2 ; $4379
	and $f5 ; $437b
	or $08 ; $437d
	jr .store18 ; $437f
.storeMenuCursorLockFlags2:
	and $fd ; $4381
.store18:
	ld [wMenuCursorLockFlags], a ; $4383
.checkMenuCursor2X:
	ld a, [wMenuCursor2X] ; $4386
	cp d ; $4389
	jr nz, .checkMenuCursorY ; $438a
	ld a, [wMenuCursor2Y] ; $438c
	cp e ; $438f
	jr nz, .checkMenuCursorY ; $4390
	xor a ; $4392
	ret ; $4393
.checkMenuCursorY:
	ld a, $01 ; $4394
	ret ; $4396
GetMenuCursorLinearIndex_17:
	ld a, [wMenuCursorY] ; $4397
	ld b, a ; $439a
	xor a ; $439b
	inc b ; $439c
.loop:
	dec b ; $439d
	jr z, .countDone ; $439e
	add c ; $43a0
	jr .loop ; $43a1
.countDone:
	ld b, a ; $43a3
	ld a, [wMenuCursorX] ; $43a4
	add b ; $43a7
	ret ; $43a8
GetMenuCursorLinearIndexFromPtr_17:
	push bc ; $43a9
	ld a, [hl-] ; $43aa
	ld b, a ; $43ab
	xor a ; $43ac
	inc b ; $43ad
.loopB:
	dec b ; $43ae
	jr z, .countDone2 ; $43af
	add c ; $43b1
	jr .loopB ; $43b2
.countDone2:
	ld b, a ; $43b4
	ld a, [hl] ; $43b5
	add b ; $43b6
	pop bc ; $43b7
	ret ; $43b8
; Divides the linear index in c by the row width in b: remainder ->
; wMenuCursorX, quotient -> wMenuCursorY. Twin of
; WriteGridPosFromLinearIndex_17, which writes through hl instead.
;
; No proven caller: the two-instruction prologue was never executed in
; any trace, so only the loop from $43bc was proven and these 3 bytes
; read as data until they were seeded as code.
SetMenuCursorFromLinearIndex_17:
	ld d, $00 ; $43b9
	ld a, c ; $43bb
.loop2:
	cp b ; $43bc
	jr c, .store19 ; $43bd
	inc d ; $43bf
	sub b ; $43c0
	jr .loop2 ; $43c1
.store19:
	ld [wMenuCursorX], a ; $43c3
	ld a, d ; $43c6
	ld [wMenuCursorY], a ; $43c7
	ret ; $43ca
; Same divide as SetMenuCursorFromLinearIndex_17 (c / b), but stores the
; remainder and quotient through the caller's hl rather than into the
; menu cursor. Also had no proven caller.
WriteGridPosFromLinearIndex_17:
	ld d, $00 ; $43cb
	ld a, c ; $43cd
.loop3:
	cp b ; $43ce
	jr c, .store20 ; $43cf
	inc d ; $43d1
	sub b ; $43d2
	jr .loop3 ; $43d3
.store20:
	ld [hl+], a ; $43d5
	ld a, d ; $43d6
	ld [hl], a ; $43d7
	ret ; $43d8
ClearWram3Row64_17:
	push_wram_bank $03 ; $43d9
	xor a ; $43e2
	ld c, $40 ; $43e3
.loop4:
	ld [hl+], a ; $43e5
	dec c ; $43e6
	jr nz, .loop4 ; $43e7
	pop_wram_bank ; $43e9
	ret ; $43ee
ClearWram3Row64Alt_17:
	push_wram_bank $03 ; $43ef
	ld a, $00 ; $43f8
	ld c, $40 ; $43fa
.loop5:
	ld [hl+], a ; $43fc
	dec c ; $43fd
	jr nz, .loop5 ; $43fe
	pop_wram_bank ; $4400
	ret ; $4405
UpdateAnimatedTilesTask_17:
	farcall UpdateAnimatedTiles ; $4406
	ret ; $4409
; Instruction-identical to DrawNameWithDiacritics_1b and DrawNameWithDiacritics_3e (one copy per bank); a change here belongs in every copy.
DrawNameWithDiacritics_17:
	push af ; $440a
	push bc ; $440b
.loop:
	ld a, [hl] ; $440c
	cp $00 ; $440d
	jr z, .restore ; $440f
	ld [de], a ; $4411
	inc hl ; $4412
	ld a, [hl] ; $4413
	cp $de ; $4414
	jr z, .eqde ; $4416
	cp $df ; $4418
	jr nz, .nedf ; $441a
.eqde:
	push hl ; $441c
	push bc ; $441d
	ld h, d ; $441e
	ld l, e ; $441f
	ld bc, $ffe0 ; $4420
	add hl, bc ; $4423
	ld b, a ; $4424
	ld a, [hl] ; $4425
	cp $03 ; $4426
	ld a, b ; $4428
	jr nz, .store ; $4429
	sub $d0 ; $442b
.store:
	ld [hl], a ; $442d
	pop bc ; $442e
	pop hl ; $442f
	inc hl ; $4430
.nedf:
	inc de ; $4431
	ld a, e ; $4432
	and $1f ; $4433
	jr nz, .loop ; $4435
	push hl ; $4437
	ld h, d ; $4438
	ld l, e ; $4439
	add hl, de ; $443a
	ld d, h ; $443b
	ld e, l ; $443c
	pop hl ; $443d
	jr .loop ; $443e
.restore:
	pop bc ; $4440
	pop af ; $4441
	ret ; $4442
; Instruction-identical to DrawDecimalNumber_1b, DrawDecimalNumber_3b and DrawDecimalNumber_3e (one copy per bank); a change here belongs in every copy.
DrawDecimalNumber_17:
	push af ; $4443
	push bc ; $4444
	push hl ; $4445
	add sp, -10 ; $4446
	push bc ; $4448
	push de ; $4449
	ld c, l ; $444a
	ld b, h ; $444b
	ld hl, sp + 4 ; $444c
	ld e, l ; $444e
	ld d, h ; $444f
	ld l, c ; $4450
	ld h, b ; $4451
	ld c, e ; $4452
	ld b, d ; $4453
	call FormatDecimalNumber ; $4454
	ld l, c ; $4457
	ld h, b ; $4458
	pop de ; $4459
	pop bc ; $445a
	call DrawAsciiDigitString_17 ; $445b
	add sp, 10 ; $445e
	pop hl ; $4460
	pop bc ; $4461
	pop af ; $4462
	ret ; $4463
DrawAsciiDigitString_17:
	ld a, [hl+] ; $4464
	and a ; $4465
	jr z, .done ; $4466
	call DrawAsciiDigitChar_17 ; $4468
	jr DrawAsciiDigitString_17 ; $446b
.done:
	ret ; $446d
; Instruction-identical to DrawAsciiDigitChar_16, DrawAsciiDigitChar_1b, DrawAsciiDigitChar_3b and DrawAsciiDigitChar_3e (one copy per bank); a change here belongs in every copy.
DrawAsciiDigitChar_17:
	push hl ; $446e
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $446f
	sub $30 ; $4472
	jr c, .carry ; $4474
	add $30 ; $4476
	ld b, a ; $4478
	wram_bank $03 ; $4479
	ld a, b ; $447f
	ld [de], a ; $4480
	inc de ; $4481
	pop hl ; $4482
	ret ; $4483
.carry:
	inc de ; $4484
	pop hl ; $4485
	ret ; $4486
ShowDrillBriefingScreen:
	xor a ; $4487
	ldh [hBGColumnBlitPending], a ; $4488
	ldh [hBGRowBlitPending], a ; $448a
	ldh [hScrollY], a ; $448c
	ldh [hScrollX], a ; $448e
	ld [wCameraX + 1], a ; $4490
	ld [wCameraY + 1], a ; $4493
	call ClearFrameTasks ; $4496
	call DisableLCDSafely ; $4499
	call LoadCourtDiagramScreen ; $449c
	farcall PrepareGlyphBuffer ; $449f
	call EnableLCD ; $44a2
	xor a ; $44a5
	ld [wAnimatedTileSet], a ; $44a6
	ld a, $01 ; $44a9
	ld hl, UpdateAnimatedTilesTask_17 ; $44ab
	call RegisterFrameTask ; $44ae
	ld a, $03 ; $44b1
	ld [wAnimatedTilePeriod], a ; $44b3
	script_fade_in $10 ; $44b6
	call WaitFadeEnd ; $44bb
	ld a, [wCurrentMinigameStoryMatch + 1] ; $44be
	cp MINIGAME_TENNIS_MACHINE_1 ; $44c1
	jr nc, .done ; $44c3
	sub MINIGAME_SERVICE_PRACTICE_1 ; $44c5
	cp $04 ; $44c7
	jr c, .dispatch ; $44c9
	sub $03 ; $44cb
	cp $06 ; $44cd
	jr c, .dispatch ; $44cf
	sub $03 ; $44d1
.dispatch:
	ld a, a ; $44d3
	rst Rst00 ; $44d4
	dw DrillBriefing_ServeToTargets ; $44d5 jumptable
	dw DrillBriefing_SpinServe ; $44d7 jumptable
	dw DrillBriefing_ServeThroughPoles ; $44d9 jumptable
	dw DrillBriefing_ServeAndVolley ; $44db jumptable
	dw DrillBriefing_ServeAndSmash ; $44dd jumptable
	dw DrillBriefing_ServeAndSmash2 ; $44df jumptable
	dw DrillBriefing_ReturnToTarget ; $44e1 jumptable
	dw DrillBriefing_ReturnLob ; $44e3 jumptable
	dw DrillBriefing_ReturnDownLine ; $44e5 jumptable
.done:
	call ClearFrameTasks ; $44e7
	ret ; $44ea
ShowCourtDiagramTestScreen:
	call DisableLCDSafely ; $44eb
	call LoadCourtDiagramScreen ; $44ee
	call EnableLCD ; $44f1
	xor a ; $44f4
	ld [wAnimatedTileSet], a ; $44f5
	ld a, $01 ; $44f8
	ld hl, UpdateAnimatedTilesTask_17 ; $44fa
	call RegisterFrameTask ; $44fd
	ld a, $03 ; $4500
	ld [wAnimatedTilePeriod], a ; $4502
	script_fade_in $10 ; $4505
	call WaitFadeEnd ; $450a
	ld a, $50 ; $450d
	ld [wBriefingPlayerX], a ; $450f
	ld a, $40 ; $4512
	ld [wBriefingPlayerY], a ; $4514
	ld a, $01 ; $4517
	ld hl, DrawBriefingPlayerSprite ; $4519
	call RegisterFrameTask ; $451c
	ld a, $30 ; $451f
	ld [wBriefingOpponentX], a ; $4521
	ld a, $20 ; $4524
	ld [wBriefingOpponentY], a ; $4526
	ld a, $01 ; $4529
	ld hl, DrawBriefingOpponentSprite ; $452b
	call RegisterFrameTask ; $452e
	ld a, $60 ; $4531
	ld [wBriefingBallX], a ; $4533
	ld a, $30 ; $4536
	ld [wBriefingBallY], a ; $4538
	ld a, $01 ; $453b
	ld hl, DrawBriefingBallSprite ; $453d
	call RegisterFrameTask ; $4540
	ld a, $01 ; $4543
	ld [wBriefingHMarkerUnflipped], a ; $4545
	ld a, $60 ; $4548
	ld [wBriefingHMarkerX], a ; $454a
	ld a, $40 ; $454d
	ld [wBriefingHMarkerY], a ; $454f
	ld a, $01 ; $4552
	ld hl, DrawBriefingMarkerHFlip ; $4554
	call RegisterFrameTask ; $4557
	ld hl, Text_30_228 ; $455a
	call DrawBriefingCaption ; $455d
	call WaitForInputBlinking ; $4560
	call ClearFrameTasks ; $4563
	ld a, $01 ; $4566
	ld hl, UpdateAnimatedTilesTask_17 ; $4568
	call RegisterFrameTask ; $456b
	ld a, $09 ; $456e
	ld [wBriefingSwingFrame], a ; $4570
	ld a, $40 ; $4573
	ld [wBriefingSwingX], a ; $4575
	ld a, $32 ; $4578
	ld [wBriefingSwingY], a ; $457a
	ld a, $01 ; $457d
	ld hl, DrawBriefingSwingAnim ; $457f
	call RegisterFrameTask ; $4582
	ld a, $40 ; $4585
	ld [wBriefingPole1X], a ; $4587
	ld a, $20 ; $458a
	ld [wBriefingPole1Y], a ; $458c
	ld a, $50 ; $458f
	ld [wBriefingPole2X], a ; $4591
	ld a, $20 ; $4594
	ld [wBriefingPole2Y], a ; $4596
	ld a, $01 ; $4599
	ld hl, DrawBriefingPoleSprites ; $459b
	call RegisterFrameTask ; $459e
	ld a, $01 ; $45a1
	ld [wBriefingVMarkerUpright], a ; $45a3
	ld a, $30 ; $45a6
	ld [wBriefingVMarkerX], a ; $45a8
	ld a, $20 ; $45ab
	ld [wBriefingVMarkerY], a ; $45ad
	ld a, $01 ; $45b0
	ld hl, DrawBriefingMarkerVFlip ; $45b2
	call RegisterFrameTask ; $45b5
	ld a, $01 ; $45b8
	ld [wBriefingSpinMarkerUnflipped], a ; $45ba
	ld a, $20 ; $45bd
	ld [wBriefingSpinMarkerX], a ; $45bf
	ld a, $40 ; $45c2
	ld [wBriefingSpinMarkerY], a ; $45c4
	ld a, $01 ; $45c7
	ld hl, DrawSpinServeBriefingMarker ; $45c9
	call RegisterFrameTask ; $45cc
	ld a, $03 ; $45cf
	ld [wBriefingRotMarkerDir], a ; $45d1
	ld a, $10 ; $45d4
	ld [wBriefingRotMarkerX], a ; $45d6
	ld a, $10 ; $45d9
	ld [wBriefingRotMarkerY], a ; $45db
	ld a, $01 ; $45de
	ld hl, DrawBriefingMarkerRotated ; $45e0
	call RegisterFrameTask ; $45e3
	ld a, $18 ; $45e6
	ld [wBriefingBracketWidth], a ; $45e8
	ld a, $08 ; $45eb
	ld [wBriefingBracketHeight], a ; $45ed
	ld a, $20 ; $45f0
	ld [wBriefingBracketX], a ; $45f2
	ld a, $40 ; $45f5
	ld [wBriefingBracketY], a ; $45f7
	ld a, $01 ; $45fa
	ld hl, DrawBriefingTargetBrackets ; $45fc
	call RegisterFrameTask ; $45ff
	ld hl, Text_30_309 ; $4602
	call DrawBriefingCaption ; $4605
	ld b, $02 ; $4608
	call DrawDiagramTargetOverlay ; $460a
	ld a, $01 ; $460d
	ld hl, CycleDiagramTargetPalette ; $460f
	call RegisterFrameTask ; $4612
	call WaitForInputBlinking ; $4615
	call ClearFrameTasks ; $4618
	ld a, $01 ; $461b
	ld hl, UpdateAnimatedTilesTask_17 ; $461d
	call RegisterFrameTask ; $4620
	ld b, $00 ; $4623
	call DrawDiagramTargetOverlay ; $4625
	ld hl, Text_30_228 ; $4628
	call DrawBriefingCaption ; $462b
	ld a, $70 ; $462e
	ld [wBriefingHMarkerX], a ; $4630
	ld a, $20 ; $4633
	ld [wBriefingHMarkerY], a ; $4635
	ld a, $01 ; $4638
	ld hl, DrawBriefingMarkerHFlip ; $463a
	call RegisterFrameTask ; $463d
	ld b, $05 ; $4640
	call DrawDiagramTargetOverlay ; $4642
	ld a, $01 ; $4645
	ld hl, CycleDiagramTargetPalette ; $4647
	call RegisterFrameTask ; $464a
	call WaitForInputBlinking ; $464d
	call ClearFrameTasks ; $4650
	ret ; $4653
DrawBriefingCaption:
	call ClearBriefingCaptionTilemap ; $4654
	farcall PrepareGlyphBuffer ; $4657
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $465a
	ld c, $12 ; $465d
	farcall RenderProportionalTextAt ; $465f
	farcall UploadGlyphBuffer ; $4662
	call QueueCaptionRowToVRAM ; $4665
	call AdvanceFrame ; $4668
	ret ; $466b
DrawDiagramTargetOverlay:
	call RestoreDiagramServiceBoxes ; $466c
	call DrawDiagramTargetPatch ; $466f
	call QueueDiagramServiceBoxesToVRAM ; $4672
	ret ; $4675
CycleDiagramTargetPalette:
	push_wram_bank $03 ; $4676
	ld hl, CycleDiagramTargetPaletteData ; $467f
	ld de, wBriefingTargetPalette ; $4682
	ld bc, $0008 ; $4685
	call CopyMemoryBC ; $4688
	ldh a, [hVBlankCounter] ; $468b
	and $3c ; $468d
	srl a ; $468f
	srl a ; $4691
	add a ; $4693
	jr nc, .noCarry ; $4694
	ld a, $0c ; $4696
	dec a ; $4698
	jr .step2 ; $4699
.noCarry:
	rra ; $469b
	cp $0c ; $469c
	jr c, .step2 ; $469e
	xor a ; $46a0
.step2:
	add a ; $46a1
	ld hl, DiagramTargetPaletteRamp_17 ; $46a2
	add l ; $46a5
	ld l, a ; $46a6
	jr nc, .read ; $46a7
	inc h ; $46a9
.read:
	ld a, [hl+] ; $46aa
	ld d, [hl] ; $46ab
	ld e, a ; $46ac
	ld hl, wBriefingTargetPalette + 4 ; $46ad
	ld [hl], e ; $46b0
	inc hl ; $46b1
	ld [hl], d ; $46b2
	ld hl, wBriefingTargetPalette ; $46b3
	lb de, $02, $01 ; $46b6 palette index, count
	call LoadPaletteShadow ; $46b9
	pop_wram_bank ; $46bc
	ret ; $46c1
Unused_17:
	; $46c2, 8 bytes (bytes:8)
	db $00, $00, $f9, $67, $98, $00, $1f, $03 ; 0x00
DiagramTargetPaletteRamp_17:
	; $46ca, 24 bytes (records:2)
	dw $001f ; record 0
	dw $00df ; record 1
	dw $01ff ; record 2
	dw $02bf ; record 3
	dw $037f ; record 4
	dw $03ff ; record 5
	dw $03ff ; record 6
	dw $039f ; record 7
	dw $02bf ; record 8
	dw $01ff ; record 9
	dw $00df ; record 10
	dw $001f ; record 11
DrawBriefingPlayerSprite:
	push_wram_bank $03 ; $46e2
	ld a, [wBriefingPlayerX] ; $46eb
	ld d, a ; $46ee
	ld a, [wBriefingPlayerY] ; $46ef
	ld e, a ; $46f2
	ld hl, DrawBriefingPlayerSprite_SpriteTemplate ; $46f3
	ld b, $08 ; $46f6
	ld c, $00 ; $46f8
	call QueueSpriteTemplate ; $46fa
	pop_wram_bank ; $46fd
	ret ; $4702
DrawBriefingPlayerSprite_SpriteTemplate:
	; $4703, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingOpponentSprite:
	push_wram_bank $03 ; $470c
	ld a, [wBriefingOpponentX] ; $4715
	ld d, a ; $4718
	ld a, [wBriefingOpponentY] ; $4719
	ld e, a ; $471c
	ld hl, DrawBriefingOpponentSprite_SpriteTemplate ; $471d
	ld b, $08 ; $4720
	ld c, $04 ; $4722
	call QueueSpriteTemplate ; $4724
	pop_wram_bank ; $4727
	ret ; $472c
DrawBriefingOpponentSprite_SpriteTemplate:
	; $472d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingBallSprite:
	push_wram_bank $03 ; $4736
	ld a, [wBriefingBallX] ; $473f
	ld d, a ; $4742
	ld a, [wBriefingBallY] ; $4743
	ld e, a ; $4746
	ld c, $6e ; $4747
	ld b, $09 ; $4749
	call QueueSprite ; $474b
	pop_wram_bank ; $474e
	ret ; $4753
DrawBriefingMarkerHFlip:
	push_wram_bank $03 ; $4754
	ld b, $09 ; $475d
	ld a, [wBriefingHMarkerUnflipped] ; $475f
	cp $01 ; $4762
	jr z, .eq01 ; $4764
	ld b, $29 ; $4766
.eq01:
	ld a, [wBriefingHMarkerX] ; $4768
	ld d, a ; $476b
	ldh a, [hVBlankCounter] ; $476c
	and $10 ; $476e
	jr z, .maskClear ; $4770
	inc d ; $4772
.maskClear:
	ld a, [wBriefingHMarkerY] ; $4773
	ld e, a ; $4776
	ld c, $60 ; $4777
	ld hl, DrawBriefingMarkerHFlip_SpriteTemplate ; $4779
	call QueueSpriteTemplate ; $477c
	pop_wram_bank ; $477f
	ret ; $4784
DrawBriefingMarkerHFlip_SpriteTemplate:
	; $4785, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingSwingAnim:
	push_wram_bank $03 ; $478e
	ld a, [wBriefingSwingFrame] ; $4797
	ld hl, BriefingSwingAnimTable0 ; $479a
	add l ; $479d
	ld l, a ; $479e
	jr nc, .read ; $479f
	inc h ; $47a1
.read:
	ld c, [hl] ; $47a2
	ld hl, BriefingSwingAnimTable1 ; $47a3
	ld a, [wBriefingSwingFrame] ; $47a6
	cp $06 ; $47a9
	jr nc, .ge06 ; $47ab
	ld hl, DrawBriefingSwingAnim_SpriteTemplate ; $47ad
.ge06:
	ld a, [wBriefingSwingX] ; $47b0
	ld d, a ; $47b3
	ld a, [wBriefingSwingY] ; $47b4
	ld e, a ; $47b7
	ld b, $09 ; $47b8
	call QueueSpriteTemplate ; $47ba
	pop_wram_bank ; $47bd
	ret ; $47c2
BriefingSwingAnimTable0:
	; $47c3, 10 bytes (bytes:10)
	db $08, $12, $1c, $36, $40, $4a, $26, $2c, $54, $5a ; 0x00
DrawBriefingSwingAnim_SpriteTemplate:
	; $47cd, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
BriefingSwingAnimTable1:
	; $47e2, 13 bytes (bytes:13)
	db $10, $08, $00, $00, $10, $10, $02, $00, $10, $18, $04, $00, $80 ; 0x00
DrawBriefingPoleSprites:
	push_wram_bank $03 ; $47ef
	ld a, [wBriefingPole1X] ; $47f8
	ld d, a ; $47fb
	ld a, [wBriefingPole1Y] ; $47fc
	ld e, a ; $47ff
	ld c, $6a ; $4800
	ld b, $09 ; $4802
	call QueueSprite ; $4804
	ld a, [wBriefingPole2X] ; $4807
	ld d, a ; $480a
	ld a, [wBriefingPole2Y] ; $480b
	ld e, a ; $480e
	ld c, $6a ; $480f
	ld b, $09 ; $4811
	call QueueSprite ; $4813
	pop_wram_bank ; $4816
	ret ; $481b
DrawBriefingMarkerVFlip:
	push_wram_bank $03 ; $481c
	ld c, $70 ; $4825
	ld b, $09 ; $4827
	ld a, [wBriefingVMarkerUpright] ; $4829
	cp $01 ; $482c
	jr z, .eq01 ; $482e
	ld b, $49 ; $4830
.eq01:
	ld a, [wBriefingVMarkerX] ; $4832
	ld d, a ; $4835
	ld a, [wBriefingVMarkerY] ; $4836
	ld e, a ; $4839
	call QueueSprite ; $483a
	pop_wram_bank ; $483d
	ret ; $4842
DrawSpinServeBriefingMarker:
	push_wram_bank $03 ; $4843
	ld c, $64 ; $484c
	ld b, $09 ; $484e
	ld a, [wBriefingSpinMarkerUnflipped] ; $4850
	cp $01 ; $4853
	jr z, .eq01 ; $4855
	ld b, $29 ; $4857
.eq01:
	ld a, [wBriefingSpinMarkerX] ; $4859
	ld d, a ; $485c
	ld a, [wBriefingSpinMarkerY] ; $485d
	ld e, a ; $4860
	ld hl, DrawSpinServeBriefingMarker_SpriteTemplate ; $4861
	call QueueSpriteTemplate ; $4864
	pop_wram_bank ; $4867
	ret ; $486c
DrawSpinServeBriefingMarker_SpriteTemplate:
	; $486d, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingMarkerRotated:
	push_wram_bank $03 ; $4876
	ld hl, BriefingMarkerRotatedTable ; $487f
	ld a, [wBriefingRotMarkerDir] ; $4882
	add l ; $4885
	ld l, a ; $4886
	jr nc, .read ; $4887
	inc h ; $4889
.read:
	ld b, [hl] ; $488a
	ld c, $68 ; $488b
	ld a, [wBriefingRotMarkerX] ; $488d
	ld d, a ; $4890
	ld a, [wBriefingRotMarkerY] ; $4891
	ld e, a ; $4894
	call QueueSprite ; $4895
	pop_wram_bank ; $4898
	ret ; $489d
BriefingMarkerRotatedTable:
	; $489e, 4 bytes (bytes:4)
	db $49, $09, $29, $69 ; 0x00
DrawBlinkingPrompt:
	push_wram_bank $03 ; $48a2
	ldh a, [hVBlankCounter] ; $48ab
	and $10 ; $48ad
	jr z, .restore ; $48af
	ld c, $72 ; $48b1
	ld b, $09 ; $48b3
	lb de, $50, $8c ; $48b5 x, y
	call QueueSprite ; $48b8
.restore:
	pop_wram_bank ; $48bb
	ret ; $48c0
DrawBriefingTargetBrackets:
	push_wram_bank $03 ; $48c1
	ld a, [wBriefingBracketX] ; $48ca
	ld d, a ; $48cd
	ldh a, [hVBlankCounter] ; $48ce
	and $10 ; $48d0
	jr z, .maskClear ; $48d2
	inc d ; $48d4
.maskClear:
	ld a, [wBriefingBracketY] ; $48d5
	ld e, a ; $48d8
	ldh a, [hVBlankCounter] ; $48d9
	and $10 ; $48db
	jr z, .maskClear2 ; $48dd
	inc e ; $48df
.maskClear2:
	ld c, $6c ; $48e0
	ld b, $0a ; $48e2
	call QueueSprite ; $48e4
	ld a, [wBriefingBracketWidth] ; $48e7
	add $03 ; $48ea
	ld b, a ; $48ec
	ld a, [wBriefingBracketX] ; $48ed
	add b ; $48f0
	ld d, a ; $48f1
	ldh a, [hVBlankCounter] ; $48f2
	and $10 ; $48f4
	jr z, .maskClear3 ; $48f6
	dec d ; $48f8
.maskClear3:
	ld a, [wBriefingBracketY] ; $48f9
	ld e, a ; $48fc
	ldh a, [hVBlankCounter] ; $48fd
	and $10 ; $48ff
	jr z, .maskClear4 ; $4901
	inc e ; $4903
.maskClear4:
	ld c, $6c ; $4904
	ld b, $2a ; $4906
	call QueueSprite ; $4908
	ld a, [wBriefingBracketWidth] ; $490b
	add $03 ; $490e
	ld b, a ; $4910
	ld a, [wBriefingBracketX] ; $4911
	add b ; $4914
	ld d, a ; $4915
	ldh a, [hVBlankCounter] ; $4916
	and $10 ; $4918
	jr z, .maskClear5 ; $491a
	dec d ; $491c
.maskClear5:
	ld a, [wBriefingBracketHeight] ; $491d
	sub $05 ; $4920
	ld b, a ; $4922
	ld a, [wBriefingBracketY] ; $4923
	add b ; $4926
	ld e, a ; $4927
	ldh a, [hVBlankCounter] ; $4928
	and $10 ; $492a
	jr z, .maskClear6 ; $492c
	dec e ; $492e
.maskClear6:
	ld c, $6c ; $492f
	ld b, $6a ; $4931
	call QueueSprite ; $4933
	ld a, [wBriefingBracketX] ; $4936
	ld d, a ; $4939
	ldh a, [hVBlankCounter] ; $493a
	and $10 ; $493c
	jr z, .maskClear7 ; $493e
	inc d ; $4940
.maskClear7:
	ld a, [wBriefingBracketHeight] ; $4941
	sub $05 ; $4944
	ld b, a ; $4946
	ld a, [wBriefingBracketY] ; $4947
	add b ; $494a
	ld e, a ; $494b
	ldh a, [hVBlankCounter] ; $494c
	and $10 ; $494e
	jr z, .maskClear8 ; $4950
	dec e ; $4952
.maskClear8:
	ld c, $6c ; $4953
	ld b, $4a ; $4955
	call QueueSprite ; $4957
	pop_wram_bank ; $495a
	ret ; $495f
LoadCourtDiagramScreen:
	ld c, SCREENASSET_CourtDiagram ; $4960
	farcall LoadScreenAssetRecord ; $4962
	call InitCourtDiagramTextWindow ; $4965
	wram_bank $03 ; $4968
	call DecompressGraphicsList ; $496e
	call LoadCourtDiagramObjPalettes ; $4971
	farcall QueueWram3MapToVRAM ; $4974
	wram_bank $03 ; $4977
	ret ; $497d
WaitForInputBlinking:
	call AdvanceFrame ; $497e
	ldh a, [hInputRisingEdge] ; $4981
	and PADF_A | PADF_B ; $4983
	jr nz, .done ; $4985
	call DrawBlinkingPrompt ; $4987
	jr WaitForInputBlinking ; $498a
.done:
	ret ; $498c
AdvanceFrameCheckInput:
	call AdvanceFrame ; $498d
	ldh a, [hInputRisingEdge] ; $4990
	and PADF_A | PADF_B ; $4992
	jr nz, .done ; $4994
	dec c ; $4996
	jr z, .noPrompt ; $4997
	call DrawBlinkingPrompt ; $4999
.noPrompt:
	ld a, $00 ; $499c
.done:
	ret ; $499e
InitCourtDiagramTextWindow:
	farcall ResetTextWindowState ; $499f
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $49a2
	ld c, SharedMenuGfx17_SIZE / 16 ; $49a4
	ld de, vTiles2 ; $49a6
	farcall LoadCompressedTileBlock ; $49a9
	wram_bank $05 ; $49ac
	ld a, $03 ; $49b2
	ld [wShadowTilemapBank], a ; $49b4
	ld a, $00 ; $49b7
	ld [wWindowTileAttr], a ; $49b9
	ld d, $00 ; $49bc
	ld e, $0b ; $49be
	ld b, $14 ; $49c0
	ld c, $07 ; $49c2
	farcall CreateWindowFromScreenRect ; $49c4
	farcall DrawTextWindowFrame ; $49c7
	farcall RedrawWindowRows ; $49ca
	ret ; $49cd
ClearBriefingCaptionTilemap:
	push af ; $49ce
	push bc ; $49cf
	push de ; $49d0
	push hl ; $49d1
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH ; $49d2
	ld b, $14 ; $49d5
	ld c, $01 ; $49d7
	ld h, $03 ; $49d9
	farcall FillTilemapRect ; $49db
	ld a, $02 ; $49de
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH], a ; $49e0
	ld a, $04 ; $49e3
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH + 19], a ; $49e5
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $49e8
	ld b, $12 ; $49eb
	ld c, $05 ; $49ed
	ld h, $20 ; $49ef
	farcall FillTilemapRect ; $49f1
	pop hl ; $49f4
	pop de ; $49f5
	pop bc ; $49f6
	pop af ; $49f7
	ret ; $49f8
QueueCaptionRowToVRAM:
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH ; $49f9
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH ; $49fc
	ld c, $0c ; $49ff
	call QueueVRAMCopy ; $4a01
	ret ; $4a04
Unused_17_StubRet:
	ret ; $4a05
Unused_17_DrawSecondCaptionRow:
	ld hl, Text_30_309 ; $4a06
	ld de, $d1c1 ; $4a09
	farcall RenderProportionalTextAt ; $4a0c
	ld hl, $d1a0 ; $4a0f
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $4a12
	ld c, $0c ; $4a15
	call QueueVRAMCopy ; $4a17
	ret ; $4a1a
; Queues the two-sprite template at $4a29 through QueueSpriteTemplate at
; screen position de = $2020, with c = $04 (tile base) and b = $09
; (flags; bit 5 would mirror it).
;
; No proven caller, so what it draws is not established -- it sits
; between QueueCaptionRowToVRAM and RestoreDiagramServiceBoxes in the
; court-diagram code. Named for what it does, not what it is for.
QueueSpritePair_17:
	ld c, $04 ; $4a1b
	ld b, $09 ; $4a1d
	ld hl, QueueSpritePair_17_SpriteTemplate ; $4a1f
	lb de, $20, $20 ; $4a22 x, y
	call QueueSpriteTemplate ; $4a25
	ret ; $4a28
QueueSpritePair_17_SpriteTemplate:
	; $4a29, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
RestoreDiagramServiceBoxes:
	push af ; $4a32
	push bc ; $4a33
	push de ; $4a34
	push hl ; $4a35
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 6 ; $4a36
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 7 ; $4a39
	ld c, $06 ; $4a3c
	ld b, $06 ; $4a3e
	farcall CopyTilemapRect ; $4a40
	pop hl ; $4a43
	pop de ; $4a44
	pop bc ; $4a45
	pop af ; $4a46
	ret ; $4a47
QueueDiagramServiceBoxesToVRAM:
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $4a48
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $4a4b
	ld c, $0c ; $4a4e
	call QueueVRAMCopy ; $4a50
	ret ; $4a53
DrawDiagramTargetPatch:
	ld a, b ; $4a54
	or a ; $4a55
	ret z ; $4a56
	dec a ; $4a57
	add a ; $4a58
	ld c, a ; $4a59
	add a ; $4a5a
	add c ; $4a5b
	ld hl, DiagramTargetPatchRecords_17 ; $4a5c
	add l ; $4a5f
	ld l, a ; $4a60
	jr nc, .read ; $4a61
	inc h ; $4a63
.read:
	ld a, [hl+] ; $4a64
	ld b, [hl] ; $4a65
	ld c, a ; $4a66
	inc hl ; $4a67
	ld a, [hl+] ; $4a68
	ld d, [hl] ; $4a69
	ld e, a ; $4a6a
	inc hl ; $4a6b
	push bc ; $4a6c
	ld b, [hl] ; $4a6d
	inc hl ; $4a6e
	ld c, [hl] ; $4a6f
	pop hl ; $4a70
	farcall CopyTilemapRect ; $4a71
	ret ; $4a74
DiagramTargetPatchRecords_17:
	; $4a75, 36 bytes (records:6)
; 6 records x 6 bytes
	dw $d243, $d08a, $0203 ; record 0
	dw $d283, $d0ca, $0203 ; record 1
	dw $d280, $d0c7, $0203 ; record 2
	dw $d240, $d087, $0203 ; record 3
	dw $d2c0, $d067, $0206 ; record 4
	dw $d300, $d0e7, $0206 ; record 5
DecompressGraphicsList:
	ld hl, CourtDiagramGraphicsList ; $4a99
.loop:
	ld a, [hl+] ; $4a9c
	ld b, [hl] ; $4a9d
	dec hl ; $4a9e
	or b ; $4a9f
	jr z, .done ; $4aa0
	push hl ; $4aa2
	push hl ; $4aa3
	inc hl ; $4aa4
	inc hl ; $4aa5
	ld a, [hl+] ; $4aa6
	ld d, [hl] ; $4aa7
	ld e, a ; $4aa8
	pop hl ; $4aa9
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	call DecompressData ; $4aad
	pop hl ; $4ab0
	ld a, $04 ; $4ab1
	add l ; $4ab3
	ld l, a ; $4ab4
	jr nc, .gotPtr ; $4ab5
	inc h ; $4ab7
.gotPtr:
	jr .loop ; $4ab8
.done:
	ret ; $4aba
CourtDiagramGraphicsList:
	; $4abb, 82 bytes (bytes:4)
	db $02, $4f, $00, $80 ; 0x00
	db $3d, $4f, $40, $80 ; 0x04
	db $7c, $4f, $80, $80 ; 0x08
	db $0b, $50, $20, $81 ; 0x0c
	db $9a, $50, $c0, $81 ; 0x10
	db $2d, $51, $60, $82 ; 0x14
	db $8f, $51, $c0, $82 ; 0x18
	db $f1, $51, $60, $83 ; 0x1c
	db $80, $52, $00, $84 ; 0x20
	db $0f, $53, $a0, $84 ; 0x24
	db $a0, $53, $40, $85 ; 0x28
	db $09, $54, $a0, $85 ; 0x2c
	db $6d, $54, $00, $86 ; 0x30
	db $b7, $54, $40, $86 ; 0x34
	db $d8, $54, $80, $86 ; 0x38
	db $ff, $54, $a0, $86 ; 0x3c
	db $11, $55, $c0, $86 ; 0x40
	db $23, $55, $e0, $86 ; 0x44
	db $36, $55, $00, $87 ; 0x48
	db $4e, $55, $20, $87 ; 0x4c
	db $00, $00 ; 0x50
LoadCourtDiagramObjPalettes:
	ld hl, CourtDiagramObjPalettes ; $4b0d
	lb de, $08, $03 ; $4b10 palette index, count
	call LoadPaletteShadow ; $4b13
	ret ; $4b16
CourtDiagramTiles:
	INCBIN "data/bank_017/lz_CourtDiagramTiles.bin" ; $4b17, 590 bytes
CourtDiagramTilemap:
	INCBIN "data/bank_017/lz_CourtDiagramTilemap.bin" ; $4d65, 221 bytes
CourtDiagramAttrmap:
	INCBIN "data/bank_017/lz_CourtDiagramAttrmap.bin" ; $4e42, 128 bytes
CourtDiagramPalettes:
	INCLUDE "data/bank_017/CourtDiagramPalettes.asm" ; $4ec2, 16 bytes (palettes)
CycleDiagramTargetPaletteData:
	INCLUDE "data/bank_017/CycleDiagramTargetPaletteData.asm" ; $4ed2, 48 bytes (palettes)
CourtDiagramGfx0:
	INCBIN "data/bank_017/CourtDiagramGfx0.bin" ; $4f02, 59 bytes
CourtDiagramGfx1:
	INCBIN "data/bank_017/CourtDiagramGfx1.bin" ; $4f3d, 63 bytes
CourtDiagramGfx2:
	INCBIN "data/bank_017/CourtDiagramGfx2.bin" ; $4f7c, 143 bytes
CourtDiagramGfx3:
	INCBIN "data/bank_017/CourtDiagramGfx3.bin" ; $500b, 143 bytes
CourtDiagramGfx4:
	INCBIN "data/bank_017/CourtDiagramGfx4.bin" ; $509a, 147 bytes
CourtDiagramGfx5:
	INCBIN "data/bank_017/CourtDiagramGfx5.bin" ; $512d, 98 bytes
CourtDiagramGfx6:
	INCBIN "data/bank_017/CourtDiagramGfx6.bin" ; $518f, 98 bytes
CourtDiagramGfx7:
	INCBIN "data/bank_017/CourtDiagramGfx7.bin" ; $51f1, 143 bytes
CourtDiagramGfx8:
	INCBIN "data/bank_017/CourtDiagramGfx8.bin" ; $5280, 143 bytes
CourtDiagramGfx9:
	INCBIN "data/bank_017/CourtDiagramGfx9.bin" ; $530f, 145 bytes
CourtDiagramGfx10:
	INCBIN "data/bank_017/CourtDiagramGfx10.bin" ; $53a0, 105 bytes
CourtDiagramGfx11:
	INCBIN "data/bank_017/CourtDiagramGfx11.bin" ; $5409, 100 bytes
CourtDiagramGfx12:
	INCBIN "data/bank_017/CourtDiagramGfx12.bin" ; $546d, 74 bytes
CourtDiagramGfx13:
	INCBIN "data/bank_017/lz_CourtDiagramGfx13.bin" ; $54b7, 33 bytes
CourtDiagramGfx14:
	INCBIN "data/bank_017/CourtDiagramGfx14.bin" ; $54d8, 39 bytes
CourtDiagramGfx15:
	INCBIN "data/bank_017/CourtDiagramGfx15.bin" ; $54ff, 18 bytes
CourtDiagramGfx16:
	INCBIN "data/bank_017/CourtDiagramGfx16.bin" ; $5511, 18 bytes
CourtDiagramGfx17:
	INCBIN "data/bank_017/CourtDiagramGfx17.bin" ; $5523, 19 bytes
CourtDiagramGfx18:
	INCBIN "data/bank_017/CourtDiagramGfx18.bin" ; $5536, 24 bytes
CourtDiagramGfx19:
	INCBIN "data/bank_017/CourtDiagramGfx19.bin" ; $554e, 25 bytes
CourtDiagramObjPalettes:
	INCLUDE "data/bank_017/CourtDiagramObjPalettes.asm" ; $5567, 24 bytes (palettes)
DrillBriefing_ServeToTargets:
	ld a, $03 ; $557f
	ld [wBriefingAnimStep], a ; $5581
	call ServeToTargetsBriefing_AdvanceAnim ; $5584
	ld a, $01 ; $5587
	ld hl, DrawBriefingPlayerSprite ; $5589
	call RegisterFrameTask ; $558c
	ld a, $01 ; $558f
	ld hl, DrawBriefingBallSprite ; $5591
	call RegisterFrameTask ; $5594
	ld a, $01 ; $5597
	ld hl, DrawBriefingMarkerHFlip ; $5599
	call RegisterFrameTask ; $559c
	ld a, $01 ; $559f
	ld hl, DrawBriefingMarkerRotated ; $55a1
	call RegisterFrameTask ; $55a4
	ld a, $01 ; $55a7
	ld hl, CycleDiagramTargetPalette ; $55a9
	call RegisterFrameTask ; $55ac
	ld hl, Text_36_688 ; $55af
	call DrawBriefingCaption ; $55b2
	xor a ; $55b5
	ld [wBriefingAnimTimer], a ; $55b6
	ld [wBriefingAnimStep], a ; $55b9
.loop:
	call ServeToTargetsBriefing_TickAnim ; $55bc
	ld c, $00 ; $55bf
	call AdvanceFrameCheckInput ; $55c1
	and a ; $55c4
	jp z, .loop ; $55c5
	call ClearFrameTasks ; $55c8
	ld a, $01 ; $55cb
	ld hl, UpdateAnimatedTilesTask_17 ; $55cd
	call RegisterFrameTask ; $55d0
	ld a, $03 ; $55d3
	ld [wBriefingAnimStep], a ; $55d5
	call ServeToTargetsBriefing_AdvanceAnim ; $55d8
	ld a, $01 ; $55db
	ld hl, DrawBriefingPlayerSprite ; $55dd
	call RegisterFrameTask ; $55e0
	ld a, $01 ; $55e3
	ld hl, DrawBriefingMarkerHFlip ; $55e5
	call RegisterFrameTask ; $55e8
	ld a, $01 ; $55eb
	ld hl, CycleDiagramTargetPalette ; $55ed
	call RegisterFrameTask ; $55f0
	ld a, $00 ; $55f3
	ld [wBriefingBracketWidth], a ; $55f5
	ld a, $00 ; $55f8
	ld [wBriefingBracketHeight], a ; $55fa
	ld a, $01 ; $55fd
	ld hl, DrawBriefingTargetBrackets ; $55ff
	call RegisterFrameTask ; $5602
	ld hl, Text_36_689 ; $5605
	call DrawBriefingCaption ; $5608
	xor a ; $560b
	ld [wBriefingAnimTimer], a ; $560c
	ld [wBriefingAnimStep], a ; $560f
.loopB:
	call ServeToTargetsBriefing_TickAnim ; $5612
	ld c, $00 ; $5615
	call AdvanceFrameCheckInput ; $5617
	and a ; $561a
	jp z, .loopB ; $561b
	call ClearFrameTasks ; $561e
	ld a, $01 ; $5621
	ld hl, UpdateAnimatedTilesTask_17 ; $5623
	call RegisterFrameTask ; $5626
	ld a, $54 ; $5629
	ld [wBriefingPlayerX], a ; $562b
	ld a, $44 ; $562e
	ld [wBriefingPlayerY], a ; $5630
	ld a, $01 ; $5633
	ld hl, DrawBriefingPlayerSprite ; $5635
	call RegisterFrameTask ; $5638
	ld a, $4e ; $563b
	ld [wBriefingBallX], a ; $563d
	ld a, $38 ; $5640
	ld [wBriefingBallY], a ; $5642
	ld a, $01 ; $5645
	ld hl, DrawBriefingBallSprite ; $5647
	call RegisterFrameTask ; $564a
	ld a, $00 ; $564d
	ld [wBriefingHMarkerUnflipped], a ; $564f
	ld a, $3a ; $5652
	ld [wBriefingHMarkerX], a ; $5654
	ld a, $24 ; $5657
	ld [wBriefingHMarkerY], a ; $5659
	ld a, $01 ; $565c
	ld hl, DrawBriefingMarkerHFlip ; $565e
	call RegisterFrameTask ; $5661
	ld a, $03 ; $5664
	ld [wBriefingRotMarkerDir], a ; $5666
	ld a, $52 ; $5669
	ld [wBriefingRotMarkerX], a ; $566b
	ld a, $40 ; $566e
	ld [wBriefingRotMarkerY], a ; $5670
	ld a, $01 ; $5673
	ld hl, DrawBriefingMarkerRotated ; $5675
	call RegisterFrameTask ; $5678
	ld b, $04 ; $567b
	call DrawDiagramTargetOverlay ; $567d
	ld a, $01 ; $5680
	ld hl, CycleDiagramTargetPalette ; $5682
	call RegisterFrameTask ; $5685
	ld a, $00 ; $5688
	ld [wBriefingBracketWidth], a ; $568a
	ld a, $00 ; $568d
	ld [wBriefingBracketHeight], a ; $568f
	ld a, $40 ; $5692
	ld [wBriefingBracketX], a ; $5694
	ld a, $24 ; $5697
	ld [wBriefingBracketY], a ; $5699
	ld a, $01 ; $569c
	ld hl, DrawBriefingTargetBrackets ; $569e
	call RegisterFrameTask ; $56a1
	ld hl, Text_36_690 ; $56a4
	call DrawBriefingCaption ; $56a7
	call WaitForInputBlinking ; $56aa
	call ClearFrameTasks ; $56ad
	ld a, $01 ; $56b0
	ld hl, UpdateAnimatedTilesTask_17 ; $56b2
	call RegisterFrameTask ; $56b5
	ld a, $03 ; $56b8
	ld [wBriefingAnimStep], a ; $56ba
	call ServeToTargetsBriefing_AdvanceAnim ; $56bd
	ld a, $01 ; $56c0
	ld hl, DrawBriefingPlayerSprite ; $56c2
	call RegisterFrameTask ; $56c5
	ld a, $01 ; $56c8
	ld hl, DrawBriefingBallSprite ; $56ca
	call RegisterFrameTask ; $56cd
	ld a, $01 ; $56d0
	ld hl, DrawBriefingMarkerRotated ; $56d2
	call RegisterFrameTask ; $56d5
	ld a, $01 ; $56d8
	ld hl, CycleDiagramTargetPalette ; $56da
	call RegisterFrameTask ; $56dd
	ld a, $00 ; $56e0
	ld [wBriefingBracketWidth], a ; $56e2
	ld a, $00 ; $56e5
	ld [wBriefingBracketHeight], a ; $56e7
	ld a, $01 ; $56ea
	ld hl, DrawBriefingTargetBrackets ; $56ec
	call RegisterFrameTask ; $56ef
	ld hl, Text_36_691 ; $56f2
	call DrawBriefingCaption ; $56f5
	xor a ; $56f8
	ld [wBriefingAnimTimer], a ; $56f9
	ld [wBriefingAnimStep], a ; $56fc
.loop2:
	call ServeToTargetsBriefing_TickAnim ; $56ff
	ld c, $01 ; $5702
	call AdvanceFrameCheckInput ; $5704
	and a ; $5707
	jp z, .loop2 ; $5708
	call ClearFrameTasks ; $570b
	ret ; $570e
ServeToTargetsBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $570f
	inc a ; $5712
	ld [wBriefingAnimTimer], a ; $5713
	cp $78 ; $5716
	jr nc, ServeToTargetsBriefing_AdvanceAnim ; $5718
	ret ; $571a
ServeToTargetsBriefing_AdvanceAnim:
	xor a ; $571b
	ld [wBriefingAnimTimer], a ; $571c
	ld a, [wBriefingAnimStep] ; $571f
	inc a ; $5722
	and $03 ; $5723
	ld [wBriefingAnimStep], a ; $5725
	sla a ; $5728
	sla a ; $572a
	ld c, a ; $572c
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnimTable ; $572d
	ld a, [hl] ; $5734
	inc hl ; $5735
	inc hl ; $5736
	ld b, [hl] ; $5737
	ld a, a ; $5738
	ld [wBriefingPlayerX], a ; $5739
	ld a, b ; $573c
	ld [wBriefingPlayerY], a ; $573d
	ld a, c ; $5740
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_BracketPosTable ; $5741
	ld a, [hl] ; $5748
	inc hl ; $5749
	inc hl ; $574a
	ld b, [hl] ; $574b
	ld a, a ; $574c
	ld [wBriefingBracketX], a ; $574d
	ld a, b ; $5750
	ld [wBriefingBracketY], a ; $5751
	ld a, c ; $5754
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_BallPosTable ; $5755
	ld a, [hl] ; $575c
	inc hl ; $575d
	inc hl ; $575e
	ld b, [hl] ; $575f
	ld a, a ; $5760
	ld [wBriefingBallX], a ; $5761
	ld a, b ; $5764
	ld [wBriefingBallY], a ; $5765
	ld a, [wBriefingAnimStep] ; $5768
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_HMarkerUnflippedTable ; $576b
	ld a, [hl] ; $5772
	ld [wBriefingHMarkerUnflipped], a ; $5773
	ld a, c ; $5776
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_HMarkerPosTable ; $5777
	ld a, [hl] ; $577e
	inc hl ; $577f
	inc hl ; $5780
	ld b, [hl] ; $5781
	ld a, a ; $5782
	ld [wBriefingHMarkerX], a ; $5783
	ld a, b ; $5786
	ld [wBriefingHMarkerY], a ; $5787
	ld a, [wBriefingAnimStep] ; $578a
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_RotMarkerDirTable ; $578d
	ld a, [hl] ; $5794
	ld [wBriefingRotMarkerDir], a ; $5795
	ld a, c ; $5798
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_RotMarkerPosTable ; $5799
	ld a, [hl] ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld b, [hl] ; $57a3
	ld a, a ; $57a4
	ld [wBriefingRotMarkerX], a ; $57a5
	ld a, b ; $57a8
	ld [wBriefingRotMarkerY], a ; $57a9
	ld a, [wBriefingAnimStep] ; $57ac
	ld_hl_indexed ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable ; $57af
	ld b, [hl] ; $57b6
	call DrawDiagramTargetOverlay ; $57b7
	ret ; $57ba
ServeToTargetsBriefing_AdvanceAnimTable:
	; $57bb, 16 bytes (records:2)
	dw $0054 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0054 ; record 6
	dw $0003 ; record 7
ServeToTargetsBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_BallPosTable.asm" ; $57cb, 16 bytes
ServeToTargetsBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $57db, 4 bytes
ServeToTargetsBriefing_AdvanceAnim_HMarkerPosTable:
	INCLUDE "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_HMarkerPosTable.asm" ; $57df, 16 bytes
ServeToTargetsBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $57ef, 4 bytes
ServeToTargetsBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $57f3, 16 bytes
ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable:
	INCBIN "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_TargetOverlayTable.bin" ; $5803, 4 bytes
ServeToTargetsBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ServeToTargetsBriefing_AdvanceAnim_BracketPosTable.bin" ; $5807, 16 bytes
DrillBriefing_SpinServe:
	ld a, $03 ; $5817
	ld [wBriefingAnimStep], a ; $5819
	call SpinServeBriefing_AdvanceAnim ; $581c
	ld a, $01 ; $581f
	ld hl, DrawBriefingPlayerSprite ; $5821
	call RegisterFrameTask ; $5824
	ld a, $01 ; $5827
	ld hl, DrawBriefingBallSprite ; $5829
	call RegisterFrameTask ; $582c
	ld a, $01 ; $582f
	ld hl, DrawBriefingMarkerHFlip ; $5831
	call RegisterFrameTask ; $5834
	ld a, $01 ; $5837
	ld hl, DrawBriefingMarkerRotated ; $5839
	call RegisterFrameTask ; $583c
	ld a, $01 ; $583f
	ld hl, CycleDiagramTargetPalette ; $5841
	call RegisterFrameTask ; $5844
	ld hl, Text_36_692 ; $5847
	call DrawBriefingCaption ; $584a
	xor a ; $584d
	ld [wBriefingAnimTimer], a ; $584e
	ld [wBriefingAnimStep], a ; $5851
.loop:
	call SpinServeBriefing_TickAnim ; $5854
	ld c, $00 ; $5857
	call AdvanceFrameCheckInput ; $5859
	and a ; $585c
	jp z, .loop ; $585d
	call ClearFrameTasks ; $5860
	ld a, $01 ; $5863
	ld hl, UpdateAnimatedTilesTask_17 ; $5865
	call RegisterFrameTask ; $5868
	ld a, $03 ; $586b
	ld [wBriefingAnimStep], a ; $586d
	call SpinServeBriefing_AdvanceAnim ; $5870
	ld a, $01 ; $5873
	ld hl, DrawBriefingPlayerSprite ; $5875
	call RegisterFrameTask ; $5878
	ld a, $01 ; $587b
	ld hl, DrawBriefingMarkerHFlip ; $587d
	call RegisterFrameTask ; $5880
	ld a, $01 ; $5883
	ld hl, CycleDiagramTargetPalette ; $5885
	call RegisterFrameTask ; $5888
	ld a, $00 ; $588b
	ld [wBriefingBracketWidth], a ; $588d
	ld a, $00 ; $5890
	ld [wBriefingBracketHeight], a ; $5892
	ld a, $01 ; $5895
	ld hl, DrawBriefingTargetBrackets ; $5897
	call RegisterFrameTask ; $589a
	ld hl, Text_36_693 ; $589d
	call DrawBriefingCaption ; $58a0
	xor a ; $58a3
	ld [wBriefingAnimTimer], a ; $58a4
	ld [wBriefingAnimStep], a ; $58a7
.loopB:
	call SpinServeBriefing_TickAnim ; $58aa
	ld c, $00 ; $58ad
	call AdvanceFrameCheckInput ; $58af
	and a ; $58b2
	jp z, .loopB ; $58b3
	call ClearFrameTasks ; $58b6
	ld a, $01 ; $58b9
	ld hl, UpdateAnimatedTilesTask_17 ; $58bb
	call RegisterFrameTask ; $58be
	ld a, $52 ; $58c1
	ld [wBriefingPlayerX], a ; $58c3
	ld a, $44 ; $58c6
	ld [wBriefingPlayerY], a ; $58c8
	ld a, $01 ; $58cb
	ld hl, DrawBriefingPlayerSprite ; $58cd
	call RegisterFrameTask ; $58d0
	ld a, $4e ; $58d3
	ld [wBriefingBallX], a ; $58d5
	ld a, $38 ; $58d8
	ld [wBriefingBallY], a ; $58da
	ld a, $01 ; $58dd
	ld hl, DrawBriefingBallSprite ; $58df
	call RegisterFrameTask ; $58e2
	ld a, $00 ; $58e5
	ld [wBriefingHMarkerUnflipped], a ; $58e7
	ld a, $3a ; $58ea
	ld [wBriefingHMarkerX], a ; $58ec
	ld a, $24 ; $58ef
	ld [wBriefingHMarkerY], a ; $58f1
	ld a, $01 ; $58f4
	ld hl, DrawBriefingMarkerHFlip ; $58f6
	call RegisterFrameTask ; $58f9
	ld a, $03 ; $58fc
	ld [wBriefingRotMarkerDir], a ; $58fe
	ld a, $52 ; $5901
	ld [wBriefingRotMarkerX], a ; $5903
	ld a, $40 ; $5906
	ld [wBriefingRotMarkerY], a ; $5908
	ld a, $01 ; $590b
	ld hl, DrawBriefingMarkerRotated ; $590d
	call RegisterFrameTask ; $5910
	ld b, $04 ; $5913
	call DrawDiagramTargetOverlay ; $5915
	ld a, $01 ; $5918
	ld hl, CycleDiagramTargetPalette ; $591a
	call RegisterFrameTask ; $591d
	ld a, $00 ; $5920
	ld [wBriefingBracketWidth], a ; $5922
	ld a, $00 ; $5925
	ld [wBriefingBracketHeight], a ; $5927
	ld a, $40 ; $592a
	ld [wBriefingBracketX], a ; $592c
	ld a, $24 ; $592f
	ld [wBriefingBracketY], a ; $5931
	ld a, $01 ; $5934
	ld hl, DrawBriefingTargetBrackets ; $5936
	call RegisterFrameTask ; $5939
	ld hl, Text_36_694 ; $593c
	call DrawBriefingCaption ; $593f
	call WaitForInputBlinking ; $5942
	call ClearFrameTasks ; $5945
	ld a, $01 ; $5948
	ld hl, UpdateAnimatedTilesTask_17 ; $594a
	call RegisterFrameTask ; $594d
	ld a, $52 ; $5950
	ld [wBriefingPlayerX], a ; $5952
	ld a, $44 ; $5955
	ld [wBriefingPlayerY], a ; $5957
	ld a, $01 ; $595a
	ld hl, DrawBriefingPlayerSprite ; $595c
	call RegisterFrameTask ; $595f
	ld a, $46 ; $5962
	ld [wBriefingBallX], a ; $5964
	ld a, $28 ; $5967
	ld [wBriefingBallY], a ; $5969
	ld a, $01 ; $596c
	ld hl, DrawBriefingBallSprite ; $596e
	call RegisterFrameTask ; $5971
	ld a, $03 ; $5974
	ld [wBriefingRotMarkerDir], a ; $5976
	ld a, $49 ; $5979
	ld [wBriefingRotMarkerX], a ; $597b
	ld a, $2f ; $597e
	ld [wBriefingRotMarkerY], a ; $5980
	ld a, $01 ; $5983
	ld hl, DrawBriefingMarkerRotated ; $5985
	call RegisterFrameTask ; $5988
	ld a, $01 ; $598b
	ld [wBriefingSpinMarkerUnflipped], a ; $598d
	ld a, $30 ; $5990
	ld [wBriefingSpinMarkerX], a ; $5992
	ld a, $22 ; $5995
	ld [wBriefingSpinMarkerY], a ; $5997
	ld a, $01 ; $599a
	ld hl, DrawSpinServeBriefingMarker ; $599c
	call RegisterFrameTask ; $599f
	ld b, $04 ; $59a2
	call DrawDiagramTargetOverlay ; $59a4
	ld a, $01 ; $59a7
	ld hl, CycleDiagramTargetPalette ; $59a9
	call RegisterFrameTask ; $59ac
	ld hl, Text_36_695 ; $59af
	call DrawBriefingCaption ; $59b2
	call WaitForInputBlinking ; $59b5
	call ClearFrameTasks ; $59b8
	ld a, $01 ; $59bb
	ld hl, UpdateAnimatedTilesTask_17 ; $59bd
	call RegisterFrameTask ; $59c0
	ld a, $00 ; $59c3
	ld [wBriefingAnimStep], a ; $59c5
	call SpinServeBriefing_AdvanceAnim2 ; $59c8
	ld a, $01 ; $59cb
	ld hl, DrawBriefingPlayerSprite ; $59cd
	call RegisterFrameTask ; $59d0
	ld a, $01 ; $59d3
	ld hl, DrawBriefingBallSprite ; $59d5
	call RegisterFrameTask ; $59d8
	ld a, $01 ; $59db
	ld hl, DrawBriefingMarkerRotated ; $59dd
	call RegisterFrameTask ; $59e0
	ld a, $01 ; $59e3
	ld hl, DrawSpinServeBriefingMarker ; $59e5
	call RegisterFrameTask ; $59e8
	ld a, $01 ; $59eb
	ld hl, DrawBriefingSwingAnim ; $59ed
	call RegisterFrameTask ; $59f0
	ld a, $01 ; $59f3
	ld hl, CycleDiagramTargetPalette ; $59f5
	call RegisterFrameTask ; $59f8
	ld hl, $1ab8 ; $59fb
	ld a, [wStoryModeMainCharacterLeftHanded] ; $59fe
	and a ; $5a01
	jr z, .drawBriefingCaption ; $5a02
	ld hl, Text_36_697 ; $5a04
.drawBriefingCaption:
	call DrawBriefingCaption ; $5a07
	xor a ; $5a0a
	ld [wBriefingAnimTimer], a ; $5a0b
	ld [wBriefingAnimStep], a ; $5a0e
.loop2:
	call SpinServeBriefing_TickAnim2 ; $5a11
	ld c, $00 ; $5a14
	call AdvanceFrameCheckInput ; $5a16
	and a ; $5a19
	jp z, .loop2 ; $5a1a
	call ClearFrameTasks ; $5a1d
	ld a, $01 ; $5a20
	ld hl, UpdateAnimatedTilesTask_17 ; $5a22
	call RegisterFrameTask ; $5a25
	ld a, $03 ; $5a28
	ld [wBriefingAnimStep], a ; $5a2a
	call SpinServeBriefing_AdvanceAnim ; $5a2d
	ld a, $01 ; $5a30
	ld hl, DrawBriefingPlayerSprite ; $5a32
	call RegisterFrameTask ; $5a35
	ld a, $01 ; $5a38
	ld hl, DrawBriefingBallSprite ; $5a3a
	call RegisterFrameTask ; $5a3d
	ld a, $01 ; $5a40
	ld hl, DrawBriefingMarkerRotated ; $5a42
	call RegisterFrameTask ; $5a45
	ld a, $01 ; $5a48
	ld hl, CycleDiagramTargetPalette ; $5a4a
	call RegisterFrameTask ; $5a4d
	ld a, $01 ; $5a50
	ld hl, DrawBriefingTargetBrackets ; $5a52
	call RegisterFrameTask ; $5a55
	ld hl, Text_36_698 ; $5a58
	call DrawBriefingCaption ; $5a5b
	xor a ; $5a5e
	ld [wBriefingAnimTimer], a ; $5a5f
	ld [wBriefingAnimStep], a ; $5a62
.loop3:
	call SpinServeBriefing_TickAnim ; $5a65
	ld c, $01 ; $5a68
	call AdvanceFrameCheckInput ; $5a6a
	and a ; $5a6d
	jp z, .loop3 ; $5a6e
	call ClearFrameTasks ; $5a71
	ret ; $5a74
SpinServeBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $5a75
	inc a ; $5a78
	ld [wBriefingAnimTimer], a ; $5a79
	cp $78 ; $5a7c
	jr nc, SpinServeBriefing_AdvanceAnim ; $5a7e
	ret ; $5a80
SpinServeBriefing_AdvanceAnim:
	xor a ; $5a81
	ld [wBriefingAnimTimer], a ; $5a82
	ld a, [wBriefingAnimStep] ; $5a85
	inc a ; $5a88
	and $03 ; $5a89
	ld [wBriefingAnimStep], a ; $5a8b
	sla a ; $5a8e
	sla a ; $5a90
	ld c, a ; $5a92
	ld_hl_indexed SpinServeBriefing_AdvanceAnimTable ; $5a93
	ld a, [hl] ; $5a9a
	inc hl ; $5a9b
	inc hl ; $5a9c
	ld b, [hl] ; $5a9d
	ld a, a ; $5a9e
	ld [wBriefingPlayerX], a ; $5a9f
	ld a, b ; $5aa2
	ld [wBriefingPlayerY], a ; $5aa3
	ld a, c ; $5aa6
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_BracketPosTable ; $5aa7
	ld a, [hl] ; $5aae
	inc hl ; $5aaf
	inc hl ; $5ab0
	ld b, [hl] ; $5ab1
	ld a, a ; $5ab2
	ld [wBriefingBracketX], a ; $5ab3
	ld a, b ; $5ab6
	ld [wBriefingBracketY], a ; $5ab7
	ld a, c ; $5aba
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_BallPosTable ; $5abb
	ld a, [hl] ; $5ac2
	inc hl ; $5ac3
	inc hl ; $5ac4
	ld b, [hl] ; $5ac5
	ld a, a ; $5ac6
	ld [wBriefingBallX], a ; $5ac7
	ld a, b ; $5aca
	ld [wBriefingBallY], a ; $5acb
	ld a, [wBriefingAnimStep] ; $5ace
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_HMarkerUnflippedTable ; $5ad1
	ld a, [hl] ; $5ad8
	ld [wBriefingHMarkerUnflipped], a ; $5ad9
	ld a, c ; $5adc
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_HMarkerPosTable ; $5add
	ld a, [hl] ; $5ae4
	inc hl ; $5ae5
	inc hl ; $5ae6
	ld b, [hl] ; $5ae7
	ld a, a ; $5ae8
	ld [wBriefingHMarkerX], a ; $5ae9
	ld a, b ; $5aec
	ld [wBriefingHMarkerY], a ; $5aed
	ld a, [wBriefingAnimStep] ; $5af0
	ld_hl_indexed SpinServeBriefing_RotMarkerDirTable ; $5af3
	ld a, [hl] ; $5afa
	ld [wBriefingRotMarkerDir], a ; $5afb
	ld a, c ; $5afe
	ld_hl_indexed SpinServeBriefing_AdvanceAnim_RotMarkerPosTable ; $5aff
	ld a, [hl] ; $5b06
	inc hl ; $5b07
	inc hl ; $5b08
	ld b, [hl] ; $5b09
	ld a, a ; $5b0a
	ld [wBriefingRotMarkerX], a ; $5b0b
	ld a, b ; $5b0e
	ld [wBriefingRotMarkerY], a ; $5b0f
	ld a, [wBriefingAnimStep] ; $5b12
	ld_hl_indexed SpinServeBriefing_TargetOverlayTable ; $5b15
	ld b, [hl] ; $5b1c
	call DrawDiagramTargetOverlay ; $5b1d
	ret ; $5b20
SpinServeBriefing_TickAnim2:
	ld a, [wBriefingAnimTimer] ; $5b21
	inc a ; $5b24
	ld [wBriefingAnimTimer], a ; $5b25
	cp $78 ; $5b28
	jr nc, SpinServeBriefing_AdvanceAnim2 ; $5b2a
	ret ; $5b2c
SpinServeBriefing_AdvanceAnim2:
	xor a ; $5b2d
	ld [wBriefingAnimTimer], a ; $5b2e
	ld a, [wBriefingAnimStep] ; $5b31
	xor $01 ; $5b34
	ld [wBriefingAnimStep], a ; $5b36
	sla a ; $5b39
	sla a ; $5b3b
	ld c, a ; $5b3d
	ld_hl_indexed SpinServeBriefing_AdvanceAnimTable ; $5b3e
	ld a, [hl] ; $5b45
	inc hl ; $5b46
	inc hl ; $5b47
	ld b, [hl] ; $5b48
	ld a, a ; $5b49
	ld [wBriefingPlayerX], a ; $5b4a
	ld a, b ; $5b4d
	ld [wBriefingPlayerY], a ; $5b4e
	ld a, c ; $5b51
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_BallPosTable ; $5b52
	ld a, [hl] ; $5b59
	inc hl ; $5b5a
	inc hl ; $5b5b
	ld b, [hl] ; $5b5c
	ld a, a ; $5b5d
	ld [wBriefingBallX], a ; $5b5e
	ld a, b ; $5b61
	ld [wBriefingBallY], a ; $5b62
	ld a, [wBriefingAnimStep] ; $5b65
	ld_hl_indexed SpinServeBriefing_RotMarkerDirTable ; $5b68
	ld a, [hl] ; $5b6f
	ld [wBriefingRotMarkerDir], a ; $5b70
	ld a, c ; $5b73
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_RotMarkerPosTable ; $5b74
	ld a, [hl] ; $5b7b
	inc hl ; $5b7c
	inc hl ; $5b7d
	ld b, [hl] ; $5b7e
	ld a, a ; $5b7f
	ld [wBriefingRotMarkerX], a ; $5b80
	ld a, b ; $5b83
	ld [wBriefingRotMarkerY], a ; $5b84
	ld a, [wBriefingAnimStep] ; $5b87
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_SpinMarkerUnflippedTable ; $5b8a
	ld a, [hl] ; $5b91
	ld [wBriefingSpinMarkerUnflipped], a ; $5b92
	ld a, c ; $5b95
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_SpinMarkerPosTable ; $5b96
	ld a, [hl] ; $5b9d
	inc hl ; $5b9e
	inc hl ; $5b9f
	ld b, [hl] ; $5ba0
	ld a, a ; $5ba1
	ld [wBriefingSpinMarkerX], a ; $5ba2
	ld a, b ; $5ba5
	ld [wBriefingSpinMarkerY], a ; $5ba6
	ld b, $00 ; $5ba9
	ld a, [wStoryModeMainCharacterLeftHanded] ; $5bab
	and a ; $5bae
	jr z, .zero ; $5baf
	ld b, $02 ; $5bb1
.zero:
	ld a, [wBriefingAnimStep] ; $5bb3
	add b ; $5bb6
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_SwingFrameTable ; $5bb7
	ld a, [hl] ; $5bbe
	ld [wBriefingSwingFrame], a ; $5bbf
	ld a, c ; $5bc2
	ld_hl_indexed SpinServeBriefing_AdvanceAnim2_SwingPosTable ; $5bc3
	ld a, [hl] ; $5bca
	inc hl ; $5bcb
	inc hl ; $5bcc
	ld b, [hl] ; $5bcd
	ld a, a ; $5bce
	ld [wBriefingSwingX], a ; $5bcf
	ld a, b ; $5bd2
	ld [wBriefingSwingY], a ; $5bd3
	ld a, [wBriefingAnimStep] ; $5bd6
	ld_hl_indexed SpinServeBriefing_TargetOverlayTable ; $5bd9
	ld b, [hl] ; $5be0
	call DrawDiagramTargetOverlay ; $5be1
	ret ; $5be4
SpinServeBriefing_AdvanceAnimTable:
	; $5be5, 16 bytes (records:2)
	dw $0052 ; record 0
	dw $0044 ; record 1
	dw $003d ; record 2
	dw $0044 ; record 3
	dw $003d ; record 4
	dw $0000 ; record 5
	dw $0052 ; record 6
	dw $0000 ; record 7
SpinServeBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/SpinServeBriefing_AdvanceAnim_BallPosTable.asm" ; $5bf5, 16 bytes
SpinServeBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $5c05, 4 bytes
SpinServeBriefing_AdvanceAnim_HMarkerPosTable:
	INCLUDE "data/bank_017/SpinServeBriefing_AdvanceAnim_HMarkerPosTable.asm" ; $5c09, 16 bytes
SpinServeBriefing_RotMarkerDirTable:
	INCBIN "data/bank_017/SpinServeBriefing_RotMarkerDirTable.bin" ; $5c19, 4 bytes
SpinServeBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $5c1d, 16 bytes
SpinServeBriefing_TargetOverlayTable:
	INCBIN "data/bank_017/SpinServeBriefing_TargetOverlayTable.bin" ; $5c2d, 4 bytes
SpinServeBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim_BracketPosTable.bin" ; $5c31, 16 bytes
SpinServeBriefing_AdvanceAnim2_BallPosTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim2_BallPosTable.bin" ; $5c41, 8 bytes
SpinServeBriefing_AdvanceAnim2_RotMarkerPosTable:
	INCLUDE "data/bank_017/SpinServeBriefing_AdvanceAnim2_RotMarkerPosTable.asm" ; $5c49, 8 bytes
SpinServeBriefing_AdvanceAnim2_SpinMarkerUnflippedTable:
	db $01 ; $5c51
	db $00 ; $5c52
SpinServeBriefing_AdvanceAnim2_SpinMarkerPosTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim2_SpinMarkerPosTable.bin" ; $5c53, 8 bytes
SpinServeBriefing_AdvanceAnim2_SwingFrameTable:
	INCBIN "data/bank_017/SpinServeBriefing_AdvanceAnim2_SwingFrameTable.bin" ; $5c5b, 4 bytes
SpinServeBriefing_AdvanceAnim2_SwingPosTable:
	INCLUDE "data/bank_017/SpinServeBriefing_AdvanceAnim2_SwingPosTable.asm" ; $5c5f, 8 bytes
DrillBriefing_ServeThroughPoles:
	ld a, $03 ; $5c67
	ld [wBriefingAnimStep], a ; $5c69
	call PoleServeBriefing_AdvanceAnim ; $5c6c
	ld a, $01 ; $5c6f
	ld hl, DrawBriefingPlayerSprite ; $5c71
	call RegisterFrameTask ; $5c74
	ld a, $01 ; $5c77
	ld hl, DrawBriefingBallSprite ; $5c79
	call RegisterFrameTask ; $5c7c
	ld a, $01 ; $5c7f
	ld hl, DrawBriefingMarkerHFlip ; $5c81
	call RegisterFrameTask ; $5c84
	ld a, $01 ; $5c87
	ld hl, DrawBriefingMarkerRotated ; $5c89
	call RegisterFrameTask ; $5c8c
	ld a, $01 ; $5c8f
	ld hl, CycleDiagramTargetPalette ; $5c91
	call RegisterFrameTask ; $5c94
	ld hl, Text_36_699 ; $5c97
	call DrawBriefingCaption ; $5c9a
	xor a ; $5c9d
	ld [wBriefingAnimTimer], a ; $5c9e
	ld [wBriefingAnimStep], a ; $5ca1
.loop:
	call PoleServeBriefing_TickAnim ; $5ca4
	ld c, $00 ; $5ca7
	call AdvanceFrameCheckInput ; $5ca9
	and a ; $5cac
	jp z, .loop ; $5cad
	call ClearFrameTasks ; $5cb0
	ld a, $01 ; $5cb3
	ld hl, UpdateAnimatedTilesTask_17 ; $5cb5
	call RegisterFrameTask ; $5cb8
	ld a, $03 ; $5cbb
	ld [wBriefingAnimStep], a ; $5cbd
	call PoleServeBriefing_AdvanceAnim2 ; $5cc0
	ld a, $01 ; $5cc3
	ld hl, DrawBriefingPlayerSprite ; $5cc5
	call RegisterFrameTask ; $5cc8
	ld a, $01 ; $5ccb
	ld hl, DrawBriefingMarkerHFlip ; $5ccd
	call RegisterFrameTask ; $5cd0
	ld a, $01 ; $5cd3
	ld hl, CycleDiagramTargetPalette ; $5cd5
	call RegisterFrameTask ; $5cd8
	ld a, $00 ; $5cdb
	ld [wBriefingBracketWidth], a ; $5cdd
	ld a, $00 ; $5ce0
	ld [wBriefingBracketHeight], a ; $5ce2
	ld a, $01 ; $5ce5
	ld hl, DrawBriefingTargetBrackets ; $5ce7
	call RegisterFrameTask ; $5cea
	ld hl, Text_36_700 ; $5ced
	call DrawBriefingCaption ; $5cf0
	xor a ; $5cf3
	ld [wBriefingAnimTimer], a ; $5cf4
	ld [wBriefingAnimStep], a ; $5cf7
.loopB:
	call PoleServeBriefing_TickAnim2 ; $5cfa
	ld a, [wBriefingAnimStep] ; $5cfd
	sla a ; $5d00
	sla a ; $5d02
	ld_hl_indexed DrillBriefing_ServeThroughPolesTable ; $5d04
	ld a, [hl] ; $5d0b
	inc hl ; $5d0c
	inc hl ; $5d0d
	ld b, [hl] ; $5d0e
	ld a, a ; $5d0f
	ld [wBriefingPlayerX], a ; $5d10
	ld a, b ; $5d13
	ld [wBriefingPlayerY], a ; $5d14
	ld c, $00 ; $5d17
	call AdvanceFrameCheckInput ; $5d19
	and a ; $5d1c
	jp z, .loopB ; $5d1d
	call ClearFrameTasks ; $5d20
	ld a, $01 ; $5d23
	ld hl, UpdateAnimatedTilesTask_17 ; $5d25
	call RegisterFrameTask ; $5d28
	ld a, $03 ; $5d2b
	ld [wBriefingAnimStep], a ; $5d2d
	call PoleServeBriefing_AdvanceAnim2 ; $5d30
	ld a, $01 ; $5d33
	ld hl, DrawBriefingPlayerSprite ; $5d35
	call RegisterFrameTask ; $5d38
	ld a, $00 ; $5d3b
	ld [wBriefingHMarkerUnflipped], a ; $5d3d
	ld a, $4b ; $5d40
	ld [wBriefingHMarkerX], a ; $5d42
	ld a, $36 ; $5d45
	ld [wBriefingHMarkerY], a ; $5d47
	ld a, $01 ; $5d4a
	ld hl, DrawBriefingMarkerHFlip ; $5d4c
	call RegisterFrameTask ; $5d4f
	ld a, $01 ; $5d52
	ld hl, DrawBriefingPoleSprites ; $5d54
	call RegisterFrameTask ; $5d57
	ld a, $01 ; $5d5a
	ld hl, CycleDiagramTargetPalette ; $5d5c
	call RegisterFrameTask ; $5d5f
	ld a, $00 ; $5d62
	ld [wBriefingBracketWidth], a ; $5d64
	ld a, $00 ; $5d67
	ld [wBriefingBracketHeight], a ; $5d69
	ld a, $01 ; $5d6c
	ld hl, DrawBriefingTargetBrackets ; $5d6e
	call RegisterFrameTask ; $5d71
	ld hl, Text_36_701 ; $5d74
	call DrawBriefingCaption ; $5d77
	call WaitForInputBlinking ; $5d7a
	call ClearFrameTasks ; $5d7d
	ld a, $01 ; $5d80
	ld hl, UpdateAnimatedTilesTask_17 ; $5d82
	call RegisterFrameTask ; $5d85
	ld a, $03 ; $5d88
	ld [wBriefingAnimStep], a ; $5d8a
	call PoleServeBriefing_AdvanceAnim2 ; $5d8d
	ld a, $01 ; $5d90
	ld hl, DrawBriefingPlayerSprite ; $5d92
	call RegisterFrameTask ; $5d95
	ld a, $01 ; $5d98
	ld hl, DrawBriefingPoleSprites ; $5d9a
	call RegisterFrameTask ; $5d9d
	ld a, $01 ; $5da0
	ld hl, CycleDiagramTargetPalette ; $5da2
	call RegisterFrameTask ; $5da5
	ld a, $00 ; $5da8
	ld [wBriefingBracketWidth], a ; $5daa
	ld a, $00 ; $5dad
	ld [wBriefingBracketHeight], a ; $5daf
	ld a, $01 ; $5db2
	ld hl, DrawBriefingTargetBrackets ; $5db4
	call RegisterFrameTask ; $5db7
	ld hl, Text_36_702 ; $5dba
	call DrawBriefingCaption ; $5dbd
.loop2:
	call PoleServeBriefing_TickAnim2 ; $5dc0
	ld c, $01 ; $5dc3
	call AdvanceFrameCheckInput ; $5dc5
	and a ; $5dc8
	jp z, .loop2 ; $5dc9
	call ClearFrameTasks ; $5dcc
	ret ; $5dcf
PoleServeBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $5dd0
	inc a ; $5dd3
	ld [wBriefingAnimTimer], a ; $5dd4
	cp $78 ; $5dd7
	jr nc, PoleServeBriefing_AdvanceAnim ; $5dd9
	ret ; $5ddb
PoleServeBriefing_AdvanceAnim:
	xor a ; $5ddc
	ld [wBriefingAnimTimer], a ; $5ddd
	ld a, [wBriefingAnimStep] ; $5de0
	inc a ; $5de3
	and $03 ; $5de4
	ld [wBriefingAnimStep], a ; $5de6
	sla a ; $5de9
	sla a ; $5deb
	ld c, a ; $5ded
	ld_hl_indexed DrillBriefing_ServeThroughPolesTable ; $5dee
	ld a, [hl] ; $5df5
	inc hl ; $5df6
	inc hl ; $5df7
	ld b, [hl] ; $5df8
	ld a, a ; $5df9
	ld [wBriefingPlayerX], a ; $5dfa
	ld a, b ; $5dfd
	ld [wBriefingPlayerY], a ; $5dfe
	ld a, c ; $5e01
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_BallPosTable ; $5e02
	ld a, [hl] ; $5e09
	inc hl ; $5e0a
	inc hl ; $5e0b
	ld b, [hl] ; $5e0c
	ld a, a ; $5e0d
	ld [wBriefingBallX], a ; $5e0e
	ld a, b ; $5e11
	ld [wBriefingBallY], a ; $5e12
	ld a, [wBriefingAnimStep] ; $5e15
	ld_hl_indexed PoleServeBriefing_HMarkerUnflippedTable ; $5e18
	ld a, [hl] ; $5e1f
	ld [wBriefingHMarkerUnflipped], a ; $5e20
	ld a, c ; $5e23
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_HMarkerPosTable ; $5e24
	ld a, [hl] ; $5e2b
	inc hl ; $5e2c
	inc hl ; $5e2d
	ld b, [hl] ; $5e2e
	ld a, a ; $5e2f
	ld [wBriefingHMarkerX], a ; $5e30
	ld a, b ; $5e33
	ld [wBriefingHMarkerY], a ; $5e34
	ld a, [wBriefingAnimStep] ; $5e37
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_RotMarkerDirTable ; $5e3a
	ld a, [hl] ; $5e41
	ld [wBriefingRotMarkerDir], a ; $5e42
	ld a, c ; $5e45
	ld_hl_indexed PoleServeBriefing_AdvanceAnim_RotMarkerPosTable ; $5e46
	ld a, [hl] ; $5e4d
	inc hl ; $5e4e
	inc hl ; $5e4f
	ld b, [hl] ; $5e50
	ld a, a ; $5e51
	ld [wBriefingRotMarkerX], a ; $5e52
	ld a, b ; $5e55
	ld [wBriefingRotMarkerY], a ; $5e56
	ld a, [wBriefingAnimStep] ; $5e59
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5e5c
	ld b, [hl] ; $5e63
	call DrawDiagramTargetOverlay ; $5e64
	ret ; $5e67
PoleServeBriefing_TickAnim2:
	ld a, [wBriefingAnimTimer] ; $5e68
	inc a ; $5e6b
	ld [wBriefingAnimTimer], a ; $5e6c
	cp $78 ; $5e6f
	jr nc, PoleServeBriefing_AdvanceAnim2 ; $5e71
	ret ; $5e73
PoleServeBriefing_AdvanceAnim2:
	xor a ; $5e74
	ld [wBriefingAnimTimer], a ; $5e75
	ld a, [wBriefingAnimStep] ; $5e78
	inc a ; $5e7b
	and $03 ; $5e7c
	ld [wBriefingAnimStep], a ; $5e7e
	sla a ; $5e81
	sla a ; $5e83
	ld c, a ; $5e85
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PlayerPosTable ; $5e86
	ld a, [hl] ; $5e8d
	inc hl ; $5e8e
	inc hl ; $5e8f
	ld b, [hl] ; $5e90
	ld a, a ; $5e91
	ld [wBriefingPlayerX], a ; $5e92
	ld a, b ; $5e95
	ld [wBriefingPlayerY], a ; $5e96
	ld a, c ; $5e99
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_BracketPosTable ; $5e9a
	ld a, [hl] ; $5ea1
	inc hl ; $5ea2
	inc hl ; $5ea3
	ld b, [hl] ; $5ea4
	ld a, a ; $5ea5
	ld [wBriefingBracketX], a ; $5ea6
	ld a, b ; $5ea9
	ld [wBriefingBracketY], a ; $5eaa
	ld a, c ; $5ead
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PolePosTable ; $5eae
	ld a, [hl] ; $5eb5
	inc hl ; $5eb6
	inc hl ; $5eb7
	ld b, [hl] ; $5eb8
	ld a, a ; $5eb9
	ld [wBriefingPole1X], a ; $5eba
	ld a, b ; $5ebd
	ld [wBriefingPole1Y], a ; $5ebe
	ld a, c ; $5ec1
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_PolePosTable ; $5ec2
	ld a, [hl] ; $5ec9
	add $08 ; $5eca
	ld [wBriefingPole2X], a ; $5ecc
	ld a, [wBriefingPole1Y] ; $5ecf
	ld [wBriefingPole2Y], a ; $5ed2
	ld a, [wBriefingAnimStep] ; $5ed5
	ld_hl_indexed PoleServeBriefing_HMarkerUnflippedTable ; $5ed8
	ld a, [hl] ; $5edf
	ld [wBriefingHMarkerUnflipped], a ; $5ee0
	ld a, c ; $5ee3
	ld_hl_indexed PoleServeBriefing_AdvanceAnim2_HMarkerPosTable ; $5ee4
	ld a, [hl] ; $5eeb
	inc hl ; $5eec
	inc hl ; $5eed
	ld b, [hl] ; $5eee
	ld a, a ; $5eef
	ld [wBriefingHMarkerX], a ; $5ef0
	ld a, b ; $5ef3
	ld [wBriefingHMarkerY], a ; $5ef4
	ld a, [wBriefingAnimStep] ; $5ef7
	ld_hl_indexed PoleServeBriefing_TargetOverlayTable ; $5efa
	ld b, [hl] ; $5f01
	call DrawDiagramTargetOverlay ; $5f02
	ret ; $5f05
DrillBriefing_ServeThroughPolesTable:
	; $5f06, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
PoleServeBriefing_AdvanceAnim2_PlayerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_PlayerPosTable.asm" ; $5f16, 16 bytes
PoleServeBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim_BallPosTable.asm" ; $5f26, 16 bytes
PoleServeBriefing_HMarkerUnflippedTable:
	INCBIN "data/bank_017/PoleServeBriefing_HMarkerUnflippedTable.bin" ; $5f36, 4 bytes
PoleServeBriefing_AdvanceAnim_HMarkerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim_HMarkerPosTable.asm" ; $5f3a, 16 bytes
PoleServeBriefing_AdvanceAnim2_HMarkerPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_HMarkerPosTable.asm" ; $5f4a, 16 bytes
PoleServeBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/PoleServeBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $5f5a, 4 bytes
PoleServeBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/PoleServeBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $5f5e, 16 bytes
PoleServeBriefing_TargetOverlayTable:
	INCBIN "data/bank_017/PoleServeBriefing_TargetOverlayTable.bin" ; $5f6e, 4 bytes
PoleServeBriefing_AdvanceAnim2_BracketPosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_BracketPosTable.asm" ; $5f72, 16 bytes
PoleServeBriefing_AdvanceAnim2_PolePosTable:
	INCLUDE "data/bank_017/PoleServeBriefing_AdvanceAnim2_PolePosTable.asm" ; $5f82, 16 bytes
DrillBriefing_ServeAndVolley:
	ld a, $52 ; $5f92
	ld [wBriefingPlayerX], a ; $5f94
	ld a, $44 ; $5f97
	ld [wBriefingPlayerY], a ; $5f99
	ld a, $01 ; $5f9c
	ld hl, DrawBriefingPlayerSprite ; $5f9e
	call RegisterFrameTask ; $5fa1
	ld a, $34 ; $5fa4
	ld [wBriefingOpponentX], a ; $5fa6
	ld a, $06 ; $5fa9
	ld [wBriefingOpponentY], a ; $5fab
	ld a, $01 ; $5fae
	ld hl, DrawBriefingOpponentSprite ; $5fb0
	call RegisterFrameTask ; $5fb3
	ld a, $4e ; $5fb6
	ld [wBriefingBallX], a ; $5fb8
	ld a, $38 ; $5fbb
	ld [wBriefingBallY], a ; $5fbd
	ld a, $01 ; $5fc0
	ld hl, DrawBriefingBallSprite ; $5fc2
	call RegisterFrameTask ; $5fc5
	ld a, $00 ; $5fc8
	ld [wBriefingHMarkerUnflipped], a ; $5fca
	ld a, $3a ; $5fcd
	ld [wBriefingHMarkerX], a ; $5fcf
	ld a, $3c ; $5fd2
	ld [wBriefingHMarkerY], a ; $5fd4
	ld a, $01 ; $5fd7
	ld hl, DrawBriefingMarkerHFlip ; $5fd9
	call RegisterFrameTask ; $5fdc
	ld a, $03 ; $5fdf
	ld [wBriefingRotMarkerDir], a ; $5fe1
	ld a, $52 ; $5fe4
	ld [wBriefingRotMarkerX], a ; $5fe6
	ld a, $40 ; $5fe9
	ld [wBriefingRotMarkerY], a ; $5feb
	ld a, $01 ; $5fee
	ld hl, DrawBriefingMarkerRotated ; $5ff0
	call RegisterFrameTask ; $5ff3
	ld b, $06 ; $5ff6
	call DrawDiagramTargetOverlay ; $5ff8
	ld a, $01 ; $5ffb
	ld hl, CycleDiagramTargetPalette ; $5ffd
	call RegisterFrameTask ; $6000
	ld hl, Text_36_703 ; $6003
	call DrawBriefingCaption ; $6006
	call WaitForInputBlinking ; $6009
	call ClearFrameTasks ; $600c
	ld a, $01 ; $600f
	ld hl, UpdateAnimatedTilesTask_17 ; $6011
	call RegisterFrameTask ; $6014
	call DrawDiagramTargetOverlay ; $6017
	ld a, $03 ; $601a
	ld [wBriefingAnimStep], a ; $601c
	call ServeAndVolleyBriefing_AdvanceAnim ; $601f
	ld a, $01 ; $6022
	ld hl, DrawBriefingPlayerSprite ; $6024
	call RegisterFrameTask ; $6027
	ld a, $01 ; $602a
	ld hl, DrawBriefingOpponentSprite ; $602c
	call RegisterFrameTask ; $602f
	ld a, $01 ; $6032
	ld hl, DrawBriefingBallSprite ; $6034
	call RegisterFrameTask ; $6037
	ld a, $01 ; $603a
	ld hl, DrawBriefingMarkerHFlip ; $603c
	call RegisterFrameTask ; $603f
	ld a, $01 ; $6042
	ld hl, DrawBriefingMarkerRotated ; $6044
	call RegisterFrameTask ; $6047
	ld a, $01 ; $604a
	ld hl, DrawBriefingMarkerVFlip ; $604c
	call RegisterFrameTask ; $604f
	ld a, $0d ; $6052
	ld [wBriefingBracketWidth], a ; $6054
	ld a, $0f ; $6057
	ld [wBriefingBracketHeight], a ; $6059
	ld a, $01 ; $605c
	ld hl, DrawBriefingTargetBrackets ; $605e
	call RegisterFrameTask ; $6061
	ld hl, Text_36_704 ; $6064
	call DrawBriefingCaption ; $6067
	call WaitForInputBlinking ; $606a
	call ClearFrameTasks ; $606d
	ld a, $01 ; $6070
	ld hl, UpdateAnimatedTilesTask_17 ; $6072
	call RegisterFrameTask ; $6075
	ld a, $03 ; $6078
	ld [wBriefingAnimStep], a ; $607a
	call ServeAndVolleyBriefing_AdvanceAnim ; $607d
	ld a, $01 ; $6080
	ld hl, DrawBriefingPlayerSprite ; $6082
	call RegisterFrameTask ; $6085
	ld a, $01 ; $6088
	ld hl, DrawBriefingOpponentSprite ; $608a
	call RegisterFrameTask ; $608d
	ld a, $01 ; $6090
	ld hl, DrawBriefingBallSprite ; $6092
	call RegisterFrameTask ; $6095
	ld a, $01 ; $6098
	ld hl, DrawBriefingMarkerHFlip ; $609a
	call RegisterFrameTask ; $609d
	ld a, $01 ; $60a0
	ld hl, DrawBriefingMarkerRotated ; $60a2
	call RegisterFrameTask ; $60a5
	ld a, $01 ; $60a8
	ld hl, DrawBriefingMarkerVFlip ; $60aa
	call RegisterFrameTask ; $60ad
	ld a, $0d ; $60b0
	ld [wBriefingBracketWidth], a ; $60b2
	ld a, $0f ; $60b5
	ld [wBriefingBracketHeight], a ; $60b7
	ld a, $01 ; $60ba
	ld hl, DrawBriefingTargetBrackets ; $60bc
	call RegisterFrameTask ; $60bf
	ld hl, Text_36_705 ; $60c2
	call DrawBriefingCaption ; $60c5
	xor a ; $60c8
	ld [wBriefingAnimTimer], a ; $60c9
	ld [wBriefingAnimStep], a ; $60cc
.loop:
	call ServeAndVolleyBriefing_TickAnim ; $60cf
	ld c, $01 ; $60d2
	call AdvanceFrameCheckInput ; $60d4
	and a ; $60d7
	jp z, .loop ; $60d8
	call ClearFrameTasks ; $60db
	ret ; $60de
ServeAndVolleyBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $60df
	inc a ; $60e2
	ld [wBriefingAnimTimer], a ; $60e3
	cp $78 ; $60e6
	jp nc, ServeAndVolleyBriefing_AdvanceAnim ; $60e8
	ret ; $60eb
ServeAndVolleyBriefing_AdvanceAnim:
	xor a ; $60ec
	ld [wBriefingAnimTimer], a ; $60ed
	ld a, [wBriefingAnimStep] ; $60f0
	inc a ; $60f3
	and $03 ; $60f4
	ld [wBriefingAnimStep], a ; $60f6
	sla a ; $60f9
	sla a ; $60fb
	ld c, a ; $60fd
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnimTable ; $60fe
	ld a, [hl] ; $6105
	inc hl ; $6106
	inc hl ; $6107
	ld b, [hl] ; $6108
	ld a, a ; $6109
	ld [wBriefingPlayerX], a ; $610a
	ld a, b ; $610d
	ld [wBriefingPlayerY], a ; $610e
	ld a, c ; $6111
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable ; $6112
	ld a, [hl] ; $6119
	inc hl ; $611a
	inc hl ; $611b
	ld b, [hl] ; $611c
	ld a, a ; $611d
	ld [wBriefingOpponentX], a ; $611e
	ld a, b ; $6121
	ld [wBriefingOpponentY], a ; $6122
	ld a, c ; $6125
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable ; $6126
	ld a, [hl] ; $612d
	inc hl ; $612e
	inc hl ; $612f
	ld b, [hl] ; $6130
	ld a, a ; $6131
	ld [wBriefingBracketX], a ; $6132
	ld a, b ; $6135
	ld [wBriefingBracketY], a ; $6136
	ld a, c ; $6139
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_BallPosTable ; $613a
	ld a, [hl] ; $6141
	inc hl ; $6142
	inc hl ; $6143
	ld b, [hl] ; $6144
	ld a, a ; $6145
	ld [wBriefingBallX], a ; $6146
	ld a, b ; $6149
	ld [wBriefingBallY], a ; $614a
	ld a, [wBriefingAnimStep] ; $614d
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6150
	ld a, [hl] ; $6157
	ld [wBriefingHMarkerUnflipped], a ; $6158
	ld a, c ; $615b
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable ; $615c
	ld a, [hl] ; $6163
	inc hl ; $6164
	inc hl ; $6165
	ld b, [hl] ; $6166
	ld a, a ; $6167
	ld [wBriefingHMarkerX], a ; $6168
	ld a, b ; $616b
	ld [wBriefingHMarkerY], a ; $616c
	ld a, [wBriefingAnimStep] ; $616f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable ; $6172
	ld a, [hl] ; $6179
	ld [wBriefingRotMarkerDir], a ; $617a
	ld a, c ; $617d
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable ; $617e
	ld a, [hl] ; $6185
	inc hl ; $6186
	inc hl ; $6187
	ld b, [hl] ; $6188
	ld a, a ; $6189
	ld [wBriefingRotMarkerX], a ; $618a
	ld a, b ; $618d
	ld [wBriefingRotMarkerY], a ; $618e
	ld a, [wBriefingAnimStep] ; $6191
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable ; $6194
	ld a, [hl] ; $619b
	ld [wBriefingVMarkerUpright], a ; $619c
	ld a, c ; $619f
	ld_hl_indexed ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable ; $61a0
	ld a, [hl] ; $61a7
	inc hl ; $61a8
	inc hl ; $61a9
	ld b, [hl] ; $61aa
	ld a, a ; $61ab
	ld [wBriefingVMarkerX], a ; $61ac
	ld a, b ; $61af
	ld [wBriefingVMarkerY], a ; $61b0
	ret ; $61b3
ServeAndVolleyBriefing_AdvanceAnimTable:
	; $61b4, 16 bytes (records:2)
	dw $0052 ; record 0
	dw $0030 ; record 1
	dw $003c ; record 2
	dw $0030 ; record 3
	dw $003c ; record 4
	dw $0018 ; record 5
	dw $0052 ; record 6
	dw $0018 ; record 7
ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_OpponentPosTable.bin" ; $61c4, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_BallPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_BallPosTable.bin" ; $61d4, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $61e4, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $61e8, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $61f8, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $61fc, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_VMarkerUprightTable.bin" ; $620c, 4 bytes
ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable:
	INCLUDE "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_VMarkerPosTable.asm" ; $6210, 16 bytes
ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ServeAndVolleyBriefing_AdvanceAnim_BracketPosTable.bin" ; $6220, 16 bytes
DrillBriefing_ServeAndSmash:
	ld a, $55 ; $6230
	ld [wBriefingPlayerX], a ; $6232
	ld a, $44 ; $6235
	ld [wBriefingPlayerY], a ; $6237
	ld a, $01 ; $623a
	ld hl, DrawBriefingPlayerSprite ; $623c
	call RegisterFrameTask ; $623f
	ld a, $34 ; $6242
	ld [wBriefingOpponentX], a ; $6244
	ld a, $06 ; $6247
	ld [wBriefingOpponentY], a ; $6249
	ld a, $01 ; $624c
	ld hl, DrawBriefingOpponentSprite ; $624e
	call RegisterFrameTask ; $6251
	ld a, $4e ; $6254
	ld [wBriefingBallX], a ; $6256
	ld a, $38 ; $6259
	ld [wBriefingBallY], a ; $625b
	ld a, $01 ; $625e
	ld hl, DrawBriefingBallSprite ; $6260
	call RegisterFrameTask ; $6263
	ld a, $00 ; $6266
	ld [wBriefingHMarkerUnflipped], a ; $6268
	ld a, $3a ; $626b
	ld [wBriefingHMarkerX], a ; $626d
	ld a, $20 ; $6270
	ld [wBriefingHMarkerY], a ; $6272
	ld a, $01 ; $6275
	ld hl, DrawBriefingMarkerHFlip ; $6277
	call RegisterFrameTask ; $627a
	ld a, $03 ; $627d
	ld [wBriefingRotMarkerDir], a ; $627f
	ld a, $52 ; $6282
	ld [wBriefingRotMarkerX], a ; $6284
	ld a, $40 ; $6287
	ld [wBriefingRotMarkerY], a ; $6289
	ld a, $01 ; $628c
	ld hl, DrawBriefingMarkerRotated ; $628e
	call RegisterFrameTask ; $6291
	ld a, $0d ; $6294
	ld [wBriefingBracketWidth], a ; $6296
	ld a, $00 ; $6299
	ld [wBriefingBracketHeight], a ; $629b
	ld a, $3e ; $629e
	ld [wBriefingBracketX], a ; $62a0
	ld a, $22 ; $62a3
	ld [wBriefingBracketY], a ; $62a5
	ld a, $01 ; $62a8
	ld hl, DrawBriefingTargetBrackets ; $62aa
	call RegisterFrameTask ; $62ad
	ld hl, Text_36_706 ; $62b0
	call DrawBriefingCaption ; $62b3
	call WaitForInputBlinking ; $62b6
	call ClearFrameTasks ; $62b9
	ld a, $01 ; $62bc
	ld hl, UpdateAnimatedTilesTask_17 ; $62be
	call RegisterFrameTask ; $62c1
	ld a, $55 ; $62c4
	ld [wBriefingPlayerX], a ; $62c6
	ld a, $44 ; $62c9
	ld [wBriefingPlayerY], a ; $62cb
	ld a, $01 ; $62ce
	ld hl, DrawBriefingPlayerSprite ; $62d0
	call RegisterFrameTask ; $62d3
	ld a, $34 ; $62d6
	ld [wBriefingOpponentX], a ; $62d8
	ld a, $06 ; $62db
	ld [wBriefingOpponentY], a ; $62dd
	ld a, $01 ; $62e0
	ld hl, DrawBriefingOpponentSprite ; $62e2
	call RegisterFrameTask ; $62e5
	ld a, $00 ; $62e8
	ld [wBriefingHMarkerUnflipped], a ; $62ea
	ld a, $3a ; $62ed
	ld [wBriefingHMarkerX], a ; $62ef
	ld a, $3c ; $62f2
	ld [wBriefingHMarkerY], a ; $62f4
	ld a, $01 ; $62f7
	ld hl, DrawBriefingMarkerHFlip ; $62f9
	call RegisterFrameTask ; $62fc
	ld b, $06 ; $62ff
	call DrawDiagramTargetOverlay ; $6301
	ld a, $01 ; $6304
	ld hl, CycleDiagramTargetPalette ; $6306
	call RegisterFrameTask ; $6309
	ld hl, Text_36_707 ; $630c
	call DrawBriefingCaption ; $630f
	call WaitForInputBlinking ; $6312
	call ClearFrameTasks ; $6315
	ld a, $01 ; $6318
	ld hl, UpdateAnimatedTilesTask_17 ; $631a
	call RegisterFrameTask ; $631d
	call DrawDiagramTargetOverlay ; $6320
	ld a, $52 ; $6323
	ld [wBriefingPlayerX], a ; $6325
	ld a, $30 ; $6328
	ld [wBriefingPlayerY], a ; $632a
	ld a, $01 ; $632d
	ld hl, DrawBriefingPlayerSprite ; $632f
	call RegisterFrameTask ; $6332
	ld a, $34 ; $6335
	ld [wBriefingOpponentX], a ; $6337
	ld a, $06 ; $633a
	ld [wBriefingOpponentY], a ; $633c
	ld a, $01 ; $633f
	ld hl, DrawBriefingOpponentSprite ; $6341
	call RegisterFrameTask ; $6344
	ld a, $5d ; $6347
	ld [wBriefingBallX], a ; $6349
	ld a, $1b ; $634c
	ld [wBriefingBallY], a ; $634e
	ld a, $01 ; $6351
	ld hl, DrawBriefingBallSprite ; $6353
	call RegisterFrameTask ; $6356
	ld a, $01 ; $6359
	ld [wBriefingRotMarkerDir], a ; $635b
	ld a, $46 ; $635e
	ld [wBriefingRotMarkerX], a ; $6360
	ld a, $16 ; $6363
	ld [wBriefingRotMarkerY], a ; $6365
	ld a, $01 ; $6368
	ld hl, DrawBriefingMarkerRotated ; $636a
	call RegisterFrameTask ; $636d
	ld a, $00 ; $6370
	ld [wBriefingVMarkerUpright], a ; $6372
	ld a, $5b ; $6375
	ld [wBriefingVMarkerX], a ; $6377
	ld a, $21 ; $637a
	ld [wBriefingVMarkerY], a ; $637c
	ld a, $01 ; $637f
	ld hl, DrawBriefingMarkerVFlip ; $6381
	call RegisterFrameTask ; $6384
	ld a, $04 ; $6387
	ld [wBriefingSwingFrame], a ; $6389
	ld a, $2d ; $638c
	ld [wBriefingSwingX], a ; $638e
	ld a, $30 ; $6391
	ld [wBriefingSwingY], a ; $6393
	ld a, $01 ; $6396
	ld hl, DrawBriefingSwingAnim ; $6398
	call RegisterFrameTask ; $639b
	ld hl, Text_36_708 ; $639e
	call DrawBriefingCaption ; $63a1
	call WaitForInputBlinking ; $63a4
	call ClearFrameTasks ; $63a7
	ld a, $01 ; $63aa
	ld hl, UpdateAnimatedTilesTask_17 ; $63ac
	call RegisterFrameTask ; $63af
	ld a, $55 ; $63b2
	ld [wBriefingPlayerX], a ; $63b4
	ld a, $44 ; $63b7
	ld [wBriefingPlayerY], a ; $63b9
	ld a, $01 ; $63bc
	ld hl, DrawBriefingPlayerSprite ; $63be
	call RegisterFrameTask ; $63c1
	ld a, $34 ; $63c4
	ld [wBriefingOpponentX], a ; $63c6
	ld a, $06 ; $63c9
	ld [wBriefingOpponentY], a ; $63cb
	ld a, $01 ; $63ce
	ld hl, DrawBriefingOpponentSprite ; $63d0
	call RegisterFrameTask ; $63d3
	ld a, $50 ; $63d6
	ld [wBriefingBallX], a ; $63d8
	ld a, $37 ; $63db
	ld [wBriefingBallY], a ; $63dd
	ld a, $01 ; $63e0
	ld hl, DrawBriefingBallSprite ; $63e2
	call RegisterFrameTask ; $63e5
	ld a, $03 ; $63e8
	ld [wBriefingRotMarkerDir], a ; $63ea
	ld a, $54 ; $63ed
	ld [wBriefingRotMarkerX], a ; $63ef
	ld a, $3d ; $63f2
	ld [wBriefingRotMarkerY], a ; $63f4
	ld a, $01 ; $63f7
	ld hl, DrawBriefingMarkerRotated ; $63f9
	call RegisterFrameTask ; $63fc
	ld a, $0d ; $63ff
	ld [wBriefingBracketWidth], a ; $6401
	ld a, $00 ; $6404
	ld [wBriefingBracketHeight], a ; $6406
	ld a, $3e ; $6409
	ld [wBriefingBracketX], a ; $640b
	ld a, $22 ; $640e
	ld [wBriefingBracketY], a ; $6410
	ld a, $01 ; $6413
	ld hl, DrawBriefingTargetBrackets ; $6415
	call RegisterFrameTask ; $6418
	ld hl, Text_36_709 ; $641b
	call DrawBriefingCaption ; $641e
.loop:
	ld a, [wBriefingAnimTimer] ; $6421
	inc a ; $6424
	ld [wBriefingAnimTimer], a ; $6425
	cp $78 ; $6428
	jp c, .lt78 ; $642a
	xor a ; $642d
	ld [wBriefingAnimTimer], a ; $642e
	ld a, [wBriefingAnimStep] ; $6431
	inc a ; $6434
	and $03 ; $6435
	ld [wBriefingAnimStep], a ; $6437
	sla a ; $643a
	sla a ; $643c
	ld c, a ; $643e
	ld_hl_indexed DrillBriefing_ServeAndSmashTable ; $643f
	ld a, [hl] ; $6446
	inc hl ; $6447
	inc hl ; $6448
	ld b, [hl] ; $6449
	ld a, a ; $644a
	ld [wBriefingPlayerX], a ; $644b
	ld a, b ; $644e
	ld [wBriefingPlayerY], a ; $644f
	ld a, c ; $6452
	ld_hl_indexed DrillBriefing_ServeAndSmash_OpponentPosTable ; $6453
	ld a, [hl] ; $645a
	inc hl ; $645b
	inc hl ; $645c
	ld b, [hl] ; $645d
	ld a, a ; $645e
	ld [wBriefingOpponentX], a ; $645f
	ld a, b ; $6462
	ld [wBriefingOpponentY], a ; $6463
	ld a, c ; $6466
	ld_hl_indexed DrillBriefing_ServeAndSmash_BracketPosTable ; $6467
	ld a, [hl] ; $646e
	inc hl ; $646f
	inc hl ; $6470
	ld b, [hl] ; $6471
	ld a, a ; $6472
	ld [wBriefingBracketX], a ; $6473
	ld a, b ; $6476
	ld [wBriefingBracketY], a ; $6477
	ld a, c ; $647a
	ld_hl_indexed DrillBriefing_ServeAndSmash_BallPosTable ; $647b
	ld a, [hl] ; $6482
	inc hl ; $6483
	inc hl ; $6484
	ld b, [hl] ; $6485
	ld a, a ; $6486
	ld [wBriefingBallX], a ; $6487
	ld a, b ; $648a
	ld [wBriefingBallY], a ; $648b
	ld a, [wBriefingAnimStep] ; $648e
	ld_hl_indexed DrillBriefing_ServeAndSmash_RotMarkerDirTable ; $6491
	ld a, [hl] ; $6498
	ld [wBriefingRotMarkerDir], a ; $6499
	ld a, c ; $649c
	ld_hl_indexed DrillBriefing_ServeAndSmash_RotMarkerPosTable ; $649d
	ld a, [hl] ; $64a4
	inc hl ; $64a5
	inc hl ; $64a6
	ld b, [hl] ; $64a7
	ld a, a ; $64a8
	ld [wBriefingRotMarkerX], a ; $64a9
	ld a, b ; $64ac
	ld [wBriefingRotMarkerY], a ; $64ad
.lt78:
	ld c, $01 ; $64b0
	call AdvanceFrameCheckInput ; $64b2
	and a ; $64b5
	jp z, .loop ; $64b6
	call ClearFrameTasks ; $64b9
	ret ; $64bc
DrillBriefing_ServeAndSmashTable:
	; $64bd, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
DrillBriefing_ServeAndSmash_OpponentPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_OpponentPosTable.bin" ; $64cd, 16 bytes
DrillBriefing_ServeAndSmash_BallPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_BallPosTable.bin" ; $64dd, 36 bytes
DrillBriefing_ServeAndSmash_RotMarkerDirTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_RotMarkerDirTable.bin" ; $6501, 4 bytes
DrillBriefing_ServeAndSmash_RotMarkerPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash_RotMarkerPosTable.bin" ; $6505, 36 bytes
DrillBriefing_ServeAndSmash_BracketPosTable:
	INCLUDE "data/bank_017/DrillBriefing_ServeAndSmash_BracketPosTable.asm" ; $6529, 16 bytes
DrillBriefing_ServeAndSmash2:
	ld a, $55 ; $6539
	ld [wBriefingPlayerX], a ; $653b
	ld a, $44 ; $653e
	ld [wBriefingPlayerY], a ; $6540
	ld a, $01 ; $6543
	ld hl, DrawBriefingPlayerSprite ; $6545
	call RegisterFrameTask ; $6548
	ld a, $34 ; $654b
	ld [wBriefingOpponentX], a ; $654d
	ld a, $06 ; $6550
	ld [wBriefingOpponentY], a ; $6552
	ld a, $01 ; $6555
	ld hl, DrawBriefingOpponentSprite ; $6557
	call RegisterFrameTask ; $655a
	ld a, $4e ; $655d
	ld [wBriefingBallX], a ; $655f
	ld a, $38 ; $6562
	ld [wBriefingBallY], a ; $6564
	ld a, $01 ; $6567
	ld hl, DrawBriefingBallSprite ; $6569
	call RegisterFrameTask ; $656c
	ld a, $00 ; $656f
	ld [wBriefingHMarkerUnflipped], a ; $6571
	ld a, $3a ; $6574
	ld [wBriefingHMarkerX], a ; $6576
	ld a, $20 ; $6579
	ld [wBriefingHMarkerY], a ; $657b
	ld a, $01 ; $657e
	ld hl, DrawBriefingMarkerHFlip ; $6580
	call RegisterFrameTask ; $6583
	ld a, $03 ; $6586
	ld [wBriefingRotMarkerDir], a ; $6588
	ld a, $52 ; $658b
	ld [wBriefingRotMarkerX], a ; $658d
	ld a, $40 ; $6590
	ld [wBriefingRotMarkerY], a ; $6592
	ld a, $01 ; $6595
	ld hl, DrawBriefingMarkerRotated ; $6597
	call RegisterFrameTask ; $659a
	ld a, $0d ; $659d
	ld [wBriefingBracketWidth], a ; $659f
	ld a, $00 ; $65a2
	ld [wBriefingBracketHeight], a ; $65a4
	ld a, $3e ; $65a7
	ld [wBriefingBracketX], a ; $65a9
	ld a, $22 ; $65ac
	ld [wBriefingBracketY], a ; $65ae
	ld a, $01 ; $65b1
	ld hl, DrawBriefingTargetBrackets ; $65b3
	call RegisterFrameTask ; $65b6
	ld hl, Text_36_710 ; $65b9
	call DrawBriefingCaption ; $65bc
	call WaitForInputBlinking ; $65bf
	call ClearFrameTasks ; $65c2
	ld a, $01 ; $65c5
	ld hl, UpdateAnimatedTilesTask_17 ; $65c7
	call RegisterFrameTask ; $65ca
	ld a, $55 ; $65cd
	ld [wBriefingPlayerX], a ; $65cf
	ld a, $44 ; $65d2
	ld [wBriefingPlayerY], a ; $65d4
	ld a, $01 ; $65d7
	ld hl, DrawBriefingPlayerSprite ; $65d9
	call RegisterFrameTask ; $65dc
	ld a, $34 ; $65df
	ld [wBriefingOpponentX], a ; $65e1
	ld a, $06 ; $65e4
	ld [wBriefingOpponentY], a ; $65e6
	ld a, $01 ; $65e9
	ld hl, DrawBriefingOpponentSprite ; $65eb
	call RegisterFrameTask ; $65ee
	ld a, $00 ; $65f1
	ld [wBriefingHMarkerUnflipped], a ; $65f3
	ld a, $3a ; $65f6
	ld [wBriefingHMarkerX], a ; $65f8
	ld a, $3c ; $65fb
	ld [wBriefingHMarkerY], a ; $65fd
	ld a, $01 ; $6600
	ld hl, DrawBriefingMarkerHFlip ; $6602
	call RegisterFrameTask ; $6605
	ld b, $06 ; $6608
	call DrawDiagramTargetOverlay ; $660a
	ld a, $01 ; $660d
	ld hl, CycleDiagramTargetPalette ; $660f
	call RegisterFrameTask ; $6612
	ld hl, Text_36_711 ; $6615
	call DrawBriefingCaption ; $6618
	call WaitForInputBlinking ; $661b
	call ClearFrameTasks ; $661e
	ld a, $01 ; $6621
	ld hl, UpdateAnimatedTilesTask_17 ; $6623
	call RegisterFrameTask ; $6626
	call DrawDiagramTargetOverlay ; $6629
	ld a, $52 ; $662c
	ld [wBriefingPlayerX], a ; $662e
	ld a, $30 ; $6631
	ld [wBriefingPlayerY], a ; $6633
	ld a, $01 ; $6636
	ld hl, DrawBriefingPlayerSprite ; $6638
	call RegisterFrameTask ; $663b
	ld a, $34 ; $663e
	ld [wBriefingOpponentX], a ; $6640
	ld a, $06 ; $6643
	ld [wBriefingOpponentY], a ; $6645
	ld a, $01 ; $6648
	ld hl, DrawBriefingOpponentSprite ; $664a
	call RegisterFrameTask ; $664d
	ld a, $5d ; $6650
	ld [wBriefingBallX], a ; $6652
	ld a, $1b ; $6655
	ld [wBriefingBallY], a ; $6657
	ld a, $01 ; $665a
	ld hl, DrawBriefingBallSprite ; $665c
	call RegisterFrameTask ; $665f
	ld a, $01 ; $6662
	ld [wBriefingRotMarkerDir], a ; $6664
	ld a, $46 ; $6667
	ld [wBriefingRotMarkerX], a ; $6669
	ld a, $16 ; $666c
	ld [wBriefingRotMarkerY], a ; $666e
	ld a, $01 ; $6671
	ld hl, DrawBriefingMarkerRotated ; $6673
	call RegisterFrameTask ; $6676
	ld a, $00 ; $6679
	ld [wBriefingVMarkerUpright], a ; $667b
	ld a, $5b ; $667e
	ld [wBriefingVMarkerX], a ; $6680
	ld a, $21 ; $6683
	ld [wBriefingVMarkerY], a ; $6685
	ld a, $01 ; $6688
	ld hl, DrawBriefingMarkerVFlip ; $668a
	call RegisterFrameTask ; $668d
	ld a, $05 ; $6690
	ld [wBriefingSwingFrame], a ; $6692
	ld a, $2d ; $6695
	ld [wBriefingSwingX], a ; $6697
	ld a, $30 ; $669a
	ld [wBriefingSwingY], a ; $669c
	ld a, $01 ; $669f
	ld hl, DrawBriefingSwingAnim ; $66a1
	call RegisterFrameTask ; $66a4
	ld hl, Text_36_712 ; $66a7
	call DrawBriefingCaption ; $66aa
	call WaitForInputBlinking ; $66ad
	call ClearFrameTasks ; $66b0
	ld a, $01 ; $66b3
	ld hl, UpdateAnimatedTilesTask_17 ; $66b5
	call RegisterFrameTask ; $66b8
	ld a, $55 ; $66bb
	ld [wBriefingPlayerX], a ; $66bd
	ld a, $44 ; $66c0
	ld [wBriefingPlayerY], a ; $66c2
	ld a, $01 ; $66c5
	ld hl, DrawBriefingPlayerSprite ; $66c7
	call RegisterFrameTask ; $66ca
	ld a, $34 ; $66cd
	ld [wBriefingOpponentX], a ; $66cf
	ld a, $06 ; $66d2
	ld [wBriefingOpponentY], a ; $66d4
	ld a, $01 ; $66d7
	ld hl, DrawBriefingOpponentSprite ; $66d9
	call RegisterFrameTask ; $66dc
	ld a, $50 ; $66df
	ld [wBriefingBallX], a ; $66e1
	ld a, $37 ; $66e4
	ld [wBriefingBallY], a ; $66e6
	ld a, $01 ; $66e9
	ld hl, DrawBriefingBallSprite ; $66eb
	call RegisterFrameTask ; $66ee
	ld a, $03 ; $66f1
	ld [wBriefingRotMarkerDir], a ; $66f3
	ld a, $54 ; $66f6
	ld [wBriefingRotMarkerX], a ; $66f8
	ld a, $3d ; $66fb
	ld [wBriefingRotMarkerY], a ; $66fd
	ld a, $01 ; $6700
	ld hl, DrawBriefingMarkerRotated ; $6702
	call RegisterFrameTask ; $6705
	ld a, $0d ; $6708
	ld [wBriefingBracketWidth], a ; $670a
	ld a, $00 ; $670d
	ld [wBriefingBracketHeight], a ; $670f
	ld a, $3e ; $6712
	ld [wBriefingBracketX], a ; $6714
	ld a, $22 ; $6717
	ld [wBriefingBracketY], a ; $6719
	ld a, $01 ; $671c
	ld hl, DrawBriefingTargetBrackets ; $671e
	call RegisterFrameTask ; $6721
	ld hl, Text_36_713 ; $6724
	call DrawBriefingCaption ; $6727
.loop:
	ld a, [wBriefingAnimTimer] ; $672a
	inc a ; $672d
	ld [wBriefingAnimTimer], a ; $672e
	cp $78 ; $6731
	jp c, .lt78 ; $6733
	xor a ; $6736
	ld [wBriefingAnimTimer], a ; $6737
	ld a, [wBriefingAnimStep] ; $673a
	inc a ; $673d
	and $03 ; $673e
	ld [wBriefingAnimStep], a ; $6740
	sla a ; $6743
	sla a ; $6745
	ld c, a ; $6747
	ld_hl_indexed DrillBriefing_ServeAndSmash2Table ; $6748
	ld a, [hl] ; $674f
	inc hl ; $6750
	inc hl ; $6751
	ld b, [hl] ; $6752
	ld a, a ; $6753
	ld [wBriefingPlayerX], a ; $6754
	ld a, b ; $6757
	ld [wBriefingPlayerY], a ; $6758
	ld a, c ; $675b
	ld_hl_indexed DrillBriefing_ServeAndSmash2_OpponentPosTable ; $675c
	ld a, [hl] ; $6763
	inc hl ; $6764
	inc hl ; $6765
	ld b, [hl] ; $6766
	ld a, a ; $6767
	ld [wBriefingOpponentX], a ; $6768
	ld a, b ; $676b
	ld [wBriefingOpponentY], a ; $676c
	ld a, c ; $676f
	ld_hl_indexed DrillBriefing_ServeAndSmash2_BracketPosTable ; $6770
	ld a, [hl] ; $6777
	inc hl ; $6778
	inc hl ; $6779
	ld b, [hl] ; $677a
	ld a, a ; $677b
	ld [wBriefingBracketX], a ; $677c
	ld a, b ; $677f
	ld [wBriefingBracketY], a ; $6780
	ld a, c ; $6783
	ld_hl_indexed DrillBriefing_ServeAndSmash2_BallPosTable ; $6784
	ld a, [hl] ; $678b
	inc hl ; $678c
	inc hl ; $678d
	ld b, [hl] ; $678e
	ld a, a ; $678f
	ld [wBriefingBallX], a ; $6790
	ld a, b ; $6793
	ld [wBriefingBallY], a ; $6794
	ld a, [wBriefingAnimStep] ; $6797
	ld_hl_indexed DrillBriefing_ServeAndSmash2_RotMarkerDirTable ; $679a
	ld a, [hl] ; $67a1
	ld [wBriefingRotMarkerDir], a ; $67a2
	ld a, c ; $67a5
	ld_hl_indexed DrillBriefing_ServeAndSmash2_RotMarkerPosTable ; $67a6
	ld a, [hl] ; $67ad
	inc hl ; $67ae
	inc hl ; $67af
	ld b, [hl] ; $67b0
	ld a, a ; $67b1
	ld [wBriefingRotMarkerX], a ; $67b2
	ld a, b ; $67b5
	ld [wBriefingRotMarkerY], a ; $67b6
.lt78:
	ld c, $01 ; $67b9
	call AdvanceFrameCheckInput ; $67bb
	and a ; $67be
	jp z, .loop ; $67bf
	call ClearFrameTasks ; $67c2
	ret ; $67c5
DrillBriefing_ServeAndSmash2Table:
	; $67c6, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
DrillBriefing_ServeAndSmash2_OpponentPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_OpponentPosTable.bin" ; $67d6, 16 bytes
DrillBriefing_ServeAndSmash2_BallPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_BallPosTable.bin" ; $67e6, 36 bytes
DrillBriefing_ServeAndSmash2_RotMarkerDirTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_RotMarkerDirTable.bin" ; $680a, 4 bytes
DrillBriefing_ServeAndSmash2_RotMarkerPosTable:
	INCBIN "data/bank_017/DrillBriefing_ServeAndSmash2_RotMarkerPosTable.bin" ; $680e, 36 bytes
DrillBriefing_ServeAndSmash2_BracketPosTable:
	INCLUDE "data/bank_017/DrillBriefing_ServeAndSmash2_BracketPosTable.asm" ; $6832, 16 bytes
DrillBriefing_ReturnToTarget:
	ld a, $55 ; $6842
	ld [wBriefingPlayerX], a ; $6844
	ld a, $44 ; $6847
	ld [wBriefingPlayerY], a ; $6849
	ld a, $01 ; $684c
	ld hl, DrawBriefingPlayerSprite ; $684e
	call RegisterFrameTask ; $6851
	ld a, $3a ; $6854
	ld [wBriefingOpponentX], a ; $6856
	ld a, $03 ; $6859
	ld [wBriefingOpponentY], a ; $685b
	ld a, $01 ; $685e
	ld hl, DrawBriefingOpponentSprite ; $6860
	call RegisterFrameTask ; $6863
	ld a, $54 ; $6866
	ld [wBriefingBallX], a ; $6868
	ld a, $28 ; $686b
	ld [wBriefingBallY], a ; $686d
	ld a, $01 ; $6870
	ld hl, DrawBriefingBallSprite ; $6872
	call RegisterFrameTask ; $6875
	ld a, $01 ; $6878
	ld [wBriefingRotMarkerDir], a ; $687a
	ld a, $4c ; $687d
	ld [wBriefingRotMarkerX], a ; $687f
	ld a, $16 ; $6882
	ld [wBriefingRotMarkerY], a ; $6884
	ld a, $01 ; $6887
	ld hl, DrawBriefingMarkerRotated ; $6889
	call RegisterFrameTask ; $688c
	ld hl, Text_37_3 ; $688f
	call DrawBriefingCaption ; $6892
	call WaitForInputBlinking ; $6895
	call ClearFrameTasks ; $6898
	ld a, $01 ; $689b
	ld hl, UpdateAnimatedTilesTask_17 ; $689d
	call RegisterFrameTask ; $68a0
	ld a, $03 ; $68a3
	ld [wBriefingAnimStep], a ; $68a5
	call ReturnToTargetBriefing_AdvanceAnim ; $68a8
	ld a, $01 ; $68ab
	ld hl, DrawBriefingPlayerSprite ; $68ad
	call RegisterFrameTask ; $68b0
	ld a, $01 ; $68b3
	ld hl, DrawBriefingOpponentSprite ; $68b5
	call RegisterFrameTask ; $68b8
	ld a, $01 ; $68bb
	ld hl, DrawBriefingBallSprite ; $68bd
	call RegisterFrameTask ; $68c0
	ld a, $01 ; $68c3
	ld hl, DrawBriefingMarkerHFlip ; $68c5
	call RegisterFrameTask ; $68c8
	ld a, $01 ; $68cb
	ld hl, DrawBriefingMarkerRotated ; $68cd
	call RegisterFrameTask ; $68d0
	ld a, $0d ; $68d3
	ld [wBriefingBracketWidth], a ; $68d5
	ld a, $09 ; $68d8
	ld [wBriefingBracketHeight], a ; $68da
	ld a, $01 ; $68dd
	ld hl, DrawBriefingTargetBrackets ; $68df
	call RegisterFrameTask ; $68e2
	ld hl, Text_37_4 ; $68e5
	call DrawBriefingCaption ; $68e8
	call WaitForInputBlinking ; $68eb
	call ClearFrameTasks ; $68ee
	ld a, $01 ; $68f1
	ld hl, UpdateAnimatedTilesTask_17 ; $68f3
	call RegisterFrameTask ; $68f6
	ld a, $03 ; $68f9
	ld [wBriefingAnimStep], a ; $68fb
	call ReturnToTargetBriefing_AdvanceAnim ; $68fe
	ld a, $01 ; $6901
	ld hl, DrawBriefingPlayerSprite ; $6903
	call RegisterFrameTask ; $6906
	ld a, $01 ; $6909
	ld hl, DrawBriefingOpponentSprite ; $690b
	call RegisterFrameTask ; $690e
	ld a, $01 ; $6911
	ld hl, DrawBriefingBallSprite ; $6913
	call RegisterFrameTask ; $6916
	ld a, $01 ; $6919
	ld hl, DrawBriefingMarkerHFlip ; $691b
	call RegisterFrameTask ; $691e
	ld a, $01 ; $6921
	ld hl, DrawBriefingMarkerRotated ; $6923
	call RegisterFrameTask ; $6926
	ld a, $0d ; $6929
	ld [wBriefingBracketWidth], a ; $692b
	ld a, $09 ; $692e
	ld [wBriefingBracketHeight], a ; $6930
	ld a, $01 ; $6933
	ld hl, DrawBriefingTargetBrackets ; $6935
	call RegisterFrameTask ; $6938
	ld hl, Text_37_5 ; $693b
	call DrawBriefingCaption ; $693e
	xor a ; $6941
	ld [wBriefingAnimTimer], a ; $6942
	ld [wBriefingAnimStep], a ; $6945
.loop:
	call ReturnToTargetBriefing_TickAnim ; $6948
	ld c, $01 ; $694b
	call AdvanceFrameCheckInput ; $694d
	and a ; $6950
	jp z, .loop ; $6951
	call ClearFrameTasks ; $6954
	ret ; $6957
ReturnToTargetBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6958
	inc a ; $695b
	ld [wBriefingAnimTimer], a ; $695c
	cp $78 ; $695f
	jp nc, ReturnToTargetBriefing_AdvanceAnim ; $6961
	ret ; $6964
ReturnToTargetBriefing_AdvanceAnim:
	xor a ; $6965
	ld [wBriefingAnimTimer], a ; $6966
	ld a, [wBriefingAnimStep] ; $6969
	inc a ; $696c
	and $03 ; $696d
	ld [wBriefingAnimStep], a ; $696f
	sla a ; $6972
	sla a ; $6974
	ld c, a ; $6976
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnimTable ; $6977
	ld a, [hl] ; $697e
	inc hl ; $697f
	inc hl ; $6980
	ld b, [hl] ; $6981
	ld a, a ; $6982
	ld [wBriefingPlayerX], a ; $6983
	ld a, b ; $6986
	ld [wBriefingPlayerY], a ; $6987
	ld a, c ; $698a
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable ; $698b
	ld a, [hl] ; $6992
	inc hl ; $6993
	inc hl ; $6994
	ld b, [hl] ; $6995
	ld a, a ; $6996
	ld [wBriefingOpponentX], a ; $6997
	ld a, b ; $699a
	ld [wBriefingOpponentY], a ; $699b
	ld a, c ; $699e
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_BracketPosTable ; $699f
	ld a, [hl] ; $69a6
	inc hl ; $69a7
	inc hl ; $69a8
	ld b, [hl] ; $69a9
	ld a, a ; $69aa
	ld [wBriefingBracketX], a ; $69ab
	ld a, b ; $69ae
	ld [wBriefingBracketY], a ; $69af
	ld a, c ; $69b2
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_BallPosTable ; $69b3
	ld a, [hl] ; $69ba
	inc hl ; $69bb
	inc hl ; $69bc
	ld b, [hl] ; $69bd
	ld a, a ; $69be
	ld [wBriefingBallX], a ; $69bf
	ld a, b ; $69c2
	ld [wBriefingBallY], a ; $69c3
	ld a, [wBriefingAnimStep] ; $69c6
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable ; $69c9
	ld a, [hl] ; $69d0
	ld [wBriefingHMarkerUnflipped], a ; $69d1
	ld a, c ; $69d4
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable ; $69d5
	ld a, [hl] ; $69dc
	inc hl ; $69dd
	inc hl ; $69de
	ld b, [hl] ; $69df
	ld a, a ; $69e0
	ld [wBriefingHMarkerX], a ; $69e1
	ld a, b ; $69e4
	ld [wBriefingHMarkerY], a ; $69e5
	ld a, [wBriefingAnimStep] ; $69e8
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable ; $69eb
	ld a, [hl] ; $69f2
	ld [wBriefingRotMarkerDir], a ; $69f3
	ld a, c ; $69f6
	ld_hl_indexed ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable ; $69f7
	ld a, [hl] ; $69fe
	inc hl ; $69ff
	inc hl ; $6a00
	ld b, [hl] ; $6a01
	ld a, a ; $6a02
	ld [wBriefingRotMarkerX], a ; $6a03
	ld a, b ; $6a06
	ld [wBriefingRotMarkerY], a ; $6a07
	ret ; $6a0a
ReturnToTargetBriefing_AdvanceAnimTable:
	; $6a0b, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6a1b, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_BallPosTable.asm" ; $6a2b, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6a3b, 4 bytes
ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6a3f, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $6a4f, 4 bytes
ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $6a53, 16 bytes
ReturnToTargetBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnToTargetBriefing_AdvanceAnim_BracketPosTable.bin" ; $6a63, 16 bytes
DrillBriefing_ReturnLob:
	ld a, $55 ; $6a73
	ld [wBriefingPlayerX], a ; $6a75
	ld a, $44 ; $6a78
	ld [wBriefingPlayerY], a ; $6a7a
	ld a, $01 ; $6a7d
	ld hl, DrawBriefingPlayerSprite ; $6a7f
	call RegisterFrameTask ; $6a82
	ld a, $3a ; $6a85
	ld [wBriefingOpponentX], a ; $6a87
	ld a, $03 ; $6a8a
	ld [wBriefingOpponentY], a ; $6a8c
	ld a, $01 ; $6a8f
	ld hl, DrawBriefingOpponentSprite ; $6a91
	call RegisterFrameTask ; $6a94
	ld a, $56 ; $6a97
	ld [wBriefingBallX], a ; $6a99
	ld a, $28 ; $6a9c
	ld [wBriefingBallY], a ; $6a9e
	ld a, $01 ; $6aa1
	ld hl, DrawBriefingBallSprite ; $6aa3
	call RegisterFrameTask ; $6aa6
	ld a, $01 ; $6aa9
	ld [wBriefingRotMarkerDir], a ; $6aab
	ld a, $4c ; $6aae
	ld [wBriefingRotMarkerX], a ; $6ab0
	ld a, $16 ; $6ab3
	ld [wBriefingRotMarkerY], a ; $6ab5
	ld a, $01 ; $6ab8
	ld hl, DrawBriefingMarkerRotated ; $6aba
	call RegisterFrameTask ; $6abd
	ld hl, Text_37_6 ; $6ac0
	call DrawBriefingCaption ; $6ac3
	call WaitForInputBlinking ; $6ac6
	call ClearFrameTasks ; $6ac9
	ld a, $01 ; $6acc
	ld hl, UpdateAnimatedTilesTask_17 ; $6ace
	call RegisterFrameTask ; $6ad1
	ld a, $03 ; $6ad4
	ld [wBriefingAnimStep], a ; $6ad6
	call ReturnLobBriefing_AdvanceAnim ; $6ad9
	ld a, $01 ; $6adc
	ld hl, DrawBriefingPlayerSprite ; $6ade
	call RegisterFrameTask ; $6ae1
	ld a, $01 ; $6ae4
	ld hl, DrawBriefingOpponentSprite ; $6ae6
	call RegisterFrameTask ; $6ae9
	ld a, $01 ; $6aec
	ld hl, DrawBriefingBallSprite ; $6aee
	call RegisterFrameTask ; $6af1
	ld a, $01 ; $6af4
	ld hl, DrawBriefingMarkerHFlip ; $6af6
	call RegisterFrameTask ; $6af9
	ld a, $01 ; $6afc
	ld hl, DrawBriefingMarkerRotated ; $6afe
	call RegisterFrameTask ; $6b01
	ld a, $01 ; $6b04
	ld hl, DrawBriefingSwingAnim ; $6b06
	call RegisterFrameTask ; $6b09
	ld a, $0d ; $6b0c
	ld [wBriefingBracketWidth], a ; $6b0e
	ld a, $09 ; $6b11
	ld [wBriefingBracketHeight], a ; $6b13
	ld a, $01 ; $6b16
	ld hl, DrawBriefingTargetBrackets ; $6b18
	call RegisterFrameTask ; $6b1b
	ld hl, Text_37_7 ; $6b1e
	call DrawBriefingCaption ; $6b21
	call WaitForInputBlinking ; $6b24
	call ClearFrameTasks ; $6b27
	ld a, $01 ; $6b2a
	ld hl, UpdateAnimatedTilesTask_17 ; $6b2c
	call RegisterFrameTask ; $6b2f
	ld a, $03 ; $6b32
	ld [wBriefingAnimStep], a ; $6b34
	call ReturnLobBriefing_AdvanceAnim ; $6b37
	ld a, $01 ; $6b3a
	ld hl, DrawBriefingPlayerSprite ; $6b3c
	call RegisterFrameTask ; $6b3f
	ld a, $01 ; $6b42
	ld hl, DrawBriefingOpponentSprite ; $6b44
	call RegisterFrameTask ; $6b47
	ld a, $01 ; $6b4a
	ld hl, DrawBriefingBallSprite ; $6b4c
	call RegisterFrameTask ; $6b4f
	ld a, $01 ; $6b52
	ld hl, DrawBriefingMarkerHFlip ; $6b54
	call RegisterFrameTask ; $6b57
	ld a, $01 ; $6b5a
	ld hl, DrawBriefingMarkerRotated ; $6b5c
	call RegisterFrameTask ; $6b5f
	ld a, $01 ; $6b62
	ld hl, DrawBriefingSwingAnim ; $6b64
	call RegisterFrameTask ; $6b67
	ld a, $0d ; $6b6a
	ld [wBriefingBracketWidth], a ; $6b6c
	ld a, $09 ; $6b6f
	ld [wBriefingBracketHeight], a ; $6b71
	ld a, $01 ; $6b74
	ld hl, DrawBriefingTargetBrackets ; $6b76
	call RegisterFrameTask ; $6b79
	ld hl, Text_37_8 ; $6b7c
	call DrawBriefingCaption ; $6b7f
	xor a ; $6b82
	ld [wBriefingAnimTimer], a ; $6b83
	ld [wBriefingAnimStep], a ; $6b86
.loop:
	call ReturnLobBriefing_TickAnim ; $6b89
	ld c, $01 ; $6b8c
	call AdvanceFrameCheckInput ; $6b8e
	and a ; $6b91
	jp z, .loop ; $6b92
	call ClearFrameTasks ; $6b95
	ret ; $6b98
ReturnLobBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6b99
	inc a ; $6b9c
	ld [wBriefingAnimTimer], a ; $6b9d
	cp $78 ; $6ba0
	jp nc, ReturnLobBriefing_AdvanceAnim ; $6ba2
	ret ; $6ba5
ReturnLobBriefing_AdvanceAnim:
	xor a ; $6ba6
	ld [wBriefingAnimTimer], a ; $6ba7
	ld a, [wBriefingAnimStep] ; $6baa
	inc a ; $6bad
	and $03 ; $6bae
	ld [wBriefingAnimStep], a ; $6bb0
	sla a ; $6bb3
	sla a ; $6bb5
	ld c, a ; $6bb7
	ld_hl_indexed ReturnLobBriefing_AdvanceAnimTable ; $6bb8
	ld a, [hl] ; $6bbf
	inc hl ; $6bc0
	inc hl ; $6bc1
	ld b, [hl] ; $6bc2
	ld a, a ; $6bc3
	ld [wBriefingPlayerX], a ; $6bc4
	ld a, b ; $6bc7
	ld [wBriefingPlayerY], a ; $6bc8
	ld a, c ; $6bcb
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_OpponentPosTable ; $6bcc
	ld a, [hl] ; $6bd3
	inc hl ; $6bd4
	inc hl ; $6bd5
	ld b, [hl] ; $6bd6
	ld a, a ; $6bd7
	ld [wBriefingOpponentX], a ; $6bd8
	ld a, b ; $6bdb
	ld [wBriefingOpponentY], a ; $6bdc
	ld a, c ; $6bdf
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_BracketPosTable ; $6be0
	ld a, [hl] ; $6be7
	inc hl ; $6be8
	inc hl ; $6be9
	ld b, [hl] ; $6bea
	ld a, a ; $6beb
	ld [wBriefingBracketX], a ; $6bec
	ld a, b ; $6bef
	ld [wBriefingBracketY], a ; $6bf0
	ld a, c ; $6bf3
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_BallPosTable ; $6bf4
	ld a, [hl] ; $6bfb
	inc hl ; $6bfc
	inc hl ; $6bfd
	ld b, [hl] ; $6bfe
	ld a, a ; $6bff
	ld [wBriefingBallX], a ; $6c00
	ld a, b ; $6c03
	ld [wBriefingBallY], a ; $6c04
	ld a, [wBriefingAnimStep] ; $6c07
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6c0a
	ld a, [hl] ; $6c11
	ld [wBriefingHMarkerUnflipped], a ; $6c12
	ld a, c ; $6c15
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_HMarkerPosTable ; $6c16
	ld a, [hl] ; $6c1d
	inc hl ; $6c1e
	inc hl ; $6c1f
	ld b, [hl] ; $6c20
	ld a, a ; $6c21
	ld [wBriefingHMarkerX], a ; $6c22
	ld a, b ; $6c25
	ld [wBriefingHMarkerY], a ; $6c26
	ld a, [wBriefingAnimStep] ; $6c29
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable ; $6c2c
	ld a, [hl] ; $6c33
	ld [wBriefingRotMarkerDir], a ; $6c34
	ld a, c ; $6c37
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable ; $6c38
	ld a, [hl] ; $6c3f
	inc hl ; $6c40
	inc hl ; $6c41
	ld b, [hl] ; $6c42
	ld a, a ; $6c43
	ld [wBriefingRotMarkerX], a ; $6c44
	ld a, b ; $6c47
	ld [wBriefingRotMarkerY], a ; $6c48
	ld a, [wBriefingAnimStep] ; $6c4b
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_SwingFrameTable ; $6c4e
	ld a, [hl] ; $6c55
	ld [wBriefingSwingFrame], a ; $6c56
	ld a, c ; $6c59
	ld_hl_indexed ReturnLobBriefing_AdvanceAnim_SwingPosTable ; $6c5a
	ld a, [hl] ; $6c61
	inc hl ; $6c62
	inc hl ; $6c63
	ld b, [hl] ; $6c64
	ld a, a ; $6c65
	ld [wBriefingSwingX], a ; $6c66
	ld a, b ; $6c69
	ld [wBriefingSwingY], a ; $6c6a
	ret ; $6c6d
ReturnLobBriefing_AdvanceAnimTable:
	; $6c6e, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnLobBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6c7e, 16 bytes
ReturnLobBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_BallPosTable.asm" ; $6c8e, 16 bytes
ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6c9e, 4 bytes
ReturnLobBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6ca2, 16 bytes
ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_RotMarkerDirTable.bin" ; $6cb2, 4 bytes
ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_RotMarkerPosTable.bin" ; $6cb6, 16 bytes
ReturnLobBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_BracketPosTable.bin" ; $6cc6, 16 bytes
ReturnLobBriefing_AdvanceAnim_SwingFrameTable:
	INCBIN "data/bank_017/ReturnLobBriefing_AdvanceAnim_SwingFrameTable.bin" ; $6cd6, 4 bytes
ReturnLobBriefing_AdvanceAnim_SwingPosTable:
	INCLUDE "data/bank_017/ReturnLobBriefing_AdvanceAnim_SwingPosTable.asm" ; $6cda, 16 bytes
DrillBriefing_ReturnDownLine:
	ld a, $55 ; $6cea
	ld [wBriefingPlayerX], a ; $6cec
	ld a, $44 ; $6cef
	ld [wBriefingPlayerY], a ; $6cf1
	ld a, $01 ; $6cf4
	ld hl, DrawBriefingPlayerSprite ; $6cf6
	call RegisterFrameTask ; $6cf9
	ld a, $3a ; $6cfc
	ld [wBriefingOpponentX], a ; $6cfe
	ld a, $03 ; $6d01
	ld [wBriefingOpponentY], a ; $6d03
	ld a, $01 ; $6d06
	ld hl, DrawBriefingOpponentSprite ; $6d08
	call RegisterFrameTask ; $6d0b
	ld a, $54 ; $6d0e
	ld [wBriefingBallX], a ; $6d10
	ld a, $28 ; $6d13
	ld [wBriefingBallY], a ; $6d15
	ld a, $01 ; $6d18
	ld hl, DrawBriefingBallSprite ; $6d1a
	call RegisterFrameTask ; $6d1d
	ld a, $01 ; $6d20
	ld [wBriefingRotMarkerDir], a ; $6d22
	ld a, $4c ; $6d25
	ld [wBriefingRotMarkerX], a ; $6d27
	ld a, $16 ; $6d2a
	ld [wBriefingRotMarkerY], a ; $6d2c
	ld a, $01 ; $6d2f
	ld hl, DrawBriefingMarkerRotated ; $6d31
	call RegisterFrameTask ; $6d34
	ld hl, Text_37_9 ; $6d37
	call DrawBriefingCaption ; $6d3a
	call WaitForInputBlinking ; $6d3d
	call ClearFrameTasks ; $6d40
	ld a, $01 ; $6d43
	ld hl, UpdateAnimatedTilesTask_17 ; $6d45
	call RegisterFrameTask ; $6d48
	ld a, $03 ; $6d4b
	ld [wBriefingAnimStep], a ; $6d4d
	call ReturnDownLineBriefing_AdvanceAnim ; $6d50
	ld a, $01 ; $6d53
	ld hl, DrawBriefingPlayerSprite ; $6d55
	call RegisterFrameTask ; $6d58
	ld a, $01 ; $6d5b
	ld hl, DrawBriefingOpponentSprite ; $6d5d
	call RegisterFrameTask ; $6d60
	ld a, $01 ; $6d63
	ld hl, DrawBriefingBallSprite ; $6d65
	call RegisterFrameTask ; $6d68
	ld a, $01 ; $6d6b
	ld hl, DrawBriefingMarkerHFlip ; $6d6d
	call RegisterFrameTask ; $6d70
	ld a, $01 ; $6d73
	ld hl, DrawBriefingMarkerVFlip ; $6d75
	call RegisterFrameTask ; $6d78
	ld a, $00 ; $6d7b
	ld [wBriefingBracketWidth], a ; $6d7d
	ld a, $09 ; $6d80
	ld [wBriefingBracketHeight], a ; $6d82
	ld a, $01 ; $6d85
	ld hl, DrawBriefingTargetBrackets ; $6d87
	call RegisterFrameTask ; $6d8a
	ld hl, Text_37_10 ; $6d8d
	call DrawBriefingCaption ; $6d90
	call WaitForInputBlinking ; $6d93
	call ClearFrameTasks ; $6d96
	ld a, $01 ; $6d99
	ld hl, UpdateAnimatedTilesTask_17 ; $6d9b
	call RegisterFrameTask ; $6d9e
	ld a, $03 ; $6da1
	ld [wBriefingAnimStep], a ; $6da3
	call ReturnDownLineBriefing_AdvanceAnim ; $6da6
	ld a, $01 ; $6da9
	ld hl, DrawBriefingPlayerSprite ; $6dab
	call RegisterFrameTask ; $6dae
	ld a, $01 ; $6db1
	ld hl, DrawBriefingOpponentSprite ; $6db3
	call RegisterFrameTask ; $6db6
	ld a, $01 ; $6db9
	ld hl, DrawBriefingBallSprite ; $6dbb
	call RegisterFrameTask ; $6dbe
	ld a, $01 ; $6dc1
	ld hl, DrawBriefingMarkerHFlip ; $6dc3
	call RegisterFrameTask ; $6dc6
	ld a, $01 ; $6dc9
	ld hl, DrawBriefingMarkerVFlip ; $6dcb
	call RegisterFrameTask ; $6dce
	ld a, $00 ; $6dd1
	ld [wBriefingBracketWidth], a ; $6dd3
	ld a, $09 ; $6dd6
	ld [wBriefingBracketHeight], a ; $6dd8
	ld a, $01 ; $6ddb
	ld hl, DrawBriefingTargetBrackets ; $6ddd
	call RegisterFrameTask ; $6de0
	ld hl, Text_37_11 ; $6de3
	call DrawBriefingCaption ; $6de6
	xor a ; $6de9
	ld [wBriefingAnimTimer], a ; $6dea
	ld [wBriefingAnimStep], a ; $6ded
.loop:
	call ReturnDownLineBriefing_TickAnim ; $6df0
	ld c, $01 ; $6df3
	call AdvanceFrameCheckInput ; $6df5
	and a ; $6df8
	jp z, .loop ; $6df9
	call ClearFrameTasks ; $6dfc
	ret ; $6dff
ReturnDownLineBriefing_TickAnim:
	ld a, [wBriefingAnimTimer] ; $6e00
	inc a ; $6e03
	ld [wBriefingAnimTimer], a ; $6e04
	cp $78 ; $6e07
	jp nc, ReturnDownLineBriefing_AdvanceAnim ; $6e09
	ret ; $6e0c
ReturnDownLineBriefing_AdvanceAnim:
	xor a ; $6e0d
	ld [wBriefingAnimTimer], a ; $6e0e
	ld a, [wBriefingAnimStep] ; $6e11
	inc a ; $6e14
	and $03 ; $6e15
	ld [wBriefingAnimStep], a ; $6e17
	sla a ; $6e1a
	sla a ; $6e1c
	ld c, a ; $6e1e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnimTable ; $6e1f
	ld a, [hl] ; $6e26
	inc hl ; $6e27
	inc hl ; $6e28
	ld b, [hl] ; $6e29
	ld a, a ; $6e2a
	ld [wBriefingPlayerX], a ; $6e2b
	ld a, b ; $6e2e
	ld [wBriefingPlayerY], a ; $6e2f
	ld a, c ; $6e32
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable ; $6e33
	ld a, [hl] ; $6e3a
	inc hl ; $6e3b
	inc hl ; $6e3c
	ld b, [hl] ; $6e3d
	ld a, a ; $6e3e
	ld [wBriefingOpponentX], a ; $6e3f
	ld a, b ; $6e42
	ld [wBriefingOpponentY], a ; $6e43
	ld a, c ; $6e46
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_BracketPosTable ; $6e47
	ld a, [hl] ; $6e4e
	inc hl ; $6e4f
	inc hl ; $6e50
	ld b, [hl] ; $6e51
	ld a, a ; $6e52
	ld [wBriefingBracketX], a ; $6e53
	ld a, b ; $6e56
	ld [wBriefingBracketY], a ; $6e57
	ld a, c ; $6e5a
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_BallPosTable ; $6e5b
	ld a, [hl] ; $6e62
	inc hl ; $6e63
	inc hl ; $6e64
	ld b, [hl] ; $6e65
	ld a, a ; $6e66
	ld [wBriefingBallX], a ; $6e67
	ld a, b ; $6e6a
	ld [wBriefingBallY], a ; $6e6b
	ld a, [wBriefingAnimStep] ; $6e6e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable ; $6e71
	ld a, [hl] ; $6e78
	ld [wBriefingHMarkerUnflipped], a ; $6e79
	ld a, c ; $6e7c
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable ; $6e7d
	ld a, [hl] ; $6e84
	inc hl ; $6e85
	inc hl ; $6e86
	ld b, [hl] ; $6e87
	ld a, a ; $6e88
	ld [wBriefingHMarkerX], a ; $6e89
	ld a, b ; $6e8c
	ld [wBriefingHMarkerY], a ; $6e8d
	ld a, [wBriefingAnimStep] ; $6e90
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable ; $6e93
	ld a, [hl] ; $6e9a
	ld [wBriefingVMarkerUpright], a ; $6e9b
	ld a, c ; $6e9e
	ld_hl_indexed ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable ; $6e9f
	ld a, [hl] ; $6ea6
	inc hl ; $6ea7
	inc hl ; $6ea8
	ld b, [hl] ; $6ea9
	ld a, a ; $6eaa
	ld [wBriefingVMarkerX], a ; $6eab
	ld a, b ; $6eae
	ld [wBriefingVMarkerY], a ; $6eaf
	ret ; $6eb2
ReturnDownLineBriefing_AdvanceAnimTable:
	; $6eb3, 16 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable:
	INCLUDE "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_OpponentPosTable.asm" ; $6ec3, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_BallPosTable:
	INCLUDE "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_BallPosTable.asm" ; $6ed3, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_HMarkerUnflippedTable.bin" ; $6ee3, 4 bytes
ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_HMarkerPosTable.bin" ; $6ee7, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_VMarkerUprightTable.bin" ; $6ef7, 4 bytes
ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_VMarkerPosTable.bin" ; $6efb, 16 bytes
ReturnDownLineBriefing_AdvanceAnim_BracketPosTable:
	INCBIN "data/bank_017/ReturnDownLineBriefing_AdvanceAnim_BracketPosTable.bin" ; $6f0b, 16 bytes
ShowRulesScreen:
	push af ; $6f1b
	wram_bank $03 ; $6f1c
	pop af ; $6f22
	ld [wRulesPageListId], a ; $6f23
	ld a, [wMinigameLevel] ; $6f26
	ld [wRulesMinigameLevel], a ; $6f29
	xor a ; $6f2c
	ld [wRulesExitCode], a ; $6f2d
	ld [wRulesAnimEnabled], a ; $6f30
	ld [wRulesAnimCounter], a ; $6f33
	ld [wRulesIsMinigame], a ; $6f36
	ld [wRulesScreenAnimFrame], a ; $6f39
	ld c, $20 ; $6f3c
	call BeginFadeOut ; $6f3e
	call WaitFadeEnd ; $6f41
	call DisableLCDSafely ; $6f44
	call LoadRulesScreen ; $6f47
	ld a, $01 ; $6f4a
	ld [wAnimatedTileSet], a ; $6f4c
	ld a, $03 ; $6f4f
	ld [wAnimatedTilePeriod], a ; $6f51
	ld a, $01 ; $6f54
	ld hl, UpdateAnimatedTilesTask_17 ; $6f56
	call RegisterFrameTask ; $6f59
	call EnableLCD ; $6f5c
	script_fade_in $20 ; $6f5f
	call WaitFadeEnd ; $6f64
	wram_bank $03 ; $6f67
	ld a, $01 ; $6f6d
	ld hl, AdvanceRulesScreenAnimFrame ; $6f6f
	call RegisterFrameTask ; $6f72
	ld a, $01 ; $6f75
	ld [wRulesAnimEnabled], a ; $6f77
	xor a ; $6f7a
	ld [wRulesAnimCounter], a ; $6f7b
	call RunMinigameRulesPages ; $6f7e
	ld c, $20 ; $6f81
	call BeginFadeOut ; $6f83
	call WaitFadeEnd ; $6f86
	call ClearFrameTasks ; $6f89
	ld a, [wRulesExitCode] ; $6f8c
	ret ; $6f8f
	ret ; $6f90
RunMinigameRulesPages:
	push_wram_bank $03 ; $6f91
	ld a, [wSelectedMinigame] ; $6f9a
	inc a ; $6f9d
	inc a ; $6f9e
	farcall ReadMinigameRecord ; $6f9f
	wram_bank $07 ; $6fa2
	ld hl, wMinigameRecordValue ; $6fa8
	ld a, [hl+] ; $6fab
	ld h, [hl] ; $6fac
	ld l, a ; $6fad
	wram_bank $03 ; $6fae
	farcall PushTextArgNumber ; $6fb4
	ld a, [wSelectedMinigame] ; $6fb7
	ld hl, MinigameRulesTextIdBases_17 ; $6fba
	add a ; $6fbd
	add l ; $6fbe
	ld l, a ; $6fbf
	jr nc, .read ; $6fc0
	inc h ; $6fc2
.read:
	ld a, [hl+] ; $6fc3
	ld d, [hl] ; $6fc4
	ld e, a ; $6fc5
	ld hl, wRulesPageTextIdBase ; $6fc6
	ld a, e ; $6fc9
	ld [hl+], a ; $6fca
	ld [hl], d ; $6fcb
	ld hl, MinigameRulesPageLists_17 ; $6fcc
	ld a, [wRulesPageListId] ; $6fcf
	call MinigameRulesPageLoop ; $6fd2
	pop_wram_bank ; $6fd5
	ret ; $6fda
MinigameRulesTextIdBases_17:
	; $6fdb, 18 bytes (records:2)
	dw $2cc6 ; record 0
	dw $2cd0 ; record 1
	dw $2cda ; record 2
	dw $2ce2 ; record 3
	dw $2cef ; record 4
	dw $2cf6 ; record 5
	dw $3007 ; record 6
	dw $3017 ; record 7
	dw $3026 ; record 8
MinigameRulesPageLists_17:
	; $6fed, 174 bytes (rules_pages:6)
	rules_pages_stride 6
	rules_pages $00, $01, $02 ; list 0
	rules_pages $03, $04, $05 ; list 1
	rules_pages $06, $07, $88 ; list 2
	rules_pages $00, $01, $02 ; list 3
	rules_pages $03, $04, $05 ; list 4
	rules_pages $06, $07, $88 ; list 5
	rules_pages $00, $01 ; list 6
	rules_pages $02, $03 ; list 7
	rules_pages $04, $05, $86 ; list 8
	rules_pages $00, $01, $02, $03 ; list 9
	rules_pages $04, $05, $06, $07 ; list 10
	rules_pages $08, $09, $0a, $8b ; list 11
	rules_pages $00, $01 ; list 12
	rules_pages $02, $03 ; list 13
	rules_pages $04, $85 ; list 14
	rules_pages $00, $01, $02 ; list 15
	rules_pages $03, $04, $05 ; list 16
	rules_pages $06, $07, $88 ; list 17
	rules_pages $00, $01, $02, $03, $04 ; list 18
	rules_pages $05, $06, $07, $08, $09 ; list 19
	rules_pages $0a, $0b, $0c, $0d, $8e ; list 20
	rules_pages $00, $01, $02, $03, $04 ; list 21
	rules_pages $05, $06, $07, $08, $09 ; list 22
	rules_pages $0a, $0b, $0c, $8d ; list 23
	rules_pages $00, $01, $02, $03 ; list 24
	rules_pages $04, $05, $06, $07 ; list 25
	rules_pages $08, $09, $0a, $0b ; list 26
	rules_pages $1b ; list 27
	rules_pages $1c ; list 28
MinigameRulesPageLoop:
	add a ; $709b
	ld b, a ; $709c
	add a ; $709d
	add b ; $709e
	add l ; $709f
	ld l, a ; $70a0
	jr nc, .loop ; $70a1
	inc h ; $70a3
.loop:
	ld a, [hl+] ; $70a4
	cp $ff ; $70a5
	jp z, .playSfx3 ; $70a7
	push hl ; $70aa
	bit 7, a ; $70ab
	jr z, .step ; $70ad
	push af ; $70af
	ld d, a ; $70b0
	wram_bank $07 ; $70b1
	ld hl, wMinigameRecordValue ; $70b7
	ld a, [hl+] ; $70ba
	ld h, [hl] ; $70bb
	ld l, a ; $70bc
	wram_bank $03 ; $70bd
	ld a, h ; $70c3
	cp $27 ; $70c4
	jr nz, .restore ; $70c6
	ld a, l ; $70c8
	cp $0f ; $70c9
	jr nz, .restore ; $70cb
	pop bc ; $70cd
	ld a, d ; $70ce
	inc a ; $70cf
	jr .step ; $70d0
.restore:
	pop af ; $70d2
.step:
	and $7f ; $70d3
	pop hl ; $70d5
	push hl ; $70d6
	push af ; $70d7
	ld a, [hl] ; $70d8
	cp $ff ; $70d9
	jr z, .prepareRulesPageTilemap ; $70db
	ld a, $01 ; $70dd
	ld hl, DrawRulesNextPageArrow ; $70df
	call RegisterFrameTask ; $70e2
.prepareRulesPageTilemap:
	call PrepareRulesPageTilemap ; $70e5
	ld hl, wRulesPageTextIdBase ; $70e8
	ld a, [hl+] ; $70eb
	ld h, [hl] ; $70ec
	ld l, a ; $70ed
	pop af ; $70ee
	add l ; $70ef
	ld l, a ; $70f0
	jr nc, .prepareGlyphBuffer ; $70f1
	inc h ; $70f3
.prepareGlyphBuffer:
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $70f4
	ld c, $20 ; $70f7
	farcall PrepareGlyphBuffer ; $70f9
	ld c, $10 ; $70fc
	farcall RenderProportionalTextAt ; $70fe
	farcall UploadGlyphBuffer ; $7101
	call QueueRulesPageToVRAM ; $7104
.loopB:
	call AdvanceFrame ; $7107
	ldh a, [hInputRisingEdge] ; $710a
	bit PADB_A, a ; $710c
	jr nz, .playSfx ; $710e
	bit 7, a ; $7110
	jr nz, .playSfx ; $7112
	bit 1, a ; $7114
	jr nz, .playSfx2 ; $7116
	bit 3, a ; $7118
	jr nz, .restore2 ; $711a
	jr .loopB ; $711c
.playSfx:
	sound SFX_MENU_SELECT ; $711e
	ld hl, DrawRulesNextPageArrow ; $7120
	call UnregisterFrameTask ; $7123
	ld hl, RulesScreenTiles ; $7126
	call UnregisterFrameTask ; $7129
	ld a, $01 ; $712c
	ld [wRulesAnimEnabled], a ; $712e
	ld [wRulesIsMinigame], a ; $7131
	xor a ; $7134
	ld [wRulesAnimCounter], a ; $7135
	pop hl ; $7138
	jp .loop ; $7139
.playSfx2:
	sound SFX_MENU_CANCEL ; $713c
	ld hl, DrawRulesNextPageArrow ; $713e
	call UnregisterFrameTask ; $7141
	ld hl, RulesScreenTiles ; $7144
	call UnregisterFrameTask ; $7147
	ld a, $ff ; $714a
	ld [wRulesExitCode], a ; $714c
	pop hl ; $714f
.playSfx3:
	sound SFX_MENU_DECIDE ; $7150
	ret ; $7152
.restore2:
	pop hl ; $7153
	sound SFX_MENU_DECIDE ; $7154
	ret ; $7156
LoadRulesScreen:
	call LoadRulesBorderAnimTiles ; $7157
	farcall LoadMenuFontGfx ; $715a
	ld c, SCREENASSET_RulesScreen ; $715d
	farcall LoadScreenAssetRecord ; $715f
	ldh a, [hWramBank] ; $7162
	push af ; $7164
	farcall InitTextWindows ; $7165
	wram_bank $05 ; $7168
	ld a, $03 ; $716e
	ld [wShadowTilemapBank], a ; $7170
	ld a, $00 ; $7173
	ld [wWindowTileAttr], a ; $7175
	pop_wram_bank ; $7178
	farcall PrepareGlyphBuffer ; $717d
	call ClearRulesScreenTextArea ; $7180
	ld hl, RulesScreenPalette ; $7183
	lb de, $09, $02 ; $7186 palette index, count
	call LoadPalettesImmediate ; $7189
	ld de, vTiles0 + VRAM_BANK1 ; $718c
	farcall LoadMenuArrowSpriteTiles ; $718f
	ld b, $08 ; $7192
	ld c, $0f ; $7194
	farcall LoadIndexedPalette ; $7196
	ld b, TILEBLOCK_SharedMenuGfx17Alias17 ; $7199
	ld c, SharedMenuGfx17_SIZE / 16 ; $719b
	ld de, vTiles2 ; $719d
	farcall LoadCompressedTileBlock ; $71a0
	ld a, $03 ; $71a3
	ld [wShadowTilemapBank], a ; $71a5
	ld hl, wShadowTilemapPtr ; $71a8
	ld de, wDecompBuffer ; $71ab
	ld a, e ; $71ae
	ld [hl+], a ; $71af
	ld [hl], d ; $71b0
	ld a, $01 ; $71b1
	ld hl, DrawRulesScreenCharacters ; $71b3
	call RegisterFrameTask ; $71b6
	farcall QueueWram3MapToVRAM ; $71b9
	ret ; $71bc
ClearRulesScreenTextArea:
	push_wram_bank $03 ; $71bd
	ld de, wShadowAttrmap + 3 * TILEMAP_WIDTH + 2 ; $71c6
	ld b, $10 ; $71c9
	ld c, $0e ; $71cb
	ld h, $00 ; $71cd
	farcall FillTilemapRect ; $71cf
	call ClearRulesPageRows ; $71d2
	pop_wram_bank ; $71d5
	ret ; $71da
ClearRulesPageRows:
	push_wram_bank $03 ; $71db
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 2 ; $71e4
	ld b, $10 ; $71e7
	ld c, $01 ; $71e9
	ld h, $03 ; $71eb
	farcall FillTilemapRect ; $71ed
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $71f0
	ld b, $10 ; $71f3
	ld c, $0d ; $71f5
	ld h, $20 ; $71f7
	farcall FillTilemapRect ; $71f9
	pop_wram_bank ; $71fc
	ret ; $7201
PrepareRulesPageTilemap:
	push_wram_bank $03 ; $7202
	ld de, wShadowTilemap + 3 * TILEMAP_WIDTH + 2 ; $720b
	ld b, $10 ; $720e
	ld c, $01 ; $7210
	ld h, $03 ; $7212
	farcall FillTilemapRect ; $7214
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 2 ; $7217
	ld b, $10 ; $721a
	ld c, $0d ; $721c
	ld h, $20 ; $721e
	farcall FillTilemapRect ; $7220
	ld a, [wRulesIsMinigame] ; $7223
	or a ; $7226
	jr nz, .nonZero ; $7227
	ld a, [wRulesMinigameLevel] ; $7229
	add $03 ; $722c
	ld h, a ; $722e
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $722f
	ld b, $10 ; $7232
	ld c, $01 ; $7234
	farcall FillTilemapRect ; $7236
	jr .restore ; $7239
.nonZero:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $723b
	ld b, $10 ; $723e
	ld c, $01 ; $7240
	ld h, $00 ; $7242
	farcall FillTilemapRect ; $7244
.restore:
	pop_wram_bank ; $7247
	ret ; $724c
QueueRulesPageToVRAM:
	ld a, [wRulesIsMinigame] ; $724d
	or a ; $7250
	jr nz, .nonZero ; $7251
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $7253
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $7256
	ld c, $0a ; $7259
	call QueueVRAMCopy ; $725b
	jr .queueVRAMCopy ; $725e
.nonZero:
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $7260
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $7263
	ld c, $0a ; $7266
	call QueueVRAMCopy ; $7268
.queueVRAMCopy:
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $726b
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $726e
	ld c, $02 ; $7271
	call QueueVRAMCopy ; $7273
	call AdvanceFrame ; $7276
	ld hl, wShadowTilemap + 8 * TILEMAP_WIDTH ; $7279
	ld de, vBGMap0 + 8 * TILEMAP_WIDTH ; $727c
	ld c, $0a ; $727f
	call QueueVRAMCopy ; $7281
	call AdvanceFrame ; $7284
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $7287
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH ; $728a
	ld c, $08 ; $728d
	call QueueVRAMCopy ; $728f
	ret ; $7292
LoadRulesBorderAnimTiles:
	wram_bank $01 ; $7293
	ld hl, RulesBorderAnimTiles0 ; $7299
	ld de, wDecompBuffer ; $729c
	call DecompressData ; $729f
	ld hl, wDecompBuffer ; $72a2
	ld de, vTiles0 ; $72a5
	ld bc, $0012 ; $72a8
	call QueueVRAMCopy ; $72ab
	ld hl, wDecompBuffer ; $72ae
	ld de, vTiles0 + $24 * TILE_SIZE ; $72b1
	ld bc, $0012 ; $72b4
	call QueueVRAMCopy ; $72b7
	ld hl, wDecompBuffer ; $72ba
	ld de, vTiles0 + $48 * TILE_SIZE ; $72bd
	ld bc, $0012 ; $72c0
	call QueueVRAMCopy ; $72c3
	ld hl, wDecompBuffer ; $72c6
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $72c9
	ld bc, $0012 ; $72cc
	call QueueVRAMCopy ; $72cf
	ld hl, wDecompBuffer ; $72d2
	ld de, vTiles0 + $34 * TILE_SIZE + VRAM_BANK1 ; $72d5
	ld bc, $0012 ; $72d8
	call QueueVRAMCopy ; $72db
	ld hl, wDecompBuffer ; $72de
	ld de, vTiles0 + $58 * TILE_SIZE + VRAM_BANK1 ; $72e1
	ld bc, $0012 ; $72e4
	call QueueVRAMCopy ; $72e7
	ld hl, RulesBorderAnimTiles1 ; $72ea
	ld de, wDecompBuffer ; $72ed
	call DecompressData ; $72f0
	ld hl, wDecompBuffer ; $72f3
	ld de, vTiles0 + $4a * TILE_SIZE ; $72f6
	ld bc, $0002 ; $72f9
	call QueueVRAMCopy ; $72fc
	ld hl, wDecompBuffer ; $72ff
	ld de, vTiles0 + $12 * TILE_SIZE + VRAM_BANK1 ; $7302
	ld bc, $0002 ; $7305
	call QueueVRAMCopy ; $7308
	ld hl, wDecompBuffer ; $730b
	ld de, vTiles0 + $36 * TILE_SIZE + VRAM_BANK1 ; $730e
	ld bc, $0002 ; $7311
	call QueueVRAMCopy ; $7314
	ld hl, wDecompBuffer ; $7317
	ld de, vTiles0 + $5a * TILE_SIZE + VRAM_BANK1 ; $731a
	ld bc, $0002 ; $731d
	call QueueVRAMCopy ; $7320
	ld hl, RulesBorderAnimTiles2 ; $7323
	ld de, wDecompBuffer ; $7326
	call DecompressData ; $7329
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $732c
	ld de, vTiles0 + $2c * TILE_SIZE ; $732f
	ld bc, $0001 ; $7332
	call QueueVRAMCopy ; $7335
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $7338
	ld de, vTiles0 + $18 * TILE_SIZE + VRAM_BANK1 ; $733b
	ld bc, $0001 ; $733e
	call QueueVRAMCopy ; $7341
	ld hl, wDecompBuffer ; $7344
	ld de, vTiles0 + $3c * TILE_SIZE + VRAM_BANK1 ; $7347
	ld bc, $0001 ; $734a
	call QueueVRAMCopy ; $734d
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $7350
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $7353
	ld bc, $0001 ; $7356
	call QueueVRAMCopy ; $7359
	ld hl, RulesBorderAnimTiles3 ; $735c
	ld de, wDecompBuffer ; $735f
	call DecompressData ; $7362
	ld hl, wDecompBuffer ; $7365
	ld de, vTiles0 + $12 * TILE_SIZE ; $7368
	ld bc, $0012 ; $736b
	call QueueVRAMCopy ; $736e
	ld hl, wDecompBuffer ; $7371
	ld de, vTiles0 + $36 * TILE_SIZE ; $7374
	ld bc, $0012 ; $7377
	call QueueVRAMCopy ; $737a
	ld hl, wDecompBuffer ; $737d
	ld de, vTiles0 + $5a * TILE_SIZE ; $7380
	ld bc, $0012 ; $7383
	call QueueVRAMCopy ; $7386
	ld hl, wDecompBuffer ; $7389
	ld de, vTiles0 + $22 * TILE_SIZE + VRAM_BANK1 ; $738c
	ld bc, $0012 ; $738f
	call QueueVRAMCopy ; $7392
	ld hl, wDecompBuffer ; $7395
	ld de, vTiles0 + $46 * TILE_SIZE + VRAM_BANK1 ; $7398
	ld bc, $0012 ; $739b
	call QueueVRAMCopy ; $739e
	ld hl, wDecompBuffer ; $73a1
	ld de, vTiles0 + $6a * TILE_SIZE + VRAM_BANK1 ; $73a4
	ld bc, $0012 ; $73a7
	call QueueVRAMCopy ; $73aa
	ld hl, RulesBorderAnimTiles4 ; $73ad
	ld de, wDecompBuffer ; $73b0
	call DecompressData ; $73b3
	ld hl, wDecompBuffer ; $73b6
	ld de, vTiles0 + $5c * TILE_SIZE ; $73b9
	ld bc, $0002 ; $73bc
	call QueueVRAMCopy ; $73bf
	ld hl, wDecompBuffer ; $73c2
	ld de, vTiles0 + $24 * TILE_SIZE + VRAM_BANK1 ; $73c5
	ld bc, $0002 ; $73c8
	call QueueVRAMCopy ; $73cb
	ld hl, wDecompBuffer ; $73ce
	ld de, vTiles0 + $48 * TILE_SIZE + VRAM_BANK1 ; $73d1
	ld bc, $0002 ; $73d4
	call QueueVRAMCopy ; $73d7
	ld hl, wDecompBuffer ; $73da
	ld de, vTiles0 + $6c * TILE_SIZE + VRAM_BANK1 ; $73dd
	ld bc, $0002 ; $73e0
	call QueueVRAMCopy ; $73e3
	ld hl, RulesBorderAnimTiles5 ; $73e6
	ld de, wDecompBuffer ; $73e9
	call DecompressData ; $73ec
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $73ef
	ld de, vTiles0 + $3e * TILE_SIZE ; $73f2
	ld bc, $0001 ; $73f5
	call QueueVRAMCopy ; $73f8
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $73fb
	ld de, vTiles0 + $2a * TILE_SIZE + VRAM_BANK1 ; $73fe
	ld bc, $0001 ; $7401
	call QueueVRAMCopy ; $7404
	ld hl, wDecompBuffer ; $7407
	ld de, vTiles0 + $4e * TILE_SIZE + VRAM_BANK1 ; $740a
	ld bc, $0001 ; $740d
	call QueueVRAMCopy ; $7410
	ld hl, wDecompBuffer + 4 * TILE_SIZE ; $7413
	ld de, vTiles0 + $72 * TILE_SIZE + VRAM_BANK1 ; $7416
	ld bc, $0001 ; $7419
	call QueueVRAMCopy ; $741c
	ret ; $741f
AdvanceRulesScreenAnimFrame:
	push_wram_bank $03 ; $7420
	ld a, [wRulesAnimCounter] ; $7429
	inc a ; $742c
	ld [wRulesAnimCounter], a ; $742d
	ld a, [wRulesAnimEnabled] ; $7430
	or a ; $7433
	jr z, .zero ; $7434
	ldh a, [hVBlankCounter] ; $7436
	srl a ; $7438
	srl a ; $743a
	srl a ; $743c
	and $3f ; $743e
	ld hl, RulesScreenAnimFrameTable1 ; $7440
	add l ; $7443
	ld l, a ; $7444
	jr nc, .read ; $7445
	inc h ; $7447
.read:
	ld a, [hl] ; $7448
	ld [wRulesScreenAnimFrame], a ; $7449
	jr .step2 ; $744c
.zero:
	ldh a, [hVBlankCounter] ; $744e
	srl a ; $7450
	srl a ; $7452
	srl a ; $7454
	srl a ; $7456
	and $1f ; $7458
	ld hl, RulesScreenAnimFrameTable ; $745a
	add l ; $745d
	ld l, a ; $745e
	jr nc, .readB ; $745f
	inc h ; $7461
.readB:
	ld a, [hl] ; $7462
	ld [wRulesScreenAnimFrame], a ; $7463
	jr .step2 ; $7466
.step2:
	ld a, [wRulesAnimEnabled] ; $7468
	or a ; $746b
	jr z, .restore ; $746c
	ld a, [wRulesAnimCounter] ; $746e
	cp $ff ; $7471
	jr nz, .restore ; $7473
	xor a ; $7475
	ld [wRulesAnimEnabled], a ; $7476
.restore:
	pop_wram_bank ; $7479
	ret ; $747e
RulesScreenAnimFrameTable:
	; $747f, 32 bytes (records:2)
	dw $0100 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0001 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0100 ; record 7
	dw $0000 ; record 8
	dw $0000 ; record 9
	dw $0000 ; record 10
	dw $0001 ; record 11
	dw $0100 ; record 12
	dw $0000 ; record 13
	dw $0001 ; record 14
	dw $0000 ; record 15
RulesScreenAnimFrameTable1:
	; $749f, 60 bytes (records:2)
	dw $0402 ; record 0
	dw $0404 ; record 1
	dw $0502 ; record 2
	dw $0402 ; record 3
	dw $0202 ; record 4
	dw $0302 ; record 5
	dw $0402 ; record 6
	dw $0402 ; record 7
	dw $0304 ; record 8
	dw $0204 ; record 9
	dw $0204 ; record 10
	dw $0404 ; record 11
	dw $0402 ; record 12
	dw $0402 ; record 13
	dw $0402 ; record 14
	dw $0402 ; record 15
	dw $0402 ; record 16
	dw $0402 ; record 17
	dw $0402 ; record 18
	dw $0202 ; record 19
	dw $0304 ; record 20
	dw $0204 ; record 21
	dw $0204 ; record 22
	dw $0204 ; record 23
	dw $0402 ; record 24
	dw $0402 ; record 25
	dw $0402 ; record 26
	dw $0202 ; record 27
	dw $0302 ; record 28
	dw $0402 ; record 29
DrawRulesScreenCharacters:
	push_wram_bank $03 ; $74db
	ld a, [wRulesScreenAnimFrame] ; $74e4
	ld hl, RulesScreenCharactersTable0 ; $74e7
	add l ; $74ea
	ld l, a ; $74eb
	jr nc, .read ; $74ec
	inc h ; $74ee
.read:
	ld a, [hl] ; $74ef
	ld c, a ; $74f0
	push bc ; $74f1
	ld a, [wRulesScreenAnimFrame] ; $74f2
	ld hl, RulesScreenCharactersTable1 ; $74f5
	add l ; $74f8
	ld l, a ; $74f9
	jr nc, .readB ; $74fa
	inc h ; $74fc
.readB:
	ld b, [hl] ; $74fd
	lb de, $7e, $68 ; $74fe x, y
	ld hl, DrawRulesScreenCharacters_SpriteTemplate ; $7501
	call QueueSpriteTemplate ; $7504
	pop bc ; $7507
	ld a, $12 ; $7508
	add c ; $750a
	ld c, a ; $750b
	ld a, [wRulesScreenAnimFrame] ; $750c
	ld hl, RulesScreenCharactersTable2 ; $750f
	add l ; $7512
	ld l, a ; $7513
	jr nc, .read2 ; $7514
	inc h ; $7516
.read2:
	ld b, [hl] ; $7517
	lb de, $7e, $68 ; $7518 x, y
	ld hl, DrawRulesScreenCharacters_SpriteTemplate ; $751b
	call QueueSpriteTemplate ; $751e
	pop_wram_bank ; $7521
	ret ; $7526
DrawRulesScreenCharacters_SpriteTemplate:
	; $7527, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $30, $08, $04, $00
	oam_sprite $10, $10, $06, $00
	oam_sprite $20, $10, $08, $00
	oam_sprite $30, $10, $0a, $00
	oam_sprite $10, $18, $0c, $00
	oam_sprite $20, $18, $0e, $00
	oam_sprite $30, $18, $10, $00
	oam_sprite_end
RulesScreenCharactersTable0:
	; $754c, 6 bytes (bytes:6)
	db $00, $24, $48, $10, $34, $58 ; 0x00
RulesScreenCharactersTable1:
	; $7552, 6 bytes (bytes:6)
	db $01, $01, $01, $09, $09, $09 ; 0x00
RulesScreenCharactersTable2:
	; $7558, 6 bytes (bytes:6)
	db $02, $02, $02, $0a, $0a, $0a ; 0x00
DrawRulesNextPageArrow:
	ld de, $7888 ; $755e
	ld c, $00 ; $7561
	call ApplySpriteWobbleY_17 ; $7563
	ld b, $08 ; $7566
	ld c, $00 ; $7568
	ld h, $03 ; $756a
	farcall QueueStackedSpritePair ; $756c
	ret ; $756f
RulesScreenTiles:
	INCBIN "data/bank_017/lz_RulesScreenTiles.bin" ; $7570, 512 bytes
RulesScreenTilemap:
	INCBIN "data/bank_017/lz_RulesScreenTilemap.bin" ; $7770, 309 bytes
RulesScreenAttrmap:
	INCBIN "data/bank_017/lz_RulesScreenAttrmap.bin" ; $78a5, 87 bytes
RulesScreenPalettes:
	INCLUDE "data/bank_017/RulesScreenPalettes.asm" ; $78fc, 64 bytes (palettes)
RulesBorderAnimTiles0:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles0.bin" ; $793c, 204 bytes
RulesBorderAnimTiles1:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles1.bin" ; $7a08, 39 bytes
RulesBorderAnimTiles2:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles2.bin" ; $7a2f, 39 bytes
RulesBorderAnimTiles3:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles3.bin" ; $7a56, 162 bytes
RulesBorderAnimTiles4:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles4.bin" ; $7af8, 32 bytes
RulesBorderAnimTiles5:
	INCBIN "data/bank_017/lz_RulesBorderAnimTiles5.bin" ; $7b18, 33 bytes
RulesScreenPalette:
	INCLUDE "data/bank_017/RulesScreenPalette.asm" ; $7b39, 64 bytes (palettes)
	; $7b79, 1159 bytes fill to bank end (linker-padded)
