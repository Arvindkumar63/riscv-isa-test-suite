#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32M
RVTEST_CODE_BEGIN
 
  li gp, 3
 
test1:
la x8,inp_data:
c.li x9,6
	c.sw x9,0(x8)
c.lw x10,0(x8)
 
test2:
la x8,d1:
c.li x10,3
	c.sw x10,4(x8)//
 c.lw x11,4(x8)

 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .word 0x584944fc
  
d1:
  .word 0x360a50f7
  .word 0x39febbec
  .word 0x39febbec
  .word 0x28cb8c74
  .word 0x28cb8c74
 
RVTEST_DATA_END
 

