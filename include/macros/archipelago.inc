; Archipelago: the practice-match offers (src/ap/practice_11.asm,
; src/ap/varsity_13.asm).

; ap_practice_entry Label, LOC, OfferScript, text, actor -- a court table's
; talk-only NPC entry that hands over to the offering script while the
; practice location is open
MACRO ap_practice_entry
\1:
	ap_open \2
	jp nz, \3
	script_set_text \4
	script_speak \5
	ret
ENDM

; Fay on the Varsity court after the Island Open opens (courts C, D, E):
; while the arc's practice location is open she offers it as she does on
; courts A and B, then plays it. -> nz if she did.
MACRO ap_varsity_practice_offer
	ap_open \3
	ret z
	script_set_text \2
	script_speak_restore \1
	farcall RunDialogueYesNoPrompt
	farcall ScriptCloseDialogueWindow
	script_wait_frames 5
	and a
	jr z, .yes\@
	script_speak \1
	script_set_actor_script \1, ActorScript_13_20
	or 1
	ret
.yes\@:
	farcall AdvanceDialogueTextCursor
	script_speak \1
	ld hl, wStoryModePlayersXPosition
	ld de, wStoryModeSpawnPosition
	ld bc, wStoryModeSpawnPosition_SIZE
	call CopyMemoryBC
	ld a, STORYENTRY_NONE
	ld [wStoryModeEntryPoint], a
	ld [wUnusedExitTriggerIdMirror], a
	ld [wStoryModeExitTriggerRequest], a
	farcall InitStoryMatchSettings
	load_match_settings \4, STORYMATCH_VARSITY_PRACTICE
	farcall RunStoryMatch
	farcall RestoreOverworldAfterMatch
	or 1
	ret
ENDM
