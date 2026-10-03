RetStub:
	ret ; $03ae
ClearMemory16:
	xor a ; $03af
.loop:
	ld [hl+], a ; $03b0
	ld [hl+], a ; $03b1
	ld [hl+], a ; $03b2
	ld [hl+], a ; $03b3
	ld [hl+], a ; $03b4
	ld [hl+], a ; $03b5
	ld [hl+], a ; $03b6
	ld [hl+], a ; $03b7
	ld [hl+], a ; $03b8
	ld [hl+], a ; $03b9
	ld [hl+], a ; $03ba
	ld [hl+], a ; $03bb
	ld [hl+], a ; $03bc
	ld [hl+], a ; $03bd
	ld [hl+], a ; $03be
	ld [hl+], a ; $03bf
	dec c ; $03c0
	jr nz, .loop ; $03c1
	ret ; $03c3
ClearMemoryBC16:
	xor a ; $03c4
	ld [hl+], a ; $03c5
	ld [hl+], a ; $03c6
	ld [hl+], a ; $03c7
	ld [hl+], a ; $03c8
	ld [hl+], a ; $03c9
	ld [hl+], a ; $03ca
	ld [hl+], a ; $03cb
	ld [hl+], a ; $03cc
	ld [hl+], a ; $03cd
	ld [hl+], a ; $03ce
	ld [hl+], a ; $03cf
	ld [hl+], a ; $03d0
	ld [hl+], a ; $03d1
	ld [hl+], a ; $03d2
	ld [hl+], a ; $03d3
	ld [hl+], a ; $03d4
	dec bc ; $03d5
	ld a, b ; $03d6
	or c ; $03d7
	jr nz, ClearMemoryBC16 ; $03d8
	ret ; $03da
CopyMemoryBC:
	inc c ; $03db
	dec c ; $03dc
	jr z, .loop ; $03dd
	inc b ; $03df
.loop:
	ld a, [hl+] ; $03e0
	ld [de], a ; $03e1
	inc de ; $03e2
	dec c ; $03e3
	jr nz, .loop ; $03e4
	dec b ; $03e6
	jr nz, .loop ; $03e7
	ret ; $03e9
Unused_00_CopyMemoryReverseBC:
	ld a, [hl-] ; $03ea
	ld [de], a ; $03eb
	dec de ; $03ec
	dec bc ; $03ed
	ld a, b ; $03ee
	or c ; $03ef
	jr nz, Unused_00_CopyMemoryReverseBC ; $03f0
	ret ; $03f2
CopyMemoryFast:
	ld a, $0f ; $03f3
	and e ; $03f5
	jr z, .copyAlignedLoop ; $03f6
.copyLoop:
	ld a, [hl+] ; $03f8
	ld [de], a ; $03f9
	inc de ; $03fa
	ld a, [hl+] ; $03fb
	ld [de], a ; $03fc
	inc de ; $03fd
	ld a, [hl+] ; $03fe
	ld [de], a ; $03ff
	inc de ; $0400
	ld a, [hl+] ; $0401
	ld [de], a ; $0402
	inc de ; $0403
	ld a, [hl+] ; $0404
	ld [de], a ; $0405
	inc de ; $0406
	ld a, [hl+] ; $0407
	ld [de], a ; $0408
	inc de ; $0409
	ld a, [hl+] ; $040a
	ld [de], a ; $040b
	inc de ; $040c
	ld a, [hl+] ; $040d
	ld [de], a ; $040e
	inc de ; $040f
	ld a, [hl+] ; $0410
	ld [de], a ; $0411
	inc de ; $0412
	ld a, [hl+] ; $0413
	ld [de], a ; $0414
	inc de ; $0415
	ld a, [hl+] ; $0416
	ld [de], a ; $0417
	inc de ; $0418
	ld a, [hl+] ; $0419
	ld [de], a ; $041a
	inc de ; $041b
	ld a, [hl+] ; $041c
	ld [de], a ; $041d
	inc de ; $041e
	ld a, [hl+] ; $041f
	ld [de], a ; $0420
	inc de ; $0421
	ld a, [hl+] ; $0422
	ld [de], a ; $0423
	inc de ; $0424
	ld a, [hl+] ; $0425
	ld [de], a ; $0426
	inc de ; $0427
	dec c ; $0428
	jr nz, .copyLoop ; $0429
	ret ; $042b
