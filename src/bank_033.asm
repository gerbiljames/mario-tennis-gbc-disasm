SECTION "ROM Bank $33", ROMX[$4000], BANK[$33]

	farptr FetchDialogueText_33 ; $4000
	farptr FetchShortText_33 ; $4002
FetchTextTable_33:
	; $4004, 442 bytes (text_offsets)
	dw TextStrings_33.s0 - TextStrings_33 ; 0
	dw TextStrings_33.s2 - TextStrings_33 ; 1
	dw TextStrings_33.s4 - TextStrings_33 ; 2
	dw TextStrings_33.s6 - TextStrings_33 ; 3
	dw TextStrings_33.s8 - TextStrings_33 ; 4
	dw TextStrings_33.s10 - TextStrings_33 ; 5
	dw TextStrings_33.s12 - TextStrings_33 ; 6
	dw TextStrings_33.s14 - TextStrings_33 ; 7
	dw TextStrings_33.s16 - TextStrings_33 ; 8
	dw TextStrings_33.s18 - TextStrings_33 ; 9
	dw TextStrings_33.s20 - TextStrings_33 ; 10
	dw TextStrings_33.s22 - TextStrings_33 ; 11
	dw TextStrings_33.s24 - TextStrings_33 ; 12
	dw TextStrings_33.s26 - TextStrings_33 ; 13
	dw TextStrings_33.s28 - TextStrings_33 ; 14
	dw TextStrings_33.s30 - TextStrings_33 ; 15
	dw TextStrings_33.s32 - TextStrings_33 ; 16
	dw TextStrings_33.s33 - TextStrings_33 ; 17
	dw TextStrings_33.s35 - TextStrings_33 ; 18
	dw TextStrings_33.s37 - TextStrings_33 ; 19
	dw TextStrings_33.s39 - TextStrings_33 ; 20
	dw TextStrings_33.s41 - TextStrings_33 ; 21
	dw TextStrings_33.s43 - TextStrings_33 ; 22
	dw TextStrings_33.s45 - TextStrings_33 ; 23
	dw TextStrings_33.s47 - TextStrings_33 ; 24
	dw TextStrings_33.s48 - TextStrings_33 ; 25
	dw TextStrings_33.s50 - TextStrings_33 ; 26
	dw TextStrings_33.s52 - TextStrings_33 ; 27
	dw TextStrings_33.s54 - TextStrings_33 ; 28
	dw TextStrings_33.s56 - TextStrings_33 ; 29
	dw TextStrings_33.s58 - TextStrings_33 ; 30
	dw TextStrings_33.s59 - TextStrings_33 ; 31
	dw TextStrings_33.s61 - TextStrings_33 ; 32
	dw TextStrings_33.s63 - TextStrings_33 ; 33
	dw TextStrings_33.s65 - TextStrings_33 ; 34
	dw TextStrings_33.s67 - TextStrings_33 ; 35
	dw TextStrings_33.s69 - TextStrings_33 ; 36
	dw TextStrings_33.s71 - TextStrings_33 ; 37
	dw TextStrings_33.s73 - TextStrings_33 ; 38
	dw TextStrings_33.s75 - TextStrings_33 ; 39
	dw TextStrings_33.s77 - TextStrings_33 ; 40
	dw TextStrings_33.s79 - TextStrings_33 ; 41
	dw TextStrings_33.s81 - TextStrings_33 ; 42
	dw TextStrings_33.s83 - TextStrings_33 ; 43
	dw TextStrings_33.s85 - TextStrings_33 ; 44
	dw TextStrings_33.s87 - TextStrings_33 ; 45
	dw TextStrings_33.s89 - TextStrings_33 ; 46
	dw TextStrings_33.s90 - TextStrings_33 ; 47
	dw TextStrings_33.s92 - TextStrings_33 ; 48
	dw TextStrings_33.s94 - TextStrings_33 ; 49
	dw TextStrings_33.s95 - TextStrings_33 ; 50
	dw TextStrings_33.s97 - TextStrings_33 ; 51
	dw TextStrings_33.s99 - TextStrings_33 ; 52
	dw TextStrings_33.s101 - TextStrings_33 ; 53
	dw TextStrings_33.s103 - TextStrings_33 ; 54
	dw TextStrings_33.s105 - TextStrings_33 ; 55
	dw TextStrings_33.s107 - TextStrings_33 ; 56
	dw TextStrings_33.s109 - TextStrings_33 ; 57
	dw TextStrings_33.s111 - TextStrings_33 ; 58
	dw TextStrings_33.s113 - TextStrings_33 ; 59
	dw TextStrings_33.s115 - TextStrings_33 ; 60
	dw TextStrings_33.s117 - TextStrings_33 ; 61
	dw TextStrings_33.s119 - TextStrings_33 ; 62
	dw TextStrings_33.s121 - TextStrings_33 ; 63
	dw TextStrings_33.s123 - TextStrings_33 ; 64
	dw TextStrings_33.s125 - TextStrings_33 ; 65
	dw TextStrings_33.s127 - TextStrings_33 ; 66
	dw TextStrings_33.s129 - TextStrings_33 ; 67
	dw TextStrings_33.s130 - TextStrings_33 ; 68
	dw TextStrings_33.s132 - TextStrings_33 ; 69
	dw TextStrings_33.s134 - TextStrings_33 ; 70
	dw TextStrings_33.s136 - TextStrings_33 ; 71
	dw TextStrings_33.s138 - TextStrings_33 ; 72
	dw TextStrings_33.s140 - TextStrings_33 ; 73
	dw TextStrings_33.s142 - TextStrings_33 ; 74
	dw TextStrings_33.s144 - TextStrings_33 ; 75
	dw TextStrings_33.s146 - TextStrings_33 ; 76
	dw TextStrings_33.s148 - TextStrings_33 ; 77
	dw TextStrings_33.s150 - TextStrings_33 ; 78
	dw TextStrings_33.s152 - TextStrings_33 ; 79
	dw TextStrings_33.s154 - TextStrings_33 ; 80
	dw TextStrings_33.s156 - TextStrings_33 ; 81
	dw TextStrings_33.s158 - TextStrings_33 ; 82
	dw TextStrings_33.s160 - TextStrings_33 ; 83
	dw TextStrings_33.s161 - TextStrings_33 ; 84
	dw TextStrings_33.s163 - TextStrings_33 ; 85
	dw TextStrings_33.s165 - TextStrings_33 ; 86
	dw TextStrings_33.s166 - TextStrings_33 ; 87
	dw TextStrings_33.s168 - TextStrings_33 ; 88
	dw TextStrings_33.s170 - TextStrings_33 ; 89
	dw TextStrings_33.s172 - TextStrings_33 ; 90
	dw TextStrings_33.s173 - TextStrings_33 ; 91
	dw TextStrings_33.s175 - TextStrings_33 ; 92
	dw TextStrings_33.s177 - TextStrings_33 ; 93
	dw TextStrings_33.s179 - TextStrings_33 ; 94
	dw TextStrings_33.s181 - TextStrings_33 ; 95
	dw TextStrings_33.s183 - TextStrings_33 ; 96
	dw TextStrings_33.s185 - TextStrings_33 ; 97
	dw TextStrings_33.s187 - TextStrings_33 ; 98
	dw TextStrings_33.s189 - TextStrings_33 ; 99
	dw TextStrings_33.s191 - TextStrings_33 ; 100
	dw TextStrings_33.s193 - TextStrings_33 ; 101
	dw TextStrings_33.s194 - TextStrings_33 ; 102
	dw TextStrings_33.s196 - TextStrings_33 ; 103
	dw TextStrings_33.s198 - TextStrings_33 ; 104
	dw TextStrings_33.s200 - TextStrings_33 ; 105
	dw TextStrings_33.s202 - TextStrings_33 ; 106
	dw TextStrings_33.s204 - TextStrings_33 ; 107
	dw TextStrings_33.s206 - TextStrings_33 ; 108
	dw TextStrings_33.s208 - TextStrings_33 ; 109
	dw TextStrings_33.s210 - TextStrings_33 ; 110
	dw TextStrings_33.s211 - TextStrings_33 ; 111
	dw TextStrings_33.s213 - TextStrings_33 ; 112
	dw TextStrings_33.s215 - TextStrings_33 ; 113
	dw TextStrings_33.s217 - TextStrings_33 ; 114
	dw TextStrings_33.s219 - TextStrings_33 ; 115
	dw TextStrings_33.s221 - TextStrings_33 ; 116
	dw TextStrings_33.s223 - TextStrings_33 ; 117
	dw TextStrings_33.s225 - TextStrings_33 ; 118
	dw TextStrings_33.s227 - TextStrings_33 ; 119
	dw TextStrings_33.s229 - TextStrings_33 ; 120
	dw TextStrings_33.s231 - TextStrings_33 ; 121
	dw TextStrings_33.s233 - TextStrings_33 ; 122
	dw TextStrings_33.s235 - TextStrings_33 ; 123
	dw TextStrings_33.s237 - TextStrings_33 ; 124
	dw TextStrings_33.s239 - TextStrings_33 ; 125
	dw TextStrings_33.s241 - TextStrings_33 ; 126
	dw TextStrings_33.s243 - TextStrings_33 ; 127
	dw TextStrings_33.s245 - TextStrings_33 ; 128
	dw TextStrings_33.s247 - TextStrings_33 ; 129
	dw TextStrings_33.s249 - TextStrings_33 ; 130
	dw TextStrings_33.s250 - TextStrings_33 ; 131
	dw TextStrings_33.s252 - TextStrings_33 ; 132
	dw TextStrings_33.s254 - TextStrings_33 ; 133
	dw TextStrings_33.s256 - TextStrings_33 ; 134
	dw TextStrings_33.s257 - TextStrings_33 ; 135
	dw TextStrings_33.s259 - TextStrings_33 ; 136
	dw TextStrings_33.s261 - TextStrings_33 ; 137
	dw TextStrings_33.s263 - TextStrings_33 ; 138
	dw TextStrings_33.s265 - TextStrings_33 ; 139
	dw TextStrings_33.s267 - TextStrings_33 ; 140
	dw TextStrings_33.s269 - TextStrings_33 ; 141
	dw TextStrings_33.s271 - TextStrings_33 ; 142
	dw TextStrings_33.s273 - TextStrings_33 ; 143
	dw TextStrings_33.s275 - TextStrings_33 ; 144
	dw TextStrings_33.s277 - TextStrings_33 ; 145
	dw TextStrings_33.s279 - TextStrings_33 ; 146
	dw TextStrings_33.s281 - TextStrings_33 ; 147
	dw TextStrings_33.s283 - TextStrings_33 ; 148
	dw TextStrings_33.s285 - TextStrings_33 ; 149
	dw TextStrings_33.s287 - TextStrings_33 ; 150
	dw TextStrings_33.s289 - TextStrings_33 ; 151
	dw TextStrings_33.s291 - TextStrings_33 ; 152
	dw TextStrings_33.s293 - TextStrings_33 ; 153
	dw TextStrings_33.s295 - TextStrings_33 ; 154
	dw TextStrings_33.s297 - TextStrings_33 ; 155
	dw TextStrings_33.s299 - TextStrings_33 ; 156
	dw TextStrings_33.s301 - TextStrings_33 ; 157
	dw TextStrings_33.s303 - TextStrings_33 ; 158
	dw TextStrings_33.s305 - TextStrings_33 ; 159
	dw TextStrings_33.s307 - TextStrings_33 ; 160
	dw TextStrings_33.s309 - TextStrings_33 ; 161
	dw TextStrings_33.s311 - TextStrings_33 ; 162
	dw TextStrings_33.s313 - TextStrings_33 ; 163
	dw TextStrings_33.s315 - TextStrings_33 ; 164
	dw TextStrings_33.s317 - TextStrings_33 ; 165
	dw TextStrings_33.s319 - TextStrings_33 ; 166
	dw TextStrings_33.s321 - TextStrings_33 ; 167
	dw TextStrings_33.s323 - TextStrings_33 ; 168
	dw TextStrings_33.s324 - TextStrings_33 ; 169
	dw TextStrings_33.s326 - TextStrings_33 ; 170
	dw TextStrings_33.s328 - TextStrings_33 ; 171
	dw TextStrings_33.s330 - TextStrings_33 ; 172
	dw TextStrings_33.s332 - TextStrings_33 ; 173
	dw TextStrings_33.s334 - TextStrings_33 ; 174
	dw TextStrings_33.s336 - TextStrings_33 ; 175
	dw TextStrings_33.s338 - TextStrings_33 ; 176
	dw TextStrings_33.s340 - TextStrings_33 ; 177
	dw TextStrings_33.s342 - TextStrings_33 ; 178
	dw TextStrings_33.s344 - TextStrings_33 ; 179
	dw TextStrings_33.s346 - TextStrings_33 ; 180
	dw TextStrings_33.s348 - TextStrings_33 ; 181
	dw TextStrings_33.s350 - TextStrings_33 ; 182
	dw TextStrings_33.s352 - TextStrings_33 ; 183
	dw TextStrings_33.s354 - TextStrings_33 ; 184
	dw TextStrings_33.s355 - TextStrings_33 ; 185
	dw TextStrings_33.s357 - TextStrings_33 ; 186
	dw TextStrings_33.s359 - TextStrings_33 ; 187
	dw TextStrings_33.s361 - TextStrings_33 ; 188
	dw TextStrings_33.s363 - TextStrings_33 ; 189
	dw TextStrings_33.s365 - TextStrings_33 ; 190
	dw TextStrings_33.s367 - TextStrings_33 ; 191
	dw TextStrings_33.s369 - TextStrings_33 ; 192
	dw TextStrings_33.s371 - TextStrings_33 ; 193
	dw TextStrings_33.s373 - TextStrings_33 ; 194
	dw TextStrings_33.s375 - TextStrings_33 ; 195
	dw TextStrings_33.s377 - TextStrings_33 ; 196
	dw TextStrings_33.s379 - TextStrings_33 ; 197
	dw TextStrings_33.s381 - TextStrings_33 ; 198
	dw TextStrings_33.s383 - TextStrings_33 ; 199
	dw TextStrings_33.s385 - TextStrings_33 ; 200
	dw TextStrings_33.s387 - TextStrings_33 ; 201
	dw TextStrings_33.s389 - TextStrings_33 ; 202
	dw TextStrings_33.s391 - TextStrings_33 ; 203
	dw TextStrings_33.s393 - TextStrings_33 ; 204
	dw TextStrings_33.s395 - TextStrings_33 ; 205
	dw TextStrings_33.s397 - TextStrings_33 ; 206
	dw TextStrings_33.s399 - TextStrings_33 ; 207
	dw TextStrings_33.s401 - TextStrings_33 ; 208
	dw TextStrings_33.s402 - TextStrings_33 ; 209
	dw TextStrings_33.s404 - TextStrings_33 ; 210
	dw TextStrings_33.s406 - TextStrings_33 ; 211
	dw TextStrings_33.s408 - TextStrings_33 ; 212
	dw TextStrings_33.s410 - TextStrings_33 ; 213
	dw TextStrings_33.s412 - TextStrings_33 ; 214
	dw TextStrings_33.s414 - TextStrings_33 ; 215
	dw TextStrings_33.s416 - TextStrings_33 ; 216
	dw TextStrings_33.s418 - TextStrings_33 ; 217
	dw TextStrings_33.s420 - TextStrings_33 ; 218
	dw TextStrings_33.s422 - TextStrings_33 ; 219
	dw TextStrings_33.s423 - TextStrings_33 ; 220
