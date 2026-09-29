SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_12_NAME EQUS "ComputeRankingProgressIndex_12"

INCLUDE "src/story/wall_12.asm"
INCLUDE "src/story/wall2_12.asm"
INCLUDE "src/story/senior_12.asm"
INCLUDE "src/story/senior2_12.asm"
INCLUDE "src/story/actor_12.asm"
INCLUDE "src/story/actor2_12.asm"
INCLUDE "src/story/actor3_12.asm"
