RetreatRemotePlayerSlot:
	ld a, [wCharSelectMode] ; $6a09
	ld hl, RemotePlayerSlotLists_38 ; $6a0c
	add a ; $6a0f
	add l ; $6a10
	ld l, a ; $6a11
	jr nc, .readList ; $6a12
	inc h ; $6a14
.readList:
	ld a, [hl+] ; $6a15
	ld h, [hl] ; $6a16
	ld l, a ; $6a17
	ld a, [wCharSelectRemoteSlot] ; $6a18
	ld b, a ; $6a1b
.findCurrent:
	ld a, [hl+] ; $6a1c
	cp b ; $6a1d
	jr nz, .findCurrent ; $6a1e
	dec hl ; $6a20
	dec hl ; $6a21
	ld a, [hl] ; $6a22
	ld [wCharSelectRemoteSlot], a ; $6a23
	ret ; $6a26
RemotePlayerSlotLists_38:
	; $6a27, 12 bytes (records:2)
	dw RemotePlayerSlotList0 ; record 0
	dw RemotePlayerSlotList0 ; record 1
	dw RemotePlayerSlotList0 ; record 2
	dw RemotePlayerSlotList0 ; record 3
	dw RemotePlayerSlotList1 ; record 4
	dw RemotePlayerSlotList1 ; record 5
RemotePlayerSlotList0:
	; $6a33, 4 bytes (bytes:4)
	db $ff, $00, $02, $ff ; 0x00
RemotePlayerSlotList1:
	; $6a37, 5 bytes (bytes:5)
	db $ff, $00, $01, $02, $ff ; 0x00
Unused_38_GetGridEntryAtCursor:
	call GetGridSlotFromCursor ; $6a3c
	ld hl, wCharGridEntries ; $6a3f
	add a ; $6a42
	add a ; $6a43
	add l ; $6a44
	ld l, a ; $6a45
	jr nc, .store ; $6a46
	inc h ; $6a48
.store:
	ld a, [hl] ; $6a49
	ret ; $6a4a
SetGridEntryTakenByCharId:
	ld a, d ; $6a4b
	cp $04 ; $6a4c
	jr nc, .search ; $6a4e
	xor a ; $6a50
	ret ; $6a51
.search:
	ld c, $00 ; $6a52
	ld hl, wCharGridEntries ; $6a54
.searchLoop:
	ld a, [hl] ; $6a57
	cp d ; $6a58
	jr z, .found ; $6a59
	inc hl ; $6a5b
	inc hl ; $6a5c
	inc hl ; $6a5d
	inc hl ; $6a5e
	ld a, c ; $6a5f
	inc a ; $6a60
	ld c, a ; $6a61
	cp $1f ; $6a62
	jr nz, .searchLoop ; $6a64
	ld a, $fe ; $6a66
	ret ; $6a68
.found:
	inc hl ; $6a69
	inc hl ; $6a6a
	ld a, e ; $6a6b
	or a ; $6a6c
	jr z, .clear ; $6a6d
	ld a, [hl] ; $6a6f
	or a ; $6a70
	jr nz, .done ; $6a71
	ld a, $01 ; $6a73
	ld [hl], a ; $6a75
	jr .store ; $6a76
.clear:
	ld [hl], e ; $6a78
.store:
	ld a, $01 ; $6a79
	ret ; $6a7b
.done:
	ld a, $ff ; $6a7c
	ret ; $6a7e
InitLinkMatchCharsFromSelection:
	push_wram_bank WRAM_SCREEN ; $6a7f
	call CacheStorySlotNames ; $6a88
	ld a, [wCharSelectMode] ; $6a8b
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $6a8e
	jr z, .slot3Entry ; $6a90
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $6a92
	jr z, .slot3Entry ; $6a94
	ld a, [wCharSelectSlotChars] ; $6a96
	cp CHAR_NONE ; $6a99
	jr z, .slot2 ; $6a9b
	cp CHAR_STORY_MAIN ; $6a9d
	jr c, .slot1Created ; $6a9f
	ld c, a ; $6aa1
	and $07 ; $6aa2
	srl a ; $6aa4
	ld b, a ; $6aa6
	ld a, c ; $6aa7
	call LoadCachedStorySlotName ; $6aa8
	and $81 ; $6aab
	ld b, a ; $6aad
	ld c, $00 ; $6aae
	farcall InitCa00RecordFromCharId ; $6ab0
	jr .slot2 ; $6ab3
