#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64A
RVTEST_CODE_BEGIN

  li gp, 2  # Number of tests

# Test1: Swap 64-bit value using amoswap.d
test1:
  la x6, inp_data_d       # Load address of 64-bit data
  li x7, 0x123456789ABCDEF0

  amoswap.d x10, x7, (x6) # x10 = original [x6], [x6] = x7
  nop
  ld x11, 0(x6)           # x11 = new value at address (should be x7)
  nop
  addi x12, x7, 0         # Save x7 to x12 for verification
  addi x14, x10, 0        # Save original value (from mem) in x14

# Test2: Another swap with different values
test2:
  la x4, d2_d
  li x3, -5               # 0xFFFFFFFFFFFFFFFB

  amoswap.d x11, x3, (x4) # x11 = original [x4], [x4] = x3
  ld x12, 0(x4)           # x12 = new value at [x4] (should be -5)
  addi x15, x3, 0         # x15 = -5 (unchanged)
  addi x16, x11, 0        # x16 = old memory content

  TEST_PASSFAIL 

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA

inp_data_d:
  .dword 0x2765123411223344

d2_d:
  .dword 0xFFFFFFFFFFFFFFFD  # -3

RVTEST_DATA_END

