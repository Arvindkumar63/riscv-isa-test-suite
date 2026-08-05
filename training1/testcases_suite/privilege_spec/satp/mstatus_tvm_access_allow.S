/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           16-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_tvm_access_allowed

  Description:
  Verifies that clearing mstatus.TVM (Bit 20) allows
  S-mode to access satp and execute SFENCE.VMA without
  triggering any exceptions.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Set Trap Handler (Safety against unexpected trap)
    la      x2, trap_handler
    csrw    mtvec, x2

#   1. Clear TVM (Bit 20) = 0
    li      x3, 0x100000            // Bit 20 Mask
    csrc    mstatus, x3

#   Self-Check: Verify TVM is clear
    csrr    x4, mstatus
    and     x5, x4, x3
    bnez    x5, fail

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

#   3. Attempt to Read satp -> SHOULD SUCCEED
    csrr    x7, satp

#   4. Attempt SFENCE.VMA -> SHOULD SUCCEED
    sfence.vma

#   If we reach here, NO TRAP occurred (PASS)
    j       exit

.align 4
trap_handler:
#   If we trap here, it's a FAIL (Unexpected Illegal Instr)
    j       fail

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
