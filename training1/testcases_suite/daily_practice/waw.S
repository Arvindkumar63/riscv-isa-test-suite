// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        08-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  WAW
// Description:  Verify that WAW hazards occur when two instructions write to the same register,
//               in a 5-stage out-of-order pipeline.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2  

test1:
  li     x6, 20             # x6 = 20
  li     x4, 10             # x4 = 10

  addi   x9, x6, 10         # First write to x9 (x9 = 30)
  addi   x9, x4, 50         # Second write to x9 (x9 = 60)

  # WAW hazard: Both instructions write to x9.
  # In out-of-order pipelines, second write must not occur before the first is committed.

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

