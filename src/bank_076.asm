SECTION "ROM Bank $76", ROMX[$4000], BANK[$76]

DataPtr_WalkSprite_76_00:
	dw WalkSprite_76_00 ; $4000
DataPtr_WalkSprite_76_01:
	dw WalkSprite_76_01 ; $4002
DataPtr_WalkSprite_76_02:
	dw WalkSprite_76_02 ; $4004
DataPtr_WalkSprite_76_03:
	dw WalkSprite_76_03 ; $4006
DataPtr_WalkSprite_76_04:
	dw WalkSprite_76_04 ; $4008
DataPtr_WalkSprite_76_05:
	dw WalkSprite_76_05 ; $400a
DataPtr_WalkSprite_76_06:
	dw WalkSprite_76_06 ; $400c
WalkSprite_76_00:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_00_Gfx00, WalkSprite_76_00_Gfx01, WalkSprite_76_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_00_Gfx02 ; $401e
	dw WalkSprite_76_00_Gfx02 ; $4020
	dw WalkSprite_76_00_Gfx02 ; $4022
	dw WalkSprite_76_00_Gfx02 ; $4024
	dw WalkSprite_76_00_Gfx03 ; $4026
	dw WalkSprite_76_00_Gfx04 ; $4028
	dw WalkSprite_76_00_Gfx05 ; $402a
Padding_76_0:
	; $402c, 4 bytes (fill)
	ds 4, $00
WalkSprite_76_00_Gfx00:
	INCBIN "data/bank_076/d_4030.bin" ; $4030, 256 bytes
WalkSprite_76_00_Gfx01:
	INCBIN "data/bank_076/d_4130.bin" ; $4130, 256 bytes
WalkSprite_76_00_Gfx02:
	INCBIN "data/bank_076/d_4230.bin" ; $4230, 256 bytes
WalkSprite_76_00_Gfx03:
	INCBIN "data/bank_076/d_4330.bin" ; $4330, 256 bytes
WalkSprite_76_00_Gfx04:
	INCBIN "data/bank_076/d_4430.bin" ; $4430, 256 bytes
WalkSprite_76_00_Gfx05:
	INCBIN "data/bank_076/d_4530.bin" ; $4530, 256 bytes
WalkSprite_76_00_AnimPtrs:
	dw WalkSprite_76_00_Anim00 ; $4630
	dw WalkSprite_76_00_Anim01 ; $4632
	dw WalkSprite_76_00_Anim02 ; $4634
	dw WalkSprite_76_00_Anim03 ; $4636
	dw WalkSprite_76_00_Anim04 ; $4638
	dw WalkSprite_76_00_Anim05 ; $463a
	dw WalkSprite_76_00_Anim05 ; $463c
	dw WalkSprite_76_00_Anim05 ; $463e
WalkSprite_76_00_Anim00:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_00_Anim01:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_00_Anim02:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_00_Anim03:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_00_Anim04:
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
WalkSprite_76_00_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_01:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_01_Gfx00, WalkSprite_76_01_Gfx01, WalkSprite_76_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_01_Gfx02 ; $468d
	dw WalkSprite_76_01_Gfx02 ; $468f
	dw WalkSprite_76_01_Gfx02 ; $4691
	dw WalkSprite_76_01_Gfx02 ; $4693
	dw WalkSprite_76_01_Gfx03 ; $4695
	dw WalkSprite_76_01_Gfx04 ; $4697
	dw WalkSprite_76_01_Gfx05 ; $4699
Padding_76_1:
	; $469b, 5 bytes (fill)
	ds 5, $00
WalkSprite_76_01_Gfx00:
	INCBIN "data/bank_076/d_46a0.bin" ; $46a0, 256 bytes
WalkSprite_76_01_Gfx01:
	INCBIN "data/bank_076/d_47a0.bin" ; $47a0, 256 bytes
WalkSprite_76_01_Gfx02:
	INCBIN "data/bank_076/d_48a0.bin" ; $48a0, 256 bytes
