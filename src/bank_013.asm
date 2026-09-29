SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_13_NAME EQUS "Unused_13_ComputeRankingProgressIndex"

INCLUDE "src/story/restaurant_13.asm"
INCLUDE "src/story/dorm_13.asm"
INCLUDE "src/story/academy_13.asm"
INCLUDE "src/story/varsity_13.asm"
INCLUDE "src/story/actor_13.asm"
INCLUDE "src/story/varsity2_13.asm"
INCLUDE "src/story/actor2_13.asm"
