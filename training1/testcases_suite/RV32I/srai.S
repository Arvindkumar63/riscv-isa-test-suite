
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV64MF
RVTEST_CODE_BEGIN

li gp, 5  


test1:
li x6, 0xF0000000
srai x8, x6, 4   # x8 = 0xFF000000 (preserve sign =  why the result is 0xFF000000, and we say the shift "preserved the sign.")

test2:
li x6, 0x7FFFFFFF
srai x8, x6, 4   # x8 = 0x07FFFFFF

test3:
li x6, 0xFFFFFFFF
srai x8, x6, 1   # x8 = 0xFFFFFFFF

test4:
li x6, 0x80000000
srai x8, x6, 1   # x8 = 0xC0000000

test5:
li x6, 0x00000001
srai x8, x6, 1   # x8 = 0

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END

