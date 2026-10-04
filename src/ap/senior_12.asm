; a = a Senior Court stage -> the stage SeniorMatchVictorySceneDispatch's
; table covers: the Island Open and complete stages (reached with a class
; pass ahead of the Senior wins) fold onto the champion stage of their arc.
ApFoldSeniorVictoryStage:
	cp SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN
	ret c
	sub 2
	jr ApFoldSeniorVictoryStage
