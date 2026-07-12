INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6d", ROMX[$4000], BANK[$6d]

DataPtr_6d_00:
	dw Lz_6d_4094 ; $4000
DataPtr_6d_02:
	dw Lz_6d_4148 ; $4002
DataPtr_6d_04:
	dw Lz_6d_4215 ; $4004
DataPtr_6d_06:
	dw Lz_6d_42e3 ; $4006
DataPtr_6d_08:
	dw Lz_6d_43c8 ; $4008
DataPtr_6d_0a:
	dw Lz_6d_44a8 ; $400a
DataPtr_6d_0c:
	dw Lz_6d_4581 ; $400c
DataPtr_6d_0e:
	dw Lz_6d_4656 ; $400e
DataPtr_IntroAwesomeTiles:
	dw IntroAwesomeTiles ; $4010
DataPtr_IntroGreatestPlayerTiles:
	dw IntroGreatestPlayerTiles ; $4012
DataPtr_IntroGreatestPlayerTilemap:
	dw IntroGreatestPlayerTilemap ; $4014
DataPtr_IntroGreatestPlayerAttrmap:
	dw IntroGreatestPlayerAttrmap ; $4016
DataPtr_IntroGreatestPlayerPalettes:
	dw IntroGreatestPlayerPalettes ; $4018
DataPtr_IntroCharactersTiles:
	dw IntroCharactersTiles ; $401a
DataPtr_IntroCharactersTilemap:
	dw IntroCharactersTilemap ; $401c
DataPtr_6d_1e:
	dw Lz_6d_6061 ; $401e
DataPtr_6d_20:
	dw Data_6d_6104 ; $4020
DataPtr_IntroCharactersTilemap2:
	dw IntroCharactersTilemap2 ; $4022
DataPtr_6d_24:
	dw Lz_6d_6250 ; $4024
DataPtr_6d_26:
	dw Data_6d_6a7f ; $4026
DataPtr_6d_28:
	dw Lz_6d_6ac8 ; $4028
DataPtr_6d_2a:
	dw Lz_6d_6ac8 ; $402a
DataPtr_6d_2c:
	dw Lz_6d_6ac8 ; $402c
DataPtr_6d_2e:
	dw Lz_6d_6ac8 ; $402e
DataPtr_TitleScreenTiles:
	dw TitleScreenTiles ; $4030
DataPtr_6d_32:
	dw Lz_6d_6ac8 ; $4032
DataPtr_6d_34:
	dw Lz_6d_6b13 ; $4034
DataPtr_6d_36:
	dw Lz_6d_6b5b ; $4036
DataPtr_6d_38:
	dw Lz_6d_6ba2 ; $4038
DataPtr_6d_3a:
	dw Lz_6d_6be5 ; $403a
DataPtr_6d_3c:
	dw Lz_6d_6c26 ; $403c
DataPtr_6d_3e:
	dw Lz_6d_6c69 ; $403e
DataPtr_6d_40:
	dw Lz_6d_6cb0 ; $4040
DataPtr_6d_42:
	dw Lz_6d_6cf8 ; $4042
DataPtr_6d_44:
	dw Lz_6d_6d41 ; $4044
DataPtr_6d_46:
	dw Lz_6d_6d89 ; $4046
DataPtr_6d_48:
	dw Lz_6d_6dd1 ; $4048
DataPtr_6d_4a:
	dw Lz_6d_6e16 ; $404a
DataPtr_6d_4c:
	dw Lz_6d_6e59 ; $404c
DataPtr_6d_4e:
	dw Lz_6d_6e9e ; $404e
DataPtr_6d_50:
	dw Lz_6d_6ee6 ; $4050
DataPtr_6d_52:
	dw Lz_6d_6f2e ; $4052
DataPtr_6d_54:
	dw Lz_6d_6f2e ; $4054
DataPtr_6d_56:
	dw Lz_6d_6f2e ; $4056
DataPtr_6d_58:
	dw Lz_6d_6f2e ; $4058
DataPtr_6d_5a:
	dw Lz_6d_6f2e ; $405a
DataPtr_6d_5c:
	dw Lz_6d_6f2e ; $405c
DataPtr_6d_5e:
	dw Lz_6d_6f2e ; $405e
DataPtr_6d_60:
	dw Lz_6d_6f2e ; $4060
DataPtr_6d_62:
	dw Lz_6d_6f2e ; $4062
DataPtr_6d_64:
	dw Lz_6d_6f2e ; $4064
DataPtr_6d_66:
	dw Lz_6d_6f2e ; $4066
DataPtr_6d_68:
	dw Lz_6d_6f2e ; $4068
