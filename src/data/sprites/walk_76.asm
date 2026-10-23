DataPtr_BrianWalkSprite:
	dw BrianWalkSprite ; $4000
DataPtr_CurtWalkSprite:
	dw CurtWalkSprite ; $4002
DataPtr_BobWalkSprite:
	dw BobWalkSprite ; $4004
DataPtr_JoyWalkSprite:
	dw JoyWalkSprite ; $4006
DataPtr_PamWalkSprite:
	dw PamWalkSprite ; $4008
DataPtr_BethWalkSprite:
	dw BethWalkSprite ; $400a
DataPtr_WaterSpriteWalkSprite:
	dw WaterSpriteWalkSprite ; $400c
BrianWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BrianWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BrianWalkSprite_Gfx00, BrianWalkSprite_Gfx01, BrianWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BrianWalkSprite_Gfx02 ; $401e
	dw BrianWalkSprite_Gfx02 ; $4020
	dw BrianWalkSprite_Gfx02 ; $4022
	dw BrianWalkSprite_Gfx02 ; $4024
	dw BrianWalkSprite_Gfx03 ; $4026
	dw BrianWalkSprite_Gfx04 ; $4028
	dw BrianWalkSprite_Gfx05 ; $402a
Padding_76_0:
	; $402c, 4 bytes (fill)
	ds 4, $00
	ds ALIGN[4]
BrianWalkSprite_Gfx00:
	INCBIN "data/sprites/BrianWalkSprite_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
BrianWalkSprite_Gfx01:
	INCBIN "data/sprites/BrianWalkSprite_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
BrianWalkSprite_Gfx02:
	INCBIN "data/sprites/BrianWalkSprite_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
BrianWalkSprite_Gfx03:
	INCBIN "data/sprites/BrianWalkSprite_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
BrianWalkSprite_Gfx04:
	INCBIN "data/sprites/BrianWalkSprite_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
BrianWalkSprite_Gfx05:
	INCBIN "data/sprites/BrianWalkSprite_Gfx05.bin" ; $4530, 256 bytes
BrianWalkSprite_AnimPtrs:
	dw BrianWalkSprite_AnimStill ; $4630
	dw BrianWalkSprite_AnimWalk ; $4632
	dw BrianWalkSprite_AnimBounce ; $4634
	dw BrianWalkSprite_AnimNod ; $4636
	dw BrianWalkSprite_AnimShake ; $4638
	dw BrianWalkSprite_Anim05 ; $463a
	dw BrianWalkSprite_Anim05 ; $463c
	dw BrianWalkSprite_Anim05 ; $463e
BrianWalkSprite_AnimStill:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BrianWalkSprite_AnimWalk:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BrianWalkSprite_AnimBounce:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BrianWalkSprite_AnimNod:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BrianWalkSprite_AnimShake:
	; $465d, 20 bytes (sprite_anim)
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
BrianWalkSprite_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
CurtWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, CurtWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw CurtWalkSprite_Gfx00, CurtWalkSprite_Gfx01, CurtWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw CurtWalkSprite_Gfx02 ; $468d
	dw CurtWalkSprite_Gfx02 ; $468f
	dw CurtWalkSprite_Gfx02 ; $4691
	dw CurtWalkSprite_Gfx02 ; $4693
	dw CurtWalkSprite_Gfx03 ; $4695
	dw CurtWalkSprite_Gfx04 ; $4697
	dw CurtWalkSprite_Gfx05 ; $4699
Padding_76_1:
	; $469b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
CurtWalkSprite_Gfx00:
	INCBIN "data/sprites/CurtWalkSprite_Gfx00.bin" ; $46a0, 256 bytes
	ds ALIGN[4]
CurtWalkSprite_Gfx01:
	INCBIN "data/sprites/CurtWalkSprite_Gfx01.bin" ; $47a0, 256 bytes
	ds ALIGN[4]
