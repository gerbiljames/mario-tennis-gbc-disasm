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

; [4096 bytes] 64 rows of 64 cells, one plane in each of WRAM banks $02 and $03 -- bank $03 the tile half, bank $02 the CGB attribute half. Both axes wrap within the buffer (the `and $3f` on each camera coordinate, `res 5, h / set 4, h` in BlitBGColumnFrom64). Only the top 32 rows carry map data; Unused_00_CopyMapToScrollBuffers clears the bottom half.
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

; [1024 bytes] Tile plane of the intro cutscene's character artwork, decompressed from DataPtr_IntroCharactersTilemap. The state inits QueueVRAMCopy slices of it ($d880, $d8c0) to $9c80/$9cc0 in VRAM bank 0, and the same offsets of wIntroCharactersAttrmap to VRAM bank 1.
; in WRAM banks $04
def wIntroCharactersTilemap equ $d800

; [576 bytes] Saved stat page, mirrored across WRAM banks $02/$03 like wCharDataPagePlane. SaveWorkTilemapToPage copies the live screen here when its selector is 2, once per bank; the three 36-byte rows sit 8 * TILEMAP_WIDTH apart and are what MainCharStatPageTilemapPatch* patch through ApplyTilemapPatchList.
def wCharDataPageSlot2 equ $da20

; [1024 bytes] CGB attribute plane for wIntroCharactersTilemap, cell for cell, from DataPtr_IntroCharactersAttrmap. Every copy out of it targets VRAM bank 1 at the address its tile-plane twin goes to in bank 0.
; in WRAM banks $04
def wIntroCharactersAttrmap equ $dc00

; [576 bytes] Saved stat page, mirrored across WRAM banks $02/$03 like wCharDataPagePlane. SaveWorkTilemapToPage copies the live screen here when its selector is 3 or more (0 saves into wCharDataPagePlane + 13 * TILEMAP_WIDTH), once per bank; the three 36-byte rows sit 8 * TILEMAP_WIDTH apart and are what MainCharStatPageTilemapPatch* patch through ApplyTilemapPatchList.
def wCharDataPageSlot3 equ $dc60

; $df00-$df97: the per-character match struct, one copy in each of WRAM banks
; $04-$07 (character index = bank - 4). The menu-screen symbols interleaved
; below share the same page in WRAM bank $05.
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer part)
def wCharPosX equ $df00

; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled; Continue and cancel skip to the result code. The menu's state lives in WRAM bank $05 over the idle far-P1 character struct, cleared on entry
def wClearStatusMode equ $df00

; [NUL-terminated string] Bank 5 scratch buffer that PushTextArgFetchedString fills (via FetchShortTextToBuffer) with a fetched short-text string, then pushes as a text argument; overlaps the idle far-P1 character struct at $df00
def wTextArgFetchBuffer equ $df00

; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the rank list and result-code row
def wClearStatusDoubles equ $df01

; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
def wClearStatusFormat equ $df02

; [3 bytes] Depth position (toward/away from net), same 24-bit fixed-point format; the two court sides carry opposite signs
def wCharPosDepth equ $df03

; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
def wClearStatusClass equ $df03

; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
def wClearStatusRank equ $df04

; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened, redrawn before every menu
def wClearStatusWindowId equ $df05

; [3 bytes] Height above court, same 24-bit fixed-point format (zeroed by SetCharPosAndTarget)
def wCharPosHeight equ $df06

; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
def wClearStatusResultCode equ $df06

