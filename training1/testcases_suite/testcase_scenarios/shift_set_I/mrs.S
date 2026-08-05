// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: Maximum Right Shift (shamt=31) using srl, srli, srlw, srliw, sra, srai
// Description: 1 test with branch and 5  tests without branch
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1 - srl (register shift) logical right shift on -1 by 31; result = 1
test1:
  li x6, -1
  li x9, 31
  srl x7, x6, x9
//  li t0, 1
 // bne x7, t0, fail

// Test2 - srli (immediate shift) logical right shift on -1 by 31; result = 1
test2:
  li x6, -1
  srli x7, x6, 31

// Test3 - srlw (word logical right shift) on -1 by 31; result = 1 (lower 32 bits only)
test3:
  li x6, -1
  li x9, 31
  srlw x7, x6, x9

// Test4 - srliw (word logical right shift immediate) on -1 by 31; result = 1
test4:
  li x6, -1
  srliw x7, x6, 31

// Test5 - sra (register shift) arithmetic right shift on -1 by 31; result = -1 (all ones)
test5:
  li x6, -1
  li x9, 31
  sra x7, x6, x9
li x3, 0x7abcd12380000000 // 31st bit =1 but 63rd bit 0
li x7,0xabcd1234abcdef12 // lower 32 bits only shifted other filled with 31st bit of x3
sraw x6,x3,x7  # x6 = 0xffffffffffffe000

li x1, 0x8abcd12370000000 // 31st bit =0 but 63rd bit 1
li x2,0xabcd1234abcdef12 // lower 32 bits only shifted other filled with 31st bit of x3
sraw x8,x1,x2  # x8= 0x0000000000001c00


// Test6 - srai (immediate shift) arithmetic right shift on -1 by 31; result = -1
test6:
  li x6, -1
  srai x7, x6, 31

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

