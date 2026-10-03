FlushWram3MapRows:
	push af ; $4cab
	push bc ; $4cac
	push de ; $4cad
	push hl ; $4cae
	push_wram_bank WRAM_SCREEN ; $4caf
	ld a, b ; $4cb8
	or a ; $4cb9
	jr nz, .mode1 ; $4cba
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4cbc
	ld hl, wShadowTilemap ; $4cbe
	ld de, vBGMap0 ; $4cc1
	call QueueVRAMCopy ; $4cc4
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4cc7
	ld hl, wShadowAttrmap ; $4cc9
	ld de, vBGMap0 + VRAM_BANK1 ; $4ccc
	call QueueVRAMCopy ; $4ccf
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cd2
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $4cd4
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $4cd7
	call QueueVRAMCopy ; $4cda
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cdd
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $4cdf
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $4ce2
	call QueueVRAMCopy ; $4ce5
	call AdvanceFrame ; $4ce8
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4ceb
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4ced
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH ; $4cf0
	call QueueVRAMCopy ; $4cf3
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4cf6
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4cf8
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $4cfb
	call QueueVRAMCopy ; $4cfe
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d01
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH ; $4d03
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH ; $4d06
	call QueueVRAMCopy ; $4d09
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d0c
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4d0e
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d11
	call QueueVRAMCopy ; $4d14
	jp .done ; $4d17
.mode1:
	cp $01 ; $4d1a
	jr nz, .mode2 ; $4d1c
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d1e
	ld hl, wShadowTilemap ; $4d20
	ld de, vBGMap0 ; $4d23
	call QueueVRAMCopy ; $4d26
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d29
	ld hl, wShadowAttrmap ; $4d2b
	ld de, vBGMap0 + VRAM_BANK1 ; $4d2e
	call QueueVRAMCopy ; $4d31
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d34
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d36
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4d39
	call QueueVRAMCopy ; $4d3c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d3f
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d41
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d44
	call QueueVRAMCopy ; $4d47
	call AdvanceFrame ; $4d4a
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d4d
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $4d4f
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH ; $4d52
	call QueueVRAMCopy ; $4d55
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d58
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $4d5a
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d5d
	call QueueVRAMCopy ; $4d60
	jr .done ; $4d63
.mode2:
	cp $02 ; $4d65
	jr nz, .mode3 ; $4d67
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d69
	ld hl, wShadowTilemap ; $4d6b
	ld de, vBGMap0 ; $4d6e
	call QueueVRAMCopy ; $4d71
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4d74
	ld hl, wShadowAttrmap ; $4d76
	ld de, vBGMap0 + VRAM_BANK1 ; $4d79
	call QueueVRAMCopy ; $4d7c
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d7f
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d81
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4d84
	call QueueVRAMCopy ; $4d87
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d8a
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d8c
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4d8f
	call QueueVRAMCopy ; $4d92
	call AdvanceFrame ; $4d95
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4d98
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4d9a
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $4d9d
	call QueueVRAMCopy ; $4da0
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4da3
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $4da5
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $4da8
	call QueueVRAMCopy ; $4dab
	jr .done ; $4dae
.mode3:
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4db0
	ld hl, wShadowTilemap ; $4db2
	ld de, vBGMap0 ; $4db5
	call QueueVRAMCopy ; $4db8
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4dbb
	ld hl, wShadowAttrmap ; $4dbd
	ld de, vBGMap0 + VRAM_BANK1 ; $4dc0
	call QueueVRAMCopy ; $4dc3
	call AdvanceFrame ; $4dc6
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4dc9
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4dcb
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH ; $4dce
	call QueueVRAMCopy ; $4dd1
	ld c, 3 * TILEMAP_WIDTH / 16 ; $4dd4
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4dd6
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1 ; $4dd9
	call QueueVRAMCopy ; $4ddc
	jr .done ; $4ddf
.done:
	pop_wram_bank ; $4de1
	pop hl ; $4de6
	pop de ; $4de7
	pop bc ; $4de8
	pop af ; $4de9
	ret ; $4dea
RestoreMenuBgAndDrawPanel:
	push af ; $4deb
	push bc ; $4dec
	push de ; $4ded
	push hl ; $4dee
	push af ; $4def
	push bc ; $4df0
	push de ; $4df1
	push hl ; $4df2
	ld hl, wScreenScratch ; $4df3
	ld de, wShadowTilemap ; $4df6
	rect_size $14, $10 ; $4df9
	call CopyTilemapRect ; $4dfd
	ld hl, wRulesScreenAnimFrame ; $4e00
	ld de, wShadowAttrmap ; $4e03
	rect_size $14, $10 ; $4e06
	call CopyTilemapRect ; $4e0a
	pop hl ; $4e0d
	pop de ; $4e0e
	pop bc ; $4e0f
	pop af ; $4e10
	ld a, b ; $4e11
	add a ; $4e12
	ld hl, TilemapAssemblyDispatch_39 ; $4e13
	add l ; $4e16
	ld l, a ; $4e17
	jr nc, .readTable ; $4e18
	inc h ; $4e1a
.readTable:
	ld a, [hl+] ; $4e1b
	ld h, [hl] ; $4e1c
	ld l, a ; $4e1d
	ld a, c ; $4e1e
	add a ; $4e1f
	add l ; $4e20
	ld l, a ; $4e21
	jr nc, .readEntry ; $4e22
	inc h ; $4e24
.readEntry:
	ld a, [hl+] ; $4e25
	ld h, [hl] ; $4e26
	ld l, a ; $4e27
