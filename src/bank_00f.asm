INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

	INCBIN "data/bank_00f/d_4000.bin" ; $4000, 1417 bytes
	rst Rst18 ; $4589
	inc [hl] ; $458a
	ld a, [bc] ; $458b
	ld a, $08 ; $458c
	rst Rst18 ; $458e
	ld [hl], $0a ; $458f
	ld a, $08 ; $4591
	rst Rst18 ; $4593
	ld [$3e0a], sp ; $4594
	inc d ; $4597
	ld bc, $0c80 ; $4598
	ld de, $1900 ; $459b
	rst Rst18 ; $459e
	ld [hl+], a ; $459f
	ld a, [bc] ; $45a0
	rst Rst08 ; $45a1
	sub a, [hl] ; $45a2
	ld a, $78 ; $45a3
	call Func_0f_5678 ; $45a5
	ld a, $14 ; $45a8
	ld bc, $3f00 ; $45aa
	ld de, $3f00 ; $45ad
	rst Rst18 ; $45b0
	ld [hl+], a ; $45b1
	ld a, [bc] ; $45b2
	jp Label_0f_4661 ; $45b3
	INCBIN "data/bank_00f/d_45b6.bin" ; $45b6, 168 bytes
	rst Rst18 ; $465e
	ld [hl+], a ; $465f
	ld a, [bc] ; $4660
Label_0f_4661:
	call Func_0f_567f ; $4661
	call Func_0f_567f ; $4664
	ld a, $08 ; $4667
	rst Rst18 ; $4669
	ld [$cd0a], sp ; $466a
	ld a, a ; $466d
	ld d, [hl] ; $466e
	call Func_0f_567f ; $466f
	ld a, $08 ; $4672
	ld bc, $0900 ; $4674
	ld de, $1d00 ; $4677
	rst Rst18 ; $467a
	inc h ; $467b
	ld a, [bc] ; $467c
	ld a, $08 ; $467d
	rst Rst18 ; $467f
	jr nz, Label_0f_468c ; $4680
	ld a, $08 ; $4682
	ld b, $00 ; $4684
	rst Rst18 ; $4686
	ld l, $0a ; $4687
	ld a, $01 ; $4689
	INCBIN "data/bank_00f/d_468b.bin" ; $468b, 1 bytes
Label_0f_468c:
	ld a, b ; $468c
	ld d, [hl] ; $468d
	ld a, $16 ; $468e
	ld bc, $3f00 ; $4690
	ld de, $3f00 ; $4693
	rst Rst18 ; $4696
	ld [hl+], a ; $4697
	ld a, [bc] ; $4698
	rst Rst30 ; $4699
	ldh [rTIMA], a ; $469a
	jp z, Label_0f_4700 ; $469c
	ld a, $15 ; $469f
	ld bc, $3f00 ; $46a1
	ld de, $3f00 ; $46a4
	rst Rst18 ; $46a7
	ld [hl+], a ; $46a8
	ld a, [bc] ; $46a9
	ld d, $4d ; $46aa
	ld a, $15 ; $46ac
	rst Rst18 ; $46ae
	ld d, $0a ; $46af
	ld c, l ; $46b1
	ld b, h ; $46b2
	rst Rst18 ; $46b3
	inc l ; $46b4
	inc b ; $46b5
	ld a, $15 ; $46b6
	ld d, $01 ; $46b8
	rst Rst18 ; $46ba
	inc [hl] ; $46bb
	ld a, [bc] ; $46bc
	ld a, $00 ; $46bd
	ld b, $40 ; $46bf
	rst Rst18 ; $46c1
	ld l, $0a ; $46c2
	ld a, $00 ; $46c4
	ld bc, $0b00 ; $46c6
	ld de, $1b00 ; $46c9
	rst Rst18 ; $46cc
	ld [hl+], a ; $46cd
	ld a, [bc] ; $46ce
	ld a, $02 ; $46cf
	ld bc, $0d00 ; $46d1
	ld de, $1b00 ; $46d4
	rst Rst18 ; $46d7
	ld [hl+], a ; $46d8
	ld a, [bc] ; $46d9
	ld a, $01 ; $46da
	call Func_0f_5678 ; $46dc
	ld a, $00 ; $46df
	ld b, $40 ; $46e1
	rst Rst18 ; $46e3
	ld l, $0a ; $46e4
	ld a, $02 ; $46e6
	ld b, $40 ; $46e8
	rst Rst18 ; $46ea
	ld l, $0a ; $46eb
	ld a, $01 ; $46ed
	call Func_0f_5678 ; $46ef
	ld a, $02 ; $46f2
	rst Rst18 ; $46f4
	ld d, $0a ; $46f5
	ld c, l ; $46f7
	ld b, h ; $46f8
	ld de, $d000 ; $46f9
	rst Rst18 ; $46fc
	jr nz, $4703 ; $46fd
	ret ; $46ff
Label_0f_4700:
	ld a, $00 ; $4700
	ld bc, $0b80 ; $4702
	ld de, $1b00 ; $4705
	rst Rst18 ; $4708
	ld [hl+], a ; $4709
	ld a, [bc] ; $470a
	ld a, $00 ; $470b
	ld b, $40 ; $470d
	rst Rst18 ; $470f
	ld l, $0a ; $4710
	ld a, $01 ; $4712
	call Func_0f_5678 ; $4714
	ld a, $03 ; $4717
	rst Rst18 ; $4719
	ld d, $0a ; $471a
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, $d000 ; $471e
	rst Rst18 ; $4721
	jr nz, Label_0f_4728 ; $4722
	ret ; $4724
	INCBIN "data/bank_00f/d_4725.bin" ; $4725, 3 bytes
Label_0f_4728:
	jp nz, Label_0f_4ea7 ; $4728
	ld a, $03 ; $472b
	rst Rst18 ; $472d
	inc e ; $472e
	ld a, [bc] ; $472f
	ld a, $00 ; $4730
	ld bc, $0c00 ; $4732
	ld de, $1900 ; $4735
	rst Rst18 ; $4738
	inc h ; $4739
	ld a, [bc] ; $473a
	ld a, $03 ; $473b
	ld bc, $0c00 ; $473d
	ld de, $1b00 ; $4740
	rst Rst18 ; $4743
	inc h ; $4744
	ld a, [bc] ; $4745
	ld a, $03 ; $4746
	rst Rst18 ; $4748
	jr nz, Label_0f_4755 ; $4749
	ld a, $0a ; $474b
	call Func_0f_5678 ; $474d
	ld a, $0b ; $4750
	ld b, a ; $4752
	ld a, $00 ; $4753
Label_0f_4755:
	rst Rst18 ; $4755
	jr nc, Label_0f_4762 ; $4756
	ld a, $03 ; $4758
	ld b, $c0 ; $475a
	rst Rst18 ; $475c
	ld l, $0a ; $475d
	ld a, $3c ; $475f
	INCBIN "data/bank_00f/d_4761.bin" ; $4761, 1 bytes
Label_0f_4762:
	ld a, b ; $4762
	ld d, [hl] ; $4763
	call Func_0f_5c52 ; $4764
	ld a, $00 ; $4767
	ld b, $40 ; $4769
	rst Rst18 ; $476b
	ld l, $0a ; $476c
	ld a, $04 ; $476e
	ld bc, $0c00 ; $4770
	ld de, $1d00 ; $4773
	rst Rst18 ; $4776
	inc h ; $4777
	ld a, [bc] ; $4778
	ld a, $04 ; $4779
	rst Rst18 ; $477b
	jr nz, Label_0f_4788 ; $477c
	ld a, $0a ; $477e
	call Func_0f_5678 ; $4780
	call Func_0f_5c96 ; $4783
	ld a, $00 ; $4786
Label_0f_4788:
	ld bc, $0020 ; $4788
	rst Rst18 ; $478b
	jr Label_0f_4798 ; $478c
	INCBIN "data/bank_00f/d_478e.bin" ; $478e, 10 bytes
Label_0f_4798:
	ld bc, $0020 ; $4798
	rst Rst18 ; $479b
	jr Label_0f_47a8 ; $479c
	INCBIN "data/bank_00f/d_479e.bin" ; $479e, 10 bytes
Label_0f_47a8:
	ld a, [bc] ; $47a8
	ldh a, [$ff95] ; $47a9
	ld b, a ; $47ab
	ld a, $03 ; $47ac
	ld de, $5665 ; $47ae
	rst Rst18 ; $47b1
	ld a, [de] ; $47b2
	ld a, [bc] ; $47b3
	ldh a, [$ff95] ; $47b4
	ld b, a ; $47b6
	ld a, $04 ; $47b7
	ld de, $5665 ; $47b9
	rst Rst18 ; $47bc
	ld a, [de] ; $47bd
	ld a, [bc] ; $47be
	ld a, $b4 ; $47bf
	call Func_0f_5678 ; $47c1
	ld a, $00 ; $47c4
	ld bc, $0c00 ; $47c6
	ld de, $0d40 ; $47c9
	rst Rst18 ; $47cc
	ld [hl+], a ; $47cd
	ld a, [bc] ; $47ce
	ld a, $03 ; $47cf
	ld bc, $0e00 ; $47d1
	ld de, $0e40 ; $47d4
	rst Rst18 ; $47d7
	ld [hl+], a ; $47d8
	ld a, [bc] ; $47d9
	ld a, $04 ; $47da
	ld bc, $0a00 ; $47dc
	ld de, $0dc0 ; $47df
	rst Rst18 ; $47e2
	ld [hl+], a ; $47e3
	ld a, [bc] ; $47e4
	call Func_0f_5641 ; $47e5
	ld a, $16 ; $47e8
	ld bc, $0c00 ; $47ea
	ld de, $0d40 ; $47ed
	rst Rst18 ; $47f0
	ld [hl+], a ; $47f1
	ld a, [bc] ; $47f2
	ld a, $16 ; $47f3
	ld b, $40 ; $47f5
	rst Rst18 ; $47f7
	ld l, $0a ; $47f8
	ld a, $03 ; $47fa
	ld b, $40 ; $47fc
	rst Rst18 ; $47fe
	ld l, $0a ; $47ff
	ld a, $04 ; $4801
	ld b, $40 ; $4803
	rst Rst18 ; $4805
	ld l, $0a ; $4806
	ld bc, $0006 ; $4808
	rst Rst18 ; $480b
	jr c, Label_0f_4818 ; $480c
	xor a, a ; $480e
	ld bc, $0c00 ; $480f
	ld de, $1300 ; $4812
	rst Rst18 ; $4815
	ld a, [hl-] ; $4816
	ld a, [bc] ; $4817
Label_0f_4818:
	rst Rst18 ; $4818
	ld a, $0a ; $4819
	call Func_0f_5ccf ; $481b
	ld a, $0c ; $481e
	ld bc, $0e00 ; $4820
	ld de, $1300 ; $4823
	rst Rst18 ; $4826
	inc h ; $4827
	ld a, [bc] ; $4828
	ld a, $0c ; $4829
	rst Rst18 ; $482b
	jr nz, Label_0f_4838 ; $482c
	ld a, $0c ; $482e
	ld b, $c0 ; $4830
	rst Rst18 ; $4832
	ld l, $0a ; $4833
	ld a, $0f ; $4835
	INCBIN "data/bank_00f/d_4837.bin" ; $4837, 1 bytes
Label_0f_4838:
	stop ; $4838
	rst Rst18 ; $483a
	jr Label_0f_4847 ; $483b
	INCBIN "data/bank_00f/d_483d.bin" ; $483d, 10 bytes
Label_0f_4847:
	ld bc, $1100 ; $4847
	ld de, $1600 ; $484a
	rst Rst18 ; $484d
	inc h ; $484e
	ld a, [bc] ; $484f
	ld a, $10 ; $4850
	rst Rst18 ; $4852
	jr nz, Label_0f_485f ; $4853
	ld a, $10 ; $4855
	ld b, $40 ; $4857
	rst Rst18 ; $4859
	ld l, $0a ; $485a
	ld a, $14 ; $485c
	INCBIN "data/bank_00f/d_485e.bin" ; $485e, 1 bytes
Label_0f_485f:
	ld a, b ; $485f
	ld d, [hl] ; $4860
	ld a, $0f ; $4861
	ld bc, $1180 ; $4863
	ld de, $1600 ; $4866
	rst Rst18 ; $4869
	ld [hl+], a ; $486a
	ld a, [bc] ; $486b
	ld a, $14 ; $486c
	call Func_0f_5678 ; $486e
	call Func_0f_5e4a ; $4871
	ld d, $5c ; $4874
	ld a, $11 ; $4876
	rst Rst18 ; $4878
	ld d, $0a ; $4879
	ld c, l ; $487b
	ld b, h ; $487c
	rst Rst18 ; $487d
	inc l ; $487e
	inc b ; $487f
	ld a, $11 ; $4880
	ld d, $01 ; $4882
	rst Rst18 ; $4884
	inc [hl] ; $4885
	ld a, [bc] ; $4886
	ld a, $03 ; $4887
	ld bc, $3f00 ; $4889
	ld de, $3f00 ; $488c
	rst Rst18 ; $488f
	ld [hl+], a ; $4890
	ld a, [bc] ; $4891
	ld a, $11 ; $4892
	ld bc, $0e00 ; $4894
	ld de, $0e40 ; $4897
	rst Rst18 ; $489a
	ld [hl+], a ; $489b
	ld a, [bc] ; $489c
	ld a, $11 ; $489d
	ld b, $40 ; $489f
	rst Rst18 ; $48a1
	ld l, $0a ; $48a2
	ld a, $0c ; $48a4
	ld bc, $0010 ; $48a6
	rst Rst18 ; $48a9
	jr Label_0f_48b6 ; $48aa
	INCBIN "data/bank_00f/d_48ac.bin" ; $48ac, 10 bytes
Label_0f_48b6:
	ld bc, $0e00 ; $48b6
	ld de, $1100 ; $48b9
	rst Rst18 ; $48bc
	inc h ; $48bd
	ld a, [bc] ; $48be
	ld a, $0f ; $48bf
	ld bc, $0e00 ; $48c1
	ld de, $1000 ; $48c4
	rst Rst18 ; $48c7
	inc h ; $48c8
	ld a, [bc] ; $48c9
	ld a, $0f ; $48ca
	rst Rst18 ; $48cc
	jr nz, Label_0f_48d9 ; $48cd
	ld a, $1e ; $48cf
	call Func_0f_5678 ; $48d1
	ld a, $0c ; $48d4
	rst Rst18 ; $48d6
	INCBIN "data/bank_00f/d_48d7.bin" ; $48d7, 2 bytes
Label_0f_48d9:
	ld a, $1e ; $48d9
	call Func_0f_5678 ; $48db
	ld a, $0c ; $48de
	ld bc, $0e00 ; $48e0
	ld de, $1040 ; $48e3
	rst Rst18 ; $48e6
	inc h ; $48e7
	ld a, [bc] ; $48e8
	ld a, $0f ; $48e9
	ld bc, $0e00 ; $48eb
	ld de, $0f40 ; $48ee
	rst Rst18 ; $48f1
	inc h ; $48f2
	ld a, [bc] ; $48f3
	ld a, $0f ; $48f4
	rst Rst18 ; $48f6
	jr nz, Label_0f_4903 ; $48f7
	ld a, $05 ; $48f9
	call Func_0f_5678 ; $48fb
	ld a, $0c ; $48fe
	ld b, $01 ; $4900
	rst Rst18 ; $4902
Label_0f_4903:
	inc l ; $4903
	ld a, [bc] ; $4904
	ld a, $0c ; $4905
	ld bc, $0e00 ; $4907
	ld de, $1100 ; $490a
	rst Rst18 ; $490d
	inc h ; $490e
	ld a, [bc] ; $490f
	ld a, $0c ; $4910
	rst Rst18 ; $4912
	jr nz, Label_0f_491f ; $4913
	ld a, $0c ; $4915
	ld b, $00 ; $4917
	rst Rst18 ; $4919
	inc l ; $491a
	ld a, [bc] ; $491b
	ld a, $0c ; $491c
	INCBIN "data/bank_00f/d_491e.bin" ; $491e, 1 bytes
Label_0f_491f:
	ret nz ; $491f
	rst Rst18 ; $4920
	ld l, $0a ; $4921
	ld a, $14 ; $4923
	call Func_0f_5678 ; $4925
	ld a, $0f ; $4928
	ld bc, $3f00 ; $492a
	ld de, $3f00 ; $492d
	rst Rst18 ; $4930
	ld [hl+], a ; $4931
	ld a, [bc] ; $4932
	ld a, $11 ; $4933
	ld d, $02 ; $4935
	rst Rst18 ; $4937
	inc [hl] ; $4938
	ld a, [bc] ; $4939
	ld a, $11 ; $493a
	rst Rst18 ; $493c
	ld [hl], $0a ; $493d
	ld a, $11 ; $493f
	rst Rst18 ; $4941
	ld [$3e0a], sp ; $4942
	dec d ; $4945
	ld bc, $0f80 ; $4946
	ld de, $0f80 ; $4949
	rst Rst18 ; $494c
	ld [hl+], a ; $494d
	ld a, [bc] ; $494e
	rst Rst08 ; $494f
	sbc a, b ; $4950
	ld a, $78 ; $4951
	call Func_0f_5678 ; $4953
	ld a, $15 ; $4956
	ld bc, $3f00 ; $4958
	ld de, $3f00 ; $495b
	rst Rst18 ; $495e
	ld [hl+], a ; $495f
	ld a, [bc] ; $4960
	ld a, $11 ; $4961
	ld d, $04 ; $4963
	rst Rst18 ; $4965
	inc [hl] ; $4966
	ld a, [bc] ; $4967
	ld a, $11 ; $4968
	rst Rst18 ; $496a
	ld [hl], $0a ; $496b
	ld a, $11 ; $496d
	rst Rst18 ; $496f
	ld [$3e0a], sp ; $4970
	ld d, $df ; $4973
	ld d, $0a ; $4975
	ld a, $01 ; $4977
	ld e, l ; $4979
	ld d, h ; $497a
	ld hl, $0018 ; $497b
	add hl, de ; $497e
	ld [hl], a ; $497f
	ld a, $0c ; $4980
	rst Rst18 ; $4982
	ld d, $0a ; $4983
	ld a, $01 ; $4985
	ld e, l ; $4987
	ld d, h ; $4988
	ld hl, $0018 ; $4989
	add hl, de ; $498c
	ld [hl], a ; $498d
	ld a, $16 ; $498e
	ld d, $02 ; $4990
	rst Rst18 ; $4992
	inc [hl] ; $4993
	ld a, [bc] ; $4994
	ld a, $16 ; $4995
	rst Rst18 ; $4997
	ld [hl], $0a ; $4998
	ld a, $0c ; $499a
	ld d, $03 ; $499c
	rst Rst18 ; $499e
	inc [hl] ; $499f
	ld a, [bc] ; $49a0
	ld a, $0c ; $49a1
	rst Rst18 ; $49a3
	ld [hl], $0a ; $49a4
	ld a, $0c ; $49a6
	rst Rst18 ; $49a8
	ld [$3e0a], sp ; $49a9
	ld e, $cd ; $49ac
	ld a, b ; $49ae
	ld d, [hl] ; $49af
	ld a, $0c ; $49b0
	ld bc, $0e00 ; $49b2
	ld de, $1300 ; $49b5
	rst Rst18 ; $49b8
	inc h ; $49b9
	ld a, [bc] ; $49ba
	ld a, $0c ; $49bb
	rst Rst18 ; $49bd
	jr nz, Label_0f_49ca ; $49be
	ld a, $0c ; $49c0
	ld bc, $0a00 ; $49c2
	ld de, $1300 ; $49c5
	rst Rst18 ; $49c8
	inc h ; $49c9
Label_0f_49ca:
	ld a, [bc] ; $49ca
	ld a, $0c ; $49cb
	rst Rst18 ; $49cd
	jr nz, Label_0f_49da ; $49ce
	ld a, $0c ; $49d0
	ld b, $c0 ; $49d2
	rst Rst18 ; $49d4
	ld l, $0a ; $49d5
	ld a, $14 ; $49d7
	INCBIN "data/bank_00f/d_49d9.bin" ; $49d9, 1 bytes
Label_0f_49da:
	ld a, b ; $49da
	ld d, [hl] ; $49db
	ld a, $0e ; $49dc
	ld bc, $0010 ; $49de
	rst Rst18 ; $49e1
	jr Label_0f_49ee ; $49e2
	INCBIN "data/bank_00f/d_49e4.bin" ; $49e4, 10 bytes
Label_0f_49ee:
	ld bc, $1000 ; $49ee
	ld de, $1600 ; $49f1
	rst Rst18 ; $49f4
	inc h ; $49f5
	ld a, [bc] ; $49f6
	ld a, $10 ; $49f7
	rst Rst18 ; $49f9
	jr nz, Label_0f_4a06 ; $49fa
	ld a, $10 ; $49fc
	ld b, $40 ; $49fe
	rst Rst18 ; $4a00
	ld l, $0a ; $4a01
	ld a, $14 ; $4a03
	INCBIN "data/bank_00f/d_4a05.bin" ; $4a05, 1 bytes
