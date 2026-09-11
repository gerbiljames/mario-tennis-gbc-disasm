RunFacingTileScript:
	push af ; $5574
	push bc ; $5575
	push de ; $5576
	push hl ; $5577
	ld [wUnusedStoryScriptId], a ; $5578
	ld d, a ; $557b
	ld hl, wMapFacingScriptsPtr ; $557c
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	call FindStoryScriptEntry ; $5582
	ld a, h ; $5585
	or l ; $5586
	jr z, .done ; $5587
	ld a, [wStoryLocationBank] ; $5589
	ld de, wStoryMapRecord ; $558c
	ld bc, $0008 ; $558f
	call FarCopyBytes ; $5592
	ld hl, wStoryMapRecord + 4 ; $5595
	ld a, [hl+] ; $5598
	ld h, [hl] ; $5599
	ld l, a ; $559a
	ld a, $00 ; $559b
	call RunStoryScriptOrDialogue ; $559d
.done:
	pop hl ; $55a0
	pop de ; $55a1
	pop bc ; $55a2
	pop af ; $55a3
	ret ; $55a4
RunQueuedTriggerScript:
	push af ; $55a5
	push bc ; $55a6
	push de ; $55a7
	push hl ; $55a8
	ld [wUnusedStoryScriptId], a ; $55a9
	ld d, a ; $55ac
	ld hl, wMapTileTriggersPtr ; $55ad
	ld a, [hl+] ; $55b0
	ld h, [hl] ; $55b1
	ld l, a ; $55b2
	call FindStoryScriptEntry ; $55b3
	ld a, h ; $55b6
	or l ; $55b7
	jr z, .done ; $55b8
	ld a, [wStoryLocationBank] ; $55ba
	ld de, wStoryMapRecord ; $55bd
	ld bc, $0008 ; $55c0
	call FarCopyBytes ; $55c3
	ld a, [wStoryMapRecord + 6] ; $55c6
	cp $01 ; $55c9
	jr z, .done ; $55cb
	ld hl, wStoryMapRecord + 4 ; $55cd
	ld a, [hl+] ; $55d0
	ld h, [hl] ; $55d1
	ld l, a ; $55d2
	ld a, $00 ; $55d3
	call RunStoryScriptOrDialogue ; $55d5
.done:
	pop hl ; $55d8
	pop de ; $55d9
	pop bc ; $55da
	pop af ; $55db
	ret ; $55dc
RunTileTriggerScript:
	push af ; $55dd
	push bc ; $55de
	push de ; $55df
	push hl ; $55e0
	ld d, a ; $55e1
	ld hl, wMapTileTriggersPtr ; $55e2
	ld a, [hl+] ; $55e5
	ld h, [hl] ; $55e6
	ld l, a ; $55e7
	call FindStoryScriptEntry ; $55e8
	ld a, h ; $55eb
	or l ; $55ec
	jr z, .done ; $55ed
	ld a, [wStoryLocationBank] ; $55ef
	ld de, wStoryMapRecord ; $55f2
	ld bc, $0008 ; $55f5
	call FarCopyBytes ; $55f8
	ld hl, wStoryMapRecord + 4 ; $55fb
	ld a, [hl+] ; $55fe
	ld h, [hl] ; $55ff
	ld l, a ; $5600
	ld a, $00 ; $5601
	call RunStoryScriptOrDialogue ; $5603
.done:
	pop hl ; $5606
	pop de ; $5607
	pop bc ; $5608
	pop af ; $5609
	ret ; $560a
RunLocationExit:
	push af ; $560b
	push bc ; $560c
	push de ; $560d
	push hl ; $560e
	ld [wUnusedStoryScriptId], a ; $560f
	ld d, a ; $5612
	ld hl, wMapExitTriggersPtr ; $5613
	ld a, [hl+] ; $5616
	ld h, [hl] ; $5617
	ld l, a ; $5618
	call FindStoryScriptEntry ; $5619
	ld a, h ; $561c
	or l ; $561d
	jr z, .saveSlot ; $561e
	ld a, [wStoryLocationBank] ; $5620
	ld de, wStoryMapRecord ; $5623
	ld bc, $0008 ; $5626
	call FarCopyBytes ; $5629
	ld hl, wStoryMapRecord + 4 ; $562c
	ld a, [hl+] ; $562f
	ld h, [hl] ; $5630
	ld l, a ; $5631
	ld a, $00 ; $5632
	call RunStoryScriptOrDialogue ; $5634
	ld a, [wStoryMapRecord + 6] ; $5637
	ld [wStoryModeCurrentLocation], a ; $563a
	ld a, [wStoryMapRecord + 7] ; $563d
	ld [wStoryModeEntryPoint], a ; $5640
.saveSlot:
	xor a ; $5643
	ld a, a ; $5644
	ldh [hSramBank], a ; $5645
	ld [rRAMB], a ; $5647
	pop hl ; $564a
	pop de ; $564b
	pop bc ; $564c
	pop af ; $564d
	ret ; $564e
