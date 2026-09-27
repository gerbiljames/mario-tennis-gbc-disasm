GetPointAheadOfActor:
	push af ; $51cf
	push bc ; $51d0
	ld b, a ; $51d1
	wram_bank WRAM_ACTORS ; $51d2
	ld a, b ; $51d8
	ld c, l ; $51d9
	ld b, h ; $51da
	ld hl, ACTORF_DRAWN_FACING ; $51db
	add hl, bc ; $51de
	add [hl] ; $51df
	ld l, e ; $51e0
	ld h, d ; $51e1
	call VectorFromLengthAndAngle ; $51e2
	push hl ; $51e5
	ld hl, ACTORF_Y ; $51e6
	add hl, bc ; $51e9
	ld a, [hl+] ; $51ea
	ld h, [hl] ; $51eb
	ld l, a ; $51ec
	add hl, de ; $51ed
	ld e, l ; $51ee
	ld d, h ; $51ef
	pop hl ; $51f0
	push de ; $51f1
	ld e, l ; $51f2
	ld d, h ; $51f3
	ld hl, ACTORF_X ; $51f4
	add hl, bc ; $51f7
	ld a, [hl+] ; $51f8
	ld h, [hl] ; $51f9
	ld l, a ; $51fa
	add hl, de ; $51fb
	pop de ; $51fc
	pop bc ; $51fd
	pop af ; $51fe
	ret ; $51ff
GetFacingTileInteractionId:
	push bc ; $5200
	push de ; $5201
	push hl ; $5202
	ld hl, wActors ; $5203
	ld de, $01c0 ; $5206
	ld a, $00 ; $5209
	call GetPointAheadOfActor ; $520b
	ld e, d ; $520e
	ld d, h ; $520f
	farcall ReadBehaviorMapCell ; $5210
	ld d, a ; $5213
	ld e, $00 ; $5214
	and $0f ; $5216
	cp $08 ; $5218
	jr nz, .done ; $521a
	ld a, d ; $521c
	swap a ; $521d
	and $0f ; $521f
	ld e, a ; $5221
.done:
	ld a, e ; $5222
	pop hl ; $5223
	pop de ; $5224
	pop bc ; $5225
	ret ; $5226
FindActorFacingPlayer:
	push bc ; $5227
	push de ; $5228
	push hl ; $5229
	wram_bank WRAM_ACTORS ; $522a
	farcall BuildActorQueryList ; $5230
	ld hl, wActors ; $5233
	ld de, $01c0 ; $5236
	ld a, $00 ; $5239
	call GetPointAheadOfActor ; $523b
	push de ; $523e
	ld e, d ; $523f
	ld d, h ; $5240
	farcall ReadBehaviorMapCell ; $5241
	and $0f ; $5244
	pop de ; $5246
	cp $0c ; $5247
	jr nz, .query ; $5249
	ld hl, wActors ; $524b
	ld de, $03c0 ; $524e
	ld a, $00 ; $5251
	call GetPointAheadOfActor ; $5253
.query:
	farcall FindActorAtPoint ; $5256
	and a ; $5259
	jr nz, .done ; $525a
	ld hl, wActors ; $525c
	ld de, $0180 ; $525f
	ld a, $f0 ; $5262
	call GetPointAheadOfActor ; $5264
	farcall FindActorAtPoint ; $5267
	and a ; $526a
	jr nz, .done ; $526b
	ld hl, wActors ; $526d
	ld de, $0180 ; $5270
	ld a, $10 ; $5273
	call GetPointAheadOfActor ; $5275
	farcall FindActorAtPoint ; $5278
.done:
	pop hl ; $527b
	pop de ; $527c
	pop bc ; $527d
	ret ; $527e
SaveStoryReturnPoint:
	push af ; $527f
	push bc ; $5280
	push de ; $5281
	push hl ; $5282
	ld a, b ; $5283
	cp $ff ; $5284
	jr z, .fromCurrent ; $5286
	ld hl, wStoryReturnLocation ; $5288
	ld [hl], b ; $528b
	ld hl, wStoryReturnEntryPoint ; $528c
	ld [hl], c ; $528f
	jr .done ; $5290