.rectLoop:
	push hl ; $4e28
	ld a, [hl+] ; $4e29
	ld b, [hl] ; $4e2a
	ld c, a ; $4e2b
	push bc ; $4e2c
	inc hl ; $4e2d
	ld a, [hl+] ; $4e2e
	ld d, [hl] ; $4e2f
	ld e, a ; $4e30
	inc hl ; $4e31
	ld a, [hl+] ; $4e32
	or a ; $4e33
	jr z, .done ; $4e34
	ld c, [hl] ; $4e36
	ld b, a ; $4e37
	pop hl ; $4e38
	push bc ; $4e39
	push hl ; $4e3a
	push de ; $4e3b
	call CopyTilemapRect ; $4e3c
	pop de ; $4e3f
	ld hl, $0400 ; $4e40
	add hl, de ; $4e43
	ld d, h ; $4e44
	ld e, l ; $4e45
	pop hl ; $4e46
	ld bc, $0400 ; $4e47
	add hl, bc ; $4e4a
	pop bc ; $4e4b
	call CopyTilemapRect ; $4e4c
	pop hl ; $4e4f
	ld a, $06 ; $4e50
	add l ; $4e52
	ld l, a ; $4e53
	jr nc, .nextRect ; $4e54
	inc h ; $4e56
.nextRect:
	jr .rectLoop ; $4e57
.done:
	pop hl ; $4e59
	pop hl ; $4e5a
	pop hl ; $4e5b
	pop de ; $4e5c
	pop bc ; $4e5d
	pop af ; $4e5e
	ret ; $4e5f
TilemapAssemblyDispatch_39:
	; $4e60, 8034 bytes (tilemap_dispatch)
	dw .l2_0 ; 0
	dw .l2_1 ; 1
	dw .l2_2 ; 2
	dw .l2_3 ; 3
	dw .l2_4 ; 4
	dw .l2_5 ; 5
	dw .l2_6 ; 6
	dw .l2_7 ; 7
	dw .l2_8 ; 8
	dw .l2_9 ; 9
	dw .l2_10 ; 10
	dw .l2_11 ; 11
	dw .l2_12 ; 12
	dw .l2_12 ; 13
	dw .l2_12 ; 14
	dw .l2_12 ; 15
	dw .l2_12 ; 16
	dw .l2_13 ; 17
	dw .l2_14 ; 18
	dw .l2_15 ; 19
	dw .l2_16 ; 20
	dw .l2_17 ; 21
	dw .l2_18 ; 22
	dw .l2_19 ; 23
.l2_0:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_1
	dw .rl_2
	dw .rl_3
	dw .rl_4
	dw .rl_5
	dw .rl_6
	dw .rl_7
	dw .rl_8
	dw .rl_9
	dw .rl_10
	dw .rl_11
	dw .rl_12
	dw .rl_13
.l2_1:
	dw .rl_13
	dw .rl_14
	dw .rl_15
	dw .rl_16
	dw .rl_17
	dw .rl_18
	dw .rl_19
	dw .rl_20
	dw .rl_21
	dw .rl_22
.l2_2:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_23
	dw .rl_24
	dw .rl_25
	dw .rl_26
	dw .rl_27
	dw .rl_28
	dw .rl_29
	dw .rl_30
	dw .rl_31
	dw .rl_32
	dw .rl_33
	dw .rl_34
	dw .rl_34
.l2_3:
	dw .rl_34
	dw .rl_35
	dw .rl_36
	dw .rl_37
	dw .rl_38
	dw .rl_39
	dw .rl_40
	dw .rl_41
	dw .rl_42
	dw .rl_43
	dw .rl_0
	dw .rl_0
.l2_4:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_44
	dw .rl_45
	dw .rl_46
	dw .rl_47
	dw .rl_48
	dw .rl_49
	dw .rl_50
	dw .rl_51
	dw .rl_52
	dw .rl_53
	dw .rl_54
	dw .rl_55
	dw .rl_55
.l2_5:
	dw .rl_54
	dw .rl_55
	dw .rl_56
	dw .rl_57
	dw .rl_58
	dw .rl_59
	dw .rl_60
	dw .rl_61
	dw .rl_62
	dw .rl_63
	dw .rl_64
	dw .rl_0
	dw .rl_0
	dw .rl_0
.l2_6:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_65
	dw .rl_66
	dw .rl_67
	dw .rl_68
	dw .rl_69
	dw .rl_70
	dw .rl_71
	dw .rl_72
	dw .rl_73
	dw .rl_74
	dw .rl_74
.l2_7:
	dw .rl_74
	dw .rl_75
	dw .rl_76
	dw .rl_77
	dw .rl_78
	dw .rl_79
	dw .rl_80
	dw .rl_81
	dw .rl_82
	dw .rl_0
	dw .rl_0
.l2_8:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_83
	dw .rl_84
	dw .rl_85
	dw .rl_86
	dw .rl_87
	dw .rl_88
	dw .rl_89
	dw .rl_90
	dw .rl_91
	dw .rl_92
	dw .rl_93
	dw .rl_94
	dw .rl_95
.l2_9:
	dw .rl_94
	dw .rl_95
	dw .rl_96
	dw .rl_97
	dw .rl_98
	dw .rl_99
	dw .rl_100
	dw .rl_101
	dw .rl_102
	dw .rl_103
	dw .rl_0
	dw .rl_0
	dw .rl_0
.l2_10:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_104
	dw .rl_105
	dw .rl_106
	dw .rl_107
	dw .rl_108
	dw .rl_109
	dw .rl_110
	dw .rl_111
	dw .rl_112
	dw .rl_113
.l2_11:
	dw .rl_114
	dw .rl_115
	dw .rl_116
	dw .rl_117
	dw .rl_118
	dw .rl_119
	dw .rl_120
	dw .rl_121
	dw .rl_122
	dw .rl_123
	dw .rl_124
.l2_12:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_125
	dw .rl_126
	dw .rl_127
	dw .rl_128
	dw .rl_129
	dw .rl_130
	dw .rl_131
	dw .rl_132
	dw .rl_133
	dw .rl_134
	dw .rl_134
	dw .rl_134
	dw .rl_134
	dw .rl_134
