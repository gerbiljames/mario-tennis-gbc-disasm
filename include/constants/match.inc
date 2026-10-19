; --- Match object slot fields ---
; Offsets into one 16-byte wObjSlot record (ram/wram/ has the full
; description), which the bank $09 object engine reaches with the slot in bc.
def OBJSLOT_SIZE            equ $10
	const_def
	const OBJSLOT_ID              ; $00 $ff = free
	const OBJSLOT_FLAGS           ; $01 bit 0 draw this frame; LoadObjTemplate_09 sets bit 7
	const OBJSLOT_SPRITE_TEMPLATE ; $02 word
	const_def 4
	const OBJSLOT_OAM_ATTR ; $04
	const OBJSLOT_TILE     ; $05
	const OBJSLOT_X        ; $06
	const OBJSLOT_Y        ; $07
	const OBJSLOT_HANDLER  ; $08 word
	const_def 10
	const OBJSLOT_CURVE_X    ; $0a
	const OBJSLOT_CURVE_Y    ; $0b
	const OBJSLOT_STATE      ; $0c the handler's RST00 sub-state
	const OBJSLOT_CURVE_STEP ; $0d
	const OBJSLOT_CURVE      ; $0e MoveCurveTable_09 index
	const OBJSLOT_ANCHOR     ; $0f 1 = relative to the serving character

