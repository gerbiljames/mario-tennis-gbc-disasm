StubNop_1a_3:
	ret ; $4da8
UnusedDrawExpScreenMessage_1:
	push af ; $4da9
	push bc ; $4daa
	push de ; $4dab
	push hl ; $4dac
	push_wram_bank $06 ; $4dad
	ld a, [wExpScreenFlags] ; $4db6
	or $01 ; $4db9
	ld [wExpScreenFlags], a ; $4dbb
	call AdvanceFrame ; $4dbe
	call DrawExpScreenMessageBox ; $4dc1
	ld hl, ExtendModifierByteTable0 ; $4dc4
	call DrawPositionedStringToTileBuffer ; $4dc7
	ld hl, ExtendModifierByteGfx1 ; $4dca
	call DrawPositionedStringToTileBuffer ; $4dcd
	wram_bank $01 ; $4dd0
	ld hl, wDecompBuffer ; $4dd6
	ld de, vBGMap0 + VRAM_BANK1 ; $4dd9
	ld c, $08 ; $4ddc
	call QueueVRAMCopy ; $4dde
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $4de1
	ld de, vBGMap0 ; $4de4
	ld c, $08 ; $4de7
	call QueueVRAMCopy ; $4de9
	call AdvanceFrame ; $4dec
	wram_bank $06 ; $4def
	ld a, [wExpScreenFlags] ; $4df5
	and $fe ; $4df8
	ld [wExpScreenFlags], a ; $4dfa
	pop_wram_bank ; $4dfd
	pop hl ; $4e02
	pop de ; $4e03
	pop bc ; $4e04
	pop af ; $4e05
	ret ; $4e06
UnusedDrawExpScreenMessage_2:
	push af ; $4e07
	push bc ; $4e08
	push de ; $4e09
	push hl ; $4e0a
	push_wram_bank $06 ; $4e0b
	ld a, [wExpScreenFlags] ; $4e14
	or $01 ; $4e17
	ld [wExpScreenFlags], a ; $4e19
	call AdvanceFrame ; $4e1c
	call DrawExpScreenMessageBox ; $4e1f
	ld hl, ExtendModifierByteTable2 ; $4e22
	call DrawPositionedStringToTileBuffer ; $4e25
	ld hl, ExtendModifierByteGfx3 ; $4e28
	call DrawPositionedStringToTileBuffer ; $4e2b
	wram_bank $01 ; $4e2e
	ld hl, wDecompBuffer ; $4e34
	ld de, vBGMap0 + VRAM_BANK1 ; $4e37
	ld c, $08 ; $4e3a
	call QueueVRAMCopy ; $4e3c
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $4e3f
	ld de, vBGMap0 ; $4e42
	ld c, $08 ; $4e45
	call QueueVRAMCopy ; $4e47
	call AdvanceFrame ; $4e4a
	wram_bank $06 ; $4e4d
	ld a, [wExpScreenFlags] ; $4e53
	and $fe ; $4e56
	ld [wExpScreenFlags], a ; $4e58
	pop_wram_bank ; $4e5b
	pop hl ; $4e60
	pop de ; $4e61
	pop bc ; $4e62
	pop af ; $4e63
	ret ; $4e64
ExpScreenNumberTask:
	wram_bank $06 ; $4e65
	ld hl, wExpAwardCounted ; $4e6b
	ld a, [hl+] ; $4e6e
	ld h, [hl] ; $4e6f
	ld l, a ; $4e70
	ld de, wExpCountedDigits ; $4e71
	ld a, $05 ; $4e74
	call FormatDecimalNumberUnsigned ; $4e76
	ld hl, wExpCountedSprite ; $4e79
	ld d, [hl] ; $4e7c
	inc hl ; $4e7d
	ld e, [hl] ; $4e7e
	ld hl, wExpCountedDigits ; $4e7f
	ld a, $05 ; $4e82
	call QueueNumberSpritesShifted ; $4e84
	wram_bank $06 ; $4e87
	push af ; $4e8d
	ld hl, wStoryModeNameOfMainCharacter ; $4e8e
	ld a, [wStoryCharacterSlot] ; $4e91
	or a ; $4e94
	jr z, .zero ; $4e95
	ld l, $40 ; $4e97
