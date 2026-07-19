RGBDS   ?= tools/rgbds/
RGBASM  := $(RGBDS)rgbasm
RGBLINK := $(RGBDS)rgblink

ROM     := mariotennis.gbc
SRCS    := $(wildcard src/bank_*.asm)
OBJS    := $(SRCS:src/%.asm=build/%.o) build/ram.o
RAM_SRCS := ram.asm $(wildcard ram/*.asm)

BASEROM_SHA1 := 414ba58340a27fc27b127bc01455b32764151ff0

.PHONY: all compare clean

all: $(ROM)

$(ROM): $(OBJS)
	$(RGBLINK) -o $@ -m build/$(ROM:.gbc=.map) -n build/$(ROM:.gbc=.sym) $(OBJS)

# hardware.inc + macros.inc are preincluded for every bank via -P instead of a
# repeated INCLUDE at the top of each source file.
PRELUDE := include/hardware.inc include/macros.inc include/constants.inc

build/%.o: src/%.asm $(PRELUDE) | build/rgbdscheck.o
	$(RGBASM) -E -I include $(PRELUDE:%=-P %) -o $@ $<

build/ram.o: $(RAM_SRCS) | build/rgbdscheck.o
	$(RGBASM) -E -I include -I . -o $@ ram.asm

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

clean:
	rm -rf build $(ROM)
