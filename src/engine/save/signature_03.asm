SaveSignature:
	INCLUDE "data/bank_003/SaveSignature.asm" ; $47e9, 16 bytes
WipeAllSaveRam:
	ld e, $00 ; $47f9
.loop:
	ld a, e ; $47fb
	ldh [hSramBank], a ; $47fc
	ld [rRAMB], a ; $47fe
	ld bc, $0200 ; $4801
	ld hl, $a000 ; $4804
	xor a ; $4807
.loopB:
	ld [hl+], a ; $4808
	ld [hl+], a ; $4809
	ld [hl+], a ; $480a
	ld [hl+], a ; $480b
	ld [hl+], a ; $480c
	ld [hl+], a ; $480d
	ld [hl+], a ; $480e
	ld [hl+], a ; $480f
	ld [hl+], a ; $4810
	ld [hl+], a ; $4811
	ld [hl+], a ; $4812
	ld [hl+], a ; $4813
	ld [hl+], a ; $4814
	ld [hl+], a ; $4815
	ld [hl+], a ; $4816
	ld [hl+], a ; $4817
	dec c ; $4818
	jr nz, .loopB ; $4819
	dec b ; $481b
	jr nz, .loopB ; $481c
	inc e ; $481e
	ld a, e ; $481f
	cp $04 ; $4820
	jr c, .loop ; $4822
	ret ; $4824
Unused_03_ClearSaveFlagsArea:
	xor a ; $4825
	ldh [hSramBank], a ; $4826
	ld [rRAMB], a ; $4828
	ld c, $02 ; $482b
	ld hl, sSaveFlags ; $482d
.loop:
	ld [hl+], a ; $4830
	ld [hl+], a ; $4831
	ld [hl+], a ; $4832
	ld [hl+], a ; $4833
	ld [hl+], a ; $4834
	ld [hl+], a ; $4835
	ld [hl+], a ; $4836
	ld [hl+], a ; $4837
	ld [hl+], a ; $4838
	ld [hl+], a ; $4839
	ld [hl+], a ; $483a
	ld [hl+], a ; $483b
	ld [hl+], a ; $483c
	ld [hl+], a ; $483d
	ld [hl+], a ; $483e
	ld [hl+], a ; $483f
	dec c ; $4840
	jr nz, .loop ; $4841
	ret ; $4843
SumSaveHeaderRegion:
	push af ; $4844
	push de ; $4845
	push bc ; $4846
	xor a ; $4847
	ldh [hSramBank], a ; $4848
	ld [rRAMB], a ; $484a
	ld h, a ; $484d
	ld l, a ; $484e
	ld de, sSaveFormatVersion ; $484f
	ld bc, $0838 ; $4852
.loop:
	ld a, [de] ; $4855
	inc de ; $4856
	add l ; $4857
	ld l, a ; $4858
	jr nc, .gotPtr ; $4859
	inc h ; $485b
.gotPtr:
	dec c ; $485c
	jr nz, .loop ; $485d
	dec b ; $485f
	jr nz, .loop ; $4860
	pop bc ; $4862
	pop de ; $4863
	pop af ; $4864
	ret ; $4865
UpdateSaveHeaderChecksum:
	push af ; $4866
	push bc ; $4867
	push de ; $4868
	push hl ; $4869
	call SumSaveHeaderRegion ; $486a
	ld a, l ; $486d
	ld [sSaveMasterChecksum], a ; $486e
	ld a, h ; $4871
	ld [sSaveMasterChecksum + 1], a ; $4872
	add sp, -64 ; $4875
	ld hl, sp + 0 ; $4877
	ld d, h ; $4879
	ld e, l ; $487a
	ld hl, $a000 ; $487b
	ld c, $04 ; $487e
	push hl ; $4880
	push de ; $4881
	call CopyMemoryFast ; $4882
	ld a, $01 ; $4885
	ldh [hSramBank], a ; $4887
	ld [rRAMB], a ; $4889
	ld c, $04 ; $488c
	pop hl ; $488e
	pop de ; $488f
	call CopyMemoryFast ; $4890
	add sp, 64 ; $4893
	ld a, $00 ; $4895
	ldh [hSramBank], a ; $4897
	ld [rRAMB], a ; $4899
	pop hl ; $489c
	pop de ; $489d
	pop bc ; $489e
	pop af ; $489f
	ret ; $48a0
