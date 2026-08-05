
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 0xAAAAAAAA
ori x8, x6, 0x55555555   # x8 = x6 | imm = 0xFFFFFFFF

test2:
li x6, 0x00000000
ori x8, x6, 0x0000FFFF   # x8 = 0x0000FFFF

test3:
li x6, 0x12345678
ori x8, x6, 0   # x8 = x6

test4:
li x6, 0xF0F0F0F0
ori x8, x6, 0x0F0F0F0F   # x8 = 0xFFFFFFFF

test5:
li x6, 0xFFFFFFFF
ori x8, x6, 0x0   # x8 = x6   

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
