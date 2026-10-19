; WaitScriptFramesSaveA_<bank>, one copy in each of banks $0f, $27.

WaitScriptFramesSaveA_{TWIN}:
	push af
	ld a, a
	farcall WaitScriptFrames
	pop af
	ret
