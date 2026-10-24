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
	ld [wApDeathPoint], a
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
; unless the player quit or a received death had a hand in it. A high-score
; run always ends in a game over, so it never counts.
ApDeathLinkMinigameEnd:
	ld a, [wApDeathDrillPending]
	ld b, a
	ld a, [wMatchExitRequest]
	and a
	jr nz, .report
	ld a, [wApDeathApplied]
	and a
	jr nz, .report
	ld a, [wPointWinLoseFlag]
	cp WINLOSE_LOSE
	jr nz, .report
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	jr z, .failed
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
; match also a game and a set short of winning.
ApDeathLinkPoll:
	ld a, [wApDeathIn]
	and a
	ret z
	ld b, a
	ld a, [wPointOutcome]
	and a
	ret nz
	ld [wApDeathIn], a
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
	ld a, 1
	ld [wApDeathApplied], a
	xor a
	ld [wPointOutcomeSide], a
	ld a, POINTOUTCOME_DEATHLINK
	ld [wPointOutcome], a
	ret

; ResolvePointOutcome, for POINTOUTCOME_DEATHLINK: "DeathLink from <name>!"
ApShowDeathLinkMessage:
	ld de, wApMessage
	ld hl, ApTextDeathLink
	call ApCopyString
	ld a, [wApDeathSource]
	and a
	jr z, .end
	ld a, AP_TEXT_LINE
	ld [de], a
	inc de
	ld hl, ApTextFrom
	call ApCopyString
	ld hl, wApDeathSource
	call ApCopyName
.end:
	call ApEndMessage
	ld hl, AP_MESSAGE_TEXT
	ld_cell de, $00, $05
	ld_size bc, $14, $06
	farcall ShowMessageWindow
	ld a, 10
	farcall StepMatchFrames
	ret

; PlayMinigamePoint, every rally frame. In a drill a received death fails
; the point (the drill's judgement is first come, first served); a game or
; the match also fails the drill once the point is scored
; (ApDeathLinkMinigamePointEnd). Any other minigame is over at once.
ApDeathLinkMinigamePoll:
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
	ld a, b
	ld [wApDeathPoint], a
	ld [wApDeathApplied], a
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	jr nz, .gameOver
	ld a, WINLOSE_LOSE
	ld [wDrillPointJudgement], a
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ret
.gameOver:
	ld a, 1
	ld [wMatchSimFrozen], a
	ld a, WINLOSE_LOSE
	ld [wPointWinLoseFlag], a
	ld d, BANNER_GAME_OVER
	farcall ShowMinigamePointResult
	xor a
	ld [wMatchSimFrozen], a
	ld a, MATCHABORT_MATCH | MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ret

; RunMinigamePointLoop, after the point-end hook: a drill point lost to the
; player's own play waits in wApDeathDrillPending, as the drill may end on it
ApDeathLinkMinigamePointEnd:
	ld a, [wGameMode]
	cp GAMEMODE_TRAINING_DRILL
	ret nz
	ld a, [wApDeathPoint]
	and a
	jr nz, .received
	ld a, [wDrillPointJudgement]
	cp WINLOSE_LOSE
	ret nz
	ld a, AP_DEATHLINK_POINT
	ld [wApDeathDrillPending], a
	ret
.received:
	cp AP_DEATHLINK_GAME
	ret c
	ld a, WINLOSE_LOSE
	ld [wPointWinLoseFlag], a
	ld hl, wMatchAbortFlag
	set MATCHABORTB_MATCH, [hl]
	ret

; RunMinigamePointLoop, as each point starts: the drill went on, so the
; point lost before this one is reported
ApDeathLinkMinigamePointStart:
	xor a
	ld [wApDeathPoint], a
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
