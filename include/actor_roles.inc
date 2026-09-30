; Actor slots named for their part in a scene rather than a row of one list
; (the ACTOR_<list>_<object> names map_actor defines): at each use the
; location may have any of the lists given, and the slot means the same thing
; in all of them. `make check` (slots) fails a use where a list the analysis
; finds possible is not one of these.

; The five senior players stand at the same Senior Court slots in the default
; list and in lists A and B, under different actor scripts.
	actor_role SENIOR_COURT_FAY, $04, SeniorCourtActors_12, SeniorCourtActorsA_12, SeniorCourtActorsB_12
	actor_role SENIOR_COURT_JOY, $06, SeniorCourtActors_12, SeniorCourtActorsA_12, SeniorCourtActorsB_12
	actor_role SENIOR_COURT_CURT, $09, SeniorCourtActors_12, SeniorCourtActorsA_12, SeniorCourtActorsB_12
	actor_role SENIOR_COURT_BOB, $0a, SeniorCourtActors_12, SeniorCourtActorsA_12, SeniorCourtActorsB_12
	actor_role SENIOR_COURT_PAM, $0b, SeniorCourtActors_12, SeniorCourtActorsA_12, SeniorCourtActorsB_12

; The Junior Class Court's doubles ranking opponents, in its singles and
; doubles lists alike.
	actor_role JUNIOR_CLASS_COURT_BRIAN, $08, JuniorClassCourtSinglesActors_11, JuniorClassCourtDoublesActors_11
	actor_role JUNIOR_CLASS_COURT_FAY, $09, JuniorClassCourtSinglesActors_11, JuniorClassCourtDoublesActors_11

; Court #2's first walking spectator, in both of its lists.
	actor_role COURT2_SPECTATOR, $06, Court2Actors_14, Court2ActorsAlt_14

; The Island Open round lists: the player's opponent in this round (singles),
; or the first of the opposing pair (doubles), and the second of that pair.
; Who it is changes every round.
	actor_role ISLAND_OPEN_OPPONENT, $0a, TournamentActors_0f, IslandOpenRound2Actors_0f, IslandOpenSemifinalActors_0f, IslandOpenFinalActors_0f, IslandOpenRound1ActorsDoubles_0f, IslandOpenSemifinalActorsDoubles_0f, IslandOpenFinalActorsDoubles_0f
	actor_role ISLAND_OPEN_OPPONENT_PARTNER, $0b, TournamentActors_0f, IslandOpenRound2Actors_0f, IslandOpenSemifinalActors_0f, IslandOpenFinalActors_0f, IslandOpenRound1ActorsDoubles_0f, IslandOpenSemifinalActorsDoubles_0f, IslandOpenFinalActorsDoubles_0f