MirrorSaveHeaderToBank1:
	push af ; $48a1
	push bc ; $48a2
	push de ; $48a3
	push hl ; $48a4
	call SumSaveHeaderRegion ; $48a5
	ld a, l ; $48a8
	ld [sSaveMasterChecksum], a ; $48a9
	ld a, h ; $48ac
	ld [sSaveMasterChecksum + 1], a ; $48ad
	ld hl, $a000 ; $48b0
	ld de, wTextBuffer ; $48b3
	ld c, $20 ; $48b6
	call CopyMemoryFast ; $48b8
	ld a, $01 ; $48bb
	ldh [hSramBank], a ; $48bd
	ld [rRAMB], a ; $48bf
	ld hl, wTextBuffer ; $48c2
	ld de, $a000 ; $48c5
	ld c, $20 ; $48c8
	call CopyMemoryFast ; $48ca
	ld a, $00 ; $48cd
	ldh [hSramBank], a ; $48cf
	ld [rRAMB], a ; $48d1
	ld hl, sSaveBlockDirectory + 416 ; $48d4
	ld de, wTextBuffer ; $48d7
	ld c, $20 ; $48da
	call CopyMemoryFast ; $48dc
	ld a, $01 ; $48df
	ldh [hSramBank], a ; $48e1
	ld [rRAMB], a ; $48e3
	ld hl, wTextBuffer ; $48e6
	ld de, sSaveBlockDirectory + 416 ; $48e9
	ld c, $20 ; $48ec
	call CopyMemoryFast ; $48ee
	ld a, $00 ; $48f1
	ldh [hSramBank], a ; $48f3
	ld [rRAMB], a ; $48f5
	ld hl, sSaveBlockDirectory + 928 ; $48f8
	ld de, wTextBuffer ; $48fb
	ld c, $20 ; $48fe
	call CopyMemoryFast ; $4900
	ld a, $01 ; $4903
	ldh [hSramBank], a ; $4905
	ld [rRAMB], a ; $4907
	ld hl, wTextBuffer ; $490a
	ld de, sSaveBlockDirectory + 928 ; $490d
	ld c, $20 ; $4910
	call CopyMemoryFast ; $4912
	ld a, $00 ; $4915
	ldh [hSramBank], a ; $4917
	ld [rRAMB], a ; $4919
	ld hl, sSaveBlockDirectory + 1440 ; $491c
	ld de, wTextBuffer ; $491f
	ld c, $20 ; $4922
	call CopyMemoryFast ; $4924
	ld a, $01 ; $4927
	ldh [hSramBank], a ; $4929
	ld [rRAMB], a ; $492b
	ld hl, wTextBuffer ; $492e
	ld de, sSaveBlockDirectory + 1440 ; $4931
	ld c, $20 ; $4934
	call CopyMemoryFast ; $4936
	ld a, $00 ; $4939
	ldh [hSramBank], a ; $493b
	ld [rRAMB], a ; $493d
	pop hl ; $4940
	pop de ; $4941
	pop bc ; $4942
	pop af ; $4943
	ret ; $4944
VerifySaveHeaderChecksum:
	push hl ; $4945
	push de ; $4946
	call SumSaveHeaderRegion ; $4947
	push hl ; $494a
	ld hl, sSaveMasterChecksum ; $494b
	ld a, [hl+] ; $494e
	ld h, [hl] ; $494f
	ld l, a ; $4950
	pop de ; $4951
	ld a, l ; $4952
	sub e ; $4953
	ld l, a ; $4954
	ld a, h ; $4955
	sbc d ; $4956
	ld h, a ; $4957
	ld a, h ; $4958
	or l ; $4959
	pop de ; $495a
	pop hl ; $495b
	ret ; $495c
ValidateSaveRam:
	push hl ; $495d
	push de ; $495e
	push bc ; $495f
	ld a, $0a ; $4960
	ld [rRAMG], a ; $4962
	ld a, $00 ; $4965
	ldh [hSramBank], a ; $4967
	ld [rRAMB], a ; $4969
	ld hl, sSaveSignature ; $496c
	ld de, SaveSignature ; $496f
	call CompareSaveSignature ; $4972
	jr nz, .setSramBank ; $4975
	call VerifySaveHeaderChecksum ; $4977
	jr nz, .setSramBank ; $497a
	xor a ; $497c
	jp .step2 ; $497d