CurtWalkSprite_Gfx02:
	INCBIN "data/sprites/CurtWalkSprite_Gfx02.bin" ; $48a0, 256 bytes
	ds ALIGN[4]
CurtWalkSprite_Gfx03:
	INCBIN "data/sprites/CurtWalkSprite_Gfx03.bin" ; $49a0, 256 bytes
	ds ALIGN[4]
CurtWalkSprite_Gfx04:
	INCBIN "data/sprites/CurtWalkSprite_Gfx04.bin" ; $4aa0, 256 bytes
	ds ALIGN[4]
CurtWalkSprite_Gfx05:
	INCBIN "data/sprites/CurtWalkSprite_Gfx05.bin" ; $4ba0, 256 bytes
CurtWalkSprite_AnimPtrs:
	dw CurtWalkSprite_AnimStill ; $4ca0
	dw CurtWalkSprite_AnimWalk ; $4ca2
	dw CurtWalkSprite_AnimBounce ; $4ca4
	dw CurtWalkSprite_AnimNod ; $4ca6
	dw CurtWalkSprite_AnimShake ; $4ca8
	dw CurtWalkSprite_Anim05 ; $4caa
	dw CurtWalkSprite_Anim05 ; $4cac
	dw CurtWalkSprite_Anim05 ; $4cae
CurtWalkSprite_AnimStill:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
CurtWalkSprite_AnimWalk:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
CurtWalkSprite_AnimBounce:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
CurtWalkSprite_AnimNod:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
CurtWalkSprite_AnimShake:
	; $4ccd, 20 bytes (sprite_anim)
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
CurtWalkSprite_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BobWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BobWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BobWalkSprite_Gfx00, BobWalkSprite_Gfx01, BobWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BobWalkSprite_Gfx03 ; $4cfd
	dw BobWalkSprite_Gfx04 ; $4cff
	dw BobWalkSprite_Gfx05 ; $4d01
	dw BobWalkSprite_Gfx06 ; $4d03
	dw BobWalkSprite_Gfx07 ; $4d05
	dw BobWalkSprite_Gfx08 ; $4d07
	dw BobWalkSprite_Gfx09 ; $4d09
Padding_76_2:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
BobWalkSprite_Gfx00:
	INCBIN "data/sprites/BobWalkSprite_Gfx00.bin" ; $4d10, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx01:
	INCBIN "data/sprites/BobWalkSprite_Gfx01.bin" ; $4e10, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx02:
	INCBIN "data/sprites/BobWalkSprite_Gfx02.bin" ; $4f10, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx03:
	INCBIN "data/sprites/BobWalkSprite_Gfx03.bin" ; $5010, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx04:
	INCBIN "data/sprites/BobWalkSprite_Gfx04.bin" ; $5110, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx05:
	INCBIN "data/sprites/BobWalkSprite_Gfx05.bin" ; $5210, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx06:
	INCBIN "data/sprites/BobWalkSprite_Gfx06.bin" ; $5310, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx07:
	INCBIN "data/sprites/BobWalkSprite_Gfx07.bin" ; $5410, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx08:
	INCBIN "data/sprites/BobWalkSprite_Gfx08.bin" ; $5510, 256 bytes
	ds ALIGN[4]
BobWalkSprite_Gfx09:
	INCBIN "data/sprites/BobWalkSprite_Gfx09.bin" ; $5610, 256 bytes
BobWalkSprite_AnimPtrs:
	dw BobWalkSprite_AnimStill ; $5710
	dw BobWalkSprite_AnimWalk ; $5712
	dw BobWalkSprite_AnimBounce ; $5714
	dw BobWalkSprite_AnimNod ; $5716
	dw BobWalkSprite_AnimShake ; $5718
	dw BobWalkSprite_Anim05 ; $571a
	dw BobWalkSprite_Anim06 ; $571c
	dw BobWalkSprite_Anim07 ; $571e
	dw BobWalkSprite_Anim08 ; $5720