Label_0f_4a06:
	ld a, b ; $4a06
	ld d, [hl] ; $4a07
	ld a, $0e ; $4a08
	ld bc, $1080 ; $4a0a
	ld de, $1600 ; $4a0d
	rst Rst18 ; $4a10
	ld [hl+], a ; $4a11
	ld a, [bc] ; $4a12
	ld a, $14 ; $4a13
	call Func_0f_5678 ; $4a15
	ld d, $74 ; $4a18
	ld a, $10 ; $4a1a
	rst Rst18 ; $4a1c
	ld d, $0a ; $4a1d
	ld c, l ; $4a1f
	ld b, h ; $4a20
	rst Rst18 ; $4a21
	inc l ; $4a22
	inc b ; $4a23
	ld a, $10 ; $4a24
	ld d, $01 ; $4a26
	rst Rst18 ; $4a28
	inc [hl] ; $4a29
	ld a, [bc] ; $4a2a
	ld d, $25 ; $4a2b
	ld a, $0e ; $4a2d
	rst Rst18 ; $4a2f
	ld d, $0a ; $4a30
	ld c, l ; $4a32
	ld b, h ; $4a33
	rst Rst18 ; $4a34
	inc l ; $4a35
	inc b ; $4a36
	ld a, $0e ; $4a37
	ld d, $01 ; $4a39
	rst Rst18 ; $4a3b
	inc [hl] ; $4a3c
	ld a, [bc] ; $4a3d
	ld a, $0e ; $4a3e
	ld bc, $1000 ; $4a40
	ld de, $1600 ; $4a43
	rst Rst18 ; $4a46
	ld [hl+], a ; $4a47
	ld a, [bc] ; $4a48
	ld a, $10 ; $4a49
	ld bc, $1000 ; $4a4b
	ld de, $1500 ; $4a4e
	rst Rst18 ; $4a51
	ld [hl+], a ; $4a52
	ld a, [bc] ; $4a53
	ld a, $0e ; $4a54
	ld b, $c0 ; $4a56
	rst Rst18 ; $4a58
	ld l, $0a ; $4a59
	ld a, $10 ; $4a5b
	ld d, $08 ; $4a5d
	rst Rst18 ; $4a5f
	inc [hl] ; $4a60
	ld a, [bc] ; $4a61
	ld a, $10 ; $4a62
	ld bc, $1000 ; $4a64
	ld de, $1200 ; $4a67
	rst Rst18 ; $4a6a
	inc h ; $4a6b
	ld a, [bc] ; $4a6c
	ld a, $0e ; $4a6d
	ld bc, $1000 ; $4a6f
	ld de, $1300 ; $4a72
	rst Rst18 ; $4a75
	inc h ; $4a76
	ld a, [bc] ; $4a77
	ld a, $0e ; $4a78
	rst Rst18 ; $4a7a
	jr nz, Label_0f_4a87 ; $4a7b
	ld d, $25 ; $4a7d
	ld a, $10 ; $4a7f
	rst Rst18 ; $4a81
	ld d, $0a ; $4a82
	ld c, l ; $4a84
	ld b, h ; $4a85
	rst Rst18 ; $4a86
Label_0f_4a87:
	inc l ; $4a87
	inc b ; $4a88
	ld a, $10 ; $4a89
	ld d, $01 ; $4a8b
	rst Rst18 ; $4a8d
	inc [hl] ; $4a8e
	ld a, [bc] ; $4a8f
	ld d, $74 ; $4a90
	ld a, $0e ; $4a92
	rst Rst18 ; $4a94
	ld d, $0a ; $4a95
	ld c, l ; $4a97
	ld b, h ; $4a98
	rst Rst18 ; $4a99
	inc l ; $4a9a
	inc b ; $4a9b
	ld a, $0e ; $4a9c
	ld d, $01 ; $4a9e
	rst Rst18 ; $4aa0
	inc [hl] ; $4aa1
	ld a, [bc] ; $4aa2
	ld a, $10 ; $4aa3
	ld bc, $1000 ; $4aa5
	ld de, $1300 ; $4aa8
	rst Rst18 ; $4aab
	ld [hl+], a ; $4aac
	ld a, [bc] ; $4aad
	ld a, $0e ; $4aae
	ld bc, $0f00 ; $4ab0
	ld de, $1300 ; $4ab3
	rst Rst18 ; $4ab6
	ld [hl+], a ; $4ab7
	ld a, [bc] ; $4ab8
	ld a, $10 ; $4ab9
	ld b, $80 ; $4abb
	rst Rst18 ; $4abd
	ld l, $0a ; $4abe
	ld a, $0e ; $4ac0
	ld d, $08 ; $4ac2
	rst Rst18 ; $4ac4
	inc [hl] ; $4ac5
	ld a, [bc] ; $4ac6
	ld a, $10 ; $4ac7
	ld bc, $0c00 ; $4ac9
	ld de, $1300 ; $4acc
	rst Rst18 ; $4acf
	inc h ; $4ad0
	ld a, [bc] ; $4ad1
	ld a, $0e ; $4ad2
	ld bc, $0b00 ; $4ad4
	ld de, $1300 ; $4ad7
	rst Rst18 ; $4ada
	inc h ; $4adb
	ld a, [bc] ; $4adc
	ld a, $0e ; $4add
	rst Rst18 ; $4adf
	jr nz, Label_0f_4aec ; $4ae0
	ld a, $10 ; $4ae2
	ld b, $01 ; $4ae4
	rst Rst18 ; $4ae6
	inc l ; $4ae7
	ld a, [bc] ; $4ae8
	ld a, $10 ; $4ae9
	INCBIN "data/bank_00f/d_4aeb.bin" ; $4aeb, 1 bytes
Label_0f_4aec:
	nop ; $4aec
	ld c, $11 ; $4aed
	nop ; $4aef
	inc de ; $4af0
	rst Rst18 ; $4af1
	inc h ; $4af2
	ld a, [bc] ; $4af3
	ld a, $10 ; $4af4
	rst Rst18 ; $4af6
	jr nz, Label_0f_4b03 ; $4af7
	ld a, $10 ; $4af9
	ld b, $00 ; $4afb
	rst Rst18 ; $4afd
	inc l ; $4afe
	ld a, [bc] ; $4aff
	ld a, $10 ; $4b00
	INCBIN "data/bank_00f/d_4b02.bin" ; $4b02, 1 bytes
Label_0f_4b03:
	jr nz, Label_0f_4b05 ; $4b03
Label_0f_4b05:
	rst Rst18 ; $4b05
	jr Label_0f_4b12 ; $4b06
	INCBIN "data/bank_00f/d_4b08.bin" ; $4b08, 10 bytes
Label_0f_4b12:
	ld a, [bc] ; $4b12
	ld a, $10 ; $4b13
	rst Rst18 ; $4b15
	jr nz, Label_0f_4b22 ; $4b16
	ld a, $10 ; $4b18
	ld b, $c0 ; $4b1a
	rst Rst18 ; $4b1c
	ld l, $0a ; $4b1d
	ld d, $61 ; $4b1f
	INCBIN "data/bank_00f/d_4b21.bin" ; $4b21, 1 bytes
Label_0f_4b22:
	ld [de], a ; $4b22
	rst Rst18 ; $4b23
	ld d, $0a ; $4b24
	ld c, l ; $4b26
	ld b, h ; $4b27
	rst Rst18 ; $4b28
	inc l ; $4b29
	inc b ; $4b2a
	ld a, $12 ; $4b2b
	ld d, $01 ; $4b2d
	rst Rst18 ; $4b2f
	inc [hl] ; $4b30
	ld a, [bc] ; $4b31
	ld a, $04 ; $4b32
	ld bc, $3f00 ; $4b34
	ld de, $3f00 ; $4b37
	rst Rst18 ; $4b3a
	ld [hl+], a ; $4b3b
	ld a, [bc] ; $4b3c
	ld a, $12 ; $4b3d
	ld bc, $0a00 ; $4b3f
	ld de, $0dc0 ; $4b42
	rst Rst18 ; $4b45
	ld [hl+], a ; $4b46
	ld a, [bc] ; $4b47
	ld a, $12 ; $4b48
	ld b, $40 ; $4b4a
	rst Rst18 ; $4b4c
	ld l, $0a ; $4b4d
	ld a, $0c ; $4b4f
	ld bc, $0010 ; $4b51
	rst Rst18 ; $4b54
	jr Label_0f_4b61 ; $4b55
	INCBIN "data/bank_00f/d_4b57.bin" ; $4b57, 10 bytes
Label_0f_4b61:
	ld bc, $0a00 ; $4b61
	ld de, $1100 ; $4b64
	rst Rst18 ; $4b67
	inc h ; $4b68
	ld a, [bc] ; $4b69
	ld a, $0e ; $4b6a
	ld bc, $0a00 ; $4b6c
	ld de, $1000 ; $4b6f
	rst Rst18 ; $4b72
	inc h ; $4b73
	ld a, [bc] ; $4b74
	ld a, $0e ; $4b75
	rst Rst18 ; $4b77
	jr nz, Label_0f_4b84 ; $4b78
	ld a, $1e ; $4b7a
	call Func_0f_5678 ; $4b7c
	ld a, $0c ; $4b7f
	rst Rst18 ; $4b81
	INCBIN "data/bank_00f/d_4b82.bin" ; $4b82, 2 bytes
Label_0f_4b84:
	ld a, $1e ; $4b84
	call Func_0f_5678 ; $4b86
	ld a, $0c ; $4b89
	ld bc, $0a00 ; $4b8b
	ld de, $0fc0 ; $4b8e
	rst Rst18 ; $4b91
	inc h ; $4b92
	ld a, [bc] ; $4b93
	ld a, $0e ; $4b94
	ld bc, $0a00 ; $4b96
	ld de, $0ec0 ; $4b99
	rst Rst18 ; $4b9c
	inc h ; $4b9d
	ld a, [bc] ; $4b9e
	ld a, $0e ; $4b9f
	rst Rst18 ; $4ba1
	jr nz, Label_0f_4bae ; $4ba2
	ld a, $05 ; $4ba4
	call Func_0f_5678 ; $4ba6
	ld a, $12 ; $4ba9
	ld d, $02 ; $4bab
	rst Rst18 ; $4bad
Label_0f_4bae:
	inc [hl] ; $4bae
	ld a, [bc] ; $4baf
	ld a, $12 ; $4bb0
	rst Rst18 ; $4bb2
	ld [hl], $0a ; $4bb3
	ld a, $0c ; $4bb5
	ld b, $01 ; $4bb7
	rst Rst18 ; $4bb9
	inc l ; $4bba
	ld a, [bc] ; $4bbb
	ld a, $0c ; $4bbc
	ld bc, $0a00 ; $4bbe
	ld de, $1100 ; $4bc1
	rst Rst18 ; $4bc4
	inc h ; $4bc5
	ld a, [bc] ; $4bc6
	ld a, $0c ; $4bc7
	rst Rst18 ; $4bc9
	jr nz, Label_0f_4bd6 ; $4bca
	ld a, $0c ; $4bcc
	ld b, $00 ; $4bce
	rst Rst18 ; $4bd0
	inc l ; $4bd1
	ld a, [bc] ; $4bd2
	ld a, $0c ; $4bd3
	INCBIN "data/bank_00f/d_4bd5.bin" ; $4bd5, 1 bytes
Label_0f_4bd6:
	ret nz ; $4bd6
	rst Rst18 ; $4bd7
	ld l, $0a ; $4bd8
	ld a, $14 ; $4bda
	call Func_0f_5678 ; $4bdc
	ld a, $0e ; $4bdf
	ld bc, $3f00 ; $4be1
	ld de, $3f00 ; $4be4
	rst Rst18 ; $4be7
	ld [hl+], a ; $4be8
	ld a, [bc] ; $4be9
	ld a, $13 ; $4bea
	ld bc, $0b80 ; $4bec
	ld de, $0c40 ; $4bef
	rst Rst18 ; $4bf2
	ld [hl+], a ; $4bf3
	ld a, [bc] ; $4bf4
	rst Rst08 ; $4bf5
	sbc a, c ; $4bf6
	ld a, $12 ; $4bf7
	rst Rst18 ; $4bf9
	ld [$3e0a], sp ; $4bfa
	inc de ; $4bfd
	ld bc, $3f00 ; $4bfe
	ld de, $3f00 ; $4c01
	rst Rst18 ; $4c04
	ld [hl+], a ; $4c05
	ld a, [bc] ; $4c06
	ld a, $15 ; $4c07
	ld bc, $0b80 ; $4c09
	ld de, $0f80 ; $4c0c
	rst Rst18 ; $4c0f
	ld [hl+], a ; $4c10
	ld a, [bc] ; $4c11
	rst Rst08 ; $4c12
	sbc a, b ; $4c13
	ld a, $78 ; $4c14
	call Func_0f_5678 ; $4c16
	ld a, $15 ; $4c19
	ld bc, $3f00 ; $4c1b
	ld de, $3f00 ; $4c1e
	rst Rst18 ; $4c21
	ld [hl+], a ; $4c22
	ld a, [bc] ; $4c23
	ld a, $12 ; $4c24
	ld d, $04 ; $4c26
	rst Rst18 ; $4c28
	inc [hl] ; $4c29
	ld a, [bc] ; $4c2a
	ld a, $12 ; $4c2b
	rst Rst18 ; $4c2d
	ld [hl], $0a ; $4c2e
	ld a, $12 ; $4c30
	rst Rst18 ; $4c32
	ld [$3e0a], sp ; $4c33
	inc c ; $4c36
	ld d, $03 ; $4c37
	rst Rst18 ; $4c39
	inc [hl] ; $4c3a
	ld a, [bc] ; $4c3b
	ld a, $0c ; $4c3c
	rst Rst18 ; $4c3e
	ld [hl], $0a ; $4c3f
	ld a, $0c ; $4c41
	rst Rst18 ; $4c43
	ld [$3e0a], sp ; $4c44
	ld e, $cd ; $4c47
	ld a, b ; $4c49
	ld d, [hl] ; $4c4a
	ld a, $0c ; $4c4b
	ld bc, $0a00 ; $4c4d
	ld de, $1300 ; $4c50
	rst Rst18 ; $4c53
	inc h ; $4c54
	ld a, [bc] ; $4c55
	ld a, $0c ; $4c56
	rst Rst18 ; $4c58
	jr nz, Label_0f_4c65 ; $4c59
	ld a, $0c ; $4c5b
	ld bc, $0c00 ; $4c5d
	ld de, $1300 ; $4c60
	rst Rst18 ; $4c63
	inc h ; $4c64
Label_0f_4c65:
	ld a, [bc] ; $4c65
	ld a, $0c ; $4c66
	rst Rst18 ; $4c68
	jr nz, Label_0f_4c75 ; $4c69
	ld a, $0c ; $4c6b
	ld b, $c0 ; $4c6d
	rst Rst18 ; $4c6f
	ld l, $0a ; $4c70
	ld a, $0d ; $4c72
	INCBIN "data/bank_00f/d_4c74.bin" ; $4c74, 1 bytes
Label_0f_4c75:
	stop ; $4c75
	rst Rst18 ; $4c77
	jr Label_0f_4c84 ; $4c78
	INCBIN "data/bank_00f/d_4c7a.bin" ; $4c7a, 10 bytes
Label_0f_4c84:
	ld bc, $0f00 ; $4c84
	ld de, $1600 ; $4c87
	rst Rst18 ; $4c8a
	inc h ; $4c8b
	ld a, [bc] ; $4c8c
	ld a, $10 ; $4c8d
	rst Rst18 ; $4c8f
	jr nz, Label_0f_4c9c ; $4c90
	ld a, $10 ; $4c92
	ld b, $40 ; $4c94
	rst Rst18 ; $4c96
	ld l, $0a ; $4c97
	ld a, $14 ; $4c99
	INCBIN "data/bank_00f/d_4c9b.bin" ; $4c9b, 1 bytes
Label_0f_4c9c:
	ld a, b ; $4c9c
	ld d, [hl] ; $4c9d
	ld a, $0d ; $4c9e
	ld bc, $0f80 ; $4ca0
	ld de, $1600 ; $4ca3
	rst Rst18 ; $4ca6
	ld [hl+], a ; $4ca7
	ld a, [bc] ; $4ca8
	ld a, $14 ; $4ca9
	call Func_0f_5678 ; $4cab
	ld d, $74 ; $4cae
	ld a, $10 ; $4cb0
	rst Rst18 ; $4cb2
	ld d, $0a ; $4cb3
	ld c, l ; $4cb5
	ld b, h ; $4cb6
	rst Rst18 ; $4cb7
	inc l ; $4cb8
	inc b ; $4cb9
	ld a, $10 ; $4cba
	ld d, $01 ; $4cbc
	rst Rst18 ; $4cbe
	inc [hl] ; $4cbf
	ld a, [bc] ; $4cc0
	ld d, $25 ; $4cc1
	ld a, $0d ; $4cc3
	rst Rst18 ; $4cc5
	ld d, $0a ; $4cc6
	ld c, l ; $4cc8
	ld b, h ; $4cc9
	rst Rst18 ; $4cca
	inc l ; $4ccb
	inc b ; $4ccc
	ld a, $0d ; $4ccd
	ld d, $01 ; $4ccf
	rst Rst18 ; $4cd1
	inc [hl] ; $4cd2
	ld a, [bc] ; $4cd3
	ld a, $0d ; $4cd4
	ld bc, $0f00 ; $4cd6
	ld de, $1600 ; $4cd9
	rst Rst18 ; $4cdc
	ld [hl+], a ; $4cdd
	ld a, [bc] ; $4cde
	ld a, $10 ; $4cdf
	ld bc, $0f00 ; $4ce1
	ld de, $1500 ; $4ce4
	rst Rst18 ; $4ce7
	ld [hl+], a ; $4ce8
	ld a, [bc] ; $4ce9
	ld a, $0d ; $4cea
	ld b, $c0 ; $4cec
	rst Rst18 ; $4cee
	ld l, $0a ; $4cef
	ld a, $10 ; $4cf1
	ld d, $06 ; $4cf3
	rst Rst18 ; $4cf5
	inc [hl] ; $4cf6
	ld a, [bc] ; $4cf7
	ld a, $10 ; $4cf8
	ld bc, $0f00 ; $4cfa
	ld de, $1200 ; $4cfd
	rst Rst18 ; $4d00
	inc h ; $4d01
	ld a, [bc] ; $4d02
	ld a, $0d ; $4d03
	ld bc, $0f00 ; $4d05
	ld de, $1300 ; $4d08
	rst Rst18 ; $4d0b
	inc h ; $4d0c
	ld a, [bc] ; $4d0d
	ld a, $0d ; $4d0e
	rst Rst18 ; $4d10
	jr nz, Label_0f_4d1d ; $4d11
	ld d, $25 ; $4d13
	ld a, $10 ; $4d15
	rst Rst18 ; $4d17
	ld d, $0a ; $4d18
	ld c, l ; $4d1a
	ld b, h ; $4d1b
	rst Rst18 ; $4d1c
Label_0f_4d1d:
	inc l ; $4d1d
	inc b ; $4d1e
	ld a, $10 ; $4d1f
	ld d, $01 ; $4d21
	rst Rst18 ; $4d23
	inc [hl] ; $4d24
	ld a, [bc] ; $4d25
	ld d, $74 ; $4d26
	ld a, $0d ; $4d28
	rst Rst18 ; $4d2a
	ld d, $0a ; $4d2b
	ld c, l ; $4d2d
	ld b, h ; $4d2e
	rst Rst18 ; $4d2f
	inc l ; $4d30
	inc b ; $4d31
	ld a, $0d ; $4d32
	ld d, $01 ; $4d34
	rst Rst18 ; $4d36
	inc [hl] ; $4d37
	ld a, [bc] ; $4d38
	ld a, $10 ; $4d39
	ld bc, $0f00 ; $4d3b
	ld de, $1300 ; $4d3e
	rst Rst18 ; $4d41
	ld [hl+], a ; $4d42
	ld a, [bc] ; $4d43
	ld a, $0d ; $4d44
	ld bc, $0e00 ; $4d46
	ld de, $1300 ; $4d49
	rst Rst18 ; $4d4c
	ld [hl+], a ; $4d4d
	ld a, [bc] ; $4d4e
	ld a, $10 ; $4d4f
	ld b, $80 ; $4d51
	rst Rst18 ; $4d53
	ld l, $0a ; $4d54
	ld a, $0d ; $4d56
	ld d, $06 ; $4d58
	rst Rst18 ; $4d5a
	inc [hl] ; $4d5b
	ld a, [bc] ; $4d5c
	ld a, $10 ; $4d5d
	ld bc, $0e00 ; $4d5f
	ld de, $1300 ; $4d62
	rst Rst18 ; $4d65
	inc h ; $4d66
	ld a, [bc] ; $4d67
	ld a, $0d ; $4d68
	ld bc, $0d00 ; $4d6a
	ld de, $1300 ; $4d6d
	rst Rst18 ; $4d70
	inc h ; $4d71
	ld a, [bc] ; $4d72
	ld a, $0d ; $4d73
	rst Rst18 ; $4d75
	jr nz, Label_0f_4d82 ; $4d76
	ld a, $10 ; $4d78
	ld b, $01 ; $4d7a
	rst Rst18 ; $4d7c
	inc l ; $4d7d
	ld a, [bc] ; $4d7e
	ld a, $10 ; $4d7f
	INCBIN "data/bank_00f/d_4d81.bin" ; $4d81, 1 bytes
Label_0f_4d82:
	nop ; $4d82
	rrca ; $4d83
	ld de, $1300 ; $4d84
	rst Rst18 ; $4d87
	inc h ; $4d88
	ld a, [bc] ; $4d89
	ld a, $10 ; $4d8a
	rst Rst18 ; $4d8c
	jr nz, Label_0f_4d99 ; $4d8d
	ld a, $10 ; $4d8f
	ld b, $00 ; $4d91
	rst Rst18 ; $4d93
	inc l ; $4d94
	ld a, [bc] ; $4d95
	ld a, $10 ; $4d96
	INCBIN "data/bank_00f/d_4d98.bin" ; $4d98, 1 bytes
Label_0f_4d99:
	jr nz, Label_0f_4d9b ; $4d99
Label_0f_4d9b:
	rst Rst18 ; $4d9b
	jr Label_0f_4da8 ; $4d9c
	INCBIN "data/bank_00f/d_4d9e.bin" ; $4d9e, 10 bytes
Label_0f_4da8:
	ld a, [bc] ; $4da8
	ld a, $10 ; $4da9
	rst Rst18 ; $4dab
	jr nz, Label_0f_4db8 ; $4dac
	ld a, $10 ; $4dae
	ld b, $c0 ; $4db0
	rst Rst18 ; $4db2
	ld l, $0a ; $4db3
	ld a, $0c ; $4db5
	INCBIN "data/bank_00f/d_4db7.bin" ; $4db7, 1 bytes
