

#include "test_macros.h"

#include "riscv_test.h"
 
RVTEST_RV32U

RVTEST_CODE_BEGIN
 
  li gp, 3

  li x2, 5
 
start:
 
li x4,5// if n=5

li x7,1

li x8,0
 
loop: 

beq x4, x8, exit0

sub x2, x2,x7

mul x4, x4,x2
 
bne x2, x7, loop
 
exit:

nop
 
exit0:

add x4, x4, 1

  TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN

  TEST_DATA
 
 
inp_data:

  .word 0x06627912

  .word 0x06627912

  .word 0x584944fc

  .word 0x584944fc

  .word 0x558f5366

  .word 0x558f5366

  .word 0x29df2fb1

  .word 0x29df2fb1

  .word 0x40053e92

  .word 0x40053e92

  .word 0x17010699

  .word 0x28cb8c74
 
RVTEST_DATA_END
 
 
