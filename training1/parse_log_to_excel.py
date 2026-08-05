import os
import sys
import re
import time

# -------------------------
# Check command-line arguments
# -------------------------
if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <input_log> <output_spike>")
    sys.exit(1)

inp_file = sys.argv[1]
out_file = sys.argv[2]

# -------------------------
# Open input log
# -------------------------
with open(inp_file, "r") as f:
    lines = f.readlines()

out = open(out_file, "w")

# -------------------------
# Regex patterns
# -------------------------
pattern_instr = re.compile(r"0x([0-9a-fA-F]+).*?: Machine\s+([0-9a-fA-F]+)\s+(\S+)\s+(.*)")
pattern_reg = re.compile(r"\s*(\w+)\s+[0-9a-fA-F]+\s+->\s+([0-9a-fA-F]+)")

# Register name mapping for readability
reg_map = {
    'x0': 'x0', 'x1': 'ra', 'x2': 'sp', 'x3': 'gp', 'x4': 'tp',
    'x5': 't0', 'x6': 't1', 'x7': 't2', 'x8': 's0', 'x9': 's1',
    'x10': 'a0', 'x11': 'a1', 'x12': 'a2', 'x13': 'a3', 'x14': 'a4',
    'x15': 'a5', 'x16': 'a6', 'x17': 'a7', 'x18': 's2', 'x19': 's3',
    'x20': 's4', 'x21': 's5', 'x22': 's6', 'x23': 's7', 'x24': 's8',
    'x25': 's9', 'x26': 's10','x27': 's11','x28': 't3','x29': 't4',
    'x30': 't5','x31': 't6'
}

last_instr_line = ""

# -------------------------
# Parse lines and generate spike.dump
# -------------------------
for line in lines:
    line = line.strip()

    # ---- Instruction line ----
    m_instr = pattern_instr.search(line)
    if m_instr:
        addr = m_instr.group(1)
        opcode = m_instr.group(2)
        mnemonic = m_instr.group(3)
        operands = m_instr.group(4).strip()
        last_instr_line = f"{addr} {opcode} {mnemonic:<10} {operands}"
        out.write(f"{last_instr_line}\n")
        continue

    # ---- Register update ----
    m_reg = pattern_reg.search(line)
    if m_reg:
        reg = m_reg.group(1)
        val = m_reg.group(2)
        reg_name = reg_map.get(reg, reg)
        # Append register and value to last instruction line
        out.write(f"{last_instr_line:<40} {reg_name:<4} 0x{val.zfill(16)}\n")
        continue

out.close()
print(f"Spike dump generated successfully: {out_file}")
