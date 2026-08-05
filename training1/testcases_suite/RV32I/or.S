
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


 test1:
li x6, 0x0         # x6 = 0
li x7, 0x0         # x7 = 0
or x8, x6, x7      # x8 = 0

 test2:
li x6, 0x00000001
li x7, 0x00000010
or x8, x6, x7      # x8 = 0x00000011

 test3:
li x6, 0x55555555
li x7, 0xAAAAAAAA
or x8, x6, x7      # x8 = 0xFFFFFFFF

 test4:
li x6, 0x12345678
li x7, 0x87654321
or x8, x6, x7      # x8 = 0x97755779

 test5:
li x6, 0xFFFFFFFF
li x7, 0x00000000
or x8, x6, x7      # x8 = 0xFFFFFFFF

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
