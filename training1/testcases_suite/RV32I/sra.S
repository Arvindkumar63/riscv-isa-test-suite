
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5  


start:
# Register to Register Addition
li x6, 16          # x6 = 16
li x7, 2         # x7 = 2
sra x8, x6, x7     # x8 = x6 >> x7 =28

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
