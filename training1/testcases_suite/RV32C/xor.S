#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32M
RVTEST_CODE_BEGIN
 
  li gp, 3


test1:
//	c.li x2,4//illegal operands
	c.li x8,4//100
	c.li x9,3//011
	c.xor x8,x9//7
//	c.xor x8,x0////illegal operands

test2:
 
	c.li x10,0xf//
	c.li x11,0xa//
	c.xor x10,x11//x10=0x00000005
test3:
	c.li x12,5//101
	c.li x13,1//001
	c.xor x12,x13//x12 = 0x0000000000000004
 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
RVTEST_DATA_BEGIN
  TEST_DATA
  
RVTEST_DATA_END
