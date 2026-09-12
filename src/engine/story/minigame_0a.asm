InitMinigameTargets:
	wram_bank WRAM_ACTORS ; $6596
	ld hl, wMinigameTargets ; $659c
	ld c, $10 ; $659f
	call ClearMemory16 ; $65a1
	ld a, $01 ; $65a4
	ld [wMinigameTargetsActive], a ; $65a6
	ld a, $ff ; $65a9
	ld [wMinigameHitTargetType], a ; $65ab
	ret ; $65ae
ActivateMinigameTarget:
	ld hl, $0004 ; $65af
	add hl, bc ; $65b2
	ld a, e ; $65b3
	ld [hl+], a ; $65b4
	ld [hl], d ; $65b5
	ld hl, $0001 ; $65b6
	add hl, bc ; $65b9
	ld [hl], $00 ; $65ba
	ld hl, $0000 ; $65bc
	add hl, bc ; $65bf
	set 0, [hl] ; $65c0
	ret ; $65c2
UpdateMinigameTargets:
	ld a, [wMinigameTargetsActive] ; $65c3
	and a ; $65c6
	ret z ; $65c7
	ld hl, wMinigameTargets ; $65c8
	ld c, $0f ; $65cb
.targetLoop:
	call UpdateMinigameTarget ; $65cd
	ld de, $000e ; $65d0
	add hl, de ; $65d3
	dec c ; $65d4
	jr nz, .targetLoop ; $65d5
	ret ; $65d7
UpdateMinigameTarget:
	bit 0, [hl] ; $65d8
	ret z ; $65da
	push af ; $65db
	push bc ; $65dc
	push de ; $65dd
	push hl ; $65de
	push hl ; $65df
	ld de, wMinigameTargetWork ; $65e0
	ld c, $01 ; $65e3
	call CopyMemoryFast ; $65e5
	ld hl, wMinigameTargetWork + 2 ; $65e8
	ld a, [hl] ; $65eb
	and a ; $65ec
	jr z, .hit ; $65ed
	dec [hl] ; $65ef
.hit:
	call RunMinigameTargetScript ; $65f0
	call MoveMinigameTargetTowardGoal ; $65f3
	ld a, [wMinigameTargetsAltMode] ; $65f6
	and a ; $65f9
	jr nz, .expire ; $65fa
	call DrawMinigameTarget ; $65fc
	call CheckBallHitsMinigameTarget ; $65ff
	call HandleMinigameTargetHit ; $6602
	jr .done ; $6605
.expire:
	call DrawMinigameTargetAlt ; $6607
	call CheckBallHitsMinigameTargetAlt ; $660a
	call HandleMinigameTargetHitAlt ; $660d
.done:
	pop de ; $6610
	ld hl, wMinigameTargetWork ; $6611
	ld c, $01 ; $6614
	call CopyMemoryFast ; $6616
	pop hl ; $6619
	pop de ; $661a
	pop bc ; $661b
	pop af ; $661c
	ret ; $661d
MoveMinigameTargetTowardGoal:
	ld hl, wMinigameTargetWork ; $661e
	bit 1, [hl] ; $6621
	ret z ; $6623
	ld hl, wMinigameTargetWork + 6 ; $6624
	ld a, [hl+] ; $6627
	ld d, [hl] ; $6628
	ld e, a ; $6629
	ld hl, wMinigameTargetWork + 10 ; $662a
	ld a, [hl+] ; $662d
	ld h, [hl] ; $662e
	ld l, a ; $662f
	ld a, l ; $6630
	sub e ; $6631
	ld l, a ; $6632
	ld a, h ; $6633
	sbc d ; $6634
	ld h, a ; $6635
	ld a, h ; $6636
	or l ; $6637
	jr z, .depthAxis ; $6638
	ld de, $0010 ; $663a
	bit 7, h ; $663d
	jr z, .stepX ; $663f
	xor a ; $6641
	sub e ; $6642
	ld e, a ; $6643
	sbc a ; $6644
	sub d ; $6645
	ld d, a ; $6646
.stepX:
	ld hl, wMinigameTargetWork + 6 ; $6647
	ld a, [hl] ; $664a
	add e ; $664b
	ld [hl+], a ; $664c
	ld a, [hl] ; $664d
	adc d ; $664e
	ld [hl+], a ; $664f
