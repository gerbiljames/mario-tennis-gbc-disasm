import itertools

from ..items import SERVES, SHOT_COPIES, STROKES, item_counts, starting_shots
from ..locations import active_location_names
from . import MarioTennisGBCTestBase


class TestBalance(MarioTennisGBCTestBase):
    def test_every_option_combination_fits(self) -> None:
        world = self.world
        for arcs, minigames, shots in itertools.product((0, 1, 2), (1, 2, 3), (0, 1)):
            with self.subTest(story_arcs=arcs, minigames=minigames, shot_items=shots):
                world.options.story_arcs.value = arcs
                world.options.minigames.value = minigames
                world.options.shot_items.value = shots
                world.starting_shots = starting_shots(world)
                counts = item_counts(world)
                locations = len(active_location_names(world))
                self.assertLessEqual(sum(counts.values()), locations)


class TestSinglesExcluded(MarioTennisGBCTestBase):
    options = {"story_arcs": "singles", "minigames": "excluded"}

    def test_no_doubles_or_minigames(self) -> None:
        names = {loc.name for loc in self.multiworld.get_locations(self.player)}
        self.assertNotIn("Junior Doubles Rank 1", names)
        self.assertNotIn("Boo Blast Level 1", names)
        self.assertNotIn("Progressive Doubles Pass", {i.name for i in self.multiworld.itempool})


class TestPassGates(MarioTennisGBCTestBase):
    options = {"story_arcs": "singles", "shot_items": False}

    def test_senior_needs_one_pass(self) -> None:
        self.assertFalse(self.can_reach_location("Senior Singles Rank 4"))
        self.collect(self.get_item_by_name("Progressive Singles Pass"))
        self.assertTrue(self.can_reach_location("Senior Singles Rank 4"))
        self.assertFalse(self.can_reach_location("Island Open Singles Final"))

    def test_goal_needs_three_passes(self) -> None:
        self.assertBeatable(False)
        self.collect(self.get_items_by_name("Progressive Singles Pass")[:3])
        self.assertBeatable(True)


class TestCompletionist(MarioTennisGBCTestBase):
    options = {"goal": "completionist", "story_arcs": "doubles", "minigames": "vanilla"}


class TestRemoteItems(MarioTennisGBCTestBase):
    options = {"remote_items": True, "nerf_swing_contest": True, "skip_intro": True}


