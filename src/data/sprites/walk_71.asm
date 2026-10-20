DataPtr_BowserWalkSprite:
	dw BowserWalkSprite ; $4000
DataPtr_PeachWalkSprite:
	dw PeachWalkSprite ; $4002
DataPtr_RestaurantServerWalkSprite:
	dw RestaurantServerWalkSprite ; $4004
DataPtr_StudentLongHairWalkSprite:
	dw StudentLongHairWalkSprite ; $4006
DataPtr_ChefWalkSprite:
	dw ChefWalkSprite ; $4008
DataPtr_StudentPonytailGirlWalkSprite:
	dw StudentPonytailGirlWalkSprite ; $400a
DataPtr_StudentCapBoyWalkSprite:
	dw StudentCapBoyWalkSprite ; $400c
DataPtr_StudentWavyHairGirlWalkSprite:
	dw StudentWavyHairGirlWalkSprite ; $400e
DataPtr_RacketWalkSprite:
	dw RacketWalkSprite ; $4010
DataPtr_InvisibleWalkSprite:
	dw InvisibleWalkSprite ; $4012
BowserWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BowserWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BowserWalkSprite_Gfx00, BowserWalkSprite_Gfx01, BowserWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BowserWalkSprite_Gfx02 ; $4024
	dw BowserWalkSprite_Gfx02 ; $4026
	dw BowserWalkSprite_Gfx02 ; $4028
	dw BowserWalkSprite_Gfx02 ; $402a
	dw BowserWalkSprite_Gfx03 ; $402c
	dw BowserWalkSprite_Gfx04 ; $402e
	dw BowserWalkSprite_Gfx05 ; $4030
Padding_71_00:
	; $4032, 14 bytes (fill)
	ds 14, $00
	ds ALIGN[4]
BowserWalkSprite_Gfx00:
	INCBIN "data/sprites/BowserWalkSprite_Gfx00.bin" ; $4040, 256 bytes
	ds ALIGN[4]
BowserWalkSprite_Gfx01:
	INCBIN "data/sprites/BowserWalkSprite_Gfx01.bin" ; $4140, 256 bytes
	ds ALIGN[4]
BowserWalkSprite_Gfx02:
	INCBIN "data/sprites/BowserWalkSprite_Gfx02.bin" ; $4240, 256 bytes
	ds ALIGN[4]
BowserWalkSprite_Gfx03:
	INCBIN "data/sprites/BowserWalkSprite_Gfx03.bin" ; $4340, 256 bytes
	ds ALIGN[4]
BowserWalkSprite_Gfx04:
	INCBIN "data/sprites/BowserWalkSprite_Gfx04.bin" ; $4440, 256 bytes
	ds ALIGN[4]
BowserWalkSprite_Gfx05:
	INCBIN "data/sprites/BowserWalkSprite_Gfx05.bin" ; $4540, 256 bytes
BowserWalkSprite_AnimPtrs:
	dw BowserWalkSprite_AnimStill ; $4640
	dw BowserWalkSprite_AnimWalk ; $4642
	dw BowserWalkSprite_AnimBounce ; $4644
	dw BowserWalkSprite_AnimNod ; $4646
	dw BowserWalkSprite_AnimShake ; $4648
	dw BowserWalkSprite_Anim05 ; $464a
	dw BowserWalkSprite_Anim05 ; $464c
	dw BowserWalkSprite_Anim05 ; $464e
BowserWalkSprite_AnimStill:
	; $4650, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BowserWalkSprite_AnimWalk:
	; $4653, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BowserWalkSprite_AnimBounce:
	; $4659, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BowserWalkSprite_AnimNod:
	; $4665, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BowserWalkSprite_AnimShake:
	; $466d, 20 bytes (sprite_anim)
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
BowserWalkSprite_Anim05:
	; $4681, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
PeachWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, PeachWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw PeachWalkSprite_Gfx00, PeachWalkSprite_Gfx01, PeachWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw PeachWalkSprite_Gfx02 ; $469d
	dw PeachWalkSprite_Gfx02 ; $469f
	dw PeachWalkSprite_Gfx02 ; $46a1
	dw PeachWalkSprite_Gfx02 ; $46a3
	dw PeachWalkSprite_Gfx03 ; $46a5
	dw PeachWalkSprite_Gfx04 ; $46a7
	dw PeachWalkSprite_Gfx05 ; $46a9
