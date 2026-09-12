ObjectIdList_04:
	; $4f75, 236 bytes (bytes:2)
	db $00, $40 ; 0x00
	db $00, $41 ; 0x02
	db $00, $42 ; 0x04
	db $00, $43 ; 0x06
	db $00, $44 ; 0x08
	db $00, $45 ; 0x0a
	db $00, $46 ; 0x0c
	db $00, $47 ; 0x0e
	db $00, $48 ; 0x10
	db $00, $49 ; 0x12
	db $00, $4a ; 0x14
	db $00, $4b ; 0x16
	db $00, $4c ; 0x18
	db $00, $4d ; 0x1a
	db $00, $4e ; 0x1c
	db $00, $4f ; 0x1e
	db $00, $50 ; 0x20
	db $00, $51 ; 0x22
	db $00, $52 ; 0x24
	db $00, $53 ; 0x26
	db $00, $54 ; 0x28
	db $00, $55 ; 0x2a
	db $00, $56 ; 0x2c
	db $00, $57 ; 0x2e
	db $00, $58 ; 0x30
	db $00, $59 ; 0x32
	db $00, $5a ; 0x34
	db $00, $5b ; 0x36
	db $00, $5c ; 0x38
	db $00, $5d ; 0x3a
	db $00, $6f ; 0x3c
	db $02, $6f ; 0x3e
	db $04, $6f ; 0x40
	db $06, $6f ; 0x42
	db $08, $6f ; 0x44
	db $0a, $6f ; 0x46
	db $0c, $6f ; 0x48
	db $0e, $6f ; 0x4a
	db $00, $70 ; 0x4c
	db $02, $70 ; 0x4e
	db $04, $70 ; 0x50
	db $06, $70 ; 0x52
	db $08, $70 ; 0x54
	db $0a, $70 ; 0x56
	db $0c, $70 ; 0x58
	db $00, $71 ; 0x5a
	db $02, $71 ; 0x5c
	db $04, $71 ; 0x5e
	db $06, $71 ; 0x60
	db $08, $71 ; 0x62
	db $0a, $71 ; 0x64
	db $0c, $71 ; 0x66
	db $0e, $71 ; 0x68
	db $10, $71 ; 0x6a
	db $12, $71 ; 0x6c
	db $00, $72 ; 0x6e
	db $02, $72 ; 0x70
	db $04, $72 ; 0x72
	db $06, $72 ; 0x74
	db $08, $72 ; 0x76
	db $0a, $72 ; 0x78
	db $0c, $72 ; 0x7a
	db $0e, $72 ; 0x7c
	db $10, $72 ; 0x7e
	db $00, $73 ; 0x80
	db $02, $73 ; 0x82
	db $04, $73 ; 0x84
	db $06, $73 ; 0x86
	db $08, $73 ; 0x88
	db $0a, $73 ; 0x8a
	db $0c, $73 ; 0x8c
	db $0e, $73 ; 0x8e
	db $10, $73 ; 0x90
	db $12, $73 ; 0x92
	db $14, $73 ; 0x94
	db $16, $73 ; 0x96
	db $18, $73 ; 0x98
	db $1a, $73 ; 0x9a
	db $1c, $73 ; 0x9c
	db $1e, $73 ; 0x9e
	db $20, $73 ; 0xa0
	db $22, $73 ; 0xa2
	db $24, $73 ; 0xa4
	db $26, $73 ; 0xa6
	db $00, $74 ; 0xa8
	db $02, $74 ; 0xaa
	db $04, $74 ; 0xac
	db $06, $74 ; 0xae
	db $08, $74 ; 0xb0
	db $0a, $74 ; 0xb2
	db $0c, $74 ; 0xb4
	db $0e, $74 ; 0xb6
	db $10, $74 ; 0xb8
	db $00, $75 ; 0xba
	db $02, $75 ; 0xbc
	db $04, $75 ; 0xbe
	db $06, $75 ; 0xc0
	db $08, $75 ; 0xc2
	db $0a, $75 ; 0xc4
	db $0c, $75 ; 0xc6
	db $0e, $75 ; 0xc8
	db $10, $75 ; 0xca
	db $00, $76 ; 0xcc
	db $02, $76 ; 0xce
	db $04, $76 ; 0xd0
	db $06, $76 ; 0xd2
	db $08, $76 ; 0xd4
	db $0a, $76 ; 0xd6
	db $0c, $76 ; 0xd8
	db $00, $77 ; 0xda
	db $02, $77 ; 0xdc
	db $04, $77 ; 0xde
	db $06, $77 ; 0xe0
	db $08, $77 ; 0xe2
	db $0a, $77 ; 0xe4
	db $0c, $77 ; 0xe6
	db $0e, $77 ; 0xe8
	db $00, $00 ; 0xea
