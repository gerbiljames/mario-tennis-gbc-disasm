DataPtr_AlexWalkSprite:
	dw AlexWalkSprite ; $4000
DataPtr_NinaWalkSprite:
	dw NinaWalkSprite ; $4002
DataPtr_HarryWalkSprite:
	dw HarryWalkSprite ; $4004
DataPtr_KateWalkSprite:
	dw KateWalkSprite ; $4006
DataPtr_MarioWalkSprite:
	dw MarioWalkSprite ; $4008
DataPtr_WaluigiWalkSprite:
	dw WaluigiWalkSprite ; $400a
DataPtr_YoshiWalkSprite:
	dw YoshiWalkSprite ; $400c
AlexWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, AlexWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw AlexWalkSprite_Gfx00, AlexWalkSprite_Gfx01, AlexWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw AlexWalkSprite_Gfx02 ; $401e
	dw AlexWalkSprite_Gfx03 ; $4020
	dw AlexWalkSprite_Gfx04 ; $4022
	dw AlexWalkSprite_Gfx04 ; $4024
	dw AlexWalkSprite_Gfx05 ; $4026
	dw AlexWalkSprite_Gfx06 ; $4028
	dw AlexWalkSprite_Gfx07 ; $402a
	dw AlexWalkSprite_Gfx08 ; $402c
	dw AlexWalkSprite_Gfx08 ; $402e
	dw AlexWalkSprite_Gfx09 ; $4030
	dw AlexWalkSprite_Gfx10 ; $4032
	dw AlexWalkSprite_Gfx11 ; $4034
Padding_70_0:
	; $4036, 10 bytes (fill)
	ds 10, $00
	ds ALIGN[4]
AlexWalkSprite_Gfx00:
	INCBIN "data/sprites/AlexWalkSprite_Gfx00.bin" ; $4040, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx01:
	INCBIN "data/sprites/AlexWalkSprite_Gfx01.bin" ; $4140, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx02:
	INCBIN "data/sprites/AlexWalkSprite_Gfx02.bin" ; $4240, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx03:
	INCBIN "data/sprites/AlexWalkSprite_Gfx03.bin" ; $4340, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx04:
	INCBIN "data/sprites/AlexWalkSprite_Gfx04.bin" ; $4440, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx05:
	INCBIN "data/sprites/AlexWalkSprite_Gfx05.bin" ; $4540, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx06:
	INCBIN "data/sprites/AlexWalkSprite_Gfx06.bin" ; $4640, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx07:
	INCBIN "data/sprites/AlexWalkSprite_Gfx07.bin" ; $4740, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx08:
	INCBIN "data/sprites/AlexWalkSprite_Gfx08.bin" ; $4840, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx09:
	INCBIN "data/sprites/AlexWalkSprite_Gfx09.bin" ; $4940, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx10:
	INCBIN "data/sprites/AlexWalkSprite_Gfx10.bin" ; $4a40, 256 bytes
	ds ALIGN[4]
AlexWalkSprite_Gfx11:
	INCBIN "data/sprites/AlexWalkSprite_Gfx11.bin" ; $4b40, 256 bytes
AlexWalkSprite_AnimPtrs:
	dw AlexWalkSprite_AnimStill ; $4c40
	dw AlexWalkSprite_AnimWalk ; $4c42
	dw AlexWalkSprite_AnimBounce ; $4c44
	dw AlexWalkSprite_AnimNod ; $4c46
	dw AlexWalkSprite_AnimShake ; $4c48
	dw AlexWalkSprite_Anim05 ; $4c4a
	dw AlexWalkSprite_Anim05 ; $4c4c
	dw AlexWalkSprite_Anim06 ; $4c4e
	dw AlexWalkSprite_Anim07 ; $4c50
	dw AlexWalkSprite_Anim08 ; $4c52
	dw AlexWalkSprite_Anim09 ; $4c54
	dw AlexWalkSprite_Anim10 ; $4c56
AlexWalkSprite_AnimStill:
	; $4c58, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
AlexWalkSprite_AnimWalk:
	; $4c5b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
AlexWalkSprite_AnimBounce:
	; $4c61, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexWalkSprite_AnimNod:
	; $4c6d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexWalkSprite_AnimShake:
	; $4c75, 20 bytes (sprite_anim)
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
AlexWalkSprite_Anim05:
	; $4c89, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
