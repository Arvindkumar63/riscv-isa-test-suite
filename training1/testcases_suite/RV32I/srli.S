
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 0x12345678
srli x8, x6, 1   # x8 = 0x091A2B3C

test2:
li x6, 0xFFFFFFFF
srli x8, x6, 4   # x8 = 0x0FFFFFFF

test3:
li x6, 0x80000000
srli x8, x6, 31   # x8 = 1

test4:
li x6, 0x00000001
srli x8, x6, 1   # x8 = 0

test5:
li x6, 0xF0000000
srli x8, x6, 28   # x8 = 0x0000000F

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END

