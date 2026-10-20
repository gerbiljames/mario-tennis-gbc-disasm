DataPtr_AcademyTeacherWalkSprite:
	dw AcademyTeacherWalkSprite ; $4000
DataPtr_OldManWalkSprite:
	dw OldManWalkSprite ; $4002
DataPtr_WeightlifterAWalkSprite:
	dw WeightlifterAWalkSprite ; $4004
DataPtr_SitupsAWalkSprite:
	dw SitupsAWalkSprite ; $4006
DataPtr_SitupsBWalkSprite:
	dw SitupsBWalkSprite ; $4008
DataPtr_WeightlifterBWalkSprite:
	dw WeightlifterBWalkSprite ; $400a
DataPtr_JumpingJacksAWalkSprite:
	dw JumpingJacksAWalkSprite ; $400c
DataPtr_JumpingJacksBWalkSprite:
	dw JumpingJacksBWalkSprite ; $400e
DataPtr_WarioWalkSprite:
	dw WarioWalkSprite ; $4010
DataPtr_EmilyWalkSprite:
	dw EmilyWalkSprite ; $4012
DataPtr_MarkWalkSprite:
	dw MarkWalkSprite ; $4014
DataPtr_KevinWalkSprite:
	dw KevinWalkSprite ; $4016
DataPtr_BalloonExclaimWalkSprite:
	dw BalloonExclaimWalkSprite ; $4018
DataPtr_BalloonQuestionWalkSprite:
	dw BalloonQuestionWalkSprite ; $401a
DataPtr_BalloonAngryWalkSprite:
	dw BalloonAngryWalkSprite ; $401c
DataPtr_BalloonEllipsisWalkSprite:
	dw BalloonEllipsisWalkSprite ; $401e
DataPtr_BalloonScribbleWalkSprite:
	dw BalloonScribbleWalkSprite ; $4020
DataPtr_BalloonMusicWalkSprite:
	dw BalloonMusicWalkSprite ; $4022
DataPtr_BalloonShockWalkSprite:
	dw BalloonShockWalkSprite ; $4024
DataPtr_BalloonSweatWalkSprite:
	dw BalloonSweatWalkSprite ; $4026
AcademyTeacherWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, AcademyTeacherWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw AcademyTeacherWalkSprite_Gfx00, AcademyTeacherWalkSprite_Gfx01, AcademyTeacherWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw AcademyTeacherWalkSprite_Gfx02 ; $4038
	dw AcademyTeacherWalkSprite_Gfx02 ; $403a
	dw AcademyTeacherWalkSprite_Gfx02 ; $403c
	dw AcademyTeacherWalkSprite_Gfx02 ; $403e
	dw AcademyTeacherWalkSprite_Gfx03 ; $4040
	dw AcademyTeacherWalkSprite_Gfx04 ; $4042
	dw AcademyTeacherWalkSprite_Gfx05 ; $4044
Padding_73_00:
	; $4046, 10 bytes (fill)
	ds 10, $00
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx00:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx00.bin" ; $4050, 256 bytes
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx01:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx01.bin" ; $4150, 256 bytes
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx02:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx02.bin" ; $4250, 256 bytes
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx03:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx03.bin" ; $4350, 256 bytes
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx04:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx04.bin" ; $4450, 256 bytes
	ds ALIGN[4]
AcademyTeacherWalkSprite_Gfx05:
	INCBIN "data/sprites/AcademyTeacherWalkSprite_Gfx05.bin" ; $4550, 256 bytes
AcademyTeacherWalkSprite_AnimPtrs:
	dw AcademyTeacherWalkSprite_AnimStill ; $4650
	dw AcademyTeacherWalkSprite_AnimWalk ; $4652
	dw AcademyTeacherWalkSprite_AnimBounce ; $4654
	dw AcademyTeacherWalkSprite_AnimNod ; $4656
	dw AcademyTeacherWalkSprite_AnimShake ; $4658
	dw AcademyTeacherWalkSprite_Anim05 ; $465a
	dw AcademyTeacherWalkSprite_Anim05 ; $465c
	dw AcademyTeacherWalkSprite_Anim05 ; $465e
AcademyTeacherWalkSprite_AnimStill:
	; $4660, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
AcademyTeacherWalkSprite_AnimWalk:
	; $4663, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
AcademyTeacherWalkSprite_AnimBounce:
	; $4669, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
AcademyTeacherWalkSprite_AnimNod:
	; $4675, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
AcademyTeacherWalkSprite_AnimShake:
	; $467d, 20 bytes (sprite_anim)
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
AcademyTeacherWalkSprite_Anim05:
	; $4691, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
OldManWalkSprite:
	db $07, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, OldManWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw OldManWalkSprite_Gfx00, OldManWalkSprite_Gfx01, OldManWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw OldManWalkSprite_Gfx02 ; $46ad
	dw OldManWalkSprite_Gfx02 ; $46af
	dw OldManWalkSprite_Gfx02 ; $46b1
	dw OldManWalkSprite_Gfx02 ; $46b3
	dw OldManWalkSprite_Gfx03 ; $46b5
	dw OldManWalkSprite_Gfx04 ; $46b7
	dw OldManWalkSprite_Gfx05 ; $46b9
Padding_73_01:
	; $46bb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
