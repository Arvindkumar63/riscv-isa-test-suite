
#include "test_macros.h"
#include "riscv_test.h"
RVTEST_RV32U
RVTEST_CODE_BEGIN

li gp, 5  

//test intention is to test the slli RV32I instructions behaviours

test1:
li x6, 0x1
slli x8, x6, 1 # x8=2

test2:
li x6, 0x12345678
slli x8, x6,4 # x8=0x23456780

test3:
li x6, 0xFFFFFFFF
slli x8, x6, 1 # x8=0xFFFFFFFE

test4:
li x6, 0x80000000
slli x8, x6, 1 # x8=0x00000000 (overflow out of MSB)

test5:
li x6, 0x1
slli x8, x6, 31 # x8=0x80000000






//test intension is to compare output with SLLIW in RV64I

test6_c: 
//The test intension is to test the slliw rv64i instructions
li x6,0x1
slliw x7,x6,1 #  x7=0x2


 
 test7_c:
li x6,0x12345678
slliw x7,x6,4 # x7=0x23456780

test8_c:
li x6, 8 #sign extended 32 bit result is written
slliw x7,x6,3 # x7=0x0000000000000040


test9_c:
li x6,-8 #sign extended 32 bit result is written

slliw x7,x6,3 # x7=0xffffffffffffffc0

TEST_PASSFAIL
RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA


RVTEST_DATA_END


