INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

DataPtr_TennisDictionaryTiles:
	dw TennisDictionaryTiles ; $4000
DataPtr_TennisDictionaryListTiles:
	dw TennisDictionaryListTiles ; $4002
DataPtr_3a_04:
	dw Lz_3a_53fb ; $4004
DataPtr_3a_06:
	dw Lz_3a_53fb ; $4006
DataPtr_3a_08:
	dw Lz_3a_53fb ; $4008
DataPtr_3a_0a:
	dw Lz_3a_53fb ; $400a
DataPtr_3a_0c:
	dw Lz_3a_53fb ; $400c
DataPtr_3a_0e:
	dw Lz_3a_53fb ; $400e
DataPtr_3a_10:
	dw Lz_3a_53fb ; $4010
DataPtr_3a_12:
	dw Lz_3a_53fb ; $4012
DataPtr_3a_14:
	dw Lz_3a_53fb ; $4014
DataPtr_3a_16:
	dw Lz_3a_5468 ; $4016
DataPtr_3a_18:
	dw Lz_3a_54d8 ; $4018
DataPtr_3a_1a:
	dw Lz_3a_5545 ; $401a
DataPtr_3a_1c:
	dw Lz_3a_53fb ; $401c
DataPtr_3a_1e:
	dw Lz_3a_53fb ; $401e
DataPtr_3a_20:
	dw Lz_3a_53fb ; $4020
DataPtr_3a_22:
	dw Lz_3a_53fb ; $4022
DataPtr_ExhibitionSetupTiles:
	dw ExhibitionSetupTiles ; $4024
DataPtr_ExhibitionSetupTilemap:
	dw ExhibitionSetupTilemap ; $4026
DataPtr_ExhibitionSetupAttrmap:
	dw ExhibitionSetupAttrmap ; $4028
DataPtr_ExhibitionSetupPalettes:
	dw ExhibitionSetupPalettes ; $402a
DataPtr_ExhibitionMenuTiles:
	dw ExhibitionMenuTiles ; $402c
DataPtr_ExhibitionMenuTilemap:
	dw ExhibitionMenuTilemap ; $402e
DataPtr_ExhibitionMenuAttrmap:
	dw ExhibitionMenuAttrmap ; $4030
DataPtr_ExhibitionMenuPalettes:
	dw ExhibitionMenuPalettes ; $4032
DataPtr_N64TournamentTiles:
	dw N64TournamentTiles ; $4034
DataPtr_N64TournamentTilemap:
	dw N64TournamentTilemap ; $4036
DataPtr_N64TournamentAttrmap:
	dw N64TournamentAttrmap ; $4038
DataPtr_N64TournamentPalettes:
	dw N64TournamentPalettes ; $403a
DataPtr_N64TournamentTilemap2:
	dw N64TournamentTilemap2 ; $403c
DataPtr_N64TournamentAttrmap2:
	dw N64TournamentAttrmap2 ; $403e
DataPtr_WarningScreenTiles:
	dw WarningScreenTiles ; $4040
DataPtr_WarningScreenTilemap:
	dw WarningScreenTilemap ; $4042
DataPtr_WarningScreenAttrmap:
	dw WarningScreenAttrmap ; $4044
DataPtr_WarningScreenPalettes:
	dw WarningScreenPalettes ; $4046
DataPtr_JapanesePlayModeTiles:
	dw JapanesePlayModeTiles ; $4048
DataPtr_JapanesePlayModeTilemap:
	dw JapanesePlayModeTilemap ; $404a
DataPtr_JapanesePlayModeAttrmap:
	dw JapanesePlayModeAttrmap ; $404c
DataPtr_JapanesePlayModePalettes:
	dw JapanesePlayModePalettes ; $404e
DataPtr_LinkErrorTiles:
	dw LinkErrorTiles ; $4050
DataPtr_LinkErrorTilemap:
	dw LinkErrorTilemap ; $4052
DataPtr_LinkErrorAttrmap:
	dw LinkErrorAttrmap ; $4054
DataPtr_LinkErrorPalettes:
	dw LinkErrorPalettes ; $4056
DataPtr_3a_58:
	dw Lz_3a_7dfa ; $4058
