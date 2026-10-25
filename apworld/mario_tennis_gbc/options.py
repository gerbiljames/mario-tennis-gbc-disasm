from dataclasses import dataclass

from Options import Choice, DefaultOnToggle, OptionGroup, PerGameCommonOptions, Toggle


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


class StoryMatchSets(Choice):
    """Sets in every story match (best of). Vanilla keeps each match's own length."""
    display_name = "Story Match Sets"
    option_vanilla = 0
    option_one = 1
    option_three = 3
    option_five = 5
    default = option_vanilla


class StoryMatchGames(Choice):
    """Games per set in every story match. Vanilla keeps each match's own length."""
    display_name = "Story Match Games"
    option_vanilla = 0
    option_two = 2
    option_six = 6
    default = option_vanilla


class CourtShuffle(Choice):
    """
    The courts story matches are played on.
    Shuffled: the story's six courts (Hard, Clay, Composition, Grass, Center Court, Castle) are shuffled among
    themselves, so a class still plays all its matches on one court (which may be its own).
    Randomized: every match picks its own court from the nine exhibition courts and Center Court.
    """
    display_name = "Court Shuffle"
    option_vanilla = 0
    option_shuffled = 1
    option_randomized = 2
    default = option_vanilla


class SkipIntro(Toggle):
    """A new story game skips the opening tour and starts in the Dorm Room."""
    display_name = "Skip Intro"


class SkipCeremony(Toggle):
    """Winning an Island Open final goes straight from the bracket to the congratulations artwork and credits,
    skipping the fireworks and the Awards Ceremony."""
    display_name = "Skip Awards Ceremony"


class DefaultTextSpeed(Choice):
    """The message speed a new story file starts with. It can still be changed in the game's Options."""
    display_name = "Default Text Speed"
    option_normal = 0
    option_fast = 1
    option_slow = 2
    default = option_normal


class DefaultCameraMode(Choice):
    """
    The match camera a new story file starts with: normal, or player (the court turned so you are always on the near
    side). It can still be changed from the match pause menu.
    """
    display_name = "Default Camera Mode"
    option_normal = 0
    option_player = 1
    default = option_normal


class ItemMessages(DefaultOnToggle):
    """
    Shows a message in the overworld for each item you find, send or receive. Turned off, items still arrive as
    normal, just silently.
    """
    display_name = "Item Messages"


class NerfSwingContest(Toggle):
    """Lowers the swing contest's thresholds from 100 and 150 swings to 60 and 90."""
    display_name = "Nerf Swing Contest"


class ExperienceModifier(Choice):
    """
    Multiplies every EXP award: story, exhibition and linked matches, drills, and EXP Bundles. A single award is
    capped at 65535 and never drops to 0.
    """
    display_name = "Experience Modifier"
    option_half = 1
    option_normal = 2
    option_double = 4
    option_triple = 6
    option_quadruple = 8
    option_quintuple = 10
    default = option_normal


class NerfTwoOnOne(Toggle):
    """Bowser's mini-game, Two-on-One, plays 2 games per set instead of 6."""
    display_name = "Nerf Two-on-One"


class DreamMatchDifficulty(Choice):
    """How hard Mario plays in Peach's first Dream Match offer (Intense in the original game). After a win she lets
    you pick any of the three, as usual."""
    display_name = "Dream Match Difficulty"
    option_hard = 1
    option_intense = 2
    option_max = 3
    default = option_intense


class ShotItems(Toggle):
    """
    Your shots are items: topspin, slice and the flat shot (the second copy of each adds its power shot, or the
    smash), the lob and drop shot, and the topspin, slice and flat serves (the second copy adds the nice serve).
    You start with one random stroke and one random serve; a locked shot plays the first stroke or serve you own.
    """
    display_name = "Shot Items"


class RemoteItems(Toggle):
    """
    Every item, this world's own and the starting inventory included, comes from the server. Needed for co-op or
    playing one slot on two carts; nothing is granted while disconnected.
    """
    display_name = "Remote Items"


class DeathLinkSend(Choice):
    """
    DeathLink: send a death when you lose a point, a game or a match (the smallest loss that counts; a lost match
    point is still one death). A failed mini-game or drill counts as a lost match, and a failed drill point as a
    lost point; Two-on-One is a match. Change it while playing with the client's /deathlink_send command.
    """
    display_name = "DeathLink Send"
    option_off = 0
    option_point = 1
    option_game = 2
    option_match = 3
    default = option_off


class DeathLinkReceive(Choice):
    """
    DeathLink: what a death from another player costs you in a match: the current point, game or match (a game in
    a tiebreak takes the set with it). Any death ends a mini-game or drill as failed (a high-score run already past
    its record ends as a high score); Two-on-One is a match. Outside a match, mini-game or drill, deaths are
    ignored. Change it while playing with the client's /deathlink_receive command.
    """
    display_name = "DeathLink Receive"
    option_off = 0
    option_point = 1
    option_game = 2
    option_match = 3
    default = option_off


@dataclass
class MarioTennisGBCOptions(PerGameCommonOptions):
    story_arcs: StoryArcs
    goal: Goal
    minigames: Minigames
    story_match_sets: StoryMatchSets
    story_match_games: StoryMatchGames
    court_shuffle: CourtShuffle
    skip_intro: SkipIntro
    skip_ceremony: SkipCeremony
    default_text_speed: DefaultTextSpeed
    default_camera_mode: DefaultCameraMode
    item_messages: ItemMessages
    nerf_swing_contest: NerfSwingContest
    nerf_two_on_one: NerfTwoOnOne
    experience_modifier: ExperienceModifier
    dream_match_difficulty: DreamMatchDifficulty
    shot_items: ShotItems
    remote_items: RemoteItems
    death_link_send: DeathLinkSend
    death_link_receive: DeathLinkReceive


option_groups = [
    OptionGroup("Logic", [StoryArcs, Goal, Minigames, ShotItems]),
    OptionGroup("Gameplay", [StoryMatchSets, StoryMatchGames, CourtShuffle, NerfSwingContest, NerfTwoOnOne, ExperienceModifier,
                             DreamMatchDifficulty]),
    OptionGroup("Quality of Life", [SkipIntro, SkipCeremony, DefaultTextSpeed, DefaultCameraMode, ItemMessages]),
    OptionGroup("Multiworld", [RemoteItems, DeathLinkSend, DeathLinkReceive]),
]

# options that shape regions, locations or rules: sent in slot data for Universal Tracker
LOGIC_OPTIONS = ("story_arcs", "goal", "minigames", "shot_items")
# the client's starting DeathLink levels (it can change them while playing)
CLIENT_OPTIONS = ("death_link_send", "death_link_receive")
