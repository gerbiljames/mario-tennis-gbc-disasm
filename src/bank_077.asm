SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

WalkSprites_77:
	dw WalkSprite_77_00 ; $4000
	dw WalkSprite_77_01 ; $4002
	dw WalkSprite_77_02 ; $4004
	dw WalkSprite_77_03 ; $4006
	dw WalkSprite_77_04 ; $4008
	dw WalkSprite_77_05 ; $400a
	dw WalkSprite_77_06 ; $400c
	dw WalkSprite_77_07 ; $400e
WalkSprite_77_00:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_00_Gfx00, WalkSprite_77_00_Gfx01, WalkSprite_77_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_00_Gfx02 ; $4020
	dw WalkSprite_77_00_Gfx02 ; $4022
	dw WalkSprite_77_00_Gfx02 ; $4024
	dw WalkSprite_77_00_Gfx02 ; $4026
	dw WalkSprite_77_00_Gfx03 ; $4028
	dw WalkSprite_77_00_Gfx04 ; $402a
	dw WalkSprite_77_00_Gfx05 ; $402c
	dw WalkSprite_77_00_Gfx06 ; $402e
	dw WalkSprite_77_00_Gfx06 ; $4030
	dw WalkSprite_77_00_Gfx07 ; $4032
Padding_77_0:
	; $4034, 12 bytes (fill)
	ds 12, $00
WalkSprite_77_00_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx00.bin" ; $4040, 256 bytes
WalkSprite_77_00_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx01.bin" ; $4140, 256 bytes
WalkSprite_77_00_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx02.bin" ; $4240, 256 bytes
WalkSprite_77_00_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx03.bin" ; $4340, 256 bytes
WalkSprite_77_00_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx04.bin" ; $4440, 256 bytes
WalkSprite_77_00_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx05.bin" ; $4540, 256 bytes
WalkSprite_77_00_Gfx06:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx06.bin" ; $4640, 256 bytes
WalkSprite_77_00_Gfx07:
	INCBIN "data/bank_077/WalkSprite_77_00_Gfx07.bin" ; $4740, 256 bytes
WalkSprite_77_00_AnimPtrs:
	dw WalkSprite_77_00_Anim00 ; $4840
	dw WalkSprite_77_00_Anim01 ; $4842
	dw WalkSprite_77_00_Anim02 ; $4844
	dw WalkSprite_77_00_Anim03 ; $4846
	dw WalkSprite_77_00_Anim04 ; $4848
	dw WalkSprite_77_00_Anim05 ; $484a
	dw WalkSprite_77_00_Anim05 ; $484c
	dw WalkSprite_77_00_Anim05 ; $484e
	dw WalkSprite_77_00_Anim06 ; $4850
WalkSprite_77_00_Anim00:
	; $4852, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_00_Anim01:
	; $4855, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_00_Anim02:
	; $485b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_00_Anim03:
	; $4867, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_00_Anim04:
	; $486f, 20 bytes (sprite_anim)
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
WalkSprite_77_00_Anim05:
	; $4883, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_00_Anim06:
	; $488f, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_01:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_01_Gfx00, WalkSprite_77_01_Gfx01, WalkSprite_77_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_01_Gfx02 ; $48a5
	dw WalkSprite_77_01_Gfx02 ; $48a7
	dw WalkSprite_77_01_Gfx02 ; $48a9
	dw WalkSprite_77_01_Gfx02 ; $48ab
	dw WalkSprite_77_01_Gfx03 ; $48ad
	dw WalkSprite_77_01_Gfx04 ; $48af
	dw WalkSprite_77_01_Gfx05 ; $48b1
	dw WalkSprite_77_01_Gfx06 ; $48b3
	dw WalkSprite_77_01_Gfx06 ; $48b5
	dw WalkSprite_77_01_Gfx07 ; $48b7
Padding_77_1:
	; $48b9, 7 bytes (fill)
	ds 7, $00
