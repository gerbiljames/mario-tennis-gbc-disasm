SECTION "ROM Bank $6c", ROMX[$4000], BANK[$6c]

DataPtr_CompanyLogosTiles:
	dw CompanyLogosTiles ; $4000
DataPtr_CompanyLogosTilemap:
	dw CompanyLogosTilemap ; $4002
DataPtr_CompanyLogosAttrmap:
	dw CompanyLogosAttrmap ; $4004
DataPtr_CompanyLogosPalettes:
	dw CompanyLogosPalettes ; $4006
DataPtr_IntroRalliesTiles:
	dw IntroRalliesTiles ; $4008
DataPtr_IntroRalliesTilemap:
	dw IntroRalliesTilemap ; $400a
DataPtr_IntroRalliesAttrmap:
	dw IntroRalliesAttrmap ; $400c
DataPtr_IntroRalliesTilemap2:
	dw IntroRalliesTilemap2 ; $400e
DataPtr_IntroRalliesAttrmap2:
	dw IntroRalliesAttrmap2 ; $4010
DataPtr_IntroRalliesTilemap3:
	dw IntroRalliesTilemap3 ; $4012
DataPtr_IntroRalliesAttrmap3:
	dw IntroRalliesAttrmap3 ; $4014
DataPtr_IntroRalliesTilemap4:
	dw IntroRalliesTilemap4 ; $4016
DataPtr_IntroRalliesAttrmap4:
	dw IntroRalliesAttrmap4 ; $4018
DataPtr_IntroRalliesPalettes:
	dw IntroRalliesPalettes ; $401a
DataPtr_6c_1c:
	dw Lz_6c_5424 ; $401c
DataPtr_6c_1e:
	dw Lz_6c_5451 ; $401e
DataPtr_6c_20:
	dw Lz_6c_54e8 ; $4020
DataPtr_6c_22:
	dw Lz_6c_55c6 ; $4022
DataPtr_6c_24:
	dw Lz_6c_55f6 ; $4024
DataPtr_6c_26:
	dw Lz_6c_56f9 ; $4026
DataPtr_6c_28:
	dw Lz_6c_57e1 ; $4028
DataPtr_IntroSwingTiles:
	dw IntroSwingTiles ; $402a
DataPtr_IntroSwingTilemap:
	dw IntroSwingTilemap ; $402c
DataPtr_IntroSwingAttrmap:
	dw IntroSwingAttrmap ; $402e
DataPtr_IntroSwingPalettes:
	dw IntroSwingPalettes ; $4030
DataPtr_IntroCloseupTiles:
	dw IntroCloseupTiles ; $4032
DataPtr_IntroCloseupTilemap:
	dw IntroCloseupTilemap ; $4034
DataPtr_IntroCloseupAttrmap:
	dw IntroCloseupAttrmap ; $4036
DataPtr_IntroCloseupPalettes:
	dw IntroCloseupPalettes ; $4038
DataPtr_IntroWaveTiles:
	dw IntroWaveTiles ; $403a
DataPtr_IntroWaveTilemap:
	dw IntroWaveTilemap ; $403c
DataPtr_IntroWaveAttrmap:
	dw IntroWaveAttrmap ; $403e
DataPtr_IntroWavePalettes:
	dw IntroWavePalettes ; $4040
DataPtr_IntroDiveTiles:
	dw IntroDiveTiles ; $4042
DataPtr_IntroDiveTilemap:
	dw IntroDiveTilemap ; $4044
DataPtr_IntroDiveAttrmap:
	dw IntroDiveAttrmap ; $4046
DataPtr_IntroDivePalettes:
	dw IntroDivePalettes ; $4048
DataPtr_IntroGirlSwingTiles:
	dw IntroGirlSwingTiles ; $404a
DataPtr_IntroGirlSwingTilemap:
	dw IntroGirlSwingTilemap ; $404c
DataPtr_IntroGirlSwingAttrmap:
	dw IntroGirlSwingAttrmap ; $404e
