SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_0e_NAME EQUS "ComputeRankingProgressIndex_0e"

INCLUDE "src/story/training_0e.asm"
INCLUDE "src/story/actor_0e.asm"
INCLUDE "src/story/repair_0e.asm"
INCLUDE "src/story/mario_0e.asm"
INCLUDE "src/story/actor2_0e.asm"
INCLUDE "src/story/mario2_0e.asm"
INCLUDE "src/story/specialcourt_0e.asm"
INCLUDE "src/story/actor3_0e.asm"
