DataPtr_WalkSprite_73_00:
	dw WalkSprite_73_00 ; $4000
DataPtr_WalkSprite_73_01:
	dw WalkSprite_73_01 ; $4002
DataPtr_WalkSprite_73_02:
	dw WalkSprite_73_02 ; $4004
DataPtr_WalkSprite_73_03:
	dw WalkSprite_73_03 ; $4006
DataPtr_WalkSprite_73_04:
	dw WalkSprite_73_04 ; $4008
DataPtr_WalkSprite_73_05:
	dw WalkSprite_73_05 ; $400a
DataPtr_WalkSprite_73_06:
	dw WalkSprite_73_06 ; $400c
DataPtr_WalkSprite_73_07:
	dw WalkSprite_73_07 ; $400e
DataPtr_WalkSprite_73_08:
	dw WalkSprite_73_08 ; $4010
DataPtr_WalkSprite_73_09:
	dw WalkSprite_73_09 ; $4012
DataPtr_WalkSprite_73_10:
	dw WalkSprite_73_10 ; $4014
DataPtr_WalkSprite_73_11:
	dw WalkSprite_73_11 ; $4016
DataPtr_WalkSprite_73_12:
	dw WalkSprite_73_12 ; $4018
DataPtr_WalkSprite_73_13:
	dw WalkSprite_73_13 ; $401a
DataPtr_WalkSprite_73_14:
	dw WalkSprite_73_14 ; $401c
DataPtr_WalkSprite_73_15:
	dw WalkSprite_73_15 ; $401e
DataPtr_WalkSprite_73_16:
	dw WalkSprite_73_16 ; $4020
DataPtr_WalkSprite_73_17:
	dw WalkSprite_73_17 ; $4022
DataPtr_WalkSprite_73_18:
	dw WalkSprite_73_18 ; $4024
DataPtr_WalkSprite_73_19:
	dw WalkSprite_73_19 ; $4026
WalkSprite_73_00:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_00_Gfx00, WalkSprite_73_00_Gfx01, WalkSprite_73_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_00_Gfx02 ; $4038
	dw WalkSprite_73_00_Gfx02 ; $403a
	dw WalkSprite_73_00_Gfx02 ; $403c
	dw WalkSprite_73_00_Gfx02 ; $403e
	dw WalkSprite_73_00_Gfx03 ; $4040
	dw WalkSprite_73_00_Gfx04 ; $4042
	dw WalkSprite_73_00_Gfx05 ; $4044
Padding_73_00:
	; $4046, 10 bytes (fill)
	ds 10, $00
WalkSprite_73_00_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx00.bin" ; $4050, 256 bytes
WalkSprite_73_00_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx01.bin" ; $4150, 256 bytes
WalkSprite_73_00_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx02.bin" ; $4250, 256 bytes
WalkSprite_73_00_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx03.bin" ; $4350, 256 bytes
WalkSprite_73_00_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx04.bin" ; $4450, 256 bytes
WalkSprite_73_00_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_00_Gfx05.bin" ; $4550, 256 bytes
WalkSprite_73_00_AnimPtrs:
	dw WalkSprite_73_00_Anim00 ; $4650
	dw WalkSprite_73_00_Anim01 ; $4652
	dw WalkSprite_73_00_Anim02 ; $4654
	dw WalkSprite_73_00_Anim03 ; $4656
	dw WalkSprite_73_00_Anim04 ; $4658
	dw WalkSprite_73_00_Anim05 ; $465a
	dw WalkSprite_73_00_Anim05 ; $465c
	dw WalkSprite_73_00_Anim05 ; $465e
WalkSprite_73_00_Anim00:
	; $4660, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_00_Anim01:
	; $4663, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_00_Anim02:
	; $4669, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_00_Anim03:
	; $4675, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_00_Anim04:
	; $467d, 20 bytes (sprite_anim)
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
WalkSprite_73_00_Anim05:
	; $4691, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_01:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_01_Gfx00, WalkSprite_73_01_Gfx01, WalkSprite_73_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_01_Gfx02 ; $46ad
	dw WalkSprite_73_01_Gfx02 ; $46af
	dw WalkSprite_73_01_Gfx02 ; $46b1
	dw WalkSprite_73_01_Gfx02 ; $46b3
	dw WalkSprite_73_01_Gfx03 ; $46b5
	dw WalkSprite_73_01_Gfx04 ; $46b7
	dw WalkSprite_73_01_Gfx05 ; $46b9
