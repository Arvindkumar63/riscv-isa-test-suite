#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
  li x6, 2
  li x7, 1
  sub x8, x6, x7       # x8 = 1

test2:
  li x6, 54321
  li x7, 12345
  sub x8, x6, x7       # x8 = 41976

test3:
  li x6, 0xABCDEF01
  li x7, 0
  sub x8, x6, x7       # x8 = 0xABCDEF01

test4:
  li x6, 0x7FFFFFFF
  li x7, -1
  sub x8, x6, x7       # x8 = 0x80000000 (overflow wrap)

test5:
  li x6, 5
  li x7, 5
  sub x8, x6, x7       # x8 = 0

TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

