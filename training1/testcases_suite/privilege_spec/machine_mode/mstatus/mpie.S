/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:          
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_mpie_verification

  Description:
  Verifies the MPIE (Machine Previous Interrupt Enable) bit.
  1. Sets MIE=1.
  2. Triggers a trap (ecall).
  3. Verifies inside handler that MPIE=1 (captured old MIE)
     and MIE=0 (disabled).
  4. Returns (mret) and verifies MIE is restored to 1.
==========================================================*/

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

    li      gp, 4
    li      x20, 0                  // Initialize Trap Flag

start:
#   Set Trap Handler
    la      x2, trap_handler
    csrw    mtvec, x2

#   -------------------------------------------------
#   1. ENABLE MIE (Bit 3)
#   -------------------------------------------------
    li      x3, 0x8                 // Bit 3 (MIE)
    csrs    mstatus, x3

#   Self-Check: Verify MIE is 1
    csrr    x4, mstatus
    and     x5, x4, x3
    beqz    x5, fail                // Fail if MIE not set

#   -------------------------------------------------
#   2. TRIGGER TRAP (ECALL)
#   This forces hardware to copy MIE -> MPIE and clear MIE.
#   -------------------------------------------------
    ecall

#   -------------------------------------------------
#   4. VERIFY RESTORATION (After mret)
#   -------------------------------------------------
#   MIE should be restored to 1 (from MPIE).
    csrr    x6, mstatus
    and     x7, x6, x3              // Extract MIE (Bit 3)
    
#   Check: MIE must be 1
    beqz    x7, fail

#   Check: Did we actually visit the handler?
    li      x1, 1
    bne     x20, x1, fail

    j       exit

.align 4
#   -------------------------------------------------
#   TRAP HANDLER
#   -------------------------------------------------
trap_handler:
    li      x20, 1                  // Set Success Flag

    csrr    x12, mstatus            // Read mstatus inside trap

#   3. VERIFY MPIE and MIE STATUS
#   Expectation: MPIE (Bit 7) = 1, MIE (Bit 3) = 0

#   Check MPIE (Bit 7) -> Should be 1 (Old MIE)
    li      x13, 0x80               // Bit 7 Mask
    and     x14, x12, x13
    beqz    x14, fail               // Fail if MPIE is 0

#   Check MIE (Bit 3) -> Should be 0 (Disabled by HW)
    li      x15, 0x8                // Bit 3 Mask
    and     x16, x12, x15
    bnez    x16, fail               // Fail if MIE is 1

#   Return (Restores MIE from MPIE)
    csrr    x8, mepc
    addi    x8, x8, 4               // Skip ecall
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

