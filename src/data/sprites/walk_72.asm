DataPtr_JuniorCoachWalkSprite:
	dw JuniorCoachWalkSprite ; $4000
DataPtr_WalkSprite_72_01:
	dw WalkSprite_72_01 ; $4002
DataPtr_StudentSidePartBoyWalkSprite:
	dw StudentSidePartBoyWalkSprite ; $4004
DataPtr_StudentPigtailsGirlWalkSprite:
	dw StudentPigtailsGirlWalkSprite ; $4006
DataPtr_StudentBlackHairBoyWalkSprite:
	dw StudentBlackHairBoyWalkSprite ; $4008
DataPtr_StudentHeadbandBoyWalkSprite:
	dw StudentHeadbandBoyWalkSprite ; $400a
DataPtr_MachineEngineerWalkSprite:
	dw MachineEngineerWalkSprite ; $400c
DataPtr_MachineAttendantWalkSprite:
	dw MachineAttendantWalkSprite ; $400e
DataPtr_ReceptionistWalkSprite:
	dw ReceptionistWalkSprite ; $4010
JuniorCoachWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, JuniorCoachWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw JuniorCoachWalkSprite_Gfx00, JuniorCoachWalkSprite_Gfx01, JuniorCoachWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw JuniorCoachWalkSprite_Gfx02 ; $4022
	dw JuniorCoachWalkSprite_Gfx02 ; $4024
	dw JuniorCoachWalkSprite_Gfx02 ; $4026
	dw JuniorCoachWalkSprite_Gfx02 ; $4028
	dw JuniorCoachWalkSprite_Gfx03 ; $402a
	dw JuniorCoachWalkSprite_Gfx04 ; $402c
	dw JuniorCoachWalkSprite_Gfx05 ; $402e
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx00:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx00.bin" ; $4030, 256 bytes
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx01:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx01.bin" ; $4130, 256 bytes
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx02:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx02.bin" ; $4230, 256 bytes
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx03:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx03.bin" ; $4330, 256 bytes
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx04:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx04.bin" ; $4430, 256 bytes
	ds ALIGN[4]
JuniorCoachWalkSprite_Gfx05:
	INCBIN "data/sprites/JuniorCoachWalkSprite_Gfx05.bin" ; $4530, 256 bytes
JuniorCoachWalkSprite_AnimPtrs:
	dw JuniorCoachWalkSprite_AnimStill ; $4630
	dw JuniorCoachWalkSprite_AnimWalk ; $4632
	dw JuniorCoachWalkSprite_AnimBounce ; $4634
	dw JuniorCoachWalkSprite_AnimNod ; $4636
	dw JuniorCoachWalkSprite_AnimShake ; $4638
	dw JuniorCoachWalkSprite_Anim05 ; $463a
	dw JuniorCoachWalkSprite_Anim05 ; $463c
	dw JuniorCoachWalkSprite_Anim05 ; $463e
JuniorCoachWalkSprite_AnimStill:
	; $4640, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
JuniorCoachWalkSprite_AnimWalk:
	; $4643, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
JuniorCoachWalkSprite_AnimBounce:
	; $4649, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
JuniorCoachWalkSprite_AnimNod:
	; $4655, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
JuniorCoachWalkSprite_AnimShake:
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
JuniorCoachWalkSprite_Anim05:
	; $4671, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
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
	INCBIN "data/sprites/WalkSprite_72_01_Gfx00.bin" ; $46a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx01:
	INCBIN "data/sprites/WalkSprite_72_01_Gfx01.bin" ; $47a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx02:
	INCBIN "data/sprites/WalkSprite_72_01_Gfx02.bin" ; $48a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx03:
	INCBIN "data/sprites/WalkSprite_72_01_Gfx03.bin" ; $49a0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx04:
	INCBIN "data/sprites/WalkSprite_72_01_Gfx04.bin" ; $4aa0, 256 bytes
	ds ALIGN[4]
WalkSprite_72_01_Gfx05:
	INCBIN "data/sprites/WalkSprite_72_01_Gfx05.bin" ; $4ba0, 256 bytes
WalkSprite_72_01_AnimPtrs:
	dw WalkSprite_72_01_AnimStill ; $4ca0
	dw WalkSprite_72_01_AnimWalk ; $4ca2
	dw WalkSprite_72_01_AnimBounce ; $4ca4
	dw WalkSprite_72_01_AnimNod ; $4ca6
	dw WalkSprite_72_01_AnimShake ; $4ca8
	dw WalkSprite_72_01_Anim05 ; $4caa
	dw WalkSprite_72_01_Anim05 ; $4cac
	dw WalkSprite_72_01_Anim05 ; $4cae
