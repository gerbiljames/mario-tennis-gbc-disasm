; Shot-solver trajectory rows (data/bank_02x/<Table>.asm, generated at setup).

; One row of a ballistic-solution table (docs/match_engine.md "The trajectory
; tables"): the launch speed (the row search key, rising with the row), the
; launch elevation angle, and, in the six-byte
; tables, the lateral aim delta added to wShotAimAngle. Rows are 64 units of
; distance apart; a block is one contact-height band or placement variant.
MACRO traj_row ; speed, elevation, lateral delta
	dw \1, \2, \3
ENDM

MACRO traj_row4 ; speed, elevation
	dw \1, \2
ENDM
