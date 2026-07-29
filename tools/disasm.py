#!/usr/bin/env python3
"""Generate per-bank RGBDS source from the base ROM plus execution coverage.

Coverage files are raw dumps from the BizHawk tracer (get_coverage
summarize=false): exact addresses of executed instruction starts. Those are
used as verified seeds; an optional conservative recursive descent extends
them through direct jump/call targets within the same bank (or bank 0).

Everything not proven to be code is emitted as an INCBIN of a blob listed in
data.manifest, which setup.sh extracts from the user's ROM at setup time, so
no ROM bytes land in the repository.

This file is the command line; the work lives in tools/disasmlib/ (see its
package docstring for the module map).
"""
import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from disasmlib import pipeline
from disasmlib.config import (load_const_defs, load_flag_names, load_hwregs,
                              load_label_notes, load_label_overrides,
                              load_offset_map)
from disasmlib.emit import emit
from disasmlib.textids import text_id_load_sites
from disasmlib.ram import (audit_rom_only_scopes, compute_wram_bank,
                           load_ram_map, load_ram_unions,
                           write_mirrored_include,
                           load_traced_wram_banks,
                           merge_traced_wram_banks)


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("rom")
    ap.add_argument("coverage", nargs="+")
    ap.add_argument("--srcdir", default="src")
    ap.add_argument("--manifest", default="data.manifest")
    ap.add_argument("--labels", default="labels.json")
    ap.add_argument("--data-tables", default="data_tables.json")
    ap.add_argument("--constants", default="constants.json")
    ap.add_argument("--flags", default="flags.json")
    ap.add_argument("--hardware-inc", default="include/hardware.inc")
    ap.add_argument("--constants-inc", default="include/constants.inc")
    ap.add_argument("--ram-map", default="ram_map.json")
    ap.add_argument("--ram-unions", default="ram_unions.json")
    ap.add_argument("--hooks", nargs="*", default=[],
                    help="hook_client.py dump(s) of data-helper call captures")
    ap.add_argument("--no-descent", action="store_true")
    return ap.parse_args(argv)


def main(argv=None):
    args = parse_args(argv)
    rom = Path(args.rom).read_bytes()
    overrides = load_label_overrides(args.labels)
    data_tables = load_offset_map(args.data_tables)

    dis = pipeline.analyse(rom, args.coverage, overrides, data_tables,
                           args.hooks, descent=not args.no_descent)
    labels, ptr_sites, ptr_data_targets = pipeline.resolve_labels(
        dis, overrides, data_tables)

    flag_names, flag_raw_sites = load_flag_names(args.flags)
    unions_by_region, ramscoped = load_ram_unions(args.ram_unions)
    ramscoped.bank_at = merge_traced_wram_banks(
        compute_wram_bank(dis), load_traced_wram_banks(args.coverage))
    ramnames = load_ram_map(args.ram_map, unions_by_region, ramscoped, dis)
    audit_rom_only_scopes(dis, ramscoped)
    write_mirrored_include("include/ram_mirrored.inc", ramscoped.mirrored)

    # `ld hl, id` sites that reach a text-id consumer render as the
    # Text_<bank>_<index> constant; a curated constants.json entry still wins.
    constants = text_id_load_sites(dis, overrides)
    auto_text_ids = len(constants)
    constants.update(load_offset_map(args.constants))
    print(f"text ids: {auto_text_ids} pointer loads named from their consumer")

    Path(args.srcdir).mkdir(parents=True, exist_ok=True)
    emit(dis, labels, load_hwregs(args.hardware_inc), ramnames, args.srcdir,
         args.manifest, data_tables, set(overrides.values()), ramscoped,
         constants, load_const_defs(args.constants_inc),
         ptr_sites, ptr_data_targets, flag_names, flag_raw_sites,
         load_label_notes(args.labels))


if __name__ == "__main__":
    main()
