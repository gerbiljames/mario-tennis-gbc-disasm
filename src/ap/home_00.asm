; Archipelago: the ROM0 free tail. Every option byte defaults to 0, vanilla;
; the patch's tokens write them (rom_addresses.py).

; Calls hl in the AP bank (apcall); bc and de go in, af and hl come back.
ApFarCall:
	ld a, BANK(ApCode)
	jp CallHLInBankA

; ap_has: the item and count follow the call
ApHasInline:
	pop hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	push hl
	ld hl, ApItemAtLeast
	jp ApFarCall

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
