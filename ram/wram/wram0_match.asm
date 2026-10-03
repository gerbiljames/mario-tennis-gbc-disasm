; WRAM0 $c400-$c4ff: match ball, physics and shot state.

; [16-bit] Fraction of the ball X position (16.16 fixed point). The three axes form one 12-byte block from here: SetBallPosition writes each as zero fraction plus integer, and StepBallPhysics copies the block to wBallPrevXFrac before adding velocity
wBallXFrac:: dw

; [16-bit] Ball X position, integer part (lateral, signed)
wBallX:: dw

; [16-bit] Fractional half of wBallDepth
wBallDepthFrac:: dw

; [16-bit] Ball depth position, integer part (signed, net at 0)
wBallDepth:: dw

; [16-bit] Fractional half of wBallHeight
wBallHeightFrac:: dw

; [16-bit] Ball height above the court, integer part
wBallHeight:: dw

; [16-bit] Vertical angle of the ball's velocity: AngleFromVector16(wBallVelocityHeight, wBallSpeedHorizontal), written by UpdateBallAnglesAndSpeed ($100 per turn)
wBallPitchAngle:: dw

; [16-bit] Horizontal heading of the ball's velocity ($100 per turn, as wShotAimAngle): AngleFromVector16(wBallVelocityX, wBallVelocityDepth), written by UpdateBallAnglesAndSpeed. Read by ApplyBallSpin (to put the topspin term back on X/depth) and PredictBallLateralOffset
wBallHeadingAngle:: dw

; [16-bit] Start-of-frame copy of the 12-byte position block, made by StepBallPhysics before integrating; this and the five words after it mirror wBallXFrac onward
wBallPrevXFrac:: dw

; [16-bit] Ball X at the start of the frame (integer part)
wBallPrevX:: dw

; [16-bit] Fractional half of wBallPrevDepth
wBallPrevDepthFrac:: dw

; [16-bit] Ball depth at the start of the frame (integer part); the only part of the copy that is read. HandleBallNetCrossing compares its sign with wBallDepth to detect the net crossing; DidBallCrossGate reads the word
wBallPrevDepth:: dw

; [16-bit] Fractional half of wBallPrevHeight
wBallPrevHeightFrac:: dw

; [16-bit] Ball height at the start of the frame (integer part)
wBallPrevHeight:: dw

; [16-bit] Top/backspin coefficient (rotation about the lateral axis), set from bc by Unused_08_SetBallSpinComponents. While nonzero, ApplyBallSpin rotates the (horizontal speed, vertical velocity) pair by it: wBallVelocityHeight * k goes (negated) into the X/depth velocities along wBallHeadingAngle, wBallSpeedHorizontal * k into the height velocity. Decays by 3/256 per frame
wBallTopspin:: dw

; [16-bit] Sidespin/curve coefficient (rotation about the vertical axis), set from de by Unused_08_SetBallSpinComponents. While nonzero, ApplyBallSpin adds +k*wBallVelocityDepth to the X velocity and -k*wBallVelocityX to the depth velocity, curving the ball; decays by 3/256 per frame
wBallSideSpin:: dw

; [8-bit] Fraction byte of wBallVelocityX. The velocity components are 8.16 fixed point, each written as zero fraction plus 16-bit integer by SetBallVelocityPolar
wBallVelocityXFrac:: db

; [16-bit] Ball X velocity, integer part; decayed by ApplyBallAirDrag
wBallVelocityX:: dw

; [8-bit] Fraction byte of wBallVelocityDepth
wBallVelocityDepthFrac:: db

; [16-bit] Ball depth velocity, integer part; curved by ApplyBallSpin
wBallVelocityDepth:: dw

; [8-bit] Fraction byte of wBallVelocityHeight
wBallVelocityHeightFrac:: db

; [16-bit] Ball vertical velocity, integer part
wBallVelocityHeight:: dw

; [8-bit] Fraction byte of wBallSpeedHorizontal
wBallSpeedHorizontalFrac:: db

