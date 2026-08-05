#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the SRAW & SRAIW rv64i instructions
li x6,0x0000000000000012
li x8, 16
sraiw x7,x6,4 #  x7=0x0000000000000001
li x9,0xffffffff
sraw x7,x9,x8 #  x7=0xffffffffffffffff
li x10,0x2001ffff
sraw x7,x10,x8 #  x7=0x0000000000002001 (sign extended 32 bit result is written)

 
 test2:
li x6,0x1231abcd45080000
//sraiw x7,x6,48 //Error: Improper shift amount (48)

sraiw x7,x6,16 # x7=0x0000000000004508

test3:
li x6, 98 #sign extended 32 bit result is written
li x8,4
sraiw x7,x6,2 # x7=0x0000000000000018
sraw x7,x6,x8  #x7 =0x0000000000000006

test4:
li x6,-98 #sign extended 32 bit result is written
li x8,4

sraiw x7,x6,2 # x7=0xfffffffffffffe7
 
sraw x7,x6,x8 # x7=0xffffffffffffff9

 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END