DataPtr_6d_6a:
	dw Lz_6d_6f2e ; $406a
DataPtr_6d_6c:
	dw Lz_6d_6f2e ; $406c
DataPtr_6d_6e:
	dw Lz_6d_6f2e ; $406e
DataPtr_6d_70:
	dw Lz_6d_6f2e ; $4070
DataPtr_6d_72:
	dw Lz_6d_6f2e ; $4072
DataPtr_6d_74:
	dw Lz_6d_6fd3 ; $4074
DataPtr_6d_76:
	dw Lz_6d_7087 ; $4076
DataPtr_6d_78:
	dw Lz_6d_7132 ; $4078
DataPtr_6d_7a:
	dw Lz_6d_71e0 ; $407a
DataPtr_6d_7c:
	dw Lz_6d_728f ; $407c
DataPtr_6d_7e:
	dw Lz_6d_731f ; $407e
DataPtr_6d_80:
	dw Lz_6d_73d9 ; $4080
DataPtr_6d_82:
	dw Lz_6d_745b ; $4082
DataPtr_6d_84:
	dw Lz_6d_7507 ; $4084
DataPtr_6d_86:
	dw Lz_6d_758a ; $4086
DataPtr_6d_88:
	dw Lz_6d_761a ; $4088
DataPtr_6d_8a:
	dw Lz_6d_76b2 ; $408a
DataPtr_6d_8c:
	dw Lz_6d_7799 ; $408c
DataPtr_6d_8e:
	dw Lz_6d_7887 ; $408e
DataPtr_6d_90:
	dw Lz_6d_7970 ; $4090
DataPtr_MarioMiniGamesTiles:
	dw MarioMiniGamesTiles ; $4092
Lz_6d_4094:
	INCBIN "data/bank_06d/lz_4094.bin" ; $4094, 180 bytes
Lz_6d_4148:
	INCBIN "data/bank_06d/lz_4148.bin" ; $4148, 205 bytes
Lz_6d_4215:
	INCBIN "data/bank_06d/lz_4215.bin" ; $4215, 206 bytes
Lz_6d_42e3:
	INCBIN "data/bank_06d/lz_42e3.bin" ; $42e3, 229 bytes
Lz_6d_43c8:
	INCBIN "data/bank_06d/lz_43c8.bin" ; $43c8, 224 bytes
Lz_6d_44a8:
	INCBIN "data/bank_06d/lz_44a8.bin" ; $44a8, 217 bytes
Lz_6d_4581:
	INCBIN "data/bank_06d/lz_4581.bin" ; $4581, 213 bytes
Lz_6d_4656:
	INCBIN "data/bank_06d/lz_4656.bin" ; $4656, 190 bytes
IntroAwesomeTiles:
	INCBIN "data/bank_06d/lz_4714.bin" ; $4714, 1577 bytes
IntroGreatestPlayerTiles:
	INCBIN "data/bank_06d/lz_4d3d.bin" ; $4d3d, 1539 bytes
IntroGreatestPlayerTilemap:
	INCBIN "data/bank_06d/lz_5340.bin" ; $5340, 299 bytes
IntroGreatestPlayerAttrmap:
	INCBIN "data/bank_06d/lz_546b.bin" ; $546b, 72 bytes
IntroGreatestPlayerPalettes:
	; $54b3, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7fff, $4252, $214a, $0000 ; pal 0: #ffffff #949483 #525241 #000000
	dw $214a, $4252, $214a, $0000 ; pal 1: #525241 #949483 #525241 #000000
	dw $214a, $4252, $214a, $0000 ; pal 2: #525241 #949483 #525241 #000000
	dw $214a, $4252, $4252, $0000 ; pal 3: #525241 #949483 #949483 #000000
	dw $214a, $4252, $4252, $0000 ; pal 4: #525241 #949483 #949483 #000000
	dw $214a, $214a, $4252, $0000 ; pal 5: #525241 #525241 #949483 #000000
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
IntroCharactersTiles:
	INCBIN "data/bank_06d/lz_54f3.bin" ; $54f3, 2597 bytes
IntroCharactersTilemap:
	INCBIN "data/bank_06d/lz_5f18.bin" ; $5f18, 329 bytes
Lz_6d_6061:
	INCBIN "data/bank_06d/lz_6061.bin" ; $6061, 163 bytes
Data_6d_6104:
	INCBIN "data/bank_06d/d_6104.bin" ; $6104, 64 bytes
IntroCharactersTilemap2:
	INCBIN "data/bank_06d/lz_6144.bin" ; $6144, 268 bytes
