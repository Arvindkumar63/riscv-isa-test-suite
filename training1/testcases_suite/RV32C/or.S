#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3 

# Test 1: OR with one operand as zero
test1:
  c.li x8, 0x0         # x8 = 0x0
  c.li x9, 0xF         # x9 = 0xF
  c.or x10, x8         # x10 = x10 | x8 => 0 | 0 = 0
  c.or x10, x9         # x10 = 0 | 0xF = 0xF
  addi x11, x10, 0     # x11 = 0xF (check)

# Test 2: OR two positive numbers
test2:
  c.li x8, 0x0F        # x8 = 0x0F
  c.li x9, 0xF0        # x9 = 0xF0
  c.or x10, x8         # x10 = x10 | x8 => 0 | 0x0F
  c.or x10, x9         # x10 = 0x0F | 0xF0 = 0xFF
  addi x11, x10, 0     # x11 = 0xFF (check)


  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

