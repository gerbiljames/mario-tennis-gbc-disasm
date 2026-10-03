Unused_00_GetScrollBufferAddr:
	ld a, [wCameraY + 1] ; $22f6
	add c ; $22f9
	and $7f ; $22fa
	ld h, $00 ; $22fc
	ld l, a ; $22fe
	add hl, hl ; $22ff
	add hl, hl ; $2300
	add hl, hl ; $2301
	add hl, hl ; $2302
	add hl, hl ; $2303
	ld a, [wCameraX + 1] ; $2304
	add b ; $2307
	and $1f ; $2308
	ld d, $00 ; $230a
	ld e, a ; $230c
	add hl, de ; $230d
	ld de, wMapBuffer64 ; $230e
	add hl, de ; $2311
	ret ; $2312
Unused_00_BlitBGStrip:
	ld a, [wCameraY + 1] ; $2313
	add c ; $2316
	and $1f ; $2317
	ld h, $00 ; $2319
	ld l, a ; $231b
	add hl, hl ; $231c
	add hl, hl ; $231d
	add hl, hl ; $231e
	add hl, hl ; $231f
	add hl, hl ; $2320
	ld de, vBGMap0 ; $2321
	add hl, de ; $2324
	ld a, l ; $2325
	ld [wBGRowBlitDest], a ; $2326
	ld a, h ; $2329
	ld [wBGRowBlitDest + 1], a ; $232a
	ld a, [wCameraX + 1] ; $232d
	add b ; $2330
	and $1f ; $2331
	ld h, $00 ; $2333
	ld l, a ; $2335
	ld de, wBGRowBlitAttrs ; $2336
	add hl, de ; $2339
	push hl ; $233a
	call Unused_00_GetScrollBufferAddr ; $233b
	pop de ; $233e
	push hl ; $233f
	wram_bank WRAM_COURT_PLANES ; $2340
	ld c, $20 ; $2346
.loop:
	ld a, [hl+] ; $2348
	ld [de], a ; $2349
	ld a, l ; $234a
	and $1f ; $234b
	jr nz, .maskSet ; $234d
	ld a, c ; $234f
	ld bc, $ffe0 ; $2350
	add hl, bc ; $2353
	ld c, a ; $2354
.maskSet:
	inc e ; $2355
	res 5, e ; $2356
	dec c ; $2358
	jr nz, .loop ; $2359
	pop hl ; $235b
	wram_bank WRAM_SCREEN ; $235c
	ld bc, $4020 ; $2362
	ld a, e ; $2365
	add b ; $2366
	ld e, a ; $2367
.loopB:
	ld a, [hl+] ; $2368
	ld [de], a ; $2369
	ld a, l ; $236a
	and $1f ; $236b
	jr nz, .maskSet2 ; $236d
	ld a, c ; $236f
	ld bc, $ffe0 ; $2370
	add hl, bc ; $2373
	ld c, a ; $2374
.maskSet2:
	inc e ; $2375
	res 5, e ; $2376
	dec c ; $2378
	jr nz, .loopB ; $2379
	ld a, $01 ; $237b
	ldh [hBGRowBlitPending], a ; $237d
	ret ; $237f
Unused_00_BlitBGStrip2:
	ld a, [wCameraX + 1] ; $2380
	add b ; $2383
	and $1f ; $2384
	ld [wBGColumnBlitX], a ; $2386
	ld d, $00 ; $2389
	ld e, a ; $238b
	ld a, [wCameraY + 1] ; $238c
	add c ; $238f
	and $1f ; $2390
	ld h, $00 ; $2392
	ld l, a ; $2394
	ld de, wBGColumnBlitAttrs ; $2395
	add hl, de ; $2398
	push hl ; $2399
	call Unused_00_GetScrollBufferAddr ; $239a
	pop de ; $239d
	push hl ; $239e
	wram_bank WRAM_COURT_PLANES ; $239f
	ld c, $20 ; $23a5
.loop:
	ld a, [hl] ; $23a7
	ld [de], a ; $23a8
	ld a, c ; $23a9
	ld bc, $0020 ; $23aa
	add hl, bc ; $23ad
	ld c, a ; $23ae
	res 5, h ; $23af
	set 4, h ; $23b1
	inc e ; $23b3
	res 5, e ; $23b4
	dec c ; $23b6
	jr nz, .loop ; $23b7
	pop hl ; $23b9
	wram_bank WRAM_SCREEN ; $23ba
	ld bc, $4020 ; $23c0
	ld a, e ; $23c3
	add b ; $23c4
	ld e, a ; $23c5
