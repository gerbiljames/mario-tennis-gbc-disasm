; Shared by StrokePractice1EvaluateResult, StrokePractice3EvaluateResult (bank
; $0b).

{TWIN_LABEL}:
	ld a, [wDrillCounters + 2]
	cp $04
	jr nz, .ne04
	xor a
	ld [wDrillLessonResult], a
	ld a, $01
	ret
.ne04:
	ld a, [wDrillCounters + 1]
	cp $04
	jr c, .compare
	ld a, $01
	ld [wDrillLessonResult], a
	jr .notFound
.compare:
	cp $02
	jr c, .lt02
	ld a, $02
	ld [wDrillLessonResult], a
	jr .notFound
.lt02:
	ld a, [wDrillCounters + 2]
	or a
	jr nz, .compare2
	ld a, $03
	ld [wDrillLessonResult], a
	jr .notFound
.compare2:
	cp $03
	jr nz, .ne03
	ld a, $05
	ld [wDrillLessonResult], a
	jr .notFound
.ne03:
	ld a, $04
	ld [wDrillLessonResult], a
	jr .notFound
.notFound:
	ld a, $ff
	ret
