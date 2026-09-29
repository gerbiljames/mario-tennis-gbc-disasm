SECTION "ROM Bank $23", ROMX[$4000], BANK[$23]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_23_NAME EQUS "Unused_23_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_23_NAME EQUS "Unused_23_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_23_NAME EQUS "BallTrajEntryPtr6_23"
DEF SeekBallTrajEntry4_23_NAME EQUS "Unused_23_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_23_NAME EQUS "SeekBallTrajEntry6_23"
DEF SetBallTargetFromAim_23_NAME EQUS "SetBallTargetFromAim_23"
DEF SetBallVelocityFromEntry4_23_NAME EQUS "Unused_23_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_23_NAME EQUS "SetBallVelocityFromEntry6_23"

INCLUDE "src/data/shots/power_topspin.asm"
