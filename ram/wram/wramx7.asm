SECTION "WRAMX bank 7", WRAMX[$d000], BANK[7]

; WRAMX bank 7 at a glance:
;
;   $d000-$d01f  sound driver
;   $d02a-$d219  sound engine
;   $d300-$daff  text glyph tiles / save-block staging
;   $db26-$db27  story-data confirm menu
;   $de00-$de1f  minigame record parameter
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Where the shared HRAM pool goes during an audio update. (Bank $05 and the
; boot path also load $d000 with WRAM bank $07 selected, as the base of a
; 4 KiB clear of the whole bank.)
; sound driver (bank 0)
; [32 bytes] Copy of $ffd0-$ffef saved by RunSoundEngine on entry and restored on exit. The driver keeps its channel state in that HRAM window, so four other subsystems can keep their own bytes there across an audio update (see the $ffd0 union)
wSndHramSave:: ds 32
	export_size wSndHramSave

	ds 10

; Sound engine channel state. (The same offsets in WRAM bank $06 are the
; palette fade engine and screen state.)
; sound engine (bank 0)
	ds 214
; [192 bytes] Six 32-byte channel state blocks (channels 0-1 sound effects, 2-5 music; StopMusic clears the four from +64). The active channel's block is mirrored into HRAM $ffd0 each pass; first word = script pointer ($ffff = idle)
wSndChannels:: ds 192
; [72 bytes] Per-channel loop bookkeeping (counter + return pointer per loop level); base resolved by GetChannelLoopSlot
wSndLoopSlots:: ds 72
; [8-bit] Bitmask of channels already serviced/keyed this update pass (AbortIfChannelTriggered tests it; folded into rAUDTERM at the end)
wSndActiveMask:: db
; [8-bit] Shadow of rAUDTERM: per-channel left/right output enable bits accumulated across channels
wSndPanShadow:: db
; [8-bit] Current channel type (0=square1/sweep, 1=square2, 2=wave, 3=noise)
wSndChannelType:: db
; [8-bit] Current channel's stereo output bit-pair (ch1=$11 .. ch4=$88), used for active-channel tracking
wSndChannelBits:: db
; [8-bit] Same bit-pair as wSndChannelBits, masked against hSndPanMask to build wSndPanShadow
wSndChannelPanMask:: db
; [8-bit] Current channel's APU register offset (type*5); WriteChannelReg forms rAUD via $ff10+this+reg
wSndRegBase:: db
; [8-bit] Free-running update counter; low nibble supplies the vibrato phase in TickVibrato
wSndFrameCounter:: db
; [8-bit] Index (0-5) of the channel currently being updated
wSndChannelIndex:: db
	ds 2
; [8-bit] Pending channel-update request: mask of channels to reconfigure (SetChannelUpdateRequest)
wSndUpdateReqMask:: db
; [8-bit] Value applied by the pending channel-update request (low nibble)
wSndUpdateReqData:: db
; [8-bit] Accumulator of channels that have acknowledged the pending update request
wSndUpdateReqAck:: db
; [8-bit] Channel index the update pass starts from (normally 0)
wSndFirstChannel:: db
	ds 1
; [8-bit] Wave-pattern id currently loaded into wave RAM (change detection for the wave channel)
wSndLoadedWaveId:: db
; [8-bit] Global transpose added to note ids (cmd $a9 $fe/$f2/$f3)
wSndTranspose:: db
; [8-bit] Non-zero to force the wave channel to reload its pattern on the next note
wSndWaveReloadPending:: db

	ds 230

; Two overlays on this 2 KiB: the text engine's glyph tiles (uploaded to
; VRAM $8800), and the bank $03 save engine's block staging (a save never
; runs while text is being composed). Banks $05/$3f use $d3xx-$dafx literals
; for other buffers in other WRAM banks too.
; Bank $03's debug save editor hex-dumps the region from $d300. Its "wipe
; the block" branch clears from $d300 and its slot-3 branch edits $d300+,
; both $200 short of where Unused_03_ReadCurrentSlotBlock puts the block.
UNION
; text glyph tiles (banks $05/$3f)
; [2048 bytes] 128 proportional-font glyph tiles, 1:1 with VRAM $8800 (tile n at + n * TILE_SIZE). PlotGlyphRow adds the pen position with a signed shift (sra d / rr e), so a negative pen writes below the base: the lesson menu's second page puts five glyph tiles at $d2b0-$d2ff, harmless since bank $07 is unused there (docs/bugs.md). ClearGlyphBuffer fills all 128 with the blank glyph; UploadGlyphBufferFull sends the first 80 as five 256-byte pages; UploadGlyphTilesPartial / Unused_05_UploadGlyphTileRange send narrower runs
wGlyphTileBuffer:: ds 2048
NEXTU
; save-block staging (bank $03)
	ds 384
; [32 bytes] Image of a minigame-record save block ($38 + story slot): 16 16-bit records by record id. ReadMinigameRecord zeroes it, reads the block over it and returns record b in wMinigameRecordValue; UpdateMinigameRecord does the reverse and verifies the block
wMinigameRecordBlock:: ds 32
	ds 96
; [512 bytes] Image of the $200-byte block the save engine is working on: the story slot block for Unused_03_ReadCurrentSlotBlock / Unused_03_WriteCurrentSlotBlock (ids from StorySlotBlockIds_03), or block $0b for the N64 transfer records. ApplyN64RecordsUnlockFlags and UpdateUnlockablesSaveBlock use the unlock bytes at +$00-$07
wSaveBlockBuffer:: ds 512
ENDU

	ds 38

; State for a stubbed-out frame task.
; story-data confirm menu (bank $1b)
; [2 bytes] Unused_1b_RunStoryDataConfirmMenu clears +$00, sets +$01 to $0c and registers StubNop_1b_09 as a frame task, whose body is a bare ret, so neither byte is read
wStubbedPromptTaskState:: dw

	ds 728

; Minigame record parameter. (WRAM bank $04 has the match ball sprite slots
; at this address.)
; minigame record parameter (WRAM bank $07)
; [16-bit] In/out parameter of ReadMinigameRecord / UpdateMinigameRecord: one record's high score, read from or written into wMinigameRecordBlock. Callers select WRAM bank $07 around it
wMinigameRecordValue:: dw
	ds 30

SECTION "WRAMX bank 7 $df00", WRAMX[$df00], BANK[7]

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 7's. Code
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
w7ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w7ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w7ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w7ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w7ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w7ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w7ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w7TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w7CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w7CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w7CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w7CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w7CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w7CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w7CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w7CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w7CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w7CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w7CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w7CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w7AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w7AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w7CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w7CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w7CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w7CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w7CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w7CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w7AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w7CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w7CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w7CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w7CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w7CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w7CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w7CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w7CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w7CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w7CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w7CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w7CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w7CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w7CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w7CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w7CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w7CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w7CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w7CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w7CharVelX:: dw
; [16-bit] Depth velocity
w7CharVelDepth:: dw
; [16-bit] Height velocity
w7CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w7CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w7CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w7CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w7CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w7CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w7CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w7CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w7CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w7CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w7CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w7CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w7CharScreenX:: db
; [8-bit] Last projected screen Y
w7CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w7CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w7CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w7CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w7AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w7AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w7CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w7CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w7CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w7CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w7CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w7CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w7CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w7CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w7GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w7SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w7ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w7TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w7SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w7CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w7CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w7CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w7CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w7CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w7AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w7AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w7AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w7AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w7AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w7CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w7AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w7CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w7CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w7CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w7CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w7CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w7LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w7DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w7CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w7CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w7CharDepthKey:: db
ENDU
