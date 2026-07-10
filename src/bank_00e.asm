INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

	INCBIN "data/bank_00e/d_4000.bin" ; $4000, 583 bytes
	rst Rst18 ; $4247
	ld a, [hl] ; $4248
	ld a, [bc] ; $4249
	push af ; $424a
	ld a, $02 ; $424b
	rst Rst18 ; $424d
	inc b ; $424e
	ld a, [bc] ; $424f
	pop af ; $4250
	ld b, $37 ; $4251
	ld c, $0a ; $4253
	ld d, $14 ; $4255
	ld e, $0a ; $4257
	ld h, $02 ; $4259
	ld l, $02 ; $425b
	rst Rst18 ; $425d
	ld a, [hl] ; $425e
	ld a, [bc] ; $425f
	push af ; $4260
	ld a, $02 ; $4261
	rst Rst18 ; $4263
	inc b ; $4264
	ld a, [bc] ; $4265
	pop af ; $4266
	ld b, $3d ; $4267
	ld c, $0c ; $4269
	ld d, $14 ; $426b
	ld e, $0a ; $426d
	ld h, $02 ; $426f
	ld l, $02 ; $4271
	rst Rst18 ; $4273
	ld a, [hl] ; $4274
	ld a, [bc] ; $4275
	ret ; $4276
	INCBIN "data/bank_00e/d_4277.bin" ; $4277, 2961 bytes
	rst Rst18 ; $4e08
	ld c, $0a ; $4e09
	jr Label_0e_4e26 ; $4e0b
	INCBIN "data/bank_00e/d_4e0d.bin" ; $4e0d, 25 bytes
Label_0e_4e26:
	ld a, $00 ; $4e26
	ld b, a ; $4e28
	ld a, $0e ; $4e29
	rst Rst18 ; $4e2b
	jr nc, Label_0e_4e38 ; $4e2c
	ld a, $0e ; $4e2e
	rst Rst18 ; $4e30
	ld a, [bc] ; $4e31
	ld a, [bc] ; $4e32
	rst Rst18 ; $4e33
	ld [de], a ; $4e34
	ld a, [bc] ; $4e35
	rst Rst18 ; $4e36
	inc c ; $4e37
Label_0e_4e38:
	ld a, [bc] ; $4e38
	push af ; $4e39
	ld a, $05 ; $4e3a
	rst Rst18 ; $4e3c
	inc b ; $4e3d
	ld a, [bc] ; $4e3e
	pop af ; $4e3f
	and a, a ; $4e40
	jr z, Label_0e_4e4f ; $4e41
Label_0e_4e43:
	ld hl, $20ea ; $4e43
	rst Rst18 ; $4e46
	ld c, $0a ; $4e47
	ld a, $0e ; $4e49
	rst Rst18 ; $4e4b
	ld [$c90a], sp ; $4e4c
Label_0e_4e4f:
	ld hl, $20eb ; $4e4f
	rst Rst18 ; $4e52
	ld c, $0a ; $4e53
	ld a, $0e ; $4e55
	rst Rst18 ; $4e57
	ld [$f50a], sp ; $4e58
	ld a, $05 ; $4e5b
	rst Rst18 ; $4e5d
	inc b ; $4e5e
	ld a, [bc] ; $4e5f
	pop af ; $4e60
Label_0e_4e61:
	ld hl, $20ec ; $4e61
	ld de, $0101 ; $4e64
	rst Rst18 ; $4e67
	ld b, [hl] ; $4e68
	ld a, [bc] ; $4e69
	ld [$c2bc], a ; $4e6a
	cp a, $ff ; $4e6d
	jp z, Label_0e_4e43 ; $4e6f
	cp a, $02 ; $4e72
	jp z, Label_0e_4e43 ; $4e74
	cp a, $00 ; $4e77
	jp z, Label_0e_4ee9 ; $4e79
	rst Rst30 ; $4e7c
	ldh [$ff0a], a ; $4e7d
	jp nz, Label_0e_4eff ; $4e7f
	ld hl, $20e8 ; $4e82
	rst Rst18 ; $4e85
	ld c, $0a ; $4e86
	ld a, $0e ; $4e88
	rst Rst18 ; $4e8a
	ld [$210a], sp ; $4e8b
	ldh a, [c] ; $4e8e
	jr nz, $4e70 ; $4e8f
	ld c, $0a ; $4e91
	ld a, $0e ; $4e93
	rst Rst18 ; $4e95
	ld a, [bc] ; $4e96
	ld a, [bc] ; $4e97
	rst Rst18 ; $4e98
	ld [de], a ; $4e99
	ld a, [bc] ; $4e9a
	rst Rst18 ; $4e9b
	inc c ; $4e9c
	ld a, [bc] ; $4e9d
	push af ; $4e9e
	ld a, $05 ; $4e9f
	rst Rst18 ; $4ea1
	inc b ; $4ea2
	ld a, [bc] ; $4ea3
	pop af ; $4ea4
	and a, a ; $4ea5
	jr z, Label_0e_4e61 ; $4ea6
	jr Label_0e_4e43 ; $4ea8
	INCBIN "data/bank_00e/d_4eaa.bin" ; $4eaa, 63 bytes
Label_0e_4ee9:
	ld hl, $20ed ; $4ee9
	rst Rst18 ; $4eec
	ld c, $0a ; $4eed
	ld a, $0e ; $4eef
	rst Rst18 ; $4ef1
	ld [$cd0a], sp ; $4ef2
	or a, d ; $4ef5
	ld c, [hl] ; $4ef6
	rst Rst18 ; $4ef7
	inc c ; $4ef8
	ld a, $a7 ; $4ef9
	jr nz, Label_0e_4f1d ; $4efb
	jr Func_0e_4f13 ; $4efd
Label_0e_4eff:
	ld hl, $20ee ; $4eff
	rst Rst18 ; $4f02
	ld c, $0a ; $4f03
	ld a, $0e ; $4f05
	rst Rst18 ; $4f07
	ld [$cd0a], sp ; $4f08
	or a, d ; $4f0b
	ld c, [hl] ; $4f0c
	rst Rst18 ; $4f0d
	ld c, $3e ; $4f0e
	and a, a ; $4f10
	jr nz, Label_0e_4f1d ; $4f11
Func_0e_4f13:
	call DisableLCDSafely ; $4f13
	rst Rst18 ; $4f16
	ld a, [bc] ; $4f17
	ld bc, $76cd ; $4f18
	inc bc ; $4f1b
	ret ; $4f1c
Label_0e_4f1d:
	ld a, [$c2b1] ; $4f1d
	add a, $02 ; $4f20
	ld [$c2b1], a ; $4f22
	ld a, $11 ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [$c2b1] ; $4f2a
	ld [$c295], a ; $4f2d
	ld a, $ff ; $4f30
	ld [$c294], a ; $4f32
	ld [$c2a1], a ; $4f35
	call Func_0e_4f13 ; $4f38
	ret ; $4f3b
	INCBIN "data/bank_00e/d_4f3c.bin" ; $4f3c, 1245 bytes
	rst Rst18 ; $5419
	ld c, $0a ; $541a
	ld a, $10 ; $541c
	rst Rst18 ; $541e
	ld [$c90a], sp ; $541f
	ld hl, $30a3 ; $5422
	ld a, [$c2b0] ; $5425
	add a, l ; $5428
	ld l, a ; $5429
	jr nc, Label_0e_542d ; $542a
	inc h ; $542c
Label_0e_542d:
	rst Rst18 ; $542d
	ld c, $0a ; $542e
	ld a, $0e ; $5430
	rst Rst18 ; $5432
	ld [$c90a], sp ; $5433
	ld hl, $30a7 ; $5436
	rst Rst18 ; $5439
	ld c, $0a ; $543a
	ld a, $13 ; $543c
	rst Rst18 ; $543e
	ld [$c90a], sp ; $543f
	ld hl, $30a8 ; $5442
	rst Rst18 ; $5445
	ld c, $0a ; $5446
	ld a, $14 ; $5448
	rst Rst18 ; $544a
	ld [$c90a], sp ; $544b
	ld [$0010], sp ; $544e
	nop ; $5451
	and a, h ; $5452
	ld h, h ; $5453
	nop ; $5454
	nop ; $5455
	ld [$0020], sp ; $5456
	nop ; $5459
	ld c, a ; $545a
	ld h, l ; $545b
	nop ; $545c
	nop ; $545d
	ld [$0040], sp ; $545e
	nop ; $5461
	INCBIN "data/bank_00e/d_5462.bin" ; $5462, 443 bytes
	rst Rst18 ; $561d
	inc [hl] ; $561e
	ld a, [bc] ; $561f
	ld a, $08 ; $5620
	rst Rst18 ; $5622
	ld [hl], $0a ; $5623
	rst Rst30 ; $5625
	ret nz ; $5626
	dec c ; $5627
	jr nz, Label_0e_562f ; $5628
	ld a, $08 ; $562a
	rst Rst18 ; $562c
	INCBIN "data/bank_00e/d_562d.bin" ; $562d, 2 bytes
Label_0e_562f:
	ld bc, $0014 ; $562f
	rst Rst18 ; $5632
	jr c, Label_0e_563f ; $5633
	ld a, $00 ; $5635
	ld bc, $0014 ; $5637
	rst Rst18 ; $563a
	jr Label_0e_5647 ; $563b
	INCBIN "data/bank_00e/d_563d.bin" ; $563d, 2 bytes
Label_0e_563f:
	ld bc, $0014 ; $563f
	rst Rst18 ; $5642
	jr Label_0e_564f ; $5643
	INCBIN "data/bank_00e/d_5645.bin" ; $5645, 2 bytes
Label_0e_5647:
	ld bc, $0014 ; $5647
	rst Rst18 ; $564a
	jr Label_0e_5657 ; $564b
	INCBIN "data/bank_00e/d_564d.bin" ; $564d, 2 bytes
Label_0e_564f:
	ld bc, $1200 ; $564f
	ld de, $1100 ; $5652
	rst Rst18 ; $5655
	inc h ; $5656
Label_0e_5657:
	ld a, [bc] ; $5657
	ld a, $13 ; $5658
	ld bc, $1200 ; $565a
	ld de, $1700 ; $565d
	rst Rst18 ; $5660
	inc h ; $5661
	ld a, [bc] ; $5662
	push af ; $5663
	ld a, $28 ; $5664
	rst Rst18 ; $5666
	inc b ; $5667
	ld a, [bc] ; $5668
	pop af ; $5669
	xor a, a ; $566a
	ld bc, $1200 ; $566b
	ld de, $0d00 ; $566e
	rst Rst18 ; $5671
	ld a, [hl-] ; $5672
	ld a, [bc] ; $5673
	ld a, $13 ; $5674
	rst Rst18 ; $5676
	jr nz, Label_0e_5683 ; $5677
	ld a, $08 ; $5679
	ld bc, $1200 ; $567b
	ld de, $0900 ; $567e
	rst Rst18 ; $5681
	inc h ; $5682
Label_0e_5683:
	ld a, [bc] ; $5683
	ld a, $13 ; $5684
	ld bc, $1200 ; $5686
	ld de, $1300 ; $5689
	rst Rst18 ; $568c
	inc h ; $568d
	ld a, [bc] ; $568e
	ld a, $13 ; $568f
	rst Rst18 ; $5691
	jr nz, Label_0e_569e ; $5692
	ld a, $13 ; $5694
	ld bc, $0d00 ; $5696
	ld de, $1300 ; $5699
	rst Rst18 ; $569c
	inc h ; $569d
Label_0e_569e:
	ld a, [bc] ; $569e
	ld a, $08 ; $569f
	rst Rst18 ; $56a1
	jr nz, Label_0e_56ae ; $56a2
	rst Rst30 ; $56a4
	ret nz ; $56a5
	dec c ; $56a6
	jr z, Label_0e_56c0 ; $56a7
	ld a, $08 ; $56a9
	ld b, $40 ; $56ab
	rst Rst18 ; $56ad
Label_0e_56ae:
	ld l, $0a ; $56ae
	push af ; $56b0
	ld a, $14 ; $56b1
	rst Rst18 ; $56b3
	inc b ; $56b4
	ld a, [bc] ; $56b5
Label_0e_56b6:
	pop af ; $56b6
	ld a, $01 ; $56b7
	ld [$c294], a ; $56b9
	ld [$c2a1], a ; $56bc
	ret ; $56bf
Label_0e_56c0:
	call Func_0e_6ad4 ; $56c0
	ld a, $0f ; $56c3
	ld bc, $0020 ; $56c5
	rst Rst18 ; $56c8
	jr Label_0e_56d5 ; $56c9
	INCBIN "data/bank_00e/d_56cb.bin" ; $56cb, 10 bytes
Label_0e_56d5:
	jr z, Label_0e_56b6 ; $56d5
	inc b ; $56d7
	ld a, [bc] ; $56d8
	pop af ; $56d9
	ld a, $0f ; $56da
	ld d, $02 ; $56dc
	rst Rst18 ; $56de
	inc [hl] ; $56df
	ld a, [bc] ; $56e0
	ld a, $0f ; $56e1
	rst Rst18 ; $56e3
	ld [hl], $0a ; $56e4
	ld a, $0f ; $56e6
	ld bc, $0f00 ; $56e8
	ld de, $0e00 ; $56eb
	rst Rst18 ; $56ee
	inc h ; $56ef
	ld a, [bc] ; $56f0
	ld a, $07 ; $56f1
	ld bc, $1000 ; $56f3
	ld de, $0c00 ; $56f6
	rst Rst18 ; $56f9
	inc h ; $56fa
	ld a, [bc] ; $56fb
	ld a, $07 ; $56fc
	rst Rst18 ; $56fe
	jr nz, Label_0e_570b ; $56ff
	ld a, $07 ; $5701
	ld bc, $3f00 ; $5703
	ld de, $3f00 ; $5706
	rst Rst18 ; $5709
	ld [hl+], a ; $570a
