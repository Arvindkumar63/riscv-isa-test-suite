#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 3

# Test1: Perform lr.w and sc.w successfully on aligned memory
test1:
    li x1, 0
    la x2, inp_data
    lr.w x3, (x2)
    addi x4, x3, 1
    sc.w x5, x4, (x2)     # if x5==0 then success
    lw x6, 0(x2)

# Test2: lr.w + sc.w with add operation on 32-bit value
test2:
    la x2, word_val
    lr.w x7, (x2)
    li x8, 0x11111111
    add x9, x7, x8
    sc.w x10, x9, (x2)
    lw x11, 0(x2)

# Test3: sc.w fails if no lr.w was executed before
test3:
    la x2, word_val2
    li x13, 0xAAAAAAAA
    sc.w x14, x13, (x2)   # Should fail: no lr.w before so X14=1 or non zero value
    lw x12, 0(x2)
    lr.w x15, (x2)        # Just load current value

	 # Test4: lr.w then sw check it will access the same addr
test4:
    la x3, word_val3
    lr.w x7, (x3)
    li x8, 0x98711111
    sw  x8, 0(x3)#x8= 0x0000000098711111)
    lw x11, 0(x3)# x11 = 0xffffffff98711111 
li x9, 0xdddd123a
	 sc.w x17,x9,(x3)#  x17 = 0x0000000000000000
	  addi x18,x17,0#  x18 = 0x0000000000000000


TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
TEST_DATA

inp_data:
    .word 5

word_val:
    .word 0x12345678

word_val2:
    .word 0x87654321

word_val3:
    .word 0xab654321


RVTEST_DATA_END

