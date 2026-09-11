; One body under 2 names (banks $0b, $0b), assembled through
; `twin_named stroke_practice1_evaluate_result, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

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
