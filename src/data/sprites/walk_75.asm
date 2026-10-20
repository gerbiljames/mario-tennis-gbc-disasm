DataPtr_SammiWalkSprite:
	dw SammiWalkSprite ; $4000
DataPtr_SeanWalkSprite:
	dw SeanWalkSprite ; $4002
DataPtr_SpikeWalkSprite:
	dw SpikeWalkSprite ; $4004
DataPtr_EldenWalkSprite:
	dw EldenWalkSprite ; $4006
DataPtr_ACozWalkSprite:
	dw ACozWalkSprite ; $4008
DataPtr_BCozWalkSprite:
	dw BCozWalkSprite ; $400a
DataPtr_HeadmasterWalkSprite:
	dw HeadmasterWalkSprite ; $400c
DataPtr_AllieWalkSprite:
	dw AllieWalkSprite ; $400e
DataPtr_FayWalkSprite:
	dw FayWalkSprite ; $4010
SammiWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SammiWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SammiWalkSprite_Gfx00, SammiWalkSprite_Gfx01, SammiWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SammiWalkSprite_Gfx02 ; $4022
	dw SammiWalkSprite_Gfx02 ; $4024
	dw SammiWalkSprite_Gfx02 ; $4026
	dw SammiWalkSprite_Gfx02 ; $4028
	dw SammiWalkSprite_Gfx03 ; $402a
	dw SammiWalkSprite_Gfx04 ; $402c
	dw SammiWalkSprite_Gfx05 ; $402e
	ds ALIGN[4]
SammiWalkSprite_Gfx00:
	INCBIN "data/sprites/SammiWalkSprite_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
SammiWalkSprite_Gfx01:
	INCBIN "data/sprites/SammiWalkSprite_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
SammiWalkSprite_Gfx02:
	INCBIN "data/sprites/SammiWalkSprite_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
SammiWalkSprite_Gfx03:
	INCBIN "data/sprites/SammiWalkSprite_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
SammiWalkSprite_Gfx04:
	INCBIN "data/sprites/SammiWalkSprite_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
SammiWalkSprite_Gfx05:
	INCBIN "data/sprites/SammiWalkSprite_Gfx05.bin" ; $4530, 256 bytes
SammiWalkSprite_AnimPtrs:
	dw SammiWalkSprite_AnimStill ; $4630
	dw SammiWalkSprite_AnimWalk ; $4632
	dw SammiWalkSprite_AnimBounce ; $4634
	dw SammiWalkSprite_AnimNod ; $4636
	dw SammiWalkSprite_AnimShake ; $4638
	dw SammiWalkSprite_Anim05 ; $463a
	dw SammiWalkSprite_Anim05 ; $463c
	dw SammiWalkSprite_Anim05 ; $463e
SammiWalkSprite_AnimStill:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SammiWalkSprite_AnimWalk:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SammiWalkSprite_AnimBounce:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SammiWalkSprite_AnimNod:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SammiWalkSprite_AnimShake:
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
SammiWalkSprite_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SeanWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SeanWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SeanWalkSprite_Gfx00, SeanWalkSprite_Gfx01, SeanWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SeanWalkSprite_Gfx02 ; $468d
	dw SeanWalkSprite_Gfx02 ; $468f
	dw SeanWalkSprite_Gfx02 ; $4691
	dw SeanWalkSprite_Gfx02 ; $4693
	dw SeanWalkSprite_Gfx03 ; $4695
	dw SeanWalkSprite_Gfx04 ; $4697
	dw SeanWalkSprite_Gfx05 ; $4699
Padding_75_0:
	; $469b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
SeanWalkSprite_Gfx00:
	INCBIN "data/sprites/SeanWalkSprite_Gfx00.bin" ; $46a0, 256 bytes
	ds ALIGN[4]
SeanWalkSprite_Gfx01:
	INCBIN "data/sprites/SeanWalkSprite_Gfx01.bin" ; $47a0, 256 bytes
	ds ALIGN[4]
