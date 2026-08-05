/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  tc_tm_scounteren

  Description:
  Verifies that U-mode CAN read the time register when
  BOTH mcounteren.TM and scounteren.TM are SET.
  Trap should NOT occur.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:

#   1. Enable mcounteren.TM[1] = 1
    li      x3, 0x2
    csrs    mcounteren, x3

#   2. Enable scounteren.TM[1] = 1
    li      x4, 0x2
    csrs    scounteren, x4
#	 self check logic
	 csrr		x6, scounteren
	 bne		x4, x6, fail

#   Prepare for U-mode transition
    la      x6, u_mode_test
    csrw    mepc, x6

#   Configure mstatus (MPP=00 for U-mode)
    li      x3, 0x1800
    csrc    mstatus, x3             // Clear MPP -> U-mode
    mret                            // Enter U-mode
csrr x9, mstatus
#   U-MODE EXECUTION
u_mode_test:


#   Attempt to read time register
    csrr    x5, time

#   If we reach here, NO TRAP occurred (PASS)
    j       exit


exit:
csrr x9, mstatus
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
