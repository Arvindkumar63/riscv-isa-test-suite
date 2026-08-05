#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 1

test1: 
// The test intention is to verify JAL instructions
li x6, 10

jal x8,fun
addi x7,x6,4
fun:
addi x9,x6,12


test2:
// test intention is to use jal with x0 (no return address) 

li x11, 100        //initialize x11 with 100
jal x0, 0x80000134   //jump to label_x0, do NOT store return address
addi x11, x11, 50  // skip this (11 remains 100)
label_x0:
addi x12, x11, 10  //x12 = 110

test3: 
// The test intention is to verify JAL instructions
  
//jal x8,4// giving me  error: ld returned 1 exit status
jal x1,fun1
addi x7,x6,4
addi x10,x6,10
j exit #prevent fun1 again

fun1:
addi x9,x6,12
jalr x0,x1,0 #return to the addr in x1

exit:
li x12, 1


test4: 
// The test intention is to verify JAL instructions
  
jal x2,fun2
addi x7,x6,4
addi x10,x6,10
j exit1 #prevent fun1 again

fun2:
addi x9,x6,12
jalr x0,x2,0 #it will not return the x2 addr bcz jal & jalr (return stack work on X1 & X5 reg.) 
exit1:
li x12, 1



test5: 
// The test intention is to verify JAL instructions without using LABELS using OFFSET PC VALUE
la x10, fun6

//jal x8,0x8000017a

jalr x1,x10,0 
li x6, 10
jalr x0,x1,0


addi x7,x6,4
fun6:
addi x9,x6,12
addi x9,x6,50
addi x9,x6,100

   

  TEST_PASSFAIL 
RVTEST_CODE_END
 
  
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END



