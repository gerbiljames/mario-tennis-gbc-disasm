; The Archipelago ledger in SRAM bank 3 (ram/sram.asm). Every entry point
; leaves cart RAM disabled and the save engine's bank (hSramBank) selected,
; as the save engine does.

; Called at boot, after ValidateSaveRam. A missing or corrupt header (a new
; cart reads all zero) starts a fresh ledger; one from another seed erases
; the whole save first, as "erase all data" does. A corrupt game region is
; restored from its backup, or cleared if that is bad too; a corrupt client
; region is cleared, and the client resends every item.
ApBootLedger:
	call ApOpenLedger
	ld hl, sApHeader
	ld bc, sApHeaderChecksum - sApHeader
	call ApVerify
	jr nz, .newLedger
	ld hl, sApMagic
	ld de, ApLedgerMagic
	ld c, 4
	call ApCompare
	jr nz, .newLedger
	ld hl, sApAuth
	ld de, ApSlotAuth
	ld c, 16
	call ApCompare
	jr z, .checkGameRegion
	call ApCloseLedger
	ld a, BANK(ReinitSaveRamPreservingBlock6)
	ld hl, ReinitSaveRamPreservingBlock6
	call CallHLInBankA
	call ApOpenLedger
.newLedger:
	ld hl, sApHeader
	ld bc, sApClientRegionEnd - sApHeader
	call ApClear
	ld hl, ApLedgerMagic
	ld de, sApMagic
	ld bc, 4
	call CopyMemoryBC
	ld hl, ApSlotAuth
	ld de, sApAuth
	ld bc, 16
	call CopyMemoryBC
	ld hl, sApHeader
	ld bc, sApHeaderChecksum - sApHeader
	call ApSeal
	call ApCommitGameRegion
	jr .clearClientRegion

.checkGameRegion:
	ld hl, sApGameRegion
	ld bc, sApGameChecksum - sApGameRegion
	call ApVerify
	jr z, .commitGameRegion
	ld hl, sApGameBackup
	ld bc, sApGameChecksum - sApGameRegion
	call ApVerify
	jr nz, .clearGameRegion
	ld hl, sApGameBackup
	ld de, sApGameRegion
	ld bc, sApGameRegionEnd - sApGameRegion
	call CopyMemoryBC
	jr .checkClientRegion
.clearGameRegion:
	ld hl, sApGameRegion
	ld bc, sApGameRegionEnd - sApGameRegion
	call ApClear
.commitGameRegion:
	call ApCommitGameRegion
.checkClientRegion:
	ld hl, sApClientRegion
	ld bc, sApClientChecksum - sApClientRegion
	call ApVerify
	jr z, .done
.clearClientRegion:
	ld hl, sApClientRegion
	ld bc, sApClientRegionEnd - sApClientRegion
	call ApClear
	ld hl, sApClientRegion
	ld bc, sApClientChecksum - sApClientRegion
	call ApSeal
.done:
	jp ApCloseLedger

ApLedgerMagic:
	db "MTAP"

; e = location id: sets its done bit. a = 0 if it was set already, else 1.
ApSetLocationDone:
	call ApOpenLedger
	ld hl, sApDoneBits
	call ApLocationBit
	ld b, a
	and [hl]
	ld a, 0
	jr nz, .close
	ld a, b
	or [hl]
	ld [hl], a
	call ApCommitGameRegion
	ld a, 1
.close:
	jp ApCloseLedger

; e = item id -> a = how many the player has: the start inventory, the
; game's grants and the server's, capped at 255
ApItemCount:
	ld d, 0
	ld hl, ApStartInventory
	add hl, de
	ld b, [hl]
	call ApOpenLedger
	ld hl, sApGameItems
	add hl, de
	ld a, [hl]
	add b
	jr c, .capped
	ld b, a
	ld hl, sApClientItems
	add hl, de
	ld a, [hl]
	add b
	jr nc, .close
.capped:
	ld a, $ff
.close:
	jp ApCloseLedger

; e = item id: one more of it in the game region
ApGrantItem:
	call ApOpenLedger
	ld d, 0
	ld hl, sApGameItems
	add hl, de
	inc [hl]
	jr nz, .commit
	dec [hl]
.commit:
	call ApCommitGameRegion
	jp ApCloseLedger

ApOpenLedger:
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	ld a, BANK(sApHeader)
	ld [rRAMB], a
	ret

; preserves af
ApCloseLedger:
	push af
	ldh a, [hSramBank]
	ld [rRAMB], a
	xor a
	ld [rRAMG], a
	pop af
	ret

; Seals the game region and copies it to the backup. The ledger is open.
ApCommitGameRegion:
	ld hl, sApGameRegion
	ld bc, sApGameChecksum - sApGameRegion
	call ApSeal
	ld hl, sApGameRegion
	ld de, sApGameBackup
	ld bc, sApGameRegionEnd - sApGameRegion
	jp CopyMemoryBC

; hl = done-bit array, e = location id -> hl = its byte, a = its mask
ApLocationBit:
	ld a, e
	srl a
	srl a
	srl a
	add l
	ld l, a
	jr nc, .mask
	inc h
.mask:
	ld a, e
	and 7
	ld b, a
	ld a, 1
	inc b
.shift:
	dec b
	ret z
	add a
	jr .shift

; hl = start, bc = length -> de = the region's checksum, hl = start + length
ApChecksum:
	ld de, AP_CHECKSUM_SEED
.loop:
	ld a, [hl+]
	add e
	ld e, a
	jr nc, .next
	inc d
.next:
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

; hl = start, bc = length of a region whose checksum word follows it -> z if
; the checksum matches
ApVerify:
	call ApChecksum
	ld a, [hl+]
	cp e
	ret nz
	ld a, [hl]
	cp d
	ret

; hl = start, bc = length: writes the region's checksum word after it
ApSeal:
	call ApChecksum
	ld a, e
	ld [hl+], a
	ld [hl], d
	ret

; hl = start, bc = length (nonzero)
ApClear:
	xor a
	ld [hl+], a
	dec bc
	ld a, b
	or c
	jr nz, ApClear
	ret

; hl, de = the two strings, c = length -> z if they match
ApCompare:
	ld a, [de]
	cp [hl]
	ret nz
	inc de
	inc hl
	dec c
	jr nz, ApCompare
	ret