DataPtr_IntroGirlSwingPalettes:
	dw IntroGirlSwingPalettes ; $4050
DataPtr_6c_52:
	dw Lz_6c_74db ; $4052
DataPtr_6c_54:
	dw Lz_6c_75a7 ; $4054
DataPtr_6c_56:
	dw Lz_6c_7678 ; $4056
DataPtr_6c_58:
	dw Lz_6c_7744 ; $4058
DataPtr_6c_5a:
	dw Lz_6c_7808 ; $405a
DataPtr_6c_5c:
	dw Lz_6c_7836 ; $405c
DataPtr_6c_5e:
	dw Lz_6c_786d ; $405e
DataPtr_ChampionMedalTilemap5:
	dw ChampionMedalTilemap5 ; $4060
DataPtr_ChampionMedalAttrmap5:
	dw ChampionMedalAttrmap5 ; $4062
DataPtr_ChampionMedalTilemap6:
	dw ChampionMedalTilemap6 ; $4064
DataPtr_ChampionMedalAttrmap6:
	dw ChampionMedalAttrmap6 ; $4066
DataPtr_AwardCeremonyTilemap6:
	dw AwardCeremonyTilemap6 ; $4068
DataPtr_AwardCeremonyAttrmap6:
	dw AwardCeremonyAttrmap6 ; $406a
CompanyLogosTiles:
	INCBIN "data/bank_06c/lz_406c.bin" ; $406c, 1804 bytes
CompanyLogosTilemap:
	INCBIN "data/bank_06c/lz_4778.bin" ; $4778, 311 bytes
CompanyLogosAttrmap:
	INCBIN "data/bank_06c/lz_48af.bin" ; $48af, 87 bytes
CompanyLogosPalettes:
	; $4906, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0000, $294a, $5294, $7fff ; pal 0: #000000 #525252 #a4a4a4 #ffffff
	dw $0000, $7fff, $396b, $62f6 ; pal 1: #000000 #ffffff #5a5a73 #b4bdc5
	dw $0000, $7fff, $354a, $035e ; pal 2: #000000 #ffffff #52526a #f6d500
	dw $0000, $0000, $0000, $0000 ; pal 3: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 4: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 5: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 6: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 7: #000000 #000000 #000000 #000000
IntroRalliesTiles:
	INCBIN "data/bank_06c/lz_4946.bin" ; $4946, 1813 bytes
IntroRalliesTilemap:
	INCBIN "data/bank_06c/lz_505b.bin" ; $505b, 92 bytes
IntroRalliesAttrmap:
	INCBIN "data/bank_06c/lz_50b7.bin" ; $50b7, 72 bytes
IntroRalliesTilemap2:
	INCBIN "data/bank_06c/lz_50ff.bin" ; $50ff, 92 bytes
IntroRalliesAttrmap2:
	INCBIN "data/bank_06c/lz_515b.bin" ; $515b, 75 bytes
IntroRalliesTilemap3:
	INCBIN "data/bank_06c/lz_51a6.bin" ; $51a6, 110 bytes
IntroRalliesAttrmap3:
	INCBIN "data/bank_06c/lz_5214.bin" ; $5214, 73 bytes
IntroRalliesTilemap4:
	INCBIN "data/bank_06c/lz_525d.bin" ; $525d, 321 bytes
IntroRalliesAttrmap4:
	INCBIN "data/bank_06c/lz_539e.bin" ; $539e, 70 bytes
IntroRalliesPalettes:
	; $53e4, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $18c6, $294a, $294a, $294a ; pal 0: #313131 #525252 #525252 #525252
	dw $7e08, $7d84, $6940, $5100 ; pal 1: #4183ff #2062ff #0052d5 #0041a4
	dw $7fff, $4252, $214a, $0000 ; pal 2: #ffffff #949483 #525241 #000000
	dw $294a, $294a, $294a, $294a ; pal 3: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 4: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 5: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
Lz_6c_5424:
	INCBIN "data/bank_06c/lz_5424.bin" ; $5424, 45 bytes