.zero:
	ld a, l ; $4e99
	add $18 ; $4e9a
	ld l, a ; $4e9c
	ld a, h ; $4e9d
	adc $00 ; $4e9e
	ld h, a ; $4ea0
	pop af ; $4ea1
	ld a, [hl] ; $4ea2
	cp $63 ; $4ea3
	ret z ; $4ea5
	ld a, [wCharDataAnimCounter] ; $4ea6
	and a ; $4ea9
	jp nz, .nonZero ; $4eaa
	ld a, [wExpLevelUpQueued] ; $4ead
	and a ; $4eb0
	ret nz ; $4eb1
	ld hl, wExpToNextDisplayed ; $4eb2
	ld a, [hl+] ; $4eb5
	ld h, [hl] ; $4eb6
	ld l, a ; $4eb7
	ld a, h ; $4eb8
	or l ; $4eb9
	jr z, .step2 ; $4eba
	ld de, wExpToNextDigits ; $4ebc
	ld a, $05 ; $4ebf
	call FormatDecimalNumberUnsigned ; $4ec1
	ld hl, wExpToNextSprite ; $4ec4
	ld d, [hl] ; $4ec7
	inc hl ; $4ec8
	ld e, [hl] ; $4ec9
	ld hl, wExpToNextDigits ; $4eca
	ld a, $05 ; $4ecd
	call QueueNumberSprites ; $4ecf
	ret ; $4ed2
.step2:
	ld a, [wExpLevelUpQueued] ; $4ed3
	and a ; $4ed6
	ret nz ; $4ed7
	ld a, [wExpScreenFlags] ; $4ed8
	or $80 ; $4edb
	ld [wExpScreenFlags], a ; $4edd
	ld a, $01 ; $4ee0
	ld [wExpLevelUpQueued], a ; $4ee2
.nonZero:
	ld hl, wExpToNextLevel ; $4ee5
	ld a, [hl+] ; $4ee8
	ld h, [hl] ; $4ee9
	ld l, a ; $4eea
	ld de, wExpToNextDigits ; $4eeb
	ld a, $05 ; $4eee
	call FormatDecimalNumberUnsigned ; $4ef0
	ld hl, wExpToNextSprite ; $4ef3
	ld d, [hl] ; $4ef6
	inc hl ; $4ef7
	ld e, [hl] ; $4ef8
	ld hl, wExpToNextDigits ; $4ef9
	ld a, $05 ; $4efc
	call QueueNumberSprites ; $4efe
	ret ; $4f01
QueueNumberSpritesShifted:
	push af ; $4f02
	push de ; $4f03
	ld a, [wExpNumberSpriteShiftX] ; $4f04
	add d ; $4f07
	ld d, a ; $4f08
	push hl ; $4f09
	push bc ; $4f0a
	ld a, [hl] ; $4f0b
	sub $20 ; $4f0c
	jr z, .restore ; $4f0e
	sub $10 ; $4f10
	add a ; $4f12
	ld b, a ; $4f13
	ld a, [wExpCountedSprite + 2] ; $4f14
	ld c, a ; $4f17
	ld a, b ; $4f18
	add c ; $4f19
	ld c, a ; $4f1a
	ld a, [wExpCountedSprite + 3] ; $4f1b
	ld b, a ; $4f1e
	call QueueSprite ; $4f1f
.restore:
	pop bc ; $4f22
	pop hl ; $4f23
	pop de ; $4f24
	dec bc ; $4f25
	inc hl ; $4f26
	ld a, d ; $4f27
	add $08 ; $4f28
	ld d, a ; $4f2a
	pop af ; $4f2b
	dec a ; $4f2c
	jr nz, QueueNumberSpritesShifted ; $4f2d
	ret ; $4f2f
