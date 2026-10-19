; Shared by StrokePractice1EvaluateResult, StrokePractice3EvaluateResult (bank
; $0b).

{TWIN_LABEL}:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	cp $04
	jr nz, .checkCounter1
	xor a
	ld [wDrillLessonResult], a
	ld a, $01
	ret
.checkCounter1:
	ld a, [wDrillCounters + DRILLCTR_OUTS]
	cp $04
	jr c, .compare
	ld a, $01
	ld [wDrillLessonResult], a
	jr .notFound
.compare:
	cp $02
	jr c, .checkCounter2
	ld a, $02
	ld [wDrillLessonResult], a
	jr .notFound
.checkCounter2:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	or a
	jr nz, .compare2
	ld a, $03
	ld [wDrillLessonResult], a
	jr .notFound
.compare2:
	cp $03
	jr nz, .result4
	ld a, $05
	ld [wDrillLessonResult], a
	jr .notFound
.result4:
	ld a, $04
	ld [wDrillLessonResult], a
	jr .notFound
.notFound:
	ld a, $ff
	ret
