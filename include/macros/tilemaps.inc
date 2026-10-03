; Tilemap grids and rect copies.

; Match-result tilemap-copy record (CopyTilemapRect):
; copy a `rows`-tall, 2-tile-wide rectangle from `src` to `dest` in the BG
; tilemap shadow. Lists live in MatchResultTilemapScripts_16, one per result
; layout, and end with a tilemap_copy_end sentinel.
; Usage: tilemap_copy dest, src, rows
MACRO tilemap_copy
	dw \1, \2
	db \3
ENDM

; Terminates a tilemap_copy list: the routine stops on a dest word of $0000.
MACRO tilemap_copy_end
	ds 5, $00
ENDM

; Tilemap-assembly record (bank $39, via CopyTilemapRect): copy a
; `height`x`width` rectangle from `src` to `dest` in the tilemap shadow (and
; again at a +$0400 buffer offset). Lists end with tilemap_rect_end (a record
; whose height byte is 0, which the loop stops on).
; Usage: tilemap_rect src, dest, height, width
MACRO tilemap_rect
	dw \1, \2
	db \3, \4
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
