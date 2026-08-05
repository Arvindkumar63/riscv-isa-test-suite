// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Comparison with Zero
// Description: Test various compare instructions against zero
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: slt x7, x6, 0 (signed less than zero)
test1:
  li x6, -1
  li x0, 0
  slt x7, x6, x0       // -1 < 0 -> 1 expected
  

// Test2: slti x7, x6, 0 (immediate zero)
test2:
  li x6, 1
  slti x7, x6, 0       // 1 < 0 -> 0 expected
  

// Test3: sltz (set less than zero, rs1 < 0)
test3:
  li x6, -5
  sltz x7, x6          // -5 < 0 -> 1 expected
 

// Test4: sgtz (set greater than zero, rs1 > 0)
test4:
  li x6, 5
  sgtz x7, x6          // 5 > 0 -> 1 expected
  

// Test5: seqz (set equal zero, rs1 == 0)
test5:
  li x6, 0
  seqz x7, x6          // 0 == 0 -> 1 expected

test6:
li x2, 10
srli x3,x2,1# x3= 0x0000000000000005
srli x3,x2, 2


srai x4,x2,1 # x4= 0x0000000000000005
srai x4,x2,2


   #Error  unrecognized opcode 
# slai x5,x2,1


slli x6,x2,1 //10* (2^1)=>  x6=0x0000000000000014
 slli x4,x2,2







  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