Label_0f_4db8:
	nop ; $4db8
	inc c ; $4db9
	ld de, $1100 ; $4dba
	rst Rst18 ; $4dbd
	inc h ; $4dbe
	ld a, [bc] ; $4dbf
	ld a, $0d ; $4dc0
	ld bc, $0c00 ; $4dc2
	ld de, $1000 ; $4dc5
	rst Rst18 ; $4dc8
	inc h ; $4dc9
	ld a, [bc] ; $4dca
	ld a, $0d ; $4dcb
	rst Rst18 ; $4dcd
	jr nz, Label_0f_4dda ; $4dce
	ld a, $0c ; $4dd0
	rst Rst18 ; $4dd2
	ld [$3e0a], sp ; $4dd3
	inc d ; $4dd6
	call Func_0f_5678 ; $4dd7
Label_0f_4dda:
	ld a, $0c ; $4dda
	ld bc, $0c00 ; $4ddc
	ld de, $0f80 ; $4ddf
	rst Rst18 ; $4de2
	inc h ; $4de3
	ld a, [bc] ; $4de4
	ld a, $0d ; $4de5
	ld bc, $0c00 ; $4de7
	ld de, $0e40 ; $4dea
	rst Rst18 ; $4ded
	inc h ; $4dee
	ld a, [bc] ; $4def
	ld a, $0d ; $4df0
	rst Rst18 ; $4df2
	jr nz, Label_0f_4dff ; $4df3
	ld a, $0c ; $4df5
	ld b, $01 ; $4df7
	rst Rst18 ; $4df9
	inc l ; $4dfa
	ld a, [bc] ; $4dfb
	ld a, $0c ; $4dfc
	INCBIN "data/bank_00f/d_4dfe.bin" ; $4dfe, 1 bytes
Label_0f_4dff:
	nop ; $4dff
	inc c ; $4e00
	ld de, $1100 ; $4e01
	rst Rst18 ; $4e04
	inc h ; $4e05
	ld a, [bc] ; $4e06
	ld a, $0c ; $4e07
	rst Rst18 ; $4e09
	jr nz, Label_0f_4e16 ; $4e0a
	ld a, $0c ; $4e0c
	ld b, $00 ; $4e0e
	rst Rst18 ; $4e10
	inc l ; $4e11
	ld a, [bc] ; $4e12
	ld a, $0c ; $4e13
	INCBIN "data/bank_00f/d_4e15.bin" ; $4e15, 1 bytes
Label_0f_4e16:
	ret nz ; $4e16
	rst Rst18 ; $4e17
	ld l, $0a ; $4e18
	ld a, $0b ; $4e1a
	ld d, $02 ; $4e1c
	rst Rst18 ; $4e1e
	inc [hl] ; $4e1f
	ld a, [bc] ; $4e20
	ld a, $0b ; $4e21
	rst Rst18 ; $4e23
	ld [hl], $0a ; $4e24
	ld a, $16 ; $4e26
	rst Rst18 ; $4e28
	ld [$3e0a], sp ; $4e29
	ld de, $8006 ; $4e2c
	rst Rst18 ; $4e2f
	ld l, $0a ; $4e30
	ld a, $12 ; $4e32
	ld b, $00 ; $4e34
	rst Rst18 ; $4e36
	ld l, $0a ; $4e37
	ld a, $3c ; $4e39
	call Func_0f_5678 ; $4e3b
	ld a, [$c90d] ; $4e3e
	ld d, $26 ; $4e41
	add a, d ; $4e43
	ld d, a ; $4e44
	ld a, $16 ; $4e45
	rst Rst18 ; $4e47
	ld d, $0a ; $4e48
	ld c, l ; $4e4a
	ld b, h ; $4e4b
	rst Rst18 ; $4e4c
	inc l ; $4e4d
	inc b ; $4e4e
	ld a, $16 ; $4e4f
	ld d, $01 ; $4e51
	rst Rst18 ; $4e53
	inc [hl] ; $4e54
	ld a, [bc] ; $4e55
	ld a, $16 ; $4e56
	ld b, $00 ; $4e58
	rst Rst18 ; $4e5a
	ld l, $0a ; $4e5b
	ld a, $16 ; $4e5d
	ld d, $08 ; $4e5f
	rst Rst18 ; $4e61
	inc [hl] ; $4e62
	ld a, [bc] ; $4e63
	ld a, $0d ; $4e64
	ld bc, $0b40 ; $4e66
	ld de, $0c40 ; $4e69
	rst Rst18 ; $4e6c
	ld [hl+], a ; $4e6d
	ld a, [bc] ; $4e6e
	xor a, a ; $4e6f
	ld bc, $0c00 ; $4e70
	ld de, $0d00 ; $4e73
	rst Rst18 ; $4e76
	ld a, [hl-] ; $4e77
	ld a, [bc] ; $4e78
	rst Rst18 ; $4e79
	ld a, $0a ; $4e7a
	ld a, $b4 ; $4e7c
	call Func_0f_5678 ; $4e7e
	ld c, $01 ; $4e81
	call Func_00_1d20 ; $4e83
	call Func_00_1da4 ; $4e86
	ld b, $01 ; $4e89
	ld a, [$c90d] ; $4e8b
	add a, $04 ; $4e8e
	ld c, a ; $4e90
	rst Rst18 ; $4e91
	adc a, [hl] ; $4e92
	jr $4ed3 ; $4e93
	INCBIN "data/bank_00f/d_4e95.bin" ; $4e95, 18 bytes
Label_0f_4ea7:
	ld a, $02 ; $4ea7
	rst Rst18 ; $4ea9
	inc e ; $4eaa
	ld a, [bc] ; $4eab
	ld a, $00 ; $4eac
	ld bc, $0c00 ; $4eae
	ld de, $1900 ; $4eb1
	rst Rst18 ; $4eb4
	inc h ; $4eb5
	ld a, [bc] ; $4eb6
	ld a, $02 ; $4eb7
	ld bc, $0c00 ; $4eb9
	ld de, $1b00 ; $4ebc
	rst Rst18 ; $4ebf
	inc h ; $4ec0
	ld a, [bc] ; $4ec1
	ld a, $02 ; $4ec2
	rst Rst18 ; $4ec4
	jr nz, Label_0f_4ed1 ; $4ec5
	ld a, $0a ; $4ec7
	call Func_0f_5678 ; $4ec9
	ld a, $0b ; $4ecc
	ld b, a ; $4ece
	ld a, $00 ; $4ecf
Label_0f_4ed1:
	rst Rst18 ; $4ed1
	jr nc, Label_0f_4ede ; $4ed2
	ld a, $02 ; $4ed4
	ld b, $c0 ; $4ed6
	rst Rst18 ; $4ed8
	ld l, $0a ; $4ed9
	ld a, $3c ; $4edb
	INCBIN "data/bank_00f/d_4edd.bin" ; $4edd, 1 bytes
Label_0f_4ede:
	ld a, b ; $4ede
	ld d, [hl] ; $4edf
	call Func_0f_5c52 ; $4ee0
	ld a, $00 ; $4ee3
	ld b, $40 ; $4ee5
	rst Rst18 ; $4ee7
	ld l, $0a ; $4ee8
	ld a, $05 ; $4eea
	rst Rst18 ; $4eec
	ld d, $0a ; $4eed
	ld c, l ; $4eef
	ld b, h ; $4ef0
	ld a, $04 ; $4ef1
	rst Rst18 ; $4ef3
	ld d, $0a ; $4ef4
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	rst Rst18 ; $4ef8
	jr nz, Label_0f_4eff ; $4ef9
	ld a, $04 ; $4efb
	INCBIN "data/bank_00f/d_4efd.bin" ; $4efd, 2 bytes
Label_0f_4eff:
	inc c ; $4eff
	ld de, $1d00 ; $4f00
	rst Rst18 ; $4f03
	inc h ; $4f04
	ld a, [bc] ; $4f05
	ld a, $04 ; $4f06
	rst Rst18 ; $4f08
	jr nz, Label_0f_4f15 ; $4f09
	ld a, $0a ; $4f0b
	call Func_0f_5678 ; $4f0d
	ld a, $05 ; $4f10
	rst Rst18 ; $4f12
	inc e ; $4f13
	ld a, [bc] ; $4f14
Label_0f_4f15:
	call Func_0f_5c96 ; $4f15
	ld a, $03 ; $4f18
	ld b, $c0 ; $4f1a
	rst Rst18 ; $4f1c
	ld l, $0a ; $4f1d
	ld a, $00 ; $4f1f
	ld bc, $0020 ; $4f21
	rst Rst18 ; $4f24
	jr Label_0f_4f31 ; $4f25
	INCBIN "data/bank_00f/d_4f27.bin" ; $4f27, 10 bytes
Label_0f_4f31:
	ld bc, $0020 ; $4f31
	rst Rst18 ; $4f34
	jr Label_0f_4f41 ; $4f35
	INCBIN "data/bank_00f/d_4f37.bin" ; $4f37, 10 bytes
Label_0f_4f41:
	ld b, a ; $4f41
	ld a, $00 ; $4f42
	ld de, $5665 ; $4f44
	rst Rst18 ; $4f47
	ld a, [de] ; $4f48
	ld a, [bc] ; $4f49
	ldh a, [$ff95] ; $4f4a
	ld b, a ; $4f4c
	ld a, $02 ; $4f4d
	ld de, $5665 ; $4f4f
	rst Rst18 ; $4f52
	ld a, [de] ; $4f53
	ld a, [bc] ; $4f54
	ldh a, [$ff95] ; $4f55
	ld b, a ; $4f57
	ld a, $04 ; $4f58
	ld de, $5665 ; $4f5a
	rst Rst18 ; $4f5d
	ld a, [de] ; $4f5e
	ld a, [bc] ; $4f5f
	ldh a, [$ff95] ; $4f60
	ld b, a ; $4f62
	ld a, $05 ; $4f63
	ld de, $5665 ; $4f65
	rst Rst18 ; $4f68
	ld a, [de] ; $4f69
	ld a, [bc] ; $4f6a
	ld a, $b4 ; $4f6b
	call Func_0f_5678 ; $4f6d
	call Func_0f_5641 ; $4f70
	ld a, $16 ; $4f73
	ld bc, $0d00 ; $4f75
	ld de, $0d60 ; $4f78
	rst Rst18 ; $4f7b
	ld [hl+], a ; $4f7c
	ld a, [bc] ; $4f7d
	ld a, [$c94d] ; $4f7e
	ld d, $58 ; $4f81
	add a, d ; $4f83
	ld d, a ; $4f84
	ld a, $11 ; $4f85
	rst Rst18 ; $4f87
	ld d, $0a ; $4f88
	ld c, l ; $4f8a
	ld b, h ; $4f8b
	rst Rst18 ; $4f8c
	inc l ; $4f8d
	inc b ; $4f8e
	ld a, $11 ; $4f8f
	ld d, $01 ; $4f91
	rst Rst18 ; $4f93
	inc [hl] ; $4f94
	ld a, [bc] ; $4f95
	ld a, $02 ; $4f96
	ld bc, $3f00 ; $4f98
	ld de, $3f00 ; $4f9b
	rst Rst18 ; $4f9e
	ld [hl+], a ; $4f9f
	ld a, [bc] ; $4fa0
	ld a, $11 ; $4fa1
	ld bc, $0f00 ; $4fa3
	ld de, $0d60 ; $4fa6
	rst Rst18 ; $4fa9
	ld [hl+], a ; $4faa
	ld a, [bc] ; $4fab
	ld d, $61 ; $4fac
	ld a, $13 ; $4fae
	rst Rst18 ; $4fb0
	ld d, $0a ; $4fb1
	ld c, l ; $4fb3
	ld b, h ; $4fb4
	rst Rst18 ; $4fb5
	inc l ; $4fb6
	inc b ; $4fb7
	ld a, $13 ; $4fb8
	ld d, $01 ; $4fba
	rst Rst18 ; $4fbc
	inc [hl] ; $4fbd
	ld a, [bc] ; $4fbe
	ld d, $62 ; $4fbf
	ld a, $15 ; $4fc1
	rst Rst18 ; $4fc3
	ld d, $0a ; $4fc4
	ld c, l ; $4fc6
	ld b, h ; $4fc7
	rst Rst18 ; $4fc8
	inc l ; $4fc9
	inc b ; $4fca
	ld a, $15 ; $4fcb
	ld d, $01 ; $4fcd
	rst Rst18 ; $4fcf
	inc [hl] ; $4fd0
	ld a, [bc] ; $4fd1
	ld a, $04 ; $4fd2
	ld bc, $3f00 ; $4fd4
	ld de, $3f00 ; $4fd7
	rst Rst18 ; $4fda
	ld [hl+], a ; $4fdb
	ld a, [bc] ; $4fdc
	ld a, $05 ; $4fdd
	ld bc, $3f00 ; $4fdf
	ld de, $3f00 ; $4fe2
	rst Rst18 ; $4fe5
	ld [hl+], a ; $4fe6
	ld a, [bc] ; $4fe7
	ld a, $13 ; $4fe8
	ld bc, $0b00 ; $4fea
	ld de, $0e00 ; $4fed
	rst Rst18 ; $4ff0
	ld [hl+], a ; $4ff1
	ld a, [bc] ; $4ff2
	ld a, $15 ; $4ff3
	ld bc, $0900 ; $4ff5
	ld de, $0e00 ; $4ff8
	rst Rst18 ; $4ffb
	ld [hl+], a ; $4ffc
	ld a, [bc] ; $4ffd
	ld d, $4e ; $4ffe
	ld a, $04 ; $5000
	rst Rst18 ; $5002
	ld d, $0a ; $5003
	ld c, l ; $5005
	ld b, h ; $5006
	rst Rst18 ; $5007
	inc l ; $5008
	inc b ; $5009
	ld a, $04 ; $500a
	ld d, $01 ; $500c
	rst Rst18 ; $500e
	inc [hl] ; $500f
	ld a, [bc] ; $5010
	ld d, $4d ; $5011
	ld a, $05 ; $5013
	rst Rst18 ; $5015
	ld d, $0a ; $5016
	ld c, l ; $5018
	ld b, h ; $5019
	rst Rst18 ; $501a
	inc l ; $501b
	inc b ; $501c
	ld a, $05 ; $501d
	ld d, $01 ; $501f
	rst Rst18 ; $5021
	inc [hl] ; $5022
	ld a, [bc] ; $5023
	ld a, $16 ; $5024
	ld b, $40 ; $5026
	rst Rst18 ; $5028
	ld l, $0a ; $5029
	ld a, $11 ; $502b
	ld b, $40 ; $502d
	rst Rst18 ; $502f
	ld l, $0a ; $5030
	ld a, $13 ; $5032
	ld b, $40 ; $5034
	rst Rst18 ; $5036
	ld l, $0a ; $5037
	ld a, $15 ; $5039
	ld b, $40 ; $503b
	rst Rst18 ; $503d
	ld l, $0a ; $503e
	ld bc, $0006 ; $5040
	rst Rst18 ; $5043
	jr c, Label_0f_5050 ; $5044
	xor a, a ; $5046
	ld bc, $0c00 ; $5047
	ld de, $1300 ; $504a
	rst Rst18 ; $504d
	ld a, [hl-] ; $504e
	ld a, [bc] ; $504f
Label_0f_5050:
	rst Rst18 ; $5050
	ld a, $0a ; $5051
	call Func_0f_5ccf ; $5053
	ld a, $0c ; $5056
	ld bc, $0a00 ; $5058
	ld de, $1300 ; $505b
	rst Rst18 ; $505e
	inc h ; $505f
	ld a, [bc] ; $5060
	ld a, $0c ; $5061
	rst Rst18 ; $5063
	jr nz, Label_0f_5070 ; $5064
	ld a, $0c ; $5066
	ld b, $c0 ; $5068
	rst Rst18 ; $506a
	ld l, $0a ; $506b
	ld a, $10 ; $506d
	INCBIN "data/bank_00f/d_506f.bin" ; $506f, 1 bytes
Label_0f_5070:
	stop ; $5070
	rst Rst18 ; $5072
	jr Label_0f_507f ; $5073
	INCBIN "data/bank_00f/d_5075.bin" ; $5075, 10 bytes
Label_0f_507f:
	ld bc, $0010 ; $507f
	rst Rst18 ; $5082
	jr Label_0f_508f ; $5083
	INCBIN "data/bank_00f/d_5085.bin" ; $5085, 10 bytes
Label_0f_508f:
	ld a, [bc] ; $508f
	ld a, $10 ; $5090
	rst Rst18 ; $5092
	jr nz, Label_0f_509f ; $5093
	ld a, $10 ; $5095
	ld b, $40 ; $5097
	rst Rst18 ; $5099
	ld l, $0a ; $509a
	ld a, $14 ; $509c
	INCBIN "data/bank_00f/d_509e.bin" ; $509e, 1 bytes
Label_0f_509f:
	ld a, b ; $509f
	ld d, [hl] ; $50a0
	ld a, $0e ; $50a1
	ld bc, $3f00 ; $50a3
	ld de, $3f00 ; $50a6
	rst Rst18 ; $50a9
	ld [hl+], a ; $50aa
	ld a, [bc] ; $50ab
	ld a, $0f ; $50ac
	ld bc, $1100 ; $50ae
	ld de, $1600 ; $50b1
	rst Rst18 ; $50b4
	ld [hl+], a ; $50b5
	ld a, [bc] ; $50b6
	ld a, $14 ; $50b7
	call Func_0f_5678 ; $50b9
	ld d, $25 ; $50bc
	ld a, $09 ; $50be
	rst Rst18 ; $50c0
	ld d, $0a ; $50c1
	ld c, l ; $50c3
	ld b, h ; $50c4
	rst Rst18 ; $50c5
	inc l ; $50c6
	inc b ; $50c7
	ld a, $09 ; $50c8
	ld d, $01 ; $50ca
	rst Rst18 ; $50cc
	inc [hl] ; $50cd
	ld a, [bc] ; $50ce
	ld a, $10 ; $50cf
	ld bc, $3f00 ; $50d1
	ld de, $3f00 ; $50d4
	rst Rst18 ; $50d7
	ld [hl+], a ; $50d8
	ld a, [bc] ; $50d9
	ld a, $09 ; $50da
	ld bc, $1100 ; $50dc
	ld de, $1600 ; $50df
	rst Rst18 ; $50e2
	ld [hl+], a ; $50e3
	ld a, [bc] ; $50e4
	ld a, $0f ; $50e5
	ld bc, $1100 ; $50e7
	ld de, $1500 ; $50ea
	rst Rst18 ; $50ed
	ld [hl+], a ; $50ee
	ld a, [bc] ; $50ef
	ld a, $09 ; $50f0
	ld b, $c0 ; $50f2
	rst Rst18 ; $50f4
	ld l, $0a ; $50f5
	ld a, $0f ; $50f7
	ld d, $08 ; $50f9
	rst Rst18 ; $50fb
	inc [hl] ; $50fc
	ld a, [bc] ; $50fd
	ld a, $0f ; $50fe
	ld bc, $1100 ; $5100
	ld de, $1200 ; $5103
	rst Rst18 ; $5106
	inc h ; $5107
	ld a, [bc] ; $5108
	ld a, $09 ; $5109
	ld bc, $1100 ; $510b
	ld de, $1300 ; $510e
	rst Rst18 ; $5111
	inc h ; $5112
	ld a, [bc] ; $5113
	ld a, $09 ; $5114
	rst Rst18 ; $5116
	jr nz, Label_0f_5123 ; $5117
	ld a, $09 ; $5119
	ld bc, $3f00 ; $511b
	ld de, $3f00 ; $511e
	rst Rst18 ; $5121
	ld [hl+], a ; $5122
Label_0f_5123:
	ld a, [bc] ; $5123
	ld a, $10 ; $5124
	ld bc, $1100 ; $5126
	ld de, $1300 ; $5129
	rst Rst18 ; $512c
	ld [hl+], a ; $512d
	ld a, [bc] ; $512e
	ld a, $0f ; $512f
	ld bc, $1000 ; $5131
	ld de, $1300 ; $5134
	rst Rst18 ; $5137
	ld [hl+], a ; $5138
	ld a, [bc] ; $5139
	ld a, $10 ; $513a
	ld b, $80 ; $513c
	rst Rst18 ; $513e
	ld l, $0a ; $513f
	ld a, $10 ; $5141
	ld bc, $0c00 ; $5143
	ld de, $1300 ; $5146
	rst Rst18 ; $5149
	inc h ; $514a
	ld a, [bc] ; $514b
	ld a, $0f ; $514c
	ld bc, $0b00 ; $514e
	ld de, $1300 ; $5151
	rst Rst18 ; $5154
	inc h ; $5155
	ld a, [bc] ; $5156
	ld a, $0f ; $5157
	rst Rst18 ; $5159
	jr nz, Label_0f_5166 ; $515a
	ld a, $10 ; $515c
	ld b, $01 ; $515e
	rst Rst18 ; $5160
	inc l ; $5161
	ld a, [bc] ; $5162
	ld a, $10 ; $5163
	INCBIN "data/bank_00f/d_5165.bin" ; $5165, 1 bytes
Label_0f_5166:
	nop ; $5166
	rrca ; $5167
	ld de, $1300 ; $5168
	rst Rst18 ; $516b
	inc h ; $516c
	ld a, [bc] ; $516d
	ld a, $10 ; $516e
	rst Rst18 ; $5170
	jr nz, Label_0f_517d ; $5171
	ld a, $10 ; $5173
	ld b, $00 ; $5175
	rst Rst18 ; $5177
	inc l ; $5178
	ld a, [bc] ; $5179
	ld a, $10 ; $517a
	INCBIN "data/bank_00f/d_517c.bin" ; $517c, 1 bytes
Label_0f_517d:
	nop ; $517d
	ld de, $0011 ; $517e
	ld d, $df ; $5181
	inc h ; $5183
	ld a, [bc] ; $5184
	ld a, $10 ; $5185
	rst Rst18 ; $5187
	jr nz, Label_0f_5194 ; $5188
	ld a, $10 ; $518a
	ld b, $c0 ; $518c
	rst Rst18 ; $518e
	ld l, $0a ; $518f
	ld hl, $28b9 ; $5191
