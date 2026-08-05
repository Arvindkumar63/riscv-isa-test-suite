#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV32M
RVTEST_CODE_BEGIN

li gp, 2 

# Test1: Simple test – XOR 0xAAAAAAAA with 0x0F0F0F0F
test1:
  li x1, 0x0F0F0F0F
  la x2, data1
  amoxor.w x3, x1, (x2)
  lw x4, 0(x2)
  addi x5, x1, 0
  addi x6, x3, 0

# Test2: Corner case – XOR 0x12345678 with 0xFFFFFFFF (bitwise inversion)
test2:
  li x1, 0xFFFFFFFF
  la x2, data2
  amoxor.w x3, x1, (x2)
  lw x4, 0(x2)
  addi x5, x1, 0
  addi x6, x3, 0

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
TEST_DATA

data1:
  .word 0xAAAAAAAA
data2:
  .word 0x12345678

RVTEST_DATA_END

