/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           10-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  tc_scounter_cy_enable

  Description:
  Verifies that U-mode CAN read the cycle register when
  BOTH mcounteren.CY and scounteren.CY are SET.
  No trap should occur.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:

#   1. Enable mcounteren.CY[0] = 1
#   Required for U-mode access (AND condition)
    li      x3, 0x1
    csrs    mcounteren, x3

#   2. Enable scounteren.CY[0] = 1
#   Required for U-mode access
    li      x4, 0x1
    csrs    scounteren, x4
#	 self check logic
	 csrr		x6, scounteren
	 bne		x4, x6, fail
#   Prepare for U-mode transition
    la      x6, u_mode_test
    csrw    mepc, x6

#   Configure mstatus (MPP=00 for U-mode)
    li      x3, 0x1800              // Mask for MPP
    csrc    mstatus, x3             // Clear MPP -> U-mode
    mret                            // Enter U-mode
#	 self check logic
	 csrr		x11, mstatus
	 li		x12, 0x0000000a00000080
	 bne		x12, x11, fail
    mret                            // Enter U-mode

#   U-MODE EXECUTION
u_mode_test:

#   Attempt to read cycle register
#   Condition: mcounteren=1, scounteren=1
#   Result: SHOULD SUCCEED (No Trap)
    csrr    x5, cycle
    j       exit                    // Jump to exit

exit:
    nop
    nop

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
