// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Self-Modifying Counter with Overflow Detection
// Description: Uses conditional branches and pseudo-branches to increment a counter,
//              simulating overflow detection by wrapping at max value (0xFFFFFFFF).
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3  // global pointer for test pass/fail

  li x1, 0xFFFFFFFE   // near max unsigned 32-bit value
  li x2, 2            // increment 2 times to cause wrap
  li x3, 0            // loop counter
  li x4, 0            // overflow flag (set to 1 on overflow)

counter_loop:
  addi x1, x1, 1           // increment counter
  addi x3, x3, 1           // loop counter++

  // simulate unsigned overflow detection: if x1 == 0 after wrap
  beq x1, x0, overflow_detected

  blt x3, x2, counter_loop
  j counter_done

overflow_detected:
  li x4, 1                 // overflow occurred

counter_done:
  li t0, 1
  bne x4, t0, fail         // expect overflow flag = 1

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

