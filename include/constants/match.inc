; --- Match object slot fields ---
; Offsets into one 16-byte wObjSlot record (ram/wram.asm has the full
; description), which the bank $09 object engine reaches with the slot in bc.
def OBJSLOT_SIZE            equ $10
def OBJSLOT_ID              equ $00 ; $ff = free
def OBJSLOT_FLAGS           equ $01 ; bit 0 draw this frame; LoadObjTemplate_09 sets bit 7
def OBJSLOT_SPRITE_TEMPLATE equ $02 ; word
def OBJSLOT_OAM_ATTR        equ $04
def OBJSLOT_TILE            equ $05
def OBJSLOT_X               equ $06
def OBJSLOT_Y               equ $07
def OBJSLOT_HANDLER         equ $08 ; word
def OBJSLOT_CURVE_X         equ $0a
def OBJSLOT_CURVE_Y         equ $0b
def OBJSLOT_STATE           equ $0c ; the handler's RST00 sub-state
def OBJSLOT_CURVE_STEP      equ $0d
def OBJSLOT_CURVE           equ $0e ; MoveCurveTable_09 index
def OBJSLOT_ANCHOR          equ $0f ; 1 = relative to the serving character

; --- Shot types (wCurrentShotType) ---
; Selected from the A/B button sequence by SelectRallyShotType /
; SelectServeShotType, which index wCharShotButton1 x wCharShotButton2 tables.
; Base strokes: A = topspin, B = slice, A->B = lob, B->A = drop, A+B = smash;
; doubling a button gives its "power" variant. When the ball is in smash range
; (wCharBallReachFlags bit 4) the ground strokes are swapped for their "reach"
; variants ($06/$07/$08, dispatched to bank $2c's ProjectShotPlacement0-2).
; Serves by first button: A -> topspin, B -> slice, A+B -> flat.
def SHOTTYPE_TOPSPIN            equ $00 ; A
def SHOTTYPE_POWER_TOPSPIN      equ $01 ; A -> A
def SHOTTYPE_SLICE              equ $02 ; B
def SHOTTYPE_POWER_SLICE        equ $03 ; B -> B
def SHOTTYPE_NEUTRAL            equ $04 ; no valid button combo (table fallback)
def SHOTTYPE_REACH              equ $05 ; reach attempted, ball not in smash range
def SHOTTYPE_REACH_POWER_TOPSPIN equ $06 ; A -> A, ball smashable
def SHOTTYPE_REACH_POWER_SLICE equ $07 ; B -> B, ball smashable
def SHOTTYPE_REACH_BASIC       equ $08 ; A / B, ball smashable
def SHOTTYPE_SMASH             equ $09 ; A + B
def SHOTTYPE_LOB               equ $0a ; A -> B
def SHOTTYPE_DROP              equ $0b ; B -> A
def SHOTTYPE_SERVE_TOPSPIN     equ $0c ; serve, A
def SHOTTYPE_SERVE_SLICE       equ $0d ; serve, B
def SHOTTYPE_SERVE_FLAT        equ $0e ; serve, A+B

; AI shot habits (CharGroupTable_02, one 16-entry row per serve style;
; AiPickShotButtons draws one by AdvanceMatchRng & $0f): the stroke's two
; button presses as nibbles, first press high -- 1 = A, 2 = B, 3 = A+B.
def AISHOT_TOPSPIN             equ $10 ; A
def AISHOT_POWER_TOPSPIN       equ $11 ; A -> A
def AISHOT_LOB                 equ $12 ; A -> B
def AISHOT_SLICE               equ $20 ; B
def AISHOT_DROP                equ $21 ; B -> A
def AISHOT_POWER_SLICE         equ $22 ; B -> B
def AISHOT_NEUTRAL             equ $30 ; A+B, a smash when the ball is in range

; --- Point outcome (wPointOutcome) — MATCH context ---
; ResolvePointOutcome dispatches `rst Rst00` on wPointOutcome: 1-5 ->
; ShowCourtBanner(wPointOutcome) (banner id == the value), 6 -> the winner
; banner ShowCourtBanner(wPointWinnerShotType + $17), 7/8 -> text popups.
def POINTOUTCOME_FAULT          equ 1
def POINTOUTCOME_DOUBLE_FAULT   equ 2
def POINTOUTCOME_LET            equ 3
def POINTOUTCOME_NET            equ 4
def POINTOUTCOME_OUT            equ 5
def POINTOUTCOME_WINNER         equ 6

; --- Winning-shot type (wPointWinnerShotType) ---
; Set by the Record*Stat functions; the winner court banner is
; ShowCourtBanner(value + $17) -> banner ids 24-28.
def POINTWINNER_SERVICE_ACE     equ 1
def POINTWINNER_RETURN_ACE      equ 2
def POINTWINNER_SMASH_ACE       equ 3
def POINTWINNER_LOB             equ 4
def POINTWINNER_DROP_SHOT       equ 5

; --- Court ids (wCurrentlyUsedCourt) ---
; Read only by LoadCourtSceneData, which takes row (id * 4) of the 25-row
; LoadCourtSceneDataTable: surface friction, surface restitution and
; court-scene graphics id. Ids that differ only in scene are skins of the same
; surface ($0d is $02's row byte for byte). IsCourtUnlocked reads byte
; (id - 4) of the unlock bits, so ids 4-8 are SAVEFLAG_COURT_STAR..._WAREHOUSE;
; ids $00-$03 are always available.
def COURT_HARD              equ $00
def COURT_CLAY              equ $01
def COURT_GRASS             equ $02
def COURT_COMPOSITION       equ $03
def COURT_STAR              equ $04 ; first of the five unlockable bonus courts
def COURT_CASTLE            equ $05 ; also the Dream Match court
def COURT_TROPICS           equ $06
def COURT_JUNGLE            equ $07
def COURT_WAREHOUSE         equ $08
def COURT_TRAINING_PRACTICE equ $09 ; Training Court, Practice drills
def COURT_TENNIS_MACHINE    equ $0a
def COURT_WALL_PRACTICE     equ $0b
def COURT_CENTER            equ $0c ; Island Open final
def COURT_GRASS_ISLAND_OPEN equ $0d ; Island Open early rounds; $02's surface
def COURT_UNUSED_0E         equ $0e ; no code or table ever selects it
def COURT_TARGET_SHOT       equ $0f
def COURT_SHOOTING_STAR     equ $10
def COURT_BANANA_BUNCH      equ $11
def COURT_BOO_BLAST         equ $12
def COURT_PERFECT_SHOT      equ $13
def COURT_TREASURE_BOX      equ $14
def COURT_MEDALLION_MATCH   equ $15
def COURT_FRUIT_FANTASY     equ $16
def COURT_TWO_ON_ONE        equ $17
def COURT_TRAINING_MATCH    equ $18 ; Training Court, Match drills

; --- On-court character animation ids (wCharAnimId, wCharSwingAnim) ---
; SetCharAnimation stores its argument in wCharAnimId and indexes
; wCharAnimTablePtr by it: the 19-entry <Char>SpriteAnims list every character
; bank ($40-$5d) opens with, so the space is $00-$12. wCharSwingAnim holds an
; id from the same space, copied into wCharAnimId by CharSwingWindupPhase.
;
; Two rules generate most of the table (every character bank is laid out alike):
;   swing + $08 = the held "ready" pose -- CharRallyReadyPhase plays
;                 `wCharSwingAnim + $08` while the button is down;
;                 SpriteAnim0d/0e/0f are each the single held frame just
;                 before SpriteAnim05/06/07.
;   swing + $04 = the quick (uncharged) variant -- StartCharSwing.startSwing
;                 adds 4 when fewer than 5 windup frames elapsed;
;                 SpriteAnim09/0a/0b/0c are the first frame of
;                 SpriteAnim05/06/07/08 alone before chaining back to idle.
; CharRallyEndState tests the set $05 $06 $07 $09 $0a $0b $12: a ground
; swing (charged or quick) or a dive still playing. The smash is covered by
; the airborne bit (wCharFlags bit 2) tested on the next line.
def CHARANIM_STAND           equ $00 ; frame 0, held; the parked pose on the character-select screen
def CHARANIM_IDLE            equ $01 ; the ready bob; UpdateCharRunAnimation's not-moving case, and what every swing chains back to
def CHARANIM_RUN             equ $02 ; UpdateCharRunAnimation's moving case (wCharFlags bit 4)
def CHARANIM_CELEBRATE       equ $03 ; CharPointReactionPhase, wCharPointResult >= 0; also both characters on the results screen
def CHARANIM_DEJECTED        equ $04 ; CharPointReactionPhase, wCharPointResult < 0
def CHARANIM_FOREHAND        equ $05 ; SelectForehandBackhand
def CHARANIM_BACKHAND        equ $06 ; SelectForehandBackhand; ExecuteShot counts it toward wShotAimMirror
def CHARANIM_OVERHEAD        equ $07 ; the high ground stroke and the serve swing
def CHARANIM_SMASH           equ $08 ; the jumping smash; the script holds its last frame until the character lands
def CHARANIM_FOREHAND_QUICK  equ $09
def CHARANIM_BACKHAND_QUICK  equ $0a ; counted toward wShotAimMirror alongside $06
def CHARANIM_OVERHEAD_QUICK  equ $0b
def CHARANIM_SMASH_QUICK     equ $0c ; only ResetSwingAnimation and the debug viewer reach it -- StartCharSwing returns before the +$04 step on the smash path
def CHARANIM_FOREHAND_READY  equ $0d
def CHARANIM_BACKHAND_READY  equ $0e
def CHARANIM_OVERHEAD_READY  equ $0f ; also the serve toss pose (CharServeTossPhase)
def CHARANIM_SERVE_READY     equ $10 ; held serve stance; CharServeWaitAnimPhase and AiServeWalkToSpot both block until it is current
def CHARANIM_SERVE_PREP      equ $11 ; the pre-serve flourish, which ends in an anim_set to $10
def CHARANIM_DIVE            equ $12 ; StartCharSwing.dive

; --- On-court character state (wCharState) ---
; The index UpdateCharStateMachine dispatches on through the 8-entry
; jumptable at $08:$6a7b; SetCharState is the only writer and zeroes
; wCharStatePhase/wAiPhase with it. Names are the handler labels. The AI's
; three parallel tables ($08:$7886/$789a/$78ae) implement only slots 1-3.
; Two `db` tables map into this space: ServeRoleCharStateTable_08 (serve role
; -> state at the start of a point) and SetCharStateOnBallHitTable (the state
; every character is remapped through on every strike).
def CHARSTATE_INERT          equ 0 ; slot points at the shared `ret` -- InitChar, ResetCharForPoint, and a character the ball hits
def CHARSTATE_RALLY          equ 1 ; CharRallyState: ready -> windup -> contact
def CHARSTATE_RECOVER        equ 2 ; CharRecoverState: let the swing finish, then movement only. Whoever struck the ball is put here
def CHARSTATE_SERVE          equ 3 ; CharServeState: indicator, toss, swing window, strike
def CHARSTATE_AWAIT_SERVE    equ 4 ; CharAwaitServeState
def CHARSTATE_STANDBY        equ 5 ; CharStandbyState: end-state, then state 4's movement phase
def CHARSTATE_WALK           equ 6 ; CharWalkState: the scripted changeover and walk-off walks
def CHARSTATE_POINT_END      equ 7 ; CharPointEndState: walk to target, then the win/lose reaction

; --- On-court character flags (wCharFlags) ---
; Bit indices only (every site is a `bit`/`res`/`set`). Bits 3 and 7 are
; never touched.
def CHARB_RECOIL             equ 0 ; set by ApplyShotRecoil after every stroke and by CheckCharBallContact on a body hit; UpdateCharVelocityFromInput drops the steering intent
def CHARB_DIVING             equ 1 ; StartCharSwing.dive sets it. Widens the contact window to 1.25x wCharReachX, flattens the brake, freezes the facing ease, costs -$0c00 shot speed, and turns both power strokes back into their base shots
def CHARB_AIRBORNE           equ 2 ; set for the smash jump, cleared by StepCharJumpPhysics on landing; also picks the airborne shadow over the ground one
def CHARB_MOVING             equ 4 ; the velocity came out nonzero this frame (or MoveCharTowardTarget stepped); UpdateCharRunAnimation reads it to choose run over idle
def CHARB_CHARGING           equ 5 ; a swing is winding up: StepCharMovement divides both velocities by 8
def CHARB_MOVE_BLOCKED       equ 6 ; StepCharMovement refused an axis at the court bound instead of clamping it. Never read

; --- Match abort flag (wMatchAbortFlag) ---
; Two independent bits rather than a code: every reader is an `and` (or one
; `bit 7`), and the two bits break different loops. The quit paths write $ff,
; every bit.
def MATCHABORT_POINT         equ $01 ; give up the current rally: tested by PlayPoint.rallyLoop and PlayMinigamePoint.rallyLoop
def MATCHABORT_MATCH         equ $80 ; break out of the point/game/set/match loops: tested in RunMatchPlayLoop, CheckSetComplete and RunMinigameLoop
def MATCHABORT_ALL           equ $ff ; every bit set, written by the four MatchQuitMenu_* actions, StoryPauseMenu_ReturnToMainMenu and Unused_07_TargetZonePointEndHook
def MATCHABORTB_MATCH        equ 7   ; bit-index form of MATCHABORT_MATCH

; --- Point outcome, continued: the codes above 6 ---
; The ResolvePointOutcome jumptable has ten entries ($00-$09); 7 and 8 show a
; text popup rather than a court banner. $0b is minigame-only and never
; reaches that jumptable.
def POINTOUTCOME_SERVE_VOLLEYED equ 7  ; the receiver hit the serve before it bounced; text id $0174 "Return the serve after it bounces."
def POINTOUTCOME_WRONG_RECEIVER equ 8  ; the wrong player of a doubles pair returned; text id $0175 "Only the receiving player may return the ball."
def POINTOUTCOME_BALL_HIT_PLAYER equ 9 ; the ball reached a character's body (ApplyBallTouchOutcome)
def POINTOUTCOME_MINIGAME_CLEARED equ $0b ; bank $0d only, set right after IsMinigameTargetReached; DetermineMinigamePointResult turns it into a WINLOSE_WIN

; --- Win/lose sign (wPointWinLoseFlag, wMatchWinLoseFlag) ---
; A signed -1/0/+1 shared by both flags and the set/game-level ones: AwardPoint
; (`add a / ret z / jr nc`) credits nobody on $00, the player-1 side on +1 and
; the player-2 side on -1.
def WINLOSE_NONE             equ $00 ; nothing decided yet
def WINLOSE_WIN              equ $01 ; the player-1 side took it
def WINLOSE_LOSE             equ $ff ; the player-2 side took it

; --- Match context (wMatchContext) ---
def MATCHCONTEXT_EXHIBITION  equ $00 ; cleared by RestoreOverworldAfterMatch
def MATCHCONTEXT_STORY       equ $01 ; InitStoryMatchSettings
def MATCHCONTEXT_MINIGAME    equ $02 ; InitMinigameMatchSettings, RunDoublesDrillMatch: fixed view, doubles scoreboard
