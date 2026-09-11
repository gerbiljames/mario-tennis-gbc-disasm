"""The curated JSON inputs: shape and consistency rules the generator
assumes but would only report obliquely (a name that never appears, a
union that silently grows the RAM section)."""
import json
import re
import unittest

from tests.helpers import ROOT
from disasmlib.ram import ram_field_size

ROM_SIZE = 0x200000
SPEC_KINDS = {
    "actor_list", "actor_script", "ascii", "bytes", "cart_header",
    "char_lz_ptr_table", "drill_definition", "enum", "fill", "flag_ids",
    "font_glyph", "gfx_ptr_table", "location_entries", "lz_ptr_table",
    "map_actors", "map_entries", "map_scripts", "map_tree", "menu_def",
    "minigame_configs", "mode_hooks", "mugshot_ptr_table", "palettes",
    "pattern", "ram_ptrs", "records", "rect_pair", "rect_ptrs", "rules_pages",
    "save_flag_ids", "sound_data", "sound_index", "sprite_anim",
    "sprite_template", "squares", "story_locations", "text_ids",
    "text_offsets", "text_pool", "tilemap", "tilemap_dispatch",
    "tilemap_scripts", "words",
}
AUTO_STEMS = ("Func_", "Label_", "Data_", "Lz_", "Fill_")


def load(name):
    return json.loads((ROOT / name).read_text())


class Labels(unittest.TestCase):
    def setUp(self):
        self.labels = load("labels.json")

    def test_keys_are_rom_offsets(self):
        for k in self.labels:
            self.assertRegex(k, r"^0x[0-9a-f]+$")
            self.assertLess(int(k, 0), ROM_SIZE, k)

    def test_names_unique_and_not_auto(self):
        seen = {}
        for k, v in self.labels.items():
            name = v if isinstance(v, str) else v["name"]
            self.assertRegex(name, r"^\.?[A-Za-z_][A-Za-z0-9_]*$", name)
            self.assertFalse(name.startswith(AUTO_STEMS),
                             f"{k}: {name} states an address, not a meaning")
            if not name.startswith("."):
                self.assertNotIn(name, seen, f"{name} at {k} and {seen.get(name)}")
                seen[name] = k

    def test_notes_are_dicts_with_name(self):
        for k, v in self.labels.items():
            if isinstance(v, dict):
                self.assertIn("name", v, k)
                self.assertTrue(v.get("note", "x").strip(), f"{k}: empty note")


class DataTables(unittest.TestCase):
    def test_specs_known(self):
        for k, spec in load("data_tables.json").items():
            self.assertLess(int(k, 0), ROM_SIZE, k)
            self.assertIn(spec.split(":")[0], SPEC_KINDS, f"{k}: {spec}")


class Flags(unittest.TestCase):
    def test_numbers_and_names(self):
        flags = load("flags.json")
        names = {}
        for k, v in flags.items():
            if k.startswith("_"):
                continue
            n = int(k, 0)
            self.assertTrue(0 <= n < 256, k)
            self.assertRegex(v, r"^FLAG_[A-Z0-9_]+$", v)
            self.assertNotIn(v, names, f"{v} twice")
            names[v] = n


class Constants(unittest.TestCase):
    def test_keys_in_rom(self):
        for k, v in load("constants.json").items():
            self.assertLess(int(k, 0), ROM_SIZE, k)
            self.assertTrue(v.strip(), k)


class RamUnions(unittest.TestCase):
    SIZE_TAG = re.compile(r"^\[(\d+) bytes\]")

    def test_structure(self):
        unions = load("ram_unions.json")["unions"]
        for u in unions:
            self.assertIn("start", u)
            self.assertIn("end", u)
            start, end = int(u["start"], 0), int(u["end"], 0)
            self.assertLess(start, end, u["start"])
            for v in u["variants"]:
                self.assertIn("context", v)
                self.assertIn("symbols", v)
                for s in v.get("scopes", []):
                    if "start" in s or "end" in s:
                        self.assertTrue("start" in s and "end" in s, v["context"])
                        self.assertLess(int(s["start"], 0), int(s["end"], 0), v["context"])
                for addr, sym in v["symbols"].items():
                    a = int(addr, 0)
                    self.assertTrue(start <= a <= end,
                                    f"{sym['name']} at {addr} outside union {u['start']}-{u['end']}")
                    size = ram_field_size(sym)
                    self.assertLessEqual(a + size, end + 1,
                                         f"{sym['name']} ({size} bytes) runs past the union end")
                    m = self.SIZE_TAG.match(sym.get("note", ""))
                    if m and "size" in sym:
                        self.assertEqual(int(m.group(1)), sym["size"],
                                         f"{sym['name']}: note tag says {m.group(1)} bytes, size says {sym['size']}")

    def test_no_overlapping_symbols_within_a_variant(self):
        for u in load("ram_unions.json")["unions"]:
            for v in u["variants"]:
                spans = sorted((int(a, 0), int(a, 0) + s.get("size", 1), s["name"])
                               for a, s in v["symbols"].items())
                for (a1, e1, n1), (a2, e2, n2) in zip(spans, spans[1:]):
                    self.assertLessEqual(e1, a2, f"{n1} overlaps {n2} in {v['context']}")


class Manifest(unittest.TestCase):
    def test_regions_in_rom_and_specs_known(self):
        for line in (ROOT / "data.manifest").read_text().splitlines():
            if not line.strip() or line.startswith("#"):
                continue
            f = line.split()
            off, n = int(f[1], 16), int(f[2], 16)
            self.assertLessEqual(off + n, ROM_SIZE, line)
            if len(f) > 3:
                self.assertIn(f[3].split(":")[0], SPEC_KINDS | {"gfx"}, line)


if __name__ == "__main__":
    unittest.main()