StoryLocationTable_0a:
	; $564f, 252 bytes (story_locations)
	story_location $00, SCENE_STAR_PATTERN_BG, DataPtr_MainMenuMapScripts_10, $ff ; loc 0 Main Menu
	story_location $01, SCENE_STAR_PATTERN_BG, DataPtr_DevelopmentMapScripts_10, $ff ; loc 1 Development
	story_location $02, SCENE_STAR_PATTERN_BG, DataPtr_SmallCharTestMapScripts_0f, $ff ; loc 2 Small Char. Test
	story_location $03, SCENE_STAR_PATTERN_BG, DataPtr_MatchSelectMapScripts_10, $ff ; loc 3 Test
	story_location $04, SCENE_STAR_PATTERN_BG, DataPtr_Test2MapScripts_10, $0b ; loc 4 Test 2
	story_location $05, SCENE_ACADEMY_MAIN_BLDG, DataPtr_AcademyMainBldgMapScripts_10, $1a ; loc 5 Academy Main Bldg.
	story_location $06, SCENE_ACADEMY_MAIN_BLDG, DataPtr_AcademyWingMapScripts_10, $1a ; loc 6 Academy Wing
	story_location $07, SCENE_COURTYARD, DataPtr_CourtyardMapScripts_13, $1b ; loc 7 Courtyard
	story_location $08, SCENE_RESTAURANT_PLAZA, DataPtr_RestaurantPlazaMapScripts_13, $1b ; loc 8 Restaurant Plaza
	story_location $09, SCENE_DORM_ENTRANCE, DataPtr_DormEntranceMapScripts_12, $1b ; loc 9 Dorm Entrance
	story_location $0a, SCENE_DORM_ROOM, DataPtr_DormRoomMapScripts_13, $00 ; loc 10 Dorm Room
	story_location $0b, SCENE_JUNIOR_CLASS_COURT, DataPtr_JuniorClassCourtSinglesMapScripts_11, $1b ; loc 11 Junior Class Court
	story_location $0c, SCENE_JUNIOR_CLASS_COURT, DataPtr_JuniorClassCourtDoublesMapScripts_11, $1b ; loc 12 Junior Class Court
	story_location $0d, SCENE_RESTAURANT, DataPtr_RestaurantMapScripts_10, $1d ; loc 13 Restaurant
	story_location $0e, SCENE_RESTAURANT, DataPtr_CafeteriaMapScripts_10, $1d ; loc 14 Cafeteria
	story_location $0f, SCENE_TRAINING_COURT_MAP, DataPtr_TrainingCourtMapScripts_15, $1b ; loc 15 Training Court
	story_location $10, SCENE_SENIOR_CLASS_COURT, DataPtr_SeniorCourtMapScripts_12, $1b ; loc 16 Senior Class Court
	story_location $11, SCENE_TRAINING_CENTER, DataPtr_TrainingGymMapScripts_0e, $1d ; loc 17 Training Center
	story_location $12, SCENE_TRAINING_CENTER, DataPtr_TennisMachineRoomMapScripts_14, $1d ; loc 18 Tennis Machine Room
	story_location $13, SCENE_TRAINING_CENTER, DataPtr_WallPracticeRoomMapScripts_12, $1d ; loc 19 Wall Practice Room
	story_location $14, SCENE_ACADEMY_ENTRANCE, DataPtr_AcademyArrivalMapScripts_11, $1b ; loc 20 Academy Entrance
	story_location $15, SCENE_TOURNAMENT_COURTYARD, DataPtr_TournamentCourtyardMapScripts_15, $1b ; loc 21 Tournament Courtyard
	story_location $16, SCENE_COURT_1, DataPtr_Court1MapScripts_14, $1b ; loc 22 Court #1
	story_location $17, SCENE_COURT_2, DataPtr_Court2MapScripts_14, $1b ; loc 23 Court #2
	story_location $18, SCENE_CENTER_COURT_MAP, DataPtr_CenterCourtMapScripts_11, $1d ; loc 24 Center Court
	story_location $19, SCENE_TOURNAMENT, DataPtr_TournamentMapScripts_0f, $1d ; loc 25 Tournament
	story_location $1a, SCENE_AWARDS_CEREMONY, DataPtr_AwardsCeremonyMapScripts_0f, $1b ; loc 26 Awards Ceremony
	story_location $1b, SCENE_ISLAND_SKY, DataPtr_IslandSkyMapScripts_14, $1b ; loc 27 Island Sky
	story_location $1c, SCENE_SPECIAL_COURT, DataPtr_SpecialCourtMapScripts_0e, $08 ; loc 28 Special Court
	story_location $1d, SCENE_PEACHS_CASTLE, DataPtr_MarioWorldMapScripts_0e, $12 ; loc 29 Peach's Castle
	story_location $1e, SCENE_ACADEMY_ENTRANCE, DataPtr_End1MainBldgMapScripts_27, $2c ; loc 30 End1 Main Bldg
	story_location $1f, SCENE_RESTAURANT_PLAZA, DataPtr_EndRestaurantEntMapScripts_27, $ff ; loc 31 End Restaurant Ent.
	story_location $20, SCENE_DORM_ENTRANCE, DataPtr_End3DormEntMapScripts_27, $ff ; loc 32 End3 Dorm Ent.
	story_location $21, SCENE_JUNIOR_CLASS_COURT, DataPtr_End4JrCourtMapScripts_27, $ff ; loc 33 End4 Jr. Court
	story_location $22, SCENE_RESTAURANT, DataPtr_End5ServiceAceMapScripts_27, $ff ; loc 34 End5 Service Ace
	story_location $23, SCENE_TRAINING_CENTER, DataPtr_End7TrainingCtrMapScripts_27, $ff ; loc 35 End7 Training Ctr.
	story_location $24, SCENE_SENIOR_CLASS_COURT, DataPtr_End8SrCourtMapScripts_27, $ff ; loc 36 End8 Sr. Court
	story_location $25, SCENE_COURTYARD, DataPtr_End10VarsityCourtMapScripts_27, $ff ; loc 37 End10 Varsity Court
	story_location $26, SCENE_TRAINING_COURT_MAP, DataPtr_End11TrainingCourtMapScripts_27, $ff ; loc 38 End11 Training Court
	story_location $27, SCENE_ACADEMY_MAIN_BLDG, DataPtr_End12PrincipalsOfficeMapScripts_27, $ff ; loc 39 End12 Principal's Office
	story_location $28, SCENE_TOURNAMENT, DataPtr_End16BeforeFinalsMapScripts_27, $ff ; loc 40 End16 Before Finals
	story_location $29, SCENE_AWARDS_CEREMONY, DataPtr_End17AwardCeremonyMapScripts_27, $ff ; loc 41 End17 Award Ceremony