WalkSprite_77_01_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx00.bin" ; $48c0, 256 bytes
WalkSprite_77_01_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx01.bin" ; $49c0, 256 bytes
WalkSprite_77_01_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx02.bin" ; $4ac0, 256 bytes
WalkSprite_77_01_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx03.bin" ; $4bc0, 256 bytes
WalkSprite_77_01_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx04.bin" ; $4cc0, 256 bytes
WalkSprite_77_01_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx05.bin" ; $4dc0, 256 bytes
WalkSprite_77_01_Gfx06:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx06.bin" ; $4ec0, 256 bytes
WalkSprite_77_01_Gfx07:
	INCBIN "data/bank_077/WalkSprite_77_01_Gfx07.bin" ; $4fc0, 256 bytes
WalkSprite_77_01_AnimPtrs:
	dw WalkSprite_77_01_Anim00 ; $50c0
	dw WalkSprite_77_01_Anim01 ; $50c2
	dw WalkSprite_77_01_Anim02 ; $50c4
	dw WalkSprite_77_01_Anim03 ; $50c6
	dw WalkSprite_77_01_Anim04 ; $50c8
	dw WalkSprite_77_01_Anim05 ; $50ca
	dw WalkSprite_77_01_Anim05 ; $50cc
	dw WalkSprite_77_01_Anim05 ; $50ce
	dw WalkSprite_77_01_Anim06 ; $50d0
WalkSprite_77_01_Anim00:
	; $50d2, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_01_Anim01:
	; $50d5, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_01_Anim02:
	; $50db, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_01_Anim03:
	; $50e7, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_01_Anim04:
	; $50ef, 20 bytes (sprite_anim)
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
WalkSprite_77_01_Anim05:
	; $5103, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_01_Anim06:
	; $510f, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_02:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_02_Gfx00, WalkSprite_77_02_Gfx01, WalkSprite_77_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_02_Gfx02 ; $5125
	dw WalkSprite_77_02_Gfx02 ; $5127
	dw WalkSprite_77_02_Gfx02 ; $5129
	dw WalkSprite_77_02_Gfx02 ; $512b
	dw WalkSprite_77_02_Gfx03 ; $512d
	dw WalkSprite_77_02_Gfx04 ; $512f
	dw WalkSprite_77_02_Gfx05 ; $5131
	dw WalkSprite_77_02_Gfx06 ; $5133
	dw WalkSprite_77_02_Gfx06 ; $5135
	dw WalkSprite_77_02_Gfx07 ; $5137
Padding_77_2:
	; $5139, 7 bytes (fill)
	ds 7, $00
WalkSprite_77_02_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx00.bin" ; $5140, 256 bytes
WalkSprite_77_02_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx01.bin" ; $5240, 256 bytes
WalkSprite_77_02_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx02.bin" ; $5340, 256 bytes
WalkSprite_77_02_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx03.bin" ; $5440, 256 bytes
WalkSprite_77_02_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx04.bin" ; $5540, 256 bytes
WalkSprite_77_02_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx05.bin" ; $5640, 256 bytes
WalkSprite_77_02_Gfx06:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx06.bin" ; $5740, 256 bytes
WalkSprite_77_02_Gfx07:
	INCBIN "data/bank_077/WalkSprite_77_02_Gfx07.bin" ; $5840, 256 bytes
WalkSprite_77_02_AnimPtrs:
	dw WalkSprite_77_02_Anim00 ; $5940
	dw WalkSprite_77_02_Anim01 ; $5942
	dw WalkSprite_77_02_Anim02 ; $5944
	dw WalkSprite_77_02_Anim03 ; $5946
	dw WalkSprite_77_02_Anim04 ; $5948
	dw WalkSprite_77_02_Anim05 ; $594a
	dw WalkSprite_77_02_Anim05 ; $594c
	dw WalkSprite_77_02_Anim05 ; $594e
	dw WalkSprite_77_02_Anim06 ; $5950
WalkSprite_77_02_Anim00:
	; $5952, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_02_Anim01:
	; $5955, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_02_Anim02:
	; $595b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_02_Anim03:
	; $5967, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_02_Anim04:
	; $596f, 20 bytes (sprite_anim)
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
WalkSprite_77_02_Anim05:
	; $5983, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_02_Anim06:
	; $598f, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_03:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_03_Gfx00, WalkSprite_77_03_Gfx01, WalkSprite_77_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_03_Gfx02 ; $59a5
	dw WalkSprite_77_03_Gfx02 ; $59a7
	dw WalkSprite_77_03_Gfx02 ; $59a9
	dw WalkSprite_77_03_Gfx02 ; $59ab
	dw WalkSprite_77_03_Gfx03 ; $59ad
	dw WalkSprite_77_03_Gfx04 ; $59af
	dw WalkSprite_77_03_Gfx05 ; $59b1