.loopB:
	ld a, [hl] ; $23c6
	ld [de], a ; $23c7
	ld a, c ; $23c8
	ld bc, $0020 ; $23c9
	add hl, bc ; $23cc
	ld c, a ; $23cd
	res 5, h ; $23ce
	set 4, h ; $23d0
	inc e ; $23d2
	res 5, e ; $23d3
	dec c ; $23d5
	jr nz, .loopB ; $23d6
	ld a, $01 ; $23d8
	ldh [hBGColumnBlitPending], a ; $23da
	ret ; $23dc
UpdateGameTimer:
	ld a, [wSecondaryTimerMode] ; $23dd
	cp $01 ; $23e0
	call z, Unused_00_TickSecondaryTimer ; $23e2
	ld hl, wGameTimer ; $23e5
	inc [hl] ; $23e8
	ld a, [hl] ; $23e9
	cp $3c ; $23ea
	ret c ; $23ec
	ld [hl], $00 ; $23ed
	inc hl ; $23ef
	inc [hl] ; $23f0
	ld a, [hl] ; $23f1
	cp $3c ; $23f2
	ret c ; $23f4
	ld [hl], $00 ; $23f5
	inc hl ; $23f7
	inc [hl] ; $23f8
	ld a, [hl] ; $23f9
	cp $3c ; $23fa
	ret c ; $23fc
	ld [hl], $00 ; $23fd
	inc hl ; $23ff
	inc [hl] ; $2400
	ld a, [hl] ; $2401
	cp $64 ; $2402
	ret c ; $2404
	dec [hl] ; $2405
	dec hl ; $2406
	ld [hl], $3b ; $2407
	ret ; $2409
Unused_00_TickSecondaryTimerCountdown:
	ld hl, wSecondaryTimer ; $240a
	inc [hl] ; $240d
	ld a, [hl] ; $240e
	cp $3c ; $240f
	jr nz, .step ; $2411
	ld [hl], $00 ; $2413
	inc hl ; $2415
	sound SFX_TIMER_TICK ; $2416
	dec [hl] ; $2418
	ld a, [hl] ; $2419
	cp $ff ; $241a
	jr nz, .step ; $241c
	ld [hl], $3b ; $241e
	inc hl ; $2420
	dec [hl] ; $2421
.step:
	ld hl, wSecondaryTimer + 1 ; $2422
	ld a, [hl+] ; $2425
	or [hl] ; $2426
	ret nz ; $2427
	xor a ; $2428
	ld hl, wSecondaryTimerMode ; $2429
	ld [hl], $ff ; $242c
	inc hl ; $242e
	ld [hl+], a ; $242f
	ld [hl+], a ; $2430
	ld [hl+], a ; $2431
	sound SFX_TIMER_UP ; $2432
	ret ; $2434
Unused_00_TickSecondaryTimer:
	ld hl, wSecondaryTimer ; $2435
	inc [hl] ; $2438
	ld a, [hl] ; $2439
	cp $3c ; $243a
	ret c ; $243c
	ld [hl], $00 ; $243d
	inc hl ; $243f
	inc [hl] ; $2440
	ld a, [hl] ; $2441
	cp $3c ; $2442
	ret c ; $2444
	ld [hl], $00 ; $2445
	inc hl ; $2447
	inc [hl] ; $2448
	ld a, [hl] ; $2449
	cp $0a ; $244a
	ret c ; $244c
	dec [hl] ; $244d
	dec hl ; $244e
	ld [hl], $3b ; $244f
	ret ; $2451
SaveGameTimer:
	push af ; $2452
	push de ; $2453
	push hl ; $2454
	ld hl, wGameTimer ; $2455
	ld de, wSavedGameTimer ; $2458
	di ; $245b
	ld a, [hl+] ; $245c
	ld [de], a ; $245d
	inc de ; $245e
	ld a, [hl+] ; $245f
	ld [de], a ; $2460
	inc de ; $2461
	ld a, [hl+] ; $2462
	ld [de], a ; $2463
	inc de ; $2464
	ld a, [hl+] ; $2465
	ld [de], a ; $2466
	inc de ; $2467
	ei ; $2468
	pop hl ; $2469
	pop de ; $246a
	pop af ; $246b
	ret ; $246c
