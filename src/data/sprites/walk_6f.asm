WalkSprites_6f:
	dw WalkSprite_6f_00 ; $4000
	dw WalkSprite_6f_01 ; $4002
	dw WalkSprite_6f_02 ; $4004
	dw WalkSprite_6f_03 ; $4006
	dw WalkSprite_6f_04 ; $4008
	dw WalkSprite_6f_05 ; $400a
	dw WalkSprite_6f_06 ; $400c
	dw WalkSprite_6f_07 ; $400e
WalkSprite_6f_00:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_00_Gfx00, WalkSprite_6f_00_Gfx01, WalkSprite_6f_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_00_Gfx02 ; $4020
	dw WalkSprite_6f_00_Gfx02 ; $4022
	dw WalkSprite_6f_00_Gfx02 ; $4024
	dw WalkSprite_6f_00_Gfx02 ; $4026
	dw WalkSprite_6f_00_Gfx03 ; $4028
	dw WalkSprite_6f_00_Gfx04 ; $402a
	dw WalkSprite_6f_00_Gfx05 ; $402c
	db $00 ; $402e
	db $00 ; $402f
WalkSprite_6f_00_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx00.bin" ; $4030, 256 bytes
WalkSprite_6f_00_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx01.bin" ; $4130, 256 bytes
WalkSprite_6f_00_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx02.bin" ; $4230, 256 bytes
WalkSprite_6f_00_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx03.bin" ; $4330, 256 bytes
WalkSprite_6f_00_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx04.bin" ; $4430, 256 bytes
WalkSprite_6f_00_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_00_Gfx05.bin" ; $4530, 256 bytes
WalkSprite_6f_00_AnimPtrs:
	dw WalkSprite_6f_00_Anim00 ; $4630
	dw WalkSprite_6f_00_Anim01 ; $4632
	dw WalkSprite_6f_00_Anim02 ; $4634
	dw WalkSprite_6f_00_Anim03 ; $4636
	dw WalkSprite_6f_00_Anim04 ; $4638
	dw WalkSprite_6f_00_Anim05 ; $463a
	dw WalkSprite_6f_00_Anim05 ; $463c
	dw WalkSprite_6f_00_Anim06 ; $463e
	dw WalkSprite_6f_00_Anim07 ; $4640
	dw WalkSprite_6f_00_Anim08 ; $4642
	dw WalkSprite_6f_00_Anim09 ; $4644
	dw WalkSprite_6f_00_Anim10 ; $4646
WalkSprite_6f_00_Anim00:
	; $4648, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_00_Anim01:
	; $464b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_00_Anim02:
	; $4651, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_00_Anim03:
	; $465d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_00_Anim04:
	; $4665, 20 bytes (sprite_anim)
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
WalkSprite_6f_00_Anim05:
	; $4679, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_00_Anim06:
	; $467e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_00_Anim07:
	; $468a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_00_Anim08:
	; $4690, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_00_Anim09:
	; $4693, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_00_Anim10:
	; $4696, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_01:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_01_Gfx00, WalkSprite_6f_01_Gfx01, WalkSprite_6f_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_01_Gfx02 ; $46b1
	dw WalkSprite_6f_01_Gfx02 ; $46b3
	dw WalkSprite_6f_01_Gfx02 ; $46b5
	dw WalkSprite_6f_01_Gfx02 ; $46b7
	dw WalkSprite_6f_01_Gfx03 ; $46b9
	dw WalkSprite_6f_01_Gfx04 ; $46bb
	dw WalkSprite_6f_01_Gfx05 ; $46bd
	db $00 ; $46bf