.depthAxis:
	ld hl, wMinigameTargetWork + 8 ; $6650
	ld a, [hl+] ; $6653
	ld d, [hl] ; $6654
	ld e, a ; $6655
	ld hl, wMinigameTargetWork + 12 ; $6656
	ld a, [hl+] ; $6659
	ld h, [hl] ; $665a
	ld l, a ; $665b
	ld a, l ; $665c
	sub e ; $665d
	ld l, a ; $665e
	ld a, h ; $665f
	sbc d ; $6660
	ld h, a ; $6661
	ld a, h ; $6662
	or l ; $6663
	jr z, .checkArrived ; $6664
	ld de, $0010 ; $6666
	bit 7, h ; $6669
	jr z, .stepDepth ; $666b
	xor a ; $666d
	sub e ; $666e
	ld e, a ; $666f
	sbc a ; $6670
	sub d ; $6671
	ld d, a ; $6672
.stepDepth:
	ld hl, wMinigameTargetWork + 8 ; $6673
	ld a, [hl] ; $6676
	add e ; $6677
	ld [hl+], a ; $6678
	ld a, [hl] ; $6679
	adc d ; $667a
	ld [hl+], a ; $667b
.checkArrived:
	ld hl, wMinigameTargetWork + 6 ; $667c
	ld a, [hl+] ; $667f
	ld d, [hl] ; $6680
	ld e, a ; $6681
	ld hl, wMinigameTargetWork + 10 ; $6682
	ld a, [hl+] ; $6685
	ld h, [hl] ; $6686
	ld l, a ; $6687
	ld a, l ; $6688
	sub e ; $6689
	ld l, a ; $668a
	ld a, h ; $668b
	sbc d ; $668c
	ld h, a ; $668d
	ld a, h ; $668e
	or l ; $668f
	jr nz, .done ; $6690
	ld hl, wMinigameTargetWork + 8 ; $6692
	ld a, [hl+] ; $6695
	ld d, [hl] ; $6696
	ld e, a ; $6697
	ld hl, wMinigameTargetWork + 12 ; $6698
	ld a, [hl+] ; $669b
	ld h, [hl] ; $669c
	ld l, a ; $669d
	ld a, l ; $669e
	sub e ; $669f
	ld l, a ; $66a0
	ld a, h ; $66a1
	sbc d ; $66a2
	ld h, a ; $66a3
	ld a, h ; $66a4
	or l ; $66a5
	jr nz, .done ; $66a6
	ld hl, wMinigameTargetWork ; $66a8
	res 1, [hl] ; $66ab
.done:
	ret ; $66ad
DrawMinigameTarget:
	ld hl, wMinigameTargetWork + 8 ; $66ae
	ld a, [hl+] ; $66b1
	ld b, [hl] ; $66b2
	ld c, a ; $66b3
	ld hl, wMinigameTargetWork + 6 ; $66b4
	ld a, [hl+] ; $66b7
	ld h, [hl] ; $66b8
	ld l, a ; $66b9
	farcall ApplyCameraProjection ; $66ba
	ld c, e ; $66bd
	ld b, d ; $66be
	ld a, [wMinigameTargetWork + 2] ; $66bf
	and $0f ; $66c2
	jr z, .readSprite ; $66c4
	ld_hl_indexed DrawMinigameTargetTable ; $66c6
	ld a, [hl] ; $66cd
	ld h, $00 ; $66ce
	ld l, a ; $66d0
	ld a, [wMinigameTargetWork + 1] ; $66d1
	rrca ; $66d4
	rrca ; $66d5
	and $c0 ; $66d6
	call VectorFromLengthAndAngleRaw ; $66d8
	ld a, c ; $66db
	add e ; $66dc
	ld e, a ; $66dd
	ld a, b ; $66de
	add l ; $66df
	ld d, a ; $66e0
.readSprite:
	ld a, [wMinigameTargetWork + 1] ; $66e1
	add a ; $66e4
	ld_hl_indexed MinigameTargetTable ; $66e5
	ld a, [hl+] ; $66ec
	ld b, [hl] ; $66ed
	ld c, a ; $66ee
	ld hl, DrawMinigameTarget_SpriteTemplate ; $66ef
	call QueueSpriteTemplate ; $66f2
	ret ; $66f5
MinigameTargetTable:
	; $66f6, 8 bytes (bytes:8)
	db $10, $0d, $14, $0f, $18, $0b, $1c, $0e ; 0x00
DrawMinigameTargetTable:
	INCBIN "data/bank_00a/DrawMinigameTargetTable.bin" ; $66fe, 16 bytes
DrawMinigameTarget_SpriteTemplate:
	; $670e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
HandleMinigameTargetHit:
	ld hl, wMinigameTargetWork ; $6717
	bit 2, [hl] ; $671a
	ret z ; $671c
	res 2, [hl] ; $671d
	sound SFX_BALL_CONTACT ; $671f
	ld a, $20 ; $6721
	ld [wMinigameTargetWork + 2], a ; $6723
	ld a, [wMinigameTargetWork + 1] ; $6726
	call DeflectBallOffMinigameTarget ; $6729
	ret ; $672c