.l2_13:
	dw .rl_134
	dw .rl_135
	dw .rl_136
	dw .rl_137
	dw .rl_138
	dw .rl_139
	dw .rl_140
	dw .rl_141
	dw .rl_142
	dw .rl_143
	dw .rl_144
	dw .rl_144
	dw .rl_144
	dw .rl_144
.l2_14:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_144
	dw .rl_145
	dw .rl_146
	dw .rl_147
	dw .rl_148
	dw .rl_149
	dw .rl_150
	dw .rl_151
	dw .rl_152
	dw .rl_153
	dw .rl_154
	dw .rl_155
	dw .rl_156
	dw .rl_157
.l2_15:
	dw .rl_158
	dw .rl_159
	dw .rl_160
	dw .rl_161
	dw .rl_162
	dw .rl_163
	dw .rl_164
	dw .rl_165
	dw .rl_166
	dw .rl_167
	dw .rl_168
	dw .rl_169
	dw .rl_170
	dw .rl_171
.l2_16:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_172
	dw .rl_173
	dw .rl_174
	dw .rl_175
	dw .rl_176
	dw .rl_177
	dw .rl_178
	dw .rl_179
	dw .rl_180
	dw .rl_181
	dw .rl_182
	dw .rl_183
	dw .rl_184
	dw .rl_184
.l2_17:
	dw .rl_184
	dw .rl_185
	dw .rl_186
	dw .rl_187
	dw .rl_188
	dw .rl_189
	dw .rl_190
	dw .rl_191
	dw .rl_192
	dw .rl_193
	dw .rl_194
	dw .rl_195
	dw .rl_195
	dw .rl_195
.l2_18:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_195
	dw .rl_196
	dw .rl_197
	dw .rl_198
	dw .rl_199
	dw .rl_200
	dw .rl_201
	dw .rl_202
	dw .rl_203
	dw .rl_204
	dw .rl_205
	dw .rl_206
	dw .rl_206
	dw .rl_206
.l2_19:
	dw .rl_205
	dw .rl_206
	dw .rl_207
	dw .rl_208
	dw .rl_209
	dw .rl_210
	dw .rl_211
	dw .rl_212
	dw .rl_213
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
	dw .pastEnd
.rl_0:
	tilemap_rect_end
.rl_1:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d070, $05, $03
	tilemap_rect_end
.rl_2:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06d, $05, $03
	tilemap_rect $da40, $d0f4, $03, $03
	tilemap_rect_end
.rl_3:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06a, $05, $03
	tilemap_rect $daa5, $d070, $05, $03
	tilemap_rect $daa0, $d070, $03, $03
	tilemap_rect_end
.rl_4:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d067, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $da40, $d0ee, $03, $03
	tilemap_rect $da43, $d0f4, $03, $03
	tilemap_rect $daaf, $d173, $05, $03
	tilemap_rect_end
.rl_5:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06a, $05, $03
	tilemap_rect $daaa, $d070, $05, $03
	tilemap_rect $da40, $d0eb, $03, $03
	tilemap_rect $da43, $d0f1, $03, $03
	tilemap_rect $daaf, $d170, $05, $03
	tilemap_rect_end
.rl_6:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d068, $05, $03
	tilemap_rect $daaa, $d06e, $05, $03
	tilemap_rect $da40, $d0e8, $03, $03
	tilemap_rect $da43, $d0ee, $03, $03
	tilemap_rect $da46, $d0f4, $03, $03
	tilemap_rect $daaf, $d16d, $05, $03
	tilemap_rect $dab4, $d173, $05, $03
	tilemap_rect_end
.rl_7:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e5, $03, $03
	tilemap_rect $da43, $d0eb, $03, $03
	tilemap_rect $da46, $d0f1, $03, $03
	tilemap_rect $daaf, $d16a, $05, $03
	tilemap_rect $dab4, $d170, $05, $03
	tilemap_rect $dab9, $d176, $05, $03
	tilemap_rect_end
.rl_8:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e3, $03, $03
	tilemap_rect $da43, $d0e9, $03, $03
	tilemap_rect $da46, $d0ef, $03, $03
	tilemap_rect $daaf, $d167, $05, $03
	tilemap_rect $dab4, $d16d, $05, $03
	tilemap_rect $dab9, $d173, $05, $03
	tilemap_rect_end
.rl_9:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d164, $05, $03
	tilemap_rect $dab4, $d16a, $05, $03
	tilemap_rect $dab9, $d170, $05, $03
	tilemap_rect_end
.rl_10:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d162, $05, $03
	tilemap_rect $dab4, $d168, $05, $03
	tilemap_rect $dab9, $d16e, $05, $03
	tilemap_rect_end
.rl_11:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_12:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_13:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_14:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d06c, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_15:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05e, $05, $03
	tilemap_rect $daa5, $d064, $05, $03
	tilemap_rect $daaa, $d06a, $05, $03
	tilemap_rect $da40, $d0e1, $03, $03
	tilemap_rect $da43, $d0e7, $03, $03
	tilemap_rect $da46, $d0ed, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_16:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05b, $05, $03
	tilemap_rect $daa5, $d061, $05, $03
	tilemap_rect $daaa, $d067, $05, $03
	tilemap_rect $da40, $d0df, $03, $03
	tilemap_rect $da43, $d0e5, $03, $03
	tilemap_rect $da46, $d0eb, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_17:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05e, $05, $03
	tilemap_rect $daaa, $d064, $05, $03
	tilemap_rect $da40, $d0dc, $03, $03
	tilemap_rect $da43, $d0e2, $03, $03
	tilemap_rect $da46, $d0e8, $03, $03
	tilemap_rect $daaf, $d160, $05, $03
	tilemap_rect $dab4, $d166, $05, $03
	tilemap_rect $dab9, $d16c, $05, $03
	tilemap_rect_end
