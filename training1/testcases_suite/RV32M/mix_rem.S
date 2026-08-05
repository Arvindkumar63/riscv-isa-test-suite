#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  li gp, 3

test1://divide both signed bit only 
//The test intension is to test the div instructions
li x6,-50//0xf234abcd
li x8, -3//0xf1111111
div x7,x6,x8
divu x7,x6,x8

test2://remainder both signed bit only
li x6,-50//0xf234abcd
li x8, -3//0xf1111111
rem x10, x6,x8
remu x10, x6,x8

test3://divide both unsigned bit only 
//The test intension is to test the div instructions
li x6,50//0x1234abcd
li x8, 3//0x11111111
div x7,x6,x8
divu x7,x6,x8

test4://remainder both unsigned bit only
li x6,50//0x1234abcd
li x8, 3//0x11111111
rem x10, x6,x8
remu x10, x6,x8


//The test intension is to test the div instructions but not giving me correct result

test5:
li x6, 50
li x8, -3
divu x7,x6,x8

div x7,x6,x8
test6:
li x6, 50
li x8, -3
remu x10, x6,x8

rem x10, x6,x8

//The test intension is to test the division by zero

test7:

li x6, 50
li x8, 0
divu x7,x6,x8

div x7,x6,x8
test8:
li x6, 50
li x8, 0
remu x10, x6,x8

rem x10, x6,x8
 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END






