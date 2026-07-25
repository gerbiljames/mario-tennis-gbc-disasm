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


def render_operand(ins, off, labels, hwregs, ramnames, data_labels=None,
                   ramscoped=None, constants=None):
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
            # Same for curated RAM symbols: a word immediate equal to a
            # named RAM address is a pointer setup, not a constant.
            if ramnames and imm in ramnames:
                return f"ld {m.group(1)}, {ramnames[imm]}"
            if ramscoped:
                sn = ramscoped.resolve(imm, off)
                if sn:
                    return f"ld {m.group(1)}, {sn}"
    if "$ff" in text and hwregs:
        m = HWADDR_RE.search(text)
        if m:
            addr = int(m.group(0)[1:], 16)
            if addr in hwregs:
                text = text.replace(m.group(0), hwregs[addr])
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
        return text.replace("{target}", labels[t])
    width = 2 if text.startswith("rst") else 4
    return text.replace("{target}", f"${ins.target:0{width}x}")
