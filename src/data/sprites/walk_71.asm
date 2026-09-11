DataPtr_WalkSprite_71_00:
	dw WalkSprite_71_00 ; $4000
DataPtr_WalkSprite_71_01:
	dw WalkSprite_71_01 ; $4002
DataPtr_WalkSprite_71_02:
	dw WalkSprite_71_02 ; $4004
DataPtr_WalkSprite_71_03:
	dw WalkSprite_71_03 ; $4006
DataPtr_WalkSprite_71_04:
	dw WalkSprite_71_04 ; $4008
DataPtr_WalkSprite_71_05:
	dw WalkSprite_71_05 ; $400a
DataPtr_WalkSprite_71_06:
	dw WalkSprite_71_06 ; $400c
DataPtr_WalkSprite_71_07:
	dw WalkSprite_71_07 ; $400e
DataPtr_WalkSprite_71_08:
	dw WalkSprite_71_08 ; $4010
DataPtr_WalkSprite_71_09:
	dw WalkSprite_71_09 ; $4012
WalkSprite_71_00:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_00_Gfx00, WalkSprite_71_00_Gfx01, WalkSprite_71_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_00_Gfx02 ; $4024
	dw WalkSprite_71_00_Gfx02 ; $4026
	dw WalkSprite_71_00_Gfx02 ; $4028
	dw WalkSprite_71_00_Gfx02 ; $402a
	dw WalkSprite_71_00_Gfx03 ; $402c
	dw WalkSprite_71_00_Gfx04 ; $402e
	dw WalkSprite_71_00_Gfx05 ; $4030
Padding_71_00:
	; $4032, 14 bytes (fill)
	ds 14, $00
WalkSprite_71_00_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx00.bin" ; $4040, 256 bytes
WalkSprite_71_00_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx01.bin" ; $4140, 256 bytes
WalkSprite_71_00_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx02.bin" ; $4240, 256 bytes
WalkSprite_71_00_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx03.bin" ; $4340, 256 bytes
WalkSprite_71_00_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx04.bin" ; $4440, 256 bytes
WalkSprite_71_00_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_00_Gfx05.bin" ; $4540, 256 bytes
WalkSprite_71_00_AnimPtrs:
	dw WalkSprite_71_00_Anim00 ; $4640
	dw WalkSprite_71_00_Anim01 ; $4642
	dw WalkSprite_71_00_Anim02 ; $4644
	dw WalkSprite_71_00_Anim03 ; $4646
	dw WalkSprite_71_00_Anim04 ; $4648
	dw WalkSprite_71_00_Anim05 ; $464a
	dw WalkSprite_71_00_Anim05 ; $464c
	dw WalkSprite_71_00_Anim05 ; $464e
WalkSprite_71_00_Anim00:
	; $4650, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_00_Anim01:
	; $4653, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_00_Anim02:
	; $4659, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_00_Anim03:
	; $4665, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_00_Anim04:
	; $466d, 20 bytes (sprite_anim)
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
WalkSprite_71_00_Anim05:
	; $4681, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_01:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_01_Gfx00, WalkSprite_71_01_Gfx01, WalkSprite_71_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_01_Gfx02 ; $469d
	dw WalkSprite_71_01_Gfx02 ; $469f
	dw WalkSprite_71_01_Gfx02 ; $46a1
	dw WalkSprite_71_01_Gfx02 ; $46a3
	dw WalkSprite_71_01_Gfx03 ; $46a5
	dw WalkSprite_71_01_Gfx04 ; $46a7
	dw WalkSprite_71_01_Gfx05 ; $46a9
Padding_71_01:
	; $46ab, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_01_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx00.bin" ; $46b0, 256 bytes
WalkSprite_71_01_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx01.bin" ; $47b0, 256 bytes
WalkSprite_71_01_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx02.bin" ; $48b0, 256 bytes
WalkSprite_71_01_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx03.bin" ; $49b0, 256 bytes
WalkSprite_71_01_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx04.bin" ; $4ab0, 256 bytes
WalkSprite_71_01_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_01_Gfx05.bin" ; $4bb0, 256 bytes
WalkSprite_71_01_AnimPtrs:
	dw WalkSprite_71_01_Anim00 ; $4cb0
	dw WalkSprite_71_01_Anim01 ; $4cb2
	dw WalkSprite_71_01_Anim02 ; $4cb4
	dw WalkSprite_71_01_Anim03 ; $4cb6
	dw WalkSprite_71_01_Anim04 ; $4cb8
	dw WalkSprite_71_01_Anim05 ; $4cba
	dw WalkSprite_71_01_Anim05 ; $4cbc
	dw WalkSprite_71_01_Anim05 ; $4cbe