Lz_6c_5451:
	INCBIN "data/bank_06c/lz_5451.bin" ; $5451, 151 bytes
Lz_6c_54e8:
	INCBIN "data/bank_06c/lz_54e8.bin" ; $54e8, 222 bytes
Lz_6c_55c6:
	INCBIN "data/bank_06c/lz_55c6.bin" ; $55c6, 48 bytes
Lz_6c_55f6:
	INCBIN "data/bank_06c/lz_55f6.bin" ; $55f6, 259 bytes
Lz_6c_56f9:
	INCBIN "data/bank_06c/lz_56f9.bin" ; $56f9, 232 bytes
Lz_6c_57e1:
	INCBIN "data/bank_06c/lz_57e1.bin" ; $57e1, 16 bytes
IntroSwingTiles:
	INCBIN "data/bank_06c/lz_57f1.bin" ; $57f1, 1085 bytes
IntroSwingTilemap:
	INCBIN "data/bank_06c/lz_5c2e.bin" ; $5c2e, 225 bytes
IntroSwingAttrmap:
	INCBIN "data/bank_06c/lz_5d0f.bin" ; $5d0f, 70 bytes
IntroSwingPalettes:
	; $5d55, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2108, $294a, $294a, $294a ; pal 0: #414141 #525252 #525252 #525252
	dw $3a96, $73ff, $115f, $0000 ; pal 1: #b4a473 #ffffe6 #ff5220 #000000
	dw $294a, $294a, $294a, $0000 ; pal 2: #525252 #525252 #525252 #000000
	dw $294a, $294a, $294a, $294a ; pal 3: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 4: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 5: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
IntroCloseupTiles:
	INCBIN "data/bank_06c/lz_5d95.bin" ; $5d95, 1061 bytes
IntroCloseupTilemap:
	INCBIN "data/bank_06c/lz_61ba.bin" ; $61ba, 170 bytes
IntroCloseupAttrmap:
	INCBIN "data/bank_06c/lz_6264.bin" ; $6264, 74 bytes
IntroCloseupPalettes:
	; $62ae, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $0000 ; pal 2: #525252 #525252 #525252 #000000
	dw $1adc, $73ff, $1e40, $0000 ; pal 3: #e6b431 #ffffe6 #009439 #000000
	dw $225f, $73ff, $505c, $0000 ; pal 4: #ff9441 #ffffe6 #e610a4 #000000
	dw $42dc, $73ff, $021f, $0000 ; pal 5: #e6b483 #ffffe6 #ff8300 #000000
	dw $5a9f, $73ff, $001f, $0000 ; pal 6: #ffa4b4 #ffffe6 #ff0000 #000000
	dw $3acc, $73ff, $7d4a, $0000 ; pal 7: #62b473 #ffffe6 #5252ff #000000
IntroWaveTiles:
	INCBIN "data/bank_06c/lz_62ee.bin" ; $62ee, 1266 bytes
IntroWaveTilemap:
	INCBIN "data/bank_06c/lz_67e0.bin" ; $67e0, 226 bytes
IntroWaveAttrmap:
	INCBIN "data/bank_06c/lz_68c2.bin" ; $68c2, 72 bytes
IntroWavePalettes:
	; $690a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $1adc, $73ff, $1e40, $0000 ; pal 3: #e6b431 #ffffe6 #009439 #000000
	dw $225f, $73ff, $505c, $0000 ; pal 4: #ff9441 #ffffe6 #e610a4 #000000
	dw $4b5a, $73ff, $01df, $0000 ; pal 5: #d5d594 #ffffe6 #ff7300 #000000
	dw $5a9f, $73ff, $001f, $0000 ; pal 6: #ffa4b4 #ffffe6 #ff0000 #000000
	dw $3acc, $73ff, $7d4a, $0000 ; pal 7: #62b473 #ffffe6 #5252ff #000000
IntroDiveTiles:
	INCBIN "data/bank_06c/lz_694a.bin" ; $694a, 1188 bytes
