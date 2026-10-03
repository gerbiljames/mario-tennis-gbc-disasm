; HRAM layout. Each symbol's note gives its size and what reads and writes
; it (docs/ram_map.md). Hand-maintained.

SECTION "HRAM $ff80", HRAM[$ff80]

; [10 bytes] OAM DMA trampoline, copied here from ROM0 $06ba by CopyOAMDMARoutineToHRAM: ld a, $c0 / ldh [rDMA], a / 40-iteration wait / ret. Must live in HRAM because the bus is unusable during the transfer
hOAMDMARoutine:: ds 10

; [8-bit] SCY shadow, applied in VBlank
hScrollY:: db

; [8-bit] SCX shadow, applied in VBlank
hScrollX:: db

; [8-bit] Increments every VBlank
hVBlankCounter:: db

; [8-bit] Set at end of VBlank handler; AdvanceFrame waits on it
hVBlankOccurred:: db

; [8-bit] Nonzero = wDebugTextBuffer needs re-upload
hDebugTextDirty:: db

; [8-bit] Nonzero when wFrameTasks is consistent; cleared while the list is mutated so the frame hook skips it
hFrameTasksReady:: db

; [8-bit] Player Input Flags
;
; Bit 7 - Down
; Bit 6 - Up
; Bit 5 - Left
; Bit 4 - Right
; Bit 3 - Start
; Bit 2 - Select
; Bit 1 - B
; Bit 0 - A
hPlayerInputFlags:: db

; [8-bit] Buttons newly pressed this frame (same bit layout as hPlayerInputFlags)
hInputPressed:: db

; [8-bit] Buttons held for key-repeat tracking
hInputRepeatButtons:: db

; [8-bit] Frames until next key-repeat fire
hInputRepeatTimer:: db

; [8-bit] Buttons newly pressed this frame (raw, before repeat processing)
hInputRisingEdge:: db

; [8-bit] Shadow of the current ROM bank (written together with the MBC register at $2000)
hRomBank:: db

; [8-bit] Shadow of the current WRAM bank (last value written to rSVBK); match engine swaps banks 4-7 for per-character data
hWramBank:: db

; [8-bit] Shadow of the current SRAM bank (always written together with the MBC RAM-bank register at $4000)
hSramBank:: db

; [8-bit] 1 = VBlank switches BG map to the debug console view
hShowDebugConsole:: db

; [8-bit] Nonzero = VRAM copy / tile-write queues have pending entries
hVRAMQueueDirty:: db

; [8-bit] Nonzero while the debug stepper is holding the frame. AdvanceFrame sets it when SELECT+START are held (only once hDebugStepMode has enabled stepping at all) and spins in its step loop until START clears it; SELECT while paused cycles hDebugStepMode 1-3 rather than resuming
hDebugStepPaused:: db

; [8-bit] Write offset into the OAM shadow buffer (max $a0)
hSpriteQueueIndex:: db

; [8-bit] OAM shadow offset where per-frame sprites start (entries below persist)
hSpriteQueueBase:: db

; [8-bit] Bit 0 = BG palettes dirty, bit 1 = OBJ palettes dirty
hPaletteDirtyFlags:: db

; [8-bit] Debug pause/frame-step mode (0 = off, 1-3)
hDebugStepMode:: db

; [8-bit] rIE saved across DisableLCDSafely's VBlank wait: it masks the VBlank interrupt off, spins until rLY hits $91, turns the LCD off and restores rIE from here
hSavedIE:: db

; [8-bit] Peak LY at end-of-frame (frame time meter shown on debug console)
hPeakLY:: db

; [8-bit] Frames until hPeakLY decays
hPeakLYFrames:: db

; [8-bit] Bit 0 = fading out, bit 1 = fading in, bit 7 = fade to white
hFadeState:: db

; [8-bit] Fade step per frame
hFadeSpeed:: db

; [8-bit] Fade progress counter (starts at $7c)
hFadeCounter:: db
	ds 1

; [8-bit] Key-repeat interval reload value
hInputRepeatDelay:: db

; [8-bit] Sign scratch for signed multiply/divide wrappers
hMathSign:: db

; [32-bit] Full 32-bit product from MulHLByDE
hMulResult:: ds 4

; [8-bit] DivAHLByDE: high byte of the 24-bit dividend (a of a:hl), saved on entry to the wide-divisor path
hDivDividendHi:: db

; [8-bit] DivAHLByDE: middle byte of the quotient, collected as the unrolled loop passes bit 7; the tail returns it in h
hDivQuotientMid:: db

; [8-bit] DivAHLByDE: high byte of the quotient, collected at bit 15; the tail returns it in a, so the result comes back as a:hl like the dividend went in
hDivQuotientHi:: db
	ds 1