WalkSprite_6f_01_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx00.bin" ; $46c0, 256 bytes
WalkSprite_6f_01_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx01.bin" ; $47c0, 256 bytes
WalkSprite_6f_01_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx02.bin" ; $48c0, 256 bytes
WalkSprite_6f_01_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx03.bin" ; $49c0, 256 bytes
WalkSprite_6f_01_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx04.bin" ; $4ac0, 256 bytes
WalkSprite_6f_01_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_01_Gfx05.bin" ; $4bc0, 256 bytes
WalkSprite_6f_01_AnimPtrs:
	dw WalkSprite_6f_01_Anim00 ; $4cc0
	dw WalkSprite_6f_01_Anim01 ; $4cc2
	dw WalkSprite_6f_01_Anim02 ; $4cc4
	dw WalkSprite_6f_01_Anim03 ; $4cc6
	dw WalkSprite_6f_01_Anim04 ; $4cc8
	dw WalkSprite_6f_01_Anim05 ; $4cca
	dw WalkSprite_6f_01_Anim05 ; $4ccc
	dw WalkSprite_6f_01_Anim06 ; $4cce
	dw WalkSprite_6f_01_Anim07 ; $4cd0
	dw WalkSprite_6f_01_Anim08 ; $4cd2
	dw WalkSprite_6f_01_Anim09 ; $4cd4
	dw WalkSprite_6f_01_Anim10 ; $4cd6
WalkSprite_6f_01_Anim00:
	; $4cd8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_01_Anim01:
	; $4cdb, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_01_Anim02:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_01_Anim03:
	; $4ced, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_01_Anim04:
	; $4cf5, 20 bytes (sprite_anim)
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
WalkSprite_6f_01_Anim05:
	; $4d09, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_01_Anim06:
	; $4d0e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_01_Anim07:
	; $4d1a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_01_Anim08:
	; $4d20, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_01_Anim09:
	; $4d23, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_01_Anim10:
	; $4d26, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_02:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_02_Gfx00, WalkSprite_6f_02_Gfx01, WalkSprite_6f_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_02_Gfx02 ; $4d41
	dw WalkSprite_6f_02_Gfx02 ; $4d43
	dw WalkSprite_6f_02_Gfx02 ; $4d45
	dw WalkSprite_6f_02_Gfx02 ; $4d47
	dw WalkSprite_6f_02_Gfx03 ; $4d49
	dw WalkSprite_6f_02_Gfx04 ; $4d4b
	dw WalkSprite_6f_02_Gfx05 ; $4d4d
	db $00 ; $4d4f
WalkSprite_6f_02_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx00.bin" ; $4d50, 256 bytes
WalkSprite_6f_02_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx01.bin" ; $4e50, 256 bytes
WalkSprite_6f_02_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx02.bin" ; $4f50, 256 bytes
WalkSprite_6f_02_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx03.bin" ; $5050, 256 bytes
WalkSprite_6f_02_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx04.bin" ; $5150, 256 bytes
WalkSprite_6f_02_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_02_Gfx05.bin" ; $5250, 256 bytes
WalkSprite_6f_02_AnimPtrs:
	dw WalkSprite_6f_02_Anim00 ; $5350
	dw WalkSprite_6f_02_Anim01 ; $5352
	dw WalkSprite_6f_02_Anim02 ; $5354
	dw WalkSprite_6f_02_Anim03 ; $5356
	dw WalkSprite_6f_02_Anim04 ; $5358
	dw WalkSprite_6f_02_Anim05 ; $535a
	dw WalkSprite_6f_02_Anim05 ; $535c
	dw WalkSprite_6f_02_Anim06 ; $535e
	dw WalkSprite_6f_02_Anim07 ; $5360
	dw WalkSprite_6f_02_Anim08 ; $5362
	dw WalkSprite_6f_02_Anim09 ; $5364
	dw WalkSprite_6f_02_Anim10 ; $5366
WalkSprite_6f_02_Anim00:
	; $5368, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_02_Anim01:
	; $536b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_02_Anim02:
	; $5371, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_02_Anim03:
	; $537d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_02_Anim04:
	; $5385, 20 bytes (sprite_anim)
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
WalkSprite_6f_02_Anim05:
	; $5399, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_02_Anim06:
	; $539e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_02_Anim07:
	; $53aa, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_02_Anim08:
	; $53b0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_02_Anim09:
	; $53b3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_02_Anim10:
	; $53b6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_03:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_03_Gfx00, WalkSprite_6f_03_Gfx01, WalkSprite_6f_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_03_Gfx02 ; $53d1
	dw WalkSprite_6f_03_Gfx02 ; $53d3
	dw WalkSprite_6f_03_Gfx02 ; $53d5
	dw WalkSprite_6f_03_Gfx02 ; $53d7
	dw WalkSprite_6f_03_Gfx03 ; $53d9
	dw WalkSprite_6f_03_Gfx04 ; $53db
	dw WalkSprite_6f_03_Gfx05 ; $53dd
	db $00 ; $53df
