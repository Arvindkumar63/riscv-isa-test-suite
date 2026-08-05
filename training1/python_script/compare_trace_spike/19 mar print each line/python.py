import sys
import re

# ------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------
STOP_ON_FIRST_FAIL = False
LOG_FILE = "compare.log"

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

        operands = parts[7] if len(parts) > 7 else ""
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
            "time": time_v,
            "cycle": cycle,
            "mode": mode,
            "pc": pc,
            "opcode": opcode,
            "instr": instr.strip(),
            "rd": rd,
            "value": value
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

        spike.append({
            "pc": m.group(1).lower(),
            "opcode": m.group(2).replace("0x",""),
            "rd": m.group(3) if m.group(3) else "",
            "value": m.group(4).lower() if m.group(4) else ""
        })

# ------------------------------------------------------------
# COMPARE + LOG
# ------------------------------------------------------------
min_len = min(len(rtl), len(spike))
first_fail = None

with open(LOG_FILE, "w") as log:

    log.write("=========== COMPARE LOG ===========\n\n")

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
                first_fail = i + 1

        # Main line log
        log.write(
            f"{i+1} {r['time']} {r['cycle']} {r['mode']} "
            f"{r['pc']} {r['opcode']} {r['instr']} "
            f"{r['rd']} {r['value']} {status}\n"
        )

        # Mismatch details
        if status == "FAIL":
            log.write("---- MISMATCH DETAILS ----\n")

            if not pc_match:
                log.write(f"PC RTL : {r['pc']}   REF : {s['pc']}\n")

            if not opcode_match:
                log.write(f"OPCODE RTL : {r['opcode']}   REF : {s['opcode']}\n")

            if not reg_match:
                log.write(f"REGISTER RTL : {r['rd']}   REF : {s['rd']}\n")

            if not val_match:
                log.write(f"VALUE RTL : {r['value']}   REF : {s['value']}\n")

            log.write("---------------------------\n\n")

            if STOP_ON_FIRST_FAIL:
                break

    # ------------------------------------------------------------
    # FINAL SUMMARY
    # ------------------------------------------------------------
    inst_retired = min_len
    test_status = "PASS" if mismatch_count == 0 else "FAIL"

    last_instr_time = rtl[min_len - 1]["time"] if min_len > 0 else "0ns"

    log.write("\n=========== SUMMARY ===========\n")
    log.write(f"fatal   : {fatal}\n")
    log.write(f"error   : {error}\n")
    log.write(f"warning : {warning}\n\n")

    log.write(f"Instructions Retired : {inst_retired}\n")

    if first_fail:
        log.write(f"First mismatch       : instruction {first_fail}\n")

    log.write(f"Total mismatches     : {mismatch_count}\n\n")
    log.write(f"TEST STATUS          : {test_status}\n")
    log.write(f"Last instruction time: {last_instr_time}\n")
    log.write("=================================\n")