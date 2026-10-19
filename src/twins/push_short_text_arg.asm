; PushShortTextArg_<bank>, one copy in each of banks $0e, $0f, $12.

PushShortTextArg_{TWIN}:
	push_wram_bank WRAM_CHAR3
	ld de, wTextArgFetchBuffer
	wram_bank WRAM_CHAR1
	farcall FetchShortTextToBuffer
	ld hl, wTextArgFetchBuffer
	farcall PushTextArgString
	pop_wram_bank
	ret
