SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

	farptr FetchDialogueText_5e ; $4000
	farptr FetchShortText_5e ; $4002
FetchTextTable_5e:
	; $4004, 646 bytes (text_offsets)
	dw TextStrings_5e.s0 - TextStrings_5e ; 0
	dw TextStrings_5e.s1 - TextStrings_5e ; 1
	dw TextStrings_5e.s2 - TextStrings_5e ; 2
	dw TextStrings_5e.s3 - TextStrings_5e ; 3
	dw TextStrings_5e.s4 - TextStrings_5e ; 4
	dw TextStrings_5e.s5 - TextStrings_5e ; 5
	dw TextStrings_5e.s6 - TextStrings_5e ; 6
	dw TextStrings_5e.s7 - TextStrings_5e ; 7
	dw TextStrings_5e.s8 - TextStrings_5e ; 8
	dw TextStrings_5e.s9 - TextStrings_5e ; 9
	dw TextStrings_5e.s10 - TextStrings_5e ; 10
	dw TextStrings_5e.s11 - TextStrings_5e ; 11
	dw TextStrings_5e.s12 - TextStrings_5e ; 12
	dw TextStrings_5e.s13 - TextStrings_5e ; 13
	dw TextStrings_5e.s14 - TextStrings_5e ; 14
	dw TextStrings_5e.s15 - TextStrings_5e ; 15
	dw TextStrings_5e.s16 - TextStrings_5e ; 16
	dw TextStrings_5e.s17 - TextStrings_5e ; 17
	dw TextStrings_5e.s18 - TextStrings_5e ; 18
	dw TextStrings_5e.s19 - TextStrings_5e ; 19
	dw TextStrings_5e.s20 - TextStrings_5e ; 20
	dw TextStrings_5e.s21 - TextStrings_5e ; 21
	dw TextStrings_5e.s22 - TextStrings_5e ; 22
	dw TextStrings_5e.s23 - TextStrings_5e ; 23
	dw TextStrings_5e.s24 - TextStrings_5e ; 24
	dw TextStrings_5e.s25 - TextStrings_5e ; 25
	dw TextStrings_5e.s26 - TextStrings_5e ; 26
	dw TextStrings_5e.s27 - TextStrings_5e ; 27
	dw TextStrings_5e.s28 - TextStrings_5e ; 28
	dw TextStrings_5e.s29 - TextStrings_5e ; 29
	dw TextStrings_5e.s30 - TextStrings_5e ; 30
	dw TextStrings_5e.s31 - TextStrings_5e ; 31
	dw TextStrings_5e.s32 - TextStrings_5e ; 32
	dw TextStrings_5e.s33 - TextStrings_5e ; 33
	dw TextStrings_5e.s34 - TextStrings_5e ; 34
	dw TextStrings_5e.s35 - TextStrings_5e ; 35
	dw TextStrings_5e.s36 - TextStrings_5e ; 36
	dw TextStrings_5e.s37 - TextStrings_5e ; 37
	dw TextStrings_5e.s38 - TextStrings_5e ; 38
	dw TextStrings_5e.s39 - TextStrings_5e ; 39
	dw TextStrings_5e.s40 - TextStrings_5e ; 40
	dw TextStrings_5e.s41 - TextStrings_5e ; 41
	dw TextStrings_5e.s42 - TextStrings_5e ; 42
	dw TextStrings_5e.s43 - TextStrings_5e ; 43
	dw TextStrings_5e.s44 - TextStrings_5e ; 44
	dw TextStrings_5e.s45 - TextStrings_5e ; 45
	dw TextStrings_5e.s46 - TextStrings_5e ; 46
	dw TextStrings_5e.s47 - TextStrings_5e ; 47
	dw TextStrings_5e.s48 - TextStrings_5e ; 48
	dw TextStrings_5e.s49 - TextStrings_5e ; 49
	dw TextStrings_5e.s50 - TextStrings_5e ; 50
	dw TextStrings_5e.s52 - TextStrings_5e ; 51
	dw TextStrings_5e.s54 - TextStrings_5e ; 52
	dw TextStrings_5e.s56 - TextStrings_5e ; 53
	dw TextStrings_5e.s58 - TextStrings_5e ; 54
	dw TextStrings_5e.s60 - TextStrings_5e ; 55
	dw TextStrings_5e.s62 - TextStrings_5e ; 56
	dw TextStrings_5e.s64 - TextStrings_5e ; 57
	dw TextStrings_5e.s66 - TextStrings_5e ; 58
	dw TextStrings_5e.s68 - TextStrings_5e ; 59
	dw TextStrings_5e.s70 - TextStrings_5e ; 60
	dw TextStrings_5e.s72 - TextStrings_5e ; 61
	dw TextStrings_5e.s74 - TextStrings_5e ; 62
	dw TextStrings_5e.s76 - TextStrings_5e ; 63
	dw TextStrings_5e.s78 - TextStrings_5e ; 64
	dw TextStrings_5e.s80 - TextStrings_5e ; 65
	dw TextStrings_5e.s82 - TextStrings_5e ; 66
	dw TextStrings_5e.s84 - TextStrings_5e ; 67
	dw TextStrings_5e.s86 - TextStrings_5e ; 68
	dw TextStrings_5e.s88 - TextStrings_5e ; 69
	dw TextStrings_5e.s90 - TextStrings_5e ; 70
	dw TextStrings_5e.s92 - TextStrings_5e ; 71
	dw TextStrings_5e.s94 - TextStrings_5e ; 72
	dw TextStrings_5e.s96 - TextStrings_5e ; 73
	dw TextStrings_5e.s98 - TextStrings_5e ; 74
	dw TextStrings_5e.s100 - TextStrings_5e ; 75
	dw TextStrings_5e.s102 - TextStrings_5e ; 76
	dw TextStrings_5e.s104 - TextStrings_5e ; 77
	dw TextStrings_5e.s106 - TextStrings_5e ; 78
	dw TextStrings_5e.s108 - TextStrings_5e ; 79
	dw TextStrings_5e.s110 - TextStrings_5e ; 80
	dw TextStrings_5e.s112 - TextStrings_5e ; 81
	dw TextStrings_5e.s114 - TextStrings_5e ; 82
	dw TextStrings_5e.s116 - TextStrings_5e ; 83
	dw TextStrings_5e.s118 - TextStrings_5e ; 84
	dw TextStrings_5e.s120 - TextStrings_5e ; 85
	dw TextStrings_5e.s122 - TextStrings_5e ; 86
	dw TextStrings_5e.s124 - TextStrings_5e ; 87
	dw TextStrings_5e.s126 - TextStrings_5e ; 88
	dw TextStrings_5e.s128 - TextStrings_5e ; 89
	dw TextStrings_5e.s130 - TextStrings_5e ; 90
	dw TextStrings_5e.s132 - TextStrings_5e ; 91
	dw TextStrings_5e.s134 - TextStrings_5e ; 92
	dw TextStrings_5e.s136 - TextStrings_5e ; 93
	dw TextStrings_5e.s138 - TextStrings_5e ; 94
	dw TextStrings_5e.s140 - TextStrings_5e ; 95
	dw TextStrings_5e.s141 - TextStrings_5e ; 96
	dw TextStrings_5e.s143 - TextStrings_5e ; 97
	dw TextStrings_5e.s145 - TextStrings_5e ; 98
	dw TextStrings_5e.s147 - TextStrings_5e ; 99
	dw TextStrings_5e.s149 - TextStrings_5e ; 100
	dw TextStrings_5e.s151 - TextStrings_5e ; 101
	dw TextStrings_5e.s153 - TextStrings_5e ; 102
	dw TextStrings_5e.s155 - TextStrings_5e ; 103
	dw TextStrings_5e.s157 - TextStrings_5e ; 104
	dw TextStrings_5e.s159 - TextStrings_5e ; 105
	dw TextStrings_5e.s161 - TextStrings_5e ; 106
	dw TextStrings_5e.s163 - TextStrings_5e ; 107
	dw TextStrings_5e.s165 - TextStrings_5e ; 108
	dw TextStrings_5e.s167 - TextStrings_5e ; 109
	dw TextStrings_5e.s169 - TextStrings_5e ; 110
	dw TextStrings_5e.s171 - TextStrings_5e ; 111
	dw TextStrings_5e.s173 - TextStrings_5e ; 112
	dw TextStrings_5e.s175 - TextStrings_5e ; 113
	dw TextStrings_5e.s177 - TextStrings_5e ; 114
	dw TextStrings_5e.s179 - TextStrings_5e ; 115
	dw TextStrings_5e.s181 - TextStrings_5e ; 116
	dw TextStrings_5e.s183 - TextStrings_5e ; 117
	dw TextStrings_5e.s185 - TextStrings_5e ; 118
	dw TextStrings_5e.s187 - TextStrings_5e ; 119
	dw TextStrings_5e.s189 - TextStrings_5e ; 120
	dw TextStrings_5e.s191 - TextStrings_5e ; 121
	dw TextStrings_5e.s193 - TextStrings_5e ; 122
	dw TextStrings_5e.s195 - TextStrings_5e ; 123
	dw TextStrings_5e.s197 - TextStrings_5e ; 124
	dw TextStrings_5e.s198 - TextStrings_5e ; 125
	dw TextStrings_5e.s200 - TextStrings_5e ; 126
	dw TextStrings_5e.s202 - TextStrings_5e ; 127
	dw TextStrings_5e.s204 - TextStrings_5e ; 128
	dw TextStrings_5e.s206 - TextStrings_5e ; 129
	dw TextStrings_5e.s208 - TextStrings_5e ; 130
	dw TextStrings_5e.s210 - TextStrings_5e ; 131
	dw TextStrings_5e.s211 - TextStrings_5e ; 132
	dw TextStrings_5e.s213 - TextStrings_5e ; 133
	dw TextStrings_5e.s215 - TextStrings_5e ; 134
	dw TextStrings_5e.s217 - TextStrings_5e ; 135
	dw TextStrings_5e.s219 - TextStrings_5e ; 136
	dw TextStrings_5e.s220 - TextStrings_5e ; 137
	dw TextStrings_5e.s221 - TextStrings_5e ; 138
	dw TextStrings_5e.s223 - TextStrings_5e ; 139
	dw TextStrings_5e.s225 - TextStrings_5e ; 140
	dw TextStrings_5e.s227 - TextStrings_5e ; 141
	dw TextStrings_5e.s229 - TextStrings_5e ; 142
	dw TextStrings_5e.s231 - TextStrings_5e ; 143
	dw TextStrings_5e.s233 - TextStrings_5e ; 144
	dw TextStrings_5e.s235 - TextStrings_5e ; 145
	dw TextStrings_5e.s237 - TextStrings_5e ; 146
	dw TextStrings_5e.s239 - TextStrings_5e ; 147
	dw TextStrings_5e.s241 - TextStrings_5e ; 148
	dw TextStrings_5e.s243 - TextStrings_5e ; 149
	dw TextStrings_5e.s245 - TextStrings_5e ; 150
	dw TextStrings_5e.s247 - TextStrings_5e ; 151
	dw TextStrings_5e.s249 - TextStrings_5e ; 152
	dw TextStrings_5e.s251 - TextStrings_5e ; 153
	dw TextStrings_5e.s253 - TextStrings_5e ; 154
	dw TextStrings_5e.s255 - TextStrings_5e ; 155
	dw TextStrings_5e.s257 - TextStrings_5e ; 156
	dw TextStrings_5e.s259 - TextStrings_5e ; 157
	dw TextStrings_5e.s261 - TextStrings_5e ; 158
	dw TextStrings_5e.s263 - TextStrings_5e ; 159
	dw TextStrings_5e.s265 - TextStrings_5e ; 160
	dw TextStrings_5e.s267 - TextStrings_5e ; 161
	dw TextStrings_5e.s269 - TextStrings_5e ; 162
	dw TextStrings_5e.s271 - TextStrings_5e ; 163
	dw TextStrings_5e.s273 - TextStrings_5e ; 164
	dw TextStrings_5e.s275 - TextStrings_5e ; 165
	dw TextStrings_5e.s277 - TextStrings_5e ; 166
	dw TextStrings_5e.s279 - TextStrings_5e ; 167
	dw TextStrings_5e.s281 - TextStrings_5e ; 168
	dw TextStrings_5e.s283 - TextStrings_5e ; 169
	dw TextStrings_5e.s285 - TextStrings_5e ; 170
	dw TextStrings_5e.s287 - TextStrings_5e ; 171
	dw TextStrings_5e.s288 - TextStrings_5e ; 172
	dw TextStrings_5e.s289 - TextStrings_5e ; 173
	dw TextStrings_5e.s290 - TextStrings_5e ; 174
	dw TextStrings_5e.s291 - TextStrings_5e ; 175
	dw TextStrings_5e.s292 - TextStrings_5e ; 176
	dw TextStrings_5e.s293 - TextStrings_5e ; 177
	dw TextStrings_5e.s294 - TextStrings_5e ; 178
	dw TextStrings_5e.s295 - TextStrings_5e ; 179
	dw TextStrings_5e.s296 - TextStrings_5e ; 180
	dw TextStrings_5e.s297 - TextStrings_5e ; 181
	dw TextStrings_5e.s298 - TextStrings_5e ; 182
	dw TextStrings_5e.s299 - TextStrings_5e ; 183
	dw TextStrings_5e.s300 - TextStrings_5e ; 184
	dw TextStrings_5e.s301 - TextStrings_5e ; 185
	dw TextStrings_5e.s302 - TextStrings_5e ; 186
	dw TextStrings_5e.s303 - TextStrings_5e ; 187
	dw TextStrings_5e.s304 - TextStrings_5e ; 188
	dw TextStrings_5e.s305 - TextStrings_5e ; 189
	dw TextStrings_5e.s306 - TextStrings_5e ; 190
	dw TextStrings_5e.s307 - TextStrings_5e ; 191
	dw TextStrings_5e.s308 - TextStrings_5e ; 192
	dw TextStrings_5e.s309 - TextStrings_5e ; 193
	dw TextStrings_5e.s310 - TextStrings_5e ; 194
	dw TextStrings_5e.s311 - TextStrings_5e ; 195
	dw TextStrings_5e.s312 - TextStrings_5e ; 196
	dw TextStrings_5e.s313 - TextStrings_5e ; 197
	dw TextStrings_5e.s314 - TextStrings_5e ; 198
	dw TextStrings_5e.s315 - TextStrings_5e ; 199
	dw TextStrings_5e.s316 - TextStrings_5e ; 200
	dw TextStrings_5e.s317 - TextStrings_5e ; 201
	dw TextStrings_5e.s318 - TextStrings_5e ; 202
	dw TextStrings_5e.s319 - TextStrings_5e ; 203
	dw TextStrings_5e.s320 - TextStrings_5e ; 204
	dw TextStrings_5e.s321 - TextStrings_5e ; 205
	dw TextStrings_5e.s322 - TextStrings_5e ; 206
	dw TextStrings_5e.s323 - TextStrings_5e ; 207
	dw TextStrings_5e.s324 - TextStrings_5e ; 208
	dw TextStrings_5e.s325 - TextStrings_5e ; 209
	dw TextStrings_5e.s326 - TextStrings_5e ; 210
	dw TextStrings_5e.s327 - TextStrings_5e ; 211
	dw TextStrings_5e.s328 - TextStrings_5e ; 212
	dw TextStrings_5e.s329 - TextStrings_5e ; 213
	dw TextStrings_5e.s330 - TextStrings_5e ; 214
	dw TextStrings_5e.s331 - TextStrings_5e ; 215
	dw TextStrings_5e.s332 - TextStrings_5e ; 216
	dw TextStrings_5e.s333 - TextStrings_5e ; 217
	dw TextStrings_5e.s334 - TextStrings_5e ; 218
	dw TextStrings_5e.s335 - TextStrings_5e ; 219
	dw TextStrings_5e.s336 - TextStrings_5e ; 220
	dw TextStrings_5e.s337 - TextStrings_5e ; 221
	dw TextStrings_5e.s338 - TextStrings_5e ; 222
	dw TextStrings_5e.s339 - TextStrings_5e ; 223
	dw TextStrings_5e.s340 - TextStrings_5e ; 224
	dw TextStrings_5e.s341 - TextStrings_5e ; 225
	dw TextStrings_5e.s342 - TextStrings_5e ; 226
	dw TextStrings_5e.s343 - TextStrings_5e ; 227
	dw TextStrings_5e.s344 - TextStrings_5e ; 228
	dw TextStrings_5e.s345 - TextStrings_5e ; 229
	dw TextStrings_5e.s346 - TextStrings_5e ; 230
	dw TextStrings_5e.s347 - TextStrings_5e ; 231
	dw TextStrings_5e.s348 - TextStrings_5e ; 232
	dw TextStrings_5e.s349 - TextStrings_5e ; 233
	dw TextStrings_5e.s350 - TextStrings_5e ; 234
	dw TextStrings_5e.s351 - TextStrings_5e ; 235
	dw TextStrings_5e.s352 - TextStrings_5e ; 236
	dw TextStrings_5e.s353 - TextStrings_5e ; 237
	dw TextStrings_5e.s354 - TextStrings_5e ; 238
	dw TextStrings_5e.s355 - TextStrings_5e ; 239
	dw TextStrings_5e.s356 - TextStrings_5e ; 240
	dw TextStrings_5e.s357 - TextStrings_5e ; 241
	dw TextStrings_5e.s358 - TextStrings_5e ; 242
	dw TextStrings_5e.s359 - TextStrings_5e ; 243
	dw TextStrings_5e.s360 - TextStrings_5e ; 244
	dw TextStrings_5e.s361 - TextStrings_5e ; 245
	dw TextStrings_5e.s362 - TextStrings_5e ; 246
	dw TextStrings_5e.s363 - TextStrings_5e ; 247
	dw TextStrings_5e.s364 - TextStrings_5e ; 248
	dw TextStrings_5e.s365 - TextStrings_5e ; 249
	dw TextStrings_5e.s366 - TextStrings_5e ; 250
	dw TextStrings_5e.s367 - TextStrings_5e ; 251
	dw TextStrings_5e.s368 - TextStrings_5e ; 252
	dw TextStrings_5e.s369 - TextStrings_5e ; 253
	dw TextStrings_5e.s370 - TextStrings_5e ; 254
	dw TextStrings_5e.s371 - TextStrings_5e ; 255
	dw TextStrings_5e.s372 - TextStrings_5e ; 256
	dw TextStrings_5e.s373 - TextStrings_5e ; 257
	dw TextStrings_5e.s374 - TextStrings_5e ; 258
	dw TextStrings_5e.s375 - TextStrings_5e ; 259
	dw TextStrings_5e.s376 - TextStrings_5e ; 260
	dw TextStrings_5e.s377 - TextStrings_5e ; 261
	dw TextStrings_5e.s378 - TextStrings_5e ; 262
	dw TextStrings_5e.s379 - TextStrings_5e ; 263
	dw TextStrings_5e.s380 - TextStrings_5e ; 264
	dw TextStrings_5e.s381 - TextStrings_5e ; 265
	dw TextStrings_5e.s382 - TextStrings_5e ; 266
	dw TextStrings_5e.s383 - TextStrings_5e ; 267
	dw TextStrings_5e.s384 - TextStrings_5e ; 268
	dw TextStrings_5e.s385 - TextStrings_5e ; 269
	dw TextStrings_5e.s386 - TextStrings_5e ; 270
	dw TextStrings_5e.s387 - TextStrings_5e ; 271
	dw TextStrings_5e.s388 - TextStrings_5e ; 272
	dw TextStrings_5e.s389 - TextStrings_5e ; 273
	dw TextStrings_5e.s390 - TextStrings_5e ; 274
	dw TextStrings_5e.s391 - TextStrings_5e ; 275
	dw TextStrings_5e.s392 - TextStrings_5e ; 276
	dw TextStrings_5e.s393 - TextStrings_5e ; 277
	dw TextStrings_5e.s394 - TextStrings_5e ; 278
	dw TextStrings_5e.s395 - TextStrings_5e ; 279
	dw TextStrings_5e.s396 - TextStrings_5e ; 280
	dw TextStrings_5e.s397 - TextStrings_5e ; 281
	dw TextStrings_5e.s398 - TextStrings_5e ; 282
	dw TextStrings_5e.s399 - TextStrings_5e ; 283
	dw TextStrings_5e.s400 - TextStrings_5e ; 284
	dw TextStrings_5e.s401 - TextStrings_5e ; 285
	dw TextStrings_5e.s402 - TextStrings_5e ; 286
	dw TextStrings_5e.s403 - TextStrings_5e ; 287
	dw TextStrings_5e.s404 - TextStrings_5e ; 288
	dw TextStrings_5e.s405 - TextStrings_5e ; 289
	dw TextStrings_5e.s406 - TextStrings_5e ; 290
	dw TextStrings_5e.s407 - TextStrings_5e ; 291
	dw TextStrings_5e.s408 - TextStrings_5e ; 292
	dw TextStrings_5e.s409 - TextStrings_5e ; 293
	dw TextStrings_5e.s410 - TextStrings_5e ; 294
	dw TextStrings_5e.s411 - TextStrings_5e ; 295
	dw TextStrings_5e.s412 - TextStrings_5e ; 296
	dw TextStrings_5e.s413 - TextStrings_5e ; 297
	dw TextStrings_5e.s414 - TextStrings_5e ; 298
	dw TextStrings_5e.s415 - TextStrings_5e ; 299
	dw TextStrings_5e.s416 - TextStrings_5e ; 300
	dw TextStrings_5e.s417 - TextStrings_5e ; 301
	dw TextStrings_5e.s418 - TextStrings_5e ; 302
	dw TextStrings_5e.s419 - TextStrings_5e ; 303
	dw TextStrings_5e.s420 - TextStrings_5e ; 304
	dw TextStrings_5e.s421 - TextStrings_5e ; 305
	dw TextStrings_5e.s422 - TextStrings_5e ; 306
	dw TextStrings_5e.s423 - TextStrings_5e ; 307
	dw TextStrings_5e.s424 - TextStrings_5e ; 308
	dw TextStrings_5e.s425 - TextStrings_5e ; 309
	dw TextStrings_5e.s426 - TextStrings_5e ; 310
	dw TextStrings_5e.s427 - TextStrings_5e ; 311
	dw TextStrings_5e.s428 - TextStrings_5e ; 312
	dw TextStrings_5e.s429 - TextStrings_5e ; 313
	dw TextStrings_5e.s430 - TextStrings_5e ; 314
	dw TextStrings_5e.s431 - TextStrings_5e ; 315
	dw TextStrings_5e.s432 - TextStrings_5e ; 316
	dw TextStrings_5e.s433 - TextStrings_5e ; 317
	dw TextStrings_5e.s434 - TextStrings_5e ; 318
	dw TextStrings_5e.s435 - TextStrings_5e ; 319
	dw TextStrings_5e.s436 - TextStrings_5e ; 320
	dw TextStrings_5e.s437 - TextStrings_5e ; 321
	dw TextStrings_5e.s438 - TextStrings_5e ; 322
