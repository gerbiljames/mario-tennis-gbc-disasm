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
	ld b, $00
	call QueueDrillResultMessage
	call RecordDrillTargetZoneHit
	call CheckDrillTargetZoneMissed
	or a
	jp nz, .hitTarget
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_3
	ld b, $00
	call QueueDrillResultMessage
	ld hl, wDrillCounters + 3
	inc [hl]
	jp .storeMatchAbortFlag
.ignoreRallyTick:
	xor a
	ret
.hitTarget:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, $01
	ret
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, $ff
	ret
