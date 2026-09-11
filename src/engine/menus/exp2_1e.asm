GetDigitSpriteTile:
	sub $30 ; $5afa
	rlca ; $5afc
	add $6c ; $5afd
	ld c, a ; $5aff
	ld b, $08 ; $5b00
	ret ; $5b02
RunExpAwardSequence:
	wram_bank $06 ; $5b03
	call AdvanceFrame ; $5b09
	call BeginNextExpAward ; $5b0c
	or a ; $5b0f
	ret z ; $5b10
	call CountUpExpTotal ; $5b11
	call WaitForConfirmOrTimeout ; $5b14
	jr RunExpAwardSequence ; $5b17
BeginNextExpAward:
	call DrawNextExpAwardMessage ; $5b19
	or a ; $5b1c
	jp z, .waitFramesCmd ; $5b1d
	sound BGM_NONE ; $5b20
	sound BGM_EXP_AWARD ; $5b22
	wram_bank $06 ; $5b24
	ld a, [wExpAwardIndex] ; $5b2a
	inc a ; $5b2d
	ld [wExpAwardIndex], a ; $5b2e
	xor a ; $5b31
	ld [wExpAwardMessageTimer], a ; $5b32
	ld hl, wExpAwardAmount ; $5b35
	ld a, c ; $5b38
	ld [hl+], a ; $5b39
	ld [hl], b ; $5b3a
	wram_bank $03 ; $5b3b
	ld hl, wShadowTilemap ; $5b41
	ld de, vBGMap0 ; $5b44
	ld c, $08 ; $5b47
	call QueueVRAMCopy ; $5b49
	wram_bank $02 ; $5b4c
	ld hl, wScreenAttrmap ; $5b52
	ld de, vBGMap0 + VRAM_BANK1 ; $5b55
	ld c, $08 ; $5b58
	call QueueVRAMCopy ; $5b5a
	ld a, $01 ; $5b5d
	ret ; $5b5f
.waitFramesCmd:
	wait_frames $0a ; $5b60
	xor a ; $5b64
	ret ; $5b65
CountUpExpTotal:
	wram_bank $06 ; $5b66
	ld hl, wExpAwardAmount ; $5b6c
	ld a, [hl+] ; $5b6f
	ld d, [hl] ; $5b70
	ld e, a ; $5b71
	ld a, d ; $5b72
	or e ; $5b73
	ret z ; $5b74
	call AdvanceFrame ; $5b75
	ldh a, [hInputRisingEdge] ; $5b78
	and PADF_A | PADF_B ; $5b7a
	jr nz, .step ; $5b7c
	call AdvanceFrame ; $5b7e
	ldh a, [hInputRisingEdge] ; $5b81
	and PADF_A | PADF_B ; $5b83
	jr nz, .step ; $5b85
	dec hl ; $5b87
	dec de ; $5b88
	ld a, e ; $5b89
	ld [hl+], a ; $5b8a
	ld [hl], d ; $5b8b
	ld hl, wExpAwardRunningTotal ; $5b8c
	ld a, [hl+] ; $5b8f
	ld d, [hl] ; $5b90
	ld e, a ; $5b91
	inc de ; $5b92
	dec hl ; $5b93
	ld a, e ; $5b94
	ld [hl+], a ; $5b95
	ld [hl], d ; $5b96
	sound SFX_MENU_MOVE ; $5b97
	jr CountUpExpTotal ; $5b99
.step:
	ld hl, wExpAwardRunningTotal ; $5b9b
	ld a, [hl+] ; $5b9e
	ld h, [hl] ; $5b9f
	ld l, a ; $5ba0
	add hl, de ; $5ba1
	ld d, h ; $5ba2
	ld e, l ; $5ba3
	ld hl, wExpAwardRunningTotal ; $5ba4
	ld a, e ; $5ba7
	ld [hl+], a ; $5ba8
	ld [hl], d ; $5ba9
	sound SFX_MENU_SELECT ; $5baa
	ret ; $5bac
