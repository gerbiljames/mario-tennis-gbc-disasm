; DeathLink. The game reports how much each loss cost in wApDeathOut and
; applies what the client writes to wApDeathIn; which levels send and which
; arrive is the client's to decide. A loss a received death caused is never
; reported.

; RunMatch and RunMinigameMatch, before play: DeathLink is live unless this
; is a link-cable match (forcing a point on one cart desyncs the pair)
ApDeathLinkMatchStart:
	xor a
	ld [wApDeathIn], a
	ld [wApDeathApplied], a
	ld [wApDeathDrillPending], a
	ld a, [wGameMode]
	cp GAMEMODE_LINK_MATCH
	jr z, .off
	ASSERT GAMEMODE_NONE == 0
	and a
	jr z, .store
	ld a, 1
	jr .store
.off:
	xor a
.store:
	ld [wApDeathInMatch], a
	ret

; RunMinigameMatch, after play: a failed minigame or drill is a lost match,
; unless the player quit or a received death ended it. A high-score run
; always ends in a game over, so it never counts.
ApDeathLinkMinigameEnd:
	ld a, [wApDeathDrillPending]
	ld b, a
	ld a, [wMatchExitRequest]
	and a
	jr nz, .report
	ld a, [wApDeathApplied]
	and a
	jr nz, .report
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	jr nz, .minigame
	; a drill match can end tied (WINLOSE_NONE), which fails it too
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_WIN
	jr nz, .failed
	jr .report
.minigame:
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_LOSE
	jr nz, .report
	ld a, [wMinigameHighScoreMode]
	and a
	jr nz, .report
.failed:
	ld b, AP_DEATHLINK_MATCH
.report:
	ld a, b
	call ApDeathLinkReport
	; fallthrough

; RunMatch, after play
ApDeathLinkMatchEnd:
	xor a
	ld [wApDeathInMatch], a
	ld [wApDeathIn], a
	ret

; a = AP_DEATHLINK_* lost (0: none): kept in wApDeathOut if it is bigger
; than what the client has yet to send
ApDeathLinkReport:
	and a
	ret z
	ld b, a
	ld a, [wApDeathInMatch]
	and a
	ret z
	ld a, [wApDeathOut]
	cp b
	ret nc
	ld a, b
	ld [wApDeathOut], a
	ret

; ScorePoint, once the point is on the score: the win/lose flags are the
; player's side (Player 1)
ApDeathLinkScored:
	ld a, [wPointOutcome]
	cp POINTOUTCOME_DEATHLINK
	ret z
	ld b, AP_DEATHLINK_MATCH
	ld a, [wMatchWinLoseFlag]
	cp WINLOSE_LOSE
	jr z, .lost
	dec b
	ld a, [wGameWinLoseFlag]
	cp WINLOSE_LOSE
	jr z, .lost
	dec b
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_LOSE
	ret nz
.lost:
	ld a, b
	jr ApDeathLinkReport

