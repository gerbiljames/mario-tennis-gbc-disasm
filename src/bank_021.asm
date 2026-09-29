SECTION "ROM Bank $21", ROMX[$4000], BANK[$21]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_21_NAME EQUS "Unused_21_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_21_NAME EQUS "Unused_21_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_21_NAME EQUS "BallTrajEntryPtr6_21"
DEF SeekBallTrajEntry4_21_NAME EQUS "Unused_21_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_21_NAME EQUS "SeekBallTrajEntry6_21"
DEF SetBallTargetFromAim_21_NAME EQUS "SetBallTargetFromAim_21"
DEF SetBallVelocityFromEntry4_21_NAME EQUS "Unused_21_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_21_NAME EQUS "SetBallVelocityFromEntry6_21"

INCLUDE "src/data/shots/power_slice.asm"
