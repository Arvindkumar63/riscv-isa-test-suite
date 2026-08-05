#!/usr/bin/env python3

import os
import subprocess
import shutil

# Training root directory
TRAINING_HOME = "/home/arvindk/training"

# Regression output directory
REG_NAME = "reg1"
LOG_DIR = os.path.join(
    TRAINING_HOME,
    "regression",
    "my_logs",
    REG_NAME
)

os.makedirs(LOG_DIR, exist_ok=True)

# List of tests to run
TESTS = [
    "add",
    "sub",
    "and"
]

PASS = 0
FAIL = 0

for test_name in TESTS:

    print("\n" + "="*60)
    print(f"Running Test : {test_name}")
    print("="*60)

    try:

        result = subprocess.run(
            ["./run_script.sh", test_name, "rv64"],
            cwd=TRAINING_HOME
        )

        elf_src = os.path.join(
            TRAINING_HOME,
            "work",
            test_name,
            f"{test_name}.elf"
        )

        elf_dst = os.path.join(
            LOG_DIR,
            f"{test_name}.elf"
        )

        if result.returncode == 0 and os.path.exists(elf_src):

            shutil.copy2(elf_src, elf_dst)

            print(f"PASS : {test_name}")
            PASS += 1

        else:

            print(f"FAIL : {test_name}")
            FAIL += 1

    except Exception as e:

        print(f"ERROR : {test_name}")
        print(e)
        FAIL += 1

print("\n")
print("="*60)
print("REGRESSION SUMMARY")
print("="*60)
print(f"PASS  : {PASS}")
print(f"FAIL  : {FAIL}")
print(f"TOTAL : {PASS + FAIL}")
print("="*60)