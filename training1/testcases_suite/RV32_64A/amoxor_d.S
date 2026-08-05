#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

li gp, 2  # Number of tests

# Test1: Simple test – XOR 0xAAAAAAAAAAAAAAAA with 0x0F0F0F0F0F0F0F0F
test1:
  li x1, 0x0F0F0F0F0F0F0F0F
  la x2, data1
  amoxor.d x3, x1, (x2)
  ld x4, 0(x2)
  addi x5, x1, 0
  addi x6, x3, 0

# Test2: Corner case – XOR 0x1234567890ABCDEF with -1 (bitwise inversion)
test2:
  li x1, -1
  la x2, data2
  amoxor.d x3, x1, (x2)
  ld x4, 0(x2)
  addi x5, x1, 0
  addi x6, x3, 0

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
TEST_DATA

data1:
  .dword 0xAAAAAAAAAAAAAAAA
data2:
  .dword 0x1234567890ABCDEF

RVTEST_DATA_END

