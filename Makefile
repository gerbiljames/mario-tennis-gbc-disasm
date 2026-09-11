RGBDS   ?= tools/rgbds/
RGBASM  := $(RGBDS)rgbasm
RGBLINK := $(RGBDS)rgblink
RGBFIX  := $(RGBDS)rgbfix

ROM     := mariotennis.gbc
SRCS    := $(wildcard src/bank_*.asm)
OBJS    := $(SRCS:src/%.asm=build/%.o) build/ram.o
RAM_SRCS := ram.asm $(wildcard ram/*.asm)

BASEROM_SHA1 := 414ba58340a27fc27b127bc01455b32764151ff0

.PHONY: all compare check test clean

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
PRELUDE := include/hardware.inc include/macros.inc include/constants.inc include/text_ids.inc include/flag_constants.inc include/ram_mirrored.inc

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

# `DEF <Label>_SIZE EQU <decoded length>` for an LZ stream the source copies
# whole after decompressing (`ld c, Label_SIZE / 16`): the assembler cannot
# measure a decoded length, so it is derived from the blob and follows edits.
data/%.inc: data/%.bin
	python3 tools/lz.py --size-inc $< > $@

build/rgbdscheck.o: rgbdscheck.asm | build
	$(RGBASM) -o $@ $<

# Top-of-file INCLUDE paths resolve via -I include; INCBIN paths and the
# indented data/ INCLUDEs (generated text source) are repo-relative.
ifeq (,$(filter clean,$(MAKECMDGOALS)))
$(foreach src,$(SRCS),$(eval build/$(notdir $(src:.asm=.o)): \
	$(shell sed -n 's|^INCLUDE "\(.*\)"|include/\1|p; s|^[[:space:]]*INCBIN "\([^"]*\)".*|\1|p; s|^[[:space:]]*INCLUDE "\(data/[^"]*\)".*|\1|p' $(src))))
endif

build:
	mkdir -p build

compare: $(ROM)
	@echo "$(BASEROM_SHA1)  $(ROM)" | sha1sum -c

# Structural invariants a byte-perfect build cannot see: that the declared LZ
# streams really decode (and re-encode), that no symbol truncates one, that the
# text offset tables address real strings, that every curated immediate lands on
# an instruction holding that value, and that the extracted regions do not
# overlap. See tools/check.py.
check:
	python3 tools/check.py

# The unit tests need no ROM; the regression pins in tests/test_rom.py skip
# themselves when baserom.gbc is absent.
test:
	python3 -m unittest discover -s tests -t . -v

clean:
	rm -rf build $(ROM)