.slot1Created:
	ld b, a ; $6ab5
	ld c, $00 ; $6ab6
	farcall InitCa00RecordFromCharId ; $6ab8
.slot2:
	ld a, [wCharSelectSlotChars + 1] ; $6abb
	cp $ff ; $6abe
	jr z, .slot3 ; $6ac0
	cp $80 ; $6ac2
	jr c, .slot2Created ; $6ac4
	ld c, a ; $6ac6
	and $07 ; $6ac7
	srl a ; $6ac9
	ld b, a ; $6acb
	ld a, c ; $6acc
	call LoadCachedStorySlotName ; $6acd
	and $81 ; $6ad0
	ld b, a ; $6ad2
	ld c, $01 ; $6ad3
	farcall InitCa00RecordFromCharId ; $6ad5
	jr .slot3 ; $6ad8
.slot2Created:
	ld b, a ; $6ada
	ld c, $01 ; $6adb
	farcall InitCa00RecordFromCharId ; $6add
.slot3:
	jr .applySettings ; $6ae0
.slot3Entry:
	ld a, [wCharSelectSlotChars + 2] ; $6ae2
	cp $ff ; $6ae5
	jr z, .slot4 ; $6ae7
	cp $80 ; $6ae9
	jr c, .slot3Created ; $6aeb
	ld c, a ; $6aed
	and $07 ; $6aee
	srl a ; $6af0
	ld b, a ; $6af2
	ld a, c ; $6af3
	call LoadCachedStorySlotName ; $6af4
	and $81 ; $6af7
	ld b, a ; $6af9
	ld c, $02 ; $6afa
	farcall InitCa00RecordFromCharId ; $6afc
	jr .slot4 ; $6aff
.slot3Created:
	ld b, a ; $6b01
	ld c, $02 ; $6b02
	farcall InitCa00RecordFromCharId ; $6b04
.slot4:
	ld a, [wCharSelectSlotChars + 3] ; $6b07
	cp $ff ; $6b0a
	jr z, .applySettings ; $6b0c
	cp $80 ; $6b0e
	jr c, .slot4Created ; $6b10
	ld c, a ; $6b12
	and $07 ; $6b13
	srl a ; $6b15
	ld b, a ; $6b17
	ld a, c ; $6b18
	call LoadCachedStorySlotName ; $6b19
	and $81 ; $6b1c
	ld b, a ; $6b1e
	ld c, $03 ; $6b1f
	farcall InitCa00RecordFromCharId ; $6b21
	jr .applySettings ; $6b24
.slot4Created:
	ld b, a ; $6b26
	ld c, $03 ; $6b27
	farcall InitCa00RecordFromCharId ; $6b29
.applySettings:
	pop_wram_bank ; $6b2c
	ret ; $6b31
Unused_38_LinkCpuDifficultyDebugLoop:
	ld a, [wCharSelectMode] ; $6b32
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $6b35
	ret z ; $6b37
	cp CHARSELECTMODE_LINK_SINGLES_P1 ; $6b38
	ret z ; $6b3a
	xor a ; $6b3b
	ld [wLinkCpuDifficulty], a ; $6b3c
	ld [wCpuDifficultyCursor], a ; $6b3f
.doubles:
	push af ; $6b42
	farcall RunLinkInputFrame ; $6b43
	pop af ; $6b46
	ldh a, [hLinkRemoteInputBuf] ; $6b47
	ld [wMenuInputPressed], a ; $6b49
	ld a, [wMenuInputPressed] ; $6b4c
	xor $0f ; $6b4f
	jr nz, .done ; $6b51
	call JumpSoftReset ; $6b53
.done:
	push de ; $6b56
	push af ; $6b57
	ld a, [wLinkCpuDifficulty] ; $6b58
	ld_cell de, $03, $03 ; $6b5b
	call PrintDecimalByte ; $6b5e
	pop af ; $6b61
	pop de ; $6b62
	push de ; $6b63
	push af ; $6b64
	ld a, [wCpuDifficultyCursor] ; $6b65
	ld_cell de, $03, $04 ; $6b68
	call PrintDecimalByte ; $6b6b
	pop af ; $6b6e
	pop de ; $6b6f
	call Unused_38_RunLinkCpuDifficultySubmenu ; $6b70
	call Unused_38_HandleLinkCpuDifficultyInput ; $6b73
	jr .doubles ; $6b76
	ret ; $6b78
