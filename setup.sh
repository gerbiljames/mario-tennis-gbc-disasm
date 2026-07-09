#!/bin/sh
# Verifies the user-supplied base ROM and extracts all game data from it.
# The repository contains no ROM data; everything binary lives in data/,
# which this script populates from baserom.gbc.
set -eu

BASEROM=${1:-baserom.gbc}
EXPECTED_SHA1="414ba58340a27fc27b127bc01455b32764151ff0"

if [ ! -f "$BASEROM" ]; then
    echo "error: $BASEROM not found." >&2
    echo "Place your legally obtained Mario Tennis (USA) ROM at ./baserom.gbc" >&2
    echo "or pass its path: ./setup.sh /path/to/rom.gbc" >&2
    exit 1
fi

ACTUAL_SHA1=$(sha1sum "$BASEROM" | cut -d' ' -f1)
if [ "$ACTUAL_SHA1" != "$EXPECTED_SHA1" ]; then
    echo "error: SHA-1 mismatch for $BASEROM" >&2
    echo "  expected: $EXPECTED_SHA1" >&2
    echo "  actual:   $ACTUAL_SHA1" >&2
    echo "This disassembly targets Mario Tennis (USA)." >&2
    exit 1
fi

if [ "$BASEROM" != "baserom.gbc" ]; then
    cp "$BASEROM" baserom.gbc
fi

python3 tools/extract.py baserom.gbc data.manifest data/
echo "setup complete: data extracted to data/"
