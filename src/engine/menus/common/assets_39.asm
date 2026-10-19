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
	ld hl, wStadiumTilemapCopy ; $4df3
	ld de, wShadowTilemap ; $4df6
	rect_size $14, $10 ; $4df9
	call CopyTilemapRect ; $4dfd
	ld hl, wStadiumAttrmapCopy ; $4e00
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
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 3, 5, 3
	tilemap_rect_end
.rl_2:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 3, 5, 3
	panel_rect 0, 18, 20, 7, 3, 3
	tilemap_rect_end
.rl_3:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 3, 5, 3
	panel_rect 5, 21, 16, 3, 5, 3
	panel_rect 0, 21, 16, 3, 3, 3
	tilemap_rect_end
.rl_4:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 0, 18, 14, 7, 3, 3
	panel_rect 3, 18, 20, 7, 3, 3
	panel_rect 15, 21, 19, 11, 5, 3
	tilemap_rect_end
.rl_5:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 10, 3, 5, 3
	panel_rect 10, 21, 16, 3, 5, 3
	panel_rect 0, 18, 11, 7, 3, 3
	panel_rect 3, 18, 17, 7, 3, 3
	panel_rect 15, 21, 16, 11, 5, 3
	tilemap_rect_end
.rl_6:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 8, 3, 5, 3
	panel_rect 10, 21, 14, 3, 5, 3
	panel_rect 0, 18, 8, 7, 3, 3
	panel_rect 3, 18, 14, 7, 3, 3
	panel_rect 6, 18, 20, 7, 3, 3
	panel_rect 15, 21, 13, 11, 5, 3
	panel_rect 20, 21, 19, 11, 5, 3
	tilemap_rect_end
.rl_7:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 5, 7, 3, 3
	panel_rect 3, 18, 11, 7, 3, 3
	panel_rect 6, 18, 17, 7, 3, 3
	panel_rect 15, 21, 10, 11, 5, 3
	panel_rect 20, 21, 16, 11, 5, 3
	panel_rect 25, 21, 22, 11, 5, 3
	tilemap_rect_end
.rl_8:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 3, 7, 3, 3
	panel_rect 3, 18, 9, 7, 3, 3
	panel_rect 6, 18, 15, 7, 3, 3
	panel_rect 15, 21, 7, 11, 5, 3
	panel_rect 20, 21, 13, 11, 5, 3
	panel_rect 25, 21, 19, 11, 5, 3
	tilemap_rect_end
.rl_9:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 4, 11, 5, 3
	panel_rect 20, 21, 10, 11, 5, 3
	panel_rect 25, 21, 16, 11, 5, 3
	tilemap_rect_end
.rl_10:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 2, 11, 5, 3
	panel_rect 20, 21, 8, 11, 5, 3
	panel_rect 25, 21, 14, 11, 5, 3
	tilemap_rect_end
.rl_11:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_12:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_13:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_14:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 12, 3, 5, 3
	panel_rect 0, 18, 2, 7, 3, 3
	panel_rect 3, 18, 8, 7, 3, 3
	panel_rect 6, 18, 14, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_15:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 2, 5, 3
	panel_rect 5, 21, 4, 3, 5, 3
	panel_rect 10, 21, 10, 3, 5, 3
	panel_rect 0, 18, 1, 7, 3, 3
	panel_rect 3, 18, 7, 7, 3, 3
	panel_rect 6, 18, 13, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_16:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 27, 2, 5, 3
	panel_rect 5, 21, 1, 3, 5, 3
	panel_rect 10, 21, 7, 3, 5, 3
	panel_rect 0, 18, 31, 6, 3, 3
	panel_rect 3, 18, 5, 7, 3, 3
	panel_rect 6, 18, 11, 7, 3, 3
	panel_rect 15, 21, 1, 11, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	tilemap_rect_end
.rl_17:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 30, 2, 5, 3
	panel_rect 10, 21, 4, 3, 5, 3
	panel_rect 0, 18, 28, 6, 3, 3
	panel_rect 3, 18, 2, 7, 3, 3
	panel_rect 6, 18, 8, 7, 3, 3
	panel_rect 15, 21, 0, 11, 5, 3
	panel_rect 20, 21, 6, 11, 5, 3
	panel_rect 25, 21, 12, 11, 5, 3
	tilemap_rect_end
.rl_18:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 27, 2, 5, 3
	panel_rect 10, 21, 1, 3, 5, 3
	panel_rect 0, 18, 25, 6, 3, 3
	panel_rect 3, 18, 31, 6, 3, 3
	panel_rect 6, 18, 5, 7, 3, 3
	panel_rect 15, 21, 30, 10, 5, 3
	panel_rect 20, 21, 4, 11, 5, 3
	panel_rect 25, 21, 10, 11, 5, 3
	tilemap_rect_end
