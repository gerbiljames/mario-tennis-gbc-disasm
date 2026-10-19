; --- WRAM layout ---
; The switchable bank at $d000-$dfff. SoftReset and InitAndRunGame clear
; whole banks from here, and SoftReset parks the stack at its lower edge,
; growing down into WRAM0.
def WRAMX_BASE equ $d000
def WRAMX_SIZE equ $1000
def WRAMX_END  equ WRAMX_BASE + WRAMX_SIZE
def STACK_TOP equ $d000

; --- Battery save (docs/save_format.md) ---
; SRAM bank 0 opens with the 2 KiB header: signature, master checksum, flags
; and the 113-entry block directory. MirrorSaveHeaderToBank1 copies it to
; bank 1 in four chunks staged through wTextBuffer. A directory entry's
; offset field counts from SRAM_BASE in the entry's own SRAM bank.
def SRAM_BASE           equ $a000
def SRAM_BANK_SIZE      equ $2000
def SAVE_HEADER_CHUNK   equ $200
def SAVE_HEADER_SIZE    equ 4 * SAVE_HEADER_CHUNK
def SAVEDIR_ENTRY_SIZE  equ 16
	const_def
	const SAVEDIR_VALID  ; $00 1 = in use
	const SAVEDIR_BANK   ; $01 SRAM bank of the data
	const SAVEDIR_OFFSET ; $02 word, from SRAM_BASE
def SAVEDIR_LENGTH      equ 4 ; word
def SAVEDIR_CHECKSUM    equ 6 ; word, byte-sum of the data
def SAVEDIR_TAG         equ 8 ; word, high byte first
; Block ids (WriteSaveBlock/ReadSaveBlock and friends take one in b). The
; bank-1 backup of block n (n <= $0a) is n + SAVEBLOCK_BACKUP.
	const_def
	const SAVEBLOCK_SLOT0       ; $00 story slot primary: image of $c800-$caff
	const SAVEBLOCK_SLOT0_EXTRA ; $01 story slot secondary block
	const SAVEBLOCK_SLOT1       ; $02
	const SAVEBLOCK_SLOT1_EXTRA ; $03
	const SAVEBLOCK_SLOT2       ; $04
	const SAVEBLOCK_SLOT2_EXTRA ; $05
	const SAVEBLOCK_PRESERVED   ; $06 kept across a full save wipe
	const SAVEBLOCK_SPARE7      ; $07 $07-$0a: small records only unreachable code touches
	const SAVEBLOCK_SPARE8      ; $08
	const SAVEBLOCK_SPARE9      ; $09
	const SAVEBLOCK_SPARE10     ; $0a
	const SAVEBLOCK_N64_RECORDS ; $0b Transfer Pak records and the unlock flags
def SAVEBLOCK_BACKUP            equ $1b
	const_def $36
	const SAVEBLOCK_EXHIBITION        ; $36 save-and-quit resume image of wStorySlotData
	const SAVEBLOCK_EXHIBITION_BACKUP ; $37
	const SAVEBLOCK_MINIGAME_RECORDS  ; $38 + story slot; backups at + 3
def SAVEBLOCK_STAR_GRID         equ $3e ; star-character exhibition victory grid
; Blocks InitSaveHeader defines but no code writes, as runs filling the rest
; of each SRAM bank. Banks 3-14 are not on the 32 KiB cart.
def SAVEBLOCK_UNUSED_BANK0      equ $0c ; $0c-$1a
def SAVEBLOCK_UNUSED_BANK1      equ $26 ; $26-$35
def SAVEBLOCK_UNUSED_BANK2      equ $3f ; $3f-$49
def SAVEBLOCK_UNUSED_BANK3      equ $4a ; $4a-$57
def SAVEBLOCK_UNUSED_BANK4      equ $58 ; $58-$61
def SAVEBLOCK_UNUSED_BANK5      equ $62 ; $62-$67
def SAVEBLOCK_UNUSED_BANK6      equ $68 ; $68-$70, one whole-bank block each for banks 6-14
def NUM_SAVEBLOCKS              equ $71

