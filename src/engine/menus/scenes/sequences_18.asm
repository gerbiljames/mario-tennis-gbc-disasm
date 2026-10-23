PlayAwardsCeremonyScene:
	call SetupAwardsCeremonyScreen ; $77bb
	call InitAwardsCeremonyConfetti ; $77be
	frame_task TaskDrawObjectSprites_18 ; $77c1
	frame_task TaskUpdateObjects_18 ; $77c9
	sound BGM_CREDITS ; $77d1
	call EnableLCD ; $77d3
	script_fade_in 2 ; $77d6
	call WaitFadeEnd ; $77db
	wram_bank WRAM_SCREEN ; $77de
	xor a ; $77e4
	ld [wScreenSequenceTimer], a ; $77e5
.scrollLoop:
	call AdvanceFrame ; $77e8
	ldh a, [hVBlankCounter] ; $77eb
	and $03 ; $77ed
	jr nz, .scrollLoop ; $77ef
	ld a, [wScreenSequenceTimer] ; $77f1
	inc a ; $77f4
	ld [wScreenSequenceTimer], a ; $77f5
	cp $af ; $77f8
	jr nz, .scrollLoop ; $77fa
	script_fade_out 1 ; $77fc
	call WaitFadeEnd ; $7801
	call ClearFrameTasks ; $7804
	call DisableLCDSafely ; $7807
	farcall RunStaffCreditsRoll ; $780a
	call DisableLCDSafely ; $780d
	call LoadToBeContinuedOutlineGfx ; $7810
	call LoadAwardsCeremonyScreenBlackedOut ; $7813
	frame_task QueueToBeContinuedOutlineSprites ; $7816
	call EnableLCD ; $781e
	script_fade_in 64 ; $7821
	call WaitFadeEnd ; $7826
	sound BGM_THE_END ; $7829
.waitInput:
	call AdvanceFrame ; $782b
	ldh a, [hInputRepeat] ; $782e
	and PADF_A | PADF_B ; $7830
	jr z, .waitInput ; $7832
	ret ; $7834
SetupAwardsCeremonyScreen:
	call ResetScrollAndCamera ; $7835
	call LookupAwardsCeremonyAssetId ; $7838
	farcall LoadScreenAssetRecord ; $783b
	farcall QueueWram3MapToVRAM ; $783e
	ret ; $7841
LookupAwardsCeremonyAssetId:
	ld a, [wStorySceneAssetIndex] ; $7842
	ld hl, AwardsCeremonyAssetIds ; $7845
	add_hl_a ; $7848
	ld c, [hl] ; $784d
	ret ; $784e
AwardsCeremonyAssetIds:
	; $784f, 6 bytes (bytes:6)
	db SCREENASSET_AwardsCeremonyCutsceneDoublesBoys, SCREENASSET_AwardsCeremonyCutsceneDoublesBoyGirl, SCREENASSET_AwardsCeremonyCutsceneDoublesGirls, SCREENASSET_AwardsCeremonyCutsceneDoublesGirlBoy, SCREENASSET_AwardsCeremonyCutsceneSinglesBoy, SCREENASSET_AwardsCeremonyCutsceneSinglesGirl ; 0x00
LoadAwardsCeremonyScreenBlackedOut:
	call ResetScrollAndCamera ; $7855
	ld c, SCREENASSET_AwardsCeremonyCutsceneDoublesBoys ; $7858
	farcall LoadScreenAssetRecord ; $785a
	ld hl, BlackPalette_18 ; $785d
	ld_bg_pals de, 0, 1 ; $7860
	call LoadPaletteShadow ; $7863
	ld hl, BlackPalette_18 ; $7866
	ld_bg_pals de, 1, 1 ; $7869
	call LoadPaletteShadow ; $786c
	ld hl, BlackPalette_18 ; $786f
	ld_bg_pals de, 2, 1 ; $7872
	call LoadPaletteShadow ; $7875
	ld hl, BlackPalette_18 ; $7878
	ld_bg_pals de, 3, 1 ; $787b
	call LoadPaletteShadow ; $787e
	ld hl, BlackPalette_18 ; $7881
	ld_bg_pals de, 4, 1 ; $7884
	call LoadPaletteShadow ; $7887
	ld hl, BlackPalette_18 ; $788a
	ld_bg_pals de, 5, 1 ; $788d
	call LoadPaletteShadow ; $7890
	ld hl, BlackPalette_18 ; $7893
	ld_bg_pals de, 6, 1 ; $7896
	call LoadPaletteShadow ; $7899
	ld hl, BlackPalette_18 ; $789c
	ld_bg_pals de, 7, 1 ; $789f
	call LoadPaletteShadow ; $78a2
	farcall QueueWram3MapToVRAM ; $78a5
	ret ; $78a8