.setSramBank:
	ld a, $01 ; $4980
	ldh [hSramBank], a ; $4982
	ld [rRAMB], a ; $4984
	ld hl, $a000 ; $4987
	ld de, wTextBuffer ; $498a
	ld c, $20 ; $498d
	call CopyMemoryFast ; $498f
	ld a, $00 ; $4992
	ldh [hSramBank], a ; $4994
	ld [rRAMB], a ; $4996
	ld hl, wTextBuffer ; $4999
	ld de, $a000 ; $499c
	ld c, $20 ; $499f
	call CopyMemoryFast ; $49a1
	ld a, $01 ; $49a4
	ldh [hSramBank], a ; $49a6
	ld [rRAMB], a ; $49a8
	ld hl, sSaveBlockDirectory + 416 ; $49ab
	ld de, wTextBuffer ; $49ae
	ld c, $20 ; $49b1
	call CopyMemoryFast ; $49b3
	ld a, $00 ; $49b6
	ldh [hSramBank], a ; $49b8
	ld [rRAMB], a ; $49ba
	ld hl, wTextBuffer ; $49bd
	ld de, sSaveBlockDirectory + 416 ; $49c0
	ld c, $20 ; $49c3
	call CopyMemoryFast ; $49c5
	ld a, $01 ; $49c8
	ldh [hSramBank], a ; $49ca
	ld [rRAMB], a ; $49cc
	ld hl, sSaveBlockDirectory + 928 ; $49cf
	ld de, wTextBuffer ; $49d2
	ld c, $20 ; $49d5
	call CopyMemoryFast ; $49d7
	ld a, $00 ; $49da
	ldh [hSramBank], a ; $49dc
	ld [rRAMB], a ; $49de
	ld hl, wTextBuffer ; $49e1
	ld de, sSaveBlockDirectory + 928 ; $49e4
	ld c, $20 ; $49e7
	call CopyMemoryFast ; $49e9
	ld a, $01 ; $49ec
	ldh [hSramBank], a ; $49ee
	ld [rRAMB], a ; $49f0
	ld hl, sSaveBlockDirectory + 1440 ; $49f3
	ld de, wTextBuffer ; $49f6
	ld c, $20 ; $49f9
	call CopyMemoryFast ; $49fb
	ld a, $00 ; $49fe
	ldh [hSramBank], a ; $4a00
	ld [rRAMB], a ; $4a02
	ld hl, wTextBuffer ; $4a05
	ld de, sSaveBlockDirectory + 1440 ; $4a08
	ld c, $20 ; $4a0b
	call CopyMemoryFast ; $4a0d
	ld hl, $a000 ; $4a10
	ld de, SaveSignature ; $4a13
	call CompareSaveSignature ; $4a16
	jr nz, .wipeAllSaveRam ; $4a19
	call VerifySaveHeaderChecksum ; $4a1b
	jr nz, .wipeAllSaveRam ; $4a1e
	ld a, $01 ; $4a20
	jr .step2 ; $4a22
.wipeAllSaveRam:
	call WipeAllSaveRam ; $4a24
	call InitSaveHeader ; $4a27
	call MirrorSaveHeaderToBank1 ; $4a2a
	call InitAllMinigameRecordBlocks ; $4a2d
	ld a, $ff ; $4a30
.step2:
	push af ; $4a32
	xor a ; $4a33
	ld [rRAMG], a ; $4a34
	pop af ; $4a37
	pop bc ; $4a38
	pop de ; $4a39
	pop hl ; $4a3a
	ret ; $4a3b
EraseAndInitSaveRam:
	ld a, $0a ; $4a3c
	ld [rRAMG], a ; $4a3e
	ld a, $00 ; $4a41
	ldh [hSramBank], a ; $4a43
	ld [rRAMB], a ; $4a45
	call WipeAllSaveRam ; $4a48
	call InitSaveHeader ; $4a4b
	call MirrorSaveHeaderToBank1 ; $4a4e
	xor a ; $4a51
	ld [rRAMG], a ; $4a52
	ret ; $4a55
CompareSaveSignature:
	push de ; $4a56
	push hl ; $4a57
.loop:
	ld a, [de] ; $4a58
	cp [hl] ; $4a59
	jr nz, .step ; $4a5a
	or a ; $4a5c
	jr z, .restore ; $4a5d
	inc de ; $4a5f
	inc hl ; $4a60
	jr .loop ; $4a61
