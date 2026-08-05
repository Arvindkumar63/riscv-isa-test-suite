
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


 test1:
li x6, 0x8       # x6 = 0x8
li x7, 1         # x7 = 1
srl x8, x6, x7   # x8 = 0x4

 test2:
li x6, 0xF0F0F0F0  # x6 = 0xF0F0F0F0
li x7, 4           # x7 = 4
srl x8, x6, x7     # x8 = 0x0F0F0F0F

 test3:
li x6, 0x80000000  # x6 = MSB set
li x7, 31          # x7 = 31
srl x8, x6, x7     # x8 = 0x1

 test4:
li x6, 0xFFFFFFFF  # x6 = all 1s
li x7, 1           # x7 = 1
srl x8, x6, x7     # x8 = 0x7FFFFFFF

 test5:
li x6, 0x12345678  # x6 = 0x12345678
li x7, 8           # x7 = 8
srl x8, x6, x7     # x8 = 0x00123456

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
