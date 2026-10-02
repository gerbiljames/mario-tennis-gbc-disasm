EraseStorySlotSaveData:
	push bc ; $4e13
	push de ; $4e14
	push hl ; $4e15
	ld h, a ; $4e16
	ld a, $0a ; $4e17
	ld [rRAMG], a ; $4e19
	call InitSaveHeader ; $4e1c
	ld a, [wCurrentStorySlot] ; $4e1f
	cp NUM_STORY_SLOTS ; $4e22
	jp nc, .badSlot ; $4e24
	add a ; $4e27
	ld c, a ; $4e28
	ld a, $00 ; $4e29
	add c ; $4e2b
	ld b, a ; $4e2c
	call ClearSaveBlock ; $4e2d
	inc b ; $4e30
	call ClearSaveBlock ; $4e31
	ld a, $1b ; $4e34
	add c ; $4e36
	ld b, a ; $4e37
	call ClearSaveBlock ; $4e38
	inc b ; $4e3b
	call ClearSaveBlock ; $4e3c
	call MirrorSaveHeaderToBank1 ; $4e3f
	xor a ; $4e42
	ld [rRAMG], a ; $4e43
	call InitCurrentSlotMinigameRecords ; $4e46
	ld a, [wCurrentStorySlot] ; $4e49
	or a ; $4e4c
	jr z, .slot0 ; $4e4d
	cp $01 ; $4e4f
	jr z, .slot1 ; $4e51
	push de ; $4e53
	ld de, SAVEFLAG_STORY_SLOT2_A ; $4e54
	farcall ClearSaveFlag ; $4e57
	pop de ; $4e5a
	push de ; $4e5b
	ld de, SAVEFLAG_STORY_SLOT2_B ; $4e5c
	farcall ClearSaveFlag ; $4e5f
	pop de ; $4e62
	jr .ok ; $4e63
.slot0:
	push de ; $4e65
	ld de, SAVEFLAG_STORY_SLOT0_A ; $4e66
	farcall ClearSaveFlag ; $4e69
	pop de ; $4e6c
	push de ; $4e6d
	ld de, SAVEFLAG_STORY_SLOT0_B ; $4e6e
	farcall ClearSaveFlag ; $4e71
	pop de ; $4e74
	jr .ok ; $4e75
.slot1:
	push de ; $4e77
	ld de, SAVEFLAG_STORY_SLOT1_A ; $4e78
	farcall ClearSaveFlag ; $4e7b
	pop de ; $4e7e
	push de ; $4e7f
	ld de, SAVEFLAG_STORY_SLOT1_B ; $4e80
	farcall ClearSaveFlag ; $4e83
	pop de ; $4e86
.ok:
	xor a ; $4e87
	jr .done ; $4e88
.badSlot:
	ld a, $01 ; $4e8a
.done:
	pop hl ; $4e8c
	pop de ; $4e8d
	pop bc ; $4e8e
	ret ; $4e8f
ClearSaveBlock:
	ld a, h ; $4e90
	or a ; $4e91
	jr nz, .clearData ; $4e92
	call ClearSaveBlockEntry ; $4e94
	jr .done ; $4e97
.clearData:
	call ClearSaveBlockData ; $4e99
.done:
	ret ; $4e9c
ClearSaveBlockData:
	push hl ; $4e9d
	push de ; $4e9e
	push bc ; $4e9f
	ld a, $00 ; $4ea0
	ldh [hSramBank], a ; $4ea2
	ld [rRAMB], a ; $4ea4
	ld a, b ; $4ea7
	call GetSaveBlockDirEntry ; $4ea8
	push bc ; $4eab
	push hl ; $4eac
	ld hl, $0001 ; $4ead
	add hl, bc ; $4eb0
	ld c, [hl] ; $4eb1
	push bc ; $4eb2
	inc hl ; $4eb3
	ld a, [hl+] ; $4eb4
	ld e, a ; $4eb5
	ld a, [hl+] ; $4eb6
	ld d, a ; $4eb7
	ld a, [hl+] ; $4eb8
	ld b, [hl] ; $4eb9
	ld c, a ; $4eba
	ld hl, SRAM_BASE ; $4ebb
	add hl, de ; $4ebe
	ld d, h ; $4ebf
	ld e, l ; $4ec0
	pop hl ; $4ec1
	ld a, l ; $4ec2
	ldh [hSramBank], a ; $4ec3
	ld [rRAMB], a ; $4ec5
	pop hl ; $4ec8
	push hl ; $4ec9
	push bc ; $4eca
.loop:
	xor a ; $4ecb
	ld [de], a ; $4ecc
	inc de ; $4ecd
	dec bc ; $4ece
	ld a, b ; $4ecf
	or c ; $4ed0
	jr nz, .loop ; $4ed1
	pop bc ; $4ed3
	pop hl ; $4ed4
	ld de, $0000 ; $4ed5
	ld a, $00 ; $4ed8
	ldh [hSramBank], a ; $4eda
	ld [rRAMB], a ; $4edc
	pop bc ; $4edf
	ld a, $01 ; $4ee0
	ld [bc], a ; $4ee2
	ld hl, $0006 ; $4ee3
	add hl, bc ; $4ee6
	ld [hl], e ; $4ee7
	inc hl ; $4ee8
	ld [hl], d ; $4ee9
	inc hl ; $4eea
	ld c, $08 ; $4eeb
.loopB:
	xor a ; $4eed
	ld [hl+], a ; $4eee
	dec c ; $4eef
	jr nz, .loopB ; $4ef0
	xor a ; $4ef2
	pop bc ; $4ef3
	pop de ; $4ef4
	pop hl ; $4ef5
	ret ; $4ef6
; ClearSaveBlockData with four extra instructions that step the pointer by 8 first -- the same block clear from a later offset. Nothing calls it.
Unused_03_EraseSaveBlock:
	push hl ; $4ef7
	push de ; $4ef8
	push bc ; $4ef9
	ld a, $00 ; $4efa
	ldh [hSramBank], a ; $4efc
	ld [rRAMB], a ; $4efe
	ld a, b ; $4f01
	call GetSaveBlockDirEntry ; $4f02
	push bc ; $4f05
	push hl ; $4f06
	ld hl, $0001 ; $4f07
	add hl, bc ; $4f0a
	ld c, [hl] ; $4f0b
	push bc ; $4f0c
	inc hl ; $4f0d
	ld a, [hl+] ; $4f0e
	ld e, a ; $4f0f
	ld a, [hl+] ; $4f10
	ld d, a ; $4f11
	ld a, [hl+] ; $4f12
	ld b, [hl] ; $4f13
	ld c, a ; $4f14
	ld hl, SRAM_BASE ; $4f15
	add hl, de ; $4f18
	ld d, h ; $4f19
	ld e, l ; $4f1a
	ld hl, $0008 ; $4f1b
	add hl, de ; $4f1e
	ld d, h ; $4f1f
	ld e, l ; $4f20
	pop hl ; $4f21
	ld a, l ; $4f22
	ldh [hSramBank], a ; $4f23
	ld [rRAMB], a ; $4f25
	pop hl ; $4f28
	push hl ; $4f29
	push bc ; $4f2a
.loop2:
	xor a ; $4f2b
	ld [de], a ; $4f2c
	inc de ; $4f2d
	dec bc ; $4f2e
	ld a, b ; $4f2f
	or c ; $4f30
	jr nz, .loop2 ; $4f31
	pop bc ; $4f33
	pop hl ; $4f34
	ld de, $0000 ; $4f35
	ld a, $00 ; $4f38
	ldh [hSramBank], a ; $4f3a
	ld [rRAMB], a ; $4f3c
	pop bc ; $4f3f
	ld a, $01 ; $4f40
	ld [bc], a ; $4f42
	ld hl, $0006 ; $4f43
	add hl, bc ; $4f46
	ld [hl], e ; $4f47
	inc hl ; $4f48
	ld [hl], d ; $4f49
	inc hl ; $4f4a
	ld c, $08 ; $4f4b
.loop3:
	xor a ; $4f4d
	ld [hl+], a ; $4f4e
	dec c ; $4f4f
	jr nz, .loop3 ; $4f50
	xor a ; $4f52
	pop bc ; $4f53
	pop de ; $4f54
	pop hl ; $4f55
	ret ; $4f56
ClearSaveBlockEntry:
	push hl ; $4f57
	push de ; $4f58
	push bc ; $4f59
	ld a, $00 ; $4f5a
	ldh [hSramBank], a ; $4f5c
	ld [rRAMB], a ; $4f5e
	ld a, b ; $4f61
	call GetSaveBlockDirEntry ; $4f62
	xor a ; $4f65
	ld [bc], a ; $4f66
	ld de, $0000 ; $4f67
	ld hl, $0006 ; $4f6a
	add hl, bc ; $4f6d
	ld [hl], e ; $4f6e
	inc hl ; $4f6f
	ld [hl], d ; $4f70
	inc hl ; $4f71
	ld c, $08 ; $4f72
	xor a ; $4f74
.loop:
	ld [hl+], a ; $4f75
	dec c ; $4f76
	jr nz, .loop ; $4f77
	pop bc ; $4f79
	pop de ; $4f7a
	pop hl ; $4f7b
	ret ; $4f7c
ReinitSaveRamPreservingBlock6:
	push af ; $4f7d
	push bc ; $4f7e
	push de ; $4f7f
	push hl ; $4f80
	push_wram_bank WRAM_STAGING ; $4f81
	ld hl, wDecompBuffer ; $4f8a
	call ReadBlock6 ; $4f8d
	ld b, a ; $4f90
	push bc ; $4f91
	call EraseAndInitSaveRam ; $4f92
	pop bc ; $4f95
	ld a, b ; $4f96
	cp $fe ; $4f97
	jr z, .initAllMinigameRecordBlocks ; $4f99
	ld hl, wDecompBuffer ; $4f9b
	call WriteBlock6WithBackup ; $4f9e
.initAllMinigameRecordBlocks:
	call InitAllMinigameRecordBlocks ; $4fa1
	pop_wram_bank ; $4fa4
	pop hl ; $4fa9
	pop de ; $4faa
	pop bc ; $4fab
	pop af ; $4fac
	ret ; $4fad
WriteExhibitionSaveBlock:
	ld a, SAVEBLOCK_EXHIBITION ; $4fae
	ld b, a ; $4fb0
	ld hl, wStorySlotData ; $4fb1
	ld de, $0000 ; $4fb4
	call WriteSaveBlock ; $4fb7
	or a ; $4fba
	ret nz ; $4fbb
	ld a, SAVEBLOCK_EXHIBITION ; $4fbc
	ld b, a ; $4fbe
	ld hl, wStorySlotData ; $4fbf
	call VerifySaveBlock ; $4fc2
	or a ; $4fc5
	ret nz ; $4fc6
	ld a, SAVEBLOCK_EXHIBITION_BACKUP ; $4fc7
	ld b, a ; $4fc9
	ld hl, wStorySlotData ; $4fca
	ld de, wTextBuffer ; $4fcd
	call WriteSaveBlock ; $4fd0
	or a ; $4fd3
	ret nz ; $4fd4
	ld a, SAVEBLOCK_EXHIBITION_BACKUP ; $4fd5
	ld b, a ; $4fd7
	ld hl, wStorySlotData ; $4fd8
	call VerifySaveBlock ; $4fdb
	or a ; $4fde
	ret nz ; $4fdf
	xor a ; $4fe0
	ret ; $4fe1
	pop_wram_bank ; $4fe2
	ld a, $ff ; $4fe7
	ret ; $4fe9
ReadExhibitionSaveBlock:
	push bc ; $4fea
	push de ; $4feb
	push hl ; $4fec
	ld a, SAVEBLOCK_EXHIBITION ; $4fed
	ld b, a ; $4fef
	ld hl, wStorySlotData ; $4ff0
	call ReadSaveBlock ; $4ff3
	jr .restore ; $4ff6
	db $3e ; $4ff8
	db $fe ; $4ff9
.restore:
	pop hl ; $4ffa
	pop de ; $4ffb
	pop bc ; $4ffc
	ret ; $4ffd
ClearSaveBlock11:
	push bc ; $4ffe
	push de ; $4fff
	push hl ; $5000
	ld a, $0a ; $5001
	ld [rRAMG], a ; $5003
	ld b, SAVEBLOCK_N64_RECORDS ; $5006
	call ClearSaveBlockData ; $5008
	push af ; $500b
	xor a ; $500c
	ld [rRAMG], a ; $500d
	pop af ; $5010
	pop hl ; $5011
	pop de ; $5012
	pop bc ; $5013
	ret ; $5014
ReadMinigameRecord:
	push af ; $5015
	push bc ; $5016
	push de ; $5017
	push hl ; $5018
	ld b, a ; $5019
	push_wram_bank WRAM_SOUND ; $501a
	ld a, b ; $5023
	sub $02 ; $5024
	jr nc, .read ; $5026
	ld a, [wCurrentStorySlot] ; $5028
	cp NUM_STORY_SLOTS ; $502b
	jr nc, .done ; $502d
.read:
	push af ; $502f
	push bc ; $5030
	push de ; $5031
	push hl ; $5032
	ld hl, wMinigameRecordBlock ; $5033
	ld c, $02 ; $5036
	xor a ; $5038
	call FillMemory16 ; $5039
	pop hl ; $503c
	pop de ; $503d
	pop bc ; $503e
	pop af ; $503f
	ld a, b ; $5040
	sub $02 ; $5041
	jr nc, .notStory ; $5043
	ld a, [wCurrentStorySlot] ; $5045
	jr .gotBlockId ; $5048
.notStory:
	xor a ; $504a
.gotBlockId:
	add $38 ; $504b
	push bc ; $504d
	ld b, a ; $504e
	ld hl, wMinigameRecordBlock ; $504f
	call ReadSaveBlock ; $5052
	pop bc ; $5055
	ld a, b ; $5056
	add a ; $5057
	ld l, a ; $5058
	xor a ; $5059
	ld h, a ; $505a
	ld de, wMinigameRecordBlock ; $505b
	add hl, de ; $505e
	ld a, [hl+] ; $505f
	ld d, [hl] ; $5060
	ld e, a ; $5061
	ld hl, wMinigameRecordValue ; $5062
	ld a, e ; $5065
	ld [hl+], a ; $5066
	ld [hl], d ; $5067
.done:
	pop_wram_bank ; $5068
	pop hl ; $506d
	pop de ; $506e
	pop bc ; $506f
	pop af ; $5070
	ret ; $5071
UpdateMinigameRecord:
	push bc ; $5072
	push de ; $5073
	push hl ; $5074
	ld b, a ; $5075
	push_wram_bank WRAM_SOUND ; $5076
	ld a, b ; $507f
	sub $02 ; $5080
	jr nc, .readSlot0 ; $5082
	ld a, [wCurrentStorySlot] ; $5084
	cp NUM_STORY_SLOTS ; $5087
	jp nc, .failed ; $5089
	jr .read ; $508c
.readSlot0:
	ld a, $00 ; $508e
.read:
	push af ; $5090
	push bc ; $5091
	push de ; $5092
	push hl ; $5093
	ld hl, wMinigameRecordBlock ; $5094
	ld c, $02 ; $5097
	xor a ; $5099
	call FillMemory16 ; $509a
	pop hl ; $509d
	pop de ; $509e
	pop bc ; $509f
	pop af ; $50a0
	add $38 ; $50a1
	push bc ; $50a3
	ld b, a ; $50a4
	ld hl, wMinigameRecordBlock ; $50a5
	call ReadSaveBlock ; $50a8
	pop bc ; $50ab
	ld hl, wMinigameRecordValue ; $50ac
	ld a, [hl+] ; $50af
	ld d, [hl] ; $50b0
	ld e, a ; $50b1
	push de ; $50b2
	ld a, b ; $50b3
	add a ; $50b4
	ld l, a ; $50b5
	xor a ; $50b6
	ld h, a ; $50b7
	ld de, wMinigameRecordBlock ; $50b8
	add hl, de ; $50bb
	pop de ; $50bc
	ld a, e ; $50bd
	ld [hl+], a ; $50be
	ld [hl], d ; $50bf
	ld a, b ; $50c0
	sub $02 ; $50c1
	jr nc, .writeSlot0 ; $50c3
	ld a, [wCurrentStorySlot] ; $50c5
	jr .write ; $50c8
.writeSlot0:
	xor a ; $50ca
.write:
	push bc ; $50cb
	add $38 ; $50cc
	ld b, a ; $50ce
	ld hl, wMinigameRecordBlock ; $50cf
	ld de, $0000 ; $50d2
	call WriteSaveBlock ; $50d5
	pop bc ; $50d8
	or a ; $50d9
	jr nz, .failed ; $50da
	ld a, b ; $50dc
	sub $02 ; $50dd
	jr nc, .verifySlot0 ; $50df
	ld a, [wCurrentStorySlot] ; $50e1
	jr .verify ; $50e4
.verifySlot0:
	xor a ; $50e6
.verify:
	push bc ; $50e7
	add $38 ; $50e8
	ld b, a ; $50ea
	ld hl, wMinigameRecordBlock ; $50eb
	call VerifySaveBlock ; $50ee
	pop bc ; $50f1
	or a ; $50f2
	jr nz, .failed ; $50f3
	ld a, b ; $50f5
	sub $02 ; $50f6
	jr nc, .backupSlot0 ; $50f8
	ld a, [wCurrentStorySlot] ; $50fa
	jr .writeBackup ; $50fd
.backupSlot0:
	xor a ; $50ff
.writeBackup:
	push bc ; $5100
	add $3b ; $5101
	ld b, a ; $5103
	ld hl, wMinigameRecordBlock ; $5104
	ld de, $0000 ; $5107
	call WriteSaveBlock ; $510a
	pop bc ; $510d
	or a ; $510e
	jr nz, .failed ; $510f
	ld a, b ; $5111
	sub $02 ; $5112
	jr nc, .backupVerifySlot0 ; $5114
	ld a, [wCurrentStorySlot] ; $5116
	jr .verifyBackup ; $5119
.backupVerifySlot0:
	xor a ; $511b
.verifyBackup:
	push bc ; $511c
	add $3b ; $511d
	ld b, a ; $511f
	ld hl, wMinigameRecordBlock ; $5120
	call VerifySaveBlock ; $5123
	pop bc ; $5126
	or a ; $5127
	jr nz, .failed ; $5128
	jr .done ; $512a
.failed:
	pop_wram_bank ; $512c
	ld a, $01 ; $5131
	pop hl ; $5133
	pop de ; $5134
	pop bc ; $5135
	ret ; $5136
.done:
	pop_wram_bank ; $5137
	xor a ; $513c
	pop hl ; $513d
	pop de ; $513e
	pop bc ; $513f
	ret ; $5140
InitCurrentSlotMinigameRecords:
	push af ; $5141
	push bc ; $5142
	push de ; $5143
	push hl ; $5144
	push_wram_bank WRAM_SOUND ; $5145
	ld a, [wCurrentStorySlot] ; $514e
	add $38 ; $5151
	ld b, a ; $5153
	ld hl, wMinigameRecordBlock ; $5154
	call ReadSaveBlock ; $5157
	xor a ; $515a
	farcall GetDefaultMinigameRecordValue ; $515b
	ld hl, wMinigameRecordBlock ; $515e
	ld a, e ; $5161
	ld [hl+], a ; $5162
	ld [hl], d ; $5163
	ld a, $01 ; $5164
	farcall GetDefaultMinigameRecordValue ; $5166
	ld hl, wMinigameRecordBlock + 2 ; $5169
	ld a, e ; $516c
	ld [hl+], a ; $516d
	ld [hl], d ; $516e
	ld a, [wCurrentStorySlot] ; $516f
	add $38 ; $5172
	ld b, a ; $5174
	ld hl, wMinigameRecordBlock ; $5175
	ld de, $0000 ; $5178
	call WriteSaveBlock ; $517b
	or a ; $517e
	jr nz, .restore ; $517f
	ld a, [wCurrentStorySlot] ; $5181
	add $3b ; $5184
	ld b, a ; $5186
	ld hl, wMinigameRecordBlock ; $5187
	ld de, $0000 ; $518a
	call WriteSaveBlock ; $518d
.restore:
	pop_wram_bank ; $5190
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
InitAllMinigameRecordBlocks:
	push af ; $519a
	push bc ; $519b
	push de ; $519c
	push hl ; $519d
	push_wram_bank WRAM_SOUND ; $519e
	push af ; $51a7
	push bc ; $51a8
	push de ; $51a9
	push hl ; $51aa
	ld hl, wMinigameRecordBlock ; $51ab
	ld c, $02 ; $51ae
	xor a ; $51b0
	call FillMemory16 ; $51b1
	pop hl ; $51b4
	pop de ; $51b5
	pop bc ; $51b6
	pop af ; $51b7
	ld hl, wMinigameRecordBlock ; $51b8
	xor a ; $51bb
.loop:
	cp $0b ; $51bc
	jr z, .eq0b ; $51be
	push af ; $51c0
	push hl ; $51c1
	farcall GetDefaultMinigameRecordValue ; $51c2
	pop hl ; $51c5
	ld a, e ; $51c6
	ld [hl+], a ; $51c7
	ld [hl], d ; $51c8
	pop af ; $51c9
	inc a ; $51ca
	inc hl ; $51cb
	jr .loop ; $51cc
.eq0b:
	ld a, SAVEBLOCK_MINIGAME_RECORDS ; $51ce
	ld b, a ; $51d0
	ld hl, wMinigameRecordBlock ; $51d1
	ld de, $0000 ; $51d4
	call WriteSaveBlock ; $51d7
	or a ; $51da
	jr nz, .restore ; $51db
	ld a, SAVEBLOCK_MINIGAME_RECORDS + 3 ; $51dd
	ld b, a ; $51df
	ld hl, wMinigameRecordBlock ; $51e0
	ld de, $0000 ; $51e3
	call WriteSaveBlock ; $51e6
	ld a, SAVEBLOCK_MINIGAME_RECORDS + 1 ; $51e9
	ld b, a ; $51eb
	ld hl, wMinigameRecordBlock ; $51ec
	ld de, $0000 ; $51ef
	call WriteSaveBlock ; $51f2
	or a ; $51f5
	jr nz, .restore ; $51f6
	ld a, SAVEBLOCK_MINIGAME_RECORDS + 4 ; $51f8
	ld b, a ; $51fa
	ld hl, wMinigameRecordBlock ; $51fb
	ld de, $0000 ; $51fe
	call WriteSaveBlock ; $5201
	ld a, SAVEBLOCK_MINIGAME_RECORDS + 2 ; $5204
	ld b, a ; $5206
	ld hl, wMinigameRecordBlock ; $5207
	ld de, $0000 ; $520a
	call WriteSaveBlock ; $520d
	or a ; $5210
	jr nz, .restore ; $5211
	ld a, SAVEBLOCK_MINIGAME_RECORDS + 5 ; $5213
	ld b, a ; $5215
	ld hl, wMinigameRecordBlock ; $5216
	ld de, $0000 ; $5219
	call WriteSaveBlock ; $521c
.restore:
	pop_wram_bank ; $521f
	pop hl ; $5224
	pop de ; $5225
	pop bc ; $5226
	pop af ; $5227
	ret ; $5228