.rl_19:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 10, 21, 30, 2, 5, 3
	panel_rect 3, 18, 28, 6, 3, 3
	panel_rect 6, 18, 2, 7, 3, 3
	panel_rect 15, 21, 27, 10, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	tilemap_rect_end
.rl_20:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 10, 21, 27, 2, 5, 3
	panel_rect 6, 18, 31, 6, 3, 3
	panel_rect 20, 21, 30, 10, 5, 3
	panel_rect 25, 21, 4, 11, 5, 3
	tilemap_rect_end
.rl_21:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 6, 18, 28, 6, 3, 3
	panel_rect 20, 21, 27, 10, 5, 3
	panel_rect 25, 21, 1, 11, 5, 3
	tilemap_rect_end
.rl_22:
	panel_rect 25, 21, 30, 10, 5, 3
	tilemap_rect_end
.rl_23:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 18, 3, 5, 3
	tilemap_rect_end
.rl_24:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 15, 3, 5, 3
	panel_rect 5, 21, 24, 3, 5, 3
	panel_rect 10, 21, 21, 7, 5, 3
	tilemap_rect_end
.rl_25:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 12, 3, 5, 3
	panel_rect 5, 21, 21, 3, 5, 3
	panel_rect 10, 21, 18, 7, 5, 3
	tilemap_rect_end
.rl_26:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 9, 3, 5, 3
	panel_rect 5, 21, 18, 3, 5, 3
	panel_rect 10, 21, 15, 7, 5, 3
	panel_rect 15, 21, 24, 7, 5, 3
	panel_rect 20, 21, 19, 11, 5, 3
	tilemap_rect_end
.rl_27:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 6, 3, 5, 3
	panel_rect 5, 21, 15, 3, 5, 3
	panel_rect 10, 21, 12, 7, 5, 3
	panel_rect 15, 21, 21, 7, 5, 3
	panel_rect 20, 21, 16, 11, 5, 3
	tilemap_rect_end
.rl_28:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 10, 21, 9, 7, 5, 3
	panel_rect 15, 21, 18, 7, 5, 3
	panel_rect 20, 21, 13, 11, 5, 3
	panel_rect 25, 21, 19, 11, 5, 3
	tilemap_rect_end
.rl_29:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 6, 7, 5, 3
	panel_rect 15, 21, 15, 7, 5, 3
	panel_rect 20, 21, 10, 11, 5, 3
	panel_rect 25, 21, 16, 11, 5, 3
	panel_rect 20, 26, 22, 11, 5, 3
	tilemap_rect_end
.rl_30:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 4, 7, 5, 3
	panel_rect 15, 21, 13, 7, 5, 3
	panel_rect 20, 21, 7, 11, 5, 3
	panel_rect 25, 21, 13, 11, 5, 3
	panel_rect 20, 26, 19, 11, 5, 3
	tilemap_rect_end
.rl_31:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 4, 11, 5, 3
	panel_rect 25, 21, 10, 11, 5, 3
	panel_rect 20, 26, 16, 11, 5, 3
	tilemap_rect_end
.rl_32:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 2, 11, 5, 3
	panel_rect 25, 21, 8, 11, 5, 3
	panel_rect 20, 26, 14, 11, 5, 3
	tilemap_rect_end
.rl_33:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.rl_34:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 3, 5, 3
	panel_rect 5, 21, 12, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.rl_35:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 11, 3, 5, 3
	panel_rect 10, 21, 3, 7, 5, 3
	panel_rect 15, 21, 12, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.rl_36:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 9, 3, 5, 3
	panel_rect 10, 21, 2, 7, 5, 3
	panel_rect 15, 21, 11, 7, 5, 3
	panel_rect 20, 21, 1, 11, 5, 3
	panel_rect 25, 21, 7, 11, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	tilemap_rect_end
.rl_37:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 29, 2, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 0, 7, 5, 3
	panel_rect 15, 21, 9, 7, 5, 3
	panel_rect 20, 21, 0, 11, 5, 3
	panel_rect 25, 21, 6, 11, 5, 3
	panel_rect 20, 26, 12, 11, 5, 3
	tilemap_rect_end
.rl_38:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 29, 2, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 0, 7, 5, 3
	panel_rect 15, 21, 9, 7, 5, 3
	panel_rect 20, 21, 0, 11, 5, 3
	panel_rect 25, 21, 6, 11, 5, 3
	panel_rect 20, 26, 12, 11, 5, 3
	tilemap_rect_end
.rl_39:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 26, 2, 5, 3
	panel_rect 5, 21, 3, 3, 5, 3
	panel_rect 10, 21, 29, 6, 5, 3
	panel_rect 15, 21, 6, 7, 5, 3
	panel_rect 20, 21, 30, 10, 5, 3
	panel_rect 25, 21, 4, 11, 5, 3
	panel_rect 20, 26, 10, 11, 5, 3
	tilemap_rect_end
