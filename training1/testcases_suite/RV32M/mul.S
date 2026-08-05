#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  li gp,3 
 
test1: //multiply unsigned * unsigned
//The test intension is to test the mul instructions
li x6,0x1234abcd2bcd1234

li x8,0x2bcd12342bcd1234

mul x7,x6,x8
mulhu x7,x6,x8

test2://multiply signed * signed
li x6,0xf234abcd2bcd1234

li x8, 0xfbcd12342bcd1234

mul x7,x6,x8
mulhu x7,x6,x8


test3://multiply signed * unsigned
li x6,0xf234abcd2bcd1234

li x8, 0x5bcd12342bcd1234

mul x7,x6,x8
mulhsu x7,x6,x8


  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END





