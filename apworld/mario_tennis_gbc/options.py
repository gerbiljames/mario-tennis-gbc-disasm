from dataclasses import dataclass

from Options import Choice, OptionGroup, PerGameCommonOptions, Range, Toggle


class StoryArcs(Choice):
    """
    Which story ladders are played. With one arc, the Singles/Doubles choosers are skipped and only that arc's
    checks exist.
    """
    display_name = "Story Arcs"
    option_both = 0
    option_singles = 1
    option_doubles = 2
    default = option_both


class Goal(Choice):
    """
    island_open: win the Island Open final (of each arc played).
    dream_match: win the Dream Match at Peach's Castle (of each arc played).
    completionist: check every location.
    """
    display_name = "Goal"
    option_island_open = 0
    option_dream_match = 1
    option_completionist = 2
    default = option_island_open


class Minigames(Choice):
    """
    progressive: each of the 9 Mario mini-games is a progressive item; its copies open the grid cell and levels 2 and 3.
    vanilla: each mini-game is one item opening its cell; levels unlock by clearing, as in the game.
    excluded: every cell is open and mini-game clears are not locations.
    """
    display_name = "Mini-Games"
    option_progressive = 1
    option_vanilla = 2
    option_excluded = 3
    default = option_progressive


class StoryMatchSets(Range):
    """Sets in every story match. 0 keeps each match's own length."""
    display_name = "Story Match Sets"
    range_start = 0
    range_end = 3
    default = 0


class StoryMatchGames(Range):
    """Games per set in every story match. 0 keeps each match's own length."""
    display_name = "Story Match Games"
    range_start = 0
    range_end = 6
    default = 0


class SkipIntro(Toggle):
    """A new story game skips the opening tour and starts in the Dorm Room."""
    display_name = "Skip Intro"


class NerfSwingContest(Toggle):
    """Lowers the swing contest's thresholds from 100 and 150 swings to 60 and 90."""
    display_name = "Nerf Swing Contest"


class RemoteItems(Toggle):
    """
    Every item, this world's own and the starting inventory included, comes from the server. Needed for co-op or
    playing one slot on two carts; nothing is granted while disconnected.
    """
    display_name = "Remote Items"


@dataclass
class MarioTennisGBCOptions(PerGameCommonOptions):
    story_arcs: StoryArcs
    goal: Goal
    minigames: Minigames
    story_match_sets: StoryMatchSets
    story_match_games: StoryMatchGames
    skip_intro: SkipIntro
    nerf_swing_contest: NerfSwingContest
    remote_items: RemoteItems


option_groups = [
    OptionGroup("Logic", [StoryArcs, Goal, Minigames]),
    OptionGroup("Gameplay", [StoryMatchSets, StoryMatchGames, SkipIntro, NerfSwingContest, RemoteItems]),
]

# options that shape regions, locations or rules: sent in slot data for Universal Tracker
LOGIC_OPTIONS = ("story_arcs", "goal", "minigames", "nerf_swing_contest")
