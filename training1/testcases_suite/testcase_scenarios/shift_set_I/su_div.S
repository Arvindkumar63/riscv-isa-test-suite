// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori 
// Testcase name: Signed vs Unsigned Division using div/divu and sra/srl
// Description: Compare results of div/divu with sra/srl for division by 4
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1: signed division and arithmetic shift right
test1:
  li x6, -40            // dividend = -40
  li x7, 4              // divisor = 4

  div x8, x6, x7        // signed division: -40 / 4 = -10
  srai x9, x6, 2        // arithmetic shift right by 2 (divide by 4 signed) = 2^2

li x7, -4
li x2, 40
div x1,x2,x7

                      #  Error: Improper shift amount 
# srai x5,x2,-2


  bne x8, x9, fail      // results should match

// Test2: unsigned division and logical shift right
test2:
  li x6, 0xFFFFFFFFFFFFFFD8  // unsigned representation of -40 in 64-bit
  li x7, 4                  // divisor = 4

  divu x8, x6, x7          // unsigned division: (2^64 - 40) / 4 
  srli x9, x6, 2           // logical shift right by 2 (divide by 4 unsigned) 2^2

li x7, -4
li x2, 40
divu x1,x2,x7

                       #  Error: Improper shift amount 
# srli x5,x2,-2


  bne x8, x9, fail         // results should match

test3:
        li x2, 32           # x2 = 32
    slli x3, x2, 5      # x3 = x2 << 5 
    slli x4, x2, 1      # x4 = x2 << 1
    srai x6, x2, 1      # x6 = x5 >> 1 
add x7,x3,x4
 add  x5, x6, x7     # x5 => (final result = 32 * 34.5=1104)


  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