.rl_40:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 0, 3, 5, 3
	panel_rect 10, 21, 26, 6, 5, 3
	panel_rect 15, 21, 3, 7, 5, 3
	panel_rect 20, 21, 27, 10, 5, 3
	panel_rect 25, 21, 1, 11, 5, 3
	panel_rect 20, 26, 7, 11, 5, 3
	tilemap_rect_end
.rl_41:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 5, 21, 29, 2, 5, 3
	panel_rect 15, 21, 0, 7, 5, 3
	panel_rect 25, 21, 30, 10, 5, 3
	panel_rect 20, 26, 4, 11, 5, 3
	tilemap_rect_end
.rl_42:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 15, 21, 29, 6, 5, 3
	panel_rect 25, 21, 27, 10, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	tilemap_rect_end
.rl_43:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 20, 26, 30, 10, 5, 3
	tilemap_rect_end
.rl_44:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 3, 3, 3
	tilemap_rect_end
.rl_45:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 3, 3, 3
	panel_rect 3, 18, 20, 3, 3, 3
	tilemap_rect_end
.rl_46:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 3, 3, 3
	panel_rect 3, 18, 17, 3, 3, 3
	panel_rect 6, 18, 23, 3, 3, 3
	panel_rect 9, 18, 17, 7, 3, 3
	tilemap_rect_end
.rl_47:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 3, 3, 3
	panel_rect 3, 18, 14, 3, 3, 3
	panel_rect 6, 18, 20, 3, 3, 3
	panel_rect 9, 18, 14, 7, 3, 3
	panel_rect 12, 18, 20, 7, 3, 3
	panel_rect 18, 18, 20, 11, 3, 3
	tilemap_rect_end
.rl_48:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 3, 3, 3
	panel_rect 3, 18, 11, 3, 3, 3
	panel_rect 6, 18, 17, 3, 3, 3
	panel_rect 9, 18, 11, 7, 3, 3
	panel_rect 12, 18, 17, 7, 3, 3
	panel_rect 18, 18, 17, 11, 3, 3
	panel_rect 21, 18, 23, 11, 3, 3
	tilemap_rect_end
.rl_49:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 3, 3, 3
	panel_rect 3, 18, 9, 3, 3, 3
	panel_rect 6, 18, 15, 3, 3, 3
	panel_rect 9, 18, 8, 7, 3, 3
	panel_rect 12, 18, 14, 7, 3, 3
	panel_rect 15, 18, 20, 7, 3, 3
	panel_rect 18, 18, 14, 11, 3, 3
	panel_rect 21, 18, 20, 11, 3, 3
	panel_rect 24, 18, 26, 11, 3, 3
	tilemap_rect_end
.rl_50:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 5, 7, 3, 3
	panel_rect 12, 18, 11, 7, 3, 3
	panel_rect 15, 18, 17, 7, 3, 3
	panel_rect 18, 18, 11, 11, 3, 3
	panel_rect 21, 18, 17, 11, 3, 3
	panel_rect 24, 18, 23, 11, 3, 3
	tilemap_rect_end
.rl_51:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 3, 7, 3, 3
	panel_rect 12, 18, 9, 7, 3, 3
	panel_rect 15, 18, 15, 7, 3, 3
	panel_rect 18, 18, 8, 11, 3, 3
	panel_rect 21, 18, 14, 11, 3, 3
	panel_rect 24, 18, 20, 11, 3, 3
	tilemap_rect_end
.rl_52:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 5, 11, 3, 3
	panel_rect 21, 18, 11, 11, 3, 3
	panel_rect 24, 18, 17, 11, 3, 3
	tilemap_rect_end
.rl_53:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 3, 11, 3, 3
	panel_rect 21, 18, 9, 11, 3, 3
	panel_rect 24, 18, 15, 11, 3, 3
	tilemap_rect_end
.rl_54:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 3, 3, 3
	panel_rect 3, 18, 8, 3, 3, 3
	panel_rect 6, 18, 14, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.rl_55:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 3, 3, 3
	panel_rect 3, 18, 7, 3, 3, 3
	panel_rect 6, 18, 13, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.rl_56:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 2, 3, 3
	panel_rect 3, 18, 5, 3, 3, 3
	panel_rect 6, 18, 11, 3, 3, 3
	panel_rect 9, 18, 2, 7, 3, 3
	panel_rect 12, 18, 8, 7, 3, 3
	panel_rect 15, 18, 14, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.rl_57:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 28, 2, 3, 3
	panel_rect 3, 18, 2, 3, 3, 3
	panel_rect 6, 18, 8, 3, 3, 3
	panel_rect 9, 18, 1, 7, 3, 3
	panel_rect 12, 18, 7, 7, 3, 3
	panel_rect 15, 18, 13, 7, 3, 3
	panel_rect 18, 18, 2, 11, 3, 3
	panel_rect 21, 18, 8, 11, 3, 3
	panel_rect 24, 18, 14, 11, 3, 3
	tilemap_rect_end
