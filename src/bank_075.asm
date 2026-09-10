SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

DataPtr_WalkSprite_75_00:
	dw WalkSprite_75_00 ; $4000
DataPtr_WalkSprite_75_01:
	dw WalkSprite_75_01 ; $4002
DataPtr_WalkSprite_75_02:
	dw WalkSprite_75_02 ; $4004
DataPtr_WalkSprite_75_03:
	dw WalkSprite_75_03 ; $4006
DataPtr_WalkSprite_75_04:
	dw WalkSprite_75_04 ; $4008
DataPtr_WalkSprite_75_05:
	dw WalkSprite_75_05 ; $400a
DataPtr_WalkSprite_75_06:
	dw WalkSprite_75_06 ; $400c
DataPtr_WalkSprite_75_07:
	dw WalkSprite_75_07 ; $400e
DataPtr_WalkSprite_75_08:
	dw WalkSprite_75_08 ; $4010
WalkSprite_75_00:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_00_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_00_Gfx00, WalkSprite_75_00_Gfx01, WalkSprite_75_00_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_00_Gfx02 ; $4022
	dw WalkSprite_75_00_Gfx02 ; $4024
	dw WalkSprite_75_00_Gfx02 ; $4026
	dw WalkSprite_75_00_Gfx02 ; $4028
	dw WalkSprite_75_00_Gfx03 ; $402a
	dw WalkSprite_75_00_Gfx04 ; $402c
	dw WalkSprite_75_00_Gfx05 ; $402e
WalkSprite_75_00_Gfx00:
	INCBIN "data/bank_075/d_4030.bin" ; $4030, 256 bytes
WalkSprite_75_00_Gfx01:
	INCBIN "data/bank_075/d_4130.bin" ; $4130, 256 bytes
WalkSprite_75_00_Gfx02:
	INCBIN "data/bank_075/d_4230.bin" ; $4230, 256 bytes
WalkSprite_75_00_Gfx03:
	INCBIN "data/bank_075/d_4330.bin" ; $4330, 256 bytes
WalkSprite_75_00_Gfx04:
	INCBIN "data/bank_075/d_4430.bin" ; $4430, 256 bytes
WalkSprite_75_00_Gfx05:
	INCBIN "data/bank_075/d_4530.bin" ; $4530, 256 bytes
WalkSprite_75_00_AnimPtrs:
	dw WalkSprite_75_00_Anim00 ; $4630
	dw WalkSprite_75_00_Anim01 ; $4632
	dw WalkSprite_75_00_Anim02 ; $4634
	dw WalkSprite_75_00_Anim03 ; $4636
	dw WalkSprite_75_00_Anim04 ; $4638
	dw WalkSprite_75_00_Anim05 ; $463a
	dw WalkSprite_75_00_Anim05 ; $463c
	dw WalkSprite_75_00_Anim05 ; $463e
WalkSprite_75_00_Anim00:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_00_Anim01:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_00_Anim02:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_00_Anim03:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_00_Anim04:
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
WalkSprite_75_00_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_01:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_01_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_01_Gfx00, WalkSprite_75_01_Gfx01, WalkSprite_75_01_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_01_Gfx02 ; $468d
	dw WalkSprite_75_01_Gfx02 ; $468f
	dw WalkSprite_75_01_Gfx02 ; $4691
	dw WalkSprite_75_01_Gfx02 ; $4693
	dw WalkSprite_75_01_Gfx03 ; $4695
	dw WalkSprite_75_01_Gfx04 ; $4697
	dw WalkSprite_75_01_Gfx05 ; $4699
Padding_75_0:
	; $469b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_01_Gfx00:
	INCBIN "data/bank_075/d_46a0.bin" ; $46a0, 256 bytes
WalkSprite_75_01_Gfx01:
	INCBIN "data/bank_075/d_47a0.bin" ; $47a0, 256 bytes