; [8-bit] Serve/side role code (court-position record byte 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
def wCharServeRole equ $df09

; [8-bit] Court position code (court-position record byte 0-3; XORed with 3 on the tiebreak side-swap)
def wCharCourtPos equ $df0a

; [8-bit] Character index 0-3 (== WRAM bank - 4); bit 0 set = far side (used by CharPointEndReaction and the edge-arrow sprite)
def wCharIndex equ $df0b

; [8-bit] Facing this character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
def wCharBaseFacing equ $df0c

; [8-bit] Desired facing direction, eased toward by wCharFacingShown
def wCharFacingDesired equ $df0d

; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
def wCharFacingShown equ $df0e

; [8-bit] State flags; bit 2 = airborne (set on jump, cleared on landing; selects the shadow slot drawn)
def wCharFlags equ $df0f

; [8-bit] Frames the character is frozen for: UpdateCharStateMachine decrements it and returns without running the state, so nothing moves. SetCharState clears it, and FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
def wCharFreezeTimer equ $df10

; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds it with 5 on the first press and the state-machine dispatch counts it down
def wCharShotComboTimer equ $df11

; [8-bit] AI countdown -- the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses to press and release the toss button
def wAiActionTimer equ $df12

; [8-bit] Frames the AI holds its first shot button before adding the second. AiWaitThenPickShot sets it to 5 after AiPressFirstShotButton; AiSwingControlSingles/Doubles wait for it to reach 0 before AiPressSecondShotButton. Counts down only once wAiActionTimer is 0, so the two run in sequence.
def wAiSecondButtonDelay equ $df13

; [8-bit] Resolved SHOTTYPE_* for the swing about to happen, looked up by SelectServeShotType / SelectRallyShotType from the two buffered buttons
def wCharShotType equ $df14

; [8-bit] Animation id of the swing SelectForehandBackhand picked; the windup plays it + $08 and the contact phase plays it as-is
def wCharSwingAnim equ $df15

; [8-bit] First shot button of the current swing (1 = A, 2 = B), 0 = none. The pair with wCharShotButton2 indexes RallyShotTypeTable0/1, which is how A+B combinations become lobs, drops and power shots
def wCharShotButton1 equ $df16

; [8-bit] Second shot button, captured while wCharShotComboTimer is still running
def wCharShotButton2 equ $df17

; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
def wCharState equ $df18

; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it and each state's phase routine dispatches on it
def wCharStatePhase equ $df19

; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase (the AI's own counter, separate from wCharStatePhase)
def wAiPhase equ $df1a

; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, consumed by DrawCharSprite
def wCharSpriteFrame equ $df1b

; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
def wCharInputSource equ $df1e

; [8-bit] Input word ReadCharInput produces: held buttons in the high nibble, newly pressed in the low one (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); read with the PADB_* bits
def wCharInputBits equ $df1f

; [8-bit] Object-definition id SetupCharSpriteFromObjectDef was handed; stored and never read again
def wCharObjectDefId equ $df21

; [8-bit] ROM bank of this character's object definition, animation scripts and frame tables (GetPerspectiveScale, SetCharAnimation, StepCharAnimation). 0 = no object loaded; UpdateChar exits on it
def wCharObjectBank equ $df22

; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks to find a frame's tile data
def wCharFrameTablePtr equ $df24

; [16-bit] VRAM destination the character's frame tiles are copied to
def wCharFrameVramDest equ $df26

; [16-bit] Pointer (in wCharObjectBank) to the object's animation-pointer table; SetCharAnimation indexes it by animation id
def wCharAnimTablePtr equ $df28

; [16-bit] Start of the current animation script, which the $ff (jump) command rewinds to
def wCharAnimScriptBase equ $df2a

; [16-bit] Cursor into the current animation script. Commands are word-sized: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
def wCharAnimScriptPtr equ $df2c

; [8-bit] Animation currently playing; SetCharAnimation returns early when asked for the one already running
def wCharAnimId equ $df2e

; [8-bit] Frames left on the current animation frame; $ff means hold it indefinitely
def wCharAnimDelay equ $df2f

; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles and clears it
def wCharSpriteDirty equ $df30

; [8-bit] Facing octant 0-7, derived from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
def wCharFacingOctant equ $df32

; [8-bit] Frame id the animation script last selected
def wCharAnimFrame equ $df33

; [8-bit] First VRAM tile of this character's sprite, from a per-character-index table
def wCharTileBase equ $df36

; [8-bit] OAM attribute byte for the character. The low three bits are the CGB OBJ palette (wCharIndex + 4) and double as the tile-block index ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation script's $fb command toggles, and SetCharAnimation clears them with `and $0f`
def wCharSpriteAttr equ $df37

; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
def wCharShadowTablePtr equ $df38

; [8-bit] ROM bank holding the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
def wCharGfxBank equ $df3a

; [16-bit] X velocity (zeroed on placement and at point end)
def wCharVelX equ $df40

; [16-bit] Depth velocity
def wCharVelDepth equ $df42

; [16-bit] Height velocity
def wCharVelHeight equ $df44

; [16-bit] Walk-target X (integer part)
def wCharWalkTargetX equ $df46

; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward it, snapping when both deltas < $18 (CheckCharNearTarget)
def wCharWalkTargetDepth equ $df48

; [8-bit] Aim the player asked for with left/right at the moment of the shot, captured by CaptureServeAim / CaptureShotAim. GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
def wCharAimOffset equ $df4a

; [8-bit] Frames elapsed in the current swing phase, reset when the windup starts and incremented by the windup and contact phases
def wCharSwingFrames equ $df4b

; [8-bit] Set when this character's swing was a quick (uncharged) one. StartCharSwing writes it and ExecuteShot reads it to seed wShotWasQuickSwing, so the shot resolves without a charge bonus.
def wCharQuickSwing equ $df4c

; [8-bit] Shot button latched while the swing is held, written by CheckSwingRelease (cleared there when SELECT is down) and cleared by CharRallyReadyPhase. Never read.
def wCharSwingHoldButton equ $df4d

; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame (through `ld hl, $df4e`) and zeroes it on release or when SELECT is down. Never read.
def wCharSwingHoldFrames equ $df4e

; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it being held
def wCharLastShotButton equ $df4f

; [8-bit] Result of this frame's ball-geometry tests: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table). Rebuilt every frame by UpdateCharBallGeometry
def wCharBallReachFlags equ $df50

; [8-bit] Set while the charge flash is playing; cleared when the swing starts or aborts
def wCharChargeFlashOn equ $df51

; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2 and uses this latch to load each half's graphics once (LoadCharChargeFlashGfx / ReloadCharFrameGfx)
def wCharChargeFlashGfxLoaded equ $df52

; [8-bit] Last projected screen X (BuildCharSpriteSlots)
def wCharScreenX equ $df53

; [8-bit] Last projected screen Y
def wCharScreenY equ $df54

; [8-bit] Zeroed after each write of wCharWalkTargetX / wCharWalkTargetDepth. Never read.
def wCharWalkTargetFlag equ $df55

; [8-bit] Set to 1 by MoveCharTowardTarget after stepping toward the walk target; cleared each frame by UpdateCharStateMachine. UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
def wCharScriptedMove equ $df56

; [8-bit] Point result from this character's perspective (signed wPointWinLoseFlag)
def wCharPointResult equ $df57

; [8-bit] Shot buttons the AI decided to press this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
def wAiShotButtons equ $df58

; [8-bit] Countdown seeded from wAiTrackingParam when the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until it reaches 0 (or wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later.
def wAiTrackingCountdown equ $df59

; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0.
def wCharRallyReady equ $df5a

; [16-bit LE] Speed limit along the X axis: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027.
def wCharMaxSpeedX equ $df60

; [16-bit LE] Speed limit along the depth axis: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to the table's ten entries, so this axis alone gets $002b's bonus.
def wCharMaxSpeedDepth equ $df62

; [16-bit LE] Acceleration, from CharStatTable_07_1 via attribute-struct offset $0028. AccelerateCharDepth/AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX.
def wCharAcceleration equ $df64

; [16-bit LE] Deceleration when not accelerating, from CharStatTable_07_2 via attribute-struct offset $002a. The brake routines sign it against the velocity; one substitutes a flat $0040 when wCharFlags bit 1 is clear.
def wCharDeceleration equ $df66

; [8-bit] Max facing change per frame, easing wCharFacingShown toward wCharFacingDesired
def wCharFacingEaseRate equ $df68

; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the aim's base offset off centre. From CharStatTable_07_4 via attribute-struct offset $0025.
def wCharAimOffsetScale equ $df69

; [8-bit] Magnitude of the random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it. Higher = less accurate. From CharStatTable_07_5 via attribute-struct offset $0026.
def wCharAimJitterScale equ $df6a

; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 -> shot speed in LoadShotPlacementEntry
def wGroundStrokeSpeedIndex equ $df6b

; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
def wSmashServeSpeedIndex equ $df6c

; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
def wReachSpeedIndex equ $df6d

; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 -> target offsets in LoadShotPlacementEntry
def wTopspinPlacementIndex equ $df6e

; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
def wSlicePlacementIndex equ $df6f

; [16-bit] How far above or below the character the ball may be and still be hit; CheckCharBallContact compares |wBallRelCharHeight| against it. Loaded from the character attribute record +$10, minus $10
def wCharReachHeight equ $df70

; [16-bit] Lateral reach: CheckCharBallContact compares |wBallRelCharX| * 2 against it. Attribute record +$12
def wCharReachX equ $df72

; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
def wCharSmashJumpSpeed equ $df74

; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth through VectorFromLengthAndAngleRaw at the character's facing. Attribute record +$16
def wCharDiveSpeed equ $df76

; [8-bit] Character id InitChar was handed, before RemapExtendedCharId
def wCharId equ $df78

; [8-bit] Base frames the AI waits before reacting when the ball is within normal reach; AiSetReactionDelay adds a 0-3 random and stores wAiActionTimer. Attribute record +$1b
def wAiReactionDelayNear equ $df79

; [8-bit] Same, for a ball outside normal reach (wCharBallReachFlags bit 4 clear), so a stretching return can be made deliberately slower. Attribute record +$1c
def wAiReactionDelayFar equ $df7a

; [8-bit] How the AI chases the ball -- read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
def wAiTrackingParam equ $df7b

; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it, so a higher value places more shots. Attribute record +$1e
def wAiAimAwayChance equ $df7c

; [8-bit] AI serve/shot habit: the low nibble indexes ServePressTossPtrs for the toss timing, and AiPickShotButtons reads it too. Attribute record +$1f
def wAiServeStyle equ $df7d

; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx use it to find the sprite bank
def wCharSpriteSetId equ $df7e

; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); an RST00 jumptable index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
def wAiPositionStrategy equ $df7f

; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
def wCharSpriteSlot equ $df80

; [4 bytes] Frame descriptor the single-character screens park after the sprite slot: Unused_1a_DrawCharViewerCharSprite and the results/EXP screen drawers write eight bytes at wCharSpriteSlot -- the slot's [tile, attr, y, x], then wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (the Y and X offsets QueueSprite24x32 adds) and a depth key (slot * 8 + $80). Not written in a match
def wCharSpriteSlotFrame equ $df84

; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrink with jump height; drawn only while wCharFlags bit 2 set)
def wCharAirShadowSlot equ $df88

; [4 bytes] Sprite-slot record for the standing shadow (tile $58; flicker-transparency while grounded)
def wCharGroundShadowSlot equ $df8c

; [16-bit] Attribute word read from the character record +$19; StartCharSwing tests bit 7 of the low byte, and bits 0 and 1 of wCharSwingAttrWord + 1 select the lob and drop placement rows
def wCharSwingAttrWord equ $df90

; [8-bit] Placement-row index (d) into ShotPlacementDataLob (set from df91 bit 0)
def wLobPlacementIndex equ $df92

; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (set from df91 bit 1)
def wDropPlacementIndex equ $df93

; [8-bit] Attribute bits XORed into wCharSpriteAttr when the facing octant is 2 or 6, i.e. when the sprite is drawn mirrored
def wCharMirrorAttrMask equ $df94

; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
def wCharExpTier equ $df95

; [8-bit] Draw-order depth key ((depth*8)>>8 + $80); DrawActorsByDepth paints teammates back-to-front
def wCharDepthKey equ $df96

; The game progress screen (bank $1e) keeps its lists in WRAM bank $05's
; $df00 page.
; [1 byte] How many progress entries BuildVisibleProgressEntryList found unlocked
; in WRAM banks $05
def wProgressVisibleCount equ $df03

; [1 byte] The row the progress list is scrolled to, an index into wProgressVisibleEntries
; in WRAM banks $05
def wProgressListIndex equ $df05

; [48 bytes] Per progress entry, 1 if its flag is set (RunRewardCategoryList); BuildVisibleProgressEntryList packs the set ones into wProgressVisibleEntries
; in WRAM banks $05
def wProgressEntryUnlocked equ $df10

; [37 bytes] Per progress entry, whether it has been earned (BuildProgressEntryEarnedTable, read by GetProgressEntryEarned)
; in WRAM banks $05
def wProgressEntryEarned equ $df40

; [48 bytes] The entry ids to draw, in order, $ff-filled past wProgressVisibleCount
; in WRAM banks $05
def wProgressVisibleEntries equ $df70