BobWalkSprite_AnimStill:
	; $5722, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BobWalkSprite_AnimWalk:
	; $5725, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BobWalkSprite_AnimBounce:
	; $572b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BobWalkSprite_AnimNod:
	; $5737, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BobWalkSprite_AnimShake:
	; $573f, 20 bytes (sprite_anim)
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
BobWalkSprite_Anim05:
	; $5753, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
BobWalkSprite_Anim06:
	; $575b, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
BobWalkSprite_Anim07:
	; $5760, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BobWalkSprite_Anim08:
	; $576c, 8 bytes (sprite_anim)
	anim_frame $05, 90
	anim_frame $03, 3
	anim_frame $04, 90
	anim_loop $00
JoyWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, JoyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw JoyWalkSprite_Gfx00, JoyWalkSprite_Gfx01, JoyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw JoyWalkSprite_Gfx02 ; $5784
	dw JoyWalkSprite_Gfx02 ; $5786
	dw JoyWalkSprite_Gfx02 ; $5788
	dw JoyWalkSprite_Gfx02 ; $578a
	dw JoyWalkSprite_Gfx03 ; $578c
	dw JoyWalkSprite_Gfx04 ; $578e
	dw JoyWalkSprite_Gfx05 ; $5790
Padding_76_3:
	; $5792, 14 bytes (fill)
	ds 14, $00
	ds ALIGN[4]
JoyWalkSprite_Gfx00:
	INCBIN "data/sprites/JoyWalkSprite_Gfx00.bin" ; $57a0, 256 bytes
	ds ALIGN[4]
JoyWalkSprite_Gfx01:
	INCBIN "data/sprites/JoyWalkSprite_Gfx01.bin" ; $58a0, 256 bytes
	ds ALIGN[4]
JoyWalkSprite_Gfx02:
	INCBIN "data/sprites/JoyWalkSprite_Gfx02.bin" ; $59a0, 256 bytes
	ds ALIGN[4]
JoyWalkSprite_Gfx03:
	INCBIN "data/sprites/JoyWalkSprite_Gfx03.bin" ; $5aa0, 256 bytes
	ds ALIGN[4]
JoyWalkSprite_Gfx04:
	INCBIN "data/sprites/JoyWalkSprite_Gfx04.bin" ; $5ba0, 256 bytes
	ds ALIGN[4]
JoyWalkSprite_Gfx05:
	INCBIN "data/sprites/JoyWalkSprite_Gfx05.bin" ; $5ca0, 256 bytes
JoyWalkSprite_AnimPtrs:
	dw JoyWalkSprite_AnimStill ; $5da0
	dw JoyWalkSprite_AnimWalk ; $5da2
	dw JoyWalkSprite_AnimBounce ; $5da4
	dw JoyWalkSprite_AnimNod ; $5da6
	dw JoyWalkSprite_AnimShake ; $5da8
	dw JoyWalkSprite_Anim05 ; $5daa
	dw JoyWalkSprite_Anim05 ; $5dac
	dw JoyWalkSprite_Anim05 ; $5dae
JoyWalkSprite_AnimStill:
	; $5db0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
JoyWalkSprite_AnimWalk:
	; $5db3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
JoyWalkSprite_AnimBounce:
	; $5db9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
JoyWalkSprite_AnimNod:
	; $5dc5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
JoyWalkSprite_AnimShake:
	; $5dcd, 20 bytes (sprite_anim)
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
JoyWalkSprite_Anim05:
	; $5de1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
PamWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, PamWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw PamWalkSprite_Gfx00, PamWalkSprite_Gfx01, PamWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw PamWalkSprite_Gfx03 ; $5dfd
	dw PamWalkSprite_Gfx04 ; $5dff
	dw PamWalkSprite_Gfx05 ; $5e01
	dw PamWalkSprite_Gfx06 ; $5e03
	dw PamWalkSprite_Gfx07 ; $5e05
	dw PamWalkSprite_Gfx08 ; $5e07
	dw PamWalkSprite_Gfx09 ; $5e09
