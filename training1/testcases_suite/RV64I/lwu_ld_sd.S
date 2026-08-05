#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32M//macros
RVTEST_CODE_BEGIN//macros

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the load word unsiged and load word  with differeent testcase instructions
la x6,inp_data
 
lwu x7,0(x6)//load word unsigned (0 extend to 64 bit)

test2: 
//li x5,1234abcd
//addiw x9, x5, abcd1234abcd5678
la x6,inp_data

ld  x9,0(x6)
//ld x9. 4(x6) //error (exception trap_load_address_misaligned,)
 test3:
 //load and store doubleword
li x4, 0x1111111106627912
sd x4,8(x6)
ld x11, 8(x6)

 
  TEST_PASSFAIL 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .dword 0x066558f536627935
  .dword 0x5849446c558f5366
  .dword 0x1111111106627912
  .word 0x06627912
 
RVTEST_DATA_END




