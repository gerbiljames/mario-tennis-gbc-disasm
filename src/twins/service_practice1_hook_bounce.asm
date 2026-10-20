; Shared by ServicePractice1Hook_Bounce, ServicePractice3Hook_Bounce (bank $0b).

{TWIN_LABEL}:
	ld a, [wRallyLength]
	cp $01
	ret nz
	call RecordDrillTargetZoneMissIfInPlay
	ret
