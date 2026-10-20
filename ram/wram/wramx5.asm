SECTION "WRAMX bank 5", WRAMX[$d000], BANK[5]

; WRAMX bank 5 at a glance:
;
;   $d000-$d3ff  wActiveTilemap  [mirrored with bank 2]
;   $d000-$d7ff  window shadow tilemap
;   $d400-$d7ff  wActiveAttrmap  [mirrored with bank 2]
;   $d800-$d80f  window / menu engine
;   $d810-$d83e  window / menu engine
;   $d841-$d87f  text and window engine
;   $d880-$d88f  short-text fetch
;   $d8b0-$d8ff  text argument queues
;   $d900-$da7f  scene tile animation staging
;   $da80-$db13  scene tile animations
;   $dc00-$dc7f  window system
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Shadow tilemap for text windows: the same 32 x 32 tile plane plus CGB
; attribute plane the full-screen UIs keep in WRAM bank $03, owned by the
; window engine. ResetTextWindowState clears both and points
; wShadowTilemapPtr / wShadowTilemapBank at $d000 / $05; the dirty-row
; flusher copies changed rows to $9800. Bank $05 code also uses $d000/$d400
; literals for whichever plane the current screen owns, and its glyph
; buffers are at $d300-$d7ff in WRAM bank $07. RestoreShadowTilemapRow
; reads wMapBuffer64 under WRAM banks $03/$02 and writes these planes under
; bank $05.
; window shadow tilemap (WRAM bank $05)
; Tile plane of the text-window shadow tilemap: 32 x 32 cells, rows TILEMAP_WIDTH apart, of which the top-left 20 x 18 is on screen
wWindowShadowTilemap:: ds 1024
; CGB attribute plane of the text-window shadow tilemap, cell for cell with wWindowShadowTilemap and copied to $9800 in VRAM bank 1
wWindowShadowAttrmap:: ds 1024

; Window-fit table: four 4-byte entries.
; window / menu engine (bank $05)
; [16 bytes] FitWindowToText turns a window id into an offset with two `sla a` and reads the entry's first word into hl before centring the text against wDialogueWindowWidth / Height. ResetTextWindowState clears it with the rest of $d800-$dfff
wWindowFitTable:: ds 16

; Window and menu engine state.
; window / menu engine (bank $05, WRAM bank $05)
	ds 16
; [8-bit] Window struct index AllocWindowStruct returned for the window being built, $ff when none was free; CreateMenuWindowFromText passes it to SetWindowTextId / SetWindowState and returns it
wWindowId:: db
; [8-bit] Window struct index the glyph stream renders into, set by RedrawWindowText / Unused_05_RenderWindowTextToCompletion; InitGlyphStreamForWindow, Unused_05_DrawWindowGlyphRun, FlushGlyphRow and UploadLastGlyphTiles resolve the window through it
wGlyphWindowId:: db
; [8-bit] While nonzero the glyph buffer is kept: PrepareGlyphBuffer calls ClearGlyphBuffer and ResetGlyphStream only on 0. Unused_05_CloseMenuWindow (never called) decrements it and nothing increments it, so the keep branch never runs (docs/bugs.md)
wGlyphBufferHoldCount:: db
	ds 1
; [8-bit] Window struct index of the on-screen dialogue window, set by CreateDialogueWindow; used by RedrawActiveTextWindow, RenderActiveWindowText, CloseActiveDialogueWindow and the speaker-dialogue helpers
wDialogueWindowId:: db
; [8-bit] Dialogue window top-left tilemap column (wrapped to $1f)
wDialogueWindowCol:: db
; [8-bit] Dialogue window top-left tilemap row (wrapped to $1f)
wDialogueWindowRow:: db
; [8-bit] Dialogue window width in cells, from b at CreateDialogueWindow
wDialogueWindowWidth:: db
; [8-bit] Dialogue window height in cells, from c at CreateDialogueWindow
wDialogueWindowHeight:: db
; [8-bit] Re-entrancy guard around RedrawActiveTextWindow: the delay/wait text commands redraw only while it is 0 and set it during their own redraw
wTextRedrawGuard:: db
; [8-bit] Text cursor column, 0-31. RenderTextString seeds it from d & $1f with wTextCursorRow; TextCmdNewline reloads it into d for GetTilemapCellAddress to re-point the write pointer
wTextCursorColumn:: db
; [8-bit] Text cursor row, 0-31. TextCmdNewline advances it by two rows (the font is double height), wrapping with `and $1f`; the two glyph-stream row commands compare it against a row computed from the stream offset
wTextCursorRow:: db
	ds 3
