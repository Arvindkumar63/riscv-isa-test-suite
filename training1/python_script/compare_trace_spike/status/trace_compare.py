import sys
import re
import time

# ------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------
STOP_ON_FIRST_FAIL = False

# ------------------------------------------------------------
# COLOR OUTPUT
# ------------------------------------------------------------
class Color:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    END = '\033[0m'

# ------------------------------------------------------------
# START TIMER
# ------------------------------------------------------------
start_time = time.time()

# ------------------------------------------------------------
# ARGUMENT CHECK
# ------------------------------------------------------------
if len(sys.argv) != 3:
    print(f"Usage: python3 {sys.argv[0]} <trace_rtl.log> <spike_tb.log>")
    sys.exit(1)

trace_file = sys.argv[1]
spike_file = sys.argv[2]

# ------------------------------------------------------------
# REGISTER MAP
# ------------------------------------------------------------
reg_map = {
"ra":"x1","sp":"x2","gp":"x3","tp":"x4",
"t0":"x5","t1":"x6","t2":"x7",
"s0":"x8","fp":"x8","s1":"x9",
"a0":"x10","a1":"x11","a2":"x12","a3":"x13",
"a4":"x14","a5":"x15","a6":"x16","a7":"x17",
"s2":"x18","s3":"x19","s4":"x20","s5":"x21",
"s6":"x22","s7":"x23","s8":"x24","s9":"x25",
"s10":"x26","s11":"x27",
"t3":"x28","t4":"x29","t5":"x30","t6":"x31"
}

# ------------------------------------------------------------
# ERROR COUNTERS
# ------------------------------------------------------------
fatal = 0
error = 0
warning = 0
mismatch_count = 0

# ------------------------------------------------------------
# PARSE RTL TRACE
# ------------------------------------------------------------
rtl = []

with open(trace_file) as f:
    for line in f:

        if "fatal" in line.lower():
            fatal += 1
        if "error" in line.lower():
            error += 1
        if "warning" in line.lower():
            warning += 1

        parts = line.strip().split()

        if len(parts) < 7:
            continue

        time_v = parts[0]
        cycle = parts[1]
        mode = parts[2]
        pc = "0x" + parts[3].lower()
        opcode = parts[5]
        mnemonic = parts[6]

        operands = ""
        if len(parts) > 7:
            operands = parts[7]

        instr = mnemonic + " " + operands

        rd = ""
        value = ""

        if ":" in line:
            try:
                reg = line.split(":")[0].split()[-1]
                val = line.split(":")[1].strip()

                rd = reg_map.get(reg, reg)
                value = "0x" + val.lower()
            except:
                pass

        rtl.append({
            "time":time_v,
            "cycle":cycle,
            "mode":mode,
            "pc":pc,
            "opcode":opcode,
            "instr":instr.strip(),
            "rd":rd,
            "value":value
        })

# ------------------------------------------------------------
# PARSE SPIKE TRACE
# ------------------------------------------------------------
pattern = re.compile(
r"core\s+\d+:\s+\d+\s+(0x[0-9a-fA-F]+)\s+\((0x[0-9a-fA-F]+)\)\s*(x\d+)?\s*(0x[0-9a-fA-F]+)?"
)

spike = []

with open(spike_file) as f:
    for line in f:

        m = pattern.search(line)

        if not m:
            continue

        pc = m.group(1).lower()
        opcode = m.group(2).replace("0x","")

        rd = ""
        val = ""

        if m.group(3):
            rd = m.group(3)

        if m.group(4):
            val = m.group(4).lower()

        spike.append({
            "pc":pc,
            "opcode":opcode,
            "rd":rd,
            "value":val
        })

# ------------------------------------------------------------
# COMPARE
# ------------------------------------------------------------
min_len = min(len(rtl), len(spike))
first_fail = None

for i in range(min_len):

    r = rtl[i]
    s = spike[i]

    pc_match = r["pc"] == s["pc"]
    opcode_match = r["opcode"] == s["opcode"]
    reg_match = r["rd"] == s["rd"]
    val_match = r["value"] == s["value"]

    status = "PASS"

    if not (pc_match and opcode_match and val_match):
        status = "FAIL"
        mismatch_count += 1

        if first_fail is None:
            first_fail = i+1

    color = Color.GREEN if status=="PASS" else Color.RED

    print(color +
          f"{i+1} {r['time']} {r['cycle']} {r['mode']} {r['pc']} {r['opcode']} {r['instr']} {r['rd']} {r['value']} {status}"
          + Color.END)

    if status == "FAIL":

        print(Color.YELLOW + "\n---- MISMATCH DETAILS ----")

        if not pc_match:
            print(f"PC RTL : {r['pc']}   REF : {s['pc']}")

        if not opcode_match:
            print(f"OPCODE RTL : {r['opcode']}   REF : {s['opcode']}")

        if not reg_match:
            print(f"REGISTER RTL : {r['rd']}   REF : {s['rd']}")

        if not val_match:
            print(f"VALUE RTL : {r['value']}   REF : {s['value']}")

        print("---------------------------\n" + Color.END)

        if STOP_ON_FIRST_FAIL:
            break

# ------------------------------------------------------------
# FINAL SUMMARY
# ------------------------------------------------------------
inst_retired = min_len
test_status = "PASS" if mismatch_count == 0 else "FAIL"

end_time = time.time()
time_taken = round(end_time - start_time,3)

print("\n=================================")
print(f"fatal   : {fatal}")
print(f"error   : {error}")
print(f"warning : {warning}")
print("")

print(f"Instructions Retired : {inst_retired}")

if first_fail:
    print(f"First mismatch       : instruction {first_fail}")

print(f"Total mismatches     : {mismatch_count}")

print("")
print(f"TEST STATUS          : {test_status}")
print(f"time taken           : {time_taken} seconds")
print("=================================")
