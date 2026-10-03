; --- Link role (hLinkState, wLinkMatchRole, wLinkState) ---
; Role election is first-come (TryEstablishLink): the console that finds the
; peer's probe already waiting becomes the slave. The master drives character
; 0, the slave character 1 (docs/match_engine.md).
def LINKSTATE_IDLE           equ $00
def LINKSTATE_MASTER         equ $01
def LINKSTATE_SLAVE          equ $02

; --- Link control tokens (the serial byte, $07 link routines) ---
; Bulk blocks travel one nibble per byte with a tag in bits 6-7 (`or $40`
; from the master, `or $80` from the slave), which keeps $c0-$cf free for
; in-band control. Per-frame play bytes never use these.
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
