SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_14_NAME EQUS "Unused_14_ComputeRankingProgressIndex"

INCLUDE "src/story/tennis_14.asm"
INCLUDE "src/story/court2_14.asm"
INCLUDE "src/story/court1_14.asm"
INCLUDE "src/story/plane_14.asm"
INCLUDE "src/story/firework_14.asm"
INCLUDE "src/story/island_14.asm"
