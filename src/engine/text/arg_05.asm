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
	wram_bank WRAM_TEXT ; $4fe7
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
	push_wram_bank WRAM_TEXT ; $508b
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
	wram_bank WRAM_TEXT ; $50e3
	ld hl, wInlineTextBuffer ; $50e9
	call RenderInlineString ; $50ec
.restore:
	pop_wram_bank ; $50ef
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
	push_wram_bank WRAM_TEXT ; $5118
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
	pop_wram_bank ; $513d
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
	push_wram_bank WRAM_TEXT ; $514b
	ld d, h ; $5154
	ld e, l ; $5155
	ld a, [wTextArgNumberWriteIndex] ; $5156
	cp $10 ; $5159
	jr z, .done ; $515b
	ld b, $00 ; $515d
	ld c, a ; $515f
	sla c ; $5160
	inc a ; $5162
	ld [wTextArgNumberWriteIndex], a ; $5163
	ld [wTextArgNumberCount], a ; $5166
	ld hl, wTextArgNumberQueue ; $5169
	add hl, bc ; $516c
	ld [hl], e ; $516d
	inc hl ; $516e
	ld [hl], d ; $516f
.done:
	pop_wram_bank ; $5170
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
	push_wram_bank WRAM_TEXT ; $517f
	ld a, [wTextArgShortTextWriteIndex] ; $5188
	cp $10 ; $518b
	jr z, .restore ; $518d
	ld b, $00 ; $518f
	ld c, a ; $5191
	inc a ; $5192
	ld [wTextArgShortTextWriteIndex], a ; $5193
	ld [wTextArgShortTextCount], a ; $5196
	ld hl, wTextArgShortTextQueue ; $5199
	add hl, bc ; $519c
	ld [hl], d ; $519d
.restore:
	pop_wram_bank ; $519e
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
	wram_bank WRAM_TEXT ; $5200
	ld a, [wTextArgStringMeasureIndex] ; $5206
	ld b, $00 ; $5209
	ld c, a ; $520b
	inc a ; $520c
	ld [wTextArgStringMeasureIndex], a ; $520d
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
	wram_bank WRAM_TEXT ; $524c
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
