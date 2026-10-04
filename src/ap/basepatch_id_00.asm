; The basepatch id: "MTAP" and the first 4 bytes of a SHA-1 over the built ROM
; with these 8 bytes zeroed, written in by tools/ap_export.py. Its address
; never moves, so a client can read any build's id.
ApBasepatchId::
	db "MTAP"
	ds 4, 0
