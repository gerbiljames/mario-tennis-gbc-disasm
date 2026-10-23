DataPtr_LuigiWalkSprite:
	dw LuigiWalkSprite ; $4000
DataPtr_DKWalkSprite:
	dw DKWalkSprite ; $4002
DataPtr_BabyMarioWalkSprite:
	dw BabyMarioWalkSprite ; $4004
DataPtr_ToadWalkSprite:
	dw ToadWalkSprite ; $4006
DataPtr_BobOmbWalkSprite:
	dw BobOmbWalkSprite ; $4008
DataPtr_MarioWorldHostessWalkSprite:
	dw MarioWorldHostessWalkSprite ; $400a
DataPtr_BooWalkSprite:
	dw BooWalkSprite ; $400c
DataPtr_TrophyWalkSprite:
	dw TrophyWalkSprite ; $400e
LuigiWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, LuigiWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw LuigiWalkSprite_Gfx00, LuigiWalkSprite_Gfx01, LuigiWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw LuigiWalkSprite_Gfx02 ; $4020
	dw LuigiWalkSprite_Gfx02 ; $4022
	dw LuigiWalkSprite_Gfx02 ; $4024
	dw LuigiWalkSprite_Gfx02 ; $4026
	dw LuigiWalkSprite_Gfx03 ; $4028
	dw LuigiWalkSprite_Gfx04 ; $402a
	dw LuigiWalkSprite_Gfx05 ; $402c
	dw LuigiWalkSprite_Gfx06 ; $402e
	dw LuigiWalkSprite_Gfx06 ; $4030
	dw LuigiWalkSprite_Gfx07 ; $4032
Padding_77_0:
	; $4034, 12 bytes (fill)
	ds 12, $00
	ds ALIGN[4]
LuigiWalkSprite_Gfx00:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx00.bin" ; $4040, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx01:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx01.bin" ; $4140, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx02:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx02.bin" ; $4240, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx03:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx03.bin" ; $4340, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx04:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx04.bin" ; $4440, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx05:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx05.bin" ; $4540, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx06:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx06.bin" ; $4640, 256 bytes
	ds ALIGN[4]
LuigiWalkSprite_Gfx07:
	INCBIN "data/sprites/LuigiWalkSprite_Gfx07.bin" ; $4740, 256 bytes
LuigiWalkSprite_AnimPtrs:
	dw LuigiWalkSprite_AnimStill ; $4840
	dw LuigiWalkSprite_AnimWalk ; $4842
	dw LuigiWalkSprite_AnimBounce ; $4844
	dw LuigiWalkSprite_AnimNod ; $4846
	dw LuigiWalkSprite_AnimShake ; $4848
	dw LuigiWalkSprite_Anim05 ; $484a
	dw LuigiWalkSprite_Anim05 ; $484c
	dw LuigiWalkSprite_Anim05 ; $484e
	dw LuigiWalkSprite_Anim06 ; $4850
LuigiWalkSprite_AnimStill:
	; $4852, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
LuigiWalkSprite_AnimWalk:
	; $4855, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
LuigiWalkSprite_AnimBounce:
	; $485b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
LuigiWalkSprite_AnimNod:
	; $4867, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
LuigiWalkSprite_AnimShake:
	; $486f, 20 bytes (sprite_anim)
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
LuigiWalkSprite_Anim05:
	; $4883, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
LuigiWalkSprite_Anim06:
	; $488f, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
DKWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, DKWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw DKWalkSprite_Gfx00, DKWalkSprite_Gfx01, DKWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw DKWalkSprite_Gfx02 ; $48a5
	dw DKWalkSprite_Gfx02 ; $48a7
	dw DKWalkSprite_Gfx02 ; $48a9
	dw DKWalkSprite_Gfx02 ; $48ab
	dw DKWalkSprite_Gfx03 ; $48ad
	dw DKWalkSprite_Gfx04 ; $48af
	dw DKWalkSprite_Gfx05 ; $48b1
	dw DKWalkSprite_Gfx06 ; $48b3
	dw DKWalkSprite_Gfx06 ; $48b5
	dw DKWalkSprite_Gfx07 ; $48b7
