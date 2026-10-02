ComputePairSpread:
	push hl ; $506e
	ld a, l ; $506f
	sub e ; $5070
	ld l, a ; $5071
	ld a, h ; $5072
	sbc d ; $5073
	ld h, a ; $5074
	bit 7, h ; $5075
	jr z, .checkRange ; $5077
	xor a ; $5079
	sub l ; $507a
	ld l, a ; $507b
	sbc a ; $507c
	sub h ; $507d
	ld h, a ; $507e
.checkRange:
	ld bc, $fe00 ; $507f
	add hl, bc ; $5082
	pop hl ; $5083
	jr nc, .absFirst ; $5084
	ld c, l ; $5086
	ld b, h ; $5087
	ret ; $5088
.absFirst:
	push hl ; $5089
	bit 7, h ; $508a
	jr z, .absSecond ; $508c
	xor a ; $508e
	sub l ; $508f
	ld l, a ; $5090
	sbc a ; $5091
	sub h ; $5092
	ld h, a ; $5093
	xor a ; $5094
	sub e ; $5095
	ld e, a ; $5096
	sbc a ; $5097
	sub d ; $5098
	ld d, a ; $5099
.absSecond:
	push hl ; $509a
	add hl, de ; $509b
	sra h ; $509c
	rr l ; $509e
	ld bc, $ff00 ; $50a0
	add hl, bc ; $50a3
	ld c, l ; $50a4
	ld b, h ; $50a5
	ld hl, $ff00 ; $50a6
	add hl, bc ; $50a9
	bit 7, h ; $50aa
	jr z, .compare ; $50ac
	ld bc, $0100 ; $50ae
.compare:
	pop hl ; $50b1
	ld a, l ; $50b2
	sub e ; $50b3
	ld l, a ; $50b4
	ld a, h ; $50b5
	sbc d ; $50b6
	ld h, a ; $50b7
	jr nc, .useFirst ; $50b8
	ld hl, $0200 ; $50ba
	add hl, bc ; $50bd
	ld e, l ; $50be
	ld d, h ; $50bf
	jr .useSecond ; $50c0
.useFirst:
	ld e, c ; $50c2
	ld d, b ; $50c3
	ld hl, $0200 ; $50c4
	add hl, de ; $50c7
	ld c, l ; $50c8
	ld b, h ; $50c9
.useSecond:
	pop hl ; $50ca
	bit 7, h ; $50cb
	jr z, .done ; $50cd
	xor a ; $50cf
	sub c ; $50d0
	ld c, a ; $50d1
	sbc a ; $50d2
	sub b ; $50d3
	ld b, a ; $50d4
	xor a ; $50d5
	sub e ; $50d6
	ld e, a ; $50d7
	sbc a ; $50d8
	sub d ; $50d9
	ld d, a ; $50da
.done:
	ret ; $50db
BallTrailPalettes:
	; $50dc, 64 bytes (records:8)
; 8 records x 8 bytes
	dw $0180, $031f, $2a94, $0000 ; record 0
	dw $0180, $031f, $01df, $0000 ; record 1
	dw $0180, $031f, $7e00, $0000 ; record 2
	dw $0180, $031f, $589f, $0000 ; record 3
	dw $0180, $031f, $03e0, $0000 ; record 4
	dw $0180, $031f, $4009, $0000 ; record 5
	dw $0180, $031f, $7fe0, $0000 ; record 6
	dw $0180, $031f, $7ffe, $0000 ; record 7
ResetBallState:
	xor a ; $511c
	ld [wBallSpriteEnabled], a ; $511d
	ld [wBallShadowEnabled], a ; $5120
	ld [wBallTrailEnabled], a ; $5123
	ld [wBounceEffectTimer], a ; $5126
	ld hl, $0380 ; $5129
	ld de, $0000 ; $512c
	ld bc, $0000 ; $512f
	call SetBallPosition ; $5132
	xor a ; $5135
	ld hl, wBallVelocityXFrac ; $5136
	ld [hl+], a ; $5139
	ld [hl+], a ; $513a
	ld [hl+], a ; $513b
	ld [hl+], a ; $513c
	ld [hl+], a ; $513d
	ld [hl+], a ; $513e
	ld [hl+], a ; $513f
	ld [hl+], a ; $5140
	ld [hl+], a ; $5141
	ld hl, wBallTopspin ; $5142
	ld [hl+], a ; $5145
	ld [hl+], a ; $5146
	ld [hl+], a ; $5147
	ld [hl+], a ; $5148
	ld hl, wShotAimTargetX ; $5149
	ld [hl+], a ; $514c
	ld [hl+], a ; $514d
	xor a ; $514e
	call SetBallTrailColor ; $514f
	ret ; $5152
