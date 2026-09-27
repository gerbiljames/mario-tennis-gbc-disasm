DataPtr_WalkSprite_72_00:
	dw WalkSprite_72_00 ; $4000
DataPtr_WalkSprite_72_01:
	dw WalkSprite_72_01 ; $4002
DataPtr_WalkSprite_72_02:
	dw WalkSprite_72_02 ; $4004
DataPtr_WalkSprite_72_03:
	dw WalkSprite_72_03 ; $4006
DataPtr_WalkSprite_72_04:
	dw WalkSprite_72_04 ; $4008
DataPtr_WalkSprite_72_05:
	dw WalkSprite_72_05 ; $400a
DataPtr_WalkSprite_72_06:
	dw WalkSprite_72_06 ; $400c
DataPtr_WalkSprite_72_07:
	dw WalkSprite_72_07 ; $400e
DataPtr_WalkSprite_72_08:
	dw WalkSprite_72_08 ; $4010
WalkSprite_72_00:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_00_Gfx00, WalkSprite_72_00_Gfx01, WalkSprite_72_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_00_Gfx02 ; $4022
	dw WalkSprite_72_00_Gfx02 ; $4024
	dw WalkSprite_72_00_Gfx02 ; $4026
	dw WalkSprite_72_00_Gfx02 ; $4028
	dw WalkSprite_72_00_Gfx03 ; $402a
	dw WalkSprite_72_00_Gfx04 ; $402c
	dw WalkSprite_72_00_Gfx05 ; $402e
	ds ALIGN[4]
WalkSprite_72_00_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
WalkSprite_72_00_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
WalkSprite_72_00_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
WalkSprite_72_00_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
WalkSprite_72_00_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
WalkSprite_72_00_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_00_Gfx05.bin" ; $4530, 256 bytes
WalkSprite_72_00_AnimPtrs:
	dw WalkSprite_72_00_Anim00 ; $4630
	dw WalkSprite_72_00_Anim01 ; $4632
	dw WalkSprite_72_00_Anim02 ; $4634
	dw WalkSprite_72_00_Anim03 ; $4636
	dw WalkSprite_72_00_Anim04 ; $4638
	dw WalkSprite_72_00_Anim05 ; $463a
	dw WalkSprite_72_00_Anim05 ; $463c
	dw WalkSprite_72_00_Anim05 ; $463e
WalkSprite_72_00_Anim00:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_00_Anim01:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_00_Anim02:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_00_Anim03:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_00_Anim04:
	; $465d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_00_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_01:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_01_Gfx00, WalkSprite_72_01_Gfx01, WalkSprite_72_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_01_Gfx02 ; $468d
	dw WalkSprite_72_01_Gfx02 ; $468f
	dw WalkSprite_72_01_Gfx02 ; $4691
	dw WalkSprite_72_01_Gfx02 ; $4693
	dw WalkSprite_72_01_Gfx03 ; $4695
	dw WalkSprite_72_01_Gfx04 ; $4697
	dw WalkSprite_72_01_Gfx05 ; $4699
Padding_72_0:
	; $469b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_01_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx00.bin" ; $46a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx01.bin" ; $47a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx02.bin" ; $48a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx03.bin" ; $49a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx04.bin" ; $4aa0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_01_Gfx05.bin" ; $4ba0, 256 bytes
WalkSprite_72_01_AnimPtrs:
	dw WalkSprite_72_01_Anim00 ; $4ca0
	dw WalkSprite_72_01_Anim01 ; $4ca2
	dw WalkSprite_72_01_Anim02 ; $4ca4
	dw WalkSprite_72_01_Anim03 ; $4ca6
	dw WalkSprite_72_01_Anim04 ; $4ca8
	dw WalkSprite_72_01_Anim05 ; $4caa
	dw WalkSprite_72_01_Anim05 ; $4cac
	dw WalkSprite_72_01_Anim05 ; $4cae
WalkSprite_72_01_Anim00:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_01_Anim01:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_01_Anim02:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_01_Anim03:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_01_Anim04:
	; $4ccd, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_01_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_02:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_02_Gfx00, WalkSprite_72_02_Gfx01, WalkSprite_72_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_02_Gfx03 ; $4cfd
	dw WalkSprite_72_02_Gfx04 ; $4cff
	dw WalkSprite_72_02_Gfx05 ; $4d01
	dw WalkSprite_72_02_Gfx05 ; $4d03
	dw WalkSprite_72_02_Gfx06 ; $4d05
	dw WalkSprite_72_02_Gfx07 ; $4d07
	dw WalkSprite_72_02_Gfx08 ; $4d09