WalkSprite_76_01_Gfx03:
	INCBIN "data/bank_076/d_49a0.bin" ; $49a0, 256 bytes
WalkSprite_76_01_Gfx04:
	INCBIN "data/bank_076/d_4aa0.bin" ; $4aa0, 256 bytes
WalkSprite_76_01_Gfx05:
	INCBIN "data/bank_076/d_4ba0.bin" ; $4ba0, 256 bytes
WalkSprite_76_01_AnimPtrs:
	dw WalkSprite_76_01_Anim00 ; $4ca0
	dw WalkSprite_76_01_Anim01 ; $4ca2
	dw WalkSprite_76_01_Anim02 ; $4ca4
	dw WalkSprite_76_01_Anim03 ; $4ca6
	dw WalkSprite_76_01_Anim04 ; $4ca8
	dw WalkSprite_76_01_Anim05 ; $4caa
	dw WalkSprite_76_01_Anim05 ; $4cac
	dw WalkSprite_76_01_Anim05 ; $4cae
WalkSprite_76_01_Anim00:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_01_Anim01:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_01_Anim02:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_01_Anim03:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_01_Anim04:
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
WalkSprite_76_01_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_02:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_02_Gfx00, WalkSprite_76_02_Gfx01, WalkSprite_76_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_02_Gfx03 ; $4cfd
	dw WalkSprite_76_02_Gfx04 ; $4cff
	dw WalkSprite_76_02_Gfx05 ; $4d01
	dw WalkSprite_76_02_Gfx06 ; $4d03
	dw WalkSprite_76_02_Gfx07 ; $4d05
	dw WalkSprite_76_02_Gfx08 ; $4d07
	dw WalkSprite_76_02_Gfx09 ; $4d09
Padding_76_2:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
WalkSprite_76_02_Gfx00:
	INCBIN "data/bank_076/d_4d10.bin" ; $4d10, 256 bytes
WalkSprite_76_02_Gfx01:
	INCBIN "data/bank_076/d_4e10.bin" ; $4e10, 256 bytes
WalkSprite_76_02_Gfx02:
	INCBIN "data/bank_076/d_4f10.bin" ; $4f10, 256 bytes
WalkSprite_76_02_Gfx03:
	INCBIN "data/bank_076/d_5010.bin" ; $5010, 256 bytes
WalkSprite_76_02_Gfx04:
	INCBIN "data/bank_076/d_5110.bin" ; $5110, 256 bytes
WalkSprite_76_02_Gfx05:
	INCBIN "data/bank_076/d_5210.bin" ; $5210, 256 bytes
WalkSprite_76_02_Gfx06:
	INCBIN "data/bank_076/d_5310.bin" ; $5310, 256 bytes
WalkSprite_76_02_Gfx07:
	INCBIN "data/bank_076/d_5410.bin" ; $5410, 256 bytes
WalkSprite_76_02_Gfx08:
	INCBIN "data/bank_076/d_5510.bin" ; $5510, 256 bytes
WalkSprite_76_02_Gfx09:
	INCBIN "data/bank_076/d_5610.bin" ; $5610, 256 bytes
WalkSprite_76_02_AnimPtrs:
	dw WalkSprite_76_02_Anim00 ; $5710
	dw WalkSprite_76_02_Anim01 ; $5712
	dw WalkSprite_76_02_Anim02 ; $5714
	dw WalkSprite_76_02_Anim03 ; $5716
	dw WalkSprite_76_02_Anim04 ; $5718
	dw WalkSprite_76_02_Anim05 ; $571a
	dw WalkSprite_76_02_Anim06 ; $571c
	dw WalkSprite_76_02_Anim07 ; $571e
	dw WalkSprite_76_02_Anim08 ; $5720