WaitForConfirmOrTimeout:
	ld c, $b4 ; $5bad
.loop:
	call AdvanceFrame ; $5baf
	ldh a, [hInputRisingEdge] ; $5bb2
	and PADF_A | PADF_B ; $5bb4
	ret nz ; $5bb6
	dec c ; $5bb7
	jr nz, .loop ; $5bb8
	ret ; $5bba
HasPendingExpAwards:
	ld hl, wPendingExpAwardAmounts ; $5bbb
	ld a, [hl+] ; $5bbe
	ld d, [hl] ; $5bbf
	inc hl ; $5bc0
	or d ; $5bc1
	jr nz, .returnOne ; $5bc2
	ld a, [hl+] ; $5bc4
	ld d, [hl] ; $5bc5
	inc hl ; $5bc6
	or d ; $5bc7
	jr nz, .returnOne ; $5bc8
	ld a, [hl+] ; $5bca
	ld d, [hl] ; $5bcb
	inc hl ; $5bcc
	or d ; $5bcd
	jr nz, .returnOne ; $5bce
	ld a, [hl+] ; $5bd0
	ld d, [hl] ; $5bd1
	inc hl ; $5bd2
	or d ; $5bd3
	jr nz, .returnOne ; $5bd4
	ld a, [hl+] ; $5bd6
	ld d, [hl] ; $5bd7
	inc hl ; $5bd8
	or d ; $5bd9
	jr nz, .returnOne ; $5bda
	xor a ; $5bdc
	ret ; $5bdd
.returnOne:
	ld a, $01 ; $5bde
	ret ; $5be0
ExpAwardScreenPalettes0:
	INCLUDE "data/bank_01e/ExpAwardScreenPalettes0.asm" ; $5be1, 24 bytes (palettes)
ExpAwardScreenGfx_1e:
	INCBIN "data/bank_01e/lz_ExpAwardScreenGfx_1e.bin" ; $5bf9, 1745 bytes
ExpAwardScreenTilemap_1e:
	INCBIN "data/bank_01e/lz_ExpAwardScreenTilemap_1e.bin" ; $62ca, 389 bytes
ExpAwardScreenAttrmap_1e:
	INCBIN "data/bank_01e/lz_ExpAwardScreenAttrmap_1e.bin" ; $644f, 70 bytes
ExpAwardScreenPalettes1:
	INCLUDE "data/bank_01e/ExpAwardScreenPalettes1.asm" ; $6495, 8 bytes (palettes)
ExpDigitSpriteGfx_1e:
	INCBIN "data/bank_01e/lz_ExpDigitSpriteGfx_1e.bin" ; $649d, 150 bytes
	INCLUDE "data/bank_01e/lz_ExpDigitSpriteGfx_1e.inc" ; DEF ExpDigitSpriteGfx_1e_SIZE EQU its decoded length, generated from the .bin by make
StubNop_1e:
	ret ; $6533
ProcessMatchRewards:
	ld a, [wMatchExitRequest] ; $6534
	or a ; $6537
	ret nz ; $6538
	ld a, [wKeepMatchStatsFlag] ; $6539
	or a ; $653c
	ret nz ; $653d
	call DisableLCDSafely ; $653e
	farcall LoadMenuFontGfx ; $6541
	call EnableLCD ; $6544
	ld hl, $0000 ; $6547
	ld a, [wGameMode] ; $654a
	cp GAMEMODE_MARIO_MINIGAME ; $654d
	jp z, .updateMinigameBestScore ; $654f
	cp GAMEMODE_LINK_MATCH ; $6552
	jp z, .eq09 ; $6554
	cp GAMEMODE_TENNIS_MACHINE ; $6557
	jp z, .checkMatchExitRequest ; $6559
	cp GAMEMODE_WALL_PRACTICE ; $655c
	jp z, .checkMatchExitRequest ; $655e
	cp GAMEMODE_DREAM_MATCH ; $6561
	jp z, .computeMatchStatsReward ; $6563
	cp GAMEMODE_EXHIBITION ; $6566
	jp z, .eq04 ; $6568
	jp c, .computeMatchStatsReward ; $656b
	ld a, [wPointWinLoseFlag] ; $656e
	cp WINLOSE_WIN ; $6571
	jp nz, .runExpDistributionFlow ; $6573
	call GetFirstClearRewardExp ; $6576
	call ShowExpAwardForMinigame ; $6579
	ld h, d ; $657c
	ld l, e ; $657d
	call SetRewardGameFlag ; $657e
	jp .runExpDistributionFlow ; $6581
