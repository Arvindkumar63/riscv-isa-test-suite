#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
c.li x7,4
   c.addi x7, 2       # x7 =6 

test2:
  li x6, 0x1234
   c.addi x6, 6//x6=0x123a

test3:
  li x6, 0xABCDEF01
  c.addi x6, 0       # x6 = 0xABCDEF01


  test4:
 c.li x6, 0x1
  c.addi x6, 5     # x6 = 0x1234a
  c.addi x6,10

c.addi x26,12


TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

