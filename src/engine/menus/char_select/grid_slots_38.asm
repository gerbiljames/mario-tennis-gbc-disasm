AdvanceToNextPlayerSlot:
	ld a, [wCharSelectMode] ; $5c47
	ld hl, CharSelectSlotRingTable ; $5c4a
	add a ; $5c4d
	add_hl_a ; $5c4e
	ld a, [hl+] ; $5c53
	ld h, [hl] ; $5c54
	ld l, a ; $5c55
	ld a, [wCharSelectSlot] ; $5c56
	ld b, a ; $5c59
.loop:
	ld a, [hl+] ; $5c5a
	cp b ; $5c5b
	jr nz, .loop ; $5c5c
	ld a, [hl] ; $5c5e
	ld [wCharSelectSlot], a ; $5c5f
	ret ; $5c62
RetreatToPreviousPlayerSlot:
	ld a, [wCharSelectMode] ; $5c63
	ld hl, CharSelectSlotRingTable ; $5c66
	add a ; $5c69
	add_hl_a ; $5c6a
	ld a, [hl+] ; $5c6f
	ld h, [hl] ; $5c70
	ld l, a ; $5c71
	ld a, [wCharSelectSlot] ; $5c72
	ld b, a ; $5c75
.findCurrent:
	ld a, [hl+] ; $5c76
	cp b ; $5c77
	jr nz, .findCurrent ; $5c78
	dec hl ; $5c7a
	dec hl ; $5c7b
	ld a, [hl] ; $5c7c
	ld [wCharSelectSlot], a ; $5c7d
	cp CHARSELECTSLOT_BACKED_OUT ; $5c80
	jr z, .done ; $5c82
	ld c, a ; $5c84
	ld a, b ; $5c85
	cp CHARSELECTSLOT_DONE ; $5c86
	jr z, .noPrevious ; $5c88
	ld a, c ; $5c8a
	ret ; $5c8b
.noPrevious:
	ld a, $fe ; $5c8c
.done:
	ret ; $5c8e
CharSelectSlotRingTable:
	; $5c8f, 12 bytes (records:2)
	table_width 2
	dw CharSelectSlotRingExhibSingles ; record 0
	dw CharSelectSlotRingExhibDoubles ; record 1
	dw CharSelectSlotRingLinkSinglesP1 ; record 2
	dw CharSelectSlotRingLinkSinglesP2 ; record 3
	dw CharSelectSlotRingLinkDoublesP1 ; record 4
	dw CharSelectSlotRingLinkDoublesP2 ; record 5
	assert_table_length NUM_CHARSELECTMODES
CharSelectSlotRingExhibSingles:
	; $5c9b, 4 bytes (bytes:4)
	db $ff, $00, $02, $ff ; 0x00
CharSelectSlotRingExhibDoubles:
	; $5c9f, 6 bytes (bytes:6)
	db $ff, $00, $01, $02, $03, $ff ; 0x00
CharSelectSlotRingLinkSinglesP1:
	; $5ca5, 4 bytes (bytes:4)
	db $ff, $00, $04, $ff ; 0x00
CharSelectSlotRingLinkSinglesP2:
	; $5ca9, 4 bytes (bytes:4)
	db $ff, $02, $04, $ff ; 0x00
CharSelectSlotRingLinkDoublesP1:
	; $5cad, 5 bytes (bytes:5)
	db $ff, $00, $01, $04, $ff ; 0x00
CharSelectSlotRingLinkDoublesP2:
	; $5cb2, 5 bytes (bytes:5)
	db $ff, $02, $03, $04, $ff ; 0x00
GetGridSlotFromCursor:
	push_wram_bank WRAM_SCREEN ; $5cb7
	ld a, [wMenuCursorX] ; $5cc0
	ld d, a ; $5cc3
	ld a, [wMenuCursorY] ; $5cc4
	ld e, a ; $5cc7
	ld a, e ; $5cc8
	add a ; $5cc9
	add e ; $5cca
	ld e, a ; $5ccb
	ld a, d ; $5ccc
	add e ; $5ccd
	ld b, a ; $5cce
	ld a, [wCharGridTopRow] ; $5ccf
	ld c, a ; $5cd2
.addPageLoop:
	ld a, c ; $5cd3
	or a ; $5cd4
	jr z, .done ; $5cd5
	ld a, $03 ; $5cd7
	add b ; $5cd9
	ld b, a ; $5cda
	dec c ; $5cdb
	jr .addPageLoop ; $5cdc
.done:
	pop_wram_bank ; $5cde
	ld a, b ; $5ce3
	ret ; $5ce4