Label_0e_570b:
	ld a, [bc] ; $570b
	ld a, $0f ; $570c
	ld b, $c0 ; $570e
	rst Rst18 ; $5710
	ld l, $0a ; $5711
	push af ; $5713
	ld a, $14 ; $5714
	rst Rst18 ; $5716
	inc b ; $5717
	ld a, [bc] ; $5718
	pop af ; $5719
	ld a, $0f ; $571a
	rst Rst18 ; $571c
	ld [$f50a], sp ; $571d
	ld a, $14 ; $5720
	rst Rst18 ; $5722
	inc b ; $5723
	ld a, [bc] ; $5724
	pop af ; $5725
	ld a, $10 ; $5726
	ld bc, $0020 ; $5728
	rst Rst18 ; $572b
	jr Label_0e_5738 ; $572c
	INCBIN "data/bank_00e/d_572e.bin" ; $572e, 10 bytes
Label_0e_5738:
	ld bc, $1000 ; $5738
	ld de, $0d00 ; $573b
	rst Rst18 ; $573e
	inc h ; $573f
	ld a, [bc] ; $5740
	ld a, $0f ; $5741
	rst Rst18 ; $5743
	jr nz, Label_0e_5750 ; $5744
	push af ; $5746
	ld a, $0a ; $5747
	rst Rst18 ; $5749
	inc b ; $574a
	ld a, [bc] ; $574b
	pop af ; $574c
	ld a, $10 ; $574d
	INCBIN "data/bank_00e/d_574f.bin" ; $574f, 1 bytes
Label_0e_5750:
	nop ; $5750
	rst Rst18 ; $5751
	ld l, $0a ; $5752
	ld a, $10 ; $5754
	ld bc, $0d00 ; $5756
	ld de, $0d00 ; $5759
	rst Rst18 ; $575c
	inc h ; $575d
	ld a, [bc] ; $575e
	ld a, $10 ; $575f
	rst Rst18 ; $5761
	jr nz, Label_0e_576e ; $5762
	ld a, $10 ; $5764
	ld b, $c0 ; $5766
	rst Rst18 ; $5768
	ld l, $0a ; $5769
	push af ; $576b
	ld a, $0a ; $576c
Label_0e_576e:
	rst Rst18 ; $576e
	inc b ; $576f
	ld a, [bc] ; $5770
	pop af ; $5771
	ld a, $0e ; $5772
	ld b, $00 ; $5774
	rst Rst18 ; $5776
	ld l, $0a ; $5777
	ld a, $0e ; $5779
	ld bc, $0e00 ; $577b
	ld de, $1000 ; $577e
	rst Rst18 ; $5781
	inc h ; $5782
	ld a, [bc] ; $5783
	ld a, $0e ; $5784
	rst Rst18 ; $5786
	jr nz, Label_0e_5793 ; $5787
	ld a, $0e ; $5789
	ld b, $c0 ; $578b
	rst Rst18 ; $578d
	ld l, $0a ; $578e
	push af ; $5790
	ld a, $28 ; $5791
Label_0e_5793:
	rst Rst18 ; $5793
	inc b ; $5794
	ld a, [bc] ; $5795
	pop af ; $5796
	rst Rst08 ; $5797
	sub a, [hl] ; $5798
	ld a, $04 ; $5799
	ld bc, $0f00 ; $579b
	ld de, $0900 ; $579e
	rst Rst18 ; $57a1
	ld [hl+], a ; $57a2
	ld a, [bc] ; $57a3
	push af ; $57a4
	ld a, $04 ; $57a5
	rst Rst18 ; $57a7
	inc b ; $57a8
	ld a, [bc] ; $57a9
	pop af ; $57aa
	rst Rst08 ; $57ab
	sub a, [hl] ; $57ac
	ld a, $05 ; $57ad
	ld bc, $1300 ; $57af
	ld de, $0700 ; $57b2
	rst Rst18 ; $57b5
	ld [hl+], a ; $57b6
	ld a, [bc] ; $57b7
	push af ; $57b8
	ld a, $04 ; $57b9
	rst Rst18 ; $57bb
	inc b ; $57bc
	ld a, [bc] ; $57bd
	pop af ; $57be
	rst Rst08 ; $57bf
	sub a, [hl] ; $57c0
	ld a, $06 ; $57c1
	ld bc, $1700 ; $57c3
	ld de, $0900 ; $57c6
	rst Rst18 ; $57c9
	ld [hl+], a ; $57ca
	ld a, [bc] ; $57cb
	push af ; $57cc
	ld a, $04 ; $57cd
	rst Rst18 ; $57cf
	inc b ; $57d0
	ld a, [bc] ; $57d1
	pop af ; $57d2
	ld a, $0f ; $57d3
	ld b, $00 ; $57d5
	rst Rst18 ; $57d7
	ld l, $0a ; $57d8
	ld a, $0f ; $57da
	ld bc, $1100 ; $57dc
	ld de, $0d00 ; $57df
	rst Rst18 ; $57e2
	inc h ; $57e3
	ld a, [bc] ; $57e4
	ld a, $0f ; $57e5
	rst Rst18 ; $57e7
	jr nz, Label_0e_57f4 ; $57e8
	ld a, $0f ; $57ea
	ld b, $c0 ; $57ec
	rst Rst18 ; $57ee
	ld l, $0a ; $57ef
	push af ; $57f1
	ld a, $0a ; $57f2
Label_0e_57f4:
	rst Rst18 ; $57f4
	inc b ; $57f5
	ld a, [bc] ; $57f6
	pop af ; $57f7
	ld a, $10 ; $57f8
	ld b, $00 ; $57fa
	rst Rst18 ; $57fc
	ld l, $0a ; $57fd
	ld a, $10 ; $57ff
	ld bc, $0f00 ; $5801
	ld de, $0d00 ; $5804
	rst Rst18 ; $5807
	inc h ; $5808
	ld a, [bc] ; $5809
	ld a, $10 ; $580a
	rst Rst18 ; $580c
	jr nz, Label_0e_5819 ; $580d
	ld a, $10 ; $580f
	ld b, $c0 ; $5811
	rst Rst18 ; $5813
	ld l, $0a ; $5814
	push af ; $5816
	ld a, $0a ; $5817
Label_0e_5819:
	rst Rst18 ; $5819
	inc b ; $581a
	ld a, [bc] ; $581b
	pop af ; $581c
	ld a, $0e ; $581d
	ld b, $00 ; $581f
	rst Rst18 ; $5821
	ld l, $0a ; $5822
	ld a, $0e ; $5824
	ld bc, $1100 ; $5826
	ld de, $0f00 ; $5829
	rst Rst18 ; $582c
	inc h ; $582d
	ld a, [bc] ; $582e
	ld a, $0e ; $582f
	rst Rst18 ; $5831
	jr nz, Label_0e_583e ; $5832
	ld a, $0e ; $5834
	ld b, $c0 ; $5836
	rst Rst18 ; $5838
	ld l, $0a ; $5839
	push af ; $583b
	ld a, $0a ; $583c
Label_0e_583e:
	rst Rst18 ; $583e
	inc b ; $583f
	ld a, [bc] ; $5840
	pop af ; $5841
	call Func_0e_6db7 ; $5842
	rst Rst08 ; $5845
	sub a, [hl] ; $5846
	ld a, $04 ; $5847
	ld bc, $1380 ; $5849
	ld de, $0f80 ; $584c
	rst Rst18 ; $584f
	ld [hl+], a ; $5850
	ld a, [bc] ; $5851
	push af ; $5852
	ld a, $14 ; $5853
	rst Rst18 ; $5855
	inc b ; $5856
	ld a, [bc] ; $5857
	pop af ; $5858
	ld a, $12 ; $5859
	ld b, $80 ; $585b
	rst Rst18 ; $585d
	ld l, $0a ; $585e
	push af ; $5860
	ld a, $28 ; $5861
	rst Rst18 ; $5863
	inc b ; $5864
	ld a, [bc] ; $5865
	pop af ; $5866
	ld a, $08 ; $5867
	ld d, $03 ; $5869
	rst Rst18 ; $586b
	inc [hl] ; $586c
	ld a, [bc] ; $586d
	ld a, $12 ; $586e
	ld d, $03 ; $5870
	rst Rst18 ; $5872
	inc [hl] ; $5873
	ld a, [bc] ; $5874
	ld a, $12 ; $5875
	rst Rst18 ; $5877
	ld [hl], $0a ; $5878
	push af ; $587a
	ld a, $0a ; $587b
	rst Rst18 ; $587d
	inc b ; $587e
	ld a, [bc] ; $587f
	pop af ; $5880
	ld a, $08 ; $5881
	ld b, $40 ; $5883
	rst Rst18 ; $5885
	ld l, $0a ; $5886
	push af ; $5888
	ld a, $0a ; $5889
	rst Rst18 ; $588b
	inc b ; $588c
	ld a, [bc] ; $588d
	pop af ; $588e
	ld a, $08 ; $588f
	ld bc, $0020 ; $5891
	rst Rst18 ; $5894
	jr Label_0e_58a1 ; $5895
	INCBIN "data/bank_00e/d_5897.bin" ; $5897, 10 bytes
Label_0e_58a1:
	ld a, [bc] ; $58a1
	ld a, $08 ; $58a2
	rst Rst18 ; $58a4
	jr nz, Label_0e_58b1 ; $58a5
	ld a, $11 ; $58a7
	ld b, $40 ; $58a9
	rst Rst18 ; $58ab
	ld l, $0a ; $58ac
	ld a, $12 ; $58ae
	INCBIN "data/bank_00e/d_58b0.bin" ; $58b0, 1 bytes
Label_0e_58b1:
	ld b, b ; $58b1
	rst Rst18 ; $58b2
	ld l, $0a ; $58b3
	ld a, $04 ; $58b5
	ld bc, $3f00 ; $58b7
	ld de, $3f00 ; $58ba
	rst Rst18 ; $58bd
	ld [hl+], a ; $58be
	ld a, [bc] ; $58bf
	ld a, $08 ; $58c0
	rst Rst18 ; $58c2
	ld [$f50a], sp ; $58c3
	ld a, $0a ; $58c6
	rst Rst18 ; $58c8
	inc b ; $58c9
	ld a, [bc] ; $58ca
	pop af ; $58cb
	call Func_0e_6f2b ; $58cc
	ld a, $0f ; $58cf
	ld bc, $1300 ; $58d1
	ld de, $0f00 ; $58d4
	rst Rst18 ; $58d7
	inc h ; $58d8
	ld a, [bc] ; $58d9
	ld a, $10 ; $58da
	ld bc, $1100 ; $58dc
	ld de, $0f00 ; $58df
	rst Rst18 ; $58e2
	inc h ; $58e3
	ld a, [bc] ; $58e4
	ld a, $0e ; $58e5
	ld bc, $1400 ; $58e7
	ld de, $1100 ; $58ea
	rst Rst18 ; $58ed
	inc h ; $58ee
	ld a, [bc] ; $58ef
	ld a, $0e ; $58f0
	rst Rst18 ; $58f2
	jr nz, Label_0e_58ff ; $58f3
	ld a, $0e ; $58f5
	ld bc, $1300 ; $58f7
	ld de, $1300 ; $58fa
	rst Rst18 ; $58fd
	inc h ; $58fe
Label_0e_58ff:
	ld a, [bc] ; $58ff
	ld a, $0e ; $5900
	rst Rst18 ; $5902
	jr nz, Label_0e_590f ; $5903
	ld a, $0e ; $5905
	ld b, $c0 ; $5907
	rst Rst18 ; $5909
	ld l, $0a ; $590a
	push af ; $590c
	ld a, $28 ; $590d
Label_0e_590f:
	rst Rst18 ; $590f
	inc b ; $5910
	ld a, [bc] ; $5911
	pop af ; $5912
	rst Rst20 ; $5913
	ld b, b ; $5914
	ld d, $df ; $5915
	jr Label_0e_591c ; $5917
	INCBIN "data/bank_00e/d_5919.bin" ; $5919, 3 bytes
Label_0e_591c:
	ld a, [bc] ; $591c
	ld a, [bc] ; $591d
	rst Rst18 ; $591e
	ld [de], a ; $591f
	ld a, [bc] ; $5920
	rst Rst18 ; $5921
	inc c ; $5922
	ld a, [bc] ; $5923
	push af ; $5924
	ld a, $05 ; $5925
	rst Rst18 ; $5927
	inc b ; $5928
	ld a, [bc] ; $5929
	pop af ; $592a
	and a, a ; $592b
	jr z, Label_0e_5938 ; $592c
	ld hl, $3060 ; $592e
	rst Rst18 ; $5931
	ld c, $0a ; $5932
	call Func_0e_7082 ; $5934
	ret ; $5937