; HRAM pointer scratch ($ffb0-$ffb3): two 16-bit slots each caller uses for
; its own purpose, so only proven consumers are named. Sites outside these
; scopes stay numeric -- note that banks $0f/$10 load $ffb0 as the immediate
; constant -80, not as an address.
UNION
; level-up stat deltas (bank $02)
; [16-bit] ComputeLevelUpStatDeltas: caller-supplied destination the per-stat deltas are written to (hl on entry, spilled at $02:$4a02)
hStatDeltaOutPtr:: dw
; [16-bit] ComputeLevelUpStatDeltas: pointer to the 64-byte stack buffer (add sp, -64 at $02:$4a07) holding the player record copied before LevelUpPlayerRecord, which each stat is then differenced against
hStatDeltaRecordCopy:: dw
NEXTU
; save-slot debug editor (bank $03)
; [16-bit] Unused_03_SaveSlotDebugEditor: byte offset of the edit cursor into the $d300 save-block buffer, wrapped to $400 by masking the high byte with $03; moved by Unused_03_MoveSaveEditorCursor, which takes the signed cursor step in c and the value step applied on A in b
hSaveEditorCursor:: dw
ENDU

	ds 4

; [8-bit] Nonzero = row in wBGRowBlitTiles/Attrs awaits VBlank blit
hBGRowBlitPending:: db

; [8-bit] Nonzero = column in wBGColumnBlitTiles/Attrs awaits VBlank blit
hBGColumnBlitPending:: db

; [8-bit] Set when the slow column blit ran this VBlank (skips VRAM queue)
hBGColumnBlitDone:: db
	ds 1

; [8-bit] Nonzero = screen currently faded out
hFadedOut:: db
	ds 3

; [8-bit] Last byte received over the serial link (captured from rSB in the serial interrupt)
hLinkRxByte:: db

; [8-bit] Next byte to transmit over the serial link (copied to rSB)
hLinkTxByte:: db

; [8-bit] Serial link state/role (0 = idle, 1/2 = connected roles); gates the encode/decode paths
hLinkState:: db

; [8-bit] Link error flags beside hLinkState. AdvanceFrame tests the top three bits while hLinkCounter is nonzero and jumps to LinkErrorReset if any is set -- but nothing in the ROM ever sets them, so the check never fires; InitSerialLink and ResetSerialState only clear it
hLinkErrorFlags:: db

; [8-bit] Cleared by InitSerialLink and ResetSerialState and read by nothing else
hUnusedLinkByte:: db
	ds 1

; [8-bit] Nibble-block transfer: the received nibble pair being assembled into a byte by ExchangeNibbleBlockMaster/Slave
hLinkNibbleAccum:: db

; [8-bit] Nibble-block transfer: byte offset into the $ce40 block buffer, stepped once per byte exchanged
hLinkBlockOffset:: db

; [8-bit] Serial link exchange/frame counter; increments per exchange and caps at 8
hLinkCounter:: db
	ds 4

; [8-bit] Jingle sound id currently overriding BGM (0 = none)
hActiveJingle:: db

; [8-bit] Music (0x00 - on, 0x01 - off)
hMusic:: db
	ds 1

; Shared HRAM scratch pool: the serial-link input path, the bank-0
; sound driver, the sprite queue and the story actor engine reuse the same
; bytes. They do not run concurrently, and the sound driver goes further --
; RunSoundEngine copies all 32 bytes out to $d000 in WRAM bank $07 on entry
; and copies them back on exit, so a value living here survives an audio
; update untouched. That is what lets hMatchFrameCounter be a counter at all.
; Only proven consumers are named; sites outside every variant's scope keep
; the numeric address.
UNION
; serial-link input slots (default: link-aware match/menu code in many banks)
	ds 2
