/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           12-12-2025
  Owner:         Arvind Kumar Kori 
  Testcase Name:  stval_ecall

  Description:
  Verifies Supervisor Software Interrupt triggers in S-mode.
  Checks scause and stval in the handler.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 3

start:


#   Delegate all interrupts to S-mode
    li      x27, 0xFFFF
    csrw    mideleg, x27

#   Prepare for S-mode transition (MPP=01)
    li      x24, 0x1800             // Clear MPP
    csrc    mstatus, x24
    li      x24, 0x0800             // Set MPP=01 (Supervisor)
    csrs    mstatus, x24

    la      x26, s_mode
    csrw    mepc, x26
    mret                            // Enter S-mode

#   -------------------------------------------------
#   S-MODE EXECUTION
#   -------------------------------------------------
s_mode:
#   Set S-mode Trap Handler
    la      x5, s_handler
    csrw    stvec, x5

#   Enable Global Interrupts (SIE)
    li      x25, 0x2
    csrrs   x0, sstatus, x25

#   Enable Supervisor Software Interrupt (SSIE)
    li      x25, 0x2
    csrs    sie, x25

#   Trigger Interrupt: Set SSIP
    csrs    sip, x25

    nop
    nop

    j       exit

.align 4
#   -------------------------------------------------
#   S-MODE TRAP HANDLER
#   -------------------------------------------------
s_handler:
    csrr    x11, scause             // Read Cause
    csrr    x14, stval              // Read Value (Should be 0 for Interrupts)

#   Verify Cause: Supervisor Software Interrupt (Int=1, Code=1)
#   0x800...001
    li      x9, 1
    slli    x9, x9, 63
    ori     x9, x9, 1
    bne     x11, x9, fail

#   Set Success Flag
    li      x20, 1

    csrr    x12, sepc
    addi    x12, x12, 4             // Skip instruction
    csrw    sepc, x12

#   Clear SSIP to prevent loop
    li      x25, 0x2
    csrc    sip, x25

    sret



exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
