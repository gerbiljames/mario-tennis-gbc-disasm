; Tilemap grids and rect copies.

; Match-result tilemap-copy record (CopyTilemapRect): copy a `width`-wide,
; two-row rectangle from cell (src_col, src_row) to (dest_col, dest_row) of
; wShadowTilemap. Lists live in MatchResultTilemapScripts_16, one per result
; layout, and end with a tilemap_copy_end sentinel.
; Usage: result_copy dest_col, dest_row, src_col, src_row, width
MACRO result_copy
	ASSERT (\1) < TILEMAP_WIDTH && (\3) < TILEMAP_WIDTH && (\2) < 32 && (\4) < 32, "result_copy: cell off the plane"
	dw wShadowTilemap + (\2) * TILEMAP_WIDTH + (\1), wShadowTilemap + (\4) * TILEMAP_WIDTH + (\3)
	db \5
ENDM

; Terminates a result_copy list: the routine stops on a dest word of $0000.
MACRO tilemap_copy_end
	ds 5, $00
ENDM

; Tilemap-assembly record (bank $39, RestoreMenuBgAndDrawPanel): copy a
; `width`x`height` rectangle from cell (src_col, src_row) of the panel art
; in wStadiumTilemapCopy to (dest_col, dest_row) of wShadowTilemap, then
; the same rectangle of the attribute planes $400 above both. Lists end with
; tilemap_rect_end (a record whose width byte is 0, which the loop stops on).
; Usage: panel_rect src_col, src_row, dest_col, dest_row, width, height
MACRO panel_rect
	ASSERT (\1) < TILEMAP_WIDTH && (\3) < TILEMAP_WIDTH && (\2) < 32 && (\4) < 32, "panel_rect: cell off the plane"
	dw wStadiumTilemapCopy + (\2) * TILEMAP_WIDTH + (\1), wShadowTilemap + (\4) * TILEMAP_WIDTH + (\3)
	db \5, \6
ENDM

MACRO tilemap_rect_end
	ds 6, $00
ENDM

; A rectangular block of tilemap (or attrmap) bytes, stored row-major and
; copied by CopyTextRect/CopyTextRectPair. `tilemap_begin` declares the
; geometry, one `tilemap_row` follows per row (rgbasm checks that its argument
; count matches the declared width), and `tilemap_end` checks the row count and
; the total size.
; Usage: tilemap_begin width, height / tilemap_row ... / tilemap_end
MACRO tilemap_begin
DEF _TM_W = \1
DEF _TM_H = \2
DEF _TM_ROWS = 0
DEF _TM_START = @
ENDM

MACRO tilemap_row
	ASSERT _NARG == _TM_W, "tilemap_row: {d:_NARG} bytes, width is {d:_TM_W}"
	db \#
DEF _TM_ROWS += 1
ENDM

MACRO tilemap_end
	ASSERT _TM_ROWS == _TM_H, "tilemap_end: {d:_TM_ROWS} rows, height is {d:_TM_H}"
	ASSERT @ - _TM_START == _TM_W * _TM_H, "tilemap_end: size mismatch"
ENDM
