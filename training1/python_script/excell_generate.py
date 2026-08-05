import os
import sys
import re
import pandas as pd
from openpyxl 
#from openpyxl.styles import Font, Alignment

# -------------------------
# Check command-line arguments
# -------------------------
if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <input_log> <output_spike>")
    sys.exit(1)

inp_file = sys.argv[1]
out_file = sys.argv[2]
excel_file = out_file.replace('.dump', '.xlsx')

# -------------------------
# Open input log
# -------------------------
with open(inp_file, "r") as f:
    lines = f.readlines()

# -------------------------
# Regex patterns
# -------------------------
pattern_instr = re.compile(r"0x([0-9a-fA-F]+).*?: Machine\s+([0-9a-fA-F]+)\s+(\S+)\s+(.*)")
pattern_reg = re.compile(r"\s*(\w+)\s+([0-9a-fA-F]+)\s+->\s+([0-9a-fA-F]+)")

# Register name mapping
reg_map = {
    'x0': 'x0', 'x1': 'ra', 'x2': 'sp', 'x3': 'gp', 'x4': 'tp',
    'x5': 't0', 'x6': 't1', 'x7': 't2', 'x8': 's0', 'x9': 's1',
    'x10': 'a0', 'x11': 'a1', 'x12': 'a2', 'x13': 'a3', 'x14': 'a4',
    'x15': 'a5', 'x16': 'a6', 'x17': 'a7', 'x18': 's2', 'x19': 's3',
    'x20': 's4', 'x21': 's5', 'x22': 's6', 'x23': 's7', 'x24': 's8',
    'x25': 's9', 'x26': 's10', 'x27': 's11', 'x28': 't3', 'x29': 't4',
    'x30': 't5', 'x31': 't6'
}

# -------------------------
# Storage for parsed data
# -------------------------
spike_lines = []
excel_data = []

current_instr = None

# -------------------------
# Parse lines
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
        
        current_instr = {
            'address': addr,
            'opcode': opcode,
            'mnemonic': mnemonic,
            'operands': operands,
            'reg_name': '',
            'reg_value': ''
        }
        continue

    # ---- Register update ----
    m_reg = pattern_reg.search(line)
    if m_reg and current_instr:
        reg = m_reg.group(1)
        old_val = m_reg.group(2)
        new_val = m_reg.group(3)
        
        # Skip CSR and MEM lines
        if reg.startswith(('MEMW', 'MEMR', 'mie', 'hie', 'vsie', 'mip')):
            continue
            
        reg_name = reg_map.get(reg, reg)
        
        # Format spike.dump line
        spike_line = f"{current_instr['address']} {current_instr['opcode']} {current_instr['mnemonic']:<10} {current_instr['operands']:<20} {reg_name:<4} 0x{new_val.zfill(16)}"
        spike_lines.append(spike_line)
        
        # Store for Excel
        excel_data.append({
            'Address': f"0x{current_instr['address']}",
            'Opcode': current_instr['opcode'],
            'Mnemonic': current_instr['mnemonic'],
            'Operands': current_instr['operands'],
            'Register': reg_name,
            'Value': f"0x{new_val.zfill(16)}"
        })
        
        current_instr = None

# -------------------------
# Generate spike.dump
# -------------------------
with open(out_file, "w") as out:
    for line in spike_lines:
        out.write(line + "\n")

print(f"Spike dump generated: {out_file}")

# -------------------------
# Generate Excel file
# -------------------------
if excel_data:
    df = pd.DataFrame(excel_data)
    df.to_excel(excel_file, index=False, sheet_name='Instructions')
    
    # Format the Excel file
    wb = load_workbook(excel_file)
    ws = wb.active
    
    # Format headers
    header_font = Font(bold=True)
    for cell in ws[1]:
        cell.font = header_font
        cell.alignment = Alignment(horizontal='center')
    
    # Adjust column widths
    ws.column_dimensions['A'].width = 20
    ws.column_dimensions['B'].width = 12
    ws.column_dimensions['C'].width = 12
    ws.column_dimensions['D'].width = 25
    ws.column_dimensions['E'].width = 10
    ws.column_dimensions['F'].width = 20
    
    wb.save(excel_file)
    print(f"Excel file generated: {excel_file}")
else:
    print("No data to generate Excel file")