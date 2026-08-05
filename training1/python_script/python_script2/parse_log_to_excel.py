`# ------------------------------------------------------------
# Import required Python standard libraries and packages
# ------------------------------------------------------------

import os              # For interacting with operating system paths
import sys             # For reading command-line arguments (sys.argv)
import re              # For using regular expressions to parse text
import pandas as pd    # For creating Excel sheets easily using DataFrame
from openpyxl import load_workbook                  # For opening Excel file again
from openpyxl.styles import Font, Alignment         # For formatting Excel headers


# ------------------------------------------------------------
# Check that exactly TWO command-line arguments are provided
# (input_log and output_spike)
#
# Example usage:
#   python3 script.py input.log out.dump
#
# sys.argv[0] = script name
# sys.argv[1] = input log
# sys.argv[2] = output dump file
# ------------------------------------------------------------
if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <input_log> <output_spike>")
    sys.exit(1)        # Exit if wrong arguments given


# ------------------------------------------------------------
# Store the two arguments into easy variable names
# Also derive Excel file name automatically
# ------------------------------------------------------------
inp_file = sys.argv[1]                      # Input spike log
out_file = sys.argv[2]                      # Output spike dump
excel_file = out_file.replace('.dump', '.xlsx')  # Change .dump to .xlsx


# ------------------------------------------------------------
# Open and read the entire input log file line-by-line
# readlines() returns a list where each element is one log line
# ------------------------------------------------------------
with open(inp_file, "r") as f:
    lines = f.readlines()


# ------------------------------------------------------------
# Define regular expression (regex) patterns for:
# 1) Instruction lines
# 2) Register update lines
#
# Regex is used because spike log format is irregular and needs pattern matching.
# ------------------------------------------------------------

# -------------------------
# pattern_instr explanation:
# -------------------------
# Example spike line:
# 0x0000000080000000: Machine 00000513 addi a0,a0,1
#
# 0x([0-9a-fA-F]+)   ? capture PC address (hex number after 0x)
# .*?:               ? skip anything until colon
# Machine\s+         ? literal word "Machine" + 
#                    \s= after that one whitespace is there, + \S = Matches any character that is NOT whitespace.
# ([0-9a-fA-F]+)     ? capture instruction opcode in hex
# (\S+)              ? capture mnemonic (e.g., addi, lw, jal)
# (.*)               ? capture all operands
# ------------------------------------------------------------
pattern_instr = re.compile(
    r"0x([0-9a-fA-F]+).*?: Machine\s+([0-9a-fA-F]+)\s+(\S+)\s+(.*)"
)

# -------------------------
# pattern_reg explanation:
# -------------------------
# Matches a register update line like:
#   x10 00000000 -> 00000005
#
# (\w+)           ? register name
# ([0-9a-fA-F]+)  ? old value
# ([0-9a-fA-F]+)  ? new value
# ------------------------------------------------------------
pattern_reg = re.compile(
    r"\s*(\w+)\s+([0-9a-fA-F]+)\s+->\s+([0-9a-fA-F]+)"
)


# ------------------------------------------------------------
# Storage for:
# 1) Final spike.dump formatted lines
# 2) Excel table rows
# ------------------------------------------------------------
spike_lines = []      # List of strings; each string = formatted spike.dump line
excel_data = []       # List of dict entries; will be converted into DataFrame

current_instr = None  # Temporary holder for the latest instruction until register update arrives


# ------------------------------------------------------------
# MAIN PARSING LOOP
#
# For each line in log:
#   - Detect instruction line
#   - Save it in current_instr
#   - Detect register update line
#   - Combine both and store output
# ------------------------------------------------------------
for line in lines:
    line = line.strip()    # Remove whitespace/newline


    # --------------------------------------------------------
    # 1) INSTRUCTION LINE DETECTED
    # --------------------------------------------------------
    m_instr = pattern_instr.search(line)
    if m_instr:

        # Extract captured fields from regex groups
        addr     = m_instr.group(1)   # instruction address
        opcode   = m_instr.group(2)   # machine code / opcode
        mnemonic = m_instr.group(3)   # instruction name (e.g., add, lw)
        operands = m_instr.group(4).strip()   # operands (rd, rs1, rs2 etc.)

        # Store instruction temporarily until we get the register change
        current_instr = {
            'address': addr,
            'opcode': opcode,
            'mnemonic': mnemonic,
            'operands': operands,
            'reg_name': '',
            'reg_value': ''
        }
        continue   # Move to next line


    # --------------------------------------------------------
    # 2) REGISTER UPDATE LINE DETECTED
    # --------------------------------------------------------
    m_reg = pattern_reg.search(line)
    if m_reg and current_instr:

        reg     = m_reg.group(1)     # Register name (x0, x1, ...)
        old_val = m_reg.group(2)     # Previous value
        new_val = m_reg.group(3)     # Updated value


        # Skip CSR or memory updates (Not required for dump)
        if reg.startswith(('MEMW', 'MEMR', 'mie', 'hie', 'vsie', 'mip')):
            continue


        # ----------------------------------------------------
        # No ABI mapping used (as requested)
        # Keep register name same
        # ----------------------------------------------------
        reg_name = reg


        # ----------------------------------------------------
        # Format spike.dump line as:
        #
        # <address> <opcode> <mnemonic> <operands> <reg> <value>
        #
        # Example:
        # 80000000 00000513 addi a0,a0,1     x10 0x0000000000000005
        #
        # zfill(16) ensures 64-bit hex width
        # ----------------------------------------------------
        spike_line = (
            f"{current_instr['address']} "
            f"{current_instr['opcode']} "
            f"{current_instr['mnemonic']:<10} "
            f"{current_instr['operands']:<20} "
            f"{reg_name:<4} "
            f"0x{new_val.zfill(16)}"
        )

        spike_lines.append(spike_line)



        # ----------------------------------------------------
        # Save row for Excel file
        # ----------------------------------------------------
        excel_data.append({
            'Address': f"0x{current_instr['address']}",
    'Opcode': current_instr['opcode'],

    # NEW FIELD: Combined instruction
    'Instruction': f"{current_instr['mnemonic']} {current_instr['operands']}",

    'Register': reg_name,
    'Value': f"0x{new_val.zfill(16)}"
        })

        # Clear instruction buffer
        current_instr = None



# ------------------------------------------------------------
# WRITE spike.dump OUTPUT FILE
# ------------------------------------------------------------
with open(out_file, "w") as out:
    for line in spike_lines:
        out.write(line + "\n")

print(f"Spike dump generated: {out_file}")



# ------------------------------------------------------------
# GENERATE EXCEL FILE (if any entries found)
# ------------------------------------------------------------
if excel_data:

    # Convert list of dicts ? DataFrame ? Excel
    df = pd.DataFrame(excel_data)
    df.to_excel(excel_file, index=False, sheet_name='Instructions') ## need

    # Open the Excel file again to apply formatting
    wb = load_workbook(excel_file)
    ws = wb.active

    # Make header row bold and center aligned
    header_font = Font(bold=True)
    for cell in ws[1]:
        cell.font = header_font
        cell.alignment = Alignment(horizontal='center')

    # Adjust column widths for readability
    ws.column_dimensions['A'].width = 20   # Address
    ws.column_dimensions['B'].width = 12   # Opcode
    ws.column_dimensions['C'].width = 12   # Mnemonic
    ws.column_dimensions['D'].width = 25   # Operands
    ws.column_dimensions['E'].width = 10   # Register
    ws.column_dimensions['F'].width = 20   # Value

    wb.save(excel_file)
    wb.save(excel_file)
    print(f"[OK] Excel file generated: {excel_file}")

else:
    print("[INFO] No Excel data found.")