; --- Shot types (wCurrentShotType) ---
; Selected from the A/B button sequence by SelectRallyShotType /
; SelectServeShotType, which index wCharShotButton1 x wCharShotButton2 tables.
; Base strokes: A = topspin, B = slice, A->B = lob, B->A = drop, A+B = smash;
; doubling a button gives its "power" variant. When the ball is in smash range
; (wCharBallReachFlags bit 4) the ground strokes are swapped for their "reach"
; variants ($06/$07/$08, dispatched to bank $2c's ProjectShotPlacement0-2).
; Serves by first button: A -> topspin, B -> slice, A+B -> flat.
	const_def
	const SHOTTYPE_TOPSPIN             ; $00 A
	const SHOTTYPE_POWER_TOPSPIN       ; $01 A -> A
	const SHOTTYPE_SLICE               ; $02 B
	const SHOTTYPE_POWER_SLICE         ; $03 B -> B
	const SHOTTYPE_NEUTRAL             ; $04 no valid button combo (table fallback)
	const SHOTTYPE_REACH               ; $05 reach attempted, ball not in smash range
	const SHOTTYPE_REACH_POWER_TOPSPIN ; $06 A -> A, ball smashable
	const SHOTTYPE_REACH_POWER_SLICE   ; $07 B -> B, ball smashable
	const SHOTTYPE_REACH_BASIC         ; $08 A / B, ball smashable
	const SHOTTYPE_SMASH               ; $09 A + B
	const SHOTTYPE_LOB                 ; $0a A -> B
	const SHOTTYPE_DROP                ; $0b B -> A
	const SHOTTYPE_SERVE_TOPSPIN       ; $0c serve, A
	const SHOTTYPE_SERVE_SLICE         ; $0d serve, B
	const SHOTTYPE_SERVE_FLAT          ; $0e serve, A+B
def NUM_SHOTTYPES equ const_value

; AI shot habits (CharGroupTable_02, one 16-entry row per serve style;
; AiPickShotButtons draws one by AdvanceMatchRng & $0f): the stroke's two
; button presses as nibbles, first press high -- 1 = A, 2 = B, 3 = A+B.
	const_def 16
	const AISHOT_TOPSPIN       ; $10 A
	const AISHOT_POWER_TOPSPIN ; $11 A -> A
	const AISHOT_LOB           ; $12 A -> B
	const_def 32
	const AISHOT_SLICE       ; $20 B
	const AISHOT_DROP        ; $21 B -> A
	const AISHOT_POWER_SLICE ; $22 B -> B
def AISHOT_NEUTRAL             equ $30 ; A+B, a smash when the ball is in range

; --- Point outcome (wPointOutcome) — MATCH context ---
; ResolvePointOutcome dispatches `rst Rst00` on wPointOutcome: 1-5 ->
; ShowCourtBanner(wPointOutcome) (banner id == the value), 6 -> the winner
; banner ShowCourtBanner(wPointWinnerShotType + $17), 7/8 -> text popups.
	const_def 1
	const POINTOUTCOME_FAULT        ; $01
	const POINTOUTCOME_DOUBLE_FAULT ; $02
	const POINTOUTCOME_LET          ; $03
	const POINTOUTCOME_NET          ; $04
	const POINTOUTCOME_OUT          ; $05
	const POINTOUTCOME_WINNER       ; $06

; --- Winning-shot type (wPointWinnerShotType) ---
; Set by the Record*Stat functions; the winner court banner is
; ShowCourtBanner(value + $17) -> banner ids 24-28.
	const_def 1
	const POINTWINNER_SERVICE_ACE ; $01
	const POINTWINNER_RETURN_ACE  ; $02
	const POINTWINNER_SMASH_ACE   ; $03
	const POINTWINNER_LOB         ; $04
	const POINTWINNER_DROP_SHOT   ; $05

; --- Court ids (wCurrentlyUsedCourt) ---
; Read only by LoadCourtSceneData, which takes row (id * 4) of the 25-row
; LoadCourtSceneDataTable: surface friction, surface restitution and
; court-scene graphics id. Ids that differ only in scene are skins of the same
; surface ($0d is $02's row byte for byte). IsCourtUnlocked reads byte
; (id - 4) of the unlock bits, so ids 4-8 are SAVEFLAG_COURT_STAR..._WAREHOUSE;
; ids $00-$03 are always available.
	const_def
	const COURT_HARD              ; $00
	const COURT_CLAY              ; $01
	const COURT_GRASS             ; $02
	const COURT_COMPOSITION       ; $03
	const COURT_STAR              ; $04 first of the five unlockable bonus courts
	const COURT_CASTLE            ; $05 also the Dream Match court
	const COURT_TROPICS           ; $06
	const COURT_JUNGLE            ; $07
	const COURT_WAREHOUSE         ; $08
	const COURT_TRAINING_PRACTICE ; $09 Training Court, Practice drills
	const COURT_TENNIS_MACHINE    ; $0a
	const COURT_WALL_PRACTICE     ; $0b
	const COURT_CENTER            ; $0c Island Open final
	const COURT_GRASS_ISLAND_OPEN ; $0d Island Open early rounds; $02's surface
	const COURT_UNUSED_0E         ; $0e no code or table ever selects it
	const COURT_TARGET_SHOT       ; $0f
	const COURT_SHOOTING_STAR     ; $10
	const COURT_BANANA_BUNCH      ; $11
	const COURT_BOO_BLAST         ; $12
	const COURT_PERFECT_SHOT      ; $13
	const COURT_TREASURE_BOX      ; $14
	const COURT_MEDALLION_MATCH   ; $15
	const COURT_FRUIT_FANTASY     ; $16
	const COURT_TWO_ON_ONE        ; $17
	const COURT_TRAINING_MATCH    ; $18 Training Court, Match drills
def NUM_COURTS equ const_value

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
	const_def
	const CHARANIM_STAND          ; $00 frame 0, held; the parked pose on the character-select screen
	const CHARANIM_IDLE           ; $01 the ready bob; UpdateCharRunAnimation's not-moving case, and what every swing chains back to
	const CHARANIM_RUN            ; $02 UpdateCharRunAnimation's moving case (wCharFlags bit 4)
	const CHARANIM_CELEBRATE      ; $03 CharPointReactionPhase, wCharPointResult >= 0; also both characters on the results screen
	const CHARANIM_DEJECTED       ; $04 CharPointReactionPhase, wCharPointResult < 0
	const CHARANIM_FOREHAND       ; $05 SelectForehandBackhand
	const CHARANIM_BACKHAND       ; $06 SelectForehandBackhand; ExecuteShot counts it toward wShotAimMirror
	const CHARANIM_OVERHEAD       ; $07 the high ground stroke and the serve swing
	const CHARANIM_SMASH          ; $08 the jumping smash; the script holds its last frame until the character lands
	const CHARANIM_FOREHAND_QUICK ; $09
	const CHARANIM_BACKHAND_QUICK ; $0a counted toward wShotAimMirror alongside $06
	const CHARANIM_OVERHEAD_QUICK ; $0b
	const CHARANIM_SMASH_QUICK    ; $0c only ResetSwingAnimation and the debug viewer reach it -- StartCharSwing returns before the +$04 step on the smash path
	const CHARANIM_FOREHAND_READY ; $0d
	const CHARANIM_BACKHAND_READY ; $0e
	const CHARANIM_OVERHEAD_READY ; $0f also the serve toss pose (CharServeTossPhase)
	const CHARANIM_SERVE_READY    ; $10 held serve stance; CharServeWaitAnimPhase and AiServeWalkToSpot both block until it is current
	const CHARANIM_SERVE_PREP     ; $11 the pre-serve flourish, which ends in an anim_set to $10
	const CHARANIM_DIVE           ; $12 StartCharSwing.dive

; --- On-court character state (wCharState) ---
; The index UpdateCharStateMachine dispatches on through the 8-entry
; jumptable at $08:$6a7b; SetCharState is the only writer and zeroes
; wCharStatePhase/wAiPhase with it. Names are the handler labels. The AI's
; three parallel tables ($08:$7886/$789a/$78ae) implement only slots 1-3.
; Two `db` tables map into this space: ServeRoleCharStateTable_08 (serve role
; -> state at the start of a point) and SetCharStateOnBallHitTable (the state
; every character is remapped through on every strike).
	const_def
	const CHARSTATE_INERT       ; $00 slot points at the shared `ret` -- InitChar, ResetCharForPoint, and a character the ball hits
	const CHARSTATE_RALLY       ; $01 CharRallyState: ready -> windup -> contact
	const CHARSTATE_RECOVER     ; $02 CharRecoverState: let the swing finish, then movement only. Whoever struck the ball is put here
	const CHARSTATE_SERVE       ; $03 CharServeState: indicator, toss, swing window, strike
	const CHARSTATE_AWAIT_SERVE ; $04 CharAwaitServeState
	const CHARSTATE_STANDBY     ; $05 CharStandbyState: end-state, then state 4's movement phase
	const CHARSTATE_WALK        ; $06 CharWalkState: the scripted changeover and walk-off walks
	const CHARSTATE_POINT_END   ; $07 CharPointEndState: walk to target, then the win/lose reaction
def NUM_CHARSTATES equ const_value

; --- On-court character flags (wCharFlags) ---
; Bit indices only (every site is a `bit`/`res`/`set`). Bits 3 and 7 are
; never touched.
	const_def
	const CHARB_RECOIL   ; $00 set by ApplyShotRecoil after every stroke and by CheckCharBallContact on a body hit; UpdateCharVelocityFromInput drops the steering intent
	const CHARB_DIVING   ; $01 StartCharSwing.dive sets it. Widens the contact window to 1.25x wCharReachX, flattens the brake, freezes the facing ease, costs -$0c00 shot speed, and turns both power strokes back into their base shots
	const CHARB_AIRBORNE ; $02 set for the smash jump, cleared by StepCharJumpPhysics on landing; also picks the airborne shadow over the ground one
	const_def 4
	const CHARB_MOVING       ; $04 the velocity came out nonzero this frame (or MoveCharTowardTarget stepped); UpdateCharRunAnimation reads it to choose run over idle
	const CHARB_CHARGING     ; $05 a swing is winding up: StepCharMovement divides both velocities by 8
	const CHARB_MOVE_BLOCKED ; $06 StepCharMovement refused an axis at the court bound instead of clamping it. Never read

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
	const_def 7
	const POINTOUTCOME_SERVE_VOLLEYED  ; $07 the receiver hit the serve before it bounced; text id $0174 "Return the serve after it bounces."
	const POINTOUTCOME_WRONG_RECEIVER  ; $08 the wrong player of a doubles pair returned; text id $0175 "Only the receiving player may return the ball."
	const POINTOUTCOME_BALL_HIT_PLAYER ; $09 the ball reached a character's body (ApplyBallTouchOutcome)
def POINTOUTCOME_MINIGAME_CLEARED equ $0b ; bank $0d only, set right after IsMinigameTargetReached; DetermineMinigamePointResult turns it into a WINLOSE_WIN

; --- Win/lose sign (wPointWinLoseFlag, wMatchWinLoseFlag) ---
; A signed -1/0/+1 shared by both flags and the set/game-level ones: AwardPoint
; (`add a / ret z / jr nc`) credits nobody on $00, the player-1 side on +1 and
; the player-2 side on -1.
def WINLOSE_NONE             equ $00 ; nothing decided yet
def WINLOSE_WIN              equ $01 ; the player-1 side took it
def WINLOSE_LOSE             equ $ff ; the player-2 side took it

; --- Match context (wMatchContext) ---
	const_def
	const MATCHCONTEXT_EXHIBITION ; $00 cleared by RestoreOverworldAfterMatch
	const MATCHCONTEXT_STORY      ; $01 InitStoryMatchSettings
	const MATCHCONTEXT_MINIGAME   ; $02 InitMinigameMatchSettings, RunDoublesDrillMatch: fixed view, doubles scoreboard
