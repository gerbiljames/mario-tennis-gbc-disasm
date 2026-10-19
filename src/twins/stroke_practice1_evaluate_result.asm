; Shared by StrokePractice1EvaluateResult, StrokePractice3EvaluateResult (bank
; $0b).

{TWIN_LABEL}:
	ld a, [wDrillCounters + 2]
	cp $04
	jr nz, .checkCounter1
	xor a
	ld [wDrillLessonResult], a
	ld a, $01
	ret
.checkCounter1:
	ld a, [wDrillCounters + 1]
	cp $04
	jr c, .counter1Below4
	ld a, $01
	ld [wDrillLessonResult], a
	jr .notFound
.counter1Below4:
	cp $02
	jr c, .checkCounter2
	ld a, $02
	ld [wDrillLessonResult], a
	jr .notFound
.checkCounter2:
	ld a, [wDrillCounters + 2]
	or a
	jr nz, .counter2NonZero
	ld a, $03
	ld [wDrillLessonResult], a
	jr .notFound
.counter2NonZero:
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
