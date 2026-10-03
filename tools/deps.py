"""Make dependencies for main.o: main.asm, the fragment files its banks
INCLUDE, the shared templates they pull in, and every data file INCBINed or
INCLUDEd. Written to <build>/deps.mk by the Makefile."""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import MAIN, bank_files, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else "build"
    files = [MAIN, ROOT / "include" / "lz_sizes.inc"] + [f for h in holders() for f in bank_files(h)[1:]]
    deps = []
    for f in dict.fromkeys(files):
        deps.append(f.relative_to(ROOT).as_posix())
        for line in f.read_text().split("\n"):
            m = re.match(r'^\s*(?:INCBIN|INCLUDE) "((?!src/)[^"]+)"', line)
            if m:
                path = m.group(1)
                deps.append(path if (ROOT / path).exists() or path.startswith("data/") else f"include/{path}")
            m = re.match(r"^\t(?:twin|twin_named|twin_in) (\w+),", line)
            if m:
                deps.append(f"src/twins/{m.group(1)}.asm")
    print(f"{out}/main.o: " + " ".join(dict.fromkeys(deps)))


if __name__ == "__main__":
    main()