WalkSprite_75_01_Gfx02:
	INCBIN "data/bank_075/d_48a0.bin" ; $48a0, 256 bytes
WalkSprite_75_01_Gfx03:
	INCBIN "data/bank_075/d_49a0.bin" ; $49a0, 256 bytes
WalkSprite_75_01_Gfx04:
	INCBIN "data/bank_075/d_4aa0.bin" ; $4aa0, 256 bytes
WalkSprite_75_01_Gfx05:
	INCBIN "data/bank_075/d_4ba0.bin" ; $4ba0, 256 bytes
WalkSprite_75_01_AnimPtrs:
	dw WalkSprite_75_01_Anim00 ; $4ca0
	dw WalkSprite_75_01_Anim01 ; $4ca2
	dw WalkSprite_75_01_Anim02 ; $4ca4
	dw WalkSprite_75_01_Anim03 ; $4ca6
	dw WalkSprite_75_01_Anim04 ; $4ca8
	dw WalkSprite_75_01_Anim05 ; $4caa
	dw WalkSprite_75_01_Anim05 ; $4cac
	dw WalkSprite_75_01_Anim05 ; $4cae
WalkSprite_75_01_Anim00:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_01_Anim01:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_01_Anim02:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_01_Anim03:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_01_Anim04:
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
WalkSprite_75_01_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_02:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_02_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_02_Gfx00, WalkSprite_75_02_Gfx01, WalkSprite_75_02_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_02_Gfx02 ; $4cfd
	dw WalkSprite_75_02_Gfx02 ; $4cff
	dw WalkSprite_75_02_Gfx02 ; $4d01
	dw WalkSprite_75_02_Gfx02 ; $4d03
	dw WalkSprite_75_02_Gfx03 ; $4d05
	dw WalkSprite_75_02_Gfx04 ; $4d07
	dw WalkSprite_75_02_Gfx05 ; $4d09
Padding_75_1:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_02_Gfx00:
	INCBIN "data/bank_075/d_4d10.bin" ; $4d10, 256 bytes
WalkSprite_75_02_Gfx01:
	INCBIN "data/bank_075/d_4e10.bin" ; $4e10, 256 bytes
WalkSprite_75_02_Gfx02:
	INCBIN "data/bank_075/d_4f10.bin" ; $4f10, 256 bytes
WalkSprite_75_02_Gfx03:
	INCBIN "data/bank_075/d_5010.bin" ; $5010, 256 bytes
WalkSprite_75_02_Gfx04:
	INCBIN "data/bank_075/d_5110.bin" ; $5110, 256 bytes
WalkSprite_75_02_Gfx05:
	INCBIN "data/bank_075/d_5210.bin" ; $5210, 256 bytes
WalkSprite_75_02_AnimPtrs:
	dw WalkSprite_75_02_Anim00 ; $5310
	dw WalkSprite_75_02_Anim01 ; $5312
	dw WalkSprite_75_02_Anim02 ; $5314
	dw WalkSprite_75_02_Anim03 ; $5316
	dw WalkSprite_75_02_Anim04 ; $5318
	dw WalkSprite_75_02_Anim05 ; $531a
	dw WalkSprite_75_02_Anim05 ; $531c
	dw WalkSprite_75_02_Anim05 ; $531e
WalkSprite_75_02_Anim00:
	; $5320, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_02_Anim01:
	; $5323, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_02_Anim02:
	; $5329, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_02_Anim03:
	; $5335, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_02_Anim04:
	; $533d, 20 bytes (sprite_anim)
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
WalkSprite_75_02_Anim05:
	; $5351, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_03:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_03_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_03_Gfx00, WalkSprite_75_03_Gfx01, WalkSprite_75_03_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_03_Gfx02 ; $536d
	dw WalkSprite_75_03_Gfx02 ; $536f
	dw WalkSprite_75_03_Gfx02 ; $5371
	dw WalkSprite_75_03_Gfx02 ; $5373
	dw WalkSprite_75_03_Gfx03 ; $5375
	dw WalkSprite_75_03_Gfx04 ; $5377
	dw WalkSprite_75_03_Gfx05 ; $5379