SeanWalkSprite_Gfx02:
	INCBIN "data/sprites/SeanWalkSprite_Gfx02.bin" ; $48a0, 256 bytes
	ds ALIGN[4]
SeanWalkSprite_Gfx03:
	INCBIN "data/sprites/SeanWalkSprite_Gfx03.bin" ; $49a0, 256 bytes
	ds ALIGN[4]
SeanWalkSprite_Gfx04:
	INCBIN "data/sprites/SeanWalkSprite_Gfx04.bin" ; $4aa0, 256 bytes
	ds ALIGN[4]
SeanWalkSprite_Gfx05:
	INCBIN "data/sprites/SeanWalkSprite_Gfx05.bin" ; $4ba0, 256 bytes
SeanWalkSprite_AnimPtrs:
	dw SeanWalkSprite_AnimStill ; $4ca0
	dw SeanWalkSprite_AnimWalk ; $4ca2
	dw SeanWalkSprite_AnimBounce ; $4ca4
	dw SeanWalkSprite_AnimNod ; $4ca6
	dw SeanWalkSprite_AnimShake ; $4ca8
	dw SeanWalkSprite_Anim05 ; $4caa
	dw SeanWalkSprite_Anim05 ; $4cac
	dw SeanWalkSprite_Anim05 ; $4cae
SeanWalkSprite_AnimStill:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SeanWalkSprite_AnimWalk:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SeanWalkSprite_AnimBounce:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SeanWalkSprite_AnimNod:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SeanWalkSprite_AnimShake:
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
SeanWalkSprite_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SpikeWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SpikeWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SpikeWalkSprite_Gfx00, SpikeWalkSprite_Gfx01, SpikeWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SpikeWalkSprite_Gfx02 ; $4cfd
	dw SpikeWalkSprite_Gfx02 ; $4cff
	dw SpikeWalkSprite_Gfx02 ; $4d01
	dw SpikeWalkSprite_Gfx02 ; $4d03
	dw SpikeWalkSprite_Gfx03 ; $4d05
	dw SpikeWalkSprite_Gfx04 ; $4d07
	dw SpikeWalkSprite_Gfx05 ; $4d09
Padding_75_1:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
SpikeWalkSprite_Gfx00:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx00.bin" ; $4d10, 256 bytes
	ds ALIGN[4]
SpikeWalkSprite_Gfx01:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx01.bin" ; $4e10, 256 bytes
	ds ALIGN[4]
SpikeWalkSprite_Gfx02:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx02.bin" ; $4f10, 256 bytes
	ds ALIGN[4]
SpikeWalkSprite_Gfx03:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx03.bin" ; $5010, 256 bytes
	ds ALIGN[4]
SpikeWalkSprite_Gfx04:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx04.bin" ; $5110, 256 bytes
	ds ALIGN[4]
SpikeWalkSprite_Gfx05:
	INCBIN "data/sprites/SpikeWalkSprite_Gfx05.bin" ; $5210, 256 bytes
SpikeWalkSprite_AnimPtrs:
	dw SpikeWalkSprite_AnimStill ; $5310
	dw SpikeWalkSprite_AnimWalk ; $5312
	dw SpikeWalkSprite_AnimBounce ; $5314
	dw SpikeWalkSprite_AnimNod ; $5316
	dw SpikeWalkSprite_AnimShake ; $5318
	dw SpikeWalkSprite_Anim05 ; $531a
	dw SpikeWalkSprite_Anim05 ; $531c
	dw SpikeWalkSprite_Anim05 ; $531e
SpikeWalkSprite_AnimStill:
	; $5320, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SpikeWalkSprite_AnimWalk:
	; $5323, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SpikeWalkSprite_AnimBounce:
	; $5329, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SpikeWalkSprite_AnimNod:
	; $5335, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SpikeWalkSprite_AnimShake:
	; $533d, 20 bytes (sprite_anim)
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
SpikeWalkSprite_Anim05:
	; $5351, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EldenWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, EldenWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw EldenWalkSprite_Gfx00, EldenWalkSprite_Gfx01, EldenWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw EldenWalkSprite_Gfx02 ; $536d
	dw EldenWalkSprite_Gfx02 ; $536f
	dw EldenWalkSprite_Gfx02 ; $5371
	dw EldenWalkSprite_Gfx02 ; $5373
	dw EldenWalkSprite_Gfx03 ; $5375
	dw EldenWalkSprite_Gfx04 ; $5377
	dw EldenWalkSprite_Gfx05 ; $5379