Padding_71_01:
	; $46ab, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
PeachWalkSprite_Gfx00:
	INCBIN "data/sprites/PeachWalkSprite_Gfx00.bin" ; $46b0, 256 bytes
	ds ALIGN[4]
PeachWalkSprite_Gfx01:
	INCBIN "data/sprites/PeachWalkSprite_Gfx01.bin" ; $47b0, 256 bytes
	ds ALIGN[4]
PeachWalkSprite_Gfx02:
	INCBIN "data/sprites/PeachWalkSprite_Gfx02.bin" ; $48b0, 256 bytes
	ds ALIGN[4]
PeachWalkSprite_Gfx03:
	INCBIN "data/sprites/PeachWalkSprite_Gfx03.bin" ; $49b0, 256 bytes
	ds ALIGN[4]
PeachWalkSprite_Gfx04:
	INCBIN "data/sprites/PeachWalkSprite_Gfx04.bin" ; $4ab0, 256 bytes
	ds ALIGN[4]
PeachWalkSprite_Gfx05:
	INCBIN "data/sprites/PeachWalkSprite_Gfx05.bin" ; $4bb0, 256 bytes
PeachWalkSprite_AnimPtrs:
	dw PeachWalkSprite_AnimStill ; $4cb0
	dw PeachWalkSprite_AnimWalk ; $4cb2
	dw PeachWalkSprite_AnimBounce ; $4cb4
	dw PeachWalkSprite_AnimNod ; $4cb6
	dw PeachWalkSprite_AnimShake ; $4cb8
	dw PeachWalkSprite_Anim05 ; $4cba
	dw PeachWalkSprite_Anim05 ; $4cbc
	dw PeachWalkSprite_Anim05 ; $4cbe
PeachWalkSprite_AnimStill:
	; $4cc0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
PeachWalkSprite_AnimWalk:
	; $4cc3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
PeachWalkSprite_AnimBounce:
	; $4cc9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
PeachWalkSprite_AnimNod:
	; $4cd5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
PeachWalkSprite_AnimShake:
	; $4cdd, 20 bytes (sprite_anim)
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
PeachWalkSprite_Anim05:
	; $4cf1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
RestaurantServerWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, RestaurantServerWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw RestaurantServerWalkSprite_Gfx00, RestaurantServerWalkSprite_Gfx01, RestaurantServerWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw RestaurantServerWalkSprite_Gfx02 ; $4d0d
	dw RestaurantServerWalkSprite_Gfx02 ; $4d0f
	dw RestaurantServerWalkSprite_Gfx02 ; $4d11
	dw RestaurantServerWalkSprite_Gfx02 ; $4d13
	dw RestaurantServerWalkSprite_Gfx03 ; $4d15
	dw RestaurantServerWalkSprite_Gfx04 ; $4d17
	dw RestaurantServerWalkSprite_Gfx05 ; $4d19
Padding_71_02:
	; $4d1b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx00:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx00.bin" ; $4d20, 256 bytes
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx01:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx01.bin" ; $4e20, 256 bytes
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx02:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx02.bin" ; $4f20, 256 bytes
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx03:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx03.bin" ; $5020, 256 bytes
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx04:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx04.bin" ; $5120, 256 bytes
	ds ALIGN[4]
RestaurantServerWalkSprite_Gfx05:
	INCBIN "data/sprites/RestaurantServerWalkSprite_Gfx05.bin" ; $5220, 256 bytes
RestaurantServerWalkSprite_AnimPtrs:
	dw RestaurantServerWalkSprite_AnimStill ; $5320
	dw RestaurantServerWalkSprite_AnimWalk ; $5322
	dw RestaurantServerWalkSprite_AnimBounce ; $5324
	dw RestaurantServerWalkSprite_AnimNod ; $5326
	dw RestaurantServerWalkSprite_AnimShake ; $5328
	dw RestaurantServerWalkSprite_Anim05 ; $532a
	dw RestaurantServerWalkSprite_Anim05 ; $532c
	dw RestaurantServerWalkSprite_Anim05 ; $532e
RestaurantServerWalkSprite_AnimStill:
	; $5330, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