.copyAlignedLoop:
	ld a, [hl+] ; $042c
	ld [de], a ; $042d
	inc e ; $042e
	ld a, [hl+] ; $042f
	ld [de], a ; $0430
	inc e ; $0431
	ld a, [hl+] ; $0432
	ld [de], a ; $0433
	inc e ; $0434
	ld a, [hl+] ; $0435
	ld [de], a ; $0436
	inc e ; $0437
	ld a, [hl+] ; $0438
	ld [de], a ; $0439
	inc e ; $043a
	ld a, [hl+] ; $043b
	ld [de], a ; $043c
	inc e ; $043d
	ld a, [hl+] ; $043e
	ld [de], a ; $043f
	inc e ; $0440
	ld a, [hl+] ; $0441
	ld [de], a ; $0442
	inc e ; $0443
	ld a, [hl+] ; $0444
	ld [de], a ; $0445
	inc e ; $0446
	ld a, [hl+] ; $0447
	ld [de], a ; $0448
	inc e ; $0449
	ld a, [hl+] ; $044a
	ld [de], a ; $044b
	inc e ; $044c
	ld a, [hl+] ; $044d
	ld [de], a ; $044e
	inc e ; $044f
	ld a, [hl+] ; $0450
	ld [de], a ; $0451
	inc e ; $0452
	ld a, [hl+] ; $0453
	ld [de], a ; $0454
	inc e ; $0455
	ld a, [hl+] ; $0456
	ld [de], a ; $0457
	inc e ; $0458
	ld a, [hl+] ; $0459
	ld [de], a ; $045a
	inc de ; $045b
	dec c ; $045c
	jr nz, .copyAlignedLoop ; $045d
	ret ; $045f
Unused_00_FillMemoryCFast:
	ld [hl+], a ; $0460
	dec c ; $0461
	jr nz, Unused_00_FillMemoryCFast ; $0462
	ret ; $0464
ClearVRAMCopyQueue:
	ld hl, wVRAMCopyQueue ; $0465
	ld c, wVRAMCopyQueue_SIZE / 16 ; $0468
	jp ClearMemory16 ; $046a
QueueVRAMCopyFromBank:
	ldh a, [hRomBank] ; $046d
	push af ; $046f
	ld a, b ; $0470
	ldh [hRomBank], a ; $0471
	ld [rROMB0], a ; $0473
	call QueueVRAMCopy ; $0476
	pop af ; $0479
	ldh [hRomBank], a ; $047a
	ld [rROMB0], a ; $047c
	ret ; $047f
; The game's only path to VRAM (no code writes $8xxx directly). hl = source,
; de = destination, c = length in 16-byte blocks.
;
; The VRAM bank rides in bit 13 of the destination, so $9800 + VRAM_BANK1 is
; $9800 in bank 1. With the LCD off the transfer runs at once as a GDMA; with
; it on the request goes into wVRAMCopyQueue (ten slots) for
; ProcessVRAMCopyQueues to run in VBlank. On overflow it sets hVRAMQueueDirty
; and, in debug step mode, plays a sound.
QueueVRAMCopy:
	ldh a, [rLCDC] ; $0480
	add a ; $0482
	jr c, .queue ; $0483
	xor a ; $0485
	bit 5, d ; $0486
	jr z, .setVramBank ; $0488
	res 5, d ; $048a
	inc a ; $048c
.setVramBank:
	ldh [rVBK], a ; $048d
	jp StartVRAMDMAFromHL ; $048f