Padding_75_2:
	; $537b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_03_Gfx00:
	INCBIN "data/bank_075/d_5380.bin" ; $5380, 256 bytes
WalkSprite_75_03_Gfx01:
	INCBIN "data/bank_075/d_5480.bin" ; $5480, 256 bytes
WalkSprite_75_03_Gfx02:
	INCBIN "data/bank_075/d_5580.bin" ; $5580, 256 bytes
WalkSprite_75_03_Gfx03:
	INCBIN "data/bank_075/d_5680.bin" ; $5680, 256 bytes
WalkSprite_75_03_Gfx04:
	INCBIN "data/bank_075/d_5780.bin" ; $5780, 256 bytes
WalkSprite_75_03_Gfx05:
	INCBIN "data/bank_075/d_5880.bin" ; $5880, 256 bytes
WalkSprite_75_03_AnimPtrs:
	dw WalkSprite_75_03_Anim00 ; $5980
	dw WalkSprite_75_03_Anim01 ; $5982
	dw WalkSprite_75_03_Anim02 ; $5984
	dw WalkSprite_75_03_Anim03 ; $5986
	dw WalkSprite_75_03_Anim04 ; $5988
	dw WalkSprite_75_03_Anim05 ; $598a
	dw WalkSprite_75_03_Anim05 ; $598c
	dw WalkSprite_75_03_Anim05 ; $598e
WalkSprite_75_03_Anim00:
	; $5990, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_03_Anim01:
	; $5993, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_03_Anim02:
	; $5999, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_03_Anim03:
	; $59a5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_03_Anim04:
	; $59ad, 20 bytes (sprite_anim)
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
WalkSprite_75_03_Anim05:
	; $59c1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_04:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_04_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_04_Gfx00, WalkSprite_75_04_Gfx01, WalkSprite_75_04_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_04_Gfx02 ; $59dd
	dw WalkSprite_75_04_Gfx02 ; $59df
	dw WalkSprite_75_04_Gfx02 ; $59e1
	dw WalkSprite_75_04_Gfx02 ; $59e3
	dw WalkSprite_75_04_Gfx03 ; $59e5
	dw WalkSprite_75_04_Gfx04 ; $59e7
	dw WalkSprite_75_04_Gfx05 ; $59e9
Padding_75_3:
	; $59eb, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_04_Gfx00:
	INCBIN "data/bank_075/d_59f0.bin" ; $59f0, 256 bytes
WalkSprite_75_04_Gfx01:
	INCBIN "data/bank_075/d_5af0.bin" ; $5af0, 256 bytes
WalkSprite_75_04_Gfx02:
	INCBIN "data/bank_075/d_5bf0.bin" ; $5bf0, 256 bytes
WalkSprite_75_04_Gfx03:
	INCBIN "data/bank_075/d_5cf0.bin" ; $5cf0, 256 bytes
WalkSprite_75_04_Gfx04:
	INCBIN "data/bank_075/d_5df0.bin" ; $5df0, 256 bytes
WalkSprite_75_04_Gfx05:
	INCBIN "data/bank_075/d_5ef0.bin" ; $5ef0, 256 bytes
WalkSprite_75_04_AnimPtrs:
	dw WalkSprite_75_04_Anim00 ; $5ff0
	dw WalkSprite_75_04_Anim01 ; $5ff2
	dw WalkSprite_75_04_Anim02 ; $5ff4
	dw WalkSprite_75_04_Anim03 ; $5ff6
	dw WalkSprite_75_04_Anim04 ; $5ff8
	dw WalkSprite_75_04_Anim05 ; $5ffa
	dw WalkSprite_75_04_Anim05 ; $5ffc
	dw WalkSprite_75_04_Anim05 ; $5ffe