SetActorMoveTarget:
	push hl ; $5061
	ld hl, $000a ; $5062
	add hl, bc ; $5065
	ld a, e ; $5066
	ld [hl+], a ; $5067
	ld [hl], d ; $5068
	pop de ; $5069
	ld hl, $0008 ; $506a
	add hl, bc ; $506d
	ld a, e ; $506e
	ld [hl+], a ; $506f
	ld [hl], d ; $5070
	ret ; $5071
ActorMoveVectors_04:
	; $5072, 96 bytes (records:4)
; 24 records x 4 bytes
	dw $0120, $0000 ; record 0
	dw $00cb, $00cb ; record 1
	dw $0000, $0120 ; record 2
	dw $ff35, $00cb ; record 3
	dw $fee0, $0000 ; record 4
	dw $ff35, $ff35 ; record 5
	dw $0000, $fee0 ; record 6
	dw $00cb, $ff35 ; record 7
	dw $0140, $0000 ; record 8
	dw $00e2, $00e2 ; record 9
	dw $0000, $0140 ; record 10
	dw $ff1e, $00e2 ; record 11
	dw $fec0, $0000 ; record 12
	dw $ff1e, $ff1e ; record 13
	dw $0000, $fec0 ; record 14
	dw $00e2, $ff1e ; record 15
	dw $0110, $0000 ; record 16
	dw $00c0, $00c0 ; record 17
	dw $0000, $0110 ; record 18
	dw $ff40, $00c0 ; record 19
	dw $fef0, $0000 ; record 20
	dw $ff40, $ff40 ; record 21
	dw $0000, $fef0 ; record 22
	dw $00c0, $ff40 ; record 23
GetPointAheadOfActorFixed:
	rrca ; $50d2
	rrca ; $50d3
	rrca ; $50d4
	and $1c ; $50d5
	ld d, a ; $50d7
	ld a, $40 ; $50d8
	jr IndexPlayerControlTable ; $50da
GetPointAheadOfActorRanged:
	rrca ; $50dc
	rrca ; $50dd
	rrca ; $50de
	and $1c ; $50df
	ld d, a ; $50e1
	ld a, [wActorProbeRange] ; $50e2
	add a ; $50e5
	add a ; $50e6
	add a ; $50e7
	add a ; $50e8
	add a ; $50e9
IndexPlayerControlTable:
	add d ; $50ea
	ld_hl_indexed ActorMoveVectors_04 ; $50eb
	ld a, [hl+] ; $50f2
	ld e, a ; $50f3
	ld a, [hl+] ; $50f4
	ld d, a ; $50f5
	push de ; $50f6
	ld a, [hl+] ; $50f7
	ld e, a ; $50f8
	ld a, [hl+] ; $50f9
	ld d, a ; $50fa
	ld hl, $000e ; $50fb
	add hl, bc ; $50fe
	ld a, [hl+] ; $50ff
	ld h, [hl] ; $5100
	ld l, a ; $5101
	add hl, de ; $5102
	ld e, l ; $5103
	ld d, h ; $5104
	pop hl ; $5105
	push de ; $5106
	ld e, l ; $5107
	ld d, h ; $5108
	ld hl, $000c ; $5109
	add hl, bc ; $510c
	ld a, [hl+] ; $510d
	ld h, [hl] ; $510e
	ld l, a ; $510f
	add hl, de ; $5110
	pop de ; $5111
	ret ; $5112
