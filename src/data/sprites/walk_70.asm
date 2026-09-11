DataPtr_WalkSprite_70_00:
	dw WalkSprite_70_00 ; $4000
DataPtr_WalkSprite_70_01:
	dw WalkSprite_70_01 ; $4002
DataPtr_WalkSprite_70_02:
	dw WalkSprite_70_02 ; $4004
DataPtr_WalkSprite_70_03:
	dw WalkSprite_70_03 ; $4006
DataPtr_WalkSprite_70_04:
	dw WalkSprite_70_04 ; $4008
DataPtr_WalkSprite_70_05:
	dw WalkSprite_70_05 ; $400a
DataPtr_WalkSprite_70_06:
	dw WalkSprite_70_06 ; $400c
WalkSprite_70_00:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_00_Gfx00, WalkSprite_70_00_Gfx01, WalkSprite_70_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_00_Gfx02 ; $401e
	dw WalkSprite_70_00_Gfx03 ; $4020
	dw WalkSprite_70_00_Gfx04 ; $4022
	dw WalkSprite_70_00_Gfx04 ; $4024
	dw WalkSprite_70_00_Gfx05 ; $4026
	dw WalkSprite_70_00_Gfx06 ; $4028
	dw WalkSprite_70_00_Gfx07 ; $402a
	dw WalkSprite_70_00_Gfx08 ; $402c
	dw WalkSprite_70_00_Gfx08 ; $402e
	dw WalkSprite_70_00_Gfx09 ; $4030
	dw WalkSprite_70_00_Gfx10 ; $4032
	dw WalkSprite_70_00_Gfx11 ; $4034
Padding_70_0:
	; $4036, 10 bytes (fill)
	ds 10, $00
WalkSprite_70_00_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx00.bin" ; $4040, 256 bytes
WalkSprite_70_00_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx01.bin" ; $4140, 256 bytes
WalkSprite_70_00_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx02.bin" ; $4240, 256 bytes
WalkSprite_70_00_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx03.bin" ; $4340, 256 bytes
WalkSprite_70_00_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx04.bin" ; $4440, 256 bytes
WalkSprite_70_00_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx05.bin" ; $4540, 256 bytes
WalkSprite_70_00_Gfx06:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx06.bin" ; $4640, 256 bytes
WalkSprite_70_00_Gfx07:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx07.bin" ; $4740, 256 bytes
WalkSprite_70_00_Gfx08:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx08.bin" ; $4840, 256 bytes
WalkSprite_70_00_Gfx09:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx09.bin" ; $4940, 256 bytes
WalkSprite_70_00_Gfx10:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx10.bin" ; $4a40, 256 bytes
WalkSprite_70_00_Gfx11:
	INCBIN "data/bank_070/WalkSprite_70_00_Gfx11.bin" ; $4b40, 256 bytes
WalkSprite_70_00_AnimPtrs:
	dw WalkSprite_70_00_Anim00 ; $4c40
	dw WalkSprite_70_00_Anim01 ; $4c42
	dw WalkSprite_70_00_Anim02 ; $4c44
	dw WalkSprite_70_00_Anim03 ; $4c46
	dw WalkSprite_70_00_Anim04 ; $4c48
	dw WalkSprite_70_00_Anim05 ; $4c4a
	dw WalkSprite_70_00_Anim05 ; $4c4c
	dw WalkSprite_70_00_Anim06 ; $4c4e
	dw WalkSprite_70_00_Anim07 ; $4c50
	dw WalkSprite_70_00_Anim08 ; $4c52
	dw WalkSprite_70_00_Anim09 ; $4c54
	dw WalkSprite_70_00_Anim10 ; $4c56
WalkSprite_70_00_Anim00:
	; $4c58, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_00_Anim01:
	; $4c5b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_00_Anim02:
	; $4c61, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_00_Anim03:
	; $4c6d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_00_Anim04:
	; $4c75, 20 bytes (sprite_anim)
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
WalkSprite_70_00_Anim05:
	; $4c89, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_70_00_Anim06:
	; $4c8e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_00_Anim07:
	; $4c9a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_70_00_Anim08:
	; $4ca0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_70_00_Anim09:
	; $4ca3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_70_00_Anim10:
	; $4ca6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_70_01:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_01_Gfx00, WalkSprite_70_01_Gfx01, WalkSprite_70_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_01_Gfx02 ; $4cc1
	dw WalkSprite_70_01_Gfx03 ; $4cc3
	dw WalkSprite_70_01_Gfx04 ; $4cc5
	dw WalkSprite_70_01_Gfx04 ; $4cc7
	dw WalkSprite_70_01_Gfx05 ; $4cc9
	dw WalkSprite_70_01_Gfx06 ; $4ccb
	dw WalkSprite_70_01_Gfx07 ; $4ccd
	dw WalkSprite_70_01_Gfx08 ; $4ccf
	dw WalkSprite_70_01_Gfx08 ; $4cd1
	dw WalkSprite_70_01_Gfx09 ; $4cd3
	dw WalkSprite_70_01_Gfx10 ; $4cd5
	dw WalkSprite_70_01_Gfx11 ; $4cd7
