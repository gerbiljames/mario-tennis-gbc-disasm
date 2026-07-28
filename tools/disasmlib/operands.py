"""Rendering one instruction's operand as source text."""
import re

from .rom import BANK_SIZE, target_to_offset


HWADDR_RE = re.compile(r"\$ff[0-9a-f]{2}\b")
MEMADDR_RE = re.compile(r"\[\$([0-9a-f]{4})\]")
LDIMM_RE = re.compile(r"^ld (hl|de|bc), \$([0-9a-f]{1,4})$")


# ROM0 data a banked caller loads by address. A word below $4000 loaded from
# ROMX is far more often a text id or a packed y/x pair than a pointer into
# bank $00, so those loads stay numeric unless listed here.
ROM0_FAR_POINTERS = {0x0153}

IMM8_RE = re.compile(r"\$[0-9a-f]{1,2}$")
IMM16_RE = re.compile(r"^ld (bc|de|hl), \$([0-9a-f]{4})$")
MBC_WRITE_RE = re.compile(r"^ld \[\$([0-5][0-9a-f]{3})\], a$")

# The MBC5 command windows, in the order a write is matched against them.
MBC_REGS = ((0x4000, "rRAMB"), (0x3000, "rROMB1"), (0x2000, "rROMB0"),
            (0x0000, "rRAMG"))

# The one site outside bank $03 that loads a real SRAM address: FetchSRAMText
# reads text out of the save at $a800. Bank $03 (the save engine) is excluded
# wholesale by its flat range.
SRAM_IMM_SITES = {0x16d49}


# Sites where a word immediate that happens to equal a named RAM address is an
# arithmetic constant, not a pointer setup. $ff80 is -128 (range clamps that
# `add hl, de` then test bit 7, and the stat-page scroll offsets stored beside
# `ld de, $0060`); $c000 at 08:$6b5e is a SetBallVelocityPolar magnitude.
# $d8f0 at 05:$531d is -10000, the first divisor MeasureNextArgNumberWidth
# subtracts, and it sits two instructions from a real wTextArgShortTextQueue
# pointer setup in the same routine.
# Keyed by flat offset, so only these exact instructions stay numeric.
RAM_IMM_IS_CONSTANT = {
    0x010dc, 0x084ce, 0x1531d, 0x212fb, 0x22b5e,
    0x352b6, 0x3577b, 0x35c0b, 0x35da0, 0x35e7d,
    0x75165, 0x75337, 0x75542, 0x75699,
}


# The same hazard, but a property of the *address* rather than of a site: these
# HRAM bytes are only ever reached with `ldh`, so every `ld rr, n16` equal to one
# is the negative constant it looks like -- $ffe0 is -32 (one tilemap row back,
# which is why it turns up in every blit and slide loop), $ffc0 -64, $ffa0 -96,
# $ffdf -33, $ffe8 -24, $fffd -3 (hRandomSeed + 1, an interior byte). All 45
# sites feed
# `add hl, rr` or get stored as a 16-bit delta; not one is dereferenced. Keeping the list by address rather than by offset means a
# newly carved blit loop cannot quietly acquire a link-engine name.
# Not every HRAM address belongs here: `ld hl, hActorPtr` is a real pointer
# setup at 82 sites, so this stays curated per address.
RAM_IMM_NEVER = {0xffa0, 0xffc0, 0xffdf, 0xffe0, 0xffe8, 0xfffd}


# The same hazard once more, for hardware register names. `ld hl, rIE` is a real
# pointer setup at 74 sites (the code then `set`s or `res`s a bit through it), so
# this cannot be an address rule -- rLCDC appears in both roles. These 18 sites
# load the register address as an addend instead: $ff00 is -256, $ff40 -192,
# $ff70 -144, each immediately followed by `add hl, rr`. Keyed by flat offset,
# like RAM_IMM_IS_CONSTANT.
HWADDR_IMM_IS_CONSTANT = {
    0x17455,
    0x1d2dd,
    0x210a0, 0x210a6, 0x21310, 0x23361, 0x233af, 0x23980,
    0x35251, 0x35281, 0x352d8, 0x352ee, 0x3574e, 0x357b3,
    0x35c21, 0x35e29, 0x35e93,
    0x926ea,
}


# Sites whose 8-bit immediate is the *low byte* of an $ffxx address, because
# the code reaches it through `ldh [c]` rather than by naming it: `ld c, $80` is
# the destination hOAMDMARoutine is copied to, and `ld c, $6b`/`ld c, $30` are
# the palette-data and wave-RAM ports. Curated because the byte alone cannot say
# which symbol it is the low half of -- SoftReset's `ld c, $80` walks all of
# HRAM from $ff80 rather than addressing the DMA routine, so it is not here.
LOW_BYTE_SITES = {
    0x0028b: "rOBPD",             # 64 bytes out through the OBJ palette port
    0x006ac: "hOAMDMARoutine",    # copy destination, 10 bytes
    0x0354c: "_AUD3WAVERAM",      # 16 bytes of wave pattern
    0x03690: "_AUD3WAVERAM",
}


# Sites whose word immediate is the address of *code*: the ten bytes at
# OAMDMARoutine are data to their only reader, which copies them into HRAM to be
# executed there, so the label of the code is the operand. Curated per site for
# the same reason as ROM0_FAR_POINTERS -- a word that happens to equal some
# routine's address is usually a constant, so this is never inferred.
IMM_CODE_POINTERS = {0x006b0}


