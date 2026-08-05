#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3
 
test1: 
//The test intension is to test the mul instructions (unsigned * unsigned)
li x6,0x1234abcd2bcd1234

li x8,0x2bcd12342bcd1234

mulw x7,x6,x8

test2://multiply signed * signed
li x6,0xf234abcd00012345

li x8, 0xfbcd12340000abcd

mulw x7,x6,x8

test3:

li x2, 0x12345     # rs1
li x3, 0xABCD      # rs2
mul x4, x2, x3     # x4 = x2 * x3 = 0x12345 * 0xABCD = 0x0000000012345ABD

 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END