WalkSprite_6f_03_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx00.bin" ; $53e0, 256 bytes
WalkSprite_6f_03_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx01.bin" ; $54e0, 256 bytes
WalkSprite_6f_03_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx02.bin" ; $55e0, 256 bytes
WalkSprite_6f_03_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx03.bin" ; $56e0, 256 bytes
WalkSprite_6f_03_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx04.bin" ; $57e0, 256 bytes
WalkSprite_6f_03_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_03_Gfx05.bin" ; $58e0, 256 bytes
WalkSprite_6f_03_AnimPtrs:
	dw WalkSprite_6f_03_Anim00 ; $59e0
	dw WalkSprite_6f_03_Anim01 ; $59e2
	dw WalkSprite_6f_03_Anim02 ; $59e4
	dw WalkSprite_6f_03_Anim03 ; $59e6
	dw WalkSprite_6f_03_Anim04 ; $59e8
	dw WalkSprite_6f_03_Anim05 ; $59ea
	dw WalkSprite_6f_03_Anim05 ; $59ec
	dw WalkSprite_6f_03_Anim06 ; $59ee
	dw WalkSprite_6f_03_Anim07 ; $59f0
	dw WalkSprite_6f_03_Anim08 ; $59f2
	dw WalkSprite_6f_03_Anim09 ; $59f4
	dw WalkSprite_6f_03_Anim10 ; $59f6
WalkSprite_6f_03_Anim00:
	; $59f8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_03_Anim01:
	; $59fb, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_03_Anim02:
	; $5a01, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_03_Anim03:
	; $5a0d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_03_Anim04:
	; $5a15, 20 bytes (sprite_anim)
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
WalkSprite_6f_03_Anim05:
	; $5a29, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_03_Anim06:
	; $5a2e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_03_Anim07:
	; $5a3a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_03_Anim08:
	; $5a40, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_03_Anim09:
	; $5a43, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_03_Anim10:
	; $5a46, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_04:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_04_Gfx00, WalkSprite_6f_04_Gfx01, WalkSprite_6f_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_04_Gfx02 ; $5a61
	dw WalkSprite_6f_04_Gfx02 ; $5a63
	dw WalkSprite_6f_04_Gfx02 ; $5a65
	dw WalkSprite_6f_04_Gfx02 ; $5a67
	dw WalkSprite_6f_04_Gfx03 ; $5a69
	dw WalkSprite_6f_04_Gfx04 ; $5a6b
	dw WalkSprite_6f_04_Gfx05 ; $5a6d
	db $00 ; $5a6f
WalkSprite_6f_04_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx00.bin" ; $5a70, 256 bytes
WalkSprite_6f_04_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx01.bin" ; $5b70, 256 bytes
WalkSprite_6f_04_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx02.bin" ; $5c70, 256 bytes
WalkSprite_6f_04_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx03.bin" ; $5d70, 256 bytes
WalkSprite_6f_04_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx04.bin" ; $5e70, 256 bytes
WalkSprite_6f_04_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_04_Gfx05.bin" ; $5f70, 256 bytes
WalkSprite_6f_04_AnimPtrs:
	dw WalkSprite_6f_04_Anim00 ; $6070
	dw WalkSprite_6f_04_Anim01 ; $6072
	dw WalkSprite_6f_04_Anim02 ; $6074
	dw WalkSprite_6f_04_Anim03 ; $6076
	dw WalkSprite_6f_04_Anim04 ; $6078
	dw WalkSprite_6f_04_Anim05 ; $607a
	dw WalkSprite_6f_04_Anim05 ; $607c
	dw WalkSprite_6f_04_Anim06 ; $607e
	dw WalkSprite_6f_04_Anim07 ; $6080
	dw WalkSprite_6f_04_Anim08 ; $6082
	dw WalkSprite_6f_04_Anim09 ; $6084
	dw WalkSprite_6f_04_Anim10 ; $6086
