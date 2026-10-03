StoreRemoteCpuDifficulty:
	ld a, [wCharSelectMode] ; $6609
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $660c
	jr z, .slot0 ; $660e
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $6610
	jr z, .slot0 ; $6612
	ld a, c ; $6614
	ld [wCharSelectSlotDifficulty + 3], a ; $6615
	ret ; $6618
.slot0:
	ld a, c ; $6619
	ld [wCharSelectSlotDifficulty + 1], a ; $661a
	ret ; $661d
ApplyRemoteCharSelection:
	push_wram_bank WRAM_SCREEN ; $661e
	push bc ; $6627
	ld d, c ; $6628
	ld e, $01 ; $6629
	call SetGridEntryTakenByCharId ; $662b
	pop bc ; $662e
	cp $ff ; $662f
	jr z, .done ; $6631
	push bc ; $6633
	call DrawRemoteSlotPortrait ; $6634
	call BuildVisiblePageSpriteList ; $6637
	pop bc ; $663a
	ld a, [wCharSelectRemoteSlot] ; $663b
	cp $00 ; $663e
	jr nz, .slot2 ; $6640
	ld a, c ; $6642
	ld [wCharSelectRemoteChars], a ; $6643
	jr .advanceSlot ; $6646
.slot2:
	ld a, c ; $6648
	ld [wCharSelectRemoteChars + 1], a ; $6649
.advanceSlot:
	call AdvanceRemotePlayerSlot ; $664c
.done:
	pop_wram_bank ; $664f
	ret ; $6654
ApplyRemoteCharCancel:
	push bc ; $6655
	call RetreatRemotePlayerSlot ; $6656
	pop bc ; $6659
	cp $ff ; $665a
	jr z, .refresh ; $665c
	ld a, [wCharSelectRemoteSlot] ; $665e
	cp $00 ; $6661
	jr nz, .slot2 ; $6663
	ld a, [wCharSelectRemoteChars] ; $6665
	ld c, a ; $6668
	jr .clearEntry ; $6669
.slot2:
	ld a, [wCharSelectRemoteChars + 1] ; $666b
	ld c, a ; $666e
.clearEntry:
	ld d, c ; $666f
	ld e, $00 ; $6670
	call SetGridEntryTakenByCharId ; $6672
	wram_bank WRAM_SCREEN ; $6675
	ld a, [wCharSelectMode] ; $667b
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $667e
	jr z, .clearOwnSlot ; $6680
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $6682
	jr z, .clearOwnSlot ; $6684
	ld a, [wCharSelectRemoteSlot] ; $6686
	ld hl, wCharSelectSlotDifficulty + 2 ; $6689
	add l ; $668c
	ld l, a ; $668d
	jr nc, .clearTaken ; $668e
	inc h ; $6690
.clearTaken:
	xor a ; $6691
	ld [hl], a ; $6692
	ld a, [wCharSelectRemoteSlot] ; $6693
	ld hl, wCharSelectSlotLeftHanded + 2 ; $6696
	add l ; $6699
	ld l, a ; $669a
	jr nc, .clearLeftHanded ; $669b
	inc h ; $669d
.clearLeftHanded:
	xor a ; $669e
	ld [hl], a ; $669f
	jr .retreatSlot ; $66a0
.clearOwnSlot:
	ld a, [wCharSelectRemoteSlot] ; $66a2
	ld hl, wCharSelectSlotDifficulty ; $66a5
	add l ; $66a8
	ld l, a ; $66a9
	jr nc, .clearOwnTaken ; $66aa
	inc h ; $66ac
.clearOwnTaken:
	xor a ; $66ad
	ld [hl], a ; $66ae
	ld a, [wCharSelectRemoteSlot] ; $66af
	ld hl, wCharSelectSlotLeftHanded ; $66b2
	add l ; $66b5
	ld l, a ; $66b6
	jr nc, .clearOwnLeftHanded ; $66b7
	inc h ; $66b9
.clearOwnLeftHanded:
	xor a ; $66ba
	ld [hl], a ; $66bb
.retreatSlot:
	call ClearRemoteSlotPortrait ; $66bc
	call BuildVisiblePageSpriteList ; $66bf
.refresh:
	ret ; $66c2