Label_0e_5938:
	push af ; $5938
	ld a, $0a ; $5939
	rst Rst18 ; $593b
	inc b ; $593c
	ld a, [bc] ; $593d
	pop af ; $593e
	ld a, $0f ; $593f
	ld d, $03 ; $5941
	rst Rst18 ; $5943
	inc [hl] ; $5944
	ld a, [bc] ; $5945
	ld a, $0f ; $5946
	rst Rst18 ; $5948
	ld [hl], $0a ; $5949
	push af ; $594b
	ld a, $0a ; $594c
	rst Rst18 ; $594e
	inc b ; $594f
	ld a, [bc] ; $5950
	pop af ; $5951
	ld hl, $3063 ; $5952
	rst Rst18 ; $5955
	ld c, $0a ; $5956
	ld a, $0f ; $5958
	rst Rst18 ; $595a
	ld [$3e0a], sp ; $595b
	ld [$08df], sp ; $595e
	ld a, [bc] ; $5961
	ld a, $0b ; $5962
	ld b, $c0 ; $5964
	rst Rst18 ; $5966
	ld l, $0a ; $5967
	push af ; $5969
	ld a, $04 ; $596a
	rst Rst18 ; $596c
	inc b ; $596d
	ld a, [bc] ; $596e
	pop af ; $596f
	ld a, $0f ; $5970
	ld b, $c0 ; $5972
	rst Rst18 ; $5974
	ld l, $0a ; $5975
	push af ; $5977
	ld a, $04 ; $5978
	rst Rst18 ; $597a
	inc b ; $597b
	ld a, [bc] ; $597c
	pop af ; $597d
	ld a, $10 ; $597e
	ld b, $c0 ; $5980
	rst Rst18 ; $5982
	ld l, $0a ; $5983
	push af ; $5985
	ld a, $04 ; $5986
	rst Rst18 ; $5988
	inc b ; $5989
	ld a, [bc] ; $598a
	pop af ; $598b
	ld a, $0a ; $598c
	ld b, $c0 ; $598e
	rst Rst18 ; $5990
	ld l, $0a ; $5991
	push af ; $5993
	ld a, $04 ; $5994
	rst Rst18 ; $5996
	inc b ; $5997
	ld a, [bc] ; $5998
	pop af ; $5999
	ld a, $09 ; $599a
	ld b, $c0 ; $599c
	rst Rst18 ; $599e
	ld l, $0a ; $599f
	push af ; $59a1
	ld a, $04 ; $59a2
	rst Rst18 ; $59a4
	inc b ; $59a5
	ld a, [bc] ; $59a6
	pop af ; $59a7
	ld a, $0e ; $59a8
	ld b, $c0 ; $59aa
	rst Rst18 ; $59ac
	ld l, $0a ; $59ad
	push af ; $59af
	ld a, $0a ; $59b0
	rst Rst18 ; $59b2
	inc b ; $59b3
	ld a, [bc] ; $59b4
	pop af ; $59b5
	ld a, $0f ; $59b6
	ld d, $03 ; $59b8
	rst Rst18 ; $59ba
	inc [hl] ; $59bb
	ld a, [bc] ; $59bc
	ld a, $10 ; $59bd
	ld d, $03 ; $59bf
	rst Rst18 ; $59c1
	inc [hl] ; $59c2
	ld a, [bc] ; $59c3
	ld a, $0e ; $59c4
	ld d, $03 ; $59c6
	rst Rst18 ; $59c8
	inc [hl] ; $59c9
	ld a, [bc] ; $59ca
	ld a, $11 ; $59cb
	ld d, $03 ; $59cd
	rst Rst18 ; $59cf
	inc [hl] ; $59d0
	ld a, [bc] ; $59d1
	ld a, $12 ; $59d2
	ld d, $03 ; $59d4
	rst Rst18 ; $59d6
	inc [hl] ; $59d7
	ld a, [bc] ; $59d8
	ld a, $0b ; $59d9
	ld d, $03 ; $59db
	rst Rst18 ; $59dd
	inc [hl] ; $59de
	ld a, [bc] ; $59df
	ld a, $0a ; $59e0
	ld d, $03 ; $59e2
	rst Rst18 ; $59e4
	inc [hl] ; $59e5
	ld a, [bc] ; $59e6
	ld a, $09 ; $59e7
	ld d, $03 ; $59e9
	rst Rst18 ; $59eb
	inc [hl] ; $59ec
	ld a, [bc] ; $59ed
	ld a, $0c ; $59ee
	ld d, $03 ; $59f0
	rst Rst18 ; $59f2
	inc [hl] ; $59f3
	ld a, [bc] ; $59f4
	ld a, $13 ; $59f5
	ld d, $03 ; $59f7
	rst Rst18 ; $59f9
	inc [hl] ; $59fa
	ld a, [bc] ; $59fb
	ld a, $13 ; $59fc
	rst Rst18 ; $59fe
	ld [hl], $0a ; $59ff
	ld bc, $0010 ; $5a01
	rst Rst18 ; $5a04
	jr c, Label_0e_5a11 ; $5a05
	xor a, a ; $5a07
	ld bc, $1500 ; $5a08
	ld de, $0d00 ; $5a0b
	rst Rst18 ; $5a0e
	ld a, [hl-] ; $5a0f
	ld a, [bc] ; $5a10
Label_0e_5a11:
	ld a, $08 ; $5a11
	ld bc, $0014 ; $5a13
	rst Rst18 ; $5a16
	jr Label_0e_5a23 ; $5a17
	INCBIN "data/bank_00e/d_5a19.bin" ; $5a19, 10 bytes
Label_0e_5a23:
	ld bc, $0014 ; $5a23
	rst Rst18 ; $5a26
	jr Label_0e_5a33 ; $5a27
	INCBIN "data/bank_00e/d_5a29.bin" ; $5a29, 10 bytes
Label_0e_5a33:
	ld bc, $0014 ; $5a33
	rst Rst18 ; $5a36
	jr Label_0e_5a43 ; $5a37
	INCBIN "data/bank_00e/d_5a39.bin" ; $5a39, 10 bytes
Label_0e_5a43:
	ld bc, $0014 ; $5a43
	rst Rst18 ; $5a46
	jr Label_0e_5a53 ; $5a47
	INCBIN "data/bank_00e/d_5a49.bin" ; $5a49, 10 bytes
Label_0e_5a53:
	ld bc, $0014 ; $5a53
	rst Rst18 ; $5a56
	jr Label_0e_5a63 ; $5a57
	INCBIN "data/bank_00e/d_5a59.bin" ; $5a59, 10 bytes
Label_0e_5a63:
	ld bc, $0014 ; $5a63
	rst Rst18 ; $5a66
	jr Label_0e_5a73 ; $5a67
	INCBIN "data/bank_00e/d_5a69.bin" ; $5a69, 10 bytes
Label_0e_5a73:
	ld bc, $0014 ; $5a73
	rst Rst18 ; $5a76
	jr Label_0e_5a83 ; $5a77
	INCBIN "data/bank_00e/d_5a79.bin" ; $5a79, 10 bytes
Label_0e_5a83:
	ld a, [bc] ; $5a83
	push af ; $5a84
	ld a, $14 ; $5a85
	rst Rst18 ; $5a87
	inc b ; $5a88
	ld a, [bc] ; $5a89
	pop af ; $5a8a
	ldh a, [$ff95] ; $5a8b
	ld b, a ; $5a8d
	ld a, $08 ; $5a8e
	ld de, $552d ; $5a90
	rst Rst18 ; $5a93
	ld a, [de] ; $5a94
	ld a, [bc] ; $5a95
	push af ; $5a96
	ld a, $14 ; $5a97
	rst Rst18 ; $5a99
	inc b ; $5a9a
	ld a, [bc] ; $5a9b
	pop af ; $5a9c
	ldh a, [$ff95] ; $5a9d
	ld b, a ; $5a9f
	ld a, $12 ; $5aa0
	ld de, $552d ; $5aa2
	rst Rst18 ; $5aa5
	ld a, [de] ; $5aa6
	ld a, [bc] ; $5aa7
	push af ; $5aa8
	ld a, $64 ; $5aa9
	rst Rst18 ; $5aab
	inc b ; $5aac
	ld a, [bc] ; $5aad
	pop af ; $5aae
	ldh a, [$ff95] ; $5aaf
	ld b, a ; $5ab1
	ld a, $0b ; $5ab2
	ld de, $552d ; $5ab4
	rst Rst18 ; $5ab7
	ld a, [de] ; $5ab8
	ld a, [bc] ; $5ab9
	ldh a, [$ff95] ; $5aba
	ld b, a ; $5abc
	ld a, $0a ; $5abd
	ld de, $552d ; $5abf
	rst Rst18 ; $5ac2
	ld a, [de] ; $5ac3
	ld a, [bc] ; $5ac4
	ldh a, [$ff95] ; $5ac5
	ld b, a ; $5ac7
	ld a, $09 ; $5ac8
	ld de, $552d ; $5aca
	rst Rst18 ; $5acd
	ld a, [de] ; $5ace
	ld a, [bc] ; $5acf
	ldh a, [$ff95] ; $5ad0
	ld b, a ; $5ad2
	ld a, $0c ; $5ad3
	ld de, $552d ; $5ad5
	rst Rst18 ; $5ad8
	ld a, [de] ; $5ad9
	ld a, [bc] ; $5ada
	ldh a, [$ff95] ; $5adb
	ld b, a ; $5add
	ld a, $0d ; $5ade
	ld de, $552d ; $5ae0
	rst Rst18 ; $5ae3
	ld a, [de] ; $5ae4
	ld a, [bc] ; $5ae5
	push af ; $5ae6
	ld a, $3c ; $5ae7
	rst Rst18 ; $5ae9
	inc b ; $5aea
	ld a, [bc] ; $5aeb
	pop af ; $5aec
	ldh a, [$ff95] ; $5aed
	ld b, a ; $5aef
	ld a, $0f ; $5af0
	ld de, $552d ; $5af2
	rst Rst18 ; $5af5
	ld a, [de] ; $5af6
	ld a, [bc] ; $5af7
	ldh a, [$ff95] ; $5af8
	ld b, a ; $5afa
	ld a, $10 ; $5afb
	ld de, $552d ; $5afd
	rst Rst18 ; $5b00
	ld a, [de] ; $5b01
	ld a, [bc] ; $5b02
	push af ; $5b03
	ld a, $28 ; $5b04
	rst Rst18 ; $5b06
	inc b ; $5b07
	ld a, [bc] ; $5b08
	pop af ; $5b09
	ldh a, [$ff95] ; $5b0a
	ld b, a ; $5b0c
	ld a, $0e ; $5b0d
	ld de, $552d ; $5b0f
	rst Rst18 ; $5b12
	ld a, [de] ; $5b13
	ld a, [bc] ; $5b14
	ld a, $0e ; $5b15
	rst Rst18 ; $5b17
	ld e, $0a ; $5b18
	xor a, a ; $5b1a
	ld bc, $1200 ; $5b1b
	ld de, $0d00 ; $5b1e
	rst Rst18 ; $5b21
	ld a, [hl-] ; $5b22
	ld a, [bc] ; $5b23
	ld a, $13 ; $5b24
	ld bc, $1000 ; $5b26
	ld de, $0f00 ; $5b29
	rst Rst18 ; $5b2c
	inc h ; $5b2d
	ld a, [bc] ; $5b2e
	ld a, $13 ; $5b2f
	rst Rst18 ; $5b31
	jr nz, Label_0e_5b3e ; $5b32
	ld a, $13 ; $5b34
	ld bc, $1200 ; $5b36
	ld de, $0f00 ; $5b39
	rst Rst18 ; $5b3c
	inc h ; $5b3d
Label_0e_5b3e:
	ld a, [bc] ; $5b3e
	ld a, $13 ; $5b3f
	rst Rst18 ; $5b41
	jr nz, Label_0e_5b4e ; $5b42
	ld a, $13 ; $5b44
	ld b, $40 ; $5b46
	rst Rst18 ; $5b48
	ld l, $0a ; $5b49
	push af ; $5b4b
	ld a, $14 ; $5b4c
