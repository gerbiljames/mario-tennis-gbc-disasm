GetSquareOfByte:
	push af ; $106e
	add a ; $106f
	jr c, .highHalf ; $1070
	ld_hl_indexed SquaresTable ; $1072
	ld a, [hl+] ; $1079
	ld h, [hl] ; $107a
	ld l, a ; $107b
	pop af ; $107c
	ret ; $107d
.highHalf:
	ld_hl_indexed SquaresTable + $100 ; $107e
	ld a, [hl+] ; $1085
	ld h, [hl] ; $1086
	ld l, a ; $1087
	pop af ; $1088
	ret ; $1089
AngleFromVector:
	push bc ; $108a
	push de ; $108b
	push hl ; $108c
	ld a, l ; $108d
	cpl ; $108e
	ld c, a ; $108f
	ld a, h ; $1090
	cpl ; $1091
	ld b, a ; $1092
	and c ; $1093
	inc a ; $1094
	jp z, .restore ; $1095
	ld de, $4000 ; $1098
	ld h, e ; $109b
	ld a, d ; $109c
	add b ; $109d
	jr c, .carry ; $109e
	ld b, a ; $10a0
	set 7, h ; $10a1
	ld a, $60 ; $10a3
	jr .step2 ; $10a5
.carry:
	ld a, $e0 ; $10a7
.step2:
	add d ; $10a9
	srl a ; $10aa
	ld d, a ; $10ac
	add b ; $10ad
	jr c, .carry2 ; $10ae
	ld b, a ; $10b0
	set 6, h ; $10b1
	ld a, $18 ; $10b3
	jr .step4 ; $10b5
.carry2:
	ld a, $f8 ; $10b7
.step4:
	add d ; $10b9
	srl a ; $10ba
	ld d, a ; $10bc
	add b ; $10bd
	jr c, .carry3 ; $10be
	ld b, a ; $10c0
	set 5, h ; $10c1
	ld a, $06 ; $10c3
	jr .step6 ; $10c5
.carry3:
	ld a, $fe ; $10c7
.step6:
	add d ; $10c9
	srl a ; $10ca
	ld d, a ; $10cc
	ld a, h ; $10cd
	ld l, e ; $10ce
	ld h, d ; $10cf
	add hl, bc ; $10d0
	jr c, .carry4 ; $10d1
	ld c, l ; $10d3
	ld b, h ; $10d4
	set 4, a ; $10d5
	ld hl, $0180 ; $10d7
	jr .offset ; $10da
.carry4:
	ld hl, $ff80 ; $10dc
.offset:
	add hl, de ; $10df
	srl h ; $10e0
	rr l ; $10e2
	ld e, l ; $10e4
	ld d, h ; $10e5
	add hl, bc ; $10e6
	jr c, .carry5 ; $10e7
	ld c, l ; $10e9
	ld b, h ; $10ea
	set 3, a ; $10eb
	ld hl, $0060 ; $10ed
	jr .offset2 ; $10f0
.carry5:
	ld hl, $ffe0 ; $10f2
.offset2:
	add hl, de ; $10f5
	srl h ; $10f6
	rr l ; $10f8
	ld e, l ; $10fa
	ld d, h ; $10fb
	add hl, bc ; $10fc
	jr c, .carry6 ; $10fd
	ld c, l ; $10ff
	ld b, h ; $1100
	set 2, a ; $1101
	ld hl, $0018 ; $1103
	jr .offset3 ; $1106
.carry6:
	ld hl, $fff8 ; $1108
.offset3:
	add hl, de ; $110b
	srl h ; $110c
	rr l ; $110e
	ld e, l ; $1110
	ld d, h ; $1111
	add hl, bc ; $1112
	jr c, .carry7 ; $1113
	ld c, l ; $1115
	ld b, h ; $1116
	set 1, a ; $1117
	ld hl, $0006 ; $1119
	jr .offset4 ; $111c
.carry7:
	ld hl, hIsCGB ; $111e
.offset4:
	add hl, de ; $1121
	srl h ; $1122
	rr l ; $1124
	ld e, l ; $1126
	ld d, h ; $1127
	add hl, bc ; $1128
	sbc $ff ; $1129
.restore:
	pop hl ; $112b
	pop de ; $112c
	pop bc ; $112d
	ret ; $112e
	db $00 ; $112f
SquaresTable:
	; $1130, 514 bytes (squares)
FOR i, 256
	dw (i * i) & $ffff
ENDR
	dw $ffff