TennisDictionaryTiles:
	INCBIN "data/bank_03a/lz_405a.bin" ; $405a, 2621 bytes
TennisDictionaryListTiles:
	INCBIN "data/bank_03a/lz_4a97.bin" ; $4a97, 2404 bytes
Lz_3a_53fb:
	INCBIN "data/bank_03a/lz_53fb.bin" ; $53fb, 109 bytes
Lz_3a_5468:
	INCBIN "data/bank_03a/lz_5468.bin" ; $5468, 112 bytes
Lz_3a_54d8:
	INCBIN "data/bank_03a/lz_54d8.bin" ; $54d8, 109 bytes
Lz_3a_5545:
	INCBIN "data/bank_03a/lz_5545.bin" ; $5545, 106 bytes
ExhibitionSetupTiles:
	INCBIN "data/bank_03a/lz_55af.bin" ; $55af, 1138 bytes
ExhibitionSetupTilemap:
	INCBIN "data/bank_03a/lz_5a21.bin" ; $5a21, 217 bytes
ExhibitionSetupAttrmap:
	INCBIN "data/bank_03a/lz_5afa.bin" ; $5afa, 109 bytes
ExhibitionSetupPalettes:
	; $5b67, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $015f, $0000, $7fff ; pal 0: #b4b4b4 #ff5200 #000000 #ffffff
	dw $5906, $03bf, $0000, $7d08 ; pal 1: #3141b4 #ffee00 #000000 #4141ff
	dw $0004, $014a, $1100, $3324 ; pal 2: #200000 #525200 #004120 #20cd62
	dw $015f, $6bff, $1e40, $0000 ; pal 3: #ff5200 #ffffd5 #009439 #000000
	dw $015f, $6bff, $505c, $0000 ; pal 4: #ff5200 #ffffd5 #e610a4 #000000
	dw $015f, $6bff, $01df, $0000 ; pal 5: #ff5200 #ffffd5 #ff7300 #000000
	dw $015f, $6bff, $001f, $0000 ; pal 6: #ff5200 #ffffd5 #ff0000 #000000
	dw $015f, $6bff, $7d4a, $0000 ; pal 7: #ff5200 #ffffd5 #5252ff #000000
ExhibitionMenuTiles:
	INCBIN "data/bank_03a/lz_5ba7.bin" ; $5ba7, 1698 bytes
ExhibitionMenuTilemap:
	INCBIN "data/bank_03a/lz_6249.bin" ; $6249, 255 bytes
ExhibitionMenuAttrmap:
	INCBIN "data/bank_03a/lz_6348.bin" ; $6348, 119 bytes
ExhibitionMenuPalettes:
	; $63bf, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $7fff, $4e73, $02df, $0000 ; pal 2: #ffffff #9c9c9c #ffb400 #000000
	dw $7fff, $6bff, $1e40, $0000 ; pal 3: #ffffff #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $331f, $6bff, $01df, $0000 ; pal 5: #ffc562 #ffffd5 #ff7300 #000000
	dw $5a9f, $6bff, $001f, $0000 ; pal 6: #ffa4b4 #ffffd5 #ff0000 #000000
	dw $7fff, $6bff, $7d4a, $0000 ; pal 7: #ffffff #ffffd5 #5252ff #000000
N64TournamentTiles:
	INCBIN "data/bank_03a/lz_63ff.bin" ; $63ff, 1650 bytes
N64TournamentTilemap:
	INCBIN "data/bank_03a/lz_6a71.bin" ; $6a71, 268 bytes
N64TournamentAttrmap:
	INCBIN "data/bank_03a/lz_6b7d.bin" ; $6b7d, 121 bytes
N64TournamentPalettes:
	; $6bf6, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $7fff, $4e73, $02df, $0000 ; pal 2: #ffffff #9c9c9c #ffb400 #000000
	dw $01df, $6bff, $1e40, $0000 ; pal 3: #ff7300 #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $3f9f, $6bff, $01df, $0000 ; pal 5: #ffe67b #ffffd5 #ff7300 #000000
	dw $4a1f, $6bff, $001f, $0000 ; pal 6: #ff8394 #ffffd5 #ff0000 #000000
	dw $505c, $6bff, $7d4a, $0000 ; pal 7: #e610a4 #ffffd5 #5252ff #000000
