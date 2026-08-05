// Testcase name: Alternating Taken/Not-Taken Branch Pattern
// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Alternating T/NT Pattern (10 + 10)
// Description: Executes exactly 10 taken and 10 non-taken alternating branches
//              to observe branch behavior in a predictable short sequence.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3  // global pointer for test pass/fail
start:
  li x1, 0         // loop counter
  li x2, 20        // loop limit (10 taken + 10 not-taken)
  li x3, 0         

alt_loop_10:
  andi x4, x1, 1         // check even or odd
  beq x4, x0, do_taken   // even: take branch

  // non-taken branch path
  addi x3, x3, 3         // odd path logic
  j alt_continue

do_taken:
  addi x3, x3, 7         // even path logic

alt_continue:
  addi x1, x1, 1
  blt x1, x2, alt_loop_10

  li t0, 100             // expected result: 10*7 + 10*3 = 100
  bne x3, t0, fail

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

