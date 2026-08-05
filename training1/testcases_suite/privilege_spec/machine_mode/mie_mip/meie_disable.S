/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           19-11-2025
  Updated Date:   04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  meie_disable

  Description:
  Verifies that the Machine External Interrupt (MEIE) remains
  disabled when the MEIE bit in mie is enabled but no external
  interrupt is pending in mip (MEIP=0).
  Result: In our core machine mode trap not occurs because mip not setting.
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
    li      x7, 0x800               // Bit 11 Mask (MEIE/MEIP)

#   Ensure mip.MEIP[11] = 0 (Clear Pending)
    # Note: MEIP is typically read-only (signal driven).
    # This attempts to clear checks consistency if writable.
    csrc    mip, x7

#   Enable mie.MEIE[11] = 1
    csrrs   x12, mie, x7            // Set MEIE bit

#   Verification of setup
    csrr    x13, mip                // Read MIP
    csrr    x14, mie                // Read MIE

#   Check: MEIP (bit 11) should be 0
    and     x15, x13, x7
    bnez    x15, fail               // If MEIP is set, setup failed

#   Check: MEIE (bit 11) should be 1
    and     x16, x14, x7
    beqz    x16, fail               // If MEIE is not set, setup failed

#   Wait (No interrupt should occur)
    nop
    nop


   TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