.rl_18:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05b, $05, $03
	tilemap_rect $daaa, $d061, $05, $03
	tilemap_rect $da40, $d0d9, $03, $03
	tilemap_rect $da43, $d0df, $03, $03
	tilemap_rect $da46, $d0e5, $03, $03
	tilemap_rect $daaf, $d15e, $05, $03
	tilemap_rect $dab4, $d164, $05, $03
	tilemap_rect $dab9, $d16a, $05, $03
	tilemap_rect_end
.rl_19:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daaa, $d05e, $05, $03
	tilemap_rect $da43, $d0dc, $03, $03
	tilemap_rect $da46, $d0e2, $03, $03
	tilemap_rect $daaf, $d15b, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect_end
.rl_20:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daaa, $d05b, $05, $03
	tilemap_rect $da46, $d0df, $03, $03
	tilemap_rect $dab4, $d15e, $05, $03
	tilemap_rect $dab9, $d164, $05, $03
	tilemap_rect_end
.rl_21:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da46, $d0dc, $03, $03
	tilemap_rect $dab4, $d15b, $05, $03
	tilemap_rect $dab9, $d161, $05, $03
	tilemap_rect_end
.rl_22:
	tilemap_rect $dab9, $d15e, $05, $03
	tilemap_rect_end
.rl_23:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d072, $05, $03
	tilemap_rect_end
.rl_24:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d06f, $05, $03
	tilemap_rect $daa5, $d078, $05, $03
	tilemap_rect $daaa, $d0f5, $05, $03
	tilemap_rect_end
.rl_25:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06c, $05, $03
	tilemap_rect $daa5, $d075, $05, $03
	tilemap_rect $daaa, $d0f2, $05, $03
	tilemap_rect_end
.rl_26:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d069, $05, $03
	tilemap_rect $daa5, $d072, $05, $03
	tilemap_rect $daaa, $d0ef, $05, $03
	tilemap_rect $daaf, $d0f8, $05, $03
	tilemap_rect $dab4, $d173, $05, $03
	tilemap_rect_end
.rl_27:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d066, $05, $03
	tilemap_rect $daa5, $d06f, $05, $03
	tilemap_rect $daaa, $d0ec, $05, $03
	tilemap_rect $daaf, $d0f5, $05, $03
	tilemap_rect $dab4, $d170, $05, $03
	tilemap_rect_end
.rl_28:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $daaa, $d0e9, $05, $03
	tilemap_rect $daaf, $d0f2, $05, $03
	tilemap_rect $dab4, $d16d, $05, $03
	tilemap_rect $dab9, $d173, $05, $03
	tilemap_rect_end
.rl_29:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e6, $05, $03
	tilemap_rect $daaf, $d0ef, $05, $03
	tilemap_rect $dab4, $d16a, $05, $03
	tilemap_rect $dab9, $d170, $05, $03
	tilemap_rect $db54, $d176, $05, $03
	tilemap_rect_end
.rl_30:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e4, $05, $03
	tilemap_rect $daaf, $d0ed, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect $db54, $d173, $05, $03
	tilemap_rect_end
.rl_31:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d164, $05, $03
	tilemap_rect $dab9, $d16a, $05, $03
	tilemap_rect $db54, $d170, $05, $03
	tilemap_rect_end
.rl_32:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d162, $05, $03
	tilemap_rect $dab9, $d168, $05, $03
	tilemap_rect $db54, $d16e, $05, $03
	tilemap_rect_end
.rl_33:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_34:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_35:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d06b, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_36:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d069, $05, $03
	tilemap_rect $daaa, $d0e2, $05, $03
	tilemap_rect $daaf, $d0eb, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_37:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05d, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d0e0, $05, $03
	tilemap_rect $daaf, $d0e9, $05, $03
	tilemap_rect $dab4, $d160, $05, $03
	tilemap_rect $dab9, $d166, $05, $03
	tilemap_rect $db54, $d16c, $05, $03
	tilemap_rect_end
.rl_38:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05d, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d0e0, $05, $03
	tilemap_rect $daaf, $d0e9, $05, $03
	tilemap_rect $dab4, $d160, $05, $03
	tilemap_rect $dab9, $d166, $05, $03
	tilemap_rect $db54, $d16c, $05, $03
	tilemap_rect_end
.rl_39:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05a, $05, $03
	tilemap_rect $daa5, $d063, $05, $03
	tilemap_rect $daaa, $d0dd, $05, $03
	tilemap_rect $daaf, $d0e6, $05, $03
	tilemap_rect $dab4, $d15e, $05, $03
	tilemap_rect $dab9, $d164, $05, $03
	tilemap_rect $db54, $d16a, $05, $03
	tilemap_rect_end
.rl_40:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d060, $05, $03
	tilemap_rect $daaa, $d0da, $05, $03
	tilemap_rect $daaf, $d0e3, $05, $03
	tilemap_rect $dab4, $d15b, $05, $03
	tilemap_rect $dab9, $d161, $05, $03
	tilemap_rect $db54, $d167, $05, $03
	tilemap_rect_end
.rl_41:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05d, $05, $03
	tilemap_rect $daaf, $d0e0, $05, $03
	tilemap_rect $dab9, $d15e, $05, $03
	tilemap_rect $db54, $d164, $05, $03
	tilemap_rect_end
.rl_42:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daaf, $d0dd, $05, $03
	tilemap_rect $dab9, $d15b, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect_end
.rl_43:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $db54, $d15e, $05, $03
	tilemap_rect_end
.rl_44:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d071, $03, $03
	tilemap_rect_end
.rl_45:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d06e, $03, $03
	tilemap_rect $da43, $d074, $03, $03
	tilemap_rect_end
.rl_46:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d06b, $03, $03
	tilemap_rect $da43, $d071, $03, $03
	tilemap_rect $da46, $d077, $03, $03
	tilemap_rect $da49, $d0f1, $03, $03
	tilemap_rect_end
