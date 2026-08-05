#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3

# Test1: Basic subtraction with 32-bit sign-extension
test1:
  li x8, 0x00000010
  li x9, 0x00000004
  c.subw x10, x8, x9   # x10 = 0x0000000C
  addi x11, x10, 0

# Test2: Subtract with negative result
test2:
  li x8, 0x00000005
  li x9, 0x0000000A
  c.subw x12, x8, x9   # x12 = 0xFFFFFFFB (-5)
  addi x13, x12, 0

# Test3: Corner case - result overflows 32-bit signed range
test3:
  li x8, 0x80000000    # -2147483648
  li x9, 0x00000001
  c.subw x14, x8, x9   # x14 = 0x7FFFFFFF
  addi x15, x14, 0

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

