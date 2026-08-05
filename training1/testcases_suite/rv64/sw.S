#include "test_macros.h"
#include "riscv_test.h"
 
//s_type instruction
RVTEST_RV32M//macros
RVTEST_CODE_BEGIN//macros
////////////////////////////////////////////
  li gp, 3// global pointer
 
start: 

la x6,inp_data
li x11, 0x22
sw x11,8(x6)  
 
  TEST_PASSFAIL 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
inp_data:
  .word 0x06627935
  .word 0x5849446c
  .word 0x06627935
  .dword 0x1111111106627912
  .word 0x06627912
  .word 0x584944fc
 
RVTEST_DATA_END
