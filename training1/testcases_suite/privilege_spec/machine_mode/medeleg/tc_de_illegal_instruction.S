/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date: 01/12/2025
Owner: Arvind Kumar Kori

Testcase name: tc_del_Illegal_instruction
Description:
  Verify that illegal-instruction exception is delegated to S-mode.
  Generate illegal instruction in S-mode and validate sepc, scause, stval.
===========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

start:
    li      gp, 3                     # Test ID

# Setup trap handler in M-mode
trap_handler_address:
    la      x4, trap_handler          # Load M-mode trap handler
    csrw    mtvec, x4                 # Set MTVEC

# Delegate all synchronous exceptions to S-mode
label1:
    li      x8, 0xFFFFFFFFFFFF        # Enable all delegation bits
    csrw    medeleg, x8               # Write to MEDELEG
    csrr    x9, medeleg               # Read back for confirmation

# Change MPP to S-mode and enter S-mode
label3:
    li      x11, 0x800                # MPP = 01 (S-mode)
    csrrs   x7, mstatus, x11
    la      x2, s_mode                # S-mode start address
    csrw    mepc, x2
    mret                              # Enter S-mode

# Setup STVEC for S-mode trap handler
label4:
    la      x16, s_trap_handler
    csrw    stvec, x16
    sret

# ==========================
# S-mode: Generate illegal instruction
# ==========================
s_mode:
    li      x6, 0x9                   # Dummy value

    # Illegal instruction (mvendorid is read-only CSR → writing MUST trap)
    csrw    mvendorid, x6             # Should trap here

    # Should not reach here. If reached → FAIL.
    j       fail

# Unused input data block
inp_data1:
    li      x2, 0x2
    addi    x8, x4, 8

    # Self-check (never reaches normally)
    div     x7, x8, x4
    bnez    x7, pass                  # Should never enter here

# ==========================
# Machine trap handler (unexpected if delegation works)
# ==========================
trap_handler:
    csrr    x23, mepc                 # Read PC of faulting inst
    addi    x23, x23, 4
    csrw    mepc, x23

    csrr    x9,  mcause               # Read cause
    csrr    x10, mtval                # Read trap value

    j       fail                      # Delegation failed → M-mode caught trap

# ==========================
# S-mode trap handler (expected)
# ==========================
s_trap_handler:
    csrr    x12, sepc                 # Faulting PC
    addi    x12, x12, 4               # Skip trapped instruction
    csrw    sepc, x12

    csrr    x20, scause               # Trap cause
    csrr    x10, stval                # Illegal instruction encoding

    li      x21, 2                    # Illegal instruction exception code = 2
    beq     x20, x21, pass            # PASS if correct trap

    j       fail                      # Otherwise FAIL

TEST_PASSFAIL
RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

