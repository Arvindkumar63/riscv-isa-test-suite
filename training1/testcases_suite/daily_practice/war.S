// ===========================================================
//
// Copyright  2025 Scaledge India Pvt Ltd - All Right Reserved.
//
// Date:        08-07-2025
// Owner:       Arvind Kumar Kori
// Testcase name:  WAR
// Description:  Verify that WAR hazards occur when the read happens before the write,
//               in a 5-stage out-of-order pipeline.
//
// ===========================================================

#include "test_macros.h"
#include "riscv_test.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  li gp, 2  

test1:
  li       x6, 20           # x6 = 20
  li       x4, 10           # x4 = 10

  add      x9, x6, x7       # Read x7 before it is written (WAR hazard)
  addi     x7, x4, 50       # x7 = 60 (written after x7 is read above)

  TEST_PASSFAIL

RVTEST_CODE_END

RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END

