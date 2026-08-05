#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  li gp, 3
test1://both unsigned integer 
//The test intension is to test the mul instructions
li x6,5
li x8,10

mul x7,x6,x8
mulh x9,x6,x8
test2:
li x6,5
li x8,10
li x5,-50
li x10, -10
mul x7,x6,x8
mulh x9,x5,x10
test3://one signed and others unsigned
li x6,-5
li x8, 10
li x2, -10
mul x10,x6,x8 #one signed and others unsigned
mul x13,x6,x2 #both signed 
mulh x12,x6,x8
mulhsu x7,x6,x8
mulhu x11,x6,x8
mulhu x9,x8,x8

test_all:
li x1,4
li x2,-3
li x3,0
//unsigned * signed
mul x5,x1,x2//x5=0xfffffff4
mulh x5,x1,x2//x5=0xffffffff
mulhsu x5,x1,x2//x5=0x00000003
mulhu x5,x1,x2//x5=0x00000003


//signed * unsigned -3*4
mul x6,x2,x1
mulh x6,x2,x1
mulhsu x6,x2,x1//x5=0xffffffff
mulhu x6,x2,x1//x5=0x00000003


// signed * signed -3*-3
mul x7,x2,x2
mulh x7,x2,x2
mulhsu x7,x2,x2//x5=0xfffffffd
mulhu x7,x2,x2//x5=0xfffffffa

// multiply with zero so all give 0
mul x8,x1,x3
mulh x8,x1,x3
mulhsu x8,x1,x3
mulhu x8,x1,x3

mul x9,x3,x3
mulh x9,x3,x3
mulhsu x9,x3,x3
mulhu x9,x3,x3



test4://both unsigned integer 
//The test intension is to test the mul instructions
li x6,0x1234abcd
li x8, 0xabcd1234

mul x7,x6,x8
mulh x9,x6,x8
test5:
li x6,0x1234abcdffffffff
li x8, 0xabcd1234ffffffff
li x5,0xffffffff1234abf
li x10,0xf1234abcd2134258
mul x7,x6,x8
mulh x9,x5,x10//x9=0xff1234abcdfe1640

test6://one signed and others unsigned
li x6,0xffffffffffffffff
li x8,0xabcd1234ffffffff
mul x10,x6,x8
mulh x12,x6,x8
mulhsu x7,x6,x8
mulhu x11,x6,x8
mulhu x9,x6,x6//x9= 0xfffffffffffffffe

test7:
li x6,-1
li x7,0x8000000000000000
mulhsu x10,x7,x6//x10=0x8000000000000000

 
  TEST_PASSFAIL 
RVTEST_CODE_END

 
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END