Padding_77_3:
	; $59b3, 13 bytes (fill)
	ds 13, $00
WalkSprite_77_03_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx00.bin" ; $59c0, 256 bytes
WalkSprite_77_03_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx01.bin" ; $5ac0, 256 bytes
WalkSprite_77_03_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx02.bin" ; $5bc0, 256 bytes
WalkSprite_77_03_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx03.bin" ; $5cc0, 256 bytes
WalkSprite_77_03_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx04.bin" ; $5dc0, 256 bytes
WalkSprite_77_03_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_03_Gfx05.bin" ; $5ec0, 256 bytes
WalkSprite_77_03_AnimPtrs:
	dw WalkSprite_77_03_Anim00 ; $5fc0
	dw WalkSprite_77_03_Anim01 ; $5fc2
	dw WalkSprite_77_03_Anim02 ; $5fc4
	dw WalkSprite_77_03_Anim03 ; $5fc6
	dw WalkSprite_77_03_Anim04 ; $5fc8
	dw WalkSprite_77_03_Anim05 ; $5fca
	dw WalkSprite_77_03_Anim05 ; $5fcc
	dw WalkSprite_77_03_Anim06 ; $5fce
	dw WalkSprite_77_03_Anim07 ; $5fd0
	dw WalkSprite_77_03_Anim08 ; $5fd2
	dw WalkSprite_77_03_Anim09 ; $5fd4
	dw WalkSprite_77_03_Anim10 ; $5fd6
WalkSprite_77_03_Anim00:
	; $5fd8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_03_Anim01:
	; $5fdb, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_03_Anim02:
	; $5fe1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_03_Anim03:
	; $5fed, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_03_Anim04:
	; $5ff5, 20 bytes (sprite_anim)
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
WalkSprite_77_03_Anim05:
	; $6009, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_77_03_Anim06:
	; $600e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_03_Anim07:
	; $601a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_03_Anim08:
	; $6020, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_77_03_Anim09:
	; $6023, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_77_03_Anim10:
	; $6026, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_77_04:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_04_Gfx00, WalkSprite_77_04_Gfx01, WalkSprite_77_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_04_Gfx02 ; $6041
	dw WalkSprite_77_04_Gfx02 ; $6043
	dw WalkSprite_77_04_Gfx02 ; $6045
	dw WalkSprite_77_04_Gfx02 ; $6047
	dw WalkSprite_77_04_Gfx03 ; $6049
	dw WalkSprite_77_04_Gfx04 ; $604b
	dw WalkSprite_77_04_Gfx05 ; $604d
	db $00 ; $604f
WalkSprite_77_04_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx00.bin" ; $6050, 256 bytes
WalkSprite_77_04_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx01.bin" ; $6150, 256 bytes
WalkSprite_77_04_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx02.bin" ; $6250, 256 bytes
WalkSprite_77_04_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx03.bin" ; $6350, 256 bytes
WalkSprite_77_04_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx04.bin" ; $6450, 256 bytes
WalkSprite_77_04_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_04_Gfx05.bin" ; $6550, 256 bytes
WalkSprite_77_04_AnimPtrs:
	dw WalkSprite_77_04_Anim00 ; $6650
	dw WalkSprite_77_04_Anim01 ; $6652
	dw WalkSprite_77_04_Anim02 ; $6654
	dw WalkSprite_77_04_Anim03 ; $6656
	dw WalkSprite_77_04_Anim04 ; $6658
	dw WalkSprite_77_04_Anim05 ; $665a
	dw WalkSprite_77_04_Anim05 ; $665c
	dw WalkSprite_77_04_Anim06 ; $665e
	dw WalkSprite_77_04_Anim07 ; $6660
	dw WalkSprite_77_04_Anim08 ; $6662
	dw WalkSprite_77_04_Anim09 ; $6664
	dw WalkSprite_77_04_Anim10 ; $6666
