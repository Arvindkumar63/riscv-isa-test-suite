#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the slliw and sllw rv64i instructions
li x6,0x01
li x8, 31
slliw x7,x6,1 #  x7=0x2

sllw x7,x6,x8 #  x7=0x80000000


 
 test2:
li x6,0x12345678
slliw x7,x6,4# x7=0x23456780

test3:
li x6, 8 #sign extended 32 bit result is written
li x8,31
slliw x7,x6,3 # x7=0x00000040

sllw x7,x6,x8  #x7 = 0x00000000 

test4:
li x6,-8 #sign extended 32 bit result is written
li x8,31

slliw x7,x6,3 # x7=0xffffffffffffffc0
 
sllw x7,x6,x8 
 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END



