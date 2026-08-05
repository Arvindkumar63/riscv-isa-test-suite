/*===========================================================
Testcase name: tc_del_Store_access_fault
Description:
  Verify that storing to an invalid address traps to S-mode if MEDELEG is set.
===========================================================*/

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
    li      x7, 0xFFFFFFF0               # Invalid address
    sw      x8, 0(x7)                    # Store access fault → trap
    j       fail

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
    li      x21, 7                        # Store access fault = 7
    beq     x20, x21, pass
    j       fail

TEST_PASSFAIL
RVTEST_CODE_END

