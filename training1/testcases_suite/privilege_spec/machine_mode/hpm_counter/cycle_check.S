/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  cycle_check

  Description:
  Verifies that `cycle` and `mcycle` CSRs increment over time.
  Reads initial value, waits, reads final value, and compares.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Trap flag

start:
#   Trap handler setup
    la      x2, trap_handler
    csrw    mtvec, x2

#   Read initial cycle values
    csrr    x5, mcycle              // Read machine cycle
    csrr    x6, cycle               // Read cycle alias

    li      x10, 10                 // Loop count
delay_loop:
    addi    x10, x10, -1
    bnez    x10, delay_loop         // Burn cycles

#   Read final cycle values
    csrr    x7, mcycle
    csrr    x8, cycle

#   Self-check: Verify mcycle increased
    bge     x5, x7, fail            // If initial >= final, fail

#   Self-check: Verify cycle increased
    bge     x6, x8, fail            // If initial >= final, fail

    j       exit

.align 4
trap_handler:
    csrr    x12, mcause
    li      x20, 1                  // Set trap flag
    csrr    x8, mepc
    addi    x8, x8, 4
    csrw    mepc, x8
    mret

exit:
    nop
    nop

    RVTEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
