///*==========================================================
//  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.
//
//  Date:           11-12-2025
//  Owner:          Arvind Kumar Kori
//  Testcase Name:  pmp_exec_access_fault
//
//  Description:
//  Verifies PMP Instruction Access Fault.
//  Configures PMP0 with R=1, W=1, but X=0.
//  S-mode attempts to Execute code, which should trap.
//==========================================================*/
//
//#include "test_macros.h"
//#include "riscv_test.h"
//
//RVTEST_RV64M
//RVTEST_CODE_BEGIN
//
//    li      gp, 4
//
//start:
//#   Set Trap Handler
//    la      x2, trap_handler
//    csrw    mtvec, x2
//pmp_cfg:
//#   1. Set Address Range (pmpaddr0)
//    csrr x8, pmpaddr0
//    li      x3, 0x80005000
//    slli    x3, x3, 2
//    csrw    pmpaddr0, x3
//
//#   2. Set Configuration (pmpcfg0)
//#   0x1B = 0001 1011 -> NAPOT(11), X(0), W(1), R(1)
//#   Execute Access is DENIED.
//    li      x4, 0x1B
//    csrw    pmpcfg0, x4
//mode_switch:
//#   MODE SWITCH (S-mode)
//    la      x6, s_mode
//    csrw    mepc, x6
//
//    li      x3, 0x1800
//    csrc    mstatus, x3
//    li      x3, 0x0800
//    csrs    mstatus, x3
//    mret
//
//#   S-MODE EXECUTION
//s_mode:
//
//#   Attempt to Execute -> MUST TRAP
//#   This address is covered by PMP where X=0.
//
//    addi    x1, x4, 1                // exception trap_instruction_access_fault
//
//    j       exit
//
//.align 4
//#   TRAP HANDLER
//trap_handler:
//    csrr    x12, mcause
//    
//#   Verify Cause: Instruction Access Fault (1)
//    li      x15, 1
//    bne     x12, x15, fail
//    csrr    x31, mtval 
//
//
//    csrr    x8, mepc
//    addi    x8, x8, 4               // Skip instruction
//    csrw    mepc, x8
//    mret
//
//exit:
//    nop
//    nop
//li x7, 0x80000004
//csrw mtvec, x7
//    TEST_PASSFAIL
//
//RVTEST_CODE_END
//
//.data
//RVTEST_DATA_BEGIN
//    TEST_DATA
//RVTEST_DATA_END












/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           11-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  pmp_specific_store_fault

  Description:
  Verifies PMP Store Access Fault on a specific address.
  Configures PMP0 for 'inp_data' using NA4 mode.
  Permissions: Read=1, Write=0 (ReadOnly).
  S-mode attempts to Store, which should trap.
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
#   Format: Physical Address >> 2
    la      x3, inp_data
    srli    x3, x3, 2
    csrw    pmpaddr0, x3

#   2. Set Configuration (pmpcfg0)
#   Mode: NA4 (Naturally Aligned 4-byte) -> A=2 (Bits 4:3 = 10)
#   Perms: R=1, W=0, X=0 -> 0x1
#   Total: (2 << 3) | 1 = 0x11
    li      x4, 0x11
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

#   Attempt to Store Data (Write) -> MUST TRAP
    la      x8, inp_data
    li      x9, 0x1234
    sw      x9, 0(x8)

#   If we are here, Trap did not occur -> FAIL

.align 4
#   TRAP HANDLER
trap_handler:
    csrr    x12, mcause
    
#   Verify Cause: Store/AMO Access Fault (7)
    li      x15, 7
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
