// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Comparison with -1
// Description: Test compare instructions involving immediate -1 and registers set to -1
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: slti with immediate -1
test1:
  li x6, 0
  slti x7, x6, -1    // 0 < -1? should be 0
    
// Test2: slt with register -1
test2:
  li x6, -1
  li x5, 0
  slt x7, x6, x5     // -1 < 0? should be 1
  
// Test3: sltu with register -1 (unsigned compare)
test3:
  li x6, -1          // 0xFFFFFFFFFFFFFFFF in 64-bit
  li x5, 1
  sltu x7, x6, x5    // large unsigned < 1? should be 0
 
// Test4: snez (set not equal zero) with -1
test4:
  li x6, -1
  snez x7, x6        // -1 != 0? should be 1
 
// Test5: seqz (set equal zero) with -1
test5:
  li x6, -1
  seqz x7, x6        // -1 == 0? should be 0
  
  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