.rl_47:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d068, $03, $03
	tilemap_rect $da43, $d06e, $03, $03
	tilemap_rect $da46, $d074, $03, $03
	tilemap_rect $da49, $d0ee, $03, $03
	tilemap_rect $da4c, $d0f4, $03, $03
	tilemap_rect $da52, $d174, $03, $03
	tilemap_rect_end
.rl_48:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d065, $03, $03
	tilemap_rect $da43, $d06b, $03, $03
	tilemap_rect $da46, $d071, $03, $03
	tilemap_rect $da49, $d0eb, $03, $03
	tilemap_rect $da4c, $d0f1, $03, $03
	tilemap_rect $da52, $d171, $03, $03
	tilemap_rect $da55, $d177, $03, $03
	tilemap_rect_end
.rl_49:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d063, $03, $03
	tilemap_rect $da43, $d069, $03, $03
	tilemap_rect $da46, $d06f, $03, $03
	tilemap_rect $da49, $d0e8, $03, $03
	tilemap_rect $da4c, $d0ee, $03, $03
	tilemap_rect $da4f, $d0f4, $03, $03
	tilemap_rect $da52, $d16e, $03, $03
	tilemap_rect $da55, $d174, $03, $03
	tilemap_rect $da58, $d17a, $03, $03
	tilemap_rect_end
.rl_50:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e5, $03, $03
	tilemap_rect $da4c, $d0eb, $03, $03
	tilemap_rect $da4f, $d0f1, $03, $03
	tilemap_rect $da52, $d16b, $03, $03
	tilemap_rect $da55, $d171, $03, $03
	tilemap_rect $da58, $d177, $03, $03
	tilemap_rect_end
.rl_51:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e3, $03, $03
	tilemap_rect $da4c, $d0e9, $03, $03
	tilemap_rect $da4f, $d0ef, $03, $03
	tilemap_rect $da52, $d168, $03, $03
	tilemap_rect $da55, $d16e, $03, $03
	tilemap_rect $da58, $d174, $03, $03
	tilemap_rect_end
.rl_52:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d165, $03, $03
	tilemap_rect $da55, $d16b, $03, $03
	tilemap_rect $da58, $d171, $03, $03
	tilemap_rect_end
.rl_53:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d163, $03, $03
	tilemap_rect $da55, $d169, $03, $03
	tilemap_rect $da58, $d16f, $03, $03
	tilemap_rect_end
.rl_54:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_55:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d061, $03, $03
	tilemap_rect $da43, $d067, $03, $03
	tilemap_rect $da46, $d06d, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_56:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d05f, $03, $03
	tilemap_rect $da43, $d065, $03, $03
	tilemap_rect $da46, $d06b, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_57:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d05c, $03, $03
	tilemap_rect $da43, $d062, $03, $03
	tilemap_rect $da46, $d068, $03, $03
	tilemap_rect $da49, $d0e1, $03, $03
	tilemap_rect $da4c, $d0e7, $03, $03
	tilemap_rect $da4f, $d0ed, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_58:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d05f, $03, $03
	tilemap_rect $da46, $d065, $03, $03
	tilemap_rect $da49, $d0df, $03, $03
	tilemap_rect $da4c, $d0e5, $03, $03
	tilemap_rect $da4f, $d0eb, $03, $03
	tilemap_rect $da52, $d161, $03, $03
	tilemap_rect $da55, $d167, $03, $03
	tilemap_rect $da58, $d16d, $03, $03
	tilemap_rect_end
.rl_59:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d05c, $03, $03
	tilemap_rect $da46, $d062, $03, $03
	tilemap_rect $da49, $d0dc, $03, $03
	tilemap_rect $da4c, $d0e2, $03, $03
	tilemap_rect $da4f, $d0e8, $03, $03
	tilemap_rect $da52, $d15f, $03, $03
	tilemap_rect $da55, $d165, $03, $03
	tilemap_rect $da58, $d16b, $03, $03
	tilemap_rect_end
.rl_60:
	tilemap_rect $da46, $d05f, $03, $03
	tilemap_rect $da4c, $d0df, $03, $03
	tilemap_rect $da4f, $d0e5, $03, $03
	tilemap_rect $da52, $d15c, $03, $03
	tilemap_rect $da55, $d162, $03, $03
	tilemap_rect $da58, $d168, $03, $03
	tilemap_rect_end
.rl_61:
	tilemap_rect $da4c, $d0dc, $03, $03
	tilemap_rect $da4f, $d0e2, $03, $03
	tilemap_rect $da55, $d15f, $03, $03
	tilemap_rect $da58, $d165, $03, $03
	tilemap_rect_end
.rl_62:
	tilemap_rect $da4f, $d0df, $03, $03
	tilemap_rect $da55, $d15c, $03, $03
	tilemap_rect $da58, $d162, $03, $03
	tilemap_rect_end
.rl_63:
	tilemap_rect $da58, $d15f, $03, $03
	tilemap_rect_end
.rl_64:
	tilemap_rect_end
.rl_65:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_66:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect $da43, $d094, $03, $03
	tilemap_rect_end
.rl_67:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_68:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect $daa0, $d133, $03, $03
	tilemap_rect_end
.rl_69:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $daa0, $d130, $03, $03
	tilemap_rect_end
.rl_70:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $daa0, $d12d, $03, $03
	tilemap_rect_end
.rl_71:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d12a, $05, $03
	tilemap_rect_end
.rl_72:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d128, $05, $03
	tilemap_rect_end
.rl_73:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_74:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_75:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_76:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_77:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d07c, $03, $03
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $daa0, $d126, $05, $03
	tilemap_rect_end
.rl_78:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $daa0, $d124, $05, $03
	tilemap_rect_end
.rl_79:
	tilemap_rect $da43, $d07c, $03, $03
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $daa0, $d121, $05, $03
	tilemap_rect_end
