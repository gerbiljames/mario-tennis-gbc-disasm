"""SM83 / GBZ80 instruction decoder for the Mario Tennis GBC disassembler.

Decodes a single instruction at a byte offset into an rgbasm (v1.0) source
line, exactly enough for the assembler to reproduce the original bytes when
that line is reassembled.

Notes on exactness / rgbasm quirks, for callers doing byte-exact reassembly:

  - `ld [$nnnn], a` / `ld a, [$nnnn]` (opcodes EA/FA) are emitted as plain
    `ld` even when the address falls in $ff00-$ffff. rgbasm 1.0 does not
    silently rewrite `ld [nn], a` into the shorter `ldh` form -- `ld` and
    `ldh` are distinct mnemonics/opcodes to the assembler, so `ld [$ff44], a`
    always assembles to the 3-byte EA encoding. Only opcodes E0/F0/E2/F2 are
    emitted as `ldh`, and only because that is what those opcodes are.
  - `stop` with a non-zero byte following it (i.e. not the canonical 10 00
    encoding) is reported invalid; the caller should emit both bytes as raw
    `db` data rather than trying to round-trip a `stop $nn` pseudo-operand
    rgbasm doesn't support.
  - `jr`/`jp`/`call`/`rst` targets are left as the literal placeholder
    string "{target}" inside `text`; the caller is expected to substitute a
    label name or a `$xx`/`$xxxx` literal for that placeholder itself. The
    resolved absolute address is available separately via `Instr.target`.
  - 8-bit ALU ops (add/adc/sub/sbc/and/xor/or/cp) are always rendered in the
    two-operand form (`sub a, b`, `cp a, $12`, ...); rgbasm 1.0 accepts and
    re-emits this form identically for all eight ops, so it is unambiguous.
"""

from dataclasses import dataclass
from typing import Optional


@dataclass
class Instr:
    size: int
    text: str
    target: Optional[int]
    is_call: bool
    is_jump: bool
    is_cond: bool
    ends_flow: bool
    valid: bool = True


R8 = ["b", "c", "d", "e", "h", "l", "[hl]", "a"]
R16 = ["bc", "de", "hl", "sp"]
R16STK = ["bc", "de", "hl", "af"]
R16MEM = ["[bc]", "[de]", "[hl+]", "[hl-]"]
COND = ["nz", "z", "nc", "c"]
ALU = ["add", "adc", "sub", "sbc", "and", "xor", "or", "cp"]
ROT = ["rlc", "rrc", "rl", "rr", "sla", "sra", "swap", "srl"]

INVALID_OPCODES = frozenset(
    [0xD3, 0xDB, 0xDD, 0xE3, 0xE4, 0xEB, 0xEC, 0xED, 0xF4, 0xFC, 0xFD]
)


def hex8(n: int) -> str:
    return f"${n & 0xff:02x}"


def hex16(n: int) -> str:
    return f"${n & 0xffff:04x}"


def signed8(b: int) -> int:
    return b - 256 if b & 0x80 else b


def _invalid1(op: int) -> Instr:
    return Instr(1, f"db {hex8(op)}", None, False, False, False, False, False)