AdvanceExpGaugeFill:
	wram_bank $06 ; $4f30
	ld a, [wExpCountDone] ; $4f36
	and a ; $4f39
	jr nz, .updateRemaining ; $4f3a
	ld hl, wExpAwardCounted ; $4f3c
	ld a, [hl+] ; $4f3f
	ld d, [hl] ; $4f40
	ld e, a ; $4f41
	inc de ; $4f42
	dec hl ; $4f43
	ld a, e ; $4f44
	ld [hl+], a ; $4f45
	ld [hl], d ; $4f46
	ld hl, wExpAwardTotal ; $4f47
	ld a, [hl+] ; $4f4a
	ld h, [hl] ; $4f4b
	ld l, a ; $4f4c
	ld a, l ; $4f4d
	sub e ; $4f4e
	ld l, a ; $4f4f
	ld a, h ; $4f50
	sbc d ; $4f51
	ld h, a ; $4f52
	ld a, h ; $4f53
	or l ; $4f54
	jr nz, .updateRemaining ; $4f55
	ld a, $01 ; $4f57
	ld [wExpCountDone], a ; $4f59
.updateRemaining:
	ld hl, wExpAwardCounted ; $4f5c
	ld a, [hl+] ; $4f5f
	ld b, [hl] ; $4f60
	ld c, a ; $4f61
	ld hl, wExpToNextLevel ; $4f62
	ld a, [hl+] ; $4f65
	ld h, [hl] ; $4f66
	ld l, a ; $4f67
	ld a, l ; $4f68
	sub c ; $4f69
	ld l, a ; $4f6a
	ld a, h ; $4f6b
	sbc b ; $4f6c
	ld h, a ; $4f6d
	bit 7, h ; $4f6e
	jr nz, .clampToZero ; $4f70
	ld d, h ; $4f72
	ld e, l ; $4f73
	ld hl, wExpToNextDisplayed ; $4f74
	ld a, e ; $4f77
	ld [hl+], a ; $4f78
	ld [hl], d ; $4f79
	ret ; $4f7a
.clampToZero:
	xor a ; $4f7b
	ld hl, wExpToNextDisplayed ; $4f7c
	ld [hl+], a ; $4f7f
	ld [hl+], a ; $4f80
	ret ; $4f81
QueueNumberSprites:
	push af ; $4f82
	push de ; $4f83
	push hl ; $4f84
	push bc ; $4f85
	ld a, [hl] ; $4f86
	sub $20 ; $4f87
	jr z, .restore ; $4f89
	sub $10 ; $4f8b
	add a ; $4f8d
	ld b, a ; $4f8e
	ld a, [wExpCountedSprite + 2] ; $4f8f
	ld c, a ; $4f92
	ld a, b ; $4f93
	add c ; $4f94
	ld c, a ; $4f95
	ld a, [wExpCountedSprite + 3] ; $4f96
	ld b, a ; $4f99
	call QueueSprite ; $4f9a
.restore:
	pop bc ; $4f9d
	pop hl ; $4f9e
	pop de ; $4f9f
	dec bc ; $4fa0
	inc hl ; $4fa1
	ld a, d ; $4fa2
	add $08 ; $4fa3
	ld d, a ; $4fa5
	pop af ; $4fa6
	dec a ; $4fa7
	jr nz, QueueNumberSprites ; $4fa8
	ret ; $4faa
DrawExpScreenCaption:
	and a ; $4fab
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
	ld hl, wTextTileBuffer ; $4fcb
	ld bc, $0302 ; $4fce
	ld e, $01 ; $4fd1
	call DrawStringToTileBuffer ; $4fd3
	ret ; $4fd6