CheckBallHitsMinigameTarget:
	ld a, [wBallCrossedNetFlag] ; $672d
	and a ; $6730
	ret z ; $6731
	ld hl, wBallHistory + 30 ; $6732
	ld a, [hl+] ; $6735
	ld d, [hl] ; $6736
	ld e, a ; $6737
	ld hl, wMinigameTargetWork + 6 ; $6738
	ld a, [hl+] ; $673b
	ld h, [hl] ; $673c
	ld l, a ; $673d
	ld a, l ; $673e
	sub e ; $673f
	ld l, a ; $6740
	ld a, h ; $6741
	sbc d ; $6742
	ld h, a ; $6743
	bit 7, h ; $6744
	jr z, .done ; $6746
	ld de, $0200 ; $6748
	add hl, de ; $674b
	bit 7, h ; $674c
	jr nz, .done ; $674e
	ld hl, wBallHistory + 32 ; $6750
	ld a, [hl+] ; $6753
	ld d, [hl] ; $6754
	ld e, a ; $6755
	ld hl, wMinigameTargetWork + 8 ; $6756
	ld a, [hl+] ; $6759
	ld h, [hl] ; $675a
	ld l, a ; $675b
	ld a, l ; $675c
	sub e ; $675d
	ld l, a ; $675e
	ld a, h ; $675f
	sbc d ; $6760
	ld h, a ; $6761
	bit 7, h ; $6762
	jr z, .done ; $6764
	ld de, $0200 ; $6766
	add hl, de ; $6769
	bit 7, h ; $676a
	jr nz, .done ; $676c
	ld hl, wMinigameTargetWork ; $676e
	set 2, [hl] ; $6771
.done:
	ret ; $6773
DeflectBallOffMinigameTarget:
	and $03 ; $6774
	ld a, a ; $6776
	rst Rst00 ; $6777
	dw DeflectBallOffMinigameTarget.pushX ; $6778 jumptable
	dw DeflectBallOffMinigameTarget.pushUp ; $677a jumptable
	dw DeflectBallOffMinigameTarget.pushDepth ; $677c jumptable
	dw DeflectBallOffMinigameTarget.reverse ; $677e jumptable
.pushX:
	ld de, $0600 ; $6780
	ld hl, wBallVelocityX ; $6783
	ld a, [hl] ; $6786
	add e ; $6787
	ld [hl+], a ; $6788
	ld a, [hl] ; $6789
	adc d ; $678a
	ld [hl+], a ; $678b
	ret ; $678c
.pushUp:
	ld bc, $0800 ; $678d
	ld hl, wBallVelocityHeight ; $6790
	ld a, c ; $6793
	ld [hl+], a ; $6794
	ld [hl], b ; $6795
	ld hl, wBallVelocityDepth ; $6796
	ld a, [hl+] ; $6799
	ld d, [hl] ; $679a
	ld e, a ; $679b
	sra d ; $679c
	rr e ; $679e
	dec hl ; $67a0
	ld a, e ; $67a1
	ld [hl+], a ; $67a2
	ld [hl], d ; $67a3
	ret ; $67a4
.pushDepth:
	ld de, $fa00 ; $67a5
	ld hl, wBallVelocityX ; $67a8
	ld a, [hl] ; $67ab
	add e ; $67ac
	ld [hl+], a ; $67ad
	ld a, [hl] ; $67ae
	adc d ; $67af
	ld [hl+], a ; $67b0
	ret ; $67b1
.reverse:
	ld bc, $f400 ; $67b2
	ld hl, wBallVelocityHeight ; $67b5
	ld a, c ; $67b8
	ld [hl+], a ; $67b9
	ld [hl], b ; $67ba
	ld hl, wBallVelocityDepth ; $67bb
	ld a, [hl+] ; $67be
	ld d, [hl] ; $67bf
	ld e, a ; $67c0
	sra d ; $67c1
	rr e ; $67c3
	dec hl ; $67c5
	ld a, e ; $67c6
	ld [hl+], a ; $67c7
	ld [hl], d ; $67c8
	ret ; $67c9
DrawNumberWithSprites:
	push af ; $67ca
	push bc ; $67cb
	push hl ; $67cc
	add sp, -10 ; $67cd
	push bc ; $67cf
	push de ; $67d0
	ld c, l ; $67d1
	ld b, h ; $67d2
	ld hl, sp + 4 ; $67d3
	ld e, l ; $67d5
	ld d, h ; $67d6
	ld l, c ; $67d7
	ld h, b ; $67d8
	ld c, e ; $67d9
	ld b, d ; $67da
	call FormatDecimalNumber ; $67db
	ld l, c ; $67de
	ld h, b ; $67df
	pop de ; $67e0
	pop bc ; $67e1
	call DrawDigitSpritesString ; $67e2
	add sp, 10 ; $67e5
	pop hl ; $67e7
	pop bc ; $67e8
	pop af ; $67e9
	ret ; $67ea