RestaurantServerWalkSprite_AnimWalk:
	; $5333, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
RestaurantServerWalkSprite_AnimBounce:
	; $5339, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
RestaurantServerWalkSprite_AnimNod:
	; $5345, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
RestaurantServerWalkSprite_AnimShake:
	; $534d, 20 bytes (sprite_anim)
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
RestaurantServerWalkSprite_Anim05:
	; $5361, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentLongHairWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentLongHairWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentLongHairWalkSprite_Gfx00, StudentLongHairWalkSprite_Gfx01, StudentLongHairWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentLongHairWalkSprite_Gfx02 ; $537d
	dw StudentLongHairWalkSprite_Gfx02 ; $537f
	dw StudentLongHairWalkSprite_Gfx02 ; $5381
	dw StudentLongHairWalkSprite_Gfx02 ; $5383
	dw StudentLongHairWalkSprite_Gfx03 ; $5385
	dw StudentLongHairWalkSprite_Gfx04 ; $5387
	dw StudentLongHairWalkSprite_Gfx05 ; $5389
Padding_71_03:
	; $538b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx00.bin" ; $5390, 256 bytes
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx01.bin" ; $5490, 256 bytes
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx02.bin" ; $5590, 256 bytes
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx03.bin" ; $5690, 256 bytes
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx04.bin" ; $5790, 256 bytes
	ds ALIGN[4]
StudentLongHairWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentLongHairWalkSprite_Gfx05.bin" ; $5890, 256 bytes
StudentLongHairWalkSprite_AnimPtrs:
	dw StudentLongHairWalkSprite_AnimStill ; $5990
	dw StudentLongHairWalkSprite_AnimWalk ; $5992
	dw StudentLongHairWalkSprite_AnimBounce ; $5994
	dw StudentLongHairWalkSprite_AnimNod ; $5996
	dw StudentLongHairWalkSprite_AnimShake ; $5998
	dw StudentLongHairWalkSprite_Anim05 ; $599a
	dw StudentLongHairWalkSprite_Anim05 ; $599c
	dw StudentLongHairWalkSprite_Anim05 ; $599e
StudentLongHairWalkSprite_AnimStill:
	; $59a0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentLongHairWalkSprite_AnimWalk:
	; $59a3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentLongHairWalkSprite_AnimBounce:
	; $59a9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentLongHairWalkSprite_AnimNod:
	; $59b5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentLongHairWalkSprite_AnimShake:
	; $59bd, 20 bytes (sprite_anim)
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
StudentLongHairWalkSprite_Anim05:
	; $59d1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ChefWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, ChefWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw ChefWalkSprite_Gfx00, ChefWalkSprite_Gfx01, ChefWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw ChefWalkSprite_Gfx02 ; $59ed
	dw ChefWalkSprite_Gfx02 ; $59ef
	dw ChefWalkSprite_Gfx02 ; $59f1
	dw ChefWalkSprite_Gfx02 ; $59f3
	dw ChefWalkSprite_Gfx03 ; $59f5
	dw ChefWalkSprite_Gfx04 ; $59f7
	dw ChefWalkSprite_Gfx05 ; $59f9
Padding_71_04:
	; $59fb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
ChefWalkSprite_Gfx00:
	INCBIN "data/sprites/ChefWalkSprite_Gfx00.bin" ; $5a00, 256 bytes
	ds ALIGN[4]
ChefWalkSprite_Gfx01:
	INCBIN "data/sprites/ChefWalkSprite_Gfx01.bin" ; $5b00, 256 bytes
	ds ALIGN[4]
ChefWalkSprite_Gfx02:
	INCBIN "data/sprites/ChefWalkSprite_Gfx02.bin" ; $5c00, 256 bytes
	ds ALIGN[4]
ChefWalkSprite_Gfx03:
	INCBIN "data/sprites/ChefWalkSprite_Gfx03.bin" ; $5d00, 256 bytes
	ds ALIGN[4]
ChefWalkSprite_Gfx04:
	INCBIN "data/sprites/ChefWalkSprite_Gfx04.bin" ; $5e00, 256 bytes
	ds ALIGN[4]
ChefWalkSprite_Gfx05:
	INCBIN "data/sprites/ChefWalkSprite_Gfx05.bin" ; $5f00, 256 bytes