; [8-bit] Window struct index of the menu window CreateMenuWindowFromText just built (copy of wWindowId taken as the menu is pushed)
wMenuWindowId:: db
; [8-bit] Row the menu cursor sits on; RunMenuSelection steps it against wMenuRowCount and returns it as the chosen entry
wMenuCursorRow:: db
; [8-bit] Selectable rows in the current menu, (lines - 1) / 2 from MeasureTextDimensions
wMenuRowCount:: db
; [12 bytes] Six two-byte frames, one per nested menu, indexed by wMenuDepth * 2: [wMenuRowCount << 4 | saved wMenuCursorRow, window id]. Pushed by CreateMenuWindowFromText, unwound when a menu is cancelled
wMenuStack:: ds 12
; [8-bit] Number of menus currently stacked; indexes wMenuStack
wMenuDepth:: db

	ds 2

; Text and dialogue engine state, owned by the bank $05 text/window engine
; and driven from the bank $0a story scripts and bank $0b drill messages.
; The engine selects WRAM bank $05 once on entry. Bank $1b keeps its
; ranking-marker animation channels at the same $d84x bytes in another
; WRAM bank, and banks $18/$1a/$6b use $d8bx/$d8fx as screen tilemap cells.
; text and window engine (banks $05/$0a/$0b)
; [8-bit] Frame counter of the menu-cursor arrow blink task; bit 4 picks the tile written ($20 blank / $0d arrow)
wTextArrowBlinkCounter:: db
; [16-bit] Shadow-tilemap address of the cell the cursor arrow is in. AnimateTextArrowTask converts it to a VRAM address (+ $3000 + $9800) and blinks the arrow there; RunMenuSelection primes it to $ffff and rewrites it whenever the cursor moves
wTextArrowCell:: dw
; [16-bit] VRAM address of the cell the arrow just left, overwritten with tile $20 by the blink task, which then clears it; zero means nothing pending (AnimateTextArrowTask tests the low byte, Unused_05_AnimateMenuScrollArrowsTask the high)
wTextArrowEraseAddr:: dw
; [8-bit] Page RunPagedTextMenu shows; left/right step and wrap it. The returned entry is wMenuPage * 4 + row (four rows a page)
wMenuPage:: db
; [8-bit] Cursor into wTextArgStringQueue: PushTextArgString writes at it, TextCmdPrintArgString reads at it, the dialogue entry points reset it between messages. Stops at 16
wTextArgStringWriteIndex:: db
; [8-bit] The same cursor for wTextArgNumberQueue, shared by PushTextArgNumber and TextCmdPrintArgNumber
wTextArgNumberWriteIndex:: db
; [8-bit] The same cursor for wTextArgShortTextQueue, written by Unused_05_PushTextArgShortTextId
wTextArgShortTextWriteIndex:: db
; [8-bit] String args pushed. Kept in step with wTextArgStringWriteIndex while queueing and not reset with the cursor, so it is the limit the print command stops at
wTextArgStringCount:: db
; [8-bit] The same count for wTextArgNumberQueue; TextCmdPrintArgNumber prints nothing once the cursor reaches it
wTextArgNumberCount:: db
; [8-bit] The same count for wTextArgShortTextQueue
wTextArgShortTextCount:: db
	ds 1
