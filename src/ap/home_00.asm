; Archipelago: the ROM0 free tail. Every option byte defaults to 0, vanilla;
; the patch's tokens write them (rom_addresses.py).

; Calls hl in the AP bank (apcall); bc and de go in, af and hl come back.
ApFarCall:
	ld a, BANK(ApCode)
	jp CallHLInBankA

; ap_has and ap_pass: two argument bytes follow the call, read here while
; the caller's bank is still mapped
ApTestInline:
	push bc
	push de
	push hl
	ld hl, sp + 6
	call FetchInlineWordOperand
	ld hl, ApTestInlineFar
	call ApFarCall
	pop hl
	pop de
	pop bc
	ret

ApOptSkipIntro: db 0
ApOptStoryArcs: db 0
ApOptMinigames: db 0
ApOptRemoteItems: db 0
ApOptGoal: db 0
ApOptMatchSets: db 0
ApOptMatchGames: db 0
ApOptSwingLow: db 0
ApOptSwingHigh: db 0
ApOptLocationCount: db 0
; a new game's message speed + 1 (0: Normal, the vanilla default)
ApOptTextSpeed: db 0
; nonzero: a new story file's matches use the PLAYER camera (wCourtViewOption)
ApOptCameraMode: db 0
