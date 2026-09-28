DataPtr_WalkSprite_74_00:
	dw WalkSprite_74_00 ; $4000
DataPtr_WalkSprite_74_01:
	dw WalkSprite_74_01 ; $4002
DataPtr_WalkSprite_74_02:
	dw WalkSprite_74_02 ; $4004
DataPtr_WalkSprite_74_03:
	dw WalkSprite_74_03 ; $4006
DataPtr_WalkSprite_74_04:
	dw WalkSprite_74_04 ; $4008
DataPtr_WalkSprite_74_05:
	dw WalkSprite_74_05 ; $400a
DataPtr_WalkSprite_74_06:
	dw WalkSprite_74_06 ; $400c
DataPtr_WalkSprite_74_07:
	dw WalkSprite_74_07 ; $400e
DataPtr_WalkSprite_74_08:
	dw WalkSprite_74_08 ; $4010
WalkSprite_74_00:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_00_Gfx00, WalkSprite_74_00_Gfx01, WalkSprite_74_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_00_Gfx03 ; $4022
	dw WalkSprite_74_00_Gfx03 ; $4024
	dw WalkSprite_74_00_Gfx03 ; $4026
	dw WalkSprite_74_00_Gfx03 ; $4028
	dw WalkSprite_74_00_Gfx04 ; $402a
	dw WalkSprite_74_00_Gfx05 ; $402c
	dw WalkSprite_74_00_Gfx06 ; $402e
	ds ALIGN[4]
WalkSprite_74_00_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx05.bin" ; $4530, 256 bytes
	ds ALIGN[4]
WalkSprite_74_00_Gfx06:
	INCBIN "data/bank_074/WalkSprite_74_00_Gfx06.bin" ; $4630, 256 bytes
WalkSprite_74_00_AnimPtrs:
	dw WalkSprite_74_00_Anim00 ; $4730
	dw WalkSprite_74_00_Anim01 ; $4732
	dw WalkSprite_74_00_Anim02 ; $4734
	dw WalkSprite_74_00_Anim03 ; $4736
	dw WalkSprite_74_00_Anim04 ; $4738
	dw WalkSprite_74_00_Anim05 ; $473a
	dw WalkSprite_74_00_Anim06 ; $473c
	dw WalkSprite_74_00_Anim06 ; $473e
WalkSprite_74_00_Anim00:
	; $4740, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_00_Anim01:
	; $4743, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_00_Anim02:
	; $4749, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_00_Anim03:
	; $4755, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_00_Anim04:
	; $475d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_00_Anim05:
	; $4771, 8 bytes (sprite_anim)
	anim_frame $00, $14
	anim_frame $02, $0a
	anim_frame $01, $1e
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
WalkSprite_74_00_Anim06:
	; $4779, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_01:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_01_Gfx00, WalkSprite_74_01_Gfx01, WalkSprite_74_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_01_Gfx02 ; $4795
	dw WalkSprite_74_01_Gfx02 ; $4797
	dw WalkSprite_74_01_Gfx02 ; $4799
	dw WalkSprite_74_01_Gfx02 ; $479b
	dw WalkSprite_74_01_Gfx03 ; $479d
	dw WalkSprite_74_01_Gfx04 ; $479f
	dw WalkSprite_74_01_Gfx05 ; $47a1
Padding_74_0:
	; $47a3, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
WalkSprite_74_01_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx00.bin" ; $47b0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_01_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx01.bin" ; $48b0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_01_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx02.bin" ; $49b0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_01_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx03.bin" ; $4ab0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_01_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx04.bin" ; $4bb0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_01_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_01_Gfx05.bin" ; $4cb0, 256 bytes
WalkSprite_74_01_AnimPtrs:
	dw WalkSprite_74_01_Anim00 ; $4db0
	dw WalkSprite_74_01_Anim01 ; $4db2
	dw WalkSprite_74_01_Anim02 ; $4db4
	dw WalkSprite_74_01_Anim03 ; $4db6
	dw WalkSprite_74_01_Anim04 ; $4db8
	dw WalkSprite_74_01_Anim05 ; $4dba
	dw WalkSprite_74_01_Anim05 ; $4dbc
	dw WalkSprite_74_01_Anim05 ; $4dbe
