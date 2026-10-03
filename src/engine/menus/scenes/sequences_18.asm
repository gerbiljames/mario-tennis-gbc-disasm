PlayScreenSequence1:
	call SetupScreen1Assets ; $77bb
	call InitObjectSceneA ; $77be
	ld a, $01 ; $77c1
	ld hl, TaskDrawObjectSprites_18 ; $77c3
	call RegisterFrameTask ; $77c6
	ld a, $01 ; $77c9
	ld hl, TaskUpdateObjects_18 ; $77cb
	call RegisterFrameTask ; $77ce
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
	ld c, 1 ; $77fc
	call BeginFadeOut ; $77fe
	call WaitFadeEnd ; $7801
	call ClearFrameTasks ; $7804
	call DisableLCDSafely ; $7807
	farcall RunScrollingTextScreen ; $780a
	call DisableLCDSafely ; $780d
	call LoadScreen1ObjTiles ; $7810
	call FillAllBgPalettes ; $7813
	ld a, $01 ; $7816
	ld hl, QueueScreen1Sprites ; $7818
	call RegisterFrameTask ; $781b
	call EnableLCD ; $781e
	script_fade_in 64 ; $7821
	call WaitFadeEnd ; $7826
	sound BGM_THE_END ; $7829
.waitInput:
	call AdvanceFrame ; $782b
	ldh a, [hInputPressed] ; $782e
	and PADF_A | PADF_B ; $7830
	jr z, .waitInput ; $7832
	ret ; $7834
SetupScreen1Assets:
	call ResetScrollAndCamera ; $7835
	call LookupScreen1AssetId ; $7838
	farcall LoadScreenAssetRecord ; $783b
	farcall QueueWram3MapToVRAM ; $783e
	ret ; $7841
LookupScreen1AssetId:
	ld a, [wStorySceneAssetIndex] ; $7842
	ld hl, Screen1AssetIdTable ; $7845
	add l ; $7848
	ld l, a ; $7849
	jr nc, .read ; $784a
	inc h ; $784c
.read:
	ld c, [hl] ; $784d
	ret ; $784e
Screen1AssetIdTable:
	; $784f, 6 bytes (bytes:6)
	db SCREENASSET_ShopCutscene, SCREENASSET_ShopCutscene2, SCREENASSET_ShopCutscene4, SCREENASSET_ShopCutscene3, SCREENASSET_ShopCutscene5, SCREENASSET_ShopCutscene6 ; 0x00
FillAllBgPalettes:
	call ResetScrollAndCamera ; $7855
	ld c, SCREENASSET_ShopCutscene ; $7858
	farcall LoadScreenAssetRecord ; $785a
	ld hl, AllBgPalettes ; $785d
	ld_bg_pals de, 0, 1 ; $7860
	call LoadPaletteShadow ; $7863
	ld hl, AllBgPalettes ; $7866
	ld_bg_pals de, 1, 1 ; $7869
	call LoadPaletteShadow ; $786c
	ld hl, AllBgPalettes ; $786f
	ld_bg_pals de, 2, 1 ; $7872
	call LoadPaletteShadow ; $7875
	ld hl, AllBgPalettes ; $7878
	ld_bg_pals de, 3, 1 ; $787b
	call LoadPaletteShadow ; $787e
	ld hl, AllBgPalettes ; $7881
	ld_bg_pals de, 4, 1 ; $7884
	call LoadPaletteShadow ; $7887
	ld hl, AllBgPalettes ; $788a
	ld_bg_pals de, 5, 1 ; $788d
	call LoadPaletteShadow ; $7890
	ld hl, AllBgPalettes ; $7893
	ld_bg_pals de, 6, 1 ; $7896
	call LoadPaletteShadow ; $7899
	ld hl, AllBgPalettes ; $789c
	ld_bg_pals de, 7, 1 ; $789f
	call LoadPaletteShadow ; $78a2
	farcall QueueWram3MapToVRAM ; $78a5
	ret ; $78a8
AllBgPalettes:
	INCLUDE "data/bank_018/AllBgPalettes.asm" ; $78a9, 8 bytes (palettes)
LoadScreen1ObjTiles:
	ld b, TILEBLOCK_Screen1ObjGfx ; $78b1
	ld c, Screen1ObjGfx_SIZE / 16 ; $78b3
	ld de, vTiles0 ; $78b5
	farcall LoadCompressedTileBlock ; $78b8
	ld hl, Screen1ObjPalette ; $78bb
	ld_obj_pals de, 0, 1 ; $78be
	call LoadPaletteShadow ; $78c1
	ret ; $78c4
Screen1ObjPalette:
	INCLUDE "data/bank_018/Screen1ObjPalette.asm" ; $78c5, 8 bytes (palettes)
QueueScreen1Sprites:
	ld hl, QueueScreen1Sprites_SpriteTemplate ; $78cd
	ld_xy de, $28, $3a ; $78d0
	sprite_tile_attr $00, 0 ; $78d3
	call QueueSpriteTemplate ; $78d7
	ret ; $78da
QueueScreen1Sprites_SpriteTemplate:
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
PlayScreenSequence2:
	call ResetScrollAndCamera ; $792c
	sound BGM_WIN ; $792f
	call LookupScreen2AssetIdA ; $7931
	farcall LoadScreenAssetRecord ; $7934
	farcall QueueWram3MapToVRAM ; $7937
	call InitObjectSceneB ; $793a
	ld a, $01 ; $793d
	ld hl, TaskDrawObjectSprites_18 ; $793f
	call RegisterFrameTask ; $7942
	ld a, $01 ; $7945
	ld hl, TaskUpdateObjects_18 ; $7947
	call RegisterFrameTask ; $794a
	call EnableLCD ; $794d
	script_fade_in 1 ; $7950
	call WaitFadeEnd ; $7955
.scene1:
	call AdvanceFrame ; $7958
	ldh a, [hInputPressed] ; $795b
	and PADF_A | PADF_B ; $795d
	jr z, .scene1 ; $795f
	ld c, 2 ; $7961
	call BeginFadeOut ; $7963
	call WaitFadeEnd ; $7966
	ld_flag_id de, FLAG_DOUBLES ; $7969
	call TestGameFlag ; $796c
	jr z, .scene2 ; $796f
	ld_flag_id de, FLAG_ENDING_SEEN_DOUBLES ; $7971
	call TestGameFlag ; $7974
	jr z, .scene2Wait ; $7977
	jr .scene3 ; $7979
.scene2:
	ld_flag_id de, FLAG_ENDING_SEEN_SINGLES ; $797b
	call TestGameFlag ; $797e
	jr z, .scene2Wait ; $7981
	jr .scene3 ; $7983
.scene2Wait:
	sound BGM_CREDITS ; $7985
	farcall RunEndingCreditsSequence ; $7987
.scene3:
	wram_bank WRAM_SCREEN ; $798a
	xor a ; $7990
	ld [wEndingSceneStep], a ; $7991
	call ClearFrameTasks ; $7994
	call ResetScrollAndCamera ; $7997
	call DisableLCDSafely ; $799a
	call LookupScreen2AssetIdB ; $799d
	farcall LoadScreenAssetRecord ; $79a0
	farcall QueueWram3MapToVRAM ; $79a3
	call LoadScreen2ObjTiles ; $79a6
	call EnableLCD ; $79a9
	script_fade_in 2 ; $79ac
	call WaitFadeEnd ; $79b1
	wram_bank WRAM_SCREEN ; $79b4
	xor a ; $79ba
	ld [wScreenSequenceTimer], a ; $79bb
.scene4:
	call AdvanceFrame ; $79be
	ld a, [wScreenSequenceTimer] ; $79c1
	inc a ; $79c4
	ld [wScreenSequenceTimer], a ; $79c5
	cp $b4 ; $79c8
	jr nz, .scene4 ; $79ca
	ld a, $01 ; $79cc
	ld hl, TaskFadeInPalette_18 ; $79ce
	call RegisterFrameTask ; $79d1
	ld a, $01 ; $79d4
	ld hl, QueueScreen2Sprites ; $79d6
	call RegisterFrameTask ; $79d9
	sound BGM_THE_END ; $79dc
.scene5:
	call AdvanceFrame ; $79de
	ldh a, [hInputPressed] ; $79e1
	and PADF_A | PADF_B ; $79e3
	jr z, .scene5 ; $79e5
	ld de, SAVEFLAG_OPENING_SEEN ; $79e7
	farcall SetSaveFlag ; $79ea
	ld_flag_id de, FLAG_DOUBLES ; $79ed
	call TestGameFlag ; $79f0
	jr z, .fadeOut ; $79f3
	ld_flag_id de, FLAG_ENDING_SEEN_DOUBLES ; $79f5
	call SetGameFlag ; $79f8
	jr .done ; $79fb
.fadeOut:
	ld_flag_id de, FLAG_ENDING_SEEN_SINGLES ; $79fd
	call SetGameFlag ; $7a00
.done:
	farcall SaveStorySlotWithTimer ; $7a03
	ret ; $7a06
LookupScreen2AssetIdA:
	ld a, [wStorySceneAssetIndex] ; $7a07
	ld hl, Screen2AssetIdATable ; $7a0a
	add l ; $7a0d
	ld l, a ; $7a0e
	jr nc, .read ; $7a0f
	inc h ; $7a11
.read:
	ld c, [hl] ; $7a12
	ret ; $7a13
Screen2AssetIdATable:
	; $7a14, 6 bytes (bytes:6)
	db SCREENASSET_AwardCeremony, SCREENASSET_AwardCeremony2, SCREENASSET_AwardCeremony4, SCREENASSET_AwardCeremony3, SCREENASSET_AwardCeremony5, SCREENASSET_AwardCeremony6 ; 0x00
LookupScreen2AssetIdB:
	ld a, [wStorySceneAssetIndex] ; $7a1a
	ld hl, Screen2AssetIdBTable ; $7a1d
	add l ; $7a20
	ld l, a ; $7a21
	jr nc, .read ; $7a22
	inc h ; $7a24
.read:
	ld c, [hl] ; $7a25
	ret ; $7a26
Screen2AssetIdBTable:
	; $7a27, 6 bytes (bytes:6)
	db SCREENASSET_ChampionMedal, SCREENASSET_ChampionMedal2, SCREENASSET_ChampionMedal4, SCREENASSET_ChampionMedal3, SCREENASSET_ChampionMedal5, SCREENASSET_ChampionMedal6 ; 0x00
LoadScreen2ObjTiles:
	ld b, TILEBLOCK_Screen2ObjGfx ; $7a2d
	ld c, Screen2ObjGfx_SIZE / 16 ; $7a2f
	ld de, vTiles0 ; $7a31
	farcall LoadCompressedTileBlock ; $7a34
	ld hl, Screen2ObjPalette ; $7a37
	ld_obj_pals de, 0, 1 ; $7a3a
	call LoadPaletteShadow ; $7a3d
	ret ; $7a40
Screen2ObjPalette:
	INCLUDE "data/bank_018/Screen2ObjPalette.asm" ; $7a41, 8 bytes (palettes)
QueueScreen2Sprites:
	ld hl, QueueScreen2Sprites_SpriteTemplate ; $7a49
	ld_xy de, $28, $40 ; $7a4c
	sprite_tile_attr $00, 0 ; $7a4f
	call QueueSpriteTemplate ; $7a53
	ret ; $7a56
QueueScreen2Sprites_SpriteTemplate:
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
Unused_18_StubNop_7a80:
	ret ; $7a80
TaskFadeInPalette_18:
	push_wram_bank WRAM_SCREEN ; $7a81
	ld a, [wEndingSceneStep] ; $7a8a
	cp $10 ; $7a8d
	jr z, .alt2 ; $7a8f
	add a ; $7a91
	add a ; $7a92
	add a ; $7a93
	ld hl, PaletteFadeTable_18 ; $7a94
	add l ; $7a97
	ld l, a ; $7a98
	jr nc, .read ; $7a99
	inc h ; $7a9b
.read:
	ld_obj_pals de, 0, 1 ; $7a9c
	call LoadPalettesImmediate ; $7a9f
	ldh a, [hVBlankCounter] ; $7aa2
	and $03 ; $7aa4
	jr nz, .alt2 ; $7aa6
	ld a, [wEndingSceneStep] ; $7aa8
	inc a ; $7aab
	ld [wEndingSceneStep], a ; $7aac
.alt2:
	pop_wram_bank ; $7aaf
	ret ; $7ab4
PaletteFadeTable_18:
	INCLUDE "data/bank_018/PaletteFadeTable_18.asm" ; $7ab5, 128 bytes (palettes)
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
	add l ; $7b41
	ld l, a ; $7b42
	jr nc, .read ; $7b43
	inc h ; $7b45
.read:
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
	cp $10 ; $7b69
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
	add l ; $7b79
	ld l, a ; $7b7a
	jr nc, .updateObject ; $7b7b
	inc h ; $7b7d
.updateObject:
	ld b, h ; $7b7e
	ld c, l ; $7b7f
	ld hl, $0005 ; $7b80
	add hl, bc ; $7b83
	ld a, [hl] ; $7b84
	ld e, a ; $7b85
	ld hl, $0001 ; $7b86
	add hl, bc ; $7b89
	ld a, [hl+] ; $7b8a
	ld h, [hl] ; $7b8b
	ld l, a ; $7b8c
	ld d, $00 ; $7b8d
	add hl, de ; $7b8f
	ld d, h ; $7b90
	ld e, l ; $7b91
	ld hl, $0001 ; $7b92
	add hl, bc ; $7b95
	ld [hl], e ; $7b96
	inc hl ; $7b97
	ld [hl], d ; $7b98
	ld hl, $0006 ; $7b99
	add hl, bc ; $7b9c
	ld a, [hl] ; $7b9d
	ld e, a ; $7b9e
	ld hl, $0003 ; $7b9f
	add hl, bc ; $7ba2
	ld a, [hl+] ; $7ba3
	ld h, [hl] ; $7ba4
	ld l, a ; $7ba5
	ld d, $00 ; $7ba6
	add hl, de ; $7ba8
	ld d, h ; $7ba9
	ld e, l ; $7baa
	ld hl, $0003 ; $7bab
	add hl, bc ; $7bae
	ld [hl], e ; $7baf
	inc hl ; $7bb0
	ld [hl], d ; $7bb1
	ld hl, $0009 ; $7bb2
	add hl, bc ; $7bb5
	ld a, [hl+] ; $7bb6
	ld h, [hl] ; $7bb7
	ld l, a ; $7bb8
	jp hl ; $7bb9
ObjectUpdateLoopTail_18:
	ld hl, $0004 ; $7bba
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
	cp $10 ; $7bc9
	jr nz, TaskUpdateObjects_18.objectLoop ; $7bcb
	ret ; $7bcd
InitObjectSceneA:
	push_wram_bank WRAM_SCREEN ; $7bce
	ld hl, wScreenScratch ; $7bd7
	ld bc, $0100 ; $7bda
	call ClearBytes ; $7bdd
	call PopulateObjectArrayA ; $7be0
	call LoadObjectSceneATiles ; $7be3
	ret ; $7be6
LoadObjectSceneATiles:
	ld b, TILEBLOCK_ObjectSceneAGfx0 ; $7be7
	ld c, ObjectSceneAGfx0_SIZE / 16 ; $7be9
	ld de, vTiles0 ; $7beb
	farcall LoadCompressedTileBlock ; $7bee
	ld b, TILEBLOCK_ObjectSceneAGfx1 ; $7bf1
	ld c, ObjectSceneAGfx1_SIZE / 16 ; $7bf3
	ld de, vTiles0 + $10 * TILE_SIZE ; $7bf5
	farcall LoadCompressedTileBlock ; $7bf8
	ld b, TILEBLOCK_ObjectSceneAGfx2 ; $7bfb
	ld c, ObjectSceneAGfx2_SIZE / 16 ; $7bfd
	ld de, vTiles0 + $20 * TILE_SIZE ; $7bff
	farcall LoadCompressedTileBlock ; $7c02
	ld hl, ObjectSceneATilesPalettes ; $7c05
	ld_obj_pals de, 1, 3 ; $7c08
	call LoadPaletteShadow ; $7c0b
	ret ; $7c0e
ObjectSceneATilesPalettes:
	; $7c0f, 24 bytes (bytes:8)
	db $ff, $6b, $df, $5a, $ff, $20, $00, $00 ; 0x00
	db $ff, $6b, $b8, $3b, $80, $12, $00, $00 ; 0x08
	db $ff, $6b, $bf, $53, $9f, $02, $00, $00 ; 0x10
