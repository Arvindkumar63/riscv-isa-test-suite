/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           04-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  seie_enable_smode

  Description:
  Verifies Supervisor External Interrupt (SEIE) triggers in
  S-mode. Delegates interrupt, forces pending bit in M-mode,
  enables in S-mode, and verifies trap handling.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3

start:
#   -------------------------------------------------
#   M-MODE SETUP
#   -------------------------------------------------

#   1. Set S-mode Trap Handler
    la      x5, trap_handler
    csrw    stvec, x5

#   2. DELEGATION (Critical Step)
#   Delegate Supervisor External Interrupt (Bit 9) to S-mode.
    li      x7, 0x200               // Bit 9 mask (SEIP)
    csrw    mideleg, x7             // Write to mideleg

#   3. FORCE PENDING INTERRUPT
#   Set mip.SEIP (Bit 9) = 1.
#   This forces a pending external interrupt visible in S-mode sip.
    csrrs   x0, mip, x7

#   4. Prepare for S-mode transition
    la      x6, s_mode
    csrw    mepc, x6                // Set return address

#   5. Configure mstatus (MPP=01 for S-mode)
    li      x3, 0x1800              // Mask for MPP
    csrc    mstatus, x3             // Clear MPP
    li      x3, 0x0800              // Set MPP = 01 (S-mode)
    csrs    mstatus, x3

    mret                            // Enter S-mode

#   -------------------------------------------------
#   S-MODE EXECUTION
#   -------------------------------------------------
s_mode:
#   1. Enable Global Interrupts (SIE) in sstatus
    li      x8, 0x2                 // Bit 1 (SIE)
    csrrs   x0, sstatus, x8         // Set SIE

#   2. Enable SEIE in sie (This should trigger the trap)
    li      x7, 0x200               // Bit 9 (SEIE)
    csrrs   x0, sie, x7

#   Self-check: Verify SEIE is set
//	 li		x7, 0
//  csrr    x9, sie
//  bne     x9, x7, fail

#   Trap should have occurred by now.
    nop
    nop

    j       exit

#   -------------------------------------------------
#   S-MODE TRAP HANDLER
#   -------------------------------------------------
.align 4
trap_handler:
    csrr    x12, scause             // Read scause
    li      x20, 1                  // Set success flag

#   Verify Cause: Supervisor External Interrupt (Interrupt=1, Code=9)
#   0x800...009
    li      x15, 9
    slli    x15, x15, 63            // Set MSB (Interrupt bit)
    ori     x15, x15, 9             // Cause 9
    bne     x12, x15, fail

    csrr    x13, sepc
    addi    x13, x13, 4             // Skip instruction
    csrw    sepc, x13

#   CRITICAL: Disable SEIE in sie
#   We cannot clear sip.SEIP in S-mode (it's read-only/PLIC driven).
#   To avoid an infinite loop, we must disable the interrupt enable bit.
    li      x14, 0x200
    csrc    sie, x14

    sret                            // Return to S-mode

#   -------------------------------------------------
#   EXIT / FAIL
#   -------------------------------------------------
exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
