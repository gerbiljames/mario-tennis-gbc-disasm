SECTION "ROM Bank $28", ROMX[$4000], BANK[$28]

	farptr LoadMatchGraphics ; $4000
	farptr LoadMatchVariantGraphics ; $4002
	farptr LoadSpecialHitEffectTiles ; $4004
	farptr LoadBallTouchCharEffectTilesA ; $4006
	farptr LoadBallTouchCharEffectTilesB ; $4008
	farptr LoadMatchStoryGfx ; $400a
	farptr QueueMatchSpriteFrameA ; $400c
	farptr Func_28_60a0 ; $400e
	farptr QueueMatchSpriteFrameB ; $4010
	INCBIN "data/bank_028/d_4012.bin" ; $4012, 1486 bytes
MatchGfxTilesA_28:
	INCBIN "data/bank_028/d_45e0.bin" ; $45e0, 1472 bytes
MatchGfxPalettesA_28:
	; $4ba0, 80 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0180, $031f, $2a94, $0000 ; pal 0: #006200 #ffc500 #a4a452 #000000
	dw $0260, $00ff, $27ff, $0000 ; pal 1: #009c00 #ff3900 #ffff4a #000000
	dw $7e60, $00ff, $7fff, $0000 ; pal 2: #009cff #ff3900 #ffffff #000000
	dw $7f18, $7f18, $7f18, $7f18 ; pal 3: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 4: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 5: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 6: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 7: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $0600, $9e40, $0000, $7fff ; pal 8: #008308 #009439 #000000 #ffffff
	dw $a7ff, $015f, $0000, $7fff ; pal 9: #ffff4a #ff5200 #000000 #ffffff
MatchGfxMapsA_28:
	INCBIN "data/bank_028/d_4bf0.bin" ; $4bf0, 4672 bytes
MatchGfxPalettesB_28:
	; $5e30, 128 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $294a, $7e00, $7fff, $0000 ; pal 0: #525252 #0083ff #ffffff #000000
	dw $294a, $02c0, $7fff, $0000 ; pal 1: #525252 #00b400 #ffffff #000000
	dw $294a, $009f, $7fff, $0000 ; pal 2: #525252 #ff2000 #ffffff #000000
	dw $294a, $023f, $7fff, $0000 ; pal 3: #525252 #ff8b00 #ffffff #000000
	dw $294a, $02c0, $7fff, $0000 ; pal 4: #525252 #00b400 #ffffff #000000
	dw $294a, $009f, $7fff, $0000 ; pal 5: #525252 #ff2000 #ffffff #000000
	dw $294a, $023f, $7fff, $0000 ; pal 6: #525252 #ff8b00 #ffffff #000000
	dw $294a, $009f, $4bff, $000c ; pal 7: #525252 #ff2000 #ffff94 #620000
	dw $294a, $021f, $4bff, $00cc ; pal 8: #525252 #ff8300 #ffff94 #623100
	dw $294a, $02c0, $4bff, $0140 ; pal 9: #525252 #00b400 #ffff94 #005200
	dw $294a, $7e00, $4bff, $3880 ; pal 10: #525252 #0083ff #ffff94 #002073
	dw $294a, $02c0, $4bff, $0140 ; pal 11: #525252 #00b400 #ffff94 #005200
	dw $294a, $009f, $4bff, $000c ; pal 12: #525252 #ff2000 #ffff94 #620000
	dw $294a, $021f, $4bff, $00cc ; pal 13: #525252 #ff8300 #ffff94 #623100
	dw $294a, $001f, $7fff, $0000 ; pal 14: #525252 #ff0000 #ffffff #000000
	dw $0260, $00ff, $27ff, $0000 ; pal 15: #009c00 #ff3900 #ffff4a #000000
LoadMatchGraphics:
	wram_bank $01 ; $5eb0
	ld hl, MatchGfxPalettesA_28 ; $5eb6
	ld de, $0803 ; $5eb9
	call LoadPaletteShadow ; $5ebc
	ld hl, $4be0 ; $5ebf
	ld de, $0002 ; $5ec2
	call LoadPaletteShadow ; $5ec5
	ld hl, $4020 ; $5ec8
	ld de, $a400 ; $5ecb
	ld c, $40 ; $5ece
	call QueueVRAMCopy ; $5ed0
	ld hl, MatchGfxTilesA_28 ; $5ed3
	ld de, $d000 ; $5ed6
	call DecompressData ; $5ed9
	ld hl, $d000 ; $5edc
	ld de, $9000 ; $5edf
	ld c, $80 ; $5ee2
	call QueueVRAMCopy ; $5ee4
	ld hl, $d800 ; $5ee7
	ld de, $8800 ; $5eea
	ld c, $80 ; $5eed
	call QueueVRAMCopy ; $5eef
	ld a, [$c8f5] ; $5ef2
	cp a, $02 ; $5ef5
	call z, LoadMatchVariantGraphics ; $5ef7
	ret ; $5efa
