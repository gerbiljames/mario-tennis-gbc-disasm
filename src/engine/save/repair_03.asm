RepairAllSaveSlots:
	wram_bank WRAM_STAGING ; $5669
	ld b, $00 ; $566f
	call RestoreStoryBlockFromBackup ; $5671
	ld b, $02 ; $5674
	call RestoreStoryBlockFromBackup ; $5676
	ld b, $04 ; $5679
	call RestoreStoryBlockFromBackup ; $567b
	call RestoreBlock36FromBackup ; $567e
	ret ; $5681
RestoreBlock36FromBackup:
	ld a, SAVEBLOCK_EXHIBITION ; $5682
	ld b, a ; $5684
	ld hl, wDecompBuffer ; $5685
	call ReadSaveBlock ; $5688
	cp $ff ; $568b
	ret nz ; $568d
	push bc ; $568e
	ld a, SAVEBLOCK_EXHIBITION_BACKUP ; $568f
	ld b, a ; $5691
	call ReadSaveBlock ; $5692
	or a ; $5695
	jr nz, .restore ; $5696
	pop bc ; $5698
	ld hl, wDecompBuffer ; $5699
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $569c
	call WriteSaveBlock ; $569f
	ret ; $56a2
.restore:
	pop bc ; $56a3
	call InvalidateSaveBlock ; $56a4
	ret ; $56a7
ApplyN64RecordsUnlockFlags:
	push af ; $56a8
	push bc ; $56a9
	push de ; $56aa
	push hl ; $56ab
	push_wram_bank WRAM_SOUND ; $56ac
	ld hl, wSaveBlockBuffer ; $56b5
	ld b, SAVEBLOCK_N64_RECORDS ; $56b8
	call ReadSaveBlock ; $56ba
	or a ; $56bd
	jr nz, .restore ; $56be
	ld hl, wSaveBlockBuffer ; $56c0
	ld a, [hl] ; $56c3
	inc hl ; $56c4
	add [hl] ; $56c5
	or a ; $56c6
	jr z, .restore ; $56c7
	push de ; $56c9
	ld de, SAVEFLAG_N64_RECORDS_PRESENT ; $56ca
	farcall SetSaveFlag ; $56cd
	pop de ; $56d0
	push de ; $56d1
	ld de, SAVEFLAG_UNLOCKED_FAY ; $56d2
	farcall SetSaveFlag ; $56d5
	pop de ; $56d8
	push de ; $56d9
	ld de, SAVEFLAG_UNLOCKED_CURT ; $56da
	farcall SetSaveFlag ; $56dd
	pop de ; $56e0
	push de ; $56e1
	ld de, SAVEFLAG_UNLOCKED_MARK ; $56e2
	farcall SetSaveFlag ; $56e5
	pop de ; $56e8
	push de ; $56e9
	ld de, SAVEFLAG_UNLOCKED_SEAN ; $56ea
	farcall SetSaveFlag ; $56ed
	pop de ; $56f0
.restore:
	pop_wram_bank ; $56f1
	pop hl ; $56f6
	pop de ; $56f7
	pop bc ; $56f8
	pop af ; $56f9
	ret ; $56fa
UpdateUnlockablesSaveBlock:
	push af ; $56fb
	push bc ; $56fc
	push de ; $56fd
	push hl ; $56fe
	push_wram_bank WRAM_SOUND ; $56ff
	ld hl, wSaveBlockBuffer ; $5708
	ld b, SAVEBLOCK_N64_RECORDS ; $570b
	call ReadSaveBlock ; $570d
	or a ; $5710
	jp nz, .restore ; $5711
	ld hl, wSaveBlockBuffer ; $5714
	ld a, [hl] ; $5717
	inc hl ; $5718
	add [hl] ; $5719
	or a ; $571a
	jp z, .restore ; $571b
	ld a, $02 ; $571e
	call CheckUnlockCondition ; $5720
	or a ; $5723
	jr z, .zero ; $5724
	ld hl, wSaveBlockBuffer + 2 ; $5726
	ld a, $01 ; $5729
	ld [hl], a ; $572b
.zero:
	ld a, $04 ; $572c
	call CheckUnlockCondition ; $572e
	or a ; $5731
	jr z, .zero2 ; $5732
	ld hl, wSaveBlockBuffer + 7 ; $5734
	ld a, $01 ; $5737
	ld [hl], a ; $5739
.zero2:
	ld a, $06 ; $573a
	call CheckUnlockCondition ; $573c
	or a ; $573f
	jr z, .zero3 ; $5740
	ld hl, wSaveBlockBuffer + 4 ; $5742
	ld a, $01 ; $5745
	ld [hl], a ; $5747
.zero3:
	ld a, $08 ; $5748
	call CheckUnlockCondition ; $574a
	or a ; $574d
	jr z, .zero4 ; $574e
	ld hl, wSaveBlockBuffer + 6 ; $5750
	ld a, $01 ; $5753
	ld [hl], a ; $5755
.zero4:
	ld a, $09 ; $5756
	call CheckUnlockCondition ; $5758
	or a ; $575b
	jr z, .zero5 ; $575c
	ld hl, wSaveBlockBuffer + 3 ; $575e
	ld a, $01 ; $5761
	ld [hl], a ; $5763
.zero5:
	ld a, $0a ; $5764
	call CheckUnlockCondition ; $5766
	or a ; $5769
	jr z, .zero6 ; $576a
	ld hl, wSaveBlockBuffer + 5 ; $576c
	ld a, $01 ; $576f
	ld [hl], a ; $5771
.zero6:
	ld hl, wSaveBlockBuffer ; $5772
	ld b, SAVEBLOCK_N64_RECORDS ; $5775
	ld de, $0000 ; $5777
	call WriteSaveBlock ; $577a
.restore:
	pop_wram_bank ; $577d
	pop hl ; $5782
	pop de ; $5783
	pop bc ; $5784
	pop af ; $5785
	ret ; $5786
SetAllUnlockablesInSaveBlock:
	push af ; $5787
	push bc ; $5788
	push de ; $5789
	push hl ; $578a
	push_wram_bank WRAM_SOUND ; $578b
	ld hl, wSaveBlockBuffer ; $5794
	ld b, SAVEBLOCK_N64_RECORDS ; $5797
	call ReadSaveBlock ; $5799
	or a ; $579c
	jp nz, .restore ; $579d
	ld hl, wSaveBlockBuffer + 2 ; $57a0
	ld a, $01 ; $57a3
	ld [hl], a ; $57a5
	ld hl, wSaveBlockBuffer + 7 ; $57a6
	ld a, $01 ; $57a9
	ld [hl], a ; $57ab
	ld hl, wSaveBlockBuffer + 4 ; $57ac
	ld a, $01 ; $57af
	ld [hl], a ; $57b1
	ld hl, wSaveBlockBuffer + 6 ; $57b2
	ld a, $01 ; $57b5
	ld [hl], a ; $57b7
	ld hl, wSaveBlockBuffer + 3 ; $57b8
	ld a, $01 ; $57bb
	ld [hl], a ; $57bd
	ld hl, wSaveBlockBuffer + 5 ; $57be
	ld a, $01 ; $57c1
	ld [hl], a ; $57c3
	ld hl, wSaveBlockBuffer ; $57c4
	ld b, SAVEBLOCK_N64_RECORDS ; $57c7
	ld de, $0000 ; $57c9
	call WriteSaveBlock ; $57cc
.restore:
	pop_wram_bank ; $57cf
	pop hl ; $57d4
	pop de ; $57d5
	pop bc ; $57d6
	pop af ; $57d7
	ret ; $57d8
UnlockConditionFlagRows_03:
	; $57d9, 9 bytes (bytes:1)
	db $16 ; 0x00
	db $19 ; 0x01
	db $1c ; 0x02
	db $1f ; 0x03
	db $2a ; 0x04
	db $2d ; 0x05
	db $30 ; 0x06
	db $33 ; 0x07
	db $36 ; 0x08
CheckUnlockCondition:
	push bc ; $57e2
	push de ; $57e3
	push hl ; $57e4
	ld b, a ; $57e5
	push_wram_bank WRAM_SOUND ; $57e6
	cp $02 ; $57ef
	jr nc, .saveFlagCondition ; $57f1
	or a ; $57f3
	jr nz, .machineWall ; $57f4
	test_flag FLAG_CLEARED_WALL_LEVEL_4 ; $57f6
	jr z, .locked ; $57f9
	jr .checkRecord ; $57fb
.machineWall:
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $57fd
	jr z, .locked ; $5800
	jr .checkRecord ; $5802
.saveFlagCondition:
	ld a, b ; $5804
	sub $02 ; $5805
	ld hl, UnlockConditionFlagRows_03 ; $5807
	ld d, $00 ; $580a
	ld e, a ; $580c
	add hl, de ; $580d
	ld a, [hl] ; $580e
	ld l, a ; $580f
	ld h, $00 ; $5810
	ld a, $20 ; $5812
	call MulHLByA ; $5814
	push hl ; $5817
	pop de ; $5818
	call TestSaveFlag ; $5819
	jr z, .locked ; $581c
.checkRecord:
	ld a, b ; $581e
	farcall GetDefaultMinigameRecordValue ; $581f
	ld a, b ; $5822
	call ReadMinigameRecord ; $5823
	ld hl, wMinigameRecordValue ; $5826
	ld a, [hl+] ; $5829
	ld h, [hl] ; $582a
	ld l, a ; $582b
	ld a, l ; $582c
	sub e ; $582d
	ld l, a ; $582e
	ld a, h ; $582f
	sbc d ; $5830
	ld h, a ; $5831
	jr c, .locked ; $5832
	ld b, $01 ; $5834
	jr .done ; $5836
.locked:
	xor a ; $5838
	ld b, a ; $5839
.done:
	pop_wram_bank ; $583a
	ld a, b ; $583f
	pop hl ; $5840
	pop de ; $5841
	pop bc ; $5842
	ret ; $5843
WriteBlock6WithBackup:
	push bc ; $5844
	push de ; $5845
	push hl ; $5846
	ld de, $0000 ; $5847
	ld b, SAVEBLOCK_PRESERVED ; $584a
	call WriteSaveBlock ; $584c
	or a ; $584f
	jr nz, .step ; $5850
	call VerifySaveBlock ; $5852
	or a ; $5855
	jr nz, .step ; $5856
	ld b, SAVEBLOCK_PRESERVED + SAVEBLOCK_BACKUP ; $5858
	call WriteSaveBlock ; $585a
	or a ; $585d
	jr nz, .step ; $585e
	call VerifySaveBlock ; $5860
	or a ; $5863
	jr nz, .step ; $5864
	xor a ; $5866
	jr .restore ; $5867
.step:
	ld a, $ff ; $5869
.restore:
	pop hl ; $586b
	pop de ; $586c
	pop bc ; $586d
	ret ; $586e
ReadBlock6:
	push bc ; $586f
	push de ; $5870
	push hl ; $5871
	ld b, SAVEBLOCK_PRESERVED ; $5872
	call ReadSaveBlock ; $5874
	pop hl ; $5877
	pop de ; $5878
	pop bc ; $5879
	ret ; $587a
Unused_03_WriteBlock7WithBackup:
	push bc ; $587b
	push de ; $587c
	push hl ; $587d
	ld de, $0000 ; $587e
	ld b, SAVEBLOCK_SPARE7 ; $5881
	call WriteSaveBlock ; $5883
	or a ; $5886
	jr nz, .step ; $5887
	call VerifySaveBlock ; $5889
	or a ; $588c
	jr nz, .step ; $588d
	ld b, SAVEBLOCK_SPARE7 + SAVEBLOCK_BACKUP ; $588f
	call WriteSaveBlock ; $5891
	or a ; $5894
	jr nz, .step ; $5895
	call VerifySaveBlock ; $5897
	or a ; $589a
	jr nz, .step ; $589b
	xor a ; $589d
	jr .restore ; $589e
.step:
	ld a, $ff ; $58a0
.restore:
	pop hl ; $58a2
	pop de ; $58a3
	pop bc ; $58a4
	ret ; $58a5
Unused_03_ReadBlock7:
	push bc ; $58a6
	push de ; $58a7
	push hl ; $58a8
	ld b, SAVEBLOCK_SPARE7 ; $58a9
	call ReadSaveBlock ; $58ab
	pop hl ; $58ae
	pop de ; $58af
	pop bc ; $58b0
	ret ; $58b1
Unused_03_WriteBlock8WithBackup:
	push bc ; $58b2
	push de ; $58b3
	push hl ; $58b4
	ld de, $0000 ; $58b5
	ld b, SAVEBLOCK_SPARE8 ; $58b8
	call WriteSaveBlock ; $58ba
	or a ; $58bd
	jr nz, .step ; $58be
	call VerifySaveBlock ; $58c0
	or a ; $58c3
	jr nz, .step ; $58c4
	ld b, SAVEBLOCK_SPARE8 + SAVEBLOCK_BACKUP ; $58c6
	call WriteSaveBlock ; $58c8
	or a ; $58cb
	jr nz, .step ; $58cc
	call VerifySaveBlock ; $58ce
	or a ; $58d1
	jr nz, .step ; $58d2
	xor a ; $58d4
	jr .restore ; $58d5
.step:
	ld a, $ff ; $58d7
.restore:
	pop hl ; $58d9
	pop de ; $58da
	pop bc ; $58db
	ret ; $58dc
Unused_03_ReadBlock8:
	push bc ; $58dd
	push de ; $58de
	push hl ; $58df
	ld b, SAVEBLOCK_SPARE8 ; $58e0
	call ReadSaveBlock ; $58e2
	pop hl ; $58e5
	pop de ; $58e6
	pop bc ; $58e7
	ret ; $58e8
Unused_03_WriteBlock9WithBackup:
	push bc ; $58e9
	push de ; $58ea
	push hl ; $58eb
	ld de, $0000 ; $58ec
	ld b, SAVEBLOCK_SPARE9 ; $58ef
	call WriteSaveBlock ; $58f1
	or a ; $58f4
	jr nz, .step ; $58f5
	call VerifySaveBlock ; $58f7
	or a ; $58fa
	jr nz, .step ; $58fb
	ld b, SAVEBLOCK_SPARE9 + SAVEBLOCK_BACKUP ; $58fd
	call WriteSaveBlock ; $58ff
	or a ; $5902
	jr nz, .step ; $5903
	call VerifySaveBlock ; $5905
	or a ; $5908
	jr nz, .step ; $5909
	xor a ; $590b
	jr .restore ; $590c
.step:
	ld a, $ff ; $590e
.restore:
	pop hl ; $5910
	pop de ; $5911
	pop bc ; $5912
	ret ; $5913
Unused_03_ReadBlock9:
	push bc ; $5914
	push de ; $5915
	push hl ; $5916
	ld b, SAVEBLOCK_SPARE9 ; $5917
	call ReadSaveBlock ; $5919
	pop hl ; $591c
	pop de ; $591d
	pop bc ; $591e
	ret ; $591f
Unused_03_WriteBlock10WithBackup:
	push bc ; $5920
	push de ; $5921
	push hl ; $5922
	ld de, $0000 ; $5923
	ld b, SAVEBLOCK_SPARE10 ; $5926
	call WriteSaveBlock ; $5928
	or a ; $592b
	jr nz, .step ; $592c
	call VerifySaveBlock ; $592e
	or a ; $5931
	jr nz, .step ; $5932
	ld b, SAVEBLOCK_SPARE10 + SAVEBLOCK_BACKUP ; $5934
	call WriteSaveBlock ; $5936
	or a ; $5939
	jr nz, .step ; $593a
	call VerifySaveBlock ; $593c
	or a ; $593f
	jr nz, .step ; $5940
	xor a ; $5942
	jr .restore ; $5943
.step:
	ld a, $ff ; $5945
.restore:
	pop hl ; $5947
	pop de ; $5948
	pop bc ; $5949
	ret ; $594a
Unused_03_ReadBlock10:
	push bc ; $594b
	push de ; $594c
	push hl ; $594d
	ld b, SAVEBLOCK_SPARE10 ; $594e
	call ReadSaveBlock ; $5950
	pop hl ; $5953
	pop de ; $5954
	pop bc ; $5955
	ret ; $5956
