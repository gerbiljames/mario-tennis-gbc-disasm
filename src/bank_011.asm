SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ComputeRankingProgressIndex_11_NAME EQUS "ComputeRankingProgressIndex_11"

INCLUDE "src/story/center_11.asm"
INCLUDE "src/story/student_11.asm"
INCLUDE "src/story/junior_11.asm"
INCLUDE "src/story/doubles_11.asm"
INCLUDE "src/story/junior2_11.asm"
INCLUDE "src/story/actor_11.asm"
INCLUDE "src/story/actor2_11.asm"