def render_operand(ins, off, labels, hwregs, ramnames, data_labels=None,
                   ramscoped=None, constants=None, scopes=None):
    text = ins.text
    # A curated 8-bit immediate (constants.json maps the instruction offset to a
    # named constant, e.g. a wCurrentShotType code). Keyed by exact offset, so
    # only the tagged `ld r, n8` / `cp a, n8` sites are affected; a wrong tag
    # changes the assembled byte and fails the byte-perfect compare.
    if constants and off in constants and ins.target is None:
        name = constants[off]
        # bit/set/res N, r: the index is baked into the opcode, so replacing it
        # with a (numerically equal) named bit constant is a pure text change.
        mb = re.match(r"(bit|res|set) \d+, (.*)$", text)
        if mb:
            return f"{mb.group(1)} {name}, {mb.group(2)}"
        # `ld rr, n16` -- the save-flag ids passed to Test/Set/ClearSaveFlag are
        # 16-bit (byte << 8 | bit << 5), so they need the wide form.
        m16 = LDIMM_RE.match(text)
        if m16:
            return f"ld {m16.group(1)}, {name}"
        m = IMM8_RE.search(text)
        if m:
            return text[:m.start()] + name
    # An 8-bit immediate that is the low half of an address the code never
    # names, because it addresses through `ldh [c]`.
    if off in LOW_BYTE_SITES and ins.target is None:
        m = IMM8_RE.search(text)
        if m:
            return text[:m.start()] + f"LOW({LOW_BYTE_SITES[off]})"
    # A 16-bit immediate load whose value points at a named data region is a
    # pointer setup; inline the label. Bounded to data_labels (curated data
    # offsets) so numeric constants that alias code addresses are untouched.
    if data_labels and ins.target is None:
        m = LDIMM_RE.match(text)
        if m:
            imm = int(m.group(2), 16)
            base = (off // BANK_SIZE) * BANK_SIZE
            flat = None
            if imm < 0x4000:
                if not base or imm in ROM0_FAR_POINTERS:
                    flat = imm
            elif base and imm < 0x8000:
                flat = base + (imm - 0x4000)
            if flat in data_labels:
                return f"ld {m.group(1)}, {data_labels[flat]}"
            if off in IMM_CODE_POINTERS and flat in labels:
                name = scopes.ref(flat, off) if scopes else labels[flat]
                return f"ld {m.group(1)}, {name}"
            # Same for curated RAM symbols: a word immediate equal to a
            # named RAM address is a pointer setup, not a constant.
            if off not in RAM_IMM_IS_CONSTANT and imm not in RAM_IMM_NEVER:
                if ramnames and imm in ramnames:
                    return f"ld {m.group(1)}, {ramnames[imm]}"
                if ramscoped:
                    sn = ramscoped.resolve(imm, off)
                    if sn:
                        return f"ld {m.group(1)}, {sn}"
    # A word immediate in $a000-$bfff handed to the graphics code is a VRAM
    # destination with the bank folded into bit 13 (see QueueVRAMCopy), not an
    # SRAM address. The value cannot say which: $a000 is both the SRAM base and
    # VRAM bank 1's $8000. What decides it is that *only bank $03 ever enables
    # SRAM* -- every `ld a, $0a` / `ld [$0000], a` in the ROM is in the save
    # engine -- so everywhere else the range is VRAM. Rendering it as
    # `$9800 + VRAM_BANK1` puts the bank back in the operand, and rgbasm folds
    # it to the same word.
    m = IMM16_RE.search(text) if "ld " in text else None
    if m and off not in SRAM_IMM_SITES and not (0x0c000 <= off < 0x10000):
        imm = int(m.group(2), 16)
        if 0xa000 <= imm < 0xc000:
            return f"ld {m.group(1)}, ${imm - 0x2000:04x} + VRAM_BANK1"
    if "$ff" in text and hwregs and off not in HWADDR_IMM_IS_CONSTANT:
        m = HWADDR_RE.search(text)
        if m:
            addr = int(m.group(0)[1:], 16)
            if addr in hwregs:
                text = text.replace(m.group(0), hwregs[addr])
    # A *write* through a bracket operand below $8000 is not a memory store at
    # all -- ROM space is the MBC's command interface, so it always selects a
    # bank or gates cartridge RAM. (No instruction in the ROM reads a bracket
    # operand from this range, so restricting to the write form costs nothing.)
    if MBC_WRITE_RE.match(text):
        addr = int(MBC_WRITE_RE.match(text).group(1), 16)
        for base, name in MBC_REGS:
            if base <= addr < base + 0x2000:
                off_in = addr - base
                sym = name if not off_in else f"{name} + {off_in}"
                return f"ld [{sym}], a"
    if ramnames and "[$" in text:
        m = MEMADDR_RE.search(text)
        if m:
            addr = int(m.group(1), 16)
            if addr in ramnames:
                text = text.replace(f"[${m.group(1)}]", f"[{ramnames[addr]}]")
            elif ramscoped:
                sn = ramscoped.resolve(addr, off)
                if sn:
                    text = text.replace(f"[${m.group(1)}]", f"[{sn}]")
    if ins.target is None:
        return text
    t = target_to_offset(ins.target, off)
    if t is not None and t in labels:
        name = scopes.ref(t, off) if scopes else labels[t]
        return text.replace("{target}", name)
    # A call/jp whose target is RAM runs code that was copied there (the OAM DMA
    # routine in HRAM), so the RAM symbol is the operand. Unambiguous in a way
    # the immediate forms are not: a branch target is always an address, and no
    # ROM offset can collide because target_to_offset resolves those first.
    if t is None and ramnames and ins.target in ramnames:
        return text.replace("{target}", ramnames[ins.target])
    width = 2 if text.startswith("rst") else 4
    return text.replace("{target}", f"${ins.target:0{width}x}")
