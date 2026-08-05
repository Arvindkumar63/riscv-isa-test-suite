#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3  

# Test1: Load upper immediate to x9
test1:
  c.lui x9, 0x5       # x9 = 0x00005000

# Test2: Load negative upper immediate to x10
test2:
  c.lui x10, 0Xf      # x10 = 0xF000

# Test3: Load upper 12-bit value to x11
test3:
  c.lui x11, 12    # x11 = 0x0000c000

# Test4: Invalid - c.lui with rd = x0 or rd =x2 (should be rejected by assembler)
test4:
  c.lui x0, 0x4       # INVALID

//test5:

  //c.lui x2, 3      # INVALID//Error: illegal operands `c.lui x2,3'



  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

