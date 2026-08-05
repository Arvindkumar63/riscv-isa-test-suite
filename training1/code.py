regs = [f"x{i}" for i in range(32)]

# ADD combinations
with open("add_combinations.s", "w") as f:
    f.write("# ADD instruction combinations (rd, rs1, rs2)\n")
    for rd in regs:
        for rs1 in regs:
            for rs2 in regs:
                f.write(f"add {rd}, {rs1}, {rs2}\n")

# ADDI combinations with imm = 0x10
with open("addi_combinations.s", "w") as f:
    f.write("# ADDI instruction combinations (rd, rs1, imm=0x10)\n")
    for rd in regs:
        for rs1 in regs:
            f.write(f"addi {rd}, {rs1}, 0x10\n")