.rl_80:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $daa0, $d11e, $05, $03
	tilemap_rect_end
.rl_81:
	tilemap_rect $da46, $d07c, $03, $03
	tilemap_rect $daa0, $d11b, $05, $03
	tilemap_rect_end
.rl_82:
	tilemap_rect $daa0, $d118, $05, $03
	tilemap_rect_end
.rl_83:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d094, $03, $03
	tilemap_rect_end
.rl_84:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_85:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect $da43, $d094, $03, $03
	tilemap_rect_end
.rl_86:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_87:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect_end
.rl_88:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $daa0, $d132, $05, $03
	tilemap_rect_end
.rl_89:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $daa0, $d12f, $05, $03
	tilemap_rect_end
.rl_90:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d12c, $05, $03
	tilemap_rect $daa5, $d134, $05, $03
	tilemap_rect_end
.rl_91:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d129, $05, $03
	tilemap_rect $daa5, $d131, $05, $03
	tilemap_rect_end
.rl_92:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d126, $05, $03
	tilemap_rect $daa5, $d12e, $05, $03
	tilemap_rect_end
.rl_93:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d124, $05, $03
	tilemap_rect $daa5, $d12c, $05, $03
	tilemap_rect_end
.rl_94:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_95:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_96:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_97:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $daa0, $d122, $05, $03
	tilemap_rect $daa5, $d12a, $05, $03
	tilemap_rect_end
.rl_98:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $daa0, $d120, $05, $03
	tilemap_rect $daa5, $d128, $05, $03
	tilemap_rect_end
.rl_99:
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $daa0, $d11d, $05, $03
	tilemap_rect $daa5, $d125, $05, $03
	tilemap_rect_end
.rl_100:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $daa0, $d11a, $05, $03
	tilemap_rect $daa5, $d122, $05, $03
	tilemap_rect_end
.rl_101:
	tilemap_rect $daa0, $d117, $05, $03
	tilemap_rect $daa5, $d11f, $05, $03
	tilemap_rect_end
.rl_102:
	tilemap_rect $daa5, $d11c, $05, $03
	tilemap_rect_end
.rl_103:
	tilemap_rect $daa5, $d119, $05, $03
	tilemap_rect_end
.rl_104:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f3, $05, $03
	tilemap_rect_end
.rl_105:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f0, $05, $03
	tilemap_rect_end
.rl_106:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ed, $05, $03
	tilemap_rect $daa5, $d0f6, $05, $03
	tilemap_rect_end
.rl_107:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ea, $05, $03
	tilemap_rect $daa5, $d0f3, $05, $03
	tilemap_rect_end
.rl_108:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e7, $05, $03
	tilemap_rect $daa5, $d0f0, $05, $03
	tilemap_rect_end
.rl_109:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e4, $05, $03
	tilemap_rect $daa5, $d0ed, $05, $03
	tilemap_rect $daaa, $d0f6, $05, $03
	tilemap_rect_end
.rl_110:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e2, $05, $03
	tilemap_rect $daa5, $d0ea, $05, $03
	tilemap_rect $daaa, $d0f3, $05, $03
	tilemap_rect_end
.rl_111:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e8, $05, $03
	tilemap_rect $daaa, $d0f0, $05, $03
	tilemap_rect_end
.rl_112:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ee, $05, $03
	tilemap_rect_end
.rl_113:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_114:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_115:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e0, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_116:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0de, $05, $03
	tilemap_rect $daa5, $d0e6, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_117:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0db, $05, $03
	tilemap_rect $daa5, $d0e4, $05, $03
	tilemap_rect $daaa, $d0ec, $05, $03
	tilemap_rect_end
.rl_118:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0d8, $05, $03
	tilemap_rect $daa5, $d0e1, $05, $03
	tilemap_rect $daaa, $d0ea, $05, $03
	tilemap_rect_end
.rl_119:
	tilemap_rect $daa5, $d0de, $05, $03
	tilemap_rect $daaa, $d0e7, $05, $03
	tilemap_rect_end
.rl_120:
	tilemap_rect $daa5, $d0db, $05, $03
	tilemap_rect $daaa, $d0e4, $05, $03
	tilemap_rect_end
.rl_121:
	tilemap_rect $daaa, $d0e1, $05, $03
	tilemap_rect_end
.rl_122:
	tilemap_rect $daaa, $d0de, $05, $03
	tilemap_rect_end
.rl_123:
	tilemap_rect $daaa, $d0db, $05, $03
	tilemap_rect_end
.rl_124:
	tilemap_rect $daaa, $d0d8, $05, $03
	tilemap_rect_end
.rl_125:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f5, $05, $03
	tilemap_rect_end
.rl_126:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f2, $05, $03
	tilemap_rect_end
.rl_127:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ef, $05, $03
	tilemap_rect_end
.rl_128:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ec, $05, $03
	tilemap_rect $daa5, $d0f8, $05, $03
	tilemap_rect_end
.rl_129:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e9, $05, $03
	tilemap_rect $daa5, $d0f5, $05, $03
	tilemap_rect_end
.rl_130:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e6, $05, $03
	tilemap_rect $daa5, $d0f2, $05, $03
	tilemap_rect_end
.rl_131:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e4, $05, $03
	tilemap_rect $daa5, $d0ef, $05, $03
	tilemap_rect_end
.rl_132:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ed, $05, $03
	tilemap_rect_end
.rl_133:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_134:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_135:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0e2, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_136:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0e0, $05, $03
	tilemap_rect $daa5, $d0eb, $05, $03
	tilemap_rect_end
.rl_137:
	tilemap_rect $daa0, $d0dd, $05, $03
	tilemap_rect $daa5, $d0e9, $05, $03
	tilemap_rect_end
.rl_138:
	tilemap_rect $daa0, $d0da, $05, $03
	tilemap_rect $daa5, $d0e6, $05, $03
	tilemap_rect_end
