/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           19-11-2025
  Updated Date:   03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  seie_disable

  Description:
  Verifies that the Supervisor External Interrupt (SEIE)
  remains disabled when the SEIE bit in mie is enabled but
  no external interrupt is pending in mip (SEIP=0).
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
    li      x7, 0x200               // Bit 9 Mask (SEIE/SEIP)
	 li		x9, 0x0

#   Ensure mip.SEIP[9] = 0 (Clear Pending)
    csrc    mip, x9

#   Enable mie.SEIE[9] = 1
    csrrs   x12, mie, x7            // Set SEIE

    csrr    x13, mip                // Read MIP
    csrr    x14, mie                // Read MIE

#   Self check: SEIP (bit 9) should not be 1
    li		x5,  0x0
	 bnez    x13, fail               // If SEIE is set, setup failed

#   Wait (No interrupt should occur)
    nop
    nop


TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
