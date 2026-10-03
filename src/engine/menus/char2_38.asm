DrawCharNameAndType:
	push bc ; $58cd
	ld a, c ; $58ce
	ld hl, Text_30_27 ; $58cf
	add l ; $58d2
	ld l, a ; $58d3
	jr nc, .drawName ; $58d4
	inc h ; $58d6
.drawName:
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 6 ; $58d7
	ld c, $20 ; $58da
	farcall RenderTextToBuffer64 ; $58dc
	pop bc ; $58df
	ld a, c ; $58e0
	ld hl, CharNameAndTypeTable ; $58e1
	add l ; $58e4
	ld l, a ; $58e5
	jr nc, .readType ; $58e6
	inc h ; $58e8
.readType:
	ld a, [hl] ; $58e9
	ld hl, Text_30_153 ; $58ea
	add l ; $58ed
	ld l, a ; $58ee
	jr nc, .drawType ; $58ef
	inc h ; $58f1
.drawType:
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 3 ; $58f2
	ld c, $20 ; $58f5
	farcall RenderTextToBuffer64 ; $58f7
	ret ; $58fa
CharNameAndTypeTable:
	; $58fb, 32 bytes (bytes:16)
	db $00, $00, $00, $00, $04, $01, $02, $02, $00, $04, $00, $03, $02, $02, $01, $04 ; 0x00
	db $02, $04, $00, $03, $05, $05, $05, $02, $00, $04, $02, $01, $04, $00, $00, $01 ; 0x10
DrawCharSelectSlotLabel:
	ld a, [wCharGridPage] ; $591b
	cp $02 ; $591e
	jr nc, .drawName ; $5920
	ld a, [wCharGridHandedness] ; $5922
	or a ; $5925
	jr nz, .slot2 ; $5926
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH ; $5928
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 4 ; $592b
	rect_size $05, $01 ; $592e
	farcall CopyTilemapRect ; $5932
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH + 10 ; $5935
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 9 ; $5938
	rect_size $05, $01 ; $593b
	farcall CopyTilemapRect ; $593f
	jr .drawName ; $5942
.slot2:
	cp $01 ; $5944
	jr nz, .slot3 ; $5946
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH ; $5948
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 4 ; $594b
	rect_size $05, $01 ; $594e
	farcall CopyTilemapRect ; $5952
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH + 5 ; $5955
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 9 ; $5958
	rect_size $05, $01 ; $595b
	farcall CopyTilemapRect ; $595f
	jr .drawName ; $5962
.slot3:
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH ; $5964
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 4 ; $5967
	rect_size $05, $01 ; $596a
	farcall CopyTilemapRect ; $596e
	ld hl, wShadowTilemap + 26 * TILEMAP_WIDTH + 15 ; $5971
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 9 ; $5974
	rect_size $08, $01 ; $5977
	farcall CopyTilemapRect ; $597b
.drawName:
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH + 1 ; $597e
	ld h, $08 ; $5981
	rect_size $12, $01 ; $5983
	farcall FillTilemapRect ; $5987
	ret ; $598a
DrawCharGridSlotIcons:
	push_wram_bank WRAM_SCREEN ; $598b
	ld a, [wCharSelectMode] ; $5994
	add a ; $5997
	ld hl, CharGridSlotIconListPtrs_38 ; $5998
	add l ; $599b
	ld l, a ; $599c
	jr nc, .readList ; $599d
	inc h ; $599f
.readList:
	ld a, [hl+] ; $59a0
	ld h, [hl] ; $59a1
	ld l, a ; $59a2
.iconLoop:
	ld a, [hl] ; $59a3
	or a ; $59a4
	jr z, .done ; $59a5
	ld c, a ; $59a7
	inc hl ; $59a8
	ld b, [hl] ; $59a9
	inc hl ; $59aa
	ld a, [hl+] ; $59ab
	ld d, [hl] ; $59ac
	ld e, a ; $59ad
	inc hl ; $59ae
	call WriteSlotIconTiles ; $59af
	jr .iconLoop ; $59b2
.done:
	pop_wram_bank ; $59b4
	ret ; $59b9
; Indexed by wCharSelectMode * 2 in DrawCharGridSlotIcons, then
; dereferenced: each target is a $00-terminated list of 4-byte icon
; records (count, flag, then a shadow-tilemap address) fed to
; WriteSlotIconTiles. The targets are data; they used to render as four
; SubHandler* functions because hand-authored static-code seeds pointed
; at them.
CharGridSlotIconListPtrs_38:
	; $59ba, 12 bytes (records:2)
	dw CharGridSlotIconList0 ; record 0
	dw CharGridSlotIconList1 ; record 1
	dw CharGridSlotIconList2 ; record 2
	dw CharGridSlotIconList2 ; record 3
	dw CharGridSlotIconList3 ; record 4
	dw CharGridSlotIconList3 ; record 5
