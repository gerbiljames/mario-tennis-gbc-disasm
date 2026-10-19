InitSaveHeader:
	push af ; $404a
	push bc ; $404b
	push de ; $404c
	push hl ; $404d
	sram_bank $00 ; $404e
	ld hl, SaveSignature ; $4055
	ld de, sSaveSignature ; $4058
	call CopySaveSignature ; $405b
	savedir_entry SAVEBLOCK_SLOT0, $00, $0800, $0300 ; $405e
	savedir_entry SAVEBLOCK_SLOT0_EXTRA, $00, $0b00, $0200 ; $406f
	savedir_entry SAVEBLOCK_SLOT1, $00, $0d00, $0300 ; $4080
	savedir_entry SAVEBLOCK_SLOT1_EXTRA, $00, $1000, $0200 ; $4091
	savedir_entry SAVEBLOCK_SLOT2, $00, $1200, $0300 ; $40a2
	savedir_entry SAVEBLOCK_SLOT2_EXTRA, $00, $1500, $0200 ; $40b3
	savedir_entry SAVEBLOCK_PRESERVED, $00, $1700, $0030 ; $40c4
	savedir_entry SAVEBLOCK_SPARE7, $00, $1730, $0020 ; $40d5
	savedir_entry SAVEBLOCK_SPARE8, $00, $1750, $0020 ; $40e6
	savedir_entry SAVEBLOCK_SPARE9, $00, $1770, $0020 ; $40f7
	savedir_entry SAVEBLOCK_SPARE10, $00, $1790, $0010 ; $4108
	savedir_entry SAVEBLOCK_N64_RECORDS, $00, $1800, $0200 ; $4119
	savedir_entry SAVEBLOCK_UNUSED_BANK0, $00, $1a00, $0020 ; $412a
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 1, $00, $1a20, $0020 ; $413b
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 2, $00, $1a40, $0020 ; $414c
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 3, $00, $1a60, $0020 ; $415d
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 4, $00, $1a80, $0080 ; $416e
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 5, $00, $1b00, $0080 ; $417f
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 6, $00, $1b80, $0080 ; $4190
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 7, $00, $1c00, $0080 ; $41a1
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 8, $00, $1c80, $0080 ; $41b2
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 9, $00, $1d00, $0080 ; $41c3
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 10, $00, $1d80, $0080 ; $41d4
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 11, $00, $1e00, $0080 ; $41e5
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 12, $00, $1e80, $0080 ; $41f6
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 13, $00, $1f00, $0080 ; $4207
	savedir_entry SAVEBLOCK_UNUSED_BANK0 + 14, $00, $1f80, $0080 ; $4218
	savedir_entry SAVEBLOCK_SLOT0 + SAVEBLOCK_BACKUP, $01, $0800, $0300 ; $4229
	savedir_entry SAVEBLOCK_SLOT0_EXTRA + SAVEBLOCK_BACKUP, $01, $0b00, $0200 ; $423a
	savedir_entry SAVEBLOCK_SLOT1 + SAVEBLOCK_BACKUP, $01, $0d00, $0300 ; $424b
	savedir_entry SAVEBLOCK_SLOT1_EXTRA + SAVEBLOCK_BACKUP, $01, $1000, $0200 ; $425c
	savedir_entry SAVEBLOCK_SLOT2 + SAVEBLOCK_BACKUP, $01, $1200, $0300 ; $426d
	savedir_entry SAVEBLOCK_SLOT2_EXTRA + SAVEBLOCK_BACKUP, $01, $1500, $0200 ; $427e
	savedir_entry SAVEBLOCK_PRESERVED + SAVEBLOCK_BACKUP, $01, $1700, $0030 ; $428f
	savedir_entry SAVEBLOCK_SPARE7 + SAVEBLOCK_BACKUP, $01, $1730, $0020 ; $42a0
	savedir_entry SAVEBLOCK_SPARE8 + SAVEBLOCK_BACKUP, $01, $1750, $0020 ; $42b1
	savedir_entry SAVEBLOCK_SPARE9 + SAVEBLOCK_BACKUP, $01, $1770, $0020 ; $42c2
	savedir_entry SAVEBLOCK_SPARE10 + SAVEBLOCK_BACKUP, $01, $1790, $0010 ; $42d3
	savedir_entry SAVEBLOCK_UNUSED_BANK1, $01, $1800, $0080 ; $42e4
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 1, $01, $1880, $0080 ; $42f5
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 2, $01, $1900, $0080 ; $4306
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 3, $01, $1980, $0080 ; $4317
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 4, $01, $1a00, $0080 ; $4328
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 5, $01, $1a80, $0080 ; $4339
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 6, $01, $1b00, $0080 ; $434a
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 7, $01, $1b80, $0080 ; $435b
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 8, $01, $1c00, $0080 ; $436c
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 9, $01, $1c80, $0080 ; $437d
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 10, $01, $1d00, $0080 ; $438e
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 11, $01, $1d80, $0080 ; $439f
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 12, $01, $1e00, $0080 ; $43b0
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 13, $01, $1e80, $0080 ; $43c1
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 14, $01, $1f00, $0080 ; $43d2
	savedir_entry SAVEBLOCK_UNUSED_BANK1 + 15, $01, $1f80, $0080 ; $43e3
	savedir_entry SAVEBLOCK_EXHIBITION, $02, $0000, $0300 ; $43f4
	savedir_entry SAVEBLOCK_EXHIBITION_BACKUP, $02, $0300, $0300 ; $4405
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS, $02, $0600, $0020 ; $4416
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS + 1, $02, $0620, $0020 ; $4427
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS + 2, $02, $0640, $0020 ; $4438
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS + 3, $02, $0660, $0020 ; $4449
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS + 4, $02, $0680, $0020 ; $445a
	savedir_entry SAVEBLOCK_MINIGAME_RECORDS + 5, $02, $06a0, $0020 ; $446b
	savedir_entry SAVEBLOCK_STAR_GRID, $02, $06c0, $0060 ; $447c
	savedir_entry SAVEBLOCK_UNUSED_BANK2, $02, $0720, $0da0 ; $448d
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 1, $02, $14c0, $06c0 ; $449e
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 2, $02, $1b80, $0080 ; $44af
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 3, $02, $1c00, $0080 ; $44c0
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 4, $02, $1c80, $0080 ; $44d1
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 5, $02, $1d00, $0080 ; $44e2
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 6, $02, $1d80, $0080 ; $44f3
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 7, $02, $1e00, $0080 ; $4504
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 8, $02, $1e80, $0080 ; $4515
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 9, $02, $1f00, $0080 ; $4526
	savedir_entry SAVEBLOCK_UNUSED_BANK2 + 10, $02, $1f80, $0080 ; $4537
	savedir_entry SAVEBLOCK_UNUSED_BANK3, $03, $0000, $0100 ; $4548
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 1, $03, $0100, $0100 ; $4559
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 2, $03, $0200, $0100 ; $456a
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 3, $03, $0300, $0100 ; $457b
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 4, $03, $0400, $0100 ; $458c
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 5, $03, $0500, $0200 ; $459d
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 6, $03, $0700, $0100 ; $45ae
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 7, $03, $0800, $0100 ; $45bf
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 8, $03, $0900, $0100 ; $45d0
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 9, $03, $0a00, $0100 ; $45e1
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 10, $03, $0b00, $0100 ; $45f2
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 11, $03, $0c00, $0200 ; $4603
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 12, $03, $0e00, $0200 ; $4614
	savedir_entry SAVEBLOCK_UNUSED_BANK3 + 13, $03, $1000, $0500 ; $4625
	savedir_entry SAVEBLOCK_UNUSED_BANK4, $04, $0000, $0100 ; $4636
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 1, $04, $0100, $0100 ; $4647
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 2, $04, $0200, $0100 ; $4658
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 3, $04, $0300, $0100 ; $4669
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 4, $04, $0400, $0100 ; $467a
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 5, $04, $0500, $0200 ; $468b
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 6, $04, $0700, $0500 ; $469c
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 7, $04, $0c00, $0500 ; $46ad
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 8, $04, $1100, $0500 ; $46be
	savedir_entry SAVEBLOCK_UNUSED_BANK4 + 9, $04, $1600, $0500 ; $46cf
	savedir_entry SAVEBLOCK_UNUSED_BANK5, $05, $0000, $1500 ; $46e0
	savedir_entry SAVEBLOCK_UNUSED_BANK5 + 1, $05, $1500, $0200 ; $46f1
	savedir_entry SAVEBLOCK_UNUSED_BANK5 + 2, $05, $1700, $0200 ; $4702
	savedir_entry SAVEBLOCK_UNUSED_BANK5 + 3, $05, $1900, $0200 ; $4713
	savedir_entry SAVEBLOCK_UNUSED_BANK5 + 4, $05, $1b00, $0200 ; $4724
	savedir_entry SAVEBLOCK_UNUSED_BANK5 + 5, $05, $1d00, $0200 ; $4735
	savedir_entry SAVEBLOCK_UNUSED_BANK6, $06, $0000, $1e00 ; $4746
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 1, $07, $0000, $1e00 ; $4757
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 2, $08, $0000, $1e00 ; $4768
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 3, $09, $0000, $1e00 ; $4779
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 4, $0a, $0000, $1e00 ; $478a
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 5, $0b, $0000, $1e00 ; $479b
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 6, $0c, $0000, $1e00 ; $47ac
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 7, $0d, $0000, $1e00 ; $47bd
	savedir_entry SAVEBLOCK_UNUSED_BANK6 + 8, $0e, $0000, $1e00 ; $47ce
	ASSERT savedir_next == NUM_SAVEBLOCKS
	ld hl, sSaveFormatVersion ; $47df
	ld [hl], $71 ; $47e2
	pop hl ; $47e4
	pop de ; $47e5
	pop bc ; $47e6
	pop af ; $47e7
	ret ; $47e8
