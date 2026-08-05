
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  

 test1:
li x6, -1          # x6 = -1
li x7, 1           # x7 = 1
slt x8, x6, x7     # x8 = 1

 test2:
li x6, 0x7FFFFFFF  # max positive
li x7, -1          # x7 = -1
slt x8, x6, x7     # x8 = 0

 test3:
li x6, 0           # x6 = 0
li x7, 0           # x7 = 0
slt x8, x6, x7     # x8 = 0

 test4:
li x6, -100        # x6 = -100
li x7, -99         # x7 = -99
slt x8, x6, x7     # x8 = 1

 test5:
li x6, 100         # x6 = 100
li x7, 100         # x7 = 100
slt x8, x6, x7     # x8 = 0


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
