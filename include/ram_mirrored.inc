; Mirrored RAM symbols: one address range that holds a parallel copy in
; each of several WRAM banks, so the address names the cell and the
; selected bank picks which copy. Declared as constants, not sections,
; because no single bank owns them (docs/ram_map.md "Mirrored variants").
; tools/ram_free.py reads the `[N bytes]` tag and the `; in WRAM banks` line,
; which lists the banks that hold a copy; a symbol without one is counted in
; no bank.

; [1024 bytes] BG tile plane of the screen currently running, 32 x 32 cells with rows TILEMAP_WIDTH apart. The same bytes are wCourtTilemap in WRAM bank $02, wWindowShadowTilemap in bank $05 and wShadowTilemap in bank $03; wShadowTilemapBank / wShadowTilemapPtr are how the text engine is told which one is live.
; in WRAM banks $02, $05
def wActiveTilemap equ $d000

; [1056 bytes] The live screen the character-data and EXP screens draw into, one 32 x 32 cell plane in each of WRAM banks $02 and $03 -- bank $03 the tile half, bank $02 the CGB attribute half, cell for cell at the same address. References are arguments to routines that select those banks themselves (CharDataScreen_WriteStatNumber writes [de] under $03 then $02; ApplyTilemapPatchList and its EXP-screen twin likewise), so the WRAM bank live at the call site ($06) says nothing about the operand. Declared one row longer because SetupCharDataScreen's band-8 runs read a 33rd row at +$400 ($d410).
; in WRAM banks $02, $03
def wCharDataScreenCell equ $d000

; [1024 bytes] One byte per half-tile cell of the scene, 32 x 32, addressed as (y & ~1) * 16 + (x & ~1) / 2 by GetCollisionMapCellAddr. Accessed only by ReadCollisionMapCell and Unused_0a_WriteCollisionMapCell, each selecting WRAM bank $06 for the one access.
; in WRAM banks $06
def wCollisionMap equ $d000

; [4096 bytes] 64 rows of 64 cells, one plane in each of WRAM banks $02 and $03 -- bank $03 the tile half, bank $02 the CGB attribute half. Both axes wrap within the buffer (the `and $3f` on each camera coordinate, `res 5, h / set 4, h` in BlitBGColumnFrom64). The story scenes and the intro and title cutscenes decompress whole 4096-byte planes here; Unused_00_CopyMapToScrollBuffers fills only the top 32 rows and clears the bottom half.
; in WRAM banks $02, $03
def wMapBuffer64 equ $d000

; [1024 bytes] Its CGB attribute plane, cell for cell $400 higher -- wCourtAttrmap, wWindowShadowAttrmap or wShadowAttrmap depending on the bank. FlushTilemapToVram sends the tile half to $9800 in VRAM bank 0 and this half to the same address in bank 1.
; in WRAM banks $02, $05
def wActiveAttrmap equ $d400

; [1024 bytes] Second plane of wCollisionMap's grid, cell for cell $400 higher: what a cell does rather than whether it blocks. ReadBehaviorMapCell also prints the byte as a debug readout.
; in WRAM banks $06
def wBehaviorMap equ $d400

; [992 bytes] Base stat-page rows for the character-data screen, one 31 x 32 cell plane in each of WRAM banks $02 and $03 (tile half / CGB attribute half, cell for cell). LoadBasePageIntoWorkTilemap copies a row to the live screen once per bank, so both `ld hl` operands of that pair are the same word. Not an attribute map, despite sitting where wShadowAttrmap does for other screens; the page slots start at wCharDataPageSlot1.
; Bank $1c stages the stat-distribution screen's reveal bands in the same rows: BlitTilemapRunsFromTable's eight bands walk $d240, $d280, $d2d0, $d310, $d370, $d3e0 and $d410 (rows 18 to 32 of one plane, alternating columns 0 and 16), so band 8's base is this plane's first row. The 576 bytes from `+ 1 * TILEMAP_WIDTH + 16` on are wCharDataScreenBackup, a save area.
; Bank $1d passes cells here to CharDataScreen_WriteStatNumber and ApplyTilemapPatchList like wCharDataScreenCell: the callee selects the bank.
def wCharDataPagePlane equ $d400

; [576 bytes] Snapshot of the visible screen -- 18 rows of 32 cells, one copy in each of WRAM banks $02 and $03 -- taken at the top of AnimateCharDataStatsReveal and copied back before every step, so each step redraws over a clean background. CopyMemoryFast's `c` counts 16-byte blocks (`ld c, $24` = 576 bytes). Lies inside wCharDataPagePlane's extent; the stat pages patch cells through $d430 while this snapshot is not live.
; in WRAM banks $02, $03
def wCharDataScreenBackup equ $d430

