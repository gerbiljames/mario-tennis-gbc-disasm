; WRAM0 $c500-$c7ff: the second shadow-OAM page, text and tilemap buffers, debug-menu state.

; [160 bytes] Second shadow OAM page: hOAMDMARoutine sources $c0 or $c5 as wSpriteBufferPage toggles, so this is built while wShadowOAM is copied (and vice versa). Only reached through pointers, with wSpriteBufferPage as the high byte
wShadowOAM2:: ds 160
	ds 96

; Dialogue string buffer (160 bytes); text-bank fetch routines copy string N here when called with a = 0. Also the save engine's staging area: MirrorSaveHeaderToBank1 copies each 512-byte SRAM header region through $c600-$c7ff on its way to SRAM bank 1, overwriting this buffer, wTilemapRowStage, wInlineTextBuffer and the debug-menu variables
wTextBuffer:: ds 160
	export_size wTextBuffer

; [32 bytes] One tilemap row staged by RestoreShadowTilemapRow: read from the map buffer (wrapping at the map edge), then written back into the shadow tilemap
wTilemapRowStage:: ds 32
	export_size wTilemapRowStage

; 32-byte staging buffer for inline text args (player name, arg strings, short texts) rendered via RenderInlineString
wInlineTextBuffer:: ds 32
	export_size wInlineTextBuffer
	ds 32

; [8-bit] Window struct index of the debug menu's own window, from CreateMenuWindowFromText; RunDebugMenu passes it to RunMenuSelection and CloseWindow
wDebugMenuWindowId:: db

; [8-bit] Window struct index of the debug warp submenu, addressed the same way by DebugDrawWarpMenu
wDebugWarpWindowId:: db

; [8-bit] Story location count from GetStoryLocationCount; RunDebugWarpMenu's location stepper wraps at it
wDebugWarpLocationCount:: db

; [8-bit] Debug warp menu field under the cursor: 0 = location number, 1 = entry point (toggled with xor 1, row drawn at *2+2). The location number is held in $c700 during this menu. The colour editor formats its G digits over these bytes
wDebugWarpCursorRow:: db

; [8-bit] Entry point the debug warp menu is editing, written to wStoryModeEntryPoint when A confirms. $c700-$c709 is shared debug scratch: the window ids here in one submenu, the "RRRGGGBBB" decimal buffer in the colour editor, eight bytes of wCharPosX in the stats editor
wDebugWarpEntryPoint:: db
	ds 1

; [3 bytes] Last third of the colour editor's $c700-$c709 digit string: DebugDrawColorComponents formats R/G/B as 3-digit groups at $c700/$c703/$c706, puts the $0d cursor glyph over the selected component's first digit, and WriteStringToWindow draws the run. R and G overlap the warp-menu names
wDebugColorBlueDigits:: ds 3

; [8-bit] NUL terminator after the nine RGB digits; last byte of the $c700-$c709 debug scratch
wDebugColorDigitsEnd:: db
	ds 6

; [8-bit] Window handle of the debug palette viewer's grid window (RunDebugPaletteViewer)
wDebugPaletteViewerWindowId:: db

; [8-bit] Window handle of the debug colour editor opened on top of the palette viewer (RunDebugColorEditor)
wDebugColorEditorWindowId:: db

; [8-bit] Which of the four colours in the selected palette the debug cursor is on, masked to $03
wDebugPaletteColorIndex:: db

; [8-bit] Palette under the debug cursor, masked to $0f. GetSelectedBGPaletteColorPtr indexes wBGPalettes with (palette * 4 + colour) * 2, so 8-15 run on into wOBJPalettes
wDebugPaletteIndex:: db

; [8-bit] Page of 64 game flags shown by the debug flag editor; the flag number DebugToggleSelectedFlag builds is page * 64 + byte * 8 + bit
wDebugFlagPage:: db

; [8-bit] Bit 0-7 the flag cursor sits on (the low term of the flag number)
wDebugFlagBit:: db

; [8-bit] Flag byte within the page, scaled by 8 into the flag number
wDebugFlagByte:: db

; [8-bit] Window handle of the debug flag editor's two-row hex header
wDebugFlagHeaderWindowId:: db