Padding_75_2:
	; $537b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
EldenWalkSprite_Gfx00:
	INCBIN "data/sprites/EldenWalkSprite_Gfx00.bin" ; $5380, 256 bytes
	ds ALIGN[4]
EldenWalkSprite_Gfx01:
	INCBIN "data/sprites/EldenWalkSprite_Gfx01.bin" ; $5480, 256 bytes
	ds ALIGN[4]
EldenWalkSprite_Gfx02:
	INCBIN "data/sprites/EldenWalkSprite_Gfx02.bin" ; $5580, 256 bytes
	ds ALIGN[4]
EldenWalkSprite_Gfx03:
	INCBIN "data/sprites/EldenWalkSprite_Gfx03.bin" ; $5680, 256 bytes
	ds ALIGN[4]
EldenWalkSprite_Gfx04:
	INCBIN "data/sprites/EldenWalkSprite_Gfx04.bin" ; $5780, 256 bytes
	ds ALIGN[4]
EldenWalkSprite_Gfx05:
	INCBIN "data/sprites/EldenWalkSprite_Gfx05.bin" ; $5880, 256 bytes
EldenWalkSprite_AnimPtrs:
	dw EldenWalkSprite_AnimStill ; $5980
	dw EldenWalkSprite_AnimWalk ; $5982
	dw EldenWalkSprite_AnimBounce ; $5984
	dw EldenWalkSprite_AnimNod ; $5986
	dw EldenWalkSprite_AnimShake ; $5988
	dw EldenWalkSprite_Anim05 ; $598a
	dw EldenWalkSprite_Anim05 ; $598c
	dw EldenWalkSprite_Anim05 ; $598e
EldenWalkSprite_AnimStill:
	; $5990, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
EldenWalkSprite_AnimWalk:
	; $5993, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
EldenWalkSprite_AnimBounce:
	; $5999, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EldenWalkSprite_AnimNod:
	; $59a5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
EldenWalkSprite_AnimShake:
	; $59ad, 20 bytes (sprite_anim)
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
EldenWalkSprite_Anim05:
	; $59c1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ACozWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, ACozWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw ACozWalkSprite_Gfx00, ACozWalkSprite_Gfx01, ACozWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw ACozWalkSprite_Gfx02 ; $59dd
	dw ACozWalkSprite_Gfx02 ; $59df
	dw ACozWalkSprite_Gfx02 ; $59e1
	dw ACozWalkSprite_Gfx02 ; $59e3
	dw ACozWalkSprite_Gfx03 ; $59e5
	dw ACozWalkSprite_Gfx04 ; $59e7
	dw ACozWalkSprite_Gfx05 ; $59e9
Padding_75_3:
	; $59eb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
ACozWalkSprite_Gfx00:
	INCBIN "data/sprites/ACozWalkSprite_Gfx00.bin" ; $59f0, 256 bytes
	ds ALIGN[4]
ACozWalkSprite_Gfx01:
	INCBIN "data/sprites/ACozWalkSprite_Gfx01.bin" ; $5af0, 256 bytes
	ds ALIGN[4]
ACozWalkSprite_Gfx02:
	INCBIN "data/sprites/ACozWalkSprite_Gfx02.bin" ; $5bf0, 256 bytes
	ds ALIGN[4]
ACozWalkSprite_Gfx03:
	INCBIN "data/sprites/ACozWalkSprite_Gfx03.bin" ; $5cf0, 256 bytes
	ds ALIGN[4]
ACozWalkSprite_Gfx04:
	INCBIN "data/sprites/ACozWalkSprite_Gfx04.bin" ; $5df0, 256 bytes
	ds ALIGN[4]
