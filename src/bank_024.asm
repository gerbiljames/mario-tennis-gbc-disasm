SECTION "ROM Bank $24", ROMX[$4000], BANK[$24]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplyBallTrajectory4_24_NAME EQUS "Unused_24_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_24_NAME EQUS "BallTrajEntryPtr4_24"
DEF BallTrajEntryPtr6_24_NAME EQUS "BallTrajEntryPtr6_24"
DEF SeekBallTrajEntry4_24_NAME EQUS "SeekBallTrajEntry4_24"
DEF SeekBallTrajEntry6_24_NAME EQUS "Unused_24_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_24_NAME EQUS "SetBallTargetFromAim_24"
DEF SetBallVelocityFromEntry4_24_NAME EQUS "SetBallVelocityFromEntry4_24"
DEF SetBallVelocityFromEntry6_24_NAME EQUS "SetBallVelocityFromEntry6_24"

INCLUDE "src/data/shots/lob_drop_neutral_smash.asm"
