; Archipelago: faster EXP distribution. Select gives the highlighted character
; the whole pool; a held increase past full speed keeps speeding up.

; From RunExpDistributionLoop on a new Select press: every point left to the
; highlighted character, a point at a time so each level-up is checked, then
; the finish the pool running dry would take
ApAssignAllExp:
	wram_bank WRAM_SCENE
	ld a, [wExpCursorChar]
	bit 0, a
	jp nz, RunExpDistributionLoop
	call AssignExpPointToChar
	and a
	jp z, RunExpDistributionLoop
.loop:
	call AssignExpPointToChar
	and a
	jr nz, .loop
	sound SFX_MENU_SELECT
	call RefreshExpScreenReadouts
	wram_bank WRAM_SCENE
	ld hl, wExpCursorChar
	res 1, [hl]
	ld a, $a8
	ld [wExpBarMarkerX], a
	jp CheckExpLevelDown.step2

; The full-speed increase's extra points this frame: 1, doubling every 32
; frames held (wExpInputRepeating) up to 64
ApAssignExpBurst:
	wram_bank WRAM_SCENE
	ld a, [wExpInputRepeating]
	swap a
	srl a
	and $07
	cp 7
	jr c, .shift
	ld a, 6
.shift:
	ld b, a
	ld c, 1
	and a
	jr z, .loop
.double:
	sla c
	dec b
	jr nz, .double
.loop:
	push bc
	call AssignExpPointToChar
	pop bc
	and a
	ret z
	dec c
	jr nz, .loop
	ret