.caption1:
	ld hl, Text_31_239 ; $4fd7
	call LoadDialogueTextToBuffer ; $4fda
	wram_bank $01 ; $4fdd
	ld hl, wTextTileBuffer ; $4fe3
	ld bc, $0101 ; $4fe6
	ld e, $01 ; $4fe9
	call DrawStringToTileBuffer ; $4feb
	ld hl, Text_31_240 ; $4fee
	call LoadDialogueTextToBuffer ; $4ff1
	ld hl, wTextTileBuffer ; $4ff4
	ld bc, $0103 ; $4ff7
	ld e, $01 ; $4ffa
	call DrawStringToTileBuffer ; $4ffc
	ret ; $4fff
.caption2:
	ld hl, Text_31_241 ; $5000
	call LoadDialogueTextToBuffer ; $5003
	wram_bank $01 ; $5006
	ld hl, wTextTileBuffer ; $500c
	ld bc, $0110 ; $500f
	ld e, $01 ; $5012
	call DrawStringToTileBuffer ; $5014
	ret ; $5017
.caption3:
	wram_bank $03 ; $5018
	ld hl, Text_31_242 ; $501e
	ld de, wCharDataPageSlot1 + 2 * TILEMAP_WIDTH + 11 ; $5021
	ld c, $20 ; $5024
	farcall RenderProportionalTextAt ; $5026
	sound SFX_CAPTION ; $5029
	ret ; $502b
.caption4:
	ld hl, Text_31_243 ; $502c
	call LoadDialogueTextToBuffer ; $502f
	wram_bank $01 ; $5032
	ld hl, wTextTileBuffer ; $5038
	ld bc, $0302 ; $503b
	ld e, $01 ; $503e
	call DrawStringToTileBuffer ; $5040
	ret ; $5043
.caption5:
	sound BGM_NONE ; $5044
	ld hl, Text_31_244 ; $5046
	call LoadDialogueTextToBuffer ; $5049
	wram_bank $01 ; $504c
	ld hl, wTextTileBuffer ; $5052
	ld bc, $0a10 ; $5055
	ld e, $01 ; $5058
	call DrawStringToTileBuffer ; $505a
	ret ; $505d
LoadDialogueTextToBuffer:
	wram_bank $05 ; $505e
	farcall FetchDialogueText ; $5064
	ld hl, wTextBuffer ; $5067
	ld de, wTextTileBuffer ; $506a
.copyLoop:
	wram_bank $05 ; $506d
	ld b, [hl] ; $5073
	wram_bank $01 ; $5074
	ld a, b ; $507a
	ld [de], a ; $507b
	inc hl ; $507c
	inc de ; $507d
	and a ; $507e
	jr nz, .copyLoop ; $507f
	ret ; $5081
ResetCharDataScreenAnim:
	push af ; $5082
	push bc ; $5083
	push de ; $5084
	push hl ; $5085
	push_wram_bank $06 ; $5086
	xor a ; $508f
	ld [wCharDataAnimCounter], a ; $5090
	pop_wram_bank ; $5093
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
	ld a, [wExpLevelUpQueued] ; $50ae
	and a ; $50b1
	jr z, .restore ; $50b2
	wram_bank $06 ; $50b4
	ld a, $01 ; $50ba
	ld [wCharDataAnimCounter], a ; $50bc
	ld a, $01 ; $50bf
	ld de, $0000 ; $50c1
	ld h, $04 ; $50c4
	call ShowExpGainScreen ; $50c6
.restore:
	pop_wram_bank ; $50c9
	pop hl ; $50ce
	pop de ; $50cf
	pop bc ; $50d0
	pop af ; $50d1
	ret ; $50d2