BlackPalette_18:
	INCLUDE "data/engine/menus/scenes/BlackPalette_18.asm" ; $78a9, 8 bytes (palettes)
LoadToBeContinuedOutlineGfx:
	ld b, TILEBLOCK_ToBeContinuedOutlineGfx ; $78b1
	ld c, ToBeContinuedOutlineGfx_SIZE / 16 ; $78b3
	ld de, vTiles0 ; $78b5
	farcall LoadCompressedTileBlock ; $78b8
	ld hl, ToBeContinuedOutlinePalette ; $78bb
	ld_obj_pals de, 0, 1 ; $78be
	call LoadPaletteShadow ; $78c1
	ret ; $78c4
ToBeContinuedOutlinePalette:
	INCLUDE "data/engine/menus/scenes/ToBeContinuedOutlinePalette.asm" ; $78c5, 8 bytes (palettes)
QueueToBeContinuedOutlineSprites:
	ld hl, QueueToBeContinuedOutlineSprites_SpriteTemplate ; $78cd
	ld_xy de, $28, $3a ; $78d0
	sprite_tile_attr $00, 0 ; $78d3
	call QueueSpriteTemplate ; $78d7
	ret ; $78da
QueueToBeContinuedOutlineSprites_SpriteTemplate:
	; $78db, 81 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite $10, $48, $20, $00
	oam_sprite $20, $48, $22, $00
	oam_sprite $10, $50, $24, $00
	oam_sprite $20, $50, $26, $00
	oam_sprite_end
PlayDreamMatchEpilogueScene:
	call ResetScrollAndCamera ; $792c
	sound BGM_WIN ; $792f
	call LookupDreamMatchEpilogueAssetId ; $7931
	farcall LoadScreenAssetRecord ; $7934
	farcall QueueWram3MapToVRAM ; $7937
	call InitDreamMatchEpilogueConfetti ; $793a
	frame_task TaskDrawObjectSprites_18 ; $793d
	frame_task TaskUpdateObjects_18 ; $7945
	call EnableLCD ; $794d
	script_fade_in 1 ; $7950
	call WaitFadeEnd ; $7955
.waitWinScreenInput:
	call AdvanceFrame ; $7958
	ldh a, [hInputRepeat] ; $795b
	and PADF_A | PADF_B ; $795d
	jr z, .waitWinScreenInput ; $795f
	script_fade_out 2 ; $7961
	call WaitFadeEnd ; $7966
	ld_flag_id de, FLAG_DOUBLES ; $7969
	call TestGameFlag ; $796c
	jr z, .singles ; $796f
	ld_flag_id de, FLAG_ENDING_SEEN_DOUBLES ; $7971
	call TestGameFlag ; $7974
	jr z, .runCredits ; $7977
	jr .showTheEnd ; $7979
.singles:
	ld_flag_id de, FLAG_ENDING_SEEN_SINGLES ; $797b
	call TestGameFlag ; $797e
	jr z, .runCredits ; $7981
	jr .showTheEnd ; $7983
.runCredits:
	sound BGM_CREDITS ; $7985
	farcall RunEndingCreditsSequence ; $7987
