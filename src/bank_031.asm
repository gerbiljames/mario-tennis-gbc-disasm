SECTION "ROM Bank $31", ROMX[$4000], BANK[$31]

	farptr FetchDialogueText_31 ; $4000
	farptr FetchShortText_31 ; $4002
FetchTextTable_31:
	; $4004, 694 bytes (text_offsets)
	dw TextStrings_31.s0 - TextStrings_31 ; 0
	dw TextStrings_31.s2 - TextStrings_31 ; 1
	dw TextStrings_31.s4 - TextStrings_31 ; 2
	dw TextStrings_31.s6 - TextStrings_31 ; 3
	dw TextStrings_31.s7 - TextStrings_31 ; 4
	dw TextStrings_31.s9 - TextStrings_31 ; 5
	dw TextStrings_31.s11 - TextStrings_31 ; 6
	dw TextStrings_31.s13 - TextStrings_31 ; 7
	dw TextStrings_31.s14 - TextStrings_31 ; 8
	dw TextStrings_31.s16 - TextStrings_31 ; 9
	dw TextStrings_31.s18 - TextStrings_31 ; 10
	dw TextStrings_31.s20 - TextStrings_31 ; 11
	dw TextStrings_31.s22 - TextStrings_31 ; 12
	dw TextStrings_31.s23 - TextStrings_31 ; 13
	dw TextStrings_31.s25 - TextStrings_31 ; 14
	dw TextStrings_31.s27 - TextStrings_31 ; 15
	dw TextStrings_31.s28 - TextStrings_31 ; 16
	dw TextStrings_31.s30 - TextStrings_31 ; 17
	dw TextStrings_31.s31 - TextStrings_31 ; 18
	dw TextStrings_31.s33 - TextStrings_31 ; 19
	dw TextStrings_31.s34 - TextStrings_31 ; 20
	dw TextStrings_31.s36 - TextStrings_31 ; 21
	dw TextStrings_31.s38 - TextStrings_31 ; 22
	dw TextStrings_31.s40 - TextStrings_31 ; 23
	dw TextStrings_31.s42 - TextStrings_31 ; 24
	dw TextStrings_31.s44 - TextStrings_31 ; 25
	dw TextStrings_31.s46 - TextStrings_31 ; 26
	dw TextStrings_31.s48 - TextStrings_31 ; 27
	dw TextStrings_31.s50 - TextStrings_31 ; 28
	dw TextStrings_31.s52 - TextStrings_31 ; 29
	dw TextStrings_31.s54 - TextStrings_31 ; 30
	dw TextStrings_31.s56 - TextStrings_31 ; 31
	dw TextStrings_31.s58 - TextStrings_31 ; 32
	dw TextStrings_31.s60 - TextStrings_31 ; 33
	dw TextStrings_31.s62 - TextStrings_31 ; 34
	dw TextStrings_31.s64 - TextStrings_31 ; 35
	dw TextStrings_31.s66 - TextStrings_31 ; 36
	dw TextStrings_31.s68 - TextStrings_31 ; 37
	dw TextStrings_31.s70 - TextStrings_31 ; 38
	dw TextStrings_31.s72 - TextStrings_31 ; 39
	dw TextStrings_31.s74 - TextStrings_31 ; 40
	dw TextStrings_31.s76 - TextStrings_31 ; 41
	dw TextStrings_31.s78 - TextStrings_31 ; 42
	dw TextStrings_31.s80 - TextStrings_31 ; 43
	dw TextStrings_31.s82 - TextStrings_31 ; 44
	dw TextStrings_31.s84 - TextStrings_31 ; 45
	dw TextStrings_31.s86 - TextStrings_31 ; 46
	dw TextStrings_31.s88 - TextStrings_31 ; 47
	dw TextStrings_31.s90 - TextStrings_31 ; 48
	dw TextStrings_31.s92 - TextStrings_31 ; 49
	dw TextStrings_31.s94 - TextStrings_31 ; 50
	dw TextStrings_31.s96 - TextStrings_31 ; 51
	dw TextStrings_31.s98 - TextStrings_31 ; 52
	dw TextStrings_31.s100 - TextStrings_31 ; 53
	dw TextStrings_31.s102 - TextStrings_31 ; 54
	dw TextStrings_31.s104 - TextStrings_31 ; 55
	dw TextStrings_31.s106 - TextStrings_31 ; 56
	dw TextStrings_31.s108 - TextStrings_31 ; 57
	dw TextStrings_31.s110 - TextStrings_31 ; 58
	dw TextStrings_31.s112 - TextStrings_31 ; 59
	dw TextStrings_31.s114 - TextStrings_31 ; 60
	dw TextStrings_31.s116 - TextStrings_31 ; 61
	dw TextStrings_31.s118 - TextStrings_31 ; 62
	dw TextStrings_31.s120 - TextStrings_31 ; 63
	dw TextStrings_31.s122 - TextStrings_31 ; 64
	dw TextStrings_31.s124 - TextStrings_31 ; 65
	dw TextStrings_31.s126 - TextStrings_31 ; 66
	dw TextStrings_31.s128 - TextStrings_31 ; 67
	dw TextStrings_31.s130 - TextStrings_31 ; 68
	dw TextStrings_31.s132 - TextStrings_31 ; 69
	dw TextStrings_31.s134 - TextStrings_31 ; 70
	dw TextStrings_31.s136 - TextStrings_31 ; 71
	dw TextStrings_31.s138 - TextStrings_31 ; 72
	dw TextStrings_31.s140 - TextStrings_31 ; 73
	dw TextStrings_31.s142 - TextStrings_31 ; 74
	dw TextStrings_31.s144 - TextStrings_31 ; 75
	dw TextStrings_31.s146 - TextStrings_31 ; 76
	dw TextStrings_31.s148 - TextStrings_31 ; 77
	dw TextStrings_31.s150 - TextStrings_31 ; 78
	dw TextStrings_31.s152 - TextStrings_31 ; 79
	dw TextStrings_31.s154 - TextStrings_31 ; 80
	dw TextStrings_31.s156 - TextStrings_31 ; 81
	dw TextStrings_31.s158 - TextStrings_31 ; 82
	dw TextStrings_31.s160 - TextStrings_31 ; 83
	dw TextStrings_31.s162 - TextStrings_31 ; 84
	dw TextStrings_31.s163 - TextStrings_31 ; 85
	dw TextStrings_31.s165 - TextStrings_31 ; 86
	dw TextStrings_31.s167 - TextStrings_31 ; 87
	dw TextStrings_31.s169 - TextStrings_31 ; 88
	dw TextStrings_31.s171 - TextStrings_31 ; 89
	dw TextStrings_31.s173 - TextStrings_31 ; 90
	dw TextStrings_31.s175 - TextStrings_31 ; 91
	dw TextStrings_31.s177 - TextStrings_31 ; 92
	dw TextStrings_31.s179 - TextStrings_31 ; 93
	dw TextStrings_31.s181 - TextStrings_31 ; 94
	dw TextStrings_31.s183 - TextStrings_31 ; 95
	dw TextStrings_31.s185 - TextStrings_31 ; 96
	dw TextStrings_31.s187 - TextStrings_31 ; 97
	dw TextStrings_31.s189 - TextStrings_31 ; 98
	dw TextStrings_31.s190 - TextStrings_31 ; 99
	dw TextStrings_31.s192 - TextStrings_31 ; 100
	dw TextStrings_31.s194 - TextStrings_31 ; 101
	dw TextStrings_31.s196 - TextStrings_31 ; 102
	dw TextStrings_31.s198 - TextStrings_31 ; 103
	dw TextStrings_31.s200 - TextStrings_31 ; 104
	dw TextStrings_31.s201 - TextStrings_31 ; 105
	dw TextStrings_31.s202 - TextStrings_31 ; 106
	dw TextStrings_31.s203 - TextStrings_31 ; 107
	dw TextStrings_31.s204 - TextStrings_31 ; 108
	dw TextStrings_31.s205 - TextStrings_31 ; 109
	dw TextStrings_31.s206 - TextStrings_31 ; 110
	dw TextStrings_31.s207 - TextStrings_31 ; 111
	dw TextStrings_31.s208 - TextStrings_31 ; 112
	dw TextStrings_31.s209 - TextStrings_31 ; 113
	dw TextStrings_31.s210 - TextStrings_31 ; 114
	dw TextStrings_31.s211 - TextStrings_31 ; 115
	dw TextStrings_31.s212 - TextStrings_31 ; 116
	dw TextStrings_31.s213 - TextStrings_31 ; 117
	dw TextStrings_31.s214 - TextStrings_31 ; 118
	dw TextStrings_31.s215 - TextStrings_31 ; 119
	dw TextStrings_31.s216 - TextStrings_31 ; 120
	dw TextStrings_31.s217 - TextStrings_31 ; 121
	dw TextStrings_31.s218 - TextStrings_31 ; 122
	dw TextStrings_31.s219 - TextStrings_31 ; 123
	dw TextStrings_31.s220 - TextStrings_31 ; 124
	dw TextStrings_31.s221 - TextStrings_31 ; 125
	dw TextStrings_31.s222 - TextStrings_31 ; 126
	dw TextStrings_31.s223 - TextStrings_31 ; 127
	dw TextStrings_31.s225 - TextStrings_31 ; 128
	dw TextStrings_31.s227 - TextStrings_31 ; 129
	dw TextStrings_31.s229 - TextStrings_31 ; 130
	dw TextStrings_31.s231 - TextStrings_31 ; 131
	dw TextStrings_31.s233 - TextStrings_31 ; 132
	dw TextStrings_31.s234 - TextStrings_31 ; 133
	dw TextStrings_31.s235 - TextStrings_31 ; 134
	dw TextStrings_31.s236 - TextStrings_31 ; 135
	dw TextStrings_31.s237 - TextStrings_31 ; 136
	dw TextStrings_31.s238 - TextStrings_31 ; 137
	dw TextStrings_31.s239 - TextStrings_31 ; 138
	dw TextStrings_31.s240 - TextStrings_31 ; 139
	dw TextStrings_31.s241 - TextStrings_31 ; 140
	dw TextStrings_31.s242 - TextStrings_31 ; 141
	dw TextStrings_31.s243 - TextStrings_31 ; 142
	dw TextStrings_31.s244 - TextStrings_31 ; 143
	dw TextStrings_31.s245 - TextStrings_31 ; 144
	dw TextStrings_31.s246 - TextStrings_31 ; 145
	dw TextStrings_31.s247 - TextStrings_31 ; 146
	dw TextStrings_31.s248 - TextStrings_31 ; 147
	dw TextStrings_31.s249 - TextStrings_31 ; 148
	dw TextStrings_31.s250 - TextStrings_31 ; 149
	dw TextStrings_31.s251 - TextStrings_31 ; 150
	dw TextStrings_31.s252 - TextStrings_31 ; 151
	dw TextStrings_31.s253 - TextStrings_31 ; 152
	dw TextStrings_31.s254 - TextStrings_31 ; 153
	dw TextStrings_31.s255 - TextStrings_31 ; 154
	dw TextStrings_31.s256 - TextStrings_31 ; 155
	dw TextStrings_31.s257 - TextStrings_31 ; 156
	dw TextStrings_31.s258 - TextStrings_31 ; 157
	dw TextStrings_31.s259 - TextStrings_31 ; 158
	dw TextStrings_31.s260 - TextStrings_31 ; 159
	dw TextStrings_31.s261 - TextStrings_31 ; 160
	dw TextStrings_31.s262 - TextStrings_31 ; 161
	dw TextStrings_31.s263 - TextStrings_31 ; 162
	dw TextStrings_31.s264 - TextStrings_31 ; 163
	dw TextStrings_31.s265 - TextStrings_31 ; 164
	dw TextStrings_31.s266 - TextStrings_31 ; 165
	dw TextStrings_31.s267 - TextStrings_31 ; 166
	dw TextStrings_31.s268 - TextStrings_31 ; 167
	dw TextStrings_31.s269 - TextStrings_31 ; 168
	dw TextStrings_31.s270 - TextStrings_31 ; 169
	dw TextStrings_31.s271 - TextStrings_31 ; 170
	dw TextStrings_31.s272 - TextStrings_31 ; 171
	dw TextStrings_31.s273 - TextStrings_31 ; 172
	dw TextStrings_31.s274 - TextStrings_31 ; 173
	dw TextStrings_31.s275 - TextStrings_31 ; 174
	dw TextStrings_31.s276 - TextStrings_31 ; 175
	dw TextStrings_31.s277 - TextStrings_31 ; 176
	dw TextStrings_31.s278 - TextStrings_31 ; 177
	dw TextStrings_31.s279 - TextStrings_31 ; 178
	dw TextStrings_31.s280 - TextStrings_31 ; 179
	dw TextStrings_31.s281 - TextStrings_31 ; 180
	dw TextStrings_31.s282 - TextStrings_31 ; 181
	dw TextStrings_31.s283 - TextStrings_31 ; 182
	dw TextStrings_31.s284 - TextStrings_31 ; 183
	dw TextStrings_31.s285 - TextStrings_31 ; 184
	dw TextStrings_31.s286 - TextStrings_31 ; 185
	dw TextStrings_31.s287 - TextStrings_31 ; 186
	dw TextStrings_31.s288 - TextStrings_31 ; 187
	dw TextStrings_31.s289 - TextStrings_31 ; 188
	dw TextStrings_31.s290 - TextStrings_31 ; 189
	dw TextStrings_31.s291 - TextStrings_31 ; 190
	dw TextStrings_31.s292 - TextStrings_31 ; 191
	dw TextStrings_31.s293 - TextStrings_31 ; 192
	dw TextStrings_31.s294 - TextStrings_31 ; 193
	dw TextStrings_31.s295 - TextStrings_31 ; 194
	dw TextStrings_31.s296 - TextStrings_31 ; 195
	dw TextStrings_31.s297 - TextStrings_31 ; 196
	dw TextStrings_31.s298 - TextStrings_31 ; 197
	dw TextStrings_31.s299 - TextStrings_31 ; 198
	dw TextStrings_31.s300 - TextStrings_31 ; 199
	dw TextStrings_31.s301 - TextStrings_31 ; 200
	dw TextStrings_31.s302 - TextStrings_31 ; 201
	dw TextStrings_31.s303 - TextStrings_31 ; 202
	dw TextStrings_31.s304 - TextStrings_31 ; 203
	dw TextStrings_31.s305 - TextStrings_31 ; 204
	dw TextStrings_31.s306 - TextStrings_31 ; 205
	dw TextStrings_31.s307 - TextStrings_31 ; 206
	dw TextStrings_31.s308 - TextStrings_31 ; 207
	dw TextStrings_31.s309 - TextStrings_31 ; 208
	dw TextStrings_31.s310 - TextStrings_31 ; 209
	dw TextStrings_31.s311 - TextStrings_31 ; 210
	dw TextStrings_31.s312 - TextStrings_31 ; 211
	dw TextStrings_31.s313 - TextStrings_31 ; 212
	dw TextStrings_31.s314 - TextStrings_31 ; 213
	dw TextStrings_31.s315 - TextStrings_31 ; 214
	dw TextStrings_31.s316 - TextStrings_31 ; 215
	dw TextStrings_31.s317 - TextStrings_31 ; 216
	dw TextStrings_31.s318 - TextStrings_31 ; 217
	dw TextStrings_31.s319 - TextStrings_31 ; 218
	dw TextStrings_31.s320 - TextStrings_31 ; 219
	dw TextStrings_31.s321 - TextStrings_31 ; 220
	dw TextStrings_31.s322 - TextStrings_31 ; 221
	dw TextStrings_31.s323 - TextStrings_31 ; 222
	dw TextStrings_31.s324 - TextStrings_31 ; 223
	dw TextStrings_31.s325 - TextStrings_31 ; 224
	dw TextStrings_31.s326 - TextStrings_31 ; 225
	dw TextStrings_31.s327 - TextStrings_31 ; 226
	dw TextStrings_31.s328 - TextStrings_31 ; 227
	dw TextStrings_31.s329 - TextStrings_31 ; 228
	dw TextStrings_31.s330 - TextStrings_31 ; 229
	dw TextStrings_31.s331 - TextStrings_31 ; 230
	dw TextStrings_31.s332 - TextStrings_31 ; 231
	dw TextStrings_31.s333 - TextStrings_31 ; 232
	dw TextStrings_31.s334 - TextStrings_31 ; 233
	dw TextStrings_31.s335 - TextStrings_31 ; 234
	dw TextStrings_31.s336 - TextStrings_31 ; 235
	dw TextStrings_31.s337 - TextStrings_31 ; 236
	dw TextStrings_31.s338 - TextStrings_31 ; 237
	dw TextStrings_31.s339 - TextStrings_31 ; 238
	dw TextStrings_31.s340 - TextStrings_31 ; 239
	dw TextStrings_31.s341 - TextStrings_31 ; 240
	dw TextStrings_31.s342 - TextStrings_31 ; 241
	dw TextStrings_31.s343 - TextStrings_31 ; 242
	dw TextStrings_31.s344 - TextStrings_31 ; 243
	dw TextStrings_31.s345 - TextStrings_31 ; 244
	dw TextStrings_31.s346 - TextStrings_31 ; 245
	dw TextStrings_31.s348 - TextStrings_31 ; 246
	dw TextStrings_31.s350 - TextStrings_31 ; 247
	dw TextStrings_31.s352 - TextStrings_31 ; 248
	dw TextStrings_31.s354 - TextStrings_31 ; 249
	dw TextStrings_31.s356 - TextStrings_31 ; 250
	dw TextStrings_31.s357 - TextStrings_31 ; 251
	dw TextStrings_31.s359 - TextStrings_31 ; 252
	dw TextStrings_31.s361 - TextStrings_31 ; 253
	dw TextStrings_31.s363 - TextStrings_31 ; 254
	dw TextStrings_31.s365 - TextStrings_31 ; 255
	dw TextStrings_31.s366 - TextStrings_31 ; 256
	dw TextStrings_31.s368 - TextStrings_31 ; 257
	dw TextStrings_31.s370 - TextStrings_31 ; 258
	dw TextStrings_31.s372 - TextStrings_31 ; 259
	dw TextStrings_31.s374 - TextStrings_31 ; 260
	dw TextStrings_31.s376 - TextStrings_31 ; 261
	dw TextStrings_31.s378 - TextStrings_31 ; 262
	dw TextStrings_31.s380 - TextStrings_31 ; 263
	dw TextStrings_31.s382 - TextStrings_31 ; 264
	dw TextStrings_31.s384 - TextStrings_31 ; 265
	dw TextStrings_31.s386 - TextStrings_31 ; 266
	dw TextStrings_31.s388 - TextStrings_31 ; 267
	dw TextStrings_31.s390 - TextStrings_31 ; 268
	dw TextStrings_31.s392 - TextStrings_31 ; 269
	dw TextStrings_31.s394 - TextStrings_31 ; 270
	dw TextStrings_31.s396 - TextStrings_31 ; 271
	dw TextStrings_31.s398 - TextStrings_31 ; 272
	dw TextStrings_31.s400 - TextStrings_31 ; 273
	dw TextStrings_31.s402 - TextStrings_31 ; 274
	dw TextStrings_31.s404 - TextStrings_31 ; 275
	dw TextStrings_31.s406 - TextStrings_31 ; 276
	dw TextStrings_31.s408 - TextStrings_31 ; 277
	dw TextStrings_31.s410 - TextStrings_31 ; 278
	dw TextStrings_31.s411 - TextStrings_31 ; 279
	dw TextStrings_31.s413 - TextStrings_31 ; 280
	dw TextStrings_31.s415 - TextStrings_31 ; 281
	dw TextStrings_31.s417 - TextStrings_31 ; 282
	dw TextStrings_31.s419 - TextStrings_31 ; 283
	dw TextStrings_31.s421 - TextStrings_31 ; 284
	dw TextStrings_31.s422 - TextStrings_31 ; 285
	dw TextStrings_31.s424 - TextStrings_31 ; 286
	dw TextStrings_31.s426 - TextStrings_31 ; 287
	dw TextStrings_31.s428 - TextStrings_31 ; 288
	dw TextStrings_31.s430 - TextStrings_31 ; 289
	dw TextStrings_31.s431 - TextStrings_31 ; 290
	dw TextStrings_31.s433 - TextStrings_31 ; 291
	dw TextStrings_31.s434 - TextStrings_31 ; 292
	dw TextStrings_31.s436 - TextStrings_31 ; 293
	dw TextStrings_31.s438 - TextStrings_31 ; 294
	dw TextStrings_31.s439 - TextStrings_31 ; 295
	dw TextStrings_31.s441 - TextStrings_31 ; 296
	dw TextStrings_31.s442 - TextStrings_31 ; 297
	dw TextStrings_31.s443 - TextStrings_31 ; 298
	dw TextStrings_31.s445 - TextStrings_31 ; 299
	dw TextStrings_31.s447 - TextStrings_31 ; 300
	dw TextStrings_31.s448 - TextStrings_31 ; 301
	dw TextStrings_31.s450 - TextStrings_31 ; 302
	dw TextStrings_31.s451 - TextStrings_31 ; 303
	dw TextStrings_31.s452 - TextStrings_31 ; 304
	dw TextStrings_31.s453 - TextStrings_31 ; 305
	dw TextStrings_31.s455 - TextStrings_31 ; 306
	dw TextStrings_31.s457 - TextStrings_31 ; 307
	dw TextStrings_31.s458 - TextStrings_31 ; 308
	dw TextStrings_31.s460 - TextStrings_31 ; 309
	dw TextStrings_31.s462 - TextStrings_31 ; 310
	dw TextStrings_31.s463 - TextStrings_31 ; 311
	dw TextStrings_31.s465 - TextStrings_31 ; 312
	dw TextStrings_31.s467 - TextStrings_31 ; 313
	dw TextStrings_31.s468 - TextStrings_31 ; 314
	dw TextStrings_31.s470 - TextStrings_31 ; 315
	dw TextStrings_31.s472 - TextStrings_31 ; 316
	dw TextStrings_31.s474 - TextStrings_31 ; 317
	dw TextStrings_31.s476 - TextStrings_31 ; 318
	dw TextStrings_31.s478 - TextStrings_31 ; 319
	dw TextStrings_31.s480 - TextStrings_31 ; 320
	dw TextStrings_31.s482 - TextStrings_31 ; 321
	dw TextStrings_31.s484 - TextStrings_31 ; 322
	dw TextStrings_31.s486 - TextStrings_31 ; 323
	dw TextStrings_31.s488 - TextStrings_31 ; 324
	dw TextStrings_31.s490 - TextStrings_31 ; 325
	dw TextStrings_31.s492 - TextStrings_31 ; 326
	dw TextStrings_31.s494 - TextStrings_31 ; 327
	dw TextStrings_31.s496 - TextStrings_31 ; 328
	dw TextStrings_31.s498 - TextStrings_31 ; 329
	dw TextStrings_31.s500 - TextStrings_31 ; 330
	dw TextStrings_31.s502 - TextStrings_31 ; 331
	dw TextStrings_31.s504 - TextStrings_31 ; 332
	dw TextStrings_31.s505 - TextStrings_31 ; 333
	dw TextStrings_31.s506 - TextStrings_31 ; 334
	dw TextStrings_31.s507 - TextStrings_31 ; 335
	dw TextStrings_31.s508 - TextStrings_31 ; 336
	dw TextStrings_31.s510 - TextStrings_31 ; 337
	dw TextStrings_31.s512 - TextStrings_31 ; 338
	dw TextStrings_31.s514 - TextStrings_31 ; 339
	dw TextStrings_31.s516 - TextStrings_31 ; 340
	dw TextStrings_31.s518 - TextStrings_31 ; 341
	dw TextStrings_31.s520 - TextStrings_31 ; 342
	dw TextStrings_31.s522 - TextStrings_31 ; 343
	dw TextStrings_31.s524 - TextStrings_31 ; 344
	dw TextStrings_31.s526 - TextStrings_31 ; 345
	dw TextStrings_31.s528 - TextStrings_31 ; 346
