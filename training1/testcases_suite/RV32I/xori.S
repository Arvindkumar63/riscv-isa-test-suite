
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 0xAAAAAAAA
xori x8, x6, 0x55555555   # x8 = x6 ^ imm

test2:
li x6, 0xFFFFFFFF
xori x8, x6, 0xFFFFFFFF   # x8 = 0

test3:
li x6, 0
xori x8, x6, 0x12345678   # x8 = 0x12345678

test4:
li x6, 0x0000FFFF
xori x8, x6, 0xFFFF0000   # x8 = 0xFFFFFFFF

test5:
li x6, 0x12345678
xori x8, x6, 0   # x8 = x6
   

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
