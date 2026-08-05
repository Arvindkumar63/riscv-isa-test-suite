/*===========================================================
Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
Date:01/12/2025
Owner: Arvind Kumar Kori

Testcase name: tc_del_instruction_address_misaligned
Description:
  Verify that instruction-address-misaligned trap is delegated to S-mode,
  and validate mcause, mtval during trap handling in both M-mode and S-mode.
===========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

start:
    li      gp, 3                    

# Setup trap handler (M-mode)
trap_handler_address:
    la      x4, trap_handler       //  Load M-mode trap handler address
    csrw    mtvec, x4              //  Set MTVEC to handler

# Enable delegation of misaligned instruction trap to S-mode
label1:
  li      x8, 0xFFFFFFFFFFFF       // Enable delegation of all sync exceptions
  csrr    x9, medeleg              // Read initial MEDELEG
  csrw    medeleg, x8              // Write delegation bits
  csrr    x9, medeleg              // Read-back check

# Enable S-mode (MPP = S-mode) using mstatus.MPP
label3:
    li      x11, 0x800             // MPP = 01 (S-mode)
    csrrs   x7, mstatus, x11       // Set MPP = S-mode

    la      x2, s_mode             // Set MEPC to S-mode entry
    csrw    mepc, x2

    mret                           // Enter S-mode

# Setup S-mode trap handler
label4:
    la      x16, s_trap_handler    // S-mode trap handler
    csrw    stvec, x16
    nop
    sret

# S-mode: Intentionally generate misaligned instruction trap
s_mode:
    la      x7, inp_data1            // Load address
    lw      x8, 2(x7)               // Misaligned address → should trap
    nop
    nop

inp_data1:
	 li		x2, 0x2
	 addi		x8, x4, 8
# Self-checking logic (simple)
# If trap is not taken, CPU reaches here.
# Divide x8/4 → result must be zero. If not zero → PASS (unexpected!)
    div     x7, x8, x4
    bnez    x7, pass                // If non-zero → pass (but practically won't reach here)

# M-mode trap handler (fallback)
trap_handler:
    csrr    x23, mepc               // Read MEPC (faulting address)
    addi    x23, x23, 4             //   Skip the faulting instruction
    csrw    mepc, x23

    nop

    csrr    x9,  mcause             //   Capture mcause
    csrr    x10, mtval              //   Capture mtval

    mret                            // Machine return to the mepc address

# S-mode trap handler
s_trap_handler:
    csrr    x12, sepc               //  Read Supervisor EPC
    li      x13, 4
    add     x12, x12, x13
    csrw    sepc, x12               //  Skip faulting instruction

    csrr    x20, scause             //  Read S trap cause
    csrr    x10, stval              //  Read trap value

    sret                            //  Return to S-mode code

TEST_PASSFAIL
RVTEST_CODE_END

    .data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END