DrawDigitSpritesString:
	ld a, [hl+] ; $67eb
	and a ; $67ec
	jr z, .done ; $67ed
	call DrawDigitSprite_0a ; $67ef
	jr DrawDigitSpritesString ; $67f2
.done:
	ret ; $67f4
DrawDigitSprite_0a:
	sub $30 ; $67f5
	jr c, .advance ; $67f7
	push de ; $67f9
	push hl ; $67fa
	add a ; $67fb
	add $08 ; $67fc
	ld c, a ; $67fe
	call QueueSprite ; $67ff
	pop hl ; $6802
	pop de ; $6803
.advance:
	ld a, d ; $6804
	add $08 ; $6805
	ld d, a ; $6807
	ret ; $6808
MinigameTargetOpHandlers_0a:
	; $6809, 18 bytes (records:2)
	dw MinigameTargetOp_00 ; record 0
	dw MinigameTargetOp_01 ; record 1
	dw MinigameTargetOp_02 ; record 2
	dw MinigameTargetOp_03 ; record 3
	dw MinigameTargetOp_04 ; record 4
	dw MinigameTargetOp_05 ; record 5
	dw MinigameTargetOp_06 ; record 6
	dw MinigameTargetOp_07 ; record 7
	dw MinigameTargetOp_08 ; record 8
MinigameTargetOp_00:
	xor a ; $681b
	ret ; $681c
MinigameTargetOp_01:
	inc de ; $681d
	ld a, [de] ; $681e
	inc de ; $681f
	dec a ; $6820
	ld [wMinigameTargetWork + 3], a ; $6821
	xor a ; $6824
	ret ; $6825
MinigameTargetOp_02:
	inc de ; $6826
	ld l, e ; $6827
	ld h, d ; $6828
	ld a, [hl+] ; $6829
	ld e, a ; $682a
	ld a, [hl-] ; $682b
	ld d, a ; $682c
	add hl, de ; $682d
	ld e, l ; $682e
	ld d, h ; $682f
	ld a, $01 ; $6830
	ret ; $6832
MinigameTargetOp_03:
	inc de ; $6833
	ld a, [de] ; $6834
	ld l, a ; $6835
	inc de ; $6836
	ld a, [de] ; $6837
	ld h, a ; $6838
	inc de ; $6839
	push de ; $683a
	call JumpToHL ; $683b
	pop de ; $683e
	ret ; $683f
MinigameTargetOp_04:
	ld hl, wMinigameTargetWork ; $6840
	bit 1, [hl] ; $6843
	jr nz, .apply ; $6845
	inc de ; $6847
	ld a, $01 ; $6848
	ret ; $684a
.apply:
	xor a ; $684b
	ret ; $684c
MinigameTargetOp_05:
	inc de ; $684d
	ld l, e ; $684e
	ld h, d ; $684f
	ld de, wMinigameTargetWork + 6 ; $6850
	ld a, [hl+] ; $6853
	ld [de], a ; $6854
	inc de ; $6855
	ld a, [hl+] ; $6856
	ld [de], a ; $6857
	inc de ; $6858
	ld a, [hl+] ; $6859
	ld [de], a ; $685a
	inc de ; $685b
	ld a, [hl+] ; $685c
	ld [de], a ; $685d
	inc de ; $685e
	ld e, l ; $685f
	ld d, h ; $6860
	ld hl, wMinigameTargetWork ; $6861
	res 1, [hl] ; $6864
	ld a, $01 ; $6866
	ret ; $6868
