DataPtr_RacketStudentWalkSprite:
	dw RacketStudentWalkSprite ; $4000
DataPtr_CatWalkSprite:
	dw CatWalkSprite ; $4002
DataPtr_AlexBWalkSprite:
	dw AlexBWalkSprite ; $4004
DataPtr_NinaBWalkSprite:
	dw NinaBWalkSprite ; $4006
DataPtr_HarryBWalkSprite:
	dw HarryBWalkSprite ; $4008
DataPtr_KateBWalkSprite:
	dw KateBWalkSprite ; $400a
DataPtr_EmilySweatsWalkSprite:
	dw EmilySweatsWalkSprite ; $400c
DataPtr_MarkSweatsWalkSprite:
	dw MarkSweatsWalkSprite ; $400e
DataPtr_KevinSweatsWalkSprite:
	dw KevinSweatsWalkSprite ; $4010
RacketStudentWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, RacketStudentWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw RacketStudentWalkSprite_Gfx00, RacketStudentWalkSprite_Gfx01, RacketStudentWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw RacketStudentWalkSprite_Gfx03 ; $4022
	dw RacketStudentWalkSprite_Gfx03 ; $4024
	dw RacketStudentWalkSprite_Gfx03 ; $4026
	dw RacketStudentWalkSprite_Gfx03 ; $4028
	dw RacketStudentWalkSprite_Gfx04 ; $402a
	dw RacketStudentWalkSprite_Gfx05 ; $402c
	dw RacketStudentWalkSprite_Gfx06 ; $402e
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx00:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx01:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx02:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx03:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx04:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx05:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx05.bin" ; $4530, 256 bytes
	ds ALIGN[4]
RacketStudentWalkSprite_Gfx06:
	INCBIN "data/sprites/RacketStudentWalkSprite_Gfx06.bin" ; $4630, 256 bytes
RacketStudentWalkSprite_AnimPtrs:
	dw RacketStudentWalkSprite_AnimStill ; $4730
	dw RacketStudentWalkSprite_AnimWalk ; $4732
	dw RacketStudentWalkSprite_AnimBounce ; $4734
	dw RacketStudentWalkSprite_AnimNod ; $4736
	dw RacketStudentWalkSprite_AnimShake ; $4738
	dw RacketStudentWalkSprite_Anim05 ; $473a
	dw RacketStudentWalkSprite_Anim06 ; $473c
	dw RacketStudentWalkSprite_Anim06 ; $473e
RacketStudentWalkSprite_AnimStill:
	; $4740, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
RacketStudentWalkSprite_AnimWalk:
	; $4743, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
RacketStudentWalkSprite_AnimBounce:
	; $4749, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
RacketStudentWalkSprite_AnimNod:
	; $4755, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
RacketStudentWalkSprite_AnimShake:
	; $475d, 20 bytes (sprite_anim)
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
RacketStudentWalkSprite_Anim05:
	; $4771, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
RacketStudentWalkSprite_Anim06:
	; $4779, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
CatWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, CatWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw CatWalkSprite_Gfx00, CatWalkSprite_Gfx01, CatWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw CatWalkSprite_Gfx02 ; $4795
	dw CatWalkSprite_Gfx02 ; $4797
	dw CatWalkSprite_Gfx02 ; $4799
	dw CatWalkSprite_Gfx02 ; $479b
	dw CatWalkSprite_Gfx03 ; $479d
	dw CatWalkSprite_Gfx04 ; $479f
	dw CatWalkSprite_Gfx05 ; $47a1
Padding_74_0:
	; $47a3, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
CatWalkSprite_Gfx00:
	INCBIN "data/sprites/CatWalkSprite_Gfx00.bin" ; $47b0, 256 bytes
	ds ALIGN[4]
CatWalkSprite_Gfx01:
	INCBIN "data/sprites/CatWalkSprite_Gfx01.bin" ; $48b0, 256 bytes
	ds ALIGN[4]
CatWalkSprite_Gfx02:
	INCBIN "data/sprites/CatWalkSprite_Gfx02.bin" ; $49b0, 256 bytes
	ds ALIGN[4]
CatWalkSprite_Gfx03:
	INCBIN "data/sprites/CatWalkSprite_Gfx03.bin" ; $4ab0, 256 bytes
	ds ALIGN[4]
CatWalkSprite_Gfx04:
	INCBIN "data/sprites/CatWalkSprite_Gfx04.bin" ; $4bb0, 256 bytes
	ds ALIGN[4]
