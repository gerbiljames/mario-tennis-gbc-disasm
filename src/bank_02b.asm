SECTION "ROM Bank $2b", ROMX[$4000], BANK[$2b]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_2b_NAME EQUS "Unused_2b_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_2b_NAME EQUS "Unused_2b_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_2b_NAME EQUS "Unused_2b_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_2b_NAME EQUS "Unused_2b_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_2b_NAME EQUS "Unused_2b_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_2b_NAME EQUS "Unused_2b_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_2b_NAME EQUS "Unused_2b_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_2b_NAME EQUS "Unused_2b_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_flat.asm"