ProjectPointFromActor:
	call VectorFromLengthAndAngle ; $5113
	push hl ; $5116
	ld hl, $000e ; $5117
	add hl, bc ; $511a
	ld a, [hl+] ; $511b
	ld h, [hl] ; $511c
	ld l, a ; $511d
	add hl, de ; $511e
	ld e, l ; $511f
	ld d, h ; $5120
	pop hl ; $5121
	push de ; $5122
	ld e, l ; $5123
	ld d, h ; $5124
	ld hl, $000c ; $5125
	add hl, bc ; $5128
	ld a, [hl+] ; $5129
	ld h, [hl] ; $512a
	ld l, a ; $512b
	add hl, de ; $512c
	pop de ; $512d
	ret ; $512e
OffsetPointByPolarVector:
	push de ; $512f
	push hl ; $5130
	ld l, c ; $5131
	ld h, b ; $5132
	call VectorFromLengthAndAngle ; $5133
	pop bc ; $5136
	add hl, bc ; $5137
	ld c, l ; $5138
	ld b, h ; $5139
	pop hl ; $513a
	add hl, de ; $513b
	ld e, l ; $513c
	ld d, h ; $513d
	ld l, c ; $513e
	ld h, b ; $513f
	ret ; $5140
CheckTileTriggerAtPoint:
	push af ; $5141
	push de ; $5142
	ld e, d ; $5143
	ld d, h ; $5144
	farcall ReadBehaviorMapCell ; $5145
	ld d, a ; $5148
	and $0f ; $5149
	cp $01 ; $514b
	jr z, .scriptTrigger ; $514d
	cp $03 ; $514f
	jr z, .exitTrigger ; $5151
	xor a ; $5153
	jr .done ; $5154
.scriptTrigger:
	ld a, d ; $5156
	swap a ; $5157
	and $0f ; $5159
	ld [wStoryModeTriggerScript], a ; $515b
	jr .done ; $515e
.exitTrigger:
	ld a, d ; $5160
	swap a ; $5161
	and $0f ; $5163
	ld [wStoryModeExitTriggerRequest], a ; $5165
.done:
	pop de ; $5168
	pop af ; $5169
	ret ; $516a
UpdatePlayerControl:
	wram_bank WRAM_ACTORS ; $516b
	call BuildNearbyActorList ; $5171
	ld hl, hActorPtr ; $5174
	ld a, [hl+] ; $5177
	ld b, [hl] ; $5178
	ld c, a ; $5179
	ldh a, [hInputRisingEdge] ; $517a
	bit PADB_A, a ; $517c
	jr z, .checkStart ; $517e
	ld hl, wStoryModeInteractRequest ; $5180
	ld [hl], $01 ; $5183
	ld hl, $000f ; $5185
	add hl, bc ; $5188
	ld d, [hl] ; $5189
	ld hl, $000d ; $518a
	add hl, bc ; $518d
	ld h, [hl] ; $518e
	call CheckTileTriggerAtPoint ; $518f
.checkStart:
	ldh a, [hInputRisingEdge] ; $5192
	bit PADB_START, a ; $5194
	jr z, .checkRun ; $5196
	ld hl, wStoryModeMenuRequest ; $5198
	ld [hl], $01 ; $519b
.checkRun:
	ldh a, [hPlayerInputFlags] ; $519d
	bit PADB_B, a ; $519f
	jr z, .setAnimSpeed ; $51a1
	set_flag FLAG_PLAYER_RUNNING ; $51a3
.setAnimSpeed:
	ld d, $01 ; $51a6
	ldh a, [hPlayerInputFlags] ; $51a8
	and $f0 ; $51aa
	jr z, .storeSpeed ; $51ac
	ld d, $03 ; $51ae
