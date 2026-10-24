"""Smoke tests for the tools `make check` does not run: each is imported and,
where it can run without PyBoy, run on the real tree, so a layout change that
breaks one fails here rather than the next time someone reaches for it."""
import importlib
import struct
import subprocess
import sys
import tempfile
import unittest

from tests.helpers import ROOT, TOOLS, assemble, needs_rgbasm, needs_rom

SYM = ROOT / "build" / "mariotennis.sym"
needs_build = unittest.skipUnless(SYM.exists(), "build/mariotennis.sym not present: run make first")


def run(*args):
    return subprocess.run([sys.executable, *map(str, args)], cwd=ROOT,
                          capture_output=True, text=True, check=True).stdout


class Imports(unittest.TestCase):
    def test_every_tool_imports(self):
        for path in sorted(TOOLS.glob("*.py")):
            with self.subTest(tool=path.stem):
                importlib.import_module(path.stem)


class Static(unittest.TestCase):
    """Tools that read only the source tree."""

    def test_ram_free(self):
        import ram_free
        self.assertEqual(sum(e - s for _, _, s, e in ram_free.free_ranges()), 4249)

    def test_twins(self):
        import twins
        self.assertGreaterEqual(len(twins.groups()), 40)

    def test_routes(self):
        import routes
        dead, rows, bad = routes.unreached()
        self.assertEqual((len(dead), len(rows), bad), (15, 126, []))
        self.assertEqual(len(routes.entry_ids()), 137)

    def test_coverage_routines(self):
        import coverage
        self.assertGreaterEqual(len(coverage.routines()), 4249)

    def test_eventtest_plan(self):
        import eventtest
        self.assertEqual(len(eventtest.states()), 36)
        self.assertEqual(len(eventtest.handlers()), 251)
        self.assertGreater(len(eventtest.code_labels()), 3000)

    def test_deps_resolve(self):
        line = run(TOOLS / "deps.py", "build")
        target, deps = line.split(":", 1)
        self.assertEqual(target, "build/main.o")
        missing = [d for d in deps.split() if not d.startswith("data/") and not (ROOT / d).exists()]
        self.assertEqual(missing, [])

    def test_consts_every_def_evaluates(self):
        import consts
        strings = {"HARDWARE_INC_VERSION", "tile", "tiles"}  # EQUS, not numbers
        counters = {"AP_NUM_LOCATIONS", "AP_NUM_ITEMS"}  # `=` variables the ap_location/ap_item macros bump
        failed = [f"{f.relative_to(ROOT)}:{n}: {line.strip()}" for f, n, line in consts.unevaluated()
                  if line.split()[1] not in strings | counters]
        self.assertEqual(failed, [])

    @needs_rgbasm
    def test_consts_match_assembler(self):
        import consts
        values = consts.constants()
        self.assertEqual((values["DRILLCTR_TOPSPIN_SERVES_LEFT"], values["PADF_BUTTONS"]), (1, 0x0f))
        names = sorted(values)
        with tempfile.TemporaryDirectory() as d:
            for i in range(0, len(names), 3000):
                chunk = names[i:i + 3000]
                out = assemble("\n".join(f"\tdl {n}" for n in chunk), d)
                for name, got in zip(chunk, struct.unpack(f"<{len(chunk)}i", out[:4 * len(chunk)])):
                    self.assertEqual(values[name] & 0xffffffff, got & 0xffffffff, name)

    def test_savetool(self):
        save = ROOT / "maxed-unlocked.sav"
        if not save.exists():
            self.skipTest("maxed-unlocked.sav not present")
        self.assertIn("slot 0 main", run(TOOLS / "savetool.py", save, "dump", "0"))


@needs_build
class Built(unittest.TestCase):
    """Tools that read the build's .sym and .map."""

    def test_stats(self):
        out = run(TOOLS / "stats.py")
        self.assertIn("labels", out)
        self.assertIn("spelled out", out)

    def test_ram_free_matches_sym(self):
        import banksrc
        import ram_free
        sym = {}
        for bank, addr, name in banksrc.read_sym(SYM):
            sym.setdefault(name, (bank, addr))
        wrong = [(name, f"{bank:02x}:{addr:04x}", sym.get(name))
                 for _, bank, name, addr, _ in ram_free.placed()
                 if name and sym.get(name) != (bank, addr)]
        self.assertEqual(wrong, [])

    def test_eventtest_locations(self):
        import eventtest
        self.assertEqual(len(eventtest.locations()), 42)
        self.assertGreater(len(eventtest.handler_rows()), 200)

    def test_linktest_serial_sites(self):
        import eventtest
        import linktest
        self.assertTrue(all(linktest.serial_sites(eventtest.symbols(SYM))))


@needs_rom
class WithRom(unittest.TestCase):
    def test_strings(self):
        out = run(TOOLS / "strings.py", ROOT / "baserom.gbc", "--index", "--bank", "25")
        self.assertTrue(out.startswith("25:0 "))


if __name__ == "__main__":
    unittest.main()