.fromCurrent:
	ld a, [wStoryModeCurrentLocation] ; $5292
	ld [wStoryReturnLocation], a ; $5295
	ld hl, wStoryReturnEntryPoint ; $5298
	ld [hl], $ff ; $529b
	ld hl, wStoryModePlayersXPosition ; $529d
	ld de, wStoryReturnPosition ; $52a0
	ld bc, $0005 ; $52a3
	call CopyMemoryBC ; $52a6
.done:
	pop hl ; $52a9
	pop de ; $52aa
	pop bc ; $52ab
	pop af ; $52ac
	ret ; $52ad
RestoreStoryReturnPoint:
	push af ; $52ae
	push bc ; $52af
	push de ; $52b0
	push hl ; $52b1
	ld a, [wStoryReturnEntryPoint] ; $52b2
	cp $ff ; $52b5
	jr z, .restorePosition ; $52b7
	ld a, [wStoryReturnLocation] ; $52b9
	ld [wStoryModeCurrentLocation], a ; $52bc
	ld a, [wStoryReturnEntryPoint] ; $52bf
	ld [wStoryModeEntryPoint], a ; $52c2
	ld a, $ff ; $52c5
	ld [wUnusedExitTriggerIdMirror], a ; $52c7
	ld [wStoryModeExitTriggerRequest], a ; $52ca
	jr .done ; $52cd
.restorePosition:
	ld hl, wStoryReturnPosition ; $52cf
	ld de, wStoryModeSpawnPosition ; $52d2
	ld bc, $0005 ; $52d5
	call CopyMemoryBC ; $52d8
	ld a, [wStoryReturnLocation] ; $52db
	ld [wStoryModeCurrentLocation], a ; $52de
	ld a, STORYENTRY_NONE ; $52e1
	ld [wStoryModeEntryPoint], a ; $52e3
	ld a, $ff ; $52e6
	ld [wUnusedExitTriggerIdMirror], a ; $52e8
	ld a, $ff ; $52eb
	ld [wStoryModeExitTriggerRequest], a ; $52ed
.done:
	pop hl ; $52f0
	pop de ; $52f1
	pop bc ; $52f2
	pop af ; $52f3
	ret ; $52f4
ShowLocationNamePopup:
	push af ; $52f5
	push bc ; $52f6
	push de ; $52f7
	push hl ; $52f8
	ldh a, [hWramBank] ; $52f9
	push af ; $52fb
	call WaitPlayerMoveDone ; $52fc
	wram_bank WRAM_TEXT ; $52ff
	ld a, [wMessageSpeed] ; $5305
	set 7, a ; $5308
	ld [wMessageSpeed], a ; $530a
	ld a, $83 ; $530d
	farcall ShowSpeakerDialogueRestoreBG ; $530f
	ld b, $50 ; $5312
.waitLoop:
	call AdvanceFrame ; $5314
	ldh a, [hPlayerInputFlags] ; $5317
	and a ; $5319
	jr nz, .close ; $531a
	dec b ; $531c
	jr nz, .waitLoop ; $531d
.close:
	farcall CloseActiveDialogueWindow ; $531f
	wram_bank WRAM_TEXT ; $5322
	ld hl, wMessageSpeed ; $5328
	res 7, [hl] ; $532b
	pop_wram_bank ; $532d
	pop hl ; $5332
	pop de ; $5333
	pop bc ; $5334
	pop af ; $5335
	ret ; $5336
LoadStoryObjPalettes:
	ld hl, StoryObjPalettes ; $5337
	lb de, $0b, $05 ; $533a palette index, count
	call LoadPaletteShadow ; $533d
	ret ; $5340