RestoreGameTimer:
	push af ; $246d
	push de ; $246e
	push hl ; $246f
	ld de, wGameTimer ; $2470
	ld hl, wSavedGameTimer ; $2473
	di ; $2476
	ld a, [hl+] ; $2477
	ld [de], a ; $2478
	inc de ; $2479
	ld a, [hl+] ; $247a
	ld [de], a ; $247b
	inc de ; $247c
	ld a, [hl+] ; $247d
	ld [de], a ; $247e
	inc de ; $247f
	ld a, [hl+] ; $2480
	ld [de], a ; $2481
	inc de ; $2482
	ei ; $2483
	pop hl ; $2484
	pop de ; $2485
	pop af ; $2486
	ret ; $2487
ResetGameTimer:
	push af ; $2488
	push hl ; $2489
	ld hl, wGameTimer ; $248a
	xor a ; $248d
	di ; $248e
	ld [hl+], a ; $248f
	ld [hl+], a ; $2490
	ld [hl+], a ; $2491
	ld [hl], a ; $2492
	ei ; $2493
	pop hl ; $2494
	pop af ; $2495
	ret ; $2496
FlagMaskTable:
	; $2497, 8 bytes (bytes:8)
	db $80, $40, $20, $10, $08, $04, $02, $01 ; 0x00
TestGameFlag:
	push hl ; $249f
	push bc ; $24a0
	ld b, a ; $24a1
	ld a, e ; $24a2
	rlca ; $24a3
	rlca ; $24a4
	rlca ; $24a5
	ld_hl_indexed FlagMaskTable ; $24a6
	ld a, [hl] ; $24ad
	ld hl, wGameFlags ; $24ae
	ld e, d ; $24b1
	ld d, $00 ; $24b2
	add hl, de ; $24b4
	and [hl] ; $24b5
	ld a, b ; $24b6
	pop bc ; $24b7
	pop hl ; $24b8
	ret ; $24b9
SetGameFlag:
	push hl ; $24ba
	push af ; $24bb
	ld a, e ; $24bc
	rlca ; $24bd
	rlca ; $24be
	rlca ; $24bf
	ld_hl_indexed FlagMaskTable ; $24c0
	ld a, [hl] ; $24c7
	ld hl, wGameFlags ; $24c8
	ld e, d ; $24cb
	ld d, $00 ; $24cc
	add hl, de ; $24ce
	or [hl] ; $24cf
	ld [hl], a ; $24d0
	pop af ; $24d1
	pop hl ; $24d2
	ret ; $24d3
ClearGameFlag:
	push hl ; $24d4
	push af ; $24d5
	ld a, e ; $24d6
	rlca ; $24d7
	rlca ; $24d8
	rlca ; $24d9
	ld_hl_indexed FlagMaskTable ; $24da
	ld a, [hl] ; $24e1
	ld hl, wGameFlags ; $24e2
	ld e, d ; $24e5
	ld d, $00 ; $24e6
	add hl, de ; $24e8
	cpl ; $24e9
	and [hl] ; $24ea
	ld [hl], a ; $24eb
	pop af ; $24ec
	pop hl ; $24ed
	ret ; $24ee
TestGameFlagByNumber:
	push de ; $24ef
	sla e ; $24f0
	rl d ; $24f2
	sla e ; $24f4
	rl d ; $24f6
	sla e ; $24f8
	rl d ; $24fa
	sla e ; $24fc
	rl d ; $24fe
	sla e ; $2500
	rl d ; $2502
	call TestGameFlag ; $2504
	pop de ; $2507
	ret ; $2508
SetGameFlagByNumber:
	push de ; $2509
	sla e ; $250a
	rl d ; $250c
	sla e ; $250e
	rl d ; $2510
	sla e ; $2512
	rl d ; $2514
	sla e ; $2516
	rl d ; $2518
	sla e ; $251a
	rl d ; $251c
	call SetGameFlag ; $251e
	pop de ; $2521
	ret ; $2522