.storeSpeed:
	ld hl, $0018 ; $51b0
	add hl, bc ; $51b3
	ld [hl], d ; $51b4
	ld a, [wPlayerMoveAngleApplied] ; $51b5
	ld [wPlayerMoveAnglePrev], a ; $51b8
	xor a ; $51bb
	ld [wPlayerMoveAngleApplied], a ; $51bc
	ldh a, [hPlayerInputFlags] ; $51bf
	and $f0 ; $51c1
	jr nz, .dpadToAngle ; $51c3
	xor a ; $51c5
	ld [wPlayerMoving], a ; $51c6
	jp .done ; $51c9
.dpadToAngle:
	ld hl, DpadMaskToAngleTable_04 ; $51cc
	swap a ; $51cf
	ld d, $00 ; $51d1
	ld e, a ; $51d3
	add hl, de ; $51d4
	ld a, [hl] ; $51d5
	cp $ff ; $51d6
	jr nz, .haveAngle ; $51d8
	jp .done ; $51da
.haveAngle:
	push bc ; $51dd
	ld [wPlayerMoveAngle], a ; $51de
	ld hl, hActorPtr ; $51e1
	ld a, [hl+] ; $51e4
	ld b, [hl] ; $51e5
	ld c, a ; $51e6
	ld hl, $0034 ; $51e7
	add hl, bc ; $51ea
	ld a, [wPlayerMoveAngle] ; $51eb
	ld [hl], a ; $51ee
	ld hl, $0015 ; $51ef
	add hl, bc ; $51f2
	ld [hl], $40 ; $51f3
	test_flag FLAG_PLAYER_RUNNING ; $51f5
	jr z, .checkBlocked ; $51f8
	ld a, $01 ; $51fa
	ld [wActorProbeRange], a ; $51fc
	ld de, $0040 ; $51ff
	ld hl, $0006 ; $5202
	add hl, bc ; $5205
	ld a, e ; $5206
	ld [hl+], a ; $5207
	ld [hl], d ; $5208
	jr .slideDepth ; $5209
.checkBlocked:
	ld hl, $000d ; $520b
	add hl, bc ; $520e
	ld d, [hl] ; $520f
	ld hl, $000f ; $5210
	add hl, bc ; $5213
	ld e, [hl] ; $5214
	farcall ReadCollisionMapCell ; $5215
	ld a, $00 ; $5218
	and $0f ; $521a
	cp $0b ; $521c
	jr nz, .slideX ; $521e
	ld a, $02 ; $5220
	ld [wActorProbeRange], a ; $5222
	ld de, $0010 ; $5225
	ld hl, $0006 ; $5228
	add hl, bc ; $522b
	ld a, e ; $522c
	ld [hl+], a ; $522d
	ld [hl], d ; $522e
	jr .slideDepth ; $522f
.slideX:
	xor a ; $5231
	ld [wActorProbeRange], a ; $5232
	ld de, $0020 ; $5235
	ld hl, $0006 ; $5238
	add hl, bc ; $523b
	ld a, e ; $523c
	ld [hl+], a ; $523d
	ld [hl], d ; $523e
.slideDepth:
	test_flag FLAG_DEBUG_NOCLIP ; $523f
	ld d, $00 ; $5242
	jp nz, .stopMoving ; $5244
	ld a, [wPlayerMoveAngle] ; $5247
	call GetPointAheadOfActorFixed ; $524a
	call IsPointBlocked ; $524d
	and a ; $5250
	jr nz, .checkFacing ; $5251
	ld a, [wPlayerMoveAngle] ; $5253
	add $20 ; $5256
	call GetPointAheadOfActorRanged ; $5258
	call IsPointBlocked ; $525b
	and a ; $525e
	jr nz, .applyMove ; $525f
	ld a, [wPlayerMoveAngle] ; $5261
	add $e0 ; $5264
	call GetPointAheadOfActorRanged ; $5266
	call IsPointBlocked ; $5269
	and a ; $526c
	ld d, $00 ; $526d
	jr z, .stopMoving ; $526f
	ld a, [wPlayerMoveAngle] ; $5271
	add $40 ; $5274
	call GetPointAheadOfActorFixed ; $5276
	call IsPointBlocked ; $5279
	and a ; $527c
	ld d, $20 ; $527d
	jr z, .stopMoving ; $527f
	jr .setFacing ; $5281
