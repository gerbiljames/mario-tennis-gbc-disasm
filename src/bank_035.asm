SECTION "ROM Bank $35", ROMX[$4000], BANK[$35]

	farptr FetchDialogueText_35 ; $4000
	farptr FetchShortText_35 ; $4002
FetchTextTable_35:
	; $4004, 540 bytes (text_offsets)
	dw TextStrings_35.s0 - TextStrings_35 ; 0
	dw TextStrings_35.s1 - TextStrings_35 ; 1
	dw TextStrings_35.s2 - TextStrings_35 ; 2
	dw TextStrings_35.s3 - TextStrings_35 ; 3
	dw TextStrings_35.s4 - TextStrings_35 ; 4
	dw TextStrings_35.s5 - TextStrings_35 ; 5
	dw TextStrings_35.s6 - TextStrings_35 ; 6
	dw TextStrings_35.s7 - TextStrings_35 ; 7
	dw TextStrings_35.s8 - TextStrings_35 ; 8
	dw TextStrings_35.s9 - TextStrings_35 ; 9
	dw TextStrings_35.s10 - TextStrings_35 ; 10
	dw TextStrings_35.s11 - TextStrings_35 ; 11
	dw TextStrings_35.s12 - TextStrings_35 ; 12
	dw TextStrings_35.s13 - TextStrings_35 ; 13
	dw TextStrings_35.s14 - TextStrings_35 ; 14
	dw TextStrings_35.s15 - TextStrings_35 ; 15
	dw TextStrings_35.s16 - TextStrings_35 ; 16
	dw TextStrings_35.s17 - TextStrings_35 ; 17
	dw TextStrings_35.s18 - TextStrings_35 ; 18
	dw TextStrings_35.s19 - TextStrings_35 ; 19
	dw TextStrings_35.s20 - TextStrings_35 ; 20
	dw TextStrings_35.s21 - TextStrings_35 ; 21
	dw TextStrings_35.s22 - TextStrings_35 ; 22
	dw TextStrings_35.s23 - TextStrings_35 ; 23
	dw TextStrings_35.s24 - TextStrings_35 ; 24
	dw TextStrings_35.s25 - TextStrings_35 ; 25
	dw TextStrings_35.s26 - TextStrings_35 ; 26
	dw TextStrings_35.s27 - TextStrings_35 ; 27
	dw TextStrings_35.s28 - TextStrings_35 ; 28
	dw TextStrings_35.s29 - TextStrings_35 ; 29
	dw TextStrings_35.s30 - TextStrings_35 ; 30
	dw TextStrings_35.s31 - TextStrings_35 ; 31
	dw TextStrings_35.s32 - TextStrings_35 ; 32
	dw TextStrings_35.s33 - TextStrings_35 ; 33
	dw TextStrings_35.s34 - TextStrings_35 ; 34
	dw TextStrings_35.s35 - TextStrings_35 ; 35
	dw TextStrings_35.s36 - TextStrings_35 ; 36
	dw TextStrings_35.s37 - TextStrings_35 ; 37
	dw TextStrings_35.s38 - TextStrings_35 ; 38
	dw TextStrings_35.s39 - TextStrings_35 ; 39
	dw TextStrings_35.s40 - TextStrings_35 ; 40
	dw TextStrings_35.s41 - TextStrings_35 ; 41
	dw TextStrings_35.s42 - TextStrings_35 ; 42
	dw TextStrings_35.s43 - TextStrings_35 ; 43
	dw TextStrings_35.s44 - TextStrings_35 ; 44
	dw TextStrings_35.s45 - TextStrings_35 ; 45
	dw TextStrings_35.s46 - TextStrings_35 ; 46
	dw TextStrings_35.s47 - TextStrings_35 ; 47
	dw TextStrings_35.s48 - TextStrings_35 ; 48
	dw TextStrings_35.s50 - TextStrings_35 ; 49
	dw TextStrings_35.s52 - TextStrings_35 ; 50
	dw TextStrings_35.s54 - TextStrings_35 ; 51
	dw TextStrings_35.s56 - TextStrings_35 ; 52
	dw TextStrings_35.s58 - TextStrings_35 ; 53
	dw TextStrings_35.s60 - TextStrings_35 ; 54
	dw TextStrings_35.s62 - TextStrings_35 ; 55
	dw TextStrings_35.s64 - TextStrings_35 ; 56
	dw TextStrings_35.s66 - TextStrings_35 ; 57
	dw TextStrings_35.s68 - TextStrings_35 ; 58
	dw TextStrings_35.s70 - TextStrings_35 ; 59
	dw TextStrings_35.s72 - TextStrings_35 ; 60
	dw TextStrings_35.s74 - TextStrings_35 ; 61
	dw TextStrings_35.s76 - TextStrings_35 ; 62
	dw TextStrings_35.s78 - TextStrings_35 ; 63
	dw TextStrings_35.s80 - TextStrings_35 ; 64
	dw TextStrings_35.s82 - TextStrings_35 ; 65
	dw TextStrings_35.s84 - TextStrings_35 ; 66
	dw TextStrings_35.s86 - TextStrings_35 ; 67
	dw TextStrings_35.s88 - TextStrings_35 ; 68
	dw TextStrings_35.s90 - TextStrings_35 ; 69
	dw TextStrings_35.s92 - TextStrings_35 ; 70
	dw TextStrings_35.s94 - TextStrings_35 ; 71
	dw TextStrings_35.s96 - TextStrings_35 ; 72
	dw TextStrings_35.s98 - TextStrings_35 ; 73
	dw TextStrings_35.s100 - TextStrings_35 ; 74
	dw TextStrings_35.s102 - TextStrings_35 ; 75
	dw TextStrings_35.s104 - TextStrings_35 ; 76
	dw TextStrings_35.s106 - TextStrings_35 ; 77
	dw TextStrings_35.s108 - TextStrings_35 ; 78
	dw TextStrings_35.s110 - TextStrings_35 ; 79
	dw TextStrings_35.s112 - TextStrings_35 ; 80
	dw TextStrings_35.s114 - TextStrings_35 ; 81
	dw TextStrings_35.s116 - TextStrings_35 ; 82
	dw TextStrings_35.s118 - TextStrings_35 ; 83
	dw TextStrings_35.s120 - TextStrings_35 ; 84
	dw TextStrings_35.s122 - TextStrings_35 ; 85
	dw TextStrings_35.s124 - TextStrings_35 ; 86
	dw TextStrings_35.s126 - TextStrings_35 ; 87
	dw TextStrings_35.s128 - TextStrings_35 ; 88
	dw TextStrings_35.s130 - TextStrings_35 ; 89
	dw TextStrings_35.s132 - TextStrings_35 ; 90
	dw TextStrings_35.s134 - TextStrings_35 ; 91
	dw TextStrings_35.s136 - TextStrings_35 ; 92
	dw TextStrings_35.s138 - TextStrings_35 ; 93
	dw TextStrings_35.s140 - TextStrings_35 ; 94
	dw TextStrings_35.s142 - TextStrings_35 ; 95
	dw TextStrings_35.s144 - TextStrings_35 ; 96
	dw TextStrings_35.s146 - TextStrings_35 ; 97
	dw TextStrings_35.s148 - TextStrings_35 ; 98
	dw TextStrings_35.s150 - TextStrings_35 ; 99
	dw TextStrings_35.s152 - TextStrings_35 ; 100
	dw TextStrings_35.s154 - TextStrings_35 ; 101
	dw TextStrings_35.s156 - TextStrings_35 ; 102
	dw TextStrings_35.s158 - TextStrings_35 ; 103
	dw TextStrings_35.s160 - TextStrings_35 ; 104
	dw TextStrings_35.s162 - TextStrings_35 ; 105
	dw TextStrings_35.s164 - TextStrings_35 ; 106
	dw TextStrings_35.s166 - TextStrings_35 ; 107
	dw TextStrings_35.s168 - TextStrings_35 ; 108
	dw TextStrings_35.s170 - TextStrings_35 ; 109
	dw TextStrings_35.s172 - TextStrings_35 ; 110
	dw TextStrings_35.s174 - TextStrings_35 ; 111
	dw TextStrings_35.s176 - TextStrings_35 ; 112
	dw TextStrings_35.s178 - TextStrings_35 ; 113
	dw TextStrings_35.s180 - TextStrings_35 ; 114
	dw TextStrings_35.s182 - TextStrings_35 ; 115
	dw TextStrings_35.s184 - TextStrings_35 ; 116
	dw TextStrings_35.s186 - TextStrings_35 ; 117
	dw TextStrings_35.s188 - TextStrings_35 ; 118
	dw TextStrings_35.s190 - TextStrings_35 ; 119
	dw TextStrings_35.s192 - TextStrings_35 ; 120
	dw TextStrings_35.s194 - TextStrings_35 ; 121
	dw TextStrings_35.s196 - TextStrings_35 ; 122
	dw TextStrings_35.s198 - TextStrings_35 ; 123
	dw TextStrings_35.s200 - TextStrings_35 ; 124
	dw TextStrings_35.s202 - TextStrings_35 ; 125
	dw TextStrings_35.s204 - TextStrings_35 ; 126
	dw TextStrings_35.s206 - TextStrings_35 ; 127
	dw TextStrings_35.s208 - TextStrings_35 ; 128
	dw TextStrings_35.s210 - TextStrings_35 ; 129
	dw TextStrings_35.s212 - TextStrings_35 ; 130
	dw TextStrings_35.s214 - TextStrings_35 ; 131
	dw TextStrings_35.s216 - TextStrings_35 ; 132
	dw TextStrings_35.s218 - TextStrings_35 ; 133
	dw TextStrings_35.s220 - TextStrings_35 ; 134
	dw TextStrings_35.s222 - TextStrings_35 ; 135
	dw TextStrings_35.s224 - TextStrings_35 ; 136
	dw TextStrings_35.s226 - TextStrings_35 ; 137
	dw TextStrings_35.s228 - TextStrings_35 ; 138
	dw TextStrings_35.s230 - TextStrings_35 ; 139
	dw TextStrings_35.s232 - TextStrings_35 ; 140
	dw TextStrings_35.s234 - TextStrings_35 ; 141
	dw TextStrings_35.s236 - TextStrings_35 ; 142
	dw TextStrings_35.s238 - TextStrings_35 ; 143
	dw TextStrings_35.s239 - TextStrings_35 ; 144
	dw TextStrings_35.s240 - TextStrings_35 ; 145
	dw TextStrings_35.s241 - TextStrings_35 ; 146
	dw TextStrings_35.s242 - TextStrings_35 ; 147
	dw TextStrings_35.s243 - TextStrings_35 ; 148
	dw TextStrings_35.s244 - TextStrings_35 ; 149
	dw TextStrings_35.s245 - TextStrings_35 ; 150
	dw TextStrings_35.s246 - TextStrings_35 ; 151
	dw TextStrings_35.s247 - TextStrings_35 ; 152
	dw TextStrings_35.s248 - TextStrings_35 ; 153
	dw TextStrings_35.s249 - TextStrings_35 ; 154
	dw TextStrings_35.s250 - TextStrings_35 ; 155
	dw TextStrings_35.s251 - TextStrings_35 ; 156
	dw TextStrings_35.s252 - TextStrings_35 ; 157
	dw TextStrings_35.s253 - TextStrings_35 ; 158
	dw TextStrings_35.s254 - TextStrings_35 ; 159
	dw TextStrings_35.s255 - TextStrings_35 ; 160
	dw TextStrings_35.s256 - TextStrings_35 ; 161
	dw TextStrings_35.s257 - TextStrings_35 ; 162
	dw TextStrings_35.s258 - TextStrings_35 ; 163
	dw TextStrings_35.s259 - TextStrings_35 ; 164
	dw TextStrings_35.s260 - TextStrings_35 ; 165
	dw TextStrings_35.s261 - TextStrings_35 ; 166
	dw TextStrings_35.s262 - TextStrings_35 ; 167
	dw TextStrings_35.s263 - TextStrings_35 ; 168
	dw TextStrings_35.s264 - TextStrings_35 ; 169
	dw TextStrings_35.s266 - TextStrings_35 ; 170
	dw TextStrings_35.s268 - TextStrings_35 ; 171
	dw TextStrings_35.s270 - TextStrings_35 ; 172
	dw TextStrings_35.s272 - TextStrings_35 ; 173
	dw TextStrings_35.s274 - TextStrings_35 ; 174
	dw TextStrings_35.s276 - TextStrings_35 ; 175
	dw TextStrings_35.s278 - TextStrings_35 ; 176
	dw TextStrings_35.s280 - TextStrings_35 ; 177
	dw TextStrings_35.s282 - TextStrings_35 ; 178
	dw TextStrings_35.s284 - TextStrings_35 ; 179
	dw TextStrings_35.s286 - TextStrings_35 ; 180
	dw TextStrings_35.s288 - TextStrings_35 ; 181
	dw TextStrings_35.s290 - TextStrings_35 ; 182
	dw TextStrings_35.s292 - TextStrings_35 ; 183
	dw TextStrings_35.s294 - TextStrings_35 ; 184
	dw TextStrings_35.s296 - TextStrings_35 ; 185
	dw TextStrings_35.s298 - TextStrings_35 ; 186
	dw TextStrings_35.s300 - TextStrings_35 ; 187
	dw TextStrings_35.s302 - TextStrings_35 ; 188
	dw TextStrings_35.s304 - TextStrings_35 ; 189
	dw TextStrings_35.s306 - TextStrings_35 ; 190
	dw TextStrings_35.s308 - TextStrings_35 ; 191
	dw TextStrings_35.s310 - TextStrings_35 ; 192
	dw TextStrings_35.s312 - TextStrings_35 ; 193
	dw TextStrings_35.s314 - TextStrings_35 ; 194
	dw TextStrings_35.s316 - TextStrings_35 ; 195
	dw TextStrings_35.s318 - TextStrings_35 ; 196
	dw TextStrings_35.s320 - TextStrings_35 ; 197
	dw TextStrings_35.s322 - TextStrings_35 ; 198
	dw TextStrings_35.s324 - TextStrings_35 ; 199
	dw TextStrings_35.s326 - TextStrings_35 ; 200
	dw TextStrings_35.s328 - TextStrings_35 ; 201
	dw TextStrings_35.s330 - TextStrings_35 ; 202
	dw TextStrings_35.s332 - TextStrings_35 ; 203
	dw TextStrings_35.s334 - TextStrings_35 ; 204
	dw TextStrings_35.s336 - TextStrings_35 ; 205
	dw TextStrings_35.s338 - TextStrings_35 ; 206
	dw TextStrings_35.s340 - TextStrings_35 ; 207
	dw TextStrings_35.s342 - TextStrings_35 ; 208
	dw TextStrings_35.s344 - TextStrings_35 ; 209
	dw TextStrings_35.s346 - TextStrings_35 ; 210
	dw TextStrings_35.s347 - TextStrings_35 ; 211
	dw TextStrings_35.s349 - TextStrings_35 ; 212
	dw TextStrings_35.s351 - TextStrings_35 ; 213
	dw TextStrings_35.s353 - TextStrings_35 ; 214
	dw TextStrings_35.s355 - TextStrings_35 ; 215
	dw TextStrings_35.s357 - TextStrings_35 ; 216
	dw TextStrings_35.s359 - TextStrings_35 ; 217
	dw TextStrings_35.s361 - TextStrings_35 ; 218
	dw TextStrings_35.s363 - TextStrings_35 ; 219
	dw TextStrings_35.s365 - TextStrings_35 ; 220
	dw TextStrings_35.s367 - TextStrings_35 ; 221
	dw TextStrings_35.s369 - TextStrings_35 ; 222
	dw TextStrings_35.s371 - TextStrings_35 ; 223
	dw TextStrings_35.s373 - TextStrings_35 ; 224
	dw TextStrings_35.s375 - TextStrings_35 ; 225
	dw TextStrings_35.s377 - TextStrings_35 ; 226
	dw TextStrings_35.s379 - TextStrings_35 ; 227
	dw TextStrings_35.s381 - TextStrings_35 ; 228
	dw TextStrings_35.s383 - TextStrings_35 ; 229
	dw TextStrings_35.s385 - TextStrings_35 ; 230
	dw TextStrings_35.s387 - TextStrings_35 ; 231
	dw TextStrings_35.s388 - TextStrings_35 ; 232
	dw TextStrings_35.s390 - TextStrings_35 ; 233
	dw TextStrings_35.s392 - TextStrings_35 ; 234
	dw TextStrings_35.s394 - TextStrings_35 ; 235
	dw TextStrings_35.s396 - TextStrings_35 ; 236
	dw TextStrings_35.s398 - TextStrings_35 ; 237
	dw TextStrings_35.s400 - TextStrings_35 ; 238
	dw TextStrings_35.s401 - TextStrings_35 ; 239
	dw TextStrings_35.s403 - TextStrings_35 ; 240
	dw TextStrings_35.s404 - TextStrings_35 ; 241
	dw TextStrings_35.s406 - TextStrings_35 ; 242
	dw TextStrings_35.s408 - TextStrings_35 ; 243
	dw TextStrings_35.s409 - TextStrings_35 ; 244
	dw TextStrings_35.s410 - TextStrings_35 ; 245
	dw TextStrings_35.s411 - TextStrings_35 ; 246
	dw TextStrings_35.s412 - TextStrings_35 ; 247
	dw TextStrings_35.s413 - TextStrings_35 ; 248
	dw TextStrings_35.s414 - TextStrings_35 ; 249
	dw TextStrings_35.s415 - TextStrings_35 ; 250
	dw TextStrings_35.s416 - TextStrings_35 ; 251
	dw TextStrings_35.s418 - TextStrings_35 ; 252
	dw TextStrings_35.s420 - TextStrings_35 ; 253
	dw TextStrings_35.s422 - TextStrings_35 ; 254
	dw TextStrings_35.s424 - TextStrings_35 ; 255
	dw TextStrings_35.s426 - TextStrings_35 ; 256
	dw TextStrings_35.s428 - TextStrings_35 ; 257
	dw TextStrings_35.s430 - TextStrings_35 ; 258
	dw TextStrings_35.s432 - TextStrings_35 ; 259
	dw TextStrings_35.s434 - TextStrings_35 ; 260
	dw TextStrings_35.s436 - TextStrings_35 ; 261
	dw TextStrings_35.s437 - TextStrings_35 ; 262
	dw TextStrings_35.s439 - TextStrings_35 ; 263
	dw TextStrings_35.s440 - TextStrings_35 ; 264
	dw TextStrings_35.s442 - TextStrings_35 ; 265
	dw TextStrings_35.s444 - TextStrings_35 ; 266
	dw TextStrings_35.s445 - TextStrings_35 ; 267
	dw TextStrings_35.s447 - TextStrings_35 ; 268
	dw TextStrings_35.s449 - TextStrings_35 ; 269