def decode(buf: bytes, offset: int, pc: int) -> Instr:
    n = len(buf)
    if offset < 0 or offset >= n:
        return Instr(1, "db $00", None, False, False, False, False, False)

    op = buf[offset]

    if op in INVALID_OPCODES:
        return _invalid1(op)

    def have(extra: int) -> bool:
        return offset + 1 + extra <= n

    def u8(o: int) -> int:
        return buf[o]

    def u16(o: int) -> int:
        return buf[o] | (buf[o + 1] << 8)

    top = op >> 6

    # ---- CB prefix ------------------------------------------------------
    if op == 0xCB:
        if not have(1):
            return _invalid1(op)
        op2 = buf[offset + 1]
        grp = op2 >> 6
        r = op2 & 7
        rtext = R8[r]
        if grp == 0:
            sub = (op2 >> 3) & 7
            text = f"{ROT[sub]} {rtext}"
        elif grp == 1:
            b = (op2 >> 3) & 7
            text = f"bit {b}, {rtext}"
        elif grp == 2:
            b = (op2 >> 3) & 7
            text = f"res {b}, {rtext}"
        else:
            b = (op2 >> 3) & 7
            text = f"set {b}, {rtext}"
        return Instr(2, text, None, False, False, False, False, True)

    # ---- block 01: ld r8, r8' (and halt) --------------------------------
    if top == 1:
        dst = (op >> 3) & 7
        src = op & 7
        if dst == 6 and src == 6:
            return Instr(1, "halt", None, False, False, False, False, True)
        text = f"ld {R8[dst]}, {R8[src]}"
        return Instr(1, text, None, False, False, False, False, True)

    # ---- block 10: alu a, r8 ---------------------------------------------
    if top == 2:
        sub = (op >> 3) & 7
        src = op & 7
        text = f"{ALU[sub]} a, {R8[src]}"
        return Instr(1, text, None, False, False, False, False, True)

    # ---- block 00 ----------------------------------------------------------
    if top == 0:
        low3 = op & 7
        b53 = (op >> 3) & 7

        if low3 == 0:
            if b53 == 0:
                return Instr(1, "nop", None, False, False, False, False, True)
            if b53 == 1:
                if not have(2):
                    return _invalid1(op)
                addr = u16(offset + 1)
                text = f"ld [{hex16(addr)}], sp"
                return Instr(3, text, None, False, False, False, False, True)
            if b53 == 2:
                if not have(1):
                    return _invalid1(op)
                nxt = buf[offset + 1]
                if nxt == 0x00:
                    return Instr(2, "stop", None, False, False, False, False, True)
                return Instr(1, f"db {hex8(op)}", None, False, False, False, False, False)
            if b53 == 3:
                if not have(1):
                    return _invalid1(op)
                rel = signed8(buf[offset + 1])
                tgt = pc + 2 + rel
                return Instr(2, "jr {target}", tgt, False, True, False, True, True)
            # b53 in 4..7: jr cc, e8
            if not have(1):
                return _invalid1(op)
            cc = (op >> 3) & 3
            rel = signed8(buf[offset + 1])
            tgt = pc + 2 + rel
            text = f"jr {COND[cc]}, {{target}}"
            return Instr(2, text, tgt, False, True, True, False, True)

        if low3 == 1:
            r16 = (op >> 4) & 3
            if (op >> 3) & 1 == 0:
                if not have(2):
                    return _invalid1(op)
                imm = u16(offset + 1)
                text = f"ld {R16[r16]}, {hex16(imm)}"
                return Instr(3, text, None, False, False, False, False, True)
            else:
                text = f"add hl, {R16[r16]}"
                return Instr(1, text, None, False, False, False, False, True)

        if low3 == 2:
            rm = (op >> 4) & 3
            if (op >> 3) & 1 == 0:
                text = f"ld {R16MEM[rm]}, a"
            else:
                text = f"ld a, {R16MEM[rm]}"
            return Instr(1, text, None, False, False, False, False, True)

        if low3 == 3:
            r16 = (op >> 4) & 3
            if (op >> 3) & 1 == 0:
                text = f"inc {R16[r16]}"
            else:
                text = f"dec {R16[r16]}"
            return Instr(1, text, None, False, False, False, False, True)

        if low3 == 4:
            r8 = (op >> 3) & 7
            return Instr(1, f"inc {R8[r8]}", None, False, False, False, False, True)

        if low3 == 5:
            r8 = (op >> 3) & 7
            return Instr(1, f"dec {R8[r8]}", None, False, False, False, False, True)

        if low3 == 6:
            r8 = (op >> 3) & 7
            if not have(1):
                return _invalid1(op)
            imm = buf[offset + 1]
            text = f"ld {R8[r8]}, {hex8(imm)}"
            return Instr(2, text, None, False, False, False, False, True)

        # low3 == 7: misc single-byte ops
        misc = ["rlca", "rrca", "rla", "rra", "daa", "cpl", "scf", "ccf"]
        return Instr(1, misc[b53], None, False, False, False, False, True)

    # ---- block 11 --------------------------------------------------------
    low3 = op & 7
    b53 = (op >> 3) & 7

    if low3 == 0:
        if b53 <= 3:
            cc = b53
            text = f"ret {COND[cc]}"
            return Instr(1, text, None, False, False, True, False, True)
        if b53 == 4:
            if not have(1):
                return _invalid1(op)
            imm = buf[offset + 1]
            addr = 0xFF00 + imm
            text = f"ldh [{hex16(addr)}], a"
            return Instr(2, text, None, False, False, False, False, True)
        if b53 == 5:
            if not have(1):
                return _invalid1(op)
            val = signed8(buf[offset + 1])
            text = f"add sp, {val}"
            return Instr(2, text, None, False, False, False, False, True)
        if b53 == 6:
            if not have(1):
                return _invalid1(op)
            imm = buf[offset + 1]
            addr = 0xFF00 + imm
            text = f"ldh a, [{hex16(addr)}]"
            return Instr(2, text, None, False, False, False, False, True)
        # b53 == 7
        if not have(1):
            return _invalid1(op)
        val = signed8(buf[offset + 1])
        if val >= 0:
            text = f"ld hl, sp + {val}"
        else:
            text = f"ld hl, sp - {-val}"
        return Instr(2, text, None, False, False, False, False, True)

    if low3 == 1:
        if (op >> 3) & 1 == 0:
            r16s = (op >> 4) & 3
            text = f"pop {R16STK[r16s]}"
            return Instr(1, text, None, False, False, False, False, True)
        else:
            sel = (op >> 4) & 3
            if sel == 0:
                return Instr(1, "ret", None, False, False, False, True, True)
            if sel == 1:
                return Instr(1, "reti", None, False, False, False, True, True)
            if sel == 2:
                return Instr(1, "jp hl", None, False, True, False, True, True)
            return Instr(1, "ld sp, hl", None, False, False, False, False, True)

    if low3 == 2:
        if b53 <= 3:
            cc = b53
            if not have(2):
                return _invalid1(op)
            addr = u16(offset + 1)
            text = f"jp {COND[cc]}, {{target}}"
            return Instr(3, text, addr, False, True, True, False, True)
        if b53 == 4:
            return Instr(1, "ldh [c], a", None, False, False, False, False, True)
        if b53 == 5:
            if not have(2):
                return _invalid1(op)
            addr = u16(offset + 1)
            text = f"ld [{hex16(addr)}], a"
            return Instr(3, text, None, False, False, False, False, True)
        if b53 == 6:
            return Instr(1, "ldh a, [c]", None, False, False, False, False, True)
        # b53 == 7
        if not have(2):
            return _invalid1(op)
        addr = u16(offset + 1)
        text = f"ld a, [{hex16(addr)}]"
        return Instr(3, text, None, False, False, False, False, True)

    if low3 == 3:
        if b53 == 0:
            if not have(2):
                return _invalid1(op)
            addr = u16(offset + 1)
            return Instr(3, "jp {target}", addr, False, True, False, True, True)
        if b53 == 6:
            return Instr(1, "di", None, False, False, False, False, True)
        if b53 == 7:
            return Instr(1, "ei", None, False, False, False, False, True)
        # b53 in {2,3,4,5} -> D3,DB,E3,EB handled by INVALID_OPCODES already
        return _invalid1(op)

    if low3 == 4:
        if b53 <= 3:
            cc = b53
            if not have(2):
                return _invalid1(op)
            addr = u16(offset + 1)
            text = f"call {COND[cc]}, {{target}}"
            return Instr(3, text, addr, True, False, True, False, True)
        return _invalid1(op)

    if low3 == 5:
        if (op >> 3) & 1 == 0:
            r16s = (op >> 4) & 3
            text = f"push {R16STK[r16s]}"
            return Instr(1, text, None, False, False, False, False, True)
        else:
            sel = (op >> 4) & 3
            if sel == 0:
                if not have(2):
                    return _invalid1(op)
                addr = u16(offset + 1)
                return Instr(3, "call {target}", addr, True, False, False, False, True)
            return _invalid1(op)

    if low3 == 6:
        if not have(1):
            return _invalid1(op)
        imm = buf[offset + 1]
        text = f"{ALU[b53]} a, {hex8(imm)}"
        return Instr(2, text, None, False, False, False, False, True)

    # low3 == 7: rst
    vec = b53 * 8
    return Instr(1, "rst {target}", vec, True, False, False, False, True)


