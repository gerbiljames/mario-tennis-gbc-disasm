SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_15_NAME EQUS "Unused_15_ComputeRankingProgressIndex"

INCLUDE "src/story/training_15.asm"
INCLUDE "src/story/training2_15.asm"
INCLUDE "src/story/water_15.asm"
INCLUDE "src/story/challenger_15.asm"
INCLUDE "src/story/actor_15.asm"
INCLUDE "src/story/actor2_15.asm"
INCLUDE "src/story/net_15.asm"
INCLUDE "src/story/net2_15.asm"
INCLUDE "src/story/actor3_15.asm"