GetStoryLocationCount:
	ld a, $2a ; $574b
	ret ; $574d
GetStoryLocationRecordPtr:
	ld h, a ; $574e
	add a ; $574f
	add h ; $5750
	add a ; $5751
	add $4f ; $5752
	ld l, a ; $5754
	adc $56 ; $5755
	sub l ; $5757
	ld h, a ; $5758
	ret ; $5759
	db $ff ; $575a
	ret ; $575b
Unused_0a_CopySceneTilemapToVram:
	push af ; $575c
	push bc ; $575d
	push de ; $575e
	push hl ; $575f
	ld a, [wCameraY + 1] ; $5760
	and $1f ; $5763
	ld l, a ; $5765
	ld h, $00 ; $5766
	add hl, hl ; $5768
	add hl, hl ; $5769
	add hl, hl ; $576a
	add hl, hl ; $576b
	add hl, hl ; $576c
	ld a, [wCameraX + 1] ; $576d
	and $1f ; $5770
	add l ; $5772
	ld l, a ; $5773
	ld de, $9800 ; $5774
	add hl, de ; $5777
	push hl ; $5778
	ld a, [wCameraY + 1] ; $5779
	ld l, a ; $577c
	ld h, $00 ; $577d
	add hl, hl ; $577f
	add hl, hl ; $5780
	add hl, hl ; $5781
	add hl, hl ; $5782
	add hl, hl ; $5783
	add hl, hl ; $5784
	ld a, [wCameraX + 1] ; $5785
	add l ; $5788
	ld l, a ; $5789
	ld de, $d000 ; $578a
	add hl, de ; $578d
	pop de ; $578e
	wram_bank $02 ; $578f
	ld a, $01 ; $5795
	ldh [rVBK], a ; $5797
	push de ; $5799
	push hl ; $579a
	call CopySceneTilemapChunk ; $579b
	call CopySceneTilemapChunk ; $579e
	call CopySceneTilemapChunk ; $57a1
	call CopySceneTilemapChunk ; $57a4
	call CopySceneTilemapChunk ; $57a7
	call CopySceneTilemapChunk ; $57aa
	call CopySceneTilemapChunk ; $57ad
	call CopySceneTilemapChunk ; $57b0
	call CopySceneTilemapChunk ; $57b3
	call CopySceneTilemapChunk ; $57b6
	call CopySceneTilemapChunk ; $57b9
	call CopySceneTilemapChunk ; $57bc
	call CopySceneTilemapChunk ; $57bf
	call CopySceneTilemapChunk ; $57c2
	call CopySceneTilemapChunk ; $57c5
	call CopySceneTilemapChunk ; $57c8
	call CopySceneTilemapChunk ; $57cb
	call CopySceneTilemapChunk ; $57ce
	call CopySceneTilemapChunk ; $57d1
	call CopySceneTilemapChunk ; $57d4
	pop hl ; $57d7
	pop de ; $57d8
	wram_bank $03 ; $57d9
	xor a ; $57df
	ldh [rVBK], a ; $57e0
	call CopySceneTilemapChunk ; $57e2
	call CopySceneTilemapChunk ; $57e5
	call CopySceneTilemapChunk ; $57e8
	call CopySceneTilemapChunk ; $57eb
	call CopySceneTilemapChunk ; $57ee
	call CopySceneTilemapChunk ; $57f1
	call CopySceneTilemapChunk ; $57f4
	call CopySceneTilemapChunk ; $57f7
	call CopySceneTilemapChunk ; $57fa
	call CopySceneTilemapChunk ; $57fd
	call CopySceneTilemapChunk ; $5800
	call CopySceneTilemapChunk ; $5803
	call CopySceneTilemapChunk ; $5806
	call CopySceneTilemapChunk ; $5809
	call CopySceneTilemapChunk ; $580c
	call CopySceneTilemapChunk ; $580f
	call CopySceneTilemapChunk ; $5812
	call CopySceneTilemapChunk ; $5815
	call CopySceneTilemapChunk ; $5818
	call CopySceneTilemapChunk ; $581b
	pop hl ; $581e
	pop de ; $581f
	pop bc ; $5820
	pop af ; $5821
	ret ; $5822