Label_0f_5194:
	rst Rst18 ; $5194
	ld c, $0a ; $5195
	ld a, $0c ; $5197
	ld bc, $0010 ; $5199
	rst Rst18 ; $519c
	jr Label_0f_51a9 ; $519d
	INCBIN "data/bank_00f/d_519f.bin" ; $519f, 10 bytes
Label_0f_51a9:
	ld a, [bc] ; $51a9
	ld a, $0f ; $51aa
	ld bc, $0a00 ; $51ac
	ld de, $1000 ; $51af
	rst Rst18 ; $51b2
	inc h ; $51b3
	ld a, [bc] ; $51b4
	ld a, $0f ; $51b5
	rst Rst18 ; $51b7
	jr nz, Label_0f_51c4 ; $51b8
	ld a, $1e ; $51ba
	call Func_0f_5678 ; $51bc
	ld a, $0c ; $51bf
	rst Rst18 ; $51c1
	INCBIN "data/bank_00f/d_51c2.bin" ; $51c2, 2 bytes
Label_0f_51c4:
	ld a, $1e ; $51c4
	call Func_0f_5678 ; $51c6
	ld a, $0c ; $51c9
	ld bc, $0a00 ; $51cb
	ld de, $1000 ; $51ce
	rst Rst18 ; $51d1
	inc h ; $51d2
	ld a, [bc] ; $51d3
	ld a, $0f ; $51d4
	ld bc, $0a00 ; $51d6
	ld de, $0f00 ; $51d9
	rst Rst18 ; $51dc
	inc h ; $51dd
	ld a, [bc] ; $51de
	ld a, $0f ; $51df
	rst Rst18 ; $51e1
	jr nz, Label_0f_51ee ; $51e2
	ld a, $05 ; $51e4
	call Func_0f_5678 ; $51e6
	ld a, $13 ; $51e9
	ld d, $02 ; $51eb
	rst Rst18 ; $51ed
Label_0f_51ee:
	inc [hl] ; $51ee
	ld a, [bc] ; $51ef
	ld a, $13 ; $51f0
	rst Rst18 ; $51f2
	ld [hl], $0a ; $51f3
	ld a, $0c ; $51f5
	ld b, $01 ; $51f7
	rst Rst18 ; $51f9
	inc l ; $51fa
	ld a, [bc] ; $51fb
	ld a, $0c ; $51fc
	ld bc, $0a00 ; $51fe
	ld de, $1100 ; $5201
	rst Rst18 ; $5204
	inc h ; $5205
	ld a, [bc] ; $5206
	ld a, $0c ; $5207
	rst Rst18 ; $5209
	jr nz, Label_0f_5216 ; $520a
	ld a, $0c ; $520c
	ld b, $00 ; $520e
	rst Rst18 ; $5210
	inc l ; $5211
	ld a, [bc] ; $5212
	ld a, $0c ; $5213
	INCBIN "data/bank_00f/d_5215.bin" ; $5215, 1 bytes
Label_0f_5216:
	ret nz ; $5216
	rst Rst18 ; $5217
	ld l, $0a ; $5218
	ld a, $32 ; $521a
	call Func_0f_5678 ; $521c
	ld a, $0f ; $521f
	ld bc, $3f00 ; $5221
	ld de, $3f00 ; $5224
	rst Rst18 ; $5227
	ld [hl+], a ; $5228
	ld a, [bc] ; $5229
	ld a, $04 ; $522a
	ld bc, $0c80 ; $522c
	ld de, $0c80 ; $522f
	rst Rst18 ; $5232
	ld [hl+], a ; $5233
	ld a, [bc] ; $5234
	rst Rst08 ; $5235
	sbc a, c ; $5236
	ld a, $50 ; $5237
	call Func_0f_5678 ; $5239
	ld a, $04 ; $523c
	ld bc, $3f00 ; $523e
	ld de, $3f00 ; $5241
	rst Rst18 ; $5244
	ld [hl+], a ; $5245
	ld a, [bc] ; $5246
	ld a, $13 ; $5247
	rst Rst18 ; $5249
	ld [$3e0a], sp ; $524a
	dec d ; $524d
	ld d, $02 ; $524e
	rst Rst18 ; $5250
	inc [hl] ; $5251
	ld a, [bc] ; $5252
	ld a, $15 ; $5253
	rst Rst18 ; $5255
	ld [hl], $0a ; $5256
	ld a, $15 ; $5258
	rst Rst18 ; $525a
	ld [$3e0a], sp ; $525b
	dec b ; $525e
	ld bc, $0b80 ; $525f
	ld de, $0f80 ; $5262
	rst Rst18 ; $5265
	ld [hl+], a ; $5266
	ld a, [bc] ; $5267
	rst Rst08 ; $5268
	sbc a, b ; $5269
	ld a, $78 ; $526a
	call Func_0f_5678 ; $526c
	ld a, $05 ; $526f
	ld bc, $3f00 ; $5271
	ld de, $3f00 ; $5274
	rst Rst18 ; $5277
	ld [hl+], a ; $5278
	ld a, [bc] ; $5279
	ld a, $13 ; $527a
	ld d, $04 ; $527c
	rst Rst18 ; $527e
	inc [hl] ; $527f
	ld a, [bc] ; $5280
	ld a, $13 ; $5281
	rst Rst18 ; $5283
	ld [hl], $0a ; $5284
	ld a, $13 ; $5286
	rst Rst18 ; $5288
	ld [$3e0a], sp ; $5289
	ld d, $16 ; $528c
	ld [bc], a ; $528e
	rst Rst18 ; $528f
	inc [hl] ; $5290
	ld a, [bc] ; $5291
	ld a, $11 ; $5292
	ld d, $02 ; $5294
	rst Rst18 ; $5296
	inc [hl] ; $5297
	ld a, [bc] ; $5298
	ld a, $11 ; $5299
	rst Rst18 ; $529b
	ld [hl], $0a ; $529c
	ld a, $16 ; $529e
	ld b, $80 ; $52a0
	rst Rst18 ; $52a2
	ld l, $0a ; $52a3
	ld a, $11 ; $52a5
	ld b, $80 ; $52a7
	rst Rst18 ; $52a9
	ld l, $0a ; $52aa
	ld a, $3c ; $52ac
	call Func_0f_5678 ; $52ae
	ld a, $16 ; $52b1
	ld b, $40 ; $52b3
	rst Rst18 ; $52b5
	ld l, $0a ; $52b6
	ld a, $11 ; $52b8
	ld b, $40 ; $52ba
	rst Rst18 ; $52bc
	ld l, $0a ; $52bd
	ld a, $15 ; $52bf
	ld d, $02 ; $52c1
	rst Rst18 ; $52c3
	inc [hl] ; $52c4
	ld a, [bc] ; $52c5
	ld a, $15 ; $52c6
	rst Rst18 ; $52c8
	ld [hl], $0a ; $52c9
	ld a, $15 ; $52cb
	rst Rst18 ; $52cd
	ld [$3e0a], sp ; $52ce
	inc c ; $52d1
	ld d, $03 ; $52d2
	rst Rst18 ; $52d4
	inc [hl] ; $52d5
	ld a, [bc] ; $52d6
	ld a, $0c ; $52d7
	rst Rst18 ; $52d9
	ld [hl], $0a ; $52da
	ld a, $0c ; $52dc
	rst Rst18 ; $52de
	ld [$3e0a], sp ; $52df
	ld e, $cd ; $52e2
	ld a, b ; $52e4
	ld d, [hl] ; $52e5
	ld a, $0c ; $52e6
	ld bc, $0a00 ; $52e8
	ld de, $1300 ; $52eb
	rst Rst18 ; $52ee
	inc h ; $52ef
	ld a, [bc] ; $52f0
	ld a, $0c ; $52f1
	rst Rst18 ; $52f3
	jr nz, Label_0f_5300 ; $52f4
	ld a, $0c ; $52f6
	ld bc, $0e00 ; $52f8
	ld de, $1300 ; $52fb
	rst Rst18 ; $52fe
	inc h ; $52ff
Label_0f_5300:
	ld a, [bc] ; $5300
	ld a, $0c ; $5301
	rst Rst18 ; $5303
	jr nz, Label_0f_5310 ; $5304
	ld a, $0c ; $5306
	ld b, $c0 ; $5308
	rst Rst18 ; $530a
	ld l, $0a ; $530b
	ld a, $14 ; $530d
	INCBIN "data/bank_00f/d_530f.bin" ; $530f, 1 bytes
Label_0f_5310:
	ld a, b ; $5310
	ld d, [hl] ; $5311
	ld a, $0d ; $5312
	ld bc, $0010 ; $5314
	rst Rst18 ; $5317
	jr Label_0f_5324 ; $5318
	INCBIN "data/bank_00f/d_531a.bin" ; $531a, 10 bytes
Label_0f_5324:
	ld a, [bc] ; $5324
	ld a, $10 ; $5325
	rst Rst18 ; $5327
	jr nz, Label_0f_5334 ; $5328
	ld a, $10 ; $532a
	ld b, $40 ; $532c
	rst Rst18 ; $532e
	ld l, $0a ; $532f
	ld a, $14 ; $5331
	INCBIN "data/bank_00f/d_5333.bin" ; $5333, 1 bytes
Label_0f_5334:
	ld a, b ; $5334
	ld d, [hl] ; $5335
	ld a, $0d ; $5336
	ld bc, $0f80 ; $5338
	ld de, $1600 ; $533b
	rst Rst18 ; $533e
	ld [hl+], a ; $533f
	ld a, [bc] ; $5340
	ld a, $14 ; $5341
	call Func_0f_5678 ; $5343
	ld a, $10 ; $5346
	ld bc, $3f00 ; $5348
	ld de, $3f00 ; $534b
	rst Rst18 ; $534e
	ld [hl+], a ; $534f
	ld a, [bc] ; $5350
	ld a, $09 ; $5351
	ld bc, $0f00 ; $5353
	ld de, $1600 ; $5356
	rst Rst18 ; $5359
	ld [hl+], a ; $535a
	ld a, [bc] ; $535b
	ld a, $0d ; $535c
	ld bc, $0f00 ; $535e
	ld de, $1500 ; $5361
	rst Rst18 ; $5364
	ld [hl+], a ; $5365
	ld a, [bc] ; $5366
	ld a, $09 ; $5367
	ld b, $c0 ; $5369
	rst Rst18 ; $536b
	ld l, $0a ; $536c
	ld a, $0d ; $536e
	ld d, $08 ; $5370
	rst Rst18 ; $5372
	inc [hl] ; $5373
	ld a, [bc] ; $5374
	ld a, $0d ; $5375
	ld bc, $0f00 ; $5377
	ld de, $1300 ; $537a
	rst Rst18 ; $537d
	inc h ; $537e
	ld a, [bc] ; $537f
	ld a, $09 ; $5380
	ld bc, $0f00 ; $5382
	ld de, $1400 ; $5385
	rst Rst18 ; $5388
	inc h ; $5389
	ld a, [bc] ; $538a
	ld a, $09 ; $538b
	rst Rst18 ; $538d
	jr nz, Label_0f_539a ; $538e
	ld a, $09 ; $5390
	ld bc, $3f00 ; $5392
	ld de, $3f00 ; $5395
	rst Rst18 ; $5398
	ld [hl+], a ; $5399
Label_0f_539a:
	ld a, [bc] ; $539a
	ld a, $10 ; $539b
	ld bc, $0f00 ; $539d
	ld de, $1400 ; $53a0
	rst Rst18 ; $53a3
	ld [hl+], a ; $53a4
	ld a, [bc] ; $53a5
	ld a, $10 ; $53a6
	ld b, $c0 ; $53a8
	rst Rst18 ; $53aa
	ld l, $0a ; $53ab
	ld a, $10 ; $53ad
	ld b, $01 ; $53af
	rst Rst18 ; $53b1
	inc l ; $53b2
	ld a, [bc] ; $53b3
	ld a, $10 ; $53b4
	ld bc, $0f00 ; $53b6
	ld de, $1600 ; $53b9
	rst Rst18 ; $53bc
	inc h ; $53bd
	ld a, [bc] ; $53be
	ld a, $10 ; $53bf
	rst Rst18 ; $53c1
	jr nz, Label_0f_53ce ; $53c2
	ld a, $10 ; $53c4
	ld b, $00 ; $53c6
	rst Rst18 ; $53c8
	inc l ; $53c9
	ld a, [bc] ; $53ca
	ld a, $10 ; $53cb
	INCBIN "data/bank_00f/d_53cd.bin" ; $53cd, 1 bytes
Label_0f_53ce:
	ret nz ; $53ce
	rst Rst18 ; $53cf
	ld l, $0a ; $53d0
	ld a, $0d ; $53d2
	ld bc, $0ec0 ; $53d4
	ld de, $1300 ; $53d7
	rst Rst18 ; $53da
	ld [hl+], a ; $53db
	ld a, [bc] ; $53dc
	ld a, $0c ; $53dd
	ld bc, $0f00 ; $53df
	ld de, $1300 ; $53e2
	rst Rst18 ; $53e5
	inc h ; $53e6
	ld a, [bc] ; $53e7
	ld a, $0d ; $53e8
	ld bc, $0fc0 ; $53ea
	ld de, $1300 ; $53ed
	rst Rst18 ; $53f0
	inc h ; $53f1
	ld a, [bc] ; $53f2
	ld a, $0d ; $53f3
	rst Rst18 ; $53f5
	jr nz, Label_0f_5402 ; $53f6
	ld a, $0c ; $53f8
	ld bc, $0f00 ; $53fa
	ld de, $1100 ; $53fd
	rst Rst18 ; $5400
	inc h ; $5401
Label_0f_5402:
	ld a, [bc] ; $5402
	ld a, $0d ; $5403
	ld bc, $0fc0 ; $5405
	ld de, $1100 ; $5408
	rst Rst18 ; $540b
	inc h ; $540c
	ld a, [bc] ; $540d
	ld a, $0d ; $540e
	rst Rst18 ; $5410
	jr nz, Label_0f_541d ; $5411
	ld a, $1e ; $5413
	call Func_0f_5678 ; $5415
	ld a, $0c ; $5418
	rst Rst18 ; $541a
	INCBIN "data/bank_00f/d_541b.bin" ; $541b, 2 bytes
Label_0f_541d:
	ld a, $0a ; $541d
	call Func_0f_5678 ; $541f
	ld a, $11 ; $5422
	ld d, $03 ; $5424
	rst Rst18 ; $5426
	inc [hl] ; $5427
	ld a, [bc] ; $5428
	ld a, $11 ; $5429
	rst Rst18 ; $542b
	ld [hl], $0a ; $542c
	ld a, $11 ; $542e
	rst Rst18 ; $5430
	ld [$3e0a], sp ; $5431
	inc d ; $5434
	call Func_0f_5678 ; $5435
	ld a, $0d ; $5438
	ld bc, $0e40 ; $543a
	ld de, $1100 ; $543d
	rst Rst18 ; $5440
	ld [hl+], a ; $5441
	ld a, [bc] ; $5442
	ld a, $0c ; $5443
	ld bc, $0d00 ; $5445
	ld de, $1100 ; $5448
	rst Rst18 ; $544b
	inc h ; $544c
	ld a, [bc] ; $544d
	ld a, $0d ; $544e
	ld bc, $0c40 ; $5450
	ld de, $1100 ; $5453
	rst Rst18 ; $5456
	inc h ; $5457
	ld a, [bc] ; $5458
	ld a, $0d ; $5459
	rst Rst18 ; $545b
	jr nz, Label_0f_5468 ; $545c
	ld a, $04 ; $545e
	call Func_0f_5678 ; $5460
	ld a, $0c ; $5463
	ld b, $c0 ; $5465
	rst Rst18 ; $5467
Label_0f_5468:
	ld l, $0a ; $5468
	ld a, $0d ; $546a
	ld bc, $0d00 ; $546c
	ld de, $1000 ; $546f
	rst Rst18 ; $5472
	inc h ; $5473
	ld a, [bc] ; $5474
	ld a, $0d ; $5475
	rst Rst18 ; $5477
	jr nz, Label_0f_5484 ; $5478
	ld a, $14 ; $547a
	call Func_0f_5678 ; $547c
	ld a, $0c ; $547f
	rst Rst18 ; $5481
	INCBIN "data/bank_00f/d_5482.bin" ; $5482, 2 bytes
Label_0f_5484:
	ld a, $1e ; $5484
	call Func_0f_5678 ; $5486
	ld a, $0c ; $5489
	ld bc, $0d00 ; $548b
	ld de, $1000 ; $548e
	rst Rst18 ; $5491
	inc h ; $5492
	ld a, [bc] ; $5493
	ld a, $0d ; $5494
	ld bc, $0d00 ; $5496
	ld de, $0e80 ; $5499
	rst Rst18 ; $549c
	inc h ; $549d
	ld a, [bc] ; $549e
	ld a, $0d ; $549f
	rst Rst18 ; $54a1
	jr nz, Label_0f_54ae ; $54a2
	ld a, $05 ; $54a4
	call Func_0f_5678 ; $54a6
	ld a, $0c ; $54a9
	ld b, $01 ; $54ab
	rst Rst18 ; $54ad
Label_0f_54ae:
	inc l ; $54ae
	ld a, [bc] ; $54af
	ld a, $0c ; $54b0
	ld bc, $0d00 ; $54b2
	ld de, $1100 ; $54b5
	rst Rst18 ; $54b8
	inc h ; $54b9
	ld a, [bc] ; $54ba
	ld a, $0c ; $54bb
	rst Rst18 ; $54bd
	jr nz, Label_0f_54ca ; $54be
	ld a, $0c ; $54c0
	ld b, $00 ; $54c2
	rst Rst18 ; $54c4
	inc l ; $54c5
	ld a, [bc] ; $54c6
	ld a, $0c ; $54c7
	INCBIN "data/bank_00f/d_54c9.bin" ; $54c9, 1 bytes
Label_0f_54ca:
	ret nz ; $54ca
	rst Rst18 ; $54cb
	ld l, $0a ; $54cc
	ld a, $0b ; $54ce
	ld d, $02 ; $54d0
	rst Rst18 ; $54d2
	inc [hl] ; $54d3
	ld a, [bc] ; $54d4
	ld a, $0b ; $54d5
	rst Rst18 ; $54d7
	ld [hl], $0a ; $54d8
	ld a, $16 ; $54da
	rst Rst18 ; $54dc
	ld [$3e0a], sp ; $54dd
	ld d, $16 ; $54e0
	inc bc ; $54e2
	rst Rst18 ; $54e3
	inc [hl] ; $54e4
	ld a, [bc] ; $54e5
	ld a, $11 ; $54e6
	ld d, $03 ; $54e8
	rst Rst18 ; $54ea
	inc [hl] ; $54eb
	ld a, [bc] ; $54ec
	ld a, $11 ; $54ed
	rst Rst18 ; $54ef
	ld [hl], $0a ; $54f0
	ld a, $16 ; $54f2
	rst Rst18 ; $54f4
	ld [$3e0a], sp ; $54f5
	ld de, $8006 ; $54f8
	rst Rst18 ; $54fb
	ld l, $0a ; $54fc
	ld a, $13 ; $54fe
	ld b, $00 ; $5500
	rst Rst18 ; $5502
	ld l, $0a ; $5503
	ld a, $15 ; $5505
	ld b, $00 ; $5507
	rst Rst18 ; $5509
	ld l, $0a ; $550a
	ld a, $3c ; $550c
	call Func_0f_5678 ; $550e
	ld a, [$c90d] ; $5511
	ld d, $26 ; $5514
	add a, d ; $5516
	ld d, a ; $5517
	ld a, $16 ; $5518
	rst Rst18 ; $551a
	ld d, $0a ; $551b
	ld c, l ; $551d
	ld b, h ; $551e
	rst Rst18 ; $551f
	inc l ; $5520
	inc b ; $5521
	ld a, $16 ; $5522
	ld d, $01 ; $5524
	rst Rst18 ; $5526
	inc [hl] ; $5527
	ld a, [bc] ; $5528
	ld a, $16 ; $5529
	ld b, $00 ; $552b
	rst Rst18 ; $552d
	ld l, $0a ; $552e
	ld a, $16 ; $5530
	ld d, $08 ; $5532
	rst Rst18 ; $5534
	inc [hl] ; $5535
	ld a, [bc] ; $5536
	ld a, $0d ; $5537
	ld bc, $0c40 ; $5539
	ld de, $0c60 ; $553c
	rst Rst18 ; $553f
	ld [hl+], a ; $5540
	ld a, [bc] ; $5541
	xor a, a ; $5542
	ld bc, $0c00 ; $5543
	ld de, $0d00 ; $5546
	rst Rst18 ; $5549
	ld a, [hl-] ; $554a
	ld a, [bc] ; $554b
	rst Rst18 ; $554c
	ld a, $0a ; $554d
	ld a, $b4 ; $554f
	call Func_0f_5678 ; $5551
	ld c, $01 ; $5554
	call Func_00_1d20 ; $5556
	call Func_00_1da4 ; $5559
	ld b, $01 ; $555c
	ld a, [$c90d] ; $555e
	ld d, a ; $5561
	sla a ; $5562
	ld c, a ; $5564
	ld a, [$c94d] ; $5565
	xor a, d ; $5568
	or a, c ; $5569
	ld c, a ; $556a
	rst Rst18 ; $556b
	adc a, [hl] ; $556c
	jr Label_0f_55ad ; $556d
	INCBIN "data/bank_00f/d_556f.bin" ; $556f, 62 bytes
Label_0f_55ad:
	rst Rst18 ; $55ad
	inc [hl] ; $55ae
	ld a, [bc] ; $55af
	ld a, $0f ; $55b0
	ld d, $08 ; $55b2
	rst Rst18 ; $55b4
	inc [hl] ; $55b5
	ld a, [bc] ; $55b6
	rst Rst30 ; $55b7
	ldh [rTIMA], a ; $55b8
	jr nz, Label_0f_55c3 ; $55ba
	ld a, $0d ; $55bc
	ld d, $06 ; $55be
	rst Rst18 ; $55c0
	inc [hl] ; $55c1
	ld a, [bc] ; $55c2