; One VRAM bank: the three tile blocks and both maps.
def VRAM_SIZE equ $2000

; --- Match statistics (match_stats in ram/wram/wram0_records.asm) ---
def MATCH_STATS_STRIDE equ 8 ; wCharacter1ServiceAces + character index * 8

; --- VRAM bank in a copy destination ---
; QueueVRAMCopy takes its destination in de and carries the VRAM bank in bit 13
; of it: `bit 5, d` selects rVBK, and `res 5, d` recovers the real address. So
; `$9800 + VRAM_BANK1` ($b800) means $9800 in VRAM bank 1.
def VRAM_BANK1 equ $2000

; --- $4000 slot tables ---
; Every banked FarPtr_/DataPtr_ table sits at the start of its bank, and a
; (slot, bank) pair stores only the slot label's low byte: the trampolines
; rebuild the address as SLOT_TABLE_PAGE:slot.
def SLOT_TABLE_PAGE equ HIGH($4000)

; --- VRAM regions ---
; The three 128-tile blocks and the two background maps, so a copy destination
; reads as a place: `vTiles0 tile $10` is tile $10 of the sprite
; block, `vBGMap0 + 15 * TILEMAP_WIDTH + 4` is map cell (4, 15). The BG uses
; $8800 addressing (ids $80-$ff in vTiles1, $00-$7f in vTiles2); objects use
; $8000 addressing (ids $00-$7f in vTiles0, $80-$ff in vTiles1).
def vTiles0 equ $8000
def vTiles1 equ $8800
def vTiles2 equ $9000
def vBGMap0 equ $9800
def vBGMap1 equ $9c00

; --- Absent cell in a table of tilemap addresses ---
; The character-select PlayerSlotBoxAddrs* tables hold one shadow-tilemap cell
; per player slot, and a layout that does not show a slot stores zero for it.
; Nothing checks the fetched address: the code relies on never selecting it.
def NO_BOX equ $0000

; --- WRAM banks (wram_bank / push_wram_bank; the "at a glance" notes in ram/wram/) ---
; Banks 1-3 and 5-7 each have one main owner; 4-7 also hold the four
; on-court character structs at $df00, one per wCharIndex, which the match
; engine selects with WRAM_CHARn. Same numbers, different use.
	const_def $01
	const WRAM_STAGING      ; $01 VRAM staging: wDecompBuffer, which every screen decompresses into
	const WRAM_COURT_PLANES ; $02 the court's tile and attribute planes; the overworld scroll buffer's attribute half; the char-data screen's attribute pages
	const WRAM_SCREEN       ; $03 wShadowTilemap, the full-screen UIs' tile plane; the scroll buffer's tile half; the char-data screen's tile pages
	const WRAM_ACTORS       ; $04 overworld actors and the actor engine; minigame targets
	const WRAM_TEXT         ; $05 the text and window engine and wWindowShadowTilemap
	const WRAM_SCENE        ; $06 the story scene's collision and behaviour maps, scene loading, and the per-screen scratch overlays
	const WRAM_SOUND        ; $07 the sound driver; glyph tiles and save-block staging
	const_def $04
	const WRAM_CHAR0 ; $04 on-court character 0's struct (wCharIndex 0)
	const WRAM_CHAR1 ; $05
	const WRAM_CHAR2 ; $06
	const WRAM_CHAR3 ; $07

; --- Background tile attribute (wWindowTileAttr) ---
; A CGB background attribute byte, stamped into the attribute plane of a text
; window's rect by DrawTextWindowFrame and read for its bank bit by both glyph
; uploaders (`bit 3, a` then +$2000 on the VRAM destination). Same layout as
; hardware.inc's BG_PRIO/BG_PALETTE.
def TILEATTR_PAL1            equ $01 ; BG palette 1
def TILEATTR_PRIORITY        equ $80 ; BG colours 1-3 draw above sprites
