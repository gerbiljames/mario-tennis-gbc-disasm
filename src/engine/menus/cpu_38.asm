ApplyCpuDifficultyToCharRecords:
	push_wram_bank $03 ; $5f4c
	ld a, [wCharSelectSlotDifficulty + 1] ; $5f55
	ld hl, CpuDifficultyParamPtrs_38 ; $5f58
	add a ; $5f5b
	add l ; $5f5c
	ld l, a ; $5f5d
	jr nc, .readSlot1 ; $5f5e
	inc h ; $5f60
.readSlot1:
	ld a, [hl+] ; $5f61
	ld h, [hl] ; $5f62
	ld l, a ; $5f63
	ld a, [hl+] ; $5f64
	ld [wPlayer1PartnerAiParams], a ; $5f65
	ld a, [hl+] ; $5f68
	ld [wPlayer1PartnerAiParams + 1], a ; $5f69
	ld a, [hl+] ; $5f6c
	ld [wPlayer1PartnerAiParams + 2], a ; $5f6d
	ld a, [hl+] ; $5f70
	ld [wPlayer1PartnerAiParams + 3], a ; $5f71
	ld a, [hl+] ; $5f74
	ld [wExhibitionModePlayerPartnerCharacterDifficulty], a ; $5f75
	ld a, [wPlayer1CurrentPartnerCharacter] ; $5f78
	call IsCreatedCharId ; $5f7b
	or a ; $5f7e
	jr nz, .slot2 ; $5f7f
	ld a, [hl+] ; $5f81
	ld [wPlayer1PartnerExpTier], a ; $5f82
.slot2:
	ld a, [wCharSelectSlotDifficulty + 2] ; $5f85
	ld hl, CpuDifficultyParamPtrs_38 ; $5f88
	add a ; $5f8b
	add l ; $5f8c
	ld l, a ; $5f8d
	jr nc, .readSlot2 ; $5f8e
	inc h ; $5f90
.readSlot2:
	ld a, [hl+] ; $5f91
	ld h, [hl] ; $5f92
	ld l, a ; $5f93
	ld a, [hl+] ; $5f94
	ld [wPlayer2MainAiParams], a ; $5f95
	ld a, [hl+] ; $5f98
	ld [wPlayer2MainAiParams + 1], a ; $5f99
	ld a, [hl+] ; $5f9c
	ld [wPlayer2MainAiParams + 2], a ; $5f9d
	ld a, [hl+] ; $5fa0
	ld [wPlayer2MainAiParams + 3], a ; $5fa1
	ld a, [hl+] ; $5fa4
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $5fa5
	ld a, [wPlayer2CurrentMainCharacter] ; $5fa8
	call IsCreatedCharId ; $5fab
	or a ; $5fae
	jr nz, .slot3 ; $5faf
	ld a, [hl+] ; $5fb1
	ld [wPlayer2MainExpTier], a ; $5fb2
.slot3:
	ld a, [wCharSelectSlotDifficulty + 3] ; $5fb5
	ld hl, CpuDifficultyParamPtrs_38 ; $5fb8
	add a ; $5fbb
	add l ; $5fbc
	ld l, a ; $5fbd
	jr nc, .readSlot3 ; $5fbe
	inc h ; $5fc0
.readSlot3:
	ld a, [hl+] ; $5fc1
	ld h, [hl] ; $5fc2
	ld l, a ; $5fc3
	ld a, [hl+] ; $5fc4
	ld [wPlayer2PartnerAiParams], a ; $5fc5
	ld a, [hl+] ; $5fc8
	ld [wPlayer2PartnerAiParams + 1], a ; $5fc9
	ld a, [hl+] ; $5fcc
	ld [wPlayer2PartnerAiParams + 2], a ; $5fcd
	ld a, [hl+] ; $5fd0
	ld [wPlayer2PartnerAiParams + 3], a ; $5fd1
	ld a, [hl+] ; $5fd4
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $5fd5
	ld a, [wPlayer2CurrentPartnerCharacter] ; $5fd8
	call IsCreatedCharId ; $5fdb
	or a ; $5fde
	jr nz, .done ; $5fdf
	ld a, [hl+] ; $5fe1
	ld [wPlayer2PartnerExpTier], a ; $5fe2
.done:
	pop_wram_bank ; $5fe5
	ret ; $5fea
; Indexed by wCharSelectSlotDifficulty * 2 in
; ApplyCpuDifficultyToCharRecords, then dereferenced to a 6-byte record:
; four AI parameters, the difficulty byte copied to
; wExhibitionMode*CharacterDifficulty, and an EXP tier read only for
; characters that are not created ones.
;
; Records 1-4 ramp monotonically -- reaction delays 28/18/10/2, tracking
; 60/120/190/230, difficulty 0/1/2/3, tier 1/3/5/7 -- which is what
; identifies them as EASY/NORMAL/HARD/INTENSE. Slot 0 duplicates
; INTENSE and is what an unset difficulty selects.
CpuDifficultyParamPtrs_38:
	; $5feb, 10 bytes (records:2)
	dw CpuDifficultyParamsUnset ; record 0
	dw CpuDifficultyParamsEasy ; record 1
	dw CpuDifficultyParamsNormal ; record 2
	dw CpuDifficultyParamsHard ; record 3
	dw CpuDifficultyParamsIntense ; record 4
CpuDifficultyParamsUnset:
	; $5ff5, 6 bytes (cpu_difficulty)
	cpu_difficulty 2, 2, 0, 230, 3, 7
CpuDifficultyParamsEasy:
	; $5ffb, 6 bytes (cpu_difficulty)
	cpu_difficulty 28, 24, 12, 60, 0, 1
CpuDifficultyParamsNormal:
	; $6001, 6 bytes (cpu_difficulty)
	cpu_difficulty 18, 15, 9, 120, 1, 3
CpuDifficultyParamsHard:
	; $6007, 6 bytes (cpu_difficulty)
	cpu_difficulty 10, 9, 5, 190, 2, 5
CpuDifficultyParamsIntense:
	; $600d, 6 bytes (cpu_difficulty)
	cpu_difficulty 2, 2, 0, 230, 3, 7
IsCreatedCharId:
	cp $04 ; $6013
	jr nc, .no ; $6015
	ld a, $01 ; $6017
	ret ; $6019
.no:
	xor a ; $601a
	ret ; $601b
ApplyHandednessToCharRecords:
	push_wram_bank $03 ; $601c
	ld a, [wPlayer1MainLeftHanded] ; $6025
	or a ; $6028
	jr nz, .slot2 ; $6029
	ld a, [wCharSelectSlotLeftHanded] ; $602b
	ld [wPlayer1MainLeftHanded], a ; $602e
.slot2:
	ld a, [wPlayer1PartnerLeftHanded] ; $6031
	or a ; $6034
	jr nz, .slot3 ; $6035
	ld a, [wCharSelectSlotLeftHanded + 1] ; $6037
	ld [wPlayer1PartnerLeftHanded], a ; $603a
.slot3:
	ld a, [wPlayer2MainLeftHanded] ; $603d
	or a ; $6040
	jr nz, .slot4 ; $6041
	ld a, [wCharSelectSlotLeftHanded + 2] ; $6043
	ld [wPlayer2MainLeftHanded], a ; $6046
.slot4:
	ld a, [wPlayer2PartnerLeftHanded] ; $6049
	or a ; $604c
	jr nz, .done ; $604d
	ld a, [wCharSelectSlotLeftHanded + 3] ; $604f
	ld [wPlayer2PartnerLeftHanded], a ; $6052
.done:
	pop_wram_bank ; $6055
	ret ; $605a
CacheStorySlotNames:
	push af ; $605b
	push bc ; $605c
	push de ; $605d
	push hl ; $605e
	push_wram_bank $01 ; $605f
	ld a, $00 ; $6068
	ld [wCurrentStorySlot], a ; $606a
	farcall CheckStorySlot ; $606d
	ld hl, wStoryModeNameOfMainCharacter ; $6070
	ld de, wDecompBuffer ; $6073
	ld bc, $0008 ; $6076
	call CopyMemoryFast ; $6079
	ld a, $01 ; $607c
	ld [wCurrentStorySlot], a ; $607e
	farcall CheckStorySlot ; $6081
	ld hl, wStoryModeNameOfMainCharacter ; $6084
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $6087
	ld bc, $0008 ; $608a
	call CopyMemoryFast ; $608d
	ld a, $02 ; $6090
	ld [wCurrentStorySlot], a ; $6092
	farcall CheckStorySlot ; $6095
	ld hl, wStoryModeNameOfMainCharacter ; $6098
	ld de, wDecompBuffer + 32 * TILE_SIZE ; $609b
	ld bc, $0008 ; $609e
	call CopyMemoryFast ; $60a1
	pop_wram_bank ; $60a4
	pop hl ; $60a9
	pop de ; $60aa
	pop bc ; $60ab
	pop af ; $60ac
	ld a, STORYSLOT_NONE ; $60ad
	ld [wCurrentStorySlot], a ; $60af
	farcall InitStoryModeState ; $60b2
	farcall InitDefaultMatchSettings ; $60b5
	ret ; $60b8
LoadCachedStorySlotName:
	push af ; $60b9
	push bc ; $60ba
	push de ; $60bb
	push hl ; $60bc
	push_wram_bank $01 ; $60bd
	ld a, b ; $60c6
	add a ; $60c7
	ld hl, CachedStorySlotNameTable ; $60c8
	add l ; $60cb
	ld l, a ; $60cc
	jr nc, .readPtr ; $60cd
	inc h ; $60cf
.readPtr:
	ld a, [hl+] ; $60d0
	ld h, [hl] ; $60d1
	ld l, a ; $60d2
	ld de, wStoryModeNameOfMainCharacter ; $60d3
	ld bc, $0008 ; $60d6
	call CopyMemoryFast ; $60d9
	pop_wram_bank ; $60dc
	pop hl ; $60e1
	pop de ; $60e2
	pop bc ; $60e3
	pop af ; $60e4
	ret ; $60e5
CachedStorySlotNameTable:
	; $60e6, 6 bytes (bytes:6)
	db $00, $d0, $00, $d1, $00, $d2 ; 0x00
CompactRosterGridEntries:
	ld hl, wCharGridEntries + 36 ; $60ec
	ld c, $00 ; $60ef
.scanLoop:
	ld a, [hl] ; $60f1
	cp $ff ; $60f2
	jr nz, .next ; $60f4
	push hl ; $60f6
	ld a, $16 ; $60f7
	sub c ; $60f9
	ld b, a ; $60fa
.findNext:
	inc hl ; $60fb
	inc hl ; $60fc
	inc hl ; $60fd
	inc hl ; $60fe
	ld a, [hl] ; $60ff
	cp $04 ; $6100
	jr c, .nextSlot ; $6102
	ld a, [hl] ; $6104
	cp $ff ; $6105
	jr nz, .moveEntry ; $6107
.nextSlot:
	ld a, b ; $6109
	dec a ; $610a
	ld b, a ; $610b
	jr nz, .findNext ; $610c
.moveEntry:
	pop de ; $610e
	ld a, [hl] ; $610f
	ld [de], a ; $6110
	ld a, $ff ; $6111
	ld [hl], a ; $6113
	inc de ; $6114
	inc hl ; $6115
	ld a, [hl] ; $6116
	ld [de], a ; $6117
	xor a ; $6118
	ld [hl], a ; $6119
	inc de ; $611a
	inc hl ; $611b
	ld a, [hl] ; $611c
	ld [de], a ; $611d
	xor a ; $611e
	ld [hl], a ; $611f
	inc de ; $6120
	inc hl ; $6121
	ld a, [hl] ; $6122
	ld [de], a ; $6123
	xor a ; $6124
	ld [hl], a ; $6125
	inc de ; $6126
	inc hl ; $6127
	ld h, d ; $6128
	ld l, e ; $6129
	jr .done ; $612a
.next:
	inc hl ; $612c
	inc hl ; $612d
	inc hl ; $612e
	inc hl ; $612f
.done:
	ld a, c ; $6130
	inc a ; $6131
	ld c, a ; $6132
	cp $16 ; $6133
	jr nz, .scanLoop ; $6135
	ld a, $ff ; $6137
	ld [hl+], a ; $6139
	ld [hl+], a ; $613a
	ld [hl+], a ; $613b
	ld [hl+], a ; $613c
	ld [hl+], a ; $613d
	ld [hl+], a ; $613e
	ld [hl+], a ; $613f
	ld [hl+], a ; $6140
	ld [hl+], a ; $6141
	ld [hl+], a ; $6142
	ld [hl+], a ; $6143
	ld [hl+], a ; $6144
	ret ; $6145
CompactMarioCastGridEntries:
	ld hl, wCharGridEntries ; $6146
	ld c, $00 ; $6149
.scanLoop:
	ld a, [hl] ; $614b
	cp $ff ; $614c
	jr nz, .next ; $614e
	push hl ; $6150
	ld a, $08 ; $6151
	sub c ; $6153
	ld b, a ; $6154
.findNext:
	inc hl ; $6155
	inc hl ; $6156
	inc hl ; $6157
	inc hl ; $6158
	ld a, [hl] ; $6159
	cp $04 ; $615a
	jr c, .nextSlot ; $615c
	ld a, [hl] ; $615e
	cp $ff ; $615f
	jr nz, .moveEntry ; $6161
.nextSlot:
	ld a, b ; $6163
	dec a ; $6164
	ld b, a ; $6165
	jr nz, .findNext ; $6166
.moveEntry:
	pop de ; $6168
	ld a, [hl] ; $6169
	ld [de], a ; $616a
	ld a, $ff ; $616b
	ld [hl], a ; $616d
	inc de ; $616e
	inc hl ; $616f
	ld a, [hl] ; $6170
	ld [de], a ; $6171
	xor a ; $6172
	ld [hl], a ; $6173
	inc de ; $6174
	inc hl ; $6175
	ld a, [hl] ; $6176
	ld [de], a ; $6177
	xor a ; $6178
	ld [hl], a ; $6179
	inc de ; $617a
	inc hl ; $617b
	ld a, [hl] ; $617c
	ld [de], a ; $617d
	xor a ; $617e
	ld [hl], a ; $617f
	inc de ; $6180
	inc hl ; $6181
	ld h, d ; $6182
	ld l, e ; $6183
	jr .done ; $6184
.next:
	inc hl ; $6186
	inc hl ; $6187
	inc hl ; $6188
	inc hl ; $6189
.done:
	ld a, c ; $618a
	inc a ; $618b
	ld c, a ; $618c
	cp $08 ; $618d
	jr nz, .scanLoop ; $618f
	ret ; $6191
CountCharGridEntries:
	ld hl, wCharGridEntries + 36 ; $6192
	ld c, $00 ; $6195
	ld b, $00 ; $6197
.countLoop:
	ld a, [hl] ; $6199
	cp $ff ; $619a
	jr z, .next ; $619c
	inc b ; $619e
.next:
	inc hl ; $619f
	inc hl ; $61a0
	inc hl ; $61a1
	inc hl ; $61a2
	ld a, c ; $61a3
	inc a ; $61a4
	ld c, a ; $61a5
	cp $16 ; $61a6
	jr nz, .countLoop ; $61a8
	ld a, b ; $61aa
	ld [wCharGridEntryCount], a ; $61ab
	ld hl, wCharGridEntries ; $61ae
	ld c, $00 ; $61b1
	ld b, $00 ; $61b3
.countPageLoop:
	ld a, [hl] ; $61b5
	cp $ff ; $61b6
	jr z, .nextPage ; $61b8
	inc b ; $61ba
.nextPage:
	inc hl ; $61bb
	inc hl ; $61bc
	inc hl ; $61bd
	inc hl ; $61be
	ld a, c ; $61bf
	inc a ; $61c0
	ld c, a ; $61c1
	cp $09 ; $61c2
	jr nz, .countPageLoop ; $61c4
	ld a, b ; $61c6
	ld [wCharGridCreatedCount], a ; $61c7
	ret ; $61ca
SetCharGridPageCount:
	ld a, [wCharGridEntryCount] ; $61cb
	ld hl, CharGridPageCountTable ; $61ce
	add l ; $61d1
	ld l, a ; $61d2
	jr nc, .read ; $61d3
	inc h ; $61d5
.read:
	ld a, [hl] ; $61d6
	ld [wCharGridPageCount], a ; $61d7
	ret ; $61da
CharGridPageCountTable:
	; $61db, 28 bytes (bytes:16)
	db $05, $05, $05, $05, $05, $05, $05, $06, $06, $06, $07, $07, $07, $08, $08, $08 ; 0x00
	db $09, $09, $09, $0a, $0a, $0a, $0b, $0b, $0b, $0c, $0c, $0c ; 0x10
NeedsCpuDifficultyPrompt:
	call IsMarioCastCharacter ; $61f7
	or a ; $61fa
	jr z, .notMarioCast ; $61fb
	ld a, [wCharSelectSlot] ; $61fd
	or a ; $6200
	jr z, .notMarioCast ; $6201
	ld a, $01 ; $6203
	ret ; $6205
.notMarioCast:
	xor a ; $6206
	ret ; $6207
; Returns 1 for character ids $17-$1f. Those are the nine Mario-series
; characters: id = bank $30 string index - 27 puts them at indices 50-58,
; Luigi through Peach, and GetMarioCastIndex ($3b:$7de1) does `sub $17` into a
; nine-entry table, so the block is exactly those ids and nothing else.
;
; What it gates is handedness. Both character grids reach their .toggleHandedness
; branch on `bit 3` (START) and refuse the toggle unless this returns 1, so only
; the Mario cast may be flipped; created characters set handedness at name entry
; instead (wCharSelectHandedness). The prompt row the grid draws is text 30:118
; "START: Change Hands", and DrawCharSelectSlotLabel swaps the word in it for one
; of three pre-rendered labels on $df00's three values -- 30:150/151/152 are
; "START: Right-Handed", "START: Left-Handed" and "START: Change Hands".
; On confirm the slot's wCharSelectSlotLeftHanded is set, and
; ApplyHandednessToCharRecords copies it to the match record's +$0e, which
; LoadCharacterAttributes turns into wCharMirrorAttrMask: the OAM X-flip bit plus
; the forehand/backhand swap in SelectForehandBackhand.
IsMarioCastCharacter:
	ld a, c ; $6208
	cp $17 ; $6209
	jr c, .notMarioCast ; $620b
	cp $20 ; $620d
	jr nc, .notMarioCast ; $620f
	ld a, $01 ; $6211
	ret ; $6213
.notMarioCast:
	xor a ; $6214
	ret ; $6215