Padding_76_4:
	; $5e0b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
PamWalkSprite_Gfx00:
	INCBIN "data/sprites/PamWalkSprite_Gfx00.bin" ; $5e10, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx01:
	INCBIN "data/sprites/PamWalkSprite_Gfx01.bin" ; $5f10, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx02:
	INCBIN "data/sprites/PamWalkSprite_Gfx02.bin" ; $6010, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx03:
	INCBIN "data/sprites/PamWalkSprite_Gfx03.bin" ; $6110, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx04:
	INCBIN "data/sprites/PamWalkSprite_Gfx04.bin" ; $6210, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx05:
	INCBIN "data/sprites/PamWalkSprite_Gfx05.bin" ; $6310, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx06:
	INCBIN "data/sprites/PamWalkSprite_Gfx06.bin" ; $6410, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx07:
	INCBIN "data/sprites/PamWalkSprite_Gfx07.bin" ; $6510, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx08:
	INCBIN "data/sprites/PamWalkSprite_Gfx08.bin" ; $6610, 256 bytes
	ds ALIGN[4]
PamWalkSprite_Gfx09:
	INCBIN "data/sprites/PamWalkSprite_Gfx09.bin" ; $6710, 256 bytes
PamWalkSprite_AnimPtrs:
	dw PamWalkSprite_AnimStill ; $6810
	dw PamWalkSprite_AnimWalk ; $6812
	dw PamWalkSprite_AnimBounce ; $6814
	dw PamWalkSprite_AnimNod ; $6816
	dw PamWalkSprite_AnimShake ; $6818
	dw PamWalkSprite_Anim05 ; $681a
	dw PamWalkSprite_Anim06 ; $681c
	dw PamWalkSprite_Anim07 ; $681e
PamWalkSprite_AnimStill:
	; $6820, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
PamWalkSprite_AnimWalk:
	; $6823, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
PamWalkSprite_AnimBounce:
	; $6829, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
PamWalkSprite_AnimNod:
	; $6835, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
PamWalkSprite_AnimShake:
	; $683d, 20 bytes (sprite_anim)
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
PamWalkSprite_Anim05:
	; $6851, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
PamWalkSprite_Anim06:
	; $6859, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
PamWalkSprite_Anim07:
	; $685e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BethWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BethWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BethWalkSprite_Gfx00, BethWalkSprite_Gfx01, BethWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BethWalkSprite_Gfx03 ; $687a
	dw BethWalkSprite_Gfx04 ; $687c
	dw BethWalkSprite_Gfx05 ; $687e
	dw BethWalkSprite_Gfx06 ; $6880
	dw BethWalkSprite_Gfx07 ; $6882
	dw BethWalkSprite_Gfx08 ; $6884
	dw BethWalkSprite_Gfx09 ; $6886
Padding_76_5:
	; $6888, 8 bytes (fill)
	ds 8, $00
	ds ALIGN[4]
BethWalkSprite_Gfx00:
	INCBIN "data/sprites/BethWalkSprite_Gfx00.bin" ; $6890, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx01:
	INCBIN "data/sprites/BethWalkSprite_Gfx01.bin" ; $6990, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx02:
	INCBIN "data/sprites/BethWalkSprite_Gfx02.bin" ; $6a90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx03:
	INCBIN "data/sprites/BethWalkSprite_Gfx03.bin" ; $6b90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx04:
	INCBIN "data/sprites/BethWalkSprite_Gfx04.bin" ; $6c90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx05:
	INCBIN "data/sprites/BethWalkSprite_Gfx05.bin" ; $6d90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx06:
	INCBIN "data/sprites/BethWalkSprite_Gfx06.bin" ; $6e90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx07:
	INCBIN "data/sprites/BethWalkSprite_Gfx07.bin" ; $6f90, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx08:
	INCBIN "data/sprites/BethWalkSprite_Gfx08.bin" ; $7090, 256 bytes
	ds ALIGN[4]