Padding_73_01:
	; $46bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_01_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx00.bin" ; $46c0, 256 bytes
WalkSprite_73_01_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx01.bin" ; $47c0, 256 bytes
WalkSprite_73_01_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx02.bin" ; $48c0, 256 bytes
WalkSprite_73_01_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx03.bin" ; $49c0, 256 bytes
WalkSprite_73_01_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx04.bin" ; $4ac0, 256 bytes
WalkSprite_73_01_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_01_Gfx05.bin" ; $4bc0, 256 bytes
WalkSprite_73_01_AnimPtrs:
	dw WalkSprite_73_01_Anim00 ; $4cc0
	dw WalkSprite_73_01_Anim01 ; $4cc2
	dw WalkSprite_73_01_Anim02 ; $4cc4
	dw WalkSprite_73_01_Anim03 ; $4cc6
	dw WalkSprite_73_01_Anim04 ; $4cc8
	dw WalkSprite_73_01_Anim05 ; $4cca
	dw WalkSprite_73_01_Anim05 ; $4ccc
	dw WalkSprite_73_01_Anim05 ; $4cce
WalkSprite_73_01_Anim00:
	; $4cd0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_01_Anim01:
	; $4cd3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_01_Anim02:
	; $4cd9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_01_Anim03:
	; $4ce5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_01_Anim04:
	; $4ced, 20 bytes (sprite_anim)
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
WalkSprite_73_01_Anim05:
	; $4d01, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_02:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_02_Gfx00, WalkSprite_73_02_Gfx01, WalkSprite_73_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_02_Gfx02 ; $4d1d
	dw WalkSprite_73_02_Gfx02 ; $4d1f
	dw WalkSprite_73_02_Gfx02 ; $4d21
	dw WalkSprite_73_02_Gfx02 ; $4d23
	dw WalkSprite_73_02_Gfx03 ; $4d25
	dw WalkSprite_73_02_Gfx04 ; $4d27
	dw WalkSprite_73_02_Gfx05 ; $4d29
Padding_73_02:
	; $4d2b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_02_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx00.bin" ; $4d30, 64 bytes
WalkSprite_73_02_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx01.bin" ; $4d70, 64 bytes
WalkSprite_73_02_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx02.bin" ; $4db0, 64 bytes
WalkSprite_73_02_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx03.bin" ; $4df0, 64 bytes
WalkSprite_73_02_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx04.bin" ; $4e30, 64 bytes
WalkSprite_73_02_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_02_Gfx05.bin" ; $4e70, 64 bytes
WalkSprite_73_02_AnimPtrs:
	dw WalkSprite_73_02_Anim00 ; $4eb0
	dw WalkSprite_73_02_Anim01 ; $4eb2
	dw WalkSprite_73_02_Anim02 ; $4eb4
	dw WalkSprite_73_02_Anim03 ; $4eb6
	dw WalkSprite_73_02_Anim04 ; $4eb8
	dw WalkSprite_73_02_Anim05 ; $4eba
	dw WalkSprite_73_02_Anim05 ; $4ebc
	dw WalkSprite_73_02_Anim05 ; $4ebe
WalkSprite_73_02_Anim00:
	; $4ec0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_02_Anim01:
	; $4ec3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_02_Anim02:
	; $4ec9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_02_Anim03:
	; $4ed5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_02_Anim04:
	; $4edd, 20 bytes (sprite_anim)
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
WalkSprite_73_02_Anim05:
	; $4ef1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_03:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_03_Gfx00, WalkSprite_73_03_Gfx01, WalkSprite_73_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_03_Gfx02 ; $4f0d
	dw WalkSprite_73_03_Gfx02 ; $4f0f
	dw WalkSprite_73_03_Gfx02 ; $4f11
	dw WalkSprite_73_03_Gfx02 ; $4f13
	dw WalkSprite_73_03_Gfx03 ; $4f15
	dw WalkSprite_73_03_Gfx04 ; $4f17
	dw WalkSprite_73_03_Gfx05 ; $4f19