; [144 bytes] One 3 x 3 tile mugshot, decompressed from the entry CharMugshotGfxPointers holds for the character id in a. CopyMugshotBufferToVram sends all nine tiles to the VRAM address its caller passes in de.
; in WRAM banks $02, $03, $04
def wMugshotBuffer equ $d600

; [576 bytes] Saved stat page, mirrored across WRAM banks $02/$03 like wCharDataPagePlane. SaveWorkTilemapToPage copies the live screen here when its selector is 1, once per bank; the three 36-byte rows sit 8 * TILEMAP_WIDTH apart and are what MainCharStatPageTilemapPatch* patch through ApplyTilemapPatchList.
def wCharDataPageSlot1 equ $d7e0

; [1024 bytes] Tile plane of the intro cutscene's Mario artwork, decompressed from DataPtr_IntroMarioTilemap. The state inits QueueVRAMCopy slices of it ($d880, $d8c0) to $9c80/$9cc0 in VRAM bank 0, and the same offsets of wIntroMarioAttrmap to VRAM bank 1.
; in WRAM banks $04
def wIntroMarioTilemap equ $d800

; [576 bytes] Saved stat page, mirrored across WRAM banks $02/$03 like wCharDataPagePlane. SaveWorkTilemapToPage copies the live screen here when its selector is 2, once per bank; the three 36-byte rows sit 8 * TILEMAP_WIDTH apart and are what MainCharStatPageTilemapPatch* patch through ApplyTilemapPatchList.
def wCharDataPageSlot2 equ $da20

; [1024 bytes] CGB attribute plane for wIntroMarioTilemap, cell for cell, from DataPtr_IntroMarioAttrmap. Every copy out of it targets VRAM bank 1 at the address its tile-plane twin goes to in bank 0.
; in WRAM banks $04
def wIntroMarioAttrmap equ $dc00

; [576 bytes] Saved stat page, mirrored across WRAM banks $02/$03 like wCharDataPagePlane. SaveWorkTilemapToPage copies the live screen here when its selector is 3 or more (0 saves into wCharDataPagePlane + 13 * TILEMAP_WIDTH), once per bank; the three 36-byte rows sit 8 * TILEMAP_WIDTH apart and are what MainCharStatPageTilemapPatch* patch through ApplyTilemapPatchList.
def wCharDataPageSlot3 equ $dc60

; [42 bytes] The character-data confirm screen's top banner rows, mirrored across WRAM banks $02/$03 (tile half / CGB attribute half). RunCharDataConfirmScreen decompresses each half to wDecompBufferHigh tile 106 in bank $01 and CopyBank1ToBank3/2BufferAlt copy it to the same address here, from where ApplyTilemapPatchList_1a patches three 14-byte runs into wCharDataScreenCell.
; in WRAM banks $02, $03
def wCharDataConfirmTopRows equ $dea0