DrawExpBonusMessage:
	push af ; $50d3
	call DrawExpScreenMessageBox ; $50d4
	pop af ; $50d7
	cp $01 ; $50d8
	jp z, .eq01 ; $50da
	cp $02 ; $50dd
	jp z, .eq02 ; $50df
	cp $03 ; $50e2
	jp z, .eq03 ; $50e4
	cp $14 ; $50e7
	jp z, .eq14 ; $50e9
	cp $15 ; $50ec
	jp z, .eq15 ; $50ee
	cp $16 ; $50f1
	jp z, .eq16 ; $50f3
	cp $17 ; $50f6
	jp z, .eq17 ; $50f8
	cp $18 ; $50fb
	jp z, .eq18 ; $50fd
	cp $19 ; $5100
	jp z, .eq19 ; $5102
	cp $1a ; $5105
	jp z, .eq1a ; $5107
	cp $1b ; $510a
	jp z, .eq1b ; $510c
	cp $1c ; $510f
	jp z, .eq1c ; $5111
	cp $1d ; $5114
	jp z, .eq1d ; $5116
	cp $1e ; $5119
	jp z, .eq1e ; $511b
	jp .loadDialogueTextToBuffer ; $511e
.eq01:
	ld hl, Text_31_245 ; $5121
	call LoadDialogueTextToBuffer ; $5124
	wram_bank $01 ; $5127
	ld hl, wTextTileBuffer ; $512d
	ld bc, $0201 ; $5130
	ld e, $01 ; $5133
	call DrawStringToTileBuffer ; $5135
	jp .loadDialogueTextToBuffer2 ; $5138
.eq02:
	ld hl, Text_31_246 ; $513b
	call LoadDialogueTextToBuffer ; $513e
	wram_bank $01 ; $5141
	ld hl, wTextTileBuffer ; $5147
	ld bc, $0201 ; $514a
	ld e, $01 ; $514d
	call DrawStringToTileBuffer ; $514f
	jp .loadDialogueTextToBuffer2 ; $5152
.eq03:
	ld hl, Text_31_247 ; $5155
	call LoadDialogueTextToBuffer ; $5158
	wram_bank $01 ; $515b
	ld hl, wTextTileBuffer ; $5161
	ld bc, $0201 ; $5164
	ld e, $01 ; $5167
	call DrawStringToTileBuffer ; $5169
	jp .loadDialogueTextToBuffer2 ; $516c
.eq14:
	ld hl, Text_31_248 ; $516f
	call LoadDialogueTextToBuffer ; $5172
	wram_bank $01 ; $5175
	ld hl, wTextTileBuffer ; $517b
	ld bc, $0201 ; $517e
	ld e, $01 ; $5181
	call DrawStringToTileBuffer ; $5183
	ld hl, Text_30_31 ; $5186
	call LoadDialogueTextToBuffer ; $5189
	wram_bank $01 ; $518c
	ld hl, wTextTileBuffer ; $5192
	ld bc, $0601 ; $5195
	ld e, $01 ; $5198
	call DrawStringToTileBuffer ; $519a
	ld hl, Text_31_249 ; $519d
	call LoadDialogueTextToBuffer ; $51a0
	wram_bank $01 ; $51a3
	ld hl, wTextTileBuffer ; $51a9
	ld bc, $0901 ; $51ac
	ld e, $01 ; $51af
	call DrawStringToTileBuffer ; $51b1
	jp .loadDialogueTextToBuffer2 ; $51b4
.eq15:
	ld hl, Text_31_248 ; $51b7
	call LoadDialogueTextToBuffer ; $51ba
	wram_bank $01 ; $51bd
	ld hl, wTextTileBuffer ; $51c3
	ld bc, $0201 ; $51c6
	ld e, $01 ; $51c9
	call DrawStringToTileBuffer ; $51cb
	ld hl, Text_30_32 ; $51ce
	call LoadDialogueTextToBuffer ; $51d1
	wram_bank $01 ; $51d4
	ld hl, wTextTileBuffer ; $51da
	ld bc, $0601 ; $51dd
	ld e, $01 ; $51e0
	call DrawStringToTileBuffer ; $51e2
	ld hl, Text_31_249 ; $51e5
	call LoadDialogueTextToBuffer ; $51e8
	wram_bank $01 ; $51eb
	ld hl, wTextTileBuffer ; $51f1
	ld bc, $0a01 ; $51f4
	ld e, $01 ; $51f7
	call DrawStringToTileBuffer ; $51f9
	jp .loadDialogueTextToBuffer2 ; $51fc
