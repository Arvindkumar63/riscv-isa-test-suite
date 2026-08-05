
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  

 test1:
li x6, 0x0         # x6 = 0
li x7, 0x1         # x7 = 1
sltu x8, x6, x7    # x8 = 1

 test2:
li x6, 0xFFFFFFFF  # max unsigned
li x7, 0x0         # x7 = 0
sltu x8, x6, x7    # x8 = 0

 test3:
li x6, 0x7FFFFFFF  # signed max = 0x7FFFFFFF = 2,147,483,647 (in both signed and unsigned)
li x7, 0x80000000  # signed min = -2,147,483,648
sltu x8, x6, x7    # x8 = 1

 test4:
li x6, 0x12345678
li x7, 0x12345678
sltu x8, x6, x7    # x8 = 0

 test5:
li x6, 0xDEADBEEF
li x7, 0xDEADBEF0
sltu x8, x6, x7    # x8 = 1


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END

