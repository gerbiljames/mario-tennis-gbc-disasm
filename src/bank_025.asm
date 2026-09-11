SECTION "ROM Bank $25", ROMX[$4000], BANK[$25]

	farptr FetchDialogueText_25 ; $4000
	farptr FetchShortText_25 ; $4002
FetchTextTable_25:
	; $4004, 534 bytes (text_offsets)
	dw TextStrings_25.s0 - TextStrings_25 ; 0
	dw TextStrings_25.s2 - TextStrings_25 ; 1
	dw TextStrings_25.s4 - TextStrings_25 ; 2
	dw TextStrings_25.s6 - TextStrings_25 ; 3
	dw TextStrings_25.s8 - TextStrings_25 ; 4
	dw TextStrings_25.s10 - TextStrings_25 ; 5
	dw TextStrings_25.s12 - TextStrings_25 ; 6
	dw TextStrings_25.s14 - TextStrings_25 ; 7
	dw TextStrings_25.s16 - TextStrings_25 ; 8
	dw TextStrings_25.s18 - TextStrings_25 ; 9
	dw TextStrings_25.s20 - TextStrings_25 ; 10
	dw TextStrings_25.s22 - TextStrings_25 ; 11
	dw TextStrings_25.s24 - TextStrings_25 ; 12
	dw TextStrings_25.s26 - TextStrings_25 ; 13
	dw TextStrings_25.s28 - TextStrings_25 ; 14
	dw TextStrings_25.s30 - TextStrings_25 ; 15
	dw TextStrings_25.s32 - TextStrings_25 ; 16
	dw TextStrings_25.s34 - TextStrings_25 ; 17
	dw TextStrings_25.s36 - TextStrings_25 ; 18
	dw TextStrings_25.s38 - TextStrings_25 ; 19
	dw TextStrings_25.s40 - TextStrings_25 ; 20
	dw TextStrings_25.s42 - TextStrings_25 ; 21
	dw TextStrings_25.s44 - TextStrings_25 ; 22
	dw TextStrings_25.s46 - TextStrings_25 ; 23
	dw TextStrings_25.s48 - TextStrings_25 ; 24
	dw TextStrings_25.s50 - TextStrings_25 ; 25
	dw TextStrings_25.s52 - TextStrings_25 ; 26
	dw TextStrings_25.s54 - TextStrings_25 ; 27
	dw TextStrings_25.s56 - TextStrings_25 ; 28
	dw TextStrings_25.s58 - TextStrings_25 ; 29
	dw TextStrings_25.s60 - TextStrings_25 ; 30
	dw TextStrings_25.s61 - TextStrings_25 ; 31
	dw TextStrings_25.s63 - TextStrings_25 ; 32
	dw TextStrings_25.s65 - TextStrings_25 ; 33
	dw TextStrings_25.s66 - TextStrings_25 ; 34
	dw TextStrings_25.s68 - TextStrings_25 ; 35
	dw TextStrings_25.s70 - TextStrings_25 ; 36
	dw TextStrings_25.s72 - TextStrings_25 ; 37
	dw TextStrings_25.s73 - TextStrings_25 ; 38
	dw TextStrings_25.s75 - TextStrings_25 ; 39
	dw TextStrings_25.s77 - TextStrings_25 ; 40
	dw TextStrings_25.s79 - TextStrings_25 ; 41
	dw TextStrings_25.s81 - TextStrings_25 ; 42
	dw TextStrings_25.s83 - TextStrings_25 ; 43
	dw TextStrings_25.s85 - TextStrings_25 ; 44
	dw TextStrings_25.s86 - TextStrings_25 ; 45
	dw TextStrings_25.s88 - TextStrings_25 ; 46
	dw TextStrings_25.s90 - TextStrings_25 ; 47
	dw TextStrings_25.s92 - TextStrings_25 ; 48
	dw TextStrings_25.s94 - TextStrings_25 ; 49
	dw TextStrings_25.s96 - TextStrings_25 ; 50
	dw TextStrings_25.s98 - TextStrings_25 ; 51
	dw TextStrings_25.s99 - TextStrings_25 ; 52
	dw TextStrings_25.s101 - TextStrings_25 ; 53
	dw TextStrings_25.s103 - TextStrings_25 ; 54
	dw TextStrings_25.s105 - TextStrings_25 ; 55
	dw TextStrings_25.s107 - TextStrings_25 ; 56
	dw TextStrings_25.s109 - TextStrings_25 ; 57
	dw TextStrings_25.s111 - TextStrings_25 ; 58
	dw TextStrings_25.s113 - TextStrings_25 ; 59
	dw TextStrings_25.s115 - TextStrings_25 ; 60
	dw TextStrings_25.s117 - TextStrings_25 ; 61
	dw TextStrings_25.s118 - TextStrings_25 ; 62
	dw TextStrings_25.s120 - TextStrings_25 ; 63
	dw TextStrings_25.s122 - TextStrings_25 ; 64
	dw TextStrings_25.s124 - TextStrings_25 ; 65
	dw TextStrings_25.s126 - TextStrings_25 ; 66
	dw TextStrings_25.s128 - TextStrings_25 ; 67
	dw TextStrings_25.s130 - TextStrings_25 ; 68
	dw TextStrings_25.s132 - TextStrings_25 ; 69
	dw TextStrings_25.s134 - TextStrings_25 ; 70
	dw TextStrings_25.s136 - TextStrings_25 ; 71
	dw TextStrings_25.s138 - TextStrings_25 ; 72
	dw TextStrings_25.s140 - TextStrings_25 ; 73
	dw TextStrings_25.s142 - TextStrings_25 ; 74
	dw TextStrings_25.s144 - TextStrings_25 ; 75
	dw TextStrings_25.s146 - TextStrings_25 ; 76
	dw TextStrings_25.s148 - TextStrings_25 ; 77
	dw TextStrings_25.s150 - TextStrings_25 ; 78
	dw TextStrings_25.s152 - TextStrings_25 ; 79
	dw TextStrings_25.s154 - TextStrings_25 ; 80
	dw TextStrings_25.s156 - TextStrings_25 ; 81
	dw TextStrings_25.s158 - TextStrings_25 ; 82
	dw TextStrings_25.s160 - TextStrings_25 ; 83
	dw TextStrings_25.s162 - TextStrings_25 ; 84
	dw TextStrings_25.s164 - TextStrings_25 ; 85
	dw TextStrings_25.s166 - TextStrings_25 ; 86
	dw TextStrings_25.s168 - TextStrings_25 ; 87
	dw TextStrings_25.s170 - TextStrings_25 ; 88
	dw TextStrings_25.s172 - TextStrings_25 ; 89
	dw TextStrings_25.s174 - TextStrings_25 ; 90
	dw TextStrings_25.s176 - TextStrings_25 ; 91
	dw TextStrings_25.s178 - TextStrings_25 ; 92
	dw TextStrings_25.s180 - TextStrings_25 ; 93
	dw TextStrings_25.s182 - TextStrings_25 ; 94
	dw TextStrings_25.s184 - TextStrings_25 ; 95
	dw TextStrings_25.s186 - TextStrings_25 ; 96
	dw TextStrings_25.s188 - TextStrings_25 ; 97
	dw TextStrings_25.s189 - TextStrings_25 ; 98
	dw TextStrings_25.s190 - TextStrings_25 ; 99
	dw TextStrings_25.s191 - TextStrings_25 ; 100
	dw TextStrings_25.s192 - TextStrings_25 ; 101
	dw TextStrings_25.s193 - TextStrings_25 ; 102
	dw TextStrings_25.s194 - TextStrings_25 ; 103
	dw TextStrings_25.s195 - TextStrings_25 ; 104
	dw TextStrings_25.s196 - TextStrings_25 ; 105
	dw TextStrings_25.s198 - TextStrings_25 ; 106
	dw TextStrings_25.s200 - TextStrings_25 ; 107
	dw TextStrings_25.s202 - TextStrings_25 ; 108
	dw TextStrings_25.s204 - TextStrings_25 ; 109
	dw TextStrings_25.s206 - TextStrings_25 ; 110
	dw TextStrings_25.s208 - TextStrings_25 ; 111
	dw TextStrings_25.s210 - TextStrings_25 ; 112
	dw TextStrings_25.s212 - TextStrings_25 ; 113
	dw TextStrings_25.s214 - TextStrings_25 ; 114
	dw TextStrings_25.s216 - TextStrings_25 ; 115
	dw TextStrings_25.s218 - TextStrings_25 ; 116
	dw TextStrings_25.s220 - TextStrings_25 ; 117
	dw TextStrings_25.s222 - TextStrings_25 ; 118
	dw TextStrings_25.s224 - TextStrings_25 ; 119
	dw TextStrings_25.s226 - TextStrings_25 ; 120
	dw TextStrings_25.s228 - TextStrings_25 ; 121
	dw TextStrings_25.s230 - TextStrings_25 ; 122
	dw TextStrings_25.s232 - TextStrings_25 ; 123
	dw TextStrings_25.s234 - TextStrings_25 ; 124
	dw TextStrings_25.s236 - TextStrings_25 ; 125
	dw TextStrings_25.s238 - TextStrings_25 ; 126
	dw TextStrings_25.s240 - TextStrings_25 ; 127
	dw TextStrings_25.s242 - TextStrings_25 ; 128
	dw TextStrings_25.s244 - TextStrings_25 ; 129
	dw TextStrings_25.s246 - TextStrings_25 ; 130
	dw TextStrings_25.s248 - TextStrings_25 ; 131
	dw TextStrings_25.s250 - TextStrings_25 ; 132
	dw TextStrings_25.s252 - TextStrings_25 ; 133
	dw TextStrings_25.s254 - TextStrings_25 ; 134
	dw TextStrings_25.s256 - TextStrings_25 ; 135
	dw TextStrings_25.s258 - TextStrings_25 ; 136
	dw TextStrings_25.s260 - TextStrings_25 ; 137
	dw TextStrings_25.s262 - TextStrings_25 ; 138
	dw TextStrings_25.s264 - TextStrings_25 ; 139
	dw TextStrings_25.s266 - TextStrings_25 ; 140
	dw TextStrings_25.s268 - TextStrings_25 ; 141
	dw TextStrings_25.s270 - TextStrings_25 ; 142
	dw TextStrings_25.s272 - TextStrings_25 ; 143
	dw TextStrings_25.s274 - TextStrings_25 ; 144
	dw TextStrings_25.s276 - TextStrings_25 ; 145
	dw TextStrings_25.s278 - TextStrings_25 ; 146
	dw TextStrings_25.s280 - TextStrings_25 ; 147
	dw TextStrings_25.s282 - TextStrings_25 ; 148
	dw TextStrings_25.s284 - TextStrings_25 ; 149
	dw TextStrings_25.s286 - TextStrings_25 ; 150
	dw TextStrings_25.s288 - TextStrings_25 ; 151
	dw TextStrings_25.s290 - TextStrings_25 ; 152
	dw TextStrings_25.s292 - TextStrings_25 ; 153
	dw TextStrings_25.s294 - TextStrings_25 ; 154
	dw TextStrings_25.s296 - TextStrings_25 ; 155
	dw TextStrings_25.s298 - TextStrings_25 ; 156
	dw TextStrings_25.s300 - TextStrings_25 ; 157
	dw TextStrings_25.s302 - TextStrings_25 ; 158
	dw TextStrings_25.s304 - TextStrings_25 ; 159
	dw TextStrings_25.s306 - TextStrings_25 ; 160
	dw TextStrings_25.s308 - TextStrings_25 ; 161
	dw TextStrings_25.s310 - TextStrings_25 ; 162
	dw TextStrings_25.s312 - TextStrings_25 ; 163
	dw TextStrings_25.s314 - TextStrings_25 ; 164
	dw TextStrings_25.s316 - TextStrings_25 ; 165
	dw TextStrings_25.s318 - TextStrings_25 ; 166
	dw TextStrings_25.s320 - TextStrings_25 ; 167
	dw TextStrings_25.s322 - TextStrings_25 ; 168
	dw TextStrings_25.s324 - TextStrings_25 ; 169
	dw TextStrings_25.s326 - TextStrings_25 ; 170
	dw TextStrings_25.s328 - TextStrings_25 ; 171
	dw TextStrings_25.s330 - TextStrings_25 ; 172
	dw TextStrings_25.s332 - TextStrings_25 ; 173
	dw TextStrings_25.s334 - TextStrings_25 ; 174
	dw TextStrings_25.s336 - TextStrings_25 ; 175
	dw TextStrings_25.s338 - TextStrings_25 ; 176
	dw TextStrings_25.s340 - TextStrings_25 ; 177
	dw TextStrings_25.s342 - TextStrings_25 ; 178
	dw TextStrings_25.s344 - TextStrings_25 ; 179
	dw TextStrings_25.s346 - TextStrings_25 ; 180
	dw TextStrings_25.s348 - TextStrings_25 ; 181
	dw TextStrings_25.s350 - TextStrings_25 ; 182
	dw TextStrings_25.s352 - TextStrings_25 ; 183
	dw TextStrings_25.s354 - TextStrings_25 ; 184
	dw TextStrings_25.s356 - TextStrings_25 ; 185
	dw TextStrings_25.s358 - TextStrings_25 ; 186
	dw TextStrings_25.s360 - TextStrings_25 ; 187
	dw TextStrings_25.s362 - TextStrings_25 ; 188
	dw TextStrings_25.s364 - TextStrings_25 ; 189
	dw TextStrings_25.s366 - TextStrings_25 ; 190
	dw TextStrings_25.s368 - TextStrings_25 ; 191
	dw TextStrings_25.s370 - TextStrings_25 ; 192
	dw TextStrings_25.s372 - TextStrings_25 ; 193
	dw TextStrings_25.s374 - TextStrings_25 ; 194
	dw TextStrings_25.s376 - TextStrings_25 ; 195
	dw TextStrings_25.s378 - TextStrings_25 ; 196
	dw TextStrings_25.s379 - TextStrings_25 ; 197
	dw TextStrings_25.s380 - TextStrings_25 ; 198
	dw TextStrings_25.s381 - TextStrings_25 ; 199
	dw TextStrings_25.s382 - TextStrings_25 ; 200
	dw TextStrings_25.s383 - TextStrings_25 ; 201
	dw TextStrings_25.s384 - TextStrings_25 ; 202
	dw TextStrings_25.s385 - TextStrings_25 ; 203
	dw TextStrings_25.s386 - TextStrings_25 ; 204
	dw TextStrings_25.s387 - TextStrings_25 ; 205
	dw TextStrings_25.s388 - TextStrings_25 ; 206
	dw TextStrings_25.s389 - TextStrings_25 ; 207
	dw TextStrings_25.s390 - TextStrings_25 ; 208
	dw TextStrings_25.s391 - TextStrings_25 ; 209
	dw TextStrings_25.s392 - TextStrings_25 ; 210
	dw TextStrings_25.s393 - TextStrings_25 ; 211
	dw TextStrings_25.s394 - TextStrings_25 ; 212
	dw TextStrings_25.s395 - TextStrings_25 ; 213
	dw TextStrings_25.s396 - TextStrings_25 ; 214
	dw TextStrings_25.s397 - TextStrings_25 ; 215
	dw TextStrings_25.s398 - TextStrings_25 ; 216
	dw TextStrings_25.s399 - TextStrings_25 ; 217
	dw TextStrings_25.s400 - TextStrings_25 ; 218
	dw TextStrings_25.s401 - TextStrings_25 ; 219
	dw TextStrings_25.s402 - TextStrings_25 ; 220
	dw TextStrings_25.s403 - TextStrings_25 ; 221
	dw TextStrings_25.s404 - TextStrings_25 ; 222
	dw TextStrings_25.s405 - TextStrings_25 ; 223
	dw TextStrings_25.s406 - TextStrings_25 ; 224
	dw TextStrings_25.s407 - TextStrings_25 ; 225
	dw TextStrings_25.s408 - TextStrings_25 ; 226
	dw TextStrings_25.s409 - TextStrings_25 ; 227
	dw TextStrings_25.s410 - TextStrings_25 ; 228
	dw TextStrings_25.s411 - TextStrings_25 ; 229
	dw TextStrings_25.s412 - TextStrings_25 ; 230
	dw TextStrings_25.s413 - TextStrings_25 ; 231
	dw TextStrings_25.s414 - TextStrings_25 ; 232
	dw TextStrings_25.s415 - TextStrings_25 ; 233
	dw TextStrings_25.s416 - TextStrings_25 ; 234
	dw TextStrings_25.s417 - TextStrings_25 ; 235
	dw TextStrings_25.s418 - TextStrings_25 ; 236
	dw TextStrings_25.s419 - TextStrings_25 ; 237
	dw TextStrings_25.s420 - TextStrings_25 ; 238
	dw TextStrings_25.s421 - TextStrings_25 ; 239
	dw TextStrings_25.s422 - TextStrings_25 ; 240
	dw TextStrings_25.s423 - TextStrings_25 ; 241
	dw TextStrings_25.s424 - TextStrings_25 ; 242
	dw TextStrings_25.s425 - TextStrings_25 ; 243
	dw TextStrings_25.s426 - TextStrings_25 ; 244
	dw TextStrings_25.s427 - TextStrings_25 ; 245
	dw TextStrings_25.s428 - TextStrings_25 ; 246
	dw TextStrings_25.s429 - TextStrings_25 ; 247
	dw TextStrings_25.s430 - TextStrings_25 ; 248
	dw TextStrings_25.s431 - TextStrings_25 ; 249
	dw TextStrings_25.s432 - TextStrings_25 ; 250
	dw TextStrings_25.s433 - TextStrings_25 ; 251
	dw TextStrings_25.s434 - TextStrings_25 ; 252
	dw TextStrings_25.s435 - TextStrings_25 ; 253
	dw TextStrings_25.s436 - TextStrings_25 ; 254
	dw TextStrings_25.s437 - TextStrings_25 ; 255
	dw TextStrings_25.s438 - TextStrings_25 ; 256
	dw TextStrings_25.s439 - TextStrings_25 ; 257
	dw TextStrings_25.s440 - TextStrings_25 ; 258
	dw TextStrings_25.s441 - TextStrings_25 ; 259
	dw TextStrings_25.s442 - TextStrings_25 ; 260
	dw TextStrings_25.s443 - TextStrings_25 ; 261
	dw TextStrings_25.s444 - TextStrings_25 ; 262
	dw TextStrings_25.s445 - TextStrings_25 ; 263
	dw TextStrings_25.s446 - TextStrings_25 ; 264
	dw TextStrings_25.s447 - TextStrings_25 ; 265
	dw TextStrings_25.s448 - TextStrings_25 ; 266
