SECTION "ROM Bank $29", ROMX[$4000], BANK[$29]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_29_NAME EQUS "Unused_29_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_29_NAME EQUS "Unused_29_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_29_NAME EQUS "Unused_29_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_29_NAME EQUS "Unused_29_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_29_NAME EQUS "Unused_29_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_29_NAME EQUS "Unused_29_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_29_NAME EQUS "Unused_29_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_29_NAME EQUS "Unused_29_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_topspin.asm"