MulSinCosSigned:
	bit 7, h ; $1332
	jr z, MulSinCos ; $1334
	xor a ; $1336
	sub l ; $1337
	ld l, a ; $1338
	sbc a ; $1339
	sub h ; $133a
	ld h, a ; $133b
	ld a, $80 ; $133c
	add b ; $133e
	ld b, a ; $133f
MulSinCos:
	ld a, c ; $1340
	and $f0 ; $1341
	ld c, a ; $1343
	push bc ; $1344
	push hl ; $1345
	call MulSin ; $1346
	ld e, l ; $1349
	ld d, h ; $134a
	pop hl ; $134b
	pop bc ; $134c
	ld a, b ; $134d
	add $40 ; $134e
	ld b, a ; $1350
MulSin:
	bit 7, b ; $1351
	jr z, MulSinUnsigned ; $1353
	res 7, b ; $1355
	call MulSinUnsigned ; $1357
	xor a ; $135a
	sub l ; $135b
	ld l, a ; $135c
	sbc a ; $135d
	sub h ; $135e
	ld h, a ; $135f
	ret ; $1360
MulSinUnsigned:
	push de ; $1361
	add hl, hl ; $1362
	ld e, l ; $1363
	ld d, h ; $1364
	ld h, b ; $1365
	ld a, c ; $1366
	srl h ; $1367
	rra ; $1369
	srl h ; $136a
	rra ; $136c
	srl h ; $136d
	rra ; $136f
	res 0, a ; $1370
	ld l, a ; $1372
	ld a, h ; $1373
	add HIGH(SineTable) ; $1374
	ld h, a ; $1376
	ldh a, [hRomBank] ; $1377
	ld b, a ; $1379
	ld a, BANK(SineTable) ; $137a
	ldh [hRomBank], a ; $137c
	ld [rROMB0], a ; $137e
	ld a, [hl+] ; $1381
	ld h, [hl] ; $1382
	ld l, a ; $1383
	call MulHLByDE32 ; $1384
	ld a, b ; $1387
	ldh [hRomBank], a ; $1388
	ld [rROMB0], a ; $138a
	pop de ; $138d
	ret ; $138e
VectorLengthFromAngle:
	ld a, b ; $138f
	and $7f ; $1390
	sub $20 ; $1392
	cp $40 ; $1394
	jr c, .viaSin ; $1396
	bit 7, h ; $1398
	jr z, .absX ; $139a
	xor a ; $139c
	sub l ; $139d
	ld l, a ; $139e
	sbc a ; $139f
	sub h ; $13a0
	ld h, a ; $13a1
.absX:
	call DivByCos ; $13a2
	bit 7, h ; $13a5
	jr z, .doneX ; $13a7
	xor a ; $13a9
	sub l ; $13aa
	ld l, a ; $13ab
	sbc a ; $13ac
	sub h ; $13ad
	ld h, a ; $13ae
.doneX:
	ret ; $13af
.viaSin:
	ld l, e ; $13b0
	ld h, d ; $13b1
	bit 7, h ; $13b2
	jr z, .absY ; $13b4
	xor a ; $13b6
	sub l ; $13b7
	ld l, a ; $13b8
	sbc a ; $13b9
	sub h ; $13ba
	ld h, a ; $13bb
.absY:
	call DivBySin ; $13bc
	bit 7, h ; $13bf
	jr z, .doneY ; $13c1
	xor a ; $13c3
	sub l ; $13c4
	ld l, a ; $13c5
	sbc a ; $13c6
	sub h ; $13c7
	ld h, a ; $13c8
.doneY:
	ret ; $13c9
DivByCos:
	ld a, b ; $13ca
	add $40 ; $13cb
	ld b, a ; $13cd
DivBySin:
	bit 7, b ; $13ce
	jr z, DivBySinUnsigned ; $13d0
	res 7, b ; $13d2
	call DivBySinUnsigned ; $13d4
	xor a ; $13d7
	sub l ; $13d8
	ld l, a ; $13d9
	sbc a ; $13da
	sub h ; $13db
	ld h, a ; $13dc
	ret ; $13dd