TextStrings_25:
	INCLUDE "data/bank_025/TextStrings_25.asm" ; $421a, 14622 bytes (text_pool)
FetchDialogueText_25:
	push af ; $7b38
	ld a, $00 ; $7b39
	call FetchText_25 ; $7b3b
	pop af ; $7b3e
	ret ; $7b3f
FetchShortText_25:
	push af ; $7b40
	ld a, $01 ; $7b41
	call FetchText_25 ; $7b43
	pop af ; $7b46
	ret ; $7b47
; Instruction-identical to FetchText_1f, FetchText_26, FetchText_30, FetchText_31, FetchText_32, FetchText_33, FetchText_34, FetchText_35, FetchText_36, FetchText_37, FetchText_5e and FetchText_6e (one copy per bank); a change here belongs in every copy.
FetchText_25:
	push bc ; $7b48
	push de ; $7b49
	push hl ; $7b4a
	ld hl, FetchTextTable_25 ; $7b4b
	sla e ; $7b4e
	rl d ; $7b50
	add hl, de ; $7b52
	ld e, [hl] ; $7b53
	inc hl ; $7b54
	ld d, [hl] ; $7b55
	ld hl, TextStrings_25 ; $7b56
	add hl, de ; $7b59
	or a ; $7b5a
	jr nz, .nonZero ; $7b5b
	ld de, wTextBuffer ; $7b5d
	ld c, $a0 ; $7b60
	jr .loop ; $7b62
.nonZero:
	ld de, wShortTextBuffer ; $7b64
	ld c, $10 ; $7b67
.loop:
	dec c ; $7b69
	jr z, .countDone ; $7b6a
	ld a, [hl+] ; $7b6c
	ld [de], a ; $7b6d
	inc de ; $7b6e
	or a ; $7b6f
	jr nz, .loop ; $7b70
	pop hl ; $7b72
	pop de ; $7b73
	pop bc ; $7b74
	ret ; $7b75
.countDone:
	xor a ; $7b76
	ld [de], a ; $7b77
	ldh a, [hDebugStepMode] ; $7b78
	or a ; $7b7a
	jr z, .restore ; $7b7b
	sound BGM_CREDITS ; $7b7d
.restore:
	pop hl ; $7b7f
	pop de ; $7b80
	pop bc ; $7b81
	ret ; $7b82
	; $7b83, 1149 bytes fill to bank end (linker-padded)