.showTheEnd:
	wram_bank WRAM_SCREEN ; $798a
	xor a ; $7990
	ld [wTheEndPaletteFadeStep], a ; $7991
	call ClearFrameTasks ; $7994
	call ResetScrollAndCamera ; $7997
	call DisableLCDSafely ; $799a
	call LookupChampionMedalAssetId ; $799d
	farcall LoadScreenAssetRecord ; $79a0
	farcall QueueWram3MapToVRAM ; $79a3
	call LoadTheEndGfx ; $79a6
	call EnableLCD ; $79a9
	script_fade_in 2 ; $79ac
	call WaitFadeEnd ; $79b1
	wram_bank WRAM_SCREEN ; $79b4
	xor a ; $79ba
	ld [wScreenSequenceTimer], a ; $79bb
.theEndDelay:
	call AdvanceFrame ; $79be
	ld a, [wScreenSequenceTimer] ; $79c1
	inc a ; $79c4
	ld [wScreenSequenceTimer], a ; $79c5
	cp $b4 ; $79c8
	jr nz, .theEndDelay ; $79ca
	frame_task TaskFadeInTheEndPalette ; $79cc
	frame_task QueueTheEndSprites ; $79d4
	sound BGM_THE_END ; $79dc
.waitTheEndInput:
	call AdvanceFrame ; $79de
	ldh a, [hInputRepeat] ; $79e1
	and PADF_A | PADF_B ; $79e3
	jr z, .waitTheEndInput ; $79e5
	ld de, SAVEFLAG_OPENING_SEEN ; $79e7
	farcall SetSaveFlag ; $79ea
	ld_flag_id de, FLAG_DOUBLES ; $79ed
	call TestGameFlag ; $79f0
	jr z, .singlesEndingSeen ; $79f3
	ld_flag_id de, FLAG_ENDING_SEEN_DOUBLES ; $79f5
	call SetGameFlag ; $79f8
	jr .done ; $79fb
.singlesEndingSeen:
	ld_flag_id de, FLAG_ENDING_SEEN_SINGLES ; $79fd
	call SetGameFlag ; $7a00
.done:
	farcall SaveStorySlotWithTimer ; $7a03
	ret ; $7a06
LookupDreamMatchEpilogueAssetId:
	ld a, [wStorySceneAssetIndex] ; $7a07
	ld hl, DreamMatchEpilogueAssetIds ; $7a0a
	add_hl_a ; $7a0d
	ld c, [hl] ; $7a12
	ret ; $7a13
DreamMatchEpilogueAssetIds:
	; $7a14, 6 bytes (bytes:6)
	db SCREENASSET_DreamMatchEpilogueDoublesBoys, SCREENASSET_DreamMatchEpilogueDoublesBoyGirl, SCREENASSET_DreamMatchEpilogueDoublesGirls, SCREENASSET_DreamMatchEpilogueDoublesGirlBoy, SCREENASSET_DreamMatchEpilogueSinglesBoy, SCREENASSET_DreamMatchEpilogueSinglesGirl ; 0x00
LookupChampionMedalAssetId:
	ld a, [wStorySceneAssetIndex] ; $7a1a
	ld hl, ChampionMedalAssetIds ; $7a1d
	add_hl_a ; $7a20
	ld c, [hl] ; $7a25
	ret ; $7a26
ChampionMedalAssetIds:
	; $7a27, 6 bytes (bytes:6)
	db SCREENASSET_ChampionMedalDoublesBoys, SCREENASSET_ChampionMedalDoublesBoyGirl, SCREENASSET_ChampionMedalDoublesGirls, SCREENASSET_ChampionMedalDoublesGirlBoy, SCREENASSET_ChampionMedalSinglesBoy, SCREENASSET_ChampionMedalSinglesGirl ; 0x00
LoadTheEndGfx:
	ld b, TILEBLOCK_TheEndGfx ; $7a2d
	ld c, TheEndGfx_SIZE / 16 ; $7a2f
	ld de, vTiles0 ; $7a31
	farcall LoadCompressedTileBlock ; $7a34
	ld hl, TheEndPalette ; $7a37
	ld_obj_pals de, 0, 1 ; $7a3a
	call LoadPaletteShadow ; $7a3d
	ret ; $7a40