WalkSprite_75_04_Anim00:
	; $6000, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_04_Anim01:
	; $6003, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_04_Anim02:
	; $6009, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_04_Anim03:
	; $6015, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_04_Anim04:
	; $601d, 20 bytes (sprite_anim)
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
WalkSprite_75_04_Anim05:
	; $6031, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_05:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_05_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_05_Gfx00, WalkSprite_75_05_Gfx01, WalkSprite_75_05_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_05_Gfx02 ; $604d
	dw WalkSprite_75_05_Gfx02 ; $604f
	dw WalkSprite_75_05_Gfx02 ; $6051
	dw WalkSprite_75_05_Gfx02 ; $6053
	dw WalkSprite_75_05_Gfx03 ; $6055
	dw WalkSprite_75_05_Gfx04 ; $6057
	dw WalkSprite_75_05_Gfx05 ; $6059
Padding_75_4:
	; $605b, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_05_Gfx00:
	INCBIN "data/bank_075/d_6060.bin" ; $6060, 256 bytes
WalkSprite_75_05_Gfx01:
	INCBIN "data/bank_075/d_6160.bin" ; $6160, 256 bytes
WalkSprite_75_05_Gfx02:
	INCBIN "data/bank_075/d_6260.bin" ; $6260, 256 bytes
WalkSprite_75_05_Gfx03:
	INCBIN "data/bank_075/d_6360.bin" ; $6360, 256 bytes
WalkSprite_75_05_Gfx04:
	INCBIN "data/bank_075/d_6460.bin" ; $6460, 256 bytes
WalkSprite_75_05_Gfx05:
	INCBIN "data/bank_075/d_6560.bin" ; $6560, 256 bytes
WalkSprite_75_05_AnimPtrs:
	dw WalkSprite_75_05_Anim00 ; $6660
	dw WalkSprite_75_05_Anim01 ; $6662
	dw WalkSprite_75_05_Anim02 ; $6664
	dw WalkSprite_75_05_Anim03 ; $6666
	dw WalkSprite_75_05_Anim04 ; $6668
	dw WalkSprite_75_05_Anim05 ; $666a
	dw WalkSprite_75_05_Anim05 ; $666c
	dw WalkSprite_75_05_Anim05 ; $666e
WalkSprite_75_05_Anim00:
	; $6670, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_05_Anim01:
	; $6673, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_05_Anim02:
	; $6679, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_05_Anim03:
	; $6685, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_05_Anim04:
	; $668d, 20 bytes (sprite_anim)
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
WalkSprite_75_05_Anim05:
	; $66a1, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_06:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_06_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_06_Gfx00, WalkSprite_75_06_Gfx01, WalkSprite_75_06_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_06_Gfx02 ; $66bd
	dw WalkSprite_75_06_Gfx02 ; $66bf
	dw WalkSprite_75_06_Gfx02 ; $66c1
	dw WalkSprite_75_06_Gfx02 ; $66c3
	dw WalkSprite_75_06_Gfx03 ; $66c5
	dw WalkSprite_75_06_Gfx04 ; $66c7
	dw WalkSprite_75_06_Gfx05 ; $66c9
	dw WalkSprite_75_06_AnimPtrs ; $66cb
Padding_75_5:
	; $66cd, 3 bytes (fill)
	ds 3, $00
WalkSprite_75_06_Gfx00:
	INCBIN "data/bank_075/d_66d0.bin" ; $66d0, 256 bytes
WalkSprite_75_06_Gfx01:
	INCBIN "data/bank_075/d_67d0.bin" ; $67d0, 256 bytes
WalkSprite_75_06_Gfx02:
	INCBIN "data/bank_075/d_68d0.bin" ; $68d0, 256 bytes
WalkSprite_75_06_Gfx03:
	INCBIN "data/bank_075/d_69d0.bin" ; $69d0, 256 bytes