StoryObjPalettes:
	INCLUDE "data/bank_00a/StoryObjPalettes.asm" ; $5341, 40 bytes (palettes)
GetTileTriggerAtPlayer:
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld bc, wActors ; $536c
	ld hl, ACTORF_X + 1 ; $536f
	add hl, bc ; $5372
	ld d, [hl] ; $5373
	ld hl, ACTORF_Y + 1 ; $5374
	add hl, bc ; $5377
	ld e, [hl] ; $5378
	farcall ReadBehaviorMapCell ; $5379
	ld e, a ; $537c
	ld d, $00 ; $537d
	and $0f ; $537f
	cp $01 ; $5381
	jr nz, .done ; $5383
	ld a, e ; $5385
	swap a ; $5386
	and $0f ; $5388
	ld d, a ; $538a
	ld hl, wMapTileTriggersPtr ; $538b
	ld a, [hl+] ; $538e
	ld h, [hl] ; $538f
	ld l, a ; $5390
	ld a, [wStoryLocationBank] ; $5391
	call FindStoryScriptEntry ; $5394
	ld a, h ; $5397
	or l ; $5398
	jr nz, .done ; $5399
	ld d, $00 ; $539b
.done:
	ld a, d ; $539d
	pop hl ; $539e
	pop de ; $539f
	pop bc ; $53a0
	ret ; $53a1
; Bank $0a's copy of EvalFlagCondition ($04:$4c49), identical instruction for instruction: the shared story include assembled into this bank too. Nothing calls this copy; FindStoryScriptEntry farcalls the bank $04 one.
UnusedEvalFlagCondition_0a:
	ld a, e ; $53a2
	or d ; $53a3
	ret z ; $53a4
	bit 7, d ; $53a5
	jr nz, .negated ; $53a7
	call TestGameFlag ; $53a9
	ret ; $53ac
.negated:
	res 7, d ; $53ad
	call TestGameFlag ; $53af
	jr z, .true ; $53b2
	xor a ; $53b4
	ret ; $53b5
.true:
	xor a ; $53b6
	inc a ; $53b7
	ret ; $53b8
FacingMaskTable_0a:
	; $53b9, 4 bytes (enum:FACEMASK:4)
	db FACEMASK_RIGHT, FACEMASK_DOWN, FACEMASK_LEFT, FACEMASK_UP ; 0x00
CheckTriggerFacingMask:
	push bc ; $53bd
	push hl ; $53be
	wram_bank WRAM_ACTORS ; $53bf
	ld c, $01 ; $53c5
	ld a, b ; $53c7
	cp $ff ; $53c8
	jr z, .done ; $53ca
	ld a, [wPlayerMoveAngle] ; $53cc
	rlca ; $53cf
	rlca ; $53d0
	and $03 ; $53d1
	ld_hl_indexed FacingMaskTable_0a ; $53d3
	ld a, [hl] ; $53da
	and b ; $53db
	jr nz, .done ; $53dc
	ld c, $00 ; $53de
.done:
	ld a, c ; $53e0
	pop hl ; $53e1
	pop bc ; $53e2
	ret ; $53e3
FindStoryScriptEntry:
	push af ; $53e4
	push bc ; $53e5
	push de ; $53e6
.searchLoop:
	ld a, [wStoryLocationBank] ; $53e7
	call FarReadWord ; $53ea
	ld a, c ; $53ed
	cp $ff ; $53ee
	jr z, .notFound ; $53f0
	cp d ; $53f2
	jr nz, .nextEntry ; $53f3
	call CheckTriggerFacingMask ; $53f5
	and a ; $53f8
	jr z, .nextEntry ; $53f9
	inc hl ; $53fb
	inc hl ; $53fc
	ld a, [wStoryLocationBank] ; $53fd
	call FarReadWord ; $5400
	dec hl ; $5403
	dec hl ; $5404
	push de ; $5405
	ld e, c ; $5406
	ld d, b ; $5407
	farcall EvalFlagCondition ; $5408
	pop de ; $540b
	jr nz, .nextEntry ; $540c
	jr .done ; $540e