LoadMatchVariantGraphics:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5efb
	sub a, $12 ; $5efe
	jr c, Label_28_5f2a ; $5f00
	ld a, a ; $5f02
	rst Rst00 ; $5f03
	dw Label_28_5f36 ; $5f04 jumptable
	dw Label_28_5f36 ; $5f06 jumptable
	dw Label_28_5f36 ; $5f08 jumptable
	dw Label_28_5f36 ; $5f0a jumptable
	dw Label_28_5f3a ; $5f0c jumptable
	dw Label_28_5f3a ; $5f0e jumptable
	dw Label_28_5f3a ; $5f10 jumptable
	dw Label_28_5f3a ; $5f12 jumptable
	dw Label_28_5f36 ; $5f14 jumptable
	dw Label_28_5f3a ; $5f16 jumptable
	dw Label_28_5f6a ; $5f18 jumptable
	dw Label_28_5f82 ; $5f1a jumptable
	dw Label_28_5f3a ; $5f1c jumptable
	dw Label_28_5f5b ; $5f1e jumptable
	dw Label_28_600c ; $5f20 jumptable
	dw Label_28_5fe9 ; $5f22 jumptable
	dw Label_28_5fbd ; $5f24 jumptable
	dw Label_28_5f9a ; $5f26 jumptable
	dw Label_28_5f2a ; $5f28 jumptable
Label_28_5f2a:
	ld hl, MatchGfxMapsA_28 ; $5f2a
	ld de, $a200 ; $5f2d
	ld c, $20 ; $5f30
	call QueueVRAMCopy ; $5f32
	ret ; $5f35
Label_28_5f36:
	call Func_28_6024 ; $5f36
	ret ; $5f39
Label_28_5f3a:
	ld hl, MatchGfxPalettesB_28 ; $5f3a
	ld de, $0b01 ; $5f3d
	call LoadPaletteShadow ; $5f40
	ld hl, $5e38 ; $5f43
	ld de, $0d03 ; $5f46
	call LoadPaletteShadow ; $5f49
	ld hl, $4d30 ; $5f4c
	ld de, $a100 ; $5f4f
	ld c, $10 ; $5f52
	call QueueVRAMCopy ; $5f54
	call Func_28_6024 ; $5f57
	ret ; $5f5a
Label_28_5f5b:
	ld hl, MatchGfxMapsA_28 ; $5f5b
	ld de, $a200 ; $5f5e
	ld c, $08 ; $5f61
	call QueueVRAMCopy ; $5f63
	call Func_28_6024 ; $5f66
	ret ; $5f69
Label_28_5f6a:
	ld hl, $5ea0 ; $5f6a
	ld de, $0e02 ; $5f6d
	call LoadPaletteShadow ; $5f70
	ld hl, $5470 ; $5f73
	ld de, $a3c0 ; $5f76
	ld c, $02 ; $5f79
	call QueueVRAMCopy ; $5f7b
	call Func_28_6024 ; $5f7e
	ret ; $5f81
Label_28_5f82:
	ld hl, $5e68 ; $5f82
	ld de, $0e02 ; $5f85
	call LoadPaletteShadow ; $5f88
	ld hl, $5470 ; $5f8b
	ld de, $a3c0 ; $5f8e
	ld c, $02 ; $5f91
	call QueueVRAMCopy ; $5f93
	call Func_28_6024 ; $5f96
	ret ; $5f99
Label_28_5f9a:
	ld hl, $5e78 ; $5f9a
	ld de, $0f01 ; $5f9d
	call LoadPaletteShadow ; $5fa0
	ld hl, $5490 ; $5fa3
	ld de, $a200 ; $5fa6
	ld c, $10 ; $5fa9
	call QueueVRAMCopy ; $5fab
	ld hl, $5470 ; $5fae
	ld de, $a3c0 ; $5fb1
	ld c, $02 ; $5fb4
	call QueueVRAMCopy ; $5fb6
	call Func_28_6024 ; $5fb9
	ret ; $5fbc
