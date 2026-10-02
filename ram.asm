; RAM declarations: the battery save, WRAM and HRAM (docs/ram_map.md).

; export_size Label -- right after a declaration: Label_SIZE is its size in
; bytes, exported so code assembled elsewhere can copy or clear it by name.
MACRO export_size
	DEF \1_SIZE EQU @ - \1
	EXPORT \1_SIZE
ENDM

INCLUDE "ram/sram.asm"
INCLUDE "ram/wram.asm"
INCLUDE "ram/hram.asm"
