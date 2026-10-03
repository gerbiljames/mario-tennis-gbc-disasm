	farptr Unused_17_ShowCourtDiagramTestScreen ; $4000
DataPtr_CourtDiagramTiles:
	dw CourtDiagramTiles ; $4002
DataPtr_CourtDiagramTilemap:
	dw CourtDiagramTilemap ; $4004
DataPtr_CourtDiagramAttrmap:
	dw CourtDiagramAttrmap ; $4006
DataPtr_CourtDiagramPalettes:
	dw CourtDiagramPalettes ; $4008
	farptr ShowDrillBriefingScreen ; $400a
	farptr ShowRulesScreen ; $400c
DataPtr_RulesScreenTiles:
	dw RulesScreenTiles ; $400e
DataPtr_RulesScreenTilemap:
	dw RulesScreenTilemap ; $4010
DataPtr_RulesScreenAttrmap:
	dw RulesScreenAttrmap ; $4012
DataPtr_RulesScreenPalettes:
	dw RulesScreenPalettes ; $4014
Unused_17_DrawWobblingCornerBrackets:
	push de ; $4016
	push bc ; $4017
	ld c, $00 ; $4018
	call Unused_17_ApplySpriteWobbleX ; $401a
	ld c, $00 ; $401d
	call ApplySpriteWobbleY_17 ; $401f
	sprite_tile_attr $00, OAM_BANK1 ; $4022
	call QueueSprite ; $4026
	pop bc ; $4029
	pop de ; $402a
	push de ; $402b
	push bc ; $402c
	ld a, b ; $402d
	add d ; $402e
	ld d, a ; $402f
	push de ; $4030
	ld c, $01 ; $4031
	call Unused_17_ApplySpriteWobbleX ; $4033
	ld c, $00 ; $4036
	call ApplySpriteWobbleY_17 ; $4038
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP ; $403b
	call QueueSprite ; $403f
	pop de ; $4042
	pop bc ; $4043
	pop de ; $4044
	push de ; $4045
	push bc ; $4046
	ld a, c ; $4047
	add e ; $4048
	ld e, a ; $4049
	ld a, b ; $404a
	add d ; $404b
	ld d, a ; $404c
	push de ; $404d
	ld c, $01 ; $404e
	call Unused_17_ApplySpriteWobbleX ; $4050
	ld c, $01 ; $4053
	call ApplySpriteWobbleY_17 ; $4055
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP ; $4058
	call QueueSprite ; $405c
	pop de ; $405f
	pop bc ; $4060
	pop de ; $4061
	ld a, e ; $4062
	add c ; $4063
	ld e, a ; $4064
	push de ; $4065
	ld c, $00 ; $4066
	call Unused_17_ApplySpriteWobbleX ; $4068
	ld c, $01 ; $406b
	call ApplySpriteWobbleY_17 ; $406d
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP ; $4070
	call QueueSprite ; $4074
	pop de ; $4077
	ret ; $4078