Label_28_5fbd:
	ld hl, MatchGfxMapsA_28 ; $5fbd
	ld de, $a200 ; $5fc0
	ld c, $08 ; $5fc3
	call QueueVRAMCopy ; $5fc5
	ld hl, $5e80 ; $5fc8
	ld de, $0e01 ; $5fcb
	call LoadPaletteShadow ; $5fce
	ld hl, $5e98 ; $5fd1
	ld de, $0f01 ; $5fd4
	call LoadPaletteShadow ; $5fd7
	ld hl, $5470 ; $5fda
	ld de, $a3c0 ; $5fdd
	ld c, $02 ; $5fe0
	call QueueVRAMCopy ; $5fe2
	call Func_28_6024 ; $5fe5
	ret ; $5fe8
Label_28_5fe9:
	ld hl, $5e50 ; $5fe9
	ld de, $0d03 ; $5fec
	call LoadPaletteShadow ; $5fef
	ld hl, $4e30 ; $5ff2
	ld de, $a100 ; $5ff5
	ld c, $10 ; $5ff8
	call QueueVRAMCopy ; $5ffa
	ld hl, $5130 ; $5ffd
	ld de, $a200 ; $6000
	ld c, $10 ; $6003
	call QueueVRAMCopy ; $6005
	call Func_28_6024 ; $6008
	ret ; $600b
Label_28_600c:
	ld hl, $5e50 ; $600c
	ld de, $0d03 ; $600f
	call LoadPaletteShadow ; $6012
	ld hl, $4e30 ; $6015
	ld de, $a100 ; $6018
	ld c, $30 ; $601b
	call QueueVRAMCopy ; $601d
	call Func_28_6024 ; $6020
	ret ; $6023
Func_28_6024:
	ld hl, $5590 ; $6024
	ld de, $8080 ; $6027
	ld c, $14 ; $602a
	call QueueVRAMCopy ; $602c
	ret ; $602f
LoadSpecialHitEffectTiles:
	rrca ; $6030
	rrca ; $6031
	and a, $c0 ; $6032
	add a, $60 ; $6034
	ld l, a ; $6036
	adc a, $43 ; $6037
	sub a, l ; $6039
	ld h, a ; $603a
	ld de, $a740 ; $603b
	ld c, $04 ; $603e
	call QueueVRAMCopy ; $6040
	ret ; $6043
LoadBallTouchCharEffectTilesA:
	rrca ; $6044
	rrca ; $6045
	and a, $40 ; $6046
	add a, $60 ; $6048
	ld l, a ; $604a
	adc a, $44 ; $604b
	sub a, l ; $604d
	ld h, a ; $604e
	ld de, $a780 ; $604f
	ld c, $04 ; $6052
	call QueueVRAMCopy ; $6054
	ret ; $6057
LoadBallTouchCharEffectTilesB:
	rrca ; $6058
	rrca ; $6059
	and a, $40 ; $605a
	add a, $60 ; $605c
	ld l, a ; $605e
	adc a, $45 ; $605f
	sub a, l ; $6061
	ld h, a ; $6062
	ld de, $a7c0 ; $6063
	ld c, $04 ; $6066
	call QueueVRAMCopy ; $6068
	ret ; $606b
QueueMatchSpriteFrameA:
	add a, a ; $606c
	add a, $80 ; $606d
	ld l, a ; $606f
	adc a, $60 ; $6070
	sub a, l ; $6072
	ld h, a ; $6073
	ld a, [hl+] ; $6074
	ld h, [hl] ; $6075
	ld l, a ; $6076
	ld de, $a300 ; $6077
	ld c, $0c ; $607a
	call QueueVRAMCopy ; $607c
	ret ; $607f
	INCBIN "data/bank_028/d_6080.bin" ; $6080, 6 bytes
QueueMatchSpriteFrameB:
	add a, a ; $6086
	add a, $9a ; $6087
	ld l, a ; $6089
	adc a, $60 ; $608a
	sub a, l ; $608c
	ld h, a ; $608d
	ld a, [hl+] ; $608e
	ld h, [hl] ; $608f
	ld l, a ; $6090
	ld de, $a300 ; $6091
	ld c, $0c ; $6094
	call QueueVRAMCopy ; $6096
	ret ; $6099
	INCBIN "data/bank_028/d_609a.bin" ; $609a, 6 bytes