.queue:
	xor a ; $0492
	ldh [hVRAMQueueDirty], a ; $0493
	ld a, c ; $0495
	dec a ; $0496
	push af ; $0497
	push hl ; $0498
	ld hl, wVRAMCopyQueue ; $0499
	ld l, $a0 ; $049c
	ld a, [hl] ; $049e
	or a ; $049f
	jr z, .fillSlot ; $04a0
	ld l, $a8 ; $04a2
	ld a, [hl] ; $04a4
	or a ; $04a5
	jr z, .fillSlot ; $04a6
	ld l, $b0 ; $04a8
	ld a, [hl] ; $04aa
	or a ; $04ab
	jr z, .fillSlot ; $04ac
	ld l, $b8 ; $04ae
	ld a, [hl] ; $04b0
	or a ; $04b1
	jr z, .fillSlot ; $04b2
	ld l, $c0 ; $04b4
	ld a, [hl] ; $04b6
	or a ; $04b7
	jr z, .fillSlot ; $04b8
	ld l, $c8 ; $04ba
	ld a, [hl] ; $04bc
	or a ; $04bd
	jr z, .fillSlot ; $04be
	ld l, $d0 ; $04c0
	ld a, [hl] ; $04c2
	or a ; $04c3
	jr z, .fillSlot ; $04c4
	ld l, $d8 ; $04c6
	ld a, [hl] ; $04c8
	or a ; $04c9
	jr z, .fillSlot ; $04ca
	ld l, $e0 ; $04cc
	ld a, [hl] ; $04ce
	or a ; $04cf
	jr z, .fillSlot ; $04d0
	ld l, $e8 ; $04d2
	ld a, [hl] ; $04d4
	or a ; $04d5
	jr z, .fillSlot ; $04d6
	ld a, $01 ; $04d8
	ldh [hVRAMQueueDirty], a ; $04da
	ldh a, [hDebugStepMode] ; $04dc
	or a ; $04de
	jr z, .queueFull ; $04df
	sound SFX_DEBUG_ALARM ; $04e1
.queueFull:
	pop hl ; $04e3
	pop af ; $04e4
	xor a ; $04e5
	ret ; $04e6
.fillSlot:
	ldh a, [hRomBank] ; $04e7
	ld [hl+], a ; $04e9
	ldh a, [hWramBank] ; $04ea
	ld [hl+], a ; $04ec
	pop bc ; $04ed
	ld [hl], b ; $04ee
	inc l ; $04ef
	ld [hl], c ; $04f0
	inc l ; $04f1
	ld a, $20 ; $04f2
	and d ; $04f4
	jr z, .storeVramBank ; $04f5
	ld a, $01 ; $04f7
.storeVramBank:
	ld [hl+], a ; $04f9
	res 5, d ; $04fa
	ld [hl], d ; $04fc
	inc l ; $04fd
	ld [hl], e ; $04fe
	inc l ; $04ff
	pop af ; $0500
	ld [hl], a ; $0501
	ld a, $01 ; $0502
	ldh [hVRAMQueueDirty], a ; $0504
	ret ; $0506
QueueBGTileWrite:
	xor a ; $0507
	ldh [hVRAMQueueDirty], a ; $0508
	push hl ; $050a
	ld hl, wTileWriteQueue ; $050b
	ld c, $10 ; $050e
.findSlot:
	ld a, [hl] ; $0510
	or a ; $0511
	jr z, .fillSlot ; $0512
	inc hl ; $0514
	inc hl ; $0515
	inc hl ; $0516
	inc hl ; $0517
	dec c ; $0518
	jr nz, .findSlot ; $0519
	pop hl ; $051b
	ld a, $01 ; $051c
	ldh [hVRAMQueueDirty], a ; $051e
	ret ; $0520
.fillSlot:
	pop bc ; $0521
	ld [hl], d ; $0522
	inc hl ; $0523
	ld [hl], e ; $0524
	inc hl ; $0525
	ld [hl], c ; $0526
	inc hl ; $0527
	ld [hl], b ; $0528
	ld a, $01 ; $0529
	ldh [hVRAMQueueDirty], a ; $052b
	ret ; $052d
; Drains wVRAMCopyQueue in VBlank. A slot is the five CGB VDMA register values
; ($ff51-$ff55; the $ff55 write starts the transfer) plus the source's banks.
; Slot +$00 doubles as the in-use flag and is cleared as the slot is consumed.
ProcessVRAMCopyQueues:
	ldh a, [hVRAMQueueDirty] ; $052e
	or a ; $0530
	ret z ; $0531
	ld hl, wVRAMCopyQueue ; $0532
	ld c, $0a ; $0535
	ldh a, [hWramBank] ; $0537
	ld e, a ; $0539
	ldh a, [hRomBank] ; $053a
	ld d, a ; $053c
	push de ; $053d
	ld d, $ff ; $053e