Label_0f_55c3:
	call Func_0f_7b20 ; $55c3
	ld a, [$c295] ; $55c6
	cp a, $0a ; $55c9
	jp z, Label_0f_56a8 ; $55cb
	cp a, $0b ; $55ce
	jp z, Label_0f_5889 ; $55d0
	call Func_0f_5f7a ; $55d3
	and a, $01 ; $55d6
	jr z, Label_0f_5600 ; $55d8
	ld a, $08 ; $55da
	ld bc, $0900 ; $55dc
	ld de, $1d00 ; $55df
	rst Rst18 ; $55e2
	inc h ; $55e3
	ld a, [bc] ; $55e4
	ld a, $08 ; $55e5
	rst Rst18 ; $55e7
	jr nz, Label_0f_55f4 ; $55e8
	ld a, $08 ; $55ea
	ld b, $00 ; $55ec
	rst Rst18 ; $55ee
	ld l, $0a ; $55ef
	ld b, $0a ; $55f1
	INCBIN "data/bank_00f/d_55f3.bin" ; $55f3, 1 bytes
Label_0f_55f4:
	inc e ; $55f4
	ld d, $0a ; $55f5
	ld e, $1a ; $55f7
	ld h, $04 ; $55f9
	ld l, $02 ; $55fb
	rst Rst18 ; $55fd
	add a, d ; $55fe
	ld a, [bc] ; $55ff
Label_0f_5600:
	rst Rst30 ; $5600
	ldh [rTIMA], a ; $5601
	jp nz, Label_0f_5627 ; $5603
	call Func_0f_5f52 ; $5606
	ld hl, $c2b2 ; $5609
	ld a, [hl+] ; $560c
	ld b, [hl] ; $560d
	ld c, a ; $560e
	ld hl, $c2b4 ; $560f
	ld a, [hl+] ; $5612
	ld d, [hl] ; $5613
	ld e, a ; $5614
	ld a, $03 ; $5615
	rst Rst18 ; $5617
	ld [hl+], a ; $5618
	ld a, [bc] ; $5619
	ld a, $03 ; $561a
	rst Rst18 ; $561c
	ld d, $0a ; $561d
	ld c, l ; $561f
	ld b, h ; $5620
	ld de, $d000 ; $5621
	rst Rst18 ; $5624
	jr nz, Label_0f_562b ; $5625
Label_0f_5627:
	ret ; $5627
	INCBIN "data/bank_00f/d_5628.bin" ; $5628, 3 bytes
Label_0f_562b:
	rst Rst18 ; $562b
	ld c, $0a ; $562c
	call Func_0f_5f7a ; $562e
	and a, $01 ; $5631
	jr z, Label_0f_563b ; $5633
	ld hl, $2881 ; $5635
	rst Rst18 ; $5638
	ld c, $0a ; $5639
Label_0f_563b:
	ld a, $08 ; $563b
	rst Rst18 ; $563d
	ld [$c90a], sp ; $563e
Func_0f_5641:
	ld a, [$c90d] ; $5641
	ld d, $56 ; $5644
	add a, d ; $5646
	ld d, a ; $5647
	ld a, $16 ; $5648
	rst Rst18 ; $564a
	ld d, $0a ; $564b
	ld c, l ; $564d
	ld b, h ; $564e
	rst Rst18 ; $564f
	inc l ; $5650
	inc b ; $5651
	ld a, $16 ; $5652
	ld d, $01 ; $5654
	rst Rst18 ; $5656
	inc [hl] ; $5657
	ld a, [bc] ; $5658
	ld a, $00 ; $5659
	ld bc, $3f00 ; $565b
	ld de, $3f00 ; $565e
	rst Rst18 ; $5661
	ld [hl+], a ; $5662
	ld a, [bc] ; $5663
	ret ; $5664
	INCBIN "data/bank_00f/d_5665.bin" ; $5665, 19 bytes
Func_0f_5678:
	push af ; $5678
	ld a, a ; $5679
	rst Rst18 ; $567a
	inc b ; $567b
	ld a, [bc] ; $567c
	pop af ; $567d
	ret ; $567e
Func_0f_567f:
	ld a, $08 ; $567f
	ld de, $ff80 ; $5681
	rst Rst18 ; $5684
	ld b, d ; $5685
	ld a, [bc] ; $5686
	ld a, $08 ; $5687
	rst Rst18 ; $5689
	ld b, h ; $568a
	ld a, [bc] ; $568b
	rst Rst08 ; $568c
	add a, e ; $568d
	ld a, $02 ; $568e
	rst Rst18 ; $5690
	ld b, b ; $5691
	ld a, [bc] ; $5692
	ld a, $08 ; $5693
	call Func_0f_5678 ; $5695
	ld a, $01 ; $5698
	rst Rst18 ; $569a
	ld b, b ; $569b
	ld a, [bc] ; $569c
	ld a, $08 ; $569d
	call Func_0f_5678 ; $569f
	ld a, $00 ; $56a2
	rst Rst18 ; $56a4
	ld b, b ; $56a5
	ld a, [bc] ; $56a6
	ret ; $56a7
Label_0f_56a8:
	call Func_0f_5b4d ; $56a8
	ld a, $03 ; $56ab
	ld d, $02 ; $56ad
	rst Rst18 ; $56af
	inc [hl] ; $56b0
	ld a, [bc] ; $56b1
	ld a, $03 ; $56b2
	rst Rst18 ; $56b4
	ld [hl], $0a ; $56b5
	ld a, $00 ; $56b7
	ld b, a ; $56b9
	ld a, $03 ; $56ba
	rst Rst18 ; $56bc
	jr nc, Label_0f_56c9 ; $56bd
	ld a, $0a ; $56bf
	call Func_0f_5678 ; $56c1
	ld hl, $286b ; $56c4
	rst Rst18 ; $56c7
	INCBIN "data/bank_00f/d_56c8.bin" ; $56c8, 1 bytes
Label_0f_56c9:
	ld a, [bc] ; $56c9
	ld a, $03 ; $56ca
	rst Rst18 ; $56cc
	ld [$3e0a], sp ; $56cd
	inc bc ; $56d0
	ld d, $03 ; $56d1
	rst Rst18 ; $56d3
	inc [hl] ; $56d4
	ld a, [bc] ; $56d5
	ld a, $03 ; $56d6
	rst Rst18 ; $56d8
	ld [hl], $0a ; $56d9
	ld a, $03 ; $56db
	rst Rst18 ; $56dd
	ld [$3e0a], sp ; $56de
	nop ; $56e1
	ld d, $03 ; $56e2
	rst Rst18 ; $56e4
	inc [hl] ; $56e5
	ld a, [bc] ; $56e6
	ld a, $00 ; $56e7
	rst Rst18 ; $56e9
	ld [hl], $0a ; $56ea
	ld a, $03 ; $56ec
	ld b, a ; $56ee
	ld a, $04 ; $56ef
	rst Rst18 ; $56f1
	jr nc, Label_0f_56fe ; $56f2
	ld a, $04 ; $56f4
	ld d, $02 ; $56f6
	rst Rst18 ; $56f8
	inc [hl] ; $56f9
	ld a, [bc] ; $56fa
	ld a, $04 ; $56fb
	rst Rst18 ; $56fd
Label_0f_56fe:
	ld [hl], $0a ; $56fe
	ld a, $04 ; $5700
	rst Rst18 ; $5702
	ld [$3e0a], sp ; $5703
	inc de ; $5706
	ld bc, $0c80 ; $5707
	ld de, $2580 ; $570a
	rst Rst18 ; $570d
	ld [hl+], a ; $570e
	ld a, [bc] ; $570f
	rst Rst08 ; $5710
	sbc a, c ; $5711
	ld a, $3c ; $5712
	call Func_0f_5678 ; $5714
	ld a, $13 ; $5717
	ld bc, $3f00 ; $5719
	ld de, $3f00 ; $571c
	rst Rst18 ; $571f
	ld [hl+], a ; $5720
	ld a, [bc] ; $5721
	ld a, $03 ; $5722
	ld d, $02 ; $5724
	rst Rst18 ; $5726
	inc [hl] ; $5727
	ld a, [bc] ; $5728
	ld a, $03 ; $5729
	rst Rst18 ; $572b
	ld [hl], $0a ; $572c
	ld a, $04 ; $572e
	ld b, a ; $5730
	ld a, $03 ; $5731
	rst Rst18 ; $5733
	jr nc, Label_0f_5740 ; $5734
	ld a, $03 ; $5736
	rst Rst18 ; $5738
	ld [$3e0a], sp ; $5739
	inc b ; $573c
	ld d, $02 ; $573d
	rst Rst18 ; $573f
Label_0f_5740:
	inc [hl] ; $5740
	ld a, [bc] ; $5741
	ld a, $04 ; $5742
	rst Rst18 ; $5744
	ld [hl], $0a ; $5745
	ld a, $04 ; $5747
	rst Rst18 ; $5749
	ld [$3e0a], sp ; $574a
	ld e, $cd ; $574d
	ld a, b ; $574f
	ld d, [hl] ; $5750
	ld a, $00 ; $5751
	ld b, a ; $5753
Label_0f_5754:
	ld a, $03 ; $5754
	rst Rst18 ; $5756
	ld [hl-], a ; $5757
	ld a, [bc] ; $5758
	ld a, $50 ; $5759
	call Func_0f_5678 ; $575b
	ld a, $04 ; $575e
	ld b, a ; $5760
	ld a, $03 ; $5761
	rst Rst18 ; $5763
	jr nc, Label_0f_5770 ; $5764
	ld a, $04 ; $5766
	ld b, a ; $5768
	ld a, $00 ; $5769
	rst Rst18 ; $576b
	ld [hl-], a ; $576c
	ld a, [bc] ; $576d
	ld a, $1e ; $576e
Label_0f_5770:
	call Func_0f_5678 ; $5770
	ld a, $04 ; $5773
	ld d, $04 ; $5775
	rst Rst18 ; $5777
	inc [hl] ; $5778
	ld a, [bc] ; $5779
	ld a, $04 ; $577a
	rst Rst18 ; $577c
	ld [hl], $0a ; $577d
	ld a, $04 ; $577f
	rst Rst18 ; $5781
	ld [$3e0a], sp ; $5782
	jr z, Label_0f_5754 ; $5785
	ld a, b ; $5787
	ld d, [hl] ; $5788
	ld a, $0b ; $5789
	rst Rst18 ; $578b
	ld [$3e0a], sp ; $578c
	inc bc ; $578f
	ld b, $c0 ; $5790
	rst Rst18 ; $5792
	ld l, $0a ; $5793
	ld a, $04 ; $5795
	ld b, $c0 ; $5797
	rst Rst18 ; $5799
Label_0f_579a:
	ld l, $0a ; $579a
	ld a, $14 ; $579c
	call Func_0f_5678 ; $579e
	ld bc, $0018 ; $57a1
	rst Rst18 ; $57a4
	jr c, Label_0f_57b1 ; $57a5
	xor a, a ; $57a7
	ld bc, $0c00 ; $57a8
	ld de, $1300 ; $57ab
	rst Rst18 ; $57ae
	ld a, [hl-] ; $57af
	ld a, [bc] ; $57b0
Label_0f_57b1:
	rst Rst18 ; $57b1
	ld a, $0a ; $57b2
	ld a, $1e ; $57b4
	call Func_0f_5678 ; $57b6
	ld a, $0b ; $57b9
	ld d, $02 ; $57bb
	rst Rst18 ; $57bd
	inc [hl] ; $57be
	ld a, [bc] ; $57bf
	ld a, $0b ; $57c0
	rst Rst18 ; $57c2
	ld [hl], $0a ; $57c3
	ld a, $0b ; $57c5
	rst Rst18 ; $57c7
	ld [$3e0a], sp ; $57c8
	jr z, Label_0f_579a ; $57cb
	ld a, b ; $57cd
	ld d, [hl] ; $57ce
	xor a, a ; $57cf
	ld bc, $0c00 ; $57d0
	ld de, $2900 ; $57d3
	rst Rst18 ; $57d6
	ld a, [hl-] ; $57d7
	ld a, [bc] ; $57d8
	rst Rst18 ; $57d9
	ld a, $0a ; $57da
	ld a, $04 ; $57dc
	ld b, $40 ; $57de
	rst Rst18 ; $57e0
	ld l, $0a ; $57e1
	ld a, $04 ; $57e3
	rst Rst18 ; $57e5
	ld [$3e0a], sp ; $57e6
	inc bc ; $57e9
	ld b, $00 ; $57ea
	rst Rst18 ; $57ec
	ld l, $0a ; $57ed
	ld a, $04 ; $57ef
	ld d, $02 ; $57f1
	rst Rst18 ; $57f3
	inc [hl] ; $57f4
	ld a, [bc] ; $57f5
	ld a, $04 ; $57f6
	rst Rst18 ; $57f8
	ld [hl], $0a ; $57f9
	ld a, $04 ; $57fb
	rst Rst18 ; $57fd
	ld [$3e0a], sp ; $57fe
	inc bc ; $5801
	ld d, $02 ; $5802
	rst Rst18 ; $5804
	inc [hl] ; $5805
	ld a, [bc] ; $5806
	ld a, $03 ; $5807
	rst Rst18 ; $5809
	ld [hl], $0a ; $580a
	ld a, $04 ; $580c
	ld b, $80 ; $580e
	rst Rst18 ; $5810
	ld l, $0a ; $5811
	ld a, $03 ; $5813
	rst Rst18 ; $5815
	ld [$3e0a], sp ; $5816
	inc de ; $5819
	ld bc, $0e80 ; $581a
	ld de, $2580 ; $581d
	rst Rst18 ; $5820
	ld [hl+], a ; $5821
	ld a, [bc] ; $5822
	rst Rst08 ; $5823
	sbc a, c ; $5824
	ld a, $3c ; $5825
	call Func_0f_5678 ; $5827
	ld a, $13 ; $582a
	ld bc, $3f00 ; $582c
	ld de, $3f00 ; $582f
	rst Rst18 ; $5832
	ld [hl+], a ; $5833
	ld a, [bc] ; $5834
	ld a, $04 ; $5835
	ld b, $c0 ; $5837
	rst Rst18 ; $5839
	ld l, $0a ; $583a
	ld a, $28 ; $583c
	call Func_0f_5678 ; $583e
	ld a, $03 ; $5841
	ld b, $40 ; $5843
	rst Rst18 ; $5845
	ld l, $0a ; $5846
	ld a, $03 ; $5848
	rst Rst18 ; $584a
	ld [$3e0a], sp ; $584b
	inc bc ; $584e
	ld d, $02 ; $584f
	rst Rst18 ; $5851
	inc [hl] ; $5852
	ld a, [bc] ; $5853
	ld a, $03 ; $5854
	rst Rst18 ; $5856
	ld [hl], $0a ; $5857
	ld a, $03 ; $5859
	rst Rst18 ; $585b
	ld [$3e0a], sp ; $585c
	nop ; $585f
	ld d, $02 ; $5860
	rst Rst18 ; $5862
	inc [hl] ; $5863
	ld a, [bc] ; $5864
	ld a, $00 ; $5865
	rst Rst18 ; $5867
	ld [hl], $0a ; $5868
	ld a, $03 ; $586a
	rst Rst18 ; $586c
	ld [$3e0a], sp ; $586d
	nop ; $5870
	ld d, $03 ; $5871
	rst Rst18 ; $5873
	inc [hl] ; $5874
	ld a, [bc] ; $5875
	ld a, $00 ; $5876
	rst Rst18 ; $5878
	ld [hl], $0a ; $5879
	ld a, $03 ; $587b
	rst Rst18 ; $587d
	ld d, $0a ; $587e
	ld c, l ; $5880
	ld b, h ; $5881
	ld de, $d000 ; $5882
	rst Rst18 ; $5885
	jr nz, Label_0f_588c ; $5886
	ret ; $5888
Label_0f_5889:
	ld a, $02 ; $5889
	rst Rst18 ; $588b
Label_0f_588c:
	inc e ; $588c
	ld a, [bc] ; $588d
	ld a, $02 ; $588e
	ld bc, $0b00 ; $5890
	ld de, $2700 ; $5893
	rst Rst18 ; $5896
	ld [hl+], a ; $5897
	ld a, [bc] ; $5898
	ld a, $02 ; $5899
	ld b, $c0 ; $589b
	rst Rst18 ; $589d
	ld l, $0a ; $589e
	call Func_0f_5b4d ; $58a0
	ld hl, $2897 ; $58a3
	rst Rst18 ; $58a6
	ld c, $0a ; $58a7
	ld a, $02 ; $58a9
	ld d, $02 ; $58ab
	rst Rst18 ; $58ad
	inc [hl] ; $58ae
	ld a, [bc] ; $58af
	ld a, $02 ; $58b0
	rst Rst18 ; $58b2
	ld [hl], $0a ; $58b3
	ld a, $02 ; $58b5
	ld b, $40 ; $58b7
	rst Rst18 ; $58b9
	ld l, $0a ; $58ba
	call Func_0f_5aec ; $58bc
	ld a, $00 ; $58bf
	ld d, $03 ; $58c1
	rst Rst18 ; $58c3
	inc [hl] ; $58c4
	ld a, [bc] ; $58c5
	ld a, $00 ; $58c6
	rst Rst18 ; $58c8
	ld [hl], $0a ; $58c9
	ld a, $02 ; $58cb
	ld d, $03 ; $58cd
	rst Rst18 ; $58cf
	inc [hl] ; $58d0
	ld a, [bc] ; $58d1
	ld a, $02 ; $58d2
	rst Rst18 ; $58d4
	ld [hl], $0a ; $58d5
	call Func_0f_5aec ; $58d7
	ld a, $00 ; $58da
	ld d, $03 ; $58dc
	rst Rst18 ; $58de
	inc [hl] ; $58df
	ld a, [bc] ; $58e0
	ld a, $00 ; $58e1
	rst Rst18 ; $58e3
	ld [hl], $0a ; $58e4
	ld a, $02 ; $58e6
	ld b, a ; $58e8
	ld a, $04 ; $58e9
	rst Rst18 ; $58eb
	jr nc, Label_0f_58f8 ; $58ec
	ld a, $0a ; $58ee
	call Func_0f_5678 ; $58f0
	ld a, $04 ; $58f3
	ld d, $02 ; $58f5
	rst Rst18 ; $58f7
Label_0f_58f8:
	inc [hl] ; $58f8
	ld a, [bc] ; $58f9
	ld a, $04 ; $58fa
	rst Rst18 ; $58fc
	ld [hl], $0a ; $58fd
	ld a, $04 ; $58ff
	rst Rst18 ; $5901
	ld [$3e0a], sp ; $5902
	nop ; $5905
	ld b, a ; $5906
	ld a, $05 ; $5907
	rst Rst18 ; $5909
	jr nc, Label_0f_5916 ; $590a
	ld a, $05 ; $590c
	rst Rst18 ; $590e
	ld [$3e0a], sp ; $590f
	dec d ; $5912
	ld bc, $0c80 ; $5913
Label_0f_5916:
	ld de, $2580 ; $5916
	rst Rst18 ; $5919
	ld [hl+], a ; $591a
	ld a, [bc] ; $591b
	rst Rst08 ; $591c
	sbc a, b ; $591d
	ld a, $3c ; $591e
	call Func_0f_5678 ; $5920
	ld a, $15 ; $5923
	ld bc, $3f00 ; $5925
	ld de, $3f00 ; $5928
	rst Rst18 ; $592b
	ld [hl+], a ; $592c
	ld a, [bc] ; $592d
	ld a, $02 ; $592e
	ld b, $00 ; $5930
	rst Rst18 ; $5932
	ld l, $0a ; $5933
	ld a, $02 ; $5935
	ld d, $02 ; $5937
	rst Rst18 ; $5939
	inc [hl] ; $593a
	ld a, [bc] ; $593b
	ld a, $02 ; $593c
	rst Rst18 ; $593e
	ld [hl], $0a ; $593f
	call Func_0f_5aec ; $5941
	ld a, $04 ; $5944
	ld d, $02 ; $5946
	rst Rst18 ; $5948
	inc [hl] ; $5949
	ld a, [bc] ; $594a
	ld a, $04 ; $594b
	rst Rst18 ; $594d
	ld [hl], $0a ; $594e
	ld a, $04 ; $5950
	rst Rst18 ; $5952
	ld [$3e0a], sp ; $5953
	dec b ; $5956
	ld d, $02 ; $5957
	rst Rst18 ; $5959
	inc [hl] ; $595a
	ld a, [bc] ; $595b
	ld a, $05 ; $595c
	rst Rst18 ; $595e
	ld [hl], $0a ; $595f
	ld a, $05 ; $5961
	rst Rst18 ; $5963
	ld [$3e0a], sp ; $5964
	ld e, $cd ; $5967
	ld a, b ; $5969
	ld d, [hl] ; $596a
	ld a, $02 ; $596b
	ld b, a ; $596d
	ld a, $00 ; $596e
	rst Rst18 ; $5970
	ld [hl-], a ; $5971
	ld a, [bc] ; $5972
Label_0f_5973:
	ld a, $3c ; $5973
	call Func_0f_5678 ; $5975
	ld a, $00 ; $5978
	ld b, $00 ; $597a
	rst Rst18 ; $597c
	ld l, $0a ; $597d
	ld a, $02 ; $597f
	ld b, $00 ; $5981
	rst Rst18 ; $5983
	ld l, $0a ; $5984
	ld a, $1e ; $5986
	call Func_0f_5678 ; $5988
	ld a, $04 ; $598b
	ld b, $40 ; $598d
	rst Rst18 ; $598f
	ld l, $0a ; $5990
	ld a, $04 ; $5992
	ld d, $04 ; $5994
	rst Rst18 ; $5996
	inc [hl] ; $5997
	ld a, [bc] ; $5998
	ld a, $04 ; $5999
	rst Rst18 ; $599b
	ld [hl], $0a ; $599c
	ld a, $04 ; $599e
	rst Rst18 ; $59a0
	ld [$3e0a], sp ; $59a1
	jr z, Label_0f_5973 ; $59a4
	ld a, b ; $59a6
	ld d, [hl] ; $59a7
	ld a, $0b ; $59a8
	rst Rst18 ; $59aa
	ld [$3e0a], sp ; $59ab
	nop ; $59ae
	ld b, $c0 ; $59af
	rst Rst18 ; $59b1
	ld l, $0a ; $59b2
	ld a, $02 ; $59b4
	ld b, $c0 ; $59b6
	rst Rst18 ; $59b8
	ld l, $0a ; $59b9
	ld a, $04 ; $59bb
	ld b, $c0 ; $59bd
	rst Rst18 ; $59bf
	ld l, $0a ; $59c0
	ld a, $05 ; $59c2
	ld b, $c0 ; $59c4
	rst Rst18 ; $59c6
