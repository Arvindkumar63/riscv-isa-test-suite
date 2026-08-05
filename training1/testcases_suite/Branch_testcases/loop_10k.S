// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Loop with Multiple Branches (10,000 iterations)
// Description: Simulates a long-running loop using only conditional
//              branches and pseudo-branches to verify stability.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN
  li x1, 10000       # Loop counter
  li x2, 0           
  li x3, 1           # Constant for addition
  li x4, 5000        # Midpoint comparison

loop_start:
  beq x1, x0, loop_end      # Exit loop if x1 == 0

  blt x1, x4, less_than_mid # If x1 < 5000 → skip increment
  add x2, x2, x3            # Increment 

less_than_mid:
  addi x1, x1, -1           # Decrement counter
  bne x1, x0, loop_start    # Loop again if x1 ≠ 0

loop_end:
  nop                       # End of program

  
  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