Unused_38_HandleLinkCpuDifficultyInput:
	ldh a, [hLinkRemoteInput] ; $6b79
	bit 5, a ; $6b7b
	jr nz, .decrease ; $6b7d
	bit 4, a ; $6b7f
	jr nz, .increase ; $6b81
	bit 0, a ; $6b83
	jr nz, .confirm ; $6b85
	bit 1, a ; $6b87
	jr nz, .cancel ; $6b89
	ret ; $6b8b
.decrease:
	ld a, [wLinkCpuDifficulty] ; $6b8c
	dec a ; $6b8f
	add a ; $6b90
	jr nc, .decCheckMax ; $6b91
	ld a, $04 ; $6b93
	dec a ; $6b95
	jr .storeDecrease ; $6b96
.decCheckMax:
	rra ; $6b98
	cp $04 ; $6b99
	jr c, .storeDecrease ; $6b9b
	xor a ; $6b9d
.storeDecrease:
	ld [wLinkCpuDifficulty], a ; $6b9e
	ret ; $6ba1
.increase:
	ld a, [wLinkCpuDifficulty] ; $6ba2
	inc a ; $6ba5
	add a ; $6ba6
	jr nc, .incCheckMax ; $6ba7
	ld a, $04 ; $6ba9
	dec a ; $6bab
	jr .storeIncrease ; $6bac
.incCheckMax:
	rra ; $6bae
	cp $04 ; $6baf
	jr c, .storeIncrease ; $6bb1
	xor a ; $6bb3
.storeIncrease:
	ld [wLinkCpuDifficulty], a ; $6bb4
	ret ; $6bb7
.confirm:
	call Unused_38_StubNop_38_0 ; $6bb8
	ret ; $6bbb
.cancel:
	call Unused_38_StubNop_38_1 ; $6bbc
	ret ; $6bbf
Unused_38_StubNop_38_0:
	ret ; $6bc0
Unused_38_StubNop_38_1:
	ret ; $6bc1
Unused_38_CheckMarioCastEquipCategory:
	call IsMarioCastCharacter ; $6bc2
	or a ; $6bc5
	jr z, .returnFalse ; $6bc6
	ld a, [wCharSelectSlot] ; $6bc8
	or a ; $6bcb
	jr z, .returnFalse ; $6bcc
	cp $02 ; $6bce
	jr z, .returnFalse ; $6bd0
	ld a, $01 ; $6bd2
	ret ; $6bd4
.returnFalse:
	xor a ; $6bd5
	ret ; $6bd6
Unused_38_RunLinkCpuDifficultySubmenu:
	push_wram_bank WRAM_SCREEN ; $6bd7
	ld a, [wCpuDifficultyPanelOpen] ; $6be0
	or a ; $6be3
	jr nz, .inputLoop ; $6be4
	call OpenCpuDifficultyPanel ; $6be6
	call QueueCpuDifficultyPanelToVram ; $6be9
	ld a, $01 ; $6bec
	ld [wCpuDifficultyPanelOpen], a ; $6bee
.inputLoop:
	call HandleCpuDifficultyInput ; $6bf1
	call DrawCpuDifficultyCursorBox ; $6bf4
	ld a, [wMenuInputPressed] ; $6bf7
	bit PADB_A, a ; $6bfa
	jr nz, .confirm ; $6bfc
	bit 1, a ; $6bfe
	jr nz, .cancel ; $6c00
	jr .done ; $6c02
.cancel:
	call CloseCpuDifficultyPanel ; $6c04
	sound SFX_MENU_CANCEL ; $6c07
	wram_bank WRAM_SCREEN ; $6c09
	call ClearPlayerSlotPortrait ; $6c0f
	call BuildVisiblePageSpriteList ; $6c12
	jr .storeDifficulty ; $6c15
.confirm:
	ld hl, wCharSelectSlotDifficulty ; $6c17
	ld a, [wCpuDifficultyCursor] ; $6c1a
	call GetGridSlotFromCursor ; $6c1d
	call DrawPlayerSlotPortrait ; $6c20
.storeDifficulty:
	call DrawCharGridSlotPrompt ; $6c23
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $6c26
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $6c29
	ld c, $04 ; $6c2c
	call QueueVRAMCopy ; $6c2e
.done:
	pop_wram_bank ; $6c31
	ret ; $6c36
