"""Game constant tables shared by the source renderers."""


# Spec kinds whose rendering is a run of independent rows, so a region can be
# cut at any offset and rendered as two pieces without changing a byte. A
# pointer into the middle of one of these anchors a label there; every other
# kind (bytecode, a table whose rows reference their own base, a decoded
# header) has to stay whole, and a pointer into it stays numeric.
#
# `fill` and `pattern` are deliberately absent: they assert that one exact run
# is padding, so a label inside one means the padding stopped there. Carrying
# such a spec past a cut turned 1,472 bytes of bank $28 tile graphics into
# `ds` runs -- wrong, and it would have inlined ROM content into the repo.
SPLITTABLE_SPEC_KINDS = frozenset((
    "bytes", "records", "tilemap", "palettes", "sound_data",
    "text_ids", "flag_ids",
))


def is_splittable(spec):
    return bool(spec) and spec.partition(":")[0] in SPLITTABLE_SPEC_KINDS


MAP_TREE_SLOTS = ("EntryPoints", "ExitTriggers", "Actors", "NpcScripts",
                  "FacingScripts", "TileTriggers", "InitScript")

# Overworld actor facing byte (map_actor `facing`, map_entry `sprite`): the top
# 2 bits are a direction index (CheckTriggerFacingMask $0a:$53bd). Rendered as
# the FACE_* constants from constants.inc.
ACTOR_FACING_NAMES = {0x00: "FACE_RIGHT", 0x40: "FACE_DOWN",
                      0x80: "FACE_LEFT", 0xc0: "FACE_UP"}
# map_script `facing_mask`: a PADF-layout mask the actor's facing must match
# ($ff = any). Rendered as the FACEMASK_* constants from constants.inc.
FACING_MASK_NAMES = {0xff: "FACEMASK_ANY", 0x10: "FACEMASK_RIGHT",
                     0x20: "FACEMASK_LEFT", 0x40: "FACEMASK_UP",
                     0x80: "FACEMASK_DOWN"}

# Story-location names, indexed by location id, from the in-game name popup
# (text id $0179 + loc = string bank $30 index 377 + loc). Annotates the
# StoryLocationTable so each record documents which location it selects.
STORY_LOCATION_NAMES = (
    "Main Menu", "Development", "Small Char. Test", "Test", "Test 2",
    "Academy Main Bldg.", "Academy Wing", "Courtyard", "Restaurant Plaza",
    "Dorm Entrance", "Dorm Room", "Junior Class Court", "Junior Class Court",
    "Restaurant", "Cafeteria", "Training Court", "Senior Class Court",
    "Training Center", "Tennis Machine Room", "Wall Practice Room",
    "Academy Entrance", "Tournament Courtyard", "Court #1", "Court #2",
    "Center Court", "Tournament", "Awards Ceremony", "Island Sky",
    "Special Court", "Peach's Castle", "End1 Main Bldg", "End Restaurant Ent.",
    "End3 Dorm Ent.", "End4 Jr. Court", "End5 Service Ace", "End7 Training Ctr.",
    "End8 Sr. Court", "End10 Varsity Court", "End11 Training Court",
    "End12 Principal's Office", "End16 Before Finals", "End17 Award Ceremony")


# Character roster, in character-id order: the id is the index the mugshot and
# portrait tables take, and the name text id is $001b + id (bank $30 strings
# $1b.., fetched by InitCa00RecordFromCharId $02:$40f6). Ids $15/$16 are the
# roster's "Not used" slots.
CHAR_ROSTER = [
    "Alex", "Nina", "Harry", "Kate", "Allie", "Joy", "Brian", "Pam",
    "Bob", "Beth", "Fay", "Curt", "Mark", "Sean", "Sammi", "Elden",
    "Spike", "Emily", "B. Coz", "A. Coz", "Kevin", "Not used", "Not used",
    "Luigi", "DK", "Baby M.", "Mario", "Waluigi", "Yoshi", "Bowser",
    "Wario", "Peach",
]