.nextEntry:
	ld bc, $0008 ; $5410
	add hl, bc ; $5413
	jr .searchLoop ; $5414
.notFound:
	ld hl, $0000 ; $5416
.done:
	pop de ; $5419
	pop bc ; $541a
	pop af ; $541b
	ret ; $541c
RunStoryScriptOrDialogue:
	push af ; $541d
	push bc ; $541e
	ld b, a ; $541f
	push de ; $5420
	push hl ; $5421
	ldh a, [hWramBank] ; $5422
	push af ; $5424
	ld a, $01 ; $5425
	ld [wStoryScriptRan], a ; $5427
	ld a, h ; $542a
	or l ; $542b
	jr z, .done ; $542c
	ld a, h ; $542e
	and $c0 ; $542f
	jr nz, .runScript ; $5431
	call WaitPlayerMoveDone ; $5433
	ld a, b ; $5436
	farcall ShowSpeakerDialogue ; $5437
	jr .done ; $543a
.runScript:
	farcall BeginCutsceneScriptMode ; $543c
	push hl ; $543f
	wram_bank WRAM_ACTORS ; $5440
	ld hl, wActors + ACTORF_STATUS ; $5446
	res 0, [hl] ; $5449
	ld hl, wActors + ACTORF_HEADING ; $544b
	ld a, [wPlayerMoveAngle] ; $544e
	ld [hl], a ; $5451
	pop hl ; $5452
	ld a, [wStoryLocationBank] ; $5453
	call CallHLInBankA ; $5456
	farcall EndCutsceneScriptMode ; $5459
.done:
	pop_wram_bank ; $545c
	pop hl ; $5461
	pop de ; $5462
	pop bc ; $5463
	pop af ; $5464
	ret ; $5465
InitLocationActors:
	push af ; $5466
	push bc ; $5467
	push de ; $5468
	push hl ; $5469
	push af ; $546a
	push hl ; $546b
	wram_bank WRAM_ACTORS ; $546c
	farcall InitActorEngine ; $5472
	ld hl, wStoryModeSpawnPosition + 4 ; $5475
	ld c, [hl] ; $5478
	ld hl, wStoryModeSpawnPosition + 2 ; $5479
	ld a, [hl+] ; $547c
	ld d, [hl] ; $547d
	ld e, a ; $547e
	ld hl, wStoryModeSpawnPosition ; $547f
	ld a, [hl+] ; $5482
	ld h, [hl] ; $5483
	ld l, a ; $5484
	farcall SpawnMainCharacterActor ; $5485
	pop hl ; $5488
	pop af ; $5489
	farcall SpawnCompanionActor ; $548a
	farcall SpawnActorsFromList ; $548d
	pop hl ; $5490
	pop de ; $5491
	pop bc ; $5492
	pop af ; $5493
	ret ; $5494
RunLocationInitScript:
	push af ; $5495
	push bc ; $5496
	push de ; $5497
	push hl ; $5498
	ldh a, [hWramBank] ; $5499
	push af ; $549b
	ld a, $90 ; $549c
	ldh [rWY], a ; $549e
	ld hl, wMapInitScriptPtr ; $54a0
	ld a, [hl+] ; $54a3
	ld h, [hl] ; $54a4
	ld l, a ; $54a5
	ld a, $00 ; $54a6
	call RunStoryScriptOrDialogue ; $54a8
	pop_wram_bank ; $54ab
	pop hl ; $54b0
	pop de ; $54b1
	pop bc ; $54b2
	pop af ; $54b3
	ret ; $54b4