UpdateBallVisuals:
	call StepBallPhysics ; $5153
	call BuildBallSlot ; $5156
	call BuildBallTrailSlots ; $5159
	call BuildBallShadowSlot ; $515c
	call BuildNetBallSlot ; $515f
	call DrawBallTouchCharEffect ; $5162
	ld a, [wMatchIsDoubles] ; $5165
	and a ; $5168
	jr nz, .shiftHistory ; $5169
	ldh a, [hDebugStepMode] ; $516b
	and a ; $516d
	jr z, .shiftHistory ; $516e
.shiftHistory:
	ld hl, wBallHistory + 6 ; $5170
	ld de, wBallHistory ; $5173
	ld bc, $001e ; $5176
	call CopyMemoryBC ; $5179
	ld hl, wBounceEffectTimer ; $517c
	call TickTimer ; $517f
	ld hl, wHitSparkTimer ; $5182
	call TickTimer ; $5185
	ret ; $5188
SetBallTrailColor:
	ld [wBallTrailColor], a ; $5189
	add a ; $518c
	add a ; $518d
	add a ; $518e
	ld_hl_indexed BallTrailPalettes ; $518f
	ld_obj_pals de, 0, 1 ; $5196
	call LoadPalettesImmediate ; $5199
	ret ; $519c
BuildBallSlot:
	ld hl, wBallHeight ; $519d
	ld a, [hl+] ; $51a0
	ld b, [hl] ; $51a1
	ld c, a ; $51a2
	ld hl, wBallDepth ; $51a3
	ld a, [hl+] ; $51a6
	ld d, [hl] ; $51a7
	ld e, a ; $51a8
	ld hl, wBallX ; $51a9
	ld a, [hl+] ; $51ac
	ld h, [hl] ; $51ad
	ld l, a ; $51ae
	call ProjectWorldToScreen_08 ; $51af
	push de ; $51b2
	ld e, l ; $51b3
	ld d, h ; $51b4
	ld hl, wBallHistory + 30 ; $51b5
	ld a, e ; $51b8
	ld [hl+], a ; $51b9
	ld [hl], d ; $51ba
	ld hl, wBallHistory + 32 ; $51bb
	ld a, c ; $51be
	ld [hl+], a ; $51bf
	ld [hl], b ; $51c0
	ld l, e ; $51c1
	ld h, d ; $51c2
	call ApplyCameraProjection ; $51c3
	pop hl ; $51c6
	bit 7, h ; $51c7
	jr nz, .midHeight ; $51c9
	ld a, $42 ; $51cb
	ld bc, $fe60 ; $51cd
	add hl, bc ; $51d0
	jr nc, .fillSlot ; $51d1
	ld a, $44 ; $51d3
	jr .fillSlot ; $51d5
.midHeight:
	ld a, $42 ; $51d7
	ld bc, $01a0 ; $51d9
	add hl, bc ; $51dc
	jr c, .fillSlot ; $51dd
	ld a, $40 ; $51df
.fillSlot:
	ld c, a ; $51e1
	ld b, $08 ; $51e2
	ld a, [wBallSpriteEnabled] ; $51e4
	and a ; $51e7
	jr z, .done ; $51e8
	ld hl, wBallSlot ; $51ea
	ld a, c ; $51ed
	ld [hl+], a ; $51ee
	ld a, b ; $51ef
	ld [hl+], a ; $51f0
	ld a, e ; $51f1
	ld [hl+], a ; $51f2
	ld [hl], d ; $51f3
.done:
	ld hl, wBallHistory + 34 ; $51f4
	ld a, c ; $51f7
	add $08 ; $51f8
	ld [hl+], a ; $51fa
	ld [hl], b ; $51fb
	ret ; $51fc
