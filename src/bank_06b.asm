SECTION "ROM Bank $6b", ROMX[$4000], BANK[$6b]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_06c/lz_CutsceneGfx0.inc" ; DEF CutsceneGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx1.inc" ; DEF CutsceneGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx2.inc" ; DEF CutsceneGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx3.inc" ; DEF CutsceneGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx4.inc" ; DEF CutsceneGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx5.inc" ; DEF CutsceneGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_CutsceneGfx6.inc" ; DEF CutsceneGfx6_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx0.inc" ; DEF IntroGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx1.inc" ; DEF IntroGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx2.inc" ; DEF IntroGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx3.inc" ; DEF IntroGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx4.inc" ; DEF IntroGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06c/lz_IntroGfx5.inc" ; DEF IntroGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx0.inc" ; DEF TitleGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx1.inc" ; DEF TitleGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx2.inc" ; DEF TitleGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx3.inc" ; DEF TitleGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx4.inc" ; DEF TitleGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx5.inc" ; DEF TitleGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx6.inc" ; DEF TitleGfx6_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_TitleGfx7.inc" ; DEF TitleGfx7_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/cutscenes/slots_6b.asm"
INCLUDE "src/engine/cutscenes/intro_6b.asm"
INCLUDE "src/engine/cutscenes/cutscene_6b.asm"
INCLUDE "src/engine/cutscenes/cutscene2_6b.asm"
INCLUDE "src/engine/cutscenes/title_6b.asm"
