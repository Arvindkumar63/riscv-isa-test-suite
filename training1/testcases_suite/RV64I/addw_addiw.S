#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M//macros
RVTEST_CODE_BEGIN//macros

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the addiw rv64i instructions
li x5, 0x1234abcd1234ef12
addiw x7,x5,66

 
 test2:
 //addw rv64i instructions
li x4, 0x1111111106627912
li x5, 0x1234abcd1234ef12

addw x8,x4,x5
 
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





