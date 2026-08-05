/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           19-11-2025
  Updated Date:   04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mtie_disable

  Description:
  Verifies that the Machine Timer Interrupt (MTIE) remains
  disabled when the MTIE bit in mie is enabled but no timer
  interrupt is pending in mip (MTIP=0).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Enable global interrupts (mstatus.MIE[3] = 1)
    li      x3, 0x8
    csrrs   x0, mstatus, x3         // Set MIE bit
    csrr    x4, mstatus             // Verify write

level1:
    li      x7, 0x80                // Bit 7 Mask (MTIE/MTIP)

#   Ensure mip.MTIP[7] = 0 (Clear Pending)
    # Note: MTIP is typically read-only / controlled by mtimecmp.
    # This instruction attempts to clear it for test consistency.
    csrc    mip, x7

#   Enable mie.MTIE[7] = 1
    csrrs   x12, mie, x7            // Set MTIE

#   Verification of setup
    csrr    x13, mip                // Read MIP
    csrr    x14, mie                // Read MIE

#   Check: MTIP (bit 7) should be 0
    and     x15, x13, x7
    bnez    x15, fail               // If MTIP is set, setup failed

#   Check: MTIE (bit 7) should be 1
    and     x16, x14, x7
    beqz    x16, fail               // If MTIE is not set, setup failed

#   Wait (No interrupt should occur)
    nop
    nop


TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
