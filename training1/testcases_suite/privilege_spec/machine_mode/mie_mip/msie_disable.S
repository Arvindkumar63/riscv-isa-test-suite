/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  msie_disable

  Description:
  Verifies that the Machine Software Interrupt (MSIE) remains
  disabled when the MSIE bit in mie is enabled but no software
  interrupt is pending in mip (MSIP=0).
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
    li      x7, 0x8                 // Bit 3 Mask (MSIE/MSIP)


#   Ensure mip.MSIP[3] = 0 (Clear Pending)
    csrc    mip, x7

#   Enable mie.MSIE[3] = 1
    csrrs   x12, mie, x7            // Set MSIE

#   Verification of setup
    csrr    x13, mip                // Read MIP
    csrr    x14, mie                // Read MIE

#   Check: MSIP (bit 3) should be 0
    bnez    x13, fail               // If MSIP is set, setup failed

#   Check: MSIE (bit 3) should be 1
    beqz    x14, fail               // If MSIE is not set, setup failed

#   Wait (No interrupt should occur)
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
