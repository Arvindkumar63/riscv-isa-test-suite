// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        16-06-2025
// Owner:       Arvind & Nikhil
// Testcase name: Register Equalization via Operation and Branch
// Description: Compares two registers, applies math operations to make them equal,
//              and verifies equality using conditional branches.
//              Uses a mix of base and pseudoinstructions.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3  

start:

li x2, 2           # Start value reg A
  li x3, 64          # Start value reg B

loop:
  sll x4, x2, x1     # x4 = x2 << 1
  sra x5, x3, x1     # x5 = x3 >> 1 (arith)

  beq x4, x5, done   # If equal, exit loop

  addi x2, x2, 1     # Increment x2
  addi x3, x3, -1    # Decrement x3

  bne x4, x5, loop   # Repeat if not equal

done:
nop # loop ended

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