OldManWalkSprite_Gfx00:
	INCBIN "data/sprites/OldManWalkSprite_Gfx00.bin" ; $46c0, 256 bytes
	ds ALIGN[4]
OldManWalkSprite_Gfx01:
	INCBIN "data/sprites/OldManWalkSprite_Gfx01.bin" ; $47c0, 256 bytes
	ds ALIGN[4]
OldManWalkSprite_Gfx02:
	INCBIN "data/sprites/OldManWalkSprite_Gfx02.bin" ; $48c0, 256 bytes
	ds ALIGN[4]
OldManWalkSprite_Gfx03:
	INCBIN "data/sprites/OldManWalkSprite_Gfx03.bin" ; $49c0, 256 bytes
	ds ALIGN[4]
OldManWalkSprite_Gfx04:
	INCBIN "data/sprites/OldManWalkSprite_Gfx04.bin" ; $4ac0, 256 bytes
	ds ALIGN[4]
OldManWalkSprite_Gfx05:
	INCBIN "data/sprites/OldManWalkSprite_Gfx05.bin" ; $4bc0, 256 bytes
OldManWalkSprite_AnimPtrs:
	dw OldManWalkSprite_AnimStill ; $4cc0
	dw OldManWalkSprite_AnimWalk ; $4cc2
	dw OldManWalkSprite_AnimBounce ; $4cc4
	dw OldManWalkSprite_AnimNod ; $4cc6
	dw OldManWalkSprite_AnimShake ; $4cc8
	dw OldManWalkSprite_Anim05 ; $4cca
	dw OldManWalkSprite_Anim05 ; $4ccc
	dw OldManWalkSprite_Anim05 ; $4cce
OldManWalkSprite_AnimStill:
	; $4cd0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
OldManWalkSprite_AnimWalk:
	; $4cd3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
OldManWalkSprite_AnimBounce:
	; $4cd9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
OldManWalkSprite_AnimNod:
	; $4ce5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
OldManWalkSprite_AnimShake:
	; $4ced, 20 bytes (sprite_anim)
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
OldManWalkSprite_Anim05:
	; $4d01, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterAWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WeightlifterAWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WeightlifterAWalkSprite_Gfx00, WeightlifterAWalkSprite_Gfx01, WeightlifterAWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw WeightlifterAWalkSprite_Gfx02 ; $4d1d
	dw WeightlifterAWalkSprite_Gfx02 ; $4d1f
	dw WeightlifterAWalkSprite_Gfx02 ; $4d21
	dw WeightlifterAWalkSprite_Gfx02 ; $4d23
	dw WeightlifterAWalkSprite_Gfx03 ; $4d25
	dw WeightlifterAWalkSprite_Gfx04 ; $4d27
	dw WeightlifterAWalkSprite_Gfx05 ; $4d29
Padding_73_02:
	; $4d2b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx00:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx00.bin" ; $4d30, 64 bytes
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx01:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx01.bin" ; $4d70, 64 bytes
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx02:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx02.bin" ; $4db0, 64 bytes
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx03:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx03.bin" ; $4df0, 64 bytes
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx04:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx04.bin" ; $4e30, 64 bytes
	ds ALIGN[4]
WeightlifterAWalkSprite_Gfx05:
	INCBIN "data/sprites/WeightlifterAWalkSprite_Gfx05.bin" ; $4e70, 64 bytes
WeightlifterAWalkSprite_AnimPtrs:
	dw WeightlifterAWalkSprite_AnimStill ; $4eb0
	dw WeightlifterAWalkSprite_AnimWalk ; $4eb2
	dw WeightlifterAWalkSprite_AnimBounce ; $4eb4
	dw WeightlifterAWalkSprite_AnimNod ; $4eb6
	dw WeightlifterAWalkSprite_AnimShake ; $4eb8
	dw WeightlifterAWalkSprite_Anim05 ; $4eba
	dw WeightlifterAWalkSprite_Anim05 ; $4ebc
	dw WeightlifterAWalkSprite_Anim05 ; $4ebe
WeightlifterAWalkSprite_AnimStill:
	; $4ec0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WeightlifterAWalkSprite_AnimWalk:
	; $4ec3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
WeightlifterAWalkSprite_AnimBounce:
	; $4ec9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterAWalkSprite_AnimNod:
	; $4ed5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterAWalkSprite_AnimShake:
	; $4edd, 20 bytes (sprite_anim)
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
WeightlifterAWalkSprite_Anim05:
	; $4ef1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsAWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SitupsAWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SitupsAWalkSprite_Gfx00, SitupsAWalkSprite_Gfx01, SitupsAWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SitupsAWalkSprite_Gfx02 ; $4f0d
	dw SitupsAWalkSprite_Gfx02 ; $4f0f
	dw SitupsAWalkSprite_Gfx02 ; $4f11
	dw SitupsAWalkSprite_Gfx02 ; $4f13
	dw SitupsAWalkSprite_Gfx03 ; $4f15
	dw SitupsAWalkSprite_Gfx04 ; $4f17
	dw SitupsAWalkSprite_Gfx05 ; $4f19
Padding_73_03:
	; $4f1b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
SitupsAWalkSprite_Gfx00:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx00.bin" ; $4f20, 64 bytes
	ds ALIGN[4]
