; Same divide as Unused_17_SetMenuCursorFromLinearIndex (c / b), but stores the
; remainder and quotient through the caller's hl rather than into the
; menu cursor. Also had no proven caller.
Unused_17_WriteGridPosFromLinearIndex:
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
	push_wram_bank WRAM_SCREEN ; $43d9
	xor a ; $43e2
	ld c, $40 ; $43e3
.loop4:
	ld [hl+], a ; $43e5
	dec c ; $43e6
	jr nz, .loop4 ; $43e7
	pop_wram_bank ; $43e9
	ret ; $43ee
ClearWram3Row64Alt_17:
	push_wram_bank WRAM_SCREEN ; $43ef
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
; Instruction-identical to DrawNameWithDiacritics_1b and Unused_3e_DrawNameWithDiacritics (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in draw_name_with_diacritics, Unused_17_DrawNameWithDiacritics, 17 ; $440a Unused_17_DrawNameWithDiacritics
; Instruction-identical to Unused_1b_DrawDecimalNumber, Unused_3b_DrawDecimalNumber and Unused_3e_DrawDecimalNumber (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in draw_decimal_number, Unused_17_DrawDecimalNumber, 17 ; $4443 Unused_17_DrawDecimalNumber
DrawAsciiDigitString_17:
	ld a, [hl+] ; $4464
	and a ; $4465
	jr z, .done ; $4466
	call DrawAsciiDigitChar_17 ; $4468
	jr DrawAsciiDigitString_17 ; $446b
.done:
	ret ; $446d
; Instruction-identical to DrawAsciiDigitChar_16, DrawAsciiDigitChar_1b, DrawAsciiDigitChar_3b and DrawAsciiDigitChar_3e (one copy per bank); a change here belongs in every copy.
	twin draw_ascii_digit_char, 17 ; $446e DrawAsciiDigitChar_17
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
	push_wram_bank WRAM_SCREEN ; $4676
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
	push_wram_bank WRAM_SCREEN ; $46e2
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
	push_wram_bank WRAM_SCREEN ; $470c
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
	push_wram_bank WRAM_SCREEN ; $4736
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
	push_wram_bank WRAM_SCREEN ; $4754
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
	push_wram_bank WRAM_SCREEN ; $478e
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
	push_wram_bank WRAM_SCREEN ; $47ef
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
	push_wram_bank WRAM_SCREEN ; $481c
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