TheEndPalette:
	INCLUDE "data/engine/menus/scenes/TheEndPalette.asm" ; $7a41, 8 bytes (palettes)
QueueTheEndSprites:
	ld hl, QueueTheEndSprites_SpriteTemplate ; $7a49
	ld_xy de, $28, $40 ; $7a4c
	sprite_tile_attr $00, 0 ; $7a4f
	call QueueSpriteTemplate ; $7a53
	ret ; $7a56
QueueTheEndSprites_SpriteTemplate:
	; $7a57, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
Unused_18_StubNop2:
	ret ; $7a80
TaskFadeInTheEndPalette:
	push_wram_bank WRAM_SCREEN ; $7a81
	ld a, [wTheEndPaletteFadeStep] ; $7a8a
	cp $10 ; $7a8d
	jr z, .done ; $7a8f
	add a ; $7a91
	add a ; $7a92
	add a ; $7a93
	ld hl, TheEndFadeInPalettes ; $7a94
	add_hl_a ; $7a97
	ld_obj_pals de, 0, 1 ; $7a9c
	call LoadPalettesImmediate ; $7a9f
	ldh a, [hVBlankCounter] ; $7aa2
	and $03 ; $7aa4
	jr nz, .done ; $7aa6
	ld a, [wTheEndPaletteFadeStep] ; $7aa8
	inc a ; $7aab
	ld [wTheEndPaletteFadeStep], a ; $7aac
.done:
	pop_wram_bank ; $7aaf
	ret ; $7ab4
TheEndFadeInPalettes:
	INCLUDE "data/engine/menus/scenes/TheEndFadeInPalettes.asm" ; $7ab5, 128 bytes (palettes)
Unused_18_StubRet3:
	ret ; $7b35
TaskDrawObjectSprites_18:
	ld c, $00 ; $7b36
.objectLoop:
	push bc ; $7b38
	ld hl, wScreenScratch ; $7b39
	ld a, c ; $7b3c
	add a ; $7b3d
	add a ; $7b3e
	add a ; $7b3f
	add a ; $7b40
	add_hl_a ; $7b41
	ld a, [hl+] ; $7b46
	ld b, a ; $7b47
	inc hl ; $7b48
	ld a, [hl+] ; $7b49
	ld d, a ; $7b4a
	inc hl ; $7b4b
	ld a, [hl+] ; $7b4c
	ld e, a ; $7b4d
	inc hl ; $7b4e
	inc hl ; $7b4f
	ld a, [hl] ; $7b50
	ld c, a ; $7b51
	push af ; $7b52
	push bc ; $7b53
	push de ; $7b54
	push hl ; $7b55
	call QueueSprite ; $7b56
	pop hl ; $7b59
	pop de ; $7b5a
	pop bc ; $7b5b
	pop af ; $7b5c
	ld a, $08 ; $7b5d
	add d ; $7b5f
	ld d, a ; $7b60
	inc c ; $7b61
	inc c ; $7b62
	call QueueSprite ; $7b63
	pop bc ; $7b66
	inc c ; $7b67
	ld a, c ; $7b68
	cp NUM_SCENEOBJS ; $7b69
	jr nz, .objectLoop ; $7b6b
	ret ; $7b6d
TaskUpdateObjects_18:
	ld c, $00 ; $7b6e