WalkSprite_72_01_AnimStill:
	; $4cb0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WalkSprite_72_01_AnimWalk:
	; $4cb3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
WalkSprite_72_01_AnimBounce:
	; $4cb9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_72_01_AnimNod:
	; $4cc5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WalkSprite_72_01_AnimShake:
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
WalkSprite_72_01_Anim05:
	; $4ce1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentSidePartBoyWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentSidePartBoyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentSidePartBoyWalkSprite_Gfx00, StudentSidePartBoyWalkSprite_Gfx01, StudentSidePartBoyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentSidePartBoyWalkSprite_Gfx03 ; $4cfd
	dw StudentSidePartBoyWalkSprite_Gfx04 ; $4cff
	dw StudentSidePartBoyWalkSprite_Gfx05 ; $4d01
	dw StudentSidePartBoyWalkSprite_Gfx05 ; $4d03
	dw StudentSidePartBoyWalkSprite_Gfx06 ; $4d05
	dw StudentSidePartBoyWalkSprite_Gfx07 ; $4d07
	dw StudentSidePartBoyWalkSprite_Gfx08 ; $4d09
Padding_72_1:
	; $4d0b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx00.bin" ; $4d10, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx01.bin" ; $4e10, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx02.bin" ; $4f10, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx03.bin" ; $5010, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx04.bin" ; $5110, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx05.bin" ; $5210, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx06:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx06.bin" ; $5310, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx07:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx07.bin" ; $5410, 256 bytes
	ds ALIGN[4]
StudentSidePartBoyWalkSprite_Gfx08:
	INCBIN "data/sprites/StudentSidePartBoyWalkSprite_Gfx08.bin" ; $5510, 256 bytes
StudentSidePartBoyWalkSprite_AnimPtrs:
	dw StudentSidePartBoyWalkSprite_AnimStill ; $5610
	dw StudentSidePartBoyWalkSprite_AnimWalk ; $5612
	dw StudentSidePartBoyWalkSprite_AnimBounce ; $5614
	dw StudentSidePartBoyWalkSprite_AnimNod ; $5616
	dw StudentSidePartBoyWalkSprite_AnimShake ; $5618
	dw StudentSidePartBoyWalkSprite_Anim05 ; $561a
	dw StudentSidePartBoyWalkSprite_Anim06 ; $561c
	dw StudentSidePartBoyWalkSprite_Anim07 ; $561e
StudentSidePartBoyWalkSprite_AnimStill:
	; $5620, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentSidePartBoyWalkSprite_AnimWalk:
	; $5623, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentSidePartBoyWalkSprite_AnimBounce:
	; $5629, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentSidePartBoyWalkSprite_AnimNod:
	; $5635, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentSidePartBoyWalkSprite_AnimShake:
	; $563d, 20 bytes (sprite_anim)
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
StudentSidePartBoyWalkSprite_Anim05:
	; $5651, 8 bytes (sprite_anim)
	anim_frame $00, 20
	anim_frame $02, 10
	anim_frame $01, 30
	anim_hold $fd
	db $00 ; never read: the hold above ends the script
StudentSidePartBoyWalkSprite_Anim06:
	; $5659, 5 bytes (sprite_anim)
	anim_frame $03, 40
	anim_frame $04, 70
	db $ff ; anim_loop whose operand is the next script's first byte ($00)
StudentSidePartBoyWalkSprite_Anim07:
	; $565e, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPigtailsGirlWalkSprite:
	db $06, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentPigtailsGirlWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentPigtailsGirlWalkSprite_Gfx00, StudentPigtailsGirlWalkSprite_Gfx01, StudentPigtailsGirlWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentPigtailsGirlWalkSprite_Gfx02 ; $567a
	dw StudentPigtailsGirlWalkSprite_Gfx02 ; $567c
	dw StudentPigtailsGirlWalkSprite_Gfx02 ; $567e
	dw StudentPigtailsGirlWalkSprite_Gfx02 ; $5680
	dw StudentPigtailsGirlWalkSprite_Gfx03 ; $5682
	dw StudentPigtailsGirlWalkSprite_Gfx04 ; $5684
	dw StudentPigtailsGirlWalkSprite_Gfx05 ; $5686
Padding_72_2:
	; $5688, 8 bytes (fill)
	ds 8, $00
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx00.bin" ; $5690, 256 bytes
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx01.bin" ; $5790, 256 bytes
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx02.bin" ; $5890, 256 bytes
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx03.bin" ; $5990, 256 bytes
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx04.bin" ; $5a90, 256 bytes
	ds ALIGN[4]
StudentPigtailsGirlWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentPigtailsGirlWalkSprite_Gfx05.bin" ; $5b90, 256 bytes
StudentPigtailsGirlWalkSprite_AnimPtrs:
	dw StudentPigtailsGirlWalkSprite_AnimStill ; $5c90
	dw StudentPigtailsGirlWalkSprite_AnimWalk ; $5c92
	dw StudentPigtailsGirlWalkSprite_AnimBounce ; $5c94
	dw StudentPigtailsGirlWalkSprite_AnimNod ; $5c96
	dw StudentPigtailsGirlWalkSprite_AnimShake ; $5c98
	dw StudentPigtailsGirlWalkSprite_Anim05 ; $5c9a
	dw StudentPigtailsGirlWalkSprite_Anim05 ; $5c9c
	dw StudentPigtailsGirlWalkSprite_Anim05 ; $5c9e
StudentPigtailsGirlWalkSprite_AnimStill:
	; $5ca0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentPigtailsGirlWalkSprite_AnimWalk:
	; $5ca3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentPigtailsGirlWalkSprite_AnimBounce:
	; $5ca9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPigtailsGirlWalkSprite_AnimNod:
	; $5cb5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentPigtailsGirlWalkSprite_AnimShake:
	; $5cbd, 20 bytes (sprite_anim)
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
StudentPigtailsGirlWalkSprite_Anim05:
	; $5cd1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentBlackHairBoyWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentBlackHairBoyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentBlackHairBoyWalkSprite_Gfx00, StudentBlackHairBoyWalkSprite_Gfx01, StudentBlackHairBoyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentBlackHairBoyWalkSprite_Gfx02 ; $5ced
	dw StudentBlackHairBoyWalkSprite_Gfx02 ; $5cef
	dw StudentBlackHairBoyWalkSprite_Gfx02 ; $5cf1
	dw StudentBlackHairBoyWalkSprite_Gfx02 ; $5cf3
	dw StudentBlackHairBoyWalkSprite_Gfx03 ; $5cf5
	dw StudentBlackHairBoyWalkSprite_Gfx04 ; $5cf7
	dw StudentBlackHairBoyWalkSprite_Gfx05 ; $5cf9
Padding_72_3:
	; $5cfb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx00.bin" ; $5d00, 256 bytes
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx01.bin" ; $5e00, 256 bytes
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx02.bin" ; $5f00, 256 bytes
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx03.bin" ; $6000, 256 bytes
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx04.bin" ; $6100, 256 bytes
	ds ALIGN[4]
StudentBlackHairBoyWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentBlackHairBoyWalkSprite_Gfx05.bin" ; $6200, 256 bytes
StudentBlackHairBoyWalkSprite_AnimPtrs:
	dw StudentBlackHairBoyWalkSprite_AnimStill ; $6300
	dw StudentBlackHairBoyWalkSprite_AnimWalk ; $6302
	dw StudentBlackHairBoyWalkSprite_AnimBounce ; $6304
	dw StudentBlackHairBoyWalkSprite_AnimNod ; $6306
	dw StudentBlackHairBoyWalkSprite_AnimShake ; $6308
	dw StudentBlackHairBoyWalkSprite_Anim05 ; $630a
	dw StudentBlackHairBoyWalkSprite_Anim05 ; $630c
	dw StudentBlackHairBoyWalkSprite_Anim05 ; $630e
StudentBlackHairBoyWalkSprite_AnimStill:
	; $6310, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentBlackHairBoyWalkSprite_AnimWalk:
	; $6313, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentBlackHairBoyWalkSprite_AnimBounce:
	; $6319, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentBlackHairBoyWalkSprite_AnimNod:
	; $6325, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentBlackHairBoyWalkSprite_AnimShake:
	; $632d, 20 bytes (sprite_anim)
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
StudentBlackHairBoyWalkSprite_Anim05:
	; $6341, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentHeadbandBoyWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, StudentHeadbandBoyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw StudentHeadbandBoyWalkSprite_Gfx00, StudentHeadbandBoyWalkSprite_Gfx01, StudentHeadbandBoyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw StudentHeadbandBoyWalkSprite_Gfx02 ; $635d
	dw StudentHeadbandBoyWalkSprite_Gfx02 ; $635f
	dw StudentHeadbandBoyWalkSprite_Gfx02 ; $6361
	dw StudentHeadbandBoyWalkSprite_Gfx02 ; $6363
	dw StudentHeadbandBoyWalkSprite_Gfx03 ; $6365
	dw StudentHeadbandBoyWalkSprite_Gfx04 ; $6367
	dw StudentHeadbandBoyWalkSprite_Gfx05 ; $6369