Padding_73_03:
	; $4f1b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_03_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx00.bin" ; $4f20, 64 bytes
WalkSprite_73_03_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx01.bin" ; $4f60, 64 bytes
WalkSprite_73_03_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx02.bin" ; $4fa0, 64 bytes
WalkSprite_73_03_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx03.bin" ; $4fe0, 64 bytes
WalkSprite_73_03_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx04.bin" ; $5020, 64 bytes
WalkSprite_73_03_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_03_Gfx05.bin" ; $5060, 64 bytes
WalkSprite_73_03_AnimPtrs:
	dw WalkSprite_73_03_Anim00 ; $50a0
	dw WalkSprite_73_03_Anim01 ; $50a2
	dw WalkSprite_73_03_Anim02 ; $50a4
	dw WalkSprite_73_03_Anim03 ; $50a6
	dw WalkSprite_73_03_Anim04 ; $50a8
	dw WalkSprite_73_03_Anim05 ; $50aa
	dw WalkSprite_73_03_Anim05 ; $50ac
	dw WalkSprite_73_03_Anim05 ; $50ae
WalkSprite_73_03_Anim00:
	; $50b0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_03_Anim01:
	; $50b3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_03_Anim02:
	; $50b9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_03_Anim03:
	; $50c5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_03_Anim04:
	; $50cd, 20 bytes (sprite_anim)
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
WalkSprite_73_03_Anim05:
	; $50e1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_04:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_04_Gfx00, WalkSprite_73_04_Gfx01, WalkSprite_73_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_04_Gfx02 ; $50fd
	dw WalkSprite_73_04_Gfx02 ; $50ff
	dw WalkSprite_73_04_Gfx02 ; $5101
	dw WalkSprite_73_04_Gfx02 ; $5103
	dw WalkSprite_73_04_Gfx03 ; $5105
	dw WalkSprite_73_04_Gfx04 ; $5107
	dw WalkSprite_73_04_Gfx05 ; $5109
Padding_73_04:
	; $510b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_04_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx00.bin" ; $5110, 64 bytes
WalkSprite_73_04_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx01.bin" ; $5150, 64 bytes
WalkSprite_73_04_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx02.bin" ; $5190, 64 bytes
WalkSprite_73_04_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx03.bin" ; $51d0, 64 bytes
WalkSprite_73_04_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx04.bin" ; $5210, 64 bytes
WalkSprite_73_04_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_04_Gfx05.bin" ; $5250, 64 bytes
WalkSprite_73_04_AnimPtrs:
	dw WalkSprite_73_04_Anim00 ; $5290
	dw WalkSprite_73_04_Anim01 ; $5292
	dw WalkSprite_73_04_Anim02 ; $5294
	dw WalkSprite_73_04_Anim03 ; $5296
	dw WalkSprite_73_04_Anim04 ; $5298
	dw WalkSprite_73_04_Anim05 ; $529a
	dw WalkSprite_73_04_Anim05 ; $529c
	dw WalkSprite_73_04_Anim05 ; $529e
WalkSprite_73_04_Anim00:
	; $52a0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_04_Anim01:
	; $52a3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_04_Anim02:
	; $52a9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_04_Anim03:
	; $52b5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_04_Anim04:
	; $52bd, 20 bytes (sprite_anim)
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
WalkSprite_73_04_Anim05:
	; $52d1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_05:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_05_Gfx00, WalkSprite_73_05_Gfx01, WalkSprite_73_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_05_Gfx02 ; $52ed
	dw WalkSprite_73_05_Gfx02 ; $52ef
	dw WalkSprite_73_05_Gfx02 ; $52f1
	dw WalkSprite_73_05_Gfx02 ; $52f3
	dw WalkSprite_73_05_Gfx03 ; $52f5
	dw WalkSprite_73_05_Gfx04 ; $52f7
	dw WalkSprite_73_05_Gfx05 ; $52f9
Padding_73_05:
	; $52fb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_05_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx00.bin" ; $5300, 64 bytes
