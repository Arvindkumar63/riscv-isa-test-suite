#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3

test1:
li x1, 50
la x2, inp_data//data at addr. x2=50
	amoadd.d x3,x1,(x2)
	ld x4,0(x2)//x4=0x64
	addi x5,x1,0//x5=50
	addi x6,x3,0 //x6=50



test2:
	la x2,d1//data at addr. x2= 0x2134abcd

	li x1, 0x12345678
	amoadd.d x3,x1,(x2)
	ld x4,0(x2)//x4= 0x4944fc2233690245
	addi x5,x1,0//x5=0x12345678
	addi x6,x3,0 //x6=0x4944fc222134abcd
 
//test3: # exception trap_store_address_misaligned,
//li x1, 0xab
//la x2, byte
//	amoadd.d x3,x1,(x2)// x3=
//	ld x4,0(x2)//x4=0x4944fccd 
//	addi x5,x1,0//x5=0xab
//	addi x6,x3,0 //x6=0x4944fccd 
 
test4:
    la x6, double        # Load address of aligned 8-byte data
    li x2, 0x12345678    # Load 32-bit value
    amoadd.d x13, x2, (x6)   # Atomic add: [x6] = [x6] + x2, x13 = original [x6]
    ld x27, 0(x6)        # Load new value into x27
    addi x5, x2, 0       # x5 = x2 (for reference)
    addi x6, x13, 0      # x6 = x13 (original value at address)



TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:  // addr should be multiple of 8 in double 
  .dword 5
double:
    .dword 0x123456789ABCDEF00
d1:
  .word 0x2134abcd


byte:
  .byte 0x22
RVTEST_DATA_END