MinigameTargetOp_06:
	inc de ; $6869
	ld a, [de] ; $686a
	ld b, a ; $686b
	inc de ; $686c
	ld a, [de] ; $686d
	ld l, a ; $686e
	inc de ; $686f
	ld a, [de] ; $6870
	ld h, a ; $6871
	inc de ; $6872
	push de ; $6873
	ld a, b ; $6874
	call VectorFromLengthAndAngle ; $6875
	ld c, l ; $6878
	ld b, h ; $6879
	ld hl, wMinigameTargetWork + 6 ; $687a
	ld a, [hl+] ; $687d
	ld h, [hl] ; $687e
	ld l, a ; $687f
	add hl, bc ; $6880
	ld c, l ; $6881
	ld b, h ; $6882
	ld hl, wMinigameTargetWork + 10 ; $6883
	ld a, c ; $6886
	ld [hl+], a ; $6887
	ld [hl], b ; $6888
	ld hl, wMinigameTargetWork + 8 ; $6889
	ld a, [hl+] ; $688c
	ld h, [hl] ; $688d
	ld l, a ; $688e
	add hl, de ; $688f
	ld e, l ; $6890
	ld d, h ; $6891
	ld hl, wMinigameTargetWork + 12 ; $6892
	ld a, e ; $6895
	ld [hl+], a ; $6896
	ld [hl], d ; $6897
	pop de ; $6898
	ld hl, wMinigameTargetWork ; $6899
	set 1, [hl] ; $689c
	ld a, $01 ; $689e
	ret ; $68a0
MinigameTargetOp_07:
	inc de ; $68a1
	ld a, [de] ; $68a2
	inc de ; $68a3
	ld [wMinigameTargetWork + 1], a ; $68a4
	ld a, $01 ; $68a7
	ret ; $68a9
MinigameTargetOp_08:
	inc de ; $68aa
	ld a, [de] ; $68ab
	inc de ; $68ac
	ld hl, wMinigameTargetWork + 1 ; $68ad
	add [hl] ; $68b0
	and $03 ; $68b1
	ld [hl], a ; $68b3
	ld a, $01 ; $68b4
	ret ; $68b6
RunMinigameTargetScript:
	ld hl, wMinigameTargetWork + 3 ; $68b7
	ld a, [hl] ; $68ba
	and a ; $68bb
	jr z, .runScript ; $68bc
	dec [hl] ; $68be
	ret ; $68bf
.runScript:
	ld hl, wMinigameTargetWork + 4 ; $68c0
	ld a, [hl+] ; $68c3
	ld d, [hl] ; $68c4
	ld e, a ; $68c5
.dispatchOp:
	ld hl, MinigameTargetScriptOpReturn ; $68c6
	push hl ; $68c9
	ld a, [de] ; $68ca
	add a ; $68cb
	ld_hl_indexed MinigameTargetOpHandlers_0a ; $68cc
	ld a, [hl+] ; $68d3
	ld h, [hl] ; $68d4
	ld l, a ; $68d5
	jp hl ; $68d6
MinigameTargetScriptOpReturn:
	ld hl, wMinigameTargetWork + 4 ; $68d7
	ld [hl], e ; $68da
	inc hl ; $68db
	ld [hl], d ; $68dc
	and a ; $68dd
	jr nz, RunMinigameTargetScript.dispatchOp ; $68de
	ret ; $68e0
MinigameTargetFormation0Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation0Script0.bin" ; $68e1, 10 bytes
MinigameTargetFormation0Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation0Script1.bin" ; $68eb, 10 bytes
MinigameTargetFormation0Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation0Script2.bin" ; $68f5, 10 bytes
MinigameTargetFormation0Script3:
	INCBIN "data/bank_00a/MinigameTargetFormation0Script3.bin" ; $68ff, 33 bytes
MinigameTargetFormation1Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script0.bin" ; $6920, 10 bytes
MinigameTargetFormation1Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script1.bin" ; $692a, 10 bytes
MinigameTargetFormation1Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script2.bin" ; $6934, 10 bytes
MinigameTargetFormation1Script3:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script3.bin" ; $693e, 10 bytes
MinigameTargetFormation1Script4:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script4.bin" ; $6948, 10 bytes
MinigameTargetFormation1Script5:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script5.bin" ; $6952, 10 bytes
MinigameTargetFormation1Script6:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script6.bin" ; $695c, 10 bytes
MinigameTargetFormation1Script7:
	INCBIN "data/bank_00a/MinigameTargetFormation1Script7.bin" ; $6966, 33 bytes
MinigameTargetFormation2Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script0.bin" ; $6987, 10 bytes
MinigameTargetFormation2Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script1.bin" ; $6991, 10 bytes
MinigameTargetFormation2Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script2.bin" ; $699b, 10 bytes
MinigameTargetFormation2Script3:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script3.bin" ; $69a5, 10 bytes
MinigameTargetFormation2Script4:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script4.bin" ; $69af, 10 bytes
MinigameTargetFormation2Script5:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script5.bin" ; $69b9, 10 bytes
MinigameTargetFormation2Script6:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script6.bin" ; $69c3, 10 bytes
MinigameTargetFormation2Script7:
	INCBIN "data/bank_00a/MinigameTargetFormation2Script7.bin" ; $69cd, 144 bytes