ChefWalkSprite_AnimPtrs:
	dw ChefWalkSprite_AnimStill ; $6000
	dw ChefWalkSprite_AnimWalk ; $6002
	dw ChefWalkSprite_AnimBounce ; $6004
	dw ChefWalkSprite_AnimNod ; $6006
	dw ChefWalkSprite_AnimShake ; $6008
	dw ChefWalkSprite_Anim05 ; $600a
	dw ChefWalkSprite_Anim05 ; $600c
	dw ChefWalkSprite_Anim05 ; $600e
ChefWalkSprite_AnimStill:
	; $6010, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
ChefWalkSprite_AnimWalk:
	; $6013, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
ChefWalkSprite_AnimBounce:
	; $6019, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ChefWalkSprite_AnimNod:
	; $6025, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
ChefWalkSprite_AnimShake:
	; $602d, 20 bytes (sprite_anim)
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
ChefWalkSprite_Anim05:
	; $6041, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPonytailGirlWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentPonytailGirlWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentPonytailGirlWalkSprite_Gfx00, StudentPonytailGirlWalkSprite_Gfx01, StudentPonytailGirlWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentPonytailGirlWalkSprite_Gfx02 ; $605d
	dw StudentPonytailGirlWalkSprite_Gfx03 ; $605f
	dw StudentPonytailGirlWalkSprite_Gfx04 ; $6061
	dw StudentPonytailGirlWalkSprite_Gfx05 ; $6063
	dw StudentPonytailGirlWalkSprite_Gfx06 ; $6065
	dw StudentPonytailGirlWalkSprite_Gfx07 ; $6067
	dw StudentPonytailGirlWalkSprite_Gfx08 ; $6069
Padding_71_05:
	; $606b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx00.bin" ; $6070, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx01.bin" ; $6170, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx02.bin" ; $6270, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx03.bin" ; $6370, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx04.bin" ; $6470, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx05.bin" ; $6570, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx06:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx06.bin" ; $6670, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx07:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx07.bin" ; $6770, 256 bytes
	ds ALIGN[4]
StudentPonytailGirlWalkSprite_Gfx08:
	INCBIN "data/sprites/StudentPonytailGirlWalkSprite_Gfx08.bin" ; $6870, 256 bytes
StudentPonytailGirlWalkSprite_AnimPtrs:
	dw StudentPonytailGirlWalkSprite_AnimStill ; $6970
	dw StudentPonytailGirlWalkSprite_AnimWalk ; $6972
	dw StudentPonytailGirlWalkSprite_AnimBounce ; $6974
	dw StudentPonytailGirlWalkSprite_AnimNod ; $6976
	dw StudentPonytailGirlWalkSprite_AnimShake ; $6978
	dw StudentPonytailGirlWalkSprite_Anim05 ; $697a
	dw StudentPonytailGirlWalkSprite_Anim05 ; $697c
	dw StudentPonytailGirlWalkSprite_Anim06 ; $697e
	dw StudentPonytailGirlWalkSprite_Anim07 ; $6980
StudentPonytailGirlWalkSprite_AnimStill:
	; $6982, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentPonytailGirlWalkSprite_AnimWalk:
	; $6985, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentPonytailGirlWalkSprite_AnimBounce:
	; $698b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPonytailGirlWalkSprite_AnimNod:
	; $6997, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPonytailGirlWalkSprite_AnimShake:
	; $699f, 20 bytes (sprite_anim)
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
StudentPonytailGirlWalkSprite_Anim05:
	; $69b3, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
StudentPonytailGirlWalkSprite_Anim06:
	; $69b8, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPonytailGirlWalkSprite_Anim07:
	; $69c4, 8 bytes (sprite_anim)
	anim_frame $05, 90
	anim_frame $03, 3
	anim_frame $04, 90
	anim_loop $00
StudentCapBoyWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentCapBoyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentCapBoyWalkSprite_Gfx00, StudentCapBoyWalkSprite_Gfx01, StudentCapBoyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentCapBoyWalkSprite_Gfx02 ; $69dc
	dw StudentCapBoyWalkSprite_Gfx03 ; $69de
	dw StudentCapBoyWalkSprite_Gfx04 ; $69e0
	dw StudentCapBoyWalkSprite_Gfx05 ; $69e2
	dw StudentCapBoyWalkSprite_Gfx06 ; $69e4
	dw StudentCapBoyWalkSprite_Gfx07 ; $69e6
	dw StudentCapBoyWalkSprite_Gfx08 ; $69e8