Label_0e_5b4e:
	rst Rst18 ; $5b4e
	inc b ; $5b4f
	ld a, [bc] ; $5b50
	pop af ; $5b51
	ld a, $13 ; $5b52
	rst Rst18 ; $5b54
	ld [$f50a], sp ; $5b55
	ld a, $0a ; $5b58
	rst Rst18 ; $5b5a
	inc b ; $5b5b
	ld a, [bc] ; $5b5c
	pop af ; $5b5d
	ld a, $00 ; $5b5e
	ld d, $03 ; $5b60
	rst Rst18 ; $5b62
	inc [hl] ; $5b63
	ld a, [bc] ; $5b64
	ld a, $00 ; $5b65
	rst Rst18 ; $5b67
	ld [hl], $0a ; $5b68
	push af ; $5b6a
	ld a, $14 ; $5b6b
	rst Rst18 ; $5b6d
	inc b ; $5b6e
	ld a, [bc] ; $5b6f
	pop af ; $5b70
	ldh a, [$ff95] ; $5b71
	ld b, a ; $5b73
	ld a, $13 ; $5b74
	ld de, $5545 ; $5b76
	rst Rst18 ; $5b79
	ld a, [de] ; $5b7a
	ld a, [bc] ; $5b7b
	push af ; $5b7c
	ld a, $14 ; $5b7d
	rst Rst18 ; $5b7f
	inc b ; $5b80
	ld a, [bc] ; $5b81
	pop af ; $5b82
	ldh a, [$ff95] ; $5b83
	ld b, a ; $5b85
	ld a, $00 ; $5b86
	ld de, $5545 ; $5b88
	rst Rst18 ; $5b8b
	ld a, [de] ; $5b8c
	ld a, [bc] ; $5b8d
	push af ; $5b8e
	ld a, $3c ; $5b8f
	rst Rst18 ; $5b91
	inc b ; $5b92
	ld a, [bc] ; $5b93
	pop af ; $5b94
	xor a, a ; $5b95
	ld bc, $1500 ; $5b96
	ld de, $0d00 ; $5b99
	rst Rst18 ; $5b9c
	ld a, [hl-] ; $5b9d
	ld a, [bc] ; $5b9e
	ld a, $00 ; $5b9f
	rst Rst18 ; $5ba1
	ld e, $0a ; $5ba2
	call Func_0e_7150 ; $5ba4
	ld a, $1c ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [$c295], a ; $5bae
	ld a, $ff ; $5bb1
	ld [$c294], a ; $5bb3
	ld [$c2a1], a ; $5bb6
	ret ; $5bb9
	INCBIN "data/bank_00e/d_5bba.bin" ; $5bba, 2189 bytes
	rst Rst18 ; $6447
	ld a, [de] ; $6448
	ld a, [bc] ; $6449
	call Func_0e_6987 ; $644a
	ld a, $08 ; $644d
	ld b, $40 ; $644f
	rst Rst18 ; $6451
	ld l, $0a ; $6452
	ldh a, [$ff95] ; $6454
	ld b, a ; $6456
	ld a, $00 ; $6457
	ld de, $63da ; $6459
	rst Rst18 ; $645c
	ld a, [de] ; $645d
	ld a, [bc] ; $645e
	push af ; $645f
	ld a, $14 ; $6460
	rst Rst18 ; $6462
	inc b ; $6463
	ld a, [bc] ; $6464
	pop af ; $6465
	ldh a, [$ff95] ; $6466
	ld b, a ; $6468
	ld a, $02 ; $6469
	ld de, $63e7 ; $646b
	rst Rst18 ; $646e
	ld a, [de] ; $646f
	ld a, [bc] ; $6470
	ld a, $00 ; $6471
	rst Rst18 ; $6473
	ld e, $0a ; $6474
	ld a, $02 ; $6476
	rst Rst18 ; $6478
	ld e, $0a ; $6479
	jp Label_0e_65d4 ; $647b
	INCBIN "data/bank_00e/d_647e.bin" ; $647e, 238 bytes
	rst Rst18 ; $656c
	inc h ; $656d
	ld a, [bc] ; $656e
	ld a, $00 ; $656f
	rst Rst18 ; $6571
	jr nz, Label_0e_657e ; $6572
	ld a, $00 ; $6574
	ld bc, $1200 ; $6576
	ld de, $0d00 ; $6579
	rst Rst18 ; $657c
	inc h ; $657d
Label_0e_657e:
	ld a, [bc] ; $657e
	ld a, $00 ; $657f
	rst Rst18 ; $6581
	jr nz, Label_0e_658e ; $6582
	ld a, $00 ; $6584
	ld b, $c0 ; $6586
	rst Rst18 ; $6588
	ld l, $0a ; $6589
	ld a, $08 ; $658b
	INCBIN "data/bank_00e/d_658d.bin" ; $658d, 1 bytes
Label_0e_658e:
	ld b, b ; $658e
	rst Rst18 ; $658f
	ld l, $0a ; $6590
	jp Label_0e_65d4 ; $6592
	INCBIN "data/bank_00e/d_6595.bin" ; $6595, 63 bytes
Label_0e_65d4:
	rst Rst18 ; $65d4
	nop ; $65d5
	ld a, [bc] ; $65d6
	ld bc, $0018 ; $65d7
	rst Rst18 ; $65da
	jr c, Label_0e_65e7 ; $65db
	xor a, a ; $65dd
	ld bc, $1200 ; $65de
	ld de, $0d00 ; $65e1
	rst Rst18 ; $65e4
	ld a, [hl-] ; $65e5
	ld a, [bc] ; $65e6
Label_0e_65e7:
	rst Rst18 ; $65e7
	ld a, $0a ; $65e8
	ld a, $02 ; $65ea
	ld [wWaterSpriteMinigameTimer], a ; $65ec
	ld hl, $c2b2 ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	rst Rst30 ; $65f8
	ldh [rTIMA], a ; $65f9
	jr z, Label_0e_660b ; $65fb
	ld a, $05 ; $65fd
	ld [wWaterSpriteMinigameTimer], a ; $65ff
	ld hl, $c2b2 ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
Label_0e_660b:
	ld hl, $c2b2 ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	rst Rst18 ; $6611
	ld c, $0a ; $6612
	ld a, $08 ; $6614
	rst Rst18 ; $6616
	ld a, [bc] ; $6617
	ld a, [bc] ; $6618
	rst Rst18 ; $6619
	ld [de], a ; $661a
	ld a, [bc] ; $661b
	rst Rst18 ; $661c
	inc c ; $661d
	ld a, [bc] ; $661e
	push af ; $661f
	ld a, $05 ; $6620
	rst Rst18 ; $6622
	inc b ; $6623
	ld a, [bc] ; $6624
	pop af ; $6625
	and a, a ; $6626
	jr z, Label_0e_6644 ; $6627
	ld a, $08 ; $6629
	rst Rst18 ; $662b
	ld [$f70a], sp ; $662c
	ldh [rTIMA], a ; $662f
	jr z, Label_0e_6640 ; $6631
	ld a, $02 ; $6633
	rst Rst18 ; $6635
	ld d, $0a ; $6636
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, $d000 ; $663a
	rst Rst18 ; $663d
	jr nz, Label_0e_6644 ; $663e
Label_0e_6640:
	rst Rst18 ; $6640
	ld [bc], a ; $6641
	ld a, [bc] ; $6642
	ret ; $6643
Label_0e_6644:
	ld a, [$c2b0] ; $6644
	and a, $01 ; $6647
	jr z, Label_0e_666e ; $6649
	rst Rst18 ; $664b
	INCBIN "data/bank_00e/d_664c.bin" ; $664c, 34 bytes
Label_0e_666e:
	ld hl, $c2b2 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add a, l ; $6676
	ld l, a ; $6677
	jr nc, Label_0e_667b ; $6678
	inc h ; $667a
Label_0e_667b:
	rst Rst18 ; $667b
	ld c, $0a ; $667c
	ld a, $08 ; $667e
	rst Rst18 ; $6680
	ld [$3e0a], sp ; $6681
	dec bc ; $6684
	ld b, $c0 ; $6685
	rst Rst18 ; $6687
	ld l, $0a ; $6688
	push af ; $668a
	ld a, $04 ; $668b
	rst Rst18 ; $668d
	inc b ; $668e
	ld a, [bc] ; $668f
	pop af ; $6690
	ld a, $0f ; $6691
	ld b, $c0 ; $6693
	rst Rst18 ; $6695
	ld l, $0a ; $6696
	push af ; $6698
	ld a, $04 ; $6699
	rst Rst18 ; $669b
	inc b ; $669c
	ld a, [bc] ; $669d
	pop af ; $669e
	ld a, $10 ; $669f
	ld b, $c0 ; $66a1
	rst Rst18 ; $66a3
	ld l, $0a ; $66a4
	push af ; $66a6
	ld a, $04 ; $66a7
	rst Rst18 ; $66a9
	inc b ; $66aa
	ld a, [bc] ; $66ab
	pop af ; $66ac
	ld a, $0a ; $66ad
	ld b, $c0 ; $66af
	rst Rst18 ; $66b1
	ld l, $0a ; $66b2
	push af ; $66b4
	ld a, $04 ; $66b5
	rst Rst18 ; $66b7
	inc b ; $66b8
	ld a, [bc] ; $66b9
	pop af ; $66ba
	ld a, $09 ; $66bb
	ld b, $c0 ; $66bd
	rst Rst18 ; $66bf
	ld l, $0a ; $66c0
	push af ; $66c2
	ld a, $04 ; $66c3
	rst Rst18 ; $66c5
	inc b ; $66c6
	ld a, [bc] ; $66c7
	pop af ; $66c8
	ld a, $0e ; $66c9
	ld b, $c0 ; $66cb
	rst Rst18 ; $66cd
	ld l, $0a ; $66ce
	push af ; $66d0
	ld a, $0a ; $66d1
	rst Rst18 ; $66d3
	inc b ; $66d4
	ld a, [bc] ; $66d5
	pop af ; $66d6
	ld a, $0f ; $66d7
	ld d, $03 ; $66d9
	rst Rst18 ; $66db
	inc [hl] ; $66dc
	ld a, [bc] ; $66dd
	ld a, $10 ; $66de
	ld d, $03 ; $66e0
	rst Rst18 ; $66e2
	inc [hl] ; $66e3
	ld a, [bc] ; $66e4
	ld a, $0e ; $66e5
	ld d, $03 ; $66e7
	rst Rst18 ; $66e9
	inc [hl] ; $66ea
	ld a, [bc] ; $66eb
	ld a, $11 ; $66ec
	ld d, $03 ; $66ee
	rst Rst18 ; $66f0
	inc [hl] ; $66f1
	ld a, [bc] ; $66f2
	ld a, $12 ; $66f3
	ld d, $03 ; $66f5
	rst Rst18 ; $66f7
	inc [hl] ; $66f8
	ld a, [bc] ; $66f9
	ld a, $0b ; $66fa
	ld d, $03 ; $66fc
	rst Rst18 ; $66fe
	inc [hl] ; $66ff
	ld a, [bc] ; $6700
	ld a, $0a ; $6701
	ld d, $03 ; $6703
	rst Rst18 ; $6705
	inc [hl] ; $6706
	ld a, [bc] ; $6707
	ld a, $09 ; $6708
	ld d, $03 ; $670a
	rst Rst18 ; $670c
	inc [hl] ; $670d
	ld a, [bc] ; $670e
	ld a, $0c ; $670f
	ld d, $03 ; $6711
	rst Rst18 ; $6713
	inc [hl] ; $6714
	ld a, [bc] ; $6715
	ld a, $13 ; $6716
	ld d, $03 ; $6718
	rst Rst18 ; $671a
	inc [hl] ; $671b
	ld a, [bc] ; $671c
	ld a, $13 ; $671d
	rst Rst18 ; $671f
	ld [hl], $0a ; $6720
	ld bc, $0018 ; $6722
	rst Rst18 ; $6725
	jr c, Label_0e_6732 ; $6726
	xor a, a ; $6728
	ld bc, $1500 ; $6729
	ld de, $0d00 ; $672c
	rst Rst18 ; $672f
	ld a, [hl-] ; $6730
	ld a, [bc] ; $6731
Label_0e_6732:
	ld a, $08 ; $6732
	ld bc, $0020 ; $6734
	rst Rst18 ; $6737
	jr Label_0e_6744 ; $6738
	INCBIN "data/bank_00e/d_673a.bin" ; $673a, 10 bytes
Label_0e_6744:
	ld bc, $0020 ; $6744
	rst Rst18 ; $6747
	jr Label_0e_6754 ; $6748
	INCBIN "data/bank_00e/d_674a.bin" ; $674a, 10 bytes
Label_0e_6754:
	ld bc, $0020 ; $6754
	rst Rst18 ; $6757
	jr Label_0e_6764 ; $6758
	INCBIN "data/bank_00e/d_675a.bin" ; $675a, 10 bytes
Label_0e_6764:
	ld bc, $0020 ; $6764
	rst Rst18 ; $6767
	jr Label_0e_6774 ; $6768
	INCBIN "data/bank_00e/d_676a.bin" ; $676a, 10 bytes
Label_0e_6774:
	ld bc, $0020 ; $6774
	rst Rst18 ; $6777
	jr Label_0e_6784 ; $6778
	INCBIN "data/bank_00e/d_677a.bin" ; $677a, 10 bytes
Label_0e_6784:
	ld bc, $0020 ; $6784
	rst Rst18 ; $6787
	jr Label_0e_6794 ; $6788
	INCBIN "data/bank_00e/d_678a.bin" ; $678a, 10 bytes
Label_0e_6794:
	ld bc, $0020 ; $6794
	rst Rst18 ; $6797
	jr Label_0e_67a4 ; $6798
	INCBIN "data/bank_00e/d_679a.bin" ; $679a, 10 bytes
