DrawSelectionBoxCorners:
	push de ; $4048
	push bc ; $4049
	ld c, $00 ; $404a
	call ApplySelectionBoxWobbleX ; $404c
	ld c, $00 ; $404f
	call ApplySelectionBoxWobbleY ; $4051
	sprite_tile_attr $00, OAM_BANK1 ; $4054
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP ; $406d
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP ; $408a
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP ; $40a2
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
; Instruction-identical to Unused_1b_DrawCornerBrackets, Unused_38_DrawCornerBrackets and Unused_3b_DrawCornerBrackets (one copy per bank); a change here belongs in every copy.
	twin_in draw_corner_brackets, Unused_3e_DrawCornerBrackets, 3e ; $40ff Unused_3e_DrawCornerBrackets
; Instruction-identical to MoveMenuCursorGrid_38 and MoveMenuCursorGrid_3b (one copy per bank); a change here belongs in every copy.
	twin move_menu_cursor_grid, 3e ; $413a MoveMenuCursorGrid_3e
; Instruction-identical to Unused_16_MoveMenuCursorGridFromLinkInput and Unused_38_MoveMenuCursorGridFromLinkInput (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in move_menu_cursor_grid_from_link_input, Unused_3e_MoveMenuCursorGridFromLinkInput, 3e ; $41b8 Unused_3e_MoveMenuCursorGridFromLinkInput
; Instruction-identical to Unused_16_MoveMenuCursorGridRemote and Unused_38_MoveMenuCursorGridRemote (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in move_menu_cursor_grid_remote, Unused_3e_MoveMenuCursorGridRemote, 3e ; $4235 Unused_3e_MoveMenuCursorGridRemote
; Instruction-identical to Unused_16_MoveMenuCursor2GridRemote (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in move_menu_cursor2_grid_remote, Unused_3e_MoveMenuCursor2GridRemote, 3e ; $4300 Unused_3e_MoveMenuCursor2GridRemote
; Instruction-identical to Unused_16_GetMenuCursorIndex, GetMenuCursorIndex_1b, GetMenuCursorIndex_38 and GetMenuCursorIndex_3b (one copy per bank); a change here belongs in every copy.
	twin_in get_menu_cursor_index, GetMenuCursorIndex_3e, 3e ; $43c9 GetMenuCursorIndex_3e
