#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
 c.li x9,7 
  c.andi x9, 0xF    # x9 = 0x000F

test2:
  li x8, 0xFFFFFFFF
  c.andi x8, 0       # x8 = 0

test3:
  li x9, 0x55555555
//c.li x9,2

 // c.andi x9, 32 //imm more than 5 bit giving error
c.andi x9, 12  //x9=12

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