MinigameTargetFormation3Script00:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script00.bin" ; $6a5d, 10 bytes
MinigameTargetFormation3Script01:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script01.bin" ; $6a67, 10 bytes
MinigameTargetFormation3Script02:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script02.bin" ; $6a71, 10 bytes
MinigameTargetFormation3Script03:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script03.bin" ; $6a7b, 10 bytes
MinigameTargetFormation3Script04:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script04.bin" ; $6a85, 10 bytes
MinigameTargetFormation3Script05:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script05.bin" ; $6a8f, 10 bytes
MinigameTargetFormation3Script06:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script06.bin" ; $6a99, 10 bytes
MinigameTargetFormation3Script07:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script07.bin" ; $6aa3, 10 bytes
MinigameTargetFormation3Script08:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script08.bin" ; $6aad, 10 bytes
MinigameTargetFormation3Script09:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script09.bin" ; $6ab7, 10 bytes
MinigameTargetFormation3Script10:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script10.bin" ; $6ac1, 10 bytes
MinigameTargetFormation3Script11:
	INCBIN "data/bank_00a/MinigameTargetFormation3Script11.bin" ; $6acb, 70 bytes
MinigameTargetFormation4Script00:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script00.bin" ; $6b11, 10 bytes
MinigameTargetFormation4Script01:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script01.bin" ; $6b1b, 10 bytes
MinigameTargetFormation4Script02:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script02.bin" ; $6b25, 10 bytes
MinigameTargetFormation4Script03:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script03.bin" ; $6b2f, 10 bytes
MinigameTargetFormation4Script04:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script04.bin" ; $6b39, 10 bytes
MinigameTargetFormation4Script05:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script05.bin" ; $6b43, 10 bytes
MinigameTargetFormation4Script06:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script06.bin" ; $6b4d, 10 bytes
MinigameTargetFormation4Script07:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script07.bin" ; $6b57, 10 bytes
MinigameTargetFormation4Script08:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script08.bin" ; $6b61, 10 bytes
MinigameTargetFormation4Script09:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script09.bin" ; $6b6b, 10 bytes
MinigameTargetFormation4Script10:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script10.bin" ; $6b75, 10 bytes
MinigameTargetFormation4Script11:
	INCBIN "data/bank_00a/MinigameTargetFormation4Script11.bin" ; $6b7f, 42 bytes
MinigameTargetFormation5Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation5Script0.bin" ; $6ba9, 10 bytes
MinigameTargetFormation5Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation5Script1.bin" ; $6bb3, 35 bytes
MinigameTargetFormation6Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation6Script0.bin" ; $6bd6, 10 bytes
MinigameTargetFormation6Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation6Script1.bin" ; $6be0, 10 bytes
MinigameTargetFormation6Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation6Script2.bin" ; $6bea, 38 bytes
MinigameTargetFormation7Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation7Script0.bin" ; $6c10, 10 bytes
MinigameTargetFormation7Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation7Script1.bin" ; $6c1a, 10 bytes
MinigameTargetFormation7Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation7Script2.bin" ; $6c24, 10 bytes
MinigameTargetFormation7Script3:
	INCBIN "data/bank_00a/MinigameTargetFormation7Script3.bin" ; $6c2e, 37 bytes
MinigameTargetFormation8Script0:
	INCBIN "data/bank_00a/MinigameTargetFormation8Script0.bin" ; $6c53, 10 bytes
MinigameTargetFormation8Script1:
	INCBIN "data/bank_00a/MinigameTargetFormation8Script1.bin" ; $6c5d, 10 bytes
MinigameTargetFormation8Script2:
	INCBIN "data/bank_00a/MinigameTargetFormation8Script2.bin" ; $6c67, 10 bytes
MinigameTargetFormation8Script3:
	INCBIN "data/bank_00a/MinigameTargetFormation8Script3.bin" ; $6c71, 10 bytes
SpawnMinigameTargetFormation:
	ld a, a ; $6c7b
	rst Rst00 ; $6c7c
	dw SpawnMinigameTargetFormation0 ; $6c7d jumptable
	dw SpawnMinigameTargetFormation1 ; $6c7f jumptable
	dw SpawnMinigameTargetFormation2 ; $6c81 jumptable
	dw SpawnMinigameTargetFormation3 ; $6c83 jumptable
	dw SpawnMinigameTargetFormation4 ; $6c85 jumptable
	dw SpawnMinigameTargetFormation5 ; $6c87 jumptable
	dw SpawnMinigameTargetFormation6 ; $6c89 jumptable
	dw SpawnMinigameTargetFormation7 ; $6c8b jumptable
	dw SpawnMinigameTargetFormation8 ; $6c8d jumptable