SitupsAWalkSprite_Gfx01:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx01.bin" ; $4f60, 64 bytes
	ds ALIGN[4]
SitupsAWalkSprite_Gfx02:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx02.bin" ; $4fa0, 64 bytes
	ds ALIGN[4]
SitupsAWalkSprite_Gfx03:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx03.bin" ; $4fe0, 64 bytes
	ds ALIGN[4]
SitupsAWalkSprite_Gfx04:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx04.bin" ; $5020, 64 bytes
	ds ALIGN[4]
SitupsAWalkSprite_Gfx05:
	INCBIN "data/sprites/SitupsAWalkSprite_Gfx05.bin" ; $5060, 64 bytes
SitupsAWalkSprite_AnimPtrs:
	dw SitupsAWalkSprite_AnimStill ; $50a0
	dw SitupsAWalkSprite_AnimWalk ; $50a2
	dw SitupsAWalkSprite_AnimBounce ; $50a4
	dw SitupsAWalkSprite_AnimNod ; $50a6
	dw SitupsAWalkSprite_AnimShake ; $50a8
	dw SitupsAWalkSprite_Anim05 ; $50aa
	dw SitupsAWalkSprite_Anim05 ; $50ac
	dw SitupsAWalkSprite_Anim05 ; $50ae
SitupsAWalkSprite_AnimStill:
	; $50b0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SitupsAWalkSprite_AnimWalk:
	; $50b3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SitupsAWalkSprite_AnimBounce:
	; $50b9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsAWalkSprite_AnimNod:
	; $50c5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsAWalkSprite_AnimShake:
	; $50cd, 20 bytes (sprite_anim)
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
SitupsAWalkSprite_Anim05:
	; $50e1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsBWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, SitupsBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw SitupsBWalkSprite_Gfx00, SitupsBWalkSprite_Gfx01, SitupsBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw SitupsBWalkSprite_Gfx02 ; $50fd
	dw SitupsBWalkSprite_Gfx02 ; $50ff
	dw SitupsBWalkSprite_Gfx02 ; $5101
	dw SitupsBWalkSprite_Gfx02 ; $5103
	dw SitupsBWalkSprite_Gfx03 ; $5105
	dw SitupsBWalkSprite_Gfx04 ; $5107
	dw SitupsBWalkSprite_Gfx05 ; $5109
Padding_73_04:
	; $510b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
SitupsBWalkSprite_Gfx00:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx00.bin" ; $5110, 64 bytes
	ds ALIGN[4]
SitupsBWalkSprite_Gfx01:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx01.bin" ; $5150, 64 bytes
	ds ALIGN[4]
SitupsBWalkSprite_Gfx02:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx02.bin" ; $5190, 64 bytes
	ds ALIGN[4]
SitupsBWalkSprite_Gfx03:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx03.bin" ; $51d0, 64 bytes
	ds ALIGN[4]
SitupsBWalkSprite_Gfx04:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx04.bin" ; $5210, 64 bytes
	ds ALIGN[4]
SitupsBWalkSprite_Gfx05:
	INCBIN "data/sprites/SitupsBWalkSprite_Gfx05.bin" ; $5250, 64 bytes
SitupsBWalkSprite_AnimPtrs:
	dw SitupsBWalkSprite_AnimStill ; $5290
	dw SitupsBWalkSprite_AnimWalk ; $5292
	dw SitupsBWalkSprite_AnimBounce ; $5294
	dw SitupsBWalkSprite_AnimNod ; $5296
	dw SitupsBWalkSprite_AnimShake ; $5298
	dw SitupsBWalkSprite_Anim05 ; $529a
	dw SitupsBWalkSprite_Anim05 ; $529c
	dw SitupsBWalkSprite_Anim05 ; $529e
SitupsBWalkSprite_AnimStill:
	; $52a0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
SitupsBWalkSprite_AnimWalk:
	; $52a3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
SitupsBWalkSprite_AnimBounce:
	; $52a9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsBWalkSprite_AnimNod:
	; $52b5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
SitupsBWalkSprite_AnimShake:
	; $52bd, 20 bytes (sprite_anim)
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
SitupsBWalkSprite_Anim05:
	; $52d1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterBWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WeightlifterBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WeightlifterBWalkSprite_Gfx00, WeightlifterBWalkSprite_Gfx01, WeightlifterBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw WeightlifterBWalkSprite_Gfx02 ; $52ed
	dw WeightlifterBWalkSprite_Gfx02 ; $52ef
	dw WeightlifterBWalkSprite_Gfx02 ; $52f1
	dw WeightlifterBWalkSprite_Gfx02 ; $52f3
	dw WeightlifterBWalkSprite_Gfx03 ; $52f5
	dw WeightlifterBWalkSprite_Gfx04 ; $52f7
	dw WeightlifterBWalkSprite_Gfx05 ; $52f9
Padding_73_05:
	; $52fb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx00:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx00.bin" ; $5300, 64 bytes
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx01:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx01.bin" ; $5340, 64 bytes
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx02:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx02.bin" ; $5380, 64 bytes
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx03:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx03.bin" ; $53c0, 64 bytes
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx04:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx04.bin" ; $5400, 64 bytes
	ds ALIGN[4]
WeightlifterBWalkSprite_Gfx05:
	INCBIN "data/sprites/WeightlifterBWalkSprite_Gfx05.bin" ; $5440, 64 bytes