.applyMove:
	ld a, [wPlayerMoveAngle] ; $5283
	add $e0 ; $5286
	call GetPointAheadOfActorRanged ; $5288
	call IsPointBlocked ; $528b
	and a ; $528e
	jr nz, .checkFacing ; $528f
	ld a, [wPlayerMoveAngle] ; $5291
	add $c0 ; $5294
	call GetPointAheadOfActorFixed ; $5296
	call IsPointBlocked ; $5299
	and a ; $529c
	ld d, $e0 ; $529d
	jr z, .stopMoving ; $529f
	jr .setFacing ; $52a1
.checkFacing:
	ld [wPlayerMoveAngleApplied], a ; $52a3
	ld hl, wStoryAutoInteractArmed ; $52a6
	ld [hl], $01 ; $52a9
.setFacing:
	ld hl, $0014 ; $52ab
	add hl, bc ; $52ae
	ld a, [wPlayerMoveAngle] ; $52af
	ld [hl], a ; $52b2
	jr .idle ; $52b3
.stopMoving:
	ld hl, $0006 ; $52b5
	add hl, bc ; $52b8
	ld a, [hl+] ; $52b9
	ld h, [hl] ; $52ba
	ld l, a ; $52bb
	ld a, [wPlayerMoveAngle] ; $52bc
	add d ; $52bf
	call ProjectPointFromActor ; $52c0
	call CheckTileTriggerAtPoint ; $52c3
	call SetActorMoveTarget ; $52c6
	ld hl, $0005 ; $52c9
	add hl, bc ; $52cc
	set 7, [hl] ; $52cd
	ld hl, $0018 ; $52cf
	add hl, bc ; $52d2
	ld [hl], $02 ; $52d3
.idle:
	ld hl, wPlayerMoving ; $52d5
	inc [hl] ; $52d8
	ld a, [wPlayerMoveAngleApplied] ; $52d9
	and a ; $52dc
	jr nz, .clearMove ; $52dd
	ld [hl], $00 ; $52df
.clearMove:
	clear_flag FLAG_PLAYER_RUNNING ; $52e1
	pop bc ; $52e4
	xor a ; $52e5
	ret ; $52e6
.done:
	push bc ; $52e7
	ld hl, hActorPtr ; $52e8
	ld a, [hl+] ; $52eb
	ld b, [hl] ; $52ec
	ld c, a ; $52ed
	ld hl, $000e ; $52ee
	add hl, bc ; $52f1
	ld a, [hl+] ; $52f2
	ld h, [hl] ; $52f3
	ld l, a ; $52f4
	ld de, $0010 ; $52f5
	add hl, de ; $52f8
	ld a, l ; $52f9
	and $e0 ; $52fa
	ld l, a ; $52fc
	push hl ; $52fd
	ld hl, $000e ; $52fe
	add hl, bc ; $5301
	pop de ; $5302
	ld [hl], e ; $5303
	inc hl ; $5304
	ld [hl], d ; $5305
	ld hl, $000c ; $5306
	add hl, bc ; $5309
	ld a, [hl+] ; $530a
	ld h, [hl] ; $530b
	ld l, a ; $530c
	ld de, $0010 ; $530d
	add hl, de ; $5310
	ld a, l ; $5311
	and $e0 ; $5312
	ld l, a ; $5314
	push hl ; $5315
	ld hl, $000c ; $5316
	add hl, bc ; $5319
	pop de ; $531a
	ld [hl], e ; $531b
	inc hl ; $531c
	ld [hl], d ; $531d
	ld hl, $0005 ; $531e
	add hl, bc ; $5321
	res 7, [hl] ; $5322
	ld hl, $0018 ; $5324
	add hl, bc ; $5327
	ld [hl], $01 ; $5328
	pop bc ; $532a
	xor a ; $532b
	ret ; $532c