AlexWalkSprite_Anim06:
	; $4c8e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexWalkSprite_Anim07:
	; $4c9a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
AlexWalkSprite_Anim08:
	; $4ca0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
AlexWalkSprite_Anim09:
	; $4ca3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
AlexWalkSprite_Anim10:
	; $4ca6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
NinaWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, NinaWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw NinaWalkSprite_Gfx00, NinaWalkSprite_Gfx01, NinaWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw NinaWalkSprite_Gfx02 ; $4cc1
	dw NinaWalkSprite_Gfx03 ; $4cc3
	dw NinaWalkSprite_Gfx04 ; $4cc5
	dw NinaWalkSprite_Gfx04 ; $4cc7
	dw NinaWalkSprite_Gfx05 ; $4cc9
	dw NinaWalkSprite_Gfx06 ; $4ccb
	dw NinaWalkSprite_Gfx07 ; $4ccd
	dw NinaWalkSprite_Gfx08 ; $4ccf
	dw NinaWalkSprite_Gfx08 ; $4cd1
	dw NinaWalkSprite_Gfx09 ; $4cd3
	dw NinaWalkSprite_Gfx10 ; $4cd5
	dw NinaWalkSprite_Gfx11 ; $4cd7
Padding_70_1:
	; $4cd9, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
NinaWalkSprite_Gfx00:
	INCBIN "data/sprites/NinaWalkSprite_Gfx00.bin" ; $4ce0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx01:
	INCBIN "data/sprites/NinaWalkSprite_Gfx01.bin" ; $4de0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx02:
	INCBIN "data/sprites/NinaWalkSprite_Gfx02.bin" ; $4ee0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx03:
	INCBIN "data/sprites/NinaWalkSprite_Gfx03.bin" ; $4fe0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx04:
	INCBIN "data/sprites/NinaWalkSprite_Gfx04.bin" ; $50e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx05:
	INCBIN "data/sprites/NinaWalkSprite_Gfx05.bin" ; $51e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx06:
	INCBIN "data/sprites/NinaWalkSprite_Gfx06.bin" ; $52e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx07:
	INCBIN "data/sprites/NinaWalkSprite_Gfx07.bin" ; $53e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx08:
	INCBIN "data/sprites/NinaWalkSprite_Gfx08.bin" ; $54e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx09:
	INCBIN "data/sprites/NinaWalkSprite_Gfx09.bin" ; $55e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx10:
	INCBIN "data/sprites/NinaWalkSprite_Gfx10.bin" ; $56e0, 256 bytes
	ds ALIGN[4]
NinaWalkSprite_Gfx11:
	INCBIN "data/sprites/NinaWalkSprite_Gfx11.bin" ; $57e0, 256 bytes
NinaWalkSprite_AnimPtrs:
	dw NinaWalkSprite_AnimStill ; $58e0
	dw NinaWalkSprite_AnimWalk ; $58e2
	dw NinaWalkSprite_AnimBounce ; $58e4
	dw NinaWalkSprite_AnimNod ; $58e6
	dw NinaWalkSprite_AnimShake ; $58e8
	dw NinaWalkSprite_Anim05 ; $58ea
	dw NinaWalkSprite_Anim05 ; $58ec
	dw NinaWalkSprite_Anim06 ; $58ee
	dw NinaWalkSprite_Anim07 ; $58f0
	dw NinaWalkSprite_Anim08 ; $58f2
	dw NinaWalkSprite_Anim09 ; $58f4
	dw NinaWalkSprite_Anim10 ; $58f6
NinaWalkSprite_AnimStill:
	; $58f8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
NinaWalkSprite_AnimWalk:
	; $58fb, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
NinaWalkSprite_AnimBounce:
	; $5901, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaWalkSprite_AnimNod:
	; $590d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaWalkSprite_AnimShake:
	; $5915, 20 bytes (sprite_anim)
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
NinaWalkSprite_Anim05:
	; $5929, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
NinaWalkSprite_Anim06:
	; $592e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaWalkSprite_Anim07:
	; $593a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
NinaWalkSprite_Anim08:
	; $5940, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
NinaWalkSprite_Anim09:
	; $5943, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
NinaWalkSprite_Anim10:
	; $5946, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
HarryWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, HarryWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw HarryWalkSprite_Gfx00, HarryWalkSprite_Gfx01, HarryWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw HarryWalkSprite_Gfx02 ; $5961
	dw HarryWalkSprite_Gfx02 ; $5963
	dw HarryWalkSprite_Gfx02 ; $5965
	dw HarryWalkSprite_Gfx02 ; $5967
	dw HarryWalkSprite_Gfx03 ; $5969
	dw HarryWalkSprite_Gfx04 ; $596b
	dw HarryWalkSprite_Gfx05 ; $596d
	dw HarryWalkSprite_Gfx06 ; $596f
	dw HarryWalkSprite_Gfx06 ; $5971
	dw HarryWalkSprite_Gfx07 ; $5973
Padding_70_2:
	; $5975, 11 bytes (fill)
	ds 11, $00
	ds ALIGN[4]
HarryWalkSprite_Gfx00:
	INCBIN "data/sprites/HarryWalkSprite_Gfx00.bin" ; $5980, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx01:
	INCBIN "data/sprites/HarryWalkSprite_Gfx01.bin" ; $5a80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx02:
	INCBIN "data/sprites/HarryWalkSprite_Gfx02.bin" ; $5b80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx03:
	INCBIN "data/sprites/HarryWalkSprite_Gfx03.bin" ; $5c80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx04:
	INCBIN "data/sprites/HarryWalkSprite_Gfx04.bin" ; $5d80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx05:
	INCBIN "data/sprites/HarryWalkSprite_Gfx05.bin" ; $5e80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx06:
	INCBIN "data/sprites/HarryWalkSprite_Gfx06.bin" ; $5f80, 256 bytes
	ds ALIGN[4]
HarryWalkSprite_Gfx07:
	INCBIN "data/sprites/HarryWalkSprite_Gfx07.bin" ; $6080, 256 bytes
HarryWalkSprite_AnimPtrs:
	dw HarryWalkSprite_AnimStill ; $6180
	dw HarryWalkSprite_AnimWalk ; $6182
	dw HarryWalkSprite_AnimBounce ; $6184
	dw HarryWalkSprite_AnimNod ; $6186
	dw HarryWalkSprite_AnimShake ; $6188
	dw HarryWalkSprite_Anim05 ; $618a
	dw HarryWalkSprite_Anim05 ; $618c
	dw HarryWalkSprite_Anim05 ; $618e
	dw HarryWalkSprite_Anim06 ; $6190
HarryWalkSprite_AnimStill:
	; $6192, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
HarryWalkSprite_AnimWalk:
	; $6195, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
HarryWalkSprite_AnimBounce:
	; $619b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryWalkSprite_AnimNod:
	; $61a7, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryWalkSprite_AnimShake:
	; $61af, 20 bytes (sprite_anim)
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
HarryWalkSprite_Anim05:
	; $61c3, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryWalkSprite_Anim06:
	; $61cf, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
KateWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, KateWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw KateWalkSprite_Gfx00, KateWalkSprite_Gfx01, KateWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw KateWalkSprite_Gfx02 ; $61e5
	dw KateWalkSprite_Gfx02 ; $61e7
	dw KateWalkSprite_Gfx02 ; $61e9
	dw KateWalkSprite_Gfx02 ; $61eb
	dw KateWalkSprite_Gfx03 ; $61ed
	dw KateWalkSprite_Gfx04 ; $61ef
	dw KateWalkSprite_Gfx05 ; $61f1
	dw KateWalkSprite_Gfx06 ; $61f3
	dw KateWalkSprite_Gfx06 ; $61f5
	dw KateWalkSprite_Gfx07 ; $61f7
Padding_70_3:
	; $61f9, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
KateWalkSprite_Gfx00:
	INCBIN "data/sprites/KateWalkSprite_Gfx00.bin" ; $6200, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx01:
	INCBIN "data/sprites/KateWalkSprite_Gfx01.bin" ; $6300, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx02:
	INCBIN "data/sprites/KateWalkSprite_Gfx02.bin" ; $6400, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx03:
	INCBIN "data/sprites/KateWalkSprite_Gfx03.bin" ; $6500, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx04:
	INCBIN "data/sprites/KateWalkSprite_Gfx04.bin" ; $6600, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx05:
	INCBIN "data/sprites/KateWalkSprite_Gfx05.bin" ; $6700, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx06:
	INCBIN "data/sprites/KateWalkSprite_Gfx06.bin" ; $6800, 256 bytes
	ds ALIGN[4]
KateWalkSprite_Gfx07:
	INCBIN "data/sprites/KateWalkSprite_Gfx07.bin" ; $6900, 256 bytes
KateWalkSprite_AnimPtrs:
	dw KateWalkSprite_AnimStill ; $6a00
	dw KateWalkSprite_AnimWalk ; $6a02
	dw KateWalkSprite_AnimBounce ; $6a04
	dw KateWalkSprite_AnimNod ; $6a06
	dw KateWalkSprite_AnimShake ; $6a08
	dw KateWalkSprite_Anim05 ; $6a0a
	dw KateWalkSprite_Anim05 ; $6a0c
	dw KateWalkSprite_Anim05 ; $6a0e
	dw KateWalkSprite_Anim06 ; $6a10
KateWalkSprite_AnimStill:
	; $6a12, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
KateWalkSprite_AnimWalk:
	; $6a15, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
KateWalkSprite_AnimBounce:
	; $6a1b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KateWalkSprite_AnimNod:
	; $6a27, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
KateWalkSprite_AnimShake:
	; $6a2f, 20 bytes (sprite_anim)
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
KateWalkSprite_Anim05:
	; $6a43, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KateWalkSprite_Anim06:
	; $6a4f, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
MarioWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MarioWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MarioWalkSprite_Gfx00, MarioWalkSprite_Gfx01, MarioWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MarioWalkSprite_Gfx02 ; $6a65
	dw MarioWalkSprite_Gfx02 ; $6a67
	dw MarioWalkSprite_Gfx02 ; $6a69
	dw MarioWalkSprite_Gfx02 ; $6a6b
	dw MarioWalkSprite_Gfx03 ; $6a6d
	dw MarioWalkSprite_Gfx04 ; $6a6f
	dw MarioWalkSprite_Gfx05 ; $6a71
Padding_70_4:
	; $6a73, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
MarioWalkSprite_Gfx00:
	INCBIN "data/sprites/MarioWalkSprite_Gfx00.bin" ; $6a80, 256 bytes
	ds ALIGN[4]
MarioWalkSprite_Gfx01:
	INCBIN "data/sprites/MarioWalkSprite_Gfx01.bin" ; $6b80, 256 bytes
	ds ALIGN[4]
MarioWalkSprite_Gfx02:
	INCBIN "data/sprites/MarioWalkSprite_Gfx02.bin" ; $6c80, 256 bytes
	ds ALIGN[4]
MarioWalkSprite_Gfx03:
	INCBIN "data/sprites/MarioWalkSprite_Gfx03.bin" ; $6d80, 256 bytes
	ds ALIGN[4]
MarioWalkSprite_Gfx04:
	INCBIN "data/sprites/MarioWalkSprite_Gfx04.bin" ; $6e80, 256 bytes
	ds ALIGN[4]
MarioWalkSprite_Gfx05:
	INCBIN "data/sprites/MarioWalkSprite_Gfx05.bin" ; $6f80, 256 bytes
MarioWalkSprite_AnimPtrs:
	dw MarioWalkSprite_AnimStill ; $7080
	dw MarioWalkSprite_AnimWalk ; $7082
	dw MarioWalkSprite_AnimBounce ; $7084
	dw MarioWalkSprite_AnimNod ; $7086
	dw MarioWalkSprite_AnimShake ; $7088
	dw MarioWalkSprite_Anim05 ; $708a
	dw MarioWalkSprite_Anim05 ; $708c
	dw MarioWalkSprite_Anim05 ; $708e
MarioWalkSprite_AnimStill:
	; $7090, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MarioWalkSprite_AnimWalk:
	; $7093, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MarioWalkSprite_AnimBounce:
	; $7099, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarioWalkSprite_AnimNod:
	; $70a5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MarioWalkSprite_AnimShake:
	; $70ad, 20 bytes (sprite_anim)
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
MarioWalkSprite_Anim05:
	; $70c1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WaluigiWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WaluigiWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WaluigiWalkSprite_Gfx00, WaluigiWalkSprite_Gfx01, WaluigiWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw WaluigiWalkSprite_Gfx02 ; $70dd
	dw WaluigiWalkSprite_Gfx02 ; $70df
	dw WaluigiWalkSprite_Gfx02 ; $70e1
	dw WaluigiWalkSprite_Gfx02 ; $70e3
	dw WaluigiWalkSprite_Gfx03 ; $70e5
	dw WaluigiWalkSprite_Gfx04 ; $70e7
	dw WaluigiWalkSprite_Gfx05 ; $70e9
