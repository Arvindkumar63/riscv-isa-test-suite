/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           15-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mcountinhibit_no_increment

  Description:
  Verifies that mcycle STOPS incrementing when
  mcountinhibit.CY (Bit 0) is SET (1).
  
  Note: If the hardware does not implement mcountinhibit,
  it behaves as 0 (counting enabled), and this test will fail
  at the bit-set check.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   1. Set mcountinhibit.CY (Bit 0) to 1
#   This instructs the hardware to STOP incrementing mcycle.
    li      x3, 1
    csrs    mcountinhibit, x3

#   Self-Check: Did the bit actually set?
#   If x4 is 0, your hardware does NOT support this feature.
    csrr    x4, mcountinhibit
    and     x4, x4, x3
    beqz    x4, fail                // Fail if register is Read-Only 0

#   2. Read Initial mcycle
    csrr    x5, mcycle

#   3. Burn Cycles
#   We execute NOPs. If inhibited, mcycle must NOT change.
    nop
    nop
    nop
    nop

#   4. Read Final mcycle
    csrr    x6, mcycle

#   5. Verification: Final must EQUAL Initial
#   If x6 > x5, the counter is still running (Inhibit failed).
    bne     x5, x6, fail

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