Padding_71_06:
	; $69ea, 6 bytes (fill)
	ds 6, $00
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx00.bin" ; $69f0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx01.bin" ; $6af0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx02.bin" ; $6bf0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx03.bin" ; $6cf0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx04.bin" ; $6df0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx05.bin" ; $6ef0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx06:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx06.bin" ; $6ff0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx07:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx07.bin" ; $70f0, 256 bytes
	ds ALIGN[4]
StudentCapBoyWalkSprite_Gfx08:
	INCBIN "data/sprites/StudentCapBoyWalkSprite_Gfx08.bin" ; $71f0, 256 bytes
StudentCapBoyWalkSprite_AnimPtrs:
	dw StudentCapBoyWalkSprite_AnimStill ; $72f0
	dw StudentCapBoyWalkSprite_AnimWalk ; $72f2
	dw StudentCapBoyWalkSprite_AnimBounce ; $72f4
	dw StudentCapBoyWalkSprite_AnimNod ; $72f6
	dw StudentCapBoyWalkSprite_AnimShake ; $72f8
	dw StudentCapBoyWalkSprite_Anim05 ; $72fa
	dw StudentCapBoyWalkSprite_Anim05 ; $72fc
	dw StudentCapBoyWalkSprite_Anim06 ; $72fe
	dw StudentCapBoyWalkSprite_Anim07 ; $7300
StudentCapBoyWalkSprite_AnimStill:
	; $7302, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentCapBoyWalkSprite_AnimWalk:
	; $7305, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentCapBoyWalkSprite_AnimBounce:
	; $730b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentCapBoyWalkSprite_AnimNod:
	; $7317, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentCapBoyWalkSprite_AnimShake:
	; $731f, 20 bytes (sprite_anim)
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
StudentCapBoyWalkSprite_Anim05:
	; $7333, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
StudentCapBoyWalkSprite_Anim06:
	; $7338, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentCapBoyWalkSprite_Anim07:
	; $7344, 8 bytes (sprite_anim)
	anim_frame $05, 90
	anim_frame $03, 3
	anim_frame $04, 90
	anim_loop $00
StudentWavyHairGirlWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentWavyHairGirlWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentWavyHairGirlWalkSprite_Gfx00, StudentWavyHairGirlWalkSprite_Gfx01, StudentWavyHairGirlWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentWavyHairGirlWalkSprite_Gfx02 ; $735c
	dw StudentWavyHairGirlWalkSprite_Gfx03 ; $735e
	dw StudentWavyHairGirlWalkSprite_Gfx04 ; $7360
	dw StudentWavyHairGirlWalkSprite_Gfx05 ; $7362
	dw StudentWavyHairGirlWalkSprite_Gfx06 ; $7364
	dw StudentWavyHairGirlWalkSprite_Gfx07 ; $7366
	dw StudentWavyHairGirlWalkSprite_Gfx08 ; $7368
Padding_71_07:
	; $736a, 6 bytes (fill)
	ds 6, $00
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx00.bin" ; $7370, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx01.bin" ; $7470, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx02.bin" ; $7570, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx03.bin" ; $7670, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx04.bin" ; $7770, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx05.bin" ; $7870, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx06:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx06.bin" ; $7970, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx07:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx07.bin" ; $7a70, 256 bytes
	ds ALIGN[4]
StudentWavyHairGirlWalkSprite_Gfx08:
	INCBIN "data/sprites/StudentWavyHairGirlWalkSprite_Gfx08.bin" ; $7b70, 256 bytes