CharGridSlotIconList0:
	; $59c6, 9 bytes (bytes:4)
	db $01, $00, $cc, $d0 ; 0x00
	db $02, $01, $2c, $d1 ; 0x04
	db $00 ; 0x08
CharGridSlotIconList1:
	; $59cf, 17 bytes (bytes:4)
	db $01, $00, $cb, $d0 ; 0x00
	db $03, $01, $cf, $d0 ; 0x04
	db $02, $01, $2b, $d1 ; 0x08
	db $04, $01, $2f, $d1 ; 0x0c
	db $00 ; 0x10
CharGridSlotIconList2:
	; $59e0, 9 bytes (bytes:4)
	db $01, $00, $cc, $d0 ; 0x00
	db $02, $00, $2c, $d1 ; 0x04
	db $00 ; 0x08
CharGridSlotIconList3:
	; $59e9, 17 bytes (bytes:4)
	db $01, $00, $cb, $d0 ; 0x00
	db $03, $01, $cf, $d0 ; 0x04
	db $02, $00, $2b, $d1 ; 0x08
	db $04, $01, $2f, $d1 ; 0x0c
	db $00 ; 0x10
WriteSlotIconTiles:
	push af ; $59fa
	push bc ; $59fb
	push de ; $59fc
	push hl ; $59fd
	push_wram_bank WRAM_SCREEN ; $59fe
	dec c ; $5a07
	ld a, $50 ; $5a08
	add c ; $5a0a
	ld [de], a ; $5a0b
	inc de ; $5a0c
	ld a, $54 ; $5a0d
	add b ; $5a0f
	ld [de], a ; $5a10
	pop_wram_bank ; $5a11
	pop hl ; $5a16
	pop de ; $5a17
	pop bc ; $5a18
	pop af ; $5a19
	ret ; $5a1a
InitCharGridState:
	push_wram_bank WRAM_SCREEN ; $5a1b
	ld a, $00 ; $5a24
	ld [wCharGridPage], a ; $5a26
	xor a ; $5a29
	ld [wCharSelectExitCode], a ; $5a2a
	ld [wCharSelectRemoteSlot], a ; $5a2d
	ld [wCpuDifficultyPrompt], a ; $5a30
	ld [wCpuDifficultyPanelOpen], a ; $5a33
	ld [wCpuDifficultyCursor], a ; $5a36
	ld a, CHAR_NONE ; $5a39
	ld [wCharSelectSlotChars], a ; $5a3b
	ld [wCharSelectSlotChars + 1], a ; $5a3e
	ld [wCharSelectSlotChars + 2], a ; $5a41
	ld [wCharSelectSlotChars + 3], a ; $5a44
	ld [wCharSelectRemoteChars], a ; $5a47
	ld [wCharSelectRemoteChars + 1], a ; $5a4a
	ld a, [wCharSelectMode] ; $5a4d
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $5a50
	jr z, .slot2 ; $5a52
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $5a54
	jr z, .slot2 ; $5a56
	ld a, $00 ; $5a58
	jr .storeSlot ; $5a5a
.slot2:
	ld a, $02 ; $5a5c
.storeSlot:
	ld [wCharSelectSlot], a ; $5a5e
	ld hl, wCharUnlockFlags ; $5a61
	call BuildCharGridFromUnlockFlags ; $5a64
	call FillCharGridPaletteIndices ; $5a67
	call AddCreatedCharsToCharGrid ; $5a6a
	call CompactRosterGridEntries ; $5a6d
	call CompactMarioCastGridEntries ; $5a70
	call CountCharGridEntries ; $5a73
	call SetCharGridPageCount ; $5a76
	call BuildVisiblePageSpriteList ; $5a79
	pop_wram_bank ; $5a7c
	ret ; $5a81
BuildCharUnlockFlags:
	push_wram_bank WRAM_SCREEN ; $5a82
	ld hl, wCharUnlockFlags ; $5a8b
	ld bc, wCharUnlockFlags_SIZE ; $5a8e
	call ClearBytes ; $5a91
	ld b, $00 ; $5a94
.flagLoop:
	ld a, b ; $5a96
	add a ; $5a97
	ld hl, CharUnlockFlagsTable0 ; $5a98
	add l ; $5a9b
	ld l, a ; $5a9c
	jr nc, .readFlagId ; $5a9d
	inc h ; $5a9f
.readFlagId:
	ld a, [hl+] ; $5aa0
	ld d, [hl] ; $5aa1
	ld e, a ; $5aa2
	ld a, d ; $5aa3
	and e ; $5aa4
	cp $ff ; $5aa5
	jr z, .markUnlocked ; $5aa7
	farcall TestSaveFlag ; $5aa9
	jr nz, .markUnlocked ; $5aac
	jr .nextFlag ; $5aae