Label_0f_59c7:
	ld l, $0a ; $59c7
	ld a, $14 ; $59c9
	call Func_0f_5678 ; $59cb
	ld bc, $0018 ; $59ce
	rst Rst18 ; $59d1
	jr c, Label_0f_59de ; $59d2
	xor a, a ; $59d4
	ld bc, $0c00 ; $59d5
	ld de, $1300 ; $59d8
	rst Rst18 ; $59db
	ld a, [hl-] ; $59dc
	ld a, [bc] ; $59dd
Label_0f_59de:
	rst Rst18 ; $59de
	ld a, $0a ; $59df
	ld a, $1e ; $59e1
	call Func_0f_5678 ; $59e3
	ld a, $0b ; $59e6
	ld d, $02 ; $59e8
	rst Rst18 ; $59ea
	inc [hl] ; $59eb
	ld a, [bc] ; $59ec
	ld a, $0b ; $59ed
	rst Rst18 ; $59ef
	ld [hl], $0a ; $59f0
	ld a, $0b ; $59f2
	rst Rst18 ; $59f4
	ld [$3e0a], sp ; $59f5
	jr z, Label_0f_59c7 ; $59f8
	ld a, b ; $59fa
	ld d, [hl] ; $59fb
	xor a, a ; $59fc
	ld bc, $0c00 ; $59fd
	ld de, $2900 ; $5a00
	rst Rst18 ; $5a03
	ld a, [hl-] ; $5a04
	ld a, [bc] ; $5a05
	rst Rst18 ; $5a06
	ld a, $0a ; $5a07
	ld a, $04 ; $5a09
	ld b, $80 ; $5a0b
	rst Rst18 ; $5a0d
	ld l, $0a ; $5a0e
	ld a, $04 ; $5a10
	rst Rst18 ; $5a12
	ld [$3e0a], sp ; $5a13
	nop ; $5a16
	ld b, $00 ; $5a17
	rst Rst18 ; $5a19
	ld l, $0a ; $5a1a
	ld a, $02 ; $5a1c
	ld b, $00 ; $5a1e
	rst Rst18 ; $5a20
	ld l, $0a ; $5a21
	ld a, $04 ; $5a23
	ld d, $02 ; $5a25
	rst Rst18 ; $5a27
	inc [hl] ; $5a28
	ld a, [bc] ; $5a29
	ld a, $04 ; $5a2a
	rst Rst18 ; $5a2c
	ld [hl], $0a ; $5a2d
	ld a, $04 ; $5a2f
	rst Rst18 ; $5a31
	ld [$3e0a], sp ; $5a32
	dec b ; $5a35
	ld b, $80 ; $5a36
	rst Rst18 ; $5a38
	ld l, $0a ; $5a39
	ld a, $05 ; $5a3b
	ld d, $02 ; $5a3d
	rst Rst18 ; $5a3f
	inc [hl] ; $5a40
	ld a, [bc] ; $5a41
	ld a, $05 ; $5a42
	rst Rst18 ; $5a44
	ld [hl], $0a ; $5a45
	ld a, $05 ; $5a47
	rst Rst18 ; $5a49
	ld [$3e0a], sp ; $5a4a
	ld [bc], a ; $5a4d
	ld d, $02 ; $5a4e
	rst Rst18 ; $5a50
	inc [hl] ; $5a51
	ld a, [bc] ; $5a52
	ld a, $02 ; $5a53
	rst Rst18 ; $5a55
	ld [hl], $0a ; $5a56
	call Func_0f_5aec ; $5a58
	ld a, $13 ; $5a5b
	ld bc, $0e80 ; $5a5d
	ld de, $2580 ; $5a60
	rst Rst18 ; $5a63
	ld [hl+], a ; $5a64
	ld a, [bc] ; $5a65
	rst Rst08 ; $5a66
	sbc a, c ; $5a67
	ld a, $3c ; $5a68
	call Func_0f_5678 ; $5a6a
	ld a, $13 ; $5a6d
	ld bc, $0e80 ; $5a6f
	ld de, $2780 ; $5a72
	rst Rst18 ; $5a75
	ld [hl+], a ; $5a76
	ld a, [bc] ; $5a77
	rst Rst08 ; $5a78
	sbc a, c ; $5a79
	ld a, $3c ; $5a7a
	call Func_0f_5678 ; $5a7c
	ld a, $13 ; $5a7f
	ld bc, $3f00 ; $5a81
	ld de, $3f00 ; $5a84
	rst Rst18 ; $5a87
	ld [hl+], a ; $5a88
	ld a, [bc] ; $5a89
	ld a, $04 ; $5a8a
	ld b, $c0 ; $5a8c
	rst Rst18 ; $5a8e
	ld l, $0a ; $5a8f
	ld a, $05 ; $5a91
	ld b, $c0 ; $5a93
	rst Rst18 ; $5a95
	ld l, $0a ; $5a96
	ld a, $1e ; $5a98
	call Func_0f_5678 ; $5a9a
	ld a, $00 ; $5a9d
	ld b, a ; $5a9f
	ld a, $02 ; $5aa0
	rst Rst18 ; $5aa2
	ld [hl-], a ; $5aa3
	ld a, [bc] ; $5aa4
	call Func_0f_5aec ; $5aa5
	ld a, $02 ; $5aa8
	ld d, $02 ; $5aaa
	rst Rst18 ; $5aac
	inc [hl] ; $5aad
	ld a, [bc] ; $5aae
	ld a, $02 ; $5aaf
	rst Rst18 ; $5ab1
	ld [hl], $0a ; $5ab2
	call Func_0f_5aec ; $5ab4
	ld a, $00 ; $5ab7
	ld d, $02 ; $5ab9
	rst Rst18 ; $5abb
	inc [hl] ; $5abc
	ld a, [bc] ; $5abd
	ld a, $00 ; $5abe
	rst Rst18 ; $5ac0
	ld [hl], $0a ; $5ac1
	ld a, $02 ; $5ac3
	ld d, $03 ; $5ac5
	rst Rst18 ; $5ac7
	inc [hl] ; $5ac8
	ld a, [bc] ; $5ac9
	ld a, $02 ; $5aca
	rst Rst18 ; $5acc
	ld [hl], $0a ; $5acd
	call Func_0f_5aec ; $5acf
	ld a, $00 ; $5ad2
	ld d, $03 ; $5ad4
	rst Rst18 ; $5ad6
	inc [hl] ; $5ad7
	ld a, [bc] ; $5ad8
	ld a, $00 ; $5ad9
	rst Rst18 ; $5adb
	ld [hl], $0a ; $5adc
	ld a, $02 ; $5ade
	rst Rst18 ; $5ae0
	ld d, $0a ; $5ae1
	ld c, l ; $5ae3
	ld b, h ; $5ae4
	ld de, $d000 ; $5ae5
	rst Rst18 ; $5ae8
	jr nz, Label_0f_5aef ; $5ae9
	ret ; $5aeb
Func_0f_5aec:
	ld a, [$c94d] ; $5aec
Label_0f_5aef:
	and a, a ; $5aef
	jr nz, Label_0f_5afb ; $5af0
	ld a, $02 ; $5af2
	rst Rst18 ; $5af4
	ld [$df0a], sp ; $5af5
	INCBIN "data/bank_00f/d_5af8.bin" ; $5af8, 3 bytes
Label_0f_5afb:
	rst Rst18 ; $5afb
	INCBIN "data/bank_00f/d_5afc.bin" ; $5afc, 81 bytes
Func_0f_5b4d:
	ld bc, $00ff ; $5b4d
	rst Rst18 ; $5b50
	jr c, Label_0f_5b5d ; $5b51
	xor a, a ; $5b53
	ld bc, $0c00 ; $5b54
	ld de, $0b00 ; $5b57
	rst Rst18 ; $5b5a
	ld a, [hl-] ; $5b5b
	ld a, [bc] ; $5b5c
Label_0f_5b5d:
	rst Rst18 ; $5b5d
	ld a, $0a ; $5b5e
	xor a, a ; $5b60
	ld [$c2d5], a ; $5b61
	ld c, $04 ; $5b64
	call Func_00_1d2e ; $5b66
	call Func_00_1da4 ; $5b69
	ld d, $30 ; $5b6c
	ld a, $13 ; $5b6e
	rst Rst18 ; $5b70
	ld d, $0a ; $5b71
	ld c, l ; $5b73
	ld b, h ; $5b74
	rst Rst18 ; $5b75
	inc l ; $5b76
	inc b ; $5b77
	ld a, $13 ; $5b78
	ld d, $01 ; $5b7a
	rst Rst18 ; $5b7c
	inc [hl] ; $5b7d
	ld a, [bc] ; $5b7e
	ld d, $3a ; $5b7f
	ld a, $14 ; $5b81
	rst Rst18 ; $5b83
	ld d, $0a ; $5b84
	ld c, l ; $5b86
	ld b, h ; $5b87
	rst Rst18 ; $5b88
	inc l ; $5b89
	inc b ; $5b8a
	ld a, $14 ; $5b8b
	ld d, $01 ; $5b8d
	rst Rst18 ; $5b8f
	inc [hl] ; $5b90
	ld a, [bc] ; $5b91
	ld a, $13 ; $5b92
	ld bc, $0700 ; $5b94
	ld de, $0100 ; $5b97
	rst Rst18 ; $5b9a
	ld [hl+], a ; $5b9b
	ld a, [bc] ; $5b9c
	ld a, $14 ; $5b9d
	ld bc, $0f00 ; $5b9f
	ld de, $0100 ; $5ba2
	rst Rst18 ; $5ba5
	ld [hl+], a ; $5ba6
	ld a, [bc] ; $5ba7
	ld a, $13 ; $5ba8
	ld bc, $0020 ; $5baa
	rst Rst18 ; $5bad
	jr Label_0f_5bba ; $5bae
	INCBIN "data/bank_00f/d_5bb0.bin" ; $5bb0, 10 bytes
Label_0f_5bba:
	ld a, [bc] ; $5bba
	ld a, $13 ; $5bbb
	rst Rst18 ; $5bbd
	jr nz, Label_0f_5bca ; $5bbe
	ld a, $13 ; $5bc0
	ld d, $04 ; $5bc2
	rst Rst18 ; $5bc4
	inc [hl] ; $5bc5
	ld a, [bc] ; $5bc6
	ld a, $13 ; $5bc7
	rst Rst18 ; $5bc9
Label_0f_5bca:
	ld [hl], $0a ; $5bca
	ld a, $13 ; $5bcc
	ld de, $ff80 ; $5bce
	rst Rst18 ; $5bd1
	ld b, d ; $5bd2
	ld a, [bc] ; $5bd3
	ld a, $13 ; $5bd4
	rst Rst18 ; $5bd6
	ld b, h ; $5bd7
	ld a, [bc] ; $5bd8
	ld a, $14 ; $5bd9
	ld bc, $0020 ; $5bdb
	rst Rst18 ; $5bde
	jr Label_0f_5beb ; $5bdf
	INCBIN "data/bank_00f/d_5be1.bin" ; $5be1, 10 bytes
Label_0f_5beb:
	ld a, [bc] ; $5beb
	ld a, $14 ; $5bec
	rst Rst18 ; $5bee
	jr nz, Label_0f_5bfb ; $5bef
	ld a, $13 ; $5bf1
	ld de, $ff80 ; $5bf3
	rst Rst18 ; $5bf6
	ld b, d ; $5bf7
	ld a, [bc] ; $5bf8
	ld a, $14 ; $5bf9
Label_0f_5bfb:
	ld d, $02 ; $5bfb
	rst Rst18 ; $5bfd
	inc [hl] ; $5bfe
	ld a, [bc] ; $5bff
	ld bc, $0010 ; $5c00
	rst Rst18 ; $5c03
	jr c, Label_0f_5c10 ; $5c04
	ld a, $00 ; $5c06
	ld b, $00 ; $5c08
	rst Rst18 ; $5c0a
	inc a ; $5c0b
	ld a, [bc] ; $5c0c
	rst Rst18 ; $5c0d
	ld a, $0a ; $5c0e
Label_0f_5c10:
	ld a, $1e ; $5c10
	call Func_0f_5678 ; $5c12
	ld d, $4e ; $5c15
	ld a, $13 ; $5c17
	rst Rst18 ; $5c19
	ld d, $0a ; $5c1a
	ld c, l ; $5c1c
	ld b, h ; $5c1d
	rst Rst18 ; $5c1e
	inc l ; $5c1f
	inc b ; $5c20
	ld a, $13 ; $5c21
	ld d, $01 ; $5c23
	rst Rst18 ; $5c25
	inc [hl] ; $5c26
	ld a, [bc] ; $5c27
	ld d, $53 ; $5c28
	ld a, $14 ; $5c2a
	rst Rst18 ; $5c2c
	ld d, $0a ; $5c2d
	ld c, l ; $5c2f
	ld b, h ; $5c30
	rst Rst18 ; $5c31
	inc l ; $5c32
	inc b ; $5c33
	ld a, $14 ; $5c34
	ld d, $01 ; $5c36
	rst Rst18 ; $5c38
	inc [hl] ; $5c39
	ld a, [bc] ; $5c3a
	ld a, $13 ; $5c3b
	ld bc, $3f00 ; $5c3d
	ld de, $3f00 ; $5c40
	rst Rst18 ; $5c43
	ld [hl+], a ; $5c44
	ld a, [bc] ; $5c45
	ld a, $14 ; $5c46
	ld bc, $3f00 ; $5c48
	ld de, $3f00 ; $5c4b
	rst Rst18 ; $5c4e
	ld [hl+], a ; $5c4f
	ld a, [bc] ; $5c50
	ret ; $5c51
Func_0f_5c52:
	ld a, $0c ; $5c52
	ld b, a ; $5c54
	ld a, $0b ; $5c55
	rst Rst18 ; $5c57
	ld [hl-], a ; $5c58
	ld a, [bc] ; $5c59
	ld a, $1e ; $5c5a
	call Func_0f_5678 ; $5c5c
	ld a, $0b ; $5c5f
	ld d, $03 ; $5c61
	rst Rst18 ; $5c63
	inc [hl] ; $5c64
	ld a, [bc] ; $5c65
	ld a, $0b ; $5c66
	rst Rst18 ; $5c68
	ld [hl], $0a ; $5c69
	ld a, $0c ; $5c6b
	ld d, $03 ; $5c6d
	rst Rst18 ; $5c6f
	inc [hl] ; $5c70
	ld a, [bc] ; $5c71
	ld a, $0c ; $5c72
	rst Rst18 ; $5c74
	ld [hl], $0a ; $5c75
	ld a, $1e ; $5c77
	call Func_0f_5678 ; $5c79
	ld a, $0b ; $5c7c
	ld b, $00 ; $5c7e
	rst Rst18 ; $5c80
	ld l, $0a ; $5c81
	ld a, $0c ; $5c83
	ld b, $00 ; $5c85
	rst Rst18 ; $5c87
	ld l, $0a ; $5c88
	ld hl, $2885 ; $5c8a
	rst Rst18 ; $5c8d
	ld c, $0a ; $5c8e
	ld a, $0b ; $5c90
	rst Rst18 ; $5c92
	ld [$c90a], sp ; $5c93
Func_0f_5c96:
	ld a, $05 ; $5c96
	ld b, $c0 ; $5c98
	rst Rst18 ; $5c9a
	ld l, $0a ; $5c9b
	ld a, $08 ; $5c9d
	ld b, $c0 ; $5c9f
	rst Rst18 ; $5ca1
	ld l, $0a ; $5ca2
	ld a, $09 ; $5ca4
	ld b, $c0 ; $5ca6
	rst Rst18 ; $5ca8
	ld l, $0a ; $5ca9
	ld a, $0a ; $5cab
	ld b, $c0 ; $5cad
	rst Rst18 ; $5caf
	ld l, $0a ; $5cb0
	ld a, $06 ; $5cb2
	ld b, $c0 ; $5cb4
	rst Rst18 ; $5cb6
	ld l, $0a ; $5cb7
	ld a, $12 ; $5cb9
	ld b, $c0 ; $5cbb
	rst Rst18 ; $5cbd
	ld l, $0a ; $5cbe
	ld a, $07 ; $5cc0
	ld b, $c0 ; $5cc2
	rst Rst18 ; $5cc4
	ld l, $0a ; $5cc5
	ld a, $11 ; $5cc7
	ld b, $c0 ; $5cc9
	rst Rst18 ; $5ccb
	ld l, $0a ; $5ccc
	ret ; $5cce
Func_0f_5ccf:
	ld a, $1e ; $5ccf
	call Func_0f_5678 ; $5cd1
	ld a, $0b ; $5cd4
	rst Rst18 ; $5cd6
	ld [$3e0a], sp ; $5cd7
	dec bc ; $5cda
	ld d, $03 ; $5cdb
	rst Rst18 ; $5cdd
	inc [hl] ; $5cde
	ld a, [bc] ; $5cdf
	ld a, $0b ; $5ce0
	rst Rst18 ; $5ce2
	ld [hl], $0a ; $5ce3
	ld a, $0b ; $5ce5
	ld b, $c0 ; $5ce7
	rst Rst18 ; $5ce9
	ld l, $0a ; $5cea
	ld a, $1e ; $5cec
	call Func_0f_5678 ; $5cee
	ld a, $0b ; $5cf1
	ld b, $01 ; $5cf3
	rst Rst18 ; $5cf5
	inc l ; $5cf6
	ld a, [bc] ; $5cf7
	ld a, $0b ; $5cf8
	ld bc, $0700 ; $5cfa
	ld de, $1b00 ; $5cfd
	rst Rst18 ; $5d00
	inc h ; $5d01
	ld a, [bc] ; $5d02
	ld a, $0b ; $5d03
	rst Rst18 ; $5d05
	jr nz, Label_0f_5d12 ; $5d06
	ld a, $0b ; $5d08
	ld b, $00 ; $5d0a
	rst Rst18 ; $5d0c
	inc l ; $5d0d
	ld a, [bc] ; $5d0e
	ld a, $0b ; $5d0f
	INCBIN "data/bank_00f/d_5d11.bin" ; $5d11, 1 bytes
Label_0f_5d12:
	nop ; $5d12
	rst Rst18 ; $5d13
	ld l, $0a ; $5d14
	ld a, $0c ; $5d16
	ld bc, $0800 ; $5d18
	ld de, $1900 ; $5d1b
	rst Rst18 ; $5d1e
	inc h ; $5d1f
	ld a, [bc] ; $5d20
	ld a, $0c ; $5d21
	rst Rst18 ; $5d23
	jr nz, Label_0f_5d30 ; $5d24
	ld a, $0c ; $5d26
	ld b, $00 ; $5d28
	rst Rst18 ; $5d2a
	ld l, $0a ; $5d2b
	ld a, $1e ; $5d2d
	INCBIN "data/bank_00f/d_5d2f.bin" ; $5d2f, 1 bytes
Label_0f_5d30:
	ld a, b ; $5d30
	ld d, [hl] ; $5d31
	ld a, $0c ; $5d32
	ld d, $03 ; $5d34
	rst Rst18 ; $5d36
	inc [hl] ; $5d37
	ld a, [bc] ; $5d38
	ld a, $0c ; $5d39
	rst Rst18 ; $5d3b
	ld [hl], $0a ; $5d3c
	ld a, $0c ; $5d3e
	rst Rst18 ; $5d40
	ld [$3e0a], sp ; $5d41
	inc c ; $5d44
	ld d, $04 ; $5d45
	rst Rst18 ; $5d47
	inc [hl] ; $5d48
	ld a, [bc] ; $5d49
	ld a, $0c ; $5d4a
	rst Rst18 ; $5d4c
	ld [hl], $0a ; $5d4d
	ld a, $0c ; $5d4f
	rst Rst18 ; $5d51
	ld [$3e0a], sp ; $5d52
	inc c ; $5d55
	ld d, $02 ; $5d56
	rst Rst18 ; $5d58
	inc [hl] ; $5d59
	ld a, [bc] ; $5d5a
	ld a, $0c ; $5d5b
	rst Rst18 ; $5d5d
	ld [hl], $0a ; $5d5e
	ld a, $0c ; $5d60
	rst Rst18 ; $5d62
	ld [$3e0a], sp ; $5d63
	inc c ; $5d66
	ld d, $04 ; $5d67
	rst Rst18 ; $5d69
	inc [hl] ; $5d6a
	ld a, [bc] ; $5d6b
	ld a, $0c ; $5d6c
	rst Rst18 ; $5d6e
	ld [hl], $0a ; $5d6f
	ld a, $0c ; $5d71
	rst Rst18 ; $5d73
	ld [$3e0a], sp ; $5d74
	inc c ; $5d77
	ld d, $03 ; $5d78
	rst Rst18 ; $5d7a
	inc [hl] ; $5d7b
	ld a, [bc] ; $5d7c
	ld a, $0c ; $5d7d
	rst Rst18 ; $5d7f
	ld [hl], $0a ; $5d80
	ld a, $0c ; $5d82
	rst Rst18 ; $5d84
	ld [$3e0a], sp ; $5d85
	inc c ; $5d88
	ld d, $03 ; $5d89
	rst Rst18 ; $5d8b
	inc [hl] ; $5d8c
	ld a, [bc] ; $5d8d
	ld a, $0c ; $5d8e
	rst Rst18 ; $5d90
	ld [hl], $0a ; $5d91
	ld a, $3c ; $5d93
	call Func_0f_5678 ; $5d95
	ld a, $0c ; $5d98
	ld bc, $0800 ; $5d9a
	ld de, $1700 ; $5d9d
	rst Rst18 ; $5da0
	inc h ; $5da1
	ld a, [bc] ; $5da2
	ld a, $0c ; $5da3
	rst Rst18 ; $5da5
	jr nz, Label_0f_5db2 ; $5da6
	ld a, $0c ; $5da8
	ld b, $00 ; $5daa
	rst Rst18 ; $5dac
	ld l, $0a ; $5dad
	ld a, $0b ; $5daf
	INCBIN "data/bank_00f/d_5db1.bin" ; $5db1, 1 bytes
