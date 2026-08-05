/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  tc_tm_scrounter_ill

  Description:
  Verifies that U-mode CANNOT read the time register when
  scounteren.TM is CLEAR.
  Trap MUST occur.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4

start:
#   Set Trap Handler
    la      x2, trap_handler
    csrw    mtvec, x2

#   DISABLE scounteren.TM[1] = 0
    li      x4, 0x2
    csrc    scounteren, x4
#	 self check logic
	 li		x5, 0
	 csrr		x6, scounteren
	 bne		x5, x6, fail

#   Prepare for U-mode transition
    la      x6, u_mode_test
    csrw    mepc, x6

#   Configure mstatus (MPP=00 for U-mode)
    li      x3, 0x1800
    csrc    mstatus, x3             // Clear MPP -> U-mode
    mret                            // Enter U-mode
#	 self check logic
	 csrr		x11, mstatus
	 li		x12, 0x0000000a00000080
	 bne		x12, x11, fail

#   U-MODE EXECUTION
u_mode_test:

#   Attempt to read time register (Should Trap)
    csrr    x5, time

    j       exit

.align 4
#   Trap Handler: Handles interrupt and returns
trap_handler:
    csrr    x12, mcause             // Read mcause
    
# 	 self - check logic
	 li		x13, 0x2
	 bne		x12, x13, fail

#   Set Flag = 1 to indicate Trap Occurred
    li      x20, 1

    csrr    x8, mepc
    addi    x8, x8, 4               // Increment return address (skip instruction)
    csrw    mepc, x8

    mret                            // Return to next instruction

exit:
    nop
    nop

#   Break infinite loop safety
    li      x5, 0x80000004
    csrw    mtvec, x5

    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
