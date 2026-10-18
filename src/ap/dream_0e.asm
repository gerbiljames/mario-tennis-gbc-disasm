; Archipelago: dream_match_difficulty. The Special Court entry Peach's first
; offer leads to (1 Hard, 2 Intense, 3 MAX; +3 in doubles), vanilla Intense
; while ApOptDreamDifficulty is 0
ApDreamMatchEntry_0e:
	ld a, [ApOptDreamDifficulty]
	and a
	jr nz, .arc
	ld a, 2
.arc:
	push af
	test_flag FLAG_DOUBLES
	pop bc
	ld a, b
	ret z
	add 3
	ret