TextStrings_5e:
	INCLUDE "data/bank_05e/text_pool_428a.asm" ; $428a, 11269 bytes (text_pool)
FetchDialogueText_5e:
	push af ; $6e8f
	ld a, $00 ; $6e90
	call FetchText_5e ; $6e92
	pop af ; $6e95
	ret ; $6e96
FetchShortText_5e:
	push af ; $6e97
	ld a, $01 ; $6e98
	call FetchText_5e ; $6e9a
	pop af ; $6e9d
	ret ; $6e9e
FetchText_5e:
	push bc ; $6e9f
	push de ; $6ea0
	push hl ; $6ea1
	ld hl, FetchTextTable_5e ; $6ea2
	sla e ; $6ea5
	rl d ; $6ea7
	add hl, de ; $6ea9
	ld e, [hl] ; $6eaa
	inc hl ; $6eab
	ld d, [hl] ; $6eac
	ld hl, TextStrings_5e ; $6ead
	add hl, de ; $6eb0
	or a ; $6eb1
	jr nz, .nonZero ; $6eb2
	ld de, wTextBuffer ; $6eb4
	ld c, $a0 ; $6eb7
	jr .loop ; $6eb9
.nonZero:
	ld de, wShortTextBuffer ; $6ebb
	ld c, $10 ; $6ebe
.loop:
	dec c ; $6ec0
	jr z, .countDone ; $6ec1
	ld a, [hl+] ; $6ec3
	ld [de], a ; $6ec4
	inc de ; $6ec5
	or a ; $6ec6
	jr nz, .loop ; $6ec7
	pop hl ; $6ec9
	pop de ; $6eca
	pop bc ; $6ecb
	ret ; $6ecc
.countDone:
	xor a ; $6ecd
	ld [de], a ; $6ece
	ldh a, [hDebugStepMode] ; $6ecf
	or a ; $6ed1
	jr z, .restore ; $6ed2
	sound BGM_CREDITS ; $6ed4
.restore:
	pop hl ; $6ed6
	pop de ; $6ed7
	pop bc ; $6ed8
	ret ; $6ed9
	; $6eda, 4390 bytes fill to bank end (linker-padded)
