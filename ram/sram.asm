; SRAM layout: the battery save (docs/save_format.md). Hand-maintained.

SECTION "SRAM bank 0", SRAM[$a000], BANK[0]

; SRAM bank 0 at a glance:
;
;   $a020-$a03e  save engine
;   $a040-$a05f  save engine
;   $a060-$a76e  save engine

; [2048 bytes] The header region, $a000-$a7ff, as MirrorSaveHeaderToBank1 and
; ValidateSaveRam copy it in four SAVE_HEADER_CHUNKs: the 32 unused bytes here,
; the fields below, and 144 bytes past the end of the block directory.
sSaveHeader::
	ds 32

; Battery-save header fields (SRAM bank 0), owned by the bank $03 save
; engine; scoped so unrelated $a0xx literals in other banks stay numeric
; save engine (bank $03)
; [16 bytes] "CAMELOTGBTENNIS\0" signature (ROM copy at SaveSignature, 03:47e9)
sSaveSignature:: ds 16
; [16-bit LE] byte-sum of $a038-$a76f (version byte + block directory)
sSaveMasterChecksum:: dw
	ds 6
; [8-bit] save layout version byte, always $71; first byte covered by the master checksum
sSaveFormatVersion:: db
	ds 6

	ds 1

; Global save-flag array (SRAM bank 0), owned by the bank $03 save
; engine; scoped so unrelated $a0xx literals in other banks (VRAM-bank-1
; copy destinations) stay numeric
; save engine (bank $03)
; [8 bytes] The 64 global save flags the game actually uses. Test/Set/ClearSaveFlag ($03:$4d8f/$4dbd/$4deb) index this base with d (byte) and mask $80 >> bit, where e = bit << 5; flag number = byte * 8 + bit, and the SAVEFLAG_* constants in constants.inc hold the (byte << 8 | bit << 5) id each call site passes. Layout: bytes $00-$03 are the character-unlock bits, one per character id (CheckCharacterUnlocked $18:$452a tests flag number = char id; ids 0-3 are always unlocked). Byte $01 also carries #9 opening-seen and the unlocks granted by outside events - #10-#13 (Fay, Curt, Mark, Sean) from N64 transfer records, #14/#15 (Sammi, Elden) from the singles/doubles Dream Match. Bytes $02/$03 double as the first twelve minigame-clear flags (#20-#31, Boo Blast through Target Shot), which is why clearing a minigame level unlocks a character: it is the same bit. Byte $04 is per-story-slot (SetStorySlotFlagA #32-#34, SetStorySlotFlagB #36-#38; EraseStorySlotSaveData clears the pair for the erased slot). Bytes $05/$06 continue the minigame-clear run (#40-#54, Fruit Fantasy through Two-On-One; MinigameClearFlagTable_1e lists all 27 in order). Byte $07 is court unlocks (#57 Star, #58 Castle, #59 Tropics, #60 Jungle, #61 Warehouse) plus #62 'N64 records present' and #63, the bank $01 debug-menu toggle. The RetroAchievements Code Notes for $a042/$a043/$a045/$a046/$a047 describe the same bits with their own bit numbering (their 'Bit N' is mask 1 << N, i.e. this engine's bit 7 - N); those names now live on the SAVEFLAG_* constants.
sSaveFlags:: ds 8
; [24 bytes] Flags #64-#255. Unused_03_ClearSaveFlagsArea ($03:$4825) zeroes all 32 bytes of the array, but nothing ever sets or tests a flag with a byte index above $07: every immediate id in the ROM is $01xx-$07xx, the computed callers are bounded (character ids stop at $1f, MinigameClearFlagTable_1e stops at #54, UnlockConditionFlagRows_03 at #54), so this half is dead storage.
sSaveFlagsUnused:: ds 24

; Save block directory: 113 16-byte entries (see docs/save_format.md);
; entry = valid, SRAM bank, offset, length, checksum, tag
; save engine (bank $03)
; [113 x 16 bytes] block directory; +0 valid, +1 SRAM bank, +2 offset word, +4 length word, +6 checksum word, +8 tag (hi,lo)
sSaveBlockDirectory:: ds 1808