DivBySinUnsigned:
	push de ; $13de
	ld e, l ; $13df
	ld d, h ; $13e0
	ld h, b ; $13e1
	ld a, c ; $13e2
	srl h ; $13e3
	rra ; $13e5
	srl h ; $13e6
	rra ; $13e8
	srl h ; $13e9
	rra ; $13eb
	res 0, a ; $13ec
	ld l, a ; $13ee
	ld a, h ; $13ef
	add HIGH(CosecantTable) ; $13f0
	ld h, a ; $13f2
	ldh a, [hRomBank] ; $13f3
	ld b, a ; $13f5
	ld a, BANK(CosecantTable) ; $13f6
	ldh [hRomBank], a ; $13f8
	ld [rROMB0], a ; $13fa
	ld a, [hl+] ; $13fd
	ld h, [hl] ; $13fe
	ld l, a ; $13ff
	call MulHLByDE32 ; $1400
	ld a, d ; $1403
	add a ; $1404
	rl l ; $1405
	rl h ; $1407
	add a ; $1409
	rl l ; $140a
	rl h ; $140c
	ld a, b ; $140e
	ldh [hRomBank], a ; $140f
	ld [rROMB0], a ; $1411
	pop de ; $1414
	ret ; $1415
AngleFromVector16:
	ld bc, $0000 ; $1416
	ld a, h ; $1419
	or l ; $141a
	jp z, .applySignY ; $141b
	ld b, $40 ; $141e
	ld a, d ; $1420
	or e ; $1421
	jp z, .applySignY ; $1422
	push hl ; $1425
	push de ; $1426
	bit 7, d ; $1427
	jr z, .absY ; $1429
	xor a ; $142b
	sub e ; $142c
	ld e, a ; $142d
	sbc a ; $142e
	sub d ; $142f
	ld d, a ; $1430
.absY:
	bit 7, h ; $1431
	jr z, .absX ; $1433
	xor a ; $1435
	sub l ; $1436
	ld l, a ; $1437
	sbc a ; $1438
	sub h ; $1439
	ld h, a ; $143a
.absX:
	ld a, h ; $143b
	ld h, l ; $143c
	ld l, $00 ; $143d
	call DivAHLByDE ; $143f
	ld bc, $3fc0 ; $1442
	or a ; $1445
	jp nz, .restore ; $1446
	ld e, l ; $1449
	ld d, h ; $144a
	ld hl, TangentTable + 127 * 2 ; $144b
	ld b, $00 ; $144e
	ld a, [hl+] ; $1450
	ld c, a ; $1451
	ld a, [hl-] ; $1452
	cp d ; $1453
	jr c, .add7 ; $1454
	jr nz, .sub7 ; $1456
	ld a, c ; $1458
	cp e ; $1459
	jr c, .add7 ; $145a
.sub7:
	ld a, l ; $145c
	sub $80 ; $145d
	ld l, a ; $145f
	jr nc, .sub7Done ; $1460
	dec h ; $1462
.sub7Done:
	jr .step6 ; $1463
.add7:
	ld a, $80 ; $1465
	add l ; $1467
	ld l, a ; $1468
	jr nc, .setBit7 ; $1469
	inc h ; $146b
.setBit7:
	set 7, b ; $146c
.step6:
	ld a, [hl+] ; $146e
	ld c, a ; $146f
	ld a, [hl-] ; $1470
	cp d ; $1471
	jr c, .add6 ; $1472
	jr nz, .sub6 ; $1474
	ld a, c ; $1476
	cp e ; $1477
	jr c, .add6 ; $1478
.sub6:
	ld a, l ; $147a
	sub $40 ; $147b
	ld l, a ; $147d
	jr nc, .sub6Done ; $147e
	dec h ; $1480
.sub6Done:
	jr .step5 ; $1481
.add6:
	ld a, $40 ; $1483
	add l ; $1485
	ld l, a ; $1486
	jr nc, .setBit6 ; $1487
	inc h ; $1489
.setBit6:
	set 6, b ; $148a
.step5:
	ld a, [hl+] ; $148c
	ld c, a ; $148d
	ld a, [hl-] ; $148e
	cp d ; $148f
	jr c, .add5 ; $1490
	jr nz, .sub5 ; $1492
	ld a, c ; $1494
	cp e ; $1495
	jr c, .add5 ; $1496
.sub5:
	ld a, l ; $1498
	sub $20 ; $1499
	ld l, a ; $149b
	jr nc, .sub5Done ; $149c
	dec h ; $149e
.sub5Done:
	jr .step4 ; $149f
.add5:
	ld a, $20 ; $14a1
	add l ; $14a3
	ld l, a ; $14a4
	jr nc, .setBit5 ; $14a5
	inc h ; $14a7
.setBit5:
	set 5, b ; $14a8
.step4:
	ld a, [hl+] ; $14aa
	ld c, a ; $14ab
	ld a, [hl-] ; $14ac
	cp d ; $14ad
	jr c, .add4 ; $14ae
	jr nz, .sub4 ; $14b0
	ld a, c ; $14b2
	cp e ; $14b3
	jr c, .add4 ; $14b4
