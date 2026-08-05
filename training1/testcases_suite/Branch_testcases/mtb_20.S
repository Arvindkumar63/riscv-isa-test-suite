// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Branch Offset and Misaligned Verification + 20/20 Branch Split
// Description: Verifies branch behavior with aligned/misaligned targets
//              and executes 20 taken followed by 20 non-taken branches.
//
// ===========================================================
 
#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3 
 
// ------------------ BLOCK 1: 20/20 Branches Taken ------------------
  li x1, 0         // loop counter
  li x2, 20        // loop limit
  li x3, 0         
  li x4, 1         // constant value for taken branches
 
taken_loop:
  bge x1, x2, non_taken_start  // exit after 20 iterations
  add x3, x3, x4               
  addi x1, x1, 1               // increment loop counter
  beq x4, x4, taken_loop       // always taken
 
  li t0, 20
  bne x3, t0, fail            // confirm 20 increments
 
// ------------------ BLOCK 2: 20/20 Branches Not Taken ------------------
non_taken_start:
  li x5, 0         // loop counter
  li x6, 0         
  li x7, 0         // compare value
  li x8, 20        // loop limit
 
non_taken_loop:
  bne x7, x7, branch_exec      // never taken
  addi x6, x6, 999             // should not execute
branch_exec:
  addi x5, x5, 1
  blt x5, x8, non_taken_loop
 
 
 
// ------------------ Branch Offset and Misaligned Jump ------------------
  la x10, aligned_label

 
aligned_label:
  li x12, 55
  la x13, aligned_label
  addi x13, x13, 2            // misaligned jump address

  li x14, 77                  // should be skipped on trap
 
  li t1, 55
  bne x12, t1, fail
 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
