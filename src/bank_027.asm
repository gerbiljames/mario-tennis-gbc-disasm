SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_27_NAME EQUS "Unused_27_ComputeRankingProgressIndex"

INCLUDE "src/story/slots_27.asm"
INCLUDE "src/story/end16_27.asm"
INCLUDE "src/story/end12_27.asm"
INCLUDE "src/story/end10_27.asm"
INCLUDE "src/story/end4_27.asm"
INCLUDE "src/story/restaurant_27.asm"
INCLUDE "src/story/actor_27.asm"
