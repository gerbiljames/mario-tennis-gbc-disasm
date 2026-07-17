SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

DataPtr_StoryCmdHandlersA_13:
	dw StoryCmdHandlersA_13 ; $4000
DataPtr_StoryCmdHandlersB_13:
	dw StoryCmdHandlersB_13 ; $4002
DataPtr_StoryCmdHandlersD_13:
	dw StoryCmdHandlersD_13 ; $4004
StoryCmdHandlersA_13:
	; $4006, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $401e ; record 0
	dw $4236 ; record 1
	dw $4014 ; record 2
	dw $428b ; record 3
	dw $4294 ; record 4
	dw $42b5 ; record 5
	dw $44df ; record 6
	nop ; $4014
	nop ; $4015
	nop ; $4016
	nop ; $4017
	nop ; $4018
	nop ; $4019
	nop ; $401a
	nop ; $401b
	nop ; $401c
	rst Rst38 ; $401d
	ld bc, $0040 ; $401e
	rlca ; $4021
	ld b, b ; $4022
	ld [$40eb], sp ; $4023
	ld [bc], a ; $4026
	ld b, b ; $4027
	nop ; $4028
	dec d ; $4029
	ld b, b ; $402a
	add hl, bc ; $402b
	ld h, e ; $402c
	ld b, c ; $402d
	inc bc ; $402e
	ld b, b ; $402f
	nop ; $4030
	dec h ; $4031
	ld b, b ; $4032
	ld [$41cf], sp ; $4033
	inc b ; $4036
	ret nz ; $4037
	nop ; $4038
	ld [hl-], a ; $4039
	nop ; $403a
	rrca ; $403b
	ld e, a ; $403c
	ld b, b ; $403d
	dec b ; $403e
	ld b, b ; $403f
	nop ; $4040
	scf ; $4041
	ld b, b ; $4042
	ld [$41cf], sp ; $4043
	ld b, $80 ; $4046
	nop ; $4048
	inc a ; $4049
	nop ; $404a
	dec c ; $404b
	and a, l ; $404c
	ld b, b ; $404d
	ld c, $80 ; $404e
	nop ; $4050
	dec sp ; $4051
	nop ; $4052
	rrca ; $4053
	nop ; $4054
	nop ; $4055
	rrca ; $4056
	add a, b ; $4057
	nop ; $4058
	ld [hl-], a ; $4059
	nop ; $405a
	rrca ; $405b
	nop ; $405c
	nop ; $405d
	rst Rst38 ; $405e
	ld a, [$c295] ; $405f
	cp a, $ff ; $4062
	jp z, Label_13_40a4 ; $4064
	test_flag $05, 7 ; $4067
	jr z, Label_13_4092 ; $406a
	ld a, $02 ; $406c
	ld bc, $00ff ; $406e
	farcall FarPtr_0a_18 ; $4071
	ld a, $02 ; $4074
	ld b, $40 ; $4076
	ld de, $0200 ; $4078
	farcall FarPtr_MoveActorByAngle ; $407b
	ld a, $02 ; $407e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4080
	ld a, $02 ; $4083
	ld b, $c0 ; $4085
	farcall FarPtr_SetActorFacing ; $4087
	ld a, $02 ; $408a
	ld bc, $0010 ; $408c
	farcall FarPtr_0a_18 ; $408f
Label_13_4092:
	ld a, $00 ; $4092
	ld bc, $0010 ; $4094
	farcall FarPtr_0a_18 ; $4097
	ld a, $00 ; $409a
	ld b, $c0 ; $409c
	ld de, $0200 ; $409e
	farcall FarPtr_MoveActorByAngle ; $40a1
Label_13_40a4:
	ret ; $40a4
	ld a, [$c295] ; $40a5
	cp a, $ff ; $40a8
	jp z, Label_13_40ea ; $40aa
	test_flag $05, 7 ; $40ad
	jr z, Label_13_40d8 ; $40b0
	ld a, $02 ; $40b2
	ld bc, $00ff ; $40b4
	farcall FarPtr_0a_18 ; $40b7
	ld a, $02 ; $40ba
	ld b, $00 ; $40bc
	ld de, $0200 ; $40be
	farcall FarPtr_MoveActorByAngle ; $40c1
	ld a, $02 ; $40c4
	farcall FarPtr_ScriptWaitActorMoveDone ; $40c6
	ld a, $02 ; $40c9
	ld b, $80 ; $40cb
	farcall FarPtr_SetActorFacing ; $40cd
	ld a, $02 ; $40d0
	ld bc, $0010 ; $40d2
	farcall FarPtr_0a_18 ; $40d5
Label_13_40d8:
	ld a, $00 ; $40d8
	ld bc, $0010 ; $40da
	farcall FarPtr_0a_18 ; $40dd
	ld a, $00 ; $40e0
	ld b, $80 ; $40e2
	ld de, $0200 ; $40e4
	farcall FarPtr_MoveActorByAngle ; $40e7
Label_13_40ea:
	ret ; $40ea
	ld a, [$c295] ; $40eb
	cp a, $ff ; $40ee
	jp z, Label_13_4235 ; $40f0
	ld a, $00 ; $40f3
	ld bc, $0018 ; $40f5
	farcall FarPtr_0a_18 ; $40f8
	ld a, $00 ; $40fb
	ld d, $08 ; $40fd
	farcall FarPtr_ScriptSetActorAnimation ; $40ff
	ld a, $02 ; $4102
	ld bc, $0018 ; $4104
	farcall FarPtr_0a_18 ; $4107
	ld a, $02 ; $410a
	ld d, $08 ; $410c
	farcall FarPtr_ScriptSetActorAnimation ; $410e
	ld c, $08 ; $4111
	call BeginFadeIn ; $4113
	push af ; $4116
	ld a, $14 ; $4117
	farcall FarPtr_WaitScriptFrames ; $4119
	pop af ; $411c
	ld a, $00 ; $411d
	ld bc, $0700 ; $411f
	ld de, $0c80 ; $4122
	farcall FarPtr_ScriptSetActorMoveTarget ; $4125
	push af ; $4128
	ld a, $14 ; $4129
	farcall FarPtr_WaitScriptFrames ; $412b
	pop af ; $412e
	ld a, $02 ; $412f
	ld bc, $0700 ; $4131
	ld de, $0b00 ; $4134
	farcall FarPtr_ScriptSetActorMoveTarget ; $4137
	push af ; $413a
	ld a, $14 ; $413b
	farcall FarPtr_WaitScriptFrames ; $413d
	pop af ; $4140
	ld a, $00 ; $4141
	ld d, $01 ; $4143
	farcall FarPtr_ScriptSetActorAnimation ; $4145
	push af ; $4148
	ld a, $0a ; $4149
	farcall FarPtr_WaitScriptFrames ; $414b
	pop af ; $414e
	ld a, $02 ; $414f
	ld d, $01 ; $4151
	farcall FarPtr_ScriptSetActorAnimation ; $4153
	ld a, $00 ; $4156
	farcall FarPtr_ScriptWaitActorMoveDone ; $4158
	ld a, $00 ; $415b
	ld b, $00 ; $415d
	farcall FarPtr_SetActorFacing ; $415f
	ret ; $4162
	ld a, [$c295] ; $4163
	cp a, $ff ; $4166
	jp z, Label_13_4235 ; $4168
	ld b, $14 ; $416b
	ld c, $08 ; $416d
	ld d, $06 ; $416f
	ld e, $15 ; $4171
	ld h, $02 ; $4173
	ld l, $02 ; $4175
	farcall FarPtr_0a_7e ; $4177
	ld b, $04 ; $417a
	ld c, $15 ; $417c
	ld d, $14 ; $417e
	ld e, $08 ; $4180
	ld h, $02 ; $4182
	ld l, $02 ; $4184
	farcall FarPtr_0a_7e ; $4186
	ld a, $00 ; $4189
	ld bc, $0018 ; $418b
	farcall FarPtr_0a_18 ; $418e
	ld c, $08 ; $4191
	call BeginFadeIn ; $4193
	call WaitFadeEnd ; $4196
	push af ; $4199
	ld a, $05 ; $419a
	farcall FarPtr_WaitScriptFrames ; $419c
	pop af ; $419f
	sound $50 ; $41a0
	push af ; $41a2
	ld a, $05 ; $41a3
	farcall FarPtr_WaitScriptFrames ; $41a5
	pop af ; $41a8
	ld a, $00 ; $41a9
	ld bc, $1500 ; $41ab
	ld de, $0d00 ; $41ae
	farcall FarPtr_ScriptSetActorMoveTarget ; $41b1
	ld a, $02 ; $41b4
	ld bc, $1500 ; $41b6
	ld de, $0b00 ; $41b9
	farcall FarPtr_ScriptSetActorMoveTarget ; $41bc
	test_flag $05, 7 ; $41bf
	jr z, Label_13_41cb ; $41c2
	push af ; $41c4
	ld a, $0c ; $41c5
	farcall FarPtr_WaitScriptFrames ; $41c7
	pop af ; $41ca
Label_13_41cb:
	call Func_13_4dcc ; $41cb
	ret ; $41ce
	ld a, [$c295] ; $41cf
	cp a, $ff ; $41d2
	jr z, Label_13_4235 ; $41d4
	ld a, $00 ; $41d6
	ld bc, $000c ; $41d8
	farcall FarPtr_0a_18 ; $41db
	ld a, $00 ; $41de
	ld d, $08 ; $41e0
	farcall FarPtr_ScriptSetActorAnimation ; $41e2
	ld a, $02 ; $41e5
	ld bc, $000c ; $41e7
	farcall FarPtr_0a_18 ; $41ea
	ld a, $02 ; $41ed
	ld d, $08 ; $41ef
	farcall FarPtr_ScriptSetActorAnimation ; $41f1
	ld c, $08 ; $41f4
	call BeginFadeIn ; $41f6
	push af ; $41f9
	ld a, $0a ; $41fa
	farcall FarPtr_WaitScriptFrames ; $41fc
	pop af ; $41ff
	ld a, $00 ; $4200
	ld b, $40 ; $4202
	ld de, $0500 ; $4204
	farcall FarPtr_MoveActorByAngle ; $4207
	push af ; $420a
	ld a, $28 ; $420b
	farcall FarPtr_WaitScriptFrames ; $420d
	pop af ; $4210
	ld a, $02 ; $4211
	ld b, $40 ; $4213
	ld de, $0400 ; $4215
	farcall FarPtr_MoveActorByAngle ; $4218
	ld a, $00 ; $421b
	ld d, $01 ; $421d
	farcall FarPtr_ScriptSetActorAnimation ; $421f
	push af ; $4222
	ld a, $10 ; $4223
	farcall FarPtr_WaitScriptFrames ; $4225
	pop af ; $4228
	ld a, $02 ; $4229
	ld d, $01 ; $422b
	farcall FarPtr_ScriptSetActorAnimation ; $422d
	ld a, $00 ; $4230
	farcall FarPtr_ScriptWaitActorMoveDone ; $4232
Label_13_4235:
	ret ; $4235
	ld bc, $00ff ; $4236
	nop ; $4239
	ld c, l ; $423a
	ld a, e ; $423b
	add hl, bc ; $423c
	ld bc, rSC ; $423d
	nop ; $4240
	nop ; $4241
	ld c, l ; $4242
	ld a, e ; $4243
	dec c ; $4244
	ld bc, $ff03 ; $4245
	nop ; $4248
	nop ; $4249
	ld c, l ; $424a
	ld a, e ; $424b
	INCBIN "data/bank_013/d_424c.bin" ; $424c, 63 bytes
	inc bc ; $428b
	rst Rst38 ; $428c
	nop ; $428d
	nop ; $428e
	scf ; $428f
	inc d ; $4290
	nop ; $4291
	nop ; $4292
	rst Rst38 ; $4293
	ld bc, $00ff ; $4294
	nop ; $4297
	ld b, [hl] ; $4298
	inc b ; $4299
	nop ; $429a
	nop ; $429b
	ld [bc], a ; $429c
	rst Rst38 ; $429d
	nop ; $429e
	nop ; $429f
	ld b, a ; $42a0
	inc b ; $42a1
	nop ; $42a2
	nop ; $42a3
	inc bc ; $42a4
	rst Rst38 ; $42a5
	nop ; $42a6
	nop ; $42a7
	ld c, b ; $42a8
	inc b ; $42a9
	nop ; $42aa
	nop ; $42ab
	inc b ; $42ac
	rst Rst38 ; $42ad
	nop ; $42ae
	nop ; $42af
	ld c, c ; $42b0
	inc b ; $42b1
	nop ; $42b2
	nop ; $42b3
	rst Rst38 ; $42b4
	ld bc, $00ff ; $42b5
	nop ; $42b8
	sbc a, $42 ; $42b9
	nop ; $42bb
	nop ; $42bc
	ld [bc], a ; $42bd
	rst Rst38 ; $42be
	nop ; $42bf
	nop ; $42c0
	inc c ; $42c1
	ld b, e ; $42c2
	nop ; $42c3
	nop ; $42c4
	inc bc ; $42c5
	rst Rst38 ; $42c6
	nop ; $42c7
	nop ; $42c8
	ld d, a ; $42c9
	ld b, e ; $42ca
	nop ; $42cb
	nop ; $42cc
	dec b ; $42cd
	rst Rst38 ; $42ce
	nop ; $42cf
	nop ; $42d0
	and a, c ; $42d1
	ld b, e ; $42d2
	nop ; $42d3
	nop ; $42d4
	ld b, $ff ; $42d5
	nop ; $42d7
	nop ; $42d8
	rst Rst18 ; $42d9
	ld b, e ; $42da
	nop ; $42db
	nop ; $42dc
	rst Rst38 ; $42dd
	ld a, $02 ; $42de
	ld bc, $0700 ; $42e0
	ld de, $0d00 ; $42e3
	farcall FarPtr_ScriptSetActorMoveTarget ; $42e6
	ld a, $00 ; $42e9
	ld bc, $0010 ; $42eb
	farcall FarPtr_0a_18 ; $42ee
	ld a, $00 ; $42f1
	ld b, $c0 ; $42f3
	ld de, $0100 ; $42f5
	farcall FarPtr_MoveActorByAngle ; $42f8
	ld a, $00 ; $42fb
	farcall FarPtr_ScriptWaitActorMoveDone ; $42fd
	call Func_13_4425 ; $4300
	ld a, $01 ; $4303
	ld [$c294], a ; $4305
	ld [$c2a1], a ; $4308
	ret ; $430b
	ld a, $00 ; $430c
	ld bc, $0010 ; $430e
	farcall FarPtr_0a_18 ; $4311
	ld a, $02 ; $4314
	ld bc, $1500 ; $4316
	ld de, $0d00 ; $4319
	farcall FarPtr_ScriptSetActorMoveTarget ; $431c
	ld a, $00 ; $431f
	ld b, $c2 ; $4321
	ld de, $0200 ; $4323
	farcall FarPtr_MoveActorByAngle ; $4326
	ld a, $00 ; $4329
	farcall FarPtr_ScriptWaitActorMoveDone ; $432b
	call Func_13_4d78 ; $432e
	ld a, $00 ; $4331
	ld b, $c2 ; $4333
	ld de, $0200 ; $4335
	farcall FarPtr_MoveActorByAngle ; $4338
	push af ; $433b
	ld a, $02 ; $433c
	farcall FarPtr_WaitScriptFrames ; $433e
	pop af ; $4341
	ld c, $10 ; $4342
	call BeginFadeOut ; $4344
	push af ; $4347
	ld a, $1e ; $4348
	farcall FarPtr_WaitScriptFrames ; $434a
	pop af ; $434d
	ld a, $02 ; $434e
	ld [$c294], a ; $4350
	ld [$c2a1], a ; $4353
	ret ; $4356
	ld a, $02 ; $4357
	ld bc, $0040 ; $4359
	farcall FarPtr_0a_18 ; $435c
	ld a, $02 ; $435f
	ld bc, $2500 ; $4361
	ld de, $0d00 ; $4364
	farcall FarPtr_ScriptSetActorMoveTarget ; $4367
	ld a, $00 ; $436a
	ld bc, $0010 ; $436c
	farcall FarPtr_0a_18 ; $436f
	ld a, $02 ; $4372
	ld bc, $0010 ; $4374
	farcall FarPtr_0a_18 ; $4377
	ld a, $00 ; $437a
	ld b, $c0 ; $437c
	ld de, $0100 ; $437e
	farcall FarPtr_MoveActorByAngle ; $4381
	ld a, $00 ; $4384
	farcall FarPtr_ScriptWaitActorMoveDone ; $4386
	call Func_13_4425 ; $4389
	ld c, $10 ; $438c
	call BeginFadeOut ; $438e
	push af ; $4391
	ld a, $1e ; $4392
	farcall FarPtr_WaitScriptFrames ; $4394
	pop af ; $4397
	ld a, $03 ; $4398
	ld [$c294], a ; $439a
	ld [$c2a1], a ; $439d
	ret ; $43a0
	ld a, $02 ; $43a1
	ld bc, $3700 ; $43a3
	ld de, $0d00 ; $43a6
	farcall FarPtr_ScriptSetActorMoveTarget ; $43a9
	ld a, $00 ; $43ac
	ld bc, $0010 ; $43ae
	farcall FarPtr_0a_18 ; $43b1
	ld a, $02 ; $43b4
	ld bc, $0010 ; $43b6
	farcall FarPtr_0a_18 ; $43b9
	ld a, $00 ; $43bc
	ld b, $c0 ; $43be
	ld de, $0080 ; $43c0
	farcall FarPtr_MoveActorByAngle ; $43c3
	call Func_13_4425 ; $43c6
	test_flag $05, 7 ; $43c9
	ld a, $05 ; $43cc
	ld [$c294], a ; $43ce
	ld [$c2a1], a ; $43d1
	jr z, Label_13_43de ; $43d4
	ld a, $0d ; $43d6
	ld [$c294], a ; $43d8
	ld [$c2a1], a ; $43db
Label_13_43de:
	ret ; $43de
	ld a, $00 ; $43df
	ld bc, $0020 ; $43e1
	farcall FarPtr_0a_18 ; $43e4
	ld a, $02 ; $43e7
	ld bc, $3b00 ; $43e9
	ld de, $0d00 ; $43ec
	farcall FarPtr_ScriptSetActorMoveTarget ; $43ef
	ld a, $00 ; $43f2
	ld b, $00 ; $43f4
	ld de, $0600 ; $43f6
	farcall FarPtr_MoveActorByAngle ; $43f9
	push af ; $43fc
	ld a, $3c ; $43fd
	farcall FarPtr_WaitScriptFrames ; $43ff
	pop af ; $4402
	ld c, $10 ; $4403
	call BeginFadeOut ; $4405
	push af ; $4408
	ld a, $1e ; $4409
	farcall FarPtr_WaitScriptFrames ; $440b
	pop af ; $440e
	test_flag $05, 7 ; $440f
	ld a, $06 ; $4412
	ld [$c294], a ; $4414
	ld [$c2a1], a ; $4417
	jr z, Label_13_43de ; $441a
	ld a, $06 ; $441c
	ld [$c294], a ; $441e
	ld [$c2a1], a ; $4421
	ret ; $4424
Func_13_4425:
	test_flag $05, 7 ; $4425
	jr nz, Label_13_446a ; $4428
	ld a, $00 ; $442a
	ld b, $c0 ; $442c
	farcall FarPtr_SetActorFacing ; $442e
	ld a, $00 ; $4431
	ld b, $c8 ; $4433
	ld de, $0400 ; $4435
	farcall FarPtr_MoveActorByAngle ; $4438
	ld a, $00 ; $443b
	ld bc, $0010 ; $443d
	farcall FarPtr_0a_18 ; $4440
	push af ; $4443
	ld a, $28 ; $4444
	farcall FarPtr_WaitScriptFrames ; $4446
	pop af ; $4449
	ld a, $00 ; $444a
	ld d, $08 ; $444c
	farcall FarPtr_ScriptSetActorAnimation ; $444e
	ld c, $08 ; $4451
	call BeginFadeOut ; $4453
	ld a, $00 ; $4456
	farcall FarPtr_ScriptWaitActorMoveDone ; $4458
	ld a, $00 ; $445b
	ld b, $00 ; $445d
	farcall FarPtr_SetActorActive ; $445f
	push af ; $4462
	ld a, $0a ; $4463
	farcall FarPtr_WaitScriptFrames ; $4465
	pop af ; $4468
	ret ; $4469
Label_13_446a:
	ld a, $02 ; $446a
	farcall FarPtr_ScriptWaitActorMoveDone ; $446c
	ld a, $00 ; $446f
	ld b, $c8 ; $4471
	ld de, $0280 ; $4473
	farcall FarPtr_MoveActorByAngle ; $4476
	ld a, $00 ; $4479
	ld bc, $0010 ; $447b
	farcall FarPtr_0a_18 ; $447e
	ld a, $02 ; $4481
	ld bc, $0010 ; $4483
	farcall FarPtr_0a_18 ; $4486
	push af ; $4489
	ld a, $0a ; $448a
	farcall FarPtr_WaitScriptFrames ; $448c
	pop af ; $448f
	ld a, $02 ; $4490
	ld b, $ca ; $4492
	ld de, $0500 ; $4494
	farcall FarPtr_MoveActorByAngle ; $4497
	ld a, $00 ; $449a
	farcall FarPtr_ScriptWaitActorMoveDone ; $449c
	ld a, $00 ; $449f
	ld d, $08 ; $44a1
	farcall FarPtr_ScriptSetActorAnimation ; $44a3
	ld a, $00 ; $44a6
	ld b, $ca ; $44a8
	ld de, $0100 ; $44aa
	farcall FarPtr_MoveActorByAngle ; $44ad
	ld a, $02 ; $44b0
	farcall FarPtr_ScriptWaitActorMoveDone ; $44b2
	ld a, $02 ; $44b5
	ld d, $08 ; $44b7
	farcall FarPtr_ScriptSetActorAnimation ; $44b9
	ld a, $02 ; $44bc
	ld b, $ca ; $44be
	ld de, $0200 ; $44c0
	farcall FarPtr_MoveActorByAngle ; $44c3
	ld a, $00 ; $44c6
	farcall FarPtr_ScriptWaitActorMoveDone ; $44c8
	ld a, $00 ; $44cb
	ld b, $00 ; $44cd
	farcall FarPtr_SetActorActive ; $44cf
	ld c, $10 ; $44d2
	call BeginFadeOut ; $44d4
	push af ; $44d7
	ld a, $0a ; $44d8
	farcall FarPtr_WaitScriptFrames ; $44da
	pop af ; $44dd
	ret ; $44de
	ld a, [$c295] ; $44df
	cp a, $0f ; $44e2
	jr nz, Label_13_44e9 ; $44e4
	call Func_13_44f1 ; $44e6
Label_13_44e9:
	cp a, $0e ; $44e9
	jr nz, Label_13_44f0 ; $44eb
	call Func_13_476e ; $44ed
Label_13_44f0:
	ret ; $44f0
Func_13_44f1:
	ldh a, [hRomBank] ; $44f1
	ld hl, $472c ; $44f3
	farcall FarPtr_0a_06 ; $44f6
	farcall FarPtr_0a_00 ; $44f9
	ld a, $00 ; $44fc
	ld bc, $3f00 ; $44fe
	ld de, $3f00 ; $4501
	farcall FarPtr_ScriptSetActorPosition ; $4504
	ld a, $06 ; $4507
	ld bc, $3f00 ; $4509
	ld de, $3f00 ; $450c
	farcall FarPtr_ScriptSetActorPosition ; $450f
	call Func_13_4cdc ; $4512
	ld c, $04 ; $4515
	call BeginFadeIn ; $4517
	call WaitFadeEnd ; $451a
	ld a, $06 ; $451d
	ld bc, $3200 ; $451f
	ld de, $1300 ; $4522
	farcall FarPtr_ScriptSetActorPosition ; $4525
	ld a, $06 ; $4528
	ld bc, $3200 ; $452a
	ld de, $0d00 ; $452d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4530
	push af ; $4533
	ld a, $0f ; $4534
	farcall FarPtr_WaitScriptFrames ; $4536
	pop af ; $4539
	ld a, $00 ; $453a
	ld bc, $3200 ; $453c
	ld de, $1300 ; $453f
	farcall FarPtr_ScriptSetActorPosition ; $4542
	ld a, $00 ; $4545
	ld bc, $3200 ; $4547
	ld de, $0f00 ; $454a
	farcall FarPtr_ScriptSetActorMoveTarget ; $454d
	ld a, $00 ; $4550
	farcall FarPtr_ScriptWaitActorMoveDone ; $4552
	push af ; $4555
	ld a, $1e ; $4556
	farcall FarPtr_WaitScriptFrames ; $4558
	pop af ; $455b
	ld a, $00 ; $455c
	ld b, a ; $455e
	ld a, $06 ; $455f
	farcall FarPtr_FaceActorTowardActor ; $4561
	push af ; $4564
	ld a, $3c ; $4565
	farcall FarPtr_WaitScriptFrames ; $4567
	pop af ; $456a
	ld a, $06 ; $456b
	ld b, $00 ; $456d
	farcall FarPtr_SetActorFacing ; $456f
	push af ; $4572
	ld a, $0f ; $4573
	farcall FarPtr_WaitScriptFrames ; $4575
	pop af ; $4578
	ld a, $00 ; $4579
	ld b, $00 ; $457b
	farcall FarPtr_SetActorFacing ; $457d
	push af ; $4580
	ld a, $0f ; $4581
	farcall FarPtr_WaitScriptFrames ; $4583
	pop af ; $4586
	xor a, a ; $4587
	ld bc, $3600 ; $4588
	ld de, $0d00 ; $458b
	farcall FarPtr_MovePlayerToPosition ; $458e
	farcall FarPtr_WaitPlayerMoveDone ; $4591
	ld a, $50 ; $4594
	ld [$c2b0], a ; $4596
	ld a, $48 ; $4599
	ld [$c2b1], a ; $459b
	ld a, $01 ; $459e
	ld hl, $4d0a ; $45a0
	call RegisterFrameTask ; $45a3
	ld hl, $0430 ; $45a6
	farcall FarPtr_0a_0e ; $45a9
	ld a, $06 ; $45ac
	farcall FarPtr_0a_08 ; $45ae
	ld hl, $4d0a ; $45b1
	call UnregisterFrameTask ; $45b4
	xor a, a ; $45b7
	ld bc, $3200 ; $45b8
	ld de, $1300 ; $45bb
	farcall FarPtr_MovePlayerToPosition ; $45be
	farcall FarPtr_WaitPlayerMoveDone ; $45c1
	push af ; $45c4
	ld a, $1e ; $45c5
	farcall FarPtr_WaitScriptFrames ; $45c7
	pop af ; $45ca
	ld a, $00 ; $45cb
	ld b, a ; $45cd
	ld a, $06 ; $45ce
	farcall FarPtr_FaceActorsTowardEachOther ; $45d0
	ld a, $06 ; $45d3
	farcall FarPtr_0a_08 ; $45d5
	push af ; $45d8
	ld a, $0f ; $45d9
	farcall FarPtr_WaitScriptFrames ; $45db
	pop af ; $45de
	ld a, $00 ; $45df
	ld d, $03 ; $45e1
	farcall FarPtr_ScriptSetActorAnimation ; $45e3
	ld a, $00 ; $45e6
	farcall FarPtr_ScriptWaitActorIdle ; $45e8
	push af ; $45eb
	ld a, $1e ; $45ec
	farcall FarPtr_WaitScriptFrames ; $45ee
	pop af ; $45f1
	ld a, $06 ; $45f2
	ld b, $80 ; $45f4
	farcall FarPtr_SetActorFacing ; $45f6
	push af ; $45f9
	ld a, $0f ; $45fa
	farcall FarPtr_WaitScriptFrames ; $45fc
	pop af ; $45ff
	ld a, $00 ; $4600
	ld b, $80 ; $4602
	farcall FarPtr_SetActorFacing ; $4604
	push af ; $4607
	ld a, $0f ; $4608
	farcall FarPtr_WaitScriptFrames ; $460a
	pop af ; $460d
	xor a, a ; $460e
	ld bc, $2a00 ; $460f
	ld de, $0d00 ; $4612
	farcall FarPtr_MovePlayerToPosition ; $4615
	farcall FarPtr_WaitPlayerMoveDone ; $4618
	ld a, $20 ; $461b
	ld [$c2b0], a ; $461d
	ld a, $48 ; $4620
	ld [$c2b1], a ; $4622
	ld a, $01 ; $4625
	ld hl, $4d0a ; $4627
	call RegisterFrameTask ; $462a
	ld a, $06 ; $462d
	farcall FarPtr_0a_08 ; $462f
	ld hl, $4d0a ; $4632
	call UnregisterFrameTask ; $4635
	xor a, a ; $4638
	ld bc, $3200 ; $4639
	ld de, $0d00 ; $463c
	farcall FarPtr_MovePlayerToPosition ; $463f
	farcall FarPtr_WaitPlayerMoveDone ; $4642
	ld a, $00 ; $4645
	ld b, a ; $4647
	ld a, $06 ; $4648
	farcall FarPtr_FaceActorsTowardEachOther ; $464a
	ld a, $06 ; $464d
	farcall FarPtr_0a_08 ; $464f
	ld a, $00 ; $4652
	ld d, $03 ; $4654
	farcall FarPtr_ScriptSetActorAnimation ; $4656
	ld a, $00 ; $4659
	farcall FarPtr_ScriptWaitActorIdle ; $465b
	ld a, $06 ; $465e
	ld d, $03 ; $4660
	farcall FarPtr_ScriptSetActorAnimation ; $4662
	ld a, $06 ; $4665
	farcall FarPtr_ScriptWaitActorIdle ; $4667
	push af ; $466a
	ld a, $32 ; $466b
	farcall FarPtr_WaitScriptFrames ; $466d
	pop af ; $4670
	ld a, $06 ; $4671
	ld b, $80 ; $4673
	farcall FarPtr_SetActorFacing ; $4675
	push af ; $4678
	ld a, $28 ; $4679
	farcall FarPtr_WaitScriptFrames ; $467b
	pop af ; $467e
	ld a, $06 ; $467f
	ld b, $40 ; $4681
	farcall FarPtr_SetActorFacing ; $4683
	push af ; $4686
	ld a, $0a ; $4687
	farcall FarPtr_WaitScriptFrames ; $4689
	pop af ; $468c
	ld a, $06 ; $468d
	ld b, $00 ; $468f
	farcall FarPtr_SetActorFacing ; $4691
	push af ; $4694
	ld a, $28 ; $4695
	farcall FarPtr_WaitScriptFrames ; $4697
	pop af ; $469a
	ld a, $06 ; $469b
	ld b, $40 ; $469d
	farcall FarPtr_SetActorFacing ; $469f
	push af ; $46a2
	ld a, $0a ; $46a3
	farcall FarPtr_WaitScriptFrames ; $46a5
	pop af ; $46a8
	ld a, $06 ; $46a9
	ld b, $80 ; $46ab
	farcall FarPtr_SetActorFacing ; $46ad
	push af ; $46b0
	ld a, $28 ; $46b1
	farcall FarPtr_WaitScriptFrames ; $46b3
	pop af ; $46b6
	ld a, $06 ; $46b7
	ld b, $40 ; $46b9
	farcall FarPtr_SetActorFacing ; $46bb
	push af ; $46be
	ld a, $0a ; $46bf
	farcall FarPtr_WaitScriptFrames ; $46c1
	pop af ; $46c4
	ld a, $06 ; $46c5
	ld b, $00 ; $46c7
	farcall FarPtr_SetActorFacing ; $46c9
	push af ; $46cc
	ld a, $32 ; $46cd
	farcall FarPtr_WaitScriptFrames ; $46cf
	pop af ; $46d2
	ld a, $06 ; $46d3
	ld d, $03 ; $46d5
	farcall FarPtr_ScriptSetActorAnimation ; $46d7
	ld a, $06 ; $46da
	farcall FarPtr_ScriptWaitActorIdle ; $46dc
	ld a, $06 ; $46df
	farcall FarPtr_0a_08 ; $46e1
	ld a, $06 ; $46e4
	ld bc, $4100 ; $46e6
	ld de, $0d00 ; $46e9
	farcall FarPtr_ScriptSetActorMoveTarget ; $46ec
	push af ; $46ef
	ld a, $05 ; $46f0
	farcall FarPtr_WaitScriptFrames ; $46f2
	pop af ; $46f5
	xor a, a ; $46f6
	ld bc, $3600 ; $46f7
	ld de, $0d00 ; $46fa
	farcall FarPtr_MovePlayerToPosition ; $46fd
	ld a, $00 ; $4700
	ld bc, $3200 ; $4702
	ld de, $0d20 ; $4705
	farcall FarPtr_ScriptSetActorMoveTarget ; $4708
	ld a, $00 ; $470b
	farcall FarPtr_ScriptWaitActorMoveDone ; $470d
	ld a, $00 ; $4710
	ld bc, $4100 ; $4712
	ld de, $0d20 ; $4715
	farcall FarPtr_ScriptSetActorMoveTarget ; $4718
	ld a, $00 ; $471b
	farcall FarPtr_ScriptWaitActorMoveDone ; $471d
	ld a, $0f ; $4720
	ld [$c294], a ; $4722
	ld [$c2a1], a ; $4725
	farcall FarPtr_0a_02 ; $4728
	ret ; $472b
	INCBIN "data/bank_013/d_472c.bin" ; $472c, 66 bytes