Padding_70_1:
	; $4cd9, 7 bytes (fill)
	ds 7, $00
WalkSprite_70_01_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx00.bin" ; $4ce0, 256 bytes
WalkSprite_70_01_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx01.bin" ; $4de0, 256 bytes
WalkSprite_70_01_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx02.bin" ; $4ee0, 256 bytes
WalkSprite_70_01_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx03.bin" ; $4fe0, 256 bytes
WalkSprite_70_01_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx04.bin" ; $50e0, 256 bytes
WalkSprite_70_01_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx05.bin" ; $51e0, 256 bytes
WalkSprite_70_01_Gfx06:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx06.bin" ; $52e0, 256 bytes
WalkSprite_70_01_Gfx07:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx07.bin" ; $53e0, 256 bytes
WalkSprite_70_01_Gfx08:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx08.bin" ; $54e0, 256 bytes
WalkSprite_70_01_Gfx09:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx09.bin" ; $55e0, 256 bytes
WalkSprite_70_01_Gfx10:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx10.bin" ; $56e0, 256 bytes
WalkSprite_70_01_Gfx11:
	INCBIN "data/bank_070/WalkSprite_70_01_Gfx11.bin" ; $57e0, 256 bytes
WalkSprite_70_01_AnimPtrs:
	dw WalkSprite_70_01_Anim00 ; $58e0
	dw WalkSprite_70_01_Anim01 ; $58e2
	dw WalkSprite_70_01_Anim02 ; $58e4
	dw WalkSprite_70_01_Anim03 ; $58e6
	dw WalkSprite_70_01_Anim04 ; $58e8
	dw WalkSprite_70_01_Anim05 ; $58ea
	dw WalkSprite_70_01_Anim05 ; $58ec
	dw WalkSprite_70_01_Anim06 ; $58ee
	dw WalkSprite_70_01_Anim07 ; $58f0
	dw WalkSprite_70_01_Anim08 ; $58f2
	dw WalkSprite_70_01_Anim09 ; $58f4
	dw WalkSprite_70_01_Anim10 ; $58f6
WalkSprite_70_01_Anim00:
	; $58f8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_01_Anim01:
	; $58fb, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_01_Anim02:
	; $5901, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_01_Anim03:
	; $590d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_01_Anim04:
	; $5915, 20 bytes (sprite_anim)
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
WalkSprite_70_01_Anim05:
	; $5929, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_70_01_Anim06:
	; $592e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_01_Anim07:
	; $593a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_70_01_Anim08:
	; $5940, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_70_01_Anim09:
	; $5943, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_70_01_Anim10:
	; $5946, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_70_02:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_02_Gfx00, WalkSprite_70_02_Gfx01, WalkSprite_70_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_02_Gfx02 ; $5961
	dw WalkSprite_70_02_Gfx02 ; $5963
	dw WalkSprite_70_02_Gfx02 ; $5965
	dw WalkSprite_70_02_Gfx02 ; $5967
	dw WalkSprite_70_02_Gfx03 ; $5969
	dw WalkSprite_70_02_Gfx04 ; $596b
	dw WalkSprite_70_02_Gfx05 ; $596d
	dw WalkSprite_70_02_Gfx06 ; $596f
	dw WalkSprite_70_02_Gfx06 ; $5971
	dw WalkSprite_70_02_Gfx07 ; $5973
Padding_70_2:
	; $5975, 11 bytes (fill)
	ds 11, $00
WalkSprite_70_02_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx00.bin" ; $5980, 256 bytes
WalkSprite_70_02_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx01.bin" ; $5a80, 256 bytes
WalkSprite_70_02_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx02.bin" ; $5b80, 256 bytes
WalkSprite_70_02_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx03.bin" ; $5c80, 256 bytes
WalkSprite_70_02_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx04.bin" ; $5d80, 256 bytes
WalkSprite_70_02_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx05.bin" ; $5e80, 256 bytes
WalkSprite_70_02_Gfx06:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx06.bin" ; $5f80, 256 bytes
WalkSprite_70_02_Gfx07:
	INCBIN "data/bank_070/WalkSprite_70_02_Gfx07.bin" ; $6080, 256 bytes
WalkSprite_70_02_AnimPtrs:
	dw WalkSprite_70_02_Anim00 ; $6180
	dw WalkSprite_70_02_Anim01 ; $6182
	dw WalkSprite_70_02_Anim02 ; $6184
	dw WalkSprite_70_02_Anim03 ; $6186
	dw WalkSprite_70_02_Anim04 ; $6188
	dw WalkSprite_70_02_Anim05 ; $618a
	dw WalkSprite_70_02_Anim05 ; $618c
	dw WalkSprite_70_02_Anim05 ; $618e
	dw WalkSprite_70_02_Anim06 ; $6190