WalkSprite_71_01_Anim00:
	; $4cc0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_01_Anim01:
	; $4cc3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_01_Anim02:
	; $4cc9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_01_Anim03:
	; $4cd5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_01_Anim04:
	; $4cdd, 20 bytes (sprite_anim)
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
WalkSprite_71_01_Anim05:
	; $4cf1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_02:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_02_Gfx00, WalkSprite_71_02_Gfx01, WalkSprite_71_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_02_Gfx02 ; $4d0d
	dw WalkSprite_71_02_Gfx02 ; $4d0f
	dw WalkSprite_71_02_Gfx02 ; $4d11
	dw WalkSprite_71_02_Gfx02 ; $4d13
	dw WalkSprite_71_02_Gfx03 ; $4d15
	dw WalkSprite_71_02_Gfx04 ; $4d17
	dw WalkSprite_71_02_Gfx05 ; $4d19
Padding_71_02:
	; $4d1b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_02_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx00.bin" ; $4d20, 256 bytes
WalkSprite_71_02_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx01.bin" ; $4e20, 256 bytes
WalkSprite_71_02_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx02.bin" ; $4f20, 256 bytes
WalkSprite_71_02_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx03.bin" ; $5020, 256 bytes
WalkSprite_71_02_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx04.bin" ; $5120, 256 bytes
WalkSprite_71_02_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_02_Gfx05.bin" ; $5220, 256 bytes
WalkSprite_71_02_AnimPtrs:
	dw WalkSprite_71_02_Anim00 ; $5320
	dw WalkSprite_71_02_Anim01 ; $5322
	dw WalkSprite_71_02_Anim02 ; $5324
	dw WalkSprite_71_02_Anim03 ; $5326
	dw WalkSprite_71_02_Anim04 ; $5328
	dw WalkSprite_71_02_Anim05 ; $532a
	dw WalkSprite_71_02_Anim05 ; $532c
	dw WalkSprite_71_02_Anim05 ; $532e
WalkSprite_71_02_Anim00:
	; $5330, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_02_Anim01:
	; $5333, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_02_Anim02:
	; $5339, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_02_Anim03:
	; $5345, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_02_Anim04:
	; $534d, 20 bytes (sprite_anim)
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
WalkSprite_71_02_Anim05:
	; $5361, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_03:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_03_Gfx00, WalkSprite_71_03_Gfx01, WalkSprite_71_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_03_Gfx02 ; $537d
	dw WalkSprite_71_03_Gfx02 ; $537f
	dw WalkSprite_71_03_Gfx02 ; $5381
	dw WalkSprite_71_03_Gfx02 ; $5383
	dw WalkSprite_71_03_Gfx03 ; $5385
	dw WalkSprite_71_03_Gfx04 ; $5387
	dw WalkSprite_71_03_Gfx05 ; $5389
Padding_71_03:
	; $538b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_03_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx00.bin" ; $5390, 256 bytes
WalkSprite_71_03_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx01.bin" ; $5490, 256 bytes
WalkSprite_71_03_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx02.bin" ; $5590, 256 bytes
WalkSprite_71_03_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx03.bin" ; $5690, 256 bytes
WalkSprite_71_03_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx04.bin" ; $5790, 256 bytes
WalkSprite_71_03_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_03_Gfx05.bin" ; $5890, 256 bytes
WalkSprite_71_03_AnimPtrs:
	dw WalkSprite_71_03_Anim00 ; $5990
	dw WalkSprite_71_03_Anim01 ; $5992
	dw WalkSprite_71_03_Anim02 ; $5994
	dw WalkSprite_71_03_Anim03 ; $5996
	dw WalkSprite_71_03_Anim04 ; $5998
	dw WalkSprite_71_03_Anim05 ; $599a
	dw WalkSprite_71_03_Anim05 ; $599c
	dw WalkSprite_71_03_Anim05 ; $599e
