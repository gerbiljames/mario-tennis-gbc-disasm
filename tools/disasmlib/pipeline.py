"""Pass ordering.

Every pass only ever adds knowledge to the Disassembly, but the order matters:
a pass that proves data before another guesses at it keeps the guess honest,
and the descent/jump-table passes feed each other until they stop finding
anything. The comments below record why each ordering constraint exists.
"""
from .coverage import load_coverage
from .disassembly import Disassembly
from .labels import build_labels
from .rom import BANK_SIZE
from .seeds import (ACTOR_HANDLER_INSTALL, FRAME_TASK_REGISTER,
                    actor_handler_sites, actor_handler_targets,
                    frame_task_targets, map_script_code_targets,
                    minigame_config_init_targets, mode_hook_code_targets,
                    pointer_load_targets)

DATA_HELPERS = (("CopyDataFromBank", "copy"), ("DecompressDataFromBank", "lz"))


def _curated_offsets(overrides, names):
    """Flat offsets of the curated labels with any of `names`."""
    return {int(k, 0) for k, n in (overrides or {}).items() if n in names}


def analyse(rom, coverage_paths, overrides=None, data_tables=None,
            hook_paths=(), descent=True):
    """ROM + coverage dumps -> a fully analysed Disassembly."""
    dis = Disassembly(rom)
    dis.data_boundaries = set(data_tables or {})
    seeds = load_coverage(coverage_paths, len(rom) // BANK_SIZE)
    print(f"{len(seeds)} coverage seeds")
    dis.seed(seeds)
    if descent:
        prove_code(dis, overrides, data_tables or {})
    prove_data(dis, overrides, hook_paths)
    return dis


def prove_code(dis, overrides, data_tables):
    """Grow the seeds into every function they reach, directly or through the
    dispatch shapes the game uses."""
    dis.descend()
    # Slot-record tables are ground truth that their referenced slots
    # hold data pointers; prove them before table inference so a data
    # target whose bytes happen to decode as instructions (bank $6b's
    # title-screen tilemap) isn't claimed as an unused code entry and
    # seeded as false code.
    dis.add_slot_record_tables(overrides)
    dis.infer_tables()
    dis.seed_text_entries()
    dis.seed_launcher_stubs()
    # Map-script/entry handlers and arrival scripts are reached only through
    # indirect dispatch (CallHLInBankA), so descent never finds them and
    # their code otherwise falls into the map table's own data blob. Seed
    # the pointers the tables embed so the code is decoded and the records
    # reference each handler by name.
    dis.seed(list(map_script_code_targets(dis.rom, data_tables)))
    # Minigame mode-hook handlers are likewise reached only through an
    # indirect dispatch (CallModeHook), so seed each table's 8 slots.
    dis.seed(list(mode_hook_code_targets(dis.rom, data_tables)))
    dis.seed(list(minigame_config_init_targets(dis.rom, data_tables)))
    dis.descend()
    if dis.infer_twin_tables():
        dis.descend()
    # An installed actor handler's body opens with a `rst Rst00` jumptable,
    # so seed the handlers before the fixpoint rather than after it.
    dis.seed(list(actor_handler_targets(
        dis, _curated_offsets(overrides, ACTOR_HANDLER_INSTALL))))
    dis.descend()
    # jump tables and descent feed each other; iterate to a fixed point
    for _ in range(8):
        if not dis.parse_jumptables():
            break
        dis.descend()
    # Frame-task functions installed via `ld hl, fn; call RegisterFrameTask`
    # run only through the task dispatcher; those not hit by coverage stay
    # INCBIN blobs. Seed after the jump-table fixpoint so all registration
    # sites are decoded (some surface late through jump-table descent), then
    # decode the pointed-at functions.
    dis.seed(list(frame_task_targets(
        dis, _curated_offsets(overrides, FRAME_TASK_REGISTER))))
    dis.descend()


def prove_data(dis, overrides, hook_paths=()):
    """Classify everything descent left behind: which table slots point at
    data, and what structure that data has."""
    helpers = {}
    for name, kind in DATA_HELPERS:
        for off in _curated_offsets(overrides, (name,)):
            helpers[off] = kind
    if helpers:
        dis.find_data_slots(helpers)
    if hook_paths:
        dis.load_hook_dumps(hook_paths)
    dis.add_static_data_slots()
    dis.add_static_code_slots()
    dis.carve_gfx_pointer_sets()
    dis.carve_tennis_dictionary_assets()
    dis.carve_char_mugshots()
    dis.carve_tilemap_dispatch()
    queue_sprite = _curated_offsets(overrides, ("QueueSpriteTemplate",))
    if queue_sprite:
        dis.carve_sprite_templates(min(queue_sprite))
    dis.find_sprite_banks()
    dis.find_sound_banks()
    dis.find_walk_sprite_banks()
    dis.add_object_header_slots()
    dis.split_object_bodies()
    dis.follow_oam_arrays()
    dis.follow_frame_arrays()
    if helpers or hook_paths:
        dis.scan_data_slots()


def resolve_labels(dis, overrides=None, data_tables=None):
    """Name every proven offset. Returns (labels, ptr_sites, ptr_data_targets):
    the symbol table, the vetted `ld rr, imm` pointer-load sites, and the raw
    data targets those loads reach (which emit splits blobs at)."""
    ptr_sites = pointer_load_targets(dis, overrides)
    # Handler-install sites store the pointer instead of dereferencing it, so
    # pointer_load_targets' use-gate skips them; resolve them explicitly.
    ptr_sites.update(actor_handler_sites(
        dis, _curated_offsets(overrides, ACTOR_HANDLER_INSTALL)))
    labels, ptr_data_targets = build_labels(dis, overrides, data_tables,
                                            ptr_sites)
    return labels, ptr_sites, ptr_data_targets
