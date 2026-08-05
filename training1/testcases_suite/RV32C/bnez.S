#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# Test 1: Branch should be taken (x9 ≠ 0)
test1:
    c.li x9, 5
    la x10, label1
    c.bnez x9, label1     # Taken branch
    c.addi x9, 1          # Skipped
label1:
    c.addi x12, 10        # Executed

# Test 2: Branch should NOT be taken (x9 = 0)
test2:
    c.li x9, 0
    c.bnez x9, label2     # Not taken
    c.addi x11, 5         # Executed
    c.addi x12, 4         # Executed
label2:
    c.addi x12, 10        # Executed

# Test 3: Using `la` for target label address (branch taken)
test3:
    c.li x10, 7
    la x11, label3
    c.bnez x10, label3    # Taken branch
    c.addi x10, 1         # Skipped
label3:
    c.addi x12, 20        # Executed

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

