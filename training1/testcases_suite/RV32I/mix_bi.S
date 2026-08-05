#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 1

test1: 
// The test intention is to verify BLT works correctly when the condition is true (x5 < x6)
li x5, 1 
li x6, 2
li x7, 0
blt x5, x6, t1_pass
li x7, 1                  
beq x0, x0, t1_end
t1_pass:
li x7, 2                
t1_end:



test2:

// to test the assembly program to add the numbers from 1 to 10. Store the result in s0.
 main :
addi x1 ,x0, 1 
addi x2, x0 , 0
addi x3 ,x0, 10 
 loop :
add x2,x2,x1  
addi x1,x1,1 
bge x3 , x1 ,  loop
                 


TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