ACozWalkSprite_Gfx05:
	INCBIN "data/sprites/ACozWalkSprite_Gfx05.bin" ; $5ef0, 256 bytes
ACozWalkSprite_AnimPtrs:
	dw ACozWalkSprite_AnimStill ; $5ff0
	dw ACozWalkSprite_AnimWalk ; $5ff2
	dw ACozWalkSprite_AnimBounce ; $5ff4
	dw ACozWalkSprite_AnimNod ; $5ff6
	dw ACozWalkSprite_AnimShake ; $5ff8
	dw ACozWalkSprite_Anim05 ; $5ffa
	dw ACozWalkSprite_Anim05 ; $5ffc
	dw ACozWalkSprite_Anim05 ; $5ffe
ACozWalkSprite_AnimStill:
	; $6000, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
ACozWalkSprite_AnimWalk:
	; $6003, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
ACozWalkSprite_AnimBounce:
	; $6009, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ACozWalkSprite_AnimNod:
	; $6015, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
ACozWalkSprite_AnimShake:
	; $601d, 20 bytes (sprite_anim)
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
ACozWalkSprite_Anim05:
	; $6031, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BCozWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BCozWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BCozWalkSprite_Gfx00, BCozWalkSprite_Gfx01, BCozWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BCozWalkSprite_Gfx02 ; $604d
	dw BCozWalkSprite_Gfx02 ; $604f
	dw BCozWalkSprite_Gfx02 ; $6051
	dw BCozWalkSprite_Gfx02 ; $6053
	dw BCozWalkSprite_Gfx03 ; $6055
	dw BCozWalkSprite_Gfx04 ; $6057
	dw BCozWalkSprite_Gfx05 ; $6059
Padding_75_4:
	; $605b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
BCozWalkSprite_Gfx00:
	INCBIN "data/sprites/BCozWalkSprite_Gfx00.bin" ; $6060, 256 bytes
	ds ALIGN[4]
BCozWalkSprite_Gfx01:
	INCBIN "data/sprites/BCozWalkSprite_Gfx01.bin" ; $6160, 256 bytes
	ds ALIGN[4]
BCozWalkSprite_Gfx02:
	INCBIN "data/sprites/BCozWalkSprite_Gfx02.bin" ; $6260, 256 bytes
	ds ALIGN[4]
BCozWalkSprite_Gfx03:
	INCBIN "data/sprites/BCozWalkSprite_Gfx03.bin" ; $6360, 256 bytes
	ds ALIGN[4]
BCozWalkSprite_Gfx04:
	INCBIN "data/sprites/BCozWalkSprite_Gfx04.bin" ; $6460, 256 bytes
	ds ALIGN[4]
BCozWalkSprite_Gfx05:
	INCBIN "data/sprites/BCozWalkSprite_Gfx05.bin" ; $6560, 256 bytes
BCozWalkSprite_AnimPtrs:
	dw BCozWalkSprite_AnimStill ; $6660
	dw BCozWalkSprite_AnimWalk ; $6662
	dw BCozWalkSprite_AnimBounce ; $6664
	dw BCozWalkSprite_AnimNod ; $6666
	dw BCozWalkSprite_AnimShake ; $6668
	dw BCozWalkSprite_Anim05 ; $666a
	dw BCozWalkSprite_Anim05 ; $666c
	dw BCozWalkSprite_Anim05 ; $666e
BCozWalkSprite_AnimStill:
	; $6670, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BCozWalkSprite_AnimWalk:
	; $6673, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BCozWalkSprite_AnimBounce:
	; $6679, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BCozWalkSprite_AnimNod:
	; $6685, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BCozWalkSprite_AnimShake:
	; $668d, 20 bytes (sprite_anim)
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
BCozWalkSprite_Anim05:
	; $66a1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HeadmasterWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, HeadmasterWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw HeadmasterWalkSprite_Gfx00, HeadmasterWalkSprite_Gfx01, HeadmasterWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw HeadmasterWalkSprite_Gfx02 ; $66bd
	dw HeadmasterWalkSprite_Gfx02 ; $66bf
	dw HeadmasterWalkSprite_Gfx02 ; $66c1
	dw HeadmasterWalkSprite_Gfx02 ; $66c3
	dw HeadmasterWalkSprite_Gfx03 ; $66c5
	dw HeadmasterWalkSprite_Gfx04 ; $66c7
	dw HeadmasterWalkSprite_Gfx05 ; $66c9
	dw HeadmasterWalkSprite_AnimPtrs ; $66cb
