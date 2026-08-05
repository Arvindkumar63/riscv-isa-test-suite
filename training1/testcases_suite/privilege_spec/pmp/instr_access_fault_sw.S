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
#   1. Set Address Range (pmpaddr0)
    csrr x8, pmpaddr0
    li      x3, 0x80005000
    slli    x3, x3, 2
    csrw    pmpaddr0, x3

#   2. Set Configuration (pmpcfg0)
#   0x1B = 0001 1011 -> NAPOT(11), X(0), W(1), R(1)
#   Execute Access is DENIED.
    li      x4, 0x1E
    csrw    pmpcfg0, x4
mode_switch:
#   MODE SWITCH (S-mode)
    la      x6, s_mode
    csrw    mepc, x6

    li      x3, 0x1800
    csrc    mstatus, x3
    li      x3, 0x0800
    csrs    mstatus, x3
    mret

#   S-MODE EXECUTION
s_mode:
#   Attempt to Load Data (Read) -> MUST TRAP
    la      x8, inp_data
    lw      x9, 0(x8)

    j       exit
.align 4
#   TRAP HANDLER
trap_handler:
    csrr    x12, mcause
    
#   Verify Cause: Instruction Access Fault (1)
    li      x15, 1
    bne     x12, x15, fail
    csrr    x31, mtval 


    csrr    x8, mepc
    addi    x8, x8, 4               // Skip instruction
    csrw    mepc, x8
    mret

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