; [16-bit] Magnitude of the ball's horizontal (X, depth) velocity, integer part: VectorLengthFromAngle(wBallHeadingAngle, wBallVelocityDepth, wBallVelocityX), written by UpdateBallAnglesAndSpeed. ApplyBallSpin uses it in the topspin lift term
wBallSpeedHorizontal:: dw

; [16-bit] Ball's 3D speed: VectorLengthFromAngle of wBallVelocityHeight against wBallSpeedHorizontal, recomputed with the velocity. ApplyBallAirDrag uses the top nibble of |high byte| as the drag-table index
wBallSpeed3D:: dw
	ds 2

; [16-bit] World X the shot is aimed at (wBallX units), from ComputeShotTargetX in ComputeShotTrajectory; copied to wBallTargetX and drawn as the aim marker sprite in bank $08. Cleared by ResetBallState
wShotAimTargetX:: dw

; [16-bit] World depth the shot is aimed at (net at 0, sign corrected for the hitter's side), written by ComputeShotTrajectory; copied to wBallTargetDepth and used for the aim marker
wShotAimTargetDepth:: dw

; [16-bit] wShotAimTargetX - wBallX, the lateral leg of the ball->target vector, written by ComputeShotTrajectory. Read by every court bank's SetBallTargetByPrediction and the trajectory-length path ($20:$416a, VectorLengthFromAngle with wShotAimDeltaDepth)
wShotAimDeltaX:: dw

; [16-bit] wShotAimTargetDepth - wBallDepth, the depth leg, written by ComputeShotTrajectory and fed to AngleFromVector16 with wShotAimDeltaX to make wShotAimAngle; also read by the court banks' trajectory-length code
wShotAimDeltaDepth:: dw
	ds 2

; [16-bit] Aim angle of the shot being launched (high byte = angle, $100 per turn; low byte = fraction, top nibble used by MulSinCos); projected from ball position into wBallTargetX/Depth
wShotAimAngle:: dw
	ds 2

; [16-bit] Base lateral aim spread for a rally shot's target, set at match init: $0220 singles, $0320 doubles. ComputeAimBaseOffset returns (this + |wCharPosDepth|/8) scaled by the character's aim stat $df69, which ComputeShotTargetX adds to or subtracts from wBallX before clamping
wAimSpreadBase:: dw

; [16-bit] Match camera current X (projected space). SnapCameraTo sets it with the target; UpdateMatchCamera eases it toward wMatchCameraTargetX and derives wCameraOffsetX from it
wMatchCameraX:: dw

; [16-bit] Match camera current Y (projected space); eased toward wMatchCameraTargetY, shifted into wCameraOffsetY
wMatchCameraY:: dw

; [16-bit] Match camera target X, written by SetCameraTarget and SnapCameraTo (and bank $0d's SnapCameraTo_0d), and every frame from wBallGroundProjX while wCameraFollowBall is set. UpdateMatchCamera steps wMatchCameraX toward it by $0040, snapping on overshoot
wMatchCameraTargetX:: dw

; [16-bit] Match camera target Y; same writers and stepping as wMatchCameraTargetX
wMatchCameraTargetY:: dw

; [16-bit] wBallX minus the current character's X, signed; written by UpdateCharBallGeometry for the mapped character bank. Read by AiSteerTowardBall and the swing/contact range checks in bank $08
wBallRelCharX:: dw

; [16-bit] Ball depth minus the current character's depth, signed. Read by CheckBallContactWindow, CheckBallInSwingRange, Unused_08_ComputeBallEtaToChar (divided by wBallVelocityDepth for frames to arrival), PredictBallLateralOffset and the AI
wBallRelCharDepth:: dw

; [16-bit] Ball height minus the current character's height, signed; the reach/height gates compare |value| with the character's reach field $df70
wBallRelCharHeight:: dw
	ds 2

; [16-bit] Projected ball target/landing X (same world units as wBallX)
wBallTargetX:: dw

; [16-bit] Projected ball target/landing depth (companion to wBallTargetX; net at 0)
wBallTargetDepth:: dw

; [16-bit] The ball's X velocity as the shot was struck, saved by ExecuteShot
wShotRecoilVelocityX:: dw

; [16-bit] The same for depth velocity. ApplyShotRecoil scales the pair by the ShotRecoilTable_07 factor for the shot type and pushes the striker back along it
wShotRecoilVelocityDepth:: dw

; [16-bit] Shot speed as FinalizeShotSpeed leaves it, after momentum and the character-flag penalty and clamped up to $0100. Write-only, like the three term traces above it
wShotSpeedFinal:: dw

; [16-bit] The incoming ball's contribution to the shot speed, as AddBallSpeedEighth computed it (signed, then made positive). Write-only
wShotSpeedBallTerm:: dw

; [16-bit] The striker's own depth velocity contribution, halved and signed by which end of the court the character is on (AddPlayerMomentumToShot). Write-only
wShotSpeedMomentumTerm:: dw

; [16-bit] The charge bonus AddChargeSpeedBonusHalf added, scaled $40 or $20 by sign. Write-only; with the three above it, the shot-speed sum broken into terms, none read back
wShotSpeedChargeTerm:: dw

; [16-bit] Projected X of the ball-bounce dust effect (cached at bounce time)
wBounceEffectX:: dw

; [16-bit] Projected Y of the ball-bounce dust effect
wBounceEffectY:: dw

; [16-bit] Projected X of the swing-hit effect (cached at hit time)
wHitEffectX:: dw

; [16-bit] Projected Y of the swing-hit effect
wHitEffectY:: dw
	ds 4

; [16-bit] Screen-space X of the ball's ground (shadow) position, ProjectWorldToScreen(wBallX, wBallDepth) in BuildBallShadowSlot. UpdateMatchCamera copies X/Y into the camera target while wCameraFollowBall is set
wBallGroundProjX:: dw

; [16-bit] Screen-space Y of the ball's ground position
wBallGroundProjY:: dw

; [16-bit] Negated wBallHeight, the drop the trajectory solver must cover; written by ComputeShotTrajectory
wShotSolverNegHeight:: dw

; [8-bit] Aim row (0-$1f) each shot bank's SetBallTargetFromAim derives from the ball's angle to index its per-aim target tables. Write-only; the value is used from a
wShotAimRow:: db
	ds 1

; [16-bit] The magnitude passed to SetBallVelocityPolar, saved before it is split into X/depth. Write-only
wBallVelocityPolarLength:: dw

; [16-bit] First word of the shot-table entry SetBallTargetByPrediction_* is using, stored before the aim delta is applied. Write-only
wShotPredictionEntry:: dw

; [16-bit] Camera X offset added before the <<3 screen projection (ApplyCameraProjection)
wCameraOffsetX:: dw

; [16-bit] Camera Y offset added before the <<3 screen projection
wCameraOffsetY:: dw

; [16-bit] Minigames - Current Score
wMinigamesCurrentScore:: dw

; [16-bit] Minigames - Target Score
wMinigamesTargetScore:: dw

; [16-bit] Projected X of the lob landing marker
wLandingMarkerX:: dw

; [16-bit] Projected Y of the lob landing marker
wLandingMarkerY:: dw

; [16-bit] In-bounds lateral limit, stored negated: $fe50 (-$1b0) singles, $fdc0 (-$240) doubles. CheckBallOutOfBounds adds it to |wBallX| and treats carry as out; ClampShotTargetX clamps the aim target to (-value - $20); ComputeShotTrajectory uses it to shorten wShotDistMax when the aim line would leave the court sideways
wCourtLimitX:: dw

; [16-bit] In-bounds depth limit, stored negated: $fb20 (-$4e0, the baseline) normally, $fd60 (-$2a0, the service line) while a serve is in flight. CheckBallOutOfBounds adds it to |wBallDepth| and sets bit 1 of the out mask on carry
wCourtLimitDepth:: dw

; [16-bit] Net height in ball-height units: $0060 in a match, $0000 in the netless solo minigames. When the ball crosses depth 0, HandleBallNetCrossing adds it to wBallHeight (negative is up); a non-negative sum means the ball clipped the net: sound $5a, bounce effect, wBallHasBouncedFlag set, depth position and velocity negated
wNetHeight:: dw

; [16-bit] Shot solver: distance along the aim line from the ball to depth $0140 past the net, (|wBallDepth| + $0140) / sin(wShotAimAngle), from ComputeShotTrajectory. Every court bank's ApplyBallTrajectory passes it to BallTrajEntryPtr6/4 as the starting trajectory-table row
wShotDistMin:: dw

; [16-bit] Shot solver: distance along the aim line to depth $0480 (just inside the baseline), shortened to where the line would cross the sideline (wCourtLimitX + $0020) if that comes first. The court banks clamp the ball->target length to it before picking a trajectory row
wShotDistMax:: dw

; [8-bit] wShotDistMin >> 6: first trajectory-table row to consider; the loop start for each court bank's SeekBallTrajEntry6/4
wShotTrajRowMin:: db

; [8-bit] wShotDistMax >> 6: last trajectory row SeekBallTrajEntry6/4 may reach; rewritten when the sideline clamp shortens wShotDistMax
wShotTrajRowMax:: db

; [8-bit] Shot buttons of the swing at contact: wCharShotButton1 in the high nibble, wCharShotButton2 in the low. The bank $0d minigame shot tables match required combinations against it
wLastShotButtons:: db

; [8-bit] Winning-shot type for the point just won: 0 = none, 1 = service ace, 2 = return ace, 3 = smash ace, 4 = lob winner, 5 = drop-shot winner. Reset in the per-point state clear; set by the Record*Stat functions, which also credit the wCharacterN stat. The winner banner is ShowCourtBanner(value + $17), banner ids 24-28
wPointWinnerShotType:: db

; [8-bit] Companion to wMatchAbortFlag ($ff from every quit-menu action): StepMatchFrames returns immediately and result jingles are suppressed
wMatchFramesAbort:: db

; [8-bit] hLinkState when RunMatchPlayLoop returned, taken before EndLinkSession. Write-only
wMatchEndLinkState:: db

; [8-bit] Scoreboard layout/caption style, 0-7, chosen by SelectScoreboardLayout from wOnCourtCharCount (singles/doubles) or, for minigames ($c8f5 == 2), from $c7ba/$c7bb as 3/4/7. Jumptable index for DrawScoreboardCaption and DrawScoreboard, table index elsewhere in bank $06; bank $09's serve-indicator spawner checks it against 3
wScoreboardLayout:: db
	ds 11

; [8-bit] Shot-type code of the shot in flight (rst00 jumptable in ExecuteShot; $09 smash, $0a lob, $0b drop - checked by RecordSmashAceStat/RecordLobWinnerStat/RecordDropShotWinnerStat)
wCurrentShotType:: db

; [8-bit] Recoil kind for the shot in flight, from the ShotTypePresets_07 record (ApplyShotTypePresets); ApplyShotRecoil indexes ShotRecoilVarPtrs_07 with it
wShotRecoilVariant:: db

; [8-bit] Charge level of the shot being executed, 0-$3f, from the hitter's $df4b clamped by ExecuteShot. Scales shot speed in AddChargeSpeedBonus / AddChargeSpeedBonusHalf (offset by $ffe0 first) and WeakenShotByCharge / BoostShotByCharge; $3f (fully charged) picks the special hit flash over the normal spark
wShotChargeLevel:: db

; [8-bit] The striker's wCharQuickSwing copied by ExecuteShot, so the shot keeps the value the swing started with
wShotWasQuickSwing:: db

; [8-bit] The striker's wCharAimOffset at contact, stored by ExecuteShot. Write-only
wLastShotAimOffset:: db

; [8-bit] Nonzero when the shot just struck is a special/power hit. Cleared at the top of ExecuteShot; set to 1 when the ball is struck above height $0140, and from the 32-entry toss-height table on serves. Forces the special-shot flash (wSpecialHitTimer) over the normal spark, and on the rally's first shot shows court banner $0e
wSpecialShotFlag:: db

; [8-bit] Set to 1 by each ExecuteShotPower* variant, cleared by ExecuteShot at every swing: marks the power version of topspin/slice/flat. Write-only
wLastShotWasPowerShot:: db

; [8-bit] When 1, the shot's lateral aim offsets are negated. ExecuteShot sets it to the parity of four conditions (hitter state $df15 == 6, == $0a, $df94 nonzero, wRallyLength == 0). LoadShotPlacementEntry negates the placement angle offset with it, and every court bank's SetBallVelocityFromEntry6 negates the entry's angle delta before adding it to wShotAimAngle
wShotAimMirror:: db

; [8-bit] Frames left of the ball-bounce dust effect (starts at $14)
wBounceEffectTimer:: db

; [8-bit] Frames left of the normal swing-hit spark (starts at $10)
wHitSparkTimer:: db

; [8-bit] Frames left of the special-shot hit flash (starts at $10; drives the bank $28 screen effect)
wSpecialHitTimer:: db

; [8-bit] Frames left of the ball-hit-a-character effect; started at $28 by StartBallTouchCharEffect, ticked and used as animation index by DrawBallTouchCharEffect
wBallTouchCharTimer:: db

; [8-bit] Court horizontal bounce damping (8-bit fraction, e.g. $cd = 0.80 on court 0), loaded per court from a 4-byte-per-court table at $08:$5dc4. ApplyCourtBounceDamping multiplies the X and depth velocities by it
wCourtSurfaceFriction:: db

; [8-bit] Court vertical restitution (8-bit fraction) from the same per-court record; ApplyCourtBounceDamping multiplies the height velocity by it
wCourtSurfaceBounce:: db

; [8-bit] Set to 1 when the ball reaches a character's body (which also sets bit 2 of $df50 and forces the character to state 0). HandleBallTouchCharEvent consumes it: sound $77, the effect, ApplyBallTouchOutcome. Cleared by ResetPointState
wBallTouchCharFlag:: db

; [8-bit] Character index (0-3) the ball touched, from wCharIndex. DrawBallTouchCharEffect maps it through CharIndexToWramBank for the screen position; its low bit gives the point outcome's +1/-1 side sign
wBallTouchCharIndex:: db

; [8-bit] Court quadrant under the ball: bit 1 = sign of wBallDepth (net side), bit 0 = sign of wBallX (lateral half). Rebuilt every frame by StepBallPhysics; forced to $02 by the bank $0d wall-practice setup
wBallCourtQuadrant:: db

; [8-bit] CheckBallOutOfBounds' verdict bits for the frame (which bound the ball passed). Write-only; the caller uses the returned a
wBallOutOfBoundsBits:: db

; [8-bit] Bounces since the ball was last struck, saturating at $0a. Zeroed by HandleBallHitEvent and ResetPointState, incremented by HandleBallBounceEvent. Tested for == 1 (first bounce) by EvaluateBounceOutcome, the fault check, the bank $0b drill graders and bank $0d
wBallBounceCount:: db

; [8-bit] Per-frame bounce event, cleared at the top of StepBallPhysics: 1 = ball reached the ground, 2 = ball bounced off a court fence/wall (BounceBallOffCourtFences). HandleBallBounceEvent returns at once on 0
wBallBounceEvent:: db

; [8-bit] 1 for the single frame the ball crosses the net plane; set and cleared by HandleBallNetCrossing. Read by TickRallyTimers, AiTrackBallPhase and CheckBallHitsMinigameTarget / CheckBallHitsMinigameTargetAlt
wBallCrossedNetFlag:: db

; [8-bit] Frames the ball has spent past the net this point: TickRallyTimers increments it while wBallCrossedNetFlag is set, capped at $64; ResetPointState clears it. Read only by its own cap test
wRallyNetFrames:: db

; [8-bit] Rally Length; number of times the ball was hit in the span of a point
wRallyLength:: db

; [8-bit] Set to 1 by ExecuteShot, which refuses to run again while it is set. HandleBallHitEvent consumes it: increments wRallyLength, clears wBallHasBouncedFlag and wLandingMarkerActive, starts the landing marker and hit effect, updates every character's state. Cleared by ResetPointState
wBallHitEvent:: db

; [8-bit] Character index (0-3) of the hitter, from wCharIndex in ExecuteShot. Selects the wCharacterN stat block (index * 8) when crediting an ace/winner, its low bit gives the point outcome's side sign, and the bank $0d minigames test it for player vs machine
wLastShotCharIndex:: db

; [8-bit] The hitter's wCharServeRole, from ExecuteShot. Read only by DetectServeAceOutcome: on a point's second hit with the ball unbounced, role 1 (receiver) gives POINTOUTCOME_SERVE_VOLLEYED and any other role POINTOUTCOME_WRONG_RECEIVER
wLastShotServeRole:: db

; [8-bit] Nonzero draws the ball sprite slot
wBallSpriteEnabled:: db

; [8-bit] Nonzero draws the ball ground-shadow slot
wBallShadowEnabled:: db

; [8-bit] Nonzero draws the ball trail afterimages from the position history ring
wBallTrailEnabled:: db

; [8-bit] Trail palette index into BallTrailPalettes; nonzero also extends the trail from 2 to 5 ghosts
wBallTrailColor:: db

; [8-bit] wBallCourtQuadrant when the shot was struck. EvaluateBounceOutcome XORs it with the live quadrant: bit 1 = reached the other side of the net, bit 0 = changed lateral half (the serve's diagonal-box rule). The bank $0d wall-practice bounce flips bit 1 by hand
wBallQuadrantAtHit:: db

; [8-bit] Set to 1 when the ball bounces on the court (the same path fires StartBounceEffect); cleared by HandleBallHitEvent and ResetPointState. Read by EvaluateBounceOutcome, TickRallyTimers and AiTrackBallPhase
wBallHasBouncedFlag:: db

; [8-bit] Nonzero freezes the match simulation: UpdateMatchFrame skips ClearSpriteSlots, UpdateMatchCamera, UpdateAllChars, ball events, UpdateBallVisuals, timers and the mode hook. $ff during match setup and while the pause menu is open
wMatchSimFrozen:: db

; [8-bit] Nonzero freezes actor drawing: UpdateMatchFrame skips DrawActorsByDepth. Set $ff alongside wMatchSimFrozen while the pause menu is open
wMatchDrawFrozen:: db

; [8-bit] Nonzero blocks the pause menu (HandlePauseMenu returns at once). Set during match setup, the changeover sequence (RunChangeoverSequence) and the walk off court (WalkCharsOffCourt); cleared by ResetPointState and PlayMinigameCountdown
wPauseDisabled:: db

; [8-bit] $ff = abort the match (bit 7 breaks the point/game/set/match loops); set by every pause/quit-menu action, cleared per point by ResetPointState
wMatchAbortFlag:: db

; [8-bit] Nonzero draws edge arrows for off-screen characters (set during the rally)
wOffscreenArrowsEnabled:: db

; [8-bit] Set to 1 by PlayMinigamePoint as the rally starts; nothing reads it
wUnusedMinigamePointFlag:: db

; [8-bit] Set to 1 by ApplyFallbackBallTrajectory_24, the shared handler the court banks use when the requested trajectory row is out of range; cleared by ExecuteShot. StartLandingMarker then draws the lob landing marker, and AiIsIncomingLobShot treats the shot as SHOTTYPE_LOB
wFallbackTrajectoryFlag:: db

; [8-bit] Nonzero when the player chose Retry / Select New Level / Quit in the quit menu (discriminated by wMatchRetryRequest/wMatchSelectNewLevelRequest); outer mode loops branch on it
wMatchExitRequest:: db

; [8-bit] Set by InitViewFlipPreference when the court view is fixed instead of following the saved preference (link matches, game modes $08/$09, any minigame); the pause menus then lock the view row
wCourtViewLocked:: db

; [8-bit] Nonzero makes UpdateMatchCamera retarget to wBallGroundProjX/Y every frame instead of holding SetCameraTarget's target. Cleared by SetCameraTarget, SnapCameraTo and KeepMinigameCameraFixed; set to 1 when the rally starts and by the bank $0d wall bounce
wCameraFollowBall:: db

; [8-bit] Set in singles only; enables the wide flickering ground shadow under grounded characters
wStandingShadowsEnabled:: db

; [8-bit] Nonzero when the court view is mirrored so the human player stays on the near side: (wCourtViewOption != 0) && (bit 1 of $c8cf), recomputed by UpdateViewFlipState. FlipAllCharPositions skips flipping court-position codes when 0; RefreshCourtScoreboard picks the mirrored scoreboard layout when set
wCourtViewFlipped:: db

; [8-bit] Nonzero makes RunChangeoverSequence walk the characters to their new ends without the CHANGE ENDS banner. Set at the start of a set, at set end and when a tiebreak begins; cleared by the sequence
wChangeoverSkipBanner:: db

; [8-bit] Set to 1 when bit 1 of the game-count state $c8cf toggles (players change ends). RunChangeoverSequence then shows court banner $00, walks the characters over and clears it; also cleared at match setup
wChangeEndsPending:: db

; [8-bit] Nonzero when wCourtViewFlipped changed on the last UpdateViewFlipState (old minus new). RefreshCourtAfterEndChange returns at once on 0; ReinitPointAfterPause uses it to decide whether to redraw the court
wCourtViewFlipChanged:: db

; [8-bit] wOnCourtCharCount - 1 (0x00-0x03); jumptable index for the match engine's per-character-count dispatches
wOnCourtCharCountMinus1:: db

; [8-bit] Set when the point ended as a service ace (point outcome 6 with rally length 1); credited to the winner's ServiceAces stat
wServiceAceFlag:: db

; [8-bit] Set when the point ended as a return ace (point outcome 6 with rally length 2); credited to the winner's ReturnAces stat
wReturnAceFlag:: db

; [8-bit] WRAM bank (4-7) of the serving character, from FindServerCharBank in IdentifyServingPlayer. ReinitPointAfterPause maps it in to put the server back into the serve state
wServingCharWramBank:: db

; [8-bit] Current Serving Player (0x00-0x03)
wCurrentServingPlayer:: db

; [8-bit] wCharCourtPos of the serving character, from IdentifyServingPlayer. Bit 1 (server's side of the net) selects the serve camera target (GetServeCameraTarget) and the ace-banner offset; bank $09 uses the whole value as the serve-indicator template index and mixes it with wServeFaultFlag
wServingCharCourtPos:: db

; [8-bit] Match-point indicator: $01/$ff = P1/P2 side wins the match by taking the next point, 0 = none (EvaluatePointSituation simulates the next point)
wMatchPointFlag:: db

; [8-bit] Set-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wSetPointFlag:: db

; [8-bit] Game-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wGamePointFlag:: db

; [8-bit] 0 while the rally runs; point-end cause code once the point resolves
wPointOutcome:: db

; [8-bit] Side code stored with wPointOutcome when a point-ending event fires ($01/$ff); negated through the court-side parity bits to decide who won the point
wPointOutcomeSide:: db

; [8-bit] Nonzero while the lob landing marker is shown. Set with sound $6d by StartLandingMarker after it fills wLandingMarkerX/Y; DrawLandingMarker returns when 0. Cleared by HandleBallHitEvent, HandleBallBounceEvent, EndPointBallEffects, ResetPointState and bank $0d; the AI reads it as "a lob is coming"
wLandingMarkerActive:: db

; [8-bit] wMatchTypeNumberOfSets >> 1, set at match setup. ShowMatchRulesPages forms wRulesPageListIndex = this * 2 + wRulesGamesIndex, selecting one of the six MatchRulesPageLists records
wRulesSetsIndex:: db

; [8-bit] Bit 2 of wMatchTypeNumberOfGames, set at match setup; low term of wRulesPageListIndex
wRulesGamesIndex:: db

; [8-bit] Saved camera / court view option, loaded from story save-slot flag B (forced to 0 for minigames and game mode 8); edited by MatchPauseMenu_CameraSelect, which writes it back with SetStorySlotFlagB. UpdateViewFlipState mirrors the court only when nonzero
wCourtViewOption:: db

; [8-bit] Set to 1 by MatchQuitMenu_Retry; reruns the current drill/minigame (RunTrainingDrillByID)
wMatchRetryRequest:: db

; [8-bit] Set to 1 by MatchQuitMenu_SelectNewLevel; returns to the level-select screen after the match teardown
wMatchSelectNewLevelRequest:: db

; [8-bit] Pause/quit menu selection (rst00 jumptable index: check rules / review controls / change options / save-quit); $ff = cancelled
wMatchMenuSelection:: db

; [8-bit] Item id of the first entry of the story option submenu to draw ($04 court view, $06 message speed, $09 music, $0b save; $0e for the story pause root). RunStoryTwoOptionMenu and RunStoryThreeOptionMenu draw this id, +1 and +2, and add wMatchMenuSelection to it for the caption text ($0162 + n) and highlighted item graphics
wStoryMenuFirstItem:: db

; [8-bit] Nonzero means the shadow tilemap needs flushing to VRAM: Unused_06_FlushTilemapToVramIfDirty returns on 0, FlushTilemapToVram clears it, the debug stats editor sets it after redrawing
wTilemapDirtyFlag:: db

; [16-bit] Base position of the match scoreboard layout (low byte x, high byte y), added to each element's fixed offset. Set by PrepareScoreboardGfx ($0002 or $0202 by wScoreboardLayout) and ShowMatchScoreboardScreen (low byte 5). Read by the ScoreboardCaption_* handlers, DrawScoreboard, the pip drawers, and (shifted left 3) DrawScoreboardSprites and DrawScoreboardModeTitle
wScoreboardOrigin:: dw

; [8-bit] Rules/description page list to display, set by ShowMatchRulesPages (from wRulesSetsIndex/wRulesGamesIndex), ShowTrainingRulesPages (wCurrentMinigameStoryMatch + 1) and the minigame variant (drill id * 3 + wMinigameLevel). Indexes a 4-byte-per-record page list (MatchRulesPageLists and siblings)
wRulesPageListIndex:: db

; [8-bit] menu_def record the pause menu system should run, set before every RunMatchMenu / RunMatchQuitMenu / RunStoryMenu call in bank $06. GetMatchMenuItemCount and GetStoryMenuItemCount index their 8-byte menu_def tables with it
wPauseMenuId:: db

; [8-bit] Item count of the running menu, from Get*MenuItemCount in RunMatchMenu / RunStoryMenu. Wrap modulus for MoveCursorHorizontal, loop count in DrawMatchMenuItems / DrawStoryMenuItems, and index into the per-count item-position tables
wPauseMenuItemCount:: db

; [16-bit] Text id of the first body page of the rules sequence ($2c62 match rules, $2c6a training rules, or a per-minigame table value); ShowRulesPageSequence adds the page number to it
wRulesFirstPageTextId:: dw

; [16-bit] Text id of the caption above the rules pages: a fixed base plus wRulesPageListIndex ($2c25 + n match, $2c2b + n training, $2c47 + n minigame); passed to DrawMenuCaptionWindow
wRulesTitleTextId:: dw

; [16-bit] Saved best score for the current minigame, copied from the record ReadMinigameRecord returns (WRAM bank 7, $de00). Drawn instead of wMinigamesTargetScore when $c7bc marks a high-score attempt; bank $0d compares the current score against it
wMinigameHighScore:: dw

; [8-bit] Flags for the built-in debug test match; $fe from Unused_07_RunDebugTestMatch. Bit 1 makes character setup call OverrideCharStatsForDebug; bit 0 makes the frame-stepping loop skip the input wait
wDebugMatchFlags:: db
	ds 17
