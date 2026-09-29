SECTION "ROM Bank $2c", ROMX[$4000], BANK[$2c]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_2c_NAME EQUS "ApplyBallTrajectory4_2c"
DEF BallTrajEntryPtr4_2c_NAME EQUS "BallTrajEntryPtr4_2c"
DEF BallTrajEntryPtr6_2c_NAME EQUS "BallTrajEntryPtr6_2c"
DEF SeekBallTrajEntry4_2c_NAME EQUS "SeekBallTrajEntry4_2c"
DEF SeekBallTrajEntry6_2c_NAME EQUS "SeekBallTrajEntry6_2c"
DEF SetBallTargetFromAim_2c_NAME EQUS "SetBallTargetFromAim_2c"
DEF SetBallVelocityFromEntry4_2c_NAME EQUS "SetBallVelocityFromEntry4_2c"
DEF SetBallVelocityFromEntry6_2c_NAME EQUS "SetBallVelocityFromEntry6_2c"

INCLUDE "src/data/shots/reach.asm"