WalkSprite_77_04_Anim00:
	; $6668, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_04_Anim01:
	; $666b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_04_Anim02:
	; $6671, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_04_Anim03:
	; $667d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_04_Anim04:
	; $6685, 20 bytes (sprite_anim)
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
WalkSprite_77_04_Anim05:
	; $6699, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_77_04_Anim06:
	; $669e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_04_Anim07:
	; $66aa, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_04_Anim08:
	; $66b0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_77_04_Anim09:
	; $66b3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_77_04_Anim10:
	; $66b6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_77_05:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_05_Gfx00, WalkSprite_77_05_Gfx01, WalkSprite_77_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_05_Gfx02 ; $66d1
	dw WalkSprite_77_05_Gfx02 ; $66d3
	dw WalkSprite_77_05_Gfx02 ; $66d5
	dw WalkSprite_77_05_Gfx02 ; $66d7
	dw WalkSprite_77_05_Gfx03 ; $66d9
	dw WalkSprite_77_05_Gfx04 ; $66db
	dw WalkSprite_77_05_Gfx05 ; $66dd
	db $00 ; $66df
WalkSprite_77_05_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx00.bin" ; $66e0, 256 bytes
WalkSprite_77_05_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx01.bin" ; $67e0, 256 bytes
WalkSprite_77_05_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx02.bin" ; $68e0, 256 bytes
WalkSprite_77_05_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx03.bin" ; $69e0, 256 bytes
WalkSprite_77_05_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx04.bin" ; $6ae0, 256 bytes
WalkSprite_77_05_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_05_Gfx05.bin" ; $6be0, 256 bytes
WalkSprite_77_05_AnimPtrs:
	dw WalkSprite_77_05_Anim00 ; $6ce0
	dw WalkSprite_77_05_Anim01 ; $6ce2
	dw WalkSprite_77_05_Anim02 ; $6ce4
	dw WalkSprite_77_05_Anim03 ; $6ce6
	dw WalkSprite_77_05_Anim04 ; $6ce8
	dw WalkSprite_77_05_Anim05 ; $6cea
	dw WalkSprite_77_05_Anim05 ; $6cec
	dw WalkSprite_77_05_Anim06 ; $6cee
	dw WalkSprite_77_05_Anim07 ; $6cf0
	dw WalkSprite_77_05_Anim08 ; $6cf2
	dw WalkSprite_77_05_Anim09 ; $6cf4
	dw WalkSprite_77_05_Anim10 ; $6cf6
WalkSprite_77_05_Anim00:
	; $6cf8, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_05_Anim01:
	; $6cfb, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_05_Anim02:
	; $6d01, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_05_Anim03:
	; $6d0d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_05_Anim04:
	; $6d15, 20 bytes (sprite_anim)
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
WalkSprite_77_05_Anim05:
	; $6d29, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_77_05_Anim06:
	; $6d2e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_05_Anim07:
	; $6d3a, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_05_Anim08:
	; $6d40, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_77_05_Anim09:
	; $6d43, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_77_05_Anim10:
	; $6d46, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_77_06:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_06_Gfx00, WalkSprite_77_06_Gfx01, WalkSprite_77_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_06_Gfx02 ; $6d61
	dw WalkSprite_77_06_Gfx02 ; $6d63
	dw WalkSprite_77_06_Gfx02 ; $6d65
	dw WalkSprite_77_06_Gfx02 ; $6d67
	dw WalkSprite_77_06_Gfx03 ; $6d69
	dw WalkSprite_77_06_Gfx04 ; $6d6b
	dw WalkSprite_77_06_Gfx05 ; $6d6d
	db $00 ; $6d6f
WalkSprite_77_06_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx00.bin" ; $6d70, 256 bytes
WalkSprite_77_06_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx01.bin" ; $6e70, 256 bytes
WalkSprite_77_06_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx02.bin" ; $6f70, 256 bytes
WalkSprite_77_06_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx03.bin" ; $7070, 256 bytes
WalkSprite_77_06_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx04.bin" ; $7170, 256 bytes
WalkSprite_77_06_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_06_Gfx05.bin" ; $7270, 256 bytes
WalkSprite_77_06_AnimPtrs:
	dw WalkSprite_77_06_Anim00 ; $7370
	dw WalkSprite_77_06_Anim01 ; $7372
	dw WalkSprite_77_06_Anim02 ; $7374
	dw WalkSprite_77_06_Anim03 ; $7376
	dw WalkSprite_77_06_Anim04 ; $7378
	dw WalkSprite_77_06_Anim05 ; $737a
	dw WalkSprite_77_06_Anim05 ; $737c
	dw WalkSprite_77_06_Anim06 ; $737e
	dw WalkSprite_77_06_Anim07 ; $7380
	dw WalkSprite_77_06_Anim08 ; $7382
	dw WalkSprite_77_06_Anim09 ; $7384
	dw WalkSprite_77_06_Anim10 ; $7386