Padding_75_5:
	; $66cd, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx00:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx00.bin" ; $66d0, 256 bytes
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx01:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx01.bin" ; $67d0, 256 bytes
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx02:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx02.bin" ; $68d0, 256 bytes
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx03:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx03.bin" ; $69d0, 256 bytes
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx04:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx04.bin" ; $6ad0, 256 bytes
	ds ALIGN[4]
HeadmasterWalkSprite_Gfx05:
	INCBIN "data/sprites/HeadmasterWalkSprite_Gfx05.bin" ; $6bd0, 256 bytes
HeadmasterWalkSprite_AnimPtrs:
	dw HeadmasterWalkSprite_AnimStill ; $6cd0
	dw HeadmasterWalkSprite_AnimWalk ; $6cd2
	dw HeadmasterWalkSprite_AnimBounce ; $6cd4
	dw HeadmasterWalkSprite_AnimNod ; $6cd6
	dw HeadmasterWalkSprite_AnimShake ; $6cd8
	dw HeadmasterWalkSprite_Anim05 ; $6cda
	dw HeadmasterWalkSprite_Anim06 ; $6cdc
	dw HeadmasterWalkSprite_Anim06 ; $6cde
	dw HeadmasterWalkSprite_Anim07 ; $6ce0
HeadmasterWalkSprite_AnimStill:
	; $6ce2, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
HeadmasterWalkSprite_AnimWalk:
	; $6ce5, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
HeadmasterWalkSprite_AnimBounce:
	; $6ceb, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HeadmasterWalkSprite_AnimNod:
	; $6cf7, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
HeadmasterWalkSprite_AnimShake:
	; $6cff, 20 bytes (sprite_anim)
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
HeadmasterWalkSprite_Anim05:
	; $6d13, 6 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 10
	anim_set ANIM_WALK
HeadmasterWalkSprite_Anim06:
	; $6d19, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
HeadmasterWalkSprite_Anim07:
	; $6d25, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
AllieWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, AllieWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw AllieWalkSprite_Gfx00, AllieWalkSprite_Gfx01, AllieWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw AllieWalkSprite_Gfx02 ; $6d3b
	dw AllieWalkSprite_Gfx02 ; $6d3d
	dw AllieWalkSprite_Gfx02 ; $6d3f
	dw AllieWalkSprite_Gfx02 ; $6d41
	dw AllieWalkSprite_Gfx03 ; $6d43
	dw AllieWalkSprite_Gfx04 ; $6d45
	dw AllieWalkSprite_Gfx05 ; $6d47
Padding_75_6:
	; $6d49, 7 bytes (fill)
	ds 7, $00
	ds ALIGN[4]
AllieWalkSprite_Gfx00:
	INCBIN "data/sprites/AllieWalkSprite_Gfx00.bin" ; $6d50, 256 bytes
	ds ALIGN[4]
AllieWalkSprite_Gfx01:
	INCBIN "data/sprites/AllieWalkSprite_Gfx01.bin" ; $6e50, 256 bytes
	ds ALIGN[4]
AllieWalkSprite_Gfx02:
	INCBIN "data/sprites/AllieWalkSprite_Gfx02.bin" ; $6f50, 256 bytes
	ds ALIGN[4]
AllieWalkSprite_Gfx03:
	INCBIN "data/sprites/AllieWalkSprite_Gfx03.bin" ; $7050, 256 bytes
	ds ALIGN[4]
AllieWalkSprite_Gfx04:
	INCBIN "data/sprites/AllieWalkSprite_Gfx04.bin" ; $7150, 256 bytes
	ds ALIGN[4]
