/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           19-11-2025
  Updated Date:   03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  seie_enable

  Description:
  Verifies that the Supervisor External Interrupt (SEIE)
  triggers when mie.SEIE[9] = 1, mip.SEIP[9] = 1, and
  global interrupts are enabled (mstatus.MIE = 1).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Trap handler address setup
    la      x2, trap_handler        // Load handler address
    csrw    mtvec, x2               // Set mtvec

#   Enable global interrupts (mstatus.MIE[3] = 1)
    li      x3, 0x8
    csrrs   x0, mstatus, x3         // Set MIE bit
    csrr    x4, mstatus             // Verify write

level1:
    li      x7, 0x200               // Bit 9 Mask (SEIE/SEIP)

#   Enable mie.SEIE[9] = 1
    csrrs   x12, mie, x7            // Set SEIE bit
    csrr    x14, mie                // Read MIE

#   Self-check: Confirm SEIE bit set
    li      x3, 0x200
    bne     x14, x3,  fail               // If SEIP is set, fail

#   Set mip.SEIP[9] = 1 (Trigger Pending)
    csrrs   x2, mip, x7             // Set SEIP bit
    csrr    x13, mip                // Read MIP

    j       exit

.align 4
#   Trap Handler
trap_handler:
    csrr    x12, mcause             // Read mcause
    li      x21, 0x0
    li      x20, 1                  // Set flag: Trap entered

#   Self-check in handler: Verify Cause (Interrupt + 9)
    li      x15, 0x8000000000000009 // Interrupt bit + Cause 9 (Supervisor External)
    bne     x12, x15, fail

    csrr    x8, mepc
    addi    x8, x8, 4               // Increment return address
    csrw    mepc, x8
    csrw    mie, x21                // Clear interrupts to prevent loops
    csrw    mip, x21
    mret                            // Return

exit:
    nop
    nop
#   Break the infinite loop
	 li 	    x5,  0x80000004
	 csrw     mtvec, x5

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
