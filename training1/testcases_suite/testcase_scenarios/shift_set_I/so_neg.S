// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Shift Operations on Negative Values (all shift types)
// Description: testcases using sll, sra, srl, slli, srai, srli on negative values and we uses negative shamt but not giving me error  
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1 - Complex: combine sll, sra, srl, slli, srai, srli on -16 (0xFFFFFFFFFFFFFFF0)
test1:
  li x6, -16              // 0xFFFFFFFFFFFFFFF0
  sll x7, x6, x0          // shift by 0 => x7 = -16
  sra x8, x6, x0          // shift by 0 => x8 = -16
  srl x9, x6, x0          // shift by 0 => x9 = -16 (logical shift by 0)
  slli x10, x6, 1         // left shift by 1 => -32 (0xFFFFFFE0)
  srai x11, x6, 2         // arithmetic right shift by 2 => -4 (0xFFFFFFFFFFFFFFFC)
  srli x12, x6, 3         // logical right shift by 3 => 0x1FFFFFFFFFFFFFFF
  or x13, x7, x8          // combine sll and sra results
  or x14, x9, x10         // combine srl and slli results
  or x15, x11, x12        // combine srai and srli results
  or x16, x13, x14
  or x17, x16, x15        // combine all results
  li t0, -1               // expect combined OR to be -1 (all bits set)
 # bne x17, t0, fail

// Test2 - Simple: slli and srli on -8, check pattern
test2:
  li x6, -8
  slli x7, x6, 2           // shift left by 2 => -32
  srli x8, x6, 3           // logical right shift by 3



                    # Error: Improper shift amount 
li x2,  5
# srli x3, x2,-6

li x5,-6
srl x3,x2,x5


// Test3 - Simple: sra and srl on -4, check arithmetic vs logical shift
test3:
  li x6, -4
  sra x7, x6, 1            // arithmetic right shift by 1 => -2
  srl x8, x6, 1            // logical right shift by 1

// Test4 - Simple: sll and srai on -2, check shift left and arithmetic right
test4:
  li x6, -2
  sll x7, x6, 1            // shift left by 1 => -4
  srai x8, x6, 1           // arithmetic right shift by 1 => -1

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