WalkSprite_76_02_Anim00:
	; $5722, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_02_Anim01:
	; $5725, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_02_Anim02:
	; $572b, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_02_Anim03:
	; $5737, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_02_Anim04:
	; $573f, 20 bytes (sprite_anim)
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
WalkSprite_76_02_Anim05:
	; $5753, 8 bytes (sprite_anim)
	anim_frame $00, $14
	anim_frame $02, $0a
	anim_frame $01, $1e
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
WalkSprite_76_02_Anim06:
	; $575b, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_76_02_Anim07:
	; $5760, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_02_Anim08:
	; $576c, 8 bytes (sprite_anim)
	anim_frame $05, $5a
	anim_frame $03, $03
	anim_frame $04, $5a
	anim_loop $00
WalkSprite_76_03:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_03_Gfx00, WalkSprite_76_03_Gfx01, WalkSprite_76_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_03_Gfx02 ; $5784
	dw WalkSprite_76_03_Gfx02 ; $5786
	dw WalkSprite_76_03_Gfx02 ; $5788
	dw WalkSprite_76_03_Gfx02 ; $578a
	dw WalkSprite_76_03_Gfx03 ; $578c
	dw WalkSprite_76_03_Gfx04 ; $578e
	dw WalkSprite_76_03_Gfx05 ; $5790
Padding_76_3:
	; $5792, 14 bytes (fill)
	ds 14, $00
WalkSprite_76_03_Gfx00:
	INCBIN "data/bank_076/d_57a0.bin" ; $57a0, 256 bytes
WalkSprite_76_03_Gfx01:
	INCBIN "data/bank_076/d_58a0.bin" ; $58a0, 256 bytes
WalkSprite_76_03_Gfx02:
	INCBIN "data/bank_076/d_59a0.bin" ; $59a0, 256 bytes
WalkSprite_76_03_Gfx03:
	INCBIN "data/bank_076/d_5aa0.bin" ; $5aa0, 256 bytes
WalkSprite_76_03_Gfx04:
	INCBIN "data/bank_076/d_5ba0.bin" ; $5ba0, 256 bytes
WalkSprite_76_03_Gfx05:
	INCBIN "data/bank_076/d_5ca0.bin" ; $5ca0, 256 bytes
WalkSprite_76_03_AnimPtrs:
	dw WalkSprite_76_03_Anim00 ; $5da0
	dw WalkSprite_76_03_Anim01 ; $5da2
	dw WalkSprite_76_03_Anim02 ; $5da4
	dw WalkSprite_76_03_Anim03 ; $5da6
	dw WalkSprite_76_03_Anim04 ; $5da8
	dw WalkSprite_76_03_Anim05 ; $5daa
	dw WalkSprite_76_03_Anim05 ; $5dac
	dw WalkSprite_76_03_Anim05 ; $5dae
WalkSprite_76_03_Anim00:
	; $5db0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_03_Anim01:
	; $5db3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_03_Anim02:
	; $5db9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_03_Anim03:
	; $5dc5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_03_Anim04:
	; $5dcd, 20 bytes (sprite_anim)
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
WalkSprite_76_03_Anim05:
	; $5de1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_04:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_04_Gfx00, WalkSprite_76_04_Gfx01, WalkSprite_76_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_04_Gfx03 ; $5dfd
	dw WalkSprite_76_04_Gfx04 ; $5dff
	dw WalkSprite_76_04_Gfx05 ; $5e01
	dw WalkSprite_76_04_Gfx06 ; $5e03
	dw WalkSprite_76_04_Gfx07 ; $5e05
	dw WalkSprite_76_04_Gfx08 ; $5e07
	dw WalkSprite_76_04_Gfx09 ; $5e09
Padding_76_4:
	; $5e0b, 5 bytes (fill)
	ds 5, $00
WalkSprite_76_04_Gfx00:
	INCBIN "data/bank_076/d_5e10.bin" ; $5e10, 256 bytes
WalkSprite_76_04_Gfx01:
	INCBIN "data/bank_076/d_5f10.bin" ; $5f10, 256 bytes
WalkSprite_76_04_Gfx02:
	INCBIN "data/bank_076/d_6010.bin" ; $6010, 256 bytes
