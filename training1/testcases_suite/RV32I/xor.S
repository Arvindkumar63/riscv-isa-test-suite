
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


 test1:
li x6, 0xFF00FF00
li x7, 0x00FF00FF
xor x8, x6, x7    # x8 = 0xFFFFFFFF

 test2:
li x6, 0xABCDEF12
li x7, 0x12345678
xor x8, x6, x7    # x8 = 0xB99F998A

 test3:
li x6, 0x00000000
li x7, 0xFFFFFFFF
xor x8, x6, x7    # x8 = 0xFFFFFFFF

test4:
li x6, 0x0
li x7, 0x0
xor x8, x6, x7    # x8 = 0

 test5:
li x6, -1
li x7, -1
xor x8, x6, x7    # x8 = 0


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
