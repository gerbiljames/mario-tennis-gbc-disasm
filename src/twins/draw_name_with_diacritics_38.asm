; DrawNameWithDiacritics_<bank>, one copy in each of banks $38, $3b.

DrawNameWithDiacritics_{TWIN}:
	push af
	push bc
.charLoop:
	ld a, [hl]
	cp $00
	jr z, .done
	ld [de], a
	inc hl
	ld a, [hl]
	cp $de
	jr z, .markChar
	cp $df
	jr nz, .nextCell
.markChar:
	push hl
	push bc
	ld h, d
	ld l, e
	ld bc, $ffe0
	add hl, bc
	ld b, a
	ld a, [hl]
	cp $03
	ld a, b
	jr nz, .writeMark
	sub $d0
.writeMark:
	ld [hl], a
	pop bc
	pop hl
	inc hl
.nextCell:
	inc de
	ld a, e
	and $1f
	jr nz, .charLoop
	push hl
	ld h, d
	ld l, e
	add hl, de
	ld d, h
	ld e, l
	pop hl
	jr .charLoop
.done:
	pop bc
	pop af
	ret