.markUnlocked:
	ld hl, wCharUnlockFlags ; $5ab0
	ld a, b ; $5ab3
	add l ; $5ab4
	ld l, a ; $5ab5
	jr nc, .storeUnlocked ; $5ab6
	inc h ; $5ab8
.storeUnlocked:
	ld a, $01 ; $5ab9
	ld [hl], a ; $5abb
.nextFlag:
	ld a, b ; $5abc
	inc a ; $5abd
	ld b, a ; $5abe
	cp $09 ; $5abf
	jr nz, .flagLoop ; $5ac1
	ld hl, wCharUnlockFlags + 15 ; $5ac3
	ld a, $01 ; $5ac6
	ld [hl+], a ; $5ac8
	ld [hl+], a ; $5ac9
	ld [hl+], a ; $5aca
	ld a, [wCurrentStorySlot] ; $5acb
	push af ; $5ace
	ld c, $00 ; $5acf
.slotLoop:
	ld a, c ; $5ad1
	ld [wCurrentStorySlot], a ; $5ad2
	farcall CheckStorySlot ; $5ad5
	push bc ; $5ad8
	ld hl, wCharUnlockFlags + 18 ; $5ad9
	ld b, $00 ; $5adc
.charLoop:
	ld a, b ; $5ade
	add a ; $5adf
	ld hl, CharUnlockFlagsTable1 ; $5ae0
	add l ; $5ae3
	ld l, a ; $5ae4
	jr nc, .readCharId ; $5ae5
	inc h ; $5ae7
.readCharId:
	ld a, [hl+] ; $5ae8
	ld d, [hl] ; $5ae9
	ld e, a ; $5aea
	call TestGameFlag ; $5aeb
	jr nz, .markChar ; $5aee
	jr .nextSlot ; $5af0
.markChar:
	ld hl, wCharUnlockFlags + 18 ; $5af2
	ld a, b ; $5af5
	add l ; $5af6
	ld l, a ; $5af7
	jr nc, .nextChar ; $5af8
	inc h ; $5afa
.nextChar:
	ld a, $01 ; $5afb
	ld [hl], a ; $5afd
.nextSlot:
	ld a, b ; $5afe
	inc a ; $5aff
	ld b, a ; $5b00
	cp $0d ; $5b01
	jr nz, .charLoop ; $5b03
	pop bc ; $5b05
	ld a, c ; $5b06
	inc a ; $5b07
	ld c, a ; $5b08
	cp $03 ; $5b09
	jr nz, .slotLoop ; $5b0b
	pop af ; $5b0d
	ld [wCurrentStorySlot], a ; $5b0e
	pop_wram_bank ; $5b11
	ret ; $5b16
CharUnlockFlagsTable0:
	; $5b17, 18 bytes (bytes:16)
	db $c0, $01, $ff, $ff, $e0, $01, $ff, $ff, $60, $01, $ff, $ff, $a0, $01, $40, $01 ; 0x00
	db $80, $01 ; 0x10
CharUnlockFlagsTable1:
	; $5b29, 26 bytes (bytes:16)
	db $00, $14, $20, $14, $40, $14, $60, $14, $80, $14, $a0, $14, $c0, $14, $e0, $14 ; 0x00
	db $00, $15, $20, $15, $40, $15, $60, $15, $80, $15 ; 0x10
BuildCharGridFromUnlockFlags:
	ld a, $01 ; $5b43
	ld [wCharGridBuilt], a ; $5b45
	ld de, wCharGridEntries ; $5b48
	ld c, $00 ; $5b4b
.flagLoop:
	ld a, [hl+] ; $5b4d
	or a ; $5b4e
	jr z, .storeEmpty ; $5b4f
	push hl ; $5b51
	ld hl, CharGridFromUnlockFlagsTable ; $5b52
	ld a, c ; $5b55
	add l ; $5b56
	ld l, a ; $5b57
	jr nc, .storeCharId ; $5b58
	inc h ; $5b5a
.storeCharId:
	ld a, [hl] ; $5b5b
	ld [de], a ; $5b5c
	pop hl ; $5b5d
	jr .next ; $5b5e
.storeEmpty:
	ld a, CHAR_NONE ; $5b60
	ld [de], a ; $5b62
.next:
	inc de ; $5b63
	inc de ; $5b64
	inc de ; $5b65
	inc de ; $5b66
	ld a, c ; $5b67
	inc a ; $5b68
	ld c, a ; $5b69
	cp $20 ; $5b6a
	jr nz, .flagLoop ; $5b6c
	ret ; $5b6e
