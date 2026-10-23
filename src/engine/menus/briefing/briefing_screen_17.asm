; Same divide as Unused_17_SetMenuCursorFromLinearIndex (c / b), but stores the
; remainder and quotient through the caller's hl rather than into the
; menu cursor. Nothing calls it.
Unused_17_WriteGridPosFromLinearIndex:
	ld d, $00 ; $43cb
	ld a, c ; $43cd
.divideLoop:
	cp b ; $43ce
	jr c, .storeXY ; $43cf
	inc d ; $43d1
	sub b ; $43d2
	jr .divideLoop ; $43d3
.storeXY:
	ld [hl+], a ; $43d5
	ld a, d ; $43d6
	ld [hl], a ; $43d7
	ret ; $43d8
Unused_17_ClearWram3Row64:
	push_wram_bank WRAM_SCREEN ; $43d9
	xor a ; $43e2
	ld c, $40 ; $43e3
.clearLoop:
	ld [hl+], a ; $43e5
	dec c ; $43e6
	jr nz, .clearLoop ; $43e7
	pop_wram_bank ; $43e9
	ret ; $43ee
Unused_17_ClearWram3Row64Alt:
	push_wram_bank WRAM_SCREEN ; $43ef
	ld a, $00 ; $43f8
	ld c, $40 ; $43fa
.clearLoop:
	ld [hl+], a ; $43fc
	dec c ; $43fd
	jr nz, .clearLoop ; $43fe
	pop_wram_bank ; $4400
	ret ; $4405
UpdateAnimatedTilesTask_17:
	farcall UpdateAnimatedTiles ; $4406
	ret ; $4409
	twin_in draw_name_with_diacritics, Unused_17_DrawNameWithDiacritics, 17 ; $440a Unused_17_DrawNameWithDiacritics
	twin_in draw_decimal_number, Unused_17_DrawDecimalNumber, 17 ; $4443 Unused_17_DrawDecimalNumber
Unused_17_DrawAsciiDigitString:
	ld a, [hl+] ; $4464
	and a ; $4465
	jr z, .done ; $4466
	call Unused_17_DrawAsciiDigitChar ; $4468
	jr Unused_17_DrawAsciiDigitString ; $446b
.done:
	ret ; $446d
	twin_in draw_ascii_digit_char, Unused_17_DrawAsciiDigitChar, 17 ; $446e Unused_17_DrawAsciiDigitChar
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
	frame_task UpdateAnimatedTilesTask_17 ; $44a9
	ld a, $03 ; $44b1
	ld [wAnimatedTilePeriod], a ; $44b3
	script_fade_in 16 ; $44b6
	call WaitFadeEnd ; $44bb
	ld a, [wCurrentMatchIndex] ; $44be
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
	jumptable a ; $44d3
	dw DrillBriefing_ServeToTargets ; $44d5 jumptable
	dw DrillBriefing_SpinServe ; $44d7 jumptable
	dw DrillBriefing_ServeThroughPoles ; $44d9 jumptable
	dw DrillBriefing_ServeAndVolley ; $44db jumptable
	dw DrillBriefing_ServeAndSmash ; $44dd jumptable
	dw DrillBriefing_DropShot ; $44df jumptable
	dw DrillBriefing_ReturnToTarget ; $44e1 jumptable
	dw DrillBriefing_ReturnLob ; $44e3 jumptable
	dw DrillBriefing_ReturnDownLine ; $44e5 jumptable
.done:
	call ClearFrameTasks ; $44e7
	ret ; $44ea
