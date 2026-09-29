SECTION "ROM Bank $2a", ROMX[$4000], BANK[$2a]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_2a_NAME EQUS "Unused_2a_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_2a_NAME EQUS "Unused_2a_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_2a_NAME EQUS "Unused_2a_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_2a_NAME EQUS "Unused_2a_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_2a_NAME EQUS "Unused_2a_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_2a_NAME EQUS "Unused_2a_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_2a_NAME EQUS "Unused_2a_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_2a_NAME EQUS "Unused_2a_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_slice.asm"