Func_13_476e:
	ldh a, [hRomBank] ; $476e
	ld hl, $4c7e ; $4770
	farcall FarPtr_0a_06 ; $4773
	farcall FarPtr_0a_00 ; $4776
	ld a, $00 ; $4779
	ld bc, $3f00 ; $477b
	ld de, $3f00 ; $477e
	farcall FarPtr_ScriptSetActorPosition ; $4781
	ld a, $06 ; $4784
	ld bc, $3f00 ; $4786
	ld de, $3f00 ; $4789
	farcall FarPtr_ScriptSetActorPosition ; $478c
	ld a, $07 ; $478f
	ld bc, $3f00 ; $4791
	ld de, $3f00 ; $4794
	farcall FarPtr_ScriptSetActorPosition ; $4797
	ld a, $08 ; $479a
	ld bc, $3f00 ; $479c
	ld de, $3f00 ; $479f
	farcall FarPtr_ScriptSetActorPosition ; $47a2
	ld c, $04 ; $47a5
	call BeginFadeIn ; $47a7
	call WaitFadeEnd ; $47aa
	ld a, $06 ; $47ad
	ld bc, $4100 ; $47af
	ld de, $0d00 ; $47b2
	farcall FarPtr_ScriptSetActorPosition ; $47b5
	ld a, $06 ; $47b8
	ld bc, $1b00 ; $47ba
	ld de, $0d00 ; $47bd
	farcall FarPtr_ScriptSetActorMoveTarget ; $47c0
	ld a, $00 ; $47c3
	ld bc, $4300 ; $47c5
	ld de, $0d00 ; $47c8
	farcall FarPtr_ScriptSetActorPosition ; $47cb
	ld a, $00 ; $47ce
	ld bc, $1d00 ; $47d0
	ld de, $0d00 ; $47d3
	farcall FarPtr_ScriptSetActorMoveTarget ; $47d6
	push af ; $47d9
	ld a, $0f ; $47da
	farcall FarPtr_WaitScriptFrames ; $47dc
	pop af ; $47df
	xor a, a ; $47e0
	ld bc, $1b00 ; $47e1
	ld de, $0d00 ; $47e4
	farcall FarPtr_MovePlayerToPosition ; $47e7
	ld a, $00 ; $47ea
	farcall FarPtr_ScriptWaitActorMoveDone ; $47ec
	push af ; $47ef
	ld a, $1e ; $47f0
	farcall FarPtr_WaitScriptFrames ; $47f2
	pop af ; $47f5
	ld a, $00 ; $47f6
	ld b, a ; $47f8
	ld a, $06 ; $47f9
	farcall FarPtr_FaceActorTowardActor ; $47fb
	ld hl, $0435 ; $47fe
	farcall FarPtr_0a_0e ; $4801
	ld a, $06 ; $4804
	farcall FarPtr_0a_08 ; $4806
	ld a, $00 ; $4809
	ld d, $03 ; $480b
	farcall FarPtr_ScriptSetActorAnimation ; $480d
	ld a, $00 ; $4810
	farcall FarPtr_ScriptWaitActorIdle ; $4812
	ld a, $06 ; $4815
	ld b, $c0 ; $4817
	farcall FarPtr_SetActorFacing ; $4819
	push af ; $481c
	ld a, $0f ; $481d
	farcall FarPtr_WaitScriptFrames ; $481f
	pop af ; $4822
	ld a, $00 ; $4823
	ld b, $c0 ; $4825
	farcall FarPtr_SetActorFacing ; $4827
	ld a, $06 ; $482a
	farcall FarPtr_0a_08 ; $482c
	ld a, $00 ; $482f
	ld d, $03 ; $4831
	farcall FarPtr_ScriptSetActorAnimation ; $4833
	ld a, $00 ; $4836
	farcall FarPtr_ScriptWaitActorIdle ; $4838
	push af ; $483b
	ld a, $1e ; $483c
	farcall FarPtr_WaitScriptFrames ; $483e
	pop af ; $4841
	call Func_13_4d78 ; $4842
	ld a, $07 ; $4845
	farcall FarPtr_0a_08 ; $4847
	push af ; $484a
	ld a, $0f ; $484b
	farcall FarPtr_WaitScriptFrames ; $484d
	pop af ; $4850
	ld a, $03 ; $4851
	ld bc, $1c00 ; $4853
	ld de, $0b00 ; $4856
	farcall FarPtr_ScriptSetActorPosition ; $4859
	sound $97 ; $485c
	push af ; $485e
	ld a, $1e ; $485f
	farcall FarPtr_WaitScriptFrames ; $4861
	pop af ; $4864
	ld a, $03 ; $4865
	ld bc, $3f00 ; $4867
	ld de, $3f00 ; $486a
	farcall FarPtr_ScriptSetActorPosition ; $486d
	ld a, $06 ; $4870
	ld b, $80 ; $4872
	farcall FarPtr_SetActorFacing ; $4874
	push af ; $4877
	ld a, $0f ; $4878
	farcall FarPtr_WaitScriptFrames ; $487a
	pop af ; $487d
	ld a, $00 ; $487e
	ld b, $80 ; $4880
	farcall FarPtr_SetActorFacing ; $4882
	xor a, a ; $4885
	ld bc, $1800 ; $4886
	ld de, $0d00 ; $4889
	farcall FarPtr_MovePlayerToPosition ; $488c
	push af ; $488f
	ld a, $0f ; $4890
	farcall FarPtr_WaitScriptFrames ; $4892
	pop af ; $4895
	ld a, $07 ; $4896
	ld bc, $1500 ; $4898
	ld de, $0980 ; $489b
	farcall FarPtr_ScriptSetActorPosition ; $489e
	push af ; $48a1
	ld a, $0f ; $48a2
	farcall FarPtr_WaitScriptFrames ; $48a4
	pop af ; $48a7
	ld a, $07 ; $48a8
	ld bc, $0010 ; $48aa
	farcall FarPtr_0a_18 ; $48ad
	ld a, $07 ; $48b0
	ld bc, $1500 ; $48b2
	ld de, $0d00 ; $48b5
	farcall FarPtr_ScriptSetActorMoveTarget ; $48b8
	ld a, $07 ; $48bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $48bd
	ld a, $07 ; $48c0
	ld b, $00 ; $48c2
	farcall FarPtr_SetActorFacing ; $48c4
	ld a, $08 ; $48c7
	ld bc, $1500 ; $48c9
	ld de, $0900 ; $48cc
	farcall FarPtr_ScriptSetActorPosition ; $48cf
	push af ; $48d2
	ld a, $0f ; $48d3
	farcall FarPtr_WaitScriptFrames ; $48d5
	pop af ; $48d8
	ld a, $08 ; $48d9
	ld bc, $0010 ; $48db
	farcall FarPtr_0a_18 ; $48de
	ld a, $08 ; $48e1
	ld bc, $1500 ; $48e3
	ld de, $0b00 ; $48e6
	farcall FarPtr_ScriptSetActorMoveTarget ; $48e9
	ld a, $08 ; $48ec
	farcall FarPtr_ScriptWaitActorMoveDone ; $48ee
	call Func_13_4dcc ; $48f1
	ld a, $08 ; $48f4
	ld b, $00 ; $48f6
	farcall FarPtr_SetActorFacing ; $48f8
	push af ; $48fb
	ld a, $0f ; $48fc
	farcall FarPtr_WaitScriptFrames ; $48fe
	pop af ; $4901
	ld a, $06 ; $4902
	ld d, $02 ; $4904
	farcall FarPtr_ScriptSetActorAnimation ; $4906
	ld a, $06 ; $4909
	farcall FarPtr_ScriptWaitActorIdle ; $490b
	ld a, $06 ; $490e
	farcall FarPtr_0a_08 ; $4910
	ld a, $07 ; $4913
	ld b, $40 ; $4915
	farcall FarPtr_SetActorFacing ; $4917
	ld a, $07 ; $491a
	ld d, $04 ; $491c
	farcall FarPtr_ScriptSetActorAnimation ; $491e
	ld a, $07 ; $4921
	farcall FarPtr_ScriptWaitActorIdle ; $4923
	push af ; $4926
	ld a, $1e ; $4927
	farcall FarPtr_WaitScriptFrames ; $4929
	pop af ; $492c
	ld a, $06 ; $492d
	ld b, a ; $492f
	ld a, $07 ; $4930
	farcall FarPtr_FaceActorTowardActor ; $4932
	ld a, $07 ; $4935
	farcall FarPtr_0a_08 ; $4937
	ld a, $06 ; $493a
	ld d, $02 ; $493c
	farcall FarPtr_ScriptSetActorAnimation ; $493e
	ld a, $06 ; $4941
	farcall FarPtr_ScriptWaitActorIdle ; $4943
	ld a, $06 ; $4946
	farcall FarPtr_0a_08 ; $4948
	ld a, $08 ; $494b
	ld d, $03 ; $494d
	farcall FarPtr_ScriptSetActorAnimation ; $494f
	ld a, $08 ; $4952
	farcall FarPtr_ScriptWaitActorIdle ; $4954
	ld a, $08 ; $4957
	farcall FarPtr_0a_08 ; $4959
	push af ; $495c
	ld a, $0f ; $495d
	farcall FarPtr_WaitScriptFrames ; $495f
	pop af ; $4962
	ld a, $08 ; $4963
	ld d, $02 ; $4965
	farcall FarPtr_ScriptSetActorAnimation ; $4967
	ld a, $08 ; $496a
	farcall FarPtr_ScriptWaitActorIdle ; $496c
	ld a, $04 ; $496f
	ld bc, $1640 ; $4971
	ld de, $0940 ; $4974
	farcall FarPtr_ScriptSetActorPosition ; $4977
	sound $98 ; $497a
	push af ; $497c
	ld a, $1e ; $497d
	farcall FarPtr_WaitScriptFrames ; $497f
	pop af ; $4982
	ld a, $04 ; $4983
	ld bc, $3f00 ; $4985
	ld de, $3f00 ; $4988
	farcall FarPtr_ScriptSetActorPosition ; $498b
	push af ; $498e
	ld a, $1e ; $498f
	farcall FarPtr_WaitScriptFrames ; $4991
	pop af ; $4994
	ld a, $06 ; $4995
	ld d, $02 ; $4997
	farcall FarPtr_ScriptSetActorAnimation ; $4999
	ld a, $06 ; $499c
	farcall FarPtr_ScriptWaitActorIdle ; $499e
	ld a, $00 ; $49a1
	ld b, a ; $49a3
	ld a, $06 ; $49a4
	farcall FarPtr_FaceActorTowardActor ; $49a6
	push af ; $49a9
	ld a, $32 ; $49aa
	farcall FarPtr_WaitScriptFrames ; $49ac
	pop af ; $49af
	ld a, $07 ; $49b0
	ld b, a ; $49b2
	ld a, $06 ; $49b3
	farcall FarPtr_FaceActorTowardActor ; $49b5
	ld a, [$c90d] ; $49b8
	or a, a ; $49bb
	jr z, Label_13_49c1 ; $49bc
	farcall FarPtr_0a_10 ; $49be
Label_13_49c1:
	ld a, $06 ; $49c1
	farcall FarPtr_0a_08 ; $49c3
	ld hl, $043e ; $49c6
	farcall FarPtr_0a_0e ; $49c9
	push af ; $49cc
	ld a, $0f ; $49cd
	farcall FarPtr_WaitScriptFrames ; $49cf
	pop af ; $49d2
	ld a, $00 ; $49d3
	ld bc, $0018 ; $49d5
	farcall FarPtr_0a_18 ; $49d8
	ld a, $00 ; $49db
	ld bc, $1d00 ; $49dd
	ld de, $0c00 ; $49e0
	farcall FarPtr_ScriptSetActorMoveTarget ; $49e3
	ld a, $00 ; $49e6
	farcall FarPtr_ScriptWaitActorMoveDone ; $49e8
	ld a, $00 ; $49eb
	ld bc, $1b00 ; $49ed
	ld de, $0b00 ; $49f0
	farcall FarPtr_ScriptSetActorMoveTarget ; $49f3
	ld a, $00 ; $49f6
	farcall FarPtr_ScriptWaitActorMoveDone ; $49f8
	ld a, $00 ; $49fb
	ld b, $80 ; $49fd
	farcall FarPtr_SetActorFacing ; $49ff
	ld a, $00 ; $4a02
	ld bc, $0020 ; $4a04
	farcall FarPtr_0a_18 ; $4a07
	push af ; $4a0a
	ld a, $0f ; $4a0b
	farcall FarPtr_WaitScriptFrames ; $4a0d
	pop af ; $4a10
	ld a, $00 ; $4a11
	ld d, $03 ; $4a13
	farcall FarPtr_ScriptSetActorAnimation ; $4a15
	ld a, $00 ; $4a18
	farcall FarPtr_ScriptWaitActorIdle ; $4a1a
	push af ; $4a1d
	ld a, $0f ; $4a1e
	farcall FarPtr_WaitScriptFrames ; $4a20
	pop af ; $4a23
	ld a, $08 ; $4a24
	ld b, a ; $4a26
	ld a, $07 ; $4a27
	farcall FarPtr_FaceActorsTowardEachOther ; $4a29
	push af ; $4a2c
	ld a, $46 ; $4a2d
	farcall FarPtr_WaitScriptFrames ; $4a2f
	pop af ; $4a32
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $07 ; $4a36
	farcall FarPtr_FaceActorTowardActor ; $4a38
	ld a, $00 ; $4a3b
	ld b, a ; $4a3d
	ld a, $08 ; $4a3e
	farcall FarPtr_FaceActorTowardActor ; $4a40
	push af ; $4a43
	ld a, $0f ; $4a44
	farcall FarPtr_WaitScriptFrames ; $4a46
	pop af ; $4a49
	ld a, $07 ; $4a4a
	farcall FarPtr_0a_08 ; $4a4c
	ld a, $07 ; $4a4f
	ld d, $03 ; $4a51
	farcall FarPtr_ScriptSetActorAnimation ; $4a53
	ld a, $07 ; $4a56
	farcall FarPtr_ScriptWaitActorIdle ; $4a58
	ld a, $07 ; $4a5b
	farcall FarPtr_0a_08 ; $4a5d
	ld a, $00 ; $4a60
	ld d, $03 ; $4a62
	farcall FarPtr_ScriptSetActorAnimation ; $4a64
	ld a, $00 ; $4a67
	farcall FarPtr_ScriptWaitActorIdle ; $4a69
	push af ; $4a6c
	ld a, $1e ; $4a6d
	farcall FarPtr_WaitScriptFrames ; $4a6f
	pop af ; $4a72
	ld a, $08 ; $4a73
	ld d, $02 ; $4a75
	farcall FarPtr_ScriptSetActorAnimation ; $4a77
	ld a, $08 ; $4a7a
	farcall FarPtr_ScriptWaitActorIdle ; $4a7c
	ld a, $08 ; $4a7f
	farcall FarPtr_0a_08 ; $4a81
	ld a, $08 ; $4a84
	ld d, $03 ; $4a86
	farcall FarPtr_ScriptSetActorAnimation ; $4a88
	ld a, $08 ; $4a8b
	farcall FarPtr_ScriptWaitActorIdle ; $4a8d
	ld a, $08 ; $4a90
	farcall FarPtr_0a_08 ; $4a92
	push af ; $4a95
	ld a, $5a ; $4a96
	farcall FarPtr_WaitScriptFrames ; $4a98
	pop af ; $4a9b
	ld a, $08 ; $4a9c
	ld bc, $1500 ; $4a9e
	ld de, $0980 ; $4aa1
	farcall FarPtr_ScriptSetActorMoveTarget ; $4aa4
	call Func_13_4d78 ; $4aa7
	ld a, $08 ; $4aaa
	ld bc, $14c0 ; $4aac
	ld de, $0900 ; $4aaf
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ab2
	ld a, $07 ; $4ab5
	ld bc, $1500 ; $4ab7
	ld de, $0b00 ; $4aba
	farcall FarPtr_ScriptSetActorMoveTarget ; $4abd
	ld a, $08 ; $4ac0
	ld bc, $3f00 ; $4ac2
	ld de, $3f00 ; $4ac5
	farcall FarPtr_ScriptSetActorPosition ; $4ac8
	ld a, $07 ; $4acb
	farcall FarPtr_ScriptWaitActorMoveDone ; $4acd
	push af ; $4ad0
	ld a, $0f ; $4ad1
	farcall FarPtr_WaitScriptFrames ; $4ad3
	pop af ; $4ad6
	ld a, $06 ; $4ad7
	ld b, a ; $4ad9
	ld a, $07 ; $4ada
	farcall FarPtr_FaceActorTowardActor ; $4adc
	ld a, $07 ; $4adf
	farcall FarPtr_0a_08 ; $4ae1
	ld a, $07 ; $4ae4
	ld bc, $1500 ; $4ae6
	ld de, $0980 ; $4ae9
	farcall FarPtr_ScriptSetActorMoveTarget ; $4aec
	ld a, $07 ; $4aef
	farcall FarPtr_ScriptWaitActorMoveDone ; $4af1
	ld a, $07 ; $4af4
	ld bc, $14c0 ; $4af6
	ld de, $0900 ; $4af9
	farcall FarPtr_ScriptSetActorMoveTarget ; $4afc
	push af ; $4aff
	ld a, $0f ; $4b00
	farcall FarPtr_WaitScriptFrames ; $4b02
	pop af ; $4b05
	ld a, $07 ; $4b06
	ld bc, $3f00 ; $4b08
	ld de, $3f00 ; $4b0b
	farcall FarPtr_ScriptSetActorPosition ; $4b0e
	call Func_13_4dcc ; $4b11
	xor a, a ; $4b14
	ld bc, $1b00 ; $4b15
	ld de, $0d00 ; $4b18
	farcall FarPtr_MovePlayerToPosition ; $4b1b
	push af ; $4b1e
	ld a, $3c ; $4b1f
	farcall FarPtr_WaitScriptFrames ; $4b21
	pop af ; $4b24
	ld a, $06 ; $4b25
	ld b, a ; $4b27
	ld a, $00 ; $4b28
	farcall FarPtr_FaceActorTowardActor ; $4b2a
	push af ; $4b2d
	ld a, $0f ; $4b2e
	farcall FarPtr_WaitScriptFrames ; $4b30
	pop af ; $4b33
	ld a, $05 ; $4b34
	ld bc, $1c00 ; $4b36
	ld de, $0900 ; $4b39
	farcall FarPtr_ScriptSetActorPosition ; $4b3c
	push af ; $4b3f
	ld a, $5a ; $4b40
	farcall FarPtr_WaitScriptFrames ; $4b42
	pop af ; $4b45
	ld a, $05 ; $4b46
	ld bc, $3f00 ; $4b48
	ld de, $3f00 ; $4b4b
	farcall FarPtr_ScriptSetActorPosition ; $4b4e
	push af ; $4b51
	ld a, $0f ; $4b52
	farcall FarPtr_WaitScriptFrames ; $4b54
	pop af ; $4b57
	ld a, $06 ; $4b58
	farcall FarPtr_0a_08 ; $4b5a
	ld a, $00 ; $4b5d
	ld b, a ; $4b5f
	ld a, $06 ; $4b60
	farcall FarPtr_FaceActorTowardActor ; $4b62
	push af ; $4b65
	ld a, $1e ; $4b66
	farcall FarPtr_WaitScriptFrames ; $4b68
	pop af ; $4b6b
	ld a, $06 ; $4b6c
	farcall FarPtr_0a_08 ; $4b6e
	ld a, $00 ; $4b71
	ld d, $02 ; $4b73
	farcall FarPtr_ScriptSetActorAnimation ; $4b75
	ld a, $00 ; $4b78
	farcall FarPtr_ScriptWaitActorIdle ; $4b7a
	push af ; $4b7d
	ld a, $3c ; $4b7e
	farcall FarPtr_WaitScriptFrames ; $4b80
	pop af ; $4b83
	ld a, $06 ; $4b84
	ld bc, $1500 ; $4b86
	ld de, $0d00 ; $4b89
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b8c
	ld a, $06 ; $4b8f
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b91
	ld a, $00 ; $4b94
	ld b, a ; $4b96
	ld a, $06 ; $4b97
	farcall FarPtr_FaceActorTowardActor ; $4b99
	push af ; $4b9c
	ld a, $1e ; $4b9d
	farcall FarPtr_WaitScriptFrames ; $4b9f
	pop af ; $4ba2
	ld a, $06 ; $4ba3
	farcall FarPtr_0a_08 ; $4ba5
	push af ; $4ba8
	ld a, $0f ; $4ba9
	farcall FarPtr_WaitScriptFrames ; $4bab
	pop af ; $4bae
	ld a, $00 ; $4baf
	ld bc, $1700 ; $4bb1
	ld de, $0d00 ; $4bb4
	farcall FarPtr_ScriptSetActorMoveTarget ; $4bb7
	ld a, $00 ; $4bba
	farcall FarPtr_ScriptWaitActorMoveDone ; $4bbc
	push af ; $4bbf
	ld a, $0a ; $4bc0
	farcall FarPtr_WaitScriptFrames ; $4bc2
	pop af ; $4bc5
	ld a, $06 ; $4bc6
	ld bc, $0700 ; $4bc8
	ld de, $0d00 ; $4bcb
	farcall FarPtr_ScriptSetActorMoveTarget ; $4bce
	push af ; $4bd1
	ld a, $0a ; $4bd2
	farcall FarPtr_WaitScriptFrames ; $4bd4
	pop af ; $4bd7
	xor a, a ; $4bd8
	ld bc, $0900 ; $4bd9
	ld de, $0d00 ; $4bdc
	farcall FarPtr_MovePlayerToPosition ; $4bdf
	ld a, $00 ; $4be2
	ld bc, $0700 ; $4be4
	ld de, $0d00 ; $4be7
	farcall FarPtr_ScriptSetActorMoveTarget ; $4bea
	ld a, $06 ; $4bed
	farcall FarPtr_ScriptWaitActorMoveDone ; $4bef
	ld a, $06 ; $4bf2
	ld b, $c0 ; $4bf4
	farcall FarPtr_SetActorFacing ; $4bf6
	ld a, $06 ; $4bf9
	ld b, $c0 ; $4bfb
	ld de, $0500 ; $4bfd
	farcall FarPtr_MoveActorByAngle ; $4c00
	ld a, $06 ; $4c03
	ld bc, $000b ; $4c05
	farcall FarPtr_0a_18 ; $4c08
	push af ; $4c0b
	ld a, $0a ; $4c0c
	farcall FarPtr_WaitScriptFrames ; $4c0e
	pop af ; $4c11
	ld a, $00 ; $4c12
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c14
	ld a, $00 ; $4c17
	ld b, $c0 ; $4c19
	farcall FarPtr_SetActorFacing ; $4c1b
	ld a, $00 ; $4c1e
	ld b, $c0 ; $4c20
	ld de, $0500 ; $4c22
	farcall FarPtr_MoveActorByAngle ; $4c25
	ld a, $00 ; $4c28
	ld bc, $000b ; $4c2a
	farcall FarPtr_0a_18 ; $4c2d
	ld a, $06 ; $4c30
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c32
	ld a, $06 ; $4c35
	ld d, $08 ; $4c37
	farcall FarPtr_ScriptSetActorAnimation ; $4c39
	ld a, $06 ; $4c3c
	ld b, $c0 ; $4c3e
	ld de, $0100 ; $4c40
	farcall FarPtr_MoveActorByAngle ; $4c43
	ld a, $00 ; $4c46
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c48
	ld a, $00 ; $4c4b
	ld d, $08 ; $4c4d
	farcall FarPtr_ScriptSetActorAnimation ; $4c4f
	ld a, $00 ; $4c52
	ld b, $c0 ; $4c54
	ld de, $0100 ; $4c56
	farcall FarPtr_MoveActorByAngle ; $4c59
	ld a, $06 ; $4c5c
	ld bc, $3f00 ; $4c5e
	ld de, $3f00 ; $4c61
	farcall FarPtr_ScriptSetActorPosition ; $4c64
	ld a, $00 ; $4c67
	ld bc, $3f00 ; $4c69
	ld de, $3f00 ; $4c6c
	farcall FarPtr_ScriptSetActorPosition ; $4c6f
	ld a, $0e ; $4c72
	ld [$c294], a ; $4c74
	ld [$c2a1], a ; $4c77
	farcall FarPtr_0a_02 ; $4c7a
	ret ; $4c7d
	INCBIN "data/bank_013/d_4c7e.bin" ; $4c7e, 94 bytes
Func_13_4cdc:
	ldh a, [hWramBank] ; $4cdc
	push af ; $4cde
	wram_bank $01 ; $4cdf
	ld hl, $4d30 ; $4ce5
	ld de, $a000 ; $4ce8
	ld c, $04 ; $4ceb
	call QueueVRAMCopy ; $4ced
	ld hl, $4d70 ; $4cf0
	ld de, $0801 ; $4cf3
	call LoadPaletteShadow ; $4cf6
	pop af ; $4cf9
	wram_bank ; $4cfa
	ret ; $4cfe
Func_13_4cff:
	ld hl, $4d20 ; $4cff
	ld c, $00 ; $4d02
	ld b, $08 ; $4d04
	call QueueSpriteTemplate ; $4d06
	ret ; $4d09
	ld a, [$c2b0] ; $4d0a
	ld d, a ; $4d0d
	ldh a, [hVBlankCounter] ; $4d0e
	srl a ; $4d10
	and a, $07 ; $4d12
	ld e, a ; $4d14
	ld a, [$c2b1] ; $4d15
	add a, $08 ; $4d18
	sub a, e ; $4d1a
	ld e, a ; $4d1b
	call Func_13_4cff ; $4d1c
	ret ; $4d1f
	INCBIN "data/bank_013/d_4d20.bin" ; $4d20, 88 bytes
Func_13_4d78:
	sound $71 ; $4d78
	ld b, $14 ; $4d7a
	ld c, $08 ; $4d7c
	ld d, $06 ; $4d7e
	ld e, $15 ; $4d80
	ld h, $02 ; $4d82
	ld l, $02 ; $4d84
	farcall FarPtr_0a_7e ; $4d86
	ld b, $00 ; $4d89
	ld c, $15 ; $4d8b
	ld d, $14 ; $4d8d
	ld e, $08 ; $4d8f
	ld h, $02 ; $4d91
	ld l, $02 ; $4d93
	farcall FarPtr_0a_7e ; $4d95
	push af ; $4d98
	ld a, $02 ; $4d99
	farcall FarPtr_WaitScriptFrames ; $4d9b
	pop af ; $4d9e
	ld b, $02 ; $4d9f
	ld c, $15 ; $4da1
	ld d, $14 ; $4da3
	ld e, $08 ; $4da5
	ld h, $02 ; $4da7
	ld l, $02 ; $4da9
	farcall FarPtr_0a_7e ; $4dab
	push af ; $4dae
	ld a, $02 ; $4daf
	farcall FarPtr_WaitScriptFrames ; $4db1
	pop af ; $4db4
	ld b, $04 ; $4db5
	ld c, $15 ; $4db7
	ld d, $14 ; $4db9
	ld e, $08 ; $4dbb
	ld h, $02 ; $4dbd
	ld l, $02 ; $4dbf
	farcall FarPtr_0a_7e ; $4dc1
	push af ; $4dc4
	ld a, $02 ; $4dc5
	farcall FarPtr_WaitScriptFrames ; $4dc7
	pop af ; $4dca
	ret ; $4dcb