WeightlifterBWalkSprite_AnimPtrs:
	dw WeightlifterBWalkSprite_AnimStill ; $5480
	dw WeightlifterBWalkSprite_AnimWalk ; $5482
	dw WeightlifterBWalkSprite_AnimBounce ; $5484
	dw WeightlifterBWalkSprite_AnimNod ; $5486
	dw WeightlifterBWalkSprite_AnimShake ; $5488
	dw WeightlifterBWalkSprite_Anim05 ; $548a
	dw WeightlifterBWalkSprite_Anim05 ; $548c
	dw WeightlifterBWalkSprite_Anim05 ; $548e
WeightlifterBWalkSprite_AnimStill:
	; $5490, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WeightlifterBWalkSprite_AnimWalk:
	; $5493, 6 bytes (sprite_anim)
	anim_frame $00, 70
	anim_frame $01, 40
	anim_loop $00
WeightlifterBWalkSprite_AnimBounce:
	; $5499, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterBWalkSprite_AnimNod:
	; $54a5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WeightlifterBWalkSprite_AnimShake:
	; $54ad, 20 bytes (sprite_anim)
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
WeightlifterBWalkSprite_Anim05:
	; $54c1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
JumpingJacksAWalkSprite:
	db $04, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, JumpingJacksAWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw JumpingJacksAWalkSprite_Gfx00, JumpingJacksAWalkSprite_Gfx01, JumpingJacksAWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw JumpingJacksAWalkSprite_Gfx02 ; $54dd
	dw JumpingJacksAWalkSprite_Gfx02 ; $54df
	dw JumpingJacksAWalkSprite_Gfx02 ; $54e1
	dw JumpingJacksAWalkSprite_Gfx02 ; $54e3
	dw JumpingJacksAWalkSprite_Gfx03 ; $54e5
	dw JumpingJacksAWalkSprite_Gfx04 ; $54e7
	dw JumpingJacksAWalkSprite_Gfx05 ; $54e9
	dw JumpingJacksAWalkSprite_Gfx06 ; $54eb
Padding_73_06:
	; $54ed, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx00:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx00.bin" ; $54f0, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx01:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx01.bin" ; $5530, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx02:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx02.bin" ; $5570, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx03:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx03.bin" ; $55b0, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx04:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx04.bin" ; $55f0, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx05:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx05.bin" ; $5630, 64 bytes
	ds ALIGN[4]
JumpingJacksAWalkSprite_Gfx06:
	INCBIN "data/sprites/JumpingJacksAWalkSprite_Gfx06.bin" ; $5670, 64 bytes
JumpingJacksAWalkSprite_AnimPtrs:
	dw JumpingJacksAWalkSprite_Anim00 ; $56b0
	dw JumpingJacksAWalkSprite_Anim00 ; $56b2
	dw JumpingJacksAWalkSprite_Anim01 ; $56b4
	dw JumpingJacksAWalkSprite_Anim02 ; $56b6
	dw JumpingJacksAWalkSprite_Anim03 ; $56b8
	dw JumpingJacksAWalkSprite_Anim04 ; $56ba
	dw JumpingJacksAWalkSprite_Anim05 ; $56bc
	dw JumpingJacksAWalkSprite_Anim05 ; $56be
JumpingJacksAWalkSprite_Anim00:
	; $56c0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
JumpingJacksAWalkSprite_Anim01:
	; $56c3, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
JumpingJacksAWalkSprite_Anim02:
	; $56cf, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
JumpingJacksAWalkSprite_Anim03:
	; $56d7, 20 bytes (sprite_anim)
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
JumpingJacksAWalkSprite_Anim04:
	; $56eb, 10 bytes (sprite_anim)
	anim_frame $00, 48
	anim_frame $01, 48
	anim_frame $00, 48
	anim_frame $0a, 48
	anim_loop $00
JumpingJacksAWalkSprite_Anim05:
	; $56f5, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
JumpingJacksBWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, JumpingJacksBWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw JumpingJacksBWalkSprite_Gfx00, JumpingJacksBWalkSprite_Gfx01, JumpingJacksBWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw JumpingJacksBWalkSprite_Gfx02 ; $5711
	dw JumpingJacksBWalkSprite_Gfx02 ; $5713
	dw JumpingJacksBWalkSprite_Gfx02 ; $5715
	dw JumpingJacksBWalkSprite_Gfx02 ; $5717
	dw JumpingJacksBWalkSprite_Gfx03 ; $5719
	dw JumpingJacksBWalkSprite_Gfx04 ; $571b
	dw JumpingJacksBWalkSprite_Gfx05 ; $571d
	dw JumpingJacksBWalkSprite_Gfx06 ; $571f
Padding_73_07:
	; $5721, 15 bytes (fill)
	ds 15, $00
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx00:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx00.bin" ; $5730, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx01:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx01.bin" ; $5770, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx02:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx02.bin" ; $57b0, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx03:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx03.bin" ; $57f0, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx04:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx04.bin" ; $5830, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx05:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx05.bin" ; $5870, 64 bytes
	ds ALIGN[4]
JumpingJacksBWalkSprite_Gfx06:
	INCBIN "data/sprites/JumpingJacksBWalkSprite_Gfx06.bin" ; $58b0, 64 bytes
