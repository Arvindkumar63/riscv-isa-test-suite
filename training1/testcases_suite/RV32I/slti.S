
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 1
slti x8, x6, 2    # x8 = (x6 < 2) = 1

test2:
li x6, 10
slti x8, x6, 5    # x8 = (10 < 5) = 0

test3:
li x6, -1
slti x8, x6, 0    # x8 = (-1 < 0) = 1



test5:
li x6, 0
slti x8, x6, 0    # x8 = 0

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
