; ComputeRankingProgressIndex_<bank>: one routine assembled into banks $0e, $11, $12, $27 through
; `twin_in compute_ranking_progress_index, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_ComputeRankingProgressIndex where nothing reaches it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ASSERT STRCMP("{TWIN_LABEL}", "{ComputeRankingProgressIndex_{TWIN}_NAME}") == 0
{TWIN_LABEL}:
	push hl
	push de
	apcall ApRankingProgressIndex
	ld [wMapSceneStage], a
	pop de
	pop hl
	ret
