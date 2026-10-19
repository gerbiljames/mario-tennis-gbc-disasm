AnimateCharDataStatsReveal:
	sound BGM_STAT_DISTRIBUTION ; $4682
	call BackupCharDataScreenRow ; $4684
	wram_bank WRAM_SCENE ; $4687
.loop:
	call AdvanceFrame ; $468d
	ld a, [wCharDataFlushChunk] ; $4690
	or a ; $4693
	jr nz, .loop ; $4694
	call RestoreCharDataScreenRow ; $4696
	ld hl, CharDataBand0RunsStep1_1c ; $4699
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $469c
	call BlitTilemapRunsFromTable ; $469f
	ld hl, CharDataBand3RunsStep1_1c ; $46a2
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $46a5
	call BlitTilemapRunsFromTable ; $46a8
	wram_bank WRAM_SCENE ; $46ab
	ld a, $09 ; $46b1
	ld [wCharDataRevealTimer], a ; $46b3
	call FlushCharDataTilemaps ; $46b6
	call RestoreCharDataScreenRow ; $46b9
	ld hl, CharDataBand0RunsStep2_1c ; $46bc
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $46bf
	call BlitTilemapRunsFromTable ; $46c2
	ld hl, CharDataBand1RunsStep1_1c ; $46c5
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $46c8
	call BlitTilemapRunsFromTable ; $46cb
	ld hl, CharDataBand2RunsStep1_1c ; $46ce
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $46d1
	call BlitTilemapRunsFromTable ; $46d4
	ld hl, CharDataBand3RunsStep2_1c ; $46d7
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $46da
	call BlitTilemapRunsFromTable ; $46dd
	wram_bank WRAM_SCENE ; $46e0
	ld a, $07 ; $46e6
	ld [wCharDataRevealTimer], a ; $46e8
	call FlushCharDataTilemaps ; $46eb
	call RestoreCharDataScreenRow ; $46ee
	ld hl, CharDataBand0RunsStep3_1c ; $46f1
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $46f4
	call BlitTilemapRunsFromTable ; $46f7
	ld hl, CharDataBand1RunsStep2_1c ; $46fa
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $46fd
	call BlitTilemapRunsFromTable ; $4700
	ld hl, CharDataBand2RunsStep2_1c ; $4703
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $4706
	call BlitTilemapRunsFromTable ; $4709
	ld hl, CharDataBand3RunsStep3_1c ; $470c
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $470f
	call BlitTilemapRunsFromTable ; $4712
	wram_bank WRAM_SCENE ; $4715
	ld a, $05 ; $471b
	ld [wCharDataRevealTimer], a ; $471d
	call FlushCharDataTilemaps ; $4720
	call RestoreCharDataScreenRow ; $4723
	ld hl, CharDataBand0RunsStep4_1c ; $4726
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $4729
	call BlitTilemapRunsFromTable ; $472c
	ld hl, CharDataBand1RunsStep3_1c ; $472f
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $4732
	call BlitTilemapRunsFromTable ; $4735
	ld hl, CharDataBand2RunsStep3_1c ; $4738
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $473b
	call BlitTilemapRunsFromTable ; $473e
	ld hl, CharDataBand3RunsStep4_1c ; $4741
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $4744
	call BlitTilemapRunsFromTable ; $4747
	wram_bank WRAM_SCENE ; $474a
	ld a, $03 ; $4750
	ld [wCharDataRevealTimer], a ; $4752
	call FlushCharDataTilemaps ; $4755
	call RestoreCharDataScreenRow ; $4758
	ld hl, CharDataBand0RunsStep5_1c ; $475b
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $475e
	call BlitTilemapRunsFromTable ; $4761
	ld hl, CharDataBand1RunsStep4_1c ; $4764
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $4767
	call BlitTilemapRunsFromTable ; $476a
	ld hl, CharDataBand2RunsStep4_1c ; $476d
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $4770
	call BlitTilemapRunsFromTable ; $4773
	ld hl, CharDataBand3RunsStep5_1c ; $4776
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $4779
	call BlitTilemapRunsFromTable ; $477c
	wram_bank WRAM_SCENE ; $477f
	ld a, $02 ; $4785
	ld [wCharDataRevealTimer], a ; $4787
	call FlushCharDataTilemaps ; $478a
	call RestoreCharDataScreenRow ; $478d
	ld hl, CharDataBand0RunsStep6_1c ; $4790
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $4793
	call BlitTilemapRunsFromTable ; $4796
	ld hl, CharDataBand1RunsStep5_1c ; $4799
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $479c
	call BlitTilemapRunsFromTable ; $479f
	ld hl, CharDataBand2RunsStep5_1c ; $47a2
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $47a5
	call BlitTilemapRunsFromTable ; $47a8
	ld hl, CharDataBand3RunsStep6_1c ; $47ab
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $47ae
	call BlitTilemapRunsFromTable ; $47b1
	wram_bank WRAM_SCENE ; $47b4
	ld a, $01 ; $47ba
	ld [wCharDataRevealTimer], a ; $47bc
	call FlushCharDataTilemaps ; $47bf
	call RestoreCharDataScreenRow ; $47c2
	ld hl, CharDataBand0RunsStep7_1c ; $47c5
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $47c8
	call BlitTilemapRunsFromTable ; $47cb
	ld hl, CharDataBand1RunsStep6_1c ; $47ce
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $47d1
	call BlitTilemapRunsFromTable ; $47d4
	ld hl, CharDataBand2RunsStep6_1c ; $47d7
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $47da
	call BlitTilemapRunsFromTable ; $47dd
	ld hl, CharDataBand3RunsStep7_1c ; $47e0
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $47e3
	call BlitTilemapRunsFromTable ; $47e6
	wram_bank WRAM_SCENE ; $47e9
	ld hl, wCharDataPageArrowMode ; $47ef
	dec [hl] ; $47f2
	xor a ; $47f3
	ld [wCharDataRevealTimer], a ; $47f4
	call FlushCharDataTilemaps ; $47f7
	wait_frames 6 ; $47fa
	ld hl, CharDataBand4RunsStep1_1c ; $47fe
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $4801
	call BlitTilemapRunsFromTable ; $4804
	call FlushCharDataTilemaps ; $4807
	ld hl, CharDataBand4RunsStep2_1c ; $480a
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $480d
	call BlitTilemapRunsFromTable ; $4810
	call FlushCharDataTilemaps ; $4813
	ld hl, CharDataBand4RunsStep3_1c ; $4816
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $4819
	call BlitTilemapRunsFromTable ; $481c
	call FlushCharDataTilemaps ; $481f
	ld hl, CharDataBand6RunsStep1_1c ; $4822
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4825
	call BlitTilemapRunsFromTable ; $4828
	ld hl, CharDataBand5RunsStep1_1c ; $482b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $482e
	call BlitTilemapRunsFromTable ; $4831
	wram_bank WRAM_SCENE ; $4834
	ld a, $02 ; $483a
	ld [wCharDataRevealStep], a ; $483c
	call FlushCharDataTilemaps ; $483f
	ld hl, CharDataBand6RunsStep2_1c ; $4842
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4845
	call BlitTilemapRunsFromTable ; $4848
	ld hl, CharDataBand5RunsStep2_1c ; $484b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $484e
	call BlitTilemapRunsFromTable ; $4851
	wram_bank WRAM_SCENE ; $4854
	ld a, $01 ; $485a
	ld [wCharDataRevealStep], a ; $485c
	call FlushCharDataTilemaps ; $485f
	ld hl, CharDataBand6RunsStep3_1c ; $4862
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4865
	call BlitTilemapRunsFromTable ; $4868
	ld hl, CharDataBand5RunsStep3_1c ; $486b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $486e
	call BlitTilemapRunsFromTable ; $4871
	wram_bank WRAM_SCENE ; $4874
	xor a ; $487a
	ld [wCharDataRevealStep], a ; $487b
	call FlushCharDataTilemaps ; $487e
	ret ; $4881
