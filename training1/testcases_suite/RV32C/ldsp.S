#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3

 
test1:
la x2,inp_data

c.ldsp x9,0(x2)

 
test2:
	la x2, d1
	c.ldsp x12,0(x2)
test3:
	c.ldsp x13,8(x2)
 
 
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

