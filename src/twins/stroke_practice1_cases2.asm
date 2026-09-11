; One body under 2 names (banks $0b, $0b), assembled through
; `twin_named stroke_practice1_cases2, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	xor a
	ret
.checkBallBounceCount:
	ld a, [wBallBounceCount]
	cp $01
	ld a, $00
	ret nz
	ld a, $57
	ld b, $00
	call QueueDrillResultMessage
	call RecordDrillTargetZoneHit
	call CheckDrillTargetZoneMissed
	or a
	jp nz, .nonZero
	ld a, $5a
	ld b, $00
	call QueueDrillResultMessage
	ld hl, wDrillCounters + 3
	inc [hl]
	jp .storeMatchAbortFlag
.storeMatchAbortFlag2:
	xor a
	ret
.nonZero:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, $01
	ret
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT
	ld [wMatchAbortFlag], a
	ld a, $ff
	ret
