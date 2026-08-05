#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

# Test 1: Arithmetic shift -4 >> 1 → -2
test1:
    c.li x8, -4
    c.srai x8, 1
    c.addi x9, 1

# Test 2: Arithmetic shift -16 >> 2 → -4
test2:
    c.li x9, -16
    c.srai x9, 2
    c.addi x10, 2

# Test 3: Corner case – shift -1 (0xFFFFFFFF) >> 31 → -1
test3:
    li x10, 0xFFFFFFFF
    c.srai x10, 31
    c.addi x11, 3

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

