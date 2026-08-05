#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3 

# Test 1: Load small positive immediate
test1:
  c.li x9, 5          # x9 = 5
  addi x10, x9, 0     # x10 = 5 (copy for check)

# Test 2: Load negative immediate
test2:
  c.li x10, -7        # x10 = -7 (0xFFFFFFFFFFFFFFF9)
  addi x11, x10, 0    # x11 = -7 (copy for check)



  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