.rl_58:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 2, 3, 3
	panel_rect 6, 18, 5, 3, 3, 3
	panel_rect 9, 18, 31, 6, 3, 3
	panel_rect 12, 18, 5, 7, 3, 3
	panel_rect 15, 18, 11, 7, 3, 3
	panel_rect 18, 18, 1, 11, 3, 3
	panel_rect 21, 18, 7, 11, 3, 3
	panel_rect 24, 18, 13, 11, 3, 3
	tilemap_rect_end
.rl_59:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 28, 2, 3, 3
	panel_rect 6, 18, 2, 3, 3, 3
	panel_rect 9, 18, 28, 6, 3, 3
	panel_rect 12, 18, 2, 7, 3, 3
	panel_rect 15, 18, 8, 7, 3, 3
	panel_rect 18, 18, 31, 10, 3, 3
	panel_rect 21, 18, 5, 11, 3, 3
	panel_rect 24, 18, 11, 11, 3, 3
	tilemap_rect_end
.rl_60:
	panel_rect 6, 18, 31, 2, 3, 3
	panel_rect 12, 18, 31, 6, 3, 3
	panel_rect 15, 18, 5, 7, 3, 3
	panel_rect 18, 18, 28, 10, 3, 3
	panel_rect 21, 18, 2, 11, 3, 3
	panel_rect 24, 18, 8, 11, 3, 3
	tilemap_rect_end
.rl_61:
	panel_rect 12, 18, 28, 6, 3, 3
	panel_rect 15, 18, 2, 7, 3, 3
	panel_rect 21, 18, 31, 10, 3, 3
	panel_rect 24, 18, 5, 11, 3, 3
	tilemap_rect_end
.rl_62:
	panel_rect 15, 18, 31, 6, 3, 3
	panel_rect 21, 18, 28, 10, 3, 3
	panel_rect 24, 18, 2, 11, 3, 3
	tilemap_rect_end
.rl_63:
	panel_rect 24, 18, 31, 10, 3, 3
	tilemap_rect_end
.rl_64:
	tilemap_rect_end
.rl_65:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_66:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	panel_rect 3, 18, 20, 4, 3, 3
	tilemap_rect_end
.rl_67:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_68:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	panel_rect 0, 21, 19, 9, 3, 3
	tilemap_rect_end
.rl_69:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 0, 21, 16, 9, 3, 3
	tilemap_rect_end
.rl_70:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 0, 21, 13, 9, 3, 3
	tilemap_rect_end
.rl_71:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 10, 9, 5, 3
	tilemap_rect_end
.rl_72:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 8, 9, 5, 3
	tilemap_rect_end
.rl_73:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.rl_74:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.rl_75:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.rl_76:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 0, 21, 7, 9, 5, 3
	tilemap_rect_end
.rl_77:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 28, 3, 3, 3
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 0, 21, 6, 9, 5, 3
	tilemap_rect_end
.rl_78:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 0, 21, 4, 9, 5, 3
	tilemap_rect_end
.rl_79:
	panel_rect 3, 18, 28, 3, 3, 3
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 0, 21, 1, 9, 5, 3
	tilemap_rect_end
.rl_80:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 0, 21, 30, 8, 5, 3
	tilemap_rect_end
.rl_81:
	panel_rect 6, 18, 28, 3, 3, 3
	panel_rect 0, 21, 27, 8, 5, 3
	tilemap_rect_end
.rl_82:
	panel_rect 0, 21, 24, 8, 5, 3
	tilemap_rect_end
.rl_83:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 20, 4, 3, 3
	tilemap_rect_end
.rl_84:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_85:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	panel_rect 3, 18, 20, 4, 3, 3
	tilemap_rect_end
.rl_86:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_87:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	tilemap_rect_end
.rl_88:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 0, 21, 18, 9, 5, 3
	tilemap_rect_end
.rl_89:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 0, 21, 15, 9, 5, 3
	tilemap_rect_end
.rl_90:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 12, 9, 5, 3
	panel_rect 5, 21, 20, 9, 5, 3
	tilemap_rect_end
.rl_91:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 9, 9, 5, 3
	panel_rect 5, 21, 17, 9, 5, 3
	tilemap_rect_end
.rl_92:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 6, 9, 5, 3
	panel_rect 5, 21, 14, 9, 5, 3
	tilemap_rect_end
.rl_93:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 4, 9, 5, 3
	panel_rect 5, 21, 12, 9, 5, 3
	tilemap_rect_end
.rl_94:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_95:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_96:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 0, 21, 3, 9, 5, 3
	panel_rect 5, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_97:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 0, 21, 2, 9, 5, 3
	panel_rect 5, 21, 10, 9, 5, 3
	tilemap_rect_end
.rl_98:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 0, 21, 0, 9, 5, 3
	panel_rect 5, 21, 8, 9, 5, 3
	tilemap_rect_end
.rl_99:
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 0, 21, 29, 8, 5, 3
	panel_rect 5, 21, 5, 9, 5, 3
	tilemap_rect_end
.rl_100:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 0, 21, 26, 8, 5, 3
	panel_rect 5, 21, 2, 9, 5, 3
	tilemap_rect_end
.rl_101:
	panel_rect 0, 21, 23, 8, 5, 3
	panel_rect 5, 21, 31, 8, 5, 3
	tilemap_rect_end
.rl_102:
	panel_rect 5, 21, 28, 8, 5, 3
	tilemap_rect_end
.rl_103:
	panel_rect 5, 21, 25, 8, 5, 3
	tilemap_rect_end
.rl_104:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 7, 5, 3
	tilemap_rect_end
.rl_105:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 7, 5, 3
	tilemap_rect_end
.rl_106:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 7, 5, 3
	panel_rect 5, 21, 22, 7, 5, 3
	tilemap_rect_end
.rl_107:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 7, 5, 3
	panel_rect 5, 21, 19, 7, 5, 3
	tilemap_rect_end
.rl_108:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 7, 5, 3
	panel_rect 5, 21, 16, 7, 5, 3
	tilemap_rect_end
.rl_109:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 7, 5, 3
	panel_rect 5, 21, 13, 7, 5, 3
	panel_rect 10, 21, 22, 7, 5, 3
	tilemap_rect_end
.rl_110:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 7, 5, 3
	panel_rect 5, 21, 10, 7, 5, 3
	panel_rect 10, 21, 19, 7, 5, 3
	tilemap_rect_end
.rl_111:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 8, 7, 5, 3
	panel_rect 10, 21, 16, 7, 5, 3
	tilemap_rect_end
.rl_112:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 14, 7, 5, 3
	tilemap_rect_end
.rl_113:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.rl_114:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.rl_115:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 7, 5, 3
	panel_rect 5, 21, 7, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.rl_116:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 6, 5, 3
	panel_rect 5, 21, 6, 7, 5, 3
	panel_rect 10, 21, 13, 7, 5, 3
	tilemap_rect_end
.rl_117:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 27, 6, 5, 3
	panel_rect 5, 21, 4, 7, 5, 3
	panel_rect 10, 21, 12, 7, 5, 3
	tilemap_rect_end
.rl_118:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 24, 6, 5, 3
	panel_rect 5, 21, 1, 7, 5, 3
	panel_rect 10, 21, 10, 7, 5, 3
	tilemap_rect_end
.rl_119:
	panel_rect 5, 21, 30, 6, 5, 3
	panel_rect 10, 21, 7, 7, 5, 3
	tilemap_rect_end
.rl_120:
	panel_rect 5, 21, 27, 6, 5, 3
	panel_rect 10, 21, 4, 7, 5, 3
	tilemap_rect_end
.rl_121:
	panel_rect 10, 21, 1, 7, 5, 3
	tilemap_rect_end
.rl_122:
	panel_rect 10, 21, 30, 6, 5, 3
	tilemap_rect_end
.rl_123:
	panel_rect 10, 21, 27, 6, 5, 3
	tilemap_rect_end
.rl_124:
	panel_rect 10, 21, 24, 6, 5, 3
	tilemap_rect_end
.rl_125:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 21, 7, 5, 3
	tilemap_rect_end
.rl_126:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 18, 7, 5, 3
	tilemap_rect_end
.rl_127:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 15, 7, 5, 3
	tilemap_rect_end
.rl_128:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 12, 7, 5, 3
	panel_rect 5, 21, 24, 7, 5, 3
	tilemap_rect_end
.rl_129:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 9, 7, 5, 3
	panel_rect 5, 21, 21, 7, 5, 3
	tilemap_rect_end
.rl_130:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 6, 7, 5, 3
	panel_rect 5, 21, 18, 7, 5, 3
	tilemap_rect_end
.rl_131:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 7, 5, 3
	panel_rect 5, 21, 15, 7, 5, 3
	tilemap_rect_end
.rl_132:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 13, 7, 5, 3
	tilemap_rect_end
.rl_133:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.rl_134:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.rl_135:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 2, 7, 5, 3
	panel_rect 5, 21, 12, 7, 5, 3
	tilemap_rect_end
.rl_136:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 0, 7, 5, 3
	panel_rect 5, 21, 11, 7, 5, 3
	tilemap_rect_end
.rl_137:
	panel_rect 0, 21, 29, 6, 5, 3
	panel_rect 5, 21, 9, 7, 5, 3
	tilemap_rect_end
.rl_138:
	panel_rect 0, 21, 26, 6, 5, 3
	panel_rect 5, 21, 6, 7, 5, 3
	tilemap_rect_end
.rl_139:
	panel_rect 0, 21, 23, 6, 5, 3
	panel_rect 5, 21, 3, 7, 5, 3
	tilemap_rect_end
.rl_140:
	panel_rect 5, 21, 0, 7, 5, 3
	tilemap_rect_end
.rl_141:
	panel_rect 5, 21, 29, 6, 5, 3
	tilemap_rect_end
.rl_142:
	panel_rect 5, 21, 26, 6, 5, 3
	tilemap_rect_end
.rl_143:
	tilemap_rect_end
.rl_144:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 22, 4, 5, 3
	tilemap_rect_end
.rl_145:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 4, 5, 3
	tilemap_rect_end
.rl_146:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 16, 4, 5, 3
	panel_rect 5, 21, 23, 4, 5, 3
	panel_rect 10, 21, 22, 9, 5, 3
	tilemap_rect_end
.rl_147:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 4, 5, 3
	panel_rect 5, 21, 20, 4, 5, 3
	panel_rect 10, 21, 19, 9, 5, 3
	tilemap_rect_end
.rl_148:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 4, 5, 3
	panel_rect 5, 21, 17, 4, 5, 3
	panel_rect 10, 21, 16, 9, 5, 3
	panel_rect 15, 21, 23, 9, 5, 3
	tilemap_rect_end
.rl_149:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 4, 5, 3
	panel_rect 5, 21, 14, 4, 5, 3
	panel_rect 10, 21, 13, 9, 5, 3
	panel_rect 15, 21, 20, 9, 5, 3
	tilemap_rect_end
.rl_150:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 5, 4, 5, 3
	panel_rect 5, 21, 12, 4, 5, 3
	panel_rect 10, 21, 10, 9, 5, 3
	panel_rect 15, 21, 17, 9, 5, 3
	tilemap_rect_end
.rl_151:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 7, 9, 5, 3
	panel_rect 15, 21, 14, 9, 5, 3
	tilemap_rect_end
.rl_152:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 5, 9, 5, 3
	panel_rect 15, 21, 12, 9, 5, 3
	tilemap_rect_end
.rl_153:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
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
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 4, 5, 3
	panel_rect 5, 21, 11, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_159:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 3, 4, 5, 3
	panel_rect 5, 21, 10, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_160:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 1, 4, 5, 3
	panel_rect 5, 21, 8, 4, 5, 3
	panel_rect 10, 21, 4, 9, 5, 3
	panel_rect 15, 21, 11, 9, 5, 3
	tilemap_rect_end
.rl_161:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 30, 3, 5, 3
	panel_rect 5, 21, 5, 4, 5, 3
	panel_rect 10, 21, 3, 9, 5, 3
	panel_rect 15, 21, 10, 9, 5, 3
	tilemap_rect_end
.rl_162:
	panel_rect 0, 21, 27, 3, 5, 3
	panel_rect 5, 21, 2, 4, 5, 3
	panel_rect 10, 21, 1, 9, 5, 3
	panel_rect 15, 21, 8, 9, 5, 3
	tilemap_rect_end
.rl_163:
	panel_rect 0, 21, 24, 3, 5, 3
	panel_rect 5, 21, 31, 3, 5, 3
	panel_rect 10, 21, 30, 8, 5, 3
	panel_rect 15, 21, 5, 9, 5, 3
	tilemap_rect_end
.rl_164:
	panel_rect 5, 21, 28, 3, 5, 3
	panel_rect 10, 21, 27, 8, 5, 3
	panel_rect 15, 21, 2, 9, 5, 3
	tilemap_rect_end
.rl_165:
	panel_rect 15, 21, 31, 8, 5, 3
	tilemap_rect_end
.rl_166:
	panel_rect 15, 21, 28, 8, 5, 3
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
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 19, 3, 5, 3
	tilemap_rect_end
.rl_173:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 16, 3, 5, 3
	panel_rect 5, 21, 22, 3, 5, 3
	tilemap_rect_end
.rl_174:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 13, 3, 5, 3
	panel_rect 5, 21, 19, 3, 5, 3
	panel_rect 15, 21, 19, 7, 5, 3
	panel_rect 20, 21, 25, 7, 5, 3
	tilemap_rect_end
.rl_175:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 10, 3, 5, 3
	panel_rect 5, 21, 16, 3, 5, 3
	panel_rect 10, 21, 22, 3, 5, 3
	panel_rect 15, 21, 16, 7, 5, 3
	panel_rect 20, 21, 22, 7, 5, 3
	tilemap_rect_end
.rl_176:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 7, 3, 5, 3
	panel_rect 5, 21, 13, 3, 5, 3
	panel_rect 10, 21, 19, 3, 5, 3
	panel_rect 15, 21, 13, 7, 5, 3
	panel_rect 20, 21, 19, 7, 5, 3
	panel_rect 25, 21, 25, 7, 5, 3
	panel_rect 20, 26, 19, 11, 5, 3
	tilemap_rect_end
.rl_177:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 4, 3, 5, 3
	panel_rect 5, 21, 10, 3, 5, 3
	panel_rect 10, 21, 16, 3, 5, 3
	panel_rect 15, 21, 10, 7, 5, 3
	panel_rect 20, 21, 16, 7, 5, 3
	panel_rect 25, 21, 22, 7, 5, 3
	panel_rect 20, 26, 16, 11, 5, 3
	panel_rect 25, 26, 22, 11, 5, 3
	tilemap_rect_end
.rl_178:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 2, 3, 5, 3
	panel_rect 5, 21, 8, 3, 5, 3
	panel_rect 10, 21, 14, 3, 5, 3
	panel_rect 15, 21, 7, 7, 5, 3
	panel_rect 20, 21, 13, 7, 5, 3
	panel_rect 25, 21, 19, 7, 5, 3
	panel_rect 20, 26, 13, 11, 5, 3
	panel_rect 25, 26, 19, 11, 5, 3
	panel_rect 27, 18, 25, 11, 5, 3
	tilemap_rect_end
.rl_179:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 4, 7, 5, 3
	panel_rect 20, 21, 10, 7, 5, 3
	panel_rect 25, 21, 16, 7, 5, 3
	panel_rect 20, 26, 10, 11, 5, 3
	panel_rect 25, 26, 16, 11, 5, 3
	panel_rect 27, 18, 22, 11, 5, 3
	tilemap_rect_end
.rl_180:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 2, 7, 5, 3
	panel_rect 20, 21, 8, 7, 5, 3
	panel_rect 25, 21, 14, 7, 5, 3
	panel_rect 20, 26, 7, 11, 5, 3
	panel_rect 25, 26, 13, 11, 5, 3
	panel_rect 27, 18, 19, 11, 5, 3
	tilemap_rect_end
.rl_181:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 4, 11, 5, 3
	panel_rect 25, 26, 10, 11, 5, 3
	panel_rect 27, 18, 16, 11, 5, 3
	tilemap_rect_end
.rl_182:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 2, 11, 5, 3
	panel_rect 25, 26, 8, 11, 5, 3
	panel_rect 27, 18, 14, 11, 5, 3
	tilemap_rect_end
.rl_183:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 1, 3, 5, 3
	panel_rect 5, 21, 7, 3, 5, 3
	panel_rect 10, 21, 13, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.rl_184:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 0, 3, 5, 3
	panel_rect 5, 21, 6, 3, 5, 3
	panel_rect 10, 21, 12, 3, 5, 3
	panel_rect 15, 21, 1, 7, 5, 3
	panel_rect 20, 21, 7, 7, 5, 3
	panel_rect 25, 21, 13, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.rl_185:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 30, 2, 5, 3
	panel_rect 5, 21, 4, 3, 5, 3
	panel_rect 10, 21, 10, 3, 5, 3
	panel_rect 15, 21, 0, 7, 5, 3
	panel_rect 20, 21, 6, 7, 5, 3
	panel_rect 25, 21, 12, 7, 5, 3
	panel_rect 20, 26, 1, 11, 5, 3
	panel_rect 25, 26, 7, 11, 5, 3
	panel_rect 27, 18, 13, 11, 5, 3
	tilemap_rect_end
.rl_186:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 21, 27, 2, 5, 3
	panel_rect 5, 21, 1, 3, 5, 3
	panel_rect 10, 21, 7, 3, 5, 3
	panel_rect 15, 21, 30, 6, 5, 3
	panel_rect 20, 21, 4, 7, 5, 3
	panel_rect 25, 21, 10, 7, 5, 3
	panel_rect 20, 26, 0, 11, 5, 3
	panel_rect 25, 26, 6, 11, 5, 3
	panel_rect 27, 18, 12, 11, 5, 3
	tilemap_rect_end
.rl_187:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 21, 24, 2, 5, 3
	panel_rect 5, 21, 30, 2, 5, 3
	panel_rect 10, 21, 4, 3, 5, 3
	panel_rect 15, 21, 27, 6, 5, 3
	panel_rect 20, 21, 1, 7, 5, 3
	panel_rect 25, 21, 7, 7, 5, 3
	panel_rect 20, 26, 30, 10, 5, 3
	panel_rect 25, 26, 4, 11, 5, 3
	panel_rect 27, 18, 10, 11, 5, 3
	tilemap_rect_end
.rl_188:
	panel_rect 5, 21, 27, 2, 5, 3
	panel_rect 10, 21, 1, 3, 5, 3
	panel_rect 15, 21, 24, 6, 5, 3
	panel_rect 20, 21, 30, 6, 5, 3
	panel_rect 25, 21, 4, 7, 5, 3
	panel_rect 20, 26, 27, 10, 5, 3
	panel_rect 25, 26, 1, 11, 5, 3
	panel_rect 27, 18, 7, 11, 5, 3
	tilemap_rect_end
.rl_189:
	panel_rect 10, 21, 30, 2, 5, 3
	panel_rect 20, 21, 27, 6, 5, 3
	panel_rect 25, 21, 1, 7, 5, 3
	panel_rect 20, 26, 24, 10, 5, 3
	panel_rect 25, 26, 30, 10, 5, 3
	panel_rect 27, 18, 4, 11, 5, 3
	tilemap_rect_end
.rl_190:
	panel_rect 25, 21, 30, 6, 5, 3
	panel_rect 25, 26, 27, 10, 5, 3
	panel_rect 27, 18, 1, 11, 5, 3
	tilemap_rect_end
.rl_191:
	panel_rect 27, 18, 30, 10, 5, 3
	tilemap_rect_end
.rl_192:
	panel_rect 27, 18, 27, 10, 5, 3
	tilemap_rect_end
.rl_193:
	panel_rect 27, 18, 24, 10, 5, 3
	tilemap_rect_end
.rl_194:
	tilemap_rect_end
.rl_195:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_196:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 14, 4, 3, 3
	tilemap_rect_end
.rl_197:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 11, 4, 3, 3
	panel_rect 3, 18, 17, 4, 3, 3
	tilemap_rect_end
.rl_198:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 8, 4, 3, 3
	panel_rect 3, 18, 14, 4, 3, 3
	panel_rect 6, 18, 20, 4, 3, 3
	tilemap_rect_end
.rl_199:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 5, 4, 3, 3
	panel_rect 3, 18, 11, 4, 3, 3
	panel_rect 6, 18, 17, 4, 3, 3
	panel_rect 9, 18, 20, 9, 3, 3
	tilemap_rect_end
.rl_200:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 3, 4, 3, 3
	panel_rect 3, 18, 9, 4, 3, 3
	panel_rect 6, 18, 15, 4, 3, 3
	panel_rect 9, 18, 17, 9, 3, 3
	panel_rect 15, 18, 23, 9, 3, 3
	tilemap_rect_end
.rl_201:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 14, 9, 3, 3
	panel_rect 15, 18, 20, 9, 3, 3
	tilemap_rect_end
.rl_202:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 11, 9, 3, 3
	panel_rect 15, 18, 17, 9, 3, 3
	tilemap_rect_end
.rl_203:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 8, 9, 3, 3
	panel_rect 15, 18, 14, 9, 3, 3
	tilemap_rect_end
.rl_204:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 6, 9, 3, 3
	panel_rect 15, 18, 12, 9, 3, 3
	tilemap_rect_end
.rl_205:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 2, 4, 3, 3
	panel_rect 3, 18, 8, 4, 3, 3
	panel_rect 6, 18, 14, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.rl_206:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 1, 4, 3, 3
	panel_rect 3, 18, 7, 4, 3, 3
	panel_rect 6, 18, 13, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.rl_207:
	panel_rect 0, 27, 0, 0, 20, 2
	panel_rect 0, 18, 31, 3, 3, 3
	panel_rect 3, 18, 5, 4, 3, 3
	panel_rect 6, 18, 11, 4, 3, 3
	panel_rect 9, 18, 5, 9, 3, 3
	panel_rect 15, 18, 11, 9, 3, 3
	tilemap_rect_end
.rl_208:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 28, 3, 3, 3
	panel_rect 3, 18, 2, 4, 3, 3
	panel_rect 6, 18, 8, 4, 3, 3
	panel_rect 9, 18, 4, 9, 3, 3
	panel_rect 15, 18, 10, 9, 3, 3
	tilemap_rect_end
.rl_209:
	panel_rect 0, 28, 0, 0, 20, 1
	panel_rect 0, 18, 25, 3, 3, 3
	panel_rect 3, 18, 31, 3, 3, 3
	panel_rect 6, 18, 5, 4, 3, 3
	panel_rect 9, 18, 2, 9, 3, 3
	panel_rect 15, 18, 8, 9, 3, 3
	tilemap_rect_end
.rl_210:
	panel_rect 3, 18, 28, 3, 3, 3
	panel_rect 6, 18, 2, 4, 3, 3
	panel_rect 9, 18, 31, 8, 3, 3
	panel_rect 15, 18, 5, 9, 3, 3
	tilemap_rect_end
.rl_211:
	panel_rect 6, 18, 31, 3, 3, 3
	panel_rect 9, 18, 28, 8, 3, 3
	panel_rect 15, 18, 2, 9, 3, 3
	tilemap_rect_end
.rl_212:
	panel_rect 9, 18, 25, 8, 3, 3
	panel_rect 15, 18, 31, 8, 3, 3
	tilemap_rect_end
.rl_213:
	panel_rect 15, 18, 28, 8, 3, 3
	tilemap_rect_end
.pastEnd:
