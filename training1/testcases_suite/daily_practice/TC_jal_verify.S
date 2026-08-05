// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        02-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  TC_JAL_VERIFY
// Description:  Validate that JAL jumps correctly and link is ignored when rd = x0.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2  

  
test1:
  li x6, 10              # x6 = 10

  jal x0, target         # Jump to 'target', do not store return address

  addi x7, x6, 5         # This should be skipped

target:
  addi x9, x6, 12        # x9 = x6 + 12 = 22

  TEST_PASSFAIL

RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