Label_0e_67a4:
	rst Rst18 ; $67a4
	inc b ; $67a5
	ld a, [bc] ; $67a6
	pop af ; $67a7
	ld a, $08 ; $67a8
	ld b, $00 ; $67aa
	rst Rst18 ; $67ac
	ld l, $0a ; $67ad
	push af ; $67af
	ld a, $0a ; $67b0
	rst Rst18 ; $67b2
	inc b ; $67b3
	ld a, [bc] ; $67b4
	pop af ; $67b5
	ld a, $11 ; $67b6
	ld b, $00 ; $67b8
	rst Rst18 ; $67ba
	ld l, $0a ; $67bb
	push af ; $67bd
	ld a, $14 ; $67be
	rst Rst18 ; $67c0
	inc b ; $67c1
	ld a, [bc] ; $67c2
	pop af ; $67c3
	ldh a, [$ff95] ; $67c4
	ld b, a ; $67c6
	ld a, $12 ; $67c7
	ld de, $552d ; $67c9
	rst Rst18 ; $67cc
	ld a, [de] ; $67cd
	ld a, [bc] ; $67ce
	push af ; $67cf
	ld a, $14 ; $67d0
	rst Rst18 ; $67d2
	inc b ; $67d3
	ld a, [bc] ; $67d4
	pop af ; $67d5
	ldh a, [$ff95] ; $67d6
	ld b, a ; $67d8
	ld a, $08 ; $67d9
	ld de, $552d ; $67db
	rst Rst18 ; $67de
	ld a, [de] ; $67df
	ld a, [bc] ; $67e0
	push af ; $67e1
	ld a, $14 ; $67e2
	rst Rst18 ; $67e4
	inc b ; $67e5
	ld a, [bc] ; $67e6
	pop af ; $67e7
	ldh a, [$ff95] ; $67e8
	ld b, a ; $67ea
	ld a, $11 ; $67eb
	ld de, $552d ; $67ed
	rst Rst18 ; $67f0
	ld a, [de] ; $67f1
	ld a, [bc] ; $67f2
	push af ; $67f3
	ld a, $64 ; $67f4
	rst Rst18 ; $67f6
	inc b ; $67f7
	ld a, [bc] ; $67f8
	pop af ; $67f9
	rst Rst30 ; $67fa
	ldh [rTIMA], a ; $67fb
	jr nz, Label_0e_680c ; $67fd
	ld a, $00 ; $67ff
	ld bc, $1200 ; $6801
	ld de, $0900 ; $6804
	rst Rst18 ; $6807
	inc h ; $6808
	ld a, [bc] ; $6809
	jr Label_0e_682a ; $680a
Label_0e_680c:
	ld a, $02 ; $680c
	ld bc, $0020 ; $680e
	rst Rst18 ; $6811
	jr Label_0e_681e ; $6812
	INCBIN "data/bank_00e/d_6814.bin" ; $6814, 10 bytes
Label_0e_681e:
	ld a, [bc] ; $681e
	ld a, $02 ; $681f
	ld bc, $1300 ; $6821
	ld de, $0900 ; $6824
	rst Rst18 ; $6827
	inc h ; $6828
	ld a, [bc] ; $6829
Label_0e_682a:
	ldh a, [$ff95] ; $682a
	ld b, a ; $682c
	ld a, $0b ; $682d
	ld de, $552d ; $682f
	rst Rst18 ; $6832
	ld a, [de] ; $6833
	ld a, [bc] ; $6834
	ldh a, [$ff95] ; $6835
	ld b, a ; $6837
	ld a, $0a ; $6838
	ld de, $552d ; $683a
	rst Rst18 ; $683d
	ld a, [de] ; $683e
	ld a, [bc] ; $683f
	ldh a, [$ff95] ; $6840
	ld b, a ; $6842
	ld a, $09 ; $6843
	ld de, $552d ; $6845
	rst Rst18 ; $6848
	ld a, [de] ; $6849
	ld a, [bc] ; $684a
	ldh a, [$ff95] ; $684b
	ld b, a ; $684d
	ld a, $0c ; $684e
	ld de, $552d ; $6850
	rst Rst18 ; $6853
	ld a, [de] ; $6854
	ld a, [bc] ; $6855
	ldh a, [$ff95] ; $6856
	ld b, a ; $6858
	ld a, $0d ; $6859
	ld de, $552d ; $685b
	rst Rst18 ; $685e
	ld a, [de] ; $685f
	ld a, [bc] ; $6860
	push af ; $6861
	ld a, $1e ; $6862
	rst Rst18 ; $6864
	inc b ; $6865
	ld a, [bc] ; $6866
	pop af ; $6867
	ld a, $00 ; $6868
	ld b, $40 ; $686a
	rst Rst18 ; $686c
	ld l, $0a ; $686d
	rst Rst30 ; $686f
	ldh [rTIMA], a ; $6870
	jr z, Label_0e_687b ; $6872
	ld a, $02 ; $6874
	ld b, $40 ; $6876
	rst Rst18 ; $6878
	ld l, $0a ; $6879
Label_0e_687b:
	ldh a, [$ff95] ; $687b
	ld b, a ; $687d
	ld a, $0f ; $687e
	ld de, $552d ; $6880
	rst Rst18 ; $6883
	ld a, [de] ; $6884
	ld a, [bc] ; $6885
	push af ; $6886
	ld a, $28 ; $6887
	rst Rst18 ; $6889
	inc b ; $688a
	ld a, [bc] ; $688b
	pop af ; $688c
	ldh a, [$ff95] ; $688d
	ld b, a ; $688f
	ld a, $10 ; $6890
	ld de, $552d ; $6892
	rst Rst18 ; $6895
	ld a, [de] ; $6896
	ld a, [bc] ; $6897
	push af ; $6898
	ld a, $14 ; $6899
	rst Rst18 ; $689b
	inc b ; $689c
	ld a, [bc] ; $689d
	pop af ; $689e
	ldh a, [$ff95] ; $689f
	ld b, a ; $68a1
	ld a, $0e ; $68a2
	ld de, $552d ; $68a4
	rst Rst18 ; $68a7
	ld a, [de] ; $68a8
	ld a, [bc] ; $68a9
	ld a, $0e ; $68aa
	rst Rst18 ; $68ac
	ld e, $0a ; $68ad
	xor a, a ; $68af
	ld bc, $1200 ; $68b0
	ld de, $0d00 ; $68b3
	rst Rst18 ; $68b6
	ld a, [hl-] ; $68b7
	ld a, [bc] ; $68b8
	rst Rst30 ; $68b9
	ldh [rTIMA], a ; $68ba
	jr nz, Label_0e_68cb ; $68bc
	ld a, $00 ; $68be
	ld bc, $1200 ; $68c0
	ld de, $0b00 ; $68c3
	rst Rst18 ; $68c6
	inc h ; $68c7
	ld a, [bc] ; $68c8
	jr Label_0e_68e1 ; $68c9
Label_0e_68cb:
	ld a, $00 ; $68cb
	ld bc, $1100 ; $68cd
	ld de, $0b00 ; $68d0
	rst Rst18 ; $68d3
	inc h ; $68d4
	ld a, [bc] ; $68d5
	ld a, $02 ; $68d6
	ld bc, $1300 ; $68d8
	ld de, $0b00 ; $68db
	rst Rst18 ; $68de
	inc h ; $68df
	ld a, [bc] ; $68e0
Label_0e_68e1:
	ld a, $13 ; $68e1
	ld bc, $1200 ; $68e3
	ld de, $0d00 ; $68e6
	rst Rst18 ; $68e9
	inc h ; $68ea
	ld a, [bc] ; $68eb
	ld a, $13 ; $68ec
	rst Rst18 ; $68ee
	jr nz, Label_0e_68fb ; $68ef
	ld a, $13 ; $68f1
	ld b, $c0 ; $68f3
	rst Rst18 ; $68f5
	ld l, $0a ; $68f6
	push af ; $68f8
	ld a, $14 ; $68f9
Label_0e_68fb:
	rst Rst18 ; $68fb
	inc b ; $68fc
	ld a, [bc] ; $68fd
	pop af ; $68fe
	ld a, $13 ; $68ff
	rst Rst18 ; $6901
	ld [$f50a], sp ; $6902
	ld a, $0a ; $6905
	rst Rst18 ; $6907
	inc b ; $6908
	ld a, [bc] ; $6909
	pop af ; $690a
	ld a, $00 ; $690b
	ld d, $03 ; $690d
	rst Rst18 ; $690f
	inc [hl] ; $6910
	ld a, [bc] ; $6911
	rst Rst30 ; $6912
	ldh [rTIMA], a ; $6913
	jr z, Label_0e_691e ; $6915
	ld a, $02 ; $6917
	ld d, $03 ; $6919
	rst Rst18 ; $691b
	inc [hl] ; $691c
	ld a, [bc] ; $691d
Label_0e_691e:
	ld a, $00 ; $691e
	rst Rst18 ; $6920
	ld [hl], $0a ; $6921
	push af ; $6923
	ld a, $14 ; $6924
	rst Rst18 ; $6926
	inc b ; $6927
	ld a, [bc] ; $6928
	pop af ; $6929
	ldh a, [$ff95] ; $692a
	ld b, a ; $692c
	ld a, $13 ; $692d
	ld de, $5545 ; $692f
	rst Rst18 ; $6932
	ld a, [de] ; $6933
	ld a, [bc] ; $6934
	push af ; $6935
	ld a, $14 ; $6936
	rst Rst18 ; $6938
	inc b ; $6939
	ld a, [bc] ; $693a
	pop af ; $693b
	ldh a, [$ff95] ; $693c
	ld b, a ; $693e
	ld a, $00 ; $693f
	ld de, $5545 ; $6941
	rst Rst18 ; $6944
	ld a, [de] ; $6945
	ld a, [bc] ; $6946
	rst Rst30 ; $6947
	ldh [rTIMA], a ; $6948
	jr z, Label_0e_695e ; $694a
	push af ; $694c
	ld a, $28 ; $694d
	rst Rst18 ; $694f
	inc b ; $6950
	ld a, [bc] ; $6951
	pop af ; $6952
	ldh a, [$ff95] ; $6953
	ld b, a ; $6955
	ld a, $02 ; $6956
	ld de, $5545 ; $6958
	rst Rst18 ; $695b
	ld a, [de] ; $695c
	ld a, [bc] ; $695d
Label_0e_695e:
	xor a, a ; $695e
	ld bc, $1500 ; $695f
	ld de, $0d00 ; $6962
	rst Rst18 ; $6965
	ld a, [hl-] ; $6966
	ld a, [bc] ; $6967
	ld a, $00 ; $6968
	rst Rst18 ; $696a
	ld e, $0a ; $696b
	call Func_0e_7150 ; $696d
	ld a, $1c ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wWaterSpriteMinigameTimer] ; $6975
	ld [$c295], a ; $6978
	ld a, $ff ; $697b
	ld [$c294], a ; $697d
	ld [$c2a1], a ; $6980
	rst Rst18 ; $6983
	ld [bc], a ; $6984
	ld a, [bc] ; $6985
	ret ; $6986
Func_0e_6987:
	ld a, $04 ; $6987
	ldh [$ff96], a ; $6989
	ldh [rWBK], a ; $698b
	ld a, $00 ; $698d
	rst Rst18 ; $698f
	ld d, $0a ; $6990
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, $000e ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, $000c ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	rst Rst18 ; $69a4
	inc h ; $69a5
	ld a, [bc] ; $69a6
	ld a, $02 ; $69a7
	rst Rst18 ; $69a9
	jr nz, Label_0e_69b6 ; $69aa
	ret ; $69ac
	INCBIN "data/bank_00e/d_69ad.bin" ; $69ad, 9 bytes
Label_0e_69b6:
	ret z ; $69b6
	ld a, $00 ; $69b7
	ld bc, $1200 ; $69b9
	ld de, $0f00 ; $69bc
	rst Rst18 ; $69bf
	ld [hl+], a ; $69c0
	ld a, [bc] ; $69c1
	jp Label_0e_69fb ; $69c2
	INCBIN "data/bank_00e/d_69c5.bin" ; $69c5, 23 bytes
	rst Rst18 ; $69dc
	ld a, $0a ; $69dd
	ld a, $00 ; $69df
	ld bc, $1100 ; $69e1
	ld de, $0f00 ; $69e4
	rst Rst18 ; $69e7
	ld [hl+], a ; $69e8
	ld a, [bc] ; $69e9
	ld a, $02 ; $69ea
	ld bc, $1300 ; $69ec
	ld de, $0f00 ; $69ef
	rst Rst18 ; $69f2
	ld [hl+], a ; $69f3
	ld a, [bc] ; $69f4
	rst Rst18 ; $69f5
	ld [bc], a ; $69f6
	ld a, [bc] ; $69f7
	jp Label_0e_69fb ; $69f8
Label_0e_69fb:
	ld a, $08 ; $69fb
	ld bc, $1200 ; $69fd
	ld de, $0b00 ; $6a00
	rst Rst18 ; $6a03
	ld [hl+], a ; $6a04
	ld a, [bc] ; $6a05
	ld a, $10 ; $6a06
	ld b, $00 ; $6a08
	rst Rst18 ; $6a0a
	ld l, $0a ; $6a0b
	ld a, $0f ; $6a0d
	ld b, $00 ; $6a0f
	rst Rst18 ; $6a11
	ld l, $0a ; $6a12
	ld a, $0d ; $6a14
	ld b, $00 ; $6a16
	rst Rst18 ; $6a18
	ld l, $0a ; $6a19
	ld a, $0e ; $6a1b
	ld b, $00 ; $6a1d
	rst Rst18 ; $6a1f
	ld l, $0a ; $6a20
	ld a, $0b ; $6a22
	ld b, $80 ; $6a24
	rst Rst18 ; $6a26
	ld l, $0a ; $6a27
	ld a, $0a ; $6a29
	ld b, $80 ; $6a2b
	rst Rst18 ; $6a2d
	ld l, $0a ; $6a2e
	ld a, $09 ; $6a30
	ld b, $80 ; $6a32
	rst Rst18 ; $6a34
	ld l, $0a ; $6a35
	ld a, $0c ; $6a37
	ld b, $80 ; $6a39
	rst Rst18 ; $6a3b
	ld l, $0a ; $6a3c
	ld a, $13 ; $6a3e
	ld bc, $0d00 ; $6a40
	ld de, $1300 ; $6a43
	rst Rst18 ; $6a46
	ld [hl+], a ; $6a47
	ld a, [bc] ; $6a48
	ld a, $13 ; $6a49
	ld b, $00 ; $6a4b
	rst Rst18 ; $6a4d
	ld l, $0a ; $6a4e
	ret ; $6a50
	INCBIN "data/bank_00e/d_6a51.bin" ; $6a51, 131 bytes