WalkSprite_74_01_Anim00:
	; $4dc0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_01_Anim01:
	; $4dc3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_01_Anim02:
	; $4dc9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_01_Anim03:
	; $4dd5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_01_Anim04:
	; $4ddd, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_01_Anim05:
	; $4df1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_02:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_02_Gfx00, WalkSprite_74_02_Gfx01, WalkSprite_74_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_02_Gfx02 ; $4e0d
	dw WalkSprite_74_02_Gfx02 ; $4e0f
	dw WalkSprite_74_02_Gfx02 ; $4e11
	dw WalkSprite_74_02_Gfx02 ; $4e13
	dw WalkSprite_74_02_Gfx03 ; $4e15
	dw WalkSprite_74_02_Gfx04 ; $4e17
	dw WalkSprite_74_02_Gfx05 ; $4e19
Padding_74_1:
	; $4e1b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_02_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx00.bin" ; $4e20, 256 bytes
	ds ALIGN[4]
WalkSprite_74_02_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx01.bin" ; $4f20, 256 bytes
	ds ALIGN[4]
WalkSprite_74_02_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx02.bin" ; $5020, 256 bytes
	ds ALIGN[4]
WalkSprite_74_02_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx03.bin" ; $5120, 256 bytes
	ds ALIGN[4]
WalkSprite_74_02_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx04.bin" ; $5220, 256 bytes
	ds ALIGN[4]
WalkSprite_74_02_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_02_Gfx05.bin" ; $5320, 256 bytes
WalkSprite_74_02_AnimPtrs:
	dw WalkSprite_74_02_Anim00 ; $5420
	dw WalkSprite_74_02_Anim01 ; $5422
	dw WalkSprite_74_02_Anim02 ; $5424
	dw WalkSprite_74_02_Anim03 ; $5426
	dw WalkSprite_74_02_Anim04 ; $5428
	dw WalkSprite_74_02_Anim05 ; $542a
	dw WalkSprite_74_02_Anim05 ; $542c
	dw WalkSprite_74_02_Anim05 ; $542e
WalkSprite_74_02_Anim00:
	; $5430, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_02_Anim01:
	; $5433, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_02_Anim02:
	; $5439, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_02_Anim03:
	; $5445, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_02_Anim04:
	; $544d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_02_Anim05:
	; $5461, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_03:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_03_Gfx00, WalkSprite_74_03_Gfx01, WalkSprite_74_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_03_Gfx02 ; $547d
	dw WalkSprite_74_03_Gfx02 ; $547f
	dw WalkSprite_74_03_Gfx02 ; $5481
	dw WalkSprite_74_03_Gfx02 ; $5483
	dw WalkSprite_74_03_Gfx03 ; $5485
	dw WalkSprite_74_03_Gfx04 ; $5487
	dw WalkSprite_74_03_Gfx05 ; $5489
Padding_74_2:
	; $548b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_03_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx00.bin" ; $5490, 256 bytes
	ds ALIGN[4]
WalkSprite_74_03_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx01.bin" ; $5590, 256 bytes
	ds ALIGN[4]
WalkSprite_74_03_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx02.bin" ; $5690, 256 bytes
	ds ALIGN[4]
WalkSprite_74_03_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx03.bin" ; $5790, 256 bytes
	ds ALIGN[4]
WalkSprite_74_03_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx04.bin" ; $5890, 256 bytes
	ds ALIGN[4]
WalkSprite_74_03_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_03_Gfx05.bin" ; $5990, 256 bytes
WalkSprite_74_03_AnimPtrs:
	dw WalkSprite_74_03_Anim00 ; $5a90
	dw WalkSprite_74_03_Anim01 ; $5a92
	dw WalkSprite_74_03_Anim02 ; $5a94
	dw WalkSprite_74_03_Anim03 ; $5a96
	dw WalkSprite_74_03_Anim04 ; $5a98
	dw WalkSprite_74_03_Anim05 ; $5a9a
	dw WalkSprite_74_03_Anim05 ; $5a9c
	dw WalkSprite_74_03_Anim05 ; $5a9e
WalkSprite_74_03_Anim00:
	; $5aa0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_03_Anim01:
	; $5aa3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_03_Anim02:
	; $5aa9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_03_Anim03:
	; $5ab5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_03_Anim04:
	; $5abd, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_03_Anim05:
	; $5ad1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_04:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_04_Gfx00, WalkSprite_74_04_Gfx01, WalkSprite_74_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_04_Gfx02 ; $5aed
	dw WalkSprite_74_04_Gfx02 ; $5aef
	dw WalkSprite_74_04_Gfx02 ; $5af1
	dw WalkSprite_74_04_Gfx02 ; $5af3
	dw WalkSprite_74_04_Gfx03 ; $5af5
	dw WalkSprite_74_04_Gfx04 ; $5af7
	dw WalkSprite_74_04_Gfx05 ; $5af9
Padding_74_3:
	; $5afb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_04_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx00.bin" ; $5b00, 256 bytes
	ds ALIGN[4]