CatWalkSprite_Gfx05:
	INCBIN "data/sprites/CatWalkSprite_Gfx05.bin" ; $4cb0, 256 bytes
CatWalkSprite_AnimPtrs:
	dw CatWalkSprite_AnimStill ; $4db0
	dw CatWalkSprite_AnimWalk ; $4db2
	dw CatWalkSprite_AnimBounce ; $4db4
	dw CatWalkSprite_AnimNod ; $4db6
	dw CatWalkSprite_AnimShake ; $4db8
	dw CatWalkSprite_Anim05 ; $4dba
	dw CatWalkSprite_Anim05 ; $4dbc
	dw CatWalkSprite_Anim05 ; $4dbe
CatWalkSprite_AnimStill:
	; $4dc0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
CatWalkSprite_AnimWalk:
	; $4dc3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
CatWalkSprite_AnimBounce:
	; $4dc9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
CatWalkSprite_AnimNod:
	; $4dd5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
CatWalkSprite_AnimShake:
	; $4ddd, 20 bytes (sprite_anim)
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
CatWalkSprite_Anim05:
	; $4df1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexBWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, AlexBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw AlexBWalkSprite_Gfx00, AlexBWalkSprite_Gfx01, AlexBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw AlexBWalkSprite_Gfx02 ; $4e0d
	dw AlexBWalkSprite_Gfx02 ; $4e0f
	dw AlexBWalkSprite_Gfx02 ; $4e11
	dw AlexBWalkSprite_Gfx02 ; $4e13
	dw AlexBWalkSprite_Gfx03 ; $4e15
	dw AlexBWalkSprite_Gfx04 ; $4e17
	dw AlexBWalkSprite_Gfx05 ; $4e19
Padding_74_1:
	; $4e1b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
AlexBWalkSprite_Gfx00:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx00.bin" ; $4e20, 256 bytes
	ds ALIGN[4]
AlexBWalkSprite_Gfx01:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx01.bin" ; $4f20, 256 bytes
	ds ALIGN[4]
AlexBWalkSprite_Gfx02:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx02.bin" ; $5020, 256 bytes
	ds ALIGN[4]
AlexBWalkSprite_Gfx03:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx03.bin" ; $5120, 256 bytes
	ds ALIGN[4]
AlexBWalkSprite_Gfx04:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx04.bin" ; $5220, 256 bytes
	ds ALIGN[4]
AlexBWalkSprite_Gfx05:
	INCBIN "data/sprites/AlexBWalkSprite_Gfx05.bin" ; $5320, 256 bytes
AlexBWalkSprite_AnimPtrs:
	dw AlexBWalkSprite_AnimStill ; $5420
	dw AlexBWalkSprite_AnimWalk ; $5422
	dw AlexBWalkSprite_AnimBounce ; $5424
	dw AlexBWalkSprite_AnimNod ; $5426
	dw AlexBWalkSprite_AnimShake ; $5428
	dw AlexBWalkSprite_Anim05 ; $542a
	dw AlexBWalkSprite_Anim05 ; $542c
	dw AlexBWalkSprite_Anim05 ; $542e
AlexBWalkSprite_AnimStill:
	; $5430, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
AlexBWalkSprite_AnimWalk:
	; $5433, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
AlexBWalkSprite_AnimBounce:
	; $5439, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexBWalkSprite_AnimNod:
	; $5445, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
AlexBWalkSprite_AnimShake:
	; $544d, 20 bytes (sprite_anim)
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
AlexBWalkSprite_Anim05:
	; $5461, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaBWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, NinaBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw NinaBWalkSprite_Gfx00, NinaBWalkSprite_Gfx01, NinaBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw NinaBWalkSprite_Gfx02 ; $547d
	dw NinaBWalkSprite_Gfx02 ; $547f
	dw NinaBWalkSprite_Gfx02 ; $5481
	dw NinaBWalkSprite_Gfx02 ; $5483
	dw NinaBWalkSprite_Gfx03 ; $5485
	dw NinaBWalkSprite_Gfx04 ; $5487
	dw NinaBWalkSprite_Gfx05 ; $5489
Padding_74_2:
	; $548b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
NinaBWalkSprite_Gfx00:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx00.bin" ; $5490, 256 bytes
	ds ALIGN[4]
NinaBWalkSprite_Gfx01:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx01.bin" ; $5590, 256 bytes
	ds ALIGN[4]
NinaBWalkSprite_Gfx02:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx02.bin" ; $5690, 256 bytes
	ds ALIGN[4]
NinaBWalkSprite_Gfx03:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx03.bin" ; $5790, 256 bytes
	ds ALIGN[4]
