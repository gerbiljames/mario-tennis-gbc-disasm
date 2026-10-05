; Items reaching a story slot, and the messages shown at the overworld's safe
; moment (ApStoryIdle).

; Applies to the loaded slot whatever it has not had applied yet: the
; equipment flags, and EXP bundles into the slot's pending story EXP
; (wPendingExpStory), awarded with the EXP screens when the player opens
; Char/Partner Data or next continues the slot. wApApplied counts what was
; applied.
ApCatchUpSlot:
	ld c, ITEM_LARGE_RACKET
.equipment:
	ld hl, wApApplied
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .nextEquipment
	push bc
	ld e, c
	call ApItemCount
	pop bc
	and a
	jr z, .nextEquipment
	ld hl, wApApplied
	ld b, 0
	add hl, bc
	ld [hl], 1
	ld a, c
	add FLAG_HAVE_LARGE_RACKET - ITEM_LARGE_RACKET
	ld e, a
	and 7
	swap a
	add a
	ld d, e
	srl d
	srl d
	srl d
	ld e, a
	push bc
	call SetGameFlag
	pop bc
.nextEquipment:
	inc c
	ld a, c
	cp ITEM_LIGHT_SHOES + 1
	jr c, .equipment

.exp:
	ld e, ITEM_EXP_BUNDLE
	call ApItemCount
	ld hl, wApApplied + ITEM_EXP_BUNDLE
	cp [hl]
	ret z
	ret c
	inc [hl]
	ld hl, wPendingExpStory
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld de, AP_EXP_BUNDLE
	add hl, de
	jr nc, .store
	ld hl, $ffff
.store:
	ld a, l
	ld [wPendingExpStory], a
	ld a, h
	ld [wPendingExpStory + 1], a
	jr .exp

; -> a = 1 with wApMessage composed if a message is waiting, else 0. A done
; location's message comes first, then the client's received items (only the
; last AP_RECENT_ITEMS are kept).
ApNextMessage:
	ld a, [ApOptHideMessages]
	and a
	ld a, 0
	ret nz
	call ApOpenLedger
	ld hl, sApDoneBits
	ld e, 0
.location:
	ld a, [hl]
	push hl
	ld bc, sApMessagedBits - sApDoneBits
	add hl, bc
	ld b, a
	ld a, [hl]
	cpl
	and b
	jr nz, .unmessaged
	pop hl
	inc hl
	ld a, e
	add 8
	ld e, a
	cp AP_LOCATION_BYTES * 8
	jr c, .location
	jr .client
; a = this byte's done bits not yet messaged, hl = its messaged byte, e = the
; location id of its bit 0
.unmessaged:
	pop bc
	ld b, a
	ld c, 1
.bit:
	ld a, b
	and c
	jr nz, .mark
	sla c
	inc e
	jr .bit
.mark:
	ld a, [hl]
	or c
	ld [hl], a
	push de
	call ApCommitGameRegion
	call ApCloseLedger
	pop de
	jp ApComposeLocationMessage

.client:
	ld hl, sApReceivedCount
	ld a, [hl+]
	ld c, a
	ld b, [hl]
	ld hl, sApClientShown
	ld a, [hl+]
	ld e, a
	ld d, [hl]
	; bc - de: how many are waiting
	ld a, c
	sub e
	ld l, a
	ld a, b
	sbc d
	ld h, a
	jr c, .none
	or l
	jr z, .none
	ld a, h
	and a
	jr nz, .skipOld
	ld a, l
	cp AP_RECENT_ITEMS + 1
	jr c, .show
.skipOld:
	ld a, c
	sub AP_RECENT_ITEMS
	ld e, a
	ld a, b
	sbc 0
	ld d, a
.show:
	ld a, e
	and AP_RECENT_ITEMS - 1
	inc de
	ld hl, sApClientShown
	ld [hl], e
	inc hl
	ld [hl], d
	push af
	call ApCommitGameRegion
	pop af
	ld hl, sApRecentItems
	ld de, AP_RECENT_ITEM_SIZE
	and a
.entry:
	jr z, .gotEntry
	add hl, de
	dec a
	jr .entry
.gotEntry:
	ld de, wApMessage
	push hl
	ld hl, ApTextYouGot
	call ApCopyString
	pop hl
	ld a, [hl+]
	push hl
	call ApCopyItemName
	pop hl
	ld a, [hl]
	and a
	jr z, .noSender
	ld a, AP_TEXT_LINE
	ld [de], a
	inc de
	push hl
	ld hl, ApTextFrom
	call ApCopyString
	pop hl
	call ApCopyName
.noSender:
	call ApCloseLedger
	jr ApEndMessage

.none:
	call ApCloseLedger
	xor a
	ret

; e = a done location: "You got <item>!" for this world's item, "You sent
; <item> to <player>!" for another's (nothing when the patch left the player
; blank: an item this world receives back from the server)
ApComposeLocationMessage:
	ld d, 0
	ld hl, ApPlacements
	add hl, de
	ld a, [hl]
	and a
	jr z, .remote
	ld de, wApMessage
	push af
	ld hl, ApTextYouGot
	call ApCopyString
	pop af
	call ApCopyItemName
	jr ApEndMessage
.remote:
	ld hl, ApLocationNames
	ld bc, AP_LOCATION_NAMES_SIZE
	ld a, e
	and a
.find:
	jr z, .found
	add hl, bc
	dec a
	jr .find
.found:
	ld bc, AP_NAME_LENGTH + 1
	push hl
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .silent
	ld de, wApMessage
	push hl
	ld hl, ApTextYouSent
	call ApCopyString
	pop hl
	push hl
	call ApCopyName
	ld a, AP_TEXT_LINE
	ld [de], a
	inc de
	ld hl, ApTextTo
	call ApCopyString
	pop hl
	ld bc, AP_NAME_LENGTH + 1
	add hl, bc
	call ApCopyName
	jr ApEndMessage
.silent:
	xor a
	ret

; de = the end of the message so far: "!", then the wait for a button
ApEndMessage:
	ld hl, ApTextEnd
	call ApCopyString
	xor a
	ld [de], a
	inc a
	ret

; a = item id: its in-game name at de
ApCopyItemName:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc
	ld bc, ApItemNames
	add hl, bc
	; fall through
; hl -> de: a name, up to its NUL or AP_NAME_LENGTH characters
ApCopyName:
	ld c, AP_NAME_LENGTH
.loop:
	ld a, [hl+]
	and a
	ret z
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

; hl -> de, up to its NUL (not copied)
ApCopyString:
	ld a, [hl+]
	and a
	ret z
	ld [de], a
	inc de
	jr ApCopyString

ApTextYouGot:
	db "You got", AP_TEXT_LINE, 0
ApTextYouSent:
	db "You sent", AP_TEXT_LINE, 0
ApTextFrom:
	db "from ", 0
ApTextTo:
	db "to ", 0
ApTextEnd:
	db "!", AP_TEXT_DONE, 0

; per item id, its name in game messages (AP_ITEM_NAME_SIZE bytes each,
; NUL-padded)
ApItemNames:
	ds AP_ITEM_NAME_SIZE, 0
FOR I, 1, AP_NUM_ITEMS
	db "{AP_ITEM_TEXT_{d:I}}"
	ds AP_ITEM_NAME_SIZE - STRLEN("{AP_ITEM_TEXT_{d:I}}"), 0
ENDR