TextStrings_33:
	INCLUDE "data/bank_033/TextStrings_33.asm" ; $41be, 14604 bytes (text_pool)
FetchDialogueText_33:
	push af ; $7aca
	ld a, $00 ; $7acb
	call FetchText_33 ; $7acd
	pop af ; $7ad0
	ret ; $7ad1
FetchShortText_33:
	push af ; $7ad2
	ld a, $01 ; $7ad3
	call FetchText_33 ; $7ad5
	pop af ; $7ad8
	ret ; $7ad9
; Instruction-identical to FetchText_1f, FetchText_25, FetchText_26, FetchText_30, FetchText_31, FetchText_32, FetchText_34, FetchText_35, FetchText_36, FetchText_37, FetchText_5e and FetchText_6e (one copy per bank); a change here belongs in every copy.
FetchText_33:
	push bc ; $7ada
	push de ; $7adb
	push hl ; $7adc
	ld hl, FetchTextTable_33 ; $7add
	sla e ; $7ae0
	rl d ; $7ae2
	add hl, de ; $7ae4
	ld e, [hl] ; $7ae5
	inc hl ; $7ae6
	ld d, [hl] ; $7ae7
	ld hl, TextStrings_33 ; $7ae8
	add hl, de ; $7aeb
	or a ; $7aec
	jr nz, .nonZero ; $7aed
	ld de, wTextBuffer ; $7aef
	ld c, $a0 ; $7af2
	jr .loop ; $7af4
.nonZero:
	ld de, wShortTextBuffer ; $7af6
	ld c, $10 ; $7af9
.loop:
	dec c ; $7afb
	jr z, .countDone ; $7afc
	ld a, [hl+] ; $7afe
	ld [de], a ; $7aff
	inc de ; $7b00
	or a ; $7b01
	jr nz, .loop ; $7b02
	pop hl ; $7b04
	pop de ; $7b05
	pop bc ; $7b06
	ret ; $7b07
.countDone:
	xor a ; $7b08
	ld [de], a ; $7b09
	ldh a, [hDebugStepMode] ; $7b0a
	or a ; $7b0c
	jr z, .restore ; $7b0d
	sound BGM_CREDITS ; $7b0f
.restore:
	pop hl ; $7b11
	pop de ; $7b12
	pop bc ; $7b13
	ret ; $7b14
	; $7b15, 1259 bytes fill to bank end (linker-padded)