.loop:
	ld a, [hl] ; $0540
	or a ; $0541
	jr z, .loopB ; $0542
	ldh [hRomBank], a ; $0544
	ld [rROMB0], a ; $0546
	xor a ; $0549
	ld [hl+], a ; $054a
	ld a, [hl+] ; $054b
	wram_bank ; $054c
	ld e, $51 ; $0550
	ld a, [hl+] ; $0552
	ld [de], a ; $0553
	inc e ; $0554
	ld a, [hl+] ; $0555
	ld [de], a ; $0556
	inc e ; $0557
	ld a, [hl+] ; $0558
	ldh [rVBK], a ; $0559
	ld a, [hl+] ; $055b
	ld [de], a ; $055c
	inc e ; $055d
	ld a, [hl+] ; $055e
	ld [de], a ; $055f
	inc e ; $0560
	ld a, [hl+] ; $0561
	ld [de], a ; $0562
	dec c ; $0563
	jr nz, .loop ; $0564
.loopB:
	pop de ; $0566
	ld a, e ; $0567
	wram_bank ; $0568
	ld a, d ; $056c
	ldh [hRomBank], a ; $056d
	ld [rROMB0], a ; $056f
	ld hl, wTileWriteQueue ; $0572
	ld c, $10 ; $0575
.loop2:
	ld a, [hl] ; $0577
	or a ; $0578
	jr z, .done ; $0579
	push bc ; $057b
	ld d, a ; $057c
	xor a ; $057d
	ld [hl+], a ; $057e
	ld e, [hl] ; $057f
	inc l ; $0580
	ld c, [hl] ; $0581
	inc l ; $0582
	ld b, [hl] ; $0583
	inc l ; $0584
	xor a ; $0585
	ldh [rVBK], a ; $0586
	ld a, c ; $0588
	ld [de], a ; $0589
	ld a, $01 ; $058a
	ldh [rVBK], a ; $058c
	ld a, b ; $058e
	ld [de], a ; $058f
	pop bc ; $0590
	dec c ; $0591
	jr nz, .loop2 ; $0592
.done:
	ret ; $0594
	dec c ; $0595
	jr z, .loopB ; $0596
	ld a, c ; $0598
	add a ; $0599
	add a ; $059a
	add a ; $059b
	ld c, a ; $059c
	ld a, l ; $059d
	add $08 ; $059e
	and $f8 ; $05a0
	ld l, a ; $05a2
	ld de, wVRAMCopyQueue ; $05a3
.loop3:
	ld a, [hl+] ; $05a6
	ld [de], a ; $05a7
	inc e ; $05a8
	dec c ; $05a9
	jr nz, .loop3 ; $05aa
	xor a ; $05ac
	ld [de], a ; $05ad
	jr .loopB ; $05ae
LoadPaletteShadow:
	ldh a, [hFadedOut] ; $05b0
	and a ; $05b2
	jr nz, LoadPalettesMasterOnly ; $05b3
LoadPalettesImmediate:
	push de ; $05b5
	ld a, e ; $05b6
	add a ; $05b7
	add a ; $05b8
	ld c, a ; $05b9
	ld a, d ; $05ba
	add a ; $05bb
	add a ; $05bc
	add a ; $05bd
	ld e, a ; $05be
	ld d, $c1 ; $05bf
.copyLoop:
	ld a, [hl+] ; $05c1
	ld [de], a ; $05c2
	inc d ; $05c3
	ld [de], a ; $05c4
	inc e ; $05c5
	ld a, [hl+] ; $05c6
	ld [de], a ; $05c7
	dec d ; $05c8
	ld [de], a ; $05c9
	inc e ; $05ca
	dec c ; $05cb
	jr nz, .copyLoop ; $05cc
	ld hl, hPaletteDirtyFlags ; $05ce
	pop de ; $05d1
	bit 3, d ; $05d2
	jr nz, .checkRange ; $05d4
	set 0, [hl] ; $05d6
.checkRange:
	ld a, e ; $05d8
	add d ; $05d9
	cp $09 ; $05da
	jr c, .done ; $05dc
	set 1, [hl] ; $05de
.done:
	ret ; $05e0