RunNpcInteraction:
	ld [wUnusedStoryScriptId], a ; $54b5
	cp $02 ; $54b8
	jp z, .done ; $54ba
	push af ; $54bd
	push bc ; $54be
	push de ; $54bf
	push hl ; $54c0
	ld d, a ; $54c1
	ld hl, wMapNpcScriptsPtr ; $54c2
	ld a, [hl+] ; $54c5
	ld h, [hl] ; $54c6
	ld l, a ; $54c7
	call FindStoryScriptEntry ; $54c8
	ld a, h ; $54cb
	or l ; $54cc
	jp z, .checkRespawn ; $54cd
	ld a, [wStoryLocationBank] ; $54d0
	ld de, wStoryMapRecord ; $54d3
	ld bc, $0008 ; $54d6
	call FarCopyBytes ; $54d9
	ld hl, wStoryMapRecord + 6 ; $54dc
	ld b, [hl] ; $54df
	wram_bank WRAM_ACTORS ; $54e0
	ld hl, wStoryMapRecord ; $54e6
	ld a, [hl] ; $54e9
	call GetActorStateAddr ; $54ea
	ld e, l ; $54ed
	ld d, h ; $54ee
	ld hl, $0019 ; $54ef
	add hl, de ; $54f2
	ld a, [hl] ; $54f3
	ld [wStoryScriptSavedActorBusy], a ; $54f4
	ld a, $01 ; $54f7
	ld [hl], a ; $54f9
	ld a, b ; $54fa
	and $08 ; $54fb
	jr z, .applyFlags ; $54fd
	ld hl, $002e ; $54ff
	add hl, de ; $5502
	ld a, [hl] ; $5503
	ld [wStoryScriptSavedActorAnim], a ; $5504
	ld a, $01 ; $5507
	push bc ; $5509
	push de ; $550a
	ld c, e ; $550b
	ld b, d ; $550c
	ld d, $01 ; $550d
	farcall SetActorAnimationChecked ; $550f
	pop de ; $5512
	pop bc ; $5513
.applyFlags:
	ld a, b ; $5514
	and $10 ; $5515
	jr z, .faceThePlayer ; $5517
	ld hl, $0005 ; $5519
	add hl, de ; $551c
	set 0, [hl] ; $551d
	set 1, [hl] ; $551f
.faceThePlayer:
	bit 0, b ; $5521
	jr z, .runScript ; $5523
	ld hl, $0014 ; $5525
	add hl, de ; $5528
	ld c, [hl] ; $5529
	ld a, [wPlayerMoveAngle] ; $552a
	add $80 ; $552d
	ld [hl], a ; $552f
.runScript:
	push de ; $5530
	ld hl, wStoryMapRecord + 4 ; $5531
	ld a, [hl+] ; $5534
	ld h, [hl] ; $5535
	ld l, a ; $5536
	ld a, [wStoryMapRecord] ; $5537
	call RunStoryScriptOrDialogue ; $553a
	pop de ; $553d
	bit 1, b ; $553e
	jr z, .restoreFlags ; $5540
	ld hl, $0014 ; $5542
	add hl, de ; $5545
	ld [hl], c ; $5546
.restoreFlags:
	ld a, b ; $5547
	and $10 ; $5548
	jr z, .restoreAnim ; $554a
	ld hl, $0005 ; $554c
	add hl, de ; $554f
	res 0, [hl] ; $5550
	res 1, [hl] ; $5552
.restoreAnim:
	ld a, b ; $5554
	and $08 ; $5555
	jr z, .clearBusy ; $5557
	push bc ; $5559
	push de ; $555a
	ld c, e ; $555b
	ld b, d ; $555c
	ld a, [wStoryScriptSavedActorAnim] ; $555d
	ld d, a ; $5560
	farcall SetActorAnimationChecked ; $5561
	pop de ; $5564
	pop bc ; $5565
.clearBusy:
	ld hl, $0019 ; $5566
	add hl, de ; $5569
	ld a, [wStoryScriptSavedActorBusy] ; $556a
	ld [hl], a ; $556d
.checkRespawn:
	pop hl ; $556e
	pop de ; $556f
	pop bc ; $5570
	pop af ; $5571
	ret ; $5572
.done:
	ret ; $5573
