SECTION "ROM Bank $1f", ROMX[$4000], BANK[$1f]

	farptr FetchDialogueText_1f ; $4000
	farptr FetchShortText_1f ; $4002
FetchTextTable:
	; $4004, 378 bytes (text_offsets)
	dw TextStrings_1f.s0 - TextStrings_1f ; 0
	dw TextStrings_1f.s1 - TextStrings_1f ; 1
	dw TextStrings_1f.s2 - TextStrings_1f ; 2
	dw TextStrings_1f.s3 - TextStrings_1f ; 3
	dw TextStrings_1f.s5 - TextStrings_1f ; 4
	dw TextStrings_1f.s7 - TextStrings_1f ; 5
	dw TextStrings_1f.s9 - TextStrings_1f ; 6
	dw TextStrings_1f.s11 - TextStrings_1f ; 7
	dw TextStrings_1f.s13 - TextStrings_1f ; 8
	dw TextStrings_1f.s15 - TextStrings_1f ; 9
	dw TextStrings_1f.s17 - TextStrings_1f ; 10
	dw TextStrings_1f.s19 - TextStrings_1f ; 11
	dw TextStrings_1f.s21 - TextStrings_1f ; 12
	dw TextStrings_1f.s23 - TextStrings_1f ; 13
	dw TextStrings_1f.s25 - TextStrings_1f ; 14
	dw TextStrings_1f.s27 - TextStrings_1f ; 15
	dw TextStrings_1f.s29 - TextStrings_1f ; 16
	dw TextStrings_1f.s31 - TextStrings_1f ; 17
	dw TextStrings_1f.s33 - TextStrings_1f ; 18
	dw TextStrings_1f.s35 - TextStrings_1f ; 19
	dw TextStrings_1f.s37 - TextStrings_1f ; 20
	dw TextStrings_1f.s39 - TextStrings_1f ; 21
	dw TextStrings_1f.s41 - TextStrings_1f ; 22
	dw TextStrings_1f.s43 - TextStrings_1f ; 23
	dw TextStrings_1f.s45 - TextStrings_1f ; 24
	dw TextStrings_1f.s47 - TextStrings_1f ; 25
	dw TextStrings_1f.s49 - TextStrings_1f ; 26
	dw TextStrings_1f.s51 - TextStrings_1f ; 27
	dw TextStrings_1f.s53 - TextStrings_1f ; 28
	dw TextStrings_1f.s55 - TextStrings_1f ; 29
	dw TextStrings_1f.s57 - TextStrings_1f ; 30
	dw TextStrings_1f.s59 - TextStrings_1f ; 31
	dw TextStrings_1f.s61 - TextStrings_1f ; 32
	dw TextStrings_1f.s63 - TextStrings_1f ; 33
	dw TextStrings_1f.s65 - TextStrings_1f ; 34
	dw TextStrings_1f.s67 - TextStrings_1f ; 35
	dw TextStrings_1f.s69 - TextStrings_1f ; 36
	dw TextStrings_1f.s71 - TextStrings_1f ; 37
	dw TextStrings_1f.s73 - TextStrings_1f ; 38
	dw TextStrings_1f.s75 - TextStrings_1f ; 39
	dw TextStrings_1f.s77 - TextStrings_1f ; 40
	dw TextStrings_1f.s79 - TextStrings_1f ; 41
	dw TextStrings_1f.s81 - TextStrings_1f ; 42
	dw TextStrings_1f.s83 - TextStrings_1f ; 43
	dw TextStrings_1f.s85 - TextStrings_1f ; 44
	dw TextStrings_1f.s87 - TextStrings_1f ; 45
	dw TextStrings_1f.s89 - TextStrings_1f ; 46
	dw TextStrings_1f.s91 - TextStrings_1f ; 47
	dw TextStrings_1f.s93 - TextStrings_1f ; 48
	dw TextStrings_1f.s95 - TextStrings_1f ; 49
	dw TextStrings_1f.s97 - TextStrings_1f ; 50
	dw TextStrings_1f.s99 - TextStrings_1f ; 51
	dw TextStrings_1f.s101 - TextStrings_1f ; 52
	dw TextStrings_1f.s103 - TextStrings_1f ; 53
	dw TextStrings_1f.s105 - TextStrings_1f ; 54
	dw TextStrings_1f.s107 - TextStrings_1f ; 55
	dw TextStrings_1f.s109 - TextStrings_1f ; 56
	dw TextStrings_1f.s111 - TextStrings_1f ; 57
	dw TextStrings_1f.s113 - TextStrings_1f ; 58
	dw TextStrings_1f.s115 - TextStrings_1f ; 59
	dw TextStrings_1f.s117 - TextStrings_1f ; 60
	dw TextStrings_1f.s119 - TextStrings_1f ; 61
	dw TextStrings_1f.s121 - TextStrings_1f ; 62
	dw TextStrings_1f.s123 - TextStrings_1f ; 63
	dw TextStrings_1f.s125 - TextStrings_1f ; 64
	dw TextStrings_1f.s127 - TextStrings_1f ; 65
	dw TextStrings_1f.s129 - TextStrings_1f ; 66
	dw TextStrings_1f.s131 - TextStrings_1f ; 67
	dw TextStrings_1f.s133 - TextStrings_1f ; 68
	dw TextStrings_1f.s135 - TextStrings_1f ; 69
	dw TextStrings_1f.s137 - TextStrings_1f ; 70
	dw TextStrings_1f.s139 - TextStrings_1f ; 71
	dw TextStrings_1f.s141 - TextStrings_1f ; 72
	dw TextStrings_1f.s143 - TextStrings_1f ; 73
	dw TextStrings_1f.s145 - TextStrings_1f ; 74
	dw TextStrings_1f.s147 - TextStrings_1f ; 75
	dw TextStrings_1f.s149 - TextStrings_1f ; 76
	dw TextStrings_1f.s151 - TextStrings_1f ; 77
	dw TextStrings_1f.s153 - TextStrings_1f ; 78
	dw TextStrings_1f.s155 - TextStrings_1f ; 79
	dw TextStrings_1f.s157 - TextStrings_1f ; 80
	dw TextStrings_1f.s159 - TextStrings_1f ; 81
	dw TextStrings_1f.s160 - TextStrings_1f ; 82
	dw TextStrings_1f.s162 - TextStrings_1f ; 83
	dw TextStrings_1f.s164 - TextStrings_1f ; 84
	dw TextStrings_1f.s166 - TextStrings_1f ; 85
	dw TextStrings_1f.s168 - TextStrings_1f ; 86
	dw TextStrings_1f.s170 - TextStrings_1f ; 87
	dw TextStrings_1f.s172 - TextStrings_1f ; 88
	dw TextStrings_1f.s174 - TextStrings_1f ; 89
	dw TextStrings_1f.s176 - TextStrings_1f ; 90
	dw TextStrings_1f.s178 - TextStrings_1f ; 91
	dw TextStrings_1f.s180 - TextStrings_1f ; 92
	dw TextStrings_1f.s181 - TextStrings_1f ; 93
	dw TextStrings_1f.s183 - TextStrings_1f ; 94
	dw TextStrings_1f.s185 - TextStrings_1f ; 95
	dw TextStrings_1f.s187 - TextStrings_1f ; 96
	dw TextStrings_1f.s189 - TextStrings_1f ; 97
	dw TextStrings_1f.s191 - TextStrings_1f ; 98
	dw TextStrings_1f.s193 - TextStrings_1f ; 99
	dw TextStrings_1f.s195 - TextStrings_1f ; 100
	dw TextStrings_1f.s197 - TextStrings_1f ; 101
	dw TextStrings_1f.s199 - TextStrings_1f ; 102
	dw TextStrings_1f.s201 - TextStrings_1f ; 103
	dw TextStrings_1f.s203 - TextStrings_1f ; 104
	dw TextStrings_1f.s205 - TextStrings_1f ; 105
	dw TextStrings_1f.s207 - TextStrings_1f ; 106
	dw TextStrings_1f.s209 - TextStrings_1f ; 107
	dw TextStrings_1f.s211 - TextStrings_1f ; 108
	dw TextStrings_1f.s213 - TextStrings_1f ; 109
	dw TextStrings_1f.s215 - TextStrings_1f ; 110
	dw TextStrings_1f.s217 - TextStrings_1f ; 111
	dw TextStrings_1f.s219 - TextStrings_1f ; 112
	dw TextStrings_1f.s221 - TextStrings_1f ; 113
	dw TextStrings_1f.s223 - TextStrings_1f ; 114
	dw TextStrings_1f.s225 - TextStrings_1f ; 115
	dw TextStrings_1f.s227 - TextStrings_1f ; 116
	dw TextStrings_1f.s229 - TextStrings_1f ; 117
	dw TextStrings_1f.s231 - TextStrings_1f ; 118
	dw TextStrings_1f.s233 - TextStrings_1f ; 119
	dw TextStrings_1f.s235 - TextStrings_1f ; 120
	dw TextStrings_1f.s237 - TextStrings_1f ; 121
	dw TextStrings_1f.s239 - TextStrings_1f ; 122
	dw TextStrings_1f.s241 - TextStrings_1f ; 123
	dw TextStrings_1f.s243 - TextStrings_1f ; 124
	dw TextStrings_1f.s245 - TextStrings_1f ; 125
	dw TextStrings_1f.s247 - TextStrings_1f ; 126
	dw TextStrings_1f.s249 - TextStrings_1f ; 127
	dw TextStrings_1f.s251 - TextStrings_1f ; 128
	dw TextStrings_1f.s253 - TextStrings_1f ; 129
	dw TextStrings_1f.s255 - TextStrings_1f ; 130
	dw TextStrings_1f.s257 - TextStrings_1f ; 131
	dw TextStrings_1f.s259 - TextStrings_1f ; 132
	dw TextStrings_1f.s261 - TextStrings_1f ; 133
	dw TextStrings_1f.s263 - TextStrings_1f ; 134
	dw TextStrings_1f.s265 - TextStrings_1f ; 135
	dw TextStrings_1f.s267 - TextStrings_1f ; 136
	dw TextStrings_1f.s269 - TextStrings_1f ; 137
	dw TextStrings_1f.s271 - TextStrings_1f ; 138
	dw TextStrings_1f.s273 - TextStrings_1f ; 139
	dw TextStrings_1f.s275 - TextStrings_1f ; 140
	dw TextStrings_1f.s277 - TextStrings_1f ; 141
	dw TextStrings_1f.s279 - TextStrings_1f ; 142
	dw TextStrings_1f.s281 - TextStrings_1f ; 143
	dw TextStrings_1f.s283 - TextStrings_1f ; 144
	dw TextStrings_1f.s285 - TextStrings_1f ; 145
	dw TextStrings_1f.s287 - TextStrings_1f ; 146
	dw TextStrings_1f.s289 - TextStrings_1f ; 147
	dw TextStrings_1f.s291 - TextStrings_1f ; 148
	dw TextStrings_1f.s293 - TextStrings_1f ; 149
	dw TextStrings_1f.s295 - TextStrings_1f ; 150
	dw TextStrings_1f.s297 - TextStrings_1f ; 151
	dw TextStrings_1f.s299 - TextStrings_1f ; 152
	dw TextStrings_1f.s301 - TextStrings_1f ; 153
	dw TextStrings_1f.s303 - TextStrings_1f ; 154
	dw TextStrings_1f.s305 - TextStrings_1f ; 155
	dw TextStrings_1f.s307 - TextStrings_1f ; 156
	dw TextStrings_1f.s309 - TextStrings_1f ; 157
	dw TextStrings_1f.s311 - TextStrings_1f ; 158
	dw TextStrings_1f.s313 - TextStrings_1f ; 159
	dw TextStrings_1f.s315 - TextStrings_1f ; 160
	dw TextStrings_1f.s317 - TextStrings_1f ; 161
	dw TextStrings_1f.s319 - TextStrings_1f ; 162
	dw TextStrings_1f.s321 - TextStrings_1f ; 163
	dw TextStrings_1f.s322 - TextStrings_1f ; 164
	dw TextStrings_1f.s324 - TextStrings_1f ; 165
	dw TextStrings_1f.s326 - TextStrings_1f ; 166
	dw TextStrings_1f.s328 - TextStrings_1f ; 167
	dw TextStrings_1f.s330 - TextStrings_1f ; 168
	dw TextStrings_1f.s332 - TextStrings_1f ; 169
	dw TextStrings_1f.s334 - TextStrings_1f ; 170
	dw TextStrings_1f.s336 - TextStrings_1f ; 171
	dw TextStrings_1f.s338 - TextStrings_1f ; 172
	dw TextStrings_1f.s339 - TextStrings_1f ; 173
	dw TextStrings_1f.s341 - TextStrings_1f ; 174
	dw TextStrings_1f.s343 - TextStrings_1f ; 175
	dw TextStrings_1f.s345 - TextStrings_1f ; 176
	dw TextStrings_1f.s347 - TextStrings_1f ; 177
	dw TextStrings_1f.s349 - TextStrings_1f ; 178
	dw TextStrings_1f.s351 - TextStrings_1f ; 179
	dw TextStrings_1f.s353 - TextStrings_1f ; 180
	dw TextStrings_1f.s355 - TextStrings_1f ; 181
	dw TextStrings_1f.s357 - TextStrings_1f ; 182
	dw TextStrings_1f.s359 - TextStrings_1f ; 183
	dw TextStrings_1f.s361 - TextStrings_1f ; 184
	dw TextStrings_1f.s363 - TextStrings_1f ; 185
	dw TextStrings_1f.s365 - TextStrings_1f ; 186
	dw TextStrings_1f.s367 - TextStrings_1f ; 187
	dw TextStrings_1f.s369 - TextStrings_1f ; 188
