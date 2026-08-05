// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Shift Instructions with Destination Equal to Source (rd = rs1)
// Description: Test shifts where destination and source are same register (rd=rs1)
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1 - Complex: multiple shifts on same register (rd=rs1)
test1:
  li x6, 1
  slli x6, x6, 4        // x6 = 1 << 4 = 16
  sll x6, x6, x0        // x6 = 16 << 0 = 16 (no change)
  sra x6, x6, x0        // x6 = 16 >> 0 = 16 (no change)
  srli x6, x6, 2        // x6 = 16 >> 2 = 4
  srai x6, x6, 1        // arithmetic right shift by 1, 4 >> 1 = 2
  srli x6, x6, 1        // logical right shift by 1, 2 >> 1 = 1

#  li t0, 1
 # bne x6, t0, fail

// Test2 - sll where rd=rs1
test2:
  li x7, 3
li x4 , 4  
  sll x7, x7,x4        // shift by   4 
// Test3 - Simple: srai where rd=rs1
test3::ta
  li x8, -8
  srai x8, x8, 2        // arithmetic right shift by 2
             // -8 >> 2 = -2 (arithmetic)
 // Test4 - Simple: srli where rd=rs1
test4:
  li x9, -1
  srli x9, x9, 31       // logical right shift by 31 (fills with zero)
  li t3, 1
#   beq x9, t3, pass4


  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

