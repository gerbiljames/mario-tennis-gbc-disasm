"""The mods/ overlay: edited data files a fork can commit.

data/ is extracted from the ROM and never committed. A modder's edited
PNG, tilemap grid, text file or sound track lives at the same relative path
under mods/ (mods/sprites/AlexSpriteFrame00.png), which is tracked, and is
copied over data/ before every build and after every extraction. Only the
files under mods/ are the fork's own work, so a fork commits its changes
without committing ROM content.

usage: mods.py apply [ROOT]        copy every mods/ file whose content differs
                                   over data/ (the copy is newer, so make
                                   re-encodes a PNG or grid it covers), and
                                   put back the extracted file under any mod
                                   that is gone (a reverted edit, or a branch
                                   without it); refuses to overwrite a data/
                                   file edited since the last apply or
                                   collect
       mods.py collect <baserom>   compare data/ against a fresh extraction
                                   and copy every file that differs into
                                   mods/ -- how an edit made in data/ is kept
       mods.py list                the overlaid files
"""
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MODS, DATA = ROOT / "mods", ROOT / "data"
MANIFEST = ROOT / "data.manifest"
# The extracted files the overlay has covered, kept so that removing a mod
# restores what extraction gave rather than leaving the edit in data/.
PRISTINE = DATA / ".mods-pristine"
# SHA-1 of what apply or collect last left in data/ for each mod: a data/
# file matching none of that, its mod and its original was edited since.
APPLIED = DATA / ".mods-applied.json"
SIDECARS = (".inc", ".preview.png")   # generated from the file beside them


class EditedSinceApply(Exception):
    def __init__(self, paths):
        self.paths = paths
        super().__init__(
            "mods: edited in data/ since the last apply or collect, which would\n"
            "overwrite them: " + ", ".join(str(p) for p in paths) + "\n"
            "run `python3 tools/mods.py collect baserom.gbc` to keep the edits,\n"
            "or delete the data/ file(s) to discard them")


def _sha1(path):
    return hashlib.sha1(path.read_bytes()).hexdigest()


def load_applied():
    try:
        return json.loads(APPLIED.read_text())
    except (OSError, ValueError):
        return {}


def save_applied(record):
    APPLIED.parent.mkdir(parents=True, exist_ok=True)
    APPLIED.write_text(json.dumps(record, indent=0, sort_keys=True) + "\n")


def _edited(rel, record, *expected):
    """data/rel was changed by hand since apply or collect last wrote it."""
    dest = DATA / rel
    if str(rel) not in record or not dest.exists():
        return False
    h = _sha1(dest)
    return h != record[str(rel)] and all(not e.exists() or _sha1(e) != h for e in expected)


def overlay_files():
    return sorted(p for p in MODS.rglob("*") if p.is_file() and p.name != "README.md")


def apply():
    record = load_applied()
    edited = [src.relative_to(MODS) for src in overlay_files()
              if _edited(src.relative_to(MODS), record, src,
                         PRISTINE / src.relative_to(MODS))]
    if edited:
        raise EditedSinceApply(edited)
    n = 0
    for src in overlay_files():
        rel = src.relative_to(MODS)
        dest, keep = DATA / rel, PRISTINE / rel
        if dest.exists() and dest.read_bytes() == src.read_bytes():
            record[str(rel)] = _sha1(dest)
            continue
        if dest.exists() and not keep.exists():
            keep.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(dest, keep)
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dest)
        record[str(rel)] = _sha1(dest)
        n += 1
    if record or APPLIED.exists():
        save_applied(record)
    return n


def restore():
    n = 0
    if not PRISTINE.exists():
        return 0
    record = load_applied()
    gone = [keep.relative_to(PRISTINE)
            for keep in sorted(p for p in PRISTINE.rglob("*") if p.is_file())
            if not (MODS / keep.relative_to(PRISTINE)).exists()]
    edited = [rel for rel in gone if _edited(rel, record, PRISTINE / rel)]
    if edited:
        raise EditedSinceApply(edited)
    for rel in gone:
        shutil.copyfile(PRISTINE / rel, DATA / rel)
        (PRISTINE / rel).unlink()
        record.pop(str(rel), None)
        n += 1
    if n:
        save_applied(record)
    return n


def derived_bins(manifest):
    """The .bin files make encodes from a PNG or tilemap grid beside them."""
    out = set()
    for line in manifest.read_text().splitlines():
        parts = line.split()
        if (len(parts) > 3 and not parts[0].startswith("#") and parts[0].endswith(".bin")
                and parts[3].partition(":")[0] in ("gfx", "tilemap")):
            out.add(Path(parts[0]))
    return out


def collect(baserom):
    try:
        import PIL  # noqa: F401
    except ImportError:
        sys.exit("mods: collect needs Pillow to compare graphics PNGs "
                 "(run it with .venv/bin/python)")
    derived = derived_bins(MANIFEST)
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run([sys.executable, str(ROOT / "tools" / "extract.py"), baserom,
                        str(MANIFEST), tmp], check=True, capture_output=True)
        fresh = Path(tmp)
        record = load_applied()
        n = 0
        for p in sorted(DATA.rglob("*")):
            if not p.is_file():
                continue
            rel = p.relative_to(DATA)
            if (str(rel).endswith(SIDECARS) or rel in derived
                    or rel.parts[0] == PRISTINE.name or p == APPLIED):
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
            record[str(rel)] = _sha1(p)
            n += 1
    if n:
        save_applied(record)
    return n


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    if cmd == "apply":
        try:
            r = restore()
            n = apply()
        except EditedSinceApply as e:
            print(e, file=sys.stderr)
            return 1
        if r:
            print(f"mods: {r} removed mod(s) restored to the extracted file")
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
