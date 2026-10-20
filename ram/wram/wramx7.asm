SECTION "WRAMX bank 7", WRAMX[$d000], BANK[7]

; WRAMX bank 7 at a glance:
;
;   $d000-$d01f  sound driver
;   $d02a-$d219  sound engine
;   $d300-$daff  text glyph tiles / save-block staging
;   $db26-$db27  story-data confirm menu
;   $de00-$de1f  minigame record parameter
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Where the shared HRAM pool goes during an audio update. (Bank $05 and the
; boot path also load $d000 with WRAM bank $07 selected, as the base of a
; 4 KiB clear of the whole bank.)
; sound driver (bank 0)
; [32 bytes] Copy of $ffd0-$ffef saved by RunSoundEngine on entry and restored on exit. The driver keeps its channel state in that HRAM window, so four other subsystems can keep their own bytes there across an audio update (see the $ffd0 union)
wSndHramSave:: ds 32
	export_size wSndHramSave

	ds 10

; Sound engine channel state. (The same offsets in WRAM bank $06 are the
; palette fade engine and screen state.)
; sound engine (bank 0)
	ds 214
; [192 bytes] Six 32-byte channel state blocks (channels 0-1 sound effects, 2-5 music; StopMusic clears the four from +64). The active channel's block is mirrored into HRAM $ffd0 each pass; first word = script pointer ($ffff = idle)
wSndChannels:: ds 192
; [72 bytes] Per-channel loop bookkeeping (counter + return pointer per loop level); base resolved by GetChannelLoopSlot
wSndLoopSlots:: ds 72
; [8-bit] Bitmask of channels already serviced/keyed this update pass (AbortIfChannelTriggered tests it; folded into rAUDTERM at the end)
wSndActiveMask:: db
; [8-bit] Shadow of rAUDTERM: per-channel left/right output enable bits accumulated across channels
wSndPanShadow:: db
; [8-bit] Current channel type (0=square1/sweep, 1=square2, 2=wave, 3=noise)
wSndChannelType:: db
; [8-bit] Current channel's stereo output bit-pair (ch1=$11 .. ch4=$88), used for active-channel tracking
wSndChannelBits:: db
; [8-bit] Same bit-pair as wSndChannelBits, masked against hSndPanMask to build wSndPanShadow
wSndChannelPanMask:: db
; [8-bit] Current channel's APU register offset (type*5); WriteChannelReg forms rAUD via $ff10+this+reg
wSndRegBase:: db
; [8-bit] Free-running update counter; low nibble supplies the vibrato phase in TickVibrato
wSndFrameCounter:: db
; [8-bit] Index (0-5) of the channel currently being updated
wSndChannelIndex:: db
	ds 2
; [8-bit] Pending channel-update request: mask of channels to reconfigure (SetChannelUpdateRequest)
wSndUpdateReqMask:: db
; [8-bit] Value applied by the pending channel-update request (low nibble)
wSndUpdateReqData:: db
; [8-bit] Accumulator of channels that have acknowledged the pending update request
wSndUpdateReqAck:: db
; [8-bit] Channel index the update pass starts from (normally 0)
wSndFirstChannel:: db
	ds 1
; [8-bit] Wave-pattern id currently loaded into wave RAM (change detection for the wave channel)
wSndLoadedWaveId:: db
; [8-bit] Global switch value (snd_switch, cmd $a9): an index into the jump table $a9 $fe reads; never added to notes
wSndSwitch:: db
; [8-bit] Non-zero to force the wave channel to reload its pattern on the next note
wSndWaveReloadPending:: db

	ds 230

; Two overlays on this 2 KiB: the text engine's glyph tiles (uploaded to
; VRAM $8800), and the bank $03 save engine's block staging (a save never
; runs while text is being composed). Banks $05/$3f use $d3xx-$dafx literals
; for other buffers in other WRAM banks too.
; Bank $03's debug save editor hex-dumps the region from $d300. Its "wipe
; the block" branch clears from $d300 and its slot-3 branch edits $d300+,
; both $200 short of where Unused_03_ReadCurrentSlotBlock puts the block.
UNION
; text glyph tiles (banks $05/$3f)
; [2048 bytes] 128 proportional-font glyph tiles, 1:1 with VRAM $8800 (tile n at + n * TILE_SIZE). PlotGlyphRow adds the pen position with a signed shift (sra d / rr e), so a negative pen writes below the base: the lesson menu's second page puts five glyph tiles at $d2b0-$d2ff, harmless since bank $07 is unused there (docs/bugs.md). ClearGlyphBuffer fills all 128 with the blank glyph; UploadGlyphBufferFull sends the first 80 as five 256-byte pages; UploadGlyphTilesPartial / Unused_05_UploadGlyphTileRange send narrower runs
wGlyphTileBuffer:: ds 2048
NEXTU
; save-block staging (bank $03)
; [384 bytes] The region bank $03's debug save editor hex-dumps, wipes and edits (see above)
wSaveEditorBlock:: ds 384
; [32 bytes] Image of a minigame-record save block ($38 + story slot): 16 16-bit records by record id. ReadMinigameRecord zeroes it, reads the block over it and returns record b in wMinigameRecordValue; UpdateMinigameRecord does the reverse and verifies the block
wMinigameRecordBlock:: ds 32
	ds 96
; [512 bytes] Image of the $200-byte block the save engine is working on: the story slot block for Unused_03_ReadCurrentSlotBlock / Unused_03_WriteCurrentSlotBlock (ids from StorySlotBlockIds_03), or block $0b for the N64 transfer records. ApplyN64RecordsUnlockFlags and UpdateUnlockablesSaveBlock use the unlock bytes at +$00-$07
wSaveBlockBuffer:: ds 512
ENDU

	ds 38

; State for a stubbed-out frame task.
; story-data confirm menu (bank $1b)
; [2 bytes] Unused_1b_RunStoryDataConfirmMenu clears +$00, sets +$01 to $0c and registers StubNop_1b_09 as a frame task, whose body is a bare ret, so neither byte is read
wStubbedPromptTaskState:: dw

	ds 728

; Minigame record parameter. (WRAM bank $04 has the match ball sprite slots
; at this address.)
; minigame record parameter (WRAM bank $07)
; [16-bit] In/out parameter of ReadMinigameRecord / UpdateMinigameRecord: one record's high score, read from or written into wMinigameRecordBlock. Callers select WRAM bank $07 around it
wMinigameRecordValue:: dw
	ds 30

SECTION "WRAMX bank 7 $df00", WRAMX[$df00], BANK[7]

	match_char_struct w7