; [8-bit] Window handle of the debug flag editor's first flag grid
wDebugFlagWindow1Id:: db

; [8-bit] Window handle of the debug flag editor's second flag grid; all three windows are redrawn on every cursor move
wDebugFlagWindow2Id:: db
	ds 6

; [16 bytes] The debug warp menu's number-entry prompt: copied here, then FormatDecimalNumber overwrites the digits in place
wDebugNumberEntryText:: ds 16
	export_size wDebugNumberEntryText
	ds 48

; [8 bytes] Four 16-bit values the debug stats page shows as words. Only +$00, +$04 and +$06 are drawn; +$02 is skipped
wDebugStatWords:: ds 8

; [8 bytes] The debug stats editor's eight byte fields, drawn by Unused_06_DrawDebugStatByte and stepped in place: the first three wrap at 2, 8 and 2, the last five are decimal digits 0-9
wDebugStatBytes:: ds 8

; [8 bytes] Four more 16-bit values on the same page, drawn after wDebugStatBytes
wDebugStatWords2:: ds 8
	ds 8

; Mode-local scratch: $c780-$c78f is reused by each game mode. The match
; engine's two `ld hl, $c780 / ld c, $08 / call ClearMemory16` sites zero
; the whole $c780-$c7ff mode page (c * 16 bytes), resetting every union
; variant, the wTargetZone*/wDrillGate* flats and the mode-hook table.
; ResetMugshotPalettes_1b writes $ff to $c780; nothing reads it back.
wModeScratch::
UNION
; character select (bank $1b)
	ds 1
; [8-bit] Character id under the char-select cursor, from the roster grid at $c7a0 (Unused_1b_UpdateCharSelectSelection)
wCharSelectChar:: db
; [8-bit] Character id selected on the previous frame (change detection)
wCharSelectPrevChar:: db
; [8-bit] Char-select cursor column in the roster grid
wCharSelectCol:: db
; [8-bit] Char-select cursor row in the roster grid
wCharSelectRow:: db
	ds 7
NEXTU
; minigames (bank $0d)
; [16-bit] Serves launched this round. LaunchMinigameServe increments it and derives the ball speed from it (count / 10, capped at $19), so the feed speeds up
wMinigameServeCount:: dw
; [16-bit] Points shown by the score popup; AwardHitScore and the per-minigame scorers store the award here before AddToMinigameScore
wScorePopupValue:: dw
; [8-bit] Ball speed LaunchMinigameServe passed to LaunchBall for this serve
wMinigameServeSpeed:: db
; [8-bit] Which serve the tennis machine plays next; the machine hooks advance it by 1 or 2 per point and wrap it, and ApplyMinigameCharTargetFromTable indexes the aim table with it
wMinigameServeSlot:: db
; [8-bit] wMinigameServeSlot / 3, taken by LaunchMinigameServe and read back by LaunchBall
wMinigameServeGroup:: db
; [8-bit] Frames left on the score popup, seeded with $10 by StartScorePopup; UpdateScorePopup ticks it and uses it as the rise offset
wScorePopupTimer:: db
; [8-bit] Set while a hit is being scored; ResetTargetHitState clears the streak only when this is clear, which keeps a streak alive across one rally's points
wMinigameHitScored:: db
; [8-bit] Consecutive scoring hits, stepped by IncrementCappedCounter (cap in b). AwardHitScore indexes a sound table and a score table with it
wMinigameHitStreak:: db
; [8-bit] Treasure Box actor state, stepped by AdvanceTreasureBoxActorState and used by DrawTreasureBoxSprite to pick the frame
wTreasureBoxState:: db
NEXTU
; training drills (bank $0b)
	ds 11
; [8-bit] Set while the serve gate stands: RecordGateCrossOnServe clears it when the serve passes through (recording the bit in wDrillGateCrossBits); QueueDrillMarker1/2 draw the gate markers only while set
wDrillGateActive:: db
NEXTU
; scoreboard (bank $18)
; [8-bit] Cleared by Unused_18_InitConfirmScreen; Unused_18_DrawScoreNumbersTask raises wScorePanelBobActive for the frame's score digits when it equals 3. Nothing advances it, and the confirm screen's only caller is Unused_1b_ShowHighScoreConfirmScreen, so the bob is dead (ramp table UnusedBobRamp_18)
wScorePanelBobStep:: db
	ds 2
