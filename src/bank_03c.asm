SECTION "ROM Bank $3c", ROMX[$4000], BANK[$3c]

DataPtr_ModeSelectTiles:
	dw ModeSelectTiles ; $4000
DataPtr_ModeSelectTilemap:
	dw ModeSelectTilemap ; $4002
DataPtr_ModeSelectAttrmap:
	dw ModeSelectAttrmap ; $4004
DataPtr_ModeSelectPalettes:
	dw ModeSelectPalettes ; $4006
DataPtr_StadiumTiles:
	dw StadiumTiles ; $4008
DataPtr_StadiumTilemap:
	dw StadiumTilemap ; $400a
DataPtr_3c_0c:
	dw Lz_3c_52e6 ; $400c
DataPtr_3c_0e:
	dw Data_3c_5351 ; $400e
DataPtr_3c_10:
	dw Lz_3c_5391 ; $4010
DataPtr_3c_12:
	dw Lz_3c_53d8 ; $4012
DataPtr_3c_14:
	dw Lz_3c_54bc ; $4014
DataPtr_3c_16:
	dw Lz_3c_55b4 ; $4016
DataPtr_3c_18:
	dw Lz_3c_569f ; $4018
DataPtr_3c_1a:
	dw Lz_3c_5792 ; $401a
DataPtr_3c_1c:
	dw Lz_3c_5879 ; $401c
DataPtr_3c_1e:
	dw Lz_3c_5967 ; $401e
DataPtr_3c_20:
	dw Lz_3c_599a ; $4020
DataPtr_3c_22:
	dw Lz_3c_5aa6 ; $4022
DataPtr_3c_24:
	dw Lz_3c_5ac3 ; $4024
DataPtr_3c_26:
	dw Lz_3c_5b6c ; $4026
DataPtr_3c_28:
	dw Lz_3c_5c0b ; $4028
DataPtr_3c_2a:
	dw Lz_3c_5ccf ; $402a
DataPtr_3c_2c:
	dw Lz_3c_5d91 ; $402c
DataPtr_3c_2e:
	dw Lz_3c_5e39 ; $402e
DataPtr_3c_30:
	dw Lz_3c_5eff ; $4030
DataPtr_3c_32:
	dw Lz_3c_5fc2 ; $4032
DataPtr_3c_34:
	dw Lz_3c_606a ; $4034
DataPtr_3c_36:
	dw Lz_3c_6103 ; $4036
DataPtr_3c_38:
	dw Lz_3c_61a8 ; $4038
DataPtr_3c_3a:
	dw Lz_3c_624c ; $403a
DataPtr_3c_3c:
	dw Lz_3c_62d9 ; $403c
DataPtr_3c_3e:
	dw Lz_3c_638f ; $403e
DataPtr_3c_40:
	dw Lz_3c_6440 ; $4040
DataPtr_3c_42:
	dw Lz_3c_64cf ; $4042
DataPtr_3c_44:
	dw Lz_3c_656b ; $4044
DataPtr_3c_46:
	dw Lz_3c_6608 ; $4046
DataPtr_3c_48:
	dw Lz_3c_66b8 ; $4048
DataPtr_3c_4a:
	dw Lz_3c_6766 ; $404a
DataPtr_3c_4c:
	dw Lz_3c_6818 ; $404c
DataPtr_3c_4e:
	dw Lz_3c_68c8 ; $404e
DataPtr_3c_50:
	dw Lz_3c_6985 ; $4050
DataPtr_3c_52:
	dw Lz_3c_6a3a ; $4052
DataPtr_3c_54:
	dw Lz_3c_6ab6 ; $4054
DataPtr_3c_56:
	dw Lz_3c_6b40 ; $4056
DataPtr_3c_58:
	dw Lz_3c_6bc4 ; $4058
DataPtr_3c_5a:
	dw Lz_3c_6c51 ; $405a
