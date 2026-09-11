; One body under 2 names (banks $0d, $0d), assembled through
; `twin_named tennis_machine4_hook__point_start, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	farcall AdvanceMatchRng
	and $07
	inc a
	ld hl, wMinigameServeSlot
	add [hl]
	cp $09
	jr c, .store
	sub $09
.store:
	ld [hl], a
	call LaunchMinigameServe
	ret