WalkSprite_73_05_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx01.bin" ; $5340, 64 bytes
WalkSprite_73_05_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx02.bin" ; $5380, 64 bytes
WalkSprite_73_05_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx03.bin" ; $53c0, 64 bytes
WalkSprite_73_05_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx04.bin" ; $5400, 64 bytes
WalkSprite_73_05_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_05_Gfx05.bin" ; $5440, 64 bytes
WalkSprite_73_05_AnimPtrs:
	dw WalkSprite_73_05_Anim00 ; $5480
	dw WalkSprite_73_05_Anim01 ; $5482
	dw WalkSprite_73_05_Anim02 ; $5484
	dw WalkSprite_73_05_Anim03 ; $5486
	dw WalkSprite_73_05_Anim04 ; $5488
	dw WalkSprite_73_05_Anim05 ; $548a
	dw WalkSprite_73_05_Anim05 ; $548c
	dw WalkSprite_73_05_Anim05 ; $548e
WalkSprite_73_05_Anim00:
	; $5490, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_05_Anim01:
	; $5493, 6 bytes (sprite_anim)
	anim_frame $00, $46
	anim_frame $01, $28
	anim_loop $00
WalkSprite_73_05_Anim02:
	; $5499, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_05_Anim03:
	; $54a5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_05_Anim04:
	; $54ad, 20 bytes (sprite_anim)
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
WalkSprite_73_05_Anim05:
	; $54c1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_06:
	db $04, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_06_Gfx00, WalkSprite_73_06_Gfx01, WalkSprite_73_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_06_Gfx02 ; $54dd
	dw WalkSprite_73_06_Gfx02 ; $54df
	dw WalkSprite_73_06_Gfx02 ; $54e1
	dw WalkSprite_73_06_Gfx02 ; $54e3
	dw WalkSprite_73_06_Gfx03 ; $54e5
	dw WalkSprite_73_06_Gfx04 ; $54e7
	dw WalkSprite_73_06_Gfx05 ; $54e9
	dw WalkSprite_73_06_Gfx06 ; $54eb
Padding_73_06:
	; $54ed, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_06_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx00.bin" ; $54f0, 64 bytes
WalkSprite_73_06_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx01.bin" ; $5530, 64 bytes
WalkSprite_73_06_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx02.bin" ; $5570, 64 bytes
WalkSprite_73_06_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx03.bin" ; $55b0, 64 bytes
WalkSprite_73_06_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx04.bin" ; $55f0, 64 bytes
WalkSprite_73_06_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx05.bin" ; $5630, 64 bytes
WalkSprite_73_06_Gfx06:
	INCBIN "data/bank_073/WalkSprite_73_06_Gfx06.bin" ; $5670, 64 bytes
WalkSprite_73_06_AnimPtrs:
	dw WalkSprite_73_06_Anim00 ; $56b0
	dw WalkSprite_73_06_Anim00 ; $56b2
	dw WalkSprite_73_06_Anim01 ; $56b4
	dw WalkSprite_73_06_Anim02 ; $56b6
	dw WalkSprite_73_06_Anim03 ; $56b8
	dw WalkSprite_73_06_Anim04 ; $56ba
	dw WalkSprite_73_06_Anim05 ; $56bc
	dw WalkSprite_73_06_Anim05 ; $56be
WalkSprite_73_06_Anim00:
	; $56c0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_06_Anim01:
	; $56c3, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_06_Anim02:
	; $56cf, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_06_Anim03:
	; $56d7, 20 bytes (sprite_anim)
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
WalkSprite_73_06_Anim04:
	; $56eb, 10 bytes (sprite_anim)
	anim_frame $00, $30
	anim_frame $01, $30
	anim_frame $00, $30
	anim_frame $0a, $30
	anim_loop $00
WalkSprite_73_06_Anim05:
	; $56f5, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_07:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_07_Gfx00, WalkSprite_73_07_Gfx01, WalkSprite_73_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_07_Gfx02 ; $5711
	dw WalkSprite_73_07_Gfx02 ; $5713
	dw WalkSprite_73_07_Gfx02 ; $5715
	dw WalkSprite_73_07_Gfx02 ; $5717
	dw WalkSprite_73_07_Gfx03 ; $5719
	dw WalkSprite_73_07_Gfx04 ; $571b
	dw WalkSprite_73_07_Gfx05 ; $571d
	dw WalkSprite_73_07_Gfx06 ; $571f
Padding_73_07:
	; $5721, 15 bytes (fill)
	ds 15, $00