Func_13_4dcc:
	sound $71 ; $4dcc
	ld b, $04 ; $4dce
	ld c, $15 ; $4dd0
	ld d, $14 ; $4dd2
	ld e, $08 ; $4dd4
	ld h, $02 ; $4dd6
	ld l, $02 ; $4dd8
	farcall FarPtr_0a_7e ; $4dda
	push af ; $4ddd
	ld a, $01 ; $4dde
	farcall FarPtr_WaitScriptFrames ; $4de0
	pop af ; $4de3
	ld b, $02 ; $4de4
	ld c, $15 ; $4de6
	ld d, $14 ; $4de8
	ld e, $08 ; $4dea
	ld h, $02 ; $4dec
	ld l, $02 ; $4dee
	farcall FarPtr_0a_7e ; $4df0
	push af ; $4df3
	ld a, $01 ; $4df4
	farcall FarPtr_WaitScriptFrames ; $4df6
	pop af ; $4df9
	ld b, $00 ; $4dfa
	ld c, $15 ; $4dfc
	ld d, $14 ; $4dfe
	ld e, $08 ; $4e00
	ld h, $02 ; $4e02
	ld l, $02 ; $4e04
	farcall FarPtr_0a_7e ; $4e06
	push af ; $4e09
	ld a, $01 ; $4e0a
	farcall FarPtr_WaitScriptFrames ; $4e0c
	pop af ; $4e0f
	ld b, $06 ; $4e10
	ld c, $15 ; $4e12
	ld d, $14 ; $4e14
	ld e, $08 ; $4e16
	ld h, $02 ; $4e18
	ld l, $02 ; $4e1a
	farcall FarPtr_0a_7e ; $4e1c
	ret ; $4e1f
StoryCmdHandlersB_13:
	; $4e20, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $4e62 ; record 0
	dw $4e93 ; record 1
	dw $4e2e ; record 2
	dw $4eba ; record 3
	dw $4ecb ; record 4
	dw $4eeb ; record 5
	dw $502a ; record 6
	nop ; $4e2e
	nop ; $4e2f
	dec h ; $4e30
	ld a, e ; $4e31
	nop ; $4e32
	dec bc ; $4e33
	nop ; $4e34
	add hl, bc ; $4e35
	ld b, b ; $4e36
	nop ; $4e37
	add hl, hl ; $4e38
	ld bc, $0000 ; $4e39
	nop ; $4e3c
	nop ; $4e3d
	ld e, a ; $4e3e
	ld e, b ; $4e3f
	nop ; $4e40
	ld b, $80 ; $4e41
	INCBIN "data/bank_013/d_4e43.bin" ; $4e43, 31 bytes
	ld bc, $00c0 ; $4e62
	dec bc ; $4e65
	nop ; $4e66
	dec c ; $4e67
	nop ; $4e68
	nop ; $4e69
	ld [bc], a ; $4e6a
	ret nz ; $4e6b
	nop ; $4e6c
	dec bc ; $4e6d
	nop ; $4e6e
	inc de ; $4e6f
	nop ; $4e70
	nop ; $4e71
	inc bc ; $4e72
	ret nz ; $4e73
	nop ; $4e74
	dec bc ; $4e75
	nop ; $4e76
	dec c ; $4e77
	nop ; $4e78
	nop ; $4e79
	inc b ; $4e7a
	ret nz ; $4e7b
	nop ; $4e7c
	dec bc ; $4e7d
	nop ; $4e7e
	dec c ; $4e7f
	nop ; $4e80
	nop ; $4e81
	ld c, $c0 ; $4e82
	nop ; $4e84
	dec bc ; $4e85
	nop ; $4e86
	dec c ; $4e87
	nop ; $4e88
	nop ; $4e89
	rrca ; $4e8a
	ret nz ; $4e8b
	nop ; $4e8c
	dec bc ; $4e8d
	nop ; $4e8e
	dec c ; $4e8f
	nop ; $4e90
	nop ; $4e91
	rst Rst38 ; $4e92
	ld bc, $00ff ; $4e93
	nop ; $4e96
	ld c, l ; $4e97
	ld a, e ; $4e98
	add hl, bc ; $4e99
	ld [bc], a ; $4e9a
	ld [bc], a ; $4e9b
	rst Rst38 ; $4e9c
	nop ; $4e9d
	nop ; $4e9e
	ld c, l ; $4e9f
	ld a, e ; $4ea0
	nop ; $4ea1
	ld bc, $cdff ; $4ea2
	ld a, [hl-] ; $4ea5
	ld a, [bc] ; $4ea6
	ld a, l ; $4ea7
	and a, $07 ; $4ea8
	add a, $3c ; $4eaa
	ld l, a ; $4eac
	adc a, $05 ; $4ead
	sub a, l ; $4eaf
	ld h, a ; $4eb0
	farcall FarPtr_0a_0e ; $4eb1
	ld a, $04 ; $4eb4
	farcall FarPtr_0a_08 ; $4eb6
	ret ; $4eb9
	inc bc ; $4eba
	rst Rst38 ; $4ebb
	nop ; $4ebc
	nop ; $4ebd
	or a, b ; $4ebe
	ld d, d ; $4ebf
	nop ; $4ec0
	nop ; $4ec1
	inc b ; $4ec2
	rst Rst38 ; $4ec3
	nop ; $4ec4
	nop ; $4ec5
	and a, h ; $4ec6
	ld c, [hl] ; $4ec7
	inc de ; $4ec8
	nop ; $4ec9
	rst Rst38 ; $4eca
	ld bc, $00ff ; $4ecb
	nop ; $4ece
	call nc, Func_00_004e ; $4ecf
	nop ; $4ed2
	rst Rst38 ; $4ed3
	farcall FarPtr_0a_00 ; $4ed4
	ld c, $10 ; $4ed7
	call BeginFadeIn ; $4ed9
	ld hl, $0483 ; $4edc
	farcall FarPtr_0a_0e ; $4edf
	ld a, $00 ; $4ee2
	farcall FarPtr_0a_08 ; $4ee4
	farcall FarPtr_0a_02 ; $4ee7
	ret ; $4eea
	rrca ; $4eeb
	add a, b ; $4eec
	nop ; $4eed
	nop ; $4eee
	INCBIN "data/bank_013/d_4eef.bin" ; $4eef, 5 bytes
	ld a, $03 ; $4ef4
	farcall FarPtr_0a_1c ; $4ef6
	ld a, $03 ; $4ef9
	ld hl, $0544 ; $4efb
	farcall FarPtr_0a_0e ; $4efe
	test_flag $1c, 0 ; $4f01
	jr z, Label_13_4f0c ; $4f04
	ld hl, $0548 ; $4f06
	farcall FarPtr_0a_0e ; $4f09
Label_13_4f0c:
	ld a, $03 ; $4f0c
	ld de, $ff80 ; $4f0e
	farcall FarPtr_0a_42 ; $4f11
	ld a, $03 ; $4f14
	call Func_13_5bfb ; $4f16
	call Func_13_5c27 ; $4f19
	sound $97 ; $4f1c
	push af ; $4f1e
	ld a, $46 ; $4f1f
	farcall FarPtr_WaitScriptFrames ; $4f21
	pop af ; $4f24
	ld a, $05 ; $4f25
	ld bc, $3f00 ; $4f27
	ld de, $3f00 ; $4f2a
	farcall FarPtr_ScriptSetActorPosition ; $4f2d
	ld a, $03 ; $4f30
	farcall FarPtr_0a_08 ; $4f32
	ld a, $00 ; $4f35
	ld b, a ; $4f37
	ld a, $03 ; $4f38
	farcall FarPtr_FaceActorTowardActor ; $4f3a
	ld a, $03 ; $4f3d
	ld b, a ; $4f3f
	ld a, $00 ; $4f40
	farcall FarPtr_FaceActorTowardActor ; $4f42
	ld a, $06 ; $4f45
	ld bc, $0c00 ; $4f47
	ld de, $0800 ; $4f4a
	farcall FarPtr_ScriptSetActorPosition ; $4f4d
	ld a, $03 ; $4f50
	ld d, $02 ; $4f52
	farcall FarPtr_ScriptSetActorAnimation ; $4f54
	ld a, $03 ; $4f57
	farcall FarPtr_ScriptWaitActorIdle ; $4f59
	ld a, $06 ; $4f5c
	ld bc, $3f00 ; $4f5e
	ld de, $3f00 ; $4f61
	farcall FarPtr_ScriptSetActorPosition ; $4f64
	ld a, $03 ; $4f67
	farcall FarPtr_0a_08 ; $4f69
	ld a, $00 ; $4f6c
	ld de, $ff80 ; $4f6e
	farcall FarPtr_0a_42 ; $4f71
	ld a, $00 ; $4f74
	farcall FarPtr_0a_44 ; $4f76
	test_flag $05, 7 ; $4f79
	jr nz, Label_13_4fd0 ; $4f7c
	ld a, $03 ; $4f7e
	farcall FarPtr_0a_08 ; $4f80
	ld a, $00 ; $4f83
	ld d, $03 ; $4f85
	farcall FarPtr_ScriptSetActorAnimation ; $4f87
	ld a, $00 ; $4f8a
	farcall FarPtr_ScriptWaitActorIdle ; $4f8c
	ld a, $00 ; $4f8f
	ld bc, $0030 ; $4f91
	farcall FarPtr_0a_18 ; $4f94
	ld a, $00 ; $4f97
	ld bc, $0b00 ; $4f99
	ld de, $1400 ; $4f9c
	farcall FarPtr_ScriptSetActorMoveTarget ; $4f9f
	push af ; $4fa2
	ld a, $0a ; $4fa3
	farcall FarPtr_WaitScriptFrames ; $4fa5
	pop af ; $4fa8
	ld a, $00 ; $4fa9
	ld b, a ; $4fab
	ld a, $03 ; $4fac
	farcall FarPtr_FaceActorTowardActor ; $4fae
	ld a, $06 ; $4fb1
	ld [wStoryModeCurrentLocation], a ; $4fb3
	ld a, $0d ; $4fb6
	ld [$c295], a ; $4fb8
	ld a, $ff ; $4fbb
	ld [$c294], a ; $4fbd
	ld [$c2a1], a ; $4fc0
	ld c, $04 ; $4fc3
	call BeginFadeOut ; $4fc5
	push af ; $4fc8
	ld a, $14 ; $4fc9
	farcall FarPtr_WaitScriptFrames ; $4fcb
	pop af ; $4fce
	ret ; $4fcf
Label_13_4fd0:
	farcall FarPtr_0a_10 ; $4fd0
	ld a, $03 ; $4fd3
	farcall FarPtr_0a_08 ; $4fd5
	ld a, $00 ; $4fd8
	ld d, $03 ; $4fda
	farcall FarPtr_ScriptSetActorAnimation ; $4fdc
	ld a, $00 ; $4fdf
	farcall FarPtr_ScriptWaitActorIdle ; $4fe1
	ld a, $03 ; $4fe4
	farcall FarPtr_GetActorStateAddr ; $4fe6
	ld c, l ; $4fe9
	ld b, h ; $4fea
	ld de, $d000 ; $4feb
	farcall FarPtr_04_20 ; $4fee
	ld a, $00 ; $4ff1
	ld bc, $0030 ; $4ff3
	farcall FarPtr_0a_18 ; $4ff6
	ld a, $00 ; $4ff9
	ld bc, $0b00 ; $4ffb
	ld de, $1400 ; $4ffe
	farcall FarPtr_ScriptSetActorMoveTarget ; $5001
	push af ; $5004
	ld a, $0a ; $5005
	farcall FarPtr_WaitScriptFrames ; $5007
	pop af ; $500a
	ld a, $06 ; $500b
	ld [wStoryModeCurrentLocation], a ; $500d
	ld a, $0d ; $5010
	ld [$c295], a ; $5012
	ld a, $ff ; $5015
	ld [$c294], a ; $5017
	ld [$c2a1], a ; $501a
	ld c, $04 ; $501d
	call BeginFadeOut ; $501f
	push af ; $5022
	ld a, $14 ; $5023
	farcall FarPtr_WaitScriptFrames ; $5025
	pop af ; $5028
	ret ; $5029
	xor a, a ; $502a
	ld [$c2d5], a ; $502b
	ld a, [$c295] ; $502e
	cp a, $0a ; $5031
	jp z, Label_13_5a76 ; $5033
	cp a, $09 ; $5036
	jp z, Label_13_5a92 ; $5038
	cp a, $08 ; $503b
	jp z, Label_13_5aae ; $503d
	call Func_13_7d58 ; $5040
	call Func_13_5130 ; $5043
	call Func_13_51b0 ; $5046
	call Func_13_5067 ; $5049
	ld a, [$c295] ; $504c
	cp a, $0f ; $504f
	jp z, Label_13_53a1 ; $5051
	sound $1c ; $5054
	ld a, [$c295] ; $5056
	cp a, $01 ; $5059
	jp z, Label_13_52e7 ; $505b
	cp a, $02 ; $505e
	jp z, Label_13_5593 ; $5060
	farcall FarPtr_0a_02 ; $5063
	ret ; $5066
Func_13_5067:
	test_flag $05, 7 ; $5067
	jr nz, Label_13_507c ; $506a
	test_flag $0b, 0 ; $506c
	jr nz, Label_13_5074 ; $506f
	jr Label_13_50de ; $5071
	ret ; $5073
Label_13_5074:
	test_flag $15, 6 ; $5074
	jr z, Label_13_508c ; $5077
	jr Label_13_50de ; $5079
	ret ; $507b
Label_13_507c:
	test_flag $09, 0 ; $507c
	jr nz, Label_13_5084 ; $507f
	jr Label_13_50de ; $5081
	ret ; $5083
Label_13_5084:
	test_flag $15, 7 ; $5084
	jr z, Label_13_508c ; $5087
	jr Label_13_50de ; $5089
	ret ; $508b
Label_13_508c:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	farcall FarPtr_0a_8a ; $5092
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	farcall FarPtr_0a_8a ; $509b
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	farcall FarPtr_0a_8a ; $50a4
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	farcall FarPtr_0a_8a ; $50ad
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	farcall FarPtr_0a_8a ; $50b6
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	farcall FarPtr_0a_8a ; $50bf
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	farcall FarPtr_0a_8a ; $50c8
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	farcall FarPtr_0a_8a ; $50d1
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	farcall FarPtr_0a_8a ; $50da
	ret ; $50dd
Label_13_50de:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	farcall FarPtr_0a_8a ; $50e4
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	farcall FarPtr_0a_8a ; $50ed
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	farcall FarPtr_0a_8a ; $50f6
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	farcall FarPtr_0a_8a ; $50ff
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	farcall FarPtr_0a_8a ; $5108
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	farcall FarPtr_0a_8a ; $5111
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	farcall FarPtr_0a_8a ; $511a
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	farcall FarPtr_0a_8a ; $5123
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	farcall FarPtr_0a_8a ; $512c
	ret ; $512f
Func_13_5130:
	ld a, [$c94d] ; $5130
	or a, a ; $5133
	jr nz, Label_13_51ac ; $5134
	farcall FarPtr_WaitPlayerMoveDone ; $5136
	ld b, $20 ; $5139
	ld c, $00 ; $513b
	ld d, $00 ; $513d
	ld e, $00 ; $513f
	ld h, $16 ; $5141
	ld l, $16 ; $5143
	farcall FarPtr_0a_80 ; $5145
	ld b, $20 ; $5148
	ld c, $00 ; $514a
	ld d, $00 ; $514c
	ld e, $00 ; $514e
	ld h, $16 ; $5150
	ld l, $16 ; $5152
	farcall FarPtr_0a_82 ; $5154
	ld b, $20 ; $5157
	ld c, $00 ; $5159
	ld d, $00 ; $515b
	ld e, $00 ; $515d
	ld h, $16 ; $515f
	ld l, $18 ; $5161
	farcall FarPtr_0a_7e ; $5163
	ld d, $28 ; $5166
	ld a, $03 ; $5168
	farcall FarPtr_GetActorStateAddr ; $516a
	ld c, l ; $516d
	ld b, h ; $516e
	farcall FarPtr_04_2c ; $516f
	ld a, $03 ; $5172
	ld d, $01 ; $5174
	farcall FarPtr_ScriptSetActorAnimation ; $5176
	ld a, $04 ; $5179
	ld bc, $1f00 ; $517b
	ld de, $1500 ; $517e
	farcall FarPtr_ScriptSetActorPosition ; $5181
	ld a, $04 ; $5184
	farcall FarPtr_0a_1c ; $5186
	set_flag $1c, 0 ; $5189
	ld a, $02 ; $518c
	ld [$c329], a ; $518e
	ld a, $02 ; $5191
	ld [$c32a], a ; $5193
	ld a, $16 ; $5196
	ld [$c32b], a ; $5198
	ld a, $14 ; $519b
	ld [$c32c], a ; $519d
	call DisableLCDSafely ; $51a0
	ld a, $00 ; $51a3
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $51a5
	call EnableLCD ; $51a8
	ret ; $51ab
Label_13_51ac:
	call Func_13_524e ; $51ac
	ret ; $51af
Func_13_51b0:
	ld a, [$c295] ; $51b0
	cp a, $ff ; $51b3
	jr z, Label_13_521b ; $51b5
	cp a, $01 ; $51b7
	jr z, Label_13_51d3 ; $51b9
	wram_bank $04 ; $51bb
	test_flag $05, 7 ; $51c1
	jp nz, Label_13_527a ; $51c4
	ld a, $03 ; $51c7
	ld bc, $0b00 ; $51c9
	ld de, $0a00 ; $51cc
	farcall FarPtr_ScriptSetActorPosition ; $51cf
	ret ; $51d2
Label_13_51d3:
	test_flag $05, 7 ; $51d3
	jr z, Label_13_5208 ; $51d6
	ld a, $03 ; $51d8
	ld bc, $0b00 ; $51da
	ld de, $0a00 ; $51dd
	farcall FarPtr_ScriptSetActorPosition ; $51e0
	ld a, $03 ; $51e3
	ld b, $40 ; $51e5
	farcall FarPtr_SetActorFacing ; $51e7
	ld a, $02 ; $51ea
	farcall FarPtr_0a_1c ; $51ec
	ld a, $02 ; $51ef
	ld bc, $0100 ; $51f1
	ld de, $0100 ; $51f4
	farcall FarPtr_ScriptSetActorPosition ; $51f7
	ld a, $03 ; $51fa
	farcall FarPtr_GetActorStateAddr ; $51fc
	ld c, l ; $51ff
	ld b, h ; $5200
	ld hl, $0005 ; $5201
	add hl, bc ; $5204
	set 4, [hl] ; $5205
	ret ; $5207
Label_13_5208:
	ld a, $03 ; $5208
	ld bc, $0b00 ; $520a
	ld de, $0a00 ; $520d
	farcall FarPtr_ScriptSetActorPosition ; $5210
	ld a, $03 ; $5213
	ld b, $40 ; $5215
	farcall FarPtr_SetActorFacing ; $5217
	ret ; $521a
Label_13_521b:
	test_flag $05, 7 ; $521b
	jr z, Label_13_5208 ; $521e
	ld a, $02 ; $5220
	farcall FarPtr_0a_1c ; $5222
	ld a, $02 ; $5225
	ld bc, $0100 ; $5227
	ld de, $0100 ; $522a
	farcall FarPtr_ScriptSetActorPosition ; $522d
	call Func_13_5c39 ; $5230
	ld a, $03 ; $5233
	farcall FarPtr_GetActorStateAddr ; $5235
	ld c, l ; $5238
	ld b, h ; $5239
	ld de, $d000 ; $523a
	farcall FarPtr_04_20 ; $523d
	ld a, $03 ; $5240
	farcall FarPtr_GetActorStateAddr ; $5242
	ld c, l ; $5245
	ld b, h ; $5246
	ld hl, $0005 ; $5247
	add hl, bc ; $524a
	set 4, [hl] ; $524b
	ret ; $524d
Func_13_524e:
	call AdvanceRandomSeed ; $524e
	ld a, l ; $5251
	and a, $07 ; $5252
	add a, a ; $5254
	add a, $6a ; $5255
	ld l, a ; $5257
	adc a, $52 ; $5258
	sub a, l ; $525a
	ld h, a ; $525b
	ld a, [hl+] ; $525c
	ld h, [hl] ; $525d
	ld l, a ; $525e
	ld e, l ; $525f
	ld d, h ; $5260
	ldh a, [hRomBank] ; $5261
	ld b, a ; $5263
	ld a, $04 ; $5264
	farcall FarPtr_0a_1a ; $5266
	ret ; $5269
StoryCmdHandlersC_13:
	; $526a, 16 bytes (records:2)
; 8 records x 2 bytes
	dw $585f ; record 0
	dw $5877 ; record 1
	dw $5881 ; record 2
	dw $588b ; record 3
	dw $585f ; record 4
	dw $585f ; record 5
	dw $588b ; record 6
	dw $588b ; record 7
Label_13_527a:
	ld a, $02 ; $527a
	farcall FarPtr_0a_1c ; $527c
	ld a, $02 ; $527f
	ld bc, $1500 ; $5281
	ld de, $1f00 ; $5284
	farcall FarPtr_ScriptSetActorPosition ; $5287
	ld a, $03 ; $528a
	ld bc, $0b00 ; $528c
	ld de, $1000 ; $528f
	farcall FarPtr_ScriptSetActorPosition ; $5292
	ld a, $03 ; $5295
	ld b, $c0 ; $5297
	farcall FarPtr_SetActorFacing ; $5299
	ld c, $04 ; $529c
	call BeginFadeIn ; $529e
	call WaitFadeEnd ; $52a1
	ld a, $03 ; $52a4
	ld bc, $0b00 ; $52a6
	ld de, $0a00 ; $52a9
	farcall FarPtr_ScriptSetActorMoveTarget ; $52ac
	ret ; $52af
	ld a, $00 ; $52b0
	ld b, a ; $52b2
	ld a, $03 ; $52b3
	farcall FarPtr_FaceActorTowardActor ; $52b5
	test_flag $1c, 0 ; $52b8
	jr z, Label_13_52c5 ; $52bb
	ld hl, $0521 ; $52bd
	farcall FarPtr_0a_0e ; $52c0
	jr Label_13_52cb ; $52c3
Label_13_52c5:
	ld hl, $04ff ; $52c5
	farcall FarPtr_0a_0e ; $52c8
Label_13_52cb:
	ld a, $03 ; $52cb
	farcall FarPtr_0a_0a ; $52cd
	farcall FarPtr_0a_12 ; $52d0
	farcall FarPtr_0a_0c ; $52d3
	push af ; $52d6
	ld a, $05 ; $52d7
	farcall FarPtr_WaitScriptFrames ; $52d9
	pop af ; $52dc
	and a, a ; $52dd
	jr nz, Label_13_52e3 ; $52de
	call Func_13_58be ; $52e0
Label_13_52e3:
	call Func_13_56bb ; $52e3
	ret ; $52e6
Label_13_52e7:
	call Func_13_5aca ; $52e7
	cp a, $01 ; $52ea
	jp z, Label_13_5aee ; $52ec
	test_flag $1c, 0 ; $52ef
	jr z, Label_13_52fc ; $52f2
	ld hl, $0507 ; $52f4
	farcall FarPtr_0a_0e ; $52f7
	jr Label_13_5302 ; $52fa
Label_13_52fc:
	ld hl, $0502 ; $52fc
	farcall FarPtr_0a_0e ; $52ff
Label_13_5302:
	ld a, $02 ; $5302
	farcall FarPtr_0a_1c ; $5304
	ld a, $02 ; $5307
	ld bc, $0b00 ; $5309
	ld de, $1e00 ; $530c
	farcall FarPtr_ScriptSetActorPosition ; $530f
	ld a, $02 ; $5312
	ld b, $40 ; $5314
	farcall FarPtr_SetActorFacing ; $5316
	ld a, $03 ; $5319
	ld bc, $0b00 ; $531b
	ld de, $0a00 ; $531e
	farcall FarPtr_ScriptSetActorPosition ; $5321
	ld a, $03 ; $5324
	ld b, $40 ; $5326
	farcall FarPtr_SetActorFacing ; $5328
	ld c, $04 ; $532b
	call BeginFadeIn ; $532d
	call WaitFadeEnd ; $5330
	test_flag $05, 7 ; $5333
	jr z, Label_13_538f ; $5336
	farcall FarPtr_0a_10 ; $5338
	test_flag $15, 7 ; $533b
	jr nz, Label_13_5355 ; $533e
	ld a, $03 ; $5340
	farcall FarPtr_0a_08 ; $5342
	test_flag $08, 2 ; $5345
	jr z, Label_13_5355 ; $5348
	farcall FarPtr_0a_10 ; $534a
	test_flag $08, 6 ; $534d
	jr z, Label_13_5355 ; $5350
	farcall FarPtr_0a_10 ; $5352
Label_13_5355:
	ld a, $03 ; $5355
	farcall FarPtr_0a_08 ; $5357
	ld a, $00 ; $535a
	ld d, $03 ; $535c
	farcall FarPtr_ScriptSetActorAnimation ; $535e
	ld a, $00 ; $5361
	farcall FarPtr_ScriptWaitActorIdle ; $5363
	ld a, $03 ; $5366
	farcall FarPtr_GetActorStateAddr ; $5368
	ld c, l ; $536b
	ld b, h ; $536c
	ld de, $d000 ; $536d
	farcall FarPtr_04_20 ; $5370
	ld a, $00 ; $5373
	ld b, $40 ; $5375
	farcall FarPtr_SetActorFacing ; $5377
	ld a, $03 ; $537a
	farcall FarPtr_GetActorStateAddr ; $537c
	ld c, l ; $537f
	ld b, h ; $5380
	ld hl, $0005 ; $5381
	add hl, bc ; $5384
	set 4, [hl] ; $5385
	push af ; $5387
	ld a, $05 ; $5388
	farcall FarPtr_WaitScriptFrames ; $538a
	pop af ; $538d
	ret ; $538e
Label_13_538f:
	ld a, $03 ; $538f
	farcall FarPtr_0a_08 ; $5391
	ld a, $00 ; $5394
	ld d, $03 ; $5396
	farcall FarPtr_ScriptSetActorAnimation ; $5398
	ld a, $00 ; $539b
	farcall FarPtr_ScriptWaitActorIdle ; $539d
	ret ; $53a0
Label_13_53a1:
	sound $41 ; $53a1
	ld a, $00 ; $53a3
	ld bc, $0010 ; $53a5
	farcall FarPtr_0a_18 ; $53a8
	ld bc, $0040 ; $53ab
	farcall FarPtr_0a_38 ; $53ae
	test_flag $1c, 0 ; $53b1
	jr z, Label_13_53be ; $53b4
	ld hl, $0516 ; $53b6
	farcall FarPtr_0a_0e ; $53b9
	jr Label_13_53c4 ; $53bc
Label_13_53be:
	ld hl, $04f4 ; $53be
	farcall FarPtr_0a_0e ; $53c1
Label_13_53c4:
	ld a, $00 ; $53c4
	ld bc, $0b00 ; $53c6
	ld de, $0e00 ; $53c9
	farcall FarPtr_ScriptSetActorPosition ; $53cc
	ld a, $03 ; $53cf
	ld bc, $0b00 ; $53d1
	ld de, $0a00 ; $53d4
	farcall FarPtr_ScriptSetActorPosition ; $53d7
	xor a, a ; $53da
	ld bc, $0b00 ; $53db
	ld de, $0a00 ; $53de
	farcall FarPtr_MovePlayerToPosition ; $53e1
	farcall FarPtr_WaitPlayerMoveDone ; $53e4
	push af ; $53e7
	ld a, $78 ; $53e8
	farcall FarPtr_WaitScriptFrames ; $53ea
	pop af ; $53ed
	push af ; $53ee
	ld a, $b4 ; $53ef
	farcall FarPtr_WaitScriptFrames ; $53f1
	pop af ; $53f4
	ld c, $04 ; $53f5
	call BeginFadeIn ; $53f7
	call WaitJingleEnd ; $53fa
	sound $1c ; $53fd
	push af ; $53ff
	ld a, $0a ; $5400
	farcall FarPtr_WaitScriptFrames ; $5402
	pop af ; $5405
	ld a, $03 ; $5406
	farcall FarPtr_0a_0a ; $5408
	farcall FarPtr_0a_12 ; $540b
	farcall FarPtr_0a_0c ; $540e
	push af ; $5411
	ld a, $05 ; $5412
	farcall FarPtr_WaitScriptFrames ; $5414
	pop af ; $5417
	and a, a ; $5418
	jr nz, Label_13_5425 ; $5419
	ld a, $03 ; $541b
	farcall FarPtr_0a_08 ; $541d
	farcall FarPtr_0a_10 ; $5420
	jr Label_13_5430 ; $5423
Label_13_5425:
	farcall FarPtr_0a_10 ; $5425
	ld a, $03 ; $5428
	farcall FarPtr_0a_08 ; $542a
	set_flag $1c, 1 ; $542d
Label_13_5430:
	ld a, $03 ; $5430
	ld bc, $0010 ; $5432
	farcall FarPtr_0a_18 ; $5435
	ld a, $03 ; $5438
	ld d, $03 ; $543a
	farcall FarPtr_ScriptSetActorAnimation ; $543c
	ld a, $03 ; $543f
	farcall FarPtr_ScriptWaitActorIdle ; $5441
	ld a, $03 ; $5444
	farcall FarPtr_0a_08 ; $5446
	ld a, $03 ; $5449
	ld bc, $0900 ; $544b
	ld de, $0a00 ; $544e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5451
	ld a, $03 ; $5454
	farcall FarPtr_0a_08 ; $5456
	ld a, $03 ; $5459
	farcall FarPtr_ScriptWaitActorMoveDone ; $545b
	ld a, $03 ; $545e
	ld bc, $0d00 ; $5460
	ld de, $0a00 ; $5463
	farcall FarPtr_ScriptSetActorMoveTarget ; $5466
	ld a, $03 ; $5469
	farcall FarPtr_0a_08 ; $546b
	ld a, $03 ; $546e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5470
	ld a, $03 ; $5473
	ld bc, $0b00 ; $5475
	ld de, $0a00 ; $5478
	farcall FarPtr_ScriptSetActorMoveTarget ; $547b
	ld a, $03 ; $547e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5480
	ld a, $00 ; $5483
	ld b, a ; $5485
	ld a, $03 ; $5486
	farcall FarPtr_FaceActorTowardActor ; $5488
	ld a, $03 ; $548b
	farcall FarPtr_0a_0a ; $548d
	farcall FarPtr_0a_12 ; $5490
	farcall FarPtr_0a_0c ; $5493
	push af ; $5496
	ld a, $05 ; $5497
	farcall FarPtr_WaitScriptFrames ; $5499
	pop af ; $549c
	and a, a ; $549d
	jr nz, Label_13_54aa ; $549e
	ld a, $03 ; $54a0
	farcall FarPtr_0a_08 ; $54a2
	farcall FarPtr_0a_10 ; $54a5
	jr Label_13_54b2 ; $54a8
Label_13_54aa:
	farcall FarPtr_0a_10 ; $54aa
	ld a, $03 ; $54ad
	farcall FarPtr_0a_08 ; $54af
Label_13_54b2:
	ld a, $03 ; $54b2
	ld bc, $0b00 ; $54b4
	ld de, $0b00 ; $54b7
	farcall FarPtr_ScriptSetActorMoveTarget ; $54ba
	ld a, $03 ; $54bd
	farcall FarPtr_ScriptWaitActorMoveDone ; $54bf
	ld a, $03 ; $54c2
	ld d, $02 ; $54c4
	farcall FarPtr_ScriptSetActorAnimation ; $54c6
	ld a, $03 ; $54c9
	farcall FarPtr_ScriptWaitActorIdle ; $54cb
	ld a, $03 ; $54ce
	farcall FarPtr_0a_08 ; $54d0
	ld a, $03 ; $54d3
	ld d, $03 ; $54d5
	farcall FarPtr_ScriptSetActorAnimation ; $54d7
	ld a, $03 ; $54da
	farcall FarPtr_ScriptWaitActorIdle ; $54dc
	ld a, $03 ; $54df
	farcall FarPtr_0a_08 ; $54e1
	ld a, $03 ; $54e4
	ld d, $03 ; $54e6
	farcall FarPtr_ScriptSetActorAnimation ; $54e8
	ld a, $03 ; $54eb
	farcall FarPtr_ScriptWaitActorIdle ; $54ed
	ld a, $03 ; $54f0
	farcall FarPtr_0a_0a ; $54f2
	farcall FarPtr_0a_12 ; $54f5
	farcall FarPtr_0a_0c ; $54f8
	push af ; $54fb
	ld a, $05 ; $54fc
	farcall FarPtr_WaitScriptFrames ; $54fe
	pop af ; $5501
	and a, a ; $5502
	jr nz, Label_13_5508 ; $5503
	call Func_13_58be ; $5505
Label_13_5508:
	test_flag $1c, 0 ; $5508
	jr nz, Label_13_5550 ; $550b
	test_flag $1c, 1 ; $550d
	jr nz, Label_13_5531 ; $5510
	push af ; $5512
	ld a, $14 ; $5513
	farcall FarPtr_WaitScriptFrames ; $5515
	pop af ; $5518
	ld a, $03 ; $5519
	ld d, $03 ; $551b
	farcall FarPtr_ScriptSetActorAnimation ; $551d
	ld a, $03 ; $5520
	farcall FarPtr_ScriptWaitActorIdle ; $5522
	ld hl, $0500 ; $5525
	farcall FarPtr_0a_0e ; $5528
	ld a, $03 ; $552b
	farcall FarPtr_0a_08 ; $552d
	ret ; $5530
Label_13_5531:
	push af ; $5531
	ld a, $14 ; $5532
	farcall FarPtr_WaitScriptFrames ; $5534
	pop af ; $5537
	ld a, $03 ; $5538
	ld d, $03 ; $553a
	farcall FarPtr_ScriptSetActorAnimation ; $553c
	ld a, $03 ; $553f
	farcall FarPtr_ScriptWaitActorIdle ; $5541
	ld hl, $0501 ; $5544
	farcall FarPtr_0a_0e ; $5547
	ld a, $03 ; $554a
	farcall FarPtr_0a_08 ; $554c
	ret ; $554f
Label_13_5550:
	test_flag $1c, 1 ; $5550
	jr nz, Label_13_5574 ; $5553
	push af ; $5555
	ld a, $14 ; $5556
	farcall FarPtr_WaitScriptFrames ; $5558
	pop af ; $555b
	ld a, $03 ; $555c
	ld d, $03 ; $555e
	farcall FarPtr_ScriptSetActorAnimation ; $5560
	ld a, $03 ; $5563
	farcall FarPtr_ScriptWaitActorIdle ; $5565
	ld hl, $0523 ; $5568
	farcall FarPtr_0a_0e ; $556b
	ld a, $03 ; $556e
	farcall FarPtr_0a_08 ; $5570
	ret ; $5573
Label_13_5574:
	push af ; $5574
	ld a, $14 ; $5575
	farcall FarPtr_WaitScriptFrames ; $5577
	pop af ; $557a
	ld a, $03 ; $557b
	ld d, $03 ; $557d
	farcall FarPtr_ScriptSetActorAnimation ; $557f
	ld a, $03 ; $5582
	farcall FarPtr_ScriptWaitActorIdle ; $5584
	ld hl, $0522 ; $5587
	farcall FarPtr_0a_0e ; $558a
	ld a, $03 ; $558d
	farcall FarPtr_0a_08 ; $558f
	ret ; $5592
Label_13_5593:
	test_flag $1c, 0 ; $5593
	jr z, Label_13_55a3 ; $5596
	ld hl, $c2b2 ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr Label_13_55ac ; $55a1
Label_13_55a3:
	ld hl, $c2b2 ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
Label_13_55ac:
	ld hl, $c2b2 ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	farcall FarPtr_0a_0e ; $55b2
	test_flag $05, 7 ; $55b5
	jr z, Label_13_55bd ; $55b8
	farcall FarPtr_0a_10 ; $55ba
Label_13_55bd:
	push af ; $55bd
	ld a, $1e ; $55be
	farcall FarPtr_WaitScriptFrames ; $55c0
	pop af ; $55c3
	ld a, $00 ; $55c4
	ld bc, $0b00 ; $55c6
	ld de, $0e00 ; $55c9
	farcall FarPtr_ScriptSetActorMoveTarget ; $55cc
	ld c, $04 ; $55cf
	call BeginFadeIn ; $55d1
	call WaitFadeEnd ; $55d4
	xor a, a ; $55d7
	ld bc, $0b00 ; $55d8
	ld de, $0c40 ; $55db
	farcall FarPtr_MovePlayerToPosition ; $55de
	farcall FarPtr_WaitPlayerMoveDone ; $55e1
	ld a, $03 ; $55e4
	ld b, $40 ; $55e6
	farcall FarPtr_SetActorFacing ; $55e8
	ld a, $03 ; $55eb
	ld d, $03 ; $55ed
	farcall FarPtr_ScriptSetActorAnimation ; $55ef
	ld a, $03 ; $55f2
	farcall FarPtr_ScriptWaitActorIdle ; $55f4
	ld a, $03 ; $55f7
	farcall FarPtr_0a_08 ; $55f9
	call Func_13_5aca ; $55fc
	and a, a ; $55ff
	jp z, Label_13_560d ; $5600
	ld hl, $c2b2 ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr Label_13_5615 ; $560b
Label_13_560d:
	ld hl, $c2b2 ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
Label_13_5615:
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_13_561a ; $5617
	inc h ; $5619
Label_13_561a:
	farcall FarPtr_0a_0e ; $561a
	ld a, $03 ; $561d
	ld d, $04 ; $561f
	farcall FarPtr_ScriptSetActorAnimation ; $5621
	ld a, $03 ; $5624
	farcall FarPtr_ScriptWaitActorIdle ; $5626
	ld a, $03 ; $5629
	farcall FarPtr_0a_0a ; $562b
	farcall FarPtr_0a_12 ; $562e
	farcall FarPtr_0a_0c ; $5631
	push af ; $5634
	ld a, $05 ; $5635
	farcall FarPtr_WaitScriptFrames ; $5637
	pop af ; $563a
	and a, a ; $563b
	jr nz, Label_13_568f ; $563c
	ld hl, $c2b2 ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add a, l ; $5646
	ld l, a ; $5647
	jr nc, Label_13_564b ; $5648
	inc h ; $564a
Label_13_564b:
	farcall FarPtr_0a_0e ; $564b
	ld a, $03 ; $564e
	farcall FarPtr_0a_08 ; $5650
	sound $00 ; $5653
	push af ; $5655
	ld a, $02 ; $5656
	farcall FarPtr_WaitScriptFrames ; $5658
	pop af ; $565b
	sound $41 ; $565c
	ld a, $00 ; $565e
	ld d, $03 ; $5660
	farcall FarPtr_ScriptSetActorAnimation ; $5662
	ld a, $03 ; $5665
	ld d, $03 ; $5667
	farcall FarPtr_ScriptSetActorAnimation ; $5669
	ld a, $03 ; $566c
	farcall FarPtr_ScriptWaitActorIdle ; $566e
	call WaitJingleEnd ; $5671
	ld c, $04 ; $5674
	call BeginFadeOut ; $5676
	call WaitFadeEnd ; $5679
	ld a, $02 ; $567c
	ld [$c294], a ; $567e
	ld [$c2a1], a ; $5681
	ld b, $0a ; $5684
	ld c, $01 ; $5686
	farcall FarPtr_0a_62 ; $5688
	farcall FarPtr_03_18 ; $568b
	ret ; $568e
Label_13_568f:
	ld hl, $c2b2 ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add a, l ; $5697
	ld l, a ; $5698
	jr nc, Label_13_569c ; $5699
	inc h ; $569b
Label_13_569c:
	farcall FarPtr_0a_0e ; $569c
	ld a, $03 ; $569f
	farcall FarPtr_0a_0a ; $56a1
	farcall FarPtr_0a_12 ; $56a4
	farcall FarPtr_0a_0c ; $56a7
	push af ; $56aa
	ld a, $05 ; $56ab
	farcall FarPtr_WaitScriptFrames ; $56ad
	pop af ; $56b0
	and a, a ; $56b1
	jr nz, Label_13_56b7 ; $56b2
	call Func_13_58be ; $56b4
Label_13_56b7:
	call Func_13_56bb ; $56b7
	ret ; $56ba
Func_13_56bb:
	test_flag $05, 7 ; $56bb
	jp nz, Label_13_5782 ; $56be
	test_flag $1c, 0 ; $56c1
	jr nz, Label_13_56ce ; $56c4
	ld hl, $0536 ; $56c6
	farcall FarPtr_0a_0e ; $56c9
	jr Label_13_56d4 ; $56cc
Label_13_56ce:
	ld hl, $0530 ; $56ce
	farcall FarPtr_0a_0e ; $56d1
Label_13_56d4:
	ld a, $03 ; $56d4
	farcall FarPtr_0a_0a ; $56d6
	farcall FarPtr_0a_12 ; $56d9
	farcall FarPtr_0a_0c ; $56dc
	push af ; $56df
	ld a, $05 ; $56e0
	farcall FarPtr_WaitScriptFrames ; $56e2
	pop af ; $56e5
	and a, a ; $56e6
	jr nz, Label_13_574c ; $56e7
	set_flag $05, 7 ; $56e9
	call Func_13_5bdf ; $56ec
	ld a, $03 ; $56ef
	farcall FarPtr_0a_08 ; $56f1
	ld a, $00 ; $56f4
	ld d, $03 ; $56f6
	farcall FarPtr_ScriptSetActorAnimation ; $56f8
	ld a, $00 ; $56fb
	farcall FarPtr_ScriptWaitActorIdle ; $56fd
	push af ; $5700
	ld a, $05 ; $5701
	farcall FarPtr_WaitScriptFrames ; $5703
	pop af ; $5706
	ld a, $00 ; $5707
	ld b, $40 ; $5709
	farcall FarPtr_SetActorFacing ; $570b
	wram_bank $04 ; $570e
	ld a, $01 ; $5714
	ld [wMatchIsDoubles], a ; $5716
	call Func_13_5067 ; $5719
	push af ; $571c
	ld a, $05 ; $571d
	farcall FarPtr_WaitScriptFrames ; $571f
	pop af ; $5722
	ld a, $03 ; $5723
	farcall FarPtr_GetActorStateAddr ; $5725
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, $d000 ; $572a
	farcall FarPtr_04_20 ; $572d
	ld a, $03 ; $5730
	farcall FarPtr_GetActorStateAddr ; $5732
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, $0005 ; $5737
	add hl, bc ; $573a
	set 4, [hl] ; $573b
	push af ; $573d
	ld a, $05 ; $573e
	farcall FarPtr_WaitScriptFrames ; $5740
	pop af ; $5743
	ld a, $00 ; $5744
	ld b, $40 ; $5746
	farcall FarPtr_SetActorFacing ; $5748
	ret ; $574b
Label_13_574c:
	call Func_13_5b8b ; $574c
	farcall FarPtr_0a_10 ; $574f
	ld a, $03 ; $5752
	farcall FarPtr_0a_08 ; $5754
	clear_flag $05, 7 ; $5757
	wram_bank $04 ; $575a
	ld a, $00 ; $5760
	ld [wMatchIsDoubles], a ; $5762
	ld a, $03 ; $5765
	farcall FarPtr_0a_1c ; $5767
	ld a, $03 ; $576a
	farcall FarPtr_GetActorStateAddr ; $576c
	ld c, l ; $576f
	ld b, h ; $5770
	ld hl, $0005 ; $5771
	add hl, bc ; $5774
	set 3, [hl] ; $5775
	call Func_13_5067 ; $5777
	ld a, $03 ; $577a
	ld b, $40 ; $577c
	farcall FarPtr_SetActorFacing ; $577e
	ret ; $5781
Label_13_5782:
	test_flag $1c, 0 ; $5782
	jr nz, Label_13_578f ; $5785
	ld hl, $0539 ; $5787
	farcall FarPtr_0a_0e ; $578a
	jr Label_13_5795 ; $578d
Label_13_578f:
	ld hl, $0533 ; $578f
	farcall FarPtr_0a_0e ; $5792
Label_13_5795:
	ld a, $03 ; $5795
	farcall FarPtr_0a_0a ; $5797
	farcall FarPtr_0a_12 ; $579a
	farcall FarPtr_0a_0c ; $579d
	push af ; $57a0
	ld a, $05 ; $57a1
	farcall FarPtr_WaitScriptFrames ; $57a3
	pop af ; $57a6
	and a, a ; $57a7
	jr nz, Label_13_5807 ; $57a8
	call Func_13_5bc3 ; $57aa
	ld a, $03 ; $57ad
	farcall FarPtr_0a_08 ; $57af
	ld a, $03 ; $57b2
	farcall FarPtr_0a_1c ; $57b4
	clear_flag $05, 7 ; $57b7
	wram_bank $04 ; $57ba
	ld a, $00 ; $57c0
	ld [wMatchIsDoubles], a ; $57c2
	ld a, $03 ; $57c5
	ld bc, $0b00 ; $57c7
	ld de, $0900 ; $57ca
	farcall FarPtr_ScriptSetActorMoveTarget ; $57cd
	ld a, $03 ; $57d0
	farcall FarPtr_ScriptWaitActorMoveDone ; $57d2
	push af ; $57d5
	ld a, $05 ; $57d6
	farcall FarPtr_WaitScriptFrames ; $57d8
	pop af ; $57db
	ld a, $03 ; $57dc
	ld b, $40 ; $57de
	farcall FarPtr_SetActorFacing ; $57e0
	push af ; $57e3
	ld a, $05 ; $57e4
	farcall FarPtr_WaitScriptFrames ; $57e6
	pop af ; $57e9
	ld a, $03 ; $57ea
	farcall FarPtr_GetActorStateAddr ; $57ec
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, $0005 ; $57f1
	add hl, bc ; $57f4
	set 3, [hl] ; $57f5
	call Func_13_5067 ; $57f7
	ld a, $03 ; $57fa
	farcall FarPtr_0a_1c ; $57fc
	ld a, $03 ; $57ff
	ld b, $40 ; $5801
	farcall FarPtr_SetActorFacing ; $5803
	ret ; $5806
Label_13_5807:
	call Func_13_5ba7 ; $5807
	farcall FarPtr_0a_10 ; $580a
	ld a, $03 ; $580d
	farcall FarPtr_0a_08 ; $580f
	ld a, $00 ; $5812
	ld d, $03 ; $5814
	farcall FarPtr_ScriptSetActorAnimation ; $5816
	ld a, $00 ; $5819
	farcall FarPtr_ScriptWaitActorIdle ; $581b
	ld a, $00 ; $581e
	ld b, $40 ; $5820
	farcall FarPtr_SetActorFacing ; $5822
	push af ; $5825
	ld a, $05 ; $5826
	farcall FarPtr_WaitScriptFrames ; $5828
	pop af ; $582b
	wram_bank $04 ; $582c
	ld a, $01 ; $5832
	ld [wMatchIsDoubles], a ; $5834
	set_flag $05, 7 ; $5837
	call Func_13_5067 ; $583a
	ld a, $03 ; $583d
	farcall FarPtr_GetActorStateAddr ; $583f
	ld c, l ; $5842
	ld b, h ; $5843
	ld de, $d000 ; $5844
	farcall FarPtr_04_20 ; $5847
	ld a, $03 ; $584a
	farcall FarPtr_GetActorStateAddr ; $584c
	ld c, l ; $584f
	ld b, h ; $5850
	ld hl, $0005 ; $5851
	add hl, bc ; $5854
	set 4, [hl] ; $5855
	ld a, $00 ; $5857
	ld b, $40 ; $5859
	farcall FarPtr_SetActorFacing ; $585b
	ret ; $585e
	inc de ; $585f
	add hl, bc ; $5860
	ld [bc], a ; $5861
	ld [bc], a ; $5862
	inc d ; $5863
	dec c ; $5864
	inc d ; $5865
	ld b, b ; $5866
	nop ; $5867
	ld bc, $09b4 ; $5868
	ld [bc], a ; $586b
	ld [bc], a ; $586c
	inc d ; $586d
	dec c ; $586e
	inc d ; $586f
	ret nz ; $5870
	nop ; $5871
	ld bc, $0cb4 ; $5872
	db $eb ; $5875
	db $ff ; $5876
	inc bc ; $5877
	ld b, b ; $5878
	rrca ; $5879
	ldh [$ff0e], a ; $587a
	dec c ; $587c
	inc d ; $587d
	ld b, b ; $587e
	nop ; $587f
	nop ; $5880
	inc bc ; $5881
	nop ; $5882
	ld de, $0380 ; $5883
	dec c ; $5886
	inc d ; $5887
	ret nz ; $5888
	nop ; $5889
	nop ; $588a
	inc bc ; $588b
	nop ; $588c
	inc bc ; $588d
	nop ; $588e
	rlca ; $588f
	dec c ; $5890
	inc d ; $5891
	ret nz ; $5892
	nop ; $5893
	inc de ; $5894
	dec c ; $5895
	inc d ; $5896
	ld b, b ; $5897
	nop ; $5898
	ld bc, $04b4 ; $5899
	nop ; $589c
	inc bc ; $589d
	nop ; $589e
	ld [$0114], sp ; $589f
	ld d, b ; $58a2
	dec c ; $58a3
	inc d ; $58a4
	nop ; $58a5
	nop ; $58a6
	ld bc, $0412 ; $58a7
	nop ; $58aa
	inc bc ; $58ab
	nop ; $58ac
	rlca ; $58ad
	inc d ; $58ae
	dec c ; $58af
	inc d ; $58b0
	ret nz ; $58b1
	nop ; $58b2
	ld bc, $0df0 ; $58b3
	inc d ; $58b6
	nop ; $58b7
	nop ; $58b8
	ld bc, $0c12 ; $58b9
	reti ; $58bc
	ds 1, $ff ; $58bd, fill
Func_13_58be:
	test_flag $1c, 0 ; $58be
	jr z, Label_13_58cb ; $58c1
	ld hl, $c2b2 ; $58c3
	ld de, $054f ; $58c6
	jr Label_13_58d1 ; $58c9
Label_13_58cb:
	ld hl, $c2b2 ; $58cb
	ld de, $0808 ; $58ce
Label_13_58d1:
	ld a, e ; $58d1
	ld [hl+], a ; $58d2
	ld [hl], d ; $58d3
	ld hl, $054c ; $58d4
	test_flag $0a, 7 ; $58d7
	jr z, Label_13_58e7 ; $58da
	ld hl, $054d ; $58dc
	test_flag $0b, 0 ; $58df
	jr z, Label_13_58e7 ; $58e2
	ld hl, $054e ; $58e4
Label_13_58e7:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	farcall FarPtr_RunPagedTextMenu ; $58ec
	cp a, $ff ; $58ef
	jp z, Label_13_5927 ; $58f1
	add a, a ; $58f4
	add a, $28 ; $58f5
	ld l, a ; $58f7
	adc a, $59 ; $58f8
	sub a, l ; $58fa
	ld h, a ; $58fb
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	ld a, $03 ; $5902
	farcall FarPtr_0a_08 ; $5904
	ld hl, $c2b2 ; $5907
	ld a, [hl+] ; $590a
	ld h, [hl] ; $590b
	ld l, a ; $590c
	farcall FarPtr_0a_0e ; $590d
	ld a, $03 ; $5910
	farcall FarPtr_0a_0a ; $5912
	farcall FarPtr_0a_12 ; $5915
	farcall FarPtr_0a_0c ; $5918
	push af ; $591b
	ld a, $05 ; $591c
	farcall FarPtr_WaitScriptFrames ; $591e
	pop af ; $5921
	and a, a ; $5922
	jr nz, Label_13_5927 ; $5923
	jr Label_13_58d1 ; $5925
Label_13_5927:
	ret ; $5927
	ld [hl], $59 ; $5928
	ld l, b ; $592a
	ld e, c ; $592b
	and a, [hl] ; $592c
	ld e, c ; $592d
	ret nz ; $592e
	ld e, c ; $592f
	and a, $59 ; $5930
	nop ; $5932
	ld e, d ; $5933
	ld a, [de] ; $5934
	ld e, d ; $5935
	ld de, $0001 ; $5936
	ld hl, $c2b2 ; $5939
	ld a, [hl+] ; $593c
	ld h, [hl] ; $593d
	ld l, a ; $593e
	add hl, de ; $593f
	test_flag $0a, 7 ; $5940
	jr z, Label_13_5964 ; $5943
	ld a, $01 ; $5945
	add a, l ; $5947
	ld l, a ; $5948
	jr nc, Label_13_594c ; $5949
	inc h ; $594b
Label_13_594c:
	test_flag $0b, 0 ; $594c
	jr z, Label_13_5964 ; $594f
	ld a, $01 ; $5951
	add a, l ; $5953
	ld l, a ; $5954
	jr nc, Label_13_5958 ; $5955
	inc h ; $5957
Label_13_5958:
	test_flag $07, 4 ; $5958
	jr z, Label_13_5964 ; $595b
	ld a, $01 ; $595d
	add a, l ; $595f
	ld l, a ; $5960
	jr nc, Label_13_5964 ; $5961
	inc h ; $5963
Label_13_5964:
	farcall FarPtr_0a_0e ; $5964
	ret ; $5967
	ld de, $0005 ; $5968
	ld hl, $c2b2 ; $596b
	ld a, [hl+] ; $596e
	ld h, [hl] ; $596f
	ld l, a ; $5970
	add hl, de ; $5971
	test_flag $08, 2 ; $5972
	jr z, Label_13_59a2 ; $5975
	ld a, $01 ; $5977
	add a, l ; $5979
	ld l, a ; $597a
	jr nc, Label_13_597e ; $597b
	inc h ; $597d
Label_13_597e:
	test_flag $08, 6 ; $597e
	jr z, Label_13_59a2 ; $5981
	ld a, $01 ; $5983
	add a, l ; $5985
	ld l, a ; $5986
	jr nc, Label_13_598a ; $5987
	inc h ; $5989
Label_13_598a:
	test_flag $09, 0 ; $598a
	jr z, Label_13_59a2 ; $598d
	ld a, $01 ; $598f
	add a, l ; $5991
	ld l, a ; $5992
	jr nc, Label_13_5996 ; $5993
	inc h ; $5995
Label_13_5996:
	test_flag $06, 5 ; $5996
	jr z, Label_13_59a2 ; $5999
	ld a, $01 ; $599b
	add a, l ; $599d
	ld l, a ; $599e
	jr nc, Label_13_59a2 ; $599f
	inc h ; $59a1
Label_13_59a2:
	farcall FarPtr_0a_0e ; $59a2
	ret ; $59a5
	ld de, $000a ; $59a6
	ld hl, $c2b2 ; $59a9
	ld a, [hl+] ; $59ac
	ld h, [hl] ; $59ad
	ld l, a ; $59ae
	add hl, de ; $59af
	test_flag $0a, 3 ; $59b0
	jr z, Label_13_59bc ; $59b3
	ld a, $01 ; $59b5
	add a, l ; $59b7
	ld l, a ; $59b8
	jr nc, Label_13_59bc ; $59b9
	inc h ; $59bb
Label_13_59bc:
	farcall FarPtr_0a_0e ; $59bc
	ret ; $59bf
	ld de, $000c ; $59c0
	ld hl, $c2b2 ; $59c3
	ld a, [hl+] ; $59c6
	ld h, [hl] ; $59c7
	ld l, a ; $59c8
	add hl, de ; $59c9
	test_flag $0a, 3 ; $59ca
	jr z, Label_13_59e2 ; $59cd
	ld a, $01 ; $59cf
	add a, l ; $59d1
	ld l, a ; $59d2
	jr nc, Label_13_59d6 ; $59d3
	inc h ; $59d5
Label_13_59d6:
	test_flag $0a, 7 ; $59d6
	jr z, Label_13_59e2 ; $59d9
	ld a, $01 ; $59db
	add a, l ; $59dd
	ld l, a ; $59de
	jr nc, Label_13_59e2 ; $59df
	inc h ; $59e1
Label_13_59e2:
	farcall FarPtr_0a_0e ; $59e2
	ret ; $59e5
	ld de, $000f ; $59e6
	ld hl, $c2b2 ; $59e9
	ld a, [hl+] ; $59ec
	ld h, [hl] ; $59ed
	ld l, a ; $59ee
	add hl, de ; $59ef
	test_flag $0b, 0 ; $59f0
	jr z, Label_13_59fc ; $59f3
	ld a, $01 ; $59f5
	add a, l ; $59f7
	ld l, a ; $59f8
	jr nc, Label_13_59fc ; $59f9
	inc h ; $59fb
Label_13_59fc:
	farcall FarPtr_0a_0e ; $59fc
	ret ; $59ff
	ld de, $0011 ; $5a00
	ld hl, $c2b2 ; $5a03
	ld a, [hl+] ; $5a06
	ld h, [hl] ; $5a07
	ld l, a ; $5a08
	add hl, de ; $5a09
	test_flag $0b, 0 ; $5a0a
	jr z, Label_13_5a16 ; $5a0d
	ld a, $01 ; $5a0f
	add a, l ; $5a11
	ld l, a ; $5a12
	jr nc, Label_13_5a16 ; $5a13
	inc h ; $5a15
Label_13_5a16:
	farcall FarPtr_0a_0e ; $5a16
	ret ; $5a19
	ld de, $0013 ; $5a1a
	ld hl, $c2b2 ; $5a1d
	ld a, [hl+] ; $5a20
	ld h, [hl] ; $5a21
	ld l, a ; $5a22
	add hl, de ; $5a23
	farcall FarPtr_0a_0e ; $5a24
	ret ; $5a27
Func_13_5a28:
	sound $00 ; $5a28
	ld a, $03 ; $5a2a
	ld bc, $3f00 ; $5a2c
	ld de, $3f00 ; $5a2f
	farcall FarPtr_ScriptSetActorPosition ; $5a32
	ld a, $04 ; $5a35
	ld bc, $3f00 ; $5a37
	ld de, $3f00 ; $5a3a
	farcall FarPtr_ScriptSetActorPosition ; $5a3d
	ld a, $00 ; $5a40
	ld b, $00 ; $5a42
	farcall FarPtr_SetActorActive ; $5a44
	ld a, $02 ; $5a47
	ld b, $00 ; $5a49
	farcall FarPtr_SetActorActive ; $5a4b
	ld b, $00 ; $5a4e
	ld c, $20 ; $5a50
	ld d, $00 ; $5a52
	ld e, $00 ; $5a54
	ld h, $16 ; $5a56
	ld l, $18 ; $5a58
	farcall FarPtr_0a_7e ; $5a5a
	ld c, $08 ; $5a5d
	call BeginFadeIn ; $5a5f
	push af ; $5a62
	ld a, $04 ; $5a63
	farcall FarPtr_WaitScriptFrames ; $5a65
	pop af ; $5a68
	ld a, $85 ; $5a69
	farcall FarPtr_0a_08 ; $5a6b
	push af ; $5a6e
	ld a, $04 ; $5a6f
	farcall FarPtr_WaitScriptFrames ; $5a71
	pop af ; $5a74
	ret ; $5a75
Label_13_5a76:
	ld hl, $01f0 ; $5a76
	farcall FarPtr_0a_0e ; $5a79
	call Func_13_5a28 ; $5a7c
	ld a, $14 ; $5a7f
	ld [wStoryModeCurrentLocation], a ; $5a81
	ld a, $0a ; $5a84
	ld [$c295], a ; $5a86
	ld a, $ff ; $5a89
	ld [$c294], a ; $5a8b
	ld [$c2a1], a ; $5a8e
	ret ; $5a91
Label_13_5a92:
	ld hl, $01f1 ; $5a92
	farcall FarPtr_0a_0e ; $5a95
	call Func_13_5a28 ; $5a98
	ld a, $15 ; $5a9b
	ld [wStoryModeCurrentLocation], a ; $5a9d
	ld a, $0f ; $5aa0
	ld [$c295], a ; $5aa2
	ld a, $ff ; $5aa5
	ld [$c294], a ; $5aa7
	ld [$c2a1], a ; $5aaa
	ret ; $5aad
Label_13_5aae:
	ld hl, $01f0 ; $5aae
	farcall FarPtr_0a_0e ; $5ab1
	call Func_13_5a28 ; $5ab4
	ld a, $14 ; $5ab7
	ld [wStoryModeCurrentLocation], a ; $5ab9
	ld a, $0a ; $5abc
	ld [$c295], a ; $5abe
	ld a, $ff ; $5ac1
	ld [$c294], a ; $5ac3
	ld [$c2a1], a ; $5ac6
	ret ; $5ac9
Func_13_5aca:
	test_flag $05, 7 ; $5aca
	jr nz, Label_13_5ae2 ; $5acd
	test_flag $16, 0 ; $5acf
	jr nz, Label_13_5adf ; $5ad2
	test_flag $15, 6 ; $5ad4
	jr nz, Label_13_5adc ; $5ad7
Label_13_5ad9:
	ld a, $00 ; $5ad9
	ret ; $5adb
Label_13_5adc:
	ld a, $01 ; $5adc
	ret ; $5ade
Label_13_5adf:
	ld a, $02 ; $5adf
	ret ; $5ae1
Label_13_5ae2:
	test_flag $16, 1 ; $5ae2
	jr nz, Label_13_5adf ; $5ae5
	test_flag $15, 7 ; $5ae7
	jr nz, Label_13_5adc ; $5aea
	jr Label_13_5ad9 ; $5aec
Label_13_5aee:
	test_flag $1c, 0 ; $5aee
	jr z, Label_13_5afb ; $5af1
	ld hl, $0511 ; $5af3
	farcall FarPtr_0a_0e ; $5af6
	jr Label_13_5b01 ; $5af9
Label_13_5afb:
	ld hl, $050c ; $5afb
	farcall FarPtr_0a_0e ; $5afe
Label_13_5b01:
	ld a, $02 ; $5b01
	farcall FarPtr_0a_1c ; $5b03
	ld a, $02 ; $5b06
	ld bc, $0b00 ; $5b08
	ld de, $1e00 ; $5b0b
	farcall FarPtr_ScriptSetActorPosition ; $5b0e
	ld a, $02 ; $5b11
	ld b, $40 ; $5b13
	farcall FarPtr_SetActorFacing ; $5b15
	ld a, $03 ; $5b18
	ld bc, $0b00 ; $5b1a
	ld de, $0a00 ; $5b1d
	farcall FarPtr_ScriptSetActorPosition ; $5b20
	ld a, $03 ; $5b23
	ld b, $40 ; $5b25
	farcall FarPtr_SetActorFacing ; $5b27
	ld c, $04 ; $5b2a
	call BeginFadeIn ; $5b2c
	call WaitFadeEnd ; $5b2f
	test_flag $05, 7 ; $5b32
	jr z, Label_13_5b79 ; $5b35
	farcall FarPtr_0a_10 ; $5b37
	ld a, $03 ; $5b3a
	farcall FarPtr_0a_08 ; $5b3c
	ld a, $03 ; $5b3f
	farcall FarPtr_0a_08 ; $5b41
	ld a, $00 ; $5b44
	ld d, $03 ; $5b46
	farcall FarPtr_ScriptSetActorAnimation ; $5b48
	ld a, $00 ; $5b4b
	farcall FarPtr_ScriptWaitActorIdle ; $5b4d
	ld a, $00 ; $5b50
	ld b, $40 ; $5b52
	farcall FarPtr_SetActorFacing ; $5b54
	push af ; $5b57
	ld a, $05 ; $5b58
	farcall FarPtr_WaitScriptFrames ; $5b5a
	pop af ; $5b5d
	ld a, $03 ; $5b5e
	farcall FarPtr_GetActorStateAddr ; $5b60
	ld c, l ; $5b63
	ld b, h ; $5b64
	ld de, $d000 ; $5b65
	farcall FarPtr_04_20 ; $5b68
	ld a, $03 ; $5b6b
	farcall FarPtr_GetActorStateAddr ; $5b6d
	ld c, l ; $5b70
	ld b, h ; $5b71
	ld hl, $0005 ; $5b72
	add hl, bc ; $5b75
	set 4, [hl] ; $5b76
	ret ; $5b78
Label_13_5b79:
	ld a, $03 ; $5b79
	farcall FarPtr_0a_08 ; $5b7b
	ld a, $00 ; $5b7e
	ld d, $03 ; $5b80
	farcall FarPtr_ScriptSetActorAnimation ; $5b82
	ld a, $00 ; $5b85
	farcall FarPtr_ScriptWaitActorIdle ; $5b87
	ret ; $5b8a
Func_13_5b8b:
	call Func_13_5aca ; $5b8b
	cp a, $01 ; $5b8e
	jp nz, Label_13_5ba6 ; $5b90
	test_flag $1c, 0 ; $5b93
	jr z, Label_13_5ba0 ; $5b96
	ld hl, $0513 ; $5b98
	farcall FarPtr_0a_0e ; $5b9b
	jr Label_13_5ba6 ; $5b9e
Label_13_5ba0:
	ld hl, $050e ; $5ba0
	farcall FarPtr_0a_0e ; $5ba3
Label_13_5ba6:
	ret ; $5ba6
Func_13_5ba7:
	call Func_13_5aca ; $5ba7
	cp a, $01 ; $5baa
	jp nz, Label_13_5bc2 ; $5bac
	test_flag $1c, 0 ; $5baf
	jr z, Label_13_5bbc ; $5bb2
	ld hl, $0514 ; $5bb4
	farcall FarPtr_0a_0e ; $5bb7
	jr Label_13_5bc2 ; $5bba
Label_13_5bbc:
	ld hl, $050f ; $5bbc
	farcall FarPtr_0a_0e ; $5bbf
Label_13_5bc2:
	ret ; $5bc2
Func_13_5bc3:
	call Func_13_5aca ; $5bc3
	cp a, $01 ; $5bc6
	jp nz, Label_13_5bde ; $5bc8
	test_flag $1c, 0 ; $5bcb
	jr z, Label_13_5bd8 ; $5bce
	ld hl, $0514 ; $5bd0
	farcall FarPtr_0a_0e ; $5bd3
	jr Label_13_5bde ; $5bd6
Label_13_5bd8:
	ld hl, $050f ; $5bd8
	farcall FarPtr_0a_0e ; $5bdb
Label_13_5bde:
	ret ; $5bde
Func_13_5bdf:
	call Func_13_5aca ; $5bdf
	cp a, $01 ; $5be2
	jp nz, Label_13_5bfa ; $5be4
	test_flag $1c, 0 ; $5be7
	jr z, Label_13_5bf4 ; $5bea
	ld hl, $0515 ; $5bec
	farcall FarPtr_0a_0e ; $5bef
	jr Label_13_5bfa ; $5bf2
Label_13_5bf4:
	ld hl, $0510 ; $5bf4
	farcall FarPtr_0a_0e ; $5bf7
Label_13_5bfa:
	ret ; $5bfa
Func_13_5bfb:
	farcall FarPtr_GetActorStateAddr ; $5bfb
	ld c, l ; $5bfe
	ld b, h ; $5bff
	ld hl, $000c ; $5c00
	add hl, bc ; $5c03
	ld a, [hl+] ; $5c04
	ld h, [hl] ; $5c05
	ld l, a ; $5c06
	ld de, $0180 ; $5c07
	add hl, de ; $5c0a
	ld e, l ; $5c0b
	ld d, h ; $5c0c
	ld hl, $c2b8 ; $5c0d
	ld a, e ; $5c10
	ld [hl+], a ; $5c11
	ld [hl], d ; $5c12
	ld hl, $000e ; $5c13
	add hl, bc ; $5c16
	ld a, [hl+] ; $5c17
	ld h, [hl] ; $5c18
	ld l, a ; $5c19
	ld de, $fe80 ; $5c1a
	add hl, de ; $5c1d
	ld e, l ; $5c1e
	ld d, h ; $5c1f
	ld hl, wWaterSpriteMinigameFlag ; $5c20
	ld a, e ; $5c23
	ld [hl+], a ; $5c24
	ld [hl], d ; $5c25
	ret ; $5c26
Func_13_5c27:
	ld hl, $c2b8 ; $5c27
	ld a, [hl+] ; $5c2a
	ld b, [hl] ; $5c2b
	ld c, a ; $5c2c
	ld hl, wWaterSpriteMinigameFlag ; $5c2d
	ld a, [hl+] ; $5c30
	ld d, [hl] ; $5c31
	ld e, a ; $5c32
	ld a, $05 ; $5c33
	farcall FarPtr_ScriptSetActorPosition ; $5c35
	ret ; $5c38
Func_13_5c39:
	ld a, $00 ; $5c39
	farcall FarPtr_GetActorStateAddr ; $5c3b
	ld c, l ; $5c3e
	ld b, h ; $5c3f
	ld hl, $000c ; $5c40
	add hl, bc ; $5c43
	ld a, [hl+] ; $5c44
	ld h, [hl] ; $5c45
	ld l, a ; $5c46
	ld de, $0000 ; $5c47
	add hl, de ; $5c4a
	ld e, l ; $5c4b
	ld d, h ; $5c4c
	ld hl, $c2b8 ; $5c4d
	ld a, e ; $5c50
	ld [hl+], a ; $5c51
	ld [hl], d ; $5c52
	ld hl, $000e ; $5c53
	add hl, bc ; $5c56
	ld a, [hl+] ; $5c57
	ld h, [hl] ; $5c58
	ld l, a ; $5c59
	ld de, $0000 ; $5c5a
	add hl, de ; $5c5d
	ld e, l ; $5c5e
	ld d, h ; $5c5f
	ld hl, wWaterSpriteMinigameFlag ; $5c60
	ld a, e ; $5c63
	ld [hl+], a ; $5c64
	ld [hl], d ; $5c65
	ld hl, $c2b8 ; $5c66
	ld a, [hl+] ; $5c69
	ld b, [hl] ; $5c6a
	ld c, a ; $5c6b
	ld hl, wWaterSpriteMinigameFlag ; $5c6c
	ld a, [hl+] ; $5c6f
	ld d, [hl] ; $5c70
	ld e, a ; $5c71
	ld a, $03 ; $5c72
	farcall FarPtr_ScriptSetActorPosition ; $5c74
	ret ; $5c77
StoryCmdHandlersD_13:
	; $5c78, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $5e40 ; record 0
	dw $5e79 ; record 1
	dw $5c86 ; record 2
	dw $5edc ; record 3
	dw $6164 ; record 4
	dw $6188 ; record 5
	dw $6189 ; record 6
	nop ; $5c86
	nop ; $5c87
	dec h ; $5c88
	ld a, e ; $5c89
	nop ; $5c8a
	dec c ; $5c8b
	nop ; $5c8c
	dec e ; $5c8d
	ld b, b ; $5c8e
	nop ; $5c8f
	ld c, e ; $5c90
	ld bc, $0000 ; $5c91
	nop ; $5c94
	nop ; $5c95
	dec h ; $5c96
	ld a, e ; $5c97
	nop ; $5c98
	dec b ; $5c99
	nop ; $5c9a
	dec e ; $5c9b
	nop ; $5c9c
	nop ; $5c9d
	ld l, b ; $5c9e
	ld bc, $0007 ; $5c9f
	nop ; $5ca2
	nop ; $5ca3
	ld b, b ; $5ca4
	ld a, d ; $5ca5
	nop ; $5ca6
	dec c ; $5ca7
	nop ; $5ca8
	inc hl ; $5ca9
	ret nz ; $5caa
	nop ; $5cab
	ld h, l ; $5cac
	ld b, $03 ; $5cad
	nop ; $5caf
	nop ; $5cb0
	nop ; $5cb1
	dec h ; $5cb2
	ld a, e ; $5cb3
	nop ; $5cb4
	ld [$1300], sp ; $5cb5
	ret nz ; $5cb8
	nop ; $5cb9
	ld h, a ; $5cba
	ld bc, $0006 ; $5cbb
	nop ; $5cbe
	nop ; $5cbf
	cpl ; $5cc0
	ld a, e ; $5cc1
	nop ; $5cc2
	rrca ; $5cc3
	nop ; $5cc4
	rla ; $5cc5
	ld b, b ; $5cc6
	nop ; $5cc7
	ld l, e ; $5cc8
	ld bc, $0006 ; $5cc9
	nop ; $5ccc
	nop ; $5ccd
	dec h ; $5cce
	ld a, e ; $5ccf
	ret nz ; $5cd0
	INCBIN "data/bank_013/d_5cd1.bin" ; $5cd1, 367 bytes
	ld bc, $0040 ; $5e40
	ld [hl], $00 ; $5e43
	ld d, $00 ; $5e45
	nop ; $5e47
	ld [bc], a ; $5e48
	ld b, b ; $5e49
	nop ; $5e4a
	ld [hl+], a ; $5e4b
	nop ; $5e4c
	dec bc ; $5e4d
	nop ; $5e4e
	nop ; $5e4f
	inc bc ; $5e50
	ret nz ; $5e51
	nop ; $5e52
	ld [hl+], a ; $5e53
	nop ; $5e54
	ld sp, $0000 ; $5e55
	ld a, [bc] ; $5e58
	ret nz ; $5e59
	nop ; $5e5a
	ld de, $1d00 ; $5e5b
	nop ; $5e5e
	nop ; $5e5f
	dec c ; $5e60
	ret nz ; $5e61
	nop ; $5e62
	dec c ; $5e63
	nop ; $5e64
	rra ; $5e65
	nop ; $5e66
	nop ; $5e67
	ld c, $c0 ; $5e68
	nop ; $5e6a
	rrca ; $5e6b
	nop ; $5e6c
	rra ; $5e6d
	nop ; $5e6e
	nop ; $5e6f
	rrca ; $5e70
	ret nz ; $5e71
	nop ; $5e72
	ld [hl+], a ; $5e73
	nop ; $5e74
	cpl ; $5e75
	nop ; $5e76
	nop ; $5e77
	rst Rst38 ; $5e78
	ld bc, $00ff ; $5e79
	nop ; $5e7c
	nop ; $5e7d
	nop ; $5e7e
	ld de, $0201 ; $5e7f
	rst Rst38 ; $5e82
	nop ; $5e83
	nop ; $5e84
	nop ; $5e85
	nop ; $5e86
	ld [$0304], sp ; $5e87
	rst Rst38 ; $5e8a
	nop ; $5e8b
	nop ; $5e8c
	nop ; $5e8d
	nop ; $5e8e
	dec b ; $5e8f
	ld [bc], a ; $5e90
	ld a, [bc] ; $5e91
	rst Rst38 ; $5e92
	nop ; $5e93
	nop ; $5e94
	ld c, l ; $5e95
	ld a, e ; $5e96
	nop ; $5e97
	ld a, [bc] ; $5e98
	ld c, $ff ; $5e99
	nop ; $5e9b
	nop ; $5e9c
	nop ; $5e9d
	nop ; $5e9e
	rlca ; $5e9f
	ld c, $0f ; $5ea0
	rst Rst38 ; $5ea2
	nop ; $5ea3
	nop ; $5ea4
	nop ; $5ea5
	nop ; $5ea6
	ld [rIF], sp ; $5ea7
	ld hl, $020f ; $5eaa
	farcall FarPtr_0a_0e ; $5ead
	test_flag $05, 7 ; $5eb0
	jr z, Label_13_5ebb ; $5eb3
	ld hl, $0211 ; $5eb5
	farcall FarPtr_0a_0e ; $5eb8
Label_13_5ebb:
	ld a, $03 ; $5ebb
	farcall FarPtr_0a_0a ; $5ebd
	farcall FarPtr_0a_12 ; $5ec0
	farcall FarPtr_0a_0c ; $5ec3
	push af ; $5ec6
	ld a, $05 ; $5ec7
	farcall FarPtr_WaitScriptFrames ; $5ec9
	pop af ; $5ecc
	and a, a ; $5ecd
	jr nz, Label_13_5ed6 ; $5ece
	ld hl, $0213 ; $5ed0
	farcall FarPtr_0a_0e ; $5ed3
Label_13_5ed6:
	ld a, $03 ; $5ed6
	farcall FarPtr_0a_08 ; $5ed8
	ret ; $5edb
	inc bc ; $5edc
	rst Rst38 ; $5edd
	nop ; $5ede
	nop ; $5edf
	xor a, d ; $5ee0
	ld e, [hl] ; $5ee1
	inc bc ; $5ee2
	nop ; $5ee3
	inc b ; $5ee4
	rst Rst38 ; $5ee5
	ldh [rTIMA], a ; $5ee6
	inc d ; $5ee8
	ld [bc], a ; $5ee9
	inc bc ; $5eea
	nop ; $5eeb
	dec b ; $5eec
	rst Rst38 ; $5eed
	ldh [rTIMA], a ; $5eee
	dec d ; $5ef0
	ld [bc], a ; $5ef1
	dec de ; $5ef2
	nop ; $5ef3
	inc b ; $5ef4
	rst Rst38 ; $5ef5
	nop ; $5ef6
	nop ; $5ef7
	jr Label_13_5efc ; $5ef8
	db $03 ; $5efa
	db $00 ; $5efb
Label_13_5efc:
	dec b ; $5efc
	rst Rst38 ; $5efd
	nop ; $5efe
	nop ; $5eff
	add hl, de ; $5f00
	ld [bc], a ; $5f01
	dec de ; $5f02
	nop ; $5f03
	ld b, $ff ; $5f04
	nop ; $5f06
	nop ; $5f07
	ld d, $02 ; $5f08
	inc bc ; $5f0a
	nop ; $5f0b
	rlca ; $5f0c
	rst Rst38 ; $5f0d
	nop ; $5f0e
	nop ; $5f0f
	rla ; $5f10
	ld [bc], a ; $5f11
	inc de ; $5f12
	nop ; $5f13
	rst Rst38 ; $5f14
	ld a, $05 ; $5f15
	farcall FarPtr_0a_1c ; $5f17
	ld a, $05 ; $5f1a
	ld d, $01 ; $5f1c
	farcall FarPtr_ScriptSetActorAnimation ; $5f1e
	ld hl, $021b ; $5f21
	farcall FarPtr_0a_0e ; $5f24
	ld a, $05 ; $5f27
	farcall FarPtr_0a_0a ; $5f29
	farcall FarPtr_0a_12 ; $5f2c
	farcall FarPtr_0a_0c ; $5f2f
	push af ; $5f32
	ld a, $05 ; $5f33
	farcall FarPtr_WaitScriptFrames ; $5f35
	pop af ; $5f38
	and a, a ; $5f39
	jr z, Label_13_5f4d ; $5f3a
	ld a, $05 ; $5f3c
	farcall FarPtr_0a_08 ; $5f3e
	ldh a, [hRomBank] ; $5f41
	ld b, a ; $5f43
	ld a, $05 ; $5f44
	ld de, $7a40 ; $5f46
	farcall FarPtr_0a_1a ; $5f49
	ret ; $5f4c
Label_13_5f4d:
	farcall FarPtr_0a_10 ; $5f4d
	ld a, $05 ; $5f50
	farcall FarPtr_0a_08 ; $5f52
	ld hl, wStoryModePlayersXPosition ; $5f55
	ld de, $c296 ; $5f58
	ld bc, $0005 ; $5f5b
	call CopyMemoryBC ; $5f5e
	ld a, $ff ; $5f61
	ld [$c295], a ; $5f63
	ld [$c294], a ; $5f66
	ld [$c2a1], a ; $5f69
	call SetupStoryMinigameMatch0 ; $5f6c
	ret ; $5f6f
	INCBIN "data/bank_013/d_5f70.bin" ; $5f70, 328 bytes
	ld hl, $0424 ; $60b8
	farcall FarPtr_0a_0e ; $60bb
	test_flag $07, 6 ; $60be
	jr z, Label_13_60c6 ; $60c1
	farcall FarPtr_0a_10 ; $60c3
Label_13_60c6:
	ld a, $05 ; $60c6
	farcall FarPtr_0a_08 ; $60c8
	ret ; $60cb
	ld a, $05 ; $60cc
	farcall FarPtr_0a_1c ; $60ce
	ld a, $05 ; $60d1
	ld d, $01 ; $60d3
	farcall FarPtr_ScriptSetActorAnimation ; $60d5
	ld hl, $0428 ; $60d8
	farcall FarPtr_0a_0e ; $60db
	ld a, $05 ; $60de
	farcall FarPtr_0a_08 ; $60e0
	ldh a, [hRomBank] ; $60e3
	ld b, a ; $60e5
	ld a, $05 ; $60e6
	ld de, $7a40 ; $60e8
	farcall FarPtr_0a_1a ; $60eb
	ret ; $60ee
	INCBIN "data/bank_013/d_60ef.bin" ; $60ef, 41 bytes
	ld a, $05 ; $6118
	farcall FarPtr_0a_1c ; $611a
	ld a, $05 ; $611d
	ld d, $01 ; $611f
	farcall FarPtr_ScriptSetActorAnimation ; $6121
	ld hl, $042d ; $6124
	farcall FarPtr_0a_0e ; $6127
	ld a, $05 ; $612a
	farcall FarPtr_0a_08 ; $612c
	ldh a, [hRomBank] ; $612f
	ld b, a ; $6131
	ld a, $05 ; $6132
	ld de, $7a40 ; $6134
	farcall FarPtr_0a_1a ; $6137
	ret ; $613a
	INCBIN "data/bank_013/d_613b.bin" ; $613b, 41 bytes
	ld bc, $00ff ; $6164
	nop ; $6167
	ld l, l ; $6168
	ld h, c ; $6169
	nop ; $616a
	nop ; $616b
	rst Rst38 ; $616c
	call Func_13_7ae0 ; $616d
	ld hl, wStoryModePlayersXPosition ; $6170
	ld de, $c296 ; $6173
	ld bc, $0005 ; $6176
	call CopyMemoryBC ; $6179
	ld a, $ff ; $617c
	ld [$c295], a ; $617e
	ld [$c294], a ; $6181
	ld [$c2a1], a ; $6184
	ret ; $6187
	rst Rst38 ; $6188
	call Func_13_61a9 ; $6189
	ld a, [$c295] ; $618c
	cp a, $0f ; $618f
	jr nz, Label_13_6196 ; $6191
	jp Label_13_636c ; $6193
Label_13_6196:
	cp a, $0d ; $6196
	jr nz, Label_13_619e ; $6198
	call Func_13_7995 ; $619a
	ret ; $619d
Label_13_619e:
	cp a, $0e ; $619e
	jr nz, Label_13_61a5 ; $61a0
	jp Label_13_7988 ; $61a2
Label_13_61a5:
	call Func_13_62ff ; $61a5
	ret ; $61a8
Func_13_61a9:
	test_flag $05, 7 ; $61a9
	jr nz, Label_13_6222 ; $61ac
	test_flag $16, 0 ; $61ae
	jr z, Label_13_61e1 ; $61b1
	ld hl, $60ef ; $61b3
	ld de, $000c ; $61b6
	farcall FarPtr_0a_60 ; $61b9
	ld a, $18 ; $61bc
	ld d, $08 ; $61be
	ld e, $10 ; $61c0
	farcall FarPtr_0a_8a ; $61c2
	ld a, $18 ; $61c5
	ld d, $06 ; $61c7
	ld e, $10 ; $61c9
	farcall FarPtr_0a_8a ; $61cb
	ld a, $06 ; $61ce
	ld bc, $0500 ; $61d0
	ld de, $1500 ; $61d3
	farcall FarPtr_ScriptSetActorPosition ; $61d6
	ld a, $06 ; $61d9
	ld b, $00 ; $61db
	farcall FarPtr_SetActorFacing ; $61dd
	ret ; $61e0
Label_13_61e1:
	test_flag $15, 6 ; $61e1
	jr z, Label_13_620a ; $61e4
	ldh a, [hRomBank] ; $61e6
	ld hl, $5dca ; $61e8
	farcall FarPtr_0a_06 ; $61eb
	ld hl, $609f ; $61ee
	ld de, $000c ; $61f1
	farcall FarPtr_0a_60 ; $61f4
	ld a, $18 ; $61f7
	ld d, $08 ; $61f9
	ld e, $10 ; $61fb
	farcall FarPtr_0a_8a ; $61fd
	ld a, $18 ; $6200
	ld d, $06 ; $6202
	ld e, $10 ; $6204
	farcall FarPtr_0a_8a ; $6206
	ret ; $6209
Label_13_620a:
	test_flag $0a, 7 ; $620a
	jp z, Label_13_62bd ; $620d
	ldh a, [hRomBank] ; $6210
	ld hl, $5ce4 ; $6212
	farcall FarPtr_0a_06 ; $6215
	ld hl, $5f70 ; $6218
	ld de, $000c ; $621b
	farcall FarPtr_0a_60 ; $621e
	ret ; $6221
Label_13_6222:
	test_flag $16, 1 ; $6222
	jr z, Label_13_627e ; $6225
	ldh a, [hRomBank] ; $6227
	ld hl, $5d50 ; $6229
	farcall FarPtr_0a_06 ; $622c
	ld hl, $613b ; $622f
	ld de, $000c ; $6232
	farcall FarPtr_0a_60 ; $6235
	ld a, $09 ; $6238
	ld bc, $3f00 ; $623a
	ld de, $3f00 ; $623d
	farcall FarPtr_ScriptSetActorPosition ; $6240
	ld a, $04 ; $6243
	ld b, $00 ; $6245
	farcall FarPtr_SetActorFacing ; $6247
	ldh a, [hRomBank] ; $624a
	ld b, a ; $624c
	ld a, $06 ; $624d
	ld de, $7cf5 ; $624f
	farcall FarPtr_0a_1a ; $6252
	ld a, $18 ; $6255
	ld d, $08 ; $6257
	ld e, $10 ; $6259
	farcall FarPtr_0a_8a ; $625b
	ld a, $18 ; $625e
	ld d, $06 ; $6260
	ld e, $10 ; $6262
	farcall FarPtr_0a_8a ; $6264
	ld a, $07 ; $6267
	ld bc, $0f00 ; $6269
	ld de, $1700 ; $626c
	farcall FarPtr_ScriptSetActorPosition ; $626f
	ldh a, [hRomBank] ; $6272
	ld b, a ; $6274
	ld a, $07 ; $6275
	ld de, $7b2f ; $6277
	farcall FarPtr_0a_1a ; $627a
	ret ; $627d
Label_13_627e:
	test_flag $15, 7 ; $627e
	jr z, Label_13_62a7 ; $6281
	ldh a, [hRomBank] ; $6283
	ld hl, $5dfe ; $6285
	farcall FarPtr_0a_06 ; $6288
	ld hl, $609f ; $628b
	ld de, $000c ; $628e
	farcall FarPtr_0a_60 ; $6291
	ld a, $18 ; $6294
	ld d, $08 ; $6296
	ld e, $10 ; $6298
	farcall FarPtr_0a_8a ; $629a
	ld a, $18 ; $629d
	ld d, $06 ; $629f
	ld e, $10 ; $62a1
	farcall FarPtr_0a_8a ; $62a3
	ret ; $62a6
Label_13_62a7:
	test_flag $08, 6 ; $62a7
	jr z, Label_13_62bd ; $62aa
	ldh a, [hRomBank] ; $62ac
	ld hl, $5d50 ; $62ae
	farcall FarPtr_0a_06 ; $62b1
	ld hl, $6020 ; $62b4
	ld de, $000c ; $62b7
	farcall FarPtr_0a_60 ; $62ba
Label_13_62bd:
	ret ; $62bd
Func_13_62be:
	ld a, [$c94d] ; $62be
	or a, a ; $62c1
	jr nz, Label_13_62da ; $62c2
	ld d, $28 ; $62c4
	ld a, $0d ; $62c6
	farcall FarPtr_GetActorStateAddr ; $62c8
	ld c, l ; $62cb
	ld b, h ; $62cc
	farcall FarPtr_04_2c ; $62cd
	ld a, $0d ; $62d0
	ld d, $01 ; $62d2
	farcall FarPtr_ScriptSetActorAnimation ; $62d4
	set_flag $1c, 0 ; $62d7
Label_13_62da:
	ret ; $62da
	INCBIN "data/bank_013/d_62db.bin" ; $62db, 36 bytes
Func_13_62ff:
	ld a, [$c295] ; $62ff
	cp a, $ff ; $6302
	jp z, Label_13_6365 ; $6304
	test_flag $05, 7 ; $6307
	jr z, Label_13_6348 ; $630a
	ld a, $02 ; $630c
	ld bc, $00ff ; $630e
	farcall FarPtr_0a_18 ; $6311
	ld a, [$c295] ; $6314
	dec a ; $6317
	add a, $69 ; $6318
	ld l, a ; $631a
	adc a, $63 ; $631b
	sub a, l ; $631d
	ld h, a ; $631e
	ld b, [hl] ; $631f
	ld a, $02 ; $6320
	ld b, b ; $6322
	ld de, $0200 ; $6323
	farcall FarPtr_MoveActorByAngle ; $6326
	ld a, $02 ; $6329
	farcall FarPtr_ScriptWaitActorMoveDone ; $632b
	ld a, [$c295] ; $632e
	dec a ; $6331
	add a, $66 ; $6332
	ld l, a ; $6334
	adc a, $63 ; $6335
	sub a, l ; $6337
	ld h, a ; $6338
	ld b, [hl] ; $6339
	ld a, $02 ; $633a
	ld b, b ; $633c
	farcall FarPtr_SetActorFacing ; $633d
	ld a, $02 ; $6340
	ld bc, $0010 ; $6342
	farcall FarPtr_0a_18 ; $6345
Label_13_6348:
	ld a, $00 ; $6348
	ld bc, $0010 ; $634a
	farcall FarPtr_0a_18 ; $634d
	ld a, [$c295] ; $6350
	dec a ; $6353
	add a, $66 ; $6354
	ld l, a ; $6356
	adc a, $63 ; $6357
	sub a, l ; $6359
	ld h, a ; $635a
	ld b, [hl] ; $635b
	ld a, $00 ; $635c
	ld b, b ; $635e
	ld de, $0200 ; $635f
	farcall FarPtr_MoveActorByAngle ; $6362
Label_13_6365:
	ret ; $6365
	INCBIN "data/bank_013/d_6366.bin" ; $6366, 6 bytes
Label_13_636c:
	ldh a, [hRomBank] ; $636c
	ld hl, $6638 ; $636e
	farcall FarPtr_0a_06 ; $6371
	farcall FarPtr_0a_00 ; $6374
	ld a, $00 ; $6377
	ld bc, $3f00 ; $6379
	ld de, $3f00 ; $637c
	farcall FarPtr_ScriptSetActorPosition ; $637f
	ld a, $06 ; $6382
	ld bc, $3f00 ; $6384
	ld de, $3f00 ; $6387
	farcall FarPtr_ScriptSetActorPosition ; $638a
	ld c, $04 ; $638d
	call BeginFadeIn ; $638f
	call WaitFadeEnd ; $6392
	ld a, $06 ; $6395
	ld bc, $2200 ; $6397
	ld de, $3300 ; $639a
	farcall FarPtr_ScriptSetActorPosition ; $639d
	ld a, $06 ; $63a0
	ld bc, $2200 ; $63a2
	ld de, $1d00 ; $63a5
	farcall FarPtr_ScriptSetActorMoveTarget ; $63a8
	push af ; $63ab
	ld a, $0f ; $63ac
	farcall FarPtr_WaitScriptFrames ; $63ae
	pop af ; $63b1
	xor a, a ; $63b2
	ld bc, $2200 ; $63b3
	ld de, $1d00 ; $63b6
	farcall FarPtr_MovePlayerToPosition ; $63b9
	ld a, $00 ; $63bc
	ld bc, $2200 ; $63be
	ld de, $3300 ; $63c1
	farcall FarPtr_ScriptSetActorPosition ; $63c4
	ld a, $00 ; $63c7
	ld bc, $2200 ; $63c9
	ld de, $2100 ; $63cc
	farcall FarPtr_ScriptSetActorMoveTarget ; $63cf
	ld a, $00 ; $63d2
	farcall FarPtr_ScriptWaitActorMoveDone ; $63d4
	push af ; $63d7
	ld a, $0f ; $63d8
	farcall FarPtr_WaitScriptFrames ; $63da
	pop af ; $63dd
	ld a, $00 ; $63de
	ld bc, $2000 ; $63e0
	ld de, $1f00 ; $63e3
	farcall FarPtr_ScriptSetActorMoveTarget ; $63e6
	ld a, $00 ; $63e9
	farcall FarPtr_ScriptWaitActorMoveDone ; $63eb
	push af ; $63ee
	ld a, $1e ; $63ef
	farcall FarPtr_WaitScriptFrames ; $63f1
	pop af ; $63f4
	ld a, $06 ; $63f5
	ld b, $80 ; $63f7
	farcall FarPtr_SetActorFacing ; $63f9
	push af ; $63fc
	ld a, $1e ; $63fd
	farcall FarPtr_WaitScriptFrames ; $63ff
	pop af ; $6402
	ld a, $00 ; $6403
	ld b, $80 ; $6405
	farcall FarPtr_SetActorFacing ; $6407
	push af ; $640a
	ld a, $1e ; $640b
	farcall FarPtr_WaitScriptFrames ; $640d
	pop af ; $6410
	xor a, a ; $6411
	ld bc, $0c00 ; $6412
	ld de, $1b00 ; $6415
	farcall FarPtr_MovePlayerToPosition ; $6418
	farcall FarPtr_WaitPlayerMoveDone ; $641b
	push af ; $641e
	ld a, $1e ; $641f
	farcall FarPtr_WaitScriptFrames ; $6421
	pop af ; $6424
	ld hl, $0206 ; $6425
	farcall FarPtr_0a_0e ; $6428
	ld a, $06 ; $642b
	farcall FarPtr_0a_08 ; $642d
	push af ; $6430
	ld a, $0f ; $6431
	farcall FarPtr_WaitScriptFrames ; $6433
	pop af ; $6436
	ld bc, $0040 ; $6437
	farcall FarPtr_0a_38 ; $643a
	xor a, a ; $643d
	ld bc, $2200 ; $643e
	ld de, $1d00 ; $6441
	farcall FarPtr_MovePlayerToPosition ; $6444
	farcall FarPtr_WaitPlayerMoveDone ; $6447
	ld bc, $0020 ; $644a
	farcall FarPtr_0a_38 ; $644d
	ld a, $04 ; $6450
	ld bc, $2100 ; $6452
	ld de, $1d00 ; $6455
	farcall FarPtr_ScriptSetActorPosition ; $6458
	sound $98 ; $645b
	push af ; $645d
	ld a, $32 ; $645e
	farcall FarPtr_WaitScriptFrames ; $6460
	pop af ; $6463
	ld a, $04 ; $6464
	ld bc, $3f00 ; $6466
	ld de, $3f00 ; $6469
	farcall FarPtr_ScriptSetActorPosition ; $646c
	ld a, $06 ; $646f
	ld d, $02 ; $6471
	farcall FarPtr_ScriptSetActorAnimation ; $6473
	ld a, $06 ; $6476
	farcall FarPtr_ScriptWaitActorIdle ; $6478
	ld a, $06 ; $647b
	farcall FarPtr_0a_08 ; $647d
	push af ; $6480
	ld a, $1e ; $6481
	farcall FarPtr_WaitScriptFrames ; $6483
	pop af ; $6486
	ld a, $06 ; $6487
	ld b, $40 ; $6489
	farcall FarPtr_SetActorFacing ; $648b
	push af ; $648e
	ld a, $0f ; $648f
	farcall FarPtr_WaitScriptFrames ; $6491
	pop af ; $6494
	ld a, $06 ; $6495
	farcall FarPtr_0a_08 ; $6497
	ld a, $06 ; $649a
	ld b, $80 ; $649c
	farcall FarPtr_SetActorFacing ; $649e
	push af ; $64a1
	ld a, $0f ; $64a2
	farcall FarPtr_WaitScriptFrames ; $64a4
	pop af ; $64a7
	ld bc, $0040 ; $64a8
	farcall FarPtr_0a_38 ; $64ab
	xor a, a ; $64ae
	ld bc, $0c00 ; $64af
	ld de, $1600 ; $64b2
	farcall FarPtr_MovePlayerToPosition ; $64b5
	farcall FarPtr_WaitPlayerMoveDone ; $64b8
	ld bc, $0020 ; $64bb
	farcall FarPtr_0a_38 ; $64be
	push af ; $64c1
	ld a, $3c ; $64c2
	farcall FarPtr_WaitScriptFrames ; $64c4
	pop af ; $64c7
	xor a, a ; $64c8
	ld bc, $0c00 ; $64c9
	ld de, $2200 ; $64cc
	farcall FarPtr_MovePlayerToPosition ; $64cf
	farcall FarPtr_WaitPlayerMoveDone ; $64d2
	push af ; $64d5
	ld a, $3c ; $64d6
	farcall FarPtr_WaitScriptFrames ; $64d8
	pop af ; $64db
	xor a, a ; $64dc
	ld bc, $0c00 ; $64dd
	ld de, $1b00 ; $64e0
	farcall FarPtr_MovePlayerToPosition ; $64e3
	farcall FarPtr_WaitPlayerMoveDone ; $64e6
	ld a, $06 ; $64e9
	farcall FarPtr_0a_08 ; $64eb
	push af ; $64ee
	ld a, $0f ; $64ef
	farcall FarPtr_WaitScriptFrames ; $64f1
	pop af ; $64f4
	ld bc, $0040 ; $64f5
	farcall FarPtr_0a_38 ; $64f8
	xor a, a ; $64fb
	ld bc, $2200 ; $64fc
	ld de, $1d00 ; $64ff
	farcall FarPtr_MovePlayerToPosition ; $6502
	farcall FarPtr_WaitPlayerMoveDone ; $6505
	ld bc, $0020 ; $6508
	farcall FarPtr_0a_38 ; $650b
	push af ; $650e
	ld a, $1e ; $650f
	farcall FarPtr_WaitScriptFrames ; $6511
	pop af ; $6514
	ld a, $06 ; $6515
	ld b, $00 ; $6517
	farcall FarPtr_SetActorFacing ; $6519
	push af ; $651c
	ld a, $0f ; $651d
	farcall FarPtr_WaitScriptFrames ; $651f
	pop af ; $6522
	ld a, $00 ; $6523
	ld b, $00 ; $6525
	farcall FarPtr_SetActorFacing ; $6527
	xor a, a ; $652a
	ld bc, $3000 ; $652b
	ld de, $2600 ; $652e
	farcall FarPtr_MovePlayerToPosition ; $6531
	farcall FarPtr_WaitPlayerMoveDone ; $6534
	ld a, $06 ; $6537
	farcall FarPtr_0a_08 ; $6539
	push af ; $653c
	ld a, $0f ; $653d
	farcall FarPtr_WaitScriptFrames ; $653f
	pop af ; $6542
	xor a, a ; $6543
	ld bc, $3600 ; $6544
	ld de, $1000 ; $6547
	farcall FarPtr_MovePlayerToPosition ; $654a
	farcall FarPtr_WaitPlayerMoveDone ; $654d
	ld a, $06 ; $6550
	farcall FarPtr_0a_08 ; $6552
	push af ; $6555
	ld a, $0f ; $6556
	farcall FarPtr_WaitScriptFrames ; $6558
	pop af ; $655b
	ld bc, $0040 ; $655c
	farcall FarPtr_0a_38 ; $655f
	xor a, a ; $6562
	ld bc, $2200 ; $6563
	ld de, $1d00 ; $6566
	farcall FarPtr_MovePlayerToPosition ; $6569
	farcall FarPtr_WaitPlayerMoveDone ; $656c
	ld bc, $0020 ; $656f
	farcall FarPtr_0a_38 ; $6572
	push af ; $6575
	ld a, $0f ; $6576
	farcall FarPtr_WaitScriptFrames ; $6578
	pop af ; $657b
	ld a, $06 ; $657c
	ld b, $40 ; $657e
	farcall FarPtr_SetActorFacing ; $6580
	ld a, $06 ; $6583
	farcall FarPtr_0a_08 ; $6585
	push af ; $6588
	ld a, $1e ; $6589
	farcall FarPtr_WaitScriptFrames ; $658b
	pop af ; $658e
	ld a, $00 ; $658f
	ld b, $c0 ; $6591
	farcall FarPtr_SetActorFacing ; $6593
	ld a, $00 ; $6596
	ld d, $03 ; $6598
	farcall FarPtr_ScriptSetActorAnimation ; $659a
	ld a, $00 ; $659d
	farcall FarPtr_ScriptWaitActorIdle ; $659f
	push af ; $65a2
	ld a, $0f ; $65a3
	farcall FarPtr_WaitScriptFrames ; $65a5
	pop af ; $65a8
	ld a, $06 ; $65a9
	ld d, $02 ; $65ab
	farcall FarPtr_ScriptSetActorAnimation ; $65ad
	ld a, $06 ; $65b0
	farcall FarPtr_ScriptWaitActorIdle ; $65b2
	ld a, $06 ; $65b5
	farcall FarPtr_0a_08 ; $65b7
	ld a, $00 ; $65ba
	ld d, $02 ; $65bc
	farcall FarPtr_ScriptSetActorAnimation ; $65be
	ld a, $00 ; $65c1
	farcall FarPtr_ScriptWaitActorIdle ; $65c3
	push af ; $65c6
	ld a, $1e ; $65c7
	farcall FarPtr_WaitScriptFrames ; $65c9
	pop af ; $65cc
	ld a, $06 ; $65cd
	ld d, $03 ; $65cf
	farcall FarPtr_ScriptSetActorAnimation ; $65d1
	ld a, $06 ; $65d4
	farcall FarPtr_ScriptWaitActorIdle ; $65d6
	ld a, $06 ; $65d9
	farcall FarPtr_0a_08 ; $65db
	ld a, $00 ; $65de
	ld bc, $2200 ; $65e0
	ld de, $1f00 ; $65e3
	farcall FarPtr_ScriptSetActorMoveTarget ; $65e6
	ld a, $00 ; $65e9
	farcall FarPtr_ScriptWaitActorMoveDone ; $65eb
	ld a, $00 ; $65ee
	ld b, $c0 ; $65f0
	farcall FarPtr_SetActorFacing ; $65f2
	push af ; $65f5
	ld a, $0f ; $65f6
	farcall FarPtr_WaitScriptFrames ; $65f8
	pop af ; $65fb
	ld a, $06 ; $65fc
	ld bc, $2200 ; $65fe
	ld de, $0700 ; $6601
	farcall FarPtr_ScriptSetActorMoveTarget ; $6604
	push af ; $6607
	ld a, $05 ; $6608
	farcall FarPtr_WaitScriptFrames ; $660a
	pop af ; $660d
	ld a, $00 ; $660e
	ld bc, $2200 ; $6610
	ld de, $0700 ; $6613
	farcall FarPtr_ScriptSetActorMoveTarget ; $6616
	push af ; $6619
	ld a, $0a ; $661a
	farcall FarPtr_WaitScriptFrames ; $661c
	pop af ; $661f
	xor a, a ; $6620
	ld bc, $2200 ; $6621
	ld de, $0d00 ; $6624
	farcall FarPtr_MovePlayerToPosition ; $6627
	ld a, $00 ; $662a
	farcall FarPtr_ScriptWaitActorMoveDone ; $662c
	ld a, $0f ; $662f
	ld [$c294], a ; $6631
	ld [$c2a1], a ; $6634
	ret ; $6637
	INCBIN "data/bank_013/d_6638.bin" ; $6638, 984 bytes
SetupStoryMinigameMatch0:
	ld a, $05 ; $6a10
	farcall FarPtr_0a_1c ; $6a12
	ld a, $05 ; $6a15
	ld d, $01 ; $6a17
	farcall FarPtr_ScriptSetActorAnimation ; $6a19
	ld a, $07 ; $6a1c
	farcall FarPtr_0a_1c ; $6a1e
	ld a, $07 ; $6a21
	ld bc, $0018 ; $6a23
	farcall FarPtr_0a_18 ; $6a26
	ldh a, [hRomBank] ; $6a29
	ld b, a ; $6a2b
	ld a, $03 ; $6a2c
	ld de, $6b19 ; $6a2e
	farcall FarPtr_0a_1a ; $6a31
	ldh a, [hRomBank] ; $6a34
	ld b, a ; $6a36
	ld a, $06 ; $6a37
	ld de, $6b31 ; $6a39
	farcall FarPtr_0a_1a ; $6a3c
	ldh a, [hRomBank] ; $6a3f
	ld b, a ; $6a41
	ld a, $07 ; $6a42
	ld de, $6b47 ; $6a44
	farcall FarPtr_0a_1a ; $6a47
	ldh a, [hRomBank] ; $6a4a
	ld b, a ; $6a4c
	ld a, $05 ; $6a4d
	ld de, $6b69 ; $6a4f
	farcall FarPtr_0a_1a ; $6a52
	xor a, a ; $6a55
	ld bc, $0c00 ; $6a56
	ld de, $1c00 ; $6a59
	farcall FarPtr_MovePlayerToPosition ; $6a5c
	farcall FarPtr_WaitPlayerMoveDone ; $6a5f
	ldh a, [hRomBank] ; $6a62
	ld b, a ; $6a64
	ld a, $00 ; $6a65
	ld de, $6be7 ; $6a67
	farcall FarPtr_0a_1a ; $6a6a
	ld a, $05 ; $6a6d
	farcall FarPtr_WaitActorScriptDone ; $6a6f
	farcall FarPtr_InitStoryMatchSettings ; $6a72
	ld a, $00 ; $6a75
	ld [wCurrentMinigameStoryMatch], a ; $6a77
	ld a, $0a ; $6a7a
	ld [$c8f7], a ; $6a7c
	farcall FarPtr_LoadMatchSettingsFromTable ; $6a7f
	farcall FarPtr_0a_4c ; $6a82
	farcall FarPtr_0a_4e ; $6a85
	ret ; $6a88
	ld a, $05 ; $6a89
	farcall FarPtr_0a_1c ; $6a8b
	ld a, $07 ; $6a8e
	farcall FarPtr_0a_1c ; $6a90
	ld a, $07 ; $6a93
	ld bc, $0018 ; $6a95
	farcall FarPtr_0a_18 ; $6a98
	ld a, $05 ; $6a9b
	ld d, $01 ; $6a9d
	farcall FarPtr_ScriptSetActorAnimation ; $6a9f
	ld a, $05 ; $6aa2
	ld d, $03 ; $6aa4
	farcall FarPtr_ScriptSetActorAnimation ; $6aa6
	ld a, $05 ; $6aa9
	farcall FarPtr_ScriptWaitActorIdle ; $6aab
	ldh a, [hRomBank] ; $6aae
	ld b, a ; $6ab0
	ld a, $05 ; $6ab1
	ld de, $6b69 ; $6ab3
	farcall FarPtr_0a_1a ; $6ab6
	ldh a, [hRomBank] ; $6ab9
	ld b, a ; $6abb
	ld a, $06 ; $6abc
	ld de, $6b80 ; $6abe
	farcall FarPtr_0a_1a ; $6ac1
	ldh a, [hRomBank] ; $6ac4
	ld b, a ; $6ac6
	ld a, $07 ; $6ac7
	ld de, $6b47 ; $6ac9
	farcall FarPtr_0a_1a ; $6acc
	ldh a, [hRomBank] ; $6acf
	ld b, a ; $6ad1
	ld a, $00 ; $6ad2
	ld de, $6be7 ; $6ad4
	farcall FarPtr_0a_1a ; $6ad7
	ldh a, [hRomBank] ; $6ada
	ld b, a ; $6adc
	ld a, $02 ; $6add
	ld de, $6bdc ; $6adf
	farcall FarPtr_0a_1a ; $6ae2
	ldh a, [hRomBank] ; $6ae5
	ld b, a ; $6ae7
	ld a, $03 ; $6ae8
	ld de, $6b19 ; $6aea
	farcall FarPtr_0a_1a ; $6aed
	xor a, a ; $6af0
	ld bc, $0c00 ; $6af1
	ld de, $1c00 ; $6af4
	farcall FarPtr_MovePlayerToPosition ; $6af7
	farcall FarPtr_WaitPlayerMoveDone ; $6afa
	ld a, $05 ; $6afd
	farcall FarPtr_WaitActorScriptDone ; $6aff
	farcall FarPtr_InitStoryMatchSettings ; $6b02
	ld a, $01 ; $6b05
	ld [wCurrentMinigameStoryMatch], a ; $6b07
	ld a, $0a ; $6b0a
	ld [$c8f7], a ; $6b0c
	farcall FarPtr_LoadMatchSettingsFromTable ; $6b0f
	farcall FarPtr_0a_4c ; $6b12
	farcall FarPtr_0a_4e ; $6b15
	ret ; $6b18
	INCBIN "data/bank_013/d_6b19.bin" ; $6b19, 250 bytes
	ld a, $00 ; $6c13
	ld bc, $0008 ; $6c15
	farcall FarPtr_0a_18 ; $6c18
	ld a, $00 ; $6c1b
	ld b, $01 ; $6c1d
	farcall FarPtr_0a_2c ; $6c1f
	ld a, $00 ; $6c22
	ld bc, $0d00 ; $6c24
	ld de, $1f00 ; $6c27
	farcall FarPtr_ScriptSetActorMoveTarget ; $6c2a
	ld a, $00 ; $6c2d
	farcall FarPtr_ScriptWaitActorMoveDone ; $6c2f
	ld a, $00 ; $6c32
	ld b, $00 ; $6c34
	farcall FarPtr_0a_2c ; $6c36
	ld a, $00 ; $6c39
	ld b, $c0 ; $6c3b
	farcall FarPtr_SetActorFacing ; $6c3d
	ld hl, $0220 ; $6c40
	farcall FarPtr_0a_0e ; $6c43
	ld a, $03 ; $6c46
	farcall FarPtr_0a_0a ; $6c48
	farcall FarPtr_0a_12 ; $6c4b
	farcall FarPtr_0a_0c ; $6c4e
	push af ; $6c51
	ld a, $05 ; $6c52
	farcall FarPtr_WaitScriptFrames ; $6c54
	pop af ; $6c57
	and a, a ; $6c58
	jp nz, Label_13_6df5 ; $6c59
	farcall FarPtr_0a_10 ; $6c5c
	ld a, $00 ; $6c5f
	ld bc, $0010 ; $6c61
	farcall FarPtr_0a_18 ; $6c64
	ld a, $00 ; $6c67
	ld bc, $0d00 ; $6c69
	ld de, $1f00 ; $6c6c
	farcall FarPtr_ScriptSetActorMoveTarget ; $6c6f
	ld a, $00 ; $6c72
	farcall FarPtr_ScriptWaitActorMoveDone ; $6c74
	ld a, $03 ; $6c77
	ld b, a ; $6c79
	ld a, $00 ; $6c7a
	farcall FarPtr_FaceActorTowardActor ; $6c7c
	push af ; $6c7f
	ld a, $1e ; $6c80
	farcall FarPtr_WaitScriptFrames ; $6c82
	pop af ; $6c85
	ld a, $00 ; $6c86
	ld b, a ; $6c88
	ld a, $03 ; $6c89
	farcall FarPtr_FaceActorTowardActor ; $6c8b
	ld a, $03 ; $6c8e
	farcall FarPtr_0a_08 ; $6c90
	ld a, $00 ; $6c93
	ld bc, $0020 ; $6c95
	farcall FarPtr_0a_18 ; $6c98
	push af ; $6c9b
	ld a, $0f ; $6c9c
	farcall FarPtr_WaitScriptFrames ; $6c9e
	pop af ; $6ca1
	ld a, $04 ; $6ca2
	ld b, a ; $6ca4
	ld a, $03 ; $6ca5
	farcall FarPtr_FaceActorTowardActor ; $6ca7
	push af ; $6caa
	ld a, $1e ; $6cab
	farcall FarPtr_WaitScriptFrames ; $6cad
	pop af ; $6cb0
	ld a, $04 ; $6cb1
	ld b, a ; $6cb3
	ld a, $00 ; $6cb4
	farcall FarPtr_FaceActorTowardActor ; $6cb6
	push af ; $6cb9
	ld a, $1e ; $6cba
	farcall FarPtr_WaitScriptFrames ; $6cbc
	pop af ; $6cbf
	ld bc, $0020 ; $6cc0
	farcall FarPtr_0a_38 ; $6cc3
	ld a, $04 ; $6cc6
	ld b, $00 ; $6cc8
	farcall FarPtr_MovePlayerToActor ; $6cca
	farcall FarPtr_WaitPlayerMoveDone ; $6ccd
	ld a, $04 ; $6cd0
	ld d, $03 ; $6cd2
	farcall FarPtr_ScriptSetActorAnimation ; $6cd4
	ld a, $04 ; $6cd7
	farcall FarPtr_ScriptWaitActorIdle ; $6cd9
	ld a, $04 ; $6cdc
	ld bc, $0b00 ; $6cde
	ld de, $1f00 ; $6ce1
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ce4
	ld a, $00 ; $6ce7
	ld b, $00 ; $6ce9
	farcall FarPtr_MovePlayerToActor ; $6ceb
	ld a, $04 ; $6cee
	farcall FarPtr_ScriptWaitActorMoveDone ; $6cf0
	ld a, $03 ; $6cf3
	ld b, $40 ; $6cf5
	farcall FarPtr_SetActorFacing ; $6cf7
	push af ; $6cfa
	ld a, $0f ; $6cfb
	farcall FarPtr_WaitScriptFrames ; $6cfd
	pop af ; $6d00
	ld a, $04 ; $6d01
	ld b, $c0 ; $6d03
	farcall FarPtr_SetActorFacing ; $6d05
	ld a, $00 ; $6d08
	ld b, $c0 ; $6d0a
	farcall FarPtr_SetActorFacing ; $6d0c
	push af ; $6d0f
	ld a, $0f ; $6d10
	farcall FarPtr_WaitScriptFrames ; $6d12
	pop af ; $6d15
	ld a, $03 ; $6d16
	ld d, $02 ; $6d18
	farcall FarPtr_ScriptSetActorAnimation ; $6d1a
	ld a, $03 ; $6d1d
	farcall FarPtr_ScriptWaitActorIdle ; $6d1f
	ld a, $03 ; $6d22
	farcall FarPtr_0a_0a ; $6d24
	farcall FarPtr_0a_12 ; $6d27
	farcall FarPtr_0a_0c ; $6d2a
	push af ; $6d2d
	ld a, $05 ; $6d2e
	farcall FarPtr_WaitScriptFrames ; $6d30
	pop af ; $6d33
	and a, a ; $6d34
	jp nz, Label_13_6dfb ; $6d35
	ld a, $03 ; $6d38
	ld d, $03 ; $6d3a
	farcall FarPtr_ScriptSetActorAnimation ; $6d3c
	ld a, $03 ; $6d3f
	farcall FarPtr_ScriptWaitActorIdle ; $6d41
Label_13_6d44:
	ld hl, $0224 ; $6d44
	farcall FarPtr_0a_0e ; $6d47
	ld a, $03 ; $6d4a
	ld d, $03 ; $6d4c
	farcall FarPtr_ScriptSetActorAnimation ; $6d4e
	ld a, $03 ; $6d51
	farcall FarPtr_ScriptWaitActorIdle ; $6d53
	ld a, $03 ; $6d56
	farcall FarPtr_0a_08 ; $6d58
	ld a, $07 ; $6d5b
	ld [wStoryModeCurrentLocation], a ; $6d5d
	ld a, $0d ; $6d60
	ld [$c295], a ; $6d62
	ld a, $ff ; $6d65
	ld [$c294], a ; $6d67
	ld [$c2a1], a ; $6d6a
	ld a, $07 ; $6d6d
	farcall FarPtr_0a_1c ; $6d6f
	ld a, $00 ; $6d72
	ld bc, $0020 ; $6d74
	farcall FarPtr_0a_18 ; $6d77
	ld a, $02 ; $6d7a
	ld bc, $0020 ; $6d7c
	farcall FarPtr_0a_18 ; $6d7f
	ld a, $07 ; $6d82
	ld bc, $0018 ; $6d84
	farcall FarPtr_0a_18 ; $6d87
	ldh a, [hRomBank] ; $6d8a
	ld b, a ; $6d8c
	ld a, $04 ; $6d8d
	ld de, $6b97 ; $6d8f
	farcall FarPtr_0a_1a ; $6d92
	ldh a, [hRomBank] ; $6d95
	ld b, a ; $6d97
	ld a, $00 ; $6d98
	ld de, $6be7 ; $6d9a
	farcall FarPtr_0a_1a ; $6d9d
	ldh a, [hRomBank] ; $6da0
	ld b, a ; $6da2
	ld a, $07 ; $6da3
	ld de, $6b47 ; $6da5
	farcall FarPtr_0a_1a ; $6da8
	ldh a, [hRomBank] ; $6dab
	ld b, a ; $6dad
	ld a, $03 ; $6dae
	ld de, $6b19 ; $6db0
	farcall FarPtr_0a_1a ; $6db3
	ldh a, [hRomBank] ; $6db6
	ld b, a ; $6db8
	ld a, $05 ; $6db9
	ld de, $6b24 ; $6dbb
	farcall FarPtr_0a_1a ; $6dbe
	ldh a, [hRomBank] ; $6dc1
	ld b, a ; $6dc3
	ld a, $06 ; $6dc4
	ld de, $6b31 ; $6dc6
	farcall FarPtr_0a_1a ; $6dc9
	xor a, a ; $6dcc
	ld bc, $0c00 ; $6dcd
	ld de, $1b00 ; $6dd0
	farcall FarPtr_MovePlayerToPosition ; $6dd3
	farcall FarPtr_WaitPlayerMoveDone ; $6dd6
	ld a, $04 ; $6dd9
	farcall FarPtr_WaitActorScriptDone ; $6ddb
	farcall FarPtr_InitStoryMatchSettings ; $6dde
	ld a, $00 ; $6de1
	ld [wCurrentMinigameStoryMatch], a ; $6de3
	ld a, $0b ; $6de6
	ld [$c8f7], a ; $6de8
	farcall FarPtr_LoadMatchSettingsFromTable ; $6deb
	farcall FarPtr_0a_4c ; $6dee
	farcall FarPtr_0a_4e ; $6df1
	ret ; $6df4
Label_13_6df5:
	ld a, $03 ; $6df5
	farcall FarPtr_0a_08 ; $6df7
	ret ; $6dfa
Label_13_6dfb:
	farcall FarPtr_0a_10 ; $6dfb
	ld a, $03 ; $6dfe
	farcall FarPtr_0a_0a ; $6e00
	farcall FarPtr_0a_12 ; $6e03
	farcall FarPtr_0a_0c ; $6e06
	push af ; $6e09
	ld a, $05 ; $6e0a
	farcall FarPtr_WaitScriptFrames ; $6e0c
	pop af ; $6e0f
	and a, a ; $6e10
	jr z, Label_13_6e17 ; $6e11
	jp Label_13_6d44 ; $6e13
	ret ; $6e16
Label_13_6e17:
	ld a, $03 ; $6e17
	farcall FarPtr_0a_08 ; $6e19
	call Func_13_70c9 ; $6e1c
	ret ; $6e1f
	ld a, $00 ; $6e20
	ld bc, $0008 ; $6e22
	farcall FarPtr_0a_18 ; $6e25
	ld a, $00 ; $6e28
	ld b, $01 ; $6e2a
	farcall FarPtr_0a_2c ; $6e2c
	ld a, $00 ; $6e2f
	ld bc, $0d00 ; $6e31
	ld de, $1f00 ; $6e34
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e37
	ld a, $00 ; $6e3a
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e3c
	ld a, $00 ; $6e3f
	ld b, $00 ; $6e41
	farcall FarPtr_0a_2c ; $6e43
	ld a, $00 ; $6e46
	ld b, $c0 ; $6e48
	farcall FarPtr_SetActorFacing ; $6e4a
	ld a, $02 ; $6e4d
	farcall FarPtr_0a_1c ; $6e4f
	ld hl, $040c ; $6e52
	farcall FarPtr_0a_0e ; $6e55
	ld a, $03 ; $6e58
	farcall FarPtr_0a_0a ; $6e5a
	farcall FarPtr_0a_12 ; $6e5d
	farcall FarPtr_0a_0c ; $6e60
	push af ; $6e63
	ld a, $05 ; $6e64
	farcall FarPtr_WaitScriptFrames ; $6e66
	pop af ; $6e69
	and a, a ; $6e6a
	jp nz, Label_13_707d ; $6e6b
	farcall FarPtr_0a_10 ; $6e6e
	ld a, $00 ; $6e71
	ld bc, $0010 ; $6e73
	farcall FarPtr_0a_18 ; $6e76
	ld a, $02 ; $6e79
	ld bc, $0010 ; $6e7b
	farcall FarPtr_0a_18 ; $6e7e
	ld a, $02 ; $6e81
	ld bc, $0d00 ; $6e83
	ld de, $2100 ; $6e86
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e89
	ld a, $00 ; $6e8c
	ld bc, $0d00 ; $6e8e
	ld de, $1f00 ; $6e91
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e94
	ld a, $00 ; $6e97
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e99
	ld a, $03 ; $6e9c
	ld b, a ; $6e9e
	ld a, $00 ; $6e9f
	farcall FarPtr_FaceActorTowardActor ; $6ea1
	ld a, $02 ; $6ea4
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ea6
	ld a, $03 ; $6ea9
	ld b, a ; $6eab
	ld a, $02 ; $6eac
	farcall FarPtr_FaceActorTowardActor ; $6eae
	push af ; $6eb1
	ld a, $1e ; $6eb2
	farcall FarPtr_WaitScriptFrames ; $6eb4
	pop af ; $6eb7
	ld a, $00 ; $6eb8
	ld bc, $0020 ; $6eba
	farcall FarPtr_0a_18 ; $6ebd
	ld a, $02 ; $6ec0
	ld bc, $0020 ; $6ec2
	farcall FarPtr_0a_18 ; $6ec5
	ld a, $00 ; $6ec8
	ld b, a ; $6eca
	ld a, $03 ; $6ecb
	farcall FarPtr_FaceActorTowardActor ; $6ecd
	ld a, $03 ; $6ed0
	farcall FarPtr_0a_08 ; $6ed2
	push af ; $6ed5
	ld a, $0f ; $6ed6
	farcall FarPtr_WaitScriptFrames ; $6ed8
	pop af ; $6edb
	ld a, $04 ; $6edc
	ld b, a ; $6ede
	ld a, $03 ; $6edf
	farcall FarPtr_FaceActorTowardActor ; $6ee1
	push af ; $6ee4
	ld a, $1e ; $6ee5
	farcall FarPtr_WaitScriptFrames ; $6ee7
	pop af ; $6eea
	ld a, $09 ; $6eeb
	ld b, a ; $6eed
	ld a, $00 ; $6eee
	farcall FarPtr_FaceActorTowardActor ; $6ef0
	ld a, $04 ; $6ef3
	ld b, a ; $6ef5
	ld a, $02 ; $6ef6
	farcall FarPtr_FaceActorTowardActor ; $6ef8
	push af ; $6efb
	ld a, $1e ; $6efc
	farcall FarPtr_WaitScriptFrames ; $6efe
	pop af ; $6f01
	ld bc, $0020 ; $6f02
	farcall FarPtr_0a_38 ; $6f05
	ld a, $04 ; $6f08
	ld b, $00 ; $6f0a
	farcall FarPtr_MovePlayerToActor ; $6f0c
	farcall FarPtr_WaitPlayerMoveDone ; $6f0f
	ld a, $00 ; $6f12
	ld b, a ; $6f14
	ld a, $04 ; $6f15
	farcall FarPtr_FaceActorTowardActor ; $6f17
	ld a, $00 ; $6f1a
	ld b, a ; $6f1c
	ld a, $09 ; $6f1d
	farcall FarPtr_FaceActorTowardActor ; $6f1f
	ld a, $04 ; $6f22
	ld d, $03 ; $6f24
	farcall FarPtr_ScriptSetActorAnimation ; $6f26
	ld a, $04 ; $6f29
	farcall FarPtr_ScriptWaitActorIdle ; $6f2b
	ld a, $04 ; $6f2e
	ld bc, $0b00 ; $6f30
	ld de, $2100 ; $6f33
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f36
	ld a, $09 ; $6f39
	ld bc, $0b00 ; $6f3b
	ld de, $1f00 ; $6f3e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f41
	ld a, $00 ; $6f44
	ld b, $00 ; $6f46
	farcall FarPtr_MovePlayerToActor ; $6f48
	push af ; $6f4b
	ld a, $0f ; $6f4c
	farcall FarPtr_WaitScriptFrames ; $6f4e
	pop af ; $6f51
	ld a, $03 ; $6f52
	ld b, $40 ; $6f54
	farcall FarPtr_SetActorFacing ; $6f56
	push af ; $6f59
	ld a, $0f ; $6f5a
	farcall FarPtr_WaitScriptFrames ; $6f5c
	pop af ; $6f5f
	ld a, $04 ; $6f60
	farcall FarPtr_ScriptWaitActorMoveDone ; $6f62
	ld a, $04 ; $6f65
	ld b, $c0 ; $6f67
	farcall FarPtr_SetActorFacing ; $6f69
	ld a, $09 ; $6f6c
	ld b, $c0 ; $6f6e
	farcall FarPtr_SetActorFacing ; $6f70
	ld a, $00 ; $6f73
	ld b, $c0 ; $6f75
	farcall FarPtr_SetActorFacing ; $6f77
	ld a, $02 ; $6f7a
	ld b, $c0 ; $6f7c
	farcall FarPtr_SetActorFacing ; $6f7e
	push af ; $6f81
	ld a, $0f ; $6f82
	farcall FarPtr_WaitScriptFrames ; $6f84
	pop af ; $6f87
	ld a, $03 ; $6f88
	ld d, $02 ; $6f8a
	farcall FarPtr_ScriptSetActorAnimation ; $6f8c
	ld a, $03 ; $6f8f
	farcall FarPtr_ScriptWaitActorIdle ; $6f91
	ld a, $03 ; $6f94
	farcall FarPtr_0a_0a ; $6f96
	farcall FarPtr_0a_12 ; $6f99
	farcall FarPtr_0a_0c ; $6f9c
	push af ; $6f9f
	ld a, $05 ; $6fa0
	farcall FarPtr_WaitScriptFrames ; $6fa2
	pop af ; $6fa5
	and a, a ; $6fa6
	jp nz, Label_13_7090 ; $6fa7
	ld a, $03 ; $6faa
	ld d, $03 ; $6fac
	farcall FarPtr_ScriptSetActorAnimation ; $6fae
	ld a, $03 ; $6fb1
	farcall FarPtr_ScriptWaitActorIdle ; $6fb3
Label_13_6fb6:
	ld hl, $0410 ; $6fb6
	farcall FarPtr_0a_0e ; $6fb9
	ld a, $03 ; $6fbc
	ld d, $03 ; $6fbe
	farcall FarPtr_ScriptSetActorAnimation ; $6fc0
	ld a, $03 ; $6fc3
	farcall FarPtr_ScriptWaitActorIdle ; $6fc5
	ld a, $03 ; $6fc8
	farcall FarPtr_0a_08 ; $6fca
	ld a, $07 ; $6fcd
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [$c295], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [$c294], a ; $6fd9
	ld [$c2a1], a ; $6fdc
	ld a, $00 ; $6fdf
	ld bc, $0020 ; $6fe1
	farcall FarPtr_0a_18 ; $6fe4
	ld a, $02 ; $6fe7
	ld bc, $0020 ; $6fe9
	farcall FarPtr_0a_18 ; $6fec
	ldh a, [hRomBank] ; $6fef
	ld b, a ; $6ff1
	ld a, $04 ; $6ff2
	ld de, $6bae ; $6ff4
	farcall FarPtr_0a_1a ; $6ff7
	ldh a, [hRomBank] ; $6ffa
	ld b, a ; $6ffc
	ld a, $09 ; $6ffd
	ld de, $6bc5 ; $6fff
	farcall FarPtr_0a_1a ; $7002
	ldh a, [hRomBank] ; $7005
	ld b, a ; $7007
	ld a, $00 ; $7008
	ld de, $6be7 ; $700a
	farcall FarPtr_0a_1a ; $700d
	ldh a, [hRomBank] ; $7010
	ld b, a ; $7012
	ld a, $02 ; $7013
	ld de, $6bdc ; $7015
	farcall FarPtr_0a_1a ; $7018
	ld a, $07 ; $701b
	farcall FarPtr_0a_1c ; $701d
	ld a, $07 ; $7020
	ld bc, $0018 ; $7022
	farcall FarPtr_0a_18 ; $7025
	ldh a, [hRomBank] ; $7028
	ld b, a ; $702a
	ld a, $03 ; $702b
	ld de, $6b19 ; $702d
	farcall FarPtr_0a_1a ; $7030
	ldh a, [hRomBank] ; $7033
	ld b, a ; $7035
	ld a, $05 ; $7036
	ld de, $6b24 ; $7038
	farcall FarPtr_0a_1a ; $703b
	ldh a, [hRomBank] ; $703e
	ld b, a ; $7040
	ld a, $06 ; $7041
	ld de, $6b3c ; $7043
	farcall FarPtr_0a_1a ; $7046
	ldh a, [hRomBank] ; $7049
	ld b, a ; $704b
	ld a, $07 ; $704c
	ld de, $6b58 ; $704e
	farcall FarPtr_0a_1a ; $7051
	xor a, a ; $7054
	ld bc, $0c00 ; $7055
	ld de, $1b00 ; $7058
	farcall FarPtr_MovePlayerToPosition ; $705b
	farcall FarPtr_WaitPlayerMoveDone ; $705e
	ld a, $04 ; $7061
	farcall FarPtr_WaitActorScriptDone ; $7063
	farcall FarPtr_InitStoryMatchSettings ; $7066
	ld a, $01 ; $7069
	ld [wCurrentMinigameStoryMatch], a ; $706b
	ld a, $0d ; $706e
	ld [$c8f7], a ; $7070
	farcall FarPtr_LoadMatchSettingsFromTable ; $7073
	farcall FarPtr_0a_4c ; $7076
	farcall FarPtr_0a_4e ; $7079
	ret ; $707c
Label_13_707d:
	ld a, $03 ; $707d
	farcall FarPtr_0a_08 ; $707f
	ld a, $02 ; $7082
	farcall FarPtr_GetActorStateAddr ; $7084
	ld c, l ; $7087
	ld b, h ; $7088
	ld de, $d000 ; $7089
	farcall FarPtr_04_20 ; $708c
	ret ; $708f
Label_13_7090:
	farcall FarPtr_0a_10 ; $7090
	ld a, $03 ; $7093
	farcall FarPtr_0a_0a ; $7095
	farcall FarPtr_0a_12 ; $7098
	farcall FarPtr_0a_0c ; $709b
	push af ; $709e
	ld a, $05 ; $709f
	farcall FarPtr_WaitScriptFrames ; $70a1
	pop af ; $70a4
	and a, a ; $70a5
	jr z, Label_13_70ac ; $70a6
	jp Label_13_6fb6 ; $70a8
	ret ; $70ab
Label_13_70ac:
	ld a, $03 ; $70ac
	farcall FarPtr_0a_08 ; $70ae
	call Func_13_70d5 ; $70b1
	push af ; $70b4
	ld a, $3c ; $70b5
	farcall FarPtr_WaitScriptFrames ; $70b7
	pop af ; $70ba
	ld a, $02 ; $70bb
	farcall FarPtr_GetActorStateAddr ; $70bd
	ld c, l ; $70c0
	ld b, h ; $70c1
	ld de, $d000 ; $70c2
	farcall FarPtr_04_20 ; $70c5
	ret ; $70c8
Func_13_70c9:
	ldh a, [hRomBank] ; $70c9
	ld b, a ; $70cb
	ld a, $04 ; $70cc
	ld de, $6bf2 ; $70ce
	farcall FarPtr_0a_1a ; $70d1
	ret ; $70d4
Func_13_70d5:
	ldh a, [hRomBank] ; $70d5
	ld b, a ; $70d7
	ld a, $04 ; $70d8
	ld de, $6bfd ; $70da
	farcall FarPtr_0a_1a ; $70dd
	ldh a, [hRomBank] ; $70e0
	ld b, a ; $70e2
	ld a, $09 ; $70e3
	ld de, $6c08 ; $70e5
	farcall FarPtr_0a_1a ; $70e8
	ret ; $70eb
	wram_bank $04 ; $70ec
	ld a, [wMatchWinLoseFlag] ; $70f2
	cp a, $01 ; $70f5
	jp z, Func_13_70fb ; $70f7
	ret ; $70fa
Func_13_70fb:
	wram_bank $06 ; $70fb
	ldh a, [hRomBank] ; $7101
	ld hl, $739c ; $7103
	farcall FarPtr_0a_06 ; $7106
	ld a, $01 ; $7109
	farcall FarPtr_0a_1c ; $710b
	ld bc, $0040 ; $710e
	farcall FarPtr_0a_38 ; $7111
	call Func_13_62be ; $7114
	ld a, $00 ; $7117
	ld bc, $0b00 ; $7119
	ld de, $1d00 ; $711c
	farcall FarPtr_ScriptSetActorPosition ; $711f
	ld a, $02 ; $7122
	ld bc, $0d00 ; $7124
	ld de, $2300 ; $7127
	farcall FarPtr_ScriptSetActorPosition ; $712a
	ld a, $00 ; $712d
	ld b, $c0 ; $712f
	farcall FarPtr_SetActorFacing ; $7131
	ld a, $02 ; $7134
	ld b, $c0 ; $7136
	farcall FarPtr_SetActorFacing ; $7138
	xor a, a ; $713b
	ld bc, $0b00 ; $713c
	ld de, $1100 ; $713f
	farcall FarPtr_MovePlayerToPosition ; $7142
	farcall FarPtr_WaitPlayerMoveDone ; $7145
	ld c, $04 ; $7148
	call BeginFadeIn ; $714a
	call WaitFadeEnd ; $714d
	push af ; $7150
	ld a, $3c ; $7151
	farcall FarPtr_WaitScriptFrames ; $7153
	pop af ; $7156
	ld hl, $022a ; $7157
	farcall FarPtr_0a_0e ; $715a
	ld bc, $0020 ; $715d
	farcall FarPtr_0a_38 ; $7160
	xor a, a ; $7163
	ld bc, $0b00 ; $7164
	ld de, $1700 ; $7167
	farcall FarPtr_MovePlayerToPosition ; $716a
	farcall FarPtr_WaitPlayerMoveDone ; $716d
	ld a, $04 ; $7170
	ld bc, $0b00 ; $7172
	ld de, $1700 ; $7175
	farcall FarPtr_ScriptSetActorMoveTarget ; $7178
	ld a, $04 ; $717b
	farcall FarPtr_ScriptWaitActorMoveDone ; $717d
	ld a, $04 ; $7180
	farcall FarPtr_0a_08 ; $7182
	ld a, $00 ; $7185
	ld d, $03 ; $7187
	farcall FarPtr_ScriptSetActorAnimation ; $7189
	ld a, $00 ; $718c
	farcall FarPtr_ScriptWaitActorIdle ; $718e
	ld a, $0d ; $7191
	farcall FarPtr_0a_08 ; $7193
	ld a, $0c ; $7196
	ld bc, $0c40 ; $7198
	ld de, $1bc0 ; $719b
	farcall FarPtr_ScriptSetActorPosition ; $719e
	sound $98 ; $71a1
	push af ; $71a3
	ld a, $28 ; $71a4
	farcall FarPtr_WaitScriptFrames ; $71a6
	pop af ; $71a9
	ld a, $0c ; $71aa
	ld bc, $3f00 ; $71ac
	ld de, $3f00 ; $71af
	farcall FarPtr_ScriptSetActorPosition ; $71b2
	ld a, $00 ; $71b5
	ld b, $00 ; $71b7
	farcall FarPtr_SetActorFacing ; $71b9
	ld a, $0d ; $71bc
	ld b, $00 ; $71be
	farcall FarPtr_MovePlayerToActor ; $71c0
	farcall FarPtr_WaitPlayerMoveDone ; $71c3
	push af ; $71c6
	ld a, $28 ; $71c7
	farcall FarPtr_WaitScriptFrames ; $71c9
	pop af ; $71cc
	ld a, $00 ; $71cd
	ld b, $00 ; $71cf
	farcall FarPtr_MovePlayerToActor ; $71d1
	ldh a, [hRomBank] ; $71d4
	ld b, a ; $71d6
	ld a, $08 ; $71d7
	ld de, $7a43 ; $71d9
	farcall FarPtr_0a_1a ; $71dc
	ldh a, [hRomBank] ; $71df
	ld b, a ; $71e1
	ld a, $09 ; $71e2
	ld de, $7aa7 ; $71e4
	farcall FarPtr_0a_1a ; $71e7
	ldh a, [hRomBank] ; $71ea
	ld b, a ; $71ec
	ld a, $0d ; $71ed
	ld de, $7aa0 ; $71ef
	farcall FarPtr_0a_1a ; $71f2
	push af ; $71f5
	ld a, $0a ; $71f6
	farcall FarPtr_WaitScriptFrames ; $71f8
	pop af ; $71fb
	ldh a, [hRomBank] ; $71fc
	ld b, a ; $71fe
	ld a, $03 ; $71ff
	ld de, $7a7d ; $7201
	farcall FarPtr_0a_1a ; $7204
	farcall FarPtr_WaitPlayerMoveDone ; $7207
	ld a, $03 ; $720a
	farcall FarPtr_WaitActorScriptDone ; $720c
	ld a, $00 ; $720f
	ld b, a ; $7211
	ld a, $0d ; $7212
	farcall FarPtr_FaceActorTowardActor ; $7214
	test_flag $1c, 0 ; $7217
	jr z, Label_13_724d ; $721a
	farcall FarPtr_0a_10 ; $721c
	ld a, $0d ; $721f
	ld d, $02 ; $7221
	farcall FarPtr_ScriptSetActorAnimation ; $7223
	ld a, $0d ; $7226
	farcall FarPtr_ScriptWaitActorIdle ; $7228
	ld a, $0d ; $722b
	farcall FarPtr_0a_08 ; $722d
	ld a, $0d ; $7230
	ld b, a ; $7232
	ld a, $00 ; $7233
	farcall FarPtr_FaceActorTowardActor ; $7235
	ld a, $0d ; $7238
	ld d, $03 ; $723a
	farcall FarPtr_ScriptSetActorAnimation ; $723c
	ld a, $00 ; $723f
	ld d, $03 ; $7241
	farcall FarPtr_ScriptSetActorAnimation ; $7243
	ld a, $00 ; $7246
	farcall FarPtr_ScriptWaitActorIdle ; $7248
	jr Label_13_727c ; $724b
Label_13_724d:
	ld a, $0d ; $724d
	ld d, $02 ; $724f
	farcall FarPtr_ScriptSetActorAnimation ; $7251
	ld a, $0d ; $7254
	farcall FarPtr_ScriptWaitActorIdle ; $7256
	ld a, $0d ; $7259
	farcall FarPtr_0a_08 ; $725b
	ld a, $0d ; $725e
	ld b, a ; $7260
	ld a, $00 ; $7261
	farcall FarPtr_FaceActorTowardActor ; $7263
	ld a, $0d ; $7266
	ld d, $03 ; $7268
	farcall FarPtr_ScriptSetActorAnimation ; $726a
	ld a, $00 ; $726d
	ld d, $03 ; $726f
	farcall FarPtr_ScriptSetActorAnimation ; $7271
	ld a, $00 ; $7274
	farcall FarPtr_ScriptWaitActorIdle ; $7276
	farcall FarPtr_0a_10 ; $7279
Label_13_727c:
	ld a, $09 ; $727c
	ld b, $40 ; $727e
	farcall FarPtr_SetActorFacing ; $7280
	ld a, $09 ; $7283
	ld d, $04 ; $7285
	farcall FarPtr_ScriptSetActorAnimation ; $7287
	ld a, $09 ; $728a
	farcall FarPtr_ScriptWaitActorIdle ; $728c
	ld a, $09 ; $728f
	ld b, $00 ; $7291
	farcall FarPtr_SetActorFacing ; $7293
	ld a, $09 ; $7296
	ld b, a ; $7298
	ld a, $00 ; $7299
	farcall FarPtr_FaceActorTowardActor ; $729b
	ld a, $09 ; $729e
	farcall FarPtr_0a_08 ; $72a0
	ld a, $00 ; $72a3
	ld d, $02 ; $72a5
	farcall FarPtr_ScriptSetActorAnimation ; $72a7
	ld a, $00 ; $72aa
	farcall FarPtr_ScriptWaitActorIdle ; $72ac
	push af ; $72af
	ld a, $14 ; $72b0
	farcall FarPtr_WaitScriptFrames ; $72b2
	pop af ; $72b5
	ld a, $08 ; $72b6
	ld bc, $0a00 ; $72b8
	ld de, $1f00 ; $72bb
	farcall FarPtr_ScriptSetActorMoveTarget ; $72be
	ld a, $08 ; $72c1
	farcall FarPtr_ScriptWaitActorMoveDone ; $72c3
	push af ; $72c6
	ld a, $14 ; $72c7
	farcall FarPtr_WaitScriptFrames ; $72c9
	pop af ; $72cc
	ld a, $08 ; $72cd
	ld b, a ; $72cf
	ld a, $00 ; $72d0
	farcall FarPtr_FaceActorTowardActor ; $72d2
	ld a, $08 ; $72d5
	ld b, a ; $72d7
	ld a, $0d ; $72d8
	farcall FarPtr_FaceActorTowardActor ; $72da
	push af ; $72dd
	ld a, $14 ; $72de
	farcall FarPtr_WaitScriptFrames ; $72e0
	pop af ; $72e3
	ld a, $08 ; $72e4
	ld d, $03 ; $72e6
	farcall FarPtr_ScriptSetActorAnimation ; $72e8
	ld a, $08 ; $72eb
	farcall FarPtr_ScriptWaitActorIdle ; $72ed
	ld a, $08 ; $72f0
	farcall FarPtr_0a_08 ; $72f2
	push af ; $72f5
	ld a, $14 ; $72f6
	farcall FarPtr_WaitScriptFrames ; $72f8
	pop af ; $72fb
	ld a, $03 ; $72fc
	ld bc, $0c00 ; $72fe
	ld de, $1f00 ; $7301
	farcall FarPtr_ScriptSetActorMoveTarget ; $7304
	ld a, $03 ; $7307
	farcall FarPtr_ScriptWaitActorMoveDone ; $7309
	push af ; $730c
	ld a, $14 ; $730d
	farcall FarPtr_WaitScriptFrames ; $730f
	pop af ; $7312
	ld a, $03 ; $7313
	ld d, $02 ; $7315
	farcall FarPtr_ScriptSetActorAnimation ; $7317
	ld a, $03 ; $731a
	farcall FarPtr_ScriptWaitActorIdle ; $731c
	ld a, $03 ; $731f
	farcall FarPtr_0a_08 ; $7321
	ld a, $0d ; $7324
	ld d, $02 ; $7326
	farcall FarPtr_ScriptSetActorAnimation ; $7328
	ld a, $0d ; $732b
	farcall FarPtr_ScriptWaitActorIdle ; $732d
	ld a, $00 ; $7330
	ld b, a ; $7332
	ld a, $0d ; $7333
	farcall FarPtr_FaceActorTowardActor ; $7335
	test_flag $1c, 0 ; $7338
	jr z, Label_13_7340 ; $733b
	farcall FarPtr_0a_10 ; $733d
Label_13_7340:
	ld a, $0d ; $7340
	farcall FarPtr_0a_08 ; $7342
	ld a, $0d ; $7345
	ld b, a ; $7347
	ld a, $00 ; $7348
	farcall FarPtr_FaceActorTowardActor ; $734a
	ld a, $00 ; $734d
	ld d, $03 ; $734f
	farcall FarPtr_ScriptSetActorAnimation ; $7351
	ld a, $00 ; $7354
	farcall FarPtr_ScriptWaitActorIdle ; $7356
	push af ; $7359
	ld a, $0a ; $735a
	farcall FarPtr_WaitScriptFrames ; $735c
	pop af ; $735f
	ld a, $08 ; $7360
	ld b, a ; $7362
	ld a, $00 ; $7363
	farcall FarPtr_FaceActorTowardActor ; $7365
	push af ; $7368
	ld a, $0a ; $7369
	farcall FarPtr_WaitScriptFrames ; $736b
	pop af ; $736e
	ld a, $00 ; $736f
	ld d, $03 ; $7371
	farcall FarPtr_ScriptSetActorAnimation ; $7373
	ld c, $02 ; $7376
	call BeginFadeOut ; $7378
	call WaitFadeEnd ; $737b
	ld b, $00 ; $737e
	ld a, [$c90d] ; $7380
	add a, $04 ; $7383
	ld c, a ; $7385
	farcall FarPtr_18_8e ; $7386
	ld a, $00 ; $7389
	ld [wStoryModeCurrentLocation], a ; $738b
	ld a, $0a ; $738e
	ld [$c295], a ; $7390
	ld a, $ff ; $7393
	ld [$c294], a ; $7395
	ld [$c2a1], a ; $7398
	ret ; $739b
	nop ; $739c
	nop ; $739d
	dec h ; $739e
	ld a, e ; $739f
	nop ; $73a0
	add hl, de ; $73a1
	nop ; $73a2
	rra ; $73a3
	add a, b ; $73a4
	nop ; $73a5
	ld c, e ; $73a6
	ld bc, $0000 ; $73a7
	nop ; $73aa
	nop ; $73ab
	dec h ; $73ac
	ld a, e ; $73ad
	nop ; $73ae
	dec bc ; $73af
	nop ; $73b0
	inc de ; $73b1
	ld b, b ; $73b2
	nop ; $73b3
	ld l, b ; $73b4
	ld bc, $0007 ; $73b5
	nop ; $73b8
	nop ; $73b9
	dec h ; $73ba
	ld a, e ; $73bb
	nop ; $73bc
	inc de ; $73bd
	nop ; $73be
	ld hl, $0080 ; $73bf
	ld h, l ; $73c2
	ld bc, $0003 ; $73c3
	nop ; $73c6
	nop ; $73c7
	dec h ; $73c8
	ld a, e ; $73c9
	nop ; $73ca
	inc de ; $73cb
	nop ; $73cc
	inc hl ; $73cd
	add a, b ; $73ce
	nop ; $73cf
	ld h, a ; $73d0
	ld bc, $0006 ; $73d1
	nop ; $73d4
	nop ; $73d5
	dec h ; $73d6
	ld a, e ; $73d7
	nop ; $73d8
	inc de ; $73d9
	nop ; $73da
	rla ; $73db
	add a, b ; $73dc
	nop ; $73dd
	ld l, e ; $73de
	ld bc, $0006 ; $73df
	nop ; $73e2
	nop ; $73e3
	dec h ; $73e4
	ld a, e ; $73e5
	nop ; $73e6
	dec de ; $73e7
	nop ; $73e8
	dec e ; $73e9
	add a, b ; $73ea
	nop ; $73eb
	ld c, c ; $73ec
	ld bc, $0000 ; $73ed
	nop ; $73f0
	nop ; $73f1
	dec h ; $73f2
	ld a, e ; $73f3
	nop ; $73f4
	add hl, de ; $73f5
	nop ; $73f6
	dec e ; $73f7
	add a, b ; $73f8
	nop ; $73f9
	ld c, d ; $73fa
	ld bc, $0000 ; $73fb
	nop ; $73fe
	nop ; $73ff
	dec h ; $7400
	ld a, e ; $7401
	nop ; $7402
	dec a ; $7403
	nop ; $7404
	dec a ; $7405
	add a, b ; $7406
	nop ; $7407
	ld d, e ; $7408
	ld bc, $0000 ; $7409
	nop ; $740c
	nop ; $740d
	dec h ; $740e
	ld a, e ; $740f
	nop ; $7410
	dec a ; $7411
	nop ; $7412
	dec a ; $7413
	add a, b ; $7414
	nop ; $7415
	ld c, h ; $7416
	ld bc, $0000 ; $7417
	nop ; $741a
	nop ; $741b
	dec h ; $741c
	ld a, e ; $741d
	nop ; $741e
	dec a ; $741f
	nop ; $7420
	dec a ; $7421
	add a, b ; $7422
	nop ; $7423
	ld c, l ; $7424
	ld bc, $0000 ; $7425
	nop ; $7428
	nop ; $7429
	dec h ; $742a
	ld a, e ; $742b
	nop ; $742c
	rla ; $742d
	nop ; $742e
	dec e ; $742f
	add a, b ; $7430
	nop ; $7431
	add hl, hl ; $7432
	ld bc, $0000 ; $7433
	nop ; $7436
	nop ; $7437
	nop ; $7438
	nop ; $7439
	nop ; $743a
	nop ; $743b
	nop ; $743c
	nop ; $743d
	nop ; $743e
	rst Rst38 ; $743f
	wram_bank $04 ; $7440
	ld a, [wMatchWinLoseFlag] ; $7446
	cp a, $01 ; $7449
	jp z, Func_13_744f ; $744b
	ret ; $744e
