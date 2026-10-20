; RAM structures declared once and laid out per copy.

; A bit array for `\1` flags.
MACRO flag_array
	ds ((\1) + 7) / 8
ENDM

; One $40-byte character record (the CHARREC_* fields), labelled
; <prefix><Field>; each field is checked against its CHARREC_* offset.
MACRO char_record
\1::
\1Name::          ds 7
\1NamePad::       ds 3
\1LinkCourtMask:: db
\1Char::          db
\1Palette::       db
\1Gender::        db
\1LeftHanded::    db
\1Physics::       db
\1Reach::         ds 8
\1Level::         db
\1Swing::         dw
\1AiParams::      ds 4
\1Difficulty::    db
\1Stats::
\1TopStat::       db
\1SliceStat::     db
\1ServeStat::     db
\1StrokeStat::    db
\1VolleyStat::    db
\1AngleStat::     db
\1PlacementStat:: db
\1SpeedStat::     db
\1DashStat::      db
\1ReactionStat::  db
\1StopStat::      db
\1SpeedBonus::    db
\1Exp::           ds 3
\1BuildKind::     db
\1PhysicsTemplate:: ds 8
\1TrainLevels::
\1SpinLevel::     db
\1PowerLevel::    db
\1ControlLevel::  db
\1SpeedLevel::    db
\1Equipment::     db
	ds 3
	ASSERT @ - \1 == CHAR_RECORD_SIZE
	ASSERT \1LinkCourtMask - \1 == CHARREC_LINK_COURT_MASK
	ASSERT \1Char - \1 == CHARREC_CHAR
	ASSERT \1Palette - \1 == CHARREC_PALETTE
	ASSERT \1Gender - \1 == CHARREC_GENDER
	ASSERT \1LeftHanded - \1 == CHARREC_LEFT_HANDED
	ASSERT \1Physics - \1 == CHARREC_PHYSICS
	ASSERT \1Reach - \1 == CHARREC_REACH
	ASSERT \1Level - \1 == CHARREC_LEVEL
	ASSERT \1Swing - \1 == CHARREC_SWING
	ASSERT \1AiParams - \1 == CHARREC_AI_PARAMS
	ASSERT \1Difficulty - \1 == CHARREC_DIFFICULTY
	ASSERT \1TopStat - \1 == CHARREC_STAT_TOP
	ASSERT \1StopStat - \1 == CHARREC_STAT_STOP
	ASSERT \1SpeedBonus - \1 == CHARREC_SPEED_BONUS
	ASSERT \1Exp - \1 == CHARREC_EXP
	ASSERT \1BuildKind - \1 == CHARREC_BUILD_KIND
	ASSERT \1PhysicsTemplate - \1 == CHARREC_PHYSICS_TEMPLATE
	ASSERT \1TrainLevels - \1 == CHARREC_TRAIN_LEVELS
	ASSERT \1Equipment - \1 == CHARREC_EQUIPMENT
ENDM

; One on-court character's match statistics, labelled <prefix><Stat>. The
; four sit MATCH_STATS_STRIDE bytes apart, indexed by wLastShotCharIndex.
MACRO match_stats
\1ServiceAces::     db
\1ReturnAces::      db
\1SmashAces::       db
\1LobShotWinners::  db
\1DropShotWinners:: db
\1Faults::          db
\1DoubleFaults::    db
ENDM

