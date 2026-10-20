SECTION "WRAMX bank 2", WRAMX[$d000], BANK[2]

; WRAMX bank 2 at a glance:
;
;   $d000-$d3ff  wActiveTilemap  [mirrored with bank 5]
;   $d000-$d41f  wCharDataScreenCell  [mirrored with bank 3]
;   $d000-$dfff  5 overlays: N64 block presence probe / match court planes / overworld scroll buffers / +2 more
;   $d000-$dfff  wMapBuffer64  [mirrored with bank 3]
;   $d400-$d7df  wCharDataPagePlane  [mirrored with bank 3]
;   $d400-$d7ff  wActiveAttrmap  [mirrored with bank 5]
;   $d430-$d66f  wCharDataScreenBackup  [mirrored with bank 3]
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 3, 4]
;   $d7e0-$da1f  wCharDataPageSlot1  [mirrored with bank 3]
;   $da20-$dc5f  wCharDataPageSlot2  [mirrored with bank 3]
;   $dc60-$de9f  wCharDataPageSlot3  [mirrored with bank 3]

; WRAM bank $02 holds tilemap planes, used three ways: the match keeps the
; court tilemap and attrmap here as a pair, the overworld builds two of its
; four wide scroll planes here, and every full-screen UI uses $d000 as the
; attribute half of the tilemap whose tile half is wShadowTilemap in WRAM
; bank $03. Bank $08 reaches both this bank and WRAM bank $04
; (RefreshCourtScoreboard's $de9x bytes are not court planes).
; Bank $06's in-match UI (ShowMessageWindow, the pause menu) selects this
; bank and calls RestoreBgTilemap / RestoreBgTilemapRegion /
; FlushTilemapToVram, so there $d000 is the tile half sent to VRAM bank 0.
; Bank $0a's LoadCourtSceneGraphics decompresses the court into the saved
; pair at $d800/$dc00 before the match. Bank $0d's LoadMatchUiCourtTilemap
; writes all four planes: the target-zone overlay's tile and attribute
; halves go to $d12b, $d92b, $d52b and $dd2b; QueueMinigameHudVRAMCopy sends
; $d120 to $9920 and $d520 to $9920 + VRAM_BANK1.
UNION
; N64 block presence probe (bank $3b)
; [2 bytes] First two bytes of save block $0b, staged here for CheckN64DataPresent; nonzero means Transfer Pak records exist, which unlocks the N64 entries on the status menu
wN64BlockProbe:: dw
	ds 4094
NEXTU
; match court planes (banks $08/$0d/$06/$0a)
; [1024 bytes] The match's court tilemap; UploadCourtTilemap sends it to $9800 in VRAM bank 0. Kept in WRAM bank $02 because the match uses bank $03 for other things
wCourtTilemap:: ds 1024
	export_size wCourtTilemap
; [1024 bytes] Its CGB attribute plane, cell for cell, uploaded to $9800 in VRAM bank 1 by UploadCourtAttrmap
wCourtAttrmap:: ds 1024
	export_size wCourtAttrmap
; [1024 bytes] The court's base tilemap, decompressed by LoadCourtSceneGraphics and patched by the scoreboard and minigame-target code; ResetCourtTilemapsFromBase and RestoreBgTilemap copy it over wCourtTilemap
wCourtTilemapBase:: ds 1024
; [1024 bytes] The attribute half of the base planes
wCourtAttrmapBase:: ds 1024
NEXTU
; overworld scroll buffers (bank 0)
; [1024 bytes] One of the four 64-wide planes Unused_00_CopyMapToScrollBuffers expands the map into, 16 rows of 64 cells, from wDecompBuffer (WRAM bank $01) via wTextBuffer a row block at a time
wMapScrollPlane0:: ds 1024
	ds 1024
; [1024 bytes] The second plane, built the same way and then cleared (2048 bytes, twice what was written). wScreenScratch in WRAM bank $03 gets the same treatment, so two of the four planes are built and discarded
wMapScrollPlane1:: ds 1024
NEXTU
; screen attribute plane
; [1024 bytes] CGB attributes for the full-screen UIs, cell for cell with wShadowTilemap in WRAM bank $03; FlushCharDataTilemapChunk sends the pair to $99e0 in VRAM banks 0 and 1. The character-data page images above it are the ram_mirrored.inc EQUs wCharDataPagePlane and wCharDataPageSlot1-3. Plane writers such as FillTilemapRun, WriteTextToTilemap and RenderProportionalTextAt select both banks themselves (tile under $03, attribute under $02)
UNION
wScreenAttrmap:: ds 1024
	export_size wScreenAttrmap
NEXTU
; minigame level select (bank $1b): scalars in the plane's first bytes
; [8-bit] Minigame whose levels are offered, from c of RunMinigameLevelSelect; indexes ClearedMinigameLevelsTable
wLevelSelectMinigame:: db
; [8-bit] Levels cleared (0-2): CountClearedMinigameLevels counts the minigame's level-1 and level-2 clear flags. 2 runs RunMinigameLevelSelect3, else RunMinigameLevelSelect2; it is also the starting cursor, and 0 locks every level but the first and swaps the icon tiles
wLevelSelectClearedCount:: db
; [8-bit] Cursor grid columns, CountClearedMinigameLevelsTable[wLevelSelectClearedCount]; returned in b by GetMinigameLevelColumnCount
wLevelSelectColumns:: db
; [8-bit] The chosen cursor index, or $ff on cancel; RunMinigameLevelSelect returns it in a
wLevelSelectResult:: db
NEXTU
; name entry (bank $38): scalars in the plane's first bytes
; [8-bit] Charset page: SetupNameEntryScreen writes 0 and AppendCharToName tests it, but both branches index NameEntryCharset_38
wNameEntryCharsetPage:: db
; [8-bit] Character whose mugshot the screen shows, from c of RunNameEntryScreen
wNameEntryMugshotChar:: db
ENDU
NEXTU
; character record scratch (banks $18/$1b/$3b)
	ds 1408
; [128 bytes] The character record a menu is about to draw: LoadCharacterRecordToBuffer has LoadPlayer2MainRecord build it and copies the main and partner records here from wPlayer2MainName. wCharRecordScratchChar is the character id, tested against $ff by CheckCharacterUnlocked and used as the index by the mugshot and portrait loaders; the `.fixedRecord` shortcut writes $3e into it directly.
; The bank is never selected at the reference; bank $3b's BuildSaveSlotSummaries selects WRAM bank $02 around the call, and reads must use the bank the write went to.
	char_record wCharRecordScratch
	char_record wCharRecordScratchPartner
	export_size wCharRecordScratch
ENDU