Padding_72_1:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_02_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx00.bin" ; $4d10, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx01.bin" ; $4e10, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx02.bin" ; $4f10, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx03.bin" ; $5010, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx04.bin" ; $5110, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx05.bin" ; $5210, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx06:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx06.bin" ; $5310, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx07:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx07.bin" ; $5410, 256 bytes
	ds ALIGN[4]
WalkSprite_72_02_Gfx08:
	INCBIN "data/bank_072/WalkSprite_72_02_Gfx08.bin" ; $5510, 256 bytes
WalkSprite_72_02_AnimPtrs:
	dw WalkSprite_72_02_Anim00 ; $5610
	dw WalkSprite_72_02_Anim01 ; $5612
	dw WalkSprite_72_02_Anim02 ; $5614
	dw WalkSprite_72_02_Anim03 ; $5616
	dw WalkSprite_72_02_Anim04 ; $5618
	dw WalkSprite_72_02_Anim05 ; $561a
	dw WalkSprite_72_02_Anim06 ; $561c
	dw WalkSprite_72_02_Anim07 ; $561e
WalkSprite_72_02_Anim00:
	; $5620, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_02_Anim01:
	; $5623, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_02_Anim02:
	; $5629, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_02_Anim03:
	; $5635, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_02_Anim04:
	; $563d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_02_Anim05:
	; $5651, 8 bytes (sprite_anim)
	anim_frame $00, $14
	anim_frame $02, $0a
	anim_frame $01, $1e
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
WalkSprite_72_02_Anim06:
	; $5659, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_72_02_Anim07:
	; $565e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_03:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_03_Gfx00, WalkSprite_72_03_Gfx01, WalkSprite_72_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_03_Gfx02 ; $567a
	dw WalkSprite_72_03_Gfx02 ; $567c
	dw WalkSprite_72_03_Gfx02 ; $567e
	dw WalkSprite_72_03_Gfx02 ; $5680
	dw WalkSprite_72_03_Gfx03 ; $5682
	dw WalkSprite_72_03_Gfx04 ; $5684
	dw WalkSprite_72_03_Gfx05 ; $5686
Padding_72_2:
	; $5688, 8 bytes (fill)
	ds 8, $00
	ds ALIGN[4]
WalkSprite_72_03_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx00.bin" ; $5690, 256 bytes
	ds ALIGN[4]
WalkSprite_72_03_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx01.bin" ; $5790, 256 bytes
	ds ALIGN[4]
WalkSprite_72_03_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx02.bin" ; $5890, 256 bytes
	ds ALIGN[4]
WalkSprite_72_03_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx03.bin" ; $5990, 256 bytes
	ds ALIGN[4]
WalkSprite_72_03_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx04.bin" ; $5a90, 256 bytes
	ds ALIGN[4]
WalkSprite_72_03_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_03_Gfx05.bin" ; $5b90, 256 bytes
WalkSprite_72_03_AnimPtrs:
	dw WalkSprite_72_03_Anim00 ; $5c90
	dw WalkSprite_72_03_Anim01 ; $5c92
	dw WalkSprite_72_03_Anim02 ; $5c94
	dw WalkSprite_72_03_Anim03 ; $5c96
	dw WalkSprite_72_03_Anim04 ; $5c98
	dw WalkSprite_72_03_Anim05 ; $5c9a
	dw WalkSprite_72_03_Anim05 ; $5c9c
	dw WalkSprite_72_03_Anim05 ; $5c9e
WalkSprite_72_03_Anim00:
	; $5ca0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_03_Anim01:
	; $5ca3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_03_Anim02:
	; $5ca9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_03_Anim03:
	; $5cb5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_03_Anim04:
	; $5cbd, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_03_Anim05:
	; $5cd1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_04:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_04_Gfx00, WalkSprite_72_04_Gfx01, WalkSprite_72_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_04_Gfx02 ; $5ced
	dw WalkSprite_72_04_Gfx02 ; $5cef
	dw WalkSprite_72_04_Gfx02 ; $5cf1
	dw WalkSprite_72_04_Gfx02 ; $5cf3
	dw WalkSprite_72_04_Gfx03 ; $5cf5
	dw WalkSprite_72_04_Gfx04 ; $5cf7
	dw WalkSprite_72_04_Gfx05 ; $5cf9
Padding_72_3:
	; $5cfb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_04_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx00.bin" ; $5d00, 256 bytes
	ds ALIGN[4]
WalkSprite_72_04_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx01.bin" ; $5e00, 256 bytes
	ds ALIGN[4]