SpawnMinigameTargetFormation0:
	ld hl, MinigameTargetFormation0ScriptPtrs ; $6c8f
	call SpawnMinigameTargetsFromList ; $6c92
	ret ; $6c95
MinigameTargetFormation0ScriptPtrs:
	; $6c96, 10 bytes (records:2)
	dw MinigameTargetFormation0Script0 ; record 0
	dw MinigameTargetFormation0Script1 ; record 1
	dw MinigameTargetFormation0Script2 ; record 2
	dw MinigameTargetFormation0Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetFormation1:
	ld hl, MinigameTargetFormation1ScriptPtrs ; $6ca0
	call SpawnMinigameTargetsFromList ; $6ca3
	ret ; $6ca6
MinigameTargetFormation1ScriptPtrs:
	; $6ca7, 18 bytes (records:2)
	dw MinigameTargetFormation1Script0 ; record 0
	dw MinigameTargetFormation1Script1 ; record 1
	dw MinigameTargetFormation1Script2 ; record 2
	dw MinigameTargetFormation1Script3 ; record 3
	dw MinigameTargetFormation1Script4 ; record 4
	dw MinigameTargetFormation1Script5 ; record 5
	dw MinigameTargetFormation1Script6 ; record 6
	dw MinigameTargetFormation1Script7 ; record 7
	dw $0000 ; record 8
SpawnMinigameTargetFormation2:
	ld hl, MinigameTargetFormation2ScriptPtrs ; $6cb9
	call SpawnMinigameTargetsFromList ; $6cbc
	ret ; $6cbf
MinigameTargetFormation2ScriptPtrs:
	; $6cc0, 18 bytes (records:2)
	dw MinigameTargetFormation2Script0 ; record 0
	dw MinigameTargetFormation2Script1 ; record 1
	dw MinigameTargetFormation2Script2 ; record 2
	dw MinigameTargetFormation2Script3 ; record 3
	dw MinigameTargetFormation2Script4 ; record 4
	dw MinigameTargetFormation2Script5 ; record 5
	dw MinigameTargetFormation2Script6 ; record 6
	dw MinigameTargetFormation2Script7 ; record 7
	dw $0000 ; record 8
SpawnMinigameTargetFormation3:
	ld hl, MinigameTargetFormation3ScriptPtrs ; $6cd2
	call SpawnMinigameTargetsFromList ; $6cd5
	ret ; $6cd8
MinigameTargetFormation3ScriptPtrs:
	; $6cd9, 26 bytes (records:2)
	dw MinigameTargetFormation3Script00 ; record 0
	dw MinigameTargetFormation3Script01 ; record 1
	dw MinigameTargetFormation3Script02 ; record 2
	dw MinigameTargetFormation3Script03 ; record 3
	dw MinigameTargetFormation3Script04 ; record 4
	dw MinigameTargetFormation3Script05 ; record 5
	dw MinigameTargetFormation3Script06 ; record 6
	dw MinigameTargetFormation3Script07 ; record 7
	dw MinigameTargetFormation3Script08 ; record 8
	dw MinigameTargetFormation3Script09 ; record 9
	dw MinigameTargetFormation3Script10 ; record 10
	dw MinigameTargetFormation3Script11 ; record 11
	dw $0000 ; record 12
SpawnMinigameTargetFormation4:
	ld hl, MinigameTargetFormation4ScriptPtrs ; $6cf3
	call SpawnMinigameTargetsFromList ; $6cf6
	ret ; $6cf9
MinigameTargetFormation4ScriptPtrs:
	; $6cfa, 26 bytes (records:2)
	dw MinigameTargetFormation4Script00 ; record 0
	dw MinigameTargetFormation4Script01 ; record 1
	dw MinigameTargetFormation4Script02 ; record 2
	dw MinigameTargetFormation4Script03 ; record 3
	dw MinigameTargetFormation4Script04 ; record 4
	dw MinigameTargetFormation4Script05 ; record 5
	dw MinigameTargetFormation4Script06 ; record 6
	dw MinigameTargetFormation4Script07 ; record 7
	dw MinigameTargetFormation4Script08 ; record 8
	dw MinigameTargetFormation4Script09 ; record 9
	dw MinigameTargetFormation4Script10 ; record 10
	dw MinigameTargetFormation4Script11 ; record 11
	dw $0000 ; record 12
SpawnMinigameTargetFormation5:
	ld hl, MinigameTargetFormation5ScriptPtrs ; $6d14
	call SpawnMinigameTargetsFromList ; $6d17
	ret ; $6d1a
MinigameTargetFormation5ScriptPtrs:
	; $6d1b, 6 bytes (records:2)
	dw MinigameTargetFormation5Script0 ; record 0
	dw MinigameTargetFormation5Script1 ; record 1
	dw $0000 ; record 2
