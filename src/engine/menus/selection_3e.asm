DrawSelectionBoxCorners:
	push de ; $4048
	push bc ; $4049
	ld c, $00 ; $404a
	call ApplySelectionBoxWobbleX ; $404c
	ld c, $00 ; $404f
	call ApplySelectionBoxWobbleY ; $4051
	ld c, $00 ; $4054
	ld b, $08 ; $4056
	call QueueSprite ; $4058
	pop bc ; $405b
	pop de ; $405c
	push de ; $405d
	push bc ; $405e
	ld a, b ; $405f
	add d ; $4060
	ld d, a ; $4061
	push de ; $4062
	ld c, $01 ; $4063
	call ApplySelectionBoxWobbleX ; $4065
	ld c, $00 ; $4068
	call ApplySelectionBoxWobbleY ; $406a
	ld c, $00 ; $406d
	ld b, $28 ; $406f
	call QueueSprite ; $4071
	pop de ; $4074
	pop bc ; $4075
	pop de ; $4076
	push de ; $4077
	push bc ; $4078
	ld a, c ; $4079
	add e ; $407a
	ld e, a ; $407b
	ld a, b ; $407c
	add d ; $407d
	ld d, a ; $407e
	push de ; $407f
	ld c, $01 ; $4080
	call ApplySelectionBoxWobbleX ; $4082
	ld c, $01 ; $4085
	call ApplySelectionBoxWobbleY ; $4087
	ld c, $00 ; $408a
	ld b, $68 ; $408c
	call QueueSprite ; $408e
	pop de ; $4091
	pop bc ; $4092
	pop de ; $4093
	ld a, e ; $4094
	add c ; $4095
	ld e, a ; $4096
	push de ; $4097
	ld c, $00 ; $4098
	call ApplySelectionBoxWobbleX ; $409a
	ld c, $01 ; $409d
	call ApplySelectionBoxWobbleY ; $409f
	ld c, $00 ; $40a2
	ld b, $48 ; $40a4
	call QueueSprite ; $40a6
	pop de ; $40a9
	ret ; $40aa
ApplySelectionBoxWobbleX:
	ldh a, [hVBlankCounter] ; $40ab
	and $0f ; $40ad
	ld hl, SelectionBoxWobbleXTable_3e ; $40af
	add l ; $40b2
	ld l, a ; $40b3
	jr nc, .readOffset ; $40b4
	inc h ; $40b6
.readOffset:
	ld a, [hl] ; $40b7
	ld b, a ; $40b8
	ld a, c ; $40b9
	or a ; $40ba
	jr z, .subtract ; $40bb
	ld a, b ; $40bd
	add d ; $40be
	ld d, a ; $40bf
	ret ; $40c0
.subtract:
	ld a, d ; $40c1
	sub b ; $40c2
	ld d, a ; $40c3
	ret ; $40c4
SelectionBoxWobbleXTable_3e:
	; $40c5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySelectionBoxWobbleY:
	ldh a, [hVBlankCounter] ; $40d5
	and $0f ; $40d7
	ld hl, SelectionBoxWobbleYTable_3e ; $40d9
	add l ; $40dc
	ld l, a ; $40dd
	jr nc, .readOffset ; $40de
	inc h ; $40e0
.readOffset:
	ld a, [hl] ; $40e1
	ld b, a ; $40e2
	ld a, c ; $40e3
	or a ; $40e4
	jr z, .subtract ; $40e5
	ld a, b ; $40e7
	add e ; $40e8
	ld e, a ; $40e9
	ret ; $40ea
.subtract:
	ld a, e ; $40eb
	sub b ; $40ec
	ld e, a ; $40ed
	ret ; $40ee
SelectionBoxWobbleYTable_3e:
	INCBIN "data/bank_03e/SelectionBoxWobbleYTable_3e.bin" ; $40ef, 16 bytes
; Instruction-identical to DrawCornerBrackets_1b, DrawCornerBrackets_38 and DrawCornerBrackets_3b (one copy per bank); a change here belongs in every copy.
	twin draw_corner_brackets, 3e ; $40ff DrawCornerBrackets_3e
; Instruction-identical to MoveMenuCursorGrid_38 and MoveMenuCursorGrid_3b (one copy per bank); a change here belongs in every copy.
	twin move_menu_cursor_grid, 3e ; $413a MoveMenuCursorGrid_3e
; Instruction-identical to MoveMenuCursorGridFromLinkInput_16 and MoveMenuCursorGridFromLinkInput_38 (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor_grid_from_link_input, 3e ; $41b8 MoveMenuCursorGridFromLinkInput_3e
; Instruction-identical to MoveMenuCursorGridRemote_16 and MoveMenuCursorGridRemote_38 (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor_grid_remote, 3e ; $4235 MoveMenuCursorGridRemote_3e
; Instruction-identical to MoveMenuCursor2GridRemote_16 (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor2_grid_remote, 3e ; $4300 MoveMenuCursor2GridRemote_3e
; Instruction-identical to GetMenuCursorIndex_16, GetMenuCursorIndex_1b, GetMenuCursorIndex_38 and GetMenuCursorIndex_3b (one copy per bank); a change here belongs in every copy.
	twin get_menu_cursor_index, 3e ; $43c9 GetMenuCursorIndex_3e