IntroDiveTilemap:
	INCBIN "data/bank_06c/lz_6dee.bin" ; $6dee, 189 bytes
IntroDiveAttrmap:
	INCBIN "data/bank_06c/lz_6eab.bin" ; $6eab, 72 bytes
IntroDivePalettes:
	; $6ef3, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $1adc, $73ff, $1e40, $0000 ; pal 3: #e6b431 #ffffe6 #009439 #000000
	dw $42dd, $73ff, $505f, $0000 ; pal 4: #eeb483 #ffffe6 #ff10a4 #000000
	dw $331f, $73ff, $01df, $0000 ; pal 5: #ffc562 #ffffe6 #ff7300 #000000
	dw $5a9f, $73ff, $001f, $0000 ; pal 6: #ffa4b4 #ffffe6 #ff0000 #000000
	dw $3acc, $73ff, $7d4a, $0000 ; pal 7: #62b473 #ffffe6 #5252ff #000000
IntroGirlSwingTiles:
	INCBIN "data/bank_06c/lz_6f33.bin" ; $6f33, 1131 bytes
IntroGirlSwingTilemap:
	INCBIN "data/bank_06c/lz_739e.bin" ; $739e, 181 bytes
IntroGirlSwingAttrmap:
	INCBIN "data/bank_06c/lz_7453.bin" ; $7453, 72 bytes
IntroGirlSwingPalettes:
	; $749b, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $2928, $7fff, $3e4d, $0000 ; pal 0: #414a52 #ffffff #6a947b #000000
	dw $294a, $294a, $294a, $294a ; pal 1: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 2: #525252 #525252 #525252 #525252
	dw $1adc, $73ff, $1e40, $0000 ; pal 3: #e6b431 #ffffe6 #009439 #000000
	dw $225f, $73ff, $505c, $0000 ; pal 4: #ff9441 #ffffe6 #e610a4 #000000
	dw $5ade, $73ff, $219f, $0000 ; pal 5: #f6b4b4 #ffffe6 #ff6241 #000000
	dw $5a9f, $73ff, $001f, $0000 ; pal 6: #ffa4b4 #ffffe6 #ff0000 #000000
	dw $3acc, $73ff, $7d4a, $0000 ; pal 7: #62b473 #ffffe6 #5252ff #000000
Lz_6c_74db:
	INCBIN "data/bank_06c/lz_74db.bin" ; $74db, 204 bytes
Lz_6c_75a7:
	INCBIN "data/bank_06c/lz_75a7.bin" ; $75a7, 209 bytes
Lz_6c_7678:
	INCBIN "data/bank_06c/lz_7678.bin" ; $7678, 204 bytes
Lz_6c_7744:
	INCBIN "data/bank_06c/lz_7744.bin" ; $7744, 196 bytes
Lz_6c_7808:
	INCBIN "data/bank_06c/lz_7808.bin" ; $7808, 46 bytes
Lz_6c_7836:
	INCBIN "data/bank_06c/lz_7836.bin" ; $7836, 55 bytes
Lz_6c_786d:
	INCBIN "data/bank_06c/lz_786d.bin" ; $786d, 39 bytes
ChampionMedalTilemap5:
	INCBIN "data/bank_06c/lz_7894.bin" ; $7894, 265 bytes
ChampionMedalAttrmap5:
	INCBIN "data/bank_06c/lz_799d.bin" ; $799d, 121 bytes
ChampionMedalTilemap6:
	INCBIN "data/bank_06c/lz_7a16.bin" ; $7a16, 265 bytes
ChampionMedalAttrmap6:
	INCBIN "data/bank_06c/lz_7b1f.bin" ; $7b1f, 115 bytes
AwardCeremonyTilemap6:
	INCBIN "data/bank_06c/lz_7b92.bin" ; $7b92, 278 bytes
AwardCeremonyAttrmap6:
	INCBIN "data/bank_06c/lz_7ca8.bin" ; $7ca8, 118 bytes
	; $7d1e, 738 bytes fill to bank end (linker-padded)
