SECTION "ROM Bank $22", ROMX[$4000], BANK[$22]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_22_NAME EQUS "Unused_22_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_22_NAME EQUS "Unused_22_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_22_NAME EQUS "BallTrajEntryPtr6_22"
DEF SeekBallTrajEntry4_22_NAME EQUS "Unused_22_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_22_NAME EQUS "SeekBallTrajEntry6_22"
DEF SetBallTargetFromAim_22_NAME EQUS "SetBallTargetFromAim_22"
DEF SetBallVelocityFromEntry4_22_NAME EQUS "Unused_22_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_22_NAME EQUS "SetBallVelocityFromEntry6_22"

INCLUDE "src/data/shots/topspin.asm"