ClearGameFlagByNumber:
	push de ; $2523
	sla e ; $2524
	rl d ; $2526
	sla e ; $2528
	rl d ; $252a
	sla e ; $252c
	rl d ; $252e
	sla e ; $2530
	rl d ; $2532
	sla e ; $2534
	rl d ; $2536
	call ClearGameFlag ; $2538
	pop de ; $253b
	ret ; $253c
FetchInlineWordOperand:
	push bc ; $253d
	ld c, [hl] ; $253e
	inc hl ; $253f
	ld b, [hl] ; $2540
	dec hl ; $2541
	push hl ; $2542
	ld h, b ; $2543
	ld l, c ; $2544
	ld e, [hl] ; $2545
	inc hl ; $2546
	ld d, [hl] ; $2547
	inc hl ; $2548
	ld b, h ; $2549
	ld c, l ; $254a
	pop hl ; $254b
	ld [hl], c ; $254c
	inc hl ; $254d
	ld [hl], b ; $254e
	pop bc ; $254f
	ret ; $2550
TestGameFlagCmd:
	push de ; $2551
	push hl ; $2552
	ld hl, sp + 4 ; $2553
	call FetchInlineWordOperand ; $2555
	call TestGameFlag ; $2558
	pop hl ; $255b
	pop de ; $255c
	ret ; $255d
SetGameFlagCmd:
	push de ; $255e
	push hl ; $255f
	ld hl, sp + 4 ; $2560
	call FetchInlineWordOperand ; $2562
	call SetGameFlag ; $2565
	pop hl ; $2568
	pop de ; $2569
	ret ; $256a
ClearGameFlagCmd:
	push de ; $256b
	push hl ; $256c
	ld hl, sp + 4 ; $256d
	call FetchInlineWordOperand ; $256f
	call ClearGameFlag ; $2572
	pop hl ; $2575
	pop de ; $2576
	ret ; $2577
Start:
	and a ; $2578
	cp $11 ; $2579
	ld a, $00 ; $257b
	jr nz, .store ; $257d
	inc a ; $257f
.store:
	ldh [hIsCGB], a ; $2580
SoftReset:
	ld sp, STACK_TOP ; $2582
	call DisableLCDSafely ; $2585
	di ; $2588
	ld hl, wShadowOAM ; $2589
	ld c, $ff ; $258c
	call ClearMemory16 ; $258e
	xor a ; $2591
	ld c, $80 ; $2592
	ld b, $70 ; $2594
.clearHramLoop:
	ldh [c], a ; $2596
	inc c ; $2597
	dec b ; $2598
	jr nz, .clearHramLoop ; $2599
	ldh [rIF], a ; $259b
	ldh [rIE], a ; $259d
	ldh [rSCY], a ; $259f
	ldh [rSCX], a ; $25a1
	ldh [rSTAT], a ; $25a3
	ldh a, [hIsCGB] ; $25a5
	or a ; $25a7
	jr nz, .cgbOk ; $25a8
	farcall ShowDmgLockoutScreen ; $25aa
.cgbOk:
	xor a ; $25ad
	ldh [rVBK], a ; $25ae
	ldh [rWBK], a ; $25b0
	ldh [rRP], a ; $25b2
	xor a ; $25b4
	ld [rRAMG], a ; $25b5
	call CopyOAMDMARoutineToHRAM ; $25b8
	call ClearVRAMBank ; $25bb
	xor a ; $25be
	ldh [hDebugStepMode], a ; $25bf
	call SwitchCPUSpeed ; $25c1
	ld a, $06 ; $25c4
	ldh [hInputRepeatDelay], a ; $25c6
	call ClearSpriteQueue ; $25c8
	call ClearFrameTasks ; $25cb
	call ClearVRAMCopyQueue ; $25ce
	push_wram_bank WRAM_SOUND ; $25d1
	ld hl, WRAMX_BASE ; $25da
	ld c, LOW(WRAMX_SIZE / 16) ; $25dd
	call ClearMemory16 ; $25df
	call InitAudioEngine ; $25e2
	pop_wram_bank ; $25e5
	ld a, $07 ; $25ea
	ldh [rWX], a ; $25ec
	ld a, $90 ; $25ee
	ldh [rWY], a ; $25f0
	ld hl, rTMA ; $25f2
	ld a, $77 ; $25f5
	ld [hl+], a ; $25f7
	xor a ; $25f8
	ld [hl], a ; $25f9
	set 2, [hl] ; $25fa
	ld a, $08 ; $25fc
	ldh [rSTAT], a ; $25fe
	ld a, $50 ; $2600
	ldh [rLYC], a ; $2602
	xor a ; $2604
	ldh [rSB], a ; $2605
	ld a, SC_FAST | SC_EXTERNAL ; $2607
	ldh [rSC], a ; $2609
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $260b
	ldh [rSC], a ; $260d
	xor a ; $260f
	ldh [rIF], a ; $2610
	ld a, $0d ; $2612
	ldh [rIE], a ; $2614
	ld a, $e7 ; $2616
	ldh [rLCDC], a ; $2618
	ei ; $261a
	xor a ; $261b
	ldh [hPaletteDirtyFlags], a ; $261c
	ldh [hFadeState], a ; $261e
	ldh [hFadeSpeed], a ; $2620
	ldh [hFadeCounter], a ; $2622
	ld a, LINKMSG_NONE ; $2624
	ld [wSpriteBufferPage], a ; $2626
	call InitSerialLink ; $2629
	farcall InitAndRunGame ; $262c
	stop ; $262f
