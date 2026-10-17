DecompressData:
	push af ; $1797
	push bc ; $1798
	push de ; $1799
	push de ; $179a
.nextControlByte:
	ld a, [hl+] ; $179b
	scf ; $179c
	rra ; $179d
	ld c, a ; $179e
	jr nc, .match ; $179f
	ld a, [hl+] ; $17a1
	ld [de], a ; $17a2
	inc de ; $17a3
.nextFlag:
	srl c ; $17a4
	jr z, .nextControlByte ; $17a6
	jr nc, .match ; $17a8
	ld a, [hl+] ; $17aa
	ld [de], a ; $17ab
	inc de ; $17ac
	srl c ; $17ad
	jr z, .nextControlByte ; $17af
	jr nc, .match ; $17b1
	ld a, [hl+] ; $17b3
	ld [de], a ; $17b4
	inc de ; $17b5
	srl c ; $17b6
	jr z, .nextControlByte ; $17b8
	jr nc, .match ; $17ba
	ld a, [hl+] ; $17bc
	ld [de], a ; $17bd
	inc de ; $17be
	srl c ; $17bf
	jr z, .nextControlByte ; $17c1
	jr nc, .match ; $17c3
	ld a, [hl+] ; $17c5
	ld [de], a ; $17c6
	inc de ; $17c7
	srl c ; $17c8
	jr z, .nextControlByte ; $17ca
	jr nc, .match ; $17cc
	ld a, [hl+] ; $17ce
	ld [de], a ; $17cf
	inc de ; $17d0
	srl c ; $17d1
	jr z, .nextControlByte ; $17d3
	jr nc, .match ; $17d5
	ld a, [hl+] ; $17d7
	ld [de], a ; $17d8
	inc de ; $17d9
	srl c ; $17da
	jr z, .nextControlByte ; $17dc
	jr nc, .match ; $17de
	ld a, [hl+] ; $17e0
	ld [de], a ; $17e1
	inc de ; $17e2
	jr .nextControlByte ; $17e3
.done:
	pop hl ; $17e5
	ld h, d ; $17e6
	ld l, e ; $17e7
	pop de ; $17e8
	ld a, l ; $17e9
	sub e ; $17ea
	ld l, a ; $17eb
	ld a, h ; $17ec
	sbc d ; $17ed
	ld h, a ; $17ee
	pop de ; $17ef
	pop bc ; $17f0
	pop af ; $17f1
	ret ; $17f2
.match:
	ld a, [hl+] ; $17f3
	ld b, [hl] ; $17f4
	inc hl ; $17f5
	push hl ; $17f6
	ld l, a ; $17f7
	or b ; $17f8
	jr z, .done ; $17f9
	ld a, b ; $17fb
	rlca ; $17fc
	rlca ; $17fd
	rlca ; $17fe
	or $f8 ; $17ff
	ld h, a ; $1801
	add hl, de ; $1802
	ld a, b ; $1803
	and $1f ; $1804
	jr z, .matchTail ; $1806
	ld b, a ; $1808
	srl b ; $1809
	jr nc, .match2 ; $180b
	ld a, [hl+] ; $180d
	ld [de], a ; $180e
	inc de ; $180f
	jr z, .matchTail ; $1810
.match2:
	srl b ; $1812
	jr nc, .match4 ; $1814
	ld a, [hl+] ; $1816
	ld [de], a ; $1817
	inc de ; $1818
	ld a, [hl+] ; $1819
	ld [de], a ; $181a
	inc de ; $181b
	jr z, .matchTail ; $181c
.match4:
	srl b ; $181e
	jr nc, .match8 ; $1820
	ld a, [hl+] ; $1822
	ld [de], a ; $1823
	inc de ; $1824
	ld a, [hl+] ; $1825
	ld [de], a ; $1826
	inc de ; $1827
	ld a, [hl+] ; $1828
	ld [de], a ; $1829
	inc de ; $182a
	ld a, [hl+] ; $182b
	ld [de], a ; $182c
	inc de ; $182d
	jr z, .matchTail ; $182e
.match8:
	srl b ; $1830
	jr nc, .match16 ; $1832
	ld a, [hl+] ; $1834
	ld [de], a ; $1835
	inc de ; $1836
	ld a, [hl+] ; $1837
	ld [de], a ; $1838
	inc de ; $1839
	ld a, [hl+] ; $183a
	ld [de], a ; $183b
	inc de ; $183c
	ld a, [hl+] ; $183d
	ld [de], a ; $183e
	inc de ; $183f
	ld a, [hl+] ; $1840
	ld [de], a ; $1841
	inc de ; $1842
	ld a, [hl+] ; $1843
	ld [de], a ; $1844
	inc de ; $1845
	ld a, [hl+] ; $1846
	ld [de], a ; $1847
	inc de ; $1848
	ld a, [hl+] ; $1849
	ld [de], a ; $184a
	inc de ; $184b
	jr z, .matchTail ; $184c
.match16:
	ld a, [hl+] ; $184e
	ld [de], a ; $184f
	inc de ; $1850
	ld a, [hl+] ; $1851
	ld [de], a ; $1852
	inc de ; $1853
	ld a, [hl+] ; $1854
	ld [de], a ; $1855
	inc de ; $1856
	ld a, [hl+] ; $1857
	ld [de], a ; $1858
	inc de ; $1859
	ld a, [hl+] ; $185a
	ld [de], a ; $185b
	inc de ; $185c
	ld a, [hl+] ; $185d
	ld [de], a ; $185e
	inc de ; $185f
	ld a, [hl+] ; $1860
	ld [de], a ; $1861
	inc de ; $1862
	ld a, [hl+] ; $1863
	ld [de], a ; $1864
	inc de ; $1865
	ld a, [hl+] ; $1866
	ld [de], a ; $1867
	inc de ; $1868
	ld a, [hl+] ; $1869
	ld [de], a ; $186a
	inc de ; $186b
	ld a, [hl+] ; $186c
	ld [de], a ; $186d
	inc de ; $186e
	ld a, [hl+] ; $186f
	ld [de], a ; $1870
	inc de ; $1871
	ld a, [hl+] ; $1872
	ld [de], a ; $1873
	inc de ; $1874
	ld a, [hl+] ; $1875
	ld [de], a ; $1876
	inc de ; $1877
	ld a, [hl+] ; $1878
	ld [de], a ; $1879
	inc de ; $187a
	ld a, [hl+] ; $187b
	ld [de], a ; $187c
	inc de ; $187d
.matchTail:
	ld a, [hl+] ; $187e
	ld [de], a ; $187f
	inc de ; $1880
	ld a, [hl+] ; $1881
	ld [de], a ; $1882
	inc de ; $1883
	ld a, [hl+] ; $1884
	ld [de], a ; $1885
	inc de ; $1886
	pop hl ; $1887
	jp .nextFlag ; $1888
