"""Shared fixtures for the test suite."""
import os
import shutil
import subprocess
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOOLS = ROOT / "tools"
for p in (str(TOOLS), str(ROOT)):
    if p not in sys.path:
        sys.path.insert(0, p)

BASEROM = ROOT / "baserom.gbc"
RGBASM = shutil.which("rgbasm") or (str(TOOLS / "rgbds" / "rgbasm")
                                    if (TOOLS / "rgbds" / "rgbasm").exists() else None)

needs_rom = unittest.skipUnless(BASEROM.exists(), "baserom.gbc not present")
needs_rgbasm = unittest.skipUnless(RGBASM, "rgbasm not available")


def assemble(source, tmpdir):
    """Assemble a ROM0 snippet with the project's includes; return its bytes.
    The snippet is placed at $0000 so offsets in the output are addresses."""
    src = Path(tmpdir) / "t.asm"
    obj = Path(tmpdir) / "t.o"
    out = Path(tmpdir) / "t.bin"
    # the ROM0 symbols the macros expand to, as constants: the snippet is
    # linked alone, without bank $00 or ram/
    defs = ("DEF hWramBank EQU $ff96\nDEF WaitFramesCmd EQU $2725\n"
            "DEF Rst20 EQU $0020\n")
    src.write_text(defs + 'SECTION "t", ROM0[$0000]\n' + source + "\n")
    prelude = [str(ROOT / "include" / f) for f in
               ("hardware.inc", "macros.inc", "constants.inc", "text_ids.inc",
                "flag_constants.inc", "text_codes.inc", "ram_mirrored.inc")]
    subprocess.run([RGBASM, "-E", "-I", str(ROOT / "include")]
                   + [a for f in prelude for a in ("-P", f)]
                   + ["-o", str(obj), str(src)], check=True, cwd=ROOT)
    rgblink = Path(RGBASM).with_name("rgblink")
    subprocess.run([str(rgblink), "-o", str(out), str(obj)], check=True)
    return out.read_bytes()