.checkMatchExitRequest:
	ld a, [wMatchExitRequest] ; $6584
	and a ; $6587
	jp nz, .runExpDistributionFlow ; $6588
	push hl ; $658b
	ld hl, wMinigamesCurrentScore ; $658c
	ld a, [hl+] ; $658f
	ld h, [hl] ; $6590
	ld l, a ; $6591
	ld a, [wGameMode] ; $6592
	cp GAMEMODE_WALL_PRACTICE ; $6595
	ld a, $0f ; $6597
	jr nz, .mulHLByAFracSigned ; $6599
	add $0f ; $659b
.mulHLByAFracSigned:
	call MulHLByAFracSigned ; $659d
	ld e, a ; $65a0
	ld a, h ; $65a1
	ld h, l ; $65a2
	ld l, e ; $65a3
	ld e, $64 ; $65a4
	call DivAHLByE ; $65a6
	pop de ; $65a9
	add hl, de ; $65aa
	ld a, [wPlayer1MainEquipment] ; $65ab
	ld d, a ; $65ae
	call ApplyMatchSettingsExpBonus ; $65af
	ld a, [wPointWinLoseFlag] ; $65b2
	cp WINLOSE_WIN ; $65b5
	jp nz, .getScoreBonus ; $65b7
	ld a, [wMinigameHighScoreMode] ; $65ba
	or a ; $65bd
	jr z, .getFirstClearRewardExp ; $65be
	ld a, [wGameMode] ; $65c0
	cp GAMEMODE_TENNIS_MACHINE ; $65c3
	jr nz, .checkFlag ; $65c5
	test_flag FLAG_CLEARED_MACHINE_MASTER ; $65c7
	jr .step ; $65ca
.checkFlag:
	test_flag FLAG_CLEARED_WALL_MASTER ; $65cc
.step:
	jr z, .getFirstClearRewardExp ; $65cf
	push hl ; $65d1
	ld hl, wMinigamesCurrentScore ; $65d2
	ld a, [hl+] ; $65d5
	ld h, [hl] ; $65d6
	ld l, a ; $65d7
	ld de, $270f ; $65d8
	ld a, l ; $65db
	sub e ; $65dc
	ld l, a ; $65dd
	ld a, h ; $65de
	sbc d ; $65df
	ld h, a ; $65e0
	ld a, h ; $65e1
	or l ; $65e2
	pop hl ; $65e3
	jr nz, .getScoreBonus ; $65e4
.getFirstClearRewardExp:
	call GetFirstClearRewardExp ; $65e6
	add hl, de ; $65e9
	call SetRewardGameFlag ; $65ea
.getScoreBonus:
	call GetScoreBonus ; $65ed
	add hl, de ; $65f0
	ld d, h ; $65f1
	ld e, l ; $65f2
	call ShowExpAwardForMinigame ; $65f3
	jp .runExpDistributionFlow ; $65f6
.computeMatchStatsReward:
	wram_bank $04 ; $65f9
	call ComputeMatchStatsReward ; $65ff
	ld a, [wPlayer1MainEquipment] ; $6602
	ld d, a ; $6605
	call ApplyMatchSettingsExpBonus ; $6606
	ld de, $0000 ; $6609
	ld a, [wMatchWinLoseFlag] ; $660c
	cp WINLOSE_WIN ; $660f
	jr nz, .offset ; $6611
	call GetFirstClearRewardExp ; $6613
