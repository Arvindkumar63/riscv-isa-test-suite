/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Rights Reserved.
Date: 01/12/2025
Owner: Arvind Kumar Kori

Testcase name: tc_del_Store_address_misaligned
Description:
  Verify that a store to a misaligned address traps to S-mode if MEDELEG is set.
===========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

start:
    li      gp, 3

trap_handler_address:
    la      x4, trap_handler
    csrw    mtvec, x4

label1:
    li      x8, -1
    csrw    medeleg, x8

label3:
    li      x11, 0x800
    csrrs   x7, mstatus, x11
    la      x2, s_mode_entry
    csrw    mepc, x2
    mret

label4:
    la      x16, s_trap_handler
    csrw    stvec, x16
    sret

s_mode_entry:
    la      x7, inp_data
    sw      x8, 2(x7)                  # Misaligned store → should trap
    j       fail                        # Should not reach here

trap_handler:
    csrr    x23, mepc
    addi    x23, x23, 4
    csrw    mepc, x23
    j       fail

s_trap_handler:
    csrr    x12, sepc
    addi    x12, x12, 4
    csrw    sepc, x12
    csrr    x20, scause
    csrr    x10, stval
    li      x21, 6                     # Store address misaligned = 6
    beq     x20, x21, pass
    j       fail

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
inp_data:
    .word 0x11111111
    .word 0x22222222
    TEST_DATA
RVTEST_DATA_END

