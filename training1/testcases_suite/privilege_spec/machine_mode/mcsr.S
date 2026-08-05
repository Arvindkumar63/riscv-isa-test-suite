// ===========================================================
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        04-09-2025
// Owner:       Arvind 
// Testcase Name: MISA CSR Read/Write Validation
// Description: This test validates reading and writing behavior of the `misa` CSR.
//              Two test cases are included:
//
//    1) Writing all zeroes to misa (expectation: misa should either stay the same
//       or return zero if misa write is not allowed).
//    2) Writing all ones (0xFFFF) to misa to see if WARL behavior applies
//       and misa masks out illegal or reserved bits.

#include "test_macros.h"
#include "riscv_test.h"
 
RVTEST_RV64M
RVTEST_CODE_BEGIN
 
  li gp, 3
  li x1, 20
 li x6, 0x0000
 li x8, 0xffff

  level1:

//reading DEFAULT value from misa
  csrr x7,misa //x7=0x800000000014112d

//write in the misa
csrw misa, x6
//after writing  i=78=0x0000 i am reading value from misa
csrr x10,misa

level2:
//reading DEFAULT value from misa
  csrr x7,misa //x7=0x800000000014112d
csrw misa, x8
//after writing ix8=0xffff i am reading value from misa
csrr x10,misa

 
  TEST_PASSFAIL
 
RVTEST_CODE_END
 
  .data
 
RVTEST_DATA_BEGIN
  TEST_DATA
 
 
RVTEST_DATA_END
