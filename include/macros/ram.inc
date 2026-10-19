; RAM structures declared once and laid out per copy.

; A bit array for `\1` flags.
MACRO flag_array
	ds ((\1) + 7) / 8
ENDM

; One $40-byte character record (the CHARREC_* fields), labelled
; <prefix><Field>; each field is checked against its CHARREC_* offset.
MACRO char_record
\1::
\1Name::          ds 7
\1NamePad::       ds 3
\1LinkCourtMask:: db
\1Char::          db
\1Palette::       db
\1Gender::        db
\1LeftHanded::    db
\1Physics::       db
\1Reach::         ds 8
\1Level::         db
\1Swing::         dw
\1AiParams::      ds 4
\1Difficulty::    db
\1Stats::
\1TopStat::       db
\1SliceStat::     db
\1ServeStat::     db
\1StrokeStat::    db
\1VolleyStat::    db
\1AngleStat::     db
\1PlacementStat:: db
\1SpeedStat::     db
\1DashStat::      db
\1ReactionStat::  db
\1StopStat::      db
\1SpeedBonus::    db
\1Exp::           ds 3
\1BuildKind::     db
\1PhysicsTemplate:: ds 8
\1TrainLevels::
\1SpinLevel::     db
\1PowerLevel::    db
\1ControlLevel::  db
\1SpeedLevel::    db
\1Equipment::     db
	ds 3
	ASSERT @ - \1 == CHAR_RECORD_SIZE
	ASSERT \1LinkCourtMask - \1 == CHARREC_LINK_COURT_MASK
	ASSERT \1Char - \1 == CHARREC_CHAR
	ASSERT \1Palette - \1 == CHARREC_PALETTE
	ASSERT \1Gender - \1 == CHARREC_GENDER
	ASSERT \1LeftHanded - \1 == CHARREC_LEFT_HANDED
	ASSERT \1Physics - \1 == CHARREC_PHYSICS
	ASSERT \1Reach - \1 == CHARREC_REACH
	ASSERT \1Level - \1 == CHARREC_LEVEL
	ASSERT \1Swing - \1 == CHARREC_SWING
	ASSERT \1AiParams - \1 == CHARREC_AI_PARAMS
	ASSERT \1Difficulty - \1 == CHARREC_DIFFICULTY
	ASSERT \1TopStat - \1 == CHARREC_STAT_TOP
	ASSERT \1StopStat - \1 == CHARREC_STAT_STOP
	ASSERT \1SpeedBonus - \1 == CHARREC_SPEED_BONUS
	ASSERT \1Exp - \1 == CHARREC_EXP
	ASSERT \1BuildKind - \1 == CHARREC_BUILD_KIND
	ASSERT \1PhysicsTemplate - \1 == CHARREC_PHYSICS_TEMPLATE
	ASSERT \1TrainLevels - \1 == CHARREC_TRAIN_LEVELS
	ASSERT \1Equipment - \1 == CHARREC_EQUIPMENT
ENDM

; One on-court character's match statistics, labelled <prefix><Stat>. The
; four sit MATCH_STATS_STRIDE bytes apart, indexed by wLastShotCharIndex.
MACRO match_stats
\1ServiceAces::     db
\1ReturnAces::      db
\1SmashAces::       db
\1LobShotWinners::  db
\1DropShotWinners:: db
\1Faults::          db
\1DoubleFaults::    db
ENDM