; The match engine's per-character struct at $df00, labelled <prefix><Field>,
; with <prefix>CharStruct naming the whole struct.
; WRAM banks $04-$07 each hold one copy, bank = character: 4 near-P1, 5
; far-P1, 6 near-partner, 7 far-partner. Each bank file declares its copy
; under a bank-tagged prefix (w4-w7) so the symbol file resolves the right
; one in a debugger; code uses the untagged names (include/ram_mirrored.inc),
; because the bank is chosen at run time. Bank $38's
; UpdateCharSelectCharSprite and TickCharSelectIdleAnim drive the same struct
; once per preview character, selecting WRAM banks $04-$07 in turn (bank
; $38's own $df00 is wCharGridHandedness in WRAM bank $03).
MACRO match_char_struct
\1CharStruct::
UNION
; clear-status developer menu (bank $0a): only bank $05's copy, over the idle far-P1 struct
; [8-bit] RunClearStatusSetupMenu's first choice (Text_MenuSetContinue): 0 Set, 1 Continue, $ff cancelled; Continue and cancel go straight to the result code. Cleared 32 bytes at a time on entry
\1ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
\1ClearStatusDoubles:: db
; [8-bit] Second menu (Text_MenuMinigameOrRanking): 0 Mini-Game, 1 Ranking Match; $ff steps back
\1ClearStatusFormat:: db
; [8-bit] Third menu (Text_MenuClasses): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
\1ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
\1ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
\1ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
\1ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks): only bank $05's copy, over the idle far-P1 struct
; [NUL-terminated string] Buffer PushShortTextArg_12 fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument
\1TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
\1CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
\1CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
\1CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
\1CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
\1CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
\1CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
\1CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
\1CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
\1CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
\1CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
\1CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
\1CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
\1AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
\1AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
\1CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
\1CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyReachShotTypeTable/RallyStandardShotTypeTable, turning A+B combinations into lobs, drops and power shots
\1CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
\1CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
\1CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
\1CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
\1AiPhase:: db
; [3 bytes] The current frame's placement, copied from its *FramePlace record by QueueCharFrameTiles: X offset, Y offset, then the size flag DrawCharSprite dispatches on (1 = 32 wide)
\1CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
\1CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
\1CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
\1CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by QueueCharFrameTiles and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
\1CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table QueueCharFrameTiles walks for a frame's tile data
\1CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
\1CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
\1CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
\1CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
\1CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
\1CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
\1CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
\1CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
\1CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
\1CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
\1CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4), the slot ReloadCharPalette loads into; the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
\1CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the character's *FramePlace table, read by QueueCharFrameTiles
\1CharFramePlaceTablePtr:: dw
; [8-bit] Index into CharObjPalettes_01 of the character's OBJ palette (from OBJDEF_ATTR); LoadCharChargeFlashPalette loads entry + 8, the flash variant
\1CharPaletteId:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
\1CharVelX:: dw
; [16-bit] Depth velocity
\1CharVelDepth:: dw
; [16-bit] Height velocity
\1CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
\1CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
\1CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
\1CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
\1CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing; its only reader copies it into the write-only wShotWasQuickSwing (ExecuteShot), so it has no effect
\1CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
\1CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
\1CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
\1CharLastShotButton:: db
; [8-bit] This frame's ball-geometry and steering flags (BALLREACHB_*), rebuilt by UpdateCharBallGeometry
\1CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
\1CharChargeFlashOn:: db
; [8-bit] 1 while the flash palette is loaded. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2 and uses this latch to load each half's palette once (LoadCharChargeFlashPalette / ReloadCharPalette)
\1CharChargeFlashPalLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
\1CharScreenX:: db
; [8-bit] Last projected screen Y
\1CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
\1CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
\1CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
\1CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
\1AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until BALLREACHB_SWING_RANGE says the ball is in reach), so a larger parameter commits later
\1AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
\1CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharMaxSpeedByStat indexed by attribute byte $0027
\1CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharMaxSpeedByStat with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
\1CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharAccelByStat via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
\1CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharDecelByStat via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
\1CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
\1CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharAimOffsetScaleByStat via attribute offset $0025
\1CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharAimJitterScaleByStat via attribute offset $0026
\1CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
\1GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
\1SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
\1ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
\1TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
\1SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
\1CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
\1CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
\1CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
\1CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
\1CharId:: db
; [8-bit] Base frames the AI waits before reacting while near the net (BALLREACHB_NEAR_NET set); AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
\1AiReactionDelayNear:: db
; [8-bit] The same away from the net (BALLREACHB_NEAR_NET clear). Attribute record +$1c
\1AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
\1AiTrackingParam:: db
; [8-bit] RNG threshold in AiRollAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
\1AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
\1AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
\1CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
\1AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] (SPRSLOT_*) for the character sprite
\1CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
\1CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
\1CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
\1CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
\1CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
\1LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
\1DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
\1CharMirrorAttrMask:: db
; [8-bit] Character level, copied from the match record (CHARREC_LEVEL); LookupExpTierForChar turns it into an EXP tier
\1CharLevel:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
\1CharDepthKey:: db
ENDU
ENDM