WalkSprite_6f_04_Anim00:
	; $6088, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_04_Anim01:
	; $608b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_04_Anim02:
	; $6091, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_04_Anim03:
	; $609d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_04_Anim04:
	; $60a5, 20 bytes (sprite_anim)
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
WalkSprite_6f_04_Anim05:
	; $60b9, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_04_Anim06:
	; $60be, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_04_Anim07:
	; $60ca, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_04_Anim08:
	; $60d0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_04_Anim09:
	; $60d3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_04_Anim10:
	; $60d6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_05:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_05_Gfx00, WalkSprite_6f_05_Gfx01, WalkSprite_6f_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_05_Gfx02 ; $60f1
	dw WalkSprite_6f_05_Gfx02 ; $60f3
	dw WalkSprite_6f_05_Gfx02 ; $60f5
	dw WalkSprite_6f_05_Gfx02 ; $60f7
	dw WalkSprite_6f_05_Gfx03 ; $60f9
	dw WalkSprite_6f_05_Gfx04 ; $60fb
	dw WalkSprite_6f_05_Gfx05 ; $60fd
	db $00 ; $60ff
WalkSprite_6f_05_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx00.bin" ; $6100, 256 bytes
WalkSprite_6f_05_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx01.bin" ; $6200, 256 bytes
WalkSprite_6f_05_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx02.bin" ; $6300, 256 bytes
WalkSprite_6f_05_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx03.bin" ; $6400, 256 bytes
WalkSprite_6f_05_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx04.bin" ; $6500, 256 bytes
WalkSprite_6f_05_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_05_Gfx05.bin" ; $6600, 256 bytes
WalkSprite_6f_05_AnimPtrs:
	dw WalkSprite_6f_05_Anim00 ; $6700
	dw WalkSprite_6f_05_Anim01 ; $6702
	dw WalkSprite_6f_05_Anim02 ; $6704
	dw WalkSprite_6f_05_Anim03 ; $6706
	dw WalkSprite_6f_05_Anim04 ; $6708
	dw WalkSprite_6f_05_Anim05 ; $670a
	dw WalkSprite_6f_05_Anim05 ; $670c
	dw WalkSprite_6f_05_Anim06 ; $670e
	dw WalkSprite_6f_05_Anim07 ; $6710
	dw WalkSprite_6f_05_Anim08 ; $6712
	dw WalkSprite_6f_05_Anim09 ; $6714
	dw WalkSprite_6f_05_Anim10 ; $6716
WalkSprite_6f_05_Anim00:
	; $6718, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_05_Anim01:
	; $671b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_05_Anim02:
	; $6721, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_05_Anim03:
	; $672d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_05_Anim04:
	; $6735, 20 bytes (sprite_anim)
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
WalkSprite_6f_05_Anim05:
	; $6749, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_05_Anim06:
	; $674e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_05_Anim07:
	; $675a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_05_Anim08:
	; $6760, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_05_Anim09:
	; $6763, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_05_Anim10:
	; $6766, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_06:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_06_Gfx00, WalkSprite_6f_06_Gfx01, WalkSprite_6f_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_06_Gfx02 ; $6781
	dw WalkSprite_6f_06_Gfx02 ; $6783
	dw WalkSprite_6f_06_Gfx02 ; $6785
	dw WalkSprite_6f_06_Gfx02 ; $6787
	dw WalkSprite_6f_06_Gfx03 ; $6789
	dw WalkSprite_6f_06_Gfx04 ; $678b
	dw WalkSprite_6f_06_Gfx05 ; $678d
	db $00 ; $678f
