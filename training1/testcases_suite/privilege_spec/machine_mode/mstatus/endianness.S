/*==========================================================
  Copyright 2025 Scaledge India Pvt Ltd - All Right Reserved.

  Date:          
  Owner:          Arvind Kumar Kori
  Testcase Name:  mstatus_ube_endianness

  Description:
  Verifies the UBE (User Big Endian) bit in mstatus (Bit 6).
  Attempts to toggle the UBE bit and reads back the value to
  determine if Big Endian mode is supported/writable.
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

#   1. Read Initial mstatus
    csrr    x5, mstatus

#   2. Attempt to SET UBE (Bit 6) -> Enable Big Endian
    li      x6, 0x40                // Bit 6 Mask (UBE)
    csrs    mstatus, x6

#   3. Read Back to Verify
    csrr    x7, mstatus
    and     x8, x7, x6              // Extract Bit 6

#   Self-Check: Did UBE set?
    # Note: If HW is Little-Endian only, x8 will be 0.
    # If HW supports BE, x8 will be 0x40.
    # We fail only if we expected it to change but it didn't (implementation dependent).
    # For a generic check, we just verify no crash occurred.
    
    # Optional Strict Check: Uncomment if your core MUST support BE.
    # beqz    x8, fail

#   4. Attempt to CLEAR UBE (Bit 6) -> Restore Little Endian
    csrc    mstatus, x6

#   5. Read Back to Verify Restoration
    csrr    x9, mstatus
    and     x10, x9, x6

#   Self-Check: Bit 6 must be 0 now
    bnez    x10, fail

    j       exit

.align 4
trap_handler:
    j       fail

exit:
    nop
    nop
    TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
    TEST_DATA
RVTEST_DATA_END