BuildVisiblePageSpriteList:
	push af ; $5ce5
	push bc ; $5ce6
	push de ; $5ce7
	push hl ; $5ce8
	push_wram_bank WRAM_SCREEN ; $5ce9
	ld hl, wCharGridEntries ; $5cf2
	ld a, [wCharGridTopRow] ; $5cf5
	ld bc, $000c ; $5cf8
.seekPage:
	or a ; $5cfb
	jr z, .copyStart ; $5cfc
	add hl, bc ; $5cfe
	dec a ; $5cff
	jr .seekPage ; $5d00
.copyStart:
	ld c, $00 ; $5d02
	ld de, wScreenScratch ; $5d04
.copyLoop:
	ld a, [hl+] ; $5d07
	ld [de], a ; $5d08
	inc de ; $5d09
	ld a, [hl+] ; $5d0a
	ld [de], a ; $5d0b
	ld a, [hl+] ; $5d0c
	or a ; $5d0d
	jr z, .nextSlot ; $5d0e
	xor a ; $5d10
	ld [de], a ; $5d11
.nextSlot:
	inc de ; $5d12
	inc hl ; $5d13
	ld a, c ; $5d14
	inc a ; $5d15
	ld c, a ; $5d16
	cp $06 ; $5d17
	jr nz, .copyLoop ; $5d19
	pop_wram_bank ; $5d1b
	pop hl ; $5d20
	pop de ; $5d21
	pop bc ; $5d22
	pop af ; $5d23
	ret ; $5d24
; TestAndSetGridEntryTaken with `xor a` in place of `ld a, $01`: the Clear member of the pair. Nothing calls it.
Unused_38_TestAndClearGridEntryTaken:
	push bc ; $5d25
	push de ; $5d26
	push hl ; $5d27
	push_wram_bank WRAM_SCREEN ; $5d28
	call GetGridEntryTakenPtr ; $5d31
	ld a, [hl] ; $5d34
	ld b, a ; $5d35
	xor a ; $5d36
	ld [hl], a ; $5d37
	pop_wram_bank ; $5d38
	ld a, b ; $5d3d
	pop hl ; $5d3e
	pop de ; $5d3f
	pop bc ; $5d40
	ret ; $5d41
TestAndSetGridEntryTaken:
	push bc ; $5d42
	push de ; $5d43
	push hl ; $5d44
	push_wram_bank WRAM_SCREEN ; $5d45
	call GetGridEntryTakenPtr ; $5d4e
	ld a, [hl] ; $5d51
	ld b, a ; $5d52
	ld a, $01 ; $5d53
	ld [hl], a ; $5d55
	pop_wram_bank ; $5d56
	ld a, b ; $5d5b
	pop hl ; $5d5c
	pop de ; $5d5d
	pop bc ; $5d5e
	ret ; $5d5f
GetGridEntryTakenPtr:
	ld hl, wCharGridEntries ; $5d60
	ld a, c ; $5d63
	ld bc, $000c ; $5d64
.rowLoop:
	or a ; $5d67
	jr z, .addColumn ; $5d68
	add hl, bc ; $5d6a
	dec a ; $5d6b
	jr .rowLoop ; $5d6c
.addColumn:
	ld a, e ; $5d6e
	add a ; $5d6f
	add e ; $5d70
	ld e, a ; $5d71
	ld a, d ; $5d72
	add e ; $5d73
	add a ; $5d74
	add a ; $5d75
	add_hl_a ; $5d76
	ld a, $02 ; $5d7b
	add_hl_a ; $5d7d
	ret ; $5d82
BuildCreatedCharRecords:
	push af ; $5d83
	push bc ; $5d84
	push de ; $5d85
	push hl ; $5d86
	push_wram_bank WRAM_SCREEN ; $5d87
	ld hl, wCreatedCharRecords ; $5d90
	ld bc, wCreatedCharRecords_SIZE ; $5d93
	call ClearBytes ; $5d96
	ld bc, wCreatedCharRecords ; $5d99
	ld a, $80 ; $5d9c
.charLoop:
	push af ; $5d9e
	farcall LoadCharacterRecordToBuffer ; $5d9f
	farcall CheckCharRecordPresent ; $5da2
	ld hl, CREATEDCHAR_CHAR ; $5da5
	add hl, bc ; $5da8
	ld a, [wCharRecordScratchChar] ; $5da9
	cp $04 ; $5dac
	jr c, .createdChar ; $5dae
	ld a, $ff ; $5db0
	ld [hl], a ; $5db2
	ld hl, CREATED_CHAR_RECORD_SIZE ; $5db3
	add hl, bc ; $5db6
	ld b, h ; $5db7
	ld c, l ; $5db8
	ld hl, CREATEDCHAR_CHAR ; $5db9
	add hl, bc ; $5dbc
	ld a, $ff ; $5dbd
	ld [hl], a ; $5dbf
	ld hl, CREATED_CHAR_RECORD_SIZE ; $5dc0
	add hl, bc ; $5dc3
	ld b, h ; $5dc4
	ld c, l ; $5dc5
	jp .next ; $5dc6
