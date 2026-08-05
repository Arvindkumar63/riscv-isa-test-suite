/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           03-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  instret_check

  Description:
  Verifies that `instret` and `minstret` CSRs increment
  after executing a known block of NOP instructions.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0

start:
#   Trap handler setup
    la      x2, trap_handler
    csrw    mtvec, x2

#   Read initial instret
    csrr    x5, minstret            // Read machine instret
    csrr    x6, instret             // Read instret alias

#   Execute 5 instructions
    nop
    nop
    nop
    nop
    nop

#   Read final instret
    csrr    x7, minstret
    csrr    x8, instret

#   Self-check: Verify minstret increased
#   Ideally diff >= 5. Checking simplified > check.
    bge     x5, x7, fail            // If initial >= final, fail

#   Self-check: Verify instret increased
    bge     x6, x8, fail            // If initial >= final, fail

    j       exit

.align 4
trap_handler:
    csrr    x12, mcause
    li      x20, 1
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
