SECTION "ROM Bank $20", ROMX[$4000], BANK[$20]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_20_NAME EQUS "Unused_20_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_20_NAME EQUS "Unused_20_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_20_NAME EQUS "BallTrajEntryPtr6_20"
DEF SeekBallTrajEntry4_20_NAME EQUS "Unused_20_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_20_NAME EQUS "SeekBallTrajEntry6_20"
DEF SetBallTargetFromAim_20_NAME EQUS "SetBallTargetFromAim_20"
DEF SetBallVelocityFromEntry4_20_NAME EQUS "Unused_20_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_20_NAME EQUS "SetBallVelocityFromEntry6_20"

INCLUDE "src/data/shots/slice.asm"
