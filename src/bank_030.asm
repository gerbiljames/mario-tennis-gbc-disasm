SECTION "ROM Bank $30", ROMX[$4000], BANK[$30]

	farptr FetchDialogueText_30 ; $4000
	farptr FetchShortText_30 ; $4002
FetchTextTable_30:
	; $4004, 1120 bytes (text_offsets)
	dw TextStrings_30.s0 - TextStrings_30 ; 0
	dw TextStrings_30.s1 - TextStrings_30 ; 1
	dw TextStrings_30.s3 - TextStrings_30 ; 2
	dw TextStrings_30.s5 - TextStrings_30 ; 3
	dw TextStrings_30.s7 - TextStrings_30 ; 4
	dw TextStrings_30.s9 - TextStrings_30 ; 5
	dw TextStrings_30.s11 - TextStrings_30 ; 6
	dw TextStrings_30.s13 - TextStrings_30 ; 7
	dw TextStrings_30.s15 - TextStrings_30 ; 8
	dw TextStrings_30.s17 - TextStrings_30 ; 9
	dw TextStrings_30.s19 - TextStrings_30 ; 10
	dw TextStrings_30.s21 - TextStrings_30 ; 11
	dw TextStrings_30.s22 - TextStrings_30 ; 12
	dw TextStrings_30.s23 - TextStrings_30 ; 13
	dw TextStrings_30.s25 - TextStrings_30 ; 14
	dw TextStrings_30.s27 - TextStrings_30 ; 15
	dw TextStrings_30.s29 - TextStrings_30 ; 16
	dw TextStrings_30.s31 - TextStrings_30 ; 17
	dw TextStrings_30.s33 - TextStrings_30 ; 18
	dw TextStrings_30.s35 - TextStrings_30 ; 19
	dw TextStrings_30.s37 - TextStrings_30 ; 20
	dw TextStrings_30.s39 - TextStrings_30 ; 21
	dw TextStrings_30.s41 - TextStrings_30 ; 22
	dw TextStrings_30.s43 - TextStrings_30 ; 23
	dw TextStrings_30.s44 - TextStrings_30 ; 24
	dw TextStrings_30.s45 - TextStrings_30 ; 25
	dw TextStrings_30.s46 - TextStrings_30 ; 26
	dw TextStrings_30.s47 - TextStrings_30 ; 27
	dw TextStrings_30.s48 - TextStrings_30 ; 28
	dw TextStrings_30.s49 - TextStrings_30 ; 29
	dw TextStrings_30.s50 - TextStrings_30 ; 30
	dw TextStrings_30.s51 - TextStrings_30 ; 31
	dw TextStrings_30.s52 - TextStrings_30 ; 32
	dw TextStrings_30.s53 - TextStrings_30 ; 33
	dw TextStrings_30.s54 - TextStrings_30 ; 34
	dw TextStrings_30.s55 - TextStrings_30 ; 35
	dw TextStrings_30.s56 - TextStrings_30 ; 36
	dw TextStrings_30.s57 - TextStrings_30 ; 37
	dw TextStrings_30.s58 - TextStrings_30 ; 38
	dw TextStrings_30.s59 - TextStrings_30 ; 39
	dw TextStrings_30.s60 - TextStrings_30 ; 40
	dw TextStrings_30.s61 - TextStrings_30 ; 41
	dw TextStrings_30.s62 - TextStrings_30 ; 42
	dw TextStrings_30.s63 - TextStrings_30 ; 43
	dw TextStrings_30.s64 - TextStrings_30 ; 44
	dw TextStrings_30.s65 - TextStrings_30 ; 45
	dw TextStrings_30.s66 - TextStrings_30 ; 46
	dw TextStrings_30.s67 - TextStrings_30 ; 47
	dw TextStrings_30.s68 - TextStrings_30 ; 48
	dw TextStrings_30.s69 - TextStrings_30 ; 49
	dw TextStrings_30.s70 - TextStrings_30 ; 50
	dw TextStrings_30.s71 - TextStrings_30 ; 51
	dw TextStrings_30.s72 - TextStrings_30 ; 52
	dw TextStrings_30.s73 - TextStrings_30 ; 53
	dw TextStrings_30.s74 - TextStrings_30 ; 54
	dw TextStrings_30.s75 - TextStrings_30 ; 55
	dw TextStrings_30.s76 - TextStrings_30 ; 56
	dw TextStrings_30.s77 - TextStrings_30 ; 57
	dw TextStrings_30.s78 - TextStrings_30 ; 58
	dw TextStrings_30.s79 - TextStrings_30 ; 59
	dw TextStrings_30.s80 - TextStrings_30 ; 60
	dw TextStrings_30.s81 - TextStrings_30 ; 61
	dw TextStrings_30.s82 - TextStrings_30 ; 62
	dw TextStrings_30.s83 - TextStrings_30 ; 63
	dw TextStrings_30.s84 - TextStrings_30 ; 64
	dw TextStrings_30.s85 - TextStrings_30 ; 65
	dw TextStrings_30.s86 - TextStrings_30 ; 66
	dw TextStrings_30.s87 - TextStrings_30 ; 67
	dw TextStrings_30.s88 - TextStrings_30 ; 68
	dw TextStrings_30.s89 - TextStrings_30 ; 69
	dw TextStrings_30.s90 - TextStrings_30 ; 70
	dw TextStrings_30.s91 - TextStrings_30 ; 71
	dw TextStrings_30.s92 - TextStrings_30 ; 72
	dw TextStrings_30.s93 - TextStrings_30 ; 73
	dw TextStrings_30.s94 - TextStrings_30 ; 74
	dw TextStrings_30.s95 - TextStrings_30 ; 75
	dw TextStrings_30.s96 - TextStrings_30 ; 76
	dw TextStrings_30.s97 - TextStrings_30 ; 77
	dw TextStrings_30.s98 - TextStrings_30 ; 78
	dw TextStrings_30.s99 - TextStrings_30 ; 79
	dw TextStrings_30.s100 - TextStrings_30 ; 80
	dw TextStrings_30.s101 - TextStrings_30 ; 81
	dw TextStrings_30.s102 - TextStrings_30 ; 82
	dw TextStrings_30.s103 - TextStrings_30 ; 83
	dw TextStrings_30.s104 - TextStrings_30 ; 84
	dw TextStrings_30.s105 - TextStrings_30 ; 85
	dw TextStrings_30.s106 - TextStrings_30 ; 86
	dw TextStrings_30.s107 - TextStrings_30 ; 87
	dw TextStrings_30.s108 - TextStrings_30 ; 88
	dw TextStrings_30.s109 - TextStrings_30 ; 89
	dw TextStrings_30.s110 - TextStrings_30 ; 90
	dw TextStrings_30.s111 - TextStrings_30 ; 91
	dw TextStrings_30.s112 - TextStrings_30 ; 92
	dw TextStrings_30.s113 - TextStrings_30 ; 93
	dw TextStrings_30.s114 - TextStrings_30 ; 94
	dw TextStrings_30.s115 - TextStrings_30 ; 95
	dw TextStrings_30.s116 - TextStrings_30 ; 96
	dw TextStrings_30.s117 - TextStrings_30 ; 97
	dw TextStrings_30.s118 - TextStrings_30 ; 98
	dw TextStrings_30.s119 - TextStrings_30 ; 99
	dw TextStrings_30.s120 - TextStrings_30 ; 100
	dw TextStrings_30.s121 - TextStrings_30 ; 101
	dw TextStrings_30.s122 - TextStrings_30 ; 102
	dw TextStrings_30.s123 - TextStrings_30 ; 103
	dw TextStrings_30.s124 - TextStrings_30 ; 104
	dw TextStrings_30.s125 - TextStrings_30 ; 105
	dw TextStrings_30.s126 - TextStrings_30 ; 106
	dw TextStrings_30.s127 - TextStrings_30 ; 107
	dw TextStrings_30.s128 - TextStrings_30 ; 108
	dw TextStrings_30.s129 - TextStrings_30 ; 109
	dw TextStrings_30.s130 - TextStrings_30 ; 110
	dw TextStrings_30.s131 - TextStrings_30 ; 111
	dw TextStrings_30.s132 - TextStrings_30 ; 112
	dw TextStrings_30.s133 - TextStrings_30 ; 113
	dw TextStrings_30.s134 - TextStrings_30 ; 114
	dw TextStrings_30.s135 - TextStrings_30 ; 115
	dw TextStrings_30.s136 - TextStrings_30 ; 116
	dw TextStrings_30.s137 - TextStrings_30 ; 117
	dw TextStrings_30.s138 - TextStrings_30 ; 118
	dw TextStrings_30.s139 - TextStrings_30 ; 119
	dw TextStrings_30.s140 - TextStrings_30 ; 120
	dw TextStrings_30.s141 - TextStrings_30 ; 121
	dw TextStrings_30.s142 - TextStrings_30 ; 122
	dw TextStrings_30.s143 - TextStrings_30 ; 123
	dw TextStrings_30.s144 - TextStrings_30 ; 124
	dw TextStrings_30.s145 - TextStrings_30 ; 125
	dw TextStrings_30.s146 - TextStrings_30 ; 126
	dw TextStrings_30.s147 - TextStrings_30 ; 127
	dw TextStrings_30.s148 - TextStrings_30 ; 128
	dw TextStrings_30.s149 - TextStrings_30 ; 129
	dw TextStrings_30.s150 - TextStrings_30 ; 130
	dw TextStrings_30.s151 - TextStrings_30 ; 131
	dw TextStrings_30.s152 - TextStrings_30 ; 132
	dw TextStrings_30.s153 - TextStrings_30 ; 133
	dw TextStrings_30.s154 - TextStrings_30 ; 134
	dw TextStrings_30.s155 - TextStrings_30 ; 135
	dw TextStrings_30.s156 - TextStrings_30 ; 136
	dw TextStrings_30.s157 - TextStrings_30 ; 137
	dw TextStrings_30.s158 - TextStrings_30 ; 138
	dw TextStrings_30.s159 - TextStrings_30 ; 139
	dw TextStrings_30.s160 - TextStrings_30 ; 140
	dw TextStrings_30.s161 - TextStrings_30 ; 141
	dw TextStrings_30.s162 - TextStrings_30 ; 142
	dw TextStrings_30.s163 - TextStrings_30 ; 143
	dw TextStrings_30.s164 - TextStrings_30 ; 144
	dw TextStrings_30.s165 - TextStrings_30 ; 145
	dw TextStrings_30.s166 - TextStrings_30 ; 146
	dw TextStrings_30.s167 - TextStrings_30 ; 147
	dw TextStrings_30.s168 - TextStrings_30 ; 148
	dw TextStrings_30.s169 - TextStrings_30 ; 149
	dw TextStrings_30.s170 - TextStrings_30 ; 150
	dw TextStrings_30.s171 - TextStrings_30 ; 151
	dw TextStrings_30.s172 - TextStrings_30 ; 152
	dw TextStrings_30.s173 - TextStrings_30 ; 153
	dw TextStrings_30.s174 - TextStrings_30 ; 154
	dw TextStrings_30.s175 - TextStrings_30 ; 155
	dw TextStrings_30.s176 - TextStrings_30 ; 156
	dw TextStrings_30.s177 - TextStrings_30 ; 157
	dw TextStrings_30.s178 - TextStrings_30 ; 158
	dw TextStrings_30.s179 - TextStrings_30 ; 159
	dw TextStrings_30.s180 - TextStrings_30 ; 160
	dw TextStrings_30.s181 - TextStrings_30 ; 161
	dw TextStrings_30.s182 - TextStrings_30 ; 162
	dw TextStrings_30.s183 - TextStrings_30 ; 163
	dw TextStrings_30.s184 - TextStrings_30 ; 164
	dw TextStrings_30.s185 - TextStrings_30 ; 165
	dw TextStrings_30.s186 - TextStrings_30 ; 166
	dw TextStrings_30.s187 - TextStrings_30 ; 167
	dw TextStrings_30.s188 - TextStrings_30 ; 168
	dw TextStrings_30.s189 - TextStrings_30 ; 169
	dw TextStrings_30.s190 - TextStrings_30 ; 170
	dw TextStrings_30.s191 - TextStrings_30 ; 171
	dw TextStrings_30.s192 - TextStrings_30 ; 172
	dw TextStrings_30.s193 - TextStrings_30 ; 173
	dw TextStrings_30.s194 - TextStrings_30 ; 174
	dw TextStrings_30.s195 - TextStrings_30 ; 175
	dw TextStrings_30.s196 - TextStrings_30 ; 176
	dw TextStrings_30.s197 - TextStrings_30 ; 177
	dw TextStrings_30.s198 - TextStrings_30 ; 178
	dw TextStrings_30.s199 - TextStrings_30 ; 179
	dw TextStrings_30.s200 - TextStrings_30 ; 180
	dw TextStrings_30.s201 - TextStrings_30 ; 181
	dw TextStrings_30.s202 - TextStrings_30 ; 182
	dw TextStrings_30.s203 - TextStrings_30 ; 183
	dw TextStrings_30.s204 - TextStrings_30 ; 184
	dw TextStrings_30.s205 - TextStrings_30 ; 185
	dw TextStrings_30.s206 - TextStrings_30 ; 186
	dw TextStrings_30.s207 - TextStrings_30 ; 187
	dw TextStrings_30.s208 - TextStrings_30 ; 188
	dw TextStrings_30.s209 - TextStrings_30 ; 189
	dw TextStrings_30.s210 - TextStrings_30 ; 190
	dw TextStrings_30.s211 - TextStrings_30 ; 191
	dw TextStrings_30.s212 - TextStrings_30 ; 192
	dw TextStrings_30.s213 - TextStrings_30 ; 193
	dw TextStrings_30.s214 - TextStrings_30 ; 194
	dw TextStrings_30.s215 - TextStrings_30 ; 195
	dw TextStrings_30.s216 - TextStrings_30 ; 196
	dw TextStrings_30.s217 - TextStrings_30 ; 197
	dw TextStrings_30.s218 - TextStrings_30 ; 198
	dw TextStrings_30.s219 - TextStrings_30 ; 199
	dw TextStrings_30.s220 - TextStrings_30 ; 200
	dw TextStrings_30.s221 - TextStrings_30 ; 201
	dw TextStrings_30.s222 - TextStrings_30 ; 202
	dw TextStrings_30.s223 - TextStrings_30 ; 203
	dw TextStrings_30.s224 - TextStrings_30 ; 204
	dw TextStrings_30.s225 - TextStrings_30 ; 205
	dw TextStrings_30.s226 - TextStrings_30 ; 206
	dw TextStrings_30.s227 - TextStrings_30 ; 207
	dw TextStrings_30.s228 - TextStrings_30 ; 208
	dw TextStrings_30.s229 - TextStrings_30 ; 209
	dw TextStrings_30.s230 - TextStrings_30 ; 210
	dw TextStrings_30.s231 - TextStrings_30 ; 211
	dw TextStrings_30.s232 - TextStrings_30 ; 212
	dw TextStrings_30.s233 - TextStrings_30 ; 213
	dw TextStrings_30.s234 - TextStrings_30 ; 214
	dw TextStrings_30.s235 - TextStrings_30 ; 215
	dw TextStrings_30.s236 - TextStrings_30 ; 216
	dw TextStrings_30.s237 - TextStrings_30 ; 217
	dw TextStrings_30.s238 - TextStrings_30 ; 218
	dw TextStrings_30.s239 - TextStrings_30 ; 219
	dw TextStrings_30.s240 - TextStrings_30 ; 220
	dw TextStrings_30.s241 - TextStrings_30 ; 221
	dw TextStrings_30.s242 - TextStrings_30 ; 222
	dw TextStrings_30.s243 - TextStrings_30 ; 223
	dw TextStrings_30.s244 - TextStrings_30 ; 224
	dw TextStrings_30.s245 - TextStrings_30 ; 225
	dw TextStrings_30.s246 - TextStrings_30 ; 226
	dw TextStrings_30.s247 - TextStrings_30 ; 227
	dw TextStrings_30.s248 - TextStrings_30 ; 228
	dw TextStrings_30.s249 - TextStrings_30 ; 229
	dw TextStrings_30.s250 - TextStrings_30 ; 230
	dw TextStrings_30.s251 - TextStrings_30 ; 231
	dw TextStrings_30.s252 - TextStrings_30 ; 232
	dw TextStrings_30.s253 - TextStrings_30 ; 233
	dw TextStrings_30.s254 - TextStrings_30 ; 234
	dw TextStrings_30.s255 - TextStrings_30 ; 235
	dw TextStrings_30.s256 - TextStrings_30 ; 236
	dw TextStrings_30.s257 - TextStrings_30 ; 237
	dw TextStrings_30.s258 - TextStrings_30 ; 238
	dw TextStrings_30.s259 - TextStrings_30 ; 239
	dw TextStrings_30.s260 - TextStrings_30 ; 240
	dw TextStrings_30.s261 - TextStrings_30 ; 241
	dw TextStrings_30.s262 - TextStrings_30 ; 242
	dw TextStrings_30.s263 - TextStrings_30 ; 243
	dw TextStrings_30.s264 - TextStrings_30 ; 244
	dw TextStrings_30.s265 - TextStrings_30 ; 245
	dw TextStrings_30.s266 - TextStrings_30 ; 246
	dw TextStrings_30.s267 - TextStrings_30 ; 247
	dw TextStrings_30.s268 - TextStrings_30 ; 248
	dw TextStrings_30.s269 - TextStrings_30 ; 249
	dw TextStrings_30.s270 - TextStrings_30 ; 250
	dw TextStrings_30.s271 - TextStrings_30 ; 251
	dw TextStrings_30.s272 - TextStrings_30 ; 252
	dw TextStrings_30.s273 - TextStrings_30 ; 253
	dw TextStrings_30.s274 - TextStrings_30 ; 254
	dw TextStrings_30.s275 - TextStrings_30 ; 255
	dw TextStrings_30.s276 - TextStrings_30 ; 256
	dw TextStrings_30.s277 - TextStrings_30 ; 257
	dw TextStrings_30.s278 - TextStrings_30 ; 258
	dw TextStrings_30.s279 - TextStrings_30 ; 259
	dw TextStrings_30.s280 - TextStrings_30 ; 260
	dw TextStrings_30.s281 - TextStrings_30 ; 261
	dw TextStrings_30.s282 - TextStrings_30 ; 262
	dw TextStrings_30.s283 - TextStrings_30 ; 263
	dw TextStrings_30.s284 - TextStrings_30 ; 264
	dw TextStrings_30.s285 - TextStrings_30 ; 265
	dw TextStrings_30.s286 - TextStrings_30 ; 266
	dw TextStrings_30.s287 - TextStrings_30 ; 267
	dw TextStrings_30.s288 - TextStrings_30 ; 268
	dw TextStrings_30.s289 - TextStrings_30 ; 269
	dw TextStrings_30.s290 - TextStrings_30 ; 270
	dw TextStrings_30.s291 - TextStrings_30 ; 271
	dw TextStrings_30.s292 - TextStrings_30 ; 272
	dw TextStrings_30.s293 - TextStrings_30 ; 273
	dw TextStrings_30.s294 - TextStrings_30 ; 274
	dw TextStrings_30.s295 - TextStrings_30 ; 275
	dw TextStrings_30.s296 - TextStrings_30 ; 276
	dw TextStrings_30.s297 - TextStrings_30 ; 277
	dw TextStrings_30.s298 - TextStrings_30 ; 278
	dw TextStrings_30.s299 - TextStrings_30 ; 279
	dw TextStrings_30.s300 - TextStrings_30 ; 280
	dw TextStrings_30.s301 - TextStrings_30 ; 281
	dw TextStrings_30.s302 - TextStrings_30 ; 282
	dw TextStrings_30.s303 - TextStrings_30 ; 283
	dw TextStrings_30.s304 - TextStrings_30 ; 284
	dw TextStrings_30.s305 - TextStrings_30 ; 285
	dw TextStrings_30.s306 - TextStrings_30 ; 286
	dw TextStrings_30.s307 - TextStrings_30 ; 287
	dw TextStrings_30.s308 - TextStrings_30 ; 288
	dw TextStrings_30.s309 - TextStrings_30 ; 289
	dw TextStrings_30.s310 - TextStrings_30 ; 290
	dw TextStrings_30.s311 - TextStrings_30 ; 291
	dw TextStrings_30.s312 - TextStrings_30 ; 292
	dw TextStrings_30.s313 - TextStrings_30 ; 293
	dw TextStrings_30.s314 - TextStrings_30 ; 294
	dw TextStrings_30.s315 - TextStrings_30 ; 295
	dw TextStrings_30.s316 - TextStrings_30 ; 296
	dw TextStrings_30.s317 - TextStrings_30 ; 297
	dw TextStrings_30.s318 - TextStrings_30 ; 298
	dw TextStrings_30.s319 - TextStrings_30 ; 299
	dw TextStrings_30.s320 - TextStrings_30 ; 300
	dw TextStrings_30.s321 - TextStrings_30 ; 301
	dw TextStrings_30.s322 - TextStrings_30 ; 302
	dw TextStrings_30.s323 - TextStrings_30 ; 303
	dw TextStrings_30.s324 - TextStrings_30 ; 304
	dw TextStrings_30.s325 - TextStrings_30 ; 305
	dw TextStrings_30.s326 - TextStrings_30 ; 306
	dw TextStrings_30.s327 - TextStrings_30 ; 307
	dw TextStrings_30.s328 - TextStrings_30 ; 308
	dw TextStrings_30.s329 - TextStrings_30 ; 309
	dw TextStrings_30.s330 - TextStrings_30 ; 310
	dw TextStrings_30.s331 - TextStrings_30 ; 311
	dw TextStrings_30.s332 - TextStrings_30 ; 312
	dw TextStrings_30.s334 - TextStrings_30 ; 313
	dw TextStrings_30.s335 - TextStrings_30 ; 314
	dw TextStrings_30.s336 - TextStrings_30 ; 315
	dw TextStrings_30.s337 - TextStrings_30 ; 316
	dw TextStrings_30.s338 - TextStrings_30 ; 317
	dw TextStrings_30.s339 - TextStrings_30 ; 318
	dw TextStrings_30.s340 - TextStrings_30 ; 319
	dw TextStrings_30.s341 - TextStrings_30 ; 320
	dw TextStrings_30.s342 - TextStrings_30 ; 321
	dw TextStrings_30.s343 - TextStrings_30 ; 322
	dw TextStrings_30.s344 - TextStrings_30 ; 323
	dw TextStrings_30.s345 - TextStrings_30 ; 324
	dw TextStrings_30.s346 - TextStrings_30 ; 325
	dw TextStrings_30.s347 - TextStrings_30 ; 326
	dw TextStrings_30.s348 - TextStrings_30 ; 327
	dw TextStrings_30.s349 - TextStrings_30 ; 328
	dw TextStrings_30.s350 - TextStrings_30 ; 329
	dw TextStrings_30.s351 - TextStrings_30 ; 330
	dw TextStrings_30.s352 - TextStrings_30 ; 331
	dw TextStrings_30.s353 - TextStrings_30 ; 332
	dw TextStrings_30.s354 - TextStrings_30 ; 333
	dw TextStrings_30.s355 - TextStrings_30 ; 334
	dw TextStrings_30.s356 - TextStrings_30 ; 335
	dw TextStrings_30.s357 - TextStrings_30 ; 336
	dw TextStrings_30.s358 - TextStrings_30 ; 337
	dw TextStrings_30.s359 - TextStrings_30 ; 338
	dw TextStrings_30.s360 - TextStrings_30 ; 339
	dw TextStrings_30.s361 - TextStrings_30 ; 340
	dw TextStrings_30.s362 - TextStrings_30 ; 341
	dw TextStrings_30.s363 - TextStrings_30 ; 342
	dw TextStrings_30.s364 - TextStrings_30 ; 343
	dw TextStrings_30.s365 - TextStrings_30 ; 344
	dw TextStrings_30.s366 - TextStrings_30 ; 345
	dw TextStrings_30.s367 - TextStrings_30 ; 346
	dw TextStrings_30.s368 - TextStrings_30 ; 347
	dw TextStrings_30.s369 - TextStrings_30 ; 348
	dw TextStrings_30.s370 - TextStrings_30 ; 349
	dw TextStrings_30.s371 - TextStrings_30 ; 350
	dw TextStrings_30.s372 - TextStrings_30 ; 351
	dw TextStrings_30.s374 - TextStrings_30 ; 352
	dw TextStrings_30.s376 - TextStrings_30 ; 353
	dw TextStrings_30.s378 - TextStrings_30 ; 354
	dw TextStrings_30.s379 - TextStrings_30 ; 355
	dw TextStrings_30.s380 - TextStrings_30 ; 356
	dw TextStrings_30.s381 - TextStrings_30 ; 357
	dw TextStrings_30.s382 - TextStrings_30 ; 358
	dw TextStrings_30.s383 - TextStrings_30 ; 359
	dw TextStrings_30.s384 - TextStrings_30 ; 360
	dw TextStrings_30.s385 - TextStrings_30 ; 361
	dw TextStrings_30.s386 - TextStrings_30 ; 362
	dw TextStrings_30.s387 - TextStrings_30 ; 363
	dw TextStrings_30.s388 - TextStrings_30 ; 364
	dw TextStrings_30.s389 - TextStrings_30 ; 365
	dw TextStrings_30.s390 - TextStrings_30 ; 366
	dw TextStrings_30.s391 - TextStrings_30 ; 367
	dw TextStrings_30.s392 - TextStrings_30 ; 368
	dw TextStrings_30.s393 - TextStrings_30 ; 369
	dw TextStrings_30.s394 - TextStrings_30 ; 370
	dw TextStrings_30.s395 - TextStrings_30 ; 371
	dw TextStrings_30.s396 - TextStrings_30 ; 372
	dw TextStrings_30.s397 - TextStrings_30 ; 373
	dw TextStrings_30.s398 - TextStrings_30 ; 374
	dw TextStrings_30.s399 - TextStrings_30 ; 375
	dw TextStrings_30.s400 - TextStrings_30 ; 376
	dw TextStrings_30.s401 - TextStrings_30 ; 377
	dw TextStrings_30.s402 - TextStrings_30 ; 378
	dw TextStrings_30.s403 - TextStrings_30 ; 379
	dw TextStrings_30.s404 - TextStrings_30 ; 380
	dw TextStrings_30.s405 - TextStrings_30 ; 381
	dw TextStrings_30.s406 - TextStrings_30 ; 382
	dw TextStrings_30.s407 - TextStrings_30 ; 383
	dw TextStrings_30.s408 - TextStrings_30 ; 384
	dw TextStrings_30.s409 - TextStrings_30 ; 385
	dw TextStrings_30.s410 - TextStrings_30 ; 386
	dw TextStrings_30.s411 - TextStrings_30 ; 387
	dw TextStrings_30.s412 - TextStrings_30 ; 388
	dw TextStrings_30.s413 - TextStrings_30 ; 389
	dw TextStrings_30.s414 - TextStrings_30 ; 390
	dw TextStrings_30.s415 - TextStrings_30 ; 391
	dw TextStrings_30.s416 - TextStrings_30 ; 392
	dw TextStrings_30.s417 - TextStrings_30 ; 393
	dw TextStrings_30.s418 - TextStrings_30 ; 394
	dw TextStrings_30.s419 - TextStrings_30 ; 395
	dw TextStrings_30.s420 - TextStrings_30 ; 396
	dw TextStrings_30.s421 - TextStrings_30 ; 397
	dw TextStrings_30.s422 - TextStrings_30 ; 398
	dw TextStrings_30.s423 - TextStrings_30 ; 399
	dw TextStrings_30.s424 - TextStrings_30 ; 400
	dw TextStrings_30.s425 - TextStrings_30 ; 401
	dw TextStrings_30.s426 - TextStrings_30 ; 402
	dw TextStrings_30.s427 - TextStrings_30 ; 403
	dw TextStrings_30.s428 - TextStrings_30 ; 404
	dw TextStrings_30.s429 - TextStrings_30 ; 405
	dw TextStrings_30.s430 - TextStrings_30 ; 406
	dw TextStrings_30.s431 - TextStrings_30 ; 407
	dw TextStrings_30.s432 - TextStrings_30 ; 408
	dw TextStrings_30.s433 - TextStrings_30 ; 409
	dw TextStrings_30.s434 - TextStrings_30 ; 410
	dw TextStrings_30.s435 - TextStrings_30 ; 411
	dw TextStrings_30.s436 - TextStrings_30 ; 412
	dw TextStrings_30.s437 - TextStrings_30 ; 413
	dw TextStrings_30.s438 - TextStrings_30 ; 414
	dw TextStrings_30.s439 - TextStrings_30 ; 415
	dw TextStrings_30.s440 - TextStrings_30 ; 416
	dw TextStrings_30.s441 - TextStrings_30 ; 417
	dw TextStrings_30.s442 - TextStrings_30 ; 418
	dw TextStrings_30.s443 - TextStrings_30 ; 419
	dw TextStrings_30.s445 - TextStrings_30 ; 420
	dw TextStrings_30.s447 - TextStrings_30 ; 421
	dw TextStrings_30.s449 - TextStrings_30 ; 422
	dw TextStrings_30.s451 - TextStrings_30 ; 423
	dw TextStrings_30.s452 - TextStrings_30 ; 424
	dw TextStrings_30.s453 - TextStrings_30 ; 425
	dw TextStrings_30.s454 - TextStrings_30 ; 426
	dw TextStrings_30.s456 - TextStrings_30 ; 427
	dw TextStrings_30.s458 - TextStrings_30 ; 428
	dw TextStrings_30.s460 - TextStrings_30 ; 429
	dw TextStrings_30.s462 - TextStrings_30 ; 430
	dw TextStrings_30.s464 - TextStrings_30 ; 431
	dw TextStrings_30.s466 - TextStrings_30 ; 432
	dw TextStrings_30.s468 - TextStrings_30 ; 433
	dw TextStrings_30.s470 - TextStrings_30 ; 434
	dw TextStrings_30.s472 - TextStrings_30 ; 435
	dw TextStrings_30.s474 - TextStrings_30 ; 436
	dw TextStrings_30.s476 - TextStrings_30 ; 437
	dw TextStrings_30.s478 - TextStrings_30 ; 438
	dw TextStrings_30.s480 - TextStrings_30 ; 439
	dw TextStrings_30.s482 - TextStrings_30 ; 440
	dw TextStrings_30.s484 - TextStrings_30 ; 441
	dw TextStrings_30.s486 - TextStrings_30 ; 442
	dw TextStrings_30.s488 - TextStrings_30 ; 443
	dw TextStrings_30.s490 - TextStrings_30 ; 444
	dw TextStrings_30.s492 - TextStrings_30 ; 445
	dw TextStrings_30.s494 - TextStrings_30 ; 446
	dw TextStrings_30.s496 - TextStrings_30 ; 447
	dw TextStrings_30.s498 - TextStrings_30 ; 448
	dw TextStrings_30.s500 - TextStrings_30 ; 449
	dw TextStrings_30.s502 - TextStrings_30 ; 450
	dw TextStrings_30.s504 - TextStrings_30 ; 451
	dw TextStrings_30.s506 - TextStrings_30 ; 452
	dw TextStrings_30.s507 - TextStrings_30 ; 453
	dw TextStrings_30.s509 - TextStrings_30 ; 454
	dw TextStrings_30.s511 - TextStrings_30 ; 455
	dw TextStrings_30.s513 - TextStrings_30 ; 456
	dw TextStrings_30.s515 - TextStrings_30 ; 457
	dw TextStrings_30.s517 - TextStrings_30 ; 458
	dw TextStrings_30.s519 - TextStrings_30 ; 459
	dw TextStrings_30.s521 - TextStrings_30 ; 460
	dw TextStrings_30.s522 - TextStrings_30 ; 461
	dw TextStrings_30.s523 - TextStrings_30 ; 462
	dw TextStrings_30.s525 - TextStrings_30 ; 463
	dw TextStrings_30.s527 - TextStrings_30 ; 464
	dw TextStrings_30.s529 - TextStrings_30 ; 465
	dw TextStrings_30.s531 - TextStrings_30 ; 466
	dw TextStrings_30.s533 - TextStrings_30 ; 467
	dw TextStrings_30.s535 - TextStrings_30 ; 468
	dw TextStrings_30.s537 - TextStrings_30 ; 469
	dw TextStrings_30.s539 - TextStrings_30 ; 470
	dw TextStrings_30.s541 - TextStrings_30 ; 471
	dw TextStrings_30.s543 - TextStrings_30 ; 472
	dw TextStrings_30.s545 - TextStrings_30 ; 473
	dw TextStrings_30.s547 - TextStrings_30 ; 474
	dw TextStrings_30.s549 - TextStrings_30 ; 475
	dw TextStrings_30.s551 - TextStrings_30 ; 476
	dw TextStrings_30.s553 - TextStrings_30 ; 477
	dw TextStrings_30.s555 - TextStrings_30 ; 478
	dw TextStrings_30.s557 - TextStrings_30 ; 479
	dw TextStrings_30.s559 - TextStrings_30 ; 480
	dw TextStrings_30.s561 - TextStrings_30 ; 481
	dw TextStrings_30.s563 - TextStrings_30 ; 482
	dw TextStrings_30.s565 - TextStrings_30 ; 483
	dw TextStrings_30.s567 - TextStrings_30 ; 484
	dw TextStrings_30.s569 - TextStrings_30 ; 485
	dw TextStrings_30.s571 - TextStrings_30 ; 486
	dw TextStrings_30.s573 - TextStrings_30 ; 487
	dw TextStrings_30.s574 - TextStrings_30 ; 488
	dw TextStrings_30.s576 - TextStrings_30 ; 489
	dw TextStrings_30.s578 - TextStrings_30 ; 490
	dw TextStrings_30.s580 - TextStrings_30 ; 491
	dw TextStrings_30.s581 - TextStrings_30 ; 492
	dw TextStrings_30.s583 - TextStrings_30 ; 493
	dw TextStrings_30.s585 - TextStrings_30 ; 494
	dw TextStrings_30.s587 - TextStrings_30 ; 495
	dw TextStrings_30.s589 - TextStrings_30 ; 496
	dw TextStrings_30.s591 - TextStrings_30 ; 497
	dw TextStrings_30.s593 - TextStrings_30 ; 498
	dw TextStrings_30.s595 - TextStrings_30 ; 499
	dw TextStrings_30.s597 - TextStrings_30 ; 500
	dw TextStrings_30.s598 - TextStrings_30 ; 501
	dw TextStrings_30.s599 - TextStrings_30 ; 502
	dw TextStrings_30.s601 - TextStrings_30 ; 503
	dw TextStrings_30.s603 - TextStrings_30 ; 504
	dw TextStrings_30.s605 - TextStrings_30 ; 505
	dw TextStrings_30.s607 - TextStrings_30 ; 506
	dw TextStrings_30.s609 - TextStrings_30 ; 507
	dw TextStrings_30.s611 - TextStrings_30 ; 508
	dw TextStrings_30.s613 - TextStrings_30 ; 509
	dw TextStrings_30.s615 - TextStrings_30 ; 510
	dw TextStrings_30.s616 - TextStrings_30 ; 511
	dw TextStrings_30.s618 - TextStrings_30 ; 512
	dw TextStrings_30.s620 - TextStrings_30 ; 513
	dw TextStrings_30.s621 - TextStrings_30 ; 514
	dw TextStrings_30.s622 - TextStrings_30 ; 515
	dw TextStrings_30.s624 - TextStrings_30 ; 516
	dw TextStrings_30.s626 - TextStrings_30 ; 517
	dw TextStrings_30.s628 - TextStrings_30 ; 518
	dw TextStrings_30.s630 - TextStrings_30 ; 519
	dw TextStrings_30.s632 - TextStrings_30 ; 520
	dw TextStrings_30.s634 - TextStrings_30 ; 521
	dw TextStrings_30.s636 - TextStrings_30 ; 522
	dw TextStrings_30.s638 - TextStrings_30 ; 523
	dw TextStrings_30.s640 - TextStrings_30 ; 524
	dw TextStrings_30.s642 - TextStrings_30 ; 525
	dw TextStrings_30.s644 - TextStrings_30 ; 526
	dw TextStrings_30.s646 - TextStrings_30 ; 527
	dw TextStrings_30.s647 - TextStrings_30 ; 528
	dw TextStrings_30.s649 - TextStrings_30 ; 529
	dw TextStrings_30.s650 - TextStrings_30 ; 530
	dw TextStrings_30.s652 - TextStrings_30 ; 531
	dw TextStrings_30.s654 - TextStrings_30 ; 532
	dw TextStrings_30.s656 - TextStrings_30 ; 533
	dw TextStrings_30.s658 - TextStrings_30 ; 534
	dw TextStrings_30.s660 - TextStrings_30 ; 535
	dw TextStrings_30.s662 - TextStrings_30 ; 536
	dw TextStrings_30.s664 - TextStrings_30 ; 537
	dw TextStrings_30.s666 - TextStrings_30 ; 538
	dw TextStrings_30.s668 - TextStrings_30 ; 539
	dw TextStrings_30.s669 - TextStrings_30 ; 540
	dw TextStrings_30.s671 - TextStrings_30 ; 541
	dw TextStrings_30.s673 - TextStrings_30 ; 542
	dw TextStrings_30.s675 - TextStrings_30 ; 543
	dw TextStrings_30.s677 - TextStrings_30 ; 544
	dw TextStrings_30.s678 - TextStrings_30 ; 545
	dw TextStrings_30.s680 - TextStrings_30 ; 546
	dw TextStrings_30.s682 - TextStrings_30 ; 547
	dw TextStrings_30.s683 - TextStrings_30 ; 548
	dw TextStrings_30.s685 - TextStrings_30 ; 549
	dw TextStrings_30.s686 - TextStrings_30 ; 550
	dw TextStrings_30.s688 - TextStrings_30 ; 551
	dw TextStrings_30.s689 - TextStrings_30 ; 552
	dw TextStrings_30.s691 - TextStrings_30 ; 553
	dw TextStrings_30.s693 - TextStrings_30 ; 554
	dw TextStrings_30.s695 - TextStrings_30 ; 555
	dw TextStrings_30.s697 - TextStrings_30 ; 556
	dw TextStrings_30.s699 - TextStrings_30 ; 557
	dw TextStrings_30.s701 - TextStrings_30 ; 558
	dw TextStrings_30.s703 - TextStrings_30 ; 559
