"""The mods/ overlay: edited data files a fork can commit.

data/ is extracted from the ROM and never committed. A modder's edited
PNG, tilemap grid, text file or sound track lives at the same relative path
under mods/ (mods/bank_040/AlexSpriteFrame00.png), which is tracked, and is
copied over data/ before every build and after every extraction. Only the
files under mods/ are the fork's own work, so a fork commits its changes
without committing ROM content.

usage: mods.py apply [ROOT]        copy every mods/ file whose content differs
                                   over data/ (the copy is newer, so make
                                   re-encodes a PNG or grid it covers), and
                                   put back the extracted file under any mod
                                   that is gone (a reverted edit, or a branch
                                   without it)
       mods.py collect <baserom>   compare data/ against a fresh extraction
                                   and copy every file that differs into
                                   mods/ -- how an edit made in data/ is kept
       mods.py list                the overlaid files
"""
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MODS, DATA = ROOT / "mods", ROOT / "data"
# The extracted files the overlay has covered, kept so that removing a mod
# restores what extraction gave rather than leaving the edit in data/.
PRISTINE = DATA / ".mods-pristine"
SIDECARS = (".bin", ".inc", ".preview.png")   # generated from the file beside them


def overlay_files():
    return sorted(p for p in MODS.rglob("*") if p.is_file() and p.name != "README.md")


def apply():
    n = 0
    for src in overlay_files():
        rel = src.relative_to(MODS)
        dest, keep = DATA / rel, PRISTINE / rel
        if dest.exists() and dest.read_bytes() == src.read_bytes():
            continue
        if dest.exists() and not keep.exists():
            keep.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(dest, keep)
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dest)
        n += 1
    return n


def restore():
    n = 0
    if not PRISTINE.exists():
        return 0
    for keep in sorted(p for p in PRISTINE.rglob("*") if p.is_file()):
        rel = keep.relative_to(PRISTINE)
        if (MODS / rel).exists():
            continue
        shutil.copyfile(keep, DATA / rel)
        keep.unlink()
        n += 1
    return n


def collect(baserom):
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run([sys.executable, str(ROOT / "tools" / "extract.py"), baserom,
                        str(ROOT / "data.manifest"), tmp], check=True, capture_output=True)
        fresh = Path(tmp)
        n = 0
        for p in sorted(DATA.rglob("*")):
            if not p.is_file():
                continue
            rel = p.relative_to(DATA)
            if str(rel).endswith(SIDECARS) or rel.parts[0] in ("gfx", PRISTINE.name):
                continue
            ref = fresh / rel
            if ref.exists() and ref.read_bytes() == p.read_bytes():
                continue
            if not ref.exists() and not (MODS / rel).exists():
                continue          # a stray file, not an edit of something extracted
            dest = MODS / rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(p, dest)
            keep = PRISTINE / rel
            if ref.exists() and not keep.exists():
                keep.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(ref, keep)
            n += 1
    return n


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    if cmd == "apply":
        r = restore()
        if r:
            print(f"mods: {r} removed mod(s) restored to the extracted file")
        n = apply()
        if n:
            print(f"mods: {n} file(s) overlaid onto data/")
    elif cmd == "collect":
        n = collect(sys.argv[2])
        print(f"mods: {n} edited file(s) collected into mods/")
    elif cmd == "list":
        for p in overlay_files():
            print(p.relative_to(MODS))
    else:
        print(__doc__)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