.eq16:
	ld hl, Text_31_248 ; $51ff
	call LoadDialogueTextToBuffer ; $5202
	wram_bank $01 ; $5205
	ld hl, wTextTileBuffer ; $520b
	ld bc, $0201 ; $520e
	ld e, $01 ; $5211
	call DrawStringToTileBuffer ; $5213
	ld hl, Text_30_33 ; $5216
	call LoadDialogueTextToBuffer ; $5219
	wram_bank $01 ; $521c
	ld hl, wTextTileBuffer ; $5222
	ld bc, $0601 ; $5225
	ld e, $01 ; $5228
	call DrawStringToTileBuffer ; $522a
	ld hl, Text_31_249 ; $522d
	call LoadDialogueTextToBuffer ; $5230
	wram_bank $01 ; $5233
	ld hl, wTextTileBuffer ; $5239
	ld bc, $0a01 ; $523c
	ld e, $01 ; $523f
	call DrawStringToTileBuffer ; $5241
	jp .loadDialogueTextToBuffer2 ; $5244
.eq17:
	ld hl, Text_31_248 ; $5247
	call LoadDialogueTextToBuffer ; $524a
	wram_bank $01 ; $524d
	ld hl, wTextTileBuffer ; $5253
	ld bc, $0201 ; $5256
	ld e, $01 ; $5259
	call DrawStringToTileBuffer ; $525b
	ld hl, Text_30_34 ; $525e
	call LoadDialogueTextToBuffer ; $5261
	wram_bank $01 ; $5264
	ld hl, wTextTileBuffer ; $526a
	ld bc, $0601 ; $526d
	ld e, $01 ; $5270
	call DrawStringToTileBuffer ; $5272
	ld hl, Text_31_249 ; $5275
	call LoadDialogueTextToBuffer ; $5278
	wram_bank $01 ; $527b
	ld hl, wTextTileBuffer ; $5281
	ld bc, $0901 ; $5284
	ld e, $01 ; $5287
	call DrawStringToTileBuffer ; $5289
	jp .loadDialogueTextToBuffer2 ; $528c
.eq18:
	ld hl, Text_31_248 ; $528f
	call LoadDialogueTextToBuffer ; $5292
	wram_bank $01 ; $5295
	ld hl, wTextTileBuffer ; $529b
	ld bc, $0201 ; $529e
	ld e, $01 ; $52a1
	call DrawStringToTileBuffer ; $52a3
	ld hl, Text_30_35 ; $52a6
	call LoadDialogueTextToBuffer ; $52a9
	wram_bank $01 ; $52ac
	ld hl, wTextTileBuffer ; $52b2
	ld bc, $0601 ; $52b5
	ld e, $01 ; $52b8
	call DrawStringToTileBuffer ; $52ba
	ld hl, Text_31_249 ; $52bd
	call LoadDialogueTextToBuffer ; $52c0
	wram_bank $01 ; $52c3
	ld hl, wTextTileBuffer ; $52c9
	ld bc, $0901 ; $52cc
	ld e, $01 ; $52cf
	call DrawStringToTileBuffer ; $52d1
	jp .loadDialogueTextToBuffer2 ; $52d4
.eq19:
	ld hl, Text_31_248 ; $52d7
	call LoadDialogueTextToBuffer ; $52da
	wram_bank $01 ; $52dd
	ld hl, wTextTileBuffer ; $52e3
	ld bc, $0201 ; $52e6
	ld e, $01 ; $52e9
	call DrawStringToTileBuffer ; $52eb
	ld hl, Text_30_36 ; $52ee
	call LoadDialogueTextToBuffer ; $52f1
	wram_bank $01 ; $52f4
	ld hl, wTextTileBuffer ; $52fa
	ld bc, $0601 ; $52fd
	ld e, $01 ; $5300
	call DrawStringToTileBuffer ; $5302
	ld hl, Text_31_249 ; $5305
	call LoadDialogueTextToBuffer ; $5308
	wram_bank $01 ; $530b
	ld hl, wTextTileBuffer ; $5311
	ld bc, $0a01 ; $5314
	ld e, $01 ; $5317
	call DrawStringToTileBuffer ; $5319
	jp .loadDialogueTextToBuffer2 ; $531c