Padding_72_4:
	; $636b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx00:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx00.bin" ; $6370, 256 bytes
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx01:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx01.bin" ; $6470, 256 bytes
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx02:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx02.bin" ; $6570, 256 bytes
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx03:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx03.bin" ; $6670, 256 bytes
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx04:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx04.bin" ; $6770, 256 bytes
	ds ALIGN[4]
StudentHeadbandBoyWalkSprite_Gfx05:
	INCBIN "data/sprites/StudentHeadbandBoyWalkSprite_Gfx05.bin" ; $6870, 256 bytes
StudentHeadbandBoyWalkSprite_AnimPtrs:
	dw StudentHeadbandBoyWalkSprite_AnimStill ; $6970
	dw StudentHeadbandBoyWalkSprite_AnimWalk ; $6972
	dw StudentHeadbandBoyWalkSprite_AnimBounce ; $6974
	dw StudentHeadbandBoyWalkSprite_AnimNod ; $6976
	dw StudentHeadbandBoyWalkSprite_AnimShake ; $6978
	dw StudentHeadbandBoyWalkSprite_Anim05 ; $697a
	dw StudentHeadbandBoyWalkSprite_Anim05 ; $697c
	dw StudentHeadbandBoyWalkSprite_Anim05 ; $697e
StudentHeadbandBoyWalkSprite_AnimStill:
	; $6980, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
StudentHeadbandBoyWalkSprite_AnimWalk:
	; $6983, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
StudentHeadbandBoyWalkSprite_AnimBounce:
	; $6989, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentHeadbandBoyWalkSprite_AnimNod:
	; $6995, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
StudentHeadbandBoyWalkSprite_AnimShake:
	; $699d, 20 bytes (sprite_anim)
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
StudentHeadbandBoyWalkSprite_Anim05:
	; $69b1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineEngineerWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MachineEngineerWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MachineEngineerWalkSprite_Gfx00, MachineEngineerWalkSprite_Gfx01, MachineEngineerWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MachineEngineerWalkSprite_Gfx02 ; $69cd
	dw MachineEngineerWalkSprite_Gfx02 ; $69cf
	dw MachineEngineerWalkSprite_Gfx02 ; $69d1
	dw MachineEngineerWalkSprite_Gfx02 ; $69d3
	dw MachineEngineerWalkSprite_Gfx03 ; $69d5
	dw MachineEngineerWalkSprite_Gfx04 ; $69d7
	dw MachineEngineerWalkSprite_Gfx05 ; $69d9
Padding_72_5:
	; $69db, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx00:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx00.bin" ; $69e0, 256 bytes
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx01:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx01.bin" ; $6ae0, 256 bytes
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx02:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx02.bin" ; $6be0, 256 bytes
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx03:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx03.bin" ; $6ce0, 256 bytes
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx04:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx04.bin" ; $6de0, 256 bytes
	ds ALIGN[4]
MachineEngineerWalkSprite_Gfx05:
	INCBIN "data/sprites/MachineEngineerWalkSprite_Gfx05.bin" ; $6ee0, 256 bytes
MachineEngineerWalkSprite_AnimPtrs:
	dw MachineEngineerWalkSprite_AnimStill ; $6fe0
	dw MachineEngineerWalkSprite_AnimWalk ; $6fe2
	dw MachineEngineerWalkSprite_AnimBounce ; $6fe4
	dw MachineEngineerWalkSprite_AnimNod ; $6fe6
	dw MachineEngineerWalkSprite_AnimShake ; $6fe8
	dw MachineEngineerWalkSprite_Anim05 ; $6fea
	dw MachineEngineerWalkSprite_Anim05 ; $6fec
	dw MachineEngineerWalkSprite_Anim05 ; $6fee
MachineEngineerWalkSprite_AnimStill:
	; $6ff0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MachineEngineerWalkSprite_AnimWalk:
	; $6ff3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MachineEngineerWalkSprite_AnimBounce:
	; $6ff9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineEngineerWalkSprite_AnimNod:
	; $7005, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineEngineerWalkSprite_AnimShake:
	; $700d, 20 bytes (sprite_anim)
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
MachineEngineerWalkSprite_Anim05:
	; $7021, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineAttendantWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MachineAttendantWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MachineAttendantWalkSprite_Gfx00, MachineAttendantWalkSprite_Gfx01, MachineAttendantWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MachineAttendantWalkSprite_Gfx02 ; $703d
	dw MachineAttendantWalkSprite_Gfx02 ; $703f
	dw MachineAttendantWalkSprite_Gfx02 ; $7041
	dw MachineAttendantWalkSprite_Gfx02 ; $7043
	dw MachineAttendantWalkSprite_Gfx03 ; $7045
	dw MachineAttendantWalkSprite_Gfx04 ; $7047
	dw MachineAttendantWalkSprite_Gfx05 ; $7049