WalkSprite_75_06_Gfx04:
	INCBIN "data/bank_075/d_6ad0.bin" ; $6ad0, 256 bytes
WalkSprite_75_06_Gfx05:
	INCBIN "data/bank_075/d_6bd0.bin" ; $6bd0, 256 bytes
WalkSprite_75_06_AnimPtrs:
	dw WalkSprite_75_06_Anim00 ; $6cd0
	dw WalkSprite_75_06_Anim01 ; $6cd2
	dw WalkSprite_75_06_Anim02 ; $6cd4
	dw WalkSprite_75_06_Anim03 ; $6cd6
	dw WalkSprite_75_06_Anim04 ; $6cd8
	dw WalkSprite_75_06_Anim05 ; $6cda
	dw WalkSprite_75_06_Anim06 ; $6cdc
	dw WalkSprite_75_06_Anim06 ; $6cde
	dw WalkSprite_75_06_Anim07 ; $6ce0
WalkSprite_75_06_Anim00:
	; $6ce2, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_06_Anim01:
	; $6ce5, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_06_Anim02:
	; $6ceb, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_06_Anim03:
	; $6cf7, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_06_Anim04:
	; $6cff, 20 bytes (sprite_anim)
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
WalkSprite_75_06_Anim05:
	; $6d13, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $0a
	anim_set $01
WalkSprite_75_06_Anim06:
	; $6d19, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_06_Anim07:
	; $6d25, 6 bytes (sprite_anim)
	anim_frame $0b, $1e
	anim_frame $0c, $1e
	anim_loop $00
WalkSprite_75_07:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_07_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_07_Gfx00, WalkSprite_75_07_Gfx01, WalkSprite_75_07_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_07_Gfx02 ; $6d3b
	dw WalkSprite_75_07_Gfx02 ; $6d3d
	dw WalkSprite_75_07_Gfx02 ; $6d3f
	dw WalkSprite_75_07_Gfx02 ; $6d41
	dw WalkSprite_75_07_Gfx03 ; $6d43
	dw WalkSprite_75_07_Gfx04 ; $6d45
	dw WalkSprite_75_07_Gfx05 ; $6d47
Padding_75_6:
	; $6d49, 7 bytes (fill)
	ds 7, $00
WalkSprite_75_07_Gfx00:
	INCBIN "data/bank_075/d_6d50.bin" ; $6d50, 256 bytes
WalkSprite_75_07_Gfx01:
	INCBIN "data/bank_075/d_6e50.bin" ; $6e50, 256 bytes
WalkSprite_75_07_Gfx02:
	INCBIN "data/bank_075/d_6f50.bin" ; $6f50, 256 bytes
WalkSprite_75_07_Gfx03:
	INCBIN "data/bank_075/d_7050.bin" ; $7050, 256 bytes
WalkSprite_75_07_Gfx04:
	INCBIN "data/bank_075/d_7150.bin" ; $7150, 256 bytes
WalkSprite_75_07_Gfx05:
	INCBIN "data/bank_075/d_7250.bin" ; $7250, 256 bytes
WalkSprite_75_07_AnimPtrs:
	dw WalkSprite_75_07_Anim00 ; $7350
	dw WalkSprite_75_07_Anim01 ; $7352
	dw WalkSprite_75_07_Anim02 ; $7354
	dw WalkSprite_75_07_Anim03 ; $7356
	dw WalkSprite_75_07_Anim04 ; $7358
	dw WalkSprite_75_07_Anim05 ; $735a
	dw WalkSprite_75_07_Anim05 ; $735c
	dw WalkSprite_75_07_Anim05 ; $735e