N64TournamentTilemap2:
	INCBIN "data/bank_03a/lz_6c36.bin" ; $6c36, 268 bytes
N64TournamentAttrmap2:
	INCBIN "data/bank_03a/lz_6d42.bin" ; $6d42, 123 bytes
WarningScreenTiles:
	INCBIN "data/bank_03a/lz_6dbd.bin" ; $6dbd, 631 bytes
WarningScreenTilemap:
	INCBIN "data/bank_03a/lz_7034.bin" ; $7034, 149 bytes
WarningScreenAttrmap:
	INCBIN "data/bank_03a/lz_70c9.bin" ; $70c9, 107 bytes
WarningScreenPalettes:
	; $7134, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $280a, $280a, $280a, $280a ; pal 1: #520052 #520052 #520052 #520052
	dw $0004, $014a, $1100, $3324 ; pal 2: #200000 #525200 #004120 #20cd62
	dw $0300, $0240, $0180, $0100 ; pal 3: #00c500 #009400 #006200 #004100
	dw $0048, $3e13, $7fff, $01bf ; pal 4: #411000 #9c837b #ffffff #ff6a00
	dw $0000, $2940, $5280, $7fff ; pal 5: #000000 #005252 #00a4a4 #ffffff
	dw $0000, $0000, $0000, $0000 ; pal 6: #000000 #000000 #000000 #000000
	dw $001f, $00df, $01ff, $02bf ; pal 7: #ff0000 #ff3100 #ff7b00 #ffac00
JapanesePlayModeTiles:
	INCBIN "data/bank_03a/lz_7174.bin" ; $7174, 1067 bytes
JapanesePlayModeTilemap:
	INCBIN "data/bank_03a/lz_759f.bin" ; $759f, 166 bytes
JapanesePlayModeAttrmap:
	INCBIN "data/bank_03a/lz_7645.bin" ; $7645, 138 bytes
JapanesePlayModePalettes:
	; $76cf, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $280a, $280a, $280a, $280a ; pal 1: #520052 #520052 #520052 #520052
	dw $7fff, $2008, $42d0, $015f ; pal 2: #ffffff #410041 #83b483 #ff5200
	dw $0300, $0240, $0180, $0100 ; pal 3: #00c500 #009400 #006200 #004100
	dw $0000, $294a, $5294, $7fff ; pal 4: #000000 #525252 #a4a4a4 #ffffff
	dw $0000, $00c8, $00f2, $7fff ; pal 5: #000000 #413100 #943900 #ffffff
	dw $0000, $2940, $5280, $7fff ; pal 6: #000000 #005252 #00a4a4 #ffffff
	dw $0000, $05c0, $16a6, $77bf ; pal 7: #000000 #007308 #31ac29 #ffeeee
LinkErrorTiles:
	INCBIN "data/bank_03a/lz_770f.bin" ; $770f, 1376 bytes
LinkErrorTilemap:
	INCBIN "data/bank_03a/lz_7c6f.bin" ; $7c6f, 239 bytes
LinkErrorAttrmap:
	INCBIN "data/bank_03a/lz_7d5e.bin" ; $7d5e, 92 bytes
LinkErrorPalettes:
	; $7dba, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $4c80, $01bf, $0000, $7fff ; pal 0: #00209c #ff6a00 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $03ff, $01bf, $7c80, $7e00 ; pal 2: #ffff00 #ff6a00 #0020ff #0083ff
	dw $339f, $001f, $5007, $0000 ; pal 3: #ffe662 #ff0000 #3900a4 #000000
	dw $01bf, $125f, $22ff, $339f ; pal 4: #ff6a00 #ff9420 #ffbd41 #ffe662
	dw $01bf, $0bf3, $61df, $6cc0 ; pal 5: #ff6a00 #9cff10 #ff73c5 #0031de
	dw $7fff, $4300, $1e40, $01bf ; pal 6: #ffffff #00c583 #009439 #ff6a00
	dw $0000, $0000, $0000, $0000 ; pal 7: #000000 #000000 #000000 #000000
Lz_3a_7dfa:
	INCBIN "data/bank_03a/lz_7dfa.bin" ; $7dfa, 227 bytes
	ds 291, $ff ; $7edd, fill