Label_0f_5db2:
	nop ; $5db2
	ld [$0011], sp ; $5db3
	add hl, de ; $5db6
	rst Rst18 ; $5db7
	inc h ; $5db8
	ld a, [bc] ; $5db9
	ld a, $0b ; $5dba
	rst Rst18 ; $5dbc
	jr nz, Label_0f_5dc9 ; $5dbd
	ld a, $0b ; $5dbf
	ld b, $00 ; $5dc1
	rst Rst18 ; $5dc3
	ld l, $0a ; $5dc4
	ld a, $1e ; $5dc6
	INCBIN "data/bank_00f/d_5dc8.bin" ; $5dc8, 1 bytes
Label_0f_5dc9:
	ld a, b ; $5dc9
	ld d, [hl] ; $5dca
	ld a, $0b ; $5dcb
	rst Rst18 ; $5dcd
	ld [$160a], sp ; $5dce
	jr nc, Label_0f_5e11 ; $5dd1
	rlca ; $5dd3
	rst Rst18 ; $5dd4
	ld d, $0a ; $5dd5
	ld c, l ; $5dd7
	ld b, h ; $5dd8
	rst Rst18 ; $5dd9
	inc l ; $5dda
	inc b ; $5ddb
	ld a, $07 ; $5ddc
	ld d, $01 ; $5dde
	rst Rst18 ; $5de0
	inc [hl] ; $5de1
	ld a, [bc] ; $5de2
	ld d, $3a ; $5de3
	ld a, $14 ; $5de5
	rst Rst18 ; $5de7
	ld d, $0a ; $5de8
	ld c, l ; $5dea
	ld b, h ; $5deb
	rst Rst18 ; $5dec
	inc l ; $5ded
	inc b ; $5dee
	ld a, $14 ; $5def
	ld d, $01 ; $5df1
	rst Rst18 ; $5df3
	inc [hl] ; $5df4
	ld a, [bc] ; $5df5
	ld a, $07 ; $5df6
	ld bc, $0700 ; $5df8
	ld de, $0500 ; $5dfb
	rst Rst18 ; $5dfe
	ld [hl+], a ; $5dff
	ld a, [bc] ; $5e00
	ld a, $14 ; $5e01
	ld bc, $0f00 ; $5e03
	ld de, $0780 ; $5e06
	rst Rst18 ; $5e09
	ld [hl+], a ; $5e0a
	ld a, [bc] ; $5e0b
	ld a, $07 ; $5e0c
	ld b, $40 ; $5e0e
	rst Rst18 ; $5e10
Label_0f_5e11:
	ld l, $0a ; $5e11
	ld a, $14 ; $5e13
	ld b, $40 ; $5e15
	rst Rst18 ; $5e17
	ld l, $0a ; $5e18
	ld a, $1e ; $5e1a
	call Func_0f_5678 ; $5e1c
	xor a, a ; $5e1f
	ld bc, $0c00 ; $5e20
	ld de, $1100 ; $5e23
	rst Rst18 ; $5e26
	ld a, [hl-] ; $5e27
	ld a, [bc] ; $5e28
	ld a, $0c ; $5e29
	ld bc, $0c00 ; $5e2b
	ld de, $1700 ; $5e2e
	rst Rst18 ; $5e31
	inc h ; $5e32
	ld a, [bc] ; $5e33
	ld a, $0c ; $5e34
	rst Rst18 ; $5e36
	jr nz, Label_0f_5e43 ; $5e37
	ld a, $0c ; $5e39
	ld bc, $0c00 ; $5e3b
	ld de, $1300 ; $5e3e
	rst Rst18 ; $5e41
	inc h ; $5e42
Label_0f_5e43:
	ld a, [bc] ; $5e43
	ld a, $0c ; $5e44
	rst Rst18 ; $5e46
	jr nz, Label_0f_5e53 ; $5e47
	ret ; $5e49
Func_0f_5e4a:
	ld d, $74 ; $5e4a
	ld a, $10 ; $5e4c
	rst Rst18 ; $5e4e
	ld d, $0a ; $5e4f
	ld c, l ; $5e51
	ld b, h ; $5e52
Label_0f_5e53:
	rst Rst18 ; $5e53
	inc l ; $5e54
	inc b ; $5e55
	ld a, $10 ; $5e56
	ld d, $01 ; $5e58
	rst Rst18 ; $5e5a
	inc [hl] ; $5e5b
	ld a, [bc] ; $5e5c
	ld d, $25 ; $5e5d
	ld a, $0f ; $5e5f
	rst Rst18 ; $5e61
	ld d, $0a ; $5e62
	ld c, l ; $5e64
	ld b, h ; $5e65
	rst Rst18 ; $5e66
	inc l ; $5e67
	inc b ; $5e68
	ld a, $0f ; $5e69
	ld d, $01 ; $5e6b
	rst Rst18 ; $5e6d
	inc [hl] ; $5e6e
	ld a, [bc] ; $5e6f
	ld a, $0f ; $5e70
	ld bc, $1100 ; $5e72
	ld de, $1600 ; $5e75
	rst Rst18 ; $5e78
	ld [hl+], a ; $5e79
	ld a, [bc] ; $5e7a
	ld a, $10 ; $5e7b
	ld bc, $1100 ; $5e7d
	ld de, $1500 ; $5e80
	rst Rst18 ; $5e83
	ld [hl+], a ; $5e84
	ld a, [bc] ; $5e85
	ld a, $0f ; $5e86
	ld b, $c0 ; $5e88
	rst Rst18 ; $5e8a
	ld l, $0a ; $5e8b
	ld a, $10 ; $5e8d
	ld d, $08 ; $5e8f
	rst Rst18 ; $5e91
	inc [hl] ; $5e92
	ld a, [bc] ; $5e93
	ld a, $10 ; $5e94
	ld bc, $1100 ; $5e96
	ld de, $1200 ; $5e99
	rst Rst18 ; $5e9c
	inc h ; $5e9d
	ld a, [bc] ; $5e9e
	ld a, $0f ; $5e9f
	ld bc, $1100 ; $5ea1
	ld de, $1300 ; $5ea4
	rst Rst18 ; $5ea7
	inc h ; $5ea8
	ld a, [bc] ; $5ea9
	ld a, $0f ; $5eaa
	rst Rst18 ; $5eac
	jr nz, Label_0f_5eb9 ; $5ead
	ld d, $25 ; $5eaf
	ld a, $10 ; $5eb1
	rst Rst18 ; $5eb3
	ld d, $0a ; $5eb4
	ld c, l ; $5eb6
	ld b, h ; $5eb7
	rst Rst18 ; $5eb8
Label_0f_5eb9:
	inc l ; $5eb9
	inc b ; $5eba
	ld a, $10 ; $5ebb
	ld d, $01 ; $5ebd
	rst Rst18 ; $5ebf
	inc [hl] ; $5ec0
	ld a, [bc] ; $5ec1
	ld d, $74 ; $5ec2
	ld a, $0f ; $5ec4
	rst Rst18 ; $5ec6
	ld d, $0a ; $5ec7
	ld c, l ; $5ec9
	ld b, h ; $5eca
	rst Rst18 ; $5ecb
	inc l ; $5ecc
	inc b ; $5ecd
	ld a, $0f ; $5ece
	ld d, $01 ; $5ed0
	rst Rst18 ; $5ed2
	inc [hl] ; $5ed3
	ld a, [bc] ; $5ed4
	ld a, $10 ; $5ed5
	ld bc, $1100 ; $5ed7
	ld de, $1300 ; $5eda
	rst Rst18 ; $5edd
	ld [hl+], a ; $5ede
	ld a, [bc] ; $5edf
	ld a, $0f ; $5ee0
	ld bc, $1000 ; $5ee2
	ld de, $1300 ; $5ee5
	rst Rst18 ; $5ee8
	ld [hl+], a ; $5ee9
	ld a, [bc] ; $5eea
	ld a, $10 ; $5eeb
	ld b, $80 ; $5eed
	rst Rst18 ; $5eef
	ld l, $0a ; $5ef0
	ld a, $0f ; $5ef2
	ld d, $08 ; $5ef4
	rst Rst18 ; $5ef6
	inc [hl] ; $5ef7
	ld a, [bc] ; $5ef8
	ld a, $10 ; $5ef9
	ld bc, $1000 ; $5efb
	ld de, $1300 ; $5efe
	rst Rst18 ; $5f01
	inc h ; $5f02
	ld a, [bc] ; $5f03
	ld a, $0f ; $5f04
	ld bc, $0f00 ; $5f06
	ld de, $1300 ; $5f09
	rst Rst18 ; $5f0c
	inc h ; $5f0d
	ld a, [bc] ; $5f0e
	ld a, $0f ; $5f0f
	rst Rst18 ; $5f11
	jr nz, Label_0f_5f1e ; $5f12
	ld a, $10 ; $5f14
	ld b, $01 ; $5f16
	rst Rst18 ; $5f18
	inc l ; $5f19
	ld a, [bc] ; $5f1a
	ld a, $10 ; $5f1b
	INCBIN "data/bank_00f/d_5f1d.bin" ; $5f1d, 1 bytes
Label_0f_5f1e:
	nop ; $5f1e
	ld de, $0011 ; $5f1f
	inc de ; $5f22
	rst Rst18 ; $5f23
	inc h ; $5f24
	ld a, [bc] ; $5f25
	ld a, $10 ; $5f26
	rst Rst18 ; $5f28
	jr nz, Label_0f_5f35 ; $5f29
	ld a, $10 ; $5f2b
	ld b, $00 ; $5f2d
	rst Rst18 ; $5f2f
	inc l ; $5f30
	ld a, [bc] ; $5f31
	ld a, $10 ; $5f32
	INCBIN "data/bank_00f/d_5f34.bin" ; $5f34, 1 bytes
Label_0f_5f35:
	jr nz, Label_0f_5f37 ; $5f35
Label_0f_5f37:
	rst Rst18 ; $5f37
	jr Label_0f_5f44 ; $5f38
	INCBIN "data/bank_00f/d_5f3a.bin" ; $5f3a, 10 bytes
Label_0f_5f44:
	ld a, [bc] ; $5f44
	ld a, $10 ; $5f45
	rst Rst18 ; $5f47
	jr nz, Label_0f_5f54 ; $5f48
	ld a, $10 ; $5f4a
	ld b, $c0 ; $5f4c
	rst Rst18 ; $5f4e
	ld l, $0a ; $5f4f
	ret ; $5f51
Func_0f_5f52:
	ld a, $04 ; $5f52
Label_0f_5f54:
	ldh [$ff96], a ; $5f54
	ldh [rWBK], a ; $5f56
	ld a, $00 ; $5f58
	rst Rst18 ; $5f5a
	ld d, $0a ; $5f5b
	ld c, l ; $5f5d
	ld b, h ; $5f5e
	ld hl, $000c ; $5f5f
	add hl, bc ; $5f62
	ld a, [hl+] ; $5f63
	ld d, [hl] ; $5f64
	ld e, a ; $5f65
	ld hl, $c2b2 ; $5f66
	ld a, e ; $5f69
	ld [hl+], a ; $5f6a
	ld [hl], d ; $5f6b
	ld hl, $000e ; $5f6c
	add hl, bc ; $5f6f
	ld a, [hl+] ; $5f70
	ld d, [hl] ; $5f71
	ld e, a ; $5f72
	ld hl, $c2b4 ; $5f73
	ld a, e ; $5f76
	ld [hl+], a ; $5f77
	ld [hl], d ; $5f78
	ret ; $5f79
Func_0f_5f7a:
	rst Rst30 ; $5f7a
	ldh [rTIMA], a ; $5f7b
	jr z, Label_0f_5f8a ; $5f7d
	ld a, $00 ; $5f7f
	rst Rst30 ; $5f81
	add a, b ; $5f82
	INCBIN "data/bank_00f/d_5f83.bin" ; $5f83, 7 bytes
Label_0f_5f8a:
	ld a, $00 ; $5f8a
	rst Rst30 ; $5f8c
	ld h, b ; $5f8d
	INCBIN "data/bank_00f/d_5f8e.bin" ; $5f8e, 1459 bytes
	rst Rst18 ; $6541
	inc [hl] ; $6542
	ld a, [bc] ; $6543
	ld a, $00 ; $6544
	rst Rst18 ; $6546
	ld [hl], $0a ; $6547
	ld a, $03 ; $6549
	ld d, $02 ; $654b
	rst Rst18 ; $654d
	inc [hl] ; $654e
	ld a, [bc] ; $654f
	ld a, $03 ; $6550
	rst Rst18 ; $6552
	ld [hl], $0a ; $6553
	ld a, $03 ; $6555
	rst Rst18 ; $6557
	ld [$3e0a], sp ; $6558
	nop ; $655b
	ld d, $02 ; $655c
	rst Rst18 ; $655e
	inc [hl] ; $655f
	ld a, [bc] ; $6560
	ld a, $00 ; $6561
	rst Rst18 ; $6563
	ld [hl], $0a ; $6564
	rst Rst30 ; $6566
	ldh [rTIMA], a ; $6567
	jr nz, Label_0f_6582 ; $6569
	ld a, $05 ; $656b
	ld d, $03 ; $656d
	rst Rst18 ; $656f
	inc [hl] ; $6570
	ld a, [bc] ; $6571
	ld a, $05 ; $6572
	rst Rst18 ; $6574
	ld [hl], $0a ; $6575
	ld a, $05 ; $6577
	rst Rst18 ; $6579
	ld [$e70a], sp ; $657a
	ret nz ; $657d
	dec d ; $657e
	jr Label_0f_65a6 ; $657f
	INCBIN "data/bank_00f/d_6581.bin" ; $6581, 1 bytes
Label_0f_6582:
	rst Rst18 ; $6582
	INCBIN "data/bank_00f/d_6583.bin" ; $6583, 35 bytes
Label_0f_65a6:
	ld bc, $0018 ; $65a6
	rst Rst18 ; $65a9
	jr c, Label_0f_65b6 ; $65aa
	xor a, a ; $65ac
	ld bc, $1c00 ; $65ad
	ld de, $1d00 ; $65b0
	rst Rst18 ; $65b3
	ld a, [hl-] ; $65b4
	ld a, [bc] ; $65b5
Label_0f_65b6:
	rst Rst18 ; $65b6
	ld a, $0a ; $65b7
	ld a, $00 ; $65b9
	ld [$c2b0], a ; $65bb
	rst Rst18 ; $65be
	jr Label_0f_65c4 ; $65bf
	INCBIN "data/bank_00f/d_65c1.bin" ; $65c1, 3 bytes
Label_0f_65c4:
	ld d, a ; $65c4
	ld a, e ; $65c5
	nop ; $65c6
	inc e ; $65c7
	nop ; $65c8
	inc l ; $65c9
	ret nz ; $65ca
	nop ; $65cb
	ld e, h ; $65cc
	ld bc, $0000 ; $65cd
	nop ; $65d0
	nop ; $65d1
	ld d, a ; $65d2
	ld a, e ; $65d3
	nop ; $65d4
	inc e ; $65d5
	nop ; $65d6
	cpl ; $65d7
	ret nz ; $65d8
	nop ; $65d9
	ld e, d ; $65da
	ld bc, $0000 ; $65db
	nop ; $65de
	nop ; $65df
	ld d, a ; $65e0
	ld a, e ; $65e1
	nop ; $65e2
	dec e ; $65e3
	nop ; $65e4
	ld sp, $00c0 ; $65e5
	ld e, e ; $65e8
	ld bc, $0000 ; $65e9
	nop ; $65ec
	nop ; $65ed
	nop ; $65ee
	nop ; $65ef
	nop ; $65f0
	nop ; $65f1
	nop ; $65f2
	nop ; $65f3
	nop ; $65f4
	rst Rst38 ; $65f5
	inc bc ; $65f6
	rst Rst38 ; $65f7
	nop ; $65f8
	nop ; $65f9
	add hl, de ; $65fa
	inc h ; $65fb
	inc bc ; $65fc
	nop ; $65fd
	inc b ; $65fe
	rst Rst38 ; $65ff
	nop ; $6600
	nop ; $6601
	ld a, [de] ; $6602
	inc h ; $6603
	inc bc ; $6604
	nop ; $6605
	dec b ; $6606
	rst Rst38 ; $6607
	nop ; $6608
	nop ; $6609
	dec de ; $660a
	inc h ; $660b
	inc bc ; $660c
	nop ; $660d
	rst Rst38 ; $660e
Func_0f_660f:
	rst Rst30 ; $660f
	ldh [rTIMA], a ; $6610
	jr nz, Label_0f_663b ; $6612
	rst Rst30 ; $6614
	and a, b ; $6615
	rlca ; $6616
	jr z, Label_0f_661f ; $6617
	ld a, $03 ; $6619
	ld [$c2b0], a ; $661b
	ret ; $661e
Label_0f_661f:
	rst Rst30 ; $661f
	ret nz ; $6620
	rlca ; $6621
	jr z, Label_0f_662a ; $6622
	ld a, $02 ; $6624
	ld [$c2b0], a ; $6626
	ret ; $6629
Label_0f_662a:
	rst Rst30 ; $662a
	ldh [rTAC], a ; $662b
	jr z, Label_0f_6635 ; $662d
	ld a, $01 ; $662f
	ld [$c2b0], a ; $6631
	ret ; $6634
Label_0f_6635:
	ld a, $00 ; $6635
	ld [$c2b0], a ; $6637
	ret ; $663a
Label_0f_663b:
	rst Rst30 ; $663b
	ret nz ; $663c
	ld b, $28 ; $663d
	ld b, $3e ; $663f
	inc bc ; $6641
	ld [$c2b0], a ; $6642
	ret ; $6645
	INCBIN "data/bank_00f/d_6646.bin" ; $6646, 2418 bytes
	rst Rst18 ; $6fb8
	ld l, $0a ; $6fb9
	ld a, $0d ; $6fbb
	ld b, $40 ; $6fbd
	rst Rst18 ; $6fbf
	ld l, $0a ; $6fc0
	ret ; $6fc2
	INCBIN "data/bank_00f/d_6fc3.bin" ; $6fc3, 433 bytes
	rst Rst18 ; $7174
	inc h ; $7175
	ld a, [bc] ; $7176
	ld a, $05 ; $7177
	rst Rst18 ; $7179
	jr nz, Label_0f_7186 ; $717a
	ldh a, [$ff95] ; $717c
	ld b, a ; $717e
	ld a, $05 ; $717f
	ld de, $73be ; $7181
	rst Rst18 ; $7184
	ld a, [de] ; $7185
Label_0f_7186:
	ld a, [bc] ; $7186
	push af ; $7187
	ld a, $14 ; $7188
	rst Rst18 ; $718a
	inc b ; $718b
	ld a, [bc] ; $718c
	pop af ; $718d
	ldh a, [$ff95] ; $718e
	ld b, a ; $7190
	ld a, $0a ; $7191
	ld de, $73be ; $7193
	rst Rst18 ; $7196
	ld a, [de] ; $7197
	ld a, [bc] ; $7198
	push af ; $7199
	ld a, $14 ; $719a
	rst Rst18 ; $719c
	inc b ; $719d
	ld a, [bc] ; $719e
	pop af ; $719f
	ldh a, [$ff95] ; $71a0
	ld b, a ; $71a2
	ld a, $00 ; $71a3
	ld de, $73be ; $71a5
	rst Rst18 ; $71a8
	ld a, [de] ; $71a9
	ld a, [bc] ; $71aa
	xor a, a ; $71ab
	ld bc, $1100 ; $71ac
	ld de, $0d00 ; $71af
	rst Rst18 ; $71b2
	ld a, [hl-] ; $71b3
	ld a, [bc] ; $71b4
	rst Rst18 ; $71b5
	ld a, $0a ; $71b6
	push af ; $71b8
	ld a, $3c ; $71b9
	rst Rst18 ; $71bb
	inc b ; $71bc
	ld a, [bc] ; $71bd
	pop af ; $71be
	ld c, $10 ; $71bf
	call Func_00_1d20 ; $71c1
	call Func_00_1da4 ; $71c4
	call Func_0f_7434 ; $71c7
	ld a, $19 ; $71ca
	ld [wStoryModeCurrentLocation], a ; $71cc
	ld a, $0a ; $71cf
	ld [$c295], a ; $71d1
	ld a, $ff ; $71d4
	ld [$c294], a ; $71d6
	ld [$c2a1], a ; $71d9
	rst Rst18 ; $71dc
	ld c, d ; $71dd
	ld a, [bc] ; $71de
	rst Rst30 ; $71df
	and a, b ; $71e0
	rlca ; $71e1
	jr z, Label_0f_71f3 ; $71e2
	ld a, $00 ; $71e4
	ld [wCurrentMinigameStoryMatch], a ; $71e6
	ld a, $13 ; $71e9
	ld [$c8f7], a ; $71eb
	rst Rst18 ; $71ee
	ld e, d ; $71ef
	ld a, [bc] ; $71f0
	jr Label_0f_7228 ; $71f1
Label_0f_71f3:
	rst Rst30 ; $71f3
	ret nz ; $71f4
	rlca ; $71f5
	jr z, Label_0f_7207 ; $71f6
	ld a, $00 ; $71f8
	ld [wCurrentMinigameStoryMatch], a ; $71fa
	ld a, $12 ; $71fd
	ld [$c8f7], a ; $71ff
	rst Rst18 ; $7202
	ld e, d ; $7203
	ld a, [bc] ; $7204
	jr Label_0f_7228 ; $7205
