; Length checks for tables indexed by an id. `table_width` goes right after
; the table's label and region comment and gives the row size in bytes;
; `assert_table_length` goes after the last row and gives the row count,
; normally a NUM_* constant, so adding an id without a row fails the build.

MACRO table_width
	DEF TABLE_WIDTH = \1
	REDEF TABLE_START EQUS "{.}"
	ASSERT {TABLE_START} == @, "table_width must follow the table's label"
ENDM

MACRO assert_table_length
	DEF TABLE_ROWS = \1
	DEF TABLE_EXPECTED = TABLE_ROWS * TABLE_WIDTH
	DEF TABLE_SIZE = @ - {TABLE_START}
	ASSERT TABLE_SIZE == TABLE_EXPECTED, \
		"{TABLE_START}: expected {d:TABLE_ROWS} rows of {d:TABLE_WIDTH} bytes ({d:TABLE_EXPECTED}), got {d:TABLE_SIZE} bytes"
ENDM