WalkSprite_76_04_Gfx03:
	INCBIN "data/bank_076/d_6110.bin" ; $6110, 256 bytes
WalkSprite_76_04_Gfx04:
	INCBIN "data/bank_076/d_6210.bin" ; $6210, 256 bytes
WalkSprite_76_04_Gfx05:
	INCBIN "data/bank_076/d_6310.bin" ; $6310, 256 bytes
WalkSprite_76_04_Gfx06:
	INCBIN "data/bank_076/d_6410.bin" ; $6410, 256 bytes
WalkSprite_76_04_Gfx07:
	INCBIN "data/bank_076/d_6510.bin" ; $6510, 256 bytes
WalkSprite_76_04_Gfx08:
	INCBIN "data/bank_076/d_6610.bin" ; $6610, 256 bytes
WalkSprite_76_04_Gfx09:
	INCBIN "data/bank_076/d_6710.bin" ; $6710, 256 bytes
WalkSprite_76_04_AnimPtrs:
	dw WalkSprite_76_04_Anim00 ; $6810
	dw WalkSprite_76_04_Anim01 ; $6812
	dw WalkSprite_76_04_Anim02 ; $6814
	dw WalkSprite_76_04_Anim03 ; $6816
	dw WalkSprite_76_04_Anim04 ; $6818
	dw WalkSprite_76_04_Anim05 ; $681a
	dw WalkSprite_76_04_Anim06 ; $681c
	dw WalkSprite_76_04_Anim07 ; $681e
WalkSprite_76_04_Anim00:
	; $6820, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_04_Anim01:
	; $6823, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_04_Anim02:
	; $6829, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_04_Anim03:
	; $6835, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_04_Anim04:
	; $683d, 20 bytes (sprite_anim)
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
WalkSprite_76_04_Anim05:
	; $6851, 8 bytes (sprite_anim)
	anim_frame $00, $14
	anim_frame $02, $0a
	anim_frame $01, $1e
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
WalkSprite_76_04_Anim06:
	; $6859, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_76_04_Anim07:
	; $685e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_05:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_05_Gfx00, WalkSprite_76_05_Gfx01, WalkSprite_76_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_05_Gfx03 ; $687a
	dw WalkSprite_76_05_Gfx04 ; $687c
	dw WalkSprite_76_05_Gfx05 ; $687e
	dw WalkSprite_76_05_Gfx06 ; $6880
	dw WalkSprite_76_05_Gfx07 ; $6882
	dw WalkSprite_76_05_Gfx08 ; $6884
	dw WalkSprite_76_05_Gfx09 ; $6886
Padding_76_5:
	; $6888, 8 bytes (fill)
	ds 8, $00
WalkSprite_76_05_Gfx00:
	INCBIN "data/bank_076/d_6890.bin" ; $6890, 256 bytes
WalkSprite_76_05_Gfx01:
	INCBIN "data/bank_076/d_6990.bin" ; $6990, 256 bytes
WalkSprite_76_05_Gfx02:
	INCBIN "data/bank_076/d_6a90.bin" ; $6a90, 256 bytes
WalkSprite_76_05_Gfx03:
	INCBIN "data/bank_076/d_6b90.bin" ; $6b90, 256 bytes
WalkSprite_76_05_Gfx04:
	INCBIN "data/bank_076/d_6c90.bin" ; $6c90, 256 bytes
WalkSprite_76_05_Gfx05:
	INCBIN "data/bank_076/d_6d90.bin" ; $6d90, 256 bytes
WalkSprite_76_05_Gfx06:
	INCBIN "data/bank_076/d_6e90.bin" ; $6e90, 256 bytes
WalkSprite_76_05_Gfx07:
	INCBIN "data/bank_076/d_6f90.bin" ; $6f90, 256 bytes
WalkSprite_76_05_Gfx08:
	INCBIN "data/bank_076/d_7090.bin" ; $7090, 256 bytes