WalkSprite_70_02_Anim00:
	; $6192, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_02_Anim01:
	; $6195, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_02_Anim02:
	; $619b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_02_Anim03:
	; $61a7, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_02_Anim04:
	; $61af, 20 bytes (sprite_anim)
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
WalkSprite_70_02_Anim05:
	; $61c3, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_02_Anim06:
	; $61cf, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_70_03:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_03_Gfx00, WalkSprite_70_03_Gfx01, WalkSprite_70_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_03_Gfx02 ; $61e5
	dw WalkSprite_70_03_Gfx02 ; $61e7
	dw WalkSprite_70_03_Gfx02 ; $61e9
	dw WalkSprite_70_03_Gfx02 ; $61eb
	dw WalkSprite_70_03_Gfx03 ; $61ed
	dw WalkSprite_70_03_Gfx04 ; $61ef
	dw WalkSprite_70_03_Gfx05 ; $61f1
	dw WalkSprite_70_03_Gfx06 ; $61f3
	dw WalkSprite_70_03_Gfx06 ; $61f5
	dw WalkSprite_70_03_Gfx07 ; $61f7
Padding_70_3:
	; $61f9, 7 bytes (fill)
	ds 7, $00
WalkSprite_70_03_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx00.bin" ; $6200, 256 bytes
WalkSprite_70_03_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx01.bin" ; $6300, 256 bytes
WalkSprite_70_03_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx02.bin" ; $6400, 256 bytes
WalkSprite_70_03_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx03.bin" ; $6500, 256 bytes
WalkSprite_70_03_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx04.bin" ; $6600, 256 bytes
WalkSprite_70_03_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx05.bin" ; $6700, 256 bytes
WalkSprite_70_03_Gfx06:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx06.bin" ; $6800, 256 bytes
WalkSprite_70_03_Gfx07:
	INCBIN "data/bank_070/WalkSprite_70_03_Gfx07.bin" ; $6900, 256 bytes
WalkSprite_70_03_AnimPtrs:
	dw WalkSprite_70_03_Anim00 ; $6a00
	dw WalkSprite_70_03_Anim01 ; $6a02
	dw WalkSprite_70_03_Anim02 ; $6a04
	dw WalkSprite_70_03_Anim03 ; $6a06
	dw WalkSprite_70_03_Anim04 ; $6a08
	dw WalkSprite_70_03_Anim05 ; $6a0a
	dw WalkSprite_70_03_Anim05 ; $6a0c
	dw WalkSprite_70_03_Anim05 ; $6a0e
	dw WalkSprite_70_03_Anim06 ; $6a10
WalkSprite_70_03_Anim00:
	; $6a12, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_03_Anim01:
	; $6a15, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_03_Anim02:
	; $6a1b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_03_Anim03:
	; $6a27, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_03_Anim04:
	; $6a2f, 20 bytes (sprite_anim)
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
WalkSprite_70_03_Anim05:
	; $6a43, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_03_Anim06:
	; $6a4f, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_70_04:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_04_Gfx00, WalkSprite_70_04_Gfx01, WalkSprite_70_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_04_Gfx02 ; $6a65
	dw WalkSprite_70_04_Gfx02 ; $6a67
	dw WalkSprite_70_04_Gfx02 ; $6a69
	dw WalkSprite_70_04_Gfx02 ; $6a6b
	dw WalkSprite_70_04_Gfx03 ; $6a6d
	dw WalkSprite_70_04_Gfx04 ; $6a6f
	dw WalkSprite_70_04_Gfx05 ; $6a71
Padding_70_4:
	; $6a73, 13 bytes (fill)
	ds 13, $00
WalkSprite_70_04_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx00.bin" ; $6a80, 256 bytes
WalkSprite_70_04_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx01.bin" ; $6b80, 256 bytes
WalkSprite_70_04_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx02.bin" ; $6c80, 256 bytes
WalkSprite_70_04_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx03.bin" ; $6d80, 256 bytes
WalkSprite_70_04_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx04.bin" ; $6e80, 256 bytes
WalkSprite_70_04_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_04_Gfx05.bin" ; $6f80, 256 bytes
WalkSprite_70_04_AnimPtrs:
	dw WalkSprite_70_04_Anim00 ; $7080
	dw WalkSprite_70_04_Anim01 ; $7082
	dw WalkSprite_70_04_Anim02 ; $7084
	dw WalkSprite_70_04_Anim03 ; $7086
	dw WalkSprite_70_04_Anim04 ; $7088
	dw WalkSprite_70_04_Anim05 ; $708a
	dw WalkSprite_70_04_Anim05 ; $708c
	dw WalkSprite_70_04_Anim05 ; $708e
