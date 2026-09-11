; DrawNameWithDiacritics_<bank>: one routine assembled into banks $17, $1b, $3e through
; `twin draw_name_with_diacritics, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

DrawNameWithDiacritics_{TWIN}:
	push af
	push bc
.loop:
	ld a, [hl]
	cp $00
	jr z, .restore
	ld [de], a
	inc hl
	ld a, [hl]
	cp $de
	jr z, .eqde
	cp $df
	jr nz, .nedf
.eqde:
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
	jr nz, .store
	sub $d0
.store:
	ld [hl], a
	pop bc
	pop hl
	inc hl
.nedf:
	inc de
	ld a, e
	and $1f
	jr nz, .loop
	push hl
	ld h, d
	ld l, e
	add hl, de
	ld d, h
	ld e, l
	pop hl
	jr .loop
.restore:
	pop bc
	pop af
	ret
