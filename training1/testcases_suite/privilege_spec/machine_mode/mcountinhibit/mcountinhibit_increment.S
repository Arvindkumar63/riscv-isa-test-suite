/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           15-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mcountinhibit_increment

  Description:
  Verifies that mcycle increments when mcountinhibit.CY (Bit 0)
  is CLEAR (0).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   1. Clear mcountinhibit.CY (Bit 0)
#   This allows mcycle to increment.
    li      x3, 1
    csrc    mcountinhibit, x3

#   Self-Check: Verify Bit 0 is 0
    csrr    x4, mcountinhibit
    and     x4, x4, x3
    bnez    x4, fail                // Fail if bit is not 0

#   This allows other counters to increment.
    li      x3, 0xffff
    csrc    mcountinhibit, x3

#   Read the updated value of mcycle, minstret
    csrr    x5, mcycle					// x5 = 0x49
    csrr    x15, minstret				// x15 = 0x4a

#   3. Burn Cycles
    nop
    nop
    nop
    nop

#   Read the final value of mcycle, minstret
    csrr    x7, mcycle					// x7 = 0x4f
    csrr    x6, minstret				// x6 = 0x50
#   5. Verification: Final should be GREATER than Initial
    # If x6 <= x5, it failed to increment
    bge     x5, x6, fail

    j       exit

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