Unused_38_CopyRemoteCharsToSlots:
	ld a, [wCharSelectMode] ; $66c3
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $66c6
	jr z, .redraw ; $66c8
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $66ca
	jr z, .redraw ; $66cc
	ld a, [wCharSelectRemoteChars] ; $66ce
	ld [wCharSelectSlotChars + 2], a ; $66d1
	ld a, [wCharSelectRemoteChars + 1] ; $66d4
	ld [wCharSelectSlotChars + 3], a ; $66d7
	jr .done ; $66da
.redraw:
	ld a, [wCharSelectRemoteChars] ; $66dc
	ld [wCharSelectSlotChars], a ; $66df
	ld a, [wCharSelectRemoteChars + 1] ; $66e2
	ld [wCharSelectSlotChars + 1], a ; $66e5
.done:
	ret ; $66e8
CheckLinkSelectionComplete:
	push_wram_bank WRAM_SCREEN ; $66e9
	ld a, [wCharSelectSlot] ; $66f2
	cp $04 ; $66f5
	jr nz, .checkSlots ; $66f7
	ld a, [wCharSelectRemoteSlot] ; $66f9
	cp $02 ; $66fc
	jr nz, .checkSlots ; $66fe
	ld a, $01 ; $6700
	ld [wCharSelectExitCode], a ; $6702
.checkSlots:
	ld a, [wCharSelectSlot] ; $6705
	cp $ff ; $6708
	jr z, .allChosen ; $670a
	ld a, [wCharSelectRemoteSlot] ; $670c
	cp $ff ; $670f
	jr z, .allChosen ; $6711
	jr .done ; $6713
.allChosen:
	ld a, $02 ; $6715
	ld [wCharSelectExitCode], a ; $6717
.done:
	pop_wram_bank ; $671a
	ret ; $671f
HandleLinkGridButtons:
	ld a, [wMenuInputPressed] ; $6720
	and $f0 ; $6723
	ret nz ; $6725
	ld a, [wMenuInputPressed] ; $6726
	bit PADB_A, a ; $6729
	jr nz, .confirm ; $672b
	bit 1, a ; $672d
	jr nz, .cancel ; $672f
	bit 3, a ; $6731
	jr nz, .toggleHandedness ; $6733
	ret ; $6735
.confirm:
	call ConfirmLinkGridSelection ; $6736
	ret ; $6739
.cancel:
	call CancelLinkGridSelection ; $673a
	ret ; $673d
.toggleHandedness:
	call GetGridSlotFromCursor ; $673e
	ld b, a ; $6741
	ld hl, wCharGridEntries ; $6742
	add a ; $6745
	add a ; $6746
	add l ; $6747
	ld l, a ; $6748
	jr nc, .readCharId ; $6749
	inc h ; $674b
.readCharId:
	ld a, [hl] ; $674c
	ld c, a ; $674d
	call IsMarioCastCharacter ; $674e
	or a ; $6751
	jr z, .done ; $6752
	sound SFX_MENU_MOVE ; $6754
	ld a, [wCharGridHandedness] ; $6756
	cp $02 ; $6759
	jr z, .starChar ; $675b
	xor $01 ; $675d
	ld [wCharGridHandedness], a ; $675f
	call RefreshCharInfoPanel ; $6762
	ret ; $6765
.starChar:
	ld a, $01 ; $6766
	ld [wCharGridHandedness], a ; $6768
	call RefreshCharInfoPanel ; $676b
.done:
	ret ; $676e
ConfirmLinkGridSelection:
	push_wram_bank WRAM_SCREEN ; $676f
	ld a, [wCharSelectSlot] ; $6778
	cp $04 ; $677b
	jr z, .allSlotsFilled ; $677d
	ldh a, [hLinkRemoteInput] ; $677f
	cp $21 ; $6781
	jr nz, .readEntry ; $6783
	ld a, $22 ; $6785
	ldh [hLinkRemoteInput], a ; $6787
	jr .allSlotsFilled ; $6789
.readEntry:
	ld a, [wCharGridPage] ; $678b
	ld c, a ; $678e
	ld a, [wMenuCursorX] ; $678f
	ld d, a ; $6792
	ld a, [wMenuCursorY] ; $6793
	ld e, a ; $6796
	call TestAndSetGridEntryTaken ; $6797
	or a ; $679a
	jr nz, .allSlotsFilled ; $679b
	sound SFX_MENU_SELECT ; $679d
	call GetGridSlotFromCursor ; $679f
	ld b, a ; $67a2
	ld hl, wCharGridEntries ; $67a3
	add a ; $67a6
	add a ; $67a7
	add l ; $67a8
	ld l, a ; $67a9
	jr nc, .markLeftHanded ; $67aa
	inc h ; $67ac
