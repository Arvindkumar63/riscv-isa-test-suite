import os
import subprocess

TEST_DIR = "tests"

tests = sorted([f for f in os.listdir(TEST_DIR) if f.endswith(".S")])
print("Found testcases:")
for t in tests:
    print(" -", t)
print("----------------------------------")

for t in tests:
    print(f"Running {t}...")
    
    cmd = ["bash", "run_test.sh", t]
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    out, err = process.communicate()
    
    print(out.decode())
    print(err.decode())
    print("----------------------------------")
