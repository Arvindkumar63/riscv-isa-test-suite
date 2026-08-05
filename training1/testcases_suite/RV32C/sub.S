#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# Test 1: x8 = x8 - x9=> 10 - 3 = 7
test1:
    li x8, 10          # Load 10 into x8
    li x9, 3           # Load 3 into x9
    c.sub x8, x9       # x8 = x8 - x9

# Test 2: x9 = x9 - x10 => 5 - (-4) = 9
test2:
    li x9, 5
    li x10, -4
    c.sub x9, x10      # x9 = x9 - x10

# Test 3: x10 = x10 - x10 => 6 - 6 = 0
test3:
    li x10, 6
    c.sub x10, x10     # x10 = x10 - x10

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