CopySceneTilemapChunk:
	push de ; $5823
	push hl ; $5824
	ld c, $16 ; $5825
.copyLoop:
	ld a, [hl+] ; $5827
	ld [de], a ; $5828
	inc de ; $5829
	ld a, l ; $582a
	and $3f ; $582b
	jr nz, .checkDestWrap ; $582d
	ld a, l ; $582f
	sub $40 ; $5830
	ld l, a ; $5832
	jr nc, .srcWrapped ; $5833
	dec h ; $5835
.srcWrapped:
	jr .wrapDest ; $5836
.checkDestWrap:
	ld a, e ; $5838
	and $1f ; $5839
	jr nz, .next ; $583b
.wrapDest:
	ld a, e ; $583d
	sub $20 ; $583e
	ld e, a ; $5840
	jr nc, .next ; $5841
	dec d ; $5843
.next:
	dec c ; $5844
	jr nz, .copyLoop ; $5845
	pop hl ; $5847
	ld de, $0040 ; $5848
	add hl, de ; $584b
	ld a, h ; $584c
	and $0f ; $584d
	or $d0 ; $584f
	ld h, a ; $5851
	pop de ; $5852
	ld a, $20 ; $5853
	add e ; $5855
	ld e, a ; $5856
	jr nc, .done ; $5857
	inc d ; $5859
.done:
	res 2, d ; $585a
	ret ; $585c
LoadStorySceneGraphics:
	push af ; $585d
	push bc ; $585e
	push de ; $585f
	push hl ; $5860
	ld [wCurrentScene], a ; $5861
	ld h, $00 ; $5864
	ld l, a ; $5866
	add hl, hl ; $5867
	add hl, hl ; $5868
	add hl, hl ; $5869
	add hl, hl ; $586a
	ld de, SceneGfxSlotTable ; $586b
	add hl, de ; $586e
	ld a, [hl+] ; $586f
	ld c, a ; $5870
	ld a, [hl+] ; $5871
	ld b, a ; $5872
	push bc ; $5873
	ld a, [hl+] ; $5874
	ld c, a ; $5875
	ld a, [hl+] ; $5876
	ld b, a ; $5877
	push bc ; $5878
	ld a, [hl+] ; $5879
	ld c, a ; $587a
	ld a, [hl+] ; $587b
	ld b, a ; $587c
	push bc ; $587d
	ld a, [hl+] ; $587e
	ld c, a ; $587f
	ld a, [hl+] ; $5880
	ld b, a ; $5881
	push bc ; $5882
	ld a, [hl+] ; $5883
	ld c, a ; $5884
	ld a, [hl+] ; $5885
	ld b, a ; $5886
	push bc ; $5887
	ld a, [hl+] ; $5888
	ld c, a ; $5889
	ld a, [hl+] ; $588a
	ld b, a ; $588b
	push bc ; $588c
	ld a, [hl+] ; $588d
	ld c, a ; $588e
	ld a, [hl+] ; $588f
	ld b, a ; $5890
	push bc ; $5891
	wram_bank $01 ; $5892
	ld a, [hl+] ; $5898
	ld h, [hl] ; $5899
	ld l, a ; $589a
	ld de, wDecompBuffer ; $589b
	call DecompressDataFromBank ; $589e
	ld hl, wDecompBuffer ; $58a1
	ld de, vTiles2 + VRAM_BANK1 ; $58a4
	ld c, $80 ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, wTextTileBuffer ; $58ac
	ld de, vTiles1 + VRAM_BANK1 ; $58af
	ld c, $80 ; $58b2
	call QueueVRAMCopy ; $58b4
	wram_bank $06 ; $58b7
	pop hl ; $58bd
	ld de, wStorySceneUnusedBuffer ; $58be
	pop hl ; $58c1
	ld de, wBehaviorMap ; $58c2
	call DecompressDataFromBank ; $58c5
	pop hl ; $58c8
	ld de, wCollisionMap ; $58c9
	call DecompressDataFromBank ; $58cc
	wram_bank $02 ; $58cf
	pop hl ; $58d5
	ld de, wScreenAttrmap ; $58d6
	call DecompressDataFromBank ; $58d9
	wram_bank $03 ; $58dc
	pop hl ; $58e2
	ld de, wShadowTilemap ; $58e3
	call DecompressDataFromBank ; $58e6
	wram_bank $01 ; $58e9
	pop hl ; $58ef
	ld de, wDecompBuffer ; $58f0
	ld bc, $0040 ; $58f3
	call CopyDataFromBank ; $58f6
	ld hl, wDecompBuffer + 1 * TILE_SIZE ; $58f9
	lb de, $02, $06 ; $58fc palette index, count
	call LoadPaletteShadow ; $58ff
	wram_bank $06 ; $5902
	pop hl ; $5908
	ld de, wStorySceneRecord ; $5909
	ld bc, $0088 ; $590c
	call CopyDataFromBank ; $590f
	ld hl, wStorySceneRecord + 2 ; $5912
	ld a, [hl+] ; $5915
	ld [wMapScrollMinX], a ; $5916
	ld a, [hl+] ; $5919
	ld [wMapScrollMinY], a ; $591a
	ld a, [hl+] ; $591d
	ld [wMapWidthTiles], a ; $591e
	ld a, [hl+] ; $5921
	ld [wMapHeightTiles], a ; $5922
	ld a, [wCurrentScene] ; $5925
	call InitSceneTileAnimations ; $5928
	pop hl ; $592b
	pop de ; $592c
	pop bc ; $592d
	pop af ; $592e
	ret ; $592f