AllieWalkSprite_Gfx05:
	INCBIN "data/sprites/AllieWalkSprite_Gfx05.bin" ; $7250, 256 bytes
AllieWalkSprite_AnimPtrs:
	dw AllieWalkSprite_AnimStill ; $7350
	dw AllieWalkSprite_AnimWalk ; $7352
	dw AllieWalkSprite_AnimBounce ; $7354
	dw AllieWalkSprite_AnimNod ; $7356
	dw AllieWalkSprite_AnimShake ; $7358
	dw AllieWalkSprite_Anim05 ; $735a
	dw AllieWalkSprite_Anim05 ; $735c
	dw AllieWalkSprite_Anim05 ; $735e
AllieWalkSprite_AnimStill:
	; $7360, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
AllieWalkSprite_AnimWalk:
	; $7363, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
AllieWalkSprite_AnimBounce:
	; $7369, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AllieWalkSprite_AnimNod:
	; $7375, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
AllieWalkSprite_AnimShake:
	; $737d, 20 bytes (sprite_anim)
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
AllieWalkSprite_Anim05:
	; $7391, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
FayWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, FayWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw FayWalkSprite_Gfx00, FayWalkSprite_Gfx01, FayWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw FayWalkSprite_Gfx03 ; $73ad
	dw FayWalkSprite_Gfx04 ; $73af
	dw FayWalkSprite_Gfx05 ; $73b1
	dw FayWalkSprite_Gfx06 ; $73b3
	dw FayWalkSprite_Gfx07 ; $73b5
	dw FayWalkSprite_Gfx08 ; $73b7
	dw FayWalkSprite_Gfx09 ; $73b9
Padding_75_7:
	; $73bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
FayWalkSprite_Gfx00:
	INCBIN "data/sprites/FayWalkSprite_Gfx00.bin" ; $73c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx01:
	INCBIN "data/sprites/FayWalkSprite_Gfx01.bin" ; $74c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx02:
	INCBIN "data/sprites/FayWalkSprite_Gfx02.bin" ; $75c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx03:
	INCBIN "data/sprites/FayWalkSprite_Gfx03.bin" ; $76c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx04:
	INCBIN "data/sprites/FayWalkSprite_Gfx04.bin" ; $77c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx05:
	INCBIN "data/sprites/FayWalkSprite_Gfx05.bin" ; $78c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx06:
	INCBIN "data/sprites/FayWalkSprite_Gfx06.bin" ; $79c0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx07:
	INCBIN "data/sprites/FayWalkSprite_Gfx07.bin" ; $7ac0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx08:
	INCBIN "data/sprites/FayWalkSprite_Gfx08.bin" ; $7bc0, 256 bytes
	ds ALIGN[4]
FayWalkSprite_Gfx09:
	INCBIN "data/sprites/FayWalkSprite_Gfx09.bin" ; $7cc0, 256 bytes
FayWalkSprite_AnimPtrs:
	dw FayWalkSprite_AnimStill ; $7dc0
	dw FayWalkSprite_AnimWalk ; $7dc2
	dw FayWalkSprite_AnimBounce ; $7dc4
	dw FayWalkSprite_AnimNod ; $7dc6
	dw FayWalkSprite_AnimShake ; $7dc8
	dw FayWalkSprite_Anim05 ; $7dca
	dw FayWalkSprite_Anim06 ; $7dcc
	dw FayWalkSprite_Anim07 ; $7dce
FayWalkSprite_AnimStill:
	; $7dd0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
FayWalkSprite_AnimWalk:
	; $7dd3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
FayWalkSprite_AnimBounce:
	; $7dd9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
FayWalkSprite_AnimNod:
	; $7de5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
FayWalkSprite_AnimShake:
	; $7ded, 20 bytes (sprite_anim)
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
FayWalkSprite_Anim05:
	; $7e01, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
FayWalkSprite_Anim06:
	; $7e09, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
FayWalkSprite_Anim07:
	; $7e0e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
	; $7e1a, 486 bytes fill to bank end (linker-padded)