Unused_17_ShowCourtDiagramTestScreen:
	call DisableLCDSafely ; $44eb
	call LoadCourtDiagramScreen ; $44ee
	call EnableLCD ; $44f1
	xor a ; $44f4
	ld [wAnimatedTileSet], a ; $44f5
	frame_task UpdateAnimatedTilesTask_17 ; $44f8
	ld a, $03 ; $4500
	ld [wAnimatedTilePeriod], a ; $4502
	script_fade_in 16 ; $4505
	call WaitFadeEnd ; $450a
	ld a, $50 ; $450d
	ld [wBriefingPlayerX], a ; $450f
	ld a, $40 ; $4512
	ld [wBriefingPlayerY], a ; $4514
	frame_task DrawBriefingPlayerSprite ; $4517
	ld a, $30 ; $451f
	ld [wBriefingOpponentX], a ; $4521
	ld a, $20 ; $4524
	ld [wBriefingOpponentY], a ; $4526
	frame_task DrawBriefingOpponentSprite ; $4529
	ld a, $60 ; $4531
	ld [wBriefingBallX], a ; $4533
	ld a, $30 ; $4536
	ld [wBriefingBallY], a ; $4538
	frame_task DrawBriefingBallSprite ; $453b
	ld a, $01 ; $4543
	ld [wBriefingHandUnflipped], a ; $4545
	ld a, $60 ; $4548
	ld [wBriefingHandX], a ; $454a
	ld a, $40 ; $454d
	ld [wBriefingHandY], a ; $454f
	frame_task DrawBriefingPointingHand ; $4552
	ld hl, Text_DebugRacketTest ; $455a
	call DrawBriefingCaption ; $455d
	call WaitForInputBlinking ; $4560
	call ClearFrameTasks ; $4563
	frame_task UpdateAnimatedTilesTask_17 ; $4566
	ld a, $09 ; $456e
	ld [wBriefingCmdPrompt], a ; $4570
	ld a, $40 ; $4573
	ld [wBriefingCmdPromptX], a ; $4575
	ld a, $32 ; $4578
	ld [wBriefingCmdPromptY], a ; $457a
	frame_task DrawBriefingCmdPrompt ; $457d
	ld a, $40 ; $4585
	ld [wBriefingPole1X], a ; $4587
	ld a, $20 ; $458a
	ld [wBriefingPole1Y], a ; $458c
	ld a, $50 ; $458f
	ld [wBriefingPole2X], a ; $4591
	ld a, $20 ; $4594
	ld [wBriefingPole2Y], a ; $4596
	frame_task DrawBriefingPoleSprites ; $4599
	ld a, $01 ; $45a1
	ld [wBriefingDownArrowUnflipped], a ; $45a3
	ld a, $30 ; $45a6
	ld [wBriefingDownArrowX], a ; $45a8
	ld a, $20 ; $45ab
	ld [wBriefingDownArrowY], a ; $45ad
	frame_task DrawBriefingDownArrow ; $45b0
	ld a, $01 ; $45b8
	ld [wBriefingLeftArrowUnflipped], a ; $45ba
	ld a, $20 ; $45bd
	ld [wBriefingLeftArrowX], a ; $45bf
	ld a, $40 ; $45c2
	ld [wBriefingLeftArrowY], a ; $45c4
	frame_task DrawBriefingLeftArrow ; $45c7
	ld a, $03 ; $45cf
	ld [wBriefingDiagArrowDir], a ; $45d1
	ld a, $10 ; $45d4
	ld [wBriefingDiagArrowX], a ; $45d6
	ld a, $10 ; $45d9
	ld [wBriefingDiagArrowY], a ; $45db
	frame_task DrawBriefingDiagonalArrow ; $45de
	ld a, $18 ; $45e6
	ld [wBriefingBracketWidth], a ; $45e8
	ld a, $08 ; $45eb
	ld [wBriefingBracketHeight], a ; $45ed
	ld a, $20 ; $45f0
	ld [wBriefingBracketX], a ; $45f2
	ld a, $40 ; $45f5
	ld [wBriefingBracketY], a ; $45f7
	frame_task DrawBriefingTargetBrackets ; $45fa
	ld hl, Text_DebugTextDisplayTest ; $4602
	call DrawBriefingCaption ; $4605
	ld b, $02 ; $4608
	call DrawDiagramTargetOverlay ; $460a
	frame_task CycleDiagramTargetPalette ; $460d
	call WaitForInputBlinking ; $4615
	call ClearFrameTasks ; $4618
	frame_task UpdateAnimatedTilesTask_17 ; $461b
	ld b, $00 ; $4623
	call DrawDiagramTargetOverlay ; $4625
	ld hl, Text_DebugRacketTest ; $4628
	call DrawBriefingCaption ; $462b
	ld a, $70 ; $462e
	ld [wBriefingHandX], a ; $4630
	ld a, $20 ; $4633
	ld [wBriefingHandY], a ; $4635
	frame_task DrawBriefingPointingHand ; $4638
	ld b, $05 ; $4640
	call DrawDiagramTargetOverlay ; $4642
	frame_task CycleDiagramTargetPalette ; $4645
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
	ld bc, wBriefingTargetPalette_SIZE ; $4685
	call CopyMemoryBC ; $4688
	ldh a, [hVBlankCounter] ; $468b
	and $3c ; $468d
	srl a ; $468f
	srl a ; $4691
	add a ; $4693
	jr nc, .wrapIndex ; $4694
	ld a, $0c ; $4696
	dec a ; $4698
	jr .lookupColor ; $4699
.wrapIndex:
	rra ; $469b
	cp $0c ; $469c
	jr c, .lookupColor ; $469e
	xor a ; $46a0