Func_0e_6ad4:
	push af ; $6ad4
	ld a, $0a ; $6ad5
	rst Rst18 ; $6ad7
	inc b ; $6ad8
	ld a, [bc] ; $6ad9
	pop af ; $6ada
	ld a, $08 ; $6adb
	ld b, $40 ; $6add
	rst Rst18 ; $6adf
	ld l, $0a ; $6ae0
	push af ; $6ae2
	ld a, $04 ; $6ae3
	rst Rst18 ; $6ae5
	inc b ; $6ae6
	ld a, [bc] ; $6ae7
	pop af ; $6ae8
	ld a, $10 ; $6ae9
	ld b, $00 ; $6aeb
	rst Rst18 ; $6aed
	ld l, $0a ; $6aee
	push af ; $6af0
	ld a, $04 ; $6af1
	rst Rst18 ; $6af3
	inc b ; $6af4
	ld a, [bc] ; $6af5
	pop af ; $6af6
	ld a, $0f ; $6af7
	ld b, $00 ; $6af9
	rst Rst18 ; $6afb
	ld l, $0a ; $6afc
	push af ; $6afe
	ld a, $04 ; $6aff
	rst Rst18 ; $6b01
	inc b ; $6b02
	ld a, [bc] ; $6b03
	pop af ; $6b04
	ld a, $0d ; $6b05
	ld b, $00 ; $6b07
	rst Rst18 ; $6b09
	ld l, $0a ; $6b0a
	push af ; $6b0c
	ld a, $04 ; $6b0d
	rst Rst18 ; $6b0f
	inc b ; $6b10
	ld a, [bc] ; $6b11
	pop af ; $6b12
	ld a, $0e ; $6b13
	ld b, $00 ; $6b15
	rst Rst18 ; $6b17
	ld l, $0a ; $6b18
	push af ; $6b1a
	ld a, $04 ; $6b1b
	rst Rst18 ; $6b1d
	inc b ; $6b1e
	ld a, [bc] ; $6b1f
	pop af ; $6b20
	ld a, $0b ; $6b21
	ld b, $80 ; $6b23
	rst Rst18 ; $6b25
	ld l, $0a ; $6b26
	push af ; $6b28
	ld a, $04 ; $6b29
	rst Rst18 ; $6b2b
	inc b ; $6b2c
	ld a, [bc] ; $6b2d
	pop af ; $6b2e
	ld a, $0a ; $6b2f
	ld b, $80 ; $6b31
	rst Rst18 ; $6b33
	ld l, $0a ; $6b34
	push af ; $6b36
	ld a, $04 ; $6b37
	rst Rst18 ; $6b39
	inc b ; $6b3a
	ld a, [bc] ; $6b3b
	pop af ; $6b3c
	ld a, $09 ; $6b3d
	ld b, $80 ; $6b3f
	rst Rst18 ; $6b41
	ld l, $0a ; $6b42
	push af ; $6b44
	ld a, $04 ; $6b45
	rst Rst18 ; $6b47
	inc b ; $6b48
	ld a, [bc] ; $6b49
	pop af ; $6b4a
	ld a, $13 ; $6b4b
	ld b, $c0 ; $6b4d
	rst Rst18 ; $6b4f
	ld l, $0a ; $6b50
	push af ; $6b52
	ld a, $04 ; $6b53
	rst Rst18 ; $6b55
	inc b ; $6b56
	ld a, [bc] ; $6b57
	pop af ; $6b58
	ld a, $0c ; $6b59
	ld b, $c0 ; $6b5b
	rst Rst18 ; $6b5d
	ld l, $0a ; $6b5e
	push af ; $6b60
	ld a, $14 ; $6b61
	rst Rst18 ; $6b63
	inc b ; $6b64
	ld a, [bc] ; $6b65
	pop af ; $6b66
	ld a, $08 ; $6b67
	ld d, $03 ; $6b69
	rst Rst18 ; $6b6b
	inc [hl] ; $6b6c
	ld a, [bc] ; $6b6d
	ld a, $08 ; $6b6e
	rst Rst18 ; $6b70
	ld [hl], $0a ; $6b71
	ld a, $08 ; $6b73
	rst Rst18 ; $6b75
	ld [$f50a], sp ; $6b76
	ld a, $14 ; $6b79
	rst Rst18 ; $6b7b
	inc b ; $6b7c
	ld a, [bc] ; $6b7d
	pop af ; $6b7e
	ld a, $11 ; $6b7f
	ld d, $03 ; $6b81
	rst Rst18 ; $6b83
	inc [hl] ; $6b84
	ld a, [bc] ; $6b85
	ld a, $11 ; $6b86
	rst Rst18 ; $6b88
	ld [hl], $0a ; $6b89
	ld a, $11 ; $6b8b
	rst Rst18 ; $6b8d
	ld [$3e0a], sp ; $6b8e
	ld [$8006], sp ; $6b91
	rst Rst18 ; $6b94
	ld l, $0a ; $6b95
	push af ; $6b97
	ld a, $0a ; $6b98
	rst Rst18 ; $6b9a
	inc b ; $6b9b
	ld a, [bc] ; $6b9c
	pop af ; $6b9d
	ld a, $11 ; $6b9e
	ld b, $00 ; $6ba0
	rst Rst18 ; $6ba2
	ld l, $0a ; $6ba3
	push af ; $6ba5
	ld a, $14 ; $6ba6
	rst Rst18 ; $6ba8
	inc b ; $6ba9
	ld a, [bc] ; $6baa
	pop af ; $6bab
	ld a, $11 ; $6bac
	ld d, $03 ; $6bae
	rst Rst18 ; $6bb0
	inc [hl] ; $6bb1
	ld a, [bc] ; $6bb2
	ld a, $08 ; $6bb3
	ld d, $03 ; $6bb5
	rst Rst18 ; $6bb7
	inc [hl] ; $6bb8
	ld a, [bc] ; $6bb9
	ld a, $08 ; $6bba
	rst Rst18 ; $6bbc
	ld [hl], $0a ; $6bbd
	push af ; $6bbf
	ld a, $0a ; $6bc0
	rst Rst18 ; $6bc2
	inc b ; $6bc3
	ld a, [bc] ; $6bc4
	pop af ; $6bc5
	ld a, $08 ; $6bc6
	ld b, $40 ; $6bc8
	rst Rst18 ; $6bca
	ld l, $0a ; $6bcb
	push af ; $6bcd
	ld a, $0a ; $6bce
	rst Rst18 ; $6bd0
	inc b ; $6bd1
	ld a, [bc] ; $6bd2
	pop af ; $6bd3
	ld a, $11 ; $6bd4
	ld b, $40 ; $6bd6
	rst Rst18 ; $6bd8
	ld l, $0a ; $6bd9
	push af ; $6bdb
	ld a, $1e ; $6bdc
	rst Rst18 ; $6bde
	inc b ; $6bdf
	ld a, [bc] ; $6be0
	pop af ; $6be1
	ld a, $08 ; $6be2
	rst Rst18 ; $6be4
	ld [$3e0a], sp ; $6be5
	ld [$0006], sp ; $6be8
	rst Rst18 ; $6beb
	ld l, $0a ; $6bec
	push af ; $6bee
	ld a, $0a ; $6bef
	rst Rst18 ; $6bf1
	inc b ; $6bf2
	ld a, [bc] ; $6bf3
	pop af ; $6bf4
	ld a, $12 ; $6bf5
	ld b, $80 ; $6bf7
	rst Rst18 ; $6bf9
	ld l, $0a ; $6bfa
	push af ; $6bfc
	ld a, $14 ; $6bfd
	rst Rst18 ; $6bff
	inc b ; $6c00
	ld a, [bc] ; $6c01
	pop af ; $6c02
	ld a, $12 ; $6c03
	ld d, $03 ; $6c05
	rst Rst18 ; $6c07
	inc [hl] ; $6c08
	ld a, [bc] ; $6c09
	ld a, $08 ; $6c0a
	ld d, $03 ; $6c0c
	rst Rst18 ; $6c0e
	inc [hl] ; $6c0f
	ld a, [bc] ; $6c10
	ld a, $08 ; $6c11
	rst Rst18 ; $6c13
	ld [hl], $0a ; $6c14
	push af ; $6c16
	ld a, $0a ; $6c17
	rst Rst18 ; $6c19
	inc b ; $6c1a
	ld a, [bc] ; $6c1b
	pop af ; $6c1c
	ld a, $08 ; $6c1d
	ld b, $40 ; $6c1f
	rst Rst18 ; $6c21
	ld l, $0a ; $6c22
	push af ; $6c24
	ld a, $0a ; $6c25
	rst Rst18 ; $6c27
	inc b ; $6c28
	ld a, [bc] ; $6c29
	pop af ; $6c2a
	ld a, $12 ; $6c2b
	ld b, $40 ; $6c2d
	rst Rst18 ; $6c2f
	ld l, $0a ; $6c30
	push af ; $6c32
	ld a, $1e ; $6c33
	rst Rst18 ; $6c35
	inc b ; $6c36
	ld a, [bc] ; $6c37
	pop af ; $6c38
	ld a, $08 ; $6c39
	rst Rst18 ; $6c3b
	ld [$f50a], sp ; $6c3c
	ld a, $14 ; $6c3f
	rst Rst18 ; $6c41
	inc b ; $6c42
	ld a, [bc] ; $6c43
	pop af ; $6c44
	ld a, $10 ; $6c45
	ld de, $ff80 ; $6c47
	rst Rst18 ; $6c4a
	ld b, d ; $6c4b
	ld a, [bc] ; $6c4c
	push af ; $6c4d
	ld a, $14 ; $6c4e
	rst Rst18 ; $6c50
	inc b ; $6c51
	ld a, [bc] ; $6c52
	pop af ; $6c53
	ld a, $10 ; $6c54
	ld b, $c0 ; $6c56
	rst Rst18 ; $6c58
	ld l, $0a ; $6c59
	ld a, $10 ; $6c5b
	ld d, $02 ; $6c5d
	rst Rst18 ; $6c5f
	inc [hl] ; $6c60
	ld a, [bc] ; $6c61
	ld a, $10 ; $6c62
	rst Rst18 ; $6c64
	ld [hl], $0a ; $6c65
	ld a, $10 ; $6c67
	rst Rst18 ; $6c69
	ld [$f50a], sp ; $6c6a
	ld a, $0a ; $6c6d
	rst Rst18 ; $6c6f
	inc b ; $6c70
	ld a, [bc] ; $6c71
	pop af ; $6c72
	ld a, $0e ; $6c73
	ld de, rLCDC ; $6c75
	rst Rst18 ; $6c78
	ld b, d ; $6c79
	ld a, [bc] ; $6c7a
	push af ; $6c7b
	ld a, $28 ; $6c7c
	rst Rst18 ; $6c7e
	inc b ; $6c7f
	ld a, [bc] ; $6c80
	pop af ; $6c81
	ld a, $0e ; $6c82
	ld b, $c0 ; $6c84
	rst Rst18 ; $6c86
	ld l, $0a ; $6c87
	ld a, $0e ; $6c89
	ld d, $02 ; $6c8b
	rst Rst18 ; $6c8d
	inc [hl] ; $6c8e
	ld a, [bc] ; $6c8f
	ld a, $0e ; $6c90
	rst Rst18 ; $6c92
	ld [hl], $0a ; $6c93
	ld a, $0e ; $6c95
	rst Rst18 ; $6c97
	ld [$f50a], sp ; $6c98
	ld a, $14 ; $6c9b
	rst Rst18 ; $6c9d
	inc b ; $6c9e
	ld a, [bc] ; $6c9f
	pop af ; $6ca0
	rst Rst08 ; $6ca1
	sub a, [hl] ; $6ca2
	ld a, $04 ; $6ca3
	ld bc, $0f00 ; $6ca5
	ld de, $0900 ; $6ca8
	rst Rst18 ; $6cab
	ld [hl+], a ; $6cac
	ld a, [bc] ; $6cad
	push af ; $6cae
	ld a, $04 ; $6caf
	rst Rst18 ; $6cb1
	inc b ; $6cb2
	ld a, [bc] ; $6cb3
	pop af ; $6cb4
	rst Rst08 ; $6cb5
	sub a, [hl] ; $6cb6
	ld a, $05 ; $6cb7
	ld bc, $1300 ; $6cb9
	ld de, $0700 ; $6cbc
	rst Rst18 ; $6cbf
	ld [hl+], a ; $6cc0
	ld a, [bc] ; $6cc1
	push af ; $6cc2
	ld a, $04 ; $6cc3
	rst Rst18 ; $6cc5
	inc b ; $6cc6
	ld a, [bc] ; $6cc7
	pop af ; $6cc8
	rst Rst08 ; $6cc9
	sub a, [hl] ; $6cca
	ld a, $06 ; $6ccb
	ld bc, $1700 ; $6ccd
	ld de, $0900 ; $6cd0
	rst Rst18 ; $6cd3
	ld [hl+], a ; $6cd4
	ld a, [bc] ; $6cd5
	push af ; $6cd6
	ld a, $28 ; $6cd7
	rst Rst18 ; $6cd9
	inc b ; $6cda
	ld a, [bc] ; $6cdb
	pop af ; $6cdc
	ld a, $08 ; $6cdd
	ld b, $80 ; $6cdf
	rst Rst18 ; $6ce1
	ld l, $0a ; $6ce2
	push af ; $6ce4
	ld a, $0a ; $6ce5
	rst Rst18 ; $6ce7
	inc b ; $6ce8
	ld a, [bc] ; $6ce9
	pop af ; $6cea
	ld a, $11 ; $6ceb
	ld b, $00 ; $6ced
	rst Rst18 ; $6cef
	ld l, $0a ; $6cf0
	push af ; $6cf2
	ld a, $28 ; $6cf3
	rst Rst18 ; $6cf5
	inc b ; $6cf6
	ld a, [bc] ; $6cf7
	pop af ; $6cf8
	ld a, $08 ; $6cf9
	ld b, $00 ; $6cfb
	rst Rst18 ; $6cfd
	ld l, $0a ; $6cfe
	push af ; $6d00
	ld a, $0a ; $6d01
	rst Rst18 ; $6d03
	inc b ; $6d04
	ld a, [bc] ; $6d05
	pop af ; $6d06
	ld a, $12 ; $6d07
	ld b, $80 ; $6d09
	rst Rst18 ; $6d0b
	ld l, $0a ; $6d0c
	push af ; $6d0e
	ld a, $3c ; $6d0f
	rst Rst18 ; $6d11
	inc b ; $6d12
	ld a, [bc] ; $6d13
	pop af ; $6d14
	ld a, $0f ; $6d15
	ld bc, $0e00 ; $6d17
	ld de, $0f00 ; $6d1a
	rst Rst18 ; $6d1d
	inc h ; $6d1e
	ld a, [bc] ; $6d1f
	ld a, $0f ; $6d20
	rst Rst18 ; $6d22
	jr nz, Label_0e_6d2f ; $6d23
	ld a, $0f ; $6d25
	ld b, $c0 ; $6d27
	rst Rst18 ; $6d29
	ld l, $0a ; $6d2a
	push af ; $6d2c
	ld a, $04 ; $6d2d