NinaBWalkSprite_Gfx04:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx04.bin" ; $5890, 256 bytes
	ds ALIGN[4]
NinaBWalkSprite_Gfx05:
	INCBIN "data/sprites/NinaBWalkSprite_Gfx05.bin" ; $5990, 256 bytes
NinaBWalkSprite_AnimPtrs:
	dw NinaBWalkSprite_AnimStill ; $5a90
	dw NinaBWalkSprite_AnimWalk ; $5a92
	dw NinaBWalkSprite_AnimBounce ; $5a94
	dw NinaBWalkSprite_AnimNod ; $5a96
	dw NinaBWalkSprite_AnimShake ; $5a98
	dw NinaBWalkSprite_Anim05 ; $5a9a
	dw NinaBWalkSprite_Anim05 ; $5a9c
	dw NinaBWalkSprite_Anim05 ; $5a9e
NinaBWalkSprite_AnimStill:
	; $5aa0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
NinaBWalkSprite_AnimWalk:
	; $5aa3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
NinaBWalkSprite_AnimBounce:
	; $5aa9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaBWalkSprite_AnimNod:
	; $5ab5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
NinaBWalkSprite_AnimShake:
	; $5abd, 20 bytes (sprite_anim)
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
NinaBWalkSprite_Anim05:
	; $5ad1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryBWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, HarryBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw HarryBWalkSprite_Gfx00, HarryBWalkSprite_Gfx01, HarryBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw HarryBWalkSprite_Gfx02 ; $5aed
	dw HarryBWalkSprite_Gfx02 ; $5aef
	dw HarryBWalkSprite_Gfx02 ; $5af1
	dw HarryBWalkSprite_Gfx02 ; $5af3
	dw HarryBWalkSprite_Gfx03 ; $5af5
	dw HarryBWalkSprite_Gfx04 ; $5af7
	dw HarryBWalkSprite_Gfx05 ; $5af9
Padding_74_3:
	; $5afb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
HarryBWalkSprite_Gfx00:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx00.bin" ; $5b00, 256 bytes
	ds ALIGN[4]
HarryBWalkSprite_Gfx01:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx01.bin" ; $5c00, 256 bytes
	ds ALIGN[4]
HarryBWalkSprite_Gfx02:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx02.bin" ; $5d00, 256 bytes
	ds ALIGN[4]
HarryBWalkSprite_Gfx03:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx03.bin" ; $5e00, 256 bytes
	ds ALIGN[4]
HarryBWalkSprite_Gfx04:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx04.bin" ; $5f00, 256 bytes
	ds ALIGN[4]
HarryBWalkSprite_Gfx05:
	INCBIN "data/sprites/HarryBWalkSprite_Gfx05.bin" ; $6000, 256 bytes
HarryBWalkSprite_AnimPtrs:
	dw HarryBWalkSprite_AnimStill ; $6100
	dw HarryBWalkSprite_AnimWalk ; $6102
	dw HarryBWalkSprite_AnimBounce ; $6104
	dw HarryBWalkSprite_AnimNod ; $6106
	dw HarryBWalkSprite_AnimShake ; $6108
	dw HarryBWalkSprite_Anim05 ; $610a
	dw HarryBWalkSprite_Anim05 ; $610c
	dw HarryBWalkSprite_Anim05 ; $610e
HarryBWalkSprite_AnimStill:
	; $6110, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
HarryBWalkSprite_AnimWalk:
	; $6113, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
HarryBWalkSprite_AnimBounce:
	; $6119, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryBWalkSprite_AnimNod:
	; $6125, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
HarryBWalkSprite_AnimShake:
	; $612d, 20 bytes (sprite_anim)
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
HarryBWalkSprite_Anim05:
	; $6141, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KateBWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, KateBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw KateBWalkSprite_Gfx00, KateBWalkSprite_Gfx01, KateBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw KateBWalkSprite_Gfx02 ; $615d
	dw KateBWalkSprite_Gfx02 ; $615f
	dw KateBWalkSprite_Gfx02 ; $6161
	dw KateBWalkSprite_Gfx02 ; $6163
	dw KateBWalkSprite_Gfx03 ; $6165
	dw KateBWalkSprite_Gfx04 ; $6167
	dw KateBWalkSprite_Gfx05 ; $6169
Padding_74_4:
	; $616b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
KateBWalkSprite_Gfx00:
	INCBIN "data/sprites/KateBWalkSprite_Gfx00.bin" ; $6170, 256 bytes
	ds ALIGN[4]
