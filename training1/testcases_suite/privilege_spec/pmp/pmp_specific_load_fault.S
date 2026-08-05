/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  pmp_specific_load_fault

  Description:
  Verifies PMP Load Access Fault on a specific address.
  Configures PMP0 for 'inp_data' using NA4 mode.
  Permissions: Read=0, Write=1 (WriteOnly).
  S-mode attempts to Load, which should trap.
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
#   Calculate PMP address for 'inp_data'
    la      x3, inp_data
    srli    x3, x3, 2
    csrw    pmpaddr0, x3

#   2. Set Configuration (pmpcfg0)
#   Mode: NA4 (Naturally Aligned 4-byte) -> A=2 (Bits 4:3 = 10)
#   Perms: R=0, W=1, X=0 -> 0x2
#   Total: (2 << 3) | 2 = 0x12
    li      x4, 0x12
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

#   If we are here, Trap did not occur -> FAIL
    j       fail

.align 4
#   TRAP HANDLER
trap_handler:
    csrr    x12, mcause
    
#   Verify Cause: Load Access Fault (5)
    li      x15, 5
    bne     x12, x15, fail
    csrr    x31, mtval

    csrr    x8, mepc
    addi    x8, x8, 4               // Skip instruction
    csrw    mepc, x8
    mret

exit:
    nop
    nop
    li      x7, 0x80000004
    csrw    mtvec, x7
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
#   Align to 4 bytes for NA4 PMP mode accuracy
    .align 2
inp_data:
    .word 0xDEADBEEF
RVTEST_DATA_END
