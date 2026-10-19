; Shared by Unused_27_ComputeRankingProgressIndex,
; ComputeRankingProgressIndex_11, ComputeRankingProgressIndex_12,
; ComputeRankingProgressIndex_0e (banks $0e, $11, $12, $27).

ASSERT STRCMP("{TWIN_LABEL}", "{ComputeRankingProgressIndex_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push hl
	push de
	apcall ApRankingProgressIndex
	ld [wMapSceneStage], a
	pop de
	pop hl
	ret