; [8-bit] Re-entrancy guard around RunSoundEngine: UpdateSoundEngine returns immediately if it is already set, sets it, runs the engine and clears it. It survives the run because RunSoundEngine saves and restores the whole pool -- inside the engine this same byte is hSndChannelType
hSoundEngineBusy:: db
; [8-bit] Effective external input byte produced by SerialDecodeInput (local/remote merged per link role); also the scripted-input feed for demo/CPU-driven characters
hLinkInput:: db
; [8-bit] Input byte decoded from the last received link frame
hLinkRemoteInput:: db
; [8-bit] Buffered remote input from the previous exchange (double-buffered on the slave side)
hLinkRemoteInputBuf:: db
; [8-bit] Local input byte queued for transmission. PrepareLinkInputPayload loads it from hInputPressed and PrepareLinkStatePayload from ComposeLinkStateByte; SerialEncodeInput drains it a few bits per frame (all four low bits -> $3f, else bit 3 -> $30, bit 2 -> $0c, else the low pair) and stores the remainder back, so a burst of presses is sent over several frames
hLinkTxInput:: db
; [8-bit] Set to 1 by SerialHandler when a byte completes; WaitSerialTransfer spins on it and AdvanceFrame's link wait clears it after pairing it with hVBlankOccurred
hLinkTransferDone:: db
; [8-bit] Non-zero while a serial block exchange runs (UpdateLinkSession, ResyncLinkSession, Unused_07_ExchangeLinkBlockToWram5 set it; the link menus clear it when done). AdvanceFrame skips the SELECT+START debug single-step while it is set
hLinkExchangeActive:: db
; [8-bit] Cleared by InitSerialLink and ResetSerialState; no other serial-path site touches it (the sound driver owns the same byte as hSndNoteTimer)
hUnusedLinkSlot:: db
; [8-bit] Written with hLinkLastRxByte by both ExchangeLinkFrameByte routines and read by nothing
hLinkLastRxMirror:: db
; [8-bit] Previous frame byte received. ExchangeLinkFrameByteMaster/Slave compare the new byte against it: equal means the peer retransmitted, which steps hLinkCounter and re-inits the link on the second repeat
hLinkLastRxByte:: db
; [8-bit] Top two bits of the last transmitted byte, inverted (`and $c0 / xor $c0`) by PrepareLinkStatePayload and PrepareLinkInputPayload and OR'd into every byte SerialEncodeInput sends. Alternating them is what lets the peer tell a fresh frame from a repeat
hLinkTxSeqBits:: db
; [8-bit] Which record of LinkStateBytePtrs_07 ComposeLinkStateByte builds the transmitted state byte from; the match and story pause menus and ResetMatchState set it as the screen changes, so the link sends the payload the current screen expects
hLinkPayloadKind:: db
; [8-bit] One-deep history of hLinkRemoteInputBuf on the slave decode path: SerialDecodeInput swaps the two so a dropped frame can fall back to the previous remote input
hLinkRemoteInputPrev:: db
; [8-bit] Nonzero makes a slave (hLinkState $02) wait for hLinkTxPending to clear before sending, so it never gets ahead of the master
hLinkAckRequired:: db
; [8-bit] The byte handed to the serial port, held until SerialHandler sees the transfer finish and clears it; the slave's ack wait spins on it
hLinkTxPending:: db
; [8-bit] Bit queue SerialHandler shifts left once per serial interrupt. A set top bit on entry means the byte that just arrived is not payload, so rSB is not latched into hLinkRxByte; a bit shifted out suppresses hLinkTransferDone for that interrupt. Seeded with $40 when a transfer is queued
hLinkShiftQueue:: db
; [8-bit] Players currently joined to the link session. Unused_07_AdvanceLinkPlayerCount steps it against wMatchIsDoubles + 1 as peers join and leave
hLinkPlayerCount:: db
; [8-bit] Remote player's cursor page in the link character grid, written beside wMenuCursor2X/Y and read by GetGridSlotFromLinkCursor and the MoveLinkCursor* handlers
hLinkCursorPage:: db
; [8-bit] Written twice by RunLinkCharSelectScreen and read by nothing. The sound driver owns the byte as hSndPeriodHi, but the pool is saved and restored around the engine, so the write neither survives nor disturbs anything
hUnusedLinkSelectByte:: db
; [16-bit] Checksum ComputeNibbleBufferChecksum leaves for the block just transferred; both ends compare it after the last nibble and retry the block if it differs
hLinkBlockChecksum:: dw
; [8-bit] Nonzero makes VBlankHandler return immediately, doing no palette, OAM or tilemap work. The link resync sets it while it busy-waits on the serial line and clears it when the session is back in step
hVBlankSuppressed:: db
; [8-bit] Backoff counter in Unused_07_DelayByLinkPhase: decremented each call and reset to $0f when it goes negative, so repeated retries spin for a varying number of frames instead of locking in step with the peer
hLinkPhaseDelay:: db
; [8-bit] Frames the match has simulated. Incremented once per frame by the local driver (bank $08, after AdvanceFrame + UpdateMatchFrame) and by all three link frame drivers (SyncLinkFrame, RunLinkMatchFrame, RunLinkInputFrame), so it counts the same either way; cleared by ResetMatchState and by InitSerialLink / ResetSerialState. Read only for cheap periodic effects: `and $0f` cycles the landing marker's 16-frame animation, and `and $01` draws the ground shadow and the offscreen-character arrow on alternate frames -- the usual Game Boy way to fake a translucent sprite
hMatchFrameCounter:: db
	ds 6
