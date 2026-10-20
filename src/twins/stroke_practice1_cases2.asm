; Shared by StrokePractice1Cases2, StrokePractice3Cases2 (bank $0b).

{TWIN_LABEL}:
	xor a
	ret
.checkBallBounceCount:
	ld a, [wBallBounceCount]
	cp $01
	ld a, $00
	ret nz
	ld a, DRILLMSG_NICE_RETURN_YOU_DID_IT
	ld b, DRILLWORDING_SAME
	call QueueDrillResultMessage
	call RecordDrillTargetZoneMiss
	call CheckDrillTargetZoneHit
	or a
	jp nz, .hitTarget
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_3
	ld b, DRILLWORDING_SAME
	call QueueDrillResultMessage
	ld hl, wDrillCounters + DRILLCTR_OFF_TARGET
	inc [hl]
	jp .missedTarget
.ignoreRallyTick:
	xor a
	ret
.hitTarget:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, WINLOSE_WIN
	ret
.missedTarget:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, WINLOSE_LOSE
	ret