TextStrings_1f:
	INCLUDE "data/bank_01f/text_pool_417e.asm" ; $417e, 14605 bytes (text_pool)
FetchDialogueText_1f:
	push af ; $7a8b
	ld a, $00 ; $7a8c
	call FetchText_1f ; $7a8e
	pop af ; $7a91
	ret ; $7a92
FetchShortText_1f:
	push af ; $7a93
	ld a, $01 ; $7a94
	call FetchText_1f ; $7a96
	pop af ; $7a99
	ret ; $7a9a
FetchText_1f:
	push bc ; $7a9b
	push de ; $7a9c
	push hl ; $7a9d
	ld hl, FetchTextTable ; $7a9e
	sla e ; $7aa1
	rl d ; $7aa3
	add hl, de ; $7aa5
	ld e, [hl] ; $7aa6
	inc hl ; $7aa7
	ld d, [hl] ; $7aa8
	ld hl, TextStrings_1f ; $7aa9
	add hl, de ; $7aac
	or a ; $7aad
	jr nz, .nonZero ; $7aae
	ld de, wTextBuffer ; $7ab0
	ld c, $a0 ; $7ab3
	jr .loop ; $7ab5
.nonZero:
	ld de, wShortTextBuffer ; $7ab7
	ld c, $10 ; $7aba
.loop:
	dec c ; $7abc
	jr z, .countDone ; $7abd
	ld a, [hl+] ; $7abf
	ld [de], a ; $7ac0
	inc de ; $7ac1
	or a ; $7ac2
	jr nz, .loop ; $7ac3
	pop hl ; $7ac5
	pop de ; $7ac6
	pop bc ; $7ac7
	ret ; $7ac8
.countDone:
	xor a ; $7ac9
	ld [de], a ; $7aca
	ldh a, [hDebugStepMode] ; $7acb
	or a ; $7acd
	jr z, .restore ; $7ace
	sound $2c ; $7ad0
.restore:
	pop hl ; $7ad2
	pop de ; $7ad3
	pop bc ; $7ad4
	ret ; $7ad5
	; $7ad6, 1322 bytes fill to bank end (linker-padded)
