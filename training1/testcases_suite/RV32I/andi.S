
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 0x1
slli x8, x6, 1   # x8 = 2

test2:
li x6, 0x12345678
slli x8, x6, 4   # x8 = 0x23456780

test3:
li x6, 0xFFFFFFFF
slli x8, x6, 1   # x8 = 0xFFFFFFFE

test4:
li x6, 0x80000000
slli x8, x6, 1   # x8 = 0x00000000 (overflow out of MSB)

test5:
li x6, 0x1
slli x8, x6, 31   # x8 = 0x80000000

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END
