CheckBallHitsMinigameTargetAlt:
	ld a, [wBallCrossedNetFlag] ; $6df4
	and a ; $6df7
	ret z ; $6df8
	ld a, $01 ; $6df9
	ld [wMinigameHitPending], a ; $6dfb
	ld hl, wBallHistory + 30 ; $6dfe
	ld a, [hl+] ; $6e01
	ld d, [hl] ; $6e02
	ld e, a ; $6e03
	ld hl, wMinigameTargetWork + MGTARGET_X ; $6e04
	ld a, [hl+] ; $6e07
	ld h, [hl] ; $6e08
	ld l, a ; $6e09
	sub_hl_de ; $6e0a
	bit 7, h ; $6e10
	jr z, .done ; $6e12
	ld de, $0400 ; $6e14
	add hl, de ; $6e17
	bit 7, h ; $6e18
	jr nz, .done ; $6e1a
	ld hl, wBallHistory + 32 ; $6e1c
	ld a, [hl+] ; $6e1f
	ld d, [hl] ; $6e20
	ld e, a ; $6e21
	ld hl, wMinigameTargetWork + MGTARGET_DEPTH ; $6e22
	ld a, [hl+] ; $6e25
	ld h, [hl] ; $6e26
	ld l, a ; $6e27
	sub_hl_de ; $6e28
	bit 7, h ; $6e2e
	jr z, .done ; $6e30
	ld de, $0400 ; $6e32
	add hl, de ; $6e35
	bit 7, h ; $6e36
	jr nz, .done ; $6e38
	ld hl, wMinigameTargetWork + MGTARGET_FLAGS ; $6e3a
	set 2, [hl] ; $6e3d
.done:
	ret ; $6e3f
EndingCutsceneLocationList:
	; $6e40, 44 bytes (location_entries)
	db STORYLOC_END1_MAIN_BLDG, ENTRY_END1_MAIN_BLDG_SCENE ; 0
	db STORYLOC_END_RESTAURANT_ENT, ENTRY_END_RESTAURANT_ENT_SCENE ; 1
	db STORYLOC_END3_DORM_ENT, ENTRY_END3_DORM_ENT_SCENE ; 2
	db STORYLOC_END4_JR_COURT, ENTRY_END4_JR_COURT_SCENE ; 3
	db STORYLOC_END5_SERVICE_ACE, ENTRY_END5_SERVICE_ACE_SCENE ; 4
	db STORYLOC_END11_TRAINING_COURT, ENTRY_END11_TRAINING_COURT_SCENE_B ; 5
	db STORYLOC_END7_TRAINING_CTR, ENTRY_END7_TRAINING_CTR_SCENE_A ; 6
	db STORYLOC_END8_SR_COURT, ENTRY_END8_SR_COURT_SCENE ; 7
	db STORYLOC_END7_TRAINING_CTR, ENTRY_END7_TRAINING_CTR_SCENE_B ; 8
	db STORYLOC_END10_VARSITY_COURT, ENTRY_END10_VARSITY_COURT_SCENE ; 9
	db STORYLOC_END11_TRAINING_COURT, ENTRY_END11_TRAINING_COURT_SCENE_A ; 10
	db STORYLOC_END12_PRINCIPALS_OFFICE, ENTRY_END12_PRINCIPALS_OFFICE_SCENE_A ; 11
	db STORYLOC_END1_MAIN_BLDG, ENTRY_END1_MAIN_BLDG_GROUP_DEPARTURE ; 12
	db STORYLOC_ISLAND_SKY, ENTRY_ISLAND_SKY_CREDITS_TO_ISLAND_OPEN ; 13
	db STORYLOC_CENTER_COURT, ENTRY_CENTER_COURT_CREDITS ; 14
	db STORYLOC_END16_BEFORE_FINALS, ENTRY_END16_BEFORE_FINALS_SCENE ; 15
	db STORYLOC_END17_AWARD_CEREMONY, ENTRY_END17_AWARD_CEREMONY_SCENE ; 16
	db STORYLOC_END12_PRINCIPALS_OFFICE, ENTRY_END12_PRINCIPALS_OFFICE_SCENE_B ; 17
	db STORYLOC_ISLAND_SKY, ENTRY_ISLAND_SKY_CREDITS_TO_PEACHS_CASTLE ; 18
	db STORYLOC_PEACHS_CASTLE, ENTRY_PEACHS_CASTLE_CREDITS ; 19
	db STORYLOC_SPECIAL_COURT, ENTRY_SPECIAL_COURT_SINGLES_HARD ; 20
	db $ff, $ff ; list end
EndingCreditsSequencePalette:
	INCLUDE "data/engine/story/EndingCreditsSequencePalette.asm" ; $6e6c, 8 bytes (palettes)