.offset:
	add hl, de ; $6616
	ld d, h ; $6617
	ld e, l ; $6618
	call ShowExpAwardForMatch ; $6619
	ld a, [wMatchWinLoseFlag] ; $661c
	cp WINLOSE_WIN ; $661f
	jr nz, .runExpDistributionFlow ; $6621
	call SetRewardGameFlag ; $6623
	push hl ; $6626
	call ApplyRewardUnlockFlags ; $6627
	pop hl ; $662a
	call ApplyClassProgressFlags ; $662b
	jr .runExpDistributionFlow ; $662e
.eq04:
	wram_bank $04 ; $6630
	call ComputeMatchStatsReward ; $6636
	ld a, [wPlayer1MainEquipment] ; $6639
	ld d, a ; $663c
	call ApplyMatchSettingsExpBonus ; $663d
	call AwardExhibitionMatchExp ; $6640
	ret ; $6643
.eq09:
	ld a, [wLinkMatchRole] ; $6644
	cp LINKSTATE_SLAVE ; $6647
	jr z, .eq02 ; $6649
	wram_bank $04 ; $664b
	call ComputeMatchStatsReward ; $6651
	ld a, [wPlayer1MainEquipment] ; $6654
	ld d, a ; $6657
	call ApplyMatchSettingsExpBonus ; $6658
	ld a, [wMatchWinLoseFlag] ; $665b
	cp WINLOSE_WIN ; $665e
	jr z, .step6 ; $6660
	jr .awardLinkedPlayMatchExp ; $6662
.eq02:
	wram_bank $05 ; $6664
	call ComputeMatchStatsReward ; $666a
	ld a, [wPlayer2MainEquipment] ; $666d
	ld d, a ; $6670
	call ApplyMatchSettingsExpBonus ; $6671
	ld a, [wMatchWinLoseFlag] ; $6674
	cp WINLOSE_LOSE ; $6677
	jr z, .step6 ; $6679
	jr .awardLinkedPlayMatchExp ; $667b
.step6:
	ld e, l ; $667d
	ld d, h ; $667e
	sra d ; $667f
	rr e ; $6681
	add hl, de ; $6683
.awardLinkedPlayMatchExp:
	call AwardLinkedPlayMatchExp ; $6684
	ret ; $6687
.updateMinigameBestScore:
	call UpdateMinigameBestScore ; $6688
	ld a, [wPointWinLoseFlag] ; $668b
	cp WINLOSE_WIN ; $668e
	ret nz ; $6690
	call SetMinigameClearFlag ; $6691
	ret ; $6694
.runExpDistributionFlow:
	ld a, h ; $6695
	or l ; $6696
	jr z, .showIslandOpenRankingBoard ; $6697
	farcall RunExpDistributionFlow ; $6699
	ld c, $00 ; $669c
	farcall CharDataScreen_Show ; $669e
	ld c, $01 ; $66a1
	farcall CharDataScreen_Show ; $66a3
	call ApplyStatGapProgressFlag ; $66a6
.showIslandOpenRankingBoard:
	call ShowIslandOpenRankingBoard ; $66a9
	ld a, GAMEMODE_NONE ; $66ac
	ld [wGameMode], a ; $66ae
	test_flag FLAG_WON_DREAM_MATCH_SINGLES ; $66b1
	jr z, .checkFlag2 ; $66b4
	push de ; $66b6
	ld de, SAVEFLAG_UNLOCKED_SAMMI ; $66b7
	farcall SetSaveFlag ; $66ba
	pop de ; $66bd
.checkFlag2:
	test_flag FLAG_WON_DREAM_MATCH_DOUBLES ; $66be
	jr z, .checkAllProgressComplete ; $66c1
	push de ; $66c3
	ld de, SAVEFLAG_UNLOCKED_ELDEN ; $66c4
	farcall SetSaveFlag ; $66c7
	pop de ; $66ca
.checkAllProgressComplete:
	call CheckAllProgressComplete ; $66cb
	farcall SaveStorySlotWithTimer ; $66ce
	ret ; $66d1
