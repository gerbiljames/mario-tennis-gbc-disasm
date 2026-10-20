DataPtr_FrankWalkSprite:
	dw FrankWalkSprite ; $4000
DataPtr_EllisWalkSprite:
	dw EllisWalkSprite ; $4002
DataPtr_WalkSprite_6f_02:
	dw WalkSprite_6f_02 ; $4004
DataPtr_ProgramSellerWalkSprite:
	dw ProgramSellerWalkSprite ; $4006
DataPtr_SouvenirSellerWalkSprite:
	dw SouvenirSellerWalkSprite ; $4008
DataPtr_IslandSpectatorAWalkSprite:
	dw IslandSpectatorAWalkSprite ; $400a
DataPtr_IslandSpectatorBWalkSprite:
	dw IslandSpectatorBWalkSprite ; $400c
DataPtr_TournamentStaffWalkSprite:
	dw TournamentStaffWalkSprite ; $400e
FrankWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, FrankWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw FrankWalkSprite_Gfx00, FrankWalkSprite_Gfx01, FrankWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw FrankWalkSprite_Gfx02 ; $4020
	dw FrankWalkSprite_Gfx02 ; $4022
	dw FrankWalkSprite_Gfx02 ; $4024
	dw FrankWalkSprite_Gfx02 ; $4026
	dw FrankWalkSprite_Gfx03 ; $4028
	dw FrankWalkSprite_Gfx04 ; $402a
	dw FrankWalkSprite_Gfx05 ; $402c
	db $00 ; $402e
	db $00 ; $402f
	ds ALIGN[4]
FrankWalkSprite_Gfx00:
	INCBIN "data/sprites/FrankWalkSprite_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
FrankWalkSprite_Gfx01:
	INCBIN "data/sprites/FrankWalkSprite_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
FrankWalkSprite_Gfx02:
	INCBIN "data/sprites/FrankWalkSprite_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
FrankWalkSprite_Gfx03:
	INCBIN "data/sprites/FrankWalkSprite_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
FrankWalkSprite_Gfx04:
	INCBIN "data/sprites/FrankWalkSprite_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
FrankWalkSprite_Gfx05:
	INCBIN "data/sprites/FrankWalkSprite_Gfx05.bin" ; $4530, 256 bytes
FrankWalkSprite_AnimPtrs:
	dw FrankWalkSprite_AnimStill ; $4630
	dw FrankWalkSprite_AnimWalk ; $4632
	dw FrankWalkSprite_AnimBounce ; $4634
	dw FrankWalkSprite_AnimNod ; $4636
	dw FrankWalkSprite_AnimShake ; $4638
	dw FrankWalkSprite_Anim05 ; $463a
	dw FrankWalkSprite_Anim05 ; $463c
	dw FrankWalkSprite_Anim06 ; $463e
	dw FrankWalkSprite_Anim07 ; $4640
	dw FrankWalkSprite_Anim08 ; $4642
	dw FrankWalkSprite_Anim09 ; $4644
	dw FrankWalkSprite_Anim10 ; $4646
FrankWalkSprite_AnimStill:
	; $4648, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
FrankWalkSprite_AnimWalk:
	; $464b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
FrankWalkSprite_AnimBounce:
	; $4651, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
FrankWalkSprite_AnimNod:
	; $465d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
FrankWalkSprite_AnimShake:
	; $4665, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
FrankWalkSprite_Anim05:
	; $4679, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
FrankWalkSprite_Anim06:
	; $467e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
FrankWalkSprite_Anim07:
	; $468a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
FrankWalkSprite_Anim08:
	; $4690, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
FrankWalkSprite_Anim09:
	; $4693, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
FrankWalkSprite_Anim10:
	; $4696, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
EllisWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, EllisWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw EllisWalkSprite_Gfx00, EllisWalkSprite_Gfx01, EllisWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw EllisWalkSprite_Gfx02 ; $46b1
	dw EllisWalkSprite_Gfx02 ; $46b3
	dw EllisWalkSprite_Gfx02 ; $46b5
	dw EllisWalkSprite_Gfx02 ; $46b7
	dw EllisWalkSprite_Gfx03 ; $46b9
	dw EllisWalkSprite_Gfx04 ; $46bb
	dw EllisWalkSprite_Gfx05 ; $46bd
	db $00 ; $46bf
	ds ALIGN[4]
