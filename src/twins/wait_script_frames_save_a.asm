; WaitScriptFramesSaveA_<bank>: one routine assembled into banks $0f, $27 through
; `twin wait_script_frames_save_a, <bank>` -- {TWIN} is the bank suffix, so the
; label becomes that bank's; script_delay calls the copy in its own bank. No
; per-instruction addresses: the `twin` line in each bank carries the member's
; address. A fix here lands in every bank.

WaitScriptFramesSaveA_{TWIN}:
	push af
	ld a, a
	farcall WaitScriptFrames
	pop af
	ret