WalkSprite_73_07_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx00.bin" ; $5730, 64 bytes
WalkSprite_73_07_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx01.bin" ; $5770, 64 bytes
WalkSprite_73_07_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx02.bin" ; $57b0, 64 bytes
WalkSprite_73_07_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx03.bin" ; $57f0, 64 bytes
WalkSprite_73_07_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx04.bin" ; $5830, 64 bytes
WalkSprite_73_07_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx05.bin" ; $5870, 64 bytes
WalkSprite_73_07_Gfx06:
	INCBIN "data/bank_073/WalkSprite_73_07_Gfx06.bin" ; $58b0, 64 bytes
WalkSprite_73_07_AnimPtrs:
	dw WalkSprite_73_07_Anim00 ; $58f0
	dw WalkSprite_73_07_Anim00 ; $58f2
	dw WalkSprite_73_07_Anim01 ; $58f4
	dw WalkSprite_73_07_Anim02 ; $58f6
	dw WalkSprite_73_07_Anim02 ; $58f8
	dw WalkSprite_73_07_Anim03 ; $58fa
	dw WalkSprite_73_07_Anim04 ; $58fc
	dw WalkSprite_73_07_Anim04 ; $58fe
WalkSprite_73_07_Anim00:
	; $5900, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_07_Anim01:
	; $5903, 18 bytes (sprite_anim)
	anim_frame $00, $44
	anim_frame $01, $1c
	anim_frame $00, $1c
	anim_frame $0a, $30
	anim_frame $00, $1c
	anim_frame $01, $30
	anim_frame $00, $30
	anim_frame $0a, $1c
	anim_loop $00
WalkSprite_73_07_Anim02:
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
WalkSprite_73_07_Anim03:
	; $5929, 10 bytes (sprite_anim)
	anim_frame $00, $30
	anim_frame $01, $30
	anim_frame $00, $30
	anim_frame $0a, $30
	anim_loop $00
WalkSprite_73_07_Anim04:
	; $5933, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_08:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_08_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_08_Gfx00, WalkSprite_73_08_Gfx01, WalkSprite_73_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_08_Gfx02 ; $594f
	dw WalkSprite_73_08_Gfx02 ; $5951
	dw WalkSprite_73_08_Gfx02 ; $5953
	dw WalkSprite_73_08_Gfx02 ; $5955
	dw WalkSprite_73_08_Gfx03 ; $5957
	dw WalkSprite_73_08_Gfx04 ; $5959
	dw WalkSprite_73_08_Gfx05 ; $595b
Padding_73_08:
	; $595d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_08_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx00.bin" ; $5960, 256 bytes
WalkSprite_73_08_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx01.bin" ; $5a60, 256 bytes
WalkSprite_73_08_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx02.bin" ; $5b60, 256 bytes
WalkSprite_73_08_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx03.bin" ; $5c60, 256 bytes
WalkSprite_73_08_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx04.bin" ; $5d60, 256 bytes
WalkSprite_73_08_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_08_Gfx05.bin" ; $5e60, 256 bytes
WalkSprite_73_08_AnimPtrs:
	dw WalkSprite_73_08_Anim00 ; $5f60
	dw WalkSprite_73_08_Anim01 ; $5f62
	dw WalkSprite_73_08_Anim02 ; $5f64
	dw WalkSprite_73_08_Anim03 ; $5f66
	dw WalkSprite_73_08_Anim04 ; $5f68
	dw WalkSprite_73_08_Anim05 ; $5f6a
	dw WalkSprite_73_08_Anim05 ; $5f6c
	dw WalkSprite_73_08_Anim05 ; $5f6e
WalkSprite_73_08_Anim00:
	; $5f70, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_08_Anim01:
	; $5f73, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_08_Anim02:
	; $5f79, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_08_Anim03:
	; $5f85, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_08_Anim04:
	; $5f8d, 20 bytes (sprite_anim)
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
WalkSprite_73_08_Anim05:
	; $5fa1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_09:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_09_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_09_Gfx00, WalkSprite_73_09_Gfx01, WalkSprite_73_09_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_09_Gfx02 ; $5fbd
	dw WalkSprite_73_09_Gfx02 ; $5fbf
	dw WalkSprite_73_09_Gfx02 ; $5fc1
	dw WalkSprite_73_09_Gfx02 ; $5fc3
	dw WalkSprite_73_09_Gfx03 ; $5fc5
	dw WalkSprite_73_09_Gfx04 ; $5fc7
	dw WalkSprite_73_09_Gfx05 ; $5fc9
	dw WalkSprite_73_09_Gfx06 ; $5fcb
	dw WalkSprite_73_09_Gfx06 ; $5fcd
	dw WalkSprite_73_09_Gfx07 ; $5fcf