WalkSprite_71_03_Anim00:
	; $59a0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_03_Anim01:
	; $59a3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_03_Anim02:
	; $59a9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_03_Anim03:
	; $59b5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_03_Anim04:
	; $59bd, 20 bytes (sprite_anim)
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
WalkSprite_71_03_Anim05:
	; $59d1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_04:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_04_Gfx00, WalkSprite_71_04_Gfx01, WalkSprite_71_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_04_Gfx02 ; $59ed
	dw WalkSprite_71_04_Gfx02 ; $59ef
	dw WalkSprite_71_04_Gfx02 ; $59f1
	dw WalkSprite_71_04_Gfx02 ; $59f3
	dw WalkSprite_71_04_Gfx03 ; $59f5
	dw WalkSprite_71_04_Gfx04 ; $59f7
	dw WalkSprite_71_04_Gfx05 ; $59f9
Padding_71_04:
	; $59fb, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_04_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx00.bin" ; $5a00, 256 bytes
WalkSprite_71_04_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx01.bin" ; $5b00, 256 bytes
WalkSprite_71_04_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx02.bin" ; $5c00, 256 bytes
WalkSprite_71_04_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx03.bin" ; $5d00, 256 bytes
WalkSprite_71_04_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx04.bin" ; $5e00, 256 bytes
WalkSprite_71_04_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_04_Gfx05.bin" ; $5f00, 256 bytes
WalkSprite_71_04_AnimPtrs:
	dw WalkSprite_71_04_Anim00 ; $6000
	dw WalkSprite_71_04_Anim01 ; $6002
	dw WalkSprite_71_04_Anim02 ; $6004
	dw WalkSprite_71_04_Anim03 ; $6006
	dw WalkSprite_71_04_Anim04 ; $6008
	dw WalkSprite_71_04_Anim05 ; $600a
	dw WalkSprite_71_04_Anim05 ; $600c
	dw WalkSprite_71_04_Anim05 ; $600e
WalkSprite_71_04_Anim00:
	; $6010, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_04_Anim01:
	; $6013, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_04_Anim02:
	; $6019, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_04_Anim03:
	; $6025, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_04_Anim04:
	; $602d, 20 bytes (sprite_anim)
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
WalkSprite_71_04_Anim05:
	; $6041, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_05:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_05_Gfx00, WalkSprite_71_05_Gfx01, WalkSprite_71_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_05_Gfx02 ; $605d
	dw WalkSprite_71_05_Gfx03 ; $605f
	dw WalkSprite_71_05_Gfx04 ; $6061
	dw WalkSprite_71_05_Gfx05 ; $6063
	dw WalkSprite_71_05_Gfx06 ; $6065
	dw WalkSprite_71_05_Gfx07 ; $6067
	dw WalkSprite_71_05_Gfx08 ; $6069
Padding_71_05:
	; $606b, 5 bytes (fill)
	ds 5, $00
WalkSprite_71_05_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx00.bin" ; $6070, 256 bytes
WalkSprite_71_05_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx01.bin" ; $6170, 256 bytes
WalkSprite_71_05_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx02.bin" ; $6270, 256 bytes
WalkSprite_71_05_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx03.bin" ; $6370, 256 bytes
WalkSprite_71_05_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx04.bin" ; $6470, 256 bytes
WalkSprite_71_05_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx05.bin" ; $6570, 256 bytes
WalkSprite_71_05_Gfx06:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx06.bin" ; $6670, 256 bytes
WalkSprite_71_05_Gfx07:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx07.bin" ; $6770, 256 bytes
WalkSprite_71_05_Gfx08:
	INCBIN "data/bank_071/WalkSprite_71_05_Gfx08.bin" ; $6870, 256 bytes
WalkSprite_71_05_AnimPtrs:
	dw WalkSprite_71_05_Anim00 ; $6970
	dw WalkSprite_71_05_Anim01 ; $6972
	dw WalkSprite_71_05_Anim02 ; $6974
	dw WalkSprite_71_05_Anim03 ; $6976
	dw WalkSprite_71_05_Anim04 ; $6978
	dw WalkSprite_71_05_Anim05 ; $697a
	dw WalkSprite_71_05_Anim05 ; $697c
	dw WalkSprite_71_05_Anim06 ; $697e
	dw WalkSprite_71_05_Anim07 ; $6980
