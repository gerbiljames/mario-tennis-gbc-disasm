; Shared by QueueCaptionRowToVRAM, FlushLinkMessageRows (banks $17, $3e).

{TWIN_LABEL}:
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH
	ld c, 6 * TILEMAP_WIDTH / 16
	call QueueVRAMCopy
	ret
