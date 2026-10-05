#!/bin/sh
# Verifies the user-supplied base ROM and extracts all game data from it.
# The repository contains no ROM data; everything binary lives in data/,
# which this script populates from baserom.gbc.
set -eu

BASEROM=${1:-baserom.gbc}
# Mario Tennis (USA), or (Europe): the same game with region code P in its header
USA_SHA1="414ba58340a27fc27b127bc01455b32764151ff0"
EUROPE_SHA1="550dcc99d0a56bbb13ae3abb2a4193b830e54970"

if [ ! -f "$BASEROM" ]; then
    echo "error: $BASEROM not found." >&2
    echo "Place your legally obtained Mario Tennis (USA or Europe) ROM at ./baserom.gbc" >&2
    echo "or pass its path: ./setup.sh /path/to/rom.gbc" >&2
    exit 1
fi

ACTUAL_SHA1=$(sha1sum "$BASEROM" | cut -d' ' -f1)
case "$ACTUAL_SHA1" in
"$USA_SHA1") ;;
"$EUROPE_SHA1") echo "Mario Tennis (Europe): build it with make EUROPE=1" ;;
*)
    echo "error: SHA-1 mismatch for $BASEROM" >&2
    echo "  expected: $USA_SHA1 (USA)" >&2
    echo "        or: $EUROPE_SHA1 (Europe)" >&2
    echo "  actual:   $ACTUAL_SHA1" >&2
    exit 1
    ;;
esac

if [ "$BASEROM" != "baserom.gbc" ]; then
    cp "$BASEROM" baserom.gbc
fi

python3 tools/extract.py baserom.gbc data.manifest data/
echo "setup complete: data extracted to data/"
