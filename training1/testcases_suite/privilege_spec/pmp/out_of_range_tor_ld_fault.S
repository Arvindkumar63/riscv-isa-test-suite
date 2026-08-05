/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  pmp_load_access_fault

  Description:
  Verifies PMP Load Access Fault.
  Configures PMP0 with W=1, X=1, but R=0.
  S-mode attempts to Load (Read), which should trap.
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
pmp_cfg:


mode_switch:


#   S-MODE EXECUTION
s_mode:


.align 4
#   TRAP HANDLER
trap_handler:


exit:
    nop
    nop
li x7, 0x80000004
csrw mtvec, x7
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
	inp_data:
	.word 0x12345678
    TEST_DATA
RVTEST_DATA_END