JumpingJacksBWalkSprite_AnimPtrs:
	dw JumpingJacksBWalkSprite_Anim00 ; $58f0
	dw JumpingJacksBWalkSprite_Anim00 ; $58f2
	dw JumpingJacksBWalkSprite_Anim01 ; $58f4
	dw JumpingJacksBWalkSprite_Anim02 ; $58f6
	dw JumpingJacksBWalkSprite_Anim02 ; $58f8
	dw JumpingJacksBWalkSprite_Anim03 ; $58fa
	dw JumpingJacksBWalkSprite_Anim04 ; $58fc
	dw JumpingJacksBWalkSprite_Anim04 ; $58fe
JumpingJacksBWalkSprite_Anim00:
	; $5900, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
JumpingJacksBWalkSprite_Anim01:
	; $5903, 18 bytes (sprite_anim)
	anim_frame $00, 68
	anim_frame $01, 28
	anim_frame $00, 28
	anim_frame $0a, 48
	anim_frame $00, 28
	anim_frame $01, 48
	anim_frame $00, 48
	anim_frame $0a, 28
	anim_loop $00
JumpingJacksBWalkSprite_Anim02:
	; $5915, 20 bytes (sprite_anim)
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
JumpingJacksBWalkSprite_Anim03:
	; $5929, 10 bytes (sprite_anim)
	anim_frame $00, 48
	anim_frame $01, 48
	anim_frame $00, 48
	anim_frame $0a, 48
	anim_loop $00
JumpingJacksBWalkSprite_Anim04:
	; $5933, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WarioWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, WarioWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw WarioWalkSprite_Gfx00, WarioWalkSprite_Gfx01, WarioWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw WarioWalkSprite_Gfx02 ; $594f
	dw WarioWalkSprite_Gfx02 ; $5951
	dw WarioWalkSprite_Gfx02 ; $5953
	dw WarioWalkSprite_Gfx02 ; $5955
	dw WarioWalkSprite_Gfx03 ; $5957
	dw WarioWalkSprite_Gfx04 ; $5959
	dw WarioWalkSprite_Gfx05 ; $595b
Padding_73_08:
	; $595d, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
WarioWalkSprite_Gfx00:
	INCBIN "data/sprites/WarioWalkSprite_Gfx00.bin" ; $5960, 256 bytes
	ds ALIGN[4]
WarioWalkSprite_Gfx01:
	INCBIN "data/sprites/WarioWalkSprite_Gfx01.bin" ; $5a60, 256 bytes
	ds ALIGN[4]
WarioWalkSprite_Gfx02:
	INCBIN "data/sprites/WarioWalkSprite_Gfx02.bin" ; $5b60, 256 bytes
	ds ALIGN[4]
WarioWalkSprite_Gfx03:
	INCBIN "data/sprites/WarioWalkSprite_Gfx03.bin" ; $5c60, 256 bytes
	ds ALIGN[4]
WarioWalkSprite_Gfx04:
	INCBIN "data/sprites/WarioWalkSprite_Gfx04.bin" ; $5d60, 256 bytes
	ds ALIGN[4]
WarioWalkSprite_Gfx05:
	INCBIN "data/sprites/WarioWalkSprite_Gfx05.bin" ; $5e60, 256 bytes
WarioWalkSprite_AnimPtrs:
	dw WarioWalkSprite_AnimStill ; $5f60
	dw WarioWalkSprite_AnimWalk ; $5f62
	dw WarioWalkSprite_AnimBounce ; $5f64
	dw WarioWalkSprite_AnimNod ; $5f66
	dw WarioWalkSprite_AnimShake ; $5f68
	dw WarioWalkSprite_Anim05 ; $5f6a
	dw WarioWalkSprite_Anim05 ; $5f6c
	dw WarioWalkSprite_Anim05 ; $5f6e
WarioWalkSprite_AnimStill:
	; $5f70, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
WarioWalkSprite_AnimWalk:
	; $5f73, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
WarioWalkSprite_AnimBounce:
	; $5f79, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
WarioWalkSprite_AnimNod:
	; $5f85, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
WarioWalkSprite_AnimShake:
	; $5f8d, 20 bytes (sprite_anim)
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
WarioWalkSprite_Anim05:
	; $5fa1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilyWalkSprite:
	db $05, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, EmilyWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw EmilyWalkSprite_Gfx00, EmilyWalkSprite_Gfx01, EmilyWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw EmilyWalkSprite_Gfx02 ; $5fbd
	dw EmilyWalkSprite_Gfx02 ; $5fbf
	dw EmilyWalkSprite_Gfx02 ; $5fc1
	dw EmilyWalkSprite_Gfx02 ; $5fc3
	dw EmilyWalkSprite_Gfx03 ; $5fc5
	dw EmilyWalkSprite_Gfx04 ; $5fc7
	dw EmilyWalkSprite_Gfx05 ; $5fc9
	dw EmilyWalkSprite_Gfx06 ; $5fcb
	dw EmilyWalkSprite_Gfx06 ; $5fcd
	dw EmilyWalkSprite_Gfx07 ; $5fcf
Padding_73_09:
	; $5fd1, 15 bytes (fill)
	ds 15, $00
	ds ALIGN[4]