.objectLoop:
	push bc ; $7b70
	ld hl, wScreenScratch ; $7b71
	ld a, c ; $7b74
	add a ; $7b75
	add a ; $7b76
	add a ; $7b77
	add a ; $7b78
	add_hl_a ; $7b79
	ld b, h ; $7b7e
	ld c, l ; $7b7f
	ld hl, SCENEOBJ_X_STEP ; $7b80
	add hl, bc ; $7b83
	ld a, [hl] ; $7b84
	ld e, a ; $7b85
	ld hl, SCENEOBJ_X ; $7b86
	add hl, bc ; $7b89
	ld a, [hl+] ; $7b8a
	ld h, [hl] ; $7b8b
	ld l, a ; $7b8c
	ld d, $00 ; $7b8d
	add hl, de ; $7b8f
	ld d, h ; $7b90
	ld e, l ; $7b91
	ld hl, SCENEOBJ_X ; $7b92
	add hl, bc ; $7b95
	ld [hl], e ; $7b96
	inc hl ; $7b97
	ld [hl], d ; $7b98
	ld hl, SCENEOBJ_Y_STEP ; $7b99
	add hl, bc ; $7b9c
	ld a, [hl] ; $7b9d
	ld e, a ; $7b9e
	ld hl, SCENEOBJ_Y ; $7b9f
	add hl, bc ; $7ba2
	ld a, [hl+] ; $7ba3
	ld h, [hl] ; $7ba4
	ld l, a ; $7ba5
	ld d, $00 ; $7ba6
	add hl, de ; $7ba8
	ld d, h ; $7ba9
	ld e, l ; $7baa
	ld hl, SCENEOBJ_Y ; $7bab
	add hl, bc ; $7bae
	ld [hl], e ; $7baf
	inc hl ; $7bb0
	ld [hl], d ; $7bb1
	ld hl, SCENEOBJ_CALLBACK ; $7bb2
	add hl, bc ; $7bb5
	ld a, [hl+] ; $7bb6
	ld h, [hl] ; $7bb7
	ld l, a ; $7bb8
	jp hl ; $7bb9
ObjectUpdateLoopTail_18:
	ld hl, SCENEOBJ_Y + 1 ; $7bba
	add hl, bc ; $7bbd
	ld a, [hl] ; $7bbe
	cp $c0 ; $7bbf
	jr c, .next ; $7bc1
	ld a, $10 ; $7bc3
	ld [hl], a ; $7bc5
.next:
	pop bc ; $7bc6
	inc c ; $7bc7
	ld a, c ; $7bc8
	cp NUM_SCENEOBJS ; $7bc9
	jr nz, TaskUpdateObjects_18.objectLoop ; $7bcb
	ret ; $7bcd
InitAwardsCeremonyConfetti:
	push_wram_bank WRAM_SCREEN ; $7bce
	ld hl, wScreenScratch ; $7bd7
	ld bc, NUM_SCENEOBJS * SCENEOBJ_SIZE ; $7bda
	call ClearBytes ; $7bdd
	call SpawnAwardsCeremonyConfetti ; $7be0
	call LoadAwardsCeremonyConfettiGfx ; $7be3
	ret ; $7be6
LoadAwardsCeremonyConfettiGfx:
	ld b, TILEBLOCK_AwardsCeremonyConfettiGfx0 ; $7be7
	ld c, AwardsCeremonyConfettiGfx0_SIZE / 16 ; $7be9
	ld de, vTiles0 ; $7beb
	farcall LoadCompressedTileBlock ; $7bee
	ld b, TILEBLOCK_AwardsCeremonyConfettiGfx1 ; $7bf1
	ld c, AwardsCeremonyConfettiGfx1_SIZE / 16 ; $7bf3
	ld de, vTiles0 tile $10 ; $7bf5
	farcall LoadCompressedTileBlock ; $7bf8
	ld b, TILEBLOCK_AwardsCeremonyConfettiGfx2 ; $7bfb
	ld c, AwardsCeremonyConfettiGfx2_SIZE / 16 ; $7bfd
	ld de, vTiles0 tile $20 ; $7bff
	farcall LoadCompressedTileBlock ; $7c02
	ld hl, AwardsCeremonyConfettiPalettes ; $7c05
	ld_obj_pals de, 1, 3 ; $7c08
	call LoadPaletteShadow ; $7c0b
	ret ; $7c0e
AwardsCeremonyConfettiPalettes:
	INCLUDE "data/engine/menus/scenes/AwardsCeremonyConfettiPalettes.asm" ; $7c0f, 24 bytes (palettes)