; [16-bit] Text-stream pointer to resume from instead of the start of wTextBuffer; a nonzero high byte is the "set" flag RenderTextString and FitWindowToText test and clear. Filled by TextInterpreterLoop at a TextCmdWaitButtonPage, and by FindDialogueChoiceMarker with the position of the $02 choice marker so the yes/no prompt measures and renders only the tail
wTextResumePtr:: dw
; [8-bit] Set by TextCmdWaitButtonPage: TextInterpreterLoop saves the resume offset to wTextResumePtr and returns, and the dialogue loops re-enter while it is set
wTextPageBreakRequest:: db
; [8-bit] Owner of the current dialogue, as passed to ShowSpeakerDialogue ($ff becomes 0). Bit 7 set: the low bits are a literal screen row. Clear: they are an actor id, and OpenSpeechBubble / ShowYesNoPromptWindow compare that actor's Y with the camera to open the window on the top or bottom half
wDialogueSpeaker:: db
; [16-bit] Text id the story script is up to: InitDialogueTextCursor seeds it and every Script*Dialogue call in bank $0a shows it and increments, so a cutscene walks consecutive ids
wScriptDialogueTextId:: dw
; [8-bit] Widest line of the measured text in whole cells; written by FitWindowToText, returned by MeasureDialogueWidthTiles
wFitTextWidthCells:: db
	ds 7
; [8-bit] 1 when OpenSpeechBubble / Unused_05_OpenCenteredDialogueWindow put the window on the lower half (speaker near the top), else 0. Write-only
wSpeechBubbleLowerHalf:: db
; [8-bit] Stored by Unused_05_SetTextVar; nothing reads it
wUnusedTextByte:: db
	ds 1
