	farptr RunMatchWinLoseScreen ; $4000
	farptr RunMatchStatsScreen ; $4002
	farptr DecompressCharacterPortrait ; $4004
Unused_16_DrawWobblingCornerBrackets:
	push de ; $4006
	push bc ; $4007
	ld c, $00 ; $4008
	call ApplySpriteWobbleX_16 ; $400a
	ld c, $00 ; $400d
	call ApplySpriteWobbleY_16 ; $400f
	ld c, $00 ; $4012
	ld b, $08 ; $4014
	call QueueSprite ; $4016
	pop bc ; $4019
	pop de ; $401a
	push de ; $401b
	push bc ; $401c
	ld a, b ; $401d
	add d ; $401e
	ld d, a ; $401f
	push de ; $4020
	ld c, $01 ; $4021
	call ApplySpriteWobbleX_16 ; $4023
	ld c, $00 ; $4026
	call ApplySpriteWobbleY_16 ; $4028
	ld c, $00 ; $402b
	ld b, $28 ; $402d
	call QueueSprite ; $402f
	pop de ; $4032
	pop bc ; $4033
	pop de ; $4034
	push de ; $4035
	push bc ; $4036
	ld a, c ; $4037
	add e ; $4038
	ld e, a ; $4039
	ld a, b ; $403a
	add d ; $403b
	ld d, a ; $403c
	push de ; $403d
	ld c, $01 ; $403e
	call ApplySpriteWobbleX_16 ; $4040
	ld c, $01 ; $4043
	call ApplySpriteWobbleY_16 ; $4045
	ld c, $00 ; $4048
	ld b, $68 ; $404a
	call QueueSprite ; $404c
	pop de ; $404f
	pop bc ; $4050
	pop de ; $4051
	ld a, e ; $4052
	add c ; $4053
	ld e, a ; $4054
	push de ; $4055
	ld c, $00 ; $4056
	call ApplySpriteWobbleX_16 ; $4058
	ld c, $01 ; $405b
	call ApplySpriteWobbleY_16 ; $405d
	ld c, $00 ; $4060
	ld b, $48 ; $4062
	call QueueSprite ; $4064
	pop de ; $4067
	ret ; $4068
; Instruction-identical to ApplySpriteWobbleX_17 (one copy per bank); a change here belongs in every copy.
	twin apply_sprite_wobble_x, 16 ; $4069 ApplySpriteWobbleX_16
SpriteWobbleXTable_16:
	; $4083, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to ApplySpriteWobbleY_17 (one copy per bank); a change here belongs in every copy.
	twin apply_sprite_wobble_y, 16 ; $4093 ApplySpriteWobbleY_16
SpriteWobbleYTable_16:
	; $40ad, 32 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	db $d5, $c5, $0e, $00, $06, $09, $cd, $51, $1f, $c1, $d1, $d5, $c5, $78, $82, $57 ; 0x10
DrawCornerBrackets_16:
	push de ; $40cd
	ld c, $00 ; $40ce
	ld b, $29 ; $40d0
	call QueueSprite ; $40d2
	pop de ; $40d5
	pop bc ; $40d6
	pop de ; $40d7
	push de ; $40d8
	push bc ; $40d9
	ld a, c ; $40da
	add e ; $40db
	ld e, a ; $40dc
	ld a, b ; $40dd
	add d ; $40de
	ld d, a ; $40df
	push de ; $40e0
	ld c, $00 ; $40e1
	ld b, $69 ; $40e3
	call QueueSprite ; $40e5
	pop de ; $40e8
	pop bc ; $40e9
	pop de ; $40ea
	ld a, e ; $40eb
	add c ; $40ec
	ld e, a ; $40ed
	push de ; $40ee
	ld c, $00 ; $40ef
	ld b, $49 ; $40f1
	call QueueSprite ; $40f3
	pop de ; $40f6
	ret ; $40f7
Unused_16_MoveMenuCursorGrid:
	ld a, [wMenuCursorX] ; $40f8
	ld d, a ; $40fb
	ld a, [wMenuCursorY] ; $40fc
	ld e, a ; $40ff
	ld a, [wMenuInputPressed] ; $4100
	bit 4, a ; $4103
	jr z, .checkLeft ; $4105
	ld a, [wMenuCursorX] ; $4107
	inc a ; $410a
	add a ; $410b
	jr nc, .wrapRight ; $410c
	ld a, b ; $410e
	dec a ; $410f
	jr .storeRight ; $4110
.wrapRight:
	rra ; $4112
	cp b ; $4113
	jr c, .storeRight ; $4114
	xor a ; $4116
.storeRight:
	ld [wMenuCursorX], a ; $4117
	jr .compare ; $411a
.checkLeft:
	bit 5, a ; $411c
	jr z, .checkUp ; $411e
	ld a, [wMenuCursorX] ; $4120
	dec a ; $4123
	add a ; $4124
	jr nc, .wrapLeft ; $4125
	ld a, b ; $4127
	dec a ; $4128
	jr .storeLeft ; $4129
.wrapLeft:
	rra ; $412b
	cp b ; $412c
	jr c, .storeLeft ; $412d
	xor a ; $412f
.storeLeft:
	ld [wMenuCursorX], a ; $4130
	jr .compare ; $4133
.checkUp:
	bit 6, a ; $4135
	jr z, .checkDown ; $4137
	ld a, [wMenuCursorY] ; $4139
	dec a ; $413c
	add a ; $413d
	jr nc, .wrapUp ; $413e
	ld a, c ; $4140
	dec a ; $4141
	jr .storeUp ; $4142
.wrapUp:
	rra ; $4144
	cp c ; $4145
	jr c, .storeUp ; $4146
	xor a ; $4148
.storeUp:
	ld [wMenuCursorY], a ; $4149
	jr .compare ; $414c
.checkDown:
	bit 7, a ; $414e
	jr z, .compare ; $4150
	ld a, [wMenuCursorY] ; $4152
	inc a ; $4155
	add a ; $4156
	jr nc, .wrapDown ; $4157
	ld a, c ; $4159
	dec a ; $415a
	jr .storeDown ; $415b
.wrapDown:
	rra ; $415d
	cp c ; $415e
	jr c, .storeDown ; $415f
	xor a ; $4161
.storeDown:
	ld [wMenuCursorY], a ; $4162
.compare:
	ld a, [wMenuCursorX] ; $4165
	cp d ; $4168
	jr nz, .moved ; $4169
	ld a, [wMenuCursorY] ; $416b
	cp e ; $416e
	jr nz, .moved ; $416f
	xor a ; $4171
	ret ; $4172
.moved:
	ld a, $01 ; $4173
	ret ; $4175
; Instruction-identical to MoveMenuCursorGridFromLinkInput_38 and MoveMenuCursorGridFromLinkInput_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor_grid_from_link_input, 16 ; $4176 MoveMenuCursorGridFromLinkInput_16
; Instruction-identical to MoveMenuCursorGridRemote_38 and MoveMenuCursorGridRemote_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor_grid_remote, 16 ; $41f3 MoveMenuCursorGridRemote_16
; Instruction-identical to MoveMenuCursor2GridRemote_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor2_grid_remote, 16 ; $42be MoveMenuCursor2GridRemote_16
; Instruction-identical to GetMenuCursorIndex_1b, GetMenuCursorIndex_38, GetMenuCursorIndex_3b and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin get_menu_cursor_index, 16 ; $4387 GetMenuCursorIndex_16
