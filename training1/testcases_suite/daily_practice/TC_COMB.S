// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        24-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_BRANCH_MIXED_COMBO
// Description:  Mixed test of conditional (`beq`, `bne`, `blt`, `bge`) and 
//               unconditional (`jal`, `j`) branches with loops, link validation, 
//               skipped paths, and fail traps.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 5            # Indicate test number in gp

  #-------------------------------------------
  # Initial values
  li x6, 5            # Loop limit
  li x7, 0            # Loop counter
  li x8, 0            # Accumulator
  li x9, 100          # Dummy variable
  li x10, 0           # Temp
  li x11, 0           # Link result placeholder
  li x12, 0           # For conditional paths
  li x13, 999         # Trap flag
  li x14, 0           # For conditional branch check

  #-------------------------------------------
  # Unconditional jump with x0 - link must be ignored
  jal x0, skip_block1
  addi x13, x13, 1     # Should be skipped

skip_block1:
  # beq not taken (x6 != x7)
  beq x6, x7, trap     # Not equal → skip
  addi x12, x12, 1     # x12 = 1 (should execute)

  # bne taken (x6 ≠ x7)
  bne x6, x7, continue1

  j trap               # Should not happen

continue1:
  # Use blt for loop
  li x7, 0             # Reset loop counter
  li x8, 0             # Reset accumulator
loop_start:
  blt x7, x6, loop_body
  j loop_done

loop_body:
  add x8, x8, x7       # x8 += x7
  addi x7, x7, 1
  j loop_start

loop_done:
  # x8 should be 0+1+2+3+4 = 10
  li x10, 10
  bne x8, x10, trap     # Fail if loop did not sum properly

  # bge condition - true
  li x14, 5
  bge x14, x8, passed_bge   # 5 ≥ 10 → false → should skip
  addi x12, x12, 5          # Should not execute

  j skip_bge

passed_bge:
  addi x12, x12, 99         # Dummy increment if bge taken (won’t happen)

skip_bge:
  # Check jal with link
  jal x1, link_target       # Jump and store return address in x1
  addi x9, x9, 777          # Skipped

link_target:
  addi x11, x1, 0           # Save link in x11

  # Return to main flow using j
  j final_check

trap:
  li x31, 0xBAD
 

final_check:
  # Check x8 == 10 (loop result), x12 == 1 (from earlier), x11 has link
  li x15, 10
  li x16, 1

  bne x8, x15, trap
  bne x12, x16, trap
  beq x11, x0, trap        # Link must be non-zero

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