WalkSprite_71_05_Anim00:
	; $6982, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_05_Anim01:
	; $6985, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_05_Anim02:
	; $698b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_05_Anim03:
	; $6997, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_05_Anim04:
	; $699f, 20 bytes (sprite_anim)
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
WalkSprite_71_05_Anim05:
	; $69b3, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_71_05_Anim06:
	; $69b8, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_05_Anim07:
	; $69c4, 8 bytes (sprite_anim)
	anim_frame $05, $5a
	anim_frame $03, $03
	anim_frame $04, $5a
	anim_loop $00
WalkSprite_71_06:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_06_Gfx00, WalkSprite_71_06_Gfx01, WalkSprite_71_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_06_Gfx02 ; $69dc
	dw WalkSprite_71_06_Gfx03 ; $69de
	dw WalkSprite_71_06_Gfx04 ; $69e0
	dw WalkSprite_71_06_Gfx05 ; $69e2
	dw WalkSprite_71_06_Gfx06 ; $69e4
	dw WalkSprite_71_06_Gfx07 ; $69e6
	dw WalkSprite_71_06_Gfx08 ; $69e8
Padding_71_06:
	; $69ea, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_06_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx00.bin" ; $69f0, 256 bytes
WalkSprite_71_06_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx01.bin" ; $6af0, 256 bytes
WalkSprite_71_06_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx02.bin" ; $6bf0, 256 bytes
WalkSprite_71_06_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx03.bin" ; $6cf0, 256 bytes
WalkSprite_71_06_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx04.bin" ; $6df0, 256 bytes
WalkSprite_71_06_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx05.bin" ; $6ef0, 256 bytes
WalkSprite_71_06_Gfx06:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx06.bin" ; $6ff0, 256 bytes
WalkSprite_71_06_Gfx07:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx07.bin" ; $70f0, 256 bytes
WalkSprite_71_06_Gfx08:
	INCBIN "data/bank_071/WalkSprite_71_06_Gfx08.bin" ; $71f0, 256 bytes
WalkSprite_71_06_AnimPtrs:
	dw WalkSprite_71_06_Anim00 ; $72f0
	dw WalkSprite_71_06_Anim01 ; $72f2
	dw WalkSprite_71_06_Anim02 ; $72f4
	dw WalkSprite_71_06_Anim03 ; $72f6
	dw WalkSprite_71_06_Anim04 ; $72f8
	dw WalkSprite_71_06_Anim05 ; $72fa
	dw WalkSprite_71_06_Anim05 ; $72fc
	dw WalkSprite_71_06_Anim06 ; $72fe
	dw WalkSprite_71_06_Anim07 ; $7300
WalkSprite_71_06_Anim00:
	; $7302, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_06_Anim01:
	; $7305, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_06_Anim02:
	; $730b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_06_Anim03:
	; $7317, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_06_Anim04:
	; $731f, 20 bytes (sprite_anim)
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
WalkSprite_71_06_Anim05:
	; $7333, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_71_06_Anim06:
	; $7338, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_06_Anim07:
	; $7344, 8 bytes (sprite_anim)
	anim_frame $05, $5a
	anim_frame $03, $03
	anim_frame $04, $5a
	anim_loop $00
WalkSprite_71_07:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_07_Gfx00, WalkSprite_71_07_Gfx01, WalkSprite_71_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_71_07_Gfx02 ; $735c
	dw WalkSprite_71_07_Gfx03 ; $735e
	dw WalkSprite_71_07_Gfx04 ; $7360
	dw WalkSprite_71_07_Gfx05 ; $7362
	dw WalkSprite_71_07_Gfx06 ; $7364
	dw WalkSprite_71_07_Gfx07 ; $7366
	dw WalkSprite_71_07_Gfx08 ; $7368
Padding_71_07:
	; $736a, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_07_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx00.bin" ; $7370, 256 bytes
WalkSprite_71_07_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx01.bin" ; $7470, 256 bytes
WalkSprite_71_07_Gfx02:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx02.bin" ; $7570, 256 bytes
WalkSprite_71_07_Gfx03:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx03.bin" ; $7670, 256 bytes
WalkSprite_71_07_Gfx04:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx04.bin" ; $7770, 256 bytes
WalkSprite_71_07_Gfx05:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx05.bin" ; $7870, 256 bytes
WalkSprite_71_07_Gfx06:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx06.bin" ; $7970, 256 bytes
WalkSprite_71_07_Gfx07:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx07.bin" ; $7a70, 256 bytes
WalkSprite_71_07_Gfx08:
	INCBIN "data/bank_071/WalkSprite_71_07_Gfx08.bin" ; $7b70, 256 bytes
