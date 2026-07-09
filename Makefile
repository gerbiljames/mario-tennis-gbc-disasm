RGBDS   ?= tools/rgbds/
RGBASM  := $(RGBDS)rgbasm
RGBLINK := $(RGBDS)rgblink

ROM     := mariotennis.gbc
SRCS    := $(wildcard src/bank_*.asm)
OBJS    := $(SRCS:src/%.asm=build/%.o)

BASEROM_SHA1 := 414ba58340a27fc27b127bc01455b32764151ff0

.PHONY: all compare clean

all: $(ROM)

$(ROM): $(OBJS)
	$(RGBLINK) -o $@ -m build/$(ROM:.gbc=.map) -n build/$(ROM:.gbc=.sym) $(OBJS)

build/%.o: src/%.asm | build
	$(RGBASM) -E -I include -o $@ $<

build:
	mkdir -p build

compare: $(ROM)
	@echo "$(BASEROM_SHA1)  $(ROM)" | sha1sum -c

clean:
	rm -rf build $(ROM)
