#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3// global pointer
 
 
 li x1, 3      
li x2,  7          
test1:
 
sub x3,x1,x2 # x3 = 0xfffffffffffffffc=

test2:
li x1,  8     
li x2,-5
neg x5, x1 # x5=0xfffffffffffffff8
neg x6,x2

test3:
li x1, 0x80000000
srai x2,x1,3
slli x4,x1,6

test4:
li x1, 5
addi x3,x1,6
ADDI x5,x1, 8

test5:// exception trap_illegal_instruction,


   la x5, target       # x5 = address of `target` (aligned)
  addi x5, x5, 2      # now x5 is UNALIGNED (e.g., 0x1002)
  jalr x0, x5, 0      # jump to unaligned address → should raise exception //exception trap_illegal_instruction,

  li x6, 123          # should never reach here if exception works

target:
  li x7, 999
  ret

  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END