.sub4:
	ld a, l ; $14b6
	sub $10 ; $14b7
	ld l, a ; $14b9
	jr nc, .sub4Done ; $14ba
	dec h ; $14bc
.sub4Done:
	jr .step3 ; $14bd
.add4:
	ld a, $10 ; $14bf
	add l ; $14c1
	ld l, a ; $14c2
	jr nc, .setBit4 ; $14c3
	inc h ; $14c5
.setBit4:
	set 4, b ; $14c6
.step3:
	ld a, [hl+] ; $14c8
	ld c, a ; $14c9
	ld a, [hl-] ; $14ca
	cp d ; $14cb
	jr c, .add3 ; $14cc
	jr nz, .sub3 ; $14ce
	ld a, c ; $14d0
	cp e ; $14d1
	jr c, .add3 ; $14d2
.sub3:
	ld a, l ; $14d4
	sub $08 ; $14d5
	ld l, a ; $14d7
	jr nc, .sub3Done ; $14d8
	dec h ; $14da
.sub3Done:
	jr .step2 ; $14db
.add3:
	ld a, $08 ; $14dd
	add l ; $14df
	ld l, a ; $14e0
	jr nc, .setBit3 ; $14e1
	inc h ; $14e3
.setBit3:
	set 3, b ; $14e4
.step2:
	ld a, [hl+] ; $14e6
	ld c, a ; $14e7
	ld a, [hl-] ; $14e8
	cp d ; $14e9
	jr c, .add2 ; $14ea
	jr nz, .sub2 ; $14ec
	ld a, c ; $14ee
	cp e ; $14ef
	jr c, .add2 ; $14f0
.sub2:
	ld a, l ; $14f2
	sub $04 ; $14f3
	ld l, a ; $14f5
	jr nc, .sub2Done ; $14f6
	dec h ; $14f8
.sub2Done:
	jr .step1 ; $14f9
.add2:
	ld a, $04 ; $14fb
	add l ; $14fd
	ld l, a ; $14fe
	jr nc, .setBit2 ; $14ff
	inc h ; $1501
.setBit2:
	set 2, b ; $1502
.step1:
	ld a, [hl+] ; $1504
	ld c, a ; $1505
	ld a, [hl-] ; $1506
	cp d ; $1507
	jr c, .add1 ; $1508
	jr nz, .sub1 ; $150a
	ld a, c ; $150c
	cp e ; $150d
	jr c, .add1 ; $150e
.sub1:
	ld a, l ; $1510
	sub $02 ; $1511
	ld l, a ; $1513
	jr nc, .sub1Done ; $1514
	dec h ; $1516
.sub1Done:
	jr .lastStep ; $1517
.add1:
	ld a, $02 ; $1519
	add l ; $151b
	ld l, a ; $151c
	jr nc, .setBit1 ; $151d
	inc h ; $151f
.setBit1:
	set 1, b ; $1520
.lastStep:
	ld a, [hl+] ; $1522
	ld c, a ; $1523
	ld a, [hl+] ; $1524
	cp d ; $1525
	jr c, .roundUp ; $1526
	jr nz, .checkOverflow ; $1528
	ld a, c ; $152a
	cp e ; $152b
	jr nc, .checkOverflow ; $152c
.roundUp:
	inc b ; $152e
.checkOverflow:
	ld a, b ; $152f
	inc a ; $1530
	jr nz, .packAngle ; $1531
	ld a, [hl+] ; $1533
	ld c, a ; $1534
	ld a, [hl+] ; $1535
	cp d ; $1536
	jr c, .quarterTurn ; $1537
	jr nz, .packAngle ; $1539
	ld a, c ; $153b
	cp e ; $153c
	jr nc, .packAngle ; $153d
.quarterTurn:
	ld bc, $4000 ; $153f
	jr .restore ; $1542
.packAngle:
	ld a, b ; $1544
	rrca ; $1545
	rrca ; $1546
	ld b, a ; $1547
	and $c0 ; $1548
	ld c, a ; $154a
	xor b ; $154b
	ld b, a ; $154c
.restore:
	pop de ; $154d
	pop hl ; $154e
.applySignY:
	bit 7, d ; $154f
	jr z, .signYDone ; $1551
	xor a ; $1553
	sub c ; $1554
	ld c, a ; $1555
	ld a, $80 ; $1556
	sbc b ; $1558
	ld b, a ; $1559
.signYDone:
	bit 7, h ; $155a
	jr z, .done ; $155c
	xor a ; $155e
	sub c ; $155f
	ld c, a ; $1560
	sbc a ; $1561
	sub b ; $1562
	ld b, a ; $1563
.done:
	ret ; $1564
