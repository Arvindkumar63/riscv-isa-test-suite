#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M//macros
RVTEST_CODE_BEGIN//macros

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the SRLW & SRLIW rv64i instructions
li x6,0x0000000000000012
li x8, 16
srliw x7,x6,4 #  x7=0x0000000000000001
li x9,0xffffffff
srlw x7,x9,x8 #  x7=0xffffffffffffffff
li x10,0x2001ffff
srlw x7,x10,x8 #  x7=0x0000000000002001


 
 test2:
li x6,0x1231abcd45080000
//srliw x7,x6,48 //Error: Improper shift amount (48)

srliw x7,x6,16 # x7=0x0000000000004508

test3:
li x6, 98 #sign extended 32 bit result is written
li x8,4
srliw x7,x6,2 # x7=0x0000000000000018
srlw x7,x6,x8  #x7 =0x0000000000000006

test4:
li x6,-98 #sign extended 32 bit result is written
li x8,4

srliw x7,x6,2 # x7=0xfffffffffffffe7
 
srlw x7,x6,x8 # x7=0xffffffffffffff9

 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END