.rl_139:
	tilemap_rect $daa0, $d0d7, $05, $03
	tilemap_rect $daa5, $d0e3, $05, $03
	tilemap_rect_end
.rl_140:
	tilemap_rect $daa5, $d0e0, $05, $03
	tilemap_rect_end
.rl_141:
	tilemap_rect $daa5, $d0dd, $05, $03
	tilemap_rect_end
.rl_142:
	tilemap_rect $daa5, $d0da, $05, $03
	tilemap_rect_end
.rl_143:
	tilemap_rect_end
.rl_144:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d096, $05, $03
	tilemap_rect_end
.rl_145:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d093, $05, $03
	tilemap_rect_end
.rl_146:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d090, $05, $03
	tilemap_rect $daa5, $d097, $05, $03
	tilemap_rect $daaa, $d136, $05, $03
	tilemap_rect_end
.rl_147:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d08d, $05, $03
	tilemap_rect $daa5, $d094, $05, $03
	tilemap_rect $daaa, $d133, $05, $03
	tilemap_rect_end
.rl_148:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d08a, $05, $03
	tilemap_rect $daa5, $d091, $05, $03
	tilemap_rect $daaa, $d130, $05, $03
	tilemap_rect $daaf, $d137, $05, $03
	tilemap_rect_end
.rl_149:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d087, $05, $03
	tilemap_rect $daa5, $d08e, $05, $03
	tilemap_rect $daaa, $d12d, $05, $03
	tilemap_rect $daaf, $d134, $05, $03
	tilemap_rect_end
.rl_150:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d085, $05, $03
	tilemap_rect $daa5, $d08c, $05, $03
	tilemap_rect $daaa, $d12a, $05, $03
	tilemap_rect $daaf, $d131, $05, $03
	tilemap_rect_end
.rl_151:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d127, $05, $03
	tilemap_rect $daaf, $d12e, $05, $03
	tilemap_rect_end
.rl_152:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d125, $05, $03
	tilemap_rect $daaf, $d12c, $05, $03
	tilemap_rect_end
.rl_153:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_154:
	tilemap_rect_end
.rl_155:
	tilemap_rect_end
.rl_156:
	tilemap_rect_end
.rl_157:
	tilemap_rect_end
.rl_158:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_159:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d083, $05, $03
	tilemap_rect $daa5, $d08a, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_160:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d081, $05, $03
	tilemap_rect $daa5, $d088, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_161:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d07e, $05, $03
	tilemap_rect $daa5, $d085, $05, $03
	tilemap_rect $daaa, $d123, $05, $03
	tilemap_rect $daaf, $d12a, $05, $03
	tilemap_rect_end
.rl_162:
	tilemap_rect $daa0, $d07b, $05, $03
	tilemap_rect $daa5, $d082, $05, $03
	tilemap_rect $daaa, $d121, $05, $03
	tilemap_rect $daaf, $d128, $05, $03
	tilemap_rect_end
.rl_163:
	tilemap_rect $daa0, $d078, $05, $03
	tilemap_rect $daa5, $d07f, $05, $03
	tilemap_rect $daaa, $d11e, $05, $03
	tilemap_rect $daaf, $d125, $05, $03
	tilemap_rect_end
.rl_164:
	tilemap_rect $daa5, $d07c, $05, $03
	tilemap_rect $daaa, $d11b, $05, $03
	tilemap_rect $daaf, $d122, $05, $03
	tilemap_rect_end
.rl_165:
	tilemap_rect $daaf, $d11f, $05, $03
	tilemap_rect_end
.rl_166:
	tilemap_rect $daaf, $d11c, $05, $03
	tilemap_rect_end
.rl_167:
	tilemap_rect_end
.rl_168:
	tilemap_rect_end
.rl_169:
	tilemap_rect_end
.rl_170:
	tilemap_rect_end
.rl_171:
	tilemap_rect_end
.rl_172:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d073, $05, $03
	tilemap_rect_end
.rl_173:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d070, $05, $03
	tilemap_rect $daa5, $d076, $05, $03
	tilemap_rect_end
.rl_174:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06d, $05, $03
	tilemap_rect $daa5, $d073, $05, $03
	tilemap_rect $daaf, $d0f3, $05, $03
	tilemap_rect $dab4, $d0f9, $05, $03
	tilemap_rect_end
.rl_175:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06a, $05, $03
	tilemap_rect $daa5, $d070, $05, $03
	tilemap_rect $daaa, $d076, $05, $03
	tilemap_rect $daaf, $d0f0, $05, $03
	tilemap_rect $dab4, $d0f6, $05, $03
	tilemap_rect_end
.rl_176:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d067, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $daaa, $d073, $05, $03
	tilemap_rect $daaf, $d0ed, $05, $03
	tilemap_rect $dab4, $d0f3, $05, $03
	tilemap_rect $dab9, $d0f9, $05, $03
	tilemap_rect $db54, $d173, $05, $03
	tilemap_rect_end
.rl_177:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06a, $05, $03
	tilemap_rect $daaa, $d070, $05, $03
	tilemap_rect $daaf, $d0ea, $05, $03
	tilemap_rect $dab4, $d0f0, $05, $03
	tilemap_rect $dab9, $d0f6, $05, $03
	tilemap_rect $db54, $d170, $05, $03
	tilemap_rect $db59, $d176, $05, $03
	tilemap_rect_end
.rl_178:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d068, $05, $03
	tilemap_rect $daaa, $d06e, $05, $03
	tilemap_rect $daaf, $d0e7, $05, $03
	tilemap_rect $dab4, $d0ed, $05, $03
	tilemap_rect $dab9, $d0f3, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect $db59, $d173, $05, $03
	tilemap_rect $da5b, $d179, $05, $03
	tilemap_rect_end
