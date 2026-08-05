#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  li gp, 1     

test1:
  # Load float -1.0 into f1
  la x4, neg1_float
  flw f1, 0(x4)

  # Convert to unsigned int → invalid, should return 0 and raise exception
  fcvt.wu.s x5, f1        # float -1.0 → unsigned int

  li x6, 0
  bne x5, x6, fail        # Fail if result is NOT zero

  # Check exception flag
  csrr x7, fflags         # Read floating-point exception flags
  li x8, 0x10             # Bit 4 = Invalid Operation
  bne x7, x8, fail        # Fail if invalid flag not set

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN

neg1_float:  .float 1.0

TEST_DATA
RVTEST_DATA_END

