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
; [16-bit] Current VRAM destination address for glyph tiles (lo/hi)
wGlyphVramDest:: dw
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

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 5's. Code
; uses the untagged names (EQUs in include/ram_mirrored.inc), because the
; bank is chosen at run time. A change here belongs in every copy.

; Match-engine per-character struct, bank = character: 4 near-P1, 5 far-P1,
; 6 near-partner, 7 far-partner. Only named field offsets render; other
; $dfxx bytes stay numeric. Bank $38's UpdateCharSelectCharSprite and
; TickCharSelectIdleAnim drive the same struct once per preview character,
; selecting WRAM banks $04-$07 in turn (bank $38's own $df00 is
; wCharSelectHandedness in WRAM bank $03).
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled; Continue and cancel go straight to the result code. The menu keeps its state in WRAM bank $05 over the idle far-P1 character struct, cleared 32 bytes at a time on entry
w5ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w5ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w5ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w5ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w5ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w5ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w5ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w5TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w5CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w5CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w5CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w5CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w5CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w5CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w5CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w5CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w5CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w5CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w5CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w5CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w5AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w5AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w5CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w5CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w5CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w5CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w5CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w5CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w5AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w5CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w5CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w5CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w5CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w5CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w5CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w5CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w5CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w5CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w5CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w5CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w5CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w5CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w5CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w5CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w5CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w5CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w5CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w5CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w5CharVelX:: dw
; [16-bit] Depth velocity
w5CharVelDepth:: dw
; [16-bit] Height velocity
w5CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w5CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w5CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w5CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w5CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w5CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w5CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w5CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w5CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w5CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w5CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w5CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w5CharScreenX:: db
; [8-bit] Last projected screen Y
w5CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w5CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w5CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w5CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w5AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w5AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w5CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w5CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w5CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w5CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w5CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w5CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w5CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w5CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w5GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w5SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w5ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w5TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w5SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w5CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w5CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w5CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w5CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w5CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w5AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w5AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w5AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w5AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w5AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w5CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w5AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w5CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w5CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w5CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w5CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w5CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w5LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w5DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w5CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w5CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w5CharDepthKey:: db
ENDU
