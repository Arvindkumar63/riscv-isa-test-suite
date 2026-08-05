#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32U
RVTEST_CODE_BEGIN
 
  li gp, 3

test1:
li x1, 50
la x2, inp_data//data at addr. x2=50
	amoadd.w x3,x1,(x2)
	lw x4,0(x2)//x4=0x64
	addi x5,x1,0//x5=50
	addi x6,x3,0 //x6=50



test2:
	la x2,d1//data at addr. x2= 0x2134abcd

	li x1, 0x12345678
	amoadd.w x3,x1,(x2)
	lw x4,0(x2)//x4=ox33690245 
	addi x5,x1,0//x5=0x12345678
	addi x6,x3,0 //x6=0x2134abcd
 
test3:
li x1, 0xab
la x2, byte
	amoadd.w x3,x1,(x2)// x3=
	lw x4,0(x2)//x4=0x4944fccd 
	addi x5,x1,0//x5=0xab
	addi x6,x3,0 //x6=0x4944fccd 
 
//test4:
//	la x6,inp_data3
//	amoadd.w x12,x7,(x6)//address_misalligned
	//lw x24,0(x6)
 
//test5:
//	la x6,inp_data
//	li x9,0x12345678
//	amoadd.w x12,x9,(x6)//12345678+06627912=0x1896cf8a
//	lw x26,0(x6)
// 
//test6:
//	la x6,inp_data
//	li x25,0x123456789abcdef0
//	amoadd.w x13,x25,(x6)//0x123456789abcdef0+0x06627912=
//	lw x27,0(x6)
TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .word 50
d1:
  .word 0x2134abcd

byte:
  .byte 0x22
double:
  .dword 0x12345678584944fc
RVTEST_DATA_END
