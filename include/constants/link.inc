; --- Link role (hLinkState, wLinkMatchRole, wLinkState) ---
; Role election is first-come (TryEstablishLink): the console that finds the
; peer's probe already waiting becomes the slave. The master drives character
; 0, the slave character 1 (docs/match_engine.md).
	const_def
	const LINKSTATE_IDLE   ; $00
	const LINKSTATE_MASTER ; $01
	const LINKSTATE_SLAVE  ; $02

; --- Serial byte tag (top two bits of every byte the link routines send) ---
; Bulk blocks travel one nibble per byte under the sender's tag; a tag with
; no payload is the idle/poll byte. Per-frame play bytes put the alternating
; hLinkTxSeqBits ($40/$80) there instead. Tag $c0 is the LINKMSG_* range.
def LINKTAG_MASK    equ $c0
def LINKTAG_PAYLOAD equ $3f
def LINKTAG_MASTER  equ $40
def LINKTAG_SLAVE   equ $80

; Ready tokens (ExchangeReadyTokenMaster/Slave), each side sends its own
; under its tag and waits for the other's payload.
def LINKREADY_MASTER equ $0b
def LINKREADY_SLAVE  equ $0a

; --- Link control tokens (the serial byte, $07 link routines) ---
; LINKTAG_MASK's fourth value, kept free for in-band control. Per-frame play
; bytes never use these.
	const_def 192
	const LINKMSG_NONE          ; $c0 nothing to say: sent after the handshake and on a reset
	const LINKMSG_PROBE         ; $c1 the master's handshake probe (TryLinkHandshakeMaster)
	const LINKMSG_PROBE_REPLY   ; $c2 the slave's answer (TryLinkHandshakeSlave)
	const LINKMSG_SYNC_MASTER   ; $c3 block start, master side (ExchangeNibbleBlockMaster)
	const LINKMSG_SYNC_SLAVE    ; $c4 block start, slave side
	const LINKMSG_BLOCK_END     ; $c5 the sender's last nibble has gone
	const LINKMSG_BLOCK_END_ACK ; $c6 the receiver's echo of that
	const_def 203
	const LINKMSG_CHECKSUM_BAD ; $cb checksums differ: retransmit the whole block
	const LINKMSG_CHECKSUM     ; $cc compare checksums now
	const LINKMSG_BLOCK_OK     ; $cd block accepted
