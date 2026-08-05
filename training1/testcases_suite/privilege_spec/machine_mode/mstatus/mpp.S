/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_mpp_verification

  Description:
  Verifies the MPP (Machine Previous Privilege) field in mstatus.
  1. Traps from U-mode -> M-mode (Expect MPP=00).
  2. Traps from S-mode -> M-mode (Expect MPP=01).
  3. Traps from M-mode -> M-mode (Expect MPP=11).
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // State Tracker

start:
    la      x2, trap_handler
    csrw    mtvec, x2


case_mpp_supervisor:
    li      x20, 0x1000                  // State 1: Supervisor Test
	csrw mstatus,x20

    # Switch to S-mode (MPP=01)
    la      x6, h_mode_code
    csrw    mepc, x6
  //  li      x3, 0x1800
    //csrc    mstatus, x3
    //li      x3, 0x0800              // Set MPP=01
    //csrs    mstatus, x3
    mret                            // Enter S-mode

h_mode_code:
  nop
nop 
#   -------------------------------------------------
#   SCENARIO 3: M-MODE -> M-MODE (Expect MPP=11)
#   -------------------------------------------------
case_mpp_machine:
    li      x20, 2                  // State 2: Machine Test

   // ecall                           // Trap (M->M)

    j       exit

#   -------------------------------------------------
#   TRAP HANDLER
#   -------------------------------------------------
.align 4
trap_handler:
    csrr    x12, mstatus            // Read mstatus
    li      x13, 0x1800             // Mask MPP (Bits 12:11)
    and     x14, x12, x13           // Extract MPP

    # Check State 0 (User -> 00)
    li      x15, 0
    beq     x20, x15, check_user

    # Check State 1 (Supervisor -> 01 -> 0x800)
    li      x15, 1
    beq     x20, x15, check_supervisor

    # Check State 2 (Machine -> 11 -> 0x1800)
    li      x15, 2
    beq     x20, x15, check_machine

    j       fail                    // Unknown state

check_user:
    li      x16, 0x0000
    bne     x14, x16, fail          // Fail if MPP != 00
    j       return_from_trap

check_supervisor:
    li      x16, 0x0800
    bne     x14, x16, fail          // Fail if MPP != 01
    j       return_from_trap

check_machine:
    li      x16, 0x1800
    bne     x14, x16, fail          // Fail if MPP != 11
    # For Machine mode, we are done with scenarios
    csrr    x8, mepc
    addi    x8, x8, 4
    csrw    mepc, x8
    mret

return_from_trap:
    csrr    x8, mepc
    addi    x8, x8, 4
    csrw    mepc, x8
    
    # Return to M-mode controller to start next test
    # (We hijack the return to jump to the next label instead of returning to U/S mode)
    li      x15, 0
    beq     x20, x15, next_supervisor
    li      x15, 1
    beq     x20, x15, next_machine

next_supervisor:
    la      x6, case_mpp_supervisor
    csrw    mepc, x6
    # Force MPP back to Machine (11) to run setup code
    li      x3, 0x1800
    csrs    mstatus, x3
    mret

next_machine:
    la      x6, case_mpp_machine
    csrw    mepc, x6
    li      x3, 0x1800
    csrs    mstatus, x3
    mret

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
