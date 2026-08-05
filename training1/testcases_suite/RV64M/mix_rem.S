#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3
 test1:
 ///test instention is to test the remw & remuw instructions
 li x1,  10       
li x2,  -3          
rem x3, x1, x2    

li x1,  10       
li x2,  3  
remuw x3,x1,x2

test2:
li x1,  -11      
li x2,  2           
remw x3, x1, x2     
remuw x3,x1,x2  

test3://zero division
li x1,  123
li x2,  0
remw x3, x1, x2    
remuw x3,x1,x2



test4:
li x1, 20
li x2, 3
remw x3, x1, x2     
remuw x3,x1,x2  


  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END







