#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN


test1:
  c.li x6, 4
   c.add x7,x6 

test2:
  c.li x6,2
  c.add x8,x6

test3:
  c.li x6, 0xF
  c.li x5,3
  c.add x6, x5      


TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END