; [8-bit] Raised by Unused_18_DrawScoreNumbersTask around drawing the wScorePanelScore digits; Unused_18_DrawGlyphSprite then adds a per-glyph Y offset from UnusedBobRamp_18
wScorePanelBobActive:: db
	ds 6
; [8-bit] Snapshot of wStoryMainCharExpTier taken by Unused_18_LoadScorePanelValue, drawn by Unused_18_DrawScoreNumbersTask
wScorePanelExpTier:: db
; [8-bit named; read as a 16-bit word] Unused_18_DrawScoreNumbersTask draws $c78b-$c78c as a 3-digit sprite number beside wScorePanelExpTier. Nothing in bank $18 writes it and the high byte is wTargetZoneEnabled, so it reads whatever the mode-page clear left (0)
wScorePanelScore:: db
ENDU

; [8-bit] Nonzero draws the 4-corner court target zone (training drills)
wTargetZoneEnabled:: db

; The last three bytes of the $c780 mode-local scratch block, above
; wTargetZoneEnabled. The minigame target code and the scoreboard both own
; them, in different modes.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Type of the target the ball just hit, an index into MinigameTargetTypeScores; $ff = scores nothing
wMinigameHitTargetType:: db
; [8-bit] Set by the deflect hit-test and cleared by ScoreMinigameTargetHitOrDeflectBall once the hit has been scored
wMinigameHitPending:: db
	ds 1
NEXTU
; scoreboard (bank $18)
; [3 bytes] Three values Unused_18_SetupScoreboardDisplay draws as 6x2 tile blocks, each via Unused_18_GetTextSlotPointer
wScorePanelValues:: ds 3
ENDU

; [16-bit] Target zone X bound 1 (world units)
wTargetZoneX1:: dw

; [16-bit] Target zone depth bound 1 (world units)
wTargetZoneDepth1:: dw

; [16-bit] Target zone X bound 2 (world units)
wTargetZoneX2:: dw

; [16-bit] Target zone depth bound 2 (world units)
wTargetZoneDepth2:: dw

; [4 bytes] First drill gate: two 16-bit coordinates (+$00 from hl, +$02 from de in SetBallGatePoint1). DidBallCrossGate tests the ball against it each frame; QueueDrillMarker1_0b draws the marker there
wDrillGate1:: ds 4

; [4 bytes] The second gate, set and tested the same way
wDrillGate2:: ds 4

; Mode-local scratch, the first five bytes above $c780, used by the
; minigame banks. Bank $1b loads its 32-byte nav grids from the same
; address on past the named mode bytes above (harmless: the match engine
; re-zeroes the $c780-$c7ff page), so only the base byte carries the symbol.
UNION
; menu-shell nav grid (bank $1b)
; [8-bit] Base of the 32-byte 4x8 grid of character/menu-cell ids the menu shell's grid cursor walks; it runs past this union. Unused_1b_LoadCharSelectNavGrid copies CharSelectNavGridTable here and the unlock-debug screen copies UnlockDebugNavGridTable ($ff = empty cell, $fe/$fd = wrap sentinels). Unused_18_MoveGridCursor takes hl = this base; the selection readers index it split-base with row*8+col
wNavGridBuffer:: db
	ds 4
NEXTU
; minigame targets (banks $0a/$0d)
; [4 bytes] Start position of the floating score popup, copied from wBallHistory + 30 by StartScorePopup and stepped by UpdateScorePopup
wScorePopupSource:: ds 4
; [8-bit] Set at init by Banana Bunch and Fruit Fantasy, whose targets deflect the ball instead of absorbing it; UpdateMinigameTarget then runs the Alt draw, hit-test and scoring handlers
wMinigameTargetsAltMode:: db
ENDU

; [8-bit] Random roll SelectRandomMinigameShot and SelectRandomTreasureBoxTargetZone keep while walking their weight tables
wMinigameShotRoll:: db

; [8-bit] Set when the ball lands on a target tile; ProcessTargetTileHit clears it as it scores the hit
wTargetTileHit:: db

; [8-bit] Where the minigame is in its serve: StartMinigameMatch seeds it, DrawMinigameScoreHud and LaunchMinigameServe branch on it
wMinigameServeState:: db

; [8-bit] Nonzero makes AiServePressToss release the serve at once instead of running the wAiServeStyle toss table (the coach drills' plain feed). The bank $0b drill hooks set it at point start and clear it around RunMinigameMatch
wAiServeSkipToss:: db
	ds 7

; [16-bit] Pointer to the layout table for the current minigame point, set by SetMinigamePointTable and walked by LoadMinigamePointLayout and RunMinigamePointLoop
wMinigamePointTable:: dw

; [16-bit] Pointer to the current game mode's callback table (indexed by CallModeHook)
wModeHookTable:: dw

; [8-bit] ROM bank of the mode callback table (0 = no hooks registered)
wModeHookBank:: db

; [8-bit] Aim AiApplyServeAim uses for the next serve; $ff (set by RunMatch) = random from AiApplyServeAimTable. The drill point-start hooks write a fixed aim
wAiServeAimOverride:: db

; [16-bit] Spot the serving CPU walks to; zero makes AiServeWalkToSpot roll a new one. The drill runner clears it before each match
wAiServeTargetX:: dw

; [8-bit] Set to 1 by the InitMinigame_* routines fed by the tennis machine (Tennis Machine 1-4, Target Shot, Shooting Star, Treasure Box, Medallion Match); the match engine reads it for the scoreboard layout, point reset and serve phase
wMinigameUsesTennisMachine:: db

; [8-bit] Set to 1 by the InitMinigame_* routines played against the wall (Wall Practice 1-4, Banana Bunch, Perfect Shot, Fruit Fantasy); read by SelectScoreboardLayout, HandleBallNetCrossing and the serve positioning
wMinigameUsesWall:: db

; [8-bit] Set to 1 by InitMinigame_BooBlast
wMinigameIsBooBlast:: db

; [8-bit] Set to 1 by the bank $0b Service/NetGame practice drills (coach lessons). RecordDrillPointResultBits stores per-point results differently while set; SelectScoreboardLayout picks layout 3
wDrillIsPracticeLesson:: db

; [8-bit] Set to 1 for a high-score attempt: outright by the InitMinigame_*HighScore entries, and by ordinary minigames at wMinigameLevel 2. SelectScoreboardLayout picks layout 7
wMinigameHighScoreMode:: db

; [8-bit] Passed in b to LoadPlayer1ScoreDigitGfx/LoadPlayer2ScoreDigitGfx so the score panel shows tiebreak counts instead of 0/15/30/40. CheckSetComplete sets it entering a tiebreak and clears it at the start of an ordinary game
wScoreDisplayIsTiebreak:: db

; Mode-local scratch above the named mode flags; as with the $c780 block,
; each mode reuses the bytes; variants belong to the owning bank.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Set while the target actors are live; UpdateMinigameTargets returns at once when it is clear
wMinigameTargetsActive:: db
; [8-bit] Grid cell the ball last bounced off, recorded by the Banana Bunch / Fruit Fantasy deflection handlers and read when the hit is scored
wMinigameLastHitCell:: db
; [24 bytes] The 3 x 8 target grid, one byte per cell. AreAllTargetsHit passes when all 24 are 1; ResetTargetGrid clears it a row at a time (+$07, +$0f, +$17 are the row ends)
wMinigameTargetGrid:: ds 24
	export_size wMinigameTargetGrid
NEXTU
; character select and new game (bank $1b)
; [8-bit] Cursor column carried in and out of RunCharacterSelectScreen, so the new-game roster loop resumes where the player left off
wCharSelectCursorCol:: db
; [8-bit] Cursor row, the same
wCharSelectCursorRow:: db
; [8 bytes] Two bytes per starting character (wCharRecordBuffer + 14 and + 12), collected by RunNewGameSetup before the roster is shown
wNewGameRosterFields:: ds 8
; [8-bit] Cleared by Unused_1b_RunStoryDataConfirmMenu as the prompt opens
wStoryDataPromptFlag:: db
ENDU

	ds 40