WalkSprite_74_04_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx01.bin" ; $5c00, 256 bytes
	ds ALIGN[4]
WalkSprite_74_04_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx02.bin" ; $5d00, 256 bytes
	ds ALIGN[4]
WalkSprite_74_04_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx03.bin" ; $5e00, 256 bytes
	ds ALIGN[4]
WalkSprite_74_04_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx04.bin" ; $5f00, 256 bytes
	ds ALIGN[4]
WalkSprite_74_04_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_04_Gfx05.bin" ; $6000, 256 bytes
WalkSprite_74_04_AnimPtrs:
	dw WalkSprite_74_04_Anim00 ; $6100
	dw WalkSprite_74_04_Anim01 ; $6102
	dw WalkSprite_74_04_Anim02 ; $6104
	dw WalkSprite_74_04_Anim03 ; $6106
	dw WalkSprite_74_04_Anim04 ; $6108
	dw WalkSprite_74_04_Anim05 ; $610a
	dw WalkSprite_74_04_Anim05 ; $610c
	dw WalkSprite_74_04_Anim05 ; $610e
WalkSprite_74_04_Anim00:
	; $6110, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_04_Anim01:
	; $6113, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_04_Anim02:
	; $6119, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_04_Anim03:
	; $6125, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_04_Anim04:
	; $612d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_04_Anim05:
	; $6141, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_05:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_05_Gfx00, WalkSprite_74_05_Gfx01, WalkSprite_74_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_05_Gfx02 ; $615d
	dw WalkSprite_74_05_Gfx02 ; $615f
	dw WalkSprite_74_05_Gfx02 ; $6161
	dw WalkSprite_74_05_Gfx02 ; $6163
	dw WalkSprite_74_05_Gfx03 ; $6165
	dw WalkSprite_74_05_Gfx04 ; $6167
	dw WalkSprite_74_05_Gfx05 ; $6169
Padding_74_4:
	; $616b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_05_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx00.bin" ; $6170, 256 bytes
	ds ALIGN[4]
WalkSprite_74_05_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx01.bin" ; $6270, 256 bytes
	ds ALIGN[4]
WalkSprite_74_05_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx02.bin" ; $6370, 256 bytes
	ds ALIGN[4]
WalkSprite_74_05_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx03.bin" ; $6470, 256 bytes
	ds ALIGN[4]
WalkSprite_74_05_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx04.bin" ; $6570, 256 bytes
	ds ALIGN[4]
WalkSprite_74_05_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_05_Gfx05.bin" ; $6670, 256 bytes
WalkSprite_74_05_AnimPtrs:
	dw WalkSprite_74_05_Anim00 ; $6770
	dw WalkSprite_74_05_Anim01 ; $6772
	dw WalkSprite_74_05_Anim02 ; $6774
	dw WalkSprite_74_05_Anim03 ; $6776
	dw WalkSprite_74_05_Anim04 ; $6778
	dw WalkSprite_74_05_Anim05 ; $677a
	dw WalkSprite_74_05_Anim05 ; $677c
	dw WalkSprite_74_05_Anim05 ; $677e
WalkSprite_74_05_Anim00:
	; $6780, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_05_Anim01:
	; $6783, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_05_Anim02:
	; $6789, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_05_Anim03:
	; $6795, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_05_Anim04:
	; $679d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_05_Anim05:
	; $67b1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_06:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_06_Gfx00, WalkSprite_74_06_Gfx01, WalkSprite_74_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_06_Gfx02 ; $67cd
	dw WalkSprite_74_06_Gfx02 ; $67cf
	dw WalkSprite_74_06_Gfx02 ; $67d1
	dw WalkSprite_74_06_Gfx02 ; $67d3
	dw WalkSprite_74_06_Gfx03 ; $67d5
	dw WalkSprite_74_06_Gfx04 ; $67d7
	dw WalkSprite_74_06_Gfx05 ; $67d9
Padding_74_5:
	; $67db, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_06_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx00.bin" ; $67e0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_06_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx01.bin" ; $68e0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_06_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx02.bin" ; $69e0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_06_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx03.bin" ; $6ae0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_06_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx04.bin" ; $6be0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_06_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_06_Gfx05.bin" ; $6ce0, 256 bytes
WalkSprite_74_06_AnimPtrs:
	dw WalkSprite_74_06_Anim00 ; $6de0
	dw WalkSprite_74_06_Anim01 ; $6de2
	dw WalkSprite_74_06_Anim02 ; $6de4
	dw WalkSprite_74_06_Anim03 ; $6de6
	dw WalkSprite_74_06_Anim04 ; $6de8
	dw WalkSprite_74_06_Anim05 ; $6dea
	dw WalkSprite_74_06_Anim05 ; $6dec
	dw WalkSprite_74_06_Anim05 ; $6dee