EmilyWalkSprite_Gfx00:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx00.bin" ; $5fe0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx01:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx01.bin" ; $60e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx02:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx02.bin" ; $61e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx03:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx03.bin" ; $62e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx04:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx04.bin" ; $63e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx05:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx05.bin" ; $64e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx06:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx06.bin" ; $65e0, 256 bytes
	ds ALIGN[4]
EmilyWalkSprite_Gfx07:
	INCBIN "data/sprites/EmilyWalkSprite_Gfx07.bin" ; $66e0, 256 bytes
EmilyWalkSprite_AnimPtrs:
	dw EmilyWalkSprite_AnimStill ; $67e0
	dw EmilyWalkSprite_AnimWalk ; $67e2
	dw EmilyWalkSprite_AnimBounce ; $67e4
	dw EmilyWalkSprite_AnimNod ; $67e6
	dw EmilyWalkSprite_AnimShake ; $67e8
	dw EmilyWalkSprite_Anim05 ; $67ea
	dw EmilyWalkSprite_Anim05 ; $67ec
	dw EmilyWalkSprite_Anim05 ; $67ee
	dw EmilyWalkSprite_Anim06 ; $67f0
EmilyWalkSprite_AnimStill:
	; $67f2, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
EmilyWalkSprite_AnimWalk:
	; $67f5, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
EmilyWalkSprite_AnimBounce:
	; $67fb, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilyWalkSprite_AnimNod:
	; $6807, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilyWalkSprite_AnimShake:
	; $680f, 20 bytes (sprite_anim)
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
EmilyWalkSprite_Anim05:
	; $6823, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
EmilyWalkSprite_Anim06:
	; $682f, 6 bytes (sprite_anim)
	anim_frame $0b, 30
	anim_frame $0c, 30
	anim_loop $00
MarkWalkSprite:
	db $04, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, MarkWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw MarkWalkSprite_Gfx00, MarkWalkSprite_Gfx01, MarkWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw MarkWalkSprite_Gfx02 ; $6845
	dw MarkWalkSprite_Gfx02 ; $6847
	dw MarkWalkSprite_Gfx02 ; $6849
	dw MarkWalkSprite_Gfx02 ; $684b
	dw MarkWalkSprite_Gfx03 ; $684d
	dw MarkWalkSprite_Gfx04 ; $684f
	dw MarkWalkSprite_Gfx05 ; $6851
Padding_73_10:
	; $6853, 13 bytes (fill)
	ds 13, $00
	ds ALIGN[4]
MarkWalkSprite_Gfx00:
	INCBIN "data/sprites/MarkWalkSprite_Gfx00.bin" ; $6860, 256 bytes
	ds ALIGN[4]
MarkWalkSprite_Gfx01:
	INCBIN "data/sprites/MarkWalkSprite_Gfx01.bin" ; $6960, 256 bytes
	ds ALIGN[4]
MarkWalkSprite_Gfx02:
	INCBIN "data/sprites/MarkWalkSprite_Gfx02.bin" ; $6a60, 256 bytes
	ds ALIGN[4]
MarkWalkSprite_Gfx03:
	INCBIN "data/sprites/MarkWalkSprite_Gfx03.bin" ; $6b60, 256 bytes
	ds ALIGN[4]
MarkWalkSprite_Gfx04:
	INCBIN "data/sprites/MarkWalkSprite_Gfx04.bin" ; $6c60, 256 bytes
	ds ALIGN[4]
MarkWalkSprite_Gfx05:
	INCBIN "data/sprites/MarkWalkSprite_Gfx05.bin" ; $6d60, 256 bytes
MarkWalkSprite_AnimPtrs:
	dw MarkWalkSprite_AnimStill ; $6e60
	dw MarkWalkSprite_AnimWalk ; $6e62
	dw MarkWalkSprite_AnimBounce ; $6e64
	dw MarkWalkSprite_AnimNod ; $6e66
	dw MarkWalkSprite_AnimShake ; $6e68
	dw MarkWalkSprite_Anim05 ; $6e6a
	dw MarkWalkSprite_Anim05 ; $6e6c
	dw MarkWalkSprite_Anim05 ; $6e6e
MarkWalkSprite_AnimStill:
	; $6e70, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
MarkWalkSprite_AnimWalk:
	; $6e73, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
MarkWalkSprite_AnimBounce:
	; $6e79, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
MarkWalkSprite_AnimNod:
	; $6e85, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
MarkWalkSprite_AnimShake:
	; $6e8d, 20 bytes (sprite_anim)
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
MarkWalkSprite_Anim05:
	; $6ea1, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinWalkSprite:
	db $03, $04, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, KevinWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw KevinWalkSprite_Gfx00, KevinWalkSprite_Gfx01, KevinWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw KevinWalkSprite_Gfx02 ; $6ebd
	dw KevinWalkSprite_Gfx02 ; $6ebf
	dw KevinWalkSprite_Gfx02 ; $6ec1
	dw KevinWalkSprite_Gfx02 ; $6ec3
	dw KevinWalkSprite_Gfx03 ; $6ec5
	dw KevinWalkSprite_Gfx04 ; $6ec7
	dw KevinWalkSprite_Gfx05 ; $6ec9
Padding_73_11:
	; $6ecb, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
