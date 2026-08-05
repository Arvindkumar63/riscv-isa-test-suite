#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 1

test1: 
// The test intention is to verify JALR instructionns
//Basic JALR with offset (branch + link)
la x5, fun
li x8,20
jalr x6,x5,8
addi x7,x8,4

fun:
//jalr x4,x5,0
        addi  x9,x8,30         
        addi  x9,x8,80         
        addi  x9,x8,180         
		  addi  x9,x8,1         
        addi  x9,x8,2  

test2:
// JALR with x1

la x13, target3
jalr x1, x13
addi x14, x0, 55 

target3:
addi x15, x0, 77 //execute this


fun1:
//jalr x4,x5,0
        addi  x9,x8,30         
        addi  x9,x8,80         
        addi  x9,x8,180         
		  addi  x9,x8,1         
        addi  x9,x8,2


  TEST_PASSFAIL 
RVTEST_CODE_END
 
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END