BethWalkSprite_Gfx09:
	INCBIN "data/sprites/BethWalkSprite_Gfx09.bin" ; $7190, 256 bytes
BethWalkSprite_AnimPtrs:
	dw BethWalkSprite_AnimStill ; $7290
	dw BethWalkSprite_AnimWalk ; $7292
	dw BethWalkSprite_AnimBounce ; $7294
	dw BethWalkSprite_AnimNod ; $7296
	dw BethWalkSprite_AnimShake ; $7298
	dw BethWalkSprite_Anim05 ; $729a
	dw BethWalkSprite_Anim06 ; $729c
	dw BethWalkSprite_Anim07 ; $729e
BethWalkSprite_AnimStill:
	; $72a0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BethWalkSprite_AnimWalk:
	; $72a3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BethWalkSprite_AnimBounce:
	; $72a9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BethWalkSprite_AnimNod:
	; $72b5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BethWalkSprite_AnimShake:
	; $72bd, 20 bytes (sprite_anim)
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
BethWalkSprite_Anim05:
	; $72d1, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
BethWalkSprite_Anim06:
	; $72d9, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
BethWalkSprite_Anim07:
	; $72de, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WaterSpriteWalkSprite:
	db $04, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WaterSpriteWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WaterSpriteWalkSprite_Gfx00, WaterSpriteWalkSprite_Gfx01, WaterSpriteWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw WaterSpriteWalkSprite_Gfx02 ; $72fa
	dw WaterSpriteWalkSprite_Gfx02 ; $72fc
	dw WaterSpriteWalkSprite_Gfx02 ; $72fe
	dw WaterSpriteWalkSprite_Gfx02 ; $7300
	dw WaterSpriteWalkSprite_Gfx03 ; $7302
	dw WaterSpriteWalkSprite_Gfx04 ; $7304
	dw WaterSpriteWalkSprite_Gfx05 ; $7306
Padding_76_6:
	; $7308, 8 bytes (fill)
	ds 8, $00
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx00:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx00.bin" ; $7310, 64 bytes
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx01:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx01.bin" ; $7350, 64 bytes
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx02:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx02.bin" ; $7390, 64 bytes
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx03:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx03.bin" ; $73d0, 64 bytes
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx04:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx04.bin" ; $7410, 64 bytes
	ds ALIGN[4]
WaterSpriteWalkSprite_Gfx05:
	INCBIN "data/sprites/WaterSpriteWalkSprite_Gfx05.bin" ; $7450, 64 bytes
WaterSpriteWalkSprite_AnimPtrs:
	dw WaterSpriteWalkSprite_AnimStill ; $7490
	dw WaterSpriteWalkSprite_AnimWalk ; $7492
	dw WaterSpriteWalkSprite_AnimBounce ; $7494
	dw WaterSpriteWalkSprite_AnimNod ; $7496
	dw WaterSpriteWalkSprite_AnimShake ; $7498
	dw WaterSpriteWalkSprite_Anim05 ; $749a
	dw WaterSpriteWalkSprite_Anim05 ; $749c
	dw WaterSpriteWalkSprite_Anim05 ; $749e
WaterSpriteWalkSprite_AnimStill:
	; $74a0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WaterSpriteWalkSprite_AnimWalk:
	; $74a3, 6 bytes (sprite_anim)
	anim_frame $00, 70
	anim_frame $01, 40
	anim_loop $00
WaterSpriteWalkSprite_AnimBounce:
	; $74a9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WaterSpriteWalkSprite_AnimNod:
	; $74b5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WaterSpriteWalkSprite_AnimShake:
	; $74bd, 20 bytes (sprite_anim)
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
WaterSpriteWalkSprite_Anim05:
	; $74d1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
	; $74dd, 2851 bytes fill to bank end (linker-padded)