Label_0f_7207:
	rst Rst30 ; $7207
	ldh [rTAC], a ; $7208
	jr z, Label_0f_721b ; $720a
	ld a, $00 ; $720c
	ld [wCurrentMinigameStoryMatch], a ; $720e
	ld a, $11 ; $7211
	ld [$c8f7], a ; $7213
	rst Rst18 ; $7216
	ld e, d ; $7217
	ld a, [bc] ; $7218
	jr Label_0f_7228 ; $7219
Label_0f_721b:
	ld a, $00 ; $721b
	ld [wCurrentMinigameStoryMatch], a ; $721d
	ld a, $10 ; $7220
	ld [$c8f7], a ; $7222
	rst Rst18 ; $7225
	ld e, d ; $7226
	ld a, [bc] ; $7227
Label_0f_7228:
	rst Rst18 ; $7228
	ld c, h ; $7229
	ld a, [bc] ; $722a
	rst Rst18 ; $722b
	ld c, [hl] ; $722c
	ld a, [bc] ; $722d
	ret ; $722e
	INCBIN "data/bank_00f/d_722f.bin" ; $722f, 487 bytes
Func_0f_7416:
	rst Rst30 ; $7416
	ldh [rTIMA], a ; $7417
	jr nz, Label_0f_7425 ; $7419
	ld b, $00 ; $741b
	ld a, [$c2b0] ; $741d
	inc a ; $7420
	ld c, a ; $7421
	ld d, $00 ; $7422
	ret ; $7424
Label_0f_7425:
	ld b, $01 ; $7425
	ld a, [$c2b0] ; $7427
	inc a ; $742a
	cp a, $03 ; $742b
	jr c, Label_0f_7430 ; $742d
	dec a ; $742f
Label_0f_7430:
	ld c, a ; $7430
	ld d, $00 ; $7431
	ret ; $7433
Func_0f_7434:
	xor a, a ; $7434
	ldh [$ffb9], a ; $7435
	ldh [$ffb8], a ; $7437
	ldh [$ff8a], a ; $7439
	ldh [$ff8b], a ; $743b
	ld [$c321], a ; $743d
	ld [$c323], a ; $7440
	call Func_00_1b38 ; $7443
	call Func_0f_7416 ; $7446
	rst Rst18 ; $7449
	ld a, [de] ; $744a
	dec de ; $744b
	ret ; $744c
	INCBIN "data/bank_00f/d_744d.bin" ; $744d, 698 bytes
	rst Rst18 ; $7707
	ld h, b ; $7708
	ld a, [bc] ; $7709
	call Func_0f_7b20 ; $770a
	ld a, $02 ; $770d
	rst Rst18 ; $770f
	inc e ; $7710
	ld a, [bc] ; $7711
	ld a, $02 ; $7712
	ld bc, $2500 ; $7714
	ld de, $1100 ; $7717
	rst Rst18 ; $771a
	ld [hl+], a ; $771b
	ld a, [bc] ; $771c
	ld a, $02 ; $771d
	ld b, $c0 ; $771f
	rst Rst18 ; $7721
	ld l, $0a ; $7722
	ld c, $04 ; $7724
	call Func_00_1d2e ; $7726
	call Func_00_1da4 ; $7729
	call Func_0f_660f ; $772c
	rst Rst18 ; $772f
	nop ; $7730
	ld a, [bc] ; $7731
	ld a, $00 ; $7732
	ld b, a ; $7734
	ld a, $02 ; $7735
	rst Rst18 ; $7737
	jr nc, Label_0f_7744 ; $7738
	ld c, $04 ; $773a
	call Func_00_1d2e ; $773c
	call Func_00_1da4 ; $773f
	INCBIN "data/bank_00f/d_7742.bin" ; $7742, 2 bytes
Label_0f_7744:
	jp nz, $873d ; $7744
	add a, $3a ; $7747
	ld l, a ; $7749
	adc a, $78 ; $774a
	sub a, l ; $774c
	ld h, a ; $774d
	ld a, [hl+] ; $774e
	ld h, [hl] ; $774f
	ld l, a ; $7750
	rst Rst18 ; $7751
	ld c, $0a ; $7752
	ld a, [$c94d] ; $7754
	or a, a ; $7757
	jr nz, Label_0f_7763 ; $7758
	rst Rst18 ; $775a
	INCBIN "data/bank_00f/d_775b.bin" ; $775b, 8 bytes
Label_0f_7763:
	ld a, $08 ; $7763
	rst Rst18 ; $7765
	ld d, $0a ; $7766
	ld c, l ; $7768
	ld b, h ; $7769
	ld hl, $0037 ; $776a
	add hl, bc ; $776d
	ld a, [hl] ; $776e
	xor a, $20 ; $776f
	ld [hl], a ; $7771
	ld a, $00 ; $7772
	ld b, a ; $7774
	ld a, $02 ; $7775
	rst Rst18 ; $7777
	jr nc, Label_0f_7784 ; $7778
	ld a, $02 ; $777a
	ld de, $ff80 ; $777c
	rst Rst18 ; $777f
	ld b, d ; $7780
	ld a, [bc] ; $7781
	ld a, $02 ; $7782
Label_0f_7784:
	rst Rst18 ; $7784
	ld b, h ; $7785
	ld a, [bc] ; $7786
	ld a, $02 ; $7787
	ld b, a ; $7789
	ld a, $00 ; $778a
	rst Rst18 ; $778c
	jr nc, Label_0f_7799 ; $778d
	ld a, $02 ; $778f
	rst Rst18 ; $7791
	ld [$3e0a], sp ; $7792
	ld [$0001], sp ; $7795
	INCBIN "data/bank_00f/d_7798.bin" ; $7798, 1 bytes
Label_0f_7799:
	ld de, $0f80 ; $7799
	rst Rst18 ; $779c
	ld [hl+], a ; $779d
	ld a, [bc] ; $779e
	rst Rst08 ; $779f
	sub a, a ; $77a0
	push af ; $77a1
	ld a, $2d ; $77a2
	rst Rst18 ; $77a4
	inc b ; $77a5
	ld a, [bc] ; $77a6
	pop af ; $77a7
	ld a, $03 ; $77a8
	ld d, $02 ; $77aa
	rst Rst18 ; $77ac
	inc [hl] ; $77ad
	ld a, [bc] ; $77ae
	ld a, $03 ; $77af
	rst Rst18 ; $77b1
	ld [hl], $0a ; $77b2
	ld a, $08 ; $77b4
	ld bc, $3f00 ; $77b6
	ld de, $3f00 ; $77b9
	rst Rst18 ; $77bc
	ld [hl+], a ; $77bd
	ld a, [bc] ; $77be
	ld a, $03 ; $77bf
	ld b, a ; $77c1
	ld a, $00 ; $77c2
	rst Rst18 ; $77c4
	jr nc, Label_0f_77d1 ; $77c5
	ld a, $03 ; $77c7
	rst Rst18 ; $77c9
	ld [$3e0a], sp ; $77ca
	inc b ; $77cd
	ld d, $03 ; $77ce
	rst Rst18 ; $77d0
Label_0f_77d1:
	inc [hl] ; $77d1
	ld a, [bc] ; $77d2
	ld a, $04 ; $77d3
	rst Rst18 ; $77d5
	ld [hl], $0a ; $77d6
	ld a, $04 ; $77d8
	ld b, a ; $77da
	ld a, $00 ; $77db
	rst Rst18 ; $77dd
	jr nc, Label_0f_77ea ; $77de
	ld a, $04 ; $77e0
	ld b, a ; $77e2
	ld a, $02 ; $77e3
	rst Rst18 ; $77e5
	jr nc, Label_0f_77f2 ; $77e6
	ld a, $04 ; $77e8
Label_0f_77ea:
	rst Rst18 ; $77ea
	ld [$cd0a], sp ; $77eb
	ld de, $3e79 ; $77ee
	nop ; $77f1
Label_0f_77f2:
	ld b, a ; $77f2
	ld a, $04 ; $77f3
	rst Rst18 ; $77f5
	jr nc, Label_0f_7802 ; $77f6
	ld a, $03 ; $77f8
	ld b, $00 ; $77fa
	rst Rst18 ; $77fc
	ld l, $0a ; $77fd
	ld hl, $2849 ; $77ff
Label_0f_7802:
	rst Rst18 ; $7802
	ld c, $0a ; $7803
	ld a, [$c2b0] ; $7805
	dec a ; $7808
	ld hl, $2862 ; $7809
	add a, l ; $780c
	ld l, a ; $780d
	jr nc, Label_0f_7811 ; $780e
	inc h ; $7810
Label_0f_7811:
	call Func_0f_7a8e ; $7811
	ld a, $04 ; $7814
	ld b, a ; $7816
	ld a, $00 ; $7817
	rst Rst18 ; $7819
	jr nc, Label_0f_7826 ; $781a
	ld a, $04 ; $781c
	ld b, a ; $781e
	ld a, $02 ; $781f
	rst Rst18 ; $7821
	jr nc, Label_0f_782e ; $7822
	ld a, $03 ; $7824
Label_0f_7826:
	rst Rst18 ; $7826
	ld [$e70a], sp ; $7827
	jr nz, Label_0f_7843 ; $782a
	ld a, $02 ; $782c
Label_0f_782e:
	rst Rst18 ; $782e
	ld d, $0a ; $782f
	ld c, l ; $7831
	ld b, h ; $7832
	ld de, $d000 ; $7833
	rst Rst18 ; $7836
	jr nz, Label_0f_783d ; $7837
	ret ; $7839
	INCBIN "data/bank_00f/d_783a.bin" ; $783a, 3 bytes
Label_0f_783d:
	jr z, Label_0f_7897 ; $783d
	jr z, $788f ; $783f
	jr z, Label_0f_7843 ; $7841
Label_0f_7843:
	nop ; $7843
	ld d, a ; $7844
	ld a, e ; $7845
	nop ; $7846
	ld hl, $1100 ; $7847
	nop ; $784a
	nop ; $784b
	ld e, h ; $784c
	ld bc, $0000 ; $784d
	nop ; $7850
	nop ; $7851
	ld d, a ; $7852
	ld a, e ; $7853
	nop ; $7854
	daa ; $7855
	nop ; $7856
	ld de, $0080 ; $7857
	ld e, d ; $785a
	ld bc, $0000 ; $785b
	nop ; $785e
	nop ; $785f
	ld d, a ; $7860
	ld a, e ; $7861
	nop ; $7862
	dec a ; $7863
	nop ; $7864
	dec a ; $7865
	ret nz ; $7866
	nop ; $7867
	ld e, e ; $7868
	ld bc, $0000 ; $7869
	nop ; $786c
	nop ; $786d
	ld d, a ; $786e
	ld a, e ; $786f
	nop ; $7870
	ld bc, $3100 ; $7871
	ret nz ; $7874
	nop ; $7875
	dec h ; $7876
	ld bc, $0000 ; $7877
	nop ; $787a
	nop ; $787b
	ld d, a ; $787c
	ld a, e ; $787d
	nop ; $787e
	ld bc, $3100 ; $787f
	ret nz ; $7882
	nop ; $7883
	dec h ; $7884
	ld bc, $0000 ; $7885
	nop ; $7888
	nop ; $7889
	ld d, a ; $788a
	ld a, e ; $788b
	nop ; $788c
	ld bc, $3100 ; $788d
	ret nz ; $7890
	nop ; $7891
	ld c, h ; $7892
	ld bc, $0000 ; $7893
	nop ; $7896
Label_0f_7897:
	nop ; $7897
	nop ; $7898
	nop ; $7899
	nop ; $789a
	nop ; $789b
	nop ; $789c
	nop ; $789d
	nop ; $789e
	rst Rst38 ; $789f
	inc bc ; $78a0
	rst Rst38 ; $78a1
	nop ; $78a2
	nop ; $78a3
	call z, Func_00_0378 ; $78a4
	nop ; $78a7
	inc b ; $78a8
	rst Rst38 ; $78a9
	nop ; $78aa
	nop ; $78ab
	or a, c ; $78ac
	ld a, b ; $78ad
	inc bc ; $78ae
	nop ; $78af
	rst Rst38 ; $78b0
	ld hl, $2849 ; $78b1
	rst Rst18 ; $78b4
	ld c, $0a ; $78b5
	ld a, [$c2b0] ; $78b7
	dec a ; $78ba
	ld hl, $2862 ; $78bb
	add a, l ; $78be
	ld l, a ; $78bf
	jr nc, Label_0f_78c3 ; $78c0
	inc h ; $78c2
Label_0f_78c3:
	call Func_0f_7a8e ; $78c3
	ld a, $04 ; $78c6
	rst Rst18 ; $78c8
	ld [$c90a], sp ; $78c9
	ld a, [$c2b0] ; $78cc
	dec a ; $78cf
	add a, a ; $78d0
	add a, $e4 ; $78d1
	ld l, a ; $78d3
	adc a, $78 ; $78d4
	sub a, l ; $78d6
	ld h, a ; $78d7
	ld a, [hl+] ; $78d8
	ld h, [hl] ; $78d9
	ld l, a ; $78da
	rst Rst18 ; $78db
	ld c, $0a ; $78dc
	ld a, $03 ; $78de
	rst Rst18 ; $78e0
	ld [$c90a], sp ; $78e1
	ld d, e ; $78e4
	jr z, Label_0f_793a ; $78e5
	jr z, Label_0f_7942 ; $78e7
	jr z, Label_0f_793a ; $78e9
	INCBIN "data/bank_00f/d_78eb.bin" ; $78eb, 1 bytes
Func_0f_78ec:
	rst Rst30 ; $78ec
	ldh [rTIMA], a ; $78ed
	jr nz, Label_0f_7901 ; $78ef
	ld a, [$c2b0] ; $78f1
	dec a ; $78f4
	ld hl, $2861 ; $78f5
	add a, l ; $78f8
	ld l, a ; $78f9
	jr nc, Label_0f_78fd ; $78fa
	inc h ; $78fc
Label_0f_78fd:
	call Func_0f_7a8e ; $78fd
	ret ; $7900
Label_0f_7901:
	ld a, [$c2b0] ; $7901
	dec a ; $7904
	ld hl, $2865 ; $7905
	add a, l ; $7908
	ld l, a ; $7909
	jr nc, Label_0f_790d ; $790a
	inc h ; $790c
Label_0f_790d:
	call Func_0f_7a8e ; $790d
	ret ; $7910
	INCBIN "data/bank_00f/d_7911.bin" ; $7911, 41 bytes
Label_0f_793a:
	rst Rst18 ; $793a
	inc h ; $793b
	ld a, [bc] ; $793c
	ld a, $07 ; $793d
	rst Rst18 ; $793f
	jr nz, Label_0f_794c ; $7940
Label_0f_7942:
	ld hl, $2869 ; $7942
	rst Rst18 ; $7945
	ld c, $0a ; $7946
	xor a, a ; $7948
	ld bc, $2300 ; $7949
Label_0f_794c:
	ld de, $1100 ; $794c
	rst Rst18 ; $794f
	ld a, [hl-] ; $7950
	ld a, [bc] ; $7951
	rst Rst18 ; $7952
	ld a, $0a ; $7953
	ld a, $03 ; $7955
	ld b, $40 ; $7957
	rst Rst18 ; $7959
	ld l, $0a ; $795a
	ld a, $04 ; $795c
	ld b, $40 ; $795e
	rst Rst18 ; $7960
	ld l, $0a ; $7961
	ld a, $05 ; $7963
	ld b, $40 ; $7965
	rst Rst18 ; $7967
	ld l, $0a ; $7968
	ld a, $00 ; $796a
	ld b, $40 ; $796c
	rst Rst18 ; $796e
	ld l, $0a ; $796f
	ld a, $02 ; $7971
	ld b, $40 ; $7973
	rst Rst18 ; $7975
	ld l, $0a ; $7976
	ld a, $06 ; $7978
	ld b, $c0 ; $797a
	rst Rst18 ; $797c
	ld l, $0a ; $797d
	ld a, $07 ; $797f
	ld b, $c0 ; $7981
	rst Rst18 ; $7983
	ld l, $0a ; $7984
	ld a, $06 ; $7986
	ld d, $03 ; $7988
	rst Rst18 ; $798a
	inc [hl] ; $798b
	ld a, [bc] ; $798c
	ld a, $06 ; $798d
	rst Rst18 ; $798f
	ld [hl], $0a ; $7990
	call Func_0f_78ec ; $7992
	ld a, $06 ; $7995
	rst Rst18 ; $7997
	ld [$3e0a], sp ; $7998
	ld b, $16 ; $799b
	inc bc ; $799d
	rst Rst18 ; $799e
	inc [hl] ; $799f
	ld a, [bc] ; $79a0
	ld a, $06 ; $79a1
	rst Rst18 ; $79a3
	ld [hl], $0a ; $79a4
	ld a, [$c2b0] ; $79a6
	ld hl, $2861 ; $79a9
	add a, l ; $79ac
	ld l, a ; $79ad
	jr nc, Label_0f_79b1 ; $79ae
	inc h ; $79b0
Label_0f_79b1:
	call Func_0f_7a8e ; $79b1
	ld a, $06 ; $79b4
	rst Rst18 ; $79b6
	ld [$3e0a], sp ; $79b7
	rlca ; $79ba
	ld b, a ; $79bb
	ld a, $06 ; $79bc
	rst Rst18 ; $79be
	ld [hl-], a ; $79bf
	ld a, [bc] ; $79c0
	push af ; $79c1
	ld a, $14 ; $79c2
	rst Rst18 ; $79c4
	inc b ; $79c5
	ld a, [bc] ; $79c6
	pop af ; $79c7
	ld a, $06 ; $79c8
	ld d, $03 ; $79ca
	rst Rst18 ; $79cc
	inc [hl] ; $79cd
	ld a, [bc] ; $79ce
	ld a, $07 ; $79cf
	ld d, $03 ; $79d1
	rst Rst18 ; $79d3
	inc [hl] ; $79d4
	ld a, [bc] ; $79d5
	ld a, $07 ; $79d6
	rst Rst18 ; $79d8
	ld [hl], $0a ; $79d9
	ld a, $06 ; $79db
	ld bc, $1500 ; $79dd
	ld de, $1700 ; $79e0
	rst Rst18 ; $79e3
	inc h ; $79e4
	ld a, [bc] ; $79e5
	ld a, $07 ; $79e6
	ld bc, $1700 ; $79e8
	ld de, $1700 ; $79eb
	rst Rst18 ; $79ee
	inc h ; $79ef
	ld a, [bc] ; $79f0
	ld a, $07 ; $79f1
	rst Rst18 ; $79f3
	jr nz, Label_0f_7a00 ; $79f4
	ld a, $00 ; $79f6
	ld b, $00 ; $79f8
	rst Rst18 ; $79fa
	inc a ; $79fb
	ld a, [bc] ; $79fc
	ld a, $06 ; $79fd
	INCBIN "data/bank_00f/d_79ff.bin" ; $79ff, 1 bytes
Label_0f_7a00:
	nop ; $7a00
	ccf ; $7a01
	ld de, $3f00 ; $7a02
	rst Rst18 ; $7a05
	ld [hl+], a ; $7a06
	ld a, [bc] ; $7a07
	ld a, $07 ; $7a08
	ld bc, $3f00 ; $7a0a
	ld de, $3f00 ; $7a0d
	rst Rst18 ; $7a10
	ld [hl+], a ; $7a11
	ld a, [bc] ; $7a12
	rst Rst18 ; $7a13
	ld a, $0a ; $7a14
	ret ; $7a16
	INCBIN "data/bank_00f/d_7a17.bin" ; $7a17, 119 bytes
Func_0f_7a8e:
	ldh a, [$ff96] ; $7a8e
	push af ; $7a90
	ld a, $07 ; $7a91
	ldh [$ff96], a ; $7a93
	ldh [rWBK], a ; $7a95
	ld de, $df00 ; $7a97
	ld a, $05 ; $7a9a
	ldh [$ff96], a ; $7a9c
	ldh [rWBK], a ; $7a9e
	rst Rst18 ; $7aa0
	ld c, [hl] ; $7aa1
	dec b ; $7aa2
	ld hl, $df00 ; $7aa3
	rst Rst18 ; $7aa6
	ld b, [hl] ; $7aa7
	dec b ; $7aa8
	pop af ; $7aa9
	ldh [$ff96], a ; $7aaa
	ldh [rWBK], a ; $7aac
	ret ; $7aae
	INCBIN "data/bank_00f/d_7aaf.bin" ; $7aaf, 113 bytes
Func_0f_7b20:
	rst Rst30 ; $7b20
	ldh [rTIMA], a ; $7b21
	jp z, Label_0f_7b3e ; $7b23
	ld a, [$c94d] ; $7b26
	ld d, $58 ; $7b29
	add a, d ; $7b2b
	ld d, a ; $7b2c
	ld a, $02 ; $7b2d
	rst Rst18 ; $7b2f
	ld d, $0a ; $7b30
	ld c, l ; $7b32
	ld b, h ; $7b33
	rst Rst18 ; $7b34
	inc l ; $7b35
	inc b ; $7b36
	ld a, $02 ; $7b37
	ld d, $01 ; $7b39
	rst Rst18 ; $7b3b
	inc [hl] ; $7b3c
	ld a, [bc] ; $7b3d
Label_0f_7b3e:
	ld a, [$c90d] ; $7b3e
	ld d, $56 ; $7b41
	add a, d ; $7b43
	ld d, a ; $7b44
	ld a, $00 ; $7b45
	rst Rst18 ; $7b47
	ld d, $0a ; $7b48
	ld c, l ; $7b4a
	ld b, h ; $7b4b
	rst Rst18 ; $7b4c
	inc l ; $7b4d
	inc b ; $7b4e
	ld a, $00 ; $7b4f
	ld d, $01 ; $7b51
	rst Rst18 ; $7b53
	inc [hl] ; $7b54
	ld a, [bc] ; $7b55
	ret ; $7b56
	INCBIN "data/bank_00f/d_7b57.bin" ; $7b57, 1193 bytes