; PlayPoint, every rally frame: a received death ends the rally as a lost
; point. For a game or the match, the score is first set so that this one
; point decides it: the opponent at 40-0 (6-0 in a tiebreak), and for the
; match also a game and a set short of winning. Not while the point is being
; given up (a pause menu's quit or save): it waits for the next one.
ApDeathLinkPoll:
	ld a, [wApDeathIn]
	and a
	ret z
	ld b, a
	ld a, [wPointOutcome]
	and a
	ret nz
	ld a, [wMatchAbortFlag]
	and a
	ret nz
	ld [wApDeathIn], a
	push bc
	call ApComposeDeathLinkMessage
	pop bc
	ld a, b
	cp AP_DEATHLINK_GAME
	jr c, .point
	xor a
	ld [wPlayer1PointsWon], a
	ld [wDeuceIndicator], a
	ld a, [wTiebreakerIndicator]
	and a
	ld a, 3
	jr z, .points
	ld a, 6
.points:
	ld [wPlayer2PointsWon], a
	ld a, b
	cp AP_DEATHLINK_MATCH
	jr c, .point
	xor a
	ld [wPlayer1GamesWon], a
	ld a, [wMatchTypeNumberOfGames]
	dec a
	ld [wPlayer2GamesWon], a
	ld a, [wMatchTypeNumberOfSets]
	inc a
	srl a
	dec a
	ld [wPlayer2SetsWon], a
.point:
	xor a
	ld [wPointOutcomeSide], a
	ld a, POINTOUTCOME_DEATHLINK
	ld [wPointOutcome], a
	ret

; "DeathLink from <name>!" into wApMessage, composed as the death is
; applied: the client may write the next one's source before it shows
ApComposeDeathLinkMessage:
	ld de, wApMessage
	ld hl, ApTextDeathLink
	call ApCopyString
	ld a, [wApDeathSource]
	and a
	jp z, ApEndMessage
	ld a, AP_TEXT_LINE
	ld [de], a
	inc de
	ld hl, ApTextFrom
	call ApCopyString
	ld hl, wApDeathSource
	call ApCopyName
	jp ApEndMessage

; ResolvePointOutcome, for POINTOUTCOME_DEATHLINK
ApShowDeathLinkMessage:
	call ApDeathLinkWindow
	ld a, 10
	farcall StepMatchFrames
	ret

; the composed message, until a button press; the sim runs again after.
; 19 wide: ShowMessageWindow rounds the court's scroll up to a tile, so the
; window can start up to 7 pixels right of the screen edge.
ApDeathLinkWindow:
	ld hl, AP_MESSAGE_TEXT
	ld_cell de, $00, $05
	ld_size bc, $13, $06
	farcall ShowMessageWindow
	ret

; PlayMinigamePoint, every rally frame: a received death ends a minigame or
; drill at once as failed. A minigame's own result decides it (a high-score
; run past its record still ends as one); a drill is a game over. The sim
; stays frozen, as ShowMatchResultScreens follows with no frame between, so
; there is no banner (object sprites are not drawn while frozen).
ApDeathLinkMinigamePoll:
	ld a, [wApDeathIn]
	and a
	ret z
	ld a, [wPointOutcome]
	and a
	ret nz
	ld a, [wMatchAbortFlag]
	and a
	ret nz
	ld [wApDeathIn], a
	inc a
	ld [wApDeathApplied], a
	call ApComposeDeathLinkMessage
	call ApDeathLinkWindow
	ld a, 1
	ld [wMatchSimFrozen], a
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	jr z, .drill
	ld a, BANK(DetermineMinigamePointResult)
	ld hl, DetermineMinigamePointResult
	call CallHLInBankA
	jr .result
.drill:
	; a drill may leave wMinigameHighScoreMode set from an earlier minigame
	ld a, WINLOSE_LOSE
	ld [wPointWinLoseFlag], a
	; the story coaches pick their scene from it, and it is still
	; LESSON_PASSED: code 1 fails every lesson
	ASSERT LESSON_SERVE_NO_POINTS == LESSON_NET_ALL_FAULTS
	ASSERT LESSON_SERVE_NO_POINTS == LESSON_RETURN_ALL_OUT
	ASSERT LESSON_SERVE_NO_POINTS == LESSON_LOB_TOO_FEW
	ld a, LESSON_SERVE_NO_POINTS
	ld [wDrillLessonResult], a
.result:
	ld a, MATCHABORT_MATCH | MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_WIN
	jr z, .won
	sound BGM_LOSE
	ret
.won:
	sound BGM_WIN
	ret

; RecordDrillPointResultBits: every drill's point-end handler calls it once
; with the point's own result in wPointWinLoseFlag, from the player's side,
; before a drill's last point replaces it with the drill's. A lost drill
; point waits in wApDeathDrillPending, as the drill may end on it.
ApDeathLinkDrillPoint:
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	ret nz
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_LOSE
	ret nz
	ld a, AP_DEATHLINK_POINT
	ld [wApDeathDrillPending], a
	ret

; RunMinigamePointLoop, as each point starts: the drill went on, so the
; point lost before this one is reported
ApDeathLinkMinigamePointStart:
	ld a, [wApDeathDrillPending]
	and a
	ret z
	ld b, a
	xor a
	ld [wApDeathDrillPending], a
	ld a, b
	jp ApDeathLinkReport

ApTextDeathLink:
	db "DeathLink", 0