KateBWalkSprite_Gfx01:
	INCBIN "data/sprites/KateBWalkSprite_Gfx01.bin" ; $6270, 256 bytes
	ds ALIGN[4]
KateBWalkSprite_Gfx02:
	INCBIN "data/sprites/KateBWalkSprite_Gfx02.bin" ; $6370, 256 bytes
	ds ALIGN[4]
KateBWalkSprite_Gfx03:
	INCBIN "data/sprites/KateBWalkSprite_Gfx03.bin" ; $6470, 256 bytes
	ds ALIGN[4]
KateBWalkSprite_Gfx04:
	INCBIN "data/sprites/KateBWalkSprite_Gfx04.bin" ; $6570, 256 bytes
	ds ALIGN[4]
KateBWalkSprite_Gfx05:
	INCBIN "data/sprites/KateBWalkSprite_Gfx05.bin" ; $6670, 256 bytes
KateBWalkSprite_AnimPtrs:
	dw KateBWalkSprite_AnimStill ; $6770
	dw KateBWalkSprite_AnimWalk ; $6772
	dw KateBWalkSprite_AnimBounce ; $6774
	dw KateBWalkSprite_AnimNod ; $6776
	dw KateBWalkSprite_AnimShake ; $6778
	dw KateBWalkSprite_Anim05 ; $677a
	dw KateBWalkSprite_Anim05 ; $677c
	dw KateBWalkSprite_Anim05 ; $677e
KateBWalkSprite_AnimStill:
	; $6780, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
KateBWalkSprite_AnimWalk:
	; $6783, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
KateBWalkSprite_AnimBounce:
	; $6789, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KateBWalkSprite_AnimNod:
	; $6795, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
KateBWalkSprite_AnimShake:
	; $679d, 20 bytes (sprite_anim)
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
KateBWalkSprite_Anim05:
	; $67b1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilySweatsWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, EmilySweatsWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw EmilySweatsWalkSprite_Gfx00, EmilySweatsWalkSprite_Gfx01, EmilySweatsWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw EmilySweatsWalkSprite_Gfx02 ; $67cd
	dw EmilySweatsWalkSprite_Gfx02 ; $67cf
	dw EmilySweatsWalkSprite_Gfx02 ; $67d1
	dw EmilySweatsWalkSprite_Gfx02 ; $67d3
	dw EmilySweatsWalkSprite_Gfx03 ; $67d5
	dw EmilySweatsWalkSprite_Gfx04 ; $67d7
	dw EmilySweatsWalkSprite_Gfx05 ; $67d9
Padding_74_5:
	; $67db, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx00:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx00.bin" ; $67e0, 256 bytes
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx01:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx01.bin" ; $68e0, 256 bytes
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx02:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx02.bin" ; $69e0, 256 bytes
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx03:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx03.bin" ; $6ae0, 256 bytes
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx04:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx04.bin" ; $6be0, 256 bytes
	ds ALIGN[4]
EmilySweatsWalkSprite_Gfx05:
	INCBIN "data/sprites/EmilySweatsWalkSprite_Gfx05.bin" ; $6ce0, 256 bytes
EmilySweatsWalkSprite_AnimPtrs:
	dw EmilySweatsWalkSprite_AnimStill ; $6de0
	dw EmilySweatsWalkSprite_AnimWalk ; $6de2
	dw EmilySweatsWalkSprite_AnimBounce ; $6de4
	dw EmilySweatsWalkSprite_AnimNod ; $6de6
	dw EmilySweatsWalkSprite_AnimShake ; $6de8
	dw EmilySweatsWalkSprite_Anim05 ; $6dea
	dw EmilySweatsWalkSprite_Anim05 ; $6dec
	dw EmilySweatsWalkSprite_Anim05 ; $6dee
EmilySweatsWalkSprite_AnimStill:
	; $6df0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
EmilySweatsWalkSprite_AnimWalk:
	; $6df3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
EmilySweatsWalkSprite_AnimBounce:
	; $6df9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilySweatsWalkSprite_AnimNod:
	; $6e05, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilySweatsWalkSprite_AnimShake:
	; $6e0d, 20 bytes (sprite_anim)
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
EmilySweatsWalkSprite_Anim05:
	; $6e21, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarkSweatsWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MarkSweatsWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MarkSweatsWalkSprite_Gfx00, MarkSweatsWalkSprite_Gfx01, MarkSweatsWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MarkSweatsWalkSprite_Gfx02 ; $6e3d
	dw MarkSweatsWalkSprite_Gfx02 ; $6e3f
	dw MarkSweatsWalkSprite_Gfx02 ; $6e41
	dw MarkSweatsWalkSprite_Gfx02 ; $6e43
	dw MarkSweatsWalkSprite_Gfx03 ; $6e45
	dw MarkSweatsWalkSprite_Gfx04 ; $6e47
	dw MarkSweatsWalkSprite_Gfx05 ; $6e49
