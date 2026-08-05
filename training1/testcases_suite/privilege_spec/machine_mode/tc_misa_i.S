// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        30-09-2025
// Owner:       Arvind Kumar Kori
// Testcase Name: MISA Check 'I' Extension
// Description:
//   1. Read misa register
//   2. Verify if 'I' extension bit (bit 8) is set
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

start:
test1:
  // Step 1: Read misa
  csrr   x5, misa          // read misa into x5

  // Step 2: Mask bit 8 (M extension)
  li     x6, (1 << 8)      // mask for 'M' bit
  and    x7, x5, x6

  // If x7 != 0 → 'I' extension supported
  // If x7 == 0 → 'I' extension NOT supported

test2: // WARL test
  li     x2, -3             // illegal/unsupported value
  csrw   misa, x2
  csrr   x3, misa           // read back (legal value)

test3: // clear C bit
  csrr   x4, misa
  li     x6, ~(1 << 2)      // mask to clear bit 2 (C extension)
  and    x4, x4, x6
  csrw   misa, x4
  csrr   x7, misa           // read back misa (legalized)

test4:
  la     x4, level2
  lw     x6, 2(x4)          // 2-bit aligned addr store but C not set
  csrw   misa, x6
  csrr   x10, misa

level2:
  li     x8, 4
  addi   x9, x8, 4

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