WalkSprite_77_06_Anim00:
	; $7388, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_06_Anim01:
	; $738b, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_77_06_Anim02:
	; $7391, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_06_Anim03:
	; $739d, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_06_Anim04:
	; $73a5, 20 bytes (sprite_anim)
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
WalkSprite_77_06_Anim05:
	; $73b9, 5 bytes (sprite_anim)
	anim_frame $03, $14
	anim_frame $04, $1e
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_77_06_Anim06:
	; $73be, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_77_06_Anim07:
	; $73ca, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_77_06_Anim08:
	; $73d0, 3 bytes (sprite_anim)
	anim_frame $03, $01
	anim_hold $fd
WalkSprite_77_06_Anim09:
	; $73d3, 3 bytes (sprite_anim)
	anim_frame $04, $01
	anim_hold $fd
WalkSprite_77_06_Anim10:
	; $73d6, 11 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_frame $0d, $0a
	anim_frame $0e, $0a
	anim_hold $fd
WalkSprite_77_07:
	db $05, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_77_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_77_07_Gfx00, WalkSprite_77_07_Gfx01, WalkSprite_77_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_77_07_Gfx03 ; $73f1
	dw WalkSprite_77_07_Gfx04 ; $73f3
	dw WalkSprite_77_07_Gfx04 ; $73f5
	dw WalkSprite_77_07_Gfx04 ; $73f7
	dw WalkSprite_77_07_Gfx04 ; $73f9
	dw WalkSprite_77_07_Gfx04 ; $73fb
	dw WalkSprite_77_07_Gfx04 ; $73fd
	dw WalkSprite_77_07_Gfx04 ; $73ff
	dw WalkSprite_77_07_Gfx04 ; $7401
	dw WalkSprite_77_07_Gfx05 ; $7403
Padding_77_4:
	; $7405, 11 bytes (fill)
	ds 11, $00
WalkSprite_77_07_Gfx00:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx00.bin" ; $7410, 64 bytes
WalkSprite_77_07_Gfx01:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx01.bin" ; $7450, 64 bytes
WalkSprite_77_07_Gfx02:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx02.bin" ; $7490, 64 bytes
WalkSprite_77_07_Gfx03:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx03.bin" ; $74d0, 64 bytes
WalkSprite_77_07_Gfx04:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx04.bin" ; $7510, 64 bytes
WalkSprite_77_07_Gfx05:
	INCBIN "data/bank_077/WalkSprite_77_07_Gfx05.bin" ; $7550, 64 bytes
WalkSprite_77_07_AnimPtrs:
	dw WalkSprite_77_07_Anim00 ; $7590
	dw WalkSprite_77_07_Anim01 ; $7592
	dw WalkSprite_77_07_Anim02 ; $7594
	dw WalkSprite_77_07_Anim02 ; $7596
	dw WalkSprite_77_07_Anim02 ; $7598
	dw WalkSprite_77_07_Anim02 ; $759a
	dw WalkSprite_77_07_Anim02 ; $759c
	dw WalkSprite_77_07_Anim03 ; $759e
	dw WalkSprite_77_07_Anim04 ; $75a0
WalkSprite_77_07_Anim00:
	; $75a2, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_07_Anim01:
	; $75a5, 6 bytes (sprite_anim)
	anim_frame $00, $03
	anim_frame $01, $03
	anim_loop $00
WalkSprite_77_07_Anim02:
	; $75ab, 6 bytes (sprite_anim)
	anim_frame $02, $03
	anim_frame $03, $03
	anim_loop $00
WalkSprite_77_07_Anim03:
	; $75b1, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_77_07_Anim04:
	; $75b4, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $03
	anim_loop $00
	; $75ba, 2630 bytes fill to bank end (linker-padded)