DataPtr_3c_5c:
	dw Lz_3c_6ccd ; $405c
DataPtr_3c_5e:
	dw Lz_3c_6d5c ; $405e
DataPtr_3c_60:
	dw Lz_3c_6e0d ; $4060
DataPtr_3c_62:
	dw Lz_3c_6eb9 ; $4062
DataPtr_3c_64:
	dw Lz_3c_6f68 ; $4064
DataPtr_GamesLabelTiles:
	dw GamesLabelTiles ; $4066
DataPtr_GamesLabelTiles2:
	dw GamesLabelTiles2 ; $4068
DataPtr_OneSetLabelTiles:
	dw OneSetLabelTiles ; $406a
DataPtr_ThreeSetsLabelTiles:
	dw ThreeSetsLabelTiles ; $406c
DataPtr_FiveSetsLabelTiles:
	dw FiveSetsLabelTiles ; $406e
DataPtr_3c_70:
	dw Lz_3c_741b ; $4070
DataPtr_3c_72:
	dw Lz_3c_75e0 ; $4072
DataPtr_3c_74:
	dw Lz_3c_766c ; $4074
DataPtr_3c_76:
	dw Data_3c_76c5 ; $4076
DataPtr_3c_78:
	dw Lz_3c_7705 ; $4078
DataPtr_3c_7a:
	dw Lz_3c_77ec ; $407a
DataPtr_3c_7c:
	dw Lz_3c_78cf ; $407c
ModeSelectTiles:
	INCBIN "data/bank_03c/lz_407e.bin" ; $407e, 1283 bytes
ModeSelectTilemap:
	INCBIN "data/bank_03c/lz_4581.bin" ; $4581, 268 bytes
ModeSelectAttrmap:
	INCBIN "data/bank_03c/lz_468d.bin" ; $468d, 132 bytes
ModeSelectPalettes:
	; $4711, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $7fff, $4e73, $02df, $0000 ; pal 2: #ffffff #9c9c9c #ffb400 #000000
	dw $01df, $6bff, $1e40, $0000 ; pal 3: #ff7300 #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $3f9f, $6bff, $01df, $0000 ; pal 5: #ffe67b #ffffd5 #ff7300 #000000
	dw $4a1f, $6bff, $001f, $0000 ; pal 6: #ff8394 #ffffd5 #ff0000 #000000
	dw $505c, $6bff, $7d4a, $0000 ; pal 7: #e610a4 #ffffd5 #5252ff #000000
StadiumTiles:
	INCBIN "data/bank_03c/lz_4751.bin" ; $4751, 2465 bytes
StadiumTilemap:
	INCBIN "data/bank_03c/lz_50f2.bin" ; $50f2, 500 bytes
Lz_3c_52e6:
	INCBIN "data/bank_03c/lz_52e6.bin" ; $52e6, 107 bytes
Data_3c_5351:
	; $5351, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $015f, $0000, $7fff ; pal 0: #b4b4b4 #ff5200 #000000 #ffffff
	dw $7fff, $2fec, $1b47, $2289 ; pal 1: #ffffff #62ff5a #39d531 #4aa441
	dw $0004, $014a, $1100, $3324 ; pal 2: #200000 #525200 #004120 #20cd62
	dw $7fff, $6714, $3206, $7f00 ; pal 3: #ffffff #a4c5cd #318362 #00c5ff
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $5294, $7fff, $294a, $0000 ; pal 5: #a4a4a4 #ffffff #525252 #000000
	dw $5a9f, $6bff, $001f, $0000 ; pal 6: #ffa4b4 #ffffd5 #ff0000 #000000
	dw $3acc, $6bff, $7d4a, $0000 ; pal 7: #62b473 #ffffd5 #5252ff #000000
Lz_3c_5391:
	INCBIN "data/bank_03c/lz_5391.bin" ; $5391, 71 bytes
