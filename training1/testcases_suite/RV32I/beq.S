#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

test1:
    li x5, 10
    li x6, 10
    li x7, 0
la x10,equal
    beq x5, x6,0x80000146 #taken branch (equal)
    li x7, 1        

	 equal:
        li x7, 2
addi x12,x5,6
addi x13,x5,14

test2:

    li x5, 10
    li x6, 10
    li x10,10
addi x7,x7,2
    beq x5, x6, equal1//1st time branch is taken//3rd time branch taken
    li x7, 1          
equal1:
        addi x8,x7,4
		  bne x10,x8, test2// 2nd time branch taken
li x3,3 //1st time branch not taken

test3:
li x1,12
li x2, 15
li x3,1
addi x1,x1,1
if:
bge x1,x2, else
addi x3,x3,1

else:
addi x3,x3,-1

exit:



TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