Padding_77_1:
	; $48b9, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
DKWalkSprite_Gfx00:
	INCBIN "data/sprites/DKWalkSprite_Gfx00.bin" ; $48c0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx01:
	INCBIN "data/sprites/DKWalkSprite_Gfx01.bin" ; $49c0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx02:
	INCBIN "data/sprites/DKWalkSprite_Gfx02.bin" ; $4ac0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx03:
	INCBIN "data/sprites/DKWalkSprite_Gfx03.bin" ; $4bc0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx04:
	INCBIN "data/sprites/DKWalkSprite_Gfx04.bin" ; $4cc0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx05:
	INCBIN "data/sprites/DKWalkSprite_Gfx05.bin" ; $4dc0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx06:
	INCBIN "data/sprites/DKWalkSprite_Gfx06.bin" ; $4ec0, 256 bytes
	ds ALIGN[4]
DKWalkSprite_Gfx07:
	INCBIN "data/sprites/DKWalkSprite_Gfx07.bin" ; $4fc0, 256 bytes
DKWalkSprite_AnimPtrs:
	dw DKWalkSprite_AnimStill ; $50c0
	dw DKWalkSprite_AnimWalk ; $50c2
	dw DKWalkSprite_AnimBounce ; $50c4
	dw DKWalkSprite_AnimNod ; $50c6
	dw DKWalkSprite_AnimShake ; $50c8
	dw DKWalkSprite_Anim05 ; $50ca
	dw DKWalkSprite_Anim05 ; $50cc
	dw DKWalkSprite_Anim05 ; $50ce
	dw DKWalkSprite_Anim06 ; $50d0
DKWalkSprite_AnimStill:
	; $50d2, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
DKWalkSprite_AnimWalk:
	; $50d5, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
DKWalkSprite_AnimBounce:
	; $50db, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
DKWalkSprite_AnimNod:
	; $50e7, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
DKWalkSprite_AnimShake:
	; $50ef, 20 bytes (sprite_anim)
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
DKWalkSprite_Anim05:
	; $5103, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
DKWalkSprite_Anim06:
	; $510f, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
BabyMarioWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BabyMarioWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BabyMarioWalkSprite_Gfx00, BabyMarioWalkSprite_Gfx01, BabyMarioWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BabyMarioWalkSprite_Gfx02 ; $5125
	dw BabyMarioWalkSprite_Gfx02 ; $5127
	dw BabyMarioWalkSprite_Gfx02 ; $5129
	dw BabyMarioWalkSprite_Gfx02 ; $512b
	dw BabyMarioWalkSprite_Gfx03 ; $512d
	dw BabyMarioWalkSprite_Gfx04 ; $512f
	dw BabyMarioWalkSprite_Gfx05 ; $5131
	dw BabyMarioWalkSprite_Gfx06 ; $5133
	dw BabyMarioWalkSprite_Gfx06 ; $5135
	dw BabyMarioWalkSprite_Gfx07 ; $5137
Padding_77_2:
	; $5139, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx00:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx00.bin" ; $5140, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx01:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx01.bin" ; $5240, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx02:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx02.bin" ; $5340, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx03:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx03.bin" ; $5440, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx04:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx04.bin" ; $5540, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx05:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx05.bin" ; $5640, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx06:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx06.bin" ; $5740, 256 bytes
	ds ALIGN[4]
BabyMarioWalkSprite_Gfx07:
	INCBIN "data/sprites/BabyMarioWalkSprite_Gfx07.bin" ; $5840, 256 bytes
BabyMarioWalkSprite_AnimPtrs:
	dw BabyMarioWalkSprite_AnimStill ; $5940
	dw BabyMarioWalkSprite_AnimWalk ; $5942
	dw BabyMarioWalkSprite_AnimBounce ; $5944
	dw BabyMarioWalkSprite_AnimNod ; $5946
	dw BabyMarioWalkSprite_AnimShake ; $5948
	dw BabyMarioWalkSprite_Anim05 ; $594a
	dw BabyMarioWalkSprite_Anim05 ; $594c
	dw BabyMarioWalkSprite_Anim05 ; $594e
	dw BabyMarioWalkSprite_Anim06 ; $5950