WalkSprite_72_04_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx02.bin" ; $5f00, 256 bytes
	ds ALIGN[4]
WalkSprite_72_04_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx03.bin" ; $6000, 256 bytes
	ds ALIGN[4]
WalkSprite_72_04_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx04.bin" ; $6100, 256 bytes
	ds ALIGN[4]
WalkSprite_72_04_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_04_Gfx05.bin" ; $6200, 256 bytes
WalkSprite_72_04_AnimPtrs:
	dw WalkSprite_72_04_Anim00 ; $6300
	dw WalkSprite_72_04_Anim01 ; $6302
	dw WalkSprite_72_04_Anim02 ; $6304
	dw WalkSprite_72_04_Anim03 ; $6306
	dw WalkSprite_72_04_Anim04 ; $6308
	dw WalkSprite_72_04_Anim05 ; $630a
	dw WalkSprite_72_04_Anim05 ; $630c
	dw WalkSprite_72_04_Anim05 ; $630e
WalkSprite_72_04_Anim00:
	; $6310, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_04_Anim01:
	; $6313, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_04_Anim02:
	; $6319, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_04_Anim03:
	; $6325, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_04_Anim04:
	; $632d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_04_Anim05:
	; $6341, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_05:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_05_Gfx00, WalkSprite_72_05_Gfx01, WalkSprite_72_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_05_Gfx02 ; $635d
	dw WalkSprite_72_05_Gfx02 ; $635f
	dw WalkSprite_72_05_Gfx02 ; $6361
	dw WalkSprite_72_05_Gfx02 ; $6363
	dw WalkSprite_72_05_Gfx03 ; $6365
	dw WalkSprite_72_05_Gfx04 ; $6367
	dw WalkSprite_72_05_Gfx05 ; $6369
Padding_72_4:
	; $636b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_05_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx00.bin" ; $6370, 256 bytes
	ds ALIGN[4]
WalkSprite_72_05_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx01.bin" ; $6470, 256 bytes
	ds ALIGN[4]
WalkSprite_72_05_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx02.bin" ; $6570, 256 bytes
	ds ALIGN[4]
WalkSprite_72_05_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx03.bin" ; $6670, 256 bytes
	ds ALIGN[4]
WalkSprite_72_05_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx04.bin" ; $6770, 256 bytes
	ds ALIGN[4]
WalkSprite_72_05_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_05_Gfx05.bin" ; $6870, 256 bytes
WalkSprite_72_05_AnimPtrs:
	dw WalkSprite_72_05_Anim00 ; $6970
	dw WalkSprite_72_05_Anim01 ; $6972
	dw WalkSprite_72_05_Anim02 ; $6974
	dw WalkSprite_72_05_Anim03 ; $6976
	dw WalkSprite_72_05_Anim04 ; $6978
	dw WalkSprite_72_05_Anim05 ; $697a
	dw WalkSprite_72_05_Anim05 ; $697c
	dw WalkSprite_72_05_Anim05 ; $697e
WalkSprite_72_05_Anim00:
	; $6980, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_05_Anim01:
	; $6983, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_05_Anim02:
	; $6989, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_05_Anim03:
	; $6995, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_05_Anim04:
	; $699d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_05_Anim05:
	; $69b1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_06:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_06_Gfx00, WalkSprite_72_06_Gfx01, WalkSprite_72_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_06_Gfx02 ; $69cd
	dw WalkSprite_72_06_Gfx02 ; $69cf
	dw WalkSprite_72_06_Gfx02 ; $69d1
	dw WalkSprite_72_06_Gfx02 ; $69d3
	dw WalkSprite_72_06_Gfx03 ; $69d5
	dw WalkSprite_72_06_Gfx04 ; $69d7
	dw WalkSprite_72_06_Gfx05 ; $69d9
Padding_72_5:
	; $69db, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_06_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx00.bin" ; $69e0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_06_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx01.bin" ; $6ae0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_06_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx02.bin" ; $6be0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_06_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx03.bin" ; $6ce0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_06_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx04.bin" ; $6de0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_06_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_06_Gfx05.bin" ; $6ee0, 256 bytes
WalkSprite_72_06_AnimPtrs:
	dw WalkSprite_72_06_Anim00 ; $6fe0
	dw WalkSprite_72_06_Anim01 ; $6fe2
	dw WalkSprite_72_06_Anim02 ; $6fe4
	dw WalkSprite_72_06_Anim03 ; $6fe6
	dw WalkSprite_72_06_Anim04 ; $6fe8
	dw WalkSprite_72_06_Anim05 ; $6fea
	dw WalkSprite_72_06_Anim05 ; $6fec
	dw WalkSprite_72_06_Anim05 ; $6fee