.createdChar:
	ld a, [wStoryMainChar] ; $5dc9
	ld [hl], a ; $5dcc
	ld hl, CREATEDCHAR_PALETTE ; $5dcd
	add hl, bc ; $5dd0
	ld a, [wStoryMainPalette] ; $5dd1
	ld [hl], a ; $5dd4
	ld hl, CREATEDCHAR_LEVEL ; $5dd5
	add hl, bc ; $5dd8
	ld a, [wStoryMainLevel] ; $5dd9
	ld [hl], a ; $5ddc
	ld hl, CREATEDCHAR_SPIN ; $5ddd
	add hl, bc ; $5de0
	ld a, [wStoryMainSpinLevel] ; $5de1
	ld [hl], a ; $5de4
	ld hl, CREATEDCHAR_POWER ; $5de5
	add hl, bc ; $5de8
	ld a, [wStoryMainPowerLevel] ; $5de9
	ld [hl], a ; $5dec
	ld hl, CREATEDCHAR_CONTROL ; $5ded
	add hl, bc ; $5df0
	ld a, [wStoryMainControlLevel] ; $5df1
	ld [hl], a ; $5df4
	ld hl, CREATEDCHAR_SPEED ; $5df5
	add hl, bc ; $5df8
	ld a, [wStoryMainSpeedLevel] ; $5df9
	ld [hl], a ; $5dfc
	push bc ; $5dfd
	ld a, CREATEDCHAR_NAME ; $5dfe
	add c ; $5e00
	ld e, a ; $5e01
	ld d, b ; $5e02
	ld hl, wStoryMainName ; $5e03
	ld bc, CHARREC_CHAR - CHARREC_NAME ; $5e06
	call CopyMemoryBC ; $5e09
	pop bc ; $5e0c
	ld hl, CREATED_CHAR_RECORD_SIZE ; $5e0d
	add hl, bc ; $5e10
	ld b, h ; $5e11
	ld c, l ; $5e12
	ld a, [wStoryPartnerChar] ; $5e13
	ld [hl], a ; $5e16
	ld hl, CREATEDCHAR_PALETTE ; $5e17
	add hl, bc ; $5e1a
	ld a, [wStoryPartnerPalette] ; $5e1b
	ld [hl], a ; $5e1e
	ld hl, CREATEDCHAR_LEVEL ; $5e1f
	add hl, bc ; $5e22
	ld a, [wStoryPartnerLevel] ; $5e23
	ld [hl], a ; $5e26
	ld hl, CREATEDCHAR_SPIN ; $5e27
	add hl, bc ; $5e2a
	ld a, [wStoryPartnerSpinLevel] ; $5e2b
	ld [hl], a ; $5e2e
	ld hl, CREATEDCHAR_POWER ; $5e2f
	add hl, bc ; $5e32
	ld a, [wStoryPartnerPowerLevel] ; $5e33
	ld [hl], a ; $5e36
	ld hl, CREATEDCHAR_CONTROL ; $5e37
	add hl, bc ; $5e3a
	ld a, [wStoryPartnerControlLevel] ; $5e3b
	ld [hl], a ; $5e3e
	ld hl, CREATEDCHAR_SPEED ; $5e3f
	add hl, bc ; $5e42
	ld a, [wStoryPartnerSpeedLevel] ; $5e43
	ld [hl], a ; $5e46
	push bc ; $5e47
	ld a, CREATEDCHAR_NAME ; $5e48
	add c ; $5e4a
	ld e, a ; $5e4b
	ld d, b ; $5e4c
	ld hl, wStoryPartnerName ; $5e4d
	ld bc, CHARREC_CHAR - CHARREC_NAME ; $5e50
	call CopyMemoryBC ; $5e53
	pop bc ; $5e56
	ld hl, CREATED_CHAR_RECORD_SIZE ; $5e57
	add hl, bc ; $5e5a
	ld b, h ; $5e5b
	ld c, l ; $5e5c
.next:
	pop af ; $5e5d
	inc a ; $5e5e
	cp $83 ; $5e5f
	jp nz, .charLoop ; $5e61
	pop_wram_bank ; $5e64
	pop hl ; $5e69
	pop de ; $5e6a
	pop bc ; $5e6b
	pop af ; $5e6c
	ret ; $5e6d
ResolveSelectedCharIds:
	push_wram_bank WRAM_SCREEN ; $5e6e
	ld c, $00 ; $5e77
	ld hl, wCharSelectSlotChars ; $5e79
.slotLoop:
	ld a, [hl] ; $5e7c
	cp $ff ; $5e7d
	jr z, .storeId ; $5e7f
	push hl ; $5e81
	ld hl, wCharGridEntries ; $5e82
	add a ; $5e85
	add a ; $5e86
	add_hl_a ; $5e87
	ld a, [hl] ; $5e8c
	cp $04 ; $5e8d
	jr nc, .gotId ; $5e8f
	inc hl ; $5e91
	inc hl ; $5e92
	inc hl ; $5e93
	ld a, [hl] ; $5e94
	or $80 ; $5e95
.gotId:
	pop hl ; $5e97
.storeId:
	ld [hl+], a ; $5e98
	ld a, c ; $5e99
	inc a ; $5e9a
	ld c, a ; $5e9b
	cp $04 ; $5e9c
	jr nz, .slotLoop ; $5e9e
	pop_wram_bank ; $5ea0
	ret ; $5ea5
InitMatchCharsFromSelection:
	push_wram_bank WRAM_SCREEN ; $5ea6
	call CacheStorySlotRecords ; $5eaf
	ld a, [wCharSelectSlotChars] ; $5eb2
	cp CHAR_NONE ; $5eb5
	jr z, .slot2 ; $5eb7
	cp CHAR_STORY_MAIN ; $5eb9
	jr c, .slot1RosterChar ; $5ebb
	ld c, a ; $5ebd
	and $07 ; $5ebe
	srl a ; $5ec0
	ld b, a ; $5ec2
	ld a, c ; $5ec3
	call LoadCachedStorySlotRecords ; $5ec4
	and $81 ; $5ec7
	ld b, a ; $5ec9
	ld c, MATCHREC_P1_MAIN ; $5eca
	farcall InitMatchRecordFromCharId ; $5ecc
	jr .slot2 ; $5ecf
.slot1RosterChar:
	ld b, a ; $5ed1
	ld c, MATCHREC_P1_MAIN ; $5ed2
	farcall InitMatchRecordFromCharId ; $5ed4
.slot2:
	ld a, [wCharSelectSlotChars + 1] ; $5ed7
	cp CHAR_NONE ; $5eda
	jr z, .slot3 ; $5edc
	cp CHAR_STORY_MAIN ; $5ede
	jr c, .slot2RosterChar ; $5ee0
	ld c, a ; $5ee2
	and $07 ; $5ee3
	srl a ; $5ee5
	ld b, a ; $5ee7
	ld a, c ; $5ee8
	call LoadCachedStorySlotRecords ; $5ee9
	and $81 ; $5eec
	ld b, a ; $5eee
	ld c, MATCHREC_P1_PARTNER ; $5eef
	farcall InitMatchRecordFromCharId ; $5ef1
	jr .slot3 ; $5ef4
.slot2RosterChar:
	ld b, a ; $5ef6
	ld c, MATCHREC_P1_PARTNER ; $5ef7
	farcall InitMatchRecordFromCharId ; $5ef9
.slot3:
	ld a, [wCharSelectSlotChars + 2] ; $5efc
	cp CHAR_NONE ; $5eff
	jr z, .slot4 ; $5f01
	cp CHAR_STORY_MAIN ; $5f03
	jr c, .slot3RosterChar ; $5f05
	ld c, a ; $5f07
	and $07 ; $5f08
	srl a ; $5f0a
	ld b, a ; $5f0c
	ld a, c ; $5f0d
	call LoadCachedStorySlotRecords ; $5f0e
	and $81 ; $5f11
	ld b, a ; $5f13
	ld c, MATCHREC_P2_MAIN ; $5f14
	farcall InitMatchRecordFromCharId ; $5f16
	jr .slot4 ; $5f19
.slot3RosterChar:
	ld b, a ; $5f1b
	ld c, MATCHREC_P2_MAIN ; $5f1c
	farcall InitMatchRecordFromCharId ; $5f1e
.slot4:
	ld a, [wCharSelectSlotChars + 3] ; $5f21
	cp CHAR_NONE ; $5f24
	jr z, .done ; $5f26
	cp CHAR_STORY_MAIN ; $5f28
	jr c, .slot4RosterChar ; $5f2a
	ld c, a ; $5f2c
	and $07 ; $5f2d
	srl a ; $5f2f
	ld b, a ; $5f31
	ld a, c ; $5f32
	call LoadCachedStorySlotRecords ; $5f33
	and $81 ; $5f36
	ld b, a ; $5f38
	ld c, MATCHREC_P2_PARTNER ; $5f39
	farcall InitMatchRecordFromCharId ; $5f3b
	jr .done ; $5f3e
.slot4RosterChar:
	ld b, a ; $5f40
	ld c, MATCHREC_P2_PARTNER ; $5f41
	farcall InitMatchRecordFromCharId ; $5f43
.done:
	pop_wram_bank ; $5f46
	ret ; $5f4b
