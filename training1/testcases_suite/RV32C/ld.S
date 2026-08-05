#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3

 
test1:
la x8,inp_data

c.ld x9,0(x8)
 
test2:
	la x8,d1
	c.ld x12,0(x8)
test3:
	c.ld x13,8(x8)
 
 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
 .dword 0x28cb8c74febbec14

.word 0x56cb1234  


d1:
  .dword 0xabcd123439febbec
  .word 0x28cb8c74
  .word 0x28cb8c74
 
RVTEST_DATA_END
