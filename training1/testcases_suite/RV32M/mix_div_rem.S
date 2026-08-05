#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  li gp, 3

test1://divide both signed bit only 
//The test intension is to test the div instructions
li x6,0xf234abcd
li x8,0xf1111111
div x7,x6,x8 # x7=0x0000000000000001
divu x7,x6,x8# x7=0x0000000000000001



test2://remainder both signed bit only
li x6,0xf234abcd
li x8, 0xf1111111
rem x10, x6,x8 # x10=0x0000000001239abc
remu x10, x6,x8  # x10=0x0000000001239abc


//test3://divide both unsigned bit only 
////The test intension is to test the div instructions
//li x6,0x1234abcd
//li x8,0x11111111
//div x7,x6,x8
//divu x7,x6,x8
//
//test4://remainder both unsigned bit only
//li x6,0x1234abcd
//li x8,0x11111111
//rem x10, x6,x8
//remu x10, x6,x8



//The test intension is to test the division by zero

test5:

li x6, 50
li x8, 0
divu x7,x6,x8 # x7=0xffffffffffffffff

div x7,x6,x8# x7=0xffffffffffffffff

test6:
li x6, 50
li x8, 0
remu x10, x6,x8 # x10=50

rem x10, x6,x8#x10=50
 
test7: # rs2>rs1 so for rem => rd=rs1 & for div => rd=0
li x6,20
li x7,50
div x8,x6,x7
divu x9,x6,x7
rem x10,x6,x7
remu x11,x6,x7


test_all:
li x2,5
li x3, 2
li x4,-5
li x5,-2
li x1,0
//both unsigned number 5/2
div x6,x2,x3
divu x6,x2,x3
rem x6,x2,x3
remu x6,x2,x3

// unsigned/signed number 5/-2
div x6,x2,x5
divu x6,x2,x5
rem x6,x2,x5
remu x6,x2,x5

// signed/unsigned number -5/2
div x7,x4,x3
divu x7,x4,x3
rem x7,x4,x3
remu x7,x4,x3

// both unsigned number -8/-3
li x11,-8
li x15,-3
div x6,x11,x15
divu x6,x11,x15
rem x6,x11,x15
remu x6,x11,x15//x6=-8

// unsigned/0 
div x6,x2,x1//x6=0xffff
divu x6,x2,x1//x6=0xffff
rem x6,x2,x1
remu x6,x2,x1


// zero/signed number
div x6,x1,x4//0
divu x6,x1,x4//0
rem x6,x1,x4//0
remu x6,x1,x4//0

// zero/unsigned
div x6,x1,x2//0
divu x6,x1,x2//0
rem x6,x1,x2//0
remu x6,x1,x2//0




TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END