.rl_179:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e4, $05, $03
	tilemap_rect $dab4, $d0ea, $05, $03
	tilemap_rect $dab9, $d0f0, $05, $03
	tilemap_rect $db54, $d16a, $05, $03
	tilemap_rect $db59, $d170, $05, $03
	tilemap_rect $da5b, $d176, $05, $03
	tilemap_rect_end
.rl_180:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e2, $05, $03
	tilemap_rect $dab4, $d0e8, $05, $03
	tilemap_rect $dab9, $d0ee, $05, $03
	tilemap_rect $db54, $d167, $05, $03
	tilemap_rect $db59, $d16d, $05, $03
	tilemap_rect $da5b, $d173, $05, $03
	tilemap_rect_end
.rl_181:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d164, $05, $03
	tilemap_rect $db59, $d16a, $05, $03
	tilemap_rect $da5b, $d170, $05, $03
	tilemap_rect_end
.rl_182:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d162, $05, $03
	tilemap_rect $db59, $d168, $05, $03
	tilemap_rect $da5b, $d16e, $05, $03
	tilemap_rect_end
.rl_183:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_184:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d06c, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_185:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05e, $05, $03
	tilemap_rect $daa5, $d064, $05, $03
	tilemap_rect $daaa, $d06a, $05, $03
	tilemap_rect $daaf, $d0e0, $05, $03
	tilemap_rect $dab4, $d0e6, $05, $03
	tilemap_rect $dab9, $d0ec, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_186:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05b, $05, $03
	tilemap_rect $daa5, $d061, $05, $03
	tilemap_rect $daaa, $d067, $05, $03
	tilemap_rect $daaf, $d0de, $05, $03
	tilemap_rect $dab4, $d0e4, $05, $03
	tilemap_rect $dab9, $d0ea, $05, $03
	tilemap_rect $db54, $d160, $05, $03
	tilemap_rect $db59, $d166, $05, $03
	tilemap_rect $da5b, $d16c, $05, $03
	tilemap_rect_end
.rl_187:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d058, $05, $03
	tilemap_rect $daa5, $d05e, $05, $03
	tilemap_rect $daaa, $d064, $05, $03
	tilemap_rect $daaf, $d0db, $05, $03
	tilemap_rect $dab4, $d0e1, $05, $03
	tilemap_rect $dab9, $d0e7, $05, $03
	tilemap_rect $db54, $d15e, $05, $03
	tilemap_rect $db59, $d164, $05, $03
	tilemap_rect $da5b, $d16a, $05, $03
	tilemap_rect_end
.rl_188:
	tilemap_rect $daa5, $d05b, $05, $03
	tilemap_rect $daaa, $d061, $05, $03
	tilemap_rect $daaf, $d0d8, $05, $03
	tilemap_rect $dab4, $d0de, $05, $03
	tilemap_rect $dab9, $d0e4, $05, $03
	tilemap_rect $db54, $d15b, $05, $03
	tilemap_rect $db59, $d161, $05, $03
	tilemap_rect $da5b, $d167, $05, $03
	tilemap_rect_end
.rl_189:
	tilemap_rect $daaa, $d05e, $05, $03
	tilemap_rect $dab4, $d0db, $05, $03
	tilemap_rect $dab9, $d0e1, $05, $03
	tilemap_rect $db54, $d158, $05, $03
	tilemap_rect $db59, $d15e, $05, $03
	tilemap_rect $da5b, $d164, $05, $03
	tilemap_rect_end
.rl_190:
	tilemap_rect $dab9, $d0de, $05, $03
	tilemap_rect $db59, $d15b, $05, $03
	tilemap_rect $da5b, $d161, $05, $03
	tilemap_rect_end
.rl_191:
	tilemap_rect $da5b, $d15e, $05, $03
	tilemap_rect_end
.rl_192:
	tilemap_rect $da5b, $d15b, $05, $03
	tilemap_rect_end
.rl_193:
	tilemap_rect $da5b, $d158, $05, $03
	tilemap_rect_end
.rl_194:
	tilemap_rect_end
.rl_195:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_196:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect_end
.rl_197:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_198:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect $da46, $d094, $03, $03
	tilemap_rect_end
.rl_199:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $da49, $d134, $03, $03
	tilemap_rect_end
.rl_200:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $da49, $d131, $03, $03
	tilemap_rect $da4f, $d137, $03, $03
	tilemap_rect_end
.rl_201:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d12e, $03, $03
	tilemap_rect $da4f, $d134, $03, $03
	tilemap_rect_end
.rl_202:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d12b, $03, $03
	tilemap_rect $da4f, $d131, $03, $03
	tilemap_rect_end
.rl_203:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d128, $03, $03
	tilemap_rect $da4f, $d12e, $03, $03
	tilemap_rect_end
.rl_204:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d126, $03, $03
	tilemap_rect $da4f, $d12c, $03, $03
	tilemap_rect_end
.rl_205:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_206:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_207:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_208:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d07c, $03, $03
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $da49, $d124, $03, $03
	tilemap_rect $da4f, $d12a, $03, $03
	tilemap_rect_end
.rl_209:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d079, $03, $03
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $da49, $d122, $03, $03
	tilemap_rect $da4f, $d128, $03, $03
	tilemap_rect_end
.rl_210:
	tilemap_rect $da43, $d07c, $03, $03
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $da49, $d11f, $03, $03
	tilemap_rect $da4f, $d125, $03, $03
	tilemap_rect_end
.rl_211:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $da49, $d11c, $03, $03
	tilemap_rect $da4f, $d122, $03, $03
	tilemap_rect_end
.rl_212:
	tilemap_rect $da49, $d119, $03, $03
	tilemap_rect $da4f, $d11f, $03, $03
	tilemap_rect_end
.rl_213:
	tilemap_rect $da4f, $d11c, $03, $03
	tilemap_rect_end
.pastEnd:
