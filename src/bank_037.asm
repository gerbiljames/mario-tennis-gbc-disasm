SECTION "ROM Bank $37", ROMX[$4000], BANK[$37]

	farptr FetchDialogueText_37 ; $4000
	farptr FetchShortText_37 ; $4002
FetchTextTable_37:
	; $4004, 512 bytes (text_offsets)
	dw TextStrings_37.s0 - TextStrings_37 ; 0
	dw TextStrings_37.s1 - TextStrings_37 ; 1
	dw TextStrings_37.s2 - TextStrings_37 ; 2
	dw TextStrings_37.s3 - TextStrings_37 ; 3
	dw TextStrings_37.s4 - TextStrings_37 ; 4
	dw TextStrings_37.s5 - TextStrings_37 ; 5
	dw TextStrings_37.s6 - TextStrings_37 ; 6
	dw TextStrings_37.s7 - TextStrings_37 ; 7
	dw TextStrings_37.s8 - TextStrings_37 ; 8
	dw TextStrings_37.s9 - TextStrings_37 ; 9
	dw TextStrings_37.s10 - TextStrings_37 ; 10
	dw TextStrings_37.s11 - TextStrings_37 ; 11
	dw TextStrings_37.s12 - TextStrings_37 ; 12
	dw TextStrings_37.s13 - TextStrings_37 ; 13
	dw TextStrings_37.s14 - TextStrings_37 ; 14
	dw TextStrings_37.s15 - TextStrings_37 ; 15
	dw TextStrings_37.s16 - TextStrings_37 ; 16
	dw TextStrings_37.s17 - TextStrings_37 ; 17
	dw TextStrings_37.s19 - TextStrings_37 ; 18
	dw TextStrings_37.s20 - TextStrings_37 ; 19
	dw TextStrings_37.s22 - TextStrings_37 ; 20
	dw TextStrings_37.s24 - TextStrings_37 ; 21
	dw TextStrings_37.s26 - TextStrings_37 ; 22
	dw TextStrings_37.s27 - TextStrings_37 ; 23
	dw TextStrings_37.s29 - TextStrings_37 ; 24
	dw TextStrings_37.s30 - TextStrings_37 ; 25
	dw TextStrings_37.s32 - TextStrings_37 ; 26
	dw TextStrings_37.s34 - TextStrings_37 ; 27
	dw TextStrings_37.s36 - TextStrings_37 ; 28
	dw TextStrings_37.s38 - TextStrings_37 ; 29
	dw TextStrings_37.s40 - TextStrings_37 ; 30
	dw TextStrings_37.s42 - TextStrings_37 ; 31
	dw TextStrings_37.s44 - TextStrings_37 ; 32
	dw TextStrings_37.s46 - TextStrings_37 ; 33
	dw TextStrings_37.s48 - TextStrings_37 ; 34
	dw TextStrings_37.s50 - TextStrings_37 ; 35
	dw TextStrings_37.s52 - TextStrings_37 ; 36
	dw TextStrings_37.s53 - TextStrings_37 ; 37
	dw TextStrings_37.s55 - TextStrings_37 ; 38
	dw TextStrings_37.s56 - TextStrings_37 ; 39
	dw TextStrings_37.s58 - TextStrings_37 ; 40
	dw TextStrings_37.s60 - TextStrings_37 ; 41
	dw TextStrings_37.s62 - TextStrings_37 ; 42
	dw TextStrings_37.s64 - TextStrings_37 ; 43
	dw TextStrings_37.s66 - TextStrings_37 ; 44
	dw TextStrings_37.s68 - TextStrings_37 ; 45
	dw TextStrings_37.s70 - TextStrings_37 ; 46
	dw TextStrings_37.s72 - TextStrings_37 ; 47
	dw TextStrings_37.s74 - TextStrings_37 ; 48
	dw TextStrings_37.s76 - TextStrings_37 ; 49
	dw TextStrings_37.s78 - TextStrings_37 ; 50
	dw TextStrings_37.s80 - TextStrings_37 ; 51
	dw TextStrings_37.s81 - TextStrings_37 ; 52
	dw TextStrings_37.s83 - TextStrings_37 ; 53
	dw TextStrings_37.s84 - TextStrings_37 ; 54
	dw TextStrings_37.s86 - TextStrings_37 ; 55
	dw TextStrings_37.s88 - TextStrings_37 ; 56
	dw TextStrings_37.s90 - TextStrings_37 ; 57
	dw TextStrings_37.s92 - TextStrings_37 ; 58
	dw TextStrings_37.s94 - TextStrings_37 ; 59
	dw TextStrings_37.s96 - TextStrings_37 ; 60
	dw TextStrings_37.s98 - TextStrings_37 ; 61
	dw TextStrings_37.s100 - TextStrings_37 ; 62
	dw TextStrings_37.s101 - TextStrings_37 ; 63
	dw TextStrings_37.s103 - TextStrings_37 ; 64
	dw TextStrings_37.s104 - TextStrings_37 ; 65
	dw TextStrings_37.s106 - TextStrings_37 ; 66
	dw TextStrings_37.s108 - TextStrings_37 ; 67
	dw TextStrings_37.s109 - TextStrings_37 ; 68
	dw TextStrings_37.s110 - TextStrings_37 ; 69
	dw TextStrings_37.s111 - TextStrings_37 ; 70
	dw TextStrings_37.s113 - TextStrings_37 ; 71
	dw TextStrings_37.s115 - TextStrings_37 ; 72
	dw TextStrings_37.s116 - TextStrings_37 ; 73
	dw TextStrings_37.s118 - TextStrings_37 ; 74
	dw TextStrings_37.s120 - TextStrings_37 ; 75
	dw TextStrings_37.s121 - TextStrings_37 ; 76
	dw TextStrings_37.s123 - TextStrings_37 ; 77
	dw TextStrings_37.s125 - TextStrings_37 ; 78
	dw TextStrings_37.s126 - TextStrings_37 ; 79
	dw TextStrings_37.s128 - TextStrings_37 ; 80
	dw TextStrings_37.s130 - TextStrings_37 ; 81
	dw TextStrings_37.s131 - TextStrings_37 ; 82
	dw TextStrings_37.s133 - TextStrings_37 ; 83
	dw TextStrings_37.s135 - TextStrings_37 ; 84
	dw TextStrings_37.s136 - TextStrings_37 ; 85
	dw TextStrings_37.s138 - TextStrings_37 ; 86
	dw TextStrings_37.s140 - TextStrings_37 ; 87
	dw TextStrings_37.s141 - TextStrings_37 ; 88
	dw TextStrings_37.s143 - TextStrings_37 ; 89
	dw TextStrings_37.s145 - TextStrings_37 ; 90
	dw TextStrings_37.s146 - TextStrings_37 ; 91
	dw TextStrings_37.s148 - TextStrings_37 ; 92
	dw TextStrings_37.s150 - TextStrings_37 ; 93
	dw TextStrings_37.s151 - TextStrings_37 ; 94
	dw TextStrings_37.s153 - TextStrings_37 ; 95
	dw TextStrings_37.s154 - TextStrings_37 ; 96
	dw TextStrings_37.s156 - TextStrings_37 ; 97
	dw TextStrings_37.s158 - TextStrings_37 ; 98
	dw TextStrings_37.s160 - TextStrings_37 ; 99
	dw TextStrings_37.s162 - TextStrings_37 ; 100
	dw TextStrings_37.s163 - TextStrings_37 ; 101
	dw TextStrings_37.s165 - TextStrings_37 ; 102
	dw TextStrings_37.s166 - TextStrings_37 ; 103
	dw TextStrings_37.s168 - TextStrings_37 ; 104
	dw TextStrings_37.s170 - TextStrings_37 ; 105
	dw TextStrings_37.s172 - TextStrings_37 ; 106
	dw TextStrings_37.s174 - TextStrings_37 ; 107
	dw TextStrings_37.s176 - TextStrings_37 ; 108
	dw TextStrings_37.s177 - TextStrings_37 ; 109
	dw TextStrings_37.s179 - TextStrings_37 ; 110
	dw TextStrings_37.s181 - TextStrings_37 ; 111
	dw TextStrings_37.s183 - TextStrings_37 ; 112
	dw TextStrings_37.s184 - TextStrings_37 ; 113
	dw TextStrings_37.s186 - TextStrings_37 ; 114
	dw TextStrings_37.s188 - TextStrings_37 ; 115
	dw TextStrings_37.s190 - TextStrings_37 ; 116
	dw TextStrings_37.s191 - TextStrings_37 ; 117
	dw TextStrings_37.s193 - TextStrings_37 ; 118
	dw TextStrings_37.s195 - TextStrings_37 ; 119
	dw TextStrings_37.s197 - TextStrings_37 ; 120
	dw TextStrings_37.s198 - TextStrings_37 ; 121
	dw TextStrings_37.s200 - TextStrings_37 ; 122
	dw TextStrings_37.s202 - TextStrings_37 ; 123
	dw TextStrings_37.s203 - TextStrings_37 ; 124
	dw TextStrings_37.s205 - TextStrings_37 ; 125
	dw TextStrings_37.s207 - TextStrings_37 ; 126
	dw TextStrings_37.s209 - TextStrings_37 ; 127
	dw TextStrings_37.s211 - TextStrings_37 ; 128
	dw TextStrings_37.s213 - TextStrings_37 ; 129
	dw TextStrings_37.s215 - TextStrings_37 ; 130
	dw TextStrings_37.s217 - TextStrings_37 ; 131
	dw TextStrings_37.s219 - TextStrings_37 ; 132
	dw TextStrings_37.s221 - TextStrings_37 ; 133
	dw TextStrings_37.s223 - TextStrings_37 ; 134
	dw TextStrings_37.s224 - TextStrings_37 ; 135
	dw TextStrings_37.s226 - TextStrings_37 ; 136
	dw TextStrings_37.s227 - TextStrings_37 ; 137
	dw TextStrings_37.s229 - TextStrings_37 ; 138
	dw TextStrings_37.s230 - TextStrings_37 ; 139
	dw TextStrings_37.s232 - TextStrings_37 ; 140
	dw TextStrings_37.s234 - TextStrings_37 ; 141
	dw TextStrings_37.s236 - TextStrings_37 ; 142
	dw TextStrings_37.s238 - TextStrings_37 ; 143
	dw TextStrings_37.s240 - TextStrings_37 ; 144
	dw TextStrings_37.s242 - TextStrings_37 ; 145
	dw TextStrings_37.s243 - TextStrings_37 ; 146
	dw TextStrings_37.s245 - TextStrings_37 ; 147
	dw TextStrings_37.s247 - TextStrings_37 ; 148
	dw TextStrings_37.s248 - TextStrings_37 ; 149
	dw TextStrings_37.s250 - TextStrings_37 ; 150
	dw TextStrings_37.s252 - TextStrings_37 ; 151
	dw TextStrings_37.s254 - TextStrings_37 ; 152
	dw TextStrings_37.s256 - TextStrings_37 ; 153
	dw TextStrings_37.s258 - TextStrings_37 ; 154
	dw TextStrings_37.s260 - TextStrings_37 ; 155
	dw TextStrings_37.s262 - TextStrings_37 ; 156
	dw TextStrings_37.s264 - TextStrings_37 ; 157
	dw TextStrings_37.s266 - TextStrings_37 ; 158
	dw TextStrings_37.s268 - TextStrings_37 ; 159
	dw TextStrings_37.s269 - TextStrings_37 ; 160
	dw TextStrings_37.s271 - TextStrings_37 ; 161
	dw TextStrings_37.s272 - TextStrings_37 ; 162
	dw TextStrings_37.s274 - TextStrings_37 ; 163
	dw TextStrings_37.s275 - TextStrings_37 ; 164
	dw TextStrings_37.s277 - TextStrings_37 ; 165
	dw TextStrings_37.s279 - TextStrings_37 ; 166
	dw TextStrings_37.s281 - TextStrings_37 ; 167
	dw TextStrings_37.s283 - TextStrings_37 ; 168
	dw TextStrings_37.s285 - TextStrings_37 ; 169
	dw TextStrings_37.s286 - TextStrings_37 ; 170
	dw TextStrings_37.s288 - TextStrings_37 ; 171
	dw TextStrings_37.s290 - TextStrings_37 ; 172
	dw TextStrings_37.s292 - TextStrings_37 ; 173
	dw TextStrings_37.s293 - TextStrings_37 ; 174
	dw TextStrings_37.s295 - TextStrings_37 ; 175
	dw TextStrings_37.s297 - TextStrings_37 ; 176
	dw TextStrings_37.s299 - TextStrings_37 ; 177
	dw TextStrings_37.s300 - TextStrings_37 ; 178
	dw TextStrings_37.s302 - TextStrings_37 ; 179
	dw TextStrings_37.s304 - TextStrings_37 ; 180
	dw TextStrings_37.s305 - TextStrings_37 ; 181
	dw TextStrings_37.s307 - TextStrings_37 ; 182
	dw TextStrings_37.s309 - TextStrings_37 ; 183
	dw TextStrings_37.s311 - TextStrings_37 ; 184
	dw TextStrings_37.s313 - TextStrings_37 ; 185
	dw TextStrings_37.s315 - TextStrings_37 ; 186
	dw TextStrings_37.s317 - TextStrings_37 ; 187
	dw TextStrings_37.s319 - TextStrings_37 ; 188
	dw TextStrings_37.s321 - TextStrings_37 ; 189
	dw TextStrings_37.s322 - TextStrings_37 ; 190
	dw TextStrings_37.s324 - TextStrings_37 ; 191
	dw TextStrings_37.s326 - TextStrings_37 ; 192
	dw TextStrings_37.s328 - TextStrings_37 ; 193
	dw TextStrings_37.s329 - TextStrings_37 ; 194
	dw TextStrings_37.s331 - TextStrings_37 ; 195
	dw TextStrings_37.s333 - TextStrings_37 ; 196
	dw TextStrings_37.s334 - TextStrings_37 ; 197
	dw TextStrings_37.s335 - TextStrings_37 ; 198
	dw TextStrings_37.s337 - TextStrings_37 ; 199
	dw TextStrings_37.s338 - TextStrings_37 ; 200
	dw TextStrings_37.s340 - TextStrings_37 ; 201
	dw TextStrings_37.s342 - TextStrings_37 ; 202
	dw TextStrings_37.s344 - TextStrings_37 ; 203
	dw TextStrings_37.s346 - TextStrings_37 ; 204
	dw TextStrings_37.s347 - TextStrings_37 ; 205
	dw TextStrings_37.s349 - TextStrings_37 ; 206
	dw TextStrings_37.s351 - TextStrings_37 ; 207
	dw TextStrings_37.s353 - TextStrings_37 ; 208
	dw TextStrings_37.s354 - TextStrings_37 ; 209
	dw TextStrings_37.s356 - TextStrings_37 ; 210
	dw TextStrings_37.s358 - TextStrings_37 ; 211
	dw TextStrings_37.s360 - TextStrings_37 ; 212
	dw TextStrings_37.s361 - TextStrings_37 ; 213
	dw TextStrings_37.s363 - TextStrings_37 ; 214
	dw TextStrings_37.s365 - TextStrings_37 ; 215
	dw TextStrings_37.s366 - TextStrings_37 ; 216
	dw TextStrings_37.s368 - TextStrings_37 ; 217
	dw TextStrings_37.s370 - TextStrings_37 ; 218
	dw TextStrings_37.s371 - TextStrings_37 ; 219
	dw TextStrings_37.s373 - TextStrings_37 ; 220
	dw TextStrings_37.s375 - TextStrings_37 ; 221
	dw TextStrings_37.s377 - TextStrings_37 ; 222
	dw TextStrings_37.s379 - TextStrings_37 ; 223
	dw TextStrings_37.s381 - TextStrings_37 ; 224
	dw TextStrings_37.s383 - TextStrings_37 ; 225
	dw TextStrings_37.s385 - TextStrings_37 ; 226
	dw TextStrings_37.s387 - TextStrings_37 ; 227
	dw TextStrings_37.s388 - TextStrings_37 ; 228
	dw TextStrings_37.s390 - TextStrings_37 ; 229
	dw TextStrings_37.s391 - TextStrings_37 ; 230
	dw TextStrings_37.s393 - TextStrings_37 ; 231
	dw TextStrings_37.s395 - TextStrings_37 ; 232
	dw TextStrings_37.s397 - TextStrings_37 ; 233
	dw TextStrings_37.s398 - TextStrings_37 ; 234
	dw TextStrings_37.s400 - TextStrings_37 ; 235
	dw TextStrings_37.s402 - TextStrings_37 ; 236
	dw TextStrings_37.s403 - TextStrings_37 ; 237
	dw TextStrings_37.s405 - TextStrings_37 ; 238
	dw TextStrings_37.s407 - TextStrings_37 ; 239
	dw TextStrings_37.s408 - TextStrings_37 ; 240
	dw TextStrings_37.s410 - TextStrings_37 ; 241
	dw TextStrings_37.s412 - TextStrings_37 ; 242
	dw TextStrings_37.s413 - TextStrings_37 ; 243
	dw TextStrings_37.s415 - TextStrings_37 ; 244
	dw TextStrings_37.s417 - TextStrings_37 ; 245
	dw TextStrings_37.s419 - TextStrings_37 ; 246
	dw TextStrings_37.s421 - TextStrings_37 ; 247
	dw TextStrings_37.s423 - TextStrings_37 ; 248
	dw TextStrings_37.s425 - TextStrings_37 ; 249
	dw TextStrings_37.s426 - TextStrings_37 ; 250
	dw TextStrings_37.s428 - TextStrings_37 ; 251
	dw TextStrings_37.s429 - TextStrings_37 ; 252
	dw TextStrings_37.s431 - TextStrings_37 ; 253
	dw TextStrings_37.s433 - TextStrings_37 ; 254
	dw TextStrings_37.s435 - TextStrings_37 ; 255
