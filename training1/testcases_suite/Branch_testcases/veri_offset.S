#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3  
start:
  li x1, 0        
  li x2, 20       
  li x6, 1         

alt_loop_10:
  andi x4, x1, 1         
  bne x4, x6, do_taken              # addr = 0x8000011a%4=2 
blt x6,x5, misaligned_addr          # addr = 0x8000011c%4=0 
misaligned_addr:                    # addr = 0x8000011e%4=2 still not working here according to spec
addi x9,x6,20

do_taken:
  addi x6, x6, 7 

  TEST_PASSFAIL


RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