.lookupColor:
	add a ; $46a1
	ld hl, DiagramTargetPaletteRamp_17 ; $46a2
	add_hl_a ; $46a5
	ld a, [hl+] ; $46aa
	ld d, [hl] ; $46ab
	ld e, a ; $46ac
	ld hl, wBriefingTargetPalette + 4 ; $46ad
	ld [hl], e ; $46b0
	inc hl ; $46b1
	ld [hl], d ; $46b2
	ld hl, wBriefingTargetPalette ; $46b3
	ld_bg_pals de, 2, 1 ; $46b6
	call LoadPaletteShadow ; $46b9
	pop_wram_bank ; $46bc
	ret ; $46c1
Unused_17_Palette:
	INCLUDE "data/engine/menus/briefing/Unused_17_Palette.asm" ; $46c2, 8 bytes (palettes)
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
	sprite_attr_tile OAM_BANK1, $00 ; $46f6
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
	sprite_attr_tile OAM_BANK1, $04 ; $4720
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
	sprite_tile_attr $6e, OAM_BANK1 | 1 ; $4747
	call QueueSprite ; $474b
	pop_wram_bank ; $474e
	ret ; $4753
DrawBriefingPointingHand:
	push_wram_bank WRAM_SCREEN ; $4754
	ld b, $09 ; $475d
	ld a, [wBriefingHandUnflipped] ; $475f
	cp $01 ; $4762
	jr z, .gotAttr ; $4764
	ld b, $29 ; $4766
.gotAttr:
	ld a, [wBriefingHandX] ; $4768
	ld d, a ; $476b
	ldh a, [hVBlankCounter] ; $476c
	and $10 ; $476e
	jr z, .maskClear ; $4770
	inc d ; $4772
.maskClear:
	ld a, [wBriefingHandY] ; $4773
	ld e, a ; $4776
	ld c, $60 ; $4777
	ld hl, BriefingPointingHandSpriteTemplate ; $4779
	call QueueSpriteTemplate ; $477c
	pop_wram_bank ; $477f
	ret ; $4784
BriefingPointingHandSpriteTemplate:
	; $4785, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
DrawBriefingCmdPrompt:
	push_wram_bank WRAM_SCREEN ; $478e
	ld a, [wBriefingCmdPrompt] ; $4797
	ld hl, BriefingCmdPromptTileTable ; $479a
	add_hl_a ; $479d
	ld c, [hl] ; $47a2
	ld hl, BriefingCmdPromptShortTemplate ; $47a3
	ld a, [wBriefingCmdPrompt] ; $47a6
	cp $06 ; $47a9
	jr nc, .gotTemplate ; $47ab
	ld hl, BriefingCmdPromptLongTemplate ; $47ad
.gotTemplate:
	ld a, [wBriefingCmdPromptX] ; $47b0
	ld d, a ; $47b3
	ld a, [wBriefingCmdPromptY] ; $47b4
	ld e, a ; $47b7
	ld b, OAM_BANK1 | 1 ; $47b8
	call QueueSpriteTemplate ; $47ba
	pop_wram_bank ; $47bd
	ret ; $47c2
BriefingCmdPromptTileTable:
	; $47c3, 10 bytes (bytes:10)
	db $08, $12, $1c, $36, $40, $4a, $26, $2c, $54, $5a ; 0x00
BriefingCmdPromptLongTemplate:
	; $47cd, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
BriefingCmdPromptShortTemplate:
	; $47e2, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
DrawBriefingPoleSprites:
	push_wram_bank WRAM_SCREEN ; $47ef
	ld a, [wBriefingPole1X] ; $47f8
	ld d, a ; $47fb
	ld a, [wBriefingPole1Y] ; $47fc
	ld e, a ; $47ff
	sprite_tile_attr $6a, OAM_BANK1 | 1 ; $4800
	call QueueSprite ; $4804
	ld a, [wBriefingPole2X] ; $4807
	ld d, a ; $480a
	ld a, [wBriefingPole2Y] ; $480b
	ld e, a ; $480e
	sprite_tile_attr $6a, OAM_BANK1 | 1 ; $480f
	call QueueSprite ; $4813
	pop_wram_bank ; $4816
	ret ; $481b
DrawBriefingDownArrow:
	push_wram_bank WRAM_SCREEN ; $481c
	ld c, $70 ; $4825
	ld b, $09 ; $4827
	ld a, [wBriefingDownArrowUnflipped] ; $4829
	cp $01 ; $482c
	jr z, .gotAttr ; $482e
	ld b, OAM_BANK1 | OAM_YFLIP | 1 ; $4830
.gotAttr:
	ld a, [wBriefingDownArrowX] ; $4832
	ld d, a ; $4835
	ld a, [wBriefingDownArrowY] ; $4836
	ld e, a ; $4839
	call QueueSprite ; $483a
	pop_wram_bank ; $483d
	ret ; $4842
