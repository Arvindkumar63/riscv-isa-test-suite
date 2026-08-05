/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           16-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_tvm_sfence_trap

  Description:
  Verifies that setting mstatus.TVM (Bit 20) to 1 causes
  execution of SFENCE.VMA in S-mode to trigger an
  Illegal Instruction Exception.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize Trap Flag

start:
#   Set Trap Handler
    la      x2, trap_handler
    csrw    mtvec, x2

#   1. Set TVM (Bit 20) = 1
    li      x3, 0x100000            // Bit 20 Mask
    csrs    mstatus, x3

#   Self-Check: Verify TVM is set
    csrr    x4, mstatus
    and     x5, x4, x3
    beqz    x5, fail

#   2. Switch to S-mode
    la      x6, s_mode
    csrw    mepc, x6

    li      x3, 0x1800
    csrc    mstatus, x3
    li      x3, 0x0800
    csrs    mstatus, x3
    mret

#   S-MODE EXECUTION
s_mode:

#   3. Execute SFENCE.VMA -> MUST TRAP
    sfence.vma

#   Check: Did trap occur?
    li      x1, 1
    bne     x20, x1, fail           // If x20 != 1, Trap failed

    j       exit

.align 4
#   TRAP HANDLER
trap_handler:
    csrr    x12, mcause
    
#   Verify Cause: Illegal Instruction (2)
    li      x13, 2
    bne     x12, x13, fail

#   Set Success Flag
    li      x20, 1

    csrr    x8, mepc
    addi    x8, x8, 4               // Skip instruction
    csrw    mepc, x8
    mret

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
