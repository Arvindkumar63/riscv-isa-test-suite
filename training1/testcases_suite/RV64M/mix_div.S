#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64MF
RVTEST_CODE_BEGIN

  li gp, 3// global pointer
 
 ///test instention is to test the divw & divuw instructions
 li x1,  10       
li x2,  -3          
divw x3, x1, x2     # x3 = 10 / -3 = -3 (2s complement of 3 is  = 0xFFFFFFFFFFFFFFFD  (x3(64-bit) ))

divuw x4,x1,x2  #divuw output mostly in unsigned form


li x1,  10       
li x2,  3  
divuw x3,x1,x2

test2:
li x1,  -11      
li x2,  2           
divw x3, x1, x2     # x3 = -11 / 2 = -5   (2s complement of 5 is  = 0xFFFFFFFFFFFFFFFB  (x3(64-bit) ))
divuw x3,x1,x2   # unsigned means rs1 treated as unsigned only as well as rs2


test3://zero division
li x1,  123
li x2,  0
divw x3, x1, x2     # Division by zero  (x3=0xFFFFFFFFFFFFFFFF bcz of incorrect division)
divuw x3,x1,x2



test4://negative by negative
li x1, -20
li x2, -4
divw x3, x1, x2     # -20 / -4 = 5   (5 is   =0x0000000000000005  (x3(64-bit) ))  
divuw x3,x1,x2  #divuw output mostly in unsigned form



  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END






