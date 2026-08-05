#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
c.li x8,2
c.li x9,4
c.and x9,x8

test2:
//c.li x8, 0xFF// Error: illegal operands `c.li x8,0xFF'
li x8,0xFF
  c.li x9, 0
  c.and x9, x8       # x6 = 0x00000000

test3:
  c.li x8, 0x5
  c.li x9, 0xA
  c.and x9, x8       # x6 = 0

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