RunEndingCreditsSequence:
	script_fade_out 4 ; $6e74
	call WaitFadeEnd ; $6e79
	set_flag FLAG_ENDING_CREDITS_RUNNING ; $6e7c
	sound BGM_CREDITS ; $6e7f
	farcall LoadMenuFontGfx ; $6e81
	ld hl, EndingCreditsSequencePalette ; $6e84
	ld_bg_pals de, 0, 1 ; $6e87
	call LoadPalettesMasterOnly ; $6e8a
	xor a ; $6e8d
	ld [wStoryCharacterSlot], a ; $6e8e
.sceneLoop:
	call ClearFrameTasks ; $6e91
	ld a, [wStoryCharacterSlot] ; $6e94
	add a ; $6e97
	ld_hl_indexed EndingCutsceneLocationList ; $6e98
	ld a, [hl+] ; $6e9f
	cp $ff ; $6ea0
	jr z, .done ; $6ea2
	and a ; $6ea4
	jr nz, .setLocation ; $6ea5
	ld a, [wStoryMainChar] ; $6ea7
	add a ; $6eaa
	ld a, [hl+] ; $6eab
.setLocation:
	ld [wStoryModeCurrentLocation], a ; $6eac
	ld a, [hl+] ; $6eaf
	ld [wStoryModeEntryPoint], a ; $6eb0
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $6eb3
	clear_flag FLAG_ACTORS_FROZEN ; $6eb6
	xor a ; $6eb9
	ld [wRasterScrollStartLY], a ; $6eba
	ld [wRasterScrollEndLY], a ; $6ebd
	call RunStoryLocation ; $6ec0
	test_flag FLAG_ENDING_CREDITS_PENDING ; $6ec3
	jr nz, .fadeOut ; $6ec6
	set_flag FLAG_VRAM_UPDATE_BUSY ; $6ec8
	call FreezeAllActors ; $6ecb
	farcall InitGrayscalePaletteFade ; $6ece
	ld b, $3f ; $6ed1
	ld c, $ff ; $6ed3
	ld d, $1e ; $6ed5
	farcall SetupPaletteFadeMask ; $6ed7
	farcall AnimatePaletteFadeToTarget ; $6eda
	ld a, [wStoryCharacterSlot] ; $6edd
	farcall PlayScrollingStoryCutscene ; $6ee0
.fadeOut:
	clear_flag FLAG_ENDING_CREDITS_PENDING ; $6ee3
	script_fade_out 4 ; $6ee6
	call WaitFadeEnd ; $6eeb
	ld a, SCREEN_HEIGHT_PX ; $6eee
	ldh [rWY], a ; $6ef0
	ld hl, wStoryCharacterSlot ; $6ef2
	inc [hl] ; $6ef5
	ldh a, [hDebugStepMode] ; $6ef6
	ASSERT DEBUGSTEP_OFF == 0
	or a ; $6ef8
	jr z, .nextScene ; $6ef9
	ldh a, [hPlayerInputFlags] ; $6efb
	bit PADB_SELECT, a ; $6efd
	jr nz, .done ; $6eff
.nextScene:
	jr .sceneLoop ; $6f01
.done:
	farcall ShowStoryResultScreen ; $6f03
	script_fade_out 8 ; $6f06
	call WaitFadeEnd ; $6f0b
	xor a ; $6f0e
	ldh [hScrollX], a ; $6f0f
	ldh [hScrollY], a ; $6f11
	farcall LoadMenuFontGfx ; $6f13
	clear_flag FLAG_ENDING_CREDITS_RUNNING ; $6f16
	clear_flag FLAG_ACTORS_FROZEN ; $6f19
	ret ; $6f1c
FreezeAllActors:
	wram_bank WRAM_ACTORS ; $6f1d
	ld de, wActors ; $6f23
	ld c, $18 ; $6f26
.actorLoop:
	inc e ; $6f28
	ld a, [de] ; $6f29
	dec e ; $6f2a
	or a ; $6f2b
	jp z, .next ; $6f2c
	ld hl, ACTORF_FLAGS ; $6f2f
	add hl, de ; $6f32
	set 0, [hl] ; $6f33
	set 1, [hl] ; $6f35
.next:
	ld hl, ACTOR_SIZE ; $6f37
	add hl, de ; $6f3a
	ld e, l ; $6f3b
	ld d, h ; $6f3c
	dec c ; $6f3d
	jp nz, .actorLoop ; $6f3e
	set_flag FLAG_ACTORS_FROZEN ; $6f41
	ret ; $6f44
Unused_0a_2:
	; $6f45, 4 bytes (bytes:4)
	db $df, $3a, $03, $c9 ; 0x00
	; $6f49, 4279 bytes fill to bank end (linker-padded)