BabyMarioWalkSprite_AnimStill:
	; $5952, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BabyMarioWalkSprite_AnimWalk:
	; $5955, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BabyMarioWalkSprite_AnimBounce:
	; $595b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BabyMarioWalkSprite_AnimNod:
	; $5967, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BabyMarioWalkSprite_AnimShake:
	; $596f, 20 bytes (sprite_anim)
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
BabyMarioWalkSprite_Anim05:
	; $5983, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BabyMarioWalkSprite_Anim06:
	; $598f, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
ToadWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, ToadWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw ToadWalkSprite_Gfx00, ToadWalkSprite_Gfx01, ToadWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw ToadWalkSprite_Gfx02 ; $59a5
	dw ToadWalkSprite_Gfx02 ; $59a7
	dw ToadWalkSprite_Gfx02 ; $59a9
	dw ToadWalkSprite_Gfx02 ; $59ab
	dw ToadWalkSprite_Gfx03 ; $59ad
	dw ToadWalkSprite_Gfx04 ; $59af
	dw ToadWalkSprite_Gfx05 ; $59b1
Padding_77_3:
	; $59b3, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
ToadWalkSprite_Gfx00:
	INCBIN "data/sprites/ToadWalkSprite_Gfx00.bin" ; $59c0, 256 bytes
	ds ALIGN[4]
ToadWalkSprite_Gfx01:
	INCBIN "data/sprites/ToadWalkSprite_Gfx01.bin" ; $5ac0, 256 bytes
	ds ALIGN[4]
ToadWalkSprite_Gfx02:
	INCBIN "data/sprites/ToadWalkSprite_Gfx02.bin" ; $5bc0, 256 bytes
	ds ALIGN[4]
ToadWalkSprite_Gfx03:
	INCBIN "data/sprites/ToadWalkSprite_Gfx03.bin" ; $5cc0, 256 bytes
	ds ALIGN[4]
ToadWalkSprite_Gfx04:
	INCBIN "data/sprites/ToadWalkSprite_Gfx04.bin" ; $5dc0, 256 bytes
	ds ALIGN[4]
ToadWalkSprite_Gfx05:
	INCBIN "data/sprites/ToadWalkSprite_Gfx05.bin" ; $5ec0, 256 bytes
ToadWalkSprite_AnimPtrs:
	dw ToadWalkSprite_AnimStill ; $5fc0
	dw ToadWalkSprite_AnimWalk ; $5fc2
	dw ToadWalkSprite_AnimBounce ; $5fc4
	dw ToadWalkSprite_AnimNod ; $5fc6
	dw ToadWalkSprite_AnimShake ; $5fc8
	dw ToadWalkSprite_Anim05 ; $5fca
	dw ToadWalkSprite_Anim05 ; $5fcc
	dw ToadWalkSprite_Anim06 ; $5fce
	dw ToadWalkSprite_Anim07 ; $5fd0
	dw ToadWalkSprite_Anim08 ; $5fd2
	dw ToadWalkSprite_Anim09 ; $5fd4
	dw ToadWalkSprite_Anim10 ; $5fd6
ToadWalkSprite_AnimStill:
	; $5fd8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
ToadWalkSprite_AnimWalk:
	; $5fdb, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
ToadWalkSprite_AnimBounce:
	; $5fe1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ToadWalkSprite_AnimNod:
	; $5fed, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
ToadWalkSprite_AnimShake:
	; $5ff5, 20 bytes (sprite_anim)
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
ToadWalkSprite_Anim05:
	; $6009, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
ToadWalkSprite_Anim06:
	; $600e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ToadWalkSprite_Anim07:
	; $601a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
ToadWalkSprite_Anim08:
	; $6020, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
ToadWalkSprite_Anim09:
	; $6023, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
ToadWalkSprite_Anim10:
	; $6026, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
BobOmbWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BobOmbWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BobOmbWalkSprite_Gfx00, BobOmbWalkSprite_Gfx01, BobOmbWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BobOmbWalkSprite_Gfx02 ; $6041
	dw BobOmbWalkSprite_Gfx02 ; $6043
	dw BobOmbWalkSprite_Gfx02 ; $6045
	dw BobOmbWalkSprite_Gfx02 ; $6047
	dw BobOmbWalkSprite_Gfx03 ; $6049
	dw BobOmbWalkSprite_Gfx04 ; $604b
	dw BobOmbWalkSprite_Gfx05 ; $604d
	db $00 ; $604f
	ds ALIGN[4]
BobOmbWalkSprite_Gfx00:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx00.bin" ; $6050, 256 bytes
	ds ALIGN[4]
BobOmbWalkSprite_Gfx01:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx01.bin" ; $6150, 256 bytes
	ds ALIGN[4]
BobOmbWalkSprite_Gfx02:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx02.bin" ; $6250, 256 bytes
	ds ALIGN[4]
BobOmbWalkSprite_Gfx03:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx03.bin" ; $6350, 256 bytes
	ds ALIGN[4]
BobOmbWalkSprite_Gfx04:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx04.bin" ; $6450, 256 bytes
	ds ALIGN[4]
BobOmbWalkSprite_Gfx05:
	INCBIN "data/sprites/BobOmbWalkSprite_Gfx05.bin" ; $6550, 256 bytes
BobOmbWalkSprite_AnimPtrs:
	dw BobOmbWalkSprite_AnimStill ; $6650
	dw BobOmbWalkSprite_AnimWalk ; $6652
	dw BobOmbWalkSprite_AnimBounce ; $6654
	dw BobOmbWalkSprite_AnimNod ; $6656
	dw BobOmbWalkSprite_AnimShake ; $6658
	dw BobOmbWalkSprite_Anim05 ; $665a
	dw BobOmbWalkSprite_Anim05 ; $665c
	dw BobOmbWalkSprite_Anim06 ; $665e
	dw BobOmbWalkSprite_Anim07 ; $6660
	dw BobOmbWalkSprite_Anim08 ; $6662
	dw BobOmbWalkSprite_Anim09 ; $6664
	dw BobOmbWalkSprite_Anim10 ; $6666
BobOmbWalkSprite_AnimStill:
	; $6668, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BobOmbWalkSprite_AnimWalk:
	; $666b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BobOmbWalkSprite_AnimBounce:
	; $6671, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BobOmbWalkSprite_AnimNod:
	; $667d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BobOmbWalkSprite_AnimShake:
	; $6685, 20 bytes (sprite_anim)
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
BobOmbWalkSprite_Anim05:
	; $6699, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
BobOmbWalkSprite_Anim06:
	; $669e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BobOmbWalkSprite_Anim07:
	; $66aa, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
BobOmbWalkSprite_Anim08:
	; $66b0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
BobOmbWalkSprite_Anim09:
	; $66b3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
BobOmbWalkSprite_Anim10:
	; $66b6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
MarioWorldHostessWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MarioWorldHostessWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MarioWorldHostessWalkSprite_Gfx00, MarioWorldHostessWalkSprite_Gfx01, MarioWorldHostessWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MarioWorldHostessWalkSprite_Gfx02 ; $66d1
	dw MarioWorldHostessWalkSprite_Gfx02 ; $66d3
	dw MarioWorldHostessWalkSprite_Gfx02 ; $66d5
	dw MarioWorldHostessWalkSprite_Gfx02 ; $66d7
	dw MarioWorldHostessWalkSprite_Gfx03 ; $66d9
	dw MarioWorldHostessWalkSprite_Gfx04 ; $66db
	dw MarioWorldHostessWalkSprite_Gfx05 ; $66dd
	db $00 ; $66df
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx00:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx00.bin" ; $66e0, 256 bytes
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx01:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx01.bin" ; $67e0, 256 bytes
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx02:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx02.bin" ; $68e0, 256 bytes
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx03:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx03.bin" ; $69e0, 256 bytes
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx04:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx04.bin" ; $6ae0, 256 bytes
	ds ALIGN[4]
MarioWorldHostessWalkSprite_Gfx05:
	INCBIN "data/sprites/MarioWorldHostessWalkSprite_Gfx05.bin" ; $6be0, 256 bytes