.eq1a:
	ld hl, Text_31_248 ; $531f
	call LoadDialogueTextToBuffer ; $5322
	wram_bank $01 ; $5325
	ld hl, wTextTileBuffer ; $532b
	ld bc, $0201 ; $532e
	ld e, $01 ; $5331
	call DrawStringToTileBuffer ; $5333
	ld hl, Text_30_37 ; $5336
	call LoadDialogueTextToBuffer ; $5339
	wram_bank $01 ; $533c
	ld hl, wTextTileBuffer ; $5342
	ld bc, $0601 ; $5345
	ld e, $01 ; $5348
	call DrawStringToTileBuffer ; $534a
	ld hl, Text_31_249 ; $534d
	call LoadDialogueTextToBuffer ; $5350
	wram_bank $01 ; $5353
	ld hl, wTextTileBuffer ; $5359
	ld bc, $0a01 ; $535c
	ld e, $01 ; $535f
	call DrawStringToTileBuffer ; $5361
	jp .loadDialogueTextToBuffer2 ; $5364
.eq1b:
	ld hl, Text_31_248 ; $5367
	call LoadDialogueTextToBuffer ; $536a
	wram_bank $01 ; $536d
	ld hl, wTextTileBuffer ; $5373
	ld bc, $0201 ; $5376
	ld e, $01 ; $5379
	call DrawStringToTileBuffer ; $537b
	ld hl, Text_30_38 ; $537e
	call LoadDialogueTextToBuffer ; $5381
	wram_bank $01 ; $5384
	ld hl, wTextTileBuffer ; $538a
	ld bc, $0601 ; $538d
	ld e, $01 ; $5390
	call DrawStringToTileBuffer ; $5392
	ld hl, Text_31_249 ; $5395
	call LoadDialogueTextToBuffer ; $5398
	wram_bank $01 ; $539b
	ld hl, wTextTileBuffer ; $53a1
	ld bc, $0901 ; $53a4
	ld e, $01 ; $53a7
	call DrawStringToTileBuffer ; $53a9
	jp .loadDialogueTextToBuffer2 ; $53ac
.eq1c:
	ld hl, Text_31_248 ; $53af
	call LoadDialogueTextToBuffer ; $53b2
	wram_bank $01 ; $53b5
	ld hl, wTextTileBuffer ; $53bb
	ld bc, $0201 ; $53be
	ld e, $01 ; $53c1
	call DrawStringToTileBuffer ; $53c3
	ld hl, Text_30_39 ; $53c6
	call LoadDialogueTextToBuffer ; $53c9
	wram_bank $01 ; $53cc
	ld hl, wTextTileBuffer ; $53d2
	ld bc, $0601 ; $53d5
	ld e, $01 ; $53d8
	call DrawStringToTileBuffer ; $53da
	ld hl, Text_31_249 ; $53dd
	call LoadDialogueTextToBuffer ; $53e0
	wram_bank $01 ; $53e3
	ld hl, wTextTileBuffer ; $53e9
	ld bc, $0901 ; $53ec
	ld e, $01 ; $53ef
	call DrawStringToTileBuffer ; $53f1
	jp .loadDialogueTextToBuffer2 ; $53f4