NEXTU
; sound driver (bank 0, $3373-$3dd3)
; [16-bit] Current channel's script/state pointer, copied from the channel struct each update (borrows the sprite-queue bytes; RunSoundEngine save/restores them)
hSndScriptPtr:: dw
; [8-bit] Channel type in the low 2 bits (0=square1/sweep, 1=square2, 2=wave, 3=noise); high nibble carries the vibrato depth / note-length index
hSndChannelType:: db
; [16-bit] Pointer to the current channel's note/command data
hSndDataPtr:: dw
; [8-bit] ROM bank of the current channel's data (loaded into hRomBank/$2000)
hSndDataBank:: db
; [8-bit] Tone control: bits 6-7 duty, bit 4 flag, low nibble = note-length increment paired with hSndLengthAccum
hSndToneCtrl:: db
; [8-bit] Fractional note-length accumulator; hSndToneCtrl's low nibble is added each update and carries a step at $10
hSndLengthAccum:: db
; [8-bit] Current channel volume/envelope value (high nibble = level; envelope steps by $10)
hSndVolume:: db
; [8-bit] The current note's remaining ticks: SndTriggerNote sets it from the note command's length operand (less the echo count while an echo is armed) and snd_glide ($a7) sets it without a key-on; while non-zero the channel holds or slides instead of advancing the script
hSndNoteTimer:: db
; [8-bit] Wave-pattern id for the wave channel (compared with wSndLoadedWaveId); reused as a note/instrument byte on the other channels
hSndWaveId:: db
; [8-bit] Signed note offset/detune applied when a note is triggered (bit 7 = active); set by cmd $a4
hSndNoteOffset:: db
; [8-bit] Per-channel transpose added to note ids (cmd $a9 $f0/$f1/$ff)
hSndTranspose:: db
; [8-bit] Instrument-envelope sweep speed (high nibble); set with hSndEnvLength by cmd $c0-$cf and consumed by TickInstrumentEnvelope
hSndEnvRate:: db
; [8-bit] Instrument-envelope sweep length/target; on the wave channel it doubles as a note-length byte
hSndEnvLength:: db
; [8-bit] Current instrument-envelope position, advanced toward hSndEnvLength each update
hSndEnvPos:: db
; [8-bit] Volume-slide state (bit 7 direction, remaining steps in the low bits); set by cmds $d0-$ef (snd_volume_up/down), ticked by TickVolumeSlide
hSndVolSlide:: db
; [8-bit] Volume-slide period reload value
hSndVolSlideReload:: db
; [8-bit] Volume-slide countdown to the next step
hSndVolSlideTimer:: db
; [8-bit] Base period low byte of the current note, saved as the vibrato centre (TickVibrato offsets from it)
hSndPeriodLo:: db
; [8-bit] Shadow of NRx4 (period high + control); bit 5 ($20) is a software note-on marker used to tell whether a note is sounding
hSndPeriodHi:: db
; [8-bit] Echo state: low nibble echo depth (ScaleEchoVolume), high nibble saved volume level; set by cmd $aa
hSndEcho:: db
; [8-bit] This channel's rAUDTERM left/right output bits, merged into wSndPanShadow; set/swapped by cmd $a5
hSndPanMask:: db
; [8-bit] Note-length reload value (cmd $a3)
hSndNoteLenReload:: db
; [8-bit] Note-length countdown; suppresses vibrato/effects until it reaches 0
hSndNoteLenTimer:: db
; [8-bit] Instrument selector: high nibble picks the wave pattern / envelope-pointer table, low nibble the envelope sequence; set by cmd $a8
hSndInstrument:: db
; [8-bit] Echo repeat counter (cmd $aa); note this HRAM byte is hActorPtr under the story-actor variant
hSndEchoTimer:: db
; [8-bit] Echo control: high nibble enable/count, low nibble note offset
hSndEchoCtrl:: db
; [8-bit] Script loop counter (cmd $ac)
hSndLoopCount:: db
; [16-bit] Saved script pointer for the active loop (cmd $ac/$ad)
hSndLoopReturnPtr:: dw
; [8-bit] Non-zero when the current step is a rest/tie; suppresses the volume envelope in ApplyChannelEnvelope
hSndRestFlag:: db
NEXTU
; sprite queue (bank 0, $2ced-$2d9f)
; [8-bit] Screen X origin of the multi-sprite block being queued (QueueSprite32x32); QueueSpriteBlockPart adds d to it for the OAM X byte
hSpriteBlitX:: db
; [8-bit] Screen Y origin of the multi-sprite block being queued; QueueSpriteBlockPart adds e to it for the OAM Y byte
hSpriteBlitY:: db
NEXTU
; story actor engine (banks $04/$05/$0a)
	ds 26
; [16-bit] Pointer to the actor struct currently being processed (stashed around GetActorStateAddr / StepActorScript)
hActorPtr:: dw
ENDU

	ds 12

; [16-bit] RNG state (x*5 + $3573 per VBlank)
hRandomSeed:: dw

; [8-bit] 1 = running on Game Boy Color hardware
hIsCGB:: db
