; --- Link role (hLinkState, wLinkMatchRole, wLinkState) ---
; Role election is first-come (TryEstablishLink): the console that finds the
; peer's probe already waiting becomes the slave. The master drives character
; 0, the slave character 1 (docs/match_engine.md).
def LINKSTATE_IDLE           equ $00
def LINKSTATE_MASTER         equ $01
def LINKSTATE_SLAVE          equ $02

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
def LINKMSG_NONE             equ $c0 ; nothing to say: sent after the handshake and on a reset
def LINKMSG_PROBE            equ $c1 ; the master's handshake probe (TryLinkHandshakeMaster)
def LINKMSG_PROBE_REPLY      equ $c2 ; the slave's answer (TryLinkHandshakeSlave)
def LINKMSG_SYNC_MASTER      equ $c3 ; block start, master side (ExchangeNibbleBlockMaster)
def LINKMSG_SYNC_SLAVE       equ $c4 ; block start, slave side
def LINKMSG_BLOCK_END        equ $c5 ; the sender's last nibble has gone
def LINKMSG_BLOCK_END_ACK    equ $c6 ; the receiver's echo of that
def LINKMSG_CHECKSUM_BAD     equ $cb ; checksums differ: retransmit the whole block
def LINKMSG_CHECKSUM         equ $cc ; compare checksums now
def LINKMSG_BLOCK_OK         equ $cd ; block accepted