InitSceneScroll:
	push af ; $5930
	push bc ; $5931
	push de ; $5932
	push hl ; $5933
	ld a, $25 ; $5934
	ld [wScrollListLength], a ; $5936
	xor a ; $5939
	ldh [hScrollY], a ; $593a
	ldh [hScrollX], a ; $593c
	ldh [hBGColumnBlitPending], a ; $593e
	ldh [hBGRowBlitPending], a ; $5940
	ld [wCameraX], a ; $5942
	ld [wCameraX + 1], a ; $5945
	ld [wCameraY], a ; $5948
	ld [wCameraY + 1], a ; $594b
	ld [wCameraTileXPrev], a ; $594e
	ld [wCameraTileYPrev], a ; $5951
	ld [wMapScrollMinX], a ; $5954
	ld [wMapScrollMinY], a ; $5957
	ld a, $40 ; $595a
	ld [wMapWidthTiles], a ; $595c
	ld [wMapHeightTiles], a ; $595f
	ld a, $0f ; $5962
	ld hl, UpdateSceneScroll ; $5964
	call RegisterFrameTask ; $5967
	pop hl ; $596a
	pop de ; $596b
	pop bc ; $596c
	pop af ; $596d
	ret ; $596e
StopSceneScrollTask:
	ld hl, UpdateSceneScroll ; $596f
	call UnregisterFrameTask ; $5972
	ret ; $5975
UpdateSceneScroll:
	ld a, [wCameraTileYPrev] ; $5976
	ld h, a ; $5979
	ld a, [wCameraY + 1] ; $597a
	sub h ; $597d
	jr z, .checkX ; $597e
	bit 7, a ; $5980
	jr nz, .scrollUp ; $5982
	ld bc, $fb13 ; $5984
	call BlitBGRowFrom64 ; $5987
	jr .checkX ; $598a
.scrollUp:
	ld bc, $fb00 ; $598c
	call BlitBGRowFrom64 ; $598f
.checkX:
	ld a, [wCameraTileXPrev] ; $5992
	ld h, a ; $5995
	ld a, [wCameraX + 1] ; $5996
	sub h ; $5999
	jr z, .storeCamera ; $599a
	bit 7, a ; $599c
	jr nz, .scrollLeft ; $599e
	ld bc, $15fa ; $59a0
	call BlitBGColumnFrom64 ; $59a3
	jr .storeCamera ; $59a6
.scrollLeft:
	ld bc, $00fa ; $59a8
	call BlitBGColumnFrom64 ; $59ab
.storeCamera:
	ld a, [wCameraY] ; $59ae
	ld l, a ; $59b1
	ld a, [wCameraY + 1] ; $59b2
	ld h, a ; $59b5
	ld [wCameraTileYPrev], a ; $59b6
	add hl, hl ; $59b9
	add hl, hl ; $59ba
	add hl, hl ; $59bb
	ld a, h ; $59bc
	ld hl, wScreenShakeOffsetY ; $59bd
	add [hl] ; $59c0
	ldh [hScrollY], a ; $59c1
	ld a, [wCameraX] ; $59c3
	ld l, a ; $59c6
	ld a, [wCameraX + 1] ; $59c7
	ld h, a ; $59ca
	ld [wCameraTileXPrev], a ; $59cb
	add hl, hl ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	ld a, h ; $59d1
	ld hl, wScreenShakeOffsetX ; $59d2
	add [hl] ; $59d5
	ldh [hScrollX], a ; $59d6
	ret ; $59d8