WalkSprite_6f_06_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx00.bin" ; $6790, 256 bytes
WalkSprite_6f_06_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx01.bin" ; $6890, 256 bytes
WalkSprite_6f_06_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx02.bin" ; $6990, 256 bytes
WalkSprite_6f_06_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx03.bin" ; $6a90, 256 bytes
WalkSprite_6f_06_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx04.bin" ; $6b90, 256 bytes
WalkSprite_6f_06_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_06_Gfx05.bin" ; $6c90, 256 bytes
WalkSprite_6f_06_AnimPtrs:
	dw WalkSprite_6f_06_Anim00 ; $6d90
	dw WalkSprite_6f_06_Anim01 ; $6d92
	dw WalkSprite_6f_06_Anim02 ; $6d94
	dw WalkSprite_6f_06_Anim03 ; $6d96
	dw WalkSprite_6f_06_Anim04 ; $6d98
	dw WalkSprite_6f_06_Anim05 ; $6d9a
	dw WalkSprite_6f_06_Anim05 ; $6d9c
	dw WalkSprite_6f_06_Anim06 ; $6d9e
	dw WalkSprite_6f_06_Anim07 ; $6da0
	dw WalkSprite_6f_06_Anim08 ; $6da2
	dw WalkSprite_6f_06_Anim09 ; $6da4
	dw WalkSprite_6f_06_Anim10 ; $6da6
WalkSprite_6f_06_Anim00:
	; $6da8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_06_Anim01:
	; $6dab, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_06_Anim02:
	; $6db1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_06_Anim03:
	; $6dbd, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_06_Anim04:
	; $6dc5, 20 bytes (sprite_anim)
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
WalkSprite_6f_06_Anim05:
	; $6dd9, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_06_Anim06:
	; $6dde, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_06_Anim07:
	; $6dea, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_06_Anim08:
	; $6df0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_06_Anim09:
	; $6df3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_06_Anim10:
	; $6df6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_6f_07:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_6f_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_6f_07_Gfx00, WalkSprite_6f_07_Gfx01, WalkSprite_6f_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_6f_07_Gfx02 ; $6e11
	dw WalkSprite_6f_07_Gfx02 ; $6e13
	dw WalkSprite_6f_07_Gfx02 ; $6e15
	dw WalkSprite_6f_07_Gfx02 ; $6e17
	dw WalkSprite_6f_07_Gfx03 ; $6e19
	dw WalkSprite_6f_07_Gfx04 ; $6e1b
	dw WalkSprite_6f_07_Gfx05 ; $6e1d
	db $00 ; $6e1f
WalkSprite_6f_07_Gfx00:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx00.bin" ; $6e20, 256 bytes
WalkSprite_6f_07_Gfx01:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx01.bin" ; $6f20, 256 bytes
WalkSprite_6f_07_Gfx02:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx02.bin" ; $7020, 256 bytes
WalkSprite_6f_07_Gfx03:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx03.bin" ; $7120, 256 bytes
WalkSprite_6f_07_Gfx04:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx04.bin" ; $7220, 256 bytes
WalkSprite_6f_07_Gfx05:
	INCBIN "data/bank_06f/WalkSprite_6f_07_Gfx05.bin" ; $7320, 256 bytes
WalkSprite_6f_07_AnimPtrs:
	dw WalkSprite_6f_07_Anim00 ; $7420
	dw WalkSprite_6f_07_Anim01 ; $7422
	dw WalkSprite_6f_07_Anim02 ; $7424
	dw WalkSprite_6f_07_Anim03 ; $7426
	dw WalkSprite_6f_07_Anim04 ; $7428
	dw WalkSprite_6f_07_Anim05 ; $742a
	dw WalkSprite_6f_07_Anim05 ; $742c
	dw WalkSprite_6f_07_Anim06 ; $742e
	dw WalkSprite_6f_07_Anim07 ; $7430
	dw WalkSprite_6f_07_Anim08 ; $7432
	dw WalkSprite_6f_07_Anim09 ; $7434
	dw WalkSprite_6f_07_Anim10 ; $7436
WalkSprite_6f_07_Anim00:
	; $7438, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_6f_07_Anim01:
	; $743b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_6f_07_Anim02:
	; $7441, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_07_Anim03:
	; $744d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_07_Anim04:
	; $7455, 20 bytes (sprite_anim)
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
WalkSprite_6f_07_Anim05:
	; $7469, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_6f_07_Anim06:
	; $746e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_6f_07_Anim07:
	; $747a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_6f_07_Anim08:
	; $7480, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_6f_07_Anim09:
	; $7483, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_6f_07_Anim10:
	; $7486, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
	; $7491, 2927 bytes fill to bank end (linker-padded)
