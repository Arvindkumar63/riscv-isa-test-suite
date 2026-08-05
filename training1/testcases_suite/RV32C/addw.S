#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3  # Number of tests

# Test1: Add two small immediate values
test1:
  c.li x8, 5
  c.li x9, 7
  c.addw x8, x9       # x8 = 12

# Test2: Add max 32-bit signed value and 1, test sign extension
test2:
  li x10, 0x7FFFFFFF
  li x11, 1
  c.addw x10, x11     # x10 = -2147483648 (0x80000000 sign-extended to 64-bit)

# Test3: Add negative and positive using li
test3:
  li x12, -20
  c.li x13, 25
  c.addw x12, x13     # x12 = 5

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