Padding_74_6:
	; $6e4b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx00:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx00.bin" ; $6e50, 256 bytes
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx01:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx01.bin" ; $6f50, 256 bytes
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx02:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx02.bin" ; $7050, 256 bytes
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx03:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx03.bin" ; $7150, 256 bytes
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx04:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx04.bin" ; $7250, 256 bytes
	ds ALIGN[4]
MarkSweatsWalkSprite_Gfx05:
	INCBIN "data/sprites/MarkSweatsWalkSprite_Gfx05.bin" ; $7350, 256 bytes
MarkSweatsWalkSprite_AnimPtrs:
	dw MarkSweatsWalkSprite_AnimStill ; $7450
	dw MarkSweatsWalkSprite_AnimWalk ; $7452
	dw MarkSweatsWalkSprite_AnimBounce ; $7454
	dw MarkSweatsWalkSprite_AnimNod ; $7456
	dw MarkSweatsWalkSprite_AnimShake ; $7458
	dw MarkSweatsWalkSprite_Anim05 ; $745a
	dw MarkSweatsWalkSprite_Anim05 ; $745c
	dw MarkSweatsWalkSprite_Anim05 ; $745e
MarkSweatsWalkSprite_AnimStill:
	; $7460, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MarkSweatsWalkSprite_AnimWalk:
	; $7463, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MarkSweatsWalkSprite_AnimBounce:
	; $7469, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarkSweatsWalkSprite_AnimNod:
	; $7475, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MarkSweatsWalkSprite_AnimShake:
	; $747d, 20 bytes (sprite_anim)
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
MarkSweatsWalkSprite_Anim05:
	; $7491, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinSweatsWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, KevinSweatsWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw KevinSweatsWalkSprite_Gfx00, KevinSweatsWalkSprite_Gfx01, KevinSweatsWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw KevinSweatsWalkSprite_Gfx02 ; $74ad
	dw KevinSweatsWalkSprite_Gfx02 ; $74af
	dw KevinSweatsWalkSprite_Gfx02 ; $74b1
	dw KevinSweatsWalkSprite_Gfx02 ; $74b3
	dw KevinSweatsWalkSprite_Gfx03 ; $74b5
	dw KevinSweatsWalkSprite_Gfx04 ; $74b7
	dw KevinSweatsWalkSprite_Gfx05 ; $74b9
Padding_74_7:
	; $74bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx00:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx00.bin" ; $74c0, 256 bytes
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx01:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx01.bin" ; $75c0, 256 bytes
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx02:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx02.bin" ; $76c0, 256 bytes
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx03:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx03.bin" ; $77c0, 256 bytes
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx04:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx04.bin" ; $78c0, 256 bytes
	ds ALIGN[4]
KevinSweatsWalkSprite_Gfx05:
	INCBIN "data/sprites/KevinSweatsWalkSprite_Gfx05.bin" ; $79c0, 256 bytes
KevinSweatsWalkSprite_AnimPtrs:
	dw KevinSweatsWalkSprite_AnimStill ; $7ac0
	dw KevinSweatsWalkSprite_AnimWalk ; $7ac2
	dw KevinSweatsWalkSprite_AnimBounce ; $7ac4
	dw KevinSweatsWalkSprite_AnimNod ; $7ac6
	dw KevinSweatsWalkSprite_AnimShake ; $7ac8
	dw KevinSweatsWalkSprite_Anim05 ; $7aca
	dw KevinSweatsWalkSprite_Anim05 ; $7acc
	dw KevinSweatsWalkSprite_Anim05 ; $7ace
KevinSweatsWalkSprite_AnimStill:
	; $7ad0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
KevinSweatsWalkSprite_AnimWalk:
	; $7ad3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
KevinSweatsWalkSprite_AnimBounce:
	; $7ad9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinSweatsWalkSprite_AnimNod:
	; $7ae5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinSweatsWalkSprite_AnimShake:
	; $7aed, 20 bytes (sprite_anim)
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
KevinSweatsWalkSprite_Anim05:
	; $7b01, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
	; $7b0d, 1267 bytes fill to bank end (linker-padded)