WalkSprite_74_06_Anim00:
	; $6df0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_06_Anim01:
	; $6df3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_06_Anim02:
	; $6df9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_06_Anim03:
	; $6e05, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_06_Anim04:
	; $6e0d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_06_Anim05:
	; $6e21, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_07:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_07_Gfx00, WalkSprite_74_07_Gfx01, WalkSprite_74_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_07_Gfx02 ; $6e3d
	dw WalkSprite_74_07_Gfx02 ; $6e3f
	dw WalkSprite_74_07_Gfx02 ; $6e41
	dw WalkSprite_74_07_Gfx02 ; $6e43
	dw WalkSprite_74_07_Gfx03 ; $6e45
	dw WalkSprite_74_07_Gfx04 ; $6e47
	dw WalkSprite_74_07_Gfx05 ; $6e49
Padding_74_6:
	; $6e4b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_07_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx00.bin" ; $6e50, 256 bytes
	ds ALIGN[4]
WalkSprite_74_07_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx01.bin" ; $6f50, 256 bytes
	ds ALIGN[4]
WalkSprite_74_07_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx02.bin" ; $7050, 256 bytes
	ds ALIGN[4]
WalkSprite_74_07_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx03.bin" ; $7150, 256 bytes
	ds ALIGN[4]
WalkSprite_74_07_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx04.bin" ; $7250, 256 bytes
	ds ALIGN[4]
WalkSprite_74_07_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_07_Gfx05.bin" ; $7350, 256 bytes
WalkSprite_74_07_AnimPtrs:
	dw WalkSprite_74_07_Anim00 ; $7450
	dw WalkSprite_74_07_Anim01 ; $7452
	dw WalkSprite_74_07_Anim02 ; $7454
	dw WalkSprite_74_07_Anim03 ; $7456
	dw WalkSprite_74_07_Anim04 ; $7458
	dw WalkSprite_74_07_Anim05 ; $745a
	dw WalkSprite_74_07_Anim05 ; $745c
	dw WalkSprite_74_07_Anim05 ; $745e
WalkSprite_74_07_Anim00:
	; $7460, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_07_Anim01:
	; $7463, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_07_Anim02:
	; $7469, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_07_Anim03:
	; $7475, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_07_Anim04:
	; $747d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_07_Anim05:
	; $7491, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_08:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_74_08_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_74_08_Gfx00, WalkSprite_74_08_Gfx01, WalkSprite_74_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_74_08_Gfx02 ; $74ad
	dw WalkSprite_74_08_Gfx02 ; $74af
	dw WalkSprite_74_08_Gfx02 ; $74b1
	dw WalkSprite_74_08_Gfx02 ; $74b3
	dw WalkSprite_74_08_Gfx03 ; $74b5
	dw WalkSprite_74_08_Gfx04 ; $74b7
	dw WalkSprite_74_08_Gfx05 ; $74b9
Padding_74_7:
	; $74bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_74_08_Gfx00:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx00.bin" ; $74c0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_08_Gfx01:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx01.bin" ; $75c0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_08_Gfx02:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx02.bin" ; $76c0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_08_Gfx03:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx03.bin" ; $77c0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_08_Gfx04:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx04.bin" ; $78c0, 256 bytes
	ds ALIGN[4]
WalkSprite_74_08_Gfx05:
	INCBIN "data/bank_074/WalkSprite_74_08_Gfx05.bin" ; $79c0, 256 bytes
WalkSprite_74_08_AnimPtrs:
	dw WalkSprite_74_08_Anim00 ; $7ac0
	dw WalkSprite_74_08_Anim01 ; $7ac2
	dw WalkSprite_74_08_Anim02 ; $7ac4
	dw WalkSprite_74_08_Anim03 ; $7ac6
	dw WalkSprite_74_08_Anim04 ; $7ac8
	dw WalkSprite_74_08_Anim05 ; $7aca
	dw WalkSprite_74_08_Anim05 ; $7acc
	dw WalkSprite_74_08_Anim05 ; $7ace
WalkSprite_74_08_Anim00:
	; $7ad0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_74_08_Anim01:
	; $7ad3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_74_08_Anim02:
	; $7ad9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_08_Anim03:
	; $7ae5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_08_Anim04:
	; $7aed, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set ANIM_WALK
WalkSprite_74_08_Anim05:
	; $7b01, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set ANIM_WALK
	; $7b0d, 1267 bytes fill to bank end (linker-padded)
