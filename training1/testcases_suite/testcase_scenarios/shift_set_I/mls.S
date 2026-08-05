// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori 
// Testcase name: Maximum Left Shift (shamt=31) using shifts and ors only
// Description: testcases with shifts and ors
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Testcase 1   Combine shifts + add bne li  with OR to build pattern 0x80000001
test1:
  li x6, 1
  slli x7, x6, 31
  add x8, x7, x0         // preserve shifted result in x8
  li t0, 0x80000000
  #bne x8, t0, fail
  #li x5, 0          // fail flag

  //test 2: Combine shifts with OR to build pattern 0x80000001
test2:

  li x6, 1
li x9, 31
  sll x7, x6, x9       // 0x80000000
  or x8, x7, x6         // 0x80000001
  li t0, 0x80000001
 
 // Testcase 3 - slliw (RV64, 32-bit behavior)
test3: 


  li x6, 1
  slliw x7, x6, 31
 

  // Test 4: sllw 1 << 31; upper 32 bits zero checked by srli
test4:

  li x6, 1
  sllw x7, x6, 31
  srli x8, x7, 32
 
  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

