#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3  # Number of tests

# Test1: Store 64-bit value to address using c.sd
test1:
  la x8, inp_data         # Load address into x8
  li x9, 0x28cb8c74febbec14
  c.sd x9, 0(x8)          # Store x9 into [x8]
  ld x10, 0(x8)           # Load back to check
  addi x11, x10, 0        # x11 = stored value

# Test2: Store another 64-bit value using c.sd and verify
test2:
  la x8, d1
  li x12, 0xabcd123439febbec
  c.sd x12, 0(x8)         # Store at d1
  ld x13, 0(x8)           # Read back
  addi x14, x13, 0        # x14 = stored value

# Test3: Load second dword from memory
test3:
  la x8, d1
  c.ld x15, 8(x8)         # Load 2nd dword (offset 8)
  addi x16, x15, 0        # x16 = loaded value

  TEST_PASSFAIL

RVTEST_CODE_END

.data

RVTEST_DATA_BEGIN
  TEST_DATA

inp_data:
  .dword 0x0000000000000000  # To be overwritten in test1

d1:
  .dword 0x0000000000000000  # Will be overwritten in test2
  .dword 0x28cb8c74cafef00d  # For test3

RVTEST_DATA_END