Padding_73_09:
	; $5fd1, 15 bytes (fill)
	ds 15, $00
WalkSprite_73_09_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx00.bin" ; $5fe0, 256 bytes
WalkSprite_73_09_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx01.bin" ; $60e0, 256 bytes
WalkSprite_73_09_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx02.bin" ; $61e0, 256 bytes
WalkSprite_73_09_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx03.bin" ; $62e0, 256 bytes
WalkSprite_73_09_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx04.bin" ; $63e0, 256 bytes
WalkSprite_73_09_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx05.bin" ; $64e0, 256 bytes
WalkSprite_73_09_Gfx06:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx06.bin" ; $65e0, 256 bytes
WalkSprite_73_09_Gfx07:
	INCBIN "data/bank_073/WalkSprite_73_09_Gfx07.bin" ; $66e0, 256 bytes
WalkSprite_73_09_AnimPtrs:
	dw WalkSprite_73_09_Anim00 ; $67e0
	dw WalkSprite_73_09_Anim01 ; $67e2
	dw WalkSprite_73_09_Anim02 ; $67e4
	dw WalkSprite_73_09_Anim03 ; $67e6
	dw WalkSprite_73_09_Anim04 ; $67e8
	dw WalkSprite_73_09_Anim05 ; $67ea
	dw WalkSprite_73_09_Anim05 ; $67ec
	dw WalkSprite_73_09_Anim05 ; $67ee
	dw WalkSprite_73_09_Anim06 ; $67f0
WalkSprite_73_09_Anim00:
	; $67f2, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_09_Anim01:
	; $67f5, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_09_Anim02:
	; $67fb, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_09_Anim03:
	; $6807, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_09_Anim04:
	; $680f, 20 bytes (sprite_anim)
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
WalkSprite_73_09_Anim05:
	; $6823, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_09_Anim06:
	; $682f, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_73_10:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_10_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_10_Gfx00, WalkSprite_73_10_Gfx01, WalkSprite_73_10_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_10_Gfx02 ; $6845
	dw WalkSprite_73_10_Gfx02 ; $6847
	dw WalkSprite_73_10_Gfx02 ; $6849
	dw WalkSprite_73_10_Gfx02 ; $684b
	dw WalkSprite_73_10_Gfx03 ; $684d
	dw WalkSprite_73_10_Gfx04 ; $684f
	dw WalkSprite_73_10_Gfx05 ; $6851
Padding_73_10:
	; $6853, 13 bytes (fill)
	ds 13, $00
WalkSprite_73_10_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx00.bin" ; $6860, 256 bytes
WalkSprite_73_10_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx01.bin" ; $6960, 256 bytes
WalkSprite_73_10_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx02.bin" ; $6a60, 256 bytes
WalkSprite_73_10_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx03.bin" ; $6b60, 256 bytes
WalkSprite_73_10_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx04.bin" ; $6c60, 256 bytes
WalkSprite_73_10_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_10_Gfx05.bin" ; $6d60, 256 bytes
WalkSprite_73_10_AnimPtrs:
	dw WalkSprite_73_10_Anim00 ; $6e60
	dw WalkSprite_73_10_Anim01 ; $6e62
	dw WalkSprite_73_10_Anim02 ; $6e64
	dw WalkSprite_73_10_Anim03 ; $6e66
	dw WalkSprite_73_10_Anim04 ; $6e68
	dw WalkSprite_73_10_Anim05 ; $6e6a
	dw WalkSprite_73_10_Anim05 ; $6e6c
	dw WalkSprite_73_10_Anim05 ; $6e6e
