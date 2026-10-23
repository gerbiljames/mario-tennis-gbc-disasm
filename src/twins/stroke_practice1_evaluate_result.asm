; Shared by StrokePractice1EvaluateResult, StrokePractice3EvaluateResult (bank
; $0b).

{TWIN_LABEL}:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	cp DRILL_LESSON_POINTS
	jr nz, .checkOuts
	ASSERT LESSON_PASSED == 0
	xor a
	ld [wDrillLessonResult], a
	ld a, WINLOSE_WIN
	ret
.checkOuts:
	ld a, [wDrillCounters + DRILLCTR_OUTS]
	cp DRILL_LESSON_POINTS
	jr c, .notAllOut
	ld a, LESSON_RETURN_ALL_OUT
	ld [wDrillLessonResult], a
	jr .lessonFailed
.notAllOut:
	cp $02
	jr c, .checkPasses
	ld a, LESSON_RETURN_INACCURATE
	ld [wDrillLessonResult], a
	jr .lessonFailed
.checkPasses:
	ld a, [wDrillCounters + DRILLCTR_STROKE_PASSES]
	or a
	jr nz, .somePasses
	ld a, LESSON_RETURN_NO_PASSES
	ld [wDrillLessonResult], a
	jr .lessonFailed
.somePasses:
	cp DRILL_LESSON_POINTS - 1
	jr nz, .inconsistent
	ld a, LESSON_RETURN_ALMOST
	ld [wDrillLessonResult], a
	jr .lessonFailed
.inconsistent:
	ld a, LESSON_RETURN_INCONSISTENT
	ld [wDrillLessonResult], a
	jr .lessonFailed
.lessonFailed:
	ld a, WINLOSE_LOSE
	ret