TextStrings_31:
	INCLUDE "data/bank_031/text_pool_42ba.asm" ; $42ba, 14601 bytes (text_pool)
FetchDialogueText_31:
	push af ; $7bc3
	ld a, $00 ; $7bc4
	call FetchText_31 ; $7bc6
	pop af ; $7bc9
	ret ; $7bca
FetchShortText_31:
	push af ; $7bcb
	ld a, $01 ; $7bcc
	call FetchText_31 ; $7bce
	pop af ; $7bd1
	ret ; $7bd2
FetchText_31:
	push bc ; $7bd3
	push de ; $7bd4
	push hl ; $7bd5
	ld hl, FetchTextTable_31 ; $7bd6
	sla e ; $7bd9
	rl d ; $7bdb
	add hl, de ; $7bdd
	ld e, [hl] ; $7bde
	inc hl ; $7bdf
	ld d, [hl] ; $7be0
	ld hl, TextStrings_31 ; $7be1
	add hl, de ; $7be4
	or a, a ; $7be5
	jr nz, .nonZero ; $7be6
	ld de, wTextBuffer ; $7be8
	ld c, $a0 ; $7beb
	jr .loop ; $7bed
.nonZero:
	ld de, wShortTextBuffer ; $7bef
	ld c, $10 ; $7bf2
.loop:
	dec c ; $7bf4
	jr z, .countDone ; $7bf5
	ld a, [hl+] ; $7bf7
	ld [de], a ; $7bf8
	inc de ; $7bf9
	or a, a ; $7bfa
	jr nz, .loop ; $7bfb
	pop hl ; $7bfd
	pop de ; $7bfe
	pop bc ; $7bff
	ret ; $7c00
.countDone:
	xor a, a ; $7c01
	ld [de], a ; $7c02
	ldh a, [hDebugStepMode] ; $7c03
	or a, a ; $7c05
	jr z, .restore ; $7c06
	sound $2c ; $7c08
.restore:
	pop hl ; $7c0a
	pop de ; $7c0b
	pop bc ; $7c0c
	ret ; $7c0d
	; $7c0e, 1010 bytes fill to bank end (linker-padded)