BuildBallTrailSlots:
	ld a, [wBallTrailEnabled] ; $51fd
	and a ; $5200
	jr z, .done ; $5201
	ld hl, wBallHistory + 24 ; $5203
	ld de, wBallTrailSlots ; $5206
	call BuildTrailSlot ; $5209
	ld hl, wBallHistory + 18 ; $520c
	ld de, wBallTrailSlots + 4 ; $520f
	call BuildTrailSlot ; $5212
	ld a, [wBallTrailColor] ; $5215
	and a ; $5218
	jr z, .done ; $5219
	ld hl, wBallHistory + 12 ; $521b
	ld de, wBallTrailSlots + 8 ; $521e
	call BuildTrailSlot ; $5221
	ld hl, wBallHistory + 6 ; $5224
	ld de, wBallTrailSlots + 12 ; $5227
	call BuildTrailSlot ; $522a
	ld hl, wBallHistory ; $522d
	ld de, wBallTrailSlots + 16 ; $5230
	call BuildTrailSlot ; $5233
.done:
	ret ; $5236
BuildTrailSlot:
	push de ; $5237
	ld a, [hl+] ; $5238
	ld e, a ; $5239
	ld a, [hl+] ; $523a
	ld d, a ; $523b
	ld a, [hl+] ; $523c
	ld c, a ; $523d
	ld a, [hl+] ; $523e
	ld b, a ; $523f
	push hl ; $5240
	ld l, e ; $5241
	ld h, d ; $5242
	call ApplyCameraProjection ; $5243
	pop hl ; $5246
	ld a, [hl+] ; $5247
	ld b, [hl] ; $5248
	ld c, a ; $5249
	pop hl ; $524a
	ld a, c ; $524b
	ld [hl+], a ; $524c
	ld a, b ; $524d
	ld [hl+], a ; $524e
	ld a, e ; $524f
	ld [hl+], a ; $5250
	ld [hl], d ; $5251
	ret ; $5252
BuildBallShadowSlot:
	ld bc, $0000 ; $5253
	ld hl, wBallDepth ; $5256
	ld a, [hl+] ; $5259
	ld d, [hl] ; $525a
	ld e, a ; $525b
	ld hl, wBallX ; $525c
	ld a, [hl+] ; $525f
	ld h, [hl] ; $5260
	ld l, a ; $5261
	call ProjectWorldToScreen_08 ; $5262
	ld e, l ; $5265
	ld d, h ; $5266
	ld hl, wBallGroundProjX ; $5267
	ld a, e ; $526a
	ld [hl+], a ; $526b
	ld [hl], d ; $526c
	ld hl, wBallGroundProjY ; $526d
	ld a, c ; $5270
	ld [hl+], a ; $5271
	ld [hl], b ; $5272
	ld l, e ; $5273
	ld h, d ; $5274
	ld a, [wBallShadowEnabled] ; $5275
	and a ; $5278
	jr z, .done ; $5279
	call ApplyCameraProjection ; $527b
	ld bc, $0846 ; $527e
	ld hl, wBallShadowSlot ; $5281
	ld a, c ; $5284
	ld [hl+], a ; $5285
	ld a, b ; $5286
	ld [hl+], a ; $5287
	ld a, e ; $5288
	ld [hl+], a ; $5289
	ld [hl], d ; $528a
.done:
	ret ; $528b
BuildNetBallSlot:
	ld a, [wPointOutcome] ; $528c
	and a ; $528f
	ret z ; $5290
	ld hl, wBallDepth ; $5291
	ld a, [hl+] ; $5294
	ld h, [hl] ; $5295
	ld l, a ; $5296
	bit 7, h ; $5297
	ret z ; $5299
	ld de, $01e0 ; $529a
	add hl, de ; $529d
	bit 7, h ; $529e
	ret nz ; $52a0
	ld hl, wBallX ; $52a1
	ld a, [hl+] ; $52a4
	ld h, [hl] ; $52a5
	ld l, a ; $52a6
	bit 7, h ; $52a7
	jr z, .checkRange ; $52a9
	xor a ; $52ab
	sub l ; $52ac
	ld l, a ; $52ad
	sbc a ; $52ae
	sub h ; $52af
	ld h, a ; $52b0
.checkRange:
	ld de, $fdc0 ; $52b1
	add hl, de ; $52b4
	ret c ; $52b5
	ld hl, wBallHistory + 30 ; $52b6
	ld a, [hl+] ; $52b9
	ld h, [hl] ; $52ba
	ld l, a ; $52bb
	ld bc, $fe80 ; $52bc
	call ApplyCameraProjection ; $52bf
	ld a, d ; $52c2
	and $fe ; $52c3
	ld d, a ; $52c5
	ldh a, [hScrollX] ; $52c6
	and $01 ; $52c8
	or d ; $52ca
	ld d, a ; $52cb
	ld bc, $0b4e ; $52cc
	ld hl, wNetBallSlot ; $52cf
	ld a, c ; $52d2
	ld [hl+], a ; $52d3
	ld a, b ; $52d4
	ld [hl+], a ; $52d5
	ld a, e ; $52d6
	ld [hl+], a ; $52d7
	ld [hl], d ; $52d8
	ret ; $52d9
StartLandingMarker:
	ld a, [wCurrentShotType] ; $52da
	cp SHOTTYPE_LOB ; $52dd
	jr z, .place ; $52df
	ld a, [wFallbackTrajectoryFlag] ; $52e1
	and a ; $52e4
	jr nz, .place ; $52e5
	ret ; $52e7
.place:
	ld hl, $fec0 ; $52e8
	call OffsetFromBallLanding ; $52eb
	push hl ; $52ee
	ld l, e ; $52ef
	ld h, d ; $52f0
	bit 7, h ; $52f1
	jr z, .checkX ; $52f3
	xor a ; $52f5
	sub l ; $52f6
	ld l, a ; $52f7
	sbc a ; $52f8
	sub h ; $52f9
	ld h, a ; $52fa
.checkX:
	ld bc, $ff80 ; $52fb
	add hl, bc ; $52fe
	bit 7, h ; $52ff
	pop hl ; $5301
	ret nz ; $5302
	push hl ; $5303
	ld l, e ; $5304
	ld h, d ; $5305
	bit 7, h ; $5306
	jr z, .checkDepth ; $5308
	xor a ; $530a
	sub l ; $530b
	ld l, a ; $530c
	sbc a ; $530d
	sub h ; $530e
	ld h, a ; $530f
.checkDepth:
	ld bc, $ff00 ; $5310
	add hl, bc ; $5313
	bit 7, h ; $5314
	pop hl ; $5316
	jr z, .done ; $5317
	ld a, [wBallTargetDepth + 1] ; $5319
	bit 7, a ; $531c
	ld de, $0100 ; $531e
	jr z, .done ; $5321
	ld de, rJOYP ; $5323
.done:
	ld bc, $0000 ; $5326
	call ProjectWorldToScreen_08 ; $5329
	ld e, l ; $532c
	ld d, h ; $532d
	ld hl, wLandingMarkerX ; $532e
	ld a, e ; $5331
	ld [hl+], a ; $5332
	ld [hl], d ; $5333
	ld hl, wLandingMarkerY ; $5334
	ld a, c ; $5337
	ld [hl+], a ; $5338
	ld [hl], b ; $5339
	ld a, $01 ; $533a
	ld [wLandingMarkerActive], a ; $533c
	sound SFX_LANDING_MARKER ; $533f
	ret ; $5341
DrawLandingMarker:
	ld a, [wLandingMarkerActive] ; $5342
	and a ; $5345
	ret z ; $5346
	ld hl, wLandingMarkerY ; $5347
	ld a, [hl+] ; $534a
	ld b, [hl] ; $534b
	ld c, a ; $534c
	ld hl, wLandingMarkerX ; $534d
	ld a, [hl+] ; $5350
	ld h, [hl] ; $5351
	ld l, a ; $5352
	call ApplyCameraProjection ; $5353
	ld a, e ; $5356
	add $08 ; $5357
	ld e, a ; $5359
	ld bc, $097c ; $535a
	call QueueSprite16 ; $535d
	ldh a, [hMatchFrameCounter] ; $5360
	and $0f ; $5362
	ld_hl_indexed DrawLandingMarkerTable ; $5364
	ld a, [hl] ; $536b
	cp $ff ; $536c
	ret z ; $536e
	farcall LoadBallTouchCharEffectTilesB ; $536f
	ret ; $5372
DrawLandingMarkerTable:
	; $5373, 16 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x08