Lz_6d_6250:
	INCBIN "data/bank_06d/lz_6250.bin" ; $6250, 133 bytes
TitleScreenTiles:
	INCBIN "data/bank_06d/lz_62d5.bin" ; $62d5, 1962 bytes
Data_6d_6a7f:
	INCBIN "data/bank_06d/d_6a7f.bin" ; $6a7f, 73 bytes
Lz_6d_6ac8:
	INCBIN "data/bank_06d/lz_6ac8.bin" ; $6ac8, 75 bytes
Lz_6d_6b13:
	INCBIN "data/bank_06d/lz_6b13.bin" ; $6b13, 72 bytes
Lz_6d_6b5b:
	INCBIN "data/bank_06d/lz_6b5b.bin" ; $6b5b, 71 bytes
Lz_6d_6ba2:
	INCBIN "data/bank_06d/lz_6ba2.bin" ; $6ba2, 67 bytes
Lz_6d_6be5:
	INCBIN "data/bank_06d/lz_6be5.bin" ; $6be5, 65 bytes
Lz_6d_6c26:
	INCBIN "data/bank_06d/lz_6c26.bin" ; $6c26, 67 bytes
Lz_6d_6c69:
	INCBIN "data/bank_06d/lz_6c69.bin" ; $6c69, 71 bytes
Lz_6d_6cb0:
	INCBIN "data/bank_06d/lz_6cb0.bin" ; $6cb0, 72 bytes
Lz_6d_6cf8:
	INCBIN "data/bank_06d/lz_6cf8.bin" ; $6cf8, 73 bytes
Lz_6d_6d41:
	INCBIN "data/bank_06d/lz_6d41.bin" ; $6d41, 72 bytes
Lz_6d_6d89:
	INCBIN "data/bank_06d/lz_6d89.bin" ; $6d89, 72 bytes
Lz_6d_6dd1:
	INCBIN "data/bank_06d/lz_6dd1.bin" ; $6dd1, 69 bytes
Lz_6d_6e16:
	INCBIN "data/bank_06d/lz_6e16.bin" ; $6e16, 67 bytes
Lz_6d_6e59:
	INCBIN "data/bank_06d/lz_6e59.bin" ; $6e59, 69 bytes
Lz_6d_6e9e:
	INCBIN "data/bank_06d/lz_6e9e.bin" ; $6e9e, 72 bytes
Lz_6d_6ee6:
	INCBIN "data/bank_06d/lz_6ee6.bin" ; $6ee6, 72 bytes
Lz_6d_6f2e:
	INCBIN "data/bank_06d/lz_6f2e.bin" ; $6f2e, 165 bytes
Lz_6d_6fd3:
	INCBIN "data/bank_06d/lz_6fd3.bin" ; $6fd3, 180 bytes
Lz_6d_7087:
	INCBIN "data/bank_06d/lz_7087.bin" ; $7087, 171 bytes
Lz_6d_7132:
	INCBIN "data/bank_06d/lz_7132.bin" ; $7132, 174 bytes
Lz_6d_71e0:
	INCBIN "data/bank_06d/lz_71e0.bin" ; $71e0, 175 bytes
Lz_6d_728f:
	INCBIN "data/bank_06d/lz_728f.bin" ; $728f, 144 bytes
Lz_6d_731f:
	INCBIN "data/bank_06d/lz_731f.bin" ; $731f, 186 bytes
Lz_6d_73d9:
	INCBIN "data/bank_06d/lz_73d9.bin" ; $73d9, 130 bytes
Lz_6d_745b:
	INCBIN "data/bank_06d/lz_745b.bin" ; $745b, 172 bytes
Lz_6d_7507:
	INCBIN "data/bank_06d/lz_7507.bin" ; $7507, 131 bytes
Lz_6d_758a:
	INCBIN "data/bank_06d/lz_758a.bin" ; $758a, 144 bytes
Lz_6d_761a:
	INCBIN "data/bank_06d/lz_761a.bin" ; $761a, 152 bytes
Lz_6d_76b2:
	INCBIN "data/bank_06d/lz_76b2.bin" ; $76b2, 231 bytes
Lz_6d_7799:
	INCBIN "data/bank_06d/lz_7799.bin" ; $7799, 238 bytes
Lz_6d_7887:
	INCBIN "data/bank_06d/lz_7887.bin" ; $7887, 233 bytes
Lz_6d_7970:
	INCBIN "data/bank_06d/lz_7970.bin" ; $7970, 232 bytes
MarioMiniGamesTiles:
	INCBIN "data/bank_06d/lz_7a58.bin" ; $7a58, 757 bytes
	ds 691, $ff ; $7d4d, fill