.markLeftHanded:
	ld a, [hl] ; $67ad
	cp $ff ; $67ae
	jr z, .allSlotsFilled ; $67b0
	ld c, a ; $67b2
	call IsMarioCastCharacter ; $67b3
	or a ; $67b6
	jr z, .emptyCell ; $67b7
	ld a, [wCharGridHandedness] ; $67b9
	cp $01 ; $67bc
	jr nz, .emptyCell ; $67be
	ld a, [wCharSelectSlot] ; $67c0
	ld hl, wCharSelectSlotLeftHanded ; $67c3
	add l ; $67c6
	ld l, a ; $67c7
	jr nc, .drawPortrait ; $67c8
	inc h ; $67ca
.drawPortrait:
	ld a, $01 ; $67cb
	ld [hl], a ; $67cd
.emptyCell:
	ld a, [wCharSelectSlot] ; $67ce
	ld hl, wCharSelectSlotChars ; $67d1
	add l ; $67d4
	ld l, a ; $67d5
	jr nc, .advanceSlot ; $67d6
	inc h ; $67d8
.advanceSlot:
	ld [hl], b ; $67d9
	call DrawPlayerSlotPortrait ; $67da
	jr .refresh ; $67dd
.allSlotsFilled:
	sound SFX_MENU_CANCEL ; $67df
	pop_wram_bank ; $67e1
	ret ; $67e6
.refresh:
	call BuildVisiblePageSpriteList ; $67e7
	call AdvanceToNextPlayerSlot ; $67ea
	cp $04 ; $67ed
	jr nz, .drawSlotPrompt ; $67ef
.drawSlotPrompt:
	call DrawCharGridSlotPrompt ; $67f1
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $67f4
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $67f7
	ld c, 2 * TILEMAP_WIDTH / 16 ; $67fa
	call QueueVRAMCopy ; $67fc
	pop_wram_bank ; $67ff
	ret ; $6804
CancelLinkGridSelection:
	push_wram_bank WRAM_SCREEN ; $6805
	call RetreatToPreviousPlayerSlot ; $680e
	cp $ff ; $6811
	jr nz, .clearSlot ; $6813
	pop_wram_bank ; $6815
	ret ; $681a
.clearSlot:
	cp $fe ; $681b
	jr nz, .clearTaken ; $681d
	xor a ; $681f
	ld [wMenuCursorX], a ; $6820
	ld [wMenuCursorY], a ; $6823
	ld [wMenuCursor2X], a ; $6826
	ld [wMenuCursor2Y], a ; $6829
	ld [wCharGridPage], a ; $682c
	ldh [hLinkCursorPage], a ; $682f
	call RefreshCharInfoPanel ; $6831
.clearTaken:
	sound SFX_MENU_CANCEL ; $6834
	ld hl, wCharSelectSlotChars ; $6836
	ld a, [wCharSelectSlot] ; $6839
	add l ; $683c
	ld l, a ; $683d
	jr nc, .clearRecord ; $683e
	inc h ; $6840
.clearRecord:
	ld a, [hl] ; $6841
	ld b, $00 ; $6842
	ld [hl], b ; $6844
	ld hl, wCharGridEntries ; $6845
	add a ; $6848
	add a ; $6849
	add l ; $684a
	ld l, a ; $684b
	jr nc, .refresh ; $684c
	inc h ; $684e
.refresh:
	inc hl ; $684f
	inc hl ; $6850
	xor a ; $6851
	ld [hl], a ; $6852
	wram_bank WRAM_SCREEN ; $6853
	ld hl, wCharSelectSlotDifficulty ; $6859
	ld a, [wCharSelectSlot] ; $685c
	add l ; $685f
	ld l, a ; $6860
	jr nc, .redraw ; $6861
	inc h ; $6863
.redraw:
	xor a ; $6864
	ld [hl], a ; $6865
	ld hl, wCharSelectSlotLeftHanded ; $6866
	ld a, [wCharSelectSlot] ; $6869
	add l ; $686c
	ld l, a ; $686d
	jr nc, .done ; $686e
	inc h ; $6870