KevinWalkSprite_Gfx00:
	INCBIN "data/sprites/KevinWalkSprite_Gfx00.bin" ; $6ed0, 256 bytes
	ds ALIGN[4]
KevinWalkSprite_Gfx01:
	INCBIN "data/sprites/KevinWalkSprite_Gfx01.bin" ; $6fd0, 256 bytes
	ds ALIGN[4]
KevinWalkSprite_Gfx02:
	INCBIN "data/sprites/KevinWalkSprite_Gfx02.bin" ; $70d0, 256 bytes
	ds ALIGN[4]
KevinWalkSprite_Gfx03:
	INCBIN "data/sprites/KevinWalkSprite_Gfx03.bin" ; $71d0, 256 bytes
	ds ALIGN[4]
KevinWalkSprite_Gfx04:
	INCBIN "data/sprites/KevinWalkSprite_Gfx04.bin" ; $72d0, 256 bytes
	ds ALIGN[4]
KevinWalkSprite_Gfx05:
	INCBIN "data/sprites/KevinWalkSprite_Gfx05.bin" ; $73d0, 256 bytes
KevinWalkSprite_AnimPtrs:
	dw KevinWalkSprite_AnimStill ; $74d0
	dw KevinWalkSprite_AnimWalk ; $74d2
	dw KevinWalkSprite_AnimBounce ; $74d4
	dw KevinWalkSprite_AnimNod ; $74d6
	dw KevinWalkSprite_AnimShake ; $74d8
	dw KevinWalkSprite_Anim05 ; $74da
	dw KevinWalkSprite_Anim05 ; $74dc
	dw KevinWalkSprite_Anim05 ; $74de
KevinWalkSprite_AnimStill:
	; $74e0, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
KevinWalkSprite_AnimWalk:
	; $74e3, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
KevinWalkSprite_AnimBounce:
	; $74e9, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinWalkSprite_AnimNod:
	; $74f5, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
KevinWalkSprite_AnimShake:
	; $74fd, 20 bytes (sprite_anim)
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
KevinWalkSprite_Anim05:
	; $7511, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BalloonExclaimWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonExclaimWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonExclaimWalkSprite_Gfx00, BalloonExclaimWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_12:
	; $752d, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonExclaimWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonExclaimWalkSprite_Gfx00.bin" ; $7530, 64 bytes
	ds ALIGN[4]
BalloonExclaimWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonExclaimWalkSprite_Gfx01.bin" ; $7570, 64 bytes
BalloonExclaimWalkSprite_AnimPtrs:
	dw BalloonExclaimWalkSprite_Anim00 ; $75b0
	dw BalloonExclaimWalkSprite_Anim01 ; $75b2
BalloonExclaimWalkSprite_Anim00:
	; $75b4, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonExclaimWalkSprite_Anim01:
	; $75b7, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonQuestionWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonQuestionWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonQuestionWalkSprite_Gfx00, BalloonQuestionWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_13:
	; $75cd, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonQuestionWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonQuestionWalkSprite_Gfx00.bin" ; $75d0, 64 bytes
	ds ALIGN[4]
BalloonQuestionWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonQuestionWalkSprite_Gfx01.bin" ; $7610, 64 bytes
BalloonQuestionWalkSprite_AnimPtrs:
	dw BalloonQuestionWalkSprite_Anim00 ; $7650
	dw BalloonQuestionWalkSprite_Anim01 ; $7652
BalloonQuestionWalkSprite_Anim00:
	; $7654, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonQuestionWalkSprite_Anim01:
	; $7657, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonAngryWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonAngryWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonAngryWalkSprite_Gfx00, BalloonAngryWalkSprite_Gfx01, BalloonAngryWalkSprite_Gfx02 ; frame pointers (continue in body)
	dw BalloonAngryWalkSprite_Gfx02 ; $766d
	dw BalloonAngryWalkSprite_Gfx02 ; $766f
	dw BalloonAngryWalkSprite_Gfx02 ; $7671
	dw BalloonAngryWalkSprite_Gfx02 ; $7673
	dw BalloonAngryWalkSprite_Gfx03 ; $7675
	dw BalloonAngryWalkSprite_Gfx04 ; $7677
	dw BalloonAngryWalkSprite_Gfx05 ; $7679
Padding_73_14:
	; $767b, 5 bytes (fill)
	ds 5, $00
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx00.bin" ; $7680, 64 bytes
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx01.bin" ; $76c0, 64 bytes
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx02:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx02.bin" ; $7700, 64 bytes
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx03:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx03.bin" ; $7740, 64 bytes
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx04:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx04.bin" ; $7780, 64 bytes
	ds ALIGN[4]
BalloonAngryWalkSprite_Gfx05:
	INCBIN "data/sprites/BalloonAngryWalkSprite_Gfx05.bin" ; $77c0, 64 bytes
BalloonAngryWalkSprite_AnimPtrs:
	dw BalloonAngryWalkSprite_AnimStill ; $7800
	dw BalloonAngryWalkSprite_AnimWalk ; $7802
	dw BalloonAngryWalkSprite_AnimBounce ; $7804
	dw BalloonAngryWalkSprite_AnimNod ; $7806
	dw BalloonAngryWalkSprite_AnimShake ; $7808
	dw BalloonAngryWalkSprite_Anim05 ; $780a
	dw BalloonAngryWalkSprite_Anim05 ; $780c
	dw BalloonAngryWalkSprite_Anim05 ; $780e