; $df00-$df96: the per-character match struct, one copy in each of WRAM banks
; $04-$07, and its bank $05 overlays. The fields are documented once, in
; match_char_struct (include/macros/ram.inc), which declares the bank-tagged
; copies; tests/test_rom.py checks these names against them.
def wCharStruct equ $df00
def wCharPosX equ $df00
def wClearStatusMode equ $df00
def wTextArgFetchBuffer equ $df00
def wClearStatusDoubles equ $df01
def wClearStatusFormat equ $df02
def wCharPosDepth equ $df03
def wClearStatusClass equ $df03
def wClearStatusRank equ $df04
def wClearStatusWindowId equ $df05
def wCharPosHeight equ $df06
def wClearStatusResultCode equ $df06
def wCharServeRole equ $df09
def wCharCourtPos equ $df0a
def wCharIndex equ $df0b
def wCharBaseFacing equ $df0c
def wCharFacingDesired equ $df0d
def wCharFacingShown equ $df0e
def wCharFlags equ $df0f
def wCharFreezeTimer equ $df10
def wCharShotComboTimer equ $df11
def wAiActionTimer equ $df12
def wAiSecondButtonDelay equ $df13
def wCharShotType equ $df14
def wCharSwingAnim equ $df15
def wCharShotButton1 equ $df16
def wCharShotButton2 equ $df17
def wCharState equ $df18
def wCharStatePhase equ $df19
def wAiPhase equ $df1a
def wCharSpriteFrame equ $df1b
def wCharInputSource equ $df1e
def wCharInputBits equ $df1f
def wCharObjectDefId equ $df21
def wCharObjectBank equ $df22
def wCharFrameTablePtr equ $df24
def wCharFrameVramDest equ $df26
def wCharAnimTablePtr equ $df28
def wCharAnimScriptBase equ $df2a
def wCharAnimScriptPtr equ $df2c
def wCharAnimId equ $df2e
def wCharAnimDelay equ $df2f
def wCharSpriteDirty equ $df30
def wCharFacingOctant equ $df32
def wCharAnimFrame equ $df33
def wCharTileBase equ $df36
def wCharSpriteAttr equ $df37
def wCharFramePlaceTablePtr equ $df38
def wCharPaletteId equ $df3a
def wCharVelX equ $df40
def wCharVelDepth equ $df42
def wCharVelHeight equ $df44
def wCharWalkTargetX equ $df46
def wCharWalkTargetDepth equ $df48
def wCharAimOffset equ $df4a
def wCharSwingFrames equ $df4b
def wCharQuickSwing equ $df4c
def wCharSwingHoldButton equ $df4d
def wCharSwingHoldFrames equ $df4e
def wCharLastShotButton equ $df4f
def wCharBallReachFlags equ $df50
def wCharChargeFlashOn equ $df51
def wCharChargeFlashPalLoaded equ $df52
def wCharScreenX equ $df53
def wCharScreenY equ $df54
def wCharWalkTargetFlag equ $df55
def wCharScriptedMove equ $df56
def wCharPointResult equ $df57
def wAiShotButtons equ $df58
def wAiTrackingCountdown equ $df59
def wCharRallyReady equ $df5a
def wCharMaxSpeedX equ $df60
def wCharMaxSpeedDepth equ $df62
def wCharAcceleration equ $df64
def wCharDeceleration equ $df66
def wCharFacingEaseRate equ $df68
def wCharAimOffsetScale equ $df69
def wCharAimJitterScale equ $df6a
def wGroundStrokeSpeedIndex equ $df6b
def wSmashServeSpeedIndex equ $df6c
def wReachSpeedIndex equ $df6d
def wTopspinPlacementIndex equ $df6e
def wSlicePlacementIndex equ $df6f
def wCharReachHeight equ $df70
def wCharReachX equ $df72
def wCharSmashJumpSpeed equ $df74
def wCharDiveSpeed equ $df76
def wCharId equ $df78
def wAiReactionDelayNear equ $df79
def wAiReactionDelayFar equ $df7a
def wAiTrackingParam equ $df7b
def wAiAimAwayChance equ $df7c
def wAiDifficulty equ $df7d
def wCharSpriteSetId equ $df7e
def wAiPositionStrategy equ $df7f
def wCharSpriteSlot equ $df80
def wCharSpriteSlotFrame equ $df84
def wCharAirShadowSlot equ $df88
def wCharGroundShadowSlot equ $df8c
def wCharShotTraits equ $df90
def wLobPlacementIndex equ $df92
def wDropPlacementIndex equ $df93
def wCharMirrorAttrMask equ $df94
def wCharLevel equ $df95
def wCharDepthKey equ $df96

; The game progress screen (bank $1e) keeps its lists in WRAM bank $05's
; $df00 page.
; [1 byte] Window struct index CreateProgressListWindow returns; DrawTextWindowFrame redraws the list frame with it after each scroll
; in WRAM banks $05
def wProgressWindowId equ $df01

; [1 byte] How many progress entries BuildVisibleProgressEntryList found unlocked
; in WRAM banks $05
def wProgressVisibleCount equ $df03

; [1 byte] The row the progress list is scrolled to, an index into wProgressVisibleEntries
; in WRAM banks $05
def wProgressListIndex equ $df05

; [1 byte] Nonzero while the list can scroll up (wProgressListIndex is not 0): DrawProgressScreenSprites draws the up arrow
; in WRAM banks $05
def wProgressUpArrow equ $df07

; [1 byte] 1 while rows remain below the visible seven: DrawProgressScreenSprites draws the down arrow
; in WRAM banks $05
def wProgressDownArrow equ $df08

; [48 bytes] Per progress entry, 1 if its flag is set (RunRewardCategoryList); BuildVisibleProgressEntryList packs the set ones into wProgressVisibleEntries
; in WRAM banks $05
def wProgressEntryUnlocked equ $df10

; [37 bytes] Per progress entry, whether it has been earned (BuildProgressEntryEarnedTable, read by GetProgressEntryEarned)
; in WRAM banks $05
def wProgressEntryEarned equ $df40

; [48 bytes] The entry ids to draw, in order, $ff-filled past wProgressVisibleCount
; in WRAM banks $05
def wProgressVisibleEntries equ $df70

; [1024 bytes] Second copy of the decompressed stadium tilemap that the bank $39 menus keep beside wShadowTilemap: RestoreMenuBgAndDrawPanel restores the 20 x 16 background from its top rows and copies panel art out of rows 16-31 (panel_rect). Overlays the bank's screen-scratch unions.
; in WRAM banks $03
def wStadiumTilemapCopy equ $d800

; [1024 bytes] The matching copy of the stadium attribute map, the source of the attribute half of every panel_rect.
; in WRAM banks $03
def wStadiumAttrmapCopy equ $dc00