.eq1d:
	ld hl, Text_31_248 ; $53f7
	call LoadDialogueTextToBuffer ; $53fa
	wram_bank $01 ; $53fd
	ld hl, wTextTileBuffer ; $5403
	ld bc, $0201 ; $5406
	ld e, $01 ; $5409
	call DrawStringToTileBuffer ; $540b
	ld hl, Text_30_40 ; $540e
	call LoadDialogueTextToBuffer ; $5411
	wram_bank $01 ; $5414
	ld hl, wTextTileBuffer ; $541a
	ld bc, $0601 ; $541d
	ld e, $01 ; $5420
	call DrawStringToTileBuffer ; $5422
	ld hl, Text_31_249 ; $5425
	call LoadDialogueTextToBuffer ; $5428
	wram_bank $01 ; $542b
	ld hl, wTextTileBuffer ; $5431
	ld bc, $0a01 ; $5434
	ld e, $01 ; $5437
	call DrawStringToTileBuffer ; $5439
	jp .loadDialogueTextToBuffer2 ; $543c
.eq1e:
	ld hl, Text_31_248 ; $543f
	call LoadDialogueTextToBuffer ; $5442
	wram_bank $01 ; $5445
	ld hl, wTextTileBuffer ; $544b
	ld bc, $0201 ; $544e
	ld e, $01 ; $5451
	call DrawStringToTileBuffer ; $5453
	ld hl, Text_30_41 ; $5456
	call LoadDialogueTextToBuffer ; $5459
	wram_bank $01 ; $545c
	ld hl, wTextTileBuffer ; $5462
	ld bc, $0601 ; $5465
	ld e, $01 ; $5468
	call DrawStringToTileBuffer ; $546a
	ld hl, Text_31_249 ; $546d
	call LoadDialogueTextToBuffer ; $5470
	wram_bank $01 ; $5473
	ld hl, wTextTileBuffer ; $5479
	ld bc, $0b01 ; $547c
	ld e, $01 ; $547f
	call DrawStringToTileBuffer ; $5481
	jr .loadDialogueTextToBuffer2 ; $5484
.loadDialogueTextToBuffer:
	ld hl, Text_31_248 ; $5486
	call LoadDialogueTextToBuffer ; $5489
	wram_bank $01 ; $548c
	ld hl, wTextTileBuffer ; $5492
	ld bc, $0201 ; $5495
	ld e, $01 ; $5498
	call DrawStringToTileBuffer ; $549a
	ld hl, Text_30_42 ; $549d
	call LoadDialogueTextToBuffer ; $54a0
	wram_bank $01 ; $54a3
	ld hl, wTextTileBuffer ; $54a9
	ld bc, $0601 ; $54ac
	ld e, $01 ; $54af
	call DrawStringToTileBuffer ; $54b1
	ld hl, Text_31_249 ; $54b4
	call LoadDialogueTextToBuffer ; $54b7
	wram_bank $01 ; $54ba
	ld hl, wTextTileBuffer ; $54c0
	ld bc, $0901 ; $54c3
	ld e, $01 ; $54c6
	call DrawStringToTileBuffer ; $54c8
	jr .loadDialogueTextToBuffer2 ; $54cb
.loadDialogueTextToBuffer2:
	ld hl, Text_31_244 ; $54cd
	call LoadDialogueTextToBuffer ; $54d0
	wram_bank $01 ; $54d3
	ld hl, wTextTileBuffer ; $54d9
	ld bc, $0203 ; $54dc
	ld e, $01 ; $54df
	call DrawStringToTileBuffer ; $54e1
	wram_bank $06 ; $54e4
	ld a, [wExpScreenFlags] ; $54ea
	or $01 ; $54ed
	ld [wExpScreenFlags], a ; $54ef
	call AdvanceFrame ; $54f2
	wram_bank $01 ; $54f5
	ld hl, wDecompBuffer ; $54fb
	ld de, vBGMap0 + VRAM_BANK1 ; $54fe
	ld c, $08 ; $5501
	call QueueVRAMCopy ; $5503
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $5506
	ld de, vBGMap0 ; $5509
	ld c, $08 ; $550c
	call QueueVRAMCopy ; $550e
	call AdvanceFrame ; $5511
	wram_bank $06 ; $5514
	ld a, [wExpScreenFlags] ; $551a
	and $fe ; $551d
	ld [wExpScreenFlags], a ; $551f
	ret ; $5522
