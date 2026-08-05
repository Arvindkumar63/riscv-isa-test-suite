#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3  

# Test 1: Move a positive value from x6 to x8
test1:
  li x6, 1234
  c.mv x8, x6         # x8 = 1234
  addi x9, x8, 0      # x9 = 1234 

# Test 2: Move a negative value from x7 to x10
test2:
  li x7, -5678
  c.mv x10, x7        # x10 = -5678
  addi x11, x10, 0    # x11 = -5678 

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

