; WRAM layout. Each symbol's note gives its size and what reads and writes
; it; banked and overlaid ranges are UNION blocks, one variant per owner
; (docs/ram_map.md).

INCLUDE "ram/wram/wram0_system.asm"
INCLUDE "ram/wram/wram0_match.asm"
INCLUDE "ram/wram/wram0_buffers.asm"
INCLUDE "ram/wram/wram0_records.asm"
INCLUDE "ram/wram/wram0_menus.asm"
INCLUDE "ram/wram/wramx1.asm"
INCLUDE "ram/wram/wramx2.asm"
INCLUDE "ram/wram/wramx3.asm"
INCLUDE "ram/wram/wramx4.asm"
INCLUDE "ram/wram/wramx5.asm"
INCLUDE "ram/wram/wramx6.asm"
INCLUDE "ram/wram/wramx7.asm"