WalkSprite_75_07_Anim00:
	; $7360, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_07_Anim01:
	; $7363, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_07_Anim02:
	; $7369, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_07_Anim03:
	; $7375, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_07_Anim04:
	; $737d, 20 bytes (sprite_anim)
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
WalkSprite_75_07_Anim05:
	; $7391, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_08:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WalkSprite_75_08_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WalkSprite_75_08_Gfx00, WalkSprite_75_08_Gfx01, WalkSprite_75_08_Gfx02 ; frame pointers (continue in body)
	dw WalkSprite_75_08_Gfx03 ; $73ad
	dw WalkSprite_75_08_Gfx04 ; $73af
	dw WalkSprite_75_08_Gfx05 ; $73b1
	dw WalkSprite_75_08_Gfx06 ; $73b3
	dw WalkSprite_75_08_Gfx07 ; $73b5
	dw WalkSprite_75_08_Gfx08 ; $73b7
	dw WalkSprite_75_08_Gfx09 ; $73b9
Padding_75_7:
	; $73bb, 5 bytes (fill)
	ds 5, $00
WalkSprite_75_08_Gfx00:
	INCBIN "data/bank_075/d_73c0.bin" ; $73c0, 256 bytes
WalkSprite_75_08_Gfx01:
	INCBIN "data/bank_075/d_74c0.bin" ; $74c0, 256 bytes
WalkSprite_75_08_Gfx02:
	INCBIN "data/bank_075/d_75c0.bin" ; $75c0, 256 bytes
WalkSprite_75_08_Gfx03:
	INCBIN "data/bank_075/d_76c0.bin" ; $76c0, 256 bytes
WalkSprite_75_08_Gfx04:
	INCBIN "data/bank_075/d_77c0.bin" ; $77c0, 256 bytes
WalkSprite_75_08_Gfx05:
	INCBIN "data/bank_075/d_78c0.bin" ; $78c0, 256 bytes
WalkSprite_75_08_Gfx06:
	INCBIN "data/bank_075/d_79c0.bin" ; $79c0, 256 bytes
WalkSprite_75_08_Gfx07:
	INCBIN "data/bank_075/d_7ac0.bin" ; $7ac0, 256 bytes
WalkSprite_75_08_Gfx08:
	INCBIN "data/bank_075/d_7bc0.bin" ; $7bc0, 256 bytes
WalkSprite_75_08_Gfx09:
	INCBIN "data/bank_075/d_7cc0.bin" ; $7cc0, 256 bytes
WalkSprite_75_08_AnimPtrs:
	dw WalkSprite_75_08_Anim00 ; $7dc0
	dw WalkSprite_75_08_Anim01 ; $7dc2
	dw WalkSprite_75_08_Anim02 ; $7dc4
	dw WalkSprite_75_08_Anim03 ; $7dc6
	dw WalkSprite_75_08_Anim04 ; $7dc8
	dw WalkSprite_75_08_Anim05 ; $7dca
	dw WalkSprite_75_08_Anim06 ; $7dcc
	dw WalkSprite_75_08_Anim07 ; $7dce
WalkSprite_75_08_Anim00:
	; $7dd0, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
WalkSprite_75_08_Anim01:
	; $7dd3, 6 bytes (sprite_anim)
	anim_frame $00, $1e
	anim_frame $01, $1e
	anim_loop $00
WalkSprite_75_08_Anim02:
	; $7dd9, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_08_Anim03:
	; $7de5, 8 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $06, $1e
	anim_frame $00, $0a
	anim_set $01
WalkSprite_75_08_Anim04:
	; $7ded, 20 bytes (sprite_anim)
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
WalkSprite_75_08_Anim05:
	; $7e01, 8 bytes (sprite_anim)
	db $00
	db $14, $02, $0a, $01, $1e, $fd, $00
WalkSprite_75_08_Anim06:
	; $7e09, 5 bytes (sprite_anim)
	db $03
	db "(", $04, "F", $ff
WalkSprite_75_08_Anim07:
	; $7e0e, 12 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $09, $08
	anim_frame $00, $08
	anim_frame $09, $08
	anim_frame $00, $0a
	anim_set $01
	; $7e1a, 486 bytes fill to bank end (linker-padded)
