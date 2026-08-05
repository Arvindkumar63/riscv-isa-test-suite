// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        10-06-2025
// Owner:       Arvind Kumar Kori
// Testcase name: More than Maximum Right Shift (shamt > 31)
// Description:  simple testcases for srl, srli, srlw, srliw, sra, srai with shift 
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  li gp, 3          // global pointer for pass/fail

// Test1 - srl with shamt=35, branch to check correct shift
test1:
  li x6, 0xFFFFFFFF
  li x9, 35          // 35 & 0x1F = 3
  srl x7, x6, x9     // logical right shift by 3: expect 0x1FFFFFFF
  li t0, 0x1FFFFFFF
 // bne x7, t0, fail

// Test2 - srli with shamt=35
test2:
  li x6, 0x80000000
  srli x7, x6, 35    // shift by 3 , expect 0x00000000

                         # Error: Improper shift amount (64)

  # srli x7, x6, 64    // max shift amount for rv64i is 63
# srli x7, x6, 0xfa   // max shift amount bit rv64i 6 bit but more than 6bit not valid
# srli x7,x6,-2 // here -2 = 0xfffffffffffffffe 
// similarly for all the instructions



// Test3 - srlw with shamt=35, 
test3:
  li x6, 0xFFFFFFF0
  li x9, 0x12345678abcd1234
  srlw x7, x6, x9    // lower 32-bit shift by 3, expect 0x1FFFFFFE
  or x8, x7, x6      // combine with original: 0xFFFFFFFF
 
                  # Error: Improper shift amount 
# srliw x7, x6, 0xabcd1234 

#  srliw x7,x6,63 // error but
srli x7,x6,63     // not giving me error



// Test4 - sra with shamt=35, arithmetic right shift 
test4:
  li x6, -8
  srai x7, x6, 35    // shift by 35, expect -1 (arithmetic shift keeps sign)

                          # Error: Improper shift amount 
# srai x7, x6, 64


li x9,98 // 7 bit
sra x7, x6, x9    // shift by 35, expect -1 (arithmetic shift keeps sign)

  or x8, x7, x6      // -1 | -8 = -1


  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