.done:
	xor a ; $6871
	ld [hl], a ; $6872
	call ClearPlayerSlotPortrait ; $6873
	call BuildVisiblePageSpriteList ; $6876
	call DrawCharGridSlotPrompt ; $6879
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $687c
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $687f
	ld c, 2 * TILEMAP_WIDTH / 16 ; $6882
	call QueueVRAMCopy ; $6884
	pop_wram_bank ; $6887
	ret ; $688c
DrawRemoteSlotPortrait:
	push_wram_bank WRAM_SCREEN ; $688d
	ld a, c ; $6896
	push bc ; $6897
	farcall GetCharPaletteIndex ; $6898
	pop bc ; $689b
	ld d, a ; $689c
	ld e, c ; $689d
	call GetRemoteSlotBoxAddress ; $689e
	ld h, d ; $68a1
	ld l, e ; $68a2
	ld d, b ; $68a3
	ld e, c ; $68a4
	ld b, l ; $68a5
	ld c, h ; $68a6
	call WriteCharPortraitTiles ; $68a7
	call DrawRemoteSlotLeftHandedMark ; $68aa
	ld a, [wCharSelectMode] ; $68ad
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $68b0
	jr z, .slot0 ; $68b2
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $68b4
	jr z, .slot0 ; $68b6
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $68b8
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $68bb
	ld c, 2 * TILEMAP_WIDTH / 16 ; $68be
	call QueueVRAMCopy ; $68c0
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $68c3
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $68c6
	ld c, 2 * TILEMAP_WIDTH / 16 ; $68c9
	call QueueVRAMCopy ; $68cb
	jr .done ; $68ce
.slot0:
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $68d0
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $68d3
	ld c, 2 * TILEMAP_WIDTH / 16 ; $68d6
	call QueueVRAMCopy ; $68d8
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $68db
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $68de
	ld c, 2 * TILEMAP_WIDTH / 16 ; $68e1
	call QueueVRAMCopy ; $68e3
.done:
	pop_wram_bank ; $68e6
	ret ; $68eb
DrawRemoteSlotLeftHandedMark:
	ld a, [wCharSelectMode] ; $68ec
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $68ef
	jr z, .checkOwnSlot ; $68f1
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $68f3
	jr z, .checkOwnSlot ; $68f5
	ld a, [wCharSelectRemoteSlot] ; $68f7
	ld hl, wCharSelectSlotLeftHanded + 2 ; $68fa
	add l ; $68fd
	ld l, a ; $68fe
	jr nc, .checkLeftHanded ; $68ff
	inc h ; $6901
.checkLeftHanded:
	ld a, [hl] ; $6902
	or a ; $6903
	ret z ; $6904
	jr .draw ; $6905
.checkOwnSlot:
	ld a, [wCharSelectRemoteSlot] ; $6907
	ld hl, wCharSelectSlotLeftHanded ; $690a
	add l ; $690d
	ld l, a ; $690e
	jr nc, .checkOwnLeftHanded ; $690f
	inc h ; $6911
.checkOwnLeftHanded:
	ld a, [hl] ; $6912
	or a ; $6913
	ret z ; $6914
.draw:
	call GetRemoteSlotBoxAddress ; $6915
	ld hl, $001f ; $6918
	add hl, bc ; $691b
	ld a, $32 ; $691c
	ld [hl], a ; $691e
	ret ; $691f
Unused_38_DrawRemoteDifficultyDigit:
	ld a, [wCharSelectMode] ; $6920
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $6923
	jr z, .queueVram ; $6925
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $6927
	jr z, .queueVram ; $6929
	ld a, [wCharSelectSlotDifficulty + 3] ; $692b
	ld c, $33 ; $692e
	add c ; $6930
	ld hl, $d14f ; $6931
	ld [hl], a ; $6934
	jr .done ; $6935
.queueVram:
	ld a, [wCharSelectSlotDifficulty + 1] ; $6937
	ld c, $33 ; $693a
	add c ; $693c
	ld hl, $d0ef ; $693d
	ld [hl], a ; $6940
.done:
	ret ; $6941
