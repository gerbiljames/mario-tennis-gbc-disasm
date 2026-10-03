; HRAM layout. Each symbol's note gives its size and what reads and writes
; it (docs/ram_map.md).

SECTION "HRAM $ff80", HRAM[$ff80]

; [10 bytes] OAM DMA routine, copied here by CopyOAMDMARoutineToHRAM. Must live in HRAM: the bus is unusable during the transfer
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

; [8-bit] Nonzero while the debug stepper holds the frame. AdvanceFrame sets it on SELECT+START (only when hDebugStepMode is nonzero) and spins until START clears it; SELECT while paused cycles hDebugStepMode 1-3
hDebugStepPaused:: db

; [8-bit] Write offset into the OAM shadow buffer (max $a0)
hSpriteQueueIndex:: db

; [8-bit] OAM shadow offset where per-frame sprites start (entries below persist)
hSpriteQueueBase:: db

; [8-bit] Bit 0 = BG palettes dirty, bit 1 = OBJ palettes dirty
hPaletteDirtyFlags:: db

; [8-bit] Debug pause/frame-step mode (0 = off, 1-3)
hDebugStepMode:: db

; [8-bit] rIE saved by DisableLCDSafely while it masks VBlank off, waits for LY $91 and turns the LCD off
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
; its own purpose. Sites outside these scopes stay numeric; banks $0f/$10
; load $ffb0 as the constant -80, not as an address.
UNION
; level-up stat deltas (bank $02)
; [16-bit] ComputeLevelUpStatDeltas: destination for the per-stat deltas (hl on entry)
hStatDeltaOutPtr:: dw
; [16-bit] ComputeLevelUpStatDeltas: pointer to a 64-byte stack copy of the player record taken before LevelUpPlayerRecord; each stat is differenced against it
hStatDeltaRecordCopy:: dw
NEXTU
; save-slot debug editor (bank $03)
; [16-bit] Unused_03_SaveSlotDebugEditor: edit-cursor offset into the $d300 save-block buffer, wrapped at $400; moved by Unused_03_MoveSaveEditorCursor (c = signed cursor step, b = value step applied on A)
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

; [8-bit] Link error flags. AdvanceFrame jumps to LinkErrorReset if any of the top three bits is set while hLinkCounter is nonzero, but nothing sets them, so the check never fires; InitSerialLink and ResetSerialState clear it
hLinkErrorFlags:: db

; [8-bit] Cleared by InitSerialLink and ResetSerialState; read by nothing
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

; Shared HRAM scratch pool: the serial-link input path, the bank-0 sound
; driver, the sprite queue and the story actor engine reuse the same bytes.
; RunSoundEngine copies all 32 bytes to $d000 in WRAM bank $07 on entry and
; back on exit, so values here survive an audio update (which is what lets
; hMatchFrameCounter count). Sites outside every variant's scope stay numeric.
UNION
; serial-link input slots (default: link-aware match/menu code in many banks)
	ds 2