WalkSprite_76_05_Gfx09:
	INCBIN "data/bank_076/d_7190.bin" ; $7190, 256 bytes
WalkSprite_76_05_AnimPtrs:
	dw WalkSprite_76_05_Anim00 ; $7290
	dw WalkSprite_76_05_Anim01 ; $7292
	dw WalkSprite_76_05_Anim02 ; $7294
	dw WalkSprite_76_05_Anim03 ; $7296
	dw WalkSprite_76_05_Anim04 ; $7298
	dw WalkSprite_76_05_Anim05 ; $729a
	dw WalkSprite_76_05_Anim06 ; $729c
	dw WalkSprite_76_05_Anim07 ; $729e
WalkSprite_76_05_Anim00:
	; $72a0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_05_Anim01:
	; $72a3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_76_05_Anim02:
	; $72a9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_05_Anim03:
	; $72b5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_05_Anim04:
	; $72bd, 20 bytes (sprite_anim)
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
WalkSprite_76_05_Anim05:
	; $72d1, 8 bytes (sprite_anim)
	anim_frame $00, $14
	anim_frame $02, $0a
	anim_frame $01, $1e
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
WalkSprite_76_05_Anim06:
	; $72d9, 5 bytes (sprite_anim)
	anim_frame $03, $28
	anim_frame $04, $46
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
WalkSprite_76_05_Anim07:
	; $72de, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_06:
	db $04, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_76_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_76_06_Gfx00, WalkSprite_76_06_Gfx01, WalkSprite_76_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_76_06_Gfx02 ; $72fa
	dw WalkSprite_76_06_Gfx02 ; $72fc
	dw WalkSprite_76_06_Gfx02 ; $72fe
	dw WalkSprite_76_06_Gfx02 ; $7300
	dw WalkSprite_76_06_Gfx03 ; $7302
	dw WalkSprite_76_06_Gfx04 ; $7304
	dw WalkSprite_76_06_Gfx05 ; $7306
Padding_76_6:
	; $7308, 8 bytes (fill)
	ds 8, $00
WalkSprite_76_06_Gfx00:
	INCBIN "data/bank_076/d_7310.bin" ; $7310, 64 bytes
WalkSprite_76_06_Gfx01:
	INCBIN "data/bank_076/d_7350.bin" ; $7350, 64 bytes
WalkSprite_76_06_Gfx02:
	INCBIN "data/bank_076/d_7390.bin" ; $7390, 64 bytes
WalkSprite_76_06_Gfx03:
	INCBIN "data/bank_076/d_73d0.bin" ; $73d0, 64 bytes
WalkSprite_76_06_Gfx04:
	INCBIN "data/bank_076/d_7410.bin" ; $7410, 64 bytes
WalkSprite_76_06_Gfx05:
	INCBIN "data/bank_076/d_7450.bin" ; $7450, 64 bytes
WalkSprite_76_06_AnimPtrs:
	dw WalkSprite_76_06_Anim00 ; $7490
	dw WalkSprite_76_06_Anim01 ; $7492
	dw WalkSprite_76_06_Anim02 ; $7494
	dw WalkSprite_76_06_Anim03 ; $7496
	dw WalkSprite_76_06_Anim04 ; $7498
	dw WalkSprite_76_06_Anim05 ; $749a
	dw WalkSprite_76_06_Anim05 ; $749c
	dw WalkSprite_76_06_Anim05 ; $749e
WalkSprite_76_06_Anim00:
	; $74a0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_76_06_Anim01:
	; $74a3, 6 bytes (sprite_anim)
	anim_frame $00, $46
	anim_frame $01, $28
	anim_loop $00
WalkSprite_76_06_Anim02:
	; $74a9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_06_Anim03:
	; $74b5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_76_06_Anim04:
	; $74bd, 20 bytes (sprite_anim)
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
WalkSprite_76_06_Anim05:
	; $74d1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
	; $74dd, 2851 bytes fill to bank end (linker-padded)