WalkSprite_70_04_Anim00:
	; $7090, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_04_Anim01:
	; $7093, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_04_Anim02:
	; $7099, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_04_Anim03:
	; $70a5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_04_Anim04:
	; $70ad, 20 bytes (sprite_anim)
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
WalkSprite_70_04_Anim05:
	; $70c1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_05:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_05_Gfx00, WalkSprite_70_05_Gfx01, WalkSprite_70_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_05_Gfx02 ; $70dd
	dw WalkSprite_70_05_Gfx02 ; $70df
	dw WalkSprite_70_05_Gfx02 ; $70e1
	dw WalkSprite_70_05_Gfx02 ; $70e3
	dw WalkSprite_70_05_Gfx03 ; $70e5
	dw WalkSprite_70_05_Gfx04 ; $70e7
	dw WalkSprite_70_05_Gfx05 ; $70e9
Padding_70_5:
	; $70eb, 5 bytes (fill)
	ds 5, $00
WalkSprite_70_05_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx00.bin" ; $70f0, 256 bytes
WalkSprite_70_05_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx01.bin" ; $71f0, 256 bytes
WalkSprite_70_05_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx02.bin" ; $72f0, 256 bytes
WalkSprite_70_05_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx03.bin" ; $73f0, 256 bytes
WalkSprite_70_05_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx04.bin" ; $74f0, 256 bytes
WalkSprite_70_05_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_05_Gfx05.bin" ; $75f0, 256 bytes
WalkSprite_70_05_AnimPtrs:
	dw WalkSprite_70_05_Anim00 ; $76f0
	dw WalkSprite_70_05_Anim01 ; $76f2
	dw WalkSprite_70_05_Anim02 ; $76f4
	dw WalkSprite_70_05_Anim03 ; $76f6
	dw WalkSprite_70_05_Anim04 ; $76f8
	dw WalkSprite_70_05_Anim05 ; $76fa
	dw WalkSprite_70_05_Anim05 ; $76fc
	dw WalkSprite_70_05_Anim05 ; $76fe
WalkSprite_70_05_Anim00:
	; $7700, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_05_Anim01:
	; $7703, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_05_Anim02:
	; $7709, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_05_Anim03:
	; $7715, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_05_Anim04:
	; $771d, 20 bytes (sprite_anim)
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
WalkSprite_70_05_Anim05:
	; $7731, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_06:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_70_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_70_06_Gfx00, WalkSprite_70_06_Gfx01, WalkSprite_70_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_70_06_Gfx02 ; $774d
	dw WalkSprite_70_06_Gfx02 ; $774f
	dw WalkSprite_70_06_Gfx02 ; $7751
	dw WalkSprite_70_06_Gfx02 ; $7753
	dw WalkSprite_70_06_Gfx03 ; $7755
	dw WalkSprite_70_06_Gfx04 ; $7757
	dw WalkSprite_70_06_Gfx05 ; $7759
Padding_70_6:
	; $775b, 5 bytes (fill)
	ds 5, $00
WalkSprite_70_06_Gfx00:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx00.bin" ; $7760, 256 bytes
WalkSprite_70_06_Gfx01:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx01.bin" ; $7860, 256 bytes
WalkSprite_70_06_Gfx02:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx02.bin" ; $7960, 256 bytes
WalkSprite_70_06_Gfx03:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx03.bin" ; $7a60, 256 bytes
WalkSprite_70_06_Gfx04:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx04.bin" ; $7b60, 256 bytes
WalkSprite_70_06_Gfx05:
	INCBIN "data/bank_070/WalkSprite_70_06_Gfx05.bin" ; $7c60, 256 bytes
WalkSprite_70_06_AnimPtrs:
	dw WalkSprite_70_06_Anim00 ; $7d60
	dw WalkSprite_70_06_Anim01 ; $7d62
	dw WalkSprite_70_06_Anim02 ; $7d64
	dw WalkSprite_70_06_Anim03 ; $7d66
	dw WalkSprite_70_06_Anim04 ; $7d68
	dw WalkSprite_70_06_Anim05 ; $7d6a
	dw WalkSprite_70_06_Anim05 ; $7d6c
	dw WalkSprite_70_06_Anim05 ; $7d6e
WalkSprite_70_06_Anim00:
	; $7d70, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_70_06_Anim01:
	; $7d73, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_70_06_Anim02:
	; $7d79, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_06_Anim03:
	; $7d85, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_70_06_Anim04:
	; $7d8d, 20 bytes (sprite_anim)
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
WalkSprite_70_06_Anim05:
	; $7da1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
	; $7dad, 595 bytes fill to bank end (linker-padded)
