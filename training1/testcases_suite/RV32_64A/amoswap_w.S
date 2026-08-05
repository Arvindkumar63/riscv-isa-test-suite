#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV32U
RVTEST_CODE_BEGIN
  li gp, 3

//Test the amoswap.w instructions
test1: 
  la x6, inp_data     
  li x7, 0x12345678 
       
  amoswap.w x10, x7, (x6) //x10  = 0x12345678
  nop
  lw x11,0(x6)//x10<-(data of the addr. at x6), so used lw
             //x6<- x7(imm)
				 // x11 = 0x12345678
  nop
  addi x12,x7,0  //x7<- unchange  x12=0x12345678
addi x14, x10,0 // x14=0x27651234 

test2:
li x3, -5
la x4,d2

  amomax.w x11, x3, (x4) //swap x-5 & -3
                        // x11 = 0xfffffffd
  lw x12,0(x4)// x12 = 0xfffffffd
  addi x15,x3,0//x15=0xfffffffb = -5 unchange
  addi x16,x11,0//x16 = 0xfffffffd


  TEST_PASSFAIL 
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA
 
inp_data:
  .word 0x27651234
  .word 0x22222222
  d2:
  .word -3
RVTEST_DATA_END

 
  