Label_0e_6d2f:
	rst Rst18 ; $6d2f
	inc b ; $6d30
	ld a, [bc] ; $6d31
	pop af ; $6d32
	ld a, $11 ; $6d33
	ld b, $40 ; $6d35
	rst Rst18 ; $6d37
	ld l, $0a ; $6d38
	push af ; $6d3a
	ld a, $04 ; $6d3b
	rst Rst18 ; $6d3d
	inc b ; $6d3e
	ld a, [bc] ; $6d3f
	pop af ; $6d40
	ld a, $08 ; $6d41
	ld b, $40 ; $6d43
	rst Rst18 ; $6d45
	ld l, $0a ; $6d46
	push af ; $6d48
	ld a, $04 ; $6d49
	rst Rst18 ; $6d4b
	inc b ; $6d4c
	ld a, [bc] ; $6d4d
	pop af ; $6d4e
	ld a, $12 ; $6d4f
	ld b, $40 ; $6d51
	rst Rst18 ; $6d53
	ld l, $0a ; $6d54
	push af ; $6d56
	ld a, $14 ; $6d57
	rst Rst18 ; $6d59
	inc b ; $6d5a
	ld a, [bc] ; $6d5b
	pop af ; $6d5c
	ld a, $04 ; $6d5d
	ld bc, $3f00 ; $6d5f
	ld de, $3f00 ; $6d62
	rst Rst18 ; $6d65
	ld [hl+], a ; $6d66
	ld a, [bc] ; $6d67
	ld a, $05 ; $6d68
	ld bc, $3f00 ; $6d6a
	ld de, $3f00 ; $6d6d
	rst Rst18 ; $6d70
	ld [hl+], a ; $6d71
	ld a, [bc] ; $6d72
	ld a, $06 ; $6d73
	ld bc, $3f00 ; $6d75
	ld de, $3f00 ; $6d78
	rst Rst18 ; $6d7b
	ld [hl+], a ; $6d7c
	ld a, [bc] ; $6d7d
	ld a, $0f ; $6d7e
	rst Rst18 ; $6d80
	ld [$f50a], sp ; $6d81
	ld a, $0a ; $6d84
	rst Rst18 ; $6d86
	inc b ; $6d87
	ld a, [bc] ; $6d88
	pop af ; $6d89
	ld a, $0f ; $6d8a
	ld d, $04 ; $6d8c
	rst Rst18 ; $6d8e
	inc [hl] ; $6d8f
	ld a, [bc] ; $6d90
	ld a, $0f ; $6d91
	rst Rst18 ; $6d93
	ld [hl], $0a ; $6d94
	ld a, $0f ; $6d96
	ld b, $00 ; $6d98
	rst Rst18 ; $6d9a
	ld l, $0a ; $6d9b
	rst Rst08 ; $6d9d
	sbc a, c ; $6d9e
	ld a, $07 ; $6d9f
	ld bc, $0f00 ; $6da1
	ld de, $0d00 ; $6da4
	rst Rst18 ; $6da7
	ld [hl+], a ; $6da8
	ld a, [bc] ; $6da9
	push af ; $6daa
	ld a, $14 ; $6dab
	rst Rst18 ; $6dad
	inc b ; $6dae
	ld a, [bc] ; $6daf
	pop af ; $6db0
	ld a, $0f ; $6db1
	rst Rst18 ; $6db3
	ld [$c90a], sp ; $6db4
Func_0e_6db7:
	ld a, $0b ; $6db7
	ld de, $ff80 ; $6db9
	rst Rst18 ; $6dbc
	ld b, d ; $6dbd
	ld a, [bc] ; $6dbe
	push af ; $6dbf
	ld a, $14 ; $6dc0
	rst Rst18 ; $6dc2
	inc b ; $6dc3
	ld a, [bc] ; $6dc4
	pop af ; $6dc5
	ld a, $0b ; $6dc6
	rst Rst18 ; $6dc8
	ld [$3e0a], sp ; $6dc9
	inc b ; $6dcc
	ld bc, $3f00 ; $6dcd
	ld de, $3f00 ; $6dd0
	rst Rst18 ; $6dd3
	ld [hl+], a ; $6dd4
	ld a, [bc] ; $6dd5
	ld a, $05 ; $6dd6
	ld bc, $3f00 ; $6dd8
	ld de, $3f00 ; $6ddb
	rst Rst18 ; $6dde
	ld [hl+], a ; $6ddf
	ld a, [bc] ; $6de0
	ld a, $06 ; $6de1
	ld bc, $3f00 ; $6de3
	ld de, $3f00 ; $6de6
	rst Rst18 ; $6de9
	ld [hl+], a ; $6dea
	ld a, [bc] ; $6deb
	push af ; $6dec
	ld a, $0a ; $6ded
	rst Rst18 ; $6def
	inc b ; $6df0
	ld a, [bc] ; $6df1
	pop af ; $6df2
	ld a, $0f ; $6df3
	ld b, $00 ; $6df5
	rst Rst18 ; $6df7
	ld l, $0a ; $6df8
	push af ; $6dfa
	ld a, $04 ; $6dfb
	rst Rst18 ; $6dfd
	inc b ; $6dfe
	ld a, [bc] ; $6dff
	pop af ; $6e00
	ld a, $10 ; $6e01
	ld b, $00 ; $6e03
	rst Rst18 ; $6e05
	ld l, $0a ; $6e06
	push af ; $6e08
	ld a, $04 ; $6e09
	rst Rst18 ; $6e0b
	inc b ; $6e0c
	ld a, [bc] ; $6e0d
	pop af ; $6e0e
	ld a, $0e ; $6e0f
	ld b, $00 ; $6e11
	rst Rst18 ; $6e13
	ld l, $0a ; $6e14
	push af ; $6e16
	ld a, $04 ; $6e17
	rst Rst18 ; $6e19
	inc b ; $6e1a
	ld a, [bc] ; $6e1b
	pop af ; $6e1c
	ld a, $08 ; $6e1d
	ld b, $00 ; $6e1f
	rst Rst18 ; $6e21
	ld l, $0a ; $6e22
	ld a, $0a ; $6e24
	ld b, $c0 ; $6e26
	rst Rst18 ; $6e28
	ld l, $0a ; $6e29
	push af ; $6e2b
	ld a, $04 ; $6e2c
	rst Rst18 ; $6e2e
	inc b ; $6e2f
	ld a, [bc] ; $6e30
	pop af ; $6e31
	ld a, $11 ; $6e32
	ld b, $00 ; $6e34
	rst Rst18 ; $6e36
	ld l, $0a ; $6e37
	ld a, $09 ; $6e39
	ld b, $c0 ; $6e3b
	rst Rst18 ; $6e3d
	ld l, $0a ; $6e3e
	ld a, $0b ; $6e40
	ld bc, $0020 ; $6e42
	rst Rst18 ; $6e45
	jr Label_0e_6e52 ; $6e46
	INCBIN "data/bank_00e/d_6e48.bin" ; $6e48, 10 bytes
Label_0e_6e52:
	ld a, [bc] ; $6e52
	ld a, $0b ; $6e53
	rst Rst18 ; $6e55
	jr nz, Label_0e_6e62 ; $6e56
	push af ; $6e58
	ld a, $0a ; $6e59
	rst Rst18 ; $6e5b
	inc b ; $6e5c
	ld a, [bc] ; $6e5d
	pop af ; $6e5e
	ld a, $0b ; $6e5f
	rst Rst18 ; $6e61
Label_0e_6e62:
	ld [$f50a], sp ; $6e62
	ld a, $0a ; $6e65
	rst Rst18 ; $6e67
	inc b ; $6e68
	ld a, [bc] ; $6e69
	pop af ; $6e6a
	ld a, $0f ; $6e6b
	ld b, $00 ; $6e6d
	rst Rst18 ; $6e6f
	ld l, $0a ; $6e70
	rst Rst08 ; $6e72
	sbc a, c ; $6e73
	ld a, $07 ; $6e74
	ld bc, $1200 ; $6e76
	ld de, $0b00 ; $6e79
	rst Rst18 ; $6e7c
	ld [hl+], a ; $6e7d
	ld a, [bc] ; $6e7e
	push af ; $6e7f
	ld a, $0a ; $6e80
	rst Rst18 ; $6e82
	inc b ; $6e83
	ld a, [bc] ; $6e84
	pop af ; $6e85
	ld a, $0f ; $6e86
	ld d, $02 ; $6e88
	rst Rst18 ; $6e8a
	inc [hl] ; $6e8b
	ld a, [bc] ; $6e8c
	ld a, $0f ; $6e8d
	rst Rst18 ; $6e8f
	ld [hl], $0a ; $6e90
	push af ; $6e92
	ld a, $0a ; $6e93
	rst Rst18 ; $6e95
	inc b ; $6e96
	ld a, [bc] ; $6e97
	pop af ; $6e98
	ld a, $0f ; $6e99
	rst Rst18 ; $6e9b
	ld [$3e0a], sp ; $6e9c
	INCBIN "data/bank_00e/d_6e9f.bin" ; $6e9f, 140 bytes
