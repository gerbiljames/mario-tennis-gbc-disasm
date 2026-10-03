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
def SAVEDIR_ENTRY_SIZE  equ 16
def SAVEDIR_VALID       equ 0 ; 1 = in use
def SAVEDIR_BANK        equ 1 ; SRAM bank of the data
def SAVEDIR_OFFSET      equ 2 ; word, from SRAM_BASE
def SAVEDIR_LENGTH      equ 4 ; word
def SAVEDIR_CHECKSUM    equ 6 ; word, byte-sum of the data
def SAVEDIR_TAG         equ 8 ; word, high byte first
; Block ids (WriteSaveBlock/ReadSaveBlock and friends take one in b). The
; bank-1 backup of block n (n <= $0a) is n + SAVEBLOCK_BACKUP.
def SAVEBLOCK_SLOT0             equ $00 ; story slot primary: image of $c800-$caff
def SAVEBLOCK_SLOT0_EXTRA       equ $01 ; story slot secondary block
def SAVEBLOCK_SLOT1             equ $02
def SAVEBLOCK_SLOT1_EXTRA       equ $03
def SAVEBLOCK_SLOT2             equ $04
def SAVEBLOCK_SLOT2_EXTRA       equ $05
def SAVEBLOCK_PRESERVED         equ $06 ; kept across a full save wipe
def SAVEBLOCK_SPARE7            equ $07 ; $07-$0a: small records only unreachable code touches
def SAVEBLOCK_SPARE8            equ $08
def SAVEBLOCK_SPARE9            equ $09
def SAVEBLOCK_SPARE10           equ $0a
def SAVEBLOCK_N64_RECORDS       equ $0b ; Transfer Pak records and the unlock flags
def SAVEBLOCK_BACKUP            equ $1b
def SAVEBLOCK_EXHIBITION        equ $36 ; save-and-quit resume image of wStorySlotData
def SAVEBLOCK_EXHIBITION_BACKUP equ $37
def SAVEBLOCK_MINIGAME_RECORDS  equ $38 ; + story slot; backups at + 3
def SAVEBLOCK_STAR_GRID         equ $3e ; star-character exhibition victory grid

; One VRAM bank: the three tile blocks and both maps.
def VRAM_SIZE equ $2000

; --- Character records ---
; A character is a $40-byte record: the story pair at $c900/$c940 (main,
; partner), their saved-slot mirror at $c800/$c840, and the four match
; records at $ca00-$caff. The pairs are copied together, two records at once.
def CHAR_RECORD_SIZE equ $40

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
; reads as a place: `vTiles0 + $10 * TILE_SIZE` is tile $10 of the sprite
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
def WRAM_STAGING      equ 1 ; VRAM staging: wDecompBuffer, which every screen decompresses into
def WRAM_COURT_PLANES equ 2 ; the court's tile and attribute planes; the overworld scroll buffer's attribute half; the char-data screen's attribute pages
def WRAM_SCREEN       equ 3 ; wShadowTilemap, the full-screen UIs' tile plane; the scroll buffer's tile half; the char-data screen's tile pages
def WRAM_ACTORS       equ 4 ; overworld actors and the actor engine; minigame targets
def WRAM_TEXT         equ 5 ; the text and window engine and wWindowShadowTilemap
def WRAM_SCENE        equ 6 ; the story scene's collision and behaviour maps, scene loading, and the per-screen scratch overlays
def WRAM_SOUND        equ 7 ; the sound driver; glyph tiles and save-block staging
def WRAM_CHAR0        equ 4 ; on-court character 0's struct (wCharIndex 0)
def WRAM_CHAR1        equ 5
def WRAM_CHAR2        equ 6
def WRAM_CHAR3        equ 7

; --- Background tile attribute (wWindowTileAttr) ---
; A CGB background attribute byte, stamped into the attribute plane of a text
; window's rect by DrawTextWindowFrame and read for its bank bit by both glyph
; uploaders (`bit 3, a` then +$2000 on the VRAM destination). Same layout as
; hardware.inc's BG_PRIO/BG_PALETTE.
def TILEATTR_PAL1            equ $01 ; BG palette 1
def TILEATTR_PRIORITY        equ $80 ; BG colours 1-3 draw above sprites