Lz_3c_53d8:
	INCBIN "data/bank_03c/lz_53d8.bin" ; $53d8, 228 bytes
Lz_3c_54bc:
	INCBIN "data/bank_03c/lz_54bc.bin" ; $54bc, 248 bytes
Lz_3c_55b4:
	INCBIN "data/bank_03c/lz_55b4.bin" ; $55b4, 235 bytes
Lz_3c_569f:
	INCBIN "data/bank_03c/lz_569f.bin" ; $569f, 243 bytes
Lz_3c_5792:
	INCBIN "data/bank_03c/lz_5792.bin" ; $5792, 231 bytes
Lz_3c_5879:
	INCBIN "data/bank_03c/lz_5879.bin" ; $5879, 238 bytes
Lz_3c_5967:
	INCBIN "data/bank_03c/lz_5967.bin" ; $5967, 51 bytes
Lz_3c_599a:
	INCBIN "data/bank_03c/lz_599a.bin" ; $599a, 268 bytes
Lz_3c_5aa6:
	INCBIN "data/bank_03c/lz_5aa6.bin" ; $5aa6, 29 bytes
Lz_3c_5ac3:
	INCBIN "data/bank_03c/lz_5ac3.bin" ; $5ac3, 169 bytes
Lz_3c_5b6c:
	INCBIN "data/bank_03c/lz_5b6c.bin" ; $5b6c, 159 bytes
Lz_3c_5c0b:
	INCBIN "data/bank_03c/lz_5c0b.bin" ; $5c0b, 196 bytes
Lz_3c_5ccf:
	INCBIN "data/bank_03c/lz_5ccf.bin" ; $5ccf, 194 bytes
Lz_3c_5d91:
	INCBIN "data/bank_03c/lz_5d91.bin" ; $5d91, 168 bytes
Lz_3c_5e39:
	INCBIN "data/bank_03c/lz_5e39.bin" ; $5e39, 198 bytes
Lz_3c_5eff:
	INCBIN "data/bank_03c/lz_5eff.bin" ; $5eff, 195 bytes
Lz_3c_5fc2:
	INCBIN "data/bank_03c/lz_5fc2.bin" ; $5fc2, 168 bytes
Lz_3c_606a:
	INCBIN "data/bank_03c/lz_606a.bin" ; $606a, 153 bytes
Lz_3c_6103:
	INCBIN "data/bank_03c/lz_6103.bin" ; $6103, 165 bytes
Lz_3c_61a8:
	INCBIN "data/bank_03c/lz_61a8.bin" ; $61a8, 164 bytes
Lz_3c_624c:
	INCBIN "data/bank_03c/lz_624c.bin" ; $624c, 141 bytes
Lz_3c_62d9:
	INCBIN "data/bank_03c/lz_62d9.bin" ; $62d9, 182 bytes
Lz_3c_638f:
	INCBIN "data/bank_03c/lz_638f.bin" ; $638f, 177 bytes
Lz_3c_6440:
	INCBIN "data/bank_03c/lz_6440.bin" ; $6440, 143 bytes
Lz_3c_64cf:
	INCBIN "data/bank_03c/lz_64cf.bin" ; $64cf, 156 bytes
Lz_3c_656b:
	INCBIN "data/bank_03c/lz_656b.bin" ; $656b, 157 bytes
Lz_3c_6608:
	INCBIN "data/bank_03c/lz_6608.bin" ; $6608, 176 bytes
Lz_3c_66b8:
	INCBIN "data/bank_03c/lz_66b8.bin" ; $66b8, 174 bytes
Lz_3c_6766:
	INCBIN "data/bank_03c/lz_6766.bin" ; $6766, 178 bytes
Lz_3c_6818:
	INCBIN "data/bank_03c/lz_6818.bin" ; $6818, 176 bytes
Lz_3c_68c8:
	INCBIN "data/bank_03c/lz_68c8.bin" ; $68c8, 189 bytes