GetGridSlotFromLinkCursor:
	push_wram_bank WRAM_SCREEN ; $6c37
	ld a, [wMenuCursor2X] ; $6c40
	ld d, a ; $6c43
	ld a, [wMenuCursor2Y] ; $6c44
	ld e, a ; $6c47
	ld a, e ; $6c48
	add a ; $6c49
	add e ; $6c4a
	ld e, a ; $6c4b
	ld a, d ; $6c4c
	add e ; $6c4d
	ld b, a ; $6c4e
	ldh a, [hLinkCursorPage] ; $6c4f
	ld c, a ; $6c51
.loop:
	ld a, c ; $6c52
	or a ; $6c53
	jr z, .restore ; $6c54
	ld a, $03 ; $6c56
	add b ; $6c58
	ld b, a ; $6c59
	dec c ; $6c5a
	jr .loop ; $6c5b
.restore:
	pop_wram_bank ; $6c5d
	ld a, b ; $6c62
	ret ; $6c63
GetLinkCursorSelectionCode:
	call GetGridSlotFromLinkCursor ; $6c64
	ld hl, wCharGridEntries ; $6c67
	add a ; $6c6a
	add a ; $6c6b
	add l ; $6c6c
	ld l, a ; $6c6d
	jr nc, .readEntry ; $6c6e
	inc h ; $6c70
.readEntry:
	ld a, [hl] ; $6c71
	cp $ff ; $6c72
	jr nz, .checkTaken ; $6c74
	ld a, $22 ; $6c76
	jr .done ; $6c78
.checkTaken:
	inc hl ; $6c7a
	inc hl ; $6c7b
	ld b, [hl] ; $6c7c
	dec hl ; $6c7d
	dec hl ; $6c7e
	ld c, a ; $6c7f
	ld a, b ; $6c80
	or a ; $6c81
	jr z, .useCode ; $6c82
	ld a, $22 ; $6c84
	jr .done ; $6c86
.useCode:
	ld a, c ; $6c88
.done:
	ret ; $6c89
UpdateMenuCursorFromLinkInput:
	ld b, a ; $6c8a
	push_wram_bank WRAM_SCREEN ; $6c8b
	ld a, [wMenuCursor2X] ; $6c94
	ld d, a ; $6c97
	ld a, [wMenuCursor2Y] ; $6c98
	ld e, a ; $6c9b
	ld a, b ; $6c9c
	xor $0f ; $6c9d
	jr nz, .checkButtons ; $6c9f
	ld b, $20 ; $6ca1
	jr .storeCommand ; $6ca3
.checkButtons:
	ld a, b ; $6ca5
	and $f0 ; $6ca6
	ld a, b ; $6ca8
	jr nz, .checkRight ; $6ca9
	ld a, b ; $6cab
	bit 0, a ; $6cac
	jr z, .checkB ; $6cae
	ld a, [wCharGridHandedness] ; $6cb0
	cp $01 ; $6cb3
	jr nz, .sendSelect ; $6cb5
	ld b, $28 ; $6cb7
	jr .storeCommand ; $6cb9
.sendSelect:
	ld b, $21 ; $6cbb
	jr .storeCommand ; $6cbd
.checkB:
	bit 1, a ; $6cbf
	jr z, .checkRight ; $6cc1
	ld b, $23 ; $6cc3
	jr .storeCommand ; $6cc5
.checkRight:
	bit 4, a ; $6cc7
	jr z, .checkLeft ; $6cc9
	call MoveLinkCursorRight ; $6ccb
	jp .afterMove ; $6cce
.checkLeft:
	bit 5, a ; $6cd1
	jr z, .checkUp ; $6cd3
	call MoveLinkCursorLeft ; $6cd5
	jr .afterMove ; $6cd8
.checkUp:
	bit 6, a ; $6cda
	jr z, .checkDown ; $6cdc
	call MoveLinkCursorUp ; $6cde
	jr .afterMove ; $6ce1
.checkDown:
	bit 7, a ; $6ce3
	jr z, .afterMove ; $6ce5
	call MoveLinkCursorDown ; $6ce7
	jr .afterMove ; $6cea
.afterMove:
	call GetLinkCursorSelectionCode ; $6cec
	ld b, a ; $6cef
	ld a, [wMenuCursor2X] ; $6cf0
	cp d ; $6cf3
	jr nz, .moved ; $6cf4
	ld a, [wMenuCursor2Y] ; $6cf6
	cp e ; $6cf9
	jr nz, .moved ; $6cfa
.storeCommand:
	pop_wram_bank ; $6cfc
	xor a ; $6d01
	ret ; $6d02
.moved:
	pop_wram_bank ; $6d03
	ld a, $01 ; $6d08
	ret ; $6d0a