Func_0e_6f2b:
	ld a, $10 ; $6f2b
	ld b, $c0 ; $6f2d
	rst Rst18 ; $6f2f
	ld l, $0a ; $6f30
	push af ; $6f32
	ld a, $0a ; $6f33
	rst Rst18 ; $6f35
	inc b ; $6f36
	ld a, [bc] ; $6f37
	pop af ; $6f38
	ld a, $10 ; $6f39
	rst Rst18 ; $6f3b
	ld [$f50a], sp ; $6f3c
	ld a, $0a ; $6f3f
	rst Rst18 ; $6f41
	inc b ; $6f42
	ld a, [bc] ; $6f43
	pop af ; $6f44
	ld a, $0f ; $6f45
	ld b, $40 ; $6f47
	rst Rst18 ; $6f49
	ld l, $0a ; $6f4a
	push af ; $6f4c
	ld a, $0a ; $6f4d
	rst Rst18 ; $6f4f
	inc b ; $6f50
	ld a, [bc] ; $6f51
	pop af ; $6f52
	ld a, $0e ; $6f53
	ld b, $c0 ; $6f55
	rst Rst18 ; $6f57
	ld l, $0a ; $6f58
	push af ; $6f5a
	ld a, $28 ; $6f5b
	rst Rst18 ; $6f5d
	inc b ; $6f5e
	ld a, [bc] ; $6f5f
	pop af ; $6f60
	ld a, $0f ; $6f61
	ld d, $03 ; $6f63
	rst Rst18 ; $6f65
	inc [hl] ; $6f66
	ld a, [bc] ; $6f67
	ld a, $0e ; $6f68
	ld d, $03 ; $6f6a
	rst Rst18 ; $6f6c
	inc [hl] ; $6f6d
	ld a, [bc] ; $6f6e
	ld a, $0e ; $6f6f
	rst Rst18 ; $6f71
	ld [hl], $0a ; $6f72
	push af ; $6f74
	ld a, $0a ; $6f75
	rst Rst18 ; $6f77
	inc b ; $6f78
	ld a, [bc] ; $6f79
	pop af ; $6f7a
	ld a, $0f ; $6f7b
	ld b, $c0 ; $6f7d
	rst Rst18 ; $6f7f
	ld l, $0a ; $6f80
	push af ; $6f82
	ld a, $04 ; $6f83
	rst Rst18 ; $6f85
	inc b ; $6f86
	ld a, [bc] ; $6f87
	pop af ; $6f88
	ld a, $0e ; $6f89
	ld b, $c0 ; $6f8b
	rst Rst18 ; $6f8d
	ld l, $0a ; $6f8e
	push af ; $6f90
	ld a, $0a ; $6f91
	rst Rst18 ; $6f93
	inc b ; $6f94
	ld a, [bc] ; $6f95
	pop af ; $6f96
	ld a, $0e ; $6f97
	ld de, rLCDC ; $6f99
	rst Rst18 ; $6f9c
	ld b, d ; $6f9d
	ld a, [bc] ; $6f9e
	push af ; $6f9f
	ld a, $28 ; $6fa0
	rst Rst18 ; $6fa2
	inc b ; $6fa3
	ld a, [bc] ; $6fa4
	pop af ; $6fa5
	ld a, $0e ; $6fa6
	rst Rst18 ; $6fa8
	ld [$f50a], sp ; $6fa9
	ld a, $0a ; $6fac
	rst Rst18 ; $6fae
	inc b ; $6faf
	ld a, [bc] ; $6fb0
	pop af ; $6fb1
	rst Rst08 ; $6fb2
	sub a, [hl] ; $6fb3
	ld a, $04 ; $6fb4
	ld bc, $1300 ; $6fb6
	ld de, $0900 ; $6fb9
	rst Rst18 ; $6fbc
	ld [hl+], a ; $6fbd
	ld a, [bc] ; $6fbe
	ld a, $05 ; $6fbf
	ld bc, $1700 ; $6fc1
	ld de, $0900 ; $6fc4
	rst Rst18 ; $6fc7
	ld [hl+], a ; $6fc8
	ld a, [bc] ; $6fc9
	push af ; $6fca
	ld a, $14 ; $6fcb
	rst Rst18 ; $6fcd
	inc b ; $6fce
	ld a, [bc] ; $6fcf
	pop af ; $6fd0
	ld a, $08 ; $6fd1
	ld b, $00 ; $6fd3
	rst Rst18 ; $6fd5
	ld l, $0a ; $6fd6
	push af ; $6fd8
	ld a, $0a ; $6fd9
	rst Rst18 ; $6fdb
	inc b ; $6fdc
	ld a, [bc] ; $6fdd
	pop af ; $6fde
	ld a, $12 ; $6fdf
	ld b, $80 ; $6fe1
	rst Rst18 ; $6fe3
	ld l, $0a ; $6fe4
	push af ; $6fe6
	ld a, $14 ; $6fe7
	rst Rst18 ; $6fe9
	inc b ; $6fea
	ld a, [bc] ; $6feb
	pop af ; $6fec
	ld a, $04 ; $6fed
	ld bc, $3f00 ; $6fef
	ld de, $3f00 ; $6ff2
	rst Rst18 ; $6ff5
	ld [hl+], a ; $6ff6
	ld a, [bc] ; $6ff7
	ld a, $05 ; $6ff8
	ld bc, $3f00 ; $6ffa
	ld de, $3f00 ; $6ffd
	rst Rst18 ; $7000
	ld [hl+], a ; $7001
	ld a, [bc] ; $7002
	push af ; $7003
	ld a, $14 ; $7004
	rst Rst18 ; $7006
	inc b ; $7007
	ld a, [bc] ; $7008
	pop af ; $7009
	ld a, $08 ; $700a
	ld d, $03 ; $700c
	rst Rst18 ; $700e
	inc [hl] ; $700f
	ld a, [bc] ; $7010
	ld a, $12 ; $7011
	ld d, $03 ; $7013
	rst Rst18 ; $7015
	inc [hl] ; $7016
	ld a, [bc] ; $7017
	ld a, $12 ; $7018
	rst Rst18 ; $701a
	ld [hl], $0a ; $701b
	push af ; $701d
	ld a, $0a ; $701e
	rst Rst18 ; $7020
	inc b ; $7021
	ld a, [bc] ; $7022
	pop af ; $7023
	ld a, $08 ; $7024
	ld b, $40 ; $7026
	rst Rst18 ; $7028
	ld l, $0a ; $7029
	push af ; $702b
	ld a, $0a ; $702c
	rst Rst18 ; $702e
	inc b ; $702f
	ld a, [bc] ; $7030
	pop af ; $7031
	ld a, $12 ; $7032
	ld b, $40 ; $7034
	rst Rst18 ; $7036
	ld l, $0a ; $7037
	ld a, $08 ; $7039
	rst Rst18 ; $703b
	ld [$f50a], sp ; $703c
	ld a, $14 ; $703f
	rst Rst18 ; $7041
	inc b ; $7042
	ld a, [bc] ; $7043
	pop af ; $7044
	ld a, $0f ; $7045
	ld d, $03 ; $7047
	rst Rst18 ; $7049
	inc [hl] ; $704a
	ld a, [bc] ; $704b
	ld a, $10 ; $704c
	ld d, $03 ; $704e
	rst Rst18 ; $7050
	inc [hl] ; $7051
	ld a, [bc] ; $7052
	ld a, $0e ; $7053
	ld d, $03 ; $7055
	rst Rst18 ; $7057
	inc [hl] ; $7058
	ld a, [bc] ; $7059
	ld a, $0e ; $705a
	rst Rst18 ; $705c
	ld [hl], $0a ; $705d
	push af ; $705f
	ld a, $14 ; $7060
	rst Rst18 ; $7062
	inc b ; $7063
	ld a, [bc] ; $7064
	pop af ; $7065
	ld a, $10 ; $7066
	ld de, $ff80 ; $7068
	rst Rst18 ; $706b
	ld b, d ; $706c
	ld a, [bc] ; $706d
	push af ; $706e
	ld a, $28 ; $706f
	rst Rst18 ; $7071
	inc b ; $7072
	ld a, [bc] ; $7073
	pop af ; $7074
	ld a, $10 ; $7075
	rst Rst18 ; $7077
	ld [$f50a], sp ; $7078
	ld a, $0a ; $707b
	rst Rst18 ; $707d
	inc b ; $707e
	ld a, [bc] ; $707f
	pop af ; $7080
	ret ; $7081
Func_0e_7082:
	push af ; $7082
	ld a, $0a ; $7083
	rst Rst18 ; $7085
	inc b ; $7086
	ld a, [bc] ; $7087
	pop af ; $7088
	rst Rst08 ; $7089
	sbc a, c ; $708a
	ld a, $07 ; $708b
	ld bc, $1400 ; $708d
	ld de, $0d00 ; $7090
	rst Rst18 ; $7093
	ld [hl+], a ; $7094
	ld a, [bc] ; $7095
	push af ; $7096
	ld a, $28 ; $7097
	rst Rst18 ; $7099
	inc b ; $709a
	ld a, [bc] ; $709b
	pop af ; $709c
	ld a, $0f ; $709d
	rst Rst18 ; $709f
	ld [$f50a], sp ; $70a0
	ld a, $14 ; $70a3
	rst Rst18 ; $70a5
	inc b ; $70a6
	ld a, [bc] ; $70a7
	pop af ; $70a8
	ld a, $07 ; $70a9
	ld bc, $3f00 ; $70ab
	ld de, $3f00 ; $70ae
	rst Rst18 ; $70b1
	ld [hl+], a ; $70b2
	ld a, [bc] ; $70b3
	ld a, $08 ; $70b4
	ld d, $02 ; $70b6
	rst Rst18 ; $70b8
	inc [hl] ; $70b9
	ld a, [bc] ; $70ba
	ld a, $08 ; $70bb
	rst Rst18 ; $70bd
	ld [hl], $0a ; $70be
	ld a, $08 ; $70c0
	rst Rst18 ; $70c2
	ld [$f50a], sp ; $70c3
	ld a, $0a ; $70c6
	rst Rst18 ; $70c8
	inc b ; $70c9
	ld a, [bc] ; $70ca
	pop af ; $70cb
	ld a, $08 ; $70cc
	ld d, $03 ; $70ce
	rst Rst18 ; $70d0
	inc [hl] ; $70d1
	ld a, [bc] ; $70d2
	ld a, $08 ; $70d3
	rst Rst18 ; $70d5
	ld [hl], $0a ; $70d6
	push af ; $70d8
	ld a, $0a ; $70d9
	rst Rst18 ; $70db
	inc b ; $70dc
	ld a, [bc] ; $70dd
	pop af ; $70de
	ld a, $08 ; $70df
	rst Rst18 ; $70e1
	ld [$3e0a], sp ; $70e2
	rrca ; $70e5
	ld de, $ff80 ; $70e6
	rst Rst18 ; $70e9
	ld b, d ; $70ea
	ld a, [bc] ; $70eb
	push af ; $70ec
	ld a, $14 ; $70ed
	rst Rst18 ; $70ef
	inc b ; $70f0
	ld a, [bc] ; $70f1
	pop af ; $70f2
	rst Rst08 ; $70f3
	ld [hl], b ; $70f4
	ld a, $04 ; $70f5
	rst Rst18 ; $70f7
	ld b, b ; $70f8
	ld a, [bc] ; $70f9
	push af ; $70fa
	ld a, $0a ; $70fb
	rst Rst18 ; $70fd
	inc b ; $70fe
	ld a, [bc] ; $70ff
	pop af ; $7100
	ld a, $00 ; $7101
	rst Rst18 ; $7103
	ld b, b ; $7104
	ld a, [bc] ; $7105
	push af ; $7106
	ld a, $1e ; $7107
	rst Rst18 ; $7109
	inc b ; $710a
	ld a, [bc] ; $710b
	pop af ; $710c
	ld a, $10 ; $710d
	ld bc, $0c00 ; $710f
	ld de, $0d00 ; $7112
	rst Rst18 ; $7115
	inc h ; $7116
	ld a, [bc] ; $7117
	ld a, $0e ; $7118
	ld bc, $0c00 ; $711a
	ld de, $1100 ; $711d
	rst Rst18 ; $7120
	inc h ; $7121
	ld a, [bc] ; $7122
	push af ; $7123
	ld a, $14 ; $7124
	rst Rst18 ; $7126
	inc b ; $7127
	ld a, [bc] ; $7128
	pop af ; $7129
	ld a, $0f ; $712a
	ld bc, $0c00 ; $712c
	ld de, $0f00 ; $712f
	rst Rst18 ; $7132
	inc h ; $7133
	ld a, [bc] ; $7134
	ld a, $0f ; $7135
	rst Rst18 ; $7137
	jr nz, Label_0e_7144 ; $7138
	ld a, $10 ; $713a
	ld b, $00 ; $713c
	rst Rst18 ; $713e
	ld l, $0a ; $713f
	ld a, $0e ; $7141
	INCBIN "data/bank_00e/d_7143.bin" ; $7143, 1 bytes
Label_0e_7144:
	nop ; $7144
	rst Rst18 ; $7145
	ld l, $0a ; $7146
	ld a, $0f ; $7148
	ld b, $00 ; $714a
	rst Rst18 ; $714c
	ld l, $0a ; $714d
	ret ; $714f
Func_0e_7150:
	ldh a, [$ff96] ; $7150
	push af ; $7152
	ld hl, $72ce ; $7153
	ld de, $0901 ; $7156
	call Func_00_05b0 ; $7159
	ld hl, $72e0 ; $715c
	ld de, $a000 ; $715f
	ld c, $18 ; $7162
	call Func_00_0480 ; $7164
	ld hl, $7460 ; $7167
	ld de, $a180 ; $716a
	ld c, $02 ; $716d
	call Func_00_0480 ; $716f
	ld a, $06 ; $7172
	ldh [$ff96], a ; $7174
	ldh [rWBK], a ; $7176
	xor a, a ; $7178
	ld hl, $d000 ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a, a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	ld b, $00 ; $7192
	ld c, $2b ; $7194
	ld d, $1a ; $7196
	ld e, $0c ; $7198
	ld h, $04 ; $719a
	ld l, $02 ; $719c
	rst Rst18 ; $719e
	ld a, [hl] ; $719f
	ld a, [bc] ; $71a0
	ld b, $04 ; $71a1
	ld c, $2d ; $71a3
	ld d, $14 ; $71a5
	ld e, $14 ; $71a7
	ld h, $06 ; $71a9
	ld l, $02 ; $71ab
	rst Rst18 ; $71ad
	ld a, [hl] ; $71ae
	ld a, [bc] ; $71af
	ld b, $0a ; $71b0
	ld c, $2b ; $71b2
	ld d, $1a ; $71b4
	ld e, $12 ; $71b6
	ld h, $06 ; $71b8
	ld l, $02 ; $71ba
	rst Rst18 ; $71bc
	ld a, [hl] ; $71bd
	ld a, [bc] ; $71be
	rst Rst08 ; $71bf
	add hl, bc ; $71c0
	ld a, $01 ; $71c1
	ld hl, $71e9 ; $71c3
	call Func_00_1b6a ; $71c6
	ld a, $06 ; $71c9
	ldh [$ff96], a ; $71cb
	ldh [rWBK], a ; $71cd
Label_0e_71cf:
	call Func_00_2631 ; $71cf
	ld a, [$d002] ; $71d2
	cp a, $1e ; $71d5
	jr z, Label_0e_71e2 ; $71d7
	or a, a ; $71d9
	jr nz, Label_0e_71cf ; $71da
	pop af ; $71dc
	ldh [$ff96], a ; $71dd
	ldh [rWBK], a ; $71df
	ret ; $71e1
Label_0e_71e2:
	ld c, $03 ; $71e2
	call Func_00_1d20 ; $71e4
	jr Label_0e_71cf ; $71e7
	INCBIN "data/bank_00e/d_71e9.bin" ; $71e9, 2343 bytes
	ret ; $7b10
	INCBIN "data/bank_00e/d_7b11.bin" ; $7b11, 1263 bytes