WalkSprite_73_10_Anim00:
	; $6e70, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_10_Anim01:
	; $6e73, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_10_Anim02:
	; $6e79, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_10_Anim03:
	; $6e85, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_10_Anim04:
	; $6e8d, 20 bytes (sprite_anim)
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
WalkSprite_73_10_Anim05:
	; $6ea1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_11:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_11_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_11_Gfx00, WalkSprite_73_11_Gfx01, WalkSprite_73_11_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_11_Gfx02 ; $6ebd
	dw WalkSprite_73_11_Gfx02 ; $6ebf
	dw WalkSprite_73_11_Gfx02 ; $6ec1
	dw WalkSprite_73_11_Gfx02 ; $6ec3
	dw WalkSprite_73_11_Gfx03 ; $6ec5
	dw WalkSprite_73_11_Gfx04 ; $6ec7
	dw WalkSprite_73_11_Gfx05 ; $6ec9
Padding_73_11:
	; $6ecb, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_11_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx00.bin" ; $6ed0, 256 bytes
WalkSprite_73_11_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx01.bin" ; $6fd0, 256 bytes
WalkSprite_73_11_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx02.bin" ; $70d0, 256 bytes
WalkSprite_73_11_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx03.bin" ; $71d0, 256 bytes
WalkSprite_73_11_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx04.bin" ; $72d0, 256 bytes
WalkSprite_73_11_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_11_Gfx05.bin" ; $73d0, 256 bytes
WalkSprite_73_11_AnimPtrs:
	dw WalkSprite_73_11_Anim00 ; $74d0
	dw WalkSprite_73_11_Anim01 ; $74d2
	dw WalkSprite_73_11_Anim02 ; $74d4
	dw WalkSprite_73_11_Anim03 ; $74d6
	dw WalkSprite_73_11_Anim04 ; $74d8
	dw WalkSprite_73_11_Anim05 ; $74da
	dw WalkSprite_73_11_Anim05 ; $74dc
	dw WalkSprite_73_11_Anim05 ; $74de
WalkSprite_73_11_Anim00:
	; $74e0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_11_Anim01:
	; $74e3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_11_Anim02:
	; $74e9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_11_Anim03:
	; $74f5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_11_Anim04:
	; $74fd, 20 bytes (sprite_anim)
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
WalkSprite_73_11_Anim05:
	; $7511, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_12:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_12_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_12_Gfx00, WalkSprite_73_12_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_12:
	; $752d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_12_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_12_Gfx00.bin" ; $7530, 64 bytes
WalkSprite_73_12_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_12_Gfx01.bin" ; $7570, 64 bytes
WalkSprite_73_12_AnimPtrs:
	dw WalkSprite_73_12_Anim00 ; $75b0
	dw WalkSprite_73_12_Anim01 ; $75b2
WalkSprite_73_12_Anim00:
	; $75b4, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_12_Anim01:
	; $75b7, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_13:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_13_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_13_Gfx00, WalkSprite_73_13_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_13:
	; $75cd, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_13_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_13_Gfx00.bin" ; $75d0, 64 bytes
WalkSprite_73_13_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_13_Gfx01.bin" ; $7610, 64 bytes
WalkSprite_73_13_AnimPtrs:
	dw WalkSprite_73_13_Anim00 ; $7650
	dw WalkSprite_73_13_Anim01 ; $7652
WalkSprite_73_13_Anim00:
	; $7654, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_13_Anim01:
	; $7657, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_14:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_14_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_14_Gfx00, WalkSprite_73_14_Gfx01, WalkSprite_73_14_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_73_14_Gfx02 ; $766d
	dw WalkSprite_73_14_Gfx02 ; $766f
	dw WalkSprite_73_14_Gfx02 ; $7671
	dw WalkSprite_73_14_Gfx02 ; $7673
	dw WalkSprite_73_14_Gfx03 ; $7675
	dw WalkSprite_73_14_Gfx04 ; $7677
	dw WalkSprite_73_14_Gfx05 ; $7679
Padding_73_14:
	; $767b, 5 bytes (fill)
	ds 5, $00
WalkSprite_73_14_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx00.bin" ; $7680, 64 bytes
WalkSprite_73_14_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx01.bin" ; $76c0, 64 bytes
WalkSprite_73_14_Gfx02:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx02.bin" ; $7700, 64 bytes
WalkSprite_73_14_Gfx03:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx03.bin" ; $7740, 64 bytes
WalkSprite_73_14_Gfx04:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx04.bin" ; $7780, 64 bytes
WalkSprite_73_14_Gfx05:
	INCBIN "data/bank_073/WalkSprite_73_14_Gfx05.bin" ; $77c0, 64 bytes
