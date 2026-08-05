/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:           16-12-2025
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_vs_comprehensive

  Description:
  Verifies all states of the Vector Extension Status (VS) 
  field in mstatus (Bits 10:9):
  1. VS_Off (00): Access triggers Illegal Instruction trap.
  2. VS_Initial (01): Access allowed without trap.
  3. VS_Dirty (11): Executing vector instr transitions 
     state from Initial to Dirty.
  4. VS_Clean (10): Manually setting state to Clean.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize Trap Flag

start:
    la      x2, trap_handler
    csrw    mtvec, x2

# -----------------------------------------------------------
# SCENARIO 1: VS OFF (00) -> EXPECT TRAP
# -----------------------------------------------------------
case_vs_off:
    # Set VS to 00
    li      x3, 0x600               // Mask Bits 10:9
    csrc    mstatus, x3             // Clear VS

    # Self-Check: Verify VS is 00
    csrr    x4, mstatus
    and     x5, x4, x3
    bnez    x5, fail

    # Attempt Access (Should Trap)
    csrr    x6, vlenb

    # Check: Did trap occur?
    li      x1, 1
    bne     x20, x1, fail           // Fail if no trap

    # Reset Flag for next test
    li      x20, 0

# -----------------------------------------------------------
# SCENARIO 2: VS INITIAL (01) -> ACCESS ALLOWED
# -----------------------------------------------------------
case_vs_initial:
    # Set VS to 01
    li      x3, 0x600               // Clear mask
    csrc    mstatus, x3
    li      x4, 0x200               // Bit 9 (Initial)
    csrs    mstatus, x4

    # Self-Check: Verify VS is 01
    csrr    x5, mstatus
    li      x6, 0x600
    and     x7, x5, x6
    li      x8, 0x200
    bne     x7, x8, fail

    # Attempt Access (Should NOT Trap)
    csrr    x9, vlenb

# -----------------------------------------------------------
# SCENARIO 3: VS DIRTY TRANSITION (01 -> 11)
# -----------------------------------------------------------
case_vs_dirty:
    # Ensure VS is Initial (01)
    # (Already set from previous case, but enforcing safety)
    li      x3, 0x600
    csrc    mstatus, x3
    li      x4, 0x200
    csrs    mstatus, x4

    # Execute Vector Instruction (Modify State)
    # vsetvli x0, x0, e32, m1 -> 0x00007057
    .word 0x00007057

    # Check VS Status: Should be 11 (Dirty -> 0x600)
    csrr    x5, mstatus
    li      x6, 0x600               // Mask 11
    and     x7, x5, x6
    
    # Verification
    bne     x7, x6, fail

# -----------------------------------------------------------
# SCENARIO 4: VS CLEAN MANUAL SET (10)
# -----------------------------------------------------------
case_vs_clean:
    # Set VS to 10 (Clean)
    li      x3, 0x600
    csrc    mstatus, x3
    li      x4, 0x400               // Bit 10 (Clean)
    csrs    mstatus, x4

    # Verify VS Status
    csrr    x5, mstatus
    li      x6, 0x600
    and     x7, x5, x6
    
    # Verification: Must be 10 (0x400)
    bne     x7, x4, fail

    j       exit

# -----------------------------------------------------------
# TRAP HANDLER
# -----------------------------------------------------------
.align 4
trap_handler:
    csrr    x12, mcause
    
    # Verify Illegal Instruction (2)
    li      x13, 2
    bne     x12, x13, fail

    # Set Success Flag
    li      x20, 1

    csrr    x8, mepc
    addi    x8, x8, 4               // Skip instruction
    csrw    mepc, x8
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

