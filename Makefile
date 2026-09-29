RGBDS   ?= tools/rgbds/
RGBASM  := $(RGBDS)rgbasm
RGBLINK := $(RGBDS)rgblink
RGBFIX  := $(RGBDS)rgbfix

ROM     := mariotennis.gbc
SRCS    := $(wildcard src/bank_*.asm)
OBJS    := $(SRCS:src/%.asm=build/%.o) build/ram.o
RAM_SRCS := ram.asm $(wildcard ram/*.asm)

BASEROM_SHA1 := 414ba58340a27fc27b127bc01455b32764151ff0

# The mods/ overlay: edited data files a fork commits (mods/README.md) are
# copied over data/ before anything is built, at parse time so no target can
# race it. A copy is newer than the .bin it covers, so a PNG or grid from
# mods/ is re-encoded by the rules below.
ifeq (,$(filter clean,$(MAKECMDGOALS)))
$(info $(shell python3 tools/mods.py apply))
endif

.PHONY: all compare check test shift-test event-test slot-audit venv previews clean

all: $(ROM)

# rgbfix -v recomputes the header and global checksums. The unmodified build
# already has them right, so it changes nothing and `make compare` still holds;
# it is here for edited builds, where a wrong header checksum makes the CGB
# boot ROM refuse the cart -- changing one character of the title is enough.
$(ROM): $(OBJS)
	$(RGBLINK) -p 0xff -o $@ -m build/$(ROM:.gbc=.map) -n build/$(ROM:.gbc=.sym) $(OBJS)
	$(RGBFIX) -v $@

# hardware.inc + macros.inc are preincluded for every bank via -P instead of a
# repeated INCLUDE at the top of each source file.
PRELUDE := include/hardware.inc include/macros.inc include/constants.inc include/text_ids.inc include/flag_constants.inc include/text_codes.inc include/ram_mirrored.inc

build/%.o: src/%.asm $(PRELUDE) | build/rgbdscheck.o
	$(RGBASM) -E -I include $(PRELUDE:%=-P %) -o $@ $<

build/ram.o: $(RAM_SRCS) | build/rgbdscheck.o
	$(RGBASM) -E -I include -I . -o $@ ram.asm

# A graphics blob whose PNG (written by extract.py beside it) is newer is
# re-encoded from the image -- and re-compressed if it is an LZ stream. The
# PNG only exists for blobs the manifest tags gfx, and extract.py writes the
# .bin last, so an untouched tree never triggers this.
data/%.bin: data/%.png
	python3 tools/gfx.py encode $< $@

# A tilemap or attribute-map blob whose grid (.tilemap, written by extract.py
# beside it) is newer is re-encoded from the text, and re-compressed if it is
# an LZ stream. Same discipline as the PNGs: an untouched tree never triggers it.
data/%.bin: data/%.tilemap
	python3 tools/tilemap.py encode $< $@

# `DEF <Label>_SIZE EQU <decoded length>` for an LZ stream the source copies
# whole after decompressing (`ld c, Label_SIZE / 16`): the assembler cannot
# measure a decoded length, so it is derived from the blob and follows edits.
data/%.inc: data/%.bin
	python3 tools/lz.py --size-inc $< > $@

build/rgbdscheck.o: rgbdscheck.asm | build
	$(RGBASM) -o $@ $<

# A bank object depends on its holder, the fragment files the holder INCLUDEs
# (src/<subsystem>/<topic>_XX.asm), the top-of-file includes and every data
# file the bank INCBINs or INCLUDEs; tools/deps.py lists them.
FRAGMENTS := $(shell find src -mindepth 2 -name '*.asm')

build/deps.mk: $(SRCS) $(FRAGMENTS) tools/deps.py tools/banksrc.py | build
	python3 tools/deps.py > $@

ifeq (,$(filter clean,$(MAKECMDGOALS)))
-include build/deps.mk
endif

build:
	mkdir -p build

compare: $(ROM)
	@echo "$(BASEROM_SHA1)  $(ROM)" | sha1sum -c

# Structural invariants a byte-perfect build cannot see: that the declared LZ
# streams really decode (and re-encode), that no assembled symbol truncates
# one (read from the build's .sym, hence the dependency), that the extracted
# regions do not overlap, and that every PNG and tilemap grid encodes back to
# its blob. See tools/check.py.
check: $(ROM)
	python3 tools/check.py

# Redraw the view-only scene pictures (data/<bank>/<Tilemap>.preview.png)
# from the current grids, tiles and palettes, e.g. after editing a grid.
previews:
	python3 tools/tilemap.py previews data.previews data/

# The unit tests need no ROM; the regression pins in tests/test_rom.py skip
# themselves when baserom.gbc is absent.
test:
	python3 -m unittest discover -s tests -t . -v

# Rebuild a copy with every bank padded, check each changed byte is a label
# reference that moved with its target, and leave the padded ROM to boot
# (tools/shifttest.py).
shift-test: $(ROM)
	python3 tools/shifttest.py

# Play the padded ROM and this one through every story state under the same
# inputs and compare what the game does (tools/eventtest.py). Needs PyBoy in
# $(PYTHON) (`make venv`) and a battery save to start from.
PYTHON ?= $(if $(wildcard .venv/bin/python),.venv/bin/python,python3)
SAVE ?= maxed-unlocked.sav
event-test: $(ROM)
	python3 tools/shifttest.py --out build/padded.gbc
	$(PYTHON) tools/eventtest.py build/padded.gbc --save $(SAVE)

# Check every actor-slot name against the list active at run time, over
# every story state and location (tools/actorslots.py --runtime).
slot-audit: $(ROM)
	$(PYTHON) tools/actorslots.py --runtime --save $(SAVE)

# A virtualenv with the packages in requirements.txt; PYTHON uses it.
venv:
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt

clean:
	rm -rf build $(ROM)
