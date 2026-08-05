#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32M//macros
RVTEST_CODE_BEGIN//macros

  li gp, 3// global pointer
 
test1: 
//The test intension is to test the load word and store word & load byte unsigned with differeent testcase instructions
la x6,inp_data
lw x11,8(x6)
 
 
li x7,0x18757806
sw x7,0(x6)
lw x8,0(x6)

test2: 
la x5,inp_data1
lbu x11,8(x6)
 test3:
 
li x7,0x18757806
sw x7,0(x6)
lbu x8,0(x6)

 
  TEST_PASSFAIL 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .word 0x06627935
  .word 0x5849446c
  .word 0x06627935
  .dword 0x1111111106627912
  .word 0x06627912
  .word 0x584944fc
inp_data1:
  .word 0x584944fc
  .word 0x558f5366
  .word 0x558f5366
  .word 0x29df2fb1
  .word 0x29df2fb1
  .word 0x40053e92
  .word 0x40053e92
  .word 0x17010699
  .word 0x17010699
  .word 0x594b9169
  .word 0x594b9169
  .word 0x64cd11c7
  .word 0x64cd11c7
  .word 0x6133a31e
  .word 0x6133a31e
  .word 0x2a9e3a3d
  .word 0x2a9e3a3d
  .word 0x59f86117
  .word 0x59f86117
  .word 0x39214611
  .word 0x39214611
  .word 0x6ec633f5
  .word 0x6ec633f5
  .word 0x4910a7b3
  .word 0x4910a7b3
  .word 0x3392ec72
  .word 0x3392ec72
  .word 0x6c3af175
  .word 0x6c3af175
  .word 0x74555adb
  .word 0x74555adb
  .word 0x360a50f7
  .word 0x360a50f7
  .word 0x39febbec
  .word 0x39febbec
  .word 0x28cb8c74
  .word 0x28cb8c74
 
RVTEST_DATA_END