; Waits for the next frame, and hosts the debug single-stepper: with
; hDebugStepMode enabled, holding SELECT+START sets hDebugStepPaused and the
; routine spins in a second frame-wait until START releases it, SELECT cycling
; hDebugStepMode 1-3 while paused.
;
; The link-error check at the top is dead. Nothing in the ROM ever sets the top
; bits of hLinkErrorFlags -- both writes to it are `xor a` clears -- so the
; `jp nz, LinkErrorReset` is unreachable. See docs/bugs.md.
AdvanceFrame:
	push af ; $2631
	push bc ; $2632
	push de ; $2633
	push hl ; $2634
	ldh a, [hLinkCounter] ; $2635
	or a ; $2637
	jr z, .linkOk ; $2638
	ldh a, [hLinkErrorFlags] ; $263a
	and $e0 ; $263c
	jp nz, LinkErrorReset ; $263e
.linkOk:
	ldh a, [rVBK] ; $2641
	push af ; $2643
	xor a ; $2644
	ldh [hVBlankOccurred], a ; $2645
	xor a ; $2647
	call RunFrameTasks ; $2648
	ld a, [wSpriteBufferPage] ; $264b
	and $cf ; $264e
	xor $05 ; $2650
	ld [wSpriteBufferPage], a ; $2652
	push_wram_bank WRAM_SOUND ; $2655
	call ResumeBGMAfterJingle ; $265e
	pop_wram_bank ; $2661
	ldh a, [rLY] ; $2666
	ld l, a ; $2668
	ldh a, [hPeakLY] ; $2669
	ld h, a ; $266b
	cp l ; $266c
	jr c, .newPeakLY ; $266d
	ldh a, [hPeakLYFrames] ; $266f
	dec a ; $2671
	ldh [hPeakLYFrames], a ; $2672
	jr nz, .peakDone ; $2674
.newPeakLY:
	ld a, l ; $2676
	ld h, l ; $2677
	ldh [hPeakLY], a ; $2678
	ld a, $0f ; $267a
	ldh [hPeakLYFrames], a ; $267c
.peakDone:
	ld de, wDebugPeakLYText ; $267e
	call FormatHexWord ; $2681
	ldh a, [hDebugStepMode] ; $2684
	or a ; $2686
	jp z, .waitFrame ; $2687
	ldh a, [hLinkExchangeActive] ; $268a
	or a ; $268c
	jr nz, .checkStepActive ; $268d
	ldh a, [hPlayerInputFlags] ; $268f
	and PADF_SELECT | PADF_START ; $2691
	cp PADF_SELECT | PADF_START ; $2693
	jr nz, .checkStepActive ; $2695
	ld a, $01 ; $2697
	ldh [hDebugStepPaused], a ; $2699
	jr .stepLoop ; $269b
.checkStepActive:
	ldh a, [hDebugStepPaused] ; $269d
	or a ; $269f
	jr z, .waitFrame ; $26a0