SceneGfxSlotTable:
	; $59d9, 592 bytes (37 records x 8 slot words)
	dslot DataPtr_ClubhouseSceneConfig, DataPtr_ClubhouseScenePalettes, DataPtr_ClubhouseSceneTilemap, DataPtr_ClubhouseSceneAttrmap, DataPtr_ClubhouseSceneConfigAlias1, DataPtr_ClubhouseScoreboardColumnAttrs, DataPtr_CourtyardScenePalettes, DataPtr_ClubhouseSceneTiles ; record 0 SCENE_MINIGAME_COURT
	dslot DataPtr_CourtyardSceneConfig, DataPtr_CourtyardScenePalettesAlias1, DataPtr_CourtyardSceneTilemap, DataPtr_CourtyardSceneAttrmap, DataPtr_CourtyardSceneConfigAlias1, DataPtr_CourtyardScoreboardColumnAttrs, DataPtr_CourtyardSceneUnusedSlot, DataPtr_CourtyardSceneTiles ; record 1 SCENE_TARGET_SHOT_COURT
	dslot DataPtr_GrassCourtSceneConfig, DataPtr_GrassCourtPalettes, DataPtr_GrassCourtTilemap, DataPtr_GrassCourtAttrmap, DataPtr_GrassCourtSceneConfigAlias1, DataPtr_GrassCourtScoreboardColumnAttrs, DataPtr_HardCourtPalettes, DataPtr_GrassCourtTiles ; record 2 SCENE_GRASS_COURT
	dslot DataPtr_HardCourtSceneConfig, DataPtr_HardCourtPalettesAlias1, DataPtr_HardCourtTilemap, DataPtr_HardCourtAttrmap, DataPtr_HardCourtSceneConfigAlias1, DataPtr_HardCourtScoreboardColumnAttrs, DataPtr_ClayCourtPalettes, DataPtr_HardCourtTiles ; record 3 SCENE_TRAINING_COURT
	dslot DataPtr_ClayCourtSceneConfig, DataPtr_ClayCourtPalettesAlias1, DataPtr_ClayCourtTilemap, DataPtr_ClayCourtAttrmap, DataPtr_ClayCourtSceneConfigAlias1, DataPtr_ClayCourtScoreboardColumnAttrs, DataPtr_CompositionCourtPalettes, DataPtr_ClayCourtTiles ; record 4 SCENE_CLAY_COURT
	dslot DataPtr_CompositionCourtSceneConfig, DataPtr_CompositionCourtPalettesAlias1, DataPtr_CompositionCourtTilemap, DataPtr_CompositionCourtAttrmap, DataPtr_CompositionCourtSceneConfigAlias1, DataPtr_CompositionCourtScoreboardColumnAttrs, DataPtr_CompositionCourtSceneUnusedSlot, DataPtr_CompositionCourtTiles ; record 5 SCENE_HARD_COURT
	dslot DataPtr_MachineCourtSceneConfig, DataPtr_MachineCourtPalettes, DataPtr_MachineCourtTilemap, DataPtr_MachineCourtAttrmap, DataPtr_MachineCourtSceneConfigAlias1, DataPtr_MachineCourtScoreboardColumnAttrs, DataPtr_CenterCourtPalettes, DataPtr_MachineCourtTiles ; record 6 SCENE_MACHINE_COURT
	dslot DataPtr_CenterCourtSceneConfig, DataPtr_CenterCourtPalettesAlias1, DataPtr_CenterCourtTilemap, DataPtr_CenterCourtAttrmap, DataPtr_CenterCourtSceneConfigAlias1, DataPtr_CenterCourtScoreboardColumnAttrs, DataPtr_PracticeCourtPalettes, DataPtr_CenterCourtTiles ; record 7 SCENE_CENTER_COURT
	dslot DataPtr_PracticeCourtSceneConfig, DataPtr_PracticeCourtPalettesAlias1, DataPtr_PracticeCourtTilemap, DataPtr_PracticeCourtAttrmap, DataPtr_PracticeCourtSceneConfigAlias1, DataPtr_PracticeCourtScoreboardColumnAttrs, DataPtr_YoshiCourtPalettes, DataPtr_PracticeCourtTiles ; record 8 SCENE_COMPOSITION_COURT
	dslot DataPtr_YoshiCourtSceneConfig, DataPtr_YoshiCourtPalettesAlias1, DataPtr_YoshiCourtTilemap, DataPtr_YoshiCourtAttrmap, DataPtr_YoshiCourtSceneConfigAlias1, DataPtr_YoshiCourtScoreboardColumnAttrs, DataPtr_YoshiCourtSceneUnusedSlot, DataPtr_YoshiCourtTiles ; record 9 SCENE_TROPICS_COURT
	dslot DataPtr_StarCourtSceneConfig, DataPtr_StarCourtPalettes, DataPtr_StarCourtTilemap, DataPtr_StarCourtAttrmap, DataPtr_StarCourtSceneConfigAlias1, DataPtr_StarCourtScoreboardColumnAttrs, DataPtr_BowserCourtPalettes, DataPtr_StarCourtTiles ; record 10 SCENE_STAR_COURT
	dslot DataPtr_BowserCourtSceneConfig, DataPtr_BowserCourtPalettesAlias1, DataPtr_BowserCourtTilemap, DataPtr_BowserCourtAttrmap, DataPtr_BowserCourtSceneConfigAlias1, DataPtr_BowserCourtScoreboardColumnAttrs, DataPtr_WarioCourtPalettes, DataPtr_BowserCourtTiles ; record 11 SCENE_BOWSER_COURT
	dslot DataPtr_WarioCourtSceneConfig, DataPtr_WarioCourtPalettesAlias1, DataPtr_WarioCourtTilemap, DataPtr_WarioCourtAttrmap, DataPtr_WarioCourtSceneConfigAlias1, DataPtr_WarioCourtScoreboardColumnAttrs, DataPtr_PeachCourtPalettes, DataPtr_WarioCourtTiles ; record 12 SCENE_WAREHOUSE_COURT
	dslot DataPtr_PeachCourtSceneConfig, DataPtr_PeachCourtPalettesAlias1, DataPtr_PeachCourtTilemap, DataPtr_PeachCourtAttrmap, DataPtr_PeachCourtSceneConfigAlias1, DataPtr_PeachCourtScoreboardColumnAttrs, DataPtr_PeachCourtSceneUnusedSlot, DataPtr_PeachCourtTiles ; record 13 SCENE_CASTLE_COURT
	dslot DataPtr_IslandOpenCourtSceneConfig, DataPtr_IslandOpenCourtPalettes, DataPtr_IslandOpenCourtTilemap, DataPtr_IslandOpenCourtAttrmap, DataPtr_IslandOpenCourtSceneConfigAlias1, DataPtr_IslandOpenCourtScoreboardColumnAttrs, DataPtr_DKCourtPalettes, DataPtr_IslandOpenCourtTiles ; record 14 SCENE_WALL_PRACTICE
	dslot DataPtr_DKCourtSceneConfig, DataPtr_DKCourtPalettesAlias1, DataPtr_DKCourtTilemap, DataPtr_DKCourtAttrmap, DataPtr_DKCourtSceneConfigAlias1, DataPtr_DKCourtScoreboardColumnAttrs, DataPtr_StarPatternBgSceneConfig, DataPtr_DKCourtTiles ; record 15 SCENE_JUNGLE_COURT
	dslot DataPtr_StarPatternBgSceneConfigAlias1, DataPtr_StarPatternBgPalettes, DataPtr_StarPatternBgTilemap, DataPtr_StarPatternBgAttrmap, DataPtr_StarPatternBgCollisionMap, DataPtr_StarPatternBgBehaviorMap, DataPtr_AcademyMainBldgSceneConfig, DataPtr_StarPatternBgTiles ; record 16 SCENE_STAR_PATTERN_BG
	dslot DataPtr_AcademyMainBldgSceneConfigAlias1, DataPtr_AcademyMainBldgPalettes, DataPtr_AcademyMainBldgTilemap, DataPtr_AcademyMainBldgAttrmap, DataPtr_AcademyMainBldgCollisionMap, DataPtr_AcademyMainBldgBehaviorMap, DataPtr_AcademyMainBldgSceneUnusedSlot, DataPtr_AcademyMainBldgTiles ; record 17 SCENE_ACADEMY_MAIN_BLDG
	dslot DataPtr_DormBedroomSceneConfig, DataPtr_DormBedroomPalettes, DataPtr_DormBedroomTilemap, DataPtr_DormBedroomAttrmap, DataPtr_DormBedroomCollisionMap, DataPtr_DormBedroomBehaviorMap, DataPtr_CountrysideSceneConfig, DataPtr_DormBedroomTiles ; record 18 SCENE_DORM_ROOM
	dslot DataPtr_CountrysideSceneConfigAlias1, DataPtr_CountrysidePalettes, DataPtr_CountrysideTilemap, DataPtr_CountrysideAttrmap, DataPtr_CountrysideCollisionMap, DataPtr_CountrysideBehaviorMap, DataPtr_AcademyGroundsSceneConfig, DataPtr_CountrysideTiles ; record 19 SCENE_RESTAURANT_PLAZA
	dslot DataPtr_AcademyGroundsSceneConfigAlias1, DataPtr_AcademyGroundsPalettes, DataPtr_AcademyGroundsTilemap, DataPtr_AcademyGroundsAttrmap, DataPtr_AcademyGroundsCollisionMap, DataPtr_AcademyGroundsBehaviorMap, DataPtr_AcademyGroundsSceneUnusedSlot, DataPtr_AcademyGroundsTiles ; record 20 SCENE_COURTYARD
	dslot DataPtr_SeasideSceneConfig, DataPtr_SeasidePalettes, DataPtr_SeasideTilemap, DataPtr_SeasideAttrmap, DataPtr_SeasideCollisionMap, DataPtr_SeasideBehaviorMap, DataPtr_SeasideSceneUnusedSlot, DataPtr_SeasideTiles ; record 21 SCENE_ISLAND_SKY
	dslot DataPtr_HedgeCourtSceneConfig, DataPtr_HedgeCourtPalettes, DataPtr_HedgeCourtTilemap, DataPtr_HedgeCourtAttrmap, DataPtr_HedgeCourtCollisionMap, DataPtr_HedgeCourtBehaviorMap, DataPtr_HedgeCourtSceneUnusedSlot, DataPtr_HedgeCourtTiles ; record 22 SCENE_SPECIAL_COURT
	dslot DataPtr_ClayCourtGroundsSceneConfig, DataPtr_ClayCourtGroundsPalettes, DataPtr_ClayCourtGroundsTilemap, DataPtr_ClayCourtGroundsAttrmap, DataPtr_ClayCourtGroundsCollisionMap, DataPtr_ClayCourtGroundsBehaviorMap, DataPtr_ClayCourtGroundsSceneUnusedSlot, DataPtr_ClayCourtGroundsTiles ; record 23 SCENE_SENIOR_CLASS_COURT
	dslot DataPtr_HardCourtGroundsSceneConfig, DataPtr_HardCourtGroundsPalettes, DataPtr_HardCourtGroundsTilemap, DataPtr_HardCourtGroundsAttrmap, DataPtr_HardCourtGroundsCollisionMap, DataPtr_HardCourtGroundsBehaviorMap, DataPtr_SpaResortSceneConfig, DataPtr_HardCourtGroundsTiles ; record 24 SCENE_JUNIOR_CLASS_COURT
	dslot DataPtr_SpaResortSceneConfigAlias1, DataPtr_SpaResortPalettes, DataPtr_SpaResortTilemap, DataPtr_SpaResortAttrmap, DataPtr_SpaResortCollisionMap, DataPtr_SpaResortBehaviorMap, DataPtr_MainBuildingSceneConfig, DataPtr_SpaResortTiles ; record 25 SCENE_RESTAURANT
	dslot DataPtr_MainBuildingSceneConfigAlias1, DataPtr_MainBuildingPalettes, DataPtr_MainBuildingTilemap, DataPtr_MainBuildingAttrmap, DataPtr_MainBuildingCollisionMap, DataPtr_MainBuildingBehaviorMap, DataPtr_GardenPavilionSceneConfig, DataPtr_MainBuildingTiles ; record 26 SCENE_ACADEMY_ENTRANCE
	dslot DataPtr_GardenPavilionSceneConfigAlias1, DataPtr_GardenPavilionPalettes, DataPtr_GardenPavilionTilemap, DataPtr_GardenPavilionAttrmap, DataPtr_GardenPavilionCollisionMap, DataPtr_GardenPavilionBehaviorMap, DataPtr_GardenPavilionSceneUnusedSlot, DataPtr_GardenPavilionTiles ; record 27 SCENE_DORM_ENTRANCE
	dslot DataPtr_FountainCourtSceneConfig, DataPtr_FountainCourtPalettes, DataPtr_FountainCourtTilemap, DataPtr_FountainCourtAttrmap, DataPtr_FountainCourtCollisionMap, DataPtr_FountainCourtBehaviorMap, DataPtr_FountainCourtSceneUnusedSlot, DataPtr_FountainCourtTiles ; record 28 SCENE_TOURNAMENT_COURTYARD
	dslot DataPtr_CafeCourtSceneConfig, DataPtr_CafeCourtPalettes, DataPtr_CafeCourtTilemap, DataPtr_CafeCourtAttrmap, DataPtr_CafeCourtCollisionMap, DataPtr_CafeCourtBehaviorMap, DataPtr_CourtComplexSceneConfig, DataPtr_CafeCourtTiles ; record 29 SCENE_COURT_1
	dslot DataPtr_CourtComplexSceneConfigAlias1, DataPtr_CourtComplexPalettes, DataPtr_CourtComplexTilemap, DataPtr_CourtComplexAttrmap, DataPtr_CourtComplexCollisionMap, DataPtr_CourtComplexBehaviorMap, DataPtr_CourtComplexSceneUnusedSlot, DataPtr_CourtComplexTiles ; record 30 SCENE_TRAINING_COURT_MAP
	dslot DataPtr_ClubCourtSceneConfig, DataPtr_ClubCourtPalettes, DataPtr_ClubCourtTilemap, DataPtr_ClubCourtAttrmap, DataPtr_ClubCourtCollisionMap, DataPtr_ClubCourtBehaviorMap, DataPtr_StadiumGroundsSceneConfig, DataPtr_ClubCourtTiles ; record 31 SCENE_COURT_2
	dslot DataPtr_StadiumGroundsSceneConfigAlias1, DataPtr_StadiumGroundsPalettes, DataPtr_StadiumGroundsTilemap, DataPtr_StadiumGroundsAttrmap, DataPtr_StadiumGroundsCollisionMap, DataPtr_StadiumGroundsBehaviorMap, DataPtr_CeremonyHallSceneConfig, DataPtr_StadiumGroundsTiles ; record 32 SCENE_CENTER_COURT_MAP
	dslot DataPtr_CeremonyHallSceneConfigAlias1, DataPtr_CeremonyHallPalettes, DataPtr_CeremonyHallTilemap, DataPtr_CeremonyHallAttrmap, DataPtr_CeremonyHallCollisionMap, DataPtr_CeremonyHallBehaviorMap, DataPtr_CeremonyHallSceneUnusedSlot, DataPtr_CeremonyHallTiles ; record 33 SCENE_PEACHS_CASTLE
	dslot DataPtr_TrainingHallSceneConfig, DataPtr_TrainingHallPalettes, DataPtr_TrainingHallTilemap, DataPtr_TrainingHallAttrmap, DataPtr_TrainingHallCollisionMap, DataPtr_TrainingHallBehaviorMap, DataPtr_CenterCourtHallSceneConfig, DataPtr_TrainingHallTiles ; record 34 SCENE_TRAINING_CENTER
	dslot DataPtr_CenterCourtHallSceneConfigAlias1, DataPtr_CenterCourtHallPalettes, DataPtr_CenterCourtHallTilemap, DataPtr_CenterCourtHallAttrmap, DataPtr_CenterCourtHallCollisionMap, DataPtr_CenterCourtHallBehaviorMap, DataPtr_ClubroomInteriorSceneConfig, DataPtr_CenterCourtHallTiles ; record 35 SCENE_TOURNAMENT
	dslot DataPtr_ClubroomInteriorSceneConfigAlias1, DataPtr_ClubroomInteriorPalettes, DataPtr_ClubroomInteriorTilemap, DataPtr_ClubroomInteriorAttrmap, DataPtr_ClubroomInteriorCollisionMap, DataPtr_ClubroomInteriorBehaviorMap, DataPtr_ClubroomInteriorSceneUnusedSlot, DataPtr_ClubroomInteriorTiles ; record 36 SCENE_AWARDS_CEREMONY
