#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32M//macros
RVTEST_CODE_BEGIN//macros
 li gp, 3// global pointer

//the test intention is to test store byte, store half and store word
test1:
  la x6, inp_data       //Load address of inp_data into x6
  li x7, 0x12345678     //Value to store

  sb x7, 0(x6)          //Store least significant byte (0x78)
  lb x8, 0(x6)          //Load byte -> expect 0xFFFFFF78 (sign-extended)

  sh x7, 2(x6)          //Store lower 16 bits (0x5678) at offset 2
  lh x9, 2(x6)          //Load half -> expect 0xFFFF5678

test2:
  li x5, 0x11223344     //Another test word
  sw x5, 4(x6)          //Store full word at offset 4
  lw x10, 4(x6)         //Load it back

  TEST_PASSFAIL 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
inp_data:
  .word 0x06627935
  .word 0x5849446c
  .word 0x06625342
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