Func_28_60a0:
	ld h, $00 ; $60a0
	ld l, a ; $60a2
	add hl, hl ; $60a3
	add hl, hl ; $60a4
	add hl, hl ; $60a5
	add hl, hl ; $60a6
	add hl, hl ; $60a7
	add hl, hl ; $60a8
	ld e, l ; $60a9
	ld d, h ; $60aa
	ld a, b ; $60ab
	add a, a ; $60ac
	add a, $c1 ; $60ad
	ld l, a ; $60af
	adc a, $60 ; $60b0
	sub a, l ; $60b2
	ld h, a ; $60b3
	ld a, [hl+] ; $60b4
	ld h, [hl] ; $60b5
	ld l, a ; $60b6
	add hl, de ; $60b7
	ld de, $a300 ; $60b8
	ld c, $04 ; $60bb
	call QueueVRAMCopy ; $60bd
	ret ; $60c0
	INCBIN "data/bank_028/d_60c1.bin" ; $60c1, 8 bytes
LoadMatchStoryGfx:
	wram_bank $01 ; $60c9
	ld hl, MatchGfxPalettesC_28 ; $60cf
	ld de, $0902 ; $60d2
	call LoadPaletteShadow ; $60d5
	ld hl, $6d54 ; $60d8
	ld de, $0002 ; $60db
	call LoadPaletteShadow ; $60de
	ld hl, MatchGfxTilesB_28 ; $60e1
	ld de, $d000 ; $60e4
	call DecompressData ; $60e7
	ld hl, $d000 ; $60ea
	ld de, $9000 ; $60ed
	ld c, $20 ; $60f0
	call QueueVRAMCopy ; $60f2
	push af ; $60f5
	ldh a, [rLCDC] ; $60f6
	bit 7, a ; $60f8
	jr z, Label_28_60ff ; $60fa
	call AdvanceFrame ; $60fc
Label_28_60ff:
	pop af ; $60ff
	ld hl, $d200 ; $6100
	ld de, $9200 ; $6103
	ld c, $20 ; $6106
	call QueueVRAMCopy ; $6108
	push af ; $610b
	ldh a, [rLCDC] ; $610c
	bit 7, a ; $610e
	jr z, Label_28_6115 ; $6110
	call AdvanceFrame ; $6112
Label_28_6115:
	pop af ; $6115
	ld hl, $d400 ; $6116
	ld de, $9400 ; $6119
	ld c, $20 ; $611c
	call QueueVRAMCopy ; $611e
	push af ; $6121
	ldh a, [rLCDC] ; $6122
	bit 7, a ; $6124
	jr z, Label_28_612b ; $6126
	call AdvanceFrame ; $6128
Label_28_612b:
	pop af ; $612b
	ld hl, $d600 ; $612c
	ld de, $9600 ; $612f
	ld c, $20 ; $6132
	call QueueVRAMCopy ; $6134
	push af ; $6137
	ldh a, [rLCDC] ; $6138
	bit 7, a ; $613a
	jr z, Label_28_6141 ; $613c
	call AdvanceFrame ; $613e
Label_28_6141:
	pop af ; $6141
	ld hl, $d800 ; $6142
	ld de, $8800 ; $6145
	ld c, $20 ; $6148
	ld hl, $da00 ; $614a
	ld de, $8a00 ; $614d
	ld c, $20 ; $6150
	ld hl, $dc00 ; $6152
	ld de, $8c00 ; $6155
	ld c, $20 ; $6158
	ld hl, $de00 ; $615a
	ld de, $8e00 ; $615d
	ld c, $20 ; $6160
	call QueueVRAMCopy ; $6162
	push af ; $6165
	ldh a, [rLCDC] ; $6166
	bit 7, a ; $6168
	jr z, Label_28_616f ; $616a
	call AdvanceFrame ; $616c
Label_28_616f:
	pop af ; $616f
	ret ; $6170
	INCBIN "data/bank_028/d_6171.bin" ; $6171, 15 bytes
MatchGfxTilesB_28:
	INCBIN "data/bank_028/d_6180.bin" ; $6180, 2972 bytes
MatchGfxPalettesC_28:
	; $6d1c, 72 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0260, $00ff, $27ff, $0000 ; pal 0: #009c00 #ff3900 #ffff4a #000000
	dw $7e60, $00ff, $7fff, $0000 ; pal 1: #009cff #ff3900 #ffffff #000000
	dw $7f18, $7f18, $7f18, $7f18 ; pal 2: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 3: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 4: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 5: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $7f18, $7f18, $7f18, $7f18 ; pal 6: #c5c5ff #c5c5ff #c5c5ff #c5c5ff
	dw $0600, $9e40, $0000, $7fff ; pal 7: #008308 #009439 #000000 #ffffff
	dw $a7ff, $015f, $0000, $7fff ; pal 8: #ffff4a #ff5200 #000000 #ffffff
	ds 4764, $ff ; $6d64, fill