WalkSprite_71_07_AnimPtrs:
	dw WalkSprite_71_07_Anim00 ; $7c70
	dw WalkSprite_71_07_Anim01 ; $7c72
	dw WalkSprite_71_07_Anim02 ; $7c74
	dw WalkSprite_71_07_Anim03 ; $7c76
	dw WalkSprite_71_07_Anim04 ; $7c78
	dw WalkSprite_71_07_Anim05 ; $7c7a
	dw WalkSprite_71_07_Anim05 ; $7c7c
	dw WalkSprite_71_07_Anim06 ; $7c7e
	dw WalkSprite_71_07_Anim07 ; $7c80
WalkSprite_71_07_Anim00:
	; $7c82, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_07_Anim01:
	; $7c85, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_07_Anim02:
	; $7c8b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_07_Anim03:
	; $7c97, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_07_Anim04:
	; $7c9f, 20 bytes (sprite_anim)
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
WalkSprite_71_07_Anim05:
	; $7cb3, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_71_07_Anim06:
	; $7cb8, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_71_07_Anim07:
	; $7cc4, 8 bytes (sprite_anim)
	anim_frame $05, $5a
	anim_frame $03, $03
	anim_frame $04, $5a
	anim_loop $00
WalkSprite_71_08:
	db $05, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_08_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_08_Gfx00, WalkSprite_71_08_AnimPtrs, WalkSprite_71_08_AnimPtrs ; frame pointers (continue in body)
	dw WalkSprite_71_08_AnimPtrs ; $7cdc
	dw WalkSprite_71_08_AnimPtrs ; $7cde
	dw WalkSprite_71_08_AnimPtrs ; $7ce0
	dw WalkSprite_71_08_AnimPtrs ; $7ce2
	dw WalkSprite_71_08_AnimPtrs ; $7ce4
	dw WalkSprite_71_08_AnimPtrs ; $7ce6
	dw WalkSprite_71_08_AnimPtrs ; $7ce8
Padding_71_08:
	; $7cea, 6 bytes (fill)
	ds 6, $00
WalkSprite_71_08_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_08_Gfx00.bin" ; $7cf0, 64 bytes
WalkSprite_71_08_AnimPtrs:
	dw WalkSprite_71_08_Anim00 ; $7d30
	dw WalkSprite_71_08_Anim00 ; $7d32
	dw WalkSprite_71_08_Anim00 ; $7d34
	dw WalkSprite_71_08_Anim00 ; $7d36
	dw WalkSprite_71_08_Anim00 ; $7d38
	dw WalkSprite_71_08_Anim00 ; $7d3a
	dw WalkSprite_71_08_Anim00 ; $7d3c
	dw WalkSprite_71_08_Anim00 ; $7d3e
WalkSprite_71_08_Anim00:
	; $7d40, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_09:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_71_09_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_71_09_Gfx00, WalkSprite_71_09_Gfx01, $0000 ; frame pointers (continue in body)
Padding_71_09:
	; $7d53, 13 bytes (fill)
	ds 13, $00
WalkSprite_71_09_Gfx00:
	INCBIN "data/bank_071/WalkSprite_71_09_Gfx00.bin" ; $7d60, 64 bytes
WalkSprite_71_09_Gfx01:
	INCBIN "data/bank_071/WalkSprite_71_09_Gfx01.bin" ; $7da0, 64 bytes
WalkSprite_71_09_AnimPtrs:
	dw WalkSprite_71_09_Anim00 ; $7de0
	dw WalkSprite_71_09_Anim01 ; $7de2
	dw WalkSprite_71_09_Anim02 ; $7de4
	dw WalkSprite_71_09_Anim02 ; $7de6
	dw WalkSprite_71_09_Anim02 ; $7de8
	dw WalkSprite_71_09_Anim02 ; $7dea
	dw WalkSprite_71_09_Anim02 ; $7dec
	dw WalkSprite_71_09_Anim02 ; $7dee
WalkSprite_71_09_Anim00:
	; $7df0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_71_09_Anim01:
	; $7df3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_71_09_Anim02:
	; $7df9, 519 bytes fill to bank end (linker-padded)