StudentWavyHairGirlWalkSprite_AnimPtrs:
	dw StudentWavyHairGirlWalkSprite_AnimStill ; $7c70
	dw StudentWavyHairGirlWalkSprite_AnimWalk ; $7c72
	dw StudentWavyHairGirlWalkSprite_AnimBounce ; $7c74
	dw StudentWavyHairGirlWalkSprite_AnimNod ; $7c76
	dw StudentWavyHairGirlWalkSprite_AnimShake ; $7c78
	dw StudentWavyHairGirlWalkSprite_Anim05 ; $7c7a
	dw StudentWavyHairGirlWalkSprite_Anim05 ; $7c7c
	dw StudentWavyHairGirlWalkSprite_Anim06 ; $7c7e
	dw StudentWavyHairGirlWalkSprite_Anim07 ; $7c80
StudentWavyHairGirlWalkSprite_AnimStill:
	; $7c82, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentWavyHairGirlWalkSprite_AnimWalk:
	; $7c85, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentWavyHairGirlWalkSprite_AnimBounce:
	; $7c8b, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentWavyHairGirlWalkSprite_AnimNod:
	; $7c97, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentWavyHairGirlWalkSprite_AnimShake:
	; $7c9f, 20 bytes (sprite_anim)
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
StudentWavyHairGirlWalkSprite_Anim05:
	; $7cb3, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
StudentWavyHairGirlWalkSprite_Anim06:
	; $7cb8, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentWavyHairGirlWalkSprite_Anim07:
	; $7cc4, 8 bytes (sprite_anim)
	anim_frame $05, 90
	anim_frame $03, 3
	anim_frame $04, 90
	anim_loop $00
RacketWalkSprite:
	db $05, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, RacketWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw RacketWalkSprite_Gfx00, RacketWalkSprite_AnimPtrs, RacketWalkSprite_AnimPtrs ; frame pointers (continue in body)
	dw RacketWalkSprite_AnimPtrs ; $7cdc
	dw RacketWalkSprite_AnimPtrs ; $7cde
	dw RacketWalkSprite_AnimPtrs ; $7ce0
	dw RacketWalkSprite_AnimPtrs ; $7ce2
	dw RacketWalkSprite_AnimPtrs ; $7ce4
	dw RacketWalkSprite_AnimPtrs ; $7ce6
	dw RacketWalkSprite_AnimPtrs ; $7ce8
Padding_71_08:
	; $7cea, 6 bytes (fill)
	ds 6, $00
	ds ALIGN[4]
RacketWalkSprite_Gfx00:
	INCBIN "data/sprites/RacketWalkSprite_Gfx00.bin" ; $7cf0, 64 bytes
RacketWalkSprite_AnimPtrs:
	dw RacketWalkSprite_Anim00 ; $7d30
	dw RacketWalkSprite_Anim00 ; $7d32
	dw RacketWalkSprite_Anim00 ; $7d34
	dw RacketWalkSprite_Anim00 ; $7d36
	dw RacketWalkSprite_Anim00 ; $7d38
	dw RacketWalkSprite_Anim00 ; $7d3a
	dw RacketWalkSprite_Anim00 ; $7d3c
	dw RacketWalkSprite_Anim00 ; $7d3e
RacketWalkSprite_Anim00:
	; $7d40, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
InvisibleWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, InvisibleWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw InvisibleWalkSprite_Gfx00, InvisibleWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_71_09:
	; $7d53, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
InvisibleWalkSprite_Gfx00:
	INCBIN "data/sprites/InvisibleWalkSprite_Gfx00.bin" ; $7d60, 64 bytes
	ds ALIGN[4]
InvisibleWalkSprite_Gfx01:
	INCBIN "data/sprites/InvisibleWalkSprite_Gfx01.bin" ; $7da0, 64 bytes
InvisibleWalkSprite_AnimPtrs:
	dw InvisibleWalkSprite_Anim00 ; $7de0
	dw InvisibleWalkSprite_Anim01 ; $7de2
	dw InvisibleWalkSprite_Anim02 ; $7de4
	dw InvisibleWalkSprite_Anim02 ; $7de6
	dw InvisibleWalkSprite_Anim02 ; $7de8
	dw InvisibleWalkSprite_Anim02 ; $7dea
	dw InvisibleWalkSprite_Anim02 ; $7dec
	dw InvisibleWalkSprite_Anim02 ; $7dee
InvisibleWalkSprite_Anim00:
	; $7df0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
InvisibleWalkSprite_Anim01:
	; $7df3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
InvisibleWalkSprite_Anim02:
	; $7df9, 519 bytes fill to bank end (linker-padded)
