#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 3  # 3 tests

# Test1: Simple addition of small positive value
test1:
  c.li x6, 5
  c.addiw x6, 3        # x6 = 8

# Test2: Addiw with zero immediate
test2:
  li x7, 0x12345678
  c.addiw x7, 0        # x7 = 0x0000000012345678 (sign-extended 32-bit result)

# Test3: Addiw causes 32-bit overflow and sign-extension
test3:
  li x8, 0xFFFFFFFF
  c.addiw x8, 1        # x8 = 0x00000000 (32-bit wrap, sign-extended)


# Test4: Invalid - destination register x0 (should cause assembler error or be ignored)
test4:
   c.addiw x0, 4      # INVALID: rd = x0 not allowed

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