BalloonAngryWalkSprite_AnimStill:
	; $7810, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonAngryWalkSprite_AnimWalk:
	; $7813, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonAngryWalkSprite_AnimBounce:
	; $7819, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BalloonAngryWalkSprite_AnimNod:
	; $7825, 8 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $06, 30
	anim_frame $00, 10
	anim_set ANIM_WALK
BalloonAngryWalkSprite_AnimShake:
	; $782d, 20 bytes (sprite_anim)
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
BalloonAngryWalkSprite_Anim05:
	; $7841, 12 bytes (sprite_anim)
	anim_frame $00, 10
	anim_frame $09, 8
	anim_frame $00, 8
	anim_frame $09, 8
	anim_frame $00, 10
	anim_set ANIM_WALK
BalloonEllipsisWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonEllipsisWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonEllipsisWalkSprite_Gfx00, BalloonEllipsisWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_15:
	; $785d, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonEllipsisWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonEllipsisWalkSprite_Gfx00.bin" ; $7860, 64 bytes
	ds ALIGN[4]
BalloonEllipsisWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonEllipsisWalkSprite_Gfx01.bin" ; $78a0, 64 bytes
BalloonEllipsisWalkSprite_AnimPtrs:
	dw BalloonEllipsisWalkSprite_Anim00 ; $78e0
	dw BalloonEllipsisWalkSprite_Anim01 ; $78e2
BalloonEllipsisWalkSprite_Anim00:
	; $78e4, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonEllipsisWalkSprite_Anim01:
	; $78e7, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonScribbleWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonScribbleWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonScribbleWalkSprite_Gfx00, BalloonScribbleWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_16:
	; $78fd, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonScribbleWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonScribbleWalkSprite_Gfx00.bin" ; $7900, 64 bytes
	ds ALIGN[4]
BalloonScribbleWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonScribbleWalkSprite_Gfx01.bin" ; $7940, 64 bytes
BalloonScribbleWalkSprite_AnimPtrs:
	dw BalloonScribbleWalkSprite_Anim00 ; $7980
	dw BalloonScribbleWalkSprite_Anim01 ; $7982
BalloonScribbleWalkSprite_Anim00:
	; $7984, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonScribbleWalkSprite_Anim01:
	; $7987, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonMusicWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonMusicWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonMusicWalkSprite_Gfx00, BalloonMusicWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_17:
	; $799d, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonMusicWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonMusicWalkSprite_Gfx00.bin" ; $79a0, 64 bytes
	ds ALIGN[4]
BalloonMusicWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonMusicWalkSprite_Gfx01.bin" ; $79e0, 64 bytes
BalloonMusicWalkSprite_AnimPtrs:
	dw BalloonMusicWalkSprite_Anim00 ; $7a20
	dw BalloonMusicWalkSprite_Anim01 ; $7a22
BalloonMusicWalkSprite_Anim00:
	; $7a24, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonMusicWalkSprite_Anim01:
	; $7a27, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonShockWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonShockWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonShockWalkSprite_Gfx00, BalloonShockWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_18:
	; $7a3d, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonShockWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonShockWalkSprite_Gfx00.bin" ; $7a40, 64 bytes
	ds ALIGN[4]
BalloonShockWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonShockWalkSprite_Gfx01.bin" ; $7a80, 64 bytes
BalloonShockWalkSprite_AnimPtrs:
	dw BalloonShockWalkSprite_Anim00 ; $7ac0
	dw BalloonShockWalkSprite_Anim01 ; $7ac2
BalloonShockWalkSprite_Anim00:
	; $7ac4, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonShockWalkSprite_Anim01:
	; $7ac7, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
BalloonSweatWalkSprite:
	db $03, $01, $02, $00 ; OAM attr, facing count, unread, unread
	dw .frames, BalloonSweatWalkSprite_AnimPtrs, .frames ; frame array, anim scripts, frame array
.frames:
	dw BalloonSweatWalkSprite_Gfx00, BalloonSweatWalkSprite_Gfx01, $0000 ; frame pointers (continue in body)
Padding_73_19:
	; $7add, 3 bytes (fill)
	ds 3, $00
	ds ALIGN[4]
BalloonSweatWalkSprite_Gfx00:
	INCBIN "data/sprites/BalloonSweatWalkSprite_Gfx00.bin" ; $7ae0, 64 bytes
	ds ALIGN[4]
BalloonSweatWalkSprite_Gfx01:
	INCBIN "data/sprites/BalloonSweatWalkSprite_Gfx01.bin" ; $7b20, 64 bytes
BalloonSweatWalkSprite_AnimPtrs:
	dw BalloonSweatWalkSprite_Anim00 ; $7b60
	dw BalloonSweatWalkSprite_Anim01 ; $7b62
BalloonSweatWalkSprite_Anim00:
	; $7b64, 3 bytes (sprite_anim)
	anim_frame $00, ANIM_FOREVER
	anim_hold $fd
BalloonSweatWalkSprite_Anim01:
	; $7b67, 6 bytes (sprite_anim)
	anim_frame $00, 30
	anim_frame $01, 30
	anim_loop $00
	; $7b6d, 1171 bytes fill to bank end (linker-padded)