Func_13_744f:
	ld hl, $0416 ; $744f
	farcall FarPtr_0a_0e ; $7452
	ldh a, [hRomBank] ; $7455
	ld hl, $78d7 ; $7457
	farcall FarPtr_0a_06 ; $745a
	farcall FarPtr_0a_00 ; $745d
	call Func_13_62be ; $7460
	ld a, $02 ; $7463
	farcall FarPtr_0a_1c ; $7465
	ld a, $01 ; $7468
	farcall FarPtr_0a_1c ; $746a
	ld bc, $0040 ; $746d
	farcall FarPtr_0a_38 ; $7470
	ld a, $00 ; $7473
	ld bc, $0b00 ; $7475
	ld de, $1d00 ; $7478
	farcall FarPtr_ScriptSetActorPosition ; $747b
	ld a, $02 ; $747e
	ld bc, $0d00 ; $7480
	ld de, $2300 ; $7483
	farcall FarPtr_ScriptSetActorPosition ; $7486
	ld a, $00 ; $7489
	ld b, $c0 ; $748b
	farcall FarPtr_SetActorFacing ; $748d
	ld a, $02 ; $7490
	ld b, $c0 ; $7492
	farcall FarPtr_SetActorFacing ; $7494
	xor a, a ; $7497
	ld bc, $0b00 ; $7498
	ld de, $1100 ; $749b
	farcall FarPtr_MovePlayerToPosition ; $749e
	farcall FarPtr_WaitPlayerMoveDone ; $74a1
	ld c, $04 ; $74a4
	call BeginFadeIn ; $74a6
	call WaitFadeEnd ; $74a9
	push af ; $74ac
	ld a, $3c ; $74ad
	farcall FarPtr_WaitScriptFrames ; $74af
	pop af ; $74b2
	ld bc, $0020 ; $74b3
	farcall FarPtr_0a_38 ; $74b6
	xor a, a ; $74b9
	ld bc, $0b00 ; $74ba
	ld de, $1700 ; $74bd
	farcall FarPtr_MovePlayerToPosition ; $74c0
	farcall FarPtr_WaitPlayerMoveDone ; $74c3
	ld a, $02 ; $74c6
	ld bc, $0d00 ; $74c8
	ld de, $1d00 ; $74cb
	farcall FarPtr_ScriptSetActorMoveTarget ; $74ce
	ld a, $09 ; $74d1
	ld bc, $0b00 ; $74d3
	ld de, $1700 ; $74d6
	farcall FarPtr_ScriptSetActorMoveTarget ; $74d9
	ld a, $09 ; $74dc
	farcall FarPtr_ScriptWaitActorMoveDone ; $74de
	ld a, $09 ; $74e1
	ld d, $04 ; $74e3
	farcall FarPtr_ScriptSetActorAnimation ; $74e5
	ld a, $09 ; $74e8
	farcall FarPtr_ScriptWaitActorIdle ; $74ea
	ld a, $09 ; $74ed
	farcall FarPtr_0a_08 ; $74ef
	ld a, $04 ; $74f2
	ld d, $02 ; $74f4
	farcall FarPtr_ScriptSetActorAnimation ; $74f6
	ld a, $04 ; $74f9
	farcall FarPtr_ScriptWaitActorIdle ; $74fb
	ld a, $04 ; $74fe
	farcall FarPtr_0a_08 ; $7500
	ld a, $02 ; $7503
	ld d, $03 ; $7505
	farcall FarPtr_ScriptSetActorAnimation ; $7507
	ld a, $00 ; $750a
	ld d, $03 ; $750c
	farcall FarPtr_ScriptSetActorAnimation ; $750e
	ld a, $00 ; $7511
	farcall FarPtr_ScriptWaitActorIdle ; $7513
	ld a, $00 ; $7516
	ld b, a ; $7518
	ld a, $02 ; $7519
	farcall FarPtr_FaceActorTowardActor ; $751b
	push af ; $751e
	ld a, $1e ; $751f
	farcall FarPtr_WaitScriptFrames ; $7521
	pop af ; $7524
	ld a, $02 ; $7525
	ld d, $03 ; $7527
	farcall FarPtr_ScriptSetActorAnimation ; $7529
	ld a, $02 ; $752c
	farcall FarPtr_ScriptWaitActorIdle ; $752e
	test_flag $1c, 0 ; $7531
	jp z, Label_13_7672 ; $7534
	ld hl, $041a ; $7537
	farcall FarPtr_0a_0e ; $753a
	ld a, $02 ; $753d
	farcall FarPtr_0a_08 ; $753f
	ld a, $02 ; $7542
	ld b, a ; $7544
	ld a, $00 ; $7545
	farcall FarPtr_FaceActorTowardActor ; $7547
	ld a, $02 ; $754a
	ld d, $02 ; $754c
	farcall FarPtr_ScriptSetActorAnimation ; $754e
	ld a, $02 ; $7551
	farcall FarPtr_ScriptWaitActorIdle ; $7553
	ld a, $02 ; $7556
	farcall FarPtr_0a_08 ; $7558
	ld a, $00 ; $755b
	ld b, $80 ; $755d
	farcall FarPtr_SetActorFacing ; $755f
	ld a, $00 ; $7562
	ld d, $02 ; $7564
	farcall FarPtr_ScriptSetActorAnimation ; $7566
	ld a, $0a ; $7569
	ld bc, $0c00 ; $756b
	ld de, $1b80 ; $756e
	farcall FarPtr_ScriptSetActorPosition ; $7571
	sound $96 ; $7574
	push af ; $7576
	ld a, $28 ; $7577
	farcall FarPtr_WaitScriptFrames ; $7579
	pop af ; $757c
	ld a, $0a ; $757d
	ld bc, $3f00 ; $757f
	ld de, $3f00 ; $7582
	farcall FarPtr_ScriptSetActorPosition ; $7585
	ld a, $02 ; $7588
	ld b, a ; $758a
	ld a, $00 ; $758b
	farcall FarPtr_FaceActorTowardActor ; $758d
	push af ; $7590
	ld a, $0a ; $7591
	farcall FarPtr_WaitScriptFrames ; $7593
	pop af ; $7596
	ld a, $00 ; $7597
	ld b, $01 ; $7599
	farcall FarPtr_0a_2c ; $759b
	push af ; $759e
	ld a, $0a ; $759f
	farcall FarPtr_WaitScriptFrames ; $75a1
	pop af ; $75a4
	ld a, $00 ; $75a5
	ld b, $00 ; $75a7
	ld de, $0100 ; $75a9
	farcall FarPtr_MoveActorByAngle ; $75ac
	ld a, $00 ; $75af
	farcall FarPtr_ScriptWaitActorMoveDone ; $75b1
	ld a, $00 ; $75b4
	ld d, $02 ; $75b6
	farcall FarPtr_ScriptSetActorAnimation ; $75b8
	ld a, $00 ; $75bb
	farcall FarPtr_ScriptWaitActorIdle ; $75bd
	ld a, $00 ; $75c0
	ld b, $80 ; $75c2
	ld de, $0100 ; $75c4
	farcall FarPtr_MoveActorByAngle ; $75c7
	ld a, $00 ; $75ca
	farcall FarPtr_ScriptWaitActorMoveDone ; $75cc
	ld a, $02 ; $75cf
	farcall FarPtr_GetActorStateAddr ; $75d1
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	ld [hl], $04 ; $75d8
	ld a, $02 ; $75da
	ld d, $02 ; $75dc
	farcall FarPtr_ScriptSetActorAnimation ; $75de
	ld a, $02 ; $75e1
	farcall FarPtr_ScriptWaitActorIdle ; $75e3
	ld a, $02 ; $75e6
	ld b, $c0 ; $75e8
	farcall FarPtr_SetActorFacing ; $75ea
	ld a, $02 ; $75ed
	ld d, $02 ; $75ef
	farcall FarPtr_ScriptSetActorAnimation ; $75f1
	ld a, $02 ; $75f4
	farcall FarPtr_ScriptWaitActorIdle ; $75f6
	ld a, $02 ; $75f9
	ld d, $02 ; $75fb
	farcall FarPtr_ScriptSetActorAnimation ; $75fd
	ld a, $02 ; $7600
	farcall FarPtr_ScriptWaitActorIdle ; $7602
	ld a, $02 ; $7605
	ld b, $40 ; $7607
	farcall FarPtr_SetActorFacing ; $7609
	ld a, $02 ; $760c
	ld d, $02 ; $760e
	farcall FarPtr_ScriptSetActorAnimation ; $7610
	ld a, $02 ; $7613
	farcall FarPtr_ScriptWaitActorIdle ; $7615
	ld a, $02 ; $7618
	ld b, $c0 ; $761a
	farcall FarPtr_SetActorFacing ; $761c
	ld a, $02 ; $761f
	ld d, $02 ; $7621
	farcall FarPtr_ScriptSetActorAnimation ; $7623
	ld a, $02 ; $7626
	farcall FarPtr_ScriptWaitActorIdle ; $7628
	ld a, $02 ; $762b
	ld d, $02 ; $762d
	farcall FarPtr_ScriptSetActorAnimation ; $762f
	ld a, $02 ; $7632
	farcall FarPtr_ScriptWaitActorIdle ; $7634
	ld a, $02 ; $7637
	farcall FarPtr_GetActorStateAddr ; $7639
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	ld a, $02 ; $7642
	ld b, $80 ; $7644
	farcall FarPtr_SetActorFacing ; $7646
	push af ; $7649
	ld a, $14 ; $764a
	farcall FarPtr_WaitScriptFrames ; $764c
	pop af ; $764f
	ld a, $02 ; $7650
	ld d, $03 ; $7652
	farcall FarPtr_ScriptSetActorAnimation ; $7654
	ld a, $02 ; $7657
	farcall FarPtr_ScriptWaitActorIdle ; $7659
	push af ; $765c
	ld a, $14 ; $765d
	farcall FarPtr_WaitScriptFrames ; $765f
	pop af ; $7662
	ld a, $00 ; $7663
	ld d, $03 ; $7665
	farcall FarPtr_ScriptSetActorAnimation ; $7667
	ld a, $00 ; $766a
	farcall FarPtr_ScriptWaitActorIdle ; $766c
	jp Label_13_7769 ; $766f
Label_13_7672:
	ld hl, $0418 ; $7672
	farcall FarPtr_0a_0e ; $7675
	ld a, $02 ; $7678
	farcall FarPtr_0a_08 ; $767a
	ld a, $02 ; $767d
	ld d, $02 ; $767f
	farcall FarPtr_ScriptSetActorAnimation ; $7681
	ld a, $02 ; $7684
	farcall FarPtr_ScriptWaitActorIdle ; $7686
	ld a, $02 ; $7689
	farcall FarPtr_0a_08 ; $768b
	ld a, $02 ; $768e
	ld b, a ; $7690
	ld a, $00 ; $7691
	farcall FarPtr_FaceActorTowardActor ; $7693
	ld a, $0a ; $7696
	ld bc, $0c00 ; $7698
	ld de, $1b80 ; $769b
	farcall FarPtr_ScriptSetActorPosition ; $769e
	sound $96 ; $76a1
	push af ; $76a3
	ld a, $28 ; $76a4
	farcall FarPtr_WaitScriptFrames ; $76a6
	pop af ; $76a9
	ld a, $0a ; $76aa
	ld bc, $3f00 ; $76ac
	ld de, $3f00 ; $76af
	farcall FarPtr_ScriptSetActorPosition ; $76b2
	push af ; $76b5
	ld a, $0a ; $76b6
	farcall FarPtr_WaitScriptFrames ; $76b8
	pop af ; $76bb
	ld a, $00 ; $76bc
	ld b, $01 ; $76be
	farcall FarPtr_0a_2c ; $76c0
	push af ; $76c3
	ld a, $0a ; $76c4
	farcall FarPtr_WaitScriptFrames ; $76c6
	pop af ; $76c9
	ld a, $00 ; $76ca
	ld b, $00 ; $76cc
	ld de, $0100 ; $76ce
	farcall FarPtr_MoveActorByAngle ; $76d1
	ld a, $00 ; $76d4
	farcall FarPtr_ScriptWaitActorMoveDone ; $76d6
	ld a, $00 ; $76d9
	ld d, $02 ; $76db
	farcall FarPtr_ScriptSetActorAnimation ; $76dd
	ld a, $00 ; $76e0
	farcall FarPtr_ScriptWaitActorIdle ; $76e2
	ld a, $00 ; $76e5
	ld b, $80 ; $76e7
	ld de, $0100 ; $76e9
	farcall FarPtr_MoveActorByAngle ; $76ec
	ld a, $00 ; $76ef
	farcall FarPtr_ScriptWaitActorMoveDone ; $76f1
	ld a, $02 ; $76f4
	farcall FarPtr_GetActorStateAddr ; $76f6
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	ld [hl], $03 ; $76fd
	ld a, $02 ; $76ff
	ld d, $02 ; $7701
	farcall FarPtr_ScriptSetActorAnimation ; $7703
	ld a, $02 ; $7706
	farcall FarPtr_ScriptWaitActorIdle ; $7708
	ld a, $02 ; $770b
	ld b, $40 ; $770d
	farcall FarPtr_SetActorFacing ; $770f
	ld a, $02 ; $7712
	ld d, $02 ; $7714
	farcall FarPtr_ScriptSetActorAnimation ; $7716
	ld a, $02 ; $7719
	farcall FarPtr_ScriptWaitActorIdle ; $771b
	push af ; $771e
	ld a, $28 ; $771f
	farcall FarPtr_WaitScriptFrames ; $7721
	pop af ; $7724
	ld a, $02 ; $7725
	ld d, $02 ; $7727
	farcall FarPtr_ScriptSetActorAnimation ; $7729
	ld a, $02 ; $772c
	farcall FarPtr_ScriptWaitActorIdle ; $772e
	ld a, $02 ; $7731
	farcall FarPtr_GetActorStateAddr ; $7733
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	ld a, $02 ; $773c
	ld b, $80 ; $773e
	farcall FarPtr_SetActorFacing ; $7740
	push af ; $7743
	ld a, $14 ; $7744
	farcall FarPtr_WaitScriptFrames ; $7746
	pop af ; $7749
	ld a, $02 ; $774a
	ld d, $03 ; $774c
	farcall FarPtr_ScriptSetActorAnimation ; $774e
	ld a, $02 ; $7751
	farcall FarPtr_ScriptWaitActorIdle ; $7753
	push af ; $7756
	ld a, $14 ; $7757
	farcall FarPtr_WaitScriptFrames ; $7759
	pop af ; $775c
	ld a, $00 ; $775d
	ld d, $03 ; $775f
	farcall FarPtr_ScriptSetActorAnimation ; $7761
	ld a, $00 ; $7764
	farcall FarPtr_ScriptWaitActorIdle ; $7766
Label_13_7769:
	ld hl, $041c ; $7769
	farcall FarPtr_0a_0e ; $776c
	push af ; $776f
	ld a, $14 ; $7770
	farcall FarPtr_WaitScriptFrames ; $7772
	pop af ; $7775
	ld a, $08 ; $7776
	farcall FarPtr_0a_08 ; $7778
	ld a, $00 ; $777b
	ld b, $00 ; $777d
	farcall FarPtr_0a_2c ; $777f
	ld a, $00 ; $7782
	ld b, $00 ; $7784
	farcall FarPtr_SetActorFacing ; $7786
	ld a, $02 ; $7789
	ld b, $00 ; $778b
	farcall FarPtr_SetActorFacing ; $778d
	ldh a, [hRomBank] ; $7790
	ld b, a ; $7792
	ld a, $08 ; $7793
	ld de, $7a43 ; $7795
	farcall FarPtr_0a_1a ; $7798
	ldh a, [hRomBank] ; $779b
	ld b, a ; $779d
	ld a, $03 ; $779e
	ld de, $7a60 ; $77a0
	farcall FarPtr_0a_1a ; $77a3
	push af ; $77a6
	ld a, $14 ; $77a7
	farcall FarPtr_WaitScriptFrames ; $77a9
	pop af ; $77ac
	ldh a, [hRomBank] ; $77ad
	ld b, a ; $77af
	ld a, $09 ; $77b0
	ld de, $7ac9 ; $77b2
	farcall FarPtr_0a_1a ; $77b5
	xor a, a ; $77b8
	ld bc, $0b00 ; $77b9
	ld de, $1d00 ; $77bc
	farcall FarPtr_MovePlayerToPosition ; $77bf
	farcall FarPtr_WaitPlayerMoveDone ; $77c2
	ld a, $09 ; $77c5
	farcall FarPtr_WaitActorScriptDone ; $77c7
	ld a, $00 ; $77ca
	ld b, a ; $77cc
	ld a, $09 ; $77cd
	farcall FarPtr_FaceActorTowardActor ; $77cf
	ld a, $03 ; $77d2
	ld b, a ; $77d4
	ld a, $02 ; $77d5
	farcall FarPtr_FaceActorTowardActor ; $77d7
	ld a, $09 ; $77da
	ld d, $04 ; $77dc
	farcall FarPtr_ScriptSetActorAnimation ; $77de
	ld a, $09 ; $77e1
	farcall FarPtr_ScriptWaitActorIdle ; $77e3
	ld a, $09 ; $77e6
	ld b, a ; $77e8
	ld a, $00 ; $77e9
	farcall FarPtr_FaceActorTowardActor ; $77eb
	ld a, $09 ; $77ee
	farcall FarPtr_0a_08 ; $77f0
	ld a, $08 ; $77f3
	ld bc, $0a00 ; $77f5
	ld de, $1f00 ; $77f8
	farcall FarPtr_ScriptSetActorMoveTarget ; $77fb
	ld a, $08 ; $77fe
	farcall FarPtr_ScriptWaitActorMoveDone ; $7800
	ld a, $08 ; $7803
	ld b, a ; $7805
	ld a, $00 ; $7806
	farcall FarPtr_FaceActorTowardActor ; $7808
	ld a, $03 ; $780b
	ld b, a ; $780d
	ld a, $02 ; $780e
	farcall FarPtr_FaceActorTowardActor ; $7810
	ld a, $08 ; $7813
	ld d, $03 ; $7815
	farcall FarPtr_ScriptSetActorAnimation ; $7817
	ld a, $08 ; $781a
	farcall FarPtr_ScriptWaitActorIdle ; $781c
	ld a, $08 ; $781f
	farcall FarPtr_0a_08 ; $7821
	ld a, $03 ; $7824
	ld bc, $0c00 ; $7826
	ld de, $1f00 ; $7829
	farcall FarPtr_ScriptSetActorMoveTarget ; $782c
	ld a, $03 ; $782f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7831
	ld a, $03 ; $7834
	ld d, $02 ; $7836
	farcall FarPtr_ScriptSetActorAnimation ; $7838
	ld a, $03 ; $783b
	farcall FarPtr_ScriptWaitActorIdle ; $783d
	ld a, $03 ; $7840
	farcall FarPtr_0a_08 ; $7842
	ld a, $00 ; $7845
	ld b, a ; $7847
	ld a, $02 ; $7848
	farcall FarPtr_FaceActorTowardActor ; $784a
	ld a, $02 ; $784d
	ld d, $03 ; $784f
	farcall FarPtr_ScriptSetActorAnimation ; $7851
	ld a, $02 ; $7854
	farcall FarPtr_ScriptWaitActorIdle ; $7856
	test_flag $1c, 0 ; $7859
	jr z, Label_13_7861 ; $785c
	farcall FarPtr_0a_10 ; $785e
Label_13_7861:
	ld a, $02 ; $7861
	farcall FarPtr_0a_08 ; $7863
	ld a, $02 ; $7866
	ld b, a ; $7868
	ld a, $00 ; $7869
	farcall FarPtr_FaceActorTowardActor ; $786b
	ld a, $00 ; $786e
	ld d, $03 ; $7870
	farcall FarPtr_ScriptSetActorAnimation ; $7872
	ld a, $00 ; $7875
	farcall FarPtr_ScriptWaitActorIdle ; $7877
	push af ; $787a
	ld a, $0a ; $787b
	farcall FarPtr_WaitScriptFrames ; $787d
	pop af ; $7880
	ld a, $08 ; $7881
	ld b, a ; $7883
	ld a, $00 ; $7884
	farcall FarPtr_FaceActorTowardActor ; $7886
	ld a, $03 ; $7889
	ld b, a ; $788b
	ld a, $02 ; $788c
	farcall FarPtr_FaceActorTowardActor ; $788e
	push af ; $7891
	ld a, $0a ; $7892
	farcall FarPtr_WaitScriptFrames ; $7894
	pop af ; $7897
	ld a, $00 ; $7898
	ld d, $03 ; $789a
	farcall FarPtr_ScriptSetActorAnimation ; $789c
	ld a, $02 ; $789f
	ld d, $03 ; $78a1
	farcall FarPtr_ScriptSetActorAnimation ; $78a3
	ld c, $02 ; $78a6
	call BeginFadeOut ; $78a8
	call WaitFadeEnd ; $78ab
	call Func_13_78c4 ; $78ae
	ld a, $00 ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [$c295], a ; $78b8
	ld a, $ff ; $78bb
	ld [$c294], a ; $78bd
	ld [$c2a1], a ; $78c0
	ret ; $78c3
Func_13_78c4:
	ld b, $00 ; $78c4
	ld a, [$c90d] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [$c94d] ; $78cd
	xor a, d ; $78d0
	or a, c ; $78d1
	ld c, a ; $78d2
	farcall FarPtr_18_8e ; $78d3
	ret ; $78d6
	nop ; $78d7
	nop ; $78d8
	dec h ; $78d9
	ld a, e ; $78da
	nop ; $78db
	add hl, de ; $78dc
	nop ; $78dd
	dec e ; $78de
	add a, b ; $78df
	nop ; $78e0
	ld c, e ; $78e1
	ld bc, $0000 ; $78e2
	nop ; $78e5
	nop ; $78e6
	dec h ; $78e7
	ld a, e ; $78e8
	nop ; $78e9
	dec c ; $78ea
	nop ; $78eb
	rla ; $78ec
	ld b, b ; $78ed
	nop ; $78ee
	ld l, b ; $78ef
	ld bc, $0007 ; $78f0
	nop ; $78f3
	nop ; $78f4
	dec h ; $78f5
	ld a, e ; $78f6
	nop ; $78f7
	inc de ; $78f8
	nop ; $78f9
	ld hl, $0080 ; $78fa
	ld h, l ; $78fd
	ld bc, $0003 ; $78fe
	nop ; $7901
	nop ; $7902
	dec h ; $7903
	ld a, e ; $7904
	nop ; $7905
	inc de ; $7906
	nop ; $7907
	inc hl ; $7908
	add a, b ; $7909
	nop ; $790a
	ld h, a ; $790b
	ld bc, $0006 ; $790c
	nop ; $790f
	nop ; $7910
	dec h ; $7911
	ld a, e ; $7912
	nop ; $7913
	inc de ; $7914
	nop ; $7915
	rla ; $7916
	add a, b ; $7917
	nop ; $7918
	ld l, e ; $7919
	ld bc, $0006 ; $791a
	nop ; $791d
	nop ; $791e
	dec h ; $791f
	ld a, e ; $7920
	nop ; $7921
	rla ; $7922
	nop ; $7923
	dec e ; $7924
	add a, b ; $7925
	nop ; $7926
	ld c, c ; $7927
	ld bc, $0000 ; $7928
	nop ; $792b
	nop ; $792c
	dec h ; $792d
	ld a, e ; $792e
	nop ; $792f
	dec bc ; $7930
	nop ; $7931
	inc de ; $7932
	ld b, b ; $7933
	nop ; $7934
	ld c, d ; $7935
	ld bc, $0000 ; $7936
	nop ; $7939
	nop ; $793a
	dec h ; $793b
	ld a, e ; $793c
	nop ; $793d
	dec a ; $793e
	nop ; $793f
	dec a ; $7940
	add a, b ; $7941
	nop ; $7942
	ld d, e ; $7943
	ld bc, $0000 ; $7944
	nop ; $7947
	nop ; $7948
	dec h ; $7949
	ld a, e ; $794a
	nop ; $794b
	dec a ; $794c
	nop ; $794d
	dec a ; $794e
	add a, b ; $794f
	nop ; $7950
	ld c, h ; $7951
	ld bc, $0000 ; $7952
	nop ; $7955
	nop ; $7956
	dec h ; $7957
	ld a, e ; $7958
	nop ; $7959
	dec a ; $795a
	nop ; $795b
	dec a ; $795c
	add a, b ; $795d
	nop ; $795e
	ld c, h ; $795f
	ld bc, $0000 ; $7960
	nop ; $7963
	nop ; $7964
	dec h ; $7965
	ld a, e ; $7966
	nop ; $7967
	dec a ; $7968
	nop ; $7969
	dec a ; $796a
	add a, b ; $796b
	nop ; $796c
	ld c, h ; $796d
	ld bc, $0000 ; $796e
	nop ; $7971
	nop ; $7972
	nop ; $7973
	nop ; $7974
	nop ; $7975
	nop ; $7976
	nop ; $7977
	nop ; $7978
	nop ; $7979
	rst Rst38 ; $797a
	set_flag $0a, 3 ; $797b
	set_flag $0a, 7 ; $797e
	set_flag $08, 2 ; $7981
	set_flag $08, 6 ; $7984
	ret ; $7987
Label_13_7988:
	test_flag $05, 7 ; $7988
	jr z, Label_13_7991 ; $798b
	call Func_13_744f ; $798d
	ret ; $7990
Label_13_7991:
	call Func_13_70fb ; $7991
	ret ; $7994
Func_13_7995:
	wram_bank $04 ; $7995
	ld a, [wMatchWinLoseFlag] ; $799b
	cp a, $01 ; $799e
	jp z, Label_13_79a4 ; $79a0
	ret ; $79a3
Label_13_79a4:
	ld a, $07 ; $79a4
	ld [wStoryModeCurrentLocation], a ; $79a6
	ld a, $0e ; $79a9
	ld [$c295], a ; $79ab
	ld a, $ff ; $79ae
	ld [$c294], a ; $79b0
	ld [$c2a1], a ; $79b3
	test_flag $05, 7 ; $79b6
	jr nz, Label_13_79e5 ; $79b9
	ldh a, [hRomBank] ; $79bb
	ld hl, $739c ; $79bd
	farcall FarPtr_0a_06 ; $79c0
	farcall FarPtr_0a_00 ; $79c3
	ld c, $04 ; $79c6
	call BeginFadeIn ; $79c8
	call WaitFadeEnd ; $79cb
	ld bc, $0018 ; $79ce
	farcall FarPtr_0a_38 ; $79d1
	xor a, a ; $79d4
	ld bc, $0900 ; $79d5
	ld de, $1300 ; $79d8
	farcall FarPtr_MovePlayerToPosition ; $79db
	farcall FarPtr_WaitPlayerMoveDone ; $79de
	call Func_13_7ae0 ; $79e1
	ret ; $79e4
Label_13_79e5:
	ldh a, [hRomBank] ; $79e5
	ld hl, $78d7 ; $79e7
	farcall FarPtr_0a_06 ; $79ea
	farcall FarPtr_0a_00 ; $79ed
	call Func_13_62be ; $79f0
	ld a, $02 ; $79f3
	farcall FarPtr_0a_1c ; $79f5
	ld a, $01 ; $79f8
	farcall FarPtr_0a_1c ; $79fa
	ld bc, $0040 ; $79fd
	farcall FarPtr_0a_38 ; $7a00
	ld a, $00 ; $7a03
	ld bc, $0b00 ; $7a05
	ld de, $1d00 ; $7a08
	farcall FarPtr_ScriptSetActorPosition ; $7a0b
	ld a, $02 ; $7a0e
	ld bc, $0d00 ; $7a10
	ld de, $2300 ; $7a13
	farcall FarPtr_ScriptSetActorPosition ; $7a16
	ld a, $00 ; $7a19
	ld b, $c0 ; $7a1b
	farcall FarPtr_SetActorFacing ; $7a1d
	ld a, $02 ; $7a20
	ld b, $c0 ; $7a22
	farcall FarPtr_SetActorFacing ; $7a24
	ld c, $04 ; $7a27
	call BeginFadeIn ; $7a29
	call WaitFadeEnd ; $7a2c
	xor a, a ; $7a2f
	ld bc, $0900 ; $7a30
	ld de, $1300 ; $7a33
	farcall FarPtr_MovePlayerToPosition ; $7a36
	farcall FarPtr_WaitPlayerMoveDone ; $7a39
	call Func_13_7ae0 ; $7a3c
	ret ; $7a3f
	INCBIN "data/bank_013/d_7a40.bin" ; $7a40, 160 bytes
Func_13_7ae0:
	ld c, $08 ; $7ae0
	call BeginFadeOut ; $7ae2
	call WaitFadeEnd ; $7ae5
	xor a, a ; $7ae8
	ldh [hBGColumnBlitPending], a ; $7ae9
	ldh [hBGRowBlitPending], a ; $7aeb
	ldh [hScrollY], a ; $7aed
	ldh [hScrollX], a ; $7aef
	ld [$c321], a ; $7af1
	ld [$c323], a ; $7af4
	call ClearFrameTasks ; $7af7
	test_flag $05, 7 ; $7afa
	jr nz, Label_13_7b10 ; $7afd
	test_flag $07, 4 ; $7aff
	jr nz, Label_13_7b0a ; $7b02
	ld b, $00 ; $7b04
	ld c, $04 ; $7b06
	jr Label_13_7b1b ; $7b08
Label_13_7b0a:
	ld b, $00 ; $7b0a
	ld c, $01 ; $7b0c
	jr Label_13_7b1b ; $7b0e
Label_13_7b10:
	test_flag $06, 5 ; $7b10
	jr nz, Label_13_7b1f ; $7b13
	ld b, $01 ; $7b15
	ld c, $02 ; $7b17
	jr Label_13_7b1b ; $7b19
Label_13_7b1b:
	farcall FarPtr_3b_1c ; $7b1b
	ret ; $7b1e
Label_13_7b1f:
	ld b, $01 ; $7b1f
	ld c, $01 ; $7b21
	jr Label_13_7b1b ; $7b23
	INCBIN "data/bank_013/d_7b25.bin" ; $7b25, 40 bytes
	ret ; $7b4d
	xor a, a ; $7b4e
	ld [$c2da], a ; $7b4f
	ret ; $7b52
	sound $a2 ; $7b53
	ret ; $7b55
	INCBIN "data/bank_013/d_7b56.bin" ; $7b56, 514 bytes
Func_13_7d58:
	ld a, $00 ; $7d58
	test_flag $0a, 3 ; $7d5a
	jr z, Label_13_7d77 ; $7d5d
	inc a ; $7d5f
	test_flag $0a, 7 ; $7d60
	jr z, Label_13_7d77 ; $7d63
	inc a ; $7d65
	test_flag $05, 7 ; $7d66
	jr nz, Label_13_7d7b ; $7d69
	test_flag $15, 6 ; $7d6b
	jr z, Label_13_7d77 ; $7d6e
	inc a ; $7d70
	test_flag $16, 0 ; $7d71
	jr z, Label_13_7d77 ; $7d74
	inc a ; $7d76
Label_13_7d77:
	ld [$c2b0], a ; $7d77
	ret ; $7d7a
Label_13_7d7b:
	test_flag $15, 7 ; $7d7b
	jr z, Label_13_7d77 ; $7d7e
	inc a ; $7d80
	test_flag $16, 1 ; $7d81
	jr z, Label_13_7d77 ; $7d84
	inc a ; $7d86
	jr Label_13_7d77 ; $7d87
	ds 631, $ff ; $7d89, fill