Lz_3c_6985:
	INCBIN "data/bank_03c/lz_6985.bin" ; $6985, 181 bytes
Lz_3c_6a3a:
	INCBIN "data/bank_03c/lz_6a3a.bin" ; $6a3a, 124 bytes
Lz_3c_6ab6:
	INCBIN "data/bank_03c/lz_6ab6.bin" ; $6ab6, 138 bytes
Lz_3c_6b40:
	INCBIN "data/bank_03c/lz_6b40.bin" ; $6b40, 132 bytes
Lz_3c_6bc4:
	INCBIN "data/bank_03c/lz_6bc4.bin" ; $6bc4, 141 bytes
Lz_3c_6c51:
	INCBIN "data/bank_03c/lz_6c51.bin" ; $6c51, 124 bytes
Lz_3c_6ccd:
	INCBIN "data/bank_03c/lz_6ccd.bin" ; $6ccd, 143 bytes
Lz_3c_6d5c:
	INCBIN "data/bank_03c/lz_6d5c.bin" ; $6d5c, 177 bytes
Lz_3c_6e0d:
	INCBIN "data/bank_03c/lz_6e0d.bin" ; $6e0d, 172 bytes
Lz_3c_6eb9:
	INCBIN "data/bank_03c/lz_6eb9.bin" ; $6eb9, 175 bytes
Lz_3c_6f68:
	INCBIN "data/bank_03c/lz_6f68.bin" ; $6f68, 233 bytes
GamesLabelTiles:
	INCBIN "data/bank_03c/lz_7051.bin" ; $7051, 178 bytes
GamesLabelTiles2:
	INCBIN "data/bank_03c/lz_7103.bin" ; $7103, 170 bytes
OneSetLabelTiles:
	INCBIN "data/bank_03c/lz_71ad.bin" ; $71ad, 189 bytes
ThreeSetsLabelTiles:
	INCBIN "data/bank_03c/lz_726a.bin" ; $726a, 218 bytes
FiveSetsLabelTiles:
	INCBIN "data/bank_03c/lz_7344.bin" ; $7344, 215 bytes
Lz_3c_741b:
	INCBIN "data/bank_03c/lz_741b.bin" ; $741b, 453 bytes
Lz_3c_75e0:
	INCBIN "data/bank_03c/lz_75e0.bin" ; $75e0, 140 bytes
Lz_3c_766c:
	INCBIN "data/bank_03c/lz_766c.bin" ; $766c, 89 bytes
Data_3c_76c5:
	; $76c5, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $015f, $0000, $7fff ; pal 0: #b4b4b4 #ff5200 #000000 #ffffff
	dw $280a, $280a, $280a, $280a ; pal 1: #520052 #520052 #520052 #520052
	dw $0004, $014a, $1100, $3324 ; pal 2: #200000 #525200 #004120 #20cd62
	dw $0300, $0240, $0180, $0100 ; pal 3: #00c500 #009400 #006200 #004100
	dw $7bde, $6318, $4a52, $318c ; pal 4: #f6f6f6 #c5c5c5 #949494 #626262
	dw $7bde, $6318, $4a52, $318c ; pal 5: #f6f6f6 #c5c5c5 #949494 #626262
	dw $7bde, $6318, $4a52, $318c ; pal 6: #f6f6f6 #c5c5c5 #949494 #626262
	dw $7bde, $6318, $4a52, $318c ; pal 7: #f6f6f6 #c5c5c5 #949494 #626262
Lz_3c_7705:
	INCBIN "data/bank_03c/lz_7705.bin" ; $7705, 231 bytes
Lz_3c_77ec:
	INCBIN "data/bank_03c/lz_77ec.bin" ; $77ec, 227 bytes
Lz_3c_78cf:
	INCBIN "data/bank_03c/lz_78cf.bin" ; $78cf, 253 bytes
	ds 1588, $ff ; $79cc, fill
