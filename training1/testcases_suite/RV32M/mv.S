#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U//macros
RVTEST_CODE_BEGIN//macros

  li gp, 3// global pointer
 
test1:
//The test intension is to test the move instructions
li x6,40
mv x7,x6

test2:
li x8,0x1234abcd
mv x9,x8
 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END