; [8-bit] Re-entrancy guard: UpdateSoundEngine returns if set, else sets it around RunSoundEngine. Inside the engine this byte is hSndChannelType (the pool is saved and restored)
hSoundEngineBusy:: db
; [8-bit] Effective external input byte produced by SerialDecodeInput (local/remote merged per link role); also the scripted-input feed for demo/CPU-driven characters
hLinkInput:: db
; [8-bit] Input byte decoded from the last received link frame
hLinkRemoteInput:: db
; [8-bit] Buffered remote input from the previous exchange (double-buffered on the slave side)
hLinkRemoteInputBuf:: db
; [8-bit] Local input byte queued for transmission, loaded by PrepareLinkInputPayload (hInputPressed) or PrepareLinkStatePayload (ComposeLinkStateByte). SerialEncodeInput drains it a few bits per frame (all four low bits -> $3f, else bit 3 -> $30, bit 2 -> $0c, else the low pair) and stores the remainder back
hLinkTxInput:: db
; [8-bit] Set to 1 by SerialHandler when a byte completes; WaitSerialTransfer spins on it and AdvanceFrame's link wait clears it after pairing it with hVBlankOccurred
hLinkTransferDone:: db
; [8-bit] Nonzero while a serial block exchange runs (set by UpdateLinkSession, ResyncLinkSession, Unused_07_ExchangeLinkBlockToWram5; cleared by the link menus). AdvanceFrame skips the debug single-step while set
hLinkExchangeActive:: db
; [8-bit] Cleared by InitSerialLink and ResetSerialState; otherwise unused on the serial path (the sound driver's hSndNoteTimer)
hUnusedLinkSlot:: db
; [8-bit] Written with hLinkLastRxByte by both ExchangeLinkFrameByte routines and read by nothing
hLinkLastRxMirror:: db
; [8-bit] Previous frame byte received. ExchangeLinkFrameByteMaster/Slave compare the new byte against it: equal means the peer retransmitted, which steps hLinkCounter and re-inits the link on the second repeat
hLinkLastRxByte:: db
; [8-bit] Sequence bits: top two bits of the last transmitted byte, inverted by PrepareLinkStatePayload/PrepareLinkInputPayload and OR'd into every byte SerialEncodeInput sends, so the peer can tell a fresh frame from a repeat
hLinkTxSeqBits:: db
; [8-bit] Record of LinkStateBytePtrs_07 that ComposeLinkStateByte builds the transmitted state byte from; set per screen by the match and story pause menus and ResetMatchState
hLinkPayloadKind:: db
; [8-bit] One-deep history of hLinkRemoteInputBuf on the slave decode path: SerialDecodeInput swaps the two so a dropped frame can fall back to the previous remote input
hLinkRemoteInputPrev:: db
; [8-bit] Nonzero makes a slave (hLinkState $02) wait for hLinkTxPending to clear before sending, so it never gets ahead of the master
hLinkAckRequired:: db
; [8-bit] The byte handed to the serial port, held until SerialHandler sees the transfer finish and clears it; the slave's ack wait spins on it
hLinkTxPending:: db
; [8-bit] Bit queue SerialHandler shifts left per serial interrupt. Top bit set on entry = arrived byte is not payload (rSB not latched into hLinkRxByte); a bit shifted out suppresses hLinkTransferDone. Seeded with $40 when a transfer is queued
hLinkShiftQueue:: db
; [8-bit] Players currently joined to the link session. Unused_07_AdvanceLinkPlayerCount steps it against wMatchIsDoubles + 1 as peers join and leave
hLinkPlayerCount:: db
; [8-bit] Remote player's cursor page in the link character grid, written beside wMenuCursor2X/Y and read by GetGridSlotFromLinkCursor and the MoveLinkCursor* handlers
hLinkCursorPage:: db
; [8-bit] Written by RunLinkCharSelectScreen, read by nothing (the sound driver's hSndPeriodHi)
hUnusedLinkSelectByte:: db
; [16-bit] Checksum ComputeNibbleBufferChecksum leaves for the block just transferred; both ends compare it after the last nibble and retry the block if it differs
hLinkBlockChecksum:: dw
; [8-bit] Nonzero makes VBlankHandler return immediately (no palette, OAM or tilemap work); set by the link resync while it busy-waits on the serial line
hVBlankSuppressed:: db
; [8-bit] Backoff counter in Unused_07_DelayByLinkPhase: decremented each call, reset to $0f when negative, so retries vary in length instead of locking in step with the peer
hLinkPhaseDelay:: db
; [8-bit] Frames the match has simulated. Incremented by the local driver (bank $08) and the link frame drivers (SyncLinkFrame, RunLinkMatchFrame, RunLinkInputFrame); cleared by ResetMatchState, InitSerialLink and ResetSerialState. Read for periodic effects: `and $0f` cycles the landing marker's animation, `and $01` flickers the ground shadow and offscreen-character arrow
hMatchFrameCounter:: db
	ds 6
NEXTU
; sound driver (bank 0, $3373-$3dd3)
; [16-bit] Current channel's script/state pointer, copied from the channel struct each update
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
; [8-bit] Echo repeat counter (cmd $aa)
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
