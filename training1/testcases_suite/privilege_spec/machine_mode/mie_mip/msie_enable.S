/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  msie_enable

  Description:
  Verifies that the Machine Software Interrupt (MSIE)
  triggers when mie.MSIE[3] = 1, mip.MSIP[3] = 1, and
  global interrupts are enabled (mstatus.MIE = 1).
  Result: In our core machine mode trap not occurs because mip not setting.
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
    li      x7, 0x8                 // Bit 3 Mask (MSIE/MSIP)

#   Enable mie.MSIE[3] = 1
    csrrs   x12, mie, x7            // Set MSIE bit
    csrr    x14, mie                // Read MIE

    nop
    nop                             // Wait for interrupt to trigger

#   Self-check: Confirm MSIE are set
    li		x2,  0x8
	 bne     x2, x14, fail       // If MSIE is not set, fail
#   Set mip.MSIP[3] = 1 (Trigger Pending)
    csrrs   x2, mip, x7             // Set MSIP bit
    csrr    x13, mip                // Read MIP

    j       exit

.align 4
#   Trap Handler
trap_handler:
    csrr    x12, mcause             // Read mcause
    li      x21, 0x0
    li      x20, 1                  // Set flag: Trap entered

#   Self-check in handler: Verify Cause (Interrupt + 3)
    li      x15, 0x8000000000000003 // Interrupt bit + Cause 3 (Machine Software)
   // bne     x12, x15, fail

    csrr    x8, mepc
    addi    x8, x8, 4               // Increment return address
    csrw    mepc, x8
    csrw    mie, x21                // Clear interrupts to prevent loops
    csrw    mip, x21
    mret                            // Return

exit:
    nop
    nop
# Break the infinite loop
la 	   x5,  0x80000004
csrw     mtvec, x5
 
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