Padding_72_6:
	; $704b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx00:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx00.bin" ; $7050, 256 bytes
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx01:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx01.bin" ; $7150, 256 bytes
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx02:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx02.bin" ; $7250, 256 bytes
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx03:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx03.bin" ; $7350, 256 bytes
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx04:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx04.bin" ; $7450, 256 bytes
	ds ALIGN[4]
MachineAttendantWalkSprite_Gfx05:
	INCBIN "data/sprites/MachineAttendantWalkSprite_Gfx05.bin" ; $7550, 256 bytes
MachineAttendantWalkSprite_AnimPtrs:
	dw MachineAttendantWalkSprite_AnimStill ; $7650
	dw MachineAttendantWalkSprite_AnimWalk ; $7652
	dw MachineAttendantWalkSprite_AnimBounce ; $7654
	dw MachineAttendantWalkSprite_AnimNod ; $7656
	dw MachineAttendantWalkSprite_AnimShake ; $7658
	dw MachineAttendantWalkSprite_Anim05 ; $765a
	dw MachineAttendantWalkSprite_Anim05 ; $765c
	dw MachineAttendantWalkSprite_Anim05 ; $765e
MachineAttendantWalkSprite_AnimStill:
	; $7660, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MachineAttendantWalkSprite_AnimWalk:
	; $7663, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MachineAttendantWalkSprite_AnimBounce:
	; $7669, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineAttendantWalkSprite_AnimNod:
	; $7675, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MachineAttendantWalkSprite_AnimShake:
	; $767d, 20 bytes (sprite_anim)
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
MachineAttendantWalkSprite_Anim05:
	; $7691, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ReceptionistWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, ReceptionistWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw ReceptionistWalkSprite_Gfx00, ReceptionistWalkSprite_Gfx01, ReceptionistWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw ReceptionistWalkSprite_Gfx02 ; $76ad
	dw ReceptionistWalkSprite_Gfx02 ; $76af
	dw ReceptionistWalkSprite_Gfx02 ; $76b1
	dw ReceptionistWalkSprite_Gfx02 ; $76b3
	dw ReceptionistWalkSprite_Gfx03 ; $76b5
	dw ReceptionistWalkSprite_Gfx04 ; $76b7
	dw ReceptionistWalkSprite_Gfx05 ; $76b9
Padding_72_7:
	; $76bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx00:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx00.bin" ; $76c0, 256 bytes
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx01:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx01.bin" ; $77c0, 256 bytes
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx02:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx02.bin" ; $78c0, 256 bytes
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx03:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx03.bin" ; $79c0, 256 bytes
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx04:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx04.bin" ; $7ac0, 256 bytes
	ds ALIGN[4]
ReceptionistWalkSprite_Gfx05:
	INCBIN "data/sprites/ReceptionistWalkSprite_Gfx05.bin" ; $7bc0, 256 bytes
ReceptionistWalkSprite_AnimPtrs:
	dw ReceptionistWalkSprite_AnimStill ; $7cc0
	dw ReceptionistWalkSprite_AnimWalk ; $7cc2
	dw ReceptionistWalkSprite_AnimBounce ; $7cc4
	dw ReceptionistWalkSprite_AnimNod ; $7cc6
	dw ReceptionistWalkSprite_AnimShake ; $7cc8
	dw ReceptionistWalkSprite_Anim05 ; $7cca
	dw ReceptionistWalkSprite_Anim05 ; $7ccc
	dw ReceptionistWalkSprite_Anim05 ; $7cce
ReceptionistWalkSprite_AnimStill:
	; $7cd0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
ReceptionistWalkSprite_AnimWalk:
	; $7cd3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
ReceptionistWalkSprite_AnimBounce:
	; $7cd9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
ReceptionistWalkSprite_AnimNod:
	; $7ce5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
ReceptionistWalkSprite_AnimShake:
	; $7ced, 20 bytes (sprite_anim)
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
ReceptionistWalkSprite_Anim05:
	; $7d01, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
	; $7d0d, 755 bytes fill to bank end (linker-padded)