DrawCharStatsAndFlush:
	call DrawCharStatRows ; $4882
	ld hl, CharDataBand6RunsStep3_1c ; $4885
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4888
	call BlitTilemapRunsFromTable ; $488b
	ld hl, CharDataBand5RunsStep3_1c ; $488e
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $4891
	call BlitTilemapRunsFromTable ; $4894
	call FlushCharDataTilemaps ; $4897
	ret ; $489a
DrawCharStatRows:
	ld hl, CharDataBand0RunsStep7_1c ; $489b
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $489e
	call BlitTilemapRunsFromTable ; $48a1
	ld hl, CharDataBand1RunsStep6_1c ; $48a4
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $48a7
	call BlitTilemapRunsFromTable ; $48aa
	ld hl, CharDataBand2RunsStep6_1c ; $48ad
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $48b0
	call BlitTilemapRunsFromTable ; $48b3
	ld hl, CharDataBand3RunsStep7_1c ; $48b6
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $48b9
	call BlitTilemapRunsFromTable ; $48bc
	ld hl, CharDataBand4RunsStep3_1c ; $48bf
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $48c2
	call BlitTilemapRunsFromTable ; $48c5
	ret ; $48c8
BackupCharDataScreenRow:
	wram_bank WRAM_SCREEN ; $48c9
	ld hl, wShadowTilemap ; $48cf
	ld de, wCharDataScreenBackup ; $48d2
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $48d5
	call CopyMemoryFast ; $48d7
	wram_bank WRAM_COURT_PLANES ; $48da
	ld hl, wScreenAttrmap ; $48e0
	ld de, wCharDataScreenBackup ; $48e3
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $48e6
	call CopyMemoryFast ; $48e8
	ret ; $48eb
RestoreCharDataScreenRow:
	wram_bank WRAM_SCREEN ; $48ec
	ld hl, wCharDataScreenBackup ; $48f2
	ld de, wShadowTilemap ; $48f5
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $48f8
	call CopyMemoryFast ; $48fa
	wram_bank WRAM_COURT_PLANES ; $48fd
	ld hl, wCharDataScreenBackup ; $4903
	ld de, wScreenAttrmap ; $4906
	ld c, (SCREEN_HEIGHT * TILEMAP_WIDTH) / 16 ; $4909
	call CopyMemoryFast ; $490b
	ret ; $490e