; [8-bit] 1 when RenderWindowText bails on the "no text" sentinel ($03 in the text id's high byte), 0 otherwise. Write-only
wWindowTextEmpty:: db
	ds 2
; [8-bit] Speaker voice for the per-character text blip: DelayTextCharacter plays sound $9a + voice * 4 + (glyph & 3) per glyph. Set from GetSpeakerVoice; $08 = silent, also forced by a negative message speed
wDialogueVoice:: db
; [8-bit] Window Unused_05_SetFixedMenuWindowTextId built, closed by Unused_05_RunFixedTextMenu with the menu window. Neither is called; Unused_05_SetFixedMenuWindowTextId loads hWramBank into b before SetWindowTextId, so the "window id" they pass around is really the WRAM bank number
wFixedMenuWindowId:: db
; [16-bit] Start of the current text row in the destination (a window shadow-tilemap cell, or RenderTextToBuffer64's buffer); TextCmdNextGlyphStreamRow advances it two row pitches
wTextRowStartPtr:: dw
; [8-bit] Second cursor into wTextArgStringQueue, stepped by MeasureNextArgStringWidth: FitWindowToText measures the whole message before drawing, so each queue has a separate measure cursor. The dialogue entry points reset all six cursors together
wTextArgStringMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgNumberQueue, stepped by MeasureNextArgNumberWidth
wTextArgNumberMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgShortTextQueue, stepped by GetNextArgShortTextLength
wTextArgShortTextMeasureIndex:: db
; [16-bit] Current read pointer into the text byte stream
wTextStreamPtr:: dw
	ds 4
; [8-bit] Line count of the measured text, companion of wFitTextWidthCells; ShowDrillMessageByIndex makes a window height of lines * 2 + 1
wFitTextLineCount:: db
	ds 16

; Short-text scratch buffer. Every string bank ends with the same
; FetchShortText tail, which copies into $d880; the bank $6b intro cutscene
; uses the same bytes as tilemap rows in WRAM banks $03/$04.
; short-text fetch (text banks)
; [16 bytes] Short string buffer: the text-bank fetch routines copy the string here instead of wTextBuffer when called with a != 0
wShortTextBuffer:: ds 16
	export_size wShortTextBuffer

	ds 32

; Text-argument queues: three parallel 16-entry rings the text control
; codes pop from, each with a write cursor, a count and a measure-pass
; cursor ($d847-$d84c / $d866-$d868). Banks $18/$1a/$1b/$6b use these
; bytes as screen tilemap cells in other WRAM banks.
; text argument queues (banks $05/$0a/$0b)
; 16 x 2-byte string pointers queued by PushTextArgString. The high nibble carries a WRAM bank tag, so an argument can point into a banked buffer
wTextArgStringQueue:: ds 32
; 16 x 2-byte values queued by PushTextArgNumber for TextCmdPrintArgNumber
wTextArgNumberQueue:: ds 32
; 16 x 1-byte short-text ids queued by Unused_05_PushTextArgShortTextId; GetNextArgShortTextLength measures them, but the $08 control code that would print one is a bare ret (TextCmdNop2)
wTextArgShortTextQueue:: ds 16

; Staging buffer UpdateSceneTileAnimations assembles the scene's animated
; tiles in before queueing them to VRAM; bounded by the animation header at
; $da80.
; scene tile animation staging (bank $0a)
; [384 bytes] The tile staging buffer, $d900-$da7f. Referenced only as the initial value of wSceneTileAnimBufferPtr; filled by FarCopyBytes through that cursor, read by QueueVRAMCopy
wSceneTileAnimBuffer:: ds 384

; Scene tile-animation record: an $88-byte slot InitSceneTileAnimations
; copies in before building its animation slots.
; scene tile animations (bank $0a)
; [8 bytes] Header of the tile-animation record; the entry list follows at wSceneTileAnimEntries
wSceneTileAnimHeader:: ds 8
; [128 bytes] The scene's tile-animation entries; InitSceneTileAnimations builds no slots when the first byte is $fe (empty list)
wSceneTileAnimEntries:: ds 128
	ds 8
; [16-bit] Write cursor into wSceneTileAnimBuffer: UpdateSceneTileAnimations seeds it with the buffer base each pass, uses it as FarCopyBytes destination and QueueVRAMCopy source, and advances it by the bytes copied
wSceneTileAnimBufferPtr:: dw
; [16-bit] Far source pointer for the frame being staged, copied from the scene's slot 6 record by FarCopyBytes, then offset by the frame index
wSceneTileAnimSrcPtr:: dw
	export_size wSceneTileAnimSrcPtr

	ds 236

; Window bookkeeping, owned by the bank $05 window system: the window struct
; array, the dirty-row flags that drive the shadow tilemap flush, and the
; allocator mask. Unused_05_WriteStringToTilemapStreamed keeps its own
; cursor at $dc05-$dc0a in the caller's WRAM bank, so those bytes are not
; windows. Banks $0d and $17/$3b use the same addresses in WRAM banks $04
; and $03.
; window system (bank $05)
; [64 bytes] Eight 8-byte window records, indexed by window id (GetWindowStructPtr: id & 7, << 3):
;   +$00 column, +$01 row (both wrapped to $1f by SetWindowRect)
;   +$02 width in cells, +$03 height in cells
;   +$04 state, read and written through GetWindowState / SetWindowState
;   +$06 text id (lo/hi), stored by SetWindowTextId; $03 in the high byte
;        is the "no text" sentinel RenderWindowText bails on
; AllocWindowStruct fills a free slot from de/bc, FreeWindow zeroes all
; eight bytes and releases the wWindowSlotMask bit
wWindowStructs:: ds 64
; [32 bytes] One flag per tilemap row. SetRowDirtyFlags clears the array and marks e rows from d (wrapping at 32), telling the flusher which rows a window redraw changed
wTilemapRowDirty:: ds 32
; [16 bytes] Run list BuildDirtyRowRuns makes from wTilemapRowDirty: (first row, length) pairs ending in $ff, runs capped at 7 rows so one FlushDirtyRowsPerFrame pass fits in a VBlank; one run per frame
wTilemapRowRuns:: ds 16
; [8-bit] One bit per window struct, set while in use; Unused_05_AllocWindowSlotBit claims a clear bit, FreeWindow clears it
wWindowSlotMask:: db
	ds 5
; [16-bit] Byte offset Unused_05_RefreshShadowTilemapFromMapBuffer adds to wShadowTilemapPtr when copying rows back. Never written, so it stays 0 from ResetTextWindowState
wShadowTilemapReadOffset:: dw
; [8 bytes] Scratch copy of one window record made by SaveWindowStruct, so a routine can rewrite the live one and compare against the start (OpenSpeechBubble grows the bubble one cell at a time against the saved column)
wSavedWindowStruct:: ds 8

SECTION "WRAMX bank 5 $df00", WRAMX[$df00], BANK[5]

	match_char_struct w5