TextStrings_37:
	INCLUDE "data/bank_037/TextStrings_37.asm" ; $4204, 14618 bytes (text_pool)
FetchDialogueText_37:
	push af ; $7b1e
	ld a, $00 ; $7b1f
	call FetchText_37 ; $7b21
	pop af ; $7b24
	ret ; $7b25
FetchShortText_37:
	push af ; $7b26
	ld a, $01 ; $7b27
	call FetchText_37 ; $7b29
	pop af ; $7b2c
	ret ; $7b2d
; Instruction-identical to FetchText_1f, FetchText_25, FetchText_26, FetchText_30, FetchText_31, FetchText_32, FetchText_33, FetchText_34, FetchText_35, FetchText_36, FetchText_5e and FetchText_6e (one copy per bank); a change here belongs in every copy.
FetchText_37:
	push bc ; $7b2e
	push de ; $7b2f
	push hl ; $7b30
	ld hl, FetchTextTable_37 ; $7b31
	sla e ; $7b34
	rl d ; $7b36
	add hl, de ; $7b38
	ld e, [hl] ; $7b39
	inc hl ; $7b3a
	ld d, [hl] ; $7b3b
	ld hl, TextStrings_37 ; $7b3c
	add hl, de ; $7b3f
	or a ; $7b40
	jr nz, .nonZero ; $7b41
	ld de, wTextBuffer ; $7b43
	ld c, $a0 ; $7b46
	jr .loop ; $7b48
.nonZero:
	ld de, wShortTextBuffer ; $7b4a
	ld c, $10 ; $7b4d
.loop:
	dec c ; $7b4f
	jr z, .countDone ; $7b50
	ld a, [hl+] ; $7b52
	ld [de], a ; $7b53
	inc de ; $7b54
	or a ; $7b55
	jr nz, .loop ; $7b56
	pop hl ; $7b58
	pop de ; $7b59
	pop bc ; $7b5a
	ret ; $7b5b
.countDone:
	xor a ; $7b5c
	ld [de], a ; $7b5d
	ldh a, [hDebugStepMode] ; $7b5e
	or a ; $7b60
	jr z, .restore ; $7b61
	sound BGM_CREDITS ; $7b63
.restore:
	pop hl ; $7b65
	pop de ; $7b66
	pop bc ; $7b67
	ret ; $7b68
	; $7b69, 1175 bytes fill to bank end (linker-padded)