MarioWorldHostessWalkSprite_AnimPtrs:
	dw MarioWorldHostessWalkSprite_AnimStill ; $6ce0
	dw MarioWorldHostessWalkSprite_AnimWalk ; $6ce2
	dw MarioWorldHostessWalkSprite_AnimBounce ; $6ce4
	dw MarioWorldHostessWalkSprite_AnimNod ; $6ce6
	dw MarioWorldHostessWalkSprite_AnimShake ; $6ce8
	dw MarioWorldHostessWalkSprite_Anim05 ; $6cea
	dw MarioWorldHostessWalkSprite_Anim05 ; $6cec
	dw MarioWorldHostessWalkSprite_Anim06 ; $6cee
	dw MarioWorldHostessWalkSprite_Anim07 ; $6cf0
	dw MarioWorldHostessWalkSprite_Anim08 ; $6cf2
	dw MarioWorldHostessWalkSprite_Anim09 ; $6cf4
	dw MarioWorldHostessWalkSprite_Anim10 ; $6cf6
MarioWorldHostessWalkSprite_AnimStill:
	; $6cf8, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MarioWorldHostessWalkSprite_AnimWalk:
	; $6cfb, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MarioWorldHostessWalkSprite_AnimBounce:
	; $6d01, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarioWorldHostessWalkSprite_AnimNod:
	; $6d0d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MarioWorldHostessWalkSprite_AnimShake:
	; $6d15, 20 bytes (sprite_anim)
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
MarioWorldHostessWalkSprite_Anim05:
	; $6d29, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
MarioWorldHostessWalkSprite_Anim06:
	; $6d2e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarioWorldHostessWalkSprite_Anim07:
	; $6d3a, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
MarioWorldHostessWalkSprite_Anim08:
	; $6d40, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
MarioWorldHostessWalkSprite_Anim09:
	; $6d43, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
MarioWorldHostessWalkSprite_Anim10:
	; $6d46, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
BooWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BooWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BooWalkSprite_Gfx00, BooWalkSprite_Gfx01, BooWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BooWalkSprite_Gfx02 ; $6d61
	dw BooWalkSprite_Gfx02 ; $6d63
	dw BooWalkSprite_Gfx02 ; $6d65
	dw BooWalkSprite_Gfx02 ; $6d67
	dw BooWalkSprite_Gfx03 ; $6d69
	dw BooWalkSprite_Gfx04 ; $6d6b
	dw BooWalkSprite_Gfx05 ; $6d6d
	db $00 ; $6d6f
	ds ALIGN[4]
BooWalkSprite_Gfx00:
	INCBIN "data/sprites/BooWalkSprite_Gfx00.bin" ; $6d70, 256 bytes
	ds ALIGN[4]
BooWalkSprite_Gfx01:
	INCBIN "data/sprites/BooWalkSprite_Gfx01.bin" ; $6e70, 256 bytes
	ds ALIGN[4]
BooWalkSprite_Gfx02:
	INCBIN "data/sprites/BooWalkSprite_Gfx02.bin" ; $6f70, 256 bytes
	ds ALIGN[4]
BooWalkSprite_Gfx03:
	INCBIN "data/sprites/BooWalkSprite_Gfx03.bin" ; $7070, 256 bytes
	ds ALIGN[4]
BooWalkSprite_Gfx04:
	INCBIN "data/sprites/BooWalkSprite_Gfx04.bin" ; $7170, 256 bytes
	ds ALIGN[4]
BooWalkSprite_Gfx05:
	INCBIN "data/sprites/BooWalkSprite_Gfx05.bin" ; $7270, 256 bytes
BooWalkSprite_AnimPtrs:
	dw BooWalkSprite_AnimStill ; $7370
	dw BooWalkSprite_AnimWalk ; $7372
	dw BooWalkSprite_AnimBounce ; $7374
	dw BooWalkSprite_AnimNod ; $7376
	dw BooWalkSprite_AnimShake ; $7378
	dw BooWalkSprite_Anim05 ; $737a
	dw BooWalkSprite_Anim05 ; $737c
	dw BooWalkSprite_Anim06 ; $737e
	dw BooWalkSprite_Anim07 ; $7380
	dw BooWalkSprite_Anim08 ; $7382
	dw BooWalkSprite_Anim09 ; $7384
	dw BooWalkSprite_Anim10 ; $7386
BooWalkSprite_AnimStill:
	; $7388, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BooWalkSprite_AnimWalk:
	; $738b, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BooWalkSprite_AnimBounce:
	; $7391, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BooWalkSprite_AnimNod:
	; $739d, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BooWalkSprite_AnimShake:
	; $73a5, 20 bytes (sprite_anim)
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
BooWalkSprite_Anim05:
	; $73b9, 5 bytes (sprite_anim)
	anim_frame $03, 20
	anim_frame $04, 30
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
BooWalkSprite_Anim06:
	; $73be, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BooWalkSprite_Anim07:
	; $73ca, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
BooWalkSprite_Anim08:
	; $73d0, 3 bytes (sprite_anim)
	anim_frame $03, 1
	anim_hold $fd
BooWalkSprite_Anim09:
	; $73d3, 3 bytes (sprite_anim)
	anim_frame $04, 1
	anim_hold $fd
BooWalkSprite_Anim10:
	; $73d6, 11 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_frame $0d, 10
	anim_frame $0e, 10
	anim_hold $fd
TrophyWalkSprite:
	db $05, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, TrophyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw TrophyWalkSprite_Gfx00, TrophyWalkSprite_Gfx01, TrophyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw TrophyWalkSprite_Gfx03 ; $73f1
	dw TrophyWalkSprite_Gfx04 ; $73f3
	dw TrophyWalkSprite_Gfx04 ; $73f5
	dw TrophyWalkSprite_Gfx04 ; $73f7
	dw TrophyWalkSprite_Gfx04 ; $73f9
	dw TrophyWalkSprite_Gfx04 ; $73fb
	dw TrophyWalkSprite_Gfx04 ; $73fd
	dw TrophyWalkSprite_Gfx04 ; $73ff
	dw TrophyWalkSprite_Gfx04 ; $7401
	dw TrophyWalkSprite_Gfx05 ; $7403
Padding_77_4:
	; $7405, 11 bytes (fill)
	ds 11, $00
	ds ALIGN[4]
TrophyWalkSprite_Gfx00:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx00.bin" ; $7410, 64 bytes
	ds ALIGN[4]
TrophyWalkSprite_Gfx01:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx01.bin" ; $7450, 64 bytes
	ds ALIGN[4]
TrophyWalkSprite_Gfx02:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx02.bin" ; $7490, 64 bytes
	ds ALIGN[4]
TrophyWalkSprite_Gfx03:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx03.bin" ; $74d0, 64 bytes
	ds ALIGN[4]
TrophyWalkSprite_Gfx04:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx04.bin" ; $7510, 64 bytes
	ds ALIGN[4]
TrophyWalkSprite_Gfx05:
	INCBIN "data/sprites/TrophyWalkSprite_Gfx05.bin" ; $7550, 64 bytes
TrophyWalkSprite_AnimPtrs:
	dw TrophyWalkSprite_Anim00 ; $7590
	dw TrophyWalkSprite_Anim01 ; $7592
	dw TrophyWalkSprite_Anim02 ; $7594
	dw TrophyWalkSprite_Anim02 ; $7596
	dw TrophyWalkSprite_Anim02 ; $7598
	dw TrophyWalkSprite_Anim02 ; $759a
	dw TrophyWalkSprite_Anim02 ; $759c
	dw TrophyWalkSprite_Anim03 ; $759e
	dw TrophyWalkSprite_Anim04 ; $75a0
TrophyWalkSprite_Anim00:
	; $75a2, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
TrophyWalkSprite_Anim01:
	; $75a5, 6 bytes (sprite_anim)
	anim_frame $00, 3
	anim_frame $01, 3
	anim_loop $00
TrophyWalkSprite_Anim02:
	; $75ab, 6 bytes (sprite_anim)
	anim_frame $02, 3
	anim_frame $03, 3
	anim_loop $00
TrophyWalkSprite_Anim03:
	; $75b1, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
TrophyWalkSprite_Anim04:
	; $75b4, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 3
	anim_loop $00
	; $75ba, 2630 bytes fill to bank end (linker-padded)
