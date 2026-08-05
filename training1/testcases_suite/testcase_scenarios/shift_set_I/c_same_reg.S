// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori 
// Testcase name: Self-Comparison (rs1 = rs2)
// Description: Validate that comparing a register with itself returns 0 for slt and sltu
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: slt rs1 == rs2
test1:
  li x6, 10
  slt x7, x6, x6      // 10 < 10? should be 0
 

// Test2: sltu rs1 == rs2
test2:
  li x6, 10
  sltu x7, x6, x6     // 10 < 10 unsigned? should be 0
 

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