EllisWalkSprite_Gfx00:
	INCBIN "data/sprites/EllisWalkSprite_Gfx00.bin" ; $46c0, 256 bytes
	ds ALIGN[4]
EllisWalkSprite_Gfx01:
	INCBIN "data/sprites/EllisWalkSprite_Gfx01.bin" ; $47c0, 256 bytes
	ds ALIGN[4]
EllisWalkSprite_Gfx02:
	INCBIN "data/sprites/EllisWalkSprite_Gfx02.bin" ; $48c0, 256 bytes
	ds ALIGN[4]
EllisWalkSprite_Gfx03:
	INCBIN "data/sprites/EllisWalkSprite_Gfx03.bin" ; $49c0, 256 bytes
	ds ALIGN[4]
EllisWalkSprite_Gfx04:
	INCBIN "data/sprites/EllisWalkSprite_Gfx04.bin" ; $4ac0, 256 bytes
	ds ALIGN[4]
EllisWalkSprite_Gfx05:
	INCBIN "data/sprites/EllisWalkSprite_Gfx05.bin" ; $4bc0, 256 bytes
EllisWalkSprite_AnimPtrs:
	dw EllisWalkSprite_AnimStill ; $4cc0
	dw EllisWalkSprite_AnimWalk ; $4cc2
	dw EllisWalkSprite_AnimBounce ; $4cc4
	dw EllisWalkSprite_AnimNod ; $4cc6
	dw EllisWalkSprite_AnimShake ; $4cc8
	dw EllisWalkSprite_Anim05 ; $4cca
	dw EllisWalkSprite_Anim05 ; $4ccc
	dw EllisWalkSprite_Anim06 ; $4cce
	dw EllisWalkSprite_Anim07 ; $4cd0
	dw EllisWalkSprite_Anim08 ; $4cd2
	dw EllisWalkSprite_Anim09 ; $4cd4
	dw EllisWalkSprite_Anim10 ; $4cd6
EllisWalkSprite_AnimStill:
	; $4cd8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
EllisWalkSprite_AnimWalk:
	; $4cdb, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
EllisWalkSprite_AnimBounce:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EllisWalkSprite_AnimNod:
	; $4ced, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
EllisWalkSprite_AnimShake:
	; $4cf5, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
EllisWalkSprite_Anim05:
	; $4d09, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
EllisWalkSprite_Anim06:
	; $4d0e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EllisWalkSprite_Anim07:
	; $4d1a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
EllisWalkSprite_Anim08:
	; $4d20, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
EllisWalkSprite_Anim09:
	; $4d23, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
EllisWalkSprite_Anim10:
	; $4d26, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
WalkSprite_6f_02:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_02_Gfx00, WalkSprite_6f_02_Gfx01, WalkSprite_6f_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_02_Gfx02 ; $4d41
	dw WalkSprite_6f_02_Gfx02 ; $4d43
	dw WalkSprite_6f_02_Gfx02 ; $4d45
	dw WalkSprite_6f_02_Gfx02 ; $4d47
	dw WalkSprite_6f_02_Gfx03 ; $4d49
	dw WalkSprite_6f_02_Gfx04 ; $4d4b
	dw WalkSprite_6f_02_Gfx05 ; $4d4d
	db $00 ; $4d4f
	ds ALIGN[4]
WalkSprite_6f_02_Gfx00:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx00.bin" ; $4d50, 256 bytes
	ds ALIGN[4]
WalkSprite_6f_02_Gfx01:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx01.bin" ; $4e50, 256 bytes
	ds ALIGN[4]
WalkSprite_6f_02_Gfx02:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx02.bin" ; $4f50, 256 bytes
	ds ALIGN[4]
WalkSprite_6f_02_Gfx03:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx03.bin" ; $5050, 256 bytes
	ds ALIGN[4]
WalkSprite_6f_02_Gfx04:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx04.bin" ; $5150, 256 bytes
	ds ALIGN[4]
WalkSprite_6f_02_Gfx05:
	INCBIN "data/sprites/WalkSprite_6f_02_Gfx05.bin" ; $5250, 256 bytes
WalkSprite_6f_02_AnimPtrs:
	dw WalkSprite_6f_02_AnimStill ; $5350
	dw WalkSprite_6f_02_AnimWalk ; $5352
	dw WalkSprite_6f_02_AnimBounce ; $5354
	dw WalkSprite_6f_02_AnimNod ; $5356
	dw WalkSprite_6f_02_AnimShake ; $5358
	dw WalkSprite_6f_02_Anim05 ; $535a
	dw WalkSprite_6f_02_Anim05 ; $535c
	dw WalkSprite_6f_02_Anim06 ; $535e
	dw WalkSprite_6f_02_Anim07 ; $5360
	dw WalkSprite_6f_02_Anim08 ; $5362
	dw WalkSprite_6f_02_Anim09 ; $5364
	dw WalkSprite_6f_02_Anim10 ; $5366
WalkSprite_6f_02_AnimStill:
	; $5368, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WalkSprite_6f_02_AnimWalk:
	; $536b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
WalkSprite_6f_02_AnimBounce:
	; $5371, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_6f_02_AnimNod:
	; $537d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_6f_02_AnimShake:
	; $5385, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_6f_02_Anim05:
	; $5399, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_02_Anim06:
	; $539e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_6f_02_Anim07:
	; $53aa, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
WalkSprite_6f_02_Anim08:
	; $53b0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
WalkSprite_6f_02_Anim09:
	; $53b3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
WalkSprite_6f_02_Anim10:
	; $53b6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
ProgramSellerWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, ProgramSellerWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw ProgramSellerWalkSprite_Gfx00, ProgramSellerWalkSprite_Gfx01, ProgramSellerWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw ProgramSellerWalkSprite_Gfx02 ; $53d1
	dw ProgramSellerWalkSprite_Gfx02 ; $53d3
	dw ProgramSellerWalkSprite_Gfx02 ; $53d5
	dw ProgramSellerWalkSprite_Gfx02 ; $53d7
	dw ProgramSellerWalkSprite_Gfx03 ; $53d9
	dw ProgramSellerWalkSprite_Gfx04 ; $53db
	dw ProgramSellerWalkSprite_Gfx05 ; $53dd
	db $00 ; $53df
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx00:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx00.bin" ; $53e0, 256 bytes
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx01:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx01.bin" ; $54e0, 256 bytes
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx02:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx02.bin" ; $55e0, 256 bytes
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx03:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx03.bin" ; $56e0, 256 bytes
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx04:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx04.bin" ; $57e0, 256 bytes
	ds ALIGN[4]
ProgramSellerWalkSprite_Gfx05:
	INCBIN "data/sprites/ProgramSellerWalkSprite_Gfx05.bin" ; $58e0, 256 bytes
ProgramSellerWalkSprite_AnimPtrs:
	dw ProgramSellerWalkSprite_AnimStill ; $59e0
	dw ProgramSellerWalkSprite_AnimWalk ; $59e2
	dw ProgramSellerWalkSprite_AnimBounce ; $59e4
	dw ProgramSellerWalkSprite_AnimNod ; $59e6
	dw ProgramSellerWalkSprite_AnimShake ; $59e8
	dw ProgramSellerWalkSprite_Anim05 ; $59ea
	dw ProgramSellerWalkSprite_Anim05 ; $59ec
	dw ProgramSellerWalkSprite_Anim06 ; $59ee
	dw ProgramSellerWalkSprite_Anim07 ; $59f0
	dw ProgramSellerWalkSprite_Anim08 ; $59f2
	dw ProgramSellerWalkSprite_Anim09 ; $59f4
	dw ProgramSellerWalkSprite_Anim10 ; $59f6
ProgramSellerWalkSprite_AnimStill:
	; $59f8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
ProgramSellerWalkSprite_AnimWalk:
	; $59fb, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
ProgramSellerWalkSprite_AnimBounce:
	; $5a01, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ProgramSellerWalkSprite_AnimNod:
	; $5a0d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
ProgramSellerWalkSprite_AnimShake:
	; $5a15, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
ProgramSellerWalkSprite_Anim05:
	; $5a29, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
ProgramSellerWalkSprite_Anim06:
	; $5a2e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ProgramSellerWalkSprite_Anim07:
	; $5a3a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
ProgramSellerWalkSprite_Anim08:
	; $5a40, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
ProgramSellerWalkSprite_Anim09:
	; $5a43, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
ProgramSellerWalkSprite_Anim10:
	; $5a46, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
SouvenirSellerWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SouvenirSellerWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SouvenirSellerWalkSprite_Gfx00, SouvenirSellerWalkSprite_Gfx01, SouvenirSellerWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SouvenirSellerWalkSprite_Gfx02 ; $5a61
	dw SouvenirSellerWalkSprite_Gfx02 ; $5a63
	dw SouvenirSellerWalkSprite_Gfx02 ; $5a65
	dw SouvenirSellerWalkSprite_Gfx02 ; $5a67
	dw SouvenirSellerWalkSprite_Gfx03 ; $5a69
	dw SouvenirSellerWalkSprite_Gfx04 ; $5a6b
	dw SouvenirSellerWalkSprite_Gfx05 ; $5a6d
	db $00 ; $5a6f
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx00:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx00.bin" ; $5a70, 256 bytes
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx01:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx01.bin" ; $5b70, 256 bytes
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx02:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx02.bin" ; $5c70, 256 bytes
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx03:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx03.bin" ; $5d70, 256 bytes
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx04:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx04.bin" ; $5e70, 256 bytes
	ds ALIGN[4]
SouvenirSellerWalkSprite_Gfx05:
	INCBIN "data/sprites/SouvenirSellerWalkSprite_Gfx05.bin" ; $5f70, 256 bytes
SouvenirSellerWalkSprite_AnimPtrs:
	dw SouvenirSellerWalkSprite_AnimStill ; $6070
	dw SouvenirSellerWalkSprite_AnimWalk ; $6072
	dw SouvenirSellerWalkSprite_AnimBounce ; $6074
	dw SouvenirSellerWalkSprite_AnimNod ; $6076
	dw SouvenirSellerWalkSprite_AnimShake ; $6078
	dw SouvenirSellerWalkSprite_Anim05 ; $607a
	dw SouvenirSellerWalkSprite_Anim05 ; $607c
	dw SouvenirSellerWalkSprite_Anim06 ; $607e
	dw SouvenirSellerWalkSprite_Anim07 ; $6080
	dw SouvenirSellerWalkSprite_Anim08 ; $6082
	dw SouvenirSellerWalkSprite_Anim09 ; $6084
	dw SouvenirSellerWalkSprite_Anim10 ; $6086
SouvenirSellerWalkSprite_AnimStill:
	; $6088, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SouvenirSellerWalkSprite_AnimWalk:
	; $608b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SouvenirSellerWalkSprite_AnimBounce:
	; $6091, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SouvenirSellerWalkSprite_AnimNod:
	; $609d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SouvenirSellerWalkSprite_AnimShake:
	; $60a5, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
SouvenirSellerWalkSprite_Anim05:
	; $60b9, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
SouvenirSellerWalkSprite_Anim06:
	; $60be, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SouvenirSellerWalkSprite_Anim07:
	; $60ca, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
SouvenirSellerWalkSprite_Anim08:
	; $60d0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
SouvenirSellerWalkSprite_Anim09:
	; $60d3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
SouvenirSellerWalkSprite_Anim10:
	; $60d6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
IslandSpectatorAWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, IslandSpectatorAWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw IslandSpectatorAWalkSprite_Gfx00, IslandSpectatorAWalkSprite_Gfx01, IslandSpectatorAWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw IslandSpectatorAWalkSprite_Gfx02 ; $60f1
	dw IslandSpectatorAWalkSprite_Gfx02 ; $60f3
	dw IslandSpectatorAWalkSprite_Gfx02 ; $60f5
	dw IslandSpectatorAWalkSprite_Gfx02 ; $60f7
	dw IslandSpectatorAWalkSprite_Gfx03 ; $60f9
	dw IslandSpectatorAWalkSprite_Gfx04 ; $60fb
	dw IslandSpectatorAWalkSprite_Gfx05 ; $60fd
	db $00 ; $60ff
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx00:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx00.bin" ; $6100, 256 bytes
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx01:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx01.bin" ; $6200, 256 bytes
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx02:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx02.bin" ; $6300, 256 bytes
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx03:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx03.bin" ; $6400, 256 bytes
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx04:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx04.bin" ; $6500, 256 bytes
	ds ALIGN[4]
IslandSpectatorAWalkSprite_Gfx05:
	INCBIN "data/sprites/IslandSpectatorAWalkSprite_Gfx05.bin" ; $6600, 256 bytes
IslandSpectatorAWalkSprite_AnimPtrs:
	dw IslandSpectatorAWalkSprite_AnimStill ; $6700
	dw IslandSpectatorAWalkSprite_AnimWalk ; $6702
	dw IslandSpectatorAWalkSprite_AnimBounce ; $6704
	dw IslandSpectatorAWalkSprite_AnimNod ; $6706
	dw IslandSpectatorAWalkSprite_AnimShake ; $6708
	dw IslandSpectatorAWalkSprite_Anim05 ; $670a
	dw IslandSpectatorAWalkSprite_Anim05 ; $670c
	dw IslandSpectatorAWalkSprite_Anim06 ; $670e
	dw IslandSpectatorAWalkSprite_Anim07 ; $6710
	dw IslandSpectatorAWalkSprite_Anim08 ; $6712
	dw IslandSpectatorAWalkSprite_Anim09 ; $6714
	dw IslandSpectatorAWalkSprite_Anim10 ; $6716
IslandSpectatorAWalkSprite_AnimStill:
	; $6718, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
IslandSpectatorAWalkSprite_AnimWalk:
	; $671b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
IslandSpectatorAWalkSprite_AnimBounce:
	; $6721, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorAWalkSprite_AnimNod:
	; $672d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorAWalkSprite_AnimShake:
	; $6735, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorAWalkSprite_Anim05:
	; $6749, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
IslandSpectatorAWalkSprite_Anim06:
	; $674e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorAWalkSprite_Anim07:
	; $675a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
IslandSpectatorAWalkSprite_Anim08:
	; $6760, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
IslandSpectatorAWalkSprite_Anim09:
	; $6763, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
IslandSpectatorAWalkSprite_Anim10:
	; $6766, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
IslandSpectatorBWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, IslandSpectatorBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw IslandSpectatorBWalkSprite_Gfx00, IslandSpectatorBWalkSprite_Gfx01, IslandSpectatorBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw IslandSpectatorBWalkSprite_Gfx02 ; $6781
	dw IslandSpectatorBWalkSprite_Gfx02 ; $6783
	dw IslandSpectatorBWalkSprite_Gfx02 ; $6785
	dw IslandSpectatorBWalkSprite_Gfx02 ; $6787
	dw IslandSpectatorBWalkSprite_Gfx03 ; $6789
	dw IslandSpectatorBWalkSprite_Gfx04 ; $678b
	dw IslandSpectatorBWalkSprite_Gfx05 ; $678d
	db $00 ; $678f
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx00:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx00.bin" ; $6790, 256 bytes
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx01:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx01.bin" ; $6890, 256 bytes
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx02:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx02.bin" ; $6990, 256 bytes
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx03:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx03.bin" ; $6a90, 256 bytes
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx04:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx04.bin" ; $6b90, 256 bytes
	ds ALIGN[4]
IslandSpectatorBWalkSprite_Gfx05:
	INCBIN "data/sprites/IslandSpectatorBWalkSprite_Gfx05.bin" ; $6c90, 256 bytes
IslandSpectatorBWalkSprite_AnimPtrs:
	dw IslandSpectatorBWalkSprite_AnimStill ; $6d90
	dw IslandSpectatorBWalkSprite_AnimWalk ; $6d92
	dw IslandSpectatorBWalkSprite_AnimBounce ; $6d94
	dw IslandSpectatorBWalkSprite_AnimNod ; $6d96
	dw IslandSpectatorBWalkSprite_AnimShake ; $6d98
	dw IslandSpectatorBWalkSprite_Anim05 ; $6d9a
	dw IslandSpectatorBWalkSprite_Anim05 ; $6d9c
	dw IslandSpectatorBWalkSprite_Anim06 ; $6d9e
	dw IslandSpectatorBWalkSprite_Anim07 ; $6da0
	dw IslandSpectatorBWalkSprite_Anim08 ; $6da2
	dw IslandSpectatorBWalkSprite_Anim09 ; $6da4
	dw IslandSpectatorBWalkSprite_Anim10 ; $6da6
IslandSpectatorBWalkSprite_AnimStill:
	; $6da8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
IslandSpectatorBWalkSprite_AnimWalk:
	; $6dab, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
IslandSpectatorBWalkSprite_AnimBounce:
	; $6db1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorBWalkSprite_AnimNod:
	; $6dbd, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorBWalkSprite_AnimShake:
	; $6dc5, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorBWalkSprite_Anim05:
	; $6dd9, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
IslandSpectatorBWalkSprite_Anim06:
	; $6dde, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
IslandSpectatorBWalkSprite_Anim07:
	; $6dea, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
IslandSpectatorBWalkSprite_Anim08:
	; $6df0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
IslandSpectatorBWalkSprite_Anim09:
	; $6df3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
IslandSpectatorBWalkSprite_Anim10:
	; $6df6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
TournamentStaffWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, TournamentStaffWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw TournamentStaffWalkSprite_Gfx00, TournamentStaffWalkSprite_Gfx01, TournamentStaffWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw TournamentStaffWalkSprite_Gfx02 ; $6e11
	dw TournamentStaffWalkSprite_Gfx02 ; $6e13
	dw TournamentStaffWalkSprite_Gfx02 ; $6e15
	dw TournamentStaffWalkSprite_Gfx02 ; $6e17
	dw TournamentStaffWalkSprite_Gfx03 ; $6e19
	dw TournamentStaffWalkSprite_Gfx04 ; $6e1b
	dw TournamentStaffWalkSprite_Gfx05 ; $6e1d
	db $00 ; $6e1f
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx00:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx00.bin" ; $6e20, 256 bytes
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx01:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx01.bin" ; $6f20, 256 bytes
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx02:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx02.bin" ; $7020, 256 bytes
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx03:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx03.bin" ; $7120, 256 bytes
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx04:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx04.bin" ; $7220, 256 bytes
	ds ALIGN[4]
TournamentStaffWalkSprite_Gfx05:
	INCBIN "data/sprites/TournamentStaffWalkSprite_Gfx05.bin" ; $7320, 256 bytes
TournamentStaffWalkSprite_AnimPtrs:
	dw TournamentStaffWalkSprite_AnimStill ; $7420
	dw TournamentStaffWalkSprite_AnimWalk ; $7422
	dw TournamentStaffWalkSprite_AnimBounce ; $7424
	dw TournamentStaffWalkSprite_AnimNod ; $7426
	dw TournamentStaffWalkSprite_AnimShake ; $7428
	dw TournamentStaffWalkSprite_Anim05 ; $742a
	dw TournamentStaffWalkSprite_Anim05 ; $742c
	dw TournamentStaffWalkSprite_Anim06 ; $742e
	dw TournamentStaffWalkSprite_Anim07 ; $7430
	dw TournamentStaffWalkSprite_Anim08 ; $7432
	dw TournamentStaffWalkSprite_Anim09 ; $7434
	dw TournamentStaffWalkSprite_Anim10 ; $7436
TournamentStaffWalkSprite_AnimStill:
	; $7438, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
TournamentStaffWalkSprite_AnimWalk:
	; $743b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
TournamentStaffWalkSprite_AnimBounce:
	; $7441, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
TournamentStaffWalkSprite_AnimNod:
	; $744d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
TournamentStaffWalkSprite_AnimShake:
	; $7455, 20 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 3
	anim_frame $07, 10
	anim_frame $00, 3
	anim_frame $08, 10
	anim_frame $00, 10
	anim_set ANIM_WALK
TournamentStaffWalkSprite_Anim05:
	; $7469, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
TournamentStaffWalkSprite_Anim06:
	; $746e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
TournamentStaffWalkSprite_Anim07:
	; $747a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
TournamentStaffWalkSprite_Anim08:
	; $7480, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
TournamentStaffWalkSprite_Anim09:
	; $7483, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
TournamentStaffWalkSprite_Anim10:
	; $7486, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
	; $7491, 2927 bytes fill to bank end (linker-padded)
