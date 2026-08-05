// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori 
// Testcase name: Compare Register with Negative Immediate
// Description: Test slti and sltiu instructions comparing register with negative immediates
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: slti with negative immediate
test1:
  li x6, 5            // x6 = 5
  slti x7, x6, -3     // x7 = (5 < -3) ? 1 : 0 -> 0 expected
  li t0, 0
  bne x7, t0, fail

// Test2: sltiu with negative immediate (imm treated as unsigned large number)
test2:
  li x6, 5
  sltiu x7, x6, -1    // imm=-1 (0xFFFF_FFFF_FFFF_FFFF) unsigned max, so 5 < max -> 1 expected
  li t0, 1
  bne x7, t0, fail

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

