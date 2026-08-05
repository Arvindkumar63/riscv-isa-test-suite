/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  seie_disable

  Description:
  Verifies Supervisor External Interrupt (SEIE) does not occur
  in S-mode when enabled but mip.SEIP is clear.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3

start:
    # Delegate Supervisor External Interrupt (Bit 9) to S-mode
    # Necessary so S-mode sees the interrupt logic
    li      x7, 0x200
    csrw    mideleg, x7

    # Clear mip.SEIP (Bit 9)
    # Ensure pending bit is clear so trap does NOT occur
    csrc    mip, x7

    # Prepare for S-mode transition
    la      x6, s_mode
    csrw    mepc, x6                // Set return address

    # Configure mstatus (MPP=01 for S-mode)
    li      x3, 0x800              // Set MPP = 01 (S-mode)
    csrs    mstatus, x3

    mret                            // Enter S-mode

#   S-MODE EXECUTION

s_mode:
    # Enable Global Interrupts (SIE) in sstatus
    li      x8, 0x2                 // Bit 1 (SIE)
    csrrs   x0, sstatus, x8         // Set SIE

    # Enable SEIE in sie
    li      x7, 0x200               // Bit 9 (SEIE)
    csrrs   x0, sie, x7

    # Self-check: Verify SEIE is set
    csrr    x9, sie
    and     x9, x9, x7
    beqz    x9, fail

    # Wait (No interrupt should occur)
    nop
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END