class TestShotItems(MarioTennisGBCTestBase):
    options = {"story_arcs": "singles", "shot_items": True}

    def test_starts_with_one_stroke_and_one_serve(self) -> None:
        start = [i.name for i in self.multiworld.precollected_items[self.player]]
        self.assertEqual(len([n for n in start if n in STROKES]), 1)
        self.assertEqual(len([n for n in start if n in SERVES]), 1)
        pool = [i.name for i in self.multiworld.itempool]
        self.assertEqual(sum(pool.count(n) for n in SHOT_COPIES), sum(SHOT_COPIES.values()) - 2)

    def test_lob_drills(self) -> None:
        self.collect_by_name("Progressive Stroke Lesson")
        self.assertFalse(self.can_reach_location("Stroke Lesson 2"))
        self.collect_by_name("Lob")
        self.assertTrue(self.can_reach_location("Stroke Lesson 2"))

    def test_a_drill_level_needs_the_one_before(self) -> None:
        self.collect_by_name("Progressive Net Game Match")
        self.assertFalse(self.can_reach_location("Net Game Match 3"), "Match 3 without Match 2's smash and lob")
        self.collect_by_name(["Progressive Flat Shot", "Lob"])
        for item in self.multiworld.precollected_items[self.player]:
            if item.name in ("Progressive Topspin", "Progressive Slice"):
                self.multiworld.state.remove(item)
        self.assertFalse(self.can_reach_location("Net Game Match 3"), "Match 3 without Match 1's volley")
        self.collect_by_name("Progressive Slice")
        self.assertTrue(self.can_reach_location("Net Game Match 3"))

    def test_perfect_shot_needs_the_lob(self) -> None:
        self.collect_by_name("Progressive Perfect Shot")
        self.assertFalse(self.can_reach_location("Perfect Shot Level 1"))
        self.collect_by_name("Lob")
        self.assertTrue(self.can_reach_location("Perfect Shot Level 3"))

    def test_target_shot_needs_the_drop_and_wants_the_lob(self) -> None:
        self.collect_by_name("Progressive Target Shot")
        self.collect_by_name("Lob")
        self.assertFalse(self.can_reach_location("Target Shot Level 2"), "Target Shot 2 without the drop shot")
        self.multiworld.state.remove(self.get_item_by_name("Lob"))
        self.collect_by_name("Drop Shot")
        self.assertFalse(self.can_reach_location("Target Shot Level 2"), "the lob left logic")
        self.collect(self.world.create_item(self.world.glitches_item_name))
        self.assertTrue(self.can_reach_location("Target Shot Level 3"))

    def test_two_on_one_wants_dream_match_shots(self) -> None:
        self.collect_by_name("Progressive Two-on-One")
        self.assertFalse(self.can_reach_location("Two-on-One Level 1"))
        self.collect(self.get_items_by_name(list(SHOT_COPIES)))
        self.assertTrue(self.can_reach_location("Two-on-One Level 3"))

    def test_service_matches_want_a_nice_serve(self) -> None:
        self.assertFalse(self.can_reach_location("Service Match 1"))
        self.collect_by_name(["Progressive Topspin Serve", "Progressive Slice Serve", "Progressive Flat Serve"])
        self.assertTrue(self.can_reach_location("Service Match 1"))

    def test_senior_needs_a_third_shot(self) -> None:
        self.collect_by_name("Progressive Singles Pass")
        self.assertFalse(self.can_reach_location("Senior Singles Rank 4"))
        self.collect_by_name("Drop Shot")
        self.assertTrue(self.can_reach_location("Senior Singles Rank 4"))

    def test_possible_without_shots_glitched_for_universal_tracker(self) -> None:
        self.collect_by_name("Progressive Singles Pass")
        self.assertFalse(self.can_reach_location("Senior Singles Rank 4"))
        self.collect(self.world.create_item(self.world.glitches_item_name))
        self.assertTrue(self.can_reach_location("Senior Singles Rank 4"))
        self.collect_by_name(["Progressive Stroke Lesson", "Progressive Net Game Lesson"])
        self.assertFalse(self.can_reach_location("Stroke Lesson 2"), "a strict shot rule went glitched")
        self.assertFalse(self.can_reach_location("Net Game Lesson 2"), "a strict shot rule went glitched")
        self.collect_by_name("Progressive Stroke Match")
        self.assertFalse(self.can_reach_location("Stroke Match 2"), "a strict shot rule went glitched")
        self.collect_by_name("Progressive Net Game Match")
        self.assertFalse(self.can_reach_location("Net Game Match 2"), "a strict shot rule went glitched")
        self.collect_by_name("Progressive Flat Shot")
        self.assertTrue(self.can_reach_location("Net Game Lesson 3"))
        self.assertTrue(self.can_reach_location("Net Game Match 2"), "the lob stays glitched")


class TestShotItemsOff(MarioTennisGBCTestBase):

    def test_no_shot_items(self) -> None:
        names = {i.name for i in self.multiworld.itempool} | \
            {i.name for i in self.multiworld.precollected_items[self.player]}
        self.assertFalse(names & set(SHOT_COPIES))


class TestDoublesExcluded(MarioTennisGBCTestBase):
    options = {"story_arcs": "doubles", "minigames": "excluded", "shot_items": True}

    def test_tightest_case_fits(self) -> None:
        start = [i.name for i in self.multiworld.precollected_items[self.player]]
        self.assertEqual(len(start), 2)
        self.assertEqual(len(self.multiworld.itempool), len(self.multiworld.get_locations(self.player)))

    def test_practices_need_their_class_pass(self) -> None:
        self.collect(self.get_items_by_name(list(SHOT_COPIES)))
        passes = self.get_items_by_name("Progressive Doubles Pass")
        self.assertTrue(self.can_reach_location("Junior Doubles Practice"))
        self.assertFalse(self.can_reach_location("Senior Doubles Practice"))
        self.collect(passes[0])
        self.assertTrue(self.can_reach_location("Senior Doubles Practice"))
        self.assertFalse(self.can_reach_location("Varsity Doubles Practice"))
        self.collect(passes[1])
        self.assertTrue(self.can_reach_location("Varsity Doubles Practice"))


class TestUniversalTrackerOldSlotData(MarioTennisGBCTestBase):
    options = {"shot_items": True}

    def test_slot_data_without_newer_keys(self) -> None:
        self.multiworld.re_gen_passthrough = {self.game: {"story_arcs": 1, "goal": 0, "minigames": 1}}
        self.world.generate_early()
        self.assertEqual(self.world.options.story_arcs.value, 1)
        self.assertFalse(self.world.options.shot_items)
        self.assertEqual(self.world.starting_shots, [])
