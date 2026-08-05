#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# Test 1: Branch taken (x8 = 0)
test1:
    c.li x8, 0
    c.beqz x8, label1     # Taken branch
    c.addi x8, 1          # Skipped
label1:
    c.addi x12, 10        # Executed

# Test 2: Branch not taken (x8 = 2)
test2:
    c.li x8, 2
    c.beqz x8, label2     # Not taken
    c.addi x11, 5         # Executed
    c.addi x12, 4         # Executed
label2:
    c.addi x12, 10        # Executed

# Test 3: Branch taken using la (x8 = 0)
test3:
    c.li x8, 0
    la x10, label3
    c.beqz x8, label3     # Taken branch
    c.addi x10, 1         # Skipped
c.addi x13,20
c.addi x14,10
label3:
    c.addi x12, 20        # Executed

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