WalkSprite_72_06_Anim00:
	; $6ff0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_06_Anim01:
	; $6ff3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_06_Anim02:
	; $6ff9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_06_Anim03:
	; $7005, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_06_Anim04:
	; $700d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_06_Anim05:
	; $7021, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_07:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_07_Gfx00, WalkSprite_72_07_Gfx01, WalkSprite_72_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_07_Gfx02 ; $703d
	dw WalkSprite_72_07_Gfx02 ; $703f
	dw WalkSprite_72_07_Gfx02 ; $7041
	dw WalkSprite_72_07_Gfx02 ; $7043
	dw WalkSprite_72_07_Gfx03 ; $7045
	dw WalkSprite_72_07_Gfx04 ; $7047
	dw WalkSprite_72_07_Gfx05 ; $7049
Padding_72_6:
	; $704b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_07_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx00.bin" ; $7050, 256 bytes
	ds ALIGN[4]
WalkSprite_72_07_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx01.bin" ; $7150, 256 bytes
	ds ALIGN[4]
WalkSprite_72_07_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx02.bin" ; $7250, 256 bytes
	ds ALIGN[4]
WalkSprite_72_07_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx03.bin" ; $7350, 256 bytes
	ds ALIGN[4]
WalkSprite_72_07_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx04.bin" ; $7450, 256 bytes
	ds ALIGN[4]
WalkSprite_72_07_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_07_Gfx05.bin" ; $7550, 256 bytes
WalkSprite_72_07_AnimPtrs:
	dw WalkSprite_72_07_Anim00 ; $7650
	dw WalkSprite_72_07_Anim01 ; $7652
	dw WalkSprite_72_07_Anim02 ; $7654
	dw WalkSprite_72_07_Anim03 ; $7656
	dw WalkSprite_72_07_Anim04 ; $7658
	dw WalkSprite_72_07_Anim05 ; $765a
	dw WalkSprite_72_07_Anim05 ; $765c
	dw WalkSprite_72_07_Anim05 ; $765e
WalkSprite_72_07_Anim00:
	; $7660, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_07_Anim01:
	; $7663, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_07_Anim02:
	; $7669, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_07_Anim03:
	; $7675, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_07_Anim04:
	; $767d, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_07_Anim05:
	; $7691, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_08:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_72_08_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_72_08_Gfx00, WalkSprite_72_08_Gfx01, WalkSprite_72_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_72_08_Gfx02 ; $76ad
	dw WalkSprite_72_08_Gfx02 ; $76af
	dw WalkSprite_72_08_Gfx02 ; $76b1
	dw WalkSprite_72_08_Gfx02 ; $76b3
	dw WalkSprite_72_08_Gfx03 ; $76b5
	dw WalkSprite_72_08_Gfx04 ; $76b7
	dw WalkSprite_72_08_Gfx05 ; $76b9
Padding_72_7:
	; $76bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WalkSprite_72_08_Gfx00:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx00.bin" ; $76c0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_08_Gfx01:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx01.bin" ; $77c0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_08_Gfx02:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx02.bin" ; $78c0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_08_Gfx03:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx03.bin" ; $79c0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_08_Gfx04:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx04.bin" ; $7ac0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_08_Gfx05:
	INCBIN "data/bank_072/WalkSprite_72_08_Gfx05.bin" ; $7bc0, 256 bytes
WalkSprite_72_08_AnimPtrs:
	dw WalkSprite_72_08_Anim00 ; $7cc0
	dw WalkSprite_72_08_Anim01 ; $7cc2
	dw WalkSprite_72_08_Anim02 ; $7cc4
	dw WalkSprite_72_08_Anim03 ; $7cc6
	dw WalkSprite_72_08_Anim04 ; $7cc8
	dw WalkSprite_72_08_Anim05 ; $7cca
	dw WalkSprite_72_08_Anim05 ; $7ccc
	dw WalkSprite_72_08_Anim05 ; $7cce
WalkSprite_72_08_Anim00:
	; $7cd0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_72_08_Anim01:
	; $7cd3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_72_08_Anim02:
	; $7cd9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_08_Anim03:
	; $7ce5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_08_Anim04:
	; $7ced, 20 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $03
	anim_frame $07, $0a
	anim_frame $00, $03
	anim_frame $08, $0a
	anim_frame $00, $0a
	anim_set $01
WalkSprite_72_08_Anim05:
	; $7d01, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
	; $7d0d, 755 bytes fill to bank end (linker-padded)