TextStrings_35:
	INCLUDE "data/bank_035/text_pool_4220.asm" ; $4220, 14601 bytes (text_pool)
FetchDialogueText_35:
	push af ; $7b29
	ld a, $00 ; $7b2a
	call FetchText_35 ; $7b2c
	pop af ; $7b2f
	ret ; $7b30
FetchShortText_35:
	push af ; $7b31
	ld a, $01 ; $7b32
	call FetchText_35 ; $7b34
	pop af ; $7b37
	ret ; $7b38
FetchText_35:
	push bc ; $7b39
	push de ; $7b3a
	push hl ; $7b3b
	ld hl, FetchTextTable_35 ; $7b3c
	sla e ; $7b3f
	rl d ; $7b41
	add hl, de ; $7b43
	ld e, [hl] ; $7b44
	inc hl ; $7b45
	ld d, [hl] ; $7b46
	ld hl, TextStrings_35 ; $7b47
	add hl, de ; $7b4a
	or a ; $7b4b
	jr nz, .nonZero ; $7b4c
	ld de, wTextBuffer ; $7b4e
	ld c, $a0 ; $7b51
	jr .loop ; $7b53
.nonZero:
	ld de, wShortTextBuffer ; $7b55
	ld c, $10 ; $7b58
.loop:
	dec c ; $7b5a
	jr z, .countDone ; $7b5b
	ld a, [hl+] ; $7b5d
	ld [de], a ; $7b5e
	inc de ; $7b5f
	or a ; $7b60
	jr nz, .loop ; $7b61
	pop hl ; $7b63
	pop de ; $7b64
	pop bc ; $7b65
	ret ; $7b66
.countDone:
	xor a ; $7b67
	ld [de], a ; $7b68
	ldh a, [hDebugStepMode] ; $7b69
	or a ; $7b6b
	jr z, .restore ; $7b6c
	sound BGM_CREDITS ; $7b6e
.restore:
	pop hl ; $7b70
	pop de ; $7b71
	pop bc ; $7b72
	ret ; $7b73
	; $7b74, 1164 bytes fill to bank end (linker-padded)