BlitTilemapRunsFromTable:
	ld a, [hl] ; $490f
	cp $ff ; $4910
	ret z ; $4912
	push hl ; $4913
	ld d, [hl] ; $4914
	inc hl ; $4915
	ld e, [hl] ; $4916
	push hl ; $4917
	ld hl, wScreenAttrmap ; $4918
	add hl, de ; $491b
	ld d, h ; $491c
	ld e, l ; $491d
	pop hl ; $491e
	inc hl ; $491f
	push hl ; $4920
	ld a, [hl] ; $4921
	ld h, b ; $4922
	ld l, c ; $4923
	add_hl_a ; $4924
	wram_bank WRAM_SCENE ; $4929
	ld a, l ; $492f
	ld [wCharDataNumberBuffer], a ; $4930
	ld a, h ; $4933
	ld [wCharDataNumberBuffer + 1], a ; $4934
	pop hl ; $4937
	push bc ; $4938
	inc hl ; $4939
	ld c, [hl] ; $493a
	ld hl, wCharDataNumberBuffer ; $493b
	ld a, [hl+] ; $493e
	ld h, [hl] ; $493f
	ld l, a ; $4940
.copyLoop:
	wram_bank WRAM_SCREEN ; $4941
	ld a, [hl] ; $4947
	ld [de], a ; $4948
	wram_bank WRAM_COURT_PLANES ; $4949
	ld a, [hl+] ; $494f
	ld [de], a ; $4950
	inc de ; $4951
	dec c ; $4952
	jr nz, .copyLoop ; $4953
	pop bc ; $4955
	pop hl ; $4956
	inc hl ; $4957
	inc hl ; $4958
	inc hl ; $4959
	inc hl ; $495a
	jr BlitTilemapRunsFromTable ; $495b
FlushCharDataTilemaps:
	call FlushCharDataTilemapChunk ; $495d
	call FlushCharDataTilemapChunk ; $4960
	call FlushCharDataTilemapChunk ; $4963
	ret ; $4966
FlushCharDataTilemapChunk:
	wram_bank WRAM_SCENE ; $4967
	ld a, [wCharDataFlushChunk] ; $496d
	inc a ; $4970
	dec a ; $4971
	jr z, .flushBottomRows ; $4972
	dec a ; $4974
	jr z, .flushMiddleRows ; $4975
	jr .flushTopRows ; $4977
.flushBottomRows:
	wram_bank WRAM_SCREEN ; $4979
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $497f
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH ; $4982
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4985
	call QueueVRAMCopy ; $4987
	wram_bank WRAM_COURT_PLANES ; $498a
	ld hl, wScreenAttrmap + 15 * TILEMAP_WIDTH ; $4990
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH + VRAM_BANK1 ; $4993
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4996
	call QueueVRAMCopy ; $4998
	call AdvanceFrame ; $499b
	ret ; $499e
.flushMiddleRows:
	wram_bank WRAM_SCREEN ; $499f
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $49a5
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH ; $49a8
	ld c, 8 * TILEMAP_WIDTH / 16 ; $49ab
	call QueueVRAMCopy ; $49ad
	wram_bank WRAM_COURT_PLANES ; $49b0
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH ; $49b6
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $49b9
	ld c, 8 * TILEMAP_WIDTH / 16 ; $49bc
	call QueueVRAMCopy ; $49be
	call AdvanceFrame ; $49c1
	ret ; $49c4
.flushTopRows:
	wram_bank WRAM_SCREEN ; $49c5
	ld hl, wShadowTilemap ; $49cb
	ld de, vBGMap0 ; $49ce
	ld c, 7 * TILEMAP_WIDTH / 16 ; $49d1
	call QueueVRAMCopy ; $49d3
	wram_bank WRAM_COURT_PLANES ; $49d6
	ld hl, wScreenAttrmap ; $49dc
	ld de, vBGMap0 + VRAM_BANK1 ; $49df
	ld c, 7 * TILEMAP_WIDTH / 16 ; $49e2
	call QueueVRAMCopy ; $49e4
	call AdvanceFrame ; $49e7
	ret ; $49ea
WriteCharStatsToDisplayBuffer:
	wram_bank WRAM_SCENE ; $49eb
	ld a, [wCharDataPointsWorking] ; $49f1
	ld [wCharDataPointsLeft], a ; $49f4
	push af ; $49f7
	ld hl, wStoryMainName ; $49f8
	ld a, [wStoryCharacterSlot] ; $49fb
	or a ; $49fe
	jr z, .levelField ; $49ff
	ld l, $40 ; $4a01
.levelField:
	ld a, l ; $4a03
	add $18 ; $4a04
	ld l, a ; $4a06
	ld a, h ; $4a07
	adc $00 ; $4a08
	ld h, a ; $4a0a
	pop af ; $4a0b
	ld a, [wCharDataLevel] ; $4a0c
	ld [hl], a ; $4a0f
	push af ; $4a10
	ld hl, wStoryMainName ; $4a11
	ld a, [wStoryCharacterSlot] ; $4a14
	or a ; $4a17
	jr z, .spinLevelField ; $4a18
	ld l, $40 ; $4a1a
.spinLevelField:
	ld a, l ; $4a1c
	add $38 ; $4a1d
	ld l, a ; $4a1f
	ld a, h ; $4a20
	adc $00 ; $4a21
	ld h, a ; $4a23
	pop af ; $4a24
	ld a, [wCharDataNewLevels] ; $4a25
	ld [hl], a ; $4a28
	ld [wCharDataLevels], a ; $4a29
	push af ; $4a2c
	ld hl, wStoryMainName ; $4a2d
	ld a, [wStoryCharacterSlot] ; $4a30
	or a ; $4a33
	jr z, .powerLevelField ; $4a34
	ld l, $40 ; $4a36
.powerLevelField:
	ld a, l ; $4a38
	add $39 ; $4a39
	ld l, a ; $4a3b
	ld a, h ; $4a3c
	adc $00 ; $4a3d
	ld h, a ; $4a3f
	pop af ; $4a40
	ld a, [wCharDataNewLevels + 1] ; $4a41
	ld [hl], a ; $4a44
	ld [wCharDataLevels + 1], a ; $4a45
	push af ; $4a48
	ld hl, wStoryMainName ; $4a49
	ld a, [wStoryCharacterSlot] ; $4a4c
	or a ; $4a4f
	jr z, .controlLevelField ; $4a50
	ld l, $40 ; $4a52
.controlLevelField:
	ld a, l ; $4a54
	add $3a ; $4a55
	ld l, a ; $4a57
	ld a, h ; $4a58
	adc $00 ; $4a59
	ld h, a ; $4a5b
	pop af ; $4a5c
	ld a, [wCharDataNewLevels + 2] ; $4a5d
	ld [hl], a ; $4a60
	ld [wCharDataLevels + 2], a ; $4a61
	push af ; $4a64
	ld hl, wStoryMainName ; $4a65
	ld a, [wStoryCharacterSlot] ; $4a68
	or a ; $4a6b
	jr z, .speedLevelField ; $4a6c
	ld l, $40 ; $4a6e
.speedLevelField:
	ld a, l ; $4a70
	add $3b ; $4a71
	ld l, a ; $4a73
	ld a, h ; $4a74
	adc $00 ; $4a75
	ld h, a ; $4a77
	pop af ; $4a78
	ld a, [wCharDataNewLevels + 3] ; $4a79
	ld [hl], a ; $4a7c
	ld [wCharDataLevels + 3], a ; $4a7d
	xor a ; $4a80
	ld b, $64 ; $4a81
	ld hl, wCharDataChoiceLog ; $4a83
.loop:
	ld [hl+], a ; $4a86
	dec b ; $4a87
	jr nz, .loop ; $4a88
	ld [wCharDataChoiceCount], a ; $4a8a
	ld a, [wStoryCharacterSlot] ; $4a8d
	farcall RefreshPlayerStatsAndGetPtr ; $4a90
	ret ; $4a93
LoadCharStatsWithLevelUpDeltas:
	wram_bank WRAM_SCENE ; $4a94
	ld a, [wCharDataViewOnly] ; $4a9a
	or a ; $4a9d
	ret nz ; $4a9e
	push af ; $4a9f
	ld hl, wStoryMainName ; $4aa0
	ld a, [wStoryCharacterSlot] ; $4aa3
	or a ; $4aa6
	jr z, .spinLevelField ; $4aa7
	ld l, LOW(wStoryPartner) ; $4aa9
.spinLevelField:
	ld a, l ; $4aab
	add CHARREC_TRAIN_LEVELS ; $4aac
	ld l, a ; $4aae
	ld a, h ; $4aaf
	adc $00 ; $4ab0
	ld h, a ; $4ab2
	pop af ; $4ab3
	ld a, [hl] ; $4ab4
	ld [wCharDataLevels], a ; $4ab5
	push af ; $4ab8
	ld hl, wStoryMainName ; $4ab9
	ld a, [wStoryCharacterSlot] ; $4abc
	or a ; $4abf
	jr z, .topStatField ; $4ac0
	ld l, LOW(wStoryPartner) ; $4ac2
.topStatField:
	ld a, l ; $4ac4
	add CHARREC_STAT_TOP ; $4ac5
	ld l, a ; $4ac7
	ld a, h ; $4ac8
	adc $00 ; $4ac9
	ld h, a ; $4acb
	pop af ; $4acc
	ld a, [hl] ; $4acd
	inc a ; $4ace
	ld [wCharDataStats], a ; $4acf
	push af ; $4ad2
	ld hl, wStoryMainName ; $4ad3
	ld a, [wStoryCharacterSlot] ; $4ad6
	or a ; $4ad9
	jr z, .sliceStatField ; $4ada
	ld l, LOW(wStoryPartner) ; $4adc
.sliceStatField:
	ld a, l ; $4ade
	add CHARREC_STAT_SLICE ; $4adf
	ld l, a ; $4ae1
	ld a, h ; $4ae2
	adc $00 ; $4ae3
	ld h, a ; $4ae5
	pop af ; $4ae6
	ld a, [hl] ; $4ae7
	inc a ; $4ae8
	ld [wCharDataStats + 1], a ; $4ae9
	push af ; $4aec
	ld hl, wStoryMainName ; $4aed
	ld a, [wStoryCharacterSlot] ; $4af0
	or a ; $4af3
	jr z, .powerLevelField ; $4af4
	ld l, LOW(wStoryPartner) ; $4af6
.powerLevelField:
	ld a, l ; $4af8
	add CHARREC_TRAIN_LEVELS + 1 ; $4af9
	ld l, a ; $4afb
	ld a, h ; $4afc
	adc $00 ; $4afd
	ld h, a ; $4aff
	pop af ; $4b00
	ld a, [hl] ; $4b01
	ld [wCharDataLevels + 1], a ; $4b02
	push af ; $4b05
	ld hl, wStoryMainName ; $4b06
	ld a, [wStoryCharacterSlot] ; $4b09
	or a ; $4b0c
	jr z, .serveStatField ; $4b0d
	ld l, LOW(wStoryPartner) ; $4b0f
.serveStatField:
	ld a, l ; $4b11
	add CHARREC_STAT_SERVE ; $4b12
	ld l, a ; $4b14
	ld a, h ; $4b15
	adc $00 ; $4b16
	ld h, a ; $4b18
	pop af ; $4b19
	ld a, [hl] ; $4b1a
	inc a ; $4b1b
	ld [wCharDataStats + 2], a ; $4b1c
	push af ; $4b1f
	ld hl, wStoryMainName ; $4b20
	ld a, [wStoryCharacterSlot] ; $4b23
	or a ; $4b26
	jr z, .strokeStatField ; $4b27
	ld l, LOW(wStoryPartner) ; $4b29
.strokeStatField:
	ld a, l ; $4b2b
	add CHARREC_STAT_STROKE ; $4b2c
	ld l, a ; $4b2e
	ld a, h ; $4b2f
	adc $00 ; $4b30
	ld h, a ; $4b32
	pop af ; $4b33
	ld a, [hl] ; $4b34
	inc a ; $4b35
	ld [wCharDataStats + 3], a ; $4b36
	push af ; $4b39
	ld hl, wStoryMainName ; $4b3a
	ld a, [wStoryCharacterSlot] ; $4b3d
	or a ; $4b40
	jr z, .volleyStatField ; $4b41
	ld l, LOW(wStoryPartner) ; $4b43
.volleyStatField:
	ld a, l ; $4b45
	add CHARREC_STAT_VOLLEY ; $4b46
	ld l, a ; $4b48
	ld a, h ; $4b49
	adc $00 ; $4b4a
	ld h, a ; $4b4c
	pop af ; $4b4d
	ld a, [hl] ; $4b4e
	inc a ; $4b4f
	ld [wCharDataStats + 4], a ; $4b50
	push af ; $4b53
	ld hl, wStoryMainName ; $4b54
	ld a, [wStoryCharacterSlot] ; $4b57
	or a ; $4b5a
	jr z, .controlLevelField ; $4b5b
	ld l, LOW(wStoryPartner) ; $4b5d
.controlLevelField:
	ld a, l ; $4b5f
	add CHARREC_TRAIN_LEVELS + 2 ; $4b60
	ld l, a ; $4b62
	ld a, h ; $4b63
	adc $00 ; $4b64
	ld h, a ; $4b66
	pop af ; $4b67
	ld a, [hl] ; $4b68
	ld [wCharDataLevels + 2], a ; $4b69
	push af ; $4b6c
	ld hl, wStoryMainName ; $4b6d
	ld a, [wStoryCharacterSlot] ; $4b70
	or a ; $4b73
	jr z, .angleStatField ; $4b74
	ld l, LOW(wStoryPartner) ; $4b76
.angleStatField:
	ld a, l ; $4b78
	add CHARREC_STAT_ANGLE ; $4b79
	ld l, a ; $4b7b
	ld a, h ; $4b7c
	adc $00 ; $4b7d
	ld h, a ; $4b7f
	pop af ; $4b80
	ld a, [hl] ; $4b81
	inc a ; $4b82
	ld [wCharDataStats + 5], a ; $4b83
	push af ; $4b86
	ld hl, wStoryMainName ; $4b87
	ld a, [wStoryCharacterSlot] ; $4b8a
	or a ; $4b8d
	jr z, .placementStatField ; $4b8e
	ld l, LOW(wStoryPartner) ; $4b90
.placementStatField:
	ld a, l ; $4b92
	add CHARREC_STAT_PLACEMENT ; $4b93
	ld l, a ; $4b95
	ld a, h ; $4b96
	adc $00 ; $4b97
	ld h, a ; $4b99
	pop af ; $4b9a
	ld a, [hl] ; $4b9b
	inc a ; $4b9c
	ld [wCharDataStats + 6], a ; $4b9d
	push af ; $4ba0
	ld hl, wStoryMainName ; $4ba1
	ld a, [wStoryCharacterSlot] ; $4ba4
	or a ; $4ba7
	jr z, .speedLevelField ; $4ba8
	ld l, LOW(wStoryPartner) ; $4baa
.speedLevelField:
	ld a, l ; $4bac
	add CHARREC_TRAIN_LEVELS + 3 ; $4bad
	ld l, a ; $4baf
	ld a, h ; $4bb0
	adc $00 ; $4bb1
	ld h, a ; $4bb3
	pop af ; $4bb4
	ld a, [hl] ; $4bb5
	ld [wCharDataLevels + 3], a ; $4bb6
	push af ; $4bb9
	ld hl, wStoryMainName ; $4bba
	ld a, [wStoryCharacterSlot] ; $4bbd
	or a ; $4bc0
	jr z, .speedStatField ; $4bc1
	ld l, LOW(wStoryPartner) ; $4bc3
.speedStatField:
	ld a, l ; $4bc5
	add CHARREC_STAT_SPEED ; $4bc6
	ld l, a ; $4bc8
	ld a, h ; $4bc9
	adc $00 ; $4bca
	ld h, a ; $4bcc
	pop af ; $4bcd
	ld a, [hl] ; $4bce
	inc a ; $4bcf
	ld [wCharDataStats + 7], a ; $4bd0
	push af ; $4bd3
	ld hl, wStoryMainName ; $4bd4
	ld a, [wStoryCharacterSlot] ; $4bd7
	or a ; $4bda
	jr z, .dashStatField ; $4bdb
	ld l, LOW(wStoryPartner) ; $4bdd
.dashStatField:
	ld a, l ; $4bdf
	add CHARREC_STAT_DASH ; $4be0
	ld l, a ; $4be2
	ld a, h ; $4be3
	adc $00 ; $4be4
	ld h, a ; $4be6
	pop af ; $4be7
	ld a, [hl] ; $4be8
	inc a ; $4be9
	ld [wCharDataStats + 8], a ; $4bea
	push af ; $4bed
	ld hl, wStoryMainName ; $4bee
	ld a, [wStoryCharacterSlot] ; $4bf1
	or a ; $4bf4
	jr z, .reactionStatField ; $4bf5
	ld l, LOW(wStoryPartner) ; $4bf7
.reactionStatField:
	ld a, l ; $4bf9
	add CHARREC_STAT_REACTION ; $4bfa
	ld l, a ; $4bfc
	ld a, h ; $4bfd
	adc $00 ; $4bfe
	ld h, a ; $4c00
	pop af ; $4c01
	ld a, [hl] ; $4c02
	inc a ; $4c03
	ld [wCharDataStats + 9], a ; $4c04
	push af ; $4c07
	ld hl, wStoryMainName ; $4c08
	ld a, [wStoryCharacterSlot] ; $4c0b
	or a ; $4c0e
	jr z, .stopStatField ; $4c0f
	ld l, LOW(wStoryPartner) ; $4c11
.stopStatField:
	ld a, l ; $4c13
	add CHARREC_STAT_STOP ; $4c14
	ld l, a ; $4c16
	ld a, h ; $4c17
	adc $00 ; $4c18
	ld h, a ; $4c1a
	pop af ; $4c1b
	ld a, [hl] ; $4c1c
	inc a ; $4c1d
	ld [wCharDataStats + 10], a ; $4c1e
	ld a, [wCharDataPage] ; $4c21
	cp CHARDATAPAGE_CONFIRM ; $4c24
	jr z, .clearDeltas ; $4c26
	ld d, a ; $4c28
	ld hl, wCharDataStatDeltas ; $4c29
	ld a, [wStoryCharacterSlot] ; $4c2c
	farcall ComputeLevelUpStatDeltas ; $4c2f
	ret ; $4c32
.clearDeltas:
	xor a ; $4c33
	ld hl, wCharDataStatDeltas ; $4c34
	ld [hl+], a ; $4c37
	ld [hl+], a ; $4c38
	ld [hl+], a ; $4c39
	ld [hl+], a ; $4c3a
	ld [hl+], a ; $4c3b
	ld [hl+], a ; $4c3c
	ld [hl+], a ; $4c3d
	ld [hl+], a ; $4c3e
	ld [hl+], a ; $4c3f
	ld [hl+], a ; $4c40
	ld [hl+], a ; $4c41
	ret ; $4c42
LoadCharStats:
	wram_bank WRAM_SCENE ; $4c43
	push af ; $4c49
	ld hl, wStoryMainName ; $4c4a
	ld a, [wStoryCharacterSlot] ; $4c4d
	or a ; $4c50
	jr z, .spinLevelField ; $4c51
	ld l, LOW(wStoryPartner) ; $4c53
.spinLevelField:
	ld a, l ; $4c55
	add CHARREC_TRAIN_LEVELS ; $4c56
	ld l, a ; $4c58
	ld a, h ; $4c59
	adc $00 ; $4c5a
	ld h, a ; $4c5c
	pop af ; $4c5d
	ld a, [hl] ; $4c5e
	ld [wCharDataLevels], a ; $4c5f
	push af ; $4c62
	ld hl, wStoryMainName ; $4c63
	ld a, [wStoryCharacterSlot] ; $4c66
	or a ; $4c69
	jr z, .topStatField ; $4c6a
	ld l, LOW(wStoryPartner) ; $4c6c
.topStatField:
	ld a, l ; $4c6e
	add CHARREC_STAT_TOP ; $4c6f
	ld l, a ; $4c71
	ld a, h ; $4c72
	adc $00 ; $4c73
	ld h, a ; $4c75
	pop af ; $4c76
	ld a, [hl] ; $4c77
	inc a ; $4c78
	ld [wCharDataStats], a ; $4c79
	push af ; $4c7c
	ld hl, wStoryMainName ; $4c7d
	ld a, [wStoryCharacterSlot] ; $4c80
	or a ; $4c83
	jr z, .sliceStatField ; $4c84
	ld l, LOW(wStoryPartner) ; $4c86
.sliceStatField:
	ld a, l ; $4c88
	add CHARREC_STAT_SLICE ; $4c89
	ld l, a ; $4c8b
	ld a, h ; $4c8c
	adc $00 ; $4c8d
	ld h, a ; $4c8f
	pop af ; $4c90
	ld a, [hl] ; $4c91
	inc a ; $4c92
	ld [wCharDataStats + 1], a ; $4c93
	push af ; $4c96
	ld hl, wStoryMainName ; $4c97
	ld a, [wStoryCharacterSlot] ; $4c9a
	or a ; $4c9d
	jr z, .powerLevelField ; $4c9e
	ld l, LOW(wStoryPartner) ; $4ca0
.powerLevelField:
	ld a, l ; $4ca2
	add CHARREC_TRAIN_LEVELS + 1 ; $4ca3
	ld l, a ; $4ca5
	ld a, h ; $4ca6
	adc $00 ; $4ca7
	ld h, a ; $4ca9
	pop af ; $4caa
	ld a, [hl] ; $4cab
	ld [wCharDataLevels + 1], a ; $4cac
	push af ; $4caf
	ld hl, wStoryMainName ; $4cb0
	ld a, [wStoryCharacterSlot] ; $4cb3
	or a ; $4cb6
	jr z, .serveStatField ; $4cb7
	ld l, LOW(wStoryPartner) ; $4cb9
.serveStatField:
	ld a, l ; $4cbb
	add CHARREC_STAT_SERVE ; $4cbc
	ld l, a ; $4cbe
	ld a, h ; $4cbf
	adc $00 ; $4cc0
	ld h, a ; $4cc2
	pop af ; $4cc3
	ld a, [hl] ; $4cc4
	inc a ; $4cc5
	ld [wCharDataStats + 2], a ; $4cc6
	push af ; $4cc9
	ld hl, wStoryMainName ; $4cca
	ld a, [wStoryCharacterSlot] ; $4ccd
	or a ; $4cd0
	jr z, .strokeStatField ; $4cd1
	ld l, LOW(wStoryPartner) ; $4cd3
.strokeStatField:
	ld a, l ; $4cd5
	add CHARREC_STAT_STROKE ; $4cd6
	ld l, a ; $4cd8
	ld a, h ; $4cd9
	adc $00 ; $4cda
	ld h, a ; $4cdc
	pop af ; $4cdd
	ld a, [hl] ; $4cde
	inc a ; $4cdf
	ld [wCharDataStats + 3], a ; $4ce0
	push af ; $4ce3
	ld hl, wStoryMainName ; $4ce4
	ld a, [wStoryCharacterSlot] ; $4ce7
	or a ; $4cea
	jr z, .volleyStatField ; $4ceb
	ld l, LOW(wStoryPartner) ; $4ced
.volleyStatField:
	ld a, l ; $4cef
	add CHARREC_STAT_VOLLEY ; $4cf0
	ld l, a ; $4cf2
	ld a, h ; $4cf3
	adc $00 ; $4cf4
	ld h, a ; $4cf6
	pop af ; $4cf7
	ld a, [hl] ; $4cf8
	inc a ; $4cf9
	ld [wCharDataStats + 4], a ; $4cfa
	push af ; $4cfd
	ld hl, wStoryMainName ; $4cfe
	ld a, [wStoryCharacterSlot] ; $4d01
	or a ; $4d04
	jr z, .controlLevelField ; $4d05
	ld l, LOW(wStoryPartner) ; $4d07
.controlLevelField:
	ld a, l ; $4d09
	add CHARREC_TRAIN_LEVELS + 2 ; $4d0a
	ld l, a ; $4d0c
	ld a, h ; $4d0d
	adc $00 ; $4d0e
	ld h, a ; $4d10
	pop af ; $4d11
	ld a, [hl] ; $4d12
	ld [wCharDataLevels + 2], a ; $4d13
	push af ; $4d16
	ld hl, wStoryMainName ; $4d17
	ld a, [wStoryCharacterSlot] ; $4d1a
	or a ; $4d1d
	jr z, .angleStatField ; $4d1e
	ld l, LOW(wStoryPartner) ; $4d20
.angleStatField:
	ld a, l ; $4d22
	add CHARREC_STAT_ANGLE ; $4d23
	ld l, a ; $4d25
	ld a, h ; $4d26
	adc $00 ; $4d27
	ld h, a ; $4d29
	pop af ; $4d2a
	ld a, [hl] ; $4d2b
	inc a ; $4d2c
	ld [wCharDataStats + 5], a ; $4d2d
	push af ; $4d30
	ld hl, wStoryMainName ; $4d31
	ld a, [wStoryCharacterSlot] ; $4d34
	or a ; $4d37
	jr z, .placementStatField ; $4d38
	ld l, LOW(wStoryPartner) ; $4d3a
.placementStatField:
	ld a, l ; $4d3c
	add CHARREC_STAT_PLACEMENT ; $4d3d
	ld l, a ; $4d3f
	ld a, h ; $4d40
	adc $00 ; $4d41
	ld h, a ; $4d43
	pop af ; $4d44
	ld a, [hl] ; $4d45
	inc a ; $4d46
	ld [wCharDataStats + 6], a ; $4d47
	push af ; $4d4a
	ld hl, wStoryMainName ; $4d4b
	ld a, [wStoryCharacterSlot] ; $4d4e
	or a ; $4d51
	jr z, .speedLevelField ; $4d52
	ld l, LOW(wStoryPartner) ; $4d54
.speedLevelField:
	ld a, l ; $4d56
	add CHARREC_TRAIN_LEVELS + 3 ; $4d57
	ld l, a ; $4d59
	ld a, h ; $4d5a
	adc $00 ; $4d5b
	ld h, a ; $4d5d
	pop af ; $4d5e
	ld a, [hl] ; $4d5f
	ld [wCharDataLevels + 3], a ; $4d60
	push af ; $4d63
	ld hl, wStoryMainName ; $4d64
	ld a, [wStoryCharacterSlot] ; $4d67
	or a ; $4d6a
	jr z, .speedStatField ; $4d6b
	ld l, LOW(wStoryPartner) ; $4d6d
.speedStatField:
	ld a, l ; $4d6f
	add CHARREC_STAT_SPEED ; $4d70
	ld l, a ; $4d72
	ld a, h ; $4d73
	adc $00 ; $4d74
	ld h, a ; $4d76
	pop af ; $4d77
	ld a, [hl] ; $4d78
	inc a ; $4d79
	ld [wCharDataStats + 7], a ; $4d7a
	push af ; $4d7d
	ld hl, wStoryMainName ; $4d7e
	ld a, [wStoryCharacterSlot] ; $4d81
	or a ; $4d84
	jr z, .dashStatField ; $4d85
	ld l, LOW(wStoryPartner) ; $4d87
.dashStatField:
	ld a, l ; $4d89
	add CHARREC_STAT_DASH ; $4d8a
	ld l, a ; $4d8c
	ld a, h ; $4d8d
	adc $00 ; $4d8e
	ld h, a ; $4d90
	pop af ; $4d91
	ld a, [hl] ; $4d92
	inc a ; $4d93
	ld [wCharDataStats + 8], a ; $4d94
	push af ; $4d97
	ld hl, wStoryMainName ; $4d98
	ld a, [wStoryCharacterSlot] ; $4d9b
	or a ; $4d9e
	jr z, .reactionStatField ; $4d9f
	ld l, LOW(wStoryPartner) ; $4da1
.reactionStatField:
	ld a, l ; $4da3
	add CHARREC_STAT_REACTION ; $4da4
	ld l, a ; $4da6
	ld a, h ; $4da7
	adc $00 ; $4da8
	ld h, a ; $4daa
	pop af ; $4dab
	ld a, [hl] ; $4dac
	inc a ; $4dad
	ld [wCharDataStats + 9], a ; $4dae
	push af ; $4db1
	ld hl, wStoryMainName ; $4db2
	ld a, [wStoryCharacterSlot] ; $4db5
	or a ; $4db8
	jr z, .stopStatField ; $4db9
	ld l, LOW(wStoryPartner) ; $4dbb
.stopStatField:
	ld a, l ; $4dbd
	add CHARREC_STAT_STOP ; $4dbe
	ld l, a ; $4dc0
	ld a, h ; $4dc1
	adc $00 ; $4dc2
	ld h, a ; $4dc4
	pop af ; $4dc5
	ld a, [hl] ; $4dc6
	inc a ; $4dc7
	ld [wCharDataStats + 10], a ; $4dc8
	ld hl, wCharDataStatDeltas ; $4dcb
	ld b, $0b ; $4dce
	xor a ; $4dd0
.clearLoop:
	ld [hl+], a ; $4dd1
	dec b ; $4dd2
	jr nz, .clearLoop ; $4dd3
	ret ; $4dd5
CharDataScreen_DrawPageColumns:
	wram_bank WRAM_SCENE ; $4dd6
	ld a, [wCharDataPage] ; $4ddc
	rlca ; $4ddf
	push af ; $4de0
	rlca ; $4de1
	ld_hl_indexed CharDataScreen_DrawPageColumnsTable0 ; $4de2
	ld a, [hl+] ; $4de9
	ld d, [hl] ; $4dea
	ld e, a ; $4deb
	inc hl ; $4dec
	ld a, [hl+] ; $4ded
	ld b, [hl] ; $4dee
	ld c, a ; $4def
	pop af ; $4df0
	ld_hl_indexed CharDataScreen_DrawPageColumnsTable1 ; $4df1
	ld a, [hl+] ; $4df8
	ld h, [hl] ; $4df9
	ld l, a ; $4dfa
.rowLoop:
	push bc ; $4dfb
.cellLoop:
	wram_bank WRAM_COURT_PLANES ; $4dfc
	ld a, [hl+] ; $4e02
	ld [de], a ; $4e03
	inc de ; $4e04
	dec b ; $4e05
	jr nz, .cellLoop ; $4e06
	pop bc ; $4e08
	ld a, c ; $4e09
	and $01 ; $4e0a
	jr nz, .nextRow ; $4e0c
	wram_bank WRAM_SCENE ; $4e0e
	ld a, [wCharDataPage] ; $4e14
	cp CHARDATAPAGE_CONFIRM ; $4e17
	jr z, .nextRow ; $4e19
	dec de ; $4e1b
	dec de ; $4e1c
	dec de ; $4e1d
	wram_bank WRAM_COURT_PLANES ; $4e1e
	ld a, $01 ; $4e24
	ld [de], a ; $4e26
	inc de ; $4e27
	ld [de], a ; $4e28
	inc de ; $4e29
	inc de ; $4e2a
.nextRow:
	ld a, $16 ; $4e2b
	add_de_a ; $4e2d
	dec c ; $4e32
	jr nz, .rowLoop ; $4e33
	ret ; $4e35