def selftest():
    # 1. Full coverage of all 256 base opcodes: no exceptions, valid flag
    #    matches the known invalid set, sizes match the documented base
    #    table sizes (peeking with a well-stocked 3-byte trailer so no
    #    opcode is starved of operand bytes).
    expected_size = {}
    for op in range(256):
        if op in INVALID_OPCODES:
            expected_size[op] = 1
            continue
        top = op >> 6
        low3 = op & 7
        b53 = (op >> 3) & 7
        if op == 0xCB:
            expected_size[op] = 2
        elif top == 1 or top == 2:
            expected_size[op] = 1
        elif top == 0:
            if low3 == 0:
                expected_size[op] = {0: 1, 1: 3, 2: 2, 3: 2}.get(b53, 2)
            elif low3 in (1,):
                expected_size[op] = 3 if (op >> 3) & 1 == 0 else 1
            elif low3 in (2, 3):
                expected_size[op] = 1
            elif low3 == 4 or low3 == 5:
                expected_size[op] = 1
            elif low3 == 6:
                expected_size[op] = 2
            else:
                expected_size[op] = 1
        else:  # top == 3
            if low3 == 0:
                expected_size[op] = 1 if b53 <= 3 else 2
            elif low3 == 1:
                expected_size[op] = 1
            elif low3 == 2:
                expected_size[op] = 1 if b53 in (4, 6) else 3
            elif low3 == 3:
                expected_size[op] = 3 if b53 == 0 else 1
            elif low3 == 4:
                expected_size[op] = 3
            elif low3 == 5:
                expected_size[op] = 3 if ((op >> 3) & 1) and (op >> 4) & 3 == 0 else 1
            elif low3 == 6:
                expected_size[op] = 2
            else:
                expected_size[op] = 1

    valid_count = 0
    invalid_count = 0
    buf = bytes([0x00, 0x12, 0x34]) * 4  # generous trailer, non-zero so STOP is exercised separately
    for op in range(256):
        full = bytes([op]) + buf
        instr = decode(full, 0, 0x100)
        assert instr.size >= 1
        if op in INVALID_OPCODES:
            assert not instr.valid, f"opcode {op:02x} should be invalid"
            invalid_count += 1
        else:
            assert instr.valid, f"opcode {op:02x} should be valid, got {instr}"
            assert instr.size == expected_size[op], (
                f"opcode {op:02x}: expected size {expected_size[op]}, got {instr.size}"
            )
            valid_count += 1

    assert valid_count == 245, valid_count
    assert invalid_count == 11, invalid_count

    # STOP with zero trailer must decode as valid `stop`.
    stop_ok = decode(bytes([0x10, 0x00, 0x00]), 0, 0)
    assert stop_ok.valid and stop_ok.text == "stop" and stop_ok.size == 2

    # STOP with non-zero trailer must be invalid.
    stop_bad = decode(bytes([0x10, 0x01, 0x00]), 0, 0)
    assert not stop_bad.valid and stop_bad.size == 1

    # 2. Full coverage of all 256 CB-prefixed opcodes.
    for op2 in range(256):
        full = bytes([0xCB, op2, 0x00])
        instr = decode(full, 0, 0x100)
        assert instr.valid
        assert instr.size == 2

    # 3. Truncated buffer -> invalid 1-byte instruction.
    trunc = decode(bytes([0x3E]), 0, 0)  # ld a, n8 with no operand byte
    assert not trunc.valid and trunc.size == 1

    trunc_cb = decode(bytes([0xCB]), 0, 0)
    assert not trunc_cb.valid and trunc_cb.size == 1

    trunc_u16 = decode(bytes([0xC3, 0x34]), 0, 0)  # jp nn missing high byte
    assert not trunc_u16.valid and trunc_u16.size == 1

    # 4. Spot checks against hand-written expected strings/fields.
    def check(data, off, pc, exp_text, exp_size=None, exp_target=None, **flags):
        instr = decode(bytes(data), off, pc)
        assert instr.text == exp_text, f"{data}: got {instr.text!r} expected {exp_text!r}"
        if exp_size is not None:
            assert instr.size == exp_size, f"{data}: size {instr.size} != {exp_size}"
        if exp_target is not None:
            assert instr.target == exp_target, f"{data}: target {instr.target} != {exp_target}"
        for k, v in flags.items():
            assert getattr(instr, k) == v, f"{data}: {k} = {getattr(instr, k)} != {v}"
        return instr

    check([0x00], 0, 0, "nop", 1)
    check([0x76], 0, 0, "halt", 1)
    check([0xF3], 0, 0, "di", 1)
    check([0xFB], 0, 0, "ei", 1)
    check([0x27], 0, 0, "daa", 1)
    check([0x2F], 0, 0, "cpl", 1)
    check([0x37], 0, 0, "scf", 1)
    check([0x3F], 0, 0, "ccf", 1)

    check([0x01, 0x34, 0x12], 0, 0, "ld bc, $1234", 3)
    check([0x21, 0xfe, 0xff], 0, 0, "ld hl, $fffe", 3)
    check([0x31, 0xfe, 0xff], 0, 0, "ld sp, $fffe", 3)
    check([0x3E, 0x0a], 0, 0, "ld a, $0a", 2)
    check([0x06, 0x00], 0, 0, "ld b, $00", 2)

    check([0x02], 0, 0, "ld [bc], a", 1)
    check([0x12], 0, 0, "ld [de], a", 1)
    check([0x22], 0, 0, "ld [hl+], a", 1)
    check([0x32], 0, 0, "ld [hl-], a", 1)
    check([0x0A], 0, 0, "ld a, [bc]", 1)
    check([0x2A], 0, 0, "ld a, [hl+]", 1)
    check([0x3A], 0, 0, "ld a, [hl-]", 1)

    check([0x78], 0, 0, "ld a, b", 1)
    check([0x7E], 0, 0, "ld a, [hl]", 1)

    check([0x80], 0, 0, "add a, b", 1)
    check([0x8E], 0, 0, "adc a, [hl]", 1)
    check([0x90], 0, 0, "sub a, b", 1)
    check([0x9E], 0, 0, "sbc a, [hl]", 1)
    check([0xA1], 0, 0, "and a, c", 1)
    check([0xAA], 0, 0, "xor a, d", 1)
    check([0xB6], 0, 0, "or a, [hl]", 1)
    check([0xFE, 0x12], 0, 0, "cp a, $12", 2)
    check([0xC6, 0x12], 0, 0, "add a, $12", 2)

    check([0x09], 0, 0, "add hl, bc", 1)
    check([0x39], 0, 0, "add hl, sp", 1)
    check([0x03], 0, 0, "inc bc", 1)
    check([0x2B], 0, 0, "dec hl", 1)
    check([0x34], 0, 0, "inc [hl]", 1)
    check([0x35], 0, 0, "dec [hl]", 1)

    check([0xC1], 0, 0, "pop bc", 1)
    check([0xF1], 0, 0, "pop af", 1)
    check([0xC5], 0, 0, "push bc", 1)
    check([0xF5], 0, 0, "push af", 1)

    check([0x08, 0x00, 0xc0], 0, 0, "ld [$c000], sp", 3)

    check([0xE0, 0x44], 0, 0, "ldh [$ff44], a", 2)
    check([0xF0, 0x44], 0, 0, "ldh a, [$ff44]", 2)
    check([0xE2], 0, 0, "ldh [c], a", 1)
    check([0xF2], 0, 0, "ldh a, [c]", 1)
    check([0xEA, 0x44, 0xff], 0, 0, "ld [$ff44], a", 3)
    check([0xFA, 0x00, 0xc0], 0, 0, "ld a, [$c000]", 3)

    check([0xE8, 0x05], 0, 0, "add sp, 5", 2)
    check([0xE8, 0xfe], 0, 0, "add sp, -2", 2)
    check([0xF8, 0x05], 0, 0, "ld hl, sp + 5", 2)
    check([0xF8, 0xfe], 0, 0, "ld hl, sp - 2", 2)

    # jr $18 at pc=0x100, offset 0x02 -> target = 0x100+2+2 = 0x104
    j = check(
        [0x18, 0x02], 0, 0x100, "jr {target}", 2, 0x104,
        is_jump=True, is_cond=False, ends_flow=True, is_call=False,
    )
    # jr backwards: e8 = 0xfc (-4) -> target = pc+2-4
    check([0x20, 0xfc], 0, 0x200, "jr nz, {target}", 2, 0x200 + 2 - 4,
          is_jump=True, is_cond=True, ends_flow=False)

    check([0xC3, 0x00, 0x01], 0, 0, "jp {target}", 3, 0x0100,
          is_jump=True, is_cond=False, ends_flow=True, is_call=False)
    check([0xC2, 0x00, 0x01], 0, 0, "jp nz, {target}", 3, 0x0100,
          is_jump=True, is_cond=True, ends_flow=False)
    check([0xE9], 0, 0, "jp hl", 1, None, is_jump=True, ends_flow=True, is_call=False)

    check([0xCD, 0x00, 0x01], 0, 0, "call {target}", 3, 0x0100,
          is_call=True, is_jump=False, is_cond=False, ends_flow=False)
    check([0xC4, 0x00, 0x01], 0, 0, "call nz, {target}", 3, 0x0100,
          is_call=True, is_cond=True, ends_flow=False)

    check([0xC9], 0, 0, "ret", 1, None, ends_flow=True, is_call=False, is_jump=False)
    check([0xD9], 0, 0, "reti", 1, None, ends_flow=True)
    check([0xC0], 0, 0, "ret nz", 1, None, is_cond=True, ends_flow=False)
    check([0xD8], 0, 0, "ret c", 1, None, is_cond=True, ends_flow=False)

    check([0xC7], 0, 0, "rst {target}", 1, 0x00, is_call=True, ends_flow=False)
    check([0xDF], 0, 0, "rst {target}", 1, 0x18, is_call=True, ends_flow=False)
    check([0xFF], 0, 0, "rst {target}", 1, 0x38, is_call=True, ends_flow=False)

    check([0x10, 0x00], 0, 0, "stop", 2)

    # CB spot checks
    check([0xCB, 0x00], 0, 0, "rlc b", 2)
    check([0xCB, 0x06], 0, 0, "rlc [hl]", 2)
    check([0xCB, 0x37], 0, 0, "swap a", 2)
    check([0xCB, 0x3F], 0, 0, "srl a", 2)
    check([0xCB, 0x40], 0, 0, "bit 0, b", 2)
    check([0xCB, 0x7E], 0, 0, "bit 7, [hl]", 2)
    check([0xCB, 0x87], 0, 0, "res 0, a", 2)
    check([0xCB, 0xFF], 0, 0, "set 7, a", 2)

    # invalid opcodes
    for bad in (0xD3, 0xDB, 0xDD, 0xE3, 0xE4, 0xEB, 0xEC, 0xED, 0xF4, 0xFC, 0xFD):
        instr = decode(bytes([bad]), 0, 0)
        assert not instr.valid
        assert instr.size == 1
        assert instr.text == f"db {hex8(bad)}"


if __name__ == "__main__":
    selftest()
    print("OK")