; A 32-entry byte mask in exactly the format BuildCharGridFromUnlockFlags
; reads through hl -- one byte per grid slot, nonzero meaning unlocked --
; sitting immediately in front of that routine's own
; CharGridFromUnlockFlagsTable. Slots $09-$0e are zero and the rest are
; $01.
;
; Named for its format, not its purpose: no proven code loads this
; address, so which caller passes it (and whether the zeroed slots are a
; default roster or a debug one) is not established.
CharGridUnlockMask_38:
	; $5b6f, 36 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $01 ; 0x00
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x10
	db $00, $00, $00, $00 ; 0x20
CharGridFromUnlockFlagsTable:
	; $5b93, 36 bytes (bytes:16)
	db $1a, $17, $1f, $19, $1c, $18, $1e, $1b, $1d, $00, $00, $00, $00, $00, $00, $04 ; 0x00
	db $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $ff ; 0x10
	db $ff, $ff, $ff, $c9 ; 0x20
FillCharGridPaletteIndices:
	ld hl, wCharGridEntries ; $5bb7
	ld c, $00 ; $5bba
	ld b, $00 ; $5bbc
.loop:
	ld a, [hl] ; $5bbe
	push bc ; $5bbf
	push hl ; $5bc0
	farcall GetCharPaletteIndex ; $5bc1
	pop hl ; $5bc4
	pop bc ; $5bc5
	inc hl ; $5bc6
	inc a ; $5bc7
	ld [hl], a ; $5bc8
	dec hl ; $5bc9
	ld a, $04 ; $5bca
	add l ; $5bcc
	ld l, a ; $5bcd
	jr nc, .storeIndex ; $5bce
	inc h ; $5bd0
.storeIndex:
	ld a, c ; $5bd1
	inc a ; $5bd2
	ld c, a ; $5bd3
	cp $20 ; $5bd4
	jr nz, .loop ; $5bd6
	ret ; $5bd8
AddCreatedCharsToCharGrid:
	push_wram_bank WRAM_SCREEN ; $5bd9
	ld c, $00 ; $5be2
	ld b, $00 ; $5be4
	ld hl, wCreatedCharRecords ; $5be6
.slotLoop:
	ld a, [hl] ; $5be9
	cp $ff ; $5bea
	jr z, .storeCount ; $5bec
	push hl ; $5bee
	ld hl, wCharGridEntries + 36 ; $5bef
	ld a, b ; $5bf2
	add a ; $5bf3
	add a ; $5bf4
	add l ; $5bf5
	ld l, a ; $5bf6
	jr nc, .addEntry ; $5bf7
	inc h ; $5bf9
.addEntry:
	ld d, h ; $5bfa
	ld e, l ; $5bfb
	pop hl ; $5bfc
	ld a, [hl+] ; $5bfd
	ld [de], a ; $5bfe
	inc de ; $5bff
	ld a, [hl] ; $5c00
	inc a ; $5c01
	ld [de], a ; $5c02
	inc de ; $5c03
	xor a ; $5c04
	ld [de], a ; $5c05
	inc de ; $5c06
	ld a, c ; $5c07
	add a ; $5c08
	ld [de], a ; $5c09
	dec hl ; $5c0a
	ld de, $0020 ; $5c0b
	add hl, de ; $5c0e
	push hl ; $5c0f
	ld hl, wCharGridEntries + 36 ; $5c10
	ld a, b ; $5c13
	add $03 ; $5c14
	add a ; $5c16
	add a ; $5c17
	add l ; $5c18
	ld l, a ; $5c19
	jr nc, .nextSlot ; $5c1a
	inc h ; $5c1c
.nextSlot:
	ld d, h ; $5c1d
	ld e, l ; $5c1e
	pop hl ; $5c1f
	ld a, [hl+] ; $5c20
	ld [de], a ; $5c21
	inc de ; $5c22
	ld a, [hl] ; $5c23
	inc a ; $5c24
	ld [de], a ; $5c25
	inc de ; $5c26
	xor a ; $5c27
	ld [de], a ; $5c28
	ld a, c ; $5c29
	add a ; $5c2a
	inc a ; $5c2b
	inc de ; $5c2c
	ld [de], a ; $5c2d
	dec hl ; $5c2e
	ld de, $0020 ; $5c2f
	add hl, de ; $5c32
	inc b ; $5c33
	jr .done ; $5c34
.storeCount:
	ld de, $0040 ; $5c36
	add hl, de ; $5c39
.done:
	ld a, c ; $5c3a
	inc a ; $5c3b
	ld c, a ; $5c3c
	cp $03 ; $5c3d
	jr nz, .slotLoop ; $5c3f
	pop_wram_bank ; $5c41
	ret ; $5c46
