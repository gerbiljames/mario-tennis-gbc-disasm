Unused_3b_QueueBouncingCursorCorners:
	push de ; $4038
	push bc ; $4039
	ld c, BOBDIR_NEG ; $403a
	call ApplyCursorBounceX ; $403c
	ld c, BOBDIR_NEG ; $403f
	call ApplyCursorBounceY ; $4041
	sprite_tile_attr $00, OAM_BANK1 ; $4044
	call QueueSprite ; $4048
	pop bc ; $404b
	pop de ; $404c
	push de ; $404d
	push bc ; $404e
	ld a, b ; $404f
	add d ; $4050
	ld d, a ; $4051
	push de ; $4052
	ld c, BOBDIR_POS ; $4053
	call ApplyCursorBounceX ; $4055
	ld c, BOBDIR_NEG ; $4058
	call ApplyCursorBounceY ; $405a
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP ; $405d
	call QueueSprite ; $4061
	pop de ; $4064
	pop bc ; $4065
	pop de ; $4066
	push de ; $4067
	push bc ; $4068
	ld a, c ; $4069
	add e ; $406a
	ld e, a ; $406b
	ld a, b ; $406c
	add d ; $406d
	ld d, a ; $406e
	push de ; $406f
	ld c, BOBDIR_POS ; $4070
	call ApplyCursorBounceX ; $4072
	ld c, BOBDIR_POS ; $4075
	call ApplyCursorBounceY ; $4077
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP ; $407a
	call QueueSprite ; $407e
	pop de ; $4081
	pop bc ; $4082
	pop de ; $4083
	ld a, e ; $4084
	add c ; $4085
	ld e, a ; $4086
	push de ; $4087
	ld c, BOBDIR_NEG ; $4088
	call ApplyCursorBounceX ; $408a
	ld c, BOBDIR_POS ; $408d
	call ApplyCursorBounceY ; $408f
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP ; $4092
	call QueueSprite ; $4096
	pop de ; $4099
	ret ; $409a
ApplyCursorBounceX:
	ldh a, [hVBlankCounter] ; $409b
	and $0f ; $409d
	ld hl, CursorBounceXTable ; $409f
	add_hl_a ; $40a2
	ld a, [hl] ; $40a7
	ld b, a ; $40a8
	ld a, c ; $40a9
	or a ; $40aa
	jr z, .subtract ; $40ab
	ld a, b ; $40ad
	add d ; $40ae
	ld d, a ; $40af
	ret ; $40b0
.subtract:
	ld a, d ; $40b1
	sub b ; $40b2
	ld d, a ; $40b3
	ret ; $40b4
CursorBounceXTable:
	; $40b5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplyCursorBounceY:
	ldh a, [hVBlankCounter] ; $40c5
	and $0f ; $40c7
	ld hl, CursorBounceYTable ; $40c9
	add_hl_a ; $40cc
	ld a, [hl] ; $40d1
	ld b, a ; $40d2
	ld a, c ; $40d3
	or a ; $40d4
	jr z, .subtract ; $40d5
	ld a, b ; $40d7
	add e ; $40d8
	ld e, a ; $40d9
	ret ; $40da
.subtract:
	ld a, e ; $40db
	sub b ; $40dc
	ld e, a ; $40dd
	ret ; $40de
CursorBounceYTable:
	; $40df, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	twin_in draw_corner_brackets, Unused_3b_DrawCornerBrackets, 3b ; $40ef Unused_3b_DrawCornerBrackets
	twin move_menu_cursor_grid, 3b ; $412a MoveMenuCursorGrid_3b
	twin_in move_menu_cursor_grid_from_link_input, Unused_3b_MoveMenuCursorGridFromLinkInput, 3b ; $41a8 Unused_3b_MoveMenuCursorGridFromLinkInput
	twin_in move_menu_cursor_grid_remote, Unused_3b_MoveMenuCursorGridRemote, 3b ; $4225 Unused_3b_MoveMenuCursorGridRemote
	twin_in move_menu_cursor2_grid_remote, Unused_3b_MoveMenuCursor2GridRemote, 3b ; $42f0 Unused_3b_MoveMenuCursor2GridRemote
	twin_in get_menu_cursor_index, GetMenuCursorIndex_3b, 3b ; $43b9 GetMenuCursorIndex_3b