.stepLoop:
	ldh a, [hInputRisingEdge] ; $26a2
	bit PADB_SELECT, a ; $26a4
	jr z, .checkStepExit ; $26a6
	ldh a, [hDebugStepMode] ; $26a8
	inc a ; $26aa
	cp $04 ; $26ab
	jr c, .storeStepMode ; $26ad
	ld a, $01 ; $26af
.storeStepMode:
	ldh [hDebugStepMode], a ; $26b1
	jr .stepWaitFrame ; $26b3
.checkStepExit:
	ldh a, [hPlayerInputFlags] ; $26b5
	bit PADB_START, a ; $26b7
	jr z, .stepWaitFrame ; $26b9
	bit 2, a ; $26bb
	jr nz, .stepWaitFrame ; $26bd
	xor a ; $26bf
	ldh [hDebugStepPaused], a ; $26c0
	jr .waitFrame ; $26c2
.stepWaitFrame:
	ldh a, [hInputPressed] ; $26c4
	and $f3 ; $26c6
	jr nz, .waitFrame ; $26c8
	ldh a, [hLinkExchangeActive] ; $26ca
	or a ; $26cc
	jr z, .stepHaltLoop ; $26cd
	ldh a, [hLinkState] ; $26cf
	cp LINKSTATE_SLAVE ; $26d1
	jr z, .stepFrameDone ; $26d3
	jr .stepLinkLoop ; $26d5
.stepHaltLoop:
	ei ; $26d7
	halt ; $26d8
	nop ; $26d9
	di ; $26da
	ldh a, [hVBlankOccurred] ; $26db
	and a ; $26dd
	jr z, .stepHaltLoop ; $26de
	jr .stepFrameDone ; $26e0
.stepLinkLoop:
	ei ; $26e2
	nop ; $26e3
	di ; $26e4
	ldh a, [hVBlankOccurred] ; $26e5
	ld b, a ; $26e7
	ldh a, [hLinkTransferDone] ; $26e8
	and b ; $26ea
	jr z, .stepLinkLoop ; $26eb
	xor a ; $26ed
	ldh [hLinkTransferDone], a ; $26ee
.stepFrameDone:
	ei ; $26f0
	jr .stepLoop ; $26f1
.waitFrame:
	ldh a, [hLinkExchangeActive] ; $26f3
	or a ; $26f5
	jr z, .haltLoop ; $26f6
	ldh a, [hLinkState] ; $26f8
	cp LINKSTATE_SLAVE ; $26fa
	jr z, .done ; $26fc
	jr .linkLoop ; $26fe
.haltLoop:
	halt ; $2700
	nop ; $2701
	di ; $2702
	ldh a, [hVBlankOccurred] ; $2703
	and a ; $2705
	jr nz, .done ; $2706
	ei ; $2708
	jr .haltLoop ; $2709
.linkLoop:
	ei ; $270b
	nop ; $270c
	di ; $270d
	ldh a, [hVBlankOccurred] ; $270e
	ld b, a ; $2710
	ldh a, [hLinkTransferDone] ; $2711
	and b ; $2713
	jr z, .linkLoop ; $2714
	xor a ; $2716
	ldh [hLinkTransferDone], a ; $2717
.done:
	ei ; $2719
	pop af ; $271a
	ldh [rVBK], a ; $271b
	call ClearUnusedSprites ; $271d
	pop hl ; $2720
	pop de ; $2721
	pop bc ; $2722
	pop af ; $2723
	ret ; $2724
WaitFramesCmd:
	push bc ; $2725
	push de ; $2726
	push hl ; $2727
	ld hl, sp + 6 ; $2728
	ld e, [hl] ; $272a
	inc hl ; $272b
	ld d, [hl] ; $272c
	dec hl ; $272d
	push hl ; $272e
	ld h, d ; $272f
	ld l, e ; $2730
	ld c, [hl] ; $2731
	inc hl ; $2732
	ld d, h ; $2733
	ld e, l ; $2734
	pop hl ; $2735
	ld [hl], e ; $2736
	inc hl ; $2737
	ld [hl], d ; $2738
	pop hl ; $2739
	pop de ; $273a
	call WaitFrames ; $273b
	pop bc ; $273e
	ret ; $273f
WaitFrames:
	push af ; $2740
.loop:
	call AdvanceFrame ; $2741
	dec c ; $2744
	jr nz, .loop ; $2745
	pop af ; $2747
	ret ; $2748
