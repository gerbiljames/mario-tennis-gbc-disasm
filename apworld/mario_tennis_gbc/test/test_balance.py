import itertools

from ..items import item_counts
from ..locations import active_location_names
from . import MarioTennisGBCTestBase


class TestBalance(MarioTennisGBCTestBase):
    def test_every_option_combination_fits(self) -> None:
        world = self.world
        for arcs, minigames in itertools.product((0, 1, 2), (1, 2, 3)):
            with self.subTest(story_arcs=arcs, minigames=minigames):
                world.options.story_arcs.value = arcs
                world.options.minigames.value = minigames
                self.assertGreaterEqual(len(active_location_names(world)), sum(item_counts(world).values()))


class TestSinglesExcluded(MarioTennisGBCTestBase):
    options = {"story_arcs": "singles", "minigames": "excluded"}

    def test_no_doubles_or_minigames(self) -> None:
        names = {loc.name for loc in self.multiworld.get_locations(self.player)}
        self.assertNotIn("Junior Doubles Rank 1", names)
        self.assertNotIn("Boo Blast Level 1", names)
        self.assertNotIn("Progressive Doubles Pass", {i.name for i in self.multiworld.itempool})


class TestPassGates(MarioTennisGBCTestBase):
    options = {"story_arcs": "singles"}

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