SpawnMinigameTargetFormation6:
	ld hl, MinigameTargetFormation6ScriptPtrs ; $6d21
	call SpawnMinigameTargetsFromList ; $6d24
	ret ; $6d27
MinigameTargetFormation6ScriptPtrs:
	; $6d28, 8 bytes (records:2)
	dw MinigameTargetFormation6Script0 ; record 0
	dw MinigameTargetFormation6Script1 ; record 1
	dw MinigameTargetFormation6Script2 ; record 2
	dw $0000 ; record 3
SpawnMinigameTargetFormation7:
	ld hl, MinigameTargetFormation7ScriptPtrs ; $6d30
	call SpawnMinigameTargetsFromList ; $6d33
	ret ; $6d36
MinigameTargetFormation7ScriptPtrs:
	; $6d37, 10 bytes (records:2)
	dw MinigameTargetFormation7Script0 ; record 0
	dw MinigameTargetFormation7Script1 ; record 1
	dw MinigameTargetFormation7Script2 ; record 2
	dw MinigameTargetFormation7Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetFormation8:
	ld hl, MinigameTargetFormation8ScriptPtrs ; $6d41
	call SpawnMinigameTargetsFromList ; $6d44
	ret ; $6d47
MinigameTargetFormation8ScriptPtrs:
	; $6d48, 10 bytes (records:2)
	dw MinigameTargetFormation8Script0 ; record 0
	dw MinigameTargetFormation8Script1 ; record 1
	dw MinigameTargetFormation8Script2 ; record 2
	dw MinigameTargetFormation8Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetsFromList:
	ld bc, wMinigameTargets ; $6d52
.spawnLoop:
	ld a, [hl+] ; $6d55
	ld e, a ; $6d56
	ld a, [hl+] ; $6d57
	ld d, a ; $6d58
	ld a, d ; $6d59
	or e ; $6d5a
	jr z, .done ; $6d5b
	push bc ; $6d5d
	push hl ; $6d5e
	call ActivateMinigameTarget ; $6d5f
	pop hl ; $6d62
	pop bc ; $6d63
	ld a, $0e ; $6d64
	add c ; $6d66
	ld c, a ; $6d67
	jr nc, .next ; $6d68
	inc b ; $6d6a
.next:
	jr .spawnLoop ; $6d6b
.done:
	ret ; $6d6d
DrawMinigameTargetAlt:
	ld hl, wMinigameTargetWork + 8 ; $6d6e
	ld a, [hl+] ; $6d71
	ld b, [hl] ; $6d72
	ld c, a ; $6d73
	ld hl, wMinigameTargetWork + 6 ; $6d74
	ld a, [hl+] ; $6d77
	ld h, [hl] ; $6d78
	ld l, a ; $6d79
	farcall ApplyCameraProjection ; $6d7a
	ld c, e ; $6d7d
	ld b, d ; $6d7e
	ld a, [wMinigameTargetWork + 2] ; $6d7f
	and $0f ; $6d82
	jr z, .readSprite ; $6d84
	ld_hl_indexed DrawMinigameTargetAltTable ; $6d86
	ld a, [hl] ; $6d8d
	add d ; $6d8e
	ld d, a ; $6d8f
.readSprite:
	ld a, [wMinigameTargetWork + 1] ; $6d90
	add a ; $6d93
	ld_hl_indexed MinigameTargetAltTable ; $6d94
	ld a, [hl+] ; $6d9b
	ld b, [hl] ; $6d9c
	ld c, a ; $6d9d
	ld hl, DrawMinigameTargetAlt_SpriteTemplate ; $6d9e
	call QueueSpriteTemplate ; $6da1
	ret ; $6da4
MinigameTargetAltTable:
	; $6da5, 8 bytes (bytes:8)
	db $10, $0f, $20, $0e, $30, $0d, $20, $0f ; 0x00
DrawMinigameTargetAltTable:
	INCBIN "data/bank_00a/DrawMinigameTargetAltTable.bin" ; $6dad, 16 bytes
DrawMinigameTargetAlt_SpriteTemplate:
	; $6dbd, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
HandleMinigameTargetHitAlt:
	ld hl, wMinigameTargetWork ; $6dde
	bit 2, [hl] ; $6de1
	ret z ; $6de3
	res 2, [hl] ; $6de4
	sound SFX_CHIME ; $6de6
	ld a, $20 ; $6de8
	ld [wMinigameTargetWork + 2], a ; $6dea
	ld a, [wMinigameTargetWork + 1] ; $6ded
	ld [wMinigameHitTargetType], a ; $6df0
	ret ; $6df3
