; SRAM layout: the battery save (docs/save_format.md).

SECTION "SRAM bank 0", SRAM[$a000], BANK[0]

; [2048 bytes] The header region, $a000-$a7ff, copied by MirrorSaveHeaderToBank1
; and ValidateSaveRam in four SAVE_HEADER_CHUNKs: 32 unused bytes, the fields
; below, and 144 bytes past the end of the block directory.
sSaveHeader::
	ds 32

; Header fields, owned by the bank $03 save engine
; [16 bytes] "CAMELOTGBTENNIS\0" signature (ROM copy at SaveSignature)
sSaveSignature:: ds 16
; [16-bit LE] byte-sum of $a038-$a76f (version byte + block directory)
sSaveMasterChecksum:: dw
	ds 6
; [8-bit] save layout version byte, always $71; first byte covered by the master checksum
sSaveFormatVersion:: db
	ds 6

	ds 1

; Global save-flag array, owned by the bank $03 save engine. $a0xx literals
; in other banks (VRAM-bank-1 copy destinations) are not these fields
; [8 bytes] The 64 global save flags. Test/Set/ClearSaveFlag take d = byte, e = bit << 5 and mask $80 >> bit; flag number = byte * 8 + bit, and SAVEFLAG_* (include/constants/) hold the (byte << 8 | bit << 5) id. Bytes $00-$03: character-unlock bits, one per character id (CheckCharacterUnlocked; ids 0-3 always unlocked). Byte $01 also holds #9 opening-seen, #10-#13 (Fay, Curt, Mark, Sean) from N64 transfer records and #14/#15 (Sammi, Elden) from the singles/doubles Dream Match. Bytes $02/$03 double as minigame-clear flags #20-#31 (Boo Blast through Target Shot): clearing one unlocks a character because it is the same bit. Byte $04 is per-story-slot (SetStorySlotFlagA #32-#34, SetStorySlotFlagB #36-#38; EraseStorySlotSaveData clears the slot's pair). Bytes $05/$06: minigame clears #40-#54 (Fruit Fantasy through Two-On-One; MinigameClearFlagTable_1e lists all 27). Byte $07: court unlocks (#57 Star, #58 Castle, #59 Tropics, #60 Jungle, #61 Warehouse), #62 N64 records present, #63 bank $01 debug-menu toggle.
sSaveFlags:: ds 8
; [24 bytes] Flags #64-#255: dead storage. Unused_03_ClearSaveFlagsArea zeroes all 32 bytes of the array, but no flag above byte $07 is ever set or tested.
sSaveFlagsUnused:: ds 24

; Save block directory (docs/save_format.md), owned by the bank $03 save engine
; [113 x 16 bytes] block directory; +0 valid, +1 SRAM bank, +2 offset word, +4 length word, +6 checksum word, +8 tag (hi,lo)
sSaveBlockDirectory:: ds 1808

INCLUDE "constants/archipelago.inc"

; The Archipelago ledger (docs/archipelago.md): global, not tied to a story
; slot. WipeAllSaveRam stops below bank 3, so vanilla erases leave it alone;
; ApBootLedger validates it instead. Each region has one writer and its own
; checksum (ApChecksum: the byte sum plus AP_CHECKSUM_SEED, so an all-zero
; region is invalid).
SECTION "SRAM bank 3", SRAM[$a000], BANK[3]

sApHeader::
; "MTAP"
sApMagic:: ds 4
; a copy of ApSlotAuth: a ledger from another seed erases the whole save
sApAuth:: ds 16
sApHeaderChecksum:: dw
sApHeaderEnd::

; Written by the game, then copied whole to sApGameBackup.
sApGameRegion::
; one bit per location id, bit (id & 7) of byte id / 8
sApDoneBits:: ds AP_LOCATION_BYTES
; the done locations whose "Got X"/"Sent X to Y" message has been shown
sApMessagedBits:: ds AP_LOCATION_BYTES
; nonzero once the goal holds
sApGoal:: db
; how many of the client's items have had their message shown
sApClientShown:: dw
; a count per item id, granted by the game's own checks
sApGameItems:: ds AP_ITEM_SLOTS
sApGameChecksum:: dw
sApGameRegionEnd::

sApGameBackup:: ds sApGameRegionEnd - sApGameRegion

; Written by the client only.
sApClientRegion::
; how many items the server has sent that are counted below
sApReceivedCount:: dw
; a count per item id, from the server
sApClientItems:: ds AP_ITEM_SLOTS
; the last AP_RECENT_ITEMS received, item n at entry n % AP_RECENT_ITEMS:
; the item id, then the sender's name (AP_NAME_LENGTH characters at most,
; NUL-terminated)
sApRecentItems:: ds AP_RECENT_ITEMS * AP_RECENT_ITEM_SIZE
sApClientChecksum:: dw
sApClientRegionEnd::