TextStrings_30:
	INCLUDE "data/bank_030/text_pool_4464.asm" ; $4464, 14622 bytes (text_pool)
FetchDialogueText_30:
	push af ; $7d82
	ld a, $00 ; $7d83
	call FetchText_30 ; $7d85
	pop af ; $7d88
	ret ; $7d89
FetchShortText_30:
	push af ; $7d8a
	ld a, $01 ; $7d8b
	call FetchText_30 ; $7d8d
	pop af ; $7d90
	ret ; $7d91
FetchText_30:
	push bc ; $7d92
	push de ; $7d93
	push hl ; $7d94
	ld hl, FetchTextTable_30 ; $7d95
	sla e ; $7d98
	rl d ; $7d9a
	add hl, de ; $7d9c
	ld e, [hl] ; $7d9d
	inc hl ; $7d9e
	ld d, [hl] ; $7d9f
	ld hl, TextStrings_30 ; $7da0
	add hl, de ; $7da3
	or a ; $7da4
	jr nz, .nonZero ; $7da5
	ld de, wTextBuffer ; $7da7
	ld c, $a0 ; $7daa
	jr .loop ; $7dac
.nonZero:
	ld de, wShortTextBuffer ; $7dae
	ld c, $10 ; $7db1
.loop:
	dec c ; $7db3
	jr z, .countDone ; $7db4
	ld a, [hl+] ; $7db6
	ld [de], a ; $7db7
	inc de ; $7db8
	or a ; $7db9
	jr nz, .loop ; $7dba
	pop hl ; $7dbc
	pop de ; $7dbd
	pop bc ; $7dbe
	ret ; $7dbf
.countDone:
	xor a ; $7dc0
	ld [de], a ; $7dc1
	ldh a, [hDebugStepMode] ; $7dc2
	or a ; $7dc4
	jr z, .restore ; $7dc5
	sound $2c ; $7dc7
.restore:
	pop hl ; $7dc9
	pop de ; $7dca
	pop bc ; $7dcb
	ret ; $7dcc
	; $7dcd, 563 bytes fill to bank end (linker-padded)
