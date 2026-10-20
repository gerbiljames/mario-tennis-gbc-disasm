; Shared by StrokePractice1EvaluateResult, StrokePractice3EvaluateResult (bank
; $0b).

{TWIN_LABEL}:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	cp DRILL_LESSON_POINTS
	jr nz, .checkCounter1
	ASSERT LESSON_PASSED == 0
	xor a
	ld [wDrillLessonResult], a
	ld a, WINLOSE_WIN
	ret
.checkCounter1:
	ld a, [wDrillCounters + DRILLCTR_OUTS]
	cp DRILL_LESSON_POINTS
	jr c, .counter1Below4
	ld a, LESSON_RETURN_ALL_OUT
	ld [wDrillLessonResult], a
	jr .lessonFailed
.counter1Below4:
	cp $02
	jr c, .checkCounter2
	ld a, LESSON_RETURN_INACCURATE
	ld [wDrillLessonResult], a
	jr .lessonFailed
.checkCounter2:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	or a
	jr nz, .counter2NonZero
	ld a, LESSON_RETURN_NO_PASSES
	ld [wDrillLessonResult], a
	jr .lessonFailed
.counter2NonZero:
	cp DRILL_LESSON_POINTS - 1
	jr nz, .result4
	ld a, LESSON_RETURN_ALMOST
	ld [wDrillLessonResult], a
	jr .lessonFailed
.result4:
	ld a, LESSON_RETURN_INCONSISTENT
	ld [wDrillLessonResult], a
	jr .lessonFailed
.lessonFailed:
	ld a, WINLOSE_LOSE
	ret
