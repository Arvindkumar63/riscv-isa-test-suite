import re
import sys
import pandas as pd

# ----------- PARSE RTL LOG ----------------
def parse_rtl_log(file):
    rtl_data = []

    with open(file, "r") as f:
        for line in f:
            # Example parsing pattern (adjust if needed)
            match = re.search(r'(\d+)\s+(\d+)\s+(\w)\s+(0x[0-9a-fA-F]+)\s+\((0x[0-9a-fA-F]+)\)\s+(\w+)\s+(\w+)\s+(0x[0-9a-fA-F]+)', line)

            if match:
                rtl_data.append({
                    "time": match.group(1),
                    "cycle": match.group(2),
                    "mode": match.group(3),
                    "pc": match.group(4),
                    "opcode": match.group(5),
                    "instruction": match.group(6),
                    "rd": match.group(7),
                    "value": match.group(8)
                })

    return rtl_data


# ----------- PARSE SPIKE LOG ----------------
def parse_spike_log(file):
    spike_data = []

    with open(file, "r") as f:
        for line in f:
            match = re.search(r'(0x[0-9a-fA-F]+)\s+\((0x[0-9a-fA-F]+)\)\s+(\w+)\s+(\w+)\s+(0x[0-9a-fA-F]+)', line)

            if match:
                spike_data.append({
                    "pc": match.group(1),
                    "opcode": match.group(2),
                    "instruction": match.group(3),
                    "rd": match.group(4),
                    "value": match.group(5)
                })

    return spike_data


# ----------- COMPARISON ----------------
def compare_logs(rtl_data, spike_data):

    # Create opcode dictionary for spike
    spike_dict = {entry["opcode"]: entry for entry in spike_data}

    results = []
    sl_no = 1

    for rtl in rtl_data:

        opcode = rtl["opcode"]
        spike = spike_dict.get(opcode)

        if spike:
            pc_match = rtl["pc"] == spike["pc"]
            instr_match = rtl["instruction"] == spike["instruction"]
            rd_match = rtl["rd"] == spike["rd"]
            val_match = rtl["value"] == spike["value"]

            if pc_match and instr_match and rd_match and val_match:
                result = "PASS"
            else:
                result = "FAIL"
        else:
            result = "FAIL"

        results.append({
            "sl.no": sl_no,
            "time": rtl["time"],
            "cycle": rtl["cycle"],
            "mode": rtl["mode"],
            "pc value": rtl["pc"],
            "opcode": rtl["opcode"],
            "instruction": rtl["instruction"],
            "pneumonics": rtl["instruction"],
            "rd": rtl["rd"],
            "value": rtl["value"],
            "result": result
        })

        sl_no += 1

    return results


# ----------- MAIN ----------------
def main():

    if len(sys.argv) < 4:
        print("Usage: python3 compare_logs.py trace_rtl.log spike_tb.log output.xlsx")
        sys.exit(1)

    rtl_file = sys.argv[1]
    spike_file = sys.argv[2]
    output_file = sys.argv[3]

    rtl_data = parse_rtl_log(rtl_file)
    spike_data = parse_spike_log(spike_file)

    results = compare_logs(rtl_data, spike_data)

    df = pd.DataFrame(results)

    df.to_excel(output_file, index=False)

    print("Comparison completed.")
    print(f"Output saved to {output_file}")


if __name__ == "__main__":
    main()