Padding_70_5:
	; $70eb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WaluigiWalkSprite_Gfx00:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx00.bin" ; $70f0, 256 bytes
	ds ALIGN[4]
WaluigiWalkSprite_Gfx01:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx01.bin" ; $71f0, 256 bytes
	ds ALIGN[4]
WaluigiWalkSprite_Gfx02:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx02.bin" ; $72f0, 256 bytes
	ds ALIGN[4]
WaluigiWalkSprite_Gfx03:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx03.bin" ; $73f0, 256 bytes
	ds ALIGN[4]
WaluigiWalkSprite_Gfx04:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx04.bin" ; $74f0, 256 bytes
	ds ALIGN[4]
WaluigiWalkSprite_Gfx05:
	INCBIN "data/sprites/WaluigiWalkSprite_Gfx05.bin" ; $75f0, 256 bytes
WaluigiWalkSprite_AnimPtrs:
	dw WaluigiWalkSprite_AnimStill ; $76f0
	dw WaluigiWalkSprite_AnimWalk ; $76f2
	dw WaluigiWalkSprite_AnimBounce ; $76f4
	dw WaluigiWalkSprite_AnimNod ; $76f6
	dw WaluigiWalkSprite_AnimShake ; $76f8
	dw WaluigiWalkSprite_Anim05 ; $76fa
	dw WaluigiWalkSprite_Anim05 ; $76fc
	dw WaluigiWalkSprite_Anim05 ; $76fe
WaluigiWalkSprite_AnimStill:
	; $7700, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WaluigiWalkSprite_AnimWalk:
	; $7703, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
WaluigiWalkSprite_AnimBounce:
	; $7709, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WaluigiWalkSprite_AnimNod:
	; $7715, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WaluigiWalkSprite_AnimShake:
	; $771d, 20 bytes (sprite_anim)
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
WaluigiWalkSprite_Anim05:
	; $7731, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
YoshiWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, YoshiWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw YoshiWalkSprite_Gfx00, YoshiWalkSprite_Gfx01, YoshiWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw YoshiWalkSprite_Gfx02 ; $774d
	dw YoshiWalkSprite_Gfx02 ; $774f
	dw YoshiWalkSprite_Gfx02 ; $7751
	dw YoshiWalkSprite_Gfx02 ; $7753
	dw YoshiWalkSprite_Gfx03 ; $7755
	dw YoshiWalkSprite_Gfx04 ; $7757
	dw YoshiWalkSprite_Gfx05 ; $7759
Padding_70_6:
	; $775b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
YoshiWalkSprite_Gfx00:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx00.bin" ; $7760, 256 bytes
	ds ALIGN[4]
YoshiWalkSprite_Gfx01:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx01.bin" ; $7860, 256 bytes
	ds ALIGN[4]
YoshiWalkSprite_Gfx02:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx02.bin" ; $7960, 256 bytes
	ds ALIGN[4]
YoshiWalkSprite_Gfx03:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx03.bin" ; $7a60, 256 bytes
	ds ALIGN[4]
YoshiWalkSprite_Gfx04:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx04.bin" ; $7b60, 256 bytes
	ds ALIGN[4]
YoshiWalkSprite_Gfx05:
	INCBIN "data/sprites/YoshiWalkSprite_Gfx05.bin" ; $7c60, 256 bytes
YoshiWalkSprite_AnimPtrs:
	dw YoshiWalkSprite_AnimStill ; $7d60
	dw YoshiWalkSprite_AnimWalk ; $7d62
	dw YoshiWalkSprite_AnimBounce ; $7d64
	dw YoshiWalkSprite_AnimNod ; $7d66
	dw YoshiWalkSprite_AnimShake ; $7d68
	dw YoshiWalkSprite_Anim05 ; $7d6a
	dw YoshiWalkSprite_Anim05 ; $7d6c
	dw YoshiWalkSprite_Anim05 ; $7d6e
YoshiWalkSprite_AnimStill:
	; $7d70, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
YoshiWalkSprite_AnimWalk:
	; $7d73, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
YoshiWalkSprite_AnimBounce:
	; $7d79, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
YoshiWalkSprite_AnimNod:
	; $7d85, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
YoshiWalkSprite_AnimShake:
	; $7d8d, 20 bytes (sprite_anim)
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
YoshiWalkSprite_Anim05:
	; $7da1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
	; $7dad, 595 bytes fill to bank end (linker-padded)
