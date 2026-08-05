/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           
  Owner:          Arvind Kumar Kori
  Testcase Name:  sstatus_spp_verification

  Description:
  Verifies the SPP (Supervisor Previous Privilege) bit in sstatus.
  1. Delegates 'Environment Call from S-mode' to S-mode.
  2. Enters S-mode.
  3. Executes ecall from S-mode.
  4. Verifies inside handler that SPP=1 (indicating previous mode was Supervisor).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize Trap Flag

start:
#   1. Delegate Exception to S-mode
#   Cause 9 = Environment Call from S-mode
    li      x7, 0x200               // Bit 9 mask
    csrw    medeleg, x7

#   2. Set S-mode Handler
    la      x5, s_handler
    csrw    stvec, x5

#   3. Prepare for S-mode transition
    la      x6, s_mode
    csrw    mepc, x6

#   4. Configure mstatus (MPP=01 for S-mode)
    li      x3, 0x1800
    csrc    mstatus, x3
    li      x3, 0x0800
    csrs    mstatus, x3

    mret                            // Enter S-mode

#   -------------------------------------------------
#   S-MODE EXECUTION
#   -------------------------------------------------
s_mode:

#   Trigger Trap (ECALL)
#   Since we are in S-mode, this should set SPP=1.
    ecall

#   Check: Did trap occur?
    li      x1, 1
    bne     x20, x1, fail

    j       exit

#   -------------------------------------------------
#   S-MODE TRAP HANDLER
#   -------------------------------------------------
.align 4
s_handler:
    li      x20, 1                  // Set Success Flag

    csrr    x12, sstatus            // Read sstatus

#   VERIFY SPP (Bit 8)
#   Expectation: SPP=1 (Previous mode was S-mode)
    li      x13, 0x100              // Bit 8 Mask
    and     x14, x12, x13
    
#   Check: SPP must be 1
    beqz    x14, fail               // Fail if SPP is 0 (U-mode)

#   Return
    csrr    x8, sepc
    addi    x8, x8, 4               // Skip ecall
    csrw    sepc, x8
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