ClearRemoteSlotPortrait:
	call GetRemoteSlotBoxAddress ; $6942
	ld d, b ; $6945
	ld e, c ; $6946
	ld b, $02 ; $6947
	ld c, $02 ; $6949
	ld h, $00 ; $694b
	push de ; $694d
	farcall FillTilemapRect ; $694e
	pop de ; $6951
	ld b, $02 ; $6952
	ld c, $02 ; $6954
	ld hl, $0400 ; $6956
	add hl, de ; $6959
	ld d, h ; $695a
	ld e, l ; $695b
	ld h, $08 ; $695c
	farcall FillTilemapRect ; $695e
	call GetRemoteSlotBoxAddress ; $6961
	ld hl, $001e ; $6964
	add hl, bc ; $6967
	xor a ; $6968
	ld [hl+], a ; $6969
	ld [hl], a ; $696a
	ld a, [wCharSelectMode] ; $696b
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $696e
	jr z, .slot0 ; $6970
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $6972
	jr z, .slot0 ; $6974
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $6976
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $6979
	ld c, 2 * TILEMAP_WIDTH / 16 ; $697c
	call QueueVRAMCopy ; $697e
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $6981
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $6984
	ld c, 2 * TILEMAP_WIDTH / 16 ; $6987
	call QueueVRAMCopy ; $6989
	jr .done ; $698c
.slot0:
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $698e
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $6991
	ld c, 2 * TILEMAP_WIDTH / 16 ; $6994
	call QueueVRAMCopy ; $6996
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $6999
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $699c
	ld c, 2 * TILEMAP_WIDTH / 16 ; $699f
	call QueueVRAMCopy ; $69a1
.done:
	ret ; $69a4
GetRemoteSlotBoxAddress:
	ld a, [wCharSelectMode] ; $69a5
	add a ; $69a8
	ld hl, RemoteSlotBoxAddrPtrs_38 ; $69a9
	add l ; $69ac
	ld l, a ; $69ad
	jr nc, .readTable ; $69ae
	inc h ; $69b0
.readTable:
	ld a, [hl+] ; $69b1
	ld h, [hl] ; $69b2
	ld l, a ; $69b3
	ld a, [wCharSelectRemoteSlot] ; $69b4
	add a ; $69b7
	add l ; $69b8
	ld l, a ; $69b9
	jr nc, .read ; $69ba
	inc h ; $69bc
.read:
	ld a, [hl+] ; $69bd
	ld b, [hl] ; $69be
	ld c, a ; $69bf
	ret ; $69c0
; The remote-player twin of PlayerSlotBoxAddrPtrs_38: indexed in
; GetRemoteSlotBoxAddress, dereferenced, then indexed again by
; wCharSelectRemoteSlot * 2 to read one shadow-tilemap address. The
; targets are ram_ptrs tables exactly like PlayerSlotBoxAddrs0-5, with
; $0000 for slots that have no box.
RemoteSlotBoxAddrPtrs_38:
	; $69c1, 12 bytes (records:2)
	dw RemoteSlotBoxAddrs0 ; record 0
	dw RemoteSlotBoxAddrs0 ; record 1
	dw RemoteSlotBoxAddrs1 ; record 2
	dw RemoteSlotBoxAddrs0 ; record 3
	dw RemoteSlotBoxAddrs3 ; record 4
	dw RemoteSlotBoxAddrs2 ; record 5
RemoteSlotBoxAddrs0:
	; $69cd, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; record 0
	dw NO_BOX ; record 1
	dw NO_BOX ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
RemoteSlotBoxAddrs1:
	; $69d7, 6 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; record 0
	dw NO_BOX ; record 1
	dw NO_BOX ; record 2
RemoteSlotBoxAddrs2:
	; $69dd, 10 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 13 ; record 0
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 17 ; record 1
	dw NO_BOX ; record 2
	dw NO_BOX ; record 3
	dw NO_BOX ; record 4
RemoteSlotBoxAddrs3:
	; $69e7, 6 bytes (ram_ptrs:3:NO_BOX)
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 13 ; record 0
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 17 ; record 1
	dw NO_BOX ; record 2
AdvanceRemotePlayerSlot:
	ld a, [wCharSelectMode] ; $69ed
	ld hl, RemotePlayerSlotLists_38 ; $69f0
	add a ; $69f3
	add l ; $69f4
	ld l, a ; $69f5
	jr nc, .read ; $69f6
	inc h ; $69f8
.read:
	ld a, [hl+] ; $69f9
	ld h, [hl] ; $69fa
	ld l, a ; $69fb
	ld a, [wCharSelectRemoteSlot] ; $69fc
	ld b, a ; $69ff
.loop:
	ld a, [hl+] ; $6a00
	cp b ; $6a01
	jr nz, .loop ; $6a02
	ld a, [hl] ; $6a04
	ld [wCharSelectRemoteSlot], a ; $6a05
	ret ; $6a08