WalkSprite_73_14_AnimPtrs:
	dw WalkSprite_73_14_Anim00 ; $7800
	dw WalkSprite_73_14_Anim01 ; $7802
	dw WalkSprite_73_14_Anim02 ; $7804
	dw WalkSprite_73_14_Anim03 ; $7806
	dw WalkSprite_73_14_Anim04 ; $7808
	dw WalkSprite_73_14_Anim05 ; $780a
	dw WalkSprite_73_14_Anim05 ; $780c
	dw WalkSprite_73_14_Anim05 ; $780e
WalkSprite_73_14_Anim00:
	; $7810, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_14_Anim01:
	; $7813, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_14_Anim02:
	; $7819, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_14_Anim03:
	; $7825, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_14_Anim04:
	; $782d, 20 bytes (sprite_anim)
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
WalkSprite_73_14_Anim05:
	; $7841, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_73_15:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_15_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_15_Gfx00, WalkSprite_73_15_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_15:
	; $785d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_15_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_15_Gfx00.bin" ; $7860, 64 bytes
WalkSprite_73_15_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_15_Gfx01.bin" ; $78a0, 64 bytes
WalkSprite_73_15_AnimPtrs:
	dw WalkSprite_73_15_Anim00 ; $78e0
	dw WalkSprite_73_15_Anim01 ; $78e2
WalkSprite_73_15_Anim00:
	; $78e4, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_15_Anim01:
	; $78e7, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_16:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_16_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_16_Gfx00, WalkSprite_73_16_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_16:
	; $78fd, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_16_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_16_Gfx00.bin" ; $7900, 64 bytes
WalkSprite_73_16_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_16_Gfx01.bin" ; $7940, 64 bytes
WalkSprite_73_16_AnimPtrs:
	dw WalkSprite_73_16_Anim00 ; $7980
	dw WalkSprite_73_16_Anim01 ; $7982
WalkSprite_73_16_Anim00:
	; $7984, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_16_Anim01:
	; $7987, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_17:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_17_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_17_Gfx00, WalkSprite_73_17_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_17:
	; $799d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_17_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_17_Gfx00.bin" ; $79a0, 64 bytes
WalkSprite_73_17_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_17_Gfx01.bin" ; $79e0, 64 bytes
WalkSprite_73_17_AnimPtrs:
	dw WalkSprite_73_17_Anim00 ; $7a20
	dw WalkSprite_73_17_Anim01 ; $7a22
WalkSprite_73_17_Anim00:
	; $7a24, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_17_Anim01:
	; $7a27, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_18:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_18_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_18_Gfx00, WalkSprite_73_18_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_18:
	; $7a3d, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_18_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_18_Gfx00.bin" ; $7a40, 64 bytes
WalkSprite_73_18_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_18_Gfx01.bin" ; $7a80, 64 bytes
WalkSprite_73_18_AnimPtrs:
	dw WalkSprite_73_18_Anim00 ; $7ac0
	dw WalkSprite_73_18_Anim01 ; $7ac2
WalkSprite_73_18_Anim00:
	; $7ac4, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_18_Anim01:
	; $7ac7, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_73_19:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_73_19_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_73_19_Gfx00, WalkSprite_73_19_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_19:
	; $7add, 3 bytes (fill)
	ds 3, $00
WalkSprite_73_19_Gfx00:
	INCBIN "data/bank_073/WalkSprite_73_19_Gfx00.bin" ; $7ae0, 64 bytes
WalkSprite_73_19_Gfx01:
	INCBIN "data/bank_073/WalkSprite_73_19_Gfx01.bin" ; $7b20, 64 bytes
WalkSprite_73_19_AnimPtrs:
	dw WalkSprite_73_19_Anim00 ; $7b60
	dw WalkSprite_73_19_Anim01 ; $7b62
WalkSprite_73_19_Anim00:
	; $7b64, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_73_19_Anim01:
	; $7b67, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
	; $7b6d, 1171 bytes fill to bank end (linker-padded)
