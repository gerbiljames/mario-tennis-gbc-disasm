"""Make dependencies for the bank objects: each build/bank_XXX.o depends on its
holder, its fragment files, the top-of-file includes, and every data file the
bank INCBINs or INCLUDEs. Written to build/deps.mk by the Makefile."""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_files, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent


def main():
    for h in holders():
        deps = []
        for f in bank_files(h):
            deps.append(f.relative_to(ROOT).as_posix())
            for line in f.read_text().split("\n"):
                m = re.match(r'^INCLUDE "([^"]+)"', line)
                if m and not m.group(1).startswith("src/"):
                    deps.append("include/" + m.group(1))
                m = re.match(r'^\s+(?:INCBIN|INCLUDE) "([^"]+)"', line)
                if m:
                    deps.append(m.group(1))
                m = re.match(r"^\t(?:twin|twin_named) (\w+),", line)
                if m:
                    deps.append(f"src/twins/{m.group(1)}.asm")
        print(f"build/{h.stem}.o: " + " ".join(dict.fromkeys(deps)))


if __name__ == "__main__":
    main()