.step:
	ld a, $01 ; $4a63
.restore:
	pop hl ; $4a65
	pop de ; $4a66
	or a ; $4a67
	ret ; $4a68
CopySaveSignature:
	push af ; $4a69
	push de ; $4a6a
	push hl ; $4a6b
.loop:
	ld a, [hl] ; $4a6c
	ld [de], a ; $4a6d
	or a ; $4a6e
	jr z, .restore ; $4a6f
	inc hl ; $4a71
	inc de ; $4a72
	jr .loop ; $4a73
.restore:
	pop hl ; $4a75
	pop de ; $4a76
	pop af ; $4a77
	ret ; $4a78
GetSaveBlockDirEntry:
	push hl ; $4a79
	ld l, a ; $4a7a
	ld h, $00 ; $4a7b
	add hl, hl ; $4a7d
	add hl, hl ; $4a7e
	add hl, hl ; $4a7f
	add hl, hl ; $4a80
	ld bc, sSaveBlockDirectory ; $4a81
	add hl, bc ; $4a84
	ld b, h ; $4a85
	ld c, l ; $4a86
	pop hl ; $4a87
	ret ; $4a88
WriteSaveBlock:
	push hl ; $4a89
	push de ; $4a8a
	push bc ; $4a8b
	ld a, $0a ; $4a8c
	ld [rRAMG], a ; $4a8e
	ld a, $00 ; $4a91
	ldh [hSramBank], a ; $4a93
	ld [rRAMB], a ; $4a95
	call InitSaveHeader ; $4a98
	push de ; $4a9b
	ld a, b ; $4a9c
	call GetSaveBlockDirEntry ; $4a9d
	push bc ; $4aa0
	push hl ; $4aa1
	ld hl, $0001 ; $4aa2
	add hl, bc ; $4aa5
	ld c, [hl] ; $4aa6
	push bc ; $4aa7
	inc hl ; $4aa8
	ld a, [hl+] ; $4aa9
	ld e, a ; $4aaa
	ld a, [hl+] ; $4aab
	ld d, a ; $4aac
	ld a, [hl+] ; $4aad
	ld b, [hl] ; $4aae
	ld c, a ; $4aaf
	ld hl, $a000 ; $4ab0
	add hl, de ; $4ab3
	ld d, h ; $4ab4
	ld e, l ; $4ab5
	pop hl ; $4ab6
	ld a, l ; $4ab7
	ldh [hSramBank], a ; $4ab8
	ld [rRAMB], a ; $4aba
	pop hl ; $4abd
	push hl ; $4abe
	push bc ; $4abf
.copyLoop:
	ld a, [hl+] ; $4ac0
	ld [de], a ; $4ac1
	inc de ; $4ac2
	dec bc ; $4ac3
	ld a, b ; $4ac4
	or c ; $4ac5
	jr nz, .copyLoop ; $4ac6
	pop bc ; $4ac8
	pop hl ; $4ac9
	ld de, $0000 ; $4aca
.checksumLoop:
	ld a, [hl+] ; $4acd
	add e ; $4ace
	ld e, a ; $4acf
	ld a, d ; $4ad0
	adc $00 ; $4ad1
	ld d, a ; $4ad3
	dec bc ; $4ad4
	ld a, b ; $4ad5
	or c ; $4ad6
	jr nz, .checksumLoop ; $4ad7
	ld a, $00 ; $4ad9
	ldh [hSramBank], a ; $4adb
	ld [rRAMB], a ; $4add
	pop bc ; $4ae0
	ld a, $01 ; $4ae1
	ld [bc], a ; $4ae3
	ld hl, $0006 ; $4ae4
	add hl, bc ; $4ae7
	ld [hl], e ; $4ae8
	inc hl ; $4ae9
	ld [hl], d ; $4aea
	inc hl ; $4aeb
	pop de ; $4aec
	ld a, d ; $4aed
	ld [hl+], a ; $4aee
	ld a, e ; $4aef
	ld [hl+], a ; $4af0
	call MirrorSaveHeaderToBank1 ; $4af1
	xor a ; $4af4
	push af ; $4af5
	xor a ; $4af6
	ld [rRAMG], a ; $4af7
	pop af ; $4afa
	pop bc ; $4afb
	pop de ; $4afc
	pop hl ; $4afd
	ret ; $4afe