GetFirstClearRewardExp:
	call TestRewardGameFlag ; $66d2
	ld de, $0000 ; $66d5
	ret nz ; $66d8
	push hl ; $66d9
	ld a, [wCurrentMinigameStoryMatch] ; $66da
	ld hl, FirstClearExpTablePtrs_1e ; $66dd
	add a ; $66e0
	add l ; $66e1
	ld l, a ; $66e2
	jr nc, .read ; $66e3
	inc h ; $66e5
.read:
	ld a, [hl+] ; $66e6
	ld h, [hl] ; $66e7
	ld l, a ; $66e8
	call GetRewardTableIndex ; $66e9
	add a ; $66ec
	add l ; $66ed
	ld l, a ; $66ee
	jr nc, .readB ; $66ef
	inc h ; $66f1
.readB:
	ld a, [hl+] ; $66f2
	ld d, [hl] ; $66f3
	ld e, a ; $66f4
	pop hl ; $66f5
	ret ; $66f6
FirstClearExpTablePtrs_1e:
	; $66f7, 16 bytes (records:2)
	dw FirstClearExpTableMode0_1e ; record 0
	dw FirstClearExpTableMode1_1e ; record 1
	dw FirstClearExpTableMode2_1e ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0000 ; record 7
FirstClearExpTableMode0_1e:
	; $6707, 50 bytes (records:2)
	dw $0000 ; record 0
	dw $0046 ; record 1
	dw $0050 ; record 2
	dw $005a ; record 3
	dw $0064 ; record 4
	dw $0000 ; record 5
	dw $0078 ; record 6
	dw $0096 ; record 7
	dw $00c8 ; record 8
	dw $00fa ; record 9
	dw $0000 ; record 10
	dw $012c ; record 11
	dw $0000 ; record 12
	dw $0000 ; record 13
	dw $0000 ; record 14
	dw $0000 ; record 15
	dw $015e ; record 16
	dw $0190 ; record 17
	dw $01c2 ; record 18
	dw $01f4 ; record 19
	dw $0000 ; record 20
	dw $0000 ; record 21
	dw $0320 ; record 22
	dw $0320 ; record 23
	dw $0320 ; record 24
FirstClearExpTableMode1_1e:
	; $6739, 50 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0078 ; record 2
	dw $0096 ; record 3
	dw $00c8 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $00fa ; record 7
	dw $012c ; record 8
	dw $015e ; record 9
	dw $0000 ; record 10
	dw $0000 ; record 11
	dw $0000 ; record 12
	dw $01f4 ; record 13
	dw $0000 ; record 14
	dw $0000 ; record 15
	dw $0000 ; record 16
	dw $0258 ; record 17
	dw $02bc ; record 18
	dw $0320 ; record 19
	dw $0000 ; record 20
	dw $0000 ; record 21
	dw $03e8 ; record 22
	dw $03e8 ; record 23
	dw $03e8 ; record 24
FirstClearExpTableMode2_1e:
	; $676b, 60 bytes (records:2)
	dw $0032 ; record 0
	dw $0064 ; record 1
	dw $00c8 ; record 2
	dw $0032 ; record 3
	dw $0064 ; record 4
	dw $00c8 ; record 5
	dw $0032 ; record 6
	dw $0064 ; record 7
	dw $00c8 ; record 8
	dw $0032 ; record 9
	dw $0064 ; record 10
	dw $00c8 ; record 11
	dw $0032 ; record 12
	dw $0064 ; record 13
	dw $00c8 ; record 14
	dw $0032 ; record 15
	dw $0064 ; record 16
	dw $00c8 ; record 17
	dw $0064 ; record 18
	dw $00c8 ; record 19
	dw $0190 ; record 20
	dw $02bc ; record 21
	dw $012c ; record 22
	dw $0190 ; record 23
	dw $01f4 ; record 24
	dw $03e8 ; record 25
	dw $0000 ; record 26
	dw $0000 ; record 27
	dw $0000 ; record 28
	dw $0000 ; record 29
