#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 3// global pointer

start: 
  la x6, inp_data     
  la x19,data1     
 
 test1:   
  li x7, 0x3abc

  amomax.w x10, x7, (x6) //compare x7 & 0xabcd  AND it store the  maximum value in the x6 addr.
  lw x15,0(x6)//abcd # checking the value at x6 addr.
  addi x16,x7,0 # x7=0x3abc
  addi x17,x10,0 # x10=0xabcd


test2:
  amomax.w x11, x7, (x19) ////compare x7 & 0xFFFF
  lw x12,0(x19)///ffff # checking the value at x19 addr.
  addi x15,x7,0//3abc
  addi x16,x11,0//ffff

  
test3:
li x3, -5
la x4,d2

  amomax.w x11, x3, (x4) //compare x3 & -3
  lw x12,0(x4)//0xfffd
  addi x15,x3,0//0xfffb
  addi x16,x11,0//0xfffd

  TEST_PASSFAIL 
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .word 0xabcd
  data1:
  .word 0xFFFF
  d2:
  .word -3
RVTEST_DATA_END